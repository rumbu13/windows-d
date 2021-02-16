module windows.windowspropertiessystem;

public import windows.core;
public import windows.audio : IPropertyStore;
public import windows.automation : BSTR, IPropertyBag, VARIANT;
public import windows.com : HRESULT, IBindCtx, IUnknown;
public import windows.displaydevices : POINTL, POINTS, RECTL;
public import windows.search : CONDITION_OPERATION;
public import windows.shell : IDelayedPropertyStoreFactory, IObjectWithPropertyKey, ITEMIDLIST, STRRET;
public import windows.structuredstorage : IPropertySetStorage, IPropertyStorage, IStream, PROPSPEC, PROPVARIANT;
public import windows.systemservices : BOOL, HANDLE, HINSTANCE;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


// Enums


enum : int
{
    GPS_DEFAULT                 = 0x00000000,
    GPS_HANDLERPROPERTIESONLY   = 0x00000001,
    GPS_READWRITE               = 0x00000002,
    GPS_TEMPORARY               = 0x00000004,
    GPS_FASTPROPERTIESONLY      = 0x00000008,
    GPS_OPENSLOWITEM            = 0x00000010,
    GPS_DELAYCREATION           = 0x00000020,
    GPS_BESTEFFORT              = 0x00000040,
    GPS_NO_OPLOCK               = 0x00000080,
    GPS_PREFERQUERYPROPERTIES   = 0x00000100,
    GPS_EXTRINSICPROPERTIES     = 0x00000200,
    GPS_EXTRINSICPROPERTIESONLY = 0x00000400,
    GPS_VOLATILEPROPERTIES      = 0x00000800,
    GPS_VOLATILEPROPERTIESONLY  = 0x00001000,
    GPS_MASK_VALID              = 0x00001fff,
}
alias GETPROPERTYSTOREFLAGS = int;

enum : int
{
    PKA_SET    = 0x00000000,
    PKA_APPEND = 0x00000001,
    PKA_DELETE = 0x00000002,
}
alias PKA_FLAGS = int;

enum : int
{
    PSC_NORMAL      = 0x00000000,
    PSC_NOTINSOURCE = 0x00000001,
    PSC_DIRTY       = 0x00000002,
    PSC_READONLY    = 0x00000003,
}
alias PSC_STATE = int;

enum : int
{
    PET_DISCRETEVALUE = 0x00000000,
    PET_RANGEDVALUE   = 0x00000001,
    PET_DEFAULTVALUE  = 0x00000002,
    PET_ENDRANGE      = 0x00000003,
}
alias PROPENUMTYPE = int;

enum : int
{
    PDTF_DEFAULT                   = 0x00000000,
    PDTF_MULTIPLEVALUES            = 0x00000001,
    PDTF_ISINNATE                  = 0x00000002,
    PDTF_ISGROUP                   = 0x00000004,
    PDTF_CANGROUPBY                = 0x00000008,
    PDTF_CANSTACKBY                = 0x00000010,
    PDTF_ISTREEPROPERTY            = 0x00000020,
    PDTF_INCLUDEINFULLTEXTQUERY    = 0x00000040,
    PDTF_ISVIEWABLE                = 0x00000080,
    PDTF_ISQUERYABLE               = 0x00000100,
    PDTF_CANBEPURGED               = 0x00000200,
    PDTF_SEARCHRAWVALUE            = 0x00000400,
    PDTF_DONTCOERCEEMPTYSTRINGS    = 0x00000800,
    PDTF_ALWAYSINSUPPLEMENTALSTORE = 0x00001000,
    PDTF_ISSYSTEMPROPERTY          = 0x80000000,
    PDTF_MASK_ALL                  = 0x80001fff,
}
alias PROPDESC_TYPE_FLAGS = int;

enum : int
{
    PDVF_DEFAULT             = 0x00000000,
    PDVF_CENTERALIGN         = 0x00000001,
    PDVF_RIGHTALIGN          = 0x00000002,
    PDVF_BEGINNEWGROUP       = 0x00000004,
    PDVF_FILLAREA            = 0x00000008,
    PDVF_SORTDESCENDING      = 0x00000010,
    PDVF_SHOWONLYIFPRESENT   = 0x00000020,
    PDVF_SHOWBYDEFAULT       = 0x00000040,
    PDVF_SHOWINPRIMARYLIST   = 0x00000080,
    PDVF_SHOWINSECONDARYLIST = 0x00000100,
    PDVF_HIDELABEL           = 0x00000200,
    PDVF_HIDDEN              = 0x00000800,
    PDVF_CANWRAP             = 0x00001000,
    PDVF_MASK_ALL            = 0x00001bff,
}
alias PROPDESC_VIEW_FLAGS = int;

enum : int
{
    PDDT_STRING     = 0x00000000,
    PDDT_NUMBER     = 0x00000001,
    PDDT_BOOLEAN    = 0x00000002,
    PDDT_DATETIME   = 0x00000003,
    PDDT_ENUMERATED = 0x00000004,
}
alias PROPDESC_DISPLAYTYPE = int;

enum : int
{
    PDGR_DISCRETE     = 0x00000000,
    PDGR_ALPHANUMERIC = 0x00000001,
    PDGR_SIZE         = 0x00000002,
    PDGR_DYNAMIC      = 0x00000003,
    PDGR_DATE         = 0x00000004,
    PDGR_PERCENT      = 0x00000005,
    PDGR_ENUMERATED   = 0x00000006,
}
alias PROPDESC_GROUPING_RANGE = int;

enum : int
{
    PDFF_DEFAULT              = 0x00000000,
    PDFF_PREFIXNAME           = 0x00000001,
    PDFF_FILENAME             = 0x00000002,
    PDFF_ALWAYSKB             = 0x00000004,
    PDFF_RESERVED_RIGHTTOLEFT = 0x00000008,
    PDFF_SHORTTIME            = 0x00000010,
    PDFF_LONGTIME             = 0x00000020,
    PDFF_HIDETIME             = 0x00000040,
    PDFF_SHORTDATE            = 0x00000080,
    PDFF_LONGDATE             = 0x00000100,
    PDFF_HIDEDATE             = 0x00000200,
    PDFF_RELATIVEDATE         = 0x00000400,
    PDFF_USEEDITINVITATION    = 0x00000800,
    PDFF_READONLY             = 0x00001000,
    PDFF_NOAUTOREADINGORDER   = 0x00002000,
}
alias PROPDESC_FORMAT_FLAGS = int;

enum : int
{
    PDSD_GENERAL          = 0x00000000,
    PDSD_A_Z              = 0x00000001,
    PDSD_LOWEST_HIGHEST   = 0x00000002,
    PDSD_SMALLEST_BIGGEST = 0x00000003,
    PDSD_OLDEST_NEWEST    = 0x00000004,
}
alias PROPDESC_SORTDESCRIPTION = int;

enum : int
{
    PDRDT_GENERAL  = 0x00000000,
    PDRDT_DATE     = 0x00000001,
    PDRDT_SIZE     = 0x00000002,
    PDRDT_COUNT    = 0x00000003,
    PDRDT_REVISION = 0x00000004,
    PDRDT_LENGTH   = 0x00000005,
    PDRDT_DURATION = 0x00000006,
    PDRDT_SPEED    = 0x00000007,
    PDRDT_RATE     = 0x00000008,
    PDRDT_RATING   = 0x00000009,
    PDRDT_PRIORITY = 0x0000000a,
}
alias PROPDESC_RELATIVEDESCRIPTION_TYPE = int;

