module windows.windowspropertiessystem;

public import system;
public import windows.audio;
public import windows.automation;
public import windows.com;
public import windows.displaydevices;
public import windows.search;
public import windows.shell;
public import windows.structuredstorage;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

struct PROPERTYKEY
{
    Guid fmtid;
    uint pid;
}

const GUID CLSID_InMemoryPropertyStore = {0x9A02E012, 0x6303, 0x4E1E, [0xB9, 0xA1, 0x63, 0x0F, 0x80, 0x25, 0x92, 0xC5]};
@GUID(0x9A02E012, 0x6303, 0x4E1E, [0xB9, 0xA1, 0x63, 0x0F, 0x80, 0x25, 0x92, 0xC5]);
struct InMemoryPropertyStore;

const GUID CLSID_InMemoryPropertyStoreMarshalByValue = {0xD4CA0E2D, 0x6DA7, 0x4B75, [0xA9, 0x7C, 0x5F, 0x30, 0x6F, 0x0E, 0xAE, 0xDC]};
@GUID(0xD4CA0E2D, 0x6DA7, 0x4B75, [0xA9, 0x7C, 0x5F, 0x30, 0x6F, 0x0E, 0xAE, 0xDC]);
struct InMemoryPropertyStoreMarshalByValue;

const GUID CLSID_PropertySystem = {0xB8967F85, 0x58AE, 0x4F46, [0x9F, 0xB2, 0x5D, 0x79, 0x04, 0x79, 0x8F, 0x4B]};
@GUID(0xB8967F85, 0x58AE, 0x4F46, [0x9F, 0xB2, 0x5D, 0x79, 0x04, 0x79, 0x8F, 0x4B]);
struct PropertySystem;

enum GETPROPERTYSTOREFLAGS
{
    GPS_DEFAULT = 0,
    GPS_HANDLERPROPERTIESONLY = 1,
    GPS_READWRITE = 2,
    GPS_TEMPORARY = 4,
    GPS_FASTPROPERTIESONLY = 8,
    GPS_OPENSLOWITEM = 16,
    GPS_DELAYCREATION = 32,
    GPS_BESTEFFORT = 64,
    GPS_NO_OPLOCK = 128,
    GPS_PREFERQUERYPROPERTIES = 256,
    GPS_EXTRINSICPROPERTIES = 512,
    GPS_EXTRINSICPROPERTIESONLY = 1024,
    GPS_VOLATILEPROPERTIES = 2048,
    GPS_VOLATILEPROPERTIESONLY = 4096,
    GPS_MASK_VALID = 8191,
}

enum PKA_FLAGS
{
    PKA_SET = 0,
    PKA_APPEND = 1,
    PKA_DELETE = 2,
}

const GUID IID_IPropertyChange = {0xF917BC8A, 0x1BBA, 0x4478, [0xA2, 0x45, 0x1B, 0xDE, 0x03, 0xEB, 0x94, 0x31]};
@GUID(0xF917BC8A, 0x1BBA, 0x4478, [0xA2, 0x45, 0x1B, 0xDE, 0x03, 0xEB, 0x94, 0x31]);
interface IPropertyChange : IObjectWithPropertyKey
{
    HRESULT ApplyToPropVariant(const(PROPVARIANT)* propvarIn, PROPVARIANT* ppropvarOut);
}

const GUID IID_IPropertyChangeArray = {0x380F5CAD, 0x1B5E, 0x42F2, [0x80, 0x5D, 0x63, 0x7F, 0xD3, 0x92, 0xD3, 0x1E]};
@GUID(0x380F5CAD, 0x1B5E, 0x42F2, [0x80, 0x5D, 0x63, 0x7F, 0xD3, 0x92, 0xD3, 0x1E]);
interface IPropertyChangeArray : IUnknown
{
    HRESULT GetCount(uint* pcOperations);
    HRESULT GetAt(uint iIndex, const(Guid)* riid, void** ppv);
    HRESULT InsertAt(uint iIndex, IPropertyChange ppropChange);
    HRESULT Append(IPropertyChange ppropChange);
    HRESULT AppendOrReplace(IPropertyChange ppropChange);
    HRESULT RemoveAt(uint iIndex);
    HRESULT IsKeyInArray(const(PROPERTYKEY)* key);
}

const GUID IID_IPropertyStoreCapabilities = {0xC8E2D566, 0x186E, 0x4D49, [0xBF, 0x41, 0x69, 0x09, 0xEA, 0xD5, 0x6A, 0xCC]};
@GUID(0xC8E2D566, 0x186E, 0x4D49, [0xBF, 0x41, 0x69, 0x09, 0xEA, 0xD5, 0x6A, 0xCC]);
interface IPropertyStoreCapabilities : IUnknown
{
    HRESULT IsPropertyWritable(const(PROPERTYKEY)* key);
}

enum PSC_STATE
{
    PSC_NORMAL = 0,
    PSC_NOTINSOURCE = 1,
    PSC_DIRTY = 2,
    PSC_READONLY = 3,
}

const GUID IID_IPropertyStoreCache = {0x3017056D, 0x9A91, 0x4E90, [0x93, 0x7D, 0x74, 0x6C, 0x72, 0xAB, 0xBF, 0x4F]};
@GUID(0x3017056D, 0x9A91, 0x4E90, [0x93, 0x7D, 0x74, 0x6C, 0x72, 0xAB, 0xBF, 0x4F]);
interface IPropertyStoreCache : IPropertyStore
{
    HRESULT GetState(const(PROPERTYKEY)* key, PSC_STATE* pstate);
    HRESULT GetValueAndState(const(PROPERTYKEY)* key, PROPVARIANT* ppropvar, PSC_STATE* pstate);
    HRESULT SetState(const(PROPERTYKEY)* key, PSC_STATE state);
    HRESULT SetValueAndState(const(PROPERTYKEY)* key, const(PROPVARIANT)* ppropvar, PSC_STATE state);
}

enum PROPENUMTYPE
{
    PET_DISCRETEVALUE = 0,
    PET_RANGEDVALUE = 1,
    PET_DEFAULTVALUE = 2,
    PET_ENDRANGE = 3,
}

const GUID IID_IPropertyEnumType = {0x11E1FBF9, 0x2D56, 0x4A6B, [0x8D, 0xB3, 0x7C, 0xD1, 0x93, 0xA4, 0x71, 0xF2]};
@GUID(0x11E1FBF9, 0x2D56, 0x4A6B, [0x8D, 0xB3, 0x7C, 0xD1, 0x93, 0xA4, 0x71, 0xF2]);
interface IPropertyEnumType : IUnknown
{
    HRESULT GetEnumType(PROPENUMTYPE* penumtype);
    HRESULT GetValue(PROPVARIANT* ppropvar);
    HRESULT GetRangeMinValue(PROPVARIANT* ppropvarMin);
    HRESULT GetRangeSetValue(PROPVARIANT* ppropvarSet);
    HRESULT GetDisplayText(ushort** ppszDisplay);
}

