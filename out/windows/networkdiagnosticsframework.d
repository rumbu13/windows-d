// Written in the D programming language.

module windows.networkdiagnosticsframework;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.networkdrivers : SOCKET_ADDRESS_LIST;
public import windows.security : SID;
public import windows.systemservices : BOOL;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


// Enums


///The <b>ATTRIBUTE_TYPE</b> enumeration defines possible values for a helper attribute.
alias ATTRIBUTE_TYPE = int;
enum : int
{
    ///An invalid attribute.
    AT_INVALID      = 0x00000000,
    ///A true or false value.
    AT_BOOLEAN      = 0x00000001,
    ///An 8-bit signed integer.
    AT_INT8         = 0x00000002,
    ///An 8-bit unsigned integer.
    AT_UINT8        = 0x00000003,
    ///A 16-bit signed integer.
    AT_INT16        = 0x00000004,
    ///A 16-bit unsigned integer.
    AT_UINT16       = 0x00000005,
    ///A 32-bit signed integer.
    AT_INT32        = 0x00000006,
    ///A 32-bit unsigned integer.
    AT_UINT32       = 0x00000007,
    ///A 64-bit signed integer.
    AT_INT64        = 0x00000008,
    ///A 64-bit unsigned integer.
    AT_UINT64       = 0x00000009,
    ///A string.
    AT_STRING       = 0x0000000a,
    ///A GUID structure.
    AT_GUID         = 0x0000000b,
    ///A LifeTime structure.
    AT_LIFE_TIME    = 0x0000000c,
    ///An IPv4 or IPv6 address.
    AT_SOCKADDR     = 0x0000000d,
    AT_OCTET_STRING = 0x0000000e,
}

///The <b>REPAIR_SCOPE</b> enumeration describes the scope of modification for a given repair.
alias REPAIR_SCOPE = int;
enum : int
{
    ///The repair effect is system-wide.
    RS_SYSTEM      = 0x00000000,
    ///The repair effect is user-specific.
    RS_USER        = 0x00000001,
    ///The repair effect is application-specific.
    RS_APPLICATION = 0x00000002,
    RS_PROCESS     = 0x00000003,
}

///The <b>REPAIR_RISK</b> enumeration specifies whether repair changes are persistent and whether they can be undone.
alias REPAIR_RISK = int;
enum : int
{
    ///The repair performs persistent changes that cannot be undone.
    RR_NOROLLBACK = 0x00000000,
    ///The repair performs persistent changes that can be undone.
    RR_ROLLBACK   = 0x00000001,
    RR_NORISK     = 0x00000002,
}

///The <b>UI_INFO_TYPE</b> enumeration identifies repairs that perform user interface tasks.
alias UI_INFO_TYPE = int;
enum : int
{
    UIT_INVALID       = 0x00000000,
    ///No additional repair interfaces are present.
    UIT_NONE          = 0x00000001,
    ///Execute shell command.
    UIT_SHELL_COMMAND = 0x00000002,
    ///Launch help pane.
    UIT_HELP_PANE     = 0x00000003,
    UIT_DUI           = 0x00000004,
}

///The <b>DIAGNOSIS_STATUS</b> enumeration describes the result of a hypothesis submitted to a helper class in which the
///health of a component has been determined.
alias DIAGNOSIS_STATUS = int;
enum : int
{
    ///A helper class is not implemented
    DS_NOT_IMPLEMENTED = 0x00000000,
    ///The helper class has confirmed a problem existing in its component.
    DS_CONFIRMED       = 0x00000001,
    ///The helper class has determined that no problem exists.
    DS_REJECTED        = 0x00000002,
    ///The helper class is unable to determine whether there is a problem.
    DS_INDETERMINATE   = 0x00000003,
    ///The helper class is unable to perform the diagnosis at this time.
    DS_DEFERRED        = 0x00000004,
    DS_PASSTHROUGH     = 0x00000005,
}

///The <b>REPAIR_STATUS</b> enumeration describes the result of a helper class attempting a repair option.
alias REPAIR_STATUS = int;
enum : int
{
    ///The helper class does not have a repair option implemented.
    RS_NOT_IMPLEMENTED = 0x00000000,
    ///The helper class has repaired a problem.
    RS_REPAIRED        = 0x00000001,
    ///The helper class has attempted to repair a problem but validation indicates the repair operation has not
    ///succeeded.
    RS_UNREPAIRED      = 0x00000002,
    ///The helper class is unable to perform the repair at this time.
    RS_DEFERRED        = 0x00000003,
    RS_USER_ACTION     = 0x00000004,
}

///The <b>PROBLEM_TYPE</b> enumeration describes the type of problem a helper class indicates is present.
alias PROBLEM_TYPE = int;
enum : int
{
    PT_INVALID               = 0x00000000,
    ///A low-health problem exists within the component itself. No problems were found within local components on which
    ///this component depends.
    PT_LOW_HEALTH            = 0x00000001,
    ///A low-health problem exists within local components on which this component depends.
    PT_LOWER_HEALTH          = 0x00000002,
    ///The low-health problem is in the out-of-box components this component depends on.
    PT_DOWN_STREAM_HEALTH    = 0x00000004,
    ///The component's resource is being highly utilized. No high utilization was found within local components on which
    ///this component depends.
    PT_HIGH_UTILIZATION      = 0x00000008,
    ///The causes of the component's high-utilization problem are from local components that depend on it.
    PT_HIGHER_UTILIZATION    = 0x00000010,
    PT_UP_STREAM_UTILIZATION = 0x00000020,
}

// Structs


///The <b>OCTET_STRING</b> structure contains a pointer to a string of byte data.
struct OCTET_STRING
{
    ///Type: <b>DWORD</b> The length of the data.
    uint   dwLength;
    ubyte* lpValue;
}

///The <b>LIFE_TIME</b> structure contains a start time and an end time.
struct LIFE_TIME
{
    ///Type: <b>FILETIME</b> The time the problem instance began.
    FILETIME startTime;
    FILETIME endTime;
}

///The <b>DIAG_SOCKADDR</b> structure stores an Internet Protocol (IP) address for a computer that is participating in a
///Windows Sockets communication.
struct DIAG_SOCKADDR
{
    ///Type: <b>USHORT</b> Socket address group.
    ushort    family;
    ///Type: <b>CHAR[126]</b> The maximum size of all the different socket address structures.
    byte[126] data;
}

///The <b>HELPER_ATTRIBUTE</b> structure contains all NDF supported data types.
struct HELPER_ATTRIBUTE
{
    ///Type: <b>[string] LPWSTR</b> A pointer to a null-terminated string that contains the name of the attribute.
    const(wchar)*  pwszName;
    ///Type: <b>ATTRIBUTE_TYPE</b> The type of helper attribute.
    ATTRIBUTE_TYPE type;
    union
    {
        BOOL          Boolean;
        byte          Char;
        ubyte         Byte;
        short         Short;
        ushort        Word;
        int           Int;
        uint          DWord;
        long          Int64;
        ulong         UInt64;
        const(wchar)* PWStr;
        GUID          Guid;
        LIFE_TIME     LifeTime;
        DIAG_SOCKADDR Address;
        OCTET_STRING  OctetString;
    }
}

