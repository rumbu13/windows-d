module windows.uianimation;

public import windows.com;
public import windows.directcomposition;
public import windows.systemservices;

extern(Windows):

enum UI_ANIMATION_UPDATE_RESULT
{
    UI_ANIMATION_UPDATE_NO_CHANGE = 0,
    UI_ANIMATION_UPDATE_VARIABLES_CHANGED = 1,
}

enum UI_ANIMATION_MANAGER_STATUS
{
    UI_ANIMATION_MANAGER_IDLE = 0,
    UI_ANIMATION_MANAGER_BUSY = 1,
}

enum UI_ANIMATION_MODE
{
    UI_ANIMATION_MODE_DISABLED = 0,
    UI_ANIMATION_MODE_SYSTEM_DEFAULT = 1,
    UI_ANIMATION_MODE_ENABLED = 2,
}

enum UI_ANIMATION_REPEAT_MODE
{
    UI_ANIMATION_REPEAT_MODE_NORMAL = 0,
    UI_ANIMATION_REPEAT_MODE_ALTERNATE = 1,
}

const GUID IID_IUIAnimationManager = {0x9169896C, 0xAC8D, 0x4E7D, [0x94, 0xE5, 0x67, 0xFA, 0x4D, 0xC2, 0xF2, 0xE8]};
@GUID(0x9169896C, 0xAC8D, 0x4E7D, [0x94, 0xE5, 0x67, 0xFA, 0x4D, 0xC2, 0xF2, 0xE8]);
interface IUIAnimationManager : IUnknown
{
    HRESULT CreateAnimationVariable(double initialValue, IUIAnimationVariable* variable);
    HRESULT ScheduleTransition(IUIAnimationVariable variable, IUIAnimationTransition transition, double timeNow);
    HRESULT CreateStoryboard(IUIAnimationStoryboard* storyboard);
    HRESULT FinishAllStoryboards(double completionDeadline);
    HRESULT AbandonAllStoryboards();
    HRESULT Update(double timeNow, UI_ANIMATION_UPDATE_RESULT* updateResult);
    HRESULT GetVariableFromTag(IUnknown object, uint id, IUIAnimationVariable* variable);
    HRESULT GetStoryboardFromTag(IUnknown object, uint id, IUIAnimationStoryboard* storyboard);
    HRESULT GetStatus(UI_ANIMATION_MANAGER_STATUS* status);
    HRESULT SetAnimationMode(UI_ANIMATION_MODE mode);
    HRESULT Pause();
    HRESULT Resume();
    HRESULT SetManagerEventHandler(IUIAnimationManagerEventHandler handler);
    HRESULT SetCancelPriorityComparison(IUIAnimationPriorityComparison comparison);
    HRESULT SetTrimPriorityComparison(IUIAnimationPriorityComparison comparison);
    HRESULT SetCompressPriorityComparison(IUIAnimationPriorityComparison comparison);
    HRESULT SetConcludePriorityComparison(IUIAnimationPriorityComparison comparison);
    HRESULT SetDefaultLongestAcceptableDelay(double delay);
    HRESULT Shutdown();
}

enum UI_ANIMATION_ROUNDING_MODE
{
    UI_ANIMATION_ROUNDING_NEAREST = 0,
    UI_ANIMATION_ROUNDING_FLOOR = 1,
    UI_ANIMATION_ROUNDING_CEILING = 2,
}

const GUID IID_IUIAnimationVariable = {0x8CEEB155, 0x2849, 0x4CE5, [0x94, 0x48, 0x91, 0xFF, 0x70, 0xE1, 0xE4, 0xD9]};
@GUID(0x8CEEB155, 0x2849, 0x4CE5, [0x94, 0x48, 0x91, 0xFF, 0x70, 0xE1, 0xE4, 0xD9]);
interface IUIAnimationVariable : IUnknown
{
    HRESULT GetValue(double* value);
    HRESULT GetFinalValue(double* finalValue);
    HRESULT GetPreviousValue(double* previousValue);
    HRESULT GetIntegerValue(int* value);
    HRESULT GetFinalIntegerValue(int* finalValue);
    HRESULT GetPreviousIntegerValue(int* previousValue);
    HRESULT GetCurrentStoryboard(IUIAnimationStoryboard* storyboard);
    HRESULT SetLowerBound(double bound);
    HRESULT SetUpperBound(double bound);
    HRESULT SetRoundingMode(UI_ANIMATION_ROUNDING_MODE mode);
    HRESULT SetTag(IUnknown object, uint id);
    HRESULT GetTag(IUnknown* object, uint* id);
    HRESULT SetVariableChangeHandler(IUIAnimationVariableChangeHandler handler);
    HRESULT SetVariableIntegerChangeHandler(IUIAnimationVariableIntegerChangeHandler handler);
}

