module windows.netshell;

public import system;
public import windows.systemservices;

extern(Windows):

enum NS_CMD_FLAGS
{
    CMD_FLAG_PRIVATE = 1,
    CMD_FLAG_INTERACTIVE = 2,
    CMD_FLAG_LOCAL = 8,
    CMD_FLAG_ONLINE = 16,
    CMD_FLAG_HIDDEN = 32,
    CMD_FLAG_LIMIT_MASK = 65535,
    CMD_FLAG_PRIORITY = -2147483648,
}

enum NS_REQS
{
    NS_REQ_ZERO = 0,
    NS_REQ_PRESENT = 1,
    NS_REQ_ALLOW_MULTIPLE = 2,
    NS_REQ_ONE_OR_MORE = 3,
}

enum NS_EVENTS
{
    NS_EVENT_LOOP = 65536,
    NS_EVENT_LAST_N = 1,
    NS_EVENT_LAST_SECS = 2,
    NS_EVENT_FROM_N = 4,
    NS_EVENT_FROM_START = 8,
}

enum NS_MODE_CHANGE
{
    NETSH_COMMIT = 0,
    NETSH_UNCOMMIT = 1,
    NETSH_FLUSH = 2,
    NETSH_COMMIT_STATE = 3,
    NETSH_SAVE = 4,
}

struct TOKEN_VALUE
{
    const(wchar)* pwszToken;
    uint dwValue;
}

alias GET_RESOURCE_STRING_FN = extern(Windows) uint function(uint dwMsgID, const(wchar)* lpBuffer, uint nBufferMax);
alias PGET_RESOURCE_STRING_FN = extern(Windows) uint function();
alias NS_CONTEXT_COMMIT_FN = extern(Windows) uint function(uint dwAction);
alias PNS_CONTEXT_COMMIT_FN = extern(Windows) uint function();
alias NS_CONTEXT_CONNECT_FN = extern(Windows) uint function(const(wchar)* pwszMachine);
alias PNS_CONTEXT_CONNECT_FN = extern(Windows) uint function();
alias NS_CONTEXT_DUMP_FN = extern(Windows) uint function(const(wchar)* pwszRouter, char* ppwcArguments, uint dwArgCount, void* pvData);
alias PNS_CONTEXT_DUMP_FN = extern(Windows) uint function();
alias NS_DLL_STOP_FN = extern(Windows) uint function(uint dwReserved);
alias PNS_DLL_STOP_FN = extern(Windows) uint function();
alias NS_HELPER_START_FN = extern(Windows) uint function(const(Guid)* pguidParent, uint dwVersion);
alias PNS_HELPER_START_FN = extern(Windows) uint function();
alias NS_HELPER_STOP_FN = extern(Windows) uint function(uint dwReserved);
alias PNS_HELPER_STOP_FN = extern(Windows) uint function();
alias FN_HANDLE_CMD = extern(Windows) uint function(const(wchar)* pwszMachine, char* ppwcArguments, uint dwCurrentIndex, uint dwArgCount, uint dwFlags, void* pvData, int* pbDone);
alias PFN_HANDLE_CMD = extern(Windows) uint function();
alias NS_OSVERSIONCHECK = extern(Windows) BOOL function(uint CIMOSType, uint CIMOSProductSuite, const(wchar)* CIMOSVersion, const(wchar)* CIMOSBuildNumber, const(wchar)* CIMServicePackMajorVersion, const(wchar)* CIMServicePackMinorVersion, uint uiReserved, uint dwReserved);
alias PNS_OSVERSIONCHECK = extern(Windows) BOOL function();
struct NS_HELPER_ATTRIBUTES
{
    _Anonymous_e__Union Anonymous;
    Guid guidHelper;
    PNS_HELPER_START_FN pfnStart;
    PNS_HELPER_STOP_FN pfnStop;
}

struct CMD_ENTRY
{
    const(wchar)* pwszCmdToken;
    PFN_HANDLE_CMD pfnCmdHandler;
    uint dwShortCmdHelpToken;
    uint dwCmdHlpToken;
    uint dwFlags;
    PNS_OSVERSIONCHECK pOsVersionCheck;
}

struct CMD_GROUP_ENTRY
{
    const(wchar)* pwszCmdGroupToken;
    uint dwShortCmdHelpToken;
    uint ulCmdGroupSize;
    uint dwFlags;
    CMD_ENTRY* pCmdGroup;
    PNS_OSVERSIONCHECK pOsVersionCheck;
}

struct NS_CONTEXT_ATTRIBUTES
{
    _Anonymous_e__Union Anonymous;
    const(wchar)* pwszContext;
    Guid guidHelper;
    uint dwFlags;
    uint ulPriority;
    uint ulNumTopCmds;
    CMD_ENTRY* pTopCmds;
    uint ulNumGroups;
    CMD_GROUP_ENTRY* pCmdGroups;
    PNS_CONTEXT_COMMIT_FN pfnCommitFn;
    PNS_CONTEXT_DUMP_FN pfnDumpFn;
    PNS_CONTEXT_CONNECT_FN pfnConnectFn;
    void* pReserved;
    PNS_OSVERSIONCHECK pfnOsVersionCheck;
}

struct TAG_TYPE
{
    const(wchar)* pwszTag;
    uint dwRequired;
    BOOL bPresent;
}

alias NS_DLL_INIT_FN = extern(Windows) uint function(uint dwNetshVersion, void* pReserved);
alias PNS_DLL_INIT_FN = extern(Windows) uint function();
@DllImport("NETSH.dll")
uint MatchEnumTag(HANDLE hModule, const(wchar)* pwcArg, uint dwNumArg, const(TOKEN_VALUE)* pEnumTable, uint* pdwValue);

@DllImport("NETSH.dll")
BOOL MatchToken(const(wchar)* pwszUserToken, const(wchar)* pwszCmdToken);

@DllImport("NETSH.dll")
uint PreprocessCommand(HANDLE hModule, char* ppwcArguments, uint dwCurrentIndex, uint dwArgCount, char* pttTags, uint dwTagCount, uint dwMinArgs, uint dwMaxArgs, char* pdwTagType);

@DllImport("NETSH.dll")
uint PrintError(HANDLE hModule, uint dwErrId);

@DllImport("NETSH.dll")
uint PrintMessageFromModule(HANDLE hModule, uint dwMsgId);

@DllImport("NETSH.dll")
uint PrintMessage(const(wchar)* pwszFormat);

@DllImport("NETSH.dll")
uint RegisterContext(const(NS_CONTEXT_ATTRIBUTES)* pChildContext);

@DllImport("NETSH.dll")
uint RegisterHelper(const(Guid)* pguidParentContext, const(NS_HELPER_ATTRIBUTES)* pfnRegisterSubContext);

