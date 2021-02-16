module windows.directml;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.direct3d12 : D3D12_CPU_DESCRIPTOR_HANDLE, D3D12_GPU_DESCRIPTOR_HANDLE, ID3D12CommandList,
                                   ID3D12Device, ID3D12Resource;
public import windows.systemservices : BOOL;

extern(Windows):


// Enums


enum : int
{
    DML_TENSOR_DATA_TYPE_UNKNOWN = 0x00000000,
    DML_TENSOR_DATA_TYPE_FLOAT32 = 0x00000001,
    DML_TENSOR_DATA_TYPE_FLOAT16 = 0x00000002,
    DML_TENSOR_DATA_TYPE_UINT32  = 0x00000003,
    DML_TENSOR_DATA_TYPE_UINT16  = 0x00000004,
    DML_TENSOR_DATA_TYPE_UINT8   = 0x00000005,
    DML_TENSOR_DATA_TYPE_INT32   = 0x00000006,
    DML_TENSOR_DATA_TYPE_INT16   = 0x00000007,
    DML_TENSOR_DATA_TYPE_INT8    = 0x00000008,
}
alias DML_TENSOR_DATA_TYPE = int;

enum : int
{
    DML_TENSOR_TYPE_INVALID = 0x00000000,
    DML_TENSOR_TYPE_BUFFER  = 0x00000001,
}
alias DML_TENSOR_TYPE = int;

enum : int
{
    DML_TENSOR_FLAG_NONE         = 0x00000000,
    DML_TENSOR_FLAG_OWNED_BY_DML = 0x00000001,
}
alias DML_TENSOR_FLAGS = int;

