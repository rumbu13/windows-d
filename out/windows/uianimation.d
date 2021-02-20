// Written in the D programming language.

module windows.uianimation;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.directcomposition : IDCompositionAnimation;
public import windows.systemservices : BOOL;

extern(Windows) @nogc nothrow:


// Enums


///Defines results for animation updates.
alias UI_ANIMATION_UPDATE_RESULT = int;
enum : int
{
    ///No animation variables have changed.
    UI_ANIMATION_UPDATE_NO_CHANGE         = 0x00000000,
    ///One or more animation variables has changed.
    UI_ANIMATION_UPDATE_VARIABLES_CHANGED = 0x00000001,
}

///Defines the activity status of an animation manager.
alias UI_ANIMATION_MANAGER_STATUS = int;
enum : int
{
    ///The animation manager is idle; no animations are currently playing.
    UI_ANIMATION_MANAGER_IDLE = 0x00000000,
    ///The animation manager is busy; at least one animation is currently playing or scheduled.
    UI_ANIMATION_MANAGER_BUSY = 0x00000001,
}

///Defines animation modes.
alias UI_ANIMATION_MODE = int;
enum : int
{
    ///Animation is disabled.
    UI_ANIMATION_MODE_DISABLED       = 0x00000000,
    ///The animation mode is managed by the system.
    UI_ANIMATION_MODE_SYSTEM_DEFAULT = 0x00000001,
    ///Animation is enabled.
    UI_ANIMATION_MODE_ENABLED        = 0x00000002,
}

///Defines the pattern for a loop iteration.
alias UI_ANIMATION_REPEAT_MODE = int;
enum : int
{
    ///The start of a loop begins with the first value (v1-&gt;v2, v1-&gt;v2, v1-&gt;v2, and so on).
    UI_ANIMATION_REPEAT_MODE_NORMAL    = 0x00000000,
    UI_ANIMATION_REPEAT_MODE_ALTERNATE = 0x00000001,
}

///Defines the rounding modes to be used when the value of an animation variable is converted from a floating-point type
///to an integer type.
alias UI_ANIMATION_ROUNDING_MODE = int;
enum : int
{
    ///Round to the nearest integer.
    UI_ANIMATION_ROUNDING_NEAREST = 0x00000000,
    ///Round down.
    UI_ANIMATION_ROUNDING_FLOOR   = 0x00000001,
    ///Round up.
    UI_ANIMATION_ROUNDING_CEILING = 0x00000002,
}

///Defines the status for a storyboard.
alias UI_ANIMATION_STORYBOARD_STATUS = int;
enum : int
{
    ///The storyboard has never been scheduled.
    UI_ANIMATION_STORYBOARD_BUILDING              = 0x00000000,
    ///The storyboard is scheduled to play.
    UI_ANIMATION_STORYBOARD_SCHEDULED             = 0x00000001,
    ///The storyboard was canceled.
    UI_ANIMATION_STORYBOARD_CANCELLED             = 0x00000002,
    ///The storyboard is currently playing.
    UI_ANIMATION_STORYBOARD_PLAYING               = 0x00000003,
    ///The storyboard was truncated.
    UI_ANIMATION_STORYBOARD_TRUNCATED             = 0x00000004,
    ///The storyboard has finished playing.
    UI_ANIMATION_STORYBOARD_FINISHED              = 0x00000005,
    ///The storyboard is built and ready for scheduling.
    UI_ANIMATION_STORYBOARD_READY                 = 0x00000006,
    ///Scheduling the storyboard failed because a scheduling conflict occurred and the currently scheduled storyboard
    ///has higher priority.
    UI_ANIMATION_STORYBOARD_INSUFFICIENT_PRIORITY = 0x00000007,
}

///Defines results for storyboard scheduling.
alias UI_ANIMATION_SCHEDULING_RESULT = int;
enum : int
{
    ///Scheduling failed for an unexpected reason.
    UI_ANIMATION_SCHEDULING_UNEXPECTED_FAILURE    = 0x00000000,
    ///Scheduling failed because a scheduling conflict occurred and the currently scheduled storyboard has higher
    ///priority. For more information, see IUIAnimationPriorityComparison::HasPriority.
    UI_ANIMATION_SCHEDULING_INSUFFICIENT_PRIORITY = 0x00000001,
    ///Scheduling failed because the storyboard is already scheduled.
    UI_ANIMATION_SCHEDULING_ALREADY_SCHEDULED     = 0x00000002,
    ///Scheduling succeeded.
    UI_ANIMATION_SCHEDULING_SUCCEEDED             = 0x00000003,
    ///Scheduling is deferred and will be attempted when the current callback completes.
    UI_ANIMATION_SCHEDULING_DEFERRED              = 0x00000004,
}

///Defines potential effects on a storyboard if a priority comparison returns false.
alias UI_ANIMATION_PRIORITY_EFFECT = int;
enum : int
{
    ///This storyboard might not be successfully scheduled.
    UI_ANIMATION_PRIORITY_EFFECT_FAILURE = 0x00000000,
    ///The storyboard will be scheduled, but might start playing later.
    UI_ANIMATION_PRIORITY_EFFECT_DELAY   = 0x00000001,
}

///Defines animation slope characteristics.
alias UI_ANIMATION_SLOPE = int;
enum : int
{
    ///An increasing slope.
    UI_ANIMATION_SLOPE_INCREASING = 0x00000000,
    ///A decreasing slope.
    UI_ANIMATION_SLOPE_DECREASING = 0x00000001,
}

///Defines which aspects of an interpolator depend on a given input.
alias UI_ANIMATION_DEPENDENCIES = int;
enum : int
{
    ///No aspect depends on the input.
    UI_ANIMATION_DEPENDENCY_NONE                = 0x00000000,
    ///The intermediate values depend on the input.
    UI_ANIMATION_DEPENDENCY_INTERMEDIATE_VALUES = 0x00000001,
    ///The final value depends on the input.
    UI_ANIMATION_DEPENDENCY_FINAL_VALUE         = 0x00000002,
    ///The final velocity depends on the input.
    UI_ANIMATION_DEPENDENCY_FINAL_VELOCITY      = 0x00000004,
    ///The duration depends on the input.
    UI_ANIMATION_DEPENDENCY_DURATION            = 0x00000008,
}

///Defines the behavior of a timer when the animation manager is idle.
alias UI_ANIMATION_IDLE_BEHAVIOR = int;
enum : int
{
    ///The timer continues to generate timer events (is enabled) when the animation manager is idle.
    UI_ANIMATION_IDLE_BEHAVIOR_CONTINUE = 0x00000000,
    ///The timer is suspended (disabled) when the animation manager is idle.
    UI_ANIMATION_IDLE_BEHAVIOR_DISABLE  = 0x00000001,
}

///Defines activity status for a timer's client.
alias UI_ANIMATION_TIMER_CLIENT_STATUS = int;
enum : int
{
    ///The client is idle.
    UI_ANIMATION_TIMER_CLIENT_IDLE = 0x00000000,
    ///The client is busy.
    UI_ANIMATION_TIMER_CLIENT_BUSY = 0x00000001,
}

// Structs


struct UI_ANIMATION_KEYFRAME
{
    ptrdiff_t Value;
}

// Interfaces

@GUID("4C1FC63A-695C-47E8-A339-1A194BE3D0B8")
struct UIAnimationManager;

@GUID("D25D8842-8884-4A4A-B321-091314379BDD")
struct UIAnimationManager2;

@GUID("1D6322AD-AA85-4EF5-A828-86D71067D145")
struct UIAnimationTransitionLibrary;

@GUID("812F944A-C5C8-4CD9-B0A6-B3DA802F228D")
struct UIAnimationTransitionLibrary2;

@GUID("8A9B1CDD-FCD7-419C-8B44-42FD17DB1887")
struct UIAnimationTransitionFactory;

@GUID("84302F97-7F7B-4040-B190-72AC9D18E420")
struct UIAnimationTransitionFactory2;

@GUID("BFCD4A0C-06B6-4384-B768-0DAA792C380E")
struct UIAnimationTimer;

///Defines the animation manager, which provides a central interface for creating and managing animations.
@GUID("9169896C-AC8D-4E7D-94E5-67FA4DC2F2E8")
interface IUIAnimationManager : IUnknown
{
    ///Creates a new animation variable.
    ///Params:
    ///    initialValue = The initial value for the new animation variable.
    ///    variable = The new animation variable.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateAnimationVariable(double initialValue, IUIAnimationVariable* variable);
    ///Creates and schedules a single-transition storyboard.
    ///Params:
    ///    variable = The animation variable.
    ///    transition = A transition to be applied to the animation variable.
    ///    timeNow = The current system time.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT ScheduleTransition(IUIAnimationVariable variable, IUIAnimationTransition transition, double timeNow);
    ///Creates a new storyboard.
    ///Params:
    ///    storyboard = The new storyboard.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateStoryboard(IUIAnimationStoryboard* storyboard);
    ///Finishes all active storyboards within the specified time interval.
    ///Params:
    ///    completionDeadline = The maximum time interval during which all storyboards must be finished.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT FinishAllStoryboards(double completionDeadline);
    ///Abandons all active storyboards.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT AbandonAllStoryboards();
    ///Updates the values of all animation variables.
    ///Params:
    ///    timeNow = The current system time. This parameter must be greater than or equal to 0.0.
    ///    updateResult = The result of the update. This parameter can be omitted from calls to this method.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT Update(double timeNow, UI_ANIMATION_UPDATE_RESULT* updateResult);
    ///Gets the animation variable with the specified tag.
    ///Params:
    ///    object = The object portion of the tag. This parameter can be <b>NULL</b>.
    ///    id = The identifier portion of the tag.
    ///    variable = The animation variable that matches the specified tag, or <b>NULL</b> if no match is found.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetVariableFromTag(IUnknown object, uint id, IUIAnimationVariable* variable);
    ///Gets the storyboard with the specified tag.
    ///Params:
    ///    object = The object portion of the tag. This parameter can be <b>NULL</b>.
    ///    id = The identifier portion of the tag.
    ///    storyboard = The storyboard that matches the specified tag, or <b>NULL</b> if no match is found.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetStoryboardFromTag(IUnknown object, uint id, IUIAnimationStoryboard* storyboard);
    ///Gets the status of the animation manager.
    ///Params:
    ///    status = The status.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetStatus(UI_ANIMATION_MANAGER_STATUS* status);
    ///Sets the animation mode.
    ///Params:
    ///    mode = The animation mode.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT SetAnimationMode(UI_ANIMATION_MODE mode);
    ///Pauses all animations.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT Pause();
    ///Resumes all animations.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT Resume();
    ///Specifies a handler for animation manager status updates.
    ///Params:
    ///    handler = The event handler to be called when the status of the animation manager changes. The specified object must
    ///              implement the IUIAnimationManagerEventHandler interface or be <b>NULL</b>. See Remarks section for more
    ///              information.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT SetManagerEventHandler(IUIAnimationManagerEventHandler handler);
    ///Sets the priority comparison handler to be called to determine whether a scheduled storyboard can be canceled.
    ///Params:
    ///    comparison = The priority comparison handler for cancelation. The specified object must implement the
    ///                 IUIAnimationPriorityComparison interface or be <b>NULL</b>. See Remarks.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT SetCancelPriorityComparison(IUIAnimationPriorityComparison comparison);
    ///Sets the priority comparison handler to be called to determine whether a scheduled storyboard can be trimmed.
    ///Params:
    ///    comparison = The priority comparison handler for trimming. The specified object must implement the
    ///                 IUIAnimationPriorityComparison interface or be <b>NULL</b>. See Remarks.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT SetTrimPriorityComparison(IUIAnimationPriorityComparison comparison);
    ///Sets the priority comparison handler to be called to determine whether a scheduled storyboard can be compressed.
    ///Params:
    ///    comparison = The priority comparison handler for compression. The specified object must implement the
    ///                 IUIAnimationPriorityComparison interface or be <b>NULL</b>. See Remarks.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT SetCompressPriorityComparison(IUIAnimationPriorityComparison comparison);
    ///Sets the priority comparison handler to be called to determine whether a scheduled storyboard can be concluded.
    ///Params:
    ///    comparison = The priority comparison handler for conclusion. The specified object must implement the
    ///                 IUIAnimationPriorityComparison interface or be <b>NULL</b>. See Remarks.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT SetConcludePriorityComparison(IUIAnimationPriorityComparison comparison);
    ///Sets the default acceptable animation delay. This is the length of time that may pass before storyboards begin.
    ///Params:
    ///    delay = The default delay. This parameter can be a positive value, or <b>UI_ANIMATION_SECONDS_EVENTUALLY</b> (-1) to
    ///            indicate that any finite delay is acceptable.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT SetDefaultLongestAcceptableDelay(double delay);
    ///Shuts down the animation manager and all its associated objects.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT Shutdown();
}