enum : int
{
    PDAT_DEFAULT   = 0x00000000,
    PDAT_FIRST     = 0x00000001,
    PDAT_SUM       = 0x00000002,
    PDAT_AVERAGE   = 0x00000003,
    PDAT_DATERANGE = 0x00000004,
    PDAT_UNION     = 0x00000005,
    PDAT_MAX       = 0x00000006,
    PDAT_MIN       = 0x00000007,
}
alias PROPDESC_AGGREGATION_TYPE = int;

enum : int
{
    PDCOT_NONE     = 0x00000000,
    PDCOT_STRING   = 0x00000001,
    PDCOT_SIZE     = 0x00000002,
    PDCOT_DATETIME = 0x00000003,
    PDCOT_BOOLEAN  = 0x00000004,
    PDCOT_NUMBER   = 0x00000005,
}
alias PROPDESC_CONDITION_TYPE = int;

enum : int
{
    PDSIF_DEFAULT         = 0x00000000,
    PDSIF_ININVERTEDINDEX = 0x00000001,
    PDSIF_ISCOLUMN        = 0x00000002,
    PDSIF_ISCOLUMNSPARSE  = 0x00000004,
    PDSIF_ALWAYSINCLUDE   = 0x00000008,
    PDSIF_USEFORTYPEAHEAD = 0x00000010,
}
alias PROPDESC_SEARCHINFO_FLAGS = int;

enum : int
{
    PDCIT_NONE         = 0x00000000,
    PDCIT_ONDISK       = 0x00000001,
    PDCIT_INMEMORY     = 0x00000002,
    PDCIT_ONDEMAND     = 0x00000003,
    PDCIT_ONDISKALL    = 0x00000004,
    PDCIT_ONDISKVECTOR = 0x00000005,
}
alias PROPDESC_COLUMNINDEX_TYPE = int;

enum : int
{
    PDEF_ALL             = 0x00000000,
    PDEF_SYSTEM          = 0x00000001,
    PDEF_NONSYSTEM       = 0x00000002,
    PDEF_VIEWABLE        = 0x00000003,
    PDEF_QUERYABLE       = 0x00000004,
    PDEF_INFULLTEXTQUERY = 0x00000005,
    PDEF_COLUMN          = 0x00000006,
}
alias PROPDESC_ENUMFILTER = int;

enum : int
{
    FPSPS_DEFAULT                   = 0x00000000,
    FPSPS_READONLY                  = 0x00000001,
    FPSPS_TREAT_NEW_VALUES_AS_DIRTY = 0x00000002,
}
alias _PERSIST_SPROPSTORE_FLAGS = int;

enum : int
{
    PSTF_UTC   = 0x00000000,
    PSTF_LOCAL = 0x00000001,
}
alias tagPSTIME_FLAGS = int;

enum : int
{
    PVCU_DEFAULT = 0x00000000,
    PVCU_SECOND  = 0x00000001,
    PVCU_MINUTE  = 0x00000002,
    PVCU_HOUR    = 0x00000003,
    PVCU_DAY     = 0x00000004,
    PVCU_MONTH   = 0x00000005,
    PVCU_YEAR    = 0x00000006,
}
alias PROPVAR_COMPARE_UNIT = int;

enum : int
{
    PVCF_DEFAULT                       = 0x00000000,
    PVCF_TREATEMPTYASGREATERTHAN       = 0x00000001,
    PVCF_USESTRCMP                     = 0x00000002,
    PVCF_USESTRCMPC                    = 0x00000004,
    PVCF_USESTRCMPI                    = 0x00000008,
    PVCF_USESTRCMPIC                   = 0x00000010,
    PVCF_DIGITSASNUMBERS_CASESENSITIVE = 0x00000020,
}
alias tagPROPVAR_COMPARE_FLAGS = int;

enum : int
{
    PVCHF_DEFAULT        = 0x00000000,
    PVCHF_NOVALUEPROP    = 0x00000001,
    PVCHF_ALPHABOOL      = 0x00000002,
    PVCHF_NOUSEROVERRIDE = 0x00000004,
    PVCHF_LOCALBOOL      = 0x00000008,
    PVCHF_NOHEXSTRING    = 0x00000010,
}
alias tagPROPVAR_CHANGE_FLAGS = int;

enum : int
{
    DPF_NONE             = 0x00000000,
    DPF_MARQUEE          = 0x00000001,
    DPF_MARQUEE_COMPLETE = 0x00000002,
    DPF_ERROR            = 0x00000004,
    DPF_WARNING          = 0x00000008,
    DPF_STOPPED          = 0x00000010,
}
alias DRAWPROGRESSFLAGS = int;

enum : int
{
    STS_NONE                   = 0x00000000,
    STS_NEEDSUPLOAD            = 0x00000001,
    STS_NEEDSDOWNLOAD          = 0x00000002,
    STS_TRANSFERRING           = 0x00000004,
    STS_PAUSED                 = 0x00000008,
    STS_HASERROR               = 0x00000010,
    STS_FETCHING_METADATA      = 0x00000020,
    STS_USER_REQUESTED_REFRESH = 0x00000040,
    STS_HASWARNING             = 0x00000080,
    STS_EXCLUDED               = 0x00000100,
    STS_INCOMPLETE             = 0x00000200,
    STS_PLACEHOLDER_IFEMPTY    = 0x00000400,
}
alias SYNC_TRANSFER_STATUS = int;

enum : int
{
    PS_NONE                            = 0x00000000,
    PS_MARKED_FOR_OFFLINE_AVAILABILITY = 0x00000001,
    PS_FULL_PRIMARY_STREAM_AVAILABLE   = 0x00000002,
    PS_CREATE_FILE_ACCESSIBLE          = 0x00000004,
    PS_CLOUDFILE_PLACEHOLDER           = 0x00000008,
    PS_DEFAULT                         = 0x00000007,
    PS_ALL                             = 0x0000000f,
}
alias PLACEHOLDER_STATES = int;

enum : int
{
    PUIF_DEFAULT          = 0x00000000,
    PUIF_RIGHTALIGN       = 0x00000001,
    PUIF_NOLABELININFOTIP = 0x00000002,
}
alias _PROPERTYUI_FLAGS = int;

enum : int
{
    PDOPS_RUNNING   = 0x00000001,
    PDOPS_PAUSED    = 0x00000002,
    PDOPS_CANCELLED = 0x00000003,
    PDOPS_STOPPED   = 0x00000004,
    PDOPS_ERRORS    = 0x00000005,
}
alias PDOPSTATUS = int;

enum : int
{
    SESF_NONE                          = 0x00000000,
    SESF_SERVICE_QUOTA_NEARING_LIMIT   = 0x00000001,
    SESF_SERVICE_QUOTA_EXCEEDED_LIMIT  = 0x00000002,
    SESF_AUTHENTICATION_ERROR          = 0x00000004,
    SESF_PAUSED_DUE_TO_METERED_NETWORK = 0x00000008,
    SESF_PAUSED_DUE_TO_DISK_SPACE_FULL = 0x00000010,
    SESF_PAUSED_DUE_TO_CLIENT_POLICY   = 0x00000020,
    SESF_PAUSED_DUE_TO_SERVICE_POLICY  = 0x00000040,
    SESF_SERVICE_UNAVAILABLE           = 0x00000080,
    SESF_PAUSED_DUE_TO_USER_REQUEST    = 0x00000100,
    SESF_ALL_FLAGS                     = 0x000001ff,
}
alias SYNC_ENGINE_STATE_FLAGS = int;

// Structs


struct PROPERTYKEY
{
    GUID fmtid;
    uint pid;
}

struct SERIALIZEDPROPSTORAGE
{
}

struct PROPPRG
{
align (1):
    ushort    flPrg;
    ushort    flPrgInit;
    byte[30]  achTitle;
    byte[128] achCmdLine;
    byte[64]  achWorkDir;
    ushort    wHotKey;
    byte[80]  achIconFile;
    ushort    wIconIndex;
    uint      dwEnhModeFlags;
    uint      dwRealModeFlags;
    byte[80]  achOtherFile;
    byte[260] achPIFFile;
}