///The <b>ShellCommandInfo</b> structure contains data required to launch an additional application for manual repair
///options.
struct ShellCommandInfo
{
    ///Type: <b>[string] LPWSTR</b> A pointer to a null-terminated string that contains the action to be performed. The
    ///set of available verbs that specifies the action depends on the particular file or folder. Generally, the actions
    ///available from an object's shortcut menu are available verbs. For more information, see the Remarks section.
    const(wchar)* pwszOperation;
    ///Type: <b>[string] LPWSTR</b> A pointer to a null-terminated string that specifies the file or object on which to
    ///execute the specified verb. To specify a Shell namespace object, pass the fully qualified parse name. Note that
    ///not all verbs are supported on all objects. For example, not all document types support the "print" verb.
    const(wchar)* pwszFile;
    ///Type: <b>[string] LPWSTR</b> A pointer to a null-terminated strings that specifies the parameters to be passed to
    ///the application, only if the <i>pwszFile</i> parameter specifies an executable file. The format of this string is
    ///determined by the verb that is to be invoked. If <i>pwszFile</i> specifies a document file, <i>pwszParameters</i>
    ///should be <b>NULL</b>.
    const(wchar)* pwszParameters;
    ///Type: <b>[string] LPWSTR</b> A pointer to a null-terminated string that specifies the default directory.
    const(wchar)* pwszDirectory;
    ///Type: <b>ULONG</b> Flags that specify how an application is to be displayed when it is opened. If <i>pwszFile</i>
    ///specifies a document file, the flag is simply passed to the associated application. It is up to the application
    ///to decide how to handle it.
    uint          nShowCmd;
}

///The <b>UiInfo</b> structure is used to display repair messages to the user.
struct UiInfo
{
    ///Type: <b>UI_INFO_TYPE</b> The type of user interface (UI) to use. This can be one of the values shown in the
    ///following members.
    UI_INFO_TYPE type;
    union
    {
        const(wchar)*    pwzNull;
        ShellCommandInfo ShellInfo;
        const(wchar)*    pwzHelpUrl;
        const(wchar)*    pwzDui;
    }
}

///The <b>RepairInfo</b> structure contains data required for a particular repair option.
struct RepairInfo
{
    ///A unique GUID for this repair.
    GUID          guid;
    ///A pointer to a null-terminated string that contains the helper class name in a user-friendly way.
    const(wchar)* pwszClassName;
    ///A pointer to a null-terminated string that describes the repair in a user friendly way.
    const(wchar)* pwszDescription;
    ///One of the WELL_KNOWN_SID_TYPE if the repair requires certain user contexts or privileges.
    uint          sidType;
    ///The number of seconds required to perform the repair.
    int           cost;
    ///Additional information about the repair. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="RF_WORKAROUND"></a><a id="rf_workaround"></a><dl> <dt><b>RF_WORKAROUND</b></dt> </dl> </td>
    ///<td width="60%"> Indicates that the repair is a workaround for the issue. For example, sometimes resetting a
    ///network interface solves intermittent problems, but does not directly address a specific issue, so it is
    ///considered a workaround. NDF will show non-workarounds to the user before workarounds. </td> </tr> <tr> <td
    ///width="40%"><a id="RF_USER_ACTION"></a><a id="rf_user_action"></a><dl> <dt><b>RF_USER_ACTION</b></dt> </dl> </td>
    ///<td width="60%"> Indicates that the repair prompts the user to perform a manual task outside of NDF. </td> </tr>
    ///<tr> <td width="40%"><a id="RF_USER_CONFIRMATION"></a><a id="rf_user_confirmation"></a><dl>
    ///<dt><b>RF_USER_CONFIRMATION</b></dt> </dl> </td> <td width="60%"> Indicates that the repair should not be
    ///automatically performed. The user is instead prompted to select the repair. </td> </tr> <tr> <td width="40%"><a
    ///id="RF_INFORMATION_ONLY"></a><a id="rf_information_only"></a><dl> <dt><b>RF_INFORMATION_ONLY</b></dt> </dl> </td>
    ///<td width="60%"> Indicates that the repair consists of actionable information for the user. Repair and validation
    ///sessions do not occur for information-only repairs. </td> </tr> <tr> <td width="40%"><a
    ///id="RF_VALIDATE_HELPTOPIC"></a><a id="rf_validate_helptopic"></a><dl> <dt><b>RF_VALIDATE_HELPTOPIC</b></dt> </dl>
    ///</td> <td width="60%"> Indicates that the repair provides information to the user as well as a help topic. Unlike
    ///<b>RF_INFORMATION_ONLY</b> repairs, which cannot be validated, this repair can be executed and validated within a
    ///diagnostic session. <div class="alert"><b>Note</b> Available only in Windows 7, Windows Server 2008 R2, and
    ///later.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a id="RF_REPRO"></a><a id="rf_repro"></a><dl>
    ///<dt><b>RF_REPRO</b></dt> </dl> </td> <td width="60%"> Indicates that the repair prompts the user to reproduce
    ///their problem. At the same time, the helper class may have enabled more detailed logging or other background
    ///mechanisms to help detect the failure. <div class="alert"><b>Note</b> Available only in Windows 7, Windows Server
    ///2008 R2, and later.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a id="RF_CONTACT_ADMIN"></a><a
    ///id="rf_contact_admin"></a><dl> <dt><b>RF_CONTACT_ADMIN</b></dt> </dl> </td> <td width="60%"> Indicates that the
    ///repair prompts the user to contact their network administrator in order to resolve the problem. <div
    ///class="alert"><b>Note</b> Available only in Windows 7, Windows Server 2008 R2, and later.</div> <div> </div>
    ///</td> </tr> <tr> <td width="40%"><a id="RF_RESERVED"></a><a id="rf_reserved"></a><dl> <dt><b>RF_RESERVED</b></dt>
    ///</dl> </td> <td width="60%"> Reserved for system use. <div class="alert"><b>Note</b> Available only in Windows 7,
    ///Windows Server 2008 R2, and later.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
    ///id="RF_RESERVED_CA"></a><a id="rf_reserved_ca"></a><dl> <dt><b>RF_RESERVED_CA</b></dt> </dl> </td> <td
    ///width="60%"> Reserved for system use. <div class="alert"><b>Note</b> Available only in Windows 7, Windows Server
    ///2008 R2, and later.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a id="RF_RESERVED_LNI"></a><a
    ///id="rf_reserved_lni"></a><dl> <dt><b>RF_RESERVED_LNI</b></dt> </dl> </td> <td width="60%"> Reserved for system
    ///use. <div class="alert"><b>Note</b> Available only in Windows 7, Windows Server 2008 R2, and later.</div> <div>
    ///</div> </td> </tr> </table>
    uint          flags;
    ///Reserved for future use.
    REPAIR_SCOPE  scope_;
    ///Reserved for future use.
    REPAIR_RISK   risk;
    ///A UiInfo structure.
    UiInfo        UiInfo90;
    int           rootCauseIndex;
}

///Contains detailed repair information that can be used to help resolve the root cause of an incident.
struct RepairInfoEx
{
    ///Type: <b>RepairInfo</b> The detailed repair information.
    RepairInfo repair;
    ///Type: <b>USHORT</b> The rank of the repair, relative to other repairs in the RootCauseInfo structure associated
    ///with the incident. A repair with rank 1 is expected to be more relevant to the problem and thus will be the first
    ///repair to be attempted. The success of any individual repair is not guaranteed, regardless of its rank.
    ushort     repairRank;
}

