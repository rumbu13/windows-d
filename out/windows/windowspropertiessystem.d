// Written in the D programming language.

module windows.windowspropertiessystem;

public import windows.core;
public import windows.audio : IPropertyStore;
public import windows.automation : BSTR, IPropertyBag, VARIANT;
public import windows.com : HRESULT, IBindCtx, IUnknown;
public import windows.displaydevices : POINTL, POINTS, RECTL;
public import windows.search : CONDITION_OPERATION;
public import windows.shell : IDelayedPropertyStoreFactory, IObjectWithPropertyKey, ITEMIDLIST,
                              STRRET;
public import windows.structuredstorage : IPropertySetStorage, IPropertyStorage, IStream,
                                          PROPSPEC, PROPVARIANT;
public import windows.systemservices : BOOL, HANDLE, HINSTANCE;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


// Enums


///Indicates flags that modify the property store object retrieved by methods that create a property store, such as
///IShellItem2::GetPropertyStore or IPropertyStoreFactory::GetPropertyStore.
alias GETPROPERTYSTOREFLAGS = int;
enum : int
{
    ///Meaning to a calling process: Return a read-only property store that contains all properties. Slow items (offline
    ///files) are not opened. Combination with other flags: Can be overridden by other flags.
    GPS_DEFAULT                 = 0x00000000,
    ///Meaning to a calling process: Include only properties directly from the property handler, which opens the file on
    ///the disk, network, or device. Meaning to a file folder: Only include properties directly from the handler.
    ///Meaning to other folders: When delegating to a file folder, pass this flag on to the file folder; do not do any
    ///multiplexing (MUX). When not delegating to a file folder, ignore this flag instead of returning a failure code.
    ///Combination with other flags: Cannot be combined with GPS_TEMPORARY, GPS_FASTPROPERTIESONLY, or GPS_BESTEFFORT.
    GPS_HANDLERPROPERTIESONLY   = 0x00000001,
    ///Meaning to a calling process: Can write properties to the item. Note: The store may contain fewer properties than
    ///a read-only store. Meaning to a file folder: ReadWrite. Meaning to other folders: ReadWrite. Note: When using
    ///default MUX, return a single unmultiplexed store because the default MUX does not support ReadWrite. Combination
    ///with other flags: Cannot be combined with GPS_TEMPORARY, GPS_FASTPROPERTIESONLY, GPS_BESTEFFORT, or
    ///GPS_DELAYCREATION. Implies GPS_HANDLERPROPERTIESONLY.
    GPS_READWRITE               = 0x00000002,
    ///Meaning to a calling process: Provides a writable store, with no initial properties, that exists for the lifetime
    ///of the Shell item instance; basically, a property bag attached to the item instance. Meaning to a file folder:
    ///Not applicable. Handled by the Shell item. Meaning to other folders: Not applicable. Handled by the Shell item.
    ///Combination with other flags: Cannot be combined with any other flag. Implies GPS_READWRITE.
    GPS_TEMPORARY               = 0x00000004,
    ///Meaning to a calling process: Provides a store that does not involve reading from the disk or network. Note: Some
    ///values may be different, or missing, compared to a store without this flag. Meaning to a file folder: Include the
    ///"innate" and "fallback" stores only. Do not load the handler. Meaning to other folders: Include only properties
    ///that are available in memory or can be computed very quickly (no properties from disk, network, or peripheral IO
    ///devices). This is normally only data sources from the IDLIST. When delegating to other folders, pass this flag on
    ///to them. Combination with other flags: Cannot be combined with GPS_TEMPORARY, GPS_READWRITE,
    ///GPS_HANDLERPROPERTIESONLY, or GPS_DELAYCREATION.
    GPS_FASTPROPERTIESONLY      = 0x00000008,
    ///Meaning to a calling process: Open a slow item (offline file) if necessary. Meaning to a file folder: Retrieve a
    ///file from offline storage, if necessary. Note: Without this flag, the handler is not created for offline files.
    ///Meaning to other folders: Do not return any properties that are very slow. Combination with other flags: Cannot
    ///be combined with GPS_TEMPORARY or GPS_FASTPROPERTIESONLY.
    GPS_OPENSLOWITEM            = 0x00000010,
    ///Meaning to a calling process: Delay memory-intensive operations, such as file access, until a property is
    ///requested that requires such access. Meaning to a file folder: Do not create the handler until needed; for
    ///example, either GetCount/GetAt or GetValue, where the innate store does not satisfy the request. Note:
    ///<b>GetValue</b> might fail due to file access problems. Meaning to other folders: If the folder has
    ///memory-intensive properties, such as delegating to a file folder or network access, it can optimize performance
    ///by supporting IDelayedPropertyStoreFactory and splitting up its properties into a fast and a slow store. It can
    ///then use delayed MUX to recombine them. Combination with other flags: Cannot be combined with GPS_TEMPORARY or
    ///GPS_READWRITE.
    GPS_DELAYCREATION           = 0x00000020,
    ///Meaning to a calling process: Succeed at getting the store, even if some properties are not returned. Note: Some
    ///values may be different, or missing, compared to a store without this flag. Meaning to a file folder: Succeed and
    ///return a store, even if the handler or innate store has an error during creation. Only fail if substores fail.
    ///Meaning to other folders: Succeed on getting the store, even if some properties are not returned. Combination
    ///with other flags: Cannot be combined with GPS_TEMPORARY, GPS_READWRITE, or GPS_HANDLERPROPERTIESONLY.
    GPS_BESTEFFORT              = 0x00000040,
    ///<b>Windows 7 and later</b>. Callers should use this flag only if they are already holding an opportunistic lock
    ///(oplock) on the file because without an oplock, the bind operation cannot continue. By default, the Shell
    ///requests an oplock on a file before binding to the property handler. This flag disables the default behavior.
    ///<b>Windows Server 2008 and Windows Vista: </b>This flag is not available.
    GPS_NO_OPLOCK               = 0x00000080,
    ///<b>Windows 8 and later</b>. Use this flag to retrieve only properties from the indexer for WDS results.
    GPS_PREFERQUERYPROPERTIES   = 0x00000100,
    ///Include properties from the file's secondary stream.
    GPS_EXTRINSICPROPERTIES     = 0x00000200,
    ///Include only properties from the file's secondary stream.
    GPS_EXTRINSICPROPERTIESONLY = 0x00000400,
    GPS_VOLATILEPROPERTIES      = 0x00000800,
    GPS_VOLATILEPROPERTIESONLY  = 0x00001000,
    ///Mask for valid GETPROPERTYSTOREFLAGS values.
    GPS_MASK_VALID              = 0x00001fff,
}

///Describes property change array behavior.
alias PKA_FLAGS = int;
enum : int
{
    ///Replace current value.
    PKA_SET    = 0x00000000,
    ///Append to current value - multi-value properties only.
    PKA_APPEND = 0x00000001,
    PKA_DELETE = 0x00000002,
}

///Specifies the state of a property. They are set manually by the code that is hosting the in-memory property store
///cache.
alias PSC_STATE = int;
enum : int
{
    ///The property has not been altered.
    PSC_NORMAL      = 0x00000000,
    ///The requested property does not exist for the file or stream on which the property handler was initialized.
    PSC_NOTINSOURCE = 0x00000001,
    ///The property has been altered but has not yet been committed to the file or stream.
    PSC_DIRTY       = 0x00000002,
    PSC_READONLY    = 0x00000003,
}

alias PROPENUMTYPE = int;
enum : int
{
    PET_DISCRETEVALUE = 0x00000000,
    PET_RANGEDVALUE   = 0x00000001,
    PET_DEFAULTVALUE  = 0x00000002,
    PET_ENDRANGE      = 0x00000003,
}

///Describes attributes of the typeInfo element in the property's .propdesc file.
alias PROPDESC_TYPE_FLAGS = int;
enum : int
{
    ///The property uses the default values for all attributes.
    PDTF_DEFAULT                   = 0x00000000,
    ///The property can have multiple values. These values are stored as a VT_VECTOR in the PROPVARIANT structure. This
    ///value is set by the <i>multipleValues</i> attribute of the typeInfo element in the property's .propdesc file.
    PDTF_MULTIPLEVALUES            = 0x00000001,
    ///This flag indicates that a property is read-only, and cannot be written to. This value is set by the
    ///<i>isInnate</i> attribute of the typeInfo element in the property's .propdesc file.
    PDTF_ISINNATE                  = 0x00000002,
    ///The property is a group heading. This value is set by the <i>isGroup</i> attribute of the typeInfo element in the
    ///property's .propdesc file.
    PDTF_ISGROUP                   = 0x00000004,
    ///The user can group by this property. This value is set by the <i>canGroupBy</i> attribute of the typeInfo element
    ///in the property's .propdesc file.
    PDTF_CANGROUPBY                = 0x00000008,
    ///The user can stack by this property. This value is set by the <i>canStackBy</i> attribute of the typeInfo element
    ///in the property's .propdesc file.
    PDTF_CANSTACKBY                = 0x00000010,
    ///This property contains a hierarchy. This value is set by the <i>isTreeProperty</i> attribute of the typeInfo
    ///element in the property's .propdesc file.
    PDTF_ISTREEPROPERTY            = 0x00000020,
    ///<b>Deprecated in Windows 7 and later</b>. Include this property in any full text query that is performed. This
    ///value is set by the <i>includeInFullTextQuery</i> attribute of the typeInfo element in the property's .propdesc
    ///file.
    PDTF_INCLUDEINFULLTEXTQUERY    = 0x00000040,
    ///This property is meant to be viewed by the user. This influences whether the property shows up in the "Choose
    ///Columns" dialog box, for example. This value is set by the <i>isViewable</i> attribute of the typeInfo element in
    ///the property's .propdesc file.
    PDTF_ISVIEWABLE                = 0x00000080,
    ///<b>Deprecated in Windows 7 and later</b>. This property is included in the list of properties that can be
    ///queried. A queryable property must also be viewable. This influences whether the property shows up in the query
    ///builder UI. This value is set by the <i>isQueryable</i> attribute of the typeInfo element in the property's
    ///.propdesc file.
    PDTF_ISQUERYABLE               = 0x00000100,
    ///<b>Windows Vista with Service Pack 1 (SP1) and later</b>. Used with an innate property (that is, a value
    ///calculated from other property values) to indicate that it can be deleted. This value is used by the <b>Remove
    ///Properties</b> UI to determine whether to display a check box next to a property that enables that property to be
    ///selected for removal. Note that a property that is not innate can always be purged regardless of the presence or
    ///absence of this flag.
    PDTF_CANBEPURGED               = 0x00000200,
    ///<b>Windows 7 and later</b>. The unformatted (raw) property value should be used for searching.
    PDTF_SEARCHRAWVALUE            = 0x00000400,
    PDTF_DONTCOERCEEMPTYSTRINGS    = 0x00000800,
    PDTF_ALWAYSINSUPPLEMENTALSTORE = 0x00001000,
    ///This property is owned by the system.
    PDTF_ISSYSTEMPROPERTY          = 0x80000000,
    ///A mask used to retrieve all flags.
    PDTF_MASK_ALL                  = 0x80001fff,
}

///These flags describe properties in property description list strings.
alias PROPDESC_VIEW_FLAGS = int;
enum : int
{
    ///Show this property by default.
    PDVF_DEFAULT             = 0x00000000,
    ///This property should be centered.
    PDVF_CENTERALIGN         = 0x00000001,
    ///This property should be right aligned.
    PDVF_RIGHTALIGN          = 0x00000002,
    ///Show this property as the beginning of the next collection of properties in the view.
    PDVF_BEGINNEWGROUP       = 0x00000004,
    ///Fill the remainder of the view area with the content of this property.
    PDVF_FILLAREA            = 0x00000008,
    ///Sort this property in reverse (descending) order. Applies to a property in a list of sorted properties.
    PDVF_SORTDESCENDING      = 0x00000010,
    ///Show this property only if it is present.
    PDVF_SHOWONLYIFPRESENT   = 0x00000020,
    ///This property should be shown by default in a view (where applicable).
    PDVF_SHOWBYDEFAULT       = 0x00000040,
    ///This property should be shown by default in the primary column selection UI.
    PDVF_SHOWINPRIMARYLIST   = 0x00000080,
    ///This property should be shown by default in the secondary column selection UI.
    PDVF_SHOWINSECONDARYLIST = 0x00000100,
    ///Hide the label of this property if the view normally shows the label.
    PDVF_HIDELABEL           = 0x00000200,
    ///This property should not be displayed as a column in the UI.
    PDVF_HIDDEN              = 0x00000800,
    ///This property can be wrapped to the next row.
    PDVF_CANWRAP             = 0x00001000,
    ///A mask used to retrieve all flags.
    PDVF_MASK_ALL            = 0x00001bff,
}

alias PROPDESC_DISPLAYTYPE = int;
enum : int
{
    PDDT_STRING     = 0x00000000,
    PDDT_NUMBER     = 0x00000001,
    PDDT_BOOLEAN    = 0x00000002,
    PDDT_DATETIME   = 0x00000003,
    PDDT_ENUMERATED = 0x00000004,
}

alias PROPDESC_GROUPING_RANGE = int;
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

///Used by property description helper functions, such as PSFormatForDisplay, to indicate the format of a property
///string.
alias PROPDESC_FORMAT_FLAGS = int;
enum : int
{
    ///Use the format settings specified in the property's .propdesc file.
    PDFF_DEFAULT              = 0x00000000,
    ///Precede the value with the property's display name. If the <i>hideLabelPrefix</i> attribute of the labelInfo
    ///element in the property's .propinfo file is set to <b>true</b>, then this flag is ignored.
    PDFF_PREFIXNAME           = 0x00000001,
    ///Treat the string as a file name.
    PDFF_FILENAME             = 0x00000002,
    ///Byte sizes are always displayed in KB, regardless of size. This enables clean alignment of the values in the
    ///column. This flag applies only to properties that have been declared as type <b>Integer</b> in the
    ///<i>displayType</i> attribute of the displayInfo element in the property's .propinfo file. This flag overrides the
    ///numberFormat setting.
    PDFF_ALWAYSKB             = 0x00000004,
    ///Reserved.
    PDFF_RESERVED_RIGHTTOLEFT = 0x00000008,
    ///Display time as "hh:mm am/pm".
    PDFF_SHORTTIME            = 0x00000010,
    ///Display time as "hh:mm:ss am/pm".
    PDFF_LONGTIME             = 0x00000020,
    ///Hide the time portion of <code>datetime</code>.
    PDFF_HIDETIME             = 0x00000040,
    ///Display date as "MM/DD/YY". For example, "03/21/04".
    PDFF_SHORTDATE            = 0x00000080,
    ///Display date as "DayOfWeek, Month day, year". For example, "Monday, March 21, 2009".
    PDFF_LONGDATE             = 0x00000100,
    ///Hide the date portion of <code>datetime</code>.
    PDFF_HIDEDATE             = 0x00000200,
    ///Use friendly date descriptions. For example, "Yesterday".
    PDFF_RELATIVEDATE         = 0x00000400,
    ///Return the invitation text if formatting failed or the value was empty. Invitation text is text displayed in a
    ///text box as a cue for the user, such as "Enter your name". Formatting can fail if the data entered is not of an
    ///expected type, such as when alpha characters have been entered in a phone-number field.
    PDFF_USEEDITINVITATION    = 0x00000800,
    ///If this flag is used, the <b>PDFF_USEEDITINVITATION</b> flag must also be specified. When the formatting flags
    ///are <b>PDFF_READONLY</b> | <b>PDFF_USEEDITINVITATION</b> and the algorithm would have shown invitation text, a
    ///string is returned that indicates the value is "Unknown" instead of returning the invitation text.
    PDFF_READONLY             = 0x00001000,
    ///Do not detect reading order automatically. Useful when converting to ANSI to omit the Unicode reading order
    ///characters. However, reading order characters for some values are still returned.
    PDFF_NOAUTOREADINGORDER   = 0x00002000,
}

alias PROPDESC_SORTDESCRIPTION = int;
enum : int
{
    PDSD_GENERAL          = 0x00000000,
    PDSD_A_Z              = 0x00000001,
    PDSD_LOWEST_HIGHEST   = 0x00000002,
    PDSD_SMALLEST_BIGGEST = 0x00000003,
    PDSD_OLDEST_NEWEST    = 0x00000004,
}

///Describes the relative description type for a property description, as determined by the
///<i>relativeDescriptionType</i> attribute of the displayInfo element.
alias PROPDESC_RELATIVEDESCRIPTION_TYPE = int;
enum : int
{
    ///General type.
    PDRDT_GENERAL  = 0x00000000,
    ///Date type.
    PDRDT_DATE     = 0x00000001,
    ///Size type.
    PDRDT_SIZE     = 0x00000002,
    ///Count type.
    PDRDT_COUNT    = 0x00000003,
    ///Revision type.
    PDRDT_REVISION = 0x00000004,
    ///Length type.
    PDRDT_LENGTH   = 0x00000005,
    ///Duration type.
    PDRDT_DURATION = 0x00000006,
    ///Speed type.
    PDRDT_SPEED    = 0x00000007,
    ///Rate type.
    PDRDT_RATE     = 0x00000008,
    ///Rating type.
    PDRDT_RATING   = 0x00000009,
    ///Priority type.
    PDRDT_PRIORITY = 0x0000000a,
}

///Describes how property values are displayed when multiple items are selected. For a particular property,
///PROPDESC_AGGREGATION_TYPE describes how the property should be displayed when multiple items that have a value for
///the property are selected, such as whether the values should be summed, or averaged, or just displayed with the
///default "Multiple Values" string.
alias PROPDESC_AGGREGATION_TYPE = int;
enum : int
{
    ///Display the string "Multiple Values".
    PDAT_DEFAULT   = 0x00000000,
    ///Display the first value in the selection.
    PDAT_FIRST     = 0x00000001,
    ///Display the sum of the selected values. This flag is never returned for data types <b>VT_LPWSTR</b>,
    ///<b>VT_BOOL</b>, and <b>VT_FILETIME</b>.
    PDAT_SUM       = 0x00000002,
    ///Display the numerical average of the selected values. This flag is never returned for data types
    ///<b>VT_LPWSTR</b>, <b>VT_BOOL</b>, and <b>VT_FILETIME</b>.
    PDAT_AVERAGE   = 0x00000003,
    ///Display the date range of the selected values. This flag is returned only for values of the <b>VT_FILETIME</b>
    ///data type.
    PDAT_DATERANGE = 0x00000004,
    ///Display a concatenated string of all the values. The order of individual values in the string is undefined. The
    ///concatenated string omits duplicate values; if a value occurs more than once, it appears only once in the
    ///concatenated string.
    PDAT_UNION     = 0x00000005,
    ///Display the highest of the selected values.
    PDAT_MAX       = 0x00000006,
    ///Display the lowest of the selected values.
    PDAT_MIN       = 0x00000007,
}

///Describes the condition type to use when displaying the property in the query builder UI in Windows Vista, but not in
///Windows 7 and later.
alias PROPDESC_CONDITION_TYPE = int;
enum : int
{
    ///The default value; it means the condition type is unspecified.
    PDCOT_NONE     = 0x00000000,
    ///Use the string condition type.
    PDCOT_STRING   = 0x00000001,
    ///Use the size condition type.
    PDCOT_SIZE     = 0x00000002,
    ///Use the date/time condition type.
    PDCOT_DATETIME = 0x00000003,
    ///Use the Boolean condition type.
    PDCOT_BOOLEAN  = 0x00000004,
    ///Use the number condition type.
    PDCOT_NUMBER   = 0x00000005,
}

///Determines whether and how a property is indexed by Windows Search.
alias PROPDESC_SEARCHINFO_FLAGS = int;
enum : int
{
    ///The property is not indexed.
    PDSIF_DEFAULT         = 0x00000000,
    ///The property is in an inverted index to help speed searches.
    PDSIF_ININVERTEDINDEX = 0x00000001,
    ///The property is indexed by Windows Search.
    PDSIF_ISCOLUMN        = 0x00000002,
    ///The property is indexed to save space for properties that are not present on all files.
    PDSIF_ISCOLUMNSPARSE  = 0x00000004,
    ///<b>Windows 7 and later</b>. The property mnemonics are recognized by AQS even if the property is not a column
    ///(PDSIF_ISCOLUMN).
    PDSIF_ALWAYSINCLUDE   = 0x00000008,
    ///Check this property for matches when looking for type ahead results.
    PDSIF_USEFORTYPEAHEAD = 0x00000010,
}

///Indicates whether or how a property can be indexed.
alias PROPDESC_COLUMNINDEX_TYPE = int;
enum : int
{
    ///Never generate any index on this property.
    PDCIT_NONE         = 0x00000000,
    ///Always build the individual value index, but build the vector index only on demand.
    PDCIT_ONDISK       = 0x00000001,
    ///Obsolete.
    PDCIT_INMEMORY     = 0x00000002,
    ///<b>Windows 7 and later</b>. Build the individual value index or vector index the first time the index is used in
    ///a query to filter, group, or sort. After being generated the first time, the index is maintained for future
    ///queries. Most property indexes should be built on demand, because building and maintaining indexes is expensive
    ///and they should be built only if they will be used.
    PDCIT_ONDEMAND     = 0x00000003,
    ///<b>Windows 7 and later</b>. Always build both the individual value index and the vector index.
    PDCIT_ONDISKALL    = 0x00000004,
    ///<b>Windows 7 and later</b>. Always build the vector index, but build the value index only on demand.
    PDCIT_ONDISKVECTOR = 0x00000005,
}

///Describes the filtered list of property descriptions that is returned.
alias PROPDESC_ENUMFILTER = int;
enum : int
{
    ///The list contains all property descriptions in the system.
    PDEF_ALL             = 0x00000000,
    ///The list contains system property descriptions only. It excludes third-party property descriptions that are
    ///registered on the computer.
    PDEF_SYSTEM          = 0x00000001,
    ///The list contains only third-party property descriptions that are registered on the computer.
    PDEF_NONSYSTEM       = 0x00000002,
    ///The list contains only viewable properties, where &lt;typeInfo isViewable="true"&gt;.
    PDEF_VIEWABLE        = 0x00000003,
    ///Deprecated in <b>Windows 7 and later</b>. The list contains only queryable properties, where &lt;typeInfo
    ///isViewable="true" isQueryable="true"&gt;.
    PDEF_QUERYABLE       = 0x00000004,
    ///<b>Deprecated in Windows 7 and later</b>. The list contains only properties to be included in full-text queries.
    PDEF_INFULLTEXTQUERY = 0x00000005,
    ///The list contains only properties that are columns.
    PDEF_COLUMN          = 0x00000006,
}

alias _PERSIST_SPROPSTORE_FLAGS = int;
enum : int
{
    FPSPS_DEFAULT                   = 0x00000000,
    FPSPS_READONLY                  = 0x00000001,
    FPSPS_TREAT_NEW_VALUES_AS_DIRTY = 0x00000002,
}

alias tagPSTIME_FLAGS = int;
enum : int
{
    PSTF_UTC   = 0x00000000,
    PSTF_LOCAL = 0x00000001,
}

///These flags are associated with certain PROPVARIANT structure comparisons.
alias PROPVAR_COMPARE_UNIT = int;
enum : int
{
    ///The default unit.
    PVCU_DEFAULT = 0x00000000,
    ///The second comparison unit.
    PVCU_SECOND  = 0x00000001,
    ///The minute comparison unit.
    PVCU_MINUTE  = 0x00000002,
    ///The hour comparison unit.
    PVCU_HOUR    = 0x00000003,
    ///The day comparison unit.
    PVCU_DAY     = 0x00000004,
    ///The month comparison unit.
    PVCU_MONTH   = 0x00000005,
    PVCU_YEAR    = 0x00000006,
}

alias tagPROPVAR_COMPARE_FLAGS = int;
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

alias tagPROPVAR_CHANGE_FLAGS = int;
enum : int
{
    PVCHF_DEFAULT        = 0x00000000,
    PVCHF_NOVALUEPROP    = 0x00000001,
    PVCHF_ALPHABOOL      = 0x00000002,
    PVCHF_NOUSEROVERRIDE = 0x00000004,
    PVCHF_LOCALBOOL      = 0x00000008,
    PVCHF_NOHEXSTRING    = 0x00000010,
}

alias DRAWPROGRESSFLAGS = int;
enum : int
{
    DPF_NONE             = 0x00000000,
    DPF_MARQUEE          = 0x00000001,
    DPF_MARQUEE_COMPLETE = 0x00000002,
    DPF_ERROR            = 0x00000004,
    DPF_WARNING          = 0x00000008,
    DPF_STOPPED          = 0x00000010,
}

