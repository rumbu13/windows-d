module windows.applicationinstallationandservicing;

public import windows.core;
public import windows.automation : BSTR, IDispatch;
public import windows.com : HRESULT, IUnknown;
public import windows.deviceanddriverinstallation : SP_DEVINFO_DATA, SetupFileLogInfo;
public import windows.security : CERT_CONTEXT;
public import windows.structuredstorage : IStream;
public import windows.systemservices : BOOL, HANDLE, HINSTANCE, LARGE_INTEGER, ULARGE_INTEGER;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : ACTCTX_SECTION_KEYED_DATA_ASSEMBLY_METADATA, FILETIME, HKEY;

extern(Windows):


// Enums


enum : int
{
    ACTCTX_RUN_LEVEL_UNSPECIFIED       = 0x00000000,
    ACTCTX_RUN_LEVEL_AS_INVOKER        = 0x00000001,
    ACTCTX_RUN_LEVEL_HIGHEST_AVAILABLE = 0x00000002,
    ACTCTX_RUN_LEVEL_REQUIRE_ADMIN     = 0x00000003,
    ACTCTX_RUN_LEVEL_NUMBERS           = 0x00000004,
}
alias ACTCTX_REQUESTED_RUN_LEVEL = int;

enum : int
{
    ACTCTX_COMPATIBILITY_ELEMENT_TYPE_UNKNOWN          = 0x00000000,
    ACTCTX_COMPATIBILITY_ELEMENT_TYPE_OS               = 0x00000001,
    ACTCTX_COMPATIBILITY_ELEMENT_TYPE_MITIGATION       = 0x00000002,
    ACTCTX_COMPATIBILITY_ELEMENT_TYPE_MAXVERSIONTESTED = 0x00000003,
}
alias ACTCTX_COMPATIBILITY_ELEMENT_TYPE = int;

enum : int
{
    ieUnknown = 0x00000000,
    ieError   = 0x00000001,
    ieWarning = 0x00000002,
    ieInfo    = 0x00000003,
}
alias RESULTTYPES = int;

enum : int
{
    ieStatusGetCUB       = 0x00000000,
    ieStatusICECount     = 0x00000001,
    ieStatusMerge        = 0x00000002,
    ieStatusSummaryInfo  = 0x00000003,
    ieStatusCreateEngine = 0x00000004,
    ieStatusStarting     = 0x00000005,
    ieStatusRunICE       = 0x00000006,
    ieStatusShutdown     = 0x00000007,
    ieStatusSuccess      = 0x00000008,
    ieStatusFail         = 0x00000009,
    ieStatusCancel       = 0x0000000a,
}
alias STATUSTYPES = int;

enum : int
{
    msmErrorLanguageUnsupported = 0x00000001,
    msmErrorLanguageFailed      = 0x00000002,
    msmErrorExclusion           = 0x00000003,
    msmErrorTableMerge          = 0x00000004,
    msmErrorResequenceMerge     = 0x00000005,
    msmErrorFileCreate          = 0x00000006,
    msmErrorDirCreate           = 0x00000007,
    msmErrorFeatureRequired     = 0x00000008,
}
alias msmErrorType = int;

enum : int
{
    INSTALLMESSAGE_FATALEXIT      = 0x00000000,
    INSTALLMESSAGE_ERROR          = 0x01000000,
    INSTALLMESSAGE_WARNING        = 0x02000000,
    INSTALLMESSAGE_USER           = 0x03000000,
    INSTALLMESSAGE_INFO           = 0x04000000,
    INSTALLMESSAGE_FILESINUSE     = 0x05000000,
    INSTALLMESSAGE_RESOLVESOURCE  = 0x06000000,
    INSTALLMESSAGE_OUTOFDISKSPACE = 0x07000000,
    INSTALLMESSAGE_ACTIONSTART    = 0x08000000,
    INSTALLMESSAGE_ACTIONDATA     = 0x09000000,
    INSTALLMESSAGE_PROGRESS       = 0x0a000000,
    INSTALLMESSAGE_COMMONDATA     = 0x0b000000,
    INSTALLMESSAGE_INITIALIZE     = 0x0c000000,
    INSTALLMESSAGE_TERMINATE      = 0x0d000000,
    INSTALLMESSAGE_SHOWDIALOG     = 0x0e000000,
    INSTALLMESSAGE_PERFORMANCE    = 0x0f000000,
    INSTALLMESSAGE_RMFILESINUSE   = 0x19000000,
    INSTALLMESSAGE_INSTALLSTART   = 0x1a000000,
    INSTALLMESSAGE_INSTALLEND     = 0x1b000000,
}
alias INSTALLMESSAGE = int;

enum : int
{
    INSTALLUILEVEL_NOCHANGE      = 0x00000000,
    INSTALLUILEVEL_DEFAULT       = 0x00000001,
    INSTALLUILEVEL_NONE          = 0x00000002,
    INSTALLUILEVEL_BASIC         = 0x00000003,
    INSTALLUILEVEL_REDUCED       = 0x00000004,
    INSTALLUILEVEL_FULL          = 0x00000005,
    INSTALLUILEVEL_ENDDIALOG     = 0x00000080,
    INSTALLUILEVEL_PROGRESSONLY  = 0x00000040,
    INSTALLUILEVEL_HIDECANCEL    = 0x00000020,
    INSTALLUILEVEL_SOURCERESONLY = 0x00000100,
    INSTALLUILEVEL_UACONLY       = 0x00000200,
}
alias INSTALLUILEVEL = int;

enum : int
{
    INSTALLSTATE_NOTUSED      = 0xfffffff9,
    INSTALLSTATE_BADCONFIG    = 0xfffffffa,
    INSTALLSTATE_INCOMPLETE   = 0xfffffffb,
    INSTALLSTATE_SOURCEABSENT = 0xfffffffc,
    INSTALLSTATE_MOREDATA     = 0xfffffffd,
    INSTALLSTATE_INVALIDARG   = 0xfffffffe,
    INSTALLSTATE_UNKNOWN      = 0xffffffff,
    INSTALLSTATE_BROKEN       = 0x00000000,
    INSTALLSTATE_ADVERTISED   = 0x00000001,
    INSTALLSTATE_REMOVED      = 0x00000001,
    INSTALLSTATE_ABSENT       = 0x00000002,
    INSTALLSTATE_LOCAL        = 0x00000003,
    INSTALLSTATE_SOURCE       = 0x00000004,
    INSTALLSTATE_DEFAULT      = 0x00000005,
}
alias INSTALLSTATE = int;

enum : int
{
    USERINFOSTATE_MOREDATA   = 0xfffffffd,
    USERINFOSTATE_INVALIDARG = 0xfffffffe,
    USERINFOSTATE_UNKNOWN    = 0xffffffff,
    USERINFOSTATE_ABSENT     = 0x00000000,
    USERINFOSTATE_PRESENT    = 0x00000001,
}
alias USERINFOSTATE = int;

enum : int
{
    INSTALLLEVEL_DEFAULT = 0x00000000,
    INSTALLLEVEL_MINIMUM = 0x00000001,
    INSTALLLEVEL_MAXIMUM = 0x0000ffff,
}
alias INSTALLLEVEL = int;

enum : int
{
    REINSTALLMODE_REPAIR           = 0x00000001,
    REINSTALLMODE_FILEMISSING      = 0x00000002,
    REINSTALLMODE_FILEOLDERVERSION = 0x00000004,
    REINSTALLMODE_FILEEQUALVERSION = 0x00000008,
    REINSTALLMODE_FILEEXACT        = 0x00000010,
    REINSTALLMODE_FILEVERIFY       = 0x00000020,
    REINSTALLMODE_FILEREPLACE      = 0x00000040,
    REINSTALLMODE_MACHINEDATA      = 0x00000080,
    REINSTALLMODE_USERDATA         = 0x00000100,
    REINSTALLMODE_SHORTCUT         = 0x00000200,
    REINSTALLMODE_PACKAGE          = 0x00000400,
}
alias REINSTALLMODE = int;

enum : int
{
    INSTALLLOGMODE_FATALEXIT      = 0x00000001,
    INSTALLLOGMODE_ERROR          = 0x00000002,
    INSTALLLOGMODE_WARNING        = 0x00000004,
    INSTALLLOGMODE_USER           = 0x00000008,
    INSTALLLOGMODE_INFO           = 0x00000010,
    INSTALLLOGMODE_RESOLVESOURCE  = 0x00000040,
    INSTALLLOGMODE_OUTOFDISKSPACE = 0x00000080,
    INSTALLLOGMODE_ACTIONSTART    = 0x00000100,
    INSTALLLOGMODE_ACTIONDATA     = 0x00000200,
    INSTALLLOGMODE_COMMONDATA     = 0x00000800,
    INSTALLLOGMODE_PROPERTYDUMP   = 0x00000400,
    INSTALLLOGMODE_VERBOSE        = 0x00001000,
    INSTALLLOGMODE_EXTRADEBUG     = 0x00002000,
    INSTALLLOGMODE_LOGONLYONERROR = 0x00004000,
    INSTALLLOGMODE_LOGPERFORMANCE = 0x00008000,
    INSTALLLOGMODE_PROGRESS       = 0x00000400,
    INSTALLLOGMODE_INITIALIZE     = 0x00001000,
    INSTALLLOGMODE_TERMINATE      = 0x00002000,
    INSTALLLOGMODE_SHOWDIALOG     = 0x00004000,
    INSTALLLOGMODE_FILESINUSE     = 0x00000020,
    INSTALLLOGMODE_RMFILESINUSE   = 0x02000000,
    INSTALLLOGMODE_INSTALLSTART   = 0x04000000,
    INSTALLLOGMODE_INSTALLEND     = 0x08000000,
}
alias tagINSTALLOGMODE = int;

enum : int
{
    INSTALLLOGATTRIBUTES_APPEND        = 0x00000001,
    INSTALLLOGATTRIBUTES_FLUSHEACHLINE = 0x00000002,
}
alias INSTALLLOGATTRIBUTES = int;

enum : int
{
    INSTALLFEATUREATTRIBUTE_FAVORLOCAL             = 0x00000001,
    INSTALLFEATUREATTRIBUTE_FAVORSOURCE            = 0x00000002,
    INSTALLFEATUREATTRIBUTE_FOLLOWPARENT           = 0x00000004,
    INSTALLFEATUREATTRIBUTE_FAVORADVERTISE         = 0x00000008,
    INSTALLFEATUREATTRIBUTE_DISALLOWADVERTISE      = 0x00000010,
    INSTALLFEATUREATTRIBUTE_NOUNSUPPORTEDADVERTISE = 0x00000020,
}
alias INSTALLFEATUREATTRIBUTE = int;

enum : int
{
    INSTALLMODE_NODETECTION_ANY    = 0xfffffffc,
    INSTALLMODE_NOSOURCERESOLUTION = 0xfffffffd,
    INSTALLMODE_NODETECTION        = 0xfffffffe,
    INSTALLMODE_EXISTING           = 0xffffffff,
    INSTALLMODE_DEFAULT            = 0x00000000,
}
alias INSTALLMODE = int;

enum : int
{
    MSIPATCHSTATE_INVALID    = 0x00000000,
    MSIPATCHSTATE_APPLIED    = 0x00000001,
    MSIPATCHSTATE_SUPERSEDED = 0x00000002,
    MSIPATCHSTATE_OBSOLETED  = 0x00000004,
    MSIPATCHSTATE_REGISTERED = 0x00000008,
    MSIPATCHSTATE_ALL        = 0x0000000f,
}
alias MSIPATCHSTATE = int;

enum : int
{
    MSIINSTALLCONTEXT_FIRSTVISIBLE   = 0x00000000,
    MSIINSTALLCONTEXT_NONE           = 0x00000000,
    MSIINSTALLCONTEXT_USERMANAGED    = 0x00000001,
    MSIINSTALLCONTEXT_USERUNMANAGED  = 0x00000002,
    MSIINSTALLCONTEXT_MACHINE        = 0x00000004,
    MSIINSTALLCONTEXT_ALL            = 0x00000007,
    MSIINSTALLCONTEXT_ALLUSERMANAGED = 0x00000008,
}
alias MSIINSTALLCONTEXT = int;

enum : int
{
    MSIPATCH_DATATYPE_PATCHFILE = 0x00000000,
    MSIPATCH_DATATYPE_XMLPATH   = 0x00000001,
    MSIPATCH_DATATYPE_XMLBLOB   = 0x00000002,
}
alias MSIPATCHDATATYPE = int;

enum : int
{
    SCRIPTFLAGS_CACHEINFO                = 0x00000001,
    SCRIPTFLAGS_SHORTCUTS                = 0x00000004,
    SCRIPTFLAGS_MACHINEASSIGN            = 0x00000008,
    SCRIPTFLAGS_REGDATA_CNFGINFO         = 0x00000020,
    SCRIPTFLAGS_VALIDATE_TRANSFORMS_LIST = 0x00000040,
    SCRIPTFLAGS_REGDATA_CLASSINFO        = 0x00000080,
    SCRIPTFLAGS_REGDATA_EXTENSIONINFO    = 0x00000100,
    SCRIPTFLAGS_REGDATA_APPINFO          = 0x00000180,
    SCRIPTFLAGS_REGDATA                  = 0x000001a0,
}
alias SCRIPTFLAGS = int;

enum : int
{
    ADVERTISEFLAGS_MACHINEASSIGN = 0x00000000,
    ADVERTISEFLAGS_USERASSIGN    = 0x00000001,
}
alias ADVERTISEFLAGS = int;

enum : int
{
    INSTALLTYPE_DEFAULT         = 0x00000000,
    INSTALLTYPE_NETWORK_IMAGE   = 0x00000001,
    INSTALLTYPE_SINGLE_INSTANCE = 0x00000002,
}
alias INSTALLTYPE = int;

enum : int
{
    MSIARCHITECTUREFLAGS_X86   = 0x00000001,
    MSIARCHITECTUREFLAGS_IA64  = 0x00000002,
    MSIARCHITECTUREFLAGS_AMD64 = 0x00000004,
    MSIARCHITECTUREFLAGS_ARM   = 0x00000008,
}
alias MSIARCHITECTUREFLAGS = int;

enum : int
{
    MSIOPENPACKAGEFLAGS_IGNOREMACHINESTATE = 0x00000001,
}
alias MSIOPENPACKAGEFLAGS = int;

enum : int
{
    MSIADVERTISEOPTIONFLAGS_INSTANCE = 0x00000001,
}
alias MSIADVERTISEOPTIONFLAGS = int;

enum : int
{
    MSISOURCETYPE_UNKNOWN = 0x00000000,
    MSISOURCETYPE_NETWORK = 0x00000001,
    MSISOURCETYPE_URL     = 0x00000002,
    MSISOURCETYPE_MEDIA   = 0x00000004,
}
alias MSISOURCETYPE = int;

enum : int
{
    MSICODE_PRODUCT = 0x00000000,
    MSICODE_PATCH   = 0x40000000,
}
alias MSICODE = int;

enum : int
{
    MSITRANSACTION_CHAIN_EMBEDDEDUI         = 0x00000001,
    MSITRANSACTION_JOIN_EXISTING_EMBEDDEDUI = 0x00000002,
}
alias MSITRANSACTION = int;

enum : int
{
    MSITRANSACTIONSTATE_ROLLBACK = 0x00000000,
    MSITRANSACTIONSTATE_COMMIT   = 0x00000001,
}
alias MSITRANSACTIONSTATE = int;

enum : int
{
    MSIDBSTATE_ERROR = 0xffffffff,
    MSIDBSTATE_READ  = 0x00000000,
    MSIDBSTATE_WRITE = 0x00000001,
}
alias MSIDBSTATE = int;

