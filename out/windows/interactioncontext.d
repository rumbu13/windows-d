// Written in the D programming language.

module windows.interactioncontext;

public import windows.core;
public import windows.com : HRESULT;
public import windows.pointerinput : POINTER_INFO;

extern(Windows):


// Enums


///Specifies the interaction states used for configuring an Interaction Context object. Interactions can be static
///(single contact with no manipulation, such as tap, double tap, right tap, press and hold) or dynamic (one or more
///contacts with manipulation, such as translation, rotation, or scaling).
alias INTERACTION_ID = int;
enum : int
{
    ///Not used.
    INTERACTION_ID_NONE          = 0x00000000,
    ///A compound gesture that supports translation, rotation, and scaling (dynamic).
    INTERACTION_ID_MANIPULATION  = 0x00000001,
    ///A tap gesture (static).
    INTERACTION_ID_TAP           = 0x00000002,
    ///A right click gesture (static), regardless of input device. Typically used for displaying a context menu. <ul>
    ///<li>Right mouse button click</li> <li>Pen barrel button click</li> <li>Touch or pen press and hold</li> </ul>
    INTERACTION_ID_SECONDARY_TAP = 0x00000003,
    ///Press and hold gesture (static).
    INTERACTION_ID_HOLD          = 0x00000004,
    ///Move with mouse or pen (dynamic).
    INTERACTION_ID_DRAG          = 0x00000005,
    ///Select or move through slide or swipe gestures (dynamic).
    INTERACTION_ID_CROSS_SLIDE   = 0x00000006,
    ///Maximum number of interactions exceeded.
    INTERACTION_ID_MAX           = 0xffffffff,
}

///Specifies the state of an interaction.
alias INTERACTION_FLAGS = int;
enum : int
{
    ///No flags set.
    INTERACTION_FLAG_NONE    = 0x00000000,
    ///The beginning of an interaction.
    INTERACTION_FLAG_BEGIN   = 0x00000001,
    ///The end of an interaction (including inertia).
    INTERACTION_FLAG_END     = 0x00000002,
    ///Interaction canceled. INTERACTION_FLAG_END also set on cancel.
    INTERACTION_FLAG_CANCEL  = 0x00000004,
    ///Inertia being processed.
    INTERACTION_FLAG_INERTIA = 0x00000008,
    ///Maximum number of interactions exceeded.
    INTERACTION_FLAG_MAX     = 0xffffffff,
}