///Specifies possible status values used in the System.SyncTransferStatus property.
alias SYNC_TRANSFER_STATUS = int;
enum : int
{
    ///There is no current sync activity.
    STS_NONE                   = 0x00000000,
    ///The file is pending upload.
    STS_NEEDSUPLOAD            = 0x00000001,
    ///The file is pending download.
    STS_NEEDSDOWNLOAD          = 0x00000002,
    ///The file is currently being uploaded or downloaded.
    STS_TRANSFERRING           = 0x00000004,
    ///The current transfer is paused.
    STS_PAUSED                 = 0x00000008,
    ///An error was encountered during the last sync operation.
    STS_HASERROR               = 0x00000010,
    ///The sync engine is retrieving metadata from the cloud.
    STS_FETCHING_METADATA      = 0x00000020,
    STS_USER_REQUESTED_REFRESH = 0x00000040,
    STS_HASWARNING             = 0x00000080,
    STS_EXCLUDED               = 0x00000100,
    STS_INCOMPLETE             = 0x00000200,
    STS_PLACEHOLDER_IFEMPTY    = 0x00000400,
}

///Specifies the states that a placeholder file can have. Retrieve this value through the System.FilePlaceholderStatus
///(PKEY_FilePlaceholderStatus) property.
alias PLACEHOLDER_STATES = int;
enum : int
{
    ///None of the other states apply at this time.
    PS_NONE                            = 0x00000000,
    ///May already be or eventually will be available offline.
    PS_MARKED_FOR_OFFLINE_AVAILABILITY = 0x00000001,
    ///The primary stream has been made fully available.
    PS_FULL_PRIMARY_STREAM_AVAILABLE   = 0x00000002,
    ///The file is accessible through a call to the CreateFile function, without requesting the opening of reparse
    ///points.
    PS_CREATE_FILE_ACCESSIBLE          = 0x00000004,
    PS_CLOUDFILE_PLACEHOLDER           = 0x00000008,
    PS_DEFAULT                         = 0x00000007,
    PS_ALL                             = 0x0000000f,
}

///Specifies property features.
alias _PROPERTYUI_FLAGS = int;
enum : int
{
    ///There are no special features defined.
    PUIF_DEFAULT          = 0x00000000,
    ///The property should be right aligned.
    PUIF_RIGHTALIGN       = 0x00000001,
    PUIF_NOLABELININFOTIP = 0x00000002,
}

///Provides operation status flags.
alias PDOPSTATUS = int;
enum : int
{
    ///Operation is running, no user intervention.
    PDOPS_RUNNING   = 0x00000001,
    ///Operation has been paused by the user.
    PDOPS_PAUSED    = 0x00000002,
    ///Operation has been canceled by the user - now go undo.
    PDOPS_CANCELLED = 0x00000003,
    ///Operation has been stopped by the user - terminate completely.
    PDOPS_STOPPED   = 0x00000004,
    PDOPS_ERRORS    = 0x00000005,
}

///Specifies values used by any sync engine to expose their internal engine states to the Property Store's
///PKEY_StorageProviderStatus value in the File Indexer To update the property, first call IShellItem2::GetPropertyStore
///with the GPS_EXTRINSICPROPERTIES flag. Next, call the IPropertyStore::SetValue method of the returned object,
///specifying the PKEY_StorageProviderStatus key, to set the property's bitmask value using these
///SYNC_ENGINE_STATE_FLAGS.
alias SYNC_ENGINE_STATE_FLAGS = int;
enum : int
{
    ///No state.
    SESF_NONE                          = 0x00000000,
    ///The user's cloud storage quota is nearing capacity. This is dependent on the user's total quota space.
    SESF_SERVICE_QUOTA_NEARING_LIMIT   = 0x00000001,
    ///The user's cloud storage quota is filled.
    SESF_SERVICE_QUOTA_EXCEEDED_LIMIT  = 0x00000002,
    ///The user's account credentials are invalid.
    SESF_AUTHENTICATION_ERROR          = 0x00000004,
    ///The sync engine is paused because of metered network settings.
    SESF_PAUSED_DUE_TO_METERED_NETWORK = 0x00000008,
    ///The drive that contains the sync engine's content has reached the maximum allowed space.
    SESF_PAUSED_DUE_TO_DISK_SPACE_FULL = 0x00000010,
    ///The user has exceeded their daily limit of requests or data transfers to the service.
    SESF_PAUSED_DUE_TO_CLIENT_POLICY   = 0x00000020,
    ///The service has requested the system to throttle requests.
    SESF_PAUSED_DUE_TO_SERVICE_POLICY  = 0x00000040,
    ///The service can't be reached at this time.
    SESF_SERVICE_UNAVAILABLE           = 0x00000080,
    SESF_PAUSED_DUE_TO_USER_REQUEST    = 0x00000100,
    SESF_ALL_FLAGS                     = 0x000001ff,
}

// Structs


///Specifies the FMTID/PID identifier that programmatically identifies a property. Replaces SHCOLUMNID.
struct PROPERTYKEY
{
    ///Type: <b>GUID</b> A unique GUID for the property.
    GUID fmtid;
    ///Type: <b>DWORD</b> A property identifier (PID). This parameter is not used as in SHCOLUMNID. It is recommended
    ///that you set this value to PID_FIRST_USABLE. Any value greater than or equal to 2 is acceptable. <div
    ///class="alert"><b>Note</b> Values of 0 and 1 are reserved and should not be used.</div> <div> </div>
    uint pid;
}

struct SERIALIZEDPROPSTORAGE
{
}

///This structure contains information from a .pif file. It is used by PifMgr_GetProperties.
struct PROPPRG
{
align (1):
    ///Type: <b>WORD</b> Flags that describe how the program will run.
    ushort    flPrg;
    ///Type: <b>WORD</b> Flags that specify the initial conditions for the application.
    ushort    flPrgInit;
    ///Type: <b>__wchar_t</b> A null-terminated string that contains the title.
    byte[30]  achTitle;
    ///Type: <b>__wchar_t</b> A null-terminated string that contains the command line, including arguments.
    byte[128] achCmdLine;
    ///Type: <b>__wchar_t</b> A null-terminated string that contains the working directory.
    byte[64]  achWorkDir;
    ///Type: <b>WORD</b> The key code of the .pif file's hotkey.
    ushort    wHotKey;
    ///Type: <b>__wchar_t</b> A null-terminated string that contains the name of the file that contains the icon.
    byte[80]  achIconFile;
    ///Type: <b>WORD</b> The index of the icon in the file specified by <b>achIconFile</b>.
    ushort    wIconIndex;
    ///Type: <b>DWORD</b> Reserved.
    uint      dwEnhModeFlags;
    ///Type: <b>DWORD</b> Flags that specify the real mode options.
    uint      dwRealModeFlags;
    ///Type: <b>__wchar_t</b> A null-terminated string that contains the name of the "other" file in the directory.
    byte[80]  achOtherFile;
    byte[260] achPIFFile;
}

// Functions

///Extracts data from a PROPVARIANT structure into a Windows Runtime property value. Note that in some cases more than
///one PROPVARIANT type maps to a single Windows Runtime property type.
///Params:
///    propvar = Reference to a source PROPVARIANT structure.
///    riid = A reference to the IID of the interface to retrieve through <i>ppv</i>, typically IID_IPropertyValue (defined in
///           Windows.Foundation.h).
///    ppv = When this method returns successfully, contains the interface pointer requested in <i>riid</i>. This is typically
///          an IPropertyValue pointer. If the call fails, this value is <b>NULL</b>.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PropVariantToWinRTPropertyValue(const(PROPVARIANT)* propvar, const(GUID)* riid, void** ppv);

///Copies the content from a Windows runtime property value to a PROPVARIANT structure.
///Params:
///    punkPropertyValue = A pointer to the IUnknown interface from which this function can access the contents of a Windows runtime
///                        property value by retrieving and using the Windows::Foundation::IPropertyValue interface.
///    ppropvar = Pointer to a PROPVARIANT structure. When this function returns, the <b>PROPVARIANT</b> contains the converted
///               info.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT WinRTPropertyValueToPropVariant(IUnknown punkPropertyValue, PROPVARIANT* ppropvar);

///Gets a formatted, Unicode string representation of a property value stored in a PROPVARIANT structure. The caller is
///responsible for allocating the output buffer.
///Params:
///    propkey = Type: <b>REFPROPERTYKEY</b> Reference to a PROPERTYKEY that names the property whose value is being retrieved.
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a PROPVARIANT structure that contains the type and value of the
///              property.
///    pdfFlags = Type: <b>PROPDESC_FORMAT_FLAGS</b> A flag that specifies the format to apply to the property string. See
///               PROPDESC_FORMAT_FLAGS for possible values.
///    pwszText = Type: <b>LPWSTR</b> When the function returns, contains a pointer to the formatted value as a null-terminated,
///               Unicode string. The calling application is responsible for allocating memory for the buffer before it calls
///               PSFormatForDisplay.
///    cchText = Type: <b>DWORD</b> Specifies the length of the buffer at <i>pwszText</i> in <b>WCHAR</b><b>s</b>, including the
///              terminating null character.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The formatted string was
///    successfully created. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%">
///    The formatted string was not created. S_FALSE indicates that an empty string resulted from a VT_EMPTY. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Indicates allocation
///    failed. </td> </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PSFormatForDisplay(const(PROPERTYKEY)* propkey, const(PROPVARIANT)* propvar, 
                           PROPDESC_FORMAT_FLAGS pdfFlags, const(wchar)* pwszText, uint cchText);

///Gets a formatted, Unicode string representation of a property value stored in a PROPVARIANT structure. This function
///allocates memory for the output string.
///Params:
///    key = Type: <b>REFPROPERTYKEY</b> Reference to a PROPERTYKEY that names the property whose value is being retrieved.
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a PROPVARIANT structure that contains the type and value of the
///              property.
///    pdff = Type: <b>PROPDESC_FORMAT_FLAGS</b> One or more flags that specify the format to apply to the property string. See
///           PROPDESC_FORMAT_FLAGS for possible values.
///    ppszDisplay = Type: <b>PWSTR*</b> When the function returns, contains a pointer to a null-terminated, Unicode string
///                  representation of the requested property value.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The formatted string was
///    successfully created. <b>S_OK</b> together with an empty return string indicates that there was an empty input
///    string or a non-empty value that was formatted as an empty string. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The formatted string was not created. S_FALSE together with
///    an empty return string indicates that the empty string resulted from a VT_EMPTY. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Indicates allocation failed. </td>
///    </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PSFormatForDisplayAlloc(const(PROPERTYKEY)* key, const(PROPVARIANT)* propvar, PROPDESC_FORMAT_FLAGS pdff, 
                                ushort** ppszDisplay);

///Gets a formatted, Unicode string representation of a property value stored in a property store. This function
///allocates memory for the output string.
///Params:
///    pps = Type: <b>IPropertyStore*</b> Pointer to an IPropertyStore, which represents the property store from which the
///          property value is taken.
///    ppd = Type: <b>IPropertyDescription*</b> Pointer to an IPropertyDescription, which represents the property whose value
///          is being retrieved.
///    pdff = Type: <b>PROPDESC_FORMAT_FLAGS</b> One or more PROPDESC_FORMAT_FLAGS that specify the format to apply to the
///           property string. See <b>PROPDESC_FORMAT_FLAGS</b> for possible values.
///    ppszDisplay = Type: <b>LPWSTR*</b> When the function returns, contains a pointer to the formatted value as a null-terminated,
///                  Unicode string.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSFormatPropertyValue(IPropertyStore pps, IPropertyDescription ppd, PROPDESC_FORMAT_FLAGS pdff, 
                              ushort** ppszDisplay);

///Gets an instance of a property description interface for a specified property.
///Params:
///    propkey = Type: <b>REFPROPERTYKEY</b> A reference to a PROPERTYKEY structure that specifies the property.
///    propvar = Type: <b>REFIID</b> A reference to the IID of the interface to retrieve through <i>ppv</i>.
///    ppszImageRes = Type: <b>void**</b> When this function returns successfully, contains the interface pointer requested in
///                   <i>riid</i>.
///Returns:
///    Type: <b>HRESULT</b> Returns <b>S_OK</b> if successful, or an error value otherwise, including the following:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TYPE_E_ELEMENTNOTFOUND</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PSGetImageReferenceForValue(const(PROPERTYKEY)* propkey, const(PROPVARIANT)* propvar, 
                                    ushort** ppszImageRes);

///Creates a string that identifies a property from that property's key.
///Params:
///    pkey = Type: <b>REFPROPERTYKEY</b> Reference to a PROPERTYKEY structure that identifies a property.
///    psz = Type: <b>LPWSTR</b> Pointer to a buffer that receives the output string. The buffer should be large enough to
///          contain PKEYSTR_MAX <b>WCHAR</b><b>s</b>.
///    cch = Type: <b>UINT</b> The length of the buffer pointed to by <i>psz</i>, in <b>WCHAR</b><b>s</b>.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSStringFromPropertyKey(const(PROPERTYKEY)* pkey, const(wchar)* psz, uint cch);

///Converts a string to a PROPERTYKEY structure.
///Params:
///    pszString = Type: <b>LPCWSTR</b> Pointer to a null-terminated, Unicode string to be converted.
///    pkey = Type: <b>PROPERTYKEY*</b> When this function returns, contains a pointer to a PROPERTYKEY structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyKeyFromString(const(wchar)* pszString, PROPERTYKEY* pkey);

///Creates an in-memory property store.
///Params:
///    riid = Type: <b>REFIID</b> Reference to the requested interface ID.
///    ppv = Type: <b>void**</b> When this function returns, contains a pointer to the desired interface, typically
///          IPropertyStore or IPersistSerializedPropStorage.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSCreateMemoryPropertyStore(const(GUID)* riid, void** ppv);

///Creates a read-only, delayed-binding property store that contains multiple property stores.
///Params:
///    flags = Type: <b>GETPROPERTYSTOREFLAGS</b> One or more GETPROPERTYSTOREFLAGS values. These values specify details of the
///            created property store object.
///    pdpsf = Type: <b>IDelayedPropertyStoreFactory*</b> Interface pointer to an instance of IDelayedPropertyStoreFactory.
///    rgStoreIds = Type: <b>const DWORD*</b> Pointer to an array of property store IDs. This array does not need to be initialized.
///    cStores = Type: <b>DWORD</b> The number of elements in the array pointed to by <i>rgStoreIds</i>.
///    riid = Type: <b>REFIID</b> Reference to the requested IID of the interface that will represent the created property
///           store.
///    ppv = Type: <b>void**</b> When this function returns, contains the interface pointer requested in <i>riid</i>. This is
///          typically IPropertyStore.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSCreateDelayedMultiplexPropertyStore(GETPROPERTYSTOREFLAGS flags, IDelayedPropertyStoreFactory pdpsf, 
                                              char* rgStoreIds, uint cStores, const(GUID)* riid, void** ppv);

///Creates a read-only property store that contains multiple property stores, each of which must support either
///IPropertyStore or IPropertySetStorage.
///Params:
///    prgpunkStores = Type: <b>IUnknown**</b> Address of a pointer to an array of property stores that implement either IPropertyStore
///                    or IPropertySetStorage.
///    cStores = Type: <b>DWORD</b> The number of elements in the array referenced in <i>prgpunkStores</i>.
///    riid = Type: <b>REFIID</b> Reference to the requested IID.
///    ppv = Type: <b>void**</b> When this function returns, contains the interface pointer requested in <i>riid</i>. This is
///          typically IPropertyStore.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSCreateMultiplexPropertyStore(char* prgpunkStores, uint cStores, const(GUID)* riid, void** ppv);

///Creates a container for a set of IPropertyChange objects. This container can be used with IFileOperation to apply a
///set of property changes to a set of files.
///Params:
///    rgpropkey = Type: <b>const PROPERTYKEY*</b> Pointer to an array of PROPERTYKEY structures that name the specific properties
///                whose changes are being stored. If this value is <b>NULL</b>, <i>cChanges</i> must be 0.
///    rgflags = Type: <b>const PKA_FLAGS*</b> Pointer to an array of PKA_FLAGS values. If this value is <b>NULL</b>,
///              <i>cChanges</i> must be 0.
///    rgpropvar = Type: <b>const PROPVARIANT*</b> Pointer to an array of PROPVARIANT structures. If this value is <b>NULL</b>,
///                <i>cChanges</i> must be 0.
///    cChanges = Type: <b>UINT</b> Count of changes to be applied. This is the number of elements in each of the arrays
///               <i>rgpropkey</i>, <i>rgflags</i>, and <i>rgpropvar</i>.
///    riid = Type: <b>REFIID</b> Reference to the ID of the requested interface.
///    ppv = Type: <b>void**</b> When this function returns, contains the interface pointer requested in <i>riid</i>. This is
///          typically IPropertyChangeArray.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSCreatePropertyChangeArray(char* rgpropkey, char* rgflags, char* rgpropvar, uint cChanges, 
                                    const(GUID)* riid, void** ppv);

///Creates a simple property change.
///Params:
///    flags = Type: <b>PKA_FLAGS</b> PKA_FLAGS flags.
///    key = Type: <b>REFPROPERTYKEY</b> Reference to a PROPERTYKEY structure.
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a PROPVARIANT structure.
///    riid = Type: <b>REFIID</b> Reference to a specified IID.
///    ppv = Type: <b>void**</b> The address of an IPropertyChange interface pointer.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSCreateSimplePropertyChange(PKA_FLAGS flags, const(PROPERTYKEY)* key, const(PROPVARIANT)* propvar, 
                                     const(GUID)* riid, void** ppv);

///Gets an instance of a property description interface for a property specified by a PROPERTYKEY structure.
///Params:
///    propkey = Type: <b>REFPROPERTYKEY</b> Reference to a PROPERTYKEY.
///    riid = Type: <b>REFIID</b> Reference to the interface ID of the requested interface.
///    ppv = Type: <b>void**</b> When this function returns, contains the interface pointer requested in <i>riid</i>. This is
///          typically IPropertyDescription, IPropertyDescriptionAliasInfo, or IPropertyDescriptionSearchInfo.
///Returns:
///    Type: <b>PSSTDAPI</b> Returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The interface was obtained.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>ppv</i>
///    parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_ELEMENTNOTFOUND</b></dt> </dl>
///    </td> <td width="60%"> The PROPERTYKEY does not exist in the schema subsystem cache. </td> </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PSGetPropertyDescription(const(PROPERTYKEY)* propkey, const(GUID)* riid, void** ppv);

///Gets an instance of a property description interface for a specified property name.
///Params:
///    pszCanonicalName = Type: <b>LPCWSTR</b> A pointer to a null-terminated, Unicode string that identifies the property.
///    riid = Type: <b>REFIID</b> Reference to the interface ID of the requested property.
///    ppv = Type: <b>void**</b> When this function returns, contains the interface pointer requested in <i>riid</i>. This is
///          typically IPropertyDescription, IPropertyDescriptionAliasInfo, or IPropertyDescriptionSearchInfo.
///Returns:
///    Type: <b>PSSTDAPI</b> Returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The interface was obtained.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
///    <i>pszCanonicalName</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TYPE_E_ELEMENTNOTFOUND</b></dt> </dl> </td> <td width="60%"> The canonical name does not exist in the
///    schema subsystem cache. </td> </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PSGetPropertyDescriptionByName(const(wchar)* pszCanonicalName, const(GUID)* riid, void** ppv);

///Gets the class identifier (CLSID) of a per-computer, registered file property handler.
///Params:
///    pszFilePath = Type: <b>PCWSTR</b> Pointer to a null-terminated, Unicode buffer that contains the absolute path of the file
///                  whose property handler CLSID is requested.
///    pclsid = Type: <b>CLSID*</b> When this function returns, contains the requested property handler CLSID.
///Returns:
///    Type: <b>PSSTDAPI</b> Returns <b>S_OK</b> if successful, or an error value otherwise.
///    
@DllImport("PROPSYS")
HRESULT PSLookupPropertyHandlerCLSID(const(wchar)* pszFilePath, GUID* pclsid);

///Retrieves a property handler for a Shell item.
///Params:
///    punkItem = Type: <b>IUnknown*</b> A pointer to the IUnknown interface of a Shell item that supports IShellItem. <b>Windows
///               XP:</b> Use SHCreateShellItem to create the Shell item. <b>Windows Vista:</b> Use SHCreateItemFromIDList,
///               SHCreateItemFromParsingName, SHCreateItemFromRelativeName, SHCreateItemInKnownFolder, or SHCreateItemWithParent
///               to create the Shell item.
///    fReadWrite = Type: <b>BOOL</b> <b>TRUE</b> to retrieve a read/write property handler. <b>FALSE</b> to retrieve a read-only
///                 property handler.
///    riid = Type: <b>REFIID</b> Reference to the IID of the interface the handler object should return. This should be
///           IPropertyStore or an interface derived from <b>IPropertyStore</b>.
///    ppv = Type: <b>void**</b> When this function returns, contains the interface pointer requested in <i>riid</i>.
///Returns:
///    Type: <b>PSSTDAPI</b> Returns <b>S_OK</b> if successful, or an error value otherwise.
///    
@DllImport("PROPSYS")
HRESULT PSGetItemPropertyHandler(IUnknown punkItem, BOOL fReadWrite, const(GUID)* riid, void** ppv);

///Retrieves a property handler for a Shell item.
///Params:
///    punkItem = Type: <b>IUnknown*</b> A pointer to the IUnknown interface of a Shell item that supports IShellItem. <b>Windows
///               XP:</b> Use SHCreateShellItem to create the Shell item. <b>Windows Vista:</b> Use SHCreateItemFromIDList,
///               SHCreateItemFromParsingName, SHCreateItemFromRelativeName, SHCreateItemInKnownFolder, or SHCreateItemWithParent
///               to create the Shell item.
///    fReadWrite = Type: <b>BOOL</b> <b>TRUE</b> to retrieve a read/write property handler. <b>FALSE</b> to retrieve a read-only
///                 property handler.
///    punkCreateObject = Type: <b>IUnknown*</b> Pointer to the IUnknown interface of a class factory object that supports ICreateObject.
///    riid = Type: <b>REFIID</b> A reference to the IID of the interface to retrieve through <i>ppv</i>.
///    ppv = Type: <b>void**</b> When this function returns successfully, contains the interface pointer requested in
///          <i>riid</i>. This is typically IPropertyStore or IPropertyStoreCapabilities.
///Returns:
///    Type: <b>PSSTDAPI</b> Returns <b>S_OK</b> if successful, or an error value otherwise.
///    
@DllImport("PROPSYS")
HRESULT PSGetItemPropertyHandlerWithCreateObject(IUnknown punkItem, BOOL fReadWrite, IUnknown punkCreateObject, 
                                                 const(GUID)* riid, void** ppv);

///Gets a property value from a property store.
///Params:
///    pps = Type: <b>IPropertyStore*</b> Pointer to an instance of the IPropertyStore interface, which represents the
///          property store from which to get the value.
///    ppd = Type: <b>IPropertyDescription*</b> Pointer to an instance of the IPropertyDescription interface, which represents
///          the property in the property store.
///    ppropvar = Type: <b>PROPVARIANT*</b> Pointer to an uninitialized PROPVARIANT structure. When this function returns, points
///               to the requested property value.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSGetPropertyValue(IPropertyStore pps, IPropertyDescription ppd, PROPVARIANT* ppropvar);

///Sets the value of a property in a property store.
///Params:
///    pps = Type: <b>IPropertyStore*</b> Pointer to an instance of the IPropertyStore interface, which represents the
///          property store that contains the property.
///    ppd = Type: <b>IPropertyDescription*</b> Pointer to an instance of the IPropertyDescription interface, which identifies
///          the individual property.
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a PROPVARIANT structure that contains the new value.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSSetPropertyValue(IPropertyStore pps, IPropertyDescription ppd, const(PROPVARIANT)* propvar);

///Informs the schema subsystem of the addition of a property description schema file.
///Params:
///    pszPath = Type: <b>PCWSTR</b> Pointer to the full file path, as a Unicode string, to the property description schema
///              (.propdesc) file on the local machine. This can be either a fully-specified full path, or a full path that
///              includes environment variables such as <code>%PROGRAMFILES%</code>.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> All property descriptions in
///    the schema were registered. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
///    width="60%"> The calling context does not have proper privileges. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>INPLACE_S_TRUNCATED</b></dt> </dl> </td> <td width="60%"> One or more property descriptions in the schema
///    failed to register. The specific failures are logged in the application event log. </td> </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PSRegisterPropertySchema(const(wchar)* pszPath);

///Informs the schema subsystem of the removal of a property description schema file.
///Params:
///    pszPath = Type: <b>PCWSTR</b> Pointer to the full file path, as a Unicode string, to the property description schema
///              (.propdesc) file on the local machine. This can be either a fully-specified full path, or a full path that
///              includes environment variables such as <code>%PROGRAMFILES%</code>.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The schema was unregistered.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The calling
///    context does not have proper privileges. </td> </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PSUnregisterPropertySchema(const(wchar)* pszPath);