enum : int
{
    MSIMODIFY_SEEK             = 0xffffffff,
    MSIMODIFY_REFRESH          = 0x00000000,
    MSIMODIFY_INSERT           = 0x00000001,
    MSIMODIFY_UPDATE           = 0x00000002,
    MSIMODIFY_ASSIGN           = 0x00000003,
    MSIMODIFY_REPLACE          = 0x00000004,
    MSIMODIFY_MERGE            = 0x00000005,
    MSIMODIFY_DELETE           = 0x00000006,
    MSIMODIFY_INSERT_TEMPORARY = 0x00000007,
    MSIMODIFY_VALIDATE         = 0x00000008,
    MSIMODIFY_VALIDATE_NEW     = 0x00000009,
    MSIMODIFY_VALIDATE_FIELD   = 0x0000000a,
    MSIMODIFY_VALIDATE_DELETE  = 0x0000000b,
}
alias MSIMODIFY = int;

enum : int
{
    MSICOLINFO_NAMES = 0x00000000,
    MSICOLINFO_TYPES = 0x00000001,
}
alias MSICOLINFO = int;

enum : int
{
    MSICONDITION_FALSE = 0x00000000,
    MSICONDITION_TRUE  = 0x00000001,
    MSICONDITION_NONE  = 0x00000002,
    MSICONDITION_ERROR = 0x00000003,
}
alias MSICONDITION = int;

enum : int
{
    MSICOSTTREE_SELFONLY = 0x00000000,
    MSICOSTTREE_CHILDREN = 0x00000001,
    MSICOSTTREE_PARENTS  = 0x00000002,
    MSICOSTTREE_RESERVED = 0x00000003,
}
alias MSICOSTTREE = int;

enum : int
{
    MSIDBERROR_INVALIDARG        = 0xfffffffd,
    MSIDBERROR_MOREDATA          = 0xfffffffe,
    MSIDBERROR_FUNCTIONERROR     = 0xffffffff,
    MSIDBERROR_NOERROR           = 0x00000000,
    MSIDBERROR_DUPLICATEKEY      = 0x00000001,
    MSIDBERROR_REQUIRED          = 0x00000002,
    MSIDBERROR_BADLINK           = 0x00000003,
    MSIDBERROR_OVERFLOW          = 0x00000004,
    MSIDBERROR_UNDERFLOW         = 0x00000005,
    MSIDBERROR_NOTINSET          = 0x00000006,
    MSIDBERROR_BADVERSION        = 0x00000007,
    MSIDBERROR_BADCASE           = 0x00000008,
    MSIDBERROR_BADGUID           = 0x00000009,
    MSIDBERROR_BADWILDCARD       = 0x0000000a,
    MSIDBERROR_BADIDENTIFIER     = 0x0000000b,
    MSIDBERROR_BADLANGUAGE       = 0x0000000c,
    MSIDBERROR_BADFILENAME       = 0x0000000d,
    MSIDBERROR_BADPATH           = 0x0000000e,
    MSIDBERROR_BADCONDITION      = 0x0000000f,
    MSIDBERROR_BADFORMATTED      = 0x00000010,
    MSIDBERROR_BADTEMPLATE       = 0x00000011,
    MSIDBERROR_BADDEFAULTDIR     = 0x00000012,
    MSIDBERROR_BADREGPATH        = 0x00000013,
    MSIDBERROR_BADCUSTOMSOURCE   = 0x00000014,
    MSIDBERROR_BADPROPERTY       = 0x00000015,
    MSIDBERROR_MISSINGDATA       = 0x00000016,
    MSIDBERROR_BADCATEGORY       = 0x00000017,
    MSIDBERROR_BADKEYTABLE       = 0x00000018,
    MSIDBERROR_BADMAXMINVALUES   = 0x00000019,
    MSIDBERROR_BADCABINET        = 0x0000001a,
    MSIDBERROR_BADSHORTCUT       = 0x0000001b,
    MSIDBERROR_STRINGOVERFLOW    = 0x0000001c,
    MSIDBERROR_BADLOCALIZEATTRIB = 0x0000001d,
}
alias MSIDBERROR = int;

enum : int
{
    MSIRUNMODE_ADMIN            = 0x00000000,
    MSIRUNMODE_ADVERTISE        = 0x00000001,
    MSIRUNMODE_MAINTENANCE      = 0x00000002,
    MSIRUNMODE_ROLLBACKENABLED  = 0x00000003,
    MSIRUNMODE_LOGENABLED       = 0x00000004,
    MSIRUNMODE_OPERATIONS       = 0x00000005,
    MSIRUNMODE_REBOOTATEND      = 0x00000006,
    MSIRUNMODE_REBOOTNOW        = 0x00000007,
    MSIRUNMODE_CABINET          = 0x00000008,
    MSIRUNMODE_SOURCESHORTNAMES = 0x00000009,
    MSIRUNMODE_TARGETSHORTNAMES = 0x0000000a,
    MSIRUNMODE_RESERVED11       = 0x0000000b,
    MSIRUNMODE_WINDOWS9X        = 0x0000000c,
    MSIRUNMODE_ZAWENABLED       = 0x0000000d,
    MSIRUNMODE_RESERVED14       = 0x0000000e,
    MSIRUNMODE_RESERVED15       = 0x0000000f,
    MSIRUNMODE_SCHEDULED        = 0x00000010,
    MSIRUNMODE_ROLLBACK         = 0x00000011,
    MSIRUNMODE_COMMIT           = 0x00000012,
}
alias MSIRUNMODE = int;

enum : int
{
    MSITRANSFORM_ERROR_ADDEXISTINGROW   = 0x00000001,
    MSITRANSFORM_ERROR_DELMISSINGROW    = 0x00000002,
    MSITRANSFORM_ERROR_ADDEXISTINGTABLE = 0x00000004,
    MSITRANSFORM_ERROR_DELMISSINGTABLE  = 0x00000008,
    MSITRANSFORM_ERROR_UPDATEMISSINGROW = 0x00000010,
    MSITRANSFORM_ERROR_CHANGECODEPAGE   = 0x00000020,
    MSITRANSFORM_ERROR_VIEWTRANSFORM    = 0x00000100,
}
alias MSITRANSFORM_ERROR = int;

enum : int
{
    MSITRANSFORM_VALIDATE_LANGUAGE                   = 0x00000001,
    MSITRANSFORM_VALIDATE_PRODUCT                    = 0x00000002,
    MSITRANSFORM_VALIDATE_PLATFORM                   = 0x00000004,
    MSITRANSFORM_VALIDATE_MAJORVERSION               = 0x00000008,
    MSITRANSFORM_VALIDATE_MINORVERSION               = 0x00000010,
    MSITRANSFORM_VALIDATE_UPDATEVERSION              = 0x00000020,
    MSITRANSFORM_VALIDATE_NEWLESSBASEVERSION         = 0x00000040,
    MSITRANSFORM_VALIDATE_NEWLESSEQUALBASEVERSION    = 0x00000080,
    MSITRANSFORM_VALIDATE_NEWEQUALBASEVERSION        = 0x00000100,
    MSITRANSFORM_VALIDATE_NEWGREATEREQUALBASEVERSION = 0x00000200,
    MSITRANSFORM_VALIDATE_NEWGREATERBASEVERSION      = 0x00000400,
    MSITRANSFORM_VALIDATE_UPGRADECODE                = 0x00000800,
}
alias MSITRANSFORM_VALIDATE = int;

enum : int
{
    ASM_NAME_PUBLIC_KEY            = 0x00000000,
    ASM_NAME_PUBLIC_KEY_TOKEN      = 0x00000001,
    ASM_NAME_HASH_VALUE            = 0x00000002,
    ASM_NAME_NAME                  = 0x00000003,
    ASM_NAME_MAJOR_VERSION         = 0x00000004,
    ASM_NAME_MINOR_VERSION         = 0x00000005,
    ASM_NAME_BUILD_NUMBER          = 0x00000006,
    ASM_NAME_REVISION_NUMBER       = 0x00000007,
    ASM_NAME_CULTURE               = 0x00000008,
    ASM_NAME_PROCESSOR_ID_ARRAY    = 0x00000009,
    ASM_NAME_OSINFO_ARRAY          = 0x0000000a,
    ASM_NAME_HASH_ALGID            = 0x0000000b,
    ASM_NAME_ALIAS                 = 0x0000000c,
    ASM_NAME_CODEBASE_URL          = 0x0000000d,
    ASM_NAME_CODEBASE_LASTMOD      = 0x0000000e,
    ASM_NAME_NULL_PUBLIC_KEY       = 0x0000000f,
    ASM_NAME_NULL_PUBLIC_KEY_TOKEN = 0x00000010,
    ASM_NAME_CUSTOM                = 0x00000011,
    ASM_NAME_NULL_CUSTOM           = 0x00000012,
    ASM_NAME_MVID                  = 0x00000013,
    ASM_NAME_MAX_PARAMS            = 0x00000014,
}
alias ASM_NAME = int;

enum : int
{
    ASM_BINDF_FORCE_CACHE_INSTALL = 0x00000001,
    ASM_BINDF_RFS_INTEGRITY_CHECK = 0x00000002,
    ASM_BINDF_RFS_MODULE_CHECK    = 0x00000004,
    ASM_BINDF_BINPATH_PROBE_ONLY  = 0x00000008,
    ASM_BINDF_SHARED_BINPATH_HINT = 0x00000010,
    ASM_BINDF_PARENT_ASM_HINT     = 0x00000020,
}
alias __MIDL_IAssemblyName_0002 = int;

enum : int
{
    ASM_DISPLAYF_VERSION               = 0x00000001,
    ASM_DISPLAYF_CULTURE               = 0x00000002,
    ASM_DISPLAYF_PUBLIC_KEY_TOKEN      = 0x00000004,
    ASM_DISPLAYF_PUBLIC_KEY            = 0x00000008,
    ASM_DISPLAYF_CUSTOM                = 0x00000010,
    ASM_DISPLAYF_PROCESSORARCHITECTURE = 0x00000020,
    ASM_DISPLAYF_LANGUAGEID            = 0x00000040,
}
alias ASM_DISPLAY_FLAGS = int;

enum : int
{
    ASM_CMPF_NAME             = 0x00000001,
    ASM_CMPF_MAJOR_VERSION    = 0x00000002,
    ASM_CMPF_MINOR_VERSION    = 0x00000004,
    ASM_CMPF_BUILD_NUMBER     = 0x00000008,
    ASM_CMPF_REVISION_NUMBER  = 0x00000010,
    ASM_CMPF_PUBLIC_KEY_TOKEN = 0x00000020,
    ASM_CMPF_CULTURE          = 0x00000040,
    ASM_CMPF_CUSTOM           = 0x00000080,
    ASM_CMPF_ALL              = 0x000000ff,
    ASM_CMPF_DEFAULT          = 0x00000100,
}
alias ASM_CMP_FLAGS = int;

enum : int
{
    CANOF_PARSE_DISPLAY_NAME = 0x00000001,
    CANOF_SET_DEFAULT_VALUES = 0x00000002,
}
alias CREATE_ASM_NAME_OBJ_FLAGS = int;

// Callbacks

alias LPDISPLAYVAL = BOOL function(void* pContext, RESULTTYPES uiType, const(wchar)* szwVal, 
                                   const(wchar)* szwDescription, const(wchar)* szwLocation);
alias LPEVALCOMCALLBACK = BOOL function(STATUSTYPES iStatus, const(wchar)* szData, void* pContext);
alias INSTALLUI_HANDLERA = int function(void* pvContext, uint iMessageType, const(char)* szMessage);
alias INSTALLUI_HANDLERW = int function(void* pvContext, uint iMessageType, const(wchar)* szMessage);
alias INSTALLUI_HANDLER_RECORD = int function(void* pvContext, uint iMessageType, uint hRecord);
alias PINSTALLUI_HANDLER_RECORD = int function();
alias PSP_FILE_CALLBACK_A = uint function(void* Context, uint Notification, size_t Param1, size_t Param2);
alias PSP_FILE_CALLBACK_W = uint function(void* Context, uint Notification, size_t Param1, size_t Param2);

// Structs


struct ACTIVATION_CONTEXT_QUERY_INDEX
{
    uint ulAssemblyIndex;
    uint ulFileIndexInAssembly;
}

struct ASSEMBLY_FILE_DETAILED_INFORMATION
{
    uint          ulFlags;
    uint          ulFilenameLength;
    uint          ulPathLength;
    const(wchar)* lpFileName;
    const(wchar)* lpFilePath;
}

struct ACTIVATION_CONTEXT_ASSEMBLY_DETAILED_INFORMATION
{
    uint          ulFlags;
    uint          ulEncodedAssemblyIdentityLength;
    uint          ulManifestPathType;
    uint          ulManifestPathLength;
    LARGE_INTEGER liManifestLastWriteTime;
    uint          ulPolicyPathType;
    uint          ulPolicyPathLength;
    LARGE_INTEGER liPolicyLastWriteTime;
    uint          ulMetadataSatelliteRosterIndex;
    uint          ulManifestVersionMajor;
    uint          ulManifestVersionMinor;
    uint          ulPolicyVersionMajor;
    uint          ulPolicyVersionMinor;
    uint          ulAssemblyDirectoryNameLength;
    const(wchar)* lpAssemblyEncodedAssemblyIdentity;
    const(wchar)* lpAssemblyManifestPath;
    const(wchar)* lpAssemblyPolicyPath;
    const(wchar)* lpAssemblyDirectoryName;
    uint          ulFileCount;
}

struct ACTIVATION_CONTEXT_RUN_LEVEL_INFORMATION
{
    uint ulFlags;
    ACTCTX_REQUESTED_RUN_LEVEL RunLevel;
    uint UiAccess;
}

struct COMPATIBILITY_CONTEXT_ELEMENT
{
    GUID  Id;
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
    uint          dwFlags;
    uint          ulFormatVersion;
    uint          ulAssemblyCount;
    uint          ulRootManifestPathType;
    uint          ulRootManifestPathChars;
    uint          ulRootConfigurationPathType;
    uint          ulRootConfigurationPathChars;
    uint          ulAppDirPathType;
    uint          ulAppDirPathChars;
    const(wchar)* lpRootManifestPath;
    const(wchar)* lpRootConfigurationPath;
    const(wchar)* lpAppDirPath;
}

struct PMSIHANDLE
{
    uint m_h;
}

struct MSIPATCHSEQUENCEINFOA
{
    const(char)*     szPatchData;
    MSIPATCHDATATYPE ePatchDataType;
    uint             dwOrder;
    uint             uStatus;
}

struct MSIPATCHSEQUENCEINFOW
{
    const(wchar)*    szPatchData;
    MSIPATCHDATATYPE ePatchDataType;
    uint             dwOrder;
    uint             uStatus;
}

struct MSIFILEHASHINFO
{
    uint    dwFileHashInfoSize;
    uint[4] dwData;
}

struct ASSEMBLY_INFO
{
    uint           cbAssemblyInfo;
    uint           dwAssemblyFlags;
    ULARGE_INTEGER uliAssemblySizeInKB;
    const(wchar)*  pszCurrentAssemblyPathBuf;
    uint           cchBuf;
}

struct FUSION_INSTALL_REFERENCE
{
    uint          cbSize;
    uint          dwFlags;
    GUID          guidScheme;
    const(wchar)* szIdentifier;
    const(wchar)* szNonCannonicalData;
}

struct PROTECTED_FILE_DATA
{
    ushort[260] FileName;
    uint        FileNumber;
}

struct ACTCTXA
{
    uint         cbSize;
    uint         dwFlags;
    const(char)* lpSource;
    ushort       wProcessorArchitecture;
    ushort       wLangId;
    const(char)* lpAssemblyDirectory;
    const(char)* lpResourceName;
    const(char)* lpApplicationName;
    ptrdiff_t    hModule;
}

struct ACTCTXW
{
    uint          cbSize;
    uint          dwFlags;
    const(wchar)* lpSource;
    ushort        wProcessorArchitecture;
    ushort        wLangId;
    const(wchar)* lpAssemblyDirectory;
    const(wchar)* lpResourceName;
    const(wchar)* lpApplicationName;
    ptrdiff_t     hModule;
}