enum : int
{
    DML_OPERATOR_INVALID                           = 0x00000000,
    DML_OPERATOR_ELEMENT_WISE_IDENTITY             = 0x00000001,
    DML_OPERATOR_ELEMENT_WISE_ABS                  = 0x00000002,
    DML_OPERATOR_ELEMENT_WISE_ACOS                 = 0x00000003,
    DML_OPERATOR_ELEMENT_WISE_ADD                  = 0x00000004,
    DML_OPERATOR_ELEMENT_WISE_ASIN                 = 0x00000005,
    DML_OPERATOR_ELEMENT_WISE_ATAN                 = 0x00000006,
    DML_OPERATOR_ELEMENT_WISE_CEIL                 = 0x00000007,
    DML_OPERATOR_ELEMENT_WISE_CLIP                 = 0x00000008,
    DML_OPERATOR_ELEMENT_WISE_COS                  = 0x00000009,
    DML_OPERATOR_ELEMENT_WISE_DIVIDE               = 0x0000000a,
    DML_OPERATOR_ELEMENT_WISE_EXP                  = 0x0000000b,
    DML_OPERATOR_ELEMENT_WISE_FLOOR                = 0x0000000c,
    DML_OPERATOR_ELEMENT_WISE_LOG                  = 0x0000000d,
    DML_OPERATOR_ELEMENT_WISE_LOGICAL_AND          = 0x0000000e,
    DML_OPERATOR_ELEMENT_WISE_LOGICAL_EQUALS       = 0x0000000f,
    DML_OPERATOR_ELEMENT_WISE_LOGICAL_GREATER_THAN = 0x00000010,
    DML_OPERATOR_ELEMENT_WISE_LOGICAL_LESS_THAN    = 0x00000011,
    DML_OPERATOR_ELEMENT_WISE_LOGICAL_NOT          = 0x00000012,
    DML_OPERATOR_ELEMENT_WISE_LOGICAL_OR           = 0x00000013,
    DML_OPERATOR_ELEMENT_WISE_LOGICAL_XOR          = 0x00000014,
    DML_OPERATOR_ELEMENT_WISE_MAX                  = 0x00000015,
    DML_OPERATOR_ELEMENT_WISE_MEAN                 = 0x00000016,
    DML_OPERATOR_ELEMENT_WISE_MIN                  = 0x00000017,
    DML_OPERATOR_ELEMENT_WISE_MULTIPLY             = 0x00000018,
    DML_OPERATOR_ELEMENT_WISE_POW                  = 0x00000019,
    DML_OPERATOR_ELEMENT_WISE_CONSTANT_POW         = 0x0000001a,
    DML_OPERATOR_ELEMENT_WISE_RECIP                = 0x0000001b,
    DML_OPERATOR_ELEMENT_WISE_SIN                  = 0x0000001c,
    DML_OPERATOR_ELEMENT_WISE_SQRT                 = 0x0000001d,
    DML_OPERATOR_ELEMENT_WISE_SUBTRACT             = 0x0000001e,
    DML_OPERATOR_ELEMENT_WISE_TAN                  = 0x0000001f,
    DML_OPERATOR_ELEMENT_WISE_THRESHOLD            = 0x00000020,
    DML_OPERATOR_ELEMENT_WISE_QUANTIZE_LINEAR      = 0x00000021,
    DML_OPERATOR_ELEMENT_WISE_DEQUANTIZE_LINEAR    = 0x00000022,
    DML_OPERATOR_ACTIVATION_ELU                    = 0x00000023,
    DML_OPERATOR_ACTIVATION_HARDMAX                = 0x00000024,
    DML_OPERATOR_ACTIVATION_HARD_SIGMOID           = 0x00000025,
    DML_OPERATOR_ACTIVATION_IDENTITY               = 0x00000026,
    DML_OPERATOR_ACTIVATION_LEAKY_RELU             = 0x00000027,
    DML_OPERATOR_ACTIVATION_LINEAR                 = 0x00000028,
    DML_OPERATOR_ACTIVATION_LOG_SOFTMAX            = 0x00000029,
    DML_OPERATOR_ACTIVATION_PARAMETERIZED_RELU     = 0x0000002a,
    DML_OPERATOR_ACTIVATION_PARAMETRIC_SOFTPLUS    = 0x0000002b,
    DML_OPERATOR_ACTIVATION_RELU                   = 0x0000002c,
    DML_OPERATOR_ACTIVATION_SCALED_ELU             = 0x0000002d,
    DML_OPERATOR_ACTIVATION_SCALED_TANH            = 0x0000002e,
    DML_OPERATOR_ACTIVATION_SIGMOID                = 0x0000002f,
    DML_OPERATOR_ACTIVATION_SOFTMAX                = 0x00000030,
    DML_OPERATOR_ACTIVATION_SOFTPLUS               = 0x00000031,
    DML_OPERATOR_ACTIVATION_SOFTSIGN               = 0x00000032,
    DML_OPERATOR_ACTIVATION_TANH                   = 0x00000033,
    DML_OPERATOR_ACTIVATION_THRESHOLDED_RELU       = 0x00000034,
    DML_OPERATOR_CONVOLUTION                       = 0x00000035,
    DML_OPERATOR_GEMM                              = 0x00000036,
    DML_OPERATOR_REDUCE                            = 0x00000037,
    DML_OPERATOR_AVERAGE_POOLING                   = 0x00000038,
    DML_OPERATOR_LP_POOLING                        = 0x00000039,
    DML_OPERATOR_MAX_POOLING                       = 0x0000003a,
    DML_OPERATOR_ROI_POOLING                       = 0x0000003b,
    DML_OPERATOR_SLICE                             = 0x0000003c,
    DML_OPERATOR_CAST                              = 0x0000003d,
    DML_OPERATOR_SPLIT                             = 0x0000003e,
    DML_OPERATOR_JOIN                              = 0x0000003f,
    DML_OPERATOR_PADDING                           = 0x00000040,
    DML_OPERATOR_VALUE_SCALE_2D                    = 0x00000041,
    DML_OPERATOR_UPSAMPLE_2D                       = 0x00000042,
    DML_OPERATOR_GATHER                            = 0x00000043,
    DML_OPERATOR_SPACE_TO_DEPTH                    = 0x00000044,
    DML_OPERATOR_DEPTH_TO_SPACE                    = 0x00000045,
    DML_OPERATOR_TILE                              = 0x00000046,
    DML_OPERATOR_TOP_K                             = 0x00000047,
    DML_OPERATOR_BATCH_NORMALIZATION               = 0x00000048,
    DML_OPERATOR_MEAN_VARIANCE_NORMALIZATION       = 0x00000049,
    DML_OPERATOR_LOCAL_RESPONSE_NORMALIZATION      = 0x0000004a,
    DML_OPERATOR_LP_NORMALIZATION                  = 0x0000004b,
    DML_OPERATOR_RNN                               = 0x0000004c,
    DML_OPERATOR_LSTM                              = 0x0000004d,
    DML_OPERATOR_GRU                               = 0x0000004e,
    DML_OPERATOR_ELEMENT_WISE_SIGN                 = 0x0000004f,
    DML_OPERATOR_ELEMENT_WISE_IS_NAN               = 0x00000050,
    DML_OPERATOR_ELEMENT_WISE_ERF                  = 0x00000051,
    DML_OPERATOR_ELEMENT_WISE_SINH                 = 0x00000052,
    DML_OPERATOR_ELEMENT_WISE_COSH                 = 0x00000053,
    DML_OPERATOR_ELEMENT_WISE_TANH                 = 0x00000054,
    DML_OPERATOR_ELEMENT_WISE_ASINH                = 0x00000055,
    DML_OPERATOR_ELEMENT_WISE_ACOSH                = 0x00000056,
    DML_OPERATOR_ELEMENT_WISE_ATANH                = 0x00000057,
    DML_OPERATOR_ELEMENT_WISE_IF                   = 0x00000058,
    DML_OPERATOR_ELEMENT_WISE_ADD1                 = 0x00000059,
    DML_OPERATOR_ACTIVATION_SHRINK                 = 0x0000005a,
    DML_OPERATOR_MAX_POOLING1                      = 0x0000005b,
    DML_OPERATOR_MAX_UNPOOLING                     = 0x0000005c,
    DML_OPERATOR_DIAGONAL_MATRIX                   = 0x0000005d,
    DML_OPERATOR_SCATTER                           = 0x0000005e,
    DML_OPERATOR_ONE_HOT                           = 0x0000005f,
    DML_OPERATOR_RESAMPLE                          = 0x00000060,
}
alias DML_OPERATOR_TYPE = int;

