module windows.interactioncontext;

public import windows.com;
public import windows.pointerinput;

extern(Windows):

enum INTERACTION_ID
{
    INTERACTION_ID_NONE = 0,
    INTERACTION_ID_MANIPULATION = 1,
    INTERACTION_ID_TAP = 2,
    INTERACTION_ID_SECONDARY_TAP = 3,
    INTERACTION_ID_HOLD = 4,
    INTERACTION_ID_DRAG = 5,
    INTERACTION_ID_CROSS_SLIDE = 6,
    INTERACTION_ID_MAX = -1,
}

enum INTERACTION_FLAGS
{
    INTERACTION_FLAG_NONE = 0,
    INTERACTION_FLAG_BEGIN = 1,
    INTERACTION_FLAG_END = 2,
    INTERACTION_FLAG_CANCEL = 4,
    INTERACTION_FLAG_INERTIA = 8,
    INTERACTION_FLAG_MAX = -1,
}

enum INTERACTION_CONFIGURATION_FLAGS
{
    INTERACTION_CONFIGURATION_FLAG_NONE = 0,
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION = 1,
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_TRANSLATION_X = 2,
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_TRANSLATION_Y = 4,
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_ROTATION = 8,
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_SCALING = 16,
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_TRANSLATION_INERTIA = 32,
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_ROTATION_INERTIA = 64,
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_SCALING_INERTIA = 128,
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_RAILS_X = 256,
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_RAILS_Y = 512,
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_EXACT = 1024,
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_MULTIPLE_FINGER_PANNING = 2048,
    INTERACTION_CONFIGURATION_FLAG_CROSS_SLIDE = 1,
    INTERACTION_CONFIGURATION_FLAG_CROSS_SLIDE_HORIZONTAL = 2,
    INTERACTION_CONFIGURATION_FLAG_CROSS_SLIDE_SELECT = 4,
    INTERACTION_CONFIGURATION_FLAG_CROSS_SLIDE_SPEED_BUMP = 8,
    INTERACTION_CONFIGURATION_FLAG_CROSS_SLIDE_REARRANGE = 16,
    INTERACTION_CONFIGURATION_FLAG_CROSS_SLIDE_EXACT = 32,
    INTERACTION_CONFIGURATION_FLAG_TAP = 1,
    INTERACTION_CONFIGURATION_FLAG_TAP_DOUBLE = 2,
    INTERACTION_CONFIGURATION_FLAG_TAP_MULTIPLE_FINGER = 4,
    INTERACTION_CONFIGURATION_FLAG_SECONDARY_TAP = 1,
    INTERACTION_CONFIGURATION_FLAG_HOLD = 1,
    INTERACTION_CONFIGURATION_FLAG_HOLD_MOUSE = 2,
    INTERACTION_CONFIGURATION_FLAG_HOLD_MULTIPLE_FINGER = 4,
    INTERACTION_CONFIGURATION_FLAG_DRAG = 1,
    INTERACTION_CONFIGURATION_FLAG_MAX = -1,
}

enum INERTIA_PARAMETER
{
    INERTIA_PARAMETER_TRANSLATION_DECELERATION = 1,
    INERTIA_PARAMETER_TRANSLATION_DISPLACEMENT = 2,
    INERTIA_PARAMETER_ROTATION_DECELERATION = 3,
    INERTIA_PARAMETER_ROTATION_ANGLE = 4,
    INERTIA_PARAMETER_EXPANSION_DECELERATION = 5,
    INERTIA_PARAMETER_EXPANSION_EXPANSION = 6,
    INERTIA_PARAMETER_MAX = -1,
}

enum INTERACTION_STATE
{
    INTERACTION_STATE_IDLE = 0,
    INTERACTION_STATE_IN_INTERACTION = 1,
    INTERACTION_STATE_POSSIBLE_DOUBLE_TAP = 2,
    INTERACTION_STATE_MAX = -1,
}

enum INTERACTION_CONTEXT_PROPERTY
{
    INTERACTION_CONTEXT_PROPERTY_MEASUREMENT_UNITS = 1,
    INTERACTION_CONTEXT_PROPERTY_INTERACTION_UI_FEEDBACK = 2,
    INTERACTION_CONTEXT_PROPERTY_FILTER_POINTERS = 3,
    INTERACTION_CONTEXT_PROPERTY_MAX = -1,
}

enum CROSS_SLIDE_THRESHOLD
{
    CROSS_SLIDE_THRESHOLD_SELECT_START = 0,
    CROSS_SLIDE_THRESHOLD_SPEED_BUMP_START = 1,
    CROSS_SLIDE_THRESHOLD_SPEED_BUMP_END = 2,
    CROSS_SLIDE_THRESHOLD_REARRANGE_START = 3,
    CROSS_SLIDE_THRESHOLD_COUNT = 4,
    CROSS_SLIDE_THRESHOLD_MAX = -1,
}