struct ACTCTX_SECTION_KEYED_DATA
{
    uint   cbSize;
    uint   ulDataFormatVersion;
    void*  lpData;
    uint   ulLength;
    void*  lpSectionGlobalData;
    uint   ulSectionGlobalDataLength;
    void*  lpSectionBase;
    uint   ulSectionTotalLength;
    HANDLE hActCtx;
    uint   ulAssemblyRosterIndex;
    uint   ulFlags;
    ACTCTX_SECTION_KEYED_DATA_ASSEMBLY_METADATA AssemblyMetadata;
}

struct INFCONTEXT
{
align (1):
    void* Inf;
    void* CurrentInf;
    uint  Section;
    uint  Line;
}

struct SP_INF_INFORMATION
{
align (1):
    uint     InfStyle;
    uint     InfCount;
    ubyte[1] VersionData;
}

struct SP_ALTPLATFORM_INFO_V2
{
align (1):
    uint   cbSize;
    uint   Platform;
    uint   MajorVersion;
    uint   MinorVersion;
    ushort ProcessorArchitecture;
    union
    {
    align (1):
        ushort Reserved;
        ushort Flags;
    }
    uint   FirstValidatedMajorVersion;
    uint   FirstValidatedMinorVersion;
}

struct SP_ALTPLATFORM_INFO_V1
{
align (1):
    uint   cbSize;
    uint   Platform;
    uint   MajorVersion;
    uint   MinorVersion;
    ushort ProcessorArchitecture;
    ushort Reserved;
}

struct SP_ORIGINAL_FILE_INFO_A
{
align (1):
    uint      cbSize;
    byte[260] OriginalInfName;
    byte[260] OriginalCatalogName;
}

struct SP_ORIGINAL_FILE_INFO_W
{
align (1):
    uint        cbSize;
    ushort[260] OriginalInfName;
    ushort[260] OriginalCatalogName;
}

struct FILEPATHS_A
{
align (1):
    const(char)* Target;
    const(char)* Source;
    uint         Win32Error;
    uint         Flags;
}

struct FILEPATHS_W
{
align (1):
    const(wchar)* Target;
    const(wchar)* Source;
    uint          Win32Error;
    uint          Flags;
}

struct FILEPATHS_SIGNERINFO_A
{
align (1):
    const(char)* Target;
    const(char)* Source;
    uint         Win32Error;
    uint         Flags;
    const(char)* DigitalSigner;
    const(char)* Version;
    const(char)* CatalogFile;
}

struct FILEPATHS_SIGNERINFO_W
{
align (1):
    const(wchar)* Target;
    const(wchar)* Source;
    uint          Win32Error;
    uint          Flags;
    const(wchar)* DigitalSigner;
    const(wchar)* Version;
    const(wchar)* CatalogFile;
}

struct SOURCE_MEDIA_A
{
align (1):
    const(char)* Reserved;
    const(char)* Tagfile;
    const(char)* Description;
    const(char)* SourcePath;
    const(char)* SourceFile;
    uint         Flags;
}

struct SOURCE_MEDIA_W
{
align (1):
    const(wchar)* Reserved;
    const(wchar)* Tagfile;
    const(wchar)* Description;
    const(wchar)* SourcePath;
    const(wchar)* SourceFile;
    uint          Flags;
}

struct CABINET_INFO_A
{
align (1):
    const(char)* CabinetPath;
    const(char)* CabinetFile;
    const(char)* DiskName;
    ushort       SetId;
    ushort       CabinetNumber;
}

struct CABINET_INFO_W
{
align (1):
    const(wchar)* CabinetPath;
    const(wchar)* CabinetFile;
    const(wchar)* DiskName;
    ushort        SetId;
    ushort        CabinetNumber;
}

struct FILE_IN_CABINET_INFO_A
{
align (1):
    const(char)* NameInCabinet;
    uint         FileSize;
    uint         Win32Error;
    ushort       DosDate;
    ushort       DosTime;
    ushort       DosAttribs;
    byte[260]    FullTargetName;
}

struct FILE_IN_CABINET_INFO_W
{
align (1):
    const(wchar)* NameInCabinet;
    uint          FileSize;
    uint          Win32Error;
    ushort        DosDate;
    ushort        DosTime;
    ushort        DosAttribs;
    ushort[260]   FullTargetName;
}

struct SP_REGISTER_CONTROL_STATUSA
{
align (1):
    uint         cbSize;
    const(char)* FileName;
    uint         Win32Error;
    uint         FailureCode;
}

struct SP_REGISTER_CONTROL_STATUSW
{
align (1):
    uint          cbSize;
    const(wchar)* FileName;
    uint          Win32Error;
    uint          FailureCode;
}

struct SP_FILE_COPY_PARAMS_A
{
align (1):
    uint         cbSize;
    void*        QueueHandle;
    const(char)* SourceRootPath;
    const(char)* SourcePath;
    const(char)* SourceFilename;
    const(char)* SourceDescription;
    const(char)* SourceTagfile;
    const(char)* TargetDirectory;
    const(char)* TargetFilename;
    uint         CopyStyle;
    void*        LayoutInf;
    const(char)* SecurityDescriptor;
}

struct SP_FILE_COPY_PARAMS_W
{
align (1):
    uint          cbSize;
    void*         QueueHandle;
    const(wchar)* SourceRootPath;
    const(wchar)* SourcePath;
    const(wchar)* SourceFilename;
    const(wchar)* SourceDescription;
    const(wchar)* SourceTagfile;
    const(wchar)* TargetDirectory;
    const(wchar)* TargetFilename;
    uint          CopyStyle;
    void*         LayoutInf;
    const(wchar)* SecurityDescriptor;
}

struct SP_INF_SIGNER_INFO_V1_A
{
align (1):
    uint      cbSize;
    byte[260] CatalogFile;
    byte[260] DigitalSigner;
    byte[260] DigitalSignerVersion;
}

struct SP_INF_SIGNER_INFO_V1_W
{
align (1):
    uint        cbSize;
    ushort[260] CatalogFile;
    ushort[260] DigitalSigner;
    ushort[260] DigitalSignerVersion;
}

struct SP_INF_SIGNER_INFO_V2_A
{
align (1):
    uint      cbSize;
    byte[260] CatalogFile;
    byte[260] DigitalSigner;
    byte[260] DigitalSignerVersion;
    uint      SignerScore;
}

struct SP_INF_SIGNER_INFO_V2_W
{
align (1):
    uint        cbSize;
    ushort[260] CatalogFile;
    ushort[260] DigitalSigner;
    ushort[260] DigitalSignerVersion;
    uint        SignerScore;
}

// Functions

@DllImport("msi")
uint MsiCloseHandle(uint hAny);

@DllImport("msi")
uint MsiCloseAllHandles();

@DllImport("msi")
INSTALLUILEVEL MsiSetInternalUI(INSTALLUILEVEL dwUILevel, HWND* phWnd);

@DllImport("msi")
INSTALLUI_HANDLERA MsiSetExternalUIA(INSTALLUI_HANDLERA puiHandler, uint dwMessageFilter, void* pvContext);

@DllImport("msi")
INSTALLUI_HANDLERW MsiSetExternalUIW(INSTALLUI_HANDLERW puiHandler, uint dwMessageFilter, void* pvContext);

@DllImport("msi")
uint MsiSetExternalUIRecord(INSTALLUI_HANDLER_RECORD puiHandler, uint dwMessageFilter, void* pvContext, 
                            PINSTALLUI_HANDLER_RECORD ppuiPrevHandler);

@DllImport("msi")
uint MsiEnableLogA(uint dwLogMode, const(char)* szLogFile, uint dwLogAttributes);

@DllImport("msi")
uint MsiEnableLogW(uint dwLogMode, const(wchar)* szLogFile, uint dwLogAttributes);

@DllImport("msi")
INSTALLSTATE MsiQueryProductStateA(const(char)* szProduct);

@DllImport("msi")
INSTALLSTATE MsiQueryProductStateW(const(wchar)* szProduct);

@DllImport("msi")
uint MsiGetProductInfoA(const(char)* szProduct, const(char)* szAttribute, const(char)* lpValueBuf, 
                        uint* pcchValueBuf);

@DllImport("msi")
uint MsiGetProductInfoW(const(wchar)* szProduct, const(wchar)* szAttribute, const(wchar)* lpValueBuf, 
                        uint* pcchValueBuf);

@DllImport("msi")
uint MsiGetProductInfoExA(const(char)* szProductCode, const(char)* szUserSid, MSIINSTALLCONTEXT dwContext, 
                          const(char)* szProperty, const(char)* szValue, uint* pcchValue);

@DllImport("msi")
uint MsiGetProductInfoExW(const(wchar)* szProductCode, const(wchar)* szUserSid, MSIINSTALLCONTEXT dwContext, 
                          const(wchar)* szProperty, const(wchar)* szValue, uint* pcchValue);

@DllImport("msi")
uint MsiInstallProductA(const(char)* szPackagePath, const(char)* szCommandLine);

@DllImport("msi")
uint MsiInstallProductW(const(wchar)* szPackagePath, const(wchar)* szCommandLine);

@DllImport("msi")
uint MsiConfigureProductA(const(char)* szProduct, int iInstallLevel, INSTALLSTATE eInstallState);

@DllImport("msi")
uint MsiConfigureProductW(const(wchar)* szProduct, int iInstallLevel, INSTALLSTATE eInstallState);

@DllImport("msi")
uint MsiConfigureProductExA(const(char)* szProduct, int iInstallLevel, INSTALLSTATE eInstallState, 
                            const(char)* szCommandLine);

@DllImport("msi")
uint MsiConfigureProductExW(const(wchar)* szProduct, int iInstallLevel, INSTALLSTATE eInstallState, 
                            const(wchar)* szCommandLine);

@DllImport("msi")
uint MsiReinstallProductA(const(char)* szProduct, uint szReinstallMode);

@DllImport("msi")
uint MsiReinstallProductW(const(wchar)* szProduct, uint szReinstallMode);

@DllImport("msi")
uint MsiAdvertiseProductExA(const(char)* szPackagePath, const(char)* szScriptfilePath, const(char)* szTransforms, 
                            ushort lgidLanguage, uint dwPlatform, uint dwOptions);

@DllImport("msi")
uint MsiAdvertiseProductExW(const(wchar)* szPackagePath, const(wchar)* szScriptfilePath, 
                            const(wchar)* szTransforms, ushort lgidLanguage, uint dwPlatform, uint dwOptions);

@DllImport("msi")
uint MsiAdvertiseProductA(const(char)* szPackagePath, const(char)* szScriptfilePath, const(char)* szTransforms, 
                          ushort lgidLanguage);

@DllImport("msi")
uint MsiAdvertiseProductW(const(wchar)* szPackagePath, const(wchar)* szScriptfilePath, const(wchar)* szTransforms, 
                          ushort lgidLanguage);

@DllImport("msi")
uint MsiProcessAdvertiseScriptA(const(char)* szScriptFile, const(char)* szIconFolder, HKEY hRegData, 
                                BOOL fShortcuts, BOOL fRemoveItems);

@DllImport("msi")
uint MsiProcessAdvertiseScriptW(const(wchar)* szScriptFile, const(wchar)* szIconFolder, HKEY hRegData, 
                                BOOL fShortcuts, BOOL fRemoveItems);

@DllImport("msi")
uint MsiAdvertiseScriptA(const(char)* szScriptFile, uint dwFlags, HKEY* phRegData, BOOL fRemoveItems);

@DllImport("msi")
uint MsiAdvertiseScriptW(const(wchar)* szScriptFile, uint dwFlags, HKEY* phRegData, BOOL fRemoveItems);

@DllImport("msi")
uint MsiGetProductInfoFromScriptA(const(char)* szScriptFile, const(char)* lpProductBuf39, ushort* plgidLanguage, 
                                  uint* pdwVersion, const(char)* lpNameBuf, uint* pcchNameBuf, 
                                  const(char)* lpPackageBuf, uint* pcchPackageBuf);

@DllImport("msi")
uint MsiGetProductInfoFromScriptW(const(wchar)* szScriptFile, const(wchar)* lpProductBuf39, ushort* plgidLanguage, 
                                  uint* pdwVersion, const(wchar)* lpNameBuf, uint* pcchNameBuf, 
                                  const(wchar)* lpPackageBuf, uint* pcchPackageBuf);

@DllImport("msi")
uint MsiGetProductCodeA(const(char)* szComponent, const(char)* lpBuf39);

@DllImport("msi")
uint MsiGetProductCodeW(const(wchar)* szComponent, const(wchar)* lpBuf39);

@DllImport("msi")
USERINFOSTATE MsiGetUserInfoA(const(char)* szProduct, const(char)* lpUserNameBuf, uint* pcchUserNameBuf, 
                              const(char)* lpOrgNameBuf, uint* pcchOrgNameBuf, const(char)* lpSerialBuf, 
                              uint* pcchSerialBuf);

@DllImport("msi")
USERINFOSTATE MsiGetUserInfoW(const(wchar)* szProduct, const(wchar)* lpUserNameBuf, uint* pcchUserNameBuf, 
                              const(wchar)* lpOrgNameBuf, uint* pcchOrgNameBuf, const(wchar)* lpSerialBuf, 
                              uint* pcchSerialBuf);

@DllImport("msi")
uint MsiCollectUserInfoA(const(char)* szProduct);

@DllImport("msi")
uint MsiCollectUserInfoW(const(wchar)* szProduct);

@DllImport("msi")
uint MsiApplyPatchA(const(char)* szPatchPackage, const(char)* szInstallPackage, INSTALLTYPE eInstallType, 
                    const(char)* szCommandLine);

@DllImport("msi")
uint MsiApplyPatchW(const(wchar)* szPatchPackage, const(wchar)* szInstallPackage, INSTALLTYPE eInstallType, 
                    const(wchar)* szCommandLine);

@DllImport("msi")
uint MsiGetPatchInfoA(const(char)* szPatch, const(char)* szAttribute, const(char)* lpValueBuf, uint* pcchValueBuf);

@DllImport("msi")
uint MsiGetPatchInfoW(const(wchar)* szPatch, const(wchar)* szAttribute, const(wchar)* lpValueBuf, 
                      uint* pcchValueBuf);

@DllImport("msi")
uint MsiEnumPatchesA(const(char)* szProduct, uint iPatchIndex, const(char)* lpPatchBuf, 
                     const(char)* lpTransformsBuf, uint* pcchTransformsBuf);

@DllImport("msi")
uint MsiEnumPatchesW(const(wchar)* szProduct, uint iPatchIndex, const(wchar)* lpPatchBuf, 
                     const(wchar)* lpTransformsBuf, uint* pcchTransformsBuf);

@DllImport("msi")
uint MsiRemovePatchesA(const(char)* szPatchList, const(char)* szProductCode, INSTALLTYPE eUninstallType, 
                       const(char)* szPropertyList);

@DllImport("msi")
uint MsiRemovePatchesW(const(wchar)* szPatchList, const(wchar)* szProductCode, INSTALLTYPE eUninstallType, 
                       const(wchar)* szPropertyList);

@DllImport("msi")
uint MsiExtractPatchXMLDataA(const(char)* szPatchPath, uint dwReserved, const(char)* szXMLData, uint* pcchXMLData);

@DllImport("msi")
uint MsiExtractPatchXMLDataW(const(wchar)* szPatchPath, uint dwReserved, const(wchar)* szXMLData, 
                             uint* pcchXMLData);

@DllImport("msi")
uint MsiGetPatchInfoExA(const(char)* szPatchCode, const(char)* szProductCode, const(char)* szUserSid, 
                        MSIINSTALLCONTEXT dwContext, const(char)* szProperty, const(char)* lpValue, uint* pcchValue);

@DllImport("msi")
uint MsiGetPatchInfoExW(const(wchar)* szPatchCode, const(wchar)* szProductCode, const(wchar)* szUserSid, 
                        MSIINSTALLCONTEXT dwContext, const(wchar)* szProperty, const(wchar)* lpValue, 
                        uint* pcchValue);

@DllImport("msi")
uint MsiApplyMultiplePatchesA(const(char)* szPatchPackages, const(char)* szProductCode, 
                              const(char)* szPropertiesList);

