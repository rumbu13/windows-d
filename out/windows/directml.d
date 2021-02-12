module windows.directml;

public import system;
public import windows.com;
public import windows.direct3d12;
public import windows.systemservices;

extern(Windows):

enum DML_TENSOR_DATA_TYPE
{
    DML_TENSOR_DATA_TYPE_UNKNOWN = 0,
    DML_TENSOR_DATA_TYPE_FLOAT32 = 1,
    DML_TENSOR_DATA_TYPE_FLOAT16 = 2,
    DML_TENSOR_DATA_TYPE_UINT32 = 3,
    DML_TENSOR_DATA_TYPE_UINT16 = 4,
    DML_TENSOR_DATA_TYPE_UINT8 = 5,
    DML_TENSOR_DATA_TYPE_INT32 = 6,
    DML_TENSOR_DATA_TYPE_INT16 = 7,
    DML_TENSOR_DATA_TYPE_INT8 = 8,
}

enum DML_TENSOR_TYPE
{
    DML_TENSOR_TYPE_INVALID = 0,
    DML_TENSOR_TYPE_BUFFER = 1,
}

enum DML_TENSOR_FLAGS
{
    DML_TENSOR_FLAG_NONE = 0,
    DML_TENSOR_FLAG_OWNED_BY_DML = 1,
}

struct DML_BUFFER_TENSOR_DESC
{
    DML_TENSOR_DATA_TYPE DataType;
    DML_TENSOR_FLAGS Flags;
    uint DimensionCount;
    const(uint)* Sizes;
    const(uint)* Strides;
    ulong TotalTensorSizeInBytes;
    uint GuaranteedBaseOffsetAlignment;
}

struct DML_TENSOR_DESC
{
    DML_TENSOR_TYPE Type;
    const(void)* Desc;
}

