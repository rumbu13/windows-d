// Written in the D programming language.

module windows.htmlhelp;

public import windows.core;
public import windows.automation : VARIANT;
public import windows.com : HRESULT, IPersistStreamInit, IUnknown;
public import windows.controls : NMHDR;
public import windows.displaydevices : POINT, RECT;
public import windows.search : IStemmer;
public import windows.structuredstorage : IStream;
public import windows.systemservices : BOOL, HINSTANCE, PSTR, PWSTR;
public import windows.windowsandmessaging : HWND;

extern(Windows) @nogc nothrow:


// Enums


alias HH_GPROPID = int;
enum : int
{
    HH_GPROPID_SINGLETHREAD     = 0x00000001,
    HH_GPROPID_TOOLBAR_MARGIN   = 0x00000002,
    HH_GPROPID_UI_LANGUAGE      = 0x00000003,
    HH_GPROPID_CURRENT_SUBSET   = 0x00000004,
    HH_GPROPID_CONTENT_LANGUAGE = 0x00000005,
}

alias PRIORITY = int;
enum : int
{
    PRIORITY_LOW    = 0x00000000,
    PRIORITY_NORMAL = 0x00000001,
    PRIORITY_HIGH   = 0x00000002,
}

// Constants


enum : int
{
    HHWIN_NAVTYPE_TOC          = 0x00000000,
    HHWIN_NAVTYPE_INDEX        = 0x00000001,
    HHWIN_NAVTYPE_SEARCH       = 0x00000002,
    HHWIN_NAVTYPE_FAVORITES    = 0x00000003,
    HHWIN_NAVTYPE_HISTORY      = 0x00000004,
    HHWIN_NAVTYPE_AUTHOR       = 0x00000005,
    HHWIN_NAVTYPE_CUSTOM_FIRST = 0x0000000b,
}

enum int IT_EXCLUSIVE = 0x00000001;

enum : int
{
    HHWIN_NAVTAB_TOP    = 0x00000000,
    HHWIN_NAVTAB_LEFT   = 0x00000001,
    HHWIN_NAVTAB_BOTTOM = 0x00000002,
}

enum : int
{
    HH_TAB_INDEX        = 0x00000001,
    HH_TAB_SEARCH       = 0x00000002,
    HH_TAB_FAVORITES    = 0x00000003,
    HH_TAB_HISTORY      = 0x00000004,
    HH_TAB_AUTHOR       = 0x00000005,
    HH_TAB_CUSTOM_FIRST = 0x0000000b,
    HH_TAB_CUSTOM_LAST  = 0x00000013,
}

enum : int
{
    HHACT_TAB_INDEX     = 0x00000001,
    HHACT_TAB_SEARCH    = 0x00000002,
    HHACT_TAB_HISTORY   = 0x00000003,
    HHACT_TAB_FAVORITES = 0x00000004,
}

enum : int
{
    HHACT_CONTRACT  = 0x00000006,
    HHACT_BACK      = 0x00000007,
    HHACT_FORWARD   = 0x00000008,
    HHACT_STOP      = 0x00000009,
    HHACT_REFRESH   = 0x0000000a,
    HHACT_HOME      = 0x0000000b,
    HHACT_SYNC      = 0x0000000c,
    HHACT_OPTIONS   = 0x0000000d,
    HHACT_PRINT     = 0x0000000e,
    HHACT_HIGHLIGHT = 0x0000000f,
}

enum : int
{
    HHACT_JUMP1     = 0x00000011,
    HHACT_JUMP2     = 0x00000012,
    HHACT_ZOOM      = 0x00000013,
    HHACT_TOC_NEXT  = 0x00000014,
    HHACT_TOC_PREV  = 0x00000015,
    HHACT_NOTES     = 0x00000016,
    HHACT_LAST_ENUM = 0x00000017,
}

// Callbacks

alias PFNCOLHEAPFREE = int function(void* param0);