@DllImport("msi")
uint MsiApplyMultiplePatchesW(const(wchar)* szPatchPackages, const(wchar)* szProductCode, 
                              const(wchar)* szPropertiesList);

@DllImport("msi")
uint MsiDeterminePatchSequenceA(const(char)* szProductCode, const(char)* szUserSid, MSIINSTALLCONTEXT dwContext, 
                                uint cPatchInfo, char* pPatchInfo);

@DllImport("msi")
uint MsiDeterminePatchSequenceW(const(wchar)* szProductCode, const(wchar)* szUserSid, MSIINSTALLCONTEXT dwContext, 
                                uint cPatchInfo, char* pPatchInfo);

@DllImport("msi")
uint MsiDetermineApplicablePatchesA(const(char)* szProductPackagePath, uint cPatchInfo, char* pPatchInfo);

@DllImport("msi")
uint MsiDetermineApplicablePatchesW(const(wchar)* szProductPackagePath, uint cPatchInfo, char* pPatchInfo);

@DllImport("msi")
uint MsiEnumPatchesExA(const(char)* szProductCode, const(char)* szUserSid, uint dwContext, uint dwFilter, 
                       uint dwIndex, char* szPatchCode, char* szTargetProductCode, 
                       MSIINSTALLCONTEXT* pdwTargetProductContext, const(char)* szTargetUserSid, 
                       uint* pcchTargetUserSid);

@DllImport("msi")
uint MsiEnumPatchesExW(const(wchar)* szProductCode, const(wchar)* szUserSid, uint dwContext, uint dwFilter, 
                       uint dwIndex, char* szPatchCode, char* szTargetProductCode, 
                       MSIINSTALLCONTEXT* pdwTargetProductContext, const(wchar)* szTargetUserSid, 
                       uint* pcchTargetUserSid);

@DllImport("msi")
INSTALLSTATE MsiQueryFeatureStateA(const(char)* szProduct, const(char)* szFeature);

@DllImport("msi")
INSTALLSTATE MsiQueryFeatureStateW(const(wchar)* szProduct, const(wchar)* szFeature);

@DllImport("msi")
uint MsiQueryFeatureStateExA(const(char)* szProductCode, const(char)* szUserSid, MSIINSTALLCONTEXT dwContext, 
                             const(char)* szFeature, INSTALLSTATE* pdwState);

@DllImport("msi")
uint MsiQueryFeatureStateExW(const(wchar)* szProductCode, const(wchar)* szUserSid, MSIINSTALLCONTEXT dwContext, 
                             const(wchar)* szFeature, INSTALLSTATE* pdwState);

@DllImport("msi")
INSTALLSTATE MsiUseFeatureA(const(char)* szProduct, const(char)* szFeature);

@DllImport("msi")
INSTALLSTATE MsiUseFeatureW(const(wchar)* szProduct, const(wchar)* szFeature);

@DllImport("msi")
INSTALLSTATE MsiUseFeatureExA(const(char)* szProduct, const(char)* szFeature, uint dwInstallMode, uint dwReserved);

@DllImport("msi")
INSTALLSTATE MsiUseFeatureExW(const(wchar)* szProduct, const(wchar)* szFeature, uint dwInstallMode, 
                              uint dwReserved);

@DllImport("msi")
uint MsiGetFeatureUsageA(const(char)* szProduct, const(char)* szFeature, uint* pdwUseCount, ushort* pwDateUsed);

@DllImport("msi")
uint MsiGetFeatureUsageW(const(wchar)* szProduct, const(wchar)* szFeature, uint* pdwUseCount, ushort* pwDateUsed);

@DllImport("msi")
uint MsiConfigureFeatureA(const(char)* szProduct, const(char)* szFeature, INSTALLSTATE eInstallState);

@DllImport("msi")
uint MsiConfigureFeatureW(const(wchar)* szProduct, const(wchar)* szFeature, INSTALLSTATE eInstallState);

@DllImport("msi")
uint MsiReinstallFeatureA(const(char)* szProduct, const(char)* szFeature, uint dwReinstallMode);

@DllImport("msi")
uint MsiReinstallFeatureW(const(wchar)* szProduct, const(wchar)* szFeature, uint dwReinstallMode);

@DllImport("msi")
uint MsiProvideComponentA(const(char)* szProduct, const(char)* szFeature, const(char)* szComponent, 
                          uint dwInstallMode, const(char)* lpPathBuf, uint* pcchPathBuf);

@DllImport("msi")
uint MsiProvideComponentW(const(wchar)* szProduct, const(wchar)* szFeature, const(wchar)* szComponent, 
                          uint dwInstallMode, const(wchar)* lpPathBuf, uint* pcchPathBuf);

@DllImport("msi")
uint MsiProvideQualifiedComponentA(const(char)* szCategory, const(char)* szQualifier, uint dwInstallMode, 
                                   const(char)* lpPathBuf, uint* pcchPathBuf);

@DllImport("msi")
uint MsiProvideQualifiedComponentW(const(wchar)* szCategory, const(wchar)* szQualifier, uint dwInstallMode, 
                                   const(wchar)* lpPathBuf, uint* pcchPathBuf);

@DllImport("msi")
uint MsiProvideQualifiedComponentExA(const(char)* szCategory, const(char)* szQualifier, uint dwInstallMode, 
                                     const(char)* szProduct, uint dwUnused1, uint dwUnused2, const(char)* lpPathBuf, 
                                     uint* pcchPathBuf);

@DllImport("msi")
uint MsiProvideQualifiedComponentExW(const(wchar)* szCategory, const(wchar)* szQualifier, uint dwInstallMode, 
                                     const(wchar)* szProduct, uint dwUnused1, uint dwUnused2, 
                                     const(wchar)* lpPathBuf, uint* pcchPathBuf);

@DllImport("msi")
INSTALLSTATE MsiGetComponentPathA(const(char)* szProduct, const(char)* szComponent, const(char)* lpPathBuf, 
                                  uint* pcchBuf);

@DllImport("msi")
INSTALLSTATE MsiGetComponentPathW(const(wchar)* szProduct, const(wchar)* szComponent, const(wchar)* lpPathBuf, 
                                  uint* pcchBuf);

@DllImport("msi")
INSTALLSTATE MsiGetComponentPathExA(const(char)* szProductCode, const(char)* szComponentCode, 
                                    const(char)* szUserSid, MSIINSTALLCONTEXT dwContext, 
                                    const(char)* lpOutPathBuffer, uint* pcchOutPathBuffer);

@DllImport("msi")
INSTALLSTATE MsiGetComponentPathExW(const(wchar)* szProductCode, const(wchar)* szComponentCode, 
                                    const(wchar)* szUserSid, MSIINSTALLCONTEXT dwContext, 
                                    const(wchar)* lpOutPathBuffer, uint* pcchOutPathBuffer);

@DllImport("msi")
uint MsiProvideAssemblyA(const(char)* szAssemblyName, const(char)* szAppContext, uint dwInstallMode, 
                         uint dwAssemblyInfo, const(char)* lpPathBuf, uint* pcchPathBuf);

@DllImport("msi")
uint MsiProvideAssemblyW(const(wchar)* szAssemblyName, const(wchar)* szAppContext, uint dwInstallMode, 
                         uint dwAssemblyInfo, const(wchar)* lpPathBuf, uint* pcchPathBuf);

@DllImport("msi")
uint MsiQueryComponentStateA(const(char)* szProductCode, const(char)* szUserSid, MSIINSTALLCONTEXT dwContext, 
                             const(char)* szComponentCode, INSTALLSTATE* pdwState);

@DllImport("msi")
uint MsiQueryComponentStateW(const(wchar)* szProductCode, const(wchar)* szUserSid, MSIINSTALLCONTEXT dwContext, 
                             const(wchar)* szComponentCode, INSTALLSTATE* pdwState);

@DllImport("msi")
uint MsiEnumProductsA(uint iProductIndex, const(char)* lpProductBuf);

@DllImport("msi")
uint MsiEnumProductsW(uint iProductIndex, const(wchar)* lpProductBuf);

@DllImport("msi")
uint MsiEnumProductsExA(const(char)* szProductCode, const(char)* szUserSid, uint dwContext, uint dwIndex, 
                        char* szInstalledProductCode, MSIINSTALLCONTEXT* pdwInstalledContext, const(char)* szSid, 
                        uint* pcchSid);

@DllImport("msi")
uint MsiEnumProductsExW(const(wchar)* szProductCode, const(wchar)* szUserSid, uint dwContext, uint dwIndex, 
                        char* szInstalledProductCode, MSIINSTALLCONTEXT* pdwInstalledContext, const(wchar)* szSid, 
                        uint* pcchSid);

@DllImport("msi")
uint MsiEnumRelatedProductsA(const(char)* lpUpgradeCode, uint dwReserved, uint iProductIndex, 
                             const(char)* lpProductBuf);

@DllImport("msi")
uint MsiEnumRelatedProductsW(const(wchar)* lpUpgradeCode, uint dwReserved, uint iProductIndex, 
                             const(wchar)* lpProductBuf);

@DllImport("msi")
uint MsiEnumFeaturesA(const(char)* szProduct, uint iFeatureIndex, const(char)* lpFeatureBuf, 
                      const(char)* lpParentBuf);

@DllImport("msi")
uint MsiEnumFeaturesW(const(wchar)* szProduct, uint iFeatureIndex, const(wchar)* lpFeatureBuf, 
                      const(wchar)* lpParentBuf);

@DllImport("msi")
uint MsiEnumComponentsA(uint iComponentIndex, const(char)* lpComponentBuf);

@DllImport("msi")
uint MsiEnumComponentsW(uint iComponentIndex, const(wchar)* lpComponentBuf);

@DllImport("msi")
uint MsiEnumComponentsExA(const(char)* szUserSid, uint dwContext, uint dwIndex, char* szInstalledComponentCode, 
                          MSIINSTALLCONTEXT* pdwInstalledContext, const(char)* szSid, uint* pcchSid);

@DllImport("msi")
uint MsiEnumComponentsExW(const(wchar)* szUserSid, uint dwContext, uint dwIndex, char* szInstalledComponentCode, 
                          MSIINSTALLCONTEXT* pdwInstalledContext, const(wchar)* szSid, uint* pcchSid);

@DllImport("msi")
uint MsiEnumClientsA(const(char)* szComponent, uint iProductIndex, const(char)* lpProductBuf);

@DllImport("msi")
uint MsiEnumClientsW(const(wchar)* szComponent, uint iProductIndex, const(wchar)* lpProductBuf);

@DllImport("msi")
uint MsiEnumClientsExA(const(char)* szComponent, const(char)* szUserSid, uint dwContext, uint dwProductIndex, 
                       char* szProductBuf, MSIINSTALLCONTEXT* pdwInstalledContext, const(char)* szSid, uint* pcchSid);

@DllImport("msi")
uint MsiEnumClientsExW(const(wchar)* szComponent, const(wchar)* szUserSid, uint dwContext, uint dwProductIndex, 
                       char* szProductBuf, MSIINSTALLCONTEXT* pdwInstalledContext, const(wchar)* szSid, 
                       uint* pcchSid);

@DllImport("msi")
uint MsiEnumComponentQualifiersA(const(char)* szComponent, uint iIndex, const(char)* lpQualifierBuf, 
                                 uint* pcchQualifierBuf, const(char)* lpApplicationDataBuf, 
                                 uint* pcchApplicationDataBuf);

@DllImport("msi")
uint MsiEnumComponentQualifiersW(const(wchar)* szComponent, uint iIndex, const(wchar)* lpQualifierBuf, 
                                 uint* pcchQualifierBuf, const(wchar)* lpApplicationDataBuf, 
                                 uint* pcchApplicationDataBuf);

@DllImport("msi")
uint MsiOpenProductA(const(char)* szProduct, uint* hProduct);

@DllImport("msi")
uint MsiOpenProductW(const(wchar)* szProduct, uint* hProduct);

@DllImport("msi")
uint MsiOpenPackageA(const(char)* szPackagePath, uint* hProduct);

@DllImport("msi")
uint MsiOpenPackageW(const(wchar)* szPackagePath, uint* hProduct);

@DllImport("msi")
uint MsiOpenPackageExA(const(char)* szPackagePath, uint dwOptions, uint* hProduct);

@DllImport("msi")
uint MsiOpenPackageExW(const(wchar)* szPackagePath, uint dwOptions, uint* hProduct);

@DllImport("msi")
uint MsiGetPatchFileListA(const(char)* szProductCode, const(char)* szPatchPackages, uint* pcFiles, 
                          uint** pphFileRecords);

@DllImport("msi")
uint MsiGetPatchFileListW(const(wchar)* szProductCode, const(wchar)* szPatchPackages, uint* pcFiles, 
                          uint** pphFileRecords);

@DllImport("msi")
uint MsiGetProductPropertyA(uint hProduct, const(char)* szProperty, const(char)* lpValueBuf, uint* pcchValueBuf);

@DllImport("msi")
uint MsiGetProductPropertyW(uint hProduct, const(wchar)* szProperty, const(wchar)* lpValueBuf, uint* pcchValueBuf);

@DllImport("msi")
uint MsiVerifyPackageA(const(char)* szPackagePath);

@DllImport("msi")
uint MsiVerifyPackageW(const(wchar)* szPackagePath);

@DllImport("msi")
uint MsiGetFeatureInfoA(uint hProduct, const(char)* szFeature, uint* lpAttributes, const(char)* lpTitleBuf, 
                        uint* pcchTitleBuf, const(char)* lpHelpBuf, uint* pcchHelpBuf);

@DllImport("msi")
uint MsiGetFeatureInfoW(uint hProduct, const(wchar)* szFeature, uint* lpAttributes, const(wchar)* lpTitleBuf, 
                        uint* pcchTitleBuf, const(wchar)* lpHelpBuf, uint* pcchHelpBuf);

@DllImport("msi")
uint MsiInstallMissingComponentA(const(char)* szProduct, const(char)* szComponent, INSTALLSTATE eInstallState);

@DllImport("msi")
uint MsiInstallMissingComponentW(const(wchar)* szProduct, const(wchar)* szComponent, INSTALLSTATE eInstallState);

@DllImport("msi")
uint MsiInstallMissingFileA(const(char)* szProduct, const(char)* szFile);

@DllImport("msi")
uint MsiInstallMissingFileW(const(wchar)* szProduct, const(wchar)* szFile);

@DllImport("msi")
INSTALLSTATE MsiLocateComponentA(const(char)* szComponent, const(char)* lpPathBuf, uint* pcchBuf);

@DllImport("msi")
INSTALLSTATE MsiLocateComponentW(const(wchar)* szComponent, const(wchar)* lpPathBuf, uint* pcchBuf);

@DllImport("msi")
uint MsiSourceListClearAllA(const(char)* szProduct, const(char)* szUserName, uint dwReserved);

@DllImport("msi")
uint MsiSourceListClearAllW(const(wchar)* szProduct, const(wchar)* szUserName, uint dwReserved);

@DllImport("msi")
uint MsiSourceListAddSourceA(const(char)* szProduct, const(char)* szUserName, uint dwReserved, 
                             const(char)* szSource);

@DllImport("msi")
uint MsiSourceListAddSourceW(const(wchar)* szProduct, const(wchar)* szUserName, uint dwReserved, 
                             const(wchar)* szSource);

@DllImport("msi")
uint MsiSourceListForceResolutionA(const(char)* szProduct, const(char)* szUserName, uint dwReserved);

@DllImport("msi")
uint MsiSourceListForceResolutionW(const(wchar)* szProduct, const(wchar)* szUserName, uint dwReserved);

@DllImport("msi")
uint MsiSourceListAddSourceExA(const(char)* szProductCodeOrPatchCode, const(char)* szUserSid, 
                               MSIINSTALLCONTEXT dwContext, uint dwOptions, const(char)* szSource, uint dwIndex);

@DllImport("msi")
uint MsiSourceListAddSourceExW(const(wchar)* szProductCodeOrPatchCode, const(wchar)* szUserSid, 
                               MSIINSTALLCONTEXT dwContext, uint dwOptions, const(wchar)* szSource, uint dwIndex);

