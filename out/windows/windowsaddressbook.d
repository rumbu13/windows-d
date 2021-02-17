// Written in the D programming language.

module windows.windowsaddressbook;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : BOOL, CY, LARGE_INTEGER;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


// Enums


///Do not use. The <b>Gender</b> enumeration specifies the possible values for the PR_GENDER property.
enum Gender : int
{
    ///No gender is specified.
    genderUnspecified = 0x00000000,
    ///Specifies a gender of female.
    genderFemale      = 0x00000001,
    genderMale        = 0x00000002,
}

// Callbacks

alias ALLOCATEBUFFER = int function(uint cbSize, void** lppBuffer);
alias ALLOCATEMORE = int function(uint cbSize, void* lpObject, void** lppBuffer);
alias FREEBUFFER = uint function(void* lpBuffer);
alias LPALLOCATEBUFFER = int function();
alias LPALLOCATEMORE = int function();
alias LPFREEBUFFER = uint function();
alias NOTIFCALLBACK = int function(void* lpvContext, uint cNotification, NOTIFICATION* lpNotifications);
alias LPNOTIFCALLBACK = int function();
alias ACCELERATEABSDI = BOOL function(size_t ulUIParam, void* lpvmsg);
alias LPFNABSDI = BOOL function();
alias DISMISSMODELESS = void function(size_t ulUIParam, void* lpvContext);
alias LPFNDISMISS = void function();
alias LPFNBUTTON = int function(size_t ulUIParam, void* lpvContext, uint cbEntryID, ENTRYID* lpSelection, 
                                uint ulFlags);
alias IWABOBJECT_QueryInterface_METHOD = HRESULT function(const(GUID)* riid, void** ppvObj);
alias IWABOBJECT_AddRef_METHOD = uint function();
alias IWABOBJECT_Release_METHOD = uint function();
alias IWABOBJECT_GetLastError_METHOD = HRESULT function(HRESULT hResult, uint ulFlags, MAPIERROR** lppMAPIError);
alias IWABOBJECT_AllocateBuffer_METHOD = HRESULT function(uint cbSize, void** lppBuffer);
alias IWABOBJECT_AllocateMore_METHOD = HRESULT function(uint cbSize, void* lpObject, void** lppBuffer);
alias IWABOBJECT_FreeBuffer_METHOD = HRESULT function(void* lpBuffer);
alias IWABOBJECT_Backup_METHOD = HRESULT function(const(char)* lpFileName);
alias IWABOBJECT_Import_METHOD = HRESULT function(const(char)* lpWIP);
alias IWABOBJECT_Find_METHOD = HRESULT function(IAddrBook lpIAB, HWND hWnd);
alias IWABOBJECT_VCardDisplay_METHOD = HRESULT function(IAddrBook lpIAB, HWND hWnd, const(char)* lpszFileName);
alias IWABOBJECT_LDAPUrl_METHOD = HRESULT function(IAddrBook lpIAB, HWND hWnd, uint ulFlags, const(char)* lpszURL, 
                                                   IMailUser* lppMailUser);
alias IWABOBJECT_VCardCreate_METHOD = HRESULT function(IAddrBook lpIAB, uint ulFlags, const(char)* lpszVCard, 
                                                       IMailUser lpMailUser);
alias IWABOBJECT_VCardRetrieve_METHOD = HRESULT function(IAddrBook lpIAB, uint ulFlags, const(char)* lpszVCard, 
                                                         IMailUser* lppMailUser);
alias IWABOBJECT_GetMe_METHOD = HRESULT function(IAddrBook lpIAB, uint ulFlags, uint* lpdwAction, SBinary* lpsbEID, 
                                                 HWND hwnd);
alias IWABOBJECT_SetMe_METHOD = HRESULT function(IAddrBook lpIAB, uint ulFlags, SBinary sbEID, HWND hwnd);
alias WABOPEN = HRESULT function(IAddrBook* lppAdrBook, IWABObject* lppWABObject, WAB_PARAM* lpWP, uint Reserved2);
alias LPWABOPEN = HRESULT function();
alias WABOPENEX = HRESULT function(IAddrBook* lppAdrBook, IWABObject* lppWABObject, WAB_PARAM* lpWP, uint Reserved, 
                                   ALLOCATEBUFFER* fnAllocateBuffer, ALLOCATEMORE* fnAllocateMore, 
                                   FREEBUFFER* fnFreeBuffer);
alias LPWABOPENEX = HRESULT function();

// Structs


///Do not use. Contains the entry identifier information for a MAPI object.
struct ENTRYID
{
    ///Type: <b>BYTE[4]</b> Array of variables of type <b>BYTE</b> that specifies the bitmask of flags that provide
    ///information describing the object.
    ubyte[4] abFlags;
    ubyte[1] ab;
}

struct MAPIUID
{
    ubyte[16] ab;
}

///Do not use. Contains an array of property tags.
struct SPropTagArray
{
    ///Type: <b>ULONG</b> Variable of type <b>ULONG</b> that specifies the number of property tags in the array
    ///indicated by the <b>aulPropTag</b> member.
    uint    cValues;
    uint[1] aulPropTag;
}

struct SBinary
{
    uint   cb;
    ubyte* lpb;
}

struct SShortArray
{
    uint   cValues;
    short* lpi;
}

struct SGuidArray
{
    uint  cValues;
    GUID* lpguid;
}

struct SRealArray
{
    uint   cValues;
    float* lpflt;
}

struct SLongArray
{
    uint cValues;
    int* lpl;
}

struct SLargeIntegerArray
{
    uint           cValues;
    LARGE_INTEGER* lpli;
}

struct SDateTimeArray
{
    uint      cValues;
    FILETIME* lpft;
}

struct SAppTimeArray
{
    uint    cValues;
    double* lpat;
}

struct SCurrencyArray
{
    uint cValues;
    CY*  lpcur;
}

///Do not use. An array of entry identifiers representing MAPI objects. Uses the same implementation as SBinaryArray.
struct SBinaryArray
{
    ///Type: <b>ULONG</b> Variable of type <b>ULONG</b> that specifies the number of entry identifiers.
    uint     cValues;
    SBinary* lpbin;
}

struct SDoubleArray
{
    uint    cValues;
    double* lpdbl;
}

struct SWStringArray
{
    uint     cValues;
    ushort** lppszW;
}

struct SLPSTRArray
{
    uint   cValues;
    byte** lppszA;
}

union _PV
{
    short              i;
    int                l;
    uint               ul;
    float              flt;
    double             dbl;
    ushort             b;
    CY                 cur;
    double             at;
    FILETIME           ft;
    const(char)*       lpszA;
    SBinary            bin;
    const(wchar)*      lpszW;
    GUID*              lpguid;
    LARGE_INTEGER      li;
    SShortArray        MVi;
    SLongArray         MVl;
    SRealArray         MVflt;
    SDoubleArray       MVdbl;
    SCurrencyArray     MVcur;
    SAppTimeArray      MVat;
    SDateTimeArray     MVft;
    SBinaryArray       MVbin;
    SLPSTRArray        MVszA;
    SWStringArray      MVszW;
    SGuidArray         MVguid;
    SLargeIntegerArray MVli;
    int                err;
    int                x;
}

