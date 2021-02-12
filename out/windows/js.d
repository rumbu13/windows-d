module windows.js;

public import windows.automation;
public import windows.com;
public import windows.debug;

extern(Windows):

enum JsRuntimeVersion
{
    JsRuntimeVersion10 = 0,
    JsRuntimeVersion11 = 1,
    JsRuntimeVersionEdge = -1,
}

@DllImport("chakra.dll")
JsErrorCode JsCreateRuntime(JsRuntimeAttributes attributes, JsRuntimeVersion runtimeVersion, JsThreadServiceCallback threadService, void** runtime);

@DllImport("chakra.dll")
JsErrorCode JsCollectGarbage(void* runtime);

@DllImport("chakra.dll")
JsErrorCode JsDisposeRuntime(void* runtime);

@DllImport("chakra.dll")
JsErrorCode JsGetRuntimeMemoryUsage(void* runtime, uint* memoryUsage);

@DllImport("chakra.dll")
JsErrorCode JsGetRuntimeMemoryLimit(void* runtime, uint* memoryLimit);

@DllImport("chakra.dll")
JsErrorCode JsSetRuntimeMemoryLimit(void* runtime, uint memoryLimit);

@DllImport("chakra.dll")
JsErrorCode JsSetRuntimeMemoryAllocationCallback(void* runtime, void* callbackState, JsMemoryAllocationCallback allocationCallback);

@DllImport("chakra.dll")
JsErrorCode JsSetRuntimeBeforeCollectCallback(void* runtime, void* callbackState, JsBeforeCollectCallback beforeCollectCallback);

@DllImport("chakra.dll")
JsErrorCode JsAddRef(void* ref, uint* count);

@DllImport("chakra.dll")
JsErrorCode JsRelease(void* ref, uint* count);

@DllImport("chakra.dll")
JsErrorCode JsCreateContext(void* runtime, IDebugApplication32 debugApplication, void** newContext);

@DllImport("chakra.dll")
JsErrorCode JsGetCurrentContext(void** currentContext);

@DllImport("chakra.dll")
JsErrorCode JsSetCurrentContext(void* context);

@DllImport("chakra.dll")
JsErrorCode JsGetRuntime(void* context, void** runtime);

@DllImport("chakra.dll")
JsErrorCode JsStartDebugging(IDebugApplication32 debugApplication);

@DllImport("chakra.dll")
JsErrorCode JsIdle(uint* nextIdleTick);

@DllImport("chakra.dll")
JsErrorCode JsParseScript(const(ushort)* script, uint sourceContext, const(ushort)* sourceUrl, void** result);

@DllImport("chakra.dll")
JsErrorCode JsRunScript(const(ushort)* script, uint sourceContext, const(ushort)* sourceUrl, void** result);

@DllImport("chakra.dll")
JsErrorCode JsSerializeScript(const(ushort)* script, char* buffer, uint* bufferSize);

@DllImport("chakra.dll")
JsErrorCode JsParseSerializedScript(const(ushort)* script, ubyte* buffer, uint sourceContext, const(ushort)* sourceUrl, void** result);

@DllImport("chakra.dll")
JsErrorCode JsRunSerializedScript(const(ushort)* script, ubyte* buffer, uint sourceContext, const(ushort)* sourceUrl, void** result);

@DllImport("chakra.dll")
JsErrorCode JsGetPropertyIdFromName(const(ushort)* name, void** propertyId);

@DllImport("chakra.dll")
JsErrorCode JsGetPropertyNameFromId(void* propertyId, const(ushort)** name);

@DllImport("chakra.dll")
JsErrorCode JsGetUndefinedValue(void** undefinedValue);

@DllImport("chakra.dll")
JsErrorCode JsGetNullValue(void** nullValue);

@DllImport("chakra.dll")
JsErrorCode JsGetTrueValue(void** trueValue);

@DllImport("chakra.dll")
JsErrorCode JsGetFalseValue(void** falseValue);

@DllImport("chakra.dll")
JsErrorCode JsBoolToBoolean(ubyte value, void** booleanValue);

@DllImport("chakra.dll")
JsErrorCode JsBooleanToBool(void* value, bool* boolValue);

@DllImport("chakra.dll")
JsErrorCode JsConvertValueToBoolean(void* value, void** booleanValue);

@DllImport("chakra.dll")
JsErrorCode JsGetValueType(void* value, JsValueType* type);

@DllImport("chakra.dll")
JsErrorCode JsDoubleToNumber(double doubleValue, void** value);

