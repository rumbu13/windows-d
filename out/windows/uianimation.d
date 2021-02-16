module windows.uianimation;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.directcomposition : IDCompositionAnimation;
public import windows.systemservices : BOOL;

extern(Windows):


// Enums


enum : int
{
    UI_ANIMATION_UPDATE_NO_CHANGE         = 0x00000000,
    UI_ANIMATION_UPDATE_VARIABLES_CHANGED = 0x00000001,
}
alias UI_ANIMATION_UPDATE_RESULT = int;

enum : int
{
    UI_ANIMATION_MANAGER_IDLE = 0x00000000,
    UI_ANIMATION_MANAGER_BUSY = 0x00000001,
}
alias UI_ANIMATION_MANAGER_STATUS = int;

enum : int
{
    UI_ANIMATION_MODE_DISABLED       = 0x00000000,
    UI_ANIMATION_MODE_SYSTEM_DEFAULT = 0x00000001,
    UI_ANIMATION_MODE_ENABLED        = 0x00000002,
}
alias UI_ANIMATION_MODE = int;

enum : int
{
    UI_ANIMATION_REPEAT_MODE_NORMAL    = 0x00000000,
    UI_ANIMATION_REPEAT_MODE_ALTERNATE = 0x00000001,
}
alias UI_ANIMATION_REPEAT_MODE = int;

enum : int
{
    UI_ANIMATION_ROUNDING_NEAREST = 0x00000000,
    UI_ANIMATION_ROUNDING_FLOOR   = 0x00000001,
    UI_ANIMATION_ROUNDING_CEILING = 0x00000002,
}
alias UI_ANIMATION_ROUNDING_MODE = int;

enum : int
{
    UI_ANIMATION_STORYBOARD_BUILDING              = 0x00000000,
    UI_ANIMATION_STORYBOARD_SCHEDULED             = 0x00000001,
    UI_ANIMATION_STORYBOARD_CANCELLED             = 0x00000002,
    UI_ANIMATION_STORYBOARD_PLAYING               = 0x00000003,
    UI_ANIMATION_STORYBOARD_TRUNCATED             = 0x00000004,
    UI_ANIMATION_STORYBOARD_FINISHED              = 0x00000005,
    UI_ANIMATION_STORYBOARD_READY                 = 0x00000006,
    UI_ANIMATION_STORYBOARD_INSUFFICIENT_PRIORITY = 0x00000007,
}
alias UI_ANIMATION_STORYBOARD_STATUS = int;

enum : int
{
    UI_ANIMATION_SCHEDULING_UNEXPECTED_FAILURE    = 0x00000000,
    UI_ANIMATION_SCHEDULING_INSUFFICIENT_PRIORITY = 0x00000001,
    UI_ANIMATION_SCHEDULING_ALREADY_SCHEDULED     = 0x00000002,
    UI_ANIMATION_SCHEDULING_SUCCEEDED             = 0x00000003,
    UI_ANIMATION_SCHEDULING_DEFERRED              = 0x00000004,
}
alias UI_ANIMATION_SCHEDULING_RESULT = int;

enum : int
{
    UI_ANIMATION_PRIORITY_EFFECT_FAILURE = 0x00000000,
    UI_ANIMATION_PRIORITY_EFFECT_DELAY   = 0x00000001,
}
alias UI_ANIMATION_PRIORITY_EFFECT = int;

enum : int
{
    UI_ANIMATION_SLOPE_INCREASING = 0x00000000,
    UI_ANIMATION_SLOPE_DECREASING = 0x00000001,
}
alias UI_ANIMATION_SLOPE = int;

enum : int
{
    UI_ANIMATION_DEPENDENCY_NONE                = 0x00000000,
    UI_ANIMATION_DEPENDENCY_INTERMEDIATE_VALUES = 0x00000001,
    UI_ANIMATION_DEPENDENCY_FINAL_VALUE         = 0x00000002,
    UI_ANIMATION_DEPENDENCY_FINAL_VELOCITY      = 0x00000004,
    UI_ANIMATION_DEPENDENCY_DURATION            = 0x00000008,
}
alias UI_ANIMATION_DEPENDENCIES = int;

enum : int
{
    UI_ANIMATION_IDLE_BEHAVIOR_CONTINUE = 0x00000000,
    UI_ANIMATION_IDLE_BEHAVIOR_DISABLE  = 0x00000001,
}
alias UI_ANIMATION_IDLE_BEHAVIOR = int;