enum : int
{
    DML_REDUCE_FUNCTION_ARGMAX      = 0x00000000,
    DML_REDUCE_FUNCTION_ARGMIN      = 0x00000001,
    DML_REDUCE_FUNCTION_AVERAGE     = 0x00000002,
    DML_REDUCE_FUNCTION_L1          = 0x00000003,
    DML_REDUCE_FUNCTION_L2          = 0x00000004,
    DML_REDUCE_FUNCTION_LOG_SUM     = 0x00000005,
    DML_REDUCE_FUNCTION_LOG_SUM_EXP = 0x00000006,
    DML_REDUCE_FUNCTION_MAX         = 0x00000007,
    DML_REDUCE_FUNCTION_MIN         = 0x00000008,
    DML_REDUCE_FUNCTION_MULTIPLY    = 0x00000009,
    DML_REDUCE_FUNCTION_SUM         = 0x0000000a,
    DML_REDUCE_FUNCTION_SUM_SQUARE  = 0x0000000b,
}
alias DML_REDUCE_FUNCTION = int;

enum : int
{
    DML_MATRIX_TRANSFORM_NONE      = 0x00000000,
    DML_MATRIX_TRANSFORM_TRANSPOSE = 0x00000001,
}
alias DML_MATRIX_TRANSFORM = int;

enum : int
{
    DML_CONVOLUTION_MODE_CONVOLUTION       = 0x00000000,
    DML_CONVOLUTION_MODE_CROSS_CORRELATION = 0x00000001,
}
alias DML_CONVOLUTION_MODE = int;

enum : int
{
    DML_CONVOLUTION_DIRECTION_FORWARD  = 0x00000000,
    DML_CONVOLUTION_DIRECTION_BACKWARD = 0x00000001,
}
alias DML_CONVOLUTION_DIRECTION = int;

