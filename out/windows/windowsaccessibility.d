module windows.windowsaccessibility;

public import windows.core;
public import windows.automation : BSTR, IDispatch, SAFEARRAY, VARIANT;
public import windows.com : HRESULT, IEnumUnknown, IUnknown;
public import windows.displaydevices : POINT, RECT;
public import windows.menusandresources : HMENU;
public import windows.systemservices : BOOL, LRESULT;
public import windows.textservices : IAnchor, ITextStoreACPSink, ITextStoreAnchorSink;
public import windows.windowsandmessaging : HWND, LPARAM, WPARAM;

extern(Windows):


// Enums


enum AnnoScope : int
{
    ANNO_THIS      = 0x00000000,
    ANNO_CONTAINER = 0x00000001,
}

enum NavigateDirection : int
{
    NavigateDirection_Parent          = 0x00000000,
    NavigateDirection_NextSibling     = 0x00000001,
    NavigateDirection_PreviousSibling = 0x00000002,
    NavigateDirection_FirstChild      = 0x00000003,
    NavigateDirection_LastChild       = 0x00000004,
}

enum ProviderOptions : int
{
    ProviderOptions_ClientSideProvider     = 0x00000001,
    ProviderOptions_ServerSideProvider     = 0x00000002,
    ProviderOptions_NonClientAreaProvider  = 0x00000004,
    ProviderOptions_OverrideProvider       = 0x00000008,
    ProviderOptions_ProviderOwnsSetFocus   = 0x00000010,
    ProviderOptions_UseComThreading        = 0x00000020,
    ProviderOptions_RefuseNonClientSupport = 0x00000040,
    ProviderOptions_HasNativeIAccessible   = 0x00000080,
    ProviderOptions_UseClientCoordinates   = 0x00000100,
}

enum StructureChangeType : int
{
    StructureChangeType_ChildAdded          = 0x00000000,
    StructureChangeType_ChildRemoved        = 0x00000001,
    StructureChangeType_ChildrenInvalidated = 0x00000002,
    StructureChangeType_ChildrenBulkAdded   = 0x00000003,
    StructureChangeType_ChildrenBulkRemoved = 0x00000004,
    StructureChangeType_ChildrenReordered   = 0x00000005,
}

enum TextEditChangeType : int
{
    TextEditChangeType_None                 = 0x00000000,
    TextEditChangeType_AutoCorrect          = 0x00000001,
    TextEditChangeType_Composition          = 0x00000002,
    TextEditChangeType_CompositionFinalized = 0x00000003,
    TextEditChangeType_AutoComplete         = 0x00000004,
}

enum OrientationType : int
{
    OrientationType_None       = 0x00000000,
    OrientationType_Horizontal = 0x00000001,
    OrientationType_Vertical   = 0x00000002,
}

enum DockPosition : int
{
    DockPosition_Top    = 0x00000000,
    DockPosition_Left   = 0x00000001,
    DockPosition_Bottom = 0x00000002,
    DockPosition_Right  = 0x00000003,
    DockPosition_Fill   = 0x00000004,
    DockPosition_None   = 0x00000005,
}

enum ExpandCollapseState : int
{
    ExpandCollapseState_Collapsed         = 0x00000000,
    ExpandCollapseState_Expanded          = 0x00000001,
    ExpandCollapseState_PartiallyExpanded = 0x00000002,
    ExpandCollapseState_LeafNode          = 0x00000003,
}

enum ScrollAmount : int
{
    ScrollAmount_LargeDecrement = 0x00000000,
    ScrollAmount_SmallDecrement = 0x00000001,
    ScrollAmount_NoAmount       = 0x00000002,
    ScrollAmount_LargeIncrement = 0x00000003,
    ScrollAmount_SmallIncrement = 0x00000004,
}

enum RowOrColumnMajor : int
{
    RowOrColumnMajor_RowMajor      = 0x00000000,
    RowOrColumnMajor_ColumnMajor   = 0x00000001,
    RowOrColumnMajor_Indeterminate = 0x00000002,
}

enum ToggleState : int
{
    ToggleState_Off           = 0x00000000,
    ToggleState_On            = 0x00000001,
    ToggleState_Indeterminate = 0x00000002,
}

enum WindowVisualState : int
{
    WindowVisualState_Normal    = 0x00000000,
    WindowVisualState_Maximized = 0x00000001,
    WindowVisualState_Minimized = 0x00000002,
}

enum SynchronizedInputType : int
{
    SynchronizedInputType_KeyUp          = 0x00000001,
    SynchronizedInputType_KeyDown        = 0x00000002,
    SynchronizedInputType_LeftMouseUp    = 0x00000004,
    SynchronizedInputType_LeftMouseDown  = 0x00000008,
    SynchronizedInputType_RightMouseUp   = 0x00000010,
    SynchronizedInputType_RightMouseDown = 0x00000020,
}

enum WindowInteractionState : int
{
    WindowInteractionState_Running                 = 0x00000000,
    WindowInteractionState_Closing                 = 0x00000001,
    WindowInteractionState_ReadyForUserInteraction = 0x00000002,
    WindowInteractionState_BlockedByModalWindow    = 0x00000003,
    WindowInteractionState_NotResponding           = 0x00000004,
}

enum SayAsInterpretAs : int
{
    SayAsInterpretAs_None                       = 0x00000000,
    SayAsInterpretAs_Spell                      = 0x00000001,
    SayAsInterpretAs_Cardinal                   = 0x00000002,
    SayAsInterpretAs_Ordinal                    = 0x00000003,
    SayAsInterpretAs_Number                     = 0x00000004,
    SayAsInterpretAs_Date                       = 0x00000005,
    SayAsInterpretAs_Time                       = 0x00000006,
    SayAsInterpretAs_Telephone                  = 0x00000007,
    SayAsInterpretAs_Currency                   = 0x00000008,
    SayAsInterpretAs_Net                        = 0x00000009,
    SayAsInterpretAs_Url                        = 0x0000000a,
    SayAsInterpretAs_Address                    = 0x0000000b,
    SayAsInterpretAs_Alphanumeric               = 0x0000000c,
    SayAsInterpretAs_Name                       = 0x0000000d,
    SayAsInterpretAs_Media                      = 0x0000000e,
    SayAsInterpretAs_Date_MonthDayYear          = 0x0000000f,
    SayAsInterpretAs_Date_DayMonthYear          = 0x00000010,
    SayAsInterpretAs_Date_YearMonthDay          = 0x00000011,
    SayAsInterpretAs_Date_YearMonth             = 0x00000012,
    SayAsInterpretAs_Date_MonthYear             = 0x00000013,
    SayAsInterpretAs_Date_DayMonth              = 0x00000014,
    SayAsInterpretAs_Date_MonthDay              = 0x00000015,
    SayAsInterpretAs_Date_Year                  = 0x00000016,
    SayAsInterpretAs_Time_HoursMinutesSeconds12 = 0x00000017,
    SayAsInterpretAs_Time_HoursMinutes12        = 0x00000018,
    SayAsInterpretAs_Time_HoursMinutesSeconds24 = 0x00000019,
    SayAsInterpretAs_Time_HoursMinutes24        = 0x0000001a,
}

enum TextUnit : int
{
    TextUnit_Character = 0x00000000,
    TextUnit_Format    = 0x00000001,
    TextUnit_Word      = 0x00000002,
    TextUnit_Line      = 0x00000003,
    TextUnit_Paragraph = 0x00000004,
    TextUnit_Page      = 0x00000005,
    TextUnit_Document  = 0x00000006,
}

enum TextPatternRangeEndpoint : int
{
    TextPatternRangeEndpoint_Start = 0x00000000,
    TextPatternRangeEndpoint_End   = 0x00000001,
}

enum SupportedTextSelection : int
{
    SupportedTextSelection_None     = 0x00000000,
    SupportedTextSelection_Single   = 0x00000001,
    SupportedTextSelection_Multiple = 0x00000002,
}

enum LiveSetting : int
{
    Off       = 0x00000000,
    Polite    = 0x00000001,
    Assertive = 0x00000002,
}

enum ActiveEnd : int
{
    ActiveEnd_None  = 0x00000000,
    ActiveEnd_Start = 0x00000001,
    ActiveEnd_End   = 0x00000002,
}

enum CaretPosition : int
{
    CaretPosition_Unknown         = 0x00000000,
    CaretPosition_EndOfLine       = 0x00000001,
    CaretPosition_BeginningOfLine = 0x00000002,
}

enum CaretBidiMode : int
{
    CaretBidiMode_LTR = 0x00000000,
    CaretBidiMode_RTL = 0x00000001,
}

enum ZoomUnit : int
{
    ZoomUnit_NoAmount       = 0x00000000,
    ZoomUnit_LargeDecrement = 0x00000001,
    ZoomUnit_SmallDecrement = 0x00000002,
    ZoomUnit_LargeIncrement = 0x00000003,
    ZoomUnit_SmallIncrement = 0x00000004,
}

enum AnimationStyle : int
{
    AnimationStyle_None               = 0x00000000,
    AnimationStyle_LasVegasLights     = 0x00000001,
    AnimationStyle_BlinkingBackground = 0x00000002,
    AnimationStyle_SparkleText        = 0x00000003,
    AnimationStyle_MarchingBlackAnts  = 0x00000004,
    AnimationStyle_MarchingRedAnts    = 0x00000005,
    AnimationStyle_Shimmer            = 0x00000006,
    AnimationStyle_Other              = 0xffffffff,
}

enum BulletStyle : int
{
    BulletStyle_None               = 0x00000000,
    BulletStyle_HollowRoundBullet  = 0x00000001,
    BulletStyle_FilledRoundBullet  = 0x00000002,
    BulletStyle_HollowSquareBullet = 0x00000003,
    BulletStyle_FilledSquareBullet = 0x00000004,
    BulletStyle_DashBullet         = 0x00000005,
    BulletStyle_Other              = 0xffffffff,
}

enum CapStyle : int
{
    CapStyle_None          = 0x00000000,
    CapStyle_SmallCap      = 0x00000001,
    CapStyle_AllCap        = 0x00000002,
    CapStyle_AllPetiteCaps = 0x00000003,
    CapStyle_PetiteCaps    = 0x00000004,
    CapStyle_Unicase       = 0x00000005,
    CapStyle_Titling       = 0x00000006,
    CapStyle_Other         = 0xffffffff,
}

enum FillType : int
{
    FillType_None     = 0x00000000,
    FillType_Color    = 0x00000001,
    FillType_Gradient = 0x00000002,
    FillType_Picture  = 0x00000003,
    FillType_Pattern  = 0x00000004,
}

enum FlowDirections : int
{
    FlowDirections_Default     = 0x00000000,
    FlowDirections_RightToLeft = 0x00000001,
    FlowDirections_BottomToTop = 0x00000002,
    FlowDirections_Vertical    = 0x00000004,
}

enum HorizontalTextAlignment : int
{
    HorizontalTextAlignment_Left      = 0x00000000,
    HorizontalTextAlignment_Centered  = 0x00000001,
    HorizontalTextAlignment_Right     = 0x00000002,
    HorizontalTextAlignment_Justified = 0x00000003,
}

enum OutlineStyles : int
{
    OutlineStyles_None     = 0x00000000,
    OutlineStyles_Outline  = 0x00000001,
    OutlineStyles_Shadow   = 0x00000002,
    OutlineStyles_Engraved = 0x00000004,
    OutlineStyles_Embossed = 0x00000008,
}

enum TextDecorationLineStyle : int
{
    TextDecorationLineStyle_None            = 0x00000000,
    TextDecorationLineStyle_Single          = 0x00000001,
    TextDecorationLineStyle_WordsOnly       = 0x00000002,
    TextDecorationLineStyle_Double          = 0x00000003,
    TextDecorationLineStyle_Dot             = 0x00000004,
    TextDecorationLineStyle_Dash            = 0x00000005,
    TextDecorationLineStyle_DashDot         = 0x00000006,
    TextDecorationLineStyle_DashDotDot      = 0x00000007,
    TextDecorationLineStyle_Wavy            = 0x00000008,
    TextDecorationLineStyle_ThickSingle     = 0x00000009,
    TextDecorationLineStyle_DoubleWavy      = 0x0000000b,
    TextDecorationLineStyle_ThickWavy       = 0x0000000c,
    TextDecorationLineStyle_LongDash        = 0x0000000d,
    TextDecorationLineStyle_ThickDash       = 0x0000000e,
    TextDecorationLineStyle_ThickDashDot    = 0x0000000f,
    TextDecorationLineStyle_ThickDashDotDot = 0x00000010,
    TextDecorationLineStyle_ThickDot        = 0x00000011,
    TextDecorationLineStyle_ThickLongDash   = 0x00000012,
    TextDecorationLineStyle_Other           = 0xffffffff,
}

enum VisualEffects : int
{
    VisualEffects_None       = 0x00000000,
    VisualEffects_Shadow     = 0x00000001,
    VisualEffects_Reflection = 0x00000002,
    VisualEffects_Glow       = 0x00000004,
    VisualEffects_SoftEdges  = 0x00000008,
    VisualEffects_Bevel      = 0x00000010,
}

enum NotificationProcessing : int
{
    NotificationProcessing_ImportantAll          = 0x00000000,
    NotificationProcessing_ImportantMostRecent   = 0x00000001,
    NotificationProcessing_All                   = 0x00000002,
    NotificationProcessing_MostRecent            = 0x00000003,
    NotificationProcessing_CurrentThenMostRecent = 0x00000004,
}

enum NotificationKind : int
{
    NotificationKind_ItemAdded       = 0x00000000,
    NotificationKind_ItemRemoved     = 0x00000001,
    NotificationKind_ActionCompleted = 0x00000002,
    NotificationKind_ActionAborted   = 0x00000003,
    NotificationKind_Other           = 0x00000004,
}

enum UIAutomationType : int
{
    UIAutomationType_Int             = 0x00000001,
    UIAutomationType_Bool            = 0x00000002,
    UIAutomationType_String          = 0x00000003,
    UIAutomationType_Double          = 0x00000004,
    UIAutomationType_Point           = 0x00000005,
    UIAutomationType_Rect            = 0x00000006,
    UIAutomationType_Element         = 0x00000007,
    UIAutomationType_Array           = 0x00010000,
    UIAutomationType_Out             = 0x00020000,
    UIAutomationType_IntArray        = 0x00010001,
    UIAutomationType_BoolArray       = 0x00010002,
    UIAutomationType_StringArray     = 0x00010003,
    UIAutomationType_DoubleArray     = 0x00010004,
    UIAutomationType_PointArray      = 0x00010005,
    UIAutomationType_RectArray       = 0x00010006,
    UIAutomationType_ElementArray    = 0x00010007,
    UIAutomationType_OutInt          = 0x00020001,
    UIAutomationType_OutBool         = 0x00020002,
    UIAutomationType_OutString       = 0x00020003,
    UIAutomationType_OutDouble       = 0x00020004,
    UIAutomationType_OutPoint        = 0x00020005,
    UIAutomationType_OutRect         = 0x00020006,
    UIAutomationType_OutElement      = 0x00020007,
    UIAutomationType_OutIntArray     = 0x00030001,
    UIAutomationType_OutBoolArray    = 0x00030002,
    UIAutomationType_OutStringArray  = 0x00030003,
    UIAutomationType_OutDoubleArray  = 0x00030004,
    UIAutomationType_OutPointArray   = 0x00030005,
    UIAutomationType_OutRectArray    = 0x00030006,
    UIAutomationType_OutElementArray = 0x00030007,
}

enum TreeScope : int
{
    TreeScope_None        = 0x00000000,
    TreeScope_Element     = 0x00000001,
    TreeScope_Children    = 0x00000002,
    TreeScope_Descendants = 0x00000004,
    TreeScope_Parent      = 0x00000008,
    TreeScope_Ancestors   = 0x00000010,
    TreeScope_Subtree     = 0x00000007,
}

enum ConditionType : int
{
    ConditionType_True     = 0x00000000,
    ConditionType_False    = 0x00000001,
    ConditionType_Property = 0x00000002,
    ConditionType_And      = 0x00000003,
    ConditionType_Or       = 0x00000004,
    ConditionType_Not      = 0x00000005,
}

enum PropertyConditionFlags : int
{
    PropertyConditionFlags_None           = 0x00000000,
    PropertyConditionFlags_IgnoreCase     = 0x00000001,
    PropertyConditionFlags_MatchSubstring = 0x00000002,
}

enum AutomationElementMode : int
{
    AutomationElementMode_None = 0x00000000,
    AutomationElementMode_Full = 0x00000001,
}

enum NormalizeState : int
{
    NormalizeState_None   = 0x00000000,
    NormalizeState_View   = 0x00000001,
    NormalizeState_Custom = 0x00000002,
}

enum TreeTraversalOptions : int
{
    TreeTraversalOptions_Default          = 0x00000000,
    TreeTraversalOptions_PostOrder        = 0x00000001,
    TreeTraversalOptions_LastToFirstOrder = 0x00000002,
}

enum ProviderType : int
{
    ProviderType_BaseHwnd      = 0x00000000,
    ProviderType_Proxy         = 0x00000001,
    ProviderType_NonClientArea = 0x00000002,
}

enum AutomationIdentifierType : int
{
    AutomationIdentifierType_Property      = 0x00000000,
    AutomationIdentifierType_Pattern       = 0x00000001,
    AutomationIdentifierType_Event         = 0x00000002,
    AutomationIdentifierType_ControlType   = 0x00000003,
    AutomationIdentifierType_TextAttribute = 0x00000004,
    AutomationIdentifierType_LandmarkType  = 0x00000005,
    AutomationIdentifierType_Annotation    = 0x00000006,
    AutomationIdentifierType_Changes       = 0x00000007,
    AutomationIdentifierType_Style         = 0x00000008,
}