///Do not use. Contains the property tag values.
struct SPropValue
{
    ///Type: <b>ULONG</b> Variable of type <b>ULONG</b> that specifies the property tag for the property. Property tags
    ///are 32-bit unsigned integers consisting of the property's unique identifier in the high-order 16 bits and the
    ///property's type in the low-order 16 bits.
    uint ulPropTag;
    ///Type: <b>ULONG</b>
    uint dwAlignPad;
    ///Union of data values, with the specific value dictated by the property type. The following text provides a list
    ///for each property type of the member of the union to be used and its associated data type.
    _PV  Value;
}

///Do not use. Describes an error relating to an operation involving a property.
struct SPropProblem
{
    ///Type: <b>ULONG</b> Variable of type <b>ULONG</b> that specifies the index value in an array of property tags.
    uint ulIndex;
    ///Type: <b>ULONG</b> Variable of type <b>ULONG</b> that specifies the property tag for the property with the error.
    uint ulPropTag;
    int  scode;
}

///Do not use. Contains an array of one or more SPropProblem structures.
struct SPropProblemArray
{
    ///Type: <b>ULONG</b> Variable of type <b>ULONG</b> that specifies the count of SPropProblem structures in the array
    ///indicated by the <b>aProblem</b> member.
    uint            cProblem;
    SPropProblem[1] aProblem;
}

struct FLATENTRY
{
    uint     cb;
    ubyte[1] abEntry;
}

struct FLATENTRYLIST
{
    uint     cEntries;
    uint     cbEntries;
    ubyte[1] abEntries;
}

struct MTSID
{
    uint     cb;
    ubyte[1] ab;
}

struct FLATMTSIDLIST
{
    uint     cMTSIDs;
    uint     cbMTSIDs;
    ubyte[1] abMTSIDs;
}

///Do not use. Describes zero or more properties belonging to one or more recipients.
struct ADRENTRY
{
    ///Type: <b>ULONG</b>
    uint        ulReserved1;
    ///Type: <b>ULONG</b> Variable of type <b>ULONG</b> that specifies the count of properties in the property value
    ///array to which the <b>rgPropVals</b> member points. The <b>cValues</b> member can be zero.
    uint        cValues;
    SPropValue* rgPropVals;
}

///Do not use. Describes zero or more properties belonging to one or more recipients.
struct ADRLIST
{
    ///Type: <b>ULONG</b> Variable of type <b>ULONG</b> that specifies the entry count in the array specified by the
    ///<b>aEntries</b> member.
    uint        cEntries;
    ADRENTRY[1] aEntries;
}

///Do not use. Describes a row from a table containing selected properties for a specific object.
struct SRow
{
    ///Type: <b>ULONG</b> Variable of type <b>ULONG</b> that specifies the number of padding bytes for aligning properly
    ///the property values to which the <b>lpProps</b> member points.
    uint        ulAdrEntryPad;
    ///Type: <b>ULONG</b> Variable of type <b>ULONG</b> that specifies the count of property values to which
    ///<b>lpProps</b> points.
    uint        cValues;
    SPropValue* lpProps;
}

///Do not use. Contains an array of SRow structures. Each <b>SRow</b> structure describes a row from a table.
struct SRowSet
{
    ///Type: <b>ULONG</b> Variable of type <b>ULONG</b> that specifies the number of SRow structures in the <b>aRow</b>
    ///member.
    uint    cRows;
    SRow[1] aRow;
}

struct MAPIERROR
{
    uint  ulVersion;
    byte* lpszError;
    byte* lpszComponent;
    uint  ulLowLevelError;
    uint  ulContext;
}

struct ERROR_NOTIFICATION
{
    uint       cbEntryID;
    ENTRYID*   lpEntryID;
    int        scode;
    uint       ulFlags;
    MAPIERROR* lpMAPIError;
}

struct NEWMAIL_NOTIFICATION
{
    uint     cbEntryID;
    ENTRYID* lpEntryID;
    uint     cbParentID;
    ENTRYID* lpParentID;
    uint     ulFlags;
    byte*    lpszMessageClass;
    uint     ulMessageFlags;
}

struct OBJECT_NOTIFICATION
{
    uint           cbEntryID;
    ENTRYID*       lpEntryID;
    uint           ulObjType;
    uint           cbParentID;
    ENTRYID*       lpParentID;
    uint           cbOldID;
    ENTRYID*       lpOldID;
    uint           cbOldParentID;
    ENTRYID*       lpOldParentID;
    SPropTagArray* lpPropTagArray;
}

struct TABLE_NOTIFICATION
{
    uint       ulTableEvent;
    HRESULT    hResult;
    SPropValue propIndex;
    SPropValue propPrior;
    SRow       row;
    uint       ulPad;
}

struct EXTENDED_NOTIFICATION
{
    uint   ulEvent;
    uint   cb;
    ubyte* pbEventParameters;
}

struct STATUS_OBJECT_NOTIFICATION
{
    uint        cbEntryID;
    ENTRYID*    lpEntryID;
    uint        cValues;
    SPropValue* lpPropVals;
}

struct NOTIFICATION
{
    uint ulEventType;
    uint ulAlignPad;
    union info
    {
        ERROR_NOTIFICATION   err;
        NEWMAIL_NOTIFICATION newmail;
        OBJECT_NOTIFICATION  obj;
        TABLE_NOTIFICATION   tab;
        EXTENDED_NOTIFICATION ext;
        STATUS_OBJECT_NOTIFICATION statobj;
    }
}

struct MAPINAMEID
{
    GUID* lpguid;
    uint  ulKind;
    union Kind
    {
        int           lID;
        const(wchar)* lpwstrName;
    }
}

///Do not use. Defines how to sort rows of a table, describing both the column to use as the sort key and the direction
///of the sort.
struct SSortOrder
{
    ///Type: <b>ULONG</b> Variable of type <b>ULONG</b> that specifies the property tag identifying either the sort key
    ///or, for a categorized sort, the category column.
    uint ulPropTag;
    ///Type: <b>ULONG</b> Variable of type <b>ULONG</b> that specifies the order in which the data is to be sorted. The
    ///possible values are as follows.
    uint ulOrder;
}

///Do not use. Defines a collection of keys for a table to be used for standard or categorized sorting.
struct SSortOrderSet
{
    ///Type: <b>ULONG</b> Variable of type <b>ULONG</b> that specifes the number of SSortOrder structures that are
    ///included in the <b>aSort</b> member.
    uint          cSorts;
    ///Type: <b>ULONG</b> Variable of type <b>ULONG</b> that specifes the number of columns that are designated as
    ///category columns. Possible values range from zero, which indicates a non-categorized or standard sort, to the
    ///number indicated by the <b>cSorts</b> member.
    uint          cCategories;
    ///Type: <b>ULONG</b> Variable of type <b>ULONG</b> that specifies the number of categories that start in an
    ///expanded state, where all the rows that apply to the category are visible in the table view. Possible values
    ///range from zero to the number indicated by <b>cCategories</b>.
    uint          cExpanded;
    SSortOrder[1] aSort;
}

