// Written in the D programming language.

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


///The <b>MMC_PROPERTY_ACTION</b> enumeration specifies the operations that can occur to a property contained in an
///MMC_SNAPIN_PROPERTY structure.
alias MMC_PROPERTY_ACTION = int;
enum : int
{
    ///The property is being deleted.
    MMC_PROPACT_DELETING    = 0x00000001,
    ///The property is being modified.
    MMC_PROPACT_CHANGING    = 0x00000002,
    ///The property is being added.
    MMC_PROPACT_INITIALIZED = 0x00000003,
}

///The <b>DocumentMode</b> enumeration is used by the Document.Mode property and specifies how the document is opened.
///This enumeration applies to the MMC 2.0 Automation Object Model.
alias _DocumentMode = int;
enum : int
{
    ///The document is opened in Author Mode.
    DocumentMode_Author   = 0x00000000,
    ///The document is opened in Full-Access User Mode.
    DocumentMode_User     = 0x00000001,
    ///The document is opened in Limited-Access User Mode with multiple windows.
    DocumentMode_User_MDI = 0x00000002,
    ///The document is opened in Limited-Access User Mode with a single window.
    DocumentMode_User_SDI = 0x00000003,
}

///The <b>ListViewMode</b> enumeration is used by the View.ListViewMode property to define the list view. The list view
///can contain small icons, large icons, a simple list, a detailed list, or a filtered list. This enumeration applies to
///the MMC 2.0 Automation Object Model.
alias _ListViewMode = int;
enum : int
{
    ///The list view is displayed with small icons.
    ListMode_Small_Icons = 0x00000000,
    ///The list view is displayed with large icons.
    ListMode_Large_Icons = 0x00000001,
    ///A simple list view is displayed.
    ListMode_List        = 0x00000002,
    ///A detailed list view is displayed.
    ListMode_Detail      = 0x00000003,
    ///A filtered list view is displayed.
    ListMode_Filtered    = 0x00000004,
}

///The <b>ViewOptions</b> enumeration is used by the Views.Add method and specifies the visibility of the view, scope
///tree, and toolbars, as well as the persistence state of the view. These flags can be combined using a bitwise OR
///operation. This enumeration applies to the MMC 2.0 Automation Object Model.
alias _ViewOptions = int;
enum : int
{
    ///The view is added with default settings.
    ViewOption_Default          = 0x00000000,
    ///The view is added with the scope tree pane hidden. The user will not be able to show the scope tree, as the
    ///<b>Console Tree</b> check box will be disabled in the <b>Customize View</b> dialog box.
    ViewOption_ScopeTreeHidden  = 0x00000001,
    ///The view is added with toolbars hidden.
    ViewOption_NoToolBars       = 0x00000002,
    ///The view is added as temporary (without persistence capability).
    ViewOption_NotPersistable   = 0x00000004,
    ViewOption_ActionPaneHidden = 0x00000008,
}

///The <b>ExportListOptions</b> enumeration is used by the View.ExportList method and specifies options when writing
///list view contents to a file. These values can be combined using a bitwise OR operation. This enumeration applies to
///the MMC 2.0 Automation Object Model.
alias _ExportListOptions = int;
enum : int
{
    ///Default list export option. If this is the only flag specified in the call to View.ExportList, then the list view
    ///contents are exported as comma-delimited ANSI text.
    ExportListOptions_Default           = 0x00000000,
    ///The list is exported as Unicode text.
    ExportListOptions_Unicode           = 0x00000001,
    ///The list is exported as tab-delimited text.
    ExportListOptions_TabDelimited      = 0x00000002,
    ///The exported list contains only currently selected items.
    ExportListOptions_SelectedItemsOnly = 0x00000004,
}

///The <b>MMC_RESULT_VIEW_STYLE</b> enumeration defines the Win32 list view style (LVS_*) flags that can be used to set
///the view style in the MMC result view pane. They can be used in the <i>add</i> and <i>remove</i> parameters of the
///IResultData::ModifyViewStyle method.
alias MMC_RESULT_VIEW_STYLE = int;
enum : int
{
    ///Allows only one item at a time to be selected. Without this view style, multiple items can be selected.
    MMC_SINGLESEL          = 0x00000001,
    ///Always show the selection, if any, even if the control does not have the focus.
    MMC_SHOWSELALWAYS      = 0x00000002,
    ///A value that specifies that column headers do not work like buttons. This style is useful if clicking a column
    ///header in report view does not carry out an action, such as sorting.
    MMC_NOSORTHEADER       = 0x00000004,
    MMC_ENSUREFOCUSVISIBLE = 0x00000008,
}

///The MMC_CONTROL_TYPE enumeration defines the kinds of controls that can appear in the control bar. The values can be
///used in the nType parameter of the IControlbar::Attach and IControlbar::Create methods.
alias MMC_CONTROL_TYPE = int;
enum : int
{
    ///The control to be associated with the control bar is a toolbar.
    TOOLBAR     = 0x00000000,
    ///The control is a drop-down menu. This is a standard Win32 menu button.
    MENUBUTTON  = 0x00000001,
    ///Not implemented at this time. This is a standard Win32 combo box.
    COMBOBOXBAR = 0x00000002,
}

///The <b>MMC_CONSOLE_VERB</b> enumeration defines the command identifiers available for MMC verbs. These values are
///used in the <i>m_eCmdID</i> parameter of IConsoleVerb::GetVerbState, IConsoleVerb::SetVerbState, and
///IConsoleVerb::SetDefaultVerb.
alias MMC_CONSOLE_VERB = int;
enum : int
{
    ///No verbs specified. Snap-ins can use this verb in calls to IConsoleVerb::SetDefaultVerb to specify that the
    ///selected item does not have a default verb.
    MMC_VERB_NONE       = 0x00000000,
    ///Allows the selected item to be opened.
    MMC_VERB_OPEN       = 0x00008000,
    ///Allows the selected item to be copied to the clipboard. When the user activates this verb, MMC calls the
    ///snap-in's IComponentData::QueryDataObject or IComponent::QueryDataObject implementation to request a data object
    ///for the selected item.
    MMC_VERB_COPY       = 0x00008001,
    ///Allows the selected item that has been cut or copied to be pasted into the result pane. When the user activates
    ///this verb, MMC sends the snap-in's IComponent::Notify method a MMCN_QUERY_PASTE notification message.
    MMC_VERB_PASTE      = 0x00008002,
    ///Allows the selected item to be deleted. When the user activates this verb, MMC sends the snap-in's
    ///IComponent::Notify method a MMCN_DELETE notification message.
    MMC_VERB_DELETE     = 0x00008003,
    ///The console instructs the snap-in and all snap-in extensions to provide property pages for the currently selected
    ///item. When the user activates this verb, MMC calls the IExtendPropertySheet2::CreatePropertyPages method of all
    ///snap-ins (primary and extension) that add property pages for the selected item. Be aware that primary snap-ins
    ///are responsible for enabling the <b>MMC_VERB_PROPERTIES</b> verb. Extensions snap-ins cannot do this, because
    ///they do not own the item for which the verb is enabled.
    MMC_VERB_PROPERTIES = 0x00008004,
    ///Allows the selected item to be renamed. When the user activates this verb, MMC sends the snap-in's
    ///IComponent::Notify or IComponentData::Notify method a MMCN_RENAME notification message.
    MMC_VERB_RENAME     = 0x00008005,
    ///Determines whether the currently selected scope item (folder) can be refreshed. When the user activates this
    ///verb, MMC sends the snap-in's IComponent::Notify a MMCN_REFRESH notification message.
    MMC_VERB_REFRESH    = 0x00008006,
    ///Determines whether the currently selected item can be printed. When the user activates this verb, MMC sends the
    ///snap-in's IComponent::Notify a MMCN_PRINT notification message.
    MMC_VERB_PRINT      = 0x00008007,
    ///(Applies to MMC 1.1 and later.) Used only to explicitly disable or hide the cut verb, when the copy and paste
    ///verbs are enabled. When the user activates this verb, MMC calls the snap-in's IComponentData::QueryDataObject or
    ///IComponent::QueryDataObject implementation to request a data object for the cut item.
    MMC_VERB_CUT        = 0x00008008,
    MMC_VERB_MAX        = 0x00008009,
    MMC_VERB_FIRST      = 0x00008000,
    MMC_VERB_LAST       = 0x00008008,
}

///The <b>MMC_BUTTON_STATE</b> enumeration defines the possible states of buttons available in MMC. These values are
///used in the <i>nState</i> parameter of IConsoleVerb::GetVerbState, IConsoleVerb::SetVerbState,
///IToolbar::GetButtonState, and IToolbar::SetButtonState.
alias MMC_BUTTON_STATE = int;
enum : int
{
    ///The button accepts user input. A button that does not have this state does not accept user input and appears
    ///dimmed.
    ENABLED       = 0x00000001,
    ///The button has the CHECKED style and is being pressed.
    CHECKED       = 0x00000002,
    ///The button is not visible and cannot receive user input.
    HIDDEN        = 0x00000004,
    ///The button appears dimmed.
    INDETERMINATE = 0x00000008,
    BUTTONPRESSED = 0x00000010,
}

///The MMC_SCOPE_ITEM_STATE enumeration is used to specify the <b>nState</b> member of the SCOPEDATAITEM structure.
alias MMC_SCOPE_ITEM_STATE = int;
enum : int
{
    ///Not currently used.
    MMC_SCOPE_ITEM_STATE_NORMAL       = 0x00000001,
    ///Not currently used.
    MMC_SCOPE_ITEM_STATE_BOLD         = 0x00000002,
    MMC_SCOPE_ITEM_STATE_EXPANDEDONCE = 0x00000003,
}

///The <b>MMC_MENU_COMMAND_IDS</b> enumeration defines the Command Identifiers that are reserved by MMC.
alias MMC_MENU_COMMAND_IDS = int;
enum : int
{
    ///Sent to a snap-in's IExtendContextMenu::Command method when the user switches from a custom result view to the
    ///standard list view.
    MMCC_STANDARD_VIEW_SELECT = 0xffffffff,
}

///The <b>MMC_FILTER_TYPE</b> enumeration is introduced in MMC 1.2. The <b>MMC_FILTER_TYPE</b> enumeration defines the
///filter type that is associated with a filter applied to a column in a filtered list. The values can be used in the
///<i>dwType</i> parameter of the IHeaderCtrl2::SetColumnFilter method and the <i>pdwType</i> parameter of the
///IHeaderCtrl2::GetColumnFilter method.
alias MMC_FILTER_TYPE = int;
enum : int
{
    ///String filter.
    MMC_STRING_FILTER  = 0x00000000,
    ///Integer filter.
    MMC_INT_FILTER     = 0x00000001,
    ///When used by the IHeaderCtrl2::SetColumnFilter method, the snap-in sets the flag to clear the column filter. When
    ///used by the IHeaderCtrl2::GetColumnFilter method, the flag is set to indicate that the column filter is empty.
    MMC_FILTER_NOVALUE = 0x00008000,
}

///The <b>MMC_FILTER_CHANGE_CODE</b> enumeration is introduced in MMC 1.2. The <b>MMC_FILTER_CHANGE_CODE</b> enumeration
///specifies the filter change codes that can be sent as the <i>arg</i> parameter of an MMCN_FILTER_CHANGE notification
///in calls to IComponent::Notify.
alias MMC_FILTER_CHANGE_CODE = int;
enum : int
{
    ///The filter view has been turned off.
    MFCC_DISABLE      = 0x00000000,
    ///The filter view has been turned on.
    MFCC_ENABLE       = 0x00000001,
    ///The filter value of a column in a result view filter list has changed. The <i>param</i> parameter of the
    ///IComponent::Notify method contains the column ID.
    MFCC_VALUE_CHANGE = 0x00000002,
}

///The MMC_NOTIFY_TYPE enumeration defines the notifications of user actions that can be sent to a snap-in by the
///console's Node Manager when it calls IComponentData::Notify, IComponent::Notify, or
///IExtendControlbar::ControlbarNotify. For more information, see MMC Notifications.
alias MMC_NOTIFY_TYPE = int;
enum : int
{
    ///A window for which the snap-in owns the result view is being activated or deactivated.
    MMCN_ACTIVATE           = 0x00008001,
    ///The snap-in is being notified to add images for the result pane.
    MMCN_ADD_IMAGES         = 0x00008002,
    ///The user clicked a toolbar button.
    MMCN_BTN_CLICK          = 0x00008003,
    ///Not used.
    MMCN_CLICK              = 0x00008004,
    ///The user clicked a list view column header.
    MMCN_COLUMN_CLICK       = 0x00008005,
    ///Not used.
    MMCN_CONTEXTMENU        = 0x00008006,
    ///Items owned by the snap-in have been cut or moved.
    MMCN_CUTORMOVE          = 0x00008007,
    ///The user double-clicked a mouse button on a list view item or on a scope item in the result pane.
    MMCN_DBLCLICK           = 0x00008008,
    ///Sent to inform the snap-in that an object should be deleted.
    MMCN_DELETE             = 0x00008009,
    ///Sent to the virtual list view when all items of an owner-data result pane are deselected.
    MMCN_DESELECT_ALL       = 0x0000800a,
    ///Sent when a scope item must be expanded or collapsed.
    MMCN_EXPAND             = 0x0000800b,
    ///Not used.
    MMCN_HELP               = 0x0000800c,
    ///Sent when the user clicks a snap-in defined menu button.
    MMCN_MENU_BTNCLICK      = 0x0000800d,
    ///Sent when a window is being minimized or maximized.
    MMCN_MINIMIZED          = 0x0000800e,
    ///Notifies the snap-in's scope item to paste selected result items.
    MMCN_PASTE              = 0x0000800f,
    ///Informs the snap-in of property changes.
    MMCN_PROPERTY_CHANGE    = 0x00008010,
    ///Sent to determine whether the snap-in can paste items from a given data object.
    MMCN_QUERY_PASTE        = 0x00008011,
    ///Sent when the refresh verb is selected.
    MMCN_REFRESH            = 0x00008012,
    ///Notifies the snap-in when to delete all the child items (the entire subtree) below a specified item.
    MMCN_REMOVE_CHILDREN    = 0x00008013,
    ///A scope or result item must be renamed.
    MMCN_RENAME             = 0x00008014,
    ///An item has been selected in either the scope pane or result pane.
    MMCN_SELECT             = 0x00008015,
    ///Sent when a scope item is selected or deselected.
    MMCN_SHOW               = 0x00008016,
    ///Sent to inform the snap-in that the view should be updated.
    MMCN_VIEW_CHANGE        = 0x00008017,
    ///The user requested help about the snap-in.
    MMCN_SNAPINHELP         = 0x00008018,
    ///The user requested help about a selected item.
    MMCN_CONTEXTHELP        = 0x00008019,
    ///Sent when a custom OCX is initialized for the first time.
    MMCN_INITOCX            = 0x0000801a,
    ///Sent when the filter value for a filtered result view column has been changed.
    MMCN_FILTER_CHANGE      = 0x0000801b,
    ///The user clicked the filter button on the header control of a filtered view.
    MMCN_FILTERBTN_CLICK    = 0x0000801c,
    ///Sent when the result pane for a scope item must be restored.
    MMCN_RESTORE_VIEW       = 0x0000801d,
    ///Sent when the user clicks the <b>Print</b> button or selects the <b>Print</b> menu item.
    MMCN_PRINT              = 0x0000801e,
    ///Sent if the snap-in supports the CCF_SNAPIN_PRELOADS format.
    MMCN_PRELOAD            = 0x0000801f,
    ///Sent when the list control for the list view taskpad is being attached or detached.
    MMCN_LISTPAD            = 0x00008020,
    ///Sent when MMC requires a scope item to be expanded synchronously.
    MMCN_EXPANDSYNC         = 0x00008021,
    ///Sent when the user hides columns or makes columns visible in the list view.
    MMCN_COLUMNS_CHANGED    = 0x00008022,
    ///Sent by MMC to determine whether the snap-in supports paste operations from another MMC process.
    MMCN_CANPASTE_OUTOFPROC = 0x00008023,
}

///The <b>DATA_OBJECT_TYPES</b> enumeration is used by the <i>type</i> parameter of IComponentData::QueryDataObject and
///IComponent::QueryDataObject to obtain context information about a specified cookie.
alias DATA_OBJECT_TYPES = int;
enum : int
{
    ///Data object for scope pane context.
    CCT_SCOPE          = 0x00008000,
    ///Data object for result pane context.
    CCT_RESULT         = 0x00008001,
    ///Data object for Snap-in Manager context.
    CCT_SNAPIN_MANAGER = 0x00008002,
    CCT_UNINITIALIZED  = 0x0000ffff,
}

alias __MIDL___MIDL_itf_mmc_0000_0006_0001 = int;
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

alias __MIDL___MIDL_itf_mmc_0000_0006_0002 = int;
enum : int
{
    CCM_INSERTIONALLOWED_TOP  = 0x00000001,
    CCM_INSERTIONALLOWED_NEW  = 0x00000002,
    CCM_INSERTIONALLOWED_TASK = 0x00000004,
    CCM_INSERTIONALLOWED_VIEW = 0x00000008,
}

alias __MIDL___MIDL_itf_mmc_0000_0006_0003 = int;
enum : int
{
    CCM_COMMANDID_MASK_RESERVED = 0xffff0000,
}

alias __MIDL___MIDL_itf_mmc_0000_0006_0004 = int;
enum : int
{
    CCM_SPECIAL_SEPARATOR       = 0x00000001,
    CCM_SPECIAL_SUBMENU         = 0x00000002,
    CCM_SPECIAL_DEFAULT_ITEM    = 0x00000004,
    CCM_SPECIAL_INSERTION_POINT = 0x00000008,
    CCM_SPECIAL_TESTONLY        = 0x00000010,
}

///The <b>MMC_TASK_DISPLAY_TYPE</b> enumeration is introduced in MMC 1.1. The <b>MMC_TASK_DISPLAY_TYPE</b> enumeration
///defines the types of image that can be displayed for a task or the background on a taskpad. These values are used in
///the <b>eDisplayType</b> member of the MMC_TASK_DISPLAY_OBJECT structure. For that which displays the task image, the
///MMC_TASK_DISPLAY_OBJECT structure is the <b>sDisplayObject</b> member of the MMC_TASK structure, which is filled in
///by the IEnumTASK::Next method. For that which displays the background image, the MMC_TASK_DISPLAY_OBJECT structure is
///filled in by the IExtendTaskPad::GetBackground method.
alias MMC_TASK_DISPLAY_TYPE = int;
enum : int
{
    ///No images specified.
    MMC_TASK_DISPLAY_UNINITIALIZED      = 0x00000000,
    ///The image displayed for the task or background is the symbol specified by an MMC_TASK_DISPLAY_SYMBOL structure.
    MMC_TASK_DISPLAY_TYPE_SYMBOL        = 0x00000001,
    ///The image displayed for the task or background is a transparent GIF image. The GIF image is specified by an
    ///MMC_TASK_DISPLAY_BITMAP structure. <div class="alert"><b>Note</b> There is no difference between
    ///<b>MMC_TASK_DISPLAY_TYPE_VANILLA_GIF</b> and <b>MMC_TASK_DISPLAY_TYPE_CHOCOLATE_GIF</b>.</div> <div> </div>
    MMC_TASK_DISPLAY_TYPE_VANILLA_GIF   = 0x00000002,
    ///The image displayed for the task or background is a transparent GIF image. The GIF image is specified by an
    ///MMC_TASK_DISPLAY_BITMAP structure. <div class="alert"><b>Note</b> There is no difference between
    ///<b>MMC_TASK_DISPLAY_TYPE_VANILLA_GIF</b> and <b>MMC_TASK_DISPLAY_TYPE_CHOCOLATE_GIF</b>.</div> <div> </div>
    MMC_TASK_DISPLAY_TYPE_CHOCOLATE_GIF = 0x00000003,
    MMC_TASK_DISPLAY_TYPE_BITMAP        = 0x00000004,
}

