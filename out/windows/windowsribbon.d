// Written in the D programming language.

module windows.windowsribbon;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.gdi : HBITMAP;
public import windows.structuredstorage : IStream, PROPVARIANT;
public import windows.systemservices : HINSTANCE, PWSTR;
public import windows.windowsandmessaging : HWND;
public import windows.windowspropertiessystem : PROPERTYKEY;

extern(Windows) @nogc nothrow:


// Enums


///Specifies values that identify the availability of a contextual tab.
alias UI_CONTEXTAVAILABILITY = int;
enum : int
{
    ///A contextual tab is not available for the selected object.
    UI_CONTEXTAVAILABILITY_NOTAVAILABLE = 0x00000000,
    ///A contextual tab is available for the selected object. The tab is not the active tab.
    UI_CONTEXTAVAILABILITY_AVAILABLE    = 0x00000001,
    ///A contextual tab is available for the selected object. The tab is the active tab.
    UI_CONTEXTAVAILABILITY_ACTIVE       = 0x00000002,
}

///Specifies values that identify the font property state of a FontControl, such as <b>Strikethrough</b>.
alias UI_FONTPROPERTIES = int;
enum : int
{
    ///The property is not available.
    UI_FONTPROPERTIES_NOTAVAILABLE = 0x00000000,
    ///The property is not set.
    UI_FONTPROPERTIES_NOTSET       = 0x00000001,
    ///The property is set.
    UI_FONTPROPERTIES_SET          = 0x00000002,
}

///Specifies values that identify the vertical-alignment state of a FontControl.
alias UI_FONTVERTICALPOSITION = int;
enum : int
{
    ///Vertical positioning is not enabled.
    UI_FONTVERTICALPOSITION_NOTAVAILABLE = 0x00000000,
    ///Vertical positioning is enabled but not toggled.
    UI_FONTVERTICALPOSITION_NOTSET       = 0x00000001,
    ///Vertical positioning is enabled and toggled for superscript.
    UI_FONTVERTICALPOSITION_SUPERSCRIPT  = 0x00000002,
    ///Vertical positioning is enabled and toggled for subscript.
    UI_FONTVERTICALPOSITION_SUBSCRIPT    = 0x00000003,
}

///Specifies values that identify the underline state of a FontControl.
alias UI_FONTUNDERLINE = int;
enum : int
{
    ///Underlining is not enabled.
    UI_FONTUNDERLINE_NOTAVAILABLE = 0x00000000,
    ///Underlining is off.
    UI_FONTUNDERLINE_NOTSET       = 0x00000001,
    ///Underlining is on.
    UI_FONTUNDERLINE_SET          = 0x00000002,
}

///Specifies values that identify whether the font size of a highlighted text run should be incremented or decremented.
alias UI_FONTDELTASIZE = int;
enum : int
{
    ///Increment the font size.
    UI_FONTDELTASIZE_GROW   = 0x00000000,
    ///Decrement the font size.
    UI_FONTDELTASIZE_SHRINK = 0x00000001,
}

///Specifies values that identify the dock state of the Quick Access Toolbar (QAT).
alias UI_CONTROLDOCK = int;
enum : int
{
    ///The QAT is docked in the nonclient area of the Ribbon host application, as shown in the following screen shot.
    ///<img alt="Screen shot showing the Quick Access Toolbar docked above the Ribbon in the nonclient area."
    ///src="./images/QAT_DockTop.png"/>
    UI_CONTROLDOCK_TOP    = 0x00000001,
    ///The QAT is docked as a visually integral band below the Ribbon, as shown in the following screen shot. <img
    ///alt="Screen shot showing the Quick Access Toolbar docked below the Ribbon." src="./images/QAT_DockBottom.png"/>
    UI_CONTROLDOCK_BOTTOM = 0x00000003,
}

///Specifies the values that identify how a color swatch in a DropDownColorPicker or a FontControl color picker (<b>Text
///color</b> or <b>Text highlight</b>) is filled. <div class="alert"><b>Note</b> These are recommendations only. The
///application can associate any fill type with these values.</div><div> </div>
alias UI_SWATCHCOLORTYPE = int;
enum : int
{
    ///The swatch is transparent.
    UI_SWATCHCOLORTYPE_NOCOLOR   = 0x00000000,
    ///The swatch is filled with a solid RGB color bound to GetSysColor(COLOR_WINDOWTEXT).
    UI_SWATCHCOLORTYPE_AUTOMATIC = 0x00000001,
    ///The swatch is filled with a solid RGB color.
    UI_SWATCHCOLORTYPE_RGB       = 0x00000002,
}

