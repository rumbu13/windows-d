module windows.machinelearning;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.direct3d12 : ID3D12Device, ID3D12Resource;
public import windows.systemservices : BOOL;

extern(Windows):


// Enums


enum : int
{
    WINML_TENSOR_UNDEFINED  = 0x00000000,
    WINML_TENSOR_FLOAT      = 0x00000001,
    WINML_TENSOR_UINT8      = 0x00000002,
    WINML_TENSOR_INT8       = 0x00000003,
    WINML_TENSOR_UINT16     = 0x00000004,
    WINML_TENSOR_INT16      = 0x00000005,
    WINML_TENSOR_INT32      = 0x00000006,
    WINML_TENSOR_INT64      = 0x00000007,
    WINML_TENSOR_STRING     = 0x00000008,
    WINML_TENSOR_BOOLEAN    = 0x00000009,
    WINML_TENSOR_FLOAT16    = 0x0000000a,
    WINML_TENSOR_DOUBLE     = 0x0000000b,
    WINML_TENSOR_UINT32     = 0x0000000c,
    WINML_TENSOR_UINT64     = 0x0000000d,
    WINML_TENSOR_COMPLEX64  = 0x0000000e,
    WINML_TENSOR_COMPLEX128 = 0x0000000f,
}
alias WINML_TENSOR_DATA_TYPE = int;

enum : int
{
    WINML_FEATURE_UNDEFINED = 0x00000000,
    WINML_FEATURE_TENSOR    = 0x00000001,
    WINML_FEATURE_SEQUENCE  = 0x00000002,
    WINML_FEATURE_MAP       = 0x00000003,
    WINML_FEATURE_IMAGE     = 0x00000004,
}
alias WINML_FEATURE_TYPE = int;

enum : int
{
    WINML_BINDING_UNDEFINED = 0x00000000,
    WINML_BINDING_TENSOR    = 0x00000001,
    WINML_BINDING_SEQUENCE  = 0x00000002,
    WINML_BINDING_MAP       = 0x00000003,
    WINML_BINDING_IMAGE     = 0x00000004,
    WINML_BINDING_RESOURCE  = 0x00000005,
}
alias WINML_BINDING_TYPE = int;

enum : int
{
    WINML_RUNTIME_CNTK = 0x00000000,
}
alias WINML_RUNTIME_TYPE = int;

enum MLOperatorAttributeType : uint
{
    Undefined   = 0x00000000,
    Float       = 0x00000002,
    Int         = 0x00000003,
    String      = 0x00000004,
    FloatArray  = 0x00000007,
    IntArray    = 0x00000008,
    StringArray = 0x00000009,
}

enum MLOperatorTensorDataType : uint
{
    Undefined  = 0x00000000,
    Float      = 0x00000001,
    UInt8      = 0x00000002,
    Int8       = 0x00000003,
    UInt16     = 0x00000004,
    Int16      = 0x00000005,
    Int32      = 0x00000006,
    Int64      = 0x00000007,
    String     = 0x00000008,
    Bool       = 0x00000009,
    Float16    = 0x0000000a,
    Double     = 0x0000000b,
    UInt32     = 0x0000000c,
    UInt64     = 0x0000000d,
    Complex64  = 0x0000000e,
    Complex128 = 0x0000000f,
}

enum MLOperatorEdgeType : uint
{
    Undefined = 0x00000000,
    Tensor    = 0x00000001,
}

enum MLOperatorParameterOptions : uint
{
    Single   = 0x00000000,
    Optional = 0x00000001,
    Variadic = 0x00000002,
}

enum MLOperatorSchemaEdgeTypeFormat : int
{
    EdgeDescription = 0x00000000,
    Label           = 0x00000001,
}

enum MLOperatorKernelOptions : uint
{
    None                    = 0x00000000,
    AllowDynamicInputShapes = 0x00000001,
}

enum MLOperatorExecutionType : uint
{
    Undefined = 0x00000000,
    Cpu       = 0x00000001,
    D3D12     = 0x00000002,
}

// Structs


struct WINML_TENSOR_BINDING_DESC
{
    WINML_TENSOR_DATA_TYPE DataType;
    uint  NumDimensions;
    long* pShape;
    uint  DataSize;
    void* pData;
}

struct WINML_SEQUENCE_BINDING_DESC
{
    uint ElementCount;
    WINML_TENSOR_DATA_TYPE ElementType;
    union
    {
        ushort** pStrings;
        long*    pInts;
        float*   pFloats;
        double*  pDoubles;
    }
}

