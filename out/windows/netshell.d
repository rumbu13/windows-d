// Written in the D programming language.

module windows.netshell;

public import windows.core;
public import windows.systemservices : BOOL, HANDLE;

extern(Windows):


// Enums


///The <b>NS_CMD_FLAGS</b> enumeration specifies command flags available in NetShell.
alias NS_CMD_FLAGS = int;
enum : int
{
    ///Indicates a private command. This command is not valid in subcontexts.
    CMD_FLAG_PRIVATE     = 0x00000001,
    ///Indicates an interactive command. This command is not valid from outside NetShell.
    CMD_FLAG_INTERACTIVE = 0x00000002,
    ///Indicates a local command. This command is not valid from remote computers.
    CMD_FLAG_LOCAL       = 0x00000008,
    ///Indicates a command is valid only when online. This command is not valid in offline or noncommit mode.
    CMD_FLAG_ONLINE      = 0x00000010,
    ///Indicates a command is not in online Help, but can be executed.
    CMD_FLAG_HIDDEN      = 0x00000020,
    ///Indicates that the command limits the mask.
    CMD_FLAG_LIMIT_MASK  = 0x0000ffff,
    CMD_FLAG_PRIORITY    = 0x80000000,
}

///The <b>NS_REQS</b> enumeration specifies the number of events.
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

// Callbacks

alias GET_RESOURCE_STRING_FN = uint function(uint dwMsgID, const(wchar)* lpBuffer, uint nBufferMax);
alias PGET_RESOURCE_STRING_FN = uint function();
///The <b>NS_CONTEXT_COMMIT_FN</b> command is the commit function for helpers. The commit function commits commands used
///for committing offline commands, and is registered in the RegisterContext function. The following is an example of a
///commit function. Be aware that <b>SampleCommit</b> is a placeholder for the application-defined function name.
///Params:
///    dwAction = A value that specifies the commit action. Must be one of the following. <table> <tr> <th>Value</th>
///               <th>Meaning</th> </tr> <tr> <td width="40%"><a id="NETSH_COMMIT"></a><a id="netsh_commit"></a><dl>
///               <dt><b>NETSH_COMMIT</b></dt> </dl> </td> <td width="60%"> Changes to commit mode. </td> </tr> <tr> <td
///               width="40%"><a id="NETSH_UNCOMMIT"></a><a id="netsh_uncommit"></a><dl> <dt><b>NETSH_UNCOMMIT</b></dt> </dl> </td>
///               <td width="60%"> Changes to uncommit mode. </td> </tr> <tr> <td width="40%"><a id="NETSH_SAVE"></a><a
///               id="netsh_save"></a><dl> <dt><b>NETSH_SAVE</b></dt> </dl> </td> <td width="60%"> Saves all uncommitted changes.
///               </td> </tr> <tr> <td width="40%"><a id="NETSH_FLUSH"></a><a id="netsh_flush"></a><dl> <dt><b>NETSH_FLUSH</b></dt>
///               </dl> </td> <td width="60%"> Flushes all uncommitted changes. </td> </tr> </table>
///Returns:
///    Returns NO_ERROR upon success. Any other return value indicates an error.
///    
alias NS_CONTEXT_COMMIT_FN = uint function(uint dwAction);
alias PNS_CONTEXT_COMMIT_FN = uint function();
///The <b>NS_CONTEXT_CONNECT_FN</b> command is the connect function for helpers. Helpers expose a connect function that
///enables NetShell to connect to the helper. NetShell calls a helper connect function before calling other helper
///functions. The connect function is registered with NetShell using the RegisterContext function. The following is an
///example of a connect function. Be aware that <b>SampleConnect</b> is a placeholder for the application-defined
///function name.
///Params:
///    pwszMachine = The computer on which to perform the command, or null if the command applies to the local computer. The default
///                  value is null.
///Returns:
///    Returns NO_ERROR upon success. Any other return value indicates an error.
///    
alias NS_CONTEXT_CONNECT_FN = uint function(const(wchar)* pwszMachine);
alias PNS_CONTEXT_CONNECT_FN = uint function();
///The <b>NS_CONTEXT_DUMP_FN</b> command is the dump function for helpers. The dump function is used to print comments,
///and is registered in the RegisterContext function. The following is an example of a dump function. Be aware that
///<b>SampleDump</b> is a placeholder for the application-defined function name.
///Params:
///    pwszRouter = The computer on which to perform the command, or null if the command applies to the local computer. The default
///                 value is null.
///    ppwcArguments = An array of command arguments. <i>ppwcArguments</i>[0] equates to "dump".
///    dwArgCount = The number of elements in <i>ppwcArguments</i>.
///    pvData = A pointer to an arbitrary buffer of data specified by the parent context.
///Returns:
///    Returns NO_ERROR upon success. Any other return value indicates an error.
///    
alias NS_CONTEXT_DUMP_FN = uint function(const(wchar)* pwszRouter, char* ppwcArguments, uint dwArgCount, 
                                         void* pvData);
