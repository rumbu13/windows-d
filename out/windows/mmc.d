module windows.mmc;

public import windows.core;
public import windows.automation : BSTR, IDispatch, VARIANT;
public import windows.com : HRESULT, IDataObject, IEnumString, IUnknown;
public import windows.controls : HPROPSHEETPAGE;
public import windows.gdi : HBITMAP, HICON, HPALETTE;
public import windows.legacywindowsenvironmentfeatures : _ColumnSortOrder;
public import windows.systemservices : BOOL, LRESULT;
public import windows.windowsandmessaging : HWND, LPARAM;

extern(Windows):


// Enums


enum : int
{
    MMC_PROPACT_DELETING    = 0x00000001,
    MMC_PROPACT_CHANGING    = 0x00000002,
    MMC_PROPACT_INITIALIZED = 0x00000003,
}
alias MMC_PROPERTY_ACTION = int;

enum : int
{
    DocumentMode_Author   = 0x00000000,
    DocumentMode_User     = 0x00000001,
    DocumentMode_User_MDI = 0x00000002,
    DocumentMode_User_SDI = 0x00000003,
}
alias _DocumentMode = int;

enum : int
{
    ListMode_Small_Icons = 0x00000000,
    ListMode_Large_Icons = 0x00000001,
    ListMode_List        = 0x00000002,
    ListMode_Detail      = 0x00000003,
    ListMode_Filtered    = 0x00000004,
}
alias _ListViewMode = int;

enum : int
{
    ViewOption_Default          = 0x00000000,
    ViewOption_ScopeTreeHidden  = 0x00000001,
    ViewOption_NoToolBars       = 0x00000002,
    ViewOption_NotPersistable   = 0x00000004,
    ViewOption_ActionPaneHidden = 0x00000008,
}
alias _ViewOptions = int;

enum : int
{
    ExportListOptions_Default           = 0x00000000,
    ExportListOptions_Unicode           = 0x00000001,
    ExportListOptions_TabDelimited      = 0x00000002,
    ExportListOptions_SelectedItemsOnly = 0x00000004,
}
alias _ExportListOptions = int;

enum : int
{
    MMC_SINGLESEL          = 0x00000001,
    MMC_SHOWSELALWAYS      = 0x00000002,
    MMC_NOSORTHEADER       = 0x00000004,
    MMC_ENSUREFOCUSVISIBLE = 0x00000008,
}
alias MMC_RESULT_VIEW_STYLE = int;

enum : int
{
    TOOLBAR     = 0x00000000,
    MENUBUTTON  = 0x00000001,
    COMBOBOXBAR = 0x00000002,
}
alias MMC_CONTROL_TYPE = int;

enum : int
{
    MMC_VERB_NONE       = 0x00000000,
    MMC_VERB_OPEN       = 0x00008000,
    MMC_VERB_COPY       = 0x00008001,
    MMC_VERB_PASTE      = 0x00008002,
    MMC_VERB_DELETE     = 0x00008003,
    MMC_VERB_PROPERTIES = 0x00008004,
    MMC_VERB_RENAME     = 0x00008005,
    MMC_VERB_REFRESH    = 0x00008006,
    MMC_VERB_PRINT      = 0x00008007,
    MMC_VERB_CUT        = 0x00008008,
    MMC_VERB_MAX        = 0x00008009,
    MMC_VERB_FIRST      = 0x00008000,
    MMC_VERB_LAST       = 0x00008008,
}
alias MMC_CONSOLE_VERB = int;

enum : int
{
    ENABLED       = 0x00000001,
    CHECKED       = 0x00000002,
    HIDDEN        = 0x00000004,
    INDETERMINATE = 0x00000008,
    BUTTONPRESSED = 0x00000010,
}
alias MMC_BUTTON_STATE = int;

enum : int
{
    MMC_SCOPE_ITEM_STATE_NORMAL       = 0x00000001,
    MMC_SCOPE_ITEM_STATE_BOLD         = 0x00000002,
    MMC_SCOPE_ITEM_STATE_EXPANDEDONCE = 0x00000003,
}
alias MMC_SCOPE_ITEM_STATE = int;

enum : int
{
    MMCC_STANDARD_VIEW_SELECT = 0xffffffff,
}
alias MMC_MENU_COMMAND_IDS = int;

enum : int
{
    MMC_STRING_FILTER  = 0x00000000,
    MMC_INT_FILTER     = 0x00000001,
    MMC_FILTER_NOVALUE = 0x00008000,
}
alias MMC_FILTER_TYPE = int;

enum : int
{
    MFCC_DISABLE      = 0x00000000,
    MFCC_ENABLE       = 0x00000001,
    MFCC_VALUE_CHANGE = 0x00000002,
}
alias MMC_FILTER_CHANGE_CODE = int;

enum : int
{
    MMCN_ACTIVATE           = 0x00008001,
    MMCN_ADD_IMAGES         = 0x00008002,
    MMCN_BTN_CLICK          = 0x00008003,
    MMCN_CLICK              = 0x00008004,
    MMCN_COLUMN_CLICK       = 0x00008005,
    MMCN_CONTEXTMENU        = 0x00008006,
    MMCN_CUTORMOVE          = 0x00008007,
    MMCN_DBLCLICK           = 0x00008008,
    MMCN_DELETE             = 0x00008009,
    MMCN_DESELECT_ALL       = 0x0000800a,
    MMCN_EXPAND             = 0x0000800b,
    MMCN_HELP               = 0x0000800c,
    MMCN_MENU_BTNCLICK      = 0x0000800d,
    MMCN_MINIMIZED          = 0x0000800e,
    MMCN_PASTE              = 0x0000800f,
    MMCN_PROPERTY_CHANGE    = 0x00008010,
    MMCN_QUERY_PASTE        = 0x00008011,
    MMCN_REFRESH            = 0x00008012,
    MMCN_REMOVE_CHILDREN    = 0x00008013,
    MMCN_RENAME             = 0x00008014,
    MMCN_SELECT             = 0x00008015,
    MMCN_SHOW               = 0x00008016,
    MMCN_VIEW_CHANGE        = 0x00008017,
    MMCN_SNAPINHELP         = 0x00008018,
    MMCN_CONTEXTHELP        = 0x00008019,
    MMCN_INITOCX            = 0x0000801a,
    MMCN_FILTER_CHANGE      = 0x0000801b,
    MMCN_FILTERBTN_CLICK    = 0x0000801c,
    MMCN_RESTORE_VIEW       = 0x0000801d,
    MMCN_PRINT              = 0x0000801e,
    MMCN_PRELOAD            = 0x0000801f,
    MMCN_LISTPAD            = 0x00008020,
    MMCN_EXPANDSYNC         = 0x00008021,
    MMCN_COLUMNS_CHANGED    = 0x00008022,
    MMCN_CANPASTE_OUTOFPROC = 0x00008023,
}
alias MMC_NOTIFY_TYPE = int;

