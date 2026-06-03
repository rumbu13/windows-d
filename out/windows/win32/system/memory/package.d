// Written in the D programming language.

module windows.win32.system.memory;

public import windows.core;
public import windows.win32.foundation : BOOL, BOOLEAN, FARPROC, HANDLE, HGLOBAL,
                                         HLOCAL, PSTR, PWSTR;
public import windows.win32.security : SECURITY_ATTRIBUTES;

extern(Windows) @nogc nothrow:


// Enums


alias SECTION_FLAGS = uint;
enum : uint
{
    SECTION_ALL_ACCESS           = 0x000f001fU,
    SECTION_QUERY                = 0x00000001U,
    SECTION_MAP_WRITE            = 0x00000002U,
    SECTION_MAP_READ             = 0x00000004U,
    SECTION_MAP_EXECUTE          = 0x00000008U,
    SECTION_EXTEND_SIZE          = 0x00000010U,
    SECTION_MAP_EXECUTE_EXPLICIT = 0x00000020U,
}

alias FILE_MAP = uint;
enum : uint
{
    FILE_MAP_WRITE           = 0x00000002U,
    FILE_MAP_READ            = 0x00000004U,
    FILE_MAP_ALL_ACCESS      = 0x000f001fU,
    FILE_MAP_EXECUTE         = 0x00000020U,
    FILE_MAP_COPY            = 0x00000001U,
    FILE_MAP_RESERVE         = 0x80000000U,
    FILE_MAP_TARGETS_INVALID = 0x40000000U,
    FILE_MAP_LARGE_PAGES     = 0x20000000U,
}

alias HEAP_FLAGS = uint;
enum : uint
{
    HEAP_NONE                     = 0x00000000U,
    HEAP_NO_SERIALIZE             = 0x00000001U,
    HEAP_GROWABLE                 = 0x00000002U,
    HEAP_GENERATE_EXCEPTIONS      = 0x00000004U,
    HEAP_ZERO_MEMORY              = 0x00000008U,
    HEAP_REALLOC_IN_PLACE_ONLY    = 0x00000010U,
    HEAP_TAIL_CHECKING_ENABLED    = 0x00000020U,
    HEAP_FREE_CHECKING_ENABLED    = 0x00000040U,
    HEAP_DISABLE_COALESCE_ON_FREE = 0x00000080U,
    HEAP_CREATE_ALIGN_16          = 0x00010000U,
    HEAP_CREATE_ENABLE_TRACING    = 0x00020000U,
    HEAP_CREATE_ENABLE_EXECUTE    = 0x00040000U,
    HEAP_MAXIMUM_TAG              = 0x00000fffU,
    HEAP_PSEUDO_TAG_FLAG          = 0x00008000U,
    HEAP_TAG_SHIFT                = 0x00000012U,
    HEAP_CREATE_SEGMENT_HEAP      = 0x00000100U,
    HEAP_CREATE_HARDENED          = 0x00000200U,
}

alias PAGE_PROTECTION_FLAGS = uint;
enum : uint
{
    PAGE_NOACCESS                   = 0x00000001U,
    PAGE_READONLY                   = 0x00000002U,
    PAGE_READWRITE                  = 0x00000004U,
    PAGE_WRITECOPY                  = 0x00000008U,
    PAGE_EXECUTE                    = 0x00000010U,
    PAGE_EXECUTE_READ               = 0x00000020U,
    PAGE_EXECUTE_READWRITE          = 0x00000040U,
    PAGE_EXECUTE_WRITECOPY          = 0x00000080U,
    PAGE_GUARD                      = 0x00000100U,
    PAGE_NOCACHE                    = 0x00000200U,
    PAGE_WRITECOMBINE               = 0x00000400U,
    PAGE_GRAPHICS_NOACCESS          = 0x00000800U,
    PAGE_GRAPHICS_READONLY          = 0x00001000U,
    PAGE_GRAPHICS_READWRITE         = 0x00002000U,
    PAGE_GRAPHICS_EXECUTE           = 0x00004000U,
    PAGE_GRAPHICS_EXECUTE_READ      = 0x00008000U,
    PAGE_GRAPHICS_EXECUTE_READWRITE = 0x00010000U,
    PAGE_GRAPHICS_COHERENT          = 0x00020000U,
    PAGE_GRAPHICS_NOCACHE           = 0x00040000U,
    PAGE_ENCLAVE_THREAD_CONTROL     = 0x80000000U,
    PAGE_REVERT_TO_FILE_MAP         = 0x80000000U,
    PAGE_TARGETS_NO_UPDATE          = 0x40000000U,
    PAGE_TARGETS_INVALID            = 0x40000000U,
    PAGE_ENCLAVE_UNVALIDATED        = 0x20000000U,
    PAGE_ENCLAVE_MASK               = 0x10000000U,
    PAGE_ENCLAVE_DECOMMIT           = 0x10000000U,
    PAGE_ENCLAVE_SS_FIRST           = 0x10000001U,
    PAGE_ENCLAVE_SS_REST            = 0x10000002U,
    SEC_PARTITION_OWNER_HANDLE      = 0x00040000U,
    SEC_64K_PAGES                   = 0x00080000U,
    SEC_FILE                        = 0x00800000U,
    SEC_IMAGE                       = 0x01000000U,
    SEC_PROTECTED_IMAGE             = 0x02000000U,
    SEC_RESERVE                     = 0x04000000U,
    SEC_COMMIT                      = 0x08000000U,
    SEC_NOCACHE                     = 0x10000000U,
    SEC_WRITECOMBINE                = 0x40000000U,
    SEC_LARGE_PAGES                 = 0x80000000U,
    SEC_IMAGE_NO_EXECUTE            = 0x11000000U,
}

