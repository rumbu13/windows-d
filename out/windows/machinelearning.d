module windows.machinelearning;

public import windows.com;
public import windows.direct3d12;
public import windows.systemservices;

extern(Windows):

enum WINML_TENSOR_DATA_TYPE
{
    WINML_TENSOR_UNDEFINED = 0,
    WINML_TENSOR_FLOAT = 1,
    WINML_TENSOR_UINT8 = 2,
    WINML_TENSOR_INT8 = 3,
    WINML_TENSOR_UINT16 = 4,
    WINML_TENSOR_INT16 = 5,
    WINML_TENSOR_INT32 = 6,
    WINML_TENSOR_INT64 = 7,
    WINML_TENSOR_STRING = 8,
    WINML_TENSOR_BOOLEAN = 9,
    WINML_TENSOR_FLOAT16 = 10,
    WINML_TENSOR_DOUBLE = 11,
    WINML_TENSOR_UINT32 = 12,
    WINML_TENSOR_UINT64 = 13,
    WINML_TENSOR_COMPLEX64 = 14,
    WINML_TENSOR_COMPLEX128 = 15,
}

enum WINML_FEATURE_TYPE
{
    WINML_FEATURE_UNDEFINED = 0,
    WINML_FEATURE_TENSOR = 1,
    WINML_FEATURE_SEQUENCE = 2,
    WINML_FEATURE_MAP = 3,
    WINML_FEATURE_IMAGE = 4,
}

enum WINML_BINDING_TYPE
{
    WINML_BINDING_UNDEFINED = 0,
    WINML_BINDING_TENSOR = 1,
    WINML_BINDING_SEQUENCE = 2,
    WINML_BINDING_MAP = 3,
    WINML_BINDING_IMAGE = 4,
    WINML_BINDING_RESOURCE = 5,
}

struct WINML_TENSOR_BINDING_DESC
{
    WINML_TENSOR_DATA_TYPE DataType;
    uint NumDimensions;
    long* pShape;
    uint DataSize;
    void* pData;
}

struct WINML_SEQUENCE_BINDING_DESC
{
    uint ElementCount;
    WINML_TENSOR_DATA_TYPE ElementType;
    _Anonymous_e__Union Anonymous;
}

struct WINML_MAP_BINDING_DESC
{
    uint ElementCount;
    WINML_TENSOR_DATA_TYPE KeyType;
    _Anonymous1_e__Union Anonymous1;
    WINML_TENSOR_DATA_TYPE Fields;
    _Anonymous2_e__Union Anonymous2;
}

struct WINML_IMAGE_BINDING_DESC
{
    WINML_TENSOR_DATA_TYPE ElementType;
    uint NumDimensions;
    long* pShape;
    uint DataSize;
    void* pData;
}

struct WINML_RESOURCE_BINDING_DESC
{
    WINML_TENSOR_DATA_TYPE ElementType;
    uint NumDimensions;
    long* pShape;
    ID3D12Resource pResource;
}

struct WINML_BINDING_DESC
{
    const(wchar)* Name;
    WINML_BINDING_TYPE BindType;
    _Anonymous_e__Union Anonymous;
}

struct WINML_TENSOR_VARIABLE_DESC
{
    WINML_TENSOR_DATA_TYPE ElementType;
    uint NumDimensions;
    long* pShape;
}

struct WINML_SEQUENCE_VARIABLE_DESC
{
    WINML_TENSOR_DATA_TYPE ElementType;
}

struct WINML_MAP_VARIABLE_DESC
{
    WINML_TENSOR_DATA_TYPE KeyType;
    WINML_TENSOR_DATA_TYPE Fields;
}

struct WINML_IMAGE_VARIABLE_DESC
{
    WINML_TENSOR_DATA_TYPE ElementType;
    uint NumDimensions;
    long* pShape;
}

struct WINML_VARIABLE_DESC
{
    const(wchar)* Name;
    const(wchar)* Description;
    WINML_FEATURE_TYPE FeatureType;
    BOOL Required;
    _Anonymous_e__Union Anonymous;
}

struct WINML_MODEL_DESC
{
    const(wchar)* Author;
    const(wchar)* Name;
    const(wchar)* Domain;
    const(wchar)* Description;
    uint Version;
}