enum : int
{
    UI_ANIMATION_TIMER_CLIENT_IDLE = 0x00000000,
    UI_ANIMATION_TIMER_CLIENT_BUSY = 0x00000001,
}
alias UI_ANIMATION_TIMER_CLIENT_STATUS = int;

// Structs


struct __MIDL___MIDL_itf_UIAnimation_0000_0002_0003
{
    int _;
}

// Interfaces

@GUID("9169896C-AC8D-4E7D-94E5-67FA4DC2F2E8")
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

@GUID("8CEEB155-2849-4CE5-9448-91FF70E1E4D9")
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

@GUID("A8FF128F-9BF9-4AF1-9E67-E5E410DEFB84")
interface IUIAnimationStoryboard : IUnknown
{
    HRESULT AddTransition(IUIAnimationVariable variable, IUIAnimationTransition transition);
    HRESULT AddKeyframeAtOffset(__MIDL___MIDL_itf_UIAnimation_0000_0002_0003* existingKeyframe, double offset, 
                                __MIDL___MIDL_itf_UIAnimation_0000_0002_0003** keyframe);
    HRESULT AddKeyframeAfterTransition(IUIAnimationTransition transition, 
                                       __MIDL___MIDL_itf_UIAnimation_0000_0002_0003** keyframe);
    HRESULT AddTransitionAtKeyframe(IUIAnimationVariable variable, IUIAnimationTransition transition, 
                                    __MIDL___MIDL_itf_UIAnimation_0000_0002_0003* startKeyframe);
    HRESULT AddTransitionBetweenKeyframes(IUIAnimationVariable variable, IUIAnimationTransition transition, 
                                          __MIDL___MIDL_itf_UIAnimation_0000_0002_0003* startKeyframe, 
                                          __MIDL___MIDL_itf_UIAnimation_0000_0002_0003* endKeyframe);
    HRESULT RepeatBetweenKeyframes(__MIDL___MIDL_itf_UIAnimation_0000_0002_0003* startKeyframe, 
                                   __MIDL___MIDL_itf_UIAnimation_0000_0002_0003* endKeyframe, int repetitionCount);
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

@GUID("DC6CE252-F731-41CF-B610-614B6CA049AD")
interface IUIAnimationTransition : IUnknown
{
    HRESULT SetInitialValue(double value);
    HRESULT SetInitialVelocity(double velocity);
    HRESULT IsDurationKnown();
    HRESULT GetDuration(double* duration);
}

@GUID("783321ED-78A3-4366-B574-6AF607A64788")
interface IUIAnimationManagerEventHandler : IUnknown
{
    HRESULT OnManagerStatusChanged(UI_ANIMATION_MANAGER_STATUS newStatus, 
                                   UI_ANIMATION_MANAGER_STATUS previousStatus);
}

@GUID("6358B7BA-87D2-42D5-BF71-82E919DD5862")
interface IUIAnimationVariableChangeHandler : IUnknown
{
    HRESULT OnValueChanged(IUIAnimationStoryboard storyboard, IUIAnimationVariable variable, double newValue, 
                           double previousValue);
}

@GUID("BB3E1550-356E-44B0-99DA-85AC6017865E")
interface IUIAnimationVariableIntegerChangeHandler : IUnknown
{
    HRESULT OnIntegerValueChanged(IUIAnimationStoryboard storyboard, IUIAnimationVariable variable, int newValue, 
                                  int previousValue);
}

@GUID("3D5C9008-EC7C-4364-9F8A-9AF3C58CBAE6")
interface IUIAnimationStoryboardEventHandler : IUnknown
{
    HRESULT OnStoryboardStatusChanged(IUIAnimationStoryboard storyboard, UI_ANIMATION_STORYBOARD_STATUS newStatus, 
                                      UI_ANIMATION_STORYBOARD_STATUS previousStatus);
    HRESULT OnStoryboardUpdated(IUIAnimationStoryboard storyboard);
}

@GUID("83FA9B74-5F86-4618-BC6A-A2FAC19B3F44")
interface IUIAnimationPriorityComparison : IUnknown
{
    HRESULT HasPriority(IUIAnimationStoryboard scheduledStoryboard, IUIAnimationStoryboard newStoryboard, 
                        UI_ANIMATION_PRIORITY_EFFECT priorityEffect);
}

@GUID("CA5A14B1-D24F-48B8-8FE4-C78169BA954E")
interface IUIAnimationTransitionLibrary : IUnknown
{
    HRESULT CreateInstantaneousTransition(double finalValue, IUIAnimationTransition* transition);
    HRESULT CreateConstantTransition(double duration, IUIAnimationTransition* transition);
    HRESULT CreateDiscreteTransition(double delay, double finalValue, double hold, 
                                     IUIAnimationTransition* transition);
    HRESULT CreateLinearTransition(double duration, double finalValue, IUIAnimationTransition* transition);
    HRESULT CreateLinearTransitionFromSpeed(double speed, double finalValue, IUIAnimationTransition* transition);
    HRESULT CreateSinusoidalTransitionFromVelocity(double duration, double period, 
                                                   IUIAnimationTransition* transition);
    HRESULT CreateSinusoidalTransitionFromRange(double duration, double minimumValue, double maximumValue, 
                                                double period, UI_ANIMATION_SLOPE slope, 
                                                IUIAnimationTransition* transition);
    HRESULT CreateAccelerateDecelerateTransition(double duration, double finalValue, double accelerationRatio, 
                                                 double decelerationRatio, IUIAnimationTransition* transition);
    HRESULT CreateReversalTransition(double duration, IUIAnimationTransition* transition);
    HRESULT CreateCubicTransition(double duration, double finalValue, double finalVelocity, 
                                  IUIAnimationTransition* transition);
    HRESULT CreateSmoothStopTransition(double maximumDuration, double finalValue, 
                                       IUIAnimationTransition* transition);
    HRESULT CreateParabolicTransitionFromAcceleration(double finalValue, double finalVelocity, double acceleration, 
                                                      IUIAnimationTransition* transition);
}

@GUID("7815CBBA-DDF7-478C-A46C-7B6C738B7978")
interface IUIAnimationInterpolator : IUnknown
{
    HRESULT SetInitialValueAndVelocity(double initialValue, double initialVelocity);
    HRESULT SetDuration(double duration);
    HRESULT GetDuration(double* duration);
    HRESULT GetFinalValue(double* value);
    HRESULT InterpolateValue(double offset, double* value);
    HRESULT InterpolateVelocity(double offset, double* velocity);
    HRESULT GetDependencies(UI_ANIMATION_DEPENDENCIES* initialValueDependencies, 
                            UI_ANIMATION_DEPENDENCIES* initialVelocityDependencies, 
                            UI_ANIMATION_DEPENDENCIES* durationDependencies);
}

@GUID("FCD91E03-3E3B-45AD-BBB1-6DFC8153743D")
interface IUIAnimationTransitionFactory : IUnknown
{
    HRESULT CreateTransition(IUIAnimationInterpolator interpolator, IUIAnimationTransition* transition);
}

@GUID("6B0EFAD1-A053-41D6-9085-33A689144665")
interface IUIAnimationTimer : IUnknown
{
    HRESULT SetTimerUpdateHandler(IUIAnimationTimerUpdateHandler updateHandler, 
                                  UI_ANIMATION_IDLE_BEHAVIOR idleBehavior);
    HRESULT SetTimerEventHandler(IUIAnimationTimerEventHandler handler);
    HRESULT Enable();
    HRESULT Disable();
    HRESULT IsEnabled();
    HRESULT GetTime(double* seconds);
    HRESULT SetFrameRateThreshold(uint framesPerSecond);
}

@GUID("195509B7-5D5E-4E3E-B278-EE3759B367AD")
interface IUIAnimationTimerUpdateHandler : IUnknown
{
    HRESULT OnUpdate(double timeNow, UI_ANIMATION_UPDATE_RESULT* result);
    HRESULT SetTimerClientEventHandler(IUIAnimationTimerClientEventHandler handler);
    HRESULT ClearTimerClientEventHandler();
}

@GUID("BEDB4DB6-94FA-4BFB-A47F-EF2D9E408C25")
interface IUIAnimationTimerClientEventHandler : IUnknown
{
    HRESULT OnTimerClientStatusChanged(UI_ANIMATION_TIMER_CLIENT_STATUS newStatus, 
                                       UI_ANIMATION_TIMER_CLIENT_STATUS previousStatus);
}

@GUID("274A7DEA-D771-4095-ABBD-8DF7ABD23CE3")
interface IUIAnimationTimerEventHandler : IUnknown
{
    HRESULT OnPreUpdate();
    HRESULT OnPostUpdate();
    HRESULT OnRenderingTooSlow(uint framesPerSecond);
}

@GUID("D8B6F7D4-4109-4D3F-ACEE-879926968CB1")
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

@GUID("4914B304-96AB-44D9-9E77-D5109B7E7466")
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
    HRESULT SetVariableChangeHandler(IUIAnimationVariableChangeHandler2 handler, 
                                     BOOL fRegisterForNextAnimationEvent);
    HRESULT SetVariableIntegerChangeHandler(IUIAnimationVariableIntegerChangeHandler2 handler, 
                                            BOOL fRegisterForNextAnimationEvent);
    HRESULT SetVariableCurveChangeHandler(IUIAnimationVariableCurveChangeHandler2 handler);
}