enum : int
{
    CCT_SCOPE          = 0x00008000,
    CCT_RESULT         = 0x00008001,
    CCT_SNAPIN_MANAGER = 0x00008002,
    CCT_UNINITIALIZED  = 0x0000ffff,
}
alias DATA_OBJECT_TYPES = int;

enum : int
{
    CCM_INSERTIONPOINTID_MASK_SPECIAL        = 0xffff0000,
    CCM_INSERTIONPOINTID_MASK_SHARED         = 0x80000000,
    CCM_INSERTIONPOINTID_MASK_CREATE_PRIMARY = 0x40000000,
    CCM_INSERTIONPOINTID_MASK_ADD_PRIMARY    = 0x20000000,
    CCM_INSERTIONPOINTID_MASK_ADD_3RDPARTY   = 0x10000000,
    CCM_INSERTIONPOINTID_MASK_RESERVED       = 0x0fff0000,
    CCM_INSERTIONPOINTID_MASK_FLAGINDEX      = 0x0000001f,
    CCM_INSERTIONPOINTID_PRIMARY_TOP         = 0xa0000000,
    CCM_INSERTIONPOINTID_PRIMARY_NEW         = 0xa0000001,
    CCM_INSERTIONPOINTID_PRIMARY_TASK        = 0xa0000002,
    CCM_INSERTIONPOINTID_PRIMARY_VIEW        = 0xa0000003,
    CCM_INSERTIONPOINTID_PRIMARY_HELP        = 0xa0000004,
    CCM_INSERTIONPOINTID_3RDPARTY_NEW        = 0x90000001,
    CCM_INSERTIONPOINTID_3RDPARTY_TASK       = 0x90000002,
    CCM_INSERTIONPOINTID_ROOT_MENU           = 0x80000000,
}
alias __MIDL___MIDL_itf_mmc_0000_0006_0001 = int;

enum : int
{
    CCM_INSERTIONALLOWED_TOP  = 0x00000001,
    CCM_INSERTIONALLOWED_NEW  = 0x00000002,
    CCM_INSERTIONALLOWED_TASK = 0x00000004,
    CCM_INSERTIONALLOWED_VIEW = 0x00000008,
}
alias __MIDL___MIDL_itf_mmc_0000_0006_0002 = int;

enum : int
{
    CCM_COMMANDID_MASK_RESERVED = 0xffff0000,
}
alias __MIDL___MIDL_itf_mmc_0000_0006_0003 = int;

enum : int
{
    CCM_SPECIAL_SEPARATOR       = 0x00000001,
    CCM_SPECIAL_SUBMENU         = 0x00000002,
    CCM_SPECIAL_DEFAULT_ITEM    = 0x00000004,
    CCM_SPECIAL_INSERTION_POINT = 0x00000008,
    CCM_SPECIAL_TESTONLY        = 0x00000010,
}
alias __MIDL___MIDL_itf_mmc_0000_0006_0004 = int;

enum : int
{
    MMC_TASK_DISPLAY_UNINITIALIZED      = 0x00000000,
    MMC_TASK_DISPLAY_TYPE_SYMBOL        = 0x00000001,
    MMC_TASK_DISPLAY_TYPE_VANILLA_GIF   = 0x00000002,
    MMC_TASK_DISPLAY_TYPE_CHOCOLATE_GIF = 0x00000003,
    MMC_TASK_DISPLAY_TYPE_BITMAP        = 0x00000004,
}
alias MMC_TASK_DISPLAY_TYPE = int;

enum : int
{
    MMC_ACTION_UNINITIALIZED = 0xffffffff,
    MMC_ACTION_ID            = 0x00000000,
    MMC_ACTION_LINK          = 0x00000001,
    MMC_ACTION_SCRIPT        = 0x00000002,
}
alias MMC_ACTION_TYPE = int;

enum IconIdentifier : int
{
    Icon_None        = 0x00000000,
    Icon_Error       = 0x00007f01,
    Icon_Question    = 0x00007f02,
    Icon_Warning     = 0x00007f03,
    Icon_Information = 0x00007f04,
    Icon_First       = 0x00007f01,
    Icon_Last        = 0x00007f04,
}

enum : int
{
    MMC_VIEW_TYPE_LIST = 0x00000000,
    MMC_VIEW_TYPE_HTML = 0x00000001,
    MMC_VIEW_TYPE_OCX  = 0x00000002,
}
alias MMC_VIEW_TYPE = int;

// Structs


struct MMC_SNAPIN_PROPERTY
{
    ushort*             pszPropName;
    VARIANT             varValue;
    MMC_PROPERTY_ACTION eAction;
}

struct MMCBUTTON
{
    int     nBitmap;
    int     idCommand;
    ubyte   fsState;
    ubyte   fsType;
    ushort* lpButtonText;
    ushort* lpTooltipText;
}

struct RESULTDATAITEM
{
    uint      mask;
    BOOL      bScopeItem;
    ptrdiff_t itemID;
    int       nIndex;
    int       nCol;
    ushort*   str;
    int       nImage;
    uint      nState;
    LPARAM    lParam;
    int       iIndent;
}

struct RESULTFINDINFO
{
    ushort* psz;
    int     nStart;
    uint    dwOptions;
}

struct SCOPEDATAITEM
{
    uint      mask;
    ushort*   displayname;
    int       nImage;
    int       nOpenImage;
    uint      nState;
    int       cChildren;
    LPARAM    lParam;
    ptrdiff_t relativeID;
    ptrdiff_t ID;
}

struct CONTEXTMENUITEM
{
    const(wchar)* strName;
    const(wchar)* strStatusBarText;
    int           lCommandID;
    int           lInsertionPointID;
    int           fFlags;
    int           fSpecialFlags;
}

struct MENUBUTTONDATA
{
    int idCommand;
    int x;
    int y;
}

struct MMC_FILTERDATA
{
    ushort* pszText;
    int     cchTextMax;
    int     lValue;
}

struct MMC_RESTORE_VIEW
{
    uint      dwSize;
    ptrdiff_t cookie;
    ushort*   pViewType;
    int       lViewOptions;
}

struct MMC_EXPANDSYNC_STRUCT
{
    BOOL      bHandled;
    BOOL      bExpanding;
    ptrdiff_t hItem;
}

struct MMC_VISIBLE_COLUMNS
{
    int    nVisibleColumns;
    int[1] rgVisibleCols;
}

struct SMMCDataObjects
{
    uint           count;
    IDataObject[1] lpDataObject;
}

struct SMMCObjectTypes
{
    uint    count;
    GUID[1] guid;
}

struct SNodeID
{
    uint     cBytes;
    ubyte[1] id;
}

struct SNodeID2
{
    uint     dwFlags;
    uint     cBytes;
    ubyte[1] id;
}