enum UI_ANIMATION_STORYBOARD_STATUS
{
    UI_ANIMATION_STORYBOARD_BUILDING = 0,
    UI_ANIMATION_STORYBOARD_SCHEDULED = 1,
    UI_ANIMATION_STORYBOARD_CANCELLED = 2,
    UI_ANIMATION_STORYBOARD_PLAYING = 3,
    UI_ANIMATION_STORYBOARD_TRUNCATED = 4,
    UI_ANIMATION_STORYBOARD_FINISHED = 5,
    UI_ANIMATION_STORYBOARD_READY = 6,
    UI_ANIMATION_STORYBOARD_INSUFFICIENT_PRIORITY = 7,
}

enum UI_ANIMATION_SCHEDULING_RESULT
{
    UI_ANIMATION_SCHEDULING_UNEXPECTED_FAILURE = 0,
    UI_ANIMATION_SCHEDULING_INSUFFICIENT_PRIORITY = 1,
    UI_ANIMATION_SCHEDULING_ALREADY_SCHEDULED = 2,
    UI_ANIMATION_SCHEDULING_SUCCEEDED = 3,
    UI_ANIMATION_SCHEDULING_DEFERRED = 4,
}

struct __MIDL___MIDL_itf_UIAnimation_0000_0002_0003
{
    int _;
}

const GUID IID_IUIAnimationStoryboard = {0xA8FF128F, 0x9BF9, 0x4AF1, [0x9E, 0x67, 0xE5, 0xE4, 0x10, 0xDE, 0xFB, 0x84]};
@GUID(0xA8FF128F, 0x9BF9, 0x4AF1, [0x9E, 0x67, 0xE5, 0xE4, 0x10, 0xDE, 0xFB, 0x84]);
interface IUIAnimationStoryboard : IUnknown
{
    HRESULT AddTransition(IUIAnimationVariable variable, IUIAnimationTransition transition);
    HRESULT AddKeyframeAtOffset(__MIDL___MIDL_itf_UIAnimation_0000_0002_0003* existingKeyframe, double offset, __MIDL___MIDL_itf_UIAnimation_0000_0002_0003** keyframe);
    HRESULT AddKeyframeAfterTransition(IUIAnimationTransition transition, __MIDL___MIDL_itf_UIAnimation_0000_0002_0003** keyframe);
    HRESULT AddTransitionAtKeyframe(IUIAnimationVariable variable, IUIAnimationTransition transition, __MIDL___MIDL_itf_UIAnimation_0000_0002_0003* startKeyframe);
    HRESULT AddTransitionBetweenKeyframes(IUIAnimationVariable variable, IUIAnimationTransition transition, __MIDL___MIDL_itf_UIAnimation_0000_0002_0003* startKeyframe, __MIDL___MIDL_itf_UIAnimation_0000_0002_0003* endKeyframe);
    HRESULT RepeatBetweenKeyframes(__MIDL___MIDL_itf_UIAnimation_0000_0002_0003* startKeyframe, __MIDL___MIDL_itf_UIAnimation_0000_0002_0003* endKeyframe, int repetitionCount);
    HRESULT HoldVariable(IUIAnimationVariable variable);
    HRESULT SetLongestAcceptableDelay(double delay);
    HRESULT Schedule(double timeNow, UI_ANIMATION_SCHEDULING_RESULT* schedulingResult);
    HRESULT Conclude();
    HRESULT Finish(double completionDeadline);
    HRESULT Abandon();
    HRESULT SetTag(IUnknown object, uint id);
    HRESULT GetTag(IUnknown* object, uint* id);
    HRESULT GetStatus(UI_ANIMATION_STORYBOARD_STATUS* status);
    HRESULT GetElapsedTime(double* elapsedTime);
    HRESULT SetStoryboardEventHandler(IUIAnimationStoryboardEventHandler handler);
}

const GUID IID_IUIAnimationTransition = {0xDC6CE252, 0xF731, 0x41CF, [0xB6, 0x10, 0x61, 0x4B, 0x6C, 0xA0, 0x49, 0xAD]};
@GUID(0xDC6CE252, 0xF731, 0x41CF, [0xB6, 0x10, 0x61, 0x4B, 0x6C, 0xA0, 0x49, 0xAD]);
interface IUIAnimationTransition : IUnknown
{
    HRESULT SetInitialValue(double value);
    HRESULT SetInitialVelocity(double velocity);
    HRESULT IsDurationKnown();
    HRESULT GetDuration(double* duration);
}

const GUID IID_IUIAnimationManagerEventHandler = {0x783321ED, 0x78A3, 0x4366, [0xB5, 0x74, 0x6A, 0xF6, 0x07, 0xA6, 0x47, 0x88]};
@GUID(0x783321ED, 0x78A3, 0x4366, [0xB5, 0x74, 0x6A, 0xF6, 0x07, 0xA6, 0x47, 0x88]);
interface IUIAnimationManagerEventHandler : IUnknown
{
    HRESULT OnManagerStatusChanged(UI_ANIMATION_MANAGER_STATUS newStatus, UI_ANIMATION_MANAGER_STATUS previousStatus);
}

