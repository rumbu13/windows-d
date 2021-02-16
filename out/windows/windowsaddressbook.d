module windows.windowsaddressbook;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : BOOL, CY, LARGE_INTEGER;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


// Enums


enum Gender : int
{
    genderUnspecified = 0x00000000,
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


struct ENTRYID
{
    ubyte[4] abFlags;
    ubyte[1] ab;
}

struct MAPIUID
{
    ubyte[16] ab;
}

struct SPropTagArray
{
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

struct SBinaryArray
{
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

struct SPropValue
{
    uint ulPropTag;
    uint dwAlignPad;
    _PV  Value;
}

struct SPropProblem
{
    uint ulIndex;
    uint ulPropTag;
    int  scode;
}

struct SPropProblemArray
{
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

struct ADRENTRY
{
    uint        ulReserved1;
    uint        cValues;
    SPropValue* rgPropVals;
}

struct ADRLIST
{
    uint        cEntries;
    ADRENTRY[1] aEntries;
}

struct SRow
{
    uint        ulAdrEntryPad;
    uint        cValues;
    SPropValue* lpProps;
}

struct SRowSet
{
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

struct SSortOrder
{
    uint ulPropTag;
    uint ulOrder;
}

struct SSortOrderSet
{
    uint          cSorts;
    uint          cCategories;
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

struct SRestriction
{
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

struct ADRPARM
{
    uint          cbABContEntryID;
    ENTRYID*      lpABContEntryID;
    uint          ulFlags;
    void*         lpReserved;
    uint          ulHelpContext;
    byte*         lpszHelpFileName;
    LPFNABSDI     lpfnABSDI;
    LPFNDISMISS   lpfnDismiss;
    void*         lpvDismissContext;
    byte*         lpszCaption;
    byte*         lpszNewEntryTitle;
    byte*         lpszDestWellsTitle;
    uint          cDestFields;
    uint          nDestFieldFocus;
    byte**        lppszDestTitles;
    uint*         lpulDestComps;
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

struct WAB_PARAM
{
    uint         cbSize;
    HWND         hwnd;
    const(char)* szFileName;
    uint         ulFlags;
    GUID         guidPSExt;
}

struct WABIMPORTPARAM
{
    uint         cbSize;
    IAddrBook    lpAdrBook;
    HWND         hWnd;
    uint         ulFlags;
    const(char)* lpszFileName;
}

struct WABEXTDISPLAY
{
    uint       cbSize;
    IWABObject lpWABObject;
    IAddrBook  lpAdrBook;
    IMAPIProp  lpPropObj;
    BOOL       fReadOnly;
    BOOL       fDataChanged;
    uint       ulFlags;
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

interface IABContainer : IMAPIContainer
{
    HRESULT CreateEntry(uint cbEntryID, char* lpEntryID, uint ulCreateFlags, IMAPIProp* lppMAPIPropEntry);
    HRESULT CopyEntries(SBinaryArray* lpEntries, size_t ulUIParam, IMAPIProgress lpProgress, uint ulFlags);
    HRESULT DeleteEntries(SBinaryArray* lpEntries, uint ulFlags);
    HRESULT ResolveNames(SPropTagArray* lpPropTagArray, uint ulFlags, ADRLIST* lpAdrList, _flaglist* lpFlagList);
}

interface IMailUser : IMAPIProp
{
}

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

interface IWABObject : IUnknown
{
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

interface IWABExtInit : IUnknown
{
    HRESULT Initialize(WABEXTDISPLAY* lpWABExtDisplay);
}