// Functions

@DllImport("PROPSYS")
HRESULT PropVariantToWinRTPropertyValue(const(PROPVARIANT)* propvar, const(GUID)* riid, void** ppv);

@DllImport("PROPSYS")
HRESULT WinRTPropertyValueToPropVariant(IUnknown punkPropertyValue, PROPVARIANT* ppropvar);

@DllImport("PROPSYS")
HRESULT PSFormatForDisplay(const(PROPERTYKEY)* propkey, const(PROPVARIANT)* propvar, 
                           PROPDESC_FORMAT_FLAGS pdfFlags, const(wchar)* pwszText, uint cchText);

@DllImport("PROPSYS")
HRESULT PSFormatForDisplayAlloc(const(PROPERTYKEY)* key, const(PROPVARIANT)* propvar, PROPDESC_FORMAT_FLAGS pdff, 
                                ushort** ppszDisplay);

@DllImport("PROPSYS")
HRESULT PSFormatPropertyValue(IPropertyStore pps, IPropertyDescription ppd, PROPDESC_FORMAT_FLAGS pdff, 
                              ushort** ppszDisplay);

@DllImport("PROPSYS")
HRESULT PSGetImageReferenceForValue(const(PROPERTYKEY)* propkey, const(PROPVARIANT)* propvar, 
                                    ushort** ppszImageRes);

@DllImport("PROPSYS")
HRESULT PSStringFromPropertyKey(const(PROPERTYKEY)* pkey, const(wchar)* psz, uint cch);

@DllImport("PROPSYS")
HRESULT PSPropertyKeyFromString(const(wchar)* pszString, PROPERTYKEY* pkey);

@DllImport("PROPSYS")
HRESULT PSCreateMemoryPropertyStore(const(GUID)* riid, void** ppv);

@DllImport("PROPSYS")
HRESULT PSCreateDelayedMultiplexPropertyStore(GETPROPERTYSTOREFLAGS flags, IDelayedPropertyStoreFactory pdpsf, 
                                              char* rgStoreIds, uint cStores, const(GUID)* riid, void** ppv);

@DllImport("PROPSYS")
HRESULT PSCreateMultiplexPropertyStore(char* prgpunkStores, uint cStores, const(GUID)* riid, void** ppv);

@DllImport("PROPSYS")
HRESULT PSCreatePropertyChangeArray(char* rgpropkey, char* rgflags, char* rgpropvar, uint cChanges, 
                                    const(GUID)* riid, void** ppv);

@DllImport("PROPSYS")
HRESULT PSCreateSimplePropertyChange(PKA_FLAGS flags, const(PROPERTYKEY)* key, const(PROPVARIANT)* propvar, 
                                     const(GUID)* riid, void** ppv);

@DllImport("PROPSYS")
HRESULT PSGetPropertyDescription(const(PROPERTYKEY)* propkey, const(GUID)* riid, void** ppv);

@DllImport("PROPSYS")
HRESULT PSGetPropertyDescriptionByName(const(wchar)* pszCanonicalName, const(GUID)* riid, void** ppv);

@DllImport("PROPSYS")
HRESULT PSLookupPropertyHandlerCLSID(const(wchar)* pszFilePath, GUID* pclsid);

@DllImport("PROPSYS")
HRESULT PSGetItemPropertyHandler(IUnknown punkItem, BOOL fReadWrite, const(GUID)* riid, void** ppv);

@DllImport("PROPSYS")
HRESULT PSGetItemPropertyHandlerWithCreateObject(IUnknown punkItem, BOOL fReadWrite, IUnknown punkCreateObject, 
                                                 const(GUID)* riid, void** ppv);

@DllImport("PROPSYS")
HRESULT PSGetPropertyValue(IPropertyStore pps, IPropertyDescription ppd, PROPVARIANT* ppropvar);

@DllImport("PROPSYS")
HRESULT PSSetPropertyValue(IPropertyStore pps, IPropertyDescription ppd, const(PROPVARIANT)* propvar);

@DllImport("PROPSYS")
HRESULT PSRegisterPropertySchema(const(wchar)* pszPath);

@DllImport("PROPSYS")
HRESULT PSUnregisterPropertySchema(const(wchar)* pszPath);

@DllImport("PROPSYS")
HRESULT PSRefreshPropertySchema();

@DllImport("PROPSYS")
HRESULT PSEnumeratePropertyDescriptions(PROPDESC_ENUMFILTER filterOn, const(GUID)* riid, void** ppv);

@DllImport("PROPSYS")
HRESULT PSGetPropertyKeyFromName(const(wchar)* pszName, PROPERTYKEY* ppropkey);

@DllImport("PROPSYS")
HRESULT PSGetNameFromPropertyKey(const(PROPERTYKEY)* propkey, ushort** ppszCanonicalName);

@DllImport("PROPSYS")
HRESULT PSCoerceToCanonicalValue(const(PROPERTYKEY)* key, PROPVARIANT* ppropvar);

@DllImport("PROPSYS")
HRESULT PSGetPropertyDescriptionListFromString(const(wchar)* pszPropList, const(GUID)* riid, void** ppv);

@DllImport("PROPSYS")
HRESULT PSCreatePropertyStoreFromPropertySetStorage(IPropertySetStorage ppss, uint grfMode, const(GUID)* riid, 
                                                    void** ppv);

@DllImport("PROPSYS")
HRESULT PSCreatePropertyStoreFromObject(IUnknown punk, uint grfMode, const(GUID)* riid, void** ppv);

@DllImport("PROPSYS")
HRESULT PSCreateAdapterFromPropertyStore(IPropertyStore pps, const(GUID)* riid, void** ppv);

@DllImport("PROPSYS")
HRESULT PSGetPropertySystem(const(GUID)* riid, void** ppv);

@DllImport("PROPSYS")
HRESULT PSGetPropertyFromPropertyStorage(char* psps, uint cb, const(PROPERTYKEY)* rpkey, PROPVARIANT* ppropvar);

@DllImport("PROPSYS")
HRESULT PSGetNamedPropertyFromPropertyStorage(char* psps, uint cb, const(wchar)* pszName, PROPVARIANT* ppropvar);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadType(IPropertyBag propBag, const(wchar)* propName, VARIANT* var, ushort type);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadStr(IPropertyBag propBag, const(wchar)* propName, const(wchar)* value, 
                              int characterCount);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadStrAlloc(IPropertyBag propBag, const(wchar)* propName, ushort** value);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadBSTR(IPropertyBag propBag, const(wchar)* propName, BSTR* value);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_WriteStr(IPropertyBag propBag, const(wchar)* propName, const(wchar)* value);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_WriteBSTR(IPropertyBag propBag, const(wchar)* propName, BSTR value);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadInt(IPropertyBag propBag, const(wchar)* propName, int* value);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_WriteInt(IPropertyBag propBag, const(wchar)* propName, int value);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadSHORT(IPropertyBag propBag, const(wchar)* propName, short* value);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_WriteSHORT(IPropertyBag propBag, const(wchar)* propName, short value);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadLONG(IPropertyBag propBag, const(wchar)* propName, int* value);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_WriteLONG(IPropertyBag propBag, const(wchar)* propName, int value);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadDWORD(IPropertyBag propBag, const(wchar)* propName, uint* value);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_WriteDWORD(IPropertyBag propBag, const(wchar)* propName, uint value);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadBOOL(IPropertyBag propBag, const(wchar)* propName, int* value);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_WriteBOOL(IPropertyBag propBag, const(wchar)* propName, BOOL value);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadPOINTL(IPropertyBag propBag, const(wchar)* propName, POINTL* value);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_WritePOINTL(IPropertyBag propBag, const(wchar)* propName, const(POINTL)* value);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadPOINTS(IPropertyBag propBag, const(wchar)* propName, POINTS* value);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_WritePOINTS(IPropertyBag propBag, const(wchar)* propName, const(POINTS)* value);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadRECTL(IPropertyBag propBag, const(wchar)* propName, RECTL* value);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_WriteRECTL(IPropertyBag propBag, const(wchar)* propName, const(RECTL)* value);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadStream(IPropertyBag propBag, const(wchar)* propName, IStream* value);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_WriteStream(IPropertyBag propBag, const(wchar)* propName, IStream value);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_Delete(IPropertyBag propBag, const(wchar)* propName);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadULONGLONG(IPropertyBag propBag, const(wchar)* propName, ulong* value);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_WriteULONGLONG(IPropertyBag propBag, const(wchar)* propName, ulong value);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadUnknown(IPropertyBag propBag, const(wchar)* propName, const(GUID)* riid, void** ppv);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_WriteUnknown(IPropertyBag propBag, const(wchar)* propName, IUnknown punk);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadGUID(IPropertyBag propBag, const(wchar)* propName, GUID* value);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_WriteGUID(IPropertyBag propBag, const(wchar)* propName, const(GUID)* value);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadPropertyKey(IPropertyBag propBag, const(wchar)* propName, PROPERTYKEY* value);