///Not supported. It is valid to call this function, but it is not implemented to perform any function so there is no
///reason to do so.
@DllImport("PROPSYS")
HRESULT PSRefreshPropertySchema();

///A wrapper API that calls the schema subsystem's IPropertySystem::EnumeratePropertyDescriptions. This function
///retrieves an instance of the subsystem object that implements IPropertyDescriptionList, to obtain either the entire
///list or a partial list of property descriptions in the system.
///Params:
///    filterOn = Type: <b>PROPDESC_ENUMFILTER</b> The list to return. PROPDESC_ENUMFILTER shows the valid values for this method.
///    riid = Type: <b>REFIID</b> Reference to the interface ID of the requested interface.
///    ppv = Type: <b>void**</b> The address of an IPropertyDescriptionList interface pointer.
///Returns:
///    Type: <b>PSSTDAPI</b> Returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Indicates an interface is
///    obtained. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
///    Indicates that <i>ppv</i> is <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PSEnumeratePropertyDescriptions(PROPDESC_ENUMFILTER filterOn, const(GUID)* riid, void** ppv);

///Gets the property key for a canonical property name.
///Params:
///    pszName = Type: <b>PCWSTR</b> Pointer to a property name as a null-terminated, Unicode string.
///    ppropkey = Type: <b>PROPERTYKEY*</b> When this function returns, contains the requested property key.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Property key structure was
///    obtained. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
///    <i>pszName</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TYPE_E_ELEMENTNOTFOUND</b></dt> </dl> </td> <td width="60%"> The canonical property name does not exist in
///    the schema subsystem cache. </td> </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PSGetPropertyKeyFromName(const(wchar)* pszName, PROPERTYKEY* ppropkey);

///Retrieves the canonical name of the property, given its PROPERTYKEY.
///Params:
///    propkey = Type: <b>REFPROPERTYKEY</b> Reference to a PROPERTYKEY structure that identifies the requested property.
///    ppszCanonicalName = Type: <b>PWSTR*</b> When this function returns, contains a pointer to the property name as a null-terminated
///                        Unicode string.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The property's canonical name
///    is obtained. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_ELEMENTNOTFOUND</b></dt> </dl> </td> <td
///    width="60%"> Indicates that the PROPERTYKEY does not exist in the schema subsystem cache. </td> </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PSGetNameFromPropertyKey(const(PROPERTYKEY)* propkey, ushort** ppszCanonicalName);

///Converts the value of a property to the canonical value, according to the property description.
///Params:
///    key = Type: <b>REFPROPERTYKEY</b> Reference to a PROPERTYKEY structure that identifies the property whose value is to
///          be coerced.
///    ppropvar = Type: <b>PROPVARIANT*</b> On entry, contains a pointer to a PROPVARIANT structure that contains the original
///               value. When this function returns successfully, contains the canonical value.
///Returns:
///    Type: <b>HRESULT</b> Possible return values include the following: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
///    function succeeded. The property value specified by <i>ppropvar</i> is now in a canonical form. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>INPLACE_S_TRUNCATED</b></dt> </dl> </td> <td width="60%"> The property value
///    specified by <i>ppropvar</i> is now in a truncated, canonical form. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>ppropvar</i> parameter is invalid. The
///    PROPVARIANT structure has been cleared. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TYPE_E_TYPEMISMATCH</b></dt> </dl> </td> <td width="60%"> Coercion from the value's type to the property
///    description's type was not possible. The PROPVARIANT structure has been cleared. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>Any other failure code</b></dt> </dl> </td> <td width="60%"> Coercion from the value's
///    type to the property description's type was not possible. The PROPVARIANT structure has been cleared. </td> </tr>
///    </table>
///    
@DllImport("PROPSYS")
HRESULT PSCoerceToCanonicalValue(const(PROPERTYKEY)* key, PROPVARIANT* ppropvar);

///Gets an instance of a property description list interface for a specified property list.
///Params:
///    pszPropList = Type: <b>LPCWSTR</b> Pointer to a null-terminated, Unicode string that identifies the property list. See
///                  IPropertySystem::GetPropertyDescriptionListFromString for more information about the format of this parameter.
///    riid = Type: <b>REFIID</b> Reference to the interface ID of the requested interface.
///    ppv = Type: <b>void**</b> When this function returns, contains the interface pointer requested in <i>riid</i>. This is
///          typically IPropertyDescriptionList.
///Returns:
///    Type: <b>PSSTDAPI</b> Returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The interface was obtained.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>ppv</i>
///    parameter is <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PSGetPropertyDescriptionListFromString(const(wchar)* pszPropList, const(GUID)* riid, void** ppv);

///Wraps an IPropertySetStorage interface in an IPropertyStore interface.
///Params:
///    ppss = Type: <b>IPropertySetStorage*</b> A pointer to an IPropertySetStorage interface.
///    grfMode = Type: <b>DWORD</b> Specifies the access mode to enforce. grfMode should match the access mode used to open the
///              IPropertySetStorage. Valid values are as follows:
///    riid = Type: <b>REFIID</b> Reference to an IID.
///    ppv = Type: <b>void**</b> When this function returns, contains the interface pointer specified in <i>riid</i>.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSCreatePropertyStoreFromPropertySetStorage(IPropertySetStorage ppss, uint grfMode, const(GUID)* riid, 
                                                    void** ppv);

///Accepts the IUnknown interface of an object that supports IPropertyStore or IPropertySetStorage. If the object
///supports <b>IPropertySetStorage</b>, it is wrapped so that it supports <b>IPropertyStore</b>.
///Params:
///    punk = Type: <b>IUnknown*</b> A pointer to an interface that supports either IPropertyStore or IPropertySetStorage.
///    grfMode = Type: <b>DWORD</b> Specifies the access mode to use. One of these values:
///    riid = Type: <b>REFIID</b> Reference to the requested IID.
///    ppv = Type: <b>void**</b> When this function returns successfully, contains the address of a pointer to an interface
///          guaranteed to support IPropertyStore.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSCreatePropertyStoreFromObject(IUnknown punk, uint grfMode, const(GUID)* riid, void** ppv);

///Creates an adapter from an IPropertyStore.
///Params:
///    pps = Type: <b>IPropertyStore*</b> Pointer to an IPropertyStore object that represents the property store.
///    riid = Type: <b>REFIID</b> Reference to an IID.
///    ppv = Type: <b>void**</b> When this function returns, contains the interface pointer requested in <i>riid</i>.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSCreateAdapterFromPropertyStore(IPropertyStore pps, const(GUID)* riid, void** ppv);

///Gets an instance of the subsystem object that implements IPropertySystem.
///Params:
///    riid = Type: <b>REFIID</b> Reference to the IID of the requested interface.
///    ppv = Type: <b>void**</b> When this function returns, contains the interface pointer requested in <i>riid</i>. This is
///          typically IPropertySystem.
///Returns:
///    Type: <b>PSSTDAPI</b> Returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The interface was obtained.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>ppv</i>
///    parameter is <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PSGetPropertySystem(const(GUID)* riid, void** ppv);

///Gets the value of a property as stored in serialized property storage.
///Params:
///    psps = Type: <b>PCUSERIALIZEDPROPSTORAGE</b> Pointer to an allocated buffer that contains the serialized properties.
///           This buffer is obtained by a call to IPersistSerializedPropStorage::GetPropertyStorage.
///    cb = Type: <b>DWORD</b> The size, in bytes, of the <b>USERIALIZESPROPSTORAGE</b> buffer pointed to by <i>psps</i>.
///    rpkey = Type: <b>REFPROPERTYKEY</b> Reference to the PROPERTYKEY that identifies the property for which to get the value.
///    ppropvar = Type: <b>PROPVARIANT**</b> When this function returns, contains the requested value.
///Returns:
///    Type: <b>PSSTDAPI</b> Returns <b>S_OK</b> if successful, or an error value otherwise.
///    
@DllImport("PROPSYS")
HRESULT PSGetPropertyFromPropertyStorage(char* psps, uint cb, const(PROPERTYKEY)* rpkey, PROPVARIANT* ppropvar);

///Gets a value from serialized property storage by property name.
///Params:
///    psps = Type: <b>PCUSERIALIZEDPROPSTORAGE</b> A pointer to an allocated buffer that contains the serialized properties.
///           Call IPersistSerializedPropStorage::GetPropertyStorage to obtain the buffer.
///    cb = Type: <b>DWORD</b> The size, in bytes, of the USERIALIZESPROPSTORAGE buffer pointed to by <i>psps</i>.
///    pszName = Type: <b>LPCWSTR</b> A pointer to a null-terminated, Unicode string that contains the name of the property.
///    ppropvar = Type: <b>PROPVARIANT*</b> When this function returns, contains the requested value.
///Returns:
///    Type: <b>PSSTDAPI</b> Returns <b>S_OK</b> if successful, or an error value otherwise.
///    
@DllImport("PROPSYS")
HRESULT PSGetNamedPropertyFromPropertyStorage(char* psps, uint cb, const(wchar)* pszName, PROPVARIANT* ppropvar);

///Reads the type of data value of a property that is stored in a property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object, that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A pointer to a null-terminated property name string.
///    var = Type: <b>VARIANT*</b> Returns on successful function completion a pointer to a <b>VARIANT</b> data type that
///          contains the property value.
///    type = Type: <b>VARTYPE*</b> If <i>type</i> is VT_EMPTY, this function reads the <b>VARIANT</b> of the property in the
///           IPropertyBag <i>propBag</i> parameter. If <i>type</i> is not VT_EMPTY and not the same as the <b>VARIANT</b>
///           read, then this function attempts to convert the <b>VARIANT</b> read to the <b>VARTYPE</b> defined by <i>type</i>
///           parameter before returning.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadType(IPropertyBag propBag, const(wchar)* propName, VARIANT* var, ushort type);

///Reads the string data value of a property in a property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A null-terminated property name string.
///    value = Type: <b>LPCWSTR</b> When this function returns, contains a pointer to a string property value.
///    characterCount = Type: <b>int</b> This function returns the integer that represents the size (maximum number of characters) of the
///                     <i>value</i> parameter being returned.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadStr(IPropertyBag propBag, const(wchar)* propName, const(wchar)* value, 
                              int characterCount);

///Reads a string data value from a property in a property bag and allocates memory for the string that is read.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A pointer to a null-terminated property name string.
///    value = Type: <b>PWSTR*</b> When this function returns, contains a pointer to a string data value from a property in a
///            property bag and allocates memory for the string that is read. The caller of the PSPropertyBag_ReadStrAlloc
///            function needs to call a CoTaskMemFree function on this parameter.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadStrAlloc(IPropertyBag propBag, const(wchar)* propName, ushort** value);

///Reads a <b>BSTR</b> data value from a property in a property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A null-terminated property name string.
///    value = Type: <b>BSTR*</b> When this function returns, contains a pointer to a <b>BSTR</b> property value.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadBSTR(IPropertyBag propBag, const(wchar)* propName, BSTR* value);

///Sets the string value of a property in a property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A null-terminated property name string.
///    value = Type: <b>LPCWSTR</b> The string value to which the property should be set.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_WriteStr(IPropertyBag propBag, const(wchar)* propName, const(wchar)* value);

///Sets the <b>BSTR</b> value of a property in a property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A null-terminated property name string.
///    value = Type: <b>BSTR</b> The <b>BSTR</b> value to which the named property should be set.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_WriteBSTR(IPropertyBag propBag, const(wchar)* propName, BSTR value);

///Reads an <b>int</b> data value from a property in a property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A null-terminated property name string.
///    value = Type: <b>int*</b> When this function returns, contains a pointer to an <b>int</b> property value.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadInt(IPropertyBag propBag, const(wchar)* propName, int* value);

///Sets the <b>int</b> value of a property in a property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A null-terminated property name string.
///    value = Type: <b>int</b> The <b>int</b> value to which the property should be set.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_WriteInt(IPropertyBag propBag, const(wchar)* propName, int value);

///Reads the SHORT data value of a property in a property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A null-terminated property name string.
///    value = Type: <b>SHORT*</b> When this function returns, contains a pointer to a SHORT property value.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadSHORT(IPropertyBag propBag, const(wchar)* propName, short* value);

///Sets the SHORT value of a property in a property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A null-terminated property name string.
///    value = Type: <b>SHORT</b> The SHORT value to which the property should be set.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_WriteSHORT(IPropertyBag propBag, const(wchar)* propName, short value);

///Reads a <b>LONG</b> data value from a property in a property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A null-terminated property name string.
///    value = Type: <b>LONG*</b> When this function returns, contains a pointer to a <b>LONG</b> property value.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadLONG(IPropertyBag propBag, const(wchar)* propName, int* value);

///Sets the <b>LONG</b> value of a property in a property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A null-terminated property name string.
///    value = Type: <b>LONG</b> The <b>LONG</b> value to which the property should be set.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_WriteLONG(IPropertyBag propBag, const(wchar)* propName, int value);

///Reads a <b>DWORD</b> data value from property in a property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A pointer to a null-terminated property name string.
///    value = Type: <b>DWORD*</b> When this function returns, contains a pointer to a <b>DWORD</b> property value.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadDWORD(IPropertyBag propBag, const(wchar)* propName, uint* value);

///Sets the <b>DWORD</b> value of a property in a property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A null-terminated property name string.
///    value = Type: <b>DWORD</b> A <b>DWORD</b> value to which the named property should be set.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_WriteDWORD(IPropertyBag propBag, const(wchar)* propName, uint value);

///Reads the <b>BOOL</b> data value of a property in a property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A null-terminated property name string.
///    value = Type: <b>BOOL*</b> When this function returns successfully, contains a pointer to the value read from the
///            property.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadBOOL(IPropertyBag propBag, const(wchar)* propName, int* value);

///Sets the <b>BOOL</b> value of a property in a property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A null-terminated property name string.
///    value = Type: <b>BOOL</b> The <b>BOOL</b> value to which the named property should be set.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_WriteBOOL(IPropertyBag propBag, const(wchar)* propName, BOOL value);

///Retrieves the property coordinates stored in a POINTL structure of a specified property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A null-terminated property name string.
///    value = Type: <b>POINTL*</b> When this function returns, contains a pointer to a POINTL structure that contains the
///            property coordinates.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadPOINTL(IPropertyBag propBag, const(wchar)* propName, POINTL* value);

///Stores the property coordinates in aPOINTL structure of a specified property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A null-terminated property name string.
///    value = Type: <b>const POINTL*</b> A pointer to a POINTL structure that specifies the coordinates to store in the
///            property.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_WritePOINTL(IPropertyBag propBag, const(wchar)* propName, const(POINTL)* value);

///Retrieves the property coordinates stored in a POINTS structure of a specified property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A null-terminated property name string.
///    value = Type: <b>POINTS*</b> When this function returns successfully, contains a pointer to a POINTS structure that
///            contains the property coordinates.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadPOINTS(IPropertyBag propBag, const(wchar)* propName, POINTS* value);

///Stores the property coordinates in aPOINTS structure of a specified property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A null-terminated property name string.
///    value = Type: <b>const POINTS*</b> Pointer to a POINTS structure that specifies the coordinates to store in the property.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_WritePOINTS(IPropertyBag propBag, const(wchar)* propName, const(POINTS)* value);

///Retrieves the coordinates of a rectangle stored in a property contained in a specified property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A null-terminated property name string.
///    value = Type: <b>RECTL*</b> When this function returns, contains a pointer to a RECTL structure that contains the
///            property coordinates.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadRECTL(IPropertyBag propBag, const(wchar)* propName, RECTL* value);

///Stores the coordinates of a rectangle in a property in a property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A null-terminated property name string.
///    value = Type: <b>const RECTL*</b> A pointer to a RECTL structure that specifies the coordinates to store in the property.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_WriteRECTL(IPropertyBag propBag, const(wchar)* propName, const(RECTL)* value);

///Reads the data stream stored in a given property contained in a specified property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object, that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A pointer to a null-terminated property name string.
///    value = Type: <b>IStream**</b> The address of a pointer that, when this function returns successfully, receives the
///            IStream object.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadStream(IPropertyBag propBag, const(wchar)* propName, IStream* value);

///Writes a data stream to a property in a property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A null-terminated property name string.
///    value = Type: <b>IStream*</b> A pointer to the IStream object to write to the property.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_WriteStream(IPropertyBag propBag, const(wchar)* propName, IStream value);

///Deletes a property from a property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A null-terminated property name string.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_Delete(IPropertyBag propBag, const(wchar)* propName);

///Reads a <b>ULONGLONG</b> data value from a property in a property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A null-terminated property name string.
///    value = Type: <b>ULONGLONG</b> When this function returns, contains a pointer to a <b>ULONGLONG</b> property value.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadULONGLONG(IPropertyBag propBag, const(wchar)* propName, ulong* value);

///Sets the <b>ULONGLONG</b> value of a property in a property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A null-terminated property name string.
///    value = Type: <b>ULONGLONG</b> An <b>ULONGLONG</b> value to which the property should be set.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_WriteULONGLONG(IPropertyBag propBag, const(wchar)* propName, ulong value);

///Reads a given property of an unknown data value in a property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object, that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A pointer to a null-terminated property name string.
///    riid = Type: <b>REFIID</b> A reference to the IID of the interface to retrieve through <i>ppv</i>. This interface IID
///           should be IPropertyBag or an interface derived from <b>IPropertyBag</b>.
///    ppv = Type: <b>void**</b> When this method returns successfully, contains the interface pointer requested in
///          <i>riid</i>. This is typically <i>riid</i>.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadUnknown(IPropertyBag propBag, const(wchar)* propName, const(GUID)* riid, void** ppv);

///Writes a property of an unknown data value in a property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A pointer to a null-terminated property name string.
///    punk = Type: <b>IUnknown*</b> A pointer to an IUnknown derived interface that copies the specified property of an
///           unknown data value in a property bag.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_WriteUnknown(IPropertyBag propBag, const(wchar)* propName, IUnknown punk);

///Reads the GUID data value from a property in a property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A null-terminated property name string.
///    value = Type: <b>GUID*</b> When this function returns, contains a pointer to a GUID property value.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadGUID(IPropertyBag propBag, const(wchar)* propName, GUID* value);

///Sets the GUID value of a property in a property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A null-terminated property name string.
///    value = Type: <b>const GUID*</b> A pointer to a GUID value to which the named property should be set.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_WriteGUID(IPropertyBag propBag, const(wchar)* propName, const(GUID)* value);

///Reads the property key of a property in a specified property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A null-terminated property name string.
///    value = Type: <b>PROPERTYKEY*</b> When this function returns, contains a pointer to a property key value.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_ReadPropertyKey(IPropertyBag propBag, const(wchar)* propName, PROPERTYKEY* value);

///Sets the property key value of a property in a property bag.
///Params:
///    propBag = Type: <b>IPropertyBag*</b> A pointer to an IPropertyBag object that represents the property bag in which the
///              property is stored.
///    propName = Type: <b>LPCWSTR</b> A null-terminated property name string.
///    value = Type: <b>REFPROPERTYKEY</b> A PROPERTYKEY structure that specifies the property key value to store in the
///            property.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PSPropertyBag_WritePropertyKey(IPropertyBag propBag, const(wchar)* propName, const(PROPERTYKEY)* value);

///Initializes a PROPVARIANT structure based on a string resource embedded in an executable file.
///Params:
///    hinst = Type: <b>HINSTANCE</b> Handle to an instance of the module whose executable file contains the string resource.
///    id = Type: <b>UINT</b> Integer identifier of the string to be loaded.
///    ppropvar = Type: <b>PROPVARIANT*</b> When this function returns, contains the initialized PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitPropVariantFromResource(HINSTANCE hinst, uint id, PROPVARIANT* ppropvar);

///Initializes a PROPVARIANT structure using the contents of a buffer.
///Params:
///    pv = Type: <b>const void*</b> Pointer to the buffer.
///    cb = Type: <b>UINT</b> The length of the buffer, in bytes.
///    ppropvar = Type: <b>PROPVARIANT*</b> When this function returns, contains the initialized PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitPropVariantFromBuffer(char* pv, uint cb, PROPVARIANT* ppropvar);

///Initializes a PROPVARIANT structure based on a class identifier (CLSID).
///Params:
///    clsid = Type: <b>REFCLSID</b> Reference to the CLSID.
///    ppropvar = Type: <b>PROPVARIANT*</b> When this function returns, contains the initialized PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitPropVariantFromCLSID(const(GUID)* clsid, PROPVARIANT* ppropvar);

///Initializes a PROPVARIANT structure based on a <b>GUID</b>. The structure is initialized as VT_LPWSTR.
///Params:
///    guid = Type: <b>REFGUID</b> Reference to the source <b>GUID</b>.
///    ppropvar = Type: <b>PROPVARIANT*</b> When this function returns, contains the initialized PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitPropVariantFromGUIDAsString(const(GUID)* guid, PROPVARIANT* ppropvar);

///Initializes a PROPVARIANT structure based on information stored in a FILETIME structure.
///Params:
///    pftIn = Type: <b>const FILETIME*</b> Pointer to the date and time as a FILETIME structure.
///    ppropvar = Type: <b>PROPVARIANT*</b> When this function returns, contains the initialized PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitPropVariantFromFileTime(const(FILETIME)* pftIn, PROPVARIANT* ppropvar);

///Initializes a PROPVARIANT structure based on a specified <b>PROPVARIANT</b> vector element.
///Params:
///    propvarIn = Type: <b>REFPROPVARIANT</b> The source PROPVARIANT structure.
///    iElem = Type: <b>ULONG</b> The index of the source PROPVARIANT structure element.
///    ppropvar = Type: <b>PROPVARIANT*</b> When this function returns, contains the initialized PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitPropVariantFromPropVariantVectorElem(const(PROPVARIANT)* propvarIn, uint iElem, PROPVARIANT* ppropvar);

///Initializes a vector element in a PROPVARIANT structure with a value stored in another <b>PROPVARIANT</b>.
///Params:
///    propvarSingle = Type: <b>REFPROPVARIANT</b> Reference to the source PROPVARIANT structure that contains a single value.
///    ppropvarVector = Type: <b>PROPVARIANT*</b> When this function returns, contains the initialized PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitPropVariantVectorFromPropVariant(const(PROPVARIANT)* propvarSingle, PROPVARIANT* ppropvarVector);

///Initializes a PROPVARIANT structure based on a string stored in a STRRET structure.
///Params:
///    pstrret = Type: <b>STRRET*</b> Pointer to a STRRET structure that contains the string.
///    pidl = Type: <b>PCUITEMID_CHILD</b> PIDL of the item whose details are being retrieved.
///    ppropvar = Type: <b>PROPVARIANT*</b> When this function returns, contains the initialized PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitPropVariantFromStrRet(STRRET* pstrret, ITEMIDLIST* pidl, PROPVARIANT* ppropvar);

///Initializes a PROPVARIANT structure from a specified Boolean vector.
///Params:
///    prgf = Type: <b>const BOOL*</b> Pointer to the Boolean vector used to initialize the structure. If this parameter is
///           <b>NULL</b>, the elements pointed to by the <b>cabool.pElems</b> structure member are initialized with
///           VARIANT_FALSE.
///    cElems = Type: <b>ULONG</b> The number of vector elements.
///    ppropvar = Type: <b>PROPVARIANT*</b> When this function returns, contains the initialized PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitPropVariantFromBooleanVector(char* prgf, uint cElems, PROPVARIANT* ppropvar);

///Initializes a PROPVARIANT structure based on a specified vector of 16-bit integer values.
///Params:
///    prgn = Type: <b>const SHORT*</b> Pointer to a source vector of <b>SHORT</b> values. If this parameter is <b>NULL</b>,
///           the vector is initialized with zeros.
///    cElems = Type: <b>ULONG</b> The number of elements in the vector.
///    ppropvar = Type: <b>PROPVARIANT*</b> When this function returns, contains the initialized PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitPropVariantFromInt16Vector(char* prgn, uint cElems, PROPVARIANT* ppropvar);

///Initializes a PROPVARIANT structure based on a vector of 16-bit unsigned integer values.
///Params:
///    prgn = Type: <b>const USHORT*</b> Pointer to a source vector of <b>USHORT</b> values. If this parameter is <b>NULL</b>,
///           the PROPVARIANT is initialized with zeros.
///    cElems = Type: <b>ULONG</b> Number of elements in the vector pointed to by <i>prgn</i>.
///    ppropvar = Type: <b>PROPVARIANT*</b> When this function returns, contains the initialized PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitPropVariantFromUInt16Vector(char* prgn, uint cElems, PROPVARIANT* ppropvar);

///Initializes a PROPVARIANT structure based on a vector of 32-bit integer values.
///Params:
///    prgn = Type: <b>const LONG*</b> Pointer to a source vector of <b>LONG</b> values. If this parameter is <b>NULL</b>, the
///           vector is initialized with zeros.
///    cElems = Type: <b>ULONG</b> The number of vector elements.
///    ppropvar = Type: <b>PROPVARIANT*</b> When this function returns, contains the initialized PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitPropVariantFromInt32Vector(char* prgn, uint cElems, PROPVARIANT* ppropvar);