struct WINML_MAP_BINDING_DESC
{
    uint ElementCount;
    WINML_TENSOR_DATA_TYPE KeyType;
    union
    {
        ushort** pStringKeys;
        long*    pIntKeys;
    }
    WINML_TENSOR_DATA_TYPE Fields;
    union
    {
        ushort** pStringFields;
        long*    pIntFields;
        float*   pFloatFields;
        double*  pDoubleFields;
    }
}

struct WINML_IMAGE_BINDING_DESC
{
    WINML_TENSOR_DATA_TYPE ElementType;
    uint  NumDimensions;
    long* pShape;
    uint  DataSize;
    void* pData;
}

struct WINML_RESOURCE_BINDING_DESC
{
    WINML_TENSOR_DATA_TYPE ElementType;
    uint           NumDimensions;
    long*          pShape;
    ID3D12Resource pResource;
}

struct WINML_BINDING_DESC
{
    const(wchar)*      Name;
    WINML_BINDING_TYPE BindType;
    union
    {
        WINML_TENSOR_BINDING_DESC Tensor;
        WINML_SEQUENCE_BINDING_DESC Sequence;
        WINML_MAP_BINDING_DESC Map;
        WINML_IMAGE_BINDING_DESC Image;
        WINML_RESOURCE_BINDING_DESC Resource;
    }
}

struct WINML_TENSOR_VARIABLE_DESC
{
    WINML_TENSOR_DATA_TYPE ElementType;
    uint  NumDimensions;
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
    uint  NumDimensions;
    long* pShape;
}

struct WINML_VARIABLE_DESC
{
    const(wchar)*      Name;
    const(wchar)*      Description;
    WINML_FEATURE_TYPE FeatureType;
    BOOL               Required;
    union
    {
        WINML_TENSOR_VARIABLE_DESC Tensor;
        WINML_SEQUENCE_VARIABLE_DESC Sequence;
        WINML_MAP_VARIABLE_DESC Map;
        WINML_IMAGE_VARIABLE_DESC Image;
    }
}

struct WINML_MODEL_DESC
{
    const(wchar)* Author;
    const(wchar)* Name;
    const(wchar)* Domain;
    const(wchar)* Description;
    size_t        Version;
}

struct MLOperatorEdgeDescription
{
    MLOperatorEdgeType edgeType;
    union
    {
        ulong reserved;
        MLOperatorTensorDataType tensorDataType;
    }
}

struct MLOperatorSchemaEdgeDescription
{
    MLOperatorParameterOptions options;
    MLOperatorSchemaEdgeTypeFormat typeFormat;
    union
    {
        const(void)* reserved;
        const(byte)* typeLabel;
        MLOperatorEdgeDescription edgeDescription;
    }
}

struct MLOperatorEdgeTypeConstraint
{
    const(byte)* typeLabel;
    const(MLOperatorEdgeDescription)* allowedTypes;
    uint         allowedTypeCount;
}

struct MLOperatorAttribute
{
    const(byte)* name;
    MLOperatorAttributeType type;
    bool         required;
}

struct MLOperatorAttributeNameValue
{
    const(byte)* name;
    MLOperatorAttributeType type;
    uint         valueCount;
    union
    {
        const(void)*  reserved;
        const(long)*  ints;
        const(byte)** strings;
        const(float)* floats;
    }
}

struct MLOperatorSchemaDescription
{
    const(byte)* name;
    int          operatorSetVersionAtLastChange;
    const(MLOperatorSchemaEdgeDescription)* inputs;
    uint         inputCount;
    const(MLOperatorSchemaEdgeDescription)* outputs;
    uint         outputCount;
    const(MLOperatorEdgeTypeConstraint)* typeConstraints;
    uint         typeConstraintCount;
    const(MLOperatorAttribute)* attributes;
    uint         attributeCount;
    const(MLOperatorAttributeNameValue)* defaultAttributes;
    uint         defaultAttributeCount;
}

struct MLOperatorSetId
{
    const(byte)* domain;
    int          version_;
}

struct MLOperatorKernelDescription
{
    const(byte)* domain;
    const(byte)* name;
    int          minimumOperatorSetVersion;
    MLOperatorExecutionType executionType;
    const(MLOperatorEdgeTypeConstraint)* typeConstraints;
    uint         typeConstraintCount;
    const(MLOperatorAttributeNameValue)* defaultAttributes;
    uint         defaultAttributeCount;
    MLOperatorKernelOptions options;
    uint         executionOptions;
}

// Functions

@DllImport("winml")
HRESULT WinMLCreateRuntime(IWinMLRuntime* runtime);

@DllImport("windows")
HRESULT MLCreateOperatorRegistry(IMLOperatorRegistry* registry);


// Interfaces