enum DML_OPERATOR_TYPE
{
    DML_OPERATOR_INVALID = 0,
    DML_OPERATOR_ELEMENT_WISE_IDENTITY = 1,
    DML_OPERATOR_ELEMENT_WISE_ABS = 2,
    DML_OPERATOR_ELEMENT_WISE_ACOS = 3,
    DML_OPERATOR_ELEMENT_WISE_ADD = 4,
    DML_OPERATOR_ELEMENT_WISE_ASIN = 5,
    DML_OPERATOR_ELEMENT_WISE_ATAN = 6,
    DML_OPERATOR_ELEMENT_WISE_CEIL = 7,
    DML_OPERATOR_ELEMENT_WISE_CLIP = 8,
    DML_OPERATOR_ELEMENT_WISE_COS = 9,
    DML_OPERATOR_ELEMENT_WISE_DIVIDE = 10,
    DML_OPERATOR_ELEMENT_WISE_EXP = 11,
    DML_OPERATOR_ELEMENT_WISE_FLOOR = 12,
    DML_OPERATOR_ELEMENT_WISE_LOG = 13,
    DML_OPERATOR_ELEMENT_WISE_LOGICAL_AND = 14,
    DML_OPERATOR_ELEMENT_WISE_LOGICAL_EQUALS = 15,
    DML_OPERATOR_ELEMENT_WISE_LOGICAL_GREATER_THAN = 16,
    DML_OPERATOR_ELEMENT_WISE_LOGICAL_LESS_THAN = 17,
    DML_OPERATOR_ELEMENT_WISE_LOGICAL_NOT = 18,
    DML_OPERATOR_ELEMENT_WISE_LOGICAL_OR = 19,
    DML_OPERATOR_ELEMENT_WISE_LOGICAL_XOR = 20,
    DML_OPERATOR_ELEMENT_WISE_MAX = 21,
    DML_OPERATOR_ELEMENT_WISE_MEAN = 22,
    DML_OPERATOR_ELEMENT_WISE_MIN = 23,
    DML_OPERATOR_ELEMENT_WISE_MULTIPLY = 24,
    DML_OPERATOR_ELEMENT_WISE_POW = 25,
    DML_OPERATOR_ELEMENT_WISE_CONSTANT_POW = 26,
    DML_OPERATOR_ELEMENT_WISE_RECIP = 27,
    DML_OPERATOR_ELEMENT_WISE_SIN = 28,
    DML_OPERATOR_ELEMENT_WISE_SQRT = 29,
    DML_OPERATOR_ELEMENT_WISE_SUBTRACT = 30,
    DML_OPERATOR_ELEMENT_WISE_TAN = 31,
    DML_OPERATOR_ELEMENT_WISE_THRESHOLD = 32,
    DML_OPERATOR_ELEMENT_WISE_QUANTIZE_LINEAR = 33,
    DML_OPERATOR_ELEMENT_WISE_DEQUANTIZE_LINEAR = 34,
    DML_OPERATOR_ACTIVATION_ELU = 35,
    DML_OPERATOR_ACTIVATION_HARDMAX = 36,
    DML_OPERATOR_ACTIVATION_HARD_SIGMOID = 37,
    DML_OPERATOR_ACTIVATION_IDENTITY = 38,
    DML_OPERATOR_ACTIVATION_LEAKY_RELU = 39,
    DML_OPERATOR_ACTIVATION_LINEAR = 40,
    DML_OPERATOR_ACTIVATION_LOG_SOFTMAX = 41,
    DML_OPERATOR_ACTIVATION_PARAMETERIZED_RELU = 42,
    DML_OPERATOR_ACTIVATION_PARAMETRIC_SOFTPLUS = 43,
    DML_OPERATOR_ACTIVATION_RELU = 44,
    DML_OPERATOR_ACTIVATION_SCALED_ELU = 45,
    DML_OPERATOR_ACTIVATION_SCALED_TANH = 46,
    DML_OPERATOR_ACTIVATION_SIGMOID = 47,
    DML_OPERATOR_ACTIVATION_SOFTMAX = 48,
    DML_OPERATOR_ACTIVATION_SOFTPLUS = 49,
    DML_OPERATOR_ACTIVATION_SOFTSIGN = 50,
    DML_OPERATOR_ACTIVATION_TANH = 51,
    DML_OPERATOR_ACTIVATION_THRESHOLDED_RELU = 52,
    DML_OPERATOR_CONVOLUTION = 53,
    DML_OPERATOR_GEMM = 54,
    DML_OPERATOR_REDUCE = 55,
    DML_OPERATOR_AVERAGE_POOLING = 56,
    DML_OPERATOR_LP_POOLING = 57,
    DML_OPERATOR_MAX_POOLING = 58,
    DML_OPERATOR_ROI_POOLING = 59,
    DML_OPERATOR_SLICE = 60,
    DML_OPERATOR_CAST = 61,
    DML_OPERATOR_SPLIT = 62,
    DML_OPERATOR_JOIN = 63,
    DML_OPERATOR_PADDING = 64,
    DML_OPERATOR_VALUE_SCALE_2D = 65,
    DML_OPERATOR_UPSAMPLE_2D = 66,
    DML_OPERATOR_GATHER = 67,
    DML_OPERATOR_SPACE_TO_DEPTH = 68,
    DML_OPERATOR_DEPTH_TO_SPACE = 69,
    DML_OPERATOR_TILE = 70,
    DML_OPERATOR_TOP_K = 71,
    DML_OPERATOR_BATCH_NORMALIZATION = 72,
    DML_OPERATOR_MEAN_VARIANCE_NORMALIZATION = 73,
    DML_OPERATOR_LOCAL_RESPONSE_NORMALIZATION = 74,
    DML_OPERATOR_LP_NORMALIZATION = 75,
    DML_OPERATOR_RNN = 76,
    DML_OPERATOR_LSTM = 77,
    DML_OPERATOR_GRU = 78,
    DML_OPERATOR_ELEMENT_WISE_SIGN = 79,
    DML_OPERATOR_ELEMENT_WISE_IS_NAN = 80,
    DML_OPERATOR_ELEMENT_WISE_ERF = 81,
    DML_OPERATOR_ELEMENT_WISE_SINH = 82,
    DML_OPERATOR_ELEMENT_WISE_COSH = 83,
    DML_OPERATOR_ELEMENT_WISE_TANH = 84,
    DML_OPERATOR_ELEMENT_WISE_ASINH = 85,
    DML_OPERATOR_ELEMENT_WISE_ACOSH = 86,
    DML_OPERATOR_ELEMENT_WISE_ATANH = 87,
    DML_OPERATOR_ELEMENT_WISE_IF = 88,
    DML_OPERATOR_ELEMENT_WISE_ADD1 = 89,
    DML_OPERATOR_ACTIVATION_SHRINK = 90,
    DML_OPERATOR_MAX_POOLING1 = 91,
    DML_OPERATOR_MAX_UNPOOLING = 92,
    DML_OPERATOR_DIAGONAL_MATRIX = 93,
    DML_OPERATOR_SCATTER = 94,
    DML_OPERATOR_ONE_HOT = 95,
    DML_OPERATOR_RESAMPLE = 96,
}