enum EventArgsType : int
{
    EventArgsType_Simple                    = 0x00000000,
    EventArgsType_PropertyChanged           = 0x00000001,
    EventArgsType_StructureChanged          = 0x00000002,
    EventArgsType_AsyncContentLoaded        = 0x00000003,
    EventArgsType_WindowClosed              = 0x00000004,
    EventArgsType_TextEditTextChanged       = 0x00000005,
    EventArgsType_Changes                   = 0x00000006,
    EventArgsType_Notification              = 0x00000007,
    EventArgsType_ActiveTextPositionChanged = 0x00000008,
    EventArgsType_StructuredMarkup          = 0x00000009,
}

enum AsyncContentLoadedState : int
{
    AsyncContentLoadedState_Beginning = 0x00000000,
    AsyncContentLoadedState_Progress  = 0x00000001,
    AsyncContentLoadedState_Completed = 0x00000002,
}

// Constants


enum double UIA_ScrollPatternNoScroll = -0x1p+0;
enum int UIA_SelectionPatternId = 0x00002711;
enum int UIA_RangeValuePatternId = 0x00002713;
enum int UIA_ExpandCollapsePatternId = 0x00002715;
enum int UIA_GridItemPatternId = 0x00002717;
enum int UIA_WindowPatternId = 0x00002719;
enum int UIA_DockPatternId = 0x0000271b;
enum int UIA_TableItemPatternId = 0x0000271d;
enum int UIA_TogglePatternId = 0x0000271f;
enum int UIA_ScrollItemPatternId = 0x00002721;
enum int UIA_ItemContainerPatternId = 0x00002723;
enum int UIA_SynchronizedInputPatternId = 0x00002725;
enum int UIA_AnnotationPatternId = 0x00002727;
enum int UIA_StylesPatternId = 0x00002729;
enum int UIA_SpreadsheetItemPatternId = 0x0000272b;
enum int UIA_TextChildPatternId = 0x0000272d;
enum int UIA_DropTargetPatternId = 0x0000272f;
enum int UIA_CustomNavigationPatternId = 0x00002731;

enum : int
{
    UIA_ToolTipOpenedEventId = 0x00004e20,
    UIA_ToolTipClosedEventId = 0x00004e21,
}

enum int UIA_MenuOpenedEventId = 0x00004e23;
enum int UIA_AutomationFocusChangedEventId = 0x00004e25;
enum int UIA_MenuClosedEventId = 0x00004e27;
enum int UIA_Invoke_InvokedEventId = 0x00004e29;

enum : int
{
    UIA_SelectionItem_ElementRemovedFromSelectionEventId = 0x00004e2b,
    UIA_SelectionItem_ElementSelectedEventId             = 0x00004e2c,
}

enum int UIA_Text_TextSelectionChangedEventId = 0x00004e2e;

enum : int
{
    UIA_Window_WindowOpenedEventId = 0x00004e30,
    UIA_Window_WindowClosedEventId = 0x00004e31,
}

enum int UIA_MenuModeEndEventId = 0x00004e33;
enum int UIA_InputReachedOtherElementEventId = 0x00004e35;
enum int UIA_SystemAlertEventId = 0x00004e37;
enum int UIA_HostedFragmentRootsInvalidatedEventId = 0x00004e39;

enum : int
{
    UIA_Drag_DragCancelEventId   = 0x00004e3b,
    UIA_Drag_DragCompleteEventId = 0x00004e3c,
}

enum : int
{
    UIA_DropTarget_DragLeaveEventId = 0x00004e3e,
    UIA_DropTarget_DroppedEventId   = 0x00004e3f,
}

enum int UIA_TextEdit_ConversionTargetChangedEventId = 0x00004e41;
enum int UIA_NotificationEventId = 0x00004e43;
enum int UIA_RuntimeIdPropertyId = 0x00007530;
enum int UIA_ProcessIdPropertyId = 0x00007532;
enum int UIA_LocalizedControlTypePropertyId = 0x00007534;
enum int UIA_AcceleratorKeyPropertyId = 0x00007536;
enum int UIA_HasKeyboardFocusPropertyId = 0x00007538;
enum int UIA_IsEnabledPropertyId = 0x0000753a;
enum int UIA_ClassNamePropertyId = 0x0000753c;
enum int UIA_ClickablePointPropertyId = 0x0000753e;
enum int UIA_IsControlElementPropertyId = 0x00007540;
enum int UIA_LabeledByPropertyId = 0x00007542;
enum int UIA_NativeWindowHandlePropertyId = 0x00007544;
enum int UIA_IsOffscreenPropertyId = 0x00007546;
enum int UIA_FrameworkIdPropertyId = 0x00007548;
enum int UIA_ItemStatusPropertyId = 0x0000754a;
enum int UIA_IsExpandCollapsePatternAvailablePropertyId = 0x0000754c;
enum int UIA_IsGridPatternAvailablePropertyId = 0x0000754e;
enum int UIA_IsMultipleViewPatternAvailablePropertyId = 0x00007550;
enum int UIA_IsScrollPatternAvailablePropertyId = 0x00007552;
enum int UIA_IsSelectionItemPatternAvailablePropertyId = 0x00007554;
enum int UIA_IsTablePatternAvailablePropertyId = 0x00007556;
enum int UIA_IsTextPatternAvailablePropertyId = 0x00007558;
enum int UIA_IsTransformPatternAvailablePropertyId = 0x0000755a;
enum int UIA_IsWindowPatternAvailablePropertyId = 0x0000755c;
enum int UIA_ValueIsReadOnlyPropertyId = 0x0000755e;

enum : int
{
    UIA_RangeValueIsReadOnlyPropertyId  = 0x00007560,
    UIA_RangeValueMinimumPropertyId     = 0x00007561,
    UIA_RangeValueMaximumPropertyId     = 0x00007562,
    UIA_RangeValueLargeChangePropertyId = 0x00007563,
}

enum : int
{
    UIA_ScrollHorizontalScrollPercentPropertyId = 0x00007565,
    UIA_ScrollHorizontalViewSizePropertyId      = 0x00007566,
}

enum int UIA_ScrollVerticalViewSizePropertyId = 0x00007568;
enum int UIA_ScrollVerticallyScrollablePropertyId = 0x0000756a;
enum int UIA_SelectionCanSelectMultiplePropertyId = 0x0000756c;
enum int UIA_GridRowCountPropertyId = 0x0000756e;

enum : int
{
    UIA_GridItemRowPropertyId            = 0x00007570,
    UIA_GridItemColumnPropertyId         = 0x00007571,
    UIA_GridItemRowSpanPropertyId        = 0x00007572,
    UIA_GridItemColumnSpanPropertyId     = 0x00007573,
    UIA_GridItemContainingGridPropertyId = 0x00007574,
}

enum int UIA_ExpandCollapseExpandCollapseStatePropertyId = 0x00007576;
enum int UIA_MultipleViewSupportedViewsPropertyId = 0x00007578;
enum int UIA_WindowCanMinimizePropertyId = 0x0000757a;
enum int UIA_WindowWindowInteractionStatePropertyId = 0x0000757c;
enum int UIA_WindowIsTopmostPropertyId = 0x0000757e;
enum int UIA_SelectionItemSelectionContainerPropertyId = 0x00007580;
enum int UIA_TableColumnHeadersPropertyId = 0x00007582;
enum int UIA_TableItemRowHeaderItemsPropertyId = 0x00007584;
enum int UIA_ToggleToggleStatePropertyId = 0x00007586;

enum : int
{
    UIA_TransformCanResizePropertyId = 0x00007588,
    UIA_TransformCanRotatePropertyId = 0x00007589,
}

enum : int
{
    UIA_LegacyIAccessibleChildIdPropertyId          = 0x0000758b,
    UIA_LegacyIAccessibleNamePropertyId             = 0x0000758c,
    UIA_LegacyIAccessibleValuePropertyId            = 0x0000758d,
    UIA_LegacyIAccessibleDescriptionPropertyId      = 0x0000758e,
    UIA_LegacyIAccessibleRolePropertyId             = 0x0000758f,
    UIA_LegacyIAccessibleStatePropertyId            = 0x00007590,
    UIA_LegacyIAccessibleHelpPropertyId             = 0x00007591,
    UIA_LegacyIAccessibleKeyboardShortcutPropertyId = 0x00007592,
    UIA_LegacyIAccessibleSelectionPropertyId        = 0x00007593,
    UIA_LegacyIAccessibleDefaultActionPropertyId    = 0x00007594,
}

enum int UIA_AriaPropertiesPropertyId = 0x00007596;
enum int UIA_ControllerForPropertyId = 0x00007598;
enum int UIA_FlowsToPropertyId = 0x0000759a;
enum int UIA_IsItemContainerPatternAvailablePropertyId = 0x0000759c;
enum int UIA_IsSynchronizedInputPatternAvailablePropertyId = 0x0000759e;
enum int UIA_IsObjectModelPatternAvailablePropertyId = 0x000075a0;
enum int UIA_AnnotationAnnotationTypeNamePropertyId = 0x000075a2;

enum : int
{
    UIA_AnnotationDateTimePropertyId = 0x000075a4,
    UIA_AnnotationTargetPropertyId   = 0x000075a5,
}

enum int UIA_IsTextPattern2AvailablePropertyId = 0x000075a7;
enum int UIA_StylesStyleNamePropertyId = 0x000075a9;
enum int UIA_StylesFillPatternStylePropertyId = 0x000075ab;
enum int UIA_StylesFillPatternColorPropertyId = 0x000075ad;
enum int UIA_IsStylesPatternAvailablePropertyId = 0x000075af;

enum : int
{
    UIA_SpreadsheetItemFormulaPropertyId           = 0x000075b1,
    UIA_SpreadsheetItemAnnotationObjectsPropertyId = 0x000075b2,
    UIA_SpreadsheetItemAnnotationTypesPropertyId   = 0x000075b3,
}

enum int UIA_Transform2CanZoomPropertyId = 0x000075b5;
enum int UIA_LiveSettingPropertyId = 0x000075b7;
enum int UIA_IsDragPatternAvailablePropertyId = 0x000075b9;

enum : int
{
    UIA_DragDropEffectPropertyId  = 0x000075bb,
    UIA_DragDropEffectsPropertyId = 0x000075bc,
}

enum : int
{
    UIA_DropTargetDropTargetEffectPropertyId  = 0x000075be,
    UIA_DropTargetDropTargetEffectsPropertyId = 0x000075bf,
}

enum : int
{
    UIA_Transform2ZoomLevelPropertyId   = 0x000075c1,
    UIA_Transform2ZoomMinimumPropertyId = 0x000075c2,
    UIA_Transform2ZoomMaximumPropertyId = 0x000075c3,
}

enum int UIA_IsTextEditPatternAvailablePropertyId = 0x000075c5;
enum int UIA_IsCustomNavigationPatternAvailablePropertyId = 0x000075c7;
enum int UIA_SizeOfSetPropertyId = 0x000075c9;

enum : int
{
    UIA_AnnotationTypesPropertyId   = 0x000075cb,
    UIA_AnnotationObjectsPropertyId = 0x000075cc,
}

enum int UIA_LocalizedLandmarkTypePropertyId = 0x000075ce;
enum int UIA_FillColorPropertyId = 0x000075d0;
enum int UIA_FillTypePropertyId = 0x000075d2;
enum int UIA_OutlineThicknessPropertyId = 0x000075d4;
enum int UIA_RotationPropertyId = 0x000075d6;
enum int UIA_IsSelectionPattern2AvailablePropertyId = 0x000075d8;
enum int UIA_Selection2LastSelectedItemPropertyId = 0x000075da;
enum int UIA_Selection2ItemCountPropertyId = 0x000075dc;
enum int UIA_IsDialogPropertyId = 0x000075de;
enum int UIA_BackgroundColorAttributeId = 0x00009c41;
enum int UIA_CapStyleAttributeId = 0x00009c43;
enum int UIA_FontNameAttributeId = 0x00009c45;
enum int UIA_FontWeightAttributeId = 0x00009c47;
enum int UIA_HorizontalTextAlignmentAttributeId = 0x00009c49;

enum : int
{
    UIA_IndentationLeadingAttributeId  = 0x00009c4b,
    UIA_IndentationTrailingAttributeId = 0x00009c4c,
}

enum int UIA_IsItalicAttributeId = 0x00009c4e;
enum int UIA_IsSubscriptAttributeId = 0x00009c50;
enum int UIA_MarginBottomAttributeId = 0x00009c52;

enum : int
{
    UIA_MarginTopAttributeId      = 0x00009c54,
    UIA_MarginTrailingAttributeId = 0x00009c55,
}

enum : int
{
    UIA_OverlineColorAttributeId = 0x00009c57,
    UIA_OverlineStyleAttributeId = 0x00009c58,
}

enum int UIA_StrikethroughStyleAttributeId = 0x00009c5a;
enum int UIA_TextFlowDirectionsAttributeId = 0x00009c5c;
enum int UIA_UnderlineStyleAttributeId = 0x00009c5e;
enum int UIA_AnnotationObjectsAttributeId = 0x00009c60;
enum int UIA_StyleIdAttributeId = 0x00009c62;
enum int UIA_IsActiveAttributeId = 0x00009c64;
enum int UIA_CaretPositionAttributeId = 0x00009c66;
enum int UIA_LineSpacingAttributeId = 0x00009c68;
enum int UIA_AfterParagraphSpacingAttributeId = 0x00009c6a;
enum int UIA_ButtonControlTypeId = 0x0000c350;
enum int UIA_CheckBoxControlTypeId = 0x0000c352;
enum int UIA_EditControlTypeId = 0x0000c354;
enum int UIA_ImageControlTypeId = 0x0000c356;
enum int UIA_ListControlTypeId = 0x0000c358;
enum int UIA_MenuBarControlTypeId = 0x0000c35a;
enum int UIA_ProgressBarControlTypeId = 0x0000c35c;
enum int UIA_ScrollBarControlTypeId = 0x0000c35e;
enum int UIA_SpinnerControlTypeId = 0x0000c360;
enum int UIA_TabControlTypeId = 0x0000c362;
enum int UIA_TextControlTypeId = 0x0000c364;
enum int UIA_ToolTipControlTypeId = 0x0000c366;
enum int UIA_TreeItemControlTypeId = 0x0000c368;
enum int UIA_GroupControlTypeId = 0x0000c36a;
enum int UIA_DataGridControlTypeId = 0x0000c36c;
enum int UIA_DocumentControlTypeId = 0x0000c36e;
enum int UIA_WindowControlTypeId = 0x0000c370;

enum : int
{
    UIA_HeaderControlTypeId     = 0x0000c372,
    UIA_HeaderItemControlTypeId = 0x0000c373,
}

enum int UIA_TitleBarControlTypeId = 0x0000c375;
enum int UIA_SemanticZoomControlTypeId = 0x0000c377;

enum : int
{
    AnnotationType_Unknown                = 0x0000ea60,
    AnnotationType_SpellingError          = 0x0000ea61,
    AnnotationType_GrammarError           = 0x0000ea62,
    AnnotationType_Comment                = 0x0000ea63,
    AnnotationType_FormulaError           = 0x0000ea64,
    AnnotationType_TrackChanges           = 0x0000ea65,
    AnnotationType_Header                 = 0x0000ea66,
    AnnotationType_Footer                 = 0x0000ea67,
    AnnotationType_Highlighted            = 0x0000ea68,
    AnnotationType_Endnote                = 0x0000ea69,
    AnnotationType_Footnote               = 0x0000ea6a,
    AnnotationType_InsertionChange        = 0x0000ea6b,
    AnnotationType_DeletionChange         = 0x0000ea6c,
    AnnotationType_MoveChange             = 0x0000ea6d,
    AnnotationType_FormatChange           = 0x0000ea6e,
    AnnotationType_UnsyncedChange         = 0x0000ea6f,
    AnnotationType_EditingLockedChange    = 0x0000ea70,
    AnnotationType_ExternalChange         = 0x0000ea71,
    AnnotationType_ConflictingChange      = 0x0000ea72,
    AnnotationType_Author                 = 0x0000ea73,
    AnnotationType_AdvancedProofingIssue  = 0x0000ea74,
    AnnotationType_DataValidationError    = 0x0000ea75,
    AnnotationType_CircularReferenceError = 0x0000ea76,
    AnnotationType_Mathematics            = 0x0000ea77,
    AnnotationType_Sensitive              = 0x0000ea78,
}

enum : int
{
    StyleId_Heading1     = 0x00011171,
    StyleId_Heading2     = 0x00011172,
    StyleId_Heading3     = 0x00011173,
    StyleId_Heading4     = 0x00011174,
    StyleId_Heading5     = 0x00011175,
    StyleId_Heading6     = 0x00011176,
    StyleId_Heading7     = 0x00011177,
    StyleId_Heading8     = 0x00011178,
    StyleId_Heading9     = 0x00011179,
    StyleId_Title        = 0x0001117a,
    StyleId_Subtitle     = 0x0001117b,
    StyleId_Normal       = 0x0001117c,
    StyleId_Emphasis     = 0x0001117d,
    StyleId_Quote        = 0x0001117e,
    StyleId_BulletedList = 0x0001117f,
}

enum int UIA_CustomLandmarkTypeId = 0x00013880;
enum int UIA_MainLandmarkTypeId = 0x00013882;
enum int UIA_SearchLandmarkTypeId = 0x00013884;

