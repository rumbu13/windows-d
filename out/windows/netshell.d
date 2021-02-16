module windows.netshell;

public import windows.core;
public import windows.systemservices : BOOL, HANDLE;

extern(Windows):


// Enums


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
alias NS_CMD_FLAGS = int;

enum : int
{
    NS_REQ_ZERO           = 0x00000000,
    NS_REQ_PRESENT        = 0x00000001,
    NS_REQ_ALLOW_MULTIPLE = 0x00000002,
    NS_REQ_ONE_OR_MORE    = 0x00000003,
}
alias NS_REQS = int;

enum : int
{
    NS_EVENT_LOOP       = 0x00010000,
    NS_EVENT_LAST_N     = 0x00000001,
    NS_EVENT_LAST_SECS  = 0x00000002,
    NS_EVENT_FROM_N     = 0x00000004,
    NS_EVENT_FROM_START = 0x00000008,
}
alias NS_EVENTS = int;

enum : int
{
    NETSH_COMMIT       = 0x00000000,
    NETSH_UNCOMMIT     = 0x00000001,
    NETSH_FLUSH        = 0x00000002,
    NETSH_COMMIT_STATE = 0x00000003,
    NETSH_SAVE         = 0x00000004,
}
alias NS_MODE_CHANGE = int;

// Callbacks

alias GET_RESOURCE_STRING_FN = uint function(uint dwMsgID, const(wchar)* lpBuffer, uint nBufferMax);
alias PGET_RESOURCE_STRING_FN = uint function();
alias NS_CONTEXT_COMMIT_FN = uint function(uint dwAction);
alias PNS_CONTEXT_COMMIT_FN = uint function();
alias NS_CONTEXT_CONNECT_FN = uint function(const(wchar)* pwszMachine);
alias PNS_CONTEXT_CONNECT_FN = uint function();
alias NS_CONTEXT_DUMP_FN = uint function(const(wchar)* pwszRouter, char* ppwcArguments, uint dwArgCount, 
                                         void* pvData);
alias PNS_CONTEXT_DUMP_FN = uint function();
alias NS_DLL_STOP_FN = uint function(uint dwReserved);
alias PNS_DLL_STOP_FN = uint function();
alias NS_HELPER_START_FN = uint function(const(GUID)* pguidParent, uint dwVersion);
alias PNS_HELPER_START_FN = uint function();
alias NS_HELPER_STOP_FN = uint function(uint dwReserved);
alias PNS_HELPER_STOP_FN = uint function();
alias FN_HANDLE_CMD = uint function(const(wchar)* pwszMachine, char* ppwcArguments, uint dwCurrentIndex, 
                                    uint dwArgCount, uint dwFlags, void* pvData, int* pbDone);
alias PFN_HANDLE_CMD = uint function();
alias NS_OSVERSIONCHECK = BOOL function(uint CIMOSType, uint CIMOSProductSuite, const(wchar)* CIMOSVersion, 
                                        const(wchar)* CIMOSBuildNumber, const(wchar)* CIMServicePackMajorVersion, 
                                        const(wchar)* CIMServicePackMinorVersion, uint uiReserved, uint dwReserved);
alias PNS_OSVERSIONCHECK = BOOL function();
alias NS_DLL_INIT_FN = uint function(uint dwNetshVersion, void* pReserved);
alias PNS_DLL_INIT_FN = uint function();

// Structs


struct TOKEN_VALUE
{
    const(wchar)* pwszToken;
    uint          dwValue;
}

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

struct CMD_ENTRY
{
    const(wchar)*      pwszCmdToken;
    PFN_HANDLE_CMD     pfnCmdHandler;
    uint               dwShortCmdHelpToken;
    uint               dwCmdHlpToken;
    uint               dwFlags;
    PNS_OSVERSIONCHECK pOsVersionCheck;
}

struct CMD_GROUP_ENTRY
{
    const(wchar)*      pwszCmdGroupToken;
    uint               dwShortCmdHelpToken;
    uint               ulCmdGroupSize;
    uint               dwFlags;
    CMD_ENTRY*         pCmdGroup;
    PNS_OSVERSIONCHECK pOsVersionCheck;
}

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
    const(wchar)*       pwszContext;
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

struct TAG_TYPE
{
    const(wchar)* pwszTag;
    uint          dwRequired;
    BOOL          bPresent;
}

// Functions

@DllImport("NETSH")
uint MatchEnumTag(HANDLE hModule, const(wchar)* pwcArg, uint dwNumArg, const(TOKEN_VALUE)* pEnumTable, 
                  uint* pdwValue);

@DllImport("NETSH")
BOOL MatchToken(const(wchar)* pwszUserToken, const(wchar)* pwszCmdToken);

@DllImport("NETSH")
uint PreprocessCommand(HANDLE hModule, char* ppwcArguments, uint dwCurrentIndex, uint dwArgCount, char* pttTags, 
                       uint dwTagCount, uint dwMinArgs, uint dwMaxArgs, char* pdwTagType);

@DllImport("NETSH")
uint PrintError(HANDLE hModule, uint dwErrId);

@DllImport("NETSH")
uint PrintMessageFromModule(HANDLE hModule, uint dwMsgId);

@DllImport("NETSH")
uint PrintMessage(const(wchar)* pwszFormat);

@DllImport("NETSH")
uint RegisterContext(const(NS_CONTEXT_ATTRIBUTES)* pChildContext);

@DllImport("NETSH")
uint RegisterHelper(const(GUID)* pguidParentContext, const(NS_HELPER_ATTRIBUTES)* pfnRegisterSubContext);