enum DML_REDUCE_FUNCTION
{
    DML_REDUCE_FUNCTION_ARGMAX = 0,
    DML_REDUCE_FUNCTION_ARGMIN = 1,
    DML_REDUCE_FUNCTION_AVERAGE = 2,
    DML_REDUCE_FUNCTION_L1 = 3,
    DML_REDUCE_FUNCTION_L2 = 4,
    DML_REDUCE_FUNCTION_LOG_SUM = 5,
    DML_REDUCE_FUNCTION_LOG_SUM_EXP = 6,
    DML_REDUCE_FUNCTION_MAX = 7,
    DML_REDUCE_FUNCTION_MIN = 8,
    DML_REDUCE_FUNCTION_MULTIPLY = 9,
    DML_REDUCE_FUNCTION_SUM = 10,
    DML_REDUCE_FUNCTION_SUM_SQUARE = 11,
}

enum DML_MATRIX_TRANSFORM
{
    DML_MATRIX_TRANSFORM_NONE = 0,
    DML_MATRIX_TRANSFORM_TRANSPOSE = 1,
}

enum DML_CONVOLUTION_MODE
{
    DML_CONVOLUTION_MODE_CONVOLUTION = 0,
    DML_CONVOLUTION_MODE_CROSS_CORRELATION = 1,
}

enum DML_CONVOLUTION_DIRECTION
{
    DML_CONVOLUTION_DIRECTION_FORWARD = 0,
    DML_CONVOLUTION_DIRECTION_BACKWARD = 1,
}

enum DML_PADDING_MODE
{
    DML_PADDING_MODE_CONSTANT = 0,
    DML_PADDING_MODE_EDGE = 1,
    DML_PADDING_MODE_REFLECTION = 2,
}

enum DML_INTERPOLATION_MODE
{
    DML_INTERPOLATION_MODE_NEAREST_NEIGHBOR = 0,
    DML_INTERPOLATION_MODE_LINEAR = 1,
}

struct DML_SCALE_BIAS
{
    float Scale;
    float Bias;
}

struct DML_SIZE_2D
{
    uint Width;
    uint Height;
}

enum DML_RECURRENT_NETWORK_DIRECTION
{
    DML_RECURRENT_NETWORK_DIRECTION_FORWARD = 0,
    DML_RECURRENT_NETWORK_DIRECTION_BACKWARD = 1,
    DML_RECURRENT_NETWORK_DIRECTION_BIDIRECTIONAL = 2,
}

struct DML_OPERATOR_DESC
{
    DML_OPERATOR_TYPE Type;
    const(void)* Desc;
}

struct DML_ELEMENT_WISE_IDENTITY_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

struct DML_ELEMENT_WISE_ABS_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

struct DML_ELEMENT_WISE_ACOS_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

struct DML_ELEMENT_WISE_ADD_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_ELEMENT_WISE_ADD1_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_OPERATOR_DESC)* FusedActivation;
}

struct DML_ELEMENT_WISE_ASIN_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

struct DML_ELEMENT_WISE_ATAN_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

struct DML_ELEMENT_WISE_CEIL_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

struct DML_ELEMENT_WISE_CLIP_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
    float Min;
    float Max;
}

struct DML_ELEMENT_WISE_COS_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

struct DML_ELEMENT_WISE_DIVIDE_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_ELEMENT_WISE_EXP_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

struct DML_ELEMENT_WISE_FLOOR_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

struct DML_ELEMENT_WISE_LOG_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