///Specifies whether a swatch has normal or monochrome mode.
alias UI_SWATCHCOLORMODE = int;
enum : int
{
    ///The swatch is normal mode.
    UI_SWATCHCOLORMODE_NORMAL     = 0x00000000,
    ///The swatch is monochrome. The swatch's RGB color value will be interpreted as a 1 bit-per-pixel pattern.
    UI_SWATCHCOLORMODE_MONOCHROME = 0x00000001,
}

///Identifies the types of events associated with a Ribbon.
alias UI_EVENTTYPE = int;
enum : int
{
    ///The ApplicationMenu opened.
    UI_EVENTTYPE_ApplicationMenuOpened   = 0x00000000,
    ///The Ribbon minimized.
    UI_EVENTTYPE_RibbonMinimized         = 0x00000001,
    ///The Ribbon expanded.
    UI_EVENTTYPE_RibbonExpanded          = 0x00000002,
    ///The application mode changed.
    UI_EVENTTYPE_ApplicationModeSwitched = 0x00000003,
    ///A Tab activated.
    UI_EVENTTYPE_TabActivated            = 0x00000004,
    ///A menu opened.
    UI_EVENTTYPE_MenuOpened              = 0x00000005,
    ///A Command executed.
    UI_EVENTTYPE_CommandExecuted         = 0x00000006,
    ///A Command tooltip displayed.
    UI_EVENTTYPE_TooltipShown            = 0x00000007,
}

///Identifies the locations where events associated with a Ribbon control can originate.
alias UI_EVENTLOCATION = int;
enum : int
{
    ///The Ribbon.
    UI_EVENTLOCATION_Ribbon          = 0x00000000,
    ///The QuickAccessToolbar.
    UI_EVENTLOCATION_QAT             = 0x00000001,
    ///The ApplicationMenu.
    UI_EVENTLOCATION_ApplicationMenu = 0x00000002,
    ///The ContextPopup.
    UI_EVENTLOCATION_ContextPopup    = 0x00000003,
}

///Specifies values that identify the aspect of a Command to invalidate.
alias UI_INVALIDATIONS = int;
enum : int
{
    ///A state property, such as UI_PKEY_Enabled.
    UI_INVALIDATIONS_STATE         = 0x00000001,
    ///The value property of a Command.
    UI_INVALIDATIONS_VALUE         = 0x00000002,
    ///Any property.
    UI_INVALIDATIONS_PROPERTY      = 0x00000004,
    ///All properties.
    UI_INVALIDATIONS_ALLPROPERTIES = 0x00000008,
}

///Specifies values that identify the types of changes that can be made to a collection.
alias UI_COLLECTIONCHANGE = int;
enum : int
{
    ///Insert an item into the collection.
    UI_COLLECTIONCHANGE_INSERT  = 0x00000000,
    ///Delete an item from the collection.
    UI_COLLECTIONCHANGE_REMOVE  = 0x00000001,
    ///Replace an item in the collection.
    UI_COLLECTIONCHANGE_REPLACE = 0x00000002,
    ///Delete all items from the collection.
    UI_COLLECTIONCHANGE_RESET   = 0x00000003,
}

///Specifies values that identify the execution IDs that map to actions a user can initiate on a Command.
alias UI_EXECUTIONVERB = int;
enum : int
{
    ///Execute a command.
    UI_EXECUTIONVERB_EXECUTE       = 0x00000000,
    ///Show a preview of a visual element.
    UI_EXECUTIONVERB_PREVIEW       = 0x00000001,
    ///Cancel a preview of a visual element.
    UI_EXECUTIONVERB_CANCELPREVIEW = 0x00000002,
}