///Specifies the interactions to enable when configuring an Interaction Context object.
alias INTERACTION_CONFIGURATION_FLAGS = int;
enum : int
{
    ///No interactions enabled.
    INTERACTION_CONFIGURATION_FLAG_NONE                                 = 0x00000000,
    ///All manipulations enabled (move, rotate, and scale).
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION                         = 0x00000001,
    ///Translate (move) along the x-axis.
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_TRANSLATION_X           = 0x00000002,
    ///Translate (move) along the y-axis.
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_TRANSLATION_Y           = 0x00000004,
    ///Rotation.
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_ROTATION                = 0x00000008,
    ///Scaling.
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_SCALING                 = 0x00000010,
    ///Translation inertia (in direction of move) after contact lifted.
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_TRANSLATION_INERTIA     = 0x00000020,
    ///Rotation inertia after contact lifted.
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_ROTATION_INERTIA        = 0x00000040,
    ///Scaling inertia after contact lifted.
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_SCALING_INERTIA         = 0x00000080,
    ///Interactions are constrained along the x-axis. Rails indicate that slight motions off the primary axis of motion
    ///are ignored. This makes for a tighter experience for users; when they attempt to pan along a single axis, they
    ///are constrained to the axis.
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_RAILS_X                 = 0x00000100,
    ///Interactions are constrained along the y-axis. Rails indicate that slight motions off the primary axis of motion
    ///are ignored. This makes for a tighter experience for users; when they attempt to pan along a single axis, they
    ///are constrained to the axis.
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_RAILS_Y                 = 0x00000200,
    ///Report exact distance from initial contact to end of the interaction. By default, a small distance threshold is
    ///subtracted from the first manipulation delta reported by the system. This distance threshold is intended to
    ///account for slight movements of the contact when processing a tap gesture. If this flag is set, the distance
    ///threshold is not subtracted from the first delta.
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_EXACT                   = 0x00000400,
    INTERACTION_CONFIGURATION_FLAG_MANIPULATION_MULTIPLE_FINGER_PANNING = 0x00000800,
    ///All cross-slide interactions enabled.
    INTERACTION_CONFIGURATION_FLAG_CROSS_SLIDE                          = 0x00000001,
    ///Cross-slide along the x-axis.
    INTERACTION_CONFIGURATION_FLAG_CROSS_SLIDE_HORIZONTAL               = 0x00000002,
    ///Selection using cross-slide.
    INTERACTION_CONFIGURATION_FLAG_CROSS_SLIDE_SELECT                   = 0x00000004,
    ///Speed bump effect. A speed bump is a region in which the user experiences a slight drag (or friction) during the
    ///swipe or slide gesture.
    INTERACTION_CONFIGURATION_FLAG_CROSS_SLIDE_SPEED_BUMP               = 0x00000008,
    ///Rearrange using cross-slide.
    INTERACTION_CONFIGURATION_FLAG_CROSS_SLIDE_REARRANGE                = 0x00000010,
    ///Report exact distance from initial contact to end of the interaction. By default, a small distance threshold is
    ///subtracted from the first cross-slide delta reported by the system. This distance threshold is intended to
    ///account for slight movements of the contact when processing a tap gesture. If this flag is set, the distance
    ///threshold is not subtracted from the first delta.
    INTERACTION_CONFIGURATION_FLAG_CROSS_SLIDE_EXACT                    = 0x00000020,
    ///Tap.
    INTERACTION_CONFIGURATION_FLAG_TAP                                  = 0x00000001,
    ///Double tap.
    INTERACTION_CONFIGURATION_FLAG_TAP_DOUBLE                           = 0x00000002,
    INTERACTION_CONFIGURATION_FLAG_TAP_MULTIPLE_FINGER                  = 0x00000004,
    ///Secondary tap.
    INTERACTION_CONFIGURATION_FLAG_SECONDARY_TAP                        = 0x00000001,
    ///Hold.
    INTERACTION_CONFIGURATION_FLAG_HOLD                                 = 0x00000001,
    ///Hold with mouse.
    INTERACTION_CONFIGURATION_FLAG_HOLD_MOUSE                           = 0x00000002,
    INTERACTION_CONFIGURATION_FLAG_HOLD_MULTIPLE_FINGER                 = 0x00000004,
    ///Drag with mouse.
    INTERACTION_CONFIGURATION_FLAG_DRAG                                 = 0x00000001,
    ///Maximum number of interactions exceeded.
    INTERACTION_CONFIGURATION_FLAG_MAX                                  = 0xffffffff,
}

///Specifies the inertia values for a manipulation (translation, rotation, scaling).
alias INERTIA_PARAMETER = int;
enum : int
{
    ///The rate of deceleration, in degrees/ms².
    INERTIA_PARAMETER_TRANSLATION_DECELERATION = 0x00000001,
    ///The relative change in screen location, in DIPs.
    INERTIA_PARAMETER_TRANSLATION_DISPLACEMENT = 0x00000002,
    ///The rate of deceleration, in degrees/ms².
    INERTIA_PARAMETER_ROTATION_DECELERATION    = 0x00000003,
    ///The relative change in angle of rotation, in radians.
    INERTIA_PARAMETER_ROTATION_ANGLE           = 0x00000004,
    ///The rate of deceleration, in degrees/ms².
    INERTIA_PARAMETER_EXPANSION_DECELERATION   = 0x00000005,
    ///The relative change in size, in pixels.
    INERTIA_PARAMETER_EXPANSION_EXPANSION      = 0x00000006,
    ///Maximum number of interactions exceeded.
    INERTIA_PARAMETER_MAX                      = 0xffffffff,
}

///Specifies the state of the Interaction Context object.
alias INTERACTION_STATE = int;
enum : int
{
    ///There are no ongoing interactions and all transitional states (inertia, double tap) are complete. It is safe to
    ///reuse the Interaction Context object.
    INTERACTION_STATE_IDLE                = 0x00000000,
    ///There is an ongoing interaction. One or more contacts are detected, or inertia is in progress.
    INTERACTION_STATE_IN_INTERACTION      = 0x00000001,
    ///All contacts are lifted, but the time threshold for double tap has not been crossed.
    INTERACTION_STATE_POSSIBLE_DOUBLE_TAP = 0x00000002,
    ///Maximum number of interactions exceeded.
    INTERACTION_STATE_MAX                 = 0xffffffff,
}