const GUID IID_IUIAnimationVariableChangeHandler = {0x6358B7BA, 0x87D2, 0x42D5, [0xBF, 0x71, 0x82, 0xE9, 0x19, 0xDD, 0x58, 0x62]};
@GUID(0x6358B7BA, 0x87D2, 0x42D5, [0xBF, 0x71, 0x82, 0xE9, 0x19, 0xDD, 0x58, 0x62]);
interface IUIAnimationVariableChangeHandler : IUnknown
{
    HRESULT OnValueChanged(IUIAnimationStoryboard storyboard, IUIAnimationVariable variable, double newValue, double previousValue);
}

const GUID IID_IUIAnimationVariableIntegerChangeHandler = {0xBB3E1550, 0x356E, 0x44B0, [0x99, 0xDA, 0x85, 0xAC, 0x60, 0x17, 0x86, 0x5E]};
@GUID(0xBB3E1550, 0x356E, 0x44B0, [0x99, 0xDA, 0x85, 0xAC, 0x60, 0x17, 0x86, 0x5E]);
interface IUIAnimationVariableIntegerChangeHandler : IUnknown
{
    HRESULT OnIntegerValueChanged(IUIAnimationStoryboard storyboard, IUIAnimationVariable variable, int newValue, int previousValue);
}

const GUID IID_IUIAnimationStoryboardEventHandler = {0x3D5C9008, 0xEC7C, 0x4364, [0x9F, 0x8A, 0x9A, 0xF3, 0xC5, 0x8C, 0xBA, 0xE6]};
@GUID(0x3D5C9008, 0xEC7C, 0x4364, [0x9F, 0x8A, 0x9A, 0xF3, 0xC5, 0x8C, 0xBA, 0xE6]);
interface IUIAnimationStoryboardEventHandler : IUnknown
{
    HRESULT OnStoryboardStatusChanged(IUIAnimationStoryboard storyboard, UI_ANIMATION_STORYBOARD_STATUS newStatus, UI_ANIMATION_STORYBOARD_STATUS previousStatus);
    HRESULT OnStoryboardUpdated(IUIAnimationStoryboard storyboard);
}

enum UI_ANIMATION_PRIORITY_EFFECT
{
    UI_ANIMATION_PRIORITY_EFFECT_FAILURE = 0,
    UI_ANIMATION_PRIORITY_EFFECT_DELAY = 1,
}

const GUID IID_IUIAnimationPriorityComparison = {0x83FA9B74, 0x5F86, 0x4618, [0xBC, 0x6A, 0xA2, 0xFA, 0xC1, 0x9B, 0x3F, 0x44]};
@GUID(0x83FA9B74, 0x5F86, 0x4618, [0xBC, 0x6A, 0xA2, 0xFA, 0xC1, 0x9B, 0x3F, 0x44]);
interface IUIAnimationPriorityComparison : IUnknown
{
    HRESULT HasPriority(IUIAnimationStoryboard scheduledStoryboard, IUIAnimationStoryboard newStoryboard, UI_ANIMATION_PRIORITY_EFFECT priorityEffect);
}

enum UI_ANIMATION_SLOPE
{
    UI_ANIMATION_SLOPE_INCREASING = 0,
    UI_ANIMATION_SLOPE_DECREASING = 1,
}

const GUID IID_IUIAnimationTransitionLibrary = {0xCA5A14B1, 0xD24F, 0x48B8, [0x8F, 0xE4, 0xC7, 0x81, 0x69, 0xBA, 0x95, 0x4E]};
@GUID(0xCA5A14B1, 0xD24F, 0x48B8, [0x8F, 0xE4, 0xC7, 0x81, 0x69, 0xBA, 0x95, 0x4E]);
interface IUIAnimationTransitionLibrary : IUnknown
{
    HRESULT CreateInstantaneousTransition(double finalValue, IUIAnimationTransition* transition);
    HRESULT CreateConstantTransition(double duration, IUIAnimationTransition* transition);
    HRESULT CreateDiscreteTransition(double delay, double finalValue, double hold, IUIAnimationTransition* transition);
    HRESULT CreateLinearTransition(double duration, double finalValue, IUIAnimationTransition* transition);
    HRESULT CreateLinearTransitionFromSpeed(double speed, double finalValue, IUIAnimationTransition* transition);
    HRESULT CreateSinusoidalTransitionFromVelocity(double duration, double period, IUIAnimationTransition* transition);
    HRESULT CreateSinusoidalTransitionFromRange(double duration, double minimumValue, double maximumValue, double period, UI_ANIMATION_SLOPE slope, IUIAnimationTransition* transition);
    HRESULT CreateAccelerateDecelerateTransition(double duration, double finalValue, double accelerationRatio, double decelerationRatio, IUIAnimationTransition* transition);
    HRESULT CreateReversalTransition(double duration, IUIAnimationTransition* transition);
    HRESULT CreateCubicTransition(double duration, double finalValue, double finalVelocity, IUIAnimationTransition* transition);
    HRESULT CreateSmoothStopTransition(double maximumDuration, double finalValue, IUIAnimationTransition* transition);
    HRESULT CreateParabolicTransitionFromAcceleration(double finalValue, double finalVelocity, double acceleration, IUIAnimationTransition* transition);
}