///Specifies values that identify the type of Command associated with a Ribbon control.
alias UI_COMMANDTYPE = int;
enum : int
{
    ///The type of command is not known.
    UI_COMMANDTYPE_UNKNOWN           = 0x00000000,
    ///Group
    UI_COMMANDTYPE_GROUP             = 0x00000001,
    ///Button Help Button
    UI_COMMANDTYPE_ACTION            = 0x00000002,
    ///Application Menu Drop-Down Button Split Button Tab
    UI_COMMANDTYPE_ANCHOR            = 0x00000003,
    ///Tab Group
    UI_COMMANDTYPE_CONTEXT           = 0x00000004,
    ///Combo Box Drop-Down Gallery In-Ribbon Gallery Split Button Gallery
    UI_COMMANDTYPE_COLLECTION        = 0x00000005,
    ///Drop-Down Gallery In-Ribbon Gallery Quick Access Toolbar Split Button Gallery
    UI_COMMANDTYPE_COMMANDCOLLECTION = 0x00000006,
    ///Spinner
    UI_COMMANDTYPE_DECIMAL           = 0x00000007,
    ///Toggle Button Check Box
    UI_COMMANDTYPE_BOOLEAN           = 0x00000008,
    ///Font Control
    UI_COMMANDTYPE_FONT              = 0x00000009,
    ///Recent Items
    UI_COMMANDTYPE_RECENTITEMS       = 0x0000000a,
    ///Drop-Down Color Picker
    UI_COMMANDTYPE_COLORANCHOR       = 0x0000000b,
    ///This Command type is not supported by any framework controls.
    UI_COMMANDTYPE_COLORCOLLECTION   = 0x0000000c,
}

///Specifies values that identify the Ribbon framework View.
alias UI_VIEWTYPE = int;
enum : int
{
    ///A Ribbon View.
    UI_VIEWTYPE_RIBBON = 0x00000001,
}

///Specifies values that identify the type of action to complete on a Ribbon framework View.
alias UI_VIEWVERB = int;
enum : int
{
    ///Create a View.
    UI_VIEWVERB_CREATE  = 0x00000000,
    ///Destroy a View.
    UI_VIEWVERB_DESTROY = 0x00000001,
    ///Resize a View.
    UI_VIEWVERB_SIZE    = 0x00000002,
    ///Unable to complete the action.
    UI_VIEWVERB_ERROR   = 0x00000003,
}

///Specifies values that identify the ownership conditions under which an image is created by the Windows Ribbon
///framework.
alias UI_OWNERSHIP = int;
enum : int
{
    ///The handle to the bitmap (HBITMAP) is owned by the Ribbon framework through the IUIImage object.
    UI_OWNERSHIP_TRANSFER = 0x00000000,
    ///A copy of the HBITMAP is created by the Ribbon framework through the IUIImage object. The host application still
    ///owns the HBITMAP.
    UI_OWNERSHIP_COPY     = 0x00000001,
}

// Structs


///Contains information about a Command associated with a event.
struct UI_EVENTPARAMS_COMMAND
{
    ///The ID of the Command directly related to the event, which is specified in the markup resource file.
    uint             CommandID;
    ///The Command name that is associated with <b>CommandId</b>.
    const(PWSTR)     CommandName;
    ///The ID for the parent of the Command, which is specified in the markup resource file.
    uint             ParentCommandID;
    ///The Command name of the parent that is associated with <b>CommandId</b>.
    const(PWSTR)     ParentCommandName;
    ///<b>SelectionIndex</b> is used only when a UI_EVENTTYPE_CommandExecuted has been fired in response to the user
    ///selecting an item within a ComboBox or item gallery. In those cases, <b>SelectionIndex</b> contains the index of
    ///the selected item. In all other cases, it is set to 0.
    uint             SelectionIndex;
    ///One of the values from UI_EVENTLOCATION.
    UI_EVENTLOCATION Location;
}

///Contains information about a Ribbon event.
struct UI_EVENTPARAMS
{
    ///One of the values from UI_EVENTTYPE.
    UI_EVENTTYPE EventType;
union
    {
        int Modes;
        UI_EVENTPARAMS_COMMAND Params;
    }
}

// Interfaces

@GUID("926749FA-2615-4987-8845-C33E65F2B957")
struct UIRibbonFramework;

@GUID("0F7434B6-59B6-4250-999E-D168D6AE4293")
struct UIRibbonImageFromBitmapFactory;