alias PNS_CONTEXT_DUMP_FN = uint function();
///The <b>NS_DLL_STOP_FN</b> command is the DLL stop function for helper DLLs. The DLL stop function provides an
///opportunity for helper DLLs to release any resources before being unloaded, and is registered in the RegisterContext
///function. The following is an example of a DLL stop function. Be aware that <b>SampleStop</b> is a placeholder for
///the application-defined function name.
///Params:
///    dwReserved = Reserved.
///Returns:
///    Returns NO_ERROR upon success. Any other return value indicates an error.
///    
alias NS_DLL_STOP_FN = uint function(uint dwReserved);
alias PNS_DLL_STOP_FN = uint function();
///The <b>NS_HELPER_START_FN</b> command is the start function for helpers. The start function provides an opportunity
///for helpers to register contexts and is registered in the RegisterContext function. The following is an example of a
///start function. Be aware that <b>SampleStartHelper</b> is a placeholder for the application-defined function name.
///Params:
///    pguidParent = The parent under which the helper DLL should be registered.
///    dwVersion = The version of the parent helper DLL.
///Returns:
///    Returns NO_ERROR upon success. Any other return value indicates an error.
///    
alias NS_HELPER_START_FN = uint function(const(GUID)* pguidParent, uint dwVersion);
alias PNS_HELPER_START_FN = uint function();
///The <b>NS_HELPER_STOP_FN</b> command is the stop function for helpers. This function enables helper contexts to
///release any resources before being unloaded, and is registered in the RegisterContext function. The following is an
///example of a stop function. Be aware that <b>SampleStopHelper</b> is a placeholder for the application-defined
///function name.
///Params:
///    dwReserved = Reserved.
///Returns:
///    Returns NO_ERROR upon success. Any other return value indicates an error.
///    
alias NS_HELPER_STOP_FN = uint function(uint dwReserved);
alias PNS_HELPER_STOP_FN = uint function();
///The <b>FN_HANDLE_CMD</b> command is the command function for helpers. Helpers expose commands through the
///<i>pTopCmds</i> and <i>pCmdGroups</i> parameters in the RegisterContext function. The following is an example of a
///command function. Be aware that <b>SampleCommand</b> is a placeholder for the application-defined function name.
///Params:
///    pwszMachine = The name of the computer on which to perform the command, or null if the command applies to the local computer.
///                  The default value is null. If the context uses a connect function, this argument can be ignored.
///    ppwcArguments = A set of command tokens.
///    dwCurrentIndex = The current index into <i>ppwcArguments</i> of the last token processed before the function was called.
///    dwArgCount = The number of arguments in the <i>ppwcArguments</i> parameter.
///    dwFlags = The command flags that pertain to the current state.
///    pvData = A data pointer. Value is null unless changed by a parent context <b>SubEntry</b> function.
///    pbDone = A set <i>pbDone</i> to <b>TRUE</b> before returning to instruct NetShell to terminate after the command function
///             completes. The <i>pbDone</i> parameter is set to <b>FALSE</b> by default.
///Returns:
///    Returns NO_ERROR upon success. Any other return value indicates an error.
///    
alias FN_HANDLE_CMD = uint function(const(wchar)* pwszMachine, char* ppwcArguments, uint dwCurrentIndex, 
                                    uint dwArgCount, uint dwFlags, void* pvData, int* pbDone);