///Specifies properties of the Interaction Context object.
alias INTERACTION_CONTEXT_PROPERTY = int;
enum : int
{
    ///Measurement units used by the Interaction Context object: himetric (0.01mm) or screen pixels.
    INTERACTION_CONTEXT_PROPERTY_MEASUREMENT_UNITS       = 0x00000001,
    ///UI feedback is provided.
    INTERACTION_CONTEXT_PROPERTY_INTERACTION_UI_FEEDBACK = 0x00000002,
    ///Pointer filtering is active.
    INTERACTION_CONTEXT_PROPERTY_FILTER_POINTERS         = 0x00000003,
    ///Maximum number of interactions exceeded.
    INTERACTION_CONTEXT_PROPERTY_MAX                     = 0xffffffff,
}

///Specifies the cross-slide behavior thresholds.
alias CROSS_SLIDE_THRESHOLD = int;
enum : int
{
    ///Selection start.
    CROSS_SLIDE_THRESHOLD_SELECT_START     = 0x00000000,
    ///Speed bump start.
    CROSS_SLIDE_THRESHOLD_SPEED_BUMP_START = 0x00000001,
    ///Speed bump end.
    CROSS_SLIDE_THRESHOLD_SPEED_BUMP_END   = 0x00000002,
    ///Rearrange (drag and drop) start.
    CROSS_SLIDE_THRESHOLD_REARRANGE_START  = 0x00000003,
    ///The number of thresholds specified.
    CROSS_SLIDE_THRESHOLD_COUNT            = 0x00000004,
    ///Maximum number of interactions exceeded.
    CROSS_SLIDE_THRESHOLD_MAX              = 0xffffffff,
}

///Specifies the state of the cross-slide interaction.
alias CROSS_SLIDE_FLAGS = int;
enum : int
{
    ///No cross-slide interaction.
    CROSS_SLIDE_FLAGS_NONE       = 0x00000000,
    ///Cross-slide interaction has crossed a distance threshold and is in select mode.
    CROSS_SLIDE_FLAGS_SELECT     = 0x00000001,
    ///Cross-slide interaction is in speed bump mode.
    CROSS_SLIDE_FLAGS_SPEED_BUMP = 0x00000002,
    ///Cross-slide interaction has crossed the speed bump threshold and is in rearrange (drag and drop) mode.
    CROSS_SLIDE_FLAGS_REARRANGE  = 0x00000004,
    ///Maximum number of interactions exceeded.
    CROSS_SLIDE_FLAGS_MAX        = 0xffffffff,
}

///Specifies the manipulations that can be mapped to mouse wheel rotation.
alias MOUSE_WHEEL_PARAMETER = int;
enum : int
{
    ///Scrolling/panning distance along the x-axis.
    MOUSE_WHEEL_PARAMETER_CHAR_TRANSLATION_X = 0x00000001,
    ///Scrolling/panning distance along the y-axis.
    MOUSE_WHEEL_PARAMETER_CHAR_TRANSLATION_Y = 0x00000002,
    ///The relative change in scale, as a multiplier, since the last input message.
    MOUSE_WHEEL_PARAMETER_DELTA_SCALE        = 0x00000003,
    ///The relative change in rotation, in radians, since the last input message.
    MOUSE_WHEEL_PARAMETER_DELTA_ROTATION     = 0x00000004,
    ///Paging distance along the x-axis.
    MOUSE_WHEEL_PARAMETER_PAGE_TRANSLATION_X = 0x00000005,
    ///Paging distance along the y-axis.
    MOUSE_WHEEL_PARAMETER_PAGE_TRANSLATION_Y = 0x00000006,
    ///Maximum number of interactions exceeded.
    MOUSE_WHEEL_PARAMETER_MAX                = 0xffffffff,
}

alias TAP_PARAMETER = int;
enum : int
{
    TAP_PARAMETER_MIN_CONTACT_COUNT = 0x00000000,
    TAP_PARAMETER_MAX_CONTACT_COUNT = 0x00000001,
    TAP_PARAMETER_MAX               = 0xffffffff,
}

alias HOLD_PARAMETER = int;
enum : int
{
    HOLD_PARAMETER_MIN_CONTACT_COUNT     = 0x00000000,
    HOLD_PARAMETER_MAX_CONTACT_COUNT     = 0x00000001,
    HOLD_PARAMETER_THRESHOLD_RADIUS      = 0x00000002,
    HOLD_PARAMETER_THRESHOLD_START_DELAY = 0x00000003,
    HOLD_PARAMETER_MAX                   = 0xffffffff,
}