const GUID IID_IWinMLModel = {0xE2EEB6A9, 0xF31F, 0x4055, [0xA5, 0x21, 0xE3, 0x0B, 0x5B, 0x33, 0x66, 0x4A]};
@GUID(0xE2EEB6A9, 0xF31F, 0x4055, [0xA5, 0x21, 0xE3, 0x0B, 0x5B, 0x33, 0x66, 0x4A]);
interface IWinMLModel : IUnknown
{
    HRESULT GetDescription(WINML_MODEL_DESC** ppDescription);
    HRESULT EnumerateMetadata(uint Index, ushort** pKey, ushort** pValue);
    HRESULT EnumerateModelInputs(uint Index, WINML_VARIABLE_DESC** ppInputDescriptor);
    HRESULT EnumerateModelOutputs(uint Index, WINML_VARIABLE_DESC** ppOutputDescriptor);
}

const GUID IID_IWinMLEvaluationContext = {0x95848F9E, 0x583D, 0x4054, [0xAF, 0x12, 0x91, 0x63, 0x87, 0xCD, 0x84, 0x26]};
@GUID(0x95848F9E, 0x583D, 0x4054, [0xAF, 0x12, 0x91, 0x63, 0x87, 0xCD, 0x84, 0x26]);
interface IWinMLEvaluationContext : IUnknown
{
    HRESULT BindValue(WINML_BINDING_DESC* pDescriptor);
    HRESULT GetValueByName(const(wchar)* Name, WINML_BINDING_DESC** pDescriptor);
    HRESULT Clear();
}

const GUID IID_IWinMLRuntime = {0xA0425329, 0x40AE, 0x48D9, [0xBC, 0xE3, 0x82, 0x9E, 0xF7, 0xB8, 0xA4, 0x1A]};
@GUID(0xA0425329, 0x40AE, 0x48D9, [0xBC, 0xE3, 0x82, 0x9E, 0xF7, 0xB8, 0xA4, 0x1A]);
interface IWinMLRuntime : IUnknown
{
    HRESULT LoadModel(const(wchar)* Path, IWinMLModel* ppModel);
    HRESULT CreateEvaluationContext(ID3D12Device device, IWinMLEvaluationContext* ppContext);
    HRESULT EvaluateModel(IWinMLEvaluationContext pContext);
}

enum WINML_RUNTIME_TYPE
{
    WINML_RUNTIME_CNTK = 0,
}

const GUID IID_IWinMLRuntimeFactory = {0xA807B84D, 0x4AE5, 0x4BC0, [0xA7, 0x6A, 0x94, 0x1A, 0xA2, 0x46, 0xBD, 0x41]};
@GUID(0xA807B84D, 0x4AE5, 0x4BC0, [0xA7, 0x6A, 0x94, 0x1A, 0xA2, 0x46, 0xBD, 0x41]);
interface IWinMLRuntimeFactory : IUnknown
{
    HRESULT CreateRuntime(WINML_RUNTIME_TYPE RuntimeType, IWinMLRuntime* ppRuntime);
}

enum MLOperatorAttributeType
{
    Undefined = 0,
    Float = 2,
    Int = 3,
    String = 4,
    FloatArray = 7,
    IntArray = 8,
    StringArray = 9,
}

enum MLOperatorTensorDataType
{
    Undefined = 0,
    Float = 1,
    UInt8 = 2,
    Int8 = 3,
    UInt16 = 4,
    Int16 = 5,
    Int32 = 6,
    Int64 = 7,
    String = 8,
    Bool = 9,
    Float16 = 10,
    Double = 11,
    UInt32 = 12,
    UInt64 = 13,
    Complex64 = 14,
    Complex128 = 15,
}

enum MLOperatorEdgeType
{
    Undefined = 0,
    Tensor = 1,
}

struct MLOperatorEdgeDescription
{
    MLOperatorEdgeType edgeType;
    _Anonymous_e__Union Anonymous;
}

