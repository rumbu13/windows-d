module windows.windowsribbon;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.gdi : HBITMAP;
public import windows.structuredstorage : IStream, PROPVARIANT;
public import windows.systemservices : HINSTANCE;
public import windows.windowsandmessaging : HWND;
public import windows.windowspropertiessystem : PROPERTYKEY;

extern(Windows):


// Enums


enum : int
{
    UI_CONTEXTAVAILABILITY_NOTAVAILABLE = 0x00000000,
    UI_CONTEXTAVAILABILITY_AVAILABLE    = 0x00000001,
    UI_CONTEXTAVAILABILITY_ACTIVE       = 0x00000002,
}
alias UI_CONTEXTAVAILABILITY = int;

enum : int
{
    UI_FONTPROPERTIES_NOTAVAILABLE = 0x00000000,
    UI_FONTPROPERTIES_NOTSET       = 0x00000001,
    UI_FONTPROPERTIES_SET          = 0x00000002,
}
alias UI_FONTPROPERTIES = int;

enum : int
{
    UI_FONTVERTICALPOSITION_NOTAVAILABLE = 0x00000000,
    UI_FONTVERTICALPOSITION_NOTSET       = 0x00000001,
    UI_FONTVERTICALPOSITION_SUPERSCRIPT  = 0x00000002,
    UI_FONTVERTICALPOSITION_SUBSCRIPT    = 0x00000003,
}
alias UI_FONTVERTICALPOSITION = int;

enum : int
{
    UI_FONTUNDERLINE_NOTAVAILABLE = 0x00000000,
    UI_FONTUNDERLINE_NOTSET       = 0x00000001,
    UI_FONTUNDERLINE_SET          = 0x00000002,
}
alias UI_FONTUNDERLINE = int;

enum : int
{
    UI_FONTDELTASIZE_GROW   = 0x00000000,
    UI_FONTDELTASIZE_SHRINK = 0x00000001,
}
alias UI_FONTDELTASIZE = int;

enum : int
{
    UI_CONTROLDOCK_TOP    = 0x00000001,
    UI_CONTROLDOCK_BOTTOM = 0x00000003,
}
alias UI_CONTROLDOCK = int;

enum : int
{
    UI_SWATCHCOLORTYPE_NOCOLOR   = 0x00000000,
    UI_SWATCHCOLORTYPE_AUTOMATIC = 0x00000001,
    UI_SWATCHCOLORTYPE_RGB       = 0x00000002,
}
alias UI_SWATCHCOLORTYPE = int;

enum : int
{
    UI_SWATCHCOLORMODE_NORMAL     = 0x00000000,
    UI_SWATCHCOLORMODE_MONOCHROME = 0x00000001,
}
alias UI_SWATCHCOLORMODE = int;

enum : int
{
    UI_EVENTTYPE_ApplicationMenuOpened   = 0x00000000,
    UI_EVENTTYPE_RibbonMinimized         = 0x00000001,
    UI_EVENTTYPE_RibbonExpanded          = 0x00000002,
    UI_EVENTTYPE_ApplicationModeSwitched = 0x00000003,
    UI_EVENTTYPE_TabActivated            = 0x00000004,
    UI_EVENTTYPE_MenuOpened              = 0x00000005,
    UI_EVENTTYPE_CommandExecuted         = 0x00000006,
    UI_EVENTTYPE_TooltipShown            = 0x00000007,
}
alias UI_EVENTTYPE = int;

enum : int
{
    UI_EVENTLOCATION_Ribbon          = 0x00000000,
    UI_EVENTLOCATION_QAT             = 0x00000001,
    UI_EVENTLOCATION_ApplicationMenu = 0x00000002,
    UI_EVENTLOCATION_ContextPopup    = 0x00000003,
}
alias UI_EVENTLOCATION = int;

enum : int
{
    UI_INVALIDATIONS_STATE         = 0x00000001,
    UI_INVALIDATIONS_VALUE         = 0x00000002,
    UI_INVALIDATIONS_PROPERTY      = 0x00000004,
    UI_INVALIDATIONS_ALLPROPERTIES = 0x00000008,
}
alias UI_INVALIDATIONS = int;

enum : int
{
    UI_COLLECTIONCHANGE_INSERT  = 0x00000000,
    UI_COLLECTIONCHANGE_REMOVE  = 0x00000001,
    UI_COLLECTIONCHANGE_REPLACE = 0x00000002,
    UI_COLLECTIONCHANGE_RESET   = 0x00000003,
}
alias UI_COLLECTIONCHANGE = int;

enum : int
{
    UI_EXECUTIONVERB_EXECUTE       = 0x00000000,
    UI_EXECUTIONVERB_PREVIEW       = 0x00000001,
    UI_EXECUTIONVERB_CANCELPREVIEW = 0x00000002,
}
alias UI_EXECUTIONVERB = int;

enum : int
{
    UI_COMMANDTYPE_UNKNOWN           = 0x00000000,
    UI_COMMANDTYPE_GROUP             = 0x00000001,
    UI_COMMANDTYPE_ACTION            = 0x00000002,
    UI_COMMANDTYPE_ANCHOR            = 0x00000003,
    UI_COMMANDTYPE_CONTEXT           = 0x00000004,
    UI_COMMANDTYPE_COLLECTION        = 0x00000005,
    UI_COMMANDTYPE_COMMANDCOLLECTION = 0x00000006,
    UI_COMMANDTYPE_DECIMAL           = 0x00000007,
    UI_COMMANDTYPE_BOOLEAN           = 0x00000008,
    UI_COMMANDTYPE_FONT              = 0x00000009,
    UI_COMMANDTYPE_RECENTITEMS       = 0x0000000a,
    UI_COMMANDTYPE_COLORANCHOR       = 0x0000000b,
    UI_COMMANDTYPE_COLORCOLLECTION   = 0x0000000c,
}
alias UI_COMMANDTYPE = int;

