module windows.mmc;

public import system;
public import windows.automation;
public import windows.com;
public import windows.controls;
public import windows.gdi;
public import windows.legacywindowsenvironmentfeatures;
public import windows.systemservices;
public import windows.windowsandmessaging;

extern(Windows):

const GUID CLSID_Application = {0x49B2791A, 0xB1AE, 0x4C90, [0x9B, 0x8E, 0xE8, 0x60, 0xBA, 0x07, 0xF8, 0x89]};
@GUID(0x49B2791A, 0xB1AE, 0x4C90, [0x9B, 0x8E, 0xE8, 0x60, 0xBA, 0x07, 0xF8, 0x89]);
struct Application;

const GUID CLSID_AppEventsDHTMLConnector = {0xADE6444B, 0xC91F, 0x4E37, [0x92, 0xA4, 0x5B, 0xB4, 0x30, 0xA3, 0x33, 0x40]};
@GUID(0xADE6444B, 0xC91F, 0x4E37, [0x92, 0xA4, 0x5B, 0xB4, 0x30, 0xA3, 0x33, 0x40]);
struct AppEventsDHTMLConnector;

enum MMC_PROPERTY_ACTION
{
    MMC_PROPACT_DELETING = 1,
    MMC_PROPACT_CHANGING = 2,
    MMC_PROPACT_INITIALIZED = 3,
}

struct MMC_SNAPIN_PROPERTY
{
    ushort* pszPropName;
    VARIANT varValue;
    MMC_PROPERTY_ACTION eAction;
}

const GUID IID_ISnapinProperties = {0xF7889DA9, 0x4A02, 0x4837, [0xBF, 0x89, 0x1A, 0x6F, 0x2A, 0x02, 0x10, 0x10]};
@GUID(0xF7889DA9, 0x4A02, 0x4837, [0xBF, 0x89, 0x1A, 0x6F, 0x2A, 0x02, 0x10, 0x10]);
interface ISnapinProperties : IUnknown
{
    HRESULT Initialize(Properties pProperties);
    HRESULT QueryPropertyNames(ISnapinPropertiesCallback pCallback);
    HRESULT PropertiesChanged(int cProperties, char* pProperties);
}

const GUID IID_ISnapinPropertiesCallback = {0xA50FA2E5, 0x7E61, 0x45EB, [0xA8, 0xD4, 0x9A, 0x07, 0xB3, 0xE8, 0x51, 0xA8]};
@GUID(0xA50FA2E5, 0x7E61, 0x45EB, [0xA8, 0xD4, 0x9A, 0x07, 0xB3, 0xE8, 0x51, 0xA8]);
interface ISnapinPropertiesCallback : IUnknown
{
    HRESULT AddPropertyName(ushort* pszPropName, uint dwFlags);
}

enum _DocumentMode
{
    DocumentMode_Author = 0,
    DocumentMode_User = 1,
    DocumentMode_User_MDI = 2,
    DocumentMode_User_SDI = 3,
}

enum _ListViewMode
{
    ListMode_Small_Icons = 0,
    ListMode_Large_Icons = 1,
    ListMode_List = 2,
    ListMode_Detail = 3,
    ListMode_Filtered = 4,
}

enum _ViewOptions
{
    ViewOption_Default = 0,
    ViewOption_ScopeTreeHidden = 1,
    ViewOption_NoToolBars = 2,
    ViewOption_NotPersistable = 4,
    ViewOption_ActionPaneHidden = 8,
}

enum _ExportListOptions
{
    ExportListOptions_Default = 0,
    ExportListOptions_Unicode = 1,
    ExportListOptions_TabDelimited = 2,
    ExportListOptions_SelectedItemsOnly = 4,
}

const GUID IID__Application = {0xA3AFB9CC, 0xB653, 0x4741, [0x86, 0xAB, 0xF0, 0x47, 0x0E, 0xC1, 0x38, 0x4C]};
@GUID(0xA3AFB9CC, 0xB653, 0x4741, [0x86, 0xAB, 0xF0, 0x47, 0x0E, 0xC1, 0x38, 0x4C]);
interface _Application : IDispatch
{
    void Help();
    void Quit();
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

const GUID IID__AppEvents = {0xDE46CBDD, 0x53F5, 0x4635, [0xAF, 0x54, 0x4F, 0xE7, 0x1E, 0x92, 0x3D, 0x3F]};
@GUID(0xDE46CBDD, 0x53F5, 0x4635, [0xAF, 0x54, 0x4F, 0xE7, 0x1E, 0x92, 0x3D, 0x3F]);
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

const GUID IID_AppEvents = {0xFC7A4252, 0x78AC, 0x4532, [0x8C, 0x5A, 0x56, 0x3C, 0xFE, 0x13, 0x88, 0x63]};
@GUID(0xFC7A4252, 0x78AC, 0x4532, [0x8C, 0x5A, 0x56, 0x3C, 0xFE, 0x13, 0x88, 0x63]);
interface AppEvents : IDispatch
{
}

const GUID IID__EventConnector = {0xC0BCCD30, 0xDE44, 0x4528, [0x84, 0x03, 0xA0, 0x5A, 0x6A, 0x1C, 0xC8, 0xEA]};
@GUID(0xC0BCCD30, 0xDE44, 0x4528, [0x84, 0x03, 0xA0, 0x5A, 0x6A, 0x1C, 0xC8, 0xEA]);
interface _EventConnector : IDispatch
{
    HRESULT ConnectTo(_Application Application);
    HRESULT Disconnect();
}

const GUID IID_Frame = {0xE5E2D970, 0x5BB3, 0x4306, [0x88, 0x04, 0xB0, 0x96, 0x8A, 0x31, 0xC8, 0xE6]};
@GUID(0xE5E2D970, 0x5BB3, 0x4306, [0x88, 0x04, 0xB0, 0x96, 0x8A, 0x31, 0xC8, 0xE6]);
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

const GUID IID_Node = {0xF81ED800, 0x7839, 0x4447, [0x94, 0x5D, 0x8E, 0x15, 0xDA, 0x59, 0xCA, 0x55]};
@GUID(0xF81ED800, 0x7839, 0x4447, [0x94, 0x5D, 0x8E, 0x15, 0xDA, 0x59, 0xCA, 0x55]);
interface Node : IDispatch
{
    HRESULT get_Name(ushort** Name);
    HRESULT get_Property(BSTR PropertyName, ushort** PropertyValue);
    HRESULT get_Bookmark(ushort** Bookmark);
    HRESULT IsScopeNode(int* IsScopeNode);
    HRESULT get_Nodetype(ushort** Nodetype);
}

const GUID IID_ScopeNamespace = {0xEBBB48DC, 0x1A3B, 0x4D86, [0xB7, 0x86, 0xC2, 0x1B, 0x28, 0x38, 0x90, 0x12]};
@GUID(0xEBBB48DC, 0x1A3B, 0x4D86, [0xB7, 0x86, 0xC2, 0x1B, 0x28, 0x38, 0x90, 0x12]);
interface ScopeNamespace : IDispatch
{
    HRESULT GetParent(Node Node, Node* Parent);
    HRESULT GetChild(Node Node, Node* Child);
    HRESULT GetNext(Node Node, Node* Next);
    HRESULT GetRoot(Node* Root);
    HRESULT Expand(Node Node);
}

const GUID IID_Document = {0x225120D6, 0x1E0F, 0x40A3, [0x93, 0xFE, 0x10, 0x79, 0xE6, 0xA8, 0x01, 0x7B]};
@GUID(0x225120D6, 0x1E0F, 0x40A3, [0x93, 0xFE, 0x10, 0x79, 0xE6, 0xA8, 0x01, 0x7B]);
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

const GUID IID_SnapIn = {0x3BE910F6, 0x3459, 0x49C6, [0xA1, 0xBB, 0x41, 0xE6, 0xBE, 0x9D, 0xF3, 0xEA]};
@GUID(0x3BE910F6, 0x3459, 0x49C6, [0xA1, 0xBB, 0x41, 0xE6, 0xBE, 0x9D, 0xF3, 0xEA]);
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

const GUID IID_SnapIns = {0x2EF3DE1D, 0xB12A, 0x49D1, [0x92, 0xC5, 0x0B, 0x00, 0x79, 0x87, 0x68, 0xF1]};
@GUID(0x2EF3DE1D, 0xB12A, 0x49D1, [0x92, 0xC5, 0x0B, 0x00, 0x79, 0x87, 0x68, 0xF1]);
interface SnapIns : IDispatch
{
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Item(int Index, SnapIn* SnapIn);
    HRESULT get_Count(int* Count);
    HRESULT Add(BSTR SnapinNameOrCLSID, VARIANT ParentSnapin, VARIANT Properties, SnapIn* SnapIn);
    HRESULT Remove(SnapIn SnapIn);
}

const GUID IID_Extension = {0xAD4D6CA6, 0x912F, 0x409B, [0xA2, 0x6E, 0x7F, 0xD2, 0x34, 0xAE, 0xF5, 0x42]};
@GUID(0xAD4D6CA6, 0x912F, 0x409B, [0xA2, 0x6E, 0x7F, 0xD2, 0x34, 0xAE, 0xF5, 0x42]);
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

const GUID IID_Extensions = {0x82DBEA43, 0x8CA4, 0x44BC, [0xA2, 0xCA, 0xD1, 0x87, 0x41, 0x05, 0x9E, 0xC8]};
@GUID(0x82DBEA43, 0x8CA4, 0x44BC, [0xA2, 0xCA, 0xD1, 0x87, 0x41, 0x05, 0x9E, 0xC8]);
interface Extensions : IDispatch
{
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Item(int Index, Extension* Extension);
    HRESULT get_Count(int* Count);
}

const GUID IID_Columns = {0x383D4D97, 0xFC44, 0x478B, [0xB1, 0x39, 0x63, 0x23, 0xDC, 0x48, 0x61, 0x1C]};
@GUID(0x383D4D97, 0xFC44, 0x478B, [0xB1, 0x39, 0x63, 0x23, 0xDC, 0x48, 0x61, 0x1C]);
interface Columns : IDispatch
{
    HRESULT Item(int Index, Column* Column);
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* retval);
}