enum : int
{
    DML_PADDING_MODE_CONSTANT   = 0x00000000,
    DML_PADDING_MODE_EDGE       = 0x00000001,
    DML_PADDING_MODE_REFLECTION = 0x00000002,
}
alias DML_PADDING_MODE = int;

enum : int
{
    DML_INTERPOLATION_MODE_NEAREST_NEIGHBOR = 0x00000000,
    DML_INTERPOLATION_MODE_LINEAR           = 0x00000001,
}
alias DML_INTERPOLATION_MODE = int;

enum : int
{
    DML_RECURRENT_NETWORK_DIRECTION_FORWARD       = 0x00000000,
    DML_RECURRENT_NETWORK_DIRECTION_BACKWARD      = 0x00000001,
    DML_RECURRENT_NETWORK_DIRECTION_BIDIRECTIONAL = 0x00000002,
}
alias DML_RECURRENT_NETWORK_DIRECTION = int;

enum : int
{
    DML_FEATURE_LEVEL_1_0 = 0x00001000,
    DML_FEATURE_LEVEL_2_0 = 0x00002000,
}
alias DML_FEATURE_LEVEL = int;

enum : int
{
    DML_FEATURE_TENSOR_DATA_TYPE_SUPPORT = 0x00000000,
    DML_FEATURE_FEATURE_LEVELS           = 0x00000001,
}
alias DML_FEATURE = int;

enum : int
{
    DML_EXECUTION_FLAG_NONE                             = 0x00000000,
    DML_EXECUTION_FLAG_ALLOW_HALF_PRECISION_COMPUTATION = 0x00000001,
    DML_EXECUTION_FLAG_DISABLE_META_COMMANDS            = 0x00000002,
    DML_EXECUTION_FLAG_DESCRIPTORS_VOLATILE             = 0x00000004,
}
alias DML_EXECUTION_FLAGS = int;

enum : int
{
    DML_CREATE_DEVICE_FLAG_NONE  = 0x00000000,
    DML_CREATE_DEVICE_FLAG_DEBUG = 0x00000001,
}
alias DML_CREATE_DEVICE_FLAGS = int;

enum : int
{
    DML_BINDING_TYPE_NONE         = 0x00000000,
    DML_BINDING_TYPE_BUFFER       = 0x00000001,
    DML_BINDING_TYPE_BUFFER_ARRAY = 0x00000002,
}
alias DML_BINDING_TYPE = int;

// Constants


enum uint DML_TENSOR_DIMENSION_COUNT_MAX = 0x00000005;
enum uint DML_PERSISTENT_BUFFER_ALIGNMENT = 0x00000100;

// Structs


struct DML_BUFFER_TENSOR_DESC
{
    DML_TENSOR_DATA_TYPE DataType;
    DML_TENSOR_FLAGS     Flags;
    uint                 DimensionCount;
    const(uint)*         Sizes;
    const(uint)*         Strides;
    ulong                TotalTensorSizeInBytes;
    uint                 GuaranteedBaseOffsetAlignment;
}

struct DML_TENSOR_DESC
{
    DML_TENSOR_TYPE Type;
    const(void)*    Desc;
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

struct DML_OPERATOR_DESC
{
    DML_OPERATOR_TYPE Type;
    const(void)*      Desc;
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
    uint                 DimensionCount;
    const(uint)*         Strides;
    const(uint)*         Dilations;
    const(uint)*         StartPadding;
    const(uint)*         EndPadding;
    const(uint)*         OutputPadding;
    uint                 GroupCount;
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
    float                Alpha;
    float                Beta;
    const(DML_OPERATOR_DESC)* FusedActivation;
}

struct DML_REDUCE_OPERATOR_DESC
{
    DML_REDUCE_FUNCTION Function;
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint                AxisCount;
    const(uint)*        Axes;
}

struct DML_AVERAGE_POOLING_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint         DimensionCount;
    const(uint)* Strides;
    const(uint)* WindowSize;
    const(uint)* StartPadding;
    const(uint)* EndPadding;
    BOOL         IncludePadding;
}