alias TRANSLATION_PARAMETER = int;
enum : int
{
    TRANSLATION_PARAMETER_MIN_CONTACT_COUNT = 0x00000000,
    TRANSLATION_PARAMETER_MAX_CONTACT_COUNT = 0x00000001,
    TRANSLATION_PARAMETER_MAX               = 0xffffffff,
}

///Specifies the rail states for an interaction.
alias MANIPULATION_RAILS_STATE = int;
enum : int
{
    ///Rail state not defined yet.
    MANIPULATION_RAILS_STATE_UNDECIDED = 0x00000000,
    ///Interaction is not constrained to rail.
    MANIPULATION_RAILS_STATE_FREE      = 0x00000001,
    ///Interaction is constrained to rail.
    MANIPULATION_RAILS_STATE_RAILED    = 0x00000002,
    ///Maximum number of interactions exceeded.
    MANIPULATION_RAILS_STATE_MAX       = 0xffffffff,
}

// Callbacks

///Callback that receives events from an Interaction Context object.
///Params:
///    clientData = A pointer to an object that contains information about the client. The value typically points to the object for
///                 which the member function is called.
///    output = Output of the Interaction Context object.
alias INTERACTION_CONTEXT_OUTPUT_CALLBACK = void function(void* clientData, 
                                                          const(INTERACTION_CONTEXT_OUTPUT)* output);
alias INTERACTION_CONTEXT_OUTPUT_CALLBACK2 = void function(void* clientData, 
                                                           const(INTERACTION_CONTEXT_OUTPUT2)* output);

// Structs


///Defines the transformation data for a manipulation.
struct MANIPULATION_TRANSFORM
{
    ///Translation along the x-axis, in HIMETRIC units.
    float translationX;
    ///Translation along the y-axis, in HIMETRIC units.
    float translationY;
    ///Change in scale as a percentage, in HIMETRIC units.
    float scale;
    ///Expansion in user-defined coordinates, in HIMETRIC units.
    float expansion;
    ///Change in rotation, in radians.
    float rotation;
}

///Defines the velocity data of a manipulation.
struct MANIPULATION_VELOCITY
{
    ///The velocity along the x-axis.
    float velocityX;
    ///The velocity along the y-axis.
    float velocityY;
    ///The velocity expansion.
    float velocityExpansion;
    ///The angular velocity.
    float velocityAngular;
}

///Defines the state of a manipulation.
struct INTERACTION_ARGUMENTS_MANIPULATION
{
    ///The change in translation, rotation, and scale since the last INTERACTION_CONTEXT_OUTPUT_CALLBACK.
    MANIPULATION_TRANSFORM delta;
    ///The accumulated change in translation, rotation, and scale since the interaction started.
    MANIPULATION_TRANSFORM cumulative;
    ///The velocities of the accumulated transformations for the interaction.
    MANIPULATION_VELOCITY velocity;
    ///One of the constants from MANIPULATION_RAILS_STATE.
    MANIPULATION_RAILS_STATE railsState;
}

///Defines the state of the tap interaction.
struct INTERACTION_ARGUMENTS_TAP
{
    ///The number of taps detected.
    uint count;
}

///Defines the state of the cross-slide interaction.
struct INTERACTION_ARGUMENTS_CROSS_SLIDE
{
    ///One of the constants from CROSS_SLIDE_FLAGS.
    CROSS_SLIDE_FLAGS flags;
}

///Defines the output of the Interaction Context object.
struct INTERACTION_CONTEXT_OUTPUT
{
    ///ID of the Interaction Context object.
    INTERACTION_ID    interactionId;
    ///One of the constants from INTERACTION_FLAGS.
    INTERACTION_FLAGS interactionFlags;
    ///One of the constants from POINTER_INPUT_TYPE.
    uint              inputType;
    ///The x-coordinate of the input pointer, in HIMETRIC units.
    float             x;
    ///The y-coordinate of the input pointer, in HIMETRIC units.
    float             y;
    union arguments
    {
        INTERACTION_ARGUMENTS_MANIPULATION manipulation;
        INTERACTION_ARGUMENTS_TAP tap;
        INTERACTION_ARGUMENTS_CROSS_SLIDE crossSlide;
    }
}