alias UNMAP_VIEW_OF_FILE_FLAGS = uint;
enum : uint
{
    MEM_UNMAP_NONE                 = 0x00000000U,
    MEM_UNMAP_WITH_TRANSIENT_BOOST = 0x00000001U,
    MEM_PRESERVE_PLACEHOLDER       = 0x00000002U,
}

alias VIRTUAL_FREE_TYPE = uint;
enum : uint
{
    MEM_DECOMMIT = 0x00004000U,
    MEM_RELEASE  = 0x00008000U,
}

alias VIRTUAL_ALLOCATION_TYPE = uint;
enum : uint
{
    MEM_COMMIT              = 0x00001000U,
    MEM_RESERVE             = 0x00002000U,
    MEM_RESET               = 0x00080000U,
    MEM_RESET_UNDO          = 0x01000000U,
    MEM_REPLACE_PLACEHOLDER = 0x00004000U,
    MEM_LARGE_PAGES         = 0x20000000U,
    MEM_RESERVE_PLACEHOLDER = 0x00040000U,
    MEM_FREE                = 0x00010000U,
}

alias LOCAL_ALLOC_FLAGS = uint;
enum : uint
{
    LHND          = 0x00000042U,
    LMEM_FIXED    = 0x00000000U,
    LMEM_MOVEABLE = 0x00000002U,
    LMEM_ZEROINIT = 0x00000040U,
    LPTR          = 0x00000040U,
    NONZEROLHND   = 0x00000002U,
    NONZEROLPTR   = 0x00000000U,
}

alias GLOBAL_ALLOC_FLAGS = uint;
enum : uint
{
    GHND          = 0x00000042U,
    GMEM_FIXED    = 0x00000000U,
    GMEM_MOVEABLE = 0x00000002U,
    GMEM_ZEROINIT = 0x00000040U,
    GPTR          = 0x00000040U,
}

alias PAGE_TYPE = uint;
enum : uint
{
    MEM_PRIVATE = 0x00020000U,
    MEM_MAPPED  = 0x00040000U,
    MEM_IMAGE   = 0x01000000U,
}

alias SETPROCESSWORKINGSETSIZEEX_FLAGS = uint;
enum : uint
{
    QUOTA_LIMITS_HARDWS_MIN_ENABLE  = 0x00000001U,
    QUOTA_LIMITS_HARDWS_MIN_DISABLE = 0x00000002U,
    QUOTA_LIMITS_HARDWS_MAX_ENABLE  = 0x00000004U,
    QUOTA_LIMITS_HARDWS_MAX_DISABLE = 0x00000008U,
}

alias MEMORY_RESOURCE_NOTIFICATION_TYPE = int;
enum : int
{
    LowMemoryResourceNotification  = 0x00000000,
    HighMemoryResourceNotification = 0x00000001,
}

alias OFFER_PRIORITY = int;
enum : int
{
    VmOfferPriorityVeryLow     = 0x00000001,
    VmOfferPriorityLow         = 0x00000002,
    VmOfferPriorityBelowNormal = 0x00000003,
    VmOfferPriorityNormal      = 0x00000004,
}

alias WIN32_MEMORY_INFORMATION_CLASS = int;
enum : int
{
    MemoryRegionInfo = 0x00000000,
}

