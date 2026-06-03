// Written in the D programming language.

module windows.win32.ui.accessibility;

public import windows.core;
public import windows.win32.foundation : BOOL, BSTR, HMODULE, HRESULT, HWND, LPARAM,
                                         LRESULT, POINT, PSTR, PWSTR, RECT, WPARAM;
public import windows.win32.system.com : IDispatch, IUnknown, SAFEARRAY;
public import windows.win32.system.variant : VARIANT;
public import windows.win32.ui.windowsandmessaging : HMENU, POINTER_INPUT_TYPE;

extern(Windows) @nogc nothrow:


// Enums


alias STICKYKEYS_FLAGS = uint;
enum : uint
{
    SKF_STICKYKEYSON    = 0x00000001U,
    SKF_AVAILABLE       = 0x00000002U,
    SKF_HOTKEYACTIVE    = 0x00000004U,
    SKF_CONFIRMHOTKEY   = 0x00000008U,
    SKF_HOTKEYSOUND     = 0x00000010U,
    SKF_INDICATOR       = 0x00000020U,
    SKF_AUDIBLEFEEDBACK = 0x00000040U,
    SKF_TRISTATE        = 0x00000080U,
    SKF_TWOKEYSOFF      = 0x00000100U,
    SKF_LALTLATCHED     = 0x10000000U,
    SKF_LCTLLATCHED     = 0x04000000U,
    SKF_LSHIFTLATCHED   = 0x01000000U,
    SKF_RALTLATCHED     = 0x20000000U,
    SKF_RCTLLATCHED     = 0x08000000U,
    SKF_RSHIFTLATCHED   = 0x02000000U,
    SKF_LWINLATCHED     = 0x40000000U,
    SKF_RWINLATCHED     = 0x80000000U,
    SKF_LALTLOCKED      = 0x00100000U,
    SKF_LCTLLOCKED      = 0x00040000U,
    SKF_LSHIFTLOCKED    = 0x00010000U,
    SKF_RALTLOCKED      = 0x00200000U,
    SKF_RCTLLOCKED      = 0x00080000U,
    SKF_RSHIFTLOCKED    = 0x00020000U,
    SKF_LWINLOCKED      = 0x00400000U,
    SKF_RWINLOCKED      = 0x00800000U,
}

alias SOUNDSENTRY_FLAGS = uint;
enum : uint
{
    SSF_SOUNDSENTRYON = 0x00000001U,
    SSF_AVAILABLE     = 0x00000002U,
    SSF_INDICATOR     = 0x00000004U,
}

alias ACC_UTILITY_STATE_FLAGS = uint;
enum : uint
{
    ANRUS_ON_SCREEN_KEYBOARD_ACTIVE    = 0x00000001U,
    ANRUS_TOUCH_MODIFICATION_ACTIVE    = 0x00000002U,
    ANRUS_PRIORITY_AUDIO_ACTIVE        = 0x00000004U,
    ANRUS_PRIORITY_AUDIO_ACTIVE_NODUCK = 0x00000008U,
}

alias SOUND_SENTRY_GRAPHICS_EFFECT = uint;
enum : uint
{
    SSGF_DISPLAY = 0x00000003U,
    SSGF_NONE    = 0x00000000U,
}

alias SERIALKEYS_FLAGS = uint;
enum : uint
{
    SERKF_AVAILABLE    = 0x00000002U,
    SERKF_INDICATOR    = 0x00000004U,
    SERKF_SERIALKEYSON = 0x00000001U,
}

alias HIGHCONTRASTW_FLAGS = uint;
enum : uint
{
    HCF_HIGHCONTRASTON       = 0x00000001U,
    HCF_AVAILABLE            = 0x00000002U,
    HCF_HOTKEYACTIVE         = 0x00000004U,
    HCF_CONFIRMHOTKEY        = 0x00000008U,
    HCF_HOTKEYSOUND          = 0x00000010U,
    HCF_INDICATOR            = 0x00000020U,
    HCF_HOTKEYAVAILABLE      = 0x00000040U,
    HCF_OPTION_NOTHEMECHANGE = 0x00001000U,
}

alias SOUNDSENTRY_TEXT_EFFECT = uint;
enum : uint
{
    SSTF_BORDER  = 0x00000002U,
    SSTF_CHARS   = 0x00000001U,
    SSTF_DISPLAY = 0x00000003U,
    SSTF_NONE    = 0x00000000U,
}

alias SOUNDSENTRY_WINDOWS_EFFECT = uint;
enum : uint
{
    SSWF_CUSTOM  = 0x00000004U,
    SSWF_DISPLAY = 0x00000003U,
    SSWF_NONE    = 0x00000000U,
    SSWF_TITLE   = 0x00000001U,
    SSWF_WINDOW  = 0x00000002U,
}

alias UIA_PATTERN_ID = int;
enum : int
{
    UIA_InvokePatternId            = 0x00002710,
    UIA_SelectionPatternId         = 0x00002711,
    UIA_ValuePatternId             = 0x00002712,
    UIA_RangeValuePatternId        = 0x00002713,
    UIA_ScrollPatternId            = 0x00002714,
    UIA_ExpandCollapsePatternId    = 0x00002715,
    UIA_GridPatternId              = 0x00002716,
    UIA_GridItemPatternId          = 0x00002717,
    UIA_MultipleViewPatternId      = 0x00002718,
    UIA_WindowPatternId            = 0x00002719,
    UIA_SelectionItemPatternId     = 0x0000271a,
    UIA_DockPatternId              = 0x0000271b,
    UIA_TablePatternId             = 0x0000271c,
    UIA_TableItemPatternId         = 0x0000271d,
    UIA_TextPatternId              = 0x0000271e,
    UIA_TogglePatternId            = 0x0000271f,
    UIA_TransformPatternId         = 0x00002720,
    UIA_ScrollItemPatternId        = 0x00002721,
    UIA_LegacyIAccessiblePatternId = 0x00002722,
    UIA_ItemContainerPatternId     = 0x00002723,
    UIA_VirtualizedItemPatternId   = 0x00002724,
    UIA_SynchronizedInputPatternId = 0x00002725,
    UIA_ObjectModelPatternId       = 0x00002726,
    UIA_AnnotationPatternId        = 0x00002727,
    UIA_TextPattern2Id             = 0x00002728,
    UIA_StylesPatternId            = 0x00002729,
    UIA_SpreadsheetPatternId       = 0x0000272a,
    UIA_SpreadsheetItemPatternId   = 0x0000272b,
    UIA_TransformPattern2Id        = 0x0000272c,
    UIA_TextChildPatternId         = 0x0000272d,
    UIA_DragPatternId              = 0x0000272e,
    UIA_DropTargetPatternId        = 0x0000272f,
    UIA_TextEditPatternId          = 0x00002730,
    UIA_CustomNavigationPatternId  = 0x00002731,
    UIA_SelectionPattern2Id        = 0x00002732,
}

alias UIA_EVENT_ID = int;
enum : int
{
    UIA_ToolTipOpenedEventId                             = 0x00004e20,
    UIA_ToolTipClosedEventId                             = 0x00004e21,
    UIA_StructureChangedEventId                          = 0x00004e22,
    UIA_MenuOpenedEventId                                = 0x00004e23,
    UIA_AutomationPropertyChangedEventId                 = 0x00004e24,
    UIA_AutomationFocusChangedEventId                    = 0x00004e25,
    UIA_AsyncContentLoadedEventId                        = 0x00004e26,
    UIA_MenuClosedEventId                                = 0x00004e27,
    UIA_LayoutInvalidatedEventId                         = 0x00004e28,
    UIA_Invoke_InvokedEventId                            = 0x00004e29,
    UIA_SelectionItem_ElementAddedToSelectionEventId     = 0x00004e2a,
    UIA_SelectionItem_ElementRemovedFromSelectionEventId = 0x00004e2b,
    UIA_SelectionItem_ElementSelectedEventId             = 0x00004e2c,
    UIA_Selection_InvalidatedEventId                     = 0x00004e2d,
    UIA_Text_TextSelectionChangedEventId                 = 0x00004e2e,
    UIA_Text_TextChangedEventId                          = 0x00004e2f,
    UIA_Window_WindowOpenedEventId                       = 0x00004e30,
    UIA_Window_WindowClosedEventId                       = 0x00004e31,
    UIA_MenuModeStartEventId                             = 0x00004e32,
    UIA_MenuModeEndEventId                               = 0x00004e33,
    UIA_InputReachedTargetEventId                        = 0x00004e34,
    UIA_InputReachedOtherElementEventId                  = 0x00004e35,
    UIA_InputDiscardedEventId                            = 0x00004e36,
    UIA_SystemAlertEventId                               = 0x00004e37,
    UIA_LiveRegionChangedEventId                         = 0x00004e38,
    UIA_HostedFragmentRootsInvalidatedEventId            = 0x00004e39,
    UIA_Drag_DragStartEventId                            = 0x00004e3a,
    UIA_Drag_DragCancelEventId                           = 0x00004e3b,
    UIA_Drag_DragCompleteEventId                         = 0x00004e3c,
    UIA_DropTarget_DragEnterEventId                      = 0x00004e3d,
    UIA_DropTarget_DragLeaveEventId                      = 0x00004e3e,
    UIA_DropTarget_DroppedEventId                        = 0x00004e3f,
    UIA_TextEdit_TextChangedEventId                      = 0x00004e40,
    UIA_TextEdit_ConversionTargetChangedEventId          = 0x00004e41,
    UIA_ChangesEventId                                   = 0x00004e42,
    UIA_NotificationEventId                              = 0x00004e43,
    UIA_ActiveTextPositionChangedEventId                 = 0x00004e44,
}

alias UIA_PROPERTY_ID = int;
enum : int
{
    UIA_RuntimeIdPropertyId                           = 0x00007530,
    UIA_BoundingRectanglePropertyId                   = 0x00007531,
    UIA_ProcessIdPropertyId                           = 0x00007532,
    UIA_ControlTypePropertyId                         = 0x00007533,
    UIA_LocalizedControlTypePropertyId                = 0x00007534,
    UIA_NamePropertyId                                = 0x00007535,
    UIA_AcceleratorKeyPropertyId                      = 0x00007536,
    UIA_AccessKeyPropertyId                           = 0x00007537,
    UIA_HasKeyboardFocusPropertyId                    = 0x00007538,
    UIA_IsKeyboardFocusablePropertyId                 = 0x00007539,
    UIA_IsEnabledPropertyId                           = 0x0000753a,
    UIA_AutomationIdPropertyId                        = 0x0000753b,
    UIA_ClassNamePropertyId                           = 0x0000753c,
    UIA_HelpTextPropertyId                            = 0x0000753d,
    UIA_ClickablePointPropertyId                      = 0x0000753e,
    UIA_CulturePropertyId                             = 0x0000753f,
    UIA_IsControlElementPropertyId                    = 0x00007540,
    UIA_IsContentElementPropertyId                    = 0x00007541,
    UIA_LabeledByPropertyId                           = 0x00007542,
    UIA_IsPasswordPropertyId                          = 0x00007543,
    UIA_NativeWindowHandlePropertyId                  = 0x00007544,
    UIA_ItemTypePropertyId                            = 0x00007545,
    UIA_IsOffscreenPropertyId                         = 0x00007546,
    UIA_OrientationPropertyId                         = 0x00007547,
    UIA_FrameworkIdPropertyId                         = 0x00007548,
    UIA_IsRequiredForFormPropertyId                   = 0x00007549,
    UIA_ItemStatusPropertyId                          = 0x0000754a,
    UIA_IsDockPatternAvailablePropertyId              = 0x0000754b,
    UIA_IsExpandCollapsePatternAvailablePropertyId    = 0x0000754c,
    UIA_IsGridItemPatternAvailablePropertyId          = 0x0000754d,
    UIA_IsGridPatternAvailablePropertyId              = 0x0000754e,
    UIA_IsInvokePatternAvailablePropertyId            = 0x0000754f,
    UIA_IsMultipleViewPatternAvailablePropertyId      = 0x00007550,
    UIA_IsRangeValuePatternAvailablePropertyId        = 0x00007551,
    UIA_IsScrollPatternAvailablePropertyId            = 0x00007552,
    UIA_IsScrollItemPatternAvailablePropertyId        = 0x00007553,
    UIA_IsSelectionItemPatternAvailablePropertyId     = 0x00007554,
    UIA_IsSelectionPatternAvailablePropertyId         = 0x00007555,
    UIA_IsTablePatternAvailablePropertyId             = 0x00007556,
    UIA_IsTableItemPatternAvailablePropertyId         = 0x00007557,
    UIA_IsTextPatternAvailablePropertyId              = 0x00007558,
    UIA_IsTogglePatternAvailablePropertyId            = 0x00007559,
    UIA_IsTransformPatternAvailablePropertyId         = 0x0000755a,
    UIA_IsValuePatternAvailablePropertyId             = 0x0000755b,
    UIA_IsWindowPatternAvailablePropertyId            = 0x0000755c,
    UIA_ValueValuePropertyId                          = 0x0000755d,
    UIA_ValueIsReadOnlyPropertyId                     = 0x0000755e,
    UIA_RangeValueValuePropertyId                     = 0x0000755f,
    UIA_RangeValueIsReadOnlyPropertyId                = 0x00007560,
    UIA_RangeValueMinimumPropertyId                   = 0x00007561,
    UIA_RangeValueMaximumPropertyId                   = 0x00007562,
    UIA_RangeValueLargeChangePropertyId               = 0x00007563,
    UIA_RangeValueSmallChangePropertyId               = 0x00007564,
    UIA_ScrollHorizontalScrollPercentPropertyId       = 0x00007565,
    UIA_ScrollHorizontalViewSizePropertyId            = 0x00007566,
    UIA_ScrollVerticalScrollPercentPropertyId         = 0x00007567,
    UIA_ScrollVerticalViewSizePropertyId              = 0x00007568,
    UIA_ScrollHorizontallyScrollablePropertyId        = 0x00007569,
    UIA_ScrollVerticallyScrollablePropertyId          = 0x0000756a,
    UIA_SelectionSelectionPropertyId                  = 0x0000756b,
    UIA_SelectionCanSelectMultiplePropertyId          = 0x0000756c,
    UIA_SelectionIsSelectionRequiredPropertyId        = 0x0000756d,
    UIA_GridRowCountPropertyId                        = 0x0000756e,
    UIA_GridColumnCountPropertyId                     = 0x0000756f,
    UIA_GridItemRowPropertyId                         = 0x00007570,
    UIA_GridItemColumnPropertyId                      = 0x00007571,
    UIA_GridItemRowSpanPropertyId                     = 0x00007572,
    UIA_GridItemColumnSpanPropertyId                  = 0x00007573,
    UIA_GridItemContainingGridPropertyId              = 0x00007574,
    UIA_DockDockPositionPropertyId                    = 0x00007575,
    UIA_ExpandCollapseExpandCollapseStatePropertyId   = 0x00007576,
    UIA_MultipleViewCurrentViewPropertyId             = 0x00007577,
    UIA_MultipleViewSupportedViewsPropertyId          = 0x00007578,
    UIA_WindowCanMaximizePropertyId                   = 0x00007579,
    UIA_WindowCanMinimizePropertyId                   = 0x0000757a,
    UIA_WindowWindowVisualStatePropertyId             = 0x0000757b,
    UIA_WindowWindowInteractionStatePropertyId        = 0x0000757c,
    UIA_WindowIsModalPropertyId                       = 0x0000757d,
    UIA_WindowIsTopmostPropertyId                     = 0x0000757e,
    UIA_SelectionItemIsSelectedPropertyId             = 0x0000757f,
    UIA_SelectionItemSelectionContainerPropertyId     = 0x00007580,
    UIA_TableRowHeadersPropertyId                     = 0x00007581,
    UIA_TableColumnHeadersPropertyId                  = 0x00007582,
    UIA_TableRowOrColumnMajorPropertyId               = 0x00007583,
    UIA_TableItemRowHeaderItemsPropertyId             = 0x00007584,
    UIA_TableItemColumnHeaderItemsPropertyId          = 0x00007585,
    UIA_ToggleToggleStatePropertyId                   = 0x00007586,
    UIA_TransformCanMovePropertyId                    = 0x00007587,
    UIA_TransformCanResizePropertyId                  = 0x00007588,
    UIA_TransformCanRotatePropertyId                  = 0x00007589,
    UIA_IsLegacyIAccessiblePatternAvailablePropertyId = 0x0000758a,
    UIA_LegacyIAccessibleChildIdPropertyId            = 0x0000758b,
    UIA_LegacyIAccessibleNamePropertyId               = 0x0000758c,
    UIA_LegacyIAccessibleValuePropertyId              = 0x0000758d,
    UIA_LegacyIAccessibleDescriptionPropertyId        = 0x0000758e,
    UIA_LegacyIAccessibleRolePropertyId               = 0x0000758f,
    UIA_LegacyIAccessibleStatePropertyId              = 0x00007590,
    UIA_LegacyIAccessibleHelpPropertyId               = 0x00007591,
    UIA_LegacyIAccessibleKeyboardShortcutPropertyId   = 0x00007592,
    UIA_LegacyIAccessibleSelectionPropertyId          = 0x00007593,
    UIA_LegacyIAccessibleDefaultActionPropertyId      = 0x00007594,
    UIA_AriaRolePropertyId                            = 0x00007595,
    UIA_AriaPropertiesPropertyId                      = 0x00007596,
    UIA_IsDataValidForFormPropertyId                  = 0x00007597,
    UIA_ControllerForPropertyId                       = 0x00007598,
    UIA_DescribedByPropertyId                         = 0x00007599,
    UIA_FlowsToPropertyId                             = 0x0000759a,
    UIA_ProviderDescriptionPropertyId                 = 0x0000759b,
    UIA_IsItemContainerPatternAvailablePropertyId     = 0x0000759c,
    UIA_IsVirtualizedItemPatternAvailablePropertyId   = 0x0000759d,
    UIA_IsSynchronizedInputPatternAvailablePropertyId = 0x0000759e,
    UIA_OptimizeForVisualContentPropertyId            = 0x0000759f,
    UIA_IsObjectModelPatternAvailablePropertyId       = 0x000075a0,
    UIA_AnnotationAnnotationTypeIdPropertyId          = 0x000075a1,
    UIA_AnnotationAnnotationTypeNamePropertyId        = 0x000075a2,
    UIA_AnnotationAuthorPropertyId                    = 0x000075a3,
    UIA_AnnotationDateTimePropertyId                  = 0x000075a4,
    UIA_AnnotationTargetPropertyId                    = 0x000075a5,
    UIA_IsAnnotationPatternAvailablePropertyId        = 0x000075a6,
    UIA_IsTextPattern2AvailablePropertyId             = 0x000075a7,
    UIA_StylesStyleIdPropertyId                       = 0x000075a8,
    UIA_StylesStyleNamePropertyId                     = 0x000075a9,
    UIA_StylesFillColorPropertyId                     = 0x000075aa,
    UIA_StylesFillPatternStylePropertyId              = 0x000075ab,
    UIA_StylesShapePropertyId                         = 0x000075ac,
    UIA_StylesFillPatternColorPropertyId              = 0x000075ad,
    UIA_StylesExtendedPropertiesPropertyId            = 0x000075ae,
    UIA_IsStylesPatternAvailablePropertyId            = 0x000075af,
    UIA_IsSpreadsheetPatternAvailablePropertyId       = 0x000075b0,
    UIA_SpreadsheetItemFormulaPropertyId              = 0x000075b1,
    UIA_SpreadsheetItemAnnotationObjectsPropertyId    = 0x000075b2,
    UIA_SpreadsheetItemAnnotationTypesPropertyId      = 0x000075b3,
    UIA_IsSpreadsheetItemPatternAvailablePropertyId   = 0x000075b4,
    UIA_Transform2CanZoomPropertyId                   = 0x000075b5,
    UIA_IsTransformPattern2AvailablePropertyId        = 0x000075b6,
    UIA_LiveSettingPropertyId                         = 0x000075b7,
    UIA_IsTextChildPatternAvailablePropertyId         = 0x000075b8,
    UIA_IsDragPatternAvailablePropertyId              = 0x000075b9,
    UIA_DragIsGrabbedPropertyId                       = 0x000075ba,
    UIA_DragDropEffectPropertyId                      = 0x000075bb,
    UIA_DragDropEffectsPropertyId                     = 0x000075bc,
    UIA_IsDropTargetPatternAvailablePropertyId        = 0x000075bd,
    UIA_DropTargetDropTargetEffectPropertyId          = 0x000075be,
    UIA_DropTargetDropTargetEffectsPropertyId         = 0x000075bf,
    UIA_DragGrabbedItemsPropertyId                    = 0x000075c0,
    UIA_Transform2ZoomLevelPropertyId                 = 0x000075c1,
    UIA_Transform2ZoomMinimumPropertyId               = 0x000075c2,
    UIA_Transform2ZoomMaximumPropertyId               = 0x000075c3,
    UIA_FlowsFromPropertyId                           = 0x000075c4,
    UIA_IsTextEditPatternAvailablePropertyId          = 0x000075c5,
    UIA_IsPeripheralPropertyId                        = 0x000075c6,
    UIA_IsCustomNavigationPatternAvailablePropertyId  = 0x000075c7,
    UIA_PositionInSetPropertyId                       = 0x000075c8,
    UIA_SizeOfSetPropertyId                           = 0x000075c9,
    UIA_LevelPropertyId                               = 0x000075ca,
    UIA_AnnotationTypesPropertyId                     = 0x000075cb,
    UIA_AnnotationObjectsPropertyId                   = 0x000075cc,
    UIA_LandmarkTypePropertyId                        = 0x000075cd,
    UIA_LocalizedLandmarkTypePropertyId               = 0x000075ce,
    UIA_FullDescriptionPropertyId                     = 0x000075cf,
    UIA_FillColorPropertyId                           = 0x000075d0,
    UIA_OutlineColorPropertyId                        = 0x000075d1,
    UIA_FillTypePropertyId                            = 0x000075d2,
    UIA_VisualEffectsPropertyId                       = 0x000075d3,
    UIA_OutlineThicknessPropertyId                    = 0x000075d4,
    UIA_CenterPointPropertyId                         = 0x000075d5,
    UIA_RotationPropertyId                            = 0x000075d6,
    UIA_SizePropertyId                                = 0x000075d7,
    UIA_IsSelectionPattern2AvailablePropertyId        = 0x000075d8,
    UIA_Selection2FirstSelectedItemPropertyId         = 0x000075d9,
    UIA_Selection2LastSelectedItemPropertyId          = 0x000075da,
    UIA_Selection2CurrentSelectedItemPropertyId       = 0x000075db,
    UIA_Selection2ItemCountPropertyId                 = 0x000075dc,
    UIA_HeadingLevelPropertyId                        = 0x000075dd,
    UIA_IsDialogPropertyId                            = 0x000075de,
}

alias UIA_TEXTATTRIBUTE_ID = int;
enum : int
{
    UIA_AnimationStyleAttributeId          = 0x00009c40,
    UIA_BackgroundColorAttributeId         = 0x00009c41,
    UIA_BulletStyleAttributeId             = 0x00009c42,
    UIA_CapStyleAttributeId                = 0x00009c43,
    UIA_CultureAttributeId                 = 0x00009c44,
    UIA_FontNameAttributeId                = 0x00009c45,
    UIA_FontSizeAttributeId                = 0x00009c46,
    UIA_FontWeightAttributeId              = 0x00009c47,
    UIA_ForegroundColorAttributeId         = 0x00009c48,
    UIA_HorizontalTextAlignmentAttributeId = 0x00009c49,
    UIA_IndentationFirstLineAttributeId    = 0x00009c4a,
    UIA_IndentationLeadingAttributeId      = 0x00009c4b,
    UIA_IndentationTrailingAttributeId     = 0x00009c4c,
    UIA_IsHiddenAttributeId                = 0x00009c4d,
    UIA_IsItalicAttributeId                = 0x00009c4e,
    UIA_IsReadOnlyAttributeId              = 0x00009c4f,
    UIA_IsSubscriptAttributeId             = 0x00009c50,
    UIA_IsSuperscriptAttributeId           = 0x00009c51,
    UIA_MarginBottomAttributeId            = 0x00009c52,
    UIA_MarginLeadingAttributeId           = 0x00009c53,
    UIA_MarginTopAttributeId               = 0x00009c54,
    UIA_MarginTrailingAttributeId          = 0x00009c55,
    UIA_OutlineStylesAttributeId           = 0x00009c56,
    UIA_OverlineColorAttributeId           = 0x00009c57,
    UIA_OverlineStyleAttributeId           = 0x00009c58,
    UIA_StrikethroughColorAttributeId      = 0x00009c59,
    UIA_StrikethroughStyleAttributeId      = 0x00009c5a,
    UIA_TabsAttributeId                    = 0x00009c5b,
    UIA_TextFlowDirectionsAttributeId      = 0x00009c5c,
    UIA_UnderlineColorAttributeId          = 0x00009c5d,
    UIA_UnderlineStyleAttributeId          = 0x00009c5e,
    UIA_AnnotationTypesAttributeId         = 0x00009c5f,
    UIA_AnnotationObjectsAttributeId       = 0x00009c60,
    UIA_StyleNameAttributeId               = 0x00009c61,
    UIA_StyleIdAttributeId                 = 0x00009c62,
    UIA_LinkAttributeId                    = 0x00009c63,
    UIA_IsActiveAttributeId                = 0x00009c64,
    UIA_SelectionActiveEndAttributeId      = 0x00009c65,
    UIA_CaretPositionAttributeId           = 0x00009c66,
    UIA_CaretBidiModeAttributeId           = 0x00009c67,
    UIA_LineSpacingAttributeId             = 0x00009c68,
    UIA_BeforeParagraphSpacingAttributeId  = 0x00009c69,
    UIA_AfterParagraphSpacingAttributeId   = 0x00009c6a,
    UIA_SayAsInterpretAsAttributeId        = 0x00009c6b,
}

alias UIA_CONTROLTYPE_ID = int;
enum : int
{
    UIA_ButtonControlTypeId       = 0x0000c350,
    UIA_CalendarControlTypeId     = 0x0000c351,
    UIA_CheckBoxControlTypeId     = 0x0000c352,
    UIA_ComboBoxControlTypeId     = 0x0000c353,
    UIA_EditControlTypeId         = 0x0000c354,
    UIA_HyperlinkControlTypeId    = 0x0000c355,
    UIA_ImageControlTypeId        = 0x0000c356,
    UIA_ListItemControlTypeId     = 0x0000c357,
    UIA_ListControlTypeId         = 0x0000c358,
    UIA_MenuControlTypeId         = 0x0000c359,
    UIA_MenuBarControlTypeId      = 0x0000c35a,
    UIA_MenuItemControlTypeId     = 0x0000c35b,
    UIA_ProgressBarControlTypeId  = 0x0000c35c,
    UIA_RadioButtonControlTypeId  = 0x0000c35d,
    UIA_ScrollBarControlTypeId    = 0x0000c35e,
    UIA_SliderControlTypeId       = 0x0000c35f,
    UIA_SpinnerControlTypeId      = 0x0000c360,
    UIA_StatusBarControlTypeId    = 0x0000c361,
    UIA_TabControlTypeId          = 0x0000c362,
    UIA_TabItemControlTypeId      = 0x0000c363,
    UIA_TextControlTypeId         = 0x0000c364,
    UIA_ToolBarControlTypeId      = 0x0000c365,
    UIA_ToolTipControlTypeId      = 0x0000c366,
    UIA_TreeControlTypeId         = 0x0000c367,
    UIA_TreeItemControlTypeId     = 0x0000c368,
    UIA_CustomControlTypeId       = 0x0000c369,
    UIA_GroupControlTypeId        = 0x0000c36a,
    UIA_ThumbControlTypeId        = 0x0000c36b,
    UIA_DataGridControlTypeId     = 0x0000c36c,
    UIA_DataItemControlTypeId     = 0x0000c36d,
    UIA_DocumentControlTypeId     = 0x0000c36e,
    UIA_SplitButtonControlTypeId  = 0x0000c36f,
    UIA_WindowControlTypeId       = 0x0000c370,
    UIA_PaneControlTypeId         = 0x0000c371,
    UIA_HeaderControlTypeId       = 0x0000c372,
    UIA_HeaderItemControlTypeId   = 0x0000c373,
    UIA_TableControlTypeId        = 0x0000c374,
    UIA_TitleBarControlTypeId     = 0x0000c375,
    UIA_SeparatorControlTypeId    = 0x0000c376,
    UIA_SemanticZoomControlTypeId = 0x0000c377,
    UIA_AppBarControlTypeId       = 0x0000c378,
}

alias UIA_ANNOTATIONTYPE = int;
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

alias UIA_STYLE_ID = int;
enum : int
{
    StyleId_Custom       = 0x00011170,
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
    StyleId_NumberedList = 0x00011180,
}