///<b>IUISimplePropertySet</b> is a read-only interface that defines a method for retrieving the value identified by a
///property key. This interface is implemented by the Windows Ribbon framework and is also implemented by the host
///application for each item in the IUICollection object of an item gallery. When implemented by the host application,
///the method defined by this interface is used to retrieve a property key value for the selected item in the
///IUICollection.
@GUID("C205BB48-5B1C-4219-A106-15BD0A5F24E2")
interface IUISimplePropertySet : IUnknown
{
    ///Retrieves the value identified by a property key.
    ///Params:
    ///    key = Type: <b>REFPROPERTYKEY</b> The Property Key of interest.
    ///    value = Type: <b>PROPVARIANT*</b> When this method returns, contains a pointer to the value for <i>key</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetValue(const(PROPERTYKEY)* key, PROPVARIANT* value);
}

///The <b>IUIRibbon</b> interface is implemented by the Windows Ribbon framework and provides the ability to specify
///settings and properties for a ribbon.
@GUID("803982AB-370A-4F7E-A9E7-8784036A6E26")
interface IUIRibbon : IUnknown
{
    ///Retrieves the height of the ribbon.
    ///Params:
    ///    cy = Type: <b>UINT32*</b> The height of the ribbon, in pixels.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetHeight(uint* cy);
    ///Reads ribbon settings from a binary stream.
    ///Params:
    ///    pStream = Type: <b>IStream*</b> Pointer to an IStream object.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful, or E_FAIL if the format or content of the serialized stream
    ///    is empty or cannot be verified by the Ribbon framework.
    ///    
    HRESULT LoadSettingsFromStream(IStream pStream);
    ///Writes ribbon settings to a binary stream.
    ///Params:
    ///    pStream = Type: <b>IStream*</b> Pointer to an IStream object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SaveSettingsToStream(IStream pStream);
}