const GUID IID_Column = {0xFD1C5F63, 0x2B16, 0x4D06, [0x9A, 0xB3, 0xF4, 0x53, 0x50, 0xB9, 0x40, 0xAB]};
@GUID(0xFD1C5F63, 0x2B16, 0x4D06, [0x9A, 0xB3, 0xF4, 0x53, 0x50, 0xB9, 0x40, 0xAB]);
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

const GUID IID_Views = {0xD6B8C29D, 0xA1FF, 0x4D72, [0xAA, 0xB0, 0xE3, 0x81, 0xE9, 0xB9, 0x33, 0x8D]};
@GUID(0xD6B8C29D, 0xA1FF, 0x4D72, [0xAA, 0xB0, 0xE3, 0x81, 0xE9, 0xB9, 0x33, 0x8D]);
interface Views : IDispatch
{
    HRESULT Item(int Index, View* View);
    HRESULT get_Count(int* Count);
    HRESULT Add(Node Node, _ViewOptions viewOptions);
    HRESULT get__NewEnum(IUnknown* retval);
}

const GUID IID_View = {0x6EFC2DA2, 0xB38C, 0x457E, [0x9A, 0xBB, 0xED, 0x2D, 0x18, 0x9B, 0x8C, 0x38]};
@GUID(0x6EFC2DA2, 0xB38C, 0x457E, [0x9A, 0xBB, 0xED, 0x2D, 0x18, 0x9B, 0x8C, 0x38]);
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

const GUID IID_Nodes = {0x313B01DF, 0xB22F, 0x4D42, [0xB1, 0xB8, 0x48, 0x3C, 0xDC, 0xF5, 0x1D, 0x35]};
@GUID(0x313B01DF, 0xB22F, 0x4D42, [0xB1, 0xB8, 0x48, 0x3C, 0xDC, 0xF5, 0x1D, 0x35]);
interface Nodes : IDispatch
{
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Item(int Index, Node* Node);
    HRESULT get_Count(int* Count);
}

const GUID IID_ContextMenu = {0xDAB39CE0, 0x25E6, 0x4E07, [0x83, 0x62, 0xBA, 0x9C, 0x95, 0x70, 0x65, 0x45]};
@GUID(0xDAB39CE0, 0x25E6, 0x4E07, [0x83, 0x62, 0xBA, 0x9C, 0x95, 0x70, 0x65, 0x45]);
interface ContextMenu : IDispatch
{
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Item(VARIANT IndexOrPath, MenuItem* MenuItem);
    HRESULT get_Count(int* Count);
}

const GUID IID_MenuItem = {0x0178FAD1, 0xB361, 0x4B27, [0x96, 0xAD, 0x67, 0xC5, 0x7E, 0xBF, 0x2E, 0x1D]};
@GUID(0x0178FAD1, 0xB361, 0x4B27, [0x96, 0xAD, 0x67, 0xC5, 0x7E, 0xBF, 0x2E, 0x1D]);
interface MenuItem : IDispatch
{
    HRESULT get_DisplayName(ushort** DisplayName);
    HRESULT get_LanguageIndependentName(ushort** LanguageIndependentName);
    HRESULT get_Path(ushort** Path);
    HRESULT get_LanguageIndependentPath(ushort** LanguageIndependentPath);
    HRESULT Execute();
    HRESULT get_Enabled(int* Enabled);
}

const GUID IID_Properties = {0x2886ABC2, 0xA425, 0x42B2, [0x91, 0xC6, 0xE2, 0x5C, 0x0E, 0x04, 0x58, 0x1C]};
@GUID(0x2886ABC2, 0xA425, 0x42B2, [0x91, 0xC6, 0xE2, 0x5C, 0x0E, 0x04, 0x58, 0x1C]);
interface Properties : IDispatch
{
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT Item(BSTR Name, Property* Property);
    HRESULT get_Count(int* Count);
    HRESULT Remove(BSTR Name);
}

const GUID IID_Property = {0x4600C3A5, 0xE301, 0x41D8, [0xB6, 0xD0, 0xEF, 0x2E, 0x42, 0x12, 0xE0, 0xCA]};
@GUID(0x4600C3A5, 0xE301, 0x41D8, [0xB6, 0xD0, 0xEF, 0x2E, 0x42, 0x12, 0xE0, 0xCA]);
interface Property : IDispatch
{
    HRESULT get_Value(VARIANT* Value);
    HRESULT put_Value(VARIANT Value);
    HRESULT get_Name(ushort** Name);
}