alias WIN32_MEMORY_PARTITION_INFORMATION_CLASS = int;
enum : int
{
    MemoryPartitionInfo                = 0x00000000,
    MemoryPartitionDedicatedMemoryInfo = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-mem_extended_parameter_type
alias MEM_EXTENDED_PARAMETER_TYPE = int;
enum : int
{
    MemExtendedParameterInvalidType         = 0x00000000,
    MemExtendedParameterAddressRequirements = 0x00000001,
    MemExtendedParameterNumaNode            = 0x00000002,
    MemExtendedParameterPartitionHandle     = 0x00000003,
    MemExtendedParameterUserPhysicalHandle  = 0x00000004,
    MemExtendedParameterAttributeFlags      = 0x00000005,
    MemExtendedParameterImageMachine        = 0x00000006,
    MemExtendedParameterMax                 = 0x00000007,
}

alias MEM_DEDICATED_ATTRIBUTE_TYPE = int;
enum : int
{
    MemDedicatedAttributeReadBandwidth  = 0x00000000,
    MemDedicatedAttributeReadLatency    = 0x00000001,
    MemDedicatedAttributeWriteBandwidth = 0x00000002,
    MemDedicatedAttributeWriteLatency   = 0x00000003,
    MemDedicatedAttributeMax            = 0x00000004,
}

alias MEM_SECTION_EXTENDED_PARAMETER_TYPE = int;
enum : int
{
    MemSectionExtendedParameterInvalidType       = 0x00000000,
    MemSectionExtendedParameterUserPhysicalFlags = 0x00000001,
    MemSectionExtendedParameterNumaNode          = 0x00000002,
    MemSectionExtendedParameterSigningLevel      = 0x00000003,
    MemSectionExtendedParameterMax               = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-heap_information_class
alias HEAP_INFORMATION_CLASS = int;
enum : int
{
    HeapCompatibilityInformation      = 0x00000000,
    HeapEnableTerminationOnCorruption = 0x00000001,
    HeapOptimizeResources             = 0x00000003,
    HeapTag                           = 0x00000007,
}

// Constants


enum : uint
{
    FILE_CACHE_MAX_HARD_ENABLE  = 0x00000001U,
    FILE_CACHE_MAX_HARD_DISABLE = 0x00000002U,
    FILE_CACHE_MIN_HARD_ENABLE  = 0x00000004U,
    FILE_CACHE_MIN_HARD_DISABLE = 0x00000008U,
}

enum uint MEHC_PATROL_SCRUBBER_PRESENT = 0x00000001U;

enum : uint
{
    WIN32_MEMORY_NUMA_PERFORMANCE_ALL_TARGET_NODE = 0xffffffffU,
    WIN32_MEMORY_NUMA_PERFORMANCE_READ_LATENCY    = 0x00000001U,
    WIN32_MEMORY_NUMA_PERFORMANCE_READ_BANDWIDTH  = 0x00000002U,
    WIN32_MEMORY_NUMA_PERFORMANCE_WRITE_LATENCY   = 0x00000004U,
    WIN32_MEMORY_NUMA_PERFORMANCE_WRITE_BANDWIDTH = 0x00000008U,
}

// Callbacks

alias PBAD_MEMORY_CALLBACK_ROUTINE = void function();
alias PSECURE_MEMORY_CACHE_CALLBACK = BOOLEAN function(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* Addr, 
                                                       size_t Range);

// Structs


//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
//STRUCT ATTR: MetadataTypedefAttribute : CustomAttributeSig([], [])
struct MEMORY_MAPPED_VIEW_ADDRESS
{
    void* Value;
}

struct AtlThunkData_t
{
    ptrdiff_t Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minwinbase/ns-minwinbase-process_heap_entry
struct PROCESS_HEAP_ENTRY
{
    void*  lpData;
    uint   cbData;
    ubyte  cbOverhead;
    ubyte  iRegionIndex;
    ushort wFlags;
    union
    {
        struct Block
        {
            HANDLE  hMem;
            uint[3] dwReserved;
        }
        struct Region
        {
            uint  dwCommittedSize;
            uint  dwUnCommittedSize;
            void* lpFirstBlock;
            void* lpLastBlock;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/heapapi/ns-heapapi-heap_summary
struct HEAP_SUMMARY
{
    uint   cb;
    size_t cbAllocated;
    size_t cbCommitted;
    size_t cbReserved;
    size_t cbMaxReserve;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/memoryapi/ns-memoryapi-win32_memory_range_entry
struct WIN32_MEMORY_RANGE_ENTRY
{
    void*  VirtualAddress;
    size_t NumberOfBytes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/memoryapi/ns-memoryapi-win32_memory_region_information
struct WIN32_MEMORY_REGION_INFORMATION
{
    void*  AllocationBase;
    uint   AllocationProtect;
    union
    {
        uint Flags;
        struct
        {
            // Native bit field: Private: [0], MappedDataFile: [1], MappedImage: [2], MappedPageFile: [3], MappedPhysical: [4], DirectMapped: [5], Reserved: [6-31]
            uint _bitfield0;
        }
    }
    size_t RegionSize;
    size_t CommitSize;
}

struct WIN32_MEMORY_PARTITION_INFORMATION
{
    uint      Flags;
    uint      NumaNode;
    uint      Channel;
    uint      NumberOfNumaNodes;
    ulong     ResidentAvailablePages;
    ulong     CommittedPages;
    ulong     CommitLimit;
    ulong     PeakCommitment;
    ulong     TotalNumberOfPages;
    ulong     AvailablePages;
    ulong     ZeroPages;
    ulong     FreePages;
    ulong     StandbyPages;
    ulong[16] Reserved;
    ulong     MaximumCommitLimit;
    ulong     Reserved2;
    uint      PartitionId;
}

struct WIN32_MEMORY_NUMA_PERFORMANCE_ENTRY
{
    uint  InitiatorNodeNumber;
    uint  TargetNodeNumber;
    ubyte DataType;
    struct Flags
    {
        // Native bit field: MinTransferSizeToAchieveValues: [0], NonSequentialTransfers: [1], Reserved: [2-7]
        ubyte _bitfield0;
    }
    ulong MinTransferSizeInBytes;
    ulong EntryValue;
}

struct WIN32_MEMORY_NUMA_PERFORMANCE_INFORMATION_OUTPUT
{
    uint EntryCount;
    WIN32_MEMORY_NUMA_PERFORMANCE_ENTRY[1] PerformanceEntries; // Flexible array
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-memory_basic_information
    struct MEMORY_BASIC_INFORMATION
    {
        void*     BaseAddress;
        void*     AllocationBase;
        PAGE_PROTECTION_FLAGS AllocationProtect;
        ushort    PartitionId;
        size_t    RegionSize;
        VIRTUAL_ALLOCATION_TYPE State;
        PAGE_PROTECTION_FLAGS Protect;
        PAGE_TYPE Type;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-memory_basic_information
    struct MEMORY_BASIC_INFORMATION
    {
        void*     BaseAddress;
        void*     AllocationBase;
        PAGE_PROTECTION_FLAGS AllocationProtect;
        ushort    PartitionId;
        size_t    RegionSize;
        VIRTUAL_ALLOCATION_TYPE State;
        PAGE_PROTECTION_FLAGS Protect;
        PAGE_TYPE Type;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-memory_basic_information
    struct MEMORY_BASIC_INFORMATION
    {
        void*     BaseAddress;
        void*     AllocationBase;
        PAGE_PROTECTION_FLAGS AllocationProtect;
        size_t    RegionSize;
        VIRTUAL_ALLOCATION_TYPE State;
        PAGE_PROTECTION_FLAGS Protect;
        PAGE_TYPE Type;
    }
}

struct MEMORY_BASIC_INFORMATION32
{
    uint      BaseAddress;
    uint      AllocationBase;
    PAGE_PROTECTION_FLAGS AllocationProtect;
    uint      RegionSize;
    VIRTUAL_ALLOCATION_TYPE State;
    PAGE_PROTECTION_FLAGS Protect;
    PAGE_TYPE Type;
}

struct MEMORY_BASIC_INFORMATION64
{
    ulong     BaseAddress;
    ulong     AllocationBase;
    PAGE_PROTECTION_FLAGS AllocationProtect;
    uint      __alignment1;
    ulong     RegionSize;
    VIRTUAL_ALLOCATION_TYPE State;
    PAGE_PROTECTION_FLAGS Protect;
    PAGE_TYPE Type;
    uint      __alignment2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Memory/-cfg-call-target-info
struct CFG_CALL_TARGET_INFO
{
    size_t Offset;
    size_t Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-mem_extended_parameter
struct MEM_EXTENDED_PARAMETER
{
    struct
    {
        // Native bit field: Type: [0-7], Reserved: [8-63]
        ulong _bitfield0;
    }
    union
    {
        ulong  ULong64;
        void*  Pointer;
        size_t Size;
        HANDLE Handle;
        uint   ULong;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-mem_address_requirements
struct MEM_ADDRESS_REQUIREMENTS
{
    void*  LowestStartingAddress;
    void*  HighestEndingAddress;
    size_t Alignment;
}

struct MEMORY_PARTITION_DEDICATED_MEMORY_ATTRIBUTE
{
    MEM_DEDICATED_ATTRIBUTE_TYPE Type;
    uint  Reserved;
    ulong Value;
}

struct MEMORY_PARTITION_DEDICATED_MEMORY_INFORMATION
{
    uint  NextEntryOffset;
    uint  SizeOfInformation;
    uint  Flags;
    uint  AttributesOffset;
    uint  AttributeCount;
    uint  Reserved;
    ulong TypeId;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HANDLE HeapCreate(HEAP_FLAGS flOptions, size_t dwInitialSize, size_t dwMaximumSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL HeapDestroy(HANDLE hHeap);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
void* HeapAlloc(HANDLE hHeap, HEAP_FLAGS dwFlags, size_t dwBytes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
void* HeapReAlloc(HANDLE hHeap, HEAP_FLAGS dwFlags, void* lpMem, size_t dwBytes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL HeapFree(HANDLE hHeap, HEAP_FLAGS dwFlags, void* lpMem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
size_t HeapSize(HANDLE hHeap, HEAP_FLAGS dwFlags, const(void)* lpMem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HANDLE GetProcessHeap();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
size_t HeapCompact(HANDLE hHeap, HEAP_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL HeapSetInformation(HANDLE HeapHandle, HEAP_INFORMATION_CLASS HeapInformationClass, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* HeapInformation, 
                        size_t HeapInformationLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL HeapValidate(HANDLE hHeap, HEAP_FLAGS dwFlags, const(void)* lpMem);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/heapapi/nf-heapapi-heapsummary
@DllImport("KERNEL32.dll")
BOOL HeapSummary(HANDLE hHeap, uint dwFlags, HEAP_SUMMARY* lpSummary);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetProcessHeaps(uint NumberOfHeaps, 
                     /*PARAM ATTR: DoNotReleaseAttribute : CustomAttributeSig([], [])*/HANDLE* ProcessHeaps);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL HeapLock(HANDLE hHeap);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL HeapUnlock(HANDLE hHeap);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL HeapWalk(HANDLE hHeap, PROCESS_HEAP_ENTRY* lpEntry);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL HeapQueryInformation(HANDLE HeapHandle, HEAP_INFORMATION_CLASS HeapInformationClass, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* HeapInformation, 
                          size_t HeapInformationLength, size_t* ReturnLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
void* VirtualAlloc(void* lpAddress, size_t dwSize, VIRTUAL_ALLOCATION_TYPE flAllocationType, 
                   PAGE_PROTECTION_FLAGS flProtect);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL VirtualProtect(void* lpAddress, size_t dwSize, PAGE_PROTECTION_FLAGS flNewProtect, 
                    PAGE_PROTECTION_FLAGS* lpflOldProtect);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL VirtualFree(void* lpAddress, size_t dwSize, VIRTUAL_FREE_TYPE dwFreeType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
size_t VirtualQuery(const(void)* lpAddress, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/MEMORY_BASIC_INFORMATION* lpBuffer, 
                    size_t dwLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
void* VirtualAllocEx(HANDLE hProcess, void* lpAddress, size_t dwSize, VIRTUAL_ALLOCATION_TYPE flAllocationType, 
                     PAGE_PROTECTION_FLAGS flProtect);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL VirtualProtectEx(HANDLE hProcess, void* lpAddress, size_t dwSize, PAGE_PROTECTION_FLAGS flNewProtect, 
                      PAGE_PROTECTION_FLAGS* lpflOldProtect);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
size_t VirtualQueryEx(HANDLE hProcess, const(void)* lpAddress, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/MEMORY_BASIC_INFORMATION* lpBuffer, 
                      size_t dwLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HANDLE CreateFileMappingW(HANDLE hFile, SECURITY_ATTRIBUTES* lpFileMappingAttributes, 
                          PAGE_PROTECTION_FLAGS flProtect, uint dwMaximumSizeHigh, uint dwMaximumSizeLow, 
                          const(PWSTR) lpName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HANDLE OpenFileMappingW(uint dwDesiredAccess, BOOL bInheritHandle, const(PWSTR) lpName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
MEMORY_MAPPED_VIEW_ADDRESS MapViewOfFile(HANDLE hFileMappingObject, FILE_MAP dwDesiredAccess, 
                                         uint dwFileOffsetHigh, uint dwFileOffsetLow, size_t dwNumberOfBytesToMap);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
MEMORY_MAPPED_VIEW_ADDRESS MapViewOfFileEx(HANDLE hFileMappingObject, FILE_MAP dwDesiredAccess, 
                                           uint dwFileOffsetHigh, uint dwFileOffsetLow, size_t dwNumberOfBytesToMap, 
                                           void* lpBaseAddress);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL VirtualFreeEx(HANDLE hProcess, void* lpAddress, size_t dwSize, VIRTUAL_FREE_TYPE dwFreeType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL FlushViewOfFile(const(void)* lpBaseAddress, size_t dwNumberOfBytesToFlush);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL UnmapViewOfFile(const(MEMORY_MAPPED_VIEW_ADDRESS) lpBaseAddress);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
size_t GetLargePageMinimum();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL GetProcessWorkingSetSizeEx(HANDLE hProcess, size_t* lpMinimumWorkingSetSize, size_t* lpMaximumWorkingSetSize, 
                                uint* Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL SetProcessWorkingSetSizeEx(HANDLE hProcess, size_t dwMinimumWorkingSetSize, size_t dwMaximumWorkingSetSize, 
                                SETPROCESSWORKINGSETSIZEEX_FLAGS Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL VirtualLock(void* lpAddress, size_t dwSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL VirtualUnlock(void* lpAddress, size_t dwSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetWriteWatch(uint dwFlags, void* lpBaseAddress, size_t dwRegionSize, void** lpAddresses, size_t* lpdwCount, 
                   uint* lpdwGranularity);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint ResetWriteWatch(void* lpBaseAddress, size_t dwRegionSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HANDLE CreateMemoryResourceNotification(MEMORY_RESOURCE_NOTIFICATION_TYPE NotificationType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL QueryMemoryResourceNotification(HANDLE ResourceNotificationHandle, BOOL* ResourceState);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL GetSystemFileCacheSize(size_t* lpMinimumFileCacheSize, size_t* lpMaximumFileCacheSize, uint* lpFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL SetSystemFileCacheSize(size_t MinimumFileCacheSize, size_t MaximumFileCacheSize, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
HANDLE CreateFileMappingNumaW(HANDLE hFile, SECURITY_ATTRIBUTES* lpFileMappingAttributes, 
                              PAGE_PROTECTION_FLAGS flProtect, uint dwMaximumSizeHigh, uint dwMaximumSizeLow, 
                              const(PWSTR) lpName, uint nndPreferred);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
BOOL PrefetchVirtualMemory(HANDLE hProcess, size_t NumberOfEntries, WIN32_MEMORY_RANGE_ENTRY* VirtualAddresses, 
                           uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
HANDLE CreateFileMappingFromApp(HANDLE hFile, SECURITY_ATTRIBUTES* SecurityAttributes, 
                                PAGE_PROTECTION_FLAGS PageProtection, ulong MaximumSize, const(PWSTR) Name);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
MEMORY_MAPPED_VIEW_ADDRESS MapViewOfFileFromApp(HANDLE hFileMappingObject, FILE_MAP DesiredAccess, 
                                                ulong FileOffset, size_t NumberOfBytesToMap);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
BOOL UnmapViewOfFileEx(MEMORY_MAPPED_VIEW_ADDRESS BaseAddress, UNMAP_VIEW_OF_FILE_FLAGS UnmapFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL AllocateUserPhysicalPages(HANDLE hProcess, size_t* NumberOfPages, size_t* PageArray);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL FreeUserPhysicalPages(HANDLE hProcess, size_t* NumberOfPages, size_t* PageArray);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL MapUserPhysicalPages(void* VirtualAddress, size_t NumberOfPages, size_t* PageArray);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL AllocateUserPhysicalPagesNuma(HANDLE hProcess, size_t* NumberOfPages, size_t* PageArray, uint nndPreferred);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
void* VirtualAllocExNuma(HANDLE hProcess, void* lpAddress, size_t dwSize, VIRTUAL_ALLOCATION_TYPE flAllocationType, 
                         uint flProtect, uint nndPreferred);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
BOOL GetMemoryErrorHandlingCapabilities(uint* Capabilities);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
void* RegisterBadMemoryNotification(PBAD_MEMORY_CALLBACK_ROUTINE Callback);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
BOOL UnregisterBadMemoryNotification(void* RegistrationHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("KERNEL32.dll")
uint OfferVirtualMemory(void* VirtualAddress, size_t Size, OFFER_PRIORITY Priority);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("KERNEL32.dll")
uint ReclaimVirtualMemory(const(void)* VirtualAddress, size_t Size);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("KERNEL32.dll")
uint DiscardVirtualMemory(void* VirtualAddress, size_t Size);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("api-ms-win-core-memory-l1-1-3.dll")
BOOL SetProcessValidCallTargets(HANDLE hProcess, void* VirtualAddress, size_t RegionSize, uint NumberOfOffsets, 
                                CFG_CALL_TARGET_INFO* OffsetInformation);

@DllImport("api-ms-win-core-memory-l1-1-7.dll")
BOOL SetProcessValidCallTargetsForMappedView(HANDLE Process, void* VirtualAddress, size_t RegionSize, 
                                             uint NumberOfOffsets, CFG_CALL_TARGET_INFO* OffsetInformation, 
                                             HANDLE Section, ulong ExpectedFileOffset);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("api-ms-win-core-memory-l1-1-3.dll")
void* VirtualAllocFromApp(void* BaseAddress, size_t Size, VIRTUAL_ALLOCATION_TYPE AllocationType, uint Protection);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("api-ms-win-core-memory-l1-1-3.dll")
BOOL VirtualProtectFromApp(void* Address, size_t Size, uint NewProtection, uint* OldProtection);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("api-ms-win-core-memory-l1-1-3.dll")
HANDLE OpenFileMappingFromApp(uint DesiredAccess, BOOL InheritHandle, const(PWSTR) Name);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
@DllImport("api-ms-win-core-memory-l1-1-4.dll")
BOOL QueryVirtualMemoryInformation(HANDLE Process, const(void)* VirtualAddress, 
                                   WIN32_MEMORY_INFORMATION_CLASS MemoryInformationClass, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* MemoryInformation, 
                                   size_t MemoryInformationSize, size_t* ReturnSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
@DllImport("api-ms-win-core-memory-l1-1-5.dll")
MEMORY_MAPPED_VIEW_ADDRESS MapViewOfFileNuma2(HANDLE FileMappingHandle, HANDLE ProcessHandle, ulong Offset, 
                                              void* BaseAddress, size_t ViewSize, uint AllocationType, 
                                              uint PageProtection, uint PreferredNode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
@DllImport("api-ms-win-core-memory-l1-1-5.dll")
BOOL UnmapViewOfFile2(HANDLE Process, MEMORY_MAPPED_VIEW_ADDRESS BaseAddress, UNMAP_VIEW_OF_FILE_FLAGS UnmapFlags);

@DllImport("api-ms-win-core-memory-l1-1-5.dll")
BOOL VirtualUnlockEx(HANDLE Process, void* Address, size_t Size);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("api-ms-win-core-memory-l1-1-6.dll")
void* VirtualAlloc2(HANDLE Process, void* BaseAddress, size_t Size, VIRTUAL_ALLOCATION_TYPE AllocationType, 
                    uint PageProtection, MEM_EXTENDED_PARAMETER* ExtendedParameters, uint ParameterCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
@DllImport("api-ms-win-core-memory-l1-1-6.dll")
MEMORY_MAPPED_VIEW_ADDRESS MapViewOfFile3(HANDLE FileMapping, HANDLE Process, void* BaseAddress, ulong Offset, 
                                          size_t ViewSize, VIRTUAL_ALLOCATION_TYPE AllocationType, 
                                          uint PageProtection, MEM_EXTENDED_PARAMETER* ExtendedParameters, 
                                          uint ParameterCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("api-ms-win-core-memory-l1-1-6.dll")
void* VirtualAlloc2FromApp(HANDLE Process, void* BaseAddress, size_t Size, VIRTUAL_ALLOCATION_TYPE AllocationType, 
                           uint PageProtection, MEM_EXTENDED_PARAMETER* ExtendedParameters, uint ParameterCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("api-ms-win-core-memory-l1-1-6.dll")
MEMORY_MAPPED_VIEW_ADDRESS MapViewOfFile3FromApp(HANDLE FileMapping, HANDLE Process, void* BaseAddress, 
                                                 ulong Offset, size_t ViewSize, 
                                                 VIRTUAL_ALLOCATION_TYPE AllocationType, uint PageProtection, 
                                                 MEM_EXTENDED_PARAMETER* ExtendedParameters, uint ParameterCount);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/memoryapi/nf-memoryapi-createfilemapping2
@DllImport("api-ms-win-core-memory-l1-1-7.dll")
HANDLE CreateFileMapping2(HANDLE File, SECURITY_ATTRIBUTES* SecurityAttributes, uint DesiredAccess, 
                          PAGE_PROTECTION_FLAGS PageProtection, uint AllocationAttributes, ulong MaximumSize, 
                          const(PWSTR) Name, MEM_EXTENDED_PARAMETER* ExtendedParameters, uint ParameterCount);

@DllImport("api-ms-win-core-memory-l1-1-8.dll")
BOOL AllocateUserPhysicalPages2(HANDLE ObjectHandle, size_t* NumberOfPages, size_t* PageArray, 
                                MEM_EXTENDED_PARAMETER* ExtendedParameters, uint ExtendedParameterCount);

@DllImport("api-ms-win-core-memory-l1-1-8.dll")
HANDLE OpenDedicatedMemoryPartition(HANDLE Partition, ulong DedicatedMemoryTypeId, uint DesiredAccess, 
                                    BOOL InheritHandle);

@DllImport("api-ms-win-core-memory-l1-1-8.dll")
BOOL QueryPartitionInformation(HANDLE Partition, 
                               WIN32_MEMORY_PARTITION_INFORMATION_CLASS PartitionInformationClass, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* PartitionInformation, 
                               uint PartitionInformationLength);

@DllImport("api-ms-win-core-memory-l1-1-9.dll")
BOOL GetMemoryNumaClosestInitiatorNode(uint TargetNodeNumber, uint* InitiatorNodeNumber);

@DllImport("api-ms-win-core-memory-l1-1-9.dll")
BOOL GetMemoryNumaPerformanceInformation(uint NodeNumber, ubyte DataType, 
                                         WIN32_MEMORY_NUMA_PERFORMANCE_INFORMATION_OUTPUT** PerfInfo);

@DllImport("KERNEL32.dll")
size_t RtlCompareMemory(const(void)* Source1, const(void)* Source2, size_t Length);

@DllImport("ntdll.dll")
uint RtlCrc32(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* Buffer, 
              size_t Size, uint InitialCrc);

@DllImport("ntdll.dll")
ulong RtlCrc64(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* Buffer, 
               size_t Size, ulong InitialCrc);

@DllImport("ntdll.dll")
BOOLEAN RtlIsZeroMemory(void* Buffer, size_t Length);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HGLOBAL GlobalAlloc(GLOBAL_ALLOC_FLAGS uFlags, size_t dwBytes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HGLOBAL GlobalReAlloc(HGLOBAL hMem, size_t dwBytes, uint uFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
size_t GlobalSize(HGLOBAL hMem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GlobalUnlock(HGLOBAL hMem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
void* GlobalLock(HGLOBAL hMem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GlobalFlags(HGLOBAL hMem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HGLOBAL GlobalHandle(const(void)* pMem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HLOCAL LocalAlloc(LOCAL_ALLOC_FLAGS uFlags, size_t uBytes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HLOCAL LocalReAlloc(HLOCAL hMem, size_t uBytes, uint uFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
void* LocalLock(HLOCAL hMem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HLOCAL LocalHandle(const(void)* pMem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL LocalUnlock(HLOCAL hMem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
size_t LocalSize(HLOCAL hMem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint LocalFlags(HLOCAL hMem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HANDLE CreateFileMappingA(HANDLE hFile, SECURITY_ATTRIBUTES* lpFileMappingAttributes, 
                          PAGE_PROTECTION_FLAGS flProtect, uint dwMaximumSizeHigh, uint dwMaximumSizeLow, 
                          const(PSTR) lpName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
HANDLE CreateFileMappingNumaA(HANDLE hFile, SECURITY_ATTRIBUTES* lpFileMappingAttributes, 
                              PAGE_PROTECTION_FLAGS flProtect, uint dwMaximumSizeHigh, uint dwMaximumSizeLow, 
                              const(PSTR) lpName, uint nndPreferred);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
HANDLE OpenFileMappingA(uint dwDesiredAccess, BOOL bInheritHandle, const(PSTR) lpName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
MEMORY_MAPPED_VIEW_ADDRESS MapViewOfFileExNuma(HANDLE hFileMappingObject, FILE_MAP dwDesiredAccess, 
                                               uint dwFileOffsetHigh, uint dwFileOffsetLow, 
                                               size_t dwNumberOfBytesToMap, void* lpBaseAddress, uint nndPreferred);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL IsBadReadPtr(const(void)* lp, size_t ucb);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL IsBadWritePtr(void* lp, size_t ucb);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL IsBadCodePtr(FARPROC lpfn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL IsBadStringPtrA(const(PSTR) lpsz, size_t ucchMax);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL IsBadStringPtrW(const(PWSTR) lpsz, size_t ucchMax);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL MapUserPhysicalPagesScatter(void** VirtualAddresses, size_t NumberOfPages, size_t* PageArray);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL AddSecureMemoryCacheCallback(PSECURE_MEMORY_CACHE_CALLBACK pfnCallBack);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL RemoveSecureMemoryCacheCallback(PSECURE_MEMORY_CACHE_CALLBACK pfnCallBack);