const GUID IID_IPropertyEnumType2 = {0x9B6E051C, 0x5DDD, 0x4321, [0x90, 0x70, 0xFE, 0x2A, 0xCB, 0x55, 0xE7, 0x94]};
@GUID(0x9B6E051C, 0x5DDD, 0x4321, [0x90, 0x70, 0xFE, 0x2A, 0xCB, 0x55, 0xE7, 0x94]);
interface IPropertyEnumType2 : IPropertyEnumType
{
    HRESULT GetImageReference(ushort** ppszImageRes);
}

const GUID IID_IPropertyEnumTypeList = {0xA99400F4, 0x3D84, 0x4557, [0x94, 0xBA, 0x12, 0x42, 0xFB, 0x2C, 0xC9, 0xA6]};
@GUID(0xA99400F4, 0x3D84, 0x4557, [0x94, 0xBA, 0x12, 0x42, 0xFB, 0x2C, 0xC9, 0xA6]);
interface IPropertyEnumTypeList : IUnknown
{
    HRESULT GetCount(uint* pctypes);
    HRESULT GetAt(uint itype, const(Guid)* riid, void** ppv);
    HRESULT GetConditionAt(uint nIndex, const(Guid)* riid, void** ppv);
    HRESULT FindMatchingIndex(const(PROPVARIANT)* propvarCmp, uint* pnIndex);
}

enum PROPDESC_TYPE_FLAGS
{
    PDTF_DEFAULT = 0,
    PDTF_MULTIPLEVALUES = 1,
    PDTF_ISINNATE = 2,
    PDTF_ISGROUP = 4,
    PDTF_CANGROUPBY = 8,
    PDTF_CANSTACKBY = 16,
    PDTF_ISTREEPROPERTY = 32,
    PDTF_INCLUDEINFULLTEXTQUERY = 64,
    PDTF_ISVIEWABLE = 128,
    PDTF_ISQUERYABLE = 256,
    PDTF_CANBEPURGED = 512,
    PDTF_SEARCHRAWVALUE = 1024,
    PDTF_DONTCOERCEEMPTYSTRINGS = 2048,
    PDTF_ALWAYSINSUPPLEMENTALSTORE = 4096,
    PDTF_ISSYSTEMPROPERTY = -2147483648,
    PDTF_MASK_ALL = -2147475457,
}

enum PROPDESC_VIEW_FLAGS
{
    PDVF_DEFAULT = 0,
    PDVF_CENTERALIGN = 1,
    PDVF_RIGHTALIGN = 2,
    PDVF_BEGINNEWGROUP = 4,
    PDVF_FILLAREA = 8,
    PDVF_SORTDESCENDING = 16,
    PDVF_SHOWONLYIFPRESENT = 32,
    PDVF_SHOWBYDEFAULT = 64,
    PDVF_SHOWINPRIMARYLIST = 128,
    PDVF_SHOWINSECONDARYLIST = 256,
    PDVF_HIDELABEL = 512,
    PDVF_HIDDEN = 2048,
    PDVF_CANWRAP = 4096,
    PDVF_MASK_ALL = 7167,
}

enum PROPDESC_DISPLAYTYPE
{
    PDDT_STRING = 0,
    PDDT_NUMBER = 1,
    PDDT_BOOLEAN = 2,
    PDDT_DATETIME = 3,
    PDDT_ENUMERATED = 4,
}

enum PROPDESC_GROUPING_RANGE
{
    PDGR_DISCRETE = 0,
    PDGR_ALPHANUMERIC = 1,
    PDGR_SIZE = 2,
    PDGR_DYNAMIC = 3,
    PDGR_DATE = 4,
    PDGR_PERCENT = 5,
    PDGR_ENUMERATED = 6,
}

enum PROPDESC_FORMAT_FLAGS
{
    PDFF_DEFAULT = 0,
    PDFF_PREFIXNAME = 1,
    PDFF_FILENAME = 2,
    PDFF_ALWAYSKB = 4,
    PDFF_RESERVED_RIGHTTOLEFT = 8,
    PDFF_SHORTTIME = 16,
    PDFF_LONGTIME = 32,
    PDFF_HIDETIME = 64,
    PDFF_SHORTDATE = 128,
    PDFF_LONGDATE = 256,
    PDFF_HIDEDATE = 512,
    PDFF_RELATIVEDATE = 1024,
    PDFF_USEEDITINVITATION = 2048,
    PDFF_READONLY = 4096,
    PDFF_NOAUTOREADINGORDER = 8192,
}

enum PROPDESC_SORTDESCRIPTION
{
    PDSD_GENERAL = 0,
    PDSD_A_Z = 1,
    PDSD_LOWEST_HIGHEST = 2,
    PDSD_SMALLEST_BIGGEST = 3,
    PDSD_OLDEST_NEWEST = 4,
}

enum PROPDESC_RELATIVEDESCRIPTION_TYPE
{
    PDRDT_GENERAL = 0,
    PDRDT_DATE = 1,
    PDRDT_SIZE = 2,
    PDRDT_COUNT = 3,
    PDRDT_REVISION = 4,
    PDRDT_LENGTH = 5,
    PDRDT_DURATION = 6,
    PDRDT_SPEED = 7,
    PDRDT_RATE = 8,
    PDRDT_RATING = 9,
    PDRDT_PRIORITY = 10,
}

enum PROPDESC_AGGREGATION_TYPE
{
    PDAT_DEFAULT = 0,
    PDAT_FIRST = 1,
    PDAT_SUM = 2,
    PDAT_AVERAGE = 3,
    PDAT_DATERANGE = 4,
    PDAT_UNION = 5,
    PDAT_MAX = 6,
    PDAT_MIN = 7,
}

enum PROPDESC_CONDITION_TYPE
{
    PDCOT_NONE = 0,
    PDCOT_STRING = 1,
    PDCOT_SIZE = 2,
    PDCOT_DATETIME = 3,
    PDCOT_BOOLEAN = 4,
    PDCOT_NUMBER = 5,
}

const GUID IID_IPropertyDescription = {0x6F79D558, 0x3E96, 0x4549, [0xA1, 0xD1, 0x7D, 0x75, 0xD2, 0x28, 0x88, 0x14]};
@GUID(0x6F79D558, 0x3E96, 0x4549, [0xA1, 0xD1, 0x7D, 0x75, 0xD2, 0x28, 0x88, 0x14]);
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
    HRESULT GetRelativeDescription(const(PROPVARIANT)* propvar1, const(PROPVARIANT)* propvar2, ushort** ppszDesc1, ushort** ppszDesc2);
    HRESULT GetSortDescription(PROPDESC_SORTDESCRIPTION* psd);
    HRESULT GetSortDescriptionLabel(BOOL fDescending, ushort** ppszDescription);
    HRESULT GetAggregationType(PROPDESC_AGGREGATION_TYPE* paggtype);
    HRESULT GetConditionType(PROPDESC_CONDITION_TYPE* pcontype, CONDITION_OPERATION* popDefault);
    HRESULT GetEnumTypeList(const(Guid)* riid, void** ppv);
    HRESULT CoerceToCanonicalValue(PROPVARIANT* ppropvar);
    HRESULT FormatForDisplay(const(PROPVARIANT)* propvar, PROPDESC_FORMAT_FLAGS pdfFlags, ushort** ppszDisplay);
    HRESULT IsValueCanonical(const(PROPVARIANT)* propvar);
}