const GUID CLSID_MMCVersionInfo = {0xD6FEDB1D, 0xCF21, 0x4BD9, [0xAF, 0x3B, 0xC5, 0x46, 0x8E, 0x9C, 0x66, 0x84]};
@GUID(0xD6FEDB1D, 0xCF21, 0x4BD9, [0xAF, 0x3B, 0xC5, 0x46, 0x8E, 0x9C, 0x66, 0x84]);
struct MMCVersionInfo;

const GUID CLSID_ConsolePower = {0xF0285374, 0xDFF1, 0x11D3, [0xB4, 0x33, 0x00, 0xC0, 0x4F, 0x8E, 0xCD, 0x78]};
@GUID(0xF0285374, 0xDFF1, 0x11D3, [0xB4, 0x33, 0x00, 0xC0, 0x4F, 0x8E, 0xCD, 0x78]);
struct ConsolePower;

enum MMC_RESULT_VIEW_STYLE
{
    MMC_SINGLESEL = 1,
    MMC_SHOWSELALWAYS = 2,
    MMC_NOSORTHEADER = 4,
    MMC_ENSUREFOCUSVISIBLE = 8,
}

enum MMC_CONTROL_TYPE
{
    TOOLBAR = 0,
    MENUBUTTON = 1,
    COMBOBOXBAR = 2,
}

enum MMC_CONSOLE_VERB
{
    MMC_VERB_NONE = 0,
    MMC_VERB_OPEN = 32768,
    MMC_VERB_COPY = 32769,
    MMC_VERB_PASTE = 32770,
    MMC_VERB_DELETE = 32771,
    MMC_VERB_PROPERTIES = 32772,
    MMC_VERB_RENAME = 32773,
    MMC_VERB_REFRESH = 32774,
    MMC_VERB_PRINT = 32775,
    MMC_VERB_CUT = 32776,
    MMC_VERB_MAX = 32777,
    MMC_VERB_FIRST = 32768,
    MMC_VERB_LAST = 32776,
}

struct MMCBUTTON
{
    int nBitmap;
    int idCommand;
    ubyte fsState;
    ubyte fsType;
    ushort* lpButtonText;
    ushort* lpTooltipText;
}

enum MMC_BUTTON_STATE
{
    ENABLED = 1,
    CHECKED = 2,
    HIDDEN = 4,
    INDETERMINATE = 8,
    BUTTONPRESSED = 16,
}

struct RESULTDATAITEM
{
    uint mask;
    BOOL bScopeItem;
    int itemID;
    int nIndex;
    int nCol;
    ushort* str;
    int nImage;
    uint nState;
    LPARAM lParam;
    int iIndent;
}

struct RESULTFINDINFO
{
    ushort* psz;
    int nStart;
    uint dwOptions;
}

struct SCOPEDATAITEM
{
    uint mask;
    ushort* displayname;
    int nImage;
    int nOpenImage;
    uint nState;
    int cChildren;
    LPARAM lParam;
    int relativeID;
    int ID;
}

enum MMC_SCOPE_ITEM_STATE
{
    MMC_SCOPE_ITEM_STATE_NORMAL = 1,
    MMC_SCOPE_ITEM_STATE_BOLD = 2,
    MMC_SCOPE_ITEM_STATE_EXPANDEDONCE = 3,
}

struct CONTEXTMENUITEM
{
    const(wchar)* strName;
    const(wchar)* strStatusBarText;
    int lCommandID;
    int lInsertionPointID;
    int fFlags;
    int fSpecialFlags;
}

enum MMC_MENU_COMMAND_IDS
{
    MMCC_STANDARD_VIEW_SELECT = -1,
}

struct MENUBUTTONDATA
{
    int idCommand;
    int x;
    int y;
}

enum MMC_FILTER_TYPE
{
    MMC_STRING_FILTER = 0,
    MMC_INT_FILTER = 1,
    MMC_FILTER_NOVALUE = 32768,
}

struct MMC_FILTERDATA
{
    ushort* pszText;
    int cchTextMax;
    int lValue;
}

enum MMC_FILTER_CHANGE_CODE
{
    MFCC_DISABLE = 0,
    MFCC_ENABLE = 1,
    MFCC_VALUE_CHANGE = 2,
}

struct MMC_RESTORE_VIEW
{
    uint dwSize;
    int cookie;
    ushort* pViewType;
    int lViewOptions;
}

struct MMC_EXPANDSYNC_STRUCT
{
    BOOL bHandled;
    BOOL bExpanding;
    int hItem;
}

struct MMC_VISIBLE_COLUMNS
{
    int nVisibleColumns;
    int rgVisibleCols;
}

enum MMC_NOTIFY_TYPE
{
    MMCN_ACTIVATE = 32769,
    MMCN_ADD_IMAGES = 32770,
    MMCN_BTN_CLICK = 32771,
    MMCN_CLICK = 32772,
    MMCN_COLUMN_CLICK = 32773,
    MMCN_CONTEXTMENU = 32774,
    MMCN_CUTORMOVE = 32775,
    MMCN_DBLCLICK = 32776,
    MMCN_DELETE = 32777,
    MMCN_DESELECT_ALL = 32778,
    MMCN_EXPAND = 32779,
    MMCN_HELP = 32780,
    MMCN_MENU_BTNCLICK = 32781,
    MMCN_MINIMIZED = 32782,
    MMCN_PASTE = 32783,
    MMCN_PROPERTY_CHANGE = 32784,
    MMCN_QUERY_PASTE = 32785,
    MMCN_REFRESH = 32786,
    MMCN_REMOVE_CHILDREN = 32787,
    MMCN_RENAME = 32788,
    MMCN_SELECT = 32789,
    MMCN_SHOW = 32790,
    MMCN_VIEW_CHANGE = 32791,
    MMCN_SNAPINHELP = 32792,
    MMCN_CONTEXTHELP = 32793,
    MMCN_INITOCX = 32794,
    MMCN_FILTER_CHANGE = 32795,
    MMCN_FILTERBTN_CLICK = 32796,
    MMCN_RESTORE_VIEW = 32797,
    MMCN_PRINT = 32798,
    MMCN_PRELOAD = 32799,
    MMCN_LISTPAD = 32800,
    MMCN_EXPANDSYNC = 32801,
    MMCN_COLUMNS_CHANGED = 32802,
    MMCN_CANPASTE_OUTOFPROC = 32803,
}

enum DATA_OBJECT_TYPES
{
    CCT_SCOPE = 32768,
    CCT_RESULT = 32769,
    CCT_SNAPIN_MANAGER = 32770,
    CCT_UNINITIALIZED = 65535,
}

struct SMMCDataObjects
{
    uint count;
    IDataObject lpDataObject;
}

struct SMMCObjectTypes
{
    uint count;
    Guid guid;
}

struct SNodeID
{
    uint cBytes;
    ubyte id;
}

struct SNodeID2
{
    uint dwFlags;
    uint cBytes;
    ubyte id;
}

struct SColumnSetID
{
    uint dwFlags;
    uint cBytes;
    ubyte id;
}

const GUID IID_IComponentData = {0x955AB28A, 0x5218, 0x11D0, [0xA9, 0x85, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x65]};
@GUID(0x955AB28A, 0x5218, 0x11D0, [0xA9, 0x85, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x65]);
interface IComponentData : IUnknown
{
    HRESULT Initialize(IUnknown pUnknown);
    HRESULT CreateComponent(IComponent* ppComponent);
    HRESULT Notify(IDataObject lpDataObject, MMC_NOTIFY_TYPE event, LPARAM arg, LPARAM param3);
    HRESULT Destroy();
    HRESULT QueryDataObject(int cookie, DATA_OBJECT_TYPES type, IDataObject* ppDataObject);
    HRESULT GetDisplayInfo(SCOPEDATAITEM* pScopeDataItem);
    HRESULT CompareObjects(IDataObject lpDataObjectA, IDataObject lpDataObjectB);
}