///Initializes a PROPVARIANT structure based on a vector of 32-bit unsigned integer values.
///Params:
///    prgn = Type: <b>const ULONG*</b> Pointer to a source vector of <b>ULONG</b> values. If this parameter is <b>NULL</b>,
///           the PROPVARIANT is initialized with zeros.
///    cElems = Type: <b>ULONG</b> Number of elements in the vector pointed to by <i>prgn</i>.
///    ppropvar = Type: <b>PROPVARIANT*</b> When this function returns, contains the initialized PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitPropVariantFromUInt32Vector(char* prgn, uint cElems, PROPVARIANT* ppropvar);

///Initializes a PROPVARIANT structure based on a vector of <b>Int64</b> values.
///Params:
///    prgn = Type: <b>const LONGLONG*</b> Pointer to a source vector of <b>LONGLONG</b> values. If this parameter is
///           <b>NULL</b>, the vector is initialized with zeros.
///    cElems = Type: <b>ULONG</b> The number of elements in the vector.
///    ppropvar = Type: <b>PROPVARIANT*</b> When this function returns, contains the initialized PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitPropVariantFromInt64Vector(char* prgn, uint cElems, PROPVARIANT* ppropvar);

///Initializes a PROPVARIANT structure based on a vector of 64-bit unsigned integers.
///Params:
///    prgn = Type: <b>const ULONGLONG*</b> Pointer to a source vector of <b>ULONGLONG</b> values. If this parameter is
///           <b>NULL</b>, the PROPVARIANT is initialized with zeros.
///    cElems = Type: <b>ULONG</b> Number of elements in the vector pointed to by <i>prgn</i>.
///    ppropvar = Type: <b>PROPVARIANT*</b> When this function returns, contains the initialized PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitPropVariantFromUInt64Vector(char* prgn, uint cElems, PROPVARIANT* ppropvar);

///Initializes a PROPVARIANT structure based on a specified vector of <b>double</b> values.
///Params:
///    prgn = Type: <b>const DOUBLE*</b> Pointer to a <b>double</b> vector. If this value is <b>NULL</b>, the elements pointed
///           to by the <b>cadbl.pElems</b> structure member are initialized with 0.0.
///    cElems = Type: <b>ULONG</b> The number of vector elements.
///    ppropvar = Type: <b>PROPVARIANT*</b> When this function returns, contains the initialized PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitPropVariantFromDoubleVector(char* prgn, uint cElems, PROPVARIANT* ppropvar);

///Initializes a PROPVARIANT structure from a specified vector of FILETIME values.
///Params:
///    prgft = Type: <b>const FILETIME*</b> Pointer to the date and time as a FILETIME vector. If this value is <b>NULL</b>, the
///            elements pointed to by the <b>cafiletime.pElems</b> structure member is initialized with (FILETIME)0.
///    cElems = Type: <b>ULONG</b> The number of vector elements.
///    ppropvar = Type: <b>PROPVARIANT*</b> When this function returns, contains the initialized PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitPropVariantFromFileTimeVector(char* prgft, uint cElems, PROPVARIANT* ppropvar);

///Initializes a PROPVARIANT structure from a specified string vector.
///Params:
///    prgsz = Type: <b>PCWSTR*</b> Pointer to a buffer that contains the source string vector.
///    cElems = Type: <b>ULONG</b> The number of vector elements in <i>prgsz</i>.
///    ppropvar = Type: <b>PROPVARIANT*</b> When this function returns, contains the initialized PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitPropVariantFromStringVector(char* prgsz, uint cElems, PROPVARIANT* ppropvar);

///Initializes a PROPVARIANT structure from a specified string. The string is parsed as a semi-colon delimited list (for
///example: "A;B;C").
///Params:
///    psz = Type: <b>PCWSTR</b> Pointer to a buffer that contains the source Unicode string.
///    ppropvar = Type: <b>PROPVARIANT*</b> When this function returns, contains the initialized PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitPropVariantFromStringAsVector(const(wchar)* psz, PROPVARIANT* ppropvar);

///Extracts the Boolean property value of a PROPVARIANT structure. If no value exists, then the specified default value
///is returned.
///Params:
///    propvarIn = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    fDefault = Type: <b>BOOL</b> Specifies the default property value, for use where no value currently exists.
///Returns:
///    Type: <b>BOOL</b> The extracted Boolean value or the default value.
///    
@DllImport("PROPSYS")
BOOL PropVariantToBooleanWithDefault(const(PROPVARIANT)* propvarIn, BOOL fDefault);

///Extracts the Int16 property value of a PROPVARIANT structure. If no value currently exists, then specified default
///value is returned.
///Params:
///    propvarIn = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    iDefault = Type: <b>SHORT</b> Specifies default property value, for use where no value currently exists.
///Returns:
///    Type: <b>SHORT</b> Returns the extracted <b>short</b> value, or default.
///    
@DllImport("PROPSYS")
short PropVariantToInt16WithDefault(const(PROPVARIANT)* propvarIn, short iDefault);

///Extracts an <b>unsigned short</b> value from a PROPVARIANT structure. If no value exists, then the specified default
///value is returned.
///Params:
///    propvarIn = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    uiDefault = Type: <b>USHORT</b> Specifies a default property value, for use where no value currently exists.
///Returns:
///    Type: <b>unsigned short</b> Returns extracted <b>unsigned short</b> value, or default.
///    
@DllImport("PROPSYS")
ushort PropVariantToUInt16WithDefault(const(PROPVARIANT)* propvarIn, ushort uiDefault);

///Extracts an <b>Int32</b> value from a PROPVARIANT structure. If no value currently exists, then the specified default
///value is returned.
///Params:
///    propvarIn = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    lDefault = Type: <b>LONG</b> Specifies a default property value, for use where no value currently exists.
///Returns:
///    Type: <b>LONG</b> Returns extracted <b>LONG</b> value, or default.
///    
@DllImport("PROPSYS")
int PropVariantToInt32WithDefault(const(PROPVARIANT)* propvarIn, int lDefault);

///Extracts a <b>ULONG</b> value from a PROPVARIANT structure. If no value exists, then a specified default value is
///returned.
///Params:
///    propvarIn = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    ulDefault = Type: <b>ULONG</b> Specifies a default property value, for use where no value currently exists.
///Returns:
///    Type: <b>ULONG</b> Returns extracted <b>ULONG</b> value, or default.
///    
@DllImport("PROPSYS")
uint PropVariantToUInt32WithDefault(const(PROPVARIANT)* propvarIn, uint ulDefault);

///Extracts the <b>Int64</b> property value of a PROPVARIANT structure. If no value exists, then specified default value
///is returned.
///Params:
///    propvarIn = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    llDefault = Type: <b>LONGLONG</b> Specifies a default property value, for use where no value currently exists.
///Returns:
///    Type: <b>LONGLONG</b> Returns the extracted <b>LONGLONG</b> value, or default.
///    
@DllImport("PROPSYS")
long PropVariantToInt64WithDefault(const(PROPVARIANT)* propvarIn, long llDefault);

///Extracts <b>ULONGLONG</b> value from a PROPVARIANT structure. If no value exists, then the specified default value is
///returned.
///Params:
///    propvarIn = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    ullDefault = Type: <b>ULONGLONG</b> Specifies a default property value, for use where no value currently exists.
///Returns:
///    Type: <b>ULONGLONG</b> Returns the extracted unsigned <b>LONGLONG</b> value, or a default.
///    
@DllImport("PROPSYS")
ulong PropVariantToUInt64WithDefault(const(PROPVARIANT)* propvarIn, ulong ullDefault);

///Extracts a double property value of a PROPVARIANT structure. If no value exists, then the specified default value is
///returned.
///Params:
///    propvarIn = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    dblDefault = Type: <b>DOUBLE</b> Specifies default property value, for use where no value currently exists.
///Returns:
///    Type: <b>DOUBLE</b> Returns extracted <b>double</b> value, or default.
///    
@DllImport("PROPSYS")
double PropVariantToDoubleWithDefault(const(PROPVARIANT)* propvarIn, double dblDefault);

///Extracts the string property value of a PROPVARIANT structure. If no value exists, then the specified default value
///is returned.
///Params:
///    propvarIn = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    pszDefault = Type: <b>LPCWSTR</b> Pointer to a default Unicode string value, for use where no value currently exists. May be
///                 <b>NULL</b>.
///Returns:
///    Type: <b>PCWSTR</b> Returns string value or default, or the default.
///    
@DllImport("PROPSYS")
ushort* PropVariantToStringWithDefault(const(PROPVARIANT)* propvarIn, const(wchar)* pszDefault);

///Extracts a Boolean property value of a PROPVARIANT structure. If no value can be extracted, then a default value is
///assigned.
///Params:
///    propvarIn = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    pfRet = Type: <b>BOOL*</b> When this function returns, contains the extracted property value if one exists; otherwise,
///            contains <b>FALSE</b>.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PropVariantToBoolean(const(PROPVARIANT)* propvarIn, int* pfRet);

///Extracts an Int16 property value of a PROPVARIANT structure.
///Params:
///    propvarIn = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    piRet = Type: <b>SHORT*</b> When this function returns, contains the extracted property value if one exists; otherwise,
///            0.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PropVariantToInt16(const(PROPVARIANT)* propvarIn, short* piRet);

///Extracts a <b>unsigned short</b> value from a PROPVARIANT structure. If no value can be extracted, then a default
///value is assigned.
///Params:
///    propvarIn = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    puiRet = Type: <b>USHORT*</b> When this function returns, contains the extracted property value if one exists; otherwise,
///             0.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PropVariantToUInt16(const(PROPVARIANT)* propvarIn, ushort* puiRet);

///Extracts the <b>Int32</b> property value of a PROPVARIANT structure. If no value can be extracted, then a default
///value is assigned.
///Params:
///    propvarIn = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    plRet = Type: <b>LONG*</b> When this function returns, contains the extracted value if one exists; otherwise, 0.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PropVariantToInt32(const(PROPVARIANT)* propvarIn, int* plRet);

///Extracts an <b>ULONG</b> value from a PROPVARIANT structure. If no value can be extracted, then a default value is
///assigned.
///Params:
///    propvarIn = Type: <b>REFPROPVARIANT</b> A reference to a source PROPVARIANT structure.
///    pulRet = Type: <b>ULONG*</b> When this function returns, contains the extracted property value if one exists; otherwise,
///             0.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PropVariantToUInt32(const(PROPVARIANT)* propvarIn, uint* pulRet);

///Extracts a <b>LONGLONG</b> value from a PROPVARIANT structure. If no value can be extracted, then a default value is
///assigned.
///Params:
///    propvarIn = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    pllRet = Type: <b>LONGLONG*</b> When this function returns, contains the extracted property value if one exists;
///             otherwise, 0.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PropVariantToInt64(const(PROPVARIANT)* propvarIn, long* pllRet);

///Extracts a <b>UInt64</b> value from a PROPVARIANT structure. If no value can be extracted, then a default value is
///assigned.
///Params:
///    propvarIn = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    pullRet = Type: <b>ULONGLONG*</b> When this function returns, contains the extracted property value if one exists;
///              otherwise, 0.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PropVariantToUInt64(const(PROPVARIANT)* propvarIn, ulong* pullRet);

///Extracts double value from a PROPVARIANT structure.
///Params:
///    propvarIn = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    pdblRet = Type: <b>DOUBLE*</b> When this function returns, contains the extracted property value if one exists; otherwise,
///              contains 0.0.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PropVariantToDouble(const(PROPVARIANT)* propvarIn, double* pdblRet);

///Extracts the buffer value from a PROPVARIANT structure of type VT_VECTOR | VT_UI1 or VT_ARRRAY | VT_UI1.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> The source PROPVARIANT structure.
///    pv = Type: <b>VOID*</b> Pointer to a buffer of length <i>cb</i> bytes. When this function returns, contains the first
///         <i>cb</i> bytes of the extracted buffer value.
///    cb = Type: <b>UINT</b> The buffer length, in bytes.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> If
///    successful, or an error value otherwise. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
///    </dl> </td> <td width="60%"> ThePROPVARIANTwas of the wrong type. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> ThePROPVARIANTvalue had fewer than <i>cb</i> bytes. </td>
///    </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PropVariantToBuffer(const(PROPVARIANT)* propvar, char* pv, uint cb);

///Extracts a string value from a PROPVARIANT structure.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    psz = Type: <b>PWSTR</b> Points to a string buffer. When this function returns, the buffer is initialized with a
///          <b>NULL</b> terminated Unicode string value.
///    cch = Type: <b>UINT</b> Size of the buffer pointed to by <i>psz</i>, in characters.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The value
///    was extracted and the result buffer was <b>NULL</b> terminated. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>STRSAFE_E_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The copy operation failed due to
///    insufficient buffer space. The destination buffer contains a truncated, null-terminated version of the intended
///    result. In situations where truncation is acceptable, this may not necessarily be seen as a failure condition.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Some other error value</b></dt> </dl> </td> <td width="60%"> The
///    extraction failed for some other reason. </td> </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PropVariantToString(const(PROPVARIANT)* propvar, const(wchar)* psz, uint cch);

///Extracts a GUID value from a PROPVARIANT structure.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    pguid = Type: <b>GUID*</b> When this function returns, contains the extracted property value if one exists.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PropVariantToGUID(const(PROPVARIANT)* propvar, GUID* pguid);

///Extracts a string property value from a PROPVARIANT structure.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    ppszOut = Type: <b>PWSTR*</b> When this function returns, contains a pointer to the extracted property value if one exists.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PropVariantToStringAlloc(const(PROPVARIANT)* propvar, ushort** ppszOut);

///Extracts the BSTR property value of a PROPVARIANT structure.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    pbstrOut = Type: <b>BSTR*</b> Pointer to the extracted property value if one exists; otherwise, contains an empty string.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PropVariantToBSTR(const(PROPVARIANT)* propvar, BSTR* pbstrOut);

///Extracts a string from a PROPVARIANT structure and places it into a STRRET structure.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    pstrret = Type: <b>STRRET*</b> Points to the STRRET structure. When this function returns, the structure has been
///              initialized to contain a copy of the extracted string.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PropVariantToStrRet(const(PROPVARIANT)* propvar, STRRET* pstrret);

///Extracts the FILETIME structure from a PROPVARIANT structure.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    pstfOut = Type: <b>PSTIME_FLAGS</b> Specifies one of the following time flags.
///    pftOut = Type: <b>FILETIME*</b> When this function returns, contains the extracted FILETIME structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PropVariantToFileTime(const(PROPVARIANT)* propvar, int pstfOut, FILETIME* pftOut);

///Retrieves the element count of a PROPVARIANT structure.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to the source PROPVARIANT structure.
///Returns:
///    Type: <b>ULONG</b> Returns the element count of a VT_VECTOR or VT_ARRAY value: for single values, returns 1; for
///    empty structures, returns 0.
///    
@DllImport("PROPSYS")
uint PropVariantGetElementCount(const(PROPVARIANT)* propvar);

///Extracts a Boolean vector from a PROPVARIANT structure.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    prgf = Type: <b>BOOL*</b> Points to a buffer that contains <i>crgf</i> <b>BOOL</b> values. When this function returns,
///           the buffer has been initialized with <i>pcElem</i> Boolean elements extracted from the source PROPVARIANT
///           structure.
///    crgf = Type: <b>ULONG</b> Number of elements in the buffer pointed to by <i>prgf</i>.
///    pcElem = Type: <b>ULONG*</b> When this function returns, contains the count of Boolean elements extracted from source
///             PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Returns
///    <b>S_OK</b> if successful, or an error value otherwise. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TYPE_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The source PROPVARIANT contained more than
///    <i>crgf</i> values. The buffer pointed to by <i>prgf</i>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The PROPVARIANT was not of the appropriate type. </td>
///    </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PropVariantToBooleanVector(const(PROPVARIANT)* propvar, char* prgf, uint crgf, uint* pcElem);

///Extracts a vector of <b>Int16</b> values from a PROPVARIANT structure.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    prgn = Type: <b>SHORT*</b> Points to a buffer containing <i>crgn</i> SHORT values. When this function returns, the
///           buffer has been initialized with <i>pcElem</i> SHORT elements extracted from the source PROPVARIANT structure.
///    crgn = Type: <b>ULONG</b> Size of the buffer pointed to by <i>prgn</i> in elements.
///    pcElem = Type: <b>ULONG*</b> When this function returns, contains the count of <b>Int16</b> elements extracted from source
///             PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Returns
///    <b>S_OK</b> if successful, or an error value otherwise. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TYPE_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The source PROPVARIANT contained more than
///    <i>crgn</i> values. The buffer pointed to by <i>prgn</i>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> ThePROPVARIANTwas not of the appropriate type. </td>
///    </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PropVariantToInt16Vector(const(PROPVARIANT)* propvar, char* prgn, uint crgn, uint* pcElem);

///Extracts data from a PROPVARIANT structure into an <b>unsigned short</b> vector.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    prgn = Type: <b>USHORT*</b> Points to a buffer containing <i>crgn</i> <b>unsigned short</b> values. When this function
///           returns, the buffer has been initialized with <i>pcElem</i> <b>unsigned short</b> elements extracted from the
///           source PROPVARIANT.
///    crgn = Type: <b>ULONG</b> Size of the buffer pointed to by <i>prgn</i> in elements.
///    pcElem = Type: <b>ULONG*</b> When this function returns, contains the count of <b>unsigned short</b> values extracted from
///             the source PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Returns
///    <b>S_OK</b> if successful, or an error value otherwise. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TYPE_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The source PROPVARIANT contained more than
///    <i>crgn</i> values. The buffer pointed to by <i>prgn</i>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The PROPVARIANT was not of the appropriate type. </td>
///    </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PropVariantToUInt16Vector(const(PROPVARIANT)* propvar, char* prgn, uint crgn, uint* pcElem);

///Extracts a vector of <b>long</b> values from a PROPVARIANT structure.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    prgn = Type: <b>LONG*</b> Points to a buffer containing <i>crgn</i> <b>LONG</b> values. When this function returns, the
///           buffer has been initialized with <i>pcElem</i> <b>LONG</b> elements extracted from the source PROPVARIANT.
///    crgn = Type: <b>ULONG</b> Size of the buffer pointed to by <i>prgn</i> in elements.
///    pcElem = Type: <b>ULONG*</b> When this function returns, contains the count of <b>LONG</b> elements extracted from source
///             PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Returns
///    <b>S_OK</b> if successful, or an error value otherwise. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TYPE_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The source PROPVARIANT contained more than
///    crgn values. The buffer pointed to by <i>prgn</i>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The PROPVARIANT was not of the appropriate type. </td>
///    </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PropVariantToInt32Vector(const(PROPVARIANT)* propvar, char* prgn, uint crgn, uint* pcElem);

///Extracts data from a PROPVARIANT structure into an <b>ULONG</b> vector.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    prgn = Type: <b>ULONG*</b> Points to a buffer containing <i>crgn</i> <b>ULONG</b> values. When this function returns,
///           the buffer has been initialized with <i>pcElem</i> <b>ULONG</b> elements extracted from the source PROPVARIANT.
///    crgn = Type: <b>ULONG</b> Size of the buffer pointed to by <i>prgn</i>, in elements.
///    pcElem = Type: <b>ULONG*</b> When this function returns, contains the count of <b>ULONG</b> values extracted from the
///             source PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Returns
///    <b>S_OK</b> if successful, or an error value otherwise. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TYPE_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The source PROPVARIANT contained more than
///    <i>crgn</i> values. The buffer pointed to by <i>prgn</i> is too small. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The PROPVARIANT was not of the appropriate type. </td>
///    </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PropVariantToUInt32Vector(const(PROPVARIANT)* propvar, char* prgn, uint crgn, uint* pcElem);

///Extracts data from a PROPVARIANT structure into an <b>Int64</b> vector.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    prgn = Type: <b>LONGLONG*</b> Points to a buffer containing <i>crgn</i> <b>LONGLONG</b> values. When this function
///           returns, the buffer has been initialized with <i>pcElem</i> <b>LONGLONG</b> elements extracted from the source
///           PROPVARIANT.
///    crgn = Type: <b>ULONG</b> Size of the buffer pointed to by <i>prgn</i> in elements.
///    pcElem = Type: <b>ULONG*</b> When this function returns, contains the count of <b>LONGLONG</b> values extracted from the
///             source PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Returns
///    <b>S_OK</b> if successful, or an error value otherwise. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TYPE_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The source PROPVARIANT contained more than
///    <i>crgn</i> values. The buffer pointed to by <i>prgn</i>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The PROPVARIANT was not of the appropriate type </td>
///    </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PropVariantToInt64Vector(const(PROPVARIANT)* propvar, char* prgn, uint crgn, uint* pcElem);

///Extracts data from a PROPVARIANT structure into a <b>ULONGLONG</b> vector.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    prgn = Type: <b>ULONGLONG*</b> Points to a buffer containing <i>crgn</i> <b>ULONGLONG</b> values. When this function
///           returns, the buffer has been initialized with <i>pcElem</i> <b>ULONGLONG</b> elements extracted from the source
///           PROPVARIANT.
///    crgn = Type: <b>ULONG</b> Size of the buffer pointed to by <i>prgn</i>, in elements.
///    pcElem = Type: <b>ULONG*</b> When this function returns, contains the count of <b>ULONGLONG</b> values extracted from the
///             source PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Returns
///    <b>S_OK</b> if successful, or an error value otherwise. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TYPE_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The source PROPVARIANT contained more than
///    <i>crgn</i> values. The buffer pointed to by <i>prgn</i>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The PROPVARIANT was not of the appropriate type. </td>
///    </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PropVariantToUInt64Vector(const(PROPVARIANT)* propvar, char* prgn, uint crgn, uint* pcElem);

///Extracts a vector of doubles from a PROPVARIANT structure.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    prgn = Type: <b>DOUBLE*</b> Points to a buffer containing <i>crgn</i> DOUBLE values. When this function returns, the
///           buffer has been initialized with <i>pcElem</i> double elements extracted from the source PROPVARIANT structure.
///    crgn = Type: <b>ULONG</b> Size in elements of the buffer pointed to by <i>prgn</i>.
///    pcElem = Type: <b>ULONG*</b> When this function returns, contains the count of double elements extracted from the source
///             PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PropVariantToDoubleVector(const(PROPVARIANT)* propvar, char* prgn, uint crgn, uint* pcElem);

///Extracts data from a PROPVARIANT structure into a FILETIME vector.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    prgft = Type: <b>FILETIME*</b> Points to a buffer containing <i>crgft</i> FILETIME values. When this function returns,
///            the buffer has been initialized with <i>pcElem</i> FILETIME elements extracted from the source PROPVARIANT
///            structure.
///    crgft = Type: <b>ULONG</b> Size in elements of the buffer pointed to by <i>prgft</i>.
///    pcElem = Type: <b>ULONG*</b> When this function returns, contains the count of FILETIME elements extracted from the source
///             PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Returns <b>S_OK</b> if
///    successful, or an error value otherwise. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TYPE_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The source PROPVARIANT contained more than
///    crgn values. The buffer pointed to by <i>prgft</i>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The PROPVARIANT was not of the appropriate type. </td>
///    </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PropVariantToFileTimeVector(const(PROPVARIANT)* propvar, char* prgft, uint crgft, uint* pcElem);

///Extracts a vector of strings from a PROPVARIANT structure.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    prgsz = Type: <b>PWSTR*</b> Pointer to a vector of string pointers. When this function returns, the buffer has been
///            initialized with <i>pcElem</i> elements pointing to newly allocated strings containing the data extracted from
///            the source PROPVARIANT.
///    crgsz = Type: <b>ULONG</b> Size of the buffer pointed to by <i>prgsz</i>, in elements.
///    pcElem = Type: <b>ULONG*</b> When this function returns, contains the count of strings extracted from source PROPVARIANT
///             structure.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Returns
///    <b>S_OK</b> if successful, or an error value otherwise. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TYPE_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The sourcePROPVARIANTcontained more than
///    <i>crgsz</i> values. The buffer pointed to by <i>prgsz</i>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> ThePROPVARIANTwas not of the appropriate type. </td>
///    </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PropVariantToStringVector(const(PROPVARIANT)* propvar, char* prgsz, uint crgsz, uint* pcElem);

///Extracts data from a PROPVARIANT structure into a newly allocated Boolean vector.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    pprgf = Type: <b>BOOL**</b> When this function returns, contains a pointer to a vector of Boolean values extracted from
///            the source PROPVARIANT structure.
///    pcElem = Type: <b>ULONG*</b> When this function returns, contains the count of Boolean elements extracted from the source
///             PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Returns
///    <b>S_OK</b> if successful, or an error value otherwise. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> ThePROPVARIANTwas not of the appropriate type. </td>
///    </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PropVariantToBooleanVectorAlloc(const(PROPVARIANT)* propvar, int** pprgf, uint* pcElem);

