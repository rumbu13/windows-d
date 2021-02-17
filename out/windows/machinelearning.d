// Written in the D programming language.

module windows.machinelearning;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.direct3d12 : ID3D12Device, ID3D12Resource;
public import windows.systemservices : BOOL;

extern(Windows):


// Enums


///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
///Windows.AI.MachineLearning instead. Specifies the different data types of WinML tensors.
alias WINML_TENSOR_DATA_TYPE = int;
enum : int
{
    ///Tensor data type undefined.
    WINML_TENSOR_UNDEFINED  = 0x00000000,
    ///Tensor of data type float.
    WINML_TENSOR_FLOAT      = 0x00000001,
    ///Tensor of data type uint8.
    WINML_TENSOR_UINT8      = 0x00000002,
    ///Tensor of data type int8.
    WINML_TENSOR_INT8       = 0x00000003,
    ///Tensor of data type uint16.
    WINML_TENSOR_UINT16     = 0x00000004,
    ///Tensor of data type int16.
    WINML_TENSOR_INT16      = 0x00000005,
    ///Tensor of data type int32.
    WINML_TENSOR_INT32      = 0x00000006,
    ///Tensor of data type int64.
    WINML_TENSOR_INT64      = 0x00000007,
    ///Tensor of data type string.
    WINML_TENSOR_STRING     = 0x00000008,
    ///Tensor of data type Boolean.
    WINML_TENSOR_BOOLEAN    = 0x00000009,
    ///Tensor of data type float16.
    WINML_TENSOR_FLOAT16    = 0x0000000a,
    ///Tensor of data type double.
    WINML_TENSOR_DOUBLE     = 0x0000000b,
    ///Tensor of data type uint32.
    WINML_TENSOR_UINT32     = 0x0000000c,
    ///Tensor of data type uint64.
    WINML_TENSOR_UINT64     = 0x0000000d,
    ///Tensor of data type complex64.
    WINML_TENSOR_COMPLEX64  = 0x0000000e,
    WINML_TENSOR_COMPLEX128 = 0x0000000f,
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
///Windows.AI.MachineLearning instead. Specifies the different types of WinML features.
alias WINML_FEATURE_TYPE = int;
enum : int
{
    WINML_FEATURE_UNDEFINED = 0x00000000,
    WINML_FEATURE_TENSOR    = 0x00000001,
    WINML_FEATURE_SEQUENCE  = 0x00000002,
    WINML_FEATURE_MAP       = 0x00000003,
    WINML_FEATURE_IMAGE     = 0x00000004,
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
///Windows.AI.MachineLearning instead. Specifies the different types of WinML bindings.
alias WINML_BINDING_TYPE = int;
enum : int
{
    ///Binding type undefined.
    WINML_BINDING_UNDEFINED = 0x00000000,
    ///Binding of type tensor.
    WINML_BINDING_TENSOR    = 0x00000001,
    ///Binding of type sequence.
    WINML_BINDING_SEQUENCE  = 0x00000002,
    ///Binding of type map.
    WINML_BINDING_MAP       = 0x00000003,
    ///Binding of type image.
    WINML_BINDING_IMAGE     = 0x00000004,
    WINML_BINDING_RESOURCE  = 0x00000005,
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
///Windows.AI.MachineLearning instead. Specifies the different types of WinML runtimes.
alias WINML_RUNTIME_TYPE = int;
enum : int
{
    WINML_RUNTIME_CNTK = 0x00000000,
}

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


///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
///Windows.AI.MachineLearning instead. Contains description properties of the tensor binding.
struct WINML_TENSOR_BINDING_DESC
{
    ///A WINML_TENSOR_DATA_TYPE containing the WinML tensor data type.
    WINML_TENSOR_DATA_TYPE DataType;
    ///The WinML tensor dimension count.
    uint  NumDimensions;
    ///A pointer to the shape of the WinML tensor.
    long* pShape;
    ///The size of tensor data in bytes.
    uint  DataSize;
    void* pData;
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
///Windows.AI.MachineLearning instead. Contains description properties of the sequence binding.
struct WINML_SEQUENCE_BINDING_DESC
{
    ///The element count in the sequence binding.
    uint ElementCount;
    ///A WINML_TENSOR_DATA_TYPE containing the element tensor data type.
    WINML_TENSOR_DATA_TYPE ElementType;
    union
    {
        ushort** pStrings;
        long*    pInts;
        float*   pFloats;
        double*  pDoubles;
    }
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
///Windows.AI.MachineLearning instead. Contains properties for the binding of type map.
struct WINML_MAP_BINDING_DESC
{
    ///Element count in the map binding.
    uint ElementCount;
    ///A WINML_TENSOR_DATA_TYPE containing the key element tensor data type.
    WINML_TENSOR_DATA_TYPE KeyType;
    union
    {
        ushort** pStringKeys;
        long*    pIntKeys;
    }
    ///A WINML_TENSOR_DATA_TYPE containing the field element tensor data type.
    WINML_TENSOR_DATA_TYPE Fields;
    union
    {
        ushort** pStringFields;
        long*    pIntFields;
        float*   pFloatFields;
        double*  pDoubleFields;
    }
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
///Windows.AI.MachineLearning instead. Contains properties for the binding of the type image.
struct WINML_IMAGE_BINDING_DESC
{
    ///A WINML_TENSOR_DATA_TYPE describing the element tensor data type.
    WINML_TENSOR_DATA_TYPE ElementType;
    ///The image tensor dimension count.
    uint  NumDimensions;
    ///Pointer to the shape of the image.
    long* pShape;
    ///Size of image data in bytes.
    uint  DataSize;
    void* pData;
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
///Windows.AI.MachineLearning instead. Contains description properties of the resource binding.
struct WINML_RESOURCE_BINDING_DESC
{
    ///A WINML_TENSOR_DATA_TYPE containing the element tensor data type.
    WINML_TENSOR_DATA_TYPE ElementType;
    ///The resource dimension count.
    uint           NumDimensions;
    ///A pointer to the shape of the resource.
    long*          pShape;
    ID3D12Resource pResource;
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
///Windows.AI.MachineLearning instead. Contains a description of the WinML binding.
struct WINML_BINDING_DESC
{
    ///The name of the WinML binding.
    const(wchar)*      Name;
    ///A WINML_BINDING_TYPE containing the type of the WinML binding.
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

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
///Windows.AI.MachineLearning instead. Contains description properties of the tensor variable.
struct WINML_TENSOR_VARIABLE_DESC
{
    ///A WINML_TENSOR_DATA_TYPE containing the element tensor data type.
    WINML_TENSOR_DATA_TYPE ElementType;
    ///The tensor variable dimension count.
    uint  NumDimensions;
    long* pShape;
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
///Windows.AI.MachineLearning instead. Contains description properties of the sequence variable.
struct WINML_SEQUENCE_VARIABLE_DESC
{
    WINML_TENSOR_DATA_TYPE ElementType;
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
///Windows.AI.MachineLearning instead. Contains description properties of the map variable.
struct WINML_MAP_VARIABLE_DESC
{
    ///A WINML_TENSOR_DATA_TYPE containing the key tensor data type.
    WINML_TENSOR_DATA_TYPE KeyType;
    WINML_TENSOR_DATA_TYPE Fields;
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
///Windows.AI.MachineLearning instead. Contains properties for the image variable description.
struct WINML_IMAGE_VARIABLE_DESC
{
    ///A WINML_TENSOR_DATA_TYPE containing the element tensor data type.
    WINML_TENSOR_DATA_TYPE ElementType;
    ///The image variable dimension count.
    uint  NumDimensions;
    long* pShape;
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
///Windows.AI.MachineLearning instead. Contains description properties of the variable.
struct WINML_VARIABLE_DESC
{
    ///The name of the variable.
    const(wchar)*      Name;
    ///The description of the variable.
    const(wchar)*      Description;
    ///A WINML_FEATURE_TYPE containing the feature type of variable.
    WINML_FEATURE_TYPE FeatureType;
    ///<b>true</b> if the variable is required; otherwise, <b>false</b>.
    BOOL               Required;
    union
    {
        WINML_TENSOR_VARIABLE_DESC Tensor;
        WINML_SEQUENCE_VARIABLE_DESC Sequence;
        WINML_MAP_VARIABLE_DESC Map;
        WINML_IMAGE_VARIABLE_DESC Image;
    }
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
///Windows.AI.MachineLearning instead. Contains description properties of the model.
struct WINML_MODEL_DESC
{
    ///The author of the model.
    const(wchar)* Author;
    ///The name of the model.
    const(wchar)* Name;
    ///The domain of the model.
    const(wchar)* Domain;
    ///The description of the model.
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

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
///Windows.AI.MachineLearning instead. Represents a Windows Machine Learning model with corresponding metadata; includes
///model descriptions (name, author, versioning, etc.), as well as expected inputs and outputs.
@GUID("E2EEB6A9-F31F-4055-A521-E30B5B33664A")
interface IWinMLModel : IUnknown
{
    ///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified
    ///before it's commercially released. Microsoft makes no warranties, express or implied, with respect to the
    ///information provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
    ///Windows.AI.MachineLearning instead. Retrieves the WinML model description.
    ///Params:
    ///    ppDescription = A pointer to a WINML_MODEL_DESC containing the model description.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetDescription(WINML_MODEL_DESC** ppDescription);
    ///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified
    ///before it's commercially released. Microsoft makes no warranties, express or implied, with respect to the
    ///information provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
    ///Windows.AI.MachineLearning instead. Gets the metadata of the model.
    ///Params:
    ///    Index = The metadata index value.
    ///    pKey = A pointer to the metadata key for the given index.
    ///    pValue = A pointer to the metadata value for the given index.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnumerateMetadata(uint Index, ushort** pKey, ushort** pValue);
    ///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified
    ///before it's commercially released. Microsoft makes no warranties, express or implied, with respect to the
    ///information provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
    ///Windows.AI.MachineLearning instead. Enumerates the WinML model inputs.
    ///Params:
    ///    Index = Input index value.
    ///    ppInputDescriptor = A pointer to a WINML_VARIABLE_DESC containing the model input description.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnumerateModelInputs(uint Index, WINML_VARIABLE_DESC** ppInputDescriptor);
    ///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified
    ///before it's commercially released. Microsoft makes no warranties, express or implied, with respect to the
    ///information provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
    ///Windows.AI.MachineLearning instead. Enumerates the WinML model outputs.
    ///Params:
    ///    Index = Output index value.
    ///    ppOutputDescriptor = A pointer to a WINML_VARIABLE_DESC containing the model output description.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnumerateModelOutputs(uint Index, WINML_VARIABLE_DESC** ppOutputDescriptor);
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
///Windows.AI.MachineLearning instead. Represents the context to bind inputs and outputs to a WinML model.
@GUID("95848F9E-583D-4054-AF12-916387CD8426")
interface IWinMLEvaluationContext : IUnknown
{
    ///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified
    ///before it's commercially released. Microsoft makes no warranties, express or implied, with respect to the
    ///information provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
    ///Windows.AI.MachineLearning instead. Binds the input/output to the given model.
    ///Params:
    ///    pDescriptor = A pointer to a WINML_BINDING_DESC containing the input/output binding descriptor.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT BindValue(WINML_BINDING_DESC* pDescriptor);
    ///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified
    ///before it's commercially released. Microsoft makes no warranties, express or implied, with respect to the
    ///information provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
    ///Windows.AI.MachineLearning instead. Returns the input/output description for the specific binding name.
    ///Params:
    ///    Name = The name of the binding.
    ///    pDescriptor = A pointer to a WINML_BINDING_DESC containing the specified (Name) binding description.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetValueByName(const(wchar)* Name, WINML_BINDING_DESC** pDescriptor);
    ///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified
    ///before it's commercially released. Microsoft makes no warranties, express or implied, with respect to the
    ///information provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
    ///Windows.AI.MachineLearning instead. Clears the bindings for a model.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Clear();
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
///Windows.AI.MachineLearning instead. Represents the runtime to load and evaluate a WinML model.
@GUID("A0425329-40AE-48D9-BCE3-829EF7B8A41A")
interface IWinMLRuntime : IUnknown
{
    ///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified
    ///before it's commercially released. Microsoft makes no warranties, express or implied, with respect to the
    ///information provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
    ///Windows.AI.MachineLearning instead. Loads a WinML model.
    ///Params:
    ///    Path = Path name for the model.
    ///    ppModel = A double pointer to an IWinMLModel describing a WinML model.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT LoadModel(const(wchar)* Path, IWinMLModel* ppModel);
    ///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified
    ///before it's commercially released. Microsoft makes no warranties, express or implied, with respect to the
    ///information provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
    ///Windows.AI.MachineLearning instead. Creates a WinML evaluation context object.
    ///Params:
    ///    device = A pointer to an ID3D12Device describing a D3D12 device input.
    ///    ppContext = On success, returns a double pointer to the newly-created WinMLEvaluationContext object.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateEvaluationContext(ID3D12Device device, IWinMLEvaluationContext* ppContext);
    ///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified
    ///before it's commercially released. Microsoft makes no warranties, express or implied, with respect to the
    ///information provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
    ///Windows.AI.MachineLearning instead. Evaluates a WinML model.
    ///Params:
    ///    pContext = A pointer to the WinMLEvaluationContext to evaluate.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EvaluateModel(IWinMLEvaluationContext pContext);
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
///Windows.AI.MachineLearning instead. Represents the factory that creates the WinML runtime for model loading and
///evaluation.
@GUID("A807B84D-4AE5-4BC0-A76A-941AA246BD41")
interface IWinMLRuntimeFactory : IUnknown
{
    ///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified
    ///before it's commercially released. Microsoft makes no warranties, express or implied, with respect to the
    ///information provided here.] <b>These APIs have been deprecated and should no longer be used: </b>Please use
    ///Windows.AI.MachineLearning instead. Creates a WinML runtime.
    ///Params:
    ///    RuntimeType = A WINML_RUNTIME_TYPE that decribes the type of WinML runtime.
    ///    ppRuntime = A pointer to the created IWinMLRuntime.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
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