@DllImport("PROPSYS")
HRESULT PSPropertyBag_WritePropertyKey(IPropertyBag propBag, const(wchar)* propName, const(PROPERTYKEY)* value);

@DllImport("PROPSYS")
HRESULT InitPropVariantFromResource(HINSTANCE hinst, uint id, PROPVARIANT* ppropvar);

@DllImport("PROPSYS")
HRESULT InitPropVariantFromBuffer(char* pv, uint cb, PROPVARIANT* ppropvar);

@DllImport("PROPSYS")
HRESULT InitPropVariantFromCLSID(const(GUID)* clsid, PROPVARIANT* ppropvar);

@DllImport("PROPSYS")
HRESULT InitPropVariantFromGUIDAsString(const(GUID)* guid, PROPVARIANT* ppropvar);

@DllImport("PROPSYS")
HRESULT InitPropVariantFromFileTime(const(FILETIME)* pftIn, PROPVARIANT* ppropvar);

@DllImport("PROPSYS")
HRESULT InitPropVariantFromPropVariantVectorElem(const(PROPVARIANT)* propvarIn, uint iElem, PROPVARIANT* ppropvar);

@DllImport("PROPSYS")
HRESULT InitPropVariantVectorFromPropVariant(const(PROPVARIANT)* propvarSingle, PROPVARIANT* ppropvarVector);

@DllImport("PROPSYS")
HRESULT InitPropVariantFromStrRet(STRRET* pstrret, ITEMIDLIST* pidl, PROPVARIANT* ppropvar);

@DllImport("PROPSYS")
HRESULT InitPropVariantFromBooleanVector(char* prgf, uint cElems, PROPVARIANT* ppropvar);

@DllImport("PROPSYS")
HRESULT InitPropVariantFromInt16Vector(char* prgn, uint cElems, PROPVARIANT* ppropvar);

@DllImport("PROPSYS")
HRESULT InitPropVariantFromUInt16Vector(char* prgn, uint cElems, PROPVARIANT* ppropvar);

@DllImport("PROPSYS")
HRESULT InitPropVariantFromInt32Vector(char* prgn, uint cElems, PROPVARIANT* ppropvar);

@DllImport("PROPSYS")
HRESULT InitPropVariantFromUInt32Vector(char* prgn, uint cElems, PROPVARIANT* ppropvar);

@DllImport("PROPSYS")
HRESULT InitPropVariantFromInt64Vector(char* prgn, uint cElems, PROPVARIANT* ppropvar);

@DllImport("PROPSYS")
HRESULT InitPropVariantFromUInt64Vector(char* prgn, uint cElems, PROPVARIANT* ppropvar);

@DllImport("PROPSYS")
HRESULT InitPropVariantFromDoubleVector(char* prgn, uint cElems, PROPVARIANT* ppropvar);

@DllImport("PROPSYS")
HRESULT InitPropVariantFromFileTimeVector(char* prgft, uint cElems, PROPVARIANT* ppropvar);

@DllImport("PROPSYS")
HRESULT InitPropVariantFromStringVector(char* prgsz, uint cElems, PROPVARIANT* ppropvar);

@DllImport("PROPSYS")
HRESULT InitPropVariantFromStringAsVector(const(wchar)* psz, PROPVARIANT* ppropvar);

@DllImport("PROPSYS")
BOOL PropVariantToBooleanWithDefault(const(PROPVARIANT)* propvarIn, BOOL fDefault);

@DllImport("PROPSYS")
short PropVariantToInt16WithDefault(const(PROPVARIANT)* propvarIn, short iDefault);

@DllImport("PROPSYS")
ushort PropVariantToUInt16WithDefault(const(PROPVARIANT)* propvarIn, ushort uiDefault);

@DllImport("PROPSYS")
int PropVariantToInt32WithDefault(const(PROPVARIANT)* propvarIn, int lDefault);

@DllImport("PROPSYS")
uint PropVariantToUInt32WithDefault(const(PROPVARIANT)* propvarIn, uint ulDefault);

@DllImport("PROPSYS")
long PropVariantToInt64WithDefault(const(PROPVARIANT)* propvarIn, long llDefault);

@DllImport("PROPSYS")
ulong PropVariantToUInt64WithDefault(const(PROPVARIANT)* propvarIn, ulong ullDefault);

@DllImport("PROPSYS")
double PropVariantToDoubleWithDefault(const(PROPVARIANT)* propvarIn, double dblDefault);

@DllImport("PROPSYS")
ushort* PropVariantToStringWithDefault(const(PROPVARIANT)* propvarIn, const(wchar)* pszDefault);

@DllImport("PROPSYS")
HRESULT PropVariantToBoolean(const(PROPVARIANT)* propvarIn, int* pfRet);

@DllImport("PROPSYS")
HRESULT PropVariantToInt16(const(PROPVARIANT)* propvarIn, short* piRet);

@DllImport("PROPSYS")
HRESULT PropVariantToUInt16(const(PROPVARIANT)* propvarIn, ushort* puiRet);

@DllImport("PROPSYS")
HRESULT PropVariantToInt32(const(PROPVARIANT)* propvarIn, int* plRet);

@DllImport("PROPSYS")
HRESULT PropVariantToUInt32(const(PROPVARIANT)* propvarIn, uint* pulRet);

@DllImport("PROPSYS")
HRESULT PropVariantToInt64(const(PROPVARIANT)* propvarIn, long* pllRet);

@DllImport("PROPSYS")
HRESULT PropVariantToUInt64(const(PROPVARIANT)* propvarIn, ulong* pullRet);

@DllImport("PROPSYS")
HRESULT PropVariantToDouble(const(PROPVARIANT)* propvarIn, double* pdblRet);

@DllImport("PROPSYS")
HRESULT PropVariantToBuffer(const(PROPVARIANT)* propvar, char* pv, uint cb);

@DllImport("PROPSYS")
HRESULT PropVariantToString(const(PROPVARIANT)* propvar, const(wchar)* psz, uint cch);

@DllImport("PROPSYS")
HRESULT PropVariantToGUID(const(PROPVARIANT)* propvar, GUID* pguid);

@DllImport("PROPSYS")
HRESULT PropVariantToStringAlloc(const(PROPVARIANT)* propvar, ushort** ppszOut);

