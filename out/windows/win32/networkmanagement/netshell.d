// Written in the D programming language.

module windows.win32.networkmanagement.netshell;

public import windows.core;
public import windows.win32.foundation : BOOL, HANDLE, PWSTR;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netsh/ne-netsh-ns_cmd_flags
alias NS_CMD_FLAGS = int;
enum : int
{
    CMD_FLAG_PRIVATE     = 0x00000001,
    CMD_FLAG_INTERACTIVE = 0x00000002,
    CMD_FLAG_LOCAL       = 0x00000008,
    CMD_FLAG_ONLINE      = 0x00000010,
    CMD_FLAG_HIDDEN      = 0x00000020,
    CMD_FLAG_LIMIT_MASK  = 0x0000ffff,
    CMD_FLAG_PRIORITY    = 0x80000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netsh/ne-netsh-ns_reqs
alias NS_REQS = int;
enum : int
{
    NS_REQ_ZERO           = 0x00000000,
    NS_REQ_PRESENT        = 0x00000001,
    NS_REQ_ALLOW_MULTIPLE = 0x00000002,
    NS_REQ_ONE_OR_MORE    = 0x00000003,
}

alias NS_EVENTS = int;
enum : int
{
    NS_EVENT_LOOP       = 0x00010000,
    NS_EVENT_LAST_N     = 0x00000001,
    NS_EVENT_LAST_SECS  = 0x00000002,
    NS_EVENT_FROM_N     = 0x00000004,
    NS_EVENT_FROM_START = 0x00000008,
}

alias NS_MODE_CHANGE = int;
enum : int
{
    NETSH_COMMIT       = 0x00000000,
    NETSH_UNCOMMIT     = 0x00000001,
    NETSH_FLUSH        = 0x00000002,
    NETSH_COMMIT_STATE = 0x00000003,
    NETSH_SAVE         = 0x00000004,
}

// Constants


enum uint NETSH_ERROR_BASE = 0x00003a98U;
enum uint ERROR_NO_ENTRIES = 0x00003a98U;
enum uint ERROR_INVALID_SYNTAX = 0x00003a99U;
enum uint ERROR_PROTOCOL_NOT_IN_TRANSPORT = 0x00003a9aU;
enum uint ERROR_NO_CHANGE = 0x00003a9bU;
enum uint ERROR_CMD_NOT_FOUND = 0x00003a9cU;
enum uint ERROR_ENTRY_PT_NOT_FOUND = 0x00003a9dU;
enum uint ERROR_DLL_LOAD_FAILED = 0x00003a9eU;
enum uint ERROR_INIT_DISPLAY = 0x00003a9fU;
enum uint ERROR_TAG_ALREADY_PRESENT = 0x00003aa0U;
enum uint ERROR_INVALID_OPTION_TAG = 0x00003aa1U;

enum : uint
{
    ERROR_NO_TAG         = 0x00003aa2U,
    ERROR_MISSING_OPTION = 0x00003aa3U,
}

enum uint ERROR_TRANSPORT_NOT_PRESENT = 0x00003aa4U;
enum uint ERROR_SHOW_USAGE = 0x00003aa5U;
enum uint ERROR_INVALID_OPTION_VALUE = 0x00003aa6U;

enum : uint
{
    ERROR_OKAY                       = 0x00003aa7U,
    ERROR_CONTINUE_IN_PARENT_CONTEXT = 0x00003aa8U,
}

enum uint ERROR_SUPPRESS_OUTPUT = 0x00003aa9U;
enum uint ERROR_HELPER_ALREADY_REGISTERED = 0x00003aaaU;
enum uint ERROR_CONTEXT_ALREADY_REGISTERED = 0x00003aabU;
enum uint ERROR_PARSING_FAILURE = 0x00003aacU;
enum uint NETSH_ERROR_END = 0x00003aabU;
// Native encoding: ansi
enum const(wchar)* NS_GET_EVENT_IDS_FN_NAME = "GetEventIds";
enum uint MAX_NAME_LEN = 0x00000030U;
enum uint NETSH_VERSION_50 = 0x00005000U;
enum const(wchar)* NETSH_ARG_DELIMITER = "=";
enum const(wchar)* NETSH_CMD_DELIMITER = " ";

enum : uint
{
    NETSH_MAX_TOKEN_LENGTH     = 0x00000040U,
    NETSH_MAX_CMD_TOKEN_LENGTH = 0x00000080U,
}

enum uint DEFAULT_CONTEXT_PRIORITY = 0x00000064U;
// Native encoding: ansi
enum const(wchar)* GET_RESOURCE_STRING_FN_NAME = "GetResourceString";

// Callbacks

alias PGET_RESOURCE_STRING_FN = uint function(uint dwMsgID, PWSTR lpBuffer, uint nBufferMax);
alias PNS_CONTEXT_COMMIT_FN = uint function(uint dwAction);
alias PNS_CONTEXT_CONNECT_FN = uint function(const(PWSTR) pwszMachine);
alias PNS_CONTEXT_DUMP_FN = uint function(const(PWSTR) pwszRouter, PWSTR* ppwcArguments, uint dwArgCount, 
                                          const(void)* pvData);
alias PNS_DLL_STOP_FN = uint function(uint dwReserved);
alias PNS_HELPER_START_FN = uint function(const(GUID)* pguidParent, uint dwVersion);
alias PNS_HELPER_STOP_FN = uint function(uint dwReserved);
alias PFN_HANDLE_CMD = uint function(const(PWSTR) pwszMachine, PWSTR* ppwcArguments, uint dwCurrentIndex, 
                                     uint dwArgCount, uint dwFlags, const(void)* pvData, BOOL* pbDone);
alias PNS_OSVERSIONCHECK = BOOL function(uint CIMOSType, uint CIMOSProductSuite, const(PWSTR) CIMOSVersion, 
                                         const(PWSTR) CIMOSBuildNumber, const(PWSTR) CIMServicePackMajorVersion, 
                                         const(PWSTR) CIMServicePackMinorVersion, uint uiReserved, uint dwReserved);
alias PNS_DLL_INIT_FN = uint function(uint dwNetshVersion, void* pReserved);

// Structs


struct TOKEN_VALUE
{
    const(PWSTR) pwszToken;
    uint         dwValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netsh/ns-netsh-ns_helper_attributes
struct NS_HELPER_ATTRIBUTES
{
    union
    {
        struct
        {
            uint dwVersion;
            uint dwReserved;
        }
        ulong _ullAlign;
    }
    GUID                guidHelper;
    PNS_HELPER_START_FN pfnStart;
    PNS_HELPER_STOP_FN  pfnStop;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netsh/ns-netsh-cmd_entry
struct CMD_ENTRY
{
    const(PWSTR)       pwszCmdToken;
    PFN_HANDLE_CMD     pfnCmdHandler;
    uint               dwShortCmdHelpToken;
    uint               dwCmdHlpToken;
    uint               dwFlags;
    PNS_OSVERSIONCHECK pOsVersionCheck;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netsh/ns-netsh-cmd_group_entry
struct CMD_GROUP_ENTRY
{
    const(PWSTR)       pwszCmdGroupToken;
    uint               dwShortCmdHelpToken;
    uint               ulCmdGroupSize;
    uint               dwFlags;
    CMD_ENTRY*         pCmdGroup;
    PNS_OSVERSIONCHECK pOsVersionCheck;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netsh/ns-netsh-ns_context_attributes
struct NS_CONTEXT_ATTRIBUTES
{
    union
    {
        struct
        {
            uint dwVersion;
            uint dwReserved;
        }
        ulong _ullAlign;
    }
    PWSTR               pwszContext;
    GUID                guidHelper;
    uint                dwFlags;
    uint                ulPriority;
    uint                ulNumTopCmds;
    CMD_ENTRY*          pTopCmds;
    uint                ulNumGroups;
    CMD_GROUP_ENTRY*    pCmdGroups;
    PNS_CONTEXT_COMMIT_FN pfnCommitFn;
    PNS_CONTEXT_DUMP_FN pfnDumpFn;
    PNS_CONTEXT_CONNECT_FN pfnConnectFn;
    void*               pReserved;
    PNS_OSVERSIONCHECK  pfnOsVersionCheck;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netsh/ns-netsh-tag_type
struct TAG_TYPE
{
    const(PWSTR) pwszTag;
    uint         dwRequired;
    BOOL         bPresent;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("NETSH.dll")
uint MatchEnumTag(HANDLE hModule, const(PWSTR) pwcArg, uint dwNumArg, const(TOKEN_VALUE)* pEnumTable, 
                  uint* pdwValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("NETSH.dll")
BOOL MatchToken(const(PWSTR) pwszUserToken, const(PWSTR) pwszCmdToken);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("NETSH.dll")
uint PreprocessCommand(HANDLE hModule, PWSTR* ppwcArguments, uint dwCurrentIndex, uint dwArgCount, 
                       TAG_TYPE* pttTags, uint dwTagCount, uint dwMinArgs, uint dwMaxArgs, uint* pdwTagType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("NETSH.dll")
uint PrintError(HANDLE hModule, uint dwErrId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("NETSH.dll")
uint PrintMessageFromModule(HANDLE hModule, uint dwMsgId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("NETSH.dll")
uint PrintMessage(const(PWSTR) pwszFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("NETSH.dll")
uint RegisterContext(const(NS_CONTEXT_ATTRIBUTES)* pChildContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("NETSH.dll")
uint RegisterHelper(const(GUID)* pguidParentContext, const(NS_HELPER_ATTRIBUTES)* pfnRegisterSubContext);