struct DML_ELEMENT_WISE_LOGICAL_AND_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_ELEMENT_WISE_LOGICAL_EQUALS_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_ELEMENT_WISE_LOGICAL_GREATER_THAN_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_ELEMENT_WISE_LOGICAL_LESS_THAN_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_ELEMENT_WISE_LOGICAL_NOT_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_ELEMENT_WISE_LOGICAL_OR_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_ELEMENT_WISE_LOGICAL_XOR_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_ELEMENT_WISE_MAX_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_ELEMENT_WISE_MEAN_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_ELEMENT_WISE_MIN_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_ELEMENT_WISE_MULTIPLY_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_ELEMENT_WISE_POW_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* ExponentTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

struct DML_ELEMENT_WISE_CONSTANT_POW_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
    float Exponent;
}

struct DML_ELEMENT_WISE_RECIP_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

struct DML_ELEMENT_WISE_SIN_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

struct DML_ELEMENT_WISE_SQRT_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

struct DML_ELEMENT_WISE_SUBTRACT_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_ELEMENT_WISE_TAN_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

struct DML_ELEMENT_WISE_THRESHOLD_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
    float Min;
}

struct DML_ELEMENT_WISE_QUANTIZE_LINEAR_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* ScaleTensor;
    const(DML_TENSOR_DESC)* ZeroPointTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_ELEMENT_WISE_DEQUANTIZE_LINEAR_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* ScaleTensor;
    const(DML_TENSOR_DESC)* ZeroPointTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_ACTIVATION_ELU_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    float Alpha;
}

struct DML_ACTIVATION_HARDMAX_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_ACTIVATION_HARD_SIGMOID_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    float Alpha;
    float Beta;
}

struct DML_ACTIVATION_IDENTITY_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_ACTIVATION_LEAKY_RELU_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    float Alpha;
}

struct DML_ACTIVATION_LINEAR_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    float Alpha;
    float Beta;
}

struct DML_ACTIVATION_LOG_SOFTMAX_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_ACTIVATION_PARAMETERIZED_RELU_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* SlopeTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_ACTIVATION_PARAMETRIC_SOFTPLUS_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    float Alpha;
    float Beta;
}

struct DML_ACTIVATION_RELU_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_ACTIVATION_SCALED_ELU_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    float Alpha;
    float Gamma;
}

struct DML_ACTIVATION_SCALED_TANH_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    float Alpha;
    float Beta;
}

struct DML_ACTIVATION_SIGMOID_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_ACTIVATION_SOFTMAX_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_ACTIVATION_SOFTPLUS_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    float Steepness;
}

struct DML_ACTIVATION_SOFTSIGN_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_ACTIVATION_TANH_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_ACTIVATION_THRESHOLDED_RELU_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    float Alpha;
}

struct DML_CONVOLUTION_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* FilterTensor;
    const(DML_TENSOR_DESC)* BiasTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    DML_CONVOLUTION_MODE Mode;
    DML_CONVOLUTION_DIRECTION Direction;
    uint DimensionCount;
    const(uint)* Strides;
    const(uint)* Dilations;
    const(uint)* StartPadding;
    const(uint)* EndPadding;
    const(uint)* OutputPadding;
    uint GroupCount;
    const(DML_OPERATOR_DESC)* FusedActivation;
}

struct DML_GEMM_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* CTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    DML_MATRIX_TRANSFORM TransA;
    DML_MATRIX_TRANSFORM TransB;
    float Alpha;
    float Beta;
    const(DML_OPERATOR_DESC)* FusedActivation;
}

struct DML_REDUCE_OPERATOR_DESC
{
    DML_REDUCE_FUNCTION Function;
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint AxisCount;
    const(uint)* Axes;
}

struct DML_AVERAGE_POOLING_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint DimensionCount;
    const(uint)* Strides;
    const(uint)* WindowSize;
    const(uint)* StartPadding;
    const(uint)* EndPadding;
    BOOL IncludePadding;
}

struct DML_LP_POOLING_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint DimensionCount;
    const(uint)* Strides;
    const(uint)* WindowSize;
    const(uint)* StartPadding;
    const(uint)* EndPadding;
    uint P;
}

struct DML_MAX_POOLING_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint DimensionCount;
    const(uint)* Strides;
    const(uint)* WindowSize;
    const(uint)* StartPadding;
    const(uint)* EndPadding;
}

struct DML_MAX_POOLING1_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_TENSOR_DESC)* OutputIndicesTensor;
    uint DimensionCount;
    const(uint)* Strides;
    const(uint)* WindowSize;
    const(uint)* StartPadding;
    const(uint)* EndPadding;
}