///Contains detailed information about the root cause of an incident.
struct RootCauseInfo
{
    ///Type: <b>LPWSTR</b> A string that describes the problem that caused the incident.
    const(wchar)* pwszDescription;
    ///Type: <b>GUID</b> The GUID that corresponds to the problem identified.
    GUID          rootCauseID;
    ///Type: <b>DWORD</b> A numeric value that provides more information about the problem. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="RCF_ISLEAF"></a><a id="rcf_isleaf"></a><dl>
    ///<dt><b>RCF_ISLEAF</b></dt> <dt>0x1</dt> </dl> </td> <td width="60%"> The root cause corresponds to a leaf in the
    ///diagnostics tree. Root causes that are leafs are more likely to be closer to the problem that the user is trying
    ///to diagnose. </td> </tr> <tr> <td width="40%"><a id="RCF_ISCONFIRMED"></a><a id="rcf_isconfirmed"></a><dl>
    ///<dt><b>RCF_ISCONFIRMED</b></dt> <dt>0x2</dt> </dl> </td> <td width="60%"> The root cause corresponds to a node
    ///with a DIAGNOSIS_STATUS value of <b>DS_CONFIRMED</b>. Problems with confirmed low health are more likely to
    ///correspond to the problem the user is trying to diagnose. </td> </tr> <tr> <td width="40%"><a
    ///id="RCF_ISTHIRDPARTY"></a><a id="rcf_isthirdparty"></a><dl> <dt><b>RCF_ISTHIRDPARTY</b></dt> <dt>0x4</dt> </dl>
    ///</td> <td width="60%"> The root cause comes from a third-party helper class extension rather than a native
    ///Windows helper class. </td> </tr> </table>
    uint          rootCauseFlags;
    ///Type: <b>GUID</b> GUID of the network interface on which the problem occurred. If the problem is not
    ///interface-specific, this value is zero (0).
    GUID          networkInterfaceID;
    ///Type: <b>RepairInfoEx*</b> The repairs that are available to try and fix the problem.
    RepairInfoEx* pRepairs;
    ///Type: <b>USHORT</b> The number of repairs available.
    ushort        repairCount;
}

///The <b>HYPOTHESIS</b> structure contains data used to submit a hypothesis to NDF for another helper class. The name
///of the helper class, the number of parameters that the helper class requires, and the parameters to pass to the
///helper class are contained in this structure.
struct HYPOTHESIS
{
    ///Type: <b>[string] LPWSTR</b> A pointer to a null-terminated string that contains the name of the helper class.
    const(wchar)*     pwszClassName;
    ///Type: <b>[string] LPWSTR</b> A pointer to a null-terminated string that contains a user-friendly description of
    ///the data being passed to the helper class..
    const(wchar)*     pwszDescription;
    ///Type: <b>ULONG</b> The count of attributes in this hypothesis.
    uint              celt;
    ///Type: <b>[size_is(celt)]PHELPER_ATTRIBUTE[ ]</b> A pointer to an array of HELPER_ATTRIBUTE structures that
    ///contains key attributes for this hypothesis.
    HELPER_ATTRIBUTE* rgAttributes;
}

///The <b>HelperAttributeInfo</b> structure contains the name of the helper attribute and its type.
struct HelperAttributeInfo
{
    ///Type: <b>[string] LPWSTR</b> Pointer to a null-terminated string that contains the name of the helper attribute.
    const(wchar)*  pwszName;
    ///Type: <b>ATTRIBUTE_TYPE</b> The type of helper attribute.
    ATTRIBUTE_TYPE type;
}

///The <b>DiagnosticsInfo</b> structure contains the estimate of diagnosis time, and flags for invocation.
struct DiagnosticsInfo
{
    ///Type: <b>long</b> The length of time, in seconds, that the diagnosis should take to complete. A value of zero or
    ///a negative value means the cost is negligible. Any positive value will cause the engine to adjust the overall
    ///diagnostics process.
    int  cost;
    uint flags;
}

///The <b>HypothesisResult</b> structure contains information about a hypothesis returned from a helper class. The
///hypothesis is obtained via a call to GetLowerHypotheses.
struct HypothesisResult
{
    ///Type: <b>HYPOTHESIS</b> Information for a specific hypothesis.
    HYPOTHESIS       hypothesis;
    ///Type: <b>DIAGNOSIS_STATUS</b> The status of the child helper class and its children. If the hypothesis or any of
    ///its children indicated <b>DS_CONFIRMED</b> in a call to LowHealth, then this value will be <b>DS_CONFIRMED</b>.
    ///If no problems exist in such a call, the value will be <b>DS_REJECTED</b>. The value will be
    ///<b>DS_INDETERMINATE</b> if the health of the component is not clear.
    DIAGNOSIS_STATUS pathStatus;
}

// Functions

///The <b>NdfCreateIncident</b> function is used internally by application developers to test the NDF functionality
///incorporated into their application.
///Params:
///    helperClassName = Type: <b>LPCWSTR</b> The name of the helper class to be used in the diagnoses of the incident.
///    celt = Type: <b>ULONG</b> A count of elements in the attributes array.
///    attributes = Type: <b>HELPER_ATTRIBUTE*</b> The applicable HELPER_ATTRIBUTE structure.
///    handle = Type: <b>NDFHANDLE*</b> A handle to the Network Diagnostics Framework incident.
///Returns:
///    Type: <b>HRESULT</b> Possible return values include, but are not limited to, the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
///    width="60%"> The operation succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory available to complete this operation. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>NDF_E_BAD_PARAM</b></dt> </dl> </td> <td width="60%"> One or more parameters are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> NDF_E_NOHELPERCLASS</b></dt> </dl> </td> <td width="60%">
///    <i>helperClassName</i> is <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("NDFAPI")
HRESULT NdfCreateIncident(const(wchar)* helperClassName, uint celt, char* attributes, void** handle);

///The <b>NdfCreateWinSockIncident</b> function provides access to the Winsock Helper Class provided by Microsoft.
///Params:
///    sock = Type: <b>SOCKET</b> A descriptor identifying a connected socket.
///    host = Type: <b>LPCWSTR</b> A pointer to the local host.
///    port = Type: <b>USHORT</b> The port providing Winsock access.
///    appId = Type: <b>LPCWSTR</b> Unique identifier associated with the application.
///    userId = Type: <b>SID*</b> Unique identifier associated with the user.
///    handle = Type: <b>NDFHANDLE*</b> Handle to the Network Diagnostics Framework incident.
///Returns:
///    Type: <b>HRESULT</b> Possible return values include, but are not limited to, the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
///    width="60%"> The operation succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> There is not enough memory available to complete this operation. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>NDF_E_BAD_PARAM</b></dt> </dl> </td> <td width="60%"> One or more parameters are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or
///    more parameters are invalid. </td> </tr> </table>
///    
@DllImport("NDFAPI")
HRESULT NdfCreateWinSockIncident(size_t sock, const(wchar)* host, ushort port, const(wchar)* appId, SID* userId, 
                                 void** handle);