// Structs


///Use this structure to return the file name of the topic that has been navigated to, or to return the window type name
///of the help window that has been created.
struct HHN_NOTIFY
{
    ///Standard <b>WM_NOTIFY</b> header.
    NMHDR       hdr;
    ///A multi-byte, zero-terminated string that specifies the topic navigated to, or the name of the help window being
    ///created.
    const(PSTR) pszUrl;
}

///Use this structure to specify or modify the attributes of a pop-up window.
struct HH_POPUP
{
    ///Specifies the size of the structure. This value must always be filled in before passing the structure to
    ///HtmlHelp().
    int       cbStruct;
    ///Instance handle of the program or DLL to retrieve the string resource from. Ignored if <i>idString</i> is zero,
    ///or if <i>idString</i> specifies a file name.
    HINSTANCE hinst;
    ///Specifies zero, a resource ID, or a topic number in a text file.
    uint      idString;
    ///Specifies the text to display if <i>idString</i> is zero.
    byte*     pszText;
    ///Specifies (in pixels) where the top center of the pop-up window should be located.
    POINT     pt;
    ///Specifies the RGB value to use for the foreground color of the pop-up window. To use the system color for the
    ///window text, specify -1.
    uint      clrForeground;
    ///Specifies the RGB value to use for the background color of the pop-up window. To use the system color for the
    ///window background, specify -1.
    uint      clrBackground;
    ///Specifies (in pixels) the margins to use on the left, top, right, and bottom sides of the pop-up window. The
    ///default for all rectangle members is -1.
    RECT      rcMargins;
    ///Specifies the font attributes to use for the text in the pop-up window. Use the following format to specify font
    ///family, point size, character set, and font format: facename[, point size[, charset[ BOLD ITALIC UNDERLINE]]] To
    ///omit an attribute, enter a comma. For example, to specify bold, 10-pt, MS Sans Serif font, <i>pszFont</i> would
    ///be: MS Sans Serif, 10, , BOLD
    byte*     pszFont;
}

///Use this structure to specify one or more ALink names or KLink keywords that you want to search for.
struct HH_AKLINK
{
    ///Specifies the size of the structure. This value must always be filled in before passing the structure to the HTML
    ///Help API.
    int   cbStruct;
    ///This parameter must be set to FALSE.
    BOOL  fReserved;
    ///Specifies one or more ALink names or KLink keywords to look up. Multiple entries are delimited by a semicolon.
    byte* pszKeywords;
    ///Specifies the topic file to navigate to if the lookup fails. <i>pszURL</i> refers to a valid topic within the
    ///specified compiled help (.chm) file and does not support Internet protocols that point to an HTML file.
    byte* pszUrl;
    ///Specifies the text to display in a message box if the lookup fails and <i>fIndexOnFail</i> is FALSE and
    ///<i>pszURL</i> is NULL.
    byte* pszMsgText;
    ///Specifies the caption of the message box in which the <i>pszMsgText</i> parameter appears.
    byte* pszMsgTitle;
    ///Specifies the name of the window type in which to display one of the following: <ul> <li>The selected topic, if
    ///the lookup yields one or more matching topics.</li> <li>The topic specified in <i>pszURL</i>, if the lookup fails
    ///and a topic is specified in <i>pszURL</i>.</li> </ul> The Index tab, if the lookup fails and <i>fIndexOnFail</i>
    ///is specified as TRUE.
    byte* pszWindow;
    ///Specifies whether to display the keyword in the Index tab of the HTML Help Viewer if the lookup fails. The value
    ///of <i>pszWindow</i> specifies the Help Viewer.
    BOOL  fIndexOnFail;
}

struct HH_ENUM_IT
{
    int         cbStruct;
    int         iType;
    const(PSTR) pszCatName;
    const(PSTR) pszITName;
    const(PSTR) pszITDescription;
}