const GUID IID_IMLOperatorAttributes = {0x4B1B1759, 0xEC40, 0x466C, [0xAA, 0xB4, 0xBE, 0xB5, 0x34, 0x7F, 0xD2, 0x4C]};
@GUID(0x4B1B1759, 0xEC40, 0x466C, [0xAA, 0xB4, 0xBE, 0xB5, 0x34, 0x7F, 0xD2, 0x4C]);
interface IMLOperatorAttributes : IUnknown
{
    HRESULT GetAttributeElementCount(const(byte)* name, MLOperatorAttributeType type, uint* elementCount);
    HRESULT GetAttribute(const(byte)* name, MLOperatorAttributeType type, uint elementCount, uint elementByteSize, char* value);
    HRESULT GetStringAttributeElementLength(const(byte)* name, uint elementIndex, uint* attributeElementByteSize);
    HRESULT GetStringAttributeElement(const(byte)* name, uint elementIndex, uint attributeElementByteSize, char* attributeElement);
}

const GUID IID_IMLOperatorTensorShapeDescription = {0xF20E8CBE, 0x3B28, 0x4248, [0xBE, 0x95, 0xF9, 0x6F, 0xBC, 0x6E, 0x46, 0x43]};
@GUID(0xF20E8CBE, 0x3B28, 0x4248, [0xBE, 0x95, 0xF9, 0x6F, 0xBC, 0x6E, 0x46, 0x43]);
interface IMLOperatorTensorShapeDescription : IUnknown
{
    HRESULT GetInputTensorDimensionCount(uint inputIndex, uint* dimensionCount);
    HRESULT GetInputTensorShape(uint inputIndex, uint dimensionCount, char* dimensions);
    bool HasOutputShapeDescription();
    HRESULT GetOutputTensorDimensionCount(uint outputIndex, uint* dimensionCount);
    HRESULT GetOutputTensorShape(uint outputIndex, uint dimensionCount, char* dimensions);
}

const GUID IID_IMLOperatorKernelCreationContext = {0x5459B53D, 0xA0FC, 0x4665, [0xAD, 0xDD, 0x70, 0x17, 0x1E, 0xF7, 0xE6, 0x31]};
@GUID(0x5459B53D, 0xA0FC, 0x4665, [0xAD, 0xDD, 0x70, 0x17, 0x1E, 0xF7, 0xE6, 0x31]);
interface IMLOperatorKernelCreationContext : IMLOperatorAttributes
{
    uint GetInputCount();
    uint GetOutputCount();
    bool IsInputValid(uint inputIndex);
    bool IsOutputValid(uint outputIndex);
    HRESULT GetInputEdgeDescription(uint inputIndex, MLOperatorEdgeDescription* edgeDescription);
    HRESULT GetOutputEdgeDescription(uint outputIndex, MLOperatorEdgeDescription* edgeDescription);
    bool HasTensorShapeDescription();
    HRESULT GetTensorShapeDescription(IMLOperatorTensorShapeDescription* shapeDescription);
    void GetExecutionInterface(IUnknown* executionObject);
}

const GUID IID_IMLOperatorTensor = {0x7FE41F41, 0xF430, 0x440E, [0xAE, 0xCE, 0x54, 0x41, 0x6D, 0xC8, 0xB9, 0xDB]};
@GUID(0x7FE41F41, 0xF430, 0x440E, [0xAE, 0xCE, 0x54, 0x41, 0x6D, 0xC8, 0xB9, 0xDB]);
interface IMLOperatorTensor : IUnknown
{
    uint GetDimensionCount();
    HRESULT GetShape(uint dimensionCount, char* dimensions);
    MLOperatorTensorDataType GetTensorDataType();
    bool IsCpuData();
    bool IsDataInterface();
    void* GetData();
    void GetDataInterface(IUnknown* dataInterface);
}