///The <b>NdfCreateWebIncident</b> function diagnoses web connectivity problems concerning a specific URL.
///Params:
///    url = Type: <b>LPCWSTR</b> The URL with which there is a connectivity issue.
///    handle = Type: <b>NDFHANDLE*</b> Handle to the Network Diagnostics Framework incident.
@DllImport("NDFAPI")
HRESULT NdfCreateWebIncident(const(wchar)* url, void** handle);

///The <b>NdfCreateWebIncidentEx</b> function diagnoses web connectivity problems concerning a specific URL. This
///function allows for more control over the underlying diagnosis than the NdfCreateWebIncident function.
///Params:
///    url = Type: <b>LPCWSTR</b> The URL with which there is a connectivity issue.
///    useWinHTTP = Type: <b>BOOL</b> <b>TRUE</b> if diagnosis will be performed using the WinHTTP APIs; <b>FALSE</b> if the WinInet
///                 APIs will be used.
///    moduleName = Type: <b>LPWSTR</b> The module name to use when checking against application-specific filtering rules (for
///                 example, "C:\Program Files\Internet Explorer\iexplorer.exe"). If <b>NULL</b>, the value is autodetected during
///                 the diagnosis.
///    handle = Type: <b>NDFHANDLE*</b> Handle to the Network Diagnostics Framework incident.
///Returns:
///    Type: <b>HRESULT</b> Possible return values include, but are not limited to, the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
///    width="60%"> The operation succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ABORT</b></dt> </dl> </td>
///    <td width="60%"> The underlying diagnosis or repair operation has been canceled. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory available
///    to complete this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NDF_E_BAD_PARAM</b></dt> </dl> </td>
///    <td width="60%"> One or more parameters are invalid. </td> </tr> </table>
///    
@DllImport("NDFAPI")
HRESULT NdfCreateWebIncidentEx(const(wchar)* url, BOOL useWinHTTP, const(wchar)* moduleName, void** handle);

///The <b>NdfCreateSharingIncident</b> function diagnoses network problems in accessing a specific network share.
///Params:
///    UNCPath = Type: <b>LPCWSTR</b> The full UNC string (for example, "\\server\folder\file.ext") for the shared asset with
///              which there is a connectivity issue.
///    handle = Type: <b>NDFHANDLE*</b> Handle to the Network Diagnostics Framework incident.
@DllImport("NDFAPI")
HRESULT NdfCreateSharingIncident(const(wchar)* UNCPath, void** handle);

///The <b>NdfCreateDNSIncident</b> function diagnoses name resolution issues in resolving a specific host name.
///Params:
///    hostname = Type: <b>LPCWSTR</b> The host name with which there is a name resolution issue.
///    queryType = Type: <b>WORD</b> The numeric representation of the type of record that was queried when the issue occurred. For
///                more information and a complete listing of record set types and their numeric representations, see the windns.h
///                header file. This parameter should be set to <b>DNS_TYPE_ZERO</b> for generic DNS resolution diagnosis.
///    handle = Type: <b>NDFHANDLE*</b> Handle to the Network Diagnostics Framework incident.
@DllImport("NDFAPI")
HRESULT NdfCreateDNSIncident(const(wchar)* hostname, ushort queryType, void** handle);

///The <b>NdfCreateConnectivityIncident</b> function diagnoses generic Internet connectivity problems.
///Params:
///    handle = Type: <b>NDFHANDLE*</b> Handle to the Network Diagnostics Framework incident.
@DllImport("NDFAPI")
HRESULT NdfCreateConnectivityIncident(void** handle);

///The <b>NdfCreateNetConnectionIncident</b> function diagnoses connectivity issues using the NetConnection helper
///class.
///Params:
///    handle = Type: <b>NDFHANDLE*</b> Handle to the Network Diagnostics Framework incident.
///    id = Type: <b>GUID</b> Identifier of the network interface that the caller would like to create the incident for. The
///         NULL GUID {00000000-0000-0000-0000-000000000000} may be used if the caller does not want to specify an interface.
///         The system will attempt to determine the most appropriate interface based on the current state of the system.
@DllImport("NDFAPI")
HRESULT NdfCreateNetConnectionIncident(void** handle, GUID id);

///The <b>NdfCreatePnrpIncident</b> function creates a session to diagnose issues with the Peer Name Resolution Protocol
///(PNRP) service.
///Params:
///    cloudname = Type: <b>LPCWSTR</b> The name of the cloud to be diagnosed.
///    peername = Type: <b>LPCWSTR</b> Optional name of a peer node which PNRP can attempt to resolve. The results will be used to
///               help diagnose any problems.
///    diagnosePublish = Type: <b>BOOL</b> Specifies whether the helper class should verify that the node can publish IDs. If
///                      <b>FALSE</b>, this diagnostic step will be skipped.
///    appId = Type: <b>LPCWSTR</b> Application ID for the calling application.
///    handle = Type: <b>NDFHANDLE*</b> Handle to the Network Diagnostics Framework incident.
///Returns:
///    Type: <b>HRESULT</b> Possible return values include, but are not limited to, the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
///    width="60%"> The operation succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NDF_E_BAD_PARAM</b></dt>
///    </dl> </td> <td width="60%"> One or more parameters has not been provided correctly. </td> </tr> </table>
///    
@DllImport("NDFAPI")
HRESULT NdfCreatePnrpIncident(const(wchar)* cloudname, const(wchar)* peername, BOOL diagnosePublish, 
                              const(wchar)* appId, void** handle);

///The <b>NdfCreateGroupingIncident</b> function creates a session to diagnose peer-to-peer grouping functionality
///issues.
///Params:
///    CloudName = Type: <b>LPCWSTR</b> The name of the Peer Name Resolution Protocol (PNRP) cloud where the group is created. If
///                <b>NULL</b>, the session will not attempt to diagnose issues related to PNRP.
///    GroupName = Type: <b>LPCWSTR</b> The name of the group to be diagnosed. If <b>NULL</b>, the session will not attempt to
///                diagnose issues related to group availability.
///    Identity = Type: <b>LPCWSTR</b> The identity that a peer uses to access the group. If <b>NULL</b>, the session will not
///               attempt to diagnose issues related to the group's ability to register in PNRP.
///    Invitation = Type: <b>LPCWSTR</b> An XML invitation granted by another peer. An invitation is created when the inviting peer
///                 calls PeerGroupCreateInvitation or PeerGroupIssueCredentials. If this value is present, the invitation will be
///                 checked to ensure its format and expiration are valid.
///    Addresses = Type: <b>SOCKET_ADDRESS_LIST*</b> Optional list of addresses of the peers to which the application is trying to
///                connect. If this parameter is used, the helper class will diagnose connectivity to these addresses.
///    appId = Type: <b>LPCWSTR</b> Application ID for the calling application.
///    handle = Type: <b>NDFHANDLE*</b> Handle to the Network Diagnostics Framework incident.
///Returns:
///    Type: <b>HRESULT</b> Possible return values include, but are not limited to, the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
///    width="60%"> The operation succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NDF_E_BAD_PARAM</b></dt>
///    </dl> </td> <td width="60%"> One or more parameters has not been provided correctly. </td> </tr> </table>
///    
@DllImport("NDFAPI")
HRESULT NdfCreateGroupingIncident(const(wchar)* CloudName, const(wchar)* GroupName, const(wchar)* Identity, 
                                  const(wchar)* Invitation, SOCKET_ADDRESS_LIST* Addresses, const(wchar)* appId, 
                                  void** handle);