const GUID IID_IComponent = {0x43136EB2, 0xD36C, 0x11CF, [0xAD, 0xBC, 0x00, 0xAA, 0x00, 0xA8, 0x00, 0x33]};
@GUID(0x43136EB2, 0xD36C, 0x11CF, [0xAD, 0xBC, 0x00, 0xAA, 0x00, 0xA8, 0x00, 0x33]);
interface IComponent : IUnknown
{
    HRESULT Initialize(IConsole lpConsole);
    HRESULT Notify(IDataObject lpDataObject, MMC_NOTIFY_TYPE event, LPARAM arg, LPARAM param3);
    HRESULT Destroy(int cookie);
    HRESULT QueryDataObject(int cookie, DATA_OBJECT_TYPES type, IDataObject* ppDataObject);
    HRESULT GetResultViewType(int cookie, ushort** ppViewType, int* pViewOptions);
    HRESULT GetDisplayInfo(RESULTDATAITEM* pResultDataItem);
    HRESULT CompareObjects(IDataObject lpDataObjectA, IDataObject lpDataObjectB);
}

const GUID IID_IResultDataCompare = {0xE8315A52, 0x7A1A, 0x11D0, [0xA2, 0xD2, 0x00, 0xC0, 0x4F, 0xD9, 0x09, 0xDD]};
@GUID(0xE8315A52, 0x7A1A, 0x11D0, [0xA2, 0xD2, 0x00, 0xC0, 0x4F, 0xD9, 0x09, 0xDD]);
interface IResultDataCompare : IUnknown
{
    HRESULT Compare(LPARAM lUserParam, int cookieA, int cookieB, int* pnResult);
}

const GUID IID_IResultOwnerData = {0x9CB396D8, 0xEA83, 0x11D0, [0xAE, 0xF1, 0x00, 0xC0, 0x4F, 0xB6, 0xDD, 0x2C]};
@GUID(0x9CB396D8, 0xEA83, 0x11D0, [0xAE, 0xF1, 0x00, 0xC0, 0x4F, 0xB6, 0xDD, 0x2C]);
interface IResultOwnerData : IUnknown
{
    HRESULT FindItem(RESULTFINDINFO* pFindInfo, int* pnFoundIndex);
    HRESULT CacheHint(int nStartIndex, int nEndIndex);
    HRESULT SortItems(int nColumn, uint dwSortOptions, LPARAM lUserParam);
}

const GUID IID_IConsole = {0x43136EB1, 0xD36C, 0x11CF, [0xAD, 0xBC, 0x00, 0xAA, 0x00, 0xA8, 0x00, 0x33]};
@GUID(0x43136EB1, 0xD36C, 0x11CF, [0xAD, 0xBC, 0x00, 0xAA, 0x00, 0xA8, 0x00, 0x33]);
interface IConsole : IUnknown
{
    HRESULT SetHeader(IHeaderCtrl pHeader);
    HRESULT SetToolbar(IToolbar pToolbar);
    HRESULT QueryResultView(IUnknown* pUnknown);
    HRESULT QueryScopeImageList(IImageList* ppImageList);
    HRESULT QueryResultImageList(IImageList* ppImageList);
    HRESULT UpdateAllViews(IDataObject lpDataObject, LPARAM data, int hint);
    HRESULT MessageBoxA(const(wchar)* lpszText, const(wchar)* lpszTitle, uint fuStyle, int* piRetval);
    HRESULT QueryConsoleVerb(IConsoleVerb* ppConsoleVerb);
    HRESULT SelectScopeItem(int hScopeItem);
    HRESULT GetMainWindow(HWND* phwnd);
    HRESULT NewWindow(int hScopeItem, uint lOptions);
}

const GUID IID_IHeaderCtrl = {0x43136EB3, 0xD36C, 0x11CF, [0xAD, 0xBC, 0x00, 0xAA, 0x00, 0xA8, 0x00, 0x33]};
@GUID(0x43136EB3, 0xD36C, 0x11CF, [0xAD, 0xBC, 0x00, 0xAA, 0x00, 0xA8, 0x00, 0x33]);
interface IHeaderCtrl : IUnknown
{
    HRESULT InsertColumn(int nCol, const(wchar)* title, int nFormat, int nWidth);
    HRESULT DeleteColumn(int nCol);
    HRESULT SetColumnText(int nCol, const(wchar)* title);
    HRESULT GetColumnText(int nCol, ushort** pText);
    HRESULT SetColumnWidth(int nCol, int nWidth);
    HRESULT GetColumnWidth(int nCol, int* pWidth);
}

enum __MIDL___MIDL_itf_mmc_0000_0006_0001
{
    CCM_INSERTIONPOINTID_MASK_SPECIAL = -65536,
    CCM_INSERTIONPOINTID_MASK_SHARED = -2147483648,
    CCM_INSERTIONPOINTID_MASK_CREATE_PRIMARY = 1073741824,
    CCM_INSERTIONPOINTID_MASK_ADD_PRIMARY = 536870912,
    CCM_INSERTIONPOINTID_MASK_ADD_3RDPARTY = 268435456,
    CCM_INSERTIONPOINTID_MASK_RESERVED = 268369920,
    CCM_INSERTIONPOINTID_MASK_FLAGINDEX = 31,
    CCM_INSERTIONPOINTID_PRIMARY_TOP = -1610612736,
    CCM_INSERTIONPOINTID_PRIMARY_NEW = -1610612735,
    CCM_INSERTIONPOINTID_PRIMARY_TASK = -1610612734,
    CCM_INSERTIONPOINTID_PRIMARY_VIEW = -1610612733,
    CCM_INSERTIONPOINTID_PRIMARY_HELP = -1610612732,
    CCM_INSERTIONPOINTID_3RDPARTY_NEW = -1879048191,
    CCM_INSERTIONPOINTID_3RDPARTY_TASK = -1879048190,
    CCM_INSERTIONPOINTID_ROOT_MENU = -2147483648,
}

enum __MIDL___MIDL_itf_mmc_0000_0006_0002
{
    CCM_INSERTIONALLOWED_TOP = 1,
    CCM_INSERTIONALLOWED_NEW = 2,
    CCM_INSERTIONALLOWED_TASK = 4,
    CCM_INSERTIONALLOWED_VIEW = 8,
}

enum __MIDL___MIDL_itf_mmc_0000_0006_0003
{
    CCM_COMMANDID_MASK_RESERVED = -65536,
}

enum __MIDL___MIDL_itf_mmc_0000_0006_0004
{
    CCM_SPECIAL_SEPARATOR = 1,
    CCM_SPECIAL_SUBMENU = 2,
    CCM_SPECIAL_DEFAULT_ITEM = 4,
    CCM_SPECIAL_INSERTION_POINT = 8,
    CCM_SPECIAL_TESTONLY = 16,
}

const GUID IID_IContextMenuCallback = {0x43136EB7, 0xD36C, 0x11CF, [0xAD, 0xBC, 0x00, 0xAA, 0x00, 0xA8, 0x00, 0x33]};
@GUID(0x43136EB7, 0xD36C, 0x11CF, [0xAD, 0xBC, 0x00, 0xAA, 0x00, 0xA8, 0x00, 0x33]);
interface IContextMenuCallback : IUnknown
{
    HRESULT AddItem(CONTEXTMENUITEM* pItem);
}