alias PFN_HANDLE_CMD = uint function();
///The <b>NS_OSVERSIONCHECK</b> command is the operating system check function for helpers. This function can be called
///on a per-function basis, and verifies whether the associated function is supported on the specified operating system.
///This function is registered within the CMD_GROUP_ENTRY or CMD_ENTRY parameter of the RegisterContext function. The
///following is an example of an operating system check function. Be aware that <b>SampleOsVersionCheck</b> is a
///placeholder for the application-defined function name.
///Params:
///    CIMOSType = 
///    CIMOSProductSuite = 
///    CIMOSVersion = 
///    CIMOSBuildNumber = 
///    CIMServicePackMajorVersion = 
///    CIMServicePackMinorVersion = 
///    uiReserved = 
///    dwReserved = 
///Returns:
///    Returns <b>TRUE</b> of the command or group should be available, <b>FALSE</b> if the command or group should be
///    hidden.
///    
alias NS_OSVERSIONCHECK = BOOL function(uint CIMOSType, uint CIMOSProductSuite, const(wchar)* CIMOSVersion, 
                                        const(wchar)* CIMOSBuildNumber, const(wchar)* CIMServicePackMajorVersion, 
                                        const(wchar)* CIMServicePackMinorVersion, uint uiReserved, uint dwReserved);
alias PNS_OSVERSIONCHECK = BOOL function();
///The <b>InitHelperDll</b> function is called by NetShell to perform an initial loading of a helper.
///Params:
///    dwNetshVersion = The version of NetShell.
///    pReserved = Reserved for future use.
///Returns:
///    Returns NO_ERROR upon success. Any other return value indicates an error.
///    
alias NS_DLL_INIT_FN = uint function(uint dwNetshVersion, void* pReserved);
alias PNS_DLL_INIT_FN = uint function();

// Structs


struct TOKEN_VALUE
{
    const(wchar)* pwszToken;
    uint          dwValue;
}

///The <b>NS_HELPER_ATTRIBUTES</b> structure provides attributes of a helper.
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
    ///The GUID of the helper.
    GUID                guidHelper;
    ///A pointer to the NS_HELPER_START_FN entry point (the start function) of the helper.
    PNS_HELPER_START_FN pfnStart;
    ///A pointer to the NS_HELPER_STOP_FN entry point (the stop function) of the helper. Set to null if no stop function
    ///is implemented.
    PNS_HELPER_STOP_FN  pfnStop;
}

///The <b>CMD_ENTRY</b> structure defines a helper command.
struct CMD_ENTRY
{
    ///The token (name) for the command.
    const(wchar)*      pwszCmdToken;
    ///A function that handles the command. For more information, see FN_HANDLE_CMD.
    PFN_HANDLE_CMD     pfnCmdHandler;
    ///A short help message. This is the message identifier from the resource file of the helper DLL.
    uint               dwShortCmdHelpToken;
    ///The message to display if the command is followed only by a help token (HELP, /?, -?, or ?). This is the message
    ///identifier from the resource file of the helper DLL.
    uint               dwCmdHlpToken;
    ///The flags for the command. For more information, see Netshell Flags.
    uint               dwFlags;
    ///The operating system version check function. This is the function used to determine whether the command can be
    ///run on the operating system running on the local and/or remote context before invoking or displaying commands.
    ///For more information, see NS_OSVERSIONCHECK.
    PNS_OSVERSIONCHECK pOsVersionCheck;
}