///The <b>NdfExecuteDiagnosis</b> function is used to diagnose the root cause of the incident that has occurred.
///Params:
///    handle = Type: <b>NDFHANDLE</b> Handle to the Network Diagnostics Framework incident.
///    hwnd = Type: <b>HWND</b> Handle to the window that is intended to display the diagnostic information. If specified, the
///           NDF UI is modal to the window. If <b>NULL</b>, the UI is non-modal.
///Returns:
///    Type: <b>HRESULT</b> Possible return values include, but are not limited to, the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
///    width="60%"> The operation succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td>
///    <td width="60%"> <i>handle</i> is invalid. </td> </tr> </table>
///    
@DllImport("NDFAPI")
HRESULT NdfExecuteDiagnosis(void* handle, HWND hwnd);

///The <b>NdfCloseIncident</b> function is used to close an Network Diagnostics Framework (NDF) incident following its
///resolution.
///Params:
///    handle = Type: <b>NDFHANDLE</b> Handle to the NDF incident that is being closed.
///Returns:
///    Type: <b>HRESULT</b> Possible return values include, but are not limited to, the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
///    width="60%"> The operation succeeded. </td> </tr> </table>
///    
@DllImport("NDFAPI")
HRESULT NdfCloseIncident(void* handle);

///The <b>NdfDiagnoseIncident</b> function diagnoses the root cause of an incident without displaying a user interface.
///Params:
///    Handle = Type: <b>NDFHANDLE</b> A handle to the Network Diagnostics Framework incident.
///    RootCauseCount = Type: <b>ULONG*</b> The number of root causes that could potentially have caused this incident. If diagnosis does
///                     not succeed, the contents of this parameter should be ignored.
///    RootCauses = Type: <b>RootCauseInfo**</b> A collection of RootCauseInfo structures that contain a detailed description of the
///                 root cause. If diagnosis succeeds, this parameter contains both the leaf root causes identified in the diagnosis
///                 session and any non-leaf root causes that have an available repair. If diagnosis does not succeed, the contents
///                 of this parameter should be ignored. Memory allocated to these structures should later be freed. For an example
///                 of how to do this, see the Microsoft Windows Network Diagnostics Samples.
///    dwWait = Type: <b>DWORD</b> The length of time, in milliseconds, to wait before terminating the diagnostic routine.
///             INFINITE may be passed to this parameter if no time-out is desired.
///    dwFlags = Type: <b>DWORD</b> Possible values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="NDF_ADD_CAPTURE_TRACE"></a><a id="ndf_add_capture_trace"></a><dl> <dt><b>NDF_ADD_CAPTURE_TRACE</b></dt>
///              <dt>0x0001</dt> </dl> </td> <td width="60%"> Turns on network tracing during diagnosis. Diagnostic results will
///              be included in the Event Trace Log (ETL) file returned by NdfGetTraceFile. </td> </tr> <tr> <td width="40%"><a
///              id="NDF_APPLY_INCLUSION_LIST_FILTER_"></a><a id="ndf_apply_inclusion_list_filter_"></a><dl>
///              <dt><b>NDF_APPLY_INCLUSION_LIST_FILTER </b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%"> Applies filtering
///              to the returned root causes so that they are consistent with the in-box scripted diagnostics behavior. Without
///              this flag, root causes will not be filtered. This flag must be set by the caller, so existing callers will not
///              see a change in behavior unless they explicitly specify this flag. <div class="alert"><b>Note</b> Available only
///              in Windows 8 and Windows Server 2012.</div> <div> </div> </td> </tr> </table>
///Returns:
///    Type: <b>HRESULT</b> Possible return values include, but are not limited to, the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
///    width="60%"> The operation succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td>
///    <td width="60%"> The NDF incident handle is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WAIT_TIMEOUT</b></dt> </dl> </td> <td width="60%"> The diagnostic routine has terminated because it has
///    taken longer than the time-out specified in dwWait. </td> </tr> </table>
///    
@DllImport("NDFAPI")
HRESULT NdfDiagnoseIncident(void* Handle, uint* RootCauseCount, RootCauseInfo** RootCauses, uint dwWait, 
                            uint dwFlags);

///The <b>NdfRepairIncident</b> function repairs an incident without displaying a user interface.
///Params:
///    Handle = Type: <b>NDFHANDLE</b> Handle to the Network Diagnostics Framework incident. This handle should match the handle
///             passed to NdfDiagnoseIncident.
///    RepairEx = Type: <b>RepairInfoEx*</b> A structure (obtained from NdfDiagnoseIncident) which indicates the particular repair
///               to be performed. Memory allocated to these structures should later be freed. For an example of how to do this,
///               see the Microsoft Windows Network Diagnostics Samples.
///    dwWait = Type: <b>DWORD</b> The length of time, in milliseconds, to wait before terminating the diagnostic routine.
///             INFINITE may be passed to this parameter if no timeout is desired.
///Returns:
///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Repair
///    succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NDF_E_VALIDATION</b></dt> </dl> </td> <td width="60%">
///    The repair executed successfully, but NDF validation still found a connectivity problem. If this value is
///    returned, the session should be closed by calling NdfCloseIncident and another session should be created to
///    continue the diagnosis. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> The NDF incident handle is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WAIT_TIMEOUT</b></dt> </dl> </td> <td width="60%"> The repair operation has terminated because it has
///    taken longer than the time-out specified in dwWait. </td> </tr> </table> Other failure codes are returned if the
///    repair failed to execute. In that case, the client can call <b>NdfRepairIncident</b> again with a different
///    repair.
///    
@DllImport("NDFAPI")
HRESULT NdfRepairIncident(void* Handle, RepairInfoEx* RepairEx, uint dwWait);

///The <b>NdfCancelIncident</b> function is used to cancel unneeded functions which have been previously called on an
///existing incident.
///Params:
///    Handle = Type: <b>NDFHANDLE</b> Handle to the Network Diagnostics Framework incident. This handle should match the handle
///             of an existing incident.
///Returns:
///    Type: <b>HRESULT</b> Possible return values include, but are not limited to, the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
///    width="60%"> The operation succeeded. </td> </tr> </table> Any result other than S_OK should be interpreted as an
///    error.
///    
@DllImport("NDFAPI")
HRESULT NdfCancelIncident(void* Handle);

///The <b>NdfGetTraceFile</b> function is used to retrieve the path containing an Event Trace Log (ETL) file that
///contains Event Tracing for Windows (ETW) events from a diagnostic session.
///Params:
///    Handle = Type: <b>NDFHANDLE</b> Handle to a Network Diagnostics Framework incident. This handle should match the handle of
///             an existing incident.
///    TraceFileLocation = Type: <b>LPCWSTR*</b> The location of the trace file.
///Returns:
///    Type: <b>HRESULT</b> Possible return values include, but are not limited to, the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
///    width="60%"> The operation succeeded. </td> </tr> </table> Any result other than S_OK should be interpreted as an
///    error.
///    
@DllImport("NDFAPI")
HRESULT NdfGetTraceFile(void* Handle, ushort** TraceFileLocation);