struct HH_ENUM_CAT
{
    int         cbStruct;
    const(PSTR) pszCatName;
    const(PSTR) pszCatDescription;
}

struct HH_SET_INFOTYPE
{
    int         cbStruct;
    const(PSTR) pszCatName;
    const(PSTR) pszInfoTypeName;
}

///Use this structure for full-text search.
struct HH_FTS_QUERY
{
    ///Specifies the size of the structure.
    int   cbStruct;
    ///TRUE if all strings are Unicode.
    BOOL  fUniCodeStrings;
    ///String containing the search query.
    byte* pszSearchQuery;
    ///Word proximity.
    int   iProximity;
    ///TRUE for StemmedSearch only.
    BOOL  fStemmedSearch;
    ///TRUE for Title search only.
    BOOL  fTitleOnly;
    ///TRUE to initiate the search.
    BOOL  fExecute;
    ///Window to display in.
    byte* pszWindow;
}

///Use this structure to specify or modify the attributes of a window type.
struct HH_WINTYPE
{
    ///Specifies the size of the structure. This value must always be filled in before passing the structure to
    ///HtmlHelp().
    int       cbStruct;
    ///Specifies whether the strings used in this structure are UNICODE.
    BOOL      fUniCodeStrings;
    ///A null-terminated string that specifies the name of the window type.
    byte*     pszType;
    ///Specifies which members in the structure are valid.
    uint      fsValidMembers;
    ///Specifies the properties of the window, such as whether it is the standard HTML Help Viewer or whether it
    ///includes a Search tab.
    uint      fsWinProperties;
    ///A null-terminated string that specifies the caption to display in the title bar of the window.
    byte*     pszCaption;
    ///Specifies the styles used to create the window. These styles can be ignored, combined with extended styles, or
    ///used exclusively depending on the value of the <i>fsValidMembers</i> and <i>fsWinProperties</i> parameters.
    uint      dwStyles;
    ///Specifies the extended styles used to create the window. These styles can be ignored, combined with default
    ///styles, or used exclusively depending on the value of the <i>fsValidMembers</i> and <i>fsWinProperties</i>
    ///parameters.
    uint      dwExStyles;
    ///Specifies the coordinates of the window in pixels. The values are read in the following order: <i>rcWindowPos</i>
    ///= {left, top, right, bottom};
    RECT      rcWindowPos;
    ///Specifies the initial display state of the window. Valid values are the same as those for the Win32 API
    ///<b>ShowWindow</b> function.
    int       nShowState;
    ///Specifies the handle of the window if the window has been created.
    HWND      hwndHelp;
    ///Specifies the window that will receive HTML Help notification messages. Notification messages are sent via
    ///Windows <b>WM_NOTIFY</b> messages.
    HWND      hwndCaller;
    ///Pointer to an array of Information Types.
    uint*     paInfoTypes;
    ///Specifies the handle of the toolbar.
    HWND      hwndToolBar;
    ///Specifies the handle of the Navigation pane.
    HWND      hwndNavigation;
    ///Specifies the handle of the Topic pane, which hosts Shdocvw.dll.
    HWND      hwndHTML;
    ///Specifies the width of the Navigation pane when the Help Viewer is expanded.
    int       iNavWidth;
    ///Specifies the coordinates of the Topic pane.
    RECT      rcHTML;
    ///Specifies the contents (.hhc) file to display in the Navigation pane.
    byte*     pszToc;
    ///Specifies the index (.hhk) file to display in the Navigation pane.
    byte*     pszIndex;
    ///Specifies the default HTML file to display in the Topic pane.
    byte*     pszFile;
    ///Specifies the file or URL to display in the Topic pane when the Home button is clicked. Specifies which buttons
    ///to include on the toolbar.
    byte*     pszHome;
    ///Specifies which buttons to include on the Toolbar pane of a three-pane Help Viewer.
    uint      fsToolBarFlags;
    ///Specifies that the Help Viewer open with the Navigation pane closed.
    BOOL      fNotExpanded;
    ///Specifies the default tab to display on the Navigation pane.
    int       curNavType;
    ///Specifies where to place the tabs on the Navigation pane of the HTML Help Viewer.
    int       tabpos;
    ///Specifies a non-zero ID for enabling HTML Help notification messages. This ID is passed as the wParam value of
    ///Windows <b>WM_NOTIFY</b> messages.
    int       idNotify;
    ///Tab order: Contents, Index, Search, History, Favorites, Reserved 1-5, Custom tabs
    ubyte[20] tabOrder;
    ///Number of history items to keep. (Default: 30)
    int       cHistory;
    ///Specifies the text to display underneath the Jump1 button.
    byte*     pszJump1;
    ///Specifies the text to display underneath the Jump2 button.
    byte*     pszJump2;
    ///Specifies the URL to jump to when the Jump1 button is clicked.
    byte*     pszUrlJump1;
    ///Specifies the URL to jump to when the Jump2 button is clicked.
    byte*     pszUrlJump2;
    ///Minimum size for window (ignored in version 1).
    RECT      rcMinSize;
    ///Size of <i>paInfoTypes</i>
    int       cbInfoTypes;
    ///Series of zero-terminated strings to be used as tab labels.
    byte*     pszCustomTabs;
}