enum UI_ANIMATION_DEPENDENCIES
{
    UI_ANIMATION_DEPENDENCY_NONE = 0,
    UI_ANIMATION_DEPENDENCY_INTERMEDIATE_VALUES = 1,
    UI_ANIMATION_DEPENDENCY_FINAL_VALUE = 2,
    UI_ANIMATION_DEPENDENCY_FINAL_VELOCITY = 4,
    UI_ANIMATION_DEPENDENCY_DURATION = 8,
}

const GUID IID_IUIAnimationInterpolator = {0x7815CBBA, 0xDDF7, 0x478C, [0xA4, 0x6C, 0x7B, 0x6C, 0x73, 0x8B, 0x79, 0x78]};
@GUID(0x7815CBBA, 0xDDF7, 0x478C, [0xA4, 0x6C, 0x7B, 0x6C, 0x73, 0x8B, 0x79, 0x78]);
interface IUIAnimationInterpolator : IUnknown
{
    HRESULT SetInitialValueAndVelocity(double initialValue, double initialVelocity);
    HRESULT SetDuration(double duration);
    HRESULT GetDuration(double* duration);
    HRESULT GetFinalValue(double* value);
    HRESULT InterpolateValue(double offset, double* value);
    HRESULT InterpolateVelocity(double offset, double* velocity);
    HRESULT GetDependencies(UI_ANIMATION_DEPENDENCIES* initialValueDependencies, UI_ANIMATION_DEPENDENCIES* initialVelocityDependencies, UI_ANIMATION_DEPENDENCIES* durationDependencies);
}

const GUID IID_IUIAnimationTransitionFactory = {0xFCD91E03, 0x3E3B, 0x45AD, [0xBB, 0xB1, 0x6D, 0xFC, 0x81, 0x53, 0x74, 0x3D]};
@GUID(0xFCD91E03, 0x3E3B, 0x45AD, [0xBB, 0xB1, 0x6D, 0xFC, 0x81, 0x53, 0x74, 0x3D]);
interface IUIAnimationTransitionFactory : IUnknown
{
    HRESULT CreateTransition(IUIAnimationInterpolator interpolator, IUIAnimationTransition* transition);
}

enum UI_ANIMATION_IDLE_BEHAVIOR
{
    UI_ANIMATION_IDLE_BEHAVIOR_CONTINUE = 0,
    UI_ANIMATION_IDLE_BEHAVIOR_DISABLE = 1,
}

const GUID IID_IUIAnimationTimer = {0x6B0EFAD1, 0xA053, 0x41D6, [0x90, 0x85, 0x33, 0xA6, 0x89, 0x14, 0x46, 0x65]};
@GUID(0x6B0EFAD1, 0xA053, 0x41D6, [0x90, 0x85, 0x33, 0xA6, 0x89, 0x14, 0x46, 0x65]);
interface IUIAnimationTimer : IUnknown
{
    HRESULT SetTimerUpdateHandler(IUIAnimationTimerUpdateHandler updateHandler, UI_ANIMATION_IDLE_BEHAVIOR idleBehavior);
    HRESULT SetTimerEventHandler(IUIAnimationTimerEventHandler handler);
    HRESULT Enable();
    HRESULT Disable();
    HRESULT IsEnabled();
    HRESULT GetTime(double* seconds);
    HRESULT SetFrameRateThreshold(uint framesPerSecond);
}

const GUID IID_IUIAnimationTimerUpdateHandler = {0x195509B7, 0x5D5E, 0x4E3E, [0xB2, 0x78, 0xEE, 0x37, 0x59, 0xB3, 0x67, 0xAD]};
@GUID(0x195509B7, 0x5D5E, 0x4E3E, [0xB2, 0x78, 0xEE, 0x37, 0x59, 0xB3, 0x67, 0xAD]);
interface IUIAnimationTimerUpdateHandler : IUnknown
{
    HRESULT OnUpdate(double timeNow, UI_ANIMATION_UPDATE_RESULT* result);
    HRESULT SetTimerClientEventHandler(IUIAnimationTimerClientEventHandler handler);
    HRESULT ClearTimerClientEventHandler();
}

enum UI_ANIMATION_TIMER_CLIENT_STATUS
{
    UI_ANIMATION_TIMER_CLIENT_IDLE = 0,
    UI_ANIMATION_TIMER_CLIENT_BUSY = 1,
}

const GUID IID_IUIAnimationTimerClientEventHandler = {0xBEDB4DB6, 0x94FA, 0x4BFB, [0xA4, 0x7F, 0xEF, 0x2D, 0x9E, 0x40, 0x8C, 0x25]};
@GUID(0xBEDB4DB6, 0x94FA, 0x4BFB, [0xA4, 0x7F, 0xEF, 0x2D, 0x9E, 0x40, 0x8C, 0x25]);
interface IUIAnimationTimerClientEventHandler : IUnknown
{
    HRESULT OnTimerClientStatusChanged(UI_ANIMATION_TIMER_CLIENT_STATUS newStatus, UI_ANIMATION_TIMER_CLIENT_STATUS previousStatus);
}

