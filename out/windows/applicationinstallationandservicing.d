module windows.applicationinstallationandservicing;

public import system;
public import windows.automation;
public import windows.com;
public import windows.deviceanddriver;
public import windows.security;
public import windows.structuredstorage;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

struct ACTIVATION_CONTEXT_QUERY_INDEX
{
    uint ulAssemblyIndex;
    uint ulFileIndexInAssembly;
}

struct ASSEMBLY_FILE_DETAILED_INFORMATION
{
    uint ulFlags;
    uint ulFilenameLength;
    uint ulPathLength;
    const(wchar)* lpFileName;
    const(wchar)* lpFilePath;
}

struct ACTIVATION_CONTEXT_ASSEMBLY_DETAILED_INFORMATION
{
    uint ulFlags;
    uint ulEncodedAssemblyIdentityLength;
    uint ulManifestPathType;
    uint ulManifestPathLength;
    LARGE_INTEGER liManifestLastWriteTime;
    uint ulPolicyPathType;
    uint ulPolicyPathLength;
    LARGE_INTEGER liPolicyLastWriteTime;
    uint ulMetadataSatelliteRosterIndex;
    uint ulManifestVersionMajor;
    uint ulManifestVersionMinor;
    uint ulPolicyVersionMajor;
    uint ulPolicyVersionMinor;
    uint ulAssemblyDirectoryNameLength;
    const(wchar)* lpAssemblyEncodedAssemblyIdentity;
    const(wchar)* lpAssemblyManifestPath;
    const(wchar)* lpAssemblyPolicyPath;
    const(wchar)* lpAssemblyDirectoryName;
    uint ulFileCount;
}

enum ACTCTX_REQUESTED_RUN_LEVEL
{
    ACTCTX_RUN_LEVEL_UNSPECIFIED = 0,
    ACTCTX_RUN_LEVEL_AS_INVOKER = 1,
    ACTCTX_RUN_LEVEL_HIGHEST_AVAILABLE = 2,
    ACTCTX_RUN_LEVEL_REQUIRE_ADMIN = 3,
    ACTCTX_RUN_LEVEL_NUMBERS = 4,
}

struct ACTIVATION_CONTEXT_RUN_LEVEL_INFORMATION
{
    uint ulFlags;
    ACTCTX_REQUESTED_RUN_LEVEL RunLevel;
    uint UiAccess;
}

enum ACTCTX_COMPATIBILITY_ELEMENT_TYPE
{
    ACTCTX_COMPATIBILITY_ELEMENT_TYPE_UNKNOWN = 0,
    ACTCTX_COMPATIBILITY_ELEMENT_TYPE_OS = 1,
    ACTCTX_COMPATIBILITY_ELEMENT_TYPE_MITIGATION = 2,
    ACTCTX_COMPATIBILITY_ELEMENT_TYPE_MAXVERSIONTESTED = 3,
}

struct COMPATIBILITY_CONTEXT_ELEMENT
{
    Guid Id;
    ACTCTX_COMPATIBILITY_ELEMENT_TYPE Type;
    ulong MaxVersionTested;
}

struct ACTIVATION_CONTEXT_COMPATIBILITY_INFORMATION
{
    uint ElementCount;
    COMPATIBILITY_CONTEXT_ELEMENT Elements;
}

struct ACTIVATION_CONTEXT_DETAILED_INFORMATION
{
    uint dwFlags;
    uint ulFormatVersion;
    uint ulAssemblyCount;
    uint ulRootManifestPathType;
    uint ulRootManifestPathChars;
    uint ulRootConfigurationPathType;
    uint ulRootConfigurationPathChars;
    uint ulAppDirPathType;
    uint ulAppDirPathChars;
    const(wchar)* lpRootManifestPath;
    const(wchar)* lpRootConfigurationPath;
    const(wchar)* lpAppDirPath;
}

enum RESULTTYPES
{
    ieUnknown = 0,
    ieError = 1,
    ieWarning = 2,
    ieInfo = 3,
}

enum STATUSTYPES
{
    ieStatusGetCUB = 0,
    ieStatusICECount = 1,
    ieStatusMerge = 2,
    ieStatusSummaryInfo = 3,
    ieStatusCreateEngine = 4,
    ieStatusStarting = 5,
    ieStatusRunICE = 6,
    ieStatusShutdown = 7,
    ieStatusSuccess = 8,
    ieStatusFail = 9,
    ieStatusCancel = 10,
}

alias LPDISPLAYVAL = extern(Windows) BOOL function(void* pContext, RESULTTYPES uiType, const(wchar)* szwVal, const(wchar)* szwDescription, const(wchar)* szwLocation);
alias LPEVALCOMCALLBACK = extern(Windows) BOOL function(STATUSTYPES iStatus, const(wchar)* szData, void* pContext);
interface IValidate : IUnknown
{
    HRESULT OpenDatabase(ushort* szDatabase);
    HRESULT OpenCUB(ushort* szCUBFile);
    HRESULT CloseDatabase();
    HRESULT CloseCUB();
    HRESULT SetDisplay(LPDISPLAYVAL pDisplayFunction, void* pContext);
    HRESULT SetStatus(LPEVALCOMCALLBACK pStatusFunction, void* pContext);
    HRESULT Validate(const(wchar)* wzICEs);
}

const GUID CLSID_MsmMerge = {0x0ADDA830, 0x2C26, 0x11D2, [0xAD, 0x65, 0x00, 0xA0, 0xC9, 0xAF, 0x11, 0xA6]};
@GUID(0x0ADDA830, 0x2C26, 0x11D2, [0xAD, 0x65, 0x00, 0xA0, 0xC9, 0xAF, 0x11, 0xA6]);
struct MsmMerge;

enum msmErrorType
{
    msmErrorLanguageUnsupported = 1,
    msmErrorLanguageFailed = 2,
    msmErrorExclusion = 3,
    msmErrorTableMerge = 4,
    msmErrorResequenceMerge = 5,
    msmErrorFileCreate = 6,
    msmErrorDirCreate = 7,
    msmErrorFeatureRequired = 8,
}

const GUID IID_IEnumMsmString = {0x0ADDA826, 0x2C26, 0x11D2, [0xAD, 0x65, 0x00, 0xA0, 0xC9, 0xAF, 0x11, 0xA6]};
@GUID(0x0ADDA826, 0x2C26, 0x11D2, [0xAD, 0x65, 0x00, 0xA0, 0xC9, 0xAF, 0x11, 0xA6]);
interface IEnumMsmString : IUnknown
{
    HRESULT Next(uint cFetch, BSTR* rgbstrStrings, uint* pcFetched);
    HRESULT Skip(uint cSkip);
    HRESULT Reset();
    HRESULT Clone(IEnumMsmString* pemsmStrings);
}

const GUID IID_IMsmStrings = {0x0ADDA827, 0x2C26, 0x11D2, [0xAD, 0x65, 0x00, 0xA0, 0xC9, 0xAF, 0x11, 0xA6]};
@GUID(0x0ADDA827, 0x2C26, 0x11D2, [0xAD, 0x65, 0x00, 0xA0, 0xC9, 0xAF, 0x11, 0xA6]);
interface IMsmStrings : IDispatch
{
    HRESULT get_Item(int Item, BSTR* Return);
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* NewEnum);
}

const GUID IID_IMsmError = {0x0ADDA828, 0x2C26, 0x11D2, [0xAD, 0x65, 0x00, 0xA0, 0xC9, 0xAF, 0x11, 0xA6]};
@GUID(0x0ADDA828, 0x2C26, 0x11D2, [0xAD, 0x65, 0x00, 0xA0, 0xC9, 0xAF, 0x11, 0xA6]);
interface IMsmError : IDispatch
{
    HRESULT get_Type(msmErrorType* ErrorType);
    HRESULT get_Path(BSTR* ErrorPath);
    HRESULT get_Language(short* ErrorLanguage);
    HRESULT get_DatabaseTable(BSTR* ErrorTable);
    HRESULT get_DatabaseKeys(IMsmStrings* ErrorKeys);
    HRESULT get_ModuleTable(BSTR* ErrorTable);
    HRESULT get_ModuleKeys(IMsmStrings* ErrorKeys);
}

const GUID IID_IEnumMsmError = {0x0ADDA829, 0x2C26, 0x11D2, [0xAD, 0x65, 0x00, 0xA0, 0xC9, 0xAF, 0x11, 0xA6]};
@GUID(0x0ADDA829, 0x2C26, 0x11D2, [0xAD, 0x65, 0x00, 0xA0, 0xC9, 0xAF, 0x11, 0xA6]);
interface IEnumMsmError : IUnknown
{
    HRESULT Next(uint cFetch, IMsmError* rgmsmErrors, uint* pcFetched);
    HRESULT Skip(uint cSkip);
    HRESULT Reset();
    HRESULT Clone(IEnumMsmError* pemsmErrors);
}

const GUID IID_IMsmErrors = {0x0ADDA82A, 0x2C26, 0x11D2, [0xAD, 0x65, 0x00, 0xA0, 0xC9, 0xAF, 0x11, 0xA6]};
@GUID(0x0ADDA82A, 0x2C26, 0x11D2, [0xAD, 0x65, 0x00, 0xA0, 0xC9, 0xAF, 0x11, 0xA6]);
interface IMsmErrors : IDispatch
{
    HRESULT get_Item(int Item, IMsmError* Return);
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* NewEnum);
}

const GUID IID_IMsmDependency = {0x0ADDA82B, 0x2C26, 0x11D2, [0xAD, 0x65, 0x00, 0xA0, 0xC9, 0xAF, 0x11, 0xA6]};
@GUID(0x0ADDA82B, 0x2C26, 0x11D2, [0xAD, 0x65, 0x00, 0xA0, 0xC9, 0xAF, 0x11, 0xA6]);
interface IMsmDependency : IDispatch
{
    HRESULT get_Module(BSTR* Module);
    HRESULT get_Language(short* Language);
    HRESULT get_Version(BSTR* Version);
}

const GUID IID_IEnumMsmDependency = {0x0ADDA82C, 0x2C26, 0x11D2, [0xAD, 0x65, 0x00, 0xA0, 0xC9, 0xAF, 0x11, 0xA6]};
@GUID(0x0ADDA82C, 0x2C26, 0x11D2, [0xAD, 0x65, 0x00, 0xA0, 0xC9, 0xAF, 0x11, 0xA6]);
interface IEnumMsmDependency : IUnknown
{
    HRESULT Next(uint cFetch, IMsmDependency* rgmsmDependencies, uint* pcFetched);
    HRESULT Skip(uint cSkip);
    HRESULT Reset();
    HRESULT Clone(IEnumMsmDependency* pemsmDependencies);
}

const GUID IID_IMsmDependencies = {0x0ADDA82D, 0x2C26, 0x11D2, [0xAD, 0x65, 0x00, 0xA0, 0xC9, 0xAF, 0x11, 0xA6]};
@GUID(0x0ADDA82D, 0x2C26, 0x11D2, [0xAD, 0x65, 0x00, 0xA0, 0xC9, 0xAF, 0x11, 0xA6]);
interface IMsmDependencies : IDispatch
{
    HRESULT get_Item(int Item, IMsmDependency* Return);
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* NewEnum);
}

const GUID IID_IMsmMerge = {0x0ADDA82E, 0x2C26, 0x11D2, [0xAD, 0x65, 0x00, 0xA0, 0xC9, 0xAF, 0x11, 0xA6]};
@GUID(0x0ADDA82E, 0x2C26, 0x11D2, [0xAD, 0x65, 0x00, 0xA0, 0xC9, 0xAF, 0x11, 0xA6]);
interface IMsmMerge : IDispatch
{
    HRESULT OpenDatabase(const(ushort)* Path);
    HRESULT OpenModule(const(ushort)* Path, const(short) Language);
    HRESULT CloseDatabase(const(short) Commit);
    HRESULT CloseModule();
    HRESULT OpenLog(const(ushort)* Path);
    HRESULT CloseLog();
    HRESULT Log(const(ushort)* Message);
    HRESULT get_Errors(IMsmErrors* Errors);
    HRESULT get_Dependencies(IMsmDependencies* Dependencies);
    HRESULT Merge(const(ushort)* Feature, const(ushort)* RedirectDir);
    HRESULT Connect(const(ushort)* Feature);
    HRESULT ExtractCAB(const(ushort)* FileName);
    HRESULT ExtractFiles(const(ushort)* Path);
}

const GUID IID_IMsmGetFiles = {0x7041AE26, 0x2D78, 0x11D2, [0x88, 0x8A, 0x00, 0xA0, 0xC9, 0x81, 0xB0, 0x15]};
@GUID(0x7041AE26, 0x2D78, 0x11D2, [0x88, 0x8A, 0x00, 0xA0, 0xC9, 0x81, 0xB0, 0x15]);
interface IMsmGetFiles : IDispatch
{
    HRESULT get_ModuleFiles(IMsmStrings* Files);
}

struct PMSIHANDLE
{
    uint m_h;
}

enum INSTALLMESSAGE
{
    INSTALLMESSAGE_FATALEXIT = 0,
    INSTALLMESSAGE_ERROR = 16777216,
    INSTALLMESSAGE_WARNING = 33554432,
    INSTALLMESSAGE_USER = 50331648,
    INSTALLMESSAGE_INFO = 67108864,
    INSTALLMESSAGE_FILESINUSE = 83886080,
    INSTALLMESSAGE_RESOLVESOURCE = 100663296,
    INSTALLMESSAGE_OUTOFDISKSPACE = 117440512,
    INSTALLMESSAGE_ACTIONSTART = 134217728,
    INSTALLMESSAGE_ACTIONDATA = 150994944,
    INSTALLMESSAGE_PROGRESS = 167772160,
    INSTALLMESSAGE_COMMONDATA = 184549376,
    INSTALLMESSAGE_INITIALIZE = 201326592,
    INSTALLMESSAGE_TERMINATE = 218103808,
    INSTALLMESSAGE_SHOWDIALOG = 234881024,
    INSTALLMESSAGE_PERFORMANCE = 251658240,
    INSTALLMESSAGE_RMFILESINUSE = 419430400,
    INSTALLMESSAGE_INSTALLSTART = 436207616,
    INSTALLMESSAGE_INSTALLEND = 452984832,
}

alias INSTALLUI_HANDLERA = extern(Windows) int function(void* pvContext, uint iMessageType, const(char)* szMessage);
alias INSTALLUI_HANDLERW = extern(Windows) int function(void* pvContext, uint iMessageType, const(wchar)* szMessage);
alias INSTALLUI_HANDLER_RECORD = extern(Windows) int function(void* pvContext, uint iMessageType, uint hRecord);
alias PINSTALLUI_HANDLER_RECORD = extern(Windows) int function();
enum INSTALLUILEVEL
{
    INSTALLUILEVEL_NOCHANGE = 0,
    INSTALLUILEVEL_DEFAULT = 1,
    INSTALLUILEVEL_NONE = 2,
    INSTALLUILEVEL_BASIC = 3,
    INSTALLUILEVEL_REDUCED = 4,
    INSTALLUILEVEL_FULL = 5,
    INSTALLUILEVEL_ENDDIALOG = 128,
    INSTALLUILEVEL_PROGRESSONLY = 64,
    INSTALLUILEVEL_HIDECANCEL = 32,
    INSTALLUILEVEL_SOURCERESONLY = 256,
    INSTALLUILEVEL_UACONLY = 512,
}

enum INSTALLSTATE
{
    INSTALLSTATE_NOTUSED = -7,
    INSTALLSTATE_BADCONFIG = -6,
    INSTALLSTATE_INCOMPLETE = -5,
    INSTALLSTATE_SOURCEABSENT = -4,
    INSTALLSTATE_MOREDATA = -3,
    INSTALLSTATE_INVALIDARG = -2,
    INSTALLSTATE_UNKNOWN = -1,
    INSTALLSTATE_BROKEN = 0,
    INSTALLSTATE_ADVERTISED = 1,
    INSTALLSTATE_REMOVED = 1,
    INSTALLSTATE_ABSENT = 2,
    INSTALLSTATE_LOCAL = 3,
    INSTALLSTATE_SOURCE = 4,
    INSTALLSTATE_DEFAULT = 5,
}