///The MMC_ACTION_TYPE enumeration is introduced in MMC 1.1. The MMC_ACTION_TYPE enumeration defines the types of action
///that can be triggered when a user clicks a task on a taskpad. These values are used in the eActionType member of the
///MMC_TASK structure, which is filled in by the IEnumTASK::Next method.
alias MMC_ACTION_TYPE = int;
enum : int
{
    ///No actions specified.
    MMC_ACTION_UNINITIALIZED = 0xffffffff,
    ///When the user clicks the task, MMC calls IExtendTaskPad::TaskNotify and returns the command ID specified in the
    ///nCommandID member of the MMC_TASK structure that was filled in when MMC called IEnumTASK::Next to add the task to
    ///the taskpad.
    MMC_ACTION_ID            = 0x00000000,
    ///When the user clicks the task, MMC activates the link specified by the szActionURL member of the MMC_TASK
    ///structure.
    MMC_ACTION_LINK          = 0x00000001,
    MMC_ACTION_SCRIPT        = 0x00000002,
}

///The <b>IconIdentifier</b> enumeration is introduced in MMC 1.2. The <b>IconIdentifier</b> enumeration defines the
///types of icons that can appear in error messages displayed by the snap-in when using the MMC message OCX control.
enum IconIdentifier : int
{
    ///No icon displayed in error message.
    Icon_None        = 0x00000000,
    ///Error icon displayed in error message.
    Icon_Error       = 0x00007f01,
    ///Question icon displayed in error message.
    Icon_Question    = 0x00007f02,
    ///Warning icon displayed in error message.
    Icon_Warning     = 0x00007f03,
    ///Information icon displayed in error message.
    Icon_Information = 0x00007f04,
    ///Used internally by MMC.
    Icon_First       = 0x00007f01,
    ///Used internally by MMC.
    Icon_Last        = 0x00007f04,
}

///The <b>MMC_VIEW_TYPE</b> enumeration specifies a result view type and is used in the RESULT_VIEW_TYPE_INFO structure.
alias MMC_VIEW_TYPE = int;
enum : int
{
    ///The view type is a list view.
    MMC_VIEW_TYPE_LIST = 0x00000000,
    ///The view type is an HTML view.
    MMC_VIEW_TYPE_HTML = 0x00000001,
    ///The view type is a control view.
    MMC_VIEW_TYPE_OCX  = 0x00000002,
}

// Structs


///The <b>MMC_SNAPIN_PROPERTY</b> structure is introduced in MMC 2.0. The <b>MMC_SNAPIN_PROPERTY</b> structure is used
///by a snap-in when a property is added, changed, or deleted.
struct MMC_SNAPIN_PROPERTY
{
    ///Name of the property.
    ushort*             pszPropName;
    ///The property's value; if the property is being changed, this is the new value.
    VARIANT             varValue;
    ///The action taking place on the property, as defined in MMC_PROPERTY_ACTION.
    MMC_PROPERTY_ACTION eAction;
}

///The <b>MMCBUTTON</b> structure contains values used in creating buttons on a toolbar. This structure is similar to
///the <b>TBBUTTON</b> structure discussed in the Platform Software Development Kit (SDK) topics related to common
///controls.
struct MMCBUTTON
{
    ///A value that specifies the zero-based index of a button image.
    int     nBitmap;
    ///A value that specifies the command identifier returned when a button is clicked. This can be any integer value
    ///the user wants. Only the low word of the <b>int</b> is used.
    int     idCommand;
    ///A value that specifies the button-state flags. This member can be any of the following values:
    ubyte   fsState;
    ///A value that specifies the button style. This member can be any combination of the following values:
    ubyte   fsType;
    ///A pointer to the text associated with a particular instance of the <b>MMCBUTTON</b> structure.
    ushort* lpButtonText;
    ///A pointer to the text for a particular tooltip.
    ushort* lpTooltipText;
}

///The <b>RESULTDATAITEM</b> structure specifies or receives the attributes of result items in the result pane of the
///snap-in.
struct RESULTDATAITEM
{
    ///A set of flags that specifies attributes of this data structure, or an operation that uses this structure. The
    ///following flags specify the members of the <b>RESULTDATAITEM</b> structure that contain valid data, or need to be
    ///filled in with data. One or more of the flags can be set.
    uint      mask;
    ///<b>TRUE</b> if the <b>lParam</b> member refers to a scope item. <b>FALSE</b> if the <b>lParam</b> member refers
    ///to a result item.
    BOOL      bScopeItem;
    ///A value that specifies a console-supplied unique item identifier for the result item. This value is used to
    ///identify an item in the result pane of calls to some IResultData interface methods. After the snap-in
    ///successfully inserts an item in the scope pane (by using IResultData::InsertItem), the <b>itemID</b> member of
    ///the <b>RESULTDATAITEM</b> structure contains the <b>HRESULTITEM</b> handle of the newly inserted item. This
    ///handle is the unique identifier for the result item. The snap-in should store this value to manipulate (later)
    ///the inserted item by calling methods such as IResultData::GetItem. If this value is not stored, it can be looked
    ///up by using IResultData::FindItemByLParam.
    ptrdiff_t itemID;
    ///A value that specifies the zero-based index of the item to which this structure refers.
    int       nIndex;
    ///A value that specifies the column on which an operation is to be performed. If the operation is to be performed
    ///on an item and not a column, the value is zero (0).
    int       nCol;
    ///A pointer to a null-terminated string that contains the item text if the structure specifies the <b>RDI_STR</b>
    ///item attribute. If this member is the <b>MMC_CALLBACK</b> value, the item is a callback item. Be aware that the
    ///snap-in can use <b>MMC_TEXTCALLBACK</b> instead of <b>MMC_CALLBACK</b>. The <b>MMC_TEXTCALLBACK</b> value is a
    ///type-correct (no casting necessary) version of <b>MMC_CALLBACK</b>. <b>MMC_TEXTCALLBACK</b> is introduced in MMC
    ///version 1.2.
    ushort*   str;
    ///Virtual image index of the list view item's icon in the large and small icon image lists. Be aware that the
    ///virtual image index is mapped internally to the actual index. This member can also be specified as a callback
    ///item: <b>MMC_CALLBACK</b> or <b>MMC_IMAGECALLBACK</b>. The <b>MMC_IMAGECALLBACK</b> value is a type-correct (no
    ///casting necessary) version of <b>MMC_CALLBACK</b>. <b>MMC_IMAGECALLBACK</b> is introduced in MMC version 1.2.
    int       nImage;
    ///A value that specifies the state mask for the item. It can be one of the following values.
    uint      nState;
    ///A value that specifies a user-supplied 32-bit value to associate with the item. This item, also called a cookie,
    ///is the value that is passed as the first parameter to IComponent::QueryDataObject.
    LPARAM    lParam;
    ///Reserved.
    int       iIndent;
}

///The <b>RESULTFINDINFO</b> structure is used by the IResultOwnerData::FindItem method to support keyboard navigation
///in virtual lists in the result pane.
struct RESULTFINDINFO
{
    ///Null-terminated string to match.
    ushort* psz;
    ///Index at which to start search.
    int     nStart;
    ///One or both of the following flags:
    uint    dwOptions;
}

///The <b>SCOPEDATAITEM</b> structure specifies items to be inserted into the scope pane.
struct SCOPEDATAITEM
{
    ///A value that specifies an array of flags that indicate which members of the structure contain valid data. When
    ///this structure is used in the IConsoleNameSpace2::GetItem method, it indicates the item attributes to be
    ///retrieved. This member can be one of the following values.
    uint      mask;
    ///<b>MMC_CALLBACK</b> value or a pointer to a null-terminated string, which depends on how the structure is being
    ///used. <ul> <li>When an item is inserted by using IConsoleNameSpace2::InsertItem, this member must be set to
    ///<b>MMC_CALLBACK</b>.</li> <li>When the name of an item inserted by the snap-in is changed by using
    ///IConsoleNameSpace2::SetItem, this member must be set to <b>MMC_CALLBACK</b>.</li> <li>When the name of the static
    ///node (an item that the console inserts) is changed, this member can be set to <b>MMC_CALLBACK</b>, or be a
    ///pointer to the null-terminated string that contains the item text.</li> </ul> Be aware that the snap-in can use
    ///<b>MMC_TEXTCALLBACK</b> instead of <b>MMC_CALLBACK</b>. The <b>MMC_TEXTCALLBACK</b> value is a type-correct (no
    ///casting necessary) version of <b>MMC_CALLBACK</b>. <b>MMC_TEXTCALLBACK</b> is introduced in MMC version 1.2.
    ushort*   displayname;
    ///Virtual image index in the image list when the item is in the nonselected state. Be aware that the virtual image
    ///index is mapped internally to the actual index. This member can also be specified as a callback item:
    ///<b>MMC_CALLBACK</b> or <b>MMC_IMAGECALLBACK</b>. The <b>MMC_IMAGECALLBACK</b> is a type-correct (no casting
    ///necessary) version of <b>MMC_CALLBACK</b>. <b>MMC_IMAGECALLBACK</b> is introduced in MMC version 1.2.
    int       nImage;
    ///Virtual image index in the image list when the item is in the selected state. Be aware that the virtual image
    ///index is mapped internally to the actual index. The item is like a folder in Microsoft Windows Explorer. The icon
    ///is for an open folder.
    int       nOpenImage;
    ///A value that specifies the state mask for the item. For IConsoleNameSpace2::GetItem, this member returns
    ///<b>MMC_SCOPE_ITEM_STATE_EXPANDEDONCE</b> if the item has been expanded at least one time, or 0 (zero) if the item
    ///has not been expanded. This member is ignored for IConsoleNameSpace2::InsertItem and IConsoleNameSpace2::SetItem.
    uint      nState;
    ///A value that specifies the number of enumerated items. When a snap-in inserts a scope item, it should set the
    ///<b>cChildren</b> field to 0 (zero), and set the <b>SDI_CHILDREN</b> flag if both of the following conditions are
    ///met: <ul> <li>The snap-in does not have any child items to add under the inserted item.</li> <li>The snap-in does
    ///not dynamically enable any namespace extension snap-ins for this item.</li> </ul> Otherwise, when inserting a
    ///scope item, the <b>cChildren</b> field should be set to 1 (one), or not set at all. If conditions change at a
    ///later time, the snap-in can modify the <b>cChildren</b> field by using IConsoleNameSpace2::SetItem. If it will
    ///take a significant amount of time to determine the number of children, the snap-in should use a best guess at
    ///insertion time, and make the actual determination on another thread so the MMC user interface will not be locked
    ///out. IConsoleNameSpace2::SetItem can be used to correct the setting if necessary. When MMC detects a scope item
    ///with a <b>cChildren</b> count of 0 (zero), it checks for namespace extensions that have been statically enabled
    ///for the item by the user or the IRequiredExtensions interface. If none are enabled, the plus (+) sign is removed
    ///from the item. After an item is expanded, the state of the plus sign is determined by the actual number of child
    ///items present.
    int       cChildren;
    ///A value that specifies a user-supplied 32-bit value to associate with the item. This item, also called a cookie,
    ///is the value that is passed as the first parameter to IComponentData::QueryDataObject.
    LPARAM    lParam;
    ///A console-supplied unique item identifier. An item is inserted at a position relative to the item that this
    ///member specifies. The <b>mask</b> settings determine the relative position. To determine how <b>relativeID</b> is
    ///interpreted, specify one of the following constants as the <b>mask</b> member.
    ptrdiff_t relativeID;
    ///A value that specifies a console-supplied unique identifier for the scope item. This value is used to identify an
    ///item in the scope pane of calls to some of the IConsole2 and IConsoleNameSpace2 interface methods. After the
    ///snap-in successfully inserts an item into the scope pane (by using IConsoleNameSpace2::InsertItem), the <b>ID</b>
    ///member of the <b>SCOPEDATAITEM</b> structure contains the <b>HSCOPEITEM</b> handle of the newly inserted item.
    ///This handle is the unique identifier for the scope item. For a static node, MMC inserts an item into the scope
    ///pane of the snap-in. Then MMC passes the <b>HSCOPEITEM</b> of the static node to the snap-in as the <i>param</i>
    ///parameter in the MMCN_EXPAND notification. Be aware that snap-ins should store the <b>HSCOPEITEM</b> of each
    ///inserted item and use it later to manipulate the item by using the methods of the IConsole2 and
    ///IConsoleNameSpace2 interfaces.
    ptrdiff_t ID;
}

///The <b>CONTEXTMENUITEM</b> structure is passed to the IContextMenuCallback::AddItem method or the
///<b>IContextMenuProvider::AddItem</b> method (inherited from IContextMenuCallback) to define a new menu item, submenu,
///or insertion point. The context menu is built from the root down, with each new item going to the end of the submenu
///or insertion point where it is inserted.
struct CONTEXTMENUITEM
{
    ///A pointer to a null-terminated string that contains the name of the menu item or of the submenu. This member
    ///cannot be <b>NULL</b> except for a separator or insertion point.
    const(wchar)* strName;
    ///A pointer to a null-terminated string that contains the text that is displayed in the status bar when this item
    ///is highlighted. This member can be <b>NULL</b>.
    const(wchar)* strStatusBarText;
    ///A value that specifies the command identifier for menu items. If this menu item is added by
    ///IExtendContextMenu::AddMenuItems and then selected, this is the command ID that is passed back to
    ///IExtendContextMenu::Command. If this menu item is added by the IContextMenuProvider interface and then selected,
    ///this is the command ID that is passed back to pISelected by IContextMenuProvider::ShowContextMenu. If this is an
    ///insertion point (<b>CCM_SPECIAL_INSERTION_POINT</b> is set in <i>fSpecialFlags</i>) or a submenu (<b>MF_POPUP</b>
    ///is set in <i>fFlags</i>), use <i>lCommandID</i> in subsequent calls as <i>lInsertionPointID</i> (for more
    ///information, see the following list). Carefully read the following discussion because specific bits in the new
    ///insertion point ID must be on and others must be off. Some bits in the command ID require special handling for
    ///items that are not insertion points or submenus.
    int           lCommandID;
    ///A value that specifies where in the context menu the new item should be added. Snap-ins can only add items to
    ///insertion points created by the menu creator or the primary snap-in. The following are the insertion points
    ///created by MMC in the default context menus for items in the scope pane and list view result pane:
    int           lInsertionPointID;
    ///A value that specifies one or more of the following style flags:
    int           fFlags;
    ///A value that specifies one or more of the following flags:
    int           fSpecialFlags;
}

///The <b>MENUBUTTONDATA</b> structure contains values used to create buttons on a toolbar.
struct MENUBUTTONDATA
{
    ///A value that specifies a user-supplied value that uniquely identifies the menu button.
    int idCommand;
    ///A value that specifies the horizontal position, in pixels, at which the snap-in's context menu is displayed.
    int x;
    ///A value that specifies the vertical position, in pixels, at which the snap-in's context menu is displayed.
    int y;
}

///The MMC_FILTERDATA structure is introduced in MMC 1.2. The MMC_FILTERDATA structure is used by the
///IHeaderCtrl2::GetColumnFilter and IHeaderCtrl2::SetColumnFilter methods to retrieve and set the filter value of a
///column in a filtered list view.
struct MMC_FILTERDATA
{
    ///When a snap-in sets a text filter value, pszText points to the filter string to set and cchTextMax sets the
    ///maximum length of the filter string that the user can type into the filter field. When a snap-in reads a text
    ///filter value, pszText points to a buffer to receive the text and cchTextMax gives the length of the buffer.
    ushort* pszText;
    ///For more information, see the description for pszText.
    int     cchTextMax;
    ///When a snap-in sets a numeric filter value, lValue contains the filter value. The filter field converts the value
    ///to a string and places it in the filter control. When a snap-in reads a numeric filter value, the current filter
    ///value is converted to binary and returned in lValue.
    int     lValue;
}

///The MMC_RESTORE_VIEW structure is introduced in MMC 1.1. The MMC_RESTORE_VIEW structure contains information about a
///result pane view that must be restored by the snap-in when the user has navigated to a view displayed in the view
///history using the back or forward buttons.
struct MMC_RESTORE_VIEW
{
    ///A value that specifies the size of the MMC_RESTORE_VIEW structure. A snap-in can use dwSize to check the version
    ///of the structure.
    uint      dwSize;
    ///A value that specifies the cookie for the item that will be restored in the scope pane.
    ptrdiff_t cookie;
    ///A pointer to a string that specifies the view type used to display the result pane for the item specified by
    ///cookie. For more information about view types, see the ppViewType parameter for IComponent::GetResultViewType.
    ushort*   pViewType;
    ///A value that specifies the view option settings used to display the result pane for the item specified by cookie.
    ///For more information about view options, see the pViewOptions parameter of IComponent::GetResultViewType.
    int       lViewOptions;
}

///The <b>MMC_EXPANDSYNC_STRUCT</b> structure is introduced in MMC 1.1. The <b>MMC_EXPANDSYNC_STRUCT</b> structure
///contains information about a scope item that must be expanded synchronously. MMC passes a pointer to an
///<b>MMC_EXPANDSYNC_STRUCT</b> structure when it calls the snap-in's IComponentData::Notify method with the
///MMCN_EXPANDSYNC notification.
struct MMC_EXPANDSYNC_STRUCT
{
    ///A value that specifies whether the snap-in has expanded the specified scope item. If this value is <b>TRUE</b>,
    ///the snap-in handles <b>MMC_EXPANDSYNC</b>, and consequently MMC does not send a further MMCN_EXPAND notification
    ///to the snap-in. The default value for <b>bHandled</b> is <b>FALSE</b>. If the snap-in does not handle
    ///<b>MMC_EXPANDSYNC</b> or sets <b>bHandled</b> to <b>FALSE</b>, MMC sends an MMCN_EXPAND notification to the
    ///snap-in.
    BOOL      bHandled;
    ///A value that specifies whether the snap-in is expanding or collapsing. <b>TRUE</b> if the folder is being
    ///expanded. <b>FALSE</b> if the folder is being collapsed.
    BOOL      bExpanding;
    ///The <b>HSCOPEITEM</b> of the item that must be expanded.
    ptrdiff_t hItem;
}

///The MMC_VISIBLE_COLUMNS structure is introduced in MMC 1.2. The MMC_VISIBLE_COLUMNS structure is used by MMC with the
///MMCN_COLUMNS_CHANGED notification to inform the snap-in which columns in a column set are visible.
struct MMC_VISIBLE_COLUMNS
{
    ///The number of visible columns in the column set.
    int    nVisibleColumns;
    ///A variable-length array in which each member contains the zero-based number of a visible column. The ordering of
    ///the columns in the array corresponds to the order of the columns as they appear in the list view. The
    ///nVisibleColumns member gives the number of elements in the list.
    int[1] rgVisibleCols;
}

///The <b>SMMCDataObjects</b> structure defines the format of the data for the CCF_MULTI_SELECT_SNAPINS clipboard
///format. The structure contains the array of pointers to the multiselection data object of each snap-in represented in
///the set of selected items in the result pane.
struct SMMCDataObjects
{
    ///The number of snap-ins whose items are selected in the result pane.
    uint           count;
    ///Array of pointers to the multiselection data objects for each snap-in selected in the result pane.
    IDataObject[1] lpDataObject;
}

///The <b>SMMCDynamicExtensions</b> structure is introduced in MMC 1.1. The <b>SMMCDynamicExtensions</b> structure
///defines the format of the data for the CCF_MMC_DYNAMIC_EXTENSIONS clipboard format, which specifies the non-namespace
///extension snap-ins that should extend a scope or result item.
struct SMMCObjectTypes
{
    ///The count of GUIDs in the array specified by <b>guid</b>.
    uint    count;
    ///An array of GUIDs that represent the CLSIDs of the snap-ins that you want to extend the item represented by an
    ///<b>IDataObject</b> object.
    GUID[1] guid;
}

///The <b>SNodeID</b> structure is introduced in MMC 1.1, and is replaced by the SNodeID2 structure in MMC 1.2. The
///<b>SNodeID</b> structure defines the format of the data for the CCF_NODEID clipboard format. The <b>SNodeID</b>
///structure contains an array of bytes that represent the node ID.
struct SNodeID
{
    ///The count of bytes in the <b>id</b> array. The snap-in can also specify that a scope item should not be
    ///re-expanded when the console is reopened. To do this, set the <b>cBytes</b> member to 0 (zero) and return
    ///<b>S_OK</b> in the IDataObject::GetData method. Be aware that this setting not only keeps the selected item from
    ///being persisted but also prevents its parent item from automatically expanding when the console file is reopened.
    uint     cBytes;
    ///The bytes that contains the node ID of the scope item.
    ubyte[1] id;
}