///This structure returns the file name of the current topic and a constant that specifies the user action that is about
///to occur, such as hiding the Navigation pane by clicking the Hide button on the toolbar.
struct HHNTRACK
{
    ///Standard <b>WM_NOTIFY</b> header.
    NMHDR       hdr;
    ///A multi-byte, zero-terminated string that specifies the current topic (before the action is taken).
    const(PSTR) pszCurUrl;
    ///Specifies the action the user is about to take. This is an HHACT_ constant.
    int         idAction;
    ///A pointer to the current HH_WINTYPE structure.
    HH_WINTYPE* phhWinType;
}

struct HH_GLOBAL_PROPERTY
{
    HH_GPROPID id;
    VARIANT    var;
}

struct CProperty
{
    uint dwPropID;
    uint cbData;
    uint dwType;
union
    {
        PWSTR lpszwData;
        void* lpvData;
        uint  dwValue;
    }
    BOOL fPersist;
}

struct IITGroup
{
}

struct IITQuery
{
}

struct IITStopWordList
{
}

struct ROWSTATUS
{
    int lRowFirst;
    int cRows;
    int cProperties;
    int cRowsTotal;
}

struct COLUMNSTATUS
{
    int cPropCount;
    int cPropsLoaded;
}

// Interfaces

///Use this interface to set properties for build objects such as word wheels and indexes. Call these methods in the
///document build process to define properties for all build objects.
interface IITPropList : IPersistStreamInit
{
    HRESULT Set(uint PropID, uint dwData, uint dwOperation);
    HRESULT Set(uint PropID, void* lpvData, uint cbData, uint dwOperation);
    HRESULT Set(uint PropID, const(PWSTR) lpszwString, uint dwOperation);
    HRESULT Add(CProperty* Prop);
    ///Returns the property object associated with the given property ID.
    ///Params:
    ///    PropID = ID of the property object to get.
    ///    Property = The property object returned.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The property was successfully
    ///    returned. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTEXIST</b></dt> </dl> </td> <td width="60%"> The
    ///    requested property does not exist. </td> </tr> </table>
    ///    
    HRESULT Get(uint PropID, CProperty* Property);
    ///Clears memory associated with a property list and reinitializes the list.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The property list was cleared. </td>
    ///    </tr> </table>
    ///    
    HRESULT Clear();
    HRESULT SetPersist(uint PropID, BOOL fPersist);
    HRESULT SetPersist(BOOL fPersist);
    ///Returns the first property object in a property list.
    ///Params:
    ///    Property = The property object returned.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The property was successfully
    ///    returned. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTEXIST</b></dt> </dl> </td> <td width="60%"> The
    ///    requested property does not exist. </td> </tr> </table>
    ///    
    HRESULT GetFirst(CProperty* Property);
    HRESULT GetNext(CProperty* Property);
    HRESULT GetPropCount(int* cProp);
    ///Saves the property ID and data type from the property list to a buffer. Only saves properties marked with a
    ///persistence state of TRUE.
    ///Params:
    ///    lpvData = Pointer to a buffer to fill.
    ///    dwHdrSize = Size of the buffer.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The property list was successfully
    ///    saved. </td> </tr> </table>
    ///    
    HRESULT SaveHeader(void* lpvData, uint dwHdrSize);
    ///Saves the data size and data from the property list to a buffer.
    ///Params:
    ///    lpvHeader = Pointer to a buffer containing the header.
    ///    dwHdrSize = Size of the buffer containing the header.
    ///    lpvData = Pointer to a buffer to fill.
    ///    dwBufSize = Size of the buffer to fill.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The property list was successfully
    ///    saved. </td> </tr> </table>
    ///    
    HRESULT SaveData(void* lpvHeader, uint dwHdrSize, void* lpvData, uint dwBufSize);
    ///Returns the number of bytes needed to save the header.
    ///Params:
    ///    dwHdrSize = Size, in bytes.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The size was successfully returned.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetHeaderSize(uint* dwHdrSize);
    ///Returns the number of bytes needed to save the property data.
    ///Params:
    ///    lpvHeader = Pointer to a buffer containing the header.
    ///    dwHdrSize = Size of the header buffer.
    ///    dwDataSize = Size in bytes.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The size was successfully returned.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>lpvHeader</i> parameter is NULL, or <i>dwHdrSize</i> is too small. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_BADVALUE</b></dt> </dl> </td> <td width="60%"> Invalid header buffer. </td> </tr> </table>
    ///    
    HRESULT GetDataSize(void* lpvHeader, uint dwHdrSize, uint* dwDataSize);
    HRESULT SaveDataToStream(void* lpvHeader, uint dwHdrSize, IStream pStream);
    HRESULT LoadFromMem(void* lpvData, uint dwBufSize);
    HRESULT SaveToMem(void* lpvData, uint dwBufSize);
}