///the <b>CMD_GROUP_ENTRY</b> structure defines a group of helper commands.
struct CMD_GROUP_ENTRY
{
    ///The token (name) for the command group
    const(wchar)*      pwszCmdGroupToken;
    ///A short help message.
    uint               dwShortCmdHelpToken;
    ///The number of elements in the command group.
    uint               ulCmdGroupSize;
    ///Flags. For more information, see NetShell Flags.
    uint               dwFlags;
    ///An array of CMD_ENTRY structures.
    CMD_ENTRY*         pCmdGroup;
    ///An operating system version check function. This is the function used to determine whether the command can be run
    ///on the operating system running on the local and/or remote context before invoking or displaying commands. For
    ///more information, see NS_OSVERSIONCHECK.
    PNS_OSVERSIONCHECK pOsVersionCheck;
}

///The <b>NS_CONTEXT_ATTRIBUTES</b> structure defines attributes of a context.
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
    ///A unicode string that identifies the new context. This string is the command available to users. The string must
    ///not contain spaces.
    const(wchar)*       pwszContext;
    ///A pointer to the GUID of this helper. Identical to the value passed to the RegisterHelper function as the
    ///<b>pguidHelper</b> member of the NS_HELPER_ATTRIBUTES structure.
    GUID                guidHelper;
    ///A set of flags that limit when this context is available. <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr>
    ///<td width="40%"><a id="CMD_FLAG_INTERACTIVE"></a><a id="cmd_flag_interactive"></a><dl>
    ///<dt><b>CMD_FLAG_INTERACTIVE</b></dt> </dl> </td> <td width="60%"> If set, context is available only when NetSh is
    ///run in interactive mode, but is not available to be passed to NetSh on the command line. </td> </tr> <tr> <td
    ///width="40%"><a id="CMD_FLAG_LOCAL"></a><a id="cmd_flag_local"></a><dl> <dt><b>CMD_FLAG_LOCAL</b></dt> </dl> </td>
    ///<td width="60%"> If set, the context is not valid from a remote computer. </td> </tr> <tr> <td width="40%"><a
    ///id="CMD_FLAG_ONLINE"></a><a id="cmd_flag_online"></a><dl> <dt><b>CMD_FLAG_ONLINE</b></dt> </dl> </td> <td
    ///width="60%"> If set, the context is not valid in offline mode. </td> </tr> <tr> <td width="40%"><a
    ///id="CMD_FLAG_PRIORITY"></a><a id="cmd_flag_priority"></a><dl> <dt><b>CMD_FLAG_PRIORITY</b></dt> </dl> </td> <td
    ///width="60%"> If set, the ulPriority field is used. </td> </tr> </table>
    uint                dwFlags;
    ///A priority value used when ordering dump and commit commands. Used only when the CMD_FLAG_PRIORITY flag is set in
    ///<b>dwFlags</b>. Default value is DEFAULT_CONTEXT_PRIORITY, defined as 100 in NetSh.h. Lower values indicate
    ///higher priority.
    uint                ulPriority;
    ///The number of entries in the <b>pTopCmds</b> member.
    uint                ulNumTopCmds;
    ///An array of CMD_ENTRY structures that contain helper commands.
    CMD_ENTRY*          pTopCmds;
    ///A number of entries in the <b>pCmdGroups</b> member.
    uint                ulNumGroups;
    ///An array of CMD_GROUP_ENTRY structures that contain helper command groups.
    CMD_GROUP_ENTRY*    pCmdGroups;
    ///A function called to commit changes from offline mode. Can be null. For more information about the commit
    ///function, see NS_CONTEXT_COMMIT_FN.
    PNS_CONTEXT_COMMIT_FN pfnCommitFn;
    ///A function called to dump the current configuration. Can be null. For more information about the dump function,
    ///see NS_CONTEXT_DUMP_FN.
    PNS_CONTEXT_DUMP_FN pfnDumpFn;
    ///A function called to connect to a remote computer, or to update the set of available commands. Can be null. For
    ///more information about the connect function, see NS_CONTEXT_CONNECT_FN.
    PNS_CONTEXT_CONNECT_FN pfnConnectFn;
    ///Reserved. Must be null.
    void*               pReserved;
    PNS_OSVERSIONCHECK  pfnOsVersionCheck;
}