///Extracts data from a PROPVARIANT structure into a newly allocated <b>Int16</b> vector.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    pprgn = Type: <b>SHORT**</b> When this function returns, contains a pointer to a vector of <b>Int16</b> values extracted
///            from the source PROPVARIANT structure.
///    pcElem = Type: <b>ULONG*</b> When this function returns, contains the count of <b>Int16</b> elements extracted from source
///             PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Returns
///    <b>S_OK</b> if successful, or an error value otherwise. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> ThePROPVARIANTwas not of the appropriate type. </td>
///    </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PropVariantToInt16VectorAlloc(const(PROPVARIANT)* propvar, short** pprgn, uint* pcElem);

///Extracts data from a PROPVARIANT structure into a newly-allocated <b>unsigned short</b> vector.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    pprgn = Type: <b>USHORT**</b> When this function returns, contains a pointer to a vector of <b>unsigned short</b> values
///            extracted from the source PROPVARIANT structure.
///    pcElem = Type: <b>ULONG*</b> When this function returns, contains the count of <b>unsigned short</b> values extracted from
///             the source PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Returns
///    <b>S_OK</b> if successful, or an error value otherwise </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The PROPVARIANT was not of the appropriate type. </td>
///    </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PropVariantToUInt16VectorAlloc(const(PROPVARIANT)* propvar, ushort** pprgn, uint* pcElem);

///Extracts data from a PROPVARIANT structure into a newly-allocated <b>Int32</b> vector.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    pprgn = Type: <b>LONG**</b> When this function returns, contains a pointer to a vector of <b>LONG</b> values extracted
///            from the source PROPVARIANT structure.
///    pcElem = Type: <b>ULONG*</b> When this function returns, contains the count of <b>LONG</b> elements extracted from the
///             source PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Returns
///    <b>S_OK</b> if successful, or an error value otherwise. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> ThePROPVARIANTwas not of the appropriate type. </td>
///    </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PropVariantToInt32VectorAlloc(const(PROPVARIANT)* propvar, int** pprgn, uint* pcElem);

///Extracts data from a PROPVARIANT structure into a newly-allocated <b>ULONG</b> vector.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    pprgn = Type: <b>ULONG**</b> When this function returns, contains a pointer to a vector of <b>ULONG</b> values extracted
///            from the source PROPVARIANT structure.
///    pcElem = Type: <b>ULONG*</b> When this function returns, contains the count of <b>ULONG</b> values extracted from the
///             source PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Returns
///    <b>S_OK</b> if successful, or an error value otherwise. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The PROPVARIANT was not of the appropriate type. </td>
///    </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PropVariantToUInt32VectorAlloc(const(PROPVARIANT)* propvar, uint** pprgn, uint* pcElem);

///Extracts data from a PROPVARIANT structure into a newly-allocated <b>LONGLONG</b> vector.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    pprgn = Type: <b>LONGLONG**</b> When this function returns, contains a pointer to a vector of <b>LONGLONG</b> values
///            extracted from the source PROPVARIANT structure.
///    pcElem = Type: <b>ULONG*</b> When this function returns, contains the count of <b>LONGLONG</b> values extracted from
///             source PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Returns
///    <b>S_OK</b> if successful, or an error value otherwise. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> ThePROPVARIANTwas not of the appropriate type. </td>
///    </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PropVariantToInt64VectorAlloc(const(PROPVARIANT)* propvar, long** pprgn, uint* pcElem);

///Extracts data from a PROPVARIANT structure into a newly-allocated <b>ULONGLONG</b> vector.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    pprgn = Type: <b>ULONGLONG**</b> When this function returns, contains a pointer to a vector of <b>ULONGLONG</b> values
///            extracted from the source PROPVARIANT structure.
///    pcElem = Type: <b>ULONG*</b> When this function returns, contains the count of <b>ULONGLONG</b> elements extracted from
///             the source PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Returns
///    <b>S_OK</b> if successful, or an error value otherwise. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The PROPVARIANT was not of the appropriate type. </td>
///    </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PropVariantToUInt64VectorAlloc(const(PROPVARIANT)* propvar, ulong** pprgn, uint* pcElem);

///Extracts data from a PROPVARIANT structure into a newly-allocated double vector.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    pprgn = Type: <b>DOUBLE**</b> When this function returns, contains a pointer to a vector of double values extracted from
///            the source PROPVARIANT structure.
///    pcElem = Type: <b>ULONG*</b> When this function returns, contains the count of double elements extracted from the source
///             PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PropVariantToDoubleVectorAlloc(const(PROPVARIANT)* propvar, double** pprgn, uint* pcElem);

///Extracts data from a PROPVARIANT structure into a newly-allocated FILETIME vector.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    pprgft = Type: <b>FILETIME**</b> When this function returns, contains a pointer to a vector of FILETIME values extracted
///             from the source PROPVARIANT structure.
///    pcElem = Type: <b>ULONG*</b> When this function returns, contains the count of FILETIME elements extracted from source
///             PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Returns <b>S_OK</b> if
///    successful, or an error value otherwise. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
///    </dl> </td> <td width="60%"> ThePROPVARIANTwas not of the appropriate type. </td> </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PropVariantToFileTimeVectorAlloc(const(PROPVARIANT)* propvar, FILETIME** pprgft, uint* pcElem);

///Extracts data from a PROPVARIANT structure into a newly allocated strings in a newly allocated vector.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    pprgsz = Type: <b>PWSTR**</b> When this function returns, contains a pointer to a vector of strings extracted from source
///             PROPVARIANT structure.
///    pcElem = Type: <b>ULONG*</b> When this function returns, containsthe count of string elements extracted from source
///             PROPVARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> This function can return one of these values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Returns
///    <b>S_OK</b> if successful, or an error value otherwise. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The PROPVARIANT was not of the appropriate type. </td>
///    </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT PropVariantToStringVectorAlloc(const(PROPVARIANT)* propvar, ushort*** pprgsz, uint* pcElem);

///Extracts a single Boolean element from a PROPVARIANT structure of type <code>VT_BOOL</code>, <code>VT_VECTOR |
///VT_BOOL</code>, or <code>VT_ARRAY | VT_BOOL</code>.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> A reference to the source PROPVARIANT structure.
///    iElem = Type: <b>ULONG</b> Specifies the vector or array index; otherwise, <i>iElem</i> must be 0.
///    pfVal = Type: <b>BOOL*</b> When this function returns, contains the extracted Boolean value.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PropVariantGetBooleanElem(const(PROPVARIANT)* propvar, uint iElem, int* pfVal);

///Extracts a single Int16 element from a PROPVARIANT structure of type VT_I2, VT_VECTOR | VT_I2, or VT_ARRAY | VT_I2.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to the source PROPVARIANT structure.
///    iElem = Type: <b>ULONG</b> The vector or array index; otherwise, this value must be 0.
///    pnVal = Type: <b>SHORT*</b> When this function returns, contains the extracted Int32 element value.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PropVariantGetInt16Elem(const(PROPVARIANT)* propvar, uint iElem, short* pnVal);

///Extracts a single unsigned Int16 element from a PROPVARIANT structure of type VT_U12, VT_VECTOR | VT_U12, or VT_ARRAY
///| VT_U12.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to the source PROPVARIANT structure.
///    iElem = Type: <b>ULONG</b> The vector or array index; otherwise, <i>iElem</i> must be 0.
///    pnVal = Type: <b>USHORT*</b> When this function returns, contains the extracted element value.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PropVariantGetUInt16Elem(const(PROPVARIANT)* propvar, uint iElem, ushort* pnVal);

///Extracts a single Int32 element from a PROPVARIANT of type VT_I4, VT_VECTOR | VT_I4, or VT_ARRAY | VT_I4.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to the source PROPVARIANT structure.
///    iElem = Type: <b>ULONG</b> The vector or array index; otherwise, <i>iElem</i> must be 0.
///    pnVal = Type: <b>LONG*</b> When this function, contains the extracted Int32 value.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PropVariantGetInt32Elem(const(PROPVARIANT)* propvar, uint iElem, int* pnVal);

///Extracts a single unsigned Int32 element from a PROPVARIANT structure of type VT_UI4, VT_VECTOR | VT_UI4, or VT_ARRAY
///| VT_UI4.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> The source PROPVARIANT structure.
///    iElem = Type: <b>ULONG</b> A vector or array index; otherwise, <i>iElem</i> must be 0.
///    pnVal = Type: <b>ULONG*</b> When this function returns, contains the extracted unsigned Int32 value.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PropVariantGetUInt32Elem(const(PROPVARIANT)* propvar, uint iElem, uint* pnVal);

///Extracts a single Int64 element from a PROPVARIANT structure of type VT_I8, VT_VECTOR | VT_I8, or VT_ARRAY | VT_I8.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to the source PROPVARIANT structure.
///    iElem = Type: <b>ULONG</b> The vector or array index; otherwise, <i>iElem</i> must be 0.
///    pnVal = Type: <b>LONGLONG*</b> When this function returns, contains the extracted Int64 value.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PropVariantGetInt64Elem(const(PROPVARIANT)* propvar, uint iElem, long* pnVal);

///Extracts a single unsigned Int64 element from a PROPVARIANT structure of type VT_UI8, VT_VECTOR | VT_UI8, or VT_ARRAY
///| VT_UI8.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> The source PROPVARIANT structure.
///    iElem = Type: <b>ULONG</b> The vector or array index; otherwise, <i>iElem</i> must be 0.
///    pnVal = Type: <b>ULONGLONG*</b> When this function returns, contains the extracted Int64 value.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PropVariantGetUInt64Elem(const(PROPVARIANT)* propvar, uint iElem, ulong* pnVal);

///Extracts a single <b>double</b> element from a PROPVARIANT structure of type <code>VT_R8</code>, <code>VT_VECTOR |
///VT_R8</code>, or <code>VT_ARRAY | VT_R8</code>.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to the source PROPVARIANT structure.
///    iElem = Type: <b>ULONG</b> Specifies vector or array index; otherwise, <i>iElem</i> must be 0.
///    pnVal = Type: <b>DOUBLE*</b> When this function returns, contains the extracted double value.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PropVariantGetDoubleElem(const(PROPVARIANT)* propvar, uint iElem, double* pnVal);

///Extracts a single FILETIME element from a PROPVARIANT structure of type VT_FILETIME, VT_VECTOR | VT_FILETIME, or
///VT_ARRAY | VT_FILETIME.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> The source PROPVARIANT structure.
///    iElem = Type: <b>ULONG</b> Specifies vector or array index; otherwise, this value must be 0.
///    pftVal = Type: <b>FILETIME*</b> When this function returns, contains the extracted filetime value.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PropVariantGetFileTimeElem(const(PROPVARIANT)* propvar, uint iElem, FILETIME* pftVal);

///Extracts a single Unicode string element from a PROPVARIANT structure of type VT_LPWSTR, VT_BSTR, VT_VECTOR |
///VT_LPWSTR, VT_VECTOR | VT_BSTR, or VT_ARRAY | VT_BSTR.
///Params:
///    propvar = Type: <b>REFPROPVARIANT</b> Reference to a source PROPVARIANT structure.
///    iElem = Type: <b>ULONG</b> The vector or array index; otherwise, <i>iElem</i> must be 0.
///    ppszVal = Type: <b>PWSTR*</b> When this function returns, contains the extracted string value. The calling application is
///              responsible for freeing this string by calling CoTaskMemFree when it is no longer needed.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PropVariantGetStringElem(const(PROPVARIANT)* propvar, uint iElem, ushort** ppszVal);

///Frees the memory and references used by an array of PROPVARIANT structures stored in an array.
///Params:
///    rgPropVar = Type: <b>PROPVARIANT*</b> Array of PROPVARIANT structures to free.
///    cVars = Type: <b>UINT</b> The number of elements in the array specified by <i>rgPropVar</i>.
///Returns:
///    No return value.
///    
@DllImport("PROPSYS")
void ClearPropVariantArray(char* rgPropVar, uint cVars);

///Extends PropVariantCompare by allowing the caller to compare two PROPVARIANT structures based on specified comparison
///units and flags.
///Params:
///    propvar1 = Type: <b>REFPROPVARIANT</b> Reference to the first PROPVARIANT structure.
///    propvar2 = Type: <b>REFPROPVARIANT</b> Reference to the second PROPVARIANT structure.
///    unit = Type: <b>PROPVAR_COMPARE_UNIT</b> Specifies, where appropriate, one of the comparison units defined in
///           PROPVAR_COMPARE_UNIT.
///    flags = Type: <b>PROPVAR_COMPARE_FLAGS</b> Specifies one of the following:
///Returns:
///    Type: <b>INT</b> <ul> <li>Returns 1 if <i>propvar1</i> is greater than <i>propvar2</i></li> <li>Returns 0 if
///    <i>propvar1</i> equals <i>propvar2</i></li> <li>Returns -1 if <i>propvar1</i> is less than <i>propvar2</i></li>
///    </ul>
///    
@DllImport("PROPSYS")
int PropVariantCompareEx(const(PROPVARIANT)* propvar1, const(PROPVARIANT)* propvar2, PROPVAR_COMPARE_UNIT unit, 
                         int flags);

///Coerces a value stored as a PROPVARIANT structure to an equivalent value of a different variant type.
///Params:
///    ppropvarDest = Type: <b>PROPVARIANT*</b> A pointer to a PROPVARIANT structure that, when this function returns successfully,
///                   receives the coerced value and its new type.
///    propvarSrc = Type: <b>REFPROPVARIANT</b> A reference to the source PROPVARIANT structure that contains the value expressed as
///                 its original type.
///    flags = Type: <b>PROPVAR_CHANGE_FLAGS</b> Reserved, must be 0.
///    vt = Type: <b>VARTYPE</b> Specifies the new type for the value. See the tables below for recognized type names.
///Returns:
///    Type: <b>HRESULT</b> Returns <b>S_OK</b> if successful, or a standard COM error value otherwise. If the requested
///    coercion is not possible, an error is returned.
///    
@DllImport("PROPSYS")
HRESULT PropVariantChangeType(PROPVARIANT* ppropvarDest, const(PROPVARIANT)* propvarSrc, int flags, ushort vt);

///Converts the contents of a PROPVARIANT structure to a VARIANT structure.
///Params:
///    pPropVar = Type: <b>const PROPVARIANT*</b> Pointer to a source PROPVARIANT structure.
///    pVar = Type: <b>VARIANT*</b> Pointer to a VARIANT structure. When this function returns, the <b>VARIANT</b> contains the
///           converted information.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT PropVariantToVariant(const(PROPVARIANT)* pPropVar, VARIANT* pVar);

///Copies the contents of a VARIANT structure to a PROPVARIANT structure.
///Params:
///    pVar = Type: <b>const VARIANT*</b> Pointer to a source VARIANT structure.
///    pPropVar = Type: <b>PROPVARIANT*</b> Pointer to a PROPVARIANT structure. When this function returns, the <b>PROPVARIANT</b>
///               contains the converted information.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT VariantToPropVariant(const(VARIANT)* pVar, PROPVARIANT* pPropVar);

///Initializes a VARIANT structure based on a string resource imbedded in an executable file.
///Params:
///    hinst = Type: <b>HINSTANCE</b> Handle to an instance of the module whose executable file contains the string resource.
///    id = Type: <b>UINT</b> Integer identifier of the string to be loaded.
///    pvar = Type: <b>VARIANT*</b> When this function returns, contains the initialized VARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitVariantFromResource(HINSTANCE hinst, uint id, VARIANT* pvar);

///Initializes a VARIANT structure with the contents of a buffer.
///Params:
///    pv = Type: <b>const VOID*</b> Pointer to the source buffer.
///    cb = Type: <b>UINT</b> The length of the buffer, in bytes.
///    pvar = Type: <b>VARIANT*</b> When this function returns, contains the initialized VARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitVariantFromBuffer(char* pv, uint cb, VARIANT* pvar);

///Initializes a VARIANT structure based on a <b>GUID</b>. The structure is initialized as a <b>VT_BSTR</b> type.
///Params:
///    guid = Type: <b>REFGUID</b> Reference to the source <b>GUID</b>.
///    pvar = Type: <b>VARIANT*</b> When this function returns, contains the initialized VARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitVariantFromGUIDAsString(const(GUID)* guid, VARIANT* pvar);

///Initializes a VARIANT structure with the contents of a FILETIME structure.
///Params:
///    pft = Type: <b>const FILETIME*</b> Pointer to date and time information stored in a FILETIME structure.
///    pvar = Type: <b>VARIANT*</b> When this function returns, contains the initialized VARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitVariantFromFileTime(const(FILETIME)* pft, VARIANT* pvar);

///Initializes a VARIANT structure with an array of FILETIME structures.
///Params:
///    prgft = Type: <b>const FILETIME*</b> Pointer to an array of FILETIME structures.
///    cElems = Type: <b>ULONG</b> The number of elements in the array pointed to by <i>prgft</i>.
///    pvar = Type: <b>VARIANT*</b> When this function returns, contains the initialized VARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitVariantFromFileTimeArray(char* prgft, uint cElems, VARIANT* pvar);

///Initializes a VARIANT structure with a string stored in a STRRET structure.
///Params:
///    pstrret = Type: <b>STRRET*</b> Pointer to a STRRET structure.
///    pidl = Type: <b>PCUITEMID_CHILD</b> PIDL of the item whose details are being retrieved.
///    pvar = Type: <b>VARIANT*</b> When this function returns, contains the initialized VARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitVariantFromStrRet(STRRET* pstrret, ITEMIDLIST* pidl, VARIANT* pvar);

///Initializes a VARIANT structure with a value stored in another <b>VARIANT</b> structure.
///Params:
///    varIn = Type: <b>REFVARIANT</b> Reference to the source VARIANT structure.
///    iElem = Type: <b>ULONG</b> Index of one of the source VARIANT structure elements.
///    pvar = Type: <b>VARIANT*</b> When this function returns, contains the initialized VARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitVariantFromVariantArrayElem(const(VARIANT)* varIn, uint iElem, VARIANT* pvar);

///Initializes a VARIANT structure from an array of Boolean values.
///Params:
///    prgf = Type: <b>const BOOL*</b> Pointer to source array of Boolean values.
///    cElems = Type: <b>ULONG</b> The number of elements in the array.
///    pvar = Type: <b>VARIANT*</b> When this function returns, contains the initialized VARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitVariantFromBooleanArray(char* prgf, uint cElems, VARIANT* pvar);

///Initializes a VARIANT structure with an array of 16-bit integer values.
///Params:
///    prgn = Type: <b>const SHORT*</b> Pointer to the source array of <b>SHORT</b> values.
///    cElems = Type: <b>ULONG</b> The number of elements in the array pointed to by <i>prgn</i>.
///    pvar = Type: <b>VARIANT*</b> When this function returns, contains the initialized VARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitVariantFromInt16Array(char* prgn, uint cElems, VARIANT* pvar);

///Initializes a VARIANT structure with an array of unsigned 16-bit integer values.
///Params:
///    prgn = Type: <b>const USHORT*</b> Pointer to the source array of <b>USHORT</b> values.
///    cElems = Type: <b>ULONG</b> The number of elements in the array pointed to by <i>prgn</i>.
///    pvar = Type: <b>VARIANT*</b> When this function returns, contains the initialized VARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitVariantFromUInt16Array(char* prgn, uint cElems, VARIANT* pvar);

///Initializes a VARIANT structure with an array of 32-bit integer values.
///Params:
///    prgn = Type: <b>const LONG*</b> Pointer to the source array of <b>LONG</b> values.
///    cElems = Type: <b>ULONG</b> The number of elements in the array pointed to by <i>prgn</i>.
///    pvar = Type: <b>VARIANT*</b> When this function returns, contains the initialized VARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitVariantFromInt32Array(char* prgn, uint cElems, VARIANT* pvar);

///Initializes a VARIANT structure with an array of unsigned 32-bit integer values.
///Params:
///    prgn = Type: <b>const ULONG*</b> Pointer to the source array of <b>ULONG</b> values.
///    cElems = Type: <b>ULONG</b> The number of elements in the array pointed to by <i>prgn</i>.
///    pvar = Type: <b>VARIANT*</b> When this function returns, contains the initialized VARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitVariantFromUInt32Array(char* prgn, uint cElems, VARIANT* pvar);

///Initializes a VARIANT structure with an array of 64-bit integer values.
///Params:
///    prgn = Type: <b>const LONGLONG*</b> Pointer to the source array of <b>LONGLONG</b> values.
///    cElems = Type: <b>ULONG</b> The number of elements in the array pointed to by <i>prgn</i>. The number of array elements.
///    pvar = Type: <b>VARIANT*</b> When this function returns, contains the initialized VARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitVariantFromInt64Array(char* prgn, uint cElems, VARIANT* pvar);

///Initializes a VARIANT structure with an array of unsigned 64-bit integer values.
///Params:
///    prgn = Type: <b>const ULONGLONG*</b> Pointer to the source array of <b>ULONGLONG</b> values.
///    cElems = Type: <b>ULONG</b> The number of elements in the array pointed to by <i>prgn</i>.
///    pvar = Type: <b>VARIANT*</b> When this function returns, contains the initialized VARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitVariantFromUInt64Array(char* prgn, uint cElems, VARIANT* pvar);

///Initializes a VARIANT structure with an array of values of type DOUBLE.
///Params:
///    prgn = Type: <b>const DOUBLE*</b> Pointer to the source array of DOUBLE values.
///    cElems = Type: <b>ULONG</b> The number of elements in the array pointed to by <i>prgn</i>.
///    pvar = Type: <b>VARIANT*</b> When this function returns, contains the initialized VARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitVariantFromDoubleArray(char* prgn, uint cElems, VARIANT* pvar);

///Initializes a VARIANT structure with an array of strings.
///Params:
///    prgsz = Type: <b>PCWSTR*</b> Pointer to an array of strings.
///    cElems = Type: <b>ULONG</b> The number of elements in the array pointed to by <i>prgsz</i>.
///    pvar = Type: <b>VARIANT*</b> When this function returns, contains the initialized VARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT InitVariantFromStringArray(char* prgsz, uint cElems, VARIANT* pvar);

///Extracts a <b>BOOL</b> value from a VARIANT structure. If no value exists, then the specified default value is
///returned.
///Params:
///    varIn = Type: <b>REFVARIANT</b> Reference to a source VARIANT structure.
///    fDefault = Type: <b>BOOL</b> The default value for use where no extractable value exists.
///Returns:
///    Type: <b>BOOL</b> Returns the extracted <b>BOOL</b> value; otherwise, the default value specified in
///    <i>fDefault</i>.
///    
@DllImport("PROPSYS")
BOOL VariantToBooleanWithDefault(const(VARIANT)* varIn, BOOL fDefault);

///Extracts an <b>Int16</b> property value of a variant structure. If no value exists, then the specified default value
///is returned.
///Params:
///    varIn = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    iDefault = Type: <b>SHORT</b> Specifies default property value, for use where no value currently exists.
@DllImport("PROPSYS")
short VariantToInt16WithDefault(const(VARIANT)* varIn, short iDefault);

///Extracts an unsigned <b>Int16</b> property value of a variant structure. If no value exists, then the specified
///default value is returned.
///Params:
///    varIn = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    uiDefault = Type: <b>USHORT</b> Specifies default property value, for use where no value currently exists.
@DllImport("PROPSYS")
ushort VariantToUInt16WithDefault(const(VARIANT)* varIn, ushort uiDefault);

///Extracts an <b>Int32</b> property value of a variant structure. If no value exists, then the specified default value
///is returned.
///Params:
///    varIn = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    lDefault = Type: <b>LONG</b> Specifies default property value, for use where no value currently exists.
@DllImport("PROPSYS")
int VariantToInt32WithDefault(const(VARIANT)* varIn, int lDefault);

///Extracts an unsigned <b>Int32</b> property value of a variant structure. If no value currently exists, then the
///specified default value is returned.
///Params:
///    varIn = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    ulDefault = Type: <b>ULONG</b> Specifies default property value, for use where no value currently exists.
@DllImport("PROPSYS")
uint VariantToUInt32WithDefault(const(VARIANT)* varIn, uint ulDefault);

///Extracts an <b>Int64</b> property value of a variant structure. If no value exists, then the specified default value
///is returned.
///Params:
///    varIn = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    llDefault = Type: <b>LONGLONG</b> Specifies default property value, for use where no value currently exists.
@DllImport("PROPSYS")
long VariantToInt64WithDefault(const(VARIANT)* varIn, long llDefault);