///The <b>IUIFramework</b> interface is implemented by the Windows Ribbon framework and defines the methods that provide
///the core functionality for the framework.
@GUID("F4F0385D-6872-43A8-AD09-4C339CB3F5C5")
interface IUIFramework : IUnknown
{
    ///Connects the host application to the Windows Ribbon framework.
    ///Params:
    ///    frameWnd = Type: <b>HWND</b> Handle to the top-level window that will contain the Ribbon.
    ///    application = Type: <b>IUIApplication*</b> Pointer to the IUIApplication implementation of the host application.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, an error value from the following list. <table
    ///    class="clsStd"> <tr> <th>Value</th> <th>Description</th> </tr> <tr>
    ///    <td>HRESULT_FROM_WIN32(ERROR_INVALID_WINDOW_HANDLE)</td> <td><i>frameWnd</i> is <b>NULL</b>, does not point
    ///    to an existing window, or is not a top-level window of the desktop. <div class="alert"><b>Note</b> This error
    ///    is also returned if <i>frameWnd</i> is a child window (WS_CHILD), is declared as a tool window
    ///    (WS_EX_TOOLWINDOW), or it lacks a caption property (WS_CAPTION is mandatory).</div> <div> </div> </td> </tr>
    ///    <tr> <td>HRESULT_FROM_WIN32(ERROR_WINDOW_OF_OTHER_THREAD)</td> <td><i>frameWnd</i> is not owned by the
    ///    execution thread.</td> </tr> <tr> <td>E_POINTER</td> <td><i>application</i> is <b>NULL</b> or an invalid
    ///    pointer.</td> </tr> </table>
    ///    
    HRESULT Initialize(HWND frameWnd, IUIApplication application);
    ///Terminates and releases all objects, hooks, and references for an instance of the Windows Ribbon framework.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Destroy();
    ///Loads the Windows Ribbon framework UI resource, or compiled markup, file.
    ///Params:
    ///    instance = Type: <b>HINSTANCE</b> A handle to the Ribbon application instance.
    ///    resourceName = Type: <b>LPCWSTR</b> The name of the resource that contains the compiled, binary markup. <div
    ///                   class="alert"><b>Note</b> To initialize the Ribbon successfully, a compiled Ribbon markup file must be
    ///                   available as a resource. This markup file is an integral component of the Ribbon framework; it specifies the
    ///                   controls to use and their layout. </div> <div> </div>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT LoadUI(HINSTANCE instance, const(PWSTR) resourceName);
    ///Retrieves the address of a pointer to an interface that represents a Windows Ribbon framework View, such as
    ///IUIRibbon or IUIContextualUI.
    ///Params:
    ///    viewId = Type: <b>UINT32</b> The ID for the View. A value of 0 for a Ribbon or the Command.Id of a ContextPopup.
    ///    riid = Type: <b>REFIID</b> The interface ID for IUIRibbon or IUIContextualUI.
    ///    ppv = Type: <b>void**</b> When this method returns, contains the address of a pointer to an IUIRibbon or an
    ///          IUIContextualUI object.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, an error value from the following list. <table
    ///    class="clsStd"> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td>E_INVALIDARG</td> <td><i>riid</i> is
    ///    not a valid interface ID. </td> </tr> <tr> <td>E_FAIL</td> <td>The operation failed.</td> </tr> </table>
    ///    
    HRESULT GetView(uint viewId, const(GUID)* riid, void** ppv);
    ///Retrieves a command property, value, or state.
    ///Params:
    ///    commandId = Type: <b>UINT32</b> The ID for the Command, which is specified in the Markup resource file.
    ///    key = Type: <b>REFPROPERTYKEY</b> The property key of the command property, value, or state.
    ///    value = Type: <b>PROPVARIANT*</b> When this method returns, contains the property, value, or state.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, an error value from the following list. <table
    ///    class="clsStd"> <tr> <th>Value</th> <th>Description</th> </tr> <tr>
    ///    <td>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</td> <td>The property, value, or state does not support
    ///    <b>IUIFramework::GetUICommandProperty</b>. </td> </tr> <tr> <td>E_FAIL</td> <td>The operation failed.</td>
    ///    </tr> </table>
    ///    
    HRESULT GetUICommandProperty(uint commandId, const(PROPERTYKEY)* key, PROPVARIANT* value);
    ///Sets a command property, value, or state.
    ///Params:
    ///    commandId = Type: <b>UINT32</b> The ID for the Command, which is specified in the Markup resource file.
    ///    key = Type: <b>REFPROPERTYKEY</b> The property key of the command property, value, or state.
    ///    value = Type: <b>PROPVARIANT</b> The property, value, or state.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful, otherwise an error value from the following list. <table
    ///    class="clsStd"> <tr> <th>Value</th> <th>Description</th> </tr> <tr>
    ///    <td>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</td> <td>The property, value, or state does not support
    ///    <b>IUIFramework::SetUICommandProperty</b>. They may support being set through invalidation only. </td> </tr>
    ///    <tr> <td>E_FAIL</td> <td>The operation failed.</td> </tr> </table>
    ///    
    HRESULT SetUICommandProperty(uint commandId, const(PROPERTYKEY)* key, const(PROPVARIANT)* value);
    ///Invalidates a Windows Ribbon framework Command property, value, or state.
    ///Params:
    ///    commandId = Type: <b>UINT32</b> The ID for the Command, which is specified in the markup resource file.
    ///    flags = Type: <b>UI_INVALIDATIONS</b> Identifies which aspect of a command to invalidate. <div
    ///            class="alert"><b>Note</b> Passing <b>UI_INVALIDATIONS_ALLPROPERTIES</b> invalidates all properties bound to a
    ///            command, including value and state. </div> <div> </div>
    ///    key = Type: <b>const PROPERTYKEY*</b> The property key of the command property or state. This parameter can be
    ///          <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, an error value from the following list. <table
    ///    class="clsStd"> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid
    ///    value for <i>key</i> was supplied. </td> </tr> <tr> <td>E_FAIL</td> <td>The operation failed. All the
    ///    commands failed to invalidate, or none of the properties specified are supported. </td> </tr> </table>
    ///    
    HRESULT InvalidateUICommand(uint commandId, UI_INVALIDATIONS flags, const(PROPERTYKEY)* key);
    ///Processes all pending Command updates.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, an error value.
    ///    
    HRESULT FlushPendingInvalidations();
    ///Specifies the application modes to enable.
    ///Params:
    ///    iModes = Type: <b>INT32</b> A bit mask that identifies the modes.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetModes(int iModes);
}