///Defines an animation variable, which represents a visual element that can be animated.
@GUID("8CEEB155-2849-4CE5-9448-91FF70E1E4D9")
interface IUIAnimationVariable : IUnknown
{
    ///Gets the current value of the animation variable.
    ///Params:
    ///    value = The current value of the animation variable.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetValue(double* value);
    ///Gets the final value of the animation variable. This is the value after all currently scheduled animations have
    ///completed.
    ///Params:
    ///    finalValue = The final value of the animation variable.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>UI_E_VALUE_NOT_DETERMINED</b></dt> </dl> </td> <td width="60%"> The final
    ///    value of the animation variable cannot be determined at this time. </td> </tr> </table>
    ///    
    HRESULT GetFinalValue(double* finalValue);
    ///Gets the previous value of the animation variable. This is the value of the animation variable before the most
    ///recent update.
    ///Params:
    ///    previousValue = The previous value of the animation variable.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetPreviousValue(double* previousValue);
    ///Gets the current value of the animation variable as an integer.
    ///Params:
    ///    value = The current value of the animation variable, converted to an <b>INT32</b> value.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetIntegerValue(int* value);
    ///Gets the final value of the animation variable as an integer. This is the value after all currently scheduled
    ///animations have completed.
    ///Params:
    ///    finalValue = The final value of the animation variable, converted to an <b>INT32</b> value.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>UI_E_VALUE_NOT_DETERMINED</b></dt> </dl> </td> <td width="60%"> The final
    ///    value of the animation variable cannot be determined at this time. </td> </tr> </table>
    ///    
    HRESULT GetFinalIntegerValue(int* finalValue);
    ///Gets the previous value of the animation variable as an integer. This is the value of the animation variable
    ///before the most recent update.
    ///Params:
    ///    previousValue = The previous value of the animation variable, converted to an <b>INT32</b> value.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetPreviousIntegerValue(int* previousValue);
    ///Gets the storyboard that is currently animating the animation variable.
    ///Params:
    ///    storyboard = The current storyboard, or <b>NULL</b> if no storyboard is currently animating the animation variable.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See UIAnimation
    ///    Error Codes for a list of error codes.
    ///    
    HRESULT GetCurrentStoryboard(IUIAnimationStoryboard* storyboard);
    ///Sets the lower bound (floor) for the animation variable. The value of the animation variable should not fall
    ///below the specified value.
    ///Params:
    ///    bound = The lower bound for the animation variable.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT SetLowerBound(double bound);
    ///Sets an upper bound (ceiling) for the animation variable. The value of the animation variable should not rise
    ///above the specified value.
    ///Params:
    ///    bound = The upper bound for the animation variable.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT SetUpperBound(double bound);
    ///Specifies the rounding mode for the animation variable.
    ///Params:
    ///    mode = The rounding mode for the animation variable.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT SetRoundingMode(UI_ANIMATION_ROUNDING_MODE mode);
    ///Sets the tag for an animation variable.
    ///Params:
    ///    object = The object portion of the tag. This parameter can be <b>NULL</b>.
    ///    id = The identifier portion of the tag.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT SetTag(IUnknown object, uint id);
    ///Gets the tag for an animation variable.
    ///Params:
    ///    object = The object portion of the tag.
    ///    id = The identifier portion of the tag.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>UI_E_VALUE_NOT_SET</b></dt> </dl> </td> <td width="60%"> The animation
    ///    variable's tag was not set. </td> </tr> </table>
    ///    
    HRESULT GetTag(IUnknown* object, uint* id);
    ///Specifies a variable change handler. This handler is notified of changes to the value of the animation variable.
    ///Params:
    ///    handler = A variable change handler. The specified object must implement the IUIAnimationVariableChangeHandler
    ///              interface or be <b>NULL</b>. See Remarks.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT SetVariableChangeHandler(IUIAnimationVariableChangeHandler handler);
    ///Specifies an integer variable change handler. This handler is notified of changes to the integer value of the
    ///animation variable.
    ///Params:
    ///    handler = An integer variable change handler. The specified object must implement the
    ///              IUIAnimationVariableIntegerChangeHandler interface or be NULL. See Remarks.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Winodws
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT SetVariableIntegerChangeHandler(IUIAnimationVariableIntegerChangeHandler handler);
}

///Defines a storyboard, which contains a group of transitions that are synchronized relative to one another.
@GUID("A8FF128F-9BF9-4AF1-9E67-E5E410DEFB84")
interface IUIAnimationStoryboard : IUnknown
{
    ///Adds a transition to the storyboard.
    ///Params:
    ///    variable = The animation variable for which the transition is to be added.
    ///    transition = The transition to be added.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>UI_E_TRANSITION_ALREADY_USED</b></dt> </dl> </td> <td width="60%"> This
    ///    transition has already been added to a storyboard. </td> </tr> </table>
    ///    
    HRESULT AddTransition(IUIAnimationVariable variable, IUIAnimationTransition transition);
    ///Adds a keyframe at the specified offset from an existing keyframe.
    ///Params:
    ///    existingKeyframe = The existing keyframe. To add a keyframe at an offset from the start of the storyboard, use the special
    ///                       keyframe UI_ANIMATION_KEYFRAME_STORYBOARD_START.
    ///    offset = The offset from the existing keyframe at which a new keyframe is to be added.
    ///    keyframe = The keyframe to be added.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT AddKeyframeAtOffset(UI_ANIMATION_KEYFRAME existingKeyframe, double offset, 
                                UI_ANIMATION_KEYFRAME* keyframe);
    ///Adds a keyframe at the end of the specified transition.
    ///Params:
    ///    transition = The transition after which a keyframe is to be added.
    ///    keyframe = The keyframe to be added.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>UI_E_TRANSITION_NOT_IN_STORYBOARD</b></dt> </dl> </td> <td width="60%"> The
    ///    transition has not been added to the storyboard. </td> </tr> </table>
    ///    
    HRESULT AddKeyframeAfterTransition(IUIAnimationTransition transition, UI_ANIMATION_KEYFRAME* keyframe);
    ///Adds a transition that starts at the specified keyframe.
    ///Params:
    ///    variable = The animation variable for which a transition is to be added.
    ///    transition = The transition to be added.
    ///    startKeyframe = The keyframe that specifies the beginning of the new transition.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>UI_E_TRANSITION_ALREADY_USED</b></dt> </dl> </td> <td width="60%"> This
    ///    transition has already been added to a storyboard or has been added to a storyboard that has finished playing
    ///    and been released. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>UI_E_TRANSITION_ECLIPSED</b></dt> </dl>
    ///    </td> <td width="60%"> The transition might eclipse the beginning of another transition in the storyboard.
    ///    </td> </tr> </table>
    ///    
    HRESULT AddTransitionAtKeyframe(IUIAnimationVariable variable, IUIAnimationTransition transition, 
                                    UI_ANIMATION_KEYFRAME startKeyframe);
    ///Adds a transition between two keyframes.
    ///Params:
    ///    variable = The animation variable for which the transition is to be added.
    ///    transition = The transition to be added.
    ///    startKeyframe = A keyframe that specifies the beginning of the new transition.
    ///    endKeyframe = A keyframe that specifies the end of the new transition. It must not be possible for <i>endKeyframe</i> to
    ///                  appear earlier in the storyboard than <i>startKeyframe</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>UI_E_TRANSITION_ALREADY_USED</b></dt> </dl> </td> <td width="60%"> This
    ///    transition has already been added to a storyboard or has been added to a storyboard that has finished playing
    ///    and been released. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>UI_E_TRANSITION_ECLIPSED</b></dt> </dl>
    ///    </td> <td width="60%"> The transition might eclipse the beginning of another transition in the storyboard.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>UI_E_START_KEYFRAME_AFTER_END</b></dt> </dl> </td> <td
    ///    width="60%"> The start keyframe might occur after the end keyframe. </td> </tr> </table>
    ///    
    HRESULT AddTransitionBetweenKeyframes(IUIAnimationVariable variable, IUIAnimationTransition transition, 
                                          UI_ANIMATION_KEYFRAME startKeyframe, UI_ANIMATION_KEYFRAME endKeyframe);
    ///Creates a loop between two specified keyframes.
    ///Params:
    ///    startKeyframe = The keyframe at which the loop is to begin.
    ///    endKeyframe = The keyframe at which the loop is to end. It must not be posssible for <i>endKeyframe</i> to occur earlier in
    ///                  the storyboard than <i>startKeyframe</i>.
    ///    repetitionCount = The number of times the loop is to be repeated; this parameter must be 0 or a positive number. Use
    ///                      UI_ANIMATION_REPEAT_INDEFINITELY (-1) to repeat the loop indefinitely until the storyboard is trimmed or
    ///                      concluded.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>UI_E_START_KEYFRAME_AFTER_END</b></dt> </dl> </td> <td width="60%"> The
    ///    start keyframe might occur after the end keyframe. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UI_E_END_KEYFRAME_NOT_DETERMINED</b></dt> </dl> </td> <td width="60%"> It might not be possible to
    ///    determine the end keyframe time when the start keyframe is reached. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UI_E_LOOPS_OVERLAP</b></dt> </dl> </td> <td width="60%"> Two repeated portions of a storyboard might
    ///    overlap. </td> </tr> </table>
    ///    
    HRESULT RepeatBetweenKeyframes(UI_ANIMATION_KEYFRAME startKeyframe, UI_ANIMATION_KEYFRAME endKeyframe, 
                                   int repetitionCount);
    ///Directs the storyboard to hold the specified animation variable at its final value until the storyboard ends.
    ///Params:
    ///    variable = The animation variable.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT HoldVariable(IUIAnimationVariable variable);
    ///Sets the longest acceptable delay before the scheduled storyboard begins.
    ///Params:
    ///    delay = The longest acceptable delay. This parameter can be a positive value, or
    ///            <b>UI_ANIMATION_SECONDS_EVENTUALLY</b> (-1) to indicate that any finite delay is acceptable.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT SetLongestAcceptableDelay(double delay);
    ///Directs the storyboard to schedule itself for play.
    ///Params:
    ///    timeNow = The current time.
    ///    schedulingResult = The result of the scheduling request. This parameter can be omitted from calls to this method.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT Schedule(double timeNow, UI_ANIMATION_SCHEDULING_RESULT* schedulingResult);
    ///Completes the current iteration of a keyframe loop that is in progress (where the loop is set to
    ///<b>UI_ANIMATION_REPEAT_INDEFINITELY</b>), terminates the loop, and continues with the storyboard.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT Conclude();
    ///Finishes the storyboard within the specified time, compressing the storyboard if necessary.
    ///Params:
    ///    completionDeadline = The maximum amount of time that the storyboard can use to finish playing.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT Finish(double completionDeadline);
    ///Terminates the storyboard, releases all related animation variables, and removes the storyboard from the
    ///schedule.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT Abandon();
    ///Sets the tag for the storyboard.
    ///Params:
    ///    object = The object portion of the tag. This parameter can be <b>NULL</b>.
    ///    id = The identifier portion of the tag.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>UI_E_STORYBOARD_ACTIVE</b></dt> </dl> </td> <td width="60%"> The storyboard
    ///    is currently in the schedule. </td> </tr> </table>
    ///    
    HRESULT SetTag(IUnknown object, uint id);
    ///Gets the tag for a storyboard.
    ///Params:
    ///    object = The object portion of the tag.
    ///    id = The identifier portion of the tag.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>UI_E_VALUE_NOT_SET</b></dt> </dl> </td> <td width="60%"> The storyboard's
    ///    tag was not set. </td> </tr> </table>
    ///    
    HRESULT GetTag(IUnknown* object, uint* id);
    ///Gets the status of the storyboard.
    ///Params:
    ///    status = The storyboard status.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetStatus(UI_ANIMATION_STORYBOARD_STATUS* status);
    ///Gets the time that has elapsed since the storyboard started playing.
    ///Params:
    ///    elapsedTime = The elapsed time.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>UI_E_STORYBOARD_NOT_PLAYING</b></dt> </dl> </td> <td width="60%"> The
    ///    storyboard is not playing. </td> </tr> </table>
    ///    
    HRESULT GetElapsedTime(double* elapsedTime);
    ///Specifies a handler for storyboard events.
    ///Params:
    ///    handler = The handler to be called whenever storyboard status and update events occur. The specified object must
    ///              implement the IUIAnimationStoryboardEventHandler interface or be <b>NULL</b>. See Remarks.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT SetStoryboardEventHandler(IUIAnimationStoryboardEventHandler handler);
}