@DllImport("chakra.dll")
JsErrorCode JsIntToNumber(int intValue, void** value);

@DllImport("chakra.dll")
JsErrorCode JsNumberToDouble(void* value, double* doubleValue);

@DllImport("chakra.dll")
JsErrorCode JsConvertValueToNumber(void* value, void** numberValue);

@DllImport("chakra.dll")
JsErrorCode JsGetStringLength(void* stringValue, int* length);

@DllImport("chakra.dll")
JsErrorCode JsPointerToString(char* stringValue, uint stringLength, void** value);

@DllImport("chakra.dll")
JsErrorCode JsStringToPointer(void* value, const(ushort)** stringValue, uint* stringLength);

@DllImport("chakra.dll")
JsErrorCode JsConvertValueToString(void* value, void** stringValue);

@DllImport("chakra.dll")
JsErrorCode JsVariantToValue(VARIANT* variant, void** value);

@DllImport("chakra.dll")
JsErrorCode JsValueToVariant(void* object, VARIANT* variant);

@DllImport("chakra.dll")
JsErrorCode JsGetGlobalObject(void** globalObject);

@DllImport("chakra.dll")
JsErrorCode JsCreateObject(void** object);

@DllImport("chakra.dll")
JsErrorCode JsCreateExternalObject(void* data, JsFinalizeCallback finalizeCallback, void** object);

@DllImport("chakra.dll")
JsErrorCode JsConvertValueToObject(void* value, void** object);

@DllImport("chakra.dll")
JsErrorCode JsGetPrototype(void* object, void** prototypeObject);

@DllImport("chakra.dll")
JsErrorCode JsSetPrototype(void* object, void* prototypeObject);

@DllImport("chakra.dll")
JsErrorCode JsGetExtensionAllowed(void* object, bool* value);

@DllImport("chakra.dll")
JsErrorCode JsPreventExtension(void* object);

@DllImport("chakra.dll")
JsErrorCode JsGetProperty(void* object, void* propertyId, void** value);

@DllImport("chakra.dll")
JsErrorCode JsGetOwnPropertyDescriptor(void* object, void* propertyId, void** propertyDescriptor);

@DllImport("chakra.dll")
JsErrorCode JsGetOwnPropertyNames(void* object, void** propertyNames);

@DllImport("chakra.dll")
JsErrorCode JsSetProperty(void* object, void* propertyId, void* value, ubyte useStrictRules);

@DllImport("chakra.dll")
JsErrorCode JsHasProperty(void* object, void* propertyId, bool* hasProperty);

@DllImport("chakra.dll")
JsErrorCode JsDeleteProperty(void* object, void* propertyId, ubyte useStrictRules, void** result);

@DllImport("chakra.dll")
JsErrorCode JsDefineProperty(void* object, void* propertyId, void* propertyDescriptor, bool* result);

@DllImport("chakra.dll")
JsErrorCode JsHasIndexedProperty(void* object, void* index, bool* result);

@DllImport("chakra.dll")
JsErrorCode JsGetIndexedProperty(void* object, void* index, void** result);

@DllImport("chakra.dll")
JsErrorCode JsSetIndexedProperty(void* object, void* index, void* value);

@DllImport("chakra.dll")
JsErrorCode JsDeleteIndexedProperty(void* object, void* index);

@DllImport("chakra.dll")
JsErrorCode JsEquals(void* object1, void* object2, bool* result);

@DllImport("chakra.dll")
JsErrorCode JsStrictEquals(void* object1, void* object2, bool* result);

@DllImport("chakra.dll")
JsErrorCode JsHasExternalData(void* object, bool* value);

@DllImport("chakra.dll")
JsErrorCode JsGetExternalData(void* object, void** externalData);

@DllImport("chakra.dll")
JsErrorCode JsSetExternalData(void* object, void* externalData);

@DllImport("chakra.dll")
JsErrorCode JsCreateArray(uint length, void** result);

@DllImport("chakra.dll")
JsErrorCode JsCallFunction(void* function, char* arguments, ushort argumentCount, void** result);

@DllImport("chakra.dll")
JsErrorCode JsConstructObject(void* function, char* arguments, ushort argumentCount, void** result);

@DllImport("chakra.dll")
JsErrorCode JsCreateFunction(JsNativeFunction nativeFunction, void* callbackState, void** function);

@DllImport("chakra.dll")
JsErrorCode JsCreateError(void* message, void** error);

@DllImport("chakra.dll")
JsErrorCode JsCreateRangeError(void* message, void** error);