struct INTERACTION_CONTEXT_OUTPUT2
{
    INTERACTION_ID    interactionId;
    INTERACTION_FLAGS interactionFlags;
    uint              inputType;
    uint              contactCount;
    uint              currentContactCount;
    float             x;
    float             y;
    union arguments
    {
        INTERACTION_ARGUMENTS_MANIPULATION manipulation;
        INTERACTION_ARGUMENTS_TAP tap;
        INTERACTION_ARGUMENTS_CROSS_SLIDE crossSlide;
    }
}

///Defines the configuration of an Interaction Context object that enables, disables, or modifies the behavior of an
///interaction.
struct INTERACTION_CONTEXT_CONFIGURATION
{
    ///One of the constants from INTERACTION_ID. <div class="alert"><b>Note</b> INTERACTION_FLAG_NONE is not a valid
    ///value.</div> <div> </div>
    INTERACTION_ID interactionId;
    ///The value of this property is a bitmask, which can be set to one or more of the values from
    ///INTERACTION_CONFIGURATION_FLAGS. This example shows the default setting for
    ///<b>INTERACTION_CONTEXT_CONFIGURATION</b>. ```cpp
    INTERACTION_CONFIGURATION_FLAGS enable;
}

///Defines the cross-slide threshold and its distance threshold.
struct CROSS_SLIDE_PARAMETER
{
    ///One of the constants from CROSS_SLIDE_THRESHOLD.
    CROSS_SLIDE_THRESHOLD threshold;
    ///The <i>threshold</i> distance, in DIPs.
    float distance;
}

struct HINTERACTIONCONTEXT__
{
    int unused;
}

// Functions

///Creates and initializes an Interaction Context object.
///Params:
///    interactionContext = Pointer to a handle for the Interaction Context.
///Returns:
///    If this function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
///    
@DllImport("NInput")
HRESULT CreateInteractionContext(HINTERACTIONCONTEXT__** interactionContext);

///Destroys the specified Interaction Context object.
///Params:
///    interactionContext = The handle of the interaction context.
///Returns:
///    If this function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
///    
@DllImport("NInput")
HRESULT DestroyInteractionContext(HINTERACTIONCONTEXT__* interactionContext);

///Registers a callback to receive interaction events from an Interaction Context object.
///Params:
///    interactionContext = Handle to the Interaction Context.
///    outputCallback = The callback function.
///    clientData = A pointer to an object that contains information about the client. The value typically points to the object for
///                 which the member function is called (<b>this</b>).
///Returns:
///    If this function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
///    
@DllImport("NInput")
HRESULT RegisterOutputCallbackInteractionContext(HINTERACTIONCONTEXT__* interactionContext, 
                                                 INTERACTION_CONTEXT_OUTPUT_CALLBACK outputCallback, 
                                                 void* clientData);

@DllImport("NInput")
HRESULT RegisterOutputCallbackInteractionContext2(HINTERACTIONCONTEXT__* interactionContext, 
                                                  INTERACTION_CONTEXT_OUTPUT_CALLBACK2 outputCallback, 
                                                  void* clientData);

///Configures the Interaction Context object to process the specified manipulations.
///Params:
///    interactionContext = The handle of the Interaction Context.
///    configurationCount = The number of interactions being configured.
///    configuration = The interactions to enable for this Interaction Context object.
///Returns:
///    If this function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
///    
@DllImport("NInput")
HRESULT SetInteractionConfigurationInteractionContext(HINTERACTIONCONTEXT__* interactionContext, 
                                                      uint configurationCount, char* configuration);

///Gets interaction configuration state for the Interaction Context object.
///Params:
///    interactionContext = Pointer to a handle for the Interaction Context.
///    configurationCount = Number of interaction configurations.
///    configuration = The interactions enabled for this Interaction Context object.
///Returns:
///    If this function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
///    
@DllImport("NInput")
HRESULT GetInteractionConfigurationInteractionContext(HINTERACTIONCONTEXT__* interactionContext, 
                                                      uint configurationCount, char* configuration);

///Sets Interaction Context object properties.
///Params:
///    interactionContext = Handle to the Interaction Context object.
///    contextProperty = One of the constants identified by INTERACTION_CONTEXT_PROPERTY.
///    value = The value of the constant identified by <i>contextProperty</i>.
///Returns:
///    If this function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
///    
@DllImport("NInput")
HRESULT SetPropertyInteractionContext(HINTERACTIONCONTEXT__* interactionContext, 
                                      INTERACTION_CONTEXT_PROPERTY contextProperty, uint value);