///Defines a transition, which determines how an animation variable changes over time.
@GUID("DC6CE252-F731-41CF-B610-614B6CA049AD")
interface IUIAnimationTransition : IUnknown
{
    ///Sets the initial value for the transition.
    ///Params:
    ///    value = The initial value for the transition.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT SetInitialValue(double value);
    ///Sets the initial velocity for the transition.
    ///Params:
    ///    velocity = The initial velocity for the transition.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT SetInitialVelocity(double velocity);
    ///Determines whether a transition's duration is currently known.
    ///Returns:
    ///    Returns S_OK if the duration is known, S_FALSE if the duration is not known, or an <b>HRESULT</b> error code.
    ///    See Windows Animation Error Codes for a list of error codes. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>UI_E_STORYBOARD_ACTIVE</b></dt> </dl> </td> <td
    ///    width="60%"> The storyboard for this transition is currently in schedule. </td> </tr> </table>
    ///    
    HRESULT IsDurationKnown();
    ///Gets the duration of the transition.
    ///Params:
    ///    duration = The duration of the transition, in seconds.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>UI_E_VALUE_NOT_DETERMINED</b></dt> </dl> </td> <td width="60%"> The
    ///    requested value for the duration cannot be determined. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UI_E_STORYBOARD_ACTIVE</b></dt> </dl> </td> <td width="60%"> The storyboard for this transition is
    ///    currently in the schedule. </td> </tr> </table>
    ///    
    HRESULT GetDuration(double* duration);
}

///Defines a method for handling status updates to an animation manager.
@GUID("783321ED-78A3-4366-B574-6AF607A64788")
interface IUIAnimationManagerEventHandler : IUnknown
{
    ///Handles status changes to an animation manager.
    ///Params:
    ///    newStatus = The new status.
    ///    previousStatus = The previous status.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT OnManagerStatusChanged(UI_ANIMATION_MANAGER_STATUS newStatus, 
                                   UI_ANIMATION_MANAGER_STATUS previousStatus);
}

///Defines a method for handling events related to animation variable updates.
@GUID("6358B7BA-87D2-42D5-BF71-82E919DD5862")
interface IUIAnimationVariableChangeHandler : IUnknown
{
    ///Handles events that occur when the value of an animation variable changes. This method receives updates as
    ///<b>DOUBLE</b> values. To receive updates as <b>INT32</b> values, use the
    ///IUIAnimationVariableIntegerChangeHandler::OnIntegerValueChanged method.
    ///Params:
    ///    storyboard = The storyboard that is animating the animation variable specified by the <i>variable</i> parameter.
    ///    variable = The animation variable that has been updated.
    ///    newValue = The new value of the animation variable.
    ///    previousValue = The previous value of the animation variable.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT OnValueChanged(IUIAnimationStoryboard storyboard, IUIAnimationVariable variable, double newValue, 
                           double previousValue);
}

///Defines a method for handling animation variable update events.
@GUID("BB3E1550-356E-44B0-99DA-85AC6017865E")
interface IUIAnimationVariableIntegerChangeHandler : IUnknown
{
    ///Handles events that occur when the value of an animation variable changes. This method receives updates as
    ///<b>INT32</b> values. To receive updates as <b>DOUBLE</b> values, use the
    ///IUIAnimationVariableChangeHandler::OnValueChanged method.
    ///Params:
    ///    storyboard = The storyboard that is animating the animation variable specified by the <i>variable</i> parameter.
    ///    variable = The animation variable that has been updated.
    ///    newValue = The new value of the animation variable, rounded according to the variable's rounding mode.
    ///    previousValue = The previous value of the animation variable, rounded according to the variable's rounding mode.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT OnIntegerValueChanged(IUIAnimationStoryboard storyboard, IUIAnimationVariable variable, int newValue, 
                                  int previousValue);
}

///Defines methods for handling status and update events for a storyboard.
@GUID("3D5C9008-EC7C-4364-9F8A-9AF3C58CBAE6")
interface IUIAnimationStoryboardEventHandler : IUnknown
{
    ///Handles events that occur when a storyboard's status changes.
    ///Params:
    ///    storyboard = The storyboard whose status has changed.
    ///    newStatus = The new status.
    ///    previousStatus = The previous status.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT OnStoryboardStatusChanged(IUIAnimationStoryboard storyboard, UI_ANIMATION_STORYBOARD_STATUS newStatus, 
                                      UI_ANIMATION_STORYBOARD_STATUS previousStatus);
    ///Handles events that occur when a storyboard is updated.
    ///Params:
    ///    storyboard = The storyboard that has been updated.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT OnStoryboardUpdated(IUIAnimationStoryboard storyboard);
}

///Defines a method for priority comparison that the animation manager uses to resolve scheduling conflicts.
@GUID("83FA9B74-5F86-4618-BC6A-A2FAC19B3F44")
interface IUIAnimationPriorityComparison : IUnknown
{
    ///Determines whether a new storyboard has priority over a scheduled storyboard.
    ///Params:
    ///    scheduledStoryboard = The currently scheduled storyboard.
    ///    newStoryboard = The new storyboard that is interrupting the scheduled storyboard specified in <i>scheduledStoryboard</i>.
    ///    priorityEffect = The potential effect on <i>newStoryboard</i> if <i>scheduledStoryboard</i> has a higher priority.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> <i>newStoryboard</i> has priority.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%">
    ///    <i>scheduledStoryboard</i> has priority. </td> </tr> </table>
    ///    
    HRESULT HasPriority(IUIAnimationStoryboard scheduledStoryboard, IUIAnimationStoryboard newStoryboard, 
                        UI_ANIMATION_PRIORITY_EFFECT priorityEffect);
}

///Defines a library of standard transitions.
@GUID("CA5A14B1-D24F-48B8-8FE4-C78169BA954E")
interface IUIAnimationTransitionLibrary : IUnknown
{
    ///Creates an instantaneous transition.
    ///Params:
    ///    finalValue = The value of the animation variable at the end of the transition.
    ///    transition = The new instantaneous transition.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateInstantaneousTransition(double finalValue, IUIAnimationTransition* transition);
    ///Creates a constant transition.
    ///Params:
    ///    duration = The duration of the transition.
    ///    transition = The new constant transition.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateConstantTransition(double duration, IUIAnimationTransition* transition);
    ///Creates a discrete transition.
    ///Params:
    ///    delay = The amount of time by which to delay the instantaneous switch to the final value.
    ///    finalValue = The value of the animation variable at the end of the transition.
    ///    hold = The amount of time by which to hold the variable at its final value.
    ///    transition = The new discrete transition.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateDiscreteTransition(double delay, double finalValue, double hold, 
                                     IUIAnimationTransition* transition);
    ///Creates a linear transition.
    ///Params:
    ///    duration = The duration of the transition.
    ///    finalValue = The value of the animation variable at the end of the transition.
    ///    transition = The new linear transition.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateLinearTransition(double duration, double finalValue, IUIAnimationTransition* transition);
    ///Creates a linear-speed transition.
    ///Params:
    ///    speed = The absolute value of the velocity.
    ///    finalValue = The value of the animation variable at the end of the transition.
    ///    transition = The new linear-speed transition.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateLinearTransitionFromSpeed(double speed, double finalValue, IUIAnimationTransition* transition);
    ///Creates a sinusoidal-velocity transition, with an amplitude determined by the initial velocity.
    ///Params:
    ///    duration = The duration of the transition.
    ///    period = The period of oscillation of the sinusoidal wave in seconds.
    ///    transition = The new sinusoidal-velocity transition.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateSinusoidalTransitionFromVelocity(double duration, double period, 
                                                   IUIAnimationTransition* transition);
    ///Creates a sinusoidal-range transition, with a specified range of oscillation.
    ///Params:
    ///    duration = The duration of the transition.
    ///    minimumValue = The value of the animation variable at a trough of the sinusoidal wave.
    ///    maximumValue = The value of the animation variable at a peak of the sinusoidal wave.
    ///    period = The period of oscillation of the sinusoidal wave, in seconds.
    ///    slope = The slope at the start of the transition.
    ///    transition = The new sinusoidal-range transition.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateSinusoidalTransitionFromRange(double duration, double minimumValue, double maximumValue, 
                                                double period, UI_ANIMATION_SLOPE slope, 
                                                IUIAnimationTransition* transition);
    ///Creates an accelerate-decelerate transition.
    ///Params:
    ///    duration = The duration of the transition.
    ///    finalValue = The value of the animation variable at the end of the transition.
    ///    accelerationRatio = The ratio of the time spent accelerating to the duration.
    ///    decelerationRatio = The ratio of the time spent decelerating to the duration.
    ///    transition = The new accelerate-decelerate transition.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateAccelerateDecelerateTransition(double duration, double finalValue, double accelerationRatio, 
                                                 double decelerationRatio, IUIAnimationTransition* transition);
    ///Creates a reversal transition.
    ///Params:
    ///    duration = The duration of the transition.
    ///    transition = The new reversal transition.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateReversalTransition(double duration, IUIAnimationTransition* transition);
    ///Creates a cubic transition.
    ///Params:
    ///    duration = The duration of the transition.
    ///    finalValue = The value of the animation variable at the end of the transition.
    ///    finalVelocity = The velocity of the variable at the end of the transition.
    ///    transition = The new cubic transition.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateCubicTransition(double duration, double finalValue, double finalVelocity, 
                                  IUIAnimationTransition* transition);
    ///Creates a smooth-stop transition.
    ///Params:
    ///    maximumDuration = The maximum duration of the transition.
    ///    finalValue = The value of the animation variable at the end of the transition.
    ///    transition = The new smooth-stop transition.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateSmoothStopTransition(double maximumDuration, double finalValue, 
                                       IUIAnimationTransition* transition);
    ///Creates a parabolic-acceleration transition.
    ///Params:
    ///    finalValue = The value of the animation variable at the end of the transition.
    ///    finalVelocity = The velocity at the end of the transition.
    ///    acceleration = The acceleration during the transition.
    ///    transition = The new parabolic-acceleration transition.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateParabolicTransitionFromAcceleration(double finalValue, double finalVelocity, double acceleration, 
                                                      IUIAnimationTransition* transition);
}

///Defines methods for creating a custom interpolator.
@GUID("7815CBBA-DDF7-478C-A46C-7B6C738B7978")
interface IUIAnimationInterpolator : IUnknown
{
    ///Sets the initial value and velocity at the start of the transition.
    ///Params:
    ///    initialValue = The initial value.
    ///    initialVelocity = The initial velocity.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT SetInitialValueAndVelocity(double initialValue, double initialVelocity);
    ///Sets the duration of the transition.
    ///Params:
    ///    duration = The duration of the transition.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT SetDuration(double duration);
    ///Gets the duration of a transition.
    ///Params:
    ///    duration = The duration of the transition.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetDuration(double* duration);
    ///Gets the final value at the end of the transition.
    ///Params:
    ///    value = The final value.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetFinalValue(double* value);
    ///Interpolates the value of an animation variable at the specified offset.
    ///Params:
    ///    offset = The offset from the start of the transition. This parameter is always greater than or equal to zero and less
    ///             than the duration of the transition. This method is not called if the duration of the transition is zero.
    ///    value = The interpolated value.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT InterpolateValue(double offset, double* value);
    ///Interpolates the velocity, or rate of change, at the specified offset.
    ///Params:
    ///    offset = The offset from the start of the transition. The offset is always greater than or equal to zero and less than
    ///             or equal to the duration of the transition. This method is not called if the duration of the transition is
    ///             zero.
    ///    velocity = The interpolated velocity.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT InterpolateVelocity(double offset, double* velocity);
    ///Gets the aspects of the interpolator that depend on the initial value or velocity passed to
    ///SetInitialValueAndVelocity, or that depend on the duration passed to SetDuration.
    ///Params:
    ///    initialValueDependencies = Aspects of the interpolator that depend on the initial value passed to SetInitialValueAndVelocity.
    ///    initialVelocityDependencies = Aspects of the interpolator that depend on the initial velocity passed to SetInitialValueAndVelocity.
    ///    durationDependencies = Aspects of the interpolator that depend on the duration passed to SetDuration.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetDependencies(UI_ANIMATION_DEPENDENCIES* initialValueDependencies, 
                            UI_ANIMATION_DEPENDENCIES* initialVelocityDependencies, 
                            UI_ANIMATION_DEPENDENCIES* durationDependencies);
}