enum USERINFOSTATE
{
    USERINFOSTATE_MOREDATA = -3,
    USERINFOSTATE_INVALIDARG = -2,
    USERINFOSTATE_UNKNOWN = -1,
    USERINFOSTATE_ABSENT = 0,
    USERINFOSTATE_PRESENT = 1,
}

enum INSTALLLEVEL
{
    INSTALLLEVEL_DEFAULT = 0,
    INSTALLLEVEL_MINIMUM = 1,
    INSTALLLEVEL_MAXIMUM = 65535,
}

enum REINSTALLMODE
{
    REINSTALLMODE_REPAIR = 1,
    REINSTALLMODE_FILEMISSING = 2,
    REINSTALLMODE_FILEOLDERVERSION = 4,
    REINSTALLMODE_FILEEQUALVERSION = 8,
    REINSTALLMODE_FILEEXACT = 16,
    REINSTALLMODE_FILEVERIFY = 32,
    REINSTALLMODE_FILEREPLACE = 64,
    REINSTALLMODE_MACHINEDATA = 128,
    REINSTALLMODE_USERDATA = 256,
    REINSTALLMODE_SHORTCUT = 512,
    REINSTALLMODE_PACKAGE = 1024,
}

enum tagINSTALLOGMODE
{
    INSTALLLOGMODE_FATALEXIT = 1,
    INSTALLLOGMODE_ERROR = 2,
    INSTALLLOGMODE_WARNING = 4,
    INSTALLLOGMODE_USER = 8,
    INSTALLLOGMODE_INFO = 16,
    INSTALLLOGMODE_RESOLVESOURCE = 64,
    INSTALLLOGMODE_OUTOFDISKSPACE = 128,
    INSTALLLOGMODE_ACTIONSTART = 256,
    INSTALLLOGMODE_ACTIONDATA = 512,
    INSTALLLOGMODE_COMMONDATA = 2048,
    INSTALLLOGMODE_PROPERTYDUMP = 1024,
    INSTALLLOGMODE_VERBOSE = 4096,
    INSTALLLOGMODE_EXTRADEBUG = 8192,
    INSTALLLOGMODE_LOGONLYONERROR = 16384,
    INSTALLLOGMODE_LOGPERFORMANCE = 32768,
    INSTALLLOGMODE_PROGRESS = 1024,
    INSTALLLOGMODE_INITIALIZE = 4096,
    INSTALLLOGMODE_TERMINATE = 8192,
    INSTALLLOGMODE_SHOWDIALOG = 16384,
    INSTALLLOGMODE_FILESINUSE = 32,
    INSTALLLOGMODE_RMFILESINUSE = 33554432,
    INSTALLLOGMODE_INSTALLSTART = 67108864,
    INSTALLLOGMODE_INSTALLEND = 134217728,
}

enum INSTALLLOGATTRIBUTES
{
    INSTALLLOGATTRIBUTES_APPEND = 1,
    INSTALLLOGATTRIBUTES_FLUSHEACHLINE = 2,
}

enum INSTALLFEATUREATTRIBUTE
{
    INSTALLFEATUREATTRIBUTE_FAVORLOCAL = 1,
    INSTALLFEATUREATTRIBUTE_FAVORSOURCE = 2,
    INSTALLFEATUREATTRIBUTE_FOLLOWPARENT = 4,
    INSTALLFEATUREATTRIBUTE_FAVORADVERTISE = 8,
    INSTALLFEATUREATTRIBUTE_DISALLOWADVERTISE = 16,
    INSTALLFEATUREATTRIBUTE_NOUNSUPPORTEDADVERTISE = 32,
}

enum INSTALLMODE
{
    INSTALLMODE_NODETECTION_ANY = -4,
    INSTALLMODE_NOSOURCERESOLUTION = -3,
    INSTALLMODE_NODETECTION = -2,
    INSTALLMODE_EXISTING = -1,
    INSTALLMODE_DEFAULT = 0,
}

enum MSIPATCHSTATE
{
    MSIPATCHSTATE_INVALID = 0,
    MSIPATCHSTATE_APPLIED = 1,
    MSIPATCHSTATE_SUPERSEDED = 2,
    MSIPATCHSTATE_OBSOLETED = 4,
    MSIPATCHSTATE_REGISTERED = 8,
    MSIPATCHSTATE_ALL = 15,
}

enum MSIINSTALLCONTEXT
{
    MSIINSTALLCONTEXT_FIRSTVISIBLE = 0,
    MSIINSTALLCONTEXT_NONE = 0,
    MSIINSTALLCONTEXT_USERMANAGED = 1,
    MSIINSTALLCONTEXT_USERUNMANAGED = 2,
    MSIINSTALLCONTEXT_MACHINE = 4,
    MSIINSTALLCONTEXT_ALL = 7,
    MSIINSTALLCONTEXT_ALLUSERMANAGED = 8,
}

enum MSIPATCHDATATYPE
{
    MSIPATCH_DATATYPE_PATCHFILE = 0,
    MSIPATCH_DATATYPE_XMLPATH = 1,
    MSIPATCH_DATATYPE_XMLBLOB = 2,
}

struct MSIPATCHSEQUENCEINFOA
{
    const(char)* szPatchData;
    MSIPATCHDATATYPE ePatchDataType;
    uint dwOrder;
    uint uStatus;
}

struct MSIPATCHSEQUENCEINFOW
{
    const(wchar)* szPatchData;
    MSIPATCHDATATYPE ePatchDataType;
    uint dwOrder;
    uint uStatus;
}

enum SCRIPTFLAGS
{
    SCRIPTFLAGS_CACHEINFO = 1,
    SCRIPTFLAGS_SHORTCUTS = 4,
    SCRIPTFLAGS_MACHINEASSIGN = 8,
    SCRIPTFLAGS_REGDATA_CNFGINFO = 32,
    SCRIPTFLAGS_VALIDATE_TRANSFORMS_LIST = 64,
    SCRIPTFLAGS_REGDATA_CLASSINFO = 128,
    SCRIPTFLAGS_REGDATA_EXTENSIONINFO = 256,
    SCRIPTFLAGS_REGDATA_APPINFO = 384,
    SCRIPTFLAGS_REGDATA = 416,
}

enum ADVERTISEFLAGS
{
    ADVERTISEFLAGS_MACHINEASSIGN = 0,
    ADVERTISEFLAGS_USERASSIGN = 1,
}

enum INSTALLTYPE
{
    INSTALLTYPE_DEFAULT = 0,
    INSTALLTYPE_NETWORK_IMAGE = 1,
    INSTALLTYPE_SINGLE_INSTANCE = 2,
}

struct MSIFILEHASHINFO
{
    uint dwFileHashInfoSize;
    uint dwData;
}

enum MSIARCHITECTUREFLAGS
{
    MSIARCHITECTUREFLAGS_X86 = 1,
    MSIARCHITECTUREFLAGS_IA64 = 2,
    MSIARCHITECTUREFLAGS_AMD64 = 4,
    MSIARCHITECTUREFLAGS_ARM = 8,
}

enum MSIOPENPACKAGEFLAGS
{
    MSIOPENPACKAGEFLAGS_IGNOREMACHINESTATE = 1,
}

enum MSIADVERTISEOPTIONFLAGS
{
    MSIADVERTISEOPTIONFLAGS_INSTANCE = 1,
}

enum MSISOURCETYPE
{
    MSISOURCETYPE_UNKNOWN = 0,
    MSISOURCETYPE_NETWORK = 1,
    MSISOURCETYPE_URL = 2,
    MSISOURCETYPE_MEDIA = 4,
}

enum MSICODE
{
    MSICODE_PRODUCT = 0,
    MSICODE_PATCH = 1073741824,
}

enum MSITRANSACTION
{
    MSITRANSACTION_CHAIN_EMBEDDEDUI = 1,
    MSITRANSACTION_JOIN_EXISTING_EMBEDDEDUI = 2,
}

enum MSITRANSACTIONSTATE
{
    MSITRANSACTIONSTATE_ROLLBACK = 0,
    MSITRANSACTIONSTATE_COMMIT = 1,
}

enum MSIDBSTATE
{
    MSIDBSTATE_ERROR = -1,
    MSIDBSTATE_READ = 0,
    MSIDBSTATE_WRITE = 1,
}

enum MSIMODIFY
{
    MSIMODIFY_SEEK = -1,
    MSIMODIFY_REFRESH = 0,
    MSIMODIFY_INSERT = 1,
    MSIMODIFY_UPDATE = 2,
    MSIMODIFY_ASSIGN = 3,
    MSIMODIFY_REPLACE = 4,
    MSIMODIFY_MERGE = 5,
    MSIMODIFY_DELETE = 6,
    MSIMODIFY_INSERT_TEMPORARY = 7,
    MSIMODIFY_VALIDATE = 8,
    MSIMODIFY_VALIDATE_NEW = 9,
    MSIMODIFY_VALIDATE_FIELD = 10,
    MSIMODIFY_VALIDATE_DELETE = 11,
}

enum MSICOLINFO
{
    MSICOLINFO_NAMES = 0,
    MSICOLINFO_TYPES = 1,
}

enum MSICONDITION
{
    MSICONDITION_FALSE = 0,
    MSICONDITION_TRUE = 1,
    MSICONDITION_NONE = 2,
    MSICONDITION_ERROR = 3,
}

enum MSICOSTTREE
{
    MSICOSTTREE_SELFONLY = 0,
    MSICOSTTREE_CHILDREN = 1,
    MSICOSTTREE_PARENTS = 2,
    MSICOSTTREE_RESERVED = 3,
}

enum MSIDBERROR
{
    MSIDBERROR_INVALIDARG = -3,
    MSIDBERROR_MOREDATA = -2,
    MSIDBERROR_FUNCTIONERROR = -1,
    MSIDBERROR_NOERROR = 0,
    MSIDBERROR_DUPLICATEKEY = 1,
    MSIDBERROR_REQUIRED = 2,
    MSIDBERROR_BADLINK = 3,
    MSIDBERROR_OVERFLOW = 4,
    MSIDBERROR_UNDERFLOW = 5,
    MSIDBERROR_NOTINSET = 6,
    MSIDBERROR_BADVERSION = 7,
    MSIDBERROR_BADCASE = 8,
    MSIDBERROR_BADGUID = 9,
    MSIDBERROR_BADWILDCARD = 10,
    MSIDBERROR_BADIDENTIFIER = 11,
    MSIDBERROR_BADLANGUAGE = 12,
    MSIDBERROR_BADFILENAME = 13,
    MSIDBERROR_BADPATH = 14,
    MSIDBERROR_BADCONDITION = 15,
    MSIDBERROR_BADFORMATTED = 16,
    MSIDBERROR_BADTEMPLATE = 17,
    MSIDBERROR_BADDEFAULTDIR = 18,
    MSIDBERROR_BADREGPATH = 19,
    MSIDBERROR_BADCUSTOMSOURCE = 20,
    MSIDBERROR_BADPROPERTY = 21,
    MSIDBERROR_MISSINGDATA = 22,
    MSIDBERROR_BADCATEGORY = 23,
    MSIDBERROR_BADKEYTABLE = 24,
    MSIDBERROR_BADMAXMINVALUES = 25,
    MSIDBERROR_BADCABINET = 26,
    MSIDBERROR_BADSHORTCUT = 27,
    MSIDBERROR_STRINGOVERFLOW = 28,
    MSIDBERROR_BADLOCALIZEATTRIB = 29,
}

enum MSIRUNMODE
{
    MSIRUNMODE_ADMIN = 0,
    MSIRUNMODE_ADVERTISE = 1,
    MSIRUNMODE_MAINTENANCE = 2,
    MSIRUNMODE_ROLLBACKENABLED = 3,
    MSIRUNMODE_LOGENABLED = 4,
    MSIRUNMODE_OPERATIONS = 5,
    MSIRUNMODE_REBOOTATEND = 6,
    MSIRUNMODE_REBOOTNOW = 7,
    MSIRUNMODE_CABINET = 8,
    MSIRUNMODE_SOURCESHORTNAMES = 9,
    MSIRUNMODE_TARGETSHORTNAMES = 10,
    MSIRUNMODE_RESERVED11 = 11,
    MSIRUNMODE_WINDOWS9X = 12,
    MSIRUNMODE_ZAWENABLED = 13,
    MSIRUNMODE_RESERVED14 = 14,
    MSIRUNMODE_RESERVED15 = 15,
    MSIRUNMODE_SCHEDULED = 16,
    MSIRUNMODE_ROLLBACK = 17,
    MSIRUNMODE_COMMIT = 18,
}

enum MSITRANSFORM_ERROR
{
    MSITRANSFORM_ERROR_ADDEXISTINGROW = 1,
    MSITRANSFORM_ERROR_DELMISSINGROW = 2,
    MSITRANSFORM_ERROR_ADDEXISTINGTABLE = 4,
    MSITRANSFORM_ERROR_DELMISSINGTABLE = 8,
    MSITRANSFORM_ERROR_UPDATEMISSINGROW = 16,
    MSITRANSFORM_ERROR_CHANGECODEPAGE = 32,
    MSITRANSFORM_ERROR_VIEWTRANSFORM = 256,
}

enum MSITRANSFORM_VALIDATE
{
    MSITRANSFORM_VALIDATE_LANGUAGE = 1,
    MSITRANSFORM_VALIDATE_PRODUCT = 2,
    MSITRANSFORM_VALIDATE_PLATFORM = 4,
    MSITRANSFORM_VALIDATE_MAJORVERSION = 8,
    MSITRANSFORM_VALIDATE_MINORVERSION = 16,
    MSITRANSFORM_VALIDATE_UPDATEVERSION = 32,
    MSITRANSFORM_VALIDATE_NEWLESSBASEVERSION = 64,
    MSITRANSFORM_VALIDATE_NEWLESSEQUALBASEVERSION = 128,
    MSITRANSFORM_VALIDATE_NEWEQUALBASEVERSION = 256,
    MSITRANSFORM_VALIDATE_NEWGREATEREQUALBASEVERSION = 512,
    MSITRANSFORM_VALIDATE_NEWGREATERBASEVERSION = 1024,
    MSITRANSFORM_VALIDATE_UPGRADECODE = 2048,
}

struct ASSEMBLY_INFO
{
    uint cbAssemblyInfo;
    uint dwAssemblyFlags;
    ULARGE_INTEGER uliAssemblySizeInKB;
    const(wchar)* pszCurrentAssemblyPathBuf;
    uint cchBuf;
}

struct FUSION_INSTALL_REFERENCE
{
    uint cbSize;
    uint dwFlags;
    Guid guidScheme;
    const(wchar)* szIdentifier;
    const(wchar)* szNonCannonicalData;
}

enum ASM_NAME
{
    ASM_NAME_PUBLIC_KEY = 0,
    ASM_NAME_PUBLIC_KEY_TOKEN = 1,
    ASM_NAME_HASH_VALUE = 2,
    ASM_NAME_NAME = 3,
    ASM_NAME_MAJOR_VERSION = 4,
    ASM_NAME_MINOR_VERSION = 5,
    ASM_NAME_BUILD_NUMBER = 6,
    ASM_NAME_REVISION_NUMBER = 7,
    ASM_NAME_CULTURE = 8,
    ASM_NAME_PROCESSOR_ID_ARRAY = 9,
    ASM_NAME_OSINFO_ARRAY = 10,
    ASM_NAME_HASH_ALGID = 11,
    ASM_NAME_ALIAS = 12,
    ASM_NAME_CODEBASE_URL = 13,
    ASM_NAME_CODEBASE_LASTMOD = 14,
    ASM_NAME_NULL_PUBLIC_KEY = 15,
    ASM_NAME_NULL_PUBLIC_KEY_TOKEN = 16,
    ASM_NAME_CUSTOM = 17,
    ASM_NAME_NULL_CUSTOM = 18,
    ASM_NAME_MVID = 19,
    ASM_NAME_MAX_PARAMS = 20,
}