@DllImport("msi")
uint MsiSourceListAddMediaDiskA(const(char)* szProductCodeOrPatchCode, const(char)* szUserSid, 
                                MSIINSTALLCONTEXT dwContext, uint dwOptions, uint dwDiskId, 
                                const(char)* szVolumeLabel, const(char)* szDiskPrompt);

@DllImport("msi")
uint MsiSourceListAddMediaDiskW(const(wchar)* szProductCodeOrPatchCode, const(wchar)* szUserSid, 
                                MSIINSTALLCONTEXT dwContext, uint dwOptions, uint dwDiskId, 
                                const(wchar)* szVolumeLabel, const(wchar)* szDiskPrompt);

@DllImport("msi")
uint MsiSourceListClearSourceA(const(char)* szProductCodeOrPatchCode, const(char)* szUserSid, 
                               MSIINSTALLCONTEXT dwContext, uint dwOptions, const(char)* szSource);

@DllImport("msi")
uint MsiSourceListClearSourceW(const(wchar)* szProductCodeOrPatchCode, const(wchar)* szUserSid, 
                               MSIINSTALLCONTEXT dwContext, uint dwOptions, const(wchar)* szSource);

@DllImport("msi")
uint MsiSourceListClearMediaDiskA(const(char)* szProductCodeOrPatchCode, const(char)* szUserSid, 
                                  MSIINSTALLCONTEXT dwContext, uint dwOptions, uint dwDiskId);

@DllImport("msi")
uint MsiSourceListClearMediaDiskW(const(wchar)* szProductCodeOrPatchCode, const(wchar)* szUserSid, 
                                  MSIINSTALLCONTEXT dwContext, uint dwOptions, uint dwDiskId);

@DllImport("msi")
uint MsiSourceListClearAllExA(const(char)* szProductCodeOrPatchCode, const(char)* szUserSid, 
                              MSIINSTALLCONTEXT dwContext, uint dwOptions);

@DllImport("msi")
uint MsiSourceListClearAllExW(const(wchar)* szProductCodeOrPatchCode, const(wchar)* szUserSid, 
                              MSIINSTALLCONTEXT dwContext, uint dwOptions);

@DllImport("msi")
uint MsiSourceListForceResolutionExA(const(char)* szProductCodeOrPatchCode, const(char)* szUserSid, 
                                     MSIINSTALLCONTEXT dwContext, uint dwOptions);

@DllImport("msi")
uint MsiSourceListForceResolutionExW(const(wchar)* szProductCodeOrPatchCode, const(wchar)* szUserSid, 
                                     MSIINSTALLCONTEXT dwContext, uint dwOptions);

@DllImport("msi")
uint MsiSourceListSetInfoA(const(char)* szProductCodeOrPatchCode, const(char)* szUserSid, 
                           MSIINSTALLCONTEXT dwContext, uint dwOptions, const(char)* szProperty, 
                           const(char)* szValue);

@DllImport("msi")
uint MsiSourceListSetInfoW(const(wchar)* szProductCodeOrPatchCode, const(wchar)* szUserSid, 
                           MSIINSTALLCONTEXT dwContext, uint dwOptions, const(wchar)* szProperty, 
                           const(wchar)* szValue);

@DllImport("msi")
uint MsiSourceListGetInfoA(const(char)* szProductCodeOrPatchCode, const(char)* szUserSid, 
                           MSIINSTALLCONTEXT dwContext, uint dwOptions, const(char)* szProperty, 
                           const(char)* szValue, uint* pcchValue);

@DllImport("msi")
uint MsiSourceListGetInfoW(const(wchar)* szProductCodeOrPatchCode, const(wchar)* szUserSid, 
                           MSIINSTALLCONTEXT dwContext, uint dwOptions, const(wchar)* szProperty, 
                           const(wchar)* szValue, uint* pcchValue);

@DllImport("msi")
uint MsiSourceListEnumSourcesA(const(char)* szProductCodeOrPatchCode, const(char)* szUserSid, 
                               MSIINSTALLCONTEXT dwContext, uint dwOptions, uint dwIndex, const(char)* szSource, 
                               uint* pcchSource);

@DllImport("msi")
uint MsiSourceListEnumSourcesW(const(wchar)* szProductCodeOrPatchCode, const(wchar)* szUserSid, 
                               MSIINSTALLCONTEXT dwContext, uint dwOptions, uint dwIndex, const(wchar)* szSource, 
                               uint* pcchSource);

@DllImport("msi")
uint MsiSourceListEnumMediaDisksA(const(char)* szProductCodeOrPatchCode, const(char)* szUserSid, 
                                  MSIINSTALLCONTEXT dwContext, uint dwOptions, uint dwIndex, uint* pdwDiskId, 
                                  const(char)* szVolumeLabel, uint* pcchVolumeLabel, const(char)* szDiskPrompt, 
                                  uint* pcchDiskPrompt);

@DllImport("msi")
uint MsiSourceListEnumMediaDisksW(const(wchar)* szProductCodeOrPatchCode, const(wchar)* szUserSid, 
                                  MSIINSTALLCONTEXT dwContext, uint dwOptions, uint dwIndex, uint* pdwDiskId, 
                                  const(wchar)* szVolumeLabel, uint* pcchVolumeLabel, const(wchar)* szDiskPrompt, 
                                  uint* pcchDiskPrompt);

@DllImport("msi")
uint MsiGetFileVersionA(const(char)* szFilePath, const(char)* lpVersionBuf, uint* pcchVersionBuf, 
                        const(char)* lpLangBuf, uint* pcchLangBuf);

@DllImport("msi")
uint MsiGetFileVersionW(const(wchar)* szFilePath, const(wchar)* lpVersionBuf, uint* pcchVersionBuf, 
                        const(wchar)* lpLangBuf, uint* pcchLangBuf);

@DllImport("msi")
uint MsiGetFileHashA(const(char)* szFilePath, uint dwOptions, MSIFILEHASHINFO* pHash);

@DllImport("msi")
uint MsiGetFileHashW(const(wchar)* szFilePath, uint dwOptions, MSIFILEHASHINFO* pHash);

@DllImport("msi")
HRESULT MsiGetFileSignatureInformationA(const(char)* szSignedObjectPath, uint dwFlags, 
                                        CERT_CONTEXT** ppcCertContext, char* pbHashData, uint* pcbHashData);

@DllImport("msi")
HRESULT MsiGetFileSignatureInformationW(const(wchar)* szSignedObjectPath, uint dwFlags, 
                                        CERT_CONTEXT** ppcCertContext, char* pbHashData, uint* pcbHashData);

@DllImport("msi")
uint MsiGetShortcutTargetA(const(char)* szShortcutPath, const(char)* szProductCode, const(char)* szFeatureId, 
                           const(char)* szComponentCode);

@DllImport("msi")
uint MsiGetShortcutTargetW(const(wchar)* szShortcutPath, const(wchar)* szProductCode, const(wchar)* szFeatureId, 
                           const(wchar)* szComponentCode);

@DllImport("msi")
uint MsiIsProductElevatedA(const(char)* szProduct, int* pfElevated);

@DllImport("msi")
uint MsiIsProductElevatedW(const(wchar)* szProduct, int* pfElevated);

@DllImport("msi")
uint MsiNotifySidChangeA(const(char)* pOldSid, const(char)* pNewSid);

@DllImport("msi")
uint MsiNotifySidChangeW(const(wchar)* pOldSid, const(wchar)* pNewSid);

@DllImport("msi")
uint MsiBeginTransactionA(const(char)* szName, uint dwTransactionAttributes, uint* phTransactionHandle, 
                          HANDLE* phChangeOfOwnerEvent);

@DllImport("msi")
uint MsiBeginTransactionW(const(wchar)* szName, uint dwTransactionAttributes, uint* phTransactionHandle, 
                          HANDLE* phChangeOfOwnerEvent);

@DllImport("msi")
uint MsiEndTransaction(uint dwTransactionState);

@DllImport("msi")
uint MsiJoinTransaction(uint hTransactionHandle, uint dwTransactionAttributes, HANDLE* phChangeOfOwnerEvent);

@DllImport("msi")
uint MsiDatabaseOpenViewA(uint hDatabase, const(char)* szQuery, uint* phView);

@DllImport("msi")
uint MsiDatabaseOpenViewW(uint hDatabase, const(wchar)* szQuery, uint* phView);

@DllImport("msi")
MSIDBERROR MsiViewGetErrorA(uint hView, const(char)* szColumnNameBuffer, uint* pcchBuf);

@DllImport("msi")
MSIDBERROR MsiViewGetErrorW(uint hView, const(wchar)* szColumnNameBuffer, uint* pcchBuf);

@DllImport("msi")
uint MsiViewExecute(uint hView, uint hRecord);

@DllImport("msi")
uint MsiViewFetch(uint hView, uint* phRecord);

@DllImport("msi")
uint MsiViewModify(uint hView, MSIMODIFY eModifyMode, uint hRecord);

@DllImport("msi")
uint MsiViewGetColumnInfo(uint hView, MSICOLINFO eColumnInfo, uint* phRecord);

@DllImport("msi")
uint MsiViewClose(uint hView);

@DllImport("msi")
uint MsiDatabaseGetPrimaryKeysA(uint hDatabase, const(char)* szTableName, uint* phRecord);

@DllImport("msi")
uint MsiDatabaseGetPrimaryKeysW(uint hDatabase, const(wchar)* szTableName, uint* phRecord);

@DllImport("msi")
MSICONDITION MsiDatabaseIsTablePersistentA(uint hDatabase, const(char)* szTableName);

@DllImport("msi")
MSICONDITION MsiDatabaseIsTablePersistentW(uint hDatabase, const(wchar)* szTableName);

@DllImport("msi")
uint MsiGetSummaryInformationA(uint hDatabase, const(char)* szDatabasePath, uint uiUpdateCount, 
                               uint* phSummaryInfo);

@DllImport("msi")
uint MsiGetSummaryInformationW(uint hDatabase, const(wchar)* szDatabasePath, uint uiUpdateCount, 
                               uint* phSummaryInfo);

@DllImport("msi")
uint MsiSummaryInfoGetPropertyCount(uint hSummaryInfo, uint* puiPropertyCount);

@DllImport("msi")
uint MsiSummaryInfoSetPropertyA(uint hSummaryInfo, uint uiProperty, uint uiDataType, int iValue, 
                                FILETIME* pftValue, const(char)* szValue);

@DllImport("msi")
uint MsiSummaryInfoSetPropertyW(uint hSummaryInfo, uint uiProperty, uint uiDataType, int iValue, 
                                FILETIME* pftValue, const(wchar)* szValue);

@DllImport("msi")
uint MsiSummaryInfoGetPropertyA(uint hSummaryInfo, uint uiProperty, uint* puiDataType, int* piValue, 
                                FILETIME* pftValue, const(char)* szValueBuf, uint* pcchValueBuf);

@DllImport("msi")
uint MsiSummaryInfoGetPropertyW(uint hSummaryInfo, uint uiProperty, uint* puiDataType, int* piValue, 
                                FILETIME* pftValue, const(wchar)* szValueBuf, uint* pcchValueBuf);

@DllImport("msi")
uint MsiSummaryInfoPersist(uint hSummaryInfo);

@DllImport("msi")
uint MsiOpenDatabaseA(const(char)* szDatabasePath, const(char)* szPersist, uint* phDatabase);

@DllImport("msi")
uint MsiOpenDatabaseW(const(wchar)* szDatabasePath, const(wchar)* szPersist, uint* phDatabase);

@DllImport("msi")
uint MsiDatabaseImportA(uint hDatabase, const(char)* szFolderPath, const(char)* szFileName);

@DllImport("msi")
uint MsiDatabaseImportW(uint hDatabase, const(wchar)* szFolderPath, const(wchar)* szFileName);

@DllImport("msi")
uint MsiDatabaseExportA(uint hDatabase, const(char)* szTableName, const(char)* szFolderPath, 
                        const(char)* szFileName);

@DllImport("msi")
uint MsiDatabaseExportW(uint hDatabase, const(wchar)* szTableName, const(wchar)* szFolderPath, 
                        const(wchar)* szFileName);

@DllImport("msi")
uint MsiDatabaseMergeA(uint hDatabase, uint hDatabaseMerge, const(char)* szTableName);

@DllImport("msi")
uint MsiDatabaseMergeW(uint hDatabase, uint hDatabaseMerge, const(wchar)* szTableName);

@DllImport("msi")
uint MsiDatabaseGenerateTransformA(uint hDatabase, uint hDatabaseReference, const(char)* szTransformFile, 
                                   int iReserved1, int iReserved2);

@DllImport("msi")
uint MsiDatabaseGenerateTransformW(uint hDatabase, uint hDatabaseReference, const(wchar)* szTransformFile, 
                                   int iReserved1, int iReserved2);

@DllImport("msi")
uint MsiDatabaseApplyTransformA(uint hDatabase, const(char)* szTransformFile, int iErrorConditions);

@DllImport("msi")
uint MsiDatabaseApplyTransformW(uint hDatabase, const(wchar)* szTransformFile, int iErrorConditions);

@DllImport("msi")
uint MsiCreateTransformSummaryInfoA(uint hDatabase, uint hDatabaseReference, const(char)* szTransformFile, 
                                    int iErrorConditions, int iValidation);

@DllImport("msi")
uint MsiCreateTransformSummaryInfoW(uint hDatabase, uint hDatabaseReference, const(wchar)* szTransformFile, 
                                    int iErrorConditions, int iValidation);

@DllImport("msi")
uint MsiDatabaseCommit(uint hDatabase);

@DllImport("msi")
MSIDBSTATE MsiGetDatabaseState(uint hDatabase);

@DllImport("msi")
uint MsiCreateRecord(uint cParams);

@DllImport("msi")
BOOL MsiRecordIsNull(uint hRecord, uint iField);

@DllImport("msi")
uint MsiRecordDataSize(uint hRecord, uint iField);

@DllImport("msi")
uint MsiRecordSetInteger(uint hRecord, uint iField, int iValue);

@DllImport("msi")
uint MsiRecordSetStringA(uint hRecord, uint iField, const(char)* szValue);

@DllImport("msi")
uint MsiRecordSetStringW(uint hRecord, uint iField, const(wchar)* szValue);

@DllImport("msi")
int MsiRecordGetInteger(uint hRecord, uint iField);

@DllImport("msi")
uint MsiRecordGetStringA(uint hRecord, uint iField, const(char)* szValueBuf, uint* pcchValueBuf);

@DllImport("msi")
uint MsiRecordGetStringW(uint hRecord, uint iField, const(wchar)* szValueBuf, uint* pcchValueBuf);

@DllImport("msi")
uint MsiRecordGetFieldCount(uint hRecord);

@DllImport("msi")
uint MsiRecordSetStreamA(uint hRecord, uint iField, const(char)* szFilePath);

@DllImport("msi")
uint MsiRecordSetStreamW(uint hRecord, uint iField, const(wchar)* szFilePath);

@DllImport("msi")
uint MsiRecordReadStream(uint hRecord, uint iField, char* szDataBuf, uint* pcbDataBuf);

@DllImport("msi")
uint MsiRecordClearData(uint hRecord);

@DllImport("msi")
uint MsiGetActiveDatabase(uint hInstall);

@DllImport("msi")
uint MsiSetPropertyA(uint hInstall, const(char)* szName, const(char)* szValue);

@DllImport("msi")
uint MsiSetPropertyW(uint hInstall, const(wchar)* szName, const(wchar)* szValue);

@DllImport("msi")
uint MsiGetPropertyA(uint hInstall, const(char)* szName, const(char)* szValueBuf, uint* pcchValueBuf);

@DllImport("msi")
uint MsiGetPropertyW(uint hInstall, const(wchar)* szName, const(wchar)* szValueBuf, uint* pcchValueBuf);

@DllImport("msi")
ushort MsiGetLanguage(uint hInstall);

@DllImport("msi")
BOOL MsiGetMode(uint hInstall, MSIRUNMODE eRunMode);

@DllImport("msi")
uint MsiSetMode(uint hInstall, MSIRUNMODE eRunMode, BOOL fState);