///Defines a method for creating transitions from custom interpolators.
@GUID("FCD91E03-3E3B-45AD-BBB1-6DFC8153743D")
interface IUIAnimationTransitionFactory : IUnknown
{
    ///Creates a transition from a custom interpolator.
    ///Params:
    ///    interpolator = The interpolator from which a transition is to be created. The specified object must implement the
    ///                   IUIAnimationInterpolator interface.
    ///    transition = The new transition.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateTransition(IUIAnimationInterpolator interpolator, IUIAnimationTransition* transition);
}

///Defines an animation timer, which provides services for managing animation timing.
@GUID("6B0EFAD1-A053-41D6-9085-33A689144665")
interface IUIAnimationTimer : IUnknown
{
    ///Specifies a timer update handler.
    ///Params:
    ///    updateHandler = A timer update handler, or <b>NULL</b> (see Remarks). The specified object must implement the
    ///                    IUIAnimationTimerUpdateHandler interface.
    ///    idleBehavior = A member of UI_ANIMATION_IDLE_BEHAVIOR that specifies the behavior of the timer when it is idle.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If the update handler is already connected to a timer, this method
    ///    returns <b>UI_E_TIMER_CLIENT_ALREADY_CONNECTED</b>. Otherwise, it returns an <b>HRESULT</b> error code. See
    ///    Windows Animation Error Codes for a list of error codes.
    ///    
    HRESULT SetTimerUpdateHandler(IUIAnimationTimerUpdateHandler updateHandler, 
                                  UI_ANIMATION_IDLE_BEHAVIOR idleBehavior);
    ///Specifies a timer event handler.
    ///Params:
    ///    handler = A timer event handler. The specified object must implement the IUIAnimationTimerEventHandler interface or be
    ///              <b>NULL</b>. See Remarks.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT SetTimerEventHandler(IUIAnimationTimerEventHandler handler);
    ///Enables the animation timer.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT Enable();
    ///Disables the animation timer.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT Disable();
    ///Determines whether the timer is currently enabled.
    ///Returns:
    ///    Returns S_OK if the animation timer is enabled, S_FALSE if the animation timer is disabled, or an
    ///    <b>HRESULT</b> error code. See Windows Animation Error Codes for a list of error codes.
    ///    
    HRESULT IsEnabled();
    ///Gets the current time.
    ///Params:
    ///    seconds = The current time, in UI_ANIMATION_SECONDS.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetTime(double* seconds);
    ///Sets the frame rate below which the timer notifies the application that rendering is too slow.
    ///Params:
    ///    framesPerSecond = The minimum desirable frame rate, in frames per second.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT SetFrameRateThreshold(uint framesPerSecond);
}

///Defines methods for handling timing update events.
@GUID("195509B7-5D5E-4E3E-B278-EE3759B367AD")
interface IUIAnimationTimerUpdateHandler : IUnknown
{
    ///Handles update events from the timer.
    ///Params:
    ///    timeNow = The current timer time, in seconds.
    ///    result = Receives a member of the UI_ANIMATION_UPDATE_RESULT enumeration, indicating whether any animation variables
    ///             changed as a result of the update.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT OnUpdate(double timeNow, UI_ANIMATION_UPDATE_RESULT* result);
    ///Specifies a handler for timer client status change events.
    ///Params:
    ///    handler = A handler for timer client events. The specified object must implement IUIAnimationTimerUpdateHandler.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT SetTimerClientEventHandler(IUIAnimationTimerClientEventHandler handler);
    ///Clears the handler for timer client status change events.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT ClearTimerClientEventHandler();
}

///Defines a method for handling events related to changes in timer client status.
@GUID("BEDB4DB6-94FA-4BFB-A47F-EF2D9E408C25")
interface IUIAnimationTimerClientEventHandler : IUnknown
{
    ///Handles events that occur when the status of the timer's client changes.
    ///Params:
    ///    newStatus = The new status of the timer's client.
    ///    previousStatus = The previous status of the timer's client.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT OnTimerClientStatusChanged(UI_ANIMATION_TIMER_CLIENT_STATUS newStatus, 
                                       UI_ANIMATION_TIMER_CLIENT_STATUS previousStatus);
}

///Defines methods for handling timing events.
@GUID("274A7DEA-D771-4095-ABBD-8DF7ABD23CE3")
interface IUIAnimationTimerEventHandler : IUnknown
{
    ///Handles events that occur before an animation update begins.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See UIAnimation
    ///    Error Codes for a list of error codes.
    ///    
    HRESULT OnPreUpdate();
    ///Handles events that occur after an animation update is finished.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See UIAnimation
    ///    Error Codes for a list of error codes.
    ///    
    HRESULT OnPostUpdate();
    ///Handles events that occur when the rendering frame rate for an animation falls below a minimum desirable frame
    ///rate.
    ///Params:
    ///    framesPerSecond = The current frame rate, in frames per second.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See UIAnimation
    ///    Error Codes for a list of error codes.
    ///    
    HRESULT OnRenderingTooSlow(uint framesPerSecond);
}

///Defines an <b>animation manager</b>, which provides a central interface for creating and managing animations in
///multiple dimensions.
@GUID("D8B6F7D4-4109-4D3F-ACEE-879926968CB1")
interface IUIAnimationManager2 : IUnknown
{
    ///Creates a new animation variable for each specified dimension.
    ///Params:
    ///    initialValue = A vector (of size <i>cDimension</i>) of initial values for the animation variable.
    ///    cDimension = The number of dimensions that require animated values. This parameter specifies the number of values listed
    ///                 in <i>initialValue</i>.
    ///    variable = The new animation variable.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateAnimationVectorVariable(const(double)* initialValue, uint cDimension, 
                                          IUIAnimationVariable2* variable);
    ///Creates a new animation variable.
    ///Params:
    ///    initialValue = The initial value for the animation variable.
    ///    variable = The new animation variable.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateAnimationVariable(double initialValue, IUIAnimationVariable2* variable);
    ///Creates and schedules a single-transition storyboard.
    ///Params:
    ///    variable = The animation variable.
    ///    transition = A transition to be applied to the animation variable.
    ///    timeNow = The current system time.
    ///Returns:
    ///    Returns S_OK if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error Codes for a
    ///    list of error codes.
    ///    
    HRESULT ScheduleTransition(IUIAnimationVariable2 variable, IUIAnimationTransition2 transition, double timeNow);
    ///Creates a new storyboard.
    ///Params:
    ///    storyboard = The new storyboard.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateStoryboard(IUIAnimationStoryboard2* storyboard);
    ///Finishes all active storyboards within the specified time interval.
    ///Params:
    ///    completionDeadline = The maximum time interval during which all storyboards must be finished.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT FinishAllStoryboards(double completionDeadline);
    ///Abandons all active storyboards.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT AbandonAllStoryboards();
    ///Updates the values of all animation variables.
    ///Params:
    ///    timeNow = The current system time. This parameter must be greater than or equal to 0.0.
    ///    updateResult = The result of the update. You can omit this parameter from calls to this method.
    ///Returns:
    ///    Returns S_OK if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error Codes for a
    ///    list of error codes.
    ///    
    HRESULT Update(double timeNow, UI_ANIMATION_UPDATE_RESULT* updateResult);
    ///Gets the animation variable with the specified tag.
    ///Params:
    ///    object = The object portion of the tag. This parameter can be NULL.
    ///    id = The identifier portion of the tag.
    ///    variable = The animation variable that matches the specified tag, or <b>NULL</b> if no match is found.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetVariableFromTag(IUnknown object, uint id, IUIAnimationVariable2* variable);
    ///Gets the storyboard with the specified tag.
    ///Params:
    ///    object = The object portion of the tag. This parameter can be NULL.
    ///    id = The identifier portion of the tag.
    ///    storyboard = The storyboard that matches the specified tag, or <b>NULL</b> if no match is found.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetStoryboardFromTag(IUnknown object, uint id, IUIAnimationStoryboard2* storyboard);
    ///Retrieves an estimate of the time interval before the next animation event.
    ///Params:
    ///    seconds = The estimated time, in seconds.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT EstimateNextEventTime(double* seconds);
    ///Gets the status of the animation manager.
    ///Params:
    ///    status = The status of the animation manager.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetStatus(UI_ANIMATION_MANAGER_STATUS* status);
    ///Sets the animation mode.
    ///Params:
    ///    mode = The animation mode.
    ///Returns:
    ///    Returns S_OK if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error Codes for a
    ///    list of error codes.
    ///    
    HRESULT SetAnimationMode(UI_ANIMATION_MODE mode);
    ///Pauses all animations.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT Pause();
    ///Resumes all animations.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT Resume();
    ///Specifies a handler for animation manager status updates.
    ///Params:
    ///    handler = The event handler to be called when the status of the animation manager changes. The specified object must
    ///              implement the IUIAnimationManagerEventHandler interface or be <b>NULL</b>. See Remarks for more info.
    ///    fRegisterForNextAnimationEvent = If <b>TRUE</b>, specifies that IUIAnimationManager2::EstimateNextEventTime will incorporate <i>handler</i>
    ///                                     into its estimate of the time interval until the next animation event. No default value.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error Codes
    ///    for a list of error codes.
    ///    
    HRESULT SetManagerEventHandler(IUIAnimationManagerEventHandler2 handler, BOOL fRegisterForNextAnimationEvent);
    ///Sets the priority comparison handler that determines whether a scheduled storyboard can be canceled.
    ///Params:
    ///    comparison = The priority comparison handler for cancelation. The specified object must implement the
    ///                 IUIAnimationPriorityComparison2 interface or be <b>NULL</b>. See Remarks for more info.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error Codes
    ///    for a list of error codes.
    ///    
    HRESULT SetCancelPriorityComparison(IUIAnimationPriorityComparison2 comparison);
    ///Sets the priority comparison handler that determines whether a scheduled storyboard can be trimmed.
    ///Params:
    ///    comparison = The priority comparison handler for trimming. The specified object must implement the
    ///                 IUIAnimationPriorityComparison interface or be <b>NULL</b>. See Remarks for more info.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error Codes
    ///    for a list of error codes.
    ///    
    HRESULT SetTrimPriorityComparison(IUIAnimationPriorityComparison2 comparison);
    ///Sets the priority comparison handler that determines whether a scheduled storyboard can be compressed.
    ///Params:
    ///    comparison = The priority comparison handler for compression. The specified object must implement the
    ///                 IUIAnimationPriorityComparison2 interface or be <b>NULL</b>. See Remarks for more info.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error Codes
    ///    for a list of error codes.
    ///    
    HRESULT SetCompressPriorityComparison(IUIAnimationPriorityComparison2 comparison);
    ///Sets the priority comparison handler that determines whether a scheduled storyboard can be concluded.
    ///Params:
    ///    comparison = The priority comparison handler for conclusion. The specified object must implement the
    ///                 IUIAnimationPriorityComparison2 interface or be <b>NULL</b>. See Remarks for more info.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error Codes
    ///    for a list of error codes.
    ///    
    HRESULT SetConcludePriorityComparison(IUIAnimationPriorityComparison2 comparison);
    ///Sets the default acceptable animation delay. This is the length of time that may pass before storyboards begin.
    ///Params:
    ///    delay = The default delay. This parameter can be a positive value, or UI_ANIMATION_SECONDS_EVENTUALLY (-1) to
    ///            indicate that any finite delay is acceptable.
    ///Returns:
    ///    Returns S_OK if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error Codes for a
    ///    list of error codes.
    ///    
    HRESULT SetDefaultLongestAcceptableDelay(double delay);
    ///Shuts down the animation manager and all its associated objects.
    ///Returns:
    ///    Returns S_OK if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error Codes for a
    ///    list of error codes.
    ///    
    HRESULT Shutdown();
}

