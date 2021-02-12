module windows.windowsribbon;

public import system;
public import windows.com;
public import windows.gdi;
public import windows.structuredstorage;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowspropertiessystem;

extern(Windows):

const GUID CLSID_UIRibbonFramework = {0x926749FA, 0x2615, 0x4987, [0x88, 0x45, 0xC3, 0x3E, 0x65, 0xF2, 0xB9, 0x57]};
@GUID(0x926749FA, 0x2615, 0x4987, [0x88, 0x45, 0xC3, 0x3E, 0x65, 0xF2, 0xB9, 0x57]);
struct UIRibbonFramework;

const GUID CLSID_UIRibbonImageFromBitmapFactory = {0x0F7434B6, 0x59B6, 0x4250, [0x99, 0x9E, 0xD1, 0x68, 0xD6, 0xAE, 0x42, 0x93]};
@GUID(0x0F7434B6, 0x59B6, 0x4250, [0x99, 0x9E, 0xD1, 0x68, 0xD6, 0xAE, 0x42, 0x93]);
struct UIRibbonImageFromBitmapFactory;

enum UI_CONTEXTAVAILABILITY
{
    UI_CONTEXTAVAILABILITY_NOTAVAILABLE = 0,
    UI_CONTEXTAVAILABILITY_AVAILABLE = 1,
    UI_CONTEXTAVAILABILITY_ACTIVE = 2,
}

enum UI_FONTPROPERTIES
{
    UI_FONTPROPERTIES_NOTAVAILABLE = 0,
    UI_FONTPROPERTIES_NOTSET = 1,
    UI_FONTPROPERTIES_SET = 2,
}

enum UI_FONTVERTICALPOSITION
{
    UI_FONTVERTICALPOSITION_NOTAVAILABLE = 0,
    UI_FONTVERTICALPOSITION_NOTSET = 1,
    UI_FONTVERTICALPOSITION_SUPERSCRIPT = 2,
    UI_FONTVERTICALPOSITION_SUBSCRIPT = 3,
}

enum UI_FONTUNDERLINE
{
    UI_FONTUNDERLINE_NOTAVAILABLE = 0,
    UI_FONTUNDERLINE_NOTSET = 1,
    UI_FONTUNDERLINE_SET = 2,
}

enum UI_FONTDELTASIZE
{
    UI_FONTDELTASIZE_GROW = 0,
    UI_FONTDELTASIZE_SHRINK = 1,
}

enum UI_CONTROLDOCK
{
    UI_CONTROLDOCK_TOP = 1,
    UI_CONTROLDOCK_BOTTOM = 3,
}

enum UI_SWATCHCOLORTYPE
{
    UI_SWATCHCOLORTYPE_NOCOLOR = 0,
    UI_SWATCHCOLORTYPE_AUTOMATIC = 1,
    UI_SWATCHCOLORTYPE_RGB = 2,
}

enum UI_SWATCHCOLORMODE
{
    UI_SWATCHCOLORMODE_NORMAL = 0,
    UI_SWATCHCOLORMODE_MONOCHROME = 1,
}

enum UI_EVENTTYPE
{
    UI_EVENTTYPE_ApplicationMenuOpened = 0,
    UI_EVENTTYPE_RibbonMinimized = 1,
    UI_EVENTTYPE_RibbonExpanded = 2,
    UI_EVENTTYPE_ApplicationModeSwitched = 3,
    UI_EVENTTYPE_TabActivated = 4,
    UI_EVENTTYPE_MenuOpened = 5,
    UI_EVENTTYPE_CommandExecuted = 6,
    UI_EVENTTYPE_TooltipShown = 7,
}

enum UI_EVENTLOCATION
{
    UI_EVENTLOCATION_Ribbon = 0,
    UI_EVENTLOCATION_QAT = 1,
    UI_EVENTLOCATION_ApplicationMenu = 2,
    UI_EVENTLOCATION_ContextPopup = 3,
}

const GUID IID_IUISimplePropertySet = {0xC205BB48, 0x5B1C, 0x4219, [0xA1, 0x06, 0x15, 0xBD, 0x0A, 0x5F, 0x24, 0xE2]};
@GUID(0xC205BB48, 0x5B1C, 0x4219, [0xA1, 0x06, 0x15, 0xBD, 0x0A, 0x5F, 0x24, 0xE2]);
interface IUISimplePropertySet : IUnknown
{
    HRESULT GetValue(const(PROPERTYKEY)* key, PROPVARIANT* value);
}

const GUID IID_IUIRibbon = {0x803982AB, 0x370A, 0x4F7E, [0xA9, 0xE7, 0x87, 0x84, 0x03, 0x6A, 0x6E, 0x26]};
@GUID(0x803982AB, 0x370A, 0x4F7E, [0xA9, 0xE7, 0x87, 0x84, 0x03, 0x6A, 0x6E, 0x26]);
interface IUIRibbon : IUnknown
{
    HRESULT GetHeight(uint* cy);
    HRESULT LoadSettingsFromStream(IStream pStream);
    HRESULT SaveSettingsToStream(IStream pStream);
}