///The <b>SNodeID2</b> structure is introduced in MMC 1.2, and replaces the SNodeID structure. The <b>SNodeID2</b>
///structure is used by the CCF_NODEID2 clipboard format. The <b>SNodeID2</b> structure contains an array of bytes that
///represent the node ID.
struct SNodeID2
{
    ///Currently, only the MMC_NODEID_SLOW_RETRIEVAL flag is defined for <b>dwFlags</b>. If this flag is set, MMC will
    ///not persist the specified scope item except where absolutely necessary, as for example for console taskpads.
    ///Console taskpads always persist the target items and task target items.
    uint     dwFlags;
    ///The count of bytes in the <b>id</b> array.
    uint     cBytes;
    ///The bytes that contains the node ID of the scope item.
    ubyte[1] id;
}

///The <b>SColumnSetID</b> structure is introduced in MMC 1.2. The <b>SColumnSetID</b> structure is used by the
///CCF_COLUMN_SET_ID clipboard format. The <b>SColumnSetID</b> structure contains an array of bytes that represent the
///node ID.
struct SColumnSetID
{
    ///Reserved for future use. Must be 0.
    uint     dwFlags;
    ///The count of bytes in the <b>id</b> array.
    uint     cBytes;
    ///The bytes that contains the column set ID.
    ubyte[1] id;
}

///The <b>MMC_TASK_DISPLAY_SYMBOL</b> structure is introduced in MMC 1.1. The <b>MMC_TASK_DISPLAY_SYMBOL</b> structure
///is used for the <b>uSymbol</b> member of the MMC_TASK_DISPLAY_OBJECT structure to specify all the data required to
///display a symbol as an image for a task or background on a taskpad.
struct MMC_TASK_DISPLAY_SYMBOL
{
    ///A pointer to a null-terminated string that contains the font family name of the symbol to display. For example,
    ///the following string specifies that the font is Webdings: "Webdings". This should never be set to a <b>NULL</b>
    ///string or an empty string.
    ushort* szFontFamilyName;
    ///A pointer to a null-terminated string that contains the resource path to the EOT (embedded OpenType) file that
    ///contains the font for the symbol to display. The string should have the following form:
    ///"res://<i>filepath</i>/imgpath". where <i>filepath</i> is the full path to the snap-in's DLL that stores the
    ///image file as a resource, and <i>imgpath</i> is the resource path of the image file with the snap-in DLL. For
    ///example, the following string specifies that the snap-in DLL (snapin.dll) has a path of
    ///"c:\windows\system32\snapin.dll" and that the resource path is img/myfont.eot:
    ///"res://c:\\windows\\system32\\snapin.dll/img/myfont.eot".
    ushort* szURLtoEOT;
    ///A pointer to a null-terminated string that contains the character or characters to display in the symbol.
    ushort* szSymbolString;
}

///The <b>MMC_TASK_DISPLAY_BITMAP</b> structure is introduced in MMC 1.1. The <b>MMC_TASK_DISPLAY_BITMAP</b> structure
///is used for the <b>uBitmap</b> member of the MMC_TASK_DISPLAY_OBJECT structure to specify all the data required to
///display a GIF or bitmap image for a task or background on a taskpad.
struct MMC_TASK_DISPLAY_BITMAP
{
    ///A pointer to a null-terminated string that contains the resource path to the image file for the image displayed
    ///for the task when the user moves the mouse over the task's image or text area. The string should have the
    ///following form: "res://<i>filepath</i>/<i>imgpath</i>" where <i>filepath</i> is the full path to the snap-in's
    ///DLL that stores the image file as a resource, and <i>imgpath</i> is the resource path of the image file with the
    ///snap-in DLL. For example, the following string specifies that the snap-in DLL (snapin.dll) has a path of
    ///"c:\windows\system32\snapin.dll" and that the resource path is img/mon.gif:
    ///"res://c:\\windows\\system32\\snapin.dll/img/mon.bmp". If <i>szMouseOverBitmap</i> points to a <b>NULL</b>
    ///string, <i>szMouseOffBitmap</i> must be a valid string that contains the location of a valid image. If one of
    ///these strings is <b>NULL</b>, the other string is used for both. If both mouse image locations are <b>NULL</b>,
    ///the task is not displayed.
    ushort* szMouseOverBitmap;
    ///A pointer to a null-terminated string that contains the resource path to the image file for the image displayed
    ///for the task when the mouse is not in the task's image or text area. See <b>szMouseOverBitmap</b> for the format
    ///of the string. If <b>szMouseOffBitmap</b> points to a <b>NULL</b> string, <b>szMouseOverBitmap</b> must be a
    ///valid string that contains the location of a valid image. If one of these strings is <b>NULL</b>, the other
    ///string is used for both. If both mouse image locations are <b>NULL</b>, the task is not displayed.
    ushort* szMouseOffBitmap;
}

///The <b>MMC_TASK_DISPLAY_OBJECT</b> structure is introduced in MMC 1.1. The <b>MMC_TASK_DISPLAY_OBJECT</b> structure
///specifies the type of image and all the data required to use that image to display a task or the background on a
///taskpad. For that which displays the task image, the <b>MMC_TASK_DISPLAY_OBJECT</b> structure is the
///<b>sDisplayObject</b> member of the MMC_TASK structure, which is filled in by the IEnumTASK::Next method. For that
///which displays the background image, the <b>MMC_TASK_DISPLAY_OBJECT</b> structure is filled in by the
///IExtendTaskPad::GetBackground method.
struct MMC_TASK_DISPLAY_OBJECT
{
    ///Value of type MMC_TASK_DISPLAY_TYPE that specifies the type of image displayed as the background. The image can
    ///be one of three types: symbol, GIF, or bitmap.
    MMC_TASK_DISPLAY_TYPE eDisplayType;
    union
    {
        MMC_TASK_DISPLAY_BITMAP uBitmap;
        MMC_TASK_DISPLAY_SYMBOL uSymbol;
    }
}

///The <b>MMC_TASK</b> structure is introduced in MMC 1.1. The <b>MMC_TASK</b> structure is filled in by the
///IEnumTASK::Next method to specify all the data required to set up an individual task on a taskpad.
struct MMC_TASK
{
    ///MMC_TASK_DISPLAY_OBJECT structure that the snap-in must fill in to specify the image to be displayed as the image
    ///for the task in the taskpad specified by <b>pszGroup</b>.
    MMC_TASK_DISPLAY_OBJECT sDisplayObject;
    ///A pointer to a null-terminated string that contains the text placed directly to the right of the mouse-over
    ///image. This text serves as the label for the task. This text should be an action in the imperative such as "Add a
    ///new user."
    ushort*         szText;
    ///A pointer to a null-terminated string that contains the descriptive text placed in the upper-right corner when
    ///the user moves the mouse over the mouse-over image or the label text for the task. This text serves as the
    ///description for the task such as "Creates a new account, creates a mailbox, and sets up everything a user must
    ///access the network."
    ushort*         szHelpString;
    ///Value of type MMC_ACTION_TYPE that specifies the type of action triggered when a user clicks a task on a taskpad.
    ///There are three types of actions:
    MMC_ACTION_TYPE eActionType;
    union
    {
        ptrdiff_t nCommandID;
        ushort*   szActionURL;
        ushort*   szScript;
    }
}

///The <b>MMC_LISTPAD_INFO</b> structure is introduced in MMC 1.1. The <b>MMC_LISTPAD_INFO</b> structure is filled in by
///the IExtendTaskPad::GetListPadInfo method to specify the following information for a list view taskpad: <ul>
///<li>Title text for the list control</li> <li>Text for an optional button</li> <li>The command ID passed to
///IExtendTaskPad::TaskNotify when that button is clicked.</li> </ul>
struct MMC_LISTPAD_INFO
{
    ///A pointer to a null-terminated string that contains the text placed directly above the list control. This text
    ///can be the label for the objects within the list control (such as "Printers" if the list contains printers) or
    ///instructions (such as "Select a printer and click an action to perform."). If <b>szTitle</b> is <b>NULL</b> or
    ///empty, no title is displayed for the list control. Be aware that the <b>szTitle</b> member is not the same as the
    ///<i>pszTitle</i> parameter for IExtendTaskPad::GetTitle. The <b>IExtendTaskPad::GetTitle</b> method returns the
    ///title for the entire taskpad that appears at the top of the taskpad and appears on every standard MMC taskpad.
    ///The <b>szTitle</b> member of <b>MMC_LISTPAD_INFO</b> is the label for the list control and appears only on MMC
    ///list view taskpads.
    ushort*   szTitle;
    ///A pointer to a null-terminated string that contains the text placed on a button that is directly above the list
    ///control and to the right of the <b>szTitle</b> text. When the user clicks this button on the taskpad, MMC calls
    ///the IExtendTaskPad::TaskNotify method of the snap-in and passes the value specified in <b>nCommandID</b> as a
    ///VARIANT structure in the arg parameter. The <b>VARIANT</b> passed to <b>TaskNotify</b> has a <b>vt</b> member set
    ///to <b>VT_I4</b> and an <b>lVal</b> member that contains the command ID. To make the button to appear with no
    ///text, set <b>szButtonText</b> to an empty string. To hide this button to appear on the taskpad, set
    ///<b>szButtonText</b> to <b>NULL</b>.
    ushort*   szButtonText;
    ///Value that serves as an identifier for the button specified by <b>szButtonText</b>. It is recommended that you
    ///make this value unique to each taskpad to help identify the taskpad that sent the button-click notification. When
    ///the user clicks this button, MMC calls the IExtendTaskPad::TaskNotify method of the snap-in and passes this value
    ///as a VARIANT in the arg parameter. This value is ignored if <b>szButtonText</b> is <b>NULL</b>.
    ptrdiff_t nCommandID;
}

///The MMC_COLUMN_DATA structure is introduced in MMC 1.2. The MMC_COLUMN_DATA structure contains the column data of a
///single column in a column set. The column data is persisted in memory by MMC. The MMC_COLUMN_SET_DATA structure holds
///a pointer to an array of MMC_COLUMN_DATA structures.
struct MMC_COLUMN_DATA
{
    ///A zero-based index value of the column.
    int    nColIndex;
    ///A flag that is defined, HDI_HIDDEN (= 0x0001), which indicates that the column is hidden. The default value for
    ///the field is 0, indicating that the column is visible.
    uint   dwFlags;
    ///Width of the column.
    int    nWidth;
    ///Not currently used.
    size_t ulReserved;
}

///The MMC_COLUMN_SET_DATA structure is introduced in MMC 1.2. The MMC_COLUMN_SET_DATA structure is used with setting
///and retrieving list view column sets whose data is persisted in memory by MMC. The MMC_COLUMN_SET_DATA structure
///contains information about the number of columns in a particular column set as well as a pointer to persisted column
///data of the column set.
struct MMC_COLUMN_SET_DATA
{
    ///The size of the MMC_COLUMN_SET_DATA structure.
    int              cbSize;
    ///The number of columns in the column set.
    int              nNumCols;
    ///A pointer to an array of MMC_COLUMN_DATA structures that contains the persisted column set data.
    MMC_COLUMN_DATA* pColData;
}

///The MMC_SORT_DATA structure is introduced in MMC 1.2. The MMC_SORT_DATA structure contains the column sort data of a
///single column in a column set. This data is persisted in memory by MMC. A pointer to an array of these structures is
///held in the pSortData member of the MMC_SORT_SET_DATA structure.
struct MMC_SORT_DATA
{
    ///A zero-based index value of the column.
    int    nColIndex;
    ///Sort options to be used during the sort operation. This value can be a combination of the following:
    uint   dwSortOptions;
    ///Reserved for future use.
    size_t ulReserved;
}

///The MMC_SORT_SET_DATA structure is introduced in MMC 1.2. The MMC_SORT_SET_DATA structure is used with setting and
///retrieving list view column sets whose sort data is stored persistently. The MMC_SORT_SET_DATA structure contains
///information about the number of columns in a particular column set for which persistent sort data is being set or
///retrieved, as well as a pointer to an array of MMC_SORT_DATA structures that actually hold the sort data.
struct MMC_SORT_SET_DATA
{
    ///Size of the MMC_SORT_SET_DATA structure.
    int            cbSize;
    ///The number of columns in the column set for which persistent sort data is being set or retrieved. This value can
    ///be one of the following:
    int            nNumItems;
    ///A pointer to an array of MMC_SORT_DATA structures that hold the actual sort data. Should be set to <b>NULL</b> if
    ///nNumItems is set to 0.
    MMC_SORT_DATA* pSortData;
}

///The <b>RDITEMHDR</b> structure is introduced in MMC 1.2. The <b>RDITEMHDR</b> structure is used by the RDCOMPARE
///structure to specify the type and cookie value of a scope or result item.
struct RDITEMHDR
{
    ///A value that specifies whether the item is a scope or result item. If the <b>RDCI_ScopeItem</b> (0x80000000) flag
    ///is set, the item is a scope item. Otherwise, the item is a result item.
    uint      dwFlags;
    ///The unique identifier of the scope or result item object to be compared as part of the sorting operation.
    ptrdiff_t cookie;
    ///Reserved for future use.
    LPARAM    lpReserved;
}

///The <b>RDCOMPARE</b> structure is introduced in MMC 1.2. The <b>RDCOMPARE</b> structure is used by the
///IResultDataCompareEx::Compare method for specifying information used for sorting scope and result items in the result
///pane of a primary snap-in.
struct RDCOMPARE
{
    ///Size of this structure.
    uint       cbSize;
    ///Reserved. Always zero.
    uint       dwFlags;
    ///Column being sorted.
    int        nColumn;
    ///A value that specifies user-provided information that is passed into IResultData::Sort. MMC does not interpret
    ///this parameter.
    LPARAM     lUserParam;
    ///A pointer to an RDITEMHDR structure that specifies the first item's type (scope or result) and cookie.
    RDITEMHDR* prdch1;
    ///A pointer to an RDITEMHDR structure that specifies the second item's type (scope or result) and cookie.
    RDITEMHDR* prdch2;
}