struct DML_LP_POOLING_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint         DimensionCount;
    const(uint)* Strides;
    const(uint)* WindowSize;
    const(uint)* StartPadding;
    const(uint)* EndPadding;
    uint         P;
}

struct DML_MAX_POOLING_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint         DimensionCount;
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
    uint         DimensionCount;
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
    float       SpatialScale;
    DML_SIZE_2D PooledSize;
}

struct DML_SLICE_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint         DimensionCount;
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
    float            PaddingValue;
    uint             DimensionCount;
    const(uint)*     StartPadding;
    const(uint)*     EndPadding;
}

struct DML_VALUE_SCALE_2D_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    float         Scale;
    uint          ChannelCount;
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
    uint         RepeatsCount;
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
    BOOL  Spatial;
    float Epsilon;
    const(DML_OPERATOR_DESC)* FusedActivation;
}

struct DML_MEAN_VARIANCE_NORMALIZATION_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* ScaleTensor;
    const(DML_TENSOR_DESC)* BiasTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    BOOL  CrossChannel;
    BOOL  NormalizeVariance;
    float Epsilon;
    const(DML_OPERATOR_DESC)* FusedActivation;
}

struct DML_LOCAL_RESPONSE_NORMALIZATION_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    BOOL  CrossChannel;
    uint  LocalSize;
    float Alpha;
    float Beta;
    float Bias;
}

struct DML_LP_NORMALIZATION_OPERATOR_DESC
{
    const(DML_TENSOR_DESC)* InputTensor;
    const(DML_TENSOR_DESC)* OutputTensor;
    uint  Axis;
    float Epsilon;
    uint  P;
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
    uint  ActivationDescCount;
    const(DML_OPERATOR_DESC)* ActivationDescs;
    DML_RECURRENT_NETWORK_DIRECTION Direction;
    float ClipThreshold;
    BOOL  UseClipThreshold;
    BOOL  CoupleInputForget;
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
    int   Offset;
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
    uint          ScaleCount;
    const(float)* Scales;
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
    uint             SizeInDescriptors;
}

struct DML_BINDING_PROPERTIES
{
    uint  RequiredDescriptorCount;
    ulong TemporaryResourceSize;
    ulong PersistentResourceSize;
}

struct DML_BINDING_DESC
{
    DML_BINDING_TYPE Type;
    const(void)*     Desc;
}

struct DML_BUFFER_BINDING
{
    ID3D12Resource Buffer;
    ulong          Offset;
    ulong          SizeInBytes;
}

struct DML_BUFFER_ARRAY_BINDING
{
    uint BindingCount;
    const(DML_BUFFER_BINDING)* Bindings;
}

// Functions

@DllImport("DirectML")
HRESULT DMLCreateDevice(ID3D12Device d3d12Device, DML_CREATE_DEVICE_FLAGS flags, const(GUID)* riid, void** ppv);

@DllImport("DirectML")
HRESULT DMLCreateDevice1(ID3D12Device d3d12Device, DML_CREATE_DEVICE_FLAGS flags, 
                         DML_FEATURE_LEVEL minimumFeatureLevel, const(GUID)* riid, void** ppv);


// Interfaces

@GUID("C8263AAC-9E0C-4A2D-9B8E-007521A3317C")
interface IDMLObject : IUnknown
{
    HRESULT GetPrivateData(const(GUID)* guid, uint* dataSize, char* data);
    HRESULT SetPrivateData(const(GUID)* guid, uint dataSize, char* data);
    HRESULT SetPrivateDataInterface(const(GUID)* guid, IUnknown data);
    HRESULT SetName(const(wchar)* name);
}