struct DML_ROI_POOLING_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* ROITensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    float SpatialScale;
    DML_SIZE_2D PooledSize;
}

struct DML_SLICE_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint DimensionCount;
    const(uint)* Offsets;
    const(uint)* Sizes;
    const(uint)* Strides;
}

struct DML_CAST_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_SPLIT_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    uint OutputCount;
    const(DML_TENSOR_DESC)* OutputTensors;
    uint Axis;
}

struct DML_JOIN_OPERATOR_DESC
{
    uint InputCount;
    const(DML_TENSOR_DESC)* InputTensors;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint Axis;
}

struct DML_PADDING_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    DML_PADDING_MODE PaddingMode;
    float PaddingValue;
    uint DimensionCount;
    const(uint)* StartPadding;
    const(uint)* EndPadding;
}

struct DML_VALUE_SCALE_2D_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    float Scale;
    uint ChannelCount;
    const(float)* Bias;
}

struct DML_UPSAMPLE_2D_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    DML_SIZE_2D ScaleSize;
    DML_INTERPOLATION_MODE InterpolationMode;
}

struct DML_GATHER_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* IndicesTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint Axis;
    uint IndexDimensions;
}

struct DML_SPACE_TO_DEPTH_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint BlockSize;
}

struct DML_DEPTH_TO_SPACE_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint BlockSize;
}

struct DML_TILE_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint RepeatsCount;
    const(uint)* Repeats;
}

struct DML_TOP_K_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputValueTensor;
    const(DML_TENSOR_DESC)* OutputIndexTensor;
    uint Axis;
    uint K;
}

struct DML_BATCH_NORMALIZATION_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* MeanTensor;
    const(DML_TENSOR_DESC)* VarianceTensor;
    const(DML_TENSOR_DESC)* ScaleTensor;
    const(DML_TENSOR_DESC)* BiasTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    BOOL Spatial;
    float Epsilon;
    const(DML_OPERATOR_DESC)* FusedActivation;
}

struct DML_MEAN_VARIANCE_NORMALIZATION_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* ScaleTensor;
    const(DML_TENSOR_DESC)* BiasTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    BOOL CrossChannel;
    BOOL NormalizeVariance;
    float Epsilon;
    const(DML_OPERATOR_DESC)* FusedActivation;
}

struct DML_LOCAL_RESPONSE_NORMALIZATION_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    BOOL CrossChannel;
    uint LocalSize;
    float Alpha;
    float Beta;
    float Bias;
}

struct DML_LP_NORMALIZATION_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint Axis;
    float Epsilon;
    uint P;
}

struct DML_RNN_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* WeightTensor;
    const(DML_TENSOR_DESC)* RecurrenceTensor;
    const(DML_TENSOR_DESC)* BiasTensor;
    const(DML_TENSOR_DESC)* HiddenInitTensor;
    const(DML_TENSOR_DESC)* SequenceLengthsTensor;
    const(DML_TENSOR_DESC)* OutputSequenceTensor;
    const(DML_TENSOR_DESC)* OutputSingleTensor;
    uint ActivationDescCount;
    const(DML_OPERATOR_DESC)* ActivationDescs;
    DML_RECURRENT_NETWORK_DIRECTION Direction;
}

struct DML_LSTM_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* WeightTensor;
    const(DML_TENSOR_DESC)* RecurrenceTensor;
    const(DML_TENSOR_DESC)* BiasTensor;
    const(DML_TENSOR_DESC)* HiddenInitTensor;
    const(DML_TENSOR_DESC)* CellMemInitTensor;
    const(DML_TENSOR_DESC)* SequenceLengthsTensor;
    const(DML_TENSOR_DESC)* PeepholeTensor;
    const(DML_TENSOR_DESC)* OutputSequenceTensor;
    const(DML_TENSOR_DESC)* OutputSingleTensor;
    const(DML_TENSOR_DESC)* OutputCellSingleTensor;
    uint ActivationDescCount;
    const(DML_OPERATOR_DESC)* ActivationDescs;
    DML_RECURRENT_NETWORK_DIRECTION Direction;
    float ClipThreshold;
    BOOL UseClipThreshold;
    BOOL CoupleInputForget;
}