///Defines an animation variable, which represents a visual element that can be animated in multiple dimensions.
@GUID("4914B304-96AB-44D9-9E77-D5109B7E7466")
interface IUIAnimationVariable2 : IUnknown
{
    ///Gets the number of dimensions that the animation variable is to be animated in.
    ///Params:
    ///    dimension = The number of dimensions.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetDimension(uint* dimension);
    ///Gets the value of the animation variable.
    ///Params:
    ///    value = The value of the animation variable.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetValue(double* value);
    ///Gets the value of the animation variable in the specified dimension.
    ///Params:
    ///    value = The value of the animation variable.
    ///    cDimension = The dimension from which to get the value of the animation variable.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetVectorValue(double* value, uint cDimension);
    ///Gets the animation curve of the animation variable.
    ///Params:
    ///    animation = The object that generates a sequence of animation curve primitives.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetCurve(IDCompositionAnimation animation);
    ///Gets the animation curve of the animation variable for the specified dimension.
    ///Params:
    ///    animation = The object that generates a sequence of animation curve primitives.
    ///    cDimension = The number of animation curves.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetVectorCurve(IDCompositionAnimation* animation, uint cDimension);
    ///Gets the final value of the animation variable. This is the value after all currently scheduled animations have
    ///completed.
    ///Params:
    ///    finalValue = The final value of the animation variable.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetFinalValue(double* finalValue);
    ///Gets the final value of the animation variable for the specified dimension. This is the value after all currently
    ///scheduled animations have completed.
    ///Params:
    ///    finalValue = The final value of the animation variable.
    ///    cDimension = The dimension from which to get the value of the animation variable.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetFinalVectorValue(double* finalValue, uint cDimension);
    ///Gets the previous value of the animation variable. This is the value of the animation variable before the most
    ///recent update.
    ///Params:
    ///    previousValue = The previous value of the animation variable.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetPreviousValue(double* previousValue);
    ///Gets the previous value of the animation variable for the specified dimension. This is the value of the animation
    ///variable before the most recent update.
    ///Params:
    ///    previousValue = The previous value of the animation variable.
    ///    cDimension = The dimension from which to get the value of the animation variable.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetPreviousVectorValue(double* previousValue, uint cDimension);
    ///Gets the integer value of the animation variable.
    ///Params:
    ///    value = The value of the animation variable as an integer.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetIntegerValue(int* value);
    ///Gets the integer value of the animation variable for the specified dimension.
    ///Params:
    ///    value = The value of the animation variable as an integer.
    ///    cDimension = The dimension from which to get the value of the animation variable.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetIntegerVectorValue(int* value, uint cDimension);
    ///Gets the final integer value of the animation variable. This is the value after all currently scheduled
    ///animations have completed.
    ///Params:
    ///    finalValue = The final value of the animation variable as an integer.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetFinalIntegerValue(int* finalValue);
    ///Gets the final integer value of the animation variable for the specified dimension. This is the value after all
    ///currently scheduled animations have completed.
    ///Params:
    ///    finalValue = The final value of the animation variable as an integer.
    ///    cDimension = The dimension from which to get the value of the animation variable.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetFinalIntegerVectorValue(int* finalValue, uint cDimension);
    ///Gets the previous integer value of the animation variable in the specified dimension. This is the value of the
    ///animation variable before the most recent update.
    ///Params:
    ///    previousValue = The previous value of the animation variable as an integer.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetPreviousIntegerValue(int* previousValue);
    ///Gets the previous integer value of the animation variable for the specified dimension. This is the value of the
    ///animation variable before the most recent update.
    ///Params:
    ///    previousValue = The previous value of the animation variable as an integer.
    ///    cDimension = The dimension from which to get the value of the animation variable.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetPreviousIntegerVectorValue(int* previousValue, uint cDimension);
    ///Gets the active storyboard for the animation variable.
    ///Params:
    ///    storyboard = The active storyboard, or NULL if the animation variable is not being animated.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetCurrentStoryboard(IUIAnimationStoryboard2* storyboard);
    ///Sets the lower bound (floor) for the value of the animation variable. The value of the animation variable should
    ///not fall below the specified value.
    ///Params:
    ///    bound = The lower bound for the value of the animation variable.
    ///Returns:
    ///    Returns S_OK if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error Codes for a
    ///    list of error codes.
    ///    
    HRESULT SetLowerBound(double bound);
    ///Sets the lower bound (floor) value of each specified dimension for the animation variable. The value of each
    ///animation variable should not fall below its lower bound.
    ///Params:
    ///    bound = A vector (of size <i>cDimension</i>) that contains the lower bound values of each dimension.
    ///    cDimension = The number of dimensions that require lower bound values. This parameter specifies the number of values
    ///                 listed in <i>bound</i>.
    ///Returns:
    ///    Returns S_OK if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error Codes for a
    ///    list of error codes.
    ///    
    HRESULT SetLowerBoundVector(const(double)* bound, uint cDimension);
    ///Sets the upper bound (ceiling) for the value of the animation variable. The value of the animation variable
    ///should not rise above the specified value.
    ///Params:
    ///    bound = The upper bound for the value of the animation variable.
    ///Returns:
    ///    Returns S_OK if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error Codes for a
    ///    list of error codes.
    ///    
    HRESULT SetUpperBound(double bound);
    ///Sets the upper bound (ceiling) value of each specified dimension for the animation variable. The value of each
    ///animation variable should not rise above its upper bound.
    ///Params:
    ///    bound = A vector (of size <i>cDimension</i>) that contains the upper bound values of each dimension.
    ///    cDimension = The number of dimensions that require upper bound values. This parameter specifies the number of values
    ///                 listed in <i>bound</i>.
    ///Returns:
    ///    Returns S_OK if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error Codes for a
    ///    list of error codes.
    ///    
    HRESULT SetUpperBoundVector(const(double)* bound, uint cDimension);
    ///Sets the rounding mode of the animation variable.
    ///Params:
    ///    mode = The rounding mode.
    ///Returns:
    ///    Returns S_OK if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error Codes for a
    ///    list of error codes.
    ///    
    HRESULT SetRoundingMode(UI_ANIMATION_ROUNDING_MODE mode);
    ///Sets the tag of the animation variable.
    ///Params:
    ///    object = The object portion of the tag. This parameter can be <b>NULL</b>.
    ///    id = The identifier portion of the tag.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error Codes
    ///    for a list of error codes.
    ///    
    HRESULT SetTag(IUnknown object, uint id);
    ///Gets the tag of the animation variable.
    ///Params:
    ///    object = The object portion of the tag.
    ///    id = The identifier portion of the tag.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetTag(IUnknown* object, uint* id);
    ///Specifies a handler for changes to the value of the animation variable.
    ///Params:
    ///    handler = The handler for changes to the value of the animation variable. This parameter can be <b>NULL</b>.
    ///    fRegisterForNextAnimationEvent = If <b>TRUE</b>, specifies that the EstimateNextEventTime method will incorporate <i>handler</i> into its
    ///                                     estimate of the time interval until the next animation event. No default value.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error Codes
    ///    for a list of error codes.
    ///    
    HRESULT SetVariableChangeHandler(IUIAnimationVariableChangeHandler2 handler, 
                                     BOOL fRegisterForNextAnimationEvent);
    ///Specifies a handler for changes to the integer value of the animation variable.
    ///Params:
    ///    handler = A pointer to the handler for changes to the integer value of the animation variable. This parameter can be
    ///              <b>NULL</b>.
    ///    fRegisterForNextAnimationEvent = If <b>TRUE</b>, specifies that the EstimateNextEventTime method will incorporate <i>handler</i> into its
    ///                                     estimate of the time interval until the next animation event. No default value.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error Codes
    ///    for a list of error codes.
    ///    
    HRESULT SetVariableIntegerChangeHandler(IUIAnimationVariableIntegerChangeHandler2 handler, 
                                            BOOL fRegisterForNextAnimationEvent);
    ///Specifies a handler for changes to the animation curve of the animation variable.
    ///Params:
    ///    handler = A pointer to the handler for changes to the animation curve of the animation variable. This parameter can be
    ///              <b>NULL</b>.
    ///Returns:
    ///    Returns S_OK if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error Codes for a
    ///    list of error codes.
    ///    
    HRESULT SetVariableCurveChangeHandler(IUIAnimationVariableCurveChangeHandler2 handler);
}

///Extends the IUIAnimationTransition interface that defines a transition. An <b>IUIAnimationTransition2</b> transition
///determines how an animation variable changes over time in a given dimension.
@GUID("62FF9123-A85A-4E9B-A218-435A93E268FD")
interface IUIAnimationTransition2 : IUnknown
{
    ///Gets the number of dimensions in which the animation variable has a transition specified.
    ///Params:
    ///    dimension = The number of dimensions.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetDimension(uint* dimension);
    ///Sets the initial value of the transition.
    ///Params:
    ///    value = The initial value for the transition.
    ///Returns:
    ///    Returns S_OK if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error Codes for a
    ///    list of error codes.
    ///    
    HRESULT SetInitialValue(double value);
    ///Sets the initial value of the transition for each specified dimension in the animation variable.
    ///Params:
    ///    value = A vector (of size <i>cDimension</i>) that contains the initial values for the transition.
    ///    cDimension = The number of dimensions that require transition values. This parameter specifies the number of values listed
    ///                 in <i>value</i>.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error Codes
    ///    for a list of error codes.
    ///    
    HRESULT SetInitialVectorValue(const(double)* value, uint cDimension);
    ///Sets the initial velocity of the transition.
    ///Params:
    ///    velocity = The initial velocity for the transition.
    ///Returns:
    ///    Returns S_OK if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error Codes for a
    ///    list of error codes.
    ///    
    HRESULT SetInitialVelocity(double velocity);
    ///Sets the initial velocity of the transition for each specified dimension in the animation variable.
    ///Params:
    ///    velocity = A vector (of size <i>cDimension</i>) that contains the initial velocities for the transition.
    ///    cDimension = The number of dimensions that require transition velocities. This parameter specifies the number of values
    ///                 listed in <i>velocity</i>.
    ///Returns:
    ///    Returns S_OK if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error Codes for a
    ///    list of error codes.
    ///    
    HRESULT SetInitialVectorVelocity(const(double)* velocity, uint cDimension);
    ///Determines whether the duration of a transition is known.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT IsDurationKnown();
    ///Gets the duration of the transition.
    ///Params:
    ///    duration = The duration of the transition, in seconds.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetDuration(double* duration);
}

///Defines a method for handling updates to an animation manager.
@GUID("F6E022BA-BFF3-42EC-9033-E073F33E83C3")
interface IUIAnimationManagerEventHandler2 : IUnknown
{
    ///Handles status changes to an animation manager.
    ///Params:
    ///    newStatus = The new status of the animation manager.
    ///    previousStatus = The previous status of the animation manager.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT OnManagerStatusChanged(UI_ANIMATION_MANAGER_STATUS newStatus, 
                                   UI_ANIMATION_MANAGER_STATUS previousStatus);
}

///Defines a method for handling animation variable update events. <b>IUIAnimationVariableChangeHandler2</b> handles
///events that occur in a specified dimension.
@GUID("63ACC8D2-6EAE-4BB0-B879-586DD8CFBE42")
interface IUIAnimationVariableChangeHandler2 : IUnknown
{
    ///Handles events that occur when the value of an animation variable changes in the specified dimension.
    ///Params:
    ///    storyboard = The storyboard that is animating the animation variable specified by the <i>variable</i> parameter.
    ///    variable = The animation variable that has been updated.
    ///    newValue = The new value of the animation variable.
    ///    previousValue = The previous value of the animation variable.
    ///    cDimension = The dimension in which the value of the animation variable changed.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT OnValueChanged(IUIAnimationStoryboard2 storyboard, IUIAnimationVariable2 variable, double* newValue, 
                           double* previousValue, uint cDimension);
}