@DllImport("msi")
uint MsiFormatRecordA(uint hInstall, uint hRecord, const(char)* szResultBuf, uint* pcchResultBuf);

@DllImport("msi")
uint MsiFormatRecordW(uint hInstall, uint hRecord, const(wchar)* szResultBuf, uint* pcchResultBuf);

@DllImport("msi")
uint MsiDoActionA(uint hInstall, const(char)* szAction);

@DllImport("msi")
uint MsiDoActionW(uint hInstall, const(wchar)* szAction);

@DllImport("msi")
uint MsiSequenceA(uint hInstall, const(char)* szTable, int iSequenceMode);

@DllImport("msi")
uint MsiSequenceW(uint hInstall, const(wchar)* szTable, int iSequenceMode);

@DllImport("msi")
int MsiProcessMessage(uint hInstall, INSTALLMESSAGE eMessageType, uint hRecord);

@DllImport("msi")
MSICONDITION MsiEvaluateConditionA(uint hInstall, const(char)* szCondition);

@DllImport("msi")
MSICONDITION MsiEvaluateConditionW(uint hInstall, const(wchar)* szCondition);

@DllImport("msi")
uint MsiGetFeatureStateA(uint hInstall, const(char)* szFeature, INSTALLSTATE* piInstalled, INSTALLSTATE* piAction);

@DllImport("msi")
uint MsiGetFeatureStateW(uint hInstall, const(wchar)* szFeature, INSTALLSTATE* piInstalled, INSTALLSTATE* piAction);

@DllImport("msi")
uint MsiSetFeatureStateA(uint hInstall, const(char)* szFeature, INSTALLSTATE iState);

@DllImport("msi")
uint MsiSetFeatureStateW(uint hInstall, const(wchar)* szFeature, INSTALLSTATE iState);

@DllImport("msi")
uint MsiSetFeatureAttributesA(uint hInstall, const(char)* szFeature, uint dwAttributes);

@DllImport("msi")
uint MsiSetFeatureAttributesW(uint hInstall, const(wchar)* szFeature, uint dwAttributes);

@DllImport("msi")
uint MsiGetComponentStateA(uint hInstall, const(char)* szComponent, INSTALLSTATE* piInstalled, 
                           INSTALLSTATE* piAction);

@DllImport("msi")
uint MsiGetComponentStateW(uint hInstall, const(wchar)* szComponent, INSTALLSTATE* piInstalled, 
                           INSTALLSTATE* piAction);

@DllImport("msi")
uint MsiSetComponentStateA(uint hInstall, const(char)* szComponent, INSTALLSTATE iState);

@DllImport("msi")
uint MsiSetComponentStateW(uint hInstall, const(wchar)* szComponent, INSTALLSTATE iState);

@DllImport("msi")
uint MsiGetFeatureCostA(uint hInstall, const(char)* szFeature, MSICOSTTREE iCostTree, INSTALLSTATE iState, 
                        int* piCost);

@DllImport("msi")
uint MsiGetFeatureCostW(uint hInstall, const(wchar)* szFeature, MSICOSTTREE iCostTree, INSTALLSTATE iState, 
                        int* piCost);

@DllImport("msi")
uint MsiEnumComponentCostsA(uint hInstall, const(char)* szComponent, uint dwIndex, INSTALLSTATE iState, 
                            const(char)* szDriveBuf, uint* pcchDriveBuf, int* piCost, int* piTempCost);

@DllImport("msi")
uint MsiEnumComponentCostsW(uint hInstall, const(wchar)* szComponent, uint dwIndex, INSTALLSTATE iState, 
                            const(wchar)* szDriveBuf, uint* pcchDriveBuf, int* piCost, int* piTempCost);

@DllImport("msi")
uint MsiSetInstallLevel(uint hInstall, int iInstallLevel);

@DllImport("msi")
uint MsiGetFeatureValidStatesA(uint hInstall, const(char)* szFeature, uint* lpInstallStates);

@DllImport("msi")
uint MsiGetFeatureValidStatesW(uint hInstall, const(wchar)* szFeature, uint* lpInstallStates);

@DllImport("msi")
uint MsiGetSourcePathA(uint hInstall, const(char)* szFolder, const(char)* szPathBuf, uint* pcchPathBuf);

@DllImport("msi")
uint MsiGetSourcePathW(uint hInstall, const(wchar)* szFolder, const(wchar)* szPathBuf, uint* pcchPathBuf);

@DllImport("msi")
uint MsiGetTargetPathA(uint hInstall, const(char)* szFolder, const(char)* szPathBuf, uint* pcchPathBuf);

@DllImport("msi")
uint MsiGetTargetPathW(uint hInstall, const(wchar)* szFolder, const(wchar)* szPathBuf, uint* pcchPathBuf);

@DllImport("msi")
uint MsiSetTargetPathA(uint hInstall, const(char)* szFolder, const(char)* szFolderPath);

@DllImport("msi")
uint MsiSetTargetPathW(uint hInstall, const(wchar)* szFolder, const(wchar)* szFolderPath);

@DllImport("msi")
uint MsiVerifyDiskSpace(uint hInstall);

@DllImport("msi")
uint MsiEnableUIPreview(uint hDatabase, uint* phPreview);

@DllImport("msi")
uint MsiPreviewDialogA(uint hPreview, const(char)* szDialogName);

@DllImport("msi")
uint MsiPreviewDialogW(uint hPreview, const(wchar)* szDialogName);

@DllImport("msi")
uint MsiPreviewBillboardA(uint hPreview, const(char)* szControlName, const(char)* szBillboard);

@DllImport("msi")
uint MsiPreviewBillboardW(uint hPreview, const(wchar)* szControlName, const(wchar)* szBillboard);

@DllImport("msi")
uint MsiGetLastErrorRecord();

@DllImport("sfc")
BOOL SfcGetNextProtectedFile(HANDLE RpcHandle, PROTECTED_FILE_DATA* ProtFileData);

@DllImport("sfc")
BOOL SfcIsFileProtected(HANDLE RpcHandle, const(wchar)* ProtFileName);

@DllImport("sfc")
BOOL SfcIsKeyProtected(HKEY KeyHandle, const(wchar)* SubKeyName, uint KeySam);

@DllImport("sfc")
BOOL SfpVerifyFile(const(char)* pszFileName, const(char)* pszError, uint dwErrSize);

@DllImport("KERNEL32")
HANDLE CreateActCtxA(ACTCTXA* pActCtx);

@DllImport("KERNEL32")
HANDLE CreateActCtxW(ACTCTXW* pActCtx);

@DllImport("KERNEL32")
void AddRefActCtx(HANDLE hActCtx);

@DllImport("KERNEL32")
void ReleaseActCtx(HANDLE hActCtx);

@DllImport("KERNEL32")
BOOL ZombifyActCtx(HANDLE hActCtx);

@DllImport("KERNEL32")
BOOL ActivateActCtx(HANDLE hActCtx, size_t* lpCookie);

@DllImport("KERNEL32")
BOOL DeactivateActCtx(uint dwFlags, size_t ulCookie);

@DllImport("KERNEL32")
BOOL GetCurrentActCtx(HANDLE* lphActCtx);

@DllImport("KERNEL32")
BOOL FindActCtxSectionStringA(uint dwFlags, const(GUID)* lpExtensionGuid, uint ulSectionId, 
                              const(char)* lpStringToFind, ACTCTX_SECTION_KEYED_DATA* ReturnedData);

@DllImport("KERNEL32")
BOOL FindActCtxSectionStringW(uint dwFlags, const(GUID)* lpExtensionGuid, uint ulSectionId, 
                              const(wchar)* lpStringToFind, ACTCTX_SECTION_KEYED_DATA* ReturnedData);

@DllImport("KERNEL32")
BOOL FindActCtxSectionGuid(uint dwFlags, const(GUID)* lpExtensionGuid, uint ulSectionId, const(GUID)* lpGuidToFind, 
                           ACTCTX_SECTION_KEYED_DATA* ReturnedData);

@DllImport("KERNEL32")
BOOL QueryActCtxW(uint dwFlags, HANDLE hActCtx, void* pvSubInstance, uint ulInfoClass, char* pvBuffer, 
                  size_t cbBuffer, size_t* pcbWrittenOrRequired);

@DllImport("KERNEL32")
BOOL QueryActCtxSettingsW(uint dwFlags, HANDLE hActCtx, const(wchar)* settingsNameSpace, const(wchar)* settingName, 
                          const(wchar)* pvBuffer, size_t dwBuffer, size_t* pdwWrittenOrRequired);