enum __MIDL_IAssemblyName_0002
{
    ASM_BINDF_FORCE_CACHE_INSTALL = 1,
    ASM_BINDF_RFS_INTEGRITY_CHECK = 2,
    ASM_BINDF_RFS_MODULE_CHECK = 4,
    ASM_BINDF_BINPATH_PROBE_ONLY = 8,
    ASM_BINDF_SHARED_BINPATH_HINT = 16,
    ASM_BINDF_PARENT_ASM_HINT = 32,
}

enum ASM_DISPLAY_FLAGS
{
    ASM_DISPLAYF_VERSION = 1,
    ASM_DISPLAYF_CULTURE = 2,
    ASM_DISPLAYF_PUBLIC_KEY_TOKEN = 4,
    ASM_DISPLAYF_PUBLIC_KEY = 8,
    ASM_DISPLAYF_CUSTOM = 16,
    ASM_DISPLAYF_PROCESSORARCHITECTURE = 32,
    ASM_DISPLAYF_LANGUAGEID = 64,
}

enum ASM_CMP_FLAGS
{
    ASM_CMPF_NAME = 1,
    ASM_CMPF_MAJOR_VERSION = 2,
    ASM_CMPF_MINOR_VERSION = 4,
    ASM_CMPF_BUILD_NUMBER = 8,
    ASM_CMPF_REVISION_NUMBER = 16,
    ASM_CMPF_PUBLIC_KEY_TOKEN = 32,
    ASM_CMPF_CULTURE = 64,
    ASM_CMPF_CUSTOM = 128,
    ASM_CMPF_ALL = 255,
    ASM_CMPF_DEFAULT = 256,
}

const GUID IID_IAssemblyName = {0xCD193BC0, 0xB4BC, 0x11D2, [0x98, 0x33, 0x00, 0xC0, 0x4F, 0xC3, 0x1D, 0x2E]};
@GUID(0xCD193BC0, 0xB4BC, 0x11D2, [0x98, 0x33, 0x00, 0xC0, 0x4F, 0xC3, 0x1D, 0x2E]);
interface IAssemblyName : IUnknown
{
    HRESULT SetProperty(uint PropertyId, void* pvProperty, uint cbProperty);
    HRESULT GetProperty(uint PropertyId, void* pvProperty, uint* pcbProperty);
    HRESULT Finalize();
    HRESULT GetDisplayName(const(wchar)* szDisplayName, uint* pccDisplayName, uint dwDisplayFlags);
    HRESULT Reserved(const(Guid)* refIID, IUnknown pUnkReserved1, IUnknown pUnkReserved2, ushort* szReserved, long llReserved, void* pvReserved, uint cbReserved, void** ppReserved);
    HRESULT GetName(uint* lpcwBuffer, const(wchar)* pwzName);
    HRESULT GetVersion(uint* pdwVersionHi, uint* pdwVersionLow);
    HRESULT IsEqual(IAssemblyName pName, uint dwCmpFlags);
    HRESULT Clone(IAssemblyName* pName);
}

const GUID IID_IAssemblyCacheItem = {0x9E3AAEB4, 0xD1CD, 0x11D2, [0xBA, 0xB9, 0x00, 0xC0, 0x4F, 0x8E, 0xCE, 0xAE]};
@GUID(0x9E3AAEB4, 0xD1CD, 0x11D2, [0xBA, 0xB9, 0x00, 0xC0, 0x4F, 0x8E, 0xCE, 0xAE]);
interface IAssemblyCacheItem : IUnknown
{
    HRESULT CreateStream(uint dwFlags, const(wchar)* pszStreamName, uint dwFormat, uint dwFormatFlags, IStream* ppIStream, ULARGE_INTEGER* puliMaxSize);
    HRESULT Commit(uint dwFlags, uint* pulDisposition);
    HRESULT AbortItem();
}

const GUID IID_IAssemblyCache = {0xE707DCDE, 0xD1CD, 0x11D2, [0xBA, 0xB9, 0x00, 0xC0, 0x4F, 0x8E, 0xCE, 0xAE]};
@GUID(0xE707DCDE, 0xD1CD, 0x11D2, [0xBA, 0xB9, 0x00, 0xC0, 0x4F, 0x8E, 0xCE, 0xAE]);
interface IAssemblyCache : IUnknown
{
    HRESULT UninstallAssembly(uint dwFlags, const(wchar)* pszAssemblyName, FUSION_INSTALL_REFERENCE* pRefData, uint* pulDisposition);
    HRESULT QueryAssemblyInfo(uint dwFlags, const(wchar)* pszAssemblyName, ASSEMBLY_INFO* pAsmInfo);
    HRESULT CreateAssemblyCacheItem(uint dwFlags, void* pvReserved, IAssemblyCacheItem* ppAsmItem, const(wchar)* pszAssemblyName);
    HRESULT Reserved(IUnknown* ppUnk);
    HRESULT InstallAssembly(uint dwFlags, const(wchar)* pszManifestFilePath, FUSION_INSTALL_REFERENCE* pRefData);
}

enum CREATE_ASM_NAME_OBJ_FLAGS
{
    CANOF_PARSE_DISPLAY_NAME = 1,
    CANOF_SET_DEFAULT_VALUES = 2,
}

struct PROTECTED_FILE_DATA
{
    ushort FileName;
    uint FileNumber;
}

@DllImport("msi.dll")
uint MsiCloseHandle(uint hAny);

@DllImport("msi.dll")
uint MsiCloseAllHandles();

@DllImport("msi.dll")
INSTALLUILEVEL MsiSetInternalUI(INSTALLUILEVEL dwUILevel, HWND* phWnd);

@DllImport("msi.dll")
INSTALLUI_HANDLERA MsiSetExternalUIA(INSTALLUI_HANDLERA puiHandler, uint dwMessageFilter, void* pvContext);

@DllImport("msi.dll")
INSTALLUI_HANDLERW MsiSetExternalUIW(INSTALLUI_HANDLERW puiHandler, uint dwMessageFilter, void* pvContext);

@DllImport("msi.dll")
uint MsiSetExternalUIRecord(INSTALLUI_HANDLER_RECORD puiHandler, uint dwMessageFilter, void* pvContext, PINSTALLUI_HANDLER_RECORD ppuiPrevHandler);

@DllImport("msi.dll")
uint MsiEnableLogA(uint dwLogMode, const(char)* szLogFile, uint dwLogAttributes);

@DllImport("msi.dll")
uint MsiEnableLogW(uint dwLogMode, const(wchar)* szLogFile, uint dwLogAttributes);

@DllImport("msi.dll")
INSTALLSTATE MsiQueryProductStateA(const(char)* szProduct);

@DllImport("msi.dll")
INSTALLSTATE MsiQueryProductStateW(const(wchar)* szProduct);

@DllImport("msi.dll")
uint MsiGetProductInfoA(const(char)* szProduct, const(char)* szAttribute, const(char)* lpValueBuf, uint* pcchValueBuf);

@DllImport("msi.dll")
uint MsiGetProductInfoW(const(wchar)* szProduct, const(wchar)* szAttribute, const(wchar)* lpValueBuf, uint* pcchValueBuf);

@DllImport("msi.dll")
uint MsiGetProductInfoExA(const(char)* szProductCode, const(char)* szUserSid, MSIINSTALLCONTEXT dwContext, const(char)* szProperty, const(char)* szValue, uint* pcchValue);

@DllImport("msi.dll")
uint MsiGetProductInfoExW(const(wchar)* szProductCode, const(wchar)* szUserSid, MSIINSTALLCONTEXT dwContext, const(wchar)* szProperty, const(wchar)* szValue, uint* pcchValue);

@DllImport("msi.dll")
uint MsiInstallProductA(const(char)* szPackagePath, const(char)* szCommandLine);

@DllImport("msi.dll")
uint MsiInstallProductW(const(wchar)* szPackagePath, const(wchar)* szCommandLine);

@DllImport("msi.dll")
uint MsiConfigureProductA(const(char)* szProduct, int iInstallLevel, INSTALLSTATE eInstallState);

@DllImport("msi.dll")
uint MsiConfigureProductW(const(wchar)* szProduct, int iInstallLevel, INSTALLSTATE eInstallState);

@DllImport("msi.dll")
uint MsiConfigureProductExA(const(char)* szProduct, int iInstallLevel, INSTALLSTATE eInstallState, const(char)* szCommandLine);

@DllImport("msi.dll")
uint MsiConfigureProductExW(const(wchar)* szProduct, int iInstallLevel, INSTALLSTATE eInstallState, const(wchar)* szCommandLine);

@DllImport("msi.dll")
uint MsiReinstallProductA(const(char)* szProduct, uint szReinstallMode);

@DllImport("msi.dll")
uint MsiReinstallProductW(const(wchar)* szProduct, uint szReinstallMode);

@DllImport("msi.dll")
uint MsiAdvertiseProductExA(const(char)* szPackagePath, const(char)* szScriptfilePath, const(char)* szTransforms, ushort lgidLanguage, uint dwPlatform, uint dwOptions);

@DllImport("msi.dll")
uint MsiAdvertiseProductExW(const(wchar)* szPackagePath, const(wchar)* szScriptfilePath, const(wchar)* szTransforms, ushort lgidLanguage, uint dwPlatform, uint dwOptions);

@DllImport("msi.dll")
uint MsiAdvertiseProductA(const(char)* szPackagePath, const(char)* szScriptfilePath, const(char)* szTransforms, ushort lgidLanguage);

@DllImport("msi.dll")
uint MsiAdvertiseProductW(const(wchar)* szPackagePath, const(wchar)* szScriptfilePath, const(wchar)* szTransforms, ushort lgidLanguage);

@DllImport("msi.dll")
uint MsiProcessAdvertiseScriptA(const(char)* szScriptFile, const(char)* szIconFolder, HKEY hRegData, BOOL fShortcuts, BOOL fRemoveItems);

@DllImport("msi.dll")
uint MsiProcessAdvertiseScriptW(const(wchar)* szScriptFile, const(wchar)* szIconFolder, HKEY hRegData, BOOL fShortcuts, BOOL fRemoveItems);

@DllImport("msi.dll")
uint MsiAdvertiseScriptA(const(char)* szScriptFile, uint dwFlags, HKEY* phRegData, BOOL fRemoveItems);

@DllImport("msi.dll")
uint MsiAdvertiseScriptW(const(wchar)* szScriptFile, uint dwFlags, HKEY* phRegData, BOOL fRemoveItems);

@DllImport("msi.dll")
uint MsiGetProductInfoFromScriptA(const(char)* szScriptFile, const(char)* lpProductBuf39, ushort* plgidLanguage, uint* pdwVersion, const(char)* lpNameBuf, uint* pcchNameBuf, const(char)* lpPackageBuf, uint* pcchPackageBuf);

@DllImport("msi.dll")
uint MsiGetProductInfoFromScriptW(const(wchar)* szScriptFile, const(wchar)* lpProductBuf39, ushort* plgidLanguage, uint* pdwVersion, const(wchar)* lpNameBuf, uint* pcchNameBuf, const(wchar)* lpPackageBuf, uint* pcchPackageBuf);

@DllImport("msi.dll")
uint MsiGetProductCodeA(const(char)* szComponent, const(char)* lpBuf39);

@DllImport("msi.dll")
uint MsiGetProductCodeW(const(wchar)* szComponent, const(wchar)* lpBuf39);

@DllImport("msi.dll")
USERINFOSTATE MsiGetUserInfoA(const(char)* szProduct, const(char)* lpUserNameBuf, uint* pcchUserNameBuf, const(char)* lpOrgNameBuf, uint* pcchOrgNameBuf, const(char)* lpSerialBuf, uint* pcchSerialBuf);

@DllImport("msi.dll")
USERINFOSTATE MsiGetUserInfoW(const(wchar)* szProduct, const(wchar)* lpUserNameBuf, uint* pcchUserNameBuf, const(wchar)* lpOrgNameBuf, uint* pcchOrgNameBuf, const(wchar)* lpSerialBuf, uint* pcchSerialBuf);

@DllImport("msi.dll")
uint MsiCollectUserInfoA(const(char)* szProduct);

@DllImport("msi.dll")
uint MsiCollectUserInfoW(const(wchar)* szProduct);

@DllImport("msi.dll")
uint MsiApplyPatchA(const(char)* szPatchPackage, const(char)* szInstallPackage, INSTALLTYPE eInstallType, const(char)* szCommandLine);

@DllImport("msi.dll")
uint MsiApplyPatchW(const(wchar)* szPatchPackage, const(wchar)* szInstallPackage, INSTALLTYPE eInstallType, const(wchar)* szCommandLine);

@DllImport("msi.dll")
uint MsiGetPatchInfoA(const(char)* szPatch, const(char)* szAttribute, const(char)* lpValueBuf, uint* pcchValueBuf);

@DllImport("msi.dll")
uint MsiGetPatchInfoW(const(wchar)* szPatch, const(wchar)* szAttribute, const(wchar)* lpValueBuf, uint* pcchValueBuf);

@DllImport("msi.dll")
uint MsiEnumPatchesA(const(char)* szProduct, uint iPatchIndex, const(char)* lpPatchBuf, const(char)* lpTransformsBuf, uint* pcchTransformsBuf);

@DllImport("msi.dll")
uint MsiEnumPatchesW(const(wchar)* szProduct, uint iPatchIndex, const(wchar)* lpPatchBuf, const(wchar)* lpTransformsBuf, uint* pcchTransformsBuf);

@DllImport("msi.dll")
uint MsiRemovePatchesA(const(char)* szPatchList, const(char)* szProductCode, INSTALLTYPE eUninstallType, const(char)* szPropertyList);

@DllImport("msi.dll")
uint MsiRemovePatchesW(const(wchar)* szPatchList, const(wchar)* szProductCode, INSTALLTYPE eUninstallType, const(wchar)* szPropertyList);

@DllImport("msi.dll")
uint MsiExtractPatchXMLDataA(const(char)* szPatchPath, uint dwReserved, const(char)* szXMLData, uint* pcchXMLData);

@DllImport("msi.dll")
uint MsiExtractPatchXMLDataW(const(wchar)* szPatchPath, uint dwReserved, const(wchar)* szXMLData, uint* pcchXMLData);

@DllImport("msi.dll")
uint MsiGetPatchInfoExA(const(char)* szPatchCode, const(char)* szProductCode, const(char)* szUserSid, MSIINSTALLCONTEXT dwContext, const(char)* szProperty, const(char)* lpValue, uint* pcchValue);

@DllImport("msi.dll")
uint MsiGetPatchInfoExW(const(wchar)* szPatchCode, const(wchar)* szProductCode, const(wchar)* szUserSid, MSIINSTALLCONTEXT dwContext, const(wchar)* szProperty, const(wchar)* lpValue, uint* pcchValue);

@DllImport("msi.dll")
uint MsiApplyMultiplePatchesA(const(char)* szPatchPackages, const(char)* szProductCode, const(char)* szPropertiesList);

@DllImport("msi.dll")
uint MsiApplyMultiplePatchesW(const(wchar)* szPatchPackages, const(wchar)* szProductCode, const(wchar)* szPropertiesList);

@DllImport("msi.dll")
uint MsiDeterminePatchSequenceA(const(char)* szProductCode, const(char)* szUserSid, MSIINSTALLCONTEXT dwContext, uint cPatchInfo, char* pPatchInfo);

@DllImport("msi.dll")
uint MsiDeterminePatchSequenceW(const(wchar)* szProductCode, const(wchar)* szUserSid, MSIINSTALLCONTEXT dwContext, uint cPatchInfo, char* pPatchInfo);