struct SAndRestriction
{
    uint          cRes;
    SRestriction* lpRes;
}

struct SOrRestriction
{
    uint          cRes;
    SRestriction* lpRes;
}

struct SNotRestriction
{
    uint          ulReserved;
    SRestriction* lpRes;
}

struct SContentRestriction
{
    uint        ulFuzzyLevel;
    uint        ulPropTag;
    SPropValue* lpProp;
}

struct SBitMaskRestriction
{
    uint relBMR;
    uint ulPropTag;
    uint ulMask;
}

struct SPropertyRestriction
{
    uint        relop;
    uint        ulPropTag;
    SPropValue* lpProp;
}

struct SComparePropsRestriction
{
    uint relop;
    uint ulPropTag1;
    uint ulPropTag2;
}

struct SSizeRestriction
{
    uint relop;
    uint ulPropTag;
    uint cb;
}

struct SExistRestriction
{
    uint ulReserved1;
    uint ulPropTag;
    uint ulReserved2;
}

struct SSubRestriction
{
    uint          ulSubObject;
    SRestriction* lpRes;
}

struct SCommentRestriction
{
    uint          cValues;
    SRestriction* lpRes;
    SPropValue*   lpProp;
}

///Do not use. Describes a filter for limiting the view of a table to particular rows.
struct SRestriction
{
    ///Type: <b>ULONG</b> Variable of type <b>ULONG</b> that specifies the restriction type. The possible values are as
    ///follows.
    uint rt;
    union res
    {
        SComparePropsRestriction resCompareProps;
        SAndRestriction      resAnd;
        SOrRestriction       resOr;
        SNotRestriction      resNot;
        SContentRestriction  resContent;
        SPropertyRestriction resProperty;
        SBitMaskRestriction  resBitMask;
        SSizeRestriction     resSize;
        SExistRestriction    resExist;
        SSubRestriction      resSub;
        SCommentRestriction  resComment;
    }
}

struct _flaglist
{
    uint    cFlags;
    uint[1] ulFlag;
}

///Do not use. Describes the display and behavior of the common address dialog box.
struct ADRPARM
{
    ///Type: <b>ULONG</b> Variable of type <b>ULONG</b> that specifies the list of entries that can be added to the
    ///recipient wells.
    uint          cbABContEntryID;
    ///Type: <b>LPENTRYID</b> Pointer to a variable of type ENTRYID that specifies the container that will supply the
    ///list of one-off entries that can be added to the recipient wells of the address book's common dialog box. The
    ///address book container that <b>lpABContEntryID</b> points to determines what is listed in the edit box within the
    ///dialog box that holds possible recipient names. Usually, <b>lpABContEntryID</b> is <b>NULL</b>, indicating the
    ///use of a custom recipient provider.
    ENTRYID*      lpABContEntryID;
    ///Type: <b>ULONG</b> Value of type <b>ULONG</b> that specifies the bitmask of flags associated with various address
    ///dialog box options. The following flags can be set in the WAB.
    uint          ulFlags;
    ///Type: <b>LPVOID</b>
    void*         lpReserved;
    ///Type: <b>ULONG</b> Not supported. Must be set to 0.
    uint          ulHelpContext;
    ///Type: <b>LPTSTR</b> Not supported. Must be set to <b>NULL</b>.
    byte*         lpszHelpFileName;
    ///Type: <b>LPFNABSDI</b> Pointer to a WAB function based on the ACCELERATEABSDI prototype (see MAPI documentation),
    ///or <b>NULL</b>. This member applies only to the modeless version of the dialog box, as indicated by the
    ///<b>DIALOG_SDI</b> flag being set. Clients building an <b>ADRPARM</b> structure to pass to Address must always set
    ///the <b>lpfnABSDI</b> member to <b>NULL</b>. If the <b>DIALOG_SDI</b> flag is set, WAB then sets it to a valid
    ///function before returning. Clients call this function from within their message loop to ensure that accelerators
    ///in the address book dialog box work. When the dialog box is dismissed and WAB calls the function to which the
    ///<b>lpfnDismiss</b> member points, clients should unhook the ACCELERATEABSDI function from their message loop.
    LPFNABSDI     lpfnABSDI;
    ///Type: <b>LPFNDISMISS</b> Pointer to a function based on the DISMISSMODELESS (see MAPI documentation) prototype,
    ///or <b>NULL</b>. This member applies only to the modeless version of the dialog box, as indicated by the
    ///<b>DIALOG_SDI</b> flag being set. WAB calls the DISMISSMODELESS function when the user dismisses the modeless
    ///address dialog box, informing a client calling Address that the dialog box is no longer active.
    LPFNDISMISS   lpfnDismiss;
    ///Type: <b>LPVOID</b> Pointer to the context information to be passed to the DISMISSMODELESS function to which the
    ///<b>lpfnDismiss</b> member points. This member applies only to the modeless version of the dialog box, as
    ///indicated by the <b>DIALOG_SDI</b> flag being set.
    void*         lpvDismissContext;
    ///Type: <b>LPTSTR</b> Variable of type <b>LPTSTR</b> that specifies the text to be used as a caption for the
    ///address book dialog box.
    byte*         lpszCaption;
    ///Type: <b>LPTSTR</b> Variable of type <b>LPTSTR</b> that specifies the text to be used as a new-entry prompt for
    ///an edit box in an address book dialog box.
    byte*         lpszNewEntryTitle;
    ///Type: <b>LPTSTR</b> Variable of type <b>LPTSTR</b> that specifies the text to be used as a title for the set of
    ///recipient-name edit boxes that appears in the dialog box. This member is used only if the address book dialog box
    ///is modal.
    byte*         lpszDestWellsTitle;
    ///Type: <b>ULONG</b> Variable of type <b>ULONG</b> that specifies the number of recipient-name edit boxes (that is,
    ///destination fields) in the address book dialog box. A number from 0 through 3 is typical. If the
    ///<b>cDestFields</b> member is zero and the ADDRESS_ONE flag is not set in <b>ulFlags</b>, the address book will be
    ///open for browsing only.
    uint          cDestFields;
    ///Type: <b>ULONG</b> Variable of type <b>ULONG</b> that specifies the field in the address book dialog box that
    ///should have the initial focus when the dialog box appears. This value must be between 0 and the value of
    ///<b>cDestFields</b> minus 1.
    uint          nDestFieldFocus;
    ///Type: <b>LPTSTR*</b> Pointer to an array of variables of type <b>LPTSTR</b> that specify the text titles to be
    ///displayed in the recipient-name edit boxes of the address book dialog box. The size of the array is the value of
    ///<b>cDestFields</b>. If the <b>lppszDestTitles</b> member is <b>NULL</b>, the Address method chooses default
    ///titles.
    byte**        lppszDestTitles;
    ///Type: <b>ULONG*</b> Pointer to an array of variables of type <b>ULONG</b> that specify the recipient types—such
    ///as MAPI_TO, MAPI_CC, and MAPI_BCC—associated with each recipient-name edit box. The size of the array is the
    ///value of <b>cDestFields</b>. If the <b>lpulDestComps</b> member is <b>NULL</b>, the Address method chooses
    ///default recipient types.
    uint*         lpulDestComps;
    ///Type: <b>LPSRestriction</b> Not supported. Must be set to <b>NULL</b>.
    SRestriction* lpContRestriction;
    SRestriction* lpHierRestriction;
}