const GUID IID_IUIAnimationTimerEventHandler = {0x274A7DEA, 0xD771, 0x4095, [0xAB, 0xBD, 0x8D, 0xF7, 0xAB, 0xD2, 0x3C, 0xE3]};
@GUID(0x274A7DEA, 0xD771, 0x4095, [0xAB, 0xBD, 0x8D, 0xF7, 0xAB, 0xD2, 0x3C, 0xE3]);
interface IUIAnimationTimerEventHandler : IUnknown
{
    HRESULT OnPreUpdate();
    HRESULT OnPostUpdate();
    HRESULT OnRenderingTooSlow(uint framesPerSecond);
}

const GUID IID_IUIAnimationManager2 = {0xD8B6F7D4, 0x4109, 0x4D3F, [0xAC, 0xEE, 0x87, 0x99, 0x26, 0x96, 0x8C, 0xB1]};
@GUID(0xD8B6F7D4, 0x4109, 0x4D3F, [0xAC, 0xEE, 0x87, 0x99, 0x26, 0x96, 0x8C, 0xB1]);
interface IUIAnimationManager2 : IUnknown
{
    HRESULT CreateAnimationVectorVariable(char* initialValue, uint cDimension, IUIAnimationVariable2* variable);
    HRESULT CreateAnimationVariable(double initialValue, IUIAnimationVariable2* variable);
    HRESULT ScheduleTransition(IUIAnimationVariable2 variable, IUIAnimationTransition2 transition, double timeNow);
    HRESULT CreateStoryboard(IUIAnimationStoryboard2* storyboard);
    HRESULT FinishAllStoryboards(double completionDeadline);
    HRESULT AbandonAllStoryboards();
    HRESULT Update(double timeNow, UI_ANIMATION_UPDATE_RESULT* updateResult);
    HRESULT GetVariableFromTag(IUnknown object, uint id, IUIAnimationVariable2* variable);
    HRESULT GetStoryboardFromTag(IUnknown object, uint id, IUIAnimationStoryboard2* storyboard);
    HRESULT EstimateNextEventTime(double* seconds);
    HRESULT GetStatus(UI_ANIMATION_MANAGER_STATUS* status);
    HRESULT SetAnimationMode(UI_ANIMATION_MODE mode);
    HRESULT Pause();
    HRESULT Resume();
    HRESULT SetManagerEventHandler(IUIAnimationManagerEventHandler2 handler, BOOL fRegisterForNextAnimationEvent);
    HRESULT SetCancelPriorityComparison(IUIAnimationPriorityComparison2 comparison);
    HRESULT SetTrimPriorityComparison(IUIAnimationPriorityComparison2 comparison);
    HRESULT SetCompressPriorityComparison(IUIAnimationPriorityComparison2 comparison);
    HRESULT SetConcludePriorityComparison(IUIAnimationPriorityComparison2 comparison);
    HRESULT SetDefaultLongestAcceptableDelay(double delay);
    HRESULT Shutdown();
}

const GUID IID_IUIAnimationVariable2 = {0x4914B304, 0x96AB, 0x44D9, [0x9E, 0x77, 0xD5, 0x10, 0x9B, 0x7E, 0x74, 0x66]};
@GUID(0x4914B304, 0x96AB, 0x44D9, [0x9E, 0x77, 0xD5, 0x10, 0x9B, 0x7E, 0x74, 0x66]);
interface IUIAnimationVariable2 : IUnknown
{
    HRESULT GetDimension(uint* dimension);
    HRESULT GetValue(double* value);
    HRESULT GetVectorValue(char* value, uint cDimension);
    HRESULT GetCurve(IDCompositionAnimation animation);
    HRESULT GetVectorCurve(char* animation, uint cDimension);
    HRESULT GetFinalValue(double* finalValue);
    HRESULT GetFinalVectorValue(char* finalValue, uint cDimension);
    HRESULT GetPreviousValue(double* previousValue);
    HRESULT GetPreviousVectorValue(char* previousValue, uint cDimension);
    HRESULT GetIntegerValue(int* value);
    HRESULT GetIntegerVectorValue(char* value, uint cDimension);
    HRESULT GetFinalIntegerValue(int* finalValue);
    HRESULT GetFinalIntegerVectorValue(char* finalValue, uint cDimension);
    HRESULT GetPreviousIntegerValue(int* previousValue);
    HRESULT GetPreviousIntegerVectorValue(char* previousValue, uint cDimension);
    HRESULT GetCurrentStoryboard(IUIAnimationStoryboard2* storyboard);
    HRESULT SetLowerBound(double bound);
    HRESULT SetLowerBoundVector(char* bound, uint cDimension);
    HRESULT SetUpperBound(double bound);
    HRESULT SetUpperBoundVector(char* bound, uint cDimension);
    HRESULT SetRoundingMode(UI_ANIMATION_ROUNDING_MODE mode);
    HRESULT SetTag(IUnknown object, uint id);
    HRESULT GetTag(IUnknown* object, uint* id);
    HRESULT SetVariableChangeHandler(IUIAnimationVariableChangeHandler2 handler, BOOL fRegisterForNextAnimationEvent);
    HRESULT SetVariableIntegerChangeHandler(IUIAnimationVariableIntegerChangeHandler2 handler, BOOL fRegisterForNextAnimationEvent);
    HRESULT SetVariableCurveChangeHandler(IUIAnimationVariableCurveChangeHandler2 handler);
}