@DllImport("msi.dll")
uint MsiDetermineApplicablePatchesA(const(char)* szProductPackagePath, uint cPatchInfo, char* pPatchInfo);

@DllImport("msi.dll")
uint MsiDetermineApplicablePatchesW(const(wchar)* szProductPackagePath, uint cPatchInfo, char* pPatchInfo);

@DllImport("msi.dll")
uint MsiEnumPatchesExA(const(char)* szProductCode, const(char)* szUserSid, uint dwContext, uint dwFilter, uint dwIndex, char* szPatchCode, char* szTargetProductCode, MSIINSTALLCONTEXT* pdwTargetProductContext, const(char)* szTargetUserSid, uint* pcchTargetUserSid);

@DllImport("msi.dll")
uint MsiEnumPatchesExW(const(wchar)* szProductCode, const(wchar)* szUserSid, uint dwContext, uint dwFilter, uint dwIndex, char* szPatchCode, char* szTargetProductCode, MSIINSTALLCONTEXT* pdwTargetProductContext, const(wchar)* szTargetUserSid, uint* pcchTargetUserSid);

@DllImport("msi.dll")
INSTALLSTATE MsiQueryFeatureStateA(const(char)* szProduct, const(char)* szFeature);

@DllImport("msi.dll")
INSTALLSTATE MsiQueryFeatureStateW(const(wchar)* szProduct, const(wchar)* szFeature);

@DllImport("msi.dll")
uint MsiQueryFeatureStateExA(const(char)* szProductCode, const(char)* szUserSid, MSIINSTALLCONTEXT dwContext, const(char)* szFeature, INSTALLSTATE* pdwState);

@DllImport("msi.dll")
uint MsiQueryFeatureStateExW(const(wchar)* szProductCode, const(wchar)* szUserSid, MSIINSTALLCONTEXT dwContext, const(wchar)* szFeature, INSTALLSTATE* pdwState);

@DllImport("msi.dll")
INSTALLSTATE MsiUseFeatureA(const(char)* szProduct, const(char)* szFeature);

@DllImport("msi.dll")
INSTALLSTATE MsiUseFeatureW(const(wchar)* szProduct, const(wchar)* szFeature);

@DllImport("msi.dll")
INSTALLSTATE MsiUseFeatureExA(const(char)* szProduct, const(char)* szFeature, uint dwInstallMode, uint dwReserved);

@DllImport("msi.dll")
INSTALLSTATE MsiUseFeatureExW(const(wchar)* szProduct, const(wchar)* szFeature, uint dwInstallMode, uint dwReserved);

@DllImport("msi.dll")
uint MsiGetFeatureUsageA(const(char)* szProduct, const(char)* szFeature, uint* pdwUseCount, ushort* pwDateUsed);

@DllImport("msi.dll")
uint MsiGetFeatureUsageW(const(wchar)* szProduct, const(wchar)* szFeature, uint* pdwUseCount, ushort* pwDateUsed);

@DllImport("msi.dll")
uint MsiConfigureFeatureA(const(char)* szProduct, const(char)* szFeature, INSTALLSTATE eInstallState);

@DllImport("msi.dll")
uint MsiConfigureFeatureW(const(wchar)* szProduct, const(wchar)* szFeature, INSTALLSTATE eInstallState);

@DllImport("msi.dll")
uint MsiReinstallFeatureA(const(char)* szProduct, const(char)* szFeature, uint dwReinstallMode);

@DllImport("msi.dll")
uint MsiReinstallFeatureW(const(wchar)* szProduct, const(wchar)* szFeature, uint dwReinstallMode);

@DllImport("msi.dll")
uint MsiProvideComponentA(const(char)* szProduct, const(char)* szFeature, const(char)* szComponent, uint dwInstallMode, const(char)* lpPathBuf, uint* pcchPathBuf);

@DllImport("msi.dll")
uint MsiProvideComponentW(const(wchar)* szProduct, const(wchar)* szFeature, const(wchar)* szComponent, uint dwInstallMode, const(wchar)* lpPathBuf, uint* pcchPathBuf);

@DllImport("msi.dll")
uint MsiProvideQualifiedComponentA(const(char)* szCategory, const(char)* szQualifier, uint dwInstallMode, const(char)* lpPathBuf, uint* pcchPathBuf);

@DllImport("msi.dll")
uint MsiProvideQualifiedComponentW(const(wchar)* szCategory, const(wchar)* szQualifier, uint dwInstallMode, const(wchar)* lpPathBuf, uint* pcchPathBuf);

@DllImport("msi.dll")
uint MsiProvideQualifiedComponentExA(const(char)* szCategory, const(char)* szQualifier, uint dwInstallMode, const(char)* szProduct, uint dwUnused1, uint dwUnused2, const(char)* lpPathBuf, uint* pcchPathBuf);

@DllImport("msi.dll")
uint MsiProvideQualifiedComponentExW(const(wchar)* szCategory, const(wchar)* szQualifier, uint dwInstallMode, const(wchar)* szProduct, uint dwUnused1, uint dwUnused2, const(wchar)* lpPathBuf, uint* pcchPathBuf);

@DllImport("msi.dll")
INSTALLSTATE MsiGetComponentPathA(const(char)* szProduct, const(char)* szComponent, const(char)* lpPathBuf, uint* pcchBuf);

@DllImport("msi.dll")
INSTALLSTATE MsiGetComponentPathW(const(wchar)* szProduct, const(wchar)* szComponent, const(wchar)* lpPathBuf, uint* pcchBuf);

@DllImport("msi.dll")
INSTALLSTATE MsiGetComponentPathExA(const(char)* szProductCode, const(char)* szComponentCode, const(char)* szUserSid, MSIINSTALLCONTEXT dwContext, const(char)* lpOutPathBuffer, uint* pcchOutPathBuffer);

@DllImport("msi.dll")
INSTALLSTATE MsiGetComponentPathExW(const(wchar)* szProductCode, const(wchar)* szComponentCode, const(wchar)* szUserSid, MSIINSTALLCONTEXT dwContext, const(wchar)* lpOutPathBuffer, uint* pcchOutPathBuffer);

@DllImport("msi.dll")
uint MsiProvideAssemblyA(const(char)* szAssemblyName, const(char)* szAppContext, uint dwInstallMode, uint dwAssemblyInfo, const(char)* lpPathBuf, uint* pcchPathBuf);

@DllImport("msi.dll")
uint MsiProvideAssemblyW(const(wchar)* szAssemblyName, const(wchar)* szAppContext, uint dwInstallMode, uint dwAssemblyInfo, const(wchar)* lpPathBuf, uint* pcchPathBuf);

@DllImport("msi.dll")
uint MsiQueryComponentStateA(const(char)* szProductCode, const(char)* szUserSid, MSIINSTALLCONTEXT dwContext, const(char)* szComponentCode, INSTALLSTATE* pdwState);

@DllImport("msi.dll")
uint MsiQueryComponentStateW(const(wchar)* szProductCode, const(wchar)* szUserSid, MSIINSTALLCONTEXT dwContext, const(wchar)* szComponentCode, INSTALLSTATE* pdwState);

@DllImport("msi.dll")
uint MsiEnumProductsA(uint iProductIndex, const(char)* lpProductBuf);

@DllImport("msi.dll")
uint MsiEnumProductsW(uint iProductIndex, const(wchar)* lpProductBuf);

@DllImport("msi.dll")
uint MsiEnumProductsExA(const(char)* szProductCode, const(char)* szUserSid, uint dwContext, uint dwIndex, char* szInstalledProductCode, MSIINSTALLCONTEXT* pdwInstalledContext, const(char)* szSid, uint* pcchSid);

@DllImport("msi.dll")
uint MsiEnumProductsExW(const(wchar)* szProductCode, const(wchar)* szUserSid, uint dwContext, uint dwIndex, char* szInstalledProductCode, MSIINSTALLCONTEXT* pdwInstalledContext, const(wchar)* szSid, uint* pcchSid);

@DllImport("msi.dll")
uint MsiEnumRelatedProductsA(const(char)* lpUpgradeCode, uint dwReserved, uint iProductIndex, const(char)* lpProductBuf);

@DllImport("msi.dll")
uint MsiEnumRelatedProductsW(const(wchar)* lpUpgradeCode, uint dwReserved, uint iProductIndex, const(wchar)* lpProductBuf);

@DllImport("msi.dll")
uint MsiEnumFeaturesA(const(char)* szProduct, uint iFeatureIndex, const(char)* lpFeatureBuf, const(char)* lpParentBuf);

@DllImport("msi.dll")
uint MsiEnumFeaturesW(const(wchar)* szProduct, uint iFeatureIndex, const(wchar)* lpFeatureBuf, const(wchar)* lpParentBuf);

@DllImport("msi.dll")
uint MsiEnumComponentsA(uint iComponentIndex, const(char)* lpComponentBuf);

@DllImport("msi.dll")
uint MsiEnumComponentsW(uint iComponentIndex, const(wchar)* lpComponentBuf);

@DllImport("msi.dll")
uint MsiEnumComponentsExA(const(char)* szUserSid, uint dwContext, uint dwIndex, char* szInstalledComponentCode, MSIINSTALLCONTEXT* pdwInstalledContext, const(char)* szSid, uint* pcchSid);

@DllImport("msi.dll")
uint MsiEnumComponentsExW(const(wchar)* szUserSid, uint dwContext, uint dwIndex, char* szInstalledComponentCode, MSIINSTALLCONTEXT* pdwInstalledContext, const(wchar)* szSid, uint* pcchSid);

@DllImport("msi.dll")
uint MsiEnumClientsA(const(char)* szComponent, uint iProductIndex, const(char)* lpProductBuf);

@DllImport("msi.dll")
uint MsiEnumClientsW(const(wchar)* szComponent, uint iProductIndex, const(wchar)* lpProductBuf);

@DllImport("msi.dll")
uint MsiEnumClientsExA(const(char)* szComponent, const(char)* szUserSid, uint dwContext, uint dwProductIndex, char* szProductBuf, MSIINSTALLCONTEXT* pdwInstalledContext, const(char)* szSid, uint* pcchSid);

@DllImport("msi.dll")
uint MsiEnumClientsExW(const(wchar)* szComponent, const(wchar)* szUserSid, uint dwContext, uint dwProductIndex, char* szProductBuf, MSIINSTALLCONTEXT* pdwInstalledContext, const(wchar)* szSid, uint* pcchSid);

@DllImport("msi.dll")
uint MsiEnumComponentQualifiersA(const(char)* szComponent, uint iIndex, const(char)* lpQualifierBuf, uint* pcchQualifierBuf, const(char)* lpApplicationDataBuf, uint* pcchApplicationDataBuf);

@DllImport("msi.dll")
uint MsiEnumComponentQualifiersW(const(wchar)* szComponent, uint iIndex, const(wchar)* lpQualifierBuf, uint* pcchQualifierBuf, const(wchar)* lpApplicationDataBuf, uint* pcchApplicationDataBuf);

@DllImport("msi.dll")
uint MsiOpenProductA(const(char)* szProduct, uint* hProduct);

@DllImport("msi.dll")
uint MsiOpenProductW(const(wchar)* szProduct, uint* hProduct);

@DllImport("msi.dll")
uint MsiOpenPackageA(const(char)* szPackagePath, uint* hProduct);

@DllImport("msi.dll")
uint MsiOpenPackageW(const(wchar)* szPackagePath, uint* hProduct);

@DllImport("msi.dll")
uint MsiOpenPackageExA(const(char)* szPackagePath, uint dwOptions, uint* hProduct);

@DllImport("msi.dll")
uint MsiOpenPackageExW(const(wchar)* szPackagePath, uint dwOptions, uint* hProduct);

@DllImport("msi.dll")
uint MsiGetPatchFileListA(const(char)* szProductCode, const(char)* szPatchPackages, uint* pcFiles, uint** pphFileRecords);

@DllImport("msi.dll")
uint MsiGetPatchFileListW(const(wchar)* szProductCode, const(wchar)* szPatchPackages, uint* pcFiles, uint** pphFileRecords);

@DllImport("msi.dll")
uint MsiGetProductPropertyA(uint hProduct, const(char)* szProperty, const(char)* lpValueBuf, uint* pcchValueBuf);

@DllImport("msi.dll")
uint MsiGetProductPropertyW(uint hProduct, const(wchar)* szProperty, const(wchar)* lpValueBuf, uint* pcchValueBuf);

@DllImport("msi.dll")
uint MsiVerifyPackageA(const(char)* szPackagePath);

@DllImport("msi.dll")
uint MsiVerifyPackageW(const(wchar)* szPackagePath);

@DllImport("msi.dll")
uint MsiGetFeatureInfoA(uint hProduct, const(char)* szFeature, uint* lpAttributes, const(char)* lpTitleBuf, uint* pcchTitleBuf, const(char)* lpHelpBuf, uint* pcchHelpBuf);

@DllImport("msi.dll")
uint MsiGetFeatureInfoW(uint hProduct, const(wchar)* szFeature, uint* lpAttributes, const(wchar)* lpTitleBuf, uint* pcchTitleBuf, const(wchar)* lpHelpBuf, uint* pcchHelpBuf);

@DllImport("msi.dll")
uint MsiInstallMissingComponentA(const(char)* szProduct, const(char)* szComponent, INSTALLSTATE eInstallState);

@DllImport("msi.dll")
uint MsiInstallMissingComponentW(const(wchar)* szProduct, const(wchar)* szComponent, INSTALLSTATE eInstallState);

@DllImport("msi.dll")
uint MsiInstallMissingFileA(const(char)* szProduct, const(char)* szFile);

@DllImport("msi.dll")
uint MsiInstallMissingFileW(const(wchar)* szProduct, const(wchar)* szFile);

@DllImport("msi.dll")
INSTALLSTATE MsiLocateComponentA(const(char)* szComponent, const(char)* lpPathBuf, uint* pcchBuf);

@DllImport("msi.dll")
INSTALLSTATE MsiLocateComponentW(const(wchar)* szComponent, const(wchar)* lpPathBuf, uint* pcchBuf);

@DllImport("msi.dll")
uint MsiSourceListClearAllA(const(char)* szProduct, const(char)* szUserName, uint dwReserved);

@DllImport("msi.dll")
uint MsiSourceListClearAllW(const(wchar)* szProduct, const(wchar)* szUserName, uint dwReserved);

@DllImport("msi.dll")
uint MsiSourceListAddSourceA(const(char)* szProduct, const(char)* szUserName, uint dwReserved, const(char)* szSource);

@DllImport("msi.dll")
uint MsiSourceListAddSourceW(const(wchar)* szProduct, const(wchar)* szUserName, uint dwReserved, const(wchar)* szSource);

@DllImport("msi.dll")
uint MsiSourceListForceResolutionA(const(char)* szProduct, const(char)* szUserName, uint dwReserved);

@DllImport("msi.dll")
uint MsiSourceListForceResolutionW(const(wchar)* szProduct, const(wchar)* szUserName, uint dwReserved);

@DllImport("msi.dll")
uint MsiSourceListAddSourceExA(const(char)* szProductCodeOrPatchCode, const(char)* szUserSid, MSIINSTALLCONTEXT dwContext, uint dwOptions, const(char)* szSource, uint dwIndex);

@DllImport("msi.dll")
uint MsiSourceListAddSourceExW(const(wchar)* szProductCodeOrPatchCode, const(wchar)* szUserSid, MSIINSTALLCONTEXT dwContext, uint dwOptions, const(wchar)* szSource, uint dwIndex);

@DllImport("msi.dll")
uint MsiSourceListAddMediaDiskA(const(char)* szProductCodeOrPatchCode, const(char)* szUserSid, MSIINSTALLCONTEXT dwContext, uint dwOptions, uint dwDiskId, const(char)* szVolumeLabel, const(char)* szDiskPrompt);