struct DTBLLABEL
{
    uint ulbLpszLabelName;
    uint ulFlags;
}

struct DTBLEDIT
{
    uint ulbLpszCharsAllowed;
    uint ulFlags;
    uint ulNumCharsAllowed;
    uint ulPropTag;
}

struct DTBLLBX
{
    uint ulFlags;
    uint ulPRSetProperty;
    uint ulPRTableName;
}

struct DTBLCOMBOBOX
{
    uint ulbLpszCharsAllowed;
    uint ulFlags;
    uint ulNumCharsAllowed;
    uint ulPRPropertyName;
    uint ulPRTableName;
}

struct DTBLDDLBX
{
    uint ulFlags;
    uint ulPRDisplayProperty;
    uint ulPRSetProperty;
    uint ulPRTableName;
}

struct DTBLCHECKBOX
{
    uint ulbLpszLabel;
    uint ulFlags;
    uint ulPRPropertyName;
}

struct DTBLGROUPBOX
{
    uint ulbLpszLabel;
    uint ulFlags;
}

struct DTBLBUTTON
{
    uint ulbLpszLabel;
    uint ulFlags;
    uint ulPRControl;
}

struct DTBLPAGE
{
    uint ulbLpszLabel;
    uint ulFlags;
    uint ulbLpszComponent;
    uint ulContext;
}

struct DTBLRADIOBUTTON
{
    uint ulbLpszLabel;
    uint ulFlags;
    uint ulcButtons;
    uint ulPropTag;
    int  lReturnValue;
}

struct DTBLMVLISTBOX
{
    uint ulFlags;
    uint ulMVPropTag;
}

struct DTBLMVDDLBX
{
    uint ulFlags;
    uint ulMVPropTag;
}

struct _WABACTIONITEM
{
}

///Do not use. Contains the input information to pass to WABOpen.
struct WAB_PARAM
{
    ///Type: <b>ULONG</b> Value of type <b>ULONG</b> that specifies the size of the <b>WAB_PARAM</b> structure in bytes.
    uint         cbSize;
    ///Type: <b>HWND</b> Value of type <b>HWND</b> that specifies the window handle of the calling client application.
    ///Can be <b>NULL</b>.
    HWND         hwnd;
    ///Type: <b>LPTSTR</b> Value of type <b>LPTSTR</b> that specifies the WAB file name to open. If this parameter is
    ///<b>NULL</b>, the default Address Book file is opened.
    const(char)* szFileName;
    ///Type: <b>ULONG</b> Value of type <b>ULONG</b> that specifies flags that control the behavior of WAB
    ///functionality. Available only on Internet Explorer 4.0 or later.
    uint         ulFlags;
    GUID         guidPSExt;
}

///Do not use. Structure passed to Import that gives information about importing .wab files.
struct WABIMPORTPARAM
{
    ///Type: <b>ULONG</b> Value of type <b>ULONG</b> that specifies the size of the structure in bytes.
    uint         cbSize;
    ///Type: <b>IAddrBook*</b> Pointer to an IAddrBook interface that specifies the address book object to import to.
    IAddrBook    lpAdrBook;
    HWND         hWnd;
    ///Type: <b>ULONG</b> Value of type <b>ULONG</b> that specifies flags affecting behavior.
    uint         ulFlags;
    ///Type: <b>LPSTR</b> Value of type <b>LPSTR</b> that specifies the filename to import, or <b>NULL</b> to cause a
    ///FileOpen dialog box to open.
    const(char)* lpszFileName;
}

///Do not use. Used by the Windows Address Book (WAB) to initialize user's IContextMenu Interface and IShellPropSheetExt
///Interface implementations.
struct WABEXTDISPLAY
{
    ///Type: <b>ULONG</b> Not used.
    uint       cbSize;
    ///Type: <b>LPWABOBJECT</b> Pointer to an IWABObject interface that specifies the object to use for calling the
    ///<b>IWABObject</b> memory allocation methods. These methods allocate any memory that you pass back to the WAB and
    ///that you expect the WAB to free or use. You can also use this pointer to call any of the other <b>IWABObject</b>
    ///methods.
    IWABObject lpWABObject;
    ///Type: <b>LPADRBOOK</b> Pointer to an IAddrBook interface that specifies the object to use for calling any of the
    ///standard WAB <b>IAddrBook</b> methods.
    IAddrBook  lpAdrBook;
    ///Type: <b>LPMAPIPROP</b> Pointer to an IMailUser : IMAPIProp object. This interface is relevant for both
    ///IShellPropSheetExt Interface and IContextMenu Interface implementations. For IShellPropSheetExt Interface
    ///implementations, <b>lpPropObj</b> contains the actual object being displayed. It can be either an IMailUser :
    ///IMAPIProp or IDistList : IMAPIContainer object. To determine which object <b>lpPropObj</b> is, query for its
    ///PR_OBJECT_TYPE property. You can retrieve properties from this object to populate your extension property sheets.
    ///For IContextMenu Interface implementations, <b>lpPropObj</b> contains a valid object; however, this object does
    ///not have any properties associated with it. You can call the AddRef on this object to ensure that the object and
    ///any other data of interest in this <b>WABEXTDISPLAY</b> structure survives as long as you need it. If you call
    ///AddRef, you must call Release on <b>lpPropObj</b> when you no longer need it. If your application uses named
    ///properties, and you want to get the named properties relevant to you from the WAB, you can call the
    ///GetIDsfromNames method on this <b>lpPropObj</b> object to retrieve any such named properties. If you want to
    ///access properties that are associated with messaging users, cast this object to an LPMAILUSER before calling
    ///GetIDsfromNames on it.
    IMAPIProp  lpPropObj;
    ///Type: <b>BOOL</b> Variable of type <b>BOOL</b> that specifies the read-only property on certain kinds of objects,
    ///such as the VCARD_NAME attribute, LDAP search results, and one-off MailUser. This member is relevant only for
    ///IShellPropSheetExt Interface. If this flag is set to true, one's property sheet must set all its controls to a
    ///read-only or disabled mode, typically in response to the WM_INITDIALOG message. Setting controls to a read-only
    ///state makes the user experience more consistent.
    BOOL       fReadOnly;
    ///Type: <b>BOOL</b> Variable of type <b>BOOL</b> that specifies the flag indicating that a change has been made to
    ///your property sheet. This member is relevant for IShellPropSheetExt Interface only. Any time the user makes a
    ///change such as adding, editing or deleting data on your property sheet, you must set this flag to true to signal
    ///to the WAB that the data on your property sheet has changed. If this flag is not set, the WAB may not persist the
    ///changes the user made to your property sheet.
    BOOL       fDataChanged;
    ///Type: <b>ULONG</b> Variable of type <b>ULONG</b> that specifies flags that control behavior. The following flags
    ///are valid.
    uint       ulFlags;
    ///Type: <b>LPVOID</b> Pointer that specifies miscellaneous information that is passed to your application. The
    ///current flags identify the information being represented. If <b>ulFlags</b> is set to <b>WAB_CONTEXT_ADRLIST</b>,
    ///<b>lpv</b> contains a pointer to an ADRLIST. Cast <b>lpv</b> to an <b>ADRLIST</b> to access the contents of the
    ///<b>ADRLIST</b>. The <b>lpAdrList-&gt;cEntries</b> member contains the number of selected items. The ADRENTRY
    ///structures in <b>lpAdrList-&gt;aEntries</b> contain SPropValue arrays with all of the properties pertaining to
    ///each selected item.
    void*      lpv;
    byte*      lpsz;
}