enum : int
{
    UI_VIEWTYPE_RIBBON = 0x00000001,
}
alias UI_VIEWTYPE = int;

enum : int
{
    UI_VIEWVERB_CREATE  = 0x00000000,
    UI_VIEWVERB_DESTROY = 0x00000001,
    UI_VIEWVERB_SIZE    = 0x00000002,
    UI_VIEWVERB_ERROR   = 0x00000003,
}
alias UI_VIEWVERB = int;

enum : int
{
    UI_OWNERSHIP_TRANSFER = 0x00000000,
    UI_OWNERSHIP_COPY     = 0x00000001,
}
alias UI_OWNERSHIP = int;

// Structs


struct UI_EVENTPARAMS_COMMAND
{
    uint             CommandID;
    const(wchar)*    CommandName;
    uint             ParentCommandID;
    const(wchar)*    ParentCommandName;
    uint             SelectionIndex;
    UI_EVENTLOCATION Location;
}

struct UI_EVENTPARAMS
{
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

@GUID("C205BB48-5B1C-4219-A106-15BD0A5F24E2")
interface IUISimplePropertySet : IUnknown
{
    HRESULT GetValue(const(PROPERTYKEY)* key, PROPVARIANT* value);
}

@GUID("803982AB-370A-4F7E-A9E7-8784036A6E26")
interface IUIRibbon : IUnknown
{
    HRESULT GetHeight(uint* cy);
    HRESULT LoadSettingsFromStream(IStream pStream);
    HRESULT SaveSettingsToStream(IStream pStream);
}

@GUID("F4F0385D-6872-43A8-AD09-4C339CB3F5C5")
interface IUIFramework : IUnknown
{
    HRESULT Initialize(HWND frameWnd, IUIApplication application);
    HRESULT Destroy();
    HRESULT LoadUI(HINSTANCE instance, const(wchar)* resourceName);
    HRESULT GetView(uint viewId, const(GUID)* riid, void** ppv);
    HRESULT GetUICommandProperty(uint commandId, const(PROPERTYKEY)* key, PROPVARIANT* value);
    HRESULT SetUICommandProperty(uint commandId, const(PROPERTYKEY)* key, const(PROPVARIANT)* value);
    HRESULT InvalidateUICommand(uint commandId, UI_INVALIDATIONS flags, const(PROPERTYKEY)* key);
    HRESULT FlushPendingInvalidations();
    HRESULT SetModes(int iModes);
}

@GUID("EC3E1034-DBF4-41A1-95D5-03E0F1026E05")
interface IUIEventLogger : IUnknown
{
    void OnUIEvent(UI_EVENTPARAMS* pEventParams);
}

@GUID("3BE6EA7F-9A9B-4198-9368-9B0F923BD534")
interface IUIEventingManager : IUnknown
{
    HRESULT SetEventLogger(IUIEventLogger eventLogger);
}

@GUID("EEA11F37-7C46-437C-8E55-B52122B29293")
interface IUIContextualUI : IUnknown
{
    HRESULT ShowAtLocation(int x, int y);
}

@GUID("DF4F45BF-6F9D-4DD7-9D68-D8F9CD18C4DB")
interface IUICollection : IUnknown
{
    HRESULT GetCount(uint* count);
    HRESULT GetItem(uint index, IUnknown* item);
    HRESULT Add(IUnknown item);
    HRESULT Insert(uint index, IUnknown item);
    HRESULT RemoveAt(uint index);
    HRESULT Replace(uint indexReplaced, IUnknown itemReplaceWith);
    HRESULT Clear();
}

@GUID("6502AE91-A14D-44B5-BBD0-62AACC581D52")
interface IUICollectionChangedEvent : IUnknown
{
    HRESULT OnChanged(UI_COLLECTIONCHANGE action, uint oldIndex, IUnknown oldItem, uint newIndex, IUnknown newItem);
}

@GUID("75AE0A2D-DC03-4C9F-8883-069660D0BEB6")
interface IUICommandHandler : IUnknown
{
    HRESULT Execute(uint commandId, UI_EXECUTIONVERB verb, const(PROPERTYKEY)* key, 
                    const(PROPVARIANT)* currentValue, IUISimplePropertySet commandExecutionProperties);
    HRESULT UpdateProperty(uint commandId, const(PROPERTYKEY)* key, const(PROPVARIANT)* currentValue, 
                           PROPVARIANT* newValue);
}

@GUID("D428903C-729A-491D-910D-682A08FF2522")
interface IUIApplication : IUnknown
{
    HRESULT OnViewChanged(uint viewId, UI_VIEWTYPE typeID, IUnknown view, UI_VIEWVERB verb, int uReasonCode);
    HRESULT OnCreateUICommand(uint commandId, UI_COMMANDTYPE typeID, IUICommandHandler* commandHandler);
    HRESULT OnDestroyUICommand(uint commandId, UI_COMMANDTYPE typeID, IUICommandHandler commandHandler);
}

@GUID("23C8C838-4DE6-436B-AB01-5554BB7C30DD")
interface IUIImage : IUnknown
{
    HRESULT GetBitmap(HBITMAP* bitmap);
}

@GUID("18ABA7F3-4C1C-4BA2-BF6C-F5C3326FA816")
interface IUIImageFromBitmap : IUnknown
{
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