@DllImport("msi.dll")
uint MsiSourceListAddMediaDiskW(const(wchar)* szProductCodeOrPatchCode, const(wchar)* szUserSid, MSIINSTALLCONTEXT dwContext, uint dwOptions, uint dwDiskId, const(wchar)* szVolumeLabel, const(wchar)* szDiskPrompt);

@DllImport("msi.dll")
uint MsiSourceListClearSourceA(const(char)* szProductCodeOrPatchCode, const(char)* szUserSid, MSIINSTALLCONTEXT dwContext, uint dwOptions, const(char)* szSource);

@DllImport("msi.dll")
uint MsiSourceListClearSourceW(const(wchar)* szProductCodeOrPatchCode, const(wchar)* szUserSid, MSIINSTALLCONTEXT dwContext, uint dwOptions, const(wchar)* szSource);

@DllImport("msi.dll")
uint MsiSourceListClearMediaDiskA(const(char)* szProductCodeOrPatchCode, const(char)* szUserSid, MSIINSTALLCONTEXT dwContext, uint dwOptions, uint dwDiskId);

@DllImport("msi.dll")
uint MsiSourceListClearMediaDiskW(const(wchar)* szProductCodeOrPatchCode, const(wchar)* szUserSid, MSIINSTALLCONTEXT dwContext, uint dwOptions, uint dwDiskId);

@DllImport("msi.dll")
uint MsiSourceListClearAllExA(const(char)* szProductCodeOrPatchCode, const(char)* szUserSid, MSIINSTALLCONTEXT dwContext, uint dwOptions);

@DllImport("msi.dll")
uint MsiSourceListClearAllExW(const(wchar)* szProductCodeOrPatchCode, const(wchar)* szUserSid, MSIINSTALLCONTEXT dwContext, uint dwOptions);

@DllImport("msi.dll")
uint MsiSourceListForceResolutionExA(const(char)* szProductCodeOrPatchCode, const(char)* szUserSid, MSIINSTALLCONTEXT dwContext, uint dwOptions);

@DllImport("msi.dll")
uint MsiSourceListForceResolutionExW(const(wchar)* szProductCodeOrPatchCode, const(wchar)* szUserSid, MSIINSTALLCONTEXT dwContext, uint dwOptions);

@DllImport("msi.dll")
uint MsiSourceListSetInfoA(const(char)* szProductCodeOrPatchCode, const(char)* szUserSid, MSIINSTALLCONTEXT dwContext, uint dwOptions, const(char)* szProperty, const(char)* szValue);

@DllImport("msi.dll")
uint MsiSourceListSetInfoW(const(wchar)* szProductCodeOrPatchCode, const(wchar)* szUserSid, MSIINSTALLCONTEXT dwContext, uint dwOptions, const(wchar)* szProperty, const(wchar)* szValue);

@DllImport("msi.dll")
uint MsiSourceListGetInfoA(const(char)* szProductCodeOrPatchCode, const(char)* szUserSid, MSIINSTALLCONTEXT dwContext, uint dwOptions, const(char)* szProperty, const(char)* szValue, uint* pcchValue);

@DllImport("msi.dll")
uint MsiSourceListGetInfoW(const(wchar)* szProductCodeOrPatchCode, const(wchar)* szUserSid, MSIINSTALLCONTEXT dwContext, uint dwOptions, const(wchar)* szProperty, const(wchar)* szValue, uint* pcchValue);

@DllImport("msi.dll")
uint MsiSourceListEnumSourcesA(const(char)* szProductCodeOrPatchCode, const(char)* szUserSid, MSIINSTALLCONTEXT dwContext, uint dwOptions, uint dwIndex, const(char)* szSource, uint* pcchSource);

@DllImport("msi.dll")
uint MsiSourceListEnumSourcesW(const(wchar)* szProductCodeOrPatchCode, const(wchar)* szUserSid, MSIINSTALLCONTEXT dwContext, uint dwOptions, uint dwIndex, const(wchar)* szSource, uint* pcchSource);

@DllImport("msi.dll")
uint MsiSourceListEnumMediaDisksA(const(char)* szProductCodeOrPatchCode, const(char)* szUserSid, MSIINSTALLCONTEXT dwContext, uint dwOptions, uint dwIndex, uint* pdwDiskId, const(char)* szVolumeLabel, uint* pcchVolumeLabel, const(char)* szDiskPrompt, uint* pcchDiskPrompt);

@DllImport("msi.dll")
uint MsiSourceListEnumMediaDisksW(const(wchar)* szProductCodeOrPatchCode, const(wchar)* szUserSid, MSIINSTALLCONTEXT dwContext, uint dwOptions, uint dwIndex, uint* pdwDiskId, const(wchar)* szVolumeLabel, uint* pcchVolumeLabel, const(wchar)* szDiskPrompt, uint* pcchDiskPrompt);

@DllImport("msi.dll")
uint MsiGetFileVersionA(const(char)* szFilePath, const(char)* lpVersionBuf, uint* pcchVersionBuf, const(char)* lpLangBuf, uint* pcchLangBuf);

@DllImport("msi.dll")
uint MsiGetFileVersionW(const(wchar)* szFilePath, const(wchar)* lpVersionBuf, uint* pcchVersionBuf, const(wchar)* lpLangBuf, uint* pcchLangBuf);

@DllImport("msi.dll")
uint MsiGetFileHashA(const(char)* szFilePath, uint dwOptions, MSIFILEHASHINFO* pHash);

@DllImport("msi.dll")
uint MsiGetFileHashW(const(wchar)* szFilePath, uint dwOptions, MSIFILEHASHINFO* pHash);

@DllImport("msi.dll")
HRESULT MsiGetFileSignatureInformationA(const(char)* szSignedObjectPath, uint dwFlags, CERT_CONTEXT** ppcCertContext, char* pbHashData, uint* pcbHashData);

@DllImport("msi.dll")
HRESULT MsiGetFileSignatureInformationW(const(wchar)* szSignedObjectPath, uint dwFlags, CERT_CONTEXT** ppcCertContext, char* pbHashData, uint* pcbHashData);

@DllImport("msi.dll")
uint MsiGetShortcutTargetA(const(char)* szShortcutPath, const(char)* szProductCode, const(char)* szFeatureId, const(char)* szComponentCode);

@DllImport("msi.dll")
uint MsiGetShortcutTargetW(const(wchar)* szShortcutPath, const(wchar)* szProductCode, const(wchar)* szFeatureId, const(wchar)* szComponentCode);

@DllImport("msi.dll")
uint MsiIsProductElevatedA(const(char)* szProduct, int* pfElevated);

@DllImport("msi.dll")
uint MsiIsProductElevatedW(const(wchar)* szProduct, int* pfElevated);

@DllImport("msi.dll")
uint MsiNotifySidChangeA(const(char)* pOldSid, const(char)* pNewSid);

@DllImport("msi.dll")
uint MsiNotifySidChangeW(const(wchar)* pOldSid, const(wchar)* pNewSid);

@DllImport("msi.dll")
uint MsiBeginTransactionA(const(char)* szName, uint dwTransactionAttributes, uint* phTransactionHandle, HANDLE* phChangeOfOwnerEvent);

@DllImport("msi.dll")
uint MsiBeginTransactionW(const(wchar)* szName, uint dwTransactionAttributes, uint* phTransactionHandle, HANDLE* phChangeOfOwnerEvent);

@DllImport("msi.dll")
uint MsiEndTransaction(uint dwTransactionState);

@DllImport("msi.dll")
uint MsiJoinTransaction(uint hTransactionHandle, uint dwTransactionAttributes, HANDLE* phChangeOfOwnerEvent);

@DllImport("msi.dll")
uint MsiDatabaseOpenViewA(uint hDatabase, const(char)* szQuery, uint* phView);

@DllImport("msi.dll")
uint MsiDatabaseOpenViewW(uint hDatabase, const(wchar)* szQuery, uint* phView);

@DllImport("msi.dll")
MSIDBERROR MsiViewGetErrorA(uint hView, const(char)* szColumnNameBuffer, uint* pcchBuf);

@DllImport("msi.dll")
MSIDBERROR MsiViewGetErrorW(uint hView, const(wchar)* szColumnNameBuffer, uint* pcchBuf);

@DllImport("msi.dll")
uint MsiViewExecute(uint hView, uint hRecord);

@DllImport("msi.dll")
uint MsiViewFetch(uint hView, uint* phRecord);

@DllImport("msi.dll")
uint MsiViewModify(uint hView, MSIMODIFY eModifyMode, uint hRecord);

@DllImport("msi.dll")
uint MsiViewGetColumnInfo(uint hView, MSICOLINFO eColumnInfo, uint* phRecord);

@DllImport("msi.dll")
uint MsiViewClose(uint hView);

@DllImport("msi.dll")
uint MsiDatabaseGetPrimaryKeysA(uint hDatabase, const(char)* szTableName, uint* phRecord);

@DllImport("msi.dll")
uint MsiDatabaseGetPrimaryKeysW(uint hDatabase, const(wchar)* szTableName, uint* phRecord);

@DllImport("msi.dll")
MSICONDITION MsiDatabaseIsTablePersistentA(uint hDatabase, const(char)* szTableName);

@DllImport("msi.dll")
MSICONDITION MsiDatabaseIsTablePersistentW(uint hDatabase, const(wchar)* szTableName);

@DllImport("msi.dll")
uint MsiGetSummaryInformationA(uint hDatabase, const(char)* szDatabasePath, uint uiUpdateCount, uint* phSummaryInfo);

@DllImport("msi.dll")
uint MsiGetSummaryInformationW(uint hDatabase, const(wchar)* szDatabasePath, uint uiUpdateCount, uint* phSummaryInfo);

@DllImport("msi.dll")
uint MsiSummaryInfoGetPropertyCount(uint hSummaryInfo, uint* puiPropertyCount);

@DllImport("msi.dll")
uint MsiSummaryInfoSetPropertyA(uint hSummaryInfo, uint uiProperty, uint uiDataType, int iValue, FILETIME* pftValue, const(char)* szValue);

@DllImport("msi.dll")
uint MsiSummaryInfoSetPropertyW(uint hSummaryInfo, uint uiProperty, uint uiDataType, int iValue, FILETIME* pftValue, const(wchar)* szValue);

@DllImport("msi.dll")
uint MsiSummaryInfoGetPropertyA(uint hSummaryInfo, uint uiProperty, uint* puiDataType, int* piValue, FILETIME* pftValue, const(char)* szValueBuf, uint* pcchValueBuf);

@DllImport("msi.dll")
uint MsiSummaryInfoGetPropertyW(uint hSummaryInfo, uint uiProperty, uint* puiDataType, int* piValue, FILETIME* pftValue, const(wchar)* szValueBuf, uint* pcchValueBuf);

@DllImport("msi.dll")
uint MsiSummaryInfoPersist(uint hSummaryInfo);

@DllImport("msi.dll")
uint MsiOpenDatabaseA(const(char)* szDatabasePath, const(char)* szPersist, uint* phDatabase);

@DllImport("msi.dll")
uint MsiOpenDatabaseW(const(wchar)* szDatabasePath, const(wchar)* szPersist, uint* phDatabase);

@DllImport("msi.dll")
uint MsiDatabaseImportA(uint hDatabase, const(char)* szFolderPath, const(char)* szFileName);

@DllImport("msi.dll")
uint MsiDatabaseImportW(uint hDatabase, const(wchar)* szFolderPath, const(wchar)* szFileName);

@DllImport("msi.dll")
uint MsiDatabaseExportA(uint hDatabase, const(char)* szTableName, const(char)* szFolderPath, const(char)* szFileName);

@DllImport("msi.dll")
uint MsiDatabaseExportW(uint hDatabase, const(wchar)* szTableName, const(wchar)* szFolderPath, const(wchar)* szFileName);

@DllImport("msi.dll")
uint MsiDatabaseMergeA(uint hDatabase, uint hDatabaseMerge, const(char)* szTableName);

@DllImport("msi.dll")
uint MsiDatabaseMergeW(uint hDatabase, uint hDatabaseMerge, const(wchar)* szTableName);

@DllImport("msi.dll")
uint MsiDatabaseGenerateTransformA(uint hDatabase, uint hDatabaseReference, const(char)* szTransformFile, int iReserved1, int iReserved2);

@DllImport("msi.dll")
uint MsiDatabaseGenerateTransformW(uint hDatabase, uint hDatabaseReference, const(wchar)* szTransformFile, int iReserved1, int iReserved2);

@DllImport("msi.dll")
uint MsiDatabaseApplyTransformA(uint hDatabase, const(char)* szTransformFile, int iErrorConditions);

@DllImport("msi.dll")
uint MsiDatabaseApplyTransformW(uint hDatabase, const(wchar)* szTransformFile, int iErrorConditions);

@DllImport("msi.dll")
uint MsiCreateTransformSummaryInfoA(uint hDatabase, uint hDatabaseReference, const(char)* szTransformFile, int iErrorConditions, int iValidation);

@DllImport("msi.dll")
uint MsiCreateTransformSummaryInfoW(uint hDatabase, uint hDatabaseReference, const(wchar)* szTransformFile, int iErrorConditions, int iValidation);

@DllImport("msi.dll")
uint MsiDatabaseCommit(uint hDatabase);

@DllImport("msi.dll")
MSIDBSTATE MsiGetDatabaseState(uint hDatabase);

@DllImport("msi.dll")
uint MsiCreateRecord(uint cParams);

@DllImport("msi.dll")
BOOL MsiRecordIsNull(uint hRecord, uint iField);

@DllImport("msi.dll")
uint MsiRecordDataSize(uint hRecord, uint iField);

@DllImport("msi.dll")
uint MsiRecordSetInteger(uint hRecord, uint iField, int iValue);

@DllImport("msi.dll")
uint MsiRecordSetStringA(uint hRecord, uint iField, const(char)* szValue);

@DllImport("msi.dll")
uint MsiRecordSetStringW(uint hRecord, uint iField, const(wchar)* szValue);

@DllImport("msi.dll")
int MsiRecordGetInteger(uint hRecord, uint iField);

@DllImport("msi.dll")
uint MsiRecordGetStringA(uint hRecord, uint iField, const(char)* szValueBuf, uint* pcchValueBuf);

@DllImport("msi.dll")
uint MsiRecordGetStringW(uint hRecord, uint iField, const(wchar)* szValueBuf, uint* pcchValueBuf);

@DllImport("msi.dll")
uint MsiRecordGetFieldCount(uint hRecord);

@DllImport("msi.dll")
uint MsiRecordSetStreamA(uint hRecord, uint iField, const(char)* szFilePath);

@DllImport("msi.dll")
uint MsiRecordSetStreamW(uint hRecord, uint iField, const(wchar)* szFilePath);

@DllImport("msi.dll")
uint MsiRecordReadStream(uint hRecord, uint iField, char* szDataBuf, uint* pcbDataBuf);

@DllImport("msi.dll")
uint MsiRecordClearData(uint hRecord);

@DllImport("msi.dll")
uint MsiGetActiveDatabase(uint hInstall);

@DllImport("msi.dll")
uint MsiSetPropertyA(uint hInstall, const(char)* szName, const(char)* szValue);

@DllImport("msi.dll")
uint MsiSetPropertyW(uint hInstall, const(wchar)* szName, const(wchar)* szValue);

@DllImport("msi.dll")
uint MsiGetPropertyA(uint hInstall, const(char)* szName, const(char)* szValueBuf, uint* pcchValueBuf);

@DllImport("msi.dll")
uint MsiGetPropertyW(uint hInstall, const(wchar)* szName, const(wchar)* szValueBuf, uint* pcchValueBuf);

@DllImport("msi.dll")
ushort MsiGetLanguage(uint hInstall);

@DllImport("msi.dll")
BOOL MsiGetMode(uint hInstall, MSIRUNMODE eRunMode);

@DllImport("msi.dll")
uint MsiSetMode(uint hInstall, MSIRUNMODE eRunMode, BOOL fState);

@DllImport("msi.dll")
uint MsiFormatRecordA(uint hInstall, uint hRecord, const(char)* szResultBuf, uint* pcchResultBuf);