const GUID IID_IPropertyDescription2 = {0x57D2EDED, 0x5062, 0x400E, [0xB1, 0x07, 0x5D, 0xAE, 0x79, 0xFE, 0x57, 0xA6]};
@GUID(0x57D2EDED, 0x5062, 0x400E, [0xB1, 0x07, 0x5D, 0xAE, 0x79, 0xFE, 0x57, 0xA6]);
interface IPropertyDescription2 : IPropertyDescription
{
    HRESULT GetImageReferenceForValue(const(PROPVARIANT)* propvar, ushort** ppszImageRes);
}

const GUID IID_IPropertyDescriptionAliasInfo = {0xF67104FC, 0x2AF9, 0x46FD, [0xB3, 0x2D, 0x24, 0x3C, 0x14, 0x04, 0xF3, 0xD1]};
@GUID(0xF67104FC, 0x2AF9, 0x46FD, [0xB3, 0x2D, 0x24, 0x3C, 0x14, 0x04, 0xF3, 0xD1]);
interface IPropertyDescriptionAliasInfo : IPropertyDescription
{
    HRESULT GetSortByAlias(const(Guid)* riid, void** ppv);
    HRESULT GetAdditionalSortByAliases(const(Guid)* riid, void** ppv);
}

enum PROPDESC_SEARCHINFO_FLAGS
{
    PDSIF_DEFAULT = 0,
    PDSIF_ININVERTEDINDEX = 1,
    PDSIF_ISCOLUMN = 2,
    PDSIF_ISCOLUMNSPARSE = 4,
    PDSIF_ALWAYSINCLUDE = 8,
    PDSIF_USEFORTYPEAHEAD = 16,
}

enum PROPDESC_COLUMNINDEX_TYPE
{
    PDCIT_NONE = 0,
    PDCIT_ONDISK = 1,
    PDCIT_INMEMORY = 2,
    PDCIT_ONDEMAND = 3,
    PDCIT_ONDISKALL = 4,
    PDCIT_ONDISKVECTOR = 5,
}

const GUID IID_IPropertyDescriptionSearchInfo = {0x078F91BD, 0x29A2, 0x440F, [0x92, 0x4E, 0x46, 0xA2, 0x91, 0x52, 0x45, 0x20]};
@GUID(0x078F91BD, 0x29A2, 0x440F, [0x92, 0x4E, 0x46, 0xA2, 0x91, 0x52, 0x45, 0x20]);
interface IPropertyDescriptionSearchInfo : IPropertyDescription
{
    HRESULT GetSearchInfoFlags(PROPDESC_SEARCHINFO_FLAGS* ppdsiFlags);
    HRESULT GetColumnIndexType(PROPDESC_COLUMNINDEX_TYPE* ppdciType);
    HRESULT GetProjectionString(ushort** ppszProjection);
    HRESULT GetMaxSize(uint* pcbMaxSize);
}

const GUID IID_IPropertyDescriptionRelatedPropertyInfo = {0x507393F4, 0x2A3D, 0x4A60, [0xB5, 0x9E, 0xD9, 0xC7, 0x57, 0x16, 0xC2, 0xDD]};
@GUID(0x507393F4, 0x2A3D, 0x4A60, [0xB5, 0x9E, 0xD9, 0xC7, 0x57, 0x16, 0xC2, 0xDD]);
interface IPropertyDescriptionRelatedPropertyInfo : IPropertyDescription
{
    HRESULT GetRelatedProperty(const(wchar)* pszRelationshipName, const(Guid)* riid, void** ppv);
}

enum PROPDESC_ENUMFILTER
{
    PDEF_ALL = 0,
    PDEF_SYSTEM = 1,
    PDEF_NONSYSTEM = 2,
    PDEF_VIEWABLE = 3,
    PDEF_QUERYABLE = 4,
    PDEF_INFULLTEXTQUERY = 5,
    PDEF_COLUMN = 6,
}

const GUID IID_IPropertySystem = {0xCA724E8A, 0xC3E6, 0x442B, [0x88, 0xA4, 0x6F, 0xB0, 0xDB, 0x80, 0x35, 0xA3]};
@GUID(0xCA724E8A, 0xC3E6, 0x442B, [0x88, 0xA4, 0x6F, 0xB0, 0xDB, 0x80, 0x35, 0xA3]);
interface IPropertySystem : IUnknown
{
    HRESULT GetPropertyDescription(const(PROPERTYKEY)* propkey, const(Guid)* riid, void** ppv);
    HRESULT GetPropertyDescriptionByName(const(wchar)* pszCanonicalName, const(Guid)* riid, void** ppv);
    HRESULT GetPropertyDescriptionListFromString(const(wchar)* pszPropList, const(Guid)* riid, void** ppv);
    HRESULT EnumeratePropertyDescriptions(PROPDESC_ENUMFILTER filterOn, const(Guid)* riid, void** ppv);
    HRESULT FormatForDisplay(const(PROPERTYKEY)* key, const(PROPVARIANT)* propvar, PROPDESC_FORMAT_FLAGS pdff, const(wchar)* pszText, uint cchText);
    HRESULT FormatForDisplayAlloc(const(PROPERTYKEY)* key, const(PROPVARIANT)* propvar, PROPDESC_FORMAT_FLAGS pdff, ushort** ppszDisplay);
    HRESULT RegisterPropertySchema(const(wchar)* pszPath);
    HRESULT UnregisterPropertySchema(const(wchar)* pszPath);
    HRESULT RefreshPropertySchema();
}

const GUID IID_IPropertyDescriptionList = {0x1F9FC1D0, 0xC39B, 0x4B26, [0x81, 0x7F, 0x01, 0x19, 0x67, 0xD3, 0x44, 0x0E]};
@GUID(0x1F9FC1D0, 0xC39B, 0x4B26, [0x81, 0x7F, 0x01, 0x19, 0x67, 0xD3, 0x44, 0x0E]);
interface IPropertyDescriptionList : IUnknown
{
    HRESULT GetCount(uint* pcElem);
    HRESULT GetAt(uint iElem, const(Guid)* riid, void** ppv);
}

const GUID IID_IPropertyStoreFactory = {0xBC110B6D, 0x57E8, 0x4148, [0xA9, 0xC6, 0x91, 0x01, 0x5A, 0xB2, 0xF3, 0xA5]};
@GUID(0xBC110B6D, 0x57E8, 0x4148, [0xA9, 0xC6, 0x91, 0x01, 0x5A, 0xB2, 0xF3, 0xA5]);
interface IPropertyStoreFactory : IUnknown
{
    HRESULT GetPropertyStore(GETPROPERTYSTOREFLAGS flags, IUnknown pUnkFactory, const(Guid)* riid, void** ppv);
    HRESULT GetPropertyStoreForKeys(const(PROPERTYKEY)* rgKeys, uint cKeys, GETPROPERTYSTOREFLAGS flags, const(Guid)* riid, void** ppv);
}

enum _PERSIST_SPROPSTORE_FLAGS
{
    FPSPS_DEFAULT = 0,
    FPSPS_READONLY = 1,
    FPSPS_TREAT_NEW_VALUES_AS_DIRTY = 2,
}