const GUID IID_IContextMenuProvider = {0x43136EB6, 0xD36C, 0x11CF, [0xAD, 0xBC, 0x00, 0xAA, 0x00, 0xA8, 0x00, 0x33]};
@GUID(0x43136EB6, 0xD36C, 0x11CF, [0xAD, 0xBC, 0x00, 0xAA, 0x00, 0xA8, 0x00, 0x33]);
interface IContextMenuProvider : IContextMenuCallback
{
    HRESULT EmptyMenuList();
    HRESULT AddPrimaryExtensionItems(IUnknown piExtension, IDataObject piDataObject);
    HRESULT AddThirdPartyExtensionItems(IDataObject piDataObject);
    HRESULT ShowContextMenu(HWND hwndParent, int xPos, int yPos, int* plSelected);
}

const GUID IID_IExtendContextMenu = {0x4F3B7A4F, 0xCFAC, 0x11CF, [0xB8, 0xE3, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0xB0]};
@GUID(0x4F3B7A4F, 0xCFAC, 0x11CF, [0xB8, 0xE3, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0xB0]);
interface IExtendContextMenu : IUnknown
{
    HRESULT AddMenuItems(IDataObject piDataObject, IContextMenuCallback piCallback, int* pInsertionAllowed);
    HRESULT Command(int lCommandID, IDataObject piDataObject);
}

const GUID IID_IImageList = {0x43136EB8, 0xD36C, 0x11CF, [0xAD, 0xBC, 0x00, 0xAA, 0x00, 0xA8, 0x00, 0x33]};
@GUID(0x43136EB8, 0xD36C, 0x11CF, [0xAD, 0xBC, 0x00, 0xAA, 0x00, 0xA8, 0x00, 0x33]);
interface IImageList : IUnknown
{
    HRESULT ImageListSetIcon(int* pIcon, int nLoc);
    HRESULT ImageListSetStrip(int* pBMapSm, int* pBMapLg, int nStartLoc, uint cMask);
}

const GUID IID_IResultData = {0x31DA5FA0, 0xE0EB, 0x11CF, [0x9F, 0x21, 0x00, 0xAA, 0x00, 0x3C, 0xA9, 0xF6]};
@GUID(0x31DA5FA0, 0xE0EB, 0x11CF, [0x9F, 0x21, 0x00, 0xAA, 0x00, 0x3C, 0xA9, 0xF6]);
interface IResultData : IUnknown
{
    HRESULT InsertItem(RESULTDATAITEM* item);
    HRESULT DeleteItem(int itemID, int nCol);
    HRESULT FindItemByLParam(LPARAM lParam, int* pItemID);
    HRESULT DeleteAllRsltItems();
    HRESULT SetItem(RESULTDATAITEM* item);
    HRESULT GetItem(RESULTDATAITEM* item);
    HRESULT GetNextItem(RESULTDATAITEM* item);
    HRESULT ModifyItemState(int nIndex, int itemID, uint uAdd, uint uRemove);
    HRESULT ModifyViewStyle(MMC_RESULT_VIEW_STYLE add, MMC_RESULT_VIEW_STYLE remove);
    HRESULT SetViewMode(int lViewMode);
    HRESULT GetViewMode(int* lViewMode);
    HRESULT UpdateItem(int itemID);
    HRESULT Sort(int nColumn, uint dwSortOptions, LPARAM lUserParam);
    HRESULT SetDescBarText(ushort* DescText);
    HRESULT SetItemCount(int nItemCount, uint dwOptions);
}

const GUID IID_IConsoleNameSpace = {0xBEDEB620, 0xF24D, 0x11CF, [0x8A, 0xFC, 0x00, 0xAA, 0x00, 0x3C, 0xA9, 0xF6]};
@GUID(0xBEDEB620, 0xF24D, 0x11CF, [0x8A, 0xFC, 0x00, 0xAA, 0x00, 0x3C, 0xA9, 0xF6]);
interface IConsoleNameSpace : IUnknown
{
    HRESULT InsertItem(SCOPEDATAITEM* item);
    HRESULT DeleteItem(int hItem, int fDeleteThis);
    HRESULT SetItem(SCOPEDATAITEM* item);
    HRESULT GetItem(SCOPEDATAITEM* item);
    HRESULT GetChildItem(int item, int* pItemChild, int* pCookie);
    HRESULT GetNextItem(int item, int* pItemNext, int* pCookie);
    HRESULT GetParentItem(int item, int* pItemParent, int* pCookie);
}

const GUID IID_IConsoleNameSpace2 = {0x255F18CC, 0x65DB, 0x11D1, [0xA7, 0xDC, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x65]};
@GUID(0x255F18CC, 0x65DB, 0x11D1, [0xA7, 0xDC, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x65]);
interface IConsoleNameSpace2 : IConsoleNameSpace
{
    HRESULT Expand(int hItem);
    HRESULT AddExtension(int hItem, Guid* lpClsid);
}

const GUID IID_IPropertySheetCallback = {0x85DE64DD, 0xEF21, 0x11CF, [0xA2, 0x85, 0x00, 0xC0, 0x4F, 0xD8, 0xDB, 0xE6]};
@GUID(0x85DE64DD, 0xEF21, 0x11CF, [0xA2, 0x85, 0x00, 0xC0, 0x4F, 0xD8, 0xDB, 0xE6]);
interface IPropertySheetCallback : IUnknown
{
    HRESULT AddPage(HPROPSHEETPAGE hPage);
    HRESULT RemovePage(HPROPSHEETPAGE hPage);
}

const GUID IID_IPropertySheetProvider = {0x85DE64DE, 0xEF21, 0x11CF, [0xA2, 0x85, 0x00, 0xC0, 0x4F, 0xD8, 0xDB, 0xE6]};
@GUID(0x85DE64DE, 0xEF21, 0x11CF, [0xA2, 0x85, 0x00, 0xC0, 0x4F, 0xD8, 0xDB, 0xE6]);
interface IPropertySheetProvider : IUnknown
{
    HRESULT CreatePropertySheet(const(wchar)* title, ubyte type, int cookie, IDataObject pIDataObjectm, uint dwOptions);
    HRESULT FindPropertySheet(int hItem, IComponent lpComponent, IDataObject lpDataObject);
    HRESULT AddPrimaryPages(IUnknown lpUnknown, BOOL bCreateHandle, HWND hNotifyWindow, BOOL bScopePane);
    HRESULT AddExtensionPages();
    HRESULT Show(int window, int page);
}

const GUID IID_IExtendPropertySheet = {0x85DE64DC, 0xEF21, 0x11CF, [0xA2, 0x85, 0x00, 0xC0, 0x4F, 0xD8, 0xDB, 0xE6]};
@GUID(0x85DE64DC, 0xEF21, 0x11CF, [0xA2, 0x85, 0x00, 0xC0, 0x4F, 0xD8, 0xDB, 0xE6]);
interface IExtendPropertySheet : IUnknown
{
    HRESULT CreatePropertyPages(IPropertySheetCallback lpProvider, int handle, IDataObject lpIDataObject);
    HRESULT QueryPagesFor(IDataObject lpDataObject);
}