// Interfaces

///The <b>INetDiagHelper</b> interface provides methods that capture and provide information associated with diagnoses
///and resolution of network-related issues.
@GUID("C0B35746-EBF5-11D8-BBE9-505054503030")
interface INetDiagHelper : IUnknown
{
    ///The <b>Initialize</b> method passes in attributes to the Helper Class Extension from the hypothesis. The helper
    ///class should store these parameters for use in the main diagnostics functions. This method must be called before
    ///any diagnostics function.
    ///Params:
    ///    celt = A pointer to a count of elements in <b>HELPER_ATTRIBUTE</b> array.
    ///    rgAttributes = A reference to the HELPER_ATTRIBUTE array.
    ///Returns:
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
    ///    </dl> </td> <td width="60%"> The operation succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory available to complete
    ///    this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> One or more parameters has not been provided correctly. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have sufficient privileges to
    ///    perform the diagnosis or repair operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ABORT</b></dt>
    ///    </dl> </td> <td width="60%"> The diagnosis or repair operation has been canceled. </td> </tr> </table> Helper
    ///    Class Extensions may return HRESULTS that are specific to the failures encountered in the function.
    ///    
    HRESULT Initialize(uint celt, char* rgAttributes);
    ///The <b>GetDiagnosticsInfo</b> method enables the Helper Class Extension instance to provide an estimate of how
    ///long the diagnosis may take.
    ///Params:
    ///    ppInfo = A pointer to a pointer to a DiagnosticsInfo structure.
    ///Returns:
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
    ///    </dl> </td> <td width="60%"> The operation succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory available to complete
    ///    this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> One or more parameters has not been provided correctly. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have sufficient privileges to
    ///    perform the diagnosis or repair operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ABORT</b></dt>
    ///    </dl> </td> <td width="60%"> The diagnosis or repair operation has been canceled. </td> </tr> </table> Helper
    ///    Class Extensions may return HRESULTS that are specific to the failures encountered in the function.
    ///    
    HRESULT GetDiagnosticsInfo(DiagnosticsInfo** ppInfo);
    ///The <b>GetKeyAttributes</b> method retrieves the key attributes of the Helper Class Extension.
    ///Params:
    ///    pcelt = A pointer to a count of elements in the <b>HELPER_ATTRIBUTE</b> array.
    ///    pprgAttributes = A pointer to an array of HELPER_ATTRIBUTE structures.
    ///Returns:
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
    ///    </dl> </td> <td width="60%"> The operation succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory available to complete
    ///    this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> One or more parameters has not been provided correctly. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> This optional method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The caller does not
    ///    have sufficient privileges to perform the diagnosis or repair operation. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The diagnosis or repair operation has been
    ///    canceled. </td> </tr> </table> Helper Class Extensions may return HRESULTS that are specific to the failures
    ///    encountered in the function.
    ///    
    HRESULT GetKeyAttributes(uint* pcelt, char* pprgAttributes);
    ///The <b>LowHealth</b> method enables the Helper Class Extension to check whether the component being diagnosed is
    ///healthy.
    ///Params:
    ///    pwszInstanceDescription = A pointer to a null-terminated string containing the user-friendly description of the information being
    ///                              diagnosed. For example, if a class were to diagnosis a connectivity issue with an IP address, the
    ///                              <i>pwszInstanceDescription</i> parameter would contain the host name.
    ///    ppwszDescription = A pointer to a null-terminated string containing the description of the issue found if the component is found
    ///                       to be unhealthy.
    ///    pDeferredTime = A pointer to the time, in seconds, to be deferred if the diagnosis cannot be started immediately. This is
    ///                    used when the <i>pStatus</i> parameter is set to <b>DS_DEFERRED</b>.
    ///    pStatus = A pointer to the DIAGNOSIS_STATUS that is returned from the diagnosis.
    ///Returns:
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
    ///    </dl> </td> <td width="60%"> The operation succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory available to complete
    ///    this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> One or more parameters has not been provided correctly. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have sufficient privileges to
    ///    perform the diagnosis or repair operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ABORT</b></dt>
    ///    </dl> </td> <td width="60%"> The diagnosis or repair operation has been canceled. </td> </tr> </table> Helper
    ///    Class Extensions may return HRESULTS that are specific to the failures encountered in the function.
    ///    
    HRESULT LowHealth(const(wchar)* pwszInstanceDescription, ushort** ppwszDescription, int* pDeferredTime, 
                      DIAGNOSIS_STATUS* pStatus);
    ///The <b>HighUtilization</b> method enables the Helper Class Extension to check whether the corresponding component
    ///is highly utilized.
    ///Params:
    ///    pwszInstanceDescription = A pointer to a null-terminated string containing the user-friendly description of the information being
    ///                              diagnosed. For example, if a class were to diagnosis a connectivity issue with an IP address, the
    ///                              <i>pwszInstanceDescription</i> parameter would contain the host name.
    ///    ppwszDescription = A pointer to a null-terminated string containing the description of high utilization diagnosis result.
    ///    pDeferredTime = A pointer to the time, in seconds, to be deferred if the diagnosis cannot be started immediately. This is
    ///                    used when the <i>pStatus</i> parameter is set to <b>DS_DEFERRED</b>.
    ///    pStatus = A pointer to the DIAGNOSIS_STATUS that is returned from the diagnosis.
    ///Returns:
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
    ///    </dl> </td> <td width="60%"> The operation succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory available to complete
    ///    this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> One or more parameters has not been provided correctly. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> This optional method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The caller does not
    ///    have sufficient privileges to perform the diagnosis or repair operation. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The diagnosis or repair operation has been
    ///    canceled. </td> </tr> </table> Helper Class Extensions may return HRESULTS that are specific to the failures
    ///    encountered in the function.
    ///    
    HRESULT HighUtilization(const(wchar)* pwszInstanceDescription, ushort** ppwszDescription, int* pDeferredTime, 
                            DIAGNOSIS_STATUS* pStatus);
    ///The <b>GetLowerHypotheses</b> method asks the Helper Class Extension to generate hypotheses for possible causes
    ///of low health in the local components that depend on it.
    ///Params:
    ///    pcelt = A pointer to a count of elements in the <b>HYPOTHESIS</b> array.
    ///    pprgHypotheses = A pointer to a HYPOTHESIS array.
    ///Returns:
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
    ///    </dl> </td> <td width="60%"> The operation succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory available to complete
    ///    this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> One or more parameters has not been provided correctly. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> This optional method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The caller does not
    ///    have sufficient privileges to perform the diagnosis or repair operation. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The diagnosis or repair operation has been
    ///    canceled. </td> </tr> </table> Helper Class Extensions may return HRESULTS that are specific to the failures
    ///    encountered in the function.
    ///    
    HRESULT GetLowerHypotheses(uint* pcelt, char* pprgHypotheses);
    ///The <b>GetDownStreamHypotheses</b> method asks the Helper Class Extension to generate hypotheses for possible
    ///causes of low health in the downstream network components it depends on.
    ///Params:
    ///    pcelt = A pointer to a count of elements in the HYPOTHESIS array.
    ///    pprgHypotheses = A pointer to an array of HYPOTHESIS structures.
    ///Returns:
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
    ///    </dl> </td> <td width="60%"> The operation succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory available to complete
    ///    this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> One or more parameters has not been provided correctly. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> This optional method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The caller does not
    ///    have sufficient privileges to perform the diagnosis or repair operation. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The diagnosis or repair operation has been
    ///    canceled. </td> </tr> </table> Helper Class Extensions may return HRESULTS that are specific to the failures
    ///    encountered in the function.
    ///    
    HRESULT GetDownStreamHypotheses(uint* pcelt, char* pprgHypotheses);
    ///The <b>GetHigherHypotheses</b> method asks the Helper Class Extension to generate hypotheses for possible causes
    ///of high utilization in the local components that depend on it.
    ///Params:
    ///    pcelt = A pointer to a count of elements in the HYPOTHESIS array.
    ///    pprgHypotheses = A pointer to an array of HYPOTHESIS structures.
    ///Returns:
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
    ///    </dl> </td> <td width="60%"> The operation succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory available to complete
    ///    this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> One or more parameters has not been provided correctly. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> This optional method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The caller does not
    ///    have sufficient privileges to perform the diagnosis or repair operation. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The diagnosis or repair operation has been
    ///    canceled. </td> </tr> </table> Helper Class Extensions may return HRESULTS that are specific to the failures
    ///    encountered in the function.
    ///    
    HRESULT GetHigherHypotheses(uint* pcelt, char* pprgHypotheses);
    ///The <b>GetUpStreamHypotheses</b> method asks the Helper Class Extension to generate hypotheses for possible
    ///causes of high utilization in the upstream network components that depend on it.
    ///Params:
    ///    pcelt = A pointer to a count of elements in the <b>HYPOTHESIS</b> array.
    ///    pprgHypotheses = A pointer to a HYPOTHESIS array.
    ///Returns:
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
    ///    </dl> </td> <td width="60%"> The operation succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory available to complete
    ///    this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> One or more parameters has not been provided correctly. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> This optional method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The caller does not
    ///    have sufficient privileges to perform the diagnosis or repair operation. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The diagnosis or repair operation has been
    ///    canceled. </td> </tr> </table> Helper Class Extensions may return HRESULTS that are specific to the failures
    ///    encountered in the function.
    ///    
    HRESULT GetUpStreamHypotheses(uint* pcelt, char* pprgHypotheses);
    ///The <b>Repair</b> method performs a repair specified by the input parameter.
    ///Params:
    ///    pInfo = A pointer to a RepairInfo structure.
    ///    pDeferredTime = A pointer to the time, in seconds, to be deferred if the repair cannot be started immediately. This is only
    ///                    valid when the pStatus parameter is set to <b>DS_DEFERRED</b>.
    ///    pStatus = A pointer to the REPAIR_STATUS that is returned from the repair.
    ///Returns:
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
    ///    </dl> </td> <td width="60%"> The operation succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory available to complete
    ///    this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> One or more parameters has not been provided correctly. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> This optional method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The caller does not
    ///    have sufficient privileges to perform the diagnosis or repair operation. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The diagnosis or repair operation has been
    ///    canceled. </td> </tr> </table> Helper Class Extensions may return HRESULTS that are specific to the failures
    ///    encountered in the function.
    ///    
    HRESULT Repair(RepairInfo* pInfo, int* pDeferredTime, REPAIR_STATUS* pStatus);
    ///The <b>Validate</b> method is called by NDF after a repair is successfully completed in order to validate that a
    ///previously diagnosed problem has been fixed.
    ///Params:
    ///    problem = The PROBLEM_TYPE that the helper class has previously diagnosed.
    ///    pDeferredTime = A pointer to the time to be deferred, in seconds, if the diagnosis cannot be started immediately. This is
    ///                    used only when the pStatus member is set to <b>DS_DEFERRED</b>.
    ///    pStatus = A pointer to the DIAGNOSIS_STATUS that is returned from the diagnosis.
    ///Returns:
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
    ///    </dl> </td> <td width="60%"> The operation succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory available to complete
    ///    this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> One or more parameters has not been provided correctly. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> This optional method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The caller does not
    ///    have sufficient privileges to perform the diagnosis or repair operation. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The diagnosis or repair operation has been
    ///    canceled. </td> </tr> </table> Helper Class Extensions may return HRESULTS that are specific to the failures
    ///    encountered in the function.
    ///    
    HRESULT Validate(PROBLEM_TYPE problem, int* pDeferredTime, REPAIR_STATUS* pStatus);
    ///The <b>GetRepairInfo</b> method retrieves the repair information that the Helper Class Extension has for a given
    ///problem type.
    ///Params:
    ///    problem = A PROBLEM_TYPE value that specifies the problem type that the helper class has previously diagnosed.
    ///    pcelt = A pointer to a count of elements in the <b>RepairInfo</b> array.
    ///    ppInfo = A pointer to an array of RepairInfo structures.
    ///Returns:
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
    ///    </dl> </td> <td width="60%"> The operation succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory available to complete
    ///    this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> One or more parameters has not been provided correctly. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> This optional method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The caller does not
    ///    have sufficient privileges to perform the diagnosis or repair operation. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The diagnosis or repair operation has been
    ///    canceled. </td> </tr> </table> Helper Class Extensions may return HRESULTS that are specific to the failures
    ///    encountered in the function.
    ///    
    HRESULT GetRepairInfo(PROBLEM_TYPE problem, uint* pcelt, char* ppInfo);
    ///The <b>GetLifeTime</b> method retrieves the lifetime of the Helper Class Extension instance.
    ///Params:
    ///    pLifeTime = A pointer to a LIFE_TIME structure.
    ///Returns:
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
    ///    </dl> </td> <td width="60%"> The operation succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory available to complete
    ///    this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> One or more parameters has not been provided correctly. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> This optional method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The caller does not
    ///    have sufficient privileges to perform the diagnosis or repair operation. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The diagnosis or repair operation has been
    ///    canceled. </td> </tr> </table> Helper Class Extensions may return HRESULTS that are specific to the failures
    ///    encountered in the function.
    ///    
    HRESULT GetLifeTime(LIFE_TIME* pLifeTime);
    ///The <b>SetLifeTime</b> method is called by NDF to set the start and end time of interest to diagnostics so that
    ///the Helper Class Extension can limit its diagnosis to events within that time period.
    ///Params:
    ///    lifeTime = A LIFE_TIME structure.
    ///Returns:
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
    ///    </dl> </td> <td width="60%"> The operation succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory available to complete
    ///    this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> One or more parameters has not been provided correctly. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> This optional method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The caller does not
    ///    have sufficient privileges to perform the diagnosis or repair operation. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The diagnosis or repair operation has been
    ///    canceled. </td> </tr> </table> Helper Class Extensions may return HRESULTS that are specific to the failures
    ///    encountered in the function.
    ///    
    HRESULT SetLifeTime(LIFE_TIME lifeTime);
    ///The <b>GetCacheTime</b> method specifies the time when cached results of a diagnosis and repair operation have
    ///expired.
    ///Params:
    ///    pCacheTime = A pointer to a FILETIME structure.
    ///Returns:
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
    ///    </dl> </td> <td width="60%"> The operation succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory available to complete
    ///    this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> One or more parameters has not been provided correctly. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> This optional method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The caller does not
    ///    have sufficient privileges to perform the diagnosis or repair operation. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The diagnosis or repair operation has been
    ///    canceled. </td> </tr> </table> Helper Class Extensions may return HRESULTS that are specific to the failures
    ///    encountered in the function.
    ///    
    HRESULT GetCacheTime(FILETIME* pCacheTime);
    ///The <b>GetAttributes</b> method retrieves additional information about a problem that the helper class extension
    ///has diagnosed.
    ///Params:
    ///    pcelt = A pointer to a count of elements in the <b>HELPER_ATTRIBUTE</b> array.
    ///    pprgAttributes = A pointer to an array of HELPER_ATTRIBUTE structures.
    ///Returns:
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
    ///    </dl> </td> <td width="60%"> The operation succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory available to complete
    ///    this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> One or more parameters has not been provided correctly. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> This optional method is not implemented. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The caller does not
    ///    have sufficient privileges to perform the diagnosis or repair operation. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The diagnosis or repair operation has been
    ///    canceled. </td> </tr> </table> Helper Class Extensions may return HRESULTS that are specific to the failures
    ///    encountered in the function.
    ///    
    HRESULT GetAttributes(uint* pcelt, char* pprgAttributes);
    ///The <b>Cancel</b> method cancels an ongoing diagnosis or repair.
    ///Returns:
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
    ///    </dl> </td> <td width="60%"> The operation succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory available to complete
    ///    this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> The caller does not have sufficient privileges to perform the diagnosis or repair operation.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The diagnosis or
    ///    repair operation has been canceled. </td> </tr> </table> Helper Class Extensions may return HRESULTS that are
    ///    specific to the failures encountered in the function.
    ///    
    HRESULT Cancel();
    ///The <b>Cleanup</b> method allows the Helper Class Extension to clean up resources following a diagnosis or repair
    ///operation.
    ///Returns:
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
    ///    </dl> </td> <td width="60%"> The operation succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory available to complete
    ///    this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> The caller does not have sufficient privileges to perform the diagnosis or repair operation.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The diagnosis or
    ///    repair operation has been canceled. </td> </tr> </table> Helper Class Extensions may return HRESULTS that are
    ///    specific to the failures encountered in the function.
    ///    
    HRESULT Cleanup();
}