///Use this interface for opening and closing the database object, and for instantiating objects stored in the database.
interface IITDatabase : IUnknown
{
    ///Opens a database.
    ///Params:
    ///    lpszHost = Host name. You can pass NULL if calling the <b>Open</b> method locally, otherwise this string should contain
    ///               the host description string, described below.
    ///    lpszMoniker = Name of database file to open. This should include the full path to the file name, if calling locally. If
    ///                  calling using HTTP, this should contain the ISAPI extension DLL name followed by the relative path to the
    ///                  database file, for example: <code>isapiext.dll?path1\path2\db.its</code>
    ///    dwFlags = Currently not used.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The database was successfully opened.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>STG_E*</b></dt> </dl> </td> <td width="60%"> IStorage interface
    ///    errors that can occur as storage is opened. </td> </tr> </table>
    ///    
    HRESULT Open(const(PWSTR) lpszHost, const(PWSTR) lpszMoniker, uint dwFlags);
    ///Closes a database.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The database was successfully closed.
    ///    </td> </tr> </table>
    ///    
    HRESULT Close();
    ///Creates an unnamed object you can reference in the future through the *<i>pdwObjInstance</i> parameter.
    ///Params:
    ///    rclsid = Class ID for object.
    ///    pdwObjInstance = Identifier for object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The object was successfully created.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The argument
    ///    was not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTINIT</b></dt> </dl> </td> <td width="60%">
    ///    The database has not been opened. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
    ///    </td> <td width="60%"> The memory required for internal structures could not be allocated. </td> </tr>
    ///    </table>
    ///    
    HRESULT CreateObject(const(GUID)* rclsid, uint* pdwObjInstance);
    HRESULT GetObjectA(uint dwObjInstance, const(GUID)* riid, void** ppvObj);
    HRESULT GetObjectPersistence(const(PWSTR) lpwszObject, uint dwObjInstance, void** ppvPersistence, BOOL fStream);
}