///Defines a method for handling animation variable update events. <b>IUIAnimationVariableIntegerChangeHandler2</b>
///handles events that occur in a specified dimension.
@GUID("829B6CF1-4F3A-4412-AE09-B243EB4C6B58")
interface IUIAnimationVariableIntegerChangeHandler2 : IUnknown
{
    ///Handles events that occur when the integer value of an animation variable changes in the specified dimension.
    ///Params:
    ///    storyboard = The storyboard that is animating the animation variable specified by the <i>variable</i> parameter.
    ///    variable = The animation variable that has been updated.
    ///    newValue = The new integer value of the animation variable. <div class="alert"><b>Note</b> The rounding mode for an
    ///               animation variable is specified using the SetRoundingMode method.</div> <div> </div>
    ///    previousValue = The previous integer value of the animation variable. <div class="alert"><b>Note</b> The rounding mode for an
    ///                    animation variable is specified using the SetRoundingMode method.</div> <div> </div>
    ///    cDimension = The dimension in which the integer value of the animation variable changed.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT OnIntegerValueChanged(IUIAnimationStoryboard2 storyboard, IUIAnimationVariable2 variable, 
                                  int* newValue, int* previousValue, uint cDimension);
}

///Defines a method for handling animation curve update events.
@GUID("72895E91-0145-4C21-9192-5AAB40EDDF80")
interface IUIAnimationVariableCurveChangeHandler2 : IUnknown
{
    ///Handles events that occur when the animation curve of an animation variable changes.
    ///Params:
    ///    variable = The animation variable for which the animation curve has been updated.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT OnCurveChanged(IUIAnimationVariable2 variable);
}

///Defines methods for handling storyboard events.
@GUID("BAC5F55A-BA7C-414C-B599-FBF850F553C6")
interface IUIAnimationStoryboardEventHandler2 : IUnknown
{
    ///Handles storyboard status change events.
    ///Params:
    ///    storyboard = The storyboard for which the status has changed.
    ///    newStatus = The new status.
    ///    previousStatus = The previous status.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT OnStoryboardStatusChanged(IUIAnimationStoryboard2 storyboard, UI_ANIMATION_STORYBOARD_STATUS newStatus, 
                                      UI_ANIMATION_STORYBOARD_STATUS previousStatus);
    ///Handles storyboard update events.
    ///Params:
    ///    storyboard = The storyboard that has been updated.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT OnStoryboardUpdated(IUIAnimationStoryboard2 storyboard);
}

///Defines a method for handling storyboard loop iteration events.
@GUID("2D3B15A4-4762-47AB-A030-B23221DF3AE0")
interface IUIAnimationLoopIterationChangeHandler2 : IUnknown
{
    ///Handles loop iteration change events, which occur when a loop within a storyboard begins a new iteration.
    ///Params:
    ///    storyboard = The storyboard to which the loop belongs.
    ///    id = The loop ID.
    ///    newIterationCount = The iteration count for the latest IUIAnimationManager2::Update.
    ///    oldIterationCount = The iteration count for the previous IUIAnimationManager2::Update.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT OnLoopIterationChanged(IUIAnimationStoryboard2 storyboard, size_t id, uint newIterationCount, 
                                   uint oldIterationCount);
}

///Defines a method that resolves scheduling conflicts through priority comparison.
@GUID("5B6D7A37-4621-467C-8B05-70131DE62DDB")
interface IUIAnimationPriorityComparison2 : IUnknown
{
    ///Determines the relative priority between a scheduled storyboard and a new storyboard.
    ///Params:
    ///    scheduledStoryboard = The currently scheduled storyboard.
    ///    newStoryboard = The new storyboard that is interrupting the scheduled storyboard specified by <i>scheduledStoryboard</i>.
    ///    priorityEffect = The potential effect on <i>newStoryboard</i> if <i>scheduledStoryboard</i> has a higher priority.
    ///Returns:
    ///    Returns the following if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error
    ///    Codes for a list of error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> <i>newStoryboard</i> has priority. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%">
    ///    <i>scheduledStoryboard</i> has priority. </td> </tr> </table>
    ///    
    HRESULT HasPriority(IUIAnimationStoryboard2 scheduledStoryboard, IUIAnimationStoryboard2 newStoryboard, 
                        UI_ANIMATION_PRIORITY_EFFECT priorityEffect);
}

///Defines a library of standard transitions for a specified dimension.
@GUID("03CFAE53-9580-4EE3-B363-2ECE51B4AF6A")
interface IUIAnimationTransitionLibrary2 : IUnknown
{
    ///Creates an instantaneous scalar transition.
    ///Params:
    ///    finalValue = The value of the animation variable at the end of the transition.
    ///    transition = The new instantaneous transition.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateInstantaneousTransition(double finalValue, IUIAnimationTransition2* transition);
    ///Creates an instantaneous vector transition for each specified dimension.
    ///Params:
    ///    finalValue = A vector (of size <i>cDimension</i>) that contains the values of the animation variable at the end of the
    ///                 transition.
    ///    cDimension = The number of dimensions to apply the transition. This parameter specifies the number of values listed in
    ///                 <i>finalValue</i>.
    ///    transition = The new instantaneous transition.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateInstantaneousVectorTransition(const(double)* finalValue, uint cDimension, 
                                                IUIAnimationTransition2* transition);
    ///Creates a constant scalar transition.
    ///Params:
    ///    duration = The duration of the transition.
    ///    transition = The new constant transition.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateConstantTransition(double duration, IUIAnimationTransition2* transition);
    ///Creates a discrete scalar transition.
    ///Params:
    ///    delay = The amount of time by which to delay the instantaneous switch to the final value.
    ///    finalValue = The value of the animation variable at the end of the transition.
    ///    hold = The amount of time by which to hold the variable at its final value.
    ///    transition = The new discrete transition.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateDiscreteTransition(double delay, double finalValue, double hold, 
                                     IUIAnimationTransition2* transition);
    ///Creates a discrete vector transition for each specified dimension.
    ///Params:
    ///    delay = The amount of time by which to delay the instantaneous switch to the final value.
    ///    finalValue = A vector (of size <i>cDimension</i>) that contains the final values of the animation variable at the end of
    ///                 the transition.
    ///    cDimension = The number of dimensions to apply the transition. This parameter specifies the number of values listed in
    ///                 <i>finalValue</i>.
    ///    hold = The amount of time by which to hold the variable at its final value.
    ///    transition = The new discrete transition.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateDiscreteVectorTransition(double delay, const(double)* finalValue, uint cDimension, double hold, 
                                           IUIAnimationTransition2* transition);
    ///Creates a linear scalar transition.
    ///Params:
    ///    duration = The duration of the transition.
    ///    finalValue = The value of the animation variable at the end of the transition.
    ///    transition = The new linear transition.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateLinearTransition(double duration, double finalValue, IUIAnimationTransition2* transition);
    ///Creates a linear vector transition in the specified dimension.
    ///Params:
    ///    duration = The duration of the transition.
    ///    finalValue = A vector (of size <i>cDimension</i>) that contains the final values of the animation variable at the end of
    ///                 the transition.
    ///    cDimension = The number of dimensions to apply the transition. This parameter specifies the number of values listed in
    ///                 <i>finalValue</i>.
    ///    transition = The new linear transition.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateLinearVectorTransition(double duration, const(double)* finalValue, uint cDimension, 
                                         IUIAnimationTransition2* transition);
    ///Creates a linear-speed scalar transition.
    ///Params:
    ///    speed = The absolute value of the velocity in units/second.
    ///    finalValue = The value of the animation variable at the end of the transition.
    ///    transition = The new linear-speed transition.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateLinearTransitionFromSpeed(double speed, double finalValue, IUIAnimationTransition2* transition);
    ///Creates a linear-speed vector transition in the specified dimension.
    ///Params:
    ///    speed = The absolute value of the velocity in units/second.
    ///    finalValue = A vector (of size <i>cDimension</i>) that contains the final values of the animation variable at the end of
    ///                 the transition.
    ///    cDimension = The number of dimensions to apply the transition. This parameter specifies the number of values listed in
    ///                 <i>finalValue</i>.
    ///    transition = The new linear-speed transition.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateLinearVectorTransitionFromSpeed(double speed, const(double)* finalValue, uint cDimension, 
                                                  IUIAnimationTransition2* transition);
    ///Creates a sinusoidal scalar transition where amplitude is determined by initial velocity.
    ///Params:
    ///    duration = The duration of the transition.
    ///    period = The period of oscillation of the sinusoidal wave.
    ///    transition = The new sinusoidal-velocity transition.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateSinusoidalTransitionFromVelocity(double duration, double period, 
                                                   IUIAnimationTransition2* transition);
    ///Creates a sinusoidal-range scalar transition with a specified range of oscillation.
    ///Params:
    ///    duration = The duration of the transition.
    ///    minimumValue = The value of the animation variable at a trough of the sinusoidal wave.
    ///    maximumValue = The value of the animation variable at a peak of the sinusoidal wave.
    ///    period = The period of oscillation of the sinusoidal wave.
    ///    slope = The slope at the start of the transition.
    ///    transition = The new sinusoidal-range transition.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateSinusoidalTransitionFromRange(double duration, double minimumValue, double maximumValue, 
                                                double period, UI_ANIMATION_SLOPE slope, 
                                                IUIAnimationTransition2* transition);
    ///Creates an accelerate-decelerate scalar transition.
    ///Params:
    ///    duration = The duration of the transition.
    ///    finalValue = The value of the animation variable at the end of the transition.
    ///    accelerationRatio = The ratio of <i>duration</i> time spent accelerating (0 to 1).
    ///    decelerationRatio = The ratio of <i>duration</i> time spent decelerating (0 to 1).
    ///    transition = The new accelerate-decelerate transition.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateAccelerateDecelerateTransition(double duration, double finalValue, double accelerationRatio, 
                                                 double decelerationRatio, IUIAnimationTransition2* transition);
    ///Creates a reversal scalar transition.
    ///Params:
    ///    duration = The duration of the transition.
    ///    transition = The new reversal transition.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateReversalTransition(double duration, IUIAnimationTransition2* transition);
    ///Creates a cubic scalar transition.
    ///Params:
    ///    duration = The duration of the transition.
    ///    finalValue = The value of the animation variable at the end of the transition.
    ///    finalVelocity = The velocity of the variable at the end of the transition.
    ///    transition = The new cubic transition.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateCubicTransition(double duration, double finalValue, double finalVelocity, 
                                  IUIAnimationTransition2* transition);
    ///Creates a cubic vector transition for each specified dimension.
    ///Params:
    ///    duration = The duration of the transition.
    ///    finalValue = A vector (of size <i>cDimension</i>) that contains the final values of the animation variable at the end of
    ///                 the transition.
    ///    finalVelocity = A vector (of size <i>cDimension</i>) that contains the final velocities (in units per second) of the
    ///                    animation variable at the end of the transition.
    ///    cDimension = The number of dimensions to apply the transition. This parameter specifies the number of values listed in
    ///                 <i>finalValue</i> and <i>finalVelocity</i>.
    ///    transition = The new cubic transition.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateCubicVectorTransition(double duration, const(double)* finalValue, const(double)* finalVelocity, 
                                        uint cDimension, IUIAnimationTransition2* transition);
    ///Creates a smooth-stop scalar transition.
    ///Params:
    ///    maximumDuration = The maximum duration of the transition.
    ///    finalValue = The value of the animation variable at the end of the transition.
    ///    transition = The new smooth-stop transition.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateSmoothStopTransition(double maximumDuration, double finalValue, 
                                       IUIAnimationTransition2* transition);
    ///Creates a parabolic-acceleration scalar transition.
    ///Params:
    ///    finalValue = The value of the animation variable at the end of the transition.
    ///    finalVelocity = The velocity, in units/second, at the end of the transition.
    ///    acceleration = The acceleration, in units/second², during the transition.
    ///    transition = The new parabolic-acceleration transition.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateParabolicTransitionFromAcceleration(double finalValue, double finalVelocity, double acceleration, 
                                                      IUIAnimationTransition2* transition);
    ///Creates a cubic Bézier linear scalar transition.
    ///Params:
    ///    duration = The duration of the transition.
    ///    finalValue = The value of the animation variable at the end of the transition.
    ///    x1 = The x-coordinate of the first control point.
    ///    y1 = The y-coordinate of the first control point.
    ///    x2 = The x-coordinate of the second control point.
    ///    y2 = The y-coordinate of the second control point.
    ///    ppTransition = The new cubic Bézier linear transition.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateCubicBezierLinearTransition(double duration, double finalValue, double x1, double y1, double x2, 
                                              double y2, IUIAnimationTransition2* ppTransition);
    ///Creates a cubic Bézier linear vector transition for each specified dimension.
    ///Params:
    ///    duration = The duration of the transition.
    ///    finalValue = A vector (of size <i>cDimension</i>) that contains the final values of the animation variable at the end of
    ///                 the transition.
    ///    cDimension = The number of dimensions to apply the transition. This parameter specifies the number of values listed in
    ///                 <i>finalValue</i>.
    ///    x1 = The x-coordinate of the first control point.
    ///    y1 = The y-coordinate of the first control point.
    ///    x2 = The x-coordinate of the second control point.
    ///    y2 = The y-coordinate of the second control point.
    ///    ppTransition = The new cubic Bézier linear transition.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateCubicBezierLinearVectorTransition(double duration, const(double)* finalValue, uint cDimension, 
                                                    double x1, double y1, double x2, double y2, 
                                                    IUIAnimationTransition2* ppTransition);
}