///Gets Interaction Context object properties.
///Params:
///    interactionContext = Handle to the Interaction Context object.
///    contextProperty = One of the constants identified by INTERACTION_CONTEXT_PROPERTY.
///    value = The value of the property. Valid values for <i>contextProperty</i> are: <table> <tr> <th>
///            INTERACTION_CONTEXT_PROPERTY_MEASUREMENT_UNITS </th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="INTERACTION_CONTEXT_PROPERTY_MEASUREMENT_UNITS_HIMETRIC"></a><a
///            id="interaction_context_property_measurement_units_himetric"></a><dl>
///            <dt><b>INTERACTION_CONTEXT_PROPERTY_MEASUREMENT_UNITS_HIMETRIC</b></dt> <dt>0</dt> </dl> </td> <td width="60%">
///            Measurement units are HIMETRIC units (0.01 mm). </td> </tr> <tr> <td width="40%"><a
///            id="INTERACTION_CONTEXT_PROPERTY_MEASUREMENT_UNITS_SCREEN"></a><a
///            id="interaction_context_property_measurement_units_screen"></a><dl>
///            <dt><b>INTERACTION_CONTEXT_PROPERTY_MEASUREMENT_UNITS_SCREEN</b></dt> <dt>1</dt> </dl> </td> <td width="60%">
///            Measurement units are screen pixels. This is the default value. </td> </tr> </table> <table> <tr> <th>
///            INTERACTION_CONTEXT_PROPERTY_UI_FEEDBACK </th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="INTERACTION_CONTEXT_PROPERTY_UI_FEEDBACK_OFF"></a><a
///            id="interaction_context_property_ui_feedback_off"></a><dl>
///            <dt><b>INTERACTION_CONTEXT_PROPERTY_UI_FEEDBACK_OFF</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> Visual
///            feedback for user interactions is disabled (the caller is responsible for displaying visual feedback). For more
///            info, see Input Feedback Configuration. </td> </tr> <tr> <td width="40%"><a
///            id="INTERACTION_CONTEXT_PROPERTY_UI_FEEDBACK_ON"></a><a id="interaction_context_property_ui_feedback_on"></a><dl>
///            <dt><b>INTERACTION_CONTEXT_PROPERTY_UI_FEEDBACK_ON</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Visual
///            feedback for user interactions is enabled. This is the default value. For more info, see Input Feedback
///            Configuration. </td> </tr> </table> <table> <tr> <th>INTERACTION_CONTEXT_PROPERTY_FILTER_POINTERS</th>
///            <th>Meaning</th> </tr> <tr> <td width="40%"><a id="INTERACTION_CONTEXT_PROPERTY_FILTER_POINTERS_OFF"></a><a
///            id="interaction_context_property_filter_pointers_off"></a><dl>
///            <dt><b>INTERACTION_CONTEXT_PROPERTY_FILTER_POINTERS_OFF</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> Pointer
///            filtering is disabled (all pointer input data is processed). </td> </tr> <tr> <td width="40%"><a
///            id="INTERACTION_CONTEXT_PROPERTY_FILTER_POINTERS_ON"></a><a
///            id="interaction_context_property_filter_pointers_on"></a><dl>
///            <dt><b>INTERACTION_CONTEXT_PROPERTY_FILTER_POINTERS_ON</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Pointer
///            filtering is enabled (only pointers specified through AddPointerInteractionContext are processed). This is the
///            default value. </td> </tr> </table>
///Returns:
///    If this function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
///    
@DllImport("NInput")
HRESULT GetPropertyInteractionContext(HINTERACTIONCONTEXT__* interactionContext, 
                                      INTERACTION_CONTEXT_PROPERTY contextProperty, uint* value);

///Configures the inertia behavior of a manipulation (translation, rotation, scaling) after the contact is lifted.
///Params:
///    interactionContext = The handle of the interaction context.
///    inertiaParameter = One of the constants from INERTIA_PARAMETER.
///    value = One of the following: <ul> <li>The rate of deceleration, in radians/ms².</li> <li>For translation, the relative
///            change in screen location, in HIMETRIC units.</li> <li>For rotation, the relative change in angle of rotation, in
///            radianx</li> <li>For scaling, the relative change in size, in HIMETRIC units.</li> </ul>
///Returns:
///    If this function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
///    
@DllImport("NInput")
HRESULT SetInertiaParameterInteractionContext(HINTERACTIONCONTEXT__* interactionContext, 
                                              INERTIA_PARAMETER inertiaParameter, float value);