@GUID("62FF9123-A85A-4E9B-A218-435A93E268FD")
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

@GUID("F6E022BA-BFF3-42EC-9033-E073F33E83C3")
interface IUIAnimationManagerEventHandler2 : IUnknown
{
    HRESULT OnManagerStatusChanged(UI_ANIMATION_MANAGER_STATUS newStatus, 
                                   UI_ANIMATION_MANAGER_STATUS previousStatus);
}

@GUID("63ACC8D2-6EAE-4BB0-B879-586DD8CFBE42")
interface IUIAnimationVariableChangeHandler2 : IUnknown
{
    HRESULT OnValueChanged(IUIAnimationStoryboard2 storyboard, IUIAnimationVariable2 variable, char* newValue, 
                           char* previousValue, uint cDimension);
}

@GUID("829B6CF1-4F3A-4412-AE09-B243EB4C6B58")
interface IUIAnimationVariableIntegerChangeHandler2 : IUnknown
{
    HRESULT OnIntegerValueChanged(IUIAnimationStoryboard2 storyboard, IUIAnimationVariable2 variable, 
                                  char* newValue, char* previousValue, uint cDimension);
}

@GUID("72895E91-0145-4C21-9192-5AAB40EDDF80")
interface IUIAnimationVariableCurveChangeHandler2 : IUnknown
{
    HRESULT OnCurveChanged(IUIAnimationVariable2 variable);
}