@GUID("E2EEB6A9-F31F-4055-A521-E30B5B33664A")
interface IWinMLModel : IUnknown
{
    HRESULT GetDescription(WINML_MODEL_DESC** ppDescription);
    HRESULT EnumerateMetadata(uint Index, ushort** pKey, ushort** pValue);
    HRESULT EnumerateModelInputs(uint Index, WINML_VARIABLE_DESC** ppInputDescriptor);
    HRESULT EnumerateModelOutputs(uint Index, WINML_VARIABLE_DESC** ppOutputDescriptor);
}

@GUID("95848F9E-583D-4054-AF12-916387CD8426")
interface IWinMLEvaluationContext : IUnknown
{
    HRESULT BindValue(WINML_BINDING_DESC* pDescriptor);
    HRESULT GetValueByName(const(wchar)* Name, WINML_BINDING_DESC** pDescriptor);
    HRESULT Clear();
}

@GUID("A0425329-40AE-48D9-BCE3-829EF7B8A41A")
interface IWinMLRuntime : IUnknown
{
    HRESULT LoadModel(const(wchar)* Path, IWinMLModel* ppModel);
    HRESULT CreateEvaluationContext(ID3D12Device device, IWinMLEvaluationContext* ppContext);
    HRESULT EvaluateModel(IWinMLEvaluationContext pContext);
}

@GUID("A807B84D-4AE5-4BC0-A76A-941AA246BD41")
interface IWinMLRuntimeFactory : IUnknown
{
    HRESULT CreateRuntime(WINML_RUNTIME_TYPE RuntimeType, IWinMLRuntime* ppRuntime);
}

@GUID("4B1B1759-EC40-466C-AAB4-BEB5347FD24C")
interface IMLOperatorAttributes : IUnknown
{
    HRESULT GetAttributeElementCount(const(byte)* name, MLOperatorAttributeType type, uint* elementCount);
    HRESULT GetAttribute(const(byte)* name, MLOperatorAttributeType type, uint elementCount, 
                         size_t elementByteSize, char* value);
    HRESULT GetStringAttributeElementLength(const(byte)* name, uint elementIndex, uint* attributeElementByteSize);
    HRESULT GetStringAttributeElement(const(byte)* name, uint elementIndex, uint attributeElementByteSize, 
                                      char* attributeElement);
}

@GUID("F20E8CBE-3B28-4248-BE95-F96FBC6E4643")
interface IMLOperatorTensorShapeDescription : IUnknown
{
    HRESULT GetInputTensorDimensionCount(uint inputIndex, uint* dimensionCount);
    HRESULT GetInputTensorShape(uint inputIndex, uint dimensionCount, char* dimensions);
    bool    HasOutputShapeDescription();
    HRESULT GetOutputTensorDimensionCount(uint outputIndex, uint* dimensionCount);
    HRESULT GetOutputTensorShape(uint outputIndex, uint dimensionCount, char* dimensions);
}

@GUID("5459B53D-A0FC-4665-ADDD-70171EF7E631")
interface IMLOperatorKernelCreationContext : IMLOperatorAttributes
{
    uint    GetInputCount();
    uint    GetOutputCount();
    bool    IsInputValid(uint inputIndex);
    bool    IsOutputValid(uint outputIndex);
    HRESULT GetInputEdgeDescription(uint inputIndex, MLOperatorEdgeDescription* edgeDescription);
    HRESULT GetOutputEdgeDescription(uint outputIndex, MLOperatorEdgeDescription* edgeDescription);
    bool    HasTensorShapeDescription();
    HRESULT GetTensorShapeDescription(IMLOperatorTensorShapeDescription* shapeDescription);
    void    GetExecutionInterface(IUnknown* executionObject);
}

@GUID("7FE41F41-F430-440E-AECE-54416DC8B9DB")
interface IMLOperatorTensor : IUnknown
{
    uint    GetDimensionCount();
    HRESULT GetShape(uint dimensionCount, char* dimensions);
    MLOperatorTensorDataType GetTensorDataType();
    bool    IsCpuData();
    bool    IsDataInterface();
    void*   GetData();
    void    GetDataInterface(IUnknown* dataInterface);
}

@GUID("82536A28-F022-4769-9D3F-8B278F84C0C3")
interface IMLOperatorKernelContext : IUnknown
{
    HRESULT GetInputTensor(uint inputIndex, IMLOperatorTensor* tensor);
    HRESULT GetOutputTensor(uint outputIndex, IMLOperatorTensor* tensor);
    HRESULT GetOutputTensor(uint outputIndex, uint dimensionCount, char* dimensionSizes, IMLOperatorTensor* tensor);
    HRESULT AllocateTemporaryData(size_t size, IUnknown* data);
    void    GetExecutionInterface(IUnknown* executionObject);
}