struct SColumnSetID
{
    uint     dwFlags;
    uint     cBytes;
    ubyte[1] id;
}

struct MMC_TASK_DISPLAY_SYMBOL
{
    ushort* szFontFamilyName;
    ushort* szURLtoEOT;
    ushort* szSymbolString;
}

struct MMC_TASK_DISPLAY_BITMAP
{
    ushort* szMouseOverBitmap;
    ushort* szMouseOffBitmap;
}

struct MMC_TASK_DISPLAY_OBJECT
{
    MMC_TASK_DISPLAY_TYPE eDisplayType;
    union
    {
        MMC_TASK_DISPLAY_BITMAP uBitmap;
        MMC_TASK_DISPLAY_SYMBOL uSymbol;
    }
}

struct MMC_TASK
{
    MMC_TASK_DISPLAY_OBJECT sDisplayObject;
    ushort*         szText;
    ushort*         szHelpString;
    MMC_ACTION_TYPE eActionType;
    union
    {
        ptrdiff_t nCommandID;
        ushort*   szActionURL;
        ushort*   szScript;
    }
}

struct MMC_LISTPAD_INFO
{
    ushort*   szTitle;
    ushort*   szButtonText;
    ptrdiff_t nCommandID;
}

struct MMC_COLUMN_DATA
{
    int    nColIndex;
    uint   dwFlags;
    int    nWidth;
    size_t ulReserved;
}

struct MMC_COLUMN_SET_DATA
{
    int              cbSize;
    int              nNumCols;
    MMC_COLUMN_DATA* pColData;
}

struct MMC_SORT_DATA
{
    int    nColIndex;
    uint   dwSortOptions;
    size_t ulReserved;
}

struct MMC_SORT_SET_DATA
{
    int            cbSize;
    int            nNumItems;
    MMC_SORT_DATA* pSortData;
}

struct RDITEMHDR
{
    uint      dwFlags;
    ptrdiff_t cookie;
    LPARAM    lpReserved;
}

struct RDCOMPARE
{
    uint       cbSize;
    uint       dwFlags;
    int        nColumn;
    LPARAM     lUserParam;
    RDITEMHDR* prdch1;
    RDITEMHDR* prdch2;
}

struct RESULT_VIEW_TYPE_INFO
{
    ushort*       pstrPersistableViewDescription;
    MMC_VIEW_TYPE eViewType;
    uint          dwMiscOptions;
    union
    {
        uint dwListOptions;
        struct
        {
            uint    dwHTMLOptions;
            ushort* pstrURL;
        }
        struct
        {
            uint     dwOCXOptions;
            IUnknown pUnkControl;
        }
    }
}

struct CONTEXTMENUITEM2
{
    const(wchar)* strName;
    const(wchar)* strStatusBarText;
    int           lCommandID;
    int           lInsertionPointID;
    int           fFlags;
    int           fSpecialFlags;
    const(wchar)* strLanguageIndependentName;
}

struct MMC_EXT_VIEW_DATA
{
    GUID    viewID;
    ushort* pszURL;
    ushort* pszViewTitle;
    ushort* pszTooltipText;
    BOOL    bReplacesDefaultView;
}

// Interfaces

@GUID("49B2791A-B1AE-4C90-9B8E-E860BA07F889")
struct Application;

@GUID("ADE6444B-C91F-4E37-92A4-5BB430A33340")
struct AppEventsDHTMLConnector;

@GUID("D6FEDB1D-CF21-4BD9-AF3B-C5468E9C6684")
struct MMCVersionInfo;

@GUID("F0285374-DFF1-11D3-B433-00C04F8ECD78")
struct ConsolePower;

@GUID("F7889DA9-4A02-4837-BF89-1A6F2A021010")
interface ISnapinProperties : IUnknown
{
    HRESULT Initialize(Properties pProperties);
    HRESULT QueryPropertyNames(ISnapinPropertiesCallback pCallback);
    HRESULT PropertiesChanged(int cProperties, char* pProperties);
}

@GUID("A50FA2E5-7E61-45EB-A8D4-9A07B3E851A8")
interface ISnapinPropertiesCallback : IUnknown
{
    HRESULT AddPropertyName(ushort* pszPropName, uint dwFlags);
}

@GUID("A3AFB9CC-B653-4741-86AB-F0470EC1384C")
interface _Application : IDispatch
{
    void    Help();
    void    Quit();
    HRESULT get_Document(Document* Document);
    HRESULT Load(BSTR Filename);
    HRESULT get_Frame(Frame* Frame);
    HRESULT get_Visible(int* Visible);
    HRESULT Show();
    HRESULT Hide();
    HRESULT get_UserControl(int* UserControl);
    HRESULT put_UserControl(BOOL UserControl);
    HRESULT get_VersionMajor(int* VersionMajor);
    HRESULT get_VersionMinor(int* VersionMinor);
}

@GUID("DE46CBDD-53F5-4635-AF54-4FE71E923D3F")
interface _AppEvents : IDispatch
{
    HRESULT OnQuit(_Application Application);
    HRESULT OnDocumentOpen(Document Document, BOOL New);
    HRESULT OnDocumentClose(Document Document);
    HRESULT OnSnapInAdded(Document Document, SnapIn SnapIn);
    HRESULT OnSnapInRemoved(Document Document, SnapIn SnapIn);
    HRESULT OnNewView(View View);
    HRESULT OnViewClose(View View);
    HRESULT OnViewChange(View View, Node NewOwnerNode);
    HRESULT OnSelectionChange(View View, Nodes NewNodes);
    HRESULT OnContextMenuExecuted(MenuItem MenuItem);
    HRESULT OnToolbarButtonClicked();
    HRESULT OnListUpdated(View View);
}

@GUID("FC7A4252-78AC-4532-8C5A-563CFE138863")
interface AppEvents : IDispatch
{
}

@GUID("C0BCCD30-DE44-4528-8403-A05A6A1CC8EA")
interface _EventConnector : IDispatch
{
    HRESULT ConnectTo(_Application Application);
    HRESULT Disconnect();
}

@GUID("E5E2D970-5BB3-4306-8804-B0968A31C8E6")
interface Frame : IDispatch
{
    HRESULT Maximize();
    HRESULT Minimize();
    HRESULT Restore();
    HRESULT get_Top(int* Top);
    HRESULT put_Top(int top);
    HRESULT get_Bottom(int* Bottom);
    HRESULT put_Bottom(int bottom);
    HRESULT get_Left(int* Left);
    HRESULT put_Left(int left);
    HRESULT get_Right(int* Right);
    HRESULT put_Right(int right);
}

@GUID("F81ED800-7839-4447-945D-8E15DA59CA55")
interface Node : IDispatch
{
    HRESULT get_Name(ushort** Name);
    HRESULT get_Property(BSTR PropertyName, ushort** PropertyValue);
    HRESULT get_Bookmark(ushort** Bookmark);
    HRESULT IsScopeNode(int* IsScopeNode);
    HRESULT get_Nodetype(ushort** Nodetype);
}