const GUID IID_IUIAnimationTransition2 = {0x62FF9123, 0xA85A, 0x4E9B, [0xA2, 0x18, 0x43, 0x5A, 0x93, 0xE2, 0x68, 0xFD]};
@GUID(0x62FF9123, 0xA85A, 0x4E9B, [0xA2, 0x18, 0x43, 0x5A, 0x93, 0xE2, 0x68, 0xFD]);
interface IUIAnimationTransition2 : IUnknown
{
    HRESULT GetDimension(uint* dimension);
    HRESULT SetInitialValue(double value);
    HRESULT SetInitialVectorValue(char* value, uint cDimension);
    HRESULT SetInitialVelocity(double velocity);
    HRESULT SetInitialVectorVelocity(char* velocity, uint cDimension);
    HRESULT IsDurationKnown();
    HRESULT GetDuration(double* duration);
}

const GUID IID_IUIAnimationManagerEventHandler2 = {0xF6E022BA, 0xBFF3, 0x42EC, [0x90, 0x33, 0xE0, 0x73, 0xF3, 0x3E, 0x83, 0xC3]};
@GUID(0xF6E022BA, 0xBFF3, 0x42EC, [0x90, 0x33, 0xE0, 0x73, 0xF3, 0x3E, 0x83, 0xC3]);
interface IUIAnimationManagerEventHandler2 : IUnknown
{
    HRESULT OnManagerStatusChanged(UI_ANIMATION_MANAGER_STATUS newStatus, UI_ANIMATION_MANAGER_STATUS previousStatus);
}

const GUID IID_IUIAnimationVariableChangeHandler2 = {0x63ACC8D2, 0x6EAE, 0x4BB0, [0xB8, 0x79, 0x58, 0x6D, 0xD8, 0xCF, 0xBE, 0x42]};
@GUID(0x63ACC8D2, 0x6EAE, 0x4BB0, [0xB8, 0x79, 0x58, 0x6D, 0xD8, 0xCF, 0xBE, 0x42]);
interface IUIAnimationVariableChangeHandler2 : IUnknown
{
    HRESULT OnValueChanged(IUIAnimationStoryboard2 storyboard, IUIAnimationVariable2 variable, char* newValue, char* previousValue, uint cDimension);
}

const GUID IID_IUIAnimationVariableIntegerChangeHandler2 = {0x829B6CF1, 0x4F3A, 0x4412, [0xAE, 0x09, 0xB2, 0x43, 0xEB, 0x4C, 0x6B, 0x58]};
@GUID(0x829B6CF1, 0x4F3A, 0x4412, [0xAE, 0x09, 0xB2, 0x43, 0xEB, 0x4C, 0x6B, 0x58]);
interface IUIAnimationVariableIntegerChangeHandler2 : IUnknown
{
    HRESULT OnIntegerValueChanged(IUIAnimationStoryboard2 storyboard, IUIAnimationVariable2 variable, char* newValue, char* previousValue, uint cDimension);
}

const GUID IID_IUIAnimationVariableCurveChangeHandler2 = {0x72895E91, 0x0145, 0x4C21, [0x91, 0x92, 0x5A, 0xAB, 0x40, 0xED, 0xDF, 0x80]};
@GUID(0x72895E91, 0x0145, 0x4C21, [0x91, 0x92, 0x5A, 0xAB, 0x40, 0xED, 0xDF, 0x80]);
interface IUIAnimationVariableCurveChangeHandler2 : IUnknown
{
    HRESULT OnCurveChanged(IUIAnimationVariable2 variable);
}

const GUID IID_IUIAnimationStoryboardEventHandler2 = {0xBAC5F55A, 0xBA7C, 0x414C, [0xB5, 0x99, 0xFB, 0xF8, 0x50, 0xF5, 0x53, 0xC6]};
@GUID(0xBAC5F55A, 0xBA7C, 0x414C, [0xB5, 0x99, 0xFB, 0xF8, 0x50, 0xF5, 0x53, 0xC6]);
interface IUIAnimationStoryboardEventHandler2 : IUnknown
{
    HRESULT OnStoryboardStatusChanged(IUIAnimationStoryboard2 storyboard, UI_ANIMATION_STORYBOARD_STATUS newStatus, UI_ANIMATION_STORYBOARD_STATUS previousStatus);
    HRESULT OnStoryboardUpdated(IUIAnimationStoryboard2 storyboard);
}