struct DML_GRU_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* WeightTensor;
    const(DML_TENSOR_DESC)* RecurrenceTensor;
    const(DML_TENSOR_DESC)* BiasTensor;
    const(DML_TENSOR_DESC)* HiddenInitTensor;
    const(DML_TENSOR_DESC)* SequenceLengthsTensor;
    const(DML_TENSOR_DESC)* OutputSequenceTensor;
    const(DML_TENSOR_DESC)* OutputSingleTensor;
    uint ActivationDescCount;
    const(DML_OPERATOR_DESC)* ActivationDescs;
    DML_RECURRENT_NETWORK_DIRECTION Direction;
    BOOL LinearBeforeReset;
}

struct DML_ELEMENT_WISE_SIGN_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_ELEMENT_WISE_IS_NAN_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_ELEMENT_WISE_ERF_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

struct DML_ELEMENT_WISE_SINH_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

struct DML_ELEMENT_WISE_COSH_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

struct DML_ELEMENT_WISE_TANH_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

struct DML_ELEMENT_WISE_ASINH_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

struct DML_ELEMENT_WISE_ACOSH_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

struct DML_ELEMENT_WISE_ATANH_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    const(DML_SCALE_BIAS)* ScaleBias;
}

struct DML_ELEMENT_WISE_IF_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* ConditionTensor;
    const(DML_TENSOR_DESC)* ATensor;
    const(DML_TENSOR_DESC)* BTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_ACTIVATION_SHRINK_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    float Bias;
    float Threshold;
}

struct DML_MAX_UNPOOLING_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* IndicesTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
}

struct DML_DIAGONAL_MATRIX_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* OutputTensor;
    int Offset;
    float Value;
}

struct DML_SCATTER_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* IndicesTensor;
    const(DML_TENSOR_DESC)* UpdatesTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint Axis;
}

struct DML_ONE_HOT_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* IndicesTensor;
    const(DML_TENSOR_DESC)* ValuesTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint Axis;
}

struct DML_RESAMPLE_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    DML_INTERPOLATION_MODE InterpolationMode;
    uint ScaleCount;
    const(float)* Scales;
}

enum DML_FEATURE_LEVEL
{
    DML_FEATURE_LEVEL_1_0 = 4096,
    DML_FEATURE_LEVEL_2_0 = 8192,
}

enum DML_FEATURE
{
    DML_FEATURE_TENSOR_DATA_TYPE_SUPPORT = 0,
    DML_FEATURE_FEATURE_LEVELS = 1,
}

struct DML_FEATURE_QUERY_TENSOR_DATA_TYPE_SUPPORT
{
    DML_TENSOR_DATA_TYPE DataType;
}

struct DML_FEATURE_DATA_TENSOR_DATA_TYPE_SUPPORT
{
    BOOL IsSupported;
}

struct DML_FEATURE_QUERY_FEATURE_LEVELS
{
    uint RequestedFeatureLevelCount;
    const(DML_FEATURE_LEVEL)* RequestedFeatureLevels;
}

struct DML_FEATURE_DATA_FEATURE_LEVELS
{
    DML_FEATURE_LEVEL MaxSupportedFeatureLevel;
}

struct DML_BINDING_TABLE_DESC
{
    IDMLDispatchable Dispatchable;
    D3D12_CPU_DESCRIPTOR_HANDLE CPUDescriptorHandle;
    D3D12_GPU_DESCRIPTOR_HANDLE GPUDescriptorHandle;
    uint SizeInDescriptors;
}

enum DML_EXECUTION_FLAGS
{
    DML_EXECUTION_FLAG_NONE = 0,
    DML_EXECUTION_FLAG_ALLOW_HALF_PRECISION_COMPUTATION = 1,
    DML_EXECUTION_FLAG_DISABLE_META_COMMANDS = 2,
    DML_EXECUTION_FLAG_DESCRIPTORS_VOLATILE = 4,
}

enum DML_CREATE_DEVICE_FLAGS
{
    DML_CREATE_DEVICE_FLAG_NONE = 0,
    DML_CREATE_DEVICE_FLAG_DEBUG = 1,
}