enum CROSS_SLIDE_FLAGS
{
    CROSS_SLIDE_FLAGS_NONE = 0,
    CROSS_SLIDE_FLAGS_SELECT = 1,
    CROSS_SLIDE_FLAGS_SPEED_BUMP = 2,
    CROSS_SLIDE_FLAGS_REARRANGE = 4,
    CROSS_SLIDE_FLAGS_MAX = -1,
}

enum MOUSE_WHEEL_PARAMETER
{
    MOUSE_WHEEL_PARAMETER_CHAR_TRANSLATION_X = 1,
    MOUSE_WHEEL_PARAMETER_CHAR_TRANSLATION_Y = 2,
    MOUSE_WHEEL_PARAMETER_DELTA_SCALE = 3,
    MOUSE_WHEEL_PARAMETER_DELTA_ROTATION = 4,
    MOUSE_WHEEL_PARAMETER_PAGE_TRANSLATION_X = 5,
    MOUSE_WHEEL_PARAMETER_PAGE_TRANSLATION_Y = 6,
    MOUSE_WHEEL_PARAMETER_MAX = -1,
}

enum TAP_PARAMETER
{
    TAP_PARAMETER_MIN_CONTACT_COUNT = 0,
    TAP_PARAMETER_MAX_CONTACT_COUNT = 1,
    TAP_PARAMETER_MAX = -1,
}

enum HOLD_PARAMETER
{
    HOLD_PARAMETER_MIN_CONTACT_COUNT = 0,
    HOLD_PARAMETER_MAX_CONTACT_COUNT = 1,
    HOLD_PARAMETER_THRESHOLD_RADIUS = 2,
    HOLD_PARAMETER_THRESHOLD_START_DELAY = 3,
    HOLD_PARAMETER_MAX = -1,
}

enum TRANSLATION_PARAMETER
{
    TRANSLATION_PARAMETER_MIN_CONTACT_COUNT = 0,
    TRANSLATION_PARAMETER_MAX_CONTACT_COUNT = 1,
    TRANSLATION_PARAMETER_MAX = -1,
}

enum MANIPULATION_RAILS_STATE
{
    MANIPULATION_RAILS_STATE_UNDECIDED = 0,
    MANIPULATION_RAILS_STATE_FREE = 1,
    MANIPULATION_RAILS_STATE_RAILED = 2,
    MANIPULATION_RAILS_STATE_MAX = -1,
}

struct MANIPULATION_TRANSFORM
{
    float translationX;
    float translationY;
    float scale;
    float expansion;
    float rotation;
}

struct MANIPULATION_VELOCITY
{
    float velocityX;
    float velocityY;
    float velocityExpansion;
    float velocityAngular;
}

struct INTERACTION_ARGUMENTS_MANIPULATION
{
    MANIPULATION_TRANSFORM delta;
    MANIPULATION_TRANSFORM cumulative;
    MANIPULATION_VELOCITY velocity;
    MANIPULATION_RAILS_STATE railsState;
}

struct INTERACTION_ARGUMENTS_TAP
{
    uint count;
}

struct INTERACTION_ARGUMENTS_CROSS_SLIDE
{
    CROSS_SLIDE_FLAGS flags;
}

struct INTERACTION_CONTEXT_OUTPUT
{
    INTERACTION_ID interactionId;
    INTERACTION_FLAGS interactionFlags;
    uint inputType;
    float x;
    float y;
    _arguments_e__Union arguments;
}

struct INTERACTION_CONTEXT_OUTPUT2
{
    INTERACTION_ID interactionId;
    INTERACTION_FLAGS interactionFlags;
    uint inputType;
    uint contactCount;
    uint currentContactCount;
    float x;
    float y;
    _arguments_e__Union arguments;
}

struct INTERACTION_CONTEXT_CONFIGURATION
{
    INTERACTION_ID interactionId;
    INTERACTION_CONFIGURATION_FLAGS enable;
}

struct CROSS_SLIDE_PARAMETER
{
    CROSS_SLIDE_THRESHOLD threshold;
    float distance;
}

alias INTERACTION_CONTEXT_OUTPUT_CALLBACK = extern(Windows) void function(void* clientData, const(INTERACTION_CONTEXT_OUTPUT)* output);
alias INTERACTION_CONTEXT_OUTPUT_CALLBACK2 = extern(Windows) void function(void* clientData, const(INTERACTION_CONTEXT_OUTPUT2)* output);
struct HINTERACTIONCONTEXT__
{
    int unused;
}

@DllImport("NInput.dll")
HRESULT CreateInteractionContext(HINTERACTIONCONTEXT__** interactionContext);

@DllImport("NInput.dll")
HRESULT DestroyInteractionContext(HINTERACTIONCONTEXT__* interactionContext);

@DllImport("NInput.dll")
HRESULT RegisterOutputCallbackInteractionContext(HINTERACTIONCONTEXT__* interactionContext, INTERACTION_CONTEXT_OUTPUT_CALLBACK outputCallback, void* clientData);