// Interfaces

interface IMAPIAdviseSink : IUnknown
{
    uint OnNotify(uint cNotif, NOTIFICATION* lpNotifications);
}

interface IMAPIProgress : IUnknown
{
    HRESULT Progress(uint ulValue, uint ulCount, uint ulTotal);
    HRESULT GetFlags(uint* lpulFlags);
    HRESULT GetMax(uint* lpulMax);
    HRESULT GetMin(uint* lpulMin);
    HRESULT SetLimits(uint* lpulMin, uint* lpulMax, uint* lpulFlags);
}

interface IMAPIProp : IUnknown
{
    HRESULT GetLastError(HRESULT hResult, uint ulFlags, MAPIERROR** lppMAPIError);
    HRESULT SaveChanges(uint ulFlags);
    HRESULT GetProps(SPropTagArray* lpPropTagArray, uint ulFlags, uint* lpcValues, SPropValue** lppPropArray);
    HRESULT GetPropList(uint ulFlags, SPropTagArray** lppPropTagArray);
    HRESULT OpenProperty(uint ulPropTag, GUID* lpiid, uint ulInterfaceOptions, uint ulFlags, IUnknown* lppUnk);
    HRESULT SetProps(uint cValues, SPropValue* lpPropArray, SPropProblemArray** lppProblems);
    HRESULT DeleteProps(SPropTagArray* lpPropTagArray, SPropProblemArray** lppProblems);
    HRESULT CopyTo(uint ciidExclude, GUID* rgiidExclude, SPropTagArray* lpExcludeProps, size_t ulUIParam, 
                   IMAPIProgress lpProgress, GUID* lpInterface, void* lpDestObj, uint ulFlags, 
                   SPropProblemArray** lppProblems);
    HRESULT CopyProps(SPropTagArray* lpIncludeProps, size_t ulUIParam, IMAPIProgress lpProgress, GUID* lpInterface, 
                      void* lpDestObj, uint ulFlags, SPropProblemArray** lppProblems);
    HRESULT GetNamesFromIDs(SPropTagArray** lppPropTags, GUID* lpPropSetGuid, uint ulFlags, uint* lpcPropNames, 
                            MAPINAMEID*** lpppPropNames);
    HRESULT GetIDsFromNames(uint cPropNames, MAPINAMEID** lppPropNames, uint ulFlags, SPropTagArray** lppPropTags);
}

///Do not use. This interface is used for content tables of Windows Address Book (WAB) containers and distribution
///lists.
interface IMAPITable : IUnknown
{
    HRESULT GetLastError(HRESULT hResult, uint ulFlags, MAPIERROR** lppMAPIError);
    HRESULT Advise(uint ulEventMask, IMAPIAdviseSink lpAdviseSink, uint* lpulConnection);
    HRESULT Unadvise(uint ulConnection);
    HRESULT GetStatus(uint* lpulTableStatus, uint* lpulTableType);
    HRESULT SetColumns(SPropTagArray* lpPropTagArray, uint ulFlags);
    HRESULT QueryColumns(uint ulFlags, SPropTagArray** lpPropTagArray);
    HRESULT GetRowCount(uint ulFlags, uint* lpulCount);
    HRESULT SeekRow(uint bkOrigin, int lRowCount, int* lplRowsSought);
    HRESULT SeekRowApprox(uint ulNumerator, uint ulDenominator);
    HRESULT QueryPosition(uint* lpulRow, uint* lpulNumerator, uint* lpulDenominator);
    HRESULT FindRow(SRestriction* lpRestriction, uint bkOrigin, uint ulFlags);
    HRESULT Restrict(SRestriction* lpRestriction, uint ulFlags);
    HRESULT CreateBookmark(uint* lpbkPosition);
    HRESULT FreeBookmark(uint bkPosition);
    HRESULT SortTable(SSortOrderSet* lpSortCriteria, uint ulFlags);
    HRESULT QuerySortOrder(SSortOrderSet** lppSortCriteria);
    HRESULT QueryRows(int lRowCount, uint ulFlags, SRowSet** lppRows);
    HRESULT Abort();
    HRESULT ExpandRow(uint cbInstanceKey, ubyte* pbInstanceKey, uint ulRowCount, uint ulFlags, SRowSet** lppRows, 
                      uint* lpulMoreRows);
    HRESULT CollapseRow(uint cbInstanceKey, ubyte* pbInstanceKey, uint ulFlags, uint* lpulRowCount);
    HRESULT WaitForCompletion(uint ulFlags, uint ulTimeout, uint* lpulTableStatus);
    HRESULT GetCollapseState(uint ulFlags, uint cbInstanceKey, ubyte* lpbInstanceKey, uint* lpcbCollapseState, 
                             ubyte** lppbCollapseState);
    HRESULT SetCollapseState(uint ulFlags, uint cbCollapseState, ubyte* pbCollapseState, uint* lpbkLocation);
}

interface IProfSect : IMAPIProp
{
}

interface IMAPIStatus : IMAPIProp
{
    HRESULT ValidateState(size_t ulUIParam, uint ulFlags);
    HRESULT SettingsDialog(size_t ulUIParam, uint ulFlags);
    HRESULT ChangePassword(byte* lpOldPass, byte* lpNewPass, uint ulFlags);
    HRESULT FlushQueues(size_t ulUIParam, uint cbTargetTransport, char* lpTargetTransport, uint ulFlags);
}