enum : int
{
    HeadingLevel1 = 0x000138b3,
    HeadingLevel2 = 0x000138b4,
    HeadingLevel3 = 0x000138b5,
    HeadingLevel4 = 0x000138b6,
    HeadingLevel5 = 0x000138b7,
    HeadingLevel6 = 0x000138b8,
    HeadingLevel7 = 0x000138b9,
    HeadingLevel8 = 0x000138ba,
    HeadingLevel9 = 0x000138bb,
}

enum int UIA_SayAsInterpretAsMetadataId = 0x000186a0;

// Callbacks

alias WINEVENTPROC = void function(ptrdiff_t hWinEventHook, uint event, HWND hwnd, int idObject, int idChild, 
                                   uint idEventThread, uint dwmsEventTime);
alias LPFNLRESULTFROMOBJECT = LRESULT function(const(GUID)* riid, WPARAM wParam, IUnknown punk);
alias LPFNOBJECTFROMLRESULT = HRESULT function(LRESULT lResult, const(GUID)* riid, WPARAM wParam, void** ppvObject);
alias LPFNACCESSIBLEOBJECTFROMWINDOW = HRESULT function(HWND hwnd, uint dwId, const(GUID)* riid, void** ppvObject);
alias LPFNACCESSIBLEOBJECTFROMPOINT = HRESULT function(POINT ptScreen, IAccessible* ppacc, VARIANT* pvarChild);
alias LPFNCREATESTDACCESSIBLEOBJECT = HRESULT function(HWND hwnd, int idObject, const(GUID)* riid, 
                                                       void** ppvObject);
alias LPFNACCESSIBLECHILDREN = HRESULT function(IAccessible paccContainer, int iChildStart, int cChildren, 
                                                VARIANT* rgvarChildren, int* pcObtained);
alias UiaProviderCallback = SAFEARRAY* function(HWND hwnd, ProviderType providerType);
alias UiaEventCallback = void function(UiaEventArgs* pArgs, SAFEARRAY* pRequestedData, BSTR pTreeStructure);

// Structs


struct SERIALKEYSA
{
    uint         cbSize;
    uint         dwFlags;
    const(char)* lpszActivePort;
    const(char)* lpszPort;
    uint         iBaudRate;
    uint         iPortState;
    uint         iActive;
}

struct SERIALKEYSW
{
    uint          cbSize;
    uint          dwFlags;
    const(wchar)* lpszActivePort;
    const(wchar)* lpszPort;
    uint          iBaudRate;
    uint          iPortState;
    uint          iActive;
}

struct HIGHCONTRASTA
{
    uint         cbSize;
    uint         dwFlags;
    const(char)* lpszDefaultScheme;
}

struct HIGHCONTRASTW
{
    uint          cbSize;
    uint          dwFlags;
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
    uint         cbSize;
    uint         dwFlags;
    uint         iFSTextEffect;
    uint         iFSTextEffectMSec;
    uint         iFSTextEffectColorBits;
    uint         iFSGrafEffect;
    uint         iFSGrafEffectMSec;
    uint         iFSGrafEffectColor;
    uint         iWindowsEffect;
    uint         iWindowsEffectMSec;
    const(char)* lpszWindowsEffectDLL;
    uint         iWindowsEffectOrdinal;
}

struct SOUNDSENTRYW
{
    uint          cbSize;
    uint          dwFlags;
    uint          iFSTextEffect;
    uint          iFSTextEffectMSec;
    uint          iFSTextEffectColorBits;
    uint          iFSGrafEffect;
    uint          iFSGrafEffectMSec;
    uint          iFSGrafEffectColor;
    uint          iWindowsEffect;
    uint          iWindowsEffectMSec;
    const(wchar)* lpszWindowsEffectDLL;
    uint          iWindowsEffectOrdinal;
}

struct TOGGLEKEYS
{
    uint cbSize;
    uint dwFlags;
}

struct MSAAMENUINFO
{
    uint          dwMSAASignature;
    uint          cchWText;
    const(wchar)* pszWText;
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
    int     uiaId;
    VARIANT payload;
    VARIANT extraInfo;
}

struct UIAutomationParameter
{
    UIAutomationType type;
    void*            pData;
}

struct UIAutomationPropertyInfo
{
    GUID             guid;
    const(wchar)*    pProgrammaticName;
    UIAutomationType type;
}

struct UIAutomationEventInfo
{
    GUID          guid;
    const(wchar)* pProgrammaticName;
}

struct UIAutomationMethodInfo
{
    const(wchar)*     pProgrammaticName;
    BOOL              doSetFocus;
    uint              cInParameters;
    uint              cOutParameters;
    UIAutomationType* pParameterTypes;
    ushort**          pParameterNames;
}