@DllImport("chakra.dll")
JsErrorCode JsCreateReferenceError(void* message, void** error);

@DllImport("chakra.dll")
JsErrorCode JsCreateSyntaxError(void* message, void** error);

@DllImport("chakra.dll")
JsErrorCode JsCreateTypeError(void* message, void** error);

@DllImport("chakra.dll")
JsErrorCode JsCreateURIError(void* message, void** error);

@DllImport("chakra.dll")
JsErrorCode JsHasException(bool* hasException);

@DllImport("chakra.dll")
JsErrorCode JsGetAndClearException(void** exception);

@DllImport("chakra.dll")
JsErrorCode JsSetException(void* exception);

@DllImport("chakra.dll")
JsErrorCode JsDisableRuntimeExecution(void* runtime);

@DllImport("chakra.dll")
JsErrorCode JsEnableRuntimeExecution(void* runtime);

@DllImport("chakra.dll")
JsErrorCode JsIsRuntimeExecutionDisabled(void* runtime, bool* isDisabled);

@DllImport("chakra.dll")
JsErrorCode JsStartProfiling(IActiveScriptProfilerCallback callback, __MIDL___MIDL_itf_activprof_0000_0000_0002 eventMask, uint context);

@DllImport("chakra.dll")
JsErrorCode JsStopProfiling(HRESULT reason);

@DllImport("chakra.dll")
JsErrorCode JsEnumerateHeap(IActiveScriptProfilerHeapEnum* enumerator);

@DllImport("chakra.dll")
JsErrorCode JsIsEnumeratingHeap(bool* isEnumeratingHeap);

enum JsErrorCode
{
    JsNoError = 0,
    JsErrorCategoryUsage = 65536,
    JsErrorInvalidArgument = 65537,
    JsErrorNullArgument = 65538,
    JsErrorNoCurrentContext = 65539,
    JsErrorInExceptionState = 65540,
    JsErrorNotImplemented = 65541,
    JsErrorWrongThread = 65542,
    JsErrorRuntimeInUse = 65543,
    JsErrorBadSerializedScript = 65544,
    JsErrorInDisabledState = 65545,
    JsErrorCannotDisableExecution = 65546,
    JsErrorHeapEnumInProgress = 65547,
    JsErrorArgumentNotObject = 65548,
    JsErrorInProfileCallback = 65549,
    JsErrorInThreadServiceCallback = 65550,
    JsErrorCannotSerializeDebugScript = 65551,
    JsErrorAlreadyDebuggingContext = 65552,
    JsErrorAlreadyProfilingContext = 65553,
    JsErrorIdleNotEnabled = 65554,
    JsErrorCategoryEngine = 131072,
    JsErrorOutOfMemory = 131073,
    JsErrorCategoryScript = 196608,
    JsErrorScriptException = 196609,
    JsErrorScriptCompile = 196610,
    JsErrorScriptTerminated = 196611,
    JsErrorScriptEvalDisabled = 196612,
    JsErrorCategoryFatal = 262144,
    JsErrorFatal = 262145,
}

enum JsRuntimeAttributes
{
    JsRuntimeAttributeNone = 0,
    JsRuntimeAttributeDisableBackgroundWork = 1,
    JsRuntimeAttributeAllowScriptInterrupt = 2,
    JsRuntimeAttributeEnableIdleProcessing = 4,
    JsRuntimeAttributeDisableNativeCodeGeneration = 8,
    JsRuntimeAttributeDisableEval = 16,
}

enum JsMemoryEventType
{
    JsMemoryAllocate = 0,
    JsMemoryFree = 1,
    JsMemoryFailure = 2,
}

alias JsMemoryAllocationCallback = extern(Windows) bool function(void* callbackState, JsMemoryEventType allocationEvent, uint allocationSize);
alias JsBeforeCollectCallback = extern(Windows) void function(void* callbackState);
alias JsBackgroundWorkItemCallback = extern(Windows) void function(void* callbackState);
alias JsThreadServiceCallback = extern(Windows) bool function(JsBackgroundWorkItemCallback callback, void* callbackState);
enum JsValueType
{
    JsUndefined = 0,
    JsNull = 1,
    JsNumber = 2,
    JsString = 3,
    JsBoolean = 4,
    JsObject = 5,
    JsFunction = 6,
    JsError = 7,
    JsArray = 8,
}

alias JsFinalizeCallback = extern(Windows) void function(void* data);
alias JsNativeFunction = extern(Windows) void* function(void* callee, bool isConstructCall, void** arguments, ushort argumentCount, void* callbackState);