///The <b>IUIEventLogger</b> interface is implemented by the application and defines the ribbon events callback method.
@GUID("EC3E1034-DBF4-41A1-95D5-03E0F1026E05")
interface IUIEventLogger : IUnknown
{
    ///Receives notifications that a ribbon event has occurred.
    ///Params:
    ///    pEventParams = The parameters associated with the event. This value varies according to the event type.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    void OnUIEvent(UI_EVENTPARAMS* pEventParams);
}

///The <b>IUIEventingManager</b> interface is implemented by the Ribbon framework and provides the notification
///functionality for applications that register for ribbon events.
@GUID("3BE6EA7F-9A9B-4198-9368-9B0F923BD534")
interface IUIEventingManager : IUnknown
{
    ///Sets the event logger for ribbon events.
    ///Params:
    ///    eventLogger = The event logger. If NULL, disables event logging.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetEventLogger(IUIEventLogger eventLogger);
}

///The <b>IUIContextualUI</b> interface is implemented by the Ribbon framework and provides the core functionality for
///the Context Popup View.
@GUID("EEA11F37-7C46-437C-8E55-B52122B29293")
interface IUIContextualUI : IUnknown
{
    ///Displays a ContextPopup.
    ///Params:
    ///    x = Type: <b>INT32</b> The absolute x-coordinate, in screen coordinates, for the upper-left corner of the
    ///        ContextPopup.
    ///    y = Type: <b>INT32</b> The absolute y-coordinate, in screen coordinates, for the upper-left corner of the
    ///        ContextPopup.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ShowAtLocation(int x, int y);
}

///The <b>IUICollection</b> interface is implemented by the Ribbon framework. The <b>IUICollection</b> interface defines
///the methods for dynamically manipulating collection-based controls, such as the various Ribbon galleries and the
///Quick Access Toolbar (QAT), at run time.
@GUID("DF4F45BF-6F9D-4DD7-9D68-D8F9CD18C4DB")
interface IUICollection : IUnknown
{
    ///Retrieves the number of items contained in the IUICollection.
    ///Params:
    ///    count = Type: <b>UINT32*</b> When this method returns, contains the item count.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCount(uint* count);
    ///Retrieves an item from the IUICollection at the specified index.
    ///Params:
    ///    index = Type: <b>UINT32</b> The zero-based index of <i>item</i> to retrieve from the IUICollection.
    ///    item = Type: <b>IUnknown**</b> When this method returns, contains the address of a pointer variable that receives
    ///           the item.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetItem(uint index, IUnknown* item);
    ///Adds an item to the end of the IUICollection.
    ///Params:
    ///    item = Type: <b>IUnknown*</b> Pointer to the item that is added to the IUICollection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Add(IUnknown item);
    ///Inserts an item into the IUICollection at the specified index.
    ///Params:
    ///    index = Type: <b>UINT32</b> The zero-based index at which <i>item</i> is inserted into the IUICollection.
    ///    item = Type: <b>IUnknown*</b> Pointer to the item that is added to the IUICollection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Insert(uint index, IUnknown item);
    ///Removes an item from the IUICollection at the specified index.
    ///Params:
    ///    index = Type: <b>UINT32</b> The zero-based index of the item to remove from the IUICollection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RemoveAt(uint index);
    ///Replaces an item at the specified index of the IUICollection with another item.
    ///Params:
    ///    indexReplaced = Type: <b>UINT32</b> The zero-based index of <i>item</i> to be replaced in the IUICollection.
    ///    itemReplaceWith = Type: <b>IUnknown*</b> Pointer to the replacement item that is added to the IUICollection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Replace(uint indexReplaced, IUnknown itemReplaceWith);
    ///Deletes all items from the IUICollection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Clear();
}

///The <b>IUICollectionChangedEvent</b> interface is implemented by the application and defines the method required to
///handle changes to a collection at run time.
@GUID("6502AE91-A14D-44B5-BBD0-62AACC581D52")
interface IUICollectionChangedEvent : IUnknown
{
    ///Called when an IUICollection changes.
    ///Params:
    ///    action = Type: <b>UI_COLLECTIONCHANGE</b> The action performed on the IUICollection.
    ///    oldIndex = Type: <b>UINT32</b> Index of the old item on remove or replace; otherwise UI_COLLECTION_INVALIDINDEX.
    ///    oldItem = Type: <b>IUnknown*</b> Pointer to the old item on remove or replace; otherwise <b>NULL</b>.
    ///    newIndex = Type: <b>UINT32</b> Index of the new item on insert, add, or replace; otherwise UI_COLLECTION_INVALIDINDEX.
    ///    newItem = Type: <b>IUnknown*</b> Pointer to the new item on insert, add, or replace; otherwise <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnChanged(UI_COLLECTIONCHANGE action, uint oldIndex, IUnknown oldItem, uint newIndex, IUnknown newItem);
}