///Extracts an unsigned <b>Int64</b> property value of a variant structure. If no value currently exists, then the
///specified default value is returned.
///Params:
///    varIn = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    ullDefault = Type: <b>ULONGLONG</b> Specifies default property value, for use where no value currently exists.
@DllImport("PROPSYS")
ulong VariantToUInt64WithDefault(const(VARIANT)* varIn, ulong ullDefault);

///Extracts a <b>DOUBLE</b> value from a VARIANT structure. If no value exists, then the specified default value is
///returned.
///Params:
///    varIn = Type: <b>REFVARIANT</b> Reference to a source VARIANT structure.
///    dblDefault = Type: <b>DOUBLE</b> The default value for use where no extractable value exists.
///Returns:
///    Type: <b>DOUBLE</b> Returns the extracted <b>double</b> value; otherwise, the default value specified in
///    <i>dblDefault</i>.
///    
@DllImport("PROPSYS")
double VariantToDoubleWithDefault(const(VARIANT)* varIn, double dblDefault);

///Extracts the string property value of a variant structure. If no value exists, then the specified default value is
///returned.
///Params:
///    varIn = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    pszDefault = Type: <b>LPCWSTR</b> Pointer to the default Unicode string property value, for use where no value currently
///                 exists.
@DllImport("PROPSYS")
ushort* VariantToStringWithDefault(const(VARIANT)* varIn, const(wchar)* pszDefault);

///Extracts the value of a Boolean property from a VARIANT structure. If no value can be extracted, then a default value
///is assigned.
///Params:
///    varIn = Type: <b>REFVARIANT</b> Reference to a source VARIANT structure.
///    pfRet = Type: <b>BOOL*</b> When this function returns, contains the extracted value if one exists; otherwise,
///            <b>FALSE</b>.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT VariantToBoolean(const(VARIANT)* varIn, int* pfRet);

///Extracts the <b>Int16</b> property value of a variant structure. If no value can be extracted, then a default value
///is assigned by this function.
///Params:
///    varIn = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    piRet = Type: <b>SHORT*</b> Pointer to the extracted property value if one exists; otherwise, 0.
@DllImport("PROPSYS")
HRESULT VariantToInt16(const(VARIANT)* varIn, short* piRet);

///Extracts an unsigned <b>Int16</b> property value of a variant structure. If no value can be extracted, then a default
///value is assigned by this function.
///Params:
///    varIn = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    puiRet = Type: <b>USHORT*</b> Pointer to the extracted property value if one exists; otherwise, 0.
@DllImport("PROPSYS")
HRESULT VariantToUInt16(const(VARIANT)* varIn, ushort* puiRet);

///Extracts an <b>Int32</b> property value of a variant structure. If no value can be extracted, then a default value is
///assigned.
///Params:
///    varIn = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    plRet = Type: <b>LONG*</b> Pointer to the extracted property value if one exists; otherwise, 0.
@DllImport("PROPSYS")
HRESULT VariantToInt32(const(VARIANT)* varIn, int* plRet);

///Extracts unsigned <b>Int32</b> property value of a variant structure. If no value can be extracted, then a default
///value is assigned.
///Params:
///    varIn = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    pulRet = Type: <b>ULONG*</b> Pointer to the extracted property value if one exists; otherwise, 0.
@DllImport("PROPSYS")
HRESULT VariantToUInt32(const(VARIANT)* varIn, uint* pulRet);

///Extracts an <b>Int64</b> property value of a variant structure. If no value can be extracted, then a default value is
///assigned.
///Params:
///    varIn = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    pllRet = Type: <b>LONGLONG*</b> Pointer to the extracted property value if one exists; otherwise, 0.
@DllImport("PROPSYS")
HRESULT VariantToInt64(const(VARIANT)* varIn, long* pllRet);

///Extracts unsigned <b>Int64</b> property value of a variant structure. If no value can be extracted, then a default
///value is assigned.
///Params:
///    varIn = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    pullRet = Type: <b>ULONGLONG*</b> Pointer to the extracted property value if one exists; otherwise, 0.
@DllImport("PROPSYS")
HRESULT VariantToUInt64(const(VARIANT)* varIn, ulong* pullRet);

///Extracts a <b>DOUBLE</b> value from a VARIANT structure. If no value can be extracted, then a default value is
///assigned.
///Params:
///    varIn = Type: <b>REFVARIANT</b> Reference to a source VARIANT structure.
///    pdblRet = Type: <b>DOUBLE*</b> When this function returns, contains the extracted value if one exists; otherwise, 0.0.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT VariantToDouble(const(VARIANT)* varIn, double* pdblRet);

///Extracts the contents of a buffer stored in a VARIANT structure of type VT_ARRRAY | VT_UI1.
///Params:
///    varIn = Type: <b>REFVARIANT</b> Reference to a source VARIANT structure.
///    pv = Type: <b>VOID*</b> Pointer to a buffer of length <i>cb</i> bytes. When this function returns, contains the first
///         <i>cb</i> bytes of the extracted buffer value.
///    cb = Type: <b>UINT</b> The size of the <i>pv</i> buffer, in bytes. The buffer should be the same size as the data to
///         be extracted, or smaller.
///Returns:
///    Type: <b>HRESULT</b> Returns one of the following values: <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Data successfully extracted.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The VARIANT was
///    not of type VT_ARRRAY | VT_UI1. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
///    width="60%"> The VARIANT buffer value had fewer than <i>cb</i> bytes. </td> </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT VariantToBuffer(const(VARIANT)* varIn, char* pv, uint cb);

///Extracts a <b>GUID</b> property value of a variant structure.
///Params:
///    varIn = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    pguid = Type: <b>GUID*</b> Pointer to the extracted property value.
@DllImport("PROPSYS")
HRESULT VariantToGUID(const(VARIANT)* varIn, GUID* pguid);

///Extracts the variant value of a variant structure to a string. If no value can be extracted, then a default value is
///assigned.
///Params:
///    varIn = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    pszBuf = Type: <b>PWSTR</b> Pointer to the extracted property value if one exists; otherwise, empty.
///    cchBuf = Type: <b>UINT</b> Specifies string length, in characters.
@DllImport("PROPSYS")
HRESULT VariantToString(const(VARIANT)* varIn, const(wchar)* pszBuf, uint cchBuf);

///Extracts the variant value of a variant structure to a newly-allocated string. If no value can be extracted, then a
///default value is assigned.
///Params:
///    varIn = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    ppszBuf = Type: <b>PWSTR</b> Pointer to the extracted property value if one exists; otherwise, empty.
@DllImport("PROPSYS")
HRESULT VariantToStringAlloc(const(VARIANT)* varIn, ushort** ppszBuf);

///Extracts a date and time value in Microsoft MS-DOS format from a VARIANT structure.
///Params:
///    varIn = Type: <b>REFVARIANT</b> Reference to a source VARIANT structure.
///    pwDate = Type: <b>WORD*</b> When this function returns, contains the extracted <b>WORD</b> that represents a MS-DOS date.
///    pwTime = Type: <b>WORD*</b> When this function returns, contains the extracted contains the extracted <b>WORD</b> that
///             represents a MS-DOS time.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT VariantToDosDateTime(const(VARIANT)* varIn, ushort* pwDate, ushort* pwTime);

///If the source variant is a VT_BSTR, extracts string and places it into a STRRET structure.
///Params:
///    varIn = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    pstrret = Type: <b>STRRET*</b> Pointer to the extracted string if one exists.
@DllImport("PROPSYS")
HRESULT VariantToStrRet(const(VARIANT)* varIn, STRRET* pstrret);

///Extracts a FILETIME structure from a variant structure.
///Params:
///    varIn = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    stfOut = Type: <b>PSTIME_FLAGS</b> Specifies one of the following time flags:
///    pftOut = Type: <b>FILETIME*</b> Pointer to the extracted FILETIME structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT VariantToFileTime(const(VARIANT)* varIn, int stfOut, FILETIME* pftOut);

///Retrieves the element count of a variant structure.
///Params:
///    varIn = Type: <b>REFVARIANT</b> Reference to a source variant structure.
@DllImport("PROPSYS")
uint VariantGetElementCount(const(VARIANT)* varIn);

///Extracts an array of Boolean values from a VARIANT structure.
///Params:
///    var = Type: <b>REFVARIANT</b> Reference to a source VARIANT structure.
///    prgf = Type: <b>BOOL*</b> Pointer to a buffer that contains <i>crgn</i> Boolean values. When this function returns, the
///           buffer has been initialized with *<i>pcElem</i> <b>BOOL</b> elements extracted from the source VARIANT structure.
///    crgn = Type: <b>ULONG</b> The number of elements in the buffer pointed to by <i>prgf</i>.
///    pcElem = Type: <b>ULONG*</b> When this function returns, contains a pointer to the count of <b>BOOL</b> elements extracted
///             from the source VARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> Returns <b>S_OK</b> if successful, or an error value otherwise, including the following:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TYPE_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The source VARIANT contained more than
///    <i>crgn</i> values. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
///    width="60%"> The VARIANT was not of the appropriate type. </td> </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT VariantToBooleanArray(const(VARIANT)* var, char* prgf, uint crgn, uint* pcElem);

///Extracts data from a vector structure into an <b>Int16</b> array.
///Params:
///    var = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    prgn = Type: <b>SHORT*</b> Pointer to the <b>Int16</b> data extracted from source variant structure.
///    crgn = Type: <b>ULONG</b> Specifies <b>Int16</b> array size.
///    pcElem = Type: <b>ULONG*</b> Pointer to the count of <b>Int16</b> elements extracted from source variant structure.
@DllImport("PROPSYS")
HRESULT VariantToInt16Array(const(VARIANT)* var, char* prgn, uint crgn, uint* pcElem);

///Extracts data from a vector structure into an unsigned <b>Int16</b> array.
///Params:
///    var = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    prgn = Type: <b>USHORT*</b> Pointer to the unsigned <b>Int16</b> data extracted from source variant structure.
///    crgn = Type: <b>ULONG</b> Specifies unsigned <b>Int16</b> array size.
///    pcElem = Type: <b>ULONG*</b> Pointer to the count of unsigned <b>Int16</b> elements extracted from source variant
///             structure.
@DllImport("PROPSYS")
HRESULT VariantToUInt16Array(const(VARIANT)* var, char* prgn, uint crgn, uint* pcElem);

///Extracts data from a vector structure into an <b>Int32</b> array.
///Params:
///    var = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    prgn = Type: <b>LONG*</b> Pointer to the <b>Int32</b> data extracted from source variant structure.
///    crgn = Type: <b>ULONG</b> Specifies <b>Int32</b> array size.
///    pcElem = Type: <b>ULONG*</b> Pointer to the count of <b>Int32</b> elements extracted from source variant structure.
@DllImport("PROPSYS")
HRESULT VariantToInt32Array(const(VARIANT)* var, char* prgn, uint crgn, uint* pcElem);

///Extracts data from a vector structure into an unsigned <b>Int32</b> array.
///Params:
///    var = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    prgn = Type: <b>ULONG*</b> Pointer to the unsigned <b>Int32</b> data extracted from source variant structure.
///    crgn = Type: <b>ULONG</b> Specifies unsigned <b>Int32</b> array size.
///    pcElem = Type: <b>ULONG*</b> Pointer to the count of unsigned <b>Int32</b> elements extracted from source variant
///             structure.
@DllImport("PROPSYS")
HRESULT VariantToUInt32Array(const(VARIANT)* var, char* prgn, uint crgn, uint* pcElem);

///Extracts data from a vector structure into an <b>Int64</b> array.
///Params:
///    var = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    prgn = Type: <b>LONGLONG*</b> Pointer to the Int64 data extracted from source variant structure.
///    crgn = Type: <b>ULONG</b> Specifies Int64 array size.
///    pcElem = Type: <b>ULONG*</b> Pointer to the count of Int64 elements extracted from source variant structure.
@DllImport("PROPSYS")
HRESULT VariantToInt64Array(const(VARIANT)* var, char* prgn, uint crgn, uint* pcElem);

///Extracts data from a vector structure into an unsigned <b>Int64</b> array.
///Params:
///    var = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    prgn = Type: <b>ULONGLONG*</b> Pointer to the unsigned <b>Int64</b> data extracted from source variant structure.
///    crgn = Type: <b>ULONG</b> Specifies unsigned <b>Int64</b> array size.
///    pcElem = Type: <b>ULONG*</b> Pointer to the count of unsigned <b>Int64</b> elements extracted from source variant
///             structure.
@DllImport("PROPSYS")
HRESULT VariantToUInt64Array(const(VARIANT)* var, char* prgn, uint crgn, uint* pcElem);

///Extracts an array of <b>DOUBLE</b> values from a VARIANT structure.
///Params:
///    var = Type: <b>REFVARIANT</b> Reference to a source VARIANT structure.
///    prgn = Type: <b>DOUBLE*</b> Pointer to a buffer that contains <i>crgn</i> <b>DOUBLE</b> values. When this function
///           returns, the buffer has been initialized with *<i>pcElem</i> <b>DOUBLE</b> elements extracted from the source
///           VARIANT structure.
///    crgn = Type: <b>ULONG</b> The number of elements in the buffer pointed to by <i>prgn</i>.
///    pcElem = Type: <b>ULONG*</b> When this function returns, contains the count of <b>DOUBLE</b> elements extracted from the
///             source VARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> Returns <b>S_OK</b> if successful, or an error value otherwise, including the following:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TYPE_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The source VARIANT contained more than
///    <i>crgn</i> values. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
///    width="60%"> The VARIANT was not of the appropriate type. </td> </tr> </table>
///    
@DllImport("PROPSYS")
HRESULT VariantToDoubleArray(const(VARIANT)* var, char* prgn, uint crgn, uint* pcElem);

///Extracts data from a vector structure into a String array.
///Params:
///    var = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    prgsz = Type: <b>PWSTR*</b> Pointer to the string data extracted from source variant structure.
///    crgsz = Type: <b>ULONG</b> Specifies string array size.
///    pcElem = Type: <b>ULONG*</b> Pointer to the count of string elements extracted from source variant structure.
@DllImport("PROPSYS")
HRESULT VariantToStringArray(const(VARIANT)* var, char* prgsz, uint crgsz, uint* pcElem);

///Allocates an array of <b>BOOL</b> values then extracts data from a VARIANT structure into that array.
///Params:
///    var = Type: <b>REFVARIANT</b> Reference to a source VARIANT structure.
///    pprgf = Type: <b>BOOL**</b> When this function returns, contains a pointer to an array of <b>BOOL</b> values extracted
///            from the source VARIANT structure.
///    pcElem = Type: <b>ULONG*</b> When this function returns, contains a pointer to the count of elements extracted from the
///             source VARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT VariantToBooleanArrayAlloc(const(VARIANT)* var, int** pprgf, uint* pcElem);

///Extracts data from a vector structure into a newly-allocated <b>Int16</b> array.
///Params:
///    var = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    pprgn = Type: <b>SHORT**</b> Pointer to the address of the <b>Int16</b> data extracted from source variant structure.
///    pcElem = Type: <b>ULONG*</b> Pointer to the count of <b>Int16</b> elements extracted from source variant structure.
@DllImport("PROPSYS")
HRESULT VariantToInt16ArrayAlloc(const(VARIANT)* var, short** pprgn, uint* pcElem);

///Extracts data from a vector structure into a newly-allocated unsigned <b>Int16</b> array.
///Params:
///    var = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    pprgn = Type: <b>USHORT**</b> Pointer to the address of the unsigned <b>Int16</b> data extracted from the source variant
///            structure.
///    pcElem = Type: <b>ULONG*</b> Pointer to the count of unsigned <b>Int16</b> elements extracted from the source variant
///             structure.
@DllImport("PROPSYS")
HRESULT VariantToUInt16ArrayAlloc(const(VARIANT)* var, ushort** pprgn, uint* pcElem);

///Extracts data from a vector structure into a newly-allocated <b>Int32</b> array.
///Params:
///    var = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    pprgn = Type: <b>LONG**</b> Pointer to the address of the <b>Int32</b> data extracted from source variant structure.
///    pcElem = Type: <b>ULONG*</b> Pointer to the count of <b>Int32</b> elements extracted from source variant structure.
@DllImport("PROPSYS")
HRESULT VariantToInt32ArrayAlloc(const(VARIANT)* var, int** pprgn, uint* pcElem);

///Extracts data from a vector structure into a newly-allocated unsigned <b>Int32</b> array.
///Params:
///    var = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    pprgn = Type: <b>ULONG**</b> The address of a pointer to the unsigned <b>Int32</b> data extracted from source variant
///            structure.
///    pcElem = Type: <b>ULONG*</b> Pointer to the count of unsigned <b>Int32</b> elements extracted from source variant
///             structure.
@DllImport("PROPSYS")
HRESULT VariantToUInt32ArrayAlloc(const(VARIANT)* var, uint** pprgn, uint* pcElem);

///Extracts data from a vector structure into a newly-allocated <b>Int64</b> array.
///Params:
///    var = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    pprgn = Type: <b>LONGLONG**</b> Pointer to the address of the <b>Int64</b> data extracted from source variant structure.
///    pcElem = Type: <b>ULONG*</b> Pointer to the count of <b>Int64</b> elements extracted from source variant structure.
@DllImport("PROPSYS")
HRESULT VariantToInt64ArrayAlloc(const(VARIANT)* var, long** pprgn, uint* pcElem);

///Extracts data from a vector structure into a newly-allocated unsigned <b>Int64</b> array.
///Params:
///    var = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    pprgn = Type: <b>ULONGLONG**</b> The address of a pointer to the unsigned <b>Int64</b> data extracted from source variant
///            structure.
///    pcElem = Type: <b>ULONG*</b> Pointer to the count of unsigned <b>Int64</b> elements extracted from source variant
///             structure.
@DllImport("PROPSYS")
HRESULT VariantToUInt64ArrayAlloc(const(VARIANT)* var, ulong** pprgn, uint* pcElem);

///Allocates an array of <b>DOUBLE</b> values then extracts data from a VARIANT structure into that array.
///Params:
///    var = Type: <b>REFVARIANT</b> Reference to a source VARIANT structure.
///    pprgn = Type: <b>DOUBLE**</b> When this function returns, contains a pointer to an array of <b>DOUBLE</b> values
///            extracted from the source VARIANT structure.
///    pcElem = Type: <b>ULONG*</b> When this function returns, contains a pointer to the count of elements extracted from the
///             source VARIANT structure.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROPSYS")
HRESULT VariantToDoubleArrayAlloc(const(VARIANT)* var, double** pprgn, uint* pcElem);

///Extracts data from a vector structure into a newly-allocated String array.
///Params:
///    var = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    pprgsz = Type: <b>PWSTR**</b> The address of a pointer to the string data extracted from source variant structure.
///    pcElem = Type: <b>ULONG*</b> Pointer to the count of string elements extracted from source variant structure.
@DllImport("PROPSYS")
HRESULT VariantToStringArrayAlloc(const(VARIANT)* var, ushort*** pprgsz, uint* pcElem);

///Extracts a single Boolean element from a variant structure.
///Params:
///    var = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    iElem = Type: <b>ULONG</b> Specifies vector or array index; otherwise, value must be 0.
///    pfVal = Type: <b>BOOL*</b> Pointer to the extracted element value.
@DllImport("PROPSYS")
HRESULT VariantGetBooleanElem(const(VARIANT)* var, uint iElem, int* pfVal);

///Extracts a single <b>Int16</b> element from a variant structure.
///Params:
///    var = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    iElem = Type: <b>ULONG</b> Specifies vector or array index; otherwise, value must be 0.
///    pnVal = Type: <b>SHORT*</b> Pointer to the extracted element value.
@DllImport("PROPSYS")
HRESULT VariantGetInt16Elem(const(VARIANT)* var, uint iElem, short* pnVal);

///Extracts a single unsigned <b>Int16</b> element from a variant structure.
///Params:
///    var = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    iElem = Type: <b>ULONG</b> Specifies a vector or array index; otherwise, value must be 0.
///    pnVal = Type: <b>USHORT*</b> Pointer to the extracted element value.
@DllImport("PROPSYS")
HRESULT VariantGetUInt16Elem(const(VARIANT)* var, uint iElem, ushort* pnVal);

///Extracts a single <b>Int32</b> element from a variant structure.
///Params:
///    var = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    iElem = Type: <b>ULONG</b> Specifies vector or array index; otherwise, value must be 0.
///    pnVal = Type: <b>LONG*</b> Pointer to the extracted element value.
@DllImport("PROPSYS")
HRESULT VariantGetInt32Elem(const(VARIANT)* var, uint iElem, int* pnVal);

///Extracts a single unsigned <b>Int32</b> element from a variant structure.
///Params:
///    var = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    iElem = Type: <b>ULONG</b> Specifies vector or array index; otherwise, value must be 0.
///    pnVal = Type: <b>ULONG*</b> Pointer to the extracted element value.
@DllImport("PROPSYS")
HRESULT VariantGetUInt32Elem(const(VARIANT)* var, uint iElem, uint* pnVal);

///Extracts a single <b>Int64</b> element from a variant structure.
///Params:
///    var = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    iElem = Type: <b>ULONG</b> Specifies vector or array index; otherwise, value must be 0.
///    pnVal = Type: <b>LONGLONG*</b> Pointer to the extracted element value.
@DllImport("PROPSYS")
HRESULT VariantGetInt64Elem(const(VARIANT)* var, uint iElem, long* pnVal);

///Extracts a single unsigned <b>Int64</b> element from a variant structure.
///Params:
///    var = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    iElem = Type: <b>ULONG</b> Specifies vector or array index; otherwise, value must be 0.
///    pnVal = Type: <b>ULONGLONG*</b> Pointer to the extracted element value.
@DllImport("PROPSYS")
HRESULT VariantGetUInt64Elem(const(VARIANT)* var, uint iElem, ulong* pnVal);

///Extracts one <b>double</b> element from a variant structure.
///Params:
///    var = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    iElem = Type: <b>ULONG</b> Specifies vector or array index; otherwise, value must be 0.
///    pnVal = Type: <b>DOUBLE*</b> Pointer to the extracted element value.
@DllImport("PROPSYS")
HRESULT VariantGetDoubleElem(const(VARIANT)* var, uint iElem, double* pnVal);

///Extracts a single wide string element from a variant structure.
///Params:
///    var = Type: <b>REFVARIANT</b> Reference to a source variant structure.
///    iElem = Type: <b>ULONG</b> Specifies a vector or array index; otherwise, value must be 0.
///    ppszVal = Type: <b>PWSTR*</b> The address of a pointer to the extracted element value.
@DllImport("PROPSYS")
HRESULT VariantGetStringElem(const(VARIANT)* var, uint iElem, ushort** ppszVal);

///Frees the memory and references used by an array of VARIANT structures stored in an array.
///Params:
///    pvars = Type: <b>VARIANT*</b> Array of VARIANT structures to free.
///    cvars = Type: <b>UINT</b> The number of elements in the array specified by <i>pvars</i>.
///Returns:
///    No return value.
///    
@DllImport("PROPSYS")
void ClearVariantArray(char* pvars, uint cvars);

///Compares two variant structures, based on default comparison rules.
///Params:
///    var1 = Type: <b>REFVARIANT</b> Reference to a first variant structure.
///    var2 = Type: <b>REFVARIANT</b> Reference to a second variant structure.
///Returns:
///    Type: <b>INT</b> <ul> <li>Returns 1 if <i>var1</i> is greater than <i>var2</i></li> <li>Returns 0 if <i>var1</i>
///    equals <i>var2</i></li> <li>Returns -1 if <i>var1</i> is less than <i>var2</i></li> </ul>
///    
@DllImport("PROPSYS")
int VariantCompare(const(VARIANT)* var1, const(VARIANT)* var2);

///Retrieves an object that represents a specific window's collection of properties, which allows those properties to be
///queried or set.
///Params:
///    hwnd = Type: <b>HWND</b> A handle to the window whose properties are being retrieved.
///    riid = Type: <b>REFIID</b> A reference to the IID of the property store object to retrieve through <i>ppv</i>. This is
///           typically IID_IPropertyStore.
///    ppv = Type: <b>void**</b> When this function returns, contains the interface pointer requested in <i>riid</i>. This is
///          typically IPropertyStore.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("SHELL32")
HRESULT SHGetPropertyStoreForWindow(HWND hwnd, const(GUID)* riid, void** ppv);

///Retrieves an object that supports IPropertyStore or related interfaces from a pointer to an item identifier list
///(PIDL).
///Params:
///    pidl = Type: <b>PCIDLIST_ABSOLUTE</b> A pointer to an item ID list.
///    flags = Type: <b>GETPROPERTYSTOREFLAGS</b> One or more values from the GETPROPERTYSTOREFLAGS constants. This parameter
///            can also be <b>NULL</b>.
///    riid = Type: <b>REFIID</b> A reference to the desired interface ID.
@DllImport("SHELL32")
HRESULT SHGetPropertyStoreFromIDList(ITEMIDLIST* pidl, GETPROPERTYSTOREFLAGS flags, const(GUID)* riid, void** ppv);