///The <b>TAG_TYPE</b> structure specifies tags used for the PreprocessCommand function.
struct TAG_TYPE
{
    ///A tag string, in UNICODE.
    const(wchar)* pwszTag;
    ///Specifies whether the tag is required. <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="NS_REQ_ZERO"></a><a id="ns_req_zero"></a><dl> <dt><b>NS_REQ_ZERO</b></dt> </dl> </td> <td width="60%"> Tag is
    ///optional. </td> </tr> <tr> <td width="40%"><a id="NS_REQ_PRESENT"></a><a id="ns_req_present"></a><dl>
    ///<dt><b>NS_REQ_PRESENT</b></dt> </dl> </td> <td width="60%"> Tag must be present. </td> </tr> <tr> <td
    ///width="40%"><a id="NS_REQ_ALLOW_MULTIPLE"></a><a id="ns_req_allow_multiple"></a><dl>
    ///<dt><b>NS_REQ_ALLOW_MULTIPLE</b></dt> </dl> </td> <td width="60%"> Multiple copies of the tag is allowed. </td>
    ///</tr> <tr> <td width="40%"><a id="NS_REQ_ONE_OR_MORE"></a><a id="ns_req_one_or_more"></a><dl>
    ///<dt><b>NS_REQ_ONE_OR_MORE</b></dt> </dl> </td> <td width="60%"> Multiple copies of the tag is allowed. Tag must
    ///be present. </td> </tr> </table>
    uint          dwRequired;
    ///This value specifies whether the tag is present. <b>TRUE</b> indicates the tag is present.
    BOOL          bPresent;
}

// Functions

///The <b>MatchEnumTag</b> function searches a table of legal values to find a value that matches a specific token. The
///<b>MatchEnumTag</b> function is typically called by a command function when an argument is specified that has an
///enumerated set of possible values.
///Params:
///    hModule = Reserved. Set to null.
///    pwcArg = A token to match. The <i>pwcArg</i> parameter is usually an entry in the <i>ppwcArguments</i> array passed into
///             the FN_HANDLE_CMD function exposed by the helper (the command function).
///    dwNumArg = The number of entries in the <i>pEnumTable</i> array.
///    pEnumTable = An array of token:value pairs.
///    pdwValue = Upon success, the <i>pdwValue</i> parameter is filled with the value associated with the token in the
///               <i>pEnumTable</i> array.
@DllImport("NETSH")
uint MatchEnumTag(HANDLE hModule, const(wchar)* pwcArg, uint dwNumArg, const(TOKEN_VALUE)* pEnumTable, 
                  uint* pdwValue);

///The <b>MatchToken</b> function determines whether a user-entered string matches a specific string. A match exists if
///the user-entered string is a case-insensitive prefix of the specific string.
///Params:
///    pwszUserToken = A string entered by the user.
///    pwszCmdToken = A string against which to check for a match.
///Returns:
///    Returns <b>TRUE</b> if there is a match, <b>FALSE</b> if not.
///    
@DllImport("NETSH")
BOOL MatchToken(const(wchar)* pwszUserToken, const(wchar)* pwszCmdToken);