const GUID IID_IMLOperatorKernelContext = {0x82536A28, 0xF022, 0x4769, [0x9D, 0x3F, 0x8B, 0x27, 0x8F, 0x84, 0xC0, 0xC3]};
@GUID(0x82536A28, 0xF022, 0x4769, [0x9D, 0x3F, 0x8B, 0x27, 0x8F, 0x84, 0xC0, 0xC3]);
interface IMLOperatorKernelContext : IUnknown
{
    HRESULT GetInputTensor(uint inputIndex, IMLOperatorTensor* tensor);
    HRESULT GetOutputTensor(uint outputIndex, IMLOperatorTensor* tensor);
    HRESULT GetOutputTensor(uint outputIndex, uint dimensionCount, char* dimensionSizes, IMLOperatorTensor* tensor);
    HRESULT AllocateTemporaryData(uint size, IUnknown* data);
    void GetExecutionInterface(IUnknown* executionObject);
}

const GUID IID_IMLOperatorKernel = {0x11C4B4A0, 0xB467, 0x4EAA, [0xA1, 0xA6, 0xB9, 0x61, 0xD8, 0xD0, 0xED, 0x79]};
@GUID(0x11C4B4A0, 0xB467, 0x4EAA, [0xA1, 0xA6, 0xB9, 0x61, 0xD8, 0xD0, 0xED, 0x79]);
interface IMLOperatorKernel : IUnknown
{
    HRESULT Compute(IMLOperatorKernelContext context);
}

enum MLOperatorParameterOptions
{
    Single = 0,
    Optional = 1,
    Variadic = 2,
}

enum MLOperatorSchemaEdgeTypeFormat
{
    EdgeDescription = 0,
    Label = 1,
}

struct MLOperatorSchemaEdgeDescription
{
    MLOperatorParameterOptions options;
    MLOperatorSchemaEdgeTypeFormat typeFormat;
    _Anonymous_e__Union Anonymous;
}

struct MLOperatorEdgeTypeConstraint
{
    const(byte)* typeLabel;
    const(MLOperatorEdgeDescription)* allowedTypes;
    uint allowedTypeCount;
}

const GUID IID_IMLOperatorShapeInferenceContext = {0x105B6B29, 0x5408, 0x4A68, [0x99, 0x59, 0x09, 0xB5, 0x95, 0x5A, 0x34, 0x92]};
@GUID(0x105B6B29, 0x5408, 0x4A68, [0x99, 0x59, 0x09, 0xB5, 0x95, 0x5A, 0x34, 0x92]);
interface IMLOperatorShapeInferenceContext : IMLOperatorAttributes
{
    uint GetInputCount();
    uint GetOutputCount();
    bool IsInputValid(uint inputIndex);
    bool IsOutputValid(uint outputIndex);
    HRESULT GetInputEdgeDescription(uint inputIndex, MLOperatorEdgeDescription* edgeDescription);
    HRESULT GetInputTensorDimensionCount(uint inputIndex, uint* dimensionCount);
    HRESULT GetInputTensorShape(uint inputIndex, uint dimensionCount, char* dimensions);
    HRESULT SetOutputTensorShape(uint outputIndex, uint dimensionCount, const(uint)* dimensions);
}

const GUID IID_IMLOperatorTypeInferenceContext = {0xEC893BB1, 0xF938, 0x427B, [0x84, 0x88, 0xC8, 0xDC, 0xF7, 0x75, 0xF1, 0x38]};
@GUID(0xEC893BB1, 0xF938, 0x427B, [0x84, 0x88, 0xC8, 0xDC, 0xF7, 0x75, 0xF1, 0x38]);
interface IMLOperatorTypeInferenceContext : IMLOperatorAttributes
{
    uint GetInputCount();
    uint GetOutputCount();
    bool IsInputValid(uint inputIndex);
    bool IsOutputValid(uint outputIndex);
    HRESULT GetInputEdgeDescription(uint inputIndex, MLOperatorEdgeDescription* edgeDescription);
    HRESULT SetOutputEdgeDescription(uint outputIndex, const(MLOperatorEdgeDescription)* edgeDescription);
}

const GUID IID_IMLOperatorTypeInferrer = {0x781AEB48, 0x9BCB, 0x4797, [0xBF, 0x77, 0x8B, 0xF4, 0x55, 0x21, 0x7B, 0xEB]};
@GUID(0x781AEB48, 0x9BCB, 0x4797, [0xBF, 0x77, 0x8B, 0xF4, 0x55, 0x21, 0x7B, 0xEB]);
interface IMLOperatorTypeInferrer : IUnknown
{
    HRESULT InferOutputTypes(IMLOperatorTypeInferenceContext context);
}