struct UIAutomationPatternInfo
{
    GUID          guid;
    const(wchar)* pProgrammaticName;
    GUID          providerInterfaceId;
    GUID          clientInterfaceId;
    uint          cProperties;
    UIAutomationPropertyInfo* pProperties;
    uint          cMethods;
    UIAutomationMethodInfo* pMethods;
    uint          cEvents;
    UIAutomationEventInfo* pEvents;
    IUIAutomationPatternHandler pPatternHandler;
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

struct UiaCondition
{
    ConditionType ConditionType200;
}

struct UiaPropertyCondition
{
    ConditionType ConditionType201;
    int           PropertyId;
    VARIANT       Value;
    PropertyConditionFlags Flags;
}

struct UiaAndOrCondition
{
    ConditionType  ConditionType202;
    UiaCondition** ppConditions;
    int            cConditions;
}

struct UiaNotCondition
{
    ConditionType ConditionType203;
    UiaCondition* pCondition;
}

struct UiaCacheRequest
{
    UiaCondition* pViewCondition;
    TreeScope     Scope;
    int*          pProperties;
    int           cProperties;
    int*          pPatterns;
    int           cPatterns;
    AutomationElementMode automationElementMode;
}

struct UiaFindParams
{
    int           MaxDepth;
    BOOL          FindFirst;
    BOOL          ExcludeRoot;
    UiaCondition* pFindCondition;
}

struct UiaEventArgs
{
    EventArgsType Type;
    int           EventId;
}

struct UiaPropertyChangedEventArgs
{
    EventArgsType Type;
    int           EventId;
    int           PropertyId;
    VARIANT       OldValue;
    VARIANT       NewValue;
}

struct UiaStructureChangedEventArgs
{
    EventArgsType       Type;
    int                 EventId;
    StructureChangeType StructureChangeType204;
    int*                pRuntimeId;
    int                 cRuntimeIdLen;
}

struct UiaTextEditTextChangedEventArgs
{
    EventArgsType      Type;
    int                EventId;
    TextEditChangeType TextEditChangeType205;
    SAFEARRAY*         pTextChange;
}

struct UiaChangesEventArgs
{
    EventArgsType  Type;
    int            EventId;
    int            EventIdCount;
    UiaChangeInfo* pUiaChanges;
}

struct UiaAsyncContentLoadedEventArgs
{
    EventArgsType Type;
    int           EventId;
    AsyncContentLoadedState AsyncContentLoadedState206;
    double        PercentComplete;
}

struct UiaWindowClosedEventArgs
{
    EventArgsType Type;
    int           EventId;
    int*          pRuntimeId;
    int           cRuntimeIdLen;
}

struct ExtendedProperty
{
    BSTR PropertyName;
    BSTR PropertyValue;
}

// Functions

@DllImport("USER32")
BOOL RegisterPointerInputTarget(HWND hwnd, uint pointerType);

@DllImport("USER32")
BOOL UnregisterPointerInputTarget(HWND hwnd, uint pointerType);

@DllImport("USER32")
BOOL RegisterPointerInputTargetEx(HWND hwnd, uint pointerType, BOOL fObserve);

@DllImport("USER32")
BOOL UnregisterPointerInputTargetEx(HWND hwnd, uint pointerType);

@DllImport("USER32")
void NotifyWinEvent(uint event, HWND hwnd, int idObject, int idChild);

@DllImport("USER32")
ptrdiff_t SetWinEventHook(uint eventMin, uint eventMax, ptrdiff_t hmodWinEventProc, WINEVENTPROC pfnWinEventProc, 
                          uint idProcess, uint idThread, uint dwFlags);

@DllImport("USER32")
BOOL IsWinEventHookInstalled(uint event);

@DllImport("USER32")
BOOL UnhookWinEvent(ptrdiff_t hWinEventHook);

@DllImport("OLEACC")
LRESULT LresultFromObject(const(GUID)* riid, WPARAM wParam, IUnknown punk);

@DllImport("OLEACC")
HRESULT ObjectFromLresult(LRESULT lResult, const(GUID)* riid, WPARAM wParam, void** ppvObject);

@DllImport("OLEACC")
HRESULT WindowFromAccessibleObject(IAccessible param0, HWND* phwnd);

@DllImport("OLEACC")
HRESULT AccessibleObjectFromWindow(HWND hwnd, uint dwId, const(GUID)* riid, void** ppvObject);

@DllImport("OLEACC")
HRESULT AccessibleObjectFromEvent(HWND hwnd, uint dwId, uint dwChildId, IAccessible* ppacc, VARIANT* pvarChild);

@DllImport("OLEACC")
HRESULT AccessibleObjectFromPoint(POINT ptScreen, IAccessible* ppacc, VARIANT* pvarChild);

@DllImport("OLEACC")
HRESULT AccessibleChildren(IAccessible paccContainer, int iChildStart, int cChildren, char* rgvarChildren, 
                           int* pcObtained);

@DllImport("OLEACC")
uint GetRoleTextA(uint lRole, const(char)* lpszRole, uint cchRoleMax);

@DllImport("OLEACC")
uint GetRoleTextW(uint lRole, const(wchar)* lpszRole, uint cchRoleMax);

@DllImport("OLEACC")
uint GetStateTextA(uint lStateBit, const(char)* lpszState, uint cchState);

@DllImport("OLEACC")
uint GetStateTextW(uint lStateBit, const(wchar)* lpszState, uint cchState);

@DllImport("OLEACC")
void GetOleaccVersionInfo(uint* pVer, uint* pBuild);

@DllImport("OLEACC")
HRESULT CreateStdAccessibleObject(HWND hwnd, int idObject, const(GUID)* riid, void** ppvObject);

@DllImport("OLEACC")
HRESULT CreateStdAccessibleProxyA(HWND hwnd, const(char)* pClassName, int idObject, const(GUID)* riid, 
                                  void** ppvObject);

@DllImport("OLEACC")
HRESULT CreateStdAccessibleProxyW(HWND hwnd, const(wchar)* pClassName, int idObject, const(GUID)* riid, 
                                  void** ppvObject);

@DllImport("OLEACC")
HRESULT AccSetRunningUtilityState(HWND hwndApp, uint dwUtilityStateMask, uint dwUtilityState);

@DllImport("OLEACC")
HRESULT AccNotifyTouchInteraction(HWND hwndApp, HWND hwndTarget, POINT ptTarget);

@DllImport("UIAutomationCore")
BOOL UiaGetErrorDescription(BSTR* pDescription);

@DllImport("UIAutomationCore")
HRESULT UiaHUiaNodeFromVariant(VARIANT* pvar, HUIANODE__** phnode);

@DllImport("UIAutomationCore")
HRESULT UiaHPatternObjectFromVariant(VARIANT* pvar, HUIAPATTERNOBJECT__** phobj);

@DllImport("UIAutomationCore")
HRESULT UiaHTextRangeFromVariant(VARIANT* pvar, HUIATEXTRANGE__** phtextrange);

@DllImport("UIAutomationCore")
BOOL UiaNodeRelease(HUIANODE__* hnode);

@DllImport("UIAutomationCore")
HRESULT UiaGetPropertyValue(HUIANODE__* hnode, int propertyId, VARIANT* pValue);

@DllImport("UIAutomationCore")
HRESULT UiaGetPatternProvider(HUIANODE__* hnode, int patternId, HUIAPATTERNOBJECT__** phobj);

@DllImport("UIAutomationCore")
HRESULT UiaGetRuntimeId(HUIANODE__* hnode, SAFEARRAY** pruntimeId);

@DllImport("UIAutomationCore")
HRESULT UiaSetFocus(HUIANODE__* hnode);

@DllImport("UIAutomationCore")
HRESULT UiaNavigate(HUIANODE__* hnode, NavigateDirection direction, UiaCondition* pCondition, 
                    UiaCacheRequest* pRequest, SAFEARRAY** ppRequestedData, BSTR* ppTreeStructure);

@DllImport("UIAutomationCore")
HRESULT UiaGetUpdatedCache(HUIANODE__* hnode, UiaCacheRequest* pRequest, NormalizeState normalizeState, 
                           UiaCondition* pNormalizeCondition, SAFEARRAY** ppRequestedData, BSTR* ppTreeStructure);

@DllImport("UIAutomationCore")
HRESULT UiaFind(HUIANODE__* hnode, UiaFindParams* pParams, UiaCacheRequest* pRequest, SAFEARRAY** ppRequestedData, 
                SAFEARRAY** ppOffsets, SAFEARRAY** ppTreeStructures);

@DllImport("UIAutomationCore")
HRESULT UiaNodeFromPoint(double x, double y, UiaCacheRequest* pRequest, SAFEARRAY** ppRequestedData, 
                         BSTR* ppTreeStructure);

@DllImport("UIAutomationCore")
HRESULT UiaNodeFromFocus(UiaCacheRequest* pRequest, SAFEARRAY** ppRequestedData, BSTR* ppTreeStructure);

@DllImport("UIAutomationCore")
HRESULT UiaNodeFromHandle(HWND hwnd, HUIANODE__** phnode);

@DllImport("UIAutomationCore")
HRESULT UiaNodeFromProvider(IRawElementProviderSimple pProvider, HUIANODE__** phnode);

@DllImport("UIAutomationCore")
HRESULT UiaGetRootNode(HUIANODE__** phnode);

@DllImport("UIAutomationCore")
void UiaRegisterProviderCallback(UiaProviderCallback* pCallback);

@DllImport("UIAutomationCore")
int UiaLookupId(AutomationIdentifierType type, const(GUID)* pGuid);

@DllImport("UIAutomationCore")
HRESULT UiaGetReservedNotSupportedValue(IUnknown* punkNotSupportedValue);

@DllImport("UIAutomationCore")
HRESULT UiaGetReservedMixedAttributeValue(IUnknown* punkMixedAttributeValue);

@DllImport("UIAutomationCore")
BOOL UiaClientsAreListening();

@DllImport("UIAutomationCore")
HRESULT UiaRaiseAutomationPropertyChangedEvent(IRawElementProviderSimple pProvider, int id, VARIANT oldValue, 
                                               VARIANT newValue);

@DllImport("UIAutomationCore")
HRESULT UiaRaiseAutomationEvent(IRawElementProviderSimple pProvider, int id);

@DllImport("UIAutomationCore")
HRESULT UiaRaiseStructureChangedEvent(IRawElementProviderSimple pProvider, StructureChangeType structureChangeType, 
                                      int* pRuntimeId, int cRuntimeIdLen);

@DllImport("UIAutomationCore")
HRESULT UiaRaiseAsyncContentLoadedEvent(IRawElementProviderSimple pProvider, 
                                        AsyncContentLoadedState asyncContentLoadedState, double percentComplete);

@DllImport("UIAutomationCore")
HRESULT UiaRaiseTextEditTextChangedEvent(IRawElementProviderSimple pProvider, 
                                         TextEditChangeType textEditChangeType, SAFEARRAY* pChangedData);

@DllImport("UIAutomationCore")
HRESULT UiaRaiseChangesEvent(IRawElementProviderSimple pProvider, int eventIdCount, UiaChangeInfo* pUiaChanges);

@DllImport("UIAutomationCore")
HRESULT UiaRaiseNotificationEvent(IRawElementProviderSimple provider, NotificationKind notificationKind, 
                                  NotificationProcessing notificationProcessing, BSTR displayString, BSTR activityId);

@DllImport("UIAutomationCore")
HRESULT UiaRaiseActiveTextPositionChangedEvent(IRawElementProviderSimple provider, ITextRangeProvider textRange);

@DllImport("UIAutomationCore")
HRESULT UiaAddEvent(HUIANODE__* hnode, int eventId, UiaEventCallback* pCallback, TreeScope scope_, 
                    int* pProperties, int cProperties, UiaCacheRequest* pRequest, HUIAEVENT__** phEvent);

@DllImport("UIAutomationCore")
HRESULT UiaRemoveEvent(HUIAEVENT__* hEvent);

@DllImport("UIAutomationCore")
HRESULT UiaEventAddWindow(HUIAEVENT__* hEvent, HWND hwnd);

@DllImport("UIAutomationCore")
HRESULT UiaEventRemoveWindow(HUIAEVENT__* hEvent, HWND hwnd);

@DllImport("UIAutomationCore")
HRESULT DockPattern_SetDockPosition(HUIAPATTERNOBJECT__* hobj, DockPosition dockPosition);

@DllImport("UIAutomationCore")
HRESULT ExpandCollapsePattern_Collapse(HUIAPATTERNOBJECT__* hobj);

@DllImport("UIAutomationCore")
HRESULT ExpandCollapsePattern_Expand(HUIAPATTERNOBJECT__* hobj);

@DllImport("UIAutomationCore")
HRESULT GridPattern_GetItem(HUIAPATTERNOBJECT__* hobj, int row, int column, HUIANODE__** pResult);

@DllImport("UIAutomationCore")
HRESULT InvokePattern_Invoke(HUIAPATTERNOBJECT__* hobj);

@DllImport("UIAutomationCore")
HRESULT MultipleViewPattern_GetViewName(HUIAPATTERNOBJECT__* hobj, int viewId, BSTR* ppStr);

@DllImport("UIAutomationCore")
HRESULT MultipleViewPattern_SetCurrentView(HUIAPATTERNOBJECT__* hobj, int viewId);

@DllImport("UIAutomationCore")
HRESULT RangeValuePattern_SetValue(HUIAPATTERNOBJECT__* hobj, double val);

@DllImport("UIAutomationCore")
HRESULT ScrollItemPattern_ScrollIntoView(HUIAPATTERNOBJECT__* hobj);

@DllImport("UIAutomationCore")
HRESULT ScrollPattern_Scroll(HUIAPATTERNOBJECT__* hobj, ScrollAmount horizontalAmount, ScrollAmount verticalAmount);

@DllImport("UIAutomationCore")
HRESULT ScrollPattern_SetScrollPercent(HUIAPATTERNOBJECT__* hobj, double horizontalPercent, double verticalPercent);

@DllImport("UIAutomationCore")
HRESULT SelectionItemPattern_AddToSelection(HUIAPATTERNOBJECT__* hobj);

@DllImport("UIAutomationCore")
HRESULT SelectionItemPattern_RemoveFromSelection(HUIAPATTERNOBJECT__* hobj);

@DllImport("UIAutomationCore")
HRESULT SelectionItemPattern_Select(HUIAPATTERNOBJECT__* hobj);

@DllImport("UIAutomationCore")
HRESULT TogglePattern_Toggle(HUIAPATTERNOBJECT__* hobj);

@DllImport("UIAutomationCore")
HRESULT TransformPattern_Move(HUIAPATTERNOBJECT__* hobj, double x, double y);

@DllImport("UIAutomationCore")
HRESULT TransformPattern_Resize(HUIAPATTERNOBJECT__* hobj, double width, double height);

@DllImport("UIAutomationCore")
HRESULT TransformPattern_Rotate(HUIAPATTERNOBJECT__* hobj, double degrees);

@DllImport("UIAutomationCore")
HRESULT ValuePattern_SetValue(HUIAPATTERNOBJECT__* hobj, const(wchar)* pVal);

@DllImport("UIAutomationCore")
HRESULT WindowPattern_Close(HUIAPATTERNOBJECT__* hobj);

@DllImport("UIAutomationCore")
HRESULT WindowPattern_SetWindowVisualState(HUIAPATTERNOBJECT__* hobj, WindowVisualState state);

@DllImport("UIAutomationCore")
HRESULT WindowPattern_WaitForInputIdle(HUIAPATTERNOBJECT__* hobj, int milliseconds, int* pResult);

@DllImport("UIAutomationCore")
HRESULT TextPattern_GetSelection(HUIAPATTERNOBJECT__* hobj, SAFEARRAY** pRetVal);

@DllImport("UIAutomationCore")
HRESULT TextPattern_GetVisibleRanges(HUIAPATTERNOBJECT__* hobj, SAFEARRAY** pRetVal);

@DllImport("UIAutomationCore")
HRESULT TextPattern_RangeFromChild(HUIAPATTERNOBJECT__* hobj, HUIANODE__* hnodeChild, HUIATEXTRANGE__** pRetVal);

@DllImport("UIAutomationCore")
HRESULT TextPattern_RangeFromPoint(HUIAPATTERNOBJECT__* hobj, UiaPoint point, HUIATEXTRANGE__** pRetVal);

@DllImport("UIAutomationCore")
HRESULT TextPattern_get_DocumentRange(HUIAPATTERNOBJECT__* hobj, HUIATEXTRANGE__** pRetVal);

@DllImport("UIAutomationCore")
HRESULT TextPattern_get_SupportedTextSelection(HUIAPATTERNOBJECT__* hobj, SupportedTextSelection* pRetVal);

@DllImport("UIAutomationCore")
HRESULT TextRange_Clone(HUIATEXTRANGE__* hobj, HUIATEXTRANGE__** pRetVal);

@DllImport("UIAutomationCore")
HRESULT TextRange_Compare(HUIATEXTRANGE__* hobj, HUIATEXTRANGE__* range, int* pRetVal);

@DllImport("UIAutomationCore")
HRESULT TextRange_CompareEndpoints(HUIATEXTRANGE__* hobj, TextPatternRangeEndpoint endpoint, 
                                   HUIATEXTRANGE__* targetRange, TextPatternRangeEndpoint targetEndpoint, 
                                   int* pRetVal);

@DllImport("UIAutomationCore")
HRESULT TextRange_ExpandToEnclosingUnit(HUIATEXTRANGE__* hobj, TextUnit unit);

@DllImport("UIAutomationCore")
HRESULT TextRange_GetAttributeValue(HUIATEXTRANGE__* hobj, int attributeId, VARIANT* pRetVal);

@DllImport("UIAutomationCore")
HRESULT TextRange_FindAttribute(HUIATEXTRANGE__* hobj, int attributeId, VARIANT val, BOOL backward, 
                                HUIATEXTRANGE__** pRetVal);

@DllImport("UIAutomationCore")
HRESULT TextRange_FindText(HUIATEXTRANGE__* hobj, BSTR text, BOOL backward, BOOL ignoreCase, 
                           HUIATEXTRANGE__** pRetVal);

@DllImport("UIAutomationCore")
HRESULT TextRange_GetBoundingRectangles(HUIATEXTRANGE__* hobj, SAFEARRAY** pRetVal);

@DllImport("UIAutomationCore")
HRESULT TextRange_GetEnclosingElement(HUIATEXTRANGE__* hobj, HUIANODE__** pRetVal);

@DllImport("UIAutomationCore")
HRESULT TextRange_GetText(HUIATEXTRANGE__* hobj, int maxLength, BSTR* pRetVal);

@DllImport("UIAutomationCore")
HRESULT TextRange_Move(HUIATEXTRANGE__* hobj, TextUnit unit, int count, int* pRetVal);

@DllImport("UIAutomationCore")
HRESULT TextRange_MoveEndpointByUnit(HUIATEXTRANGE__* hobj, TextPatternRangeEndpoint endpoint, TextUnit unit, 
                                     int count, int* pRetVal);

@DllImport("UIAutomationCore")
HRESULT TextRange_MoveEndpointByRange(HUIATEXTRANGE__* hobj, TextPatternRangeEndpoint endpoint, 
                                      HUIATEXTRANGE__* targetRange, TextPatternRangeEndpoint targetEndpoint);

@DllImport("UIAutomationCore")
HRESULT TextRange_Select(HUIATEXTRANGE__* hobj);

@DllImport("UIAutomationCore")
HRESULT TextRange_AddToSelection(HUIATEXTRANGE__* hobj);

@DllImport("UIAutomationCore")
HRESULT TextRange_RemoveFromSelection(HUIATEXTRANGE__* hobj);

@DllImport("UIAutomationCore")
HRESULT TextRange_ScrollIntoView(HUIATEXTRANGE__* hobj, BOOL alignToTop);

@DllImport("UIAutomationCore")
HRESULT TextRange_GetChildren(HUIATEXTRANGE__* hobj, SAFEARRAY** pRetVal);

@DllImport("UIAutomationCore")
HRESULT ItemContainerPattern_FindItemByProperty(HUIAPATTERNOBJECT__* hobj, HUIANODE__* hnodeStartAfter, 
                                                int propertyId, VARIANT value, HUIANODE__** pFound);

@DllImport("UIAutomationCore")
HRESULT LegacyIAccessiblePattern_Select(HUIAPATTERNOBJECT__* hobj, int flagsSelect);

@DllImport("UIAutomationCore")
HRESULT LegacyIAccessiblePattern_DoDefaultAction(HUIAPATTERNOBJECT__* hobj);

@DllImport("UIAutomationCore")
HRESULT LegacyIAccessiblePattern_SetValue(HUIAPATTERNOBJECT__* hobj, const(wchar)* szValue);

@DllImport("UIAutomationCore")
HRESULT LegacyIAccessiblePattern_GetIAccessible(HUIAPATTERNOBJECT__* hobj, IAccessible* pAccessible);

@DllImport("UIAutomationCore")
HRESULT SynchronizedInputPattern_StartListening(HUIAPATTERNOBJECT__* hobj, SynchronizedInputType inputType);

@DllImport("UIAutomationCore")
HRESULT SynchronizedInputPattern_Cancel(HUIAPATTERNOBJECT__* hobj);

@DllImport("UIAutomationCore")
HRESULT VirtualizedItemPattern_Realize(HUIAPATTERNOBJECT__* hobj);

@DllImport("UIAutomationCore")
BOOL UiaPatternRelease(HUIAPATTERNOBJECT__* hobj);

@DllImport("UIAutomationCore")
BOOL UiaTextRangeRelease(HUIATEXTRANGE__* hobj);

@DllImport("UIAutomationCore")
LRESULT UiaReturnRawElementProvider(HWND hwnd, WPARAM wParam, LPARAM lParam, IRawElementProviderSimple el);

@DllImport("UIAutomationCore")
HRESULT UiaHostProviderFromHwnd(HWND hwnd, IRawElementProviderSimple* ppProvider);

@DllImport("UIAutomationCore")
HRESULT UiaProviderForNonClient(HWND hwnd, int idObject, int idChild, IRawElementProviderSimple* ppProvider);

@DllImport("UIAutomationCore")
HRESULT UiaIAccessibleFromProvider(IRawElementProviderSimple pProvider, uint dwFlags, IAccessible* ppAccessible, 
                                   VARIANT* pvarChild);

@DllImport("UIAutomationCore")
HRESULT UiaProviderFromIAccessible(IAccessible pAccessible, int idChild, uint dwFlags, 
                                   IRawElementProviderSimple* ppProvider);

@DllImport("UIAutomationCore")
HRESULT UiaDisconnectAllProviders();

@DllImport("UIAutomationCore")
HRESULT UiaDisconnectProvider(IRawElementProviderSimple pProvider);

@DllImport("UIAutomationCore")
BOOL UiaHasServerSideProvider(HWND hwnd);


// Interfaces

@GUID("08CD963F-7A3E-4F5C-9BD8-D692BB043C5B")
struct MSAAControl;

@GUID("5440837F-4BFF-4AE5-A1B1-7722ECC6332A")
struct AccStore;

@GUID("6572EE16-5FE5-4331-BB6D-76A49C56E423")
struct AccDictionary;

@GUID("6089A37E-EB8A-482D-BD6F-F9F46904D16D")
struct AccServerDocMgr;

@GUID("FC48CC30-4F3E-4FA1-803B-AD0E196A83B1")
struct AccClientDocMgr;

@GUID("BF426F7E-7A5E-44D6-830C-A390EA9462A3")
struct DocWrap;

@GUID("B5F8350B-0548-48B1-A6EE-88BD00B4A5E7")
struct CAccPropServices;

@GUID("6E29FABF-9977-42D1-8D0E-CA7E61AD87E6")
struct CUIAutomationRegistrar;

@GUID("FF48DBA4-60EF-4201-AA87-54103EEF594E")
struct CUIAutomation;

@GUID("E22AD333-B25F-460C-83D0-0581107395C9")
struct CUIAutomation8;

@GUID("E1AA6466-9DB4-40BA-BE03-77C38E8E60B2")
interface IInternalDocWrap : IUnknown
{
    HRESULT NotifyRevoke();
}

@GUID("A2DE3BC2-3D8E-11D3-81A9-F753FBE61A00")
interface ITextStoreACPEx : IUnknown
{
    HRESULT ScrollToRect(int acpStart, int acpEnd, RECT rc, uint dwPosition);
}

@GUID("A2DE3BC1-3D8E-11D3-81A9-F753FBE61A00")
interface ITextStoreAnchorEx : IUnknown
{
    HRESULT ScrollToRect(IAnchor pStart, IAnchor pEnd, RECT rc, uint dwPosition);
}

@GUID("2BDF9464-41E2-43E3-950C-A6865BA25CD4")
interface ITextStoreACPSinkEx : ITextStoreACPSink
{
    HRESULT OnDisconnect();
}

@GUID("25642426-028D-4474-977B-111BB114FE3E")
interface ITextStoreSinkAnchorEx : ITextStoreAnchorSink
{
    HRESULT OnDisconnect();
}

@GUID("1DC4CB5F-D737-474D-ADE9-5CCFC9BC1CC9")
interface IAccDictionary : IUnknown
{
    HRESULT GetLocalizedString(const(GUID)* Term, uint lcid, BSTR* pResult, uint* plcid);
    HRESULT GetParentTerm(const(GUID)* Term, GUID* pParentTerm);
    HRESULT GetMnemonicString(const(GUID)* Term, BSTR* pResult);
    HRESULT LookupMnemonicTerm(BSTR bstrMnemonic, GUID* pTerm);
    HRESULT ConvertValueToString(const(GUID)* Term, uint lcid, VARIANT varValue, BSTR* pbstrResult, uint* plcid);
}

@GUID("401518EC-DB00-4611-9B29-2A0E4B9AFA85")
interface IVersionInfo : IUnknown
{
    HRESULT GetSubcomponentCount(uint ulSub, uint* ulCount);
    HRESULT GetImplementationID(uint ulSub, GUID* implid);
    HRESULT GetBuildVersion(uint ulSub, uint* pdwMajor, uint* pdwMinor);
    HRESULT GetComponentDescription(uint ulSub, BSTR* pImplStr);
    HRESULT GetInstanceDescription(uint ulSub, BSTR* pImplStr);
}

@GUID("03DE00AA-F272-41E3-99CB-03C5E8114EA0")
interface ICoCreateLocally : IUnknown
{
    HRESULT CoCreateLocally(const(GUID)* rclsid, uint dwClsContext, const(GUID)* riid, IUnknown* punk, 
                            const(GUID)* riidParam, IUnknown punkParam, VARIANT varParam);
}

@GUID("0A53EB6C-1908-4742-8CFF-2CEE2E93F94C")
interface ICoCreatedLocally : IUnknown
{
    HRESULT LocalInit(IUnknown punkLocalObject, const(GUID)* riidParam, IUnknown punkParam, VARIANT varParam);
}

@GUID("E2CD4A63-2B72-4D48-B739-95E4765195BA")
interface IAccStore : IUnknown
{
    HRESULT Register(const(GUID)* riid, IUnknown punk);
    HRESULT Unregister(IUnknown punk);
    HRESULT GetDocuments(IEnumUnknown* enumUnknown);
    HRESULT LookupByHWND(HWND hWnd, const(GUID)* riid, IUnknown* ppunk);
    HRESULT LookupByPoint(POINT pt, const(GUID)* riid, IUnknown* ppunk);
    HRESULT OnDocumentFocus(IUnknown punk);
    HRESULT GetFocused(const(GUID)* riid, IUnknown* ppunk);
}

@GUID("AD7C73CF-6DD5-4855-ABC2-B04BAD5B9153")
interface IAccServerDocMgr : IUnknown
{
    HRESULT NewDocument(const(GUID)* riid, IUnknown punk);
    HRESULT RevokeDocument(IUnknown punk);
    HRESULT OnDocumentFocus(IUnknown punk);
}

@GUID("4C896039-7B6D-49E6-A8C1-45116A98292B")
interface IAccClientDocMgr : IUnknown
{
    HRESULT GetDocuments(IEnumUnknown* enumUnknown);
    HRESULT LookupByHWND(HWND hWnd, const(GUID)* riid, IUnknown* ppunk);
    HRESULT LookupByPoint(POINT pt, const(GUID)* riid, IUnknown* ppunk);
    HRESULT GetFocused(const(GUID)* riid, IUnknown* ppunk);
}

@GUID("DCD285FE-0BE0-43BD-99C9-AAAEC513C555")
interface IDocWrap : IUnknown
{
    HRESULT SetDoc(const(GUID)* riid, IUnknown punk);
    HRESULT GetWrappedDoc(const(GUID)* riid, IUnknown* ppunk);
}

@GUID("B33E75FF-E84C-4DCA-A25C-33B8DC003374")
interface IClonableWrapper : IUnknown
{
    HRESULT CloneNewWrapper(const(GUID)* riid, void** ppv);
}

@GUID("618736E0-3C3D-11CF-810C-00AA00389B71")
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

@GUID("03022430-ABC4-11D0-BDE2-00AA001A1953")
interface IAccessibleHandler : IUnknown
{
    HRESULT AccessibleObjectFromID(int hwnd, int lObjectID, IAccessible* pIAccessible);
}

@GUID("BF3ABD9C-76DA-4389-9EB6-1427D25ABAB7")
interface IAccessibleWindowlessSite : IUnknown
{
    HRESULT AcquireObjectIdRange(int rangeSize, IAccessibleHandler pRangeOwner, int* pRangeBase);
    HRESULT ReleaseObjectIdRange(int rangeBase, IAccessibleHandler pRangeOwner);
    HRESULT QueryObjectIdRanges(IAccessibleHandler pRangesOwner, SAFEARRAY** psaRanges);
    HRESULT GetParentAccessible(IAccessible* ppParent);
}

@GUID("7852B78D-1CFD-41C1-A615-9C0C85960B5F")
interface IAccIdentity : IUnknown
{
    HRESULT GetIdentityString(uint dwIDChild, char* ppIDString, uint* pdwIDStringLen);
}

@GUID("76C0DBBB-15E0-4E7B-B61B-20EEEA2001E0")
interface IAccPropServer : IUnknown
{
    HRESULT GetPropValue(char* pIDString, uint dwIDStringLen, GUID idProp, VARIANT* pvarValue, int* pfHasProp);
}

@GUID("6E26E776-04F0-495D-80E4-3330352E3169")
interface IAccPropServices : IUnknown
{
    HRESULT SetPropValue(char* pIDString, uint dwIDStringLen, GUID idProp, VARIANT var);
    HRESULT SetPropServer(char* pIDString, uint dwIDStringLen, char* paProps, int cProps, IAccPropServer pServer, 
                          AnnoScope annoScope);
    HRESULT ClearProps(char* pIDString, uint dwIDStringLen, char* paProps, int cProps);
    HRESULT SetHwndProp(HWND hwnd, uint idObject, uint idChild, GUID idProp, VARIANT var);
    HRESULT SetHwndPropStr(HWND hwnd, uint idObject, uint idChild, GUID idProp, const(wchar)* str);
    HRESULT SetHwndPropServer(HWND hwnd, uint idObject, uint idChild, char* paProps, int cProps, 
                              IAccPropServer pServer, AnnoScope annoScope);
    HRESULT ClearHwndProps(HWND hwnd, uint idObject, uint idChild, char* paProps, int cProps);
    HRESULT ComposeHwndIdentityString(HWND hwnd, uint idObject, uint idChild, char* ppIDString, 
                                      uint* pdwIDStringLen);
    HRESULT DecomposeHwndIdentityString(char* pIDString, uint dwIDStringLen, HWND* phwnd, uint* pidObject, 
                                        uint* pidChild);
    HRESULT SetHmenuProp(HMENU hmenu, uint idChild, GUID idProp, VARIANT var);
    HRESULT SetHmenuPropStr(HMENU hmenu, uint idChild, GUID idProp, const(wchar)* str);
    HRESULT SetHmenuPropServer(HMENU hmenu, uint idChild, char* paProps, int cProps, IAccPropServer pServer, 
                               AnnoScope annoScope);
    HRESULT ClearHmenuProps(HMENU hmenu, uint idChild, char* paProps, int cProps);
    HRESULT ComposeHmenuIdentityString(HMENU hmenu, uint idChild, char* ppIDString, uint* pdwIDStringLen);
    HRESULT DecomposeHmenuIdentityString(char* pIDString, uint dwIDStringLen, HMENU* phmenu, uint* pidChild);
}

@GUID("D6DD68D1-86FD-4332-8666-9ABEDEA2D24C")
interface IRawElementProviderSimple : IUnknown
{
    HRESULT get_ProviderOptions(ProviderOptions* pRetVal);
    HRESULT GetPatternProvider(int patternId, IUnknown* pRetVal);
    HRESULT GetPropertyValue(int propertyId, VARIANT* pRetVal);
    HRESULT get_HostRawElementProvider(IRawElementProviderSimple* pRetVal);
}

@GUID("F8B80ADA-2C44-48D0-89BE-5FF23C9CD875")
interface IAccessibleEx : IUnknown
{
    HRESULT GetObjectForChild(int idChild, IAccessibleEx* pRetVal);
    HRESULT GetIAccessiblePair(IAccessible* ppAcc, int* pidChild);
    HRESULT GetRuntimeId(SAFEARRAY** pRetVal);
    HRESULT ConvertReturnedElement(IRawElementProviderSimple pIn, IAccessibleEx* ppRetValOut);
}

@GUID("A0A839A9-8DA1-4A82-806A-8E0D44E79F56")
interface IRawElementProviderSimple2 : IRawElementProviderSimple
{
    HRESULT ShowContextMenu();
}

@GUID("FCF5D820-D7EC-4613-BDF6-42A84CE7DAAF")
interface IRawElementProviderSimple3 : IRawElementProviderSimple2
{
    HRESULT GetMetadataValue(int targetId, int metadataId, VARIANT* returnVal);
}

@GUID("620CE2A5-AB8F-40A9-86CB-DE3C75599B58")
interface IRawElementProviderFragmentRoot : IUnknown
{
    HRESULT ElementProviderFromPoint(double x, double y, IRawElementProviderFragment* pRetVal);
    HRESULT GetFocus(IRawElementProviderFragment* pRetVal);
}

@GUID("F7063DA8-8359-439C-9297-BBC5299A7D87")
interface IRawElementProviderFragment : IUnknown
{
    HRESULT Navigate(NavigateDirection direction, IRawElementProviderFragment* pRetVal);
    HRESULT GetRuntimeId(SAFEARRAY** pRetVal);
    HRESULT get_BoundingRectangle(UiaRect* pRetVal);
    HRESULT GetEmbeddedFragmentRoots(SAFEARRAY** pRetVal);
    HRESULT SetFocus();
    HRESULT get_FragmentRoot(IRawElementProviderFragmentRoot* pRetVal);
}

@GUID("A407B27B-0F6D-4427-9292-473C7BF93258")
interface IRawElementProviderAdviseEvents : IUnknown
{
    HRESULT AdviseEventAdded(int eventId, SAFEARRAY* propertyIDs);
    HRESULT AdviseEventRemoved(int eventId, SAFEARRAY* propertyIDs);
}

@GUID("1D5DF27C-8947-4425-B8D9-79787BB460B8")
interface IRawElementProviderHwndOverride : IUnknown
{
    HRESULT GetOverrideProviderForHwnd(HWND hwnd, IRawElementProviderSimple* pRetVal);
}

@GUID("4FD82B78-A43E-46AC-9803-0A6969C7C183")
interface IProxyProviderWinEventSink : IUnknown
{
    HRESULT AddAutomationPropertyChangedEvent(IRawElementProviderSimple pProvider, int id, VARIANT newValue);
    HRESULT AddAutomationEvent(IRawElementProviderSimple pProvider, int id);
    HRESULT AddStructureChangedEvent(IRawElementProviderSimple pProvider, StructureChangeType structureChangeType, 
                                     SAFEARRAY* runtimeId);
}

@GUID("89592AD4-F4E0-43D5-A3B6-BAD7E111B435")
interface IProxyProviderWinEventHandler : IUnknown
{
    HRESULT RespondToWinEvent(uint idWinEvent, HWND hwnd, int idObject, int idChild, 
                              IProxyProviderWinEventSink pSink);
}

@GUID("0A2A93CC-BFAD-42AC-9B2E-0991FB0D3EA0")
interface IRawElementProviderWindowlessSite : IUnknown
{
    HRESULT GetAdjacentFragment(NavigateDirection direction, IRawElementProviderFragment* ppParent);
    HRESULT GetRuntimeIdPrefix(SAFEARRAY** pRetVal);
}

@GUID("33AC331B-943E-4020-B295-DB37784974A3")
interface IAccessibleHostingElementProviders : IUnknown
{
    HRESULT GetEmbeddedFragmentRoots(SAFEARRAY** pRetVal);
    HRESULT GetObjectIdForProvider(IRawElementProviderSimple pProvider, int* pidObject);
}

@GUID("24BE0B07-D37D-487A-98CF-A13ED465E9B3")
interface IRawElementProviderHostingAccessibles : IUnknown
{
    HRESULT GetEmbeddedAccessibles(SAFEARRAY** pRetVal);
}

@GUID("159BC72C-4AD3-485E-9637-D7052EDF0146")
interface IDockProvider : IUnknown
{
    HRESULT SetDockPosition(DockPosition dockPosition);
    HRESULT get_DockPosition(DockPosition* pRetVal);
}

@GUID("D847D3A5-CAB0-4A98-8C32-ECB45C59AD24")
interface IExpandCollapseProvider : IUnknown
{
    HRESULT Expand();
    HRESULT Collapse();
    HRESULT get_ExpandCollapseState(ExpandCollapseState* pRetVal);
}

@GUID("B17D6187-0907-464B-A168-0EF17A1572B1")
interface IGridProvider : IUnknown
{
    HRESULT GetItem(int row, int column, IRawElementProviderSimple* pRetVal);
    HRESULT get_RowCount(int* pRetVal);
    HRESULT get_ColumnCount(int* pRetVal);
}

@GUID("D02541F1-FB81-4D64-AE32-F520F8A6DBD1")
interface IGridItemProvider : IUnknown
{
    HRESULT get_Row(int* pRetVal);
    HRESULT get_Column(int* pRetVal);
    HRESULT get_RowSpan(int* pRetVal);
    HRESULT get_ColumnSpan(int* pRetVal);
    HRESULT get_ContainingGrid(IRawElementProviderSimple* pRetVal);
}

@GUID("54FCB24B-E18E-47A2-B4D3-ECCBE77599A2")
interface IInvokeProvider : IUnknown
{
    HRESULT Invoke();
}

@GUID("6278CAB1-B556-4A1A-B4E0-418ACC523201")
interface IMultipleViewProvider : IUnknown
{
    HRESULT GetViewName(int viewId, BSTR* pRetVal);
    HRESULT SetCurrentView(int viewId);
    HRESULT get_CurrentView(int* pRetVal);
    HRESULT GetSupportedViews(SAFEARRAY** pRetVal);
}

@GUID("36DC7AEF-33E6-4691-AFE1-2BE7274B3D33")
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

@GUID("2360C714-4BF1-4B26-BA65-9B21316127EB")
interface IScrollItemProvider : IUnknown
{
    HRESULT ScrollIntoView();
}

@GUID("FB8B03AF-3BDF-48D4-BD36-1A65793BE168")
interface ISelectionProvider : IUnknown
{
    HRESULT GetSelection(SAFEARRAY** pRetVal);
    HRESULT get_CanSelectMultiple(int* pRetVal);
    HRESULT get_IsSelectionRequired(int* pRetVal);
}

@GUID("14F68475-EE1C-44F6-A869-D239381F0FE7")
interface ISelectionProvider2 : ISelectionProvider
{
    HRESULT get_FirstSelectedItem(IRawElementProviderSimple* retVal);
    HRESULT get_LastSelectedItem(IRawElementProviderSimple* retVal);
    HRESULT get_CurrentSelectedItem(IRawElementProviderSimple* retVal);
    HRESULT get_ItemCount(int* retVal);
}

@GUID("B38B8077-1FC3-42A5-8CAE-D40C2215055A")
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

@GUID("2ACAD808-B2D4-452D-A407-91FF1AD167B2")
interface ISelectionItemProvider : IUnknown
{
    HRESULT Select();
    HRESULT AddToSelection();
    HRESULT RemoveFromSelection();
    HRESULT get_IsSelected(int* pRetVal);
    HRESULT get_SelectionContainer(IRawElementProviderSimple* pRetVal);
}

@GUID("29DB1A06-02CE-4CF7-9B42-565D4FAB20EE")
interface ISynchronizedInputProvider : IUnknown
{
    HRESULT StartListening(SynchronizedInputType inputType);
    HRESULT Cancel();
}

@GUID("9C860395-97B3-490A-B52A-858CC22AF166")
interface ITableProvider : IUnknown
{
    HRESULT GetRowHeaders(SAFEARRAY** pRetVal);
    HRESULT GetColumnHeaders(SAFEARRAY** pRetVal);
    HRESULT get_RowOrColumnMajor(RowOrColumnMajor* pRetVal);
}

@GUID("B9734FA6-771F-4D78-9C90-2517999349CD")
interface ITableItemProvider : IUnknown
{
    HRESULT GetRowHeaderItems(SAFEARRAY** pRetVal);
    HRESULT GetColumnHeaderItems(SAFEARRAY** pRetVal);
}

@GUID("56D00BD0-C4F4-433C-A836-1A52A57E0892")
interface IToggleProvider : IUnknown
{
    HRESULT Toggle();
    HRESULT get_ToggleState(ToggleState* pRetVal);
}

@GUID("6829DDC4-4F91-4FFA-B86F-BD3E2987CB4C")
interface ITransformProvider : IUnknown
{
    HRESULT Move(double x, double y);
    HRESULT Resize(double width, double height);
    HRESULT Rotate(double degrees);
    HRESULT get_CanMove(int* pRetVal);
    HRESULT get_CanResize(int* pRetVal);
    HRESULT get_CanRotate(int* pRetVal);
}

@GUID("C7935180-6FB3-4201-B174-7DF73ADBF64A")
interface IValueProvider : IUnknown
{
    HRESULT SetValue(const(wchar)* val);
    HRESULT get_Value(BSTR* pRetVal);
    HRESULT get_IsReadOnly(int* pRetVal);
}

@GUID("987DF77B-DB06-4D77-8F8A-86A9C3BB90B9")
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

@GUID("E44C3566-915D-4070-99C6-047BFF5A08F5")
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

@GUID("E747770B-39CE-4382-AB30-D8FB3F336F24")
interface IItemContainerProvider : IUnknown
{
    HRESULT FindItemByProperty(IRawElementProviderSimple pStartAfter, int propertyId, VARIANT value, 
                               IRawElementProviderSimple* pFound);
}

@GUID("CB98B665-2D35-4FAC-AD35-F3C60D0C0B8B")
interface IVirtualizedItemProvider : IUnknown
{
    HRESULT Realize();
}

@GUID("3AD86EBD-F5EF-483D-BB18-B1042A475D64")
interface IObjectModelProvider : IUnknown
{
    HRESULT GetUnderlyingObjectModel(IUnknown* ppUnknown);
}

@GUID("F95C7E80-BD63-4601-9782-445EBFF011FC")
interface IAnnotationProvider : IUnknown
{
    HRESULT get_AnnotationTypeId(int* retVal);
    HRESULT get_AnnotationTypeName(BSTR* retVal);
    HRESULT get_Author(BSTR* retVal);
    HRESULT get_DateTime(BSTR* retVal);
    HRESULT get_Target(IRawElementProviderSimple* retVal);
}

@GUID("19B6B649-F5D7-4A6D-BDCB-129252BE588A")
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

@GUID("6F6B5D35-5525-4F80-B758-85473832FFC7")
interface ISpreadsheetProvider : IUnknown
{
    HRESULT GetItemByName(const(wchar)* name, IRawElementProviderSimple* pRetVal);
}

@GUID("EAED4660-7B3D-4879-A2E6-365CE603F3D0")
interface ISpreadsheetItemProvider : IUnknown
{
    HRESULT get_Formula(BSTR* pRetVal);
    HRESULT GetAnnotationObjects(SAFEARRAY** pRetVal);
    HRESULT GetAnnotationTypes(SAFEARRAY** pRetVal);
}

@GUID("4758742F-7AC2-460C-BC48-09FC09308A93")
interface ITransformProvider2 : ITransformProvider
{
    HRESULT Zoom(double zoom);
    HRESULT get_CanZoom(int* pRetVal);
    HRESULT get_ZoomLevel(double* pRetVal);
    HRESULT get_ZoomMinimum(double* pRetVal);
    HRESULT get_ZoomMaximum(double* pRetVal);
    HRESULT ZoomByUnit(ZoomUnit zoomUnit);
}

@GUID("6AA7BBBB-7FF9-497D-904F-D20B897929D8")
interface IDragProvider : IUnknown
{
    HRESULT get_IsGrabbed(int* pRetVal);
    HRESULT get_DropEffect(BSTR* pRetVal);
    HRESULT get_DropEffects(SAFEARRAY** pRetVal);
    HRESULT GetGrabbedItems(SAFEARRAY** pRetVal);
}

@GUID("BAE82BFD-358A-481C-85A0-D8B4D90A5D61")
interface IDropTargetProvider : IUnknown
{
    HRESULT get_DropTargetEffect(BSTR* pRetVal);
    HRESULT get_DropTargetEffects(SAFEARRAY** pRetVal);
}

@GUID("5347AD7B-C355-46F8-AFF5-909033582F63")
interface ITextRangeProvider : IUnknown
{
    HRESULT Clone(ITextRangeProvider* pRetVal);
    HRESULT Compare(ITextRangeProvider range, int* pRetVal);
    HRESULT CompareEndpoints(TextPatternRangeEndpoint endpoint, ITextRangeProvider targetRange, 
                             TextPatternRangeEndpoint targetEndpoint, int* pRetVal);
    HRESULT ExpandToEnclosingUnit(TextUnit unit);
    HRESULT FindAttribute(int attributeId, VARIANT val, BOOL backward, ITextRangeProvider* pRetVal);
    HRESULT FindTextA(BSTR text, BOOL backward, BOOL ignoreCase, ITextRangeProvider* pRetVal);
    HRESULT GetAttributeValue(int attributeId, VARIANT* pRetVal);
    HRESULT GetBoundingRectangles(SAFEARRAY** pRetVal);
    HRESULT GetEnclosingElement(IRawElementProviderSimple* pRetVal);
    HRESULT GetText(int maxLength, BSTR* pRetVal);
    HRESULT Move(TextUnit unit, int count, int* pRetVal);
    HRESULT MoveEndpointByUnit(TextPatternRangeEndpoint endpoint, TextUnit unit, int count, int* pRetVal);
    HRESULT MoveEndpointByRange(TextPatternRangeEndpoint endpoint, ITextRangeProvider targetRange, 
                                TextPatternRangeEndpoint targetEndpoint);
    HRESULT Select();
    HRESULT AddToSelection();
    HRESULT RemoveFromSelection();
    HRESULT ScrollIntoView(BOOL alignToTop);
    HRESULT GetChildren(SAFEARRAY** pRetVal);
}

@GUID("3589C92C-63F3-4367-99BB-ADA653B77CF2")
interface ITextProvider : IUnknown
{
    HRESULT GetSelection(SAFEARRAY** pRetVal);
    HRESULT GetVisibleRanges(SAFEARRAY** pRetVal);
    HRESULT RangeFromChild(IRawElementProviderSimple childElement, ITextRangeProvider* pRetVal);
    HRESULT RangeFromPoint(UiaPoint point, ITextRangeProvider* pRetVal);
    HRESULT get_DocumentRange(ITextRangeProvider* pRetVal);
    HRESULT get_SupportedTextSelection(SupportedTextSelection* pRetVal);
}

@GUID("0DC5E6ED-3E16-4BF1-8F9A-A979878BC195")
interface ITextProvider2 : ITextProvider
{
    HRESULT RangeFromAnnotation(IRawElementProviderSimple annotationElement, ITextRangeProvider* pRetVal);
    HRESULT GetCaretRange(int* isActive, ITextRangeProvider* pRetVal);
}

@GUID("EA3605B4-3A05-400E-B5F9-4E91B40F6176")
interface ITextEditProvider : ITextProvider
{
    HRESULT GetActiveComposition(ITextRangeProvider* pRetVal);
    HRESULT GetConversionTarget(ITextRangeProvider* pRetVal);
}

@GUID("9BBCE42C-1921-4F18-89CA-DBA1910A0386")
interface ITextRangeProvider2 : ITextRangeProvider
{
    HRESULT ShowContextMenu();
}

@GUID("4C2DE2B9-C88F-4F88-A111-F1D336B7D1A9")
interface ITextChildProvider : IUnknown
{
    HRESULT get_TextContainer(IRawElementProviderSimple* pRetVal);
    HRESULT get_TextRange(ITextRangeProvider* pRetVal);
}

@GUID("2062A28A-8C07-4B94-8E12-7037C622AEB8")
interface ICustomNavigationProvider : IUnknown
{
    HRESULT Navigate(NavigateDirection direction, IRawElementProviderSimple* pRetVal);
}

@GUID("C03A7FE4-9431-409F-BED8-AE7C2299BC8D")
interface IUIAutomationPatternInstance : IUnknown
{
    HRESULT GetProperty(uint index, BOOL cached, UIAutomationType type, void* pPtr);
    HRESULT CallMethod(uint index, const(UIAutomationParameter)* pParams, uint cParams);
}

@GUID("D97022F3-A947-465E-8B2A-AC4315FA54E8")
interface IUIAutomationPatternHandler : IUnknown
{
    HRESULT CreateClientWrapper(IUIAutomationPatternInstance pPatternInstance, IUnknown* pClientWrapper);
    HRESULT Dispatch(IUnknown pTarget, uint index, const(UIAutomationParameter)* pParams, uint cParams);
}

@GUID("8609C4EC-4A1A-4D88-A357-5A66E060E1CF")
interface IUIAutomationRegistrar : IUnknown
{
    HRESULT RegisterProperty(const(UIAutomationPropertyInfo)* property, int* propertyId);
    HRESULT RegisterEvent(const(UIAutomationEventInfo)* event, int* eventId);
    HRESULT RegisterPattern(const(UIAutomationPatternInfo)* pattern, int* pPatternId, 
                            int* pPatternAvailablePropertyId, uint propertyIdCount, char* pPropertyIds, 
                            uint eventIdCount, char* pEventIds);
}

@GUID("D22108AA-8AC5-49A5-837B-37BBB3D7591E")
interface IUIAutomationElement : IUnknown
{
    HRESULT SetFocus();
    HRESULT GetRuntimeId(SAFEARRAY** runtimeId);
    HRESULT FindFirst(TreeScope scope_, IUIAutomationCondition condition, IUIAutomationElement* found);
    HRESULT FindAll(TreeScope scope_, IUIAutomationCondition condition, IUIAutomationElementArray* found);
    HRESULT FindFirstBuildCache(TreeScope scope_, IUIAutomationCondition condition, 
                                IUIAutomationCacheRequest cacheRequest, IUIAutomationElement* found);
    HRESULT FindAllBuildCache(TreeScope scope_, IUIAutomationCondition condition, 
                              IUIAutomationCacheRequest cacheRequest, IUIAutomationElementArray* found);
    HRESULT BuildUpdatedCache(IUIAutomationCacheRequest cacheRequest, IUIAutomationElement* updatedElement);
    HRESULT GetCurrentPropertyValue(int propertyId, VARIANT* retVal);
    HRESULT GetCurrentPropertyValueEx(int propertyId, BOOL ignoreDefaultValue, VARIANT* retVal);
    HRESULT GetCachedPropertyValue(int propertyId, VARIANT* retVal);
    HRESULT GetCachedPropertyValueEx(int propertyId, BOOL ignoreDefaultValue, VARIANT* retVal);
    HRESULT GetCurrentPatternAs(int patternId, const(GUID)* riid, void** patternObject);
    HRESULT GetCachedPatternAs(int patternId, const(GUID)* riid, void** patternObject);
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

@GUID("14314595-B4BC-4055-95F2-58F2E42C9855")
interface IUIAutomationElementArray : IUnknown
{
    HRESULT get_Length(int* length);
    HRESULT GetElement(int index, IUIAutomationElement* element);
}

@GUID("352FFBA8-0973-437C-A61F-F64CAFD81DF9")
interface IUIAutomationCondition : IUnknown
{
}

@GUID("1B4E1F2E-75EB-4D0B-8952-5A69988E2307")
interface IUIAutomationBoolCondition : IUIAutomationCondition
{
    HRESULT get_BooleanValue(int* boolVal);
}

@GUID("99EBF2CB-5578-4267-9AD4-AFD6EA77E94B")
interface IUIAutomationPropertyCondition : IUIAutomationCondition
{
    HRESULT get_PropertyId(int* propertyId);
    HRESULT get_PropertyValue(VARIANT* propertyValue);
    HRESULT get_PropertyConditionFlags(PropertyConditionFlags* flags);
}

@GUID("A7D0AF36-B912-45FE-9855-091DDC174AEC")
interface IUIAutomationAndCondition : IUIAutomationCondition
{
    HRESULT get_ChildCount(int* childCount);
    HRESULT GetChildrenAsNativeArray(char* childArray, int* childArrayCount);
    HRESULT GetChildren(SAFEARRAY** childArray);
}

@GUID("8753F032-3DB1-47B5-A1FC-6E34A266C712")
interface IUIAutomationOrCondition : IUIAutomationCondition
{
    HRESULT get_ChildCount(int* childCount);
    HRESULT GetChildrenAsNativeArray(char* childArray, int* childArrayCount);
    HRESULT GetChildren(SAFEARRAY** childArray);
}

@GUID("F528B657-847B-498C-8896-D52B565407A1")
interface IUIAutomationNotCondition : IUIAutomationCondition
{
    HRESULT GetChild(IUIAutomationCondition* condition);
}

@GUID("B32A92B5-BC25-4078-9C08-D7EE95C48E03")
interface IUIAutomationCacheRequest : IUnknown
{
    HRESULT AddProperty(int propertyId);
    HRESULT AddPattern(int patternId);
    HRESULT Clone(IUIAutomationCacheRequest* clonedRequest);
    HRESULT get_TreeScope(TreeScope* scope_);
    HRESULT put_TreeScope(TreeScope scope_);
    HRESULT get_TreeFilter(IUIAutomationCondition* filter);
    HRESULT put_TreeFilter(IUIAutomationCondition filter);
    HRESULT get_AutomationElementMode(AutomationElementMode* mode);
    HRESULT put_AutomationElementMode(AutomationElementMode mode);
}

@GUID("4042C624-389C-4AFC-A630-9DF854A541FC")
interface IUIAutomationTreeWalker : IUnknown
{
    HRESULT GetParentElement(IUIAutomationElement element, IUIAutomationElement* parent);
    HRESULT GetFirstChildElement(IUIAutomationElement element, IUIAutomationElement* first);
    HRESULT GetLastChildElement(IUIAutomationElement element, IUIAutomationElement* last);
    HRESULT GetNextSiblingElement(IUIAutomationElement element, IUIAutomationElement* next);
    HRESULT GetPreviousSiblingElement(IUIAutomationElement element, IUIAutomationElement* previous);
    HRESULT NormalizeElement(IUIAutomationElement element, IUIAutomationElement* normalized);
    HRESULT GetParentElementBuildCache(IUIAutomationElement element, IUIAutomationCacheRequest cacheRequest, 
                                       IUIAutomationElement* parent);
    HRESULT GetFirstChildElementBuildCache(IUIAutomationElement element, IUIAutomationCacheRequest cacheRequest, 
                                           IUIAutomationElement* first);
    HRESULT GetLastChildElementBuildCache(IUIAutomationElement element, IUIAutomationCacheRequest cacheRequest, 
                                          IUIAutomationElement* last);
    HRESULT GetNextSiblingElementBuildCache(IUIAutomationElement element, IUIAutomationCacheRequest cacheRequest, 
                                            IUIAutomationElement* next);
    HRESULT GetPreviousSiblingElementBuildCache(IUIAutomationElement element, 
                                                IUIAutomationCacheRequest cacheRequest, 
                                                IUIAutomationElement* previous);
    HRESULT NormalizeElementBuildCache(IUIAutomationElement element, IUIAutomationCacheRequest cacheRequest, 
                                       IUIAutomationElement* normalized);
    HRESULT get_Condition(IUIAutomationCondition* condition);
}

@GUID("146C3C17-F12E-4E22-8C27-F894B9B79C69")
interface IUIAutomationEventHandler : IUnknown
{
    HRESULT HandleAutomationEvent(IUIAutomationElement sender, int eventId);
}

@GUID("40CD37D4-C756-4B0C-8C6F-BDDFEEB13B50")
interface IUIAutomationPropertyChangedEventHandler : IUnknown
{
    HRESULT HandlePropertyChangedEvent(IUIAutomationElement sender, int propertyId, VARIANT newValue);
}

@GUID("E81D1B4E-11C5-42F8-9754-E7036C79F054")
interface IUIAutomationStructureChangedEventHandler : IUnknown
{
    HRESULT HandleStructureChangedEvent(IUIAutomationElement sender, StructureChangeType changeType, 
                                        SAFEARRAY* runtimeId);
}

@GUID("C270F6B5-5C69-4290-9745-7A7F97169468")
interface IUIAutomationFocusChangedEventHandler : IUnknown
{
    HRESULT HandleFocusChangedEvent(IUIAutomationElement sender);
}

@GUID("92FAA680-E704-4156-931A-E32D5BB38F3F")
interface IUIAutomationTextEditTextChangedEventHandler : IUnknown
{
    HRESULT HandleTextEditTextChangedEvent(IUIAutomationElement sender, TextEditChangeType textEditChangeType, 
                                           SAFEARRAY* eventStrings);
}

@GUID("58EDCA55-2C3E-4980-B1B9-56C17F27A2A0")
interface IUIAutomationChangesEventHandler : IUnknown
{
    HRESULT HandleChangesEvent(IUIAutomationElement sender, char* uiaChanges, int changesCount);
}

@GUID("C7CB2637-E6C2-4D0C-85DE-4948C02175C7")
interface IUIAutomationNotificationEventHandler : IUnknown
{
    HRESULT HandleNotificationEvent(IUIAutomationElement sender, NotificationKind notificationKind, 
                                    NotificationProcessing notificationProcessing, BSTR displayString, 
                                    BSTR activityId);
}

@GUID("FB377FBE-8EA6-46D5-9C73-6499642D3059")
interface IUIAutomationInvokePattern : IUnknown
{
    HRESULT Invoke();
}

@GUID("FDE5EF97-1464-48F6-90BF-43D0948E86EC")
interface IUIAutomationDockPattern : IUnknown
{
    HRESULT SetDockPosition(DockPosition dockPos);
    HRESULT get_CurrentDockPosition(DockPosition* retVal);
    HRESULT get_CachedDockPosition(DockPosition* retVal);
}

@GUID("619BE086-1F4E-4EE4-BAFA-210128738730")
interface IUIAutomationExpandCollapsePattern : IUnknown
{
    HRESULT Expand();
    HRESULT Collapse();
    HRESULT get_CurrentExpandCollapseState(ExpandCollapseState* retVal);
    HRESULT get_CachedExpandCollapseState(ExpandCollapseState* retVal);
}

@GUID("414C3CDC-856B-4F5B-8538-3131C6302550")
interface IUIAutomationGridPattern : IUnknown
{
    HRESULT GetItem(int row, int column, IUIAutomationElement* element);
    HRESULT get_CurrentRowCount(int* retVal);
    HRESULT get_CurrentColumnCount(int* retVal);
    HRESULT get_CachedRowCount(int* retVal);
    HRESULT get_CachedColumnCount(int* retVal);
}

@GUID("78F8EF57-66C3-4E09-BD7C-E79B2004894D")
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

@GUID("8D253C91-1DC5-4BB5-B18F-ADE16FA495E8")
interface IUIAutomationMultipleViewPattern : IUnknown
{
    HRESULT GetViewName(int view, BSTR* name);
    HRESULT SetCurrentView(int view);
    HRESULT get_CurrentCurrentView(int* retVal);
    HRESULT GetCurrentSupportedViews(SAFEARRAY** retVal);
    HRESULT get_CachedCurrentView(int* retVal);
    HRESULT GetCachedSupportedViews(SAFEARRAY** retVal);
}

@GUID("71C284B3-C14D-4D14-981E-19751B0D756D")
interface IUIAutomationObjectModelPattern : IUnknown
{
    HRESULT GetUnderlyingObjectModel(IUnknown* retVal);
}

@GUID("59213F4F-7346-49E5-B120-80555987A148")
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

@GUID("88F4D42A-E881-459D-A77C-73BBBB7E02DC")
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

@GUID("B488300F-D015-4F19-9C29-BB595E3645EF")
interface IUIAutomationScrollItemPattern : IUnknown
{
    HRESULT ScrollIntoView();
}

@GUID("5ED5202E-B2AC-47A6-B638-4B0BF140D78E")
interface IUIAutomationSelectionPattern : IUnknown
{
    HRESULT GetCurrentSelection(IUIAutomationElementArray* retVal);
    HRESULT get_CurrentCanSelectMultiple(int* retVal);
    HRESULT get_CurrentIsSelectionRequired(int* retVal);
    HRESULT GetCachedSelection(IUIAutomationElementArray* retVal);
    HRESULT get_CachedCanSelectMultiple(int* retVal);
    HRESULT get_CachedIsSelectionRequired(int* retVal);
}

@GUID("0532BFAE-C011-4E32-A343-6D642D798555")
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

@GUID("A8EFA66A-0FDA-421A-9194-38021F3578EA")
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

@GUID("2233BE0B-AFB7-448B-9FDA-3B378AA5EAE1")
interface IUIAutomationSynchronizedInputPattern : IUnknown
{
    HRESULT StartListening(SynchronizedInputType inputType);
    HRESULT Cancel();
}

@GUID("620E691C-EA96-4710-A850-754B24CE2417")
interface IUIAutomationTablePattern : IUnknown
{
    HRESULT GetCurrentRowHeaders(IUIAutomationElementArray* retVal);
    HRESULT GetCurrentColumnHeaders(IUIAutomationElementArray* retVal);
    HRESULT get_CurrentRowOrColumnMajor(RowOrColumnMajor* retVal);
    HRESULT GetCachedRowHeaders(IUIAutomationElementArray* retVal);
    HRESULT GetCachedColumnHeaders(IUIAutomationElementArray* retVal);
    HRESULT get_CachedRowOrColumnMajor(RowOrColumnMajor* retVal);
}

@GUID("0B964EB3-EF2E-4464-9C79-61D61737A27E")
interface IUIAutomationTableItemPattern : IUnknown
{
    HRESULT GetCurrentRowHeaderItems(IUIAutomationElementArray* retVal);
    HRESULT GetCurrentColumnHeaderItems(IUIAutomationElementArray* retVal);
    HRESULT GetCachedRowHeaderItems(IUIAutomationElementArray* retVal);
    HRESULT GetCachedColumnHeaderItems(IUIAutomationElementArray* retVal);
}

@GUID("94CF8058-9B8D-4AB9-8BFD-4CD0A33C8C70")
interface IUIAutomationTogglePattern : IUnknown
{
    HRESULT Toggle();
    HRESULT get_CurrentToggleState(ToggleState* retVal);
    HRESULT get_CachedToggleState(ToggleState* retVal);
}

@GUID("A9B55844-A55D-4EF0-926D-569C16FF89BB")
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

@GUID("A94CD8B1-0844-4CD6-9D2D-640537AB39E9")
interface IUIAutomationValuePattern : IUnknown
{
    HRESULT SetValue(BSTR val);
    HRESULT get_CurrentValue(BSTR* retVal);
    HRESULT get_CurrentIsReadOnly(int* retVal);
    HRESULT get_CachedValue(BSTR* retVal);
    HRESULT get_CachedIsReadOnly(int* retVal);
}

@GUID("0FAEF453-9208-43EF-BBB2-3B485177864F")
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

@GUID("A543CC6A-F4AE-494B-8239-C814481187A8")
interface IUIAutomationTextRange : IUnknown
{
    HRESULT Clone(IUIAutomationTextRange* clonedRange);
    HRESULT Compare(IUIAutomationTextRange range, int* areSame);
    HRESULT CompareEndpoints(TextPatternRangeEndpoint srcEndPoint, IUIAutomationTextRange range, 
                             TextPatternRangeEndpoint targetEndPoint, int* compValue);
    HRESULT ExpandToEnclosingUnit(TextUnit textUnit);
    HRESULT FindAttribute(int attr, VARIANT val, BOOL backward, IUIAutomationTextRange* found);
    HRESULT FindTextA(BSTR text, BOOL backward, BOOL ignoreCase, IUIAutomationTextRange* found);
    HRESULT GetAttributeValue(int attr, VARIANT* value);
    HRESULT GetBoundingRectangles(SAFEARRAY** boundingRects);
    HRESULT GetEnclosingElement(IUIAutomationElement* enclosingElement);
    HRESULT GetText(int maxLength, BSTR* text);
    HRESULT Move(TextUnit unit, int count, int* moved);
    HRESULT MoveEndpointByUnit(TextPatternRangeEndpoint endpoint, TextUnit unit, int count, int* moved);
    HRESULT MoveEndpointByRange(TextPatternRangeEndpoint srcEndPoint, IUIAutomationTextRange range, 
                                TextPatternRangeEndpoint targetEndPoint);
    HRESULT Select();
    HRESULT AddToSelection();
    HRESULT RemoveFromSelection();
    HRESULT ScrollIntoView(BOOL alignToTop);
    HRESULT GetChildren(IUIAutomationElementArray* children);
}

@GUID("BB9B40E0-5E04-46BD-9BE0-4B601B9AFAD4")
interface IUIAutomationTextRange2 : IUIAutomationTextRange
{
    HRESULT ShowContextMenu();
}

@GUID("6A315D69-5512-4C2E-85F0-53FCE6DD4BC2")
interface IUIAutomationTextRange3 : IUIAutomationTextRange2
{
    HRESULT GetEnclosingElementBuildCache(IUIAutomationCacheRequest cacheRequest, 
                                          IUIAutomationElement* enclosingElement);
    HRESULT GetChildrenBuildCache(IUIAutomationCacheRequest cacheRequest, IUIAutomationElementArray* children);
    HRESULT GetAttributeValues(char* attributeIds, int attributeIdCount, SAFEARRAY** attributeValues);
}

@GUID("CE4AE76A-E717-4C98-81EA-47371D028EB6")
interface IUIAutomationTextRangeArray : IUnknown
{
    HRESULT get_Length(int* length);
    HRESULT GetElement(int index, IUIAutomationTextRange* element);
}

@GUID("32EBA289-3583-42C9-9C59-3B6D9A1E9B6A")
interface IUIAutomationTextPattern : IUnknown
{
    HRESULT RangeFromPoint(POINT pt, IUIAutomationTextRange* range);
    HRESULT RangeFromChild(IUIAutomationElement child, IUIAutomationTextRange* range);
    HRESULT GetSelection(IUIAutomationTextRangeArray* ranges);
    HRESULT GetVisibleRanges(IUIAutomationTextRangeArray* ranges);
    HRESULT get_DocumentRange(IUIAutomationTextRange* range);
    HRESULT get_SupportedTextSelection(SupportedTextSelection* supportedTextSelection);
}

@GUID("506A921A-FCC9-409F-B23B-37EB74106872")
interface IUIAutomationTextPattern2 : IUIAutomationTextPattern
{
    HRESULT RangeFromAnnotation(IUIAutomationElement annotation, IUIAutomationTextRange* range);
    HRESULT GetCaretRange(int* isActive, IUIAutomationTextRange* range);
}

@GUID("17E21576-996C-4870-99D9-BFF323380C06")
interface IUIAutomationTextEditPattern : IUIAutomationTextPattern
{
    HRESULT GetActiveComposition(IUIAutomationTextRange* range);
    HRESULT GetConversionTarget(IUIAutomationTextRange* range);
}

@GUID("01EA217A-1766-47ED-A6CC-ACF492854B1F")
interface IUIAutomationCustomNavigationPattern : IUnknown
{
    HRESULT Navigate(NavigateDirection direction, IUIAutomationElement* pRetVal);
}

@GUID("F97933B0-8DAE-4496-8997-5BA015FE0D82")
interface IUIAutomationActiveTextPositionChangedEventHandler : IUnknown
{
    HRESULT HandleActiveTextPositionChangedEvent(IUIAutomationElement sender, IUIAutomationTextRange range);
}

@GUID("828055AD-355B-4435-86D5-3B51C14A9B1B")
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

@GUID("C690FDB2-27A8-423C-812D-429773C9084E")
interface IUIAutomationItemContainerPattern : IUnknown
{
    HRESULT FindItemByProperty(IUIAutomationElement pStartAfter, int propertyId, VARIANT value, 
                               IUIAutomationElement* pFound);
}

@GUID("6BA3D7A6-04CF-4F11-8793-A8D1CDE9969F")
interface IUIAutomationVirtualizedItemPattern : IUnknown
{
    HRESULT Realize();
}

@GUID("9A175B21-339E-41B1-8E8B-623F6B681098")
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

@GUID("85B5F0A2-BD79-484A-AD2B-388C9838D5FB")
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

@GUID("7517A7C8-FAAE-4DE9-9F08-29B91E8595C1")
interface IUIAutomationSpreadsheetPattern : IUnknown
{
    HRESULT GetItemByName(BSTR name, IUIAutomationElement* element);
}

@GUID("7D4FB86C-8D34-40E1-8E83-62C15204E335")
interface IUIAutomationSpreadsheetItemPattern : IUnknown
{
    HRESULT get_CurrentFormula(BSTR* retVal);
    HRESULT GetCurrentAnnotationObjects(IUIAutomationElementArray* retVal);
    HRESULT GetCurrentAnnotationTypes(SAFEARRAY** retVal);
    HRESULT get_CachedFormula(BSTR* retVal);
    HRESULT GetCachedAnnotationObjects(IUIAutomationElementArray* retVal);
    HRESULT GetCachedAnnotationTypes(SAFEARRAY** retVal);
}

@GUID("6D74D017-6ECB-4381-B38B-3C17A48FF1C2")
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

@GUID("6552B038-AE05-40C8-ABFD-AA08352AAB86")
interface IUIAutomationTextChildPattern : IUnknown
{
    HRESULT get_TextContainer(IUIAutomationElement* container);
    HRESULT get_TextRange(IUIAutomationTextRange* range);
}

@GUID("1DC7B570-1F54-4BAD-BCDA-D36A722FB7BD")
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

@GUID("69A095F7-EEE4-430E-A46B-FB73B1AE39A5")
interface IUIAutomationDropTargetPattern : IUnknown
{
    HRESULT get_CurrentDropTargetEffect(BSTR* retVal);
    HRESULT get_CachedDropTargetEffect(BSTR* retVal);
    HRESULT get_CurrentDropTargetEffects(SAFEARRAY** retVal);
    HRESULT get_CachedDropTargetEffects(SAFEARRAY** retVal);
}

@GUID("6749C683-F70D-4487-A698-5F79D55290D6")
interface IUIAutomationElement2 : IUIAutomationElement
{
    HRESULT get_CurrentOptimizeForVisualContent(int* retVal);
    HRESULT get_CachedOptimizeForVisualContent(int* retVal);
    HRESULT get_CurrentLiveSetting(LiveSetting* retVal);
    HRESULT get_CachedLiveSetting(LiveSetting* retVal);
    HRESULT get_CurrentFlowsFrom(IUIAutomationElementArray* retVal);
    HRESULT get_CachedFlowsFrom(IUIAutomationElementArray* retVal);
}

@GUID("8471DF34-AEE0-4A01-A7DE-7DB9AF12C296")
interface IUIAutomationElement3 : IUIAutomationElement2
{
    HRESULT ShowContextMenu();
    HRESULT get_CurrentIsPeripheral(int* retVal);
    HRESULT get_CachedIsPeripheral(int* retVal);
}

@GUID("3B6E233C-52FB-4063-A4C9-77C075C2A06B")
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

@GUID("98141C1D-0D0E-4175-BBE2-6BFF455842A7")
interface IUIAutomationElement5 : IUIAutomationElement4
{
    HRESULT get_CurrentLandmarkType(int* retVal);
    HRESULT get_CurrentLocalizedLandmarkType(BSTR* retVal);
    HRESULT get_CachedLandmarkType(int* retVal);
    HRESULT get_CachedLocalizedLandmarkType(BSTR* retVal);
}

@GUID("4780D450-8BCA-4977-AFA5-A4A517F555E3")
interface IUIAutomationElement6 : IUIAutomationElement5
{
    HRESULT get_CurrentFullDescription(BSTR* retVal);
    HRESULT get_CachedFullDescription(BSTR* retVal);
}

@GUID("204E8572-CFC3-4C11-B0C8-7DA7420750B7")
interface IUIAutomationElement7 : IUIAutomationElement6
{
    HRESULT FindFirstWithOptions(TreeScope scope_, IUIAutomationCondition condition, 
                                 TreeTraversalOptions traversalOptions, IUIAutomationElement root, 
                                 IUIAutomationElement* found);
    HRESULT FindAllWithOptions(TreeScope scope_, IUIAutomationCondition condition, 
                               TreeTraversalOptions traversalOptions, IUIAutomationElement root, 
                               IUIAutomationElementArray* found);
    HRESULT FindFirstWithOptionsBuildCache(TreeScope scope_, IUIAutomationCondition condition, 
                                           IUIAutomationCacheRequest cacheRequest, 
                                           TreeTraversalOptions traversalOptions, IUIAutomationElement root, 
                                           IUIAutomationElement* found);
    HRESULT FindAllWithOptionsBuildCache(TreeScope scope_, IUIAutomationCondition condition, 
                                         IUIAutomationCacheRequest cacheRequest, 
                                         TreeTraversalOptions traversalOptions, IUIAutomationElement root, 
                                         IUIAutomationElementArray* found);
    HRESULT GetCurrentMetadataValue(int targetId, int metadataId, VARIANT* returnVal);
}

@GUID("8C60217D-5411-4CDE-BCC0-1CEDA223830C")
interface IUIAutomationElement8 : IUIAutomationElement7
{
    HRESULT get_CurrentHeadingLevel(int* retVal);
    HRESULT get_CachedHeadingLevel(int* retVal);
}

@GUID("39325FAC-039D-440E-A3A3-5EB81A5CECC3")
interface IUIAutomationElement9 : IUIAutomationElement8
{
    HRESULT get_CurrentIsDialog(int* retVal);
    HRESULT get_CachedIsDialog(int* retVal);
}

@GUID("85B94ECD-849D-42B6-B94D-D6DB23FDF5A4")
interface IUIAutomationProxyFactory : IUnknown
{
    HRESULT CreateProvider(void* hwnd, int idObject, int idChild, IRawElementProviderSimple* provider);
    HRESULT get_ProxyFactoryId(BSTR* factoryId);
}

@GUID("D50E472E-B64B-490C-BCA1-D30696F9F289")
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

@GUID("09E31E18-872D-4873-93D1-1E541EC133FD")
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

@GUID("C9EE12F2-C13B-4408-997C-639914377F4E")
interface IUIAutomationEventHandlerGroup : IUnknown
{
    HRESULT AddActiveTextPositionChangedEventHandler(TreeScope scope_, IUIAutomationCacheRequest cacheRequest, 
                                                     IUIAutomationActiveTextPositionChangedEventHandler handler);
    HRESULT AddAutomationEventHandler(int eventId, TreeScope scope_, IUIAutomationCacheRequest cacheRequest, 
                                      IUIAutomationEventHandler handler);
    HRESULT AddChangesEventHandler(TreeScope scope_, char* changeTypes, int changesCount, 
                                   IUIAutomationCacheRequest cacheRequest, IUIAutomationChangesEventHandler handler);
    HRESULT AddNotificationEventHandler(TreeScope scope_, IUIAutomationCacheRequest cacheRequest, 
                                        IUIAutomationNotificationEventHandler handler);
    HRESULT AddPropertyChangedEventHandler(TreeScope scope_, IUIAutomationCacheRequest cacheRequest, 
                                           IUIAutomationPropertyChangedEventHandler handler, char* propertyArray, 
                                           int propertyCount);
    HRESULT AddStructureChangedEventHandler(TreeScope scope_, IUIAutomationCacheRequest cacheRequest, 
                                            IUIAutomationStructureChangedEventHandler handler);
    HRESULT AddTextEditTextChangedEventHandler(TreeScope scope_, TextEditChangeType textEditChangeType, 
                                               IUIAutomationCacheRequest cacheRequest, 
                                               IUIAutomationTextEditTextChangedEventHandler handler);
}

@GUID("30CBE57D-D9D0-452A-AB13-7AC5AC4825EE")
interface IUIAutomation : IUnknown
{
    HRESULT CompareElements(IUIAutomationElement el1, IUIAutomationElement el2, int* areSame);
    HRESULT CompareRuntimeIds(SAFEARRAY* runtimeId1, SAFEARRAY* runtimeId2, int* areSame);
    HRESULT GetRootElement(IUIAutomationElement* root);
    HRESULT ElementFromHandle(void* hwnd, IUIAutomationElement* element);
    HRESULT ElementFromPoint(POINT pt, IUIAutomationElement* element);
    HRESULT GetFocusedElement(IUIAutomationElement* element);
    HRESULT GetRootElementBuildCache(IUIAutomationCacheRequest cacheRequest, IUIAutomationElement* root);
    HRESULT ElementFromHandleBuildCache(void* hwnd, IUIAutomationCacheRequest cacheRequest, 
                                        IUIAutomationElement* element);
    HRESULT ElementFromPointBuildCache(POINT pt, IUIAutomationCacheRequest cacheRequest, 
                                       IUIAutomationElement* element);
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
    HRESULT CreatePropertyConditionEx(int propertyId, VARIANT value, PropertyConditionFlags flags, 
                                      IUIAutomationCondition* newCondition);
    HRESULT CreateAndCondition(IUIAutomationCondition condition1, IUIAutomationCondition condition2, 
                               IUIAutomationCondition* newCondition);
    HRESULT CreateAndConditionFromArray(SAFEARRAY* conditions, IUIAutomationCondition* newCondition);
    HRESULT CreateAndConditionFromNativeArray(char* conditions, int conditionCount, 
                                              IUIAutomationCondition* newCondition);
    HRESULT CreateOrCondition(IUIAutomationCondition condition1, IUIAutomationCondition condition2, 
                              IUIAutomationCondition* newCondition);
    HRESULT CreateOrConditionFromArray(SAFEARRAY* conditions, IUIAutomationCondition* newCondition);
    HRESULT CreateOrConditionFromNativeArray(char* conditions, int conditionCount, 
                                             IUIAutomationCondition* newCondition);
    HRESULT CreateNotCondition(IUIAutomationCondition condition, IUIAutomationCondition* newCondition);
    HRESULT AddAutomationEventHandler(int eventId, IUIAutomationElement element, TreeScope scope_, 
                                      IUIAutomationCacheRequest cacheRequest, IUIAutomationEventHandler handler);
    HRESULT RemoveAutomationEventHandler(int eventId, IUIAutomationElement element, 
                                         IUIAutomationEventHandler handler);
    HRESULT AddPropertyChangedEventHandlerNativeArray(IUIAutomationElement element, TreeScope scope_, 
                                                      IUIAutomationCacheRequest cacheRequest, 
                                                      IUIAutomationPropertyChangedEventHandler handler, 
                                                      char* propertyArray, int propertyCount);
    HRESULT AddPropertyChangedEventHandler(IUIAutomationElement element, TreeScope scope_, 
                                           IUIAutomationCacheRequest cacheRequest, 
                                           IUIAutomationPropertyChangedEventHandler handler, 
                                           SAFEARRAY* propertyArray);
    HRESULT RemovePropertyChangedEventHandler(IUIAutomationElement element, 
                                              IUIAutomationPropertyChangedEventHandler handler);
    HRESULT AddStructureChangedEventHandler(IUIAutomationElement element, TreeScope scope_, 
                                            IUIAutomationCacheRequest cacheRequest, 
                                            IUIAutomationStructureChangedEventHandler handler);
    HRESULT RemoveStructureChangedEventHandler(IUIAutomationElement element, 
                                               IUIAutomationStructureChangedEventHandler handler);
    HRESULT AddFocusChangedEventHandler(IUIAutomationCacheRequest cacheRequest, 
                                        IUIAutomationFocusChangedEventHandler handler);
    HRESULT RemoveFocusChangedEventHandler(IUIAutomationFocusChangedEventHandler handler);
    HRESULT RemoveAllEventHandlers();
    HRESULT IntNativeArrayToSafeArray(char* array, int arrayCount, SAFEARRAY** safeArray);
    HRESULT IntSafeArrayToNativeArray(SAFEARRAY* intArray, char* array, int* arrayCount);
    HRESULT RectToVariant(RECT rc, VARIANT* var);
    HRESULT VariantToRect(VARIANT var, RECT* rc);
    HRESULT SafeArrayToRectNativeArray(SAFEARRAY* rects, char* rectArray, int* rectArrayCount);
    HRESULT CreateProxyFactoryEntry(IUIAutomationProxyFactory factory, 
                                    IUIAutomationProxyFactoryEntry* factoryEntry);
    HRESULT get_ProxyFactoryMapping(IUIAutomationProxyFactoryMapping* factoryMapping);
    HRESULT GetPropertyProgrammaticName(int property, BSTR* name);
    HRESULT GetPatternProgrammaticName(int pattern, BSTR* name);
    HRESULT PollForPotentialSupportedPatterns(IUIAutomationElement pElement, SAFEARRAY** patternIds, 
                                              SAFEARRAY** patternNames);
    HRESULT PollForPotentialSupportedProperties(IUIAutomationElement pElement, SAFEARRAY** propertyIds, 
                                                SAFEARRAY** propertyNames);
    HRESULT CheckNotSupported(VARIANT value, int* isNotSupported);
    HRESULT get_ReservedNotSupportedValue(IUnknown* notSupportedValue);
    HRESULT get_ReservedMixedAttributeValue(IUnknown* mixedAttributeValue);
    HRESULT ElementFromIAccessible(IAccessible accessible, int childId, IUIAutomationElement* element);
    HRESULT ElementFromIAccessibleBuildCache(IAccessible accessible, int childId, 
                                             IUIAutomationCacheRequest cacheRequest, IUIAutomationElement* element);
}

@GUID("34723AFF-0C9D-49D0-9896-7AB52DF8CD8A")
interface IUIAutomation2 : IUIAutomation
{
    HRESULT get_AutoSetFocus(int* autoSetFocus);
    HRESULT put_AutoSetFocus(BOOL autoSetFocus);
    HRESULT get_ConnectionTimeout(uint* timeout);
    HRESULT put_ConnectionTimeout(uint timeout);
    HRESULT get_TransactionTimeout(uint* timeout);
    HRESULT put_TransactionTimeout(uint timeout);
}

@GUID("73D768DA-9B51-4B89-936E-C209290973E7")
interface IUIAutomation3 : IUIAutomation2
{
    HRESULT AddTextEditTextChangedEventHandler(IUIAutomationElement element, TreeScope scope_, 
                                               TextEditChangeType textEditChangeType, 
                                               IUIAutomationCacheRequest cacheRequest, 
                                               IUIAutomationTextEditTextChangedEventHandler handler);
    HRESULT RemoveTextEditTextChangedEventHandler(IUIAutomationElement element, 
                                                  IUIAutomationTextEditTextChangedEventHandler handler);
}

@GUID("1189C02A-05F8-4319-8E21-E817E3DB2860")
interface IUIAutomation4 : IUIAutomation3
{
    HRESULT AddChangesEventHandler(IUIAutomationElement element, TreeScope scope_, char* changeTypes, 
                                   int changesCount, IUIAutomationCacheRequest pCacheRequest, 
                                   IUIAutomationChangesEventHandler handler);
    HRESULT RemoveChangesEventHandler(IUIAutomationElement element, IUIAutomationChangesEventHandler handler);
}

@GUID("25F700C8-D816-4057-A9DC-3CBDEE77E256")
interface IUIAutomation5 : IUIAutomation4
{
    HRESULT AddNotificationEventHandler(IUIAutomationElement element, TreeScope scope_, 
                                        IUIAutomationCacheRequest cacheRequest, 
                                        IUIAutomationNotificationEventHandler handler);
    HRESULT RemoveNotificationEventHandler(IUIAutomationElement element, 
                                           IUIAutomationNotificationEventHandler handler);
}


// GUIDs

const GUID CLSID_AccClientDocMgr        = GUIDOF!AccClientDocMgr;
const GUID CLSID_AccDictionary          = GUIDOF!AccDictionary;
const GUID CLSID_AccServerDocMgr        = GUIDOF!AccServerDocMgr;
const GUID CLSID_AccStore               = GUIDOF!AccStore;
const GUID CLSID_CAccPropServices       = GUIDOF!CAccPropServices;
const GUID CLSID_CUIAutomation          = GUIDOF!CUIAutomation;
const GUID CLSID_CUIAutomation8         = GUIDOF!CUIAutomation8;
const GUID CLSID_CUIAutomationRegistrar = GUIDOF!CUIAutomationRegistrar;
const GUID CLSID_DocWrap                = GUIDOF!DocWrap;
const GUID CLSID_MSAAControl            = GUIDOF!MSAAControl;

const GUID IID_IAccClientDocMgr                                   = GUIDOF!IAccClientDocMgr;
const GUID IID_IAccDictionary                                     = GUIDOF!IAccDictionary;
const GUID IID_IAccIdentity                                       = GUIDOF!IAccIdentity;
const GUID IID_IAccPropServer                                     = GUIDOF!IAccPropServer;
const GUID IID_IAccPropServices                                   = GUIDOF!IAccPropServices;
const GUID IID_IAccServerDocMgr                                   = GUIDOF!IAccServerDocMgr;
const GUID IID_IAccStore                                          = GUIDOF!IAccStore;
const GUID IID_IAccessible                                        = GUIDOF!IAccessible;
const GUID IID_IAccessibleEx                                      = GUIDOF!IAccessibleEx;
const GUID IID_IAccessibleHandler                                 = GUIDOF!IAccessibleHandler;
const GUID IID_IAccessibleHostingElementProviders                 = GUIDOF!IAccessibleHostingElementProviders;
const GUID IID_IAccessibleWindowlessSite                          = GUIDOF!IAccessibleWindowlessSite;
const GUID IID_IAnnotationProvider                                = GUIDOF!IAnnotationProvider;
const GUID IID_IClonableWrapper                                   = GUIDOF!IClonableWrapper;
const GUID IID_ICoCreateLocally                                   = GUIDOF!ICoCreateLocally;
const GUID IID_ICoCreatedLocally                                  = GUIDOF!ICoCreatedLocally;
const GUID IID_ICustomNavigationProvider                          = GUIDOF!ICustomNavigationProvider;
const GUID IID_IDocWrap                                           = GUIDOF!IDocWrap;
const GUID IID_IDockProvider                                      = GUIDOF!IDockProvider;
const GUID IID_IDragProvider                                      = GUIDOF!IDragProvider;
const GUID IID_IDropTargetProvider                                = GUIDOF!IDropTargetProvider;
const GUID IID_IExpandCollapseProvider                            = GUIDOF!IExpandCollapseProvider;
const GUID IID_IGridItemProvider                                  = GUIDOF!IGridItemProvider;
const GUID IID_IGridProvider                                      = GUIDOF!IGridProvider;
const GUID IID_IInternalDocWrap                                   = GUIDOF!IInternalDocWrap;
const GUID IID_IInvokeProvider                                    = GUIDOF!IInvokeProvider;
const GUID IID_IItemContainerProvider                             = GUIDOF!IItemContainerProvider;
const GUID IID_ILegacyIAccessibleProvider                         = GUIDOF!ILegacyIAccessibleProvider;
const GUID IID_IMultipleViewProvider                              = GUIDOF!IMultipleViewProvider;
const GUID IID_IObjectModelProvider                               = GUIDOF!IObjectModelProvider;
const GUID IID_IProxyProviderWinEventHandler                      = GUIDOF!IProxyProviderWinEventHandler;
const GUID IID_IProxyProviderWinEventSink                         = GUIDOF!IProxyProviderWinEventSink;
const GUID IID_IRangeValueProvider                                = GUIDOF!IRangeValueProvider;
const GUID IID_IRawElementProviderAdviseEvents                    = GUIDOF!IRawElementProviderAdviseEvents;
const GUID IID_IRawElementProviderFragment                        = GUIDOF!IRawElementProviderFragment;
const GUID IID_IRawElementProviderFragmentRoot                    = GUIDOF!IRawElementProviderFragmentRoot;
const GUID IID_IRawElementProviderHostingAccessibles              = GUIDOF!IRawElementProviderHostingAccessibles;
const GUID IID_IRawElementProviderHwndOverride                    = GUIDOF!IRawElementProviderHwndOverride;
const GUID IID_IRawElementProviderSimple                          = GUIDOF!IRawElementProviderSimple;
const GUID IID_IRawElementProviderSimple2                         = GUIDOF!IRawElementProviderSimple2;
const GUID IID_IRawElementProviderSimple3                         = GUIDOF!IRawElementProviderSimple3;
const GUID IID_IRawElementProviderWindowlessSite                  = GUIDOF!IRawElementProviderWindowlessSite;
const GUID IID_IScrollItemProvider                                = GUIDOF!IScrollItemProvider;
const GUID IID_IScrollProvider                                    = GUIDOF!IScrollProvider;
const GUID IID_ISelectionItemProvider                             = GUIDOF!ISelectionItemProvider;
const GUID IID_ISelectionProvider                                 = GUIDOF!ISelectionProvider;
const GUID IID_ISelectionProvider2                                = GUIDOF!ISelectionProvider2;
const GUID IID_ISpreadsheetItemProvider                           = GUIDOF!ISpreadsheetItemProvider;
const GUID IID_ISpreadsheetProvider                               = GUIDOF!ISpreadsheetProvider;
const GUID IID_IStylesProvider                                    = GUIDOF!IStylesProvider;
const GUID IID_ISynchronizedInputProvider                         = GUIDOF!ISynchronizedInputProvider;
const GUID IID_ITableItemProvider                                 = GUIDOF!ITableItemProvider;
const GUID IID_ITableProvider                                     = GUIDOF!ITableProvider;
const GUID IID_ITextChildProvider                                 = GUIDOF!ITextChildProvider;
const GUID IID_ITextEditProvider                                  = GUIDOF!ITextEditProvider;
const GUID IID_ITextProvider                                      = GUIDOF!ITextProvider;
const GUID IID_ITextProvider2                                     = GUIDOF!ITextProvider2;
const GUID IID_ITextRangeProvider                                 = GUIDOF!ITextRangeProvider;
const GUID IID_ITextRangeProvider2                                = GUIDOF!ITextRangeProvider2;
const GUID IID_ITextStoreACPEx                                    = GUIDOF!ITextStoreACPEx;
const GUID IID_ITextStoreACPSinkEx                                = GUIDOF!ITextStoreACPSinkEx;
const GUID IID_ITextStoreAnchorEx                                 = GUIDOF!ITextStoreAnchorEx;
const GUID IID_ITextStoreSinkAnchorEx                             = GUIDOF!ITextStoreSinkAnchorEx;
const GUID IID_IToggleProvider                                    = GUIDOF!IToggleProvider;
const GUID IID_ITransformProvider                                 = GUIDOF!ITransformProvider;
const GUID IID_ITransformProvider2                                = GUIDOF!ITransformProvider2;
const GUID IID_IUIAutomation                                      = GUIDOF!IUIAutomation;
const GUID IID_IUIAutomation2                                     = GUIDOF!IUIAutomation2;
const GUID IID_IUIAutomation3                                     = GUIDOF!IUIAutomation3;
const GUID IID_IUIAutomation4                                     = GUIDOF!IUIAutomation4;
const GUID IID_IUIAutomation5                                     = GUIDOF!IUIAutomation5;
const GUID IID_IUIAutomationActiveTextPositionChangedEventHandler = GUIDOF!IUIAutomationActiveTextPositionChangedEventHandler;
const GUID IID_IUIAutomationAndCondition                          = GUIDOF!IUIAutomationAndCondition;
const GUID IID_IUIAutomationAnnotationPattern                     = GUIDOF!IUIAutomationAnnotationPattern;
const GUID IID_IUIAutomationBoolCondition                         = GUIDOF!IUIAutomationBoolCondition;
const GUID IID_IUIAutomationCacheRequest                          = GUIDOF!IUIAutomationCacheRequest;
const GUID IID_IUIAutomationChangesEventHandler                   = GUIDOF!IUIAutomationChangesEventHandler;
const GUID IID_IUIAutomationCondition                             = GUIDOF!IUIAutomationCondition;
const GUID IID_IUIAutomationCustomNavigationPattern               = GUIDOF!IUIAutomationCustomNavigationPattern;
const GUID IID_IUIAutomationDockPattern                           = GUIDOF!IUIAutomationDockPattern;
const GUID IID_IUIAutomationDragPattern                           = GUIDOF!IUIAutomationDragPattern;
const GUID IID_IUIAutomationDropTargetPattern                     = GUIDOF!IUIAutomationDropTargetPattern;
const GUID IID_IUIAutomationElement                               = GUIDOF!IUIAutomationElement;
const GUID IID_IUIAutomationElement2                              = GUIDOF!IUIAutomationElement2;
const GUID IID_IUIAutomationElement3                              = GUIDOF!IUIAutomationElement3;
const GUID IID_IUIAutomationElement4                              = GUIDOF!IUIAutomationElement4;
const GUID IID_IUIAutomationElement5                              = GUIDOF!IUIAutomationElement5;
const GUID IID_IUIAutomationElement6                              = GUIDOF!IUIAutomationElement6;
const GUID IID_IUIAutomationElement7                              = GUIDOF!IUIAutomationElement7;
const GUID IID_IUIAutomationElement8                              = GUIDOF!IUIAutomationElement8;
const GUID IID_IUIAutomationElement9                              = GUIDOF!IUIAutomationElement9;
const GUID IID_IUIAutomationElementArray                          = GUIDOF!IUIAutomationElementArray;
const GUID IID_IUIAutomationEventHandler                          = GUIDOF!IUIAutomationEventHandler;
const GUID IID_IUIAutomationEventHandlerGroup                     = GUIDOF!IUIAutomationEventHandlerGroup;
const GUID IID_IUIAutomationExpandCollapsePattern                 = GUIDOF!IUIAutomationExpandCollapsePattern;
const GUID IID_IUIAutomationFocusChangedEventHandler              = GUIDOF!IUIAutomationFocusChangedEventHandler;
const GUID IID_IUIAutomationGridItemPattern                       = GUIDOF!IUIAutomationGridItemPattern;
const GUID IID_IUIAutomationGridPattern                           = GUIDOF!IUIAutomationGridPattern;
const GUID IID_IUIAutomationInvokePattern                         = GUIDOF!IUIAutomationInvokePattern;
const GUID IID_IUIAutomationItemContainerPattern                  = GUIDOF!IUIAutomationItemContainerPattern;
const GUID IID_IUIAutomationLegacyIAccessiblePattern              = GUIDOF!IUIAutomationLegacyIAccessiblePattern;
const GUID IID_IUIAutomationMultipleViewPattern                   = GUIDOF!IUIAutomationMultipleViewPattern;
const GUID IID_IUIAutomationNotCondition                          = GUIDOF!IUIAutomationNotCondition;
const GUID IID_IUIAutomationNotificationEventHandler              = GUIDOF!IUIAutomationNotificationEventHandler;
const GUID IID_IUIAutomationObjectModelPattern                    = GUIDOF!IUIAutomationObjectModelPattern;
const GUID IID_IUIAutomationOrCondition                           = GUIDOF!IUIAutomationOrCondition;
const GUID IID_IUIAutomationPatternHandler                        = GUIDOF!IUIAutomationPatternHandler;
const GUID IID_IUIAutomationPatternInstance                       = GUIDOF!IUIAutomationPatternInstance;
const GUID IID_IUIAutomationPropertyChangedEventHandler           = GUIDOF!IUIAutomationPropertyChangedEventHandler;
const GUID IID_IUIAutomationPropertyCondition                     = GUIDOF!IUIAutomationPropertyCondition;
const GUID IID_IUIAutomationProxyFactory                          = GUIDOF!IUIAutomationProxyFactory;
const GUID IID_IUIAutomationProxyFactoryEntry                     = GUIDOF!IUIAutomationProxyFactoryEntry;
const GUID IID_IUIAutomationProxyFactoryMapping                   = GUIDOF!IUIAutomationProxyFactoryMapping;
const GUID IID_IUIAutomationRangeValuePattern                     = GUIDOF!IUIAutomationRangeValuePattern;
const GUID IID_IUIAutomationRegistrar                             = GUIDOF!IUIAutomationRegistrar;
const GUID IID_IUIAutomationScrollItemPattern                     = GUIDOF!IUIAutomationScrollItemPattern;
const GUID IID_IUIAutomationScrollPattern                         = GUIDOF!IUIAutomationScrollPattern;
const GUID IID_IUIAutomationSelectionItemPattern                  = GUIDOF!IUIAutomationSelectionItemPattern;
const GUID IID_IUIAutomationSelectionPattern                      = GUIDOF!IUIAutomationSelectionPattern;
const GUID IID_IUIAutomationSelectionPattern2                     = GUIDOF!IUIAutomationSelectionPattern2;
const GUID IID_IUIAutomationSpreadsheetItemPattern                = GUIDOF!IUIAutomationSpreadsheetItemPattern;
const GUID IID_IUIAutomationSpreadsheetPattern                    = GUIDOF!IUIAutomationSpreadsheetPattern;
const GUID IID_IUIAutomationStructureChangedEventHandler          = GUIDOF!IUIAutomationStructureChangedEventHandler;
const GUID IID_IUIAutomationStylesPattern                         = GUIDOF!IUIAutomationStylesPattern;
const GUID IID_IUIAutomationSynchronizedInputPattern              = GUIDOF!IUIAutomationSynchronizedInputPattern;
const GUID IID_IUIAutomationTableItemPattern                      = GUIDOF!IUIAutomationTableItemPattern;
const GUID IID_IUIAutomationTablePattern                          = GUIDOF!IUIAutomationTablePattern;
const GUID IID_IUIAutomationTextChildPattern                      = GUIDOF!IUIAutomationTextChildPattern;
const GUID IID_IUIAutomationTextEditPattern                       = GUIDOF!IUIAutomationTextEditPattern;
const GUID IID_IUIAutomationTextEditTextChangedEventHandler       = GUIDOF!IUIAutomationTextEditTextChangedEventHandler;
const GUID IID_IUIAutomationTextPattern                           = GUIDOF!IUIAutomationTextPattern;
const GUID IID_IUIAutomationTextPattern2                          = GUIDOF!IUIAutomationTextPattern2;
const GUID IID_IUIAutomationTextRange                             = GUIDOF!IUIAutomationTextRange;
const GUID IID_IUIAutomationTextRange2                            = GUIDOF!IUIAutomationTextRange2;
const GUID IID_IUIAutomationTextRange3                            = GUIDOF!IUIAutomationTextRange3;
const GUID IID_IUIAutomationTextRangeArray                        = GUIDOF!IUIAutomationTextRangeArray;
const GUID IID_IUIAutomationTogglePattern                         = GUIDOF!IUIAutomationTogglePattern;
const GUID IID_IUIAutomationTransformPattern                      = GUIDOF!IUIAutomationTransformPattern;
const GUID IID_IUIAutomationTransformPattern2                     = GUIDOF!IUIAutomationTransformPattern2;
const GUID IID_IUIAutomationTreeWalker                            = GUIDOF!IUIAutomationTreeWalker;
const GUID IID_IUIAutomationValuePattern                          = GUIDOF!IUIAutomationValuePattern;
const GUID IID_IUIAutomationVirtualizedItemPattern                = GUIDOF!IUIAutomationVirtualizedItemPattern;
const GUID IID_IUIAutomationWindowPattern                         = GUIDOF!IUIAutomationWindowPattern;
const GUID IID_IValueProvider                                     = GUIDOF!IValueProvider;
const GUID IID_IVersionInfo                                       = GUIDOF!IVersionInfo;
const GUID IID_IVirtualizedItemProvider                           = GUIDOF!IVirtualizedItemProvider;
const GUID IID_IWindowProvider                                    = GUIDOF!IWindowProvider;