@DllImport("PROPSYS")
HRESULT PropVariantToBSTR(const(PROPVARIANT)* propvar, BSTR* pbstrOut);

@DllImport("PROPSYS")
HRESULT PropVariantToStrRet(const(PROPVARIANT)* propvar, STRRET* pstrret);

@DllImport("PROPSYS")
HRESULT PropVariantToFileTime(const(PROPVARIANT)* propvar, int pstfOut, FILETIME* pftOut);

@DllImport("PROPSYS")
uint PropVariantGetElementCount(const(PROPVARIANT)* propvar);

@DllImport("PROPSYS")
HRESULT PropVariantToBooleanVector(const(PROPVARIANT)* propvar, char* prgf, uint crgf, uint* pcElem);

@DllImport("PROPSYS")
HRESULT PropVariantToInt16Vector(const(PROPVARIANT)* propvar, char* prgn, uint crgn, uint* pcElem);

@DllImport("PROPSYS")
HRESULT PropVariantToUInt16Vector(const(PROPVARIANT)* propvar, char* prgn, uint crgn, uint* pcElem);

@DllImport("PROPSYS")
HRESULT PropVariantToInt32Vector(const(PROPVARIANT)* propvar, char* prgn, uint crgn, uint* pcElem);

@DllImport("PROPSYS")
HRESULT PropVariantToUInt32Vector(const(PROPVARIANT)* propvar, char* prgn, uint crgn, uint* pcElem);

@DllImport("PROPSYS")
HRESULT PropVariantToInt64Vector(const(PROPVARIANT)* propvar, char* prgn, uint crgn, uint* pcElem);

@DllImport("PROPSYS")
HRESULT PropVariantToUInt64Vector(const(PROPVARIANT)* propvar, char* prgn, uint crgn, uint* pcElem);

@DllImport("PROPSYS")
HRESULT PropVariantToDoubleVector(const(PROPVARIANT)* propvar, char* prgn, uint crgn, uint* pcElem);

@DllImport("PROPSYS")
HRESULT PropVariantToFileTimeVector(const(PROPVARIANT)* propvar, char* prgft, uint crgft, uint* pcElem);

@DllImport("PROPSYS")
HRESULT PropVariantToStringVector(const(PROPVARIANT)* propvar, char* prgsz, uint crgsz, uint* pcElem);

@DllImport("PROPSYS")
HRESULT PropVariantToBooleanVectorAlloc(const(PROPVARIANT)* propvar, int** pprgf, uint* pcElem);

@DllImport("PROPSYS")
HRESULT PropVariantToInt16VectorAlloc(const(PROPVARIANT)* propvar, short** pprgn, uint* pcElem);

@DllImport("PROPSYS")
HRESULT PropVariantToUInt16VectorAlloc(const(PROPVARIANT)* propvar, ushort** pprgn, uint* pcElem);

@DllImport("PROPSYS")
HRESULT PropVariantToInt32VectorAlloc(const(PROPVARIANT)* propvar, int** pprgn, uint* pcElem);

@DllImport("PROPSYS")
HRESULT PropVariantToUInt32VectorAlloc(const(PROPVARIANT)* propvar, uint** pprgn, uint* pcElem);

@DllImport("PROPSYS")
HRESULT PropVariantToInt64VectorAlloc(const(PROPVARIANT)* propvar, long** pprgn, uint* pcElem);

@DllImport("PROPSYS")
HRESULT PropVariantToUInt64VectorAlloc(const(PROPVARIANT)* propvar, ulong** pprgn, uint* pcElem);

@DllImport("PROPSYS")
HRESULT PropVariantToDoubleVectorAlloc(const(PROPVARIANT)* propvar, double** pprgn, uint* pcElem);

@DllImport("PROPSYS")
HRESULT PropVariantToFileTimeVectorAlloc(const(PROPVARIANT)* propvar, FILETIME** pprgft, uint* pcElem);

@DllImport("PROPSYS")
HRESULT PropVariantToStringVectorAlloc(const(PROPVARIANT)* propvar, ushort*** pprgsz, uint* pcElem);

@DllImport("PROPSYS")
HRESULT PropVariantGetBooleanElem(const(PROPVARIANT)* propvar, uint iElem, int* pfVal);

@DllImport("PROPSYS")
HRESULT PropVariantGetInt16Elem(const(PROPVARIANT)* propvar, uint iElem, short* pnVal);

@DllImport("PROPSYS")
HRESULT PropVariantGetUInt16Elem(const(PROPVARIANT)* propvar, uint iElem, ushort* pnVal);

@DllImport("PROPSYS")
HRESULT PropVariantGetInt32Elem(const(PROPVARIANT)* propvar, uint iElem, int* pnVal);

@DllImport("PROPSYS")
HRESULT PropVariantGetUInt32Elem(const(PROPVARIANT)* propvar, uint iElem, uint* pnVal);

@DllImport("PROPSYS")
HRESULT PropVariantGetInt64Elem(const(PROPVARIANT)* propvar, uint iElem, long* pnVal);

@DllImport("PROPSYS")
HRESULT PropVariantGetUInt64Elem(const(PROPVARIANT)* propvar, uint iElem, ulong* pnVal);

@DllImport("PROPSYS")
HRESULT PropVariantGetDoubleElem(const(PROPVARIANT)* propvar, uint iElem, double* pnVal);

@DllImport("PROPSYS")
HRESULT PropVariantGetFileTimeElem(const(PROPVARIANT)* propvar, uint iElem, FILETIME* pftVal);

@DllImport("PROPSYS")
HRESULT PropVariantGetStringElem(const(PROPVARIANT)* propvar, uint iElem, ushort** ppszVal);

@DllImport("PROPSYS")
void ClearPropVariantArray(char* rgPropVar, uint cVars);

@DllImport("PROPSYS")
int PropVariantCompareEx(const(PROPVARIANT)* propvar1, const(PROPVARIANT)* propvar2, PROPVAR_COMPARE_UNIT unit, 
                         int flags);

@DllImport("PROPSYS")
HRESULT PropVariantChangeType(PROPVARIANT* ppropvarDest, const(PROPVARIANT)* propvarSrc, int flags, ushort vt);

@DllImport("PROPSYS")
HRESULT PropVariantToVariant(const(PROPVARIANT)* pPropVar, VARIANT* pVar);

@DllImport("PROPSYS")
HRESULT VariantToPropVariant(const(VARIANT)* pVar, PROPVARIANT* pPropVar);

@DllImport("PROPSYS")
HRESULT InitVariantFromResource(HINSTANCE hinst, uint id, VARIANT* pvar);

@DllImport("PROPSYS")
HRESULT InitVariantFromBuffer(char* pv, uint cb, VARIANT* pvar);

@DllImport("PROPSYS")
HRESULT InitVariantFromGUIDAsString(const(GUID)* guid, VARIANT* pvar);

@DllImport("PROPSYS")
HRESULT InitVariantFromFileTime(const(FILETIME)* pft, VARIANT* pvar);

@DllImport("PROPSYS")
HRESULT InitVariantFromFileTimeArray(char* prgft, uint cElems, VARIANT* pvar);

@DllImport("PROPSYS")
HRESULT InitVariantFromStrRet(STRRET* pstrret, ITEMIDLIST* pidl, VARIANT* pvar);

@DllImport("PROPSYS")
HRESULT InitVariantFromVariantArrayElem(const(VARIANT)* varIn, uint iElem, VARIANT* pvar);

@DllImport("PROPSYS")
HRESULT InitVariantFromBooleanArray(char* prgf, uint cElems, VARIANT* pvar);

@DllImport("PROPSYS")
HRESULT InitVariantFromInt16Array(char* prgn, uint cElems, VARIANT* pvar);