@GUID("EBBB48DC-1A3B-4D86-B786-C21B28389012")
interface ScopeNamespace : IDispatch
{
    HRESULT GetParent(Node Node, Node* Parent);
    HRESULT GetChild(Node Node, Node* Child);
    HRESULT GetNext(Node Node, Node* Next);
    HRESULT GetRoot(Node* Root);
    HRESULT Expand(Node Node);
}

@GUID("225120D6-1E0F-40A3-93FE-1079E6A8017B")
interface Document : IDispatch
{
    HRESULT Save();
    HRESULT SaveAs(BSTR Filename);
    HRESULT Close(BOOL SaveChanges);
    HRESULT get_Views(Views* Views);
    HRESULT get_SnapIns(SnapIns* SnapIns);
    HRESULT get_ActiveView(View* View);
    HRESULT get_Name(ushort** Name);
    HRESULT put_Name(BSTR Name);
    HRESULT get_Location(ushort** Location);
    HRESULT get_IsSaved(int* IsSaved);
    HRESULT get_Mode(_DocumentMode* Mode);
    HRESULT put_Mode(_DocumentMode Mode);
    HRESULT get_RootNode(Node* Node);
    HRESULT get_ScopeNamespace(ScopeNamespace* ScopeNamespace);
    HRESULT CreateProperties(Properties* Properties);
    HRESULT get_Application(_Application* Application);
}

@GUID("3BE910F6-3459-49C6-A1BB-41E6BE9DF3EA")
interface SnapIn : IDispatch
{
    HRESULT get_Name(ushort** Name);
    HRESULT get_Vendor(ushort** Vendor);
    HRESULT get_Version(ushort** Version);
    HRESULT get_Extensions(Extensions* Extensions);
    HRESULT get_SnapinCLSID(ushort** SnapinCLSID);
    HRESULT get_Properties(Properties* Properties);
    HRESULT EnableAllExtensions(BOOL Enable);
}

@GUID("2EF3DE1D-B12A-49D1-92C5-0B00798768F1")
interface SnapIns : IDispatch
{
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Item(int Index, SnapIn* SnapIn);
    HRESULT get_Count(int* Count);
    HRESULT Add(BSTR SnapinNameOrCLSID, VARIANT ParentSnapin, VARIANT Properties, SnapIn* SnapIn);
    HRESULT Remove(SnapIn SnapIn);
}

@GUID("AD4D6CA6-912F-409B-A26E-7FD234AEF542")
interface Extension : IDispatch
{
    HRESULT get_Name(ushort** Name);
    HRESULT get_Vendor(ushort** Vendor);
    HRESULT get_Version(ushort** Version);
    HRESULT get_Extensions(Extensions* Extensions);
    HRESULT get_SnapinCLSID(ushort** SnapinCLSID);
    HRESULT EnableAllExtensions(BOOL Enable);
    HRESULT Enable(BOOL Enable);
}

@GUID("82DBEA43-8CA4-44BC-A2CA-D18741059EC8")
interface Extensions : IDispatch
{
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Item(int Index, Extension* Extension);
    HRESULT get_Count(int* Count);
}

@GUID("383D4D97-FC44-478B-B139-6323DC48611C")
interface Columns : IDispatch
{
    HRESULT Item(int Index, Column* Column);
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* retval);
}

@GUID("FD1C5F63-2B16-4D06-9AB3-F45350B940AB")
interface Column : IDispatch
{
    HRESULT Name(BSTR* Name);
    HRESULT get_Width(int* Width);
    HRESULT put_Width(int Width);
    HRESULT get_DisplayPosition(int* DisplayPosition);
    HRESULT put_DisplayPosition(int Index);
    HRESULT get_Hidden(int* Hidden);
    HRESULT put_Hidden(BOOL Hidden);
    HRESULT SetAsSortColumn(_ColumnSortOrder SortOrder);
    HRESULT IsSortColumn(int* IsSortColumn);
}

@GUID("D6B8C29D-A1FF-4D72-AAB0-E381E9B9338D")
interface Views : IDispatch
{
    HRESULT Item(int Index, View* View);
    HRESULT get_Count(int* Count);
    HRESULT Add(Node Node, _ViewOptions viewOptions);
    HRESULT get__NewEnum(IUnknown* retval);
}

@GUID("6EFC2DA2-B38C-457E-9ABB-ED2D189B8C38")
interface View : IDispatch
{
    HRESULT get_ActiveScopeNode(Node* Node);
    HRESULT put_ActiveScopeNode(Node Node);
    HRESULT get_Selection(Nodes* Nodes);
    HRESULT get_ListItems(Nodes* Nodes);
    HRESULT SnapinScopeObject(VARIANT ScopeNode, IDispatch* ScopeNodeObject);
    HRESULT SnapinSelectionObject(IDispatch* SelectionObject);
    HRESULT Is(View View, short* TheSame);
    HRESULT get_Document(Document* Document);
    HRESULT SelectAll();
    HRESULT Select(Node Node);
    HRESULT Deselect(Node Node);
    HRESULT IsSelected(Node Node, int* IsSelected);
    HRESULT DisplayScopeNodePropertySheet(VARIANT ScopeNode);
    HRESULT DisplaySelectionPropertySheet();
    HRESULT CopyScopeNode(VARIANT ScopeNode);
    HRESULT CopySelection();
    HRESULT DeleteScopeNode(VARIANT ScopeNode);
    HRESULT DeleteSelection();
    HRESULT RenameScopeNode(BSTR NewName, VARIANT ScopeNode);
    HRESULT RenameSelectedItem(BSTR NewName);
    HRESULT get_ScopeNodeContextMenu(VARIANT ScopeNode, ContextMenu* ContextMenu);
    HRESULT get_SelectionContextMenu(ContextMenu* ContextMenu);
    HRESULT RefreshScopeNode(VARIANT ScopeNode);
    HRESULT RefreshSelection();
    HRESULT ExecuteSelectionMenuItem(BSTR MenuItemPath);
    HRESULT ExecuteScopeNodeMenuItem(BSTR MenuItemPath, VARIANT ScopeNode);
    HRESULT ExecuteShellCommand(BSTR Command, BSTR Directory, BSTR Parameters, BSTR WindowState);
    HRESULT get_Frame(Frame* Frame);
    HRESULT Close();
    HRESULT get_ScopeTreeVisible(int* Visible);
    HRESULT put_ScopeTreeVisible(BOOL Visible);
    HRESULT Back();
    HRESULT Forward();
    HRESULT put_StatusBarText(BSTR StatusBarText);
    HRESULT get_Memento(ushort** Memento);
    HRESULT ViewMemento(BSTR Memento);
    HRESULT get_Columns(Columns* Columns);
    HRESULT get_CellContents(Node Node, int Column, ushort** CellContents);
    HRESULT ExportList(BSTR File, _ExportListOptions exportoptions);
    HRESULT get_ListViewMode(_ListViewMode* Mode);
    HRESULT put_ListViewMode(_ListViewMode mode);
    HRESULT get_ControlObject(IDispatch* Control);
}