interface IMAPIContainer : IMAPIProp
{
    HRESULT GetContentsTable(uint ulFlags, IMAPITable* lppTable);
    HRESULT GetHierarchyTable(uint ulFlags, IMAPITable* lppTable);
    HRESULT OpenEntry(uint cbEntryID, char* lpEntryID, GUID* lpInterface, uint ulFlags, uint* lpulObjType, 
                      IUnknown* lppUnk);
    HRESULT SetSearchCriteria(SRestriction* lpRestriction, SBinaryArray* lpContainerList, uint ulSearchFlags);
    HRESULT GetSearchCriteria(uint ulFlags, SRestriction** lppRestriction, SBinaryArray** lppContainerList, 
                              uint* lpulSearchState);
}

///Do not use. This interface provides access to address book containers. Applications call the methods of the interface
///to perform name resolution and to create, copy, and delete recipients.
interface IABContainer : IMAPIContainer
{
    HRESULT CreateEntry(uint cbEntryID, char* lpEntryID, uint ulCreateFlags, IMAPIProp* lppMAPIPropEntry);
    HRESULT CopyEntries(SBinaryArray* lpEntries, size_t ulUIParam, IMAPIProgress lpProgress, uint ulFlags);
    HRESULT DeleteEntries(SBinaryArray* lpEntries, uint ulFlags);
    HRESULT ResolveNames(SPropTagArray* lpPropTagArray, uint ulFlags, ADRLIST* lpAdrList, _flaglist* lpFlagList);
}

///Do not use. This interface provides access to a mail user object.
interface IMailUser : IMAPIProp
{
}

///Do not use. This interface is used to provide access to distribution lists in modifiable address book containers. The
///interface provides methods to create, copy, and delete distribution lists, in addition to performing name resolution.
interface IDistList : IMAPIContainer
{
    HRESULT CreateEntry(uint cbEntryID, char* lpEntryID, uint ulCreateFlags, IMAPIProp* lppMAPIPropEntry);
    HRESULT CopyEntries(SBinaryArray* lpEntries, size_t ulUIParam, IMAPIProgress lpProgress, uint ulFlags);
    HRESULT DeleteEntries(SBinaryArray* lpEntries, uint ulFlags);
    HRESULT ResolveNames(SPropTagArray* lpPropTagArray, uint ulFlags, ADRLIST* lpAdrList, _flaglist* lpFlagList);
}

interface IMAPIFolder : IMAPIContainer
{
    HRESULT CreateMessage(GUID* lpInterface, uint ulFlags, IMessage* lppMessage);
    HRESULT CopyMessages(SBinaryArray* lpMsgList, GUID* lpInterface, void* lpDestFolder, size_t ulUIParam, 
                         IMAPIProgress lpProgress, uint ulFlags);
    HRESULT DeleteMessages(SBinaryArray* lpMsgList, size_t ulUIParam, IMAPIProgress lpProgress, uint ulFlags);
    HRESULT CreateFolder(uint ulFolderType, byte* lpszFolderName, byte* lpszFolderComment, GUID* lpInterface, 
                         uint ulFlags, IMAPIFolder* lppFolder);
    HRESULT CopyFolder(uint cbEntryID, char* lpEntryID, GUID* lpInterface, void* lpDestFolder, 
                       byte* lpszNewFolderName, size_t ulUIParam, IMAPIProgress lpProgress, uint ulFlags);
    HRESULT DeleteFolder(uint cbEntryID, char* lpEntryID, size_t ulUIParam, IMAPIProgress lpProgress, uint ulFlags);
    HRESULT SetReadFlags(SBinaryArray* lpMsgList, size_t ulUIParam, IMAPIProgress lpProgress, uint ulFlags);
    HRESULT GetMessageStatus(uint cbEntryID, char* lpEntryID, uint ulFlags, uint* lpulMessageStatus);
    HRESULT SetMessageStatus(uint cbEntryID, char* lpEntryID, uint ulNewStatus, uint ulNewStatusMask, 
                             uint* lpulOldStatus);
    HRESULT SaveContentsSort(SSortOrderSet* lpSortCriteria, uint ulFlags);
    HRESULT EmptyFolder(size_t ulUIParam, IMAPIProgress lpProgress, uint ulFlags);
}

interface IMsgStore : IMAPIProp
{
    HRESULT Advise(uint cbEntryID, char* lpEntryID, uint ulEventMask, IMAPIAdviseSink lpAdviseSink, 
                   uint* lpulConnection);
    HRESULT Unadvise(uint ulConnection);
    HRESULT CompareEntryIDs(uint cbEntryID1, char* lpEntryID1, uint cbEntryID2, char* lpEntryID2, uint ulFlags, 
                            uint* lpulResult);
    HRESULT OpenEntry(uint cbEntryID, char* lpEntryID, GUID* lpInterface, uint ulFlags, uint* lpulObjType, 
                      IUnknown* ppUnk);
    HRESULT SetReceiveFolder(byte* lpszMessageClass, uint ulFlags, uint cbEntryID, char* lpEntryID);
    HRESULT GetReceiveFolder(byte* lpszMessageClass, uint ulFlags, uint* lpcbEntryID, ENTRYID** lppEntryID, 
                             byte** lppszExplicitClass);
    HRESULT GetReceiveFolderTable(uint ulFlags, IMAPITable* lppTable);
    HRESULT StoreLogoff(uint* lpulFlags);
    HRESULT AbortSubmit(uint cbEntryID, char* lpEntryID, uint ulFlags);
    HRESULT GetOutgoingQueue(uint ulFlags, IMAPITable* lppTable);
    HRESULT SetLockState(IMessage lpMessage, uint ulLockState);
    HRESULT FinishedMsg(uint ulFlags, uint cbEntryID, char* lpEntryID);
    HRESULT NotifyNewMail(NOTIFICATION* lpNotification);
}

interface IMessage : IMAPIProp
{
    HRESULT GetAttachmentTable(uint ulFlags, IMAPITable* lppTable);
    HRESULT OpenAttach(uint ulAttachmentNum, GUID* lpInterface, uint ulFlags, IAttach* lppAttach);
    HRESULT CreateAttach(GUID* lpInterface, uint ulFlags, uint* lpulAttachmentNum, IAttach* lppAttach);
    HRESULT DeleteAttach(uint ulAttachmentNum, size_t ulUIParam, IMAPIProgress lpProgress, uint ulFlags);
    HRESULT GetRecipientTable(uint ulFlags, IMAPITable* lppTable);
    HRESULT ModifyRecipients(uint ulFlags, ADRLIST* lpMods);
    HRESULT SubmitMessage(uint ulFlags);
    HRESULT SetReadFlag(uint ulFlags);
}

interface IAttach : IMAPIProp
{
}

interface IMAPIControl : IUnknown
{
    HRESULT GetLastError(HRESULT hResult, uint ulFlags, MAPIERROR** lppMAPIError);
    HRESULT Activate(uint ulFlags, size_t ulUIParam);
    HRESULT GetState(uint ulFlags, uint* lpulState);
}