@GUID("6DBD6437-96FD-423F-A98C-AE5E7C2A573F")
interface IDMLDevice : IDMLObject
{
    HRESULT CheckFeatureSupport(DML_FEATURE feature, uint featureQueryDataSize, char* featureQueryData, 
                                uint featureSupportDataSize, char* featureSupportData);
    HRESULT CreateOperator(const(DML_OPERATOR_DESC)* desc, const(GUID)* riid, void** ppv);
    HRESULT CompileOperator(IDMLOperator op, DML_EXECUTION_FLAGS flags, const(GUID)* riid, void** ppv);
    HRESULT CreateOperatorInitializer(uint operatorCount, char* operators, const(GUID)* riid, void** ppv);
    HRESULT CreateCommandRecorder(const(GUID)* riid, void** ppv);
    HRESULT CreateBindingTable(const(DML_BINDING_TABLE_DESC)* desc, const(GUID)* riid, void** ppv);
    HRESULT Evict(uint count, char* ppObjects);
    HRESULT MakeResident(uint count, char* ppObjects);
    HRESULT GetDeviceRemovedReason();
    HRESULT GetParentDevice(const(GUID)* riid, void** ppv);
}

@GUID("27E83142-8165-49E3-974E-2FD66E4CB69D")
interface IDMLDeviceChild : IDMLObject
{
    HRESULT GetDevice(const(GUID)* riid, void** ppv);
}

@GUID("B1AB0825-4542-4A4B-8617-6DDE6E8F6201")
interface IDMLPageable : IDMLDeviceChild
{
}

@GUID("26CAAE7A-3081-4633-9581-226FBE57695D")
interface IDMLOperator : IDMLDeviceChild
{
}

@GUID("DCB821A8-1039-441E-9F1C-B1759C2F3CEC")
interface IDMLDispatchable : IDMLPageable
{
    DML_BINDING_PROPERTIES GetBindingProperties();
}

@GUID("6B15E56A-BF5C-4902-92D8-DA3A650AFEA4")
interface IDMLCompiledOperator : IDMLDispatchable
{
}

@GUID("427C1113-435C-469C-8676-4D5DD072F813")
interface IDMLOperatorInitializer : IDMLDispatchable
{
    HRESULT Reset(uint operatorCount, char* operators);
}

@GUID("29C687DC-DE74-4E3B-AB00-1168F2FC3CFC")
interface IDMLBindingTable : IDMLDeviceChild
{
    void    BindInputs(uint bindingCount, char* bindings);
    void    BindOutputs(uint bindingCount, char* bindings);
    void    BindTemporaryResource(const(DML_BINDING_DESC)* binding);
    void    BindPersistentResource(const(DML_BINDING_DESC)* binding);
    HRESULT Reset(const(DML_BINDING_TABLE_DESC)* desc);
}

@GUID("E6857A76-2E3E-4FDD-BFF4-5D2BA10FB453")
interface IDMLCommandRecorder : IDMLDeviceChild
{
    void RecordDispatch(ID3D12CommandList commandList, IDMLDispatchable dispatchable, IDMLBindingTable bindings);
}

@GUID("7D6F3AC9-394A-4AC3-92A7-390CC57A8217")
interface IDMLDebugDevice : IUnknown
{
    void SetMuteDebugOutput(BOOL mute);
}


// GUIDs


const GUID IID_IDMLBindingTable        = GUIDOF!IDMLBindingTable;
const GUID IID_IDMLCommandRecorder     = GUIDOF!IDMLCommandRecorder;
const GUID IID_IDMLCompiledOperator    = GUIDOF!IDMLCompiledOperator;
const GUID IID_IDMLDebugDevice         = GUIDOF!IDMLDebugDevice;
const GUID IID_IDMLDevice              = GUIDOF!IDMLDevice;
const GUID IID_IDMLDeviceChild         = GUIDOF!IDMLDeviceChild;
const GUID IID_IDMLDispatchable        = GUIDOF!IDMLDispatchable;
const GUID IID_IDMLObject              = GUIDOF!IDMLObject;
const GUID IID_IDMLOperator            = GUIDOF!IDMLOperator;
const GUID IID_IDMLOperatorInitializer = GUIDOF!IDMLOperatorInitializer;
const GUID IID_IDMLPageable            = GUIDOF!IDMLPageable;