const GUID IID_IDMLObject = {0xC8263AAC, 0x9E0C, 0x4A2D, [0x9B, 0x8E, 0x00, 0x75, 0x21, 0xA3, 0x31, 0x7C]};
@GUID(0xC8263AAC, 0x9E0C, 0x4A2D, [0x9B, 0x8E, 0x00, 0x75, 0x21, 0xA3, 0x31, 0x7C]);
interface IDMLObject : IUnknown
{
    HRESULT GetPrivateData(const(Guid)* guid, uint* dataSize, char* data);
    HRESULT SetPrivateData(const(Guid)* guid, uint dataSize, char* data);
    HRESULT SetPrivateDataInterface(const(Guid)* guid, IUnknown data);
    HRESULT SetName(const(wchar)* name);
}

const GUID IID_IDMLDevice = {0x6DBD6437, 0x96FD, 0x423F, [0xA9, 0x8C, 0xAE, 0x5E, 0x7C, 0x2A, 0x57, 0x3F]};
@GUID(0x6DBD6437, 0x96FD, 0x423F, [0xA9, 0x8C, 0xAE, 0x5E, 0x7C, 0x2A, 0x57, 0x3F]);
interface IDMLDevice : IDMLObject
{
    HRESULT CheckFeatureSupport(DML_FEATURE feature, uint featureQueryDataSize, char* featureQueryData, uint featureSupportDataSize, char* featureSupportData);
    HRESULT CreateOperator(const(DML_OPERATOR_DESC)* desc, const(Guid)* riid, void** ppv);
    HRESULT CompileOperator(IDMLOperator op, DML_EXECUTION_FLAGS flags, const(Guid)* riid, void** ppv);
    HRESULT CreateOperatorInitializer(uint operatorCount, char* operators, const(Guid)* riid, void** ppv);
    HRESULT CreateCommandRecorder(const(Guid)* riid, void** ppv);
    HRESULT CreateBindingTable(const(DML_BINDING_TABLE_DESC)* desc, const(Guid)* riid, void** ppv);
    HRESULT Evict(uint count, char* ppObjects);
    HRESULT MakeResident(uint count, char* ppObjects);
    HRESULT GetDeviceRemovedReason();
    HRESULT GetParentDevice(const(Guid)* riid, void** ppv);
}

const GUID IID_IDMLDeviceChild = {0x27E83142, 0x8165, 0x49E3, [0x97, 0x4E, 0x2F, 0xD6, 0x6E, 0x4C, 0xB6, 0x9D]};
@GUID(0x27E83142, 0x8165, 0x49E3, [0x97, 0x4E, 0x2F, 0xD6, 0x6E, 0x4C, 0xB6, 0x9D]);
interface IDMLDeviceChild : IDMLObject
{
    HRESULT GetDevice(const(Guid)* riid, void** ppv);
}

const GUID IID_IDMLPageable = {0xB1AB0825, 0x4542, 0x4A4B, [0x86, 0x17, 0x6D, 0xDE, 0x6E, 0x8F, 0x62, 0x01]};
@GUID(0xB1AB0825, 0x4542, 0x4A4B, [0x86, 0x17, 0x6D, 0xDE, 0x6E, 0x8F, 0x62, 0x01]);
interface IDMLPageable : IDMLDeviceChild
{
}

const GUID IID_IDMLOperator = {0x26CAAE7A, 0x3081, 0x4633, [0x95, 0x81, 0x22, 0x6F, 0xBE, 0x57, 0x69, 0x5D]};
@GUID(0x26CAAE7A, 0x3081, 0x4633, [0x95, 0x81, 0x22, 0x6F, 0xBE, 0x57, 0x69, 0x5D]);
interface IDMLOperator : IDMLDeviceChild
{
}

struct DML_BINDING_PROPERTIES
{
    uint RequiredDescriptorCount;
    ulong TemporaryResourceSize;
    ulong PersistentResourceSize;
}

const GUID IID_IDMLDispatchable = {0xDCB821A8, 0x1039, 0x441E, [0x9F, 0x1C, 0xB1, 0x75, 0x9C, 0x2F, 0x3C, 0xEC]};
@GUID(0xDCB821A8, 0x1039, 0x441E, [0x9F, 0x1C, 0xB1, 0x75, 0x9C, 0x2F, 0x3C, 0xEC]);
interface IDMLDispatchable : IDMLPageable
{
    DML_BINDING_PROPERTIES GetBindingProperties();
}