interface IProviderAdmin : IUnknown
{
    HRESULT GetLastError(HRESULT hResult, uint ulFlags, MAPIERROR** lppMAPIError);
    HRESULT GetProviderTable(uint ulFlags, IMAPITable* lppTable);
    HRESULT CreateProvider(byte* lpszProvider, uint cValues, char* lpProps, size_t ulUIParam, uint ulFlags, 
                           MAPIUID* lpUID);
    HRESULT DeleteProvider(MAPIUID* lpUID);
    HRESULT OpenProfileSection(MAPIUID* lpUID, GUID* lpInterface, uint ulFlags, IProfSect* lppProfSect);
}

///Do not use. This interface supports access to the Windows Address Book (WAB) and includes operations such as
///displaying common dialog boxes, opening containers, messaging users (contacts) and distribution lists (groups) in the
///address book, and performing name resolution.
interface IAddrBook : IMAPIProp
{
    HRESULT OpenEntry(uint cbEntryID, ENTRYID* lpEntryID, GUID* lpInterface, uint ulFlags, uint* lpulObjType, 
                      IUnknown* lppUnk);
    HRESULT CompareEntryIDs(uint cbEntryID1, ENTRYID* lpEntryID1, uint cbEntryID2, ENTRYID* lpEntryID2, 
                            uint ulFlags, uint* lpulResult);
    HRESULT Advise(uint cbEntryID, ENTRYID* lpEntryID, uint ulEventMask, IMAPIAdviseSink lpAdviseSink, 
                   uint* lpulConnection);
    HRESULT Unadvise(uint ulConnection);
    HRESULT CreateOneOff(byte* lpszName, byte* lpszAdrType, byte* lpszAddress, uint ulFlags, uint* lpcbEntryID, 
                         ENTRYID** lppEntryID);
    HRESULT NewEntry(uint ulUIParam, uint ulFlags, uint cbEIDContainer, ENTRYID* lpEIDContainer, 
                     uint cbEIDNewEntryTpl, ENTRYID* lpEIDNewEntryTpl, uint* lpcbEIDNewEntry, 
                     ENTRYID** lppEIDNewEntry);
    HRESULT ResolveName(size_t ulUIParam, uint ulFlags, byte* lpszNewEntryTitle, ADRLIST* lpAdrList);
    HRESULT Address(uint* lpulUIParam, ADRPARM* lpAdrParms, ADRLIST** lppAdrList);
    HRESULT Details(size_t* lpulUIParam, LPFNDISMISS lpfnDismiss, void* lpvDismissContext, uint cbEntryID, 
                    ENTRYID* lpEntryID, LPFNBUTTON lpfButtonCallback, void* lpvButtonContext, byte* lpszButtonText, 
                    uint ulFlags);
    HRESULT RecipOptions(uint ulUIParam, uint ulFlags, ADRENTRY* lpRecip);
    HRESULT QueryDefaultRecipOpt(byte* lpszAdrType, uint ulFlags, uint* lpcValues, SPropValue** lppOptions);
    HRESULT GetPAB(uint* lpcbEntryID, ENTRYID** lppEntryID);
    HRESULT SetPAB(uint cbEntryID, ENTRYID* lpEntryID);
    HRESULT GetDefaultDir(uint* lpcbEntryID, ENTRYID** lppEntryID);
    HRESULT SetDefaultDir(uint cbEntryID, ENTRYID* lpEntryID);
    HRESULT GetSearchPath(uint ulFlags, SRowSet** lppSearchPath);
    HRESULT SetSearchPath(uint ulFlags, SRowSet* lpSearchPath);
    HRESULT PrepareRecips(uint ulFlags, SPropTagArray* lpPropTagArray, ADRLIST* lpRecipList);
}