@GUID("BAC5F55A-BA7C-414C-B599-FBF850F553C6")
interface IUIAnimationStoryboardEventHandler2 : IUnknown
{
    HRESULT OnStoryboardStatusChanged(IUIAnimationStoryboard2 storyboard, UI_ANIMATION_STORYBOARD_STATUS newStatus, 
                                      UI_ANIMATION_STORYBOARD_STATUS previousStatus);
    HRESULT OnStoryboardUpdated(IUIAnimationStoryboard2 storyboard);
}

@GUID("2D3B15A4-4762-47AB-A030-B23221DF3AE0")
interface IUIAnimationLoopIterationChangeHandler2 : IUnknown
{
    HRESULT OnLoopIterationChanged(IUIAnimationStoryboard2 storyboard, size_t id, uint newIterationCount, 
                                   uint oldIterationCount);
}

@GUID("5B6D7A37-4621-467C-8B05-70131DE62DDB")
interface IUIAnimationPriorityComparison2 : IUnknown
{
    HRESULT HasPriority(IUIAnimationStoryboard2 scheduledStoryboard, IUIAnimationStoryboard2 newStoryboard, 
                        UI_ANIMATION_PRIORITY_EFFECT priorityEffect);
}

@GUID("03CFAE53-9580-4EE3-B363-2ECE51B4AF6A")
interface IUIAnimationTransitionLibrary2 : IUnknown
{
    HRESULT CreateInstantaneousTransition(double finalValue, IUIAnimationTransition2* transition);
    HRESULT CreateInstantaneousVectorTransition(char* finalValue, uint cDimension, 
                                                IUIAnimationTransition2* transition);
    HRESULT CreateConstantTransition(double duration, IUIAnimationTransition2* transition);
    HRESULT CreateDiscreteTransition(double delay, double finalValue, double hold, 
                                     IUIAnimationTransition2* transition);
    HRESULT CreateDiscreteVectorTransition(double delay, char* finalValue, uint cDimension, double hold, 
                                           IUIAnimationTransition2* transition);
    HRESULT CreateLinearTransition(double duration, double finalValue, IUIAnimationTransition2* transition);
    HRESULT CreateLinearVectorTransition(double duration, char* finalValue, uint cDimension, 
                                         IUIAnimationTransition2* transition);
    HRESULT CreateLinearTransitionFromSpeed(double speed, double finalValue, IUIAnimationTransition2* transition);
    HRESULT CreateLinearVectorTransitionFromSpeed(double speed, char* finalValue, uint cDimension, 
                                                  IUIAnimationTransition2* transition);
    HRESULT CreateSinusoidalTransitionFromVelocity(double duration, double period, 
                                                   IUIAnimationTransition2* transition);
    HRESULT CreateSinusoidalTransitionFromRange(double duration, double minimumValue, double maximumValue, 
                                                double period, UI_ANIMATION_SLOPE slope, 
                                                IUIAnimationTransition2* transition);
    HRESULT CreateAccelerateDecelerateTransition(double duration, double finalValue, double accelerationRatio, 
                                                 double decelerationRatio, IUIAnimationTransition2* transition);
    HRESULT CreateReversalTransition(double duration, IUIAnimationTransition2* transition);
    HRESULT CreateCubicTransition(double duration, double finalValue, double finalVelocity, 
                                  IUIAnimationTransition2* transition);
    HRESULT CreateCubicVectorTransition(double duration, char* finalValue, char* finalVelocity, uint cDimension, 
                                        IUIAnimationTransition2* transition);
    HRESULT CreateSmoothStopTransition(double maximumDuration, double finalValue, 
                                       IUIAnimationTransition2* transition);
    HRESULT CreateParabolicTransitionFromAcceleration(double finalValue, double finalVelocity, double acceleration, 
                                                      IUIAnimationTransition2* transition);
    HRESULT CreateCubicBezierLinearTransition(double duration, double finalValue, double x1, double y1, double x2, 
                                              double y2, IUIAnimationTransition2* ppTransition);
    HRESULT CreateCubicBezierLinearVectorTransition(double duration, char* finalValue, uint cDimension, double x1, 
                                                    double y1, double x2, double y2, 
                                                    IUIAnimationTransition2* ppTransition);
}

