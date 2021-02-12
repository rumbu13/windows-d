module windows.windowsaccessibility;

public import system;
public import windows.automation;
public import windows.com;
public import windows.displaydevices;
public import windows.menusandresources;
public import windows.systemservices;
public import windows.textservices;
public import windows.windowsandmessaging;

extern(Windows):

struct SERIALKEYSA
{
    uint cbSize;
    uint dwFlags;
    const(char)* lpszActivePort;
    const(char)* lpszPort;
    uint iBaudRate;
    uint iPortState;
    uint iActive;
}

struct SERIALKEYSW
{
    uint cbSize;
    uint dwFlags;
    const(wchar)* lpszActivePort;
    const(wchar)* lpszPort;
    uint iBaudRate;
    uint iPortState;
    uint iActive;
}

struct HIGHCONTRASTA
{
    uint cbSize;
    uint dwFlags;
    const(char)* lpszDefaultScheme;
}

struct HIGHCONTRASTW
{
    uint cbSize;
    uint dwFlags;
    const(wchar)* lpszDefaultScheme;
}

struct FILTERKEYS
{
    uint cbSize;
    uint dwFlags;
    uint iWaitMSec;
    uint iDelayMSec;
    uint iRepeatMSec;
    uint iBounceMSec;
}

struct STICKYKEYS
{
    uint cbSize;
    uint dwFlags;
}

struct MOUSEKEYS
{
    uint cbSize;
    uint dwFlags;
    uint iMaxSpeed;
    uint iTimeToMaxSpeed;
    uint iCtrlSpeed;
    uint dwReserved1;
    uint dwReserved2;
}

struct ACCESSTIMEOUT
{
    uint cbSize;
    uint dwFlags;
    uint iTimeOutMSec;
}

struct SOUNDSENTRYA
{
    uint cbSize;
    uint dwFlags;
    uint iFSTextEffect;
    uint iFSTextEffectMSec;
    uint iFSTextEffectColorBits;
    uint iFSGrafEffect;
    uint iFSGrafEffectMSec;
    uint iFSGrafEffectColor;
    uint iWindowsEffect;
    uint iWindowsEffectMSec;
    const(char)* lpszWindowsEffectDLL;
    uint iWindowsEffectOrdinal;
}

struct SOUNDSENTRYW
{
    uint cbSize;
    uint dwFlags;
    uint iFSTextEffect;
    uint iFSTextEffectMSec;
    uint iFSTextEffectColorBits;
    uint iFSGrafEffect;
    uint iFSGrafEffectMSec;
    uint iFSGrafEffectColor;
    uint iWindowsEffect;
    uint iWindowsEffectMSec;
    const(wchar)* lpszWindowsEffectDLL;
    uint iWindowsEffectOrdinal;
}

struct TOGGLEKEYS
{
    uint cbSize;
    uint dwFlags;
}

alias WINEVENTPROC = extern(Windows) void function(int hWinEventHook, uint event, HWND hwnd, int idObject, int idChild, uint idEventThread, uint dwmsEventTime);
@DllImport("USER32.dll")
BOOL RegisterPointerInputTarget(HWND hwnd, uint pointerType);

@DllImport("USER32.dll")
BOOL UnregisterPointerInputTarget(HWND hwnd, uint pointerType);

@DllImport("USER32.dll")
BOOL RegisterPointerInputTargetEx(HWND hwnd, uint pointerType, BOOL fObserve);

@DllImport("USER32.dll")
BOOL UnregisterPointerInputTargetEx(HWND hwnd, uint pointerType);

@DllImport("USER32.dll")
void NotifyWinEvent(uint event, HWND hwnd, int idObject, int idChild);

@DllImport("USER32.dll")
int SetWinEventHook(uint eventMin, uint eventMax, int hmodWinEventProc, WINEVENTPROC pfnWinEventProc, uint idProcess, uint idThread, uint dwFlags);

@DllImport("USER32.dll")
BOOL IsWinEventHookInstalled(uint event);

@DllImport("USER32.dll")
BOOL UnhookWinEvent(int hWinEventHook);

@DllImport("OLEACC.dll")
LRESULT LresultFromObject(const(Guid)* riid, WPARAM wParam, IUnknown punk);

@DllImport("OLEACC.dll")
HRESULT ObjectFromLresult(LRESULT lResult, const(Guid)* riid, WPARAM wParam, void** ppvObject);

@DllImport("OLEACC.dll")
HRESULT WindowFromAccessibleObject(IAccessible param0, HWND* phwnd);

@DllImport("OLEACC.dll")
HRESULT AccessibleObjectFromWindow(HWND hwnd, uint dwId, const(Guid)* riid, void** ppvObject);

@DllImport("OLEACC.dll")
HRESULT AccessibleObjectFromEvent(HWND hwnd, uint dwId, uint dwChildId, IAccessible* ppacc, VARIANT* pvarChild);

@DllImport("OLEACC.dll")
HRESULT AccessibleObjectFromPoint(POINT ptScreen, IAccessible* ppacc, VARIANT* pvarChild);

@DllImport("OLEACC.dll")
HRESULT AccessibleChildren(IAccessible paccContainer, int iChildStart, int cChildren, char* rgvarChildren, int* pcObtained);

@DllImport("OLEACC.dll")
uint GetRoleTextA(uint lRole, const(char)* lpszRole, uint cchRoleMax);

@DllImport("OLEACC.dll")
uint GetRoleTextW(uint lRole, const(wchar)* lpszRole, uint cchRoleMax);

@DllImport("OLEACC.dll")
uint GetStateTextA(uint lStateBit, const(char)* lpszState, uint cchState);

@DllImport("OLEACC.dll")
uint GetStateTextW(uint lStateBit, const(wchar)* lpszState, uint cchState);

@DllImport("OLEACC.dll")
void GetOleaccVersionInfo(uint* pVer, uint* pBuild);

@DllImport("OLEACC.dll")
HRESULT CreateStdAccessibleObject(HWND hwnd, int idObject, const(Guid)* riid, void** ppvObject);

@DllImport("OLEACC.dll")
HRESULT CreateStdAccessibleProxyA(HWND hwnd, const(char)* pClassName, int idObject, const(Guid)* riid, void** ppvObject);

@DllImport("OLEACC.dll")
HRESULT CreateStdAccessibleProxyW(HWND hwnd, const(wchar)* pClassName, int idObject, const(Guid)* riid, void** ppvObject);

@DllImport("OLEACC.dll")
HRESULT AccSetRunningUtilityState(HWND hwndApp, uint dwUtilityStateMask, uint dwUtilityState);

@DllImport("OLEACC.dll")
HRESULT AccNotifyTouchInteraction(HWND hwndApp, HWND hwndTarget, POINT ptTarget);

@DllImport("UIAutomationCore.dll")
BOOL UiaGetErrorDescription(BSTR* pDescription);

@DllImport("UIAutomationCore.dll")
HRESULT UiaHUiaNodeFromVariant(VARIANT* pvar, HUIANODE__** phnode);

@DllImport("UIAutomationCore.dll")
HRESULT UiaHPatternObjectFromVariant(VARIANT* pvar, HUIAPATTERNOBJECT__** phobj);

@DllImport("UIAutomationCore.dll")
HRESULT UiaHTextRangeFromVariant(VARIANT* pvar, HUIATEXTRANGE__** phtextrange);

@DllImport("UIAutomationCore.dll")
BOOL UiaNodeRelease(HUIANODE__* hnode);

@DllImport("UIAutomationCore.dll")
HRESULT UiaGetPropertyValue(HUIANODE__* hnode, int propertyId, VARIANT* pValue);

@DllImport("UIAutomationCore.dll")
HRESULT UiaGetPatternProvider(HUIANODE__* hnode, int patternId, HUIAPATTERNOBJECT__** phobj);

@DllImport("UIAutomationCore.dll")
HRESULT UiaGetRuntimeId(HUIANODE__* hnode, SAFEARRAY** pruntimeId);

@DllImport("UIAutomationCore.dll")
HRESULT UiaSetFocus(HUIANODE__* hnode);

@DllImport("UIAutomationCore.dll")
HRESULT UiaNavigate(HUIANODE__* hnode, NavigateDirection direction, UiaCondition* pCondition, UiaCacheRequest* pRequest, SAFEARRAY** ppRequestedData, BSTR* ppTreeStructure);

@DllImport("UIAutomationCore.dll")
HRESULT UiaGetUpdatedCache(HUIANODE__* hnode, UiaCacheRequest* pRequest, NormalizeState normalizeState, UiaCondition* pNormalizeCondition, SAFEARRAY** ppRequestedData, BSTR* ppTreeStructure);

@DllImport("UIAutomationCore.dll")
HRESULT UiaFind(HUIANODE__* hnode, UiaFindParams* pParams, UiaCacheRequest* pRequest, SAFEARRAY** ppRequestedData, SAFEARRAY** ppOffsets, SAFEARRAY** ppTreeStructures);

@DllImport("UIAutomationCore.dll")
HRESULT UiaNodeFromPoint(double x, double y, UiaCacheRequest* pRequest, SAFEARRAY** ppRequestedData, BSTR* ppTreeStructure);

@DllImport("UIAutomationCore.dll")
HRESULT UiaNodeFromFocus(UiaCacheRequest* pRequest, SAFEARRAY** ppRequestedData, BSTR* ppTreeStructure);

@DllImport("UIAutomationCore.dll")
HRESULT UiaNodeFromHandle(HWND hwnd, HUIANODE__** phnode);

@DllImport("UIAutomationCore.dll")
HRESULT UiaNodeFromProvider(IRawElementProviderSimple pProvider, HUIANODE__** phnode);

@DllImport("UIAutomationCore.dll")
HRESULT UiaGetRootNode(HUIANODE__** phnode);

@DllImport("UIAutomationCore.dll")
void UiaRegisterProviderCallback(UiaProviderCallback* pCallback);

@DllImport("UIAutomationCore.dll")
int UiaLookupId(AutomationIdentifierType type, const(Guid)* pGuid);

@DllImport("UIAutomationCore.dll")
HRESULT UiaGetReservedNotSupportedValue(IUnknown* punkNotSupportedValue);

@DllImport("UIAutomationCore.dll")
HRESULT UiaGetReservedMixedAttributeValue(IUnknown* punkMixedAttributeValue);

@DllImport("UIAutomationCore.dll")
BOOL UiaClientsAreListening();

@DllImport("UIAutomationCore.dll")
HRESULT UiaRaiseAutomationPropertyChangedEvent(IRawElementProviderSimple pProvider, int id, VARIANT oldValue, VARIANT newValue);

@DllImport("UIAutomationCore.dll")
HRESULT UiaRaiseAutomationEvent(IRawElementProviderSimple pProvider, int id);

@DllImport("UIAutomationCore.dll")
HRESULT UiaRaiseStructureChangedEvent(IRawElementProviderSimple pProvider, StructureChangeType structureChangeType, int* pRuntimeId, int cRuntimeIdLen);

@DllImport("UIAutomationCore.dll")
HRESULT UiaRaiseAsyncContentLoadedEvent(IRawElementProviderSimple pProvider, AsyncContentLoadedState asyncContentLoadedState, double percentComplete);

@DllImport("UIAutomationCore.dll")
HRESULT UiaRaiseTextEditTextChangedEvent(IRawElementProviderSimple pProvider, TextEditChangeType textEditChangeType, SAFEARRAY* pChangedData);

@DllImport("UIAutomationCore.dll")
HRESULT UiaRaiseChangesEvent(IRawElementProviderSimple pProvider, int eventIdCount, UiaChangeInfo* pUiaChanges);

@DllImport("UIAutomationCore.dll")
HRESULT UiaRaiseNotificationEvent(IRawElementProviderSimple provider, NotificationKind notificationKind, NotificationProcessing notificationProcessing, BSTR displayString, BSTR activityId);

@DllImport("UIAutomationCore.dll")
HRESULT UiaRaiseActiveTextPositionChangedEvent(IRawElementProviderSimple provider, ITextRangeProvider textRange);

@DllImport("UIAutomationCore.dll")
HRESULT UiaAddEvent(HUIANODE__* hnode, int eventId, UiaEventCallback* pCallback, TreeScope scope, int* pProperties, int cProperties, UiaCacheRequest* pRequest, HUIAEVENT__** phEvent);

@DllImport("UIAutomationCore.dll")
HRESULT UiaRemoveEvent(HUIAEVENT__* hEvent);

@DllImport("UIAutomationCore.dll")
HRESULT UiaEventAddWindow(HUIAEVENT__* hEvent, HWND hwnd);

@DllImport("UIAutomationCore.dll")
HRESULT UiaEventRemoveWindow(HUIAEVENT__* hEvent, HWND hwnd);

@DllImport("UIAutomationCore.dll")
HRESULT DockPattern_SetDockPosition(HUIAPATTERNOBJECT__* hobj, DockPosition dockPosition);

@DllImport("UIAutomationCore.dll")
HRESULT ExpandCollapsePattern_Collapse(HUIAPATTERNOBJECT__* hobj);

@DllImport("UIAutomationCore.dll")
HRESULT ExpandCollapsePattern_Expand(HUIAPATTERNOBJECT__* hobj);

@DllImport("UIAutomationCore.dll")
HRESULT GridPattern_GetItem(HUIAPATTERNOBJECT__* hobj, int row, int column, HUIANODE__** pResult);

@DllImport("UIAutomationCore.dll")
HRESULT InvokePattern_Invoke(HUIAPATTERNOBJECT__* hobj);

@DllImport("UIAutomationCore.dll")
HRESULT MultipleViewPattern_GetViewName(HUIAPATTERNOBJECT__* hobj, int viewId, BSTR* ppStr);

@DllImport("UIAutomationCore.dll")
HRESULT MultipleViewPattern_SetCurrentView(HUIAPATTERNOBJECT__* hobj, int viewId);

@DllImport("UIAutomationCore.dll")
HRESULT RangeValuePattern_SetValue(HUIAPATTERNOBJECT__* hobj, double val);

@DllImport("UIAutomationCore.dll")
HRESULT ScrollItemPattern_ScrollIntoView(HUIAPATTERNOBJECT__* hobj);

@DllImport("UIAutomationCore.dll")
HRESULT ScrollPattern_Scroll(HUIAPATTERNOBJECT__* hobj, ScrollAmount horizontalAmount, ScrollAmount verticalAmount);

@DllImport("UIAutomationCore.dll")
HRESULT ScrollPattern_SetScrollPercent(HUIAPATTERNOBJECT__* hobj, double horizontalPercent, double verticalPercent);

@DllImport("UIAutomationCore.dll")
HRESULT SelectionItemPattern_AddToSelection(HUIAPATTERNOBJECT__* hobj);

@DllImport("UIAutomationCore.dll")
HRESULT SelectionItemPattern_RemoveFromSelection(HUIAPATTERNOBJECT__* hobj);

@DllImport("UIAutomationCore.dll")
HRESULT SelectionItemPattern_Select(HUIAPATTERNOBJECT__* hobj);

@DllImport("UIAutomationCore.dll")
HRESULT TogglePattern_Toggle(HUIAPATTERNOBJECT__* hobj);

@DllImport("UIAutomationCore.dll")
HRESULT TransformPattern_Move(HUIAPATTERNOBJECT__* hobj, double x, double y);

@DllImport("UIAutomationCore.dll")
HRESULT TransformPattern_Resize(HUIAPATTERNOBJECT__* hobj, double width, double height);

@DllImport("UIAutomationCore.dll")
HRESULT TransformPattern_Rotate(HUIAPATTERNOBJECT__* hobj, double degrees);

@DllImport("UIAutomationCore.dll")
HRESULT ValuePattern_SetValue(HUIAPATTERNOBJECT__* hobj, const(wchar)* pVal);

@DllImport("UIAutomationCore.dll")
HRESULT WindowPattern_Close(HUIAPATTERNOBJECT__* hobj);

@DllImport("UIAutomationCore.dll")
HRESULT WindowPattern_SetWindowVisualState(HUIAPATTERNOBJECT__* hobj, WindowVisualState state);

@DllImport("UIAutomationCore.dll")
HRESULT WindowPattern_WaitForInputIdle(HUIAPATTERNOBJECT__* hobj, int milliseconds, int* pResult);

@DllImport("UIAutomationCore.dll")
HRESULT TextPattern_GetSelection(HUIAPATTERNOBJECT__* hobj, SAFEARRAY** pRetVal);

@DllImport("UIAutomationCore.dll")
HRESULT TextPattern_GetVisibleRanges(HUIAPATTERNOBJECT__* hobj, SAFEARRAY** pRetVal);

@DllImport("UIAutomationCore.dll")
HRESULT TextPattern_RangeFromChild(HUIAPATTERNOBJECT__* hobj, HUIANODE__* hnodeChild, HUIATEXTRANGE__** pRetVal);

@DllImport("UIAutomationCore.dll")
HRESULT TextPattern_RangeFromPoint(HUIAPATTERNOBJECT__* hobj, UiaPoint point, HUIATEXTRANGE__** pRetVal);

@DllImport("UIAutomationCore.dll")
HRESULT TextPattern_get_DocumentRange(HUIAPATTERNOBJECT__* hobj, HUIATEXTRANGE__** pRetVal);

@DllImport("UIAutomationCore.dll")
HRESULT TextPattern_get_SupportedTextSelection(HUIAPATTERNOBJECT__* hobj, SupportedTextSelection* pRetVal);

@DllImport("UIAutomationCore.dll")
HRESULT TextRange_Clone(HUIATEXTRANGE__* hobj, HUIATEXTRANGE__** pRetVal);

@DllImport("UIAutomationCore.dll")
HRESULT TextRange_Compare(HUIATEXTRANGE__* hobj, HUIATEXTRANGE__* range, int* pRetVal);

@DllImport("UIAutomationCore.dll")
HRESULT TextRange_CompareEndpoints(HUIATEXTRANGE__* hobj, TextPatternRangeEndpoint endpoint, HUIATEXTRANGE__* targetRange, TextPatternRangeEndpoint targetEndpoint, int* pRetVal);

@DllImport("UIAutomationCore.dll")
HRESULT TextRange_ExpandToEnclosingUnit(HUIATEXTRANGE__* hobj, TextUnit unit);

@DllImport("UIAutomationCore.dll")
HRESULT TextRange_GetAttributeValue(HUIATEXTRANGE__* hobj, int attributeId, VARIANT* pRetVal);

@DllImport("UIAutomationCore.dll")
HRESULT TextRange_FindAttribute(HUIATEXTRANGE__* hobj, int attributeId, VARIANT val, BOOL backward, HUIATEXTRANGE__** pRetVal);

@DllImport("UIAutomationCore.dll")
HRESULT TextRange_FindText(HUIATEXTRANGE__* hobj, BSTR text, BOOL backward, BOOL ignoreCase, HUIATEXTRANGE__** pRetVal);

@DllImport("UIAutomationCore.dll")
HRESULT TextRange_GetBoundingRectangles(HUIATEXTRANGE__* hobj, SAFEARRAY** pRetVal);

@DllImport("UIAutomationCore.dll")
HRESULT TextRange_GetEnclosingElement(HUIATEXTRANGE__* hobj, HUIANODE__** pRetVal);

@DllImport("UIAutomationCore.dll")
HRESULT TextRange_GetText(HUIATEXTRANGE__* hobj, int maxLength, BSTR* pRetVal);

@DllImport("UIAutomationCore.dll")
HRESULT TextRange_Move(HUIATEXTRANGE__* hobj, TextUnit unit, int count, int* pRetVal);

@DllImport("UIAutomationCore.dll")
HRESULT TextRange_MoveEndpointByUnit(HUIATEXTRANGE__* hobj, TextPatternRangeEndpoint endpoint, TextUnit unit, int count, int* pRetVal);

@DllImport("UIAutomationCore.dll")
HRESULT TextRange_MoveEndpointByRange(HUIATEXTRANGE__* hobj, TextPatternRangeEndpoint endpoint, HUIATEXTRANGE__* targetRange, TextPatternRangeEndpoint targetEndpoint);

@DllImport("UIAutomationCore.dll")
HRESULT TextRange_Select(HUIATEXTRANGE__* hobj);

@DllImport("UIAutomationCore.dll")
HRESULT TextRange_AddToSelection(HUIATEXTRANGE__* hobj);

@DllImport("UIAutomationCore.dll")
HRESULT TextRange_RemoveFromSelection(HUIATEXTRANGE__* hobj);

@DllImport("UIAutomationCore.dll")
HRESULT TextRange_ScrollIntoView(HUIATEXTRANGE__* hobj, BOOL alignToTop);

@DllImport("UIAutomationCore.dll")
HRESULT TextRange_GetChildren(HUIATEXTRANGE__* hobj, SAFEARRAY** pRetVal);

@DllImport("UIAutomationCore.dll")
HRESULT ItemContainerPattern_FindItemByProperty(HUIAPATTERNOBJECT__* hobj, HUIANODE__* hnodeStartAfter, int propertyId, VARIANT value, HUIANODE__** pFound);

@DllImport("UIAutomationCore.dll")
HRESULT LegacyIAccessiblePattern_Select(HUIAPATTERNOBJECT__* hobj, int flagsSelect);

@DllImport("UIAutomationCore.dll")
HRESULT LegacyIAccessiblePattern_DoDefaultAction(HUIAPATTERNOBJECT__* hobj);

@DllImport("UIAutomationCore.dll")
HRESULT LegacyIAccessiblePattern_SetValue(HUIAPATTERNOBJECT__* hobj, const(wchar)* szValue);

@DllImport("UIAutomationCore.dll")
HRESULT LegacyIAccessiblePattern_GetIAccessible(HUIAPATTERNOBJECT__* hobj, IAccessible* pAccessible);

@DllImport("UIAutomationCore.dll")
HRESULT SynchronizedInputPattern_StartListening(HUIAPATTERNOBJECT__* hobj, SynchronizedInputType inputType);

@DllImport("UIAutomationCore.dll")
HRESULT SynchronizedInputPattern_Cancel(HUIAPATTERNOBJECT__* hobj);

@DllImport("UIAutomationCore.dll")
HRESULT VirtualizedItemPattern_Realize(HUIAPATTERNOBJECT__* hobj);

@DllImport("UIAutomationCore.dll")
BOOL UiaPatternRelease(HUIAPATTERNOBJECT__* hobj);

@DllImport("UIAutomationCore.dll")
BOOL UiaTextRangeRelease(HUIATEXTRANGE__* hobj);