///Defines a method that allows a custom interpolator to provide transition information, in the form of a cubic
///polynomial curve, to the animation manager.
@GUID("BAB20D63-4361-45DA-A24F-AB8508846B5B")
interface IUIAnimationPrimitiveInterpolation : IUnknown
{
    ///Adds a cubic polynomial segment that describes the shape of a transition curve to the animation function.
    ///Params:
    ///    dimension = The dimension in which to apply the new segment.
    ///    beginOffset = The begin offset for the segment, where 0 corresponds to the start of the transition.
    ///    constantCoefficient = The cubic polynomial constant coefficient.
    ///    linearCoefficient = The cubic polynomial linear coefficient.
    ///    quadraticCoefficient = The cubic polynomial quadratic coefficient.
    ///    cubicCoefficient = The cubic polynomial cubic coefficient.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT AddCubic(uint dimension, double beginOffset, float constantCoefficient, float linearCoefficient, 
                     float quadraticCoefficient, float cubicCoefficient);
    ///Adds a sinusoidal segment that describes the shape of a transition curve to the animation function.
    ///Params:
    ///    dimension = The dimension in which to apply the new segment.
    ///    beginOffset = The begin offset for the segment, where 0 corresponds to the start of the transition.
    ///    bias = The bias constant in the sinusoidal function.
    ///    amplitude = The amplitude constant in the sinusoidal function.
    ///    frequency = The frequency constant in the sinusoidal function.
    ///    phase = The phase constant in the sinusoidal function.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT AddSinusoidal(uint dimension, double beginOffset, float bias, float amplitude, float frequency, 
                          float phase);
}

///Extends the IUIAnimationInterpolator interface that defines methods for creating a custom interpolator.
///<b>IUIAnimationInterpolator2</b> supports interpolation in a given dimension.
@GUID("EA76AFF8-EA22-4A23-A0EF-A6A966703518")
interface IUIAnimationInterpolator2 : IUnknown
{
    ///Gets the number of dimensions that require interpolation.
    ///Params:
    ///    dimension = The number of dimensions.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetDimension(uint* dimension);
    ///Sets the initial value and velocity of the transition for the given dimension.
    ///Params:
    ///    initialValue = The initial value.
    ///    initialVelocity = The initial velocity.
    ///    cDimension = The dimension in which to set the initial value or velocity of the transition.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error Codes
    ///    for a list of error codes.
    ///    
    HRESULT SetInitialValueAndVelocity(double* initialValue, double* initialVelocity, uint cDimension);
    ///Sets the duration of the transition in the given dimension.
    ///Params:
    ///    duration = The duration of the transition.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error Codes
    ///    for a list of error codes.
    ///    
    HRESULT SetDuration(double duration);
    ///Gets the duration of a transition for the given dimension.
    ///Params:
    ///    duration = The duration of the transition.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetDuration(double* duration);
    ///Gets the final value at the end of the transition for the given dimension.
    ///Params:
    ///    value = The final value.
    ///    cDimension = The dimension from which to retrieve the final value.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetFinalValue(double* value, uint cDimension);
    ///Interpolates the value of an animation variable at the specified offset and for the given dimension.
    ///Params:
    ///    offset = The offset from the start of the transition. This parameter is always greater than or equal to zero and less
    ///             than the duration of the transition. This method is not called if the duration of the transition is zero.
    ///    value = The interpolated value.
    ///    cDimension = The dimension in which to interpolate the value.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT InterpolateValue(double offset, double* value, uint cDimension);
    ///Interpolates the velocity, or rate of change, at the specified offset for the given dimension.
    ///Params:
    ///    offset = The offset from the start of the transition. The offset is always greater than or equal to zero and less than
    ///             or equal to the duration of the transition. This method is not called if the duration of the transition is
    ///             zero.
    ///    velocity = The interpolated velocity.
    ///    cDimension = The dimension in which to interpolate the velocity.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT InterpolateVelocity(double offset, double* velocity, uint cDimension);
    ///Generates a primitive interpolation of the specified animation curve.
    ///Params:
    ///    interpolation = The object that defines the custom animation curve information.
    ///    cDimension = The dimension in which to apply the new segment.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetPrimitiveInterpolation(IUIAnimationPrimitiveInterpolation interpolation, uint cDimension);
    ///For the given dimension, <b>GetDependencies</b> retrieves the aspects of the interpolator that depend on the
    ///initial value or velocity that is passed to the IUIAnimationInterpolator2::SetInitialValueAndVelocity method or
    ///the duration that is passed to the IUIAnimationInterpolator2::SetDuration method.
    ///Params:
    ///    initialValueDependencies = Aspects of the interpolator that depend on the initial value passed to SetInitialValueAndVelocity.
    ///    initialVelocityDependencies = Aspects of the interpolator that depend on the initial velocity passed to SetInitialValueAndVelocity.
    ///    durationDependencies = Aspects of the interpolator that depend on the duration passed to SetDuration.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetDependencies(UI_ANIMATION_DEPENDENCIES* initialValueDependencies, 
                            UI_ANIMATION_DEPENDENCIES* initialVelocityDependencies, 
                            UI_ANIMATION_DEPENDENCIES* durationDependencies);
}

///Defines a method for creating transitions from custom interpolators. <b>IUIAnimationTransitionFactory2</b> supports
///the creation of transitions in a specified dimension.
@GUID("937D4916-C1A6-42D5-88D8-30344D6EFE31")
interface IUIAnimationTransitionFactory2 : IUnknown
{
    ///Creates a transition from a custom interpolator for a given dimension.
    ///Params:
    ///    interpolator = The interpolator from which a transition is to be created. The specified object must implement the
    ///                   IUIAnimationInterpolator2 interface.
    ///    transition = The new transition.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT CreateTransition(IUIAnimationInterpolator2 interpolator, IUIAnimationTransition2* transition);
}