@DllImport("PROPSYS")
HRESULT InitVariantFromUInt16Array(char* prgn, uint cElems, VARIANT* pvar);

@DllImport("PROPSYS")
HRESULT InitVariantFromInt32Array(char* prgn, uint cElems, VARIANT* pvar);

@DllImport("PROPSYS")
HRESULT InitVariantFromUInt32Array(char* prgn, uint cElems, VARIANT* pvar);

@DllImport("PROPSYS")
HRESULT InitVariantFromInt64Array(char* prgn, uint cElems, VARIANT* pvar);

@DllImport("PROPSYS")
HRESULT InitVariantFromUInt64Array(char* prgn, uint cElems, VARIANT* pvar);

@DllImport("PROPSYS")
HRESULT InitVariantFromDoubleArray(char* prgn, uint cElems, VARIANT* pvar);

@DllImport("PROPSYS")
HRESULT InitVariantFromStringArray(char* prgsz, uint cElems, VARIANT* pvar);

@DllImport("PROPSYS")
BOOL VariantToBooleanWithDefault(const(VARIANT)* varIn, BOOL fDefault);

@DllImport("PROPSYS")
short VariantToInt16WithDefault(const(VARIANT)* varIn, short iDefault);

@DllImport("PROPSYS")
ushort VariantToUInt16WithDefault(const(VARIANT)* varIn, ushort uiDefault);

@DllImport("PROPSYS")
int VariantToInt32WithDefault(const(VARIANT)* varIn, int lDefault);

@DllImport("PROPSYS")
uint VariantToUInt32WithDefault(const(VARIANT)* varIn, uint ulDefault);

@DllImport("PROPSYS")
long VariantToInt64WithDefault(const(VARIANT)* varIn, long llDefault);

@DllImport("PROPSYS")
ulong VariantToUInt64WithDefault(const(VARIANT)* varIn, ulong ullDefault);

@DllImport("PROPSYS")
double VariantToDoubleWithDefault(const(VARIANT)* varIn, double dblDefault);

@DllImport("PROPSYS")
ushort* VariantToStringWithDefault(const(VARIANT)* varIn, const(wchar)* pszDefault);

@DllImport("PROPSYS")
HRESULT VariantToBoolean(const(VARIANT)* varIn, int* pfRet);

@DllImport("PROPSYS")
HRESULT VariantToInt16(const(VARIANT)* varIn, short* piRet);

@DllImport("PROPSYS")
HRESULT VariantToUInt16(const(VARIANT)* varIn, ushort* puiRet);

@DllImport("PROPSYS")
HRESULT VariantToInt32(const(VARIANT)* varIn, int* plRet);

@DllImport("PROPSYS")
HRESULT VariantToUInt32(const(VARIANT)* varIn, uint* pulRet);

@DllImport("PROPSYS")
HRESULT VariantToInt64(const(VARIANT)* varIn, long* pllRet);

@DllImport("PROPSYS")
HRESULT VariantToUInt64(const(VARIANT)* varIn, ulong* pullRet);

@DllImport("PROPSYS")
HRESULT VariantToDouble(const(VARIANT)* varIn, double* pdblRet);

@DllImport("PROPSYS")
HRESULT VariantToBuffer(const(VARIANT)* varIn, char* pv, uint cb);

@DllImport("PROPSYS")
HRESULT VariantToGUID(const(VARIANT)* varIn, GUID* pguid);

@DllImport("PROPSYS")
HRESULT VariantToString(const(VARIANT)* varIn, const(wchar)* pszBuf, uint cchBuf);

@DllImport("PROPSYS")
HRESULT VariantToStringAlloc(const(VARIANT)* varIn, ushort** ppszBuf);

@DllImport("PROPSYS")
HRESULT VariantToDosDateTime(const(VARIANT)* varIn, ushort* pwDate, ushort* pwTime);

@DllImport("PROPSYS")
HRESULT VariantToStrRet(const(VARIANT)* varIn, STRRET* pstrret);

@DllImport("PROPSYS")
HRESULT VariantToFileTime(const(VARIANT)* varIn, int stfOut, FILETIME* pftOut);

@DllImport("PROPSYS")
uint VariantGetElementCount(const(VARIANT)* varIn);

@DllImport("PROPSYS")
HRESULT VariantToBooleanArray(const(VARIANT)* var, char* prgf, uint crgn, uint* pcElem);

@DllImport("PROPSYS")
HRESULT VariantToInt16Array(const(VARIANT)* var, char* prgn, uint crgn, uint* pcElem);

@DllImport("PROPSYS")
HRESULT VariantToUInt16Array(const(VARIANT)* var, char* prgn, uint crgn, uint* pcElem);

@DllImport("PROPSYS")
HRESULT VariantToInt32Array(const(VARIANT)* var, char* prgn, uint crgn, uint* pcElem);

@DllImport("PROPSYS")
HRESULT VariantToUInt32Array(const(VARIANT)* var, char* prgn, uint crgn, uint* pcElem);

@DllImport("PROPSYS")
HRESULT VariantToInt64Array(const(VARIANT)* var, char* prgn, uint crgn, uint* pcElem);

@DllImport("PROPSYS")
HRESULT VariantToUInt64Array(const(VARIANT)* var, char* prgn, uint crgn, uint* pcElem);

@DllImport("PROPSYS")
HRESULT VariantToDoubleArray(const(VARIANT)* var, char* prgn, uint crgn, uint* pcElem);

@DllImport("PROPSYS")
HRESULT VariantToStringArray(const(VARIANT)* var, char* prgsz, uint crgsz, uint* pcElem);

@DllImport("PROPSYS")
HRESULT VariantToBooleanArrayAlloc(const(VARIANT)* var, int** pprgf, uint* pcElem);

@DllImport("PROPSYS")
HRESULT VariantToInt16ArrayAlloc(const(VARIANT)* var, short** pprgn, uint* pcElem);

@DllImport("PROPSYS")
HRESULT VariantToUInt16ArrayAlloc(const(VARIANT)* var, ushort** pprgn, uint* pcElem);

@DllImport("PROPSYS")
HRESULT VariantToInt32ArrayAlloc(const(VARIANT)* var, int** pprgn, uint* pcElem);

@DllImport("PROPSYS")
HRESULT VariantToUInt32ArrayAlloc(const(VARIANT)* var, uint** pprgn, uint* pcElem);

@DllImport("PROPSYS")
HRESULT VariantToInt64ArrayAlloc(const(VARIANT)* var, long** pprgn, uint* pcElem);

@DllImport("PROPSYS")
HRESULT VariantToUInt64ArrayAlloc(const(VARIANT)* var, ulong** pprgn, uint* pcElem);

@DllImport("PROPSYS")
HRESULT VariantToDoubleArrayAlloc(const(VARIANT)* var, double** pprgn, uint* pcElem);

@DllImport("PROPSYS")
HRESULT VariantToStringArrayAlloc(const(VARIANT)* var, ushort*** pprgsz, uint* pcElem);

@DllImport("PROPSYS")
HRESULT VariantGetBooleanElem(const(VARIANT)* var, uint iElem, int* pfVal);

@DllImport("PROPSYS")
HRESULT VariantGetInt16Elem(const(VARIANT)* var, uint iElem, short* pnVal);

@DllImport("PROPSYS")
HRESULT VariantGetUInt16Elem(const(VARIANT)* var, uint iElem, ushort* pnVal);

@DllImport("PROPSYS")
HRESULT VariantGetInt32Elem(const(VARIANT)* var, uint iElem, int* pnVal);

@DllImport("PROPSYS")
HRESULT VariantGetUInt32Elem(const(VARIANT)* var, uint iElem, uint* pnVal);