///The <b>INetDiagHelperUtilFactory</b> interface provides a reserved method that is used by the Network Diagnostics
///Framework (NDF). This interface is reserved for system use.
@GUID("104613FB-BC57-4178-95BA-88809698354A")
interface INetDiagHelperUtilFactory : IUnknown
{
    ///The CreateUtilityInstance method is used by the Network Diagnostics Framework (NDF). This method is reserved for
    ///system use.
    ///Params:
    ///    riid = Reserved for system use.
    ///    ppvObject = Reserved for system use.
    ///Returns:
    ///    This method does not return a value.
    ///    
    HRESULT CreateUtilityInstance(const(GUID)* riid, void** ppvObject);
}

///The <b>INetDiagHelperEx</b> interface provides methods that extend on the INetDiagHelper interface to capture and
///provide information associated with diagnoses and resolution of network-related issues.
@GUID("972DAB4D-E4E3-4FC6-AE54-5F65CCDE4A15")
interface INetDiagHelperEx : IUnknown
{
    ///The <b>ReconfirmLowHealth</b> method is used to add a second Low Health pass after hypotheses have been diagnosed
    ///and before repairs are retrieved. This method allows the helper class to see the diagnostics results and to
    ///change the diagnosis if needed. The method is only called if a diagnosis is not rejected and hypotheses were
    ///generated.
    ///Params:
    ///    celt = The number of HypothesisResult structures pointed to by <i>pResults</i>.
    ///    pResults = Pointer to HypothesisResult structure(s) containing the HYPOTHESIS information obtained via the
    ///               GetLowerHypotheses method along with the status of that hypothesis. Includes one <b>HypothesisResult</b>
    ///               structure for each hypothesis generated by the helper class's call to <b>GetLowerHypotheses</b>.
    ///    ppwszUpdatedDescription = An updated description of the incident being diagnosed.
    ///    pUpdatedStatus = A DIAGNOSIS_STATUS value which indicates the status of the incident.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation succeeded. </td> </tr> </table> Any result other than S_OK will be interpreted as an error and will
    ///    cause the function results to be discarded.
    ///    
    HRESULT ReconfirmLowHealth(uint celt, char* pResults, ushort** ppwszUpdatedDescription, 
                               DIAGNOSIS_STATUS* pUpdatedStatus);
    ///The <b>SetUtilities</b> method is used by the Network Diagnostics Framework (NDF). This method is reserved for
    ///system use.
    ///Params:
    ///    pUtilities = Reserved for system use.
    ///Returns:
    ///    This method does not return a value.
    ///    
    HRESULT SetUtilities(INetDiagHelperUtilFactory pUtilities);
    ///The <b>ReproduceFailure</b> method is used by the Network Diagnostics Framework (NDF). This method is reserved
    ///for system use.
    ///Returns:
    ///    This method does not return a value.
    ///    
    HRESULT ReproduceFailure();
}