@GUID("11C4B4A0-B467-4EAA-A1A6-B961D8D0ED79")
interface IMLOperatorKernel : IUnknown
{
    HRESULT Compute(IMLOperatorKernelContext context);
}

@GUID("105B6B29-5408-4A68-9959-09B5955A3492")
interface IMLOperatorShapeInferenceContext : IMLOperatorAttributes
{
    uint    GetInputCount();
    uint    GetOutputCount();
    bool    IsInputValid(uint inputIndex);
    bool    IsOutputValid(uint outputIndex);
    HRESULT GetInputEdgeDescription(uint inputIndex, MLOperatorEdgeDescription* edgeDescription);
    HRESULT GetInputTensorDimensionCount(uint inputIndex, uint* dimensionCount);
    HRESULT GetInputTensorShape(uint inputIndex, uint dimensionCount, char* dimensions);
    HRESULT SetOutputTensorShape(uint outputIndex, uint dimensionCount, const(uint)* dimensions);
}

@GUID("EC893BB1-F938-427B-8488-C8DCF775F138")
interface IMLOperatorTypeInferenceContext : IMLOperatorAttributes
{
    uint    GetInputCount();
    uint    GetOutputCount();
    bool    IsInputValid(uint inputIndex);
    bool    IsOutputValid(uint outputIndex);
    HRESULT GetInputEdgeDescription(uint inputIndex, MLOperatorEdgeDescription* edgeDescription);
    HRESULT SetOutputEdgeDescription(uint outputIndex, const(MLOperatorEdgeDescription)* edgeDescription);
}

@GUID("781AEB48-9BCB-4797-BF77-8BF455217BEB")
interface IMLOperatorTypeInferrer : IUnknown
{
    HRESULT InferOutputTypes(IMLOperatorTypeInferenceContext context);
}

@GUID("540BE5BE-A6C9-40EE-83F6-D2B8B40A7798")
interface IMLOperatorShapeInferrer : IUnknown
{
    HRESULT InferOutputShapes(IMLOperatorShapeInferenceContext context);
}

@GUID("EF15AD6F-0DC9-4908-AB35-A575A30DFBF8")
interface IMLOperatorKernelFactory : IUnknown
{
    HRESULT CreateKernel(IMLOperatorKernelCreationContext context, IMLOperatorKernel* kernel);
}

@GUID("2AF9DD2D-B516-4672-9AB5-530C208493AD")
interface IMLOperatorRegistry : IUnknown
{
    HRESULT RegisterOperatorSetSchema(const(MLOperatorSetId)* operatorSetId, int baselineVersion, char* schema, 
                                      uint schemaCount, IMLOperatorTypeInferrer typeInferrer, 
                                      IMLOperatorShapeInferrer shapeInferrer);
    HRESULT RegisterOperatorKernel(const(MLOperatorKernelDescription)* operatorKernel, 
                                   IMLOperatorKernelFactory operatorKernelFactory, 
                                   IMLOperatorShapeInferrer shapeInferrer);
}


// GUIDs


const GUID IID_IMLOperatorAttributes             = GUIDOF!IMLOperatorAttributes;
const GUID IID_IMLOperatorKernel                 = GUIDOF!IMLOperatorKernel;
const GUID IID_IMLOperatorKernelContext          = GUIDOF!IMLOperatorKernelContext;
const GUID IID_IMLOperatorKernelCreationContext  = GUIDOF!IMLOperatorKernelCreationContext;
const GUID IID_IMLOperatorKernelFactory          = GUIDOF!IMLOperatorKernelFactory;
const GUID IID_IMLOperatorRegistry               = GUIDOF!IMLOperatorRegistry;
const GUID IID_IMLOperatorShapeInferenceContext  = GUIDOF!IMLOperatorShapeInferenceContext;
const GUID IID_IMLOperatorShapeInferrer          = GUIDOF!IMLOperatorShapeInferrer;
const GUID IID_IMLOperatorTensor                 = GUIDOF!IMLOperatorTensor;
const GUID IID_IMLOperatorTensorShapeDescription = GUIDOF!IMLOperatorTensorShapeDescription;
const GUID IID_IMLOperatorTypeInferenceContext   = GUIDOF!IMLOperatorTypeInferenceContext;
const GUID IID_IMLOperatorTypeInferrer           = GUIDOF!IMLOperatorTypeInferrer;
const GUID IID_IWinMLEvaluationContext           = GUIDOF!IWinMLEvaluationContext;
const GUID IID_IWinMLModel                       = GUIDOF!IWinMLModel;
const GUID IID_IWinMLRuntime                     = GUIDOF!IWinMLRuntime;
const GUID IID_IWinMLRuntimeFactory              = GUIDOF!IWinMLRuntimeFactory;