@DllImport("PROPSYS")
HRESULT VariantGetInt64Elem(const(VARIANT)* var, uint iElem, long* pnVal);

@DllImport("PROPSYS")
HRESULT VariantGetUInt64Elem(const(VARIANT)* var, uint iElem, ulong* pnVal);

@DllImport("PROPSYS")
HRESULT VariantGetDoubleElem(const(VARIANT)* var, uint iElem, double* pnVal);

@DllImport("PROPSYS")
HRESULT VariantGetStringElem(const(VARIANT)* var, uint iElem, ushort** ppszVal);

@DllImport("PROPSYS")
void ClearVariantArray(char* pvars, uint cvars);

@DllImport("PROPSYS")
int VariantCompare(const(VARIANT)* var1, const(VARIANT)* var2);

@DllImport("SHELL32")
HRESULT SHGetPropertyStoreForWindow(HWND hwnd, const(GUID)* riid, void** ppv);

@DllImport("SHELL32")
HRESULT SHGetPropertyStoreFromIDList(ITEMIDLIST* pidl, GETPROPERTYSTOREFLAGS flags, const(GUID)* riid, void** ppv);

@DllImport("SHELL32")
HRESULT SHGetPropertyStoreFromParsingName(const(wchar)* pszPath, IBindCtx pbc, GETPROPERTYSTOREFLAGS flags, 
                                          const(GUID)* riid, void** ppv);

@DllImport("SHELL32")
HRESULT SHAddDefaultPropertiesByExt(const(wchar)* pszExt, IPropertyStore pPropStore);

@DllImport("SHELL32")
HANDLE PifMgr_OpenProperties(const(wchar)* pszApp, const(wchar)* pszPIF, uint hInf, uint flOpt);

@DllImport("SHELL32")
int PifMgr_GetProperties(HANDLE hProps, const(char)* pszGroup, char* lpProps, int cbProps, uint flOpt);

@DllImport("SHELL32")
int PifMgr_SetProperties(HANDLE hProps, const(char)* pszGroup, char* lpProps, int cbProps, uint flOpt);

@DllImport("SHELL32")
HANDLE PifMgr_CloseProperties(HANDLE hProps, uint flOpt);

@DllImport("SHELL32")
HRESULT SHPropStgCreate(IPropertySetStorage psstg, const(GUID)* fmtid, const(GUID)* pclsid, uint grfFlags, 
                        uint grfMode, uint dwDisposition, IPropertyStorage* ppstg, uint* puCodePage);

@DllImport("SHELL32")
HRESULT SHPropStgReadMultiple(IPropertyStorage pps, uint uCodePage, uint cpspec, char* rgpspec, char* rgvar);

@DllImport("SHELL32")
HRESULT SHPropStgWriteMultiple(IPropertyStorage pps, uint* puCodePage, uint cpspec, char* rgpspec, char* rgvar, 
                               uint propidNameFirst);


// Interfaces

@GUID("9A02E012-6303-4E1E-B9A1-630F802592C5")
struct InMemoryPropertyStore;

@GUID("D4CA0E2D-6DA7-4B75-A97C-5F306F0EAEDC")
struct InMemoryPropertyStoreMarshalByValue;

@GUID("B8967F85-58AE-4F46-9FB2-5D7904798F4B")
struct PropertySystem;

@GUID("F917BC8A-1BBA-4478-A245-1BDE03EB9431")
interface IPropertyChange : IObjectWithPropertyKey
{
    HRESULT ApplyToPropVariant(const(PROPVARIANT)* propvarIn, PROPVARIANT* ppropvarOut);
}

@GUID("380F5CAD-1B5E-42F2-805D-637FD392D31E")
interface IPropertyChangeArray : IUnknown
{
    HRESULT GetCount(uint* pcOperations);
    HRESULT GetAt(uint iIndex, const(GUID)* riid, void** ppv);
    HRESULT InsertAt(uint iIndex, IPropertyChange ppropChange);
    HRESULT Append(IPropertyChange ppropChange);
    HRESULT AppendOrReplace(IPropertyChange ppropChange);
    HRESULT RemoveAt(uint iIndex);
    HRESULT IsKeyInArray(const(PROPERTYKEY)* key);
}

@GUID("C8E2D566-186E-4D49-BF41-6909EAD56ACC")
interface IPropertyStoreCapabilities : IUnknown
{
    HRESULT IsPropertyWritable(const(PROPERTYKEY)* key);
}

@GUID("3017056D-9A91-4E90-937D-746C72ABBF4F")
interface IPropertyStoreCache : IPropertyStore
{
    HRESULT GetState(const(PROPERTYKEY)* key, PSC_STATE* pstate);
    HRESULT GetValueAndState(const(PROPERTYKEY)* key, PROPVARIANT* ppropvar, PSC_STATE* pstate);
    HRESULT SetState(const(PROPERTYKEY)* key, PSC_STATE state);
    HRESULT SetValueAndState(const(PROPERTYKEY)* key, const(PROPVARIANT)* ppropvar, PSC_STATE state);
}

@GUID("11E1FBF9-2D56-4A6B-8DB3-7CD193A471F2")
interface IPropertyEnumType : IUnknown
{
    HRESULT GetEnumType(PROPENUMTYPE* penumtype);
    HRESULT GetValue(PROPVARIANT* ppropvar);
    HRESULT GetRangeMinValue(PROPVARIANT* ppropvarMin);
    HRESULT GetRangeSetValue(PROPVARIANT* ppropvarSet);
    HRESULT GetDisplayText(ushort** ppszDisplay);
}

@GUID("9B6E051C-5DDD-4321-9070-FE2ACB55E794")
interface IPropertyEnumType2 : IPropertyEnumType
{
    HRESULT GetImageReference(ushort** ppszImageRes);
}

@GUID("A99400F4-3D84-4557-94BA-1242FB2CC9A6")
interface IPropertyEnumTypeList : IUnknown
{
    HRESULT GetCount(uint* pctypes);
    HRESULT GetAt(uint itype, const(GUID)* riid, void** ppv);
    HRESULT GetConditionAt(uint nIndex, const(GUID)* riid, void** ppv);
    HRESULT FindMatchingIndex(const(PROPVARIANT)* propvarCmp, uint* pnIndex);
}

@GUID("6F79D558-3E96-4549-A1D1-7D75D2288814")
interface IPropertyDescription : IUnknown
{
    HRESULT GetPropertyKey(PROPERTYKEY* pkey);
    HRESULT GetCanonicalName(ushort** ppszName);
    HRESULT GetPropertyType(ushort* pvartype);
    HRESULT GetDisplayName(ushort** ppszName);
    HRESULT GetEditInvitation(ushort** ppszInvite);
    HRESULT GetTypeFlags(PROPDESC_TYPE_FLAGS mask, PROPDESC_TYPE_FLAGS* ppdtFlags);
    HRESULT GetViewFlags(PROPDESC_VIEW_FLAGS* ppdvFlags);
    HRESULT GetDefaultColumnWidth(uint* pcxChars);
    HRESULT GetDisplayType(PROPDESC_DISPLAYTYPE* pdisplaytype);
    HRESULT GetColumnState(uint* pcsFlags);
    HRESULT GetGroupingRange(PROPDESC_GROUPING_RANGE* pgr);
    HRESULT GetRelativeDescriptionType(PROPDESC_RELATIVEDESCRIPTION_TYPE* prdt);
    HRESULT GetRelativeDescription(const(PROPVARIANT)* propvar1, const(PROPVARIANT)* propvar2, ushort** ppszDesc1, 
                                   ushort** ppszDesc2);
    HRESULT GetSortDescription(PROPDESC_SORTDESCRIPTION* psd);
    HRESULT GetSortDescriptionLabel(BOOL fDescending, ushort** ppszDescription);
    HRESULT GetAggregationType(PROPDESC_AGGREGATION_TYPE* paggtype);
    HRESULT GetConditionType(PROPDESC_CONDITION_TYPE* pcontype, CONDITION_OPERATION* popDefault);
    HRESULT GetEnumTypeList(const(GUID)* riid, void** ppv);
    HRESULT CoerceToCanonicalValue(PROPVARIANT* ppropvar);
    HRESULT FormatForDisplay(const(PROPVARIANT)* propvar, PROPDESC_FORMAT_FLAGS pdfFlags, ushort** ppszDisplay);
    HRESULT IsValueCanonical(const(PROPVARIANT)* propvar);
}