enum UI_INVALIDATIONS
{
    UI_INVALIDATIONS_STATE = 1,
    UI_INVALIDATIONS_VALUE = 2,
    UI_INVALIDATIONS_PROPERTY = 4,
    UI_INVALIDATIONS_ALLPROPERTIES = 8,
}

const GUID IID_IUIFramework = {0xF4F0385D, 0x6872, 0x43A8, [0xAD, 0x09, 0x4C, 0x33, 0x9C, 0xB3, 0xF5, 0xC5]};
@GUID(0xF4F0385D, 0x6872, 0x43A8, [0xAD, 0x09, 0x4C, 0x33, 0x9C, 0xB3, 0xF5, 0xC5]);
interface IUIFramework : IUnknown
{
    HRESULT Initialize(HWND frameWnd, IUIApplication application);
    HRESULT Destroy();
    HRESULT LoadUI(HINSTANCE instance, const(wchar)* resourceName);
    HRESULT GetView(uint viewId, const(Guid)* riid, void** ppv);
    HRESULT GetUICommandProperty(uint commandId, const(PROPERTYKEY)* key, PROPVARIANT* value);
    HRESULT SetUICommandProperty(uint commandId, const(PROPERTYKEY)* key, const(PROPVARIANT)* value);
    HRESULT InvalidateUICommand(uint commandId, UI_INVALIDATIONS flags, const(PROPERTYKEY)* key);
    HRESULT FlushPendingInvalidations();
    HRESULT SetModes(int iModes);
}

struct UI_EVENTPARAMS_COMMAND
{
    uint CommandID;
    const(wchar)* CommandName;
    uint ParentCommandID;
    const(wchar)* ParentCommandName;
    uint SelectionIndex;
    UI_EVENTLOCATION Location;
}

struct UI_EVENTPARAMS
{
    UI_EVENTTYPE EventType;
    _Anonymous_e__Union Anonymous;
}

const GUID IID_IUIEventLogger = {0xEC3E1034, 0xDBF4, 0x41A1, [0x95, 0xD5, 0x03, 0xE0, 0xF1, 0x02, 0x6E, 0x05]};
@GUID(0xEC3E1034, 0xDBF4, 0x41A1, [0x95, 0xD5, 0x03, 0xE0, 0xF1, 0x02, 0x6E, 0x05]);
interface IUIEventLogger : IUnknown
{
    void OnUIEvent(UI_EVENTPARAMS* pEventParams);
}

const GUID IID_IUIEventingManager = {0x3BE6EA7F, 0x9A9B, 0x4198, [0x93, 0x68, 0x9B, 0x0F, 0x92, 0x3B, 0xD5, 0x34]};
@GUID(0x3BE6EA7F, 0x9A9B, 0x4198, [0x93, 0x68, 0x9B, 0x0F, 0x92, 0x3B, 0xD5, 0x34]);
interface IUIEventingManager : IUnknown
{
    HRESULT SetEventLogger(IUIEventLogger eventLogger);
}

const GUID IID_IUIContextualUI = {0xEEA11F37, 0x7C46, 0x437C, [0x8E, 0x55, 0xB5, 0x21, 0x22, 0xB2, 0x92, 0x93]};
@GUID(0xEEA11F37, 0x7C46, 0x437C, [0x8E, 0x55, 0xB5, 0x21, 0x22, 0xB2, 0x92, 0x93]);
interface IUIContextualUI : IUnknown
{
    HRESULT ShowAtLocation(int x, int y);
}

const GUID IID_IUICollection = {0xDF4F45BF, 0x6F9D, 0x4DD7, [0x9D, 0x68, 0xD8, 0xF9, 0xCD, 0x18, 0xC4, 0xDB]};
@GUID(0xDF4F45BF, 0x6F9D, 0x4DD7, [0x9D, 0x68, 0xD8, 0xF9, 0xCD, 0x18, 0xC4, 0xDB]);
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

enum UI_COLLECTIONCHANGE
{
    UI_COLLECTIONCHANGE_INSERT = 0,
    UI_COLLECTIONCHANGE_REMOVE = 1,
    UI_COLLECTIONCHANGE_REPLACE = 2,
    UI_COLLECTIONCHANGE_RESET = 3,
}