///Returns a property store for an item, given a path or parsing name.
///Params:
///    pszPath = Type: <b>PCWSTR</b> A pointer to a null-terminated Unicode string that specifies the item path.
///    pbc = Type: <b>IBindCtx*</b> A pointer to a IBindCtx object, which provides access to a bind context. This value can be
///          <b>NULL</b>.
///    flags = Type: <b>GETPROPERTYSTOREFLAGS</b> One or more values from the GETPROPERTYSTOREFLAGS constants. This parameter
///            can also be <b>NULL</b>.
///    riid = Type: <b>REFIID</b> A reference to the desired interface ID.
///    ppv = Type: <b>void**</b> When this function returns, contains the interface pointer requested in <i>riid</i>. This is
///          typically IPropertyStore or a related interface.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("SHELL32")
HRESULT SHGetPropertyStoreFromParsingName(const(wchar)* pszPath, IBindCtx pbc, GETPROPERTYSTOREFLAGS flags, 
                                          const(GUID)* riid, void** ppv);

///Adds default properties to the property store as registered for the specified file extension.
///Params:
///    pszExt = Type: <b>PCWSTR</b> A pointer to a null-terminated, Unicode string that specifies the extension.
///    pPropStore = Type: <b>IPropertyStore*</b> A pointer to the IPropertyStore interface that defines the default properties to
///                 add.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("SHELL32")
HRESULT SHAddDefaultPropertiesByExt(const(wchar)* pszExt, IPropertyStore pPropStore);

///<p class="CCE_Message">[<b>PifMgr_OpenProperties</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions.] Opens the .pif file associated with a
///Microsoft MS-DOS application, and returns a handle to the application's properties.
///Params:
///    pszApp = Type: <b>PCWSTR</b> A null-terminated Unicode string that contains the application's name.
///    pszPIF = Type: <b>PCWSTR</b> A null-terminated Unicode string that contains the name of the .pif file.
///    hInf = Type: <b>UINT</b> A handle to the application's .inf file. Set this value to zero if there is no .inf file. Set
///           this value to -1 to prevent the .inf file from being processed.
///    flOpt = Type: <b>UINT</b> A flag that controls how the function operates.
///Returns:
///    Type: <b>HANDLE</b> Returns a handle to the application's properties. Use this handle when you call the related
///    .pif functions.
///    
@DllImport("SHELL32")
HANDLE PifMgr_OpenProperties(const(wchar)* pszApp, const(wchar)* pszPIF, uint hInf, uint flOpt);

///<p class="CCE_Message">[<b>PifMgr_GetProperties</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions.] Returns a specified block of data
///from a .pif file.
///Params:
///    hProps = Type: <b>HANDLE</b> A handle to an application's properties. This parameter should be set to the value that is
///             returned by PifMgr_OpenProperties.
///    pszGroup = Type: <b>PCSTR</b> A null-terminated string that contains the property group name. It can be one of the
///               following, or any other name that corresponds to a valid .pif extension.
///    lpProps = Type: <b>void*</b> When this function returns, contains a pointer to a PROPPRG structure.
///    cbProps = Type: <b>int</b> The size of the buffer, in bytes, pointed to by <i>lpProps</i>.
///    flOpt = Type: <b>UINT</b> Set this parameter to GETPROPS_NONE.
///Returns:
///    Type: <b>int</b> Returns <b>NULL</b> if successful. If unsuccessful, the function returns the handle to the
///    application properties that were passed as <i>hProps</i>.
///    
@DllImport("SHELL32")
int PifMgr_GetProperties(HANDLE hProps, const(char)* pszGroup, char* lpProps, int cbProps, uint flOpt);

///<p class="CCE_Message">[<b>PifMgr_SetProperties</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions.] Assigns values to a block of data
///from a .pif file.
///Params:
///    hProps = Type: <b>HANDLE</b> A handle to the application's properties. This parameter should be set to the value that is
///             returned by PifMgr_OpenProperties.
///    pszGroup = Type: <b>PCSTR</b> A null-terminated ANSI string containing the property group name. It can be one of the
///               following, or any other name that corresponds to a valid .pif extension.
///    lpProps = Type: <b>const void*</b> A property group record buffer that holds the data.
///    cbProps = Type: <b>int</b> The size of the buffer, in bytes, pointed to by <i>lpProps</i>.
///    flOpt = Type: <b>UINT</b> Always SETPROPS_NONE.
///Returns:
///    Type: <b>int</b> Returns the amount of information transferred, in bytes. Returns zero if the group cannot be
///    found or an error occurs.
///    
@DllImport("SHELL32")
int PifMgr_SetProperties(HANDLE hProps, const(char)* pszGroup, char* lpProps, int cbProps, uint flOpt);

///<p class="CCE_Message">[<b>PifMgr_CloseProperties</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions.] Closes application properties that
///were opened with PifMgr_OpenProperties.
///Params:
///    hProps = Type: <b>HANDLE</b> A handle to the application's properties. This parameter should be set to the value that is
///             returned by PifMgr_OpenProperties.
///    flOpt = Type: <b>UINT</b> A flag that specifies how the function operates.
///Returns:
///    Type: <b>int</b> Returns <b>NULL</b> if successful. If unsuccessful, the functions returns the handle to the
///    application properties that was passed as <i>hProps</i>.
///    
@DllImport("SHELL32")
HANDLE PifMgr_CloseProperties(HANDLE hProps, uint flOpt);

///<p class="CCE_Message">[This function is available through Windows XP Service Pack 2 (SP2) and Windows Server 2003.
///It might be altered or unavailable in subsequent versions of Windows.] Ensures proper handling of code page retrieval
///or assignment for the requested property set operation.
///Params:
///    psstg = Type: <b>IPropertySetStorage*</b> A pointer to an IPropertySetStorage interface.
///    fmtid = Type: <b>REFFMTID</b> A property set ID to open. The values for this parameter can be either one of those defined
///            in Predefined Property Set Format Identifiers or any other FMTID that you register.
///    pclsid = Type: <b>const CLSID*</b> A pointer to the CLSID associated with the set. This parameter can be <b>NULL</b>.
///    grfFlags = Type: <b>DWORD</b> One or more members of the PROPSETFLAG enumeration that determine how the property set is
///               created and opened. All sets containing ANSI bytes should be created with PROPSETFLAG_ANSI, otherwise
///               PROPSETFLAG_DEFAULT.
///    grfMode = Type: <b>DWORD</b> The flags from the STGM enumeration that indicate conditions for creating and deleting the
///              object and access modes for the object. Must contain STGM_DIRECT | STGM_SHARE_EXCLUSIVE.
///    dwDisposition = Type: <b>DWORD</b> One of the following values, defined in Fileapi.h.
///    ppstg = Type: <b>IPropertyStorage**</b> When this method returns, contains an IPropertyStorage interface pointer.
///    puCodePage = Type: <b>UINT*</b> When this method returns, contains the address of the code page ID for the set.
@DllImport("SHELL32")
HRESULT SHPropStgCreate(IPropertySetStorage psstg, const(GUID)* fmtid, const(GUID)* pclsid, uint grfFlags, 
                        uint grfMode, uint dwDisposition, IPropertyStorage* ppstg, uint* puCodePage);

///<p class="CCE_Message">[This function is available through Windows XP Service Pack 2 (SP2) and Windows Server 2003.
///It might be altered or unavailable in subsequent versions of Windows.] Wraps the IPropertyStorage::ReadMultiple
///function to ensure that ANSI and Unicode translations are handled properly for deprecated property sets.
///Params:
///    pps = Type: <b>IPropertyStorage*</b> An IPropertyStorage interface pointer that identifies the property store.
///    uCodePage = Type: <b>UINT</b> A code page value for ANSI string properties.
///    cpspec = Type: <b>ULONG</b> A count of properties being read.
///    rgpspec = Type: <b>PROPSPEC const[]</b> An array of properties to be read.
///    rgvar = Type: <b>PROPVARIANT[]</b> An array of PROPVARIANT types that, when this function returns successfully, receives
///            the property values.
@DllImport("SHELL32")
HRESULT SHPropStgReadMultiple(IPropertyStorage pps, uint uCodePage, uint cpspec, char* rgpspec, char* rgvar);

///<p class="CCE_Message">[This function is available through Windows XP Service Pack 2 (SP2) and Windows Server 2003.
///It might be altered or unavailable in subsequent versions of Windows.] Wraps the IPropertyStorage::WriteMultiple
///function to ensure that ANSI and Unicode translations are handled properly for deprecated property sets.
///Params:
///    pps = Type: <b>IPropertyStorage*</b> An IPropertyStorage interface pointer that identifies the property store.
///    puCodePage = Type: <b>UINT*</b> A pointer to the code page value for ANSI string properties.
///    cpspec = Type: <b>ULONG</b> A count of properties being set.
///    rgpspec = Type: <b>PROPSPEC const[]</b> An array of PROPSPEC structures that contain the property information to be set.
///    rgvar = Type: <b>PROPVARIANT[]</b> An array of PROPVARIANT types to set the property values.
///    propidNameFirst = Type: <b>PROPID</b> The minimum value for property identifiers when they must be allocated. The value should be
///                      greater than or equal to PID_FIRST_USABLE.
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

///Exposes a method that encapsulates a change to a single property.
@GUID("F917BC8A-1BBA-4478-A245-1BDE03EB9431")
interface IPropertyChange : IObjectWithPropertyKey
{
    ///Applies a change to a property value.
    ///Params:
    ///    propvarIn = Type: <b>REFPROPVARIANT</b> A reference to a source PROPVARIANT structure.
    ///    ppropvarOut = Type: <b>PROPVARIANT*</b> A pointer to a changed PROPVARIANT structure.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ApplyToPropVariant(const(PROPVARIANT)* propvarIn, PROPVARIANT* ppropvarOut);
}

///Exposes methods for several multiple change operations that may be passed to IFileOperation.
@GUID("380F5CAD-1B5E-42F2-805D-637FD392D31E")
interface IPropertyChangeArray : IUnknown
{
    ///Gets the number of change operations in the array.
    ///Params:
    ///    pcOperations = Type: <b>UINT*</b> A pointer to the number of change operations.
    HRESULT GetCount(uint* pcOperations);
    ///Gets the change operation at a specified array index.
    ///Params:
    ///    iIndex = Type: <b>UINT</b> The index of the change to retrieve.
    ///    riid = Type: <b>REFIID</b> A reference to the desired IID.
    ///    ppv = Type: <b>void**</b> The address of a pointer to the interface specified by <i>riid</i>, usually
    ///          IPropertyChange.
    HRESULT GetAt(uint iIndex, const(GUID)* riid, void** ppv);
    ///Inserts a change operation into an array at the specified position.
    ///Params:
    ///    iIndex = Type: <b>UINT</b> The index at which the change is inserted.
    ///    ppropChange = Type: <b>IPropertyChange*</b> A pointer to the interface that contains the change.
    HRESULT InsertAt(uint iIndex, IPropertyChange ppropChange);
    ///Inserts a change operation at the end of an array.
    ///Params:
    ///    ppropChange = Type: <b>IPropertyChange*</b> A pointer to the interface that contains the change.
    HRESULT Append(IPropertyChange ppropChange);
    ///Replaces the first occurrence of a change that affects the same property key as the provided change. If the
    ///property key is not already in the array, this method appends the change to the end of the array.
    ///Params:
    ///    ppropChange = Type: <b>IPropertyChange*</b> A pointer to the interface that contains the change
    HRESULT AppendOrReplace(IPropertyChange ppropChange);
    ///Removes a specified change.
    ///Params:
    ///    iIndex = Type: <b>UINT</b> The index of the change to remove.
    HRESULT RemoveAt(uint iIndex);
    ///Specifies whether a particular property key exists in the change array.
    ///Params:
    ///    key = Type: <b>REFPROPERTYKEY</b> A reference to the PROPERTYKEY structure of interest.
    HRESULT IsKeyInArray(const(PROPERTYKEY)* key);
}

///Exposes a method that determines whether a property can be edited in the UI by the user.
@GUID("C8E2D566-186E-4D49-BF41-6909EAD56ACC")
interface IPropertyStoreCapabilities : IUnknown
{
    ///Queries whether the property handler allows a specific property to be edited in the UI by the user.
    ///Params:
    ///    key = Type: <b>REFPROPERTYKEY</b> A reference to PROPERTYKEY structure that represents the property being queried.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    property can be edited and stored by the handler. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The property cannot be edited. </td> </tr> </table>
    ///    
    HRESULT IsPropertyWritable(const(PROPERTYKEY)* key);
}

///Exposes methods that allow a handler to manage various states for each property.
@GUID("3017056D-9A91-4E90-937D-746C72ABBF4F")
interface IPropertyStoreCache : IPropertyStore
{
    ///Gets the state of a specified property key.
    ///Params:
    ///    key = Type: <b>REFPROPERTYKEY</b> A reference to a PROPERTYKEY structure.
    ///    pstate = Type: <b>PSC_STATE*</b> A pointer to a PSC_STATE enumeration value.
    HRESULT GetState(const(PROPERTYKEY)* key, PSC_STATE* pstate);
    ///Gets value and state data for a property key.
    ///Params:
    ///    key = Type: <b>REFPROPERTYKEY</b> A reference to a PROPERTYKEY structure identifying the property.
    ///    ppropvar = Type: <b>PROPVARIANT*</b> A pointer to a PROPVARIANT structure for the property data.
    ///    pstate = Type: <b>PSC_STATE*</b> A pointer to a PSC_STATE enumeration value declaring the current state of the
    ///             property.
    HRESULT GetValueAndState(const(PROPERTYKEY)* key, PROPVARIANT* ppropvar, PSC_STATE* pstate);
    HRESULT SetState(const(PROPERTYKEY)* key, PSC_STATE state);
    ///Sets value and state data for a property key.
    ///Params:
    ///    key = Type: <b>REFPROPERTYKEY</b> A reference to a PROPERTYKEY structure identifying the property.
    ///    ppropvar = Type: <b>const PROPVARIANT*</b> A pointer to a PROPVARIANT structure containing the property data.
    ///    state = Type: <b>PSC_STATE</b> A value from the PSC_STATE enumeration declaring the state of the property.
    HRESULT SetValueAndState(const(PROPERTYKEY)* key, const(PROPVARIANT)* ppropvar, PSC_STATE state);
}

///Exposes methods that extract data from enumeration information. IPropertyEnumType gives access to the enum and
///enumRange elements in the property schema in a programmatic way at run time.
@GUID("11E1FBF9-2D56-4A6B-8DB3-7CD193A471F2")
interface IPropertyEnumType : IUnknown
{
    ///Gets an enumeration type from an enumeration information structure.
    ///Params:
    ///    penumtype = Type: <b>PROPENUMTYPE*</b> When this method returns, contains a pointer to one of the values listed below
    ///                that indicate the enumeration type.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetEnumType(PROPENUMTYPE* penumtype);
    ///Gets a value from an enumeration information structure.
    ///Params:
    ///    ppropvar = Type: <b>PROPVARIANT*</b> When this method returns, contains a pointer to the property value.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetValue(PROPVARIANT* ppropvar);
    ///Gets a minimum value from an enumeration information structure.
    ///Params:
    ///    ppropvarMin = Type: <b>PROPVARIANT*</b> When this method returns, contains a pointer to the minimum value.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetRangeMinValue(PROPVARIANT* ppropvarMin);
    ///Gets a set value from an enumeration information structure.
    ///Params:
    ///    ppropvarSet = Type: <b>PROPVARIANT*</b> When this method returns, contains a pointer to the set value.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetRangeSetValue(PROPVARIANT* ppropvarSet);
    ///Gets display text from an enumeration information structure.
    ///Params:
    ///    ppszDisplay = Type: <b>LPWSTR*</b> When this method returns, contains the address of a pointer to a null-terminated Unicode
    ///                  string that contains the display text.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetDisplayText(ushort** ppszDisplay);
}

///Exposes methods that extract data from enumeration information. IPropertyEnumType2 extends IPropertyEnumType.
@GUID("9B6E051C-5DDD-4321-9070-FE2ACB55E794")
interface IPropertyEnumType2 : IPropertyEnumType
{
    ///Retrieves the image reference associated with a property enumeration.
    ///Params:
    ///    ppszImageRes = Type: <b>LPWSTR*</b> A pointer to a buffer that, when this method returns successfully, receives a string of
    ///                   the form &lt;dll name&gt;,-&lt;resid&gt; that is suitable to be passed to PathParseIconLocation.
    HRESULT GetImageReference(ushort** ppszImageRes);
}

///Exposes methods that enumerate the possible values for a property.
@GUID("A99400F4-3D84-4557-94BA-1242FB2CC9A6")
interface IPropertyEnumTypeList : IUnknown
{
    ///Gets the number of elements in the list.
    ///Params:
    ///    pctypes = Type: <b>UINT*</b> When this method returns, contains a pointer to the number of list elements.
    HRESULT GetCount(uint* pctypes);
    ///Gets the IPropertyEnumType object at the specified index in the list.
    ///Params:
    ///    itype = Type: <b>UINT</b> The index of the object in the list.
    ///    riid = Type: <b>REFIID</b> A reference to the IID of the interface to retrieve through ppv, typically
    ///           IID_IShellItem.
    ///    ppv = Type: <b>void**</b> When this method returns successfully, contains the interface pointer requested in riid.
    ///          This is typically [IPropertyEnumType](nn-propsys-ipropertyenumtype.md).
    HRESULT GetAt(uint itype, const(GUID)* riid, void** ppv);
    ///Not supported. Gets the condition at the specified index.
    ///Params:
    ///    nIndex = Type: <b>UINT</b> Index of the desired condition.
    ///    riid = Type: <b>REFIID</b> A reference to the IID of the interface to retrieve.
    ///    ppv = Type: <b>void**</b> When this method returns, contains the address of an ICondition interface pointer.
    HRESULT GetConditionAt(uint nIndex, const(GUID)* riid, void** ppv);
    ///Compares the specified property value against the enumerated values in a list and returns the matching index.
    ///Params:
    ///    propvarCmp = Type: <b>REFPROPVARIANT</b> A reference to a PROPVARIANT structure that represents the property value.
    ///    pnIndex = Type: <b>UINT*</b> When this method returns, contains a pointer to the index in the enumerated type list that
    ///              matches the property value, if any.
    HRESULT FindMatchingIndex(const(PROPVARIANT)* propvarCmp, uint* pnIndex);
}

///Exposes methods that enumerate and retrieve individual property description details.
@GUID("6F79D558-3E96-4549-A1D1-7D75D2288814")
interface IPropertyDescription : IUnknown
{
    ///Gets a structure that acts as a property's unique identifier.
    ///Params:
    ///    pkey = Type: <b>PROPERTYKEY*</b> When this method returns, contains a pointer to a PROPERTYKEY structure.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPropertyKey(PROPERTYKEY* pkey);
    ///Gets the case-sensitive name by which a property is known to the system, regardless of its localized name.
    ///Params:
    ///    ppszName = Type: <b>LPWSTR*</b> When this method returns, contains the address of a pointer to the property's canonical
    ///               name as a null-terminated Unicode string.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCanonicalName(ushort** ppszName);
    ///Gets the variant type of the property.
    ///Params:
    ///    pvartype = Type: <b>VARTYPE*</b> When this method returns, contains a pointer to a VARTYPE that indicates the property
    ///               type. If the property is multi-valued, the value pointed to is a <b>VT_VECTOR</b> mask (<b>VT_VECTOR</b> ORed
    ///               to the <b>VARTYPE</b>. The following are the possible variant types.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method always returns <b>S_OK</b>.
    ///    
    HRESULT GetPropertyType(ushort* pvartype);
    ///Gets the display name of the property as it is shown in any UI.
    ///Params:
    ///    ppszName = Type: <b>LPWSTR*</b> Contains the address of a pointer to the property's name as a null-terminated Unicode
    ///               string.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Display name is obtained. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The <i>ppszDisplayName</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Memory allocation failed. </td> </tr> </table>
    ///    
    HRESULT GetDisplayName(ushort** ppszName);
    ///Gets the text used in edit controls hosted in various dialog boxes.
    ///Params:
    ///    ppszInvite = Type: <b>LPWSTR*</b> When this method returns, contains the address of a pointer to a null-terminated Unicode
    ///                 buffer that holds the invitation text.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetEditInvitation(ushort** ppszInvite);
    ///Gets a set of flags that describe the uses and capabilities of the property.
    ///Params:
    ///    mask = Type: <b>PROPDESC_TYPE_FLAGS</b> A mask that specifies which type flags to retrieve. A combination of values
    ///           found in the PROPDESC_TYPE_FLAGS constants. To retrieve all type flags, pass PDTF_MASK_ALL
    ///    ppdtFlags = Type: <b>PROPDESC_TYPE_FLAGS*</b> When this method returns, contains a pointer to a value that consists of
    ///                bitwise PROPDESC_TYPE_FLAGS values.
    ///Returns:
    ///    Type: <b>HRESULT</b> Always returns <b>S_OK</b>.
    ///    
    HRESULT GetTypeFlags(PROPDESC_TYPE_FLAGS mask, PROPDESC_TYPE_FLAGS* ppdtFlags);
    ///Gets the current set of flags governing the property's view.
    ///Params:
    ///    ppdvFlags = Type: <b>PROPDESC_VIEW_FLAGS*</b> When this method returns, contains a pointer to a value that includes one
    ///                or more of the following flags. See PROPDESC_VIEW_FLAGS for valid values.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetViewFlags(PROPDESC_VIEW_FLAGS* ppdvFlags);
    ///Gets the default column width of the property in a list view.
    ///Params:
    ///    pcxChars = Type: <b>DWORD*</b> A pointer to the column width value, in characters.
    ///Returns:
    ///    Type: <b>HRESULT</b> Always returns <b>S_OK</b>.
    ///    
    HRESULT GetDefaultColumnWidth(uint* pcxChars);
    ///Gets the current data type used to display the property.
    ///Params:
    ///    pdisplaytype = Type: <b>PROPDESC_DISPLAYTYPE*</b> Contains a pointer to a value that indicates the display type. One of the
    ///                   following values.
    ///Returns:
    ///    Type: <b>HRESULT</b> Always returns <b>S_OK</b>.
    ///    
    HRESULT GetDisplayType(PROPDESC_DISPLAYTYPE* pdisplaytype);
    ///Gets the column state flag, which describes how the property should be treated by interfaces or APIs that use
    ///this flag.
    ///Params:
    ///    pcsFlags = Type: <b>SHCOLSTATEF</b> When this method returns, contains a pointer to the column state flag. See
    ///               SHCOLSTATE for valid values.
    ///Returns:
    ///    Type: <b>HRESULT</b> Always returns <b>S_OK</b>.
    ///    
    HRESULT GetColumnState(uint* pcsFlags);
    ///Gets the grouping method to be used when a view is grouped by a property, and retrieves the grouping type.
    ///Params:
    ///    pgr = Type: <b>PROPDESC_GROUPING_RANGE*</b> Receives a pointer to a flag value that indicates the grouping type.
    ///          The possible values are:
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetGroupingRange(PROPDESC_GROUPING_RANGE* pgr);
    ///Gets the relative description type for a property description.
    ///Params:
    ///    prdt = Type: <b>PROPDESC_RELATIVEDESCRIPTION_TYPE*</b> When this method returns, contains a pointer to the relative
    ///           description type value. See PROPDESC_RELATIVEDESCRIPTION_TYPE for valid values.
    ///Returns:
    ///    Type: <b>HRESULT</b> Always returns <b>S_OK</b>.
    ///    
    HRESULT GetRelativeDescriptionType(PROPDESC_RELATIVEDESCRIPTION_TYPE* prdt);
    ///Compares two property values in the manner specified by the property description. Returns two display strings
    ///that describe how the two properties compare.
    ///Params:
    ///    propvar1 = Type: <b>REFPROPVARIANT</b> A reference to a PROPVARIANT structure that contains the type and value of the
    ///               first property.
    ///    propvar2 = Type: <b>REFPROPVARIANT</b> A reference to a PROPVARIANT structure that contains the type and value of the
    ///               second property.
    ///    ppszDesc1 = Type: <b>LPWSTR*</b> When this method returns, contains the address of a pointer to the description string
    ///                that compares the first property with the second property. The string is null-terminated.
    ///    ppszDesc2 = Type: <b>LPWSTR*</b> When this method returns, contains the address of a pointer to the description string
    ///                that compares the second property with the first property. The string is null-terminated.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetRelativeDescription(const(PROPVARIANT)* propvar1, const(PROPVARIANT)* propvar2, ushort** ppszDesc1, 
                                   ushort** ppszDesc2);
    ///Gets the current sort description flags for the property, which indicate the particular wordings of sort
    ///offerings.
    ///Params:
    ///    psd = Type: <b>PROPDESC_SORTDESCRIPTION*</b> When this method returns, contains a pointer to the value of one or
    ///          more of the following flags that indicate the sort types available to the user. Note that the strings shown
    ///          are English versions only. Localized strings are used for other locales.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSortDescription(PROPDESC_SORTDESCRIPTION* psd);
    ///Gets the localized display string that describes the current sort order.
    ///Params:
    ///    fDescending = Type: <b>BOOL*</b> <b>TRUE</b> if <i>ppszDescription</i> should reference the string "Z on top"; <b>FALSE</b>
    ///                  to reference the string "A on top".
    ///    ppszDescription = Type: <b>LPWSTR*</b> When this method returns, contains the address of a pointer to the sort description as a
    ///                      null-terminated Unicode string.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSortDescriptionLabel(BOOL fDescending, ushort** ppszDescription);
    ///Gets a value that describes how the property values are displayed when multiple items are selected in the UI.
    ///Params:
    ///    paggtype = Type: <b>PROPDESC_AGGREGATION_TYPE*</b> When this method returns, contains a pointer to a value that
    ///               indicates the aggregation type. See PROPDESC_AGGREGATION_TYPE.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetAggregationType(PROPDESC_AGGREGATION_TYPE* paggtype);
    ///Gets the condition type and default condition operation to use when displaying the property in the query builder
    ///UI. This influences the list of predicate conditions (for example, equals, less than, and contains) that are
    ///shown for this property.
    ///Params:
    ///    pcontype = Type: <b>PROPDESC_CONDITION_TYPE*</b> A pointer to a value that indicates the condition type.
    ///    popDefault = Type: <b>CONDITION_OPERATION*</b> When this method returns, contains a pointer to a value that indicates the
    ///                 default condition operation.
    ///Returns:
    ///    Type: <b>HRESULT</b> Always returns <b>S_OK</b>.
    ///    
    HRESULT GetConditionType(PROPDESC_CONDITION_TYPE* pcontype, CONDITION_OPERATION* popDefault);
    ///Gets an instance of an IPropertyEnumTypeList, which can be used to enumerate the possible values for a property.
    ///Params:
    ///    riid = Type: <b>REFIID</b> A reference to the IID of the interface to retrieve through ppv, typically
    ///           IID_IShellItem.
    ///    ppv = Type: <b>void**</b> When this method returns successfully, contains the interface pointer requested in riid.
    ///          This is typically [IPropertyEnumTypeList](nn-propsys-ipropertyenumtypelist.md).
    HRESULT GetEnumTypeList(const(GUID)* riid, void** ppv);
    ///Coerces the value to the canonical value, according to the property description.
    ///Params:
    ///    ppropvar = Type: <b>PROPVARIANT*</b> On entry, contains a pointer to a PROPVARIANT structure that contains the original
    ///               value. When this method returns, contains the canonical value.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the failure code is not INPLACE_S_TRUNCATED or E_INVALIDARG, then coercion from the
    ///    value's type to the property description's type was not possible, and the PROPVARIANT structure has been
    ///    cleared. Possible results include the following: <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The function succeeded. The
    ///    property value specified by <i>ppropvar</i> is now in a canonical form. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>INPLACE_S_TRUNCATED</b></dt> </dl> </td> <td width="60%"> The property value specified by
    ///    <i>ppropvar</i> is now in a truncated, canonical form. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>ppropvar</i> parameter is invalid. The
    ///    PROPVARIANT structure has been cleared. </td> </tr> </table>
    ///    
    HRESULT CoerceToCanonicalValue(PROPVARIANT* ppropvar);
    ///Gets a formatted, Unicode string representation of a property value.
    ///Params:
    ///    propvar = Type: <b>REFPROPVARIANT</b> A reference to a PROPVARIANT structure that contains the type and value of the
    ///              property.
    ///    pdfFlags = Type: <b>PROPDESC_FORMAT_FLAGS</b> One or more of the PROPDESC_FORMAT_FLAGS flags, which are either bitwise
    ///               or multiple values, that indicate the property string format.
    ///    ppszDisplay = Type: <b>LPWSTR*</b> The address of a pointer to a null-terminated Unicode string that contains the display
    ///                  text.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    string was copied and <b>null</b>-terminated without truncation. This string may be returned empty due to an
    ///    empty input string or from a non-empty value that was formatted as an empty string. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The empty string resulted from a
    ///    VT_EMPTY. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    The <i>pszText</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The copy operation failed due to
    ///    insufficient space. The destination buffer is modified to contain a truncated version of the ideal result and
    ///    is <b>null</b>-terminated. </td> </tr> </table>
    ///    
    HRESULT FormatForDisplay(const(PROPVARIANT)* propvar, PROPDESC_FORMAT_FLAGS pdfFlags, ushort** ppszDisplay);
    ///Gets a value that indicates whether a property is canonical according to the definition of the property
    ///description.
    ///Params:
    ///    propvar = Type: <b>REFPROPVARIANT</b> A reference to a PROPVARIANT structure that contains the type and value of the
    ///              property.
    HRESULT IsValueCanonical(const(PROPVARIANT)* propvar);
}