///Use this interface to perform word wheel keyword lookups. The <b>Lookup</b> method offers several ways of performing
///a search: it returns either an exact match, or the closest approximation based on a given prefix.
interface IITWordWheel : IUnknown
{
    ///Opens a word wheel.
    ///Params:
    ///    lpITDB = Pointer to database object.
    ///    lpszMoniker = Name of word wheel.
    ///    dwFlags = One or more of the following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///              width="40%"><a id="ITWW_OPEN_CONNECT"></a><a id="itww_open_connect"></a><dl>
    ///              <dt><b>ITWW_OPEN_CONNECT</b></dt> </dl> </td> <td width="60%"> <div class="alert"><b>Note</b> If the word
    ///              wheel resides on a remote computer, connect to the computer during this call to retrieve initialization data.
    ///              Otherwise the connection is delayed until the first API call that requires this data.</div> <div> </div>
    ///              </td> </tr> </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The word wheel was successfully
    ///    opened. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ALREADYOPEN</b></dt> </dl> </td> <td width="60%">
    ///    Word wheel is already open. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td>
    ///    <td width="60%"> The IITDatabase* interface or <i>lpszMoniker</i> parameter was NULL. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>STG_E*</b></dt> </dl> </td> <td width="60%"> IStorage interface errors that can
    ///    occur as storage is opened. </td> </tr> </table>
    ///    
    HRESULT Open(IITDatabase lpITDB, const(PWSTR) lpszMoniker, uint dwFlags);
    ///Closes a word wheel.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The word wheel was successfully
    ///    closed. </td> </tr> </table>
    ///    
    HRESULT Close();
    HRESULT GetLocaleInfoA(uint* pdwCodePageID, uint* plcid);
    HRESULT GetSorterInstance(uint* pdwObjInstance);
    ///Returns the number of entries in a word wheel.
    ///Params:
    ///    pcEntries = Number of entries in word wheel.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The count was successfully returned.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTOPEN</b></dt> </dl> </td> <td width="60%"> The word wheel
    ///    has not been opened. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> The <i>pcEntries</i> parameter was an invalid pointer. </td> </tr> </table>
    ///    
    HRESULT Count(int* pcEntries);
    HRESULT Lookup(int lEntry, void* lpvKeyBuf, uint cbKeyBuf);
    HRESULT Lookup(int lEntry, IITResultSet lpITResult, int cEntries);
    HRESULT Lookup(const(void)* lpcvPrefix, BOOL fExactMatch, int* plEntry);
    HRESULT SetGroup(IITGroup* piitGroup);
    HRESULT GetGroup(IITGroup** ppiitGroup);
    HRESULT GetDataCount(int lEntry, uint* pdwCount);
    HRESULT GetData(int lEntry, IITResultSet lpITResult);
    HRESULT GetDataColumns(IITResultSet pRS);
}

interface IStemSink : IUnknown
{
    HRESULT PutAltWord(const(PWSTR) pwcInBuf, uint cwc);
    HRESULT PutWord(const(PWSTR) pwcInBuf, uint cwc);
}

///Use this interface to provide configuration information that controls stemming.
interface IStemmerConfig : IUnknown
{
    HRESULT SetLocaleInfoA(uint dwCodePageID, uint lcid);
    HRESULT GetLocaleInfoA(uint* pdwCodePageID, uint* plcid);
    HRESULT SetControlInfo(uint grfStemFlags, uint dwReserved);
    HRESULT GetControlInfo(uint* pgrfStemFlags, uint* pdwReserved);
    HRESULT LoadExternalStemmerData(IStream pStream, uint dwExtDataType);
}