struct SERIALIZEDPROPSTORAGE
{
}

const GUID IID_IPropertySystemChangeNotify = {0xFA955FD9, 0x38BE, 0x4879, [0xA6, 0xCE, 0x82, 0x4C, 0xF5, 0x2D, 0x60, 0x9F]};
@GUID(0xFA955FD9, 0x38BE, 0x4879, [0xA6, 0xCE, 0x82, 0x4C, 0xF5, 0x2D, 0x60, 0x9F]);
interface IPropertySystemChangeNotify : IUnknown
{
    HRESULT SchemaRefreshed();
}

enum tagPSTIME_FLAGS
{
    PSTF_UTC = 0,
    PSTF_LOCAL = 1,
}

enum PROPVAR_COMPARE_UNIT
{
    PVCU_DEFAULT = 0,
    PVCU_SECOND = 1,
    PVCU_MINUTE = 2,
    PVCU_HOUR = 3,
    PVCU_DAY = 4,
    PVCU_MONTH = 5,
    PVCU_YEAR = 6,
}

enum tagPROPVAR_COMPARE_FLAGS
{
    PVCF_DEFAULT = 0,
    PVCF_TREATEMPTYASGREATERTHAN = 1,
    PVCF_USESTRCMP = 2,
    PVCF_USESTRCMPC = 4,
    PVCF_USESTRCMPI = 8,
    PVCF_USESTRCMPIC = 16,
    PVCF_DIGITSASNUMBERS_CASESENSITIVE = 32,
}

enum tagPROPVAR_CHANGE_FLAGS
{
    PVCHF_DEFAULT = 0,
    PVCHF_NOVALUEPROP = 1,
    PVCHF_ALPHABOOL = 2,
    PVCHF_NOUSEROVERRIDE = 4,
    PVCHF_LOCALBOOL = 8,
    PVCHF_NOHEXSTRING = 16,
}

enum DRAWPROGRESSFLAGS
{
    DPF_NONE = 0,
    DPF_MARQUEE = 1,
    DPF_MARQUEE_COMPLETE = 2,
    DPF_ERROR = 4,
    DPF_WARNING = 8,
    DPF_STOPPED = 16,
}

@DllImport("PROPSYS.dll")
HRESULT PropVariantToWinRTPropertyValue(const(PROPVARIANT)* propvar, const(Guid)* riid, void** ppv);

@DllImport("PROPSYS.dll")
HRESULT WinRTPropertyValueToPropVariant(IUnknown punkPropertyValue, PROPVARIANT* ppropvar);

@DllImport("PROPSYS.dll")
HRESULT PSFormatForDisplay(const(PROPERTYKEY)* propkey, const(PROPVARIANT)* propvar, PROPDESC_FORMAT_FLAGS pdfFlags, const(wchar)* pwszText, uint cchText);

@DllImport("PROPSYS.dll")
HRESULT PSFormatForDisplayAlloc(const(PROPERTYKEY)* key, const(PROPVARIANT)* propvar, PROPDESC_FORMAT_FLAGS pdff, ushort** ppszDisplay);

@DllImport("PROPSYS.dll")
HRESULT PSFormatPropertyValue(IPropertyStore pps, IPropertyDescription ppd, PROPDESC_FORMAT_FLAGS pdff, ushort** ppszDisplay);

@DllImport("PROPSYS.dll")
HRESULT PSGetImageReferenceForValue(const(PROPERTYKEY)* propkey, const(PROPVARIANT)* propvar, ushort** ppszImageRes);

@DllImport("PROPSYS.dll")
HRESULT PSStringFromPropertyKey(const(PROPERTYKEY)* pkey, const(wchar)* psz, uint cch);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyKeyFromString(const(wchar)* pszString, PROPERTYKEY* pkey);

@DllImport("PROPSYS.dll")
HRESULT PSCreateMemoryPropertyStore(const(Guid)* riid, void** ppv);

@DllImport("PROPSYS.dll")
HRESULT PSCreateDelayedMultiplexPropertyStore(GETPROPERTYSTOREFLAGS flags, IDelayedPropertyStoreFactory pdpsf, char* rgStoreIds, uint cStores, const(Guid)* riid, void** ppv);

@DllImport("PROPSYS.dll")
HRESULT PSCreateMultiplexPropertyStore(char* prgpunkStores, uint cStores, const(Guid)* riid, void** ppv);

@DllImport("PROPSYS.dll")
HRESULT PSCreatePropertyChangeArray(char* rgpropkey, char* rgflags, char* rgpropvar, uint cChanges, const(Guid)* riid, void** ppv);

@DllImport("PROPSYS.dll")
HRESULT PSCreateSimplePropertyChange(PKA_FLAGS flags, const(PROPERTYKEY)* key, const(PROPVARIANT)* propvar, const(Guid)* riid, void** ppv);

@DllImport("PROPSYS.dll")
HRESULT PSGetPropertyDescription(const(PROPERTYKEY)* propkey, const(Guid)* riid, void** ppv);

@DllImport("PROPSYS.dll")
HRESULT PSGetPropertyDescriptionByName(const(wchar)* pszCanonicalName, const(Guid)* riid, void** ppv);

@DllImport("PROPSYS.dll")
HRESULT PSLookupPropertyHandlerCLSID(const(wchar)* pszFilePath, Guid* pclsid);

@DllImport("PROPSYS.dll")
HRESULT PSGetItemPropertyHandler(IUnknown punkItem, BOOL fReadWrite, const(Guid)* riid, void** ppv);

@DllImport("PROPSYS.dll")
HRESULT PSGetItemPropertyHandlerWithCreateObject(IUnknown punkItem, BOOL fReadWrite, IUnknown punkCreateObject, const(Guid)* riid, void** ppv);

@DllImport("PROPSYS.dll")
HRESULT PSGetPropertyValue(IPropertyStore pps, IPropertyDescription ppd, PROPVARIANT* ppropvar);

@DllImport("PROPSYS.dll")
HRESULT PSSetPropertyValue(IPropertyStore pps, IPropertyDescription ppd, const(PROPVARIANT)* propvar);

@DllImport("PROPSYS.dll")
HRESULT PSRegisterPropertySchema(const(wchar)* pszPath);

@DllImport("PROPSYS.dll")
HRESULT PSUnregisterPropertySchema(const(wchar)* pszPath);

@DllImport("PROPSYS.dll")
HRESULT PSRefreshPropertySchema();

@DllImport("PROPSYS.dll")
HRESULT PSEnumeratePropertyDescriptions(PROPDESC_ENUMFILTER filterOn, const(Guid)* riid, void** ppv);

@DllImport("PROPSYS.dll")
HRESULT PSGetPropertyKeyFromName(const(wchar)* pszName, PROPERTYKEY* ppropkey);

@DllImport("PROPSYS.dll")
HRESULT PSGetNameFromPropertyKey(const(PROPERTYKEY)* propkey, ushort** ppszCanonicalName);

@DllImport("PROPSYS.dll")
HRESULT PSCoerceToCanonicalValue(const(PROPERTYKEY)* key, PROPVARIANT* ppropvar);