const GUID IID_IControlbar = {0x69FB811E, 0x6C1C, 0x11D0, [0xA2, 0xCB, 0x00, 0xC0, 0x4F, 0xD9, 0x09, 0xDD]};
@GUID(0x69FB811E, 0x6C1C, 0x11D0, [0xA2, 0xCB, 0x00, 0xC0, 0x4F, 0xD9, 0x09, 0xDD]);
interface IControlbar : IUnknown
{
    HRESULT Create(MMC_CONTROL_TYPE nType, IExtendControlbar pExtendControlbar, IUnknown* ppUnknown);
    HRESULT Attach(MMC_CONTROL_TYPE nType, IUnknown lpUnknown);
    HRESULT Detach(IUnknown lpUnknown);
}

const GUID IID_IExtendControlbar = {0x49506520, 0x6F40, 0x11D0, [0xA9, 0x8B, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x65]};
@GUID(0x49506520, 0x6F40, 0x11D0, [0xA9, 0x8B, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x65]);
interface IExtendControlbar : IUnknown
{
    HRESULT SetControlbar(IControlbar pControlbar);
    HRESULT ControlbarNotify(MMC_NOTIFY_TYPE event, LPARAM arg, LPARAM param2);
}

const GUID IID_IToolbar = {0x43136EB9, 0xD36C, 0x11CF, [0xAD, 0xBC, 0x00, 0xAA, 0x00, 0xA8, 0x00, 0x33]};
@GUID(0x43136EB9, 0xD36C, 0x11CF, [0xAD, 0xBC, 0x00, 0xAA, 0x00, 0xA8, 0x00, 0x33]);
interface IToolbar : IUnknown
{
    HRESULT AddBitmap(int nImages, HBITMAP hbmp, int cxSize, int cySize, uint crMask);
    HRESULT AddButtons(int nButtons, MMCBUTTON* lpButtons);
    HRESULT InsertButton(int nIndex, MMCBUTTON* lpButton);
    HRESULT DeleteButton(int nIndex);
    HRESULT GetButtonState(int idCommand, MMC_BUTTON_STATE nState, int* pState);
    HRESULT SetButtonState(int idCommand, MMC_BUTTON_STATE nState, BOOL bState);
}

const GUID IID_IConsoleVerb = {0xE49F7A60, 0x74AF, 0x11D0, [0xA2, 0x86, 0x00, 0xC0, 0x4F, 0xD8, 0xFE, 0x93]};
@GUID(0xE49F7A60, 0x74AF, 0x11D0, [0xA2, 0x86, 0x00, 0xC0, 0x4F, 0xD8, 0xFE, 0x93]);
interface IConsoleVerb : IUnknown
{
    HRESULT GetVerbState(MMC_CONSOLE_VERB eCmdID, MMC_BUTTON_STATE nState, int* pState);
    HRESULT SetVerbState(MMC_CONSOLE_VERB eCmdID, MMC_BUTTON_STATE nState, BOOL bState);
    HRESULT SetDefaultVerb(MMC_CONSOLE_VERB eCmdID);
    HRESULT GetDefaultVerb(MMC_CONSOLE_VERB* peCmdID);
}

const GUID IID_ISnapinAbout = {0x1245208C, 0xA151, 0x11D0, [0xA7, 0xD7, 0x00, 0xC0, 0x4F, 0xD9, 0x09, 0xDD]};
@GUID(0x1245208C, 0xA151, 0x11D0, [0xA7, 0xD7, 0x00, 0xC0, 0x4F, 0xD9, 0x09, 0xDD]);
interface ISnapinAbout : IUnknown
{
    HRESULT GetSnapinDescription(ushort** lpDescription);
    HRESULT GetProvider(ushort** lpName);
    HRESULT GetSnapinVersion(ushort** lpVersion);
    HRESULT GetSnapinImage(HICON* hAppIcon);
    HRESULT GetStaticFolderImage(HBITMAP* hSmallImage, HBITMAP* hSmallImageOpen, HBITMAP* hLargeImage, uint* cMask);
}

const GUID IID_IMenuButton = {0x951ED750, 0xD080, 0x11D0, [0xB1, 0x97, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]};
@GUID(0x951ED750, 0xD080, 0x11D0, [0xB1, 0x97, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]);
interface IMenuButton : IUnknown
{
    HRESULT AddButton(int idCommand, ushort* lpButtonText, ushort* lpTooltipText);
    HRESULT SetButton(int idCommand, ushort* lpButtonText, ushort* lpTooltipText);
    HRESULT SetButtonState(int idCommand, MMC_BUTTON_STATE nState, BOOL bState);
}

const GUID IID_ISnapinHelp = {0xA6B15ACE, 0xDF59, 0x11D0, [0xA7, 0xDD, 0x00, 0xC0, 0x4F, 0xD9, 0x09, 0xDD]};
@GUID(0xA6B15ACE, 0xDF59, 0x11D0, [0xA7, 0xDD, 0x00, 0xC0, 0x4F, 0xD9, 0x09, 0xDD]);
interface ISnapinHelp : IUnknown
{
    HRESULT GetHelpTopic(ushort** lpCompiledHelpFile);
}

const GUID IID_IExtendPropertySheet2 = {0xB7A87232, 0x4A51, 0x11D1, [0xA7, 0xEA, 0x00, 0xC0, 0x4F, 0xD9, 0x09, 0xDD]};
@GUID(0xB7A87232, 0x4A51, 0x11D1, [0xA7, 0xEA, 0x00, 0xC0, 0x4F, 0xD9, 0x09, 0xDD]);
interface IExtendPropertySheet2 : IExtendPropertySheet
{
    HRESULT GetWatermarks(IDataObject lpIDataObject, HBITMAP* lphWatermark, HBITMAP* lphHeader, HPALETTE* lphPalette, int* bStretch);
}

const GUID IID_IHeaderCtrl2 = {0x9757ABB8, 0x1B32, 0x11D1, [0xA7, 0xCE, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x65]};
@GUID(0x9757ABB8, 0x1B32, 0x11D1, [0xA7, 0xCE, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x65]);
interface IHeaderCtrl2 : IHeaderCtrl
{
    HRESULT SetChangeTimeOut(uint uTimeout);
    HRESULT SetColumnFilter(uint nColumn, uint dwType, MMC_FILTERDATA* pFilterData);
    HRESULT GetColumnFilter(uint nColumn, uint* pdwType, MMC_FILTERDATA* pFilterData);
}

const GUID IID_ISnapinHelp2 = {0x4861A010, 0x20F9, 0x11D2, [0xA5, 0x10, 0x00, 0xC0, 0x4F, 0xB6, 0xDD, 0x2C]};
@GUID(0x4861A010, 0x20F9, 0x11D2, [0xA5, 0x10, 0x00, 0xC0, 0x4F, 0xB6, 0xDD, 0x2C]);
interface ISnapinHelp2 : ISnapinHelp
{
    HRESULT GetLinkedTopics(ushort** lpCompiledHelpFiles);
}

enum MMC_TASK_DISPLAY_TYPE
{
    MMC_TASK_DISPLAY_UNINITIALIZED = 0,
    MMC_TASK_DISPLAY_TYPE_SYMBOL = 1,
    MMC_TASK_DISPLAY_TYPE_VANILLA_GIF = 2,
    MMC_TASK_DISPLAY_TYPE_CHOCOLATE_GIF = 3,
    MMC_TASK_DISPLAY_TYPE_BITMAP = 4,
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
    _Anonymous_e__Union Anonymous;
}