///The <b>IUICommandHandler</b> interface is implemented by the application and defines the methods for gathering
///Command information and handling Command events from the Windows Ribbon framework.
@GUID("75AE0A2D-DC03-4C9F-8883-069660D0BEB6")
interface IUICommandHandler : IUnknown
{
    ///Responds to execute events on Commands bound to the Command handler.
    ///Params:
    ///    commandId = Type: <b>UINT32</b> The ID for the Command, which is specified in the Markup resource file.
    ///    verb = Type: <b>UI_EXECUTIONVERB</b> The UI_EXECUTIONVERB or action that is initiated by the user.
    ///    key = Type: <b>const PROPERTYKEY*</b> A pointer to a Property Key that has changed value. This parameter can be
    ///          <b>NULL</b>.
    ///    currentValue = Type: <b>const PROPVARIANT*</b> A pointer to the current value for <i>key</i>. This parameter can be
    ///                   <b>NULL</b>.
    ///    commandExecutionProperties = Type: <b>IUISimplePropertySet*</b> A pointer to an IUISimplePropertySet object that contains Command state
    ///                                 properties and property values, such as screen coordinates and list item indices. This parameter can be
    ///                                 <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Execute(uint commandId, UI_EXECUTIONVERB verb, const(PROPERTYKEY)* key, 
                    const(PROPVARIANT)* currentValue, IUISimplePropertySet commandExecutionProperties);
    ///Responds to property update requests from the Windows Ribbon framework.
    ///Params:
    ///    commandId = Type: <b>UINT32</b> The ID for the Command, which is specified in the Markup resource file.
    ///    key = Type: <b>REFPROPERTYKEY</b> The Property Key to update.
    ///    currentValue = Type: <b>const PROPVARIANT*</b> A pointer to the current value for <i>key</i>. This parameter can be
    ///                   <b>NULL</b>.
    ///    newValue = Type: <b>PROPVARIANT*</b> When this method returns, contains a pointer to the new value for <i>key</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT UpdateProperty(uint commandId, const(PROPERTYKEY)* key, const(PROPVARIANT)* currentValue, 
                           PROPVARIANT* newValue);
}

///The <b>IUIApplication</b> interface is implemented by the application and defines the callback entry-point methods
///for the Windows Ribbon framework.
@GUID("D428903C-729A-491D-910D-682A08FF2522")
interface IUIApplication : IUnknown
{
    ///Called when the state of a View changes.
    ///Params:
    ///    viewId = Type: <b>UINT32</b> The ID for the View. Only a value of 0 is valid.
    ///    typeID = Type: <b>UI_VIEWTYPE</b> The UI_VIEWTYPE hosted by the application.
    ///    view = Type: <b>IUnknown*</b> A pointer to the View interface.
    ///    verb = Type: <b>UI_VIEWVERB</b> The UI_VIEWVERB (or action) performed by the View.
    ///    uReasonCode = Type: <b>INT32</b> Not defined.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnViewChanged(uint viewId, UI_VIEWTYPE typeID, IUnknown view, UI_VIEWVERB verb, int uReasonCode);
    ///Called for each Command specified in the Windows Ribbon framework markup to bind the Command to an
    ///IUICommandHandler.
    ///Params:
    ///    commandId = Type: <b>UINT32</b> The ID for the Command, which is specified in the markup resource file.
    ///    typeID = Type: <b>UI_COMMANDTYPE</b> The Command type that is associated with a specific control.
    ///    commandHandler = Type: <b>IUICommandHandler**</b> When this method returns, contains the address of a pointer to an
    ///                     IUICommandHandler object. This object is a host application Command handler that is bound to one or more
    ///                     Commands.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnCreateUICommand(uint commandId, UI_COMMANDTYPE typeID, IUICommandHandler* commandHandler);
    ///Called for each Command specified in the Windows Ribbon framework markup when the application window is
    ///destroyed.
    ///Params:
    ///    commandId = Type: <b>UINT32</b> The ID for the Command, which is specified in the markup resource file.
    ///    typeID = Type: <b>UI_COMMANDTYPE</b> The Command type that is associated with a specific control.
    ///    commandHandler = Type: <b>IUICommandHandler*</b> A pointer to an IUICommandHandler object. This value can be <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnDestroyUICommand(uint commandId, UI_COMMANDTYPE typeID, IUICommandHandler commandHandler);
}