@DllImport("PROPSYS.dll")
HRESULT PSGetPropertyDescriptionListFromString(const(wchar)* pszPropList, const(Guid)* riid, void** ppv);

@DllImport("PROPSYS.dll")
HRESULT PSCreatePropertyStoreFromPropertySetStorage(IPropertySetStorage ppss, uint grfMode, const(Guid)* riid, void** ppv);

@DllImport("PROPSYS.dll")
HRESULT PSCreatePropertyStoreFromObject(IUnknown punk, uint grfMode, const(Guid)* riid, void** ppv);

@DllImport("PROPSYS.dll")
HRESULT PSCreateAdapterFromPropertyStore(IPropertyStore pps, const(Guid)* riid, void** ppv);

@DllImport("PROPSYS.dll")
HRESULT PSGetPropertySystem(const(Guid)* riid, void** ppv);

@DllImport("PROPSYS.dll")
HRESULT PSGetPropertyFromPropertyStorage(char* psps, uint cb, const(PROPERTYKEY)* rpkey, PROPVARIANT* ppropvar);

@DllImport("PROPSYS.dll")
HRESULT PSGetNamedPropertyFromPropertyStorage(char* psps, uint cb, const(wchar)* pszName, PROPVARIANT* ppropvar);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadType(IPropertyBag propBag, const(wchar)* propName, VARIANT* var, ushort type);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadStr(IPropertyBag propBag, const(wchar)* propName, const(wchar)* value, int characterCount);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadStrAlloc(IPropertyBag propBag, const(wchar)* propName, ushort** value);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadBSTR(IPropertyBag propBag, const(wchar)* propName, BSTR* value);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_WriteStr(IPropertyBag propBag, const(wchar)* propName, const(wchar)* value);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_WriteBSTR(IPropertyBag propBag, const(wchar)* propName, BSTR value);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadInt(IPropertyBag propBag, const(wchar)* propName, int* value);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_WriteInt(IPropertyBag propBag, const(wchar)* propName, int value);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadSHORT(IPropertyBag propBag, const(wchar)* propName, short* value);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_WriteSHORT(IPropertyBag propBag, const(wchar)* propName, short value);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadLONG(IPropertyBag propBag, const(wchar)* propName, int* value);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_WriteLONG(IPropertyBag propBag, const(wchar)* propName, int value);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadDWORD(IPropertyBag propBag, const(wchar)* propName, uint* value);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_WriteDWORD(IPropertyBag propBag, const(wchar)* propName, uint value);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadBOOL(IPropertyBag propBag, const(wchar)* propName, int* value);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_WriteBOOL(IPropertyBag propBag, const(wchar)* propName, BOOL value);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadPOINTL(IPropertyBag propBag, const(wchar)* propName, POINTL* value);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_WritePOINTL(IPropertyBag propBag, const(wchar)* propName, const(POINTL)* value);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadPOINTS(IPropertyBag propBag, const(wchar)* propName, POINTS* value);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_WritePOINTS(IPropertyBag propBag, const(wchar)* propName, const(POINTS)* value);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadRECTL(IPropertyBag propBag, const(wchar)* propName, RECTL* value);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_WriteRECTL(IPropertyBag propBag, const(wchar)* propName, const(RECTL)* value);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadStream(IPropertyBag propBag, const(wchar)* propName, IStream* value);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_WriteStream(IPropertyBag propBag, const(wchar)* propName, IStream value);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_Delete(IPropertyBag propBag, const(wchar)* propName);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadULONGLONG(IPropertyBag propBag, const(wchar)* propName, ulong* value);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_WriteULONGLONG(IPropertyBag propBag, const(wchar)* propName, ulong value);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadUnknown(IPropertyBag propBag, const(wchar)* propName, const(Guid)* riid, void** ppv);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_WriteUnknown(IPropertyBag propBag, const(wchar)* propName, IUnknown punk);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadGUID(IPropertyBag propBag, const(wchar)* propName, Guid* value);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_WriteGUID(IPropertyBag propBag, const(wchar)* propName, const(Guid)* value);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadPropertyKey(IPropertyBag propBag, const(wchar)* propName, PROPERTYKEY* value);

@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_WritePropertyKey(IPropertyBag propBag, const(wchar)* propName, const(PROPERTYKEY)* value);

@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromResource(HINSTANCE hinst, uint id, PROPVARIANT* ppropvar);

@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromBuffer(char* pv, uint cb, PROPVARIANT* ppropvar);

@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromCLSID(const(Guid)* clsid, PROPVARIANT* ppropvar);

@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromGUIDAsString(const(Guid)* guid, PROPVARIANT* ppropvar);

@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromFileTime(const(FILETIME)* pftIn, PROPVARIANT* ppropvar);

@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromPropVariantVectorElem(const(PROPVARIANT)* propvarIn, uint iElem, PROPVARIANT* ppropvar);

@DllImport("PROPSYS.dll")
HRESULT InitPropVariantVectorFromPropVariant(const(PROPVARIANT)* propvarSingle, PROPVARIANT* ppropvarVector);

@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromStrRet(STRRET* pstrret, ITEMIDLIST* pidl, PROPVARIANT* ppropvar);

@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromBooleanVector(char* prgf, uint cElems, PROPVARIANT* ppropvar);

@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromInt16Vector(char* prgn, uint cElems, PROPVARIANT* ppropvar);

@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromUInt16Vector(char* prgn, uint cElems, PROPVARIANT* ppropvar);

@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromInt32Vector(char* prgn, uint cElems, PROPVARIANT* ppropvar);

@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromUInt32Vector(char* prgn, uint cElems, PROPVARIANT* ppropvar);

@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromInt64Vector(char* prgn, uint cElems, PROPVARIANT* ppropvar);

@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromUInt64Vector(char* prgn, uint cElems, PROPVARIANT* ppropvar);

@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromDoubleVector(char* prgn, uint cElems, PROPVARIANT* ppropvar);

@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromFileTimeVector(char* prgft, uint cElems, PROPVARIANT* ppropvar);

@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromStringVector(char* prgsz, uint cElems, PROPVARIANT* ppropvar);

@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromStringAsVector(const(wchar)* psz, PROPVARIANT* ppropvar);

@DllImport("PROPSYS.dll")
BOOL PropVariantToBooleanWithDefault(const(PROPVARIANT)* propvarIn, BOOL fDefault);

@DllImport("PROPSYS.dll")
short PropVariantToInt16WithDefault(const(PROPVARIANT)* propvarIn, short iDefault);

@DllImport("PROPSYS.dll")
ushort PropVariantToUInt16WithDefault(const(PROPVARIANT)* propvarIn, ushort uiDefault);

@DllImport("PROPSYS.dll")
int PropVariantToInt32WithDefault(const(PROPVARIANT)* propvarIn, int lDefault);

@DllImport("PROPSYS.dll")
uint PropVariantToUInt32WithDefault(const(PROPVARIANT)* propvarIn, uint ulDefault);

@DllImport("PROPSYS.dll")
long PropVariantToInt64WithDefault(const(PROPVARIANT)* propvarIn, long llDefault);

@DllImport("PROPSYS.dll")
ulong PropVariantToUInt64WithDefault(const(PROPVARIANT)* propvarIn, ulong ullDefault);