interface IWordBreakerConfig : IUnknown
{
    HRESULT SetLocaleInfoA(uint dwCodePageID, uint lcid);
    HRESULT GetLocaleInfoA(uint* pdwCodePageID, uint* plcid);
    HRESULT SetBreakWordType(uint dwBreakWordType);
    HRESULT GetBreakWordType(uint* pdwBreakWordType);
    HRESULT SetControlInfo(uint grfBreakFlags, uint dwReserved);
    HRESULT GetControlInfo(uint* pgrfBreakFlags, uint* pdwReserved);
    HRESULT LoadExternalBreakerData(IStream pStream, uint dwExtDataType);
    HRESULT SetWordStemmer(const(GUID)* rclsid, IStemmer pStemmer);
    HRESULT GetWordStemmer(IStemmer* ppStemmer);
}

///Use this interface in run-time applications to initialize, build, and obtain information about result sets.
interface IITResultSet : IUnknown
{
    HRESULT SetColumnPriority(int lColumnIndex, PRIORITY ColumnPriority);
    HRESULT SetColumnHeap(int lColumnIndex, void* lpvHeap, PFNCOLHEAPFREE pfnColHeapFree);
    HRESULT SetKeyProp(uint PropID);
    HRESULT Add(void* lpvHdr);
    HRESULT Add(uint PropID, void* lpvDefaultData, uint cbData, PRIORITY Priority);
    HRESULT Add(uint PropID, const(PWSTR) lpszwDefault, PRIORITY Priority);
    HRESULT Add(uint PropID, uint dwDefaultData, PRIORITY Priority);
    HRESULT Append(void* lpvHdr, void* lpvData);
    HRESULT Set(int lRowIndex, void* lpvHdr, void* lpvData);
    HRESULT Set(int lRowIndex, int lColumnIndex, size_t dwData);
    HRESULT Set(int lRowIndex, int lColumnIndex, const(PWSTR) lpwStr);
    HRESULT Set(int lRowIndex, int lColumnIndex, void* lpvData, uint cbData);
    HRESULT Copy(IITResultSet pRSCopy);
    HRESULT AppendRows(IITResultSet pResSrc, int lRowSrcFirst, int cSrcRows, int* lRowFirstDest);
    ///Gets the property in the specified row and column and fills the given property object.
    ///Params:
    ///    lRowIndex = Row where property belongs.
    ///    lColumnIndex = 
    ///    Prop = Column where property belongs.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The row was successfully retrieved.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTEXIST</b></dt> </dl> </td> <td width="60%"> The row or
    ///    column does not exist in the row set. </td> </tr> </table>
    ///    
    HRESULT Get(int lRowIndex, int lColumnIndex, CProperty* Prop);
    HRESULT GetKeyProp(uint* KeyPropID);
    HRESULT GetColumnPriority(int lColumnIndex, PRIORITY* ColumnPriority);
    ///Gets the number of rows in a result set.
    ///Params:
    ///    lNumberOfRows = Number of rows.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The number of rows was successfully
    ///    retrieved. </td> </tr> </table>
    ///    
    HRESULT GetRowCount(int* lNumberOfRows);
    HRESULT GetColumnCount(int* lNumberOfColumns);
    HRESULT GetColumn(int lColumnIndex, uint* PropID);
    HRESULT GetColumn(int lColumnIndex, uint* PropID, uint* dwType, void** lpvDefaultValue, uint* cbSize, 
                      PRIORITY* ColumnPriority);
    HRESULT GetColumnFromPropID(uint PropID, int* lColumnIndex);
    HRESULT Clear();
    HRESULT ClearRows();
    HRESULT Free();
    HRESULT IsCompleted();
    HRESULT Cancel();
    HRESULT Pause(BOOL fPause);
    HRESULT GetRowStatus(int lRowFirst, int cRows, ROWSTATUS* lpRowStatus);
    HRESULT GetColumnStatus(COLUMNSTATUS* lpColStatus);
}