///The <b>IUIImage</b> interface is implemented by the application and defines the method for retrieving an image to
///display in the ribbon and context popup UI of the Windows Ribbon framework .
@GUID("23C8C838-4DE6-436B-AB01-5554BB7C30DD")
interface IUIImage : IUnknown
{
    ///Retrieves a bitmap to display as an icon in the ribbon and context popup UI of the Windows Ribbon framework.
    ///Params:
    ///    bitmap = Type: <b>HBITMAP*</b> When this method returns, contains a pointer to the handle to the requested bitmap.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetBitmap(HBITMAP* bitmap);
}

///<b>IUIImageFromBitmap</b> is a factory interface implemented by the Windows Ribbon framework that defines the method
///for creating an IUIImage object.
@GUID("18ABA7F3-4C1C-4BA2-BF6C-F5C3326FA816")
interface IUIImageFromBitmap : IUnknown
{
    ///Creates an IUIImage object from a bitmap image.
    ///Params:
    ///    bitmap = Type: <b>HBITMAP</b> A handle to the bitmap that contains the image.
    ///    options = Type: <b>UI_OWNERSHIP</b> The ownership conditions under which an image is created. <table class="clsStd">
    ///              <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>UI_OWNERSHIP_TRANSFER</td> <td>If
    ///              <b>UI_OWNERSHIP_TRANSFER</b> is specified as the value of <i>options</i>, then the Ribbon framework owns the
    ///              handle to the bitmap (HBITMAP) through the IUIImage object and releases it when the framework no longer
    ///              requires it. <div class="alert"><b>Note</b> This option prevents the Ribbon host application from safely
    ///              referencing the same HBITMAP elsewhere in the application UI. </div> <div> </div> </td> </tr> <tr>
    ///              <td>UI_OWNERSHIP_COPY</td> <td>If <b>UI_OWNERSHIP_COPY</b> is specified as the value of <i>options</i>, then
    ///              the host application owns the HBITMAP and is able to reference the same HBITMAP for use elsewhere in the UI.
    ///              <div class="alert"><b>Note</b> This option places responsibility for releasing the HBITMAP on the host
    ///              application. </div> <div> </div> </td> </tr> </table>
    ///    image = Type: <b>IUIImage**</b> When this method returns, contains the address of a pointer variable that receives
    ///            the IUIImage object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateImage(HBITMAP bitmap, UI_OWNERSHIP options, IUIImage* image);
}


// GUIDs

const GUID CLSID_UIRibbonFramework              = GUIDOF!UIRibbonFramework;
const GUID CLSID_UIRibbonImageFromBitmapFactory = GUIDOF!UIRibbonImageFromBitmapFactory;

const GUID IID_IUIApplication            = GUIDOF!IUIApplication;
const GUID IID_IUICollection             = GUIDOF!IUICollection;
const GUID IID_IUICollectionChangedEvent = GUIDOF!IUICollectionChangedEvent;
const GUID IID_IUICommandHandler         = GUIDOF!IUICommandHandler;
const GUID IID_IUIContextualUI           = GUIDOF!IUIContextualUI;
const GUID IID_IUIEventLogger            = GUIDOF!IUIEventLogger;
const GUID IID_IUIEventingManager        = GUIDOF!IUIEventingManager;
const GUID IID_IUIFramework              = GUIDOF!IUIFramework;
const GUID IID_IUIImage                  = GUIDOF!IUIImage;
const GUID IID_IUIImageFromBitmap        = GUIDOF!IUIImageFromBitmap;
const GUID IID_IUIRibbon                 = GUIDOF!IUIRibbon;
const GUID IID_IUISimplePropertySet      = GUIDOF!IUISimplePropertySet;