alias UIA_LANDMARKTYPE_ID = int;
enum : int
{
    UIA_CustomLandmarkTypeId     = 0x00013880,
    UIA_FormLandmarkTypeId       = 0x00013881,
    UIA_MainLandmarkTypeId       = 0x00013882,
    UIA_NavigationLandmarkTypeId = 0x00013883,
    UIA_SearchLandmarkTypeId     = 0x00013884,
}

alias UIA_HEADINGLEVEL_ID = int;
enum : int
{
    HeadingLevel_None = 0x000138b2,
    HeadingLevel1     = 0x000138b3,
    HeadingLevel2     = 0x000138b4,
    HeadingLevel3     = 0x000138b5,
    HeadingLevel4     = 0x000138b6,
    HeadingLevel5     = 0x000138b7,
    HeadingLevel6     = 0x000138b8,
    HeadingLevel7     = 0x000138b9,
    HeadingLevel8     = 0x000138ba,
    HeadingLevel9     = 0x000138bb,
}

alias UIA_CHANGE_ID = int;
enum : int
{
    UIA_SummaryChangeId = 0x00015f90,
}

alias UIA_METADATA_ID = int;
enum : int
{
    UIA_SayAsInterpretAsMetadataId = 0x000186a0,
}

enum AnnoScope : int
{
    ANNO_THIS      = 0x00000000,
    ANNO_CONTAINER = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-navigatedirection
enum NavigateDirection : int
{
    NavigateDirection_Parent          = 0x00000000,
    NavigateDirection_NextSibling     = 0x00000001,
    NavigateDirection_PreviousSibling = 0x00000002,
    NavigateDirection_FirstChild      = 0x00000003,
    NavigateDirection_LastChild       = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-provideroptions
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-structurechangetype
enum StructureChangeType : int
{
    StructureChangeType_ChildAdded          = 0x00000000,
    StructureChangeType_ChildRemoved        = 0x00000001,
    StructureChangeType_ChildrenInvalidated = 0x00000002,
    StructureChangeType_ChildrenBulkAdded   = 0x00000003,
    StructureChangeType_ChildrenBulkRemoved = 0x00000004,
    StructureChangeType_ChildrenReordered   = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-texteditchangetype
enum TextEditChangeType : int
{
    TextEditChangeType_None                 = 0x00000000,
    TextEditChangeType_AutoCorrect          = 0x00000001,
    TextEditChangeType_Composition          = 0x00000002,
    TextEditChangeType_CompositionFinalized = 0x00000003,
    TextEditChangeType_AutoComplete         = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-orientationtype
enum OrientationType : int
{
    OrientationType_None       = 0x00000000,
    OrientationType_Horizontal = 0x00000001,
    OrientationType_Vertical   = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-dockposition
enum DockPosition : int
{
    DockPosition_Top    = 0x00000000,
    DockPosition_Left   = 0x00000001,
    DockPosition_Bottom = 0x00000002,
    DockPosition_Right  = 0x00000003,
    DockPosition_Fill   = 0x00000004,
    DockPosition_None   = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-expandcollapsestate
enum ExpandCollapseState : int
{
    ExpandCollapseState_Collapsed         = 0x00000000,
    ExpandCollapseState_Expanded          = 0x00000001,
    ExpandCollapseState_PartiallyExpanded = 0x00000002,
    ExpandCollapseState_LeafNode          = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-scrollamount
enum ScrollAmount : int
{
    ScrollAmount_LargeDecrement = 0x00000000,
    ScrollAmount_SmallDecrement = 0x00000001,
    ScrollAmount_NoAmount       = 0x00000002,
    ScrollAmount_LargeIncrement = 0x00000003,
    ScrollAmount_SmallIncrement = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-roworcolumnmajor
enum RowOrColumnMajor : int
{
    RowOrColumnMajor_RowMajor      = 0x00000000,
    RowOrColumnMajor_ColumnMajor   = 0x00000001,
    RowOrColumnMajor_Indeterminate = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-togglestate
enum ToggleState : int
{
    ToggleState_Off           = 0x00000000,
    ToggleState_On            = 0x00000001,
    ToggleState_Indeterminate = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-windowvisualstate
enum WindowVisualState : int
{
    WindowVisualState_Normal    = 0x00000000,
    WindowVisualState_Maximized = 0x00000001,
    WindowVisualState_Minimized = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-synchronizedinputtype
enum SynchronizedInputType : int
{
    SynchronizedInputType_KeyUp          = 0x00000001,
    SynchronizedInputType_KeyDown        = 0x00000002,
    SynchronizedInputType_LeftMouseUp    = 0x00000004,
    SynchronizedInputType_LeftMouseDown  = 0x00000008,
    SynchronizedInputType_RightMouseUp   = 0x00000010,
    SynchronizedInputType_RightMouseDown = 0x00000020,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-windowinteractionstate
enum WindowInteractionState : int
{
    WindowInteractionState_Running                 = 0x00000000,
    WindowInteractionState_Closing                 = 0x00000001,
    WindowInteractionState_ReadyForUserInteraction = 0x00000002,
    WindowInteractionState_BlockedByModalWindow    = 0x00000003,
    WindowInteractionState_NotResponding           = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-sayasinterpretas
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-textunit
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-textpatternrangeendpoint
enum TextPatternRangeEndpoint : int
{
    TextPatternRangeEndpoint_Start = 0x00000000,
    TextPatternRangeEndpoint_End   = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-supportedtextselection
enum SupportedTextSelection : int
{
    SupportedTextSelection_None     = 0x00000000,
    SupportedTextSelection_Single   = 0x00000001,
    SupportedTextSelection_Multiple = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-livesetting
enum LiveSetting : int
{
    Off       = 0x00000000,
    Polite    = 0x00000001,
    Assertive = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-activeend
enum ActiveEnd : int
{
    ActiveEnd_None  = 0x00000000,
    ActiveEnd_Start = 0x00000001,
    ActiveEnd_End   = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-caretposition
enum CaretPosition : int
{
    CaretPosition_Unknown         = 0x00000000,
    CaretPosition_EndOfLine       = 0x00000001,
    CaretPosition_BeginningOfLine = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-caretbidimode
enum CaretBidiMode : int
{
    CaretBidiMode_LTR = 0x00000000,
    CaretBidiMode_RTL = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-zoomunit
enum ZoomUnit : int
{
    ZoomUnit_NoAmount       = 0x00000000,
    ZoomUnit_LargeDecrement = 0x00000001,
    ZoomUnit_SmallDecrement = 0x00000002,
    ZoomUnit_LargeIncrement = 0x00000003,
    ZoomUnit_SmallIncrement = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-animationstyle
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-bulletstyle
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-capstyle
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-filltype
enum FillType : int
{
    FillType_None     = 0x00000000,
    FillType_Color    = 0x00000001,
    FillType_Gradient = 0x00000002,
    FillType_Picture  = 0x00000003,
    FillType_Pattern  = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-flowdirections
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-outlinestyles
enum OutlineStyles : int
{
    OutlineStyles_None     = 0x00000000,
    OutlineStyles_Outline  = 0x00000001,
    OutlineStyles_Shadow   = 0x00000002,
    OutlineStyles_Engraved = 0x00000004,
    OutlineStyles_Embossed = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-textdecorationlinestyle
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-visualeffects
enum VisualEffects : int
{
    VisualEffects_None       = 0x00000000,
    VisualEffects_Shadow     = 0x00000001,
    VisualEffects_Reflection = 0x00000002,
    VisualEffects_Glow       = 0x00000004,
    VisualEffects_SoftEdges  = 0x00000008,
    VisualEffects_Bevel      = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-notificationprocessing
enum NotificationProcessing : int
{
    NotificationProcessing_ImportantAll                   = 0x00000000,
    NotificationProcessing_ImportantMostRecent            = 0x00000001,
    NotificationProcessing_All                            = 0x00000002,
    NotificationProcessing_MostRecent                     = 0x00000003,
    NotificationProcessing_CurrentThenMostRecent          = 0x00000004,
    NotificationProcessing_ImportantCurrentThenMostRecent = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-notificationkind
enum NotificationKind : int
{
    NotificationKind_ItemAdded       = 0x00000000,
    NotificationKind_ItemRemoved     = 0x00000001,
    NotificationKind_ActionCompleted = 0x00000002,
    NotificationKind_ActionAborted   = 0x00000003,
    NotificationKind_Other           = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ne-uiautomationcore-uiautomationtype
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/ne-uiautomationclient-treescope
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/ne-uiautomationclient-propertyconditionflags
enum PropertyConditionFlags : int
{
    PropertyConditionFlags_None           = 0x00000000,
    PropertyConditionFlags_IgnoreCase     = 0x00000001,
    PropertyConditionFlags_MatchSubstring = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/ne-uiautomationclient-automationelementmode
enum AutomationElementMode : int
{
    AutomationElementMode_None = 0x00000000,
    AutomationElementMode_Full = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/ne-uiautomationclient-treetraversaloptions
enum TreeTraversalOptions : int
{
    TreeTraversalOptions_Default          = 0x00000000,
    TreeTraversalOptions_PostOrder        = 0x00000001,
    TreeTraversalOptions_LastToFirstOrder = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/ne-uiautomationclient-connectionrecoverybehavioroptions
enum ConnectionRecoveryBehaviorOptions : int
{
    ConnectionRecoveryBehaviorOptions_Disabled = 0x00000000,
    ConnectionRecoveryBehaviorOptions_Enabled  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/ne-uiautomationclient-coalesceeventsoptions
enum CoalesceEventsOptions : int
{
    CoalesceEventsOptions_Disabled = 0x00000000,
    CoalesceEventsOptions_Enabled  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcoreapi/ne-uiautomationcoreapi-conditiontype
enum ConditionType : int
{
    ConditionType_True     = 0x00000000,
    ConditionType_False    = 0x00000001,
    ConditionType_Property = 0x00000002,
    ConditionType_And      = 0x00000003,
    ConditionType_Or       = 0x00000004,
    ConditionType_Not      = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcoreapi/ne-uiautomationcoreapi-normalizestate
enum NormalizeState : int
{
    NormalizeState_None   = 0x00000000,
    NormalizeState_View   = 0x00000001,
    NormalizeState_Custom = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcoreapi/ne-uiautomationcoreapi-providertype
enum ProviderType : int
{
    ProviderType_BaseHwnd      = 0x00000000,
    ProviderType_Proxy         = 0x00000001,
    ProviderType_NonClientArea = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcoreapi/ne-uiautomationcoreapi-automationidentifiertype
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcoreapi/ne-uiautomationcoreapi-eventargstype
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcoreapi/ne-uiautomationcoreapi-asynccontentloadedstate
enum AsyncContentLoadedState : int
{
    AsyncContentLoadedState_Beginning = 0x00000000,
    AsyncContentLoadedState_Progress  = 0x00000001,
    AsyncContentLoadedState_Completed = 0x00000002,
}

// Constants


enum GUID LIBID_Accessibility = GUID("1ea4dbf0-3c3b-11cf-810c-00aa00389b71");
enum GUID CLSID_AccPropServices = GUID("b5f8350b-0548-48b1-a6ee-88bd00b4a5e7");
enum GUID IIS_IsOleaccProxy = GUID("902697fa-80e4-4560-802a-a13f22a64709");
enum GUID IIS_ControlAccessible = GUID("38c682a6-9731-43f2-9fae-e901e641b101");
enum uint ANRUS_PRIORITY_AUDIO_DYNAMIC_DUCK = 0x00000010U;
enum int MSAA_MENU_SIG = 0xaa0df00d;

enum : GUID
{
    PROPID_ACC_NAME             = GUID("608d3df8-8128-4aa7-a428-f55e49267291"),
    PROPID_ACC_VALUE            = GUID("123fe443-211a-4615-9527-c45a7e93717a"),
    PROPID_ACC_DESCRIPTION      = GUID("4d48dfe4-bd3f-491f-a648-492d6f20c588"),
    PROPID_ACC_ROLE             = GUID("cb905ff2-7bd1-4c05-b3c8-e6c241364d70"),
    PROPID_ACC_STATE            = GUID("a8d4d5b0-0a21-42d0-a5c0-514e984f457b"),
    PROPID_ACC_HELP             = GUID("c831e11f-44db-4a99-9768-cb8f978b7231"),
    PROPID_ACC_KEYBOARDSHORTCUT = GUID("7d9bceee-7d1e-4979-9382-5180f4172c34"),
    PROPID_ACC_DEFAULTACTION    = GUID("180c072b-c27f-43c7-9922-f63562a4632b"),
    PROPID_ACC_HELPTOPIC        = GUID("787d1379-8ede-440b-8aec-11f7bf9030b3"),
    PROPID_ACC_FOCUS            = GUID("6eb335df-1c29-4127-b12c-dee9fd157f2b"),
    PROPID_ACC_SELECTION        = GUID("b99d073c-d731-405b-9061-d95e8f842984"),
    PROPID_ACC_PARENT           = GUID("474c22b6-ffc2-467a-b1b5-e958b4657330"),
    PROPID_ACC_NAV_UP           = GUID("016e1a2b-1a4e-4767-8612-3386f66935ec"),
    PROPID_ACC_NAV_DOWN         = GUID("031670ed-3cdf-48d2-9613-138f2dd8a668"),
    PROPID_ACC_NAV_LEFT         = GUID("228086cb-82f1-4a39-8705-dcdc0fff92f5"),
    PROPID_ACC_NAV_RIGHT        = GUID("cd211d9f-e1cb-4fe5-a77c-920b884d095b"),
    PROPID_ACC_NAV_PREV         = GUID("776d3891-c73b-4480-b3f6-076a16a15af6"),
    PROPID_ACC_NAV_NEXT         = GUID("1cdc5455-8cd9-4c92-a371-3939a2fe3eee"),
    PROPID_ACC_NAV_FIRSTCHILD   = GUID("cfd02558-557b-4c67-84f9-2a09fce40749"),
    PROPID_ACC_NAV_LASTCHILD    = GUID("302ecaa5-48d5-4f8d-b671-1a8d20a77832"),
    PROPID_ACC_ROLEMAP          = GUID("f79acda2-140d-4fe6-8914-208476328269"),
    PROPID_ACC_VALUEMAP         = GUID("da1c3d79-fc5c-420e-b399-9d1533549e75"),
    PROPID_ACC_STATEMAP         = GUID("43946c5e-0ac0-4042-b525-07bbdbe17fa7"),
    PROPID_ACC_DESCRIPTIONMAP   = GUID("1ff1435f-8a14-477b-b226-a0abe279975d"),
    PROPID_ACC_DODEFAULTACTION  = GUID("1ba09523-2e3b-49a6-a059-59682a3c48fd"),
}

enum : int
{
    DISPID_ACC_PARENT           = 0xffffec78,
    DISPID_ACC_CHILDCOUNT       = 0xffffec77,
    DISPID_ACC_CHILD            = 0xffffec76,
    DISPID_ACC_NAME             = 0xffffec75,
    DISPID_ACC_VALUE            = 0xffffec74,
    DISPID_ACC_DESCRIPTION      = 0xffffec73,
    DISPID_ACC_ROLE             = 0xffffec72,
    DISPID_ACC_STATE            = 0xffffec71,
    DISPID_ACC_HELP             = 0xffffec70,
    DISPID_ACC_HELPTOPIC        = 0xffffec6f,
    DISPID_ACC_KEYBOARDSHORTCUT = 0xffffec6e,
    DISPID_ACC_FOCUS            = 0xffffec6d,
    DISPID_ACC_SELECTION        = 0xffffec6c,
    DISPID_ACC_DEFAULTACTION    = 0xffffec6b,
    DISPID_ACC_SELECT           = 0xffffec6a,
    DISPID_ACC_LOCATION         = 0xffffec69,
    DISPID_ACC_NAVIGATE         = 0xffffec68,
    DISPID_ACC_HITTEST          = 0xffffec67,
    DISPID_ACC_DODEFAULTACTION  = 0xffffec66,
}

enum : uint
{
    NAVDIR_MIN        = 0x00000000U,
    NAVDIR_UP         = 0x00000001U,
    NAVDIR_DOWN       = 0x00000002U,
    NAVDIR_LEFT       = 0x00000003U,
    NAVDIR_RIGHT      = 0x00000004U,
    NAVDIR_NEXT       = 0x00000005U,
    NAVDIR_PREVIOUS   = 0x00000006U,
    NAVDIR_FIRSTCHILD = 0x00000007U,
    NAVDIR_LASTCHILD  = 0x00000008U,
    NAVDIR_MAX        = 0x00000009U,
}

enum : uint
{
    SELFLAG_NONE          = 0x00000000U,
    SELFLAG_TAKEFOCUS     = 0x00000001U,
    SELFLAG_TAKESELECTION = 0x00000002U,
}

enum uint SELFLAG_EXTENDSELECTION = 0x00000004U;
enum uint SELFLAG_ADDSELECTION = 0x00000008U;
enum uint SELFLAG_REMOVESELECTION = 0x00000010U;
enum uint SELFLAG_VALID = 0x0000001fU;

enum : uint
{
    STATE_SYSTEM_NORMAL   = 0x00000000U,
    STATE_SYSTEM_HASPOPUP = 0x40000000U,
}

enum : uint
{
    ROLE_SYSTEM_TITLEBAR           = 0x00000001U,
    ROLE_SYSTEM_MENUBAR            = 0x00000002U,
    ROLE_SYSTEM_SCROLLBAR          = 0x00000003U,
    ROLE_SYSTEM_GRIP               = 0x00000004U,
    ROLE_SYSTEM_SOUND              = 0x00000005U,
    ROLE_SYSTEM_CURSOR             = 0x00000006U,
    ROLE_SYSTEM_CARET              = 0x00000007U,
    ROLE_SYSTEM_ALERT              = 0x00000008U,
    ROLE_SYSTEM_WINDOW             = 0x00000009U,
    ROLE_SYSTEM_CLIENT             = 0x0000000aU,
    ROLE_SYSTEM_MENUPOPUP          = 0x0000000bU,
    ROLE_SYSTEM_MENUITEM           = 0x0000000cU,
    ROLE_SYSTEM_TOOLTIP            = 0x0000000dU,
    ROLE_SYSTEM_APPLICATION        = 0x0000000eU,
    ROLE_SYSTEM_DOCUMENT           = 0x0000000fU,
    ROLE_SYSTEM_PANE               = 0x00000010U,
    ROLE_SYSTEM_CHART              = 0x00000011U,
    ROLE_SYSTEM_DIALOG             = 0x00000012U,
    ROLE_SYSTEM_BORDER             = 0x00000013U,
    ROLE_SYSTEM_GROUPING           = 0x00000014U,
    ROLE_SYSTEM_SEPARATOR          = 0x00000015U,
    ROLE_SYSTEM_TOOLBAR            = 0x00000016U,
    ROLE_SYSTEM_STATUSBAR          = 0x00000017U,
    ROLE_SYSTEM_TABLE              = 0x00000018U,
    ROLE_SYSTEM_COLUMNHEADER       = 0x00000019U,
    ROLE_SYSTEM_ROWHEADER          = 0x0000001aU,
    ROLE_SYSTEM_COLUMN             = 0x0000001bU,
    ROLE_SYSTEM_ROW                = 0x0000001cU,
    ROLE_SYSTEM_CELL               = 0x0000001dU,
    ROLE_SYSTEM_LINK               = 0x0000001eU,
    ROLE_SYSTEM_HELPBALLOON        = 0x0000001fU,
    ROLE_SYSTEM_CHARACTER          = 0x00000020U,
    ROLE_SYSTEM_LIST               = 0x00000021U,
    ROLE_SYSTEM_LISTITEM           = 0x00000022U,
    ROLE_SYSTEM_OUTLINE            = 0x00000023U,
    ROLE_SYSTEM_OUTLINEITEM        = 0x00000024U,
    ROLE_SYSTEM_PAGETAB            = 0x00000025U,
    ROLE_SYSTEM_PROPERTYPAGE       = 0x00000026U,
    ROLE_SYSTEM_INDICATOR          = 0x00000027U,
    ROLE_SYSTEM_GRAPHIC            = 0x00000028U,
    ROLE_SYSTEM_STATICTEXT         = 0x00000029U,
    ROLE_SYSTEM_TEXT               = 0x0000002aU,
    ROLE_SYSTEM_PUSHBUTTON         = 0x0000002bU,
    ROLE_SYSTEM_CHECKBUTTON        = 0x0000002cU,
    ROLE_SYSTEM_RADIOBUTTON        = 0x0000002dU,
    ROLE_SYSTEM_COMBOBOX           = 0x0000002eU,
    ROLE_SYSTEM_DROPLIST           = 0x0000002fU,
    ROLE_SYSTEM_PROGRESSBAR        = 0x00000030U,
    ROLE_SYSTEM_DIAL               = 0x00000031U,
    ROLE_SYSTEM_HOTKEYFIELD        = 0x00000032U,
    ROLE_SYSTEM_SLIDER             = 0x00000033U,
    ROLE_SYSTEM_SPINBUTTON         = 0x00000034U,
    ROLE_SYSTEM_DIAGRAM            = 0x00000035U,
    ROLE_SYSTEM_ANIMATION          = 0x00000036U,
    ROLE_SYSTEM_EQUATION           = 0x00000037U,
    ROLE_SYSTEM_BUTTONDROPDOWN     = 0x00000038U,
    ROLE_SYSTEM_BUTTONMENU         = 0x00000039U,
    ROLE_SYSTEM_BUTTONDROPDOWNGRID = 0x0000003aU,
}

enum : uint
{
    ROLE_SYSTEM_WHITESPACE    = 0x0000003bU,
    ROLE_SYSTEM_PAGETABLIST   = 0x0000003cU,
    ROLE_SYSTEM_CLOCK         = 0x0000003dU,
    ROLE_SYSTEM_SPLITBUTTON   = 0x0000003eU,
    ROLE_SYSTEM_IPADDRESS     = 0x0000003fU,
    ROLE_SYSTEM_OUTLINEBUTTON = 0x00000040U,
}

enum : uint
{
    UIA_E_ELEMENTNOTENABLED   = 0x80040200U,
    UIA_E_ELEMENTNOTAVAILABLE = 0x80040201U,
}

enum uint UIA_E_NOCLICKABLEPOINT = 0x80040202U;
enum uint UIA_E_PROXYASSEMBLYNOTLOADED = 0x80040203U;
enum uint UIA_E_NOTSUPPORTED = 0x80040204U;
enum uint UIA_E_INVALIDOPERATION = 0x80131509U;
enum uint UIA_E_TIMEOUT = 0x80131505U;
enum uint UiaAppendRuntimeId = 0x00000003U;
enum int UiaRootObjectId = 0xffffffe7;
enum GUID RuntimeId_Property_GUID = GUID("a39eebfa-7fba-4c89-b4d4-b99e2de7d160");
enum GUID BoundingRectangle_Property_GUID = GUID("7bbfe8b2-3bfc-48dd-b729-c794b846e9a1");
enum GUID ProcessId_Property_GUID = GUID("40499998-9c31-4245-a403-87320e59eaf6");
enum GUID ControlType_Property_GUID = GUID("ca774fea-28ac-4bc2-94ca-acec6d6c10a3");
enum GUID LocalizedControlType_Property_GUID = GUID("8763404f-a1bd-452a-89c4-3f01d3833806");
enum GUID Name_Property_GUID = GUID("c3a6921b-4a99-44f1-bca6-61187052c431");
enum GUID AcceleratorKey_Property_GUID = GUID("514865df-2557-4cb9-aeed-6ced084ce52c");
enum GUID AccessKey_Property_GUID = GUID("06827b12-a7f9-4a15-917c-ffa5ad3eb0a7");
enum GUID HasKeyboardFocus_Property_GUID = GUID("cf8afd39-3f46-4800-9656-b2bf12529905");
enum GUID IsKeyboardFocusable_Property_GUID = GUID("f7b8552a-0859-4b37-b9cb-51e72092f29f");
enum GUID IsEnabled_Property_GUID = GUID("2109427f-da60-4fed-bf1b-264bdce6eb3a");
enum GUID AutomationId_Property_GUID = GUID("c82c0500-b60e-4310-a267-303c531f8ee5");
enum GUID ClassName_Property_GUID = GUID("157b7215-894f-4b65-84e2-aac0da08b16b");
enum GUID HelpText_Property_GUID = GUID("08555685-0977-45c7-a7a6-abaf5684121a");
enum GUID ClickablePoint_Property_GUID = GUID("0196903b-b203-4818-a9f3-f08e675f2341");
enum GUID Culture_Property_GUID = GUID("e2d74f27-3d79-4dc2-b88b-3044963a8afb");
enum GUID IsControlElement_Property_GUID = GUID("95f35085-abcc-4afd-a5f4-dbb46c230fdb");
enum GUID IsContentElement_Property_GUID = GUID("4bda64a8-f5d8-480b-8155-ef2e89adb672");
enum GUID LabeledBy_Property_GUID = GUID("e5b8924b-fc8a-4a35-8031-cf78ac43e55e");
enum GUID IsPassword_Property_GUID = GUID("e8482eb1-687c-497b-bebc-03be53ec1454");
enum GUID NewNativeWindowHandle_Property_GUID = GUID("5196b33b-380a-4982-95e1-91f3ef60e024");
enum GUID ItemType_Property_GUID = GUID("cdda434d-6222-413b-a68a-325dd1d40f39");
enum GUID IsOffscreen_Property_GUID = GUID("03c3d160-db79-42db-a2ef-1c231eede507");
enum GUID Orientation_Property_GUID = GUID("a01eee62-3884-4415-887e-678ec21e39ba");
enum GUID FrameworkId_Property_GUID = GUID("dbfd9900-7e1a-4f58-b61b-7063120f773b");
enum GUID IsRequiredForForm_Property_GUID = GUID("4f5f43cf-59fb-4bde-a270-602e5e1141e9");
enum GUID ItemStatus_Property_GUID = GUID("51de0321-3973-43e7-8913-0b08e813c37f");
enum GUID AriaRole_Property_GUID = GUID("dd207b95-be4a-4e0d-b727-63ace94b6916");
enum GUID AriaProperties_Property_GUID = GUID("4213678c-e025-4922-beb5-e43ba08e6221");
enum GUID IsDataValidForForm_Property_GUID = GUID("445ac684-c3fc-4dd9-acf8-845a579296ba");
enum GUID ControllerFor_Property_GUID = GUID("51124c8a-a5d2-4f13-9be6-7fa8ba9d3a90");
enum GUID DescribedBy_Property_GUID = GUID("7c5865b8-9992-40fd-8db0-6bf1d317f998");
enum GUID FlowsTo_Property_GUID = GUID("e4f33d20-559a-47fb-a830-f9cb4ff1a70a");
enum GUID ProviderDescription_Property_GUID = GUID("dca5708a-c16b-4cd9-b889-beb16a804904");
enum GUID OptimizeForVisualContent_Property_GUID = GUID("6a852250-c75a-4e5d-b858-e381b0f78861");
enum GUID IsDockPatternAvailable_Property_GUID = GUID("2600a4c4-2ff8-4c96-ae31-8fe619a13c6c");
enum GUID IsExpandCollapsePatternAvailable_Property_GUID = GUID("929d3806-5287-4725-aa16-222afc63d595");
enum GUID IsGridItemPatternAvailable_Property_GUID = GUID("5a43e524-f9a2-4b12-84c8-b48a3efedd34");
enum GUID IsGridPatternAvailable_Property_GUID = GUID("5622c26c-f0ef-4f3b-97cb-714c0868588b");
enum GUID IsInvokePatternAvailable_Property_GUID = GUID("4e725738-8364-4679-aa6c-f3f41931f750");
enum GUID IsMultipleViewPatternAvailable_Property_GUID = GUID("ff0a31eb-8e25-469d-8d6e-e771a27c1b90");
enum GUID IsRangeValuePatternAvailable_Property_GUID = GUID("fda4244a-eb4d-43ff-b5ad-ed36d373ec4c");
enum GUID IsScrollPatternAvailable_Property_GUID = GUID("3ebb7b4a-828a-4b57-9d22-2fea1632ed0d");
enum GUID IsScrollItemPatternAvailable_Property_GUID = GUID("1cad1a05-0927-4b76-97e1-0fcdb209b98a");
enum GUID IsSelectionItemPatternAvailable_Property_GUID = GUID("8becd62d-0bc3-4109-bee2-8e6715290e68");
enum GUID IsSelectionPatternAvailable_Property_GUID = GUID("f588acbe-c769-4838-9a60-2686dc1188c4");
enum GUID IsTablePatternAvailable_Property_GUID = GUID("cb83575f-45c2-4048-9c76-159715a139df");
enum GUID IsTableItemPatternAvailable_Property_GUID = GUID("eb36b40d-8ea4-489b-a013-e60d5951fe34");
enum GUID IsTextPatternAvailable_Property_GUID = GUID("fbe2d69d-aff6-4a45-82e2-fc92a82f5917");
enum GUID IsTogglePatternAvailable_Property_GUID = GUID("78686d53-fcd0-4b83-9b78-5832ce63bb5b");
enum GUID IsTransformPatternAvailable_Property_GUID = GUID("a7f78804-d68b-4077-a5c6-7a5ea1ac31c5");
enum GUID IsValuePatternAvailable_Property_GUID = GUID("0b5020a7-2119-473b-be37-5ceb98bbfb22");
enum GUID IsWindowPatternAvailable_Property_GUID = GUID("e7a57bb1-5888-4155-98dc-b422fd57f2bc");
enum GUID IsLegacyIAccessiblePatternAvailable_Property_GUID = GUID("d8ebd0c7-929a-4ee7-8d3a-d3d94413027b");
enum GUID IsItemContainerPatternAvailable_Property_GUID = GUID("624b5ca7-fe40-4957-a019-20c4cf11920f");
enum GUID IsVirtualizedItemPatternAvailable_Property_GUID = GUID("302cb151-2ac8-45d6-977b-d2b3a5a53f20");
enum GUID IsSynchronizedInputPatternAvailable_Property_GUID = GUID("75d69cc5-d2bf-4943-876e-b45b62a6cc66");
enum GUID IsObjectModelPatternAvailable_Property_GUID = GUID("6b21d89b-2841-412f-8ef2-15ca952318ba");
enum GUID IsAnnotationPatternAvailable_Property_GUID = GUID("0b5b3238-6d5c-41b6-bcc4-5e807f6551c4");
enum GUID IsTextPattern2Available_Property_GUID = GUID("41cf921d-e3f1-4b22-9c81-e1c3ed331c22");
enum GUID IsTextEditPatternAvailable_Property_GUID = GUID("7843425c-8b32-484c-9ab5-e3200571ffda");
enum GUID IsCustomNavigationPatternAvailable_Property_GUID = GUID("8f8e80d4-2351-48e0-874a-54aa7313889a");
enum GUID IsStylesPatternAvailable_Property_GUID = GUID("27f353d3-459c-4b59-a490-50611dacafb5");
enum GUID IsSpreadsheetPatternAvailable_Property_GUID = GUID("6ff43732-e4b4-4555-97bc-ecdbbc4d1888");
enum GUID IsSpreadsheetItemPatternAvailable_Property_GUID = GUID("9fe79b2a-2f94-43fd-996b-549e316f4acd");
enum GUID IsTransformPattern2Available_Property_GUID = GUID("25980b4b-be04-4710-ab4a-fda31dbd2895");
enum GUID IsTextChildPatternAvailable_Property_GUID = GUID("559e65df-30ff-43b5-b5ed-5b283b80c7e9");
enum GUID IsDragPatternAvailable_Property_GUID = GUID("e997a7b7-1d39-4ca7-be0f-277fcf5605cc");
enum GUID IsDropTargetPatternAvailable_Property_GUID = GUID("0686b62e-8e19-4aaf-873d-384f6d3b92be");
enum GUID IsStructuredMarkupPatternAvailable_Property_GUID = GUID("b0d4c196-2c0b-489c-b165-a405928c6f3d");
enum GUID IsPeripheral_Property_GUID = GUID("da758276-7ed5-49d4-8e68-ecc9a2d300dd");
enum GUID PositionInSet_Property_GUID = GUID("33d1dc54-641e-4d76-a6b1-13f341c1f896");
enum GUID SizeOfSet_Property_GUID = GUID("1600d33c-3b9f-4369-9431-aa293f344cf1");
enum GUID Level_Property_GUID = GUID("242ac529-cd36-400f-aad9-7876ef3af627");
enum GUID AnnotationTypes_Property_GUID = GUID("64b71f76-53c4-4696-a219-20e940c9a176");
enum GUID AnnotationObjects_Property_GUID = GUID("310910c8-7c6e-4f20-becd-4aaf6d191156");
enum GUID LandmarkType_Property_GUID = GUID("454045f2-6f61-49f7-a4f8-b5f0cf82da1e");
enum GUID LocalizedLandmarkType_Property_GUID = GUID("7ac81980-eafb-4fb2-bf91-f485bef5e8e1");
enum GUID FullDescription_Property_GUID = GUID("0d4450ff-6aef-4f33-95dd-7befa72a4391");
enum GUID Value_Value_Property_GUID = GUID("e95f5e64-269f-4a85-ba99-4092c3ea2986");
enum GUID Value_IsReadOnly_Property_GUID = GUID("eb090f30-e24c-4799-a705-0d247bc037f8");
enum GUID RangeValue_Value_Property_GUID = GUID("131f5d98-c50c-489d-abe5-ae220898c5f7");
enum GUID RangeValue_IsReadOnly_Property_GUID = GUID("25fa1055-debf-4373-a79e-1f1a1908d3c4");
enum GUID RangeValue_Minimum_Property_GUID = GUID("78cbd3b2-684d-4860-af93-d1f95cb022fd");
enum GUID RangeValue_Maximum_Property_GUID = GUID("19319914-f979-4b35-a1a6-d37e05433473");
enum GUID RangeValue_LargeChange_Property_GUID = GUID("a1f96325-3a3d-4b44-8e1f-4a46d9844019");
enum GUID RangeValue_SmallChange_Property_GUID = GUID("81c2c457-3941-4107-9975-139760f7c072");
enum GUID Scroll_HorizontalScrollPercent_Property_GUID = GUID("c7c13c0e-eb21-47ff-acc4-b5a3350f5191");
enum GUID Scroll_HorizontalViewSize_Property_GUID = GUID("70c2e5d4-fcb0-4713-a9aa-af92ff79e4cd");
enum GUID Scroll_VerticalScrollPercent_Property_GUID = GUID("6c8d7099-b2a8-4948-bff7-3cf9058bfefb");
enum GUID Scroll_VerticalViewSize_Property_GUID = GUID("de6a2e22-d8c7-40c5-83ba-e5f681d53108");
enum GUID Scroll_HorizontallyScrollable_Property_GUID = GUID("8b925147-28cd-49ae-bd63-f44118d2e719");
enum GUID Scroll_VerticallyScrollable_Property_GUID = GUID("89164798-0068-4315-b89a-1e7cfbbc3dfc");
enum GUID Selection_Selection_Property_GUID = GUID("aa6dc2a2-0e2b-4d38-96d5-34e470b81853");
enum GUID Selection_CanSelectMultiple_Property_GUID = GUID("49d73da5-c883-4500-883d-8fcf8daf6cbe");
enum GUID Selection_IsSelectionRequired_Property_GUID = GUID("b1ae4422-63fe-44e7-a5a5-a738c829b19a");
enum GUID Grid_RowCount_Property_GUID = GUID("2a9505bf-c2eb-4fb6-b356-8245ae53703e");
enum GUID Grid_ColumnCount_Property_GUID = GUID("fe96f375-44aa-4536-ac7a-2a75d71a3efc");
enum GUID GridItem_Row_Property_GUID = GUID("6223972a-c945-4563-9329-fdc974af2553");
enum GUID GridItem_Column_Property_GUID = GUID("c774c15c-62c0-4519-8bdc-47be573c8ad5");
enum GUID GridItem_RowSpan_Property_GUID = GUID("4582291c-466b-4e93-8e83-3d1715ec0c5e");
enum GUID GridItem_ColumnSpan_Property_GUID = GUID("583ea3f5-86d0-4b08-a6ec-2c5463ffc109");
enum GUID GridItem_Parent_Property_GUID = GUID("9d912252-b97f-4ecc-8510-ea0e33427c72");
enum GUID Dock_DockPosition_Property_GUID = GUID("6d67f02e-c0b0-4b10-b5b9-18d6ecf98760");
enum GUID ExpandCollapse_ExpandCollapseState_Property_GUID = GUID("275a4c48-85a7-4f69-aba0-af157610002b");
enum GUID MultipleView_CurrentView_Property_GUID = GUID("7a81a67a-b94f-4875-918b-65c8d2f998e5");
enum GUID MultipleView_SupportedViews_Property_GUID = GUID("8d5db9fd-ce3c-4ae7-b788-400a3c645547");
enum GUID Window_CanMaximize_Property_GUID = GUID("64fff53f-635d-41c1-950c-cb5adfbe28e3");
enum GUID Window_CanMinimize_Property_GUID = GUID("b73b4625-5988-4b97-b4c2-a6fe6e78c8c6");
enum GUID Window_WindowVisualState_Property_GUID = GUID("4ab7905f-e860-453e-a30a-f6431e5daad5");
enum GUID Window_WindowInteractionState_Property_GUID = GUID("4fed26a4-0455-4fa2-b21c-c4da2db1ff9c");
enum GUID Window_IsModal_Property_GUID = GUID("ff4e6892-37b9-4fca-8532-ffe674ecfeed");
enum GUID Window_IsTopmost_Property_GUID = GUID("ef7d85d3-0937-4962-9241-b62345f24041");
enum GUID SelectionItem_IsSelected_Property_GUID = GUID("f122835f-cd5f-43df-b79d-4b849e9e6020");
enum GUID SelectionItem_SelectionContainer_Property_GUID = GUID("a4365b6e-9c1e-4b63-8b53-c2421dd1e8fb");
enum GUID Table_RowHeaders_Property_GUID = GUID("d9e35b87-6eb8-4562-aac6-a8a9075236a8");
enum GUID Table_ColumnHeaders_Property_GUID = GUID("aff1d72b-968d-42b1-b459-150b299da664");
enum GUID Table_RowOrColumnMajor_Property_GUID = GUID("83be75c3-29fe-4a30-85e1-2a6277fd106e");
enum GUID TableItem_RowHeaderItems_Property_GUID = GUID("b3f853a0-0574-4cd8-bcd7-ed5923572d97");
enum GUID TableItem_ColumnHeaderItems_Property_GUID = GUID("967a56a3-74b6-431e-8de6-99c411031c58");
enum GUID Toggle_ToggleState_Property_GUID = GUID("b23cdc52-22c2-4c6c-9ded-f5c422479ede");

enum : GUID
{
    Transform_CanMove_Property_GUID   = GUID("1b75824d-208b-4fdf-bccd-f1f4e5741f4f"),
    Transform_CanResize_Property_GUID = GUID("bb98dca5-4c1a-41d4-a4f6-ebc128644180"),
    Transform_CanRotate_Property_GUID = GUID("10079b48-3849-476f-ac96-44a95c8440d9"),
}

enum : GUID
{
    LegacyIAccessible_ChildId_Property_GUID          = GUID("9a191b5d-9ef2-4787-a459-dcde885dd4e8"),
    LegacyIAccessible_Name_Property_GUID             = GUID("caeb063d-40ae-4869-aa5a-1b8e5d666739"),
    LegacyIAccessible_Value_Property_GUID            = GUID("b5c5b0b6-8217-4a77-97a5-190a85ed0156"),
    LegacyIAccessible_Description_Property_GUID      = GUID("46448418-7d70-4ea9-9d27-b7e775cf2ad7"),
    LegacyIAccessible_Role_Property_GUID             = GUID("6856e59f-cbaf-4e31-93e8-bcbf6f7e491c"),
    LegacyIAccessible_State_Property_GUID            = GUID("df985854-2281-4340-ab9c-c60e2c5803f6"),
    LegacyIAccessible_Help_Property_GUID             = GUID("94402352-161c-4b77-a98d-a872cc33947a"),
    LegacyIAccessible_KeyboardShortcut_Property_GUID = GUID("8f6909ac-00b8-4259-a41c-966266d43a8a"),
}

enum : GUID
{
    LegacyIAccessible_Selection_Property_GUID     = GUID("8aa8b1e0-0891-40cc-8b06-90d7d4166219"),
    LegacyIAccessible_DefaultAction_Property_GUID = GUID("3b331729-eaad-4502-b85f-92615622913c"),
}

enum : GUID
{
    Annotation_AnnotationTypeId_Property_GUID   = GUID("20ae484f-69ef-4c48-8f5b-c4938b206ac7"),
    Annotation_AnnotationTypeName_Property_GUID = GUID("9b818892-5ac9-4af9-aa96-f58a77b058e3"),
}

enum GUID Annotation_Author_Property_GUID = GUID("7a528462-9c5c-4a03-a974-8b307a9937f2");
enum GUID Annotation_DateTime_Property_GUID = GUID("99b5ca5d-1acf-414b-a4d0-6b350b047578");
enum GUID Annotation_Target_Property_GUID = GUID("b71b302d-2104-44ad-9c5c-092b4907d70f");

enum : GUID
{
    Styles_StyleId_Property_GUID   = GUID("da82852f-3817-4233-82af-02279e72cc77"),
    Styles_StyleName_Property_GUID = GUID("1c12b035-05d1-4f55-9e8e-1489f3ff550d"),
}

enum GUID Styles_FillColor_Property_GUID = GUID("63eff97a-a1c5-4b1d-84eb-b765f2edd632");
enum GUID Styles_FillPatternStyle_Property_GUID = GUID("81cf651f-482b-4451-a30a-e1545e554fb8");
enum GUID Styles_Shape_Property_GUID = GUID("c71a23f8-778c-400d-8458-3b543e526984");
enum GUID Styles_FillPatternColor_Property_GUID = GUID("939a59fe-8fbd-4e75-a271-ac4595195163");
enum GUID Styles_ExtendedProperties_Property_GUID = GUID("f451cda0-ba0a-4681-b0b0-0dbdb53e58f3");

enum : GUID
{
    SpreadsheetItem_Formula_Property_GUID           = GUID("e602e47d-1b47-4bea-87cf-3b0b0b5c15b6"),
    SpreadsheetItem_AnnotationObjects_Property_GUID = GUID("a3194c38-c9bc-4604-9396-ae3f9f457f7b"),
    SpreadsheetItem_AnnotationTypes_Property_GUID   = GUID("c70c51d0-d602-4b45-afbc-b4712b96d72b"),
}

enum GUID Transform2_CanZoom_Property_GUID = GUID("f357e890-a756-4359-9ca6-86702bf8f381");
enum GUID LiveSetting_Property_GUID = GUID("c12bcd8e-2a8e-4950-8ae7-3625111d58eb");
enum GUID Drag_IsGrabbed_Property_GUID = GUID("45f206f3-75cc-4cca-a9b9-fcdfb982d8a2");
enum GUID Drag_GrabbedItems_Property_GUID = GUID("77c1562c-7b86-4b21-9ed7-3cefda6f4c43");

enum : GUID
{
    Drag_DropEffect_Property_GUID  = GUID("646f2779-48d3-4b23-8902-4bf100005df3"),
    Drag_DropEffects_Property_GUID = GUID("f5d61156-7ce6-49be-a836-9269dcec920f"),
}

enum : GUID
{
    DropTarget_DropTargetEffect_Property_GUID  = GUID("8bb75975-a0ca-4981-b818-87fc66e9509d"),
    DropTarget_DropTargetEffects_Property_GUID = GUID("bc1dd4ed-cb89-45f1-a592-e03b08ae790f"),
}

enum : GUID
{
    Transform2_ZoomLevel_Property_GUID   = GUID("eee29f1a-f4a2-4b5b-ac65-95cf93283387"),
    Transform2_ZoomMinimum_Property_GUID = GUID("742ccc16-4ad1-4e07-96fe-b122c6e6b22b"),
    Transform2_ZoomMaximum_Property_GUID = GUID("42ab6b77-ceb0-4eca-b82a-6cfa5fa1fc08"),
}

enum GUID FlowsFrom_Property_GUID = GUID("05c6844f-19de-48f8-95fa-880d5b0fd615");
enum GUID FillColor_Property_GUID = GUID("6e0ec4d0-e2a8-4a56-9de7-953389933b39");
enum GUID OutlineColor_Property_GUID = GUID("c395d6c0-4b55-4762-a073-fd303a634f52");
enum GUID FillType_Property_GUID = GUID("c6fc74e4-8cb9-429c-a9e1-9bc4ac372b62");
enum GUID VisualEffects_Property_GUID = GUID("e61a8565-aad9-46d7-9e70-4e8a8420d420");
enum GUID OutlineThickness_Property_GUID = GUID("13e67cc7-dac2-4888-bdd3-375c62fa9618");
enum GUID CenterPoint_Property_GUID = GUID("0cb00c08-540c-4edb-9445-26359ea69785");
enum GUID Rotation_Property_GUID = GUID("767cdc7d-aec0-4110-ad32-30edd403492e");
enum GUID Size_Property_GUID = GUID("2b5f761d-f885-4404-973f-9b1d98e36d8f");
enum GUID ToolTipOpened_Event_GUID = GUID("3f4b97ff-2edc-451d-bca4-95a3188d5b03");
enum GUID ToolTipClosed_Event_GUID = GUID("276d71ef-24a9-49b6-8e97-da98b401bbcd");
enum GUID StructureChanged_Event_GUID = GUID("59977961-3edd-4b11-b13b-676b2a2a6ca9");
enum GUID MenuOpened_Event_GUID = GUID("ebe2e945-66ca-4ed1-9ff8-2ad7df0a1b08");
enum GUID AutomationPropertyChanged_Event_GUID = GUID("2527fba1-8d7a-4630-a4cc-e66315942f52");
enum GUID AutomationFocusChanged_Event_GUID = GUID("b68a1f17-f60d-41a7-a3cc-b05292155fe0");
enum GUID ActiveTextPositionChanged_Event_GUID = GUID("a5c09e9c-c77d-4f25-b491-e5bb7017cbd4");
enum GUID AsyncContentLoaded_Event_GUID = GUID("5fdee11c-d2fa-4fb9-904e-5cbee894d5ef");
enum GUID MenuClosed_Event_GUID = GUID("3cf1266e-1582-4041-acd7-88a35a965297");
enum GUID LayoutInvalidated_Event_GUID = GUID("ed7d6544-a6bd-4595-9bae-3d28946cc715");
enum GUID Invoke_Invoked_Event_GUID = GUID("dfd699f0-c915-49dd-b422-dde785c3d24b");
enum GUID SelectionItem_ElementAddedToSelectionEvent_Event_GUID = GUID("3c822dd1-c407-4dba-91dd-79d4aed0aec6");
enum GUID SelectionItem_ElementRemovedFromSelectionEvent_Event_GUID = GUID("097fa8a9-7079-41af-8b9c-0934d8305e5c");
enum GUID SelectionItem_ElementSelectedEvent_Event_GUID = GUID("b9c7dbfb-4ebe-4532-aaf4-008cf647233c");
enum GUID Selection_InvalidatedEvent_Event_GUID = GUID("cac14904-16b4-4b53-8e47-4cb1df267bb7");
enum GUID Text_TextSelectionChangedEvent_Event_GUID = GUID("918edaa1-71b3-49ae-9741-79beb8d358f3");
enum GUID Text_TextChangedEvent_Event_GUID = GUID("4a342082-f483-48c4-ac11-a84b435e2a84");

enum : GUID
{
    Window_WindowOpened_Event_GUID = GUID("d3e81d06-de45-4f2f-9633-de9e02fb65af"),
    Window_WindowClosed_Event_GUID = GUID("edf141f8-fa67-4e22-bbf7-944e05735ee2"),
}

enum GUID MenuModeStart_Event_GUID = GUID("18d7c631-166a-4ac9-ae3b-ef4b5420e681");
enum GUID MenuModeEnd_Event_GUID = GUID("9ecd4c9f-80dd-47b8-8267-5aec06bb2cff");

enum : GUID
{
    InputReachedTarget_Event_GUID       = GUID("93ed549a-0549-40f0-bedb-28e44f7de2a3"),
    InputReachedOtherElement_Event_GUID = GUID("ed201d8a-4e6c-415e-a874-2460c9b66ba8"),
}

enum GUID InputDiscarded_Event_GUID = GUID("7f36c367-7b18-417c-97e3-9d58ddc944ab");
enum GUID SystemAlert_Event_GUID = GUID("d271545d-7a3a-47a7-8474-81d29a2451c9");
enum GUID LiveRegionChanged_Event_GUID = GUID("102d5e90-e6a9-41b6-b1c5-a9b1929d9510");
enum GUID HostedFragmentRootsInvalidated_Event_GUID = GUID("e6bdb03e-0921-4ec5-8dcf-eae877b0426b");
enum GUID Drag_DragStart_Event_GUID = GUID("883a480b-3aa9-429d-95e4-d9c8d011f0dd");
enum GUID Drag_DragCancel_Event_GUID = GUID("c3ede6fa-3451-4e0f-9e71-df9c280a4657");
enum GUID Drag_DragComplete_Event_GUID = GUID("38e96188-ef1f-463e-91ca-3a7792c29caf");

enum : GUID
{
    DropTarget_DragEnter_Event_GUID = GUID("aad9319b-032c-4a88-961d-1cf579581e34"),
    DropTarget_DragLeave_Event_GUID = GUID("0f82eb15-24a2-4988-9217-de162aee272b"),
    DropTarget_Dropped_Event_GUID   = GUID("622cead8-1edb-4a3d-abbc-be2211ff68b5"),
}

enum GUID StructuredMarkup_CompositionComplete_Event_GUID = GUID("c48a3c17-677a-4047-a68d-fc1257528aef");

enum : GUID
{
    StructuredMarkup_Deleted_Event_GUID          = GUID("f9d0a020-e1c1-4ecf-b9aa-52efde7e41e1"),
    StructuredMarkup_SelectionChanged_Event_GUID = GUID("a7c815f7-ff9f-41c7-a3a7-ab6cbfdb4903"),
}

enum GUID Invoke_Pattern_GUID = GUID("d976c2fc-66ea-4a6e-b28f-c24c7546ad37");
enum GUID Selection_Pattern_GUID = GUID("66e3b7e8-d821-4d25-8761-435d2c8b253f");
enum GUID Value_Pattern_GUID = GUID("17faad9e-c877-475b-b933-77332779b637");
enum GUID RangeValue_Pattern_GUID = GUID("18b00d87-b1c9-476a-bfbd-5f0bdb926f63");
enum GUID Scroll_Pattern_GUID = GUID("895fa4b4-759d-4c50-8e15-03460672003c");
enum GUID ExpandCollapse_Pattern_GUID = GUID("ae05efa2-f9d1-428a-834c-53a5c52f9b8b");
enum GUID Grid_Pattern_GUID = GUID("260a2ccb-93a8-4e44-a4c1-3df397f2b02b");
enum GUID GridItem_Pattern_GUID = GUID("f2d5c877-a462-4957-a2a5-2c96b303bc63");
enum GUID MultipleView_Pattern_GUID = GUID("547a6ae4-113f-47c4-850f-db4dfa466b1d");
enum GUID Window_Pattern_GUID = GUID("27901735-c760-4994-ad11-5919e606b110");
enum GUID SelectionItem_Pattern_GUID = GUID("9bc64eeb-87c7-4b28-94bb-4d9fa437b6ef");
enum GUID Dock_Pattern_GUID = GUID("9cbaa846-83c8-428d-827f-7e6063fe0620");
enum GUID Table_Pattern_GUID = GUID("c415218e-a028-461e-aa92-8f925cf79351");
enum GUID TableItem_Pattern_GUID = GUID("df1343bd-1888-4a29-a50c-b92e6de37f6f");
enum GUID Text_Pattern_GUID = GUID("8615f05d-7de5-44fd-a679-2ca4b46033a8");
enum GUID Toggle_Pattern_GUID = GUID("0b419760-e2f4-43ff-8c5f-9457c82b56e9");
enum GUID Transform_Pattern_GUID = GUID("24b46fdb-587e-49f1-9c4a-d8e98b664b7b");
enum GUID ScrollItem_Pattern_GUID = GUID("4591d005-a803-4d5c-b4d5-8d2800f906a7");
enum GUID LegacyIAccessible_Pattern_GUID = GUID("54cc0a9f-3395-48af-ba8d-73f85690f3e0");
enum GUID ItemContainer_Pattern_GUID = GUID("3d13da0f-8b9a-4a99-85fa-c5c9a69f1ed4");
enum GUID VirtualizedItem_Pattern_GUID = GUID("f510173e-2e71-45e9-a6e5-62f6ed8289d5");
enum GUID SynchronizedInput_Pattern_GUID = GUID("05c288a6-c47b-488b-b653-33977a551b8b");
enum GUID ObjectModel_Pattern_GUID = GUID("3e04acfe-08fc-47ec-96bc-353fa3b34aa7");
enum GUID Annotation_Pattern_GUID = GUID("f6c72ad7-356c-4850-9291-316f608a8c84");
enum GUID Text_Pattern2_GUID = GUID("498479a2-5b22-448d-b6e4-647490860698");
enum GUID TextEdit_Pattern_GUID = GUID("69f3ff89-5af9-4c75-9340-f2de292e4591");
enum GUID CustomNavigation_Pattern_GUID = GUID("afea938a-621e-4054-bb2c-2f46114dac3f");
enum GUID Styles_Pattern_GUID = GUID("1ae62655-da72-4d60-a153-e5aa6988e3bf");

enum : GUID
{
    Spreadsheet_Pattern_GUID     = GUID("6a5b24c9-9d1e-4b85-9e44-c02e3169b10b"),
    SpreadsheetItem_Pattern_GUID = GUID("32cf83ff-f1a8-4a8c-8658-d47ba74e20ba"),
}

enum GUID Tranform_Pattern2_GUID = GUID("8afcfd07-a369-44de-988b-2f7ff49fb8a8");
enum GUID TextChild_Pattern_GUID = GUID("7533cab7-3bfe-41ef-9e85-e2638cbe169e");
enum GUID Drag_Pattern_GUID = GUID("c0bee21f-ccb3-4fed-995b-114f6e3d2728");
enum GUID DropTarget_Pattern_GUID = GUID("0bcbec56-bd34-4b7b-9fd5-2659905ea3dc");
enum GUID StructuredMarkup_Pattern_GUID = GUID("abbd0878-8665-4f5c-94fc-36e7d8bb706b");
enum GUID Button_Control_GUID = GUID("5a78e369-c6a1-4f33-a9d7-79f20d0c788e");
enum GUID Calendar_Control_GUID = GUID("8913eb88-00e5-46bc-8e4e-14a786e165a1");
enum GUID CheckBox_Control_GUID = GUID("fb50f922-a3db-49c0-8bc3-06dad55778e2");
enum GUID ComboBox_Control_GUID = GUID("54cb426c-2f33-4fff-aaa1-aef60dac5deb");
enum GUID Edit_Control_GUID = GUID("6504a5c8-2c86-4f87-ae7b-1abddc810cf9");
enum GUID Hyperlink_Control_GUID = GUID("8a56022c-b00d-4d15-8ff0-5b6b266e5e02");
enum GUID Image_Control_GUID = GUID("2d3736e4-6b16-4c57-a962-f93260a75243");
enum GUID ListItem_Control_GUID = GUID("7b3717f2-44d1-4a58-98a8-f12a9b8f78e2");
enum GUID List_Control_GUID = GUID("9b149ee1-7cca-4cfc-9af1-cac7bddd3031");
enum GUID Menu_Control_GUID = GUID("2e9b1440-0ea8-41fd-b374-c1ea6f503cd1");
enum GUID MenuBar_Control_GUID = GUID("cc384250-0e7b-4ae8-95ae-a08f261b52ee");
enum GUID MenuItem_Control_GUID = GUID("f45225d3-d0a0-49d8-9834-9a000d2aeddc");
enum GUID ProgressBar_Control_GUID = GUID("228c9f86-c36c-47bb-9fb6-a5834bfc53a4");
enum GUID RadioButton_Control_GUID = GUID("3bdb49db-fe2c-4483-b3e1-e57f219440c6");
enum GUID ScrollBar_Control_GUID = GUID("daf34b36-5065-4946-b22f-92595fc0751a");
enum GUID Slider_Control_GUID = GUID("b033c24b-3b35-4cea-b609-763682fa660b");
enum GUID Spinner_Control_GUID = GUID("60cc4b38-3cb1-4161-b442-c6b726c17825");
enum GUID StatusBar_Control_GUID = GUID("d45e7d1b-5873-475f-95a4-0433e1f1b00a");
enum GUID Tab_Control_GUID = GUID("38cd1f2d-337a-4bd2-a5e3-adb469e30bd3");
enum GUID TabItem_Control_GUID = GUID("2c6a634f-921b-4e6e-b26e-08fcb0798f4c");
enum GUID Text_Control_GUID = GUID("ae9772dc-d331-4f09-be20-7e6dfaf07b0a");
enum GUID ToolBar_Control_GUID = GUID("8f06b751-e182-4e98-8893-2284543a7dce");
enum GUID ToolTip_Control_GUID = GUID("05ddc6d1-2137-4768-98ea-73f52f7134f3");
enum GUID Tree_Control_GUID = GUID("7561349c-d241-43f4-9908-b5f091bee611");
enum GUID TreeItem_Control_GUID = GUID("62c9feb9-8ffc-4878-a3a4-96b030315c18");
enum GUID Custom_Control_GUID = GUID("f29ea0c3-adb7-430a-ba90-e52c7313e6ed");
enum GUID Group_Control_GUID = GUID("ad50aa1c-e8c8-4774-ae1b-dd86df0b3bdc");
enum GUID Thumb_Control_GUID = GUID("701ca877-e310-4dd6-b644-797e4faea213");
enum GUID DataGrid_Control_GUID = GUID("84b783af-d103-4b0a-8415-e73942410f4b");
enum GUID DataItem_Control_GUID = GUID("a0177842-d94f-42a5-814b-6068addc8da5");
enum GUID Document_Control_GUID = GUID("3cd6bb6f-6f08-4562-b229-e4e2fc7a9eb4");
enum GUID SplitButton_Control_GUID = GUID("7011f01f-4ace-4901-b461-920a6f1ca650");
enum GUID Window_Control_GUID = GUID("e13a7242-f462-4f4d-aec1-53b28d6c3290");
enum GUID Pane_Control_GUID = GUID("5c2b3f5b-9182-42a3-8dec-8c04c1ee634d");
enum GUID Header_Control_GUID = GUID("5b90cbce-78fb-4614-82b6-554d74718e67");
enum GUID HeaderItem_Control_GUID = GUID("e6bc12cb-7c8e-49cf-b168-4a93a32bebb0");
enum GUID Table_Control_GUID = GUID("773bfa0e-5bc4-4deb-921b-de7b3206229e");
enum GUID TitleBar_Control_GUID = GUID("98aa55bf-3bb0-4b65-836e-2ea30dbc171f");
enum GUID Separator_Control_GUID = GUID("8767eba3-2a63-4ab0-ac8d-aa50e23de978");
enum GUID SemanticZoom_Control_GUID = GUID("5fd34a43-061e-42c8-b589-9dccf74bc43a");
enum GUID AppBar_Control_GUID = GUID("6114908d-cc02-4d37-875b-b530c7139554");
enum GUID Text_AnimationStyle_Attribute_GUID = GUID("628209f0-7c9a-4d57-be64-1f1836571ff5");
enum GUID Text_BackgroundColor_Attribute_GUID = GUID("fdc49a07-583d-4f17-ad27-77fc832a3c0b");
enum GUID Text_BulletStyle_Attribute_GUID = GUID("c1097c90-d5c4-4237-9781-3bec8ba54e48");
enum GUID Text_CapStyle_Attribute_GUID = GUID("fb059c50-92cc-49a5-ba8f-0aa872bba2f3");
enum GUID Text_Culture_Attribute_GUID = GUID("c2025af9-a42d-4ced-a1fb-c6746315222e");
enum GUID Text_FontName_Attribute_GUID = GUID("64e63ba8-f2e5-476e-a477-1734feaaf726");
enum GUID Text_FontSize_Attribute_GUID = GUID("dc5eeeff-0506-4673-93f2-377e4a8e01f1");
enum GUID Text_FontWeight_Attribute_GUID = GUID("6fc02359-b316-4f5f-b401-f1ce55741853");
enum GUID Text_ForegroundColor_Attribute_GUID = GUID("72d1c95d-5e60-471a-96b1-6c1b3b77a436");
enum GUID Text_HorizontalTextAlignment_Attribute_GUID = GUID("04ea6161-fba3-477a-952a-bb326d026a5b");
enum GUID Text_IndentationFirstLine_Attribute_GUID = GUID("206f9ad5-c1d3-424a-8182-6da9a7f3d632");

enum : GUID
{
    Text_IndentationLeading_Attribute_GUID  = GUID("5cf66bac-2d45-4a4b-b6c9-f7221d2815b0"),
    Text_IndentationTrailing_Attribute_GUID = GUID("97ff6c0f-1ce4-408a-b67b-94d83eb69bf2"),
}

enum GUID Text_IsHidden_Attribute_GUID = GUID("360182fb-bdd7-47f6-ab69-19e33f8a3344");
enum GUID Text_IsItalic_Attribute_GUID = GUID("fce12a56-1336-4a34-9663-1bab47239320");
enum GUID Text_IsReadOnly_Attribute_GUID = GUID("a738156b-ca3e-495e-9514-833c440feb11");
enum GUID Text_IsSubscript_Attribute_GUID = GUID("f0ead858-8f53-413c-873f-1a7d7f5e0de4");
enum GUID Text_IsSuperscript_Attribute_GUID = GUID("da706ee4-b3aa-4645-a41f-cd25157dea76");
enum GUID Text_MarginBottom_Attribute_GUID = GUID("7ee593c4-72b4-4cac-9271-3ed24b0e4d42");
enum GUID Text_MarginLeading_Attribute_GUID = GUID("9e9242d0-5ed0-4900-8e8a-eecc03835afc");

enum : GUID
{
    Text_MarginTop_Attribute_GUID      = GUID("683d936f-c9b9-4a9a-b3d9-d20d33311e2a"),
    Text_MarginTrailing_Attribute_GUID = GUID("af522f98-999d-40af-a5b2-0169d0342002"),
}

enum GUID Text_OutlineStyles_Attribute_GUID = GUID("5b675b27-db89-46fe-970c-614d523bb97d");
enum GUID Text_OverlineColor_Attribute_GUID = GUID("83ab383a-fd43-40da-ab3e-ecf8165cbb6d");
enum GUID Text_OverlineStyle_Attribute_GUID = GUID("0a234d66-617e-427f-871d-e1ff1e0c213f");

enum : GUID
{
    Text_StrikethroughColor_Attribute_GUID = GUID("bfe15a18-8c41-4c5a-9a0b-04af0e07f487"),
    Text_StrikethroughStyle_Attribute_GUID = GUID("72913ef1-da00-4f01-899c-ac5a8577a307"),
}

enum GUID Text_Tabs_Attribute_GUID = GUID("2e68d00b-92fe-42d8-899a-a784aa4454a1");
enum GUID Text_TextFlowDirections_Attribute_GUID = GUID("8bdf8739-f420-423e-af77-20a5d973a907");

enum : GUID
{
    Text_UnderlineColor_Attribute_GUID = GUID("bfa12c73-fde2-4473-bf64-1036d6aa0f45"),
    Text_UnderlineStyle_Attribute_GUID = GUID("5f3b21c0-ede4-44bd-9c36-3853038cbfeb"),
}

enum : GUID
{
    Text_AnnotationTypes_Attribute_GUID   = GUID("ad2eb431-ee4e-4be1-a7ba-5559155a73ef"),
    Text_AnnotationObjects_Attribute_GUID = GUID("ff41cf68-e7ab-40b9-8c72-72a8ed94017d"),
}

enum GUID Text_StyleName_Attribute_GUID = GUID("22c9e091-4d66-45d8-a828-737bab4c98a7");
enum GUID Text_StyleId_Attribute_GUID = GUID("14c300de-c32b-449b-ab7c-b0e0789aea5d");
enum GUID Text_Link_Attribute_GUID = GUID("b38ef51d-9e8d-4e46-9144-56ebe177329b");
enum GUID Text_IsActive_Attribute_GUID = GUID("f5a4e533-e1b8-436b-935d-b57aa3f558c4");
enum GUID Text_SelectionActiveEnd_Attribute_GUID = GUID("1f668cc3-9bbf-416b-b0a2-f89f86f6612c");
enum GUID Text_CaretPosition_Attribute_GUID = GUID("b227b131-9889-4752-a91b-733efdc5c5a0");
enum GUID Text_CaretBidiMode_Attribute_GUID = GUID("929ee7a6-51d3-4715-96dc-b694fa24a168");
enum GUID Text_BeforeParagraphSpacing_Attribute_GUID = GUID("be7b0ab1-c822-4a24-85e9-c8f2650fc79c");
enum GUID Text_AfterParagraphSpacing_Attribute_GUID = GUID("588cbb38-e62f-497c-b5d1-ccdf0ee823d8");
enum GUID Text_LineSpacing_Attribute_GUID = GUID("63ff70ae-d943-4b47-8ab7-a7a033d3214b");
enum GUID Text_BeforeSpacing_Attribute_GUID = GUID("be7b0ab1-c822-4a24-85e9-c8f2650fc79c");
enum GUID Text_AfterSpacing_Attribute_GUID = GUID("588cbb38-e62f-497c-b5d1-ccdf0ee823d8");
enum GUID Text_SayAsInterpretAs_Attribute_GUID = GUID("b38ad6ac-eee1-4b6e-88cc-014cefa93fcb");
enum GUID TextEdit_TextChanged_Event_GUID = GUID("120b0308-ec22-4eb8-9c98-9867cda1b165");
enum GUID TextEdit_ConversionTargetChanged_Event_GUID = GUID("3388c183-ed4f-4c8b-9baa-364d51d8847f");
enum GUID Changes_Event_GUID = GUID("7df26714-614f-4e05-9488-716c5ba19436");

enum : GUID
{
    Annotation_Custom_GUID        = GUID("9ec82750-3931-4952-85bc-1dbff78a43e3"),
    Annotation_SpellingError_GUID = GUID("ae85567e-9ece-423f-81b7-96c43d53e50e"),
}

enum GUID Annotation_GrammarError_GUID = GUID("757a048d-4518-41c6-854c-dc009b7cfb53");

enum : GUID
{
    Annotation_Comment_GUID      = GUID("fd2fda30-26b3-4c06-8bc7-98f1532e46fd"),
    Annotation_FormulaError_GUID = GUID("95611982-0cab-46d5-a2f0-e30d1905f8bf"),
}

enum GUID Annotation_TrackChanges_GUID = GUID("21e6e888-dc14-4016-ac27-190553c8c470");

enum : GUID
{
    Annotation_Header_GUID          = GUID("867b409b-b216-4472-a219-525e310681f8"),
    Annotation_Footer_GUID          = GUID("cceab046-1833-47aa-8080-701ed0b0c832"),
    Annotation_Highlighted_GUID     = GUID("757c884e-8083-4081-8b9c-e87f5072f0e4"),
    Annotation_Endnote_GUID         = GUID("7565725c-2d99-4839-960d-33d3b866aba5"),
    Annotation_Footnote_GUID        = GUID("3de10e21-4125-42db-8620-be8083080624"),
    Annotation_InsertionChange_GUID = GUID("0dbeb3a6-df15-4164-a3c0-e21a8ce931c4"),
}

enum GUID Annotation_DeletionChange_GUID = GUID("be3d5b05-951d-42e7-901d-adc8c2cf34d0");

enum : GUID
{
    Annotation_MoveChange_GUID   = GUID("9da587eb-23e5-4490-b385-1a22ddc8b187"),
    Annotation_FormatChange_GUID = GUID("eb247345-d4f1-41ce-8e52-f79b69635e48"),
}

enum GUID Annotation_UnsyncedChange_GUID = GUID("1851116a-0e47-4b30-8cb5-d7dae4fbcd1b");
enum GUID Annotation_EditingLockedChange_GUID = GUID("c31f3e1c-7423-4dac-8348-41f099ff6f64");
enum GUID Annotation_ExternalChange_GUID = GUID("75a05b31-5f11-42fd-887d-dfa010db2392");
enum GUID Annotation_ConflictingChange_GUID = GUID("98af8802-517c-459f-af13-016d3fab877e");

enum : GUID
{
    Annotation_Author_GUID                = GUID("f161d3a7-f81b-4128-b17f-71f690914520"),
    Annotation_AdvancedProofingIssue_GUID = GUID("dac7b72c-c0f2-4b84-b90d-5fafc0f0ef1c"),
}

enum GUID Annotation_DataValidationError_GUID = GUID("c8649fa8-9775-437e-ad46-e709d93c2343");
enum GUID Annotation_CircularReferenceError_GUID = GUID("25bd9cf4-1745-4659-ba67-727f0318c616");

enum : GUID
{
    Annotation_Mathematics_GUID = GUID("eaab634b-26d0-40c1-8073-57ca1c633c9b"),
    Annotation_Sensitive_GUID   = GUID("37f4c04f-0f12-4464-929c-828fd15292e3"),
}

enum GUID Changes_Summary_GUID = GUID("313d65a6-e60f-4d62-9861-55afd728d207");

enum : GUID
{
    StyleId_Custom_GUID   = GUID("ef2edd3e-a999-4b7c-a378-09bbd52a3516"),
    StyleId_Heading1_GUID = GUID("7f7e8f69-6866-4621-930c-9a5d0ca5961c"),
    StyleId_Heading2_GUID = GUID("baa9b241-5c69-469d-85ad-474737b52b14"),
    StyleId_Heading3_GUID = GUID("bf8be9d2-d8b8-4ec5-8c52-9cfb0d035970"),
    StyleId_Heading4_GUID = GUID("8436ffc0-9578-45fc-83a4-ff40053315dd"),
    StyleId_Heading5_GUID = GUID("909f424d-0dbf-406e-97bb-4e773d9798f7"),
    StyleId_Heading6_GUID = GUID("89d23459-5d5b-4824-a420-11d3ed82e40f"),
    StyleId_Heading7_GUID = GUID("a3790473-e9ae-422d-b8e3-3b675c6181a4"),
    StyleId_Heading8_GUID = GUID("2bc14145-a40c-4881-84ae-f2235685380c"),
    StyleId_Heading9_GUID = GUID("c70d9133-bb2a-43d3-8ac6-33657884b0f0"),
}

enum : GUID
{
    StyleId_Title_GUID    = GUID("15d8201a-ffcf-481f-b0a1-30b63be98f07"),
    StyleId_Subtitle_GUID = GUID("b5d9fc17-5d6f-4420-b439-7cb19ad434e2"),
}

enum : GUID
{
    StyleId_Normal_GUID   = GUID("cd14d429-e45e-4475-a1c5-7f9e6be96eba"),
    StyleId_Emphasis_GUID = GUID("ca6e7dbe-355e-4820-95a0-925f041d3470"),
}

enum : GUID
{
    StyleId_Quote_GUID        = GUID("5d1c21ea-8195-4f6c-87ea-5dabece64c1d"),
    StyleId_BulletedList_GUID = GUID("5963ed64-6426-4632-8caf-a32ad402d91a"),
}

enum GUID StyleId_NumberedList_GUID = GUID("1e96dbd5-64c3-43d0-b1ee-b53b06e3eddf");
enum GUID Notification_Event_GUID = GUID("72c5a2f7-9788-480f-b8eb-4dee00f6186f");
enum GUID SID_IsUIAutomationObject = GUID("b96fdb85-7204-4724-842b-c7059dedb9d0");
enum GUID SID_ControlElementProvider = GUID("f4791d68-e254-4ba3-9a53-26a5c5497946");
enum GUID IsSelectionPattern2Available_Property_GUID = GUID("490806fb-6e89-4a47-8319-d266e511f021");
enum GUID Selection2_FirstSelectedItem_Property_GUID = GUID("cc24ea67-369c-4e55-9ff7-38da69540c29");
enum GUID Selection2_LastSelectedItem_Property_GUID = GUID("cf7bda90-2d83-49f8-860c-9ce394cf89b4");
enum GUID Selection2_CurrentSelectedItem_Property_GUID = GUID("34257c26-83b5-41a6-939c-ae841c136236");
enum GUID Selection2_ItemCount_Property_GUID = GUID("bb49eb9f-456d-4048-b591-9c2026b84636");
enum GUID Selection_Pattern2_GUID = GUID("fba25cab-ab98-49f7-a7dc-fe539dc15be7");
enum GUID HeadingLevel_Property_GUID = GUID("29084272-aaaf-4a30-8796-3c12f62b6bbb");
enum GUID IsDialog_Property_GUID = GUID("9d0dfb9b-8436-4501-bbbb-e534a4fb3b3f");

enum : uint
{
    UIA_IAFP_DEFAULT       = 0x00000000U,
    UIA_IAFP_UNWRAP_BRIDGE = 0x00000001U,
}

enum : uint
{
    UIA_PFIA_DEFAULT       = 0x00000000U,
    UIA_PFIA_UNWRAP_BRIDGE = 0x00000001U,
}

enum double UIA_ScrollPatternNoScroll = -0x1p+0;

// Callbacks

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
alias WINEVENTPROC = void function(HWINEVENTHOOK hWinEventHook, uint event, HWND hwnd, int idObject, int idChild, 
                                   uint idEventThread, uint dwmsEventTime);

// Structs


@RAIIFree!UnhookWinEvent
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/WinAuto/hwineventhook
struct HWINEVENTHOOK
{
    void* Value;
}

@RAIIFree!UiaNodeRelease
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HUIANODE
{
    void* Value;
}

@RAIIFree!UiaPatternRelease
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HUIAPATTERNOBJECT
{
    void* Value;
}

@RAIIFree!UiaTextRangeRelease
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HUIATEXTRANGE
{
    void* Value;
}

@RAIIFree!UiaRemoveEvent
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HUIAEVENT
{
    void* Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/ns-oleacc-msaamenuinfo
struct MSAAMENUINFO
{
    uint  dwMSAASignature;
    uint  cchWText;
    PWSTR pszWText;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ns-uiautomationcore-uiarect
struct UiaRect
{
    double left;
    double top;
    double width;
    double height;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ns-uiautomationcore-uiapoint
struct UiaPoint
{
    double x;
    double y;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ns-uiautomationcore-uiachangeinfo
struct UiaChangeInfo
{
    int     uiaId;
    VARIANT payload;
    VARIANT extraInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ns-uiautomationcore-uiautomationparameter
struct UIAutomationParameter
{
    UIAutomationType type;
    void*            pData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ns-uiautomationcore-uiautomationpropertyinfo
struct UIAutomationPropertyInfo
{
    GUID             guid;
    const(PWSTR)     pProgrammaticName;
    UIAutomationType type;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ns-uiautomationcore-uiautomationeventinfo
struct UIAutomationEventInfo
{
    GUID         guid;
    const(PWSTR) pProgrammaticName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ns-uiautomationcore-uiautomationmethodinfo
struct UIAutomationMethodInfo
{
    const(PWSTR)      pProgrammaticName;
    BOOL              doSetFocus;
    uint              cInParameters;
    uint              cOutParameters;
    UIAutomationType* pParameterTypes;
    const(PWSTR)*     pParameterNames;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/ns-uiautomationcore-uiautomationpatterninfo
struct UIAutomationPatternInfo
{
    GUID         guid;
    const(PWSTR) pProgrammaticName;
    GUID         providerInterfaceId;
    GUID         clientInterfaceId;
    uint         cProperties;
    UIAutomationPropertyInfo* pProperties;
    uint         cMethods;
    UIAutomationMethodInfo* pMethods;
    uint         cEvents;
    UIAutomationEventInfo* pEvents;
    IUIAutomationPatternHandler pPatternHandler;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecCrypto/extendedproperty
struct ExtendedProperty
{
    BSTR PropertyName;
    BSTR PropertyValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcoreapi/ns-uiautomationcoreapi-uiacondition
struct UiaCondition
{
    ConditionType ConditionType_;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcoreapi/ns-uiautomationcoreapi-uiapropertycondition
struct UiaPropertyCondition
{
    ConditionType   ConditionType_;
    UIA_PROPERTY_ID PropertyId;
    VARIANT         Value;
    PropertyConditionFlags Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcoreapi/ns-uiautomationcoreapi-uiaandorcondition
struct UiaAndOrCondition
{
    ConditionType  ConditionType_;
    UiaCondition** ppConditions;
    int            cConditions;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcoreapi/ns-uiautomationcoreapi-uianotcondition
struct UiaNotCondition
{
    ConditionType ConditionType_;
    UiaCondition* pCondition;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcoreapi/ns-uiautomationcoreapi-uiacacherequest
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcoreapi/ns-uiautomationcoreapi-uiafindparams
struct UiaFindParams
{
    int           MaxDepth;
    BOOL          FindFirst;
    BOOL          ExcludeRoot;
    UiaCondition* pFindCondition;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcoreapi/ns-uiautomationcoreapi-uiaeventargs
struct UiaEventArgs
{
    EventArgsType Type;
    int           EventId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcoreapi/ns-uiautomationcoreapi-uiapropertychangedeventargs
struct UiaPropertyChangedEventArgs
{
    EventArgsType Type;
    UIA_EVENT_ID  EventId;
    int           PropertyId;
    VARIANT       OldValue;
    VARIANT       NewValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcoreapi/ns-uiautomationcoreapi-uiastructurechangedeventargs
struct UiaStructureChangedEventArgs
{
    EventArgsType       Type;
    int                 EventId;
    StructureChangeType StructureChangeType_;
    int*                pRuntimeId;
    int                 cRuntimeIdLen;
}

struct UiaTextEditTextChangedEventArgs
{
    EventArgsType      Type;
    int                EventId;
    TextEditChangeType TextEditChangeType_;
    SAFEARRAY*         pTextChange;
}

struct UiaChangesEventArgs
{
    EventArgsType  Type;
    int            EventId;
    int            EventIdCount;
    UiaChangeInfo* pUiaChanges;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcoreapi/ns-uiautomationcoreapi-uiaasynccontentloadedeventargs
struct UiaAsyncContentLoadedEventArgs
{
    EventArgsType Type;
    int           EventId;
    AsyncContentLoadedState AsyncContentLoadedState_;
    double        PercentComplete;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcoreapi/ns-uiautomationcoreapi-uiawindowclosedeventargs
struct UiaWindowClosedEventArgs
{
    EventArgsType Type;
    int           EventId;
    int*          pRuntimeId;
    int           cRuntimeIdLen;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-serialkeysa
struct SERIALKEYSA
{
    uint             cbSize;
    SERIALKEYS_FLAGS dwFlags;
    PSTR             lpszActivePort;
    PSTR             lpszPort;
    uint             iBaudRate;
    uint             iPortState;
    uint             iActive;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-serialkeysw
struct SERIALKEYSW
{
    uint             cbSize;
    SERIALKEYS_FLAGS dwFlags;
    PWSTR            lpszActivePort;
    PWSTR            lpszPort;
    uint             iBaudRate;
    uint             iPortState;
    uint             iActive;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-highcontrasta
struct HIGHCONTRASTA
{
    uint                cbSize;
    HIGHCONTRASTW_FLAGS dwFlags;
    PSTR                lpszDefaultScheme;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-highcontrastw
struct HIGHCONTRASTW
{
    uint                cbSize;
    HIGHCONTRASTW_FLAGS dwFlags;
    PWSTR               lpszDefaultScheme;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-filterkeys
struct FILTERKEYS
{
    uint cbSize;
    uint dwFlags;
    uint iWaitMSec;
    uint iDelayMSec;
    uint iRepeatMSec;
    uint iBounceMSec;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-stickykeys
struct STICKYKEYS
{
    uint             cbSize;
    STICKYKEYS_FLAGS dwFlags;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-mousekeys
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

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-accesstimeout
struct ACCESSTIMEOUT
{
    uint cbSize;
    uint dwFlags;
    uint iTimeOutMSec;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-soundsentrya
struct SOUNDSENTRYA
{
    uint              cbSize;
    SOUNDSENTRY_FLAGS dwFlags;
    SOUNDSENTRY_TEXT_EFFECT iFSTextEffect;
    uint              iFSTextEffectMSec;
    uint              iFSTextEffectColorBits;
    SOUND_SENTRY_GRAPHICS_EFFECT iFSGrafEffect;
    uint              iFSGrafEffectMSec;
    uint              iFSGrafEffectColor;
    SOUNDSENTRY_WINDOWS_EFFECT iWindowsEffect;
    uint              iWindowsEffectMSec;
    PSTR              lpszWindowsEffectDLL;
    uint              iWindowsEffectOrdinal;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-soundsentryw
struct SOUNDSENTRYW
{
    uint              cbSize;
    SOUNDSENTRY_FLAGS dwFlags;
    SOUNDSENTRY_TEXT_EFFECT iFSTextEffect;
    uint              iFSTextEffectMSec;
    uint              iFSTextEffectColorBits;
    SOUND_SENTRY_GRAPHICS_EFFECT iFSGrafEffect;
    uint              iFSGrafEffectMSec;
    uint              iFSGrafEffectColor;
    SOUNDSENTRY_WINDOWS_EFFECT iWindowsEffect;
    uint              iWindowsEffectMSec;
    PWSTR             lpszWindowsEffectDLL;
    uint              iWindowsEffectOrdinal;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-togglekeys
struct TOGGLEKEYS
{
    uint cbSize;
    uint dwFlags;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLEACC.dll")
LRESULT LresultFromObject(const(GUID)* riid, WPARAM wParam, IUnknown punk);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("OLEACC.dll")
HRESULT ObjectFromLresult(LRESULT lResult, const(GUID)* riid, WPARAM wParam, void** ppvObject);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLEACC.dll")
HRESULT WindowFromAccessibleObject(IAccessible param0, HWND* phwnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLEACC.dll")
HRESULT AccessibleObjectFromWindow(HWND hwnd, uint dwId, const(GUID)* riid, void** ppvObject);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLEACC.dll")
HRESULT AccessibleObjectFromEvent(HWND hwnd, uint dwId, uint dwChildId, IAccessible* ppacc, VARIANT* pvarChild);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLEACC.dll")
HRESULT AccessibleObjectFromPoint(POINT ptScreen, IAccessible* ppacc, VARIANT* pvarChild);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLEACC.dll")
HRESULT AccessibleChildren(IAccessible paccContainer, int iChildStart, int cChildren, VARIANT* rgvarChildren, 
                           int* pcObtained);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLEACC.dll")
uint GetRoleTextA(uint lRole, PSTR lpszRole, uint cchRoleMax);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLEACC.dll")
uint GetRoleTextW(uint lRole, PWSTR lpszRole, uint cchRoleMax);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLEACC.dll")
uint GetStateTextA(uint lStateBit, PSTR lpszState, uint cchState);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLEACC.dll")
uint GetStateTextW(uint lStateBit, PWSTR lpszState, uint cchState);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLEACC.dll")
void GetOleaccVersionInfo(uint* pVer, uint* pBuild);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLEACC.dll")
HRESULT CreateStdAccessibleObject(HWND hwnd, int idObject, const(GUID)* riid, void** ppvObject);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLEACC.dll")
HRESULT CreateStdAccessibleProxyA(HWND hwnd, const(PSTR) pClassName, int idObject, const(GUID)* riid, 
                                  void** ppvObject);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLEACC.dll")
HRESULT CreateStdAccessibleProxyW(HWND hwnd, const(PWSTR) pClassName, int idObject, const(GUID)* riid, 
                                  void** ppvObject);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("OLEACC.dll")
HRESULT AccSetRunningUtilityState(HWND hwndApp, uint dwUtilityStateMask, ACC_UTILITY_STATE_FLAGS dwUtilityState);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("OLEACC.dll")
HRESULT AccNotifyTouchInteraction(HWND hwndApp, HWND hwndTarget, POINT ptTarget);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
BOOL UiaGetErrorDescription(BSTR* pDescription);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaHUiaNodeFromVariant(VARIANT* pvar, HUIANODE* phnode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaHPatternObjectFromVariant(VARIANT* pvar, HUIAPATTERNOBJECT* phobj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaHTextRangeFromVariant(VARIANT* pvar, HUIATEXTRANGE* phtextrange);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
BOOL UiaNodeRelease(HUIANODE hnode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaGetPropertyValue(HUIANODE hnode, int propertyId, VARIANT* pValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaGetPatternProvider(HUIANODE hnode, int patternId, HUIAPATTERNOBJECT* phobj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaGetRuntimeId(HUIANODE hnode, SAFEARRAY** pruntimeId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaSetFocus(HUIANODE hnode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaNavigate(HUIANODE hnode, NavigateDirection direction, UiaCondition* pCondition, 
                    UiaCacheRequest* pRequest, SAFEARRAY** ppRequestedData, BSTR* ppTreeStructure);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaGetUpdatedCache(HUIANODE hnode, UiaCacheRequest* pRequest, NormalizeState normalizeState, 
                           UiaCondition* pNormalizeCondition, SAFEARRAY** ppRequestedData, BSTR* ppTreeStructure);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaFind(HUIANODE hnode, UiaFindParams* pParams, UiaCacheRequest* pRequest, SAFEARRAY** ppRequestedData, 
                SAFEARRAY** ppOffsets, SAFEARRAY** ppTreeStructures);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaNodeFromPoint(double x, double y, UiaCacheRequest* pRequest, SAFEARRAY** ppRequestedData, 
                         BSTR* ppTreeStructure);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaNodeFromFocus(UiaCacheRequest* pRequest, SAFEARRAY** ppRequestedData, BSTR* ppTreeStructure);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaNodeFromHandle(HWND hwnd, HUIANODE* phnode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaNodeFromProvider(IRawElementProviderSimple pProvider, HUIANODE* phnode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaGetRootNode(HUIANODE* phnode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
void UiaRegisterProviderCallback(UiaProviderCallback* pCallback);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
int UiaLookupId(AutomationIdentifierType type, const(GUID)* pGuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaGetReservedNotSupportedValue(IUnknown* punkNotSupportedValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaGetReservedMixedAttributeValue(IUnknown* punkMixedAttributeValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
BOOL UiaClientsAreListening();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaRaiseAutomationPropertyChangedEvent(IRawElementProviderSimple pProvider, UIA_PROPERTY_ID id, 
                                               VARIANT oldValue, VARIANT newValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaRaiseAutomationEvent(IRawElementProviderSimple pProvider, UIA_EVENT_ID id);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaRaiseStructureChangedEvent(IRawElementProviderSimple pProvider, StructureChangeType structureChangeType, 
                                      int* pRuntimeId, int cRuntimeIdLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaRaiseAsyncContentLoadedEvent(IRawElementProviderSimple pProvider, 
                                        AsyncContentLoadedState asyncContentLoadedState, double percentComplete);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaRaiseTextEditTextChangedEvent(IRawElementProviderSimple pProvider, 
                                         TextEditChangeType textEditChangeType, SAFEARRAY* pChangedData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaRaiseChangesEvent(IRawElementProviderSimple pProvider, int eventIdCount, UiaChangeInfo* pUiaChanges);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaRaiseNotificationEvent(IRawElementProviderSimple provider, NotificationKind notificationKind, 
                                  NotificationProcessing notificationProcessing, BSTR displayString, BSTR activityId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaRaiseActiveTextPositionChangedEvent(IRawElementProviderSimple provider, ITextRangeProvider textRange);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaAddEvent(HUIANODE hnode, int eventId, UiaEventCallback* pCallback, TreeScope scope_, int* pProperties, 
                    int cProperties, UiaCacheRequest* pRequest, HUIAEVENT* phEvent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaRemoveEvent(HUIAEVENT hEvent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaEventAddWindow(HUIAEVENT hEvent, HWND hwnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaEventRemoveWindow(HUIAEVENT hEvent, HWND hwnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT DockPattern_SetDockPosition(HUIAPATTERNOBJECT hobj, DockPosition dockPosition);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT ExpandCollapsePattern_Collapse(HUIAPATTERNOBJECT hobj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT ExpandCollapsePattern_Expand(HUIAPATTERNOBJECT hobj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT GridPattern_GetItem(HUIAPATTERNOBJECT hobj, int row, int column, HUIANODE* pResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT InvokePattern_Invoke(HUIAPATTERNOBJECT hobj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT MultipleViewPattern_GetViewName(HUIAPATTERNOBJECT hobj, int viewId, BSTR* ppStr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT MultipleViewPattern_SetCurrentView(HUIAPATTERNOBJECT hobj, int viewId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT RangeValuePattern_SetValue(HUIAPATTERNOBJECT hobj, double val);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT ScrollItemPattern_ScrollIntoView(HUIAPATTERNOBJECT hobj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT ScrollPattern_Scroll(HUIAPATTERNOBJECT hobj, ScrollAmount horizontalAmount, ScrollAmount verticalAmount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT ScrollPattern_SetScrollPercent(HUIAPATTERNOBJECT hobj, double horizontalPercent, double verticalPercent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT SelectionItemPattern_AddToSelection(HUIAPATTERNOBJECT hobj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT SelectionItemPattern_RemoveFromSelection(HUIAPATTERNOBJECT hobj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT SelectionItemPattern_Select(HUIAPATTERNOBJECT hobj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT TogglePattern_Toggle(HUIAPATTERNOBJECT hobj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT TransformPattern_Move(HUIAPATTERNOBJECT hobj, double x, double y);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT TransformPattern_Resize(HUIAPATTERNOBJECT hobj, double width, double height);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT TransformPattern_Rotate(HUIAPATTERNOBJECT hobj, double degrees);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT ValuePattern_SetValue(HUIAPATTERNOBJECT hobj, const(PWSTR) pVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT WindowPattern_Close(HUIAPATTERNOBJECT hobj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT WindowPattern_SetWindowVisualState(HUIAPATTERNOBJECT hobj, WindowVisualState state);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT WindowPattern_WaitForInputIdle(HUIAPATTERNOBJECT hobj, int milliseconds, BOOL* pResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT TextPattern_GetSelection(HUIAPATTERNOBJECT hobj, SAFEARRAY** pRetVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT TextPattern_GetVisibleRanges(HUIAPATTERNOBJECT hobj, SAFEARRAY** pRetVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT TextPattern_RangeFromChild(HUIAPATTERNOBJECT hobj, HUIANODE hnodeChild, HUIATEXTRANGE* pRetVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT TextPattern_RangeFromPoint(HUIAPATTERNOBJECT hobj, UiaPoint point, HUIATEXTRANGE* pRetVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT TextPattern_get_DocumentRange(HUIAPATTERNOBJECT hobj, HUIATEXTRANGE* pRetVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT TextPattern_get_SupportedTextSelection(HUIAPATTERNOBJECT hobj, SupportedTextSelection* pRetVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT TextRange_Clone(HUIATEXTRANGE hobj, HUIATEXTRANGE* pRetVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT TextRange_Compare(HUIATEXTRANGE hobj, HUIATEXTRANGE range, BOOL* pRetVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT TextRange_CompareEndpoints(HUIATEXTRANGE hobj, TextPatternRangeEndpoint endpoint, 
                                   HUIATEXTRANGE targetRange, TextPatternRangeEndpoint targetEndpoint, int* pRetVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT TextRange_ExpandToEnclosingUnit(HUIATEXTRANGE hobj, TextUnit unit);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT TextRange_GetAttributeValue(HUIATEXTRANGE hobj, int attributeId, VARIANT* pRetVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT TextRange_FindAttribute(HUIATEXTRANGE hobj, int attributeId, VARIANT val, BOOL backward, 
                                HUIATEXTRANGE* pRetVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT TextRange_FindText(HUIATEXTRANGE hobj, BSTR text, BOOL backward, BOOL ignoreCase, HUIATEXTRANGE* pRetVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT TextRange_GetBoundingRectangles(HUIATEXTRANGE hobj, SAFEARRAY** pRetVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT TextRange_GetEnclosingElement(HUIATEXTRANGE hobj, HUIANODE* pRetVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT TextRange_GetText(HUIATEXTRANGE hobj, int maxLength, BSTR* pRetVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT TextRange_Move(HUIATEXTRANGE hobj, TextUnit unit, int count, int* pRetVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT TextRange_MoveEndpointByUnit(HUIATEXTRANGE hobj, TextPatternRangeEndpoint endpoint, TextUnit unit, 
                                     int count, int* pRetVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT TextRange_MoveEndpointByRange(HUIATEXTRANGE hobj, TextPatternRangeEndpoint endpoint, 
                                      HUIATEXTRANGE targetRange, TextPatternRangeEndpoint targetEndpoint);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT TextRange_Select(HUIATEXTRANGE hobj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT TextRange_AddToSelection(HUIATEXTRANGE hobj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT TextRange_RemoveFromSelection(HUIATEXTRANGE hobj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT TextRange_ScrollIntoView(HUIATEXTRANGE hobj, BOOL alignToTop);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT TextRange_GetChildren(HUIATEXTRANGE hobj, SAFEARRAY** pRetVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("UIAutomationCore.dll")
HRESULT ItemContainerPattern_FindItemByProperty(HUIAPATTERNOBJECT hobj, HUIANODE hnodeStartAfter, int propertyId, 
                                                VARIANT value, HUIANODE* pFound);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("UIAutomationCore.dll")
HRESULT LegacyIAccessiblePattern_Select(HUIAPATTERNOBJECT hobj, int flagsSelect);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("UIAutomationCore.dll")
HRESULT LegacyIAccessiblePattern_DoDefaultAction(HUIAPATTERNOBJECT hobj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("UIAutomationCore.dll")
HRESULT LegacyIAccessiblePattern_SetValue(HUIAPATTERNOBJECT hobj, const(PWSTR) szValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("UIAutomationCore.dll")
HRESULT LegacyIAccessiblePattern_GetIAccessible(HUIAPATTERNOBJECT hobj, IAccessible* pAccessible);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("UIAutomationCore.dll")
HRESULT SynchronizedInputPattern_StartListening(HUIAPATTERNOBJECT hobj, SynchronizedInputType inputType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("UIAutomationCore.dll")
HRESULT SynchronizedInputPattern_Cancel(HUIAPATTERNOBJECT hobj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("UIAutomationCore.dll")
HRESULT VirtualizedItemPattern_Realize(HUIAPATTERNOBJECT hobj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
BOOL UiaPatternRelease(HUIAPATTERNOBJECT hobj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
BOOL UiaTextRangeRelease(HUIATEXTRANGE hobj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
LRESULT UiaReturnRawElementProvider(HWND hwnd, WPARAM wParam, LPARAM lParam, IRawElementProviderSimple el);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaHostProviderFromHwnd(HWND hwnd, IRawElementProviderSimple* ppProvider);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaProviderForNonClient(HWND hwnd, int idObject, int idChild, IRawElementProviderSimple* ppProvider);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaIAccessibleFromProvider(IRawElementProviderSimple pProvider, uint dwFlags, IAccessible* ppAccessible, 
                                   VARIANT* pvarChild);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaProviderFromIAccessible(IAccessible pAccessible, int idChild, uint dwFlags, 
                                   IRawElementProviderSimple* ppProvider);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaDisconnectAllProviders();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("UIAutomationCore.dll")
HRESULT UiaDisconnectProvider(IRawElementProviderSimple pProvider);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("UIAutomationCore.dll")
BOOL UiaHasServerSideProvider(HWND hwnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
BOOL RegisterPointerInputTarget(HWND hwnd, POINTER_INPUT_TYPE pointerType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
BOOL UnregisterPointerInputTarget(HWND hwnd, POINTER_INPUT_TYPE pointerType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("USER32.dll")
BOOL RegisterPointerInputTargetEx(HWND hwnd, POINTER_INPUT_TYPE pointerType, BOOL fObserve);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("USER32.dll")
BOOL UnregisterPointerInputTargetEx(HWND hwnd, POINTER_INPUT_TYPE pointerType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
void NotifyWinEvent(uint event, HWND hwnd, int idObject, int idChild);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
HWINEVENTHOOK SetWinEventHook(uint eventMin, uint eventMax, HMODULE hmodWinEventProc, WINEVENTPROC pfnWinEventProc, 
                              uint idProcess, uint idThread, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("USER32.dll")
BOOL IsWinEventHookInstalled(uint event);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL UnhookWinEvent(HWINEVENTHOOK hWinEventHook);


// Interfaces

@GUID("b5f8350b-0548-48b1-a6ee-88bd00b4a5e7")
struct CAccPropServices;

@GUID("6e29fabf-9977-42d1-8d0e-ca7e61ad87e6")
struct CUIAutomationRegistrar;

@GUID("c2d4f567-8a9b-4c3e-9f1a-2b5c7d8e0f3a")
struct CUIAutomationClientInfo;

@GUID("a8d4f123-7b2c-4e5f-9a1b-3c8d6e9f0a2b")
struct CUIAutomationClientInfoSource;

@GUID("ff48dba4-60ef-4201-aa87-54103eef594e")
struct CUIAutomation;

@GUID("e22ad333-b25f-460c-83d0-0581107395c9")
struct CUIAutomation8;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nn-oleacc-iaccessible
@GUID("618736e0-3c3d-11cf-810c-00aa00389b71")
interface IAccessible : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-get_accparent
    HRESULT get_accParent(IDispatch* ppdispParent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-get_accchildcount
    HRESULT get_accChildCount(int* pcountChildren);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-get_accchild
    HRESULT get_accChild(VARIANT varChild, IDispatch* ppdispChild);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-get_accname
    HRESULT get_accName(VARIANT varChild, BSTR* pszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-get_accvalue
    HRESULT get_accValue(VARIANT varChild, BSTR* pszValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-get_accdescription
    HRESULT get_accDescription(VARIANT varChild, BSTR* pszDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-get_accrole
    HRESULT get_accRole(VARIANT varChild, VARIANT* pvarRole);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-get_accstate
    HRESULT get_accState(VARIANT varChild, VARIANT* pvarState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-get_acchelp
    HRESULT get_accHelp(VARIANT varChild, BSTR* pszHelp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-get_acchelptopic
    HRESULT get_accHelpTopic(BSTR* pszHelpFile, VARIANT varChild, int* pidTopic);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-get_acckeyboardshortcut
    HRESULT get_accKeyboardShortcut(VARIANT varChild, BSTR* pszKeyboardShortcut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-get_accfocus
    HRESULT get_accFocus(VARIANT* pvarChild);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-get_accselection
    HRESULT get_accSelection(VARIANT* pvarChildren);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-get_accdefaultaction
    HRESULT get_accDefaultAction(VARIANT varChild, BSTR* pszDefaultAction);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-accselect
    HRESULT accSelect(int flagsSelect, VARIANT varChild);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-acclocation
    HRESULT accLocation(int* pxLeft, int* pyTop, int* pcxWidth, int* pcyHeight, VARIANT varChild);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-accnavigate
    HRESULT accNavigate(int navDir, VARIANT varStart, VARIANT* pvarEndUpAt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-acchittest
    HRESULT accHitTest(int xLeft, int yTop, VARIANT* pvarChild);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-accdodefaultaction
    HRESULT accDoDefaultAction(VARIANT varChild);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-put_accname
    HRESULT put_accName(VARIANT varChild, BSTR szName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessible-put_accvalue
    HRESULT put_accValue(VARIANT varChild, BSTR szValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nn-oleacc-iaccessiblehandler
@GUID("03022430-abc4-11d0-bde2-00aa001a1953")
interface IAccessibleHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessiblehandler-accessibleobjectfromid
    HRESULT AccessibleObjectFromID(int hwnd, int lObjectID, IAccessible* pIAccessible);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nn-oleacc-iaccessiblewindowlesssite
@GUID("bf3abd9c-76da-4389-9eb6-1427d25abab7")
interface IAccessibleWindowlessSite : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessiblewindowlesssite-acquireobjectidrange
    HRESULT AcquireObjectIdRange(int rangeSize, IAccessibleHandler pRangeOwner, int* pRangeBase);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessiblewindowlesssite-releaseobjectidrange
    HRESULT ReleaseObjectIdRange(int rangeBase, IAccessibleHandler pRangeOwner);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessiblewindowlesssite-queryobjectidranges
    HRESULT QueryObjectIdRanges(IAccessibleHandler pRangesOwner, SAFEARRAY** psaRanges);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccessiblewindowlesssite-getparentaccessible
    HRESULT GetParentAccessible(IAccessible* ppParent);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nn-oleacc-iaccidentity
@GUID("7852b78d-1cfd-41c1-a615-9c0c85960b5f")
interface IAccIdentity : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccidentity-getidentitystring
    HRESULT GetIdentityString(uint dwIDChild, ubyte** ppIDString, uint* pdwIDStringLen);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nn-oleacc-iaccpropserver
@GUID("76c0dbbb-15e0-4e7b-b61b-20eeea2001e0")
interface IAccPropServer : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropserver-getpropvalue
    HRESULT GetPropValue(const(ubyte)* pIDString, uint dwIDStringLen, GUID idProp, VARIANT* pvarValue, 
                         BOOL* pfHasProp);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nn-oleacc-iaccpropservices
@GUID("6e26e776-04f0-495d-80e4-3330352e3169")
interface IAccPropServices : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropservices-setpropvalue
    HRESULT SetPropValue(const(ubyte)* pIDString, uint dwIDStringLen, GUID idProp, VARIANT var);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropservices-setpropserver
    HRESULT SetPropServer(const(ubyte)* pIDString, uint dwIDStringLen, const(GUID)* paProps, int cProps, 
                          IAccPropServer pServer, AnnoScope annoScope);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropservices-clearprops
    HRESULT ClearProps(const(ubyte)* pIDString, uint dwIDStringLen, const(GUID)* paProps, int cProps);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropservices-sethwndprop
    HRESULT SetHwndProp(HWND hwnd, uint idObject, uint idChild, GUID idProp, VARIANT var);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropservices-sethwndpropstr
    HRESULT SetHwndPropStr(HWND hwnd, uint idObject, uint idChild, GUID idProp, const(PWSTR) str);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropservices-sethwndpropserver
    HRESULT SetHwndPropServer(HWND hwnd, uint idObject, uint idChild, const(GUID)* paProps, int cProps, 
                              IAccPropServer pServer, AnnoScope annoScope);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropservices-clearhwndprops
    HRESULT ClearHwndProps(HWND hwnd, uint idObject, uint idChild, const(GUID)* paProps, int cProps);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropservices-composehwndidentitystring
    HRESULT ComposeHwndIdentityString(HWND hwnd, uint idObject, uint idChild, ubyte** ppIDString, 
                                      uint* pdwIDStringLen);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropservices-decomposehwndidentitystring
    HRESULT DecomposeHwndIdentityString(const(ubyte)* pIDString, uint dwIDStringLen, HWND* phwnd, uint* pidObject, 
                                        uint* pidChild);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropservices-sethmenuprop
    HRESULT SetHmenuProp(HMENU hmenu, uint idChild, GUID idProp, VARIANT var);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropservices-sethmenupropstr
    HRESULT SetHmenuPropStr(HMENU hmenu, uint idChild, GUID idProp, const(PWSTR) str);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropservices-sethmenupropserver
    HRESULT SetHmenuPropServer(HMENU hmenu, uint idChild, const(GUID)* paProps, int cProps, IAccPropServer pServer, 
                               AnnoScope annoScope);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropservices-clearhmenuprops
    HRESULT ClearHmenuProps(HMENU hmenu, uint idChild, const(GUID)* paProps, int cProps);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropservices-composehmenuidentitystring
    HRESULT ComposeHmenuIdentityString(HMENU hmenu, uint idChild, ubyte** ppIDString, uint* pdwIDStringLen);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleacc/nf-oleacc-iaccpropservices-decomposehmenuidentitystring
    HRESULT DecomposeHmenuIdentityString(const(ubyte)* pIDString, uint dwIDStringLen, HMENU* phmenu, 
                                         uint* pidChild);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-irawelementprovidersimple
@GUID("d6dd68d1-86fd-4332-8666-9abedea2d24c")
interface IRawElementProviderSimple : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementprovidersimple-get_provideroptions
    HRESULT get_ProviderOptions(ProviderOptions* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementprovidersimple-getpatternprovider
    HRESULT GetPatternProvider(UIA_PATTERN_ID patternId, IUnknown* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementprovidersimple-getpropertyvalue
    HRESULT GetPropertyValue(UIA_PROPERTY_ID propertyId, VARIANT* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementprovidersimple-get_hostrawelementprovider
    HRESULT get_HostRawElementProvider(IRawElementProviderSimple* pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iaccessibleex
@GUID("f8b80ada-2c44-48d0-89be-5ff23c9cd875")
interface IAccessibleEx : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iaccessibleex-getobjectforchild
    HRESULT GetObjectForChild(int idChild, IAccessibleEx* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iaccessibleex-getiaccessiblepair
    HRESULT GetIAccessiblePair(IAccessible* ppAcc, int* pidChild);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iaccessibleex-getruntimeid
    HRESULT GetRuntimeId(SAFEARRAY** pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iaccessibleex-convertreturnedelement
    HRESULT ConvertReturnedElement(IRawElementProviderSimple pIn, IAccessibleEx* ppRetValOut);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-irawelementprovidersimple2
@GUID("a0a839a9-8da1-4a82-806a-8e0d44e79f56")
interface IRawElementProviderSimple2 : IRawElementProviderSimple
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementprovidersimple2-showcontextmenu
    HRESULT ShowContextMenu();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-irawelementprovidersimple3
@GUID("fcf5d820-d7ec-4613-bdf6-42a84ce7daaf")
interface IRawElementProviderSimple3 : IRawElementProviderSimple2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementprovidersimple3-getmetadatavalue
    HRESULT GetMetadataValue(int targetId, UIA_METADATA_ID metadataId, VARIANT* returnVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-irawelementproviderfragmentroot
@GUID("620ce2a5-ab8f-40a9-86cb-de3c75599b58")
interface IRawElementProviderFragmentRoot : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementproviderfragmentroot-elementproviderfrompoint
    HRESULT ElementProviderFromPoint(double x, double y, IRawElementProviderFragment* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementproviderfragmentroot-getfocus
    HRESULT GetFocus(IRawElementProviderFragment* pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-irawelementproviderfragment
@GUID("f7063da8-8359-439c-9297-bbc5299a7d87")
interface IRawElementProviderFragment : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementproviderfragment-navigate
    HRESULT Navigate(NavigateDirection direction, IRawElementProviderFragment* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementproviderfragment-getruntimeid
    HRESULT GetRuntimeId(SAFEARRAY** pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementproviderfragment-get_boundingrectangle
    HRESULT get_BoundingRectangle(UiaRect* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementproviderfragment-getembeddedfragmentroots
    HRESULT GetEmbeddedFragmentRoots(SAFEARRAY** pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementproviderfragment-setfocus
    HRESULT SetFocus();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementproviderfragment-get_fragmentroot
    HRESULT get_FragmentRoot(IRawElementProviderFragmentRoot* pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-irawelementprovideradviseevents
@GUID("a407b27b-0f6d-4427-9292-473c7bf93258")
interface IRawElementProviderAdviseEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementprovideradviseevents-adviseeventadded
    HRESULT AdviseEventAdded(UIA_EVENT_ID eventId, SAFEARRAY* propertyIDs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementprovideradviseevents-adviseeventremoved
    HRESULT AdviseEventRemoved(UIA_EVENT_ID eventId, SAFEARRAY* propertyIDs);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-irawelementproviderhwndoverride
@GUID("1d5df27c-8947-4425-b8d9-79787bb460b8")
interface IRawElementProviderHwndOverride : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementproviderhwndoverride-getoverrideproviderforhwnd
    HRESULT GetOverrideProviderForHwnd(HWND hwnd, IRawElementProviderSimple* pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iproxyproviderwineventsink
@GUID("4fd82b78-a43e-46ac-9803-0a6969c7c183")
interface IProxyProviderWinEventSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iproxyproviderwineventsink-addautomationpropertychangedevent
    HRESULT AddAutomationPropertyChangedEvent(IRawElementProviderSimple pProvider, UIA_PROPERTY_ID id, 
                                              VARIANT newValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iproxyproviderwineventsink-addautomationevent
    HRESULT AddAutomationEvent(IRawElementProviderSimple pProvider, UIA_EVENT_ID id);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iproxyproviderwineventsink-addstructurechangedevent
    HRESULT AddStructureChangedEvent(IRawElementProviderSimple pProvider, StructureChangeType structureChangeType, 
                                     SAFEARRAY* runtimeId);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iproxyproviderwineventhandler
@GUID("89592ad4-f4e0-43d5-a3b6-bad7e111b435")
interface IProxyProviderWinEventHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iproxyproviderwineventhandler-respondtowinevent
    HRESULT RespondToWinEvent(uint idWinEvent, HWND hwnd, int idObject, int idChild, 
                              IProxyProviderWinEventSink pSink);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-irawelementproviderwindowlesssite
@GUID("0a2a93cc-bfad-42ac-9b2e-0991fb0d3ea0")
interface IRawElementProviderWindowlessSite : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementproviderwindowlesssite-getadjacentfragment
    HRESULT GetAdjacentFragment(NavigateDirection direction, IRawElementProviderFragment* ppParent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementproviderwindowlesssite-getruntimeidprefix
    HRESULT GetRuntimeIdPrefix(SAFEARRAY** pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iaccessiblehostingelementproviders
@GUID("33ac331b-943e-4020-b295-db37784974a3")
interface IAccessibleHostingElementProviders : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iaccessiblehostingelementproviders-getembeddedfragmentroots
    HRESULT GetEmbeddedFragmentRoots(SAFEARRAY** pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iaccessiblehostingelementproviders-getobjectidforprovider
    HRESULT GetObjectIdForProvider(IRawElementProviderSimple pProvider, int* pidObject);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-irawelementproviderhostingaccessibles
@GUID("24be0b07-d37d-487a-98cf-a13ed465e9b3")
interface IRawElementProviderHostingAccessibles : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irawelementproviderhostingaccessibles-getembeddedaccessibles
    HRESULT GetEmbeddedAccessibles(SAFEARRAY** pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-idockprovider
@GUID("159bc72c-4ad3-485e-9637-d7052edf0146")
interface IDockProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-idockprovider-setdockposition
    HRESULT SetDockPosition(DockPosition dockPosition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-idockprovider-get_dockposition
    HRESULT get_DockPosition(DockPosition* pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iexpandcollapseprovider
@GUID("d847d3a5-cab0-4a98-8c32-ecb45c59ad24")
interface IExpandCollapseProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iexpandcollapseprovider-expand
    HRESULT Expand();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iexpandcollapseprovider-collapse
    HRESULT Collapse();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iexpandcollapseprovider-get_expandcollapsestate
    HRESULT get_ExpandCollapseState(ExpandCollapseState* pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-igridprovider
@GUID("b17d6187-0907-464b-a168-0ef17a1572b1")
interface IGridProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-igridprovider-getitem
    HRESULT GetItem(int row, int column, IRawElementProviderSimple* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-igridprovider-get_rowcount
    HRESULT get_RowCount(int* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-igridprovider-get_columncount
    HRESULT get_ColumnCount(int* pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-igriditemprovider
@GUID("d02541f1-fb81-4d64-ae32-f520f8a6dbd1")
interface IGridItemProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-igriditemprovider-get_row
    HRESULT get_Row(int* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-igriditemprovider-get_column
    HRESULT get_Column(int* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-igriditemprovider-get_rowspan
    HRESULT get_RowSpan(int* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-igriditemprovider-get_columnspan
    HRESULT get_ColumnSpan(int* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-igriditemprovider-get_containinggrid
    HRESULT get_ContainingGrid(IRawElementProviderSimple* pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iinvokeprovider
@GUID("54fcb24b-e18e-47a2-b4d3-eccbe77599a2")
interface IInvokeProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iinvokeprovider-invoke
    HRESULT Invoke();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-imultipleviewprovider
@GUID("6278cab1-b556-4a1a-b4e0-418acc523201")
interface IMultipleViewProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-imultipleviewprovider-getviewname
    HRESULT GetViewName(int viewId, BSTR* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-imultipleviewprovider-setcurrentview
    HRESULT SetCurrentView(int viewId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-imultipleviewprovider-get_currentview
    HRESULT get_CurrentView(int* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-imultipleviewprovider-getsupportedviews
    HRESULT GetSupportedViews(SAFEARRAY** pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-irangevalueprovider
@GUID("36dc7aef-33e6-4691-afe1-2be7274b3d33")
interface IRangeValueProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irangevalueprovider-setvalue
    HRESULT SetValue(double val);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irangevalueprovider-get_value
    HRESULT get_Value(double* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irangevalueprovider-get_isreadonly
    HRESULT get_IsReadOnly(BOOL* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irangevalueprovider-get_maximum
    HRESULT get_Maximum(double* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irangevalueprovider-get_minimum
    HRESULT get_Minimum(double* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irangevalueprovider-get_largechange
    HRESULT get_LargeChange(double* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-irangevalueprovider-get_smallchange
    HRESULT get_SmallChange(double* pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iscrollitemprovider
@GUID("2360c714-4bf1-4b26-ba65-9b21316127eb")
interface IScrollItemProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iscrollitemprovider-scrollintoview
    HRESULT ScrollIntoView();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iselectionprovider
@GUID("fb8b03af-3bdf-48d4-bd36-1a65793be168")
interface ISelectionProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iselectionprovider-getselection
    HRESULT GetSelection(SAFEARRAY** pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iselectionprovider-get_canselectmultiple
    HRESULT get_CanSelectMultiple(BOOL* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iselectionprovider-get_isselectionrequired
    HRESULT get_IsSelectionRequired(BOOL* pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iselectionprovider2
@GUID("14f68475-ee1c-44f6-a869-d239381f0fe7")
interface ISelectionProvider2 : ISelectionProvider
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iselectionprovider2-get_firstselecteditem
    HRESULT get_FirstSelectedItem(IRawElementProviderSimple* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iselectionprovider2-get_lastselecteditem
    HRESULT get_LastSelectedItem(IRawElementProviderSimple* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iselectionprovider2-get_currentselecteditem
    HRESULT get_CurrentSelectedItem(IRawElementProviderSimple* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iselectionprovider2-get_itemcount
    HRESULT get_ItemCount(int* retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iscrollprovider
@GUID("b38b8077-1fc3-42a5-8cae-d40c2215055a")
interface IScrollProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iscrollprovider-scroll
    HRESULT Scroll(ScrollAmount horizontalAmount, ScrollAmount verticalAmount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iscrollprovider-setscrollpercent
    HRESULT SetScrollPercent(double horizontalPercent, double verticalPercent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iscrollprovider-get_horizontalscrollpercent
    HRESULT get_HorizontalScrollPercent(double* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iscrollprovider-get_verticalscrollpercent
    HRESULT get_VerticalScrollPercent(double* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iscrollprovider-get_horizontalviewsize
    HRESULT get_HorizontalViewSize(double* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iscrollprovider-get_verticalviewsize
    HRESULT get_VerticalViewSize(double* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iscrollprovider-get_horizontallyscrollable
    HRESULT get_HorizontallyScrollable(BOOL* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iscrollprovider-get_verticallyscrollable
    HRESULT get_VerticallyScrollable(BOOL* pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iselectionitemprovider
@GUID("2acad808-b2d4-452d-a407-91ff1ad167b2")
interface ISelectionItemProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iselectionitemprovider-select
    HRESULT Select();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iselectionitemprovider-addtoselection
    HRESULT AddToSelection();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iselectionitemprovider-removefromselection
    HRESULT RemoveFromSelection();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iselectionitemprovider-get_isselected
    HRESULT get_IsSelected(BOOL* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iselectionitemprovider-get_selectioncontainer
    HRESULT get_SelectionContainer(IRawElementProviderSimple* pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-isynchronizedinputprovider
@GUID("29db1a06-02ce-4cf7-9b42-565d4fab20ee")
interface ISynchronizedInputProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-isynchronizedinputprovider-startlistening
    HRESULT StartListening(SynchronizedInputType inputType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-isynchronizedinputprovider-cancel
    HRESULT Cancel();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-itableprovider
@GUID("9c860395-97b3-490a-b52a-858cc22af166")
interface ITableProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itableprovider-getrowheaders
    HRESULT GetRowHeaders(SAFEARRAY** pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itableprovider-getcolumnheaders
    HRESULT GetColumnHeaders(SAFEARRAY** pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itableprovider-get_roworcolumnmajor
    HRESULT get_RowOrColumnMajor(RowOrColumnMajor* pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-itableitemprovider
@GUID("b9734fa6-771f-4d78-9c90-2517999349cd")
interface ITableItemProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itableitemprovider-getrowheaderitems
    HRESULT GetRowHeaderItems(SAFEARRAY** pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itableitemprovider-getcolumnheaderitems
    HRESULT GetColumnHeaderItems(SAFEARRAY** pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-itoggleprovider
@GUID("56d00bd0-c4f4-433c-a836-1a52a57e0892")
interface IToggleProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itoggleprovider-toggle
    HRESULT Toggle();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itoggleprovider-get_togglestate
    HRESULT get_ToggleState(ToggleState* pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-itransformprovider
@GUID("6829ddc4-4f91-4ffa-b86f-bd3e2987cb4c")
interface ITransformProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itransformprovider-move
    HRESULT Move(double x, double y);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itransformprovider-resize
    HRESULT Resize(double width, double height);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itransformprovider-rotate
    HRESULT Rotate(double degrees);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itransformprovider-get_canmove
    HRESULT get_CanMove(BOOL* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itransformprovider-get_canresize
    HRESULT get_CanResize(BOOL* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itransformprovider-get_canrotate
    HRESULT get_CanRotate(BOOL* pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-ivalueprovider
@GUID("c7935180-6fb3-4201-b174-7df73adbf64a")
interface IValueProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ivalueprovider-setvalue
    HRESULT SetValue(const(PWSTR) val);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ivalueprovider-get_value
    HRESULT get_Value(BSTR* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ivalueprovider-get_isreadonly
    HRESULT get_IsReadOnly(BOOL* pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iwindowprovider
@GUID("987df77b-db06-4d77-8f8a-86a9c3bb90b9")
interface IWindowProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iwindowprovider-setvisualstate
    HRESULT SetVisualState(WindowVisualState state);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iwindowprovider-close
    HRESULT Close();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iwindowprovider-waitforinputidle
    HRESULT WaitForInputIdle(int milliseconds, BOOL* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iwindowprovider-get_canmaximize
    HRESULT get_CanMaximize(BOOL* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iwindowprovider-get_canminimize
    HRESULT get_CanMinimize(BOOL* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iwindowprovider-get_ismodal
    HRESULT get_IsModal(BOOL* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iwindowprovider-get_windowvisualstate
    HRESULT get_WindowVisualState(WindowVisualState* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iwindowprovider-get_windowinteractionstate
    HRESULT get_WindowInteractionState(WindowInteractionState* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iwindowprovider-get_istopmost
    HRESULT get_IsTopmost(BOOL* pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-ilegacyiaccessibleprovider
@GUID("e44c3566-915d-4070-99c6-047bff5a08f5")
interface ILegacyIAccessibleProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ilegacyiaccessibleprovider-select
    HRESULT Select(int flagsSelect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ilegacyiaccessibleprovider-dodefaultaction
    HRESULT DoDefaultAction();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ilegacyiaccessibleprovider-setvalue
    HRESULT SetValue(const(PWSTR) szValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ilegacyiaccessibleprovider-getiaccessible
    HRESULT GetIAccessible(IAccessible* ppAccessible);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ilegacyiaccessibleprovider-get_childid
    HRESULT get_ChildId(int* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ilegacyiaccessibleprovider-get_name
    HRESULT get_Name(BSTR* pszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ilegacyiaccessibleprovider-get_value
    HRESULT get_Value(BSTR* pszValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ilegacyiaccessibleprovider-get_description
    HRESULT get_Description(BSTR* pszDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ilegacyiaccessibleprovider-get_role
    HRESULT get_Role(uint* pdwRole);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ilegacyiaccessibleprovider-get_state
    HRESULT get_State(uint* pdwState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ilegacyiaccessibleprovider-get_help
    HRESULT get_Help(BSTR* pszHelp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ilegacyiaccessibleprovider-get_keyboardshortcut
    HRESULT get_KeyboardShortcut(BSTR* pszKeyboardShortcut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ilegacyiaccessibleprovider-getselection
    HRESULT GetSelection(SAFEARRAY** pvarSelectedChildren);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ilegacyiaccessibleprovider-get_defaultaction
    HRESULT get_DefaultAction(BSTR* pszDefaultAction);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iitemcontainerprovider
@GUID("e747770b-39ce-4382-ab30-d8fb3f336f24")
interface IItemContainerProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iitemcontainerprovider-finditembyproperty
    HRESULT FindItemByProperty(IRawElementProviderSimple pStartAfter, UIA_PROPERTY_ID propertyId, VARIANT value, 
                               IRawElementProviderSimple* pFound);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-ivirtualizeditemprovider
@GUID("cb98b665-2d35-4fac-ad35-f3c60d0c0b8b")
interface IVirtualizedItemProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ivirtualizeditemprovider-realize
    HRESULT Realize();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iobjectmodelprovider
@GUID("3ad86ebd-f5ef-483d-bb18-b1042a475d64")
interface IObjectModelProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iobjectmodelprovider-getunderlyingobjectmodel
    HRESULT GetUnderlyingObjectModel(IUnknown* ppUnknown);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iannotationprovider
@GUID("f95c7e80-bd63-4601-9782-445ebff011fc")
interface IAnnotationProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iannotationprovider-get_annotationtypeid
    HRESULT get_AnnotationTypeId(UIA_ANNOTATIONTYPE* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iannotationprovider-get_annotationtypename
    HRESULT get_AnnotationTypeName(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iannotationprovider-get_author
    HRESULT get_Author(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iannotationprovider-get_datetime
    HRESULT get_DateTime(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iannotationprovider-get_target
    HRESULT get_Target(IRawElementProviderSimple* retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-istylesprovider
@GUID("19b6b649-f5d7-4a6d-bdcb-129252be588a")
interface IStylesProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-istylesprovider-get_styleid
    HRESULT get_StyleId(UIA_STYLE_ID* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-istylesprovider-get_stylename
    HRESULT get_StyleName(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-istylesprovider-get_fillcolor
    HRESULT get_FillColor(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-istylesprovider-get_fillpatternstyle
    HRESULT get_FillPatternStyle(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-istylesprovider-get_shape
    HRESULT get_Shape(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-istylesprovider-get_fillpatterncolor
    HRESULT get_FillPatternColor(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-istylesprovider-get_extendedproperties
    HRESULT get_ExtendedProperties(BSTR* retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-ispreadsheetprovider
@GUID("6f6b5d35-5525-4f80-b758-85473832ffc7")
interface ISpreadsheetProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ispreadsheetprovider-getitembyname
    HRESULT GetItemByName(const(PWSTR) name, IRawElementProviderSimple* pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-ispreadsheetitemprovider
@GUID("eaed4660-7b3d-4879-a2e6-365ce603f3d0")
interface ISpreadsheetItemProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ispreadsheetitemprovider-get_formula
    HRESULT get_Formula(BSTR* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ispreadsheetitemprovider-getannotationobjects
    HRESULT GetAnnotationObjects(SAFEARRAY** pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-ispreadsheetitemprovider-getannotationtypes
    HRESULT GetAnnotationTypes(SAFEARRAY** pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-itransformprovider2
@GUID("4758742f-7ac2-460c-bc48-09fc09308a93")
interface ITransformProvider2 : ITransformProvider
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itransformprovider2-zoom
    HRESULT Zoom(double zoom);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itransformprovider2-get_canzoom
    HRESULT get_CanZoom(BOOL* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itransformprovider2-get_zoomlevel
    HRESULT get_ZoomLevel(double* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itransformprovider2-get_zoomminimum
    HRESULT get_ZoomMinimum(double* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itransformprovider2-get_zoommaximum
    HRESULT get_ZoomMaximum(double* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itransformprovider2-zoombyunit
    HRESULT ZoomByUnit(ZoomUnit zoomUnit);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-idragprovider
@GUID("6aa7bbbb-7ff9-497d-904f-d20b897929d8")
interface IDragProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-idragprovider-get_isgrabbed
    HRESULT get_IsGrabbed(BOOL* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-idragprovider-get_dropeffect
    HRESULT get_DropEffect(BSTR* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-idragprovider-get_dropeffects
    HRESULT get_DropEffects(SAFEARRAY** pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-idragprovider-getgrabbeditems
    HRESULT GetGrabbedItems(SAFEARRAY** pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-idroptargetprovider
@GUID("bae82bfd-358a-481c-85a0-d8b4d90a5d61")
interface IDropTargetProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-idroptargetprovider-get_droptargeteffect
    HRESULT get_DropTargetEffect(BSTR* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-idroptargetprovider-get_droptargeteffects
    HRESULT get_DropTargetEffects(SAFEARRAY** pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-itextrangeprovider
@GUID("5347ad7b-c355-46f8-aff5-909033582f63")
interface ITextRangeProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-clone
    HRESULT Clone(ITextRangeProvider* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-compare
    HRESULT Compare(ITextRangeProvider range, BOOL* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-compareendpoints
    HRESULT CompareEndpoints(TextPatternRangeEndpoint endpoint, ITextRangeProvider targetRange, 
                             TextPatternRangeEndpoint targetEndpoint, int* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-expandtoenclosingunit
    HRESULT ExpandToEnclosingUnit(TextUnit unit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-findattribute
    HRESULT FindAttribute(UIA_TEXTATTRIBUTE_ID attributeId, VARIANT val, BOOL backward, 
                          ITextRangeProvider* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-findtext
    HRESULT FindText(BSTR text, BOOL backward, BOOL ignoreCase, ITextRangeProvider* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-getattributevalue
    HRESULT GetAttributeValue(UIA_TEXTATTRIBUTE_ID attributeId, VARIANT* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-getboundingrectangles
    HRESULT GetBoundingRectangles(SAFEARRAY** pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-getenclosingelement
    HRESULT GetEnclosingElement(IRawElementProviderSimple* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-gettext
    HRESULT GetText(int maxLength, BSTR* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-move
    HRESULT Move(TextUnit unit, int count, int* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-moveendpointbyunit
    HRESULT MoveEndpointByUnit(TextPatternRangeEndpoint endpoint, TextUnit unit, int count, int* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-moveendpointbyrange
    HRESULT MoveEndpointByRange(TextPatternRangeEndpoint endpoint, ITextRangeProvider targetRange, 
                                TextPatternRangeEndpoint targetEndpoint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-select
    HRESULT Select();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-addtoselection
    HRESULT AddToSelection();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-removefromselection
    HRESULT RemoveFromSelection();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-scrollintoview
    HRESULT ScrollIntoView(BOOL alignToTop);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider-getchildren
    HRESULT GetChildren(SAFEARRAY** pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-itextprovider
@GUID("3589c92c-63f3-4367-99bb-ada653b77cf2")
interface ITextProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextprovider-getselection
    HRESULT GetSelection(SAFEARRAY** pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextprovider-getvisibleranges
    HRESULT GetVisibleRanges(SAFEARRAY** pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextprovider-rangefromchild
    HRESULT RangeFromChild(IRawElementProviderSimple childElement, ITextRangeProvider* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextprovider-rangefrompoint
    HRESULT RangeFromPoint(UiaPoint point, ITextRangeProvider* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextprovider-get_documentrange
    HRESULT get_DocumentRange(ITextRangeProvider* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextprovider-get_supportedtextselection
    HRESULT get_SupportedTextSelection(SupportedTextSelection* pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-itextprovider2
@GUID("0dc5e6ed-3e16-4bf1-8f9a-a979878bc195")
interface ITextProvider2 : ITextProvider
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextprovider2-rangefromannotation
    HRESULT RangeFromAnnotation(IRawElementProviderSimple annotationElement, ITextRangeProvider* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextprovider2-getcaretrange
    HRESULT GetCaretRange(BOOL* isActive, ITextRangeProvider* pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-itexteditprovider
@GUID("ea3605b4-3a05-400e-b5f9-4e91b40f6176")
interface ITextEditProvider : ITextProvider
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itexteditprovider-getactivecomposition
    HRESULT GetActiveComposition(ITextRangeProvider* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itexteditprovider-getconversiontarget
    HRESULT GetConversionTarget(ITextRangeProvider* pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-itextrangeprovider2
@GUID("9bbce42c-1921-4f18-89ca-dba1910a0386")
interface ITextRangeProvider2 : ITextRangeProvider
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextrangeprovider2-showcontextmenu
    HRESULT ShowContextMenu();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-itextchildprovider
@GUID("4c2de2b9-c88f-4f88-a111-f1d336b7d1a9")
interface ITextChildProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextchildprovider-get_textcontainer
    HRESULT get_TextContainer(IRawElementProviderSimple* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-itextchildprovider-get_textrange
    HRESULT get_TextRange(ITextRangeProvider* pRetVal);
}

@GUID("2062a28a-8c07-4b94-8e12-7037c622aeb8")
interface ICustomNavigationProvider : IUnknown
{
    HRESULT Navigate(NavigateDirection direction, IRawElementProviderSimple* pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iuiautomationpatterninstance
@GUID("c03a7fe4-9431-409f-bed8-ae7c2299bc8d")
interface IUIAutomationPatternInstance : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iuiautomationpatterninstance-getproperty
    HRESULT GetProperty(uint index, BOOL cached, UIAutomationType type, void* pPtr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iuiautomationpatterninstance-callmethod
    HRESULT CallMethod(uint index, const(UIAutomationParameter)* pParams, uint cParams);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iuiautomationpatternhandler
@GUID("d97022f3-a947-465e-8b2a-ac4315fa54e8")
interface IUIAutomationPatternHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iuiautomationpatternhandler-createclientwrapper
    HRESULT CreateClientWrapper(IUIAutomationPatternInstance pPatternInstance, IUnknown* pClientWrapper);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iuiautomationpatternhandler-dispatch
    HRESULT Dispatch(IUnknown pTarget, uint index, const(UIAutomationParameter)* pParams, uint cParams);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nn-uiautomationcore-iuiautomationregistrar
@GUID("8609c4ec-4a1a-4d88-a357-5a66e060e1cf")
interface IUIAutomationRegistrar : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iuiautomationregistrar-registerproperty
    HRESULT RegisterProperty(const(UIAutomationPropertyInfo)* property, int* propertyId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iuiautomationregistrar-registerevent
    HRESULT RegisterEvent(const(UIAutomationEventInfo)* event, int* eventId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationcore/nf-uiautomationcore-iuiautomationregistrar-registerpattern
    HRESULT RegisterPattern(const(UIAutomationPatternInfo)* pattern, int* pPatternId, 
                            int* pPatternAvailablePropertyId, uint propertyIdCount, int* pPropertyIds, 
                            uint eventIdCount, int* pEventIds);
}

@GUID("b2e8a3f1-4c5d-4e7a-8f6b-3d2e1c9a0b8f")
interface IUIAutomationClientInfo : IUnknown
{
    HRESULT get_ProcessId(uint* processId);
    HRESULT get_ProcessName(BSTR* processName);
}

@GUID("5b8e8f2a-9c7d-4f3e-a1b2-8d6e9f4c0a1b")
interface IUIAutomationClientConnectionCallback : IUnknown
{
    HRESULT OnConnected(IUIAutomationClientInfo clientInfo);
    HRESULT OnDisconnected(IUIAutomationClientInfo clientInfo);
}

@GUID("f4b8a2e1-9c3d-4a7e-8f6b-2d5e4c1a9b8f")
interface IUIAutomationClientInfoSource : IUnknown
{
    HRESULT RegisterClientConnectionCallback(IUIAutomationClientConnectionCallback callback, ulong* handle);
    HRESULT UnregisterClientConnectionCallback(ulong handle);
    HRESULT GetConnectedClients(SAFEARRAY** clients);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationelement
@GUID("d22108aa-8ac5-49a5-837b-37bbb3d7591e")
interface IUIAutomationElement : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-setfocus
    HRESULT SetFocus();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-getruntimeid
    HRESULT GetRuntimeId(SAFEARRAY** runtimeId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-findfirst
    HRESULT FindFirst(TreeScope scope_, IUIAutomationCondition condition, IUIAutomationElement* found);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-findall
    HRESULT FindAll(TreeScope scope_, IUIAutomationCondition condition, IUIAutomationElementArray* found);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-findfirstbuildcache
    HRESULT FindFirstBuildCache(TreeScope scope_, IUIAutomationCondition condition, 
                                IUIAutomationCacheRequest cacheRequest, IUIAutomationElement* found);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-findallbuildcache
    HRESULT FindAllBuildCache(TreeScope scope_, IUIAutomationCondition condition, 
                              IUIAutomationCacheRequest cacheRequest, IUIAutomationElementArray* found);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-buildupdatedcache
    HRESULT BuildUpdatedCache(IUIAutomationCacheRequest cacheRequest, IUIAutomationElement* updatedElement);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-getcurrentpropertyvalue
    HRESULT GetCurrentPropertyValue(UIA_PROPERTY_ID propertyId, VARIANT* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-getcurrentpropertyvalueex
    HRESULT GetCurrentPropertyValueEx(UIA_PROPERTY_ID propertyId, BOOL ignoreDefaultValue, VARIANT* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-getcachedpropertyvalue
    HRESULT GetCachedPropertyValue(UIA_PROPERTY_ID propertyId, VARIANT* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-getcachedpropertyvalueex
    HRESULT GetCachedPropertyValueEx(UIA_PROPERTY_ID propertyId, BOOL ignoreDefaultValue, VARIANT* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-getcurrentpatternas
    HRESULT GetCurrentPatternAs(UIA_PATTERN_ID patternId, const(GUID)* riid, void** patternObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-getcachedpatternas
    HRESULT GetCachedPatternAs(UIA_PATTERN_ID patternId, const(GUID)* riid, void** patternObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-getcurrentpattern
    HRESULT GetCurrentPattern(UIA_PATTERN_ID patternId, IUnknown* patternObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-getcachedpattern
    HRESULT GetCachedPattern(UIA_PATTERN_ID patternId, IUnknown* patternObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-getcachedparent
    HRESULT GetCachedParent(IUIAutomationElement* parent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-getcachedchildren
    HRESULT GetCachedChildren(IUIAutomationElementArray* children);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentprocessid
    HRESULT get_CurrentProcessId(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentcontroltype
    HRESULT get_CurrentControlType(UIA_CONTROLTYPE_ID* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentlocalizedcontroltype
    HRESULT get_CurrentLocalizedControlType(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentname
    HRESULT get_CurrentName(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentacceleratorkey
    HRESULT get_CurrentAcceleratorKey(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentaccesskey
    HRESULT get_CurrentAccessKey(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currenthaskeyboardfocus
    HRESULT get_CurrentHasKeyboardFocus(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentiskeyboardfocusable
    HRESULT get_CurrentIsKeyboardFocusable(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentisenabled
    HRESULT get_CurrentIsEnabled(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentautomationid
    HRESULT get_CurrentAutomationId(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentclassname
    HRESULT get_CurrentClassName(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currenthelptext
    HRESULT get_CurrentHelpText(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentculture
    HRESULT get_CurrentCulture(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentiscontrolelement
    HRESULT get_CurrentIsControlElement(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentiscontentelement
    HRESULT get_CurrentIsContentElement(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentispassword
    HRESULT get_CurrentIsPassword(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentnativewindowhandle
    HRESULT get_CurrentNativeWindowHandle(HWND* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentitemtype
    HRESULT get_CurrentItemType(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentisoffscreen
    HRESULT get_CurrentIsOffscreen(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentorientation
    HRESULT get_CurrentOrientation(OrientationType* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentframeworkid
    HRESULT get_CurrentFrameworkId(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentisrequiredforform
    HRESULT get_CurrentIsRequiredForForm(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentitemstatus
    HRESULT get_CurrentItemStatus(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentboundingrectangle
    HRESULT get_CurrentBoundingRectangle(RECT* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentlabeledby
    HRESULT get_CurrentLabeledBy(IUIAutomationElement* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentariarole
    HRESULT get_CurrentAriaRole(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentariaproperties
    HRESULT get_CurrentAriaProperties(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentisdatavalidforform
    HRESULT get_CurrentIsDataValidForForm(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentcontrollerfor
    HRESULT get_CurrentControllerFor(IUIAutomationElementArray* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentdescribedby
    HRESULT get_CurrentDescribedBy(IUIAutomationElementArray* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentflowsto
    HRESULT get_CurrentFlowsTo(IUIAutomationElementArray* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentproviderdescription
    HRESULT get_CurrentProviderDescription(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedprocessid
    HRESULT get_CachedProcessId(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedcontroltype
    HRESULT get_CachedControlType(UIA_CONTROLTYPE_ID* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedlocalizedcontroltype
    HRESULT get_CachedLocalizedControlType(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedname
    HRESULT get_CachedName(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedacceleratorkey
    HRESULT get_CachedAcceleratorKey(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedaccesskey
    HRESULT get_CachedAccessKey(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedhaskeyboardfocus
    HRESULT get_CachedHasKeyboardFocus(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachediskeyboardfocusable
    HRESULT get_CachedIsKeyboardFocusable(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedisenabled
    HRESULT get_CachedIsEnabled(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedautomationid
    HRESULT get_CachedAutomationId(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedclassname
    HRESULT get_CachedClassName(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedhelptext
    HRESULT get_CachedHelpText(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedculture
    HRESULT get_CachedCulture(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachediscontrolelement
    HRESULT get_CachedIsControlElement(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachediscontentelement
    HRESULT get_CachedIsContentElement(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedispassword
    HRESULT get_CachedIsPassword(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachednativewindowhandle
    HRESULT get_CachedNativeWindowHandle(HWND* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cacheditemtype
    HRESULT get_CachedItemType(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedisoffscreen
    HRESULT get_CachedIsOffscreen(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedorientation
    HRESULT get_CachedOrientation(OrientationType* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedframeworkid
    HRESULT get_CachedFrameworkId(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedisrequiredforform
    HRESULT get_CachedIsRequiredForForm(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cacheditemstatus
    HRESULT get_CachedItemStatus(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedboundingrectangle
    HRESULT get_CachedBoundingRectangle(RECT* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedlabeledby
    HRESULT get_CachedLabeledBy(IUIAutomationElement* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedariarole
    HRESULT get_CachedAriaRole(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedariaproperties
    HRESULT get_CachedAriaProperties(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedisdatavalidforform
    HRESULT get_CachedIsDataValidForForm(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedcontrollerfor
    HRESULT get_CachedControllerFor(IUIAutomationElementArray* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cacheddescribedby
    HRESULT get_CachedDescribedBy(IUIAutomationElementArray* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedflowsto
    HRESULT get_CachedFlowsTo(IUIAutomationElementArray* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_cachedproviderdescription
    HRESULT get_CachedProviderDescription(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-getclickablepoint
    HRESULT GetClickablePoint(POINT* clickable, BOOL* gotClickable);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationelementarray
@GUID("14314595-b4bc-4055-95f2-58f2e42c9855")
interface IUIAutomationElementArray : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelementarray-get_length
    HRESULT get_Length(int* length);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelementarray-getelement
    HRESULT GetElement(int index, IUIAutomationElement* element);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationcondition
@GUID("352ffba8-0973-437c-a61f-f64cafd81df9")
interface IUIAutomationCondition : IUnknown
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationboolcondition
@GUID("1b4e1f2e-75eb-4d0b-8952-5a69988e2307")
interface IUIAutomationBoolCondition : IUIAutomationCondition
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationboolcondition-get_booleanvalue
    HRESULT get_BooleanValue(BOOL* boolVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationpropertycondition
@GUID("99ebf2cb-5578-4267-9ad4-afd6ea77e94b")
interface IUIAutomationPropertyCondition : IUIAutomationCondition
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationpropertycondition-get_propertyid
    HRESULT get_PropertyId(UIA_PROPERTY_ID* propertyId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationpropertycondition-get_propertyvalue
    HRESULT get_PropertyValue(VARIANT* propertyValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationpropertycondition-get_propertyconditionflags
    HRESULT get_PropertyConditionFlags(PropertyConditionFlags* flags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationandcondition
@GUID("a7d0af36-b912-45fe-9855-091ddc174aec")
interface IUIAutomationAndCondition : IUIAutomationCondition
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationandcondition-get_childcount
    HRESULT get_ChildCount(int* childCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationandcondition-getchildrenasnativearray
    HRESULT GetChildrenAsNativeArray(IUIAutomationCondition** childArray, int* childArrayCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationandcondition-getchildren
    HRESULT GetChildren(SAFEARRAY** childArray);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationorcondition
@GUID("8753f032-3db1-47b5-a1fc-6e34a266c712")
interface IUIAutomationOrCondition : IUIAutomationCondition
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationorcondition-get_childcount
    HRESULT get_ChildCount(int* childCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationorcondition-getchildrenasnativearray
    HRESULT GetChildrenAsNativeArray(IUIAutomationCondition** childArray, int* childArrayCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationorcondition-getchildren
    HRESULT GetChildren(SAFEARRAY** childArray);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationnotcondition
@GUID("f528b657-847b-498c-8896-d52b565407a1")
interface IUIAutomationNotCondition : IUIAutomationCondition
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationnotcondition-getchild
    HRESULT GetChild(IUIAutomationCondition* condition);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationcacherequest
@GUID("b32a92b5-bc25-4078-9c08-d7ee95c48e03")
interface IUIAutomationCacheRequest : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationcacherequest-addproperty
    HRESULT AddProperty(UIA_PROPERTY_ID propertyId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationcacherequest-addpattern
    HRESULT AddPattern(UIA_PATTERN_ID patternId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationcacherequest-clone
    HRESULT Clone(IUIAutomationCacheRequest* clonedRequest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationcacherequest-get_treescope
    HRESULT get_TreeScope(TreeScope* scope_);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationcacherequest-put_treescope
    HRESULT put_TreeScope(TreeScope scope_);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationcacherequest-get_treefilter
    HRESULT get_TreeFilter(IUIAutomationCondition* filter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationcacherequest-put_treefilter
    HRESULT put_TreeFilter(IUIAutomationCondition filter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationcacherequest-get_automationelementmode
    HRESULT get_AutomationElementMode(AutomationElementMode* mode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationcacherequest-put_automationelementmode
    HRESULT put_AutomationElementMode(AutomationElementMode mode);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationtreewalker
@GUID("4042c624-389c-4afc-a630-9df854a541fc")
interface IUIAutomationTreeWalker : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtreewalker-getparentelement
    HRESULT GetParentElement(IUIAutomationElement element, IUIAutomationElement* parent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtreewalker-getfirstchildelement
    HRESULT GetFirstChildElement(IUIAutomationElement element, IUIAutomationElement* first);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtreewalker-getlastchildelement
    HRESULT GetLastChildElement(IUIAutomationElement element, IUIAutomationElement* last);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtreewalker-getnextsiblingelement
    HRESULT GetNextSiblingElement(IUIAutomationElement element, IUIAutomationElement* next);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtreewalker-getprevioussiblingelement
    HRESULT GetPreviousSiblingElement(IUIAutomationElement element, IUIAutomationElement* previous);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtreewalker-normalizeelement
    HRESULT NormalizeElement(IUIAutomationElement element, IUIAutomationElement* normalized);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtreewalker-getparentelementbuildcache
    HRESULT GetParentElementBuildCache(IUIAutomationElement element, IUIAutomationCacheRequest cacheRequest, 
                                       IUIAutomationElement* parent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtreewalker-getfirstchildelementbuildcache
    HRESULT GetFirstChildElementBuildCache(IUIAutomationElement element, IUIAutomationCacheRequest cacheRequest, 
                                           IUIAutomationElement* first);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtreewalker-getlastchildelementbuildcache
    HRESULT GetLastChildElementBuildCache(IUIAutomationElement element, IUIAutomationCacheRequest cacheRequest, 
                                          IUIAutomationElement* last);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtreewalker-getnextsiblingelementbuildcache
    HRESULT GetNextSiblingElementBuildCache(IUIAutomationElement element, IUIAutomationCacheRequest cacheRequest, 
                                            IUIAutomationElement* next);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtreewalker-getprevioussiblingelementbuildcache
    HRESULT GetPreviousSiblingElementBuildCache(IUIAutomationElement element, 
                                                IUIAutomationCacheRequest cacheRequest, 
                                                IUIAutomationElement* previous);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtreewalker-normalizeelementbuildcache
    HRESULT NormalizeElementBuildCache(IUIAutomationElement element, IUIAutomationCacheRequest cacheRequest, 
                                       IUIAutomationElement* normalized);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtreewalker-get_condition
    HRESULT get_Condition(IUIAutomationCondition* condition);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationeventhandler
@GUID("146c3c17-f12e-4e22-8c27-f894b9b79c69")
interface IUIAutomationEventHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationeventhandler-handleautomationevent
    HRESULT HandleAutomationEvent(IUIAutomationElement sender, UIA_EVENT_ID eventId);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationpropertychangedeventhandler
@GUID("40cd37d4-c756-4b0c-8c6f-bddfeeb13b50")
interface IUIAutomationPropertyChangedEventHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationpropertychangedeventhandler-handlepropertychangedevent
    HRESULT HandlePropertyChangedEvent(IUIAutomationElement sender, UIA_PROPERTY_ID propertyId, VARIANT newValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationstructurechangedeventhandler
@GUID("e81d1b4e-11c5-42f8-9754-e7036c79f054")
interface IUIAutomationStructureChangedEventHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationstructurechangedeventhandler-handlestructurechangedevent
    HRESULT HandleStructureChangedEvent(IUIAutomationElement sender, StructureChangeType changeType, 
                                        SAFEARRAY* runtimeId);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationfocuschangedeventhandler
@GUID("c270f6b5-5c69-4290-9745-7a7f97169468")
interface IUIAutomationFocusChangedEventHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationfocuschangedeventhandler-handlefocuschangedevent
    HRESULT HandleFocusChangedEvent(IUIAutomationElement sender);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationtextedittextchangedeventhandler
@GUID("92faa680-e704-4156-931a-e32d5bb38f3f")
interface IUIAutomationTextEditTextChangedEventHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextedittextchangedeventhandler-handletextedittextchangedevent
    HRESULT HandleTextEditTextChangedEvent(IUIAutomationElement sender, TextEditChangeType textEditChangeType, 
                                           SAFEARRAY* eventStrings);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationchangeseventhandler
@GUID("58edca55-2c3e-4980-b1b9-56c17f27a2a0")
interface IUIAutomationChangesEventHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationchangeseventhandler-handlechangesevent
    HRESULT HandleChangesEvent(IUIAutomationElement sender, UiaChangeInfo* uiaChanges, int changesCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationnotificationeventhandler
@GUID("c7cb2637-e6c2-4d0c-85de-4948c02175c7")
interface IUIAutomationNotificationEventHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationnotificationeventhandler-handlenotificationevent
    HRESULT HandleNotificationEvent(IUIAutomationElement sender, NotificationKind notificationKind, 
                                    NotificationProcessing notificationProcessing, BSTR displayString, 
                                    BSTR activityId);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationinvokepattern
@GUID("fb377fbe-8ea6-46d5-9c73-6499642d3059")
interface IUIAutomationInvokePattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationinvokepattern-invoke
    HRESULT Invoke();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationdockpattern
@GUID("fde5ef97-1464-48f6-90bf-43d0948e86ec")
interface IUIAutomationDockPattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationdockpattern-setdockposition
    HRESULT SetDockPosition(DockPosition dockPos);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationdockpattern-get_currentdockposition
    HRESULT get_CurrentDockPosition(DockPosition* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationdockpattern-get_cacheddockposition
    HRESULT get_CachedDockPosition(DockPosition* retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationexpandcollapsepattern
@GUID("619be086-1f4e-4ee4-bafa-210128738730")
interface IUIAutomationExpandCollapsePattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationexpandcollapsepattern-expand
    HRESULT Expand();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationexpandcollapsepattern-collapse
    HRESULT Collapse();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationexpandcollapsepattern-get_currentexpandcollapsestate
    HRESULT get_CurrentExpandCollapseState(ExpandCollapseState* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationexpandcollapsepattern-get_cachedexpandcollapsestate
    HRESULT get_CachedExpandCollapseState(ExpandCollapseState* retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationgridpattern
@GUID("414c3cdc-856b-4f5b-8538-3131c6302550")
interface IUIAutomationGridPattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationgridpattern-getitem
    HRESULT GetItem(int row, int column, IUIAutomationElement* element);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationgridpattern-get_currentrowcount
    HRESULT get_CurrentRowCount(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationgridpattern-get_currentcolumncount
    HRESULT get_CurrentColumnCount(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationgridpattern-get_cachedrowcount
    HRESULT get_CachedRowCount(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationgridpattern-get_cachedcolumncount
    HRESULT get_CachedColumnCount(int* retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationgriditempattern
@GUID("78f8ef57-66c3-4e09-bd7c-e79b2004894d")
interface IUIAutomationGridItemPattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationgriditempattern-get_currentcontaininggrid
    HRESULT get_CurrentContainingGrid(IUIAutomationElement* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationgriditempattern-get_currentrow
    HRESULT get_CurrentRow(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationgriditempattern-get_currentcolumn
    HRESULT get_CurrentColumn(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationgriditempattern-get_currentrowspan
    HRESULT get_CurrentRowSpan(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationgriditempattern-get_currentcolumnspan
    HRESULT get_CurrentColumnSpan(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationgriditempattern-get_cachedcontaininggrid
    HRESULT get_CachedContainingGrid(IUIAutomationElement* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationgriditempattern-get_cachedrow
    HRESULT get_CachedRow(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationgriditempattern-get_cachedcolumn
    HRESULT get_CachedColumn(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationgriditempattern-get_cachedrowspan
    HRESULT get_CachedRowSpan(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationgriditempattern-get_cachedcolumnspan
    HRESULT get_CachedColumnSpan(int* retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationmultipleviewpattern
@GUID("8d253c91-1dc5-4bb5-b18f-ade16fa495e8")
interface IUIAutomationMultipleViewPattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationmultipleviewpattern-getviewname
    HRESULT GetViewName(int view, BSTR* name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationmultipleviewpattern-setcurrentview
    HRESULT SetCurrentView(int view);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationmultipleviewpattern-get_currentcurrentview
    HRESULT get_CurrentCurrentView(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationmultipleviewpattern-getcurrentsupportedviews
    HRESULT GetCurrentSupportedViews(SAFEARRAY** retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationmultipleviewpattern-get_cachedcurrentview
    HRESULT get_CachedCurrentView(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationmultipleviewpattern-getcachedsupportedviews
    HRESULT GetCachedSupportedViews(SAFEARRAY** retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationobjectmodelpattern
@GUID("71c284b3-c14d-4d14-981e-19751b0d756d")
interface IUIAutomationObjectModelPattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationobjectmodelpattern-getunderlyingobjectmodel
    HRESULT GetUnderlyingObjectModel(IUnknown* retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationrangevaluepattern
@GUID("59213f4f-7346-49e5-b120-80555987a148")
interface IUIAutomationRangeValuePattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-setvalue
    HRESULT SetValue(double val);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-get_currentvalue
    HRESULT get_CurrentValue(double* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-get_currentisreadonly
    HRESULT get_CurrentIsReadOnly(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-get_currentmaximum
    HRESULT get_CurrentMaximum(double* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-get_currentminimum
    HRESULT get_CurrentMinimum(double* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-get_currentlargechange
    HRESULT get_CurrentLargeChange(double* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-get_currentsmallchange
    HRESULT get_CurrentSmallChange(double* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-get_cachedvalue
    HRESULT get_CachedValue(double* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-get_cachedisreadonly
    HRESULT get_CachedIsReadOnly(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-get_cachedmaximum
    HRESULT get_CachedMaximum(double* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-get_cachedminimum
    HRESULT get_CachedMinimum(double* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-get_cachedlargechange
    HRESULT get_CachedLargeChange(double* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-get_cachedsmallchange
    HRESULT get_CachedSmallChange(double* retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationscrollpattern
@GUID("88f4d42a-e881-459d-a77c-73bbbb7e02dc")
interface IUIAutomationScrollPattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-scroll
    HRESULT Scroll(ScrollAmount horizontalAmount, ScrollAmount verticalAmount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-setscrollpercent
    HRESULT SetScrollPercent(double horizontalPercent, double verticalPercent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-get_currenthorizontalscrollpercent
    HRESULT get_CurrentHorizontalScrollPercent(double* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-get_currentverticalscrollpercent
    HRESULT get_CurrentVerticalScrollPercent(double* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-get_currenthorizontalviewsize
    HRESULT get_CurrentHorizontalViewSize(double* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-get_currentverticalviewsize
    HRESULT get_CurrentVerticalViewSize(double* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-get_currenthorizontallyscrollable
    HRESULT get_CurrentHorizontallyScrollable(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-get_currentverticallyscrollable
    HRESULT get_CurrentVerticallyScrollable(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-get_cachedhorizontalscrollpercent
    HRESULT get_CachedHorizontalScrollPercent(double* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-get_cachedverticalscrollpercent
    HRESULT get_CachedVerticalScrollPercent(double* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-get_cachedhorizontalviewsize
    HRESULT get_CachedHorizontalViewSize(double* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-get_cachedverticalviewsize
    HRESULT get_CachedVerticalViewSize(double* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-get_cachedhorizontallyscrollable
    HRESULT get_CachedHorizontallyScrollable(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-get_cachedverticallyscrollable
    HRESULT get_CachedVerticallyScrollable(BOOL* retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationscrollitempattern
@GUID("b488300f-d015-4f19-9c29-bb595e3645ef")
interface IUIAutomationScrollItemPattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollitempattern-scrollintoview
    HRESULT ScrollIntoView();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationselectionpattern
@GUID("5ed5202e-b2ac-47a6-b638-4b0bf140d78e")
interface IUIAutomationSelectionPattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern-getcurrentselection
    HRESULT GetCurrentSelection(IUIAutomationElementArray* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern-get_currentcanselectmultiple
    HRESULT get_CurrentCanSelectMultiple(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern-get_currentisselectionrequired
    HRESULT get_CurrentIsSelectionRequired(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern-getcachedselection
    HRESULT GetCachedSelection(IUIAutomationElementArray* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern-get_cachedcanselectmultiple
    HRESULT get_CachedCanSelectMultiple(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern-get_cachedisselectionrequired
    HRESULT get_CachedIsSelectionRequired(BOOL* retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationselectionpattern2
@GUID("0532bfae-c011-4e32-a343-6d642d798555")
interface IUIAutomationSelectionPattern2 : IUIAutomationSelectionPattern
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern2-get_currentfirstselecteditem
    HRESULT get_CurrentFirstSelectedItem(IUIAutomationElement* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern2-get_currentlastselecteditem
    HRESULT get_CurrentLastSelectedItem(IUIAutomationElement* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern2-get_currentcurrentselecteditem
    HRESULT get_CurrentCurrentSelectedItem(IUIAutomationElement* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern2-get_currentitemcount
    HRESULT get_CurrentItemCount(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern2-get_cachedfirstselecteditem
    HRESULT get_CachedFirstSelectedItem(IUIAutomationElement* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern2-get_cachedlastselecteditem
    HRESULT get_CachedLastSelectedItem(IUIAutomationElement* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern2-get_cachedcurrentselecteditem
    HRESULT get_CachedCurrentSelectedItem(IUIAutomationElement* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern2-get_cacheditemcount
    HRESULT get_CachedItemCount(int* retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationselectionitempattern
@GUID("a8efa66a-0fda-421a-9194-38021f3578ea")
interface IUIAutomationSelectionItemPattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionitempattern-select
    HRESULT Select();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionitempattern-addtoselection
    HRESULT AddToSelection();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionitempattern-removefromselection
    HRESULT RemoveFromSelection();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionitempattern-get_currentisselected
    HRESULT get_CurrentIsSelected(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionitempattern-get_currentselectioncontainer
    HRESULT get_CurrentSelectionContainer(IUIAutomationElement* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionitempattern-get_cachedisselected
    HRESULT get_CachedIsSelected(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionitempattern-get_cachedselectioncontainer
    HRESULT get_CachedSelectionContainer(IUIAutomationElement* retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationsynchronizedinputpattern
@GUID("2233be0b-afb7-448b-9fda-3b378aa5eae1")
interface IUIAutomationSynchronizedInputPattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationsynchronizedinputpattern-startlistening
    HRESULT StartListening(SynchronizedInputType inputType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationsynchronizedinputpattern-cancel
    HRESULT Cancel();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationtablepattern
@GUID("620e691c-ea96-4710-a850-754b24ce2417")
interface IUIAutomationTablePattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtablepattern-getcurrentrowheaders
    HRESULT GetCurrentRowHeaders(IUIAutomationElementArray* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtablepattern-getcurrentcolumnheaders
    HRESULT GetCurrentColumnHeaders(IUIAutomationElementArray* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtablepattern-get_currentroworcolumnmajor
    HRESULT get_CurrentRowOrColumnMajor(RowOrColumnMajor* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtablepattern-getcachedrowheaders
    HRESULT GetCachedRowHeaders(IUIAutomationElementArray* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtablepattern-getcachedcolumnheaders
    HRESULT GetCachedColumnHeaders(IUIAutomationElementArray* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtablepattern-get_cachedroworcolumnmajor
    HRESULT get_CachedRowOrColumnMajor(RowOrColumnMajor* retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationtableitempattern
@GUID("0b964eb3-ef2e-4464-9c79-61d61737a27e")
interface IUIAutomationTableItemPattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtableitempattern-getcurrentrowheaderitems
    HRESULT GetCurrentRowHeaderItems(IUIAutomationElementArray* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtableitempattern-getcurrentcolumnheaderitems
    HRESULT GetCurrentColumnHeaderItems(IUIAutomationElementArray* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtableitempattern-getcachedrowheaderitems
    HRESULT GetCachedRowHeaderItems(IUIAutomationElementArray* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtableitempattern-getcachedcolumnheaderitems
    HRESULT GetCachedColumnHeaderItems(IUIAutomationElementArray* retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationtogglepattern
@GUID("94cf8058-9b8d-4ab9-8bfd-4cd0a33c8c70")
interface IUIAutomationTogglePattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtogglepattern-toggle
    HRESULT Toggle();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtogglepattern-get_currenttogglestate
    HRESULT get_CurrentToggleState(ToggleState* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtogglepattern-get_cachedtogglestate
    HRESULT get_CachedToggleState(ToggleState* retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationtransformpattern
@GUID("a9b55844-a55d-4ef0-926d-569c16ff89bb")
interface IUIAutomationTransformPattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern-move
    HRESULT Move(double x, double y);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern-resize
    HRESULT Resize(double width, double height);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern-rotate
    HRESULT Rotate(double degrees);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern-get_currentcanmove
    HRESULT get_CurrentCanMove(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern-get_currentcanresize
    HRESULT get_CurrentCanResize(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern-get_currentcanrotate
    HRESULT get_CurrentCanRotate(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern-get_cachedcanmove
    HRESULT get_CachedCanMove(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern-get_cachedcanresize
    HRESULT get_CachedCanResize(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern-get_cachedcanrotate
    HRESULT get_CachedCanRotate(BOOL* retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationvaluepattern
@GUID("a94cd8b1-0844-4cd6-9d2d-640537ab39e9")
interface IUIAutomationValuePattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationvaluepattern-setvalue
    HRESULT SetValue(BSTR val);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationvaluepattern-get_currentvalue
    HRESULT get_CurrentValue(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationvaluepattern-get_currentisreadonly
    HRESULT get_CurrentIsReadOnly(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationvaluepattern-get_cachedvalue
    HRESULT get_CachedValue(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationvaluepattern-get_cachedisreadonly
    HRESULT get_CachedIsReadOnly(BOOL* retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationwindowpattern
@GUID("0faef453-9208-43ef-bbb2-3b485177864f")
interface IUIAutomationWindowPattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-close
    HRESULT Close();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-waitforinputidle
    HRESULT WaitForInputIdle(int milliseconds, BOOL* success);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-setwindowvisualstate
    HRESULT SetWindowVisualState(WindowVisualState state);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-get_currentcanmaximize
    HRESULT get_CurrentCanMaximize(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-get_currentcanminimize
    HRESULT get_CurrentCanMinimize(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-get_currentismodal
    HRESULT get_CurrentIsModal(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-get_currentistopmost
    HRESULT get_CurrentIsTopmost(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-get_currentwindowvisualstate
    HRESULT get_CurrentWindowVisualState(WindowVisualState* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-get_currentwindowinteractionstate
    HRESULT get_CurrentWindowInteractionState(WindowInteractionState* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-get_cachedcanmaximize
    HRESULT get_CachedCanMaximize(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-get_cachedcanminimize
    HRESULT get_CachedCanMinimize(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-get_cachedismodal
    HRESULT get_CachedIsModal(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-get_cachedistopmost
    HRESULT get_CachedIsTopmost(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-get_cachedwindowvisualstate
    HRESULT get_CachedWindowVisualState(WindowVisualState* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-get_cachedwindowinteractionstate
    HRESULT get_CachedWindowInteractionState(WindowInteractionState* retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationtextrange
@GUID("a543cc6a-f4ae-494b-8239-c814481187a8")
interface IUIAutomationTextRange : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-clone
    HRESULT Clone(IUIAutomationTextRange* clonedRange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-compare
    HRESULT Compare(IUIAutomationTextRange range, BOOL* areSame);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-compareendpoints
    HRESULT CompareEndpoints(TextPatternRangeEndpoint srcEndPoint, IUIAutomationTextRange range, 
                             TextPatternRangeEndpoint targetEndPoint, int* compValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-expandtoenclosingunit
    HRESULT ExpandToEnclosingUnit(TextUnit textUnit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-findattribute
    HRESULT FindAttribute(UIA_TEXTATTRIBUTE_ID attr, VARIANT val, BOOL backward, IUIAutomationTextRange* found);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-findtext
    HRESULT FindText(BSTR text, BOOL backward, BOOL ignoreCase, IUIAutomationTextRange* found);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-getattributevalue
    HRESULT GetAttributeValue(UIA_TEXTATTRIBUTE_ID attr, VARIANT* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-getboundingrectangles
    HRESULT GetBoundingRectangles(SAFEARRAY** boundingRects);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-getenclosingelement
    HRESULT GetEnclosingElement(IUIAutomationElement* enclosingElement);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-gettext
    HRESULT GetText(int maxLength, BSTR* text);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-move
    HRESULT Move(TextUnit unit, int count, int* moved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-moveendpointbyunit
    HRESULT MoveEndpointByUnit(TextPatternRangeEndpoint endpoint, TextUnit unit, int count, int* moved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-moveendpointbyrange
    HRESULT MoveEndpointByRange(TextPatternRangeEndpoint srcEndPoint, IUIAutomationTextRange range, 
                                TextPatternRangeEndpoint targetEndPoint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-select
    HRESULT Select();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-addtoselection
    HRESULT AddToSelection();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-removefromselection
    HRESULT RemoveFromSelection();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-scrollintoview
    HRESULT ScrollIntoView(BOOL alignToTop);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-getchildren
    HRESULT GetChildren(IUIAutomationElementArray* children);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationtextrange2
@GUID("bb9b40e0-5e04-46bd-9be0-4b601b9afad4")
interface IUIAutomationTextRange2 : IUIAutomationTextRange
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange2-showcontextmenu
    HRESULT ShowContextMenu();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationtextrange3
@GUID("6a315d69-5512-4c2e-85f0-53fce6dd4bc2")
interface IUIAutomationTextRange3 : IUIAutomationTextRange2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange3-getenclosingelementbuildcache
    HRESULT GetEnclosingElementBuildCache(IUIAutomationCacheRequest cacheRequest, 
                                          IUIAutomationElement* enclosingElement);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange3-getchildrenbuildcache
    HRESULT GetChildrenBuildCache(IUIAutomationCacheRequest cacheRequest, IUIAutomationElementArray* children);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange3-getattributevalues
    HRESULT GetAttributeValues(const(UIA_TEXTATTRIBUTE_ID)* attributeIds, int attributeIdCount, 
                               SAFEARRAY** attributeValues);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationtextrangearray
@GUID("ce4ae76a-e717-4c98-81ea-47371d028eb6")
interface IUIAutomationTextRangeArray : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrangearray-get_length
    HRESULT get_Length(int* length);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrangearray-getelement
    HRESULT GetElement(int index, IUIAutomationTextRange* element);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationtextpattern
@GUID("32eba289-3583-42c9-9c59-3b6d9a1e9b6a")
interface IUIAutomationTextPattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextpattern-rangefrompoint
    HRESULT RangeFromPoint(POINT pt, IUIAutomationTextRange* range);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextpattern-rangefromchild
    HRESULT RangeFromChild(IUIAutomationElement child, IUIAutomationTextRange* range);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextpattern-getselection
    HRESULT GetSelection(IUIAutomationTextRangeArray* ranges);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextpattern-getvisibleranges
    HRESULT GetVisibleRanges(IUIAutomationTextRangeArray* ranges);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextpattern-get_documentrange
    HRESULT get_DocumentRange(IUIAutomationTextRange* range);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextpattern-get_supportedtextselection
    HRESULT get_SupportedTextSelection(SupportedTextSelection* supportedTextSelection);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationtextpattern2
@GUID("506a921a-fcc9-409f-b23b-37eb74106872")
interface IUIAutomationTextPattern2 : IUIAutomationTextPattern
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextpattern2-rangefromannotation
    HRESULT RangeFromAnnotation(IUIAutomationElement annotation, IUIAutomationTextRange* range);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextpattern2-getcaretrange
    HRESULT GetCaretRange(BOOL* isActive, IUIAutomationTextRange* range);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationtexteditpattern
@GUID("17e21576-996c-4870-99d9-bff323380c06")
interface IUIAutomationTextEditPattern : IUIAutomationTextPattern
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtexteditpattern-getactivecomposition
    HRESULT GetActiveComposition(IUIAutomationTextRange* range);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtexteditpattern-getconversiontarget
    HRESULT GetConversionTarget(IUIAutomationTextRange* range);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationcustomnavigationpattern
@GUID("01ea217a-1766-47ed-a6cc-acf492854b1f")
interface IUIAutomationCustomNavigationPattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationcustomnavigationpattern-navigate
    HRESULT Navigate(NavigateDirection direction, IUIAutomationElement* pRetVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationactivetextpositionchangedeventhandler
@GUID("f97933b0-8dae-4496-8997-5ba015fe0d82")
interface IUIAutomationActiveTextPositionChangedEventHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationactivetextpositionchangedeventhandler-handleactivetextpositionchangedevent
    HRESULT HandleActiveTextPositionChangedEvent(IUIAutomationElement sender, IUIAutomationTextRange range);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationlegacyiaccessiblepattern
@GUID("828055ad-355b-4435-86d5-3b51c14a9b1b")
interface IUIAutomationLegacyIAccessiblePattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-select
    HRESULT Select(int flagsSelect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-dodefaultaction
    HRESULT DoDefaultAction();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-setvalue
    HRESULT SetValue(const(PWSTR) szValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_currentchildid
    HRESULT get_CurrentChildId(int* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_currentname
    HRESULT get_CurrentName(BSTR* pszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_currentvalue
    HRESULT get_CurrentValue(BSTR* pszValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_currentdescription
    HRESULT get_CurrentDescription(BSTR* pszDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_currentrole
    HRESULT get_CurrentRole(uint* pdwRole);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_currentstate
    HRESULT get_CurrentState(uint* pdwState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_currenthelp
    HRESULT get_CurrentHelp(BSTR* pszHelp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_currentkeyboardshortcut
    HRESULT get_CurrentKeyboardShortcut(BSTR* pszKeyboardShortcut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-getcurrentselection
    HRESULT GetCurrentSelection(IUIAutomationElementArray* pvarSelectedChildren);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_currentdefaultaction
    HRESULT get_CurrentDefaultAction(BSTR* pszDefaultAction);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_cachedchildid
    HRESULT get_CachedChildId(int* pRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_cachedname
    HRESULT get_CachedName(BSTR* pszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_cachedvalue
    HRESULT get_CachedValue(BSTR* pszValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_cacheddescription
    HRESULT get_CachedDescription(BSTR* pszDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_cachedrole
    HRESULT get_CachedRole(uint* pdwRole);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_cachedstate
    HRESULT get_CachedState(uint* pdwState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_cachedhelp
    HRESULT get_CachedHelp(BSTR* pszHelp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_cachedkeyboardshortcut
    HRESULT get_CachedKeyboardShortcut(BSTR* pszKeyboardShortcut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-getcachedselection
    HRESULT GetCachedSelection(IUIAutomationElementArray* pvarSelectedChildren);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_cacheddefaultaction
    HRESULT get_CachedDefaultAction(BSTR* pszDefaultAction);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-getiaccessible
    HRESULT GetIAccessible(IAccessible* ppAccessible);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationitemcontainerpattern
@GUID("c690fdb2-27a8-423c-812d-429773c9084e")
interface IUIAutomationItemContainerPattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationitemcontainerpattern-finditembyproperty
    HRESULT FindItemByProperty(IUIAutomationElement pStartAfter, UIA_PROPERTY_ID propertyId, VARIANT value, 
                               IUIAutomationElement* pFound);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationvirtualizeditempattern
@GUID("6ba3d7a6-04cf-4f11-8793-a8d1cde9969f")
interface IUIAutomationVirtualizedItemPattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationvirtualizeditempattern-realize
    HRESULT Realize();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationannotationpattern
@GUID("9a175b21-339e-41b1-8e8b-623f6b681098")
interface IUIAutomationAnnotationPattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationannotationpattern-get_currentannotationtypeid
    HRESULT get_CurrentAnnotationTypeId(UIA_ANNOTATIONTYPE* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationannotationpattern-get_currentannotationtypename
    HRESULT get_CurrentAnnotationTypeName(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationannotationpattern-get_currentauthor
    HRESULT get_CurrentAuthor(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationannotationpattern-get_currentdatetime
    HRESULT get_CurrentDateTime(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationannotationpattern-get_currenttarget
    HRESULT get_CurrentTarget(IUIAutomationElement* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationannotationpattern-get_cachedannotationtypeid
    HRESULT get_CachedAnnotationTypeId(UIA_ANNOTATIONTYPE* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationannotationpattern-get_cachedannotationtypename
    HRESULT get_CachedAnnotationTypeName(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationannotationpattern-get_cachedauthor
    HRESULT get_CachedAuthor(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationannotationpattern-get_cacheddatetime
    HRESULT get_CachedDateTime(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationannotationpattern-get_cachedtarget
    HRESULT get_CachedTarget(IUIAutomationElement* retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationstylespattern
@GUID("85b5f0a2-bd79-484a-ad2b-388c9838d5fb")
interface IUIAutomationStylesPattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationstylespattern-get_currentstyleid
    HRESULT get_CurrentStyleId(UIA_STYLE_ID* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationstylespattern-get_currentstylename
    HRESULT get_CurrentStyleName(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationstylespattern-get_currentfillcolor
    HRESULT get_CurrentFillColor(int* retVal);
    HRESULT get_CurrentFillPatternStyle(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationstylespattern-get_currentshape
    HRESULT get_CurrentShape(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationstylespattern-get_currentfillpatterncolor
    HRESULT get_CurrentFillPatternColor(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationstylespattern-get_currentextendedproperties
    HRESULT get_CurrentExtendedProperties(BSTR* retVal);
    HRESULT GetCurrentExtendedPropertiesAsArray(ExtendedProperty** propertyArray, int* propertyCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationstylespattern-get_cachedstyleid
    HRESULT get_CachedStyleId(UIA_STYLE_ID* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationstylespattern-get_cachedstylename
    HRESULT get_CachedStyleName(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationstylespattern-get_cachedfillcolor
    HRESULT get_CachedFillColor(int* retVal);
    HRESULT get_CachedFillPatternStyle(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationstylespattern-get_cachedshape
    HRESULT get_CachedShape(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationstylespattern-get_cachedfillpatterncolor
    HRESULT get_CachedFillPatternColor(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationstylespattern-get_cachedextendedproperties
    HRESULT get_CachedExtendedProperties(BSTR* retVal);
    HRESULT GetCachedExtendedPropertiesAsArray(ExtendedProperty** propertyArray, int* propertyCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationspreadsheetpattern
@GUID("7517a7c8-faae-4de9-9f08-29b91e8595c1")
interface IUIAutomationSpreadsheetPattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationspreadsheetpattern-getitembyname
    HRESULT GetItemByName(BSTR name, IUIAutomationElement* element);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationspreadsheetitempattern
@GUID("7d4fb86c-8d34-40e1-8e83-62c15204e335")
interface IUIAutomationSpreadsheetItemPattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationspreadsheetitempattern-get_currentformula
    HRESULT get_CurrentFormula(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationspreadsheetitempattern-getcurrentannotationobjects
    HRESULT GetCurrentAnnotationObjects(IUIAutomationElementArray* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationspreadsheetitempattern-getcurrentannotationtypes
    HRESULT GetCurrentAnnotationTypes(SAFEARRAY** retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationspreadsheetitempattern-get_cachedformula
    HRESULT get_CachedFormula(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationspreadsheetitempattern-getcachedannotationobjects
    HRESULT GetCachedAnnotationObjects(IUIAutomationElementArray* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationspreadsheetitempattern-getcachedannotationtypes
    HRESULT GetCachedAnnotationTypes(SAFEARRAY** retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationtransformpattern2
@GUID("6d74d017-6ecb-4381-b38b-3c17a48ff1c2")
interface IUIAutomationTransformPattern2 : IUIAutomationTransformPattern
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern2-zoom
    HRESULT Zoom(double zoomValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern2-zoombyunit
    HRESULT ZoomByUnit(ZoomUnit zoomUnit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern2-get_currentcanzoom
    HRESULT get_CurrentCanZoom(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern2-get_cachedcanzoom
    HRESULT get_CachedCanZoom(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern2-get_currentzoomlevel
    HRESULT get_CurrentZoomLevel(double* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern2-get_cachedzoomlevel
    HRESULT get_CachedZoomLevel(double* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern2-get_currentzoomminimum
    HRESULT get_CurrentZoomMinimum(double* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern2-get_cachedzoomminimum
    HRESULT get_CachedZoomMinimum(double* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern2-get_currentzoommaximum
    HRESULT get_CurrentZoomMaximum(double* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern2-get_cachedzoommaximum
    HRESULT get_CachedZoomMaximum(double* retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationtextchildpattern
@GUID("6552b038-ae05-40c8-abfd-aa08352aab86")
interface IUIAutomationTextChildPattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextchildpattern-get_textcontainer
    HRESULT get_TextContainer(IUIAutomationElement* container);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextchildpattern-get_textrange
    HRESULT get_TextRange(IUIAutomationTextRange* range);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationdragpattern
@GUID("1dc7b570-1f54-4bad-bcda-d36a722fb7bd")
interface IUIAutomationDragPattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationdragpattern-get_currentisgrabbed
    HRESULT get_CurrentIsGrabbed(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationdragpattern-get_cachedisgrabbed
    HRESULT get_CachedIsGrabbed(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationdragpattern-get_currentdropeffect
    HRESULT get_CurrentDropEffect(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationdragpattern-get_cacheddropeffect
    HRESULT get_CachedDropEffect(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationdragpattern-get_currentdropeffects
    HRESULT get_CurrentDropEffects(SAFEARRAY** retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationdragpattern-get_cacheddropeffects
    HRESULT get_CachedDropEffects(SAFEARRAY** retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationdragpattern-getcurrentgrabbeditems
    HRESULT GetCurrentGrabbedItems(IUIAutomationElementArray* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationdragpattern-getcachedgrabbeditems
    HRESULT GetCachedGrabbedItems(IUIAutomationElementArray* retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationdroptargetpattern
@GUID("69a095f7-eee4-430e-a46b-fb73b1ae39a5")
interface IUIAutomationDropTargetPattern : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationdroptargetpattern-get_currentdroptargeteffect
    HRESULT get_CurrentDropTargetEffect(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationdroptargetpattern-get_cacheddroptargeteffect
    HRESULT get_CachedDropTargetEffect(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationdroptargetpattern-get_currentdroptargeteffects
    HRESULT get_CurrentDropTargetEffects(SAFEARRAY** retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationdroptargetpattern-get_cacheddroptargeteffects
    HRESULT get_CachedDropTargetEffects(SAFEARRAY** retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationelement2
@GUID("6749c683-f70d-4487-a698-5f79d55290d6")
interface IUIAutomationElement2 : IUIAutomationElement
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement2-get_currentoptimizeforvisualcontent
    HRESULT get_CurrentOptimizeForVisualContent(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement2-get_cachedoptimizeforvisualcontent
    HRESULT get_CachedOptimizeForVisualContent(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement2-get_currentlivesetting
    HRESULT get_CurrentLiveSetting(LiveSetting* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement2-get_cachedlivesetting
    HRESULT get_CachedLiveSetting(LiveSetting* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement2-get_currentflowsfrom
    HRESULT get_CurrentFlowsFrom(IUIAutomationElementArray* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement2-get_cachedflowsfrom
    HRESULT get_CachedFlowsFrom(IUIAutomationElementArray* retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationelement3
@GUID("8471df34-aee0-4a01-a7de-7db9af12c296")
interface IUIAutomationElement3 : IUIAutomationElement2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement3-showcontextmenu
    HRESULT ShowContextMenu();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement3-get_currentisperipheral
    HRESULT get_CurrentIsPeripheral(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement3-get_cachedisperipheral
    HRESULT get_CachedIsPeripheral(BOOL* retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationelement4
@GUID("3b6e233c-52fb-4063-a4c9-77c075c2a06b")
interface IUIAutomationElement4 : IUIAutomationElement3
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement4-get_currentpositioninset
    HRESULT get_CurrentPositionInSet(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement4-get_currentsizeofset
    HRESULT get_CurrentSizeOfSet(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement4-get_currentlevel
    HRESULT get_CurrentLevel(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement4-get_currentannotationtypes
    HRESULT get_CurrentAnnotationTypes(SAFEARRAY** retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement4-get_currentannotationobjects
    HRESULT get_CurrentAnnotationObjects(IUIAutomationElementArray* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement4-get_cachedpositioninset
    HRESULT get_CachedPositionInSet(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement4-get_cachedsizeofset
    HRESULT get_CachedSizeOfSet(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement4-get_cachedlevel
    HRESULT get_CachedLevel(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement4-get_cachedannotationtypes
    HRESULT get_CachedAnnotationTypes(SAFEARRAY** retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement4-get_cachedannotationobjects
    HRESULT get_CachedAnnotationObjects(IUIAutomationElementArray* retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationelement5
@GUID("98141c1d-0d0e-4175-bbe2-6bff455842a7")
interface IUIAutomationElement5 : IUIAutomationElement4
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement5-get_currentlandmarktype
    HRESULT get_CurrentLandmarkType(UIA_LANDMARKTYPE_ID* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement5-get_currentlocalizedlandmarktype
    HRESULT get_CurrentLocalizedLandmarkType(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement5-get_cachedlandmarktype
    HRESULT get_CachedLandmarkType(UIA_LANDMARKTYPE_ID* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement5-get_cachedlocalizedlandmarktype
    HRESULT get_CachedLocalizedLandmarkType(BSTR* retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationelement6
@GUID("4780d450-8bca-4977-afa5-a4a517f555e3")
interface IUIAutomationElement6 : IUIAutomationElement5
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement6-get_currentfulldescription
    HRESULT get_CurrentFullDescription(BSTR* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement6-get_cachedfulldescription
    HRESULT get_CachedFullDescription(BSTR* retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationelement7
@GUID("204e8572-cfc3-4c11-b0c8-7da7420750b7")
interface IUIAutomationElement7 : IUIAutomationElement6
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement7-findfirstwithoptions
    HRESULT FindFirstWithOptions(TreeScope scope_, IUIAutomationCondition condition, 
                                 TreeTraversalOptions traversalOptions, IUIAutomationElement root, 
                                 IUIAutomationElement* found);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement7-findallwithoptions
    HRESULT FindAllWithOptions(TreeScope scope_, IUIAutomationCondition condition, 
                               TreeTraversalOptions traversalOptions, IUIAutomationElement root, 
                               IUIAutomationElementArray* found);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement7-findfirstwithoptionsbuildcache
    HRESULT FindFirstWithOptionsBuildCache(TreeScope scope_, IUIAutomationCondition condition, 
                                           IUIAutomationCacheRequest cacheRequest, 
                                           TreeTraversalOptions traversalOptions, IUIAutomationElement root, 
                                           IUIAutomationElement* found);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement7-findallwithoptionsbuildcache
    HRESULT FindAllWithOptionsBuildCache(TreeScope scope_, IUIAutomationCondition condition, 
                                         IUIAutomationCacheRequest cacheRequest, 
                                         TreeTraversalOptions traversalOptions, IUIAutomationElement root, 
                                         IUIAutomationElementArray* found);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement7-getcurrentmetadatavalue
    HRESULT GetCurrentMetadataValue(int targetId, UIA_METADATA_ID metadataId, VARIANT* returnVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationelement8
@GUID("8c60217d-5411-4cde-bcc0-1ceda223830c")
interface IUIAutomationElement8 : IUIAutomationElement7
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement8-get_currentheadinglevel
    HRESULT get_CurrentHeadingLevel(UIA_HEADINGLEVEL_ID* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement8-get_cachedheadinglevel
    HRESULT get_CachedHeadingLevel(UIA_HEADINGLEVEL_ID* retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationelement9
@GUID("39325fac-039d-440e-a3a3-5eb81a5cecc3")
interface IUIAutomationElement9 : IUIAutomationElement8
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement9-get_currentisdialog
    HRESULT get_CurrentIsDialog(BOOL* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement9-get_cachedisdialog
    HRESULT get_CachedIsDialog(BOOL* retVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationproxyfactory
@GUID("85b94ecd-849d-42b6-b94d-d6db23fdf5a4")
interface IUIAutomationProxyFactory : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactory-createprovider
    HRESULT CreateProvider(HWND hwnd, int idObject, int idChild, IRawElementProviderSimple* provider);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactory-get_proxyfactoryid
    HRESULT get_ProxyFactoryId(BSTR* factoryId);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationproxyfactoryentry
@GUID("d50e472e-b64b-490c-bca1-d30696f9f289")
interface IUIAutomationProxyFactoryEntry : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactoryentry-get_proxyfactory
    HRESULT get_ProxyFactory(IUIAutomationProxyFactory* factory);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactoryentry-get_classname
    HRESULT get_ClassName(BSTR* className);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactoryentry-get_imagename
    HRESULT get_ImageName(BSTR* imageName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactoryentry-get_allowsubstringmatch
    HRESULT get_AllowSubstringMatch(BOOL* allowSubstringMatch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactoryentry-get_cancheckbaseclass
    HRESULT get_CanCheckBaseClass(BOOL* canCheckBaseClass);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactoryentry-get_needsadviseevents
    HRESULT get_NeedsAdviseEvents(BOOL* adviseEvents);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactoryentry-put_classname
    HRESULT put_ClassName(const(PWSTR) className);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactoryentry-put_imagename
    HRESULT put_ImageName(const(PWSTR) imageName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactoryentry-put_allowsubstringmatch
    HRESULT put_AllowSubstringMatch(BOOL allowSubstringMatch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactoryentry-put_cancheckbaseclass
    HRESULT put_CanCheckBaseClass(BOOL canCheckBaseClass);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactoryentry-put_needsadviseevents
    HRESULT put_NeedsAdviseEvents(BOOL adviseEvents);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactoryentry-setwineventsforautomationevent
    HRESULT SetWinEventsForAutomationEvent(UIA_EVENT_ID eventId, UIA_PROPERTY_ID propertyId, SAFEARRAY* winEvents);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactoryentry-getwineventsforautomationevent
    HRESULT GetWinEventsForAutomationEvent(UIA_EVENT_ID eventId, UIA_PROPERTY_ID propertyId, SAFEARRAY** winEvents);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationproxyfactorymapping
@GUID("09e31e18-872d-4873-93d1-1e541ec133fd")
interface IUIAutomationProxyFactoryMapping : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactorymapping-get_count
    HRESULT get_Count(uint* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactorymapping-gettable
    HRESULT GetTable(SAFEARRAY** table);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactorymapping-getentry
    HRESULT GetEntry(uint index, IUIAutomationProxyFactoryEntry* entry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactorymapping-settable
    HRESULT SetTable(SAFEARRAY* factoryList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactorymapping-insertentries
    HRESULT InsertEntries(uint before, SAFEARRAY* factoryList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactorymapping-insertentry
    HRESULT InsertEntry(uint before, IUIAutomationProxyFactoryEntry factory);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactorymapping-removeentry
    HRESULT RemoveEntry(uint index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactorymapping-cleartable
    HRESULT ClearTable();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationproxyfactorymapping-restoredefaulttable
    HRESULT RestoreDefaultTable();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomationeventhandlergroup
@GUID("c9ee12f2-c13b-4408-997c-639914377f4e")
interface IUIAutomationEventHandlerGroup : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationeventhandlergroup-addactivetextpositionchangedeventhandler
    HRESULT AddActiveTextPositionChangedEventHandler(TreeScope scope_, IUIAutomationCacheRequest cacheRequest, 
                                                     IUIAutomationActiveTextPositionChangedEventHandler handler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationeventhandlergroup-addautomationeventhandler
    HRESULT AddAutomationEventHandler(UIA_EVENT_ID eventId, TreeScope scope_, 
                                      IUIAutomationCacheRequest cacheRequest, IUIAutomationEventHandler handler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationeventhandlergroup-addchangeseventhandler
    HRESULT AddChangesEventHandler(TreeScope scope_, int* changeTypes, int changesCount, 
                                   IUIAutomationCacheRequest cacheRequest, IUIAutomationChangesEventHandler handler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationeventhandlergroup-addnotificationeventhandler
    HRESULT AddNotificationEventHandler(TreeScope scope_, IUIAutomationCacheRequest cacheRequest, 
                                        IUIAutomationNotificationEventHandler handler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationeventhandlergroup-addpropertychangedeventhandler
    HRESULT AddPropertyChangedEventHandler(TreeScope scope_, IUIAutomationCacheRequest cacheRequest, 
                                           IUIAutomationPropertyChangedEventHandler handler, 
                                           UIA_PROPERTY_ID* propertyArray, int propertyCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationeventhandlergroup-addstructurechangedeventhandler
    HRESULT AddStructureChangedEventHandler(TreeScope scope_, IUIAutomationCacheRequest cacheRequest, 
                                            IUIAutomationStructureChangedEventHandler handler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomationeventhandlergroup-addtextedittextchangedeventhandler
    HRESULT AddTextEditTextChangedEventHandler(TreeScope scope_, TextEditChangeType textEditChangeType, 
                                               IUIAutomationCacheRequest cacheRequest, 
                                               IUIAutomationTextEditTextChangedEventHandler handler);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomation
@GUID("30cbe57d-d9d0-452a-ab13-7ac5ac4825ee")
interface IUIAutomation : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-compareelements
    HRESULT CompareElements(IUIAutomationElement el1, IUIAutomationElement el2, BOOL* areSame);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-compareruntimeids
    HRESULT CompareRuntimeIds(SAFEARRAY* runtimeId1, SAFEARRAY* runtimeId2, BOOL* areSame);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-getrootelement
    HRESULT GetRootElement(IUIAutomationElement* root);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-elementfromhandle
    HRESULT ElementFromHandle(HWND hwnd, IUIAutomationElement* element);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-elementfrompoint
    HRESULT ElementFromPoint(POINT pt, IUIAutomationElement* element);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-getfocusedelement
    HRESULT GetFocusedElement(IUIAutomationElement* element);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-getrootelementbuildcache
    HRESULT GetRootElementBuildCache(IUIAutomationCacheRequest cacheRequest, IUIAutomationElement* root);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-elementfromhandlebuildcache
    HRESULT ElementFromHandleBuildCache(HWND hwnd, IUIAutomationCacheRequest cacheRequest, 
                                        IUIAutomationElement* element);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-elementfrompointbuildcache
    HRESULT ElementFromPointBuildCache(POINT pt, IUIAutomationCacheRequest cacheRequest, 
                                       IUIAutomationElement* element);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-getfocusedelementbuildcache
    HRESULT GetFocusedElementBuildCache(IUIAutomationCacheRequest cacheRequest, IUIAutomationElement* element);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createtreewalker
    HRESULT CreateTreeWalker(IUIAutomationCondition pCondition, IUIAutomationTreeWalker* walker);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-get_controlviewwalker
    HRESULT get_ControlViewWalker(IUIAutomationTreeWalker* walker);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-get_contentviewwalker
    HRESULT get_ContentViewWalker(IUIAutomationTreeWalker* walker);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-get_rawviewwalker
    HRESULT get_RawViewWalker(IUIAutomationTreeWalker* walker);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-get_rawviewcondition
    HRESULT get_RawViewCondition(IUIAutomationCondition* condition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-get_controlviewcondition
    HRESULT get_ControlViewCondition(IUIAutomationCondition* condition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-get_contentviewcondition
    HRESULT get_ContentViewCondition(IUIAutomationCondition* condition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createcacherequest
    HRESULT CreateCacheRequest(IUIAutomationCacheRequest* cacheRequest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createtruecondition
    HRESULT CreateTrueCondition(IUIAutomationCondition* newCondition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createfalsecondition
    HRESULT CreateFalseCondition(IUIAutomationCondition* newCondition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createpropertycondition
    HRESULT CreatePropertyCondition(UIA_PROPERTY_ID propertyId, VARIANT value, 
                                    IUIAutomationCondition* newCondition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createpropertyconditionex
    HRESULT CreatePropertyConditionEx(UIA_PROPERTY_ID propertyId, VARIANT value, PropertyConditionFlags flags, 
                                      IUIAutomationCondition* newCondition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createandcondition
    HRESULT CreateAndCondition(IUIAutomationCondition condition1, IUIAutomationCondition condition2, 
                               IUIAutomationCondition* newCondition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createandconditionfromarray
    HRESULT CreateAndConditionFromArray(SAFEARRAY* conditions, IUIAutomationCondition* newCondition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createandconditionfromnativearray
    HRESULT CreateAndConditionFromNativeArray(IUIAutomationCondition* conditions, int conditionCount, 
                                              IUIAutomationCondition* newCondition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createorcondition
    HRESULT CreateOrCondition(IUIAutomationCondition condition1, IUIAutomationCondition condition2, 
                              IUIAutomationCondition* newCondition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createorconditionfromarray
    HRESULT CreateOrConditionFromArray(SAFEARRAY* conditions, IUIAutomationCondition* newCondition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createorconditionfromnativearray
    HRESULT CreateOrConditionFromNativeArray(IUIAutomationCondition* conditions, int conditionCount, 
                                             IUIAutomationCondition* newCondition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createnotcondition
    HRESULT CreateNotCondition(IUIAutomationCondition condition, IUIAutomationCondition* newCondition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-addautomationeventhandler
    HRESULT AddAutomationEventHandler(UIA_EVENT_ID eventId, IUIAutomationElement element, TreeScope scope_, 
                                      IUIAutomationCacheRequest cacheRequest, IUIAutomationEventHandler handler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-removeautomationeventhandler
    HRESULT RemoveAutomationEventHandler(UIA_EVENT_ID eventId, IUIAutomationElement element, 
                                         IUIAutomationEventHandler handler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-addpropertychangedeventhandlernativearray
    HRESULT AddPropertyChangedEventHandlerNativeArray(IUIAutomationElement element, TreeScope scope_, 
                                                      IUIAutomationCacheRequest cacheRequest, 
                                                      IUIAutomationPropertyChangedEventHandler handler, 
                                                      UIA_PROPERTY_ID* propertyArray, int propertyCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-addpropertychangedeventhandler
    HRESULT AddPropertyChangedEventHandler(IUIAutomationElement element, TreeScope scope_, 
                                           IUIAutomationCacheRequest cacheRequest, 
                                           IUIAutomationPropertyChangedEventHandler handler, 
                                           SAFEARRAY* propertyArray);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-removepropertychangedeventhandler
    HRESULT RemovePropertyChangedEventHandler(IUIAutomationElement element, 
                                              IUIAutomationPropertyChangedEventHandler handler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-addstructurechangedeventhandler
    HRESULT AddStructureChangedEventHandler(IUIAutomationElement element, TreeScope scope_, 
                                            IUIAutomationCacheRequest cacheRequest, 
                                            IUIAutomationStructureChangedEventHandler handler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-removestructurechangedeventhandler
    HRESULT RemoveStructureChangedEventHandler(IUIAutomationElement element, 
                                               IUIAutomationStructureChangedEventHandler handler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-addfocuschangedeventhandler
    HRESULT AddFocusChangedEventHandler(IUIAutomationCacheRequest cacheRequest, 
                                        IUIAutomationFocusChangedEventHandler handler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-removefocuschangedeventhandler
    HRESULT RemoveFocusChangedEventHandler(IUIAutomationFocusChangedEventHandler handler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-removealleventhandlers
    HRESULT RemoveAllEventHandlers();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-intnativearraytosafearray
    HRESULT IntNativeArrayToSafeArray(int* array, int arrayCount, SAFEARRAY** safeArray);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-intsafearraytonativearray
    HRESULT IntSafeArrayToNativeArray(SAFEARRAY* intArray, int** array, int* arrayCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-recttovariant
    HRESULT RectToVariant(RECT rc, VARIANT* var);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-varianttorect
    HRESULT VariantToRect(VARIANT var, RECT* rc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-safearraytorectnativearray
    HRESULT SafeArrayToRectNativeArray(SAFEARRAY* rects, RECT** rectArray, int* rectArrayCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createproxyfactoryentry
    HRESULT CreateProxyFactoryEntry(IUIAutomationProxyFactory factory, 
                                    IUIAutomationProxyFactoryEntry* factoryEntry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-get_proxyfactorymapping
    HRESULT get_ProxyFactoryMapping(IUIAutomationProxyFactoryMapping* factoryMapping);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-getpropertyprogrammaticname
    HRESULT GetPropertyProgrammaticName(UIA_PROPERTY_ID property, BSTR* name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-getpatternprogrammaticname
    HRESULT GetPatternProgrammaticName(UIA_PATTERN_ID pattern, BSTR* name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-pollforpotentialsupportedpatterns
    HRESULT PollForPotentialSupportedPatterns(IUIAutomationElement pElement, SAFEARRAY** patternIds, 
                                              SAFEARRAY** patternNames);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-pollforpotentialsupportedproperties
    HRESULT PollForPotentialSupportedProperties(IUIAutomationElement pElement, SAFEARRAY** propertyIds, 
                                                SAFEARRAY** propertyNames);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-checknotsupported
    HRESULT CheckNotSupported(VARIANT value, BOOL* isNotSupported);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-get_reservednotsupportedvalue
    HRESULT get_ReservedNotSupportedValue(IUnknown* notSupportedValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-get_reservedmixedattributevalue
    HRESULT get_ReservedMixedAttributeValue(IUnknown* mixedAttributeValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-elementfromiaccessible
    HRESULT ElementFromIAccessible(IAccessible accessible, int childId, IUIAutomationElement* element);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation-elementfromiaccessiblebuildcache
    HRESULT ElementFromIAccessibleBuildCache(IAccessible accessible, int childId, 
                                             IUIAutomationCacheRequest cacheRequest, IUIAutomationElement* element);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomation2
@GUID("34723aff-0c9d-49d0-9896-7ab52df8cd8a")
interface IUIAutomation2 : IUIAutomation
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation2-get_autosetfocus
    HRESULT get_AutoSetFocus(BOOL* autoSetFocus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation2-put_autosetfocus
    HRESULT put_AutoSetFocus(BOOL autoSetFocus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation2-get_connectiontimeout
    HRESULT get_ConnectionTimeout(uint* timeout);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation2-put_connectiontimeout
    HRESULT put_ConnectionTimeout(uint timeout);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation2-get_transactiontimeout
    HRESULT get_TransactionTimeout(uint* timeout);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation2-put_transactiontimeout
    HRESULT put_TransactionTimeout(uint timeout);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomation3
@GUID("73d768da-9b51-4b89-936e-c209290973e7")
interface IUIAutomation3 : IUIAutomation2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation3-addtextedittextchangedeventhandler
    HRESULT AddTextEditTextChangedEventHandler(IUIAutomationElement element, TreeScope scope_, 
                                               TextEditChangeType textEditChangeType, 
                                               IUIAutomationCacheRequest cacheRequest, 
                                               IUIAutomationTextEditTextChangedEventHandler handler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation3-removetextedittextchangedeventhandler
    HRESULT RemoveTextEditTextChangedEventHandler(IUIAutomationElement element, 
                                                  IUIAutomationTextEditTextChangedEventHandler handler);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomation4
@GUID("1189c02a-05f8-4319-8e21-e817e3db2860")
interface IUIAutomation4 : IUIAutomation3
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation4-addchangeseventhandler
    HRESULT AddChangesEventHandler(IUIAutomationElement element, TreeScope scope_, int* changeTypes, 
                                   int changesCount, IUIAutomationCacheRequest pCacheRequest, 
                                   IUIAutomationChangesEventHandler handler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation4-removechangeseventhandler
    HRESULT RemoveChangesEventHandler(IUIAutomationElement element, IUIAutomationChangesEventHandler handler);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nn-uiautomationclient-iuiautomation5
@GUID("25f700c8-d816-4057-a9dc-3cbdee77e256")
interface IUIAutomation5 : IUIAutomation4
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation5-addnotificationeventhandler
    HRESULT AddNotificationEventHandler(IUIAutomationElement element, TreeScope scope_, 
                                        IUIAutomationCacheRequest cacheRequest, 
                                        IUIAutomationNotificationEventHandler handler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/uiautomationclient/nf-uiautomationclient-iuiautomation5-removenotificationeventhandler
    HRESULT RemoveNotificationEventHandler(IUIAutomationElement element, 
                                           IUIAutomationNotificationEventHandler handler);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nn-textserv-iricheditwindowlessaccessibility
@GUID("983e572d-20cd-460b-9104-83111592dd10")
interface IRicheditWindowlessAccessibility : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-iricheditwindowlessaccessibility-createprovider
    HRESULT CreateProvider(IRawElementProviderWindowlessSite pSite, IRawElementProviderSimple* ppProvider);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nn-textserv-irichedituiainformation
@GUID("23969a9d-8546-4032-a1bb-73750cbf3333")
interface IRichEditUiaInformation : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-irichedituiainformation-getboundaryrectangle
    HRESULT GetBoundaryRectangle(UiaRect* pUiaRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-irichedituiainformation-isvisible
    HRESULT IsVisible();
}


// GUIDs

const GUID CLSID_CAccPropServices              = GUIDOF!CAccPropServices;
const GUID CLSID_CUIAutomation                 = GUIDOF!CUIAutomation;
const GUID CLSID_CUIAutomation8                = GUIDOF!CUIAutomation8;
const GUID CLSID_CUIAutomationClientInfo       = GUIDOF!CUIAutomationClientInfo;
const GUID CLSID_CUIAutomationClientInfoSource = GUIDOF!CUIAutomationClientInfoSource;
const GUID CLSID_CUIAutomationRegistrar        = GUIDOF!CUIAutomationRegistrar;

const GUID IID_IAccIdentity                                       = GUIDOF!IAccIdentity;
const GUID IID_IAccPropServer                                     = GUIDOF!IAccPropServer;
const GUID IID_IAccPropServices                                   = GUIDOF!IAccPropServices;
const GUID IID_IAccessible                                        = GUIDOF!IAccessible;
const GUID IID_IAccessibleEx                                      = GUIDOF!IAccessibleEx;
const GUID IID_IAccessibleHandler                                 = GUIDOF!IAccessibleHandler;
const GUID IID_IAccessibleHostingElementProviders                 = GUIDOF!IAccessibleHostingElementProviders;
const GUID IID_IAccessibleWindowlessSite                          = GUIDOF!IAccessibleWindowlessSite;
const GUID IID_IAnnotationProvider                                = GUIDOF!IAnnotationProvider;
const GUID IID_ICustomNavigationProvider                          = GUIDOF!ICustomNavigationProvider;
const GUID IID_IDockProvider                                      = GUIDOF!IDockProvider;
const GUID IID_IDragProvider                                      = GUIDOF!IDragProvider;
const GUID IID_IDropTargetProvider                                = GUIDOF!IDropTargetProvider;
const GUID IID_IExpandCollapseProvider                            = GUIDOF!IExpandCollapseProvider;
const GUID IID_IGridItemProvider                                  = GUIDOF!IGridItemProvider;
const GUID IID_IGridProvider                                      = GUIDOF!IGridProvider;
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
const GUID IID_IRichEditUiaInformation                            = GUIDOF!IRichEditUiaInformation;
const GUID IID_IRicheditWindowlessAccessibility                   = GUIDOF!IRicheditWindowlessAccessibility;
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
const GUID IID_IUIAutomationClientConnectionCallback              = GUIDOF!IUIAutomationClientConnectionCallback;
const GUID IID_IUIAutomationClientInfo                            = GUIDOF!IUIAutomationClientInfo;
const GUID IID_IUIAutomationClientInfoSource                      = GUIDOF!IUIAutomationClientInfoSource;
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
const GUID IID_IVirtualizedItemProvider                           = GUIDOF!IVirtualizedItemProvider;
const GUID IID_IWindowProvider                                    = GUIDOF!IWindowProvider;
