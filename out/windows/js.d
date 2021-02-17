// Written in the D programming language.

module windows.js;

public import windows.core;
public import windows.automation : VARIANT;
public import windows.com : HRESULT;
public import windows.dbg : IActiveScriptProfilerCallback, IActiveScriptProfilerHeapEnum,
                            IDebugApplication32, __MIDL___MIDL_itf_activprof_0000_0000_0002;

extern(Windows):


// Enums


enum JsRuntimeVersion : int
{
    JsRuntimeVersion10   = 0x00000000,
    JsRuntimeVersion11   = 0x00000001,
    JsRuntimeVersionEdge = 0xffffffff,
}

enum JsErrorCode : uint
{
    JsNoError                         = 0x00000000,
    JsErrorCategoryUsage              = 0x00010000,
    JsErrorInvalidArgument            = 0x00010001,
    JsErrorNullArgument               = 0x00010002,
    JsErrorNoCurrentContext           = 0x00010003,
    JsErrorInExceptionState           = 0x00010004,
    JsErrorNotImplemented             = 0x00010005,
    JsErrorWrongThread                = 0x00010006,
    JsErrorRuntimeInUse               = 0x00010007,
    JsErrorBadSerializedScript        = 0x00010008,
    JsErrorInDisabledState            = 0x00010009,
    JsErrorCannotDisableExecution     = 0x0001000a,
    JsErrorHeapEnumInProgress         = 0x0001000b,
    JsErrorArgumentNotObject          = 0x0001000c,
    JsErrorInProfileCallback          = 0x0001000d,
    JsErrorInThreadServiceCallback    = 0x0001000e,
    JsErrorCannotSerializeDebugScript = 0x0001000f,
    JsErrorAlreadyDebuggingContext    = 0x00010010,
    JsErrorAlreadyProfilingContext    = 0x00010011,
    JsErrorIdleNotEnabled             = 0x00010012,
    JsErrorCategoryEngine             = 0x00020000,
    JsErrorOutOfMemory                = 0x00020001,
    JsErrorCategoryScript             = 0x00030000,
    JsErrorScriptException            = 0x00030001,
    JsErrorScriptCompile              = 0x00030002,
    JsErrorScriptTerminated           = 0x00030003,
    JsErrorScriptEvalDisabled         = 0x00030004,
    JsErrorCategoryFatal              = 0x00040000,
    JsErrorFatal                      = 0x00040001,
}

enum JsRuntimeAttributes : int
{
    JsRuntimeAttributeNone                        = 0x00000000,
    JsRuntimeAttributeDisableBackgroundWork       = 0x00000001,
    JsRuntimeAttributeAllowScriptInterrupt        = 0x00000002,
    JsRuntimeAttributeEnableIdleProcessing        = 0x00000004,
    JsRuntimeAttributeDisableNativeCodeGeneration = 0x00000008,
    JsRuntimeAttributeDisableEval                 = 0x00000010,
}

enum JsMemoryEventType : int
{
    JsMemoryAllocate = 0x00000000,
    JsMemoryFree     = 0x00000001,
    JsMemoryFailure  = 0x00000002,
}

enum JsValueType : int
{
    JsUndefined = 0x00000000,
    JsNull      = 0x00000001,
    JsNumber    = 0x00000002,
    JsString    = 0x00000003,
    JsBoolean   = 0x00000004,
    JsObject    = 0x00000005,
    JsFunction  = 0x00000006,
    JsError     = 0x00000007,
    JsArray     = 0x00000008,
}

// Constants


enum ulong JS_SOURCE_CONTEXT_NONE = 0xffffffffffffffff;

// Callbacks

alias JsMemoryAllocationCallback = bool function(void* callbackState, JsMemoryEventType allocationEvent, 
                                                 size_t allocationSize);
alias JsBeforeCollectCallback = void function(void* callbackState);
alias JsBackgroundWorkItemCallback = void function(void* callbackState);
alias JsThreadServiceCallback = bool function(JsBackgroundWorkItemCallback callback, void* callbackState);
alias JsFinalizeCallback = void function(void* data);
alias JsNativeFunction = void* function(void* callee, bool isConstructCall, void** arguments, ushort argumentCount, 
                                        void* callbackState);

// Functions

@DllImport("chakra")
JsErrorCode JsCreateRuntime(JsRuntimeAttributes attributes, JsRuntimeVersion runtimeVersion, 
                            JsThreadServiceCallback threadService, void** runtime);

@DllImport("chakra")
JsErrorCode JsCollectGarbage(void* runtime);

@DllImport("chakra")
JsErrorCode JsDisposeRuntime(void* runtime);