@DllImport("msi.dll")
uint MsiFormatRecordW(uint hInstall, uint hRecord, const(wchar)* szResultBuf, uint* pcchResultBuf);

@DllImport("msi.dll")
uint MsiDoActionA(uint hInstall, const(char)* szAction);

@DllImport("msi.dll")
uint MsiDoActionW(uint hInstall, const(wchar)* szAction);

@DllImport("msi.dll")
uint MsiSequenceA(uint hInstall, const(char)* szTable, int iSequenceMode);

@DllImport("msi.dll")
uint MsiSequenceW(uint hInstall, const(wchar)* szTable, int iSequenceMode);

@DllImport("msi.dll")
int MsiProcessMessage(uint hInstall, INSTALLMESSAGE eMessageType, uint hRecord);

@DllImport("msi.dll")
MSICONDITION MsiEvaluateConditionA(uint hInstall, const(char)* szCondition);

@DllImport("msi.dll")
MSICONDITION MsiEvaluateConditionW(uint hInstall, const(wchar)* szCondition);

@DllImport("msi.dll")
uint MsiGetFeatureStateA(uint hInstall, const(char)* szFeature, INSTALLSTATE* piInstalled, INSTALLSTATE* piAction);

@DllImport("msi.dll")
uint MsiGetFeatureStateW(uint hInstall, const(wchar)* szFeature, INSTALLSTATE* piInstalled, INSTALLSTATE* piAction);

@DllImport("msi.dll")
uint MsiSetFeatureStateA(uint hInstall, const(char)* szFeature, INSTALLSTATE iState);

@DllImport("msi.dll")
uint MsiSetFeatureStateW(uint hInstall, const(wchar)* szFeature, INSTALLSTATE iState);

@DllImport("msi.dll")
uint MsiSetFeatureAttributesA(uint hInstall, const(char)* szFeature, uint dwAttributes);

@DllImport("msi.dll")
uint MsiSetFeatureAttributesW(uint hInstall, const(wchar)* szFeature, uint dwAttributes);

@DllImport("msi.dll")
uint MsiGetComponentStateA(uint hInstall, const(char)* szComponent, INSTALLSTATE* piInstalled, INSTALLSTATE* piAction);

@DllImport("msi.dll")
uint MsiGetComponentStateW(uint hInstall, const(wchar)* szComponent, INSTALLSTATE* piInstalled, INSTALLSTATE* piAction);

@DllImport("msi.dll")
uint MsiSetComponentStateA(uint hInstall, const(char)* szComponent, INSTALLSTATE iState);

@DllImport("msi.dll")
uint MsiSetComponentStateW(uint hInstall, const(wchar)* szComponent, INSTALLSTATE iState);

@DllImport("msi.dll")
uint MsiGetFeatureCostA(uint hInstall, const(char)* szFeature, MSICOSTTREE iCostTree, INSTALLSTATE iState, int* piCost);

@DllImport("msi.dll")
uint MsiGetFeatureCostW(uint hInstall, const(wchar)* szFeature, MSICOSTTREE iCostTree, INSTALLSTATE iState, int* piCost);

@DllImport("msi.dll")
uint MsiEnumComponentCostsA(uint hInstall, const(char)* szComponent, uint dwIndex, INSTALLSTATE iState, const(char)* szDriveBuf, uint* pcchDriveBuf, int* piCost, int* piTempCost);

@DllImport("msi.dll")
uint MsiEnumComponentCostsW(uint hInstall, const(wchar)* szComponent, uint dwIndex, INSTALLSTATE iState, const(wchar)* szDriveBuf, uint* pcchDriveBuf, int* piCost, int* piTempCost);

@DllImport("msi.dll")
uint MsiSetInstallLevel(uint hInstall, int iInstallLevel);

@DllImport("msi.dll")
uint MsiGetFeatureValidStatesA(uint hInstall, const(char)* szFeature, uint* lpInstallStates);

@DllImport("msi.dll")
uint MsiGetFeatureValidStatesW(uint hInstall, const(wchar)* szFeature, uint* lpInstallStates);

@DllImport("msi.dll")
uint MsiGetSourcePathA(uint hInstall, const(char)* szFolder, const(char)* szPathBuf, uint* pcchPathBuf);

@DllImport("msi.dll")
uint MsiGetSourcePathW(uint hInstall, const(wchar)* szFolder, const(wchar)* szPathBuf, uint* pcchPathBuf);

@DllImport("msi.dll")
uint MsiGetTargetPathA(uint hInstall, const(char)* szFolder, const(char)* szPathBuf, uint* pcchPathBuf);

@DllImport("msi.dll")
uint MsiGetTargetPathW(uint hInstall, const(wchar)* szFolder, const(wchar)* szPathBuf, uint* pcchPathBuf);

@DllImport("msi.dll")
uint MsiSetTargetPathA(uint hInstall, const(char)* szFolder, const(char)* szFolderPath);

@DllImport("msi.dll")
uint MsiSetTargetPathW(uint hInstall, const(wchar)* szFolder, const(wchar)* szFolderPath);

@DllImport("msi.dll")
uint MsiVerifyDiskSpace(uint hInstall);

@DllImport("msi.dll")
uint MsiEnableUIPreview(uint hDatabase, uint* phPreview);

@DllImport("msi.dll")
uint MsiPreviewDialogA(uint hPreview, const(char)* szDialogName);

@DllImport("msi.dll")
uint MsiPreviewDialogW(uint hPreview, const(wchar)* szDialogName);

@DllImport("msi.dll")
uint MsiPreviewBillboardA(uint hPreview, const(char)* szControlName, const(char)* szBillboard);

@DllImport("msi.dll")
uint MsiPreviewBillboardW(uint hPreview, const(wchar)* szControlName, const(wchar)* szBillboard);

@DllImport("msi.dll")
uint MsiGetLastErrorRecord();

@DllImport("sfc.dll")
BOOL SfcGetNextProtectedFile(HANDLE RpcHandle, PROTECTED_FILE_DATA* ProtFileData);

@DllImport("sfc.dll")
BOOL SfcIsFileProtected(HANDLE RpcHandle, const(wchar)* ProtFileName);

@DllImport("sfc.dll")
BOOL SfcIsKeyProtected(HKEY KeyHandle, const(wchar)* SubKeyName, uint KeySam);

@DllImport("sfc.dll")
BOOL SfpVerifyFile(const(char)* pszFileName, const(char)* pszError, uint dwErrSize);

@DllImport("KERNEL32.dll")
HANDLE CreateActCtxA(ACTCTXA* pActCtx);

@DllImport("KERNEL32.dll")
HANDLE CreateActCtxW(ACTCTXW* pActCtx);

@DllImport("KERNEL32.dll")
void AddRefActCtx(HANDLE hActCtx);

@DllImport("KERNEL32.dll")
void ReleaseActCtx(HANDLE hActCtx);

@DllImport("KERNEL32.dll")
BOOL ZombifyActCtx(HANDLE hActCtx);

@DllImport("KERNEL32.dll")
BOOL ActivateActCtx(HANDLE hActCtx, uint* lpCookie);

@DllImport("KERNEL32.dll")
BOOL DeactivateActCtx(uint dwFlags, uint ulCookie);

@DllImport("KERNEL32.dll")
BOOL GetCurrentActCtx(HANDLE* lphActCtx);

@DllImport("KERNEL32.dll")
BOOL FindActCtxSectionStringA(uint dwFlags, const(Guid)* lpExtensionGuid, uint ulSectionId, const(char)* lpStringToFind, ACTCTX_SECTION_KEYED_DATA* ReturnedData);

@DllImport("KERNEL32.dll")
BOOL FindActCtxSectionStringW(uint dwFlags, const(Guid)* lpExtensionGuid, uint ulSectionId, const(wchar)* lpStringToFind, ACTCTX_SECTION_KEYED_DATA* ReturnedData);

@DllImport("KERNEL32.dll")
BOOL FindActCtxSectionGuid(uint dwFlags, const(Guid)* lpExtensionGuid, uint ulSectionId, const(Guid)* lpGuidToFind, ACTCTX_SECTION_KEYED_DATA* ReturnedData);

@DllImport("KERNEL32.dll")
BOOL QueryActCtxW(uint dwFlags, HANDLE hActCtx, void* pvSubInstance, uint ulInfoClass, char* pvBuffer, uint cbBuffer, uint* pcbWrittenOrRequired);

@DllImport("KERNEL32.dll")
BOOL QueryActCtxSettingsW(uint dwFlags, HANDLE hActCtx, const(wchar)* settingsNameSpace, const(wchar)* settingName, const(wchar)* pvBuffer, uint dwBuffer, uint* pdwWrittenOrRequired);