enum MMC_ACTION_TYPE
{
    MMC_ACTION_UNINITIALIZED = -1,
    MMC_ACTION_ID = 0,
    MMC_ACTION_LINK = 1,
    MMC_ACTION_SCRIPT = 2,
}

struct MMC_TASK
{
    MMC_TASK_DISPLAY_OBJECT sDisplayObject;
    ushort* szText;
    ushort* szHelpString;
    MMC_ACTION_TYPE eActionType;
    _Anonymous_e__Union Anonymous;
}

struct MMC_LISTPAD_INFO
{
    ushort* szTitle;
    ushort* szButtonText;
    int nCommandID;
}

const GUID IID_IEnumTASK = {0x338698B1, 0x5A02, 0x11D1, [0x9F, 0xEC, 0x00, 0x60, 0x08, 0x32, 0xDB, 0x4A]};
@GUID(0x338698B1, 0x5A02, 0x11D1, [0x9F, 0xEC, 0x00, 0x60, 0x08, 0x32, 0xDB, 0x4A]);
interface IEnumTASK : IUnknown
{
    HRESULT Next(uint celt, MMC_TASK* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumTASK* ppenum);
}

const GUID IID_IExtendTaskPad = {0x8DEE6511, 0x554D, 0x11D1, [0x9F, 0xEA, 0x00, 0x60, 0x08, 0x32, 0xDB, 0x4A]};
@GUID(0x8DEE6511, 0x554D, 0x11D1, [0x9F, 0xEA, 0x00, 0x60, 0x08, 0x32, 0xDB, 0x4A]);
interface IExtendTaskPad : IUnknown
{
    HRESULT TaskNotify(IDataObject pdo, VARIANT* arg, VARIANT* param2);
    HRESULT EnumTasks(IDataObject pdo, ushort* szTaskGroup, IEnumTASK* ppEnumTASK);
    HRESULT GetTitle(ushort* pszGroup, ushort** pszTitle);
    HRESULT GetDescriptiveText(ushort* pszGroup, ushort** pszDescriptiveText);
    HRESULT GetBackground(ushort* pszGroup, MMC_TASK_DISPLAY_OBJECT* pTDO);
    HRESULT GetListPadInfo(ushort* pszGroup, MMC_LISTPAD_INFO* lpListPadInfo);
}

const GUID IID_IConsole2 = {0x103D842A, 0xAA63, 0x11D1, [0xA7, 0xE1, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x65]};
@GUID(0x103D842A, 0xAA63, 0x11D1, [0xA7, 0xE1, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x65]);
interface IConsole2 : IConsole
{
    HRESULT Expand(int hItem, BOOL bExpand);
    HRESULT IsTaskpadViewPreferred();
    HRESULT SetStatusText(ushort* pszStatusText);
}

const GUID IID_IDisplayHelp = {0xCC593830, 0xB926, 0x11D1, [0x80, 0x63, 0x00, 0x00, 0xF8, 0x75, 0xA9, 0xCE]};
@GUID(0xCC593830, 0xB926, 0x11D1, [0x80, 0x63, 0x00, 0x00, 0xF8, 0x75, 0xA9, 0xCE]);
interface IDisplayHelp : IUnknown
{
    HRESULT ShowTopic(ushort* pszHelpTopic);
}

const GUID IID_IRequiredExtensions = {0x72782D7A, 0xA4A0, 0x11D1, [0xAF, 0x0F, 0x00, 0xC0, 0x4F, 0xB6, 0xDD, 0x2C]};
@GUID(0x72782D7A, 0xA4A0, 0x11D1, [0xAF, 0x0F, 0x00, 0xC0, 0x4F, 0xB6, 0xDD, 0x2C]);
interface IRequiredExtensions : IUnknown
{
    HRESULT EnableAllExtensions();
    HRESULT GetFirstExtension(Guid* pExtCLSID);
    HRESULT GetNextExtension(Guid* pExtCLSID);
}

const GUID IID_IStringTable = {0xDE40B7A4, 0x0F65, 0x11D2, [0x8E, 0x25, 0x00, 0xC0, 0x4F, 0x8E, 0xCD, 0x78]};
@GUID(0xDE40B7A4, 0x0F65, 0x11D2, [0x8E, 0x25, 0x00, 0xC0, 0x4F, 0x8E, 0xCD, 0x78]);
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

struct MMC_COLUMN_DATA
{
    int nColIndex;
    uint dwFlags;
    int nWidth;
    uint ulReserved;
}

struct MMC_COLUMN_SET_DATA
{
    int cbSize;
    int nNumCols;
    MMC_COLUMN_DATA* pColData;
}

struct MMC_SORT_DATA
{
    int nColIndex;
    uint dwSortOptions;
    uint ulReserved;
}

struct MMC_SORT_SET_DATA
{
    int cbSize;
    int nNumItems;
    MMC_SORT_DATA* pSortData;
}

const GUID IID_IColumnData = {0x547C1354, 0x024D, 0x11D3, [0xA7, 0x07, 0x00, 0xC0, 0x4F, 0x8E, 0xF4, 0xCB]};
@GUID(0x547C1354, 0x024D, 0x11D3, [0xA7, 0x07, 0x00, 0xC0, 0x4F, 0x8E, 0xF4, 0xCB]);
interface IColumnData : IUnknown
{
    HRESULT SetColumnConfigData(SColumnSetID* pColID, MMC_COLUMN_SET_DATA* pColSetData);
    HRESULT GetColumnConfigData(SColumnSetID* pColID, MMC_COLUMN_SET_DATA** ppColSetData);
    HRESULT SetColumnSortData(SColumnSetID* pColID, MMC_SORT_SET_DATA* pColSortData);
    HRESULT GetColumnSortData(SColumnSetID* pColID, MMC_SORT_SET_DATA** ppColSortData);
}

enum IconIdentifier
{
    Icon_None = 0,
    Icon_Error = 32513,
    Icon_Question = 32514,
    Icon_Warning = 32515,
    Icon_Information = 32516,
    Icon_First = 32513,
    Icon_Last = 32516,
}

const GUID IID_IMessageView = {0x80F94174, 0xFCCC, 0x11D2, [0xB9, 0x91, 0x00, 0xC0, 0x4F, 0x8E, 0xCD, 0x78]};
@GUID(0x80F94174, 0xFCCC, 0x11D2, [0xB9, 0x91, 0x00, 0xC0, 0x4F, 0x8E, 0xCD, 0x78]);
interface IMessageView : IUnknown
{
    HRESULT SetTitleText(ushort* pszTitleText);
    HRESULT SetBodyText(ushort* pszBodyText);
    HRESULT SetIcon(IconIdentifier id);
    HRESULT Clear();
}

struct RDITEMHDR
{
    uint dwFlags;
    int cookie;
    LPARAM lpReserved;
}

struct RDCOMPARE
{
    uint cbSize;
    uint dwFlags;
    int nColumn;
    LPARAM lUserParam;
    RDITEMHDR* prdch1;
    RDITEMHDR* prdch2;
}

const GUID IID_IResultDataCompareEx = {0x96933476, 0x0251, 0x11D3, [0xAE, 0xB0, 0x00, 0xC0, 0x4F, 0x8E, 0xCD, 0x78]};
@GUID(0x96933476, 0x0251, 0x11D3, [0xAE, 0xB0, 0x00, 0xC0, 0x4F, 0x8E, 0xCD, 0x78]);
interface IResultDataCompareEx : IUnknown
{
    HRESULT Compare(RDCOMPARE* prdc, int* pnResult);
}