const GUID IID_IMLOperatorShapeInferrer = {0x540BE5BE, 0xA6C9, 0x40EE, [0x83, 0xF6, 0xD2, 0xB8, 0xB4, 0x0A, 0x77, 0x98]};
@GUID(0x540BE5BE, 0xA6C9, 0x40EE, [0x83, 0xF6, 0xD2, 0xB8, 0xB4, 0x0A, 0x77, 0x98]);
interface IMLOperatorShapeInferrer : IUnknown
{
    HRESULT InferOutputShapes(IMLOperatorShapeInferenceContext context);
}

struct MLOperatorAttribute
{
    const(byte)* name;
    MLOperatorAttributeType type;
    bool required;
}

struct MLOperatorAttributeNameValue
{
    const(byte)* name;
    MLOperatorAttributeType type;
    uint valueCount;
    _Anonymous_e__Union Anonymous;
}

struct MLOperatorSchemaDescription
{
    const(byte)* name;
    int operatorSetVersionAtLastChange;
    const(MLOperatorSchemaEdgeDescription)* inputs;
    uint inputCount;
    const(MLOperatorSchemaEdgeDescription)* outputs;
    uint outputCount;
    const(MLOperatorEdgeTypeConstraint)* typeConstraints;
    uint typeConstraintCount;
    const(MLOperatorAttribute)* attributes;
    uint attributeCount;
    const(MLOperatorAttributeNameValue)* defaultAttributes;
    uint defaultAttributeCount;
}

struct MLOperatorSetId
{
    const(byte)* domain;
    int version;
}

enum MLOperatorKernelOptions
{
    None = 0,
    AllowDynamicInputShapes = 1,
}

enum MLOperatorExecutionType
{
    Undefined = 0,
    Cpu = 1,
    D3D12 = 2,
}

struct MLOperatorKernelDescription
{
    const(byte)* domain;
    const(byte)* name;
    int minimumOperatorSetVersion;
    MLOperatorExecutionType executionType;
    const(MLOperatorEdgeTypeConstraint)* typeConstraints;
    uint typeConstraintCount;
    const(MLOperatorAttributeNameValue)* defaultAttributes;
    uint defaultAttributeCount;
    MLOperatorKernelOptions options;
    uint executionOptions;
}

const GUID IID_IMLOperatorKernelFactory = {0xEF15AD6F, 0x0DC9, 0x4908, [0xAB, 0x35, 0xA5, 0x75, 0xA3, 0x0D, 0xFB, 0xF8]};
@GUID(0xEF15AD6F, 0x0DC9, 0x4908, [0xAB, 0x35, 0xA5, 0x75, 0xA3, 0x0D, 0xFB, 0xF8]);
interface IMLOperatorKernelFactory : IUnknown
{
    HRESULT CreateKernel(IMLOperatorKernelCreationContext context, IMLOperatorKernel* kernel);
}

const GUID IID_IMLOperatorRegistry = {0x2AF9DD2D, 0xB516, 0x4672, [0x9A, 0xB5, 0x53, 0x0C, 0x20, 0x84, 0x93, 0xAD]};
@GUID(0x2AF9DD2D, 0xB516, 0x4672, [0x9A, 0xB5, 0x53, 0x0C, 0x20, 0x84, 0x93, 0xAD]);
interface IMLOperatorRegistry : IUnknown
{
    HRESULT RegisterOperatorSetSchema(const(MLOperatorSetId)* operatorSetId, int baselineVersion, char* schema, uint schemaCount, IMLOperatorTypeInferrer typeInferrer, IMLOperatorShapeInferrer shapeInferrer);
    HRESULT RegisterOperatorKernel(const(MLOperatorKernelDescription)* operatorKernel, IMLOperatorKernelFactory operatorKernelFactory, IMLOperatorShapeInferrer shapeInferrer);
}

@DllImport("winml.dll")
HRESULT WinMLCreateRuntime(IWinMLRuntime* runtime);

@DllImport("windows.dll")
HRESULT MLCreateOperatorRegistry(IMLOperatorRegistry* registry);