const GUID IID_IUIAnimationLoopIterationChangeHandler2 = {0x2D3B15A4, 0x4762, 0x47AB, [0xA0, 0x30, 0xB2, 0x32, 0x21, 0xDF, 0x3A, 0xE0]};
@GUID(0x2D3B15A4, 0x4762, 0x47AB, [0xA0, 0x30, 0xB2, 0x32, 0x21, 0xDF, 0x3A, 0xE0]);
interface IUIAnimationLoopIterationChangeHandler2 : IUnknown
{
    HRESULT OnLoopIterationChanged(IUIAnimationStoryboard2 storyboard, uint id, uint newIterationCount, uint oldIterationCount);
}

const GUID IID_IUIAnimationPriorityComparison2 = {0x5B6D7A37, 0x4621, 0x467C, [0x8B, 0x05, 0x70, 0x13, 0x1D, 0xE6, 0x2D, 0xDB]};
@GUID(0x5B6D7A37, 0x4621, 0x467C, [0x8B, 0x05, 0x70, 0x13, 0x1D, 0xE6, 0x2D, 0xDB]);
interface IUIAnimationPriorityComparison2 : IUnknown
{
    HRESULT HasPriority(IUIAnimationStoryboard2 scheduledStoryboard, IUIAnimationStoryboard2 newStoryboard, UI_ANIMATION_PRIORITY_EFFECT priorityEffect);
}

const GUID IID_IUIAnimationTransitionLibrary2 = {0x03CFAE53, 0x9580, 0x4EE3, [0xB3, 0x63, 0x2E, 0xCE, 0x51, 0xB4, 0xAF, 0x6A]};
@GUID(0x03CFAE53, 0x9580, 0x4EE3, [0xB3, 0x63, 0x2E, 0xCE, 0x51, 0xB4, 0xAF, 0x6A]);
interface IUIAnimationTransitionLibrary2 : IUnknown
{
    HRESULT CreateInstantaneousTransition(double finalValue, IUIAnimationTransition2* transition);
    HRESULT CreateInstantaneousVectorTransition(char* finalValue, uint cDimension, IUIAnimationTransition2* transition);
    HRESULT CreateConstantTransition(double duration, IUIAnimationTransition2* transition);
    HRESULT CreateDiscreteTransition(double delay, double finalValue, double hold, IUIAnimationTransition2* transition);
    HRESULT CreateDiscreteVectorTransition(double delay, char* finalValue, uint cDimension, double hold, IUIAnimationTransition2* transition);
    HRESULT CreateLinearTransition(double duration, double finalValue, IUIAnimationTransition2* transition);
    HRESULT CreateLinearVectorTransition(double duration, char* finalValue, uint cDimension, IUIAnimationTransition2* transition);
    HRESULT CreateLinearTransitionFromSpeed(double speed, double finalValue, IUIAnimationTransition2* transition);
    HRESULT CreateLinearVectorTransitionFromSpeed(double speed, char* finalValue, uint cDimension, IUIAnimationTransition2* transition);
    HRESULT CreateSinusoidalTransitionFromVelocity(double duration, double period, IUIAnimationTransition2* transition);
    HRESULT CreateSinusoidalTransitionFromRange(double duration, double minimumValue, double maximumValue, double period, UI_ANIMATION_SLOPE slope, IUIAnimationTransition2* transition);
    HRESULT CreateAccelerateDecelerateTransition(double duration, double finalValue, double accelerationRatio, double decelerationRatio, IUIAnimationTransition2* transition);
    HRESULT CreateReversalTransition(double duration, IUIAnimationTransition2* transition);
    HRESULT CreateCubicTransition(double duration, double finalValue, double finalVelocity, IUIAnimationTransition2* transition);
    HRESULT CreateCubicVectorTransition(double duration, char* finalValue, char* finalVelocity, uint cDimension, IUIAnimationTransition2* transition);
    HRESULT CreateSmoothStopTransition(double maximumDuration, double finalValue, IUIAnimationTransition2* transition);
    HRESULT CreateParabolicTransitionFromAcceleration(double finalValue, double finalVelocity, double acceleration, IUIAnimationTransition2* transition);
    HRESULT CreateCubicBezierLinearTransition(double duration, double finalValue, double x1, double y1, double x2, double y2, IUIAnimationTransition2* ppTransition);
    HRESULT CreateCubicBezierLinearVectorTransition(double duration, char* finalValue, uint cDimension, double x1, double y1, double x2, double y2, IUIAnimationTransition2* ppTransition);
}

const GUID IID_IUIAnimationPrimitiveInterpolation = {0xBAB20D63, 0x4361, 0x45DA, [0xA2, 0x4F, 0xAB, 0x85, 0x08, 0x84, 0x6B, 0x5B]};
@GUID(0xBAB20D63, 0x4361, 0x45DA, [0xA2, 0x4F, 0xAB, 0x85, 0x08, 0x84, 0x6B, 0x5B]);
interface IUIAnimationPrimitiveInterpolation : IUnknown
{
    HRESULT AddCubic(uint dimension, double beginOffset, float constantCoefficient, float linearCoefficient, float quadraticCoefficient, float cubicCoefficient);
    HRESULT AddSinusoidal(uint dimension, double beginOffset, float bias, float amplitude, float frequency, float phase);
}