@GUID("313B01DF-B22F-4D42-B1B8-483CDCF51D35")
interface Nodes : IDispatch
{
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Item(int Index, Node* Node);
    HRESULT get_Count(int* Count);
}

@GUID("DAB39CE0-25E6-4E07-8362-BA9C95706545")
interface ContextMenu : IDispatch
{
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Item(VARIANT IndexOrPath, MenuItem* MenuItem);
    HRESULT get_Count(int* Count);
}

@GUID("0178FAD1-B361-4B27-96AD-67C57EBF2E1D")
interface MenuItem : IDispatch
{
    HRESULT get_DisplayName(ushort** DisplayName);
    HRESULT get_LanguageIndependentName(ushort** LanguageIndependentName);
    HRESULT get_Path(ushort** Path);
    HRESULT get_LanguageIndependentPath(ushort** LanguageIndependentPath);
    HRESULT Execute();
    HRESULT get_Enabled(int* Enabled);
}

@GUID("2886ABC2-A425-42B2-91C6-E25C0E04581C")
interface Properties : IDispatch
{
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Item(BSTR Name, Property* Property);
    HRESULT get_Count(int* Count);
    HRESULT Remove(BSTR Name);
}

@GUID("4600C3A5-E301-41D8-B6D0-EF2E4212E0CA")
interface Property : IDispatch
{
    HRESULT get_Value(VARIANT* Value);
    HRESULT put_Value(VARIANT Value);
    HRESULT get_Name(ushort** Name);
}

@GUID("955AB28A-5218-11D0-A985-00C04FD8D565")
interface IComponentData : IUnknown
{
    HRESULT Initialize(IUnknown pUnknown);
    HRESULT CreateComponent(IComponent* ppComponent);
    HRESULT Notify(IDataObject lpDataObject, MMC_NOTIFY_TYPE event, LPARAM arg, LPARAM param3);
    HRESULT Destroy();
    HRESULT QueryDataObject(ptrdiff_t cookie, DATA_OBJECT_TYPES type, IDataObject* ppDataObject);
    HRESULT GetDisplayInfo(SCOPEDATAITEM* pScopeDataItem);
    HRESULT CompareObjects(IDataObject lpDataObjectA, IDataObject lpDataObjectB);
}

@GUID("43136EB2-D36C-11CF-ADBC-00AA00A80033")
interface IComponent : IUnknown
{
    HRESULT Initialize(IConsole lpConsole);
    HRESULT Notify(IDataObject lpDataObject, MMC_NOTIFY_TYPE event, LPARAM arg, LPARAM param3);
    HRESULT Destroy(ptrdiff_t cookie);
    HRESULT QueryDataObject(ptrdiff_t cookie, DATA_OBJECT_TYPES type, IDataObject* ppDataObject);
    HRESULT GetResultViewType(ptrdiff_t cookie, ushort** ppViewType, int* pViewOptions);
    HRESULT GetDisplayInfo(RESULTDATAITEM* pResultDataItem);
    HRESULT CompareObjects(IDataObject lpDataObjectA, IDataObject lpDataObjectB);
}

@GUID("E8315A52-7A1A-11D0-A2D2-00C04FD909DD")
interface IResultDataCompare : IUnknown
{
    HRESULT Compare(LPARAM lUserParam, ptrdiff_t cookieA, ptrdiff_t cookieB, int* pnResult);
}

@GUID("9CB396D8-EA83-11D0-AEF1-00C04FB6DD2C")
interface IResultOwnerData : IUnknown
{
    HRESULT FindItem(RESULTFINDINFO* pFindInfo, int* pnFoundIndex);
    HRESULT CacheHint(int nStartIndex, int nEndIndex);
    HRESULT SortItems(int nColumn, uint dwSortOptions, LPARAM lUserParam);
}

@GUID("43136EB1-D36C-11CF-ADBC-00AA00A80033")
interface IConsole : IUnknown
{
    HRESULT SetHeader(IHeaderCtrl pHeader);
    HRESULT SetToolbar(IToolbar pToolbar);
    HRESULT QueryResultView(IUnknown* pUnknown);
    HRESULT QueryScopeImageList(IImageList* ppImageList);
    HRESULT QueryResultImageList(IImageList* ppImageList);
    HRESULT UpdateAllViews(IDataObject lpDataObject, LPARAM data, ptrdiff_t hint);
    HRESULT MessageBoxA(const(wchar)* lpszText, const(wchar)* lpszTitle, uint fuStyle, int* piRetval);
    HRESULT QueryConsoleVerb(IConsoleVerb* ppConsoleVerb);
    HRESULT SelectScopeItem(ptrdiff_t hScopeItem);
    HRESULT GetMainWindow(HWND* phwnd);
    HRESULT NewWindow(ptrdiff_t hScopeItem, uint lOptions);
}

@GUID("43136EB3-D36C-11CF-ADBC-00AA00A80033")
interface IHeaderCtrl : IUnknown
{
    HRESULT InsertColumn(int nCol, const(wchar)* title, int nFormat, int nWidth);
    HRESULT DeleteColumn(int nCol);
    HRESULT SetColumnText(int nCol, const(wchar)* title);
    HRESULT GetColumnText(int nCol, ushort** pText);
    HRESULT SetColumnWidth(int nCol, int nWidth);
    HRESULT GetColumnWidth(int nCol, int* pWidth);
}

@GUID("43136EB7-D36C-11CF-ADBC-00AA00A80033")
interface IContextMenuCallback : IUnknown
{
    HRESULT AddItem(CONTEXTMENUITEM* pItem);
}

@GUID("43136EB6-D36C-11CF-ADBC-00AA00A80033")
interface IContextMenuProvider : IContextMenuCallback
{
    HRESULT EmptyMenuList();
    HRESULT AddPrimaryExtensionItems(IUnknown piExtension, IDataObject piDataObject);
    HRESULT AddThirdPartyExtensionItems(IDataObject piDataObject);
    HRESULT ShowContextMenu(HWND hwndParent, int xPos, int yPos, int* plSelected);
}

@GUID("4F3B7A4F-CFAC-11CF-B8E3-00C04FD8D5B0")
interface IExtendContextMenu : IUnknown
{
    HRESULT AddMenuItems(IDataObject piDataObject, IContextMenuCallback piCallback, int* pInsertionAllowed);
    HRESULT Command(int lCommandID, IDataObject piDataObject);
}