///The <b>INetDiagHelperInfo</b> interface provides a method that is called by the Network Diagnostics Framework (NDF)
///when it needs to validate that it has the necessary information for a helper class and that it has chosen the correct
///helper class.
@GUID("C0B35747-EBF5-11D8-BBE9-505054503030")
interface INetDiagHelperInfo : IUnknown
{
    ///The <b>GetAttributeInfo</b> method retrieves the list of key parameters needed by the Helper Class Extension.
    ///Params:
    ///    pcelt = A pointer to a count of elements in the array pointed to by <i>pprgAttributeInfos</i>.
    ///    pprgAttributeInfos = A pointer to an array of HelperAttributeInfo structures that contain helper class key parameters.
    ///Returns:
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
    ///    </dl> </td> <td width="60%"> The operation succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory available to complete
    ///    this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> One or more parameters has not been provided correctly. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have sufficient privileges to
    ///    perform the diagnosis or repair operation. </td> </tr> </table> Helper Class Extensions may return HRESULTS
    ///    that are specific to the diagnoses or repairs.
    ///    
    HRESULT GetAttributeInfo(uint* pcelt, char* pprgAttributeInfos);
}

@GUID("C0B35748-EBF5-11D8-BBE9-505054503030")
interface INetDiagExtensibleHelper : IUnknown
{
    HRESULT ResolveAttributes(uint celt, char* rgKeyAttributes, uint* pcelt, char* prgMatchValues);
}


// GUIDs


const GUID IID_INetDiagExtensibleHelper  = GUIDOF!INetDiagExtensibleHelper;
const GUID IID_INetDiagHelper            = GUIDOF!INetDiagHelper;
const GUID IID_INetDiagHelperEx          = GUIDOF!INetDiagHelperEx;
const GUID IID_INetDiagHelperInfo        = GUIDOF!INetDiagHelperInfo;
const GUID IID_INetDiagHelperUtilFactory = GUIDOF!INetDiagHelperUtilFactory;