///The <b>RESULT_VIEW_TYPE_INFO</b> structure is introduced in MMC 2.0. The <b>RESULT_VIEW_TYPE_INFO</b> structure is
///used in calls to IComponent2::GetResultViewType2 and IComponent2::RestoreResultView. A snap-in uses these two methods
///to include a result view in the navigational order maintained by MMC's <b>Back</b>/<b>Forward</b> buttons.
struct RESULT_VIEW_TYPE_INFO
{
    ///Snap-in-provided identifier for this view type. When implementing IComponent2::GetResultViewType2, this member
    ///must contain a valid view description string; otherwise, MMC will not initialize your snap-in. Additionally, this
    ///value must be created by means of CoTaskMemAlloc. It will be freed by MMC, not the snap-in.
    ushort*       pstrPersistableViewDescription;
    ///MMC_VIEW_TYPE enumeration value specifying the view type. This member is the structure's union discriminator and
    ///determines which members of the union are valid. This member is one of the following values.
    MMC_VIEW_TYPE eViewType;
    ///A value that specifies whether the view contains list views. If this value is
    ///<b>RVTI_MISC_OPTIONS_NOLISTVIEWS</b>, no list views are contained in the view (the console refrains from
    ///presenting standard list view choices on the <b>View</b> menu). Otherwise, this value is zero.
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

///The <b>CONTEXTMENUITEM2</b> structure is introduced in MMC 2.0. The <b>CONTEXTMENUITEM2</b> structure is passed to
///the IContextMenuCallback2::AddItem method or the IContextMenuProvider::AddItem method (inherited from
///IContextMenuCallback) to define a new menu item, submenu, or insertion point. The context menu is built from the root
///down, with each new item going to the end of the submenu or insertion point where the new item is inserted. The
///<b>CONTEXTMENUITEM2</b> structure supersedes the CONTEXTMENUITEM structure (other than the
///<b>strLanguageIndependentName</b> member, all of the members of <b>CONTEXTMENUITEM2</b> are in
///<b>CONTEXTMENUITEM</b>).
struct CONTEXTMENUITEM2
{
    ///A pointer to a null-terminated string that contains the name of the menu item or of the submenu. This member
    ///cannot be <b>NULL</b> except for a separator or insertion point.
    const(wchar)* strName;
    ///A pointer to a null-terminated string that contains the text that is displayed on the status bar when this item
    ///is highlighted. This member can be <b>NULL</b>.
    const(wchar)* strStatusBarText;
    ///A value that specifies the command identifier for menu items. If the menu item is added by
    ///IExtendContextMenu::AddMenuItems and then selected, <i>lCommandID</i> is the command ID parameter that is passed
    ///back to IExtendContextMenu::Command. If this menu item is added by the IContextMenuProvider interface and then
    ///selected, this is the command ID that is passed back to <i>pISelected</i> by
    ///IContextMenuProvider::ShowContextMenu. If this is an insertion point (<b>CCM_SPECIAL_INSERTION_POINT</b> is set
    ///in <i>fSpecialFlags</i>) or a submenu (<i>MF_POPUP</i> is set in <i>fFlags</i>), use <i>lCommandID</i> in
    ///subsequent calls as <i>lInsertionPointID</i> (for more information, see the following list). Carefully read the
    ///following discussion because specific bits in the new insertion point ID must be on and others must be off. The
    ///following bits in the command ID require special handling for items that are not insertion points or submenus.
    int           lCommandID;
    ///A value that specifies where in the context menu the new item should be added. Snap-ins can only add items to
    ///insertion points that are created by the menu creator or the primary snap-in. The following are the insertion
    ///points created by MMC in the default context menus for items in the scope pane and list view result pane:
    int           lInsertionPointID;
    ///A value that specifies one or more of the following style flags:
    int           fFlags;
    ///A value that specifies one or more of the following flags:
    int           fSpecialFlags;
    ///The language-independent name of the menu item. Retrieve this value in MMC 2.0 Automation Object Model
    ///applications by getting the MenuItem.LanguageIndependentName property. The <b>strLanguageIndependentName</b>
    ///member cannot be <b>NULL</b> or an empty string unless a separator or insertion point is added; otherwise, the
    ///IContextMenuCallback::AddItem method will fail with <b>E_INVALIDARG</b> as the return value.
    const(wchar)* strLanguageIndependentName;
}

///The <b>MMC_EXT_VIEW_DATA</b> structure is introduced in MMC 2.0. The <b>MMC_EXT_VIEW_DATA</b> structure is used by a
///view extension when it adds a view to the result pane.
struct MMC_EXT_VIEW_DATA
{
    ///GUID for the view; this value uniquely identifies the view and is used to restore the view.
    GUID    viewID;
    ///URL to the HTML used in the result pane; this typically points to an HTML resource in the snap-in's DLL.
    ushort* pszURL;
    ///Title of the view extension.
    ushort* pszViewTitle;
    ///This value is reserved for future use.
    ushort* pszTooltipText;
    ///If <b>TRUE</b>, the <b>Standard</b> tab does not appear in the tab selector; otherwise, the <b>Standard</b> tab
    ///appears. There is usually no need to display the <b>Standard</b> tab if the view extension snap-in displays the
    ///list of the primary snap-in.
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

///The <b>ISnapinProperties</b> interface enables a snap-in to initialize the snap-in's properties and receive
///notification when a property is added, changed, or deleted. The <b>ISnapinProperties</b> interface is implemented by
///the snap-in. The properties provided by the <b>ISnapinProperties</b> interface correspond to the Properties property
///of the SnapIn object. The <b>SnapIn</b> object is part of the MMC 2.0 automation object model.
@GUID("F7889DA9-4A02-4837-BF89-1A6F2A021010")
interface ISnapinProperties : IUnknown
{
    ///The <b>Initialize</b> method initializes a snap-in.
    ///Params:
    ///    pProperties = Properties collection that can be used by the snap-in for initialization.
    HRESULT Initialize(Properties pProperties);
    ///The <b>QueryPropertyNames</b> method returns the names of the properties used for the snap-in's configuration.
    ///Params:
    ///    pCallback = A pointer to the ISnapinPropertiesCallback interface; the snap-in can call
    ///                ISnapinPropertiesCallback::AddPropertyName to add the properties.
    HRESULT QueryPropertyNames(ISnapinPropertiesCallback pCallback);
    ///The <b>PropertiesChanged</b> method is called when a property is added, changed, or deleted. A snap-in can reject
    ///the change or deletion by returning E_FAIL.
    ///Params:
    ///    cProperties = The number of MMC_SNAPIN_PROPERTY structures provided by <i>pProperties</i>.
    ///    pProperties = An array of MMC_SNAPIN_PROPERTY structures.
    ///Returns:
    ///    If successful, the return value is <b>S_OK</b>; a snap-in can prevent a change or deletion from occurring by
    ///    returning <b>E_FAIL</b>.
    ///    
    HRESULT PropertiesChanged(int cProperties, char* pProperties);
}

///The <b>ISnapinPropertiesCallback</b> interface adds property names for the snap-in. This interface is implemented by
///MMC for the snap-in.
@GUID("A50FA2E5-7E61-45EB-A8D4-9A07B3E851A8")
interface ISnapinPropertiesCallback : IUnknown
{
    ///The <b>AddPropertyName</b> method adds a property, by name, for the snap-in to use.
    ///Params:
    ///    pszPropName = The property name.
    ///    dwFlags = This parameter can be one or more of the following flags.
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

///The <b>IComponentData</b> interface enables MMC to communicate with snap-ins. Similar to the IComponent interface,
///<b>IComponentData</b> is typically implemented at the document level and is closely associated with items (folders)
///being displayed in the scope pane.
@GUID("955AB28A-5218-11D0-A985-00C04FD8D565")
interface IComponentData : IUnknown
{
    ///The <b>IComponentData::Initialize</b> method provides an entry point to the console.
    ///Params:
    ///    pUnknown = A pointer to the console IUnknown interface. This interface pointer can be used to call QueryInterface for
    ///               IConsole2 and IConsoleNameSpace2.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Initialize(IUnknown pUnknown);
    ///The <b>IComponentData::CreateComponent</b> method creates an instance of the IComponent that will be associated
    ///with this IComponentData interface.
    ///Params:
    ///    ppComponent = A pointer to the location that stores the newly created pointer to IComponent.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT CreateComponent(IComponent* ppComponent);
    ///The <b>IComponentData::Notify</b> method notifies the snap-in of actions performed by the user.
    ///Params:
    ///    lpDataObject = A pointer to the data object of the currently selected item.
    ///    event = Identifies an action taken by a user. <b>IComponentData::Notify</b> can receive the following notifications:
    ///            MMCN_BTN_CLICK MMCN_DELETE MMCN_EXPAND MMCN_EXPANDSYNC MMCN_PRELOAD MMCN_PROPERTY_CHANGE MMCN_REMOVE_CHILDREN
    ///            MMCN_RENAME
    ///    arg = Depends on the notification type.
    ///    param = Depends on the notification type.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Notify(IDataObject lpDataObject, MMC_NOTIFY_TYPE event, LPARAM arg, LPARAM param3);
    ///The <b>IComponentData::Destroy</b> method releases all references to the console.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Destroy();
    ///The <b>IComponentData::QueryDataObject</b> method returns a data object that can be used to retrieve the context
    ///information for the specified cookie.
    ///Params:
    ///    cookie = A value that specifies the unique identifier for which the data object is required.
    ///    type = A value that specifies the data object as one of the following:
    ///    ppDataObject = A pointer to the address of the returned data object.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT QueryDataObject(ptrdiff_t cookie, DATA_OBJECT_TYPES type, IDataObject* ppDataObject);
    ///The <b>IComponentData::GetDisplayInfo</b> method retrieves display information for a scope item.
    ///Params:
    ///    pScopeDataItem = A pointer to a SCOPEDATAITEM structure. On input, the structure mask member specifies the type of information
    ///                     required and the lParam member identifies the item of interest.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetDisplayInfo(SCOPEDATAITEM* pScopeDataItem);
    ///The <b>IComponentData::CompareObjects</b> method enables a snap-in to compare two data objects acquired through
    ///QueryDataObject. Be aware that the data objects can be acquired from two different instances of IComponentData.
    ///Params:
    ///    lpDataObjectA = A pointer to the first data object exposing an IDataObject interface that is to be compared.
    ///    lpDataObjectB = A pointer to the second data object exposing an IDataObject interface that is to be compared.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT CompareObjects(IDataObject lpDataObjectA, IDataObject lpDataObjectB);
}

///The <b>IComponent</b> interface a base class for all derived interfaces such as IMPEG2Component and it describes the
///general characteristics of a component, which is an elementary stream within the program stream. The derived
///interfaces describe the properties of a component that are specific to a given network type. Component objects are
///created and attached to the tune request by the BDA Transport Information Filter (TIF) after reception has begun. All
///component objects also support <b>IPersistPropertyBag</b>.
@GUID("43136EB2-D36C-11CF-ADBC-00AA00A80033")
interface IComponent : IUnknown
{
    ///The <b>IComponent::Initialize</b> method provides an entry point to the console. At this point, the snap-in
    ///should set up the toolbar. If the snap-in uses the default list view it should also set up the list view's
    ///headers and add images to be used in the result pane.
    ///Params:
    ///    lpConsole = A pointer to the console IConsole interface.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Initialize(IConsole lpConsole);
    ///The <b>IComponent::Notify</b> method notifies the snap-in of actions taken by the user.
    ///Params:
    ///    lpDataObject = A pointer to the data object of the currently selected item.
    ///    event = Identifies an action taken by a user. <b>IComponent::Notify</b> can receive the following notifications:
    ///            MMCN_ACTIVATE MMCN_ADD_IMAGES MMCN_BTN_CLICK MMCN_COLUMN_CLICK MMCN_COLUMNS_CHANGED MMCN_CONTEXTHELP
    ///            MMCN_DBLCLICK MMCN_DELETE MMCN_DESELECT_ALL MMCN_FILTERBTN_CLICK MMCN_FILTER_CHANGE MMCN_INITOCX MMCN_LISTPAD
    ///            MMCN_MINIMIZED MMCN_PASTE MMCN_PRINT MMCN_PROPERTY_CHANGE MMCN_QUERY_PASTE MMCN_REFRESH MMCN_RENAME
    ///            MMCN_RESTORE_VIEW MMCN_SELECT MMCN_SHOW MMCN_SNAPINHELP MMCN_VIEW_CHANGE
    ///    arg = Depends on the notification type.
    ///    param = Depends on the notification type.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Notify(IDataObject lpDataObject, MMC_NOTIFY_TYPE event, LPARAM arg, LPARAM param3);
    ///The IComponent::Destroy method releases all references to the console that are held by this component.
    ///Params:
    ///    cookie = Reserved for future use.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Destroy(ptrdiff_t cookie);
    ///The <b>IComponent::QueryDataObject</b> method returns a data object that can be used to retrieve context
    ///information for the specified cookie.
    ///Params:
    ///    cookie = A value that specifies the unique identifier for which the data object is required. When called for virtual
    ///             list items, which do not have cookies, this parameter is set to the item list index.
    ///    type = A value that specifies the data object as one of the following.
    ///    ppDataObject = A pointer to the address of the returned data object.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT QueryDataObject(ptrdiff_t cookie, DATA_OBJECT_TYPES type, IDataObject* ppDataObject);
    ///The <b>IComponent::GetResultViewType</b> method determines what the result pane view should be.
    ///Params:
    ///    cookie = A value that specifies the snapin-provided unique identifier for the scope item. For more details about
    ///             cookies in MMC, see Cookies.
    ///    ppViewType = A pointer to the address of a string that specifies the view to display for the specified <i>cookie</i>. The
    ///                 callee (snap-in) allocates the view type string using the COM API function CoTaskMemAlloc and the caller
    ///                 (MMC) frees it using CoTaskMemFree. The string that is returned depends on the view type:
    ///    pViewOptions = A pointer to the value that provides the console with options specified by the owning snap-in. This value can
    ///                   be a combination of the following:
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetResultViewType(ptrdiff_t cookie, ushort** ppViewType, int* pViewOptions);
    ///The <b>IComponent::GetDisplayInfo</b> method retrieves display information for an item in the result pane.
    ///Params:
    ///    pResultDataItem = A pointer to a RESULTDATAITEM structure. On input, the mask member specifies the type of data required and
    ///                      the lParam member identifies the item of interest. When called for a virtual list, the nIndex member
    ///                      identifies the desired virtual item and the lParam member is zero.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetDisplayInfo(RESULTDATAITEM* pResultDataItem);
    ///The <b>IComponent::CompareObjects</b> method enables a snap-in to compare two data objects acquired through
    ///IComponent::QueryDataObject. Be aware that data objects can be acquired from two different instances of
    ///IComponent.
    ///Params:
    ///    lpDataObjectA = A pointer to the first object exposing an IDataObject interface that is to be compared.
    ///    lpDataObjectB = A pointer to the second object exposing an IDataObject interface that is to be compared.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT CompareObjects(IDataObject lpDataObjectA, IDataObject lpDataObjectB);
}

///The <b>IResultDataCompare</b> interface allows primary snap-ins to compare result items that are displayed in a
///sorted order in the result pane. MMC uses a primary snap-in's implementation of this interface for all results items.
///Scope items from either the primary snap-in or any extensions are left unsorted at the top of the list. The
///<b>IResultDataCompare</b> interface differs from the IResultDataCompareEx interface. <b>IResultDataCompareEx</b>
///allows primary snap-ins to compare both scope and result items.
@GUID("E8315A52-7A1A-11D0-A2D2-00C04FD909DD")
interface IResultDataCompare : IUnknown
{
    ///The <b>IResultDataCompare::Compare</b> method provides a way for a primary snap-in to compare cookies for the
    ///purpose of sorting the result items that it inserts in the result pane. The <b>IResultDataCompare::Compare</b>
    ///method cannot be used for scope items. However, this functionality is provided by the
    ///IResultDataCompareEx::Compare method.
    ///Params:
    ///    lUserParam = A value that specifies user-provided information that is passed into IResultData::Sort. MMC does not
    ///                 interpret this parameter.
    ///    cookieA = The unique identifier of the first result item object to be compared as part of the sorting operation.
    ///    cookieB = The unique identifier of the second result item object to be compared as part of the sorting operation.
    ///    pnResult = As an in parameter, the argument contains the column that is sorted. As an out parameter, the value of the
    ///               argument should be: <ul> <li>-1 if item 1 &lt; item 2</li> <li>zero (0) if item 1 == item 2</li> <li>1 if
    ///               item 1 &gt; item 2</li> </ul>
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Compare(LPARAM lUserParam, ptrdiff_t cookieA, ptrdiff_t cookieB, int* pnResult);
}

///The <b>IResultOwnerData</b> interface supports the use of virtual lists, which are list-view controls that have the
///LVS_OWNERDATA style set. The methods of this interface are applicable only to virtual lists. This is an optional
///interface and snap-ins can implement it for enhanced virtual list performance and functionality.
@GUID("9CB396D8-EA83-11D0-AEF1-00C04FB6DD2C")
interface IResultOwnerData : IUnknown
{
    ///The <b>IResultOwnerData::FindItem</b> method finds the next item in a virtual list matching a specified string.
    ///Params:
    ///    pFindInfo = A pointer to the RESULTFINDINFO structure.
    ///    pnFoundIndex = A pointer to the returned index of the item found. The value is –1 if no items are found.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT FindItem(RESULTFINDINFO* pFindInfo, int* pnFoundIndex);
    ///The <b>IResultOwnerData::CacheHint</b> method is called when a virtual list is about to request display
    ///information for a range of items, allowing the snap-in to collect the information ahead of time in cases where an
    ///optimization can be made.
    ///Params:
    ///    nStartIndex = An index of the first item to be requested.
    ///    nEndIndex = An index of the last item to be requested.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT CacheHint(int nStartIndex, int nEndIndex);
    ///The <b>IResultOwnerData::SortItems</b> method sorts the items of a virtual result list.
    ///Params:
    ///    nColumn = An index of the column header clicked.
    ///    dwSortOptions = The sort options to be used during the sort operation. This value can be a combination of the following:
    ///    lUserParam = A user parameter passed in an IResultData::Sort call, <b>NULL</b> if the user initiated the sort.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SortItems(int nColumn, uint dwSortOptions, LPARAM lUserParam);
}

///<div class="alert"><b>Note</b> This interface is obsolete, and only used in MMC 1.0.</div><div> </div>Enables
///communication with the console.
@GUID("43136EB1-D36C-11CF-ADBC-00AA00A80033")
interface IConsole : IUnknown
{
    ///<div class="alert"><b>Note</b> The <b>IConsole::SetHeader</b> method is obsolete in MMC version 1.1 and later. It
    ///is no longer required by snap-ins. However, the method can still safely be used by snap-ins that already call
    ///it.</div><div> </div>Sets the header interface to use for this instance of IComponent. This is used only by
    ///instances of <b>IComponent</b>.
    ///Params:
    ///    pHeader = A pointer to the <b>IHeaderCtrl</b> interface.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SetHeader(IHeaderCtrl pHeader);
    ///Sets the toolbar interface to be used for this instance of IComponent. Be aware that this is used only by
    ///instances of <b>IComponent</b>.
    ///Params:
    ///    pToolbar = A pointer to the IToolbar interface.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SetToolbar(IToolbar pToolbar);
    ///Queries IConsole for the result view object IUnknown interface pointer.
    ///Params:
    ///    pUnknown = A pointer to the location of the IUnknown interface pointer to the result view object.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT QueryResultView(IUnknown* pUnknown);
    ///Queries the console-provided scope pane image list.
    ///Params:
    ///    ppImageList = The address of a variable that receives the scope pane IImageList interface pointer.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT QueryScopeImageList(IImageList* ppImageList);
    ///Retrieves the console-provided result-view image list. This image list should be used only if the snap-in is
    ///using the default list view.
    ///Params:
    ///    ppImageList = Address of a variable that receives the IImageList interface pointer.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT QueryResultImageList(IImageList* ppImageList);
    ///Called by a snap-in when there is a content change in the result pane. This method can be called either by
    ///IComponent or IComponentData.
    ///Params:
    ///    lpDataObject = A pointer to a user-supplied data object.
    ///    data = A user-defined value, for example a pointer to the modified content.
    ///    hint = A user-defined value, for example information about the type of content change.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT UpdateAllViews(IDataObject lpDataObject, LPARAM data, ptrdiff_t hint);
    HRESULT MessageBoxA(const(wchar)* lpszText, const(wchar)* lpszTitle, uint fuStyle, int* piRetval);
    ///Queries for the IConsoleVerb interface.
    ///Params:
    ///    ppConsoleVerb = A pointer to the address of a variable that receives the IConsoleVerb interface pointer.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT QueryConsoleVerb(IConsoleVerb* ppConsoleVerb);
    ///Selects the given scope item.
    ///Params:
    ///    hScopeItem = A handle to the item in the scope pane to be selected.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SelectScopeItem(ptrdiff_t hScopeItem);
    ///Retrieves a handle to the main frame window.
    ///Params:
    ///    phwnd = A pointer to a variable that receives the window handle.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetMainWindow(HWND* phwnd);
    ///Creates a new multiple-document interface (MDI) child window rooted at the specified scope item.
    ///Params:
    ///    hScopeItem = The scope item that forms the root of the new window.
    ///    lOptions = Options used to create the new window are listed in the following list.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT NewWindow(ptrdiff_t hScopeItem, uint lOptions);
}

///<div class="alert"><b>Note</b> This interface is obsolete, and only used in MMC 1.0.</div><div> </div>Enables the
///manipulation of columns and indicates the kind of information that is to be presented in the result view pane of the
///console. These methods provide support for users to filter list views based on filters set on each column in the
///result view. Be aware that a return value of <b>E_NOTIMPL</b> by any one of these methods indicates that list view
///filtering is not available in the version of MMC in which the snap-in is loaded. The <b>IHeaderCtrl</b> interface can
///be queried from the IConsole interface passed into IComponent::Initialize during the component's creation.
@GUID("43136EB3-D36C-11CF-ADBC-00AA00A80033")
interface IHeaderCtrl : IUnknown
{
    ///Adds a column to a default result pane.
    ///Params:
    ///    nCol = A zero-based index of the column being inserted.
    ///    title = A value that specifies the string that represents the title of the column being inserted. This string can
    ///            have a maximum length of <b>MAX_PATH</b> characters.
    ///    nFormat = A value that specifies the position of text within the column. For column zero, <i>nFormat</i> must be
    ///              <b>LVCFMT_LEFT</b>. This value must be one of the following:
    ///    nWidth = A value that specifies the width of the column in pixels. This value must be one of the following:
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT InsertColumn(int nCol, const(wchar)* title, int nFormat, int nWidth);
    ///Removes a column from the header of the result view.
    ///Params:
    ///    nCol = A zero-based index that identifies the column to be removed.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT DeleteColumn(int nCol);
    ///Sets the text of the title in a specific column.
    ///Params:
    ///    nCol = A zero-based index that specifies the location of the column.
    ///    title = A pointer to the string that represents the title of the column being inserted. This string can have a
    ///            maximum length of MAX_PATH characters.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SetColumnText(int nCol, const(wchar)* title);
    ///Retrieves text from a specified column.
    ///Params:
    ///    nCol = A zero-based index that identifies the column from which the text is to be retrieved.
    ///    pText = A pointer to the address of the text to be retrieved. This pointer must not be <b>NULL</b>. The user must
    ///            call <b>CoTaskMemFree</b> on the returned text.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetColumnText(int nCol, ushort** pText);
    ///Sets the width, in pixels, of a specific column.
    ///Params:
    ///    nCol = A zero-based index that specifies the location of the column relative to other columns in the result pane.
    ///    nWidth = A value that specifies the width of the column. This value must be in pixels, or it can be the following
    ///             value:
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SetColumnWidth(int nCol, int nWidth);
    ///Retrieves the width, in pixels, of the column.
    ///Params:
    ///    nCol = A zero-based index of the column from which the width is to be retrieved.
    ///    pWidth = A pointer to width, in pixels, of the column. This parameter must not be <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetColumnWidth(int nCol, int* pWidth);
}

///The <b>IContextMenuCallback</b> interface is used to add menu items to a context menu.
@GUID("43136EB7-D36C-11CF-ADBC-00AA00A80033")
interface IContextMenuCallback : IUnknown
{
    ///The <b>IContextMenuCallback::AddItem</b> method adds a single item to a context menu.
    ///Params:
    ///    pItem = A pointer to a CONTEXTMENUITEM structure with the item to be added. This parameter cannot be <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT AddItem(CONTEXTMENUITEM* pItem);
}

///The <b>IContextMenuProvider</b> interface implements methods that create new context menus, for the purpose of adding
///items to those menus, to enable extensions to extend those menus, and to display the resulting context menus.
@GUID("43136EB6-D36C-11CF-ADBC-00AA00A80033")
interface IContextMenuProvider : IContextMenuCallback
{
    ///The <b>IContextMenuProvider::EmptyMenuList</b> method clears a context menu.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT EmptyMenuList();
    ///The <b>IContextMenuProvider::AddPrimaryExtensionItems</b> method enables one specific extension to add items to
    ///the insertion points defined for this context menu.
    ///Params:
    ///    piExtension = A pointer to an IUnknown interface on the object that implements the IExtendContextMenu interface for the
    ///                  primary extension.
    ///    piDataObject = A pointer to the IDataObject interface on the object whose context menu is extended.
    ///Returns:
    ///    Other values can be returned, depending on the implementation of IExtendContextMenu::AddMenuItems by the
    ///    specified snap-in.
    ///    
    HRESULT AddPrimaryExtensionItems(IUnknown piExtension, IDataObject piDataObject);
    ///The <b>IContextMenuProvider::AddThirdPartyExtensionItems</b> method enables third-party extensions to add items
    ///at specified insertion points in this context menu. MMC checks its list of snap-ins registered to extend objects
    ///of this node type and offers each (if there are any) the opportunity to extend the context menu by calling
    ///IExtendContextMenu::AddMenuItems.
    ///Params:
    ///    piDataObject = A pointer to the IDataObject interface on the object whose menu is extended.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT AddThirdPartyExtensionItems(IDataObject piDataObject);
    ///The <b>IContextMenuProvider::ShowContextMenu</b> method displays a context menu.
    ///Params:
    ///    hwndParent = A handle to the parent window in which the context menu is displayed.
    ///    xPos = A value, in screen coordinates, that specifies the horizontal location of the upper-left corner of the
    ///           context menu, in screen coordinates.
    ///    yPos = A value, in screen coordinates, that specifies the vertical location of the upper-left corner of the context
    ///           menu.
    ///    plSelected = A value that specifies the ICommandID value (as passed to IContextMenuCallback::AddItem) of the selected menu
    ///                 item. If this is zero, either none of the context menu items were selected or the selected context menu item
    ///                 was added by an extension. If an extension item was selected, ShowContextMenu notifies the extension by
    ///                 calling IExtendContextMenu::Command.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT ShowContextMenu(HWND hwndParent, int xPos, int yPos, int* plSelected);
}

///The <b>IExtendContextMenu</b> interface enables a snap-in to add items to an existing context menu. This is how
///extensions add menu items to the context menus for the objects that they insert into the scope pane or list view
///result pane. This interface is also the means by which third-party context menu extensions add items to the context
///menus of node types that they extend. When a user right-clicks items that belong to a snap-in and are also in the
///scope pane or list view result pane, MMC generates a default context menu. The snap-in that added the item is offered
///an opportunity to extend the context menu as a primary extension. MMC then offers all registered and enabled
///extensions the opportunity to add additional menu items.
@GUID("4F3B7A4F-CFAC-11CF-B8E3-00C04FD8D5B0")
interface IExtendContextMenu : IUnknown
{
    ///The <b>IExtendContextMenu::AddMenuItems</b> method enables a snap-in to add items to a context menu.
    ///Params:
    ///    piDataObject = A pointer to the IDataObject interface on the data object of the menu to which items are added.
    ///    piCallback = A pointer to an IContextMenuCallback that can add items to the context menu.
    ///    pInsertionAllowed = A value that identifies MMC-defined menu-item insertion points that can be used. This can be a combination of
    ///                        the following flags:
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT AddMenuItems(IDataObject piDataObject, IContextMenuCallback piCallback, int* pInsertionAllowed);
    ///The <b>IExtendContextMenu::Command</b> method is called if one of the items you added to the context menu with
    ///IExtendContextMenu::AddMenuItems is subsequently selected. MMC calls Command with the command ID you specified
    ///and another pointer to the same IDataObject interface.
    ///Params:
    ///    lCommandID = A value that specifies the command identifier of the menu item.
    ///    piDataObject = A pointer to the IDataObject interface on the object whose context menu was displayed.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Command(int lCommandID, IDataObject piDataObject);
}

///The <b>IImageList</b> interface enables the user to insert images to be used as icons for items in the result or
///scope pane of the console. When an image is inserted, an index is passed in and associated with the image. Any time
///the image is to be used, the user can refer to it by the index that he or she assigned. Be aware that because the
///image list is shared among many components, the user-specified index is a "virtual" index that gets mapped internally
///to the actual index.
@GUID("43136EB8-D36C-11CF-ADBC-00AA00A80033")
interface IImageList : IUnknown
{
    ///The <b>IImageList::ImageListSetIcon</b> method enables a user to set an icon in the image list or to create an
    ///icon if it is not there.
    ///Params:
    ///    pIcon = A value that specifies the Win32 HICON handle to the icon to set. The type must be cast as a pointer to a
    ///            LONG_PTR. The snap-in owns this resource and must free it when finished. A resource memory leak will occur if
    ///            the snap-in does not free Icon.
    ///    nLoc = A value that specifies the index assigned to the entry. This is a virtual index that is internally mapped to
    ///           the actual index.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT ImageListSetIcon(ptrdiff_t* pIcon, int nLoc);
    ///The <b>IImageList::ImageListSetStrip</b> method enables a user to add a strip of icons to the image list using a
    ///pair of bitmaps (large and small icons), starting at a location identified by nStartLoc.
    ///Params:
    ///    pBMapSm = Win32 HBITMAP handle to the small (16x16) icon image strip. The snap-in owns this resource and must free it
    ///              when finished. A resource memory leak will occur if the snap-in does not free BMapSm.
    ///    pBMapLg = Win32 HBITMAP handle to the large (32x32) icon image strip. The snap-in owns this resource and must free it
    ///              when finished. A resource memory leak will occur if the snap-in does not free BMapLg.
    ///    nStartLoc = A value that specifies the index assigned to the first image in the strip. This is a virtual index that is
    ///                internally mapped to the actual index.
    ///    cMask = A value that specifies the color used to generate a mask.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT ImageListSetStrip(ptrdiff_t* pBMapSm, ptrdiff_t* pBMapLg, int nStartLoc, uint cMask);
}

///The <b>IResultData</b> interface enables a user to add, remove, find, and modify items associated with the result
///view pane. It also enables the manipulation of the view style of the result view pane. The <b>IResultData</b>
///interface was designed to give the impression that the result view pane would be used by only one component, but
///components should be aware that the result view pane can, in fact, be shared by several components. All item
///manipulations are performed through the use of an item ID assigned when the item is inserted. This ID is guaranteed
///to be both static and unique for the life of the item. When an item is deleted, the ID is freed and can be used by
///other new items in the list. You should never keep an item ID around after its associated item has been deleted. The
///<b>IResultData</b> interface handles virtual (owner data) lists as well. Because of the nature of virtual lists, not
///all methods apply and some methods have limited functionality. These differences are detailed in the descriptions of
///individual methods. The primary difference in handling virtual lists it that because the console does not maintain
///any storage for virtual items, it does not provide item IDs. Instead virtual list items are identified by their list
///position (index).
@GUID("31DA5FA0-E0EB-11CF-9F21-00AA003CA9F6")
interface IResultData : IUnknown
{
    ///The <b>IResultData::InsertItem</b> method enables the snap-in to add a single new item to the result pane view.
    ///Params:
    ///    item = A pointer to a RESULTDATAITEM structure that contains information about the item to be added. After the item
    ///           is inserted, a unique identifier (an item ID) is assigned to it by MMC and returned through the <b>itemID</b>
    ///           member of the structure pointed to by the item parameter. Be aware that the <b>itemID</b> value is the
    ///           <b>HRESULTITEM</b> handle of the inserted item. The snap-in should store this value in order to later
    ///           manipulate the inserted item by calling methods such as IResultData::GetItem. If this identifier is not
    ///           stored, it can be looked up using IResultData::FindItemByLParam.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT InsertItem(RESULTDATAITEM* item);
    ///The <b>IResultData::DeleteItem</b> method enables the snap-in to delete a single item in the result view pane.
    ///Params:
    ///    itemID = A value that specifies the unique ID of the item to be deleted. When applied to virtual lists, pass the item
    ///             index instead of the itemID.
    ///    nCol = Not used. Must be zero.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT DeleteItem(ptrdiff_t itemID, int nCol);
    ///The <b>IResultData::FindItemByLParam</b> method enables the snap-in to find an item or subitem based on its
    ///user-inserted lParam value.
    ///Params:
    ///    lParam = A generic 32-bit value in which information can be stored.
    ///    pItemID = A pointer to an item identifier to hold the results of the search for the lParam value.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT FindItemByLParam(LPARAM lParam, ptrdiff_t* pItemID);
    ///The <b>IResultData::DeleteAllRsltItems</b> method enables the snap-in to remove all user-inserted items and
    ///subitems from the result view pane.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT DeleteAllRsltItems();
    ///The <b>IResultData::SetItem</b> method enables the snap-in to set a single item in the result pane.
    ///Params:
    ///    item = A pointer to a RESULTDATAITEM structure that contains information about the item to be changed.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SetItem(RESULTDATAITEM* item);
    ///The <b>IResultData::GetItem</b> method enables a user to retrieve the parameters of a single item.
    ///Params:
    ///    item = A pointer to a RESULTDATAITEM structure that contains information about the item whose parameters are being
    ///           retrieved.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetItem(RESULTDATAITEM* item);
    ///The <b>IResultData::GetNextItem</b> method gets the next item in the result view with the specified state flags
    ///set.
    ///Params:
    ///    item = A pointer to a RESULTDATAITEM structure that contains information about the item to be obtained. The
    ///           <b>nIndex</b> member should be set to the index at which to start the search, or to –1 to start at the
    ///           first item. The specified index is excluded from the search. The <b>nState</b> member should specify which
    ///           state flags must be set on the returned item. The <b>nIndex</b> member will be updated to the index of the
    ///           found item (or –1, if none is found). The <b>bScopeItem</b> and <b>lParam</b> members will be set according
    ///           to the found item.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetNextItem(RESULTDATAITEM* item);
    ///The <b>IResultData::ModifyItemState</b> method enables the snap-in to modify the state of an item.
    ///Params:
    ///    nIndex = A value that specifies the index of the item whose state is to be modified. This parameter is used only when
    ///             the itemID parameter is zero. When applied to virtual lists, you must use nIndex and set itemID to zero.
    ///    itemID = Unique identifier of the item whose state is to be modified. When applied to virtual lists, set itemID = 0.
    ///    uAdd = A value that specifies which Windows list-view state flags can be set. When applied to virtual lists, only
    ///           focus and select states can be modified. This value can be any valid combination of the following:
    ///    uRemove = A value that specifies the list-view item state flags that can be removed. This value can be any valid
    ///              combination of the preceding Win32 LVIS_* flags shown for the uAdd parameter.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT ModifyItemState(int nIndex, ptrdiff_t itemID, uint uAdd, uint uRemove);
    ///The <b>IResultData::ModifyViewStyle</b> method enables the snap-in to set the result pane's view style.
    ///Params:
    ///    add = A value that specifies the view style (or styles) to be set in the result view pane. This value can be a
    ///          valid combination of the following:
    ///    remove = A value that specifies the view style (or styles) to be removed from the result view pane. This value can be
    ///             a valid combination of the preceding flags shown for the add parameter. As described there, these values are
    ///             from the MMC_RESULT_VIEW_STYLE enumeration and correspond to the Win32 LVS_* flags of the same names.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT ModifyViewStyle(MMC_RESULT_VIEW_STYLE add, MMC_RESULT_VIEW_STYLE remove);
    ///The <b>IResultData::SetViewMode</b> method enables the snap-in to set the view mode in which the result view pane
    ///displays its items. Be aware that view modes apply only to list views.
    ///Params:
    ///    lViewMode = A value that specifies the view mode to be set in the result pane. It can be one of the following values:
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SetViewMode(int lViewMode);
    ///The <b>IResultData::GetViewMode</b> method enables the snap-in to retrieve a view mode for the result view pane.
    ///Be aware that view modes only apply to list views.
    ///Params:
    ///    lViewMode = A pointer to the view mode to be retrieved. It can be one of the following:
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetViewMode(int* lViewMode);
    ///The <b>IResultData::UpdateItem</b> method causes a specified item in the result pane to be redrawn.
    ///Params:
    ///    itemID = A value that specifies the unique identifier of the item to be redrawn in the result pane. When applied to
    ///             virtual lists, pass the item index instead of the itemID.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT UpdateItem(ptrdiff_t itemID);
    ///The <b>IResultData::Sort</b> method sorts all items in the result pane.
    ///Params:
    ///    nColumn = An index of the column header clicked.
    ///    dwSortOptions = The sort options to be used during the sort operation. This value can be a combination of the following:
    ///    lUserParam = A value that specifies information determined by the user. This parameter can contain a variety of entries
    ///                 such as including sort order or context information.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Sort(int nColumn, uint dwSortOptions, LPARAM lUserParam);
    ///The <b>IResultData::SetDescBarText</b> method sets the description bar text for the result view pane.
    ///Params:
    ///    DescText = A pointer to a null-terminated string that contains text to be displayed in the description bar.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SetDescBarText(ushort* DescText);
    ///The <b>IResultData::SetItemCount</b> method sets the number of items in a virtual list.
    ///Params:
    ///    nItemCount = The number of items that the control will contain.
    ///    dwOptions = Combination of the following flags:
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SetItemCount(int nItemCount, uint dwOptions);
}

///<div class="alert"><b>Note</b> This interface is obsolete, and only used in MMC 1.0.</div><div> </div>Enables
///snap-ins to enumerate dynamic subcontainers in the scope pane. The particular snap-in determines what qualifies as a
///subcontainer. For example, a snap-in that features a domain object might enumerate individual groups or organizations
///within the domain. The snap-in can query for a pointer to the <b>IConsoleNameSpace</b> interface during a call to its
///IComponentData::Initialize method.
@GUID("BEDEB620-F24D-11CF-8AFC-00AA003CA9F6")
interface IConsoleNameSpace : IUnknown
{
    ///The <b>IConsoleNameSpace2::InsertItem</b> method enables the snap-in to insert a single item into the scope view.
    ///Params:
    ///    item = A pointer to a SCOPEDATAITEM structure that specifies the attributes of the new scope item. On return, the ID
    ///           member of the structure contains the item identifier assigned by MMC for the newly inserted item. Be aware
    ///           that this value is the <b>HSCOPEITEM</b> handle of the inserted item. The snap-in should store this value in
    ///           order to later manipulate the inserted item by calling methods such as IConsoleNameSpace2::GetItem.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT InsertItem(SCOPEDATAITEM* item);
    ///The <b>IConsoleNameSpace2::DeleteItem</b> method IConsoleNameSpaceenables the snap-in to delete a single item
    ///from the scope pane.
    ///Params:
    ///    hItem = A handle to the item whose child items are to be deleted from the scope pane. If the second argument to
    ///            <b>IConsoleNameSpace2::DeleteItem</b> is set to <b>TRUE</b>, the item is also deleted.
    ///    fDeleteThis = If <b>TRUE</b>, the item specified by hItem is also deleted; otherwise, it is not.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT DeleteItem(ptrdiff_t hItem, int fDeleteThis);
    ///The <b>IConsoleNameSpace2::SetItem</b> method enables the snap-in to set the attributes of a single scope-view
    ///item.
    ///Params:
    ///    item = A pointer to a SCOPEDATAITEM structure that contains information about the item to be set in the scope pane.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SetItem(SCOPEDATAITEM* item);
    ///The <b>IConsoleNameSpace2::GetItem</b> method enables the snap-in to retrieve some or all of a single scope
    ///item's attributes.
    ///Params:
    ///    item = A pointer to a SCOPEDATAITEM structure that specifies the information to retrieve and receives information
    ///           about the item. When the message is sent, the ID member of the structure identifies the item and the mask
    ///           member specifies the attributes to retrieve. If mask specifies the <b>SDI_STATE</b> value, the <b>nState</b>
    ///           member contains the item's state information.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetItem(SCOPEDATAITEM* item);
    ///The <b>IConsoleNameSpace2::GetChildItem</b> method enables the snap-in to get the handle to a child item in the
    ///scope pane.
    ///Params:
    ///    item = A handle to a parent item in the scope pane.
    ///    pItemChild = A pointer to the handle that identifies the child item in the scope pane that has been returned.
    ///    pCookie = A pointer to the cookie associated with the child item that has been returned.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetChildItem(ptrdiff_t item, ptrdiff_t* pItemChild, ptrdiff_t* pCookie);
    ///The <b>IConsoleNameSpace2::GetNextItem</b> method enables the snap-in to retrieve the handle to the next item in
    ///the scope view.
    ///Params:
    ///    item = A handle to an item in the scope pane.
    ///    pItemNext = A pointer to the handle to the next item in the scope pane that has been returned.
    ///    pCookie = A pointer to the cookie of the next item that has been returned.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetNextItem(ptrdiff_t item, ptrdiff_t* pItemNext, ptrdiff_t* pCookie);
    ///The <b>IConsoleNameSpace2::GetParentItem</b> method enables the snap-in to retrieve the handle to a parent item
    ///in the scope view.
    ///Params:
    ///    item = A handle to an item in the scope pane.
    ///    pItemParent = A pointer to the handle to the parent item that is returned.
    ///    pCookie = A pointer to the cookie associated with the parent item that is returned.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetParentItem(ptrdiff_t item, ptrdiff_t* pItemParent, ptrdiff_t* pCookie);
}

///The <b>IConsoleNameSpace2</b> interface is introduced in MMC 1.1. The <b>IConsoleNameSpace2</b> interface enables
///snap-ins to enumerate dynamic subcontainers in the scope pane. The particular snap-in determines what qualifies as a
///subcontainer. For example, a snap-in that features a domain object might enumerate individual groups or organizations
///within the domain. <b>IConsoleNameSpace2</b> supersedes the <b>IConsoleNameSpace</b> interface for MMC 1.1. In
///addition to inheriting all of the methods of <b>IConsoleNameSpace</b>, <b>IConsoleNameSpace2</b> has the following
///methods: <ul> <li> IConsoleNameSpace2::Expand </li> <li> IConsoleNameSpace2::AddExtension </li> </ul>The snap-in can
///query for a pointer to the <b>IConsoleNameSpace2</b> interface during a call to its IComponentData::Initialize
///method.
@GUID("255F18CC-65DB-11D1-A7DC-00C04FD8D565")
interface IConsoleNameSpace2 : IConsoleNameSpace
{
    ///The <b>IConsoleNameSpace2::Expand</b> method enables the snap-in to expand an item in the namespace without
    ///visibly expanding the item in the scope pane.
    ///Params:
    ///    hItem = A handle to the item to expand.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Expand(ptrdiff_t hItem);
    ///The <b>IConsoleNameSpace2::AddExtension</b> method enables the snap-in to add an extension snap-in that
    ///dynamically extends the namespace of a selected item.
    ///Params:
    ///    hItem = A handle to the item to extend with the snap-in specified by <i>lpClsid</i>.
    ///    lpClsid = A pointer to the <b>CLSID</b> of the snap-in that will extend the namespace of the item specified by
    ///              <i>hItem</i>.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT AddExtension(ptrdiff_t hItem, GUID* lpClsid);
}

///The <b>IPropertySheetCallback</b> interface is a COM-based interface used by a snap-in to add its property pages to a
///property sheet.
@GUID("85DE64DD-EF21-11CF-A285-00C04FD8DBE6")
interface IPropertySheetCallback : IUnknown
{
    ///The <b>IPropertySheetCallback::AddPage</b> method enables a snap-in to add a page to a property sheet.
    ///Params:
    ///    hPage = A value that specifies the handle to the page to be added. The hPage parameter is a handle to a PROPSHEETPAGE
    ///            structure created by the Windows API CreatePropertySheetPage.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT AddPage(HPROPSHEETPAGE hPage);
    ///The <b>IPropertySheetCallback::RemovePage</b> method enables a snap-in to remove a page from a property sheet.
    ///Params:
    ///    hPage = A handle to the page to be removed.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT RemovePage(HPROPSHEETPAGE hPage);
}

///The <b>IPropertySheetProvider</b> interface implements Windows property sheets as COM objects. A property sheet
///object contains the code required to handle modeless operation and determining which other snap-ins are extending the
///node type. The size of the property sheet is set by the primary snap-in and extensions are forced to accept that
///size.
@GUID("85DE64DE-EF21-11CF-A285-00C04FD8DBE6")
interface IPropertySheetProvider : IUnknown
{
    ///The <b>IPropertySheetProvider::CreatePropertySheet</b> method creates a property sheet frame.
    ///Params:
    ///    title = A pointer to a null-terminated string that contains the title of the property page. This parameter cannot be
    ///            <b>NULL</b>.
    ///    type = <b>TRUE</b> creates a property sheet and <b>FALSE</b> creates a wizard.
    ///    cookie = Cookie value of the currently selected item. This can be <b>NULL</b> when CreatePropertySheet is called by an
    ///             extension snap-in.
    ///    pIDataObjectm = A pointer to the IDataObject interface on the data object for the cookie. If the value of this parameter is
    ///                    <b>NULL</b>, MMC will not call any of the IExtendPropertySheet2 methods implemented by extension snap-ins.
    ///    dwOptions = A value that specifies the flags that can be set by the method call. The parameter can be a combination of
    ///                the following values:
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT CreatePropertySheet(const(wchar)* title, ubyte type, ptrdiff_t cookie, IDataObject pIDataObjectm, 
                                uint dwOptions);
    ///The <b>IPropertySheetProvider::FindPropertySheet</b> method determines whether a specific property sheet exists.
    ///Params:
    ///    hItem = A handle to the selected item in the scope pane.
    ///    lpComponent = A pointer to the IComponent interface on the selected object. <b>NULL</b> if the object selected is a folder
    ///                  (on the scope or result panes), and <b>IComponent</b> of the snap-in if it is a result pane leaf item.
    ///    lpDataObject = A pointer to the IDataObject interface on the data object.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT FindPropertySheet(ptrdiff_t hItem, IComponent lpComponent, IDataObject lpDataObject);
    ///The <b>IPropertySheetProvider::AddPrimaryPages</b> method collects the pages from the primary snap-in.
    ///Params:
    ///    lpUnknown = A pointer to snap-in interface that will be queried for the <b>IExtendPropertySheet</b> interface. If
    ///                <i>bCreateHandle</i> is set to <b>TRUE</b>, this should also be a pointer to the snap-in's IComponent or
    ///                IComponentData interface that will be queried for <b>IExtendPropertySheet</b>. Be aware that this value can
    ///                be <b>NULL</b>. See Remarks for details.
    ///    bCreateHandle = A value that specifies whether to create a console-provided notification handle that is used to route the
    ///                    MMCN_PROPERTY_CHANGE notification to the appropriate <b>IComponent</b> or <b>IComponentData</b> interface
    ///                    during calls to MMCPropertyChangeNotify. The notification handle is passed back to the snap-in during calls
    ///                    to the snap-in's implementation of the IExtendPropertySheet2::CreatePropertyPages method. If
    ///                    <i>bCreateHandle</i> is set to <b>TRUE</b>, the <i>lpUnknown</i> parameter should be a pointer to the
    ///                    <b>IComponent</b> or <b>IComponentData</b> that receives the MMCN_PROPERTY_CHANGE notification.
    ///    hNotifyWindow = Reserved for future use. This value should be <b>NULL</b>.
    ///    bScopePane = Set to <b>TRUE</b> if the item is in the scope pane. Set to <b>FALSE</b> if it is in the result pane.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT AddPrimaryPages(IUnknown lpUnknown, BOOL bCreateHandle, HWND hNotifyWindow, BOOL bScopePane);
    ///The <b>IPropertySheetProvider::AddExtensionPages</b> method collects the pages from the extension snap-ins.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT AddExtensionPages();
    ///If the type that has been set in IPropertySheetProvider::CreatePropertySheet is a property sheet,
    ///<b>IPropertySheetProvider::Show</b> displays a property sheet frame that is parented to a hidden window. If the
    ///type that has been set in <b>IPropertySheetProvider::CreatePropertySheet</b> is a wizard,
    ///<b>IPropertySheetProvider::Show</b> displays a property sheet frame parented to the handle that is passed to this
    ///method.
    ///Params:
    ///    window = A value that specifies the handle to the parent window.
    ///    page = A value that specifies which page on the property sheet is shown. It is zero-indexed.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Show(ptrdiff_t window, int page);
}

///<div class="alert"><b>Note</b> This interface is obsolete, and only used in MMC 1.0.</div><div> </div>Enables a
///snap-in component to add pages to the property sheet of an item.
@GUID("85DE64DC-EF21-11CF-A285-00C04FD8DBE6")
interface IExtendPropertySheet : IUnknown
{
    ///Adds pages to a property sheet.
    ///Params:
    ///    lpProvider = A pointer to the IPropertySheetCallback interface.
    ///    handle = A value that specifies the handle used to route the MMCN_PROPERTY_CHANGE notification message to the
    ///             appropriate IComponent or IComponentData interface. For snap-ins that use the IPropertySheetProvider
    ///             interface directly, MMC creates the handle when the snap-in calls IPropertySheetProvider::AddPrimaryPages and
    ///             specifies its bCreateHandle to be <b>TRUE</b>.
    ///    lpIDataObject = A pointer to the IDataObject interface on the object that contains context information about the scope or
    ///                    result item.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT CreatePropertyPages(IPropertySheetCallback lpProvider, ptrdiff_t handle, IDataObject lpIDataObject);
    ///Determines whether the object requires pages.
    ///Params:
    ///    lpDataObject = A pointer to the IDataObject interface on the object that contains context information about the scope or
    ///                   result item.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT QueryPagesFor(IDataObject lpDataObject);
}

///The <b>IControlbar</b> interface provides a way to create toolbars and other controls.
@GUID("69FB811E-6C1C-11D0-A2CB-00C04FD909DD")
interface IControlbar : IUnknown
{
    ///The <b>IControlbar::Create</b> method creates and returns the control requested by the snap-in.
    ///Params:
    ///    nType = A value that specifies the type of control to be associated; taken from the MMC_CONTROL_TYPE enumeration.
    ///    pExtendControlbar = A pointer to the snap-in's IExtendControlbar interface that is to be associated with the control (toolbar or
    ///                        menu button) that will be created. Notifications generated by the new control will be sent to
    ///                        IExtendControlBar::ControlbarNotify.
    ///    ppUnknown = A pointer to the address of the IUnknown interface of the control that was created.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Create(MMC_CONTROL_TYPE nType, IExtendControlbar pExtendControlbar, IUnknown* ppUnknown);
    ///The <b>IControlbar::Attach</b> method allows the snap-in to associate a control with a control bar.
    ///Params:
    ///    nType = A value that specifies the type of control to be associated with the control bar, taken from the
    ///            MMC_CONTROL_TYPE enumeration.
    ///    lpUnknown = A pointer to the IUnknown interface on the control object to be inserted.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Attach(MMC_CONTROL_TYPE nType, IUnknown lpUnknown);
    ///The <b>IControlbar::Detach</b> method breaks the association between a control and the control bar. This command
    ///removes or detaches the control from the control bar on which it is displayed.
    ///Params:
    ///    lpUnknown = A pointer to the IUnknown interface on the control object that represents the control removed.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Detach(IUnknown lpUnknown);
}

///The <b>IExtendControlbar</b> interface enables an extension to add control bars to the console. This provides a way
///to improve the functionality and appearance of your snap-in by adding toolbars or other user interface enhancements.
@GUID("49506520-6F40-11D0-A98B-00C04FD8D565")
interface IExtendControlbar : IUnknown
{
    ///The <b>IExtendControlbar::SetControlbar</b> method attaches or detaches a control bar.
    ///Params:
    ///    pControlbar = A pointer to an IControlbar interface on the control bar object to be set. A non-<b>NULL</b> value attaches a
    ///                  control bar; a <b>NULL</b> value detaches a control bar.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SetControlbar(IControlbar pControlbar);
    ///The <b>IExtendControlbar::ControlbarNotify</b> method specifies the notification sent to the snap-in from the
    ///console as a result of user action.
    ///Params:
    ///    event = A value that specifies one of the following:
    ///    arg = Depends on the event parameter. For more information, see MMC Notifications.
    ///    param = Depends on the event parameter. For more information, see MMC Notifications.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT ControlbarNotify(MMC_NOTIFY_TYPE event, LPARAM arg, LPARAM param2);
}

///The <b>IToolbar</b> interface is used to create new toolbars, to add items to them, to extend the toolbars, and to
///display the resultant new toolbars. Each toolbar is created on its own band within the control bar.
@GUID("43136EB9-D36C-11CF-ADBC-00AA00A80033")
interface IToolbar : IUnknown
{
    ///The <b>IToolbar::AddBitmap</b> method enables a snap-in to add an image to the toolbar.
    ///Params:
    ///    nImages = An index of images that are available. A value that specifies the number of images in the bitmap being passed
    ///              in hbmp.
    ///    hbmp = A handle to the bitmap to be added to the toolbar. <div class="alert"><b>Note</b> The snap-in owns this
    ///           resource and must free it. A memory leak will occur if the snap-in does not free hbmp.</div> <div> </div>
    ///    cxSize = The height, in pixels, of the bitmap to be added. (In version 1.0, MMC only supported a cxSize of 16.)
    ///    cySize = The width, in pixels, of the bitmap to be added. (In version 1.0, MMC only supported a cySize of 16.)
    ///    crMask = The color used to generate a mask to overlay the images on the toolbar buttons.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT AddBitmap(int nImages, HBITMAP hbmp, int cxSize, int cySize, uint crMask);
    ///The <b>IToolbar::AddButtons</b> method enables a snap-in to add an array of buttons to the toolbar.
    ///Params:
    ///    nButtons = The number of buttons in the array.
    ///    lpButtons = A pointer to the MMCBUTTON structure that contains information necessary for creating a button on the
    ///                toolbar.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT AddButtons(int nButtons, MMCBUTTON* lpButtons);
    ///The <b>IToolbar::InsertButton</b> method enables a snap-in to add a single button to the toolbar. The button
    ///being added is placed at the end of the toolbar.
    ///Params:
    ///    nIndex = An internal index at which the button will be inserted. The button is always placed at the end of the
    ///             toolbar; the internal index is required if the button is to be deleted (by means of IToolbar::DeleteButton).
    ///    lpButton = A pointer to the MMCBUTTON structure that defines the button to be inserted.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT InsertButton(int nIndex, MMCBUTTON* lpButton);
    ///The <b>IToolbar::DeleteButton</b> method enables a snap-in to remove a specified toolbar button.
    ///Params:
    ///    nIndex = An index of the button to be removed from the toolbar.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT DeleteButton(int nIndex);
    ///The <b>IToolbar::GetButtonState</b> method enables a snap-in to obtain an attribute of a button.
    ///Params:
    ///    idCommand = The command identifier of the toolbar button.
    ///    nState = A value that identifies the possible states of the button. Can be one of the following:
    ///    pState = A pointer to the state information that is returned.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetButtonState(int idCommand, MMC_BUTTON_STATE nState, int* pState);
    ///The <b>IToolbar::SetButtonState</b> method enables a snap-in to set an attribute of a button.
    ///Params:
    ///    idCommand = A unique value that the snap-in has associated with a button using the InsertButton or AddButtons method
    ///                using the MMCBUTTON structure.
    ///    nState = A value that specifies the state to be set for the button. Can be any one of the following:
    ///    bState = A value that specifies whether the state identified in nState is set to <b>TRUE</b> or <b>FALSE</b>.
    ///             <b>TRUE</b> sets the button state to the state identified by nState and <b>FALSE</b> clears the state (if it
    ///             is already set).
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SetButtonState(int idCommand, MMC_BUTTON_STATE nState, BOOL bState);
}

///The <b>IConsoleVerb</b> interface allows snap-ins to enable standard verbs including cut, copy, paste, delete,
///properties, rename, refresh, and print. When an item is selected, the snap-in can update the state of these verbs.
@GUID("E49F7A60-74AF-11D0-A286-00C04FD8FE93")
interface IConsoleVerb : IUnknown
{
    ///The GetVerbState method enables a snap-in to obtain a given verb's current state.
    ///Params:
    ///    eCmdID = A value that specifies the command identifier of the verb. Taken from the MMC_CONSOLE_VERB enumeration. This
    ///             value cannot be MMC_VERB_NONE.
    ///    nState = A value that identifies the possible states of the button. Taken from the MMC_BUTTON_STATE enumeration.
    ///    pState = A pointer to the state information returned. <b>TRUE</b> if the state is enabled or hidden and <b>FALSE</b>
    ///             if the state is disabled or visible.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetVerbState(MMC_CONSOLE_VERB eCmdID, MMC_BUTTON_STATE nState, int* pState);
    ///The SetVerbState method enables a snap-in to set a given verb's button state.
    ///Params:
    ///    eCmdID = A value that specifies the command identifier of the verb. Values are taken from the MMC_CONSOLE_VERB
    ///             enumeration. This value cannot be MMC_VERB_NONE.
    ///    nState = Identifies the possible states of the button. Taken from the MMC_BUTTON_STATE enumeration.
    ///    bState = This value is <b>TRUE</b> to enable or hide the verb, <b>FALSE</b> to disable or show the selected verb.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SetVerbState(MMC_CONSOLE_VERB eCmdID, MMC_BUTTON_STATE nState, BOOL bState);
    ///The <b>SetDefaultVerb</b> method sets the default action on an object.
    ///Params:
    ///    eCmdID = The default verb.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SetDefaultVerb(MMC_CONSOLE_VERB eCmdID);
    ///The GetDefaultVerb method gets the snap-in's default verb.
    ///Params:
    ///    peCmdID = A pointer to where the snap-in's default verb is returned.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetDefaultVerb(MMC_CONSOLE_VERB* peCmdID);
}

///The <b>ISnapinAbout</b> interface enables the console to get copyright and version information from a snap-in. The
///console also uses this interface to obtain images for the static folder from the snap-in.
@GUID("1245208C-A151-11D0-A7D7-00C04FD909DD")
interface ISnapinAbout : IUnknown
{
    ///The ISnapinAbout::GetSnapinDescription method enables the console to obtain the text for the snap-in's
    ///description box.
    ///Params:
    ///    lpDescription = A pointer to the text for the description box on an <b>About</b> property page.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetSnapinDescription(ushort** lpDescription);
    ///The <b>ISnapinAbout::GetProvider</b> method enables the console to obtain the snap-in provider name.
    ///Params:
    ///    lpName = A pointer to the text of the snap-in provider name.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetProvider(ushort** lpName);
    ///The ISnapinAbout::GetSnapinVersion method enables the console to obtain the snap-in's version number.
    ///Params:
    ///    lpVersion = A pointer to the text of the snap-in version number.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetSnapinVersion(ushort** lpVersion);
    ///The <b>ISnapinAbout::GetSnapinImage</b> method enables the console to obtain the snap-in's main icon to be used
    ///in the About box.
    ///Params:
    ///    hAppIcon = A pointer to the handle to the main icon of the snap-in that is to be used in the About property page.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetSnapinImage(HICON* hAppIcon);
    ///The <b>ISnapinAbout::GetStaticFolderImage</b> method allows the console to obtain the static folder images for
    ///the scope and result panes.
    ///Params:
    ///    hSmallImage = A pointer to the handle to a small icon (16x16 pixels) in either the scope or result view pane.
    ///    hSmallImageOpen = A pointer to the handle to a small open-folder icon (16x16 pixels).
    ///    hLargeImage = A pointer to the handle to a large icon (32x32 pixels).
    ///    cMask = A pointer to a COLORREF structure that specifies the color used to generate a mask.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetStaticFolderImage(HBITMAP* hSmallImage, HBITMAP* hSmallImageOpen, HBITMAP* hLargeImage, uint* cMask);
}

///The <b>IMenuButton</b> interface enables the user to add and manage menu buttons for a snap-in. MMC provides one menu
///bar per view; when a snap-in has the focus you can add one or more menu buttons for the view to this bar. These
///buttons are always added by appending them to the buttons already in the menu bar.
@GUID("951ED750-D080-11D0-B197-000000000000")
interface IMenuButton : IUnknown
{
    ///The <b>IMenuButton::AddButton</b> method enables a user to add a button to the MMC menu bar for a particular
    ///view.
    ///Params:
    ///    idCommand = A value that specifies a user-supplied value that uniquely identifies the button to be added to the menu bar.
    ///    lpButtonText = A pointer to the text value (a null-terminated string) to be displayed on the button.
    ///    lpTooltipText = A pointer to the text value (a null-terminated string) to be displayed when the user places the mouse pointer
    ///                    on the button.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT AddButton(int idCommand, ushort* lpButtonText, ushort* lpTooltipText);
    ///The <b>IMenuButton::SetButton</b> method enables a user to set the text attributes of a button in the menu bar
    ///that is changed.
    ///Params:
    ///    idCommand = A value that specifies a user-supplied value that uniquely identifies the button to be added to the menu bar.
    ///    lpButtonText = A pointer to the text value (a null-terminated string) to be displayed on the button.
    ///    lpTooltipText = A pointer to the text value (a null-terminated string) to be displayed when the user places the mouse pointer
    ///                    on the button.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SetButton(int idCommand, ushort* lpButtonText, ushort* lpTooltipText);
    ///The <b>IMenuButton::SetButtonState</b> method enables a user to change the state of a menu button.
    ///Params:
    ///    idCommand = A value that specifies a user-supplied value that uniquely identifies the menu button in which the state is
    ///                being changed.
    ///    nState = A value that specifies the state of the button. This value can be one of the following values taken from the
    ///             MMC_BUTTON_STATE enumeration:
    ///    bState = A value that specifies whether the state is to be turned on or off. <b>TRUE</b> indicates that the button
    ///             state is on; otherwise, set to <b>FALSE</b>.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SetButtonState(int idCommand, MMC_BUTTON_STATE nState, BOOL bState);
}

///<div class="alert"><b>Note</b> This interface is obsolete, and only used in MMC 1.0.</div><div> </div>Allows snap-ins
///to add HTML Help support.
@GUID("A6B15ACE-DF59-11D0-A7DD-00C04FD909DD")
interface ISnapinHelp : IUnknown
{
    ///Enables a snap-in to add its compiled HTML Help file to the MMC Help collection file.
    ///Params:
    ///    lpCompiledHelpFile = A pointer to the address of the null-terminated Unicode string that contains the path of the compiled Help
    ///                         file (.chm) for the snap-in. When specifying the path, place the file anywhere and specify the full path
    ///                         name.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetHelpTopic(ushort** lpCompiledHelpFile);
}

///The <b>IExtendPropertySheet2</b> interface is introduced in MMC 1.1. The <b>IExtendPropertySheet2</b> interface
///enables a snap-in component to add pages to the property sheet of an item. <b>IExtendPropertySheet2</b> supersedes
///the <b>IExtendPropertySheet</b> interface for MMC 1.1. In addition to inheriting all of the methods of
///<b>IExtendPropertySheet</b>, <b>IExtendPropertySheet2</b> has the following method:
///IExtendPropertySheet2::GetWatermarks
@GUID("B7A87232-4A51-11D1-A7EA-00C04FD909DD")
interface IExtendPropertySheet2 : IExtendPropertySheet
{
    ///The <b>IExtendPropertySheet2::GetWatermarks</b> method gets the watermark bitmap and header bitmap for wizard
    ///sheets implemented as Wizard 97-style wizards.
    ///Params:
    ///    lpIDataObject = A pointer to the IDataObject interface on the object that contains context information about the scope or
    ///                    result item.
    ///    lphWatermark = A pointer to the handle to a bitmap that serves as the watermark for Wizard 97 pages. If the handle to the
    ///                   bitmap is <b>NULL</b>, no watermark is displayed for the wizard. If this value is not <b>NULL</b>, then the
    ///                   snap-in, for compatibility, should manage the lifetime of the watermark resource. The snap-in is responsible
    ///                   for freeing the watermark resource.
    ///    lphHeader = A pointer to the handle to a bitmap that serves as the header for Wizard 97 pages. If the handle to the
    ///                bitmap is <b>NULL</b>, no bitmap will be displayed in the header for wizard pages. If this value is not
    ///                <b>NULL</b>, then the snap-in, for compatibility, should manage the lifetime of the header resource. The
    ///                snap-in is responsible for freeing the header resource.
    ///    lphPalette = A pointer to the handle to a palette that should be used for the bitmaps specified by lphWatermark and
    ///                 lphHeader. The palette is <b>NULL</b> by default. If a palette is not returned, the palette is <b>NULL</b>.
    ///                 If this value is not <b>NULL</b>, then the snap-in, for compatibility, should manage the lifetime of the
    ///                 palette resource. The snap-in is responsible for freeing the palette resource.
    ///    bStretch = A value that specifies whether the watermark and header bitmaps should be stretched — instead of tiled —
    ///               to fit the background or header area of the property sheet. <b>TRUE</b> specifies that the watermark and
    ///               header bitmaps should be stretched; <b>FALSE</b> specifies that the watermark and header bitmaps should
    ///               maintain their size and be tiled. This parameter is <b>FALSE</b> by default. If a <i>bStretch</i> value is
    ///               not returned, <i>bStretch</i> is <b>FALSE</b>.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetWatermarks(IDataObject lpIDataObject, HBITMAP* lphWatermark, HBITMAP* lphHeader, 
                          HPALETTE* lphPalette, int* bStretch);
}

///The <b>IHeaderCtrl2</b> interface is introduced in MMC 1.2. The <b>IHeaderCtrl2</b> interface enables the
///manipulation of columns and indicates the kind of information that is to be presented in the result view pane of the
///console. <b>IHeaderCtrl2</b> is a new version of the <b>IHeaderCtrl</b> interface for MMC 1.2. <b>IHeaderCtrl2</b> is
///the same as <b>IHeaderCtrl</b> with the addition of the following methods: <ul> <li> SetChangeTimeOut </li> <li>
///SetColumnFilter </li> <li> GetColumnFilter </li> </ul>These methods provide support for users to filter list views
///based on filters set on each column in the result view. Be aware that a return value of <b>E_NOTIMPL</b> by any one
///of these methods indicates that list view filtering is not available in the version of MMC in which the snap-in is
///loaded. The <b>IHeaderCtrl2</b> interface can be queried from the IConsole interface passed into
///IComponent::Initialize during the component's creation.
@GUID("9757ABB8-1B32-11D1-A7CE-00C04FD8D565")
interface IHeaderCtrl2 : IHeaderCtrl
{
    ///The <b>IHeaderCtrl2::SetChangeTimeOut</b> sets the time-out interval between the time a change takes place in the
    ///filter attributes and the posting of an MMCN_FILTER_CHANGE filter change notification, which is sent to the
    ///snap-in's IComponent::Notify method.
    ///Params:
    ///    uTimeout = Filter change interval in milliseconds. The default is an implementation detail of the header control, and as
    ///               a result MMC does not know about it.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SetChangeTimeOut(uint uTimeout);
    ///The <b>IHeaderCtrl2::SetColumnFilter</b> sets the filter value and its maximum character length for a specified
    ///column in a filtered list.
    ///Params:
    ///    nColumn = A zero-based index that identifies the column for which the filter value and its maximum character length are
    ///              to be set.
    ///    dwType = Filter type to apply to the specified column, taken from the MMC_FILTER_TYPE enumeration.
    ///    pFilterData = A pointer to an MMC_FILTERDATA structure that holds the actual filter data.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SetColumnFilter(uint nColumn, uint dwType, MMC_FILTERDATA* pFilterData);
    ///The <b>IHeaderCtrl2::GetColumnFilter</b> method retrieves the filter value set on the specified column.
    ///Params:
    ///    nColumn = A zero-based index that identifies the column for which the filter value and its maximum character length are
    ///              to be retrieved.
    ///    pdwType = A pointer to a variable of type <b>DWORD</b> that can take one of the possible filter values specified in the
    ///              MMC_FILTER_TYPE enumeration. The filter type for the specified column is placed in the address pointed to by
    ///              <i>pdwType</i>.
    ///    pFilterData = A pointer to an MMC_FILTERDATA structure that holds the actual filter data.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetColumnFilter(uint nColumn, uint* pdwType, MMC_FILTERDATA* pFilterData);
}

///The <b>ISnapinHelp2</b> interface is introduced in MMC 1.1. The <b>ISnapinHelp2</b> interface allows snap-ins to add
///HTML Help support.<b>ISnapinHelp2</b> is a new version of the <b>ISnapinHelp</b> interface for MMC 1.1.
///<b>ISnapinHelp2</b> is the same as <b>ISnapinHelp</b> with the addition of the following method: <ul> <li>
///ISnapinHelp2::GetLinkedTopics </li> </ul>
@GUID("4861A010-20F9-11D2-A510-00C04FB6DD2C")
interface ISnapinHelp2 : ISnapinHelp
{
    ///The <b>ISnapinHelp2::GetLinkedTopics</b> method enables a snap-in to specify the names and locations of any HTML
    ///Help files that are linked to the snap-in's Help file (specified in the GetHelpTopic method).
    ///Params:
    ///    lpCompiledHelpFiles = A pointer to the address of the null-terminated Unicode string that contains the path of one or more compiled
    ///                          Help files (.chm) that are linked to the snap-in's Help file. A semicolon is used to separate multiple file
    ///                          paths from each other. When specifying the path, place the file anywhere and specify the full path name.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetLinkedTopics(ushort** lpCompiledHelpFiles);
}

///The <b>IEnumTASK</b> interface is introduced in MMC 1.1. The <b>IEnumTASK</b> interface enables a snap-in component
///to enumerate the tasks to add to a taskpad.
@GUID("338698B1-5A02-11D1-9FEC-00600832DB4A")
interface IEnumTASK : IUnknown
{
    ///The <b>IEnumTASK::Next</b> method enables MMC to retrieve the next task in the snap-in's list of tasks.
    ///Params:
    ///    celt = A value that specifies the number of tasks to provide. MMC always enumerates tasks one at a time; therefore,
    ///           celt is always 1.
    ///    rgelt = A pointer to an MMC_TASK structure that the snap-in fills in to represent the task to add to the taskpad. Be
    ///            aware that the caller (MMC) allocates the memory for the structure.
    ///    pceltFetched = A pointer to a value that specifies the number of tasks returned. If the snap-in successfully returned one or
    ///                   more tasks, set the value to the number of tasks that were successfully returned. Because MMC always requests
    ///                   one task at a time (celt is always 1), pceltFetched should be set to 1 if the task was successfully returned.
    ///                   If the snap-in has no more tasks in its list, or if the snap-in fails to fill in the MMC_TASK structure, set
    ///                   the value to 0.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Next(uint celt, MMC_TASK* rgelt, uint* pceltFetched);
    ///The <b>IEnumTASK::Skip</b> method skips the specified number of tasks in the snap-in's list of tasks. MMC does
    ///not use this method. It must be included for completeness.
    ///Params:
    ///    celt = A value that specifies the number of tasks to skip relative to the current task in the list.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Skip(uint celt);
    ///The <b>IEnumTASK::Reset</b> method enables MMC to reset the enumeration to the beginning of the snap-in's task
    ///list.
    HRESULT Reset();
    ///The <b>IEnumTASK::Clone</b> method creates a new IEnumTASK object that has the same state as this IEnumTASK
    ///object. MMC does not use this method. It must be included for completeness.
    ///Params:
    ///    ppenum = A pointer to address of IEnumTASK interface pointer for the cloned IEnumTASK object.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Clone(IEnumTASK* ppenum);
}

///The <b>IExtendTaskPad</b> interface is introduced in MMC 1.1. The <b>IExtendTaskPad</b> interface enables a snap-in
///component to set up a taskpad and receive notifications from the taskpad.
@GUID("8DEE6511-554D-11D1-9FEA-00600832DB4A")
interface IExtendTaskPad : IUnknown
{
    ///The <b>IExtendTaskPad::TaskNotify</b> method enables MMC to notify the snap-in when a task is extended. If the
    ///taskpad is a list-view taskpad, MMC also calls <b>IExtendTaskPad::TaskNotify</b> when a list-view button is
    ///extended.
    ///Params:
    ///    pdo = A pointer to the data object for the scope item that owns the taskpad. If your snap-in owns the item that
    ///          displays the taskpad, pdo is a pointer to that item. If your snap-in is extending the taskpad of another
    ///          snap-in, pdo is a pointer to the item in the snap-in that owns the taskpad.
    ///    arg = A pointer to a VARIANT structure that contains information passed back from the CIC control on the taskpad.
    ///          Taskpads using MMC taskpad templates For the MMC-supplied taskpads, the VARIANT structure contains the
    ///          command ID for the taskpad task or list-view button that was ed. The vt field is VT_I4 and the lVal field
    ///          contains the command ID for the taskpad task or list-view button that was ed. List-view buttons apply only to
    ///          list-view taskpads. A task command ID is specified in the nCommandID member of the MMC_TASK structure, which
    ///          is passed in the IEnumTASK::Next method that MMC calls when it retrieves the information for that task during
    ///          the setup of the taskpad. A list-view button is the button specified in the szButtonText member of the
    ///          MMC_LISTPAD_INFO structure, which is passed in the IExtendTaskPad::GetListPadInfo method that MMC calls when
    ///          it is setting up the list-view taskpad. The list-view button command ID is specified in the nCommandID member
    ///          of MMC_LISTPAD_INFO. Taskpads using custom HTML pages For custom taskpads, the VARIANT structure can contain
    ///          any data that the script on the custom HTML page wants to pass through the CIC object TaskNotify method
    ///    param = A pointer to a VARIANT structure that contains information passed back from the CIC control on the taskpad.
    ///            Taskpads that use the MMC taskpad templates ignore this parameter. However, custom taskpads can use it to
    ///            pass an additional value back to the snap-in.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT TaskNotify(IDataObject pdo, VARIANT* arg, VARIANT* param2);
    ///The <b>IExtendTaskPad::EnumTasks</b> method enables MMC to get a pointer to the IEnumTASK interface of the object
    ///that contains the snap-in's tasks.
    ///Params:
    ///    pdo = A pointer to the data object for the scope item that owns the taskpad.
    ///    szTaskGroup = A pointer to a null-terminated string that contains the group name that identifies the taskpad. The group
    ///                  name is the string that follows the hash (
    ///    ppEnumTASK = A pointer to address of IEnumTASK interface of the object that contains the snap-in's tasks.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT EnumTasks(IDataObject pdo, ushort* szTaskGroup, IEnumTASK* ppEnumTASK);
    ///The <b>IExtendTaskPad::GetTitle</b> method enables MMC to get the taskpad title text to display in taskpads that
    ///use MMC taskpad templates.
    ///Params:
    ///    pszGroup = A pointer to a null-terminated string that contains the group name that identifies the taskpad. The group
    ///               name is the string that follows the hash (
    ///    pszTitle = A pointer to the address of a null-terminated string that contains the title for the taskpad specified by
    ///               <i>pszGroup</i>. This text is displayed at the top of the taskpad as the title for the entire taskpad. If
    ///               <i>pszTitle</i> points to a <b>NULL</b> string, no title is displayed.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetTitle(ushort* pszGroup, ushort** pszTitle);
    ///The <b>IExtendTaskPad::GetDescriptiveText</b> method enables MMC to get the taskpad's descriptive text to display
    ///in taskpads that use MMC taskpad templates.
    ///Params:
    ///    pszGroup = A pointer to a null-terminated string that contains the group name that identifies the taskpad. The group
    ///               name is the string that follows the hash (
    ///    pszDescriptiveText = A pointer to the address of a null-terminated string that contains the descriptive text for the taskpad
    ///                         specified by pszGroup. This text is displayed at the top of the taskpad beneath the title for the entire
    ///                         taskpad. This text can be a phrase that serves as a subtitle or instructions (such as "Click an action to
    ///                         perform."). If pszDescriptiveText points to a <b>NULL</b> string, no descriptive text is displayed.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetDescriptiveText(ushort* pszGroup, ushort** pszDescriptiveText);
    ///The <b>IExtendTaskPad::GetBackground</b> method enables MMC to get the taskpad's background image to display in
    ///taskpads that use MMC taskpad templates.
    ///Params:
    ///    pszGroup = A pointer to a null-terminated string that contains the group name that identifies the taskpad. The group
    ///               name is the string that follows the hash (
    ///    pTDO = A pointer to an MMC_TASK_DISPLAY_OBJECT structure that the snap-in must fill in to specify the image to be
    ///           displayed as the background for the taskpad specified by pszGroup. Be aware that the caller (MMC) allocates
    ///           the memory for the MMC_TASK_DISPLAY_OBJECT structure.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetBackground(ushort* pszGroup, MMC_TASK_DISPLAY_OBJECT* pTDO);
    ///The <b>IExtendTaskPad::GetListPadInfo</b> method is used for list-view taskpads only. It enables MMC to get the
    ///title text for the list control, the text for an optional button, and the command ID passed to
    ///IExtendTaskPad::TaskNotify when that optional button is clicked.
    ///Params:
    ///    pszGroup = A pointer to a null-terminated string that contains the group name that identifies the taskpad. The group
    ///               name is the string that follows the hash (
    ///    lpListPadInfo = A pointer to an MMC_LISTPAD_INFO structure that the snap-in must fill in with the title text for the list
    ///                    control, the text for an optional button, and the command ID passed to IExtendTaskPad::TaskNotify when that
    ///                    optional button is clicked. Be aware that the caller (MMC) allocates the memory for the MMC_LISTPAD_INFO
    ///                    structure.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetListPadInfo(ushort* pszGroup, MMC_LISTPAD_INFO* lpListPadInfo);
}

///The <b>IConsole2</b> interface is introduced in MMC 1.1. The <b>IConsole2</b> interface enables communication with
///the console. <b>IConsole2</b> is the same as <b>IConsole</b> with the addition of the following methods: <ul> <li>
///IConsole2::Expand </li> <li> IConsole2::IsTaskpadViewPreferred </li> <li> IConsole2::SetStatusText </li> </ul>
@GUID("103D842A-AA63-11D1-A7E1-00C04FD8D565")
interface IConsole2 : IConsole
{
    ///The <b>IConsole2::Expand</b> method enables the snap-in to expand or collapse an item in the scope pane.
    ///Params:
    ///    hItem = A handle to the item to expand.
    ///    bExpand = A value that specifies whether to expand or collapse the item. <b>TRUE</b> expands the item. <b>FALSE</b>
    ///              collapses the item.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Expand(ptrdiff_t hItem, BOOL bExpand);
    ///The <b>IConsole2::IsTaskpadViewPreferred</b> method is obsolete. It always returns <b>S_OK</b>.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT IsTaskpadViewPreferred();
    ///The <b>IConsole2::SetStatusText</b> method enables the snap-in to change the text in the status bar. Be aware
    ///that this is used only by instances of IComponent.
    ///Params:
    ///    pszStatusText = A pointer to a null-terminated string that contains text to be displayed in the status bar.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SetStatusText(ushort* pszStatusText);
}

///The <b>IDisplayHelp</b> interface is introduced in MMC version 1.1. The <b>IDisplayHelp</b> interface enables a
///snap-in to display a specific HTML Help topic within the merged MMC HTML Help file. If the snap-in implemented
///ISnapinHelp2::GetHelpTopic, MMC merges the snap-in's compiled HTML Help file (.chm) into the MMC HTML Help collection
///file.
@GUID("CC593830-B926-11D1-8063-0000F875A9CE")
interface IDisplayHelp : IUnknown
{
    ///The <b>IDisplayHelp::ShowTopic</b> method displays the specified HTML Help topic in the merged MMC HTML Help
    ///file.
    ///Params:
    ///    pszHelpTopic = A pointer to a <b>NULL</b>-terminated string specifying the topic to display in the merged MMC HTML Help
    ///                   file. The string must have the following format: ```cpp helpfilename::topicfilename ``` where
    ///                   <i>helpfilename</i> is the file name of the snap-in's HTML Help file (.chm) that MMC merged into the MMC HTML
    ///                   Help collection file (this is the file name only, not the path to the original HTML Help file), and
    ///                   <i>topicfilename</i> is the internal path to the topic file within the snap-in's .chm file. The author of the
    ///                   snap-in's HTML Help file determines whether there is an internal directory structure for the topic HTML files
    ///                   or if all topic HTML files are at the root of the .chm file. A snap-in tells MMC about its .chm file in its
    ///                   implementation of the ISnapinHelp2::GetHelpTopic method. For example, if the snap-in had the HTML Help file
    ///                   mysnapin.chm merged into the MMC HTML Help collection file, and a topic HTML file that had the internal file
    ///                   path of htm/help01.htm, the string would have the following form: ```cpp mysnapin.chm::htm/help01.htm ``` If
    ///                   instead the help01.htm topic file is at the root of the mysnapin.chm Help file, the string should have the
    ///                   following form: ```cpp mysnapin.chm::/help01.htm ``` Support for numeric IDs for topics is not included in
    ///                   versions 1.2 and earlier.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT ShowTopic(ushort* pszHelpTopic);
}

///The <b>IRequiredExtensions</b> interface is introduced in MMC 1.1. The <b>IRequiredExtensions</b> interface enables a
///snap-in to add some or all of the extension snap-ins registered for your snap-in.
@GUID("72782D7A-A4A0-11D1-AF0F-00C04FB6DD2C")
interface IRequiredExtensions : IUnknown
{
    ///The <b>IRequiredExtensions::EnableAllExtensions</b> method enables the snap-in to specify that all extension
    ///snap-ins registered for the snap-in are required.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT EnableAllExtensions();
    ///The <b>IRequiredExtensions::GetFirstExtension</b> method enables the snap-in to specify the first extension
    ///snap-in its list of required extension snap-ins.
    ///Params:
    ///    pExtCLSID = A pointer to the CLSID of the first snap-in in the list of required extension snap-ins.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetFirstExtension(GUID* pExtCLSID);
    ///The <b>IRequiredExtensions::GetNextExtension</b> method enables the snap-in to specify the next extension snap-in
    ///in its list of required extension snap-ins.
    ///Params:
    ///    pExtCLSID = A pointer to the CLSID of the next snap-in in the list of required extension snap-ins.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetNextExtension(GUID* pExtCLSID);
}

///The <b>IStringTable</b> interface is introduced in MMC 1.1. The <b>IStringTable</b> interface provides a way to store
///string data with the snap-in. A string table is created in the console file as required for each snap-in by MMC. The
///<b>IStringTable</b> interface allows strings to be saved in the console file. Be aware that this interface is
///designed to work with specialized localization tools. Snap-ins without access to these localization tools will not
///benefit from using this interface.
@GUID("DE40B7A4-0F65-11D2-8E25-00C04F8ECD78")
interface IStringTable : IUnknown
{
    ///The <b>IStringTable::AddString</b> method enables a snap-in to add a string to the snap-in's string table.
    ///Params:
    ///    pszAdd = The string to add to the string table.
    ///    pStringID = A pointer to the ID of the string added to the string table.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT AddString(ushort* pszAdd, uint* pStringID);
    ///The <b>IStringTable::GetString</b> method enables a snap-in to retrieve a string from the snap-in's string table.
    ///Params:
    ///    StringID = The ID of the string to be retrieved from the snap-in's string table.
    ///    cchBuffer = The number of characters in lpBuffer.
    ///    lpBuffer = A pointer to the buffer for the character string.
    ///    pcchOut = The number of characters in the retrieved string, not including the NULL terminator. If the number of
    ///              characters written is not required, pass <b>NULL</b> for this parameter.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetString(uint StringID, uint cchBuffer, char* lpBuffer, uint* pcchOut);
    ///The <b>IStringTable::GetStringLength</b> method enables a snap-in to determine the length of a string in the
    ///snap-in's string table.
    ///Params:
    ///    StringID = The identifier for the string whose length is being retrieved.
    ///    pcchString = The number of characters in the specified string in the snap-in's string table, not including the terminator.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetStringLength(uint StringID, uint* pcchString);
    ///The <b>IStringTable::DeleteString</b> method enables a snap-in to delete a specified string from the snap-in
    ///string table.
    ///Params:
    ///    StringID = The string to be deleted from the snap-in string table.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT DeleteString(uint StringID);
    ///The <b>IStringTable::DeleteAllStrings</b> method enables a snap-in to delete all strings from the snap-in's
    ///string table.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT DeleteAllStrings();
    ///The <b>IStringTable::FindString</b> method enables a snap-in to search for a string in the snap-in string table.
    ///Params:
    ///    pszFind = The string to be searched for in the string table.
    ///    pStringID = A pointer to the ID of the string found in the string table.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT FindString(ushort* pszFind, uint* pStringID);
    ///The <b>IStringTable::Enumerate</b> method supplies a pointer to an IEnumString interface on an enumerator that
    ///can return the strings in a snap-in's string table. The IEnumString interface is a standard COM interface.
    ///Params:
    ///    ppEnum = The address of IEnumString* pointer variable that receives the interface pointer to the enumerator. If an
    ///             error occurs, *<i>ppEnum</i> is set to <b>NULL</b>. If *<i>ppEnum </i>is non-<b>NULL</b>, MMC's
    ///             implementation of <b>IEnumString</b> calls IUnknown::AddRef on the *<i>ppEnum</i>. The snap-in must call
    ///             IUnknown::Release when the interface is no longer required.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Enumerate(IEnumString* ppEnum);
}

///The <b>IColumnData</b> interface is introduced in MMC 1.2. The <b>IColumnData</b> interface enables a snap-in to set
///and retrieve the persisted view data of list view columns to use for column customization. For more information about
///when to use the <b>IColumnData</b> interface, see Using IColumnData. The interface provides methods for
///programmatically providing the same functionality that MMC provides in the <b>Modify Columns</b> dialog box. In
///addition, the <b>IColumnData</b> interface provides methods for setting and retrieving the sorted column and sort
///direction of a particular column set. All data set and retrieved by the methods of the <b>IColumnData</b> interface
///is persisted by MMC in memory, and not in a stream or storage medium. This data is persisted to an .msc console file
///only when the user chooses the <b>Save</b> menu command. MMC persists column data (also called column configuration
///data) per column set (using a column set ID) per view per snap-in instance. Within each view, each column set ID
///references its own column configuration data. The snap-in can use the <b>IColumnData</b> interface pertaining to the
///particular view to access the column configuration data of that view. For more information about column
///customization, see Using Column Persistence. The <b>IColumnData</b> interface can be queried from the IConsole passed
///into IComponent::Initialize during the component creation.
@GUID("547C1354-024D-11D3-A707-00C04F8EF4CB")
interface IColumnData : IUnknown
{
    ///The <b>IColumnData::SetColumnConfigData</b> method enables a snap-in to set the persisted width, order, and
    ///hidden status of columns in a column set.
    ///Params:
    ///    pColID = A pointer to an SColumnSetID structure that contains the ID of the column set whose data is to be set.
    ///    pColSetData = A pointer to an MMC_COLUMN_SET_DATA structure that contains the number of columns in the column set as well
    ///                  as the column data to be set.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SetColumnConfigData(SColumnSetID* pColID, MMC_COLUMN_SET_DATA* pColSetData);
    ///The <b>IColumnData::GetColumnConfigData</b> method enables a snap-in to retrieve the current width, order, and
    ///hidden status of each column in a column set that is stored in memory by MMC.
    ///Params:
    ///    pColID = A pointer to an SColumnSetID structure that holds the ID of the column set whose data is to be retrieved.
    ///    ppColSetData = A pointer to a pointer to an MMC_COLUMN_SET_DATA structure that will hold the retrieved column data.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetColumnConfigData(SColumnSetID* pColID, MMC_COLUMN_SET_DATA** ppColSetData);
    ///The <b>IColumnData::SetColumnSortData</b> method enables a snap-in to set the sorted column and sorting direction
    ///for columns in a column set.
    ///Params:
    ///    pColID = A pointer to an SColumnSetID structure that contains the column set ID of the column set whose sort data is
    ///             to be set.
    ///    pColSortData = A pointer to an MMC_SORT_SET_DATA structure that contains the column sort data of the column set.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SetColumnSortData(SColumnSetID* pColID, MMC_SORT_SET_DATA* pColSortData);
    ///The <b>IColumnData::GetColumnSortData</b> method enables a snap-in to retrieve from memory the sorted column and
    ///sorting direction for columns in a column set.
    ///Params:
    ///    pColID = A pointer to an SColumnSetID structure that contains the ID of the column set whose sort data is to be
    ///             retrieved.
    ///    ppColSortData = A pointer to a pointer to an MMC_SORT_SET_DATA structure that will contain the column sort data of the column
    ///                    set.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT GetColumnSortData(SColumnSetID* pColID, MMC_SORT_SET_DATA** ppColSortData);
}

///The <b>IMessageView</b> interface is introduced in MMC 1.2. The <b>IMessageView</b> interface provides support for
///specifying the text and icons for error messages displayed using the MMC message OCX control. For details on using
///the control, see Using the MMC Message OCX Control.
@GUID("80F94174-FCCC-11D2-B991-00C04F8ECD78")
interface IMessageView : IUnknown
{
    ///The <b>IMessageView::SetTitleText</b> method enables a snap-in to set the title text for the result pane message
    ///displayed using the MMC message OCX control.
    ///Params:
    ///    pszTitleText = A pointer to a null-terminated string that contains the title text for the result pane message.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SetTitleText(ushort* pszTitleText);
    ///The <b>IMessageView::SetBodyText</b> method enables a snap-in to set the body text for the result pane message
    ///displayed using the MMC message OCX control.
    ///Params:
    ///    pszBodyText = A pointer to a null-terminated string that contains the body text for the result pane message.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SetBodyText(ushort* pszBodyText);
    ///The <b>IMessageView::SetIcon</b> method enables a snap-in to set the icon for the result pane message displayed
    ///using the MMC message OCX control.
    ///Params:
    ///    id = A value that specifies the type of icon for the result pane message. The value is taken from the
    ///         IconIdentifier enumeration.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SetIcon(IconIdentifier id);
    ///The <b>IMessageView::Clear</b> method enables a snap-in to clear the title, text, and icon of the result pane
    ///message displayed using the MMC message OCX control.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Clear();
}

///The <b>IResultDataCompareEx</b> interface is introduced in MMC 1.2. The <b>IResultDataCompareEx</b> interface allows
///primary snap-ins to compare both scope and result items that are displayed in a sorted order in the result pane. MMC
///uses a primary snap-in's implementation of this interface for all scope and result items. Any scope items inserted by
///extension snap-ins are left unsorted at the bottom of the list. The <b>IResultDataCompareEx</b> interface differs
///from the <b>IResultDataCompareEx</b> interface. IResultDataCompare allows primary snap-ins to compare only result
///items. Scope items from either the primary snap-in or any extensions are left unsorted at the top of the list.
@GUID("96933476-0251-11D3-AEB0-00C04F8ECD78")
interface IResultDataCompareEx : IUnknown
{
    ///The <b>IResultDataCompareEx::Compare</b> method provides a way for a primary snap-in to compare items for the
    ///purpose of sorting the scope and result items that it inserts in the result pane.
    ///Params:
    ///    prdc = A pointer to an RDCOMPARE structure that holds information about the items being compared and which column in
    ///           the result pane list view is being sorted.
    ///    pnResult = The snap-in should set pnResult to the result of the comparison: <ul> <li>Any negative integer if item 1 &lt;
    ///               item 2</li> <li>Zero (0) if item 1 == item 2</li> <li>Any positive integer if item 1 &gt; item 2</li> </ul>
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Compare(RDCOMPARE* prdc, int* pnResult);
}

///The <b>IComponentData2</b> interface supersedes the IComponentData interface. The <b>IComponentData2</b> interface
///contains the IComponentData2::QueryDispatch method, which provides an <b>IDispatch</b> interface to the View object
///for use with the MMC 2.0 Automation Object Model.
@GUID("CCA0F2D2-82DE-41B5-BF47-3B2076273D5C")
interface IComponentData2 : IComponentData
{
    ///The <b>QueryDispatch</b> method returns the snap-in's <b>IDispatch</b> interface for a specified item. MMC
    ///exposes this interface through the MMC 2.0 Automation object model. Script, or other applications, can access the
    ///<b>IDispatch</b> interface for the item represented by the specified cookie through the View.SnapinScopeObject
    ///and View.SnapinSelectionObject methods.
    ///Params:
    ///    cookie = A value that specifies the context item (or items) for which the <b>IDispatch</b> interface is requested. The
    ///             <i>cookie</i> value is previously provided by the snap-in, and MMC uses it in this method call.
    ///    type = A value that specifies the data object as one of the following constant values, which are members of the
    ///           <b>DATA_OBJECT_TYPES</b> enumeration.
    ///    ppDispatch = Dispatch interface pointer. The snap-in sets *<i>ppDispatch</i> to the <b>IDispatch</b> interface
    ///                 corresponding to the <i>cookie</i> value.
    ///Returns:
    ///    If successful, the return value is S_OK. Other return values indicate an error code.
    ///    
    HRESULT QueryDispatch(ptrdiff_t cookie, DATA_OBJECT_TYPES type, IDispatch* ppDispatch);
}

///The <b>IComponent2</b> interface, implemented by snap-ins, is introduced in MMC 2.0 and supersedes the IComponent
///interface. Snap-ins written for MMC 2.0 and later should implement <b>IComponent2</b>, as the
///IComponent2::GetResultViewType2 and IComponent2::RestoreResultView methods provide a way to precisely restoring a
///result view. Additionally, the IComponent2::QueryDispatch method provides an IDispatch interface to the View object
///for use with the MMC 2.0 Automation Object Model.
@GUID("79A2D615-4A10-4ED4-8C65-8633F9335095")
interface IComponent2 : IComponent
{
    ///The QueryDispatch method returns the snap-in IDispatch interface for a specified item. MMC will expose this
    ///interface through the MMC 2.0 Automation object model. Script, or other applications, can access the IDispatch
    ///interface for the item represented by the specified cookie through the View.SnapinScopeObject and
    ///View.SnapinSelectionObject methods.
    ///Params:
    ///    cookie = A value that specifies the context item (or items) for which the IDispatch interface is requested. The cookie
    ///             value is previously provided by the snap-in, and MMC uses it in this method call.
    ///    type = A value that specifies the data object as one of the following constant values, which, are members of the
    ///           DATA_OBJECT_TYPES enumeration.
    ///    ppDispatch = A dispatch interface pointer. The snap-in sets *ppDispatch to the IDispatch interface that corresponds to the
    ///                 cookie value.
    ///Returns:
    ///    If successful, the return value is <b>S_OK</b>. Other return values indicate an error code.
    ///    
    HRESULT QueryDispatch(ptrdiff_t cookie, DATA_OBJECT_TYPES type, IDispatch* ppDispatch);
    ///The <b>GetResultViewType2</b> method retrieves the result view type. This method supersedes the
    ///IComponent::GetResultViewType method.
    ///Params:
    ///    cookie = A value that specifies the snapin-provided unique identifier for the scope item. For more details about
    ///             cookies in MMC, see Cookies.
    ///    pResultViewType = A pointer to the RESULT_VIEW_TYPE_INFO structure for the result view. If your snap-in implements IComponent2,
    ///                      the <b>pstrPersistableViewDescription</b> member of the <b>RESULT_VIEW_TYPE_INFO</b> structure must contain a
    ///                      valid view description string; otherwise, MMC will not initialize your snap-in. The
    ///                      <b>pstrPersistableViewDescription</b> member must be allocated by CoTaskMemAlloc. The snap-in must not free
    ///                      <b>pstrPersistableViewDescription</b>, as it will be freed by MMC.
    ///Returns:
    ///    If successful, the return value is S_OK. Other return values indicate an error code.
    ///    
    HRESULT GetResultViewType2(ptrdiff_t cookie, RESULT_VIEW_TYPE_INFO* pResultViewType);
    ///The <b>RestoreResultView</b> method restores the result view. This method enables a snap-in to restore
    ///snap-in-specific details of a result view. For more information, see Restoring Result Views. This method
    ///supersedes the use of the MMCN_RESTORE_VIEW notification.
    ///Params:
    ///    cookie = A value that specifies the unique identifier whose result view will be restored.
    ///    pResultViewType = A pointer to the RESULT_VIEW_TYPE_INFO structure for the result view.
    ///Returns:
    ///    If successful, the return value is S_OK. The snap-in can return S_FALSE to prevent MMC from restoring the
    ///    view based on the information in *<i>pResultViewType</i>. Other return values indicate an error code.
    ///    
    HRESULT RestoreResultView(ptrdiff_t cookie, RESULT_VIEW_TYPE_INFO* pResultViewType);
}

///The <b>IContextMenuCallback2</b> interface is used to add menu items to a context menu. This interface supersedes
///IContextMenuCallback.
@GUID("E178BC0E-2ED0-4B5E-8097-42C9087E8B33")
interface IContextMenuCallback2 : IUnknown
{
    ///The <b>IContextMenuCallback2::AddItem</b> method adds a single item to a context menu.
    ///Params:
    ///    pItem = A pointer to a CONTEXTMENUITEM2 structure with the item to be added. This parameter cannot be <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT AddItem(CONTEXTMENUITEM2* pItem);
}

///The <b>IMMCVersionInfo</b> interface provides version information about the installed MMC application.
@GUID("A8D2C5FE-CDCB-4B9D-BDE5-A27343FF54BC")
interface IMMCVersionInfo : IUnknown
{
    ///The <b>GetMMCVersion</b> method retrieves version information for the MMC application.
    ///Params:
    ///    pVersionMajor = The version major number. For example, if *<i>pVersionMajor</i> returns 2, then MMC version 2.x is running.
    ///    pVersionMinor = The version minor number. For example, if *<i>pVersionMinor</i> returns 0, then MMC version x.0 is running.
    ///Returns:
    ///    If successful, the return value is S_OK. Other return values indicate an error code.
    ///    
    HRESULT GetMMCVersion(int* pVersionMajor, int* pVersionMinor);
}

///The <b>IExtendView</b> interface provides information about the extended view.
@GUID("89995CEE-D2ED-4C0E-AE5E-DF7E76F3FA53")
interface IExtendView : IUnknown
{
    ///The GetViews method retrieves information about the extended view and adds extended views to the result pane.
    ///View extensions use the IViewExtensionCallback interface methods to provide information about the extended view.
    ///A pointer to the IViewExtensionCallback interface is provided as a parameter of the <b>IExtendView::GetViews</b>
    ///method.
    ///Params:
    ///    pDataObject = A pointer to the snap-in data object.
    ///    pViewExtensionCallback = A pointer to the IViewExtensionCallback interface. The view extension snap-in uses the IViewExtensionCallback
    ///                             interface to add information about the extended view. The snap-in can also call the
    ///                             IViewExtensionCallback::AddView method multiple times to add multiple extended views. The value in
    ///                             pViewExtensionCallback is valid only during the call to <b>IExtendView::GetViews</b>; view extension snap-ins
    ///                             must not save this pointer for later use.
    ///Returns:
    ///    If successful, the return value is S_OK. Other return values indicate an error code.
    ///    
    HRESULT GetViews(IDataObject pDataObject, IViewExtensionCallback pViewExtensionCallback);
}

///The <b>IViewExtensionCallback</b> interface is used to add a view to the result pane. During the call to the view
///extension's IExtendView::GetViews method, MMC provides an <b>IViewExtensionCallback</b> interface pointer; this
///pointer is valid only during the call and should not be saved for later use.
@GUID("34DD928A-7599-41E5-9F5E-D6BC3062C2DA")
interface IViewExtensionCallback : IUnknown
{
    ///The AddView method adds a view to the result pane. This method is implemented by MMC and is called by view
    ///extensions. For more information, see Extending Views.
    ///Params:
    ///    pExtViewData = A pointer to an MMC_EXT_VIEW_DATA structure, which contains information about the view being added to the
    ///                   result pane. The bReplacesDefaultView member of the <b>MMC_EXT_VIEW_DATA</b> structure determines if the
    ///                   standard view is removed when adding the new view.
    ///Returns:
    ///    If successful, the return value is S_OK. Other return values indicate an error code.
    ///    
    HRESULT AddView(MMC_EXT_VIEW_DATA* pExtViewData);
}

///The <b>IConsolePower</b> interface controls the execution state and idle timers on operating systems that support
///power management.
@GUID("1CFBDD0E-62CA-49CE-A3AF-DBB2DE61B068")
interface IConsolePower : IUnknown
{
    ///The <b>SetExecutionState</b> method sets the execution state for the current thread.
    ///Params:
    ///    dwAdd = Flags to add to the snap-in execution state. This can be a combination of 0 or more of the following flags.
    ///    dwRemove = Flags to remove from the snap-in's execution-state. This can be a combination of 0 or more of the preceding
    ///               flags. Specifying one or more of the flags enables a snap-in to turn off a power management requirement
    ///               established by an earlier call to <b>SetExecutionState</b>. <div class="alert"><b>Note</b> A power management
    ///               requirement must be turned off before it can be turned on. An attempt to turn on a power management
    ///               requirement without first turning it off returns an error <b>E_INVALIDARG</b>.</div> <div> </div>
    ///Returns:
    ///    If successful, the return value is <b>S_OK</b>. This method will return <b>S_FALSE</b> when invoked on a
    ///    system that does not support power management. Other return values indicate an error code.
    ///    
    HRESULT SetExecutionState(uint dwAdd, uint dwRemove);
    ///The ResetIdleTimer method resets the specified power management idle timers.
    ///Params:
    ///    dwFlags = The flags used to reset idle timers. One or more of the following flags can be used. For more information,
    ///              see SetThreadExecutionState.
    ///Returns:
    ///    If successful, the return value is S_OK. This method will return S_FALSE when invoked on a system that does
    ///    not support power management. Other return values indicate an error code.
    ///    
    HRESULT ResetIdleTimer(uint dwFlags);
}

///The <b>IConsolePowerSink</b> interface monitors and responds to power management messages.
@GUID("3333759F-FE4F-4975-B143-FEC0A5DD6D65")
interface IConsolePowerSink : IUnknown
{
    ///The <b>OnPowerBroadcast</b> method processes WM_POWERBROADCAST notification messages related to the computer's
    ///power management.
    ///Params:
    ///    nEvent = The power broadcast event identifier. The identifier is one of the following values.
    ///    lParam = Function-specific data. For most events, this parameter is reserved and not used. However, if <i>nEvent</i>
    ///             is one of the resume events (PBT_APMRESUME*), the <i>lParam</i> parameter can specify the
    ///             PBTF_APMRESUMEFROMFAILURE flag. This flag indicates that a suspend operation failed after the PBT_APMSUSPEND
    ///             event was broadcast.
    ///    plReturn = On return, the snap-in's response to the broadcast event. Generally, set *<i>plReturn</i> to <b>TRUE</b>. The
    ///               exception is when <i>nEvent</i> is PBT_APMQUERYSUSPEND. To allow the computer suspension to continue in
    ///               response to the PBT_APMQUERYSUSPEND event, set *<i>plReturn</i> to <b>TRUE</b>; to deny the computer
    ///               suspension, set *<i>plReturn</i> to BROADCAST_QUERY_DENY. A snap-in that permits computer suspension should
    ///               perform necessary suspension preparations before returning from this method.
    ///Returns:
    ///    If successful, the return value is S_OK. Other return values indicate an error code.
    ///    
    HRESULT OnPowerBroadcast(uint nEvent, LPARAM lParam, LRESULT* plReturn);
}

///The <b>INodeProperties</b> interface retrieves text-only properties for a node. This interface is implemented by
///snap-ins and its methods are called by the Extended View extension that ships with MMC 2.0. Other view extensions and
///the MMC 2.0 Automation Object Model (particularly the Node) can also use the <b>INodeProperties</b> interface. The
///<b>INodeProperties</b> interface is queried (using IUnknown::QueryInterface) from the IComponentData interface for
///scope nodes, and from the IComponent interface for result items. The Extended View extension queries two properties,
///CCF_DESCRIPTION and CCF_HTML_DETAILS. Instead of implementing <b>INodeProperties</b>, a snap-in can return values for
///these properties through data-object clipboard formats. The <b>INodeProperties</b> interface is available to snap-in
///developers whose data objects may not readily provide the property values.
@GUID("15BC4D24-A522-4406-AA55-0749537A6865")
interface INodeProperties : IUnknown
{
    ///The <b>GetProperty</b> method retrieves text-only property values for a node. Your implementation of the
    ///<b>INodeProperties::GetProperty</b> method is called when an application based on the MMC 2.0 Automation Object
    ///Model retrieves the Node.Property property.
    ///Params:
    ///    pDataObject = A pointer to the snap-in data object.
    ///    szPropertyName = The name of the property retrieved.
    ///    pbstrProperty = Text value for the property.
    ///Returns:
    ///    The snap-in returns <b>S_OK</b> if it provides the property value when this method is called. If the snap-in
    ///    returns <b>S_FALSE</b>, then the data object is queried for the property value.
    ///    
    HRESULT GetProperty(IDataObject pDataObject, BSTR szPropertyName, ushort** pbstrProperty);
}

///The <b>IConsole3</b> interface supersedes the IConsole2 interface. The <b>IConsole3</b> interface contains the
///IConsole3::RenameScopeItem method, which allows a scope node to programmatically be placed in rename mode.
@GUID("4F85EFDB-D0E1-498C-8D4A-D010DFDD404F")
interface IConsole3 : IConsole2
{
    ///The <b>RenameScopeItem</b> method programmatically puts the specified scope item in rename mode. Subsequently,
    ///the user can manually enter the new name. Use this method only when an item is created and immediately must be
    ///put in rename mode. Use of this method for other scenarios, such as being called after an item has been selected,
    ///is not supported and may have unexpected results.
    ///Params:
    ///    hScopeItem = The scope item put in rename mode.
    ///Returns:
    ///    If successful, the return value is <b>S_OK</b>. If unsuccessful, the method returns <b>E_FAIL</b>.
    ///    
    HRESULT RenameScopeItem(ptrdiff_t hScopeItem);
}

///The <b>IResultData2</b> interface supersedes the IResultData interface. The <b>IResultData2</b> interface contains
///the IResultData2::RenameResultItem method, which allows a result node to programmatically be put in rename mode.
@GUID("0F36E0EB-A7F1-4A81-BE5A-9247F7DE4B1B")
interface IResultData2 : IResultData
{
    ///The <b>RenameResultItem</b> method programmatically places the specified result item into rename mode, after
    ///which, the user can manually enter the new name. This method is designed specifically for the case where an item
    ///is created and immediately must be placed into rename mode. Use of this method under other scenarios, such as
    ///being called after an item has been selected, is not supported and may have unexpected results.
    ///Params:
    ///    itemID = The result item being placed into rename mode. When applied to virtual lists, pass the item index instead of
    ///             the result item.
    ///Returns:
    ///    If successful, the return value is S_OK; otherwise, the return value is an error code. The SUCCEEDED and/or
    ///    FAILED macros can be used to evaluate the return value. If the Rename verb is not enabled, this method
    ///    returns E_FAIL.
    ///    
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