const GUID IID_IUICollectionChangedEvent = {0x6502AE91, 0xA14D, 0x44B5, [0xBB, 0xD0, 0x62, 0xAA, 0xCC, 0x58, 0x1D, 0x52]};
@GUID(0x6502AE91, 0xA14D, 0x44B5, [0xBB, 0xD0, 0x62, 0xAA, 0xCC, 0x58, 0x1D, 0x52]);
interface IUICollectionChangedEvent : IUnknown
{
    HRESULT OnChanged(UI_COLLECTIONCHANGE action, uint oldIndex, IUnknown oldItem, uint newIndex, IUnknown newItem);
}

enum UI_EXECUTIONVERB
{
    UI_EXECUTIONVERB_EXECUTE = 0,
    UI_EXECUTIONVERB_PREVIEW = 1,
    UI_EXECUTIONVERB_CANCELPREVIEW = 2,
}

const GUID IID_IUICommandHandler = {0x75AE0A2D, 0xDC03, 0x4C9F, [0x88, 0x83, 0x06, 0x96, 0x60, 0xD0, 0xBE, 0xB6]};
@GUID(0x75AE0A2D, 0xDC03, 0x4C9F, [0x88, 0x83, 0x06, 0x96, 0x60, 0xD0, 0xBE, 0xB6]);
interface IUICommandHandler : IUnknown
{
    HRESULT Execute(uint commandId, UI_EXECUTIONVERB verb, const(PROPERTYKEY)* key, const(PROPVARIANT)* currentValue, IUISimplePropertySet commandExecutionProperties);
    HRESULT UpdateProperty(uint commandId, const(PROPERTYKEY)* key, const(PROPVARIANT)* currentValue, PROPVARIANT* newValue);
}

enum UI_COMMANDTYPE
{
    UI_COMMANDTYPE_UNKNOWN = 0,
    UI_COMMANDTYPE_GROUP = 1,
    UI_COMMANDTYPE_ACTION = 2,
    UI_COMMANDTYPE_ANCHOR = 3,
    UI_COMMANDTYPE_CONTEXT = 4,
    UI_COMMANDTYPE_COLLECTION = 5,
    UI_COMMANDTYPE_COMMANDCOLLECTION = 6,
    UI_COMMANDTYPE_DECIMAL = 7,
    UI_COMMANDTYPE_BOOLEAN = 8,
    UI_COMMANDTYPE_FONT = 9,
    UI_COMMANDTYPE_RECENTITEMS = 10,
    UI_COMMANDTYPE_COLORANCHOR = 11,
    UI_COMMANDTYPE_COLORCOLLECTION = 12,
}

enum UI_VIEWTYPE
{
    UI_VIEWTYPE_RIBBON = 1,
}

enum UI_VIEWVERB
{
    UI_VIEWVERB_CREATE = 0,
    UI_VIEWVERB_DESTROY = 1,
    UI_VIEWVERB_SIZE = 2,
    UI_VIEWVERB_ERROR = 3,
}

const GUID IID_IUIApplication = {0xD428903C, 0x729A, 0x491D, [0x91, 0x0D, 0x68, 0x2A, 0x08, 0xFF, 0x25, 0x22]};
@GUID(0xD428903C, 0x729A, 0x491D, [0x91, 0x0D, 0x68, 0x2A, 0x08, 0xFF, 0x25, 0x22]);
interface IUIApplication : IUnknown
{
    HRESULT OnViewChanged(uint viewId, UI_VIEWTYPE typeID, IUnknown view, UI_VIEWVERB verb, int uReasonCode);
    HRESULT OnCreateUICommand(uint commandId, UI_COMMANDTYPE typeID, IUICommandHandler* commandHandler);
    HRESULT OnDestroyUICommand(uint commandId, UI_COMMANDTYPE typeID, IUICommandHandler commandHandler);
}

const GUID IID_IUIImage = {0x23C8C838, 0x4DE6, 0x436B, [0xAB, 0x01, 0x55, 0x54, 0xBB, 0x7C, 0x30, 0xDD]};
@GUID(0x23C8C838, 0x4DE6, 0x436B, [0xAB, 0x01, 0x55, 0x54, 0xBB, 0x7C, 0x30, 0xDD]);
interface IUIImage : IUnknown
{
    HRESULT GetBitmap(HBITMAP* bitmap);
}

enum UI_OWNERSHIP
{
    UI_OWNERSHIP_TRANSFER = 0,
    UI_OWNERSHIP_COPY = 1,
}

const GUID IID_IUIImageFromBitmap = {0x18ABA7F3, 0x4C1C, 0x4BA2, [0xBF, 0x6C, 0xF5, 0xC3, 0x32, 0x6F, 0xA8, 0x16]};
@GUID(0x18ABA7F3, 0x4C1C, 0x4BA2, [0xBF, 0x6C, 0xF5, 0xC3, 0x32, 0x6F, 0xA8, 0x16]);
interface IUIImageFromBitmap : IUnknown
{
    HRESULT CreateImage(HBITMAP bitmap, UI_OWNERSHIP options, IUIImage* image);
}