@DllImport("PROPSYS.dll")
double PropVariantToDoubleWithDefault(const(PROPVARIANT)* propvarIn, double dblDefault);

@DllImport("PROPSYS.dll")
ushort* PropVariantToStringWithDefault(const(PROPVARIANT)* propvarIn, const(wchar)* pszDefault);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToBoolean(const(PROPVARIANT)* propvarIn, int* pfRet);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToInt16(const(PROPVARIANT)* propvarIn, short* piRet);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToUInt16(const(PROPVARIANT)* propvarIn, ushort* puiRet);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToInt32(const(PROPVARIANT)* propvarIn, int* plRet);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToUInt32(const(PROPVARIANT)* propvarIn, uint* pulRet);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToInt64(const(PROPVARIANT)* propvarIn, long* pllRet);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToUInt64(const(PROPVARIANT)* propvarIn, ulong* pullRet);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToDouble(const(PROPVARIANT)* propvarIn, double* pdblRet);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToBuffer(const(PROPVARIANT)* propvar, char* pv, uint cb);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToString(const(PROPVARIANT)* propvar, const(wchar)* psz, uint cch);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToGUID(const(PROPVARIANT)* propvar, Guid* pguid);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToStringAlloc(const(PROPVARIANT)* propvar, ushort** ppszOut);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToBSTR(const(PROPVARIANT)* propvar, BSTR* pbstrOut);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToStrRet(const(PROPVARIANT)* propvar, STRRET* pstrret);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToFileTime(const(PROPVARIANT)* propvar, int pstfOut, FILETIME* pftOut);