@DllImport("SETUPAPI.dll")
BOOL SetupGetInfInformationA(void* InfSpec, uint SearchControl, char* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupGetInfInformationW(void* InfSpec, uint SearchControl, char* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupQueryInfFileInformationA(SP_INF_INFORMATION* InfInformation, uint InfIndex, const(char)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupQueryInfFileInformationW(SP_INF_INFORMATION* InfInformation, uint InfIndex, const(wchar)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupQueryInfOriginalFileInformationA(SP_INF_INFORMATION* InfInformation, uint InfIndex, SP_ALTPLATFORM_INFO_V2* AlternatePlatformInfo, SP_ORIGINAL_FILE_INFO_A* OriginalFileInfo);

@DllImport("SETUPAPI.dll")
BOOL SetupQueryInfOriginalFileInformationW(SP_INF_INFORMATION* InfInformation, uint InfIndex, SP_ALTPLATFORM_INFO_V2* AlternatePlatformInfo, SP_ORIGINAL_FILE_INFO_W* OriginalFileInfo);

@DllImport("SETUPAPI.dll")
BOOL SetupQueryInfVersionInformationA(SP_INF_INFORMATION* InfInformation, uint InfIndex, const(char)* Key, const(char)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupQueryInfVersionInformationW(SP_INF_INFORMATION* InfInformation, uint InfIndex, const(wchar)* Key, const(wchar)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupGetInfFileListA(const(char)* DirectoryPath, uint InfStyle, const(char)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupGetInfFileListW(const(wchar)* DirectoryPath, uint InfStyle, const(wchar)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
void* SetupOpenInfFileW(const(wchar)* FileName, const(wchar)* InfClass, uint InfStyle, uint* ErrorLine);

@DllImport("SETUPAPI.dll")
void* SetupOpenInfFileA(const(char)* FileName, const(char)* InfClass, uint InfStyle, uint* ErrorLine);

@DllImport("SETUPAPI.dll")
void* SetupOpenMasterInf();

@DllImport("SETUPAPI.dll")
BOOL SetupOpenAppendInfFileW(const(wchar)* FileName, void* InfHandle, uint* ErrorLine);

@DllImport("SETUPAPI.dll")
BOOL SetupOpenAppendInfFileA(const(char)* FileName, void* InfHandle, uint* ErrorLine);

@DllImport("SETUPAPI.dll")
void SetupCloseInfFile(void* InfHandle);

@DllImport("SETUPAPI.dll")
BOOL SetupFindFirstLineA(void* InfHandle, const(char)* Section, const(char)* Key, INFCONTEXT* Context);

@DllImport("SETUPAPI.dll")
BOOL SetupFindFirstLineW(void* InfHandle, const(wchar)* Section, const(wchar)* Key, INFCONTEXT* Context);

@DllImport("SETUPAPI.dll")
BOOL SetupFindNextLine(INFCONTEXT* ContextIn, INFCONTEXT* ContextOut);

@DllImport("SETUPAPI.dll")
BOOL SetupFindNextMatchLineA(INFCONTEXT* ContextIn, const(char)* Key, INFCONTEXT* ContextOut);

@DllImport("SETUPAPI.dll")
BOOL SetupFindNextMatchLineW(INFCONTEXT* ContextIn, const(wchar)* Key, INFCONTEXT* ContextOut);

@DllImport("SETUPAPI.dll")
BOOL SetupGetLineByIndexA(void* InfHandle, const(char)* Section, uint Index, INFCONTEXT* Context);

@DllImport("SETUPAPI.dll")
BOOL SetupGetLineByIndexW(void* InfHandle, const(wchar)* Section, uint Index, INFCONTEXT* Context);

@DllImport("SETUPAPI.dll")
int SetupGetLineCountA(void* InfHandle, const(char)* Section);

@DllImport("SETUPAPI.dll")
int SetupGetLineCountW(void* InfHandle, const(wchar)* Section);

@DllImport("SETUPAPI.dll")
BOOL SetupGetLineTextA(INFCONTEXT* Context, void* InfHandle, const(char)* Section, const(char)* Key, const(char)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupGetLineTextW(INFCONTEXT* Context, void* InfHandle, const(wchar)* Section, const(wchar)* Key, const(wchar)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
uint SetupGetFieldCount(INFCONTEXT* Context);

@DllImport("SETUPAPI.dll")
BOOL SetupGetStringFieldA(INFCONTEXT* Context, uint FieldIndex, const(char)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupGetStringFieldW(INFCONTEXT* Context, uint FieldIndex, const(wchar)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupGetIntField(INFCONTEXT* Context, uint FieldIndex, int* IntegerValue);

@DllImport("SETUPAPI.dll")
BOOL SetupGetMultiSzFieldA(INFCONTEXT* Context, uint FieldIndex, const(char)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupGetMultiSzFieldW(INFCONTEXT* Context, uint FieldIndex, const(wchar)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupGetBinaryField(INFCONTEXT* Context, uint FieldIndex, char* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
uint SetupGetFileCompressionInfoA(const(char)* SourceFileName, byte** ActualSourceFileName, uint* SourceFileSize, uint* TargetFileSize, uint* CompressionType);

@DllImport("SETUPAPI.dll")
uint SetupGetFileCompressionInfoW(const(wchar)* SourceFileName, ushort** ActualSourceFileName, uint* SourceFileSize, uint* TargetFileSize, uint* CompressionType);

@DllImport("SETUPAPI.dll")
BOOL SetupGetFileCompressionInfoExA(const(char)* SourceFileName, const(char)* ActualSourceFileNameBuffer, uint ActualSourceFileNameBufferLen, uint* RequiredBufferLen, uint* SourceFileSize, uint* TargetFileSize, uint* CompressionType);

@DllImport("SETUPAPI.dll")
BOOL SetupGetFileCompressionInfoExW(const(wchar)* SourceFileName, const(wchar)* ActualSourceFileNameBuffer, uint ActualSourceFileNameBufferLen, uint* RequiredBufferLen, uint* SourceFileSize, uint* TargetFileSize, uint* CompressionType);

@DllImport("SETUPAPI.dll")
uint SetupDecompressOrCopyFileA(const(char)* SourceFileName, const(char)* TargetFileName, uint* CompressionType);

@DllImport("SETUPAPI.dll")
uint SetupDecompressOrCopyFileW(const(wchar)* SourceFileName, const(wchar)* TargetFileName, uint* CompressionType);

@DllImport("SETUPAPI.dll")
BOOL SetupGetSourceFileLocationA(void* InfHandle, INFCONTEXT* InfContext, const(char)* FileName, uint* SourceId, const(char)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupGetSourceFileLocationW(void* InfHandle, INFCONTEXT* InfContext, const(wchar)* FileName, uint* SourceId, const(wchar)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupGetSourceFileSizeA(void* InfHandle, INFCONTEXT* InfContext, const(char)* FileName, const(char)* Section, uint* FileSize, uint RoundingFactor);

@DllImport("SETUPAPI.dll")
BOOL SetupGetSourceFileSizeW(void* InfHandle, INFCONTEXT* InfContext, const(wchar)* FileName, const(wchar)* Section, uint* FileSize, uint RoundingFactor);

@DllImport("SETUPAPI.dll")
BOOL SetupGetTargetPathA(void* InfHandle, INFCONTEXT* InfContext, const(char)* Section, const(char)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupGetTargetPathW(void* InfHandle, INFCONTEXT* InfContext, const(wchar)* Section, const(wchar)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupSetSourceListA(uint Flags, char* SourceList, uint SourceCount);

@DllImport("SETUPAPI.dll")
BOOL SetupSetSourceListW(uint Flags, char* SourceList, uint SourceCount);

@DllImport("SETUPAPI.dll")
BOOL SetupCancelTemporarySourceList();

@DllImport("SETUPAPI.dll")
BOOL SetupAddToSourceListA(uint Flags, const(char)* Source);

@DllImport("SETUPAPI.dll")
BOOL SetupAddToSourceListW(uint Flags, const(wchar)* Source);

@DllImport("SETUPAPI.dll")
BOOL SetupRemoveFromSourceListA(uint Flags, const(char)* Source);

@DllImport("SETUPAPI.dll")
BOOL SetupRemoveFromSourceListW(uint Flags, const(wchar)* Source);

@DllImport("SETUPAPI.dll")
BOOL SetupQuerySourceListA(uint Flags, byte*** List, uint* Count);

@DllImport("SETUPAPI.dll")
BOOL SetupQuerySourceListW(uint Flags, ushort*** List, uint* Count);

@DllImport("SETUPAPI.dll")
BOOL SetupFreeSourceListA(char* List, uint Count);

@DllImport("SETUPAPI.dll")
BOOL SetupFreeSourceListW(char* List, uint Count);

@DllImport("SETUPAPI.dll")
uint SetupPromptForDiskA(HWND hwndParent, const(char)* DialogTitle, const(char)* DiskName, const(char)* PathToSource, const(char)* FileSought, const(char)* TagFile, uint DiskPromptStyle, const(char)* PathBuffer, uint PathBufferSize, uint* PathRequiredSize);

@DllImport("SETUPAPI.dll")
uint SetupPromptForDiskW(HWND hwndParent, const(wchar)* DialogTitle, const(wchar)* DiskName, const(wchar)* PathToSource, const(wchar)* FileSought, const(wchar)* TagFile, uint DiskPromptStyle, const(wchar)* PathBuffer, uint PathBufferSize, uint* PathRequiredSize);

@DllImport("SETUPAPI.dll")
uint SetupCopyErrorA(HWND hwndParent, const(char)* DialogTitle, const(char)* DiskName, const(char)* PathToSource, const(char)* SourceFile, const(char)* TargetPathFile, uint Win32ErrorCode, uint Style, const(char)* PathBuffer, uint PathBufferSize, uint* PathRequiredSize);

@DllImport("SETUPAPI.dll")
uint SetupCopyErrorW(HWND hwndParent, const(wchar)* DialogTitle, const(wchar)* DiskName, const(wchar)* PathToSource, const(wchar)* SourceFile, const(wchar)* TargetPathFile, uint Win32ErrorCode, uint Style, const(wchar)* PathBuffer, uint PathBufferSize, uint* PathRequiredSize);

@DllImport("SETUPAPI.dll")
uint SetupRenameErrorA(HWND hwndParent, const(char)* DialogTitle, const(char)* SourceFile, const(char)* TargetFile, uint Win32ErrorCode, uint Style);

@DllImport("SETUPAPI.dll")
uint SetupRenameErrorW(HWND hwndParent, const(wchar)* DialogTitle, const(wchar)* SourceFile, const(wchar)* TargetFile, uint Win32ErrorCode, uint Style);

@DllImport("SETUPAPI.dll")
uint SetupDeleteErrorA(HWND hwndParent, const(char)* DialogTitle, const(char)* File, uint Win32ErrorCode, uint Style);

@DllImport("SETUPAPI.dll")
uint SetupDeleteErrorW(HWND hwndParent, const(wchar)* DialogTitle, const(wchar)* File, uint Win32ErrorCode, uint Style);

@DllImport("SETUPAPI.dll")
uint SetupBackupErrorA(HWND hwndParent, const(char)* DialogTitle, const(char)* SourceFile, const(char)* TargetFile, uint Win32ErrorCode, uint Style);

@DllImport("SETUPAPI.dll")
uint SetupBackupErrorW(HWND hwndParent, const(wchar)* DialogTitle, const(wchar)* SourceFile, const(wchar)* TargetFile, uint Win32ErrorCode, uint Style);

@DllImport("SETUPAPI.dll")
BOOL SetupSetDirectoryIdA(void* InfHandle, uint Id, const(char)* Directory);

@DllImport("SETUPAPI.dll")
BOOL SetupSetDirectoryIdW(void* InfHandle, uint Id, const(wchar)* Directory);

@DllImport("SETUPAPI.dll")
BOOL SetupSetDirectoryIdExA(void* InfHandle, uint Id, const(char)* Directory, uint Flags, uint Reserved1, void* Reserved2);

@DllImport("SETUPAPI.dll")
BOOL SetupSetDirectoryIdExW(void* InfHandle, uint Id, const(wchar)* Directory, uint Flags, uint Reserved1, void* Reserved2);

@DllImport("SETUPAPI.dll")
BOOL SetupGetSourceInfoA(void* InfHandle, uint SourceId, uint InfoDesired, const(char)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupGetSourceInfoW(void* InfHandle, uint SourceId, uint InfoDesired, const(wchar)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupInstallFileA(void* InfHandle, INFCONTEXT* InfContext, const(char)* SourceFile, const(char)* SourcePathRoot, const(char)* DestinationName, uint CopyStyle, PSP_FILE_CALLBACK_A CopyMsgHandler, void* Context);

@DllImport("SETUPAPI.dll")
BOOL SetupInstallFileW(void* InfHandle, INFCONTEXT* InfContext, const(wchar)* SourceFile, const(wchar)* SourcePathRoot, const(wchar)* DestinationName, uint CopyStyle, PSP_FILE_CALLBACK_W CopyMsgHandler, void* Context);

@DllImport("SETUPAPI.dll")
BOOL SetupInstallFileExA(void* InfHandle, INFCONTEXT* InfContext, const(char)* SourceFile, const(char)* SourcePathRoot, const(char)* DestinationName, uint CopyStyle, PSP_FILE_CALLBACK_A CopyMsgHandler, void* Context, int* FileWasInUse);

@DllImport("SETUPAPI.dll")
BOOL SetupInstallFileExW(void* InfHandle, INFCONTEXT* InfContext, const(wchar)* SourceFile, const(wchar)* SourcePathRoot, const(wchar)* DestinationName, uint CopyStyle, PSP_FILE_CALLBACK_W CopyMsgHandler, void* Context, int* FileWasInUse);

@DllImport("SETUPAPI.dll")
void* SetupOpenFileQueue();

@DllImport("SETUPAPI.dll")
BOOL SetupCloseFileQueue(void* QueueHandle);

@DllImport("SETUPAPI.dll")
BOOL SetupSetFileQueueAlternatePlatformA(void* QueueHandle, SP_ALTPLATFORM_INFO_V2* AlternatePlatformInfo, const(char)* AlternateDefaultCatalogFile);

@DllImport("SETUPAPI.dll")
BOOL SetupSetFileQueueAlternatePlatformW(void* QueueHandle, SP_ALTPLATFORM_INFO_V2* AlternatePlatformInfo, const(wchar)* AlternateDefaultCatalogFile);

@DllImport("SETUPAPI.dll")
BOOL SetupSetPlatformPathOverrideA(const(char)* Override);

@DllImport("SETUPAPI.dll")
BOOL SetupSetPlatformPathOverrideW(const(wchar)* Override);

@DllImport("SETUPAPI.dll")
BOOL SetupQueueCopyA(void* QueueHandle, const(char)* SourceRootPath, const(char)* SourcePath, const(char)* SourceFilename, const(char)* SourceDescription, const(char)* SourceTagfile, const(char)* TargetDirectory, const(char)* TargetFilename, uint CopyStyle);

@DllImport("SETUPAPI.dll")
BOOL SetupQueueCopyW(void* QueueHandle, const(wchar)* SourceRootPath, const(wchar)* SourcePath, const(wchar)* SourceFilename, const(wchar)* SourceDescription, const(wchar)* SourceTagfile, const(wchar)* TargetDirectory, const(wchar)* TargetFilename, uint CopyStyle);

@DllImport("SETUPAPI.dll")
BOOL SetupQueueCopyIndirectA(SP_FILE_COPY_PARAMS_A* CopyParams);

@DllImport("SETUPAPI.dll")
BOOL SetupQueueCopyIndirectW(SP_FILE_COPY_PARAMS_W* CopyParams);

@DllImport("SETUPAPI.dll")
BOOL SetupQueueDefaultCopyA(void* QueueHandle, void* InfHandle, const(char)* SourceRootPath, const(char)* SourceFilename, const(char)* TargetFilename, uint CopyStyle);

@DllImport("SETUPAPI.dll")
BOOL SetupQueueDefaultCopyW(void* QueueHandle, void* InfHandle, const(wchar)* SourceRootPath, const(wchar)* SourceFilename, const(wchar)* TargetFilename, uint CopyStyle);

@DllImport("SETUPAPI.dll")
BOOL SetupQueueCopySectionA(void* QueueHandle, const(char)* SourceRootPath, void* InfHandle, void* ListInfHandle, const(char)* Section, uint CopyStyle);

@DllImport("SETUPAPI.dll")
BOOL SetupQueueCopySectionW(void* QueueHandle, const(wchar)* SourceRootPath, void* InfHandle, void* ListInfHandle, const(wchar)* Section, uint CopyStyle);

@DllImport("SETUPAPI.dll")
BOOL SetupQueueDeleteA(void* QueueHandle, const(char)* PathPart1, const(char)* PathPart2);

@DllImport("SETUPAPI.dll")
BOOL SetupQueueDeleteW(void* QueueHandle, const(wchar)* PathPart1, const(wchar)* PathPart2);

@DllImport("SETUPAPI.dll")
BOOL SetupQueueDeleteSectionA(void* QueueHandle, void* InfHandle, void* ListInfHandle, const(char)* Section);

@DllImport("SETUPAPI.dll")
BOOL SetupQueueDeleteSectionW(void* QueueHandle, void* InfHandle, void* ListInfHandle, const(wchar)* Section);

@DllImport("SETUPAPI.dll")
BOOL SetupQueueRenameA(void* QueueHandle, const(char)* SourcePath, const(char)* SourceFilename, const(char)* TargetPath, const(char)* TargetFilename);

@DllImport("SETUPAPI.dll")
BOOL SetupQueueRenameW(void* QueueHandle, const(wchar)* SourcePath, const(wchar)* SourceFilename, const(wchar)* TargetPath, const(wchar)* TargetFilename);

@DllImport("SETUPAPI.dll")
BOOL SetupQueueRenameSectionA(void* QueueHandle, void* InfHandle, void* ListInfHandle, const(char)* Section);

@DllImport("SETUPAPI.dll")
BOOL SetupQueueRenameSectionW(void* QueueHandle, void* InfHandle, void* ListInfHandle, const(wchar)* Section);

@DllImport("SETUPAPI.dll")
BOOL SetupCommitFileQueueA(HWND Owner, void* QueueHandle, PSP_FILE_CALLBACK_A MsgHandler, void* Context);

@DllImport("SETUPAPI.dll")
BOOL SetupCommitFileQueueW(HWND Owner, void* QueueHandle, PSP_FILE_CALLBACK_W MsgHandler, void* Context);

@DllImport("SETUPAPI.dll")
BOOL SetupScanFileQueueA(void* FileQueue, uint Flags, HWND Window, PSP_FILE_CALLBACK_A CallbackRoutine, void* CallbackContext, uint* Result);

@DllImport("SETUPAPI.dll")
BOOL SetupScanFileQueueW(void* FileQueue, uint Flags, HWND Window, PSP_FILE_CALLBACK_W CallbackRoutine, void* CallbackContext, uint* Result);

@DllImport("SETUPAPI.dll")
BOOL SetupGetFileQueueCount(void* FileQueue, uint SubQueueFileOp, uint* NumOperations);

@DllImport("SETUPAPI.dll")
BOOL SetupGetFileQueueFlags(void* FileQueue, uint* Flags);

@DllImport("SETUPAPI.dll")
BOOL SetupSetFileQueueFlags(void* FileQueue, uint FlagMask, uint Flags);

@DllImport("SETUPAPI.dll")
BOOL SetupCopyOEMInfA(const(char)* SourceInfFileName, const(char)* OEMSourceMediaLocation, uint OEMSourceMediaType, uint CopyStyle, const(char)* DestinationInfFileName, uint DestinationInfFileNameSize, uint* RequiredSize, byte** DestinationInfFileNameComponent);

@DllImport("SETUPAPI.dll")
BOOL SetupCopyOEMInfW(const(wchar)* SourceInfFileName, const(wchar)* OEMSourceMediaLocation, uint OEMSourceMediaType, uint CopyStyle, const(wchar)* DestinationInfFileName, uint DestinationInfFileNameSize, uint* RequiredSize, ushort** DestinationInfFileNameComponent);

@DllImport("SETUPAPI.dll")
BOOL SetupUninstallOEMInfA(const(char)* InfFileName, uint Flags, void* Reserved);

@DllImport("SETUPAPI.dll")
BOOL SetupUninstallOEMInfW(const(wchar)* InfFileName, uint Flags, void* Reserved);

@DllImport("SETUPAPI.dll")
BOOL SetupUninstallNewlyCopiedInfs(void* FileQueue, uint Flags, void* Reserved);

@DllImport("SETUPAPI.dll")
void* SetupCreateDiskSpaceListA(void* Reserved1, uint Reserved2, uint Flags);

@DllImport("SETUPAPI.dll")
void* SetupCreateDiskSpaceListW(void* Reserved1, uint Reserved2, uint Flags);

@DllImport("SETUPAPI.dll")
void* SetupDuplicateDiskSpaceListA(void* DiskSpace, void* Reserved1, uint Reserved2, uint Flags);

@DllImport("SETUPAPI.dll")
void* SetupDuplicateDiskSpaceListW(void* DiskSpace, void* Reserved1, uint Reserved2, uint Flags);

@DllImport("SETUPAPI.dll")
BOOL SetupDestroyDiskSpaceList(void* DiskSpace);

@DllImport("SETUPAPI.dll")
BOOL SetupQueryDrivesInDiskSpaceListA(void* DiskSpace, const(char)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupQueryDrivesInDiskSpaceListW(void* DiskSpace, const(wchar)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupQuerySpaceRequiredOnDriveA(void* DiskSpace, const(char)* DriveSpec, long* SpaceRequired, void* Reserved1, uint Reserved2);

@DllImport("SETUPAPI.dll")
BOOL SetupQuerySpaceRequiredOnDriveW(void* DiskSpace, const(wchar)* DriveSpec, long* SpaceRequired, void* Reserved1, uint Reserved2);

@DllImport("SETUPAPI.dll")
BOOL SetupAdjustDiskSpaceListA(void* DiskSpace, const(char)* DriveRoot, long Amount, void* Reserved1, uint Reserved2);

@DllImport("SETUPAPI.dll")
BOOL SetupAdjustDiskSpaceListW(void* DiskSpace, const(wchar)* DriveRoot, long Amount, void* Reserved1, uint Reserved2);

@DllImport("SETUPAPI.dll")
BOOL SetupAddToDiskSpaceListA(void* DiskSpace, const(char)* TargetFilespec, long FileSize, uint Operation, void* Reserved1, uint Reserved2);

@DllImport("SETUPAPI.dll")
BOOL SetupAddToDiskSpaceListW(void* DiskSpace, const(wchar)* TargetFilespec, long FileSize, uint Operation, void* Reserved1, uint Reserved2);

@DllImport("SETUPAPI.dll")
BOOL SetupAddSectionToDiskSpaceListA(void* DiskSpace, void* InfHandle, void* ListInfHandle, const(char)* SectionName, uint Operation, void* Reserved1, uint Reserved2);

@DllImport("SETUPAPI.dll")
BOOL SetupAddSectionToDiskSpaceListW(void* DiskSpace, void* InfHandle, void* ListInfHandle, const(wchar)* SectionName, uint Operation, void* Reserved1, uint Reserved2);

@DllImport("SETUPAPI.dll")
BOOL SetupAddInstallSectionToDiskSpaceListA(void* DiskSpace, void* InfHandle, void* LayoutInfHandle, const(char)* SectionName, void* Reserved1, uint Reserved2);

@DllImport("SETUPAPI.dll")
BOOL SetupAddInstallSectionToDiskSpaceListW(void* DiskSpace, void* InfHandle, void* LayoutInfHandle, const(wchar)* SectionName, void* Reserved1, uint Reserved2);

@DllImport("SETUPAPI.dll")
BOOL SetupRemoveFromDiskSpaceListA(void* DiskSpace, const(char)* TargetFilespec, uint Operation, void* Reserved1, uint Reserved2);

@DllImport("SETUPAPI.dll")
BOOL SetupRemoveFromDiskSpaceListW(void* DiskSpace, const(wchar)* TargetFilespec, uint Operation, void* Reserved1, uint Reserved2);

@DllImport("SETUPAPI.dll")
BOOL SetupRemoveSectionFromDiskSpaceListA(void* DiskSpace, void* InfHandle, void* ListInfHandle, const(char)* SectionName, uint Operation, void* Reserved1, uint Reserved2);

@DllImport("SETUPAPI.dll")
BOOL SetupRemoveSectionFromDiskSpaceListW(void* DiskSpace, void* InfHandle, void* ListInfHandle, const(wchar)* SectionName, uint Operation, void* Reserved1, uint Reserved2);

@DllImport("SETUPAPI.dll")
BOOL SetupRemoveInstallSectionFromDiskSpaceListA(void* DiskSpace, void* InfHandle, void* LayoutInfHandle, const(char)* SectionName, void* Reserved1, uint Reserved2);

@DllImport("SETUPAPI.dll")
BOOL SetupRemoveInstallSectionFromDiskSpaceListW(void* DiskSpace, void* InfHandle, void* LayoutInfHandle, const(wchar)* SectionName, void* Reserved1, uint Reserved2);

@DllImport("SETUPAPI.dll")
BOOL SetupIterateCabinetA(const(char)* CabinetFile, uint Reserved, PSP_FILE_CALLBACK_A MsgHandler, void* Context);

@DllImport("SETUPAPI.dll")
BOOL SetupIterateCabinetW(const(wchar)* CabinetFile, uint Reserved, PSP_FILE_CALLBACK_W MsgHandler, void* Context);

@DllImport("SETUPAPI.dll")
int SetupPromptReboot(void* FileQueue, HWND Owner, BOOL ScanOnly);

@DllImport("SETUPAPI.dll")
void* SetupInitDefaultQueueCallback(HWND OwnerWindow);

@DllImport("SETUPAPI.dll")
void* SetupInitDefaultQueueCallbackEx(HWND OwnerWindow, HWND AlternateProgressWindow, uint ProgressMessage, uint Reserved1, void* Reserved2);

@DllImport("SETUPAPI.dll")
void SetupTermDefaultQueueCallback(void* Context);

@DllImport("SETUPAPI.dll")
uint SetupDefaultQueueCallbackA(void* Context, uint Notification, uint Param1, uint Param2);

@DllImport("SETUPAPI.dll")
uint SetupDefaultQueueCallbackW(void* Context, uint Notification, uint Param1, uint Param2);

@DllImport("SETUPAPI.dll")
BOOL SetupInstallFromInfSectionA(HWND Owner, void* InfHandle, const(char)* SectionName, uint Flags, HKEY RelativeKeyRoot, const(char)* SourceRootPath, uint CopyFlags, PSP_FILE_CALLBACK_A MsgHandler, void* Context, void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupInstallFromInfSectionW(HWND Owner, void* InfHandle, const(wchar)* SectionName, uint Flags, HKEY RelativeKeyRoot, const(wchar)* SourceRootPath, uint CopyFlags, PSP_FILE_CALLBACK_W MsgHandler, void* Context, void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupInstallFilesFromInfSectionA(void* InfHandle, void* LayoutInfHandle, void* FileQueue, const(char)* SectionName, const(char)* SourceRootPath, uint CopyFlags);

@DllImport("SETUPAPI.dll")
BOOL SetupInstallFilesFromInfSectionW(void* InfHandle, void* LayoutInfHandle, void* FileQueue, const(wchar)* SectionName, const(wchar)* SourceRootPath, uint CopyFlags);

@DllImport("SETUPAPI.dll")
BOOL SetupInstallServicesFromInfSectionA(void* InfHandle, const(char)* SectionName, uint Flags);

@DllImport("SETUPAPI.dll")
BOOL SetupInstallServicesFromInfSectionW(void* InfHandle, const(wchar)* SectionName, uint Flags);

@DllImport("SETUPAPI.dll")
BOOL SetupInstallServicesFromInfSectionExA(void* InfHandle, const(char)* SectionName, uint Flags, void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, void* Reserved1, void* Reserved2);

@DllImport("SETUPAPI.dll")
BOOL SetupInstallServicesFromInfSectionExW(void* InfHandle, const(wchar)* SectionName, uint Flags, void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, void* Reserved1, void* Reserved2);

@DllImport("SETUPAPI.dll")
void InstallHinfSectionA(HWND Window, HINSTANCE ModuleHandle, const(char)* CommandLine, int ShowCommand);

@DllImport("SETUPAPI.dll")
void InstallHinfSectionW(HWND Window, HINSTANCE ModuleHandle, const(wchar)* CommandLine, int ShowCommand);

@DllImport("SETUPAPI.dll")
void* SetupInitializeFileLogA(const(char)* LogFileName, uint Flags);

@DllImport("SETUPAPI.dll")
void* SetupInitializeFileLogW(const(wchar)* LogFileName, uint Flags);

@DllImport("SETUPAPI.dll")
BOOL SetupTerminateFileLog(void* FileLogHandle);

@DllImport("SETUPAPI.dll")
BOOL SetupLogFileA(void* FileLogHandle, const(char)* LogSectionName, const(char)* SourceFilename, const(char)* TargetFilename, uint Checksum, const(char)* DiskTagfile, const(char)* DiskDescription, const(char)* OtherInfo, uint Flags);

@DllImport("SETUPAPI.dll")
BOOL SetupLogFileW(void* FileLogHandle, const(wchar)* LogSectionName, const(wchar)* SourceFilename, const(wchar)* TargetFilename, uint Checksum, const(wchar)* DiskTagfile, const(wchar)* DiskDescription, const(wchar)* OtherInfo, uint Flags);

@DllImport("SETUPAPI.dll")
BOOL SetupRemoveFileLogEntryA(void* FileLogHandle, const(char)* LogSectionName, const(char)* TargetFilename);

@DllImport("SETUPAPI.dll")
BOOL SetupRemoveFileLogEntryW(void* FileLogHandle, const(wchar)* LogSectionName, const(wchar)* TargetFilename);

@DllImport("SETUPAPI.dll")
BOOL SetupQueryFileLogA(void* FileLogHandle, const(char)* LogSectionName, const(char)* TargetFilename, SetupFileLogInfo DesiredInfo, const(char)* DataOut, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupQueryFileLogW(void* FileLogHandle, const(wchar)* LogSectionName, const(wchar)* TargetFilename, SetupFileLogInfo DesiredInfo, const(wchar)* DataOut, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupOpenLog(BOOL Erase);

@DllImport("SETUPAPI.dll")
BOOL SetupLogErrorA(const(char)* MessageString, uint Severity);

@DllImport("SETUPAPI.dll")
BOOL SetupLogErrorW(const(wchar)* MessageString, uint Severity);

@DllImport("SETUPAPI.dll")
void SetupCloseLog();

@DllImport("SETUPAPI.dll")
void* SetupDiGetClassDevsA(const(Guid)* ClassGuid, const(char)* Enumerator, HWND hwndParent, uint Flags);

@DllImport("SETUPAPI.dll")
BOOL SetupEnumInfSectionsA(void* InfHandle, uint Index, const(char)* Buffer, uint Size, uint* SizeNeeded);

@DllImport("SETUPAPI.dll")
BOOL SetupEnumInfSectionsW(void* InfHandle, uint Index, const(wchar)* Buffer, uint Size, uint* SizeNeeded);

@DllImport("SETUPAPI.dll")
BOOL SetupVerifyInfFileA(const(char)* InfName, SP_ALTPLATFORM_INFO_V2* AltPlatformInfo, SP_INF_SIGNER_INFO_V2_A* InfSignerInfo);

@DllImport("SETUPAPI.dll")
BOOL SetupVerifyInfFileW(const(wchar)* InfName, SP_ALTPLATFORM_INFO_V2* AltPlatformInfo, SP_INF_SIGNER_INFO_V2_W* InfSignerInfo);

@DllImport("SETUPAPI.dll")
BOOL SetupConfigureWmiFromInfSectionA(void* InfHandle, const(char)* SectionName, uint Flags);

@DllImport("SETUPAPI.dll")
BOOL SetupConfigureWmiFromInfSectionW(void* InfHandle, const(wchar)* SectionName, uint Flags);

struct ACTCTXA
{
    uint cbSize;
    uint dwFlags;
    const(char)* lpSource;
    ushort wProcessorArchitecture;
    ushort wLangId;
    const(char)* lpAssemblyDirectory;
    const(char)* lpResourceName;
    const(char)* lpApplicationName;
    int hModule;
}

struct ACTCTXW
{
    uint cbSize;
    uint dwFlags;
    const(wchar)* lpSource;
    ushort wProcessorArchitecture;
    ushort wLangId;
    const(wchar)* lpAssemblyDirectory;
    const(wchar)* lpResourceName;
    const(wchar)* lpApplicationName;
    int hModule;
}

struct ACTCTX_SECTION_KEYED_DATA
{
    uint cbSize;
    uint ulDataFormatVersion;
    void* lpData;
    uint ulLength;
    void* lpSectionGlobalData;
    uint ulSectionGlobalDataLength;
    void* lpSectionBase;
    uint ulSectionTotalLength;
    HANDLE hActCtx;
    uint ulAssemblyRosterIndex;
    uint ulFlags;
    ACTCTX_SECTION_KEYED_DATA_ASSEMBLY_METADATA AssemblyMetadata;
}

struct INFCONTEXT
{
    void* Inf;
    void* CurrentInf;
    uint Section;
    uint Line;
}

struct SP_INF_INFORMATION
{
    uint InfStyle;
    uint InfCount;
    ubyte VersionData;
}

struct SP_ALTPLATFORM_INFO_V2
{
    uint cbSize;
    uint Platform;
    uint MajorVersion;
    uint MinorVersion;
    ushort ProcessorArchitecture;
    _Anonymous_e__Union Anonymous;
    uint FirstValidatedMajorVersion;
    uint FirstValidatedMinorVersion;
}

struct SP_ALTPLATFORM_INFO_V1
{
    uint cbSize;
    uint Platform;
    uint MajorVersion;
    uint MinorVersion;
    ushort ProcessorArchitecture;
    ushort Reserved;
}

struct SP_ORIGINAL_FILE_INFO_A
{
    uint cbSize;
    byte OriginalInfName;
    byte OriginalCatalogName;
}

struct SP_ORIGINAL_FILE_INFO_W
{
    uint cbSize;
    ushort OriginalInfName;
    ushort OriginalCatalogName;
}

alias PSP_FILE_CALLBACK_A = extern(Windows) uint function(void* Context, uint Notification, uint Param1, uint Param2);
alias PSP_FILE_CALLBACK_W = extern(Windows) uint function(void* Context, uint Notification, uint Param1, uint Param2);
struct FILEPATHS_A
{
    const(char)* Target;
    const(char)* Source;
    uint Win32Error;
    uint Flags;
}

struct FILEPATHS_W
{
    const(wchar)* Target;
    const(wchar)* Source;
    uint Win32Error;
    uint Flags;
}

struct FILEPATHS_SIGNERINFO_A
{
    const(char)* Target;
    const(char)* Source;
    uint Win32Error;
    uint Flags;
    const(char)* DigitalSigner;
    const(char)* Version;
    const(char)* CatalogFile;
}

struct FILEPATHS_SIGNERINFO_W
{
    const(wchar)* Target;
    const(wchar)* Source;
    uint Win32Error;
    uint Flags;
    const(wchar)* DigitalSigner;
    const(wchar)* Version;
    const(wchar)* CatalogFile;
}

struct SOURCE_MEDIA_A
{
    const(char)* Reserved;
    const(char)* Tagfile;
    const(char)* Description;
    const(char)* SourcePath;
    const(char)* SourceFile;
    uint Flags;
}

struct SOURCE_MEDIA_W
{
    const(wchar)* Reserved;
    const(wchar)* Tagfile;
    const(wchar)* Description;
    const(wchar)* SourcePath;
    const(wchar)* SourceFile;
    uint Flags;
}

struct CABINET_INFO_A
{
    const(char)* CabinetPath;
    const(char)* CabinetFile;
    const(char)* DiskName;
    ushort SetId;
    ushort CabinetNumber;
}

struct CABINET_INFO_W
{
    const(wchar)* CabinetPath;
    const(wchar)* CabinetFile;
    const(wchar)* DiskName;
    ushort SetId;
    ushort CabinetNumber;
}

struct FILE_IN_CABINET_INFO_A
{
    const(char)* NameInCabinet;
    uint FileSize;
    uint Win32Error;
    ushort DosDate;
    ushort DosTime;
    ushort DosAttribs;
    byte FullTargetName;
}

struct FILE_IN_CABINET_INFO_W
{
    const(wchar)* NameInCabinet;
    uint FileSize;
    uint Win32Error;
    ushort DosDate;
    ushort DosTime;
    ushort DosAttribs;
    ushort FullTargetName;
}

struct SP_REGISTER_CONTROL_STATUSA
{
    uint cbSize;
    const(char)* FileName;
    uint Win32Error;
    uint FailureCode;
}

struct SP_REGISTER_CONTROL_STATUSW
{
    uint cbSize;
    const(wchar)* FileName;
    uint Win32Error;
    uint FailureCode;
}

struct SP_FILE_COPY_PARAMS_A
{
    uint cbSize;
    void* QueueHandle;
    const(char)* SourceRootPath;
    const(char)* SourcePath;
    const(char)* SourceFilename;
    const(char)* SourceDescription;
    const(char)* SourceTagfile;
    const(char)* TargetDirectory;
    const(char)* TargetFilename;
    uint CopyStyle;
    void* LayoutInf;
    const(char)* SecurityDescriptor;
}

struct SP_FILE_COPY_PARAMS_W
{
    uint cbSize;
    void* QueueHandle;
    const(wchar)* SourceRootPath;
    const(wchar)* SourcePath;
    const(wchar)* SourceFilename;
    const(wchar)* SourceDescription;
    const(wchar)* SourceTagfile;
    const(wchar)* TargetDirectory;
    const(wchar)* TargetFilename;
    uint CopyStyle;
    void* LayoutInf;
    const(wchar)* SecurityDescriptor;
}

struct SP_INF_SIGNER_INFO_V1_A
{
    uint cbSize;
    byte CatalogFile;
    byte DigitalSigner;
    byte DigitalSignerVersion;
}

struct SP_INF_SIGNER_INFO_V1_W
{
    uint cbSize;
    ushort CatalogFile;
    ushort DigitalSigner;
    ushort DigitalSignerVersion;
}

struct SP_INF_SIGNER_INFO_V2_A
{
    uint cbSize;
    byte CatalogFile;
    byte DigitalSigner;
    byte DigitalSignerVersion;
    uint SignerScore;
}

struct SP_INF_SIGNER_INFO_V2_W
{
    uint cbSize;
    ushort CatalogFile;
    ushort DigitalSigner;
    ushort DigitalSignerVersion;
    uint SignerScore;
}