const GUID IID_IDMLCompiledOperator = {0x6B15E56A, 0xBF5C, 0x4902, [0x92, 0xD8, 0xDA, 0x3A, 0x65, 0x0A, 0xFE, 0xA4]};
@GUID(0x6B15E56A, 0xBF5C, 0x4902, [0x92, 0xD8, 0xDA, 0x3A, 0x65, 0x0A, 0xFE, 0xA4]);
interface IDMLCompiledOperator : IDMLDispatchable
{
}

const GUID IID_IDMLOperatorInitializer = {0x427C1113, 0x435C, 0x469C, [0x86, 0x76, 0x4D, 0x5D, 0xD0, 0x72, 0xF8, 0x13]};
@GUID(0x427C1113, 0x435C, 0x469C, [0x86, 0x76, 0x4D, 0x5D, 0xD0, 0x72, 0xF8, 0x13]);
interface IDMLOperatorInitializer : IDMLDispatchable
{
    HRESULT Reset(uint operatorCount, char* operators);
}

enum DML_BINDING_TYPE
{
    DML_BINDING_TYPE_NONE = 0,
    DML_BINDING_TYPE_BUFFER = 1,
    DML_BINDING_TYPE_BUFFER_ARRAY = 2,
}

struct DML_BINDING_DESC
{
    DML_BINDING_TYPE Type;
    const(void)* Desc;
}

struct DML_BUFFER_BINDING
{
    ID3D12Resource Buffer;
    ulong Offset;
    ulong SizeInBytes;
}

struct DML_BUFFER_ARRAY_BINDING
{
    uint BindingCount;
    const(DML_BUFFER_BINDING)* Bindings;
}

const GUID IID_IDMLBindingTable = {0x29C687DC, 0xDE74, 0x4E3B, [0xAB, 0x00, 0x11, 0x68, 0xF2, 0xFC, 0x3C, 0xFC]};
@GUID(0x29C687DC, 0xDE74, 0x4E3B, [0xAB, 0x00, 0x11, 0x68, 0xF2, 0xFC, 0x3C, 0xFC]);
interface IDMLBindingTable : IDMLDeviceChild
{
    void BindInputs(uint bindingCount, char* bindings);
    void BindOutputs(uint bindingCount, char* bindings);
    void BindTemporaryResource(const(DML_BINDING_DESC)* binding);
    void BindPersistentResource(const(DML_BINDING_DESC)* binding);
    HRESULT Reset(const(DML_BINDING_TABLE_DESC)* desc);
}

const GUID IID_IDMLCommandRecorder = {0xE6857A76, 0x2E3E, 0x4FDD, [0xBF, 0xF4, 0x5D, 0x2B, 0xA1, 0x0F, 0xB4, 0x53]};
@GUID(0xE6857A76, 0x2E3E, 0x4FDD, [0xBF, 0xF4, 0x5D, 0x2B, 0xA1, 0x0F, 0xB4, 0x53]);
interface IDMLCommandRecorder : IDMLDeviceChild
{
    void RecordDispatch(ID3D12CommandList commandList, IDMLDispatchable dispatchable, IDMLBindingTable bindings);
}

const GUID IID_IDMLDebugDevice = {0x7D6F3AC9, 0x394A, 0x4AC3, [0x92, 0xA7, 0x39, 0x0C, 0xC5, 0x7A, 0x82, 0x17]};
@GUID(0x7D6F3AC9, 0x394A, 0x4AC3, [0x92, 0xA7, 0x39, 0x0C, 0xC5, 0x7A, 0x82, 0x17]);
interface IDMLDebugDevice : IUnknown
{
    void SetMuteDebugOutput(BOOL mute);
}

@DllImport("DirectML.dll")
HRESULT DMLCreateDevice(ID3D12Device d3d12Device, DML_CREATE_DEVICE_FLAGS flags, const(Guid)* riid, void** ppv);

@DllImport("DirectML.dll")
HRESULT DMLCreateDevice1(ID3D12Device d3d12Device, DML_CREATE_DEVICE_FLAGS flags, DML_FEATURE_LEVEL minimumFeatureLevel, const(Guid)* riid, void** ppv);