@DllImport("SETUPAPI")
BOOL SetupGetInfInformationA(void* InfSpec, uint SearchControl, char* ReturnBuffer, uint ReturnBufferSize, 
                             uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupGetInfInformationW(void* InfSpec, uint SearchControl, char* ReturnBuffer, uint ReturnBufferSize, 
                             uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupQueryInfFileInformationA(SP_INF_INFORMATION* InfInformation, uint InfIndex, const(char)* ReturnBuffer, 
                                   uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupQueryInfFileInformationW(SP_INF_INFORMATION* InfInformation, uint InfIndex, const(wchar)* ReturnBuffer, 
                                   uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupQueryInfOriginalFileInformationA(SP_INF_INFORMATION* InfInformation, uint InfIndex, 
                                           SP_ALTPLATFORM_INFO_V2* AlternatePlatformInfo, 
                                           SP_ORIGINAL_FILE_INFO_A* OriginalFileInfo);

@DllImport("SETUPAPI")
BOOL SetupQueryInfOriginalFileInformationW(SP_INF_INFORMATION* InfInformation, uint InfIndex, 
                                           SP_ALTPLATFORM_INFO_V2* AlternatePlatformInfo, 
                                           SP_ORIGINAL_FILE_INFO_W* OriginalFileInfo);

@DllImport("SETUPAPI")
BOOL SetupQueryInfVersionInformationA(SP_INF_INFORMATION* InfInformation, uint InfIndex, const(char)* Key, 
                                      const(char)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupQueryInfVersionInformationW(SP_INF_INFORMATION* InfInformation, uint InfIndex, const(wchar)* Key, 
                                      const(wchar)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupGetInfFileListA(const(char)* DirectoryPath, uint InfStyle, const(char)* ReturnBuffer, 
                          uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupGetInfFileListW(const(wchar)* DirectoryPath, uint InfStyle, const(wchar)* ReturnBuffer, 
                          uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI")
void* SetupOpenInfFileW(const(wchar)* FileName, const(wchar)* InfClass, uint InfStyle, uint* ErrorLine);

@DllImport("SETUPAPI")
void* SetupOpenInfFileA(const(char)* FileName, const(char)* InfClass, uint InfStyle, uint* ErrorLine);

@DllImport("SETUPAPI")
void* SetupOpenMasterInf();

@DllImport("SETUPAPI")
BOOL SetupOpenAppendInfFileW(const(wchar)* FileName, void* InfHandle, uint* ErrorLine);

@DllImport("SETUPAPI")
BOOL SetupOpenAppendInfFileA(const(char)* FileName, void* InfHandle, uint* ErrorLine);

@DllImport("SETUPAPI")
void SetupCloseInfFile(void* InfHandle);

@DllImport("SETUPAPI")
BOOL SetupFindFirstLineA(void* InfHandle, const(char)* Section, const(char)* Key, INFCONTEXT* Context);

@DllImport("SETUPAPI")
BOOL SetupFindFirstLineW(void* InfHandle, const(wchar)* Section, const(wchar)* Key, INFCONTEXT* Context);

@DllImport("SETUPAPI")
BOOL SetupFindNextLine(INFCONTEXT* ContextIn, INFCONTEXT* ContextOut);

@DllImport("SETUPAPI")
BOOL SetupFindNextMatchLineA(INFCONTEXT* ContextIn, const(char)* Key, INFCONTEXT* ContextOut);

@DllImport("SETUPAPI")
BOOL SetupFindNextMatchLineW(INFCONTEXT* ContextIn, const(wchar)* Key, INFCONTEXT* ContextOut);

@DllImport("SETUPAPI")
BOOL SetupGetLineByIndexA(void* InfHandle, const(char)* Section, uint Index, INFCONTEXT* Context);

@DllImport("SETUPAPI")
BOOL SetupGetLineByIndexW(void* InfHandle, const(wchar)* Section, uint Index, INFCONTEXT* Context);

@DllImport("SETUPAPI")
int SetupGetLineCountA(void* InfHandle, const(char)* Section);

@DllImport("SETUPAPI")
int SetupGetLineCountW(void* InfHandle, const(wchar)* Section);

@DllImport("SETUPAPI")
BOOL SetupGetLineTextA(INFCONTEXT* Context, void* InfHandle, const(char)* Section, const(char)* Key, 
                       const(char)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupGetLineTextW(INFCONTEXT* Context, void* InfHandle, const(wchar)* Section, const(wchar)* Key, 
                       const(wchar)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI")
uint SetupGetFieldCount(INFCONTEXT* Context);

@DllImport("SETUPAPI")
BOOL SetupGetStringFieldA(INFCONTEXT* Context, uint FieldIndex, const(char)* ReturnBuffer, uint ReturnBufferSize, 
                          uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupGetStringFieldW(INFCONTEXT* Context, uint FieldIndex, const(wchar)* ReturnBuffer, uint ReturnBufferSize, 
                          uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupGetIntField(INFCONTEXT* Context, uint FieldIndex, int* IntegerValue);

@DllImport("SETUPAPI")
BOOL SetupGetMultiSzFieldA(INFCONTEXT* Context, uint FieldIndex, const(char)* ReturnBuffer, uint ReturnBufferSize, 
                           uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupGetMultiSzFieldW(INFCONTEXT* Context, uint FieldIndex, const(wchar)* ReturnBuffer, uint ReturnBufferSize, 
                           uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupGetBinaryField(INFCONTEXT* Context, uint FieldIndex, char* ReturnBuffer, uint ReturnBufferSize, 
                         uint* RequiredSize);

@DllImport("SETUPAPI")
uint SetupGetFileCompressionInfoA(const(char)* SourceFileName, byte** ActualSourceFileName, uint* SourceFileSize, 
                                  uint* TargetFileSize, uint* CompressionType);

@DllImport("SETUPAPI")
uint SetupGetFileCompressionInfoW(const(wchar)* SourceFileName, ushort** ActualSourceFileName, 
                                  uint* SourceFileSize, uint* TargetFileSize, uint* CompressionType);

@DllImport("SETUPAPI")
BOOL SetupGetFileCompressionInfoExA(const(char)* SourceFileName, const(char)* ActualSourceFileNameBuffer, 
                                    uint ActualSourceFileNameBufferLen, uint* RequiredBufferLen, 
                                    uint* SourceFileSize, uint* TargetFileSize, uint* CompressionType);

@DllImport("SETUPAPI")
BOOL SetupGetFileCompressionInfoExW(const(wchar)* SourceFileName, const(wchar)* ActualSourceFileNameBuffer, 
                                    uint ActualSourceFileNameBufferLen, uint* RequiredBufferLen, 
                                    uint* SourceFileSize, uint* TargetFileSize, uint* CompressionType);

@DllImport("SETUPAPI")
uint SetupDecompressOrCopyFileA(const(char)* SourceFileName, const(char)* TargetFileName, uint* CompressionType);

@DllImport("SETUPAPI")
uint SetupDecompressOrCopyFileW(const(wchar)* SourceFileName, const(wchar)* TargetFileName, uint* CompressionType);

@DllImport("SETUPAPI")
BOOL SetupGetSourceFileLocationA(void* InfHandle, INFCONTEXT* InfContext, const(char)* FileName, uint* SourceId, 
                                 const(char)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupGetSourceFileLocationW(void* InfHandle, INFCONTEXT* InfContext, const(wchar)* FileName, uint* SourceId, 
                                 const(wchar)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupGetSourceFileSizeA(void* InfHandle, INFCONTEXT* InfContext, const(char)* FileName, const(char)* Section, 
                             uint* FileSize, uint RoundingFactor);

@DllImport("SETUPAPI")
BOOL SetupGetSourceFileSizeW(void* InfHandle, INFCONTEXT* InfContext, const(wchar)* FileName, 
                             const(wchar)* Section, uint* FileSize, uint RoundingFactor);

@DllImport("SETUPAPI")
BOOL SetupGetTargetPathA(void* InfHandle, INFCONTEXT* InfContext, const(char)* Section, const(char)* ReturnBuffer, 
                         uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupGetTargetPathW(void* InfHandle, INFCONTEXT* InfContext, const(wchar)* Section, 
                         const(wchar)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupSetSourceListA(uint Flags, char* SourceList, uint SourceCount);

@DllImport("SETUPAPI")
BOOL SetupSetSourceListW(uint Flags, char* SourceList, uint SourceCount);

@DllImport("SETUPAPI")
BOOL SetupCancelTemporarySourceList();

@DllImport("SETUPAPI")
BOOL SetupAddToSourceListA(uint Flags, const(char)* Source);

@DllImport("SETUPAPI")
BOOL SetupAddToSourceListW(uint Flags, const(wchar)* Source);

@DllImport("SETUPAPI")
BOOL SetupRemoveFromSourceListA(uint Flags, const(char)* Source);

@DllImport("SETUPAPI")
BOOL SetupRemoveFromSourceListW(uint Flags, const(wchar)* Source);

@DllImport("SETUPAPI")
BOOL SetupQuerySourceListA(uint Flags, byte*** List, uint* Count);

@DllImport("SETUPAPI")
BOOL SetupQuerySourceListW(uint Flags, ushort*** List, uint* Count);

@DllImport("SETUPAPI")
BOOL SetupFreeSourceListA(char* List, uint Count);

@DllImport("SETUPAPI")
BOOL SetupFreeSourceListW(char* List, uint Count);

@DllImport("SETUPAPI")
uint SetupPromptForDiskA(HWND hwndParent, const(char)* DialogTitle, const(char)* DiskName, 
                         const(char)* PathToSource, const(char)* FileSought, const(char)* TagFile, 
                         uint DiskPromptStyle, const(char)* PathBuffer, uint PathBufferSize, uint* PathRequiredSize);

@DllImport("SETUPAPI")
uint SetupPromptForDiskW(HWND hwndParent, const(wchar)* DialogTitle, const(wchar)* DiskName, 
                         const(wchar)* PathToSource, const(wchar)* FileSought, const(wchar)* TagFile, 
                         uint DiskPromptStyle, const(wchar)* PathBuffer, uint PathBufferSize, uint* PathRequiredSize);

@DllImport("SETUPAPI")
uint SetupCopyErrorA(HWND hwndParent, const(char)* DialogTitle, const(char)* DiskName, const(char)* PathToSource, 
                     const(char)* SourceFile, const(char)* TargetPathFile, uint Win32ErrorCode, uint Style, 
                     const(char)* PathBuffer, uint PathBufferSize, uint* PathRequiredSize);

@DllImport("SETUPAPI")
uint SetupCopyErrorW(HWND hwndParent, const(wchar)* DialogTitle, const(wchar)* DiskName, 
                     const(wchar)* PathToSource, const(wchar)* SourceFile, const(wchar)* TargetPathFile, 
                     uint Win32ErrorCode, uint Style, const(wchar)* PathBuffer, uint PathBufferSize, 
                     uint* PathRequiredSize);

@DllImport("SETUPAPI")
uint SetupRenameErrorA(HWND hwndParent, const(char)* DialogTitle, const(char)* SourceFile, const(char)* TargetFile, 
                       uint Win32ErrorCode, uint Style);

@DllImport("SETUPAPI")
uint SetupRenameErrorW(HWND hwndParent, const(wchar)* DialogTitle, const(wchar)* SourceFile, 
                       const(wchar)* TargetFile, uint Win32ErrorCode, uint Style);

@DllImport("SETUPAPI")
uint SetupDeleteErrorA(HWND hwndParent, const(char)* DialogTitle, const(char)* File, uint Win32ErrorCode, 
                       uint Style);

@DllImport("SETUPAPI")
uint SetupDeleteErrorW(HWND hwndParent, const(wchar)* DialogTitle, const(wchar)* File, uint Win32ErrorCode, 
                       uint Style);

@DllImport("SETUPAPI")
uint SetupBackupErrorA(HWND hwndParent, const(char)* DialogTitle, const(char)* SourceFile, const(char)* TargetFile, 
                       uint Win32ErrorCode, uint Style);

@DllImport("SETUPAPI")
uint SetupBackupErrorW(HWND hwndParent, const(wchar)* DialogTitle, const(wchar)* SourceFile, 
                       const(wchar)* TargetFile, uint Win32ErrorCode, uint Style);

@DllImport("SETUPAPI")
BOOL SetupSetDirectoryIdA(void* InfHandle, uint Id, const(char)* Directory);

@DllImport("SETUPAPI")
BOOL SetupSetDirectoryIdW(void* InfHandle, uint Id, const(wchar)* Directory);

@DllImport("SETUPAPI")
BOOL SetupSetDirectoryIdExA(void* InfHandle, uint Id, const(char)* Directory, uint Flags, uint Reserved1, 
                            void* Reserved2);

@DllImport("SETUPAPI")
BOOL SetupSetDirectoryIdExW(void* InfHandle, uint Id, const(wchar)* Directory, uint Flags, uint Reserved1, 
                            void* Reserved2);

@DllImport("SETUPAPI")
BOOL SetupGetSourceInfoA(void* InfHandle, uint SourceId, uint InfoDesired, const(char)* ReturnBuffer, 
                         uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupGetSourceInfoW(void* InfHandle, uint SourceId, uint InfoDesired, const(wchar)* ReturnBuffer, 
                         uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupInstallFileA(void* InfHandle, INFCONTEXT* InfContext, const(char)* SourceFile, 
                       const(char)* SourcePathRoot, const(char)* DestinationName, uint CopyStyle, 
                       PSP_FILE_CALLBACK_A CopyMsgHandler, void* Context);

@DllImport("SETUPAPI")
BOOL SetupInstallFileW(void* InfHandle, INFCONTEXT* InfContext, const(wchar)* SourceFile, 
                       const(wchar)* SourcePathRoot, const(wchar)* DestinationName, uint CopyStyle, 
                       PSP_FILE_CALLBACK_W CopyMsgHandler, void* Context);

@DllImport("SETUPAPI")
BOOL SetupInstallFileExA(void* InfHandle, INFCONTEXT* InfContext, const(char)* SourceFile, 
                         const(char)* SourcePathRoot, const(char)* DestinationName, uint CopyStyle, 
                         PSP_FILE_CALLBACK_A CopyMsgHandler, void* Context, int* FileWasInUse);

@DllImport("SETUPAPI")
BOOL SetupInstallFileExW(void* InfHandle, INFCONTEXT* InfContext, const(wchar)* SourceFile, 
                         const(wchar)* SourcePathRoot, const(wchar)* DestinationName, uint CopyStyle, 
                         PSP_FILE_CALLBACK_W CopyMsgHandler, void* Context, int* FileWasInUse);

@DllImport("SETUPAPI")
void* SetupOpenFileQueue();

@DllImport("SETUPAPI")
BOOL SetupCloseFileQueue(void* QueueHandle);

@DllImport("SETUPAPI")
BOOL SetupSetFileQueueAlternatePlatformA(void* QueueHandle, SP_ALTPLATFORM_INFO_V2* AlternatePlatformInfo, 
                                         const(char)* AlternateDefaultCatalogFile);

@DllImport("SETUPAPI")
BOOL SetupSetFileQueueAlternatePlatformW(void* QueueHandle, SP_ALTPLATFORM_INFO_V2* AlternatePlatformInfo, 
                                         const(wchar)* AlternateDefaultCatalogFile);

@DllImport("SETUPAPI")
BOOL SetupSetPlatformPathOverrideA(const(char)* Override);

@DllImport("SETUPAPI")
BOOL SetupSetPlatformPathOverrideW(const(wchar)* Override);

@DllImport("SETUPAPI")
BOOL SetupQueueCopyA(void* QueueHandle, const(char)* SourceRootPath, const(char)* SourcePath, 
                     const(char)* SourceFilename, const(char)* SourceDescription, const(char)* SourceTagfile, 
                     const(char)* TargetDirectory, const(char)* TargetFilename, uint CopyStyle);

@DllImport("SETUPAPI")
BOOL SetupQueueCopyW(void* QueueHandle, const(wchar)* SourceRootPath, const(wchar)* SourcePath, 
                     const(wchar)* SourceFilename, const(wchar)* SourceDescription, const(wchar)* SourceTagfile, 
                     const(wchar)* TargetDirectory, const(wchar)* TargetFilename, uint CopyStyle);

@DllImport("SETUPAPI")
BOOL SetupQueueCopyIndirectA(SP_FILE_COPY_PARAMS_A* CopyParams);

@DllImport("SETUPAPI")
BOOL SetupQueueCopyIndirectW(SP_FILE_COPY_PARAMS_W* CopyParams);

@DllImport("SETUPAPI")
BOOL SetupQueueDefaultCopyA(void* QueueHandle, void* InfHandle, const(char)* SourceRootPath, 
                            const(char)* SourceFilename, const(char)* TargetFilename, uint CopyStyle);

@DllImport("SETUPAPI")
BOOL SetupQueueDefaultCopyW(void* QueueHandle, void* InfHandle, const(wchar)* SourceRootPath, 
                            const(wchar)* SourceFilename, const(wchar)* TargetFilename, uint CopyStyle);

@DllImport("SETUPAPI")
BOOL SetupQueueCopySectionA(void* QueueHandle, const(char)* SourceRootPath, void* InfHandle, void* ListInfHandle, 
                            const(char)* Section, uint CopyStyle);

@DllImport("SETUPAPI")
BOOL SetupQueueCopySectionW(void* QueueHandle, const(wchar)* SourceRootPath, void* InfHandle, void* ListInfHandle, 
                            const(wchar)* Section, uint CopyStyle);

@DllImport("SETUPAPI")
BOOL SetupQueueDeleteA(void* QueueHandle, const(char)* PathPart1, const(char)* PathPart2);

@DllImport("SETUPAPI")
BOOL SetupQueueDeleteW(void* QueueHandle, const(wchar)* PathPart1, const(wchar)* PathPart2);

@DllImport("SETUPAPI")
BOOL SetupQueueDeleteSectionA(void* QueueHandle, void* InfHandle, void* ListInfHandle, const(char)* Section);

@DllImport("SETUPAPI")
BOOL SetupQueueDeleteSectionW(void* QueueHandle, void* InfHandle, void* ListInfHandle, const(wchar)* Section);

@DllImport("SETUPAPI")
BOOL SetupQueueRenameA(void* QueueHandle, const(char)* SourcePath, const(char)* SourceFilename, 
                       const(char)* TargetPath, const(char)* TargetFilename);

@DllImport("SETUPAPI")
BOOL SetupQueueRenameW(void* QueueHandle, const(wchar)* SourcePath, const(wchar)* SourceFilename, 
                       const(wchar)* TargetPath, const(wchar)* TargetFilename);

@DllImport("SETUPAPI")
BOOL SetupQueueRenameSectionA(void* QueueHandle, void* InfHandle, void* ListInfHandle, const(char)* Section);

@DllImport("SETUPAPI")
BOOL SetupQueueRenameSectionW(void* QueueHandle, void* InfHandle, void* ListInfHandle, const(wchar)* Section);

@DllImport("SETUPAPI")
BOOL SetupCommitFileQueueA(HWND Owner, void* QueueHandle, PSP_FILE_CALLBACK_A MsgHandler, void* Context);

@DllImport("SETUPAPI")
BOOL SetupCommitFileQueueW(HWND Owner, void* QueueHandle, PSP_FILE_CALLBACK_W MsgHandler, void* Context);

@DllImport("SETUPAPI")
BOOL SetupScanFileQueueA(void* FileQueue, uint Flags, HWND Window, PSP_FILE_CALLBACK_A CallbackRoutine, 
                         void* CallbackContext, uint* Result);

@DllImport("SETUPAPI")
BOOL SetupScanFileQueueW(void* FileQueue, uint Flags, HWND Window, PSP_FILE_CALLBACK_W CallbackRoutine, 
                         void* CallbackContext, uint* Result);

@DllImport("SETUPAPI")
BOOL SetupGetFileQueueCount(void* FileQueue, uint SubQueueFileOp, uint* NumOperations);

@DllImport("SETUPAPI")
BOOL SetupGetFileQueueFlags(void* FileQueue, uint* Flags);

@DllImport("SETUPAPI")
BOOL SetupSetFileQueueFlags(void* FileQueue, uint FlagMask, uint Flags);

@DllImport("SETUPAPI")
BOOL SetupCopyOEMInfA(const(char)* SourceInfFileName, const(char)* OEMSourceMediaLocation, uint OEMSourceMediaType, 
                      uint CopyStyle, const(char)* DestinationInfFileName, uint DestinationInfFileNameSize, 
                      uint* RequiredSize, byte** DestinationInfFileNameComponent);

@DllImport("SETUPAPI")
BOOL SetupCopyOEMInfW(const(wchar)* SourceInfFileName, const(wchar)* OEMSourceMediaLocation, 
                      uint OEMSourceMediaType, uint CopyStyle, const(wchar)* DestinationInfFileName, 
                      uint DestinationInfFileNameSize, uint* RequiredSize, ushort** DestinationInfFileNameComponent);

@DllImport("SETUPAPI")
BOOL SetupUninstallOEMInfA(const(char)* InfFileName, uint Flags, void* Reserved);

@DllImport("SETUPAPI")
BOOL SetupUninstallOEMInfW(const(wchar)* InfFileName, uint Flags, void* Reserved);

@DllImport("SETUPAPI")
BOOL SetupUninstallNewlyCopiedInfs(void* FileQueue, uint Flags, void* Reserved);

@DllImport("SETUPAPI")
void* SetupCreateDiskSpaceListA(void* Reserved1, uint Reserved2, uint Flags);

@DllImport("SETUPAPI")
void* SetupCreateDiskSpaceListW(void* Reserved1, uint Reserved2, uint Flags);

@DllImport("SETUPAPI")
void* SetupDuplicateDiskSpaceListA(void* DiskSpace, void* Reserved1, uint Reserved2, uint Flags);

@DllImport("SETUPAPI")
void* SetupDuplicateDiskSpaceListW(void* DiskSpace, void* Reserved1, uint Reserved2, uint Flags);

@DllImport("SETUPAPI")
BOOL SetupDestroyDiskSpaceList(void* DiskSpace);

@DllImport("SETUPAPI")
BOOL SetupQueryDrivesInDiskSpaceListA(void* DiskSpace, const(char)* ReturnBuffer, uint ReturnBufferSize, 
                                      uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupQueryDrivesInDiskSpaceListW(void* DiskSpace, const(wchar)* ReturnBuffer, uint ReturnBufferSize, 
                                      uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupQuerySpaceRequiredOnDriveA(void* DiskSpace, const(char)* DriveSpec, long* SpaceRequired, void* Reserved1, 
                                     uint Reserved2);

@DllImport("SETUPAPI")
BOOL SetupQuerySpaceRequiredOnDriveW(void* DiskSpace, const(wchar)* DriveSpec, long* SpaceRequired, 
                                     void* Reserved1, uint Reserved2);

@DllImport("SETUPAPI")
BOOL SetupAdjustDiskSpaceListA(void* DiskSpace, const(char)* DriveRoot, long Amount, void* Reserved1, 
                               uint Reserved2);

@DllImport("SETUPAPI")
BOOL SetupAdjustDiskSpaceListW(void* DiskSpace, const(wchar)* DriveRoot, long Amount, void* Reserved1, 
                               uint Reserved2);

@DllImport("SETUPAPI")
BOOL SetupAddToDiskSpaceListA(void* DiskSpace, const(char)* TargetFilespec, long FileSize, uint Operation, 
                              void* Reserved1, uint Reserved2);

@DllImport("SETUPAPI")
BOOL SetupAddToDiskSpaceListW(void* DiskSpace, const(wchar)* TargetFilespec, long FileSize, uint Operation, 
                              void* Reserved1, uint Reserved2);

@DllImport("SETUPAPI")
BOOL SetupAddSectionToDiskSpaceListA(void* DiskSpace, void* InfHandle, void* ListInfHandle, 
                                     const(char)* SectionName, uint Operation, void* Reserved1, uint Reserved2);

@DllImport("SETUPAPI")
BOOL SetupAddSectionToDiskSpaceListW(void* DiskSpace, void* InfHandle, void* ListInfHandle, 
                                     const(wchar)* SectionName, uint Operation, void* Reserved1, uint Reserved2);

@DllImport("SETUPAPI")
BOOL SetupAddInstallSectionToDiskSpaceListA(void* DiskSpace, void* InfHandle, void* LayoutInfHandle, 
                                            const(char)* SectionName, void* Reserved1, uint Reserved2);

@DllImport("SETUPAPI")
BOOL SetupAddInstallSectionToDiskSpaceListW(void* DiskSpace, void* InfHandle, void* LayoutInfHandle, 
                                            const(wchar)* SectionName, void* Reserved1, uint Reserved2);

@DllImport("SETUPAPI")
BOOL SetupRemoveFromDiskSpaceListA(void* DiskSpace, const(char)* TargetFilespec, uint Operation, void* Reserved1, 
                                   uint Reserved2);

@DllImport("SETUPAPI")
BOOL SetupRemoveFromDiskSpaceListW(void* DiskSpace, const(wchar)* TargetFilespec, uint Operation, void* Reserved1, 
                                   uint Reserved2);

@DllImport("SETUPAPI")
BOOL SetupRemoveSectionFromDiskSpaceListA(void* DiskSpace, void* InfHandle, void* ListInfHandle, 
                                          const(char)* SectionName, uint Operation, void* Reserved1, uint Reserved2);

@DllImport("SETUPAPI")
BOOL SetupRemoveSectionFromDiskSpaceListW(void* DiskSpace, void* InfHandle, void* ListInfHandle, 
                                          const(wchar)* SectionName, uint Operation, void* Reserved1, uint Reserved2);

@DllImport("SETUPAPI")
BOOL SetupRemoveInstallSectionFromDiskSpaceListA(void* DiskSpace, void* InfHandle, void* LayoutInfHandle, 
                                                 const(char)* SectionName, void* Reserved1, uint Reserved2);

@DllImport("SETUPAPI")
BOOL SetupRemoveInstallSectionFromDiskSpaceListW(void* DiskSpace, void* InfHandle, void* LayoutInfHandle, 
                                                 const(wchar)* SectionName, void* Reserved1, uint Reserved2);

@DllImport("SETUPAPI")
BOOL SetupIterateCabinetA(const(char)* CabinetFile, uint Reserved, PSP_FILE_CALLBACK_A MsgHandler, void* Context);

@DllImport("SETUPAPI")
BOOL SetupIterateCabinetW(const(wchar)* CabinetFile, uint Reserved, PSP_FILE_CALLBACK_W MsgHandler, void* Context);

@DllImport("SETUPAPI")
int SetupPromptReboot(void* FileQueue, HWND Owner, BOOL ScanOnly);

@DllImport("SETUPAPI")
void* SetupInitDefaultQueueCallback(HWND OwnerWindow);

@DllImport("SETUPAPI")
void* SetupInitDefaultQueueCallbackEx(HWND OwnerWindow, HWND AlternateProgressWindow, uint ProgressMessage, 
                                      uint Reserved1, void* Reserved2);

@DllImport("SETUPAPI")
void SetupTermDefaultQueueCallback(void* Context);

@DllImport("SETUPAPI")
uint SetupDefaultQueueCallbackA(void* Context, uint Notification, size_t Param1, size_t Param2);

@DllImport("SETUPAPI")
uint SetupDefaultQueueCallbackW(void* Context, uint Notification, size_t Param1, size_t Param2);

@DllImport("SETUPAPI")
BOOL SetupInstallFromInfSectionA(HWND Owner, void* InfHandle, const(char)* SectionName, uint Flags, 
                                 HKEY RelativeKeyRoot, const(char)* SourceRootPath, uint CopyFlags, 
                                 PSP_FILE_CALLBACK_A MsgHandler, void* Context, void* DeviceInfoSet, 
                                 SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI")
BOOL SetupInstallFromInfSectionW(HWND Owner, void* InfHandle, const(wchar)* SectionName, uint Flags, 
                                 HKEY RelativeKeyRoot, const(wchar)* SourceRootPath, uint CopyFlags, 
                                 PSP_FILE_CALLBACK_W MsgHandler, void* Context, void* DeviceInfoSet, 
                                 SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI")
BOOL SetupInstallFilesFromInfSectionA(void* InfHandle, void* LayoutInfHandle, void* FileQueue, 
                                      const(char)* SectionName, const(char)* SourceRootPath, uint CopyFlags);

@DllImport("SETUPAPI")
BOOL SetupInstallFilesFromInfSectionW(void* InfHandle, void* LayoutInfHandle, void* FileQueue, 
                                      const(wchar)* SectionName, const(wchar)* SourceRootPath, uint CopyFlags);

@DllImport("SETUPAPI")
BOOL SetupInstallServicesFromInfSectionA(void* InfHandle, const(char)* SectionName, uint Flags);

@DllImport("SETUPAPI")
BOOL SetupInstallServicesFromInfSectionW(void* InfHandle, const(wchar)* SectionName, uint Flags);

@DllImport("SETUPAPI")
BOOL SetupInstallServicesFromInfSectionExA(void* InfHandle, const(char)* SectionName, uint Flags, 
                                           void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, void* Reserved1, 
                                           void* Reserved2);

@DllImport("SETUPAPI")
BOOL SetupInstallServicesFromInfSectionExW(void* InfHandle, const(wchar)* SectionName, uint Flags, 
                                           void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, void* Reserved1, 
                                           void* Reserved2);

@DllImport("SETUPAPI")
void InstallHinfSectionA(HWND Window, HINSTANCE ModuleHandle, const(char)* CommandLine, int ShowCommand);

@DllImport("SETUPAPI")
void InstallHinfSectionW(HWND Window, HINSTANCE ModuleHandle, const(wchar)* CommandLine, int ShowCommand);

@DllImport("SETUPAPI")
void* SetupInitializeFileLogA(const(char)* LogFileName, uint Flags);

@DllImport("SETUPAPI")
void* SetupInitializeFileLogW(const(wchar)* LogFileName, uint Flags);

@DllImport("SETUPAPI")
BOOL SetupTerminateFileLog(void* FileLogHandle);

@DllImport("SETUPAPI")
BOOL SetupLogFileA(void* FileLogHandle, const(char)* LogSectionName, const(char)* SourceFilename, 
                   const(char)* TargetFilename, uint Checksum, const(char)* DiskTagfile, 
                   const(char)* DiskDescription, const(char)* OtherInfo, uint Flags);

@DllImport("SETUPAPI")
BOOL SetupLogFileW(void* FileLogHandle, const(wchar)* LogSectionName, const(wchar)* SourceFilename, 
                   const(wchar)* TargetFilename, uint Checksum, const(wchar)* DiskTagfile, 
                   const(wchar)* DiskDescription, const(wchar)* OtherInfo, uint Flags);

@DllImport("SETUPAPI")
BOOL SetupRemoveFileLogEntryA(void* FileLogHandle, const(char)* LogSectionName, const(char)* TargetFilename);

@DllImport("SETUPAPI")
BOOL SetupRemoveFileLogEntryW(void* FileLogHandle, const(wchar)* LogSectionName, const(wchar)* TargetFilename);

@DllImport("SETUPAPI")
BOOL SetupQueryFileLogA(void* FileLogHandle, const(char)* LogSectionName, const(char)* TargetFilename, 
                        SetupFileLogInfo DesiredInfo, const(char)* DataOut, uint ReturnBufferSize, 
                        uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupQueryFileLogW(void* FileLogHandle, const(wchar)* LogSectionName, const(wchar)* TargetFilename, 
                        SetupFileLogInfo DesiredInfo, const(wchar)* DataOut, uint ReturnBufferSize, 
                        uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupOpenLog(BOOL Erase);

@DllImport("SETUPAPI")
BOOL SetupLogErrorA(const(char)* MessageString, uint Severity);

@DllImport("SETUPAPI")
BOOL SetupLogErrorW(const(wchar)* MessageString, uint Severity);

@DllImport("SETUPAPI")
void SetupCloseLog();

@DllImport("SETUPAPI")
void* SetupDiGetClassDevsA(const(GUID)* ClassGuid, const(char)* Enumerator, HWND hwndParent, uint Flags);

@DllImport("SETUPAPI")
BOOL SetupEnumInfSectionsA(void* InfHandle, uint Index, const(char)* Buffer, uint Size, uint* SizeNeeded);

@DllImport("SETUPAPI")
BOOL SetupEnumInfSectionsW(void* InfHandle, uint Index, const(wchar)* Buffer, uint Size, uint* SizeNeeded);

@DllImport("SETUPAPI")
BOOL SetupVerifyInfFileA(const(char)* InfName, SP_ALTPLATFORM_INFO_V2* AltPlatformInfo, 
                         SP_INF_SIGNER_INFO_V2_A* InfSignerInfo);

@DllImport("SETUPAPI")
BOOL SetupVerifyInfFileW(const(wchar)* InfName, SP_ALTPLATFORM_INFO_V2* AltPlatformInfo, 
                         SP_INF_SIGNER_INFO_V2_W* InfSignerInfo);

@DllImport("SETUPAPI")
BOOL SetupConfigureWmiFromInfSectionA(void* InfHandle, const(char)* SectionName, uint Flags);

@DllImport("SETUPAPI")
BOOL SetupConfigureWmiFromInfSectionW(void* InfHandle, const(wchar)* SectionName, uint Flags);


// Interfaces

@GUID("0ADDA830-2C26-11D2-AD65-00A0C9AF11A6")
struct MsmMerge;

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

@GUID("0ADDA826-2C26-11D2-AD65-00A0C9AF11A6")
interface IEnumMsmString : IUnknown
{
    HRESULT Next(uint cFetch, BSTR* rgbstrStrings, uint* pcFetched);
    HRESULT Skip(uint cSkip);
    HRESULT Reset();
    HRESULT Clone(IEnumMsmString* pemsmStrings);
}

@GUID("0ADDA827-2C26-11D2-AD65-00A0C9AF11A6")
interface IMsmStrings : IDispatch
{
    HRESULT get_Item(int Item, BSTR* Return);
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* NewEnum);
}

@GUID("0ADDA828-2C26-11D2-AD65-00A0C9AF11A6")
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

@GUID("0ADDA829-2C26-11D2-AD65-00A0C9AF11A6")
interface IEnumMsmError : IUnknown
{
    HRESULT Next(uint cFetch, IMsmError* rgmsmErrors, uint* pcFetched);
    HRESULT Skip(uint cSkip);
    HRESULT Reset();
    HRESULT Clone(IEnumMsmError* pemsmErrors);
}

@GUID("0ADDA82A-2C26-11D2-AD65-00A0C9AF11A6")
interface IMsmErrors : IDispatch
{
    HRESULT get_Item(int Item, IMsmError* Return);
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* NewEnum);
}

@GUID("0ADDA82B-2C26-11D2-AD65-00A0C9AF11A6")
interface IMsmDependency : IDispatch
{
    HRESULT get_Module(BSTR* Module);
    HRESULT get_Language(short* Language);
    HRESULT get_Version(BSTR* Version);
}

@GUID("0ADDA82C-2C26-11D2-AD65-00A0C9AF11A6")
interface IEnumMsmDependency : IUnknown
{
    HRESULT Next(uint cFetch, IMsmDependency* rgmsmDependencies, uint* pcFetched);
    HRESULT Skip(uint cSkip);
    HRESULT Reset();
    HRESULT Clone(IEnumMsmDependency* pemsmDependencies);
}

@GUID("0ADDA82D-2C26-11D2-AD65-00A0C9AF11A6")
interface IMsmDependencies : IDispatch
{
    HRESULT get_Item(int Item, IMsmDependency* Return);
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* NewEnum);
}

@GUID("0ADDA82E-2C26-11D2-AD65-00A0C9AF11A6")
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

@GUID("7041AE26-2D78-11D2-888A-00A0C981B015")
interface IMsmGetFiles : IDispatch
{
    HRESULT get_ModuleFiles(IMsmStrings* Files);
}

@GUID("CD193BC0-B4BC-11D2-9833-00C04FC31D2E")
interface IAssemblyName : IUnknown
{
    HRESULT SetProperty(uint PropertyId, void* pvProperty, uint cbProperty);
    HRESULT GetProperty(uint PropertyId, void* pvProperty, uint* pcbProperty);
    HRESULT Finalize();
    HRESULT GetDisplayName(const(wchar)* szDisplayName, uint* pccDisplayName, uint dwDisplayFlags);
    HRESULT Reserved(const(GUID)* refIID, IUnknown pUnkReserved1, IUnknown pUnkReserved2, ushort* szReserved, 
                     long llReserved, void* pvReserved, uint cbReserved, void** ppReserved);
    HRESULT GetName(uint* lpcwBuffer, const(wchar)* pwzName);
    HRESULT GetVersion(uint* pdwVersionHi, uint* pdwVersionLow);
    HRESULT IsEqual(IAssemblyName pName, uint dwCmpFlags);
    HRESULT Clone(IAssemblyName* pName);
}

@GUID("9E3AAEB4-D1CD-11D2-BAB9-00C04F8ECEAE")
interface IAssemblyCacheItem : IUnknown
{
    HRESULT CreateStream(uint dwFlags, const(wchar)* pszStreamName, uint dwFormat, uint dwFormatFlags, 
                         IStream* ppIStream, ULARGE_INTEGER* puliMaxSize);
    HRESULT Commit(uint dwFlags, uint* pulDisposition);
    HRESULT AbortItem();
}

@GUID("E707DCDE-D1CD-11D2-BAB9-00C04F8ECEAE")
interface IAssemblyCache : IUnknown
{
    HRESULT UninstallAssembly(uint dwFlags, const(wchar)* pszAssemblyName, FUSION_INSTALL_REFERENCE* pRefData, 
                              uint* pulDisposition);
    HRESULT QueryAssemblyInfo(uint dwFlags, const(wchar)* pszAssemblyName, ASSEMBLY_INFO* pAsmInfo);
    HRESULT CreateAssemblyCacheItem(uint dwFlags, void* pvReserved, IAssemblyCacheItem* ppAsmItem, 
                                    const(wchar)* pszAssemblyName);
    HRESULT Reserved(IUnknown* ppUnk);
    HRESULT InstallAssembly(uint dwFlags, const(wchar)* pszManifestFilePath, FUSION_INSTALL_REFERENCE* pRefData);
}


// GUIDs

const GUID CLSID_MsmMerge = GUIDOF!MsmMerge;

const GUID IID_IAssemblyCache     = GUIDOF!IAssemblyCache;
const GUID IID_IAssemblyCacheItem = GUIDOF!IAssemblyCacheItem;
const GUID IID_IAssemblyName      = GUIDOF!IAssemblyName;
const GUID IID_IEnumMsmDependency = GUIDOF!IEnumMsmDependency;
const GUID IID_IEnumMsmError      = GUIDOF!IEnumMsmError;
const GUID IID_IEnumMsmString     = GUIDOF!IEnumMsmString;
const GUID IID_IMsmDependencies   = GUIDOF!IMsmDependencies;
const GUID IID_IMsmDependency     = GUIDOF!IMsmDependency;
const GUID IID_IMsmError          = GUIDOF!IMsmError;
const GUID IID_IMsmErrors         = GUIDOF!IMsmErrors;
const GUID IID_IMsmGetFiles       = GUIDOF!IMsmGetFiles;
const GUID IID_IMsmMerge          = GUIDOF!IMsmMerge;
const GUID IID_IMsmStrings        = GUIDOF!IMsmStrings;