@GUID("43136EB8-D36C-11CF-ADBC-00AA00A80033")
interface IImageList : IUnknown
{
    HRESULT ImageListSetIcon(ptrdiff_t* pIcon, int nLoc);
    HRESULT ImageListSetStrip(ptrdiff_t* pBMapSm, ptrdiff_t* pBMapLg, int nStartLoc, uint cMask);
}

@GUID("31DA5FA0-E0EB-11CF-9F21-00AA003CA9F6")
interface IResultData : IUnknown
{
    HRESULT InsertItem(RESULTDATAITEM* item);
    HRESULT DeleteItem(ptrdiff_t itemID, int nCol);
    HRESULT FindItemByLParam(LPARAM lParam, ptrdiff_t* pItemID);
    HRESULT DeleteAllRsltItems();
    HRESULT SetItem(RESULTDATAITEM* item);
    HRESULT GetItem(RESULTDATAITEM* item);
    HRESULT GetNextItem(RESULTDATAITEM* item);
    HRESULT ModifyItemState(int nIndex, ptrdiff_t itemID, uint uAdd, uint uRemove);
    HRESULT ModifyViewStyle(MMC_RESULT_VIEW_STYLE add, MMC_RESULT_VIEW_STYLE remove);
    HRESULT SetViewMode(int lViewMode);
    HRESULT GetViewMode(int* lViewMode);
    HRESULT UpdateItem(ptrdiff_t itemID);
    HRESULT Sort(int nColumn, uint dwSortOptions, LPARAM lUserParam);
    HRESULT SetDescBarText(ushort* DescText);
    HRESULT SetItemCount(int nItemCount, uint dwOptions);
}

@GUID("BEDEB620-F24D-11CF-8AFC-00AA003CA9F6")
interface IConsoleNameSpace : IUnknown
{
    HRESULT InsertItem(SCOPEDATAITEM* item);
    HRESULT DeleteItem(ptrdiff_t hItem, int fDeleteThis);
    HRESULT SetItem(SCOPEDATAITEM* item);
    HRESULT GetItem(SCOPEDATAITEM* item);
    HRESULT GetChildItem(ptrdiff_t item, ptrdiff_t* pItemChild, ptrdiff_t* pCookie);
    HRESULT GetNextItem(ptrdiff_t item, ptrdiff_t* pItemNext, ptrdiff_t* pCookie);
    HRESULT GetParentItem(ptrdiff_t item, ptrdiff_t* pItemParent, ptrdiff_t* pCookie);
}

@GUID("255F18CC-65DB-11D1-A7DC-00C04FD8D565")
interface IConsoleNameSpace2 : IConsoleNameSpace
{
    HRESULT Expand(ptrdiff_t hItem);
    HRESULT AddExtension(ptrdiff_t hItem, GUID* lpClsid);
}

@GUID("85DE64DD-EF21-11CF-A285-00C04FD8DBE6")
interface IPropertySheetCallback : IUnknown
{
    HRESULT AddPage(HPROPSHEETPAGE hPage);
    HRESULT RemovePage(HPROPSHEETPAGE hPage);
}

@GUID("85DE64DE-EF21-11CF-A285-00C04FD8DBE6")
interface IPropertySheetProvider : IUnknown
{
    HRESULT CreatePropertySheet(const(wchar)* title, ubyte type, ptrdiff_t cookie, IDataObject pIDataObjectm, 
                                uint dwOptions);
    HRESULT FindPropertySheet(ptrdiff_t hItem, IComponent lpComponent, IDataObject lpDataObject);
    HRESULT AddPrimaryPages(IUnknown lpUnknown, BOOL bCreateHandle, HWND hNotifyWindow, BOOL bScopePane);
    HRESULT AddExtensionPages();
    HRESULT Show(ptrdiff_t window, int page);
}

@GUID("85DE64DC-EF21-11CF-A285-00C04FD8DBE6")
interface IExtendPropertySheet : IUnknown
{
    HRESULT CreatePropertyPages(IPropertySheetCallback lpProvider, ptrdiff_t handle, IDataObject lpIDataObject);
    HRESULT QueryPagesFor(IDataObject lpDataObject);
}

@GUID("69FB811E-6C1C-11D0-A2CB-00C04FD909DD")
interface IControlbar : IUnknown
{
    HRESULT Create(MMC_CONTROL_TYPE nType, IExtendControlbar pExtendControlbar, IUnknown* ppUnknown);
    HRESULT Attach(MMC_CONTROL_TYPE nType, IUnknown lpUnknown);
    HRESULT Detach(IUnknown lpUnknown);
}

@GUID("49506520-6F40-11D0-A98B-00C04FD8D565")
interface IExtendControlbar : IUnknown
{
    HRESULT SetControlbar(IControlbar pControlbar);
    HRESULT ControlbarNotify(MMC_NOTIFY_TYPE event, LPARAM arg, LPARAM param2);
}

@GUID("43136EB9-D36C-11CF-ADBC-00AA00A80033")
interface IToolbar : IUnknown
{
    HRESULT AddBitmap(int nImages, HBITMAP hbmp, int cxSize, int cySize, uint crMask);
    HRESULT AddButtons(int nButtons, MMCBUTTON* lpButtons);
    HRESULT InsertButton(int nIndex, MMCBUTTON* lpButton);
    HRESULT DeleteButton(int nIndex);
    HRESULT GetButtonState(int idCommand, MMC_BUTTON_STATE nState, int* pState);
    HRESULT SetButtonState(int idCommand, MMC_BUTTON_STATE nState, BOOL bState);
}

@GUID("E49F7A60-74AF-11D0-A286-00C04FD8FE93")
interface IConsoleVerb : IUnknown
{
    HRESULT GetVerbState(MMC_CONSOLE_VERB eCmdID, MMC_BUTTON_STATE nState, int* pState);
    HRESULT SetVerbState(MMC_CONSOLE_VERB eCmdID, MMC_BUTTON_STATE nState, BOOL bState);
    HRESULT SetDefaultVerb(MMC_CONSOLE_VERB eCmdID);
    HRESULT GetDefaultVerb(MMC_CONSOLE_VERB* peCmdID);
}

@GUID("1245208C-A151-11D0-A7D7-00C04FD909DD")
interface ISnapinAbout : IUnknown
{
    HRESULT GetSnapinDescription(ushort** lpDescription);
    HRESULT GetProvider(ushort** lpName);
    HRESULT GetSnapinVersion(ushort** lpVersion);
    HRESULT GetSnapinImage(HICON* hAppIcon);
    HRESULT GetStaticFolderImage(HBITMAP* hSmallImage, HBITMAP* hSmallImageOpen, HBITMAP* hLargeImage, uint* cMask);
}

@GUID("951ED750-D080-11D0-B197-000000000000")
interface IMenuButton : IUnknown
{
    HRESULT AddButton(int idCommand, ushort* lpButtonText, ushort* lpTooltipText);
    HRESULT SetButton(int idCommand, ushort* lpButtonText, ushort* lpTooltipText);
    HRESULT SetButtonState(int idCommand, MMC_BUTTON_STATE nState, BOOL bState);
}