@DllImport("UIAutomationCore.dll")
LRESULT UiaReturnRawElementProvider(HWND hwnd, WPARAM wParam, LPARAM lParam, IRawElementProviderSimple el);

@DllImport("UIAutomationCore.dll")
HRESULT UiaHostProviderFromHwnd(HWND hwnd, IRawElementProviderSimple* ppProvider);

@DllImport("UIAutomationCore.dll")
HRESULT UiaProviderForNonClient(HWND hwnd, int idObject, int idChild, IRawElementProviderSimple* ppProvider);

@DllImport("UIAutomationCore.dll")
HRESULT UiaIAccessibleFromProvider(IRawElementProviderSimple pProvider, uint dwFlags, IAccessible* ppAccessible, VARIANT* pvarChild);

@DllImport("UIAutomationCore.dll")
HRESULT UiaProviderFromIAccessible(IAccessible pAccessible, int idChild, uint dwFlags, IRawElementProviderSimple* ppProvider);

@DllImport("UIAutomationCore.dll")
HRESULT UiaDisconnectAllProviders();

@DllImport("UIAutomationCore.dll")
HRESULT UiaDisconnectProvider(IRawElementProviderSimple pProvider);

@DllImport("UIAutomationCore.dll")
BOOL UiaHasServerSideProvider(HWND hwnd);

const GUID CLSID_MSAAControl = {0x08CD963F, 0x7A3E, 0x4F5C, [0x9B, 0xD8, 0xD6, 0x92, 0xBB, 0x04, 0x3C, 0x5B]};
@GUID(0x08CD963F, 0x7A3E, 0x4F5C, [0x9B, 0xD8, 0xD6, 0x92, 0xBB, 0x04, 0x3C, 0x5B]);
struct MSAAControl;

const GUID CLSID_AccStore = {0x5440837F, 0x4BFF, 0x4AE5, [0xA1, 0xB1, 0x77, 0x22, 0xEC, 0xC6, 0x33, 0x2A]};
@GUID(0x5440837F, 0x4BFF, 0x4AE5, [0xA1, 0xB1, 0x77, 0x22, 0xEC, 0xC6, 0x33, 0x2A]);
struct AccStore;

const GUID CLSID_AccDictionary = {0x6572EE16, 0x5FE5, 0x4331, [0xBB, 0x6D, 0x76, 0xA4, 0x9C, 0x56, 0xE4, 0x23]};
@GUID(0x6572EE16, 0x5FE5, 0x4331, [0xBB, 0x6D, 0x76, 0xA4, 0x9C, 0x56, 0xE4, 0x23]);
struct AccDictionary;

const GUID CLSID_AccServerDocMgr = {0x6089A37E, 0xEB8A, 0x482D, [0xBD, 0x6F, 0xF9, 0xF4, 0x69, 0x04, 0xD1, 0x6D]};
@GUID(0x6089A37E, 0xEB8A, 0x482D, [0xBD, 0x6F, 0xF9, 0xF4, 0x69, 0x04, 0xD1, 0x6D]);
struct AccServerDocMgr;

const GUID CLSID_AccClientDocMgr = {0xFC48CC30, 0x4F3E, 0x4FA1, [0x80, 0x3B, 0xAD, 0x0E, 0x19, 0x6A, 0x83, 0xB1]};
@GUID(0xFC48CC30, 0x4F3E, 0x4FA1, [0x80, 0x3B, 0xAD, 0x0E, 0x19, 0x6A, 0x83, 0xB1]);
struct AccClientDocMgr;

const GUID CLSID_DocWrap = {0xBF426F7E, 0x7A5E, 0x44D6, [0x83, 0x0C, 0xA3, 0x90, 0xEA, 0x94, 0x62, 0xA3]};
@GUID(0xBF426F7E, 0x7A5E, 0x44D6, [0x83, 0x0C, 0xA3, 0x90, 0xEA, 0x94, 0x62, 0xA3]);
struct DocWrap;

const GUID IID_IInternalDocWrap = {0xE1AA6466, 0x9DB4, 0x40BA, [0xBE, 0x03, 0x77, 0xC3, 0x8E, 0x8E, 0x60, 0xB2]};
@GUID(0xE1AA6466, 0x9DB4, 0x40BA, [0xBE, 0x03, 0x77, 0xC3, 0x8E, 0x8E, 0x60, 0xB2]);
interface IInternalDocWrap : IUnknown
{
    HRESULT NotifyRevoke();
}

const GUID IID_ITextStoreACPEx = {0xA2DE3BC2, 0x3D8E, 0x11D3, [0x81, 0xA9, 0xF7, 0x53, 0xFB, 0xE6, 0x1A, 0x00]};
@GUID(0xA2DE3BC2, 0x3D8E, 0x11D3, [0x81, 0xA9, 0xF7, 0x53, 0xFB, 0xE6, 0x1A, 0x00]);
interface ITextStoreACPEx : IUnknown
{
    HRESULT ScrollToRect(int acpStart, int acpEnd, RECT rc, uint dwPosition);
}

const GUID IID_ITextStoreAnchorEx = {0xA2DE3BC1, 0x3D8E, 0x11D3, [0x81, 0xA9, 0xF7, 0x53, 0xFB, 0xE6, 0x1A, 0x00]};
@GUID(0xA2DE3BC1, 0x3D8E, 0x11D3, [0x81, 0xA9, 0xF7, 0x53, 0xFB, 0xE6, 0x1A, 0x00]);
interface ITextStoreAnchorEx : IUnknown
{
    HRESULT ScrollToRect(IAnchor pStart, IAnchor pEnd, RECT rc, uint dwPosition);
}

const GUID IID_ITextStoreACPSinkEx = {0x2BDF9464, 0x41E2, 0x43E3, [0x95, 0x0C, 0xA6, 0x86, 0x5B, 0xA2, 0x5C, 0xD4]};
@GUID(0x2BDF9464, 0x41E2, 0x43E3, [0x95, 0x0C, 0xA6, 0x86, 0x5B, 0xA2, 0x5C, 0xD4]);
interface ITextStoreACPSinkEx : ITextStoreACPSink
{
    HRESULT OnDisconnect();
}

const GUID IID_ITextStoreSinkAnchorEx = {0x25642426, 0x028D, 0x4474, [0x97, 0x7B, 0x11, 0x1B, 0xB1, 0x14, 0xFE, 0x3E]};
@GUID(0x25642426, 0x028D, 0x4474, [0x97, 0x7B, 0x11, 0x1B, 0xB1, 0x14, 0xFE, 0x3E]);
interface ITextStoreSinkAnchorEx : ITextStoreAnchorSink
{
    HRESULT OnDisconnect();
}

const GUID IID_IAccDictionary = {0x1DC4CB5F, 0xD737, 0x474D, [0xAD, 0xE9, 0x5C, 0xCF, 0xC9, 0xBC, 0x1C, 0xC9]};
@GUID(0x1DC4CB5F, 0xD737, 0x474D, [0xAD, 0xE9, 0x5C, 0xCF, 0xC9, 0xBC, 0x1C, 0xC9]);
interface IAccDictionary : IUnknown
{
    HRESULT GetLocalizedString(const(Guid)* Term, uint lcid, BSTR* pResult, uint* plcid);
    HRESULT GetParentTerm(const(Guid)* Term, Guid* pParentTerm);
    HRESULT GetMnemonicString(const(Guid)* Term, BSTR* pResult);
    HRESULT LookupMnemonicTerm(BSTR bstrMnemonic, Guid* pTerm);
    HRESULT ConvertValueToString(const(Guid)* Term, uint lcid, VARIANT varValue, BSTR* pbstrResult, uint* plcid);
}

const GUID IID_IVersionInfo = {0x401518EC, 0xDB00, 0x4611, [0x9B, 0x29, 0x2A, 0x0E, 0x4B, 0x9A, 0xFA, 0x85]};
@GUID(0x401518EC, 0xDB00, 0x4611, [0x9B, 0x29, 0x2A, 0x0E, 0x4B, 0x9A, 0xFA, 0x85]);
interface IVersionInfo : IUnknown
{
    HRESULT GetSubcomponentCount(uint ulSub, uint* ulCount);
    HRESULT GetImplementationID(uint ulSub, Guid* implid);
    HRESULT GetBuildVersion(uint ulSub, uint* pdwMajor, uint* pdwMinor);
    HRESULT GetComponentDescription(uint ulSub, BSTR* pImplStr);
    HRESULT GetInstanceDescription(uint ulSub, BSTR* pImplStr);
}

const GUID IID_ICoCreateLocally = {0x03DE00AA, 0xF272, 0x41E3, [0x99, 0xCB, 0x03, 0xC5, 0xE8, 0x11, 0x4E, 0xA0]};
@GUID(0x03DE00AA, 0xF272, 0x41E3, [0x99, 0xCB, 0x03, 0xC5, 0xE8, 0x11, 0x4E, 0xA0]);
interface ICoCreateLocally : IUnknown
{
    HRESULT CoCreateLocally(const(Guid)* rclsid, uint dwClsContext, const(Guid)* riid, IUnknown* punk, const(Guid)* riidParam, IUnknown punkParam, VARIANT varParam);
}

const GUID IID_ICoCreatedLocally = {0x0A53EB6C, 0x1908, 0x4742, [0x8C, 0xFF, 0x2C, 0xEE, 0x2E, 0x93, 0xF9, 0x4C]};
@GUID(0x0A53EB6C, 0x1908, 0x4742, [0x8C, 0xFF, 0x2C, 0xEE, 0x2E, 0x93, 0xF9, 0x4C]);
interface ICoCreatedLocally : IUnknown
{
    HRESULT LocalInit(IUnknown punkLocalObject, const(Guid)* riidParam, IUnknown punkParam, VARIANT varParam);
}

const GUID IID_IAccStore = {0xE2CD4A63, 0x2B72, 0x4D48, [0xB7, 0x39, 0x95, 0xE4, 0x76, 0x51, 0x95, 0xBA]};
@GUID(0xE2CD4A63, 0x2B72, 0x4D48, [0xB7, 0x39, 0x95, 0xE4, 0x76, 0x51, 0x95, 0xBA]);
interface IAccStore : IUnknown
{
    HRESULT Register(const(Guid)* riid, IUnknown punk);
    HRESULT Unregister(IUnknown punk);
    HRESULT GetDocuments(IEnumUnknown* enumUnknown);
    HRESULT LookupByHWND(HWND hWnd, const(Guid)* riid, IUnknown* ppunk);
    HRESULT LookupByPoint(POINT pt, const(Guid)* riid, IUnknown* ppunk);
    HRESULT OnDocumentFocus(IUnknown punk);
    HRESULT GetFocused(const(Guid)* riid, IUnknown* ppunk);
}

const GUID IID_IAccServerDocMgr = {0xAD7C73CF, 0x6DD5, 0x4855, [0xAB, 0xC2, 0xB0, 0x4B, 0xAD, 0x5B, 0x91, 0x53]};
@GUID(0xAD7C73CF, 0x6DD5, 0x4855, [0xAB, 0xC2, 0xB0, 0x4B, 0xAD, 0x5B, 0x91, 0x53]);
interface IAccServerDocMgr : IUnknown
{
    HRESULT NewDocument(const(Guid)* riid, IUnknown punk);
    HRESULT RevokeDocument(IUnknown punk);
    HRESULT OnDocumentFocus(IUnknown punk);
}

const GUID IID_IAccClientDocMgr = {0x4C896039, 0x7B6D, 0x49E6, [0xA8, 0xC1, 0x45, 0x11, 0x6A, 0x98, 0x29, 0x2B]};
@GUID(0x4C896039, 0x7B6D, 0x49E6, [0xA8, 0xC1, 0x45, 0x11, 0x6A, 0x98, 0x29, 0x2B]);
interface IAccClientDocMgr : IUnknown
{
    HRESULT GetDocuments(IEnumUnknown* enumUnknown);
    HRESULT LookupByHWND(HWND hWnd, const(Guid)* riid, IUnknown* ppunk);
    HRESULT LookupByPoint(POINT pt, const(Guid)* riid, IUnknown* ppunk);
    HRESULT GetFocused(const(Guid)* riid, IUnknown* ppunk);
}

const GUID IID_IDocWrap = {0xDCD285FE, 0x0BE0, 0x43BD, [0x99, 0xC9, 0xAA, 0xAE, 0xC5, 0x13, 0xC5, 0x55]};
@GUID(0xDCD285FE, 0x0BE0, 0x43BD, [0x99, 0xC9, 0xAA, 0xAE, 0xC5, 0x13, 0xC5, 0x55]);
interface IDocWrap : IUnknown
{
    HRESULT SetDoc(const(Guid)* riid, IUnknown punk);
    HRESULT GetWrappedDoc(const(Guid)* riid, IUnknown* ppunk);
}

const GUID IID_IClonableWrapper = {0xB33E75FF, 0xE84C, 0x4DCA, [0xA2, 0x5C, 0x33, 0xB8, 0xDC, 0x00, 0x33, 0x74]};
@GUID(0xB33E75FF, 0xE84C, 0x4DCA, [0xA2, 0x5C, 0x33, 0xB8, 0xDC, 0x00, 0x33, 0x74]);
interface IClonableWrapper : IUnknown
{
    HRESULT CloneNewWrapper(const(Guid)* riid, void** ppv);
}

const GUID CLSID_CAccPropServices = {0xB5F8350B, 0x0548, 0x48B1, [0xA6, 0xEE, 0x88, 0xBD, 0x00, 0xB4, 0xA5, 0xE7]};
@GUID(0xB5F8350B, 0x0548, 0x48B1, [0xA6, 0xEE, 0x88, 0xBD, 0x00, 0xB4, 0xA5, 0xE7]);
struct CAccPropServices;

alias LPFNLRESULTFROMOBJECT = extern(Windows) LRESULT function(const(Guid)* riid, WPARAM wParam, IUnknown punk);
alias LPFNOBJECTFROMLRESULT = extern(Windows) HRESULT function(LRESULT lResult, const(Guid)* riid, WPARAM wParam, void** ppvObject);
alias LPFNACCESSIBLEOBJECTFROMWINDOW = extern(Windows) HRESULT function(HWND hwnd, uint dwId, const(Guid)* riid, void** ppvObject);
alias LPFNACCESSIBLEOBJECTFROMPOINT = extern(Windows) HRESULT function(POINT ptScreen, IAccessible* ppacc, VARIANT* pvarChild);
alias LPFNCREATESTDACCESSIBLEOBJECT = extern(Windows) HRESULT function(HWND hwnd, int idObject, const(Guid)* riid, void** ppvObject);
alias LPFNACCESSIBLECHILDREN = extern(Windows) HRESULT function(IAccessible paccContainer, int iChildStart, int cChildren, VARIANT* rgvarChildren, int* pcObtained);
struct MSAAMENUINFO
{
    uint dwMSAASignature;
    uint cchWText;
    const(wchar)* pszWText;
}