@GUID("BAB20D63-4361-45DA-A24F-AB8508846B5B")
interface IUIAnimationPrimitiveInterpolation : IUnknown
{
    HRESULT AddCubic(uint dimension, double beginOffset, float constantCoefficient, float linearCoefficient, 
                     float quadraticCoefficient, float cubicCoefficient);
    HRESULT AddSinusoidal(uint dimension, double beginOffset, float bias, float amplitude, float frequency, 
                          float phase);
}

@GUID("EA76AFF8-EA22-4A23-A0EF-A6A966703518")
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
    HRESULT GetDependencies(UI_ANIMATION_DEPENDENCIES* initialValueDependencies, 
                            UI_ANIMATION_DEPENDENCIES* initialVelocityDependencies, 
                            UI_ANIMATION_DEPENDENCIES* durationDependencies);
}

@GUID("937D4916-C1A6-42D5-88D8-30344D6EFE31")
interface IUIAnimationTransitionFactory2 : IUnknown
{
    HRESULT CreateTransition(IUIAnimationInterpolator2 interpolator, IUIAnimationTransition2* transition);
}

@GUID("AE289CD2-12D4-4945-9419-9E41BE034DF2")
interface IUIAnimationStoryboard2 : IUnknown
{
    HRESULT AddTransition(IUIAnimationVariable2 variable, IUIAnimationTransition2 transition);
    HRESULT AddKeyframeAtOffset(__MIDL___MIDL_itf_UIAnimation_0000_0002_0003* existingKeyframe, double offset, 
                                __MIDL___MIDL_itf_UIAnimation_0000_0002_0003** keyframe);
    HRESULT AddKeyframeAfterTransition(IUIAnimationTransition2 transition, 
                                       __MIDL___MIDL_itf_UIAnimation_0000_0002_0003** keyframe);
    HRESULT AddTransitionAtKeyframe(IUIAnimationVariable2 variable, IUIAnimationTransition2 transition, 
                                    __MIDL___MIDL_itf_UIAnimation_0000_0002_0003* startKeyframe);
    HRESULT AddTransitionBetweenKeyframes(IUIAnimationVariable2 variable, IUIAnimationTransition2 transition, 
                                          __MIDL___MIDL_itf_UIAnimation_0000_0002_0003* startKeyframe, 
                                          __MIDL___MIDL_itf_UIAnimation_0000_0002_0003* endKeyframe);
    HRESULT RepeatBetweenKeyframes(__MIDL___MIDL_itf_UIAnimation_0000_0002_0003* startKeyframe, 
                                   __MIDL___MIDL_itf_UIAnimation_0000_0002_0003* endKeyframe, double cRepetition, 
                                   UI_ANIMATION_REPEAT_MODE repeatMode, 
                                   IUIAnimationLoopIterationChangeHandler2 pIterationChangeHandler, size_t id, 
                                   BOOL fRegisterForNextAnimationEvent);
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
    HRESULT SetStoryboardEventHandler(IUIAnimationStoryboardEventHandler2 handler, 
                                      BOOL fRegisterStatusChangeForNextAnimationEvent, 
                                      BOOL fRegisterUpdateForNextAnimationEvent);
}


// GUIDs


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