///Exposes methods that enumerate and retrieve individual property description details.
@GUID("57D2EDED-5062-400E-B107-5DAE79FE57A6")
interface IPropertyDescription2 : IPropertyDescription
{
    ///Gets the image reference associated with a property value.
    ///Params:
    ///    propvar = Type: <b>REFPROPVARIANT</b> The PROPVARIANT for which to get an image.
    ///    ppszImageRes = Type: <b>LPWSTR*</b> A pointer to a buffer that receives, when this method returns successfully, a string of
    ///                   the form &lt;dll name&gt;,-&lt;resid&gt; that is suitable to be passed to PathParseIconLocation.
    HRESULT GetImageReferenceForValue(const(PROPVARIANT)* propvar, ushort** ppszImageRes);
}

///Exposes methods to get the "sort by" columns properties for an item. This interface is used by UI objects that want
///to retrieve the primary or secondary sort columns for a given property.
@GUID("F67104FC-2AF9-46FD-B32D-243C1404F3D1")
interface IPropertyDescriptionAliasInfo : IPropertyDescription
{
    ///Gets the address of a pointer to the IPropertyDescription interface containing the primary sort column.
    ///Params:
    ///    riid = Type: <b>REFIID</b> A reference to the identifier of the requested IPropertyDescription interface.
    ///    ppv = Type: <b>void**</b> When this method returns successfully, contains the address of a pointer to the
    ///          IPropertyDescription interface for the calling object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSortByAlias(const(GUID)* riid, void** ppv);
    ///Gets the address of a pointer to the IPropertyDescriptionList interface, which contains additional sort column
    ///values.
    ///Params:
    ///    riid = Type: <b>REFIID</b> A reference to the identifier of the requested IPropertyDescriptionList interface.
    ///    ppv = Type: <b>void**</b> When this method returns successfully, contains the address of a pointer to an
    ///          IPropertyDescriptionList interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetAdditionalSortByAliases(const(GUID)* riid, void** ppv);
}

///Exposes search-related information for a property. The information provided by this interface comes from the
///propertyDescription schema, searchInfo element for a given property. This information is used by the Windows Search
///Indexer. Most calling applications will not need to call this interface.
@GUID("078F91BD-29A2-440F-924E-46A291524520")
interface IPropertyDescriptionSearchInfo : IPropertyDescription
{
    ///Gets the PROPDESC_SEARCHINFO_FLAGS associated with the property.
    ///Params:
    ///    ppdsiFlags = Type: <b>PROPDESC_SEARCHINFO_FLAGS*</b> When this method returns successfully, contains a pointer to the
    ///                 PROPDESC_SEARCHINFO_FLAGS associated with the property.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSearchInfoFlags(PROPDESC_SEARCHINFO_FLAGS* ppdsiFlags);
    ///Determines the how the current property is indexed.
    ///Params:
    ///    ppdciType = Type: <b>PROPDESC_COLUMNINDEX_TYPE*</b> When this method returns successfully, contains a pointer to a
    ///                PROPDESC_COLUMNINDEX_TYPE constant. This constant describes whether the property is indexed and if so, if it
    ///                is indexed in memory or on disk.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetColumnIndexType(PROPDESC_COLUMNINDEX_TYPE* ppdciType);
    ///Returns a pointer to a string containing the canonical name of the item.
    ///Params:
    ///    ppszProjection = Type: <b>LPWSTR*</b> When this method returns successfully, contains a pointer to a string containing the
    ///                     canonical name of the item.
    HRESULT GetProjectionString(ushort** ppszProjection);
    ///Gets the maximum size value from the property schema's searchInfo element.
    ///Params:
    ///    pcbMaxSize = Type: <b>UINT*</b> Pointer to a value that, when this method returns successfully, receives the value of the
    ///                 maxSize attribute of the searchInfo element. The default is: <ul> <li><b>Windows Vista</b>: 128 bytes</li>
    ///                 <li><b>Windows 7 and later</b>: 512 bytes</li> </ul>
    HRESULT GetMaxSize(uint* pcbMaxSize);
}

///Provides a method that retrives an IPropertyDescription interface.
@GUID("507393F4-2A3D-4A60-B59E-D9C75716C2DD")
interface IPropertyDescriptionRelatedPropertyInfo : IPropertyDescription
{
    ///Retrieves an IPropertyDescription object that represents the related property.
    ///Params:
    ///    pszRelationshipName = Type: <b>LPCWSTR</b> A pointer to a string that contains the relationship of the property to get.
    ///    riid = Type: <b>REFIID</b> A reference to the IID of the interface to retrieve through the <i>ppv</i> parameter,
    ///           typically IID_IPropertyDescription.
    ///    ppv = Type: <b>void**</b> Receives the interface pointer requested in the parameter. This is typically
    ///          IPropertyDescription.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetRelatedProperty(const(wchar)* pszRelationshipName, const(GUID)* riid, void** ppv);
}

///Exposes methods that get property descriptions, register and unregister property schemas, enumerate property
///descriptions, and format property values in a type-strict way.
@GUID("CA724E8A-C3E6-442B-88A4-6FB0DB8035A3")
interface IPropertySystem : IUnknown
{
    ///Gets an instance of the subsystem object that implements IPropertyDescription, to obtain the property description
    ///for a given PROPERTYKEY.
    ///Params:
    ///    propkey = Type: <b>REFPROPERTYKEY</b> A reference to the desired property key. See PROPERTYKEY.
    ///    riid = Type: <b>REFIID</b> A reference to the desired IID.
    ///    ppv = Type: <b>void**</b> The address of an IPropertyDescription interface pointer.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Indicates the interface is obtained. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
    ///    </dl> </td> <td width="60%"> Indicates that <i>ppv</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TYPE_E_ELEMENTNOTFOUND</b></dt> </dl> </td> <td width="60%"> Indicates that the PROPERTYKEY does not
    ///    exist in the schema subsystem cache. </td> </tr> </table>
    ///    
    HRESULT GetPropertyDescription(const(PROPERTYKEY)* propkey, const(GUID)* riid, void** ppv);
    ///Gets an instance of the subsystem object that implements IPropertyDescription, to obtain the property description
    ///for a given canonical name.
    ///Params:
    ///    pszCanonicalName = Type: <b>LPCWSTR</b> A pointer to a string that identifies the property.
    ///    riid = Type: <b>REFIID</b> A reference to the desired IID.
    ///    ppv = Type: <b>void**</b> The address of an IPropertyDescription interface pointer.
    ///Returns:
    ///    Type: <b>PSSTDAPI</b> Returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Indicates that the interface is obtained. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
    ///    </dl> </td> <td width="60%"> Indicates <i>pszCanonicalName</i>is <b>NULL</b>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>TYPE_E_ELEMENTNOTFOUND</b></dt> </dl> </td> <td width="60%"> Indicates that the
    ///    canonical name does not exist in the schema subsystem cache. </td> </tr> </table>
    ///    
    HRESULT GetPropertyDescriptionByName(const(wchar)* pszCanonicalName, const(GUID)* riid, void** ppv);
    ///Gets an instance of the subsystem object that implements IPropertyDescriptionList, to obtain an ordered
    ///collection of property descriptions, based on the provided string.
    ///Params:
    ///    pszPropList = Type: <b>LPCWSTR</b> A pointer to a string that identifies the property list.
    ///    riid = Type: <b>REFIID</b> A reference to the desired IID.
    ///    ppv = Type: <b>void**</b> The address of an IPropertyDescriptionList interface pointer.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Indicates interface is obtained. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> Indicates <i>ppv</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetPropertyDescriptionListFromString(const(wchar)* pszPropList, const(GUID)* riid, void** ppv);
    ///Gets an instance of the subsystem object that implements IPropertyDescriptionList, to obtain either the entire or
    ///a partial list of property descriptions in the system.
    ///Params:
    ///    filterOn = Type: <b>PROPDESC_ENUMFILTER</b> The list to return. See PROPDESC_ENUMFILTER. Valid values for this method
    ///               are 0 through 4.
    ///    riid = Type: <b>REFIID</b> A reference to the desired IID.
    ///    ppv = Type: <b>void**</b> The address of an IPropertyDescriptionList interface pointer.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Indicates interface is obtained. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> Indicates <i>ppv</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT EnumeratePropertyDescriptions(PROPDESC_ENUMFILTER filterOn, const(GUID)* riid, void** ppv);
    ///Gets a formatted, Unicode string representation of a property value.
    ///Params:
    ///    key = Type: <b>REFPROPERTYKEY</b> A reference to the requested property key.
    ///    propvar = Type: <b>REFPROPVARIANT</b> A reference to a PROPVARIANT structure containing the type and value of the
    ///              property.
    ///    pdff = Type: <b>PROPDESC_FORMAT_FLAGS</b> The format of the property string. See PROPDESC_FORMAT_FLAGS for possible
    ///           values.
    ///    pszText = Type: <b>LPWSTR</b> Receives the formatted value as a null-terminated, Unicode string. The calling
    ///              application must allocate memory for the buffer.
    ///    cchText = Type: <b>DWORD</b> The length of the buffer at <i>pszText</i> in <b>WCHAR</b><b>s</b>, including the
    ///              terminating <b>NULL</b>. The maximum size is 0x8000 (32K).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Formatted string is created. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td
    ///    width="60%"> Formatted string is not created. S_FALSE indicates that the empty string resulted from a
    ///    VT_EMPTY. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Memory allocation failed. </td> </tr> </table>
    ///    
    HRESULT FormatForDisplay(const(PROPERTYKEY)* key, const(PROPVARIANT)* propvar, PROPDESC_FORMAT_FLAGS pdff, 
                             const(wchar)* pszText, uint cchText);
    ///Gets a string representation of a property value to an allocated memory buffer.
    ///Params:
    ///    key = Type: <b>REFPROPERTYKEY</b> A reference to the desired PROPERTYKEY.
    ///    propvar = Type: <b>REFPROPVARIANT</b> A reference to a PROPVARIANT structure that contains the type and value of the
    ///              property.
    ///    pdff = Type: <b>PROPDESC_FORMAT_FLAGS</b> The format of the property string. See PROPDESC_FORMAT_FLAGS.
    ///    ppszDisplay = Type: <b>LPWSTR*</b> When this method returns, contains a pointer to the formatted value as a
    ///                  null-terminated, Unicode string.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Formatted string is created. This string may be returned empty due to an empty input string or from a
    ///    non-empty value that was formatted as an empty string. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> Formatted string is not created. Indicates that the
    ///    empty string resulted from a <b>VT_EMPTY</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Indicates allocation failed. </td> </tr> </table>
    ///    
    HRESULT FormatForDisplayAlloc(const(PROPERTYKEY)* key, const(PROPVARIANT)* propvar, PROPDESC_FORMAT_FLAGS pdff, 
                                  ushort** ppszDisplay);
    ///Informs the schema subsystem of the addition of a property description schema file.
    ///Params:
    ///    pszPath = Type: <b>LPCWSTR</b> Pointer to the file path for the .propdesc file on the local machine.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Indicates schema is registered. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl>
    ///    </td> <td width="60%"> Indicates calling context does not have proper privileges. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>INPLACE_S_TRUNCATED</b></dt> </dl> </td> <td width="60%"> Indicates one or more of
    ///    the property descriptions in the schema was not registered. </td> </tr> </table>
    ///    
    HRESULT RegisterPropertySchema(const(wchar)* pszPath);
    ///Informs the schema subsystem of the removal of a property description schema (.propdesc) file, using a file path
    ///to the .propdesc file on the local machine.
    ///Params:
    ///    pszPath = Type: <b>LPCWSTR</b> Pointer to the file path for the .propdesc file on the local machine.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Indicates schema is unregistered. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl>
    ///    </td> <td width="60%"> Indicates calling context does not have proper privileges. </td> </tr> </table>
    ///    
    HRESULT UnregisterPropertySchema(const(wchar)* pszPath);
    ///Not supported.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Indicates schema files reloaded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl>
    ///    </td> <td width="60%"> Indicates calling context does not have proper privileges. </td> </tr> </table>
    ///    
    HRESULT RefreshPropertySchema();
}

///Exposes methods that extract information from a collection of property descriptions presented as a list.
@GUID("1F9FC1D0-C39B-4B26-817F-011967D3440E")
interface IPropertyDescriptionList : IUnknown
{
    ///Gets the number of properties included in the property list.
    ///Params:
    ///    pcElem = Type: <b>UINT*</b> When this method returns, contains a pointer to the count of properties.
    HRESULT GetCount(uint* pcElem);
    ///Gets the property description at the specified index in a property description list.
    ///Params:
    ///    iElem = Type: <b>UINT</b> The number of the property in the list string.
    ///    riid = Type: <b>REFIID</b> A reference to the IID of the requested property description interface, typically
    ///           IID_IPropertyDescription.
    ///    ppv = Type: <b>void**</b> When this method returns, contains the interface pointer requested in <i>riid</i>.
    ///          Typically, this is IPropertyDescription.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetAt(uint iElem, const(GUID)* riid, void** ppv);
}

///Exposes methods to get an IPropertyStore object.
@GUID("BC110B6D-57E8-4148-A9C6-91015AB2F3A5")
interface IPropertyStoreFactory : IUnknown
{
    ///Gets an IPropertyStore object that corresponds to the supplied flags.
    ///Params:
    ///    flags = Type: <b>GETPROPERTYSTOREFLAGS</b> GETPROPERTYSTOREFLAGS values that modify the store that is returned.
    ///    pUnkFactory = Type: <b>IUnknown*</b> Optional. A pointer to the IUnknown of an object that implements ICreateObject. If
    ///                  <i>pUnkFactory</i> is provided, this method can create the handler instance using <b>ICreateObject</b> rather
    ///                  than CoCreateInstance, if implemented. The reason to provide <i>pUnkFactory</i> is usually to create the
    ///                  handler in a different process. However, for most users, passing <b>NULL</b> in this parameter is sufficient.
    ///    riid = Type: <b>REFIID</b> A reference to IID of the object to create.
    ///    ppv = Type: <b>void**</b> When this method returns, contains the address of an IPropertyStore interface pointer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPropertyStore(GETPROPERTYSTOREFLAGS flags, IUnknown pUnkFactory, const(GUID)* riid, void** ppv);
    ///Gets an IPropertyStore object, given a set of property keys. This provides an alternative, possibly faster,
    ///method of getting an <b>IPropertyStore</b> object compared to calling IPropertyStoreFactory::GetPropertyStore.
    ///Params:
    ///    rgKeys = Type: <b>const PROPERTYKEY*</b> A pointer to an array of PROPERTYKEY structures.
    ///    cKeys = Type: <b>UINT</b> The number of PROPERTYKEY structures in the array pointed to by <i>rgKeys</i>.
    ///    flags = Type: <b>GETPROPERTYSTOREFLAGS</b> GETPROPERTYSTOREFLAGS values that modify the store that is returned.
    ///    riid = Type: <b>REFIID</b> A reference to IID of the object to create.
    ///    ppv = Type: <b>void**</b> When this method returns, contains the address of an IPropertyStore interface pointer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPropertyStoreForKeys(const(PROPERTYKEY)* rgKeys, uint cKeys, GETPROPERTYSTOREFLAGS flags, 
                                    const(GUID)* riid, void** ppv);
}

@GUID("FA955FD9-38BE-4879-A6CE-824CF52D609F")
interface IPropertySystemChangeNotify : IUnknown
{
    HRESULT SchemaRefreshed();
}

///Developers should use IPropertyDescription instead.
@GUID("757A7D9F-919A-4118-99D7-DBB208C8CC66")
interface IPropertyUI : IUnknown
{
    ///Developers should use IPropertyDescription instead. Reads the characters of the specified property name and
    ///identifies the FMTID and PROPID of the property.
    ///Params:
    ///    pszName = Type: <b>LPWSTR</b> A string specifying the property name to parse.
    ///    pfmtid = Type: <b>FMTID*</b> The FMTID of the parsed property.
    ///    ppid = Type: <b>PROPID*</b> The PROPID of the parsed property name.
    ///    pchEaten = Type: <b>ULONG*</b> The number of characters that were consumed in parsing <i>pszName</i>.
    HRESULT ParsePropertyName(const(wchar)* pszName, GUID* pfmtid, uint* ppid, uint* pchEaten);
    HRESULT GetCannonicalName(const(GUID)* fmtid, uint pid, const(wchar)* pwszText, uint cchText);
    ///Developers should use IPropertyDescription instead. Gets a string specifying the name of the property suitable
    ///for display to users.
    ///Params:
    ///    fmtid = Type: <b>REFFMTID</b> The FMTID of the property.
    ///    pid = Type: <b>PROPID</b> The PROPID of the property.
    ///    flags = Type: <b>PROPERTYUI_NAME_FLAGS</b> One of the following PROPERTYUI_NAME_FLAGS values:
    ///    pwszText = Type: <b>LPWSTR</b> A string specifying the property.
    ///    cchText = Type: <b>DWORD</b> The length of the property display name.
    HRESULT GetDisplayName(const(GUID)* fmtid, uint pid, uint flags, const(wchar)* pwszText, uint cchText);
    ///Developers should use IPropertyDescription instead. Gets the property description of a specified property.
    ///Params:
    ///    fmtid = Type: <b>REFFMTID</b> The FMTID of the property.
    ///    pid = Type: <b>PROPID</b> The PROPID of the property.
    ///    pwszText = Type: <b>LPWSTR</b> The description of the property.
    ///    cchText = Type: <b>DWORD</b> The length of the property description.
    HRESULT GetPropertyDescription(const(GUID)* fmtid, uint pid, const(wchar)* pwszText, uint cchText);
    ///Developers should use IPropertyDescription instead. Gets the width of the property description.
    ///Params:
    ///    fmtid = Type: <b>REFFMTID</b> The FMTID of the property.
    ///    pid = Type: <b>PROPID</b> The PROPID of the property.
    ///    pcxChars = Type: <b>ULONG*</b> The width of the property description.
    HRESULT GetDefaultWidth(const(GUID)* fmtid, uint pid, uint* pcxChars);
    ///Developers should use IPropertyDescription instead. Gets property feature flags for a specified property.
    ///Params:
    ///    fmtid = Type: <b>REFFMTID</b> The FMTID of the property.
    ///    pid = Type: <b>PROPID</b> The PROPID of the property.
    ///    pflags = Type: <b>PROPERTYUI_FLAGS*</b> The PROPERTYUI_FLAGS for the property.
    HRESULT GetFlags(const(GUID)* fmtid, uint pid, uint* pflags);
    ///Developers should use IPropertyDescription instead. Gets a formatted, Unicode string representation of a property
    ///value.
    ///Params:
    ///    fmtid = Type: <b>REFFMTID</b>
    ///    pid = Type: <b>PROPID</b>
    ///    ppropvar = Type: <b>PROPVARIANT*</b> A PROPVARIANT structure that contains the type and value of the property.
    ///    puiff = Type: <b>PROPERTYUI_FORMAT_FLAGS</b> The format for the returned property value.
    ///    pwszText = Type: <b>LPWSTR</b> The property value, formatted for display.
    ///    cchText = Type: <b>DWORD</b>
    HRESULT FormatForDisplay(const(GUID)* fmtid, uint pid, const(PROPVARIANT)* ppropvar, uint puiff, 
                             const(wchar)* pwszText, uint cchText);
    ///Developers should use IPropertyDescription instead. Gets
    ///Params:
    ///    fmtid = Type: <b>REFFMTID</b> The FMTID of the property.
    ///    pid = Type: <b>PROPID</b> The PROPID of the property.
    ///    pwszHelpFile = Type: <b>LPWSTR</b> The fully qualified path of the Help file.
    ///    cch = Type: <b>DWORD</b>
    ///    puHelpID = Type: <b>UINT*</b> The Help context ID for the property.
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