///Gets the inertia behavior of a manipulation (translation, rotation, scaling).
///Params:
///    interactionContext = The handle of the interaction context.
///    inertiaParameter = One of the constants from INERTIA_PARAMETER.
///    value = The value of <i>inertiaParameter</i>. This value is one of the following: <ul> <li>The rate of deceleration, in
///            radians/ms².</li> <li>For translation, the relative change in screen location, in HIMETRIC units.</li> <li>For
///            rotation, the relative change in angle of rotation, in radians</li> <li>For scaling, the relative change in size,
///            in HIMETRIC units.</li> </ul>
///Returns:
///    If this function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
///    
@DllImport("NInput")
HRESULT GetInertiaParameterInteractionContext(HINTERACTIONCONTEXT__* interactionContext, 
                                              INERTIA_PARAMETER inertiaParameter, float* value);

///Configures the cross-slide interaction.
///Params:
///    interactionContext = The handle of the interaction context.
///    parameterCount = Number of parameters to set.
///    crossSlideParameters = The cross-slide threshold and its distance threshold.
///Returns:
///    If this function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
///    
@DllImport("NInput")
HRESULT SetCrossSlideParametersInteractionContext(HINTERACTIONCONTEXT__* interactionContext, uint parameterCount, 
                                                  char* crossSlideParameters);

///Gets the cross-slide interaction behavior.
///Params:
///    interactionContext = The handle of the interaction context.
///    threshold = One of the constants from CROSS_SLIDE_THRESHOLD.
///    distance = The distance threshold of <i>threshold</i>.
///Returns:
///    If this function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
///    
@DllImport("NInput")
HRESULT GetCrossSlideParameterInteractionContext(HINTERACTIONCONTEXT__* interactionContext, 
                                                 CROSS_SLIDE_THRESHOLD threshold, float* distance);

@DllImport("NInput")
HRESULT SetTapParameterInteractionContext(HINTERACTIONCONTEXT__* interactionContext, TAP_PARAMETER parameter, 
                                          float value);

@DllImport("NInput")
HRESULT GetTapParameterInteractionContext(HINTERACTIONCONTEXT__* interactionContext, TAP_PARAMETER parameter, 
                                          float* value);

@DllImport("NInput")
HRESULT SetHoldParameterInteractionContext(HINTERACTIONCONTEXT__* interactionContext, HOLD_PARAMETER parameter, 
                                           float value);

@DllImport("NInput")
HRESULT GetHoldParameterInteractionContext(HINTERACTIONCONTEXT__* interactionContext, HOLD_PARAMETER parameter, 
                                           float* value);

@DllImport("NInput")
HRESULT SetTranslationParameterInteractionContext(HINTERACTIONCONTEXT__* interactionContext, 
                                                  TRANSLATION_PARAMETER parameter, float value);

@DllImport("NInput")
HRESULT GetTranslationParameterInteractionContext(HINTERACTIONCONTEXT__* interactionContext, 
                                                  TRANSLATION_PARAMETER parameter, float* value);

///Sets the parameter values for mouse wheel input.
///Params:
///    interactionContext = Pointer to a handle for the Interaction Context.
///    value = The value for <i>parameter</i>.
///    parameter = One of the constants identified by MOUSE_WHEEL_PARAMETER.
///Returns:
///    If this function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
///    
@DllImport("NInput")
HRESULT SetMouseWheelParameterInteractionContext(HINTERACTIONCONTEXT__* interactionContext, 
                                                 MOUSE_WHEEL_PARAMETER parameter, float value);

///Gets the mouse wheel state for the Interaction Context object.
///Params:
///    interactionContext = Pointer to a handle for the Interaction Context.
///    value = The value of <i>parameter</i>.
///    parameter = One of the constants from MOUSE_WHEEL_PARAMETER.
///Returns:
///    If this function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
///    
@DllImport("NInput")
HRESULT GetMouseWheelParameterInteractionContext(HINTERACTIONCONTEXT__* interactionContext, 
                                                 MOUSE_WHEEL_PARAMETER parameter, float* value);