@GUID("57D2EDED-5062-400E-B107-5DAE79FE57A6")
interface IPropertyDescription2 : IPropertyDescription
{
    HRESULT GetImageReferenceForValue(const(PROPVARIANT)* propvar, ushort** ppszImageRes);
}

@GUID("F67104FC-2AF9-46FD-B32D-243C1404F3D1")
interface IPropertyDescriptionAliasInfo : IPropertyDescription
{
    HRESULT GetSortByAlias(const(GUID)* riid, void** ppv);
    HRESULT GetAdditionalSortByAliases(const(GUID)* riid, void** ppv);
}

@GUID("078F91BD-29A2-440F-924E-46A291524520")
interface IPropertyDescriptionSearchInfo : IPropertyDescription
{
    HRESULT GetSearchInfoFlags(PROPDESC_SEARCHINFO_FLAGS* ppdsiFlags);
    HRESULT GetColumnIndexType(PROPDESC_COLUMNINDEX_TYPE* ppdciType);
    HRESULT GetProjectionString(ushort** ppszProjection);
    HRESULT GetMaxSize(uint* pcbMaxSize);
}

@GUID("507393F4-2A3D-4A60-B59E-D9C75716C2DD")
interface IPropertyDescriptionRelatedPropertyInfo : IPropertyDescription
{
    HRESULT GetRelatedProperty(const(wchar)* pszRelationshipName, const(GUID)* riid, void** ppv);
}

@GUID("CA724E8A-C3E6-442B-88A4-6FB0DB8035A3")
interface IPropertySystem : IUnknown
{
    HRESULT GetPropertyDescription(const(PROPERTYKEY)* propkey, const(GUID)* riid, void** ppv);
    HRESULT GetPropertyDescriptionByName(const(wchar)* pszCanonicalName, const(GUID)* riid, void** ppv);
    HRESULT GetPropertyDescriptionListFromString(const(wchar)* pszPropList, const(GUID)* riid, void** ppv);
    HRESULT EnumeratePropertyDescriptions(PROPDESC_ENUMFILTER filterOn, const(GUID)* riid, void** ppv);
    HRESULT FormatForDisplay(const(PROPERTYKEY)* key, const(PROPVARIANT)* propvar, PROPDESC_FORMAT_FLAGS pdff, 
                             const(wchar)* pszText, uint cchText);
    HRESULT FormatForDisplayAlloc(const(PROPERTYKEY)* key, const(PROPVARIANT)* propvar, PROPDESC_FORMAT_FLAGS pdff, 
                                  ushort** ppszDisplay);
    HRESULT RegisterPropertySchema(const(wchar)* pszPath);
    HRESULT UnregisterPropertySchema(const(wchar)* pszPath);
    HRESULT RefreshPropertySchema();
}

@GUID("1F9FC1D0-C39B-4B26-817F-011967D3440E")
interface IPropertyDescriptionList : IUnknown
{
    HRESULT GetCount(uint* pcElem);
    HRESULT GetAt(uint iElem, const(GUID)* riid, void** ppv);
}

@GUID("BC110B6D-57E8-4148-A9C6-91015AB2F3A5")
interface IPropertyStoreFactory : IUnknown
{
    HRESULT GetPropertyStore(GETPROPERTYSTOREFLAGS flags, IUnknown pUnkFactory, const(GUID)* riid, void** ppv);
    HRESULT GetPropertyStoreForKeys(const(PROPERTYKEY)* rgKeys, uint cKeys, GETPROPERTYSTOREFLAGS flags, 
                                    const(GUID)* riid, void** ppv);
}

@GUID("FA955FD9-38BE-4879-A6CE-824CF52D609F")
interface IPropertySystemChangeNotify : IUnknown
{
    HRESULT SchemaRefreshed();
}

@GUID("757A7D9F-919A-4118-99D7-DBB208C8CC66")
interface IPropertyUI : IUnknown
{
    HRESULT ParsePropertyName(const(wchar)* pszName, GUID* pfmtid, uint* ppid, uint* pchEaten);
    HRESULT GetCannonicalName(const(GUID)* fmtid, uint pid, const(wchar)* pwszText, uint cchText);
    HRESULT GetDisplayName(const(GUID)* fmtid, uint pid, uint flags, const(wchar)* pwszText, uint cchText);
    HRESULT GetPropertyDescription(const(GUID)* fmtid, uint pid, const(wchar)* pwszText, uint cchText);
    HRESULT GetDefaultWidth(const(GUID)* fmtid, uint pid, uint* pcxChars);
    HRESULT GetFlags(const(GUID)* fmtid, uint pid, uint* pflags);
    HRESULT FormatForDisplay(const(GUID)* fmtid, uint pid, const(PROPVARIANT)* ppropvar, uint puiff, 
                             const(wchar)* pwszText, uint cchText);
    HRESULT GetHelpInfo(const(GUID)* fmtid, uint pid, const(wchar)* pwszHelpFile, uint cch, uint* puHelpID);
}


// GUIDs

const GUID CLSID_InMemoryPropertyStore               = GUIDOF!InMemoryPropertyStore;
const GUID CLSID_InMemoryPropertyStoreMarshalByValue = GUIDOF!InMemoryPropertyStoreMarshalByValue;
const GUID CLSID_PropertySystem                      = GUIDOF!PropertySystem;

const GUID IID_IPropertyChange                         = GUIDOF!IPropertyChange;
const GUID IID_IPropertyChangeArray                    = GUIDOF!IPropertyChangeArray;
const GUID IID_IPropertyDescription                    = GUIDOF!IPropertyDescription;
const GUID IID_IPropertyDescription2                   = GUIDOF!IPropertyDescription2;
const GUID IID_IPropertyDescriptionAliasInfo           = GUIDOF!IPropertyDescriptionAliasInfo;
const GUID IID_IPropertyDescriptionList                = GUIDOF!IPropertyDescriptionList;
const GUID IID_IPropertyDescriptionRelatedPropertyInfo = GUIDOF!IPropertyDescriptionRelatedPropertyInfo;
const GUID IID_IPropertyDescriptionSearchInfo          = GUIDOF!IPropertyDescriptionSearchInfo;
const GUID IID_IPropertyEnumType                       = GUIDOF!IPropertyEnumType;
const GUID IID_IPropertyEnumType2                      = GUIDOF!IPropertyEnumType2;
const GUID IID_IPropertyEnumTypeList                   = GUIDOF!IPropertyEnumTypeList;
const GUID IID_IPropertyStoreCache                     = GUIDOF!IPropertyStoreCache;
const GUID IID_IPropertyStoreCapabilities              = GUIDOF!IPropertyStoreCapabilities;
const GUID IID_IPropertyStoreFactory                   = GUIDOF!IPropertyStoreFactory;
const GUID IID_IPropertySystem                         = GUIDOF!IPropertySystem;
const GUID IID_IPropertySystemChangeNotify             = GUIDOF!IPropertySystemChangeNotify;
const GUID IID_IPropertyUI                             = GUIDOF!IPropertyUI;