@DllImport("chakra")
JsErrorCode JsGetRuntimeMemoryUsage(void* runtime, size_t* memoryUsage);

@DllImport("chakra")
JsErrorCode JsGetRuntimeMemoryLimit(void* runtime, size_t* memoryLimit);

@DllImport("chakra")
JsErrorCode JsSetRuntimeMemoryLimit(void* runtime, size_t memoryLimit);

@DllImport("chakra")
JsErrorCode JsSetRuntimeMemoryAllocationCallback(void* runtime, void* callbackState, 
                                                 JsMemoryAllocationCallback allocationCallback);

@DllImport("chakra")
JsErrorCode JsSetRuntimeBeforeCollectCallback(void* runtime, void* callbackState, 
                                              JsBeforeCollectCallback beforeCollectCallback);

@DllImport("chakra")
JsErrorCode JsAddRef(void* ref_, uint* count);

@DllImport("chakra")
JsErrorCode JsRelease(void* ref_, uint* count);

@DllImport("chakra")
JsErrorCode JsCreateContext(void* runtime, IDebugApplication32 debugApplication, void** newContext);

@DllImport("chakra")
JsErrorCode JsGetCurrentContext(void** currentContext);

@DllImport("chakra")
JsErrorCode JsSetCurrentContext(void* context);

@DllImport("chakra")
JsErrorCode JsGetRuntime(void* context, void** runtime);

@DllImport("chakra")
JsErrorCode JsStartDebugging(IDebugApplication32 debugApplication);

@DllImport("chakra")
JsErrorCode JsIdle(uint* nextIdleTick);

@DllImport("chakra")
JsErrorCode JsParseScript(const(ushort)* script, size_t sourceContext, const(ushort)* sourceUrl, void** result);

@DllImport("chakra")
JsErrorCode JsRunScript(const(ushort)* script, size_t sourceContext, const(ushort)* sourceUrl, void** result);

@DllImport("chakra")
JsErrorCode JsSerializeScript(const(ushort)* script, char* buffer, uint* bufferSize);

@DllImport("chakra")
JsErrorCode JsParseSerializedScript(const(ushort)* script, ubyte* buffer, size_t sourceContext, 
                                    const(ushort)* sourceUrl, void** result);

@DllImport("chakra")
JsErrorCode JsRunSerializedScript(const(ushort)* script, ubyte* buffer, size_t sourceContext, 
                                  const(ushort)* sourceUrl, void** result);

@DllImport("chakra")
JsErrorCode JsGetPropertyIdFromName(const(ushort)* name, void** propertyId);

@DllImport("chakra")
JsErrorCode JsGetPropertyNameFromId(void* propertyId, const(ushort)** name);

@DllImport("chakra")
JsErrorCode JsGetUndefinedValue(void** undefinedValue);

@DllImport("chakra")
JsErrorCode JsGetNullValue(void** nullValue);

@DllImport("chakra")
JsErrorCode JsGetTrueValue(void** trueValue);

@DllImport("chakra")
JsErrorCode JsGetFalseValue(void** falseValue);

@DllImport("chakra")
JsErrorCode JsBoolToBoolean(ubyte value, void** booleanValue);

@DllImport("chakra")
JsErrorCode JsBooleanToBool(void* value, bool* boolValue);

@DllImport("chakra")
JsErrorCode JsConvertValueToBoolean(void* value, void** booleanValue);

@DllImport("chakra")
JsErrorCode JsGetValueType(void* value, JsValueType* type);

@DllImport("chakra")
JsErrorCode JsDoubleToNumber(double doubleValue, void** value);

@DllImport("chakra")
JsErrorCode JsIntToNumber(int intValue, void** value);

@DllImport("chakra")
JsErrorCode JsNumberToDouble(void* value, double* doubleValue);

@DllImport("chakra")
JsErrorCode JsConvertValueToNumber(void* value, void** numberValue);

@DllImport("chakra")
JsErrorCode JsGetStringLength(void* stringValue, int* length);

@DllImport("chakra")
JsErrorCode JsPointerToString(char* stringValue, size_t stringLength, void** value);

@DllImport("chakra")
JsErrorCode JsStringToPointer(void* value, const(ushort)** stringValue, size_t* stringLength);

@DllImport("chakra")
JsErrorCode JsConvertValueToString(void* value, void** stringValue);

@DllImport("chakra")
JsErrorCode JsVariantToValue(VARIANT* variant, void** value);

@DllImport("chakra")
JsErrorCode JsValueToVariant(void* object, VARIANT* variant);

@DllImport("chakra")
JsErrorCode JsGetGlobalObject(void** globalObject);

@DllImport("chakra")
JsErrorCode JsCreateObject(void** object);