enum MMC_VIEW_TYPE
{
    MMC_VIEW_TYPE_LIST = 0,
    MMC_VIEW_TYPE_HTML = 1,
    MMC_VIEW_TYPE_OCX = 2,
}

struct RESULT_VIEW_TYPE_INFO
{
    ushort* pstrPersistableViewDescription;
    MMC_VIEW_TYPE eViewType;
    uint dwMiscOptions;
    _Anonymous_e__Union Anonymous;
}

struct CONTEXTMENUITEM2
{
    const(wchar)* strName;
    const(wchar)* strStatusBarText;
    int lCommandID;
    int lInsertionPointID;
    int fFlags;
    int fSpecialFlags;
    const(wchar)* strLanguageIndependentName;
}

struct MMC_EXT_VIEW_DATA
{
    Guid viewID;
    ushort* pszURL;
    ushort* pszViewTitle;
    ushort* pszTooltipText;
    BOOL bReplacesDefaultView;
}

const GUID IID_IComponentData2 = {0xCCA0F2D2, 0x82DE, 0x41B5, [0xBF, 0x47, 0x3B, 0x20, 0x76, 0x27, 0x3D, 0x5C]};
@GUID(0xCCA0F2D2, 0x82DE, 0x41B5, [0xBF, 0x47, 0x3B, 0x20, 0x76, 0x27, 0x3D, 0x5C]);
interface IComponentData2 : IComponentData
{
    HRESULT QueryDispatch(int cookie, DATA_OBJECT_TYPES type, IDispatch* ppDispatch);
}

const GUID IID_IComponent2 = {0x79A2D615, 0x4A10, 0x4ED4, [0x8C, 0x65, 0x86, 0x33, 0xF9, 0x33, 0x50, 0x95]};
@GUID(0x79A2D615, 0x4A10, 0x4ED4, [0x8C, 0x65, 0x86, 0x33, 0xF9, 0x33, 0x50, 0x95]);
interface IComponent2 : IComponent
{
    HRESULT QueryDispatch(int cookie, DATA_OBJECT_TYPES type, IDispatch* ppDispatch);
    HRESULT GetResultViewType2(int cookie, RESULT_VIEW_TYPE_INFO* pResultViewType);
    HRESULT RestoreResultView(int cookie, RESULT_VIEW_TYPE_INFO* pResultViewType);
}

const GUID IID_IContextMenuCallback2 = {0xE178BC0E, 0x2ED0, 0x4B5E, [0x80, 0x97, 0x42, 0xC9, 0x08, 0x7E, 0x8B, 0x33]};
@GUID(0xE178BC0E, 0x2ED0, 0x4B5E, [0x80, 0x97, 0x42, 0xC9, 0x08, 0x7E, 0x8B, 0x33]);
interface IContextMenuCallback2 : IUnknown
{
    HRESULT AddItem(CONTEXTMENUITEM2* pItem);
}

const GUID IID_IMMCVersionInfo = {0xA8D2C5FE, 0xCDCB, 0x4B9D, [0xBD, 0xE5, 0xA2, 0x73, 0x43, 0xFF, 0x54, 0xBC]};
@GUID(0xA8D2C5FE, 0xCDCB, 0x4B9D, [0xBD, 0xE5, 0xA2, 0x73, 0x43, 0xFF, 0x54, 0xBC]);
interface IMMCVersionInfo : IUnknown
{
    HRESULT GetMMCVersion(int* pVersionMajor, int* pVersionMinor);
}

const GUID IID_IExtendView = {0x89995CEE, 0xD2ED, 0x4C0E, [0xAE, 0x5E, 0xDF, 0x7E, 0x76, 0xF3, 0xFA, 0x53]};
@GUID(0x89995CEE, 0xD2ED, 0x4C0E, [0xAE, 0x5E, 0xDF, 0x7E, 0x76, 0xF3, 0xFA, 0x53]);
interface IExtendView : IUnknown
{
    HRESULT GetViews(IDataObject pDataObject, IViewExtensionCallback pViewExtensionCallback);
}

const GUID IID_IViewExtensionCallback = {0x34DD928A, 0x7599, 0x41E5, [0x9F, 0x5E, 0xD6, 0xBC, 0x30, 0x62, 0xC2, 0xDA]};
@GUID(0x34DD928A, 0x7599, 0x41E5, [0x9F, 0x5E, 0xD6, 0xBC, 0x30, 0x62, 0xC2, 0xDA]);
interface IViewExtensionCallback : IUnknown
{
    HRESULT AddView(MMC_EXT_VIEW_DATA* pExtViewData);
}

const GUID IID_IConsolePower = {0x1CFBDD0E, 0x62CA, 0x49CE, [0xA3, 0xAF, 0xDB, 0xB2, 0xDE, 0x61, 0xB0, 0x68]};
@GUID(0x1CFBDD0E, 0x62CA, 0x49CE, [0xA3, 0xAF, 0xDB, 0xB2, 0xDE, 0x61, 0xB0, 0x68]);
interface IConsolePower : IUnknown
{
    HRESULT SetExecutionState(uint dwAdd, uint dwRemove);
    HRESULT ResetIdleTimer(uint dwFlags);
}

const GUID IID_IConsolePowerSink = {0x3333759F, 0xFE4F, 0x4975, [0xB1, 0x43, 0xFE, 0xC0, 0xA5, 0xDD, 0x6D, 0x65]};
@GUID(0x3333759F, 0xFE4F, 0x4975, [0xB1, 0x43, 0xFE, 0xC0, 0xA5, 0xDD, 0x6D, 0x65]);
interface IConsolePowerSink : IUnknown
{
    HRESULT OnPowerBroadcast(uint nEvent, LPARAM lParam, LRESULT* plReturn);
}

const GUID IID_INodeProperties = {0x15BC4D24, 0xA522, 0x4406, [0xAA, 0x55, 0x07, 0x49, 0x53, 0x7A, 0x68, 0x65]};
@GUID(0x15BC4D24, 0xA522, 0x4406, [0xAA, 0x55, 0x07, 0x49, 0x53, 0x7A, 0x68, 0x65]);
interface INodeProperties : IUnknown
{
    HRESULT GetProperty(IDataObject pDataObject, BSTR szPropertyName, ushort** pbstrProperty);
}

const GUID IID_IConsole3 = {0x4F85EFDB, 0xD0E1, 0x498C, [0x8D, 0x4A, 0xD0, 0x10, 0xDF, 0xDD, 0x40, 0x4F]};
@GUID(0x4F85EFDB, 0xD0E1, 0x498C, [0x8D, 0x4A, 0xD0, 0x10, 0xDF, 0xDD, 0x40, 0x4F]);
interface IConsole3 : IConsole2
{
    HRESULT RenameScopeItem(int hScopeItem);
}

const GUID IID_IResultData2 = {0x0F36E0EB, 0xA7F1, 0x4A81, [0xBE, 0x5A, 0x92, 0x47, 0xF7, 0xDE, 0x4B, 0x1B]};
@GUID(0x0F36E0EB, 0xA7F1, 0x4A81, [0xBE, 0x5A, 0x92, 0x47, 0xF7, 0xDE, 0x4B, 0x1B]);
interface IResultData2 : IResultData
{
    HRESULT RenameResultItem(int itemID);
}