const GUID IID_IUIAnimationInterpolator2 = {0xEA76AFF8, 0xEA22, 0x4A23, [0xA0, 0xEF, 0xA6, 0xA9, 0x66, 0x70, 0x35, 0x18]};
@GUID(0xEA76AFF8, 0xEA22, 0x4A23, [0xA0, 0xEF, 0xA6, 0xA9, 0x66, 0x70, 0x35, 0x18]);
interface IUIAnimationInterpolator2 : IUnknown
{
    HRESULT GetDimension(uint* dimension);
    HRESULT SetInitialValueAndVelocity(char* initialValue, char* initialVelocity, uint cDimension);
    HRESULT SetDuration(double duration);
    HRESULT GetDuration(double* duration);
    HRESULT GetFinalValue(char* value, uint cDimension);
    HRESULT InterpolateValue(double offset, char* value, uint cDimension);
    HRESULT InterpolateVelocity(double offset, char* velocity, uint cDimension);
    HRESULT GetPrimitiveInterpolation(IUIAnimationPrimitiveInterpolation interpolation, uint cDimension);
    HRESULT GetDependencies(UI_ANIMATION_DEPENDENCIES* initialValueDependencies, UI_ANIMATION_DEPENDENCIES* initialVelocityDependencies, UI_ANIMATION_DEPENDENCIES* durationDependencies);
}

const GUID IID_IUIAnimationTransitionFactory2 = {0x937D4916, 0xC1A6, 0x42D5, [0x88, 0xD8, 0x30, 0x34, 0x4D, 0x6E, 0xFE, 0x31]};
@GUID(0x937D4916, 0xC1A6, 0x42D5, [0x88, 0xD8, 0x30, 0x34, 0x4D, 0x6E, 0xFE, 0x31]);
interface IUIAnimationTransitionFactory2 : IUnknown
{
    HRESULT CreateTransition(IUIAnimationInterpolator2 interpolator, IUIAnimationTransition2* transition);
}

const GUID IID_IUIAnimationStoryboard2 = {0xAE289CD2, 0x12D4, 0x4945, [0x94, 0x19, 0x9E, 0x41, 0xBE, 0x03, 0x4D, 0xF2]};
@GUID(0xAE289CD2, 0x12D4, 0x4945, [0x94, 0x19, 0x9E, 0x41, 0xBE, 0x03, 0x4D, 0xF2]);
interface IUIAnimationStoryboard2 : IUnknown
{
    HRESULT AddTransition(IUIAnimationVariable2 variable, IUIAnimationTransition2 transition);
    HRESULT AddKeyframeAtOffset(__MIDL___MIDL_itf_UIAnimation_0000_0002_0003* existingKeyframe, double offset, __MIDL___MIDL_itf_UIAnimation_0000_0002_0003** keyframe);
    HRESULT AddKeyframeAfterTransition(IUIAnimationTransition2 transition, __MIDL___MIDL_itf_UIAnimation_0000_0002_0003** keyframe);
    HRESULT AddTransitionAtKeyframe(IUIAnimationVariable2 variable, IUIAnimationTransition2 transition, __MIDL___MIDL_itf_UIAnimation_0000_0002_0003* startKeyframe);
    HRESULT AddTransitionBetweenKeyframes(IUIAnimationVariable2 variable, IUIAnimationTransition2 transition, __MIDL___MIDL_itf_UIAnimation_0000_0002_0003* startKeyframe, __MIDL___MIDL_itf_UIAnimation_0000_0002_0003* endKeyframe);
    HRESULT RepeatBetweenKeyframes(__MIDL___MIDL_itf_UIAnimation_0000_0002_0003* startKeyframe, __MIDL___MIDL_itf_UIAnimation_0000_0002_0003* endKeyframe, double cRepetition, UI_ANIMATION_REPEAT_MODE repeatMode, IUIAnimationLoopIterationChangeHandler2 pIterationChangeHandler, uint id, BOOL fRegisterForNextAnimationEvent);
    HRESULT HoldVariable(IUIAnimationVariable2 variable);
    HRESULT SetLongestAcceptableDelay(double delay);
    HRESULT SetSkipDuration(double secondsDuration);
    HRESULT Schedule(double timeNow, UI_ANIMATION_SCHEDULING_RESULT* schedulingResult);
    HRESULT Conclude();
    HRESULT Finish(double completionDeadline);
    HRESULT Abandon();
    HRESULT SetTag(IUnknown object, uint id);
    HRESULT GetTag(IUnknown* object, uint* id);
    HRESULT GetStatus(UI_ANIMATION_STORYBOARD_STATUS* status);
    HRESULT GetElapsedTime(double* elapsedTime);
    HRESULT SetStoryboardEventHandler(IUIAnimationStoryboardEventHandler2 handler, BOOL fRegisterStatusChangeForNextAnimationEvent, BOOL fRegisterUpdateForNextAnimationEvent);
}