@GUID("A6B15ACE-DF59-11D0-A7DD-00C04FD909DD")
interface ISnapinHelp : IUnknown
{
    HRESULT GetHelpTopic(ushort** lpCompiledHelpFile);
}

@GUID("B7A87232-4A51-11D1-A7EA-00C04FD909DD")
interface IExtendPropertySheet2 : IExtendPropertySheet
{
    HRESULT GetWatermarks(IDataObject lpIDataObject, HBITMAP* lphWatermark, HBITMAP* lphHeader, 
                          HPALETTE* lphPalette, int* bStretch);
}

@GUID("9757ABB8-1B32-11D1-A7CE-00C04FD8D565")
interface IHeaderCtrl2 : IHeaderCtrl
{
    HRESULT SetChangeTimeOut(uint uTimeout);
    HRESULT SetColumnFilter(uint nColumn, uint dwType, MMC_FILTERDATA* pFilterData);
    HRESULT GetColumnFilter(uint nColumn, uint* pdwType, MMC_FILTERDATA* pFilterData);
}

@GUID("4861A010-20F9-11D2-A510-00C04FB6DD2C")
interface ISnapinHelp2 : ISnapinHelp
{
    HRESULT GetLinkedTopics(ushort** lpCompiledHelpFiles);
}

@GUID("338698B1-5A02-11D1-9FEC-00600832DB4A")
interface IEnumTASK : IUnknown
{
    HRESULT Next(uint celt, MMC_TASK* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumTASK* ppenum);
}

@GUID("8DEE6511-554D-11D1-9FEA-00600832DB4A")
interface IExtendTaskPad : IUnknown
{
    HRESULT TaskNotify(IDataObject pdo, VARIANT* arg, VARIANT* param2);
    HRESULT EnumTasks(IDataObject pdo, ushort* szTaskGroup, IEnumTASK* ppEnumTASK);
    HRESULT GetTitle(ushort* pszGroup, ushort** pszTitle);
    HRESULT GetDescriptiveText(ushort* pszGroup, ushort** pszDescriptiveText);
    HRESULT GetBackground(ushort* pszGroup, MMC_TASK_DISPLAY_OBJECT* pTDO);
    HRESULT GetListPadInfo(ushort* pszGroup, MMC_LISTPAD_INFO* lpListPadInfo);
}

@GUID("103D842A-AA63-11D1-A7E1-00C04FD8D565")
interface IConsole2 : IConsole
{
    HRESULT Expand(ptrdiff_t hItem, BOOL bExpand);
    HRESULT IsTaskpadViewPreferred();
    HRESULT SetStatusText(ushort* pszStatusText);
}

@GUID("CC593830-B926-11D1-8063-0000F875A9CE")
interface IDisplayHelp : IUnknown
{
    HRESULT ShowTopic(ushort* pszHelpTopic);
}

@GUID("72782D7A-A4A0-11D1-AF0F-00C04FB6DD2C")
interface IRequiredExtensions : IUnknown
{
    HRESULT EnableAllExtensions();
    HRESULT GetFirstExtension(GUID* pExtCLSID);
    HRESULT GetNextExtension(GUID* pExtCLSID);
}

@GUID("DE40B7A4-0F65-11D2-8E25-00C04F8ECD78")
interface IStringTable : IUnknown
{
    HRESULT AddString(ushort* pszAdd, uint* pStringID);
    HRESULT GetString(uint StringID, uint cchBuffer, char* lpBuffer, uint* pcchOut);
    HRESULT GetStringLength(uint StringID, uint* pcchString);
    HRESULT DeleteString(uint StringID);
    HRESULT DeleteAllStrings();
    HRESULT FindString(ushort* pszFind, uint* pStringID);
    HRESULT Enumerate(IEnumString* ppEnum);
}

@GUID("547C1354-024D-11D3-A707-00C04F8EF4CB")
interface IColumnData : IUnknown
{
    HRESULT SetColumnConfigData(SColumnSetID* pColID, MMC_COLUMN_SET_DATA* pColSetData);
    HRESULT GetColumnConfigData(SColumnSetID* pColID, MMC_COLUMN_SET_DATA** ppColSetData);
    HRESULT SetColumnSortData(SColumnSetID* pColID, MMC_SORT_SET_DATA* pColSortData);
    HRESULT GetColumnSortData(SColumnSetID* pColID, MMC_SORT_SET_DATA** ppColSortData);
}

@GUID("80F94174-FCCC-11D2-B991-00C04F8ECD78")
interface IMessageView : IUnknown
{
    HRESULT SetTitleText(ushort* pszTitleText);
    HRESULT SetBodyText(ushort* pszBodyText);
    HRESULT SetIcon(IconIdentifier id);
    HRESULT Clear();
}

@GUID("96933476-0251-11D3-AEB0-00C04F8ECD78")
interface IResultDataCompareEx : IUnknown
{
    HRESULT Compare(RDCOMPARE* prdc, int* pnResult);
}

@GUID("CCA0F2D2-82DE-41B5-BF47-3B2076273D5C")
interface IComponentData2 : IComponentData
{
    HRESULT QueryDispatch(ptrdiff_t cookie, DATA_OBJECT_TYPES type, IDispatch* ppDispatch);
}

@GUID("79A2D615-4A10-4ED4-8C65-8633F9335095")
interface IComponent2 : IComponent
{
    HRESULT QueryDispatch(ptrdiff_t cookie, DATA_OBJECT_TYPES type, IDispatch* ppDispatch);
    HRESULT GetResultViewType2(ptrdiff_t cookie, RESULT_VIEW_TYPE_INFO* pResultViewType);
    HRESULT RestoreResultView(ptrdiff_t cookie, RESULT_VIEW_TYPE_INFO* pResultViewType);
}

@GUID("E178BC0E-2ED0-4B5E-8097-42C9087E8B33")
interface IContextMenuCallback2 : IUnknown
{
    HRESULT AddItem(CONTEXTMENUITEM2* pItem);
}

@GUID("A8D2C5FE-CDCB-4B9D-BDE5-A27343FF54BC")
interface IMMCVersionInfo : IUnknown
{
    HRESULT GetMMCVersion(int* pVersionMajor, int* pVersionMinor);
}

@GUID("89995CEE-D2ED-4C0E-AE5E-DF7E76F3FA53")
interface IExtendView : IUnknown
{
    HRESULT GetViews(IDataObject pDataObject, IViewExtensionCallback pViewExtensionCallback);
}

@GUID("34DD928A-7599-41E5-9F5E-D6BC3062C2DA")
interface IViewExtensionCallback : IUnknown
{
    HRESULT AddView(MMC_EXT_VIEW_DATA* pExtViewData);
}