const GUID IID_IAccessible = {0x618736E0, 0x3C3D, 0x11CF, [0x81, 0x0C, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x618736E0, 0x3C3D, 0x11CF, [0x81, 0x0C, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
interface IAccessible : IDispatch
{
    HRESULT get_accParent(IDispatch* ppdispParent);
    HRESULT get_accChildCount(int* pcountChildren);
    HRESULT get_accChild(VARIANT varChild, IDispatch* ppdispChild);
    HRESULT get_accName(VARIANT varChild, BSTR* pszName);
    HRESULT get_accValue(VARIANT varChild, BSTR* pszValue);
    HRESULT get_accDescription(VARIANT varChild, BSTR* pszDescription);
    HRESULT get_accRole(VARIANT varChild, VARIANT* pvarRole);
    HRESULT get_accState(VARIANT varChild, VARIANT* pvarState);
    HRESULT get_accHelp(VARIANT varChild, BSTR* pszHelp);
    HRESULT get_accHelpTopic(BSTR* pszHelpFile, VARIANT varChild, int* pidTopic);
    HRESULT get_accKeyboardShortcut(VARIANT varChild, BSTR* pszKeyboardShortcut);
    HRESULT get_accFocus(VARIANT* pvarChild);
    HRESULT get_accSelection(VARIANT* pvarChildren);
    HRESULT get_accDefaultAction(VARIANT varChild, BSTR* pszDefaultAction);
    HRESULT accSelect(int flagsSelect, VARIANT varChild);
    HRESULT accLocation(int* pxLeft, int* pyTop, int* pcxWidth, int* pcyHeight, VARIANT varChild);
    HRESULT accNavigate(int navDir, VARIANT varStart, VARIANT* pvarEndUpAt);
    HRESULT accHitTest(int xLeft, int yTop, VARIANT* pvarChild);
    HRESULT accDoDefaultAction(VARIANT varChild);
    HRESULT put_accName(VARIANT varChild, BSTR szName);
    HRESULT put_accValue(VARIANT varChild, BSTR szValue);
}

const GUID IID_IAccessibleHandler = {0x03022430, 0xABC4, 0x11D0, [0xBD, 0xE2, 0x00, 0xAA, 0x00, 0x1A, 0x19, 0x53]};
@GUID(0x03022430, 0xABC4, 0x11D0, [0xBD, 0xE2, 0x00, 0xAA, 0x00, 0x1A, 0x19, 0x53]);
interface IAccessibleHandler : IUnknown
{
    HRESULT AccessibleObjectFromID(int hwnd, int lObjectID, IAccessible* pIAccessible);
}

const GUID IID_IAccessibleWindowlessSite = {0xBF3ABD9C, 0x76DA, 0x4389, [0x9E, 0xB6, 0x14, 0x27, 0xD2, 0x5A, 0xBA, 0xB7]};
@GUID(0xBF3ABD9C, 0x76DA, 0x4389, [0x9E, 0xB6, 0x14, 0x27, 0xD2, 0x5A, 0xBA, 0xB7]);
interface IAccessibleWindowlessSite : IUnknown
{
    HRESULT AcquireObjectIdRange(int rangeSize, IAccessibleHandler pRangeOwner, int* pRangeBase);
    HRESULT ReleaseObjectIdRange(int rangeBase, IAccessibleHandler pRangeOwner);
    HRESULT QueryObjectIdRanges(IAccessibleHandler pRangesOwner, SAFEARRAY** psaRanges);
    HRESULT GetParentAccessible(IAccessible* ppParent);
}

enum AnnoScope
{
    ANNO_THIS = 0,
    ANNO_CONTAINER = 1,
}

const GUID IID_IAccIdentity = {0x7852B78D, 0x1CFD, 0x41C1, [0xA6, 0x15, 0x9C, 0x0C, 0x85, 0x96, 0x0B, 0x5F]};
@GUID(0x7852B78D, 0x1CFD, 0x41C1, [0xA6, 0x15, 0x9C, 0x0C, 0x85, 0x96, 0x0B, 0x5F]);
interface IAccIdentity : IUnknown
{
    HRESULT GetIdentityString(uint dwIDChild, char* ppIDString, uint* pdwIDStringLen);
}

const GUID IID_IAccPropServer = {0x76C0DBBB, 0x15E0, 0x4E7B, [0xB6, 0x1B, 0x20, 0xEE, 0xEA, 0x20, 0x01, 0xE0]};
@GUID(0x76C0DBBB, 0x15E0, 0x4E7B, [0xB6, 0x1B, 0x20, 0xEE, 0xEA, 0x20, 0x01, 0xE0]);
interface IAccPropServer : IUnknown
{
    HRESULT GetPropValue(char* pIDString, uint dwIDStringLen, Guid idProp, VARIANT* pvarValue, int* pfHasProp);
}

const GUID IID_IAccPropServices = {0x6E26E776, 0x04F0, 0x495D, [0x80, 0xE4, 0x33, 0x30, 0x35, 0x2E, 0x31, 0x69]};
@GUID(0x6E26E776, 0x04F0, 0x495D, [0x80, 0xE4, 0x33, 0x30, 0x35, 0x2E, 0x31, 0x69]);
interface IAccPropServices : IUnknown
{
    HRESULT SetPropValue(char* pIDString, uint dwIDStringLen, Guid idProp, VARIANT var);
    HRESULT SetPropServer(char* pIDString, uint dwIDStringLen, char* paProps, int cProps, IAccPropServer pServer, AnnoScope annoScope);
    HRESULT ClearProps(char* pIDString, uint dwIDStringLen, char* paProps, int cProps);
    HRESULT SetHwndProp(HWND hwnd, uint idObject, uint idChild, Guid idProp, VARIANT var);
    HRESULT SetHwndPropStr(HWND hwnd, uint idObject, uint idChild, Guid idProp, const(wchar)* str);
    HRESULT SetHwndPropServer(HWND hwnd, uint idObject, uint idChild, char* paProps, int cProps, IAccPropServer pServer, AnnoScope annoScope);
    HRESULT ClearHwndProps(HWND hwnd, uint idObject, uint idChild, char* paProps, int cProps);
    HRESULT ComposeHwndIdentityString(HWND hwnd, uint idObject, uint idChild, char* ppIDString, uint* pdwIDStringLen);
    HRESULT DecomposeHwndIdentityString(char* pIDString, uint dwIDStringLen, HWND* phwnd, uint* pidObject, uint* pidChild);
    HRESULT SetHmenuProp(HMENU hmenu, uint idChild, Guid idProp, VARIANT var);
    HRESULT SetHmenuPropStr(HMENU hmenu, uint idChild, Guid idProp, const(wchar)* str);
    HRESULT SetHmenuPropServer(HMENU hmenu, uint idChild, char* paProps, int cProps, IAccPropServer pServer, AnnoScope annoScope);
    HRESULT ClearHmenuProps(HMENU hmenu, uint idChild, char* paProps, int cProps);
    HRESULT ComposeHmenuIdentityString(HMENU hmenu, uint idChild, char* ppIDString, uint* pdwIDStringLen);
    HRESULT DecomposeHmenuIdentityString(char* pIDString, uint dwIDStringLen, HMENU* phmenu, uint* pidChild);
}

const GUID CLSID_CUIAutomationRegistrar = {0x6E29FABF, 0x9977, 0x42D1, [0x8D, 0x0E, 0xCA, 0x7E, 0x61, 0xAD, 0x87, 0xE6]};
@GUID(0x6E29FABF, 0x9977, 0x42D1, [0x8D, 0x0E, 0xCA, 0x7E, 0x61, 0xAD, 0x87, 0xE6]);
struct CUIAutomationRegistrar;

enum NavigateDirection
{
    NavigateDirection_Parent = 0,
    NavigateDirection_NextSibling = 1,
    NavigateDirection_PreviousSibling = 2,
    NavigateDirection_FirstChild = 3,
    NavigateDirection_LastChild = 4,
}

enum ProviderOptions
{
    ProviderOptions_ClientSideProvider = 1,
    ProviderOptions_ServerSideProvider = 2,
    ProviderOptions_NonClientAreaProvider = 4,
    ProviderOptions_OverrideProvider = 8,
    ProviderOptions_ProviderOwnsSetFocus = 16,
    ProviderOptions_UseComThreading = 32,
    ProviderOptions_RefuseNonClientSupport = 64,
    ProviderOptions_HasNativeIAccessible = 128,
    ProviderOptions_UseClientCoordinates = 256,
}

enum StructureChangeType
{
    StructureChangeType_ChildAdded = 0,
    StructureChangeType_ChildRemoved = 1,
    StructureChangeType_ChildrenInvalidated = 2,
    StructureChangeType_ChildrenBulkAdded = 3,
    StructureChangeType_ChildrenBulkRemoved = 4,
    StructureChangeType_ChildrenReordered = 5,
}

enum TextEditChangeType
{
    TextEditChangeType_None = 0,
    TextEditChangeType_AutoCorrect = 1,
    TextEditChangeType_Composition = 2,
    TextEditChangeType_CompositionFinalized = 3,
    TextEditChangeType_AutoComplete = 4,
}

enum OrientationType
{
    OrientationType_None = 0,
    OrientationType_Horizontal = 1,
    OrientationType_Vertical = 2,
}

enum DockPosition
{
    DockPosition_Top = 0,
    DockPosition_Left = 1,
    DockPosition_Bottom = 2,
    DockPosition_Right = 3,
    DockPosition_Fill = 4,
    DockPosition_None = 5,
}

enum ExpandCollapseState
{
    ExpandCollapseState_Collapsed = 0,
    ExpandCollapseState_Expanded = 1,
    ExpandCollapseState_PartiallyExpanded = 2,
    ExpandCollapseState_LeafNode = 3,
}

enum ScrollAmount
{
    ScrollAmount_LargeDecrement = 0,
    ScrollAmount_SmallDecrement = 1,
    ScrollAmount_NoAmount = 2,
    ScrollAmount_LargeIncrement = 3,
    ScrollAmount_SmallIncrement = 4,
}

enum RowOrColumnMajor
{
    RowOrColumnMajor_RowMajor = 0,
    RowOrColumnMajor_ColumnMajor = 1,
    RowOrColumnMajor_Indeterminate = 2,
}

enum ToggleState
{
    ToggleState_Off = 0,
    ToggleState_On = 1,
    ToggleState_Indeterminate = 2,
}

enum WindowVisualState
{
    WindowVisualState_Normal = 0,
    WindowVisualState_Maximized = 1,
    WindowVisualState_Minimized = 2,
}

enum SynchronizedInputType
{
    SynchronizedInputType_KeyUp = 1,
    SynchronizedInputType_KeyDown = 2,
    SynchronizedInputType_LeftMouseUp = 4,
    SynchronizedInputType_LeftMouseDown = 8,
    SynchronizedInputType_RightMouseUp = 16,
    SynchronizedInputType_RightMouseDown = 32,
}

enum WindowInteractionState
{
    WindowInteractionState_Running = 0,
    WindowInteractionState_Closing = 1,
    WindowInteractionState_ReadyForUserInteraction = 2,
    WindowInteractionState_BlockedByModalWindow = 3,
    WindowInteractionState_NotResponding = 4,
}

enum SayAsInterpretAs
{
    SayAsInterpretAs_None = 0,
    SayAsInterpretAs_Spell = 1,
    SayAsInterpretAs_Cardinal = 2,
    SayAsInterpretAs_Ordinal = 3,
    SayAsInterpretAs_Number = 4,
    SayAsInterpretAs_Date = 5,
    SayAsInterpretAs_Time = 6,
    SayAsInterpretAs_Telephone = 7,
    SayAsInterpretAs_Currency = 8,
    SayAsInterpretAs_Net = 9,
    SayAsInterpretAs_Url = 10,
    SayAsInterpretAs_Address = 11,
    SayAsInterpretAs_Alphanumeric = 12,
    SayAsInterpretAs_Name = 13,
    SayAsInterpretAs_Media = 14,
    SayAsInterpretAs_Date_MonthDayYear = 15,
    SayAsInterpretAs_Date_DayMonthYear = 16,
    SayAsInterpretAs_Date_YearMonthDay = 17,
    SayAsInterpretAs_Date_YearMonth = 18,
    SayAsInterpretAs_Date_MonthYear = 19,
    SayAsInterpretAs_Date_DayMonth = 20,
    SayAsInterpretAs_Date_MonthDay = 21,
    SayAsInterpretAs_Date_Year = 22,
    SayAsInterpretAs_Time_HoursMinutesSeconds12 = 23,
    SayAsInterpretAs_Time_HoursMinutes12 = 24,
    SayAsInterpretAs_Time_HoursMinutesSeconds24 = 25,
    SayAsInterpretAs_Time_HoursMinutes24 = 26,
}

enum TextUnit
{
    TextUnit_Character = 0,
    TextUnit_Format = 1,
    TextUnit_Word = 2,
    TextUnit_Line = 3,
    TextUnit_Paragraph = 4,
    TextUnit_Page = 5,
    TextUnit_Document = 6,
}

enum TextPatternRangeEndpoint
{
    TextPatternRangeEndpoint_Start = 0,
    TextPatternRangeEndpoint_End = 1,
}

enum SupportedTextSelection
{
    SupportedTextSelection_None = 0,
    SupportedTextSelection_Single = 1,
    SupportedTextSelection_Multiple = 2,
}

enum LiveSetting
{
    Off = 0,
    Polite = 1,
    Assertive = 2,
}

enum ActiveEnd
{
    ActiveEnd_None = 0,
    ActiveEnd_Start = 1,
    ActiveEnd_End = 2,
}

enum CaretPosition
{
    CaretPosition_Unknown = 0,
    CaretPosition_EndOfLine = 1,
    CaretPosition_BeginningOfLine = 2,
}

enum CaretBidiMode
{
    CaretBidiMode_LTR = 0,
    CaretBidiMode_RTL = 1,
}

enum ZoomUnit
{
    ZoomUnit_NoAmount = 0,
    ZoomUnit_LargeDecrement = 1,
    ZoomUnit_SmallDecrement = 2,
    ZoomUnit_LargeIncrement = 3,
    ZoomUnit_SmallIncrement = 4,
}

enum AnimationStyle
{
    AnimationStyle_None = 0,
    AnimationStyle_LasVegasLights = 1,
    AnimationStyle_BlinkingBackground = 2,
    AnimationStyle_SparkleText = 3,
    AnimationStyle_MarchingBlackAnts = 4,
    AnimationStyle_MarchingRedAnts = 5,
    AnimationStyle_Shimmer = 6,
    AnimationStyle_Other = -1,
}

enum BulletStyle
{
    BulletStyle_None = 0,
    BulletStyle_HollowRoundBullet = 1,
    BulletStyle_FilledRoundBullet = 2,
    BulletStyle_HollowSquareBullet = 3,
    BulletStyle_FilledSquareBullet = 4,
    BulletStyle_DashBullet = 5,
    BulletStyle_Other = -1,
}

enum CapStyle
{
    CapStyle_None = 0,
    CapStyle_SmallCap = 1,
    CapStyle_AllCap = 2,
    CapStyle_AllPetiteCaps = 3,
    CapStyle_PetiteCaps = 4,
    CapStyle_Unicase = 5,
    CapStyle_Titling = 6,
    CapStyle_Other = -1,
}

enum FillType
{
    FillType_None = 0,
    FillType_Color = 1,
    FillType_Gradient = 2,
    FillType_Picture = 3,
    FillType_Pattern = 4,
}

enum FlowDirections
{
    FlowDirections_Default = 0,
    FlowDirections_RightToLeft = 1,
    FlowDirections_BottomToTop = 2,
    FlowDirections_Vertical = 4,
}

enum HorizontalTextAlignment
{
    HorizontalTextAlignment_Left = 0,
    HorizontalTextAlignment_Centered = 1,
    HorizontalTextAlignment_Right = 2,
    HorizontalTextAlignment_Justified = 3,
}

enum OutlineStyles
{
    OutlineStyles_None = 0,
    OutlineStyles_Outline = 1,
    OutlineStyles_Shadow = 2,
    OutlineStyles_Engraved = 4,
    OutlineStyles_Embossed = 8,
}

enum TextDecorationLineStyle
{
    TextDecorationLineStyle_None = 0,
    TextDecorationLineStyle_Single = 1,
    TextDecorationLineStyle_WordsOnly = 2,
    TextDecorationLineStyle_Double = 3,
    TextDecorationLineStyle_Dot = 4,
    TextDecorationLineStyle_Dash = 5,
    TextDecorationLineStyle_DashDot = 6,
    TextDecorationLineStyle_DashDotDot = 7,
    TextDecorationLineStyle_Wavy = 8,
    TextDecorationLineStyle_ThickSingle = 9,
    TextDecorationLineStyle_DoubleWavy = 11,
    TextDecorationLineStyle_ThickWavy = 12,
    TextDecorationLineStyle_LongDash = 13,
    TextDecorationLineStyle_ThickDash = 14,
    TextDecorationLineStyle_ThickDashDot = 15,
    TextDecorationLineStyle_ThickDashDotDot = 16,
    TextDecorationLineStyle_ThickDot = 17,
    TextDecorationLineStyle_ThickLongDash = 18,
    TextDecorationLineStyle_Other = -1,
}

enum VisualEffects
{
    VisualEffects_None = 0,
    VisualEffects_Shadow = 1,
    VisualEffects_Reflection = 2,
    VisualEffects_Glow = 4,
    VisualEffects_SoftEdges = 8,
    VisualEffects_Bevel = 16,
}

enum NotificationProcessing
{
    NotificationProcessing_ImportantAll = 0,
    NotificationProcessing_ImportantMostRecent = 1,
    NotificationProcessing_All = 2,
    NotificationProcessing_MostRecent = 3,
    NotificationProcessing_CurrentThenMostRecent = 4,
}

enum NotificationKind
{
    NotificationKind_ItemAdded = 0,
    NotificationKind_ItemRemoved = 1,
    NotificationKind_ActionCompleted = 2,
    NotificationKind_ActionAborted = 3,
    NotificationKind_Other = 4,
}

struct UiaRect
{
    double left;
    double top;
    double width;
    double height;
}

struct UiaPoint
{
    double x;
    double y;
}

struct UiaChangeInfo
{
    int uiaId;
    VARIANT payload;
    VARIANT extraInfo;
}

enum UIAutomationType
{
    UIAutomationType_Int = 1,
    UIAutomationType_Bool = 2,
    UIAutomationType_String = 3,
    UIAutomationType_Double = 4,
    UIAutomationType_Point = 5,
    UIAutomationType_Rect = 6,
    UIAutomationType_Element = 7,
    UIAutomationType_Array = 65536,
    UIAutomationType_Out = 131072,
    UIAutomationType_IntArray = 65537,
    UIAutomationType_BoolArray = 65538,
    UIAutomationType_StringArray = 65539,
    UIAutomationType_DoubleArray = 65540,
    UIAutomationType_PointArray = 65541,
    UIAutomationType_RectArray = 65542,
    UIAutomationType_ElementArray = 65543,
    UIAutomationType_OutInt = 131073,
    UIAutomationType_OutBool = 131074,
    UIAutomationType_OutString = 131075,
    UIAutomationType_OutDouble = 131076,
    UIAutomationType_OutPoint = 131077,
    UIAutomationType_OutRect = 131078,
    UIAutomationType_OutElement = 131079,
    UIAutomationType_OutIntArray = 196609,
    UIAutomationType_OutBoolArray = 196610,
    UIAutomationType_OutStringArray = 196611,
    UIAutomationType_OutDoubleArray = 196612,
    UIAutomationType_OutPointArray = 196613,
    UIAutomationType_OutRectArray = 196614,
    UIAutomationType_OutElementArray = 196615,
}

struct UIAutomationParameter
{
    UIAutomationType type;
    void* pData;
}

struct UIAutomationPropertyInfo
{
    Guid guid;
    const(wchar)* pProgrammaticName;
    UIAutomationType type;
}

struct UIAutomationEventInfo
{
    Guid guid;
    const(wchar)* pProgrammaticName;
}

struct UIAutomationMethodInfo
{
    const(wchar)* pProgrammaticName;
    BOOL doSetFocus;
    uint cInParameters;
    uint cOutParameters;
    UIAutomationType* pParameterTypes;
    ushort** pParameterNames;
}

struct UIAutomationPatternInfo
{
    Guid guid;
    const(wchar)* pProgrammaticName;
    Guid providerInterfaceId;
    Guid clientInterfaceId;
    uint cProperties;
    UIAutomationPropertyInfo* pProperties;
    uint cMethods;
    UIAutomationMethodInfo* pMethods;
    uint cEvents;
    UIAutomationEventInfo* pEvents;
    IUIAutomationPatternHandler pPatternHandler;
}

const GUID IID_IRawElementProviderSimple = {0xD6DD68D1, 0x86FD, 0x4332, [0x86, 0x66, 0x9A, 0xBE, 0xDE, 0xA2, 0xD2, 0x4C]};
@GUID(0xD6DD68D1, 0x86FD, 0x4332, [0x86, 0x66, 0x9A, 0xBE, 0xDE, 0xA2, 0xD2, 0x4C]);
interface IRawElementProviderSimple : IUnknown
{
    HRESULT get_ProviderOptions(ProviderOptions* pRetVal);
    HRESULT GetPatternProvider(int patternId, IUnknown* pRetVal);
    HRESULT GetPropertyValue(int propertyId, VARIANT* pRetVal);
    HRESULT get_HostRawElementProvider(IRawElementProviderSimple* pRetVal);
}

const GUID IID_IAccessibleEx = {0xF8B80ADA, 0x2C44, 0x48D0, [0x89, 0xBE, 0x5F, 0xF2, 0x3C, 0x9C, 0xD8, 0x75]};
@GUID(0xF8B80ADA, 0x2C44, 0x48D0, [0x89, 0xBE, 0x5F, 0xF2, 0x3C, 0x9C, 0xD8, 0x75]);
interface IAccessibleEx : IUnknown
{
    HRESULT GetObjectForChild(int idChild, IAccessibleEx* pRetVal);
    HRESULT GetIAccessiblePair(IAccessible* ppAcc, int* pidChild);
    HRESULT GetRuntimeId(SAFEARRAY** pRetVal);
    HRESULT ConvertReturnedElement(IRawElementProviderSimple pIn, IAccessibleEx* ppRetValOut);
}

const GUID IID_IRawElementProviderSimple2 = {0xA0A839A9, 0x8DA1, 0x4A82, [0x80, 0x6A, 0x8E, 0x0D, 0x44, 0xE7, 0x9F, 0x56]};
@GUID(0xA0A839A9, 0x8DA1, 0x4A82, [0x80, 0x6A, 0x8E, 0x0D, 0x44, 0xE7, 0x9F, 0x56]);
interface IRawElementProviderSimple2 : IRawElementProviderSimple
{
    HRESULT ShowContextMenu();
}

const GUID IID_IRawElementProviderSimple3 = {0xFCF5D820, 0xD7EC, 0x4613, [0xBD, 0xF6, 0x42, 0xA8, 0x4C, 0xE7, 0xDA, 0xAF]};
@GUID(0xFCF5D820, 0xD7EC, 0x4613, [0xBD, 0xF6, 0x42, 0xA8, 0x4C, 0xE7, 0xDA, 0xAF]);
interface IRawElementProviderSimple3 : IRawElementProviderSimple2
{
    HRESULT GetMetadataValue(int targetId, int metadataId, VARIANT* returnVal);
}

const GUID IID_IRawElementProviderFragmentRoot = {0x620CE2A5, 0xAB8F, 0x40A9, [0x86, 0xCB, 0xDE, 0x3C, 0x75, 0x59, 0x9B, 0x58]};
@GUID(0x620CE2A5, 0xAB8F, 0x40A9, [0x86, 0xCB, 0xDE, 0x3C, 0x75, 0x59, 0x9B, 0x58]);
interface IRawElementProviderFragmentRoot : IUnknown
{
    HRESULT ElementProviderFromPoint(double x, double y, IRawElementProviderFragment* pRetVal);
    HRESULT GetFocus(IRawElementProviderFragment* pRetVal);
}

const GUID IID_IRawElementProviderFragment = {0xF7063DA8, 0x8359, 0x439C, [0x92, 0x97, 0xBB, 0xC5, 0x29, 0x9A, 0x7D, 0x87]};
@GUID(0xF7063DA8, 0x8359, 0x439C, [0x92, 0x97, 0xBB, 0xC5, 0x29, 0x9A, 0x7D, 0x87]);
interface IRawElementProviderFragment : IUnknown
{
    HRESULT Navigate(NavigateDirection direction, IRawElementProviderFragment* pRetVal);
    HRESULT GetRuntimeId(SAFEARRAY** pRetVal);
    HRESULT get_BoundingRectangle(UiaRect* pRetVal);
    HRESULT GetEmbeddedFragmentRoots(SAFEARRAY** pRetVal);
    HRESULT SetFocus();
    HRESULT get_FragmentRoot(IRawElementProviderFragmentRoot* pRetVal);
}

const GUID IID_IRawElementProviderAdviseEvents = {0xA407B27B, 0x0F6D, 0x4427, [0x92, 0x92, 0x47, 0x3C, 0x7B, 0xF9, 0x32, 0x58]};
@GUID(0xA407B27B, 0x0F6D, 0x4427, [0x92, 0x92, 0x47, 0x3C, 0x7B, 0xF9, 0x32, 0x58]);
interface IRawElementProviderAdviseEvents : IUnknown
{
    HRESULT AdviseEventAdded(int eventId, SAFEARRAY* propertyIDs);
    HRESULT AdviseEventRemoved(int eventId, SAFEARRAY* propertyIDs);
}

const GUID IID_IRawElementProviderHwndOverride = {0x1D5DF27C, 0x8947, 0x4425, [0xB8, 0xD9, 0x79, 0x78, 0x7B, 0xB4, 0x60, 0xB8]};
@GUID(0x1D5DF27C, 0x8947, 0x4425, [0xB8, 0xD9, 0x79, 0x78, 0x7B, 0xB4, 0x60, 0xB8]);
interface IRawElementProviderHwndOverride : IUnknown
{
    HRESULT GetOverrideProviderForHwnd(HWND hwnd, IRawElementProviderSimple* pRetVal);
}

const GUID IID_IProxyProviderWinEventSink = {0x4FD82B78, 0xA43E, 0x46AC, [0x98, 0x03, 0x0A, 0x69, 0x69, 0xC7, 0xC1, 0x83]};
@GUID(0x4FD82B78, 0xA43E, 0x46AC, [0x98, 0x03, 0x0A, 0x69, 0x69, 0xC7, 0xC1, 0x83]);
interface IProxyProviderWinEventSink : IUnknown
{
    HRESULT AddAutomationPropertyChangedEvent(IRawElementProviderSimple pProvider, int id, VARIANT newValue);
    HRESULT AddAutomationEvent(IRawElementProviderSimple pProvider, int id);
    HRESULT AddStructureChangedEvent(IRawElementProviderSimple pProvider, StructureChangeType structureChangeType, SAFEARRAY* runtimeId);
}

const GUID IID_IProxyProviderWinEventHandler = {0x89592AD4, 0xF4E0, 0x43D5, [0xA3, 0xB6, 0xBA, 0xD7, 0xE1, 0x11, 0xB4, 0x35]};
@GUID(0x89592AD4, 0xF4E0, 0x43D5, [0xA3, 0xB6, 0xBA, 0xD7, 0xE1, 0x11, 0xB4, 0x35]);
interface IProxyProviderWinEventHandler : IUnknown
{
    HRESULT RespondToWinEvent(uint idWinEvent, HWND hwnd, int idObject, int idChild, IProxyProviderWinEventSink pSink);
}

const GUID IID_IRawElementProviderWindowlessSite = {0x0A2A93CC, 0xBFAD, 0x42AC, [0x9B, 0x2E, 0x09, 0x91, 0xFB, 0x0D, 0x3E, 0xA0]};
@GUID(0x0A2A93CC, 0xBFAD, 0x42AC, [0x9B, 0x2E, 0x09, 0x91, 0xFB, 0x0D, 0x3E, 0xA0]);
interface IRawElementProviderWindowlessSite : IUnknown
{
    HRESULT GetAdjacentFragment(NavigateDirection direction, IRawElementProviderFragment* ppParent);
    HRESULT GetRuntimeIdPrefix(SAFEARRAY** pRetVal);
}

const GUID IID_IAccessibleHostingElementProviders = {0x33AC331B, 0x943E, 0x4020, [0xB2, 0x95, 0xDB, 0x37, 0x78, 0x49, 0x74, 0xA3]};
@GUID(0x33AC331B, 0x943E, 0x4020, [0xB2, 0x95, 0xDB, 0x37, 0x78, 0x49, 0x74, 0xA3]);
interface IAccessibleHostingElementProviders : IUnknown
{
    HRESULT GetEmbeddedFragmentRoots(SAFEARRAY** pRetVal);
    HRESULT GetObjectIdForProvider(IRawElementProviderSimple pProvider, int* pidObject);
}

const GUID IID_IRawElementProviderHostingAccessibles = {0x24BE0B07, 0xD37D, 0x487A, [0x98, 0xCF, 0xA1, 0x3E, 0xD4, 0x65, 0xE9, 0xB3]};
@GUID(0x24BE0B07, 0xD37D, 0x487A, [0x98, 0xCF, 0xA1, 0x3E, 0xD4, 0x65, 0xE9, 0xB3]);
interface IRawElementProviderHostingAccessibles : IUnknown
{
    HRESULT GetEmbeddedAccessibles(SAFEARRAY** pRetVal);
}

const GUID IID_IDockProvider = {0x159BC72C, 0x4AD3, 0x485E, [0x96, 0x37, 0xD7, 0x05, 0x2E, 0xDF, 0x01, 0x46]};
@GUID(0x159BC72C, 0x4AD3, 0x485E, [0x96, 0x37, 0xD7, 0x05, 0x2E, 0xDF, 0x01, 0x46]);
interface IDockProvider : IUnknown
{
    HRESULT SetDockPosition(DockPosition dockPosition);
    HRESULT get_DockPosition(DockPosition* pRetVal);
}

const GUID IID_IExpandCollapseProvider = {0xD847D3A5, 0xCAB0, 0x4A98, [0x8C, 0x32, 0xEC, 0xB4, 0x5C, 0x59, 0xAD, 0x24]};
@GUID(0xD847D3A5, 0xCAB0, 0x4A98, [0x8C, 0x32, 0xEC, 0xB4, 0x5C, 0x59, 0xAD, 0x24]);
interface IExpandCollapseProvider : IUnknown
{
    HRESULT Expand();
    HRESULT Collapse();
    HRESULT get_ExpandCollapseState(ExpandCollapseState* pRetVal);
}

const GUID IID_IGridProvider = {0xB17D6187, 0x0907, 0x464B, [0xA1, 0x68, 0x0E, 0xF1, 0x7A, 0x15, 0x72, 0xB1]};
@GUID(0xB17D6187, 0x0907, 0x464B, [0xA1, 0x68, 0x0E, 0xF1, 0x7A, 0x15, 0x72, 0xB1]);
interface IGridProvider : IUnknown
{
    HRESULT GetItem(int row, int column, IRawElementProviderSimple* pRetVal);
    HRESULT get_RowCount(int* pRetVal);
    HRESULT get_ColumnCount(int* pRetVal);
}

const GUID IID_IGridItemProvider = {0xD02541F1, 0xFB81, 0x4D64, [0xAE, 0x32, 0xF5, 0x20, 0xF8, 0xA6, 0xDB, 0xD1]};
@GUID(0xD02541F1, 0xFB81, 0x4D64, [0xAE, 0x32, 0xF5, 0x20, 0xF8, 0xA6, 0xDB, 0xD1]);
interface IGridItemProvider : IUnknown
{
    HRESULT get_Row(int* pRetVal);
    HRESULT get_Column(int* pRetVal);
    HRESULT get_RowSpan(int* pRetVal);
    HRESULT get_ColumnSpan(int* pRetVal);
    HRESULT get_ContainingGrid(IRawElementProviderSimple* pRetVal);
}

const GUID IID_IInvokeProvider = {0x54FCB24B, 0xE18E, 0x47A2, [0xB4, 0xD3, 0xEC, 0xCB, 0xE7, 0x75, 0x99, 0xA2]};
@GUID(0x54FCB24B, 0xE18E, 0x47A2, [0xB4, 0xD3, 0xEC, 0xCB, 0xE7, 0x75, 0x99, 0xA2]);
interface IInvokeProvider : IUnknown
{
    HRESULT Invoke();
}

const GUID IID_IMultipleViewProvider = {0x6278CAB1, 0xB556, 0x4A1A, [0xB4, 0xE0, 0x41, 0x8A, 0xCC, 0x52, 0x32, 0x01]};
@GUID(0x6278CAB1, 0xB556, 0x4A1A, [0xB4, 0xE0, 0x41, 0x8A, 0xCC, 0x52, 0x32, 0x01]);
interface IMultipleViewProvider : IUnknown
{
    HRESULT GetViewName(int viewId, BSTR* pRetVal);
    HRESULT SetCurrentView(int viewId);
    HRESULT get_CurrentView(int* pRetVal);
    HRESULT GetSupportedViews(SAFEARRAY** pRetVal);
}

const GUID IID_IRangeValueProvider = {0x36DC7AEF, 0x33E6, 0x4691, [0xAF, 0xE1, 0x2B, 0xE7, 0x27, 0x4B, 0x3D, 0x33]};
@GUID(0x36DC7AEF, 0x33E6, 0x4691, [0xAF, 0xE1, 0x2B, 0xE7, 0x27, 0x4B, 0x3D, 0x33]);
interface IRangeValueProvider : IUnknown
{
    HRESULT SetValue(double val);
    HRESULT get_Value(double* pRetVal);
    HRESULT get_IsReadOnly(int* pRetVal);
    HRESULT get_Maximum(double* pRetVal);
    HRESULT get_Minimum(double* pRetVal);
    HRESULT get_LargeChange(double* pRetVal);
    HRESULT get_SmallChange(double* pRetVal);
}

const GUID IID_IScrollItemProvider = {0x2360C714, 0x4BF1, 0x4B26, [0xBA, 0x65, 0x9B, 0x21, 0x31, 0x61, 0x27, 0xEB]};
@GUID(0x2360C714, 0x4BF1, 0x4B26, [0xBA, 0x65, 0x9B, 0x21, 0x31, 0x61, 0x27, 0xEB]);
interface IScrollItemProvider : IUnknown
{
    HRESULT ScrollIntoView();
}

const GUID IID_ISelectionProvider = {0xFB8B03AF, 0x3BDF, 0x48D4, [0xBD, 0x36, 0x1A, 0x65, 0x79, 0x3B, 0xE1, 0x68]};
@GUID(0xFB8B03AF, 0x3BDF, 0x48D4, [0xBD, 0x36, 0x1A, 0x65, 0x79, 0x3B, 0xE1, 0x68]);
interface ISelectionProvider : IUnknown
{
    HRESULT GetSelection(SAFEARRAY** pRetVal);
    HRESULT get_CanSelectMultiple(int* pRetVal);
    HRESULT get_IsSelectionRequired(int* pRetVal);
}

const GUID IID_ISelectionProvider2 = {0x14F68475, 0xEE1C, 0x44F6, [0xA8, 0x69, 0xD2, 0x39, 0x38, 0x1F, 0x0F, 0xE7]};
@GUID(0x14F68475, 0xEE1C, 0x44F6, [0xA8, 0x69, 0xD2, 0x39, 0x38, 0x1F, 0x0F, 0xE7]);
interface ISelectionProvider2 : ISelectionProvider
{
    HRESULT get_FirstSelectedItem(IRawElementProviderSimple* retVal);
    HRESULT get_LastSelectedItem(IRawElementProviderSimple* retVal);
    HRESULT get_CurrentSelectedItem(IRawElementProviderSimple* retVal);
    HRESULT get_ItemCount(int* retVal);
}

const GUID IID_IScrollProvider = {0xB38B8077, 0x1FC3, 0x42A5, [0x8C, 0xAE, 0xD4, 0x0C, 0x22, 0x15, 0x05, 0x5A]};
@GUID(0xB38B8077, 0x1FC3, 0x42A5, [0x8C, 0xAE, 0xD4, 0x0C, 0x22, 0x15, 0x05, 0x5A]);
interface IScrollProvider : IUnknown
{
    HRESULT Scroll(ScrollAmount horizontalAmount, ScrollAmount verticalAmount);
    HRESULT SetScrollPercent(double horizontalPercent, double verticalPercent);
    HRESULT get_HorizontalScrollPercent(double* pRetVal);
    HRESULT get_VerticalScrollPercent(double* pRetVal);
    HRESULT get_HorizontalViewSize(double* pRetVal);
    HRESULT get_VerticalViewSize(double* pRetVal);
    HRESULT get_HorizontallyScrollable(int* pRetVal);
    HRESULT get_VerticallyScrollable(int* pRetVal);
}

const GUID IID_ISelectionItemProvider = {0x2ACAD808, 0xB2D4, 0x452D, [0xA4, 0x07, 0x91, 0xFF, 0x1A, 0xD1, 0x67, 0xB2]};
@GUID(0x2ACAD808, 0xB2D4, 0x452D, [0xA4, 0x07, 0x91, 0xFF, 0x1A, 0xD1, 0x67, 0xB2]);
interface ISelectionItemProvider : IUnknown
{
    HRESULT Select();
    HRESULT AddToSelection();
    HRESULT RemoveFromSelection();
    HRESULT get_IsSelected(int* pRetVal);
    HRESULT get_SelectionContainer(IRawElementProviderSimple* pRetVal);
}

const GUID IID_ISynchronizedInputProvider = {0x29DB1A06, 0x02CE, 0x4CF7, [0x9B, 0x42, 0x56, 0x5D, 0x4F, 0xAB, 0x20, 0xEE]};
@GUID(0x29DB1A06, 0x02CE, 0x4CF7, [0x9B, 0x42, 0x56, 0x5D, 0x4F, 0xAB, 0x20, 0xEE]);
interface ISynchronizedInputProvider : IUnknown
{
    HRESULT StartListening(SynchronizedInputType inputType);
    HRESULT Cancel();
}

const GUID IID_ITableProvider = {0x9C860395, 0x97B3, 0x490A, [0xB5, 0x2A, 0x85, 0x8C, 0xC2, 0x2A, 0xF1, 0x66]};
@GUID(0x9C860395, 0x97B3, 0x490A, [0xB5, 0x2A, 0x85, 0x8C, 0xC2, 0x2A, 0xF1, 0x66]);
interface ITableProvider : IUnknown
{
    HRESULT GetRowHeaders(SAFEARRAY** pRetVal);
    HRESULT GetColumnHeaders(SAFEARRAY** pRetVal);
    HRESULT get_RowOrColumnMajor(RowOrColumnMajor* pRetVal);
}

const GUID IID_ITableItemProvider = {0xB9734FA6, 0x771F, 0x4D78, [0x9C, 0x90, 0x25, 0x17, 0x99, 0x93, 0x49, 0xCD]};
@GUID(0xB9734FA6, 0x771F, 0x4D78, [0x9C, 0x90, 0x25, 0x17, 0x99, 0x93, 0x49, 0xCD]);
interface ITableItemProvider : IUnknown
{
    HRESULT GetRowHeaderItems(SAFEARRAY** pRetVal);
    HRESULT GetColumnHeaderItems(SAFEARRAY** pRetVal);
}

const GUID IID_IToggleProvider = {0x56D00BD0, 0xC4F4, 0x433C, [0xA8, 0x36, 0x1A, 0x52, 0xA5, 0x7E, 0x08, 0x92]};
@GUID(0x56D00BD0, 0xC4F4, 0x433C, [0xA8, 0x36, 0x1A, 0x52, 0xA5, 0x7E, 0x08, 0x92]);
interface IToggleProvider : IUnknown
{
    HRESULT Toggle();
    HRESULT get_ToggleState(ToggleState* pRetVal);
}

const GUID IID_ITransformProvider = {0x6829DDC4, 0x4F91, 0x4FFA, [0xB8, 0x6F, 0xBD, 0x3E, 0x29, 0x87, 0xCB, 0x4C]};
@GUID(0x6829DDC4, 0x4F91, 0x4FFA, [0xB8, 0x6F, 0xBD, 0x3E, 0x29, 0x87, 0xCB, 0x4C]);
interface ITransformProvider : IUnknown
{
    HRESULT Move(double x, double y);
    HRESULT Resize(double width, double height);
    HRESULT Rotate(double degrees);
    HRESULT get_CanMove(int* pRetVal);
    HRESULT get_CanResize(int* pRetVal);
    HRESULT get_CanRotate(int* pRetVal);
}

const GUID IID_IValueProvider = {0xC7935180, 0x6FB3, 0x4201, [0xB1, 0x74, 0x7D, 0xF7, 0x3A, 0xDB, 0xF6, 0x4A]};
@GUID(0xC7935180, 0x6FB3, 0x4201, [0xB1, 0x74, 0x7D, 0xF7, 0x3A, 0xDB, 0xF6, 0x4A]);
interface IValueProvider : IUnknown
{
    HRESULT SetValue(const(wchar)* val);
    HRESULT get_Value(BSTR* pRetVal);
    HRESULT get_IsReadOnly(int* pRetVal);
}

const GUID IID_IWindowProvider = {0x987DF77B, 0xDB06, 0x4D77, [0x8F, 0x8A, 0x86, 0xA9, 0xC3, 0xBB, 0x90, 0xB9]};
@GUID(0x987DF77B, 0xDB06, 0x4D77, [0x8F, 0x8A, 0x86, 0xA9, 0xC3, 0xBB, 0x90, 0xB9]);
interface IWindowProvider : IUnknown
{
    HRESULT SetVisualState(WindowVisualState state);
    HRESULT Close();
    HRESULT WaitForInputIdle(int milliseconds, int* pRetVal);
    HRESULT get_CanMaximize(int* pRetVal);
    HRESULT get_CanMinimize(int* pRetVal);
    HRESULT get_IsModal(int* pRetVal);
    HRESULT get_WindowVisualState(WindowVisualState* pRetVal);
    HRESULT get_WindowInteractionState(WindowInteractionState* pRetVal);
    HRESULT get_IsTopmost(int* pRetVal);
}

const GUID IID_ILegacyIAccessibleProvider = {0xE44C3566, 0x915D, 0x4070, [0x99, 0xC6, 0x04, 0x7B, 0xFF, 0x5A, 0x08, 0xF5]};
@GUID(0xE44C3566, 0x915D, 0x4070, [0x99, 0xC6, 0x04, 0x7B, 0xFF, 0x5A, 0x08, 0xF5]);
interface ILegacyIAccessibleProvider : IUnknown
{
    HRESULT Select(int flagsSelect);
    HRESULT DoDefaultAction();
    HRESULT SetValue(const(wchar)* szValue);
    HRESULT GetIAccessible(IAccessible* ppAccessible);
    HRESULT get_ChildId(int* pRetVal);
    HRESULT get_Name(BSTR* pszName);
    HRESULT get_Value(BSTR* pszValue);
    HRESULT get_Description(BSTR* pszDescription);
    HRESULT get_Role(uint* pdwRole);
    HRESULT get_State(uint* pdwState);
    HRESULT get_Help(BSTR* pszHelp);
    HRESULT get_KeyboardShortcut(BSTR* pszKeyboardShortcut);
    HRESULT GetSelection(SAFEARRAY** pvarSelectedChildren);
    HRESULT get_DefaultAction(BSTR* pszDefaultAction);
}

const GUID IID_IItemContainerProvider = {0xE747770B, 0x39CE, 0x4382, [0xAB, 0x30, 0xD8, 0xFB, 0x3F, 0x33, 0x6F, 0x24]};
@GUID(0xE747770B, 0x39CE, 0x4382, [0xAB, 0x30, 0xD8, 0xFB, 0x3F, 0x33, 0x6F, 0x24]);
interface IItemContainerProvider : IUnknown
{
    HRESULT FindItemByProperty(IRawElementProviderSimple pStartAfter, int propertyId, VARIANT value, IRawElementProviderSimple* pFound);
}

const GUID IID_IVirtualizedItemProvider = {0xCB98B665, 0x2D35, 0x4FAC, [0xAD, 0x35, 0xF3, 0xC6, 0x0D, 0x0C, 0x0B, 0x8B]};
@GUID(0xCB98B665, 0x2D35, 0x4FAC, [0xAD, 0x35, 0xF3, 0xC6, 0x0D, 0x0C, 0x0B, 0x8B]);
interface IVirtualizedItemProvider : IUnknown
{
    HRESULT Realize();
}

const GUID IID_IObjectModelProvider = {0x3AD86EBD, 0xF5EF, 0x483D, [0xBB, 0x18, 0xB1, 0x04, 0x2A, 0x47, 0x5D, 0x64]};
@GUID(0x3AD86EBD, 0xF5EF, 0x483D, [0xBB, 0x18, 0xB1, 0x04, 0x2A, 0x47, 0x5D, 0x64]);
interface IObjectModelProvider : IUnknown
{
    HRESULT GetUnderlyingObjectModel(IUnknown* ppUnknown);
}

const GUID IID_IAnnotationProvider = {0xF95C7E80, 0xBD63, 0x4601, [0x97, 0x82, 0x44, 0x5E, 0xBF, 0xF0, 0x11, 0xFC]};
@GUID(0xF95C7E80, 0xBD63, 0x4601, [0x97, 0x82, 0x44, 0x5E, 0xBF, 0xF0, 0x11, 0xFC]);
interface IAnnotationProvider : IUnknown
{
    HRESULT get_AnnotationTypeId(int* retVal);
    HRESULT get_AnnotationTypeName(BSTR* retVal);
    HRESULT get_Author(BSTR* retVal);
    HRESULT get_DateTime(BSTR* retVal);
    HRESULT get_Target(IRawElementProviderSimple* retVal);
}

const GUID IID_IStylesProvider = {0x19B6B649, 0xF5D7, 0x4A6D, [0xBD, 0xCB, 0x12, 0x92, 0x52, 0xBE, 0x58, 0x8A]};
@GUID(0x19B6B649, 0xF5D7, 0x4A6D, [0xBD, 0xCB, 0x12, 0x92, 0x52, 0xBE, 0x58, 0x8A]);
interface IStylesProvider : IUnknown
{
    HRESULT get_StyleId(int* retVal);
    HRESULT get_StyleName(BSTR* retVal);
    HRESULT get_FillColor(int* retVal);
    HRESULT get_FillPatternStyle(BSTR* retVal);
    HRESULT get_Shape(BSTR* retVal);
    HRESULT get_FillPatternColor(int* retVal);
    HRESULT get_ExtendedProperties(BSTR* retVal);
}

const GUID IID_ISpreadsheetProvider = {0x6F6B5D35, 0x5525, 0x4F80, [0xB7, 0x58, 0x85, 0x47, 0x38, 0x32, 0xFF, 0xC7]};
@GUID(0x6F6B5D35, 0x5525, 0x4F80, [0xB7, 0x58, 0x85, 0x47, 0x38, 0x32, 0xFF, 0xC7]);
interface ISpreadsheetProvider : IUnknown
{
    HRESULT GetItemByName(const(wchar)* name, IRawElementProviderSimple* pRetVal);
}

const GUID IID_ISpreadsheetItemProvider = {0xEAED4660, 0x7B3D, 0x4879, [0xA2, 0xE6, 0x36, 0x5C, 0xE6, 0x03, 0xF3, 0xD0]};
@GUID(0xEAED4660, 0x7B3D, 0x4879, [0xA2, 0xE6, 0x36, 0x5C, 0xE6, 0x03, 0xF3, 0xD0]);
interface ISpreadsheetItemProvider : IUnknown
{
    HRESULT get_Formula(BSTR* pRetVal);
    HRESULT GetAnnotationObjects(SAFEARRAY** pRetVal);
    HRESULT GetAnnotationTypes(SAFEARRAY** pRetVal);
}

const GUID IID_ITransformProvider2 = {0x4758742F, 0x7AC2, 0x460C, [0xBC, 0x48, 0x09, 0xFC, 0x09, 0x30, 0x8A, 0x93]};
@GUID(0x4758742F, 0x7AC2, 0x460C, [0xBC, 0x48, 0x09, 0xFC, 0x09, 0x30, 0x8A, 0x93]);
interface ITransformProvider2 : ITransformProvider
{
    HRESULT Zoom(double zoom);
    HRESULT get_CanZoom(int* pRetVal);
    HRESULT get_ZoomLevel(double* pRetVal);
    HRESULT get_ZoomMinimum(double* pRetVal);
    HRESULT get_ZoomMaximum(double* pRetVal);
    HRESULT ZoomByUnit(ZoomUnit zoomUnit);
}

const GUID IID_IDragProvider = {0x6AA7BBBB, 0x7FF9, 0x497D, [0x90, 0x4F, 0xD2, 0x0B, 0x89, 0x79, 0x29, 0xD8]};
@GUID(0x6AA7BBBB, 0x7FF9, 0x497D, [0x90, 0x4F, 0xD2, 0x0B, 0x89, 0x79, 0x29, 0xD8]);
interface IDragProvider : IUnknown
{
    HRESULT get_IsGrabbed(int* pRetVal);
    HRESULT get_DropEffect(BSTR* pRetVal);
    HRESULT get_DropEffects(SAFEARRAY** pRetVal);
    HRESULT GetGrabbedItems(SAFEARRAY** pRetVal);
}

const GUID IID_IDropTargetProvider = {0xBAE82BFD, 0x358A, 0x481C, [0x85, 0xA0, 0xD8, 0xB4, 0xD9, 0x0A, 0x5D, 0x61]};
@GUID(0xBAE82BFD, 0x358A, 0x481C, [0x85, 0xA0, 0xD8, 0xB4, 0xD9, 0x0A, 0x5D, 0x61]);
interface IDropTargetProvider : IUnknown
{
    HRESULT get_DropTargetEffect(BSTR* pRetVal);
    HRESULT get_DropTargetEffects(SAFEARRAY** pRetVal);
}

const GUID IID_ITextRangeProvider = {0x5347AD7B, 0xC355, 0x46F8, [0xAF, 0xF5, 0x90, 0x90, 0x33, 0x58, 0x2F, 0x63]};
@GUID(0x5347AD7B, 0xC355, 0x46F8, [0xAF, 0xF5, 0x90, 0x90, 0x33, 0x58, 0x2F, 0x63]);
interface ITextRangeProvider : IUnknown
{
    HRESULT Clone(ITextRangeProvider* pRetVal);
    HRESULT Compare(ITextRangeProvider range, int* pRetVal);
    HRESULT CompareEndpoints(TextPatternRangeEndpoint endpoint, ITextRangeProvider targetRange, TextPatternRangeEndpoint targetEndpoint, int* pRetVal);
    HRESULT ExpandToEnclosingUnit(TextUnit unit);
    HRESULT FindAttribute(int attributeId, VARIANT val, BOOL backward, ITextRangeProvider* pRetVal);
    HRESULT FindTextA(BSTR text, BOOL backward, BOOL ignoreCase, ITextRangeProvider* pRetVal);
    HRESULT GetAttributeValue(int attributeId, VARIANT* pRetVal);
    HRESULT GetBoundingRectangles(SAFEARRAY** pRetVal);
    HRESULT GetEnclosingElement(IRawElementProviderSimple* pRetVal);
    HRESULT GetText(int maxLength, BSTR* pRetVal);
    HRESULT Move(TextUnit unit, int count, int* pRetVal);
    HRESULT MoveEndpointByUnit(TextPatternRangeEndpoint endpoint, TextUnit unit, int count, int* pRetVal);
    HRESULT MoveEndpointByRange(TextPatternRangeEndpoint endpoint, ITextRangeProvider targetRange, TextPatternRangeEndpoint targetEndpoint);
    HRESULT Select();
    HRESULT AddToSelection();
    HRESULT RemoveFromSelection();
    HRESULT ScrollIntoView(BOOL alignToTop);
    HRESULT GetChildren(SAFEARRAY** pRetVal);
}

const GUID IID_ITextProvider = {0x3589C92C, 0x63F3, 0x4367, [0x99, 0xBB, 0xAD, 0xA6, 0x53, 0xB7, 0x7C, 0xF2]};
@GUID(0x3589C92C, 0x63F3, 0x4367, [0x99, 0xBB, 0xAD, 0xA6, 0x53, 0xB7, 0x7C, 0xF2]);
interface ITextProvider : IUnknown
{
    HRESULT GetSelection(SAFEARRAY** pRetVal);
    HRESULT GetVisibleRanges(SAFEARRAY** pRetVal);
    HRESULT RangeFromChild(IRawElementProviderSimple childElement, ITextRangeProvider* pRetVal);
    HRESULT RangeFromPoint(UiaPoint point, ITextRangeProvider* pRetVal);
    HRESULT get_DocumentRange(ITextRangeProvider* pRetVal);
    HRESULT get_SupportedTextSelection(SupportedTextSelection* pRetVal);
}

const GUID IID_ITextProvider2 = {0x0DC5E6ED, 0x3E16, 0x4BF1, [0x8F, 0x9A, 0xA9, 0x79, 0x87, 0x8B, 0xC1, 0x95]};
@GUID(0x0DC5E6ED, 0x3E16, 0x4BF1, [0x8F, 0x9A, 0xA9, 0x79, 0x87, 0x8B, 0xC1, 0x95]);
interface ITextProvider2 : ITextProvider
{
    HRESULT RangeFromAnnotation(IRawElementProviderSimple annotationElement, ITextRangeProvider* pRetVal);
    HRESULT GetCaretRange(int* isActive, ITextRangeProvider* pRetVal);
}

const GUID IID_ITextEditProvider = {0xEA3605B4, 0x3A05, 0x400E, [0xB5, 0xF9, 0x4E, 0x91, 0xB4, 0x0F, 0x61, 0x76]};
@GUID(0xEA3605B4, 0x3A05, 0x400E, [0xB5, 0xF9, 0x4E, 0x91, 0xB4, 0x0F, 0x61, 0x76]);
interface ITextEditProvider : ITextProvider
{
    HRESULT GetActiveComposition(ITextRangeProvider* pRetVal);
    HRESULT GetConversionTarget(ITextRangeProvider* pRetVal);
}

const GUID IID_ITextRangeProvider2 = {0x9BBCE42C, 0x1921, 0x4F18, [0x89, 0xCA, 0xDB, 0xA1, 0x91, 0x0A, 0x03, 0x86]};
@GUID(0x9BBCE42C, 0x1921, 0x4F18, [0x89, 0xCA, 0xDB, 0xA1, 0x91, 0x0A, 0x03, 0x86]);
interface ITextRangeProvider2 : ITextRangeProvider
{
    HRESULT ShowContextMenu();
}

const GUID IID_ITextChildProvider = {0x4C2DE2B9, 0xC88F, 0x4F88, [0xA1, 0x11, 0xF1, 0xD3, 0x36, 0xB7, 0xD1, 0xA9]};
@GUID(0x4C2DE2B9, 0xC88F, 0x4F88, [0xA1, 0x11, 0xF1, 0xD3, 0x36, 0xB7, 0xD1, 0xA9]);
interface ITextChildProvider : IUnknown
{
    HRESULT get_TextContainer(IRawElementProviderSimple* pRetVal);
    HRESULT get_TextRange(ITextRangeProvider* pRetVal);
}

const GUID IID_ICustomNavigationProvider = {0x2062A28A, 0x8C07, 0x4B94, [0x8E, 0x12, 0x70, 0x37, 0xC6, 0x22, 0xAE, 0xB8]};
@GUID(0x2062A28A, 0x8C07, 0x4B94, [0x8E, 0x12, 0x70, 0x37, 0xC6, 0x22, 0xAE, 0xB8]);
interface ICustomNavigationProvider : IUnknown
{
    HRESULT Navigate(NavigateDirection direction, IRawElementProviderSimple* pRetVal);
}

const GUID IID_IUIAutomationPatternInstance = {0xC03A7FE4, 0x9431, 0x409F, [0xBE, 0xD8, 0xAE, 0x7C, 0x22, 0x99, 0xBC, 0x8D]};
@GUID(0xC03A7FE4, 0x9431, 0x409F, [0xBE, 0xD8, 0xAE, 0x7C, 0x22, 0x99, 0xBC, 0x8D]);
interface IUIAutomationPatternInstance : IUnknown
{
    HRESULT GetProperty(uint index, BOOL cached, UIAutomationType type, void* pPtr);
    HRESULT CallMethod(uint index, const(UIAutomationParameter)* pParams, uint cParams);
}

const GUID IID_IUIAutomationPatternHandler = {0xD97022F3, 0xA947, 0x465E, [0x8B, 0x2A, 0xAC, 0x43, 0x15, 0xFA, 0x54, 0xE8]};
@GUID(0xD97022F3, 0xA947, 0x465E, [0x8B, 0x2A, 0xAC, 0x43, 0x15, 0xFA, 0x54, 0xE8]);
interface IUIAutomationPatternHandler : IUnknown
{
    HRESULT CreateClientWrapper(IUIAutomationPatternInstance pPatternInstance, IUnknown* pClientWrapper);
    HRESULT Dispatch(IUnknown pTarget, uint index, const(UIAutomationParameter)* pParams, uint cParams);
}

const GUID IID_IUIAutomationRegistrar = {0x8609C4EC, 0x4A1A, 0x4D88, [0xA3, 0x57, 0x5A, 0x66, 0xE0, 0x60, 0xE1, 0xCF]};
@GUID(0x8609C4EC, 0x4A1A, 0x4D88, [0xA3, 0x57, 0x5A, 0x66, 0xE0, 0x60, 0xE1, 0xCF]);
interface IUIAutomationRegistrar : IUnknown
{
    HRESULT RegisterProperty(const(UIAutomationPropertyInfo)* property, int* propertyId);
    HRESULT RegisterEvent(const(UIAutomationEventInfo)* event, int* eventId);
    HRESULT RegisterPattern(const(UIAutomationPatternInfo)* pattern, int* pPatternId, int* pPatternAvailablePropertyId, uint propertyIdCount, char* pPropertyIds, uint eventIdCount, char* pEventIds);
}

struct HUIANODE__
{
    int unused;
}

struct HUIAPATTERNOBJECT__
{
    int unused;
}

struct HUIATEXTRANGE__
{
    int unused;
}

struct HUIAEVENT__
{
    int unused;
}

enum TreeScope
{
    TreeScope_None = 0,
    TreeScope_Element = 1,
    TreeScope_Children = 2,
    TreeScope_Descendants = 4,
    TreeScope_Parent = 8,
    TreeScope_Ancestors = 16,
    TreeScope_Subtree = 7,
}

enum ConditionType
{
    ConditionType_True = 0,
    ConditionType_False = 1,
    ConditionType_Property = 2,
    ConditionType_And = 3,
    ConditionType_Or = 4,
    ConditionType_Not = 5,
}

struct UiaCondition
{
    ConditionType ConditionType;
}

enum PropertyConditionFlags
{
    PropertyConditionFlags_None = 0,
    PropertyConditionFlags_IgnoreCase = 1,
    PropertyConditionFlags_MatchSubstring = 2,
}

struct UiaPropertyCondition
{
    ConditionType ConditionType;
    int PropertyId;
    VARIANT Value;
    PropertyConditionFlags Flags;
}

struct UiaAndOrCondition
{
    ConditionType ConditionType;
    UiaCondition** ppConditions;
    int cConditions;
}

struct UiaNotCondition
{
    ConditionType ConditionType;
    UiaCondition* pCondition;
}

enum AutomationElementMode
{
    AutomationElementMode_None = 0,
    AutomationElementMode_Full = 1,
}

struct UiaCacheRequest
{
    UiaCondition* pViewCondition;
    TreeScope Scope;
    int* pProperties;
    int cProperties;
    int* pPatterns;
    int cPatterns;
    AutomationElementMode automationElementMode;
}

enum NormalizeState
{
    NormalizeState_None = 0,
    NormalizeState_View = 1,
    NormalizeState_Custom = 2,
}

enum TreeTraversalOptions
{
    TreeTraversalOptions_Default = 0,
    TreeTraversalOptions_PostOrder = 1,
    TreeTraversalOptions_LastToFirstOrder = 2,
}

struct UiaFindParams
{
    int MaxDepth;
    BOOL FindFirst;
    BOOL ExcludeRoot;
    UiaCondition* pFindCondition;
}

enum ProviderType
{
    ProviderType_BaseHwnd = 0,
    ProviderType_Proxy = 1,
    ProviderType_NonClientArea = 2,
}

alias UiaProviderCallback = extern(Windows) SAFEARRAY* function(HWND hwnd, ProviderType providerType);
enum AutomationIdentifierType
{
    AutomationIdentifierType_Property = 0,
    AutomationIdentifierType_Pattern = 1,
    AutomationIdentifierType_Event = 2,
    AutomationIdentifierType_ControlType = 3,
    AutomationIdentifierType_TextAttribute = 4,
    AutomationIdentifierType_LandmarkType = 5,
    AutomationIdentifierType_Annotation = 6,
    AutomationIdentifierType_Changes = 7,
    AutomationIdentifierType_Style = 8,
}

enum EventArgsType
{
    EventArgsType_Simple = 0,
    EventArgsType_PropertyChanged = 1,
    EventArgsType_StructureChanged = 2,
    EventArgsType_AsyncContentLoaded = 3,
    EventArgsType_WindowClosed = 4,
    EventArgsType_TextEditTextChanged = 5,
    EventArgsType_Changes = 6,
    EventArgsType_Notification = 7,
    EventArgsType_ActiveTextPositionChanged = 8,
    EventArgsType_StructuredMarkup = 9,
}

enum AsyncContentLoadedState
{
    AsyncContentLoadedState_Beginning = 0,
    AsyncContentLoadedState_Progress = 1,
    AsyncContentLoadedState_Completed = 2,
}

struct UiaEventArgs
{
    EventArgsType Type;
    int EventId;
}

struct UiaPropertyChangedEventArgs
{
    EventArgsType Type;
    int EventId;
    int PropertyId;
    VARIANT OldValue;
    VARIANT NewValue;
}

struct UiaStructureChangedEventArgs
{
    EventArgsType Type;
    int EventId;
    StructureChangeType StructureChangeType;
    int* pRuntimeId;
    int cRuntimeIdLen;
}

struct UiaTextEditTextChangedEventArgs
{
    EventArgsType Type;
    int EventId;
    TextEditChangeType TextEditChangeType;
    SAFEARRAY* pTextChange;
}

struct UiaChangesEventArgs
{
    EventArgsType Type;
    int EventId;
    int EventIdCount;
    UiaChangeInfo* pUiaChanges;
}

struct UiaAsyncContentLoadedEventArgs
{
    EventArgsType Type;
    int EventId;
    AsyncContentLoadedState AsyncContentLoadedState;
    double PercentComplete;
}

struct UiaWindowClosedEventArgs
{
    EventArgsType Type;
    int EventId;
    int* pRuntimeId;
    int cRuntimeIdLen;
}

alias UiaEventCallback = extern(Windows) void function(UiaEventArgs* pArgs, SAFEARRAY* pRequestedData, BSTR pTreeStructure);
const GUID CLSID_CUIAutomation = {0xFF48DBA4, 0x60EF, 0x4201, [0xAA, 0x87, 0x54, 0x10, 0x3E, 0xEF, 0x59, 0x4E]};
@GUID(0xFF48DBA4, 0x60EF, 0x4201, [0xAA, 0x87, 0x54, 0x10, 0x3E, 0xEF, 0x59, 0x4E]);
struct CUIAutomation;

const GUID CLSID_CUIAutomation8 = {0xE22AD333, 0xB25F, 0x460C, [0x83, 0xD0, 0x05, 0x81, 0x10, 0x73, 0x95, 0xC9]};
@GUID(0xE22AD333, 0xB25F, 0x460C, [0x83, 0xD0, 0x05, 0x81, 0x10, 0x73, 0x95, 0xC9]);
struct CUIAutomation8;

struct ExtendedProperty
{
    BSTR PropertyName;
    BSTR PropertyValue;
}

const GUID IID_IUIAutomationElement = {0xD22108AA, 0x8AC5, 0x49A5, [0x83, 0x7B, 0x37, 0xBB, 0xB3, 0xD7, 0x59, 0x1E]};
@GUID(0xD22108AA, 0x8AC5, 0x49A5, [0x83, 0x7B, 0x37, 0xBB, 0xB3, 0xD7, 0x59, 0x1E]);
interface IUIAutomationElement : IUnknown
{
    HRESULT SetFocus();
    HRESULT GetRuntimeId(SAFEARRAY** runtimeId);
    HRESULT FindFirst(TreeScope scope, IUIAutomationCondition condition, IUIAutomationElement* found);
    HRESULT FindAll(TreeScope scope, IUIAutomationCondition condition, IUIAutomationElementArray* found);
    HRESULT FindFirstBuildCache(TreeScope scope, IUIAutomationCondition condition, IUIAutomationCacheRequest cacheRequest, IUIAutomationElement* found);
    HRESULT FindAllBuildCache(TreeScope scope, IUIAutomationCondition condition, IUIAutomationCacheRequest cacheRequest, IUIAutomationElementArray* found);
    HRESULT BuildUpdatedCache(IUIAutomationCacheRequest cacheRequest, IUIAutomationElement* updatedElement);
    HRESULT GetCurrentPropertyValue(int propertyId, VARIANT* retVal);
    HRESULT GetCurrentPropertyValueEx(int propertyId, BOOL ignoreDefaultValue, VARIANT* retVal);
    HRESULT GetCachedPropertyValue(int propertyId, VARIANT* retVal);
    HRESULT GetCachedPropertyValueEx(int propertyId, BOOL ignoreDefaultValue, VARIANT* retVal);
    HRESULT GetCurrentPatternAs(int patternId, const(Guid)* riid, void** patternObject);
    HRESULT GetCachedPatternAs(int patternId, const(Guid)* riid, void** patternObject);
    HRESULT GetCurrentPattern(int patternId, IUnknown* patternObject);
    HRESULT GetCachedPattern(int patternId, IUnknown* patternObject);
    HRESULT GetCachedParent(IUIAutomationElement* parent);
    HRESULT GetCachedChildren(IUIAutomationElementArray* children);
    HRESULT get_CurrentProcessId(int* retVal);
    HRESULT get_CurrentControlType(int* retVal);
    HRESULT get_CurrentLocalizedControlType(BSTR* retVal);
    HRESULT get_CurrentName(BSTR* retVal);
    HRESULT get_CurrentAcceleratorKey(BSTR* retVal);
    HRESULT get_CurrentAccessKey(BSTR* retVal);
    HRESULT get_CurrentHasKeyboardFocus(int* retVal);
    HRESULT get_CurrentIsKeyboardFocusable(int* retVal);
    HRESULT get_CurrentIsEnabled(int* retVal);
    HRESULT get_CurrentAutomationId(BSTR* retVal);
    HRESULT get_CurrentClassName(BSTR* retVal);
    HRESULT get_CurrentHelpText(BSTR* retVal);
    HRESULT get_CurrentCulture(int* retVal);
    HRESULT get_CurrentIsControlElement(int* retVal);
    HRESULT get_CurrentIsContentElement(int* retVal);
    HRESULT get_CurrentIsPassword(int* retVal);
    HRESULT get_CurrentNativeWindowHandle(void** retVal);
    HRESULT get_CurrentItemType(BSTR* retVal);
    HRESULT get_CurrentIsOffscreen(int* retVal);
    HRESULT get_CurrentOrientation(OrientationType* retVal);
    HRESULT get_CurrentFrameworkId(BSTR* retVal);
    HRESULT get_CurrentIsRequiredForForm(int* retVal);
    HRESULT get_CurrentItemStatus(BSTR* retVal);
    HRESULT get_CurrentBoundingRectangle(RECT* retVal);
    HRESULT get_CurrentLabeledBy(IUIAutomationElement* retVal);
    HRESULT get_CurrentAriaRole(BSTR* retVal);
    HRESULT get_CurrentAriaProperties(BSTR* retVal);
    HRESULT get_CurrentIsDataValidForForm(int* retVal);
    HRESULT get_CurrentControllerFor(IUIAutomationElementArray* retVal);
    HRESULT get_CurrentDescribedBy(IUIAutomationElementArray* retVal);
    HRESULT get_CurrentFlowsTo(IUIAutomationElementArray* retVal);
    HRESULT get_CurrentProviderDescription(BSTR* retVal);
    HRESULT get_CachedProcessId(int* retVal);
    HRESULT get_CachedControlType(int* retVal);
    HRESULT get_CachedLocalizedControlType(BSTR* retVal);
    HRESULT get_CachedName(BSTR* retVal);
    HRESULT get_CachedAcceleratorKey(BSTR* retVal);
    HRESULT get_CachedAccessKey(BSTR* retVal);
    HRESULT get_CachedHasKeyboardFocus(int* retVal);
    HRESULT get_CachedIsKeyboardFocusable(int* retVal);
    HRESULT get_CachedIsEnabled(int* retVal);
    HRESULT get_CachedAutomationId(BSTR* retVal);
    HRESULT get_CachedClassName(BSTR* retVal);
    HRESULT get_CachedHelpText(BSTR* retVal);
    HRESULT get_CachedCulture(int* retVal);
    HRESULT get_CachedIsControlElement(int* retVal);
    HRESULT get_CachedIsContentElement(int* retVal);
    HRESULT get_CachedIsPassword(int* retVal);
    HRESULT get_CachedNativeWindowHandle(void** retVal);
    HRESULT get_CachedItemType(BSTR* retVal);
    HRESULT get_CachedIsOffscreen(int* retVal);
    HRESULT get_CachedOrientation(OrientationType* retVal);
    HRESULT get_CachedFrameworkId(BSTR* retVal);
    HRESULT get_CachedIsRequiredForForm(int* retVal);
    HRESULT get_CachedItemStatus(BSTR* retVal);
    HRESULT get_CachedBoundingRectangle(RECT* retVal);
    HRESULT get_CachedLabeledBy(IUIAutomationElement* retVal);
    HRESULT get_CachedAriaRole(BSTR* retVal);
    HRESULT get_CachedAriaProperties(BSTR* retVal);
    HRESULT get_CachedIsDataValidForForm(int* retVal);
    HRESULT get_CachedControllerFor(IUIAutomationElementArray* retVal);
    HRESULT get_CachedDescribedBy(IUIAutomationElementArray* retVal);
    HRESULT get_CachedFlowsTo(IUIAutomationElementArray* retVal);
    HRESULT get_CachedProviderDescription(BSTR* retVal);
    HRESULT GetClickablePoint(POINT* clickable, int* gotClickable);
}

const GUID IID_IUIAutomationElementArray = {0x14314595, 0xB4BC, 0x4055, [0x95, 0xF2, 0x58, 0xF2, 0xE4, 0x2C, 0x98, 0x55]};
@GUID(0x14314595, 0xB4BC, 0x4055, [0x95, 0xF2, 0x58, 0xF2, 0xE4, 0x2C, 0x98, 0x55]);
interface IUIAutomationElementArray : IUnknown
{
    HRESULT get_Length(int* length);
    HRESULT GetElement(int index, IUIAutomationElement* element);
}

const GUID IID_IUIAutomationCondition = {0x352FFBA8, 0x0973, 0x437C, [0xA6, 0x1F, 0xF6, 0x4C, 0xAF, 0xD8, 0x1D, 0xF9]};
@GUID(0x352FFBA8, 0x0973, 0x437C, [0xA6, 0x1F, 0xF6, 0x4C, 0xAF, 0xD8, 0x1D, 0xF9]);
interface IUIAutomationCondition : IUnknown
{
}

const GUID IID_IUIAutomationBoolCondition = {0x1B4E1F2E, 0x75EB, 0x4D0B, [0x89, 0x52, 0x5A, 0x69, 0x98, 0x8E, 0x23, 0x07]};
@GUID(0x1B4E1F2E, 0x75EB, 0x4D0B, [0x89, 0x52, 0x5A, 0x69, 0x98, 0x8E, 0x23, 0x07]);
interface IUIAutomationBoolCondition : IUIAutomationCondition
{
    HRESULT get_BooleanValue(int* boolVal);
}

const GUID IID_IUIAutomationPropertyCondition = {0x99EBF2CB, 0x5578, 0x4267, [0x9A, 0xD4, 0xAF, 0xD6, 0xEA, 0x77, 0xE9, 0x4B]};
@GUID(0x99EBF2CB, 0x5578, 0x4267, [0x9A, 0xD4, 0xAF, 0xD6, 0xEA, 0x77, 0xE9, 0x4B]);
interface IUIAutomationPropertyCondition : IUIAutomationCondition
{
    HRESULT get_PropertyId(int* propertyId);
    HRESULT get_PropertyValue(VARIANT* propertyValue);
    HRESULT get_PropertyConditionFlags(PropertyConditionFlags* flags);
}

const GUID IID_IUIAutomationAndCondition = {0xA7D0AF36, 0xB912, 0x45FE, [0x98, 0x55, 0x09, 0x1D, 0xDC, 0x17, 0x4A, 0xEC]};
@GUID(0xA7D0AF36, 0xB912, 0x45FE, [0x98, 0x55, 0x09, 0x1D, 0xDC, 0x17, 0x4A, 0xEC]);
interface IUIAutomationAndCondition : IUIAutomationCondition
{
    HRESULT get_ChildCount(int* childCount);
    HRESULT GetChildrenAsNativeArray(char* childArray, int* childArrayCount);
    HRESULT GetChildren(SAFEARRAY** childArray);
}

const GUID IID_IUIAutomationOrCondition = {0x8753F032, 0x3DB1, 0x47B5, [0xA1, 0xFC, 0x6E, 0x34, 0xA2, 0x66, 0xC7, 0x12]};
@GUID(0x8753F032, 0x3DB1, 0x47B5, [0xA1, 0xFC, 0x6E, 0x34, 0xA2, 0x66, 0xC7, 0x12]);
interface IUIAutomationOrCondition : IUIAutomationCondition
{
    HRESULT get_ChildCount(int* childCount);
    HRESULT GetChildrenAsNativeArray(char* childArray, int* childArrayCount);
    HRESULT GetChildren(SAFEARRAY** childArray);
}

const GUID IID_IUIAutomationNotCondition = {0xF528B657, 0x847B, 0x498C, [0x88, 0x96, 0xD5, 0x2B, 0x56, 0x54, 0x07, 0xA1]};
@GUID(0xF528B657, 0x847B, 0x498C, [0x88, 0x96, 0xD5, 0x2B, 0x56, 0x54, 0x07, 0xA1]);
interface IUIAutomationNotCondition : IUIAutomationCondition
{
    HRESULT GetChild(IUIAutomationCondition* condition);
}

const GUID IID_IUIAutomationCacheRequest = {0xB32A92B5, 0xBC25, 0x4078, [0x9C, 0x08, 0xD7, 0xEE, 0x95, 0xC4, 0x8E, 0x03]};
@GUID(0xB32A92B5, 0xBC25, 0x4078, [0x9C, 0x08, 0xD7, 0xEE, 0x95, 0xC4, 0x8E, 0x03]);
interface IUIAutomationCacheRequest : IUnknown
{
    HRESULT AddProperty(int propertyId);
    HRESULT AddPattern(int patternId);
    HRESULT Clone(IUIAutomationCacheRequest* clonedRequest);
    HRESULT get_TreeScope(TreeScope* scope);
    HRESULT put_TreeScope(TreeScope scope);
    HRESULT get_TreeFilter(IUIAutomationCondition* filter);
    HRESULT put_TreeFilter(IUIAutomationCondition filter);
    HRESULT get_AutomationElementMode(AutomationElementMode* mode);
    HRESULT put_AutomationElementMode(AutomationElementMode mode);
}

const GUID IID_IUIAutomationTreeWalker = {0x4042C624, 0x389C, 0x4AFC, [0xA6, 0x30, 0x9D, 0xF8, 0x54, 0xA5, 0x41, 0xFC]};
@GUID(0x4042C624, 0x389C, 0x4AFC, [0xA6, 0x30, 0x9D, 0xF8, 0x54, 0xA5, 0x41, 0xFC]);
interface IUIAutomationTreeWalker : IUnknown
{
    HRESULT GetParentElement(IUIAutomationElement element, IUIAutomationElement* parent);
    HRESULT GetFirstChildElement(IUIAutomationElement element, IUIAutomationElement* first);
    HRESULT GetLastChildElement(IUIAutomationElement element, IUIAutomationElement* last);
    HRESULT GetNextSiblingElement(IUIAutomationElement element, IUIAutomationElement* next);
    HRESULT GetPreviousSiblingElement(IUIAutomationElement element, IUIAutomationElement* previous);
    HRESULT NormalizeElement(IUIAutomationElement element, IUIAutomationElement* normalized);
    HRESULT GetParentElementBuildCache(IUIAutomationElement element, IUIAutomationCacheRequest cacheRequest, IUIAutomationElement* parent);
    HRESULT GetFirstChildElementBuildCache(IUIAutomationElement element, IUIAutomationCacheRequest cacheRequest, IUIAutomationElement* first);
    HRESULT GetLastChildElementBuildCache(IUIAutomationElement element, IUIAutomationCacheRequest cacheRequest, IUIAutomationElement* last);
    HRESULT GetNextSiblingElementBuildCache(IUIAutomationElement element, IUIAutomationCacheRequest cacheRequest, IUIAutomationElement* next);
    HRESULT GetPreviousSiblingElementBuildCache(IUIAutomationElement element, IUIAutomationCacheRequest cacheRequest, IUIAutomationElement* previous);
    HRESULT NormalizeElementBuildCache(IUIAutomationElement element, IUIAutomationCacheRequest cacheRequest, IUIAutomationElement* normalized);
    HRESULT get_Condition(IUIAutomationCondition* condition);
}

const GUID IID_IUIAutomationEventHandler = {0x146C3C17, 0xF12E, 0x4E22, [0x8C, 0x27, 0xF8, 0x94, 0xB9, 0xB7, 0x9C, 0x69]};
@GUID(0x146C3C17, 0xF12E, 0x4E22, [0x8C, 0x27, 0xF8, 0x94, 0xB9, 0xB7, 0x9C, 0x69]);
interface IUIAutomationEventHandler : IUnknown
{
    HRESULT HandleAutomationEvent(IUIAutomationElement sender, int eventId);
}

const GUID IID_IUIAutomationPropertyChangedEventHandler = {0x40CD37D4, 0xC756, 0x4B0C, [0x8C, 0x6F, 0xBD, 0xDF, 0xEE, 0xB1, 0x3B, 0x50]};
@GUID(0x40CD37D4, 0xC756, 0x4B0C, [0x8C, 0x6F, 0xBD, 0xDF, 0xEE, 0xB1, 0x3B, 0x50]);
interface IUIAutomationPropertyChangedEventHandler : IUnknown
{
    HRESULT HandlePropertyChangedEvent(IUIAutomationElement sender, int propertyId, VARIANT newValue);
}

const GUID IID_IUIAutomationStructureChangedEventHandler = {0xE81D1B4E, 0x11C5, 0x42F8, [0x97, 0x54, 0xE7, 0x03, 0x6C, 0x79, 0xF0, 0x54]};
@GUID(0xE81D1B4E, 0x11C5, 0x42F8, [0x97, 0x54, 0xE7, 0x03, 0x6C, 0x79, 0xF0, 0x54]);
interface IUIAutomationStructureChangedEventHandler : IUnknown
{
    HRESULT HandleStructureChangedEvent(IUIAutomationElement sender, StructureChangeType changeType, SAFEARRAY* runtimeId);
}

const GUID IID_IUIAutomationFocusChangedEventHandler = {0xC270F6B5, 0x5C69, 0x4290, [0x97, 0x45, 0x7A, 0x7F, 0x97, 0x16, 0x94, 0x68]};
@GUID(0xC270F6B5, 0x5C69, 0x4290, [0x97, 0x45, 0x7A, 0x7F, 0x97, 0x16, 0x94, 0x68]);
interface IUIAutomationFocusChangedEventHandler : IUnknown
{
    HRESULT HandleFocusChangedEvent(IUIAutomationElement sender);
}

const GUID IID_IUIAutomationTextEditTextChangedEventHandler = {0x92FAA680, 0xE704, 0x4156, [0x93, 0x1A, 0xE3, 0x2D, 0x5B, 0xB3, 0x8F, 0x3F]};
@GUID(0x92FAA680, 0xE704, 0x4156, [0x93, 0x1A, 0xE3, 0x2D, 0x5B, 0xB3, 0x8F, 0x3F]);
interface IUIAutomationTextEditTextChangedEventHandler : IUnknown
{
    HRESULT HandleTextEditTextChangedEvent(IUIAutomationElement sender, TextEditChangeType textEditChangeType, SAFEARRAY* eventStrings);
}

const GUID IID_IUIAutomationChangesEventHandler = {0x58EDCA55, 0x2C3E, 0x4980, [0xB1, 0xB9, 0x56, 0xC1, 0x7F, 0x27, 0xA2, 0xA0]};
@GUID(0x58EDCA55, 0x2C3E, 0x4980, [0xB1, 0xB9, 0x56, 0xC1, 0x7F, 0x27, 0xA2, 0xA0]);
interface IUIAutomationChangesEventHandler : IUnknown
{
    HRESULT HandleChangesEvent(IUIAutomationElement sender, char* uiaChanges, int changesCount);
}

const GUID IID_IUIAutomationNotificationEventHandler = {0xC7CB2637, 0xE6C2, 0x4D0C, [0x85, 0xDE, 0x49, 0x48, 0xC0, 0x21, 0x75, 0xC7]};
@GUID(0xC7CB2637, 0xE6C2, 0x4D0C, [0x85, 0xDE, 0x49, 0x48, 0xC0, 0x21, 0x75, 0xC7]);
interface IUIAutomationNotificationEventHandler : IUnknown
{
    HRESULT HandleNotificationEvent(IUIAutomationElement sender, NotificationKind notificationKind, NotificationProcessing notificationProcessing, BSTR displayString, BSTR activityId);
}

const GUID IID_IUIAutomationInvokePattern = {0xFB377FBE, 0x8EA6, 0x46D5, [0x9C, 0x73, 0x64, 0x99, 0x64, 0x2D, 0x30, 0x59]};
@GUID(0xFB377FBE, 0x8EA6, 0x46D5, [0x9C, 0x73, 0x64, 0x99, 0x64, 0x2D, 0x30, 0x59]);
interface IUIAutomationInvokePattern : IUnknown
{
    HRESULT Invoke();
}

const GUID IID_IUIAutomationDockPattern = {0xFDE5EF97, 0x1464, 0x48F6, [0x90, 0xBF, 0x43, 0xD0, 0x94, 0x8E, 0x86, 0xEC]};
@GUID(0xFDE5EF97, 0x1464, 0x48F6, [0x90, 0xBF, 0x43, 0xD0, 0x94, 0x8E, 0x86, 0xEC]);
interface IUIAutomationDockPattern : IUnknown
{
    HRESULT SetDockPosition(DockPosition dockPos);
    HRESULT get_CurrentDockPosition(DockPosition* retVal);
    HRESULT get_CachedDockPosition(DockPosition* retVal);
}

const GUID IID_IUIAutomationExpandCollapsePattern = {0x619BE086, 0x1F4E, 0x4EE4, [0xBA, 0xFA, 0x21, 0x01, 0x28, 0x73, 0x87, 0x30]};
@GUID(0x619BE086, 0x1F4E, 0x4EE4, [0xBA, 0xFA, 0x21, 0x01, 0x28, 0x73, 0x87, 0x30]);
interface IUIAutomationExpandCollapsePattern : IUnknown
{
    HRESULT Expand();
    HRESULT Collapse();
    HRESULT get_CurrentExpandCollapseState(ExpandCollapseState* retVal);
    HRESULT get_CachedExpandCollapseState(ExpandCollapseState* retVal);
}

const GUID IID_IUIAutomationGridPattern = {0x414C3CDC, 0x856B, 0x4F5B, [0x85, 0x38, 0x31, 0x31, 0xC6, 0x30, 0x25, 0x50]};
@GUID(0x414C3CDC, 0x856B, 0x4F5B, [0x85, 0x38, 0x31, 0x31, 0xC6, 0x30, 0x25, 0x50]);
interface IUIAutomationGridPattern : IUnknown
{
    HRESULT GetItem(int row, int column, IUIAutomationElement* element);
    HRESULT get_CurrentRowCount(int* retVal);
    HRESULT get_CurrentColumnCount(int* retVal);
    HRESULT get_CachedRowCount(int* retVal);
    HRESULT get_CachedColumnCount(int* retVal);
}

const GUID IID_IUIAutomationGridItemPattern = {0x78F8EF57, 0x66C3, 0x4E09, [0xBD, 0x7C, 0xE7, 0x9B, 0x20, 0x04, 0x89, 0x4D]};
@GUID(0x78F8EF57, 0x66C3, 0x4E09, [0xBD, 0x7C, 0xE7, 0x9B, 0x20, 0x04, 0x89, 0x4D]);
interface IUIAutomationGridItemPattern : IUnknown
{
    HRESULT get_CurrentContainingGrid(IUIAutomationElement* retVal);
    HRESULT get_CurrentRow(int* retVal);
    HRESULT get_CurrentColumn(int* retVal);
    HRESULT get_CurrentRowSpan(int* retVal);
    HRESULT get_CurrentColumnSpan(int* retVal);
    HRESULT get_CachedContainingGrid(IUIAutomationElement* retVal);
    HRESULT get_CachedRow(int* retVal);
    HRESULT get_CachedColumn(int* retVal);
    HRESULT get_CachedRowSpan(int* retVal);
    HRESULT get_CachedColumnSpan(int* retVal);
}

const GUID IID_IUIAutomationMultipleViewPattern = {0x8D253C91, 0x1DC5, 0x4BB5, [0xB1, 0x8F, 0xAD, 0xE1, 0x6F, 0xA4, 0x95, 0xE8]};
@GUID(0x8D253C91, 0x1DC5, 0x4BB5, [0xB1, 0x8F, 0xAD, 0xE1, 0x6F, 0xA4, 0x95, 0xE8]);
interface IUIAutomationMultipleViewPattern : IUnknown
{
    HRESULT GetViewName(int view, BSTR* name);
    HRESULT SetCurrentView(int view);
    HRESULT get_CurrentCurrentView(int* retVal);
    HRESULT GetCurrentSupportedViews(SAFEARRAY** retVal);
    HRESULT get_CachedCurrentView(int* retVal);
    HRESULT GetCachedSupportedViews(SAFEARRAY** retVal);
}

const GUID IID_IUIAutomationObjectModelPattern = {0x71C284B3, 0xC14D, 0x4D14, [0x98, 0x1E, 0x19, 0x75, 0x1B, 0x0D, 0x75, 0x6D]};
@GUID(0x71C284B3, 0xC14D, 0x4D14, [0x98, 0x1E, 0x19, 0x75, 0x1B, 0x0D, 0x75, 0x6D]);
interface IUIAutomationObjectModelPattern : IUnknown
{
    HRESULT GetUnderlyingObjectModel(IUnknown* retVal);
}

const GUID IID_IUIAutomationRangeValuePattern = {0x59213F4F, 0x7346, 0x49E5, [0xB1, 0x20, 0x80, 0x55, 0x59, 0x87, 0xA1, 0x48]};
@GUID(0x59213F4F, 0x7346, 0x49E5, [0xB1, 0x20, 0x80, 0x55, 0x59, 0x87, 0xA1, 0x48]);
interface IUIAutomationRangeValuePattern : IUnknown
{
    HRESULT SetValue(double val);
    HRESULT get_CurrentValue(double* retVal);
    HRESULT get_CurrentIsReadOnly(int* retVal);
    HRESULT get_CurrentMaximum(double* retVal);
    HRESULT get_CurrentMinimum(double* retVal);
    HRESULT get_CurrentLargeChange(double* retVal);
    HRESULT get_CurrentSmallChange(double* retVal);
    HRESULT get_CachedValue(double* retVal);
    HRESULT get_CachedIsReadOnly(int* retVal);
    HRESULT get_CachedMaximum(double* retVal);
    HRESULT get_CachedMinimum(double* retVal);
    HRESULT get_CachedLargeChange(double* retVal);
    HRESULT get_CachedSmallChange(double* retVal);
}

const GUID IID_IUIAutomationScrollPattern = {0x88F4D42A, 0xE881, 0x459D, [0xA7, 0x7C, 0x73, 0xBB, 0xBB, 0x7E, 0x02, 0xDC]};
@GUID(0x88F4D42A, 0xE881, 0x459D, [0xA7, 0x7C, 0x73, 0xBB, 0xBB, 0x7E, 0x02, 0xDC]);
interface IUIAutomationScrollPattern : IUnknown
{
    HRESULT Scroll(ScrollAmount horizontalAmount, ScrollAmount verticalAmount);
    HRESULT SetScrollPercent(double horizontalPercent, double verticalPercent);
    HRESULT get_CurrentHorizontalScrollPercent(double* retVal);
    HRESULT get_CurrentVerticalScrollPercent(double* retVal);
    HRESULT get_CurrentHorizontalViewSize(double* retVal);
    HRESULT get_CurrentVerticalViewSize(double* retVal);
    HRESULT get_CurrentHorizontallyScrollable(int* retVal);
    HRESULT get_CurrentVerticallyScrollable(int* retVal);
    HRESULT get_CachedHorizontalScrollPercent(double* retVal);
    HRESULT get_CachedVerticalScrollPercent(double* retVal);
    HRESULT get_CachedHorizontalViewSize(double* retVal);
    HRESULT get_CachedVerticalViewSize(double* retVal);
    HRESULT get_CachedHorizontallyScrollable(int* retVal);
    HRESULT get_CachedVerticallyScrollable(int* retVal);
}

const GUID IID_IUIAutomationScrollItemPattern = {0xB488300F, 0xD015, 0x4F19, [0x9C, 0x29, 0xBB, 0x59, 0x5E, 0x36, 0x45, 0xEF]};
@GUID(0xB488300F, 0xD015, 0x4F19, [0x9C, 0x29, 0xBB, 0x59, 0x5E, 0x36, 0x45, 0xEF]);
interface IUIAutomationScrollItemPattern : IUnknown
{
    HRESULT ScrollIntoView();
}

const GUID IID_IUIAutomationSelectionPattern = {0x5ED5202E, 0xB2AC, 0x47A6, [0xB6, 0x38, 0x4B, 0x0B, 0xF1, 0x40, 0xD7, 0x8E]};
@GUID(0x5ED5202E, 0xB2AC, 0x47A6, [0xB6, 0x38, 0x4B, 0x0B, 0xF1, 0x40, 0xD7, 0x8E]);
interface IUIAutomationSelectionPattern : IUnknown
{
    HRESULT GetCurrentSelection(IUIAutomationElementArray* retVal);
    HRESULT get_CurrentCanSelectMultiple(int* retVal);
    HRESULT get_CurrentIsSelectionRequired(int* retVal);
    HRESULT GetCachedSelection(IUIAutomationElementArray* retVal);
    HRESULT get_CachedCanSelectMultiple(int* retVal);
    HRESULT get_CachedIsSelectionRequired(int* retVal);
}

const GUID IID_IUIAutomationSelectionPattern2 = {0x0532BFAE, 0xC011, 0x4E32, [0xA3, 0x43, 0x6D, 0x64, 0x2D, 0x79, 0x85, 0x55]};
@GUID(0x0532BFAE, 0xC011, 0x4E32, [0xA3, 0x43, 0x6D, 0x64, 0x2D, 0x79, 0x85, 0x55]);
interface IUIAutomationSelectionPattern2 : IUIAutomationSelectionPattern
{
    HRESULT get_CurrentFirstSelectedItem(IUIAutomationElement* retVal);
    HRESULT get_CurrentLastSelectedItem(IUIAutomationElement* retVal);
    HRESULT get_CurrentCurrentSelectedItem(IUIAutomationElement* retVal);
    HRESULT get_CurrentItemCount(int* retVal);
    HRESULT get_CachedFirstSelectedItem(IUIAutomationElement* retVal);
    HRESULT get_CachedLastSelectedItem(IUIAutomationElement* retVal);
    HRESULT get_CachedCurrentSelectedItem(IUIAutomationElement* retVal);
    HRESULT get_CachedItemCount(int* retVal);
}

const GUID IID_IUIAutomationSelectionItemPattern = {0xA8EFA66A, 0x0FDA, 0x421A, [0x91, 0x94, 0x38, 0x02, 0x1F, 0x35, 0x78, 0xEA]};
@GUID(0xA8EFA66A, 0x0FDA, 0x421A, [0x91, 0x94, 0x38, 0x02, 0x1F, 0x35, 0x78, 0xEA]);
interface IUIAutomationSelectionItemPattern : IUnknown
{
    HRESULT Select();
    HRESULT AddToSelection();
    HRESULT RemoveFromSelection();
    HRESULT get_CurrentIsSelected(int* retVal);
    HRESULT get_CurrentSelectionContainer(IUIAutomationElement* retVal);
    HRESULT get_CachedIsSelected(int* retVal);
    HRESULT get_CachedSelectionContainer(IUIAutomationElement* retVal);
}

const GUID IID_IUIAutomationSynchronizedInputPattern = {0x2233BE0B, 0xAFB7, 0x448B, [0x9F, 0xDA, 0x3B, 0x37, 0x8A, 0xA5, 0xEA, 0xE1]};
@GUID(0x2233BE0B, 0xAFB7, 0x448B, [0x9F, 0xDA, 0x3B, 0x37, 0x8A, 0xA5, 0xEA, 0xE1]);
interface IUIAutomationSynchronizedInputPattern : IUnknown
{
    HRESULT StartListening(SynchronizedInputType inputType);
    HRESULT Cancel();
}

const GUID IID_IUIAutomationTablePattern = {0x620E691C, 0xEA96, 0x4710, [0xA8, 0x50, 0x75, 0x4B, 0x24, 0xCE, 0x24, 0x17]};
@GUID(0x620E691C, 0xEA96, 0x4710, [0xA8, 0x50, 0x75, 0x4B, 0x24, 0xCE, 0x24, 0x17]);
interface IUIAutomationTablePattern : IUnknown
{
    HRESULT GetCurrentRowHeaders(IUIAutomationElementArray* retVal);
    HRESULT GetCurrentColumnHeaders(IUIAutomationElementArray* retVal);
    HRESULT get_CurrentRowOrColumnMajor(RowOrColumnMajor* retVal);
    HRESULT GetCachedRowHeaders(IUIAutomationElementArray* retVal);
    HRESULT GetCachedColumnHeaders(IUIAutomationElementArray* retVal);
    HRESULT get_CachedRowOrColumnMajor(RowOrColumnMajor* retVal);
}

const GUID IID_IUIAutomationTableItemPattern = {0x0B964EB3, 0xEF2E, 0x4464, [0x9C, 0x79, 0x61, 0xD6, 0x17, 0x37, 0xA2, 0x7E]};
@GUID(0x0B964EB3, 0xEF2E, 0x4464, [0x9C, 0x79, 0x61, 0xD6, 0x17, 0x37, 0xA2, 0x7E]);
interface IUIAutomationTableItemPattern : IUnknown
{
    HRESULT GetCurrentRowHeaderItems(IUIAutomationElementArray* retVal);
    HRESULT GetCurrentColumnHeaderItems(IUIAutomationElementArray* retVal);
    HRESULT GetCachedRowHeaderItems(IUIAutomationElementArray* retVal);
    HRESULT GetCachedColumnHeaderItems(IUIAutomationElementArray* retVal);
}

const GUID IID_IUIAutomationTogglePattern = {0x94CF8058, 0x9B8D, 0x4AB9, [0x8B, 0xFD, 0x4C, 0xD0, 0xA3, 0x3C, 0x8C, 0x70]};
@GUID(0x94CF8058, 0x9B8D, 0x4AB9, [0x8B, 0xFD, 0x4C, 0xD0, 0xA3, 0x3C, 0x8C, 0x70]);
interface IUIAutomationTogglePattern : IUnknown
{
    HRESULT Toggle();
    HRESULT get_CurrentToggleState(ToggleState* retVal);
    HRESULT get_CachedToggleState(ToggleState* retVal);
}

const GUID IID_IUIAutomationTransformPattern = {0xA9B55844, 0xA55D, 0x4EF0, [0x92, 0x6D, 0x56, 0x9C, 0x16, 0xFF, 0x89, 0xBB]};
@GUID(0xA9B55844, 0xA55D, 0x4EF0, [0x92, 0x6D, 0x56, 0x9C, 0x16, 0xFF, 0x89, 0xBB]);
interface IUIAutomationTransformPattern : IUnknown
{
    HRESULT Move(double x, double y);
    HRESULT Resize(double width, double height);
    HRESULT Rotate(double degrees);
    HRESULT get_CurrentCanMove(int* retVal);
    HRESULT get_CurrentCanResize(int* retVal);
    HRESULT get_CurrentCanRotate(int* retVal);
    HRESULT get_CachedCanMove(int* retVal);
    HRESULT get_CachedCanResize(int* retVal);
    HRESULT get_CachedCanRotate(int* retVal);
}

const GUID IID_IUIAutomationValuePattern = {0xA94CD8B1, 0x0844, 0x4CD6, [0x9D, 0x2D, 0x64, 0x05, 0x37, 0xAB, 0x39, 0xE9]};
@GUID(0xA94CD8B1, 0x0844, 0x4CD6, [0x9D, 0x2D, 0x64, 0x05, 0x37, 0xAB, 0x39, 0xE9]);
interface IUIAutomationValuePattern : IUnknown
{
    HRESULT SetValue(BSTR val);
    HRESULT get_CurrentValue(BSTR* retVal);
    HRESULT get_CurrentIsReadOnly(int* retVal);
    HRESULT get_CachedValue(BSTR* retVal);
    HRESULT get_CachedIsReadOnly(int* retVal);
}

const GUID IID_IUIAutomationWindowPattern = {0x0FAEF453, 0x9208, 0x43EF, [0xBB, 0xB2, 0x3B, 0x48, 0x51, 0x77, 0x86, 0x4F]};
@GUID(0x0FAEF453, 0x9208, 0x43EF, [0xBB, 0xB2, 0x3B, 0x48, 0x51, 0x77, 0x86, 0x4F]);
interface IUIAutomationWindowPattern : IUnknown
{
    HRESULT Close();
    HRESULT WaitForInputIdle(int milliseconds, int* success);
    HRESULT SetWindowVisualState(WindowVisualState state);
    HRESULT get_CurrentCanMaximize(int* retVal);
    HRESULT get_CurrentCanMinimize(int* retVal);
    HRESULT get_CurrentIsModal(int* retVal);
    HRESULT get_CurrentIsTopmost(int* retVal);
    HRESULT get_CurrentWindowVisualState(WindowVisualState* retVal);
    HRESULT get_CurrentWindowInteractionState(WindowInteractionState* retVal);
    HRESULT get_CachedCanMaximize(int* retVal);
    HRESULT get_CachedCanMinimize(int* retVal);
    HRESULT get_CachedIsModal(int* retVal);
    HRESULT get_CachedIsTopmost(int* retVal);
    HRESULT get_CachedWindowVisualState(WindowVisualState* retVal);
    HRESULT get_CachedWindowInteractionState(WindowInteractionState* retVal);
}

const GUID IID_IUIAutomationTextRange = {0xA543CC6A, 0xF4AE, 0x494B, [0x82, 0x39, 0xC8, 0x14, 0x48, 0x11, 0x87, 0xA8]};
@GUID(0xA543CC6A, 0xF4AE, 0x494B, [0x82, 0x39, 0xC8, 0x14, 0x48, 0x11, 0x87, 0xA8]);
interface IUIAutomationTextRange : IUnknown
{
    HRESULT Clone(IUIAutomationTextRange* clonedRange);
    HRESULT Compare(IUIAutomationTextRange range, int* areSame);
    HRESULT CompareEndpoints(TextPatternRangeEndpoint srcEndPoint, IUIAutomationTextRange range, TextPatternRangeEndpoint targetEndPoint, int* compValue);
    HRESULT ExpandToEnclosingUnit(TextUnit textUnit);
    HRESULT FindAttribute(int attr, VARIANT val, BOOL backward, IUIAutomationTextRange* found);
    HRESULT FindTextA(BSTR text, BOOL backward, BOOL ignoreCase, IUIAutomationTextRange* found);
    HRESULT GetAttributeValue(int attr, VARIANT* value);
    HRESULT GetBoundingRectangles(SAFEARRAY** boundingRects);
    HRESULT GetEnclosingElement(IUIAutomationElement* enclosingElement);
    HRESULT GetText(int maxLength, BSTR* text);
    HRESULT Move(TextUnit unit, int count, int* moved);
    HRESULT MoveEndpointByUnit(TextPatternRangeEndpoint endpoint, TextUnit unit, int count, int* moved);
    HRESULT MoveEndpointByRange(TextPatternRangeEndpoint srcEndPoint, IUIAutomationTextRange range, TextPatternRangeEndpoint targetEndPoint);
    HRESULT Select();
    HRESULT AddToSelection();
    HRESULT RemoveFromSelection();
    HRESULT ScrollIntoView(BOOL alignToTop);
    HRESULT GetChildren(IUIAutomationElementArray* children);
}

const GUID IID_IUIAutomationTextRange2 = {0xBB9B40E0, 0x5E04, 0x46BD, [0x9B, 0xE0, 0x4B, 0x60, 0x1B, 0x9A, 0xFA, 0xD4]};
@GUID(0xBB9B40E0, 0x5E04, 0x46BD, [0x9B, 0xE0, 0x4B, 0x60, 0x1B, 0x9A, 0xFA, 0xD4]);
interface IUIAutomationTextRange2 : IUIAutomationTextRange
{
    HRESULT ShowContextMenu();
}

const GUID IID_IUIAutomationTextRange3 = {0x6A315D69, 0x5512, 0x4C2E, [0x85, 0xF0, 0x53, 0xFC, 0xE6, 0xDD, 0x4B, 0xC2]};
@GUID(0x6A315D69, 0x5512, 0x4C2E, [0x85, 0xF0, 0x53, 0xFC, 0xE6, 0xDD, 0x4B, 0xC2]);
interface IUIAutomationTextRange3 : IUIAutomationTextRange2
{
    HRESULT GetEnclosingElementBuildCache(IUIAutomationCacheRequest cacheRequest, IUIAutomationElement* enclosingElement);
    HRESULT GetChildrenBuildCache(IUIAutomationCacheRequest cacheRequest, IUIAutomationElementArray* children);
    HRESULT GetAttributeValues(char* attributeIds, int attributeIdCount, SAFEARRAY** attributeValues);
}

const GUID IID_IUIAutomationTextRangeArray = {0xCE4AE76A, 0xE717, 0x4C98, [0x81, 0xEA, 0x47, 0x37, 0x1D, 0x02, 0x8E, 0xB6]};
@GUID(0xCE4AE76A, 0xE717, 0x4C98, [0x81, 0xEA, 0x47, 0x37, 0x1D, 0x02, 0x8E, 0xB6]);
interface IUIAutomationTextRangeArray : IUnknown
{
    HRESULT get_Length(int* length);
    HRESULT GetElement(int index, IUIAutomationTextRange* element);
}

const GUID IID_IUIAutomationTextPattern = {0x32EBA289, 0x3583, 0x42C9, [0x9C, 0x59, 0x3B, 0x6D, 0x9A, 0x1E, 0x9B, 0x6A]};
@GUID(0x32EBA289, 0x3583, 0x42C9, [0x9C, 0x59, 0x3B, 0x6D, 0x9A, 0x1E, 0x9B, 0x6A]);
interface IUIAutomationTextPattern : IUnknown
{
    HRESULT RangeFromPoint(POINT pt, IUIAutomationTextRange* range);
    HRESULT RangeFromChild(IUIAutomationElement child, IUIAutomationTextRange* range);
    HRESULT GetSelection(IUIAutomationTextRangeArray* ranges);
    HRESULT GetVisibleRanges(IUIAutomationTextRangeArray* ranges);
    HRESULT get_DocumentRange(IUIAutomationTextRange* range);
    HRESULT get_SupportedTextSelection(SupportedTextSelection* supportedTextSelection);
}

const GUID IID_IUIAutomationTextPattern2 = {0x506A921A, 0xFCC9, 0x409F, [0xB2, 0x3B, 0x37, 0xEB, 0x74, 0x10, 0x68, 0x72]};
@GUID(0x506A921A, 0xFCC9, 0x409F, [0xB2, 0x3B, 0x37, 0xEB, 0x74, 0x10, 0x68, 0x72]);
interface IUIAutomationTextPattern2 : IUIAutomationTextPattern
{
    HRESULT RangeFromAnnotation(IUIAutomationElement annotation, IUIAutomationTextRange* range);
    HRESULT GetCaretRange(int* isActive, IUIAutomationTextRange* range);
}

const GUID IID_IUIAutomationTextEditPattern = {0x17E21576, 0x996C, 0x4870, [0x99, 0xD9, 0xBF, 0xF3, 0x23, 0x38, 0x0C, 0x06]};
@GUID(0x17E21576, 0x996C, 0x4870, [0x99, 0xD9, 0xBF, 0xF3, 0x23, 0x38, 0x0C, 0x06]);
interface IUIAutomationTextEditPattern : IUIAutomationTextPattern
{
    HRESULT GetActiveComposition(IUIAutomationTextRange* range);
    HRESULT GetConversionTarget(IUIAutomationTextRange* range);
}

const GUID IID_IUIAutomationCustomNavigationPattern = {0x01EA217A, 0x1766, 0x47ED, [0xA6, 0xCC, 0xAC, 0xF4, 0x92, 0x85, 0x4B, 0x1F]};
@GUID(0x01EA217A, 0x1766, 0x47ED, [0xA6, 0xCC, 0xAC, 0xF4, 0x92, 0x85, 0x4B, 0x1F]);
interface IUIAutomationCustomNavigationPattern : IUnknown
{
    HRESULT Navigate(NavigateDirection direction, IUIAutomationElement* pRetVal);
}

const GUID IID_IUIAutomationActiveTextPositionChangedEventHandler = {0xF97933B0, 0x8DAE, 0x4496, [0x89, 0x97, 0x5B, 0xA0, 0x15, 0xFE, 0x0D, 0x82]};
@GUID(0xF97933B0, 0x8DAE, 0x4496, [0x89, 0x97, 0x5B, 0xA0, 0x15, 0xFE, 0x0D, 0x82]);
interface IUIAutomationActiveTextPositionChangedEventHandler : IUnknown
{
    HRESULT HandleActiveTextPositionChangedEvent(IUIAutomationElement sender, IUIAutomationTextRange range);
}

const GUID IID_IUIAutomationLegacyIAccessiblePattern = {0x828055AD, 0x355B, 0x4435, [0x86, 0xD5, 0x3B, 0x51, 0xC1, 0x4A, 0x9B, 0x1B]};
@GUID(0x828055AD, 0x355B, 0x4435, [0x86, 0xD5, 0x3B, 0x51, 0xC1, 0x4A, 0x9B, 0x1B]);
interface IUIAutomationLegacyIAccessiblePattern : IUnknown
{
    HRESULT Select(int flagsSelect);
    HRESULT DoDefaultAction();
    HRESULT SetValue(const(wchar)* szValue);
    HRESULT get_CurrentChildId(int* pRetVal);
    HRESULT get_CurrentName(BSTR* pszName);
    HRESULT get_CurrentValue(BSTR* pszValue);
    HRESULT get_CurrentDescription(BSTR* pszDescription);
    HRESULT get_CurrentRole(uint* pdwRole);
    HRESULT get_CurrentState(uint* pdwState);
    HRESULT get_CurrentHelp(BSTR* pszHelp);
    HRESULT get_CurrentKeyboardShortcut(BSTR* pszKeyboardShortcut);
    HRESULT GetCurrentSelection(IUIAutomationElementArray* pvarSelectedChildren);
    HRESULT get_CurrentDefaultAction(BSTR* pszDefaultAction);
    HRESULT get_CachedChildId(int* pRetVal);
    HRESULT get_CachedName(BSTR* pszName);
    HRESULT get_CachedValue(BSTR* pszValue);
    HRESULT get_CachedDescription(BSTR* pszDescription);
    HRESULT get_CachedRole(uint* pdwRole);
    HRESULT get_CachedState(uint* pdwState);
    HRESULT get_CachedHelp(BSTR* pszHelp);
    HRESULT get_CachedKeyboardShortcut(BSTR* pszKeyboardShortcut);
    HRESULT GetCachedSelection(IUIAutomationElementArray* pvarSelectedChildren);
    HRESULT get_CachedDefaultAction(BSTR* pszDefaultAction);
    HRESULT GetIAccessible(IAccessible* ppAccessible);
}

const GUID IID_IUIAutomationItemContainerPattern = {0xC690FDB2, 0x27A8, 0x423C, [0x81, 0x2D, 0x42, 0x97, 0x73, 0xC9, 0x08, 0x4E]};
@GUID(0xC690FDB2, 0x27A8, 0x423C, [0x81, 0x2D, 0x42, 0x97, 0x73, 0xC9, 0x08, 0x4E]);
interface IUIAutomationItemContainerPattern : IUnknown
{
    HRESULT FindItemByProperty(IUIAutomationElement pStartAfter, int propertyId, VARIANT value, IUIAutomationElement* pFound);
}

const GUID IID_IUIAutomationVirtualizedItemPattern = {0x6BA3D7A6, 0x04CF, 0x4F11, [0x87, 0x93, 0xA8, 0xD1, 0xCD, 0xE9, 0x96, 0x9F]};
@GUID(0x6BA3D7A6, 0x04CF, 0x4F11, [0x87, 0x93, 0xA8, 0xD1, 0xCD, 0xE9, 0x96, 0x9F]);
interface IUIAutomationVirtualizedItemPattern : IUnknown
{
    HRESULT Realize();
}

const GUID IID_IUIAutomationAnnotationPattern = {0x9A175B21, 0x339E, 0x41B1, [0x8E, 0x8B, 0x62, 0x3F, 0x6B, 0x68, 0x10, 0x98]};
@GUID(0x9A175B21, 0x339E, 0x41B1, [0x8E, 0x8B, 0x62, 0x3F, 0x6B, 0x68, 0x10, 0x98]);
interface IUIAutomationAnnotationPattern : IUnknown
{
    HRESULT get_CurrentAnnotationTypeId(int* retVal);
    HRESULT get_CurrentAnnotationTypeName(BSTR* retVal);
    HRESULT get_CurrentAuthor(BSTR* retVal);
    HRESULT get_CurrentDateTime(BSTR* retVal);
    HRESULT get_CurrentTarget(IUIAutomationElement* retVal);
    HRESULT get_CachedAnnotationTypeId(int* retVal);
    HRESULT get_CachedAnnotationTypeName(BSTR* retVal);
    HRESULT get_CachedAuthor(BSTR* retVal);
    HRESULT get_CachedDateTime(BSTR* retVal);
    HRESULT get_CachedTarget(IUIAutomationElement* retVal);
}

const GUID IID_IUIAutomationStylesPattern = {0x85B5F0A2, 0xBD79, 0x484A, [0xAD, 0x2B, 0x38, 0x8C, 0x98, 0x38, 0xD5, 0xFB]};
@GUID(0x85B5F0A2, 0xBD79, 0x484A, [0xAD, 0x2B, 0x38, 0x8C, 0x98, 0x38, 0xD5, 0xFB]);
interface IUIAutomationStylesPattern : IUnknown
{
    HRESULT get_CurrentStyleId(int* retVal);
    HRESULT get_CurrentStyleName(BSTR* retVal);
    HRESULT get_CurrentFillColor(int* retVal);
    HRESULT get_CurrentFillPatternStyle(BSTR* retVal);
    HRESULT get_CurrentShape(BSTR* retVal);
    HRESULT get_CurrentFillPatternColor(int* retVal);
    HRESULT get_CurrentExtendedProperties(BSTR* retVal);
    HRESULT GetCurrentExtendedPropertiesAsArray(char* propertyArray, int* propertyCount);
    HRESULT get_CachedStyleId(int* retVal);
    HRESULT get_CachedStyleName(BSTR* retVal);
    HRESULT get_CachedFillColor(int* retVal);
    HRESULT get_CachedFillPatternStyle(BSTR* retVal);
    HRESULT get_CachedShape(BSTR* retVal);
    HRESULT get_CachedFillPatternColor(int* retVal);
    HRESULT get_CachedExtendedProperties(BSTR* retVal);
    HRESULT GetCachedExtendedPropertiesAsArray(char* propertyArray, int* propertyCount);
}

const GUID IID_IUIAutomationSpreadsheetPattern = {0x7517A7C8, 0xFAAE, 0x4DE9, [0x9F, 0x08, 0x29, 0xB9, 0x1E, 0x85, 0x95, 0xC1]};
@GUID(0x7517A7C8, 0xFAAE, 0x4DE9, [0x9F, 0x08, 0x29, 0xB9, 0x1E, 0x85, 0x95, 0xC1]);
interface IUIAutomationSpreadsheetPattern : IUnknown
{
    HRESULT GetItemByName(BSTR name, IUIAutomationElement* element);
}

const GUID IID_IUIAutomationSpreadsheetItemPattern = {0x7D4FB86C, 0x8D34, 0x40E1, [0x8E, 0x83, 0x62, 0xC1, 0x52, 0x04, 0xE3, 0x35]};
@GUID(0x7D4FB86C, 0x8D34, 0x40E1, [0x8E, 0x83, 0x62, 0xC1, 0x52, 0x04, 0xE3, 0x35]);
interface IUIAutomationSpreadsheetItemPattern : IUnknown
{
    HRESULT get_CurrentFormula(BSTR* retVal);
    HRESULT GetCurrentAnnotationObjects(IUIAutomationElementArray* retVal);
    HRESULT GetCurrentAnnotationTypes(SAFEARRAY** retVal);
    HRESULT get_CachedFormula(BSTR* retVal);
    HRESULT GetCachedAnnotationObjects(IUIAutomationElementArray* retVal);
    HRESULT GetCachedAnnotationTypes(SAFEARRAY** retVal);
}

const GUID IID_IUIAutomationTransformPattern2 = {0x6D74D017, 0x6ECB, 0x4381, [0xB3, 0x8B, 0x3C, 0x17, 0xA4, 0x8F, 0xF1, 0xC2]};
@GUID(0x6D74D017, 0x6ECB, 0x4381, [0xB3, 0x8B, 0x3C, 0x17, 0xA4, 0x8F, 0xF1, 0xC2]);
interface IUIAutomationTransformPattern2 : IUIAutomationTransformPattern
{
    HRESULT Zoom(double zoomValue);
    HRESULT ZoomByUnit(ZoomUnit zoomUnit);
    HRESULT get_CurrentCanZoom(int* retVal);
    HRESULT get_CachedCanZoom(int* retVal);
    HRESULT get_CurrentZoomLevel(double* retVal);
    HRESULT get_CachedZoomLevel(double* retVal);
    HRESULT get_CurrentZoomMinimum(double* retVal);
    HRESULT get_CachedZoomMinimum(double* retVal);
    HRESULT get_CurrentZoomMaximum(double* retVal);
    HRESULT get_CachedZoomMaximum(double* retVal);
}

const GUID IID_IUIAutomationTextChildPattern = {0x6552B038, 0xAE05, 0x40C8, [0xAB, 0xFD, 0xAA, 0x08, 0x35, 0x2A, 0xAB, 0x86]};
@GUID(0x6552B038, 0xAE05, 0x40C8, [0xAB, 0xFD, 0xAA, 0x08, 0x35, 0x2A, 0xAB, 0x86]);
interface IUIAutomationTextChildPattern : IUnknown
{
    HRESULT get_TextContainer(IUIAutomationElement* container);
    HRESULT get_TextRange(IUIAutomationTextRange* range);
}

const GUID IID_IUIAutomationDragPattern = {0x1DC7B570, 0x1F54, 0x4BAD, [0xBC, 0xDA, 0xD3, 0x6A, 0x72, 0x2F, 0xB7, 0xBD]};
@GUID(0x1DC7B570, 0x1F54, 0x4BAD, [0xBC, 0xDA, 0xD3, 0x6A, 0x72, 0x2F, 0xB7, 0xBD]);
interface IUIAutomationDragPattern : IUnknown
{
    HRESULT get_CurrentIsGrabbed(int* retVal);
    HRESULT get_CachedIsGrabbed(int* retVal);
    HRESULT get_CurrentDropEffect(BSTR* retVal);
    HRESULT get_CachedDropEffect(BSTR* retVal);
    HRESULT get_CurrentDropEffects(SAFEARRAY** retVal);
    HRESULT get_CachedDropEffects(SAFEARRAY** retVal);
    HRESULT GetCurrentGrabbedItems(IUIAutomationElementArray* retVal);
    HRESULT GetCachedGrabbedItems(IUIAutomationElementArray* retVal);
}

const GUID IID_IUIAutomationDropTargetPattern = {0x69A095F7, 0xEEE4, 0x430E, [0xA4, 0x6B, 0xFB, 0x73, 0xB1, 0xAE, 0x39, 0xA5]};
@GUID(0x69A095F7, 0xEEE4, 0x430E, [0xA4, 0x6B, 0xFB, 0x73, 0xB1, 0xAE, 0x39, 0xA5]);
interface IUIAutomationDropTargetPattern : IUnknown
{
    HRESULT get_CurrentDropTargetEffect(BSTR* retVal);
    HRESULT get_CachedDropTargetEffect(BSTR* retVal);
    HRESULT get_CurrentDropTargetEffects(SAFEARRAY** retVal);
    HRESULT get_CachedDropTargetEffects(SAFEARRAY** retVal);
}

const GUID IID_IUIAutomationElement2 = {0x6749C683, 0xF70D, 0x4487, [0xA6, 0x98, 0x5F, 0x79, 0xD5, 0x52, 0x90, 0xD6]};
@GUID(0x6749C683, 0xF70D, 0x4487, [0xA6, 0x98, 0x5F, 0x79, 0xD5, 0x52, 0x90, 0xD6]);
interface IUIAutomationElement2 : IUIAutomationElement
{
    HRESULT get_CurrentOptimizeForVisualContent(int* retVal);
    HRESULT get_CachedOptimizeForVisualContent(int* retVal);
    HRESULT get_CurrentLiveSetting(LiveSetting* retVal);
    HRESULT get_CachedLiveSetting(LiveSetting* retVal);
    HRESULT get_CurrentFlowsFrom(IUIAutomationElementArray* retVal);
    HRESULT get_CachedFlowsFrom(IUIAutomationElementArray* retVal);
}

const GUID IID_IUIAutomationElement3 = {0x8471DF34, 0xAEE0, 0x4A01, [0xA7, 0xDE, 0x7D, 0xB9, 0xAF, 0x12, 0xC2, 0x96]};
@GUID(0x8471DF34, 0xAEE0, 0x4A01, [0xA7, 0xDE, 0x7D, 0xB9, 0xAF, 0x12, 0xC2, 0x96]);
interface IUIAutomationElement3 : IUIAutomationElement2
{
    HRESULT ShowContextMenu();
    HRESULT get_CurrentIsPeripheral(int* retVal);
    HRESULT get_CachedIsPeripheral(int* retVal);
}

const GUID IID_IUIAutomationElement4 = {0x3B6E233C, 0x52FB, 0x4063, [0xA4, 0xC9, 0x77, 0xC0, 0x75, 0xC2, 0xA0, 0x6B]};
@GUID(0x3B6E233C, 0x52FB, 0x4063, [0xA4, 0xC9, 0x77, 0xC0, 0x75, 0xC2, 0xA0, 0x6B]);
interface IUIAutomationElement4 : IUIAutomationElement3
{
    HRESULT get_CurrentPositionInSet(int* retVal);
    HRESULT get_CurrentSizeOfSet(int* retVal);
    HRESULT get_CurrentLevel(int* retVal);
    HRESULT get_CurrentAnnotationTypes(SAFEARRAY** retVal);
    HRESULT get_CurrentAnnotationObjects(IUIAutomationElementArray* retVal);
    HRESULT get_CachedPositionInSet(int* retVal);
    HRESULT get_CachedSizeOfSet(int* retVal);
    HRESULT get_CachedLevel(int* retVal);
    HRESULT get_CachedAnnotationTypes(SAFEARRAY** retVal);
    HRESULT get_CachedAnnotationObjects(IUIAutomationElementArray* retVal);
}

const GUID IID_IUIAutomationElement5 = {0x98141C1D, 0x0D0E, 0x4175, [0xBB, 0xE2, 0x6B, 0xFF, 0x45, 0x58, 0x42, 0xA7]};
@GUID(0x98141C1D, 0x0D0E, 0x4175, [0xBB, 0xE2, 0x6B, 0xFF, 0x45, 0x58, 0x42, 0xA7]);
interface IUIAutomationElement5 : IUIAutomationElement4
{
    HRESULT get_CurrentLandmarkType(int* retVal);
    HRESULT get_CurrentLocalizedLandmarkType(BSTR* retVal);
    HRESULT get_CachedLandmarkType(int* retVal);
    HRESULT get_CachedLocalizedLandmarkType(BSTR* retVal);
}

const GUID IID_IUIAutomationElement6 = {0x4780D450, 0x8BCA, 0x4977, [0xAF, 0xA5, 0xA4, 0xA5, 0x17, 0xF5, 0x55, 0xE3]};
@GUID(0x4780D450, 0x8BCA, 0x4977, [0xAF, 0xA5, 0xA4, 0xA5, 0x17, 0xF5, 0x55, 0xE3]);
interface IUIAutomationElement6 : IUIAutomationElement5
{
    HRESULT get_CurrentFullDescription(BSTR* retVal);
    HRESULT get_CachedFullDescription(BSTR* retVal);
}

const GUID IID_IUIAutomationElement7 = {0x204E8572, 0xCFC3, 0x4C11, [0xB0, 0xC8, 0x7D, 0xA7, 0x42, 0x07, 0x50, 0xB7]};
@GUID(0x204E8572, 0xCFC3, 0x4C11, [0xB0, 0xC8, 0x7D, 0xA7, 0x42, 0x07, 0x50, 0xB7]);
interface IUIAutomationElement7 : IUIAutomationElement6
{
    HRESULT FindFirstWithOptions(TreeScope scope, IUIAutomationCondition condition, TreeTraversalOptions traversalOptions, IUIAutomationElement root, IUIAutomationElement* found);
    HRESULT FindAllWithOptions(TreeScope scope, IUIAutomationCondition condition, TreeTraversalOptions traversalOptions, IUIAutomationElement root, IUIAutomationElementArray* found);
    HRESULT FindFirstWithOptionsBuildCache(TreeScope scope, IUIAutomationCondition condition, IUIAutomationCacheRequest cacheRequest, TreeTraversalOptions traversalOptions, IUIAutomationElement root, IUIAutomationElement* found);
    HRESULT FindAllWithOptionsBuildCache(TreeScope scope, IUIAutomationCondition condition, IUIAutomationCacheRequest cacheRequest, TreeTraversalOptions traversalOptions, IUIAutomationElement root, IUIAutomationElementArray* found);
    HRESULT GetCurrentMetadataValue(int targetId, int metadataId, VARIANT* returnVal);
}

const GUID IID_IUIAutomationElement8 = {0x8C60217D, 0x5411, 0x4CDE, [0xBC, 0xC0, 0x1C, 0xED, 0xA2, 0x23, 0x83, 0x0C]};
@GUID(0x8C60217D, 0x5411, 0x4CDE, [0xBC, 0xC0, 0x1C, 0xED, 0xA2, 0x23, 0x83, 0x0C]);
interface IUIAutomationElement8 : IUIAutomationElement7
{
    HRESULT get_CurrentHeadingLevel(int* retVal);
    HRESULT get_CachedHeadingLevel(int* retVal);
}

const GUID IID_IUIAutomationElement9 = {0x39325FAC, 0x039D, 0x440E, [0xA3, 0xA3, 0x5E, 0xB8, 0x1A, 0x5C, 0xEC, 0xC3]};
@GUID(0x39325FAC, 0x039D, 0x440E, [0xA3, 0xA3, 0x5E, 0xB8, 0x1A, 0x5C, 0xEC, 0xC3]);
interface IUIAutomationElement9 : IUIAutomationElement8
{
    HRESULT get_CurrentIsDialog(int* retVal);
    HRESULT get_CachedIsDialog(int* retVal);
}

const GUID IID_IUIAutomationProxyFactory = {0x85B94ECD, 0x849D, 0x42B6, [0xB9, 0x4D, 0xD6, 0xDB, 0x23, 0xFD, 0xF5, 0xA4]};
@GUID(0x85B94ECD, 0x849D, 0x42B6, [0xB9, 0x4D, 0xD6, 0xDB, 0x23, 0xFD, 0xF5, 0xA4]);
interface IUIAutomationProxyFactory : IUnknown
{
    HRESULT CreateProvider(void* hwnd, int idObject, int idChild, IRawElementProviderSimple* provider);
    HRESULT get_ProxyFactoryId(BSTR* factoryId);
}

const GUID IID_IUIAutomationProxyFactoryEntry = {0xD50E472E, 0xB64B, 0x490C, [0xBC, 0xA1, 0xD3, 0x06, 0x96, 0xF9, 0xF2, 0x89]};
@GUID(0xD50E472E, 0xB64B, 0x490C, [0xBC, 0xA1, 0xD3, 0x06, 0x96, 0xF9, 0xF2, 0x89]);
interface IUIAutomationProxyFactoryEntry : IUnknown
{
    HRESULT get_ProxyFactory(IUIAutomationProxyFactory* factory);
    HRESULT get_ClassName(BSTR* className);
    HRESULT get_ImageName(BSTR* imageName);
    HRESULT get_AllowSubstringMatch(int* allowSubstringMatch);
    HRESULT get_CanCheckBaseClass(int* canCheckBaseClass);
    HRESULT get_NeedsAdviseEvents(int* adviseEvents);
    HRESULT put_ClassName(const(wchar)* className);
    HRESULT put_ImageName(const(wchar)* imageName);
    HRESULT put_AllowSubstringMatch(BOOL allowSubstringMatch);
    HRESULT put_CanCheckBaseClass(BOOL canCheckBaseClass);
    HRESULT put_NeedsAdviseEvents(BOOL adviseEvents);
    HRESULT SetWinEventsForAutomationEvent(int eventId, int propertyId, SAFEARRAY* winEvents);
    HRESULT GetWinEventsForAutomationEvent(int eventId, int propertyId, SAFEARRAY** winEvents);
}

const GUID IID_IUIAutomationProxyFactoryMapping = {0x09E31E18, 0x872D, 0x4873, [0x93, 0xD1, 0x1E, 0x54, 0x1E, 0xC1, 0x33, 0xFD]};
@GUID(0x09E31E18, 0x872D, 0x4873, [0x93, 0xD1, 0x1E, 0x54, 0x1E, 0xC1, 0x33, 0xFD]);
interface IUIAutomationProxyFactoryMapping : IUnknown
{
    HRESULT get_Count(uint* count);
    HRESULT GetTable(SAFEARRAY** table);
    HRESULT GetEntry(uint index, IUIAutomationProxyFactoryEntry* entry);
    HRESULT SetTable(SAFEARRAY* factoryList);
    HRESULT InsertEntries(uint before, SAFEARRAY* factoryList);
    HRESULT InsertEntry(uint before, IUIAutomationProxyFactoryEntry factory);
    HRESULT RemoveEntry(uint index);
    HRESULT ClearTable();
    HRESULT RestoreDefaultTable();
}

const GUID IID_IUIAutomationEventHandlerGroup = {0xC9EE12F2, 0xC13B, 0x4408, [0x99, 0x7C, 0x63, 0x99, 0x14, 0x37, 0x7F, 0x4E]};
@GUID(0xC9EE12F2, 0xC13B, 0x4408, [0x99, 0x7C, 0x63, 0x99, 0x14, 0x37, 0x7F, 0x4E]);
interface IUIAutomationEventHandlerGroup : IUnknown
{
    HRESULT AddActiveTextPositionChangedEventHandler(TreeScope scope, IUIAutomationCacheRequest cacheRequest, IUIAutomationActiveTextPositionChangedEventHandler handler);
    HRESULT AddAutomationEventHandler(int eventId, TreeScope scope, IUIAutomationCacheRequest cacheRequest, IUIAutomationEventHandler handler);
    HRESULT AddChangesEventHandler(TreeScope scope, char* changeTypes, int changesCount, IUIAutomationCacheRequest cacheRequest, IUIAutomationChangesEventHandler handler);
    HRESULT AddNotificationEventHandler(TreeScope scope, IUIAutomationCacheRequest cacheRequest, IUIAutomationNotificationEventHandler handler);
    HRESULT AddPropertyChangedEventHandler(TreeScope scope, IUIAutomationCacheRequest cacheRequest, IUIAutomationPropertyChangedEventHandler handler, char* propertyArray, int propertyCount);
    HRESULT AddStructureChangedEventHandler(TreeScope scope, IUIAutomationCacheRequest cacheRequest, IUIAutomationStructureChangedEventHandler handler);
    HRESULT AddTextEditTextChangedEventHandler(TreeScope scope, TextEditChangeType textEditChangeType, IUIAutomationCacheRequest cacheRequest, IUIAutomationTextEditTextChangedEventHandler handler);
}

const GUID IID_IUIAutomation = {0x30CBE57D, 0xD9D0, 0x452A, [0xAB, 0x13, 0x7A, 0xC5, 0xAC, 0x48, 0x25, 0xEE]};
@GUID(0x30CBE57D, 0xD9D0, 0x452A, [0xAB, 0x13, 0x7A, 0xC5, 0xAC, 0x48, 0x25, 0xEE]);
interface IUIAutomation : IUnknown
{
    HRESULT CompareElements(IUIAutomationElement el1, IUIAutomationElement el2, int* areSame);
    HRESULT CompareRuntimeIds(SAFEARRAY* runtimeId1, SAFEARRAY* runtimeId2, int* areSame);
    HRESULT GetRootElement(IUIAutomationElement* root);
    HRESULT ElementFromHandle(void* hwnd, IUIAutomationElement* element);
    HRESULT ElementFromPoint(POINT pt, IUIAutomationElement* element);
    HRESULT GetFocusedElement(IUIAutomationElement* element);
    HRESULT GetRootElementBuildCache(IUIAutomationCacheRequest cacheRequest, IUIAutomationElement* root);
    HRESULT ElementFromHandleBuildCache(void* hwnd, IUIAutomationCacheRequest cacheRequest, IUIAutomationElement* element);
    HRESULT ElementFromPointBuildCache(POINT pt, IUIAutomationCacheRequest cacheRequest, IUIAutomationElement* element);
    HRESULT GetFocusedElementBuildCache(IUIAutomationCacheRequest cacheRequest, IUIAutomationElement* element);
    HRESULT CreateTreeWalker(IUIAutomationCondition pCondition, IUIAutomationTreeWalker* walker);
    HRESULT get_ControlViewWalker(IUIAutomationTreeWalker* walker);
    HRESULT get_ContentViewWalker(IUIAutomationTreeWalker* walker);
    HRESULT get_RawViewWalker(IUIAutomationTreeWalker* walker);
    HRESULT get_RawViewCondition(IUIAutomationCondition* condition);
    HRESULT get_ControlViewCondition(IUIAutomationCondition* condition);
    HRESULT get_ContentViewCondition(IUIAutomationCondition* condition);
    HRESULT CreateCacheRequest(IUIAutomationCacheRequest* cacheRequest);
    HRESULT CreateTrueCondition(IUIAutomationCondition* newCondition);
    HRESULT CreateFalseCondition(IUIAutomationCondition* newCondition);
    HRESULT CreatePropertyCondition(int propertyId, VARIANT value, IUIAutomationCondition* newCondition);
    HRESULT CreatePropertyConditionEx(int propertyId, VARIANT value, PropertyConditionFlags flags, IUIAutomationCondition* newCondition);
    HRESULT CreateAndCondition(IUIAutomationCondition condition1, IUIAutomationCondition condition2, IUIAutomationCondition* newCondition);
    HRESULT CreateAndConditionFromArray(SAFEARRAY* conditions, IUIAutomationCondition* newCondition);
    HRESULT CreateAndConditionFromNativeArray(char* conditions, int conditionCount, IUIAutomationCondition* newCondition);
    HRESULT CreateOrCondition(IUIAutomationCondition condition1, IUIAutomationCondition condition2, IUIAutomationCondition* newCondition);
    HRESULT CreateOrConditionFromArray(SAFEARRAY* conditions, IUIAutomationCondition* newCondition);
    HRESULT CreateOrConditionFromNativeArray(char* conditions, int conditionCount, IUIAutomationCondition* newCondition);
    HRESULT CreateNotCondition(IUIAutomationCondition condition, IUIAutomationCondition* newCondition);
    HRESULT AddAutomationEventHandler(int eventId, IUIAutomationElement element, TreeScope scope, IUIAutomationCacheRequest cacheRequest, IUIAutomationEventHandler handler);
    HRESULT RemoveAutomationEventHandler(int eventId, IUIAutomationElement element, IUIAutomationEventHandler handler);
    HRESULT AddPropertyChangedEventHandlerNativeArray(IUIAutomationElement element, TreeScope scope, IUIAutomationCacheRequest cacheRequest, IUIAutomationPropertyChangedEventHandler handler, char* propertyArray, int propertyCount);
    HRESULT AddPropertyChangedEventHandler(IUIAutomationElement element, TreeScope scope, IUIAutomationCacheRequest cacheRequest, IUIAutomationPropertyChangedEventHandler handler, SAFEARRAY* propertyArray);
    HRESULT RemovePropertyChangedEventHandler(IUIAutomationElement element, IUIAutomationPropertyChangedEventHandler handler);
    HRESULT AddStructureChangedEventHandler(IUIAutomationElement element, TreeScope scope, IUIAutomationCacheRequest cacheRequest, IUIAutomationStructureChangedEventHandler handler);
    HRESULT RemoveStructureChangedEventHandler(IUIAutomationElement element, IUIAutomationStructureChangedEventHandler handler);
    HRESULT AddFocusChangedEventHandler(IUIAutomationCacheRequest cacheRequest, IUIAutomationFocusChangedEventHandler handler);
    HRESULT RemoveFocusChangedEventHandler(IUIAutomationFocusChangedEventHandler handler);
    HRESULT RemoveAllEventHandlers();
    HRESULT IntNativeArrayToSafeArray(char* array, int arrayCount, SAFEARRAY** safeArray);
    HRESULT IntSafeArrayToNativeArray(SAFEARRAY* intArray, char* array, int* arrayCount);
    HRESULT RectToVariant(RECT rc, VARIANT* var);
    HRESULT VariantToRect(VARIANT var, RECT* rc);
    HRESULT SafeArrayToRectNativeArray(SAFEARRAY* rects, char* rectArray, int* rectArrayCount);
    HRESULT CreateProxyFactoryEntry(IUIAutomationProxyFactory factory, IUIAutomationProxyFactoryEntry* factoryEntry);
    HRESULT get_ProxyFactoryMapping(IUIAutomationProxyFactoryMapping* factoryMapping);
    HRESULT GetPropertyProgrammaticName(int property, BSTR* name);
    HRESULT GetPatternProgrammaticName(int pattern, BSTR* name);
    HRESULT PollForPotentialSupportedPatterns(IUIAutomationElement pElement, SAFEARRAY** patternIds, SAFEARRAY** patternNames);
    HRESULT PollForPotentialSupportedProperties(IUIAutomationElement pElement, SAFEARRAY** propertyIds, SAFEARRAY** propertyNames);
    HRESULT CheckNotSupported(VARIANT value, int* isNotSupported);
    HRESULT get_ReservedNotSupportedValue(IUnknown* notSupportedValue);
    HRESULT get_ReservedMixedAttributeValue(IUnknown* mixedAttributeValue);
    HRESULT ElementFromIAccessible(IAccessible accessible, int childId, IUIAutomationElement* element);
    HRESULT ElementFromIAccessibleBuildCache(IAccessible accessible, int childId, IUIAutomationCacheRequest cacheRequest, IUIAutomationElement* element);
}

const GUID IID_IUIAutomation2 = {0x34723AFF, 0x0C9D, 0x49D0, [0x98, 0x96, 0x7A, 0xB5, 0x2D, 0xF8, 0xCD, 0x8A]};
@GUID(0x34723AFF, 0x0C9D, 0x49D0, [0x98, 0x96, 0x7A, 0xB5, 0x2D, 0xF8, 0xCD, 0x8A]);
interface IUIAutomation2 : IUIAutomation
{
    HRESULT get_AutoSetFocus(int* autoSetFocus);
    HRESULT put_AutoSetFocus(BOOL autoSetFocus);
    HRESULT get_ConnectionTimeout(uint* timeout);
    HRESULT put_ConnectionTimeout(uint timeout);
    HRESULT get_TransactionTimeout(uint* timeout);
    HRESULT put_TransactionTimeout(uint timeout);
}

const GUID IID_IUIAutomation3 = {0x73D768DA, 0x9B51, 0x4B89, [0x93, 0x6E, 0xC2, 0x09, 0x29, 0x09, 0x73, 0xE7]};
@GUID(0x73D768DA, 0x9B51, 0x4B89, [0x93, 0x6E, 0xC2, 0x09, 0x29, 0x09, 0x73, 0xE7]);
interface IUIAutomation3 : IUIAutomation2
{
    HRESULT AddTextEditTextChangedEventHandler(IUIAutomationElement element, TreeScope scope, TextEditChangeType textEditChangeType, IUIAutomationCacheRequest cacheRequest, IUIAutomationTextEditTextChangedEventHandler handler);
    HRESULT RemoveTextEditTextChangedEventHandler(IUIAutomationElement element, IUIAutomationTextEditTextChangedEventHandler handler);
}

const GUID IID_IUIAutomation4 = {0x1189C02A, 0x05F8, 0x4319, [0x8E, 0x21, 0xE8, 0x17, 0xE3, 0xDB, 0x28, 0x60]};
@GUID(0x1189C02A, 0x05F8, 0x4319, [0x8E, 0x21, 0xE8, 0x17, 0xE3, 0xDB, 0x28, 0x60]);
interface IUIAutomation4 : IUIAutomation3
{
    HRESULT AddChangesEventHandler(IUIAutomationElement element, TreeScope scope, char* changeTypes, int changesCount, IUIAutomationCacheRequest pCacheRequest, IUIAutomationChangesEventHandler handler);
    HRESULT RemoveChangesEventHandler(IUIAutomationElement element, IUIAutomationChangesEventHandler handler);
}

const GUID IID_IUIAutomation5 = {0x25F700C8, 0xD816, 0x4057, [0xA9, 0xDC, 0x3C, 0xBD, 0xEE, 0x77, 0xE2, 0x56]};
@GUID(0x25F700C8, 0xD816, 0x4057, [0xA9, 0xDC, 0x3C, 0xBD, 0xEE, 0x77, 0xE2, 0x56]);
interface IUIAutomation5 : IUIAutomation4
{
    HRESULT AddNotificationEventHandler(IUIAutomationElement element, TreeScope scope, IUIAutomationCacheRequest cacheRequest, IUIAutomationNotificationEventHandler handler);
    HRESULT RemoveNotificationEventHandler(IUIAutomationElement element, IUIAutomationNotificationEventHandler handler);
}

const GUID IID_IUIAutomation6 = {0xAAE072DA, 0x29E3, 0x413D, [0x87, 0xA7, 0x19, 0x2D, 0xBF, 0x81, 0xED, 0x10]};
@GUID(0xAAE072DA, 0x29E3, 0x413D, [0x87, 0xA7, 0x19, 0x2D, 0xBF, 0x81, 0xED, 0x10]);
interface IUIAutomation6 : IUIAutomation5
{
    HRESULT CreateEventHandlerGroup(IUIAutomationEventHandlerGroup* handlerGroup);
    HRESULT AddEventHandlerGroup(IUIAutomationElement element, IUIAutomationEventHandlerGroup handlerGroup);
    HRESULT RemoveEventHandlerGroup(IUIAutomationElement element, IUIAutomationEventHandlerGroup handlerGroup);
    HRESULT get_ConnectionRecoveryBehavior(ConnectionRecoveryBehaviorOptions* connectionRecoveryBehaviorOptions);
    HRESULT put_ConnectionRecoveryBehavior(ConnectionRecoveryBehaviorOptions connectionRecoveryBehaviorOptions);
    HRESULT get_CoalesceEvents(CoalesceEventsOptions* coalesceEventsOptions);
    HRESULT put_CoalesceEvents(CoalesceEventsOptions coalesceEventsOptions);
    HRESULT AddActiveTextPositionChangedEventHandler(IUIAutomationElement element, TreeScope scope, IUIAutomationCacheRequest cacheRequest, IUIAutomationActiveTextPositionChangedEventHandler handler);
    HRESULT RemoveActiveTextPositionChangedEventHandler(IUIAutomationElement element, IUIAutomationActiveTextPositionChangedEventHandler handler);
}