///Defines a storyboard, which contains a group of transitions that are synchronized relative to one another.In this
///sectionTopicDescriptionAbandon MethodTerminates the storyboard, releases all related animation variables, and removes
///the storyboard from the schedule.AddKeyframeAfterTransition MethodAdds a keyframe at the end of the specified
///transition.AddKeyframeAtOffset MethodAdds a keyframe at the specified offset from an existing keyframe.AddTransition
///MethodAdds a transition to the storyboard.AddTransitionAtKeyframe MethodAdds a transition that starts at the
///specified keyframe.AddTransitionBetweenKeyframes MethodAdds a transition between two keyframes.Conclude
///MethodCompletes the current iteration of a keyframe loop that is in progress (where the loop is set to
///UI_ANIMATION_REPEAT_INDEFINITELY), terminates the loop, and continues with the storyboard. Finish MethodFinishes the
///storyboard within the specified time, compressing the storyboard if necessary.GetElapsedTime MethodGets the time that
///has elapsed since the storyboard started playing.GetStatus MethodGets the status of the storyboard.GetTag MethodGets
///the tag for a storyboard.HoldVariable MethodDirects the storyboard to hold the specified animation variable at its
///final value until the storyboard ends.RepeatBetweenKeyframes MethodCreates a loop between two keyframes.Schedule
///MethodDirects the storyboard to schedule itself for play.SetSkipDuration MethodSpecifies an offset from the beginning
///of a storyboard at which to start animating.SetLongestAcceptableDelay MethodSets the longest acceptable delay before
///the scheduled storyboard begins.SetStoryboardEventHandler MethodSpecifies a handler for storyboard events.SetTag
///MethodSets the tag for the storyboard. .
@GUID("AE289CD2-12D4-4945-9419-9E41BE034DF2")
interface IUIAnimationStoryboard2 : IUnknown
{
    ///Adds a transition to the storyboard.
    ///Params:
    ///    variable = The animation variable for which the transition is to be added.
    ///    transition = The transition to be added.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UI_E_TRANSITION_ALREADY_USED</b></dt> </dl> </td> <td width="60%"> This transition has already been
    ///    added to a storyboard. </td> </tr> </table> See Windows Animation Error Codes for a list of error codes.
    ///    
    HRESULT AddTransition(IUIAnimationVariable2 variable, IUIAnimationTransition2 transition);
    ///Adds a keyframe at the specified offset from an existing keyframe.
    ///Params:
    ///    existingKeyframe = The existing keyframe. To add a keyframe at an offset from the start of the storyboard, use the special
    ///                       keyframe UI_ANIMATION_KEYFRAME_STORYBOARD_START.
    ///    offset = The offset from the existing keyframe at which a new keyframe is to be added.
    ///    keyframe = The keyframe to be added.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT AddKeyframeAtOffset(UI_ANIMATION_KEYFRAME existingKeyframe, double offset, 
                                UI_ANIMATION_KEYFRAME* keyframe);
    ///Adds a keyframe at the end of the specified transition.
    ///Params:
    ///    transition = The transition after which a keyframe is to be added.
    ///    keyframe = The keyframe to be added.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UI_E_TRANSITION_NOT_IN_STORYBOARD</b></dt> </dl> </td> <td width="60%"> The transition has not been
    ///    added to the storyboard. </td> </tr> </table> See Windows Animation Error Codes for a list of error codes.
    ///    
    HRESULT AddKeyframeAfterTransition(IUIAnimationTransition2 transition, UI_ANIMATION_KEYFRAME* keyframe);
    ///Adds a transition that starts at the specified keyframe.
    ///Params:
    ///    variable = The animation variable for which a transition is to be added.
    ///    transition = The transition to be added.
    ///    startKeyframe = The keyframe that specifies the beginning of the new transition.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UI_E_TRANSITION_ALREADY_USED</b></dt> </dl> </td> <td width="60%"> This transition has already been
    ///    added to a storyboard or has been added to a storyboard that has finished playing and been released. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>UI_E_TRANSITION_ECLIPSED</b></dt> </dl> </td> <td width="60%"> The
    ///    transition might eclipse the beginning of another transition in the storyboard. </td> </tr> </table> See
    ///    Windows Animation Error Codes for a list of error codes.
    ///    
    HRESULT AddTransitionAtKeyframe(IUIAnimationVariable2 variable, IUIAnimationTransition2 transition, 
                                    UI_ANIMATION_KEYFRAME startKeyframe);
    ///Adds a transition between two keyframes.
    ///Params:
    ///    variable = The animation variable for which the transition is to be added.
    ///    transition = The transition to be added.
    ///    startKeyframe = A keyframe that specifies the beginning of the new transition.
    ///    endKeyframe = A keyframe that specifies the end of the new transition. It must not be possible for <i>endKeyframe</i> to
    ///                  appear earlier in the storyboard than <i>startKeyframe</i>.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UI_E_TRANSITION_ALREADY_USED</b></dt> </dl> </td> <td width="60%"> This transition has already been
    ///    added to a storyboard or has been added to a storyboard that has finished playing and been released. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>UI_E_TRANSITION_ECLIPSED</b></dt> </dl> </td> <td width="60%"> The
    ///    transition might eclipse the beginning of another transition in the storyboard. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>UI_E_START_KEYFRAME_AFTER_END</b></dt> </dl> </td> <td width="60%"> The start
    ///    keyframe might occur after the end keyframe. </td> </tr> </table> See Windows Animation Error Codes for a
    ///    list of error codes.
    ///    
    HRESULT AddTransitionBetweenKeyframes(IUIAnimationVariable2 variable, IUIAnimationTransition2 transition, 
                                          UI_ANIMATION_KEYFRAME startKeyframe, UI_ANIMATION_KEYFRAME endKeyframe);
    ///Creates a loop between two keyframes.
    ///Params:
    ///    startKeyframe = The keyframe at which the loop is to begin.
    ///    endKeyframe = The keyframe at which the loop is to end. <i>endKeyframe</i> must not occur earlier in the storyboard than
    ///                  <i>startKeyframe</i>.
    ///    cRepetition = The number of times the loop is to be repeated; the last iteration of a loop can terminate fractionally
    ///                  between keyframes. A value of zero indicates that the specified portion of a storyboard will not be played. A
    ///                  value of UI_ANIMATION_REPEAT_INDEFINITELY (-1) indicates that the loop will repeat indefinitely until the
    ///                  storyboard is trimmed or concluded.
    ///    repeatMode = The pattern for the loop iteration. A value of UI_ANIMATION_REPEAT_MODE_ALTERNATE (1) specifies that the
    ///                 start of the loop must alternate between keyframes (k1-&gt;k2, k2-&gt;k1, k1-&gt;k2, and so on). A value of
    ///                 UI_ANIMATION_REPEAT_MODE_NORMAL (0) specifies that the start of the loop must begin with the first keyframe
    ///                 (k1-&gt;k2, k1-&gt;k2, k1-&gt;k2, and so on). <div class="alert"><b>Note</b> If <i>repeatMode</i> has a value
    ///                 of UI_ANIMATION_REPEAT_MODE_ALTERNATE (1) and <i>cRepetition</i> has a value of
    ///                 UI_ANIMATION_REPEAT_INDEFINITELY (-1), the loop terminates on the end keyframe. </div> <div> </div>
    ///    pIterationChangeHandler = The handler for each loop iteration event. The default value is 0.
    ///    id = The loop ID to pass to <i>pIterationChangeHandler</i>. The default value is 0.
    ///    fRegisterForNextAnimationEvent = If true, specifies that <i>pIterationChangeHandler</i> will be incorporated into the estimate of the time
    ///                                     interval until the next animation event that is returned by the IUIAnimationManager2::EstimateNextEventTime
    ///                                     method. The default value is 0, or false.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT RepeatBetweenKeyframes(UI_ANIMATION_KEYFRAME startKeyframe, UI_ANIMATION_KEYFRAME endKeyframe, 
                                   double cRepetition, UI_ANIMATION_REPEAT_MODE repeatMode, 
                                   IUIAnimationLoopIterationChangeHandler2 pIterationChangeHandler, size_t id, 
                                   BOOL fRegisterForNextAnimationEvent);
    ///Directs the storyboard to hold the specified animation variable at its final value until the storyboard ends.
    ///Params:
    ///    variable = The animation variable.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT HoldVariable(IUIAnimationVariable2 variable);
    ///Sets the longest acceptable delay before the scheduled storyboard begins.
    ///Params:
    ///    delay = The longest acceptable delay. This parameter can be a positive value, or UI_ANIMATION_SECONDS_EVENTUALLY (-1)
    ///            to indicate that any finite delay is acceptable.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error Codes
    ///    for a list of error codes.
    ///    
    HRESULT SetLongestAcceptableDelay(double delay);
    ///Specifies an offset from the beginning of a storyboard at which to start animating.
    ///Params:
    ///    secondsDuration = The offset, or amount of time, to skip at the beginning of the storyboard.
    ///Returns:
    ///    Returns S_OK if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error Codes for a
    ///    list of error codes.
    ///    
    HRESULT SetSkipDuration(double secondsDuration);
    ///Directs the storyboard to schedule itself for play.
    ///Params:
    ///    timeNow = The current time.
    ///    schedulingResult = The result of the scheduling request. You can omit this parameter from calls to this method.
    ///Returns:
    ///    Returns S_OK if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error Codes for a
    ///    list of error codes.
    ///    
    HRESULT Schedule(double timeNow, UI_ANIMATION_SCHEDULING_RESULT* schedulingResult);
    ///Completes the current iteration of a keyframe loop that is in progress (where the loop is set to
    ///UI_ANIMATION_REPEAT_INDEFINITELY), terminates the loop, and continues with the storyboard.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT Conclude();
    ///Finishes the storyboard within the specified time, compressing the storyboard if necessary.
    ///Params:
    ///    completionDeadline = The maximum amount of time that the storyboard can use to finish playing.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT Finish(double completionDeadline);
    ///Terminates the storyboard, releases all related animation variables, and removes the storyboard from the
    ///schedule.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT Abandon();
    ///Sets the tag for the storyboard.
    ///Params:
    ///    object = The object portion of the tag. This parameter can be NULL.
    ///    id = The identifier portion of the tag.
    ///Returns:
    ///    Returns S_OK if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error Codes for a
    ///    list of error codes.
    ///    
    HRESULT SetTag(IUnknown object, uint id);
    ///Gets the tag for a storyboard.
    ///Params:
    ///    object = The object portion of the tag.
    ///    id = The identifier portion of the tag.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>UI_E_VALUE_NOT_SET</b></dt> </dl> </td> <td width="60%"> The storyboard tag
    ///    was not set. </td> </tr> </table>
    ///    
    HRESULT GetTag(IUnknown* object, uint* id);
    ///Gets the status of the storyboard.
    ///Params:
    ///    status = The storyboard status.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes.
    ///    
    HRESULT GetStatus(UI_ANIMATION_STORYBOARD_STATUS* status);
    ///Gets the time that has elapsed since the storyboard started playing.
    ///Params:
    ///    elapsedTime = The elapsed time.
    ///Returns:
    ///    If this method succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See Windows
    ///    Animation Error Codes for a list of error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>UI_E_STORYBOARD_NOT_PLAYING</b></dt> </dl> </td> <td width="60%"> The
    ///    storyboard is not playing. </td> </tr> </table>
    ///    
    HRESULT GetElapsedTime(double* elapsedTime);
    ///Specifies a handler for storyboard events.
    ///Params:
    ///    handler = The handler that Windows Animation should call whenever storyboard status and update events occur. The
    ///              specified object must implement the IUIAnimationStoryboardEventHandler2 interface or be <b>NULL</b>. See
    ///              Remarks for more info.
    ///    fRegisterStatusChangeForNextAnimationEvent = If <b>TRUE</b>, registers the OnStoryboardStatusChanged event and includes those events in
    ///                                                 IUIAnimationManager2::EstimateNextEventTime, which estimates the time interval until the next animation
    ///                                                 event. No default value.
    ///    fRegisterUpdateForNextAnimationEvent = If <b>TRUE</b>, registers the OnStoryboardUpdated event and includes those events in
    ///                                           IUIAnimationManager2::EstimateNextEventTime, which estimates the time interval until the next animation
    ///                                           event. No default value.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful; otherwise an <b>HRESULT</b> error code. See Windows Animation Error Codes
    ///    for a list of error codes.
    ///    
    HRESULT SetStoryboardEventHandler(IUIAnimationStoryboardEventHandler2 handler, 
                                      BOOL fRegisterStatusChangeForNextAnimationEvent, 
                                      BOOL fRegisterUpdateForNextAnimationEvent);
}


// GUIDs

const GUID CLSID_UIAnimationManager            = GUIDOF!UIAnimationManager;
const GUID CLSID_UIAnimationManager2           = GUIDOF!UIAnimationManager2;
const GUID CLSID_UIAnimationTimer              = GUIDOF!UIAnimationTimer;
const GUID CLSID_UIAnimationTransitionFactory  = GUIDOF!UIAnimationTransitionFactory;
const GUID CLSID_UIAnimationTransitionFactory2 = GUIDOF!UIAnimationTransitionFactory2;
const GUID CLSID_UIAnimationTransitionLibrary  = GUIDOF!UIAnimationTransitionLibrary;
const GUID CLSID_UIAnimationTransitionLibrary2 = GUIDOF!UIAnimationTransitionLibrary2;

const GUID IID_IUIAnimationInterpolator                  = GUIDOF!IUIAnimationInterpolator;
const GUID IID_IUIAnimationInterpolator2                 = GUIDOF!IUIAnimationInterpolator2;
const GUID IID_IUIAnimationLoopIterationChangeHandler2   = GUIDOF!IUIAnimationLoopIterationChangeHandler2;
const GUID IID_IUIAnimationManager                       = GUIDOF!IUIAnimationManager;
const GUID IID_IUIAnimationManager2                      = GUIDOF!IUIAnimationManager2;
const GUID IID_IUIAnimationManagerEventHandler           = GUIDOF!IUIAnimationManagerEventHandler;
const GUID IID_IUIAnimationManagerEventHandler2          = GUIDOF!IUIAnimationManagerEventHandler2;
const GUID IID_IUIAnimationPrimitiveInterpolation        = GUIDOF!IUIAnimationPrimitiveInterpolation;
const GUID IID_IUIAnimationPriorityComparison            = GUIDOF!IUIAnimationPriorityComparison;
const GUID IID_IUIAnimationPriorityComparison2           = GUIDOF!IUIAnimationPriorityComparison2;
const GUID IID_IUIAnimationStoryboard                    = GUIDOF!IUIAnimationStoryboard;
const GUID IID_IUIAnimationStoryboard2                   = GUIDOF!IUIAnimationStoryboard2;
const GUID IID_IUIAnimationStoryboardEventHandler        = GUIDOF!IUIAnimationStoryboardEventHandler;
const GUID IID_IUIAnimationStoryboardEventHandler2       = GUIDOF!IUIAnimationStoryboardEventHandler2;
const GUID IID_IUIAnimationTimer                         = GUIDOF!IUIAnimationTimer;
const GUID IID_IUIAnimationTimerClientEventHandler       = GUIDOF!IUIAnimationTimerClientEventHandler;
const GUID IID_IUIAnimationTimerEventHandler             = GUIDOF!IUIAnimationTimerEventHandler;
const GUID IID_IUIAnimationTimerUpdateHandler            = GUIDOF!IUIAnimationTimerUpdateHandler;
const GUID IID_IUIAnimationTransition                    = GUIDOF!IUIAnimationTransition;
const GUID IID_IUIAnimationTransition2                   = GUIDOF!IUIAnimationTransition2;
const GUID IID_IUIAnimationTransitionFactory             = GUIDOF!IUIAnimationTransitionFactory;
const GUID IID_IUIAnimationTransitionFactory2            = GUIDOF!IUIAnimationTransitionFactory2;
const GUID IID_IUIAnimationTransitionLibrary             = GUIDOF!IUIAnimationTransitionLibrary;
const GUID IID_IUIAnimationTransitionLibrary2            = GUIDOF!IUIAnimationTransitionLibrary2;
const GUID IID_IUIAnimationVariable                      = GUIDOF!IUIAnimationVariable;
const GUID IID_IUIAnimationVariable2                     = GUIDOF!IUIAnimationVariable2;
const GUID IID_IUIAnimationVariableChangeHandler         = GUIDOF!IUIAnimationVariableChangeHandler;
const GUID IID_IUIAnimationVariableChangeHandler2        = GUIDOF!IUIAnimationVariableChangeHandler2;
const GUID IID_IUIAnimationVariableCurveChangeHandler2   = GUIDOF!IUIAnimationVariableCurveChangeHandler2;
const GUID IID_IUIAnimationVariableIntegerChangeHandler  = GUIDOF!IUIAnimationVariableIntegerChangeHandler;
const GUID IID_IUIAnimationVariableIntegerChangeHandler2 = GUIDOF!IUIAnimationVariableIntegerChangeHandler2;