///Do not use. This interface provides access to the Windows Address Book (WAB) object which contains function pointers
///to memory allocation functions and database maintenance functions.
interface IWABObject : IUnknown
{
    ///This method is not implemented.
    ///Params:
    ///    hResult = TBD
    ///    ulFlags = TBD
    ///    lppMAPIError = TBD
    HRESULT GetLastError(HRESULT hResult, uint ulFlags, MAPIERROR** lppMAPIError);
    ///Allocates memory for buffers that are passed to Windows Address Book (WAB) methods. The buffer must be freed with
    ///IWABObject::FreeBuffer, and may be reallocated with IWABObject::AllocateMore.
    ///Params:
    ///    cbSize = Type: <b>ULONG</b> Value of type <b>ULONG</b> that specifies the size in bytes of the buffer to be allocated.
    ///    lppBuffer = Type: <b>LPVOID*</b> Address of a pointer to the returned buffer.
    HRESULT AllocateBuffer(uint cbSize, void** lppBuffer);
    ///Allocates a memory buffer that is linked to another buffer previously allocated with the
    ///IWABObject::AllocateBuffer method.
    ///Params:
    ///    cbSize = Type: <b>ULONG</b> Value of type <b>ULONG</b> that specifies the size in bytes of the buffer to be allocated.
    ///    lpObject = Type: <b>LPVOID</b> Pointer to the existing buffer object allocated using IWABObject::AllocateBuffer.
    ///    lppBuffer = Type: <b>LPVOID*</b> Address of a pointer to the returned buffer. This buffer is linked to <i>lpObject</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful.
    ///    
    HRESULT AllocateMore(uint cbSize, void* lpObject, void** lppBuffer);
    ///Frees memory allocated with IWABObject::AllocateBuffer or any of the other Windows Address Book (WAB) methods.
    ///Params:
    ///    lpBuffer = Type: <b>LPVOID</b> Pointer to the buffer to be freed.
    HRESULT FreeBuffer(void* lpBuffer);
    ///This method is not implemented.
    ///Params:
    ///    lpFileName = TBD
    HRESULT Backup(const(char)* lpFileName);
    ///Imports a .wab file into the user's Address Book.
    ///Params:
    ///    lpWIP = Type: <b>LPSTR</b> Pointer to a WABIMPORTPARAM structure.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful, or an error value otherwise.
    ///    
    HRESULT Import(const(char)* lpWIP);
    ///Launches the Windows Address Book (WAB) Find dialog box.
    ///Params:
    ///    lpIAB = Type: <b>IAddrBook*</b> Pointer to an IAddrBook interface that specifies the address book to search.
    ///    hWnd = Type: <b>HWND</b> Value of type <b>HWND</b> that specifies the handle to the parent window for the Find
    ///           dialog box. The value can be <b>NULL</b>.
    HRESULT Find(IAddrBook lpIAB, HWND hWnd);
    ///Displays properties on a vCard file.
    ///Params:
    ///    lpIAB = Type: <b>IAddrBook*</b> Pointer to an IAddrBook interface that specifies the address book object.
    ///    hWnd = Type: <b>HWND</b> Value of type <b>HWND</b> that specifies the parent window handle for displayed dialog
    ///           boxes.
    ///    lpszFileName = Type: <b>LPSTR</b> Value of type <b>LPSTR</b> that specifies the full path of the vCard file to display.
    HRESULT VCardDisplay(IAddrBook lpIAB, HWND hWnd, const(char)* lpszFileName);
    ///Processes an Lightweight Directory Access Protocol (LDAP) URL and displays the results obtained from the URL. If
    ///the URL only contains a server name, the Windows Address Book (WAB) launches the Find window with the server name
    ///filled in. If the URL contains an LDAP query, the query is processed. If the query has a single result, the WAB
    ///shows details about the result; if the query has multiple results, the WAB shows the Find dialog box with
    ///multiple search results filled in.
    ///Params:
    ///    lpIAB = Type: <b>IAddrBook*</b> Pointer to an IAddrBook interface that specifies the address book to use.
    ///    hWnd = Type: <b>HWND</b> Value of type <b>HWND</b> that specifies the handle to the parent window for displayed
    ///           dialog boxes.
    ///    ulFlags = Type: <b>ULONG</b> Value of type <b>ULONG</b> that specifies flags that affect functionality.
    ///    lpszURL = Type: <b>LPSTR</b> Value of type <b>LPSTR</b> that specifies the LDAP URL string. This string must begin with
    ///              "ldap://".
    ///    lppMailUser = Type: <b>IMailUser**</b> Address of a pointer to an IMailUser interface that receives the returned Mailuser
    ///                  object, if requested. Otherwise, it is <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT LDAPUrl(IAddrBook lpIAB, HWND hWnd, uint ulFlags, const(char)* lpszURL, IMailUser* lppMailUser);
    ///Translates the properties of a given MailUser object into a vCard file.
    ///Params:
    ///    lpIAB = Type: <b>IAddrBook*</b> Pointer to an IAddrBookinterface that specifies the address book.
    ///    ulFlags = Type: <b>ULONG</b> No flags.
    ///    lpszVCard = Type: <b>LPSTR</b> Value of type <b>LPSTR</b> that specifies the string containing the complete path name of
    ///                the file to create.
    ///    lpMailUser = Type: <b>IMailUser*</b> Pointer to an IMailUser interface that specifies the object whose properties are to
    ///                 be written into the file.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT VCardCreate(IAddrBook lpIAB, uint ulFlags, const(char)* lpszVCard, IMailUser lpMailUser);
    ///Reads a vCard file and creates a MailUser object containing the vCard properties.
    ///Params:
    ///    lpIAB = Type: <b>IAddrBook*</b> Pointer to an IAddrBook interface that specifies the address book object.
    ///    ulFlags = Type: <b>ULONG</b> Value of type <b>ULONG</b> that specifies flags affecting behavior.
    ///    lpszVCard = Type: <b>LPSTR</b> Pointer to a string containing either the complete path name of the file to be read or the
    ///                vCard buffer.
    ///    lppMailUser = Type: <b>IMailUser**</b> Address of a pointer to an IMailUser interface that receives the MailUser object
    ///                  created containing the properties in the vCard file.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT VCardRetrieve(IAddrBook lpIAB, uint ulFlags, const(char)* lpszVCard, IMailUser* lppMailUser);
    ///Retrieves the entry identifier of the object that has been designated as "ME."
    ///Params:
    ///    lpIAB = Type: <b>IAddrBook*</b> Pointer to an IAddrBook interface that specifies the address book object.
    ///    ulFlags = Type: <b>ULONG</b> Value of type <b>ULONG</b> that specifies flags affecting functionality.
    ///    lpdwAction = Type: <b>DWORD*</b> Pointer to a variable of type <b>DWORD</b> that receives the flag WABOBJECT_ME_NEW on
    ///                 return, if a new ME entry is created. The variable is used to signal creation, as opposed to selection, of a
    ///                 new ME entry. The variable can be <b>NULL</b>.
    ///    lpsbEID = Type: <b>SBinary*</b> Pointer to a variable of type SBinary that specifies the entry identifier of the ME
    ///              object on return.
    ///    hwnd = Type: <b>ULONG</b> Value of type <b>ULONG</b> that specifies the handle of the parent window for displayed
    ///           dialog boxes. You must cast the parent <b>HWND</b> to a <b>ULONG</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetMe(IAddrBook lpIAB, uint ulFlags, uint* lpdwAction, SBinary* lpsbEID, HWND hwnd);
    ///Designates a particular contact as the ME object.
    ///Params:
    ///    lpIAB = Type: <b>IAddrBook*</b> Pointer to an IAddrBook interface that specifies the address book.
    ///    ulFlags = Type: <b>ULONG</b> Value of type <b>ULONG</b> that specifies flags affecting behavior.
    ///    sbEID = Type: <b>SBinary</b> Value of type SBinary that specifies the entry identifier of the contact that should be
    ///            tagged as ME.
    ///    hwnd = Type: <b>ULONG</b> Value of type <b>ULONG</b> that specifies the parent window handle for displaying dialog
    ///           boxes. Cast the parent <b>HWND</b> to a <b>ULONG</b> before passing.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful, or an error code otherwise.
    ///    
    HRESULT SetMe(IAddrBook lpIAB, uint ulFlags, SBinary sbEID, HWND hwnd);
}

interface IWABOBJECT_
{
    HRESULT QueryInterface(const(GUID)* riid, void** ppvObj);
    uint    AddRef();
    uint    Release();
    HRESULT GetLastError(HRESULT hResult, uint ulFlags, MAPIERROR** lppMAPIError);
    HRESULT AllocateBuffer(uint cbSize, void** lppBuffer);
    HRESULT AllocateMore(uint cbSize, void* lpObject, void** lppBuffer);
    HRESULT FreeBuffer(void* lpBuffer);
    HRESULT Backup(const(char)* lpFileName);
    HRESULT Import(const(char)* lpWIP);
    HRESULT Find(IAddrBook lpIAB, HWND hWnd);
    HRESULT VCardDisplay(IAddrBook lpIAB, HWND hWnd, const(char)* lpszFileName);
    HRESULT LDAPUrl(IAddrBook lpIAB, HWND hWnd, uint ulFlags, const(char)* lpszURL, IMailUser* lppMailUser);
    HRESULT VCardCreate(IAddrBook lpIAB, uint ulFlags, const(char)* lpszVCard, IMailUser lpMailUser);
    HRESULT VCardRetrieve(IAddrBook lpIAB, uint ulFlags, const(char)* lpszVCard, IMailUser* lppMailUser);
    HRESULT GetMe(IAddrBook lpIAB, uint ulFlags, uint* lpdwAction, SBinary* lpsbEID, HWND hwnd);
    HRESULT SetMe(IAddrBook lpIAB, uint ulFlags, SBinary sbEID, HWND hwnd);
}

///Do not use. This interface ndicates which Windows Address Book (WAB) object is being displayed (for example, a
///property sheet or context menu).
interface IWABExtInit : IUnknown
{
    HRESULT Initialize(WABEXTDISPLAY* lpWABExtDisplay);
}


