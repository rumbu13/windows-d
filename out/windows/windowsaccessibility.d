// Written in the D programming language.

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

///Contains values used to specify the direction of navigation within the Microsoft UI Automation tree.
enum NavigateDirection : int
{
    ///The navigation direction is to the parent.
    NavigateDirection_Parent          = 0x00000000,
    ///The navigation direction is to the next sibling.
    NavigateDirection_NextSibling     = 0x00000001,
    ///The navigation direction is to the previous sibling.
    NavigateDirection_PreviousSibling = 0x00000002,
    ///The navigation direction is to the first child.
    NavigateDirection_FirstChild      = 0x00000003,
    ///The navigation direction is to the last child.
    NavigateDirection_LastChild       = 0x00000004,
}

///Contains values that specify the type of UI Automation provider. The IRawElementProviderSimple::ProviderOptions
///property uses this enumeration.
enum ProviderOptions : int
{
    ///The provider is a client-side (proxy) provider.
    ProviderOptions_ClientSideProvider     = 0x00000001,
    ///The provider is a server-side provider.
    ProviderOptions_ServerSideProvider     = 0x00000002,
    ///The provider is a non-client-area provider.
    ProviderOptions_NonClientAreaProvider  = 0x00000004,
    ///The provider overrides another provider.
    ProviderOptions_OverrideProvider       = 0x00000008,
    ///The provider handles its own focus, and does not want UI Automation to set focus to the nearest window on its
    ///behalf. This option is typically used by providers for windows that appear to take focus without actually
    ///receiving Win32 focus, such as menus and drop-downs.
    ProviderOptions_ProviderOwnsSetFocus   = 0x00000010,
    ///The provider has explicit support for COM threading models, so that calls by UI Automation on COM-based providers
    ///are received on the appropriate thread. This means that STA-based provider implementations will be called back on
    ///their own STA thread, and therefore do not need extra synchronization to safely access resources that belong to
    ///that STA. MTA-based provider implementations will be called back on some other thread in the MTA, and will
    ///require appropriate synchronization to be added, as is usual for MTA code.
    ProviderOptions_UseComThreading        = 0x00000020,
    ///The provider handles its own non-client area and does not want UI Automation to provide default accessibility
    ///support for controls in the non-client area, such as minimize/maximize buttons and menu bars.
    ProviderOptions_RefuseNonClientSupport = 0x00000040,
    ///The provider implements the IAccessible interface.
    ProviderOptions_HasNativeIAccessible   = 0x00000080,
    ///The provider works in client coordinates instead of screen coordinates.
    ProviderOptions_UseClientCoordinates   = 0x00000100,
}

///Contains values that specify the type of change in the Microsoft UI Automation tree structure.
enum StructureChangeType : int
{
    ///A child element was added to the UI Automation element tree.
    StructureChangeType_ChildAdded          = 0x00000000,
    ///A child element was removed from the UI Automation element tree.
    StructureChangeType_ChildRemoved        = 0x00000001,
    ///Child elements were invalidated in the UI Automation element tree. This might mean that one or more child
    ///elements were added or removed, or a combination of both. This value can also indicate that one subtree in the UI
    ///was substituted for another. For example, the entire contents of a dialog box changed at once, or the view of a
    ///list changed because an Explorer-type application navigated to another location. The exact meaning depends on the
    ///UI Automation provider implementation.
    StructureChangeType_ChildrenInvalidated = 0x00000002,
    ///Child elements were added in bulk to the UI Automation element tree.
    StructureChangeType_ChildrenBulkAdded   = 0x00000003,
    ///Child elements were removed in bulk from the UI Automation element tree.
    StructureChangeType_ChildrenBulkRemoved = 0x00000004,
    ///The order of child elements has changed in the UI Automation element tree. Child elements may or may not have
    ///been added or removed.
    StructureChangeType_ChildrenReordered   = 0x00000005,
}

///Describes the text editing change being performed by controls when text-edit events are raised or handled.
enum TextEditChangeType : int
{
    ///Not related to a specific change type.
    TextEditChangeType_None                 = 0x00000000,
    ///Change is from an auto-correct action performed by a control.
    TextEditChangeType_AutoCorrect          = 0x00000001,
    ///Change is from an IME active composition within a control.
    TextEditChangeType_Composition          = 0x00000002,
    ///Change is from an IME composition going from active to finalized state within a control. <div
    ///class="alert"><b>Note</b> The finalized string may be empty if composition was canceled or deleted.</div> <div>
    ///</div>
    TextEditChangeType_CompositionFinalized = 0x00000003,
    TextEditChangeType_AutoComplete         = 0x00000004,
}

///Contains values that specify the orientation of a control.
enum OrientationType : int
{
    ///The control has no orientation.
    OrientationType_None       = 0x00000000,
    ///The control has horizontal orientation.
    OrientationType_Horizontal = 0x00000001,
    ///The control has vertical orientation.
    OrientationType_Vertical   = 0x00000002,
}

///Contains values that specify the location of a docking window represented by the Dock <i>control pattern</i>.
enum DockPosition : int
{
    ///The window is docked at the top.
    DockPosition_Top    = 0x00000000,
    ///The window is docked at the left.
    DockPosition_Left   = 0x00000001,
    ///The window is docked at the bottom.
    DockPosition_Bottom = 0x00000002,
    ///The window is docked at the right.
    DockPosition_Right  = 0x00000003,
    ///The window is docked on all four sides.
    DockPosition_Fill   = 0x00000004,
    ///The window is not docked.
    DockPosition_None   = 0x00000005,
}

///Contains values that specify the state of a UI element that can be expanded and collapsed.
enum ExpandCollapseState : int
{
    ///No children are visible.
    ExpandCollapseState_Collapsed         = 0x00000000,
    ///All children are visible.
    ExpandCollapseState_Expanded          = 0x00000001,
    ///Some, but not all, children are visible.
    ExpandCollapseState_PartiallyExpanded = 0x00000002,
    ///The element does not expand or collapse.
    ExpandCollapseState_LeafNode          = 0x00000003,
}

///Contains values that specify the direction and distance to scroll.
enum ScrollAmount : int
{
    ///Scrolling is done in large decrements, equivalent to pressing the PAGE UP key or clicking on a blank part of a
    ///scroll bar. If one page up is not a relevant amount for the control and no scroll bar exists, the value
    ///represents an amount equal to the current visible window.
    ScrollAmount_LargeDecrement = 0x00000000,
    ///Scrolling is done in small decrements, equivalent to pressing an arrow key or clicking the arrow button on a
    ///scroll bar.
    ScrollAmount_SmallDecrement = 0x00000001,
    ///No scrolling is done.
    ScrollAmount_NoAmount       = 0x00000002,
    ///Scrolling is done in large increments, equivalent to pressing the PAGE DOWN or PAGE UP key or clicking on a blank
    ///part of a scroll bar. If one page is not a relevant amount for the control and no scroll bar exists, the value
    ///represents an amount equal to the current visible window.
    ScrollAmount_LargeIncrement = 0x00000003,
    ///Scrolling is done in small increments, equivalent to pressing an arrow key or clicking the arrow button on a
    ///scroll bar.
    ScrollAmount_SmallIncrement = 0x00000004,
}

///Contains values that specify whether data in a table should be read primarily by row or by column.
enum RowOrColumnMajor : int
{
    ///Data in the table should be read row by row.
    RowOrColumnMajor_RowMajor      = 0x00000000,
    ///Data in the table should be read column by column.
    RowOrColumnMajor_ColumnMajor   = 0x00000001,
    ///The best way to present the data is indeterminate.
    RowOrColumnMajor_Indeterminate = 0x00000002,
}

///Contains values that specify the toggle state of a Microsoft UI Automation element that implements the Toggle
///<i>control pattern</i>.
enum ToggleState : int
{
    ///The UI Automation element is not selected, checked, marked or otherwise activated.
    ToggleState_Off           = 0x00000000,
    ///The UI Automation element is selected, checked, marked or otherwise activated.
    ToggleState_On            = 0x00000001,
    ///The UI Automation element is in an indeterminate state. The Indeterminate property can be used to indicate
    ///whether the user has acted on a control. For example, a check box can appear checked and dimmed, indicating an
    ///indeterminate state. Creating an indeterminate state is different from disabling the control. Consequently, a
    ///check box in the indeterminate state can still receive the focus. When the user clicks an indeterminate control
    ///the ToggleState cycles to its next value.
    ToggleState_Indeterminate = 0x00000002,
}

///Contains values that specify the visual state of a window.
enum WindowVisualState : int
{
    ///The window is normal (restored).
    WindowVisualState_Normal    = 0x00000000,
    ///The window is maximized.
    WindowVisualState_Maximized = 0x00000001,
    ///The window is minimized.
    WindowVisualState_Minimized = 0x00000002,
}

///Contains values that specify the type of synchronized input.
enum SynchronizedInputType : int
{
    ///A key has been released.
    SynchronizedInputType_KeyUp          = 0x00000001,
    ///A key has been pressed.
    SynchronizedInputType_KeyDown        = 0x00000002,
    ///The left mouse button has been released.
    SynchronizedInputType_LeftMouseUp    = 0x00000004,
    ///The left mouse button has been pressed.
    SynchronizedInputType_LeftMouseDown  = 0x00000008,
    ///The right mouse button has been released.
    SynchronizedInputType_RightMouseUp   = 0x00000010,
    SynchronizedInputType_RightMouseDown = 0x00000020,
}

///Contains values that specify the current state of the window for purposes of user interaction.
enum WindowInteractionState : int
{
    ///The window is running. This does not guarantee that the window is ready for user interaction or is responding.
    WindowInteractionState_Running                 = 0x00000000,
    ///The window is closing.
    WindowInteractionState_Closing                 = 0x00000001,
    ///The window is ready for user interaction.
    WindowInteractionState_ReadyForUserInteraction = 0x00000002,
    ///The window is blocked by a modal window.
    WindowInteractionState_BlockedByModalWindow    = 0x00000003,
    ///The window is not responding.
    WindowInteractionState_NotResponding           = 0x00000004,
}

///Defines the values that indicate how a text-to-speech engine should interpret specific data.
enum SayAsInterpretAs : int
{
    ///The text should be spoken using the default for the text-to-speech engine.
    SayAsInterpretAs_None                       = 0x00000000,
    ///The text should be spoken character by character.
    SayAsInterpretAs_Spell                      = 0x00000001,
    ///The text is an integral or decimal number and should be spoken as a cardinal number.
    SayAsInterpretAs_Cardinal                   = 0x00000002,
    ///The text is an integral number and should be spoken as an ordinal number.
    SayAsInterpretAs_Ordinal                    = 0x00000003,
    ///The text should be spoken as a number.
    SayAsInterpretAs_Number                     = 0x00000004,
    ///The text should be spoken as a date.
    SayAsInterpretAs_Date                       = 0x00000005,
    ///The text should be spoken as a time value.
    SayAsInterpretAs_Time                       = 0x00000006,
    ///The text should be spoken as a telephone number.
    SayAsInterpretAs_Telephone                  = 0x00000007,
    ///The text should be spoken as currency.
    SayAsInterpretAs_Currency                   = 0x00000008,
    ///The text should be spoken as a network address, including saying the '\', '/', and '@' characters.
    SayAsInterpretAs_Net                        = 0x00000009,
    ///The text should be spoken as a URL.
    SayAsInterpretAs_Url                        = 0x0000000a,
    ///The text should be spoken as an address.
    SayAsInterpretAs_Address                    = 0x0000000b,
    ///The text should be spoken as an alphanumeric number.
    SayAsInterpretAs_Alphanumeric               = 0x0000000c,
    ///The text should be spoken as a name.
    SayAsInterpretAs_Name                       = 0x0000000d,
    ///The text should be spoken as media.
    SayAsInterpretAs_Media                      = 0x0000000e,
    ///The text should be spoken as a date in a Month/Day/Year format.
    SayAsInterpretAs_Date_MonthDayYear          = 0x0000000f,
    ///The text should be spoken as a date in a Day/Month/Year format.
    SayAsInterpretAs_Date_DayMonthYear          = 0x00000010,
    ///The text should be spoken as a date in a Year/Month/Day format.
    SayAsInterpretAs_Date_YearMonthDay          = 0x00000011,
    ///The text should be spoken as a date in a Year/Month format.
    SayAsInterpretAs_Date_YearMonth             = 0x00000012,
    ///The text should be spoken as a date in a Month/Year format.
    SayAsInterpretAs_Date_MonthYear             = 0x00000013,
    ///The text should be spoken as a date in a Day/Month format.
    SayAsInterpretAs_Date_DayMonth              = 0x00000014,
    ///The text should be spoken as a date in a Month/Day format.
    SayAsInterpretAs_Date_MonthDay              = 0x00000015,
    ///The text should be spoken as a date in a Year format.
    SayAsInterpretAs_Date_Year                  = 0x00000016,
    ///The text should be spoken as a time value in an Hours:Minutes:Seconds 12-hour format.
    SayAsInterpretAs_Time_HoursMinutesSeconds12 = 0x00000017,
    ///The text should be spoken as a time value in an Hours:Minutes 12-hour format.
    SayAsInterpretAs_Time_HoursMinutes12        = 0x00000018,
    ///The text should be spoken as a time value in an Hours:Minutes:Seconds 24-hour format.
    SayAsInterpretAs_Time_HoursMinutesSeconds24 = 0x00000019,
    SayAsInterpretAs_Time_HoursMinutes24        = 0x0000001a,
}

///Contains values that specify units of text for the purposes of navigation.
enum TextUnit : int
{
    ///Character.
    TextUnit_Character = 0x00000000,
    ///Format.
    TextUnit_Format    = 0x00000001,
    ///Word.
    TextUnit_Word      = 0x00000002,
    ///Line.
    TextUnit_Line      = 0x00000003,
    ///Paragraph.
    TextUnit_Paragraph = 0x00000004,
    ///Page.
    TextUnit_Page      = 0x00000005,
    ///Document.
    TextUnit_Document  = 0x00000006,
}

///Contains values that specify the endpoints of a text range.
enum TextPatternRangeEndpoint : int
{
    ///The starting endpoint of the range.
    TextPatternRangeEndpoint_Start = 0x00000000,
    ///The ending endpoint of the range.
    TextPatternRangeEndpoint_End   = 0x00000001,
}

///Contains values that specify the supported text selection attribute.
enum SupportedTextSelection : int
{
    ///Does not support text selections.
    SupportedTextSelection_None     = 0x00000000,
    ///Supports a single, continuous text selection.
    SupportedTextSelection_Single   = 0x00000001,
    ///Supports multiple, disjoint text selections.
    SupportedTextSelection_Multiple = 0x00000002,
}

///Contains possible values for the LiveSetting property. This property is implemented by provider elements that are
///part of a live region.
enum LiveSetting : int
{
    Off       = 0x00000000,
    Polite    = 0x00000001,
    Assertive = 0x00000002,
}

///Contains possible values for the SelectionActiveEnd text attribute, which indicates the location of the caret
///relative to a text range that represents the currently selected text.
enum ActiveEnd : int
{
    ///The caret is not at either end of the text range.
    ActiveEnd_None  = 0x00000000,
    ///The caret is at the beginning of the text range.
    ActiveEnd_Start = 0x00000001,
    ActiveEnd_End   = 0x00000002,
}

///Contains possible values for the CaretPosition text attribute, which indicates the location of the caret relative to
///a line of text in a text range.
enum CaretPosition : int
{
    ///The caret is not at the beginning or the end of a line.
    CaretPosition_Unknown         = 0x00000000,
    ///The caret is at the end of a line.
    CaretPosition_EndOfLine       = 0x00000001,
    ///The caret is at the beginning of a line.
    CaretPosition_BeginningOfLine = 0x00000002,
}

///Contains possible values for the CaretBidiMode text attribute, which indicates whether the caret is in text that
///flows from left to right, or from right to left.
enum CaretBidiMode : int
{
    ///The caret is in text that flows from left to right.
    CaretBidiMode_LTR = 0x00000000,
    CaretBidiMode_RTL = 0x00000001,
}

///Contains possible values for the IUIAutomationTransformPattern2::ZoomByUnit method, which zooms the viewport of a
///control by the specified unit.
enum ZoomUnit : int
{
    ///No increase or decrease in zoom.
    ZoomUnit_NoAmount       = 0x00000000,
    ///Decrease zoom by a large decrement.
    ZoomUnit_LargeDecrement = 0x00000001,
    ///Decrease zoom by a small decrement.
    ZoomUnit_SmallDecrement = 0x00000002,
    ///Increase zoom by a large increment.
    ZoomUnit_LargeIncrement = 0x00000003,
    ///Increase zoom by a small increment.
    ZoomUnit_SmallIncrement = 0x00000004,
}

///Contains values for the AnimationStyle text attribute.
enum AnimationStyle : int
{
    ///None.
    AnimationStyle_None               = 0x00000000,
    ///The bounding rectangle displays a border of alternating icons of different colors.
    AnimationStyle_LasVegasLights     = 0x00000001,
    ///The font and background alternate between assigned colors and contrasting colors.
    AnimationStyle_BlinkingBackground = 0x00000002,
    ///The background displays flashing, multicolored icons.
    AnimationStyle_SparkleText        = 0x00000003,
    ///The bounding rectangle displays moving black dashes.
    AnimationStyle_MarchingBlackAnts  = 0x00000004,
    ///The bounding rectangle displays moving red dashes.
    AnimationStyle_MarchingRedAnts    = 0x00000005,
    ///The font alternates between solid and blurred.
    AnimationStyle_Shimmer            = 0x00000006,
    ///Other.
    AnimationStyle_Other              = 0xffffffff,
}

///Contains values for the BulletStyle text attribute.
enum BulletStyle : int
{
    ///None.
    BulletStyle_None               = 0x00000000,
    ///Hollow round bullet.
    BulletStyle_HollowRoundBullet  = 0x00000001,
    ///Filled round bullet.
    BulletStyle_FilledRoundBullet  = 0x00000002,
    ///Hollow square bullet.
    BulletStyle_HollowSquareBullet = 0x00000003,
    ///Filled square bullet.
    BulletStyle_FilledSquareBullet = 0x00000004,
    ///Dash bullet.
    BulletStyle_DashBullet         = 0x00000005,
    ///Other.
    BulletStyle_Other              = 0xffffffff,
}

///Contains values that specify the value of the CapStyle text attribute.
enum CapStyle : int
{
    ///None.
    CapStyle_None          = 0x00000000,
    ///Small capitals.
    CapStyle_SmallCap      = 0x00000001,
    ///All capitals.
    CapStyle_AllCap        = 0x00000002,
    ///All petite capitals.
    CapStyle_AllPetiteCaps = 0x00000003,
    ///Petite capitals.
    CapStyle_PetiteCaps    = 0x00000004,
    ///Single case.
    CapStyle_Unicase       = 0x00000005,
    ///Title case.
    CapStyle_Titling       = 0x00000006,
    CapStyle_Other         = 0xffffffff,
}

///Contains values for the FillType attribute.
enum FillType : int
{
    ///The element is not filled.
    FillType_None     = 0x00000000,
    ///The element is filled with a solid color.
    FillType_Color    = 0x00000001,
    ///The element is filled with a gradient.
    FillType_Gradient = 0x00000002,
    ///The element is filled using a picture.
    FillType_Picture  = 0x00000003,
    ///The element is filled using a pattern.
    FillType_Pattern  = 0x00000004,
}

///Contains values for the TextFlowDirections text attribute.
enum FlowDirections : int
{
    ///The default flow direction.
    FlowDirections_Default     = 0x00000000,
    ///The text flows from right to left.
    FlowDirections_RightToLeft = 0x00000001,
    ///The text flows from bottom to top.
    FlowDirections_BottomToTop = 0x00000002,
    ///The text flows vertically.
    FlowDirections_Vertical    = 0x00000004,
}

enum HorizontalTextAlignment : int
{
    HorizontalTextAlignment_Left      = 0x00000000,
    HorizontalTextAlignment_Centered  = 0x00000001,
    HorizontalTextAlignment_Right     = 0x00000002,
    HorizontalTextAlignment_Justified = 0x00000003,
}

///Contains values for the OutlineStyle text attribute.
enum OutlineStyles : int
{
    ///No outline style.
    OutlineStyles_None     = 0x00000000,
    ///A simple outline.
    OutlineStyles_Outline  = 0x00000001,
    ///A shadow.
    OutlineStyles_Shadow   = 0x00000002,
    ///An engraved appearance.
    OutlineStyles_Engraved = 0x00000004,
    ///An embossed appearance.
    OutlineStyles_Embossed = 0x00000008,
}

///Contains values that specify the OverlineStyle, StrikethroughStyle, and UnderlineStyle text attributes.
enum TextDecorationLineStyle : int
{
    ///No line style.
    TextDecorationLineStyle_None            = 0x00000000,
    ///A single solid line.
    TextDecorationLineStyle_Single          = 0x00000001,
    ///Only words (not spaces) are underlined.
    TextDecorationLineStyle_WordsOnly       = 0x00000002,
    ///A double line.
    TextDecorationLineStyle_Double          = 0x00000003,
    ///A dotted line.
    TextDecorationLineStyle_Dot             = 0x00000004,
    ///A dashed line.
    TextDecorationLineStyle_Dash            = 0x00000005,
    ///Alternating dashes and dots.
    TextDecorationLineStyle_DashDot         = 0x00000006,
    ///A dash followed by two dots.
    TextDecorationLineStyle_DashDotDot      = 0x00000007,
    ///A wavy line.
    TextDecorationLineStyle_Wavy            = 0x00000008,
    ///A thick single line.
    TextDecorationLineStyle_ThickSingle     = 0x00000009,
    ///A double wavy line.
    TextDecorationLineStyle_DoubleWavy      = 0x0000000b,
    ///A thick wavy line.
    TextDecorationLineStyle_ThickWavy       = 0x0000000c,
    ///Long dashes.
    TextDecorationLineStyle_LongDash        = 0x0000000d,
    ///A thick dashed line.
    TextDecorationLineStyle_ThickDash       = 0x0000000e,
    ///Thick dashes alternating with thick dots.
    TextDecorationLineStyle_ThickDashDot    = 0x0000000f,
    ///A thick dash followed by two thick dots.
    TextDecorationLineStyle_ThickDashDotDot = 0x00000010,
    ///A thick dotted line.
    TextDecorationLineStyle_ThickDot        = 0x00000011,
    ///Thick long dashes.
    TextDecorationLineStyle_ThickLongDash   = 0x00000012,
    ///A line style not represented by another value.
    TextDecorationLineStyle_Other           = 0xffffffff,
}

///Contains values for the VisualEffects attribute.
enum VisualEffects : int
{
    ///No visual effects
    VisualEffects_None       = 0x00000000,
    ///Shadow effect
    VisualEffects_Shadow     = 0x00000001,
    ///Reflection effect
    VisualEffects_Reflection = 0x00000002,
    ///Glow effect
    VisualEffects_Glow       = 0x00000004,
    ///Soft edges effect
    VisualEffects_SoftEdges  = 0x00000008,
    ///Bevel effect
    VisualEffects_Bevel      = 0x00000010,
}

///Defines values that indicate how a notification should be processed.
enum NotificationProcessing : int
{
    ///These notifications should be presented to the user as soon as possible and all of the notifications from this
    ///source should be delivered to the user. <div class="alert"><b>Warning</b> Use this in a limited capacity as this
    ///style of message could cause a flooding of information to the user due to the nature of the request to deliver
    ///all notifications.</div> <div> </div>
    NotificationProcessing_ImportantAll          = 0x00000000,
    ///These notifications should be presented to the user as soon as possible. The most recent notification from this
    ///source should be delivered to the user because it supersedes all of the other notifications.
    NotificationProcessing_ImportantMostRecent   = 0x00000001,
    ///These notifications should be presented to the user when possible. All of the notifications from this source
    ///should be delivered to the user.
    NotificationProcessing_All                   = 0x00000002,
    ///These notifications should be presented to the user when possible. The most recent notification from this source
    ///should be delivered to the user because it supersedes all of the other notifications.
    NotificationProcessing_MostRecent            = 0x00000003,
    NotificationProcessing_CurrentThenMostRecent = 0x00000004,
}

///Defines values that indicate the type of a notification event, and a hint to the listener about the processing of the
///event. For example, if multiple notifications are received, they should all be read, or only the last one should be
///read, and so on.
enum NotificationKind : int
{
    ///The current element and/or the container has had something added to it that should be presented to the user.
    NotificationKind_ItemAdded       = 0x00000000,
    ///The current element has had something removed from inside of it that should be presented to the user.
    NotificationKind_ItemRemoved     = 0x00000001,
    ///The current element has a notification that an action was completed.
    NotificationKind_ActionCompleted = 0x00000002,
    ///The current element has a notification that an action was aborted.
    NotificationKind_ActionAborted   = 0x00000003,
    NotificationKind_Other           = 0x00000004,
}

///Contains values used to indicate Microsoft UI Automation data types.
enum UIAutomationType : int
{
    ///An integer.
    UIAutomationType_Int             = 0x00000001,
    ///An Boolean value.
    UIAutomationType_Bool            = 0x00000002,
    ///A null-terminated character string.
    UIAutomationType_String          = 0x00000003,
    ///A double-precision floating-point number.
    UIAutomationType_Double          = 0x00000004,
    ///A POINT structure containing the x- and y-coordinates of a point.
    UIAutomationType_Point           = 0x00000005,
    ///A RECT structure containing the coordinates of the upper-left and lower-right corners of a rectangle. This type
    ///is not supported for a custom UI Automation property.
    UIAutomationType_Rect            = 0x00000006,
    ///The address of the IUIAutomationElement interface of a UI Automation element.
    UIAutomationType_Element         = 0x00000007,
    ///An array of an unspecified type.
    UIAutomationType_Array           = 0x00010000,
    ///The address of a variable that receives a value retrieved by a function.
    UIAutomationType_Out             = 0x00020000,
    ///An array of integers. This type is not supported for a custom UI Automation property.
    UIAutomationType_IntArray        = 0x00010001,
    ///An array of Boolean values. This type is not supported for a custom UI Automation property.
    UIAutomationType_BoolArray       = 0x00010002,
    ///An array of null-terminated character strings. This type is not supported for a custom UI Automation property.
    UIAutomationType_StringArray     = 0x00010003,
    ///An array of double-precision floating-point numbers. This type is not supported for a custom UI Automation
    ///property.
    UIAutomationType_DoubleArray     = 0x00010004,
    ///An array of POINT structures, each containing the x- and y-coordinates of a point. This type is not supported for
    ///a custom UI Automation property.
    UIAutomationType_PointArray      = 0x00010005,
    ///An array of RECT structures, each containing the coordinates of the upper-left and lower-right corners of a
    ///rectangle. This type is not supported for a custom UI Automation property.
    UIAutomationType_RectArray       = 0x00010006,
    ///An array of pointers to IUIAutomationElement interfaces, each for a UI Automation element.
    UIAutomationType_ElementArray    = 0x00010007,
    ///The address of a variable that receives an integer value.
    UIAutomationType_OutInt          = 0x00020001,
    ///The address of a variable that receives a Boolean value.
    UIAutomationType_OutBool         = 0x00020002,
    ///The address of a variable that receives a null-terminated character string.
    UIAutomationType_OutString       = 0x00020003,
    ///The address of a variable that receives a double-precision floating-point number.
    UIAutomationType_OutDouble       = 0x00020004,
    ///The address of a variable that receives a POINT structure.
    UIAutomationType_OutPoint        = 0x00020005,
    ///The address of a variable that receives a RECT structure.
    UIAutomationType_OutRect         = 0x00020006,
    ///The address of a variable that receives a pointer to the IUIAutomationElement interface of a UI Automation
    ///element.
    UIAutomationType_OutElement      = 0x00020007,
    ///The address of a variable that receives an array of integer values.
    UIAutomationType_OutIntArray     = 0x00030001,
    ///The address of a variable that receives an array of Boolean values.
    UIAutomationType_OutBoolArray    = 0x00030002,
    ///The address of a variable that receives an array of null-terminated character strings.
    UIAutomationType_OutStringArray  = 0x00030003,
    ///The address of a variable that receives an array of double-precision floating-point numbers.
    UIAutomationType_OutDoubleArray  = 0x00030004,
    ///The address of a variable that receives an array of POINT structures.
    UIAutomationType_OutPointArray   = 0x00030005,
    ///The address of a variable that receives an array of RECT structures.
    UIAutomationType_OutRectArray    = 0x00030006,
    UIAutomationType_OutElementArray = 0x00030007,
}

///Contains values that specify the scope of various operations in the Microsoft UI Automation tree.
enum TreeScope : int
{
    ///The scope excludes the subtree from the search.
    TreeScope_None        = 0x00000000,
    ///The scope includes the element itself.
    TreeScope_Element     = 0x00000001,
    ///The scope includes children of the element.
    TreeScope_Children    = 0x00000002,
    ///The scope includes children and more distant descendants of the element.
    TreeScope_Descendants = 0x00000004,
    ///The scope includes the parent of the element.
    TreeScope_Parent      = 0x00000008,
    ///The scope includes the parent and more distant ancestors of the element.
    TreeScope_Ancestors   = 0x00000010,
    ///The scope includes the element and all its descendants. This flag is a combination of the TreeScope_Element and
    ///TreeScope_Descendants values.
    TreeScope_Subtree     = 0x00000007,
}

///Contains values that specify a type of UiaCondition.
enum ConditionType : int
{
    ///A condition that is true.
    ConditionType_True     = 0x00000000,
    ///A condition that is false.
    ConditionType_False    = 0x00000001,
    ///A property condition.
    ConditionType_Property = 0x00000002,
    ///A complex condition where all the contained conditions must be true.
    ConditionType_And      = 0x00000003,
    ///A complex condition where at least one of the contained conditions must be true.
    ConditionType_Or       = 0x00000004,
    ConditionType_Not      = 0x00000005,
}

///Contains values used in creating property conditions.
enum PropertyConditionFlags : int
{
    ///No flags.
    PropertyConditionFlags_None           = 0x00000000,
    ///Comparison of string properties is not case-sensitive.
    PropertyConditionFlags_IgnoreCase     = 0x00000001,
    PropertyConditionFlags_MatchSubstring = 0x00000002,
}

///Contains values that specify the type of reference to use when returning UI Automation elements.
enum AutomationElementMode : int
{
    ///Specifies that returned elements have no reference to the underlying UI and contain only cached information.
    AutomationElementMode_None = 0x00000000,
    AutomationElementMode_Full = 0x00000001,
}

///Contains values that specify the behavior of UiaGetUpdatedCache.
enum NormalizeState : int
{
    ///No normalization.
    NormalizeState_None   = 0x00000000,
    ///Normalize against the condition in the cache request specified by pRequest.
    NormalizeState_View   = 0x00000001,
    NormalizeState_Custom = 0x00000002,
}

///Defines values that can be used to customize tree navigation order.
enum TreeTraversalOptions : int
{
    ///Pre-order, visit children from first to last.
    TreeTraversalOptions_Default          = 0x00000000,
    ///Post-order, see Remarks for more info.
    TreeTraversalOptions_PostOrder        = 0x00000001,
    ///Visit children from last to first.
    TreeTraversalOptions_LastToFirstOrder = 0x00000002,
}

///Contains values that specify the type of a client-side (proxy) UI Automation provider.
enum ProviderType : int
{
    ///The provider is window-based.
    ProviderType_BaseHwnd      = 0x00000000,
    ///The provider is one of the Win32 or Windows Forms providers from Microsoft, or a third-party proxy provider.
    ProviderType_Proxy         = 0x00000001,
    ProviderType_NonClientArea = 0x00000002,
}

///Contains values used in the UiaLookupId function.
enum AutomationIdentifierType : int
{
    ///Specifies a property ID.
    AutomationIdentifierType_Property      = 0x00000000,
    ///Specifies a control pattern ID.
    AutomationIdentifierType_Pattern       = 0x00000001,
    ///Specifies an event ID.
    AutomationIdentifierType_Event         = 0x00000002,
    ///Specifies a control type ID.
    AutomationIdentifierType_ControlType   = 0x00000003,
    ///Specifies a text attribute ID.
    AutomationIdentifierType_TextAttribute = 0x00000004,
    ///Specifies a landmark type ID.
    AutomationIdentifierType_LandmarkType  = 0x00000005,
    ///Specifies an annotion ID.
    AutomationIdentifierType_Annotation    = 0x00000006,
    ///Specifies a changes ID.
    AutomationIdentifierType_Changes       = 0x00000007,
    ///Specifies a style ID.
    AutomationIdentifierType_Style         = 0x00000008,
}

///Contains values that specify the event type described by a UiaEventArgs structure.
enum EventArgsType : int
{
    ///A simple event that does not provide data in the event arguments.
    EventArgsType_Simple                    = 0x00000000,
    ///An event raised by calling the [UiaRaiseAutomationPropertyChangedEvent
    ///function](nf-uiautomationcoreapi-uiaraiseautomationpropertychangedevent.md).
    EventArgsType_PropertyChanged           = 0x00000001,
    ///An event raised by calling the [UiaRaiseStructureChangedEvent
    ///function](nf-uiautomationcoreapi-uiaraisestructurechangedevent.md).
    EventArgsType_StructureChanged          = 0x00000002,
    ///An event raised by calling the [UiaRaiseAsyncContentLoadedEvent
    ///function](nf-uiautomationcoreapi-uiaraiseasynccontentloadedevent.md).
    EventArgsType_AsyncContentLoaded        = 0x00000003,
    ///An event raised when a window is closed.
    EventArgsType_WindowClosed              = 0x00000004,
    ///An event raised by calling the [UiaRaiseTextEditTextChangedEvent
    ///function](nf-uiautomationcoreapi-uiaraisetextedittextchangedevent.md)
    EventArgsType_TextEditTextChanged       = 0x00000005,
    ///An event raised by calling the [UiaRaiseChangesEvent function](nf-uiautomationcoreapi-uiaraisechangesevent.md).
    EventArgsType_Changes                   = 0x00000006,
    ///An event raised by calling the [UiaRaiseNotificationEvent
    ///function](nf-uiautomationcoreapi-uiaraisenotificationevent.md).
    EventArgsType_Notification              = 0x00000007,
    EventArgsType_ActiveTextPositionChanged = 0x00000008,
    EventArgsType_StructuredMarkup          = 0x00000009,
}

///Contains values that describe the progress of asynchronous loading of content.
enum AsyncContentLoadedState : int
{
    ///Loading of the content into the UI Automation element is beginning.
    AsyncContentLoadedState_Beginning = 0x00000000,
    ///Loading of the content into the UI Automation element is in progress.
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

///An application-defined callback (or hook) function that the system calls in response to events generated by an
///accessible object. The hook function processes the event notifications as required. Clients install the hook function
///and request specific types of event notifications by calling SetWinEventHook. The WINEVENTPROC type defines a pointer
///to this callback function. <i>WinEventProc</i> is a placeholder for the application-defined function name.
///Params:
///    hWinEventHook = Type: <b>HWINEVENTHOOK</b> Handle to an event hook function. This value is returned by SetWinEventHook when the
///                    hook function is installed and is specific to each instance of the hook function.
///    event = Type: <b>DWORD</b> Specifies the event that occurred. This value is one of the event constants.
///    hwnd = Type: <b>HWND</b> Handle to the window that generates the event, or <b>NULL</b> if no window is associated with
///           the event. For example, the mouse pointer is not associated with a window.
///    idObject = Type: <b>LONG</b> Identifies the object associated with the event. This is one of the object identifiers or a
///               custom object ID.
///    idChild = Type: <b>LONG</b> Identifies whether the event was triggered by an object or a child element of the object. If
///              this value is CHILDID_SELF, the event was triggered by the object; otherwise, this value is the child ID of the
///              element that triggered the event.
///    idEventThread = 
///    dwmsEventTime = Type: <b>DWORD</b> Specifies the time, in milliseconds, that the event was generated.
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
///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>An application-defined function that is
///called by UI Automation to obtain a client-side provider for an element.
///Params:
///    hwnd = Type: <b>HWND</b> The handle of the window served by the provider.
///    providerType = Type: <b>ProviderType</b> A value from the ProviderType enumerated type specifying the type of provider that is
///                   being requested.
alias UiaProviderCallback = SAFEARRAY* function(HWND hwnd, ProviderType providerType);
///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>A client-implemented function that is
///called by UI Automation when an event is raised that the client has subscribed to.
///Params:
///    pArgs = Type: <b>UiaEventArgs*</b> The address of a UiaEventArgs structure that contains the event arguments.
///    pRequestedData = Type: <b>SAFEARRAY*</b> A SAFEARRAY that contains data associated with the event.
///    pTreeStructure = Type: <b>BSTR</b> A string that contains the structure of the tree associated with the event, if the event is
///                     associated with a set of nodes. See Remarks.
alias UiaEventCallback = void function(UiaEventArgs* pArgs, SAFEARRAY* pRequestedData, BSTR pTreeStructure);

// Structs


///Contains information about the SerialKeys accessibility feature, which interprets data from a communication aid
///attached to a serial port as commands causing the system to simulate keyboard and mouse input.
struct SERIALKEYSA
{
    ///Type: <b>UINT</b> Specifies the structure size, in bytes.
    uint         cbSize;
    ///Type: <b>DWORD</b> Specifies a combination of the following values: <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="SERKF_AVAILABLE"></a><a id="serkf_available"></a><dl>
    ///<dt><b>SERKF_AVAILABLE</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> The SerialKeys feature is
    ///available. </td> </tr> <tr> <td width="40%"><a id="SERKF_INDICATOR"></a><a id="serkf_indicator"></a><dl>
    ///<dt><b>SERKF_INDICATOR</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%"> A visual indicator is displayed
    ///when the SerialKeys feature is on. This value is not currently used and is ignored. </td> </tr> <tr> <td
    ///width="40%"><a id="SERKF_SERIALKEYSON"></a><a id="serkf_serialkeyson"></a><dl> <dt><b>SERKF_SERIALKEYSON</b></dt>
    ///<dt>0x00000001</dt> </dl> </td> <td width="60%"> The SerialKeys feature is on. </td> </tr> </table>
    uint         dwFlags;
    ///Type: <b>LPSTR</b> Points to a string that contains the name of the serial port that receives input from the
    ///communication aid when the SerialKeys feature is on. If no port is being used, this member is <b>NULL</b>. If
    ///this member is "Auto", the system watches all unused serial ports for input from communication aids.
    const(char)* lpszActivePort;
    ///Type: <b>LPSTR</b> Reserved; must be <b>NULL</b>.
    const(char)* lpszPort;
    ///Type: <b>UINT</b> Specifies the baud rate setting for the serial port specified by the <b>lpszActivePort</b>
    ///member. This member should be set to one of the CBR_ values defined in the winbase.h header file. If
    ///<b>lpszActivePort</b> is <b>NULL</b>, this member is zero.
    uint         iBaudRate;
    ///Type: <b>UINT</b> Specifies the state of the port specified by the <b>lpszActivePort</b> member. If
    ///<b>lpszActivePort</b> is <b>NULL</b>, <b>iPortState</b> is zero; otherwise, it is one of the following values:
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0</dt> </dl> </td> <td
    ///width="60%"> All input on this port is ignored by the SerialKeys feature. </td> </tr> <tr> <td width="40%"> <dl>
    ///<dt>1</dt> </dl> </td> <td width="60%"> Input on this port is watched for SerialKeys activation sequences when no
    ///other application has the port open. </td> </tr> <tr> <td width="40%"> <dl> <dt>2</dt> </dl> </td> <td
    ///width="60%"> All input on this port is treated as SerialKeys commands. </td> </tr> </table>
    uint         iPortState;
    ///Type: <b>UINT</b> Specifies the active port.
    uint         iActive;
}

///Contains information about the SerialKeys accessibility feature, which interprets data from a communication aid
///attached to a serial port as commands causing the system to simulate keyboard and mouse input.
struct SERIALKEYSW
{
    ///Type: <b>UINT</b> Specifies the structure size, in bytes.
    uint          cbSize;
    ///Type: <b>DWORD</b> Specifies a combination of the following values: <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="SERKF_AVAILABLE"></a><a id="serkf_available"></a><dl>
    ///<dt><b>SERKF_AVAILABLE</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> The SerialKeys feature is
    ///available. </td> </tr> <tr> <td width="40%"><a id="SERKF_INDICATOR"></a><a id="serkf_indicator"></a><dl>
    ///<dt><b>SERKF_INDICATOR</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%"> A visual indicator is displayed
    ///when the SerialKeys feature is on. This value is not currently used and is ignored. </td> </tr> <tr> <td
    ///width="40%"><a id="SERKF_SERIALKEYSON"></a><a id="serkf_serialkeyson"></a><dl> <dt><b>SERKF_SERIALKEYSON</b></dt>
    ///<dt>0x00000001</dt> </dl> </td> <td width="60%"> The SerialKeys feature is on. </td> </tr> </table>
    uint          dwFlags;
    ///Type: <b>LPSTR</b> Points to a string that contains the name of the serial port that receives input from the
    ///communication aid when the SerialKeys feature is on. If no port is being used, this member is <b>NULL</b>. If
    ///this member is "Auto", the system watches all unused serial ports for input from communication aids.
    const(wchar)* lpszActivePort;
    ///Type: <b>LPSTR</b> Reserved; must be <b>NULL</b>.
    const(wchar)* lpszPort;
    ///Type: <b>UINT</b> Specifies the baud rate setting for the serial port specified by the <b>lpszActivePort</b>
    ///member. This member should be set to one of the CBR_ values defined in the winbase.h header file. If
    ///<b>lpszActivePort</b> is <b>NULL</b>, this member is zero.
    uint          iBaudRate;
    ///Type: <b>UINT</b> Specifies the state of the port specified by the <b>lpszActivePort</b> member. If
    ///<b>lpszActivePort</b> is <b>NULL</b>, <b>iPortState</b> is zero; otherwise, it is one of the following values:
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0</dt> </dl> </td> <td
    ///width="60%"> All input on this port is ignored by the SerialKeys feature. </td> </tr> <tr> <td width="40%"> <dl>
    ///<dt>1</dt> </dl> </td> <td width="60%"> Input on this port is watched for SerialKeys activation sequences when no
    ///other application has the port open. </td> </tr> <tr> <td width="40%"> <dl> <dt>2</dt> </dl> </td> <td
    ///width="60%"> All input on this port is treated as SerialKeys commands. </td> </tr> </table>
    uint          iPortState;
    ///Type: <b>UINT</b> Specifies the active port.
    uint          iActive;
}

///Contains information about the high contrast accessibility feature.This feature sets the appearance scheme of the
///user interface for maximum visibility for a visually-impaired user, and advises applications to comply with this
///appearance scheme.
struct HIGHCONTRASTA
{
    ///Type: <b>UINT</b> Specifies the size, in bytes, of this structure.
    uint         cbSize;
    ///Type: <b>DWORD</b> Specifies a combination of the following values: <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="HCF_HIGHCONTRASTON"></a><a id="hcf_highcontraston"></a><dl>
    ///<dt><b>HCF_HIGHCONTRASTON</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> The high contrast feature is
    ///on. </td> </tr> <tr> <td width="40%"><a id="HCF_AVAILABLE"></a><a id="hcf_available"></a><dl>
    ///<dt><b>HCF_AVAILABLE</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> The high contrast feature is
    ///available. </td> </tr> <tr> <td width="40%"><a id="HCF_HOTKEYACTIVE"></a><a id="hcf_hotkeyactive"></a><dl>
    ///<dt><b>HCF_HOTKEYACTIVE</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%"> The user can turn the high
    ///contrast feature on and off by simultaneously pressing the left ALT, left SHIFT, and PRINT SCREEN keys. </td>
    ///</tr> <tr> <td width="40%"><a id="HCF_CONFIRMHOTKEY"></a><a id="hcf_confirmhotkey"></a><dl>
    ///<dt><b>HCF_CONFIRMHOTKEY</b></dt> <dt>0x00000008</dt> </dl> </td> <td width="60%"> A confirmation dialog appears
    ///when the high contrast feature is activated by using the hot key. </td> </tr> <tr> <td width="40%"><a
    ///id="HCF_HOTKEYSOUND"></a><a id="hcf_hotkeysound"></a><dl> <dt><b>HCF_HOTKEYSOUND</b></dt> <dt>0x00000010</dt>
    ///</dl> </td> <td width="60%"> A siren is played when the user turns the high contrast feature on or off by using
    ///the hot key. </td> </tr> <tr> <td width="40%"><a id="HCF_INDICATOR"></a><a id="hcf_indicator"></a><dl>
    ///<dt><b>HCF_INDICATOR</b></dt> <dt>0x00000020</dt> </dl> </td> <td width="60%"> A visual indicator is displayed
    ///when the high contrast feature is on. This value is not currently used and is ignored. </td> </tr> <tr> <td
    ///width="40%"><a id="HCF_HOTKEYAVAILABLE"></a><a id="hcf_hotkeyavailable"></a><dl>
    ///<dt><b>HCF_HOTKEYAVAILABLE</b></dt> <dt>0x00000040</dt> </dl> </td> <td width="60%"> The hot key associated with
    ///the high contrast feature can be enabled. An application can retrieve this value, but cannot set it. </td> </tr>
    ///<tr> <td width="40%"><a id="HCF_OPTION_NOTHEMECHANGE"></a><a id="hcf_option_nothemechange"></a><dl>
    ///<dt><b>HCF_OPTION_NOTHEMECHANGE</b></dt> <dt>0x00001000</dt> </dl> </td> <td width="60%"> <p>Passing
    ///HIGHCONTRASTSTRUCTURE in calls to SystemParametersInfoA can cause theme change effects even if the theme isn't
    ///being changed. For example, the WM_THEMECHANGED message is sent to Windows even if the only change is to
    ///HCF_HOTKEYSOUND.</p> <p>To prevent this, include the HCF_OPTION_NOTHEMECHANGE flag in the call to
    ///SystemParametersInfo.</p> > [!NOTE] > The HCF_OPTION_NOTHEMECHANGE flag should not be used when toggling the high
    ///contrast mode (HCF_HIGHCONTRASTON). </td> </tr> </table>
    uint         dwFlags;
    ///Type: <b>LPTSTR</b> Points to a string that contains the name of the color scheme that will be set to the default
    ///scheme.
    const(char)* lpszDefaultScheme;
}

///Contains information about the high contrast accessibility feature.This feature sets the appearance scheme of the
///user interface for maximum visibility for a visually-impaired user, and advises applications to comply with this
///appearance scheme.
struct HIGHCONTRASTW
{
    ///Type: <b>UINT</b> Specifies the size, in bytes, of this structure.
    uint          cbSize;
    ///Type: <b>DWORD</b> Specifies a combination of the following values: <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="HCF_HIGHCONTRASTON"></a><a id="hcf_highcontraston"></a><dl>
    ///<dt><b>HCF_HIGHCONTRASTON</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> The high contrast feature is
    ///on. </td> </tr> <tr> <td width="40%"><a id="HCF_AVAILABLE"></a><a id="hcf_available"></a><dl>
    ///<dt><b>HCF_AVAILABLE</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> The high contrast feature is
    ///available. </td> </tr> <tr> <td width="40%"><a id="HCF_HOTKEYACTIVE"></a><a id="hcf_hotkeyactive"></a><dl>
    ///<dt><b>HCF_HOTKEYACTIVE</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%"> The user can turn the high
    ///contrast feature on and off by simultaneously pressing the left ALT, left SHIFT, and PRINT SCREEN keys. </td>
    ///</tr> <tr> <td width="40%"><a id="HCF_CONFIRMHOTKEY"></a><a id="hcf_confirmhotkey"></a><dl>
    ///<dt><b>HCF_CONFIRMHOTKEY</b></dt> <dt>0x00000008</dt> </dl> </td> <td width="60%"> A confirmation dialog appears
    ///when the high contrast feature is activated by using the hot key. </td> </tr> <tr> <td width="40%"><a
    ///id="HCF_HOTKEYSOUND"></a><a id="hcf_hotkeysound"></a><dl> <dt><b>HCF_HOTKEYSOUND</b></dt> <dt>0x00000010</dt>
    ///</dl> </td> <td width="60%"> A siren is played when the user turns the high contrast feature on or off by using
    ///the hot key. </td> </tr> <tr> <td width="40%"><a id="HCF_INDICATOR"></a><a id="hcf_indicator"></a><dl>
    ///<dt><b>HCF_INDICATOR</b></dt> <dt>0x00000020</dt> </dl> </td> <td width="60%"> A visual indicator is displayed
    ///when the high contrast feature is on. This value is not currently used and is ignored. </td> </tr> <tr> <td
    ///width="40%"><a id="HCF_HOTKEYAVAILABLE"></a><a id="hcf_hotkeyavailable"></a><dl>
    ///<dt><b>HCF_HOTKEYAVAILABLE</b></dt> <dt>0x00000040</dt> </dl> </td> <td width="60%"> The hot key associated with
    ///the high contrast feature can be enabled. An application can retrieve this value, but cannot set it. </td> </tr>
    ///<tr> <td width="40%"><a id="HCF_OPTION_NOTHEMECHANGE"></a><a id="hcf_option_nothemechange"></a><dl>
    ///<dt><b>HCF_OPTION_NOTHEMECHANGE</b></dt> <dt>0x00001000</dt> </dl> </td> <td width="60%"> <p>Passing
    ///HIGHCONTRASTSTRUCTURE in calls to SystemParametersInfoW can cause theme change effects even if the theme isn't
    ///being changed. For example, the WM_THEMECHANGED message is sent to Windows even if the only change is to
    ///HCF_HOTKEYSOUND.</p> <p>To prevent this, include the HCF_OPTION_NOTHEMECHANGE flag in the call to
    ///SystemParametersInfo.</p> > [!NOTE] > The HCF_OPTION_NOTHEMECHANGE flag should not be used when toggling the high
    ///contrast mode (HCF_HIGHCONTRASTON). </td> </tr> <tr> <td width="40%"><a id="HCF_OPTION_NOTHEMECHANGE"></a><a
    ///id="hcf_option_nothemechange"></a><dl> <dt><b>HCF_OPTION_NOTHEMECHANGE</b></dt> <dt>0x00001000</dt> </dl> </td>
    ///<td width="60%"> <p>Passing HIGHCONTRASTSTRUCTURE in calls to SystemParametersInfoW can cause theme change
    ///effects even if the theme isn't being changed. For example, the WM_THEMECHANGED message is sent to Windows even
    ///if the only change is to HCF_HOTKEYSOUND.</p> <p>To prevent this, include the HCF_OPTION_NOTHEMECHANGE flag in
    ///the call to SystemParametersInfo.</p> > [!NOTE] > The HCF_OPTION_NOTHEMECHANGE flag should not be used when
    ///toggling the high contrast mode (HCF_HIGHCONTRASTON). </td> </tr> </table>
    uint          dwFlags;
    ///Type: <b>LPTSTR</b> Points to a string that contains the name of the color scheme that will be set to the default
    ///scheme.
    const(wchar)* lpszDefaultScheme;
}

///Contains information about the FilterKeys accessibility feature, which enables a user with disabilities to set the
///keyboard repeat rate (RepeatKeys), acceptance delay (SlowKeys), and bounce rate (BounceKeys).
struct FILTERKEYS
{
    ///Type: <b>UINT</b> Specifies the structure size, in bytes.
    uint cbSize;
    ///Type: <b>DWORD</b> A set of bit flags that specify properties of the FilterKeys feature. The following bit-flag
    ///values are defined: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="FKF_AVAILABLE"></a><a id="fkf_available"></a><dl> <dt><b>FKF_AVAILABLE</b></dt> <dt>0x00000002</dt> </dl>
    ///</td> <td width="60%"> The FilterKeys features are available. </td> </tr> <tr> <td width="40%"><a
    ///id="FKF_CLICKON"></a><a id="fkf_clickon"></a><dl> <dt><b>FKF_CLICKON</b></dt> <dt>0x00000040</dt> </dl> </td> <td
    ///width="60%"> The computer makes a click sound when a key is pressed or accepted. If SlowKeys is on, a click is
    ///generated when the key is pressed and again when the keystroke is accepted. </td> </tr> <tr> <td width="40%"><a
    ///id="FKF_CONFIRMHOTKEY"></a><a id="fkf_confirmhotkey"></a><dl> <dt><b>FKF_CONFIRMHOTKEY</b></dt>
    ///<dt>0x00000008</dt> </dl> </td> <td width="60%"> <b>Windows 95/98, Windows 2000:</b> A confirmation dialog box
    ///appears when the FilterKeys features are activated by using the hot key. </td> </tr> <tr> <td width="40%"><a
    ///id="FKF_FILTERKEYSON"></a><a id="fkf_filterkeyson"></a><dl> <dt><b>FKF_FILTERKEYSON</b></dt> <dt>0x00000001</dt>
    ///</dl> </td> <td width="60%"> The FilterKeys features are on. </td> </tr> <tr> <td width="40%"><a
    ///id="FKF_HOTKEYACTIVE"></a><a id="fkf_hotkeyactive"></a><dl> <dt><b>FKF_HOTKEYACTIVE</b></dt> <dt>0x00000004</dt>
    ///</dl> </td> <td width="60%"> The user can turn the FilterKeys feature on and off by holding down the RIGHT SHIFT
    ///key for eight seconds. </td> </tr> <tr> <td width="40%"><a id="FKF_HOTKEYSOUND"></a><a
    ///id="fkf_hotkeysound"></a><dl> <dt><b>FKF_HOTKEYSOUND</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> If
    ///this flag is set, the computer plays a siren sound when the user turns the FilterKeys feature on or off by using
    ///the hot key. </td> </tr> <tr> <td width="40%"><a id="FKF_INDICATOR"></a><a id="fkf_indicator"></a><dl>
    ///<dt><b>FKF_INDICATOR</b></dt> <dt>0x00000020</dt> </dl> </td> <td width="60%"> <b>Windows 95, Windows 2000:</b> A
    ///visual indicator is displayed when the FilterKeys features are on. </td> </tr> </table>
    uint dwFlags;
    ///Type: <b>DWORD</b> Specifies the length of time, in milliseconds, that the user must hold down a key before it is
    ///accepted by the computer.
    uint iWaitMSec;
    ///Type: <b>DWORD</b> Specifies the length of time, in milliseconds, that the user must hold down a key before it
    ///begins to repeat.
    uint iDelayMSec;
    ///Type: <b>DWORD</b> Specifies the length of time, in milliseconds, between each repetition of the keystroke.
    uint iRepeatMSec;
    ///Type: <b>DWORD</b> Specifies the length of time, in milliseconds, that must elapse after releasing a key before
    ///the computer will accept a subsequent press of the same key.
    uint iBounceMSec;
}

///Contains information about the StickyKeys accessibility feature. When the StickyKeys feature is on, the user can
///press a modifier key (SHIFT, CTRL, or ALT) and then another key in sequence rather than at the same time, to enter
///shifted (modified) characters and other key combinations. Pressing a modifier key once <i>latches</i> the key down
///until the user presses a non-modifier key or clicks a mouse button. Pressing a modifier key twice <i>locks</i> the
///key until the user presses the key a third time.
struct STICKYKEYS
{
    ///Type: <b>DWORD</b> Specifies the size, in bytes, of this structure.
    uint cbSize;
    ///Type: <b>DWORD</b> A set of bit-flags that specify properties of the StickyKeys feature. The following bit-flag
    ///values are defined: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="SKF_AUDIBLEFEEDBACK"></a><a id="skf_audiblefeedback"></a><dl> <dt><b>SKF_AUDIBLEFEEDBACK</b></dt>
    ///<dt>0x00000040</dt> </dl> </td> <td width="60%"> If this flag is set, the system plays a sound when the user
    ///latches, locks, or releases modifier keys using the StickyKeys feature. </td> </tr> <tr> <td width="40%"><a
    ///id="SKF_AVAILABLE"></a><a id="skf_available"></a><dl> <dt><b>SKF_AVAILABLE</b></dt> <dt>0x00000002</dt> </dl>
    ///</td> <td width="60%"> If this flag is set, the StickyKeys feature is available. </td> </tr> <tr> <td
    ///width="40%"><a id="SKF_CONFIRMHOTKEY"></a><a id="skf_confirmhotkey"></a><dl> <dt><b>SKF_CONFIRMHOTKEY</b></dt>
    ///<dt>0x00000008</dt> </dl> </td> <td width="60%"> <b>Windows 95/98, Windows 2000:</b> A confirmation dialog
    ///appears when the StickyKeys feature is activated by using the hot key. </td> </tr> <tr> <td width="40%"><a
    ///id="SKF_HOTKEYACTIVE"></a><a id="skf_hotkeyactive"></a><dl> <dt><b>SKF_HOTKEYACTIVE</b></dt> <dt>0x00000004</dt>
    ///</dl> </td> <td width="60%"> If this flag is set, the user can turn the StickyKeys feature on and off by pressing
    ///the SHIFT key five times. </td> </tr> <tr> <td width="40%"><a id="SKF_HOTKEYSOUND"></a><a
    ///id="skf_hotkeysound"></a><dl> <dt><b>SKF_HOTKEYSOUND</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> If
    ///this flag is set, the system plays a siren sound when the user turns the StickyKeys feature on or off by using
    ///the hot key. </td> </tr> <tr> <td width="40%"><a id="SKF_INDICATOR"></a><a id="skf_indicator"></a><dl>
    ///<dt><b>SKF_INDICATOR</b></dt> <dt>0x00000020</dt> </dl> </td> <td width="60%"> <b>Windows 95/98, Windows
    ///2000:</b> A visual indicator should be displayed when the StickyKeys feature is on. </td> </tr> <tr> <td
    ///width="40%"><a id="SKF_STICKYKEYSON"></a><a id="skf_stickykeyson"></a><dl> <dt><b>SKF_STICKYKEYSON</b></dt>
    ///<dt>0x00000001</dt> </dl> </td> <td width="60%"> If this flag is set, the StickyKeys feature is on. </td> </tr>
    ///<tr> <td width="40%"><a id="SKF_TRISTATE"></a><a id="skf_tristate"></a><dl> <dt><b>SKF_TRISTATE</b></dt>
    ///<dt>0x00000080</dt> </dl> </td> <td width="60%"> If this flag is set, pressing a modifier key twice in a row
    ///locks down the key until the user presses it a third time. </td> </tr> <tr> <td width="40%"><a
    ///id="SKF_TWOKEYSOFF"></a><a id="skf_twokeysoff"></a><dl> <dt><b>SKF_TWOKEYSOFF</b></dt> <dt>0x00000100</dt> </dl>
    ///</td> <td width="60%"> If this flag is set, releasing a modifier key that has been pressed in combination with
    ///any other key turns off the StickyKeys feature. </td> </tr> <tr> <td width="40%"><a id="SKF_LALTLATCHED"></a><a
    ///id="skf_laltlatched"></a><dl> <dt><b>SKF_LALTLATCHED</b></dt> <dt>0x10000000</dt> </dl> </td> <td width="60%">
    ///<b>Windows 98, Windows 2000: </b>The left ALT key is latched. </td> </tr> <tr> <td width="40%"><a
    ///id="SKF_LCTLLATCHED"></a><a id="skf_lctllatched"></a><dl> <dt><b>SKF_LCTLLATCHED</b></dt> <dt>0x04000000</dt>
    ///</dl> </td> <td width="60%"> <b>Windows 98, Windows 2000: </b> The left CTRL key is latched. </td> </tr> <tr> <td
    ///width="40%"><a id="SKF_LSHIFTLATCHED"></a><a id="skf_lshiftlatched"></a><dl> <dt><b>SKF_LSHIFTLATCHED</b></dt>
    ///<dt>0x01000000</dt> </dl> </td> <td width="60%"> <b>Windows 98, Windows 2000: </b> The left SHIFT key is latched.
    ///</td> </tr> <tr> <td width="40%"><a id="SKF_RALTLATCHED"></a><a id="skf_raltlatched"></a><dl>
    ///<dt><b>SKF_RALTLATCHED</b></dt> <dt>0x20000000</dt> </dl> </td> <td width="60%"> <b>Windows 98, Windows 2000:
    ///</b> The right ALT key is latched. </td> </tr> <tr> <td width="40%"><a id="SKF_RCTLLATCHED"></a><a
    ///id="skf_rctllatched"></a><dl> <dt><b>SKF_RCTLLATCHED</b></dt> <dt>0x08000000</dt> </dl> </td> <td width="60%">
    ///<b>Windows 98, Windows 2000: </b> The right CTRL key is latched. </td> </tr> <tr> <td width="40%"><a
    ///id="SKF_RSHIFTLATCHED"></a><a id="skf_rshiftlatched"></a><dl> <dt><b>SKF_RSHIFTLATCHED</b></dt>
    ///<dt>0x02000000</dt> </dl> </td> <td width="60%"> <b>Windows 98, Windows 2000: </b> The right SHIFT key is
    ///latched. </td> </tr> <tr> <td width="40%"><a id="SKF_LALTLOCKED"></a><a id="skf_laltlocked"></a><dl>
    ///<dt><b>SKF_LALTLOCKED</b></dt> <dt>0x00100000</dt> </dl> </td> <td width="60%"> <b>Windows 98, Windows 2000: </b>
    ///The left ALT key is locked. </td> </tr> <tr> <td width="40%"><a id="SKF_LCTLLOCKED"></a><a
    ///id="skf_lctllocked"></a><dl> <dt><b>SKF_LCTLLOCKED</b></dt> <dt>0x00040000</dt> </dl> </td> <td width="60%">
    ///<b>Windows 98, Windows 2000: </b> The left CTRL key is locked. </td> </tr> <tr> <td width="40%"><a
    ///id="SKF_LSHIFTLOCKED"></a><a id="skf_lshiftlocked"></a><dl> <dt><b>SKF_LSHIFTLOCKED</b></dt> <dt>0x00010000</dt>
    ///</dl> </td> <td width="60%"> <b>Windows 98, Windows 2000: </b> The left SHIFT key is locked. </td> </tr> <tr> <td
    ///width="40%"><a id="SKF_RALTLOCKED"></a><a id="skf_raltlocked"></a><dl> <dt><b>SKF_RALTLOCKED</b></dt>
    ///<dt>0x00200000</dt> </dl> </td> <td width="60%"> <b>Windows 98, Windows 2000: </b> The right ALT key is locked.
    ///</td> </tr> <tr> <td width="40%"><a id="SKF_RCTLLOCKED"></a><a id="skf_rctllocked"></a><dl>
    ///<dt><b>SKF_RCTLLOCKED</b></dt> <dt>0x00080000</dt> </dl> </td> <td width="60%"> <b>Windows 98, Windows 2000: </b>
    ///The right CTRL key is locked. </td> </tr> <tr> <td width="40%"><a id="SKF_RSHIFTLOCKED"></a><a
    ///id="skf_rshiftlocked"></a><dl> <dt><b>SKF_RSHIFTLOCKED</b></dt> <dt>0x00020000</dt> </dl> </td> <td width="60%">
    ///<b>Windows 98, Windows 2000: </b> The right SHIFT key is locked. </td> </tr> <tr> <td width="40%"><a
    ///id="SKF_LWINLATCHED"></a><a id="skf_lwinlatched"></a><dl> <dt><b>SKF_LWINLATCHED</b></dt> <dt>0x40000000</dt>
    ///</dl> </td> <td width="60%"> <b>Windows 98, Windows 2000: </b> The left Windows key is latched. </td> </tr> <tr>
    ///<td width="40%"><a id="SKF_RWINLATCHED"></a><a id="skf_rwinlatched"></a><dl> <dt><b>SKF_RWINLATCHED</b></dt>
    ///<dt>0x80000000</dt> </dl> </td> <td width="60%"> <b>Windows 98, Windows 2000: </b> The right Windows key is
    ///latched. </td> </tr> <tr> <td width="40%"><a id="SKF_LWINLOCKED"></a><a id="skf_lwinlocked"></a><dl>
    ///<dt><b>SKF_LWINLOCKED</b></dt> <dt>0x00400000</dt> </dl> </td> <td width="60%"> <b>Windows 98, Windows 2000: </b>
    ///The left Windows key is locked. </td> </tr> <tr> <td width="40%"><a id="SKF_RWINLOCKED"></a><a
    ///id="skf_rwinlocked"></a><dl> <dt><b>SKF_RWINLOCKED</b></dt> <dt>0x00800000</dt> </dl> </td> <td width="60%">
    ///<b>Windows 98, Windows 2000: </b> The right Windows key is locked. </td> </tr> </table>
    uint dwFlags;
}

///Contains information about the MouseKeys accessibility feature. When the MouseKeys feature is active, the user can
///use the numeric keypad to control the mouse pointer, and to click, double-click, drag, and drop. By pressing NUMLOCK,
///the user can toggle the numeric keypad between mouse control mode and normal operation.
struct MOUSEKEYS
{
    ///Type: <b>DWORD</b> Specifies the size, in bytes, of this structure.
    uint cbSize;
    ///Type: <b>DWORD</b> A set of bit-flags that specify properties of the FilterKeys feature. The following bit-flag
    ///values are defined: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="MKF_AVAILABLE"></a><a id="mkf_available"></a><dl> <dt><b>MKF_AVAILABLE</b></dt> <dt>0x00000002</dt> </dl>
    ///</td> <td width="60%"> If this flag is set, the MouseKeys feature is available. </td> </tr> <tr> <td
    ///width="40%"><a id="MKF_CONFIRMHOTKEY"></a><a id="mkf_confirmhotkey"></a><dl> <dt><b>MKF_CONFIRMHOTKEY</b></dt>
    ///<dt>0x00000008</dt> </dl> </td> <td width="60%"> <b>Windows 95/98, Windows 2000:</b> A confirmation dialog box
    ///appears when the MouseKeys feature is activated by using the hot key. </td> </tr> <tr> <td width="40%"><a
    ///id="MKF_HOTKEYACTIVE"></a><a id="mkf_hotkeyactive"></a><dl> <dt><b>MKF_HOTKEYACTIVE</b></dt> <dt>0x00000004</dt>
    ///</dl> </td> <td width="60%"> If this flag is set, the user can turn the MouseKeys feature on and off by using the
    ///hot key, which is LEFT ALT+LEFT SHIFT+NUM LOCK. </td> </tr> <tr> <td width="40%"><a id="MKF_HOTKEYSOUND"></a><a
    ///id="mkf_hotkeysound"></a><dl> <dt><b>MKF_HOTKEYSOUND</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> If
    ///this flag is set, the system plays a siren sound when the user turns the MouseKeys feature on or off by using the
    ///hot key. </td> </tr> <tr> <td width="40%"><a id="MKF_INDICATOR"></a><a id="mkf_indicator"></a><dl>
    ///<dt><b>MKF_INDICATOR</b></dt> <dt>0x00000020</dt> </dl> </td> <td width="60%"> <b>Windows 95/98, Windows
    ///2000:</b> A visual indicator is displayed when the MouseKeys feature is on. </td> </tr> <tr> <td width="40%"><a
    ///id="MKF_LEFTBUTTONDOWN"></a><a id="mkf_leftbuttondown"></a><dl> <dt><b>MKF_LEFTBUTTONDOWN</b></dt>
    ///<dt>0x01000000</dt> </dl> </td> <td width="60%"> <b>Windows 95/98, Windows 2000:</b> The left button is in the
    ///"down" state. </td> </tr> <tr> <td width="40%"><a id="MKF_LEFTBUTTONSEL"></a><a id="mkf_leftbuttonsel"></a><dl>
    ///<dt><b>MKF_LEFTBUTTONSEL</b></dt> <dt>0x10000000</dt> </dl> </td> <td width="60%"> <b>Windows 95/98, Windows
    ///2000:</b> The user has selected the left button for mouse-button actions. </td> </tr> <tr> <td width="40%"><a
    ///id="MKF_MODIFIERS"></a><a id="mkf_modifiers"></a><dl> <dt><b>MKF_MODIFIERS</b></dt> <dt>0x00000040</dt> </dl>
    ///</td> <td width="60%"> <b>Windows 95/98, Windows 2000:</b> The CTRL key increases cursor speed by the value
    ///specified by the <b>iCtrlSpeed</b> member, and the SHIFT key causes the cursor to delay briefly after moving a
    ///single pixel, allowing fine positioning of the cursor. If this value is not specified, the CTRL and SHIFT keys
    ///are ignored while the user moves the mouse cursor using the arrow keys. </td> </tr> <tr> <td width="40%"><a
    ///id="MKF_MOUSEKEYSON"></a><a id="mkf_mousekeyson"></a><dl> <dt><b>MKF_MOUSEKEYSON</b></dt> <dt>0x00000001</dt>
    ///</dl> </td> <td width="60%"> If this flag is set, the MouseKeys feature is on. </td> </tr> <tr> <td
    ///width="40%"><a id="MKF_MOUSEMODE"></a><a id="mkf_mousemode"></a><dl> <dt><b>MKF_MOUSEMODE</b></dt>
    ///<dt>0x80000000</dt> </dl> </td> <td width="60%"> <b>Windows 95/98, Windows 2000:</b> The system is processing
    ///numeric keypad input as mouse commands. </td> </tr> <tr> <td width="40%"><a id="MKF_REPLACENUMBERS"></a><a
    ///id="mkf_replacenumbers"></a><dl> <dt><b>MKF_REPLACENUMBERS</b></dt> <dt>0x00000080</dt> </dl> </td> <td
    ///width="60%"> <b>Windows 95/98, Windows 2000:</b> The numeric keypad moves the mouse when the NUM LOCK key is on.
    ///If this flag is not specified, the numeric keypad moves the mouse cursor when the NUM LOCK key is off. </td>
    ///</tr> <tr> <td width="40%"><a id="MKF_RIGHTBUTTONDOWN"></a><a id="mkf_rightbuttondown"></a><dl>
    ///<dt><b>MKF_RIGHTBUTTONDOWN</b></dt> <dt>0x02000000</dt> </dl> </td> <td width="60%"> <b>Windows 95/98, Windows
    ///2000:</b> The right button is in the "down" state. </td> </tr> <tr> <td width="40%"><a
    ///id="MKF_RIGHTBUTTONSEL"></a><a id="mkf_rightbuttonsel"></a><dl> <dt><b>MKF_RIGHTBUTTONSEL</b></dt>
    ///<dt>0x20000000</dt> </dl> </td> <td width="60%"> <b>Windows 95/98, Windows 2000:</b> The user has selected the
    ///right button for mouse-button actions. </td> </tr> </table>
    uint dwFlags;
    ///Type: <b>DWORD</b> Specifies the maximum speed the mouse cursor attains when an arrow key is held down.
    ///<b>Windows 95/98:</b> Range checking is not performed. <b>Windows NT/2000:</b> Valid values are from 10 to 360.
    uint iMaxSpeed;
    ///Type: <b>DWORD</b> Specifies the length of time, in milliseconds, that it takes for the mouse cursor to reach
    ///maximum speed when an arrow key is held down. Valid values are from 1000 to 5000.
    uint iTimeToMaxSpeed;
    ///Type: <b>DWORD</b> Specifies the multiplier to apply to the mouse cursor speed when the user holds down the CTRL
    ///key while using the arrow keys to move the cursor. this value is ignored if MKF_MODIFIERS is not set.
    uint iCtrlSpeed;
    ///Type: <b>DWORD</b> This member is reserved for future use. It must be set to zero.
    uint dwReserved1;
    ///Type: <b>DWORD</b> This member is reserved for future use. It must be set to zero.
    uint dwReserved2;
}

///Contains information about the time-out period associated with the Microsoft Win32 accessibility features. The
///accessibility time-out period is the length of time that must pass without keyboard and mouse input before the
///operating system automatically turns off accessibility features. The accessibility time-out is designed for computers
///that are shared by several users so that options selected by one user do not inconvenience a subsequent user. The
///accessibility features affected by the time-out are the FilterKeys features (SlowKeys, BounceKeys, and RepeatKeys),
///MouseKeys, ToggleKeys, and StickyKeys. The accessibility time-out also affects the high contrast mode setting.
struct ACCESSTIMEOUT
{
    ///Type: <b>UINT</b> Specifies the size, in bytes, of this structure.
    uint cbSize;
    ///Type: <b>DWORD</b> A set of bit flags that specify properties of the time-out behavior for accessibility
    ///features. The following values are defined. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="ATF_ONOFFFEEDBACK"></a><a id="atf_onofffeedback"></a><dl> <dt><b>ATF_ONOFFFEEDBACK</b></dt>
    ///<dt>0x00000002 </dt> </dl> </td> <td width="60%"> If this flag is set, the operating system plays a descending
    ///siren sound when the time-out period elapses and the accessibility features are turned off. </td> </tr> <tr> <td
    ///width="40%"><a id="ATF_TIMEOUTON"></a><a id="atf_timeouton"></a><dl> <dt><b>ATF_TIMEOUTON</b></dt>
    ///<dt>0x00000001</dt> </dl> </td> <td width="60%"> If this flag is set, a time-out period has been set for
    ///accessibility features. If this flag is not set, the features will not time out even though a time-out period is
    ///specified. </td> </tr> </table>
    uint dwFlags;
    ///Type: <b>DWORD</b> Specifies the time-out period, in milliseconds.
    uint iTimeOutMSec;
}

///Contains information about the SoundSentry accessibility feature. When the SoundSentry feature is on, the computer
///displays a visual indication only when a sound is generated. <b>Windows 95/98:</b> The visual indication is displayed
///when a sound is generated through the computer's internal speaker. <b>Windows NT/2000:</b> The visual indication is
///displayed when a sound is generated through either the multimedia sound services or through the computer's speaker.
struct SOUNDSENTRYA
{
    ///Type: <b>UINT</b> Specifies the size, in bytes, of this structure.
    uint         cbSize;
    ///Type: <b>DWORD</b> A set of bit flags that specify properties of the SoundSentry feature. The following bit-flag
    ///values are defined: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="SSF_AVAILABLE"></a><a id="ssf_available"></a><dl> <dt><b>SSF_AVAILABLE</b></dt> <dt>0x00000002</dt> </dl>
    ///</td> <td width="60%"> If this flag is set, the SoundSentry feature is available. </td> </tr> <tr> <td
    ///width="40%"><a id="SSF_INDICATOR"></a><a id="ssf_indicator"></a><dl> <dt><b>SSF_INDICATOR</b></dt>
    ///<dt>0x00000004</dt> </dl> </td> <td width="60%"> This flag is not implemented. </td> </tr> <tr> <td
    ///width="40%"><a id="SSF_SOUNDSENTRYON"></a><a id="ssf_soundsentryon"></a><dl> <dt><b>SSF_SOUNDSENTRYON</b></dt>
    ///<dt>0x00000001</dt> </dl> </td> <td width="60%"> If this flag is set, the SoundSentry feature is on. </td> </tr>
    ///</table>
    uint         dwFlags;
    ///Type: <b>DWORD</b> <b>Windows 95/98:</b> Specifies the visual signal to present when a text-mode application
    ///generates a sound while running in a full-screen virtual machine. This member can be one of the following values:
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SSTF_BORDER"></a><a
    ///id="sstf_border"></a><dl> <dt><b>SSTF_BORDER</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Flash the screen
    ///border (that is, the overscan area), which is unavailable on some displays. </td> </tr> <tr> <td width="40%"><a
    ///id="SSTF_CHARS"></a><a id="sstf_chars"></a><dl> <dt><b>SSTF_CHARS</b></dt> <dt>1</dt> </dl> </td> <td
    ///width="60%"> Flash characters in the corner of the screen. </td> </tr> <tr> <td width="40%"><a
    ///id="SSTF_DISPLAY"></a><a id="sstf_display"></a><dl> <dt><b>SSTF_DISPLAY</b></dt> <dt>3</dt> </dl> </td> <td
    ///width="60%"> Flash the entire display. </td> </tr> <tr> <td width="40%"><a id="SSTF_NONE"></a><a
    ///id="sstf_none"></a><dl> <dt><b>SSTF_NONE</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> No visual signal </td>
    ///</tr> </table> <b>Windows NT/2000:</b> This member is reserved for future use. It must be set to zero.
    uint         iFSTextEffect;
    ///Type: <b>DWORD</b> <b>Windows 95/98:</b> Specifies the duration, in milliseconds, of the visual signal that is
    ///displayed when a full-screen, text-mode application generates a sound. <b>Windows NT/2000:</b> This member is
    ///reserved for future use. It must be set to zero.
    uint         iFSTextEffectMSec;
    ///Type: <b>DWORD</b> <b>Windows 95/98:</b> Specifies the RGB value of the color to be used when displaying the
    ///visual signal shown when a full-screen, text-mode application generates a sound. <b>Windows NT/2000:</b> This
    ///member is reserved for future use. It must be set to zero.
    uint         iFSTextEffectColorBits;
    ///Type: <b>DWORD</b> <b>Windows 95/98:</b> Specifies the visual signal to present when a graphics-mode application
    ///generates a sound while running in a full-screen virtual machine. This member can be one of the following values:
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SSGF_DISPLAY"></a><a
    ///id="ssgf_display"></a><dl> <dt><b>SSGF_DISPLAY</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> Flash the entire
    ///display. </td> </tr> <tr> <td width="40%"><a id="SSGF_NONE"></a><a id="ssgf_none"></a><dl>
    ///<dt><b>SSGF_NONE</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> No visual signal. </td> </tr> </table>
    ///<b>Windows NT/2000:</b> This member is reserved for future use. It must be set to zero.
    uint         iFSGrafEffect;
    ///Type: <b>DWORD</b> <b>Windows 95/98:</b> Specifies the duration, in milliseconds, of the visual signal that is
    ///displayed when a full-screen, graphics-mode application generates a sound. <b>Windows NT/2000:</b> This member is
    ///reserved for future use. It must be set to zero.
    uint         iFSGrafEffectMSec;
    ///Type: <b>DWORD</b> <b>Windows 95/98:</b> Specifies the RGB value of the color to be used when displaying the
    ///visual signal shown when a full-screen, graphics-mode application generates a sound. <b>Windows NT/2000:</b> This
    ///member is reserved for future use. It must be set to zero.
    uint         iFSGrafEffectColor;
    ///Type: <b>DWORD</b> Specifies the visual signal to display when a sound is generated by a Windows-based
    ///application or an MS-DOS application running in a window. This member can be one of the following values: <table>
    ///<tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SSWF_CUSTOM"></a><a
    ///id="sswf_custom"></a><dl> <dt><b>SSWF_CUSTOM</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> Use a custom visual
    ///signal. </td> </tr> <tr> <td width="40%"><a id="SSWF_DISPLAY"></a><a id="sswf_display"></a><dl>
    ///<dt><b>SSWF_DISPLAY</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> Flash the entire display. </td> </tr> <tr>
    ///<td width="40%"><a id="SSWF_NONE"></a><a id="sswf_none"></a><dl> <dt><b>SSWF_NONE</b></dt> <dt>0</dt> </dl> </td>
    ///<td width="60%"> No visual signal. </td> </tr> <tr> <td width="40%"><a id="SSWF_TITLE"></a><a
    ///id="sswf_title"></a><dl> <dt><b>SSWF_TITLE</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Flash the title bar
    ///of the active window. </td> </tr> <tr> <td width="40%"><a id="SSWF_WINDOW"></a><a id="sswf_window"></a><dl>
    ///<dt><b>SSWF_WINDOW</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Flash the active window. </td> </tr> </table>
    uint         iWindowsEffect;
    ///Type: <b>DWORD</b> <b>Windows 95/98:</b> Specifies the duration, in milliseconds, of the visual signal that is
    ///displayed when a Win32-based application (or an application running in a window) generates a sound. <b>Windows
    ///NT/2000:</b> This member is reserved for future use. It must be set to zero.
    uint         iWindowsEffectMSec;
    ///Type: <b>LPTSTR</b> This member is reserved for future use. It should be set to <b>NULL</b>.
    const(char)* lpszWindowsEffectDLL;
    ///Type: <b>DWORD</b> This member is reserved for future use. It must be set to zero.
    uint         iWindowsEffectOrdinal;
}

///Contains information about the SoundSentry accessibility feature. When the SoundSentry feature is on, the computer
///displays a visual indication only when a sound is generated. <b>Windows 95/98:</b> The visual indication is displayed
///when a sound is generated through the computer's internal speaker. <b>Windows NT/2000:</b> The visual indication is
///displayed when a sound is generated through either the multimedia sound services or through the computer's speaker.
struct SOUNDSENTRYW
{
    ///Type: <b>UINT</b> Specifies the size, in bytes, of this structure.
    uint          cbSize;
    ///Type: <b>DWORD</b> A set of bit flags that specify properties of the SoundSentry feature. The following bit-flag
    ///values are defined: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="SSF_AVAILABLE"></a><a id="ssf_available"></a><dl> <dt><b>SSF_AVAILABLE</b></dt> <dt>0x00000002</dt> </dl>
    ///</td> <td width="60%"> If this flag is set, the SoundSentry feature is available. </td> </tr> <tr> <td
    ///width="40%"><a id="SSF_INDICATOR"></a><a id="ssf_indicator"></a><dl> <dt><b>SSF_INDICATOR</b></dt>
    ///<dt>0x00000004</dt> </dl> </td> <td width="60%"> This flag is not implemented. </td> </tr> <tr> <td
    ///width="40%"><a id="SSF_SOUNDSENTRYON"></a><a id="ssf_soundsentryon"></a><dl> <dt><b>SSF_SOUNDSENTRYON</b></dt>
    ///<dt>0x00000001</dt> </dl> </td> <td width="60%"> If this flag is set, the SoundSentry feature is on. </td> </tr>
    ///</table>
    uint          dwFlags;
    ///Type: <b>DWORD</b> <b>Windows 95/98:</b> Specifies the visual signal to present when a text-mode application
    ///generates a sound while running in a full-screen virtual machine. This member can be one of the following values:
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SSTF_BORDER"></a><a
    ///id="sstf_border"></a><dl> <dt><b>SSTF_BORDER</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Flash the screen
    ///border (that is, the overscan area), which is unavailable on some displays. </td> </tr> <tr> <td width="40%"><a
    ///id="SSTF_CHARS"></a><a id="sstf_chars"></a><dl> <dt><b>SSTF_CHARS</b></dt> <dt>1</dt> </dl> </td> <td
    ///width="60%"> Flash characters in the corner of the screen. </td> </tr> <tr> <td width="40%"><a
    ///id="SSTF_DISPLAY"></a><a id="sstf_display"></a><dl> <dt><b>SSTF_DISPLAY</b></dt> <dt>3</dt> </dl> </td> <td
    ///width="60%"> Flash the entire display. </td> </tr> <tr> <td width="40%"><a id="SSTF_NONE"></a><a
    ///id="sstf_none"></a><dl> <dt><b>SSTF_NONE</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> No visual signal </td>
    ///</tr> </table> <b>Windows NT/2000:</b> This member is reserved for future use. It must be set to zero.
    uint          iFSTextEffect;
    ///Type: <b>DWORD</b> <b>Windows 95/98:</b> Specifies the duration, in milliseconds, of the visual signal that is
    ///displayed when a full-screen, text-mode application generates a sound. <b>Windows NT/2000:</b> This member is
    ///reserved for future use. It must be set to zero.
    uint          iFSTextEffectMSec;
    ///Type: <b>DWORD</b> <b>Windows 95/98:</b> Specifies the RGB value of the color to be used when displaying the
    ///visual signal shown when a full-screen, text-mode application generates a sound. <b>Windows NT/2000:</b> This
    ///member is reserved for future use. It must be set to zero.
    uint          iFSTextEffectColorBits;
    ///Type: <b>DWORD</b> <b>Windows 95/98:</b> Specifies the visual signal to present when a graphics-mode application
    ///generates a sound while running in a full-screen virtual machine. This member can be one of the following values:
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SSGF_DISPLAY"></a><a
    ///id="ssgf_display"></a><dl> <dt><b>SSGF_DISPLAY</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> Flash the entire
    ///display. </td> </tr> <tr> <td width="40%"><a id="SSGF_NONE"></a><a id="ssgf_none"></a><dl>
    ///<dt><b>SSGF_NONE</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> No visual signal. </td> </tr> </table>
    ///<b>Windows NT/2000:</b> This member is reserved for future use. It must be set to zero.
    uint          iFSGrafEffect;
    ///Type: <b>DWORD</b> <b>Windows 95/98:</b> Specifies the duration, in milliseconds, of the visual signal that is
    ///displayed when a full-screen, graphics-mode application generates a sound. <b>Windows NT/2000:</b> This member is
    ///reserved for future use. It must be set to zero.
    uint          iFSGrafEffectMSec;
    ///Type: <b>DWORD</b> <b>Windows 95/98:</b> Specifies the RGB value of the color to be used when displaying the
    ///visual signal shown when a full-screen, graphics-mode application generates a sound. <b>Windows NT/2000:</b> This
    ///member is reserved for future use. It must be set to zero.
    uint          iFSGrafEffectColor;
    ///Type: <b>DWORD</b> Specifies the visual signal to display when a sound is generated by a Windows-based
    ///application or an MS-DOS application running in a window. This member can be one of the following values: <table>
    ///<tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SSWF_CUSTOM"></a><a
    ///id="sswf_custom"></a><dl> <dt><b>SSWF_CUSTOM</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> Use a custom visual
    ///signal. </td> </tr> <tr> <td width="40%"><a id="SSWF_DISPLAY"></a><a id="sswf_display"></a><dl>
    ///<dt><b>SSWF_DISPLAY</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> Flash the entire display. </td> </tr> <tr>
    ///<td width="40%"><a id="SSWF_NONE"></a><a id="sswf_none"></a><dl> <dt><b>SSWF_NONE</b></dt> <dt>0</dt> </dl> </td>
    ///<td width="60%"> No visual signal. </td> </tr> <tr> <td width="40%"><a id="SSWF_TITLE"></a><a
    ///id="sswf_title"></a><dl> <dt><b>SSWF_TITLE</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Flash the title bar
    ///of the active window. </td> </tr> <tr> <td width="40%"><a id="SSWF_WINDOW"></a><a id="sswf_window"></a><dl>
    ///<dt><b>SSWF_WINDOW</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Flash the active window. </td> </tr> </table>
    uint          iWindowsEffect;
    ///Type: <b>DWORD</b> <b>Windows 95/98:</b> Specifies the duration, in milliseconds, of the visual signal that is
    ///displayed when a Win32-based application (or an application running in a window) generates a sound. <b>Windows
    ///NT/2000:</b> This member is reserved for future use. It must be set to zero.
    uint          iWindowsEffectMSec;
    ///Type: <b>LPTSTR</b> This member is reserved for future use. It should be set to <b>NULL</b>.
    const(wchar)* lpszWindowsEffectDLL;
    ///Type: <b>DWORD</b> This member is reserved for future use. It must be set to zero.
    uint          iWindowsEffectOrdinal;
}

///Contains information about the ToggleKeys accessibility feature. When the ToggleKeys feature is on, the computer
///emits a high-pitched tone whenever the user turns on the CAPS LOCK, NUM LOCK, or SCROLL LOCK key, and a low-pitched
///tone whenever the user turns off one of those keys.
struct TOGGLEKEYS
{
    ///Type: <b>DWORD</b> Specifies the size, in bytes, of this structure.
    uint cbSize;
    ///Type: <b>DWORD</b> A set of bit flags that specify properties of the ToggleKeys feature. The following bit flag
    ///values are defined: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="TKF_AVAILABLE"></a><a id="tkf_available"></a><dl> <dt><b>TKF_AVAILABLE</b></dt> <dt>0x00000002</dt> </dl>
    ///</td> <td width="60%"> If this flag is set, the ToggleKeys feature is available. </td> </tr> <tr> <td
    ///width="40%"><a id="TKF_CONFIRMHOTKEY"></a><a id="tkf_confirmhotkey"></a><dl> <dt><b>TKF_CONFIRMHOTKEY</b></dt>
    ///<dt>0x00000008</dt> </dl> </td> <td width="60%"> <b>Windows 95/98, Windows 2000:</b> A confirmation dialog box
    ///appears when the ToggleKeys feature is activated by using the hot key. </td> </tr> <tr> <td width="40%"><a
    ///id="TKF_HOTKEYACTIVE"></a><a id="tkf_hotkeyactive"></a><dl> <dt><b>TKF_HOTKEYACTIVE</b></dt> <dt>0x00000004</dt>
    ///</dl> </td> <td width="60%"> If this flag is set, the user can turn the ToggleKeys feature on and off by holding
    ///down the NUM LOCK key for eight seconds. </td> </tr> <tr> <td width="40%"><a id="TKF_HOTKEYSOUND"></a><a
    ///id="tkf_hotkeysound"></a><dl> <dt><b>TKF_HOTKEYSOUND</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> If
    ///this flag is set, the system plays a siren sound when the user turns the ToggleKeys feature on or off by using
    ///the hot key. </td> </tr> <tr> <td width="40%"><a id="TKF_INDICATOR"></a><a id="tkf_indicator"></a><dl>
    ///<dt><b>TKF_INDICATOR</b></dt> <dt>0x00000020</dt> </dl> </td> <td width="60%"> This flag is not implemented.
    ///</td> </tr> <tr> <td width="40%"><a id="TKF_TOGGLEKEYSON"></a><a id="tkf_togglekeyson"></a><dl>
    ///<dt><b>TKF_TOGGLEKEYSON</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> If this flag is set, the
    ///ToggleKeys feature is on. </td> </tr> </table>
    uint dwFlags;
}

///Used by server developers to expose the names of owner-drawn menu items.
struct MSAAMENUINFO
{
    ///Type: <b>DWORD</b> Must be MSAA_MENU_SIG, which is defined in oleacc.h.
    uint          dwMSAASignature;
    ///Type: <b>DWORD</b> Length, in characters, of the text for the menu item, <b>not including</b> the Unicode
    ///null-terminated character.
    uint          cchWText;
    ///Type: <b>LPWSTR</b> The text of the menu item, in Unicode, <b>including</b> the Unicode null-terminated
    ///character.
    const(wchar)* pszWText;
}

///Contains the position and size of a rectangle, in screen coordinates.
struct UiaRect
{
    ///Type: <b>double</b> Position of the left side.
    double left;
    ///Type: <b>double</b> Position of the top side.
    double top;
    ///Type: <b>double</b> Width.
    double width;
    double height;
}

///Contains the coordinates of a point.
struct UiaPoint
{
    ///Type: <b>double</b> The horizontal screen coordinate.
    double x;
    double y;
}

///Contains data about a UI Automation change that occurred.
struct UiaChangeInfo
{
    ///Identifies the type of change info. Possible values are all the values of <b>Change Indentifiers</b>, Property
    ///Identifiers, Text Attribute Identifiers, Annotation Type Identifiers and Style Identifiers.
    int     uiaId;
    ///Information about the type of change that occurred.
    VARIANT payload;
    ///Detailed information about the change that occurred.
    VARIANT extraInfo;
}

///Contains information about a parameter of a custom control pattern.
struct UIAutomationParameter
{
    ///Type: <b>UIAutomationType</b> A value indicating the type of the parameter.
    UIAutomationType type;
    ///Type: <b>void*</b> A pointer to the parameter data.
    void*            pData;
}

///Contains information about a custom property.
struct UIAutomationPropertyInfo
{
    ///Type: <b>GUID</b> The unique identifier of the property.
    GUID             guid;
    ///Type: <b>LPCWSTR</b> The programmatic name of the property (a non-localizable string).
    const(wchar)*    pProgrammaticName;
    ///Type: <b>UIAutomationType</b> A value from the UIAutomationType enumerated type indicating the data type of the
    ///property value.
    UIAutomationType type;
}

///Contains information about a custom event.
struct UIAutomationEventInfo
{
    ///Type: <b>GUID</b> The event identifier.
    GUID          guid;
    ///Type: <b>LPCWSTR</b> The programmatic name of the event (a non-localizable string).
    const(wchar)* pProgrammaticName;
}

///Contains information about a method that is supported by a custom control pattern.
struct UIAutomationMethodInfo
{
    ///Type: <b>LPCWSTR</b> The name of the method (a non-localizable string).
    const(wchar)*     pProgrammaticName;
    ///Type: <b>BOOL</b> <b>TRUE</b> if UI Automation should set the focus on the object before calling the method;
    ///otherwise <b>FALSE</b>.
    BOOL              doSetFocus;
    ///Type: <b>UINT</b> The count of [in] parameters, which are always first in the <b>pParameterTypes</b> array.
    uint              cInParameters;
    ///Type: <b>UINT</b> The count of [out] parameters, which always follow the [in] parameters in the
    ///<b>pParameterTypes</b> array.
    uint              cOutParameters;
    ///Type: <b>UIAutomationType*</b> A pointer to an array of values indicating the data types of the parameters of the
    ///method. The data types of the In parameters should be first, followed by those of the Out parameters.
    UIAutomationType* pParameterTypes;
    ///Type: <b>LPCWSTR*</b> A pointer to an array containing the parameter names (non-localizable strings).
    ushort**          pParameterNames;
}

///Contains information about a custom control pattern.
struct UIAutomationPatternInfo
{
    ///Type: <b>GUID</b> The unique identifier of the control pattern.
    GUID          guid;
    ///Type: <b>LPCWSTR</b> The name of the control pattern (a non-localizable string).
    const(wchar)* pProgrammaticName;
    ///Type: <b>GUID</b> The unique identifier of the provider interface for the control pattern.
    GUID          providerInterfaceId;
    ///Type: <b>GUID</b> The unique identifier of the client interface for the control pattern.
    GUID          clientInterfaceId;
    ///Type: <b>UINT</b> The count of elements in <b>pProperties</b>.
    uint          cProperties;
    ///Type: <b>UIAutomationPropertyInfo*</b> A pointer to an array of structures describing properties available on the
    ///control pattern.
    UIAutomationPropertyInfo* pProperties;
    ///Type: <b>UINT</b> The count of elements in <b>pMethods</b>.
    uint          cMethods;
    ///Type: <b>UIAutomationMethodInfo*</b> A pointer to an array of structures describing methods available on the
    ///control pattern.
    UIAutomationMethodInfo* pMethods;
    ///Type: <b>UINT</b> The count of elements in <b>pEvents</b>.
    uint          cEvents;
    ///Type: <b>UIAutomationEventInfo*</b> A pointer to an array of structures describing events available on the
    ///control pattern.
    UIAutomationEventInfo* pEvents;
    ///Type: <b>IUIAutomationPatternHandler*</b> A pointer to the object that makes the control pattern available to
    ///clients.
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

///<div class="alert"><b>Note</b> This structure is deprecated.</div><div> </div> Contains information about a
///condition.
struct UiaCondition
{
    ConditionType ConditionType200;
}

///<div class="alert"><b>Note</b> This structure is deprecated.</div><div> </div> Contains information about a condition
///used to find UI Automation elements that have a matching property.
struct UiaPropertyCondition
{
    ///Type: <b>ConditionType</b> A value indicating the type of the condition.
    ConditionType ConditionType201;
    ///Type: <b>PROPERTYID</b> The identifier of the property to match. For a list of property IDs, see Property
    ///Identifiers.
    int           PropertyId;
    ///Type: <b>VARIANT</b> The value that the property must have.
    VARIANT       Value;
    PropertyConditionFlags Flags;
}

///<div class="alert"><b>Note</b> This structure is deprecated.</div><div> </div> Contains information about a complex
///condition.
struct UiaAndOrCondition
{
    ///Type: <b>ConditionType</b> A value from the ConditionType enumerated type indicating the type of the condition.
    ConditionType  ConditionType202;
    ///Type: <b>UiaCondition**</b> The address of an array of pointers to UiaCondition structures containing information
    ///about the complex condition.
    UiaCondition** ppConditions;
    int            cConditions;
}

///<div class="alert"><b>Note</b> This structure is deprecated.</div><div> </div> Contains information about a negative
///condition.
struct UiaNotCondition
{
    ///Type: <b>ConditionType</b> A value from the ConditionType enumerated type indicating the type of condition.
    ConditionType ConditionType203;
    UiaCondition* pCondition;
}

///<div class="alert"><b>Note</b> This structure is deprecated.</div><div> </div> Contains information about a request
///to cache data about UI Automation elements.
struct UiaCacheRequest
{
    ///Type: <b>UiaCondition *</b> The address of a UiaCondition structure that specifies the condition that cached
    ///elements must match.
    UiaCondition* pViewCondition;
    ///Type: <b>TreeScope</b> A value from the TreeScope enumerated type indicating the scope of the cache request; for
    ///example, whether it includes children of the root element.
    TreeScope     Scope;
    ///Type: <b>PROPERTYID*</b> The address of an array of identifiers for properties to cache. For a list of property
    ///IDs, see Property Identifiers.
    int*          pProperties;
    ///Type: <b>int</b> The count of elements in the <b>pProperties</b> array.
    int           cProperties;
    ///Type: <b>PATTERNID*</b> The address of an array of identifiers for control patterns to cache. For a list of
    ///control pattern IDs, see Control Pattern Identifiers.
    int*          pPatterns;
    ///Type: <b>int</b> The count of elements in the <b>pPatterns</b> array.
    int           cPatterns;
    AutomationElementMode automationElementMode;
}

///<div class="alert"><b>Note</b> This structure is deprecated.</div><div> </div> Contains parameters used in the
///UiaFind function.
struct UiaFindParams
{
    ///Type: <b>int</b> The maximum depth to which to search the tree for matching elements.
    int           MaxDepth;
    ///Type: <b>BOOL</b> <b>TRUE</b> to return only the first matching element; <b>FALSE</b> to return all matching
    ///elements.
    BOOL          FindFirst;
    ///Type: <b>BOOL</b> <b>TRUE</b> to exclude the root element; otherwise <b>FALSE</b>.
    BOOL          ExcludeRoot;
    UiaCondition* pFindCondition;
}

///<div class="alert"><b>Note</b> This structure is deprecated.</div><div> </div> Contains information about a Microsoft
///UI Automation event.
struct UiaEventArgs
{
    ///Type: <b>EventArgsType</b> A value from the EventArgsType enumerated type indicating the type of the event.
    EventArgsType Type;
    int           EventId;
}

///<div class="alert"><b>Note</b> This structure is deprecated.</div><div> </div> Contains information about an event
///that is raised when a Microsoft UI Automation element property change occurs.
struct UiaPropertyChangedEventArgs
{
    ///Type: <b>EventArgsType</b> A value from the EventArgsType enumerated type indicating the type of event.
    EventArgsType Type;
    ///Type: <b>int</b> The identifier of the event. For a list of event identifiers, see Event Identifiers.
    int           EventId;
    ///Type: <b>PROPERTYID</b> The identifier of the property that has changed. For a list of property IDs, see Property
    ///Identifiers.
    int           PropertyId;
    ///Type: <b>VARIANT</b> A VARIANT containing the old value of the property.
    VARIANT       OldValue;
    ///Type: <b>VARIANT</b> A VARIANT containing the new value of the property.
    VARIANT       NewValue;
}

///<div class="alert"><b>Note</b> This structure is deprecated.</div><div> </div> Contains information about an event
///that is raised when the structure of the Microsoft UI Automation tree changes.
struct UiaStructureChangedEventArgs
{
    ///Type: <b>EventArgsType</b> A value from the EventArgsType enumerated type indicating the type of event.
    EventArgsType       Type;
    ///Type: <b>int</b> The identifier of the event. For a list of event identifiers, see Event Identifiers.
    int                 EventId;
    ///Type: <b>StructureChangeType</b> A value from the StructureChangeType enumerated type indicating the type of
    ///change that has taken place.
    StructureChangeType StructureChangeType204;
    ///Type: <b>int*</b> The address of an array of runtime identifiers for elements involved in the change.
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

///<div class="alert"><b>Note</b> This structure is deprecated.</div><div> </div> Contains information about an event
///raised when content is being asynchronously loaded by a UI element.
struct UiaAsyncContentLoadedEventArgs
{
    ///Type: <b>EventArgsType</b> A value from the EventArgsType enumerated type indicating the type of the event.
    EventArgsType Type;
    ///Type: <b>int</b> The identifier of the event. For a list of event identifiers, see Event Identifiers.
    int           EventId;
    ///Type: <b>AsyncContentLoadedState</b> A value from the AsyncContentLoadedState enumerated type indicating the
    ///state of asynchronous loading.
    AsyncContentLoadedState AsyncContentLoadedState206;
    double        PercentComplete;
}

///<div class="alert"><b>Note</b> This structure is deprecated.</div><div> </div> Contains information about an event
///that is raised when one or more windows closes.
struct UiaWindowClosedEventArgs
{
    ///Type: <b>EventArgsType</b> A value from the EventArgsType enumerated type indicating the type of event.
    EventArgsType Type;
    ///Type: <b>int</b> The event identifier. For a list of event identifiers, see Event Identifiers.
    int           EventId;
    ///Type: <b>int*</b> The address of an array of the UI Automation runtime identifiers of windows that have closed.
    int*          pRuntimeId;
    ///Type: <b>int</b> The count of elements in the array.
    int           cRuntimeIdLen;
}

///Contains information about an extended property.
struct ExtendedProperty
{
    ///Type: <b>BSTR</b> A localized string that contains the name of the extended property.
    BSTR PropertyName;
    ///Type: <b>BSTR</b> A string that represents the value of the extended property. This string should be localized,
    ///if appropriate.
    BSTR PropertyValue;
}

// Functions

///Allows the caller to register a target window to which all pointer input of the specified type is redirected.
///Params:
///    hwnd = The window to register as a global redirection target. Redirection can cause the foreground window to lose
///           activation (focus). To avoid this, ensure the window is a message-only window or has the WS_EX_NOACTIVATE style
///           set.
///    pointerType = Type of pointer input to be redirected to the specified window. This is any valid and supported value from the
///                  POINTER_INPUT_TYPE enumeration. Note that the generic <b>PT_POINTER</b> type and the <b>PT_MOUSE</b> type are not
///                  valid in this parameter.
///Returns:
///    If the function succeeds, the return value is non-zero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL RegisterPointerInputTarget(HWND hwnd, uint pointerType);

///Allows the caller to unregister a target window to which all pointer input of the specified type is redirected.
///Params:
///    hwnd = Window to be un-registered as a global redirection target on its desktop.
///    pointerType = Type of pointer input to no longer be redirected to the specified window. This is any valid and supported value
///                  from the POINTER_INPUT_TYPE enumeration. Note that the generic <b>PT_POINTER</b> type and the<b> PT_MOUSE</b>
///                  type are not valid in this parameter.
///Returns:
///    If the function succeeds, the return value is non-zero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL UnregisterPointerInputTarget(HWND hwnd, uint pointerType);

///<p class="CCE_Message">[<b>RegisterPointerInputTargetEx</b> is not supported and may be altered or unavailable in the
///future. Instead, use RegisterPointerInputTarget.] <b>RegisterPointerInputTargetEx</b> may be altered or unavailable.
///Instead, use RegisterPointerInputTarget.
///Params:
///    hwnd = Not supported.
///    pointerType = Not supported.
///    fObserve = Not supported.
///Returns:
///    Not supported.
///    
@DllImport("USER32")
BOOL RegisterPointerInputTargetEx(HWND hwnd, uint pointerType, BOOL fObserve);

///<p class="CCE_Message">[<b>UnregisterPointerInputTargetEx</b> is not supported and may be altered or unavailable in
///the future. Instead, use UnregisterPointerInputTarget.] <b>UnregisterPointerInputTargetEx</b> may be altered or
///unavailable. Instead, use UnregisterPointerInputTarget.
///Params:
///    hwnd = Not supported.
///    pointerType = Not supported.
///Returns:
///    Not supported.
///    
@DllImport("USER32")
BOOL UnregisterPointerInputTargetEx(HWND hwnd, uint pointerType);

///Signals the system that a predefined event occurred. If any client applications have registered a hook function for
///the event, the system calls the client's hook function.
///Params:
///    event = Type: <b>DWORD</b> Specifies the event that occurred. This value must be one of the event constants.
///    hwnd = Type: <b>HWND</b> Handle to the window that contains the object that generated the event.
///    idObject = Type: <b>LONG</b> Identifies the object that generated the event. This value is either one of the predefined
///               object identifiers or a custom object ID value.
///    idChild = Type: <b>LONG</b> Identifies whether the event was generated by an object or by a child element of the object. If
///              this value is CHILDID_SELF, the event was generated by the object itself. If not CHILDID_SELF, this value is the
///              child ID of the element that generated the event.
@DllImport("USER32")
void NotifyWinEvent(uint event, HWND hwnd, int idObject, int idChild);

///Sets an event hook function for a range of events.
///Params:
///    eventMin = Type: <b>UINT</b> Specifies the event constant for the lowest event value in the range of events that are handled
///               by the hook function. This parameter can be set to <b>EVENT_MIN</b> to indicate the lowest possible event value.
///    eventMax = Type: <b>UINT</b> Specifies the event constant for the highest event value in the range of events that are
///               handled by the hook function. This parameter can be set to EVENT_MAX to indicate the highest possible event
///               value.
///    hmodWinEventProc = Type: <b>HMODULE</b> Handle to the DLL that contains the hook function at <i>lpfnWinEventProc</i>, if the
///                       WINEVENT_INCONTEXT flag is specified in the <i>dwFlags</i> parameter. If the hook function is not located in a
///                       DLL, or if the WINEVENT_OUTOFCONTEXT flag is specified, this parameter is <b>NULL</b>.
///    pfnWinEventProc = Type: <b>WINEVENTPROC</b> Pointer to the event hook function. For more information about this function, see
///                      WinEventProc.
///    idProcess = Type: <b>DWORD</b> Specifies the ID of the process from which the hook function receives events. Specify zero (0)
///                to receive events from all processes on the current desktop.
///    idThread = Type: <b>DWORD</b> Specifies the ID of the thread from which the hook function receives events. If this parameter
///               is zero, the hook function is associated with all existing threads on the current desktop.
///    dwFlags = Type: <b>UINT</b> Flag values that specify the location of the hook function and of the events to be skipped. The
///              following flags are valid: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="WINEVENT_INCONTEXT"></a><a id="winevent_incontext"></a><dl> <dt><b>WINEVENT_INCONTEXT</b></dt> </dl> </td>
///              <td width="60%"> The DLL that contains the callback function is mapped into the address space of the process that
///              generates the event. With this flag, the system sends event notifications to the callback function as they occur.
///              The hook function must be in a DLL when this flag is specified. This flag has no effect when both the calling
///              process and the generating process are not 32-bit or 64-bit processes, or when the generating process is a
///              console application. For more information, see In-Context Hook Functions. </td> </tr> <tr> <td width="40%"><a
///              id="WINEVENT_OUTOFCONTEXT"></a><a id="winevent_outofcontext"></a><dl> <dt><b>WINEVENT_OUTOFCONTEXT</b></dt> </dl>
///              </td> <td width="60%"> The callback function is not mapped into the address space of the process that generates
///              the event. Because the hook function is called across process boundaries, the system must queue events. Although
///              this method is asynchronous, events are guaranteed to be in sequential order. For more information, see
///              Out-of-Context Hook Functions. </td> </tr> <tr> <td width="40%"><a id="WINEVENT_SKIPOWNPROCESS"></a><a
///              id="winevent_skipownprocess"></a><dl> <dt><b>WINEVENT_SKIPOWNPROCESS</b></dt> </dl> </td> <td width="60%">
///              Prevents this instance of the hook from receiving the events that are generated by threads in this process. This
///              flag does not prevent threads from generating events. </td> </tr> <tr> <td width="40%"><a
///              id="WINEVENT_SKIPOWNTHREAD"></a><a id="winevent_skipownthread"></a><dl> <dt><b>WINEVENT_SKIPOWNTHREAD</b></dt>
///              </dl> </td> <td width="60%"> Prevents this instance of the hook from receiving the events that are generated by
///              the thread that is registering this hook. </td> </tr> </table> The following flag combinations are valid: <ul>
///              <li>WINEVENT_INCONTEXT | WINEVENT_SKIPOWNPROCESS</li> <li>WINEVENT_INCONTEXT | WINEVENT_SKIPOWNTHREAD</li>
///              <li>WINEVENT_OUTOFCONTEXT | WINEVENT_SKIPOWNPROCESS</li> <li>WINEVENT_OUTOFCONTEXT | WINEVENT_SKIPOWNTHREAD</li>
///              </ul> Additionally, client applications can specify WINEVENT_INCONTEXT, or WINEVENT_OUTOFCONTEXT alone. See
///              Remarks section for information on Windows Store app development.
///Returns:
///    Type: <b>HWINEVENTHOOK</b> If successful, returns an HWINEVENTHOOK value that identifies this event hook
///    instance. Applications save this return value to use it with the UnhookWinEvent function. If unsuccessful,
///    returns zero.
///    
@DllImport("USER32")
ptrdiff_t SetWinEventHook(uint eventMin, uint eventMax, ptrdiff_t hmodWinEventProc, WINEVENTPROC pfnWinEventProc, 
                          uint idProcess, uint idThread, uint dwFlags);

///Determines whether there is an installed WinEvent hook that might be notified of a specified event.
///Params:
///    event = Type: <b>DWORD</b> The event constant that hooks might be notified of. The function checks whether there is an
///            installed hook for this event constant.
///Returns:
///    Type: <b>BOOL</b> If there is a hook to be notified of the specified event, the return value is <b>TRUE</b>. If
///    there are no hooks to be notified of the specified event, the return value is <b>FALSE</b>.
///    
@DllImport("USER32")
BOOL IsWinEventHookInstalled(uint event);

///Removes an event hook function created by a previous call to SetWinEventHook.
///Params:
///    hWinEventHook = Type: <b>HWINEVENTHOOK</b> Handle to the event hook returned in the previous call to SetWinEventHook.
///Returns:
///    Type: <b>BOOL</b> If successful, returns <b>TRUE</b>; otherwise, returns <b>FALSE</b>. Three common errors cause
///    this function to fail: <ul> <li>The <i>hWinEventHook</i> parameter is <b>NULL</b> or not valid.</li> <li>The
///    event hook specified by <i>hWinEventHook</i> was already removed.</li> <li><b>UnhookWinEvent</b> is called from a
///    thread that is different from the original call to SetWinEventHook.</li> </ul>
///    
@DllImport("USER32")
BOOL UnhookWinEvent(ptrdiff_t hWinEventHook);

///Returns a reference, similar to a handle, to the specified object. Servers return this reference when handling
///WM_GETOBJECT.
///Params:
///    riid = Type: <b>REFIID</b> Reference identifier of the interface provided to the client. This parameter is
///           IID_IAccessible.
///    wParam = Type: <b>WPARAM</b> Value sent by the associated WM_GETOBJECT message in its <i>wParam</i> parameter.
///    punk = Type: <b>LPUNKNOWN</b> Address of the IAccessible interface to the object that corresponds to the WM_GETOBJECT
///           message.
///Returns:
///    Type: <b>LRESULT</b> If successful, returns a positive value that is a reference to the object. If not
///    successful, returns one of the values in the table that follows, or another standard COM error code. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
///    </td> <td width="60%"> One or more arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"> The object specified in the <i>pAcc</i> parameter does
///    not support the interface specified in the <i>riid</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to store the object reference.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> An unexpected
///    error occurred. </td> </tr> </table>
///    
@DllImport("OLEACC")
LRESULT LresultFromObject(const(GUID)* riid, WPARAM wParam, IUnknown punk);

///Retrieves a requested interface pointer for an accessible object based on a previously generated object reference.
///This function is designed for internal use by Microsoft Active Accessibility and is documented for informational
///purposes only. Neither clients nor servers should call this function.
///Params:
///    lResult = Type: <b>LRESULT</b> A 32-bit value returned by a previous successful call to the LresultFromObject function.
///    riid = Type: <b>REFIID</b> Reference identifier of the interface to be retrieved. This is IID_IAccessible.
///    wParam = Type: <b>WPARAM</b> Value sent by the associated WM_GETOBJECT message in its <i>wParam</i> parameter.
///    ppvObject = Type: <b>void**</b> Receives the address of the IAccessible interface on the object that corresponds to the
///                WM_GETOBJECT message.
///Returns:
///    Type: <b>STDAPI</b> If successful, returns S_OK. If not successful, returns one of the following standard COM
///    error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. This occurs when
///    the <i>lResult</i> parameter specified is not a value obtained by a call to LresultFromObject, or when
///    <i>lResult</i> is a value used on a previous call to ObjectFromLresult. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"> The object specified in the <i>ppvObject</i> parameter
///    does not support the interface specified by the <i>riid</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to store the object reference.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> An unexpected
///    error occurred. </td> </tr> </table>
///    
@DllImport("OLEACC")
HRESULT ObjectFromLresult(LRESULT lResult, const(GUID)* riid, WPARAM wParam, void** ppvObject);

///Retrieves the window handle that corresponds to a particular instance of an IAccessible interface.
///Params:
///    arg1 = Type: <b>IAccessible*</b> Pointer to the IAccessible interface whose corresponding window handle will be
///           retrieved. This parameter must not be <b>NULL</b>.
///    phwnd = Type: <b>HWND*</b> Address of a variable that receives a handle to the window containing the object specified in
///            <i>pacc</i>. If this value is <b>NULL</b> after the call, the object is not contained within a window; for
///            example, the mouse pointer is not contained within a window.
///Returns:
///    Type: <b>STDAPI</b> If successful, returns S_OK. If not successful, returns the following or another standard COM
///    error code. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An argument is not valid. </td> </tr> </table>
///    
@DllImport("OLEACC")
HRESULT WindowFromAccessibleObject(IAccessible param0, HWND* phwnd);

///Retrieves the address of the specified interface for the object associated with the specified window.
///Params:
///    hwnd = Type: <b>HWND</b> Specifies the handle of a window for which an object is to be retrieved. To retrieve an
///           interface pointer to the cursor or caret object, specify <b>NULL</b> and use the appropriate object ID in
///           <i>dwObjectID</i>.
///    dwId = Type: <b>DWORD</b> Specifies the object ID. This value is one of the standard object identifier constants or a
///           custom object ID such as OBJID_NATIVEOM, which is the object ID for the Office native object model. For more
///           information about <b>OBJID_NATIVEOM</b>, see the Remarks section in this topic.
///    riid = Type: <b>REFIID</b> Specifies the reference identifier of the requested interface. This value is either
///           IID_IAccessible or IID_IDispatch, but it can also be IID_IUnknown, or the IID of any interface that the object is
///           expected to support.
///    ppvObject = Type: <b>void**</b> Address of a pointer variable that receives the address of the specified interface.
///Returns:
///    Type: <b>STDAPI</b> If successful, returns S_OK. If not successful, returns one of the following or another
///    standard COM error code. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An argument is not valid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"> The requested interface is not
///    supported. </td> </tr> </table>
///    
@DllImport("OLEACC")
HRESULT AccessibleObjectFromWindow(HWND hwnd, uint dwId, const(GUID)* riid, void** ppvObject);

///Retrieves the address of the IAccessible interface for the object that generated the event that is currently being
///processed by the client's event hook function.
///Params:
///    hwnd = Type: <b>HWND</b> Specifies the window handle of the window that generated the event. This value must be the
///           window handle that is sent to the event hook function.
///    dwId = Type: <b>DWORD</b> Specifies the object ID of the object that generated the event. This value must be the object
///           ID that is sent to the event hook function.
///    dwChildId = Type: <b>DWORD</b> Specifies whether the event was triggered by an object or one of its child elements. If the
///                object triggered the event, <i>dwChildID</i> is CHILDID_SELF. If a child element triggered the event,
///                <i>dwChildID</i> is the element's child ID. This value must be the child ID that is sent to the event hook
///                function.
///    ppacc = Type: <b>IAccessible**</b> Address of a pointer variable that receives the address of an IAccessible interface.
///            The interface is either for the object that generated the event, or for the parent of the element that generated
///            the event.
///    pvarChild = Type: <b>VARIANT*</b> Address of a VARIANT structure that specifies the child ID that can be used to access
///                information about the UI element.
///Returns:
///    Type: <b>STDAPI</b> If successful, returns S_OK. If not successful, returns one of the following or another
///    standard COM error code. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An argument is not valid. </td> </tr> </table>
///    
@DllImport("OLEACC")
HRESULT AccessibleObjectFromEvent(HWND hwnd, uint dwId, uint dwChildId, IAccessible* ppacc, VARIANT* pvarChild);

///Retrieves the address of the IAccessible interface pointer for the object displayed at a specified point on the
///screen.
///Params:
///    ptScreen = Specifies, in physical screen coordinates, the point that is examined.
///    ppacc = Address of a pointer variable that receives the address of the object's IAccessible interface.
///    pvarChild = Address of a VARIANT structure that specifies whether the IAccessible interface pointer that is returned in
///                <i>ppacc</i> belongs to the object displayed at the specified point, or to the parent of the element at the
///                specified point. The <b>vt</b> member of the <b>VARIANT</b> is always VT_I4. If the <b>lVal</b> member is
///                CHILDID_SELF, then the <b>IAccessible</b> interface pointer at <i>ppacc</i> belongs to the object at the point.
///                If the <b>lVal</b> member is not CHILDID_SELF, <i>ppacc</i> is the address of the <b>IAccessible</b> interface of
///                the child element's parent object. Clients must call VariantClear on the retrieved <b>VARIANT</b> parameter when
///                finished using it.
///Returns:
///    If successful, returns S_OK. If not successful, returns one of the following or another standard COM error code.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An argument is not valid. </td> </tr> </table>
///    
@DllImport("OLEACC")
HRESULT AccessibleObjectFromPoint(POINT ptScreen, IAccessible* ppacc, VARIANT* pvarChild);

///Retrieves the child ID or IDispatch of each child within an accessible container object.
///Params:
///    paccContainer = Type: <b>IAccessible*</b> Pointer to the container object's IAccessible interface.
///    iChildStart = Type: <b>LONG</b> Specifies the zero-based index of the first child that is retrieved. This parameter is an
///                  index, not a child ID, and it is usually is set to zero (0).
///    cChildren = Type: <b>LONG</b> Specifies the number of children to retrieve. To retrieve the current number of children, an
///                application calls IAccessible::get_accChildCount.
///    rgvarChildren = Type: <b>VARIANT*</b> Pointer to an array of VARIANT structures that receives information about the container's
///                    children. If the <b>vt</b> member of an array element is VT_I4, then the <b>lVal</b> member for that element is
///                    the child ID. If the <b>vt</b> member of an array element is VT_DISPATCH, then the <b>pdispVal</b> member for
///                    that element is the address of the child object's IDispatch interface.
///    pcObtained = Type: <b>LONG*</b> Address of a variable that receives the number of elements in the <i>rgvarChildren</i> array
///                 that is populated by the <b>AccessibleChildren</b> function. This value is the same as that of the
///                 <i>cChildren</i> parameter; however, if you request more children than exist, this value will be less than that
///                 of <i>cChildren</i>.
///Returns:
///    Type: <b>STDAPI</b> If successful, returns S_OK. If not successful, returns one of the following or another
///    standard COM error code. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An argument is not valid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The function succeeded, but there are
///    fewer elements in the <i>rgvarChildren</i> array than there are children requested in <i>cChildren</i>. </td>
///    </tr> </table>
///    
@DllImport("OLEACC")
HRESULT AccessibleChildren(IAccessible paccContainer, int iChildStart, int cChildren, char* rgvarChildren, 
                           int* pcObtained);

///Retrieves the localized string that describes the object's role for the specified role value.
///Params:
///    lRole = Type: <b>DWORD</b> One of the object role constants.
///    lpszRole = Type: <b>LPTSTR</b> Address of a buffer that receives the role text string. If this parameter is <b>NULL</b>, the
///               function returns the role string's length, not including the null character.
///    cchRoleMax = Type: <b>UINT</b> The size of the buffer that is pointed to by the <i>lpszRole</i> parameter. For ANSI strings,
///                 this value is measured in bytes; for Unicode strings, it is measured in characters.
///Returns:
///    Type: <b>UINT</b> If successful, and if <i>lpszRole</i> is non-<b>NULL</b>, the return value is the number of
///    bytes (ANSI strings) or characters (Unicode strings) copied into the buffer, not including the terminating null
///    character. If <i>lpszRole</i> is <b>NULL</b>, the return value represents the string's length, not including the
///    null character. If the string resource does not exist, or if the <i>lpszRole</i> parameter is not a valid
///    pointer, the return value is zero (0). To get extended error information, call GetLastError.
///    
@DllImport("OLEACC")
uint GetRoleTextA(uint lRole, const(char)* lpszRole, uint cchRoleMax);

///Retrieves the localized string that describes the object's role for the specified role value.
///Params:
///    lRole = Type: <b>DWORD</b> One of the object role constants.
///    lpszRole = Type: <b>LPTSTR</b> Address of a buffer that receives the role text string. If this parameter is <b>NULL</b>, the
///               function returns the role string's length, not including the null character.
///    cchRoleMax = Type: <b>UINT</b> The size of the buffer that is pointed to by the <i>lpszRole</i> parameter. For ANSI strings,
///                 this value is measured in bytes; for Unicode strings, it is measured in characters.
///Returns:
///    Type: <b>UINT</b> If successful, and if <i>lpszRole</i> is non-<b>NULL</b>, the return value is the number of
///    bytes (ANSI strings) or characters (Unicode strings) copied into the buffer, not including the terminating null
///    character. If <i>lpszRole</i> is <b>NULL</b>, the return value represents the string's length, not including the
///    null character. If the string resource does not exist, or if the <i>lpszRole</i> parameter is not a valid
///    pointer, the return value is zero (0). To get extended error information, call GetLastError.
///    
@DllImport("OLEACC")
uint GetRoleTextW(uint lRole, const(wchar)* lpszRole, uint cchRoleMax);

///Retrieves a localized string that describes an object's state for a single predefined state bit flag. Because state
///values are a combination of one or more bit flags, clients call this function more than once to retrieve all state
///strings.
///Params:
///    lStateBit = Type: <b>DWORD</b> One of the object state constants.
///    lpszState = Type: <b>LPTSTR</b> Address of a buffer that receives the state text string. If this parameter is <b>NULL</b>,
///                the function returns the state string's length, not including the null character.
///    cchState = Type: <b>UINT</b> The size of the buffer that is pointed to by the <i>lpszStateBit</i> parameter. For ANSI
///               strings, this value is measured in bytes; for Unicode strings, it is measured in characters.
///Returns:
///    Type: <b>UINT</b> If successful, and if <i>lpszStateBit</i> is non-<b>NULL</b>, the return value is the number of
///    bytes (ANSI strings) or characters (Unicode strings) that are copied into the buffer, not including the
///    null-terminated character. If <i>lpszStateBit</i> is <b>NULL</b>, the return value represents the string's
///    length, not including the null character. If the string resource does not exist, or if the <i>lpszStateBit</i>
///    parameter is not a valid pointer, the return value is zero (0). To get extended error information, call
///    GetLastError.
///    
@DllImport("OLEACC")
uint GetStateTextA(uint lStateBit, const(char)* lpszState, uint cchState);

///Retrieves a localized string that describes an object's state for a single predefined state bit flag. Because state
///values are a combination of one or more bit flags, clients call this function more than once to retrieve all state
///strings.
///Params:
///    lStateBit = Type: <b>DWORD</b> One of the object state constants.
///    lpszState = Type: <b>LPTSTR</b> Address of a buffer that receives the state text string. If this parameter is <b>NULL</b>,
///                the function returns the state string's length, not including the null character.
///    cchState = Type: <b>UINT</b> The size of the buffer that is pointed to by the <i>lpszStateBit</i> parameter. For ANSI
///               strings, this value is measured in bytes; for Unicode strings, it is measured in characters.
///Returns:
///    Type: <b>UINT</b> If successful, and if <i>lpszStateBit</i> is non-<b>NULL</b>, the return value is the number of
///    bytes (ANSI strings) or characters (Unicode strings) that are copied into the buffer, not including the
///    null-terminated character. If <i>lpszStateBit</i> is <b>NULL</b>, the return value represents the string's
///    length, not including the null character. If the string resource does not exist, or if the <i>lpszStateBit</i>
///    parameter is not a valid pointer, the return value is zero (0). To get extended error information, call
///    GetLastError.
///    
@DllImport("OLEACC")
uint GetStateTextW(uint lStateBit, const(wchar)* lpszState, uint cchState);

///Retrieves the version number and build number of the Microsoft Active Accessibility file Oleacc.dll.
///Params:
///    pVer = Type: <b>DWORD*</b> Address of a <b>DWORD</b> that receives the version number. The major version number is
///           placed in the high word, and the minor version number is placed in the low word.
///    pBuild = Type: <b>DWORD*</b> Address of a <b>DWORD</b> that receives the build number. The major build number is placed in
///             the high word, and the minor build number is placed in the low word.
@DllImport("OLEACC")
void GetOleaccVersionInfo(uint* pVer, uint* pBuild);

///Creates an accessible object with the methods and properties of the specified type of system-provided user interface
///element.
///Params:
///    hwnd = Type: <b>HWND</b> Window handle of the system-provided user interface element (a control) for which an accessible
///           object is created.
///    idObject = Type: <b>LONG</b> Object ID. This value is usually OBJID_CLIENT, but it may be another object identifier.
///    riid = Type: <b>REFIID</b> Reference identifier of the requested interface. This value is one of the following:
///           IID_IAccessible, IID_IDispatch, IID_IEnumVARIANT, or IID_IUnknown.
///    ppvObject = Type: <b>void**</b> Address of a pointer variable that receives the address of the specified interface.
///Returns:
///    Type: <b>STDAPI</b> If successful, returns S_OK. If not successful, returns a standard COM error code.
///    
@DllImport("OLEACC")
HRESULT CreateStdAccessibleObject(HWND hwnd, int idObject, const(GUID)* riid, void** ppvObject);

///Creates an accessible object that has the properties and methods of the specified class of system-provided user
///interface element.
///Params:
///    hwnd = Type: <b>HWND</b> Window handle of the system-provided user interface element (a control) for which an accessible
///           object is created.
///    pClassName = Type: <b>LPCTSTR</b> Pointer to a null-terminated string of the class name of a system-provided user interface
///                 element for which an accessible object is created. The window class name is one of the common controls (defined
///                 in Comctl32.dll), predefined controls (defined in User32.dll), or window elements.
///    idObject = Type: <b>LONG</b> Object ID. This value is usually OBJID_CLIENT, which is one of the object identifier constants,
///               but it may be another object identifier.
///    riid = Type: <b>REFIID</b> Reference identifier of the interface requested. This value is one of the following:
///           IID_IAccessible, IID_IDispatch, IID_IEnumVARIANT, or IID_IUnknown.
///    ppvObject = Type: <b>void**</b> Address of a pointer variable that receives the address of the specified interface.
///Returns:
///    Type: <b>STDAPI</b> If successful, returns S_OK. If not successful, returns a standard COM error code.
///    
@DllImport("OLEACC")
HRESULT CreateStdAccessibleProxyA(HWND hwnd, const(char)* pClassName, int idObject, const(GUID)* riid, 
                                  void** ppvObject);

///Creates an accessible object that has the properties and methods of the specified class of system-provided user
///interface element.
///Params:
///    hwnd = Type: <b>HWND</b> Window handle of the system-provided user interface element (a control) for which an accessible
///           object is created.
///    pClassName = Type: <b>LPCTSTR</b> Pointer to a null-terminated string of the class name of a system-provided user interface
///                 element for which an accessible object is created. The window class name is one of the common controls (defined
///                 in Comctl32.dll), predefined controls (defined in User32.dll), or window elements.
///    idObject = Type: <b>LONG</b> Object ID. This value is usually OBJID_CLIENT, which is one of the object identifier constants,
///               but it may be another object identifier.
///    riid = Type: <b>REFIID</b> Reference identifier of the interface requested. This value is one of the following:
///           IID_IAccessible, IID_IDispatch, IID_IEnumVARIANT, or IID_IUnknown.
///    ppvObject = Type: <b>void**</b> Address of a pointer variable that receives the address of the specified interface.
///Returns:
///    Type: <b>STDAPI</b> If successful, returns S_OK. If not successful, returns a standard COM error code.
///    
@DllImport("OLEACC")
HRESULT CreateStdAccessibleProxyW(HWND hwnd, const(wchar)* pClassName, int idObject, const(GUID)* riid, 
                                  void** ppvObject);

///Sets system values that indicate whether an assistive technology (AT) application's current state affects
///functionality that is typically provided by the system.
///Params:
///    hwndApp = Type: <b>HWND</b> The handle of the AT application window. This parameter must not be <b>NULL</b>.
///    dwUtilityStateMask = Type: <b>DWORD</b> A mask that indicates the system values being set. It can be a combination of the following
///                         values: <a id="ANRUS_ON_SCREEN_KEYBOARD_ACTIVE"></a> <a id="anrus_on_screen_keyboard_active"></a>
///    dwUtilityState = Type: <b>DWORD</b> The new settings for the system values indicated by <i>dwUtilityStateMask</i>. This parameter
///                     can be zero to reset the system values, or a combination of the following values. <table> <tr> <th>Value</th>
///                     <th>Meaning</th> </tr> <tr> <td width="40%"><a id="ANRUS_ON_SCREEN_KEYBOARD_ACTIVE"></a><a
///                     id="anrus_on_screen_keyboard_active"></a><dl> <dt><b>ANRUS_ON_SCREEN_KEYBOARD_ACTIVE</b></dt> <dt>0x0000001</dt>
///                     </dl> </td> <td width="60%"> The AT application is providing an on-screen keyboard. </td> </tr> <tr> <td
///                     width="40%"><a id="ANRUS_TOUCH_MODIFICATION_ACTIVE"></a><a id="anrus_touch_modification_active"></a><dl>
///                     <dt><b>ANRUS_TOUCH_MODIFICATION_ACTIVE</b></dt> <dt>0x0000002</dt> </dl> </td> <td width="60%"> The AT
///                     application is consuming redirected touch input. </td> </tr> <tr> <td width="40%"><a
///                     id="ANRUS_PRIORITY_AUDIO_ACTIVE"></a><a id="anrus_priority_audio_active"></a><dl>
///                     <dt><b>ANRUS_PRIORITY_AUDIO_ACTIVE</b></dt> <dt>0x0000004</dt> </dl> </td> <td width="60%"> The AT application is
///                     relying on audio (such as text-to-speech) to convey essential information to the user and should remain audible
///                     over other system sounds. </td> </tr> <tr> <td width="40%"><a id="ANRUS_PRIORITY_AUDIO_ACTIVE_NODUCK"></a><a
///                     id="anrus_priority_audio_active_noduck"></a><dl> <dt><b>ANRUS_PRIORITY_AUDIO_ACTIVE_NODUCK</b></dt>
///                     <dt>0x0000008</dt> </dl> </td> <td width="60%"> The AT application is relying on audio (such as text-to-speech)
///                     to convey essential information to the user but should not change relative to other system sounds. </td> </tr>
///                     </table>
///Returns:
///    Type: <b>STDAPI</b> If successful, returns S_OK. If not successful, returns a standard COM error code.
///    
@DllImport("OLEACC")
HRESULT AccSetRunningUtilityState(HWND hwndApp, uint dwUtilityStateMask, uint dwUtilityState);

///Allows an assistive technology (AT) application to notify the system that it is interacting with UI through a Windows
///Automation API (such as Microsoft UI Automation) as a result of a touch gesture from the user. This allows the
///assistive technology to notify the target application and the system that the user is interacting with touch.
///Params:
///    hwndApp = A window that belongs to the AT process that is calling <b>AccNotifyTouchInteraction</b>.
///    hwndTarget = The nearest window of the automation element that the AT is targeting.
///    ptTarget = The center point of the automation element (or a point in the bounding rectangle of the element).
///Returns:
///    If successful, returns S_OK. If not successful, returns a standard COM error code.
///    
@DllImport("OLEACC")
HRESULT AccNotifyTouchInteraction(HWND hwndApp, HWND hwndTarget, POINT ptTarget);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Gets an error string so that it can be
///passed to the client. This method is not used directly by clients.
///Params:
///    pDescription = Type: <b>BSTR*</b> The address of a variable that receives the description of the error. This parameter is passed
///                   uninitialized.
@DllImport("UIAutomationCore")
BOOL UiaGetErrorDescription(BSTR* pDescription);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Gets an HUIANODE from a VARIANT type.
///Params:
///    pvar = Type: <b>VARIANT*</b> The node.
///    phnode = Type: <b>HUIANODE*</b> The address of a variable that receives the HUIANODE. This parameter is passed
///             uninitialized.
@DllImport("UIAutomationCore")
HRESULT UiaHUiaNodeFromVariant(VARIANT* pvar, HUIANODE__** phnode);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Gets a control pattern object from a
///VARIANT type.
///Params:
///    pvar = Type: <b>VARIANT*</b> The pattern.
///    phobj = Type: <b>HUIAPATTERNOBJECT *</b> The address of a variable that receives the control pattern object. This
///            parameter is passed uninitialized.
@DllImport("UIAutomationCore")
HRESULT UiaHPatternObjectFromVariant(VARIANT* pvar, HUIAPATTERNOBJECT__** phobj);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Gets a text range from a VARIANT type.
///Params:
///    pvar = Type: <b>VARIANT*</b> The text range.
///    phtextrange = Type: <b>HUIATEXTRANGE*</b> The address of a variable that receives the text range. This parameter is passed
///                  uninitialized.
@DllImport("UIAutomationCore")
HRESULT UiaHTextRangeFromVariant(VARIANT* pvar, HUIATEXTRANGE__** phtextrange);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Deletes a node from memory.
///Params:
///    hnode = Type: <b>HUIANODE</b> The node to be deleted.
@DllImport("UIAutomationCore")
BOOL UiaNodeRelease(HUIANODE__* hnode);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Retrieves the value of a UI Automation
///property.
///Params:
///    hnode = Type: <b>HUIANODE</b> The element that the property is being requested from.
///    propertyId = Type: <b>PROPERTYID</b> The property identifier. For a list of property IDs, see Property Identifiers.
///    pValue = Type: <b>VARIANT*</b> Receives the value of the specified property, or the value returned by
///             UiaGetReservedNotSupportedValue if the property is not supported. This parameter is passed uninitialized.
@DllImport("UIAutomationCore")
HRESULT UiaGetPropertyValue(HUIANODE__* hnode, int propertyId, VARIANT* pValue);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Retrieves a <i>control pattern</i>.
///Params:
///    hnode = Type: <b>HUIANODE</b> The element that implements the pattern.
///    patternId = Type: <b>PATTERNID</b> The identifier of the control pattern being requested. For a list of control pattern IDs,
///                see Control Pattern Identifiers.
///    phobj = Type: <b>HPATTERNOBJECT*</b> The address of a variable that receives a handle to the control pattern. This
///            parameter is passed uninitialized.
@DllImport("UIAutomationCore")
HRESULT UiaGetPatternProvider(HUIANODE__* hnode, int patternId, HUIAPATTERNOBJECT__** phobj);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Retrieves the runtime identifier of a UI
///Automation node.
///Params:
///    hnode = Type: <b>HUIANODE</b> The node for which the identifier is being requested.
///    pruntimeId = Type: <b>SAFEARRAY**</b> The address of a variable that receives a pointer to a SAFEARRAY that contains the
///                 runtime identifier of the type VT_I4. This parameter is passed uninitialized.
///Returns:
///    Type: <b>HRESULT</b> Returns S_OK if successful or an error value otherwise.
///    
@DllImport("UIAutomationCore")
HRESULT UiaGetRuntimeId(HUIANODE__* hnode, SAFEARRAY** pruntimeId);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Sets the input focus to the specified
///element in the UI.
///Params:
///    hnode = Type: <b>HUIANODE</b> The element that receives focus.
@DllImport("UIAutomationCore")
HRESULT UiaSetFocus(HUIANODE__* hnode);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Navigates in the UI Automation tree,
///optionally retrieving cached information.
///Params:
///    hnode = Type: <b>HUIANODE</b> The element on which the navigation begins.
///    direction = Type: <b>NavigateDirection</b> A value from the NavigateDirection enumerated type indicating the direction to
///                navigate from <i>hnode</i>.
///    pCondition = Type: <b>UiaCondition*</b> The address of a UiaCondition structure that specifies the condition that the element
///                 being navigated to must match. Use this parameter to skip elements that are not of interest.
///    pRequest = Type: <b>UiaCacheRequest*</b> The address of a UiaCacheRequest structure that contains a description of the
///               information to be cached.
///    ppRequestedData = Type: <b>SAFEARRAY**</b> The address of a variable that receives a pointer to a SAFEARRAY that contains the
///                      requested data. This parameter is passed uninitialized. See Remarks.
///    ppTreeStructure = Type: <b>BSTR*</b> The address of a variable that receives the description of the tree structure. This parameter
///                      is passed uninitialized. See Remarks.
///Returns:
///    Type: <b>HRESULT</b> Returns S_OK if successful or an error value otherwise.
///    
@DllImport("UIAutomationCore")
HRESULT UiaNavigate(HUIANODE__* hnode, NavigateDirection direction, UiaCondition* pCondition, 
                    UiaCacheRequest* pRequest, SAFEARRAY** ppRequestedData, BSTR* ppTreeStructure);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Updates the cache of property values and
///control patterns.
///Params:
///    hnode = Type: <b>HUIANODE</b> The element that updated information is being requested for.
///    pRequest = Type: <b>UiaCacheRequest*</b> The address of a UiaCacheRequest structure that specifies the cached information to
///               update.
///    normalizeState = Type: <b>NormalizeState</b> A value from the NormalizeState enumerated type specifying the type of normalization.
///    pNormalizeCondition = Type: <b>UiaCondition*</b> The address of a UiaCondition structure that specifies a condition against which the
///                          information can be normalized, if <i>normalizeState</i> is NormalizeState_Custom.
///    ppRequestedData = Type: <b>SAFEARRAY**</b> The address of a variable that receives a pointer to a SAFEARRAY that contains the
///                      requested data. This parameter is passed uninitialized. See Remarks.
///    ppTreeStructure = Type: <b>BSTR*</b> A pointer to the description of the tree structure. This parameter is passed uninitialized.
///                      See Remarks.
///Returns:
///    Type: <b>HRESULT</b> Returns S_OK if successful or an error value otherwise.
///    
@DllImport("UIAutomationCore")
HRESULT UiaGetUpdatedCache(HUIANODE__* hnode, UiaCacheRequest* pRequest, NormalizeState normalizeState, 
                           UiaCondition* pNormalizeCondition, SAFEARRAY** ppRequestedData, BSTR* ppTreeStructure);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Retrieves one or more UI Automation
///nodes that match the search criteria.
///Params:
///    hnode = Type: <b>HUIANODE</b> The node to use as starting-point of the search.
///    pParams = Type: <b>UiaFindParams*</b> The address of a UiaFindParams structure that contains the search parameters.
///    pRequest = Type: <b>UiaCacheRequest*</b> The address of a UiaCacheRequest structure that specifies what information is to be
///               cached.
///    ppRequestedData = Type: <b>SAFEARRAY**</b> The address of a variable that receives a pointer to a SAFEARRAY containing the
///                      requested data. This parameter is passed uninitialized. See Remarks.
///    ppOffsets = Type: <b>SAFEARRAY**</b> The address of a variable that receives a pointer to a SAFEARRAY containing the indexes
///                to the requested data array for where the element subtree starts. This parameter is passed uninitialized.
///    ppTreeStructures = Type: <b>SAFEARRAY**</b> The address of a variable that receives a pointer to a SAFEARRAY containing the
///                       description of the tree structure. This parameter is passed uninitialized. See Remarks.
///Returns:
///    Type: <b>HRESULT</b> Returns S_OK if successful or an error value otherwise.
///    
@DllImport("UIAutomationCore")
HRESULT UiaFind(HUIANODE__* hnode, UiaFindParams* pParams, UiaCacheRequest* pRequest, SAFEARRAY** ppRequestedData, 
                SAFEARRAY** ppOffsets, SAFEARRAY** ppTreeStructures);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Retrieves the UI Automation node for the
///element at the specified point.
///Params:
///    x = Type: <b>double</b> The horizontal coordinate of the point.
///    y = Type: <b>double</b> The vertical coordinate of the point.
///    pRequest = Type: <b>UiaCacheRequest*</b> The address of a UiaCacheRequest structure that contains the cache request for
///               information from the client.
///    ppRequestedData = Type: <b>SAFEARRAY**</b> The address of a variable that receives a pointer to a SAFEARRAY that contains the
///                      requested data. This parameter is passed uninitialized.
///    ppTreeStructure = Type: <b>BSTR*</b> The address of a variable that receives the description of the tree structure. This parameter
///                      is passed uninitialized. See Remarks.
///Returns:
///    Type: <b>HRESULT</b> Returns S_OK if successful or an error value otherwise.
///    
@DllImport("UIAutomationCore")
HRESULT UiaNodeFromPoint(double x, double y, UiaCacheRequest* pRequest, SAFEARRAY** ppRequestedData, 
                         BSTR* ppTreeStructure);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Retrieves the UI Automation node for the
///UI element that currently has input focus.
///Params:
///    pRequest = Type: <b>UiaCacheRequest*</b> The address of a UiaCacheRequest structure that contains information about data to
///               be cached.
///    ppRequestedData = Type: <b>SAFEARRAY**</b> The address of a variable that receives a pointer to a SAFEARRAY that contains the
///                      requested information. This parameter is passed uninitialized.
///    ppTreeStructure = Type: <b>BSTR*</b> The address of a variable that receives the description of the tree structure. This parameter
///                      is passed uninitialized. See Remarks.
///Returns:
///    Type: <b>HRESULT</b> Returns S_OK if successful or an error value otherwise.
///    
@DllImport("UIAutomationCore")
HRESULT UiaNodeFromFocus(UiaCacheRequest* pRequest, SAFEARRAY** ppRequestedData, BSTR* ppTreeStructure);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Retrieves the UI Automation node
///associated with a window.
///Params:
///    hwnd = Type: <b>HWND</b> The handle of the window.
///    phnode = Type: <b>HUIANODE*</b> The address of a variable that receives the handle of the node. This parameter is passed
///             uninitialized.
@DllImport("UIAutomationCore")
HRESULT UiaNodeFromHandle(HWND hwnd, HUIANODE__** phnode);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Retrieves the UI Automation node for a
///raw element provider.
///Params:
///    pProvider = Type: <b>IRawElementProviderSimple*</b> The address of the IRawElementProviderSimple interface of the provider.
///    phnode = Type: <b>HUIANODE*</b> The address of a variable that receives the UI Automation node for the raw element
///             provider. This parameter is passed uninitialized.
@DllImport("UIAutomationCore")
HRESULT UiaNodeFromProvider(IRawElementProviderSimple pProvider, HUIANODE__** phnode);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Retrieves the root UI Automation node.
///Params:
///    phnode = Type: <b>HUIANODE*</b> The address of a variable that receives a handle to the root node. This parameter is
///             passed uninitialized.
@DllImport("UIAutomationCore")
HRESULT UiaGetRootNode(HUIANODE__** phnode);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Registers the application-defined method
///that is called by UI Automation to obtain a provider for an element.
@DllImport("UIAutomationCore")
void UiaRegisterProviderCallback(UiaProviderCallback* pCallback);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Gets the integer identifier that can be
///used in methods that require a PROPERTYID, PATTERNID, CONTROLTYPEID, TEXTATTRIBUTEID, or EVENTID.
///Params:
///    type = Type: <b>AutomationIdentifierType</b> A value from the AutomationIdentifierType enumerated type that specifies
///           the type of identifier to look up.
///    pGuid = Type: <b>GUID*</b> The address of the unique identifier of the property, pattern, control type, text attribute,
///            or event.
///Returns:
///    Type: <b>int</b> Returns an integer identifier.
///    
@DllImport("UIAutomationCore")
int UiaLookupId(AutomationIdentifierType type, const(GUID)* pGuid);

///Retrieves a reserved value indicating that a Microsoft UI Automation property or a text attribute is not supported.
///Params:
///    punkNotSupportedValue = Type: <b>IUnknown**</b> Receives the object representing the value. This parameter is passed uninitialized.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("UIAutomationCore")
HRESULT UiaGetReservedNotSupportedValue(IUnknown* punkNotSupportedValue);

///Retrieves a reserved value indicating that the value of a Microsoft UI Automation text attribute varies within a text
///range.
///Params:
///    punkMixedAttributeValue = Type: <b>IUnknown**</b> Receives a reserved value specifying that an attribute varies over a text range. This
///                              parameter is passed uninitialized.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("UIAutomationCore")
HRESULT UiaGetReservedMixedAttributeValue(IUnknown* punkMixedAttributeValue);

///Gets a value that indicates whether any client application is subscribed to Microsoft UI Automation events.
@DllImport("UIAutomationCore")
BOOL UiaClientsAreListening();

///Called by providers to notify the Microsoft UI Automation core that an element property has changed.
///Params:
///    pProvider = Type: <b>IRawElementProviderSimple*</b> The provider node where the property change event occurred.
///    id = Type: <b>PROPERTYID</b> The identifier for the property that changed. For a list of property IDs, see Property
///         Identifiers.
///    oldValue = Type: <b>VARIANT</b> The old value of the property.
///    newValue = Type: <b>VARIANT</b> The new value of the property.
@DllImport("UIAutomationCore")
HRESULT UiaRaiseAutomationPropertyChangedEvent(IRawElementProviderSimple pProvider, int id, VARIANT oldValue, 
                                               VARIANT newValue);

///Notifies listeners of an event.
///Params:
///    pProvider = Type: <b>IRawElementProviderSimple*</b> The provider element where the event occurred.
///    id = Type: <b>EVENTID</b> The identifier of the event to be raised. For a list of event IDs, see Event Identifiers.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("UIAutomationCore")
HRESULT UiaRaiseAutomationEvent(IRawElementProviderSimple pProvider, int id);

///Called by a provider to notify the Microsoft UI Automation core that the tree structure has changed.
///Params:
///    pProvider = Type: <b>IRawElementProviderSimple*</b> The provider node where the tree change occurred.
///    structureChangeType = Type: <b>StructureChangeType</b> The type of change that occurred in the tree.
///    pRuntimeId = Type: <b>int*</b> The runtime IDs for the child elements of the provider node where the tree change occurred.
///                 This parameter is used only when <i>structureChangeType</i> is StructureChangeType_ChildRemoved; it is
///                 <b>NULL</b> for all other structure-change events. <div class="alert"><b>Note</b> For Windows 7, the array of
///                 integers pointed to by <i>pRuntimeId</i> can contain a partial set of IDs that identify only those elements
///                 affected by the structure change.</div>
///    cRuntimeIdLen = Type: <b>int</b> Length of the array of integers.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b>
///    error code.
///    
@DllImport("UIAutomationCore")
HRESULT UiaRaiseStructureChangedEvent(IRawElementProviderSimple pProvider, StructureChangeType structureChangeType, 
                                      int* pRuntimeId, int cRuntimeIdLen);

///Called by a provider to notify the Microsoft UI Automation core that content is being loaded asynchronously.
///Params:
///    pProvider = Type: <b>IRawElementProviderSimple*</b> The provider node where the content is being loaded.
///    asyncContentLoadedState = Type: <b>AsyncContentLoadedState</b> The current state of loading.
///    percentComplete = Type: <b>double</b> The percentage of content that has been loaded.
@DllImport("UIAutomationCore")
HRESULT UiaRaiseAsyncContentLoadedEvent(IRawElementProviderSimple pProvider, 
                                        AsyncContentLoadedState asyncContentLoadedState, double percentComplete);

///Called by a provider to notify the Microsoft UI Automation core that a text control has programmatically changed
///text.
///Params:
///    pProvider = Type: <b>IRawElementProviderSimple*</b> The provider node where the text change occurred.
///    textEditChangeType = Type: <b>TextEditChangeType</b> The type of text-edit change that occurred.
///    pChangedData = Type: <b>SAFEARRAY*</b> The event data. Should be assignable as a <b>VAR</b> of type <b>VT_BSTR</b>.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("UIAutomationCore")
HRESULT UiaRaiseTextEditTextChangedEvent(IRawElementProviderSimple pProvider, 
                                         TextEditChangeType textEditChangeType, SAFEARRAY* pChangedData);

///Called by providers to notify the Microsoft UI Automation core that a change has occurred.
///Params:
///    pProvider = Type: <b>IRawElementProviderSimple*</b> The provider node where the change event occurred.
///    eventIdCount = The number of changes that occurred. This is the number of UiaChangeInfo structures pointed to by the
///                   <i>pUiaChanges</i> parameter.
///    pUiaChanges = A collection of pointers to UiaChangeInfo structures.
@DllImport("UIAutomationCore")
HRESULT UiaRaiseChangesEvent(IRawElementProviderSimple pProvider, int eventIdCount, UiaChangeInfo* pUiaChanges);

///Called by providers to initiate a notification event.
///Params:
///    provider = The provider node where the notification event occurred.
///    notificationKind = The type of notification, as a [NotificationKind
///                       enumeration](../uiautomationcore/ne-uiautomationcore-notificationkind.md) value.
///    notificationProcessing = The preferred way to process a notification, as a [NotificationProcessing
///                             enumeration](../uiautomationcore/ne-uiautomationcore-notificationprocessing.md) value.
///    displayString = A string to display in the notification message.
///    activityId = A unique non-localized string to identify an action or group of actions. Use this to pass additional information
///                 to the event handler.
@DllImport("UIAutomationCore")
HRESULT UiaRaiseNotificationEvent(IRawElementProviderSimple provider, NotificationKind notificationKind, 
                                  NotificationProcessing notificationProcessing, BSTR displayString, BSTR activityId);

///Called by a provider to notify the Microsoft UI Automation core that the position within a text control has
///programmatically changed.
///Params:
///    provider = Type: <b>IRawElementProviderSimple*</b> The provider node where the position change within the text occurred.
///    textRange = Type: <b>ITextRangeProvider*</b> The text range change that occurred, if applicable.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("UIAutomationCore")
HRESULT UiaRaiseActiveTextPositionChangedEvent(IRawElementProviderSimple provider, ITextRangeProvider textRange);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Adds a listener for events on a node in
///the UI Automation tree.
///Params:
///    hnode = Type: <b>HUIANODE</b> The node to add an event listener to.
///    eventId = Type: <b>EVENTID</b> The identifier of the event to listen for. For a list of event IDs, see Event Identifiers.
///    pCallback = Type: <b>UiaEventCallback*</b> The address of the application-defined UiaEventCallback callback function that is
///                called when the event is raised.
///    scope = Type: <b>TreeScope*</b> A value from the TreeScope enumerated type indicating the scope of events to be handled;
///            that is, whether they are on the element itself, or on its ancestors and children.
///    pProperties = Type: <b>PROPERTYID*</b> The address of an array that contains the identifiers of the properties to monitor for
///                  change events, when <i>eventId</i> is the EVENTID derived from AutomationPropertyChanged_Event_GUID; otherwise
///                  this parameter is <b>NULL</b>. For a list of property IDs, see Property Identifiers.
///    cProperties = Type: <b>int</b> The count of elements in the <i>pProperties</i> array.
///    pRequest = Type: <b>UiaCacheRequest*</b> The address of a UiaCacheRequest structure that defines the cache request in effect
///               for nodes that are returned with events.
///    phEvent = Type: <b>HUIEVENT*</b> When this function returns, contains a pointer to the event that is added. This parameter
///              is passed uninitialized.
///Returns:
///    Type: <b>HRESULT</b> Returns S_OK if successful or an error value otherwise.
///    
@DllImport("UIAutomationCore")
HRESULT UiaAddEvent(HUIANODE__* hnode, int eventId, UiaEventCallback* pCallback, TreeScope scope_, 
                    int* pProperties, int cProperties, UiaCacheRequest* pRequest, HUIAEVENT__** phEvent);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Removes a listener for events on a node
///in the UI Automation tree.
///Params:
///    hEvent = Type: <b>HUIAEVENT</b> The event to remove. This value was retrieved from UiaAddEvent.
///Returns:
///    Type: <b>HRESULT</b> Returns S_OK if successful or an error value otherwise.
///    
@DllImport("UIAutomationCore")
HRESULT UiaRemoveEvent(HUIAEVENT__* hEvent);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Adds a window to the event listener.
///Params:
///    hEvent = Type: <b>HUIAEVENT</b> The event being listened for. This event was retrieved from UiaAddEvent.
///    hwnd = Type: <b>HWND</b> The handle of the window to add.
@DllImport("UIAutomationCore")
HRESULT UiaEventAddWindow(HUIAEVENT__* hEvent, HWND hwnd);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Removes a window from the event
///listener.
///Params:
///    hEvent = Type: <b>HUIAEVENT</b> The event being listened for. This event was retrieved from UiaAddEvent.
///    hwnd = Type: <b>HWND</b> The handle of the window to remove.
@DllImport("UIAutomationCore")
HRESULT UiaEventRemoveWindow(HUIAEVENT__* hEvent, HWND hwnd);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Docks the UI Automation element at the
///requested <i>dockPosition</i> within a docking container.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> The <i>control pattern</i> object.
///    dockPosition = Type: <b>DockPosition</b> The location to dock the control to.
@DllImport("UIAutomationCore")
HRESULT DockPattern_SetDockPosition(HUIAPATTERNOBJECT__* hobj, DockPosition dockPosition);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Hides all descendant nodes, controls, or
///content of the UI Automation element.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> The <i>control pattern</i> object.
@DllImport("UIAutomationCore")
HRESULT ExpandCollapsePattern_Collapse(HUIAPATTERNOBJECT__* hobj);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Expands a control on the screen so that
///it shows more information.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> The <i>control pattern</i> object.
@DllImport("UIAutomationCore")
HRESULT ExpandCollapsePattern_Expand(HUIAPATTERNOBJECT__* hobj);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Gets the node for an item in a grid.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> The <i>control pattern</i> object.
///    row = Type: <b>int</b> The row of the node being requested.
///    column = Type: <b>int</b> The column of the node being requested.
///    pResult = Type: <b>HUIANODE*</b> When this function returns, contains a pointer to the node for the cell at the specified
///              location. This parameter is passed uninitialized.
///Returns:
///    Type: <b>HRESULT</b> Returns S_OK if successful or an error value otherwise.
///    
@DllImport("UIAutomationCore")
HRESULT GridPattern_GetItem(HUIAPATTERNOBJECT__* hobj, int row, int column, HUIANODE__** pResult);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Sends a request to activate a control
///and initiate its single, unambiguous action.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> The <i>control pattern</i> object.
@DllImport("UIAutomationCore")
HRESULT InvokePattern_Invoke(HUIAPATTERNOBJECT__* hobj);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Retrieves the name of a control-specific
///view.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> The <i>control pattern</i> object.
///    viewId = Type: <b>int</b> The integer identifier for the view.
///    ppStr = Type: <b>BSTR*</b> When this function returns, contains a pointer to the string containing the name of the view.
///            This parameter is passed uninitialized.
@DllImport("UIAutomationCore")
HRESULT MultipleViewPattern_GetViewName(HUIAPATTERNOBJECT__* hobj, int viewId, BSTR* ppStr);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Sets a control to a different layout.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> The control pattern object.
///    viewId = Type: <b>int</b> The control-specific identifier for the view.
@DllImport("UIAutomationCore")
HRESULT MultipleViewPattern_SetCurrentView(HUIAPATTERNOBJECT__* hobj, int viewId);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Sets the value of a control that has a
///numerical range.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> The control pattern object.
///    val = Type: <b>double</b> The value to set.
@DllImport("UIAutomationCore")
HRESULT RangeValuePattern_SetValue(HUIAPATTERNOBJECT__* hobj, double val);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Scrolls the content area of a container
///object in order to display the UI Automation element within the visible region (viewport) of the container.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> The control pattern object.
///Returns:
///    Type: <b>HRESULT</b> Returns S_OK if successful or an error value otherwise.
///    
@DllImport("UIAutomationCore")
HRESULT ScrollItemPattern_ScrollIntoView(HUIAPATTERNOBJECT__* hobj);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Scrolls the currently visible region of
///the content area the specified ScrollAmount, horizontally, vertically, or both.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> The control pattern object.
///    horizontalAmount = Type: <b>ScrollAmount</b> The amount to scroll the container on the horizontal axis, as a percentage.
///    verticalAmount = Type: <b>ScrollAmount</b> The amount to scroll the container on the vertical axis, as a percentage.
@DllImport("UIAutomationCore")
HRESULT ScrollPattern_Scroll(HUIAPATTERNOBJECT__* hobj, ScrollAmount horizontalAmount, ScrollAmount verticalAmount);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Scrolls a container to a specific
///position horizontally, vertically, or both.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> The control pattern object.
///    horizontalPercent = Type: <b>double</b> The horizontal position to scroll to.
///    verticalPercent = Type: <b>double</b> The vertical position to scroll to.
///Returns:
///    Type: <b>HRESULT</b> Returns S_OK if successful or an error value otherwise.
///    
@DllImport("UIAutomationCore")
HRESULT ScrollPattern_SetScrollPercent(HUIAPATTERNOBJECT__* hobj, double horizontalPercent, double verticalPercent);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Adds an unselected element to a
///selection in a control.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> The control pattern object.
///Returns:
///    Type: <b>HRESULT</b> Returns S_OK if successful or an error value otherwise.
///    
@DllImport("UIAutomationCore")
HRESULT SelectionItemPattern_AddToSelection(HUIAPATTERNOBJECT__* hobj);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Removes an element from the selection in
///a selection container.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> The control pattern object.
///Returns:
///    Type: <b>HRESULT</b> Returns S_OK if successful or an error value otherwise.
///    
@DllImport("UIAutomationCore")
HRESULT SelectionItemPattern_RemoveFromSelection(HUIAPATTERNOBJECT__* hobj);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Selects an element in a selection
///container.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> The control pattern object.
///Returns:
///    Type: <b>HRESULT</b> Returns S_OK if successful or an error value otherwise.
///    
@DllImport("UIAutomationCore")
HRESULT SelectionItemPattern_Select(HUIAPATTERNOBJECT__* hobj);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Toggles a control to its next supported
///state.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> The control pattern object.
@DllImport("UIAutomationCore")
HRESULT TogglePattern_Toggle(HUIAPATTERNOBJECT__* hobj);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Moves an element to a specified location
///on the screen.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> The control pattern object.
///    x = Type: <b>double</b> The horizontal screen coordinate to move the element to.
///    y = Type: <b>double</b> The vertical screen coordinate to move the element to.
@DllImport("UIAutomationCore")
HRESULT TransformPattern_Move(HUIAPATTERNOBJECT__* hobj, double x, double y);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Resizes an element on the screen.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> The control pattern object.
///    width = Type: <b>double</b> The width, in pixels, to resize the element to.
///    height = Type: <b>double</b> The height, in pixels, to resize the element to.
@DllImport("UIAutomationCore")
HRESULT TransformPattern_Resize(HUIAPATTERNOBJECT__* hobj, double width, double height);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Rotates an element on the screen.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> The control pattern object.
///    degrees = Type: <b>double</b> The number of degrees to rotate the control. Positive values are clockwise; negative values
///              are counterclockwise.
@DllImport("UIAutomationCore")
HRESULT TransformPattern_Rotate(HUIAPATTERNOBJECT__* hobj, double degrees);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Sets the text value of an element.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> The control pattern object.
///    pVal = Type: <b>LPCTSTR</b> The string to set the element's content to.
@DllImport("UIAutomationCore")
HRESULT ValuePattern_SetValue(HUIAPATTERNOBJECT__* hobj, const(wchar)* pVal);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Closes an open window.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> The control pattern object.
@DllImport("UIAutomationCore")
HRESULT WindowPattern_Close(HUIAPATTERNOBJECT__* hobj);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Sets the visual state of a window; for
///example, to maximize a window.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> The control pattern object.
///    state = Type: <b>WindowVisualState</b> The visual state to set the window to.
@DllImport("UIAutomationCore")
HRESULT WindowPattern_SetWindowVisualState(HUIAPATTERNOBJECT__* hobj, WindowVisualState state);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Causes the calling code to block for the
///specified time or until the associated process enters an idle state, whichever completes first.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> The control pattern object.
///    milliseconds = Type: <b>int</b> The number of milliseconds to wait before retrieving <i>pResult</i>.
///    pResult = Type: <b>BOOL*</b> <b>TRUE</b> if the window is ready to accept user input; otherwise <b>FALSE</b>.
///Returns:
///    Type: <b>HRESULT</b> Returns S_OK if successful or an error value otherwise.
///    
@DllImport("UIAutomationCore")
HRESULT WindowPattern_WaitForInputIdle(HUIAPATTERNOBJECT__* hobj, int milliseconds, int* pResult);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Gets the current range of selected text
///from a text container supporting the text pattern.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> A control pattern object.
///    pRetVal = Type: <b>HUIATEXTRANGE*</b> When this function returns, contains the text range spanning the currently selected
///              text in the container. This parameter is passed uninitialized.
@DllImport("UIAutomationCore")
HRESULT TextPattern_GetSelection(HUIAPATTERNOBJECT__* hobj, SAFEARRAY** pRetVal);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Retrieves an array of disjoint text
///ranges from a text container where each text range begins with the first partially visible line through to the end of
///the last partially visible line. For example, a multi-column layout where the columns are partially scrolled out of
///the visible area of the viewport and the content flows from the bottom of one column to the top of the next.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> A control pattern object.
///    pRetVal = Type: <b>HUIATEXTRANGE*</b> When this function returns, contains an array of text ranges spanning the visible
///              text within the text container. This parameter is passed uninitialized.
@DllImport("UIAutomationCore")
HRESULT TextPattern_GetVisibleRanges(HUIAPATTERNOBJECT__* hobj, SAFEARRAY** pRetVal);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Gets the text range that a given node
///spans.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> A control pattern object.
///    hnodeChild = Type: <b>HUIANODE</b> Reference to a node that the client wants the text range for.
///    pRetVal = Type: <b>HUIATEXTRANGE*</b> When this function returns, contains the text range that the node spans. This
///              parameter is passed uninitialized.
///Returns:
///    Type: <b>HRESULT</b> Returns S_OK if successful or an error value otherwise.
///    
@DllImport("UIAutomationCore")
HRESULT TextPattern_RangeFromChild(HUIAPATTERNOBJECT__* hobj, HUIANODE__* hnodeChild, HUIATEXTRANGE__** pRetVal);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Retrieves the degenerate (empty) text
///range nearest to the specified screen coordinates.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> A control pattern object.
///    point = Type: <b>HiaPoint</b> A UiaPoint structure that contains the location in screen coordinates.
///    pRetVal = Type: <b>HUIATEXTRANGE*</b> When this function returns, contains the text range that the node spans. This
///              parameter is passed uninitialized.
///Returns:
///    Type: <b>HRESULT</b> Returns S_OK if successful or an error value otherwise.
///    
@DllImport("UIAutomationCore")
HRESULT TextPattern_RangeFromPoint(HUIAPATTERNOBJECT__* hobj, UiaPoint point, HUIATEXTRANGE__** pRetVal);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Gets the text range for the entire
///document.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> A control pattern object.
///    pRetVal = Type: <b>HUIATEXTRANGE*</b> When this function returns, contains the text range spanning the entire document
///              contents of the text container. This parameter is passed uninitialized.
@DllImport("UIAutomationCore")
HRESULT TextPattern_get_DocumentRange(HUIAPATTERNOBJECT__* hobj, HUIATEXTRANGE__** pRetVal);

///> [!Important] > This function is deprecated. Client applications should use the Microsoft UI Automation Component
///Object Model (COM) interfaces instead. Ascertains whether the text container's contents can be selected and
///deselected.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> A control pattern object.
///    pRetVal = Type: <b>BOOL*</b> When this function returns, contains a value indicating whether the text container can have
///              its contents selected and deselected. This parameter is passed uninitialized.
@DllImport("UIAutomationCore")
HRESULT TextPattern_get_SupportedTextSelection(HUIAPATTERNOBJECT__* hobj, SupportedTextSelection* pRetVal);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Copies a text range.
///Params:
///    hobj = Type: <b>HUIATEXTRANGE</b> A text range object.
///    pRetVal = Type: <b>HUIATEXTRANGE*</b> When this function returns, contains the copy. This parameter is passed
///              uninitialized.
///Returns:
///    Type: <b>HRESULT</b> Returns S_OK if successful or an error value otherwise.
///    
@DllImport("UIAutomationCore")
HRESULT TextRange_Clone(HUIATEXTRANGE__* hobj, HUIATEXTRANGE__** pRetVal);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Compares two text ranges.
///Params:
///    hobj = Type: <b>HUIATEXTRANGE</b> The first text range to compare.
///    range = Type: <b>HUIATEXTRANGE</b> The second text range to compare.
///    pRetVal = Type: <b>BOOL*</b> When this function returns, contains <b>TRUE</b> if the two objects span the same text;
///              otherwise <b>FALSE</b>. This parameter is passed uninitialized.
@DllImport("UIAutomationCore")
HRESULT TextRange_Compare(HUIATEXTRANGE__* hobj, HUIATEXTRANGE__* range, int* pRetVal);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Returns a value indicating whether two
///text ranges have identical endpoints.
///Params:
///    hobj = Type: <b>HUIATEXTRANGE</b> A text range object.
///    endpoint = Type: <b>TextPatternRangeEndpoint</b> The starting or ending endpoint of <i>hobj</i>.
///    targetRange = Type: <b>ITextRangeInteropProvider*</b> The text range that is being compared against.
///    targetEndpoint = Type: <b>TextPatternRangeEndpoint</b> The starting or ending endpoint of <i>targetRange</i>.
///    pRetVal = Type: <b>int*</b> The address of a variable that receives a pointer to a value that indicates whether two text
///              ranges have identical endpoints. This parameter is passed uninitialized.
///Returns:
///    Type: <b>HRESULT</b> Returns S_OK if successful or an error value otherwise.
///    
@DllImport("UIAutomationCore")
HRESULT TextRange_CompareEndpoints(HUIATEXTRANGE__* hobj, TextPatternRangeEndpoint endpoint, 
                                   HUIATEXTRANGE__* targetRange, TextPatternRangeEndpoint targetEndpoint, 
                                   int* pRetVal);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Expands the text range to a larger or
///smaller unit such as Character, Word, Line, or Page.
///Params:
///    hobj = Type: <b>HUIATEXTRANGE</b> A text range object.
///    unit = Type: <b>TextUnit</b> The unit that the provider must expand the text range to.
///Returns:
///    Type: <b>HRESULT</b> Returns S_OK if successful or an error value otherwise.
///    
@DllImport("UIAutomationCore")
HRESULT TextRange_ExpandToEnclosingUnit(HUIATEXTRANGE__* hobj, TextUnit unit);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Gets the value of an text attribute for
///a text range.
///Params:
///    hobj = Type: <b>HUIATEXTRANGE</b> A text range object.
///    attributeId = Type: <b>TEXTATTRIBUTEID</b> The text attribute whose value is wanted. For a list of text attribute IDs, see Text
///                  Attribute Identifiers.
///    pRetVal = Type: <b>VARIANT*</b> When this function returns, contains the value of the attribute for the text range. This
///              parameter is passed uninitialized.
@DllImport("UIAutomationCore")
HRESULT TextRange_GetAttributeValue(HUIATEXTRANGE__* hobj, int attributeId, VARIANT* pRetVal);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Searches in a specified direction for
///the first piece of text supporting a specified text attribute.
///Params:
///    hobj = Type: <b>HUIATEXTRANGE</b> The text range to search.
///    attributeId = Type: <b>TEXTATTRIBUTEID</b> The text attribute to search for. For a list of text attribute IDs, see Text
///                  Attribute Identifiers.
///    val = Type: <b>VARIANT</b> The value of the attribute that the client wants to find.
///    backward = Type: <b>BOOL</b> <b>TRUE</b> to search backward, otherwise <b>FALSE</b>.
///    pRetVal = Type: <b>HUITEXTRANGE*</b> When this function returns, contains the first matching text range. This parameter is
///              passed uninitialized.
@DllImport("UIAutomationCore")
HRESULT TextRange_FindAttribute(HUIATEXTRANGE__* hobj, int attributeId, VARIANT val, BOOL backward, 
                                HUIATEXTRANGE__** pRetVal);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Returns the first text range in the
///specified direction that contains the text the client is searching for.
///Params:
///    hobj = Type: <b>HUIATEXTRANGE</b> The text range to search.
///    text = Type: <b>BSTR</b> The string to search for.
///    backward = Type: <b>BOOL</b> <b>TRUE</b> to search backward; otherwise <b>FALSE</b>.
///    ignoreCase = Type: <b>BOOL</b> <b>TRUE</b> to specify a case-insensitive search; otherwise <b>FALSE</b>.
///    pRetVal = Type: <b>HUITEXTRANGE*</b> When this function returns, contains the text range for the first span of text that
///              matches the string the client is searching for. This parameter is passed uninitialized.
@DllImport("UIAutomationCore")
HRESULT TextRange_FindText(HUIATEXTRANGE__* hobj, BSTR text, BOOL backward, BOOL ignoreCase, 
                           HUIATEXTRANGE__** pRetVal);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Retrieves the minimum number of bounding
///rectangles that can enclose the range, one rectangle per line.
///Params:
///    hobj = Type: <b>HUIATEXTRANGE</b> A text range object.
///    pRetVal = Type: <b>SAFEARRAY**</b> When this function returns, contains an array of rectangle coordinates for the lines of
///              text that the range spans. This parameter is passed uninitialized. The SAFEARRAY contains VARIANTs of type VT_I4.
@DllImport("UIAutomationCore")
HRESULT TextRange_GetBoundingRectangles(HUIATEXTRANGE__* hobj, SAFEARRAY** pRetVal);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Returns the node for the next smallest
///provider that covers the range.
///Params:
///    hobj = Type: <b>HUIATEXTRANGE</b> A text range object.
///    pRetVal = Type: <b>HUIANODE*</b> When this function returns, contains the node for the next smallest element that encloses
///              the range. This parameter is passed uninitialized.
///Returns:
///    Type: <b>HRESULT</b> Returns S_OK if successful or an error value otherwise.
///    
@DllImport("UIAutomationCore")
HRESULT TextRange_GetEnclosingElement(HUIATEXTRANGE__* hobj, HUIANODE__** pRetVal);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Returns the text in a text range, up to
///a specified number of characters.
///Params:
///    hobj = Type: <b>HUIATEXTRANGE</b> A text range object.
///    maxLength = Type: <b>int</b> The number of characters to return, beginning with the character at the starting endpoint of the
///                text range.
///    pRetVal = Type: <b>BSTR*</b> When this function returns, this parameter contains a pointer to the returned text. This
///              parameter is passed uninitialized.
///Returns:
///    Type: <b>HRESULT</b> Returns S_OK if successful or an error value otherwise.
///    
@DllImport("UIAutomationCore")
HRESULT TextRange_GetText(HUIATEXTRANGE__* hobj, int maxLength, BSTR* pRetVal);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Moves the text range the specified
///number of units requested by the client.
///Params:
///    hobj = Type: <b>HUIATEXTRANGE</b> A text range object.
///    unit = Type: <b>TextUnit</b> The unit, such as Page, Line, or Word.
///    count = Type: <b>int</b> The number of units to move. Positive numbers move the range forward, and negative numbers move
///            the range backward.
///    pRetVal = Type: <b>int*</b> When this function returns, contains the number of units actually moved. This parameter is
///              passed uninitialized.
@DllImport("UIAutomationCore")
HRESULT TextRange_Move(HUIATEXTRANGE__* hobj, TextUnit unit, int count, int* pRetVal);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Moves an endpoint of the range the
///specified number of units.
///Params:
///    hobj = Type: <b>HUIATEXTRANGE</b> A text range object.
///    endpoint = Type: <b>TextPatternRangeEndpoint</b> The endpoint to move (either the start or the end).
///    unit = Type: <b>TextUnit</b> The unit, such as Page, Line, or Word.
///    count = Type: <b>int</b> The number of units to move. A positive value moves the range forward; a negative value moves it
///            backward.
///    pRetVal = Type: <b>int*</b> When this function returns, contains the number of units the endpoint actually moved. This
///              parameter is passed uninitialized.
@DllImport("UIAutomationCore")
HRESULT TextRange_MoveEndpointByUnit(HUIATEXTRANGE__* hobj, TextPatternRangeEndpoint endpoint, TextUnit unit, 
                                     int count, int* pRetVal);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Moves an endpoint of one range to the
///endpoint of another range.
///Params:
///    hobj = Type: <b>HUIATEXTRANGE</b> The text range object whose endpoint is to move.
///    endpoint = Type: <b>TextPatternRangeEndpoint</b> The endpoint to move (either the start or the end).
///    targetRange = Type: <b>HUIATEXTRANGE</b> The text range that contains the target endpoint.
///    targetEndpoint = Type: <b>TextPatternRangeEndpoint</b> The target endpoint to move to (either the start or the end).
@DllImport("UIAutomationCore")
HRESULT TextRange_MoveEndpointByRange(HUIATEXTRANGE__* hobj, TextPatternRangeEndpoint endpoint, 
                                      HUIATEXTRANGE__* targetRange, TextPatternRangeEndpoint targetEndpoint);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Selects a text range.
///Params:
///    hobj = Type: <b>HUIATEXTRANGE</b> A text range object.
@DllImport("UIAutomationCore")
HRESULT TextRange_Select(HUIATEXTRANGE__* hobj);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Adds to the existing collection of
///highlighted text in a text container that supports multiple, disjoint selections by highlighting supplementary text
///corresponding to the calling text range <i>Start</i> and <i>End</i> endpoints.
///Params:
///    hobj = Type: <b>HUIATEXTRANGE</b> A text range object.
@DllImport("UIAutomationCore")
HRESULT TextRange_AddToSelection(HUIATEXTRANGE__* hobj);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Removes the selected text, corresponding
///to the calling text range <i>TextPatternRangeEndpoint_Start</i> and <i>TextPatternRangeEndpoint_End</i> endpoints,
///from an existing collection of selected text in a text container that supports multiple, disjoint selections.
///Params:
///    hobj = Type: <b>HUIATEXTRANGE</b> A text range object.
///Returns:
///    Type: <b>HRESULT</b> Returns S_OK if successful or an error value otherwise.
///    
@DllImport("UIAutomationCore")
HRESULT TextRange_RemoveFromSelection(HUIATEXTRANGE__* hobj);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Scrolls the text so the specified range
///is visible in the viewport.
///Params:
///    hobj = Type: <b>HUIATEXTRANGE</b> The text range to scroll.
///    alignToTop = Type: <b>BOOL</b> TRUE to align the top of the text range with the top of the viewport; FALSE to align the bottom
///                 of the text range with the bottom of the viewport.
@DllImport("UIAutomationCore")
HRESULT TextRange_ScrollIntoView(HUIATEXTRANGE__* hobj, BOOL alignToTop);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Returns all UI Automation elements
///contained within the specified text range.
///Params:
///    hobj = Type: <b>HUIATEXTRANGE</b> A text range object.
///    pRetVal = Type: <b>SAFEARRAY**</b> When this function returns, contains an array of nodes that are children of the text
///              range in the UI Automation tree. This parameter is passed uninitialized.
@DllImport("UIAutomationCore")
HRESULT TextRange_GetChildren(HUIATEXTRANGE__* hobj, SAFEARRAY** pRetVal);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Retrieves a node within a containing
///node, based on a specified property value.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> The <i>control pattern</i> object.
///    hnodeStartAfter = Type: <b>HUIANODE</b> The node after which to start the search.
///    propertyId = Type: <b>PROPERTYID</b> The property identifier. For a list of property IDs, see Property Identifiers.
///    value = Type: <b>VARIANT</b> The value of the <i>propertyId</i> property.
///    pFound = Type: <b>HUIANODE*</b> The node of the matching element.
@DllImport("UIAutomationCore")
HRESULT ItemContainerPattern_FindItemByProperty(HUIAPATTERNOBJECT__* hobj, HUIANODE__* hnodeStartAfter, 
                                                int propertyId, VARIANT value, HUIANODE__** pFound);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Performs a Microsoft Active
///Accessibility selection.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> The <i>control pattern</i> object.
///    flagsSelect = Type: <b>long</b> Specifies which selection or focus operations are to be performed. This parameter must have a
///                  combination of the values described in SELFLAG Constants.
@DllImport("UIAutomationCore")
HRESULT LegacyIAccessiblePattern_Select(HUIAPATTERNOBJECT__* hobj, int flagsSelect);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Performs the Microsoft Active
///Accessibility default action for the element.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> The <i>control pattern</i> object.
@DllImport("UIAutomationCore")
HRESULT LegacyIAccessiblePattern_DoDefaultAction(HUIAPATTERNOBJECT__* hobj);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Sets the Microsoft Active Accessibility
///value property for the node.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> The <i>control pattern</i> object.
///    szValue = Type: <b>LPCWSTR</b> A localized string that contains the value.
@DllImport("UIAutomationCore")
HRESULT LegacyIAccessiblePattern_SetValue(HUIAPATTERNOBJECT__* hobj, const(wchar)* szValue);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Retrieves an IAccessible object that
///corresponds to the UI Automation element.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> A control pattern object.
///    pAccessible = Type: <b>IAccessible**</b> The address of a variable that receives a pointer to an IAccessible interface for the
///                  accessible object.
@DllImport("UIAutomationCore")
HRESULT LegacyIAccessiblePattern_GetIAccessible(HUIAPATTERNOBJECT__* hobj, IAccessible* pAccessible);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Causes the UI Automation provider to
///start listening for mouse or keyboard input.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> The <i>control pattern</i> object.
///    inputType = Type: <b>SynchronizedInputType</b> A combination of values from the SynchronizedInputType enumerated type
///                specifying the type of input for which to listen.
@DllImport("UIAutomationCore")
HRESULT SynchronizedInputPattern_StartListening(HUIAPATTERNOBJECT__* hobj, SynchronizedInputType inputType);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Causes the UI Automation provider to
///stop listening for mouse or keyboard input.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> The <i>control pattern</i> object.
@DllImport("UIAutomationCore")
HRESULT SynchronizedInputPattern_Cancel(HUIAPATTERNOBJECT__* hobj);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Makes the virtual item fully accessible
///as a UI Automation element.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> The <i>control pattern</i> object.
@DllImport("UIAutomationCore")
HRESULT VirtualizedItemPattern_Realize(HUIAPATTERNOBJECT__* hobj);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Deletes an allocated pattern object from
///memory.
///Params:
///    hobj = Type: <b>HUIAPATTERNOBJECT</b> The pattern object to be deleted.
@DllImport("UIAutomationCore")
BOOL UiaPatternRelease(HUIAPATTERNOBJECT__* hobj);

///<div class="alert"><b>Note</b> This function is deprecated. Client applications should use the Microsoft UI
///Automation Component Object Model (COM) interfaces instead.</div><div> </div>Deletes an allocated text range object
///from memory.
///Params:
///    hobj = Type: <b>HUIATEXTRANGE</b> The text range object to be deleted.
@DllImport("UIAutomationCore")
BOOL UiaTextRangeRelease(HUIATEXTRANGE__* hobj);

///Gets an interface to the UI Automation provider for a window.
///Params:
///    hwnd = Type: <b>HWND</b> The handle of the window containing the element served by the provider.
///    wParam = Type: <b>WPARAM</b> The <i>wParam</i> argument of the WM_GETOBJECT message.
///    lParam = Type: <b>LPARAM</b> The <i>lParam</i> argument of the WM_GETOBJECT message.
///    el = Type: <b>IRawElementProviderSimple*</b> The UI Automation provider.
///Returns:
///    Type: <b>LRESULT</b> The key for the client process to connect to the server process through UI Automation. This
///    function returns zero when it is used to notify UI Automation that it is safe to remove the provider raised-event
///    map. For more information, see Remarks.
///    
@DllImport("UIAutomationCore")
LRESULT UiaReturnRawElementProvider(HWND hwnd, WPARAM wParam, LPARAM lParam, IRawElementProviderSimple el);

///Gets the host provider for a window.
///Params:
///    hwnd = Type: <b>HWND</b> The window containing the element served by the provider.
///    ppProvider = Type: <b>IRawElementProviderSimple**</b> The host provider for the window.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("UIAutomationCore")
HRESULT UiaHostProviderFromHwnd(HWND hwnd, IRawElementProviderSimple* ppProvider);

///Gets the provider for the entire non-client area of a window, or for a control in the non-client area of a window.
///Params:
///    hwnd = Type: <b>HWND</b> The window that owns the non-client area or non-client control.
///    idObject = Type: <b>long</b> The object identifier of the non-client control, or OBJID_WINDOW for the entire non-client
///               area. For a list of possible values, see <b>Object Identifiers</b>.
///    idChild = Type: <b>long</b> The child identifier of the non-client control.
///    ppProvider = Type: <b>IRawElementProviderSimple**</b> Receives the provider for the non-client area or non-client control.
///Returns:
///    Type: <b>HRESULT</b> Returns S_OK if successful or an error value otherwise.
///    
@DllImport("UIAutomationCore")
HRESULT UiaProviderForNonClient(HWND hwnd, int idObject, int idChild, IRawElementProviderSimple* ppProvider);

///Retrieves an IAccessible implementation that provides Microsoft Active Accessibility data on behalf of a Microsoft UI
///Automation provider.
///Params:
///    pProvider = Type: <b>IRawElementProviderSimple*</b> A pointer to the UI Automation object.
///    dwFlags = Type: <b>DWORD</b> One of the following values: <a id="UIA_IAFP_DEFAULT"></a> <a id="uia_iafp_default"></a>
///    ppAccessible = Type: <b>IAccessible**</b> Receives the pointer to the IAccessible implementation for the provider.
///    pvarChild = Type: <b>VARIANT*</b> Receives the child identifier of the accessible element in the <b>lVal</b> member.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("UIAutomationCore")
HRESULT UiaIAccessibleFromProvider(IRawElementProviderSimple pProvider, uint dwFlags, IAccessible* ppAccessible, 
                                   VARIANT* pvarChild);

///Creates a Microsoft UI Automation provider based on the specified Microsoft Active Accessibility object.
///Params:
///    pAccessible = Type: <b>IAccessible*</b> A pointer to the Microsoft Active Accessibility object.
///    idChild = Type: <b>long</b> The child ID of the Microsoft Active Accessibility object.
///    dwFlags = Type: <b>DWORD</b> One of the following values: <a id="UIA_PFIA_DEFAULT"></a> <a id="uia_pfia_default"></a>
///    ppProvider = Type: <b>IRawElementProviderSimple**</b> The new UI Automation provider.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("UIAutomationCore")
HRESULT UiaProviderFromIAccessible(IAccessible pAccessible, int idChild, uint dwFlags, 
                                   IRawElementProviderSimple* ppProvider);

///Releases all Microsoft UI Automation resources that are held by all providers associated with the calling process.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("UIAutomationCore")
HRESULT UiaDisconnectAllProviders();

///Releases all references that a particular provider holds to Microsoft UI Automation objects.
///Params:
///    pProvider = Type: <b>IRawElementProviderSimple*</b> The provider to be disconnected.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("UIAutomationCore")
HRESULT UiaDisconnectProvider(IRawElementProviderSimple pProvider);

///Ascertains whether a window has a Microsoft UI Automation provider implementation.
///Params:
///    hwnd = Type: <b>HWND</b> Handle of the window.
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

///<p class="CCE_Message">[Active Accessibility Text Services is deprecated. Please see Microsoft Windows Text Services
///Frameworkfor more information on advanced text input and natural language technologies. ] Exposes methods for string
///manipulation.
@GUID("1DC4CB5F-D737-474D-ADE9-5CCFC9BC1CC9")
interface IAccDictionary : IUnknown
{
    ///Clients call the <b>IAccDictionary::GetLocalizedString</b> method to get localized strings for all system
    ///properties and their values. <div class="alert"><b>Note</b> Active Accessibility Text Services is deprecated.
    ///Please see Microsoft Windows Text Services Frameworkfor more information on advanced text input and natural
    ///language technologies. </div><div> </div>
    ///Params:
    ///    Term = Type: <b>REFGUID</b> A globally unique identifier (GUID) that represents a property.
    ///    lcid = Type: <b>LCID</b> The locale of the string to be returned.
    ///    pResult = Type: <b>BSTR*</b> A localized string that represents the term.
    ///    plcid = Type: <b>LCID*</b> The language of the returned string.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK.
    ///    
    HRESULT GetLocalizedString(const(GUID)* Term, uint lcid, BSTR* pResult, uint* plcid);
    ///Clients call the <b>IAccDictionary::GetParentTerm</b> method to navigate through the object hierarchy tree. This
    ///method returns the parent object of a specified property. <div class="alert"><b>Note</b> Active Accessibility
    ///Text Services is deprecated. Please see Microsoft Windows Text Services Frameworkfor more information on advanced
    ///text input and natural language technologies. </div><div> </div>
    ///Params:
    ///    Term = Type: <b>REFGUID</b> A GUID for a property.
    ///    pParentTerm = Type: <b>GUID*</b> The parent of the property specified in the <i>Term</i> parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK.
    ///    
    HRESULT GetParentTerm(const(GUID)* Term, GUID* pParentTerm);
    ///Retrieves a mnemonic string. <div class="alert"><b>Note</b> Active Accessibility Text Services is deprecated.
    ///Please see Microsoft Windows Text Services Frameworkfor more information on advanced text input and natural
    ///language technologies. </div><div> </div>
    ///Params:
    ///    Term = Type: <b>REFGUID</b> A GUID representing a property.
    ///    pResult = Type: <b>BSTR*</b> A mnemonic string for the property. This string is not localized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK.
    ///    
    HRESULT GetMnemonicString(const(GUID)* Term, BSTR* pResult);
    ///Clients call the <b>IAccDictionary::LookupMnemonicTerm</b> method to find the property for a given mnemonic
    ///string. <div class="alert"><b>Note</b> Active Accessibility Text Services is deprecated. Please see Microsoft
    ///Windows Text Services Frameworkfor more information on advanced text input and natural language technologies.
    ///</div><div> </div>
    ///Params:
    ///    bstrMnemonic = Type: <b>BSTR</b> A non-localized mnemonic string for a property.
    ///    pTerm = Type: <b>GUID*</b> A GUID representing the property in <i>bstrMnemonic</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK.
    ///    
    HRESULT LookupMnemonicTerm(BSTR bstrMnemonic, GUID* pTerm);
    ///Clients call the <b>IAccDictionary::ConvertValueToString</b> method to convert a value to a localized string.
    ///<div class="alert"><b>Note</b> Active Accessibility Text Services is deprecated. Please see Microsoft Windows
    ///Text Services Frameworkfor more information on advanced text input and natural language technologies. </div><div>
    ///</div>
    ///Params:
    ///    Term = Type: <b>REFGUID</b> A GUID that represents a property.
    ///    lcid = Type: <b>LCID</b> The locale of the string to be returned.
    ///    varValue = Type: <b>VARIANT</b> The value of the item.
    ///    pbstrResult = Type: <b>BSTR*</b> A pointer to the converted value.
    ///    plcid = Type: <b>LCID*</b> A pointer to the language of the returned string.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK.
    ///    
    HRESULT ConvertValueToString(const(GUID)* Term, uint lcid, VARIANT varValue, BSTR* pbstrResult, uint* plcid);
}

///<p class="CCE_Message">[Active Accessibility Text Services is deprecated. Please see Microsoft Windows Text Services
///Frameworkfor more information on advanced text input and natural language technologies. ] Exposes methods that supply
///version information for accessible elements.
@GUID("401518EC-DB00-4611-9B29-2A0E4B9AFA85")
interface IVersionInfo : IUnknown
{
    ///Clients call <b>IVersionInfo::GetSubcomponentCount</b> to determine the number of subcomponents for which version
    ///information is returned. <div class="alert"><b>Note</b> Active Accessibility Text Services is deprecated. Please
    ///see Microsoft Windows Text Services Frameworkfor more information on advanced text input and natural language
    ///technologies. </div><div> </div>
    ///Params:
    ///    ulSub = Type: <b>ULONG</b> The ordinal position of the component in the tree.
    ///    ulCount = Type: <b>ULONG*</b> The number of subcomponents that this component will expose version information about.
    HRESULT GetSubcomponentCount(uint ulSub, uint* ulCount);
    ///Clients call <b>IVersionInfo::GetImplementationID</b> to retrieve a unique identifier for the component. <div
    ///class="alert"><b>Note</b> Active Accessibility Text Services is deprecated. Please see Microsoft Windows Text
    ///Services Frameworkfor more information on advanced text input and natural language technologies. </div><div>
    ///</div>
    ///Params:
    ///    ulSub = Type: <b>ULONG</b> The ordinal position of the component in the tree.
    ///    implid = Type: <b>GUID*</b> An implementation identifier for the component. The implementation identifier is unique
    ///             for this component and is used only for comparing components.
    HRESULT GetImplementationID(uint ulSub, GUID* implid);
    ///Clients call <b>IVersionInfo::GetBuildVersion</b> to retrieve build information for a specified component. <div
    ///class="alert"><b>Note</b> Active Accessibility Text Services is deprecated. Please see Microsoft Windows Text
    ///Services Frameworkfor more information on advanced text input and natural language technologies. </div><div>
    ///</div>
    ///Params:
    ///    ulSub = Type: <b>ULONG</b> The ordinal position of the component in the tree.
    ///    pdwMajor = Type: <b>DWORD*</b> The major build version of the component specified in <i>ulSub</i>.
    ///    pdwMinor = Type: <b>DWORD*</b> The minor build version of the component specified in <i>ulSub</i>.
    HRESULT GetBuildVersion(uint ulSub, uint* pdwMajor, uint* pdwMinor);
    ///Clients call this method to retrieve a description of the component. <div class="alert"><b>Note</b> Active
    ///Accessibility Text Services is deprecated. Please see Microsoft Windows Text Services Frameworkfor more
    ///information on advanced text input and natural language technologies. </div><div> </div>
    ///Params:
    ///    ulSub = Type: <b>ULONG</b> The ordinal position of the component in the tree.
    ///    pImplStr = Type: <b>BSTR*</b> String of the form of "Company, suite, component, version." This is for human consumption
    ///               and is not expected to be parsed.
    HRESULT GetComponentDescription(uint ulSub, BSTR* pImplStr);
    ///Clients call this method to retrieve a description of the instance. <div class="alert"><b>Note</b> Active
    ///Accessibility Text Services is deprecated. Please see Microsoft Windows Text Services Frameworkfor more
    ///information on advanced text input and natural language technologies. </div><div> </div>
    ///Params:
    ///    ulSub = Type: <b>ULONG</b> The ordinal position of the component in the tree.
    ///    pImplStr = Type: <b>BSTR*</b> Additional useful strings for the component, such as the internal object state.
    HRESULT GetInstanceDescription(uint ulSub, BSTR* pImplStr);
}

///<p class="CCE_Message">[Active Accessibility Text Services is deprecated. Please see Microsoft Windows Text Services
///Frameworkfor more information on advanced text input and natural language technologies. ] Exposes a method that
///enables a client application to create a helper object in the server context.
@GUID("03DE00AA-F272-41E3-99CB-03C5E8114EA0")
interface ICoCreateLocally : IUnknown
{
    ///Clients call <b>ICoCreateLocally::CoCreateLocally</b> to create a helper object in the same context as the server
    ///object. This allows clients to increase performance because they are running in the server application.<div
    ///class="alert"><b>Note</b> Active Accessibility Text Services is deprecated. Please see Microsoft Windows Text
    ///Services Frameworkfor more information on advanced text input and natural language technologies. </div> <div>
    ///</div>
    ///Params:
    ///    rclsid = Type: <b>REFCLSID</b> Class identifier of the object to be created locally.
    ///    dwClsContext = Type: <b>DWORD</b> Context in which the helper object should run. This is usually CLSCTX_INPROC_SERVER.
    ///    riid = Type: <b>REFIID</b> The desired interface identifier (IID).
    ///    punk = Type: <b>IUnknown*</b> Interface pointer to the desired interface identifier (from <i>riid</i>).
    ///    riidParam = Type: <b>REFIID</b> An optional interface parameter that is passed to the new helper object. This parameter
    ///                specifies an interface identifier.
    ///    punkParam = Type: <b>IUnknown*</b> An optional interface parameter that is passed to the new helper object. This
    ///                parameter specifies the interface pointer.
    ///    varParam = Type: <b>VARIANT</b> An optional interface parameter that is passed to the new helper object.
    HRESULT CoCreateLocally(const(GUID)* rclsid, uint dwClsContext, const(GUID)* riid, IUnknown* punk, 
                            const(GUID)* riidParam, IUnknown punkParam, VARIANT varParam);
}

///<p class="CCE_Message">[Active Accessibility Text Services is deprecated. Please see Microsoft Windows Text Services
///Frameworkfor more information on advanced text input and natural language technologies. ] Exposes a method to return
///information about a local object.
@GUID("0A53EB6C-1908-4742-8CFF-2CEE2E93F94C")
interface ICoCreatedLocally : IUnknown
{
    ///Implemented by clients to return information about the local object.<div class="alert"><b>Note</b> Active
    ///Accessibility Text Services is deprecated. Please see Microsoft Windows Text Services Frameworkfor more
    ///information on advanced text input and natural language technologies. </div> <div> </div>
    ///Params:
    ///    punkLocalObject = Type: <b>IUnknown*</b> A pointer to the server object.
    ///    riidParam = Type: <b>REFIID</b> An optional interface parameter that is passed to the new helper object. This parameter
    ///                specifies an interface identifier.
    ///    punkParam = Type: <b>IUnknown*</b> An optional interface parameter that is passed to the new helper object. This
    ///                parameter specifies the interface pointer.
    ///    varParam = Type: <b>VARIANT</b> An optional interface parameter that is passed to the new helper object.
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

///<p class="CCE_Message">[Active Accessibility Text Services is deprecated. Please see Microsoft Windows Text Services
///Frameworkfor more information on advanced text input and natural language technologies. ] Exposes methods that make
///documents accessible to client applications.
@GUID("AD7C73CF-6DD5-4855-ABC2-B04BAD5B9153")
interface IAccServerDocMgr : IUnknown
{
    ///Server applications call the <b>IAccServerDocMgr::NewDocument</b> method when it is available. The adapter
    ///creates a wrapped document and registers it with the store, so clients can access information about the text in
    ///the document. <div class="alert"><b>Note</b> Active Accessibility Text Services is deprecated. Please see
    ///Microsoft Windows Text Services Frameworkfor more information on advanced text input and natural language
    ///technologies. </div><div> </div>
    ///Params:
    ///    riid = Type: <b>REFIID</b> IID of the document. This is usually IID_ITextStoreAnchor.
    ///    punk = Type: <b>IUnknown*</b> [in, iid_is(riid)] An interface pointer to the document.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK.
    ///    
    HRESULT NewDocument(const(GUID)* riid, IUnknown punk);
    ///Server applications call the <b>IAccServerDocMgr::RevokeDocument</b> method to notify the Microsoft Active
    ///Accessibility run time that a document is no longer available. Calling <b>RevokeDocument</b> removes it from the
    ///store so that clients cannot see the document. <div class="alert"><b>Note</b> Active Accessibility Text Services
    ///is deprecated. Please see Microsoft Windows Text Services Frameworkfor more information on advanced text input
    ///and natural language technologies. </div><div> </div>
    ///Params:
    ///    punk = Type: <b>IUnknown*</b> An interface pointer to the document being revoked.
    HRESULT RevokeDocument(IUnknown punk);
    ///Applications that use Text Services Framework call <b>IAccServerDocMgr::OnDocumentFocus</b> to notify the
    ///Microsoft Active Accessibility run time when a document gets or loses focus. The store keeps this information so
    ///that clients can access the document that has focus. <div class="alert"><b>Note</b> Active Accessibility Text
    ///Services is deprecated. Please see Microsoft Windows Text Services Frameworkfor more information on advanced text
    ///input and natural language technologies. </div><div> </div>
    ///Params:
    ///    punk = Type: <b>IUnknown*</b> An interface pointer to the document getting focus.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK.
    ///    
    HRESULT OnDocumentFocus(IUnknown punk);
}

///<p class="CCE_Message">[Active Accessibility Text Services is deprecated. Please see Microsoft Windows Text Services
///Frameworkfor more information on advanced text input and natural language technologies. ] Exposes methods for client
///applications to retrieve documents.
@GUID("4C896039-7B6D-49E6-A8C1-45116A98292B")
interface IAccClientDocMgr : IUnknown
{
    ///Clients call <b>IAccClientDocMgr::GetDocuments</b> to get a list of all documents that have been registered with
    ///the Microsoft Active Accessibility run time. <div class="alert"><b>Note</b> Active Accessibility Text Services is
    ///deprecated. Please see Microsoft Windows Text Services Frameworkfor more information on advanced text input and
    ///natural language technologies. </div><div> </div>
    ///Params:
    ///    enumUnknown = Type: <b>IEnumUnknown*</b> A list of document interface pointers.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK.
    ///    
    HRESULT GetDocuments(IEnumUnknown* enumUnknown);
    ///Clients call <b>IAccClientDocMgr::LookupByHWND</b> to get a document by providing the <b>HWND</b> for the
    ///document. <div class="alert"><b>Note</b> Active Accessibility Text Services is deprecated. Please see Microsoft
    ///Windows Text Services Frameworkfor more information on advanced text input and natural language technologies.
    ///</div><div> </div>
    ///Params:
    ///    hWnd = Type: <b>HWND</b> The <b>HWND</b> of the document to be returned.
    ///    riid = Type: <b>REFIID</b> IID of the document being requested. This is usually IID_ITextStoreAnchor.
    ///    ppunk = Type: <b>IUnknown*</b> Interface pointer to the document being requested.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. If not successful, returns the following value or another
    ///    standard COM error code. <table> <tr> <th>Error</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> If the <b>HWND</b> does not correspond to an active
    ///    document, then <i>ppunk</i> will be <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT LookupByHWND(HWND hWnd, const(GUID)* riid, IUnknown* ppunk);
    ///Clients call <b>IAccClientDocMgr::LookupByPoint</b> to get a document object from a point within the document.
    ///<div class="alert"><b>Note</b> Active Accessibility Text Services is deprecated. Please see Microsoft Windows
    ///Text Services Frameworkfor more information on advanced text input and natural language technologies. </div><div>
    ///</div>
    ///Params:
    ///    pt = Type: <b>POINT</b> A point inside the bounding rectangle of the document to be returned.
    ///    riid = Type: <b>REFIID</b> IID of the document being requested. This is usually IID_ITextStoreAnchor.
    ///    ppunk = Type: <b>IUnknown*</b> Interface pointer to the document being requested.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. If not successful, returns the following value or another
    ///    standard COM error code. <table> <tr> <th>Error</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> If the value in <i>pt</i> does not fall within the
    ///    bounding rectangle of an active document, then <i>ppunk</i> will be <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT LookupByPoint(POINT pt, const(GUID)* riid, IUnknown* ppunk);
    ///Clients call the <b>IAccClientDocMgr::GetFocused</b> method to access a pointer for the document that has focus.
    ///<div class="alert"><b>Note</b> Active Accessibility Text Services is deprecated. Please see Microsoft Windows
    ///Text Services Frameworkfor more information on advanced text input and natural language technologies. </div><div>
    ///</div>
    ///Params:
    ///    riid = Type: <b>REFIID</b> IID of the document being requested. This is usually IID_ITextStoreAnchor.
    ///    ppunk = Type: <b>IUnknown*</b> Interface pointer to the document being requested.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK.
    ///    
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

///Exposes methods and properties that make a user interface element and its children accessible to client applications.
@GUID("618736E0-3C3D-11CF-810C-00AA00389B71")
interface IAccessible : IDispatch
{
    ///The <b>IAccessible::get_accParent</b> method retrieves the IDispatch of the object's parent. All objects support
    ///this property.
    ///Params:
    ///    ppdispParent = Type: <b>IDispatch**</b> Receives the address of the parent object's IDispatch interface. If no parent exists
    ///                   or if the child cannot access its parent, the variable is set to <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. If not successful, returns one of the values in the table
    ///    that follows, or another standard COM error code. Servers return these values, but clients must always check
    ///    output parameters to ensure that they contain valid values. For more information, see Checking IAccessible
    ///    Return Values. <table> <tr> <th>Error</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> No parent exists for this object. </td> </tr> </table>
    ///    
    HRESULT get_accParent(IDispatch* ppdispParent);
    ///The <b>IAccessible::get_accChildCount</b> method retrieves the number of children that belong to this object. All
    ///objects must support this property.
    ///Params:
    ///    pcountChildren = Type: <b>long*</b> Address of a variable that receives the number of children that belong to this object. The
    ///                     children are accessible objects or child elements. If the object has no children, this value is zero.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. If not successful, returns a standard COM error code.
    ///    Servers return these values, but clients must always check output parameters to ensure that they contain
    ///    valid values. For more information, see Checking IAccessible Return Values.
    ///    
    HRESULT get_accChildCount(int* pcountChildren);
    ///The <b>IAccessible::get_accChild</b> method retrieves an IDispatch for the specified child, if one exists. All
    ///objects must support this property.
    ///Params:
    ///    varChild = Type: <b>VARIANT</b> Identifies the child whose IDispatch interface is retrieved. For more information about
    ///               initializing the VARIANT, see How Child IDs Are Used in Parameters.
    ///    ppdispChild = Type: <b>IDispatch**</b> [out, retval] Receives the address of the child object's IDispatch interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. If not successful, returns one of the values in the table
    ///    that follows, or another standard COM error code. Servers return these values, but clients must always check
    ///    output parameters to ensure that they contain valid values. For more information, see Checking IAccessible
    ///    Return Values. <table> <tr> <th>Error</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The child is not an accessible object. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An argument is not valid.
    ///    </td> </tr> </table>
    ///    
    HRESULT get_accChild(VARIANT varChild, IDispatch* ppdispChild);
    ///The <b>IAccessible::get_accName</b> method retrieves the name of the specified object. All objects support this
    ///property.
    ///Params:
    ///    varChild = Type: <b>VARIANT</b> Specifies whether the retrieved name belongs to the object or one of the object's child
    ///               elements. This parameter is either CHILDID_SELF (to obtain information about the object) or a child ID (to
    ///               obtain information about the object's child element). For more information about initializing the VARIANT
    ///               structure, see How Child IDs Are Used in Parameters.
    ///    pszName = Type: <b>BSTR*</b> Address of a <b>BSTR</b> that receives a string that contains the specified object's name.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. If not successful, returns one of the values in the table
    ///    that follows, or another standard COM error code. Servers return these values, but clients must always check
    ///    output parameters to ensure that they contain valid values. For more information, see Checking IAccessible
    ///    Return Values. <table> <tr> <th>Error</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The specified object does not have a name. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An argument is not
    ///    valid. </td> </tr> </table>
    ///    
    HRESULT get_accName(VARIANT varChild, BSTR* pszName);
    ///The <b>IAccessible::get_accValue</b> method retrieves the value of the specified object. Not all objects have a
    ///value.
    ///Params:
    ///    varChild = Type: <b>VARIANT</b> Specifies whether the retrieved value information belongs to the object or one of the
    ///               object's child elements. This parameter is either CHILDID_SELF (to obtain information about the object) or a
    ///               child ID (to obtain information about the object's child element). For more information about initializing
    ///               the VARIANT structure, see How Child IDs Are Used in Parameters.
    ///    pszValue = Type: <b>BSTR*</b> Address of the <b>BSTR</b> that receives a localized string that contains the object's
    ///               current value.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. If not successful, returns one of the values in the table
    ///    that follows, or another standard COM error code. Servers return these values, but clients must always check
    ///    output parameters to ensure that they contain valid values. For more information, see Checking IAccessible
    ///    Return Values. <table> <tr> <th>Error</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DISP_E_MEMBERNOTFOUND</b></dt> </dl> </td> <td width="60%"> The object does not support this property.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An argument
    ///    is not valid. </td> </tr> </table>
    ///    
    HRESULT get_accValue(VARIANT varChild, BSTR* pszValue);
    ///The <b>IAccessible::get_accDescription</b> method retrieves a string that describes the visual appearance of the
    ///specified object. Not all objects have a description. <div class="alert"><b>Note</b> The Description property is
    ///often used incorrectly and is not supported by Microsoft UI Automation. Microsoft Active Accessibility server
    ///developers should not use this property. If more information is needed for accessibility and automation
    ///scenarios, use the properties supported by UI Automation elements and control patterns.</div><div> </div>
    ///Params:
    ///    varChild = Type: <b>VARIANT</b> Specifies whether the retrieved description belongs to the object or one of the object's
    ///               child elements. This parameter is either CHILDID_SELF (to obtain information about the object) or a child ID
    ///               (to obtain information about the object's child element). For more information about initializing the VARIANT
    ///               structure, see How Child IDs Are Used in Parameters.
    ///    pszDescription = Type: <b>BSTR*</b> Address of a <b>BSTR</b> that receives a localized string that describes the specified
    ///                     object, or <b>NULL</b> if this object has no description.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. If not successful, returns one of the values in the table
    ///    that follows, or another standard COM error code. Servers return these values, but clients must always check
    ///    output parameters to ensure that they contain valid values. For more information, see Checking IAccessible
    ///    Return Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The specified object does not have a description. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An argument is not
    ///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_MEMBERNOTFOUND</b></dt> </dl> </td> <td
    ///    width="60%"> The specified object does not support this property. </td> </tr> </table>
    ///    
    HRESULT get_accDescription(VARIANT varChild, BSTR* pszDescription);
    ///The <b>IAccessible::get_accRole</b> method retrieves information that describes the role of the specified object.
    ///All objects support this property.
    ///Params:
    ///    varChild = Type: <b>VARIANT</b> Specifies whether the retrieved role information belongs to the object or one of the
    ///               object's child elements. This parameter is either CHILDID_SELF (to obtain information about the object) or a
    ///               child ID (to obtain information about the object's child element). For more information about initializing
    ///               the VARIANT, see How Child IDs Are Used in Parameters.
    ///    pvarRole = Type: <b>VARIANT*</b> Address of a VARIANT that receives an object role constant. The <b>vt</b> member must
    ///               be VT_I4. The <b>lVal</b> member receives an object role constant.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. If not successful, returns one of the values in the table
    ///    that follows, or another standard COM error code. Servers return these values, but clients must always check
    ///    output parameters to ensure that they contain valid values. For more information, see Checking IAccessible
    ///    Return Values. <table> <tr> <th>Error</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An argument is not valid. </td> </tr> </table>
    ///    
    HRESULT get_accRole(VARIANT varChild, VARIANT* pvarRole);
    ///The <b>IAccessible::get_accState</b> method retrieves the current state of the specified object. All objects
    ///support this property.
    ///Params:
    ///    varChild = Type: <b>VARIANT</b> Specifies whether the retrieved state information belongs to the object or of one of the
    ///               object's child elements. This parameter is either CHILDID_SELF (to obtain information about the object) or a
    ///               child ID (to obtain information about the object's child element). For more information about initializing
    ///               the VARIANT, see How Child IDs Are Used in Parameters.
    ///    pvarState = Type: <b>VARIANT*</b> Address of a VARIANT structure that receives information that describes the object's
    ///                state. The <b>vt</b> member is VT_I4, and the <b>lVal</b> member is one or more of the object state
    ///                constants.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. If not successful, returns one of the values in the table
    ///    that follows, or another standard COM error code. Servers return these values, but clients must always check
    ///    output parameters to ensure that they contain valid values. For more information, see Checking IAccessible
    ///    Return Values. <table> <tr> <th>Error</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An argument is not valid. </td> </tr> </table>
    ///    
    HRESULT get_accState(VARIANT varChild, VARIANT* pvarState);
    ///The <b>IAccessible::get_accHelp</b> method retrieves the <b>Help</b> property string of an object. Not all
    ///objects support this property.
    ///Params:
    ///    varChild = Type: <b>VARIANT</b> Specifies whether the retrieved help information belongs to the object or one of the
    ///               object's child elements. This parameter is either CHILDID_SELF (to obtain information about the object) or a
    ///               child ID (to obtain information about one of the object's child elements). For more information about
    ///               initializing the VARIANT, see How Child IDs Are Used in Parameters.
    ///    pszHelp = Type: <b>BSTR*</b> [out, retval] Address of a <b>BSTR</b> that receives the localized string that contains
    ///              the help information for the specified object, or <b>NULL</b> if no help information is available.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. If not successful, returns one of the values in the table
    ///    that follows, or another standard COM error code. Servers return these values, but clients must always check
    ///    output parameters to ensure that they contain valid values. For more information, see Checking IAccessible
    ///    Return Values. <table> <tr> <th>Error</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> No help information is available. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An argument is not valid. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_MEMBERNOTFOUND</b></dt> </dl> </td> <td width="60%"> The
    ///    object does not support this property. </td> </tr> </table>
    ///    
    HRESULT get_accHelp(VARIANT varChild, BSTR* pszHelp);
    ///The <b>IAccessible::get_accHelpTopic</b> method retrieves the full path of the WinHelp file that is associated
    ///with the specified object; it also retrieves the identifier of the appropriate topic within that file. Not all
    ///objects support this property. This property is rarely supported or used by applications <div
    ///class="alert"><b>Note</b> <b>IAccessible::get_accHelpTopic</b> is deprecated and should not be used.</div><div>
    ///</div>
    ///Params:
    ///    pszHelpFile = Type: <b>BSTR*</b> Address of a <b>BSTR</b> that receives the full path of the WinHelp file that is
    ///                  associated with the specified object.
    ///    varChild = Type: <b>VARIANT</b> Specifies whether the retrieved Help topic belongs to the object or one of the object's
    ///               child elements. This parameter is either CHILDID_SELF (to obtain a Help topic for the object) or a child ID
    ///               (to obtain a Help topic for one of the object's child elements). For more information about initializing the
    ///               VARIANT, see How Child IDs Are Used in Parameters.
    ///    pidTopic = Type: <b>long*</b> [out, retval] Address of a variable that identifies the Help file topic associated with
    ///               the specified object. This value is used as the context identifier of the desired topic that passes to the
    ///               WinHelp function. When calling WinHelp to display the topic, set the <i>uCommand</i> parameter to
    ///               HELP_CONTEXT, cast the value pointed to by <i>pidTopic</i> to a <b>DWORD</b>, and pass it as the
    ///               <i>dwData</i> parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. If not successful, returns one of the values in the table
    ///    that follows, or another standard COM error code. Servers return these values, but clients must always check
    ///    output parameters to ensure that they contain valid values. For more information, see Checking IAccessible
    ///    Return Values. <table> <tr> <th>Error</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> No Help information is available. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An argument is not valid. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_MEMBERNOTFOUND</b></dt> </dl> </td> <td width="60%"> The
    ///    object does not support this property. </td> </tr> </table>
    ///    
    HRESULT get_accHelpTopic(BSTR* pszHelpFile, VARIANT varChild, int* pidTopic);
    ///The <b>IAccessible::get_accKeyboardShortcut</b> method retrieves the specified object's shortcut key or access
    ///key, also known as the mnemonic. All objects that have a shortcut key or an access key support this property.
    ///Params:
    ///    varChild = Type: <b>VARIANT</b> Specifies whether the retrieved keyboard shortcut belongs to the object or one of the
    ///               object's child elements. This parameter is either CHILDID_SELF (to obtain information about the object) or a
    ///               child ID (to obtain information about the object's child element). For more information about initializing
    ///               the VARIANT, see How Child IDs Are Used in Parameters.
    ///    pszKeyboardShortcut = Type: <b>BSTR*</b> Address of a <b>BSTR</b> that receives a localized string that identifies the keyboard
    ///                          shortcut, or <b>NULL</b> if no keyboard shortcut is associated with the specified object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. If not successful, returns one of the values in the table
    ///    that follows, or another standard COM error code. Servers return these values, but clients must always check
    ///    output parameters to ensure that they contain valid values. For more information, see Checking IAccessible
    ///    Return Values. <table> <tr> <th>Error</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The object does not have an associated keyboard
    ///    shortcut. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An
    ///    argument is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_MEMBERNOTFOUND</b></dt> </dl>
    ///    </td> <td width="60%"> The object does not support this property. </td> </tr> </table>
    ///    
    HRESULT get_accKeyboardShortcut(VARIANT varChild, BSTR* pszKeyboardShortcut);
    ///The <b>IAccessible::get_accFocus</b> method retrieves the object that has the keyboard focus. All objects that
    ///may receive the keyboard focus must support this property.
    ///Params:
    ///    pvarChild = Type: <b>VARIANT*</b> Address of a VARIANT structure that receives information about the object that has the
    ///                focus. The following table describes the information returned in <i>pvarID</i>. <table> <tr> <th>Value</th>
    ///                <th>Meaning</th> </tr> <tr> <td width="40%"><a id="VT_EMPTY"></a><a id="vt_empty"></a><dl>
    ///                <dt><b>VT_EMPTY</b></dt> </dl> </td> <td width="60%"> None. Neither this object nor any of its children has
    ///                the keyboard focus. </td> </tr> <tr> <td width="40%"><a id="VT_I4"></a><a id="vt_i4"></a><dl>
    ///                <dt><b>VT_I4</b></dt> </dl> </td> <td width="60%"> <b>lVal</b> is CHILDID_SELF. The object itself has the
    ///                keyboard focus. </td> </tr> <tr> <td width="40%"><a id="VT_I4"></a><a id="vt_i4"></a><dl>
    ///                <dt><b>VT_I4</b></dt> </dl> </td> <td width="60%"> <b>lVal</b> contains the child ID of the child element
    ///                that has the keyboard focus. </td> </tr> <tr> <td width="40%"><a id="VT_DISPATCH"></a><a
    ///                id="vt_dispatch"></a><dl> <dt><b>VT_DISPATCH</b></dt> </dl> </td> <td width="60%"> <b>pdispVal</b> member is
    ///                the address of the IDispatch interface for the child object that has the keyboard focus. </td> </tr> </table>
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. If not successful, returns one of the values in the table
    ///    that follows, or another standard COM error code. Servers return these values, but clients must always check
    ///    output parameters to ensure that they contain valid values. For more information, see Checking IAccessible
    ///    Return Values. <table> <tr> <th>Error</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The object is a window but not not the foreground
    ///    window. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_MEMBERNOTFOUND</b></dt> </dl> </td> <td
    ///    width="60%"> The object does not support this property. </td> </tr> </table>
    ///    
    HRESULT get_accFocus(VARIANT* pvarChild);
    ///The <b>IAccessible::get_accSelection</b> method retrieves the selected children of this object. All objects that
    ///support selection must support this property.
    ///Params:
    ///    pvarChildren = Type: <b>VARIANT*</b> Address of a VARIANT structure that receives information about which children are
    ///                   selected. The following table describes the information returned in <i>pvarChildren</i>. <table> <tr> <th>vt
    ///                   member</th> <th>Value member</th> </tr> <tr> <td width="40%"><a id="VT_EMPTY"></a><a id="vt_empty"></a><dl>
    ///                   <dt><b>VT_EMPTY</b></dt> </dl> </td> <td width="60%"> No children are selected. </td> </tr> <tr> <td
    ///                   width="40%"><a id="VT_DISPATCH"></a><a id="vt_dispatch"></a><dl> <dt><b>VT_DISPATCH</b></dt> </dl> </td> <td
    ///                   width="60%"> One child object is selected, and the address of its IDispatch interface is set in the
    ///                   <b>pdispVal</b> member. </td> </tr> <tr> <td width="40%"><a id="VT_I4"></a><a id="vt_i4"></a><dl>
    ///                   <dt><b>VT_I4</b></dt> </dl> </td> <td width="60%"> <b>lVal</b> contains the child ID of the child element
    ///                   that is selected. If <b>lVal</b> is CHILDID_SELF, this means that the object itself is selected. </td> </tr>
    ///                   <tr> <td width="40%"><a id="VT_UNKNOWN"></a><a id="vt_unknown"></a><dl> <dt><b>VT_UNKNOWN</b></dt> </dl>
    ///                   </td> <td width="60%"> Multiple child objects are selected, and the <b>punkVal</b> member contains the
    ///                   address of the IUnknown interface. The client queries this interface for the IEnumVARIANT interface, which it
    ///                   uses to enumerate the selected objects. </td> </tr> </table>
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. If not successful, returns one of the values in the table
    ///    that follows, or another standard COM error code. Servers return these values, but clients must always check
    ///    output parameters to ensure that they contain valid values. For more information, see Checking IAccessible
    ///    Return Values. <table> <tr> <th>Error</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DISP_E_MEMBERNOTFOUND</b></dt> </dl> </td> <td width="60%"> The object does not support this property.
    ///    </td> </tr> </table>
    ///    
    HRESULT get_accSelection(VARIANT* pvarChildren);
    ///The <b>IAccessible::get_accDefaultAction</b> method retrieves a string that indicates the object's default
    ///action. Not all objects have a default action.
    ///Params:
    ///    varChild = Type: <b>VARIANT</b> Specifies whether the retrieved default action is performed by the object or of one of
    ///               the object's child elements. This parameter is either CHILDID_SELF (to obtain information about the object)
    ///               or a child ID (to obtain information about the object's child element). For more information about
    ///               initializing the VARIANT structure, see How Child IDs Are Used in Parameters.
    ///    pszDefaultAction = Type: <b>BSTR*</b> Address of a <b>BSTR</b> that receives a localized string that describes the default
    ///                       action for the specified object; if this object has no default action, the value is <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. If not successful, returns one of the values in the table
    ///    that follows, or another standard COM error code. Servers return these values, but clients must always check
    ///    output parameters to ensure that they contain valid values. For more information, see Checking IAccessible
    ///    Return Values. <table> <tr> <th>Error</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The specified object does not have a default action.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An argument
    ///    is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_MEMBERNOTFOUND</b></dt> </dl> </td> <td
    ///    width="60%"> The specified object does not support this property. </td> </tr> </table>
    ///    
    HRESULT get_accDefaultAction(VARIANT varChild, BSTR* pszDefaultAction);
    ///The <b>IAccessible::accSelect</b> method modifies the selection or moves the keyboard focus of the specified
    ///object. All objects that support selection or receive the keyboard focus must support this method.
    ///Params:
    ///    flagsSelect = Type: <b>long</b> Specifies which selection or focus operations are to be performed. This parameter must have
    ///                  a combination of the SELFLAG Constants.
    ///    varChild = Type: <b>VARIANT</b> Specifies the selected object. If the value is CHILDID_SELF, the object itself is
    ///               selected; if a child ID, one of the object's child elements is selected. For more information about
    ///               initializing the VARIANT structure, see How Child IDs Are Used in Parameters.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. If not successful, returns one of the values in the table
    ///    that follows, or another standard COM error code. <table> <tr> <th>Error</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The specified object is not
    ///    selected. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An
    ///    argument is not valid. This return value means that the specified SELFLAG combination is not valid, or that
    ///    the SELFLAG value does not make sense for the specified object. For example, the following flags are not
    ///    allowed on a single-selection list box: SELFLAG_EXTENDSELECTION, SELFLAG_ADDSELECTION, and
    ///    SELFLAG_REMOVESELECTION. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_MEMBERNOTFOUND</b></dt> </dl>
    ///    </td> <td width="60%"> The object does not support this method. </td> </tr> </table>
    ///    
    HRESULT accSelect(int flagsSelect, VARIANT varChild);
    ///The <b>IAccessible::accLocation</b> method retrieves the specified object's current screen location. All visual
    ///objects must support this method. Sound objects do not support this method.
    ///Params:
    ///    pxLeft = Type: <b>long*</b> Address, in physical screen coordinates, of the variable that receives the x-coordinate of
    ///             the upper-left boundary of the object's location.
    ///    pyTop = Type: <b>long*</b> Address, in physical screen coordinates, of the variable that receives the y-coordinate of
    ///            the upper-left boundary of the object's location.
    ///    pcxWidth = Type: <b>long*</b> Address, in pixels, of the variable that receives the object's width.
    ///    pcyHeight = Type: <b>long*</b> Address, in pixels, of the variable that receives the object's height.
    ///    varChild = Type: <b>VARIANT</b> Specifies whether the location that the server returns should be that of the object or
    ///               that of one of the object's child elements. This parameter is either CHILDID_SELF (to obtain information
    ///               about the object) or a child ID (to obtain information about the object's child element). For more
    ///               information about initializing the VARIANT structure, see How Child IDs Are Used in Parameters.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. Clients must always check that output parameters contain
    ///    valid values. If not successful, returns one of the values in the table that follows, or another standard COM
    ///    error code. For more information, see Checking IAccessible Return Values. <table> <tr> <th>Error</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_MEMBERNOTFOUND</b></dt> </dl> </td> <td
    ///    width="60%"> The object does not support this method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An argument is not valid. </td> </tr> </table>
    ///    
    HRESULT accLocation(int* pxLeft, int* pyTop, int* pcxWidth, int* pcyHeight, VARIANT varChild);
    ///The <b>IAccessible::accNavigate</b> method traverses to another UI element within a container and retrieves the
    ///object. This method is optional. <div class="alert"><b>Note</b> The <b>accNavigate</b>method is deprecated and
    ///should not be used. Clients should use other methods and properties such as AccessibleChildren, get_accChild,
    ///get_accParent, and IEnumVARIANT.</div><div> </div>
    ///Params:
    ///    navDir = Type: <b>long</b> Specifies the direction to navigate. This direction is in <i>spatial</i> order, such as
    ///             left or right, or <i>logical</i> order, such as next or previous. This value is one of the navigation
    ///             constants.
    ///    varStart = Type: <b>VARIANT</b> Specifies whether the starting object of the navigation is the object itself or one of
    ///               the object's children. This parameter is either CHILDID_SELF (to start from the object) or a child ID (to
    ///               start from one of the object's child elements). For more information about initializing the VARIANT, see How
    ///               Child IDs Are Used in Parameters.
    ///    pvarEndUpAt = Type: <b>VARIANT*</b> [out, retval] Address of a VARIANT structure that receives information about the
    ///                  destination object. The following table describes the information that is returned in <i>pvarEnd</i>. <table>
    ///                  <tr> <th>vt member</th> <th>Value member</th> </tr> <tr> <td width="40%"><a id="VT_EMPTY"></a><a
    ///                  id="vt_empty"></a><dl> <dt><b>VT_EMPTY</b></dt> </dl> </td> <td width="60%"> None. There was no UI element in
    ///                  the specified direction. </td> </tr> <tr> <td width="40%"><a id="VT_I4"></a><a id="vt_i4"></a><dl>
    ///                  <dt><b>VT_I4</b></dt> </dl> </td> <td width="60%"> <b>lVal</b> contains the child ID of the UI element. </td>
    ///                  </tr> <tr> <td width="40%"><a id="VT_DISPATCH"></a><a id="vt_dispatch"></a><dl> <dt><b>VT_DISPATCH</b></dt>
    ///                  </dl> </td> <td width="60%"> <b>pdispVal</b> contains the address of the UI element's IDispatch. </td> </tr>
    ///                  </table>
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. If not successful, returns one of the values in the table
    ///    that follows, or another standard COM error code. Servers return these values, but clients must always check
    ///    output parameters to ensure that they contain valid values. For more information, see Checking IAccessible
    ///    Return Values and Return Values. <table> <tr> <th>Error</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> No screen element was found in the specified
    ///    direction. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_MEMBERNOTFOUND</b></dt> </dl> </td> <td
    ///    width="60%"> The object does not support this method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An argument is not valid. </td> </tr> </table>
    ///    
    HRESULT accNavigate(int navDir, VARIANT varStart, VARIANT* pvarEndUpAt);
    ///The <b>IAccessible::accHitTest</b> method retrieves the child element or child object that is displayed at a
    ///specific point on the screen. All visual objects support this method, but sound objects do not. Client
    ///applications rarely call this method directly; to get the accessible object that is displayed at a point, use the
    ///AccessibleObjectFromPoint function, which calls this method internally.
    ///Params:
    ///    xLeft = Type: <b>long</b> Specifies the screen coordinates of the point that is hit tested. The x-coordinates
    ///            increase from left to right. Note that when screen coordinates are used, the origin is the upper-left corner
    ///            of the screen.
    ///    yTop = Type: <b>long</b> Specifies the screen coordinates of the point that is hit tested. The y-coordinates
    ///           increase from top to bottom. Note that when screen coordinates are used, the origin is the upper-left corner
    ///           of the screen.
    ///    pvarChild = Type: <b>VARIANT*</b> [out, retval] Address of a VARIANT that identifies the object displayed at the point
    ///                specified by <i>xLeft</i> and <i>yTop</i>. The information returned in <i>pvarID</i> depends on the location
    ///                of the specified point in relation to the object whose <b>accHitTest</b> method is being called. <table> <tr>
    ///                <th>Point location</th> <th>vt member</th> <th>Value member</th> </tr> <tr> <td>Outside of the object's
    ///                boundaries, and either inside or outside of the object's bounding rectangle.</td> <td>VT_EMPTY</td>
    ///                <td>None.</td> </tr> <tr> <td>Within the object but not within a child element or a child object.</td>
    ///                <td>VT_I4</td> <td><b>lVal</b> is CHILDID_SELF.</td> </tr> <tr> <td>Within a child element.</td>
    ///                <td>VT_I4</td> <td><b>lVal</b> contains the child ID.</td> </tr> <tr> <td>Within a child object.</td>
    ///                <td>VT_DISPATCH</td> <td><i>pdispVal</i> is set to the child object's IDispatch interface pointer</td> </tr>
    ///                </table>
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. If not successful, returns one of the values in the table
    ///    that follows, or another standard COM error code. Servers return these values, but clients must always check
    ///    output parameters to ensure that they contain valid values. For more information, see Checking IAccessible
    ///    Return Values. <table> <tr> <th>Error</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The point is outside of the object's boundaries. The
    ///    <b>vt</b> member of <i>pvarID</i> is VT_EMPTY. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DISP_E_MEMBERNOTFOUND</b></dt> </dl> </td> <td width="60%"> The object does not support this method.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An argument
    ///    is not valid. </td> </tr> </table> <b>Note to client developers: </b>Although servers return S_FALSE if the
    ///    <b>vt</b> member of <i>pvarID</i> is VT_EMPTY, clients must also handle the case where <i>pvarID</i>-&gt;vt
    ///    is VT_EMPTY and the return value is S_OK.
    ///    
    HRESULT accHitTest(int xLeft, int yTop, VARIANT* pvarChild);
    ///The <b>IAccessible::accDoDefaultAction</b> method performs the specified object's default action. Not all objects
    ///have a default action.
    ///Params:
    ///    varChild = Type: <b>VARIANT</b> Specifies whether the default action belongs to the object or one of the object's child
    ///               elements. For more information about initializing the VARIANT, see How Child IDs Are Used in Parameters.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. If not successful, returns one of the values in the table
    ///    that follows, or another standard COM error code. <table> <tr> <th>Error</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>DISP_E_MEMBERNOTFOUND</b></dt> </dl> </td> <td width="60%"> The object does not
    ///    support the method. This value is returned for controls that do not perform actions, such as edit fields.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An argument
    ///    is not valid. </td> </tr> </table>
    ///    
    HRESULT accDoDefaultAction(VARIANT varChild);
    ///<p class="CCE_Message">[IAccessible::put_accName is no longer supported. ] The IAccessible::put_accName method is
    ///no longer supported. Client applications should use a control-specific workaround, such as the SetWindowText
    ///function. Servers should return E_NOTIMPL.
    ///Params:
    ///    varChild = Not supported.
    ///    szName = Not supported.
    ///Returns:
    ///    Not supported.
    ///    
    HRESULT put_accName(VARIANT varChild, BSTR szName);
    ///The <b>IAccessible::put_accValue</b> method sets the value of the specified object. Not all objects have a value.
    ///Params:
    ///    varChild = Type: <b>VARIANT</b> Specifies whether the value information being set belongs to the object or one of the
    ///               object's child elements. This parameter is either CHILDID_SELF (to set information on the object) or a child
    ///               ID (to set information about the object's child element). For more information about initializing the VARIANT
    ///               structure, see How Child IDs Are Used in Parameters.
    ///    szValue = Type: <b>BSTR</b> A localized string that contains the object's value.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. If not successful, returns one of the values in the table
    ///    that follows, or another standard COM error code. Servers return these values, but clients must always check
    ///    output parameters to ensure that they contain valid values. For more information, see Checking IAccessible
    ///    Return Values. <table> <tr> <th>Error</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DISP_E_MEMBERNOTFOUND</b></dt> </dl> </td> <td width="60%"> The object does not support this property.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An argument
    ///    is not valid. </td> </tr> </table>
    ///    
    HRESULT put_accValue(VARIANT varChild, BSTR szValue);
}

///<p class="CCE_Message">[<b>IAccessibleHandler</b> is deprecated and should not be used.] Exposes a method that
///retrieves an accessible element from an object ID.
@GUID("03022430-ABC4-11D0-BDE2-00AA001A1953")
interface IAccessibleHandler : IUnknown
{
    ///The <b>AccessibleObjectFromID</b> method retrieves an IAccessibleinterface pointer for the interface associated
    ///with the given object ID. Oleacc.dll uses this method to obtain an <b>IAccessible</b> interface pointer for
    ///proxies that are supplied by other code. <div class="alert"><b>Note</b>
    ///<b>IAccessibleHandler::AccessibleObjectFromID</b> is deprecated and should not be used.</div><div> </div>
    ///Params:
    ///    hwnd = Type: <b>long</b> Specifies the handle of a window for which an IAccessible interface pointer is to be
    ///           retrieved.
    ///    lObjectID = Type: <b>long</b> Specifies the object ID. This value is one of the standard object identifier constants or a
    ///                custom object ID.
    ///    pIAccessible = Type: <b>LPACCESSIBLE*</b> Specifies the address of a pointer variable that receives the address of the
    ///                   object's IAccessible interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. If not successful, returns one of the following or another
    ///    standard COM error code. <table> <tr> <th>Error</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An argument is not valid. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"> The requested interface is not
    ///    supported. </td> </tr> </table>
    ///    
    HRESULT AccessibleObjectFromID(int hwnd, int lObjectID, IAccessible* pIAccessible);
}

///A Microsoft ActiveX control site implements this interface to enable a windowless ActiveX control that has a
///Microsoft Active Accessibility implementation to express its accessibility. This interface enables the control
///container to reserve a range of object IDs that a windowless control can use to raise events, and enables the control
///container to provide an IAccessible pointer for the parent of the windowless control.
@GUID("BF3ABD9C-76DA-4389-9EB6-1427D25ABAB7")
interface IAccessibleWindowlessSite : IUnknown
{
    ///Acquires a range of object IDs from the control host and marks them as reserved by a specific windowless control.
    ///Params:
    ///    rangeSize = The size of the object ID range that is being requested.
    ///    pRangeOwner = The windowless control that is requesting the range.
    ///    pRangeBase = The first object ID in the acquired range.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AcquireObjectIdRange(int rangeSize, IAccessibleHandler pRangeOwner, int* pRangeBase);
    ///Releases an object ID range that was acquired by a previous call to the
    ///IAccessibleWindowlessSite::AcquireObjectIdRange method.
    ///Params:
    ///    rangeBase = Type: <b>long</b> The first object ID in the range of IDs to be released.
    ///    pRangeOwner = Type: <b>IAccessibleHandler*</b> The windowless ActiveX control with which the range was associated when it
    ///                  was acquired.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ReleaseObjectIdRange(int rangeBase, IAccessibleHandler pRangeOwner);
    ///Retrieves the object ID ranges that a particular windowless Microsoft ActiveX control has reserved.
    ///Params:
    ///    pRangesOwner = Type: <b>IAccessibleHandler*</b> The control whose ranges are being queried.
    ///    psaRanges = Type: <b>SAFEARRAY**</b> Receives the array of object ID ranges. The array contains a set of paired integers.
    ///                For each pair, the first integer is the first object ID in the range, and the second integer is a count of
    ///                object IDs in the range.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT QueryObjectIdRanges(IAccessibleHandler pRangesOwner, SAFEARRAY** psaRanges);
    ///Retrieves an IAccessible pointer for the parent of a windowless Microsoft ActiveX control in the accessibility
    ///tree.
    ///Params:
    ///    ppParent = Type: <b>IAccessible**</b> Receives the IAccessible pointer for the parent of the windowless ActiveX control.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetParentAccessible(IAccessible* ppParent);
}

///Exposes a method that provides a unique identifier for an accessible element.
@GUID("7852B78D-1CFD-41C1-A615-9C0C85960B5F")
interface IAccIdentity : IUnknown
{
    ///Retrieves a string of bytes (an identity string) that uniquely identifies an accessible element. If server
    ///developers know the <b>HWND</b> of the object they want to annotate, they can use one of the following methods
    ///instead of using this method and getting an identity string. <ul> <li> IAccPropServices::SetHwndPropStr </li>
    ///<li> IAccPropServices::SetHwndProp </li> <li> IAccPropServices::SetHwndPropServer </li> </ul>
    ///Params:
    ///    dwIDChild = Type: <b>DWORD</b> Specifies which child of the IAccessible object the caller wants to identify.
    ///    ppIDString = Type: <b>BYTE**</b> Address of a variable that receives a pointer to a callee-allocated identity string. The
    ///                 callee allocates the identity string using CoTaskMemAlloc; the caller must release the identity string by
    ///                 using CoTaskMemFree when finished.
    ///    pdwIDStringLen = Type: <b>DWORD*</b> Address of a variable that receives the length, in bytes, of the callee-allocated
    ///                     identity string.
    ///Returns:
    ///    Type: <b>HRESULT</b> Return S_OK, except under exceptional error conditions, such as low memory. If not
    ///    supported, calling QueryInterface on IAccIdentity should fail.
    ///    
    HRESULT GetIdentityString(uint dwIDChild, char* ppIDString, uint* pdwIDStringLen);
}

///Exposes a method that retrieves a property value for an accessible element.
@GUID("76C0DBBB-15E0-4E7B-B61B-20EEEA2001E0")
interface IAccPropServer : IUnknown
{
    ///Retrieves a property value for an accessible element.
    ///Params:
    ///    pIDString = Type: <b>const BYTE*</b> Contains a string that identifies the property being requested.
    ///    dwIDStringLen = Type: <b>DWORD</b> Specifies the length of the identity string specified by the <i>pIDString</i> parameter.
    ///    idProp = Type: <b>MSAAPROPID</b> Specifies a GUID indicating the desired property.
    ///    pvarValue = Type: <b>VARIANT*</b> Specifies the value of the overridden property. This parameter is valid only if
    ///                <i>pfHasProp</i> is <b>TRUE</b>. The server must set this to VT_EMPTY if <i>pfHasProp</i> is set to
    ///                <b>FALSE</b>.
    ///    pfHasProp = Type: <b>BOOL*</b> Indicates whether the server is supplying a value for the requested property. The server
    ///                should set this to <b>TRUE</b> if it is returning an overriding property or to <b>FALSE</b> if it is not
    ///                returning a property (in which case it should also set <i>pvarValue</i> to VT_EMPTY).
    ///Returns:
    ///    Type: <b>HRESULT</b> Return S_OK, except under exceptional error conditions such as low memory. If the
    ///    specified property is not overridden, then <i>pfHasProp</i> should be set to <b>FALSE</b> and
    ///    <i>pvarValue</i> should be set to VT_EMPTY by the server.
    ///    
    HRESULT GetPropValue(char* pIDString, uint dwIDStringLen, GUID idProp, VARIANT* pvarValue, int* pfHasProp);
}

///Exposes methods for annotating accessible elements and for manipulating identity strings.
@GUID("6E26E776-04F0-495D-80E4-3330352E3169")
interface IAccPropServices : IUnknown
{
    ///Use <b>SetPropValue</b> to identify the accessible element to be annotated, specify the property to be annotated,
    ///and provide a new value for that property. If server developers know the <b>HWND</b> of the accessible element
    ///they want to annotate, they can use one of the following methods: <ul> <li>
    ///IAccPropServices::SetHwndPropStr,</li> <li> IAccPropServices::SetHwndProp, or</li> <li>
    ///IAccPropServices::SetHwndPropServer </li> </ul>
    ///Params:
    ///    pIDString = Type: <b>const BYTE*</b> Identifies the accessible element that is to be annotated.
    ///    dwIDStringLen = Type: <b>DWORD</b> Specifies the length of the string identified by the <i>pIDString</i> parameter.
    ///    idProp = Type: <b>MSAAPROPID</b> Specifies the property of the accessible element to be annotated.
    ///    var = Type: <b>VARIANT</b> Specifies a new value for the property.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. Returns E_INVALIDARG if <i>idProp</i> is not a supported
    ///    property, if <i>var</i> is not a supported type for that property, or if the identity string is not valid.
    ///    May return other error codes under exceptional error conditions such as low memory.
    ///    
    HRESULT SetPropValue(char* pIDString, uint dwIDStringLen, GUID idProp, VARIANT var);
    ///Servers use <b>SetPropServer</b> to specify a callback object to be used to annotate an array of properties for
    ///the accessible element. You can also specify whether the annotation is to be applied to this accessible element
    ///or to the element and its children. This method is used for server annotation. If server developers know the
    ///<b>HWND</b> of the accessible element they want to annotate, they can use IAccPropServices::SetHwndPropServer.
    ///Params:
    ///    pIDString = Type: <b>const BYTE*</b> Identifies the accessible element that is to be annotated.
    ///    dwIDStringLen = Type: <b>DWORD</b> Specifies the length of the string identified by the <i>pIDString</i> parameter.
    ///    paProps = Type: <b>const MSAAPROPID*</b> Specifies an array of properties to be handled by the specified callback
    ///              object.
    ///    cProps = Type: <b>int</b> Specifies an array of properties to be handled by the specified callback object.
    ///    pServer = Type: <b>IAccPropServer*</b> Specifies the callback object that will be invoked when a client requests one of
    ///              the overridden properties.
    ///    annoScope = Type: <b>AnnoScope</b> May be ANNO_THIS, indicating that the annotation affects the indicated accessible
    ///                element only; or ANNO_CONTAINER, indicating that it applies to the element and its immediate element
    ///                children.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. Returns E_INVALIDARG if any of the properties in the
    ///    <i>paProps</i> array are not supported properties, if the identity string is not valid, or if
    ///    <i>annoScope</i> is not one of ANNO_THIS or ANNO_CONTAINER. May return other error codes under exceptional
    ///    error conditions such as low memory.
    ///    
    HRESULT SetPropServer(char* pIDString, uint dwIDStringLen, char* paProps, int cProps, IAccPropServer pServer, 
                          AnnoScope annoScope);
    ///Servers use <b>ClearProps</b> to restore default values to properties of accessible elements that they had
    ///previously annotated. If servers know the <b>HWND</b> of the object they want to clear, they can use
    ///IAccPropServices::ClearHwndProps.
    ///Params:
    ///    pIDString = Type: <b>const BYTE*</b> Identify the accessible element that is to be un-annotated.
    ///    dwIDStringLen = Type: <b>DWORD</b> Length of <i>pIDString</i>.
    ///    paProps = Type: <b>const MSAAPROPID*</b> Specify an array of properties that is to be reset. These properties will
    ///              revert to the default behavior they displayed before they were annotated.
    ///    cProps = Type: <b>int</b> Size of <i>paProps</i> array.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK, even if the specified properties were never annotated on
    ///    the accessible object; clearing already cleared properties is considered a success. Returns E_INVALIDARG if
    ///    any of the properties in the <i>paProps</i> array are not supported. May return other error codes under
    ///    exceptional error conditions such as low memory.
    ///    
    HRESULT ClearProps(char* pIDString, uint dwIDStringLen, char* paProps, int cProps);
    ///This method wraps SetPropValue, providing a convenient entry point for callers who are annotating
    ///<b>HWND</b>-based accessible elements. If the new value is a string, you can use IAccPropServices::SetHwndPropStr
    ///instead.
    ///Params:
    ///    hwnd = Type: <b>HWND</b> Identifies the accessible element that is to be annotated. This replaces the identity
    ///           string.
    ///    idObject = Type: <b>DWORD</b> Identifies the accessible element that is to be annotated. This replaces the identity
    ///               string.
    ///    idChild = Type: <b>DWORD</b> Identifies the accessible element that is to be annotated. This replaces the identity
    ///              string.
    ///    idProp = Type: <b>MSAAPROPID</b> Specifies which property of that element is to be annotated.
    ///    var = Type: <b>VARIANT</b> Specifies a new value for that property.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. Returns E_INVALIDARG if the <i>idProp</i> property is not
    ///    supported. May return other error codes under exceptional error conditions such as low memory.
    ///    
    HRESULT SetHwndProp(HWND hwnd, uint idObject, uint idChild, GUID idProp, VARIANT var);
    ///This method wraps SetPropValue, providing a more convenient entry point for callers who are annotating
    ///<b>HWND</b>-based accessible elements.
    ///Params:
    ///    hwnd = Type: <b>HWND</b> Identifies the accessible element that is to be annotated. This replaces the identity
    ///           string.
    ///    idObject = Type: <b>DWORD</b> Identifies the accessible element that is to be annotated. This replaces the identity
    ///               string.
    ///    idChild = Type: <b>DWORD</b> Identifies the accessible element that is to be annotated. This replaces the identity
    ///              string.
    ///    idProp = Type: <b>MSAAPROPID</b> Specifies which property of that element is to be annotated.
    ///    str = Type: <b>LPCWSTR</b> Specifies a new value for that property.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. May return other error codes under exceptional error
    ///    conditions such as low memory.
    ///    
    HRESULT SetHwndPropStr(HWND hwnd, uint idObject, uint idChild, GUID idProp, const(wchar)* str);
    ///This method wraps SetPropServer, providing a convenient entry point for callers who are annotating
    ///<b>HWND</b>-based accessible elements.
    ///Params:
    ///    hwnd = Type: <b>HWND</b> Identifies the accessible element that is to be annotated. This replaces the identity
    ///           string.
    ///    idObject = Type: <b>DWORD</b> Identifies the accessible element that is to be annotated. This replaces the identity
    ///               string.
    ///    idChild = Type: <b>DWORD</b> Identifies the accessible element that is to be annotated. This replaces the identity
    ///              string.
    ///    paProps = Type: <b>const MSAAPROPID*</b> Specifies an array of properties that is to be handled by the specified
    ///              callback object.
    ///    cProps = Type: <b>int</b> Specifies the number of properties in the <i>paProps</i> array.
    ///    pServer = Type: <b>IAccPropServer*</b> Specifies the callback object, which will be invoked when a client requests one
    ///              of the overridden properties.
    ///    annoScope = Type: <b>AnnoScope</b> May be ANNO_THIS, indicating that the annotation affects the indicated accessible
    ///                element only; or ANNO_CONTAINER, indicating that it applies to the element and its immediate element
    ///                children.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. Returns E_INVALIDARG if any of the properties in the
    ///    <i>paProps</i> array are not supported properties, if the identity string is not valid, or if
    ///    <i>annoScope</i> is not one of ANNO_THIS or ANNO_CONTAINER. May return other error codes under exceptional
    ///    error conditions such as low memory.
    ///    
    HRESULT SetHwndPropServer(HWND hwnd, uint idObject, uint idChild, char* paProps, int cProps, 
                              IAccPropServer pServer, AnnoScope annoScope);
    ///This method wraps SetPropValue, SetPropServer, and ClearProps, and provides a convenient entry point for callers
    ///who are annotating <b>HWND</b>-based accessible elements.
    ///Params:
    ///    hwnd = Type: <b>HWND</b> Identifies the accessible element that is to be annotated. This replaces the identity
    ///           string.
    ///    idObject = Type: <b>DWORD</b> Identifies the accessible element that is to be annotated. This replaces the identity
    ///               string.
    ///    idChild = Type: <b>DWORD</b> Identifies the accessible element that is to be annotated. This replaces the identity
    ///              string.
    ///    paProps = Type: <b>const MSAAPROPID*</b> Specifies an array of properties that is to be reset. These properties will
    ///              revert to the default behavior that they displayed before they were annotated.
    ///    cProps = Type: <b>int</b> Specifies the number of properties in the <i>paProps</i> array.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK, even if the specified properties were never annotated on
    ///    the accessible object; clearing already-cleared properties is considered a success. Returns E_INVALIDARG if
    ///    any of the properties in the <i>paProps</i> array are not supported. May return other error codes under
    ///    exceptional error conditions such as low memory. For descriptions of return values, see the corresponding
    ///    SetPropValue, SetPropServer, or ClearProps method.
    ///    
    HRESULT ClearHwndProps(HWND hwnd, uint idObject, uint idChild, char* paProps, int cProps);
    ///Callers use <b>ComposeHwndIdentityString</b> to retrieve an identity string.
    ///Params:
    ///    hwnd = Type: <b>HWND</b> Specifies the <b>HWND</b> of the accessible element that the caller wants to identify.
    ///    idObject = Type: <b>DWORD</b> Specifies the object ID of the accessible element.
    ///    idChild = Type: <b>DWORD</b> Specifies the child ID of the accessible element.
    ///    ppIDString = Type: <b>BYTE**</b> Pointer to a buffer that receives the identity string. The callee allocates this buffer
    ///                 using CoTaskMemAlloc. When finished, the caller must free the buffer by calling CoTaskMemFree.
    ///    pdwIDStringLen = Type: <b>DWORD*</b> Pointer to a buffer that receives the length of the identity string.
    HRESULT ComposeHwndIdentityString(HWND hwnd, uint idObject, uint idChild, char* ppIDString, 
                                      uint* pdwIDStringLen);
    ///Use this method to determine the <b>HWND</b>, object ID, and child ID for the accessible element identified by
    ///the identity string.
    ///Params:
    ///    pIDString = Type: <b>const BYTE*</b> Pointer to a buffer containing identity string of an <b>HWND</b>-based accessible
    ///                element.
    ///    dwIDStringLen = Type: <b>DWORD</b> Specifies the length of the identity string specified by <i>pIDString</i>.
    ///    phwnd = Type: <b>HWND*</b> Pointer to a buffer that receives the <b>HWND</b> of the accessible element.
    ///    pidObject = Type: <b>DWORD*</b> Pointer to a buffer that receives the object ID of the accessible element.
    ///    pidChild = Type: <b>DWORD*</b> Pointer to a buffer that receives the child ID of the accessible element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. Returns E_INVALIDARG if <i>phwnd</i>, <i>pidObject</i>, or
    ///    <i>pidChild</i> are not valid, or if the given identity string is not a <b>HWND</b>-based identity string.
    ///    May return other error codes under exceptional error conditions such as low memory.
    ///    
    HRESULT DecomposeHwndIdentityString(char* pIDString, uint dwIDStringLen, HWND* phwnd, uint* pidObject, 
                                        uint* pidChild);
    ///This method wraps SetPropValue, providing a convenient entry point for callers who are annotating
    ///<b>HMENU</b>-based accessible elements. If the new value is a string, you can use
    ///IAccPropServices::SetHmenuPropStr instead.
    ///Params:
    ///    hmenu = Type: <b>HMENU</b> Identifies the <b>HMENU</b>-based accessible element to be annotated.
    ///    idChild = Type: <b>DWORD</b> Specifies the child ID of the accessible element.
    ///    idProp = Type: <b>MSAAPROPID</b> Specifies which property of the accessible element is to be annotated.
    ///    var = Type: <b>VARIANT</b> Specifies a new value for the <i>idProp</i> property.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. May return other error codes under exceptional error
    ///    conditions such as low memory.
    ///    
    HRESULT SetHmenuProp(HMENU hmenu, uint idChild, GUID idProp, VARIANT var);
    ///This method wraps SetPropValue, providing a more convenient entry point for callers who are annotating
    ///<b>HMENU</b>-based accessible elements.
    ///Params:
    ///    hmenu = Type: <b>HMENU</b> Identifies the <b>HMENU</b>-based accessible element to be annotated.
    ///    idChild = Type: <b>DWORD</b> Specifies the child ID of the accessible element.
    ///    idProp = Type: <b>MSAAPROPID</b> Specifies which property of the accessible element is to be annotated.
    ///    str = Type: <b>LPCWSTR</b> Specifies a new value for the <i>idProp</i> property.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. May return other error codes under exceptional error
    ///    conditions such as low memory.
    ///    
    HRESULT SetHmenuPropStr(HMENU hmenu, uint idChild, GUID idProp, const(wchar)* str);
    ///This method wraps SetPropServer, providing a convenient entry point for callers who are annotating
    ///<b>HMENU</b>-based accessible elements.
    ///Params:
    ///    hmenu = Type: <b>HMENU</b> Identifies the <b>HMENU</b>-accessible element to be annotated.
    ///    idChild = Type: <b>DWORD</b> Identifies the accessible element that is to be annotated. This replaces the identity
    ///              string.
    ///    paProps = Type: <b>const MSAAPROPID*</b> Specifies an array of properties that is to be handled by the specified
    ///              callback object.
    ///    cProps = Type: <b>int</b> Specifies the number of properties in the <i>paProps</i> array.
    ///    pServer = Type: <b>IAccPropServer*</b> Specifies the callback object, which will be invoked when a client requests one
    ///              of the overridden properties.
    ///    annoScope = Type: <b>AnnoScope</b> May be ANNO_THIS, indicating that the annotation affects the indicated accessible
    ///                element only; or ANNO_CONTAINER, indicating that it applies to the element and its immediate element
    ///                children.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. Returns E_INVALIDARG if any of the properties in the
    ///    <i>paProps</i> array are not supported properties, if the identity string is not valid, or if
    ///    <i>annoScope</i> is not one of ANNO_THIS or ANNO_CONTAINER. May return other error codes under exceptional
    ///    error conditions such as low memory.
    ///    
    HRESULT SetHmenuPropServer(HMENU hmenu, uint idChild, char* paProps, int cProps, IAccPropServer pServer, 
                               AnnoScope annoScope);
    ///This method wraps ClearProps, and provides a convenient entry point for callers who are annotating
    ///<b>HMENU</b>-based accessible elements.
    ///Params:
    ///    hmenu = Type: <b>HMENU</b> Identifies the <b>HMENU</b>-based accessible element to be annotated.
    ///    idChild = Type: <b>DWORD</b> Specifies the child ID of the accessible element.
    ///    paProps = Type: <b>const MSAAPROPID*</b> Specifies an array of properties to be reset. These properties will revert to
    ///              the default behavior that they displayed before they were annotated.
    ///    cProps = Type: <b>int</b> Specifies the number of properties in the <i>paProps</i> array.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK, even if the specified properties were never annotated on
    ///    the accessible object; clearing already-cleared properties is considered a success. Returns E_INVALIDARG if
    ///    any of the properties in the <i>paProps</i> array are not supported. May return other error codes under
    ///    exceptional error conditions such as low memory. For descriptions of other parameters and return values, see
    ///    the ClearProps method.
    ///    
    HRESULT ClearHmenuProps(HMENU hmenu, uint idChild, char* paProps, int cProps);
    ///Callers use <b>ComposeHmenuIdentityString</b> to retrieve an identity string for an <b>HMENU</b>-based accessible
    ///element.
    ///Params:
    ///    hmenu = Type: <b>HMENU</b> Identifies the <b>HMENU</b>-based accessible element.
    ///    idChild = Type: <b>DWORD</b> Specifies the child ID of the accessible element.
    ///    ppIDString = Type: <b>BYTE**</b> Pointer to a buffer that receives the identity string. The callee allocates this buffer
    ///                 using CoTaskMemAlloc. When finished, the caller must free the buffer by calling CoTaskMemFree.
    ///    pdwIDStringLen = Type: <b>DWORD*</b> Pointer to a buffer that receives the length of the identity string.
    HRESULT ComposeHmenuIdentityString(HMENU hmenu, uint idChild, char* ppIDString, uint* pdwIDStringLen);
    ///Use this method to determine the <b>HMENU</b>, object ID, and child ID for the accessible element identified by
    ///the identity string.
    ///Params:
    ///    pIDString = Type: <b>const BYTE*</b> Pointer to a buffer containing identity string of an <b>HMENU</b>-based accessible
    ///                element.
    ///    dwIDStringLen = Type: <b>DWORD</b> Specifies the length of the identity string specified by <i>pIDString</i>.
    ///    phmenu = Type: <b>HMENU*</b> Pointer to a buffer that receives the <b>HMENU</b> of the accessible element.
    ///    pidChild = Type: <b>DWORD*</b> Pointer to a buffer that receives the child ID of the accessible element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If successful, returns S_OK. Returns E_INVALIDARG if <i>phmenu</i> or <i>pidChild</i>
    ///    are not valid, or if the given identity string is not a <b>HMENU</b>-based identity string. May return other
    ///    error codes under exceptional error conditions such as low memory.
    ///    
    HRESULT DecomposeHmenuIdentityString(char* pIDString, uint dwIDStringLen, HMENU* phmenu, uint* pidChild);
}

///Defines methods and properties that expose simple UI elements.
@GUID("D6DD68D1-86FD-4332-8666-9ABEDEA2D24C")
interface IRawElementProviderSimple : IUnknown
{
    ///Specifies the type of Microsoft UI Automation provider; for example, whether it is a client-side (proxy) or
    ///server-side provider. This property is read-only.
    HRESULT get_ProviderOptions(ProviderOptions* pRetVal);
    ///Retrieves a pointer to an object that provides support for a control pattern on a Microsoft UI Automation
    ///element.
    ///Params:
    ///    patternId = Type: <b>PATTERNID</b> The identifier of the control pattern. For a list of control pattern IDs, see Control
    ///                Pattern Identifiers.
    ///    pRetVal = Type: <b>IUnknown**</b> Receives a pointer to the object that supports the control pattern, or <b>NULL</b> if
    ///              the control pattern is not supported. This parameter is passed uninitialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPatternProvider(int patternId, IUnknown* pRetVal);
    ///Retrieves the value of a property supported by the Microsoft UI Automation provider.
    ///Params:
    ///    propertyId = Type: <b>PROPERTYID</b> The property identifier. For a list of property IDs, see Property Identifiers.
    ///    pRetVal = Type: <b>VARIANT*</b> Receives the property value, or <b>VT_EMPTY</b> if the property is not supported by
    ///              this provider. This parameter is passed uninitialized. See Remarks.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an HRESULT error
    ///    code. If the provider does not support the <i>propertyId</i> property, the provider should set
    ///    <i>pRetVal-&gt;vt</i> to <b>VT_EMPTY</b> and return <b>S_OK</b>.
    ///    
    HRESULT GetPropertyValue(int propertyId, VARIANT* pRetVal);
    ///Specifies the host provider for this element. This property is read-only.
    HRESULT get_HostRawElementProvider(IRawElementProviderSimple* pRetVal);
}

///Exposes methods that are called by Microsoft UI Automation to retrieve extra information about a control that
///supports Microsoft Active Accessibility.
@GUID("F8B80ADA-2C44-48D0-89BE-5FF23C9CD875")
interface IAccessibleEx : IUnknown
{
    ///Retrieves an IAccessibleEx interface representing the specified child of this element.
    ///Params:
    ///    idChild = Type: <b>long</b> The identifier of the child element.
    ///    pRetVal = Type: <b>IAccessibleEx**</b> Receives a pointer to the IAccessibleEx interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetObjectForChild(int idChild, IAccessibleEx* pRetVal);
    ///Retrieves the IAccessible interface and child ID for this item.
    ///Params:
    ///    ppAcc = Type: <b>IAccessible**</b> Receives a pointer to the IAccessible interface for this object, or the parent
    ///            object if this is a child element.
    ///    pidChild = Type: <b>long*</b> Receives the child ID, or CHILDID_SELF if this is not a child element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetIAccessiblePair(IAccessible* ppAcc, int* pidChild);
    ///Retrieves the runtime identifier of this element.
    ///Params:
    ///    pRetVal = Type: <b>SAFEARRAY**</b> Receives a pointer to the runtime identifier.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetRuntimeId(SAFEARRAY** pRetVal);
    ///Retrieves the IAccessibleEx interface of an element returned as a property value.
    ///Params:
    ///    pIn = Type: <b>IRawElementProviderSimple*</b> Pointer to the IRawElementProviderSimple interface that was retrieved
    ///          as a property.
    ///    ppRetValOut = Type: <b>IAccessibleEx**</b> Receives a pointer to the IAccessibleEx interface of the element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ConvertReturnedElement(IRawElementProviderSimple pIn, IAccessibleEx* ppRetValOut);
}

///Extends the IRawElementProviderSimple interface to enable programmatically invoking context menus.
@GUID("A0A839A9-8DA1-4A82-806A-8E0D44E79F56")
interface IRawElementProviderSimple2 : IRawElementProviderSimple
{
    ///Programmatically invokes a context menu on the target element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ShowContextMenu();
}

///Extends the IRawElementProviderSimple2 interface to enable retrieving metadata about how accessible technology should
///say the preferred content type.
@GUID("FCF5D820-D7EC-4613-BDF6-42A84CE7DAAF")
interface IRawElementProviderSimple3 : IRawElementProviderSimple2
{
    ///Gets metadata from the UI Automation element that indicates how the information should be interpreted. For
    ///example, should the string "1/4" be interpreted as a fraction or a date?
    ///Params:
    ///    targetId = The ID of the property to retrieve.
    ///    metadataId = Specifies the type of metadata to retrieve.
    ///    returnVal = The metadata.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, otherwise an <b>HRESULT</b> error code.
    ///    
    HRESULT GetMetadataValue(int targetId, int metadataId, VARIANT* returnVal);
}

///Exposes methods and properties on the root element in a fragment.
@GUID("620CE2A5-AB8F-40A9-86CB-DE3C75599B58")
interface IRawElementProviderFragmentRoot : IUnknown
{
    ///Retrieves the provider of the element that is at the specified point in this fragment.
    ///Params:
    ///    x = Type: <b>double</b> The horizontal screen coordinate.
    ///    y = Type: <b>double</b> The vertical screen coordinate.
    ///    pRetVal = Type: <b>IRawElementProviderFragment**</b> Receives a pointer to the provider of the element at (x, y), or
    ///              <b>NULL</b> if none exists. This parameter is passed uninitialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ElementProviderFromPoint(double x, double y, IRawElementProviderFragment* pRetVal);
    ///Retrieves the element in this fragment that has the input focus.
    ///Params:
    ///    pRetVal = Type: <b>IRawElementProviderFragment**</b> Receives a pointer to the IRawElementProviderFragment interface of
    ///              the element in this fragment that has the input focus, if any; otherwise <b>NULL</b>. This parameter is
    ///              passed uninitialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFocus(IRawElementProviderFragment* pRetVal);
}

///Exposes methods and properties on UI elements that are part of a structure more than one level deep, such as a list
///box or list item. Implemented by Microsoft UI Automation provider.
@GUID("F7063DA8-8359-439C-9297-BBC5299A7D87")
interface IRawElementProviderFragment : IUnknown
{
    ///Retrieves the Microsoft UI Automation element in a specified direction within the UI Automation tree.
    ///Params:
    ///    arg1 = Type: <b>NavigateDirection</b> The direction in which to navigate.
    ///    pRetVal = Type: <b>IRawElementProviderFragment**</b> Receives a pointer to the provider of the UI Automation element in
    ///              the specified direction, or <b>NULL</b> if there is no element in that direction. This parameter is passed
    ///              uninitialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Navigate(NavigateDirection direction, IRawElementProviderFragment* pRetVal);
    ///Retrieves the runtime identifier of an element.
    ///Params:
    ///    pRetVal = Type: <b>SAFEARRAY**</b> Receives a pointer to the runtime identifier. This parameter is passed
    ///              uninitialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetRuntimeId(SAFEARRAY** pRetVal);
    ///Specifies the bounding rectangle of this element. This property is read-only.
    HRESULT get_BoundingRectangle(UiaRect* pRetVal);
    ///Retrieves an array of root fragments that are embedded in the Microsoft UI Automation tree rooted at the current
    ///element.
    ///Params:
    ///    pRetVal = Type: <b>SAFEARRAY**</b> Receives an array of pointers to the root fragments, or <b>NULL</b> (see Remarks).
    ///              This parameter is passed uninitialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetEmbeddedFragmentRoots(SAFEARRAY** pRetVal);
    ///Sets the focus to this element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetFocus();
    ///Specifies the root node of the fragment. This property is read-only.
    HRESULT get_FragmentRoot(IRawElementProviderFragmentRoot* pRetVal);
}

///Exposes methods that are called to notify the root element of a fragment when a Microsoft UI Automation client
///application begins or ends listening for events on that fragment.
@GUID("A407B27B-0F6D-4427-9292-473C7BF93258")
interface IRawElementProviderAdviseEvents : IUnknown
{
    ///Notifies the Microsoft UI Automation provider when a UI Automation client begins listening for a specific event,
    ///including a property-changed event.
    ///Params:
    ///    eventId = Type: <b>EVENTID</b> The identifier of the event being added. For a list of event IDs, see Event Identifiers.
    ///    propertyIDs = Type: <b>SAFEARRAY*</b> A pointer to the identifiers of properties being added, or <b>NULL</b> if the event
    ///                  listener being added is not listening for property events.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AdviseEventAdded(int eventId, SAFEARRAY* propertyIDs);
    ///Notifies the Microsoft UI Automation provider when a UI Automation client stops listening for a specific event,
    ///including a property-changed event.
    ///Params:
    ///    eventId = Type: <b>EVENTID</b> The identifier of the event being removed. For a list of event IDs, see Event
    ///              Identifiers.
    ///    propertyIDs = Type: <b>SAFEARRAY*</b> A pointer to the identifiers of the properties being removed, or <b>NULL</b>if the
    ///                  event listener being removed is not listening for property events.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AdviseEventRemoved(int eventId, SAFEARRAY* propertyIDs);
}

///Exposes a method that enables repositioning of window-based elements within the fragment's UI Automation tree.
@GUID("1D5DF27C-8947-4425-B8D9-79787BB460B8")
interface IRawElementProviderHwndOverride : IUnknown
{
    ///Gets a UI Automation provider for the specified element.
    ///Params:
    ///    hwnd = Type: <b>HWND</b> The window handle of the element.
    ///    pRetVal = Type: <b>IRawElementProviderSimple**</b> Receives a pointer to the new provider for the specified window, or
    ///              <b>NULL</b> if the provider is not being overridden. This parameter is passed uninitialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetOverrideProviderForHwnd(HWND hwnd, IRawElementProviderSimple* pRetVal);
}

///Exposes methods used by proxy providers to raise events.
@GUID("4FD82B78-A43E-46AC-9803-0A6969C7C183")
interface IProxyProviderWinEventSink : IUnknown
{
    ///Raises a property-changed event.
    ///Params:
    ///    pProvider = Type: <b>IRawElementProviderSimple*</b> A pointer to the provider for the element that will raise the event.
    ///    id = Type: <b>PROPERTYID</b> The identifier of the property that is to be changed. For a list of property IDs, see
    ///         Property Identifiers.
    ///    newValue = Type: <b>VARIANT</b> The new value for the changed property.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddAutomationPropertyChangedEvent(IRawElementProviderSimple pProvider, int id, VARIANT newValue);
    ///Raises a Microsoft UI Automation event.
    ///Params:
    ///    pProvider = Type: <b>IRawElementProviderSimple*</b> A pointer to the provider for the element that will raise the event.
    ///    id = Type: <b>EVENTID</b> The identifier of the event that will be raised. For a list of event identifiers, see
    ///         Event Identifiers
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddAutomationEvent(IRawElementProviderSimple pProvider, int id);
    ///Raises an event to notify clients that the structure of the UI Automation tree has changed.
    ///Params:
    ///    pProvider = Type: <b>IRawElementProviderSimple*</b> A pointer to the provider of the element that is raising the event.
    ///    arg2 = Type: <b>StructureChangeType</b> The type of structure change that occurred.
    ///    runtimeId = Type: <b>SAFEARRAY*</b> A pointer to the runtime identifiers of the elements that are affected. These IDs
    ///                enable applications to identify elements that have been removed and are no longer represented by
    ///                IUIAutomationElement interfaces.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddStructureChangedEvent(IRawElementProviderSimple pProvider, StructureChangeType structureChangeType, 
                                     SAFEARRAY* runtimeId);
}

///Exposes a method that is implemented by proxy providers to handle WinEvents. To implement Microsoft UI Automation
///event handling, a proxy provider may need to handle WinEvents that are raised by the proxied UI. UI Automation will
///use the <b>IProxyProviderWinEventHandler</b> interface to notify the provider that a WinEvent has been raised for the
///provider window.
@GUID("89592AD4-F4E0-43D5-A3B6-BAD7E111B435")
interface IProxyProviderWinEventHandler : IUnknown
{
    ///Handles a WinEvent.
    ///Params:
    ///    idWinEvent = Type: <b>DWORD</b> The identifier of the incoming WinEvent. For a list of WinEvent IDs, see Event Constants.
    ///    hwnd = Type: <b>HWND</b> The handle of the window for which the WinEvent was fired. This should also be the window
    ///           for which the proxy was created.
    ///    idObject = Type: <b>LONG</b> The object identifier (OBJID_*) of the accessible object associated with the event. For a
    ///               list of object identifiers, see Object Identifiers.
    ///    idChild = Type: <b>LONG</b> The child identifier of the element associated with the event, or <b>CHILDID_SELF</b> if
    ///              the element is not a child.
    ///    pSink = Type: <b>IProxyProviderWinEventSink*</b> A pointer to the IProxyProviderWinEventSink interface provided by
    ///            the UI Automation core. Any event that the proxy needs to raise in response to the WinEvent being handled
    ///            should be added to the sink.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RespondToWinEvent(uint idWinEvent, HWND hwnd, int idObject, int idChild, 
                              IProxyProviderWinEventSink pSink);
}

///A Microsoft ActiveX control site implements this interface to enable a Microsoft UI Automation-enabled ActiveX
///control to express its accessibility. This interface enables the control container to provide an
///IRawElementProviderFragment pointer for the parent or siblings of the windowless ActiveX control, and to provide a
///runtime ID that is unique to the control site.
@GUID("0A2A93CC-BFAD-42AC-9B2E-0991FB0D3EA0")
interface IRawElementProviderWindowlessSite : IUnknown
{
    ///Retrieves a fragment pointer for a fragment that is adjacent to the windowless Microsoft ActiveX control owned by
    ///this control site.
    ///Params:
    ///    arg1 = Type: <b>NavigateDirection</b> A value that indicates the adjacent fragment to retrieve (parent, next
    ///           sibling, previous sibling, and so on).
    ///    ppParent = Type: <b>IRawElementProviderFragment**</b> Receives the adjacent fragment.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. The return value is E_INVALIDARG if the direction is NavigateDirection_FirstChild or
    ///    NavigateDirection_LastChild, which are not valid for this method. If there is no adjacent fragment in the
    ///    requested direction, the method returns S_OK and sets <i>ppRetVal</i> to <b>NULL</b>.
    ///    
    HRESULT GetAdjacentFragment(NavigateDirection direction, IRawElementProviderFragment* ppParent);
    ///Retrieves a Microsoft UI Automation runtime ID that is unique to the windowless Microsoft ActiveX control site.
    ///Params:
    ///    pRetVal = Type: <b>SAFEARRAY**</b> Receives the runtime ID.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetRuntimeIdPrefix(SAFEARRAY** pRetVal);
}

///A Microsoft Active Accessibility object implements this interface when the object is the root of an accessibility
///tree that includes windowless Microsoft ActiveX controls that implement Microsoft UI Automation. Because Microsoft
///Active Accessibility and UI Automation use different interfaces, this interface enables a client to discover the list
///of hosted windowless ActiveX controls that support UI Automation in case the client needs to treat them differently.
@GUID("33AC331B-943E-4020-B295-DB37784974A3")
interface IAccessibleHostingElementProviders : IUnknown
{
    ///Retrieves the Microsoft Active Accessibility providers of all windowless Microsoft ActiveX controls that have a
    ///Microsoft UI Automation provider implementation, and are hosted in a Microsoft Active Accessibility object that
    ///implements the IAccessibleHostingElementProviders interface.
    ///Params:
    ///    pRetVal = Type: <b>SAFEARRAY**</b> Receives the IRawElementProviderFragmentRoot interface pointers.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetEmbeddedFragmentRoots(SAFEARRAY** pRetVal);
    ///Retrieves the object ID associated with a contained windowless Microsoft ActiveX control that implements
    ///Microsoft UI Automation.
    ///Params:
    ///    pProvider = Type: <b>IRawElementProviderSimple*</b> The provider for the windowless ActiveX control.
    ///    pidObject = Type: <b>long*</b> The object ID of the contained windowless ActiveX control.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetObjectIdForProvider(IRawElementProviderSimple pProvider, int* pidObject);
}

///This interface is implemented by a Microsoft UI Automation provider when the provider is the root of an accessibility
///tree that includes windowless controls that support Microsoft Active Accessibility. Because UI Automation and
///Microsoft Active Accessibility use different interfaces, this interface enables a client to discover the list of
///hosted Microsoft Active Accessibility controls in case it needs to treat them differently.
@GUID("24BE0B07-D37D-487A-98CF-A13ED465E9B3")
interface IRawElementProviderHostingAccessibles : IUnknown
{
    ///Retrieves the IAccessible interface pointers of the windowless Microsoft ActiveX controls that are hosted by this
    ///provider.
    ///Params:
    ///    pRetVal = Type: <b>SAFEARRAY**</b> Receives the IAccessible pointers of the hosted windowless ActiveX controls.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetEmbeddedAccessibles(SAFEARRAY** pRetVal);
}

///Provides access to an element in a docking container.
@GUID("159BC72C-4AD3-485E-9637-D7052EDF0146")
interface IDockProvider : IUnknown
{
    ///Sets the docking position of this element.
    ///Params:
    ///    dockPosition = Type: <b>DockPosition</b> The new docking position.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetDockPosition(DockPosition dockPosition);
    ///Indicates the current docking position of this element. This property is read-only.
    HRESULT get_DockPosition(DockPosition* pRetVal);
}

///Provides access to a control that visually expands to display content, and collapses to hide content.
@GUID("D847D3A5-CAB0-4A98-8C32-ECB45C59AD24")
interface IExpandCollapseProvider : IUnknown
{
    ///Displays all child nodes, controls, or content of the control.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Expand();
    ///Hides all child nodes, controls, or content of this element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Collapse();
    ///Indicates the state, expanded or collapsed, of the control. This property is read-only.
    HRESULT get_ExpandCollapseState(ExpandCollapseState* pRetVal);
}

///Provides access to controls that act as containers for a collection of child elements organized in a two-dimensional
///logical coordinate system that can be traversed (that is, a Microsoft UI Automation client can move to adjacent
///controls) by using the keyboard. The children of this element must implement IGridItemProvider.
@GUID("B17D6187-0907-464B-A168-0EF17A1572B1")
interface IGridProvider : IUnknown
{
    ///Retrieves the Microsoft UI Automation provider for the specified cell.
    ///Params:
    ///    row = Type: <b>int</b> The ordinal number of the row of interest.
    ///    column = Type: <b>int</b> The ordinal number of the column of interest.
    ///    pRetVal = Type: <b>IRawElementProviderSimple**</b> Receives a pointer to a UI Automation provider for the specified
    ///              cell or a null reference (Nothing in Microsoft Visual Basic .NET) if the cell is empty.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetItem(int row, int column, IRawElementProviderSimple* pRetVal);
    ///Specifies the total number of rows in the grid. This property is read-only.
    HRESULT get_RowCount(int* pRetVal);
    ///Specifies the total number of columns in the grid. This property is read-only.
    HRESULT get_ColumnCount(int* pRetVal);
}

///Provides access to individual child controls of containers that implement IGridProvider.
@GUID("D02541F1-FB81-4D64-AE32-F520F8A6DBD1")
interface IGridItemProvider : IUnknown
{
    ///Specifies the ordinal number of the row that contains this cell or item. This property is read-only.
    HRESULT get_Row(int* pRetVal);
    ///Specifies the ordinal number of the column that contains this cell or item. This property is read-only.
    HRESULT get_Column(int* pRetVal);
    ///Specifies the number of rows spanned by this cell or item. This property is read-only.
    HRESULT get_RowSpan(int* pRetVal);
    ///Specifies the number of columns spanned by this cell or item. This property is read-only.
    HRESULT get_ColumnSpan(int* pRetVal);
    ///Specifies the UI Automation provider that implements IGridProvider and represents the container of this cell or
    ///item. This property is read-only.
    HRESULT get_ContainingGrid(IRawElementProviderSimple* pRetVal);
}

///Provides access to controls that initiate or perform a single, unambiguous action and do not maintain state when
///activated.
@GUID("54FCB24B-E18E-47A2-B4D3-ECCBE77599A2")
interface IInvokeProvider : IUnknown
{
    ///Sends a request to activate a control and initiate its single, unambiguous action.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Invoke();
}

///Provides access to controls that provide, and are able to switch between, multiple representations of the same set of
///information or child controls.
@GUID("6278CAB1-B556-4A1A-B4E0-418ACC523201")
interface IMultipleViewProvider : IUnknown
{
    ///Retrieves the name of a control-specific view.
    ///Params:
    ///    viewId = Type: <b>int</b> A view identifier.
    ///    pRetVal = Type: <b>BSTR*</b> Receives a localized name for the view. This parameter is passed uninitialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetViewName(int viewId, BSTR* pRetVal);
    ///Sets the current control-specific view.
    ///Params:
    ///    viewId = Type: <b>int</b> A view identifier.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetCurrentView(int viewId);
    ///Identifies the current view that the control is using to display information or child controls. This property is
    ///read-only.
    HRESULT get_CurrentView(int* pRetVal);
    ///Retrieves a collection of control-specific view identifiers.
    ///Params:
    ///    pRetVal = Type: <b>SAFEARRAY**</b> Receives a collection of control-specific integer values that identify the views
    ///              available for a UI Automation element. This parameter is passed uninitialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSupportedViews(SAFEARRAY** pRetVal);
}

///Provides access to controls that can be set to a value within a range.
@GUID("36DC7AEF-33E6-4691-AFE1-2BE7274B3D33")
interface IRangeValueProvider : IUnknown
{
    ///Sets the value of the control.
    ///Params:
    ///    val = Type: <b>double</b> The value to set.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetValue(double val);
    ///Specifies the value of the control. This property is read-only.
    HRESULT get_Value(double* pRetVal);
    ///Indicates whether the value of a control is read-only. This property is read-only.
    HRESULT get_IsReadOnly(int* pRetVal);
    ///Specifies the maximum range value supported by the control. This property is read-only.
    HRESULT get_Maximum(double* pRetVal);
    ///Specifies the minimum range value supported by the control. This property is read-only.
    HRESULT get_Minimum(double* pRetVal);
    ///Specifies the value that is added to or subtracted from the IRangeValueProvider::Value property when a large
    ///change is made, such as when the PAGE DOWN key is pressed. This property is read-only.
    HRESULT get_LargeChange(double* pRetVal);
    ///Specifies the value that is added to or subtracted from the IRangeValueProvider::Value property when a small
    ///change is made, such as when an arrow key is pressed. This property is read-only.
    HRESULT get_SmallChange(double* pRetVal);
}

///Provides access to individual child controls of containers that implement IScrollProvider.
@GUID("2360C714-4BF1-4B26-BA65-9B21316127EB")
interface IScrollItemProvider : IUnknown
{
    ///Scrolls the content area of a container object in order to display the control within the visible region
    ///(viewport) of the container.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ScrollIntoView();
}

///Provides access to controls that act as containers for a collection of individual, selectable child items. The
///children of this control must implement ISelectionItemProvider.
@GUID("FB8B03AF-3BDF-48D4-BD36-1A65793BE168")
interface ISelectionProvider : IUnknown
{
    ///Retrieves a Microsoft UI Automation provider for each child element that is selected.
    ///Params:
    ///    pRetVal = Type: <b>SAFEARRAY**</b> Receives a pointer to a SAFEARRAY that contains an array of pointers to the
    ///              IRawElementProviderSimple interfaces of the selected elements. This parameter is passed uninitialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSelection(SAFEARRAY** pRetVal);
    ///Indicates whether the Microsoft UI Automation provider allows more than one child element to be selected
    ///concurrently. This property is read-only.
    HRESULT get_CanSelectMultiple(int* pRetVal);
    ///Indicates whether the Microsoft UI Automation provider requires at least one child element to be selected. This
    ///property is read-only.
    HRESULT get_IsSelectionRequired(int* pRetVal);
}

///Extends the ISelectionItemProvider interface to provide information about selected items.
@GUID("14F68475-EE1C-44F6-A869-D239381F0FE7")
interface ISelectionProvider2 : ISelectionProvider
{
    ///Gets the first item in a group of selected items. This property is read-only.
    HRESULT get_FirstSelectedItem(IRawElementProviderSimple* retVal);
    ///Gets the last item in a group of selected items. This property is read-only.
    HRESULT get_LastSelectedItem(IRawElementProviderSimple* retVal);
    ///Gets the currently selected item. This property is read-only.
    HRESULT get_CurrentSelectedItem(IRawElementProviderSimple* retVal);
    ///Gets the number of selected items. This property is read-only.
    HRESULT get_ItemCount(int* retVal);
}

///Provides access to controls that act as scrollable containers for a collection of child objects. The children of this
///control must implement IScrollItemProvider.
@GUID("B38B8077-1FC3-42A5-8CAE-D40C2215055A")
interface IScrollProvider : IUnknown
{
    ///Scrolls the visible region of the content area horizontally and vertically.
    ///Params:
    ///    arg1 = Type: <b>ScrollAmount</b> The horizontal scrolling increment that is specific to the control.
    ///    arg2 = Type: <b>ScrollAmount</b> The vertical scrolling increment that is specific to the control.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Scroll(ScrollAmount horizontalAmount, ScrollAmount verticalAmount);
    ///Sets the horizontal and vertical scroll position as a percentage of the total content area within the control.
    ///Params:
    ///    horizontalPercent = Type: <b>double</b> The horizontal position as a percentage of the content area's total range, or
    ///                        <b>UIA_ScrollPatternNoScroll</b> if there is no horizontal scrolling.
    ///    verticalPercent = Type: <b>double</b> The vertical position as a percentage of the content area's total range, or
    ///                      <b>UIA_ScrollPatternNoScroll</b> if there is no vertical scrolling.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetScrollPercent(double horizontalPercent, double verticalPercent);
    ///Specifies the horizontal scroll position. This property is read-only.
    HRESULT get_HorizontalScrollPercent(double* pRetVal);
    ///Specifies the vertical scroll position. This property is read-only.
    HRESULT get_VerticalScrollPercent(double* pRetVal);
    ///Specifies the horizontal size of the viewable region. This property is read-only.
    HRESULT get_HorizontalViewSize(double* pRetVal);
    ///Specifies the vertical size of the viewable region. This property is read-only.
    HRESULT get_VerticalViewSize(double* pRetVal);
    ///Indicates whether the control can scroll horizontally. This property is read-only.
    HRESULT get_HorizontallyScrollable(int* pRetVal);
    ///Indicates whether the control can scroll vertically. This property is read-only.
    HRESULT get_VerticallyScrollable(int* pRetVal);
}

///Provides access to individual, selectable child controls of containers that implement ISelectionProvider.
@GUID("2ACAD808-B2D4-452D-A407-91FF1AD167B2")
interface ISelectionItemProvider : IUnknown
{
    ///Deselects any selected items and then selects the current element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Select();
    ///Adds the current element to the collection of selected items.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddToSelection();
    ///Removes the current element from the collection of selected items.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RemoveFromSelection();
    ///Indicates whether an item is selected. This property is read-only.
    HRESULT get_IsSelected(int* pRetVal);
    ///Specifies the provider that implements ISelectionProvider and acts as the container for the calling object. This
    ///property is read-only.
    HRESULT get_SelectionContainer(IRawElementProviderSimple* pRetVal);
}

///Enables Microsoft UI Automation client applications to direct the mouse or keyboard input to a specific UI element.
@GUID("29DB1A06-02CE-4CF7-9B42-565D4FAB20EE")
interface ISynchronizedInputProvider : IUnknown
{
    ///Starts listening for input of the specified type.
    ///Params:
    ///    inputType = Type: <b>SynchronizedInputType</b> The type of input that is requested to be synchronized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT StartListening(SynchronizedInputType inputType);
    ///Cancels listening for input.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Cancel();
}

///Provides access to controls that act as containers for a collection of child elements. The children of this element
///must implement ITableItemProvider and be organized in a two-dimensional logical coordinate system that can be
///traversed by using the keyboard.
@GUID("9C860395-97B3-490A-B52A-858CC22AF166")
interface ITableProvider : IUnknown
{
    ///Gets a collection of Microsoft UI Automation providers that represents all the row headers in a table.
    ///Params:
    ///    pRetVal = Type: <b>SAFEARRAY**</b> Receives a pointer to a SAFEARRAY that contains an array of pointers to the
    ///              IRawElementProviderSimple interfaces of the row headers. This parameter is passed uninitialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetRowHeaders(SAFEARRAY** pRetVal);
    ///Gets a collection of Microsoft UI Automation providers that represents all the column headers in a table.
    ///Params:
    ///    pRetVal = Type: <b>SAFEARRAY**</b> Receives a pointer to a SAFEARRAY that contains an array of pointers to the
    ///              IRawElementProviderSimple interfaces of the column headers. This parameter is passed uninitialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetColumnHeaders(SAFEARRAY** pRetVal);
    ///Specifies the primary direction of traversal for the table. This property is read-only.
    HRESULT get_RowOrColumnMajor(RowOrColumnMajor* pRetVal);
}

///Provides access to child controls of containers that implement ITableProvider.
@GUID("B9734FA6-771F-4D78-9C90-2517999349CD")
interface ITableItemProvider : IUnknown
{
    ///Retrieves a collection of Microsoft UI Automation provider representing all the row headers associated with a
    ///table item or cell.
    ///Params:
    ///    pRetVal = Type: <b>SAFEARRAY**</b> Receives a pointer to a SAFEARRAY that contains an array of pointers to the
    ///              IRawElementProviderSimple interfaces of the row headers. This parameter is passed uninitialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetRowHeaderItems(SAFEARRAY** pRetVal);
    ///Retrieves a collection of Microsoft UI Automation provider representing all the column headers associated with a
    ///table item or cell.
    ///Params:
    ///    pRetVal = Type: <b>SAFEARRAY**</b> Receives a pointer to a SAFEARRAY that contains an array of pointers to the
    ///              IRawElementProviderSimple interfaces of the column headers. This parameter is passed uninitialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetColumnHeaderItems(SAFEARRAY** pRetVal);
}

///Provides access to controls that can cycle through a set of states and maintain a state after it is set.
@GUID("56D00BD0-C4F4-433C-A836-1A52A57E0892")
interface IToggleProvider : IUnknown
{
    ///Cycles through the toggle states of a control.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Toggle();
    ///Specifies the toggle state of the control. This property is read-only.
    HRESULT get_ToggleState(ToggleState* pRetVal);
}

///Provides access to controls that can be moved, resized, and/or rotated within a two-dimensional space.
@GUID("6829DDC4-4F91-4FFA-B86F-BD3E2987CB4C")
interface ITransformProvider : IUnknown
{
    ///Moves the control.
    ///Params:
    ///    x = Type: <b>double</b> The absolute screen coordinates of the left side of the control.
    ///    y = Type: <b>double</b> The absolute screen coordinates of the top of the control.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Move(double x, double y);
    ///Resizes the control.
    ///Params:
    ///    width = Type: <b>double</b> The new width of the window in pixels.
    ///    height = Type: <b>double</b> The new height of the window in pixels.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Resize(double width, double height);
    ///Rotates the control.
    ///Params:
    ///    degrees = Type: <b>double</b> The number of degrees to rotate the control. A positive number rotates clockwise; a
    ///              negative number rotates counterclockwise.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Rotate(double degrees);
    ///Indicates whether the control can be moved. This property is read-only.
    HRESULT get_CanMove(int* pRetVal);
    ///Indicates whether the control can be resized. This property is read-only.
    HRESULT get_CanResize(int* pRetVal);
    ///Indicates whether the control can be rotated. This property is read-only.
    HRESULT get_CanRotate(int* pRetVal);
}

///Provides access to controls that have an intrinsic value that does not span a range, and that can be represented as a
///string.
@GUID("C7935180-6FB3-4201-B174-7DF73ADBF64A")
interface IValueProvider : IUnknown
{
    ///Sets the value of control.
    ///Params:
    ///    val = Type: <b>LPCWSTR</b> The value to set. The provider is responsible for converting the value to the
    ///          appropriate data type.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetValue(const(wchar)* val);
    ///The value of the control. This property is read-only.
    HRESULT get_Value(BSTR* pRetVal);
    ///Indicates whether the value of a control is read-only. This property is read-only.
    HRESULT get_IsReadOnly(int* pRetVal);
}

///Provides access to the fundamental window-based functionality of a control.
@GUID("987DF77B-DB06-4D77-8F8A-86A9C3BB90B9")
interface IWindowProvider : IUnknown
{
    ///Changes the visual state of the window. For example, minimizes or maximizes it.
    ///Params:
    ///    state = Type: <b>WindowVisualState</b> The state of the window.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetVisualState(WindowVisualState state);
    ///Attempts to close the window.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Close();
    ///Causes the calling code to block for the specified time or until the associated process enters an idle state,
    ///whichever completes first.
    ///Params:
    ///    milliseconds = Type: <b>int</b> The amount of time, in milliseconds, to wait for the associated process to become idle. The
    ///                   maximum is Int32.MaxValue.
    ///    pRetVal = Type: <b>BOOL*</b> Receives <b>TRUE</b> if the window has entered the idle state; <b>FALSE</b> if the
    ///              time-out occurred. This parameter is passed uninitialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT WaitForInputIdle(int milliseconds, int* pRetVal);
    ///Indicates whether the window can be maximized. This property is read-only.
    HRESULT get_CanMaximize(int* pRetVal);
    ///Indicates whether the window can be minimized. This property is read-only.
    HRESULT get_CanMinimize(int* pRetVal);
    ///Indicates whether the window is modal. This property is read-only.
    HRESULT get_IsModal(int* pRetVal);
    ///Specifies the visual state of the window; that is, whether the window is normal (restored), minimized, or
    ///maximized. This property is read-only.
    HRESULT get_WindowVisualState(WindowVisualState* pRetVal);
    ///Specifies the current state of the window for the purposes of user interaction. This property is read-only.
    HRESULT get_WindowInteractionState(WindowInteractionState* pRetVal);
    ///Indicates whether the window is the topmost element in the z-order. This property is read-only.
    HRESULT get_IsTopmost(int* pRetVal);
}

///Enables Microsoft UI Automation clients to access the underlying IAccessible implementation of Microsoft Active
///Accessibility elements.
@GUID("E44C3566-915D-4070-99C6-047BFF5A08F5")
interface ILegacyIAccessibleProvider : IUnknown
{
    ///Selects the element.
    ///Params:
    ///    flagsSelect = Type: <b>long</b> Specifies which selection or focus operations are to be performed. This parameter must have
    ///                  a combination of the values described in SELFLAG Constants.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Select(int flagsSelect);
    ///Performs the default action on the control.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DoDefaultAction();
    ///Sets the string value of the control.
    ///Params:
    ///    szValue = Type: <b>LPCWSTR</b> A localized string that contains the value.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetValue(const(wchar)* szValue);
    ///Retrieves an accessible object that corresponds to a UI Automation element that supports the LegacyIAccessible
    ///control pattern.
    ///Params:
    ///    ppAccessible = Type: <b>IAccessible**</b> Receives a pointer to the accessible object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetIAccessible(IAccessible* ppAccessible);
    ///Specifies the child identifier of this element. This property is read-only.
    HRESULT get_ChildId(int* pRetVal);
    ///Specifies the name of this element. This property is read-only.
    HRESULT get_Name(BSTR* pszName);
    ///Specifies the value of this element. This property is read-only.
    HRESULT get_Value(BSTR* pszValue);
    ///Contains the description of this element. This property is read-only.
    HRESULT get_Description(BSTR* pszDescription);
    ///Specifies the role identifier of this element. This property is read-only.
    HRESULT get_Role(uint* pdwRole);
    ///Specifies the state of this element. This property is read-only.
    HRESULT get_State(uint* pdwState);
    ///Specifies a string that contains help information for this element. This property is read-only.
    HRESULT get_Help(BSTR* pszHelp);
    ///Specifies the keyboard shortcut for this element. This property is read-only.
    HRESULT get_KeyboardShortcut(BSTR* pszKeyboardShortcut);
    ///Retrieves the selected item or items in the control.
    ///Params:
    ///    pvarSelectedChildren = Type: <b>SAFEARRAY**</b> Receives a pointer to a SAFEARRAY containing the selected items.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSelection(SAFEARRAY** pvarSelectedChildren);
    ///Contains a description of the default action for this element. This property is read-only.
    HRESULT get_DefaultAction(BSTR* pszDefaultAction);
}

///Provides access to controls that act as containers of other controls, such as a virtual list-view.
@GUID("E747770B-39CE-4382-AB30-D8FB3F336F24")
interface IItemContainerProvider : IUnknown
{
    ///Retrieves an element within a containing element, based on a specified property value.
    ///Params:
    ///    pStartAfter = Type: <b>IRawElementProviderSimple*</b> The UI Automation provider of the element after which the search
    ///                  begins, or <b>NULL</b> to search all elements.
    ///    propertyId = Type: <b>PROPERTYID</b> The property identifier. For a list of property IDs, see Property Identifiers.
    ///    value = Type: <b>VARIANT</b> The value of the property.
    ///    pFound = Type: <b>IRawElementProviderSimple**</b> Receives a pointer to the UI Automation provider of the element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT FindItemByProperty(IRawElementProviderSimple pStartAfter, int propertyId, VARIANT value, 
                               IRawElementProviderSimple* pFound);
}

///Provides access to virtualized items, which are items that are represented by placeholder automation elements in the
///Microsoft UI Automation tree.
@GUID("CB98B665-2D35-4FAC-AD35-F3C60D0C0B8B")
interface IVirtualizedItemProvider : IUnknown
{
    ///Makes the virtual item fully accessible as a UI Automation element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Realize();
}

///Provides access to the underlying object model implemented by a control or application. Assistive technology
///applications can use the object model to directly access the content of the control or application.
@GUID("3AD86EBD-F5EF-483D-BB18-B1042A475D64")
interface IObjectModelProvider : IUnknown
{
    ///Retrieves an interface used to access the underlying object model of the provider.
    ///Params:
    ///    ppUnknown = Type: <b>IUnknown**</b> Receives an interface for accessing the underlying object model.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetUnderlyingObjectModel(IUnknown* ppUnknown);
}

///Exposes the properties of an annotation in a document.
@GUID("F95C7E80-BD63-4601-9782-445EBFF011FC")
interface IAnnotationProvider : IUnknown
{
    ///The annotation type identifier of this annotation. This property is read-only.
    HRESULT get_AnnotationTypeId(int* retVal);
    ///The name of this annotation type. This property is read-only.
    HRESULT get_AnnotationTypeName(BSTR* retVal);
    ///The name of the annotation author. This property is read-only.
    HRESULT get_Author(BSTR* retVal);
    ///The date and time when this annotation was created. This property is read-only.
    HRESULT get_DateTime(BSTR* retVal);
    ///The UI Automation element that is being annotated. This property is read-only.
    HRESULT get_Target(IRawElementProviderSimple* retVal);
}

///Provides access to the visual styles associated with the content of a document.
@GUID("19B6B649-F5D7-4A6D-BDCB-129252BE588A")
interface IStylesProvider : IUnknown
{
    ///Identifies the visual style of an element in a document. This property is read-only.
    HRESULT get_StyleId(int* retVal);
    ///Specifies the name of the visual style of an element in a document. This property is read-only.
    HRESULT get_StyleName(BSTR* retVal);
    ///Specifies the fill color of an element in a document. This property is read-only.
    HRESULT get_FillColor(int* retVal);
    ///Specifies the fill pattern style of an element in a document. This property is read-only.
    HRESULT get_FillPatternStyle(BSTR* retVal);
    ///Specifies the shape of an element in a document. This property is read-only.
    HRESULT get_Shape(BSTR* retVal);
    ///Specifies the color of the pattern used to fill an element in a document. This property is read-only.
    HRESULT get_FillPatternColor(int* retVal);
    ///Contains additional properties that are not included in this control pattern, but that provide information about
    ///the document content that might be useful to the user. This property is read-only.
    HRESULT get_ExtendedProperties(BSTR* retVal);
}

///Provides access to items (cells) in a spreadsheet.
@GUID("6F6B5D35-5525-4F80-B758-85473832FFC7")
interface ISpreadsheetProvider : IUnknown
{
    ///Exposes a UI Automation element that represents the spreadsheet cell that has the specified name.
    ///Params:
    ///    name = Type: <b>LPCWSTR</b> The name of the target cell.
    ///    pRetVal = Type: <b>IRawElementProviderSimple**</b> Receives the element that represents the target cell.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetItemByName(const(wchar)* name, IRawElementProviderSimple* pRetVal);
}

///Provides access to information about an item (cell) in a spreadsheet.
@GUID("EAED4660-7B3D-4879-A2E6-365CE603F3D0")
interface ISpreadsheetItemProvider : IUnknown
{
    ///Specifies the formula for this spreadsheet cell. This property is read-only.
    HRESULT get_Formula(BSTR* pRetVal);
    ///Retrieves an array of objects that represent the annotations associated with this spreadsheet cell.
    ///Params:
    ///    pRetVal = Type: <b>SAFEARRAY**</b> Receives an array of IRawElementProviderSimple interfaces that represent the
    ///              annotations associated with the spreadsheet cell.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetAnnotationObjects(SAFEARRAY** pRetVal);
    ///Retrieves an array of annotation type identifiers indicating the types of annotations that are associated with
    ///this spreadsheet cell.
    ///Params:
    ///    pRetVal = Type: <b>SAFEARRAY**</b> Receives an array of annotation type identifiers, one for each type of annotation
    ///              associated with the spreadsheet cell. For a list of possible values, see Annotation Type Identifiers.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetAnnotationTypes(SAFEARRAY** pRetVal);
}

///Extends the ITransformProvider interface to enable Microsoft UI Automation providers to expose properties to support
///the viewport zooming functionality of a control.
@GUID("4758742F-7AC2-460C-BC48-09FC09308A93")
interface ITransformProvider2 : ITransformProvider
{
    ///Zooms the viewport of the control.
    ///Params:
    ///    zoom = Type: <b>double</b> The amount to zoom the viewport, specified as a percentage. The provider should zoom the
    ///           viewport to the nearest supported value.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Zoom(double zoom);
    ///Indicates whether the control supports zooming of its viewport. This property is read-only.
    HRESULT get_CanZoom(int* pRetVal);
    ///Retrieves the current zoom level of the element. This property is read-only.
    HRESULT get_ZoomLevel(double* pRetVal);
    ///Retrieves the minimum zoom level of the element. This property is read-only.
    HRESULT get_ZoomMinimum(double* pRetVal);
    ///Retrieves the maximum zoom level of the element. This property is read-only.
    HRESULT get_ZoomMaximum(double* pRetVal);
    ///Zooms the viewport of the control by the specified logical unit.
    ///Params:
    ///    zoomUnit = The logical unit by which to increase or decrease the zoom of the viewport.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ZoomByUnit(ZoomUnit zoomUnit);
}

///Enables a Microsoft UI Automation element to describe itself as an element that can be dragged as part of a
///drag-and-drop operation.
@GUID("6AA7BBBB-7FF9-497D-904F-D20B897929D8")
interface IDragProvider : IUnknown
{
    ///Indicates whether the element has been grabbed as part of a drag-and-drop operation. This property is read-only.
    HRESULT get_IsGrabbed(int* pRetVal);
    ///Retrieves a localized string that indicates what happens when this element is dropped as part of a drag-drop
    ///operation. This property is read-only.
    HRESULT get_DropEffect(BSTR* pRetVal);
    ///Retrieves an array of localized strings that enumerate the full set of effects that can happen when this element
    ///is dropped as part of a drag-and-drop operation. This property is read-only.
    HRESULT get_DropEffects(SAFEARRAY** pRetVal);
    ///Retrieves the collection of elements that are being dragged as part of a drag operation.
    ///Params:
    ///    pRetVal = An array of VT_UNKNOWN pointers to the IRawElementProviderSimple interfaces of the elements that are being
    ///              dragged. This parameter is <b>NULL</b> if only a single item is being dragged.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetGrabbedItems(SAFEARRAY** pRetVal);
}

///Enables a Microsoft UI Automation element to describe itself as an element that can receive a drop of a dragged
///element as part of a UI Automation drag-and-drop operation.
@GUID("BAE82BFD-358A-481C-85A0-D8B4D90A5D61")
interface IDropTargetProvider : IUnknown
{
    ///Retrieves a localized string that describes the effect that happens when the user drops the grabbed element on
    ///this drop target. This property is read-only.
    HRESULT get_DropTargetEffect(BSTR* pRetVal);
    ///Retrieves an array of localized strings that enumerate the full set of effects that can happen when the user
    ///drops a grabbed element on this drop target as part of a drag-and-drop operation. This property is read-only.
    HRESULT get_DropTargetEffects(SAFEARRAY** pRetVal);
}

///Provides access to a span of continuous text in a text container that implements ITextProvider or ITextProvider2.
@GUID("5347AD7B-C355-46F8-AFF5-909033582F63")
interface ITextRangeProvider : IUnknown
{
    ///Returns a new ITextRangeProvider identical to the original <b>ITextRangeProvider</b> and inheriting all
    ///properties of the original.
    ///Params:
    ///    pRetVal = Type: <b>ITextRangeProvider**</b> Receives a pointer to the copy of the text range. A null reference is never
    ///              returned. This parameter is passed uninitialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Clone(ITextRangeProvider* pRetVal);
    ///Retrieves a value that specifies whether this text range has the same endpoints as another text range.
    ///Params:
    ///    range = Type: <b>ITextRangeProvider*</b> The text range to compare with this one.
    ///    pRetVal = Type: <b>BOOL*</b> Receives <b>TRUE</b> if the text ranges have the same endpoints, or <b>FALSE</b> if they
    ///              do not.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Compare(ITextRangeProvider range, int* pRetVal);
    ///Returns a value that specifies whether two text ranges have identical endpoints.
    ///Params:
    ///    arg1 = Type: <b>TextPatternRangeEndpoint</b> The endpoint (starting or ending) of the caller's text range.
    ///    targetRange = Type: <b>ITextRangeProvider*</b> The text range to be compared.
    ///    arg3 = Type: <b>TextPatternRangeEndpoint</b> The endpoint (starting or ending) of the target text range.
    ///    pRetVal = Type: <b>int*</b> Receives a value that indicates whether the two text ranges have identical endpoints. This
    ///              parameter is passed uninitialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CompareEndpoints(TextPatternRangeEndpoint endpoint, ITextRangeProvider targetRange, 
                             TextPatternRangeEndpoint targetEndpoint, int* pRetVal);
    ///Normalizes the text range by the specified text unit. The range is expanded if it is smaller than the specified
    ///unit, or shortened if it is longer than the specified unit.
    ///Params:
    ///    unit = Type: <b>TextUnit</b> The type of text units, such as character, word, paragraph, and so on.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ExpandToEnclosingUnit(TextUnit unit);
    ///Returns a text range subset that has the specified text attribute value.
    ///Params:
    ///    attributeId = Type: <b>TEXTATTRIBUTEID</b> The identifier of the text attribute. For a list of text attribute IDs, see Text
    ///                  Attribute Identifiers.
    ///    val = Type: <b>VARIANT</b> The attribute value to search for. This value must match the type specified for the
    ///          attribute.
    ///    backward = Type: <b>BOOL</b> <b>TRUE</b> if the last occurring text range should be returned instead of the first;
    ///               otherwise <b>FALSE</b>.
    ///    pRetVal = Type: <b>ITextRangeProvider**</b> Receives a pointer to the text range having a matching attribute and
    ///              attribute value; otherwise <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT FindAttribute(int attributeId, VARIANT val, BOOL backward, ITextRangeProvider* pRetVal);
    HRESULT FindTextA(BSTR text, BOOL backward, BOOL ignoreCase, ITextRangeProvider* pRetVal);
    ///Retrieves the value of the specified text attribute across the text range.
    ///Params:
    ///    attributeId = Type: <b>TEXTATTRIBUTEID</b> The identifier of the text attribute. For a list of text attribute IDs, see Text
    ///                  Attribute Identifiers.
    ///    pRetVal = Type: <b>VARIANT*</b> Receives one of the following. <ul> <li>The address of an object representing the value
    ///              of the specified attribute. The data type of the value varies depending on the specified attribute. For
    ///              example, if <i>attributeId</i> is UIA_FontNameAttributeId, <b>GetAttributeValue</b> returns a string that
    ///              represents the font name of the text range, but if <i>attributeId</i> is UIA_IsItalicAttributeId,
    ///              <b>GetAttributeValue</b> returns a boolean. </li> <li>The address of the value retrieved by the
    ///              UiaGetReservedMixedAttributeValue function, if the value of the specified attribute varies over the text
    ///              range.</li> <li>The address of the value retrieved by the UiaGetReservedNotSupportedValue function, if the
    ///              specified attribute is not supported by the provider or the control. </li> </ul> This parameter is passed
    ///              uninitialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetAttributeValue(int attributeId, VARIANT* pRetVal);
    ///Retrieves a collection of bounding rectangles for each fully or partially visible line of text in a text range.
    ///Params:
    ///    pRetVal = Type: <b>SAFEARRAY**</b> Receives a pointer to one of the following. <ul> <li>An array of bounding rectangles
    ///              for each full or partial line of text in a text range. </li> <li>An empty array for a degenerate range. </li>
    ///              <li>An empty array for a text range that has screen coordinates placing it completely off-screen, scrolled
    ///              out of view, or obscured by an overlapping window. </li> </ul> This parameter is passed uninitialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetBoundingRectangles(SAFEARRAY** pRetVal);
    ///Returns the innermost element that encloses the specified text range.
    ///Params:
    ///    pRetVal = Type: **[IRawElementProviderSimple](nn-uiautomationcore-irawelementprovidersimple.md)\*\*** The UI Automation
    ///              provider of the innermost element that encloses the specified
    ///              [ITextRangeProvider](nn-uiautomationcore-itextrangeprovider.md). > [!NOTE] > The enclosing element can span
    ///              more than just the specified [ITextRangeProvider](nn-uiautomationcore-itextrangeprovider.md). If no enclosing
    ///              element is found, the [ITextProvider](nn-uiautomationcore-itextprovider.md) parent of the
    ///              [ITextRangeProvider](nn-uiautomationcore-itextrangeprovider.md) is returned. This parameter is passed
    ///              uninitialized.
    ///Returns:
    ///    Type: **[HRESULT](/windows/desktop/WinProg/windows-data-types)** If this method succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an **HRESULT** error code.
    ///    
    HRESULT GetEnclosingElement(IRawElementProviderSimple* pRetVal);
    ///Retrieves the plain text of the range.
    ///Params:
    ///    maxLength = Type: <b>int</b> The maximum length of the string to return. Use -1 if no limit is required.
    ///    pRetVal = Type: <b>BSTR*</b> Receives the plain text of the text range, possibly truncated at the specified maximum
    ///              length. This parameter is passed uninitialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetText(int maxLength, BSTR* pRetVal);
    ///Moves the text range forward or backward by the specified number of text units.
    ///Params:
    ///    arg1 = Type: <b>TextUnit</b> The type of text units, such as character, word, paragraph, and so on.
    ///    count = Type: <b>int</b> The number of text units to move. A positive value moves the text range forward. A negative
    ///            value moves the text range backward. Zero has no effect.
    ///    pRetVal = Type: <b>int*</b> The number of text units actually moved. This can be less than the number requested if
    ///              either of the new text range endpoints is greater than or less than the endpoints retrieved by the
    ///              ITextProvider::DocumentRange method. This value can be negative if navigation is happening in the backward
    ///              direction.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Move(TextUnit unit, int count, int* pRetVal);
    ///Moves one endpoint of the text range the specified number of TextUnit units within the document range.
    ///Params:
    ///    arg1 = Type: <b>TextPatternRangeEndpoint</b> The endpoint to move.
    ///    arg2 = Type: <b>TextUnit</b> The type of text units, such as character, word, paragraph, and so on.
    ///    count = Type: <b>int</b> The number of units to move. A positive value moves the endpoint forward. A negative value
    ///            moves backward. A value of 0 has no effect.
    ///    pRetVal = Type: <b>int*</b> Receives the number of units actually moved, which can be less than the number requested if
    ///              moving the endpoint runs into the beginning or end of the document.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT MoveEndpointByUnit(TextPatternRangeEndpoint endpoint, TextUnit unit, int count, int* pRetVal);
    ///Moves one endpoint of the current text range to the specified endpoint of a second text range.
    ///Params:
    ///    arg1 = Type: <b>TextPatternRangeEndpoint</b> An endpoint (either start or end) of the current text range. This is
    ///           the endpoint to be moved.
    ///    targetRange = Type: <b>ITextRangeProvider*</b> A second text range from the same text provider as the current text range.
    ///    arg3 = Type: <b>TextPatternRangeEndpoint</b> An endpoint (either start or end) of the second text range. The
    ///           <i>endpoint</i> of the current text range is moved to this endpoint.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT MoveEndpointByRange(TextPatternRangeEndpoint endpoint, ITextRangeProvider targetRange, 
                                TextPatternRangeEndpoint targetEndpoint);
    ///Selects the span of text that corresponds to this text range, and removes any previous selection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Select();
    ///Adds the text range to the collection of selected text ranges in a control that supports multiple, disjoint spans
    ///of selected text.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddToSelection();
    ///Removes the text range from the collection of selected text ranges in a control that supports multiple, disjoint
    ///spans of selected text.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RemoveFromSelection();
    ///Causes the text control to scroll vertically until the text range is visible in the viewport.
    ///Params:
    ///    alignToTop = Type: <b>BOOL</b> TRUE if the text control should be scrolled so the text range is flush with the top of the
    ///                 viewport; FALSE if it should be flush with the bottom of the viewport.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ScrollIntoView(BOOL alignToTop);
    ///Retrieves a collection of all elements that are both contained (either partially or completely) within the
    ///specified text range, and are child elements of the [enclosing
    ///element](nf-uiautomationcore-itextrangeprovider-getenclosingelement.md) for the specified text range.
    ///Params:
    ///    pRetVal = Type: **[SAFEARRAY](../oaidl/ns-oaidl-safearray.md)\*\*** An array of pointers to the
    ///              IRawElementProviderSimple interfaces for all child elements that are enclosed by the text range (sorted by
    ///              the Start endpoint of their ranges). If the text range does not include any child elements, an empty
    ///              collection is returned. This parameter is passed uninitialized.
    ///Returns:
    ///    Type: **[HRESULT](/windows/desktop/WinProg/windows-data-types)** If this method succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an **HRESULT** error code.
    ///    
    HRESULT GetChildren(SAFEARRAY** pRetVal);
}

///Provides access to controls that contain text.
@GUID("3589C92C-63F3-4367-99BB-ADA653B77CF2")
interface ITextProvider : IUnknown
{
    ///Retrieves a collection of text ranges that represents the currently selected text in a text-based control.
    ///Params:
    ///    pRetVal = Type: <b>SAFEARRAY**</b> Receives the address of an array of pointers to the ITextRangeProvider interfaces of
    ///              the text ranges, one for each selected span of text. This parameter is passed uninitialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSelection(SAFEARRAY** pRetVal);
    ///Retrieves an array of disjoint text ranges from a text-based control where each text range represents a
    ///contiguous span of visible text.
    ///Params:
    ///    pRetVal = Type: <b>SAFEARRAY**</b> Receives the address of an array of pointers to the ITextRangeProvider interfaces of
    ///              the visible text ranges or an empty array. A <b>NULL</b> reference is never returned. This parameter is
    ///              passed uninitialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetVisibleRanges(SAFEARRAY** pRetVal);
    ///Retrieves a text range that encloses the specified child element (for example, an image, hyperlink, or other
    ///embedded object).
    ///Params:
    ///    childElement = Type: **[IRawElementProviderSimple](nn-uiautomationcore-irawelementprovidersimple.md)\*** The UI Automation
    ///                   provider of the specified child element.
    ///    pRetVal = Type: **[ITextRangeProvider](nn-uiautomationcore-itextrangeprovider.md)\*\*** The text range that encloses
    ///              the child element. This range completely encloses the content of the child element such that: 1.
    ///              [ITextRangeProvider::GetEnclosingElement](nf-uiautomationcore-itextrangeprovider-getenclosingelement.md)
    ///              returns the child element itself, or the innermost descendant of the child element that shares the same text
    ///              range as the child element 2.
    ///              [ITextRangeProvider::GetChildren](nf-uiautomationcore-itextrangeprovider-getchildren.md) returns children of
    ///              the element from (1) that are completely enclosed within the range 3. Both endpoints of the range are at the
    ///              boundaries of the child element This parameter is passed uninitialized.
    ///Returns:
    ///    Type: **[HRESULT](/windows/desktop/WinProg/windows-data-types)** If this method succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an **HRESULT** error code. > [!NOTE] > **E_INVALIDARG** is returned if
    ///    *childElement* is not a descendent of an [ITextProvider](nn-uiautomationcore-itextprovider.md), or is not
    ///    enclosed by a valid text range.
    ///    
    HRESULT RangeFromChild(IRawElementProviderSimple childElement, ITextRangeProvider* pRetVal);
    ///Returns the degenerate (empty) text range nearest to the specified screen coordinates.
    ///Params:
    ///    point = Type: <b>UiaPoint</b> The location in screen coordinates.
    ///    pRetVal = Type: <b>ITextRangeProvider**</b> Receives a pointer to the degenerate (empty) text range nearest the
    ///              specified location. This parameter is passed uninitialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RangeFromPoint(UiaPoint point, ITextRangeProvider* pRetVal);
    ///Retrieves a text range that encloses the main text of a document. This property is read-only.
    HRESULT get_DocumentRange(ITextRangeProvider* pRetVal);
    ///Retrieves a value that specifies the type of text selection that is supported by the control. This property is
    ///read-only.
    HRESULT get_SupportedTextSelection(SupportedTextSelection* pRetVal);
}

///Extends the ITextProvider interface to enable Microsoft UI Automation providers to expose textual content that is the
///target of an annotation, and information about a caret that belongs to the provider.
@GUID("0DC5E6ED-3E16-4BF1-8F9A-A979878BC195")
interface ITextProvider2 : ITextProvider
{
    ///Exposes a text range that contains the text that is the target of the annotation associated with the specified
    ///annotation element.
    ///Params:
    ///    annotationElement = Type: <b>IRawElementProviderSimple*</b> The provider for an element that implements the IAnnotationProvider
    ///                        interface. The annotation element is a sibling of the element that implements the ITextProvider2 interface
    ///                        for the document.
    ///    pRetVal = Type: <b>ITextRangeProvider**</b> Receives a text range that contains the annotation target text.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RangeFromAnnotation(IRawElementProviderSimple annotationElement, ITextRangeProvider* pRetVal);
    ///Provides a zero-length text range at the location of the caret that belongs to the text-based control.
    ///Params:
    ///    isActive = Type: <b>BOOL*</b> <b>TRUE</b> if the text-based control that contains the caret has keyboard focus,
    ///               otherwise <b>FALSE</b>.
    ///    pRetVal = Type: <b>ITextRangeProvider**</b> A text range that represents the current location of the caret that belongs
    ///              to the text-based control.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCaretRange(int* isActive, ITextRangeProvider* pRetVal);
}

///Extends the ITextProvider interface to enable Microsoft UI Automation providers to expose programmatic text-edit
///actions.
@GUID("EA3605B4-3A05-400E-B5F9-4E91B40F6176")
interface ITextEditProvider : ITextProvider
{
    ///Returns the active composition.
    ///Params:
    ///    pRetVal = Type: <b>ITextRangeProvider**</b> Pointer to the range of the current conversion (none if there is no
    ///              conversion).
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetActiveComposition(ITextRangeProvider* pRetVal);
    ///Returns the current conversion target range.
    ///Params:
    ///    pRetVal = Type: <b>ITextRangeProvider**</b> Pointer to the conversion target range (none if there is no conversion).
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetConversionTarget(ITextRangeProvider* pRetVal);
}

///Extends the ITextRangeProvider interface to enable Microsoft UI Automation providers to invoke context menus.
@GUID("9BBCE42C-1921-4F18-89CA-DBA1910A0386")
interface ITextRangeProvider2 : ITextRangeProvider
{
    ///Programmatically invokes a context menu on the target element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ShowContextMenu();
}

///Provides access to a text-based control (or an object embedded in text) that is a child or descendant of another
///text-based control.
@GUID("4C2DE2B9-C88F-4F88-A111-F1D336B7D1A9")
interface ITextChildProvider : IUnknown
{
    ///Retrieves this element's nearest ancestor provider that supports the Text control pattern. This property is
    ///read-only.
    HRESULT get_TextContainer(IRawElementProviderSimple* pRetVal);
    ///Retrieves a text range that encloses this child element. This property is read-only.
    HRESULT get_TextRange(ITextRangeProvider* pRetVal);
}

@GUID("2062A28A-8C07-4B94-8E12-7037C622AEB8")
interface ICustomNavigationProvider : IUnknown
{
    HRESULT Navigate(NavigateDirection direction, IRawElementProviderSimple* pRetVal);
}

///Represents a control pattern object. The client API wrapper uses this interface to implement all property and method
///calls in terms of the GetProperty and CallMethod methods.
@GUID("C03A7FE4-9431-409F-BED8-AE7C2299BC8D")
interface IUIAutomationPatternInstance : IUnknown
{
    ///The client wrapper object implements the <b>IUIAutomation::get_Current</b><i>X</i> and
    ///<b>IUIAutomationElement::get_Cached</b><i>X</i> methods by calling this function, specifying the property by
    ///index.
    ///Params:
    ///    index = Type: <b>UINT</b> The index of the property.
    ///    cached = Type: <b>BOOL</b> <b>TRUE</b> if the property should be retrieved from the cache, otherwise <b>FALSE</b>.
    ///    arg3 = Type: <b>UIAutomationType</b> A value indicating the data type of the property.
    ///    pPtr = Type: <b>void*</b> Receives the value of the property.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetProperty(uint index, BOOL cached, UIAutomationType type, void* pPtr);
    ///Client wrapper implements methods by calling this CallMethod function, specifying the parameters as an array of
    ///pointers.
    ///Params:
    ///    index = Type: <b>UINT</b> The index of the method.
    ///    pParams = Type: <b>UIAutomationParameter*</b> A pointer to an array of structures describing the parameters.
    ///    cParams = Type: <b>UINT</b> The count of parameters in <i>pParams</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CallMethod(uint index, const(UIAutomationParameter)* pParams, uint cParams);
}

///Returns a client API wrapper object and to unmarshal property and method requests to an actual provider instance. The
///PatternHandler object is stateless, so this can be implemented by a singleton.
@GUID("D97022F3-A947-465E-8B2A-AC4315FA54E8")
interface IUIAutomationPatternHandler : IUnknown
{
    ///Creates an object that enables a client application to interact with a custom <i>control pattern</i>.
    ///Params:
    ///    pPatternInstance = Type: <b>IUIAutomationPatternInstance*</b> A pointer to the instance of the control pattern that will be used
    ///                       by the wrapper.
    ///    pClientWrapper = Type: <b>IUnknown**</b> Receives a pointer to the wrapper object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateClientWrapper(IUIAutomationPatternInstance pPatternInstance, IUnknown* pClientWrapper);
    ///Dispatches a method or property getter to a custom <i>control pattern</i> provider.
    ///Params:
    ///    pTarget = Type: <b>IUnknown*</b> A pointer to the object that implements the control pattern provider.
    ///    index = Type: <b>UINT</b> The index of the method or property getter.
    ///    pParams = Type: <b>UIAutomationParameter*</b> A pointer to an array of structures that contain information about the
    ///              parameters to be passed.
    ///    cParams = Type: <b>UINT</b> The count of parameters in <i>pParams</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Dispatch(IUnknown pTarget, uint index, const(UIAutomationParameter)* pParams, uint cParams);
}

///Exposes methods for registering new control patterns, properties, and events.
@GUID("8609C4EC-4A1A-4D88-A357-5A66E060E1CF")
interface IUIAutomationRegistrar : IUnknown
{
    ///Registers a third-party property.
    ///Params:
    ///    property = Type: <b>UIAutomationPropertyInfo*</b> A pointer to a structure that contains information about the property
    ///               to register.
    ///    propertyId = Type: <b>PropertyID*</b> Receives the property ID of the newly registered property.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RegisterProperty(const(UIAutomationPropertyInfo)* property, int* propertyId);
    ///Registers a third-party Microsoft UI Automation event.
    ///Params:
    ///    event = Type: <b>UIAutomationEventInfo*</b> A pointer to a structure that contains information about the event to
    ///            register.
    ///    eventId = Type: <b>EVENTID*</b> Receives the event identifier. For a list of event IDs, see Event Identifiers.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RegisterEvent(const(UIAutomationEventInfo)* event, int* eventId);
    ///Registers a third-party control pattern.
    ///Params:
    ///    pattern = Type: <b>UIAutomationPatternInfo*</b> A pointer to a structure that contains information about the control
    ///              pattern to register.
    ///    pPatternId = Type: <b>PATTERNID*</b> Receives the pattern identifier.
    ///    pPatternAvailablePropertyId = Type: <b>PROPERTYID*</b> Receives the property identifier for the pattern. This value can be used with UI
    ///                                  Automation client methods to determine whether the element supports the new pattern. This is equivalent to
    ///                                  values such as UIA_IsInvokePatternAvailablePropertyId.
    ///    propertyIdCount = Type: <b>UINT</b> The number of properties supported by the control pattern.
    ///    pPropertyIds = Type: <b>PROPERTYID*</b> Receives an array of identifiers for properties supported by the pattern.
    ///    eventIdCount = Type: <b>UINT</b> The number of events supported by the control pattern.
    ///    pEventIds = Type: <b>EVENTID*</b> Receives an array of identifiers for events that are raised by the pattern.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RegisterPattern(const(UIAutomationPatternInfo)* pattern, int* pPatternId, 
                            int* pPatternAvailablePropertyId, uint propertyIdCount, char* pPropertyIds, 
                            uint eventIdCount, char* pEventIds);
}

///Exposes methods and properties for a UI Automation element, which represents a UI item.
@GUID("D22108AA-8AC5-49A5-837B-37BBB3D7591E")
interface IUIAutomationElement : IUnknown
{
    ///Sets the keyboard focus to this UI Automation element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetFocus();
    ///Retrieves the unique identifier assigned to the UI element.
    ///Params:
    ///    runtimeId = Type: <b>SAFEARRAY**</b> Receives a pointer to the runtime ID as an array of integers.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetRuntimeId(SAFEARRAY** runtimeId);
    ///Retrieves the first child or descendant element that matches the specified condition.
    ///Params:
    ///    arg1 = Type: <b>TreeScope</b> A combination of values specifying the scope of the search.
    ///    condition = Type: <b>IUIAutomationCondition*</b> A pointer to a condition that represents the criteria to match.
    ///    found = Type: <b>IUIAutomationElement**</b> Receives a pointer to the element. <b>NULL</b> is returned if no matching
    ///            element is found.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT FindFirst(TreeScope scope_, IUIAutomationCondition condition, IUIAutomationElement* found);
    ///Returns all UI Automation elements that satisfy the specified condition.
    ///Params:
    ///    arg1 = Type: <b>TreeScope</b> A combination of values specifying the scope of the search.
    ///    condition = Type: <b>IUIAutomationCondition*</b> A pointer to a condition that represents the criteria to match.
    ///    found = Type: <b>IUIAutomationElementArray**</b> Receives a pointer to an array of matching elements. Returns an
    ///            empty array if no matching element is found.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT FindAll(TreeScope scope_, IUIAutomationCondition condition, IUIAutomationElementArray* found);
    ///Retrieves the first child or descendant element that matches the specified condition, prefetches the requested
    ///properties and control patterns, and stores the prefetched items in the cache.
    ///Params:
    ///    arg1 = Type: <b>TreeScope</b> A combination of values specifying the scope of the search.
    ///    condition = Type: <b>IUIAutomationCondition*</b> A pointer to a condition that represents the criteria to match.
    ///    cacheRequest = Type: <b>IUIAutomationCacheRequest*</b> A pointer to a cache request that specifies the control patterns and
    ///                   properties to include in the cache.
    ///    found = Type: <b>IUIAutomationElement**</b> Receives a pointer to the matching element, or <b>NULL</b> if no matching
    ///            element is found.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT FindFirstBuildCache(TreeScope scope_, IUIAutomationCondition condition, 
                                IUIAutomationCacheRequest cacheRequest, IUIAutomationElement* found);
    ///Returns all UI Automation elements that satisfy the specified condition, prefetches the requested properties and
    ///control patterns, and stores the prefetched items in the cache.
    ///Params:
    ///    arg1 = Type: <b>TreeScope</b> A combination of values specifying the scope of the search.
    ///    condition = Type: <b>IUIAutomationCondition*</b> A pointer to a condition that represents the criteria to match.
    ///    cacheRequest = Type: <b>IUIAutomationCacheRequest*</b> A pointer to a cache request that specifies the control patterns and
    ///                   properties to include in the cache.
    ///    found = Type: <b>IUIAutomationElementArray**</b> Receives a pointer to an array of matching elements. If there are no
    ///            matches, <b>NULL</b> is returned.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT FindAllBuildCache(TreeScope scope_, IUIAutomationCondition condition, 
                              IUIAutomationCacheRequest cacheRequest, IUIAutomationElementArray* found);
    ///Retrieves a new UI Automation element with an updated cache.
    ///Params:
    ///    cacheRequest = Type: <b>IUIAutomationCacheRequest*</b> A pointer to a cache request that specifies the control patterns and
    ///                   properties to include in the cache.
    ///    updatedElement = Type: <b>IUIAutomationElement**</b> Receives a pointer to the new UI Automation element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT BuildUpdatedCache(IUIAutomationCacheRequest cacheRequest, IUIAutomationElement* updatedElement);
    ///Retrieves the current value of a property for this UI Automation element.
    ///Params:
    ///    propertyId = Type: <b>PROPERTYID</b> The identifier of the property. For a list of property IDs, see Property Identifiers.
    ///    retVal = Type: <b>VARIANT*</b> Receives the value of the property.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCurrentPropertyValue(int propertyId, VARIANT* retVal);
    ///Retrieves a property value for this UI Automation element, optionally ignoring any default value.
    ///Params:
    ///    propertyId = Type: <b>PROPERTYID</b> The identifier of the property. For a list of property IDs, see Property Identifiers.
    ///    ignoreDefaultValue = Type: <b>BOOL</b> A value that specifies whether a default value should be ignored if the specified property
    ///                         is not supported: <b>TRUE</b> if the default value is not to be returned, or <b>FALSE</b> if it is to be
    ///                         returned.
    ///    retVal = Type: <b>VARIANT*</b> Receives the property value.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCurrentPropertyValueEx(int propertyId, BOOL ignoreDefaultValue, VARIANT* retVal);
    ///Retrieves a property value from the cache for this UI Automation element.
    ///Params:
    ///    propertyId = Type: <b>PROPERTYID</b> The identifier of the property. For a list of property IDs, see Property Identifiers.
    ///    retVal = Type: <b>VARIANT*</b> Receives the value of the cached property.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCachedPropertyValue(int propertyId, VARIANT* retVal);
    ///Retrieves a property value from the cache for this UI Automation element, optionally ignoring any default value.
    ///Params:
    ///    propertyId = Type: <b>PROPERTYID</b> The identifier of the property. For a list of property IDs, see Property Identifiers.
    ///    ignoreDefaultValue = Type: <b>BOOL</b> A value that specifies whether a default value should be ignored if the specified property
    ///                         is not supported: <b>TRUE</b> if the default value is not to be returned, or <b>FALSE</b> if it is to be
    ///                         returned.
    ///    retVal = Type: <b>VARIANT*</b> Receives the value of the property.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCachedPropertyValueEx(int propertyId, BOOL ignoreDefaultValue, VARIANT* retVal);
    ///Retrieves the control pattern interface of the specified pattern on this UI Automation element.
    ///Params:
    ///    patternId = Type: <b>PATTERNID</b> The identifier of the control pattern. For a list of control pattern IDs, see Control
    ///                Pattern Identifiers.
    ///    riid = Type: <b>REFIID</b> A reference to the IID of the interface to retrieve through <i>ppv</i>.
    ///    patternObject = Type: <b>void**</b> Receives the interface pointer requested in <i>riid</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCurrentPatternAs(int patternId, const(GUID)* riid, void** patternObject);
    ///Retrieves the control pattern interface of the specified pattern from the cache of this UI Automation element.
    ///Params:
    ///    patternId = Type: <b>PATTERNID</b> The identifier of the control pattern. For a list of control pattern IDs, see Control
    ///                Pattern Identifiers.
    ///    riid = Type: <b>REFIID</b> A reference to the IID of the interface to retrieve through <i>ppv</i>.
    ///    patternObject = Type: <b>void**</b> Receives the interface pointer requested in <i>riid</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCachedPatternAs(int patternId, const(GUID)* riid, void** patternObject);
    ///Retrieves the IUnknown interface of the specified control pattern on this UI Automation element.
    ///Params:
    ///    patternId = Type: <b>PATTERNID</b> The identifier of the control pattern. For a list of control pattern IDs, see Control
    ///                Pattern Identifiers.
    ///    patternObject = Type: <b>IUnknown**</b> Receives a pointer to an IUnknown interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCurrentPattern(int patternId, IUnknown* patternObject);
    ///Retrieves from the cache the IUnknown interface of the specified control pattern of this UI Automation element.
    ///Params:
    ///    patternId = Type: <b>PATTERNID</b> The identifier of the control pattern. For a list of control pattern IDs, see Control
    ///                Pattern Identifiers.
    ///    patternObject = Type: <b>IUnknown**</b> Receives a pointer to an IUnknown interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCachedPattern(int patternId, IUnknown* patternObject);
    ///Retrieves from the cache the parent of this UI Automation element.
    ///Params:
    ///    parent = Type: <b>IUIAutomationElement**</b> Receives a pointer to the cached parent element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCachedParent(IUIAutomationElement* parent);
    ///Retrieves the cached child elements of this UI Automation element.
    ///Params:
    ///    children = Type: <b>IUIAutomationElementArray**</b> Receives a pointer to a collection of the cached child elements.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCachedChildren(IUIAutomationElementArray* children);
    ///Retrieves the identifier of the process that hosts the element. This property is read-only.
    HRESULT get_CurrentProcessId(int* retVal);
    ///Retrieves the control type of the element. This property is read-only.
    HRESULT get_CurrentControlType(int* retVal);
    ///Retrieves a localized description of the control type of the element. This property is read-only.
    HRESULT get_CurrentLocalizedControlType(BSTR* retVal);
    ///Retrieves the name of the element. This property is read-only.
    HRESULT get_CurrentName(BSTR* retVal);
    ///Retrieves the accelerator key for the element. This property is read-only.
    HRESULT get_CurrentAcceleratorKey(BSTR* retVal);
    ///Retrieves the access key character for the element. This property is read-only.
    HRESULT get_CurrentAccessKey(BSTR* retVal);
    ///Indicates whether the element has keyboard focus. This property is read-only.
    HRESULT get_CurrentHasKeyboardFocus(int* retVal);
    ///Indicates whether the element can accept keyboard focus. This property is read-only.
    HRESULT get_CurrentIsKeyboardFocusable(int* retVal);
    ///Indicates whether the element is enabled. This property is read-only.
    HRESULT get_CurrentIsEnabled(int* retVal);
    ///Retrieves the Microsoft UI Automation identifier of the element. This property is read-only.
    HRESULT get_CurrentAutomationId(BSTR* retVal);
    ///Retrieves the class name of the element. This property is read-only.
    HRESULT get_CurrentClassName(BSTR* retVal);
    ///Retrieves the help text for the element. This property is read-only.
    HRESULT get_CurrentHelpText(BSTR* retVal);
    ///Retrieves the culture identifier for the element. This property is read-only.
    HRESULT get_CurrentCulture(int* retVal);
    ///Indicates whether the element is a control element. This property is read-only.
    HRESULT get_CurrentIsControlElement(int* retVal);
    ///Indicates whether the element is a content element. This property is read-only.
    HRESULT get_CurrentIsContentElement(int* retVal);
    ///Indicates whether the element contains a disguised password. This property is read-only.
    HRESULT get_CurrentIsPassword(int* retVal);
    ///Retrieves the window handle of the element. This property is read-only.
    HRESULT get_CurrentNativeWindowHandle(void** retVal);
    ///Retrieves a description of the type of UI item represented by the element. This property is read-only.
    HRESULT get_CurrentItemType(BSTR* retVal);
    ///Indicates whether the element is off-screen. This property is read-only.
    HRESULT get_CurrentIsOffscreen(int* retVal);
    ///Retrieves a value that indicates the orientation of the element. This property is read-only.
    HRESULT get_CurrentOrientation(OrientationType* retVal);
    ///Retrieves the name of the underlying UI framework. This property is read-only.
    HRESULT get_CurrentFrameworkId(BSTR* retVal);
    ///Indicates whether the element is required to be filled out on a form. This property is read-only.
    HRESULT get_CurrentIsRequiredForForm(int* retVal);
    ///Retrieves the description of the status of an item in an element. This property is read-only.
    HRESULT get_CurrentItemStatus(BSTR* retVal);
    ///Retrieves the coordinates of the rectangle that completely encloses the element. This property is read-only.
    HRESULT get_CurrentBoundingRectangle(RECT* retVal);
    ///Retrieves the element that contains the text label for this element. This property is read-only.
    HRESULT get_CurrentLabeledBy(IUIAutomationElement* retVal);
    ///Retrieves the Accessible Rich Internet Applications (ARIA) role of the element. This property is read-only.
    HRESULT get_CurrentAriaRole(BSTR* retVal);
    ///Retrieves the Accessible Rich Internet Applications (ARIA) properties of the element. This property is read-only.
    HRESULT get_CurrentAriaProperties(BSTR* retVal);
    ///Indicates whether the element contains valid data for a form. This property is read-only.
    HRESULT get_CurrentIsDataValidForForm(int* retVal);
    ///Retrieves an array of elements for which this element serves as the controller. This property is read-only.
    HRESULT get_CurrentControllerFor(IUIAutomationElementArray* retVal);
    ///Retrieves an array of elements that describe this element. This property is read-only.
    HRESULT get_CurrentDescribedBy(IUIAutomationElementArray* retVal);
    ///Retrieves an array of elements that indicates the reading order after the current element. This property is
    ///read-only.
    HRESULT get_CurrentFlowsTo(IUIAutomationElementArray* retVal);
    ///Retrieves a description of the provider for this element. This property is read-only.
    HRESULT get_CurrentProviderDescription(BSTR* retVal);
    ///Retrieves the cached ID of the process that hosts the element. This property is read-only.
    HRESULT get_CachedProcessId(int* retVal);
    ///Retrieves a cached value that indicates the control type of the element. This property is read-only.
    HRESULT get_CachedControlType(int* retVal);
    ///Retrieves the cached localized description of the control type of the element. This property is read-only.
    HRESULT get_CachedLocalizedControlType(BSTR* retVal);
    ///Retrieves the cached name of the element. This property is read-only.
    HRESULT get_CachedName(BSTR* retVal);
    ///Retrieves the cached accelerator key for the element. This property is read-only.
    HRESULT get_CachedAcceleratorKey(BSTR* retVal);
    ///Retrieves the cached access key character for the element. This property is read-only.
    HRESULT get_CachedAccessKey(BSTR* retVal);
    ///A cached value that indicates whether the element has keyboard focus. This property is read-only.
    HRESULT get_CachedHasKeyboardFocus(int* retVal);
    ///Retrieves a cached value that indicates whether the element can accept keyboard focus. This property is
    ///read-only.
    HRESULT get_CachedIsKeyboardFocusable(int* retVal);
    ///Retrieves a cached value that indicates whether the element is enabled. This property is read-only.
    HRESULT get_CachedIsEnabled(int* retVal);
    ///Retrieves the cached Microsoft UI Automation identifier of the element. This property is read-only.
    HRESULT get_CachedAutomationId(BSTR* retVal);
    ///Retrieves the cached class name of the element. This property is read-only.
    HRESULT get_CachedClassName(BSTR* retVal);
    ///Retrieves the cached help text for the element. This property is read-only.
    HRESULT get_CachedHelpText(BSTR* retVal);
    ///Retrieves a cached value that indicates the culture associated with the element. This property is read-only.
    HRESULT get_CachedCulture(int* retVal);
    ///Retrieves a cached value that indicates whether the element is a control element. This property is read-only.
    HRESULT get_CachedIsControlElement(int* retVal);
    ///A cached value that indicates whether the element is a content element. This property is read-only.
    HRESULT get_CachedIsContentElement(int* retVal);
    ///Retrieves a cached value that indicates whether the element contains a disguised password. This property is
    ///read-only.
    HRESULT get_CachedIsPassword(int* retVal);
    ///Retrieves the cached window handle of the element. This property is read-only.
    HRESULT get_CachedNativeWindowHandle(void** retVal);
    ///Retrieves a cached string that describes the type of item represented by the element. This property is read-only.
    HRESULT get_CachedItemType(BSTR* retVal);
    ///Retrieves a cached value that indicates whether the element is off-screen. This property is read-only.
    HRESULT get_CachedIsOffscreen(int* retVal);
    ///Retrieves a cached value that indicates the orientation of the element. This property is read-only.
    HRESULT get_CachedOrientation(OrientationType* retVal);
    ///Retrieves the cached name of the underlying UI framework associated with the element. This property is read-only.
    HRESULT get_CachedFrameworkId(BSTR* retVal);
    ///Retrieves a cached value that indicates whether the element is required to be filled out on a form. This property
    ///is read-only.
    HRESULT get_CachedIsRequiredForForm(int* retVal);
    ///Retrieves a cached description of the status of an item within an element. This property is read-only.
    HRESULT get_CachedItemStatus(BSTR* retVal);
    ///Retrieves the cached coordinates of the rectangle that completely encloses the element. This property is
    ///read-only.
    HRESULT get_CachedBoundingRectangle(RECT* retVal);
    ///Retrieves the cached element that contains the text label for this element. This property is read-only.
    HRESULT get_CachedLabeledBy(IUIAutomationElement* retVal);
    ///Retrieves the cached Accessible Rich Internet Applications (ARIA) role of the element. This property is
    ///read-only.
    HRESULT get_CachedAriaRole(BSTR* retVal);
    ///Retrieves the cached Accessible Rich Internet Applications (ARIA) properties of the element. This property is
    ///read-only.
    HRESULT get_CachedAriaProperties(BSTR* retVal);
    ///Retrieves a cached value that indicates whether the element contains valid data for the form. This property is
    ///read-only.
    HRESULT get_CachedIsDataValidForForm(int* retVal);
    ///Retrieves a cached array of UI Automation elements for which this element serves as the controller. This property
    ///is read-only.
    HRESULT get_CachedControllerFor(IUIAutomationElementArray* retVal);
    ///Retrieves a cached array of elements that describe this element. This property is read-only.
    HRESULT get_CachedDescribedBy(IUIAutomationElementArray* retVal);
    ///Retrieves a cached array of elements that indicate the reading order after the current element. This property is
    ///read-only.
    HRESULT get_CachedFlowsTo(IUIAutomationElementArray* retVal);
    ///Retrieves a cached description of the provider for this element. This property is read-only.
    HRESULT get_CachedProviderDescription(BSTR* retVal);
    ///Retrieves a point on the element that can be clicked.
    ///Params:
    ///    clickable = Type: <b>POINT*</b> Receives the physical screen coordinates of a point that can be used by a client to click
    ///                this element.
    ///    gotClickable = Type: <b>BOOL*</b> Receives <b>TRUE</b> if a clickable point was retrieved, or <b>FALSE</b> otherwise.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetClickablePoint(POINT* clickable, int* gotClickable);
}

///Represents a collection of UI Automation elements.
@GUID("14314595-B4BC-4055-95F2-58F2E42C9855")
interface IUIAutomationElementArray : IUnknown
{
    ///Retrieves the number of elements in the collection. This property is read-only.
    HRESULT get_Length(int* length);
    ///Retrieves a Microsoft UI Automation element from the collection.
    ///Params:
    ///    index = Type: <b>int</b> The zero-based index of the element.
    ///    element = Type: <b>IUIAutomationElement**</b> Receives a pointer to the element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetElement(int index, IUIAutomationElement* element);
}

///This is the primary interface for conditions used in filtering when searching for elements in the UI Automation tree.
///This interface has no members. The following interfaces inherit from <b>IUIAutomationCondition</b>: <ul> <li>
///IUIAutomationAndCondition </li> <li> IUIAutomationBoolCondition </li> <li> IUIAutomationNotCondition </li> <li>
///IUIAutomationPropertyCondition </li> </ul>
@GUID("352FFBA8-0973-437C-A61F-F64CAFD81DF9")
interface IUIAutomationCondition : IUnknown
{
}

///Represents a condition that can be either <b>TRUE</b> (selects all elements) or <b>FALSE</b> (selects no elements).
@GUID("1B4E1F2E-75EB-4D0B-8952-5A69988E2307")
interface IUIAutomationBoolCondition : IUIAutomationCondition
{
    ///Retrieves the value of the condition: either <b>TRUE</b> or <b>FALSE</b>. This property is read-only.
    HRESULT get_BooleanValue(int* boolVal);
}

///Represents a condition based on a property value that is used to find UI Automation elements.
@GUID("99EBF2CB-5578-4267-9AD4-AFD6EA77E94B")
interface IUIAutomationPropertyCondition : IUIAutomationCondition
{
    ///Retrieves the identifier of the property on which this condition is based. This property is read-only.
    HRESULT get_PropertyId(int* propertyId);
    ///Retrieves the property value that must be matched for the condition to be true. This property is read-only.
    HRESULT get_PropertyValue(VARIANT* propertyValue);
    ///Retrieves a set of flags that specify how the condition is applied. This property is read-only.
    HRESULT get_PropertyConditionFlags(PropertyConditionFlags* flags);
}

///Exposes properties and methods that Microsoft UI Automation client applications can use to retrieve information about
///an AND-based property condition.
@GUID("A7D0AF36-B912-45FE-9855-091DDC174AEC")
interface IUIAutomationAndCondition : IUIAutomationCondition
{
    ///Retrieves the number of conditions that make up this "and" condition. This property is read-only.
    HRESULT get_ChildCount(int* childCount);
    ///Retrieves the conditions that make up this "and" condition, as an ordinary array.
    ///Params:
    ///    childArray = Type: <b>IUIAutomationCondition***</b> Receives a pointer to an array of IUIAutomationCondition interface
    ///                 pointers.
    ///    childArrayCount = Type: <b>int*</b> Receives the number of elements in the array.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetChildrenAsNativeArray(char* childArray, int* childArrayCount);
    ///Retrieves the conditions that make up this "and" condition.
    ///Params:
    ///    childArray = Type: <b>SAFEARRAY**</b> Receives a pointer to the child conditions.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetChildren(SAFEARRAY** childArray);
}

///Represents a condition made up of multiple conditions, at least one of which must be true.
@GUID("8753F032-3DB1-47B5-A1FC-6E34A266C712")
interface IUIAutomationOrCondition : IUIAutomationCondition
{
    ///Retrieves the number of conditions that make up this "or" condition. This property is read-only.
    HRESULT get_ChildCount(int* childCount);
    ///Retrieves the conditions that make up this "or" condition, as an ordinary array.
    ///Params:
    ///    childArray = Type: <b>IUIAutomationCondition***</b> Receives a pointer to an array of IUIAutomationCondition interface
    ///                 pointers.
    ///    childArrayCount = Type: <b>int*</b> Receives the number of elements in the array.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetChildrenAsNativeArray(char* childArray, int* childArrayCount);
    ///Retrieves the conditions that make up this "or" condition.
    ///Params:
    ///    childArray = Type: <b>SAFEARRAY**</b> Receives a pointer to the child conditions.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetChildren(SAFEARRAY** childArray);
}

///Represents a condition that is the negative of another condition.
@GUID("F528B657-847B-498C-8896-D52B565407A1")
interface IUIAutomationNotCondition : IUIAutomationCondition
{
    ///Retrieves the condition of which this condition is the negative.
    ///Params:
    ///    condition = Type: <b>IUIAutomationCondition**</b> Receives a pointer to the condition.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetChild(IUIAutomationCondition* condition);
}

///Exposes properties and methods of a cache request. Client applications use this interface to specify the properties
///and control patterns to be cached when a Microsoft UI Automation element is obtained.
@GUID("B32A92B5-BC25-4078-9C08-D7EE95C48E03")
interface IUIAutomationCacheRequest : IUnknown
{
    ///Adds a property to the cache request.
    ///Params:
    ///    propertyId = Type: <b>PROPERTYID</b> A property identifier. For a list of property IDs, see Property Identifiers.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddProperty(int propertyId);
    ///Adds a control pattern to the cache request.
    ///Params:
    ///    patternId = Type: <b>PATTERNID</b> The identifier of the control pattern to add to the cache request. For a list of
    ///                control pattern IDs, see Control Pattern Identifiers.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddPattern(int patternId);
    ///Creates a copy of the cache request.
    ///Params:
    ///    clonedRequest = Type: <b>IUIAutomationCacheRequest**</b> Receives a pointer to the copy of the cache request.
    HRESULT Clone(IUIAutomationCacheRequest* clonedRequest);
    ///Specifies the scope of caching. This property is read/write.
    HRESULT get_TreeScope(TreeScope* scope_);
    ///Specifies the scope of caching. This property is read/write.
    HRESULT put_TreeScope(TreeScope scope_);
    ///Specifies the view of the UI Automation element tree that is used when caching. This property is read/write.
    HRESULT get_TreeFilter(IUIAutomationCondition* filter);
    ///Specifies the view of the UI Automation element tree that is used when caching. This property is read/write.
    HRESULT put_TreeFilter(IUIAutomationCondition filter);
    ///Indicates whether returned elements contain full references to the underlying UI, or only cached information.
    ///This property is read/write.
    HRESULT get_AutomationElementMode(AutomationElementMode* mode);
    ///Indicates whether returned elements contain full references to the underlying UI, or only cached information.
    ///This property is read/write.
    HRESULT put_AutomationElementMode(AutomationElementMode mode);
}

///Exposes properties and methods that UI Automation client applications use to view and navigate the UI Automation
///elements on the desktop.
@GUID("4042C624-389C-4AFC-A630-9DF854A541FC")
interface IUIAutomationTreeWalker : IUnknown
{
    ///Retrieves the parent element of the specified UI Automation element.
    ///Params:
    ///    element = Type: <b>IUIAutomationElement*</b> A pointer to the element for which to retrieve the parent.
    ///    parent = Type: <b>IUIAutomationElement**</b> Receives a pointer to the parent element, or <b>NULL</b> if there is no
    ///             parent element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetParentElement(IUIAutomationElement element, IUIAutomationElement* parent);
    ///Retrieves the first child element of the specified UI Automation element.
    ///Params:
    ///    element = Type: <b>IUIAutomationElement*</b> A pointer to the element for which to retrieve the first child.
    ///    first = Type: <b>IUIAutomationElement**</b> Receives a pointer to the first child element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFirstChildElement(IUIAutomationElement element, IUIAutomationElement* first);
    ///Retrieves the last child element of the specified UI Automation element.
    ///Params:
    ///    element = Type: <b>IUIAutomationElement*</b> A pointer to the element for which to retrieve the last child.
    ///    last = Type: <b>IUIAutomationElement**</b> Receives a pointer to the last child element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetLastChildElement(IUIAutomationElement element, IUIAutomationElement* last);
    ///Retrieves the next sibling element of the specified UI Automation element.
    ///Params:
    ///    element = Type: <b>IUIAutomationElement*</b> A pointer to the element for which to retrieve the next sibling.
    ///    next = Type: <b>IUIAutomationElement**</b> Receives a pointer to the next sibling element, or <b>NULL</b> if there
    ///           is no sibling element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetNextSiblingElement(IUIAutomationElement element, IUIAutomationElement* next);
    ///Retrieves the previous sibling element of the specified UI Automation element.
    ///Params:
    ///    element = Type: <b>IUIAutomationElement*</b> A pointer to the element for which to retrieve the previous sibling.
    ///    previous = Type: <b>IUIAutomationElement**</b> Receives a pointer to the previous sibling element, or <b>NULL</b> if
    ///               there is no sibling element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPreviousSiblingElement(IUIAutomationElement element, IUIAutomationElement* previous);
    ///Retrieves the ancestor element nearest to the specified Microsoft UI Automation element in the tree view.
    ///Params:
    ///    element = Type: <b>IUIAutomationElement*</b> A pointer to the element from which to start the normalization.
    ///    normalized = Type: <b>IUIAutomationElement**</b> Receives a pointer to the ancestor element nearest to the specified
    ///                 element in the tree view.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT NormalizeElement(IUIAutomationElement element, IUIAutomationElement* normalized);
    ///Retrieves the parent element of the specified UI Automation element, and caches properties and control patterns.
    ///Params:
    ///    element = Type: <b>IUIAutomationElement*</b> A pointer to the element for which to retrieve the parent.
    ///    cacheRequest = Type: <b>IUIAutomationCacheRequest*</b> A pointer to a cache request that specifies the properties and
    ///                   control patterns to cache on the returned element.
    ///    parent = Type: <b>IUIAutomationElement**</b> Receives a pointer to the parent element, or <b>NULL</b> if there is no
    ///             parent element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetParentElementBuildCache(IUIAutomationElement element, IUIAutomationCacheRequest cacheRequest, 
                                       IUIAutomationElement* parent);
    ///Retrieves the first child element of the specified UI Automation element, and caches properties and control
    ///patterns.
    ///Params:
    ///    element = Type: <b>IUIAutomationElement*</b> A pointer to the element for which to retrieve the first child.
    ///    cacheRequest = Type: <b>IUIAutomationCacheRequest*</b> A pointer to a cache request that specifies the properties and
    ///                   control patterns to cache on the returned element.
    ///    first = Type: <b>IUIAutomationElement**</b> Receives a pointer to the first child element, or <b>NULL</b> if there is
    ///            no child element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFirstChildElementBuildCache(IUIAutomationElement element, IUIAutomationCacheRequest cacheRequest, 
                                           IUIAutomationElement* first);
    ///Retrieves the last child element of the specified UI Automation element, and caches properties and control
    ///patterns.
    ///Params:
    ///    element = Type: <b>IUIAutomationElement*</b> A pointer to the element for which to retrieve the last child.
    ///    cacheRequest = Type: <b>IUIAutomationCacheRequest*</b> A pointer to a cache request that specifies the properties and
    ///                   control patterns to cache on the returned element.
    ///    last = Type: <b>IUIAutomationElement**</b> Receives a pointer to the last child element, or <b>NULL</b> if there is
    ///           no child element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetLastChildElementBuildCache(IUIAutomationElement element, IUIAutomationCacheRequest cacheRequest, 
                                          IUIAutomationElement* last);
    ///Retrieves the next sibling element of the specified UI Automation element, and caches properties and control
    ///patterns.
    ///Params:
    ///    element = Type: <b>IUIAutomationElement*</b> A pointer to the element for which to retrieve the next sibling.
    ///    cacheRequest = Type: <b>IUIAutomationCacheRequest*</b> A pointer to a cache request that specifies the properties and
    ///                   control patterns to cache on the returned element.
    ///    next = Type: <b>IUIAutomationElement**</b> Receives a pointer to the next sibling element, or <b>NULL</b> if there
    ///           is no sibling element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetNextSiblingElementBuildCache(IUIAutomationElement element, IUIAutomationCacheRequest cacheRequest, 
                                            IUIAutomationElement* next);
    ///Retrieves the previous sibling element of the specified UI Automation element, and caches properties and control
    ///patterns.
    ///Params:
    ///    element = Type: <b>IUIAutomationElement*</b> A pointer to the element for which to retrieve the previous sibling.
    ///    cacheRequest = Type: <b>IUIAutomationCacheRequest*</b> A pointer to a cache request that specifies the properties and
    ///                   control patterns to cache on the returned element.
    ///    previous = Type: <b>IUIAutomationElement**</b> Receives a pointer to the previous sibling element, or <b>NULL</b> if
    ///               there is no sibling element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPreviousSiblingElementBuildCache(IUIAutomationElement element, 
                                                IUIAutomationCacheRequest cacheRequest, 
                                                IUIAutomationElement* previous);
    ///Retrieves the ancestor element nearest to the specified Microsoft UI Automation element in the tree view,
    ///prefetches the requested properties and control patterns, and stores the prefetched items in the cache.
    ///Params:
    ///    element = Type: <b>IUIAutomationElement*</b> A pointer to the element from which to start the normalization.
    ///    cacheRequest = Type: <b>IUIAutomationCacheRequest*</b> A pointer to a cache request that specifies the properties and
    ///                   control patterns to cache on the returned element.
    ///    normalized = Type: <b>IUIAutomationElement**</b> Receives a pointer to the ancestor element nearest to the specified
    ///                 element in the tree view.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT NormalizeElementBuildCache(IUIAutomationElement element, IUIAutomationCacheRequest cacheRequest, 
                                       IUIAutomationElement* normalized);
    ///Retrieves the condition that defines the view of the UI Automation tree. This property is read-only.
    HRESULT get_Condition(IUIAutomationCondition* condition);
}

///Exposes a method to handle Microsoft UI Automation events.
@GUID("146C3C17-F12E-4E22-8C27-F894B9B79C69")
interface IUIAutomationEventHandler : IUnknown
{
    ///Handles a Microsoft UI Automation event.
    ///Params:
    ///    sender = Type: <b>IUIAutomationElement*</b> A pointer to the element that raised the event.
    ///    eventId = Type: <b>EVENTID</b> The event identifier. For a list of event identifiers, see Event Identifiers.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT HandleAutomationEvent(IUIAutomationElement sender, int eventId);
}

///Exposes a method to handle Microsoft UI Automation events that occur when a property is changed.
@GUID("40CD37D4-C756-4B0C-8C6F-BDDFEEB13B50")
interface IUIAutomationPropertyChangedEventHandler : IUnknown
{
    ///Handles a Microsoft UI Automation property-changed event.
    ///Params:
    ///    sender = Type: <b>IUIAutomationElement*</b> A pointer to the element that raised the event.
    ///    propertyId = Type: <b>PROPERTYID</b> The identifier of the property whose value has changed. For a list of property IDs,
    ///                 see Property Identifiers.
    ///    newValue = Type: <b>VARIANT</b> The new property value.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT HandlePropertyChangedEvent(IUIAutomationElement sender, int propertyId, VARIANT newValue);
}

///Exposes a method to handle events that occur when the Microsoft UI Automation tree structure is changed.
@GUID("E81D1B4E-11C5-42F8-9754-E7036C79F054")
interface IUIAutomationStructureChangedEventHandler : IUnknown
{
    ///Handles an event that is raised when the Microsoft UI Automation tree structure has changed.
    ///Params:
    ///    sender = Type: <b>IUIAutomationElement*</b> A pointer to the element that raised the event.
    ///    arg2 = Type: <b>StructureChangeType</b> A value indicating the type of tree structure change that took place.
    ///    runtimeId = Type: <b>SAFEARRAY*</b> Receives the runtime identifier of the element. This parameter is used only when
    ///                <i>changeType</i> is StructureChangeType_ChildRemoved; it is <b>NULL</b> for all other structure-change
    ///                events.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT HandleStructureChangedEvent(IUIAutomationElement sender, StructureChangeType changeType, 
                                        SAFEARRAY* runtimeId);
}

///Exposes a method to handle events that are raised when the keyboard focus moves to another UI Automation element.
@GUID("C270F6B5-5C69-4290-9745-7A7F97169468")
interface IUIAutomationFocusChangedEventHandler : IUnknown
{
    ///Handles the event raised when the keyboard focus moves to a different UI Automation element.
    ///Params:
    ///    sender = Type: <b>IUIAutomationElement*</b> A pointer to the element that has received the focus.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT HandleFocusChangedEvent(IUIAutomationElement sender);
}

///Exposes a method to handle events that occur when Microsoft UI Automation reports a text-changed event from text edit
///controls.
@GUID("92FAA680-E704-4156-931A-E32D5BB38F3F")
interface IUIAutomationTextEditTextChangedEventHandler : IUnknown
{
    ///Handles an event that is raised when a Microsoft UI Automation provider for a text-edit control reports a
    ///programmatic text change.
    ///Params:
    ///    sender = Type: <b>IUIAutomationElement*</b> A pointer to the element that raised the event.
    ///    arg2 = Type: <b>TextEditChangeType</b> The type of text-edit change that occurred.
    ///    eventStrings = Type: <b>SAFEARRAY*</b> Event data passed by the event.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT HandleTextEditTextChangedEvent(IUIAutomationElement sender, TextEditChangeType textEditChangeType, 
                                           SAFEARRAY* eventStrings);
}

///Exposes a method to handle one or more Microsoft UI Automation change events.
@GUID("58EDCA55-2C3E-4980-B1B9-56C17F27A2A0")
interface IUIAutomationChangesEventHandler : IUnknown
{
    ///Handles one or more Microsoft UI Automation change events.
    ///Params:
    ///    sender = A pointer to the element that raised the event.
    ///    uiaChanges = A collection of pointers to UiaChangeInfo structures.
    ///    changesCount = The number of changes that occurred. This is the number of UiaChangeInfo structures pointed to by the
    ///                   <i>uiaChanges</i> parameter.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT HandleChangesEvent(IUIAutomationElement sender, char* uiaChanges, int changesCount);
}

///Exposes a method to handle Microsoft UI Automation notification events.
@GUID("C7CB2637-E6C2-4D0C-85DE-4948C02175C7")
interface IUIAutomationNotificationEventHandler : IUnknown
{
    ///Handles a Microsoft UI Automation notification event.
    ///Params:
    ///    sender = A pointer to the element that raised the event.
    ///    arg2 = The type of notification.
    ///    arg3 = Indicates how to process notifications.
    ///    displayString = A string to display in the notification message.
    ///    activityId = A unique non-localized string to identify an action or group of actions. This is used to pass additional
    ///                 information to the event handler.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT HandleNotificationEvent(IUIAutomationElement sender, NotificationKind notificationKind, 
                                    NotificationProcessing notificationProcessing, BSTR displayString, 
                                    BSTR activityId);
}

///Exposes a method that enables a client application to invoke the action of a control (typically a button).
@GUID("FB377FBE-8EA6-46D5-9C73-6499642D3059")
interface IUIAutomationInvokePattern : IUnknown
{
    ///Invokes the action of a control, such as a button click.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Invoke();
}

///Provides access to a control that enables child elements to be arranged horizontally and vertically, relative to each
///other.
@GUID("FDE5EF97-1464-48F6-90BF-43D0948E86EC")
interface IUIAutomationDockPattern : IUnknown
{
    ///Sets the dock position of this element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetDockPosition(DockPosition dockPos);
    ///Retrieves the dock position of this element within its docking container. This property is read-only.
    HRESULT get_CurrentDockPosition(DockPosition* retVal);
    ///Retrieves the cached dock position of this element within its docking container. This property is read-only.
    HRESULT get_CachedDockPosition(DockPosition* retVal);
}

///Provides access to a control that can visually expand to display content, and collapse to hide content.
@GUID("619BE086-1F4E-4EE4-BAFA-210128738730")
interface IUIAutomationExpandCollapsePattern : IUnknown
{
    ///Displays all child nodes, controls, or content of the element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Expand();
    ///Hides all child nodes, controls, or content of the element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Collapse();
    ///Retrieves a value that indicates the state, expanded or collapsed, of the element. This property is read-only.
    HRESULT get_CurrentExpandCollapseState(ExpandCollapseState* retVal);
    ///Retrieves a cached value that indicates the state, expanded or collapsed, of the element. This property is
    ///read-only.
    HRESULT get_CachedExpandCollapseState(ExpandCollapseState* retVal);
}

///Provides access to a control that acts as a container for a collection of child controls that are organized in a
///two-dimensional logical coordinate system that can be traversed by row and column. The children of this element
///support the IUIAutomationGridItemPattern interface.
@GUID("414C3CDC-856B-4F5B-8538-3131C6302550")
interface IUIAutomationGridPattern : IUnknown
{
    ///Retrieves a UI Automation element representing an item in the grid.
    ///Params:
    ///    row = Type: <b>int</b> The zero-based index of the row.
    ///    column = Type: <b>int</b> The zero-based index of the column.
    ///    element = Type: <b>IUIAutomationElement**</b> Receives a pointer to the element representing the grid item.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetItem(int row, int column, IUIAutomationElement* element);
    ///Retrieves the number of rows in the grid. This property is read-only.
    HRESULT get_CurrentRowCount(int* retVal);
    ///The number of columns in the grid. This property is read-only.
    HRESULT get_CurrentColumnCount(int* retVal);
    ///Retrieves the cached number of rows in the grid. This property is read-only.
    HRESULT get_CachedRowCount(int* retVal);
    ///Retrieves the cached number of columns in the grid. This property is read-only.
    HRESULT get_CachedColumnCount(int* retVal);
}

///Provides access to a child control in a grid-style container that supports the IUIAutomationGridPattern interface.
@GUID("78F8EF57-66C3-4E09-BD7C-E79B2004894D")
interface IUIAutomationGridItemPattern : IUnknown
{
    ///Retrieves the element that contains the grid item. This property is read-only.
    HRESULT get_CurrentContainingGrid(IUIAutomationElement* retVal);
    ///Retrieves the zero-based index of the row that contains the grid item. This property is read-only.
    HRESULT get_CurrentRow(int* retVal);
    ///Retrieves the zero-based index of the column that contains the item. This property is read-only.
    HRESULT get_CurrentColumn(int* retVal);
    ///Retrieves the number of rows spanned by the grid item. This property is read-only.
    HRESULT get_CurrentRowSpan(int* retVal);
    ///Retrieves the number of columns spanned by the grid item. This property is read-only.
    HRESULT get_CurrentColumnSpan(int* retVal);
    ///Retrieves the cached element that contains the grid item. This property is read-only.
    HRESULT get_CachedContainingGrid(IUIAutomationElement* retVal);
    ///Retrieves the cached zero-based index of the row that contains the item. This property is read-only.
    HRESULT get_CachedRow(int* retVal);
    ///Retrieves the cached zero-based index of the column that contains the grid item. This property is read-only.
    HRESULT get_CachedColumn(int* retVal);
    ///Retrieves the cached number of rows spanned by a grid item. This property is read-only.
    HRESULT get_CachedRowSpan(int* retVal);
    ///Retrieves the cached number of columns spanned by the grid item. This property is read-only.
    HRESULT get_CachedColumnSpan(int* retVal);
}

///Provides access to a control that can switch between multiple representations of the same information or set of child
///controls.
@GUID("8D253C91-1DC5-4BB5-B18F-ADE16FA495E8")
interface IUIAutomationMultipleViewPattern : IUnknown
{
    ///Retrieves the name of a control-specific view.
    ///Params:
    ///    view = Type: <b>int</b> The identifier of the view.
    ///    name = Type: <b>BSTR*</b> Receives a pointer to a localized view name.
    HRESULT GetViewName(int view, BSTR* name);
    ///Sets the view of the control.
    ///Params:
    ///    view = Type: <b>int</b> The control-specific view identifier.
    HRESULT SetCurrentView(int view);
    ///Retrieves the control-specific identifier of the current view of the control. This property is read-only.
    HRESULT get_CurrentCurrentView(int* retVal);
    ///Retrieves a collection of control-specific view identifiers.
    ///Params:
    ///    retVal = Type: <b>SAFEARRAY**</b> Receives a pointer to an array of view identifiers.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCurrentSupportedViews(SAFEARRAY** retVal);
    ///Retrieves the cached control-specific identifier of the current view of the control. This property is read-only.
    HRESULT get_CachedCurrentView(int* retVal);
    ///Retrieves a collection of control-specific view identifiers from the cache.
    ///Params:
    ///    retVal = Type: <b>SAFEARRAY**</b> Receives a pointer to an array of view identifiers.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCachedSupportedViews(SAFEARRAY** retVal);
}

///Provides access to the underlying object model implemented by a control or application.
@GUID("71C284B3-C14D-4D14-981E-19751B0D756D")
interface IUIAutomationObjectModelPattern : IUnknown
{
    ///Retrieves an interface used to access the underlying object model of the provider.
    ///Params:
    ///    retVal = Type: <b>IUnknown**</b> Receives an interface for accessing the underlying object model.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetUnderlyingObjectModel(IUnknown* retVal);
}

///Provides access to a control that presents a range of values.
@GUID("59213F4F-7346-49E5-B120-80555987A148")
interface IUIAutomationRangeValuePattern : IUnknown
{
    ///Sets the value of the control.
    ///Params:
    ///    val = Type: <b>double</b> The value to set as the value of the control.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetValue(double val);
    ///Retrieves the value of the control. This property is read-only.
    HRESULT get_CurrentValue(double* retVal);
    ///Indicates whether the value of the element can be changed. This property is read-only.
    HRESULT get_CurrentIsReadOnly(int* retVal);
    ///Retrieves the maximum value of the control. This property is read-only.
    HRESULT get_CurrentMaximum(double* retVal);
    ///Retrieves the minimum value of the control. This property is read-only.
    HRESULT get_CurrentMinimum(double* retVal);
    ///Retrieves the value that is added to or subtracted from the value of the control when a large change is made,
    ///such as when the PAGE DOWN key is pressed. This property is read-only.
    HRESULT get_CurrentLargeChange(double* retVal);
    ///Retrieves the value that is added to or subtracted from the value of the control when a small change is made,
    ///such as when an arrow key is pressed. This property is read-only.
    HRESULT get_CurrentSmallChange(double* retVal);
    ///Retrieves the cached value of the control. This property is read-only.
    HRESULT get_CachedValue(double* retVal);
    ///Retrieves a cached value that indicates whether the value of the element can be changed. This property is
    ///read-only.
    HRESULT get_CachedIsReadOnly(int* retVal);
    ///Retrieves the cached maximum value of the control. This property is read-only.
    HRESULT get_CachedMaximum(double* retVal);
    ///Retrieves the cached minimum value of the control. This property is read-only.
    HRESULT get_CachedMinimum(double* retVal);
    ///Retrieves, from the cache, the value that is added to or subtracted from the value of the control when a large
    ///change is made, such as when the PAGE DOWN key is pressed. This property is read-only.
    HRESULT get_CachedLargeChange(double* retVal);
    ///Retrieves, from the cache, the value that is added to or subtracted from the value of the control when a small
    ///change is made, such as when an arrow key is pressed. This property is read-only.
    HRESULT get_CachedSmallChange(double* retVal);
}

///Provides access to a control that acts as a scrollable container for a collection of child elements. The children of
///this element support IUIAutomationScrollItemPattern.
@GUID("88F4D42A-E881-459D-A77C-73BBBB7E02DC")
interface IUIAutomationScrollPattern : IUnknown
{
    ///Scrolls the visible region of the content area horizontally and vertically.
    ///Params:
    ///    arg1 = Type: <b>ScrollAmount</b> A value indicating the size of the horizontal scroll increment, or
    ///           <b>UIA_ScrollPatternNoScroll</b> if the horizontal position is not to be set.
    ///    arg2 = Type: <b>ScrollAmount</b> A value from the ScrollAmount enumerated type indicating the size of the vertical
    ///           scroll increment, or <b>UIA_ScrollPatternNoScroll</b> if the vertical position is not to be set.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Scroll(ScrollAmount horizontalAmount, ScrollAmount verticalAmount);
    ///Sets the horizontal and vertical scroll positions as a percentage of the total content area within the UI
    ///Automation element.
    ///Params:
    ///    horizontalPercent = Type: <b>double</b> The percentage of the total horizontal content area, or <b>UIA_ScrollPatternNoScroll</b>
    ///                        if the horizontal position is not to be set.
    ///    verticalPercent = Type: <b>double</b> The percentage of the total vertical content area, or <b>UIA_ScrollPatternNoScroll</b> if
    ///                      the vertical position is not to be set.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetScrollPercent(double horizontalPercent, double verticalPercent);
    ///Retrieves the horizontal scroll position. This property is read-only.
    HRESULT get_CurrentHorizontalScrollPercent(double* retVal);
    ///Retrieves the vertical scroll position. This property is read-only.
    HRESULT get_CurrentVerticalScrollPercent(double* retVal);
    ///Retrieves the horizontal size of the viewable region of a scrollable element. This property is read-only.
    HRESULT get_CurrentHorizontalViewSize(double* retVal);
    ///Retrieves the vertical size of the viewable region of a scrollable element. This property is read-only.
    HRESULT get_CurrentVerticalViewSize(double* retVal);
    ///Indicates whether the element can scroll horizontally. This property is read-only.
    HRESULT get_CurrentHorizontallyScrollable(int* retVal);
    ///Indicates whether the element can scroll vertically. This property is read-only.
    HRESULT get_CurrentVerticallyScrollable(int* retVal);
    ///Retrieves the cached horizontal scroll position. This property is read-only.
    HRESULT get_CachedHorizontalScrollPercent(double* retVal);
    ///Retrieves the cached vertical scroll position. This property is read-only.
    HRESULT get_CachedVerticalScrollPercent(double* retVal);
    ///Retrieves the cached horizontal size of the viewable region of a scrollable element. This property is read-only.
    HRESULT get_CachedHorizontalViewSize(double* retVal);
    ///Retrieves the cached vertical size of the viewable region of a scrollable element. This property is read-only.
    HRESULT get_CachedVerticalViewSize(double* retVal);
    ///Retrieves a cached value that indicates whether the element can scroll horizontally. This property is read-only.
    HRESULT get_CachedHorizontallyScrollable(int* retVal);
    ///Retrieves a cached value that indicates whether the element can scroll vertically. This property is read-only.
    HRESULT get_CachedVerticallyScrollable(int* retVal);
}

///Exposes a method that enables an item in a scrollable view to be placed in a visible portion of the view.
@GUID("B488300F-D015-4F19-9C29-BB595E3645EF")
interface IUIAutomationScrollItemPattern : IUnknown
{
    ///Scrolls the content area of a container object to display the UI Automation element within the visible region
    ///(viewport) of the container.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ScrollIntoView();
}

///Provides access to a control that contains selectable child items. The children of this element support
///IUIAutomationSelectionItemPattern.
@GUID("5ED5202E-B2AC-47A6-B638-4B0BF140D78E")
interface IUIAutomationSelectionPattern : IUnknown
{
    ///Retrieves the selected elements in the container.
    ///Params:
    ///    retVal = Type: <b>IUIAutomationElementArray**</b> Receives a pointer to the collection of selected elements. The
    ///             default is an empty array.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCurrentSelection(IUIAutomationElementArray* retVal);
    ///Indicates whether more than one item in the container can be selected at one time. This property is read-only.
    HRESULT get_CurrentCanSelectMultiple(int* retVal);
    ///Indicates whether at least one item must be selected at all times. This property is read-only.
    HRESULT get_CurrentIsSelectionRequired(int* retVal);
    ///Retrieves the cached selected elements in the container.
    ///Params:
    ///    retVal = Type: <b>IUIAutomationElementArray**</b> Receives a pointer to the cached collection of selected elements.
    ///             The default is an empty array.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCachedSelection(IUIAutomationElementArray* retVal);
    ///Retrieves a cached value that indicates whether more than one item in the container can be selected at one time.
    ///This property is read-only.
    HRESULT get_CachedCanSelectMultiple(int* retVal);
    ///Retrieves a cached value that indicates whether at least one item must be selected at all times. This property is
    ///read-only.
    HRESULT get_CachedIsSelectionRequired(int* retVal);
}

///Extends the IUIAutomationSelectionPattern interface to provide information about selected items.
@GUID("0532BFAE-C011-4E32-A343-6D642D798555")
interface IUIAutomationSelectionPattern2 : IUIAutomationSelectionPattern
{
    ///Gets an IUIAutomationElement object representing the first item in a group of selected items. This property is
    ///read-only.
    HRESULT get_CurrentFirstSelectedItem(IUIAutomationElement* retVal);
    ///Gets an IUIAutomationElement object representing the last item in a group of selected items. This property is
    ///read-only.
    HRESULT get_CurrentLastSelectedItem(IUIAutomationElement* retVal);
    ///Gets an IUIAutomationElement object representing the currently selected item. This property is read-only.
    HRESULT get_CurrentCurrentSelectedItem(IUIAutomationElement* retVal);
    ///Gets an integer value indicating the number of selected items. This property is read-only.
    HRESULT get_CurrentItemCount(int* retVal);
    ///Gets a cached IUIAutomationElement object representing the first item in a group of selected items. This property
    ///is read-only.
    HRESULT get_CachedFirstSelectedItem(IUIAutomationElement* retVal);
    ///Gets a cached IUIAutomationElement object representing the last item in a group of selected items. This property
    ///is read-only.
    HRESULT get_CachedLastSelectedItem(IUIAutomationElement* retVal);
    ///Gets a cached IUIAutomationElement object representing the currently selected item. This property is read-only.
    HRESULT get_CachedCurrentSelectedItem(IUIAutomationElement* retVal);
    ///Gets a cached integer value indicating the number of selected items. This property is read/write.
    HRESULT get_CachedItemCount(int* retVal);
}

///Provides access to the selectable child items of a container control that supports IUIAutomationSelectionPattern.
@GUID("A8EFA66A-0FDA-421A-9194-38021F3578EA")
interface IUIAutomationSelectionItemPattern : IUnknown
{
    ///Clears any selected items and then selects the current element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Select();
    ///Adds the current element to the collection of selected items.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddToSelection();
    ///Removes this element from the selection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RemoveFromSelection();
    ///Indicates whether this item is selected. This property is read-only.
    HRESULT get_CurrentIsSelected(int* retVal);
    ///Retrieves the element that supports IUIAutomationSelectionPattern and acts as the container for this item. This
    ///property is read-only.
    HRESULT get_CurrentSelectionContainer(IUIAutomationElement* retVal);
    ///A cached value that indicates whether this item is selected. This property is read-only.
    HRESULT get_CachedIsSelected(int* retVal);
    ///Retrieves the cached element that supports IUIAutomationSelectionPattern and acts as the container for this item.
    ///This property is read-only.
    HRESULT get_CachedSelectionContainer(IUIAutomationElement* retVal);
}

///Provides access to the keyboard or mouse input of a control.
@GUID("2233BE0B-AFB7-448B-9FDA-3B378AA5EAE1")
interface IUIAutomationSynchronizedInputPattern : IUnknown
{
    ///Causes the Microsoft UI Automation provider to start listening for mouse or keyboard input.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT StartListening(SynchronizedInputType inputType);
    ///Causes the Microsoft UI Automation provider to stop listening for mouse or keyboard input.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Cancel();
}

///Provides access to a control that acts as a container for a collection of child elements. The children of this
///element support IUIAutomationTableItemPattern and are organized in a two-dimensional logical coordinate system that
///can be traversed by row and column.
@GUID("620E691C-EA96-4710-A850-754B24CE2417")
interface IUIAutomationTablePattern : IUnknown
{
    ///Retrieves a collection of UI Automation elements representing all the row headers in a table.
    ///Params:
    ///    retVal = Type: <b>IUIAutomationElementArray**</b> Receives a pointer to the collection of row headers. The default is
    ///             an empty array.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCurrentRowHeaders(IUIAutomationElementArray* retVal);
    ///Retrieves a collection of UI Automation elements representing all the column headers in a table.
    ///Params:
    ///    retVal = Type: <b>IUIAutomationElementArray**</b> Receives a pointer to the collection of column headers. The default
    ///             is an empty array.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCurrentColumnHeaders(IUIAutomationElementArray* retVal);
    ///Retrieves the primary direction of traversal for the table. This property is read-only.
    HRESULT get_CurrentRowOrColumnMajor(RowOrColumnMajor* retVal);
    ///Retrieves a cached collection of UI Automation elements representing all the row headers in a table.
    ///Params:
    ///    retVal = Type: <b>IUIAutomationElementArray**</b> Receives a pointer to the collection of cached row headers. The
    ///             default is an empty array.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCachedRowHeaders(IUIAutomationElementArray* retVal);
    ///Retrieves a cached collection of UI Automation elements representing all the column headers in a table.
    ///Params:
    ///    retVal = Type: <b>IUIAutomationElementArray**</b> Receives a pointer to the collection of cached column headers. The
    ///             default is an empty array.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCachedColumnHeaders(IUIAutomationElementArray* retVal);
    ///Retrieves the cached primary direction of traversal for the table. This property is read-only.
    HRESULT get_CachedRowOrColumnMajor(RowOrColumnMajor* retVal);
}

///Provides access to a child element in a container that supports IUIAutomationTablePattern.
@GUID("0B964EB3-EF2E-4464-9C79-61D61737A27E")
interface IUIAutomationTableItemPattern : IUnknown
{
    ///Retrieves the row headers associated with a table item or cell.
    ///Params:
    ///    retVal = Type: <b>IUIAutomationElementArray**</b> Receives a pointer to the collection of row headers.
    HRESULT GetCurrentRowHeaderItems(IUIAutomationElementArray* retVal);
    ///Retrieves the column headers associated with a table item or cell.
    ///Params:
    ///    retVal = Type: <b>IUIAutomationElementArray**</b> Receives a pointer to the collection of column headers.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCurrentColumnHeaderItems(IUIAutomationElementArray* retVal);
    ///Retrieves the cached row headers associated with a table item or cell.
    ///Params:
    ///    retVal = Type: <b>IUIAutomationElementArray**</b> Receives a pointer to the collection of cached row headers.
    HRESULT GetCachedRowHeaderItems(IUIAutomationElementArray* retVal);
    ///Retrieves the cached column headers associated with a table item or cell.
    ///Params:
    ///    retVal = Type: <b>IUIAutomationElementArray**</b> Receives a pointer to the collection of cached column headers.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCachedColumnHeaderItems(IUIAutomationElementArray* retVal);
}

///Provides access to a control that can cycle through a set of states, and maintain a state after it is set.
@GUID("94CF8058-9B8D-4AB9-8BFD-4CD0A33C8C70")
interface IUIAutomationTogglePattern : IUnknown
{
    ///Cycles through the toggle states of the control.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Toggle();
    ///Retrieves the state of the control. This property is read-only.
    HRESULT get_CurrentToggleState(ToggleState* retVal);
    ///Retrieves the cached state of the control. This property is read-only.
    HRESULT get_CachedToggleState(ToggleState* retVal);
}

///Provides access to a control that can be moved, resized, or rotated.
@GUID("A9B55844-A55D-4EF0-926D-569C16FF89BB")
interface IUIAutomationTransformPattern : IUnknown
{
    ///Moves the UI Automation element.
    ///Params:
    ///    x = Type: <b>double</b> Absolute screen coordinates of the left side of the control.
    ///    y = Type: <b>double</b> Absolute screen coordinates of the top of the control.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Move(double x, double y);
    ///Resizes the UI Automation element.
    ///Params:
    ///    width = Type: <b>double</b> The new width of the window, in pixels.
    ///    height = Type: <b>double</b> The new height of the window, in pixels.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Resize(double width, double height);
    ///Rotates the UI Automation element.
    ///Params:
    ///    degrees = Type: <b>double</b> The number of degrees to rotate the element. A positive number rotates clockwise; a
    ///              negative number rotates counterclockwise.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Rotate(double degrees);
    ///Indicates whether the element can be moved. This property is read-only.
    HRESULT get_CurrentCanMove(int* retVal);
    ///Indicates whether the element can be resized. This property is read-only.
    HRESULT get_CurrentCanResize(int* retVal);
    ///Indicates whether the element can be rotated. This property is read-only.
    HRESULT get_CurrentCanRotate(int* retVal);
    ///Retrieves a cached value that indicates whether the element can be moved. This property is read-only.
    HRESULT get_CachedCanMove(int* retVal);
    ///Retrieves a cached value that indicates whether the element can be resized. This property is read-only.
    HRESULT get_CachedCanResize(int* retVal);
    ///Retrieves a cached value that indicates whether the element can be rotated. This property is read-only.
    HRESULT get_CachedCanRotate(int* retVal);
}

///Provides access to a control that contains a value that does not span a range and that can be represented as a
///string. This string may or may not be editable, depending on the control and its settings.
@GUID("A94CD8B1-0844-4CD6-9D2D-640537AB39E9")
interface IUIAutomationValuePattern : IUnknown
{
    ///Sets the value of the element.
    ///Params:
    ///    val = Type: <b>BSTR</b> The value to set.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetValue(BSTR val);
    ///Retrieves the value of the element. This property is read-only.
    HRESULT get_CurrentValue(BSTR* retVal);
    ///Indicates whether the value of the element is read-only. This property is read-only.
    HRESULT get_CurrentIsReadOnly(int* retVal);
    ///Retrieves the cached value of the element. This property is read-only.
    HRESULT get_CachedValue(BSTR* retVal);
    ///Retrieves a cached value that indicates whether the value of the element is read-only. This property is
    ///read-only.
    HRESULT get_CachedIsReadOnly(int* retVal);
}

///Provides access to the fundamental functionality of a window.
@GUID("0FAEF453-9208-43EF-BBB2-3B485177864F")
interface IUIAutomationWindowPattern : IUnknown
{
    ///Closes the window.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Close();
    ///Causes the calling code to block for the specified time or until the associated process enters an idle state,
    ///whichever completes first.
    ///Params:
    ///    milliseconds = Type: <b>int</b> The amount of time, in milliseconds, to wait for the associated process to become idle.
    ///    success = Type: <b>BOOL*</b> Receives the result: <b>TRUE</b> if the window has entered the idle state, or <b>FALSE</b>
    ///              if the time-out occurred.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT WaitForInputIdle(int milliseconds, int* success);
    ///Minimizes, maximizes, or restores the window.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetWindowVisualState(WindowVisualState state);
    ///Indicates whether the window can be maximized. This property is read-only.
    HRESULT get_CurrentCanMaximize(int* retVal);
    ///Indicates whether the window can be minimized. This property is read-only.
    HRESULT get_CurrentCanMinimize(int* retVal);
    ///Indicates whether the window is modal. This property is read-only.
    HRESULT get_CurrentIsModal(int* retVal);
    ///Indicates whether the window is the topmost element in the z-order. This property is read-only.
    HRESULT get_CurrentIsTopmost(int* retVal);
    ///Retrieves the visual state of the window; that is, whether it is in the normal, maximized, or minimized state.
    ///This property is read-only.
    HRESULT get_CurrentWindowVisualState(WindowVisualState* retVal);
    ///Retrieves the current state of the window for the purposes of user interaction. This property is read-only.
    HRESULT get_CurrentWindowInteractionState(WindowInteractionState* retVal);
    ///Retrieves a cached value that indicates whether the window can be maximized. This property is read-only.
    HRESULT get_CachedCanMaximize(int* retVal);
    ///Retrieves a cached value that indicates whether the window can be minimized. This property is read-only.
    HRESULT get_CachedCanMinimize(int* retVal);
    ///Retrieves a cached value that indicates whether the window is modal. This property is read-only.
    HRESULT get_CachedIsModal(int* retVal);
    ///Retrieves a cached value that indicates whether the window is the topmost element in the z-order. This property
    ///is read-only.
    HRESULT get_CachedIsTopmost(int* retVal);
    ///Retrieves a cached value that indicates the visual state of the window; that is, whether it is in the normal,
    ///maximized, or minimized state. This property is read-only.
    HRESULT get_CachedWindowVisualState(WindowVisualState* retVal);
    ///Retrieves a cached value that indicates the current state of the window for the purposes of user interaction.
    ///This property is read-only.
    HRESULT get_CachedWindowInteractionState(WindowInteractionState* retVal);
}

///Provides access to a span of continuous text in a container that supports the IUIAutomationTextPattern interface.
///Client applications can use the <b>IUIAutomationTextRange</b> interface to select, compare, and retrieve embedded
///objects from the text span. The interface uses two endpoints to delimit where the text span starts and ends. Disjoint
///spans of text are represented by an IUIAutomationTextRangeArray interface.
@GUID("A543CC6A-F4AE-494B-8239-C814481187A8")
interface IUIAutomationTextRange : IUnknown
{
    ///Retrieves a new IUIAutomationTextRange identical to the original and inheriting all properties of the original.
    ///Params:
    ///    clonedRange = Type: <b>IUIAutomationTextRange**</b> Receives a pointer to the new text range.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Clone(IUIAutomationTextRange* clonedRange);
    ///Retrieves a value that specifies whether this text range has the same endpoints as another text range.
    ///Params:
    ///    range = Type: <b>IUIAutomationTextRange*</b> A pointer to the text range to compare with this one.
    ///    areSame = Type: <b>BOOL*</b> Receives <b>TRUE</b> if the text ranges have the same endpoints, or <b>FALSE</b> if they
    ///              do not.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Compare(IUIAutomationTextRange range, int* areSame);
    ///Retrieves a value that specifies whether the start or end endpoint of this text range is the same as the start or
    ///end endpoint of another text range.
    ///Params:
    ///    arg1 = Type: <b>TextPatternRangeEndpoint</b> A value indicating whether the start or end endpoint of this text range
    ///           is to be compared.
    ///    range = Type: <b>IUIAutomationTextRange*</b> A pointer to the text range to compare.
    ///    arg3 = Type: <b>TextPatternRangeEndpoint</b> A value indicating whether the start or end endpoint of <i>range</i> is
    ///           to be compared.
    ///    compValue = Type: <b>int*</b> Receives a negative value if the caller's endpoint occurs earlier in the text than the
    ///                target endpoint; 0 if the caller's endpoint is at the same location as the target endpoint; or a positive
    ///                value if the caller's endpoint occurs later in the text than the target endpoint.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CompareEndpoints(TextPatternRangeEndpoint srcEndPoint, IUIAutomationTextRange range, 
                             TextPatternRangeEndpoint targetEndPoint, int* compValue);
    ///Normalizes the text range by the specified text unit. The range is expanded if it is smaller than the specified
    ///unit, or shortened if it is longer than the specified unit.
    ///Params:
    ///    unit = Type: **[TextUnit](../uiautomationcore/ne-uiautomationcore-textunit.md)** The text unit, such as line or
    ///           paragraph.
    ///Returns:
    ///    Type: **[HRESULT](/windows/desktop/WinProg/windows-data-types)** If this method succeeds, it returns S_OK.
    ///    Otherwise, it returns an HRESULT error code.
    ///    
    HRESULT ExpandToEnclosingUnit(TextUnit textUnit);
    ///Retrieves a text range subset that has the specified text attribute value.
    ///Params:
    ///    attr = Type: <b>TEXTATTRIBUTEID</b> The identifier of the text attribute for the text range subset being retrieved.
    ///           For a list of text attribute IDs, see Text Attribute Identifiers.
    ///    val = Type: <b>VARIANT</b> The value of the attribute. This value must match the type specified for the attribute.
    ///    backward = Type: <b>BOOL</b> <b>TRUE</b> if the last occurring text range should be returned instead of the first;
    ///               otherwise <b>FALSE</b>.
    ///    found = Type: <b>IUIAutomationTextRange**</b> Receives a pointer to the text range having a matching attribute and
    ///            attribute value; otherwise <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT FindAttribute(int attr, VARIANT val, BOOL backward, IUIAutomationTextRange* found);
    HRESULT FindTextA(BSTR text, BOOL backward, BOOL ignoreCase, IUIAutomationTextRange* found);
    ///Retrieves the value of the specified text attribute across the entire text range.
    ///Params:
    ///    attr = Type: <b>TEXTATTRIBUTEID</b> The identifier of the text attribute. For a list of text attribute IDs, see Text
    ///           Attribute Identifiers.
    ///    value = Type: <b>VARIANT*</b> Receives the value of the specified attribute.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetAttributeValue(int attr, VARIANT* value);
    ///Retrieves a collection of bounding rectangles for each fully or partially visible line of text in a text range.
    ///Params:
    ///    boundingRects = Type: <b>SAFEARRAY**</b> Receives a pointer to an array of bounding rectangles for each fully or partially
    ///                    visible line of text in a text range. An empty array is returned for a degenerate (empty) text range or for a
    ///                    text range that is completely off-screen, scrolled out of view, or obscured by an overlapping window.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetBoundingRectangles(SAFEARRAY** boundingRects);
    ///Returns the innermost UI Automation element that encloses the text range.
    ///Params:
    ///    enclosingElement = Type: <b>IUIAutomationElement**</b> Receives a pointer to the enclosing element, which is typically the text
    ///                       provider that supplies the text range. However, if the text provider supports child elements such as tables
    ///                       or hyperlinks, the enclosing element could be a descendant of the text provider.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetEnclosingElement(IUIAutomationElement* enclosingElement);
    ///Returns the plain text of the text range.
    ///Params:
    ///    maxLength = Type: <b>int</b> The maximum length of the string to return, or -1 if no limit is required.
    ///    text = Type: <b>BSTR*</b> Receives a pointer to the string, possibly truncated at the specified <i>maxLength</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetText(int maxLength, BSTR* text);
    ///Moves the text range forward or backward by the specified number of text units .
    ///Params:
    ///    arg1 = Type: <b>TextUnit</b> A value specifying the type of text units, such as character, word, paragraph, and so
    ///           on.
    ///    count = Type: <b>int</b> The number of text units to move. A positive value moves the text range forward. A negative
    ///            value moves the text range backward. Zero has no effect.
    ///    moved = Type: <b>int*</b> Receives the number of text units actually moved. This can be less than the number
    ///            requested if either of the new text range endpoints is greater than or less than the endpoints retrieved by
    ///            the IUIAutomationTextPattern::DocumentRange method. This value can be negative if navigation is happening in
    ///            the backward direction.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Move(TextUnit unit, int count, int* moved);
    ///Moves one endpoint of the text range the specified number of text units within the document range.
    ///Params:
    ///    arg1 = Type: <b>TextPatternRangeEndpoint</b> A value specifying the endpoint (start or end) to move.
    ///    arg2 = Type: <b>TextUnit</b> A value specifying the textual unit for moving, such as line or paragraph.
    ///    count = Type: <b>int</b> The number of units to move. A positive count moves the endpoint forward. A negative count
    ///            moves backward. A count of 0 has no effect.
    ///    moved = Type: <b>int*</b> Receives the count of units actually moved. This value can be less than the number
    ///            requested if moving the endpoint runs into the beginning or end of the document.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT MoveEndpointByUnit(TextPatternRangeEndpoint endpoint, TextUnit unit, int count, int* moved);
    ///Moves one endpoint of the current text range to the specified endpoint of a second text range.
    ///Params:
    ///    arg1 = Type: <b>TextPatternRangeEndpoint</b> An endpoint (either start or end) of the current text range. This is
    ///           the endpoint to be moved.
    ///    range = Type: <b>IUIAutomationTextRange*</b> A second text range from the same text provider as the current text
    ///            range.
    ///    arg3 = Type: <b>TextPatternRangeEndpoint</b> An endpoint (either start or end) of the second text range. The
    ///           <i>srcEndPoint</i> of the current text range is moved to this endpoint.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT MoveEndpointByRange(TextPatternRangeEndpoint srcEndPoint, IUIAutomationTextRange range, 
                                TextPatternRangeEndpoint targetEndPoint);
    ///Selects the span of text that corresponds to this text range, and removes any previous selection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Select();
    ///Adds the text range to the collection of selected text ranges in a control that supports multiple, disjoint spans
    ///of selected text.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddToSelection();
    ///Removes the text range from an existing collection of selected text in a text container that supports multiple,
    ///disjoint selections.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RemoveFromSelection();
    ///Causes the text control to scroll until the text range is visible in the viewport.
    ///Params:
    ///    alignToTop = Type: <b>BOOL</b> <b>TRUE</b> if the text control should be scrolled so that the text range is flush with the
    ///                 top of the viewport; <b>FALSE</b> if it should be flush with the bottom of the viewport.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ScrollIntoView(BOOL alignToTop);
    ///Retrieves a collection of all embedded objects that fall within the text range.
    ///Params:
    ///    children = Type: <b>IUIAutomationElementArray**</b> Receives a pointer to the collection of all child objects that fall
    ///               within the range. Children that overlap with the range but are not entirely enclosed by it are also included
    ///               in the collection. An empty collection is returned if there are no child objects.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetChildren(IUIAutomationElementArray* children);
}

///Extends the IUIAutomationTextRange interface to enable Microsoft UI Automation clients to programmatically invoke
///context menus.
@GUID("BB9B40E0-5E04-46BD-9BE0-4B601B9AFAD4")
interface IUIAutomationTextRange2 : IUIAutomationTextRange
{
    ///Programmatically invokes a context menu on the target text range.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ShowContextMenu();
}

///Extends the IUIAutomationTextRange2 interface to support faster access to the underlying rich text data on a text
///range.
@GUID("6A315D69-5512-4C2E-85F0-53FCE6DD4BC2")
interface IUIAutomationTextRange3 : IUIAutomationTextRange2
{
    ///Gets the enclosing element and supplied properties and patterns for an element in a text range in a single
    ///cross-process call. This is equivalent to calling GetEnclosingElement, but adds the standard build cache pattern.
    ///Params:
    ///    cacheRequest = An IUIAutomationCacheRequest specifying the properties and control patterns to be cached.
    ///    enclosingElement = Returns the enclosing element (and properties/patterns) of the text range if it meets the criteria of the
    ///                       supplied <i>cacheRequest</i>.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, otherwise an <b>HRESULT</b> error code.
    ///    
    HRESULT GetEnclosingElementBuildCache(IUIAutomationCacheRequest cacheRequest, 
                                          IUIAutomationElement* enclosingElement);
    ///Returns the children and supplied properties and patterns for elements in a text range in a single cross-process
    ///call. This is equivalent to calling GetChildren, but adds the standard build cache pattern.
    ///Params:
    ///    cacheRequest = An IUIAutomationCacheRequest specifying the properties and control patterns to be cached.
    ///    children = Returns the children, and each child’s properties or patterns, of the text range that meet the criteria of
    ///               the supplied <i>cacheRequest</i>.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, otherwise an <b>HRESULT</b> error code.
    ///    
    HRESULT GetChildrenBuildCache(IUIAutomationCacheRequest cacheRequest, IUIAutomationElementArray* children);
    ///Returns all of the requested text attribute values for a text range in a single cross-process call. This is
    ///equivalent to calling GetAttributeValue, except it can retrieve multiple values instead of just one.
    ///Params:
    ///    attributeIds = A list of text attribute identifiers.
    ///    attributeIdCount = The number of text attribute identifiers in the <i>attributeIds</i> list.
    ///    attributeValues = A <b>SAFEARRAY</b> of <b>VARIANT</b> containing values to corresponding text attributes for a text range.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, otherwise an <b>HRESULT</b> error code.
    ///    
    HRESULT GetAttributeValues(char* attributeIds, int attributeIdCount, SAFEARRAY** attributeValues);
}

///Represents a collection of IUIAutomationTextRange objects.
@GUID("CE4AE76A-E717-4C98-81EA-47371D028EB6")
interface IUIAutomationTextRangeArray : IUnknown
{
    ///Retrieves the number of text ranges in the collection. This property is read-only.
    HRESULT get_Length(int* length);
    ///Retrieves a text range from the collection.
    ///Params:
    ///    index = Type: <b>int</b> The zero-based index of the item.
    ///    element = Type: <b>IUIAutomationTextRange**</b> Receives a pointer to the text range.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetElement(int index, IUIAutomationTextRange* element);
}

///Provides access to a control that contains text.
@GUID("32EBA289-3583-42C9-9C59-3B6D9A1E9B6A")
interface IUIAutomationTextPattern : IUnknown
{
    ///Retrieves the degenerate (empty) text range nearest to the specified screen coordinates.
    ///Params:
    ///    pt = Type: <b>POINT</b> A structure that contains the location, in screen coordinates.
    ///    range = Type: <b>IUIAutomationTextRange**</b> Receives a pointer to the degenerate text range nearest the specified
    ///            location.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RangeFromPoint(POINT pt, IUIAutomationTextRange* range);
    ///Retrieves a text range enclosing a child element such as an image, hyperlink, Microsoft Excel spreadsheet, or
    ///other embedded object.
    ///Params:
    ///    child = Type: <b>IUIAutomationElement*</b> A pointer to the child element to be enclosed in the text range.
    ///    range = Type: <b>IUIAutomationTextRange**</b> Receives a pointer to a text range that encloses the child element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RangeFromChild(IUIAutomationElement child, IUIAutomationTextRange* range);
    ///Retrieves a collection of text ranges that represents the currently selected text in a text-based control.
    ///Params:
    ///    ranges = Type: <b>IUIAutomationTextRangeArray**</b> Receives a pointer to the collection of text ranges.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSelection(IUIAutomationTextRangeArray* ranges);
    ///Retrieves an array of disjoint text ranges from a text-based control where each text range represents a
    ///contiguous span of visible text.
    ///Params:
    ///    ranges = Type: <b>IUIAutomationTextRangeArray**</b> Receives a pointer to the collection of visible text ranges within
    ///             the text-based control.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetVisibleRanges(IUIAutomationTextRangeArray* ranges);
    ///Retrieves a text range that encloses the main text of a document. This property is read-only.
    HRESULT get_DocumentRange(IUIAutomationTextRange* range);
    ///Retrieves a value that specifies the type of text selection that is supported by the control. This property is
    ///read-only.
    ///Returns:
    ///    Type: **[HRESULT](/windows/desktop/WinProg/windows-data-types)** If this method succeeds, it returns S_OK.
    ///    Otherwise, it returns an HRESULT error code.
    ///    
    HRESULT get_SupportedTextSelection(SupportedTextSelection* supportedTextSelection);
}

///Extends the IUIAutomationTextPattern interface.
@GUID("506A921A-FCC9-409F-B23B-37EB74106872")
interface IUIAutomationTextPattern2 : IUIAutomationTextPattern
{
    ///Retrieves a text range containing the text that is the target of the annotation associated with the specified
    ///annotation element.
    ///Params:
    ///    annotation = Type: <b>IUIAutomationElement*</b> The annotation element for which to retrieve the target text. This element
    ///                 is a sibling of the element that implements IUIAutomationTextPattern2 for the document.
    ///    range = Type: <b>IUIAutomationTextRange**</b> Receives a text range that contains the target text of the annotation.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RangeFromAnnotation(IUIAutomationElement annotation, IUIAutomationTextRange* range);
    ///Retrieves a zero-length text range at the location of the caret that belongs to the text-based control.
    ///Params:
    ///    isActive = Type: <b>BOOL*</b> <b>TRUE</b> if the text-based control that contains the caret has keyboard focus,
    ///               otherwise <b>FALSE</b>.
    ///    range = Type: <b>IUIAutomationTextRange**</b> Receives a text range that represents the current location of the caret
    ///            that belongs to the text-based control.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCaretRange(int* isActive, IUIAutomationTextRange* range);
}

///Provides access to a control that modifies text, for example a control that performs auto-correction or enables input
///composition through an Input Method Editor (IME).
@GUID("17E21576-996C-4870-99D9-BFF323380C06")
interface IUIAutomationTextEditPattern : IUIAutomationTextPattern
{
    ///Returns the active composition.
    ///Params:
    ///    range = Type: <b>IUIAutomationTextRange**</b> Pointer to the range of the current conversion (none if there is no
    ///            conversion).
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetActiveComposition(IUIAutomationTextRange* range);
    ///Returns the current conversion target range.
    ///Params:
    ///    range = Type: <b>IUIAutomationTextRange**</b> Pointer to the conversion target range (none if there is no
    ///            conversion).
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetConversionTarget(IUIAutomationTextRange* range);
}

///Exposes a method to support access by a Microsoft UI Automation client to controls that support a custom navigation
///order.
@GUID("01EA217A-1766-47ED-A6CC-ACF492854B1F")
interface IUIAutomationCustomNavigationPattern : IUnknown
{
    ///Gets the next element in the specified direction within the logical UI tree.
    ///Params:
    ///    arg1 = The specified direction.
    ///    pRetVal = The next element as specified by the <i>direction</i> parameter.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Navigate(NavigateDirection direction, IUIAutomationElement* pRetVal);
}

///Exposes a method to handle Microsoft UI Automation events that occur when the active text position changes.<div
///class="alert"><b>Note</b> This interface is implemented by the application to handle events that it has subscribed to
///by calling AddActiveTextPositionChangedEventHandler. </div> <div> </div>
@GUID("F97933B0-8DAE-4496-8997-5BA015FE0D82")
interface IUIAutomationActiveTextPositionChangedEventHandler : IUnknown
{
    ///Handles a Microsoft UI Automation active text position change event.<div class="alert"><b>Note</b> This method is
    ///implemented by the application to handle events that it has subscribed to by calling
    ///AddActiveTextPositionChangedEventHandler.</div> <div> </div>
    ///Params:
    ///    sender = A pointer to the UI Automation element that raised the event.
    ///    range = A span of continuous text in a container that supports the IUIAutomationTextPattern interface.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT HandleActiveTextPositionChangedEvent(IUIAutomationElement sender, IUIAutomationTextRange range);
}

///Exposes methods and properties that enable Microsoft UI Automation clients to retrieve UI information from Microsoft
///Active Accessibility (MSAA) servers.
@GUID("828055AD-355B-4435-86D5-3B51C14A9B1B")
interface IUIAutomationLegacyIAccessiblePattern : IUnknown
{
    ///Performs a Microsoft Active Accessibility selection.
    ///Params:
    ///    flagsSelect = Type: <b>long</b> Specifies which selection or focus operations are to be performed. This parameter must have
    ///                  a combination of the values described in SELFLAG Constants.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Select(int flagsSelect);
    ///Performs the Microsoft Active Accessibility default action for the element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DoDefaultAction();
    ///Sets the Microsoft Active Accessibility value property for the element.
    ///Params:
    ///    szValue = Type: <b>LPCWSTR</b> A localized string that contains the object's value.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetValue(const(wchar)* szValue);
    ///Retrieves the Microsoft Active Accessibility child identifier for the element. This property is read-only.
    HRESULT get_CurrentChildId(int* pRetVal);
    ///Retrieves the Microsoft Active Accessibility name property of the element. This property is read-only.
    HRESULT get_CurrentName(BSTR* pszName);
    ///Retrieves the Microsoft Active Accessibility value property. This property is read-only.
    HRESULT get_CurrentValue(BSTR* pszValue);
    ///Retrieves the Microsoft Active Accessibility description of the element. This property is read-only.
    HRESULT get_CurrentDescription(BSTR* pszDescription);
    ///Retrieves the Microsoft Active Accessibility role identifier of the element. This property is read-only.
    HRESULT get_CurrentRole(uint* pdwRole);
    ///Retrieves the Microsoft Active Accessibility state identifier for the element. This property is read-only.
    HRESULT get_CurrentState(uint* pdwState);
    ///Retrieves the Microsoft Active Accessibility help string for the element. This property is read-only.
    HRESULT get_CurrentHelp(BSTR* pszHelp);
    ///Retrieves the Microsoft Active Accessibility keyboard shortcut property for the element. This property is
    ///read-only.
    HRESULT get_CurrentKeyboardShortcut(BSTR* pszKeyboardShortcut);
    ///Retrieves the Microsoft Active Accessibility property that identifies the selected children of this element.
    ///Params:
    ///    pvarSelectedChildren = Type: <b>IUIAutomationElementArray**</b> Receives a pointer to the collection of the selected child elements.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCurrentSelection(IUIAutomationElementArray* pvarSelectedChildren);
    ///Retrieves the Microsoft Active Accessibility current default action for the element. This property is read-only.
    HRESULT get_CurrentDefaultAction(BSTR* pszDefaultAction);
    ///Retrieves the cached Microsoft Active Accessibility child identifier for the element. This property is read-only.
    HRESULT get_CachedChildId(int* pRetVal);
    ///Retrieves the cached Microsoft Active Accessibility name property of the element. This property is read-only.
    HRESULT get_CachedName(BSTR* pszName);
    ///Retrieves the cached Microsoft Active Accessibility value property. This property is read-only.
    HRESULT get_CachedValue(BSTR* pszValue);
    ///Retrieves the cached Microsoft Active Accessibility description of the element. This property is read-only.
    HRESULT get_CachedDescription(BSTR* pszDescription);
    ///Retrieves the cached Microsoft Active Accessibility role of the element. This property is read-only.
    HRESULT get_CachedRole(uint* pdwRole);
    ///Retrieves the cached Microsoft Active Accessibility state identifier for the element. This property is read-only.
    HRESULT get_CachedState(uint* pdwState);
    ///Retrieves the cached Microsoft Active Accessibility help string for the element. This property is read-only.
    HRESULT get_CachedHelp(BSTR* pszHelp);
    ///Retrieves the cached Microsoft Active Accessibility keyboard shortcut property for the element. This property is
    ///read-only.
    HRESULT get_CachedKeyboardShortcut(BSTR* pszKeyboardShortcut);
    ///Retrieves the cached Microsoft Active Accessibility property that identifies the selected children of this
    ///element.
    ///Params:
    ///    pvarSelectedChildren = Type: <b>IUIAutomationElementArray**</b> Receives a pointer to the cached collection of the selected child
    ///                           elements.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCachedSelection(IUIAutomationElementArray* pvarSelectedChildren);
    ///Retrieves the Microsoft Active Accessibility cached default action for the element. This property is read-only.
    HRESULT get_CachedDefaultAction(BSTR* pszDefaultAction);
    ///Retrieves an IAccessible object that corresponds to the Microsoft UI Automation element.
    ///Params:
    ///    ppAccessible = Type: <b>IAccessible**</b> Receives a pointer to an IAccessible interface for the accessible object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetIAccessible(IAccessible* ppAccessible);
}

///Exposes a method that retrieves an item from a container, such as a virtual list.
@GUID("C690FDB2-27A8-423C-812D-429773C9084E")
interface IUIAutomationItemContainerPattern : IUnknown
{
    ///Retrieves an element within a containing element, based on a specified property value.
    ///Params:
    ///    pStartAfter = Type: <b>IUIAutomationElement*</b> A pointer to the element after which the search begins, or <b>NULL</b> to
    ///                  search all elements.
    ///    propertyId = Type: <b>PROPERTYID</b> The property identifier. For a list of property IDs, see Property Identifiers.
    ///    value = Type: <b>VARIANT</b> The property value.
    ///    pFound = Type: <b>IUIAutomationElement**</b> Receives a pointer to the matching element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT FindItemByProperty(IUIAutomationElement pStartAfter, int propertyId, VARIANT value, 
                               IUIAutomationElement* pFound);
}

///Represents an virtualized item, which is an item that is represented by a placeholder automation element in the
///Microsoft UI Automation tree.
@GUID("6BA3D7A6-04CF-4F11-8793-A8D1CDE9969F")
interface IUIAutomationVirtualizedItemPattern : IUnknown
{
    ///Creates a full UI Automation element for a virtualized item.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Realize();
}

///Provides access to the properties of an annotation in a document.
@GUID("9A175B21-339E-41B1-8E8B-623F6B681098")
interface IUIAutomationAnnotationPattern : IUnknown
{
    ///Retrieves a value that identifies the annotation's type. This property is read-only.
    HRESULT get_CurrentAnnotationTypeId(int* retVal);
    ///Retrieves the localized name of this annotation's type. This property is read-only.
    HRESULT get_CurrentAnnotationTypeName(BSTR* retVal);
    ///Retrieves the name of the annotation author. This property is read-only.
    HRESULT get_CurrentAuthor(BSTR* retVal);
    ///Retrieves the date and time that this annotation was created. This property is read-only.
    HRESULT get_CurrentDateTime(BSTR* retVal);
    ///Retrieves the element that is being annotated. This property is read-only.
    HRESULT get_CurrentTarget(IUIAutomationElement* retVal);
    ///Retrieves a cached value that identifies this annotation's type. This property is read-only.
    HRESULT get_CachedAnnotationTypeId(int* retVal);
    ///Retrieves the cached localized name of this annotation's type. This property is read-only.
    HRESULT get_CachedAnnotationTypeName(BSTR* retVal);
    ///Retrieves the cached name of the annotation author. This property is read-only.
    HRESULT get_CachedAuthor(BSTR* retVal);
    ///Retrieves the cached date and time that this annotation was created. This property is read-only.
    HRESULT get_CachedDateTime(BSTR* retVal);
    ///Retrieves the cached element that is being annotated. This property is read-only.
    HRESULT get_CachedTarget(IUIAutomationElement* retVal);
}

///Enables Microsoft UI Automation clients to retrieve the visual styles associated with an element in a document.
@GUID("85B5F0A2-BD79-484A-AD2B-388C9838D5FB")
interface IUIAutomationStylesPattern : IUnknown
{
    ///Retrieves the identifier of the visual style associated with an element in a document. This property is
    ///read-only.
    HRESULT get_CurrentStyleId(int* retVal);
    ///Retrieves the name of the visual style associated with an element in a document. This property is read-only.
    HRESULT get_CurrentStyleName(BSTR* retVal);
    ///Retrieves the fill color of an element in a document. This property is read-only.
    HRESULT get_CurrentFillColor(int* retVal);
    HRESULT get_CurrentFillPatternStyle(BSTR* retVal);
    ///Retrieves the shape of an element in a document. This property is read-only.
    HRESULT get_CurrentShape(BSTR* retVal);
    ///Retrieves the color of the pattern used to fill an element in a document. This property is read-only.
    HRESULT get_CurrentFillPatternColor(int* retVal);
    ///Retrieves a localized string that contains the list of extended properties for an element in a document. This
    ///property is read-only.
    HRESULT get_CurrentExtendedProperties(BSTR* retVal);
    HRESULT GetCurrentExtendedPropertiesAsArray(char* propertyArray, int* propertyCount);
    ///Retrieves the cached identifier of the visual style associated with an element in a document. This property is
    ///read-only.
    HRESULT get_CachedStyleId(int* retVal);
    ///Retrieves the cached name of the visual style associated with an element in a document. This property is
    ///read-only.
    HRESULT get_CachedStyleName(BSTR* retVal);
    ///Retrieves the cached fill color of an element in a document. This property is read-only.
    HRESULT get_CachedFillColor(int* retVal);
    HRESULT get_CachedFillPatternStyle(BSTR* retVal);
    ///Retrieves the cached shape of an element in a document. This property is read-only.
    HRESULT get_CachedShape(BSTR* retVal);
    ///Retrieves the cached color of the pattern used to fill an element in a document. This property is read-only.
    HRESULT get_CachedFillPatternColor(int* retVal);
    ///Retrieves a cached localized string that contains the list of extended properties for an element in a document.
    ///This property is read-only.
    HRESULT get_CachedExtendedProperties(BSTR* retVal);
    HRESULT GetCachedExtendedPropertiesAsArray(char* propertyArray, int* propertyCount);
}

///Enables a client application to access the items (cells) in a spreadsheet.
@GUID("7517A7C8-FAAE-4DE9-9F08-29B91E8595C1")
interface IUIAutomationSpreadsheetPattern : IUnknown
{
    ///Retrieves a UI Automation element that represents the spreadsheet cell that has the specified name.
    ///Params:
    ///    name = Type: <b>BSTR</b> The name of the target cell.
    ///    element = Type: <b>IUIAutomationElement**</b> Receives the element that represents the target cell.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetItemByName(BSTR name, IUIAutomationElement* element);
}

///Enables a client application to retrieve information about an item (cell) in a spreadsheet.
@GUID("7D4FB86C-8D34-40E1-8E83-62C15204E335")
interface IUIAutomationSpreadsheetItemPattern : IUnknown
{
    ///Retrieves the formula for this cell. This property is read-only.
    HRESULT get_CurrentFormula(BSTR* retVal);
    ///Retrieves an array of elements representing the annotations associated with this spreadsheet cell.
    ///Params:
    ///    retVal = Type: <b>IUIAutomationElementArray**</b> Receives the array of annotation elements for this spreadsheet cell.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCurrentAnnotationObjects(IUIAutomationElementArray* retVal);
    ///Retrieves an array of annotation type identifiers indicating the types of annotations that are associated with
    ///this spreadsheet cell.
    ///Params:
    ///    retVal = Type: <b>SAFEARRAY**</b> Receives the array of annotation type identifiers. For a list of possible values,
    ///             see Annotation Type Identifiers.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCurrentAnnotationTypes(SAFEARRAY** retVal);
    ///Retrieves the cached formula for this cell. This property is read-only.
    HRESULT get_CachedFormula(BSTR* retVal);
    ///Retrieves a cached array of elements representing the annotations associated with this spreadsheet cell.
    ///Params:
    ///    retVal = Type: <b>IUIAutomationElementArray**</b> Receives the cached array of annotation elements for this
    ///             spreadsheet cell.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCachedAnnotationObjects(IUIAutomationElementArray* retVal);
    ///Retrieves a cached array of annotation type identifiers indicating the types of annotations that are associated
    ///with this spreadsheet cell.
    ///Params:
    ///    retVal = Type: <b>SAFEARRAY**</b> Receives the cached array of annotation type identifiers. For a list of possible
    ///             values, see Annotation Type Identifiers.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCachedAnnotationTypes(SAFEARRAY** retVal);
}

///Extends the IUIAutomationTransformPattern interface to enable Microsoft UI Automation clients to programmatically
///access the viewport zooming functionality of a control.
@GUID("6D74D017-6ECB-4381-B38B-3C17A48FF1C2")
interface IUIAutomationTransformPattern2 : IUIAutomationTransformPattern
{
    ///Zooms the viewport of the control.
    ///Params:
    ///    zoomValue = Type: <b>double</b> The amount to zoom the viewport, specified as a percentage. Positive values increase the
    ///                zoom level, and negative values decrease it. The control zooms its viewport to the nearest supported value.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Zoom(double zoomValue);
    ///Zooms the viewport of the control by the specified unit.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ZoomByUnit(ZoomUnit zoomUnit);
    ///Indicates whether the control supports zooming of its viewport. This property is read-only.
    HRESULT get_CurrentCanZoom(int* retVal);
    ///Retrieves a cached value that indicates whether the control supports zooming of its viewport. This property is
    ///read-only.
    HRESULT get_CachedCanZoom(int* retVal);
    ///Retrieves the zoom level of the control's viewport. This property is read-only.
    HRESULT get_CurrentZoomLevel(double* retVal);
    ///Retrieves the cached zoom level of the control's viewport. This property is read-only.
    HRESULT get_CachedZoomLevel(double* retVal);
    ///Retrieves the minimum zoom level of the control's viewport. This property is read-only.
    HRESULT get_CurrentZoomMinimum(double* retVal);
    ///Retrieves the cached minimum zoom level of the control's viewport. This property is read-only.
    HRESULT get_CachedZoomMinimum(double* retVal);
    ///Retrieves the maximum zoom level of the control's viewport. This property is read-only.
    HRESULT get_CurrentZoomMaximum(double* retVal);
    ///Retrieves the cached maximum zoom level of the control's viewport. This property is read-only.
    HRESULT get_CachedZoomMaximum(double* retVal);
}

///Provides access a text-based control (or an object embedded in text) that is a child or descendant of another
///text-based control.
@GUID("6552B038-AE05-40C8-ABFD-AA08352AAB86")
interface IUIAutomationTextChildPattern : IUnknown
{
    ///Retrieves this element's nearest ancestor element that supports the Text control pattern. This property is
    ///read-only.
    HRESULT get_TextContainer(IUIAutomationElement* container);
    ///Retrieves a text range that encloses this child element. This property is read-only.
    HRESULT get_TextRange(IUIAutomationTextRange* range);
}

///Provides access to information exposed by a UI Automation provider for an element that can be dragged as part of a
///drag-and-drop operation.
@GUID("1DC7B570-1F54-4BAD-BCDA-D36A722FB7BD")
interface IUIAutomationDragPattern : IUnknown
{
    ///Indicates whether the user has grabbed this element as part of a drag-and-drop operation. This property is
    ///read-only.
    HRESULT get_CurrentIsGrabbed(int* retVal);
    ///Retrieves a cached value that indicates whether this element has been grabbed as part of a drag-and-drop
    ///operation. This property is read-only.
    HRESULT get_CachedIsGrabbed(int* retVal);
    ///Retrieves a localized string that indicates what happens when the user drops this element as part of a drag-drop
    ///operation. This property is read-only.
    HRESULT get_CurrentDropEffect(BSTR* retVal);
    ///Retrieves a cached localized string that indicates what happens when the user drops this element as part of a
    ///drag-and-drop operation. This property is read-only.
    HRESULT get_CachedDropEffect(BSTR* retVal);
    ///Retrieves an array of localized strings that enumerate the full set of effects that can happen when this element
    ///as part of a drag-and-drop operation. This property is read-only.
    HRESULT get_CurrentDropEffects(SAFEARRAY** retVal);
    ///Retrieves a cached array of localized strings that enumerate the full set of effects that can happen when the
    ///user drops this element as part of a drag-and-drop operation. This property is read-only.
    HRESULT get_CachedDropEffects(SAFEARRAY** retVal);
    ///Retrieves a collection of elements that represent the full set of items that the user is dragging as part of a
    ///drag operation.
    ///Params:
    ///    retVal = Type: <b>IAutomationElementArray**</b> The collection of elements that the user is dragging. This property is
    ///             <b>NULL</b> or an empty array if only a single item is being dragged. The default value is an empty array.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCurrentGrabbedItems(IUIAutomationElementArray* retVal);
    ///Retrieves a cached collection of elements that represent the full set of items that the user is dragging as part
    ///of a drag operation.
    ///Params:
    ///    retVal = Type: <b>IAutomationElementArray**</b> The cached collection of elements that the user is dragging. This
    ///             property is <b>NULL</b> or an empty array if only a single item is being dragged. The default value is an
    ///             empty array.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCachedGrabbedItems(IUIAutomationElementArray* retVal);
}

///Provides access to drag-and-drop information exposed by a Microsoft UI Automation provider for an element that can be
///the drop target of a drag-and-drop operation.
@GUID("69A095F7-EEE4-430E-A46B-FB73B1AE39A5")
interface IUIAutomationDropTargetPattern : IUnknown
{
    ///Retrieves a localized string that describes what happens when the user drops the grabbed element on this drop
    ///target. This property is read-only.
    HRESULT get_CurrentDropTargetEffect(BSTR* retVal);
    ///Retrieves a cached localized string that describes what happens when the user drops the grabbed element on this
    ///drop target. This property is read-only.
    HRESULT get_CachedDropTargetEffect(BSTR* retVal);
    ///Retrieves an array of localized strings that enumerate the full set of effects that can happen when the user
    ///drops a grabbed element on this drop target as part of a drag-and-drop operation. This property is read-only.
    HRESULT get_CurrentDropTargetEffects(SAFEARRAY** retVal);
    ///Retrieves a cached array of localized strings that enumerate the full set of effects that can happen when the
    ///user drops a grabbed element on this drop target as part of a drag-and-drop operation. This property is
    ///read-only.
    HRESULT get_CachedDropTargetEffects(SAFEARRAY** retVal);
}

///Extends the IUIAutomationElement interface.
@GUID("6749C683-F70D-4487-A698-5F79D55290D6")
interface IUIAutomationElement2 : IUIAutomationElement
{
    ///Indicates whether the provider exposes only elements that are visible. This property is read-only.
    HRESULT get_CurrentOptimizeForVisualContent(int* retVal);
    ///Retrieves a cached value that indicates whether the provider exposes only elements that are visible. This
    ///property is read-only.
    HRESULT get_CachedOptimizeForVisualContent(int* retVal);
    ///Indicates the type of notifications, if any, that the element sends when the content of the element changes. This
    ///property is read-only.
    HRESULT get_CurrentLiveSetting(LiveSetting* retVal);
    ///Retrieves a cached value that indicates the type of notifications, if any, that the element sends when the
    ///content of the element changes. This property is read-only.
    HRESULT get_CachedLiveSetting(LiveSetting* retVal);
    ///Retrieves an array of elements that indicates the reading order before the current element. This property is
    ///read/write.
    HRESULT get_CurrentFlowsFrom(IUIAutomationElementArray* retVal);
    ///Retrieves a cached array of elements that indicate the reading order before the current element. This property is
    ///read/write.
    HRESULT get_CachedFlowsFrom(IUIAutomationElementArray* retVal);
}

///Extends the IUIAutomationElement2 interface.
@GUID("8471DF34-AEE0-4A01-A7DE-7DB9AF12C296")
interface IUIAutomationElement3 : IUIAutomationElement2
{
    ///Programmatically invokes a context menu on the target element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ShowContextMenu();
    ///Retrieves the current peripheral UI indicator for the element. This property is read-only.
    HRESULT get_CurrentIsPeripheral(int* retVal);
    ///Retrieves the cached peripheral UI indicator for the element. Peripheral UI appears and supports user
    ///interaction, but does not take keyboard focus when it appears. Examples of peripheral UI includes popups,
    ///flyouts, context menus, or floating notifications. This property is read-only.
    HRESULT get_CachedIsPeripheral(int* retVal);
}

///Extends the IUIAutomationElement3 interface.
@GUID("3B6E233C-52FB-4063-A4C9-77C075C2A06B")
interface IUIAutomationElement4 : IUIAutomationElement3
{
    ///Returns the current 1-based integer for the ordinal position in the set for the element. This property is
    ///read-only.
    HRESULT get_CurrentPositionInSet(int* retVal);
    ///Returns the current 1-based integer for the size of the set where the element is located. This property is
    ///read-only.
    HRESULT get_CurrentSizeOfSet(int* retVal);
    ///Returns the current 1-based integer for the level (hierarchy) for the element. This property is read-only.
    HRESULT get_CurrentLevel(int* retVal);
    ///Returns the current list of annotation types associated with this element, such as comment, header, footer, and
    ///so on. This property is read-only.
    HRESULT get_CurrentAnnotationTypes(SAFEARRAY** retVal);
    ///Returns the current list of annotation objects associated with this element, such as comment, header, footer, and
    ///so on. This property is read-only.
    HRESULT get_CurrentAnnotationObjects(IUIAutomationElementArray* retVal);
    ///Returns the cached 1-based integer for the ordinal position in the set for the element. This property is
    ///read-only.
    HRESULT get_CachedPositionInSet(int* retVal);
    ///Returns the cached 1-based integer for the size of the set where the element is located. This property is
    ///read-only.
    HRESULT get_CachedSizeOfSet(int* retVal);
    ///Returns the cached 1-based integer for the level (hierarchy) for the element. This property is read-only.
    HRESULT get_CachedLevel(int* retVal);
    ///Returns the cached list of annotation types associated with this element, such as comment, header, footer, and so
    ///on. This property is read-only.
    HRESULT get_CachedAnnotationTypes(SAFEARRAY** retVal);
    ///Returns the cached list of annotation objects associated with this element, such as comment, header, footer, and
    ///so on. This property is read-only.
    HRESULT get_CachedAnnotationObjects(IUIAutomationElementArray* retVal);
}

///Extends the IUIAutomationElement4 interface to provide access to current and cached landmark data.
@GUID("98141C1D-0D0E-4175-BBE2-6BFF455842A7")
interface IUIAutomationElement5 : IUIAutomationElement4
{
    ///Gets the current landmark type ID for the automation element. This property is read-only.
    HRESULT get_CurrentLandmarkType(int* retVal);
    ///Gets a string containing the current localized landmark type for the automation element. This property is
    ///read-only.
    HRESULT get_CurrentLocalizedLandmarkType(BSTR* retVal);
    ///Gets the cached landmark type ID for the automation element. This property is read-only.
    HRESULT get_CachedLandmarkType(int* retVal);
    ///Gets a string containing the cached localized landmark type for the automation element. This property is
    ///read-only.
    HRESULT get_CachedLocalizedLandmarkType(BSTR* retVal);
}

///Extends the IUIAutomationElement5 interface to provide access to current and cached full descriptions.
@GUID("4780D450-8BCA-4977-AFA5-A4A517F555E3")
interface IUIAutomationElement6 : IUIAutomationElement5
{
    ///Gets the current full description of the automation element. This property is read-only.
    HRESULT get_CurrentFullDescription(BSTR* retVal);
    ///Gets the cached full description of the automation element. This property is read-only.
    HRESULT get_CachedFullDescription(BSTR* retVal);
}

///Extends the IUIAutomationElement6 interface.
@GUID("204E8572-CFC3-4C11-B0C8-7DA7420750B7")
interface IUIAutomationElement7 : IUIAutomationElement6
{
    ///Finds the first matching element in the specified order.
    ///Params:
    ///    arg1 = A combination of values specifying the scope of the search.
    ///    condition = A pointer to a condition that represents the criteria to match.
    ///    arg3 = Enumeration value specifying the tree navigation order.
    ///    root = A pointer to the element with which to begin the search.
    ///    found = Receives a pointer to the element. <b>NULL</b> is returned if no matching element is found.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, otherwise an <b>HRESULT</b> error code.
    ///    
    HRESULT FindFirstWithOptions(TreeScope scope_, IUIAutomationCondition condition, 
                                 TreeTraversalOptions traversalOptions, IUIAutomationElement root, 
                                 IUIAutomationElement* found);
    ///Find all matching elements in the specified order.
    ///Params:
    ///    arg1 = A combination of values specifying the scope of the search.
    ///    condition = A pointer to a condition that represents the criteria to match.
    ///    arg3 = Enumeration value specifying the tree navigation order.
    ///    root = A pointer to the element with which to begin the search.
    ///    found = Receives a pointer to an array of matching elements. Returns an empty array if no matching element is found.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, otherwise an <b>HRESULT</b> error code.
    ///    
    HRESULT FindAllWithOptions(TreeScope scope_, IUIAutomationCondition condition, 
                               TreeTraversalOptions traversalOptions, IUIAutomationElement root, 
                               IUIAutomationElementArray* found);
    ///Finds the first matching element in the specified order, but also caches its properties and pattern.
    ///Params:
    ///    arg1 = A combination of values specifying the scope of the search.
    ///    condition = A pointer to a condition that represents the criteria to match.
    ///    cacheRequest = A pointer to a cache request that specifies the control patterns and properties to include in the cache.
    ///    arg4 = Enumeration value specifying the tree navigation order.
    ///    root = A pointer to the element with which to begin the search.
    ///    found = Receives a pointer to the element. <b>NULL</b> is returned if no matching element is found.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, otherwise an <b>HRESULT</b> error code.
    ///    
    HRESULT FindFirstWithOptionsBuildCache(TreeScope scope_, IUIAutomationCondition condition, 
                                           IUIAutomationCacheRequest cacheRequest, 
                                           TreeTraversalOptions traversalOptions, IUIAutomationElement root, 
                                           IUIAutomationElement* found);
    ///Finds all matching elements in the specified order, but also caches their properties and patterns.
    ///Params:
    ///    scope = Type: <b>[TreeScope](ne-uiautomationclient-treescope.md)</b> The scope of the request. When an element is
    ///            retrieved, caching can be performed for only the element itself (the default behavior), or for the element
    ///            and its children or descendants. This property describes the scope of the request.
    ///    condition = Type: <b>[IUIAutomationCondition](nn-uiautomationclient-iuiautomationcondition.md)</b> The primary interface
    ///                for conditions used in filtering when searching for elements in the UI Automation tree.
    ///    cacheRequest = Type: <b>[IUIAutomationCacheRequest](nn-uiautomationclient-iuiautomationcacherequest.md)</b> A pointer to a
    ///                   cache request that specifies the control patterns and properties to include in the cache.
    ///    traversalOptions = Type: <b>[TreeTraversalOptions](ne-uiautomationclient-treetraversaloptions.md)</b> The tree navigation order.
    ///    root = Type: <b>[IUIAutomationElement](nn-uiautomationclient-iuiautomationelement.md)</b> A pointer to the element
    ///           with which to begin the search.
    ///    found = Receives a pointer to an array of matching elements. Returns an empty array if no matching element is found.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, otherwise an <b>HRESULT</b> error code.
    ///    
    HRESULT FindAllWithOptionsBuildCache(TreeScope scope_, IUIAutomationCondition condition, 
                                         IUIAutomationCacheRequest cacheRequest, 
                                         TreeTraversalOptions traversalOptions, IUIAutomationElement root, 
                                         IUIAutomationElementArray* found);
    ///Gets metadata from the UI Automation element that indicates how the information should be interpreted. For
    ///example, should the string "1/4" be interpreted as a fraction or a date?
    ///Params:
    ///    targetId = The ID of the property to retrieve.
    ///    metadataId = Specifies the type of metadata to retrieve.
    ///    returnVal = The metadata.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, otherwise an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCurrentMetadataValue(int targetId, int metadataId, VARIANT* returnVal);
}

///Extends the IUIAutomationElement7 interface.
@GUID("8C60217D-5411-4CDE-BCC0-1CEDA223830C")
interface IUIAutomationElement8 : IUIAutomationElement7
{
    ///Gets the current heading level of the automation element. This property is read-only.
    HRESULT get_CurrentHeadingLevel(int* retVal);
    ///Gets the cached heading level of the automation element. This property is read-only.
    HRESULT get_CachedHeadingLevel(int* retVal);
}

///Extends the [IUIAutomationElement8](nn-uiautomationclient-iuiautomationelement8.md) interface.
@GUID("39325FAC-039D-440E-A3A3-5EB81A5CECC3")
interface IUIAutomationElement9 : IUIAutomationElement8
{
    ///Retrieves the current dialog window indicator for the element. This property is read-only.
    HRESULT get_CurrentIsDialog(int* retVal);
    ///Retrieves the cached dialog window indicator for the element. This property is read-only.
    HRESULT get_CachedIsDialog(int* retVal);
}

///Exposes properties and methods of an object that creates a Microsoft UI Automation provider for UI elements that do
///not have native support for UI Automation. This interface is implemented by proxies.
@GUID("85B94ECD-849D-42B6-B94D-D6DB23FDF5A4")
interface IUIAutomationProxyFactory : IUnknown
{
    ///Creates a proxy object that provides Microsoft UI Automation support for a UI element.
    ///Params:
    ///    hwnd = Type: <b>UIA_HWND</b> The window handle of the UI element.
    ///    idObject = Type: <b>LONG</b> The object ID. See Remarks.
    ///    idChild = Type: <b>LONG</b> The child ID. See Remarks.
    ///    provider = Type: <b>IRawElementProviderSimple**</b> Receives a pointer to the proxy object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateProvider(void* hwnd, int idObject, int idChild, IRawElementProviderSimple* provider);
    ///Retrieves the identifier of the proxy factory. This property is read-only.
    HRESULT get_ProxyFactoryId(BSTR* factoryId);
}

///Represents a proxy factory in the table maintained by Microsoft UI Automation, and exposes properties and methods
///that can be used by client applications to interact with IUIAutomationProxyFactory objects.
@GUID("D50E472E-B64B-490C-BCA1-D30696F9F289")
interface IUIAutomationProxyFactoryEntry : IUnknown
{
    ///Retrieves the proxy factory associated with this entry. This property is read-only.
    HRESULT get_ProxyFactory(IUIAutomationProxyFactory* factory);
    ///Sets or retrieves the name of the window class served by the proxy factory. This property is read/write.
    HRESULT get_ClassName(BSTR* className);
    ///Sets or retrieves the name of the image of the proxy factory. This property is read/write.
    HRESULT get_ImageName(BSTR* imageName);
    ///Sets or retrieves a value that specifies whether the proxy allows substring matching. This property is
    ///read/write.
    HRESULT get_AllowSubstringMatch(int* allowSubstringMatch);
    ///Sets or retrieves a value that specifies whether the base class can be checked when searching for a proxy
    ///factory. This property is read/write.
    HRESULT get_CanCheckBaseClass(int* canCheckBaseClass);
    ///Sets or retrieves a value that specifies whether the proxy must be notified when an application has registered
    ///for events. This property is read/write.
    HRESULT get_NeedsAdviseEvents(int* adviseEvents);
    ///Sets or retrieves the name of the window class served by the proxy factory. This property is read/write.
    HRESULT put_ClassName(const(wchar)* className);
    ///Sets or retrieves the name of the image of the proxy factory. This property is read/write.
    HRESULT put_ImageName(const(wchar)* imageName);
    ///Sets or retrieves a value that specifies whether the proxy allows substring matching. This property is
    ///read/write.
    HRESULT put_AllowSubstringMatch(BOOL allowSubstringMatch);
    ///Sets or retrieves a value that specifies whether the base class can be checked when searching for a proxy
    ///factory. This property is read/write.
    HRESULT put_CanCheckBaseClass(BOOL canCheckBaseClass);
    ///Sets or retrieves a value that specifies whether the proxy must be notified when an application has registered
    ///for events. This property is read/write.
    HRESULT put_NeedsAdviseEvents(BOOL adviseEvents);
    ///Maps Microsoft UI Automation events to WinEvents.
    ///Params:
    ///    eventId = Type: <b>EVENTID</b> The event identifier. For a list of event identifiers, see Event Identifiers.
    ///    propertyId = Type: <b>PROPERTYID</b> The property identifier. For a list of property IDs, see Property Identifiers.
    ///    winEvents = Type: <b>SAFEARRAY*</b> The list of WinEvents that map to this event.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetWinEventsForAutomationEvent(int eventId, int propertyId, SAFEARRAY* winEvents);
    ///Retrieves the list of WinEvents that are mapped to a specific Microsoft UI Automation event. If an element
    ///represented by this proxy raises one the listed WinEvents, the proxy handles it.
    ///Params:
    ///    eventId = Type: <b>EVENTID</b> The event identifier. For a list of event identifiers, see Event Identifiers.
    ///    propertyId = Type: <b>PROPERTYID</b> The property identifier. For a list of property IDs, see Property Identifiers.
    ///    winEvents = Type: <b>SAFEARRAY**</b> Receives a pointer to the list of WinEvents that map to this event.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetWinEventsForAutomationEvent(int eventId, int propertyId, SAFEARRAY** winEvents);
}

///Exposes properties and methods for a table of proxy factories. Each table entry is represented by an
///IUIAutomationProxyFactoryEntry interface. The entries are in the order in which the system will attempt to use the
///proxies.
@GUID("09E31E18-872D-4873-93D1-1E541EC133FD")
interface IUIAutomationProxyFactoryMapping : IUnknown
{
    ///Retrieves the number of entries in the proxy factory table. This property is read-only.
    HRESULT get_Count(uint* count);
    ///Retrieves all entries in the proxy factory table.
    ///Params:
    ///    table = Type: <b>SAFEARRAY**</b> Receives a pointer to an array of table entries.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetTable(SAFEARRAY** table);
    ///Retrieves an entry from the proxy factory table.
    ///Params:
    ///    index = Type: <b>UINT</b> The zero-based index of the item to retrieve.
    ///    entry = Type: <b>IUIAutomationProxyFactoryEntry**</b> Receives a pointer to the entry.
    HRESULT GetEntry(uint index, IUIAutomationProxyFactoryEntry* entry);
    ///Sets the table of proxy factories.
    ///Params:
    ///    factoryList = Type: <b>SAFEARRAY*</b> A pointer to the proxy factories to include in the table.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetTable(SAFEARRAY* factoryList);
    ///Inserts entries into the table of proxy factories.
    ///Params:
    ///    before = Type: <b>UINT</b> The zero-based index at which to insert the entries.
    ///    factoryList = Type: <b>SAFEARRAY*</b> A pointer to the entries to insert into the table.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT InsertEntries(uint before, SAFEARRAY* factoryList);
    ///Insert an entry into the table of proxy factories.
    ///Params:
    ///    before = Type: <b>UINT</b> The zero-based index at which to insert the entry.
    ///    factory = Type: <b>IUIAutomationProxyFactoryEntry*</b> The address of the entry to insert.
    HRESULT InsertEntry(uint before, IUIAutomationProxyFactoryEntry factory);
    ///Removes an entry from the table of proxy factories.
    ///Params:
    ///    index = Type: <b>UINT</b> The zero-based index of the entry to remove.
    HRESULT RemoveEntry(uint index);
    ///Removes all entries from the proxy factory table.
    HRESULT ClearTable();
    ///Restores the default table of proxy factories.
    HRESULT RestoreDefaultTable();
}

///Exposes methods for adding one or more events to a collection for bulk registration through the
///CreateEventHandlerGroup and AddEventHandlerGroup methods defined in IUIAutomation6. <div
///class="alert"><b>Important</b> Microsoft UI Automation clients should use the handler group methods to register event
///listeners instead of individual event registration methods defined in the various IUIAutomation namespaces.</div>
///<div> </div>
@GUID("C9EE12F2-C13B-4408-997C-639914377F4E")
interface IUIAutomationEventHandlerGroup : IUnknown
{
    ///Registers a method (in an event handler group) that handles when the active text position changes.<div
    ///class="alert"><b>Important</b> Microsoft UI Automation clients should use the handler group methods to register
    ///event listeners instead of individual event registration methods defined in the various IUIAutomation
    ///namespaces.</div> <div> </div>
    ///Params:
    ///    arg1 = The scope of events to be handled; that is, whether they are on the element itself, or on its ancestors and
    ///           descendants.
    ///    cacheRequest = A pointer to a cache request, or <b>NULL</b> if no caching is wanted.
    ///    handler = A pointer to the object that handles the active text position changed event.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddActiveTextPositionChangedEventHandler(TreeScope scope_, IUIAutomationCacheRequest cacheRequest, 
                                                     IUIAutomationActiveTextPositionChangedEventHandler handler);
    ///Registers a method that handles Microsoft UI Automation events. <div class="alert"><b>Important</b> UI Automation
    ///clients should use the handler group methods to register event listeners instead of individual event registration
    ///methods defined in the various IUIAutomation namespaces.</div><div> </div>
    ///Params:
    ///    eventId = The identifier of the event that the method handles. For a list of event IDs, see Event Identifiers.
    ///    arg2 = The scope of events to be handled; that is, whether they are on the element itself, or on its ancestors and
    ///           descendants.
    ///    cacheRequest = A pointer to a cache request, or <b>NULL</b> if no caching is wanted.
    ///    handler = A pointer to the object that handles the event.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddAutomationEventHandler(int eventId, TreeScope scope_, IUIAutomationCacheRequest cacheRequest, 
                                      IUIAutomationEventHandler handler);
    ///Registers a method that handles change events. <div class="alert"><b>Important</b> Microsoft UI Automation
    ///clients should use the handler group methods to register event listeners instead of individual event registration
    ///methods defined in the various IUIAutomation namespaces.</div><div> </div>
    ///Params:
    ///    arg1 = The scope of events to be handled; that is, whether they are on the element itself, or on its ancestors and
    ///           descendants.
    ///    changeTypes = A pointer to a list of integers that indicate the change types the event represents.
    ///    changesCount = The number of changes that occurred in this event.
    ///    cacheRequest = A pointer to a cache request, or <b>NULL</b> if no caching is wanted.
    ///    handler = A pointer to the object that handles the changes event.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddChangesEventHandler(TreeScope scope_, char* changeTypes, int changesCount, 
                                   IUIAutomationCacheRequest cacheRequest, IUIAutomationChangesEventHandler handler);
    ///Registers a method that handles notification events. <div class="alert"><b>Important</b> Microsoft UI Automation
    ///clients should use the handler group methods to register event listeners instead of individual event registration
    ///methods defined in the various IUIAutomation namespaces.</div><div> </div>
    ///Params:
    ///    arg1 = The scope of events to be handled; that is, whether they are on the element itself, or on its ancestors and
    ///           descendants.
    ///    cacheRequest = A pointer to a cache request, or <b>NULL</b> if no caching is wanted.
    ///    handler = A pointer to the object that handles the notification event.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddNotificationEventHandler(TreeScope scope_, IUIAutomationCacheRequest cacheRequest, 
                                        IUIAutomationNotificationEventHandler handler);
    ///Registers a method that handles a property-changed event. <div class="alert"><b>Important</b> Microsoft UI
    ///Automation clients should use the handler group methods to register event listeners instead of individual event
    ///registration methods defined in the various IUIAutomation namespaces.</div><div> </div>
    ///Params:
    ///    arg1 = The scope of events to be handled; that is, whether they are on the element itself, or on its ancestors and
    ///           children.
    ///    cacheRequest = A pointer to a cache request, or <b>NULL</b> if no caching is wanted.
    ///    handler = A pointer to the object that handles the event.
    ///    propertyArray = A pointer to the UI Automation properties of interest. For a list of property IDs, see Property Identifiers.
    ///    propertyCount = The number of properties being monitored.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddPropertyChangedEventHandler(TreeScope scope_, IUIAutomationCacheRequest cacheRequest, 
                                           IUIAutomationPropertyChangedEventHandler handler, char* propertyArray, 
                                           int propertyCount);
    ///Registers a method that handles structure-changed events. <div class="alert"><b>Important</b> Microsoft UI
    ///Automation clients should use the handler group methods to register event listeners instead of individual event
    ///registration methods defined in the various IUIAutomation namespaces.</div><div> </div>
    ///Params:
    ///    arg1 = The scope of events to be handled; that is, whether they are on the element itself, or on its ancestors and
    ///           descendants.
    ///    cacheRequest = A pointer to a cache request, or <b>NULL</b> if no caching is wanted.
    ///    handler = A pointer to the object that handles the structure-changed event.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddStructureChangedEventHandler(TreeScope scope_, IUIAutomationCacheRequest cacheRequest, 
                                            IUIAutomationStructureChangedEventHandler handler);
    ///Registers a method that handles programmatic text-edit events. <div class="alert"><b>Important</b> Microsoft UI
    ///Automation clients should use the handler group methods to register event listeners instead of individual event
    ///registration methods defined in the various IUIAutomation namespaces.</div><div> </div>
    ///Params:
    ///    arg1 = The scope of events to be handled; that is, whether they are on the element itself, or on its ancestors and
    ///           descendants.
    ///    arg2 = The specific change type to listen for. Clients register for each text-edit change type separately, so that
    ///           the UI Automation system can check for registered listeners at run-time and avoid raising events for
    ///           particular text-edit changes when there are no listeners.
    ///    cacheRequest = A pointer to a cache request, or <b>NULL</b> if no caching is wanted.
    ///    handler = A pointer to the object that handles the programmatic text-edit event.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddTextEditTextChangedEventHandler(TreeScope scope_, TextEditChangeType textEditChangeType, 
                                               IUIAutomationCacheRequest cacheRequest, 
                                               IUIAutomationTextEditTextChangedEventHandler handler);
}

///Exposes methods that enable Microsoft UI Automation client applications to discover, access, and filter UI Automation
///elements. UI Automation exposes every element of the UI Automation as an object represented by the
///<b>IUIAutomation</b> interface. The members of this interface are not specific to a particular element.
@GUID("30CBE57D-D9D0-452A-AB13-7AC5AC4825EE")
interface IUIAutomation : IUnknown
{
    ///Compares two UI Automation elements to determine whether they represent the same underlying UI element.
    ///Params:
    ///    el1 = Type: <b>IUIAutomationElement*</b> A pointer to the first element to compare.
    ///    el2 = Type: <b>IUIAutomationElement*</b> A pointer to the second element to compare.
    ///    areSame = Type: <b>BOOL*</b> Receives <b>TRUE</b> if the run-time identifiers of the elements are the same, or
    ///              <b>FALSE</b> otherwise.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CompareElements(IUIAutomationElement el1, IUIAutomationElement el2, int* areSame);
    ///Compares two integer arrays containing run-time identifiers (IDs) to determine whether their content is the same
    ///and they belong to the same UI element.
    ///Params:
    ///    runtimeId1 = Type: <b>SAFEARRAY*</b> The first ID to compare.
    ///    runtimeId2 = Type: <b>SAFEARRAY*</b> The second ID to compare
    ///    areSame = Type: <b>BOOL*</b> Receives <b>TRUE</b> if the IDs are the same, or <b>FALSE</b> otherwise.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CompareRuntimeIds(SAFEARRAY* runtimeId1, SAFEARRAY* runtimeId2, int* areSame);
    ///Retrieves the UI Automation element that represents the desktop.
    ///Params:
    ///    root = Type: <b>IUIAutomationElement**</b> Receives a pointer to the UI Automation element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetRootElement(IUIAutomationElement* root);
    ///Retrieves a UI Automation element for the specified window.
    ///Params:
    ///    hwnd = Type: <b>UIA_HWND</b> The window handle.
    ///    element = Type: <b>IUIAutomationElement**</b> Receives a pointer to the element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ElementFromHandle(void* hwnd, IUIAutomationElement* element);
    ///Retrieves the UI Automation element at the specified point on the desktop.
    ///Params:
    ///    pt = Type: <b>POINT</b> The desktop coordinates of the UI Automation element.
    ///    element = Type: <b>IUIAutomationElement**</b> Receives a pointer to the UI Automation element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ElementFromPoint(POINT pt, IUIAutomationElement* element);
    ///Retrieves the UI Automation element that has the input focus.
    ///Params:
    ///    element = Type: <b>IUIAutomationElement**</b> Receives a pointer to the UI Automation element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFocusedElement(IUIAutomationElement* element);
    ///Retrieves the UI Automation element that represents the desktop, prefetches the requested properties and control
    ///patterns, and stores the prefetched items in the cache.
    ///Params:
    ///    cacheRequest = Type: <b>IUIAutomationCacheRequest*</b> A pointer to the cache request, which specifies the properties and
    ///                   control patterns to store in the cache.
    ///    root = Type: <b>IUIAutomationElement**</b> Receives a pointer to the UI Automation element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetRootElementBuildCache(IUIAutomationCacheRequest cacheRequest, IUIAutomationElement* root);
    ///Retrieves a UI Automation element for the specified window, prefetches the requested properties and control
    ///patterns, and stores the prefetched items in the cache.
    ///Params:
    ///    hwnd = Type: <b>UIA_HWND</b> The window handle.
    ///    cacheRequest = Type: <b>IUIAutomationCacheRequest*</b> A pointer to the cache request, which specifies the properties and
    ///                   control patterns to store in the cache.
    ///    element = Type: <b>IUIAutomationElement**</b> Receives a pointer to the element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ElementFromHandleBuildCache(void* hwnd, IUIAutomationCacheRequest cacheRequest, 
                                        IUIAutomationElement* element);
    ///Retrieves the UI Automation element at the specified point on the desktop, prefetches the requested properties
    ///and control patterns, and stores the prefetched items in the cache.
    ///Params:
    ///    pt = Type: <b>POINT</b> The desktop coordinates of the UI Automation element.
    ///    cacheRequest = Type: <b>IUIAutomationCacheRequest*</b> A pointer to the cache request, which specifies the properties and
    ///                   control patterns to store in the cache.
    ///    element = Type: <b>IUIAutomationElement**</b> Receives a pointer to the UI Automation element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ElementFromPointBuildCache(POINT pt, IUIAutomationCacheRequest cacheRequest, 
                                       IUIAutomationElement* element);
    ///Retrieves the UI Automation element that has the input focus, prefetches the requested properties and control
    ///patterns, and stores the prefetched items in the cache.
    ///Params:
    ///    cacheRequest = Type: <b>IUIAutomationCacheRequest*</b> A pointer to the cache request, which specifies the properties and
    ///                   control patterns to store in the cache.
    ///    element = Type: <b>IUIAutomationElement**</b> Receives a pointer to the UI Automation element.
    HRESULT GetFocusedElementBuildCache(IUIAutomationCacheRequest cacheRequest, IUIAutomationElement* element);
    ///Retrieves a tree walker object that can be used to traverse the Microsoft UI Automation tree.
    ///Params:
    ///    pCondition = Type: <b>IUIAutomationCondition*</b> A pointer to a condition that specifies the elements of interest.
    ///    walker = Type: <b>IUIAutomationTreeWalker**</b> Receives a pointer to the tree walker object.
    HRESULT CreateTreeWalker(IUIAutomationCondition pCondition, IUIAutomationTreeWalker* walker);
    ///Retrieves an IUIAutomationTreeWalker interface used to discover control elements. This property is read-only.
    HRESULT get_ControlViewWalker(IUIAutomationTreeWalker* walker);
    ///Retrieves an IUIAutomationTreeWalker interface used to discover content elements. This property is read-only.
    HRESULT get_ContentViewWalker(IUIAutomationTreeWalker* walker);
    ///Retrieves a tree walker object used to traverse an unfiltered view of the Microsoft UI Automation tree. This
    ///property is read-only.
    HRESULT get_RawViewWalker(IUIAutomationTreeWalker* walker);
    ///Retrieves a predefined IUIAutomationCondition interface that selects all UI elements in an unfiltered view. This
    ///property is read-only.
    HRESULT get_RawViewCondition(IUIAutomationCondition* condition);
    ///Retrieves a predefined IUIAutomationCondition interface that selects control elements. This property is
    ///read-only.
    HRESULT get_ControlViewCondition(IUIAutomationCondition* condition);
    ///Retrieves a predefined IUIAutomationCondition interface that selects content elements. This property is
    ///read-only.
    HRESULT get_ContentViewCondition(IUIAutomationCondition* condition);
    ///Creates a cache request.
    ///Params:
    ///    cacheRequest = Type: <b>IUIAutomationCacheRequest**</b> The address of a variable that receives a pointer to an
    ///                   IUIAutomationCacheRequest interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateCacheRequest(IUIAutomationCacheRequest* cacheRequest);
    ///Retrieves a predefined condition that selects all elements.
    ///Params:
    ///    newCondition = Type: <b>IUIAutomationCondition**</b> Receives a pointer to the true condition.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateTrueCondition(IUIAutomationCondition* newCondition);
    ///Creates a condition that is always false.
    ///Params:
    ///    newCondition = Type: <b>IUIAutomationCondition**</b> Receives a pointer to the false condition.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateFalseCondition(IUIAutomationCondition* newCondition);
    ///Creates a condition that selects elements that have a property with the specified value.
    ///Params:
    ///    propertyId = Type: <b>PROPERTYID</b> The property identifier. For a list of property IDs, see Property Identifiers.
    ///    value = Type: <b>VARIANT</b> The property value.
    ///    newCondition = Type: <b>IUIAutomationCondition**</b> Receives a pointer to the new condition.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreatePropertyCondition(int propertyId, VARIANT value, IUIAutomationCondition* newCondition);
    ///Creates a condition that selects elements that have a property with the specified value, using optional flags.
    ///Params:
    ///    propertyId = Type: <b>PROPERTYID</b> The property identifier. For a list of property IDs, see Property Identifiers.
    ///    value = Type: <b>RECT</b> The property value.
    ///    arg3 = Type: <b>PropertyConditionFlags</b> The attributes of the condition. Use PropertyConditionFlags_IgnoreCase to
    ///           create a property condition that is not case-sensitive
    ///    newCondition = Type: <b>IUIAutomationCondition**</b> Receives a pointer to the new condition.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreatePropertyConditionEx(int propertyId, VARIANT value, PropertyConditionFlags flags, 
                                      IUIAutomationCondition* newCondition);
    ///Creates a condition that selects elements that match both of two conditions.
    ///Params:
    ///    condition1 = Type: <b>IUIAutomationCondition*</b> A pointer to the first condition to match.
    ///    condition2 = Type: <b>IUIAutomationCondition*</b> A pointer to the second condition to match.
    ///    newCondition = Type: <b>IUIAutomationCondition**</b> Receives a pointer to the combined condition.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateAndCondition(IUIAutomationCondition condition1, IUIAutomationCondition condition2, 
                               IUIAutomationCondition* newCondition);
    ///Creates a condition that selects elements based on multiple conditions, all of which must be true.
    ///Params:
    ///    conditions = Type: <b>SAFEARRAY*</b> A pointer to the conditions to be combined.
    ///    newCondition = Type: <b>IUIAutomationCondition**</b> Receives a pointer to the combined condition.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateAndConditionFromArray(SAFEARRAY* conditions, IUIAutomationCondition* newCondition);
    ///Creates a condition that selects elements from a native array, based on multiple conditions that must all be
    ///true.
    ///Params:
    ///    conditions = Type: <b>IUIAutomationCondition**</b> A pointer to an array of conditions to be combined.
    ///    conditionCount = Type: <b>int</b> The number of elements in the <i>conditions</i> array.
    ///    newCondition = Type: <b>IUIAutomationCondition**</b> Receives a pointer to the combined condition.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateAndConditionFromNativeArray(char* conditions, int conditionCount, 
                                              IUIAutomationCondition* newCondition);
    ///Creates a combination of two conditions where a match exists if either of the conditions is true.
    ///Params:
    ///    condition1 = Type: <b>IUIAutomationCondition*</b> A pointer to the first condition.
    ///    condition2 = Type: <b>IUIAutomationCondition*</b> A pointer to the second condition.
    ///    newCondition = Type: <b>IUIAutomationCondition**</b> Receives a pointer to the combined condition.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateOrCondition(IUIAutomationCondition condition1, IUIAutomationCondition condition2, 
                              IUIAutomationCondition* newCondition);
    ///Creates a combination of two or more conditions where a match exists if any of the conditions is true.
    ///Params:
    ///    conditions = Type: <b>SAFEARRAY*</b> A pointer to the conditions.
    ///    newCondition = Type: <b>IUIAutomationCondition**</b> Receives a pointer to the combined condition.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateOrConditionFromArray(SAFEARRAY* conditions, IUIAutomationCondition* newCondition);
    ///Creates a combination of two or more conditions where a match exists if any one of the conditions is true.
    ///Params:
    ///    conditions = Type: <b>IUIAutomationCondition**</b> A pointer to an array of conditions to combine.
    ///    conditionCount = Type: <b>int</b> The number of elements in <i>conditions</i>.
    ///    newCondition = Type: <b>IUIAutomationCondition**</b> Receives a pointer to the combined condition.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateOrConditionFromNativeArray(char* conditions, int conditionCount, 
                                             IUIAutomationCondition* newCondition);
    ///Creates a condition that is the negative of a specified condition.
    ///Params:
    ///    condition = Type: <b>IUIAutomationCondition*</b> A pointer to the initial condition.
    ///    newCondition = Type: <b>IUIAutomationCondition**</b> Receives a pointer to the negative of the initial condition specified
    ///                   by the <i>condition</i> parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateNotCondition(IUIAutomationCondition condition, IUIAutomationCondition* newCondition);
    ///Registers a method that handles Microsoft UI Automation events. <div class="alert"><b>Note</b> Before
    ///implementing an event handler, you should be familiar with the threading issues described in Understanding
    ///Threading Issues.</div><div> </div>
    ///Params:
    ///    eventId = Type: <b>EVENTID</b> The identifier of the event that the method handles. For a list of event IDs, see Event
    ///              Identifiers.
    ///    element = Type: <b>IUIAutomationElement*</b> A pointer to the UI Automation element to associate with the event
    ///              handler.
    ///    arg3 = Type: <b>TreeScope</b> The scope of events to be handled; that is, whether they are on the element itself, or
    ///           on its ancestors and descendants.
    ///    cacheRequest = Type: <b>IUIAutomationCacheRequest*</b> A pointer to a cache request, or <b>NULL</b> if no caching is wanted.
    ///    handler = Type: <b>IUIAutomationEventHandler*</b> A pointer to the object that handles the event.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddAutomationEventHandler(int eventId, IUIAutomationElement element, TreeScope scope_, 
                                      IUIAutomationCacheRequest cacheRequest, IUIAutomationEventHandler handler);
    ///Removes the specified UI Automation event handler.
    ///Params:
    ///    eventId = Type: <b>EVENTID</b> The identifier of the event being handled. For a list of event IDs, see Event
    ///              Identifiers.
    ///    element = Type: <b>IUIAutomationElement*</b> A pointer to the UI Automation element that is handling the event.
    ///    handler = Type: <b>IUIAutomationEventHandler*</b> A pointer to the handler method that was passed to
    ///              IUIAutomation::AddAutomationEventHandler for the specified event identifier and UI Automation element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RemoveAutomationEventHandler(int eventId, IUIAutomationElement element, 
                                         IUIAutomationEventHandler handler);
    ///Registers a method that handles a native array of property-changed events. <div class="alert"><b>Note</b> Before
    ///implementing an event handler, you should be familiar with the threading issues described in Understanding
    ///Threading Issues.</div><div> </div>
    ///Params:
    ///    element = Type: <b>IUIAutomationElement*</b> A pointer to the UI Automation element associated with the event handler.
    ///    arg2 = Type: <b>TreeScope</b> The scope of events to be handled; that is, whether they are on the element itself, or
    ///           on its ancestors and children.
    ///    cacheRequest = Type: <b>IUIAutomationCacheRequest*</b> A pointer to a cache request, or <b>NULL</b> if no caching is wanted.
    ///    handler = Type: <b>IUIAutomationPropertyChangedEventHandler*</b> A pointer to the object that handles the event.
    ///    propertyArray = Type: <b>PROPERTYID*</b> A pointer to the identifiers of the UI Automation properties of interest. For a list
    ///                    of property IDs, see Property Identifiers.
    ///    propertyCount = Type: <b>int</b> The number of property identifiers in <i>propertyArray</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddPropertyChangedEventHandlerNativeArray(IUIAutomationElement element, TreeScope scope_, 
                                                      IUIAutomationCacheRequest cacheRequest, 
                                                      IUIAutomationPropertyChangedEventHandler handler, 
                                                      char* propertyArray, int propertyCount);
    ///Registers a method that handles and array of property-changed events. <div class="alert"><b>Note</b> Before
    ///implementing an event handler, you should be familiar with the threading issues described in Understanding
    ///Threading Issues.</div><div> </div>
    ///Params:
    ///    element = Type: <b>IUIAutomationElement*</b> A pointer to the UI Automation element associated with the event handler.
    ///    arg2 = Type: <b>TreeScope</b> The scope of events to be handled; that is, whether they are on the element itself, or
    ///           on its ancestors and children.
    ///    cacheRequest = Type: <b>IUIAutomationCacheRequest*</b> A pointer to a cache request, or <b>NULL</b> if no caching is wanted.
    ///    handler = Type: <b>IUIAutomationPropertyChangedEventHandler*</b> A pointer to the object that handles the event.
    ///    propertyArray = Type: <b>SAFEARRAY*</b> A pointer to the UI Automation properties of interest. For a list of property IDs,
    ///                    see Property Identifiers.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddPropertyChangedEventHandler(IUIAutomationElement element, TreeScope scope_, 
                                           IUIAutomationCacheRequest cacheRequest, 
                                           IUIAutomationPropertyChangedEventHandler handler, 
                                           SAFEARRAY* propertyArray);
    ///Removes a property-changed event handler.
    ///Params:
    ///    element = Type: <b>IUIAutomationElement*</b> A pointer to the UI Automation element from which to remove the handler.
    ///    handler = Type: <b>IUIAutomationPropertyChangedEventHandler*</b> A pointer to the interface that was passed to
    ///              IUIAutomation::AddPropertyChangedEventHandler.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RemovePropertyChangedEventHandler(IUIAutomationElement element, 
                                              IUIAutomationPropertyChangedEventHandler handler);
    ///Registers a method that handles structure-changed events. <div class="alert"><b>Note</b> Before implementing an
    ///event handler, you should be familiar with the threading issues described in Understanding Threading
    ///Issues.</div><div> </div>
    ///Params:
    ///    element = Type: <b>IUIAutomationElement*</b> A pointer to the UI Automation element associated with the event handler.
    ///    arg2 = Type: <b>TreeScope</b> The scope of events to be handled; that is, whether they are on the element itself, or
    ///           on its ancestors and descendants.
    ///    cacheRequest = Type: <b>IUIAutomationCacheRequest*</b> A pointer to a cache request, or <b>NULL</b> if no caching is wanted.
    ///    handler = Type: <b>IUIAutomationStructureChangedEventHandler*</b> A pointer to the object that handles the
    ///              structure-changed event.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddStructureChangedEventHandler(IUIAutomationElement element, TreeScope scope_, 
                                            IUIAutomationCacheRequest cacheRequest, 
                                            IUIAutomationStructureChangedEventHandler handler);
    ///Removes a structure-changed event handler.
    ///Params:
    ///    element = Type: <b>IUIAutomationElement*</b> A pointer to the UI Automation element from which to remove the handler.
    ///    handler = Type: <b>IUIAutomationStructureChangedEventHandler*</b> A pointer to the interface that was passed to
    ///              IUIAutomation::AddStructureChangedEventHandler.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RemoveStructureChangedEventHandler(IUIAutomationElement element, 
                                               IUIAutomationStructureChangedEventHandler handler);
    ///Registers a method that handles focus-changed events. <div class="alert"><b>Note</b> Before implementing an event
    ///handler, you should be familiar with the threading issues described in Understanding Threading Issues.</div><div>
    ///</div>
    ///Params:
    ///    cacheRequest = Type: <b>IUIAutomationCacheRequest*</b> A pointer to a cache request, or <b>NULL</b> if no caching is wanted.
    ///    handler = Type: <b>IUIAutomationFocusChangedEventHandler*</b> A pointer to the object that handles the event.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddFocusChangedEventHandler(IUIAutomationCacheRequest cacheRequest, 
                                        IUIAutomationFocusChangedEventHandler handler);
    ///Removes a focus-changed event handler.
    ///Params:
    ///    handler = Type: <b>IUIAutomationFocusChangedEventHandler*</b> A pointer to the event handler that was passed to
    ///              IUIAutomation::AddFocusChangedEventHandler.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RemoveFocusChangedEventHandler(IUIAutomationFocusChangedEventHandler handler);
    ///Removes all registered Microsoft UI Automation event handlers.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RemoveAllEventHandlers();
    ///Converts an array of integers to a SAFEARRAY.
    ///Params:
    ///    array = Type: <b>int*</b> A pointer to an array of integers.
    ///    arrayCount = Type: <b>int</b> The number of elements in <i>array</i>.
    ///    safeArray = Type: <b>SAFEARRAY**</b> Receives a pointer to the allocated SAFEARRAY.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT IntNativeArrayToSafeArray(char* array, int arrayCount, SAFEARRAY** safeArray);
    ///Converts a SAFEARRAY of integers to an array.
    ///Params:
    ///    intArray = Type: <b>SAFEARRAY*</b> A pointer to the SAFEARRAY to convert.
    ///    array = Type: <b>int**</b> Receives a pointer to the allocated array.
    ///    arrayCount = Type: <b>int*</b> Receives the number of elements in <i>array</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT IntSafeArrayToNativeArray(SAFEARRAY* intArray, char* array, int* arrayCount);
    ///Creates a VARIANT that contains the coordinates of a rectangle.
    ///Params:
    ///    rc = Type: <b>RECT*</b> A pointer to a structure that contains the coordinates of the rectangle.
    ///    var = Type: <b>VARIANT*</b> Receives the coordinates of the rectangle.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RectToVariant(RECT rc, VARIANT* var);
    ///Converts a VARIANT containing rectangle coordinates to a RECT.
    ///Params:
    ///    var = Type: <b>VARIANT</b> The coordinates of a rectangle.
    ///    rc = Type: <b>RECT*</b> Receives the converted rectangle coordinates.
    HRESULT VariantToRect(VARIANT var, RECT* rc);
    ///Converts a SAFEARRAY containing rectangle coordinates to an array of type RECT.
    ///Params:
    ///    rects = Type: <b>SAFEARRAY*</b> A pointer to an array containing rectangle coordinates.
    ///    rectArray = Type: <b>RECT**</b> Receives a pointer to an array of structures containing rectangle coordinates.
    ///    rectArrayCount = Type: <b>int*</b> Receives the number of elements in <i>rectArray</i>.
    HRESULT SafeArrayToRectNativeArray(SAFEARRAY* rects, char* rectArray, int* rectArrayCount);
    ///Creates a new instance of a proxy factory object.
    ///Params:
    ///    factory = Type: <b>IUIAutomationProxyFactory*</b> A pointer to the proxy factory object.
    ///    factoryEntry = Type: <b>IUIAutomationProxyFactoryEntry**</b> Receives a pointer to the newly created instance of the proxy
    ///                   factory object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateProxyFactoryEntry(IUIAutomationProxyFactory factory, 
                                    IUIAutomationProxyFactoryEntry* factoryEntry);
    ///Retrieves an object that represents the mapping of Window classnames and associated data to individual proxy
    ///factories. This property is read-only.
    HRESULT get_ProxyFactoryMapping(IUIAutomationProxyFactoryMapping* factoryMapping);
    ///Retrieves the registered programmatic name of a property.
    ///Params:
    ///    property = Type: <b>PROPERTYID</b> The property identifier. For a list of property IDs, see Property Identifiers.
    ///    name = Type: <b>BSTR*</b> Receives the registered programmatic name.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPropertyProgrammaticName(int property, BSTR* name);
    ///Retrieves the registered programmatic name of a control pattern.
    ///Params:
    ///    pattern = Type: <b>PATTERNID</b> The identifier of the control pattern. For a list of control pattern IDs, see Control
    ///              Pattern Identifiers.
    ///    name = Type: <b>BSTR*</b> Receives the registered programmatic name.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPatternProgrammaticName(int pattern, BSTR* name);
    ///Retrieves the control patterns that might be supported on a UI Automation element.
    ///Params:
    ///    pElement = Type: <b>IUIAutomationElement*</b> The address of the element to poll.
    ///    patternIds = Type: <b>SAFEARRAY(int)**</b> Receives a pointer to an array of control pattern identifiers.
    ///    patternNames = Type: <b>SAFEARRAY(BSTR)**</b> Receives a pointer to an array of control pattern names.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT PollForPotentialSupportedPatterns(IUIAutomationElement pElement, SAFEARRAY** patternIds, 
                                              SAFEARRAY** patternNames);
    ///Retrieves the properties that might be supported on a UI Automation element.
    ///Params:
    ///    pElement = Type: <b>IUIAutomationElement*</b> The address of the UI Automation element to poll.
    ///    propertyIds = Type: <b>SAFEARRAY(int)**</b> Receives a pointer to an array of property identifiers. For a list of property
    ///                  IDs, see Property Identifiers.
    ///    propertyNames = Type: <b>SAFEARRAY(BSTR)**</b> Receives a pointer to an array of property names.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT PollForPotentialSupportedProperties(IUIAutomationElement pElement, SAFEARRAY** propertyIds, 
                                                SAFEARRAY** propertyNames);
    ///Checks a provided VARIANT to see if it contains the Not Supported identifier.
    ///Params:
    ///    value = Type: <b>VARIANT</b> The value to check.
    ///    isNotSupported = Type: <b>BOOL*</b> Receives <b>TRUE</b> if the provided VARIANT contains the Not Supported identifier, or
    ///                     <b>FALSE</b> otherwise.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CheckNotSupported(VARIANT value, int* isNotSupported);
    ///Retrieves a static token object representing a property or text attribute that is not supported. This property is
    ///read-only.
    HRESULT get_ReservedNotSupportedValue(IUnknown* notSupportedValue);
    ///Retrieves a static token object representing a text attribute that is a mixed attribute. This property is
    ///read-only.
    HRESULT get_ReservedMixedAttributeValue(IUnknown* mixedAttributeValue);
    ///Retrieves a UI Automation element for the specified accessible object from a Microsoft Active Accessibility
    ///server.
    ///Params:
    ///    accessible = Type: <b>IAccessible*</b> A pointer to the IAccessible interface of the accessible object.
    ///    childId = Type: <b>int</b> The child ID of the accessible object.
    ///    element = Type: <b>IUIAutomationElement**</b> Receives a pointer to the UI Automation element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ElementFromIAccessible(IAccessible accessible, int childId, IUIAutomationElement* element);
    ///Retrieves a UI Automation element for the specified accessible object from a Microsoft Active Accessibility
    ///server, prefetches the requested properties and control patterns, and stores the prefetched items in the cache.
    ///Params:
    ///    accessible = Type: <b>IAccessible*</b> A pointer to the IAccessible interface of the accessible object.
    ///    childId = Type: <b>int</b> The child ID of the accessible object.
    ///    cacheRequest = Type: <b>IUIAutomationCacheRequest**</b> The address of the cache request that specifies the properties and
    ///                   control patterns to store in the cache.
    ///    element = Type: <b>IUIAutomationElement**</b> Receives a pointer to the UI Automation element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ElementFromIAccessibleBuildCache(IAccessible accessible, int childId, 
                                             IUIAutomationCacheRequest cacheRequest, IUIAutomationElement* element);
}

///Extends the IUIAutomation interface to expose additional methods for controlling Microsoft UI Automation
///functionality.
@GUID("34723AFF-0C9D-49D0-9896-7AB52DF8CD8A")
interface IUIAutomation2 : IUIAutomation
{
    ///Specifies whether calls to UI Automation control pattern methods automatically set focus to the target element.
    ///This property is read/write.
    HRESULT get_AutoSetFocus(int* autoSetFocus);
    ///Specifies whether calls to UI Automation control pattern methods automatically set focus to the target element.
    ///This property is read/write.
    HRESULT put_AutoSetFocus(BOOL autoSetFocus);
    ///Specifies the length of time that UI Automation will wait for a provider to respond to a client request for an
    ///automation element. This property is read/write.
    HRESULT get_ConnectionTimeout(uint* timeout);
    ///Specifies the length of time that UI Automation will wait for a provider to respond to a client request for an
    ///automation element. This property is read/write.
    HRESULT put_ConnectionTimeout(uint timeout);
    ///Specifies the length of time that UI Automation will wait for a provider to respond to a client request for
    ///information about an automation element. This property is read/write.
    HRESULT get_TransactionTimeout(uint* timeout);
    ///Specifies the length of time that UI Automation will wait for a provider to respond to a client request for
    ///information about an automation element. This property is read/write.
    HRESULT put_TransactionTimeout(uint timeout);
}

///Extends the IUIAutomation2 interface to expose additional methods for controlling Microsoft UI Automation
///functionality.
@GUID("73D768DA-9B51-4B89-936E-C209290973E7")
interface IUIAutomation3 : IUIAutomation2
{
    ///Registers a method that handles programmatic text-edit events. <div class="alert"><b>Note</b> Before implementing
    ///an event handler, you should be familiar with the threading issues described in Understanding Threading
    ///Issues.</div><div> </div>
    ///Params:
    ///    element = Type: <b>IUIAutomationElement*</b> A pointer to the UI Automation element associated with the event handler.
    ///    arg2 = Type: <b>TreeScope</b> The scope of events to be handled; that is, whether they are on the element itself, or
    ///           on its ancestors and descendants.
    ///    arg3 = Type: <b>TextEditChangeType</b> The specific change type to listen for. Clients register for each text-edit
    ///           change type separately, so that the UI Automation system can check for registered listeners at run-time and
    ///           avoid raising events for particular text-edit changes when there are no listeners.
    ///    cacheRequest = Type: <b>IUIAutomationCacheRequest*</b> A pointer to a cache request, or <b>NULL</b> if no caching is wanted.
    ///    handler = Type: <b>IUIAutomationTextEditTextChangedEventHandler*</b> A pointer to the object that handles the
    ///              programmatic text-edit event.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddTextEditTextChangedEventHandler(IUIAutomationElement element, TreeScope scope_, 
                                               TextEditChangeType textEditChangeType, 
                                               IUIAutomationCacheRequest cacheRequest, 
                                               IUIAutomationTextEditTextChangedEventHandler handler);
    ///Removes a programmatic text-edit event handler.
    ///Params:
    ///    element = Type: <b>IUIAutomationElement*</b> A pointer to the UI Automation element from which to remove the handler.
    ///    handler = Type: <b>IUIAutomationTextEditTextChangedEventHandler*</b> A pointer to the interface that was passed to
    ///              IUIAutomation3::AddTextEditTextChangedEventHandler.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RemoveTextEditTextChangedEventHandler(IUIAutomationElement element, 
                                                  IUIAutomationTextEditTextChangedEventHandler handler);
}

///Extends the IUIAutomation3 interface to expose additional methods for controlling Microsoft UI Automation
///functionality.
@GUID("1189C02A-05F8-4319-8E21-E817E3DB2860")
interface IUIAutomation4 : IUIAutomation3
{
    ///Registers a method that handles change events. <div class="alert"><b>Note</b> Before implementing an event
    ///handler, you should be familiar with the threading issues described in Understanding Threading Issues.</div><div>
    ///</div>
    ///Params:
    ///    element = Type: <b>IUIAutomationElement*</b> A pointer to the UI Automation element associated with the event handler.
    ///    arg2 = Type: <b>TreeScope</b> The scope of events to be handled; that is, whether they are on the element itself, or
    ///           on its ancestors and descendants.
    ///    changeTypes = Type: <b>int*</b> A pointer to a list of integers that indicate the change types the event represents.
    ///    changesCount = Type: <b>int</b> The number of changes that occurred in this event.
    ///    pCacheRequest = Type: <b>IUIAutomationCacheRequest*</b> A pointer to a cache request, or <b>NULL</b> if no caching is wanted.
    ///    handler = Type: <b>IUIAutomationChangesEventHandler*</b> A pointer to the object that handles the changes event.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddChangesEventHandler(IUIAutomationElement element, TreeScope scope_, char* changeTypes, 
                                   int changesCount, IUIAutomationCacheRequest pCacheRequest, 
                                   IUIAutomationChangesEventHandler handler);
    ///Removes a changes event handler.
    ///Params:
    ///    element = Type: <b>IUIAutomationElement*</b> A pointer to the UI Automation element from which to remove the handler.
    ///    handler = Type: <b>IUIAutomationChangesEventHandler*</b> A pointer to the interface that was passed to
    ///              AddChangesEventHandler.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RemoveChangesEventHandler(IUIAutomationElement element, IUIAutomationChangesEventHandler handler);
}

///Extends the IUIAutomation4 interface to expose additional methods for controlling Microsoft UI Automation
///functionality.
@GUID("25F700C8-D816-4057-A9DC-3CBDEE77E256")
interface IUIAutomation5 : IUIAutomation4
{
    ///Registers a method that handles notification events. <div class="alert"><b>Note</b> Before implementing an event
    ///handler, you should be familiar with the threading issues described in Understanding Threading Issues.</div><div>
    ///</div>
    ///Params:
    ///    element = Type: <b>IUIAutomationElement*</b> A pointer to the UI Automation element associated with the event handler.
    ///    arg2 = Type: <b>TreeScope</b> The scope of events to be handled; that is, whether they are on the element itself, or
    ///           on its ancestors and descendants.
    ///    cacheRequest = Type: <b>IUIAutomationCacheRequest*</b> A pointer to a cache request, or <b>NULL</b> if no caching is wanted.
    ///    handler = Type: <b>IUIAutomationNotificationEventHandler*</b> A pointer to the object that handles the notification
    ///              event.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddNotificationEventHandler(IUIAutomationElement element, TreeScope scope_, 
                                        IUIAutomationCacheRequest cacheRequest, 
                                        IUIAutomationNotificationEventHandler handler);
    ///Removes a notification event handler.
    ///Params:
    ///    element = Type: <b>IUIAutomationElement*</b> A pointer to the UI Automation element from which to remove the handler.
    ///    handler = Type: <b>IUIAutomationNotificationEventHandler*</b> A pointer to the interface that was passed to
    ///              AddNotificationEventHandler.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
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