@DllImport("PROPSYS.dll")
uint PropVariantGetElementCount(const(PROPVARIANT)* propvar);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToBooleanVector(const(PROPVARIANT)* propvar, char* prgf, uint crgf, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToInt16Vector(const(PROPVARIANT)* propvar, char* prgn, uint crgn, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToUInt16Vector(const(PROPVARIANT)* propvar, char* prgn, uint crgn, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToInt32Vector(const(PROPVARIANT)* propvar, char* prgn, uint crgn, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToUInt32Vector(const(PROPVARIANT)* propvar, char* prgn, uint crgn, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToInt64Vector(const(PROPVARIANT)* propvar, char* prgn, uint crgn, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToUInt64Vector(const(PROPVARIANT)* propvar, char* prgn, uint crgn, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToDoubleVector(const(PROPVARIANT)* propvar, char* prgn, uint crgn, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToFileTimeVector(const(PROPVARIANT)* propvar, char* prgft, uint crgft, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToStringVector(const(PROPVARIANT)* propvar, char* prgsz, uint crgsz, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToBooleanVectorAlloc(const(PROPVARIANT)* propvar, int** pprgf, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToInt16VectorAlloc(const(PROPVARIANT)* propvar, short** pprgn, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToUInt16VectorAlloc(const(PROPVARIANT)* propvar, ushort** pprgn, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToInt32VectorAlloc(const(PROPVARIANT)* propvar, int** pprgn, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToUInt32VectorAlloc(const(PROPVARIANT)* propvar, uint** pprgn, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToInt64VectorAlloc(const(PROPVARIANT)* propvar, long** pprgn, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToUInt64VectorAlloc(const(PROPVARIANT)* propvar, ulong** pprgn, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToDoubleVectorAlloc(const(PROPVARIANT)* propvar, double** pprgn, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToFileTimeVectorAlloc(const(PROPVARIANT)* propvar, FILETIME** pprgft, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToStringVectorAlloc(const(PROPVARIANT)* propvar, ushort*** pprgsz, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT PropVariantGetBooleanElem(const(PROPVARIANT)* propvar, uint iElem, int* pfVal);

@DllImport("PROPSYS.dll")
HRESULT PropVariantGetInt16Elem(const(PROPVARIANT)* propvar, uint iElem, short* pnVal);

@DllImport("PROPSYS.dll")
HRESULT PropVariantGetUInt16Elem(const(PROPVARIANT)* propvar, uint iElem, ushort* pnVal);

@DllImport("PROPSYS.dll")
HRESULT PropVariantGetInt32Elem(const(PROPVARIANT)* propvar, uint iElem, int* pnVal);

@DllImport("PROPSYS.dll")
HRESULT PropVariantGetUInt32Elem(const(PROPVARIANT)* propvar, uint iElem, uint* pnVal);

@DllImport("PROPSYS.dll")
HRESULT PropVariantGetInt64Elem(const(PROPVARIANT)* propvar, uint iElem, long* pnVal);

@DllImport("PROPSYS.dll")
HRESULT PropVariantGetUInt64Elem(const(PROPVARIANT)* propvar, uint iElem, ulong* pnVal);

@DllImport("PROPSYS.dll")
HRESULT PropVariantGetDoubleElem(const(PROPVARIANT)* propvar, uint iElem, double* pnVal);

@DllImport("PROPSYS.dll")
HRESULT PropVariantGetFileTimeElem(const(PROPVARIANT)* propvar, uint iElem, FILETIME* pftVal);

@DllImport("PROPSYS.dll")
HRESULT PropVariantGetStringElem(const(PROPVARIANT)* propvar, uint iElem, ushort** ppszVal);

@DllImport("PROPSYS.dll")
void ClearPropVariantArray(char* rgPropVar, uint cVars);

@DllImport("PROPSYS.dll")
int PropVariantCompareEx(const(PROPVARIANT)* propvar1, const(PROPVARIANT)* propvar2, PROPVAR_COMPARE_UNIT unit, int flags);

@DllImport("PROPSYS.dll")
HRESULT PropVariantChangeType(PROPVARIANT* ppropvarDest, const(PROPVARIANT)* propvarSrc, int flags, ushort vt);

@DllImport("PROPSYS.dll")
HRESULT PropVariantToVariant(const(PROPVARIANT)* pPropVar, VARIANT* pVar);

@DllImport("PROPSYS.dll")
HRESULT VariantToPropVariant(const(VARIANT)* pVar, PROPVARIANT* pPropVar);

@DllImport("PROPSYS.dll")
HRESULT InitVariantFromResource(HINSTANCE hinst, uint id, VARIANT* pvar);

@DllImport("PROPSYS.dll")
HRESULT InitVariantFromBuffer(char* pv, uint cb, VARIANT* pvar);

@DllImport("PROPSYS.dll")
HRESULT InitVariantFromGUIDAsString(const(Guid)* guid, VARIANT* pvar);

@DllImport("PROPSYS.dll")
HRESULT InitVariantFromFileTime(const(FILETIME)* pft, VARIANT* pvar);

@DllImport("PROPSYS.dll")
HRESULT InitVariantFromFileTimeArray(char* prgft, uint cElems, VARIANT* pvar);

@DllImport("PROPSYS.dll")
HRESULT InitVariantFromStrRet(STRRET* pstrret, ITEMIDLIST* pidl, VARIANT* pvar);

@DllImport("PROPSYS.dll")
HRESULT InitVariantFromVariantArrayElem(const(VARIANT)* varIn, uint iElem, VARIANT* pvar);

@DllImport("PROPSYS.dll")
HRESULT InitVariantFromBooleanArray(char* prgf, uint cElems, VARIANT* pvar);

@DllImport("PROPSYS.dll")
HRESULT InitVariantFromInt16Array(char* prgn, uint cElems, VARIANT* pvar);

@DllImport("PROPSYS.dll")
HRESULT InitVariantFromUInt16Array(char* prgn, uint cElems, VARIANT* pvar);

@DllImport("PROPSYS.dll")
HRESULT InitVariantFromInt32Array(char* prgn, uint cElems, VARIANT* pvar);

@DllImport("PROPSYS.dll")
HRESULT InitVariantFromUInt32Array(char* prgn, uint cElems, VARIANT* pvar);

@DllImport("PROPSYS.dll")
HRESULT InitVariantFromInt64Array(char* prgn, uint cElems, VARIANT* pvar);

@DllImport("PROPSYS.dll")
HRESULT InitVariantFromUInt64Array(char* prgn, uint cElems, VARIANT* pvar);

@DllImport("PROPSYS.dll")
HRESULT InitVariantFromDoubleArray(char* prgn, uint cElems, VARIANT* pvar);

@DllImport("PROPSYS.dll")
HRESULT InitVariantFromStringArray(char* prgsz, uint cElems, VARIANT* pvar);

@DllImport("PROPSYS.dll")
BOOL VariantToBooleanWithDefault(const(VARIANT)* varIn, BOOL fDefault);

@DllImport("PROPSYS.dll")
short VariantToInt16WithDefault(const(VARIANT)* varIn, short iDefault);

@DllImport("PROPSYS.dll")
ushort VariantToUInt16WithDefault(const(VARIANT)* varIn, ushort uiDefault);

@DllImport("PROPSYS.dll")
int VariantToInt32WithDefault(const(VARIANT)* varIn, int lDefault);

@DllImport("PROPSYS.dll")
uint VariantToUInt32WithDefault(const(VARIANT)* varIn, uint ulDefault);

@DllImport("PROPSYS.dll")
long VariantToInt64WithDefault(const(VARIANT)* varIn, long llDefault);

@DllImport("PROPSYS.dll")
ulong VariantToUInt64WithDefault(const(VARIANT)* varIn, ulong ullDefault);

@DllImport("PROPSYS.dll")
double VariantToDoubleWithDefault(const(VARIANT)* varIn, double dblDefault);

@DllImport("PROPSYS.dll")
ushort* VariantToStringWithDefault(const(VARIANT)* varIn, const(wchar)* pszDefault);

@DllImport("PROPSYS.dll")
HRESULT VariantToBoolean(const(VARIANT)* varIn, int* pfRet);

@DllImport("PROPSYS.dll")
HRESULT VariantToInt16(const(VARIANT)* varIn, short* piRet);

@DllImport("PROPSYS.dll")
HRESULT VariantToUInt16(const(VARIANT)* varIn, ushort* puiRet);

@DllImport("PROPSYS.dll")
HRESULT VariantToInt32(const(VARIANT)* varIn, int* plRet);

@DllImport("PROPSYS.dll")
HRESULT VariantToUInt32(const(VARIANT)* varIn, uint* pulRet);

@DllImport("PROPSYS.dll")
HRESULT VariantToInt64(const(VARIANT)* varIn, long* pllRet);

@DllImport("PROPSYS.dll")
HRESULT VariantToUInt64(const(VARIANT)* varIn, ulong* pullRet);

@DllImport("PROPSYS.dll")
HRESULT VariantToDouble(const(VARIANT)* varIn, double* pdblRet);

@DllImport("PROPSYS.dll")
HRESULT VariantToBuffer(const(VARIANT)* varIn, char* pv, uint cb);

@DllImport("PROPSYS.dll")
HRESULT VariantToGUID(const(VARIANT)* varIn, Guid* pguid);

@DllImport("PROPSYS.dll")
HRESULT VariantToString(const(VARIANT)* varIn, const(wchar)* pszBuf, uint cchBuf);

@DllImport("PROPSYS.dll")
HRESULT VariantToStringAlloc(const(VARIANT)* varIn, ushort** ppszBuf);

@DllImport("PROPSYS.dll")
HRESULT VariantToDosDateTime(const(VARIANT)* varIn, ushort* pwDate, ushort* pwTime);

@DllImport("PROPSYS.dll")
HRESULT VariantToStrRet(const(VARIANT)* varIn, STRRET* pstrret);

@DllImport("PROPSYS.dll")
HRESULT VariantToFileTime(const(VARIANT)* varIn, int stfOut, FILETIME* pftOut);

@DllImport("PROPSYS.dll")
uint VariantGetElementCount(const(VARIANT)* varIn);

@DllImport("PROPSYS.dll")
HRESULT VariantToBooleanArray(const(VARIANT)* var, char* prgf, uint crgn, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT VariantToInt16Array(const(VARIANT)* var, char* prgn, uint crgn, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT VariantToUInt16Array(const(VARIANT)* var, char* prgn, uint crgn, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT VariantToInt32Array(const(VARIANT)* var, char* prgn, uint crgn, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT VariantToUInt32Array(const(VARIANT)* var, char* prgn, uint crgn, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT VariantToInt64Array(const(VARIANT)* var, char* prgn, uint crgn, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT VariantToUInt64Array(const(VARIANT)* var, char* prgn, uint crgn, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT VariantToDoubleArray(const(VARIANT)* var, char* prgn, uint crgn, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT VariantToStringArray(const(VARIANT)* var, char* prgsz, uint crgsz, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT VariantToBooleanArrayAlloc(const(VARIANT)* var, int** pprgf, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT VariantToInt16ArrayAlloc(const(VARIANT)* var, short** pprgn, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT VariantToUInt16ArrayAlloc(const(VARIANT)* var, ushort** pprgn, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT VariantToInt32ArrayAlloc(const(VARIANT)* var, int** pprgn, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT VariantToUInt32ArrayAlloc(const(VARIANT)* var, uint** pprgn, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT VariantToInt64ArrayAlloc(const(VARIANT)* var, long** pprgn, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT VariantToUInt64ArrayAlloc(const(VARIANT)* var, ulong** pprgn, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT VariantToDoubleArrayAlloc(const(VARIANT)* var, double** pprgn, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT VariantToStringArrayAlloc(const(VARIANT)* var, ushort*** pprgsz, uint* pcElem);

@DllImport("PROPSYS.dll")
HRESULT VariantGetBooleanElem(const(VARIANT)* var, uint iElem, int* pfVal);

@DllImport("PROPSYS.dll")
HRESULT VariantGetInt16Elem(const(VARIANT)* var, uint iElem, short* pnVal);

@DllImport("PROPSYS.dll")
HRESULT VariantGetUInt16Elem(const(VARIANT)* var, uint iElem, ushort* pnVal);

@DllImport("PROPSYS.dll")
HRESULT VariantGetInt32Elem(const(VARIANT)* var, uint iElem, int* pnVal);

@DllImport("PROPSYS.dll")
HRESULT VariantGetUInt32Elem(const(VARIANT)* var, uint iElem, uint* pnVal);

@DllImport("PROPSYS.dll")
HRESULT VariantGetInt64Elem(const(VARIANT)* var, uint iElem, long* pnVal);

@DllImport("PROPSYS.dll")
HRESULT VariantGetUInt64Elem(const(VARIANT)* var, uint iElem, ulong* pnVal);

@DllImport("PROPSYS.dll")
HRESULT VariantGetDoubleElem(const(VARIANT)* var, uint iElem, double* pnVal);

@DllImport("PROPSYS.dll")
HRESULT VariantGetStringElem(const(VARIANT)* var, uint iElem, ushort** ppszVal);

@DllImport("PROPSYS.dll")
void ClearVariantArray(char* pvars, uint cvars);

@DllImport("PROPSYS.dll")
int VariantCompare(const(VARIANT)* var1, const(VARIANT)* var2);

@DllImport("SHELL32.dll")
HRESULT SHGetPropertyStoreForWindow(HWND hwnd, const(Guid)* riid, void** ppv);

@DllImport("SHELL32.dll")
HRESULT SHGetPropertyStoreFromIDList(ITEMIDLIST* pidl, GETPROPERTYSTOREFLAGS flags, const(Guid)* riid, void** ppv);

@DllImport("SHELL32.dll")
HRESULT SHGetPropertyStoreFromParsingName(const(wchar)* pszPath, IBindCtx pbc, GETPROPERTYSTOREFLAGS flags, const(Guid)* riid, void** ppv);

@DllImport("SHELL32.dll")
HRESULT SHAddDefaultPropertiesByExt(const(wchar)* pszExt, IPropertyStore pPropStore);

@DllImport("SHELL32.dll")
HANDLE PifMgr_OpenProperties(const(wchar)* pszApp, const(wchar)* pszPIF, uint hInf, uint flOpt);

@DllImport("SHELL32.dll")
int PifMgr_GetProperties(HANDLE hProps, const(char)* pszGroup, char* lpProps, int cbProps, uint flOpt);

@DllImport("SHELL32.dll")
int PifMgr_SetProperties(HANDLE hProps, const(char)* pszGroup, char* lpProps, int cbProps, uint flOpt);

@DllImport("SHELL32.dll")
HANDLE PifMgr_CloseProperties(HANDLE hProps, uint flOpt);

@DllImport("SHELL32.dll")
HRESULT SHPropStgCreate(IPropertySetStorage psstg, const(Guid)* fmtid, const(Guid)* pclsid, uint grfFlags, uint grfMode, uint dwDisposition, IPropertyStorage* ppstg, uint* puCodePage);

@DllImport("SHELL32.dll")
HRESULT SHPropStgReadMultiple(IPropertyStorage pps, uint uCodePage, uint cpspec, char* rgpspec, char* rgvar);

@DllImport("SHELL32.dll")
HRESULT SHPropStgWriteMultiple(IPropertyStorage pps, uint* puCodePage, uint cpspec, char* rgpspec, char* rgvar, uint propidNameFirst);

enum SYNC_TRANSFER_STATUS
{
    STS_NONE = 0,
    STS_NEEDSUPLOAD = 1,
    STS_NEEDSDOWNLOAD = 2,
    STS_TRANSFERRING = 4,
    STS_PAUSED = 8,
    STS_HASERROR = 16,
    STS_FETCHING_METADATA = 32,
    STS_USER_REQUESTED_REFRESH = 64,
    STS_HASWARNING = 128,
    STS_EXCLUDED = 256,
    STS_INCOMPLETE = 512,
    STS_PLACEHOLDER_IFEMPTY = 1024,
}

enum PLACEHOLDER_STATES
{
    PS_NONE = 0,
    PS_MARKED_FOR_OFFLINE_AVAILABILITY = 1,
    PS_FULL_PRIMARY_STREAM_AVAILABLE = 2,
    PS_CREATE_FILE_ACCESSIBLE = 4,
    PS_CLOUDFILE_PLACEHOLDER = 8,
    PS_DEFAULT = 7,
    PS_ALL = 15,
}

enum _PROPERTYUI_FLAGS
{
    PUIF_DEFAULT = 0,
    PUIF_RIGHTALIGN = 1,
    PUIF_NOLABELININFOTIP = 2,
}

const GUID IID_IPropertyUI = {0x757A7D9F, 0x919A, 0x4118, [0x99, 0xD7, 0xDB, 0xB2, 0x08, 0xC8, 0xCC, 0x66]};
@GUID(0x757A7D9F, 0x919A, 0x4118, [0x99, 0xD7, 0xDB, 0xB2, 0x08, 0xC8, 0xCC, 0x66]);
interface IPropertyUI : IUnknown
{
    HRESULT ParsePropertyName(const(wchar)* pszName, Guid* pfmtid, uint* ppid, uint* pchEaten);
    HRESULT GetCannonicalName(const(Guid)* fmtid, uint pid, const(wchar)* pwszText, uint cchText);
    HRESULT GetDisplayName(const(Guid)* fmtid, uint pid, uint flags, const(wchar)* pwszText, uint cchText);
    HRESULT GetPropertyDescription(const(Guid)* fmtid, uint pid, const(wchar)* pwszText, uint cchText);
    HRESULT GetDefaultWidth(const(Guid)* fmtid, uint pid, uint* pcxChars);
    HRESULT GetFlags(const(Guid)* fmtid, uint pid, uint* pflags);
    HRESULT FormatForDisplay(const(Guid)* fmtid, uint pid, const(PROPVARIANT)* ppropvar, uint puiff, const(wchar)* pwszText, uint cchText);
    HRESULT GetHelpInfo(const(Guid)* fmtid, uint pid, const(wchar)* pwszHelpFile, uint cch, uint* puHelpID);
}

enum PDOPSTATUS
{
    PDOPS_RUNNING = 1,
    PDOPS_PAUSED = 2,
    PDOPS_CANCELLED = 3,
    PDOPS_STOPPED = 4,
    PDOPS_ERRORS = 5,
}

enum SYNC_ENGINE_STATE_FLAGS
{
    SESF_NONE = 0,
    SESF_SERVICE_QUOTA_NEARING_LIMIT = 1,
    SESF_SERVICE_QUOTA_EXCEEDED_LIMIT = 2,
    SESF_AUTHENTICATION_ERROR = 4,
    SESF_PAUSED_DUE_TO_METERED_NETWORK = 8,
    SESF_PAUSED_DUE_TO_DISK_SPACE_FULL = 16,
    SESF_PAUSED_DUE_TO_CLIENT_POLICY = 32,
    SESF_PAUSED_DUE_TO_SERVICE_POLICY = 64,
    SESF_SERVICE_UNAVAILABLE = 128,
    SESF_PAUSED_DUE_TO_USER_REQUEST = 256,
    SESF_ALL_FLAGS = 511,
}

struct PROPPRG
{
    ushort flPrg;
    ushort flPrgInit;
    byte achTitle;
    byte achCmdLine;
    byte achWorkDir;
    ushort wHotKey;
    byte achIconFile;
    ushort wIconIndex;
    uint dwEnhModeFlags;
    uint dwRealModeFlags;
    byte achOtherFile;
    byte achPIFFile;
}