@DllImport("chakra")
JsErrorCode JsCreateExternalObject(void* data, JsFinalizeCallback finalizeCallback, void** object);

@DllImport("chakra")
JsErrorCode JsConvertValueToObject(void* value, void** object);

@DllImport("chakra")
JsErrorCode JsGetPrototype(void* object, void** prototypeObject);

@DllImport("chakra")
JsErrorCode JsSetPrototype(void* object, void* prototypeObject);

@DllImport("chakra")
JsErrorCode JsGetExtensionAllowed(void* object, bool* value);

@DllImport("chakra")
JsErrorCode JsPreventExtension(void* object);

@DllImport("chakra")
JsErrorCode JsGetProperty(void* object, void* propertyId, void** value);

@DllImport("chakra")
JsErrorCode JsGetOwnPropertyDescriptor(void* object, void* propertyId, void** propertyDescriptor);

@DllImport("chakra")
JsErrorCode JsGetOwnPropertyNames(void* object, void** propertyNames);

@DllImport("chakra")
JsErrorCode JsSetProperty(void* object, void* propertyId, void* value, ubyte useStrictRules);

@DllImport("chakra")
JsErrorCode JsHasProperty(void* object, void* propertyId, bool* hasProperty);

@DllImport("chakra")
JsErrorCode JsDeleteProperty(void* object, void* propertyId, ubyte useStrictRules, void** result);

@DllImport("chakra")
JsErrorCode JsDefineProperty(void* object, void* propertyId, void* propertyDescriptor, bool* result);

@DllImport("chakra")
JsErrorCode JsHasIndexedProperty(void* object, void* index, bool* result);

@DllImport("chakra")
JsErrorCode JsGetIndexedProperty(void* object, void* index, void** result);

@DllImport("chakra")
JsErrorCode JsSetIndexedProperty(void* object, void* index, void* value);

@DllImport("chakra")
JsErrorCode JsDeleteIndexedProperty(void* object, void* index);

@DllImport("chakra")
JsErrorCode JsEquals(void* object1, void* object2, bool* result);

@DllImport("chakra")
JsErrorCode JsStrictEquals(void* object1, void* object2, bool* result);

@DllImport("chakra")
JsErrorCode JsHasExternalData(void* object, bool* value);

@DllImport("chakra")
JsErrorCode JsGetExternalData(void* object, void** externalData);

@DllImport("chakra")
JsErrorCode JsSetExternalData(void* object, void* externalData);

@DllImport("chakra")
JsErrorCode JsCreateArray(uint length, void** result);

@DllImport("chakra")
JsErrorCode JsCallFunction(void* function_, char* arguments, ushort argumentCount, void** result);

@DllImport("chakra")
JsErrorCode JsConstructObject(void* function_, char* arguments, ushort argumentCount, void** result);

@DllImport("chakra")
JsErrorCode JsCreateFunction(JsNativeFunction nativeFunction, void* callbackState, void** function_);

@DllImport("chakra")
JsErrorCode JsCreateError(void* message, void** error);

@DllImport("chakra")
JsErrorCode JsCreateRangeError(void* message, void** error);

@DllImport("chakra")
JsErrorCode JsCreateReferenceError(void* message, void** error);

@DllImport("chakra")
JsErrorCode JsCreateSyntaxError(void* message, void** error);

@DllImport("chakra")
JsErrorCode JsCreateTypeError(void* message, void** error);

@DllImport("chakra")
JsErrorCode JsCreateURIError(void* message, void** error);

@DllImport("chakra")
JsErrorCode JsHasException(bool* hasException);

@DllImport("chakra")
JsErrorCode JsGetAndClearException(void** exception);

@DllImport("chakra")
JsErrorCode JsSetException(void* exception);

@DllImport("chakra")
JsErrorCode JsDisableRuntimeExecution(void* runtime);

@DllImport("chakra")
JsErrorCode JsEnableRuntimeExecution(void* runtime);

@DllImport("chakra")
JsErrorCode JsIsRuntimeExecutionDisabled(void* runtime, bool* isDisabled);

@DllImport("chakra")
JsErrorCode JsStartProfiling(IActiveScriptProfilerCallback callback, 
                             __MIDL___MIDL_itf_activprof_0000_0000_0002 eventMask, uint context);

@DllImport("chakra")
JsErrorCode JsStopProfiling(HRESULT reason);

@DllImport("chakra")
JsErrorCode JsEnumerateHeap(IActiveScriptProfilerHeapEnum* enumerator);

@DllImport("chakra")
JsErrorCode JsIsEnumeratingHeap(bool* isEnumeratingHeap);