@DllImport("NInput.dll")
HRESULT RegisterOutputCallbackInteractionContext2(HINTERACTIONCONTEXT__* interactionContext, INTERACTION_CONTEXT_OUTPUT_CALLBACK2 outputCallback, void* clientData);

@DllImport("NInput.dll")
HRESULT SetInteractionConfigurationInteractionContext(HINTERACTIONCONTEXT__* interactionContext, uint configurationCount, char* configuration);

@DllImport("NInput.dll")
HRESULT GetInteractionConfigurationInteractionContext(HINTERACTIONCONTEXT__* interactionContext, uint configurationCount, char* configuration);

@DllImport("NInput.dll")
HRESULT SetPropertyInteractionContext(HINTERACTIONCONTEXT__* interactionContext, INTERACTION_CONTEXT_PROPERTY contextProperty, uint value);

@DllImport("NInput.dll")
HRESULT GetPropertyInteractionContext(HINTERACTIONCONTEXT__* interactionContext, INTERACTION_CONTEXT_PROPERTY contextProperty, uint* value);

@DllImport("NInput.dll")
HRESULT SetInertiaParameterInteractionContext(HINTERACTIONCONTEXT__* interactionContext, INERTIA_PARAMETER inertiaParameter, float value);

@DllImport("NInput.dll")
HRESULT GetInertiaParameterInteractionContext(HINTERACTIONCONTEXT__* interactionContext, INERTIA_PARAMETER inertiaParameter, float* value);

@DllImport("NInput.dll")
HRESULT SetCrossSlideParametersInteractionContext(HINTERACTIONCONTEXT__* interactionContext, uint parameterCount, char* crossSlideParameters);

@DllImport("NInput.dll")
HRESULT GetCrossSlideParameterInteractionContext(HINTERACTIONCONTEXT__* interactionContext, CROSS_SLIDE_THRESHOLD threshold, float* distance);

@DllImport("NInput.dll")
HRESULT SetTapParameterInteractionContext(HINTERACTIONCONTEXT__* interactionContext, TAP_PARAMETER parameter, float value);

@DllImport("NInput.dll")
HRESULT GetTapParameterInteractionContext(HINTERACTIONCONTEXT__* interactionContext, TAP_PARAMETER parameter, float* value);

@DllImport("NInput.dll")
HRESULT SetHoldParameterInteractionContext(HINTERACTIONCONTEXT__* interactionContext, HOLD_PARAMETER parameter, float value);

@DllImport("NInput.dll")
HRESULT GetHoldParameterInteractionContext(HINTERACTIONCONTEXT__* interactionContext, HOLD_PARAMETER parameter, float* value);

@DllImport("NInput.dll")
HRESULT SetTranslationParameterInteractionContext(HINTERACTIONCONTEXT__* interactionContext, TRANSLATION_PARAMETER parameter, float value);

@DllImport("NInput.dll")
HRESULT GetTranslationParameterInteractionContext(HINTERACTIONCONTEXT__* interactionContext, TRANSLATION_PARAMETER parameter, float* value);

@DllImport("NInput.dll")
HRESULT SetMouseWheelParameterInteractionContext(HINTERACTIONCONTEXT__* interactionContext, MOUSE_WHEEL_PARAMETER parameter, float value);

@DllImport("NInput.dll")
HRESULT GetMouseWheelParameterInteractionContext(HINTERACTIONCONTEXT__* interactionContext, MOUSE_WHEEL_PARAMETER parameter, float* value);

@DllImport("NInput.dll")
HRESULT ResetInteractionContext(HINTERACTIONCONTEXT__* interactionContext);

@DllImport("NInput.dll")
HRESULT GetStateInteractionContext(HINTERACTIONCONTEXT__* interactionContext, const(POINTER_INFO)* pointerInfo, INTERACTION_STATE* state);

@DllImport("NInput.dll")
HRESULT AddPointerInteractionContext(HINTERACTIONCONTEXT__* interactionContext, uint pointerId);

@DllImport("NInput.dll")
HRESULT RemovePointerInteractionContext(HINTERACTIONCONTEXT__* interactionContext, uint pointerId);

@DllImport("NInput.dll")
HRESULT ProcessPointerFramesInteractionContext(HINTERACTIONCONTEXT__* interactionContext, uint entriesCount, uint pointerCount, char* pointerInfo);

@DllImport("NInput.dll")
HRESULT BufferPointerPacketsInteractionContext(HINTERACTIONCONTEXT__* interactionContext, uint entriesCount, char* pointerInfo);

@DllImport("NInput.dll")
HRESULT ProcessBufferedPacketsInteractionContext(HINTERACTIONCONTEXT__* interactionContext);

@DllImport("NInput.dll")
HRESULT ProcessInertiaInteractionContext(HINTERACTIONCONTEXT__* interactionContext);

@DllImport("NInput.dll")
HRESULT StopInteractionContext(HINTERACTIONCONTEXT__* interactionContext);

@DllImport("NInput.dll")
HRESULT SetPivotInteractionContext(HINTERACTIONCONTEXT__* interactionContext, float x, float y, float radius);