///The <b>PreprocessCommand</b> function parses an argument string and verifies that all required tags are present.
///Params:
///    hModule = Reserved. Set to null.
///    ppwcArguments = The arguments passed to FN_HANDLE_CMD (the command function) as its <i>ppwcArguments</i> parameter.
///    dwCurrentIndex = A value that specifies the first argument to process, such that <i>ppwcArguments</i>[<i>dwCurrentIndex</i>] is
///                     the first.
///    dwArgCount = The argument count passed as the <i>dwArgCount</i> parameter.
///    pttTags = An array of tags of type <b>TAG_TYPE</b>.
///    dwTagCount = A number of entries in the <i>pttTags</i> array.
///    dwMinArgs = The minimum number of arguments required for this command.
///    dwMaxArgs = The maximum number of arguments allowed for this command.
///    pdwTagType = An array of <b>DWORD</b>s, with at least enough space for a number of entries equal to <i>dwArgCount</i> -
///                 <i>dwCurrentIndex</i>. Each <b>DWORD</b> contains the array index number in the <i>pttTags</i> array to which the
///                 array index number in the <i>ppwcArguments</i> array is matched. For example, if <i>ppwcArguments</i>[0] is
///                 matched to <i>pttTags</i>[2], <i>pdwTagType</i>[0] is 2.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NO_ERROR</b></dt>
///    </dl> </td> <td width="60%"> The function completed successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_SYNTAX</b></dt> </dl> </td> <td width="60%"> Invalid syntax. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_TAG_ALREADY_PRESENT</b></dt> </dl> </td> <td width="60%"> The tag is already
///    present. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> An invalid parameter was entered. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_OPTION_TAG</b></dt> </dl> </td> <td width="60%"> An invalid option tag. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory
///    available to carry out the command. </td> </tr> </table> <div> </div>
///    
@DllImport("NETSH")
uint PreprocessCommand(HANDLE hModule, char* ppwcArguments, uint dwCurrentIndex, uint dwArgCount, char* pttTags, 
                       uint dwTagCount, uint dwMinArgs, uint dwMaxArgs, char* pdwTagType);

///The <b>PrintError</b> function displays a system or application error message to the NetShell console.
///Params:
///    hModule = A handle to the module from which the string should be loaded, or null for system error messages.
///    dwErrId = The identifier of the message to print.
///    arg3 = The arguments used to fill into the message.
///Returns:
///    Returns the number of characters printed. Returns zero upon failure.
///    
@DllImport("NETSH")
uint PrintError(HANDLE hModule, uint dwErrId);

///The <b>PrintMessageFromModule</b> function displays localized output to the NetShell console.
///Params:
///    hModule = A handle to the module from which the string should be loaded.
///    dwMsgId = The identifier of the message to print.
///    arg3 = The arguments to fill into the message.
///Returns:
///    Returns the number of characters printed. Returns zero upon failure.
///    
@DllImport("NETSH")
uint PrintMessageFromModule(HANDLE hModule, uint dwMsgId);

///The <b>PrintMessage</b> function displays output to the NetShell console.
///Params:
///    pwszFormat = A string to be output to the NetShell console.
///    arg2 = The arguments used to fill into the message.
///Returns:
///    Returns the number of characters printed. Returns zero upon failure.
///    
@DllImport("NETSH")
uint PrintMessage(const(wchar)* pwszFormat);

///The <b>RegisterContext</b> function registers a helper context with NetShell. The <b>RegisterContext</b> function
///should be called from the NS_HELPER_START_FN entry point (the start function) passed to the RegisterHelper function
///in the <b>pfnStart</b> member of the NS_CONTEXT_ATTRIBUTES structure passed in its <i>pChildAttributes</i> parameter.
///Params:
///    pChildContext = Attributes of the context to register.
@DllImport("NETSH")
uint RegisterContext(const(NS_CONTEXT_ATTRIBUTES)* pChildContext);

///The <b>RegisterHelper</b> function is called from within a helper's exposed InitHelperDll function, and registers the
///helper with the NetShell context.
///Params:
///    pguidParentContext = A pointer to GUID of another helper under which the helper should be installed. If null, the helper is installed
///                         as a top-level helper.
///    pfnRegisterSubContext = Attributes of the helper.
@DllImport("NETSH")
uint RegisterHelper(const(GUID)* pguidParentContext, const(NS_HELPER_ATTRIBUTES)* pfnRegisterSubContext);