@GUID("1CFBDD0E-62CA-49CE-A3AF-DBB2DE61B068")
interface IConsolePower : IUnknown
{
    HRESULT SetExecutionState(uint dwAdd, uint dwRemove);
    HRESULT ResetIdleTimer(uint dwFlags);
}

@GUID("3333759F-FE4F-4975-B143-FEC0A5DD6D65")
interface IConsolePowerSink : IUnknown
{
    HRESULT OnPowerBroadcast(uint nEvent, LPARAM lParam, LRESULT* plReturn);
}

@GUID("15BC4D24-A522-4406-AA55-0749537A6865")
interface INodeProperties : IUnknown
{
    HRESULT GetProperty(IDataObject pDataObject, BSTR szPropertyName, ushort** pbstrProperty);
}

@GUID("4F85EFDB-D0E1-498C-8D4A-D010DFDD404F")
interface IConsole3 : IConsole2
{
    HRESULT RenameScopeItem(ptrdiff_t hScopeItem);
}

@GUID("0F36E0EB-A7F1-4A81-BE5A-9247F7DE4B1B")
interface IResultData2 : IResultData
{
    HRESULT RenameResultItem(ptrdiff_t itemID);
}


// GUIDs

const GUID CLSID_AppEventsDHTMLConnector = GUIDOF!AppEventsDHTMLConnector;
const GUID CLSID_Application             = GUIDOF!Application;
const GUID CLSID_ConsolePower            = GUIDOF!ConsolePower;
const GUID CLSID_MMCVersionInfo          = GUIDOF!MMCVersionInfo;

const GUID IID_AppEvents                 = GUIDOF!AppEvents;
const GUID IID_Column                    = GUIDOF!Column;
const GUID IID_Columns                   = GUIDOF!Columns;
const GUID IID_ContextMenu               = GUIDOF!ContextMenu;
const GUID IID_Document                  = GUIDOF!Document;
const GUID IID_Extension                 = GUIDOF!Extension;
const GUID IID_Extensions                = GUIDOF!Extensions;
const GUID IID_Frame                     = GUIDOF!Frame;
const GUID IID_IColumnData               = GUIDOF!IColumnData;
const GUID IID_IComponent                = GUIDOF!IComponent;
const GUID IID_IComponent2               = GUIDOF!IComponent2;
const GUID IID_IComponentData            = GUIDOF!IComponentData;
const GUID IID_IComponentData2           = GUIDOF!IComponentData2;
const GUID IID_IConsole                  = GUIDOF!IConsole;
const GUID IID_IConsole2                 = GUIDOF!IConsole2;
const GUID IID_IConsole3                 = GUIDOF!IConsole3;
const GUID IID_IConsoleNameSpace         = GUIDOF!IConsoleNameSpace;
const GUID IID_IConsoleNameSpace2        = GUIDOF!IConsoleNameSpace2;
const GUID IID_IConsolePower             = GUIDOF!IConsolePower;
const GUID IID_IConsolePowerSink         = GUIDOF!IConsolePowerSink;
const GUID IID_IConsoleVerb              = GUIDOF!IConsoleVerb;
const GUID IID_IContextMenuCallback      = GUIDOF!IContextMenuCallback;
const GUID IID_IContextMenuCallback2     = GUIDOF!IContextMenuCallback2;
const GUID IID_IContextMenuProvider      = GUIDOF!IContextMenuProvider;
const GUID IID_IControlbar               = GUIDOF!IControlbar;
const GUID IID_IDisplayHelp              = GUIDOF!IDisplayHelp;
const GUID IID_IEnumTASK                 = GUIDOF!IEnumTASK;
const GUID IID_IExtendContextMenu        = GUIDOF!IExtendContextMenu;
const GUID IID_IExtendControlbar         = GUIDOF!IExtendControlbar;
const GUID IID_IExtendPropertySheet      = GUIDOF!IExtendPropertySheet;
const GUID IID_IExtendPropertySheet2     = GUIDOF!IExtendPropertySheet2;
const GUID IID_IExtendTaskPad            = GUIDOF!IExtendTaskPad;
const GUID IID_IExtendView               = GUIDOF!IExtendView;
const GUID IID_IHeaderCtrl               = GUIDOF!IHeaderCtrl;
const GUID IID_IHeaderCtrl2              = GUIDOF!IHeaderCtrl2;
const GUID IID_IImageList                = GUIDOF!IImageList;
const GUID IID_IMMCVersionInfo           = GUIDOF!IMMCVersionInfo;
const GUID IID_IMenuButton               = GUIDOF!IMenuButton;
const GUID IID_IMessageView              = GUIDOF!IMessageView;
const GUID IID_INodeProperties           = GUIDOF!INodeProperties;
const GUID IID_IPropertySheetCallback    = GUIDOF!IPropertySheetCallback;
const GUID IID_IPropertySheetProvider    = GUIDOF!IPropertySheetProvider;
const GUID IID_IRequiredExtensions       = GUIDOF!IRequiredExtensions;
const GUID IID_IResultData               = GUIDOF!IResultData;
const GUID IID_IResultData2              = GUIDOF!IResultData2;
const GUID IID_IResultDataCompare        = GUIDOF!IResultDataCompare;
const GUID IID_IResultDataCompareEx      = GUIDOF!IResultDataCompareEx;
const GUID IID_IResultOwnerData          = GUIDOF!IResultOwnerData;
const GUID IID_ISnapinAbout              = GUIDOF!ISnapinAbout;
const GUID IID_ISnapinHelp               = GUIDOF!ISnapinHelp;
const GUID IID_ISnapinHelp2              = GUIDOF!ISnapinHelp2;
const GUID IID_ISnapinProperties         = GUIDOF!ISnapinProperties;
const GUID IID_ISnapinPropertiesCallback = GUIDOF!ISnapinPropertiesCallback;
const GUID IID_IStringTable              = GUIDOF!IStringTable;
const GUID IID_IToolbar                  = GUIDOF!IToolbar;
const GUID IID_IViewExtensionCallback    = GUIDOF!IViewExtensionCallback;
const GUID IID_MenuItem                  = GUIDOF!MenuItem;
const GUID IID_Node                      = GUIDOF!Node;
const GUID IID_Nodes                     = GUIDOF!Nodes;
const GUID IID_Properties                = GUIDOF!Properties;
const GUID IID_Property                  = GUIDOF!Property;
const GUID IID_ScopeNamespace            = GUIDOF!ScopeNamespace;
const GUID IID_SnapIn                    = GUIDOF!SnapIn;
const GUID IID_SnapIns                   = GUIDOF!SnapIns;
const GUID IID_View                      = GUIDOF!View;
const GUID IID_Views                     = GUIDOF!Views;
const GUID IID__AppEvents                = GUIDOF!_AppEvents;
const GUID IID__Application              = GUIDOF!_Application;
const GUID IID__EventConnector           = GUIDOF!_EventConnector;