///Resets the interaction state, interaction configuration settings, and all parameters to their initial state. Current
///interactions are cancelled without notifications. Interaction Context must be reconfigured before next use.
///Params:
///    interactionContext = Pointer to a handle for the Interaction Context.
///Returns:
///    If this function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
///    
@DllImport("NInput")
HRESULT ResetInteractionContext(HINTERACTIONCONTEXT__* interactionContext);

///Gets current Interaction Context state and the time when the context will return to idle state.
///Params:
///    interactionContext = Pointer to a handle for the Interaction Context.
///    pointerInfo = Basic pointer information common to all pointer types.
///    state = One of the constants from INTERACTION_STATE.
///Returns:
///    If this function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
///    
@DllImport("NInput")
HRESULT GetStateInteractionContext(HINTERACTIONCONTEXT__* interactionContext, const(POINTER_INFO)* pointerInfo, 
                                   INTERACTION_STATE* state);

///Include the specified pointer in the set of pointers processed by the Interaction Context object.
///Params:
///    interactionContext = Handle to the Interaction Context object.
///    pointerId = ID of the pointer.
///Returns:
///    If this function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
///    
@DllImport("NInput")
HRESULT AddPointerInteractionContext(HINTERACTIONCONTEXT__* interactionContext, uint pointerId);

///Remove the specified pointer from the set of pointers processed by the Interaction Context object.
///Params:
///    interactionContext = Handle to the Interaction Context object.
///    pointerId = ID of the pointer.
///Returns:
///    If this function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
///    
@DllImport("NInput")
HRESULT RemovePointerInteractionContext(HINTERACTIONCONTEXT__* interactionContext, uint pointerId);

///Processes a set of pointer input frames.
///Params:
///    interactionContext = Pointer to a handle for the Interaction Context.
///    entriesCount = Number of frames to process.
///    pointerCount = Number of pointers in each frame.
///    pointerInfo = Pointer to the array of frames (of size <i>entriesCount</i>).
///Returns:
///    If this function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
///    
@DllImport("NInput")
HRESULT ProcessPointerFramesInteractionContext(HINTERACTIONCONTEXT__* interactionContext, uint entriesCount, 
                                               uint pointerCount, char* pointerInfo);

///Adds the history for a single input pointer to the buffer of the Interaction Context object.
///Params:
///    interactionContext = The handle of the interaction context.
///    entriesCount = The number of entries in the pointer history.
///    pointerInfo = Basic pointer information common to all pointer types.
///Returns:
///    If this function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
///    
@DllImport("NInput")
HRESULT BufferPointerPacketsInteractionContext(HINTERACTIONCONTEXT__* interactionContext, uint entriesCount, 
                                               char* pointerInfo);

///Process buffered packets at the end of a pointer input frame.
///Params:
///    interactionContext = Pointer to a handle for the Interaction Context.
///Returns:
///    If this function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
///    
@DllImport("NInput")
HRESULT ProcessBufferedPacketsInteractionContext(HINTERACTIONCONTEXT__* interactionContext);

///Sends timer input to the Interaction Context object for inertia processing.
///Params:
///    interactionContext = Pointer to a handle for the Interaction Context.
///Returns:
///    If this function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
///    
@DllImport("NInput")
HRESULT ProcessInertiaInteractionContext(HINTERACTIONCONTEXT__* interactionContext);

///Sets the interaction state to INTERACTION_STATE_IDLE and leaves all interaction configuration settings and parameters
///intact. Current interactions are cancelled and notifications sent as required. Interaction Context does not have to
///be reconfigured before next use.
///Params:
///    interactionContext = Handle to the Interaction Context object.
///Returns:
///    If this function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
///    
@DllImport("NInput")
HRESULT StopInteractionContext(HINTERACTIONCONTEXT__* interactionContext);

///Sets the center point, and the pivot radius from the center point, for a rotation manipulation using a single input
///pointer.
///Params:
///    interactionContext = Pointer to a handle for the Interaction Context.
///    x = The x-coordinate for the screen location of the center point.
///    y = The y-coordinate for the screen location of the center point.
///    radius = The offset between the center point and the single input pointer, in HIMETRIC units.
///Returns:
///    If this function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
///    
@DllImport("NInput")
HRESULT SetPivotInteractionContext(HINTERACTIONCONTEXT__* interactionContext, float x, float y, float radius);


