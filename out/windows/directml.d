// Written in the D programming language.

module windows.directml;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.direct3d12 : D3D12_CPU_DESCRIPTOR_HANDLE, D3D12_GPU_DESCRIPTOR_HANDLE,
                                   ID3D12CommandList, ID3D12Device, ID3D12Resource;
public import windows.systemservices : BOOL, PWSTR;

extern(Windows) @nogc nothrow:


// Enums


///Specifies the data type of the values in a tensor. DirectML operators may not support all data types; see the
///documentation for each specific operator to find which data types it supports.
alias DML_TENSOR_DATA_TYPE = int;
enum : int
{
    ///Indicates an unknown data type. This value is never valid.
    DML_TENSOR_DATA_TYPE_UNKNOWN = 0x00000000,
    ///Indicates a 32-bit floating-point data type.
    DML_TENSOR_DATA_TYPE_FLOAT32 = 0x00000001,
    ///Indicates a 16-bit floating-point data type.
    DML_TENSOR_DATA_TYPE_FLOAT16 = 0x00000002,
    ///Indicates a 32-bit unsigned integer data type.
    DML_TENSOR_DATA_TYPE_UINT32  = 0x00000003,
    ///Indicates a 16-bit unsigned integer data type.
    DML_TENSOR_DATA_TYPE_UINT16  = 0x00000004,
    ///Indicates a 8-bit unsigned integer data type.
    DML_TENSOR_DATA_TYPE_UINT8   = 0x00000005,
    ///Indicates a 32-bit signed integer data type.
    DML_TENSOR_DATA_TYPE_INT32   = 0x00000006,
    ///Indicates a 16-bit signed integer data type.
    DML_TENSOR_DATA_TYPE_INT16   = 0x00000007,
    DML_TENSOR_DATA_TYPE_INT8    = 0x00000008,
}

///Identifies a type of tensor description.
alias DML_TENSOR_TYPE = int;
enum : int
{
    ///Indicates an unknown tensor description type. This value is never valid.
    DML_TENSOR_TYPE_INVALID = 0x00000000,
    DML_TENSOR_TYPE_BUFFER  = 0x00000001,
}

///Specifies additional options in a tensor description. Values can be bitwise OR'd together.
alias DML_TENSOR_FLAGS = int;
enum : int
{
    ///No options are specified.
    DML_TENSOR_FLAG_NONE         = 0x00000000,
    ///Indicates that the tensor data should be owned and managed by DirectML. The effect of this flag is that DirectML
    ///makes a copy of the tensor data during initialization of an operator, storing it in the persistent resource. This
    ///allows DirectML to perform reformatting of the tensor data into other, more efficient forms. Setting this flag
    ///may increase performance, but is typically only useful for tensors whose data doesn't change for the lifetime of
    ///the operator (for example, weight tensors). This flag can only be used on input tensors. When this flag is set on
    ///a particular tensor description, the corresponding tensor must be bound to the binding table during operator
    ///initialization, and not during execution. Attempting to bind the tensor during execution while this flag is set
    ///results in an error. This is the opposite of the default behavior (the behavior without the
    ///<b>DML_TENSOR_FLAG_OWNED_BY_DML</b> flag), where the tensor is expected to be bound during execution, and not
    ///during initialization.
    DML_TENSOR_FLAG_OWNED_BY_DML = 0x00000001,
}

///Defines the type of an operator description. See [DML_OPERATOR_DESC](./ns-directml-dml_operator_desc.md) for the
///usage of this enumeration.
alias DML_OPERATOR_TYPE = int;
enum : int
{
    ///Indicates an unknown operator type, and is never valid. Using this value results in an error.
    DML_OPERATOR_INVALID                           = 0x00000000,
    ///Indicates the operator described by the DML_ELEMENT_WISE_IDENTITY_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_IDENTITY             = 0x00000001,
    ///Indicates the operator described by the DML_ELEMENT_WISE_ABS_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_ABS                  = 0x00000002,
    ///Indicates the operator described by the DML_ELEMENT_WISE_ACOS_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_ACOS                 = 0x00000003,
    ///Indicates the operator described by the DML_ELEMENT_WISE_ADD_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_ADD                  = 0x00000004,
    ///Indicates the operator described by the DML_ELEMENT_WISE_ASIN_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_ASIN                 = 0x00000005,
    ///Indicates the operator described by the DML_ELEMENT_WISE_ATAN_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_ATAN                 = 0x00000006,
    ///Indicates the operator described by the DML_ELEMENT_WISE_CEIL_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_CEIL                 = 0x00000007,
    ///Indicates the operator described by the DML_ELEMENT_WISE_CLIP_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_CLIP                 = 0x00000008,
    ///Indicates the operator described by the DML_ELEMENT_WISE_COS_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_COS                  = 0x00000009,
    ///Indicates the operator described by the DML_ELEMENT_WISE_DIVIDE_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_DIVIDE               = 0x0000000a,
    ///Indicates the operator described by the DML_ELEMENT_WISE_EXP_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_EXP                  = 0x0000000b,
    ///Indicates the operator described by the DML_ELEMENT_WISE_FLOOR_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_FLOOR                = 0x0000000c,
    ///Indicates the operator described by the DML_ELEMENT_WISE_LOG_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_LOG                  = 0x0000000d,
    ///Indicates the operator described by the DML_ELEMENT_WISE_LOGICAL_AND_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_LOGICAL_AND          = 0x0000000e,
    ///Indicates the operator described by the DML_ELEMENT_WISE_LOGICAL_EQUALS_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_LOGICAL_EQUALS       = 0x0000000f,
    ///Indicates the operator described by the DML_ELEMENT_WISE_LOGICAL_GREATER_THAN_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_LOGICAL_GREATER_THAN = 0x00000010,
    ///Indicates the operator described by the DML_ELEMENT_WISE_LOGICAL_LESS_THAN_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_LOGICAL_LESS_THAN    = 0x00000011,
    ///Indicates the operator described by the DML_ELEMENT_WISE_LOGICAL_NOT_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_LOGICAL_NOT          = 0x00000012,
    ///Indicates the operator described by the DML_ELEMENT_WISE_LOGICAL_OR_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_LOGICAL_OR           = 0x00000013,
    ///Indicates the operator described by the DML_ELEMENT_WISE_LOGICAL_XOR_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_LOGICAL_XOR          = 0x00000014,
    ///Indicates the operator described by the DML_ELEMENT_WISE_MAX_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_MAX                  = 0x00000015,
    ///Indicates the operator described by the DML_ELEMENT_WISE_MEAN_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_MEAN                 = 0x00000016,
    ///Indicates the operator described by the DML_ELEMENT_WISE_MIN_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_MIN                  = 0x00000017,
    ///Indicates the operator described by the DML_ELEMENT_WISE_MULTIPLY_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_MULTIPLY             = 0x00000018,
    ///Indicates the operator described by the DML_ELEMENT_WISE_POW_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_POW                  = 0x00000019,
    ///Indicates the operator described by the DML_ELEMENT_WISE_CONSTANT_POW_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_CONSTANT_POW         = 0x0000001a,
    ///Indicates the operator described by the DML_ELEMENT_WISE_RECIP_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_RECIP                = 0x0000001b,
    ///Indicates the operator described by the DML_ELEMENT_WISE_SIN_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_SIN                  = 0x0000001c,
    ///Indicates the operator described by the DML_ELEMENT_WISE_SQRT_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_SQRT                 = 0x0000001d,
    ///Indicates the operator described by the DML_ELEMENT_WISE_SUBTRACT_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_SUBTRACT             = 0x0000001e,
    ///Indicates the operator described by the DML_ELEMENT_WISE_TAN_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_TAN                  = 0x0000001f,
    ///Indicates the operator described by the DML_ELEMENT_WISE_THRESHOLD_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_THRESHOLD            = 0x00000020,
    ///Indicates the operator described by the DML_ELEMENT_WISE_QUANTIZE_LINEAR_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_QUANTIZE_LINEAR      = 0x00000021,
    ///Indicates the operator described by the DML_ELEMENT_WISE_DEQUANTIZE_LINEAR_OPERATOR_DESC structure.
    DML_OPERATOR_ELEMENT_WISE_DEQUANTIZE_LINEAR    = 0x00000022,
    ///Indicates the operator described by the DML_ACTIVATION_ELU_OPERATOR_DESC structure.
    DML_OPERATOR_ACTIVATION_ELU                    = 0x00000023,
    ///Indicates the operator described by the DML_ACTIVATION_HARDMAX_OPERATOR_DESC structure.
    DML_OPERATOR_ACTIVATION_HARDMAX                = 0x00000024,
    ///Indicates the operator described by the DML_ACTIVATION_HARD_SIGMOID_OPERATOR_DESC structure.
    DML_OPERATOR_ACTIVATION_HARD_SIGMOID           = 0x00000025,
    ///Indicates the operator described by the DML_ACTIVATION_IDENTITY_OPERATOR_DESC structure.
    DML_OPERATOR_ACTIVATION_IDENTITY               = 0x00000026,
    ///Indicates the operator described by the DML_ACTIVATION_LEAKY_RELU_OPERATOR_DESC structure.
    DML_OPERATOR_ACTIVATION_LEAKY_RELU             = 0x00000027,
    ///Indicates the operator described by the DML_ACTIVATION_LINEAR_OPERATOR_DESC structure.
    DML_OPERATOR_ACTIVATION_LINEAR                 = 0x00000028,
    ///Indicates the operator described by the DML_ACTIVATION_LOG_SOFTMAX_OPERATOR_DESC structure.
    DML_OPERATOR_ACTIVATION_LOG_SOFTMAX            = 0x00000029,
    ///Indicates the operator described by the DML_ACTIVATION_PARAMETERIZED_RELU_OPERATOR_DESC structure.
    DML_OPERATOR_ACTIVATION_PARAMETERIZED_RELU     = 0x0000002a,
    ///Indicates the operator described by the DML_ACTIVATION_PARAMETRIC_SOFTPLUS_OPERATOR_DESC structure.
    DML_OPERATOR_ACTIVATION_PARAMETRIC_SOFTPLUS    = 0x0000002b,
    ///Indicates the operator described by the DML_ACTIVATION_RELU_OPERATOR_DESC structure.
    DML_OPERATOR_ACTIVATION_RELU                   = 0x0000002c,
    ///Indicates the operator described by the DML_ACTIVATION_SCALED_ELU_OPERATOR_DESC structure.
    DML_OPERATOR_ACTIVATION_SCALED_ELU             = 0x0000002d,
    ///Indicates the operator described by the DML_ACTIVATION_SCALED_TANH_OPERATOR_DESC structure.
    DML_OPERATOR_ACTIVATION_SCALED_TANH            = 0x0000002e,
    ///Indicates the operator described by the DML_ACTIVATION_SIGMOID_OPERATOR_DESC structure.
    DML_OPERATOR_ACTIVATION_SIGMOID                = 0x0000002f,
    ///Indicates the operator described by the DML_ACTIVATION_SOFTMAX_OPERATOR_DESC structure.
    DML_OPERATOR_ACTIVATION_SOFTMAX                = 0x00000030,
    ///Indicates the operator described by the DML_ACTIVATION_SOFTPLUS_OPERATOR_DESC structure.
    DML_OPERATOR_ACTIVATION_SOFTPLUS               = 0x00000031,
    ///Indicates the operator described by the DML_ACTIVATION_SOFTSIGN_OPERATOR_DESC structure.
    DML_OPERATOR_ACTIVATION_SOFTSIGN               = 0x00000032,
    ///Indicates the operator described by the DML_ACTIVATION_TANH_OPERATOR_DESC structure.
    DML_OPERATOR_ACTIVATION_TANH                   = 0x00000033,
    ///Indicates the operator described by the DML_ACTIVATION_THRESHOLDED_RELU_OPERATOR_DESC structure.
    DML_OPERATOR_ACTIVATION_THRESHOLDED_RELU       = 0x00000034,
    ///Indicates the operator described by the DML_CONVOLUTION_OPERATOR_DESC structure.
    DML_OPERATOR_CONVOLUTION                       = 0x00000035,
    ///Indicates the operator described by the DML_GEMM_OPERATOR_DESC structure.
    DML_OPERATOR_GEMM                              = 0x00000036,
    ///Indicates the operator described by the DML_REDUCE_OPERATOR_DESC structure.
    DML_OPERATOR_REDUCE                            = 0x00000037,
    ///Indicates the operator described by the DML_AVERAGE_POOLING_OPERATOR_DESC structure.
    DML_OPERATOR_AVERAGE_POOLING                   = 0x00000038,
    ///Indicates the operator described by the DML_LP_POOLING_OPERATOR_DESC structure.
    DML_OPERATOR_LP_POOLING                        = 0x00000039,
    ///Indicates the operator described by the DML_MAX_POOLING_OPERATOR_DESC structure.
    DML_OPERATOR_MAX_POOLING                       = 0x0000003a,
    ///Indicates the operator described by the DML_ROI_POOLING_OPERATOR_DESC structure.
    DML_OPERATOR_ROI_POOLING                       = 0x0000003b,
    ///Indicates the operator described by the DML_SLICE_OPERATOR_DESC structure.
    DML_OPERATOR_SLICE                             = 0x0000003c,
    ///Indicates the operator described by the DML_CAST_OPERATOR_DESC structure.
    DML_OPERATOR_CAST                              = 0x0000003d,
    ///Indicates the operator described by the DML_SPLIT_OPERATOR_DESC structure.
    DML_OPERATOR_SPLIT                             = 0x0000003e,
    ///Indicates the operator described by the DML_JOIN_OPERATOR_DESC structure.
    DML_OPERATOR_JOIN                              = 0x0000003f,
    ///Indicates the operator described by the DML_PADDING_OPERATOR_DESC structure.
    DML_OPERATOR_PADDING                           = 0x00000040,
    ///Indicates the operator described by the DML_VALUE_SCALE_2D_OPERATOR_DESC structure.
    DML_OPERATOR_VALUE_SCALE_2D                    = 0x00000041,
    ///Indicates the operator described by the DML_UPSAMPLE_2D_OPERATOR_DESC structure.
    DML_OPERATOR_UPSAMPLE_2D                       = 0x00000042,
    ///Indicates the operator described by the DML_GATHER_OPERATOR_DESC structure.
    DML_OPERATOR_GATHER                            = 0x00000043,
    ///Indicates the operator described by the DML_SPACE_TO_DEPTH_OPERATOR_DESC structure.
    DML_OPERATOR_SPACE_TO_DEPTH                    = 0x00000044,
    ///Indicates the operator described by the DML_DEPTH_TO_SPACE_OPERATOR_DESC structure.
    DML_OPERATOR_DEPTH_TO_SPACE                    = 0x00000045,
    ///Indicates the operator described by the DML_TILE_OPERATOR_DESC structure.
    DML_OPERATOR_TILE                              = 0x00000046,
    ///Indicates the operator described by the DML_TOP_K_OPERATOR_DESC structure.
    DML_OPERATOR_TOP_K                             = 0x00000047,
    ///Indicates the operator described by the DML_BATCH_NORMALIZATION_OPERATOR_DESC structure.
    DML_OPERATOR_BATCH_NORMALIZATION               = 0x00000048,
    ///Indicates the operator described by the DML_MEAN_VARIANCE_NORMALIZATION_OPERATOR_DESC structure.
    DML_OPERATOR_MEAN_VARIANCE_NORMALIZATION       = 0x00000049,
    ///Indicates the operator described by the DML_LOCAL_RESPONSE_NORMALIZATION_OPERATOR_DESC structure.
    DML_OPERATOR_LOCAL_RESPONSE_NORMALIZATION      = 0x0000004a,
    ///Indicates the operator described by the DML_LP_NORMALIZATION_OPERATOR_DESC structure.
    DML_OPERATOR_LP_NORMALIZATION                  = 0x0000004b,
    ///Indicates the operator described by the DML_RNN_OPERATOR_DESC structure.
    DML_OPERATOR_RNN                               = 0x0000004c,
    ///Indicates the operator described by the DML_LSTM_OPERATOR_DESC structure.
    DML_OPERATOR_LSTM                              = 0x0000004d,
    ///Indicates the operator described by the DML_GRU_OPERATOR_DESC structure.
    DML_OPERATOR_GRU                               = 0x0000004e,
    ///Indicates the operator described by the
    ///[DML_ELEMENT_WISE_SIGN_OPERATOR_DESC](ns-directml-dml_element_wise_sign_operator_desc) structure.
    DML_OPERATOR_ELEMENT_WISE_SIGN                 = 0x0000004f,
    ///Indicates the operator described by the
    ///[DML_ELEMENT_WISE_IS_NAN_OPERATOR_DESC](ns-directml-dml_element_wise_is_nan_operator_desc) structure.
    DML_OPERATOR_ELEMENT_WISE_IS_NAN               = 0x00000050,
    ///Indicates the operator described by the
    ///[DML_ELEMENT_WISE_ERF_OPERATOR_DESC](ns-directml-dml_element_wise_erf_operator_desc) structure.
    DML_OPERATOR_ELEMENT_WISE_ERF                  = 0x00000051,
    ///Indicates the operator described by the
    ///[DML_ELEMENT_WISE_SINH_OPERATOR_DESC](ns-directml-dml_element_wise_sinh_operator_desc) structure.
    DML_OPERATOR_ELEMENT_WISE_SINH                 = 0x00000052,
    ///Indicates the operator described by the
    ///[DML_ELEMENT_WISE_COSH_OPERATOR_DESC](ns-directml-dml_element_wise_cosh_operator_desc) structure.
    DML_OPERATOR_ELEMENT_WISE_COSH                 = 0x00000053,
    ///Indicates the operator described by the
    ///[DML_ELEMENT_WISE_TANH_OPERATOR_DESC](ns-directml-dml_element_wise_tanh_operator_desc) structure.
    DML_OPERATOR_ELEMENT_WISE_TANH                 = 0x00000054,
    ///Indicates the operator described by the
    ///[DML_ELEMENT_WISE_ASINH_OPERATOR_DESC](ns-directml-dml_element_wise_asinh_operator_desc) structure.
    DML_OPERATOR_ELEMENT_WISE_ASINH                = 0x00000055,
    ///Indicates the operator described by the
    ///[DML_ELEMENT_WISE_ACOSH_OPERATOR_DESC](ns-directml-dml_element_wise_acosh_operator_desc) structure.
    DML_OPERATOR_ELEMENT_WISE_ACOSH                = 0x00000056,
    ///Indicates the operator described by the
    ///[DML_ELEMENT_WISE_ATANH_OPERATOR_DESC](ns-directml-dml_element_wise_atanh_operator_desc) structure.
    DML_OPERATOR_ELEMENT_WISE_ATANH                = 0x00000057,
    ///Indicates the operator described by the
    ///[DML_ELEMENT_WISE_IF_OPERATOR_DESC](ns-directml-dml_element_wise_if_operator_desc) structure.
    DML_OPERATOR_ELEMENT_WISE_IF                   = 0x00000058,
    ///Indicates the operator described by the
    ///[DML_ELEMENT_WISE_ADD1_OPERATOR_DESC](ns-directml-dml_element_wise_add1_operator_desc) structure.
    DML_OPERATOR_ELEMENT_WISE_ADD1                 = 0x00000059,
    ///Indicates the operator described by the
    ///[DML_ACTIVATION_SHRINK_OPERATOR_DESC](ns-directml-dml_activation_shrink_operator_desc) structure.
    DML_OPERATOR_ACTIVATION_SHRINK                 = 0x0000005a,
    ///Indicates the operator described by the
    ///[DML_MAX_POOLING1_OPERATOR_DESC](ns-directml-dml_max_pooling1_operator_desc) structure.
    DML_OPERATOR_MAX_POOLING1                      = 0x0000005b,
    ///Indicates the operator described by the
    ///[DML_MAX_UNPOOLING_OPERATOR_DESC](ns-directml-dml_max_unpooling_operator_desc) structure.
    DML_OPERATOR_MAX_UNPOOLING                     = 0x0000005c,
    ///Indicates the operator described by the
    ///[DML_DIAGONAL_MATRIX_OPERATOR_DESC](ns-directml-dml_diagonal_matrix_operator_desc) structure.
    DML_OPERATOR_DIAGONAL_MATRIX                   = 0x0000005d,
    ///Indicates the operator described by the [DML_SCATTER_OPERATOR_DESC](ns-directml-dml_scatter_operator_desc)
    ///structure.
    DML_OPERATOR_SCATTER                           = 0x0000005e,
    ///Indicates the operator described by the [DML_ONE_HOT_OPERATOR_DESC](ns-directml-dml_one_hot_operator_desc)
    ///structure.
    DML_OPERATOR_ONE_HOT                           = 0x0000005f,
    ///Indicates the operator described by the [DML_RESAMPLE_OPERATOR_DESC](ns-directml-dml_resample_operator_desc)
    ///structure.
    DML_OPERATOR_RESAMPLE                          = 0x00000060,
}

///Defines constants that specify the specific reduction algorithm to use for the DirectML reduce operator (as described
///by the [DML_REDUCE_OPERATOR_DESC](/windows/win32/api/directml/ns-directml-dml_reduce_operator_desc) structure).
alias DML_REDUCE_FUNCTION = int;
enum : int
{
    ///Indicates a reduction function that computes the indices of the max elements of the input tensor's elements along
    ///the specified axis, int32 {i j k ..} = maxindex(X Y Z …).
    DML_REDUCE_FUNCTION_ARGMAX      = 0x00000000,
    ///Indicates a reduction function that computes the indices of the min elements of the input tensor's elements along
    ///the specified axis, int32 {i j k ..} = minindex(X Y Z …).
    DML_REDUCE_FUNCTION_ARGMIN      = 0x00000001,
    ///Indicates a reduction function that computes the mean of the input tensor's elements along the specified axes, x
    ///= (x1 + x2 + ... + xn) / n.
    DML_REDUCE_FUNCTION_AVERAGE     = 0x00000002,
    ///Indicates a reduction function that computes the L1 norm of the input tensor's elements along the specified axes,
    ///x = |x1| + |x2| + ... + |xn|.
    DML_REDUCE_FUNCTION_L1          = 0x00000003,
    ///Indicates a reduction function that computes the L2 norm of the input tensor's elements along the specified axes,
    ///x = sqrt(x1^2 + x2^2 + ... + xn^2).
    DML_REDUCE_FUNCTION_L2          = 0x00000004,
    ///Indicates a reduction function that computes the log sum of the input tensor's elements along the specified axes,
    ///x = log(x1 + x2 + ... + xn).
    DML_REDUCE_FUNCTION_LOG_SUM     = 0x00000005,
    ///Indicates a reduction function that computes the log sum exponent of the input tensor's elements along the
    ///specified axes, x = log(exp(x1) + exp(x2) + ... + exp(xn)).
    DML_REDUCE_FUNCTION_LOG_SUM_EXP = 0x00000006,
    ///Indicates a reduction function that computes the max of the input tensor's elements along the specified axes, x =
    ///max(max(max(x1, x2), x3), ..., xn).
    DML_REDUCE_FUNCTION_MAX         = 0x00000007,
    ///Indicates a reduction function that computes the min of the input tensor's elements along the specified axes, x =
    ///min(min(min(x1, x2), x3), ..., xn).
    DML_REDUCE_FUNCTION_MIN         = 0x00000008,
    ///Indicates a reduction function that computes the product of the input tensor's elements along the specified axes,
    ///x = (x1 * x2 * ... * xn).
    DML_REDUCE_FUNCTION_MULTIPLY    = 0x00000009,
    ///Indicates a reduction function that computes the sum of the input tensor's elements along the specified axes, x =
    ///(x1 + x2 + ... + xn).
    DML_REDUCE_FUNCTION_SUM         = 0x0000000a,
    ///Indicates a reduction function that computes the sum square of the input tensor's elements along the specified
    ///axes, x = x1^2 + x2^2 + ... + xn^2.
    DML_REDUCE_FUNCTION_SUM_SQUARE  = 0x0000000b,
}

///Defines constants that specify a matrix transform to be applied to a DirectML tensor.
alias DML_MATRIX_TRANSFORM = int;
enum : int
{
    ///Specifies that no transform is to be applied.
    DML_MATRIX_TRANSFORM_NONE      = 0x00000000,
    DML_MATRIX_TRANSFORM_TRANSPOSE = 0x00000001,
}

///Defines constants that specify a mode for the DirectML convolution operator (as described by the
///[DML_CONVOLUTION_OPERATOR_DESC](/windows/win32/api/directml/ns-directml-dml_convolution_operator_desc) structure).
alias DML_CONVOLUTION_MODE = int;
enum : int
{
    ///Specifies the convolution mode.
    DML_CONVOLUTION_MODE_CONVOLUTION       = 0x00000000,
    ///Specifies the cross-correlation mode. If in doubt, use this mode—it is appropriate for the vast majority of
    ///machine learning (ML) models.
    DML_CONVOLUTION_MODE_CROSS_CORRELATION = 0x00000001,
}

///Defines constants that specify a direction for the DirectML convolution operator (as described by the
///[DML_CONVOLUTION_OPERATOR_DESC](./ns-directml-dml_convolution_operator_desc.md) structure).
alias DML_CONVOLUTION_DIRECTION = int;
enum : int
{
    ///Indicates a forward convolution.
    DML_CONVOLUTION_DIRECTION_FORWARD  = 0x00000000,
    ///Indicates a backward convolution. Backward convolution is also known as <em>transposed</em> convolution.
    DML_CONVOLUTION_DIRECTION_BACKWARD = 0x00000001,
}

///Defines constants that specify a mode for the DirectML pad operator (as described by the
///[DML_PADDING_OPERATOR_DESC](/windows/win32/api/directml/ns-directml-dml_padding_operator_desc) structure).
alias DML_PADDING_MODE = int;
enum : int
{
    ///Indicates padding with a constant.
    DML_PADDING_MODE_CONSTANT   = 0x00000000,
    ///Indicates edge mode for padding.
    DML_PADDING_MODE_EDGE       = 0x00000001,
    ///Indicates reflection mode for padding.
    DML_PADDING_MODE_REFLECTION = 0x00000002,
}

///Defines constants that specify a mode for the DirectML upsample 2-D operator (as described by the
///[DML_UPSAMPLE_2D_OPERATOR_DESC](/windows/win32/api/directml/ns-directml-dml_upsample_2d_operator_desc) structure).
alias DML_INTERPOLATION_MODE = int;
enum : int
{
    ///Specifies the nearest-neighbor mode.
    DML_INTERPOLATION_MODE_NEAREST_NEIGHBOR = 0x00000000,
    ///Specifies a linear (including bilinear, trilinear, etc.) mode.
    DML_INTERPOLATION_MODE_LINEAR           = 0x00000001,
}

///Defines constants that specify a direction for a recurrent DirectML operator.
alias DML_RECURRENT_NETWORK_DIRECTION = int;
enum : int
{
    ///Indicates the forward pass.
    DML_RECURRENT_NETWORK_DIRECTION_FORWARD       = 0x00000000,
    ///Indicates the backward pass.
    DML_RECURRENT_NETWORK_DIRECTION_BACKWARD      = 0x00000001,
    DML_RECURRENT_NETWORK_DIRECTION_BIDIRECTIONAL = 0x00000002,
}

///Defines constants that specify a DirectML *feature level*. A feature level defines a broad umbrella of functionality
///supported by DirectML. In using DirectML, you can target specific feature levels, depending on a tradeoff between the
///level of functionality needed versus the version of DirectML required. Feature levels in DirectML are strict
///supersets of one another. This means that every feature level necessarily supports everything that exists in every
///feature level below (earlier than) it. For example, `DML_FEATURE_LEVEL_2_0` supports everything that
///`DML_FEATURE_LEVEL_1_0` does in addition to some new functionality. Similarly, `DML_FEATURE_LEVEL_2_1` supports
///everything that `DML_FEATURE_LEVEL_2_0` and `DML_FEATURE_LEVEL_1_0` do plus some additional features. You can specify
///a *minimum feature level* when creating the DirectML device using
///[DMLCreateDevice1](/windows/win32/api/directml/nf-directml-dmlcreatedevice1). This has the effect of causing device
///creation to fail if the underlying DirectML implementation is unable to satisfy the requested feature level. This is
///useful, for example, if using the system version of DirectML and a user runs your application on an older version of
///Windows 10. A DirectML device might support feature levels above the minimum feature level requested through
///**DMLCreateDevice1**. You can query the device for its supported feature levels using
///[IDMLDevice::CheckFeatureSupport](/windows/win32/api/directml/nf-directml-idmldevice-checkfeaturesupport). For a list
///of new capabilities included in each feature level, see [DirectML feature level
///history](/windows/win32/direct3d12/dml-feature-level-history).
alias DML_FEATURE_LEVEL = int;
enum : int
{
    ///Specifies feature level 1_0.
    DML_FEATURE_LEVEL_1_0 = 0x00001000,
    ///Specifies feature level 2_0.
    DML_FEATURE_LEVEL_2_0 = 0x00002000,
}

///Defines a set of optional features and capabilities that can be queried from the DirectML device. See
///[IDMLDevice::CheckFeatureSupport](/windows/win32/api/directml/nf-directml-idmldevice-checkfeaturesupport).
alias DML_FEATURE = int;
enum : int
{
    ///Allows querying for tensor data type support. The query type is
    ///[DML_FEATURE_QUERY_TENSOR_DATA_TYPE_SUPPORT](/windows/win32/api/directml/ns-directml-dml_feature_query_tensor_data_type_support),
    ///and the support data type is
    ///[DML_FEATURE_DATA_TENSOR_DATA_TYPE_SUPPORT](/windows/win32/api/directml/ns-directml-dml_feature_data_tensor_data_type_support).
    DML_FEATURE_TENSOR_DATA_TYPE_SUPPORT = 0x00000000,
    ///Allows querying for the feature levels supported by the device. The query type is
    ///[DML_FEATURE_QUERY_FEATURE_LEVELS](/windows/win32/api/directml/ns-directml-dml_feature_query_feature_levels), and
    ///the support data type is
    ///[DML_FEATURE_DATA_FEATURE_LEVELS](/windows/win32/api/directml/ns-directml-dml_feature_data_feature_levels).
    DML_FEATURE_FEATURE_LEVELS           = 0x00000001,
}

///Supplies options to DirectML to control execution of operators. These flags can be bitwise OR'd together to specify
///multiple flags at once.
alias DML_EXECUTION_FLAGS = int;
enum : int
{
    ///No execution flags are specified.
    DML_EXECUTION_FLAG_NONE                             = 0x00000000,
    ///Allows DirectML to perform computation using half-precision floating-point (FP16), if supported by the hardware
    ///device.
    DML_EXECUTION_FLAG_ALLOW_HALF_PRECISION_COMPUTATION = 0x00000001,
    ///Forces DirectML execute the operator using DirectCompute instead of meta commands. DirectML uses meta commands by
    ///default, if available.
    DML_EXECUTION_FLAG_DISABLE_META_COMMANDS            = 0x00000002,
    ///Allows changes to bindings after an operator's execution has been recorded in a command list, but before it has
    ///been submitted to the command queue. By default, without this flag set, you must set all bindings on the binding
    ///table before you record an operator into a command list. This flag allows you to perform late binding—that is,
    ///to set (or to change) bindings on operators that you've already recorded into a command list. However, this may
    ///result in a performance penalty on some hardware, as it prohibits drivers from promoting static descriptor
    ///accesses to root descriptor accesses. For more info, see <a
    ///href="/windows/win32/direct3d12/root-signature-version-1-1
    DML_EXECUTION_FLAG_DESCRIPTORS_VOLATILE             = 0x00000004,
}

///Supplies additional device creation options to
///[DMLCreateDevice](/windows/win32/api/directml/nf-directml-dmlcreatedevice). Values can be bitwise OR'd together.
alias DML_CREATE_DEVICE_FLAGS = int;
enum : int
{
    ///No creation options are specified.
    DML_CREATE_DEVICE_FLAG_NONE  = 0x00000000,
    DML_CREATE_DEVICE_FLAG_DEBUG = 0x00000001,
}

///Defines constants that specify the nature of the resource(s) referred to by a binding description (a
///[DML_BINDING_DESC](./ns-directml-dml_binding_desc.md) structure).
alias DML_BINDING_TYPE = int;
enum : int
{
    ///Indicates that no resources are to be bound.
    DML_BINDING_TYPE_NONE         = 0x00000000,
    ///Specifies a binding that binds a single buffer to the binding table. The corresponding binding desc type is
    ///DML_BUFFER_BINDING.
    DML_BINDING_TYPE_BUFFER       = 0x00000001,
    ///Specifies a binding that binds an array of buffers to the binding table. The corresponding binding desc type is
    ///DML_BUFFER_ARRAY_BINDING.
    DML_BINDING_TYPE_BUFFER_ARRAY = 0x00000002,
}

// Constants


enum uint DML_TENSOR_DIMENSION_COUNT_MAX = 0x00000005;
enum uint DML_PERSISTENT_BUFFER_ALIGNMENT = 0x00000100;

// Structs


///Describes a tensor that will be stored in a Direct3D 12 buffer resource. The corresponding tensor type is
///[DML_TENSOR_TYPE_BUFFER](/windows/win32/api/directml/ne-directml-dml_tensor_type), and the corresponding binding type
///is [DML_BINDING_TYPE_BUFFER](/windows/win32/api/directml/ne-directml-dml_binding_type).
struct DML_BUFFER_TENSOR_DESC
{
    ///Type: [**DML_TENSOR_DATA_TYPE**](/windows/win32/api/directml/ne-directml-dml_tensor_data_type) The type of the
    ///values in the tensor.
    DML_TENSOR_DATA_TYPE DataType;
    ///Type: [**DML_TENSOR_FLAGS**](/windows/win32/api/directml/ne-directml-dml_tensor_flags) Specifies additional
    ///options for the tensor.
    DML_TENSOR_FLAGS     Flags;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The number of dimensions of the tensor. This member
    ///determines the size of the <i>Sizes</i> and <i>Strides</i> arrays (if provided). In DirectML, all buffer tensors
    ///must have a *DimensionCount* of either 4 or 5. Not all operators support a *DimensionCount* of 5.
    uint                 DimensionCount;
    ///Type: <b>const [UINT](/windows/desktop/winprog/windows-data-types)*</b> The size, in elements, of each dimension
    ///in the tensor. Specifying a size of zero in any dimension is invalid, and will result in an error. The *Sizes*
    ///member is always specified in the order {N, C, H, W} if *DimensionCount* is 4, and {N, C, D, H, W} if
    ///*DimensionCount* is 5.
    const(uint)*         Sizes;
    ///Type: <b>const [UINT](/windows/desktop/winprog/windows-data-types)*</b> Optional. Determines the number of
    ///elements (not bytes) to linearly traverse in order to reach the next element in that dimension. For example, a
    ///stride of 5 in dimension 1 means that the distance between elements (n) and (n+1) in that dimension is 5 elements
    ///when traversing the buffer linearly. The *Strides* member is always specified in the order {N, C, H, W} if
    ///*DimensionCount* is 4, and {N, C, D, H, W} if *DimensionCount* is 5. <i>Strides</i> can be used to express
    ///broadcasting (by specifying a stride of 0) as well as padding (for example, by using a stride larger than the
    ///physical size of a row, to pad the end of a row). If <i>Strides</i> is not specified, each dimension in the
    ///tensor is considered to be contiguously packed, with no additional padding.
    const(uint)*         Strides;
    ///Type: <b>UINT64</b> Defines a minimum size in bytes for the buffer that will contain this tensor.
    ///<i>TotalTensorSizeInBytes</i> must be at least as large as the minimum implied size given the sizes, strides, and
    ///data type of the tensor. You can calculate the minimum implied size by calling the
    ///[DMLCalcBufferTensorSize](/windows/desktop/direct3d12/dml-helper-functions
    ulong                TotalTensorSizeInBytes;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) Optional. Defines a minimum guaranteed alignment in
    ///bytes for the base offset of the buffer range that will contain this tensor, or 0 to provide no minimum
    ///guaranteed alignment. If specified, this value must be a power of two that is at least as large as the element
    ///size. When binding this tensor, the offset in bytes of the buffer range from the start of the buffer must be a
    ///multiple of the <i>GuaranteedBaseOffsetAlignment</i>, if provided. Buffer tensors always have a minimum alignment
    ///of 16 bytes. However, providing a larger value for the <i>GuaranteedBaseOffsetAlignment</i> may allow DirectML to
    ///achieve better performance, because a larger alignment enables the use of vectorized load/store instructions.
    ///Although this member is optional, for best performance we recommend that you align tensors to boundaries of 32
    ///bytes or more, where possible.
    uint                 GuaranteedBaseOffsetAlignment;
}

///A generic container for a DirectML tensor description.
struct DML_TENSOR_DESC
{
    ///Type: [**DML_TENSOR_TYPE**](./ne-directml-dml_tensor_type.md) The type of the tensor description. See
    ///DML_TENSOR_TYPE for the available types.
    DML_TENSOR_TYPE Type;
    const(void)*    Desc;
}

///Contains the values of scale and bias terms supplied to a DirectML operator. Scale and bias have the effect of
///applying the function g(x) = x * <i>Scale</i> + <i>Bias</i>.
struct DML_SCALE_BIAS
{
    ///Type: <b>FLOAT</b> The scale term in g(x) = x * <i>Scale</i> + <i>Bias</i>.
    float Scale;
    float Bias;
}

///Contains values that can represent the size (as supplied to a DirectML operator) of a 2-D plane of elements within a
///tensor, or a 2-D scale, or any 2-D width/height value.
struct DML_SIZE_2D
{
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The width.
    uint Width;
    uint Height;
}

///A generic container for an operator description. You construct DirectML operators using the parameters specified in
///this struct. See [IDMLDevice::CreateOperator](/windows/win32/api/directml/nf-directml-idmldevice-createoperator) for
///additional details.
struct DML_OPERATOR_DESC
{
    ///Type: [**DML_OPERATOR_TYPE**](/windows/win32/api/directml/ne-directml-dml_operator_type) The type of the operator
    ///description. See DML_OPERATOR_TYPE for the available types.
    DML_OPERATOR_TYPE Type;
    const(void)*      Desc;
}

///Computes the identity for each element of *InputTensor*, placing the result into the corresponding element of
///*OutputTensor*. ``` f(x) = x ``` This operator supports in-place execution, meaning that *OutputTensor* is permitted
///to alias *InputTensor* during binding.
struct DML_ELEMENT_WISE_IDENTITY_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: \_Maybenull\_ **const [DML_SCALE_BIAS](/windows/win32/api/directml/ns-directml-dml_scale_bias)\*** An
    ///optional scale and bias to apply to the input. If present, this has the effect of applying the function `g(x) = x
    ///* scale + bias` to each *input* element prior to computing this operator.
    const(DML_SCALE_BIAS)* ScaleBias;
}

///Computes the absolute value for each element of *InputTensor*, placing the result into the corresponding element of
///*OutputTensor*. ``` f(x) = abs(x) ``` This operator supports in-place execution, meaning that *OutputTensor* is
///permitted to alias *InputTensor* during binding.
struct DML_ELEMENT_WISE_ABS_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: \_Maybenull\_ **const [DML_SCALE_BIAS](/windows/win32/api/directml/ns-directml-dml_scale_bias)\*** An
    ///optional scale and bias to apply to the input. If present, this has the effect of applying the function `g(x) = x
    ///* scale + bias` to each *input* element prior to computing this operator.
    const(DML_SCALE_BIAS)* ScaleBias;
}

///Computes the arccosine for each element of *InputTensor*, placing the result into the corresponding element of
///*OutputTensor*. ``` f(x) = acos(x) ``` This operator supports in-place execution, meaning that *OutputTensor* is
///permitted to alias *InputTensor* during binding.
struct DML_ELEMENT_WISE_ACOS_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: \_Maybenull\_ **const [DML_SCALE_BIAS](/windows/win32/api/directml/ns-directml-dml_scale_bias)\*** An
    ///optional scale and bias to apply to the input. If present, this has the effect of applying the function `g(x) = x
    ///* scale + bias` to each *input* element prior to computing this operator.
    const(DML_SCALE_BIAS)* ScaleBias;
}

///Adds every element in *ATensor* to its corresponding element in *BTensor*, placing the result into the corresponding
///element of *OutputTensor*. ``` f(a, b) = a + b ``` This operator supports in-place execution, meaning that
///*OutputTensor* is permitted to alias one or more of the input tensors during binding.
struct DML_ELEMENT_WISE_ADD_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the left-hand side inputs.
    const(DML_TENSOR_DESC)* ATensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the right-hand side inputs.
    const(DML_TENSOR_DESC)* BTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
}

///Adds every element in *ATensor* to its corresponding element in *BTensor* and places the result into the
///corresponding element of *OutputTensor*, with the option for fused activation. ``` f(a, b) = FusedActivation(a + b)
///``` The fused activation operator description, if provided, then executes the given activation operator on the
///output. This operator supports in-place execution, meaning that *OutputTensor* is permitted to alias one or more of
///the input tensors during binding.
struct DML_ELEMENT_WISE_ADD1_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the left-hand side inputs.
    const(DML_TENSOR_DESC)* ATensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the right-hand side inputs.
    const(DML_TENSOR_DESC)* BTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: \_Maybenull\_ **const [DML_OPERATOR_DESC](/windows/win32/api/directml/ns-directml-dml_operator_desc)\*** An
    ///optional fused activation layer to apply after the addition. Fused activation may be used only when the output
    ///datatype is **FLOAT16** or **FLOAT32**.
    const(DML_OPERATOR_DESC)* FusedActivation;
}

///Computes the arcsine for each element of *InputTensor*, placing the result into the corresponding element of
///*OutputTensor*. ``` f(x) = asin(x) ``` This operator supports in-place execution, meaning that *OutputTensor* is
///permitted to alias *InputTensor* during binding.
struct DML_ELEMENT_WISE_ASIN_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: \_Maybenull\_ **const [DML_SCALE_BIAS](/windows/win32/api/directml/ns-directml-dml_scale_bias)\*** An
    ///optional scale and bias to apply to the input. If present, this has the effect of applying the function `g(x) = x
    ///* scale + bias` to each *input* element prior to computing this operator.
    const(DML_SCALE_BIAS)* ScaleBias;
}

///Computes the arctangent for each element of *InputTensor*, placing the result into the corresponding element of
///*OutputTensor*. ``` f(x) = atan(x) ``` This operator supports in-place execution, meaning that *OutputTensor* is
///permitted to alias *InputTensor* during binding.
struct DML_ELEMENT_WISE_ATAN_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: \_Maybenull\_ **const [DML_SCALE_BIAS](/windows/win32/api/directml/ns-directml-dml_scale_bias)\*** An
    ///optional scale and bias to apply to the input. If present, this has the effect of applying the function `g(x) = x
    ///* scale + bias` to each *input* element prior to computing this operator.
    const(DML_SCALE_BIAS)* ScaleBias;
}

///Computes the ceiling for each element of *InputTensor*, placing the result into the corresponding element of
///*OutputTensor*. The ceiling of x is the smallest integer that is greater than or equal to x. ``` f(x) = ceil(x) ```
///This operator supports in-place execution, meaning that *OutputTensor* is permitted to alias *InputTensor* during
///binding.
struct DML_ELEMENT_WISE_CEIL_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: \_Maybenull\_ **const [DML_SCALE_BIAS](/windows/win32/api/directml/ns-directml-dml_scale_bias)\*** An
    ///optional scale and bias to apply to the input. If present, this has the effect of applying the function `g(x) = x
    ///* scale + bias` to each *input* element prior to computing this operator.
    const(DML_SCALE_BIAS)* ScaleBias;
}

///Performs the following operation for each element of *InputTensor*, placing the result into the corresponding element
///of *OutputTensor*. This operator clamps (or limits) every element in the input within the closed interval [Min, Max].
///``` f(x) = min(Max, max(Min, x)) ``` Where max(a,b) returns the larger of the two values, and min(a,b) returns the
///smaller of the two values a,b. This operator supports in-place execution, meaning that *OutputTensor* is permitted to
///alias *InputTensor* during binding.
struct DML_ELEMENT_WISE_CLIP_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: \_Maybenull\_ **const [DML_SCALE_BIAS](/windows/win32/api/directml/ns-directml-dml_scale_bias)\*** An
    ///optional scale and bias to apply to the input. If present, this has the effect of applying the function `g(x) = x
    ///* scale + bias` to each *input* element prior to computing this operator.
    const(DML_SCALE_BIAS)* ScaleBias;
    ///Type: <b>FLOAT</b> The minimum value, below which the operator replaces the value with *Min*.
    float Min;
    ///Type: <b>FLOAT</b> The maximum value, above which the operator replaces the value with *Max*.
    float Max;
}

///Computes the trigonometric cosine of each element of *InputTensor*, placing the result into the corresponding element
///of *OutputTensor*. ``` f(x) = cos(x) ``` This operator supports in-place execution, meaning that *OutputTensor* is
///permitted to alias *InputTensor* during binding.
struct DML_ELEMENT_WISE_COS_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: \_Maybenull\_ **const [DML_SCALE_BIAS](/windows/win32/api/directml/ns-directml-dml_scale_bias)\*** An
    ///optional scale and bias to apply to the input. If present, this has the effect of applying the function `g(x) = x
    ///* scale + bias` to each *input* element prior to computing this operator.
    const(DML_SCALE_BIAS)* ScaleBias;
}

///Computes the quotient of each element of *ATensor* over the corresponding element of *BTensor*, placing the result
///into the corresponding element of *OutputTensor*. ``` f(a, b) = a / b ``` For integer divisions, the result is
///truncated. This operator supports in-place execution, meaning that *OutputTensor* is permitted to alias one of the
///the input tensors during binding.
struct DML_ELEMENT_WISE_DIVIDE_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the left-hand side inputs.
    const(DML_TENSOR_DESC)* ATensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the right-hand side inputs.
    const(DML_TENSOR_DESC)* BTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
}

///Applies the natural exponentiation function to each element of *InputTensor*, placing the result into the
///corresponding element of *OutputTensor*. ``` f(x) = exp(x) ``` This operator supports in-place execution, meaning
///that *OutputTensor* is permitted to alias *InputTensor* during binding.
struct DML_ELEMENT_WISE_EXP_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: \_Maybenull\_ **const [DML_SCALE_BIAS](/windows/win32/api/directml/ns-directml-dml_scale_bias)\*** An
    ///optional scale and bias to apply to the input. If present, this has the effect of applying the function `g(x) = x
    ///* scale + bias` to each *input* element prior to computing this operator.
    const(DML_SCALE_BIAS)* ScaleBias;
}

///Computes the floor for each element of *InputTensor*, placing the result into the corresponding element of
///*OutputTensor*. The floor of x is the largest integer that is less than or equal to x. ``` f(x) = floor(x) ``` This
///operator supports in-place execution, meaning that *OutputTensor* is permitted to alias *InputTensor* during binding.
struct DML_ELEMENT_WISE_FLOOR_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: \_Maybenull\_ **const [DML_SCALE_BIAS](/windows/win32/api/directml/ns-directml-dml_scale_bias)\*** An
    ///optional scale and bias to apply to the input. If present, this has the effect of applying the function `g(x) = x
    ///* scale + bias` to each *input* element prior to computing this operator.
    const(DML_SCALE_BIAS)* ScaleBias;
}

///Computes the base-e (natural) logarithm of each element of *InputTensor*, placing the result into the corresponding
///element of *OutputTensor*. If x is negative, then this function returns `indefinite`. If x is 0, then this function
///returns -INF. ``` f(x) = ln(x) ``` This operator supports in-place execution, meaning that *OutputTensor* is
///permitted to alias *InputTensor* during binding.
struct DML_ELEMENT_WISE_LOG_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: \_Maybenull\_ **const [DML_SCALE_BIAS](/windows/win32/api/directml/ns-directml-dml_scale_bias)\*** An
    ///optional scale and bias to apply to the input. If present, this has the effect of applying the function `g(x) = x
    ///* scale + bias` to each *input* element prior to computing this operator.
    const(DML_SCALE_BIAS)* ScaleBias;
}

///Performs a logical AND on each pair of corresponding elements of the input tensors, placing the result (1 for true, 0
///for false) into the corresponding element of *OutputTensor*. ``` f(a, b) = (a && b) ``` This operator supports
///in-place execution, meaning that *OutputTensor* is permitted to alias one of the the input tensors during binding.
struct DML_ELEMENT_WISE_LOGICAL_AND_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the left-hand side inputs.
    const(DML_TENSOR_DESC)* ATensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the right-hand side inputs.
    const(DML_TENSOR_DESC)* BTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
}

///Performs a logical *equals* on each pair of corresponding elements of the input tensors, placing the result (1 for
///true, 0 for false) into the corresponding element of *OutputTensor*. ``` f(a, b) = (a == b) ```
struct DML_ELEMENT_WISE_LOGICAL_EQUALS_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the left-hand side inputs.
    const(DML_TENSOR_DESC)* ATensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the right-hand side inputs.
    const(DML_TENSOR_DESC)* BTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
}

///Performs a logical *greater than* on each pair of corresponding elements of the input tensors, placing the result (1
///for true, 0 for false) into the corresponding element of *OutputTensor*. ``` f(a, b) = (a > b) ```
struct DML_ELEMENT_WISE_LOGICAL_GREATER_THAN_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the left-hand side inputs.
    const(DML_TENSOR_DESC)* ATensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the right-hand side inputs.
    const(DML_TENSOR_DESC)* BTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
}

///Performs a logical *less than* on each pair of corresponding elements of the input tensors, placing the result (1 for
///true, 0 for false) into the corresponding element of *OutputTensor*. ``` f(a, b) = (a < b) ```
struct DML_ELEMENT_WISE_LOGICAL_LESS_THAN_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the left-hand side inputs.
    const(DML_TENSOR_DESC)* ATensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the right-hand side inputs.
    const(DML_TENSOR_DESC)* BTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
}

///Performs a logical NOT on each element of *InputTensor*, placing the result into the corresponding element of
///*OutputTensor*. ``` f(x) = !x ``` This operator supports in-place execution, meaning that *OutputTensor* is permitted
///to alias *InputTensor* during binding.
struct DML_ELEMENT_WISE_LOGICAL_NOT_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
}

///Performs a logical OR on each pair of corresponding elements of the input tensors, placing the result into the
///corresponding element of *OutputTensor*. ``` f(a, b) = (a || b) ``` This operator supports in-place execution,
///meaning that *OutputTensor* is permitted to alias one of the the input tensors during binding.
struct DML_ELEMENT_WISE_LOGICAL_OR_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the left-hand side inputs.
    const(DML_TENSOR_DESC)* ATensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the right-hand side inputs.
    const(DML_TENSOR_DESC)* BTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
}

///Performs a logical XOR (exclusive or) on each pair of corresponding elements of the input tensors, placing the result
///into the corresponding element of *OutputTensor*. ``` f(a, b) = (!!a) != (!!b) ``` This operator supports in-place
///execution, meaning that *OutputTensor* is permitted to alias one of the the input tensors during binding.
struct DML_ELEMENT_WISE_LOGICAL_XOR_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the left-hand side inputs.
    const(DML_TENSOR_DESC)* ATensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the right-hand side inputs.
    const(DML_TENSOR_DESC)* BTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
}

///Takes the greater of two corresponding elements from the input tensors, and places the result into the corresponding
///element of the output tensor. ``` f(a, b) = max(a, b) ``` This operator supports in-place execution, meaning that
///*OutputTensor* is permitted to alias one of the the input tensors during binding.
struct DML_ELEMENT_WISE_MAX_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the left-hand side inputs.
    const(DML_TENSOR_DESC)* ATensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the right-hand side inputs.
    const(DML_TENSOR_DESC)* BTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
}

///Averages each pair of corresponding elements of the input tensors, placing the result into the corresponding element
///of *OutputTensor*. ``` f(a, b) = (a + b) / 2 ``` This operator supports in-place execution, meaning that
///*OutputTensor* is permitted to alias one of the the input tensors during binding.
struct DML_ELEMENT_WISE_MEAN_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the left-hand side inputs.
    const(DML_TENSOR_DESC)* ATensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the right-hand side inputs.
    const(DML_TENSOR_DESC)* BTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
}

///Takes the lesser of two corresponding elements from the input tensors, and places the result into the corresponding
///element of *OutputTensor*. ``` f(a, b) = min(a, b) ``` This operator supports in-place execution, meaning that
///*OutputTensor* is permitted to alias one of the the input tensors during binding.
struct DML_ELEMENT_WISE_MIN_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the left-hand side inputs.
    const(DML_TENSOR_DESC)* ATensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the right-hand side inputs.
    const(DML_TENSOR_DESC)* BTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
}

///Computes the product of each pair of corresponding elements of the input tensors, placing the result into the
///corresponding element of *OutputTensor*. ``` f(a, b) = a * b ``` This operator supports in-place execution, meaning
///that *OutputTensor* is permitted to alias one of the the input tensors during binding.
struct DML_ELEMENT_WISE_MULTIPLY_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the left-hand side inputs.
    const(DML_TENSOR_DESC)* ATensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the right-hand side inputs.
    const(DML_TENSOR_DESC)* BTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
}

///Computes each element of *InputTensor* raised to the power of the corresponding element of *ExponentTensor*, placing
///the result into the corresponding element of *OutputTensor*. ``` f(input, exponent) = pow(input, exponent) ```
///Negative bases are supported for exponents with integral values (though datatype can still be float), otherwise this
///operator returns NaN. When the input tensor and exponent tensor both have integral data type, this operator
///guarantees exact results. This operator supports in-place execution, meaning that *OutputTensor* is permitted to
///alias *InputTensor* during binding.
struct DML_ELEMENT_WISE_POW_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor
    ///containing the input values.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor
    ///containing the exponent values.
    const(DML_TENSOR_DESC)* ExponentTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: \_Maybenull\_ **const [DML_SCALE_BIAS](/windows/win32/api/directml/ns-directml-dml_scale_bias)\*** An
    ///optional scale and bias to apply to the input. If present, this has the effect of applying the function `g(x) = x
    ///* scale + bias` to each *input* element prior to computing this operator.
    const(DML_SCALE_BIAS)* ScaleBias;
}

///Raises each element of *InputTensor* to the power of *Exponent*, placing the result into the corresponding element of
///*OutputTensor*. ``` f(x) = pow(x, Exponent) ``` Negative bases are supported for integral exponents, otherwise this
///operator returns NaN. This operator supports in-place execution, meaning that *OutputTensor* is permitted to alias
///*InputTensor* during binding.
struct DML_ELEMENT_WISE_CONSTANT_POW_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: \_Maybenull\_ **const [DML_SCALE_BIAS](/windows/win32/api/directml/ns-directml-dml_scale_bias)\*** An
    ///optional scale and bias to apply to the input. If present, this has the effect of applying the function `g(x) = x
    ///* scale + bias` to each *input* element prior to computing this operator.
    const(DML_SCALE_BIAS)* ScaleBias;
    ///Type: <b>FLOAT</b> The exponent that all inputs will be raised to.
    float Exponent;
}

///Computes the reciprocal for each element of the input tensor, placing the result into the corresponding element of
///the output tensor. ``` f(x) = 1 / x ``` This operator supports in-place execution, meaning that the output tensor is
///permitted to alias the input tensor during binding.
struct DML_ELEMENT_WISE_RECIP_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor to read
    ///from for the first input tensor, x.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: \_Maybenull\_ **const [DML_SCALE_BIAS](/windows/win32/api/directml/ns-directml-dml_scale_bias)\*** An
    ///optional scale and bias to apply to the input. If present, this has the effect of applying the function `g(x) = x
    ///* scale + bias` to each *input* element prior to computing this operator.
    const(DML_SCALE_BIAS)* ScaleBias;
}

///Computes the trigonometric sine of each element of *InputTensor*, placing the result into the corresponding element
///of *OutputTensor*. ``` f(x) = sin(x) ``` This operator supports in-place execution, meaning that *OutputTensor* is
///permitted to alias *InputTensor* during binding.
struct DML_ELEMENT_WISE_SIN_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: \_Maybenull\_ **const [DML_SCALE_BIAS](/windows/win32/api/directml/ns-directml-dml_scale_bias)\*** An
    ///optional scale and bias to apply to the input. If present, this has the effect of applying the function `g(x) = x
    ///* scale + bias` to each *input* element prior to computing this operator.
    const(DML_SCALE_BIAS)* ScaleBias;
}

///Computes the square root of each element of *InputTensor*, placing the result into the corresponding element of
///*OutputTensor*. ``` f(x) = sqrt(x) ``` This operator supports in-place execution, meaning that *OutputTensor* is
///permitted to alias *InputTensor* during binding.
struct DML_ELEMENT_WISE_SQRT_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: \_Maybenull\_ **const [DML_SCALE_BIAS](/windows/win32/api/directml/ns-directml-dml_scale_bias)\*** An
    ///optional scale and bias to apply to the input. If present, this has the effect of applying the function `g(x) = x
    ///* scale + bias` to each *input* element prior to computing this operator.
    const(DML_SCALE_BIAS)* ScaleBias;
}

///Subtracts each element of *BTensor* from the corresponding element of *ATensor*, placing the result into the
///corresponding element of *OutputTensor*. ``` f(a, b) = a - b ``` This operator supports in-place execution, meaning
///that *OutputTensor* is permitted to alias one of the the input tensors during binding.
struct DML_ELEMENT_WISE_SUBTRACT_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the left-hand side inputs.
    const(DML_TENSOR_DESC)* ATensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the right-hand side inputs.
    const(DML_TENSOR_DESC)* BTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
}

///Computes the trigonometric tangent of each element of *InputTensor*, placing the result into the corresponding
///element of *OutputTensor*. ``` f(x) = tan(x) ``` This operator supports in-place execution, meaning that
///*OutputTensor* is permitted to alias *InputTensor* during binding.
struct DML_ELEMENT_WISE_TAN_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: \_Maybenull\_ **const [DML_SCALE_BIAS](/windows/win32/api/directml/ns-directml-dml_scale_bias)\*** An
    ///optional scale and bias to apply to the input. If present, this has the effect of applying the function `g(x) = x
    ///* scale + bias` to each *input* element prior to computing this operator.
    const(DML_SCALE_BIAS)* ScaleBias;
}

///Replaces all elements of *InputTensor* below the given threshold, *Min*, with *Min*. Results are placed into the
///corresponding element of *OutputTensor*. ``` f(x) = max(x, Min) ``` Where max(a,b) returns the larger of the two
///values a,b. This operator supports in-place execution, meaning that *OutputTensor* is permitted to alias
///*InputTensor* during binding.
struct DML_ELEMENT_WISE_THRESHOLD_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: \_Maybenull\_ **const [DML_SCALE_BIAS](/windows/win32/api/directml/ns-directml-dml_scale_bias)\*** An
    ///optional scale and bias to apply to the input. If present, this has the effect of applying the function `g(x) = x
    ///* scale + bias` to each *input* element prior to computing this operator.
    const(DML_SCALE_BIAS)* ScaleBias;
    ///Type: <b>FLOAT</b> The minimum value, below which the operator replaces the value with *Min*.
    float Min;
}

///Performs the following linear quantization function on every element in *InputTensor* with respect to its
///corresponding element in *ScaleTensor* and `ZeroPointTensor`, placing the results in the corresponding element of
///*OutputTensor*. ``` // For uint8 output, Min = 0, Max = 255 // For int8 output, Min = -128, Max = 127 f(input, scale,
///zero_point) = clamp(round(input / scale) + zero_point, Min, Max) ``` Quantizing involves converting to a
///lower-precision data type in order to accelerate arithmetic. It's a common way to increase performance at the cost of
///precision. A group of 8-bit values can be computed faster than a group of 32-bit values can.
struct DML_ELEMENT_WISE_QUANTIZE_LINEAR_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor
    ///containing the inputs.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor
    ///containing the scales.
    const(DML_TENSOR_DESC)* ScaleTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor
    ///containing the desired zero point for the quantization.
    const(DML_TENSOR_DESC)* ZeroPointTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
}

///Performs the following linear dequantization function on every element in *InputTensor* with respect to its
///corresponding element in *ScaleTensor* and `ZeroPointTensor`, placing the results in the corresponding element of
///*OutputTensor*. ``` f(input, scale, zero_point) = (input - zero_point) * scale ``` Quantization is a common way to
///increase performance at the cost of precision. A group of 8-bit int values can be computed faster than a group of
///32-bit float values can. Dequantizing converts the encoded data back to its domain.
struct DML_ELEMENT_WISE_DEQUANTIZE_LINEAR_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor
    ///containing the inputs.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor
    ///containing the scales.
    const(DML_TENSOR_DESC)* ScaleTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor
    ///containing the zero point that was used for quantization.
    const(DML_TENSOR_DESC)* ZeroPointTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
}

///Performs an exponential linear unit (ELU) activation function on every element in *InputTensor*, placing the result
///into the corresponding element of *OutputTensor*. ``` f(x) = x, if x >= 0 Alpha * (exp(x) - 1), otherwise ``` Where
///exp(x) is the natural exponentiation function. This operator supports in-place execution, meaning that the output
///tensor is permitted to alias *InputTensor* during binding.
struct DML_ACTIVATION_ELU_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: <b>FLOAT</b> The alpha coefficient. A typical default for this value is 1.0.
    float Alpha;
}

///Performs a hardmax function on each element of *InputTensor*, placing the result into the corresponding element of
///*OutputTensor*. The operator computes the hardmax (1 for the first occurrence of the largest value in the layer, and
///0 for all other values) of each row in the given input.
struct DML_ACTIVATION_HARDMAX_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor to read
    ///from for the input. This tensor must have an *effective rank* no greater than 2. The effective rank of a tensor
    ///is the *DimensionCount* of the tensor, excluding leftmost dimensions of size 1. For example a tensor size of `{
    ///1, 1, BatchCount, Width }` is valid, and is equivalent to a tensor of sizes `{ BatchCount, Width }`.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
}

///Performs a hard sigmoid function on every element in *InputTensor*, placing the result into the corresponding element
///of *OutputTensor*. ``` f(x) = max(0, min(Alpha * x + Beta, 1)) ``` Where `max(a,b)` returns the larger of the two
///values, and `min(a,b)` returns the smaller of the two values `a,b`. This operator supports in-place execution,
///meaning that the output tensor is permitted to alias *InputTensor* during binding.
struct DML_ACTIVATION_HARD_SIGMOID_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: <b>FLOAT</b> The alpha coefficient. A typical default for this value is 0.2.
    float Alpha;
    ///Type: <b>FLOAT</b> The beta coefficient. A typical default for this value is 0.5.
    float Beta;
}

///Performs the identity activation, effectively copying every element of *InputTensor* to the corresponding element of
///*OutputTensor*. ``` f(x) = x ``` This operator supports in-place execution, meaning that the output tensor is
///permitted to alias *InputTensor* during binding.
struct DML_ACTIVATION_IDENTITY_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A pointer to a
    ///constant [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc) containing the description of
    ///the tensor to write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
}

///Performs a leaky rectified linear unit (ReLU) activation function on every element in *InputTensor*, placing the
///result into the corresponding element of *OutputTensor*. ``` f(x) = x, if x >= 0 Alpha * x, otherwise ``` This
///operator supports in-place execution, meaning that the output tensor is permitted to alias *InputTensor* during
///binding.
struct DML_ACTIVATION_LEAKY_RELU_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: <b>FLOAT</b> The alpha coefficient. A typical default for this value is 0.01.
    float Alpha;
}

///Performs the linear activation function on every element in *InputTensor*, placing the result into the corresponding
///element of *OutputTensor*. ``` f(x) = Alpha * x + Beta. ``` This operator supports in-place execution, meaning that
///the output tensor is permitted to alias *InputTensor* during binding.
struct DML_ACTIVATION_LINEAR_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: <b>FLOAT</b> The alpha coefficient.
    float Alpha;
    ///Type: <b>FLOAT</b> The beta coefficient.
    float Beta;
}

///Performs a (natural) log-of-softmax activation function on each element of *InputTensor*, placing the result into the
///corresponding element of *OutputTensor*. ``` // Let x_i be the current value in the axis, and j be the total number
///of elements along that axis. f(x_i) = ln(exp(x_i) / sum(exp(x_0), ..., exp(x_j))) ``` Where exp(x) is the natural
///exponentiation function, and ln(x) is the natural logarithm.
struct DML_ACTIVATION_LOG_SOFTMAX_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from. This tensor must have an *effective rank* no greater than 2. The effective rank of a tensor is the
    ///*DimensionCount* of the tensor, excluding leftmost dimensions of size 1. For example a tensor size of `{ 1, 1,
    ///BatchCount, Width }` is valid, and is equivalent to a tensor of sizes `{ BatchCount, Width }`.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
}

///Performs a parameterized rectified linear unit (ReLU) activation function on every element in *InputTensor*, placing
///the result into the corresponding element of *OutputTensor*. ``` f(x, slope) = x, if x >= 0 slope * x, otherwise ```
///This operator supports in-place execution, meaning that the output tensor is permitted to alias *InputTensor* during
///binding.
struct DML_ACTIVATION_PARAMETERIZED_RELU_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the slope for each corresponding value of the input.
    const(DML_TENSOR_DESC)* SlopeTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
}

///Performs a parametric softplus activation function on every element in *InputTensor*, placing the result into the
///corresponding element of *OutputTensor*. ``` f(x) = Alpha * ln(1 + exp(Beta * x)) ``` Where exp(x) is the natural
///exponentiation function, and ln(x) is the natural logarithm. This operator supports in-place execution, meaning that
///the output tensor is permitted to alias *InputTensor* during binding.
struct DML_ACTIVATION_PARAMETRIC_SOFTPLUS_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: <b>FLOAT</b> The alpha coefficient.
    float Alpha;
    ///Type: <b>FLOAT</b> The beta coefficient.
    float Beta;
}

///Performs a rectified linear unit (ReLU) activation function on every element in *InputTensor*, placing the result
///into the corresponding element of *OutputTensor*. ``` f(x) = max(0, x) ``` Where max(a,b) returns the larger of the
///two values a,b. This operator supports in-place execution, meaning that the output tensor is permitted to alias
///*InputTensor* during binding.
struct DML_ACTIVATION_RELU_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
}

///Performs a scaled exponential linear unit (ELU) activation function on every element in *InputTensor*, placing the
///result into the corresponding element of *OutputTensor*. ``` f(x) = Gamma * x, if x > 0 Gamma * (Alpha * exp(x) -
///Alpha), otherwise ``` Where exp(x) is the natural exponentiation function. This operator supports in-place execution,
///meaning that the output tensor is permitted to alias *InputTensor* during binding.
struct DML_ACTIVATION_SCALED_ELU_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: <b>FLOAT</b> The value of alpha. A typical default for this value is 1.6732.
    float Alpha;
    ///Type: <b>FLOAT</b> The value of gamma. A typical default for this value is 1.0507.
    float Gamma;
}

///Performs a scaled hyperbolic tangent activation function on every element in *InputTensor*, placing the result into
///the corresponding element of *OutputTensor*. ``` f(x) = Alpha * tanh(Beta * x) ``` Where tanh(x) is the hyperbolic
///tangent function. This operator supports in-place execution, meaning that the output tensor is permitted to alias
///*InputTensor* during binding.
struct DML_ACTIVATION_SCALED_TANH_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: <b>FLOAT</b> The value of alpha. A typical default for this value is 1.0.
    float Alpha;
    ///Type: <b>FLOAT</b> The value of beta. A typical default for this value is 0.5.
    float Beta;
}

///Performs the sigmoid function on every element in *InputTensor*, placing the result into the corresponding element of
///*OutputTensor*. ``` f(x) = 1 / (1 + exp(-x)) ``` Where exp(x) is the natural exponentiation function. This operator
///supports in-place execution, meaning that the output tensor is permitted to alias *InputTensor* during binding.
struct DML_ACTIVATION_SIGMOID_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
}

///Performs a softmax activation function on *InputTensor*, placing the result into the corresponding element of
///*OutputTensor*. ``` // Let x_i be the current value in the axis, and j be the total number of elements along that
///axis. f(x_i) = exp(x_i) / sum(exp(x_0), ..., exp(x_j)) ``` Where exp(x) is the natural exponentiation function.
struct DML_ACTIVATION_SOFTMAX_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from. This tensor must have an *effective rank* no greater than 2. The effective rank of a tensor is the
    ///*DimensionCount* of the tensor, excluding leftmost dimensions of size 1. For example a tensor size of `{ 1, 1,
    ///BatchCount, Width }` is valid, and is equivalent to a tensor of sizes `{ BatchCount, Width }`.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
}

///Performs a parametric softplus activation function on every element in *InputTensor*, placing the result into the
///corresponding element of *OutputTensor*. ``` f(x) = ln(1 + exp(Steepness * x)) / Steepness ``` Where exp(x) is the
///natural exponentiation function and ln(x) is the natural logarithm. This operator supports in-place execution,
///meaning that the output tensor is permitted to alias *InputTensor* during binding.
struct DML_ACTIVATION_SOFTPLUS_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The **Steepness**
    ///coefficient. A typical default for this value is 1.0. This value cannot be less than 1.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: <b>FLOAT</b> The steepness value.
    float Steepness;
}

///Performs the softsign function on every element in *InputTensor*, placing the result into the corresponding element
///of *OutputTensor*. ``` f(x) = x / (1 + abs(x)) ``` Where abs(x) returns the absolute value of x. This operator
///supports in-place execution, meaning that the output tensor is permitted to alias *InputTensor* during binding.
struct DML_ACTIVATION_SOFTSIGN_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
}

///Performs a hyperbolic tangent activation function on every element in *InputTensor*, placing the result into the
///corresponding element of *OutputTensor*. ``` f(x) = tanh(x) // (1 - exp(-2 * x)) / (1 + exp(-2 * x)). ``` This
///operator supports in-place execution, meaning that the output tensor is permitted to alias *InputTensor* during
///binding.
struct DML_ACTIVATION_TANH_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
}

///Performs a thresholded rectified linear unit (ReLU) activation function on every element in *InputTensor*, placing
///the result into the corresponding element of *OutputTensor*. ``` f(x) = x, if x > Alpha 0, otherwise ``` This
///operator supports in-place execution, meaning that the output tensor is permitted to alias *InputTensor* during
///binding.
struct DML_ACTIVATION_THRESHOLDED_RELU_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: <b>FLOAT</b> The threshold for the function. A typical default for this value is 1.0.
    float Alpha;
}

///Performs a convolution of the *FilterTensor* with the *InputTensor*. This operator supports a number of standard
///convolution configurations. These standard configurations include forward and backward (transposed) convolution by
///setting the *Direction* and *Mode* fields, as well as depth-wise convolution by setting the *GroupCount* field. A
///summary of the steps involved: perform the convolution into the output tensor; reshape the bias to the same dimension
///sizes as the output tensor; add the reshaped bias tensor to the output tensor.
struct DML_CONVOLUTION_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the input data. The expected dimensions of the *InputTensor* are `{ BatchCount, InputChannelCount, InputHeight,
    ///InputWidth }` for 4D, and `{ BatchCount, InputChannelCount, InputDepth, InputHeight, InputWidth }` for 5D.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the filter data. The expected dimensions of the *FilterTensor* are `{ FilterBatchCount, FilterChannelCount,
    ///FilterHeight, FilterWidth }` for 4D, and `{ FilterBatchCount, FilterChannelCount, FilterDepth, FilterHeight,
    ///FilterWidth }` for 5D.
    const(DML_TENSOR_DESC)* FilterTensor;
    ///Type: \_Maybenull\_ **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An
    ///optional tensor containing the bias data&mdash;one value for each output channel. Assuming the *OutputTensor* has
    ///sizes of `{ BatchCount, OutputChannelCount, OutputHeight, OutputWidth }`, the expected dimensions of the
    ///*BiasTensor* are `{ 1, OutputChannelCount, 1, 1 }` for 4D, and `{ 1, OutputChannelCount, 1, 1, 1 }` for 5D. For
    ///each output channel, the single bias value for that channel is added to every element in that channel of the
    ///*OutputTensor*. That is, the *BiasTensor* is broadcasted to the size of the *OutputTensor*, and what the operator
    ///returns is the summation of this broadcasted *BiasTensor* with the result from convolution.
    const(DML_TENSOR_DESC)* BiasTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor to write
    ///the results to. The expected dimensions of the *OutputTensor* are `{ BatchCount, OutputChannelCount,
    ///OutputHeight, OutputWidth }` for 4D, and `{ BatchCount, OutputChannelCount, OutputDepth, OutputHeight,
    ///OutputWidth }` for 5D.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: [**DML_CONVOLUTION_MODE**](/windows/win32/api/directml/ne-directml-dml_convolution_mode) The mode to use
    ///for the convolution operation.
    ///[DML_CONVOLUTION_MODE_CROSS_CORRELATION](/windows/win32/api/directml/ne-directml-dml_convolution_mode) is the
    ///behavior for required for typical inference scenarios. In contrast,
    ///[DML_CONVOLUTION_MODE_CONVOLUTION](/windows/win32/api/directml/ne-directml-dml_convolution_mode) flips the order
    ///of elements in each filter kernel along each spatial dimension.
    DML_CONVOLUTION_MODE Mode;
    ///Type: [**DML_CONVOLUTION_DIRECTION**](/windows/win32/api/directml/ne-directml-dml_convolution_direction) The
    ///direction of the convolution operation.
    ///[DML_CONVOLUTION_DIRECTION_FORWARD](/windows/win32/api/directml/ne-directml-dml_convolution_direction) is the
    ///primary form of convolution used for inference where a combination of
    ///[DML_CONVOLUTION_DIRECTION_FORWARD](/windows/win32/api/directml/ne-directml-dml_convolution_direction) and
    ///[DML_CONVOLUTION_DIRECTION_BACKWARD](/windows/win32/api/directml/ne-directml-dml_convolution_direction) are used
    ///during training.
    DML_CONVOLUTION_DIRECTION Direction;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The number of spatial dimensions for the
    ///convolution operation. Spatial dimensions are the lower dimensions of the convolution *FilterTensor*. For
    ///example, the width and height dimension are spatial dimensions of a 4D convolution filter tensor. This value also
    ///determines the size of the *Strides*, *Dilations*, *StartPadding*, *EndPadding*, and *OutputPadding* arrays. It
    ///should be set to 2 when *InputTensor.DimensionCount* is 4, and 3 when *InputTensor.DimensionCount* is 5.
    uint                 DimensionCount;
    ///Type: \_Field_size\_(DimensionCount) **const [UINT](/windows/desktop/WinProg/windows-data-types)\*** An array
    ///containing the strides of the convolution operation. These strides are applied to the convolution filter. They
    ///are separate from the tensor strides included in
    ///[DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc).
    const(uint)*         Strides;
    ///Type: \_Field_size\_(DimensionCount) **const [UINT](/windows/desktop/WinProg/windows-data-types)\*** An array
    ///containing the dilations of the convolution operation. Dilations are strides applied to the elements of the
    ///filter kernel. This has the effect of simulating a larger filter kernel by padding the internal filter kernel
    ///elements with zeros.
    const(uint)*         Dilations;
    ///Type: \_Field_size\_(DimensionCount) **const [UINT](/windows/desktop/WinProg/windows-data-types)\*** An array
    ///containing the padding values to be applied to the beginning of each spatial dimension of the filter and input
    ///tensor of the convolution operation. The start padding values are interpreted according to the *Direction* field.
    const(uint)*         StartPadding;
    ///Type: \_Field_size\_(DimensionCount) **const [UINT](/windows/desktop/WinProg/windows-data-types)\*** An array
    ///containing the padding values to be applied to the end of each spatial dimension of the filter and input tensor
    ///of the convolution operation. The end padding values are interpreted according to the *Direction* field.
    const(uint)*         EndPadding;
    ///Type: \_Field_size\_(DimensionCount) **const [UINT](/windows/desktop/WinProg/windows-data-types)\*** An array
    ///containing the output padding of the convolution operation. *OutputPadding* applies a zero padding to the result
    ///of the convolution. This padding is applied to the end of each spatial dimension of the output tensor.
    const(uint)*         OutputPadding;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The number of groups which to divide the
    ///convolution operation up into. This can be used to achieve depth-wise convolution by setting *GroupCount* equal
    ///to the input channel count, and *Direction* equal to
    ///[DML_CONVOLUTION_DIRECTION_FORWARD](/windows/win32/api/directml/ne-directml-dml_convolution_direction). This
    ///divides the convolution up into a separate convolution per input channel.
    uint                 GroupCount;
    ///Type: \_Maybenull\_ **const [DML_OPERATOR_DESC](/windows/win32/api/directml/ns-directml-dml_operator_desc)\*** An
    ///optional fused activation layer to apply after the convolution.
    const(DML_OPERATOR_DESC)* FusedActivation;
}

///Performs a general matrix multiplication function of the form `Output = FusedActivation(Alpha * TransA(A) x TransB(B)
///+ Beta * C)`, where `x` denotes matrix multiplication, and `*` denotes multiplication with a scalar. This operator
///requires 4D tensors with layout `{ BatchCount, ChannelCount, Height, Width }`, and it will perform BatchCount *
///ChannelCount number of independent matrix multiplications. For example, if *ATensor* has *Sizes* of `{ BatchCount,
///ChannelCount, M, K }`, and *BTensor* has *Sizes* of `{ BatchCount, ChannelCount, K, N }`, and *OutputTensor* has
///*Sizes* of `{ BatchCount, ChannelCount, M, N }`, then this operator performs BatchCount * ChannelCount independent
///matrix multiplications of dimensions {M,K} x {K,N} = {M,N}.
struct DML_GEMM_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the A matrix. This tensor's *Sizes* should be `{ BatchCount, ChannelCount, M, K }` if *TransA* is
    ///[DML_MATRIX_TRANSFORM_NONE](/windows/win32/api/directml/ne-directml-dml_matrix_transform), or `{ BatchCount,
    ///ChannelCount, K, M }` if *TransA* is **DML_MATRIX_TRANSFORM_TRANSPOSE**.
    const(DML_TENSOR_DESC)* ATensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the B matrix. This tensor's *Sizes* should be `{ BatchCount, ChannelCount, K, N }` if *TransB* is
    ///[DML_MATRIX_TRANSFORM_NONE](/windows/win32/api/directml/ne-directml-dml_matrix_transform), or `{ BatchCount,
    ///ChannelCount, N, K }` if *TransB* is **DML_MATRIX_TRANSFORM_TRANSPOSE**.
    const(DML_TENSOR_DESC)* BTensor;
    ///Type: \_Maybenull\_ **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A
    ///tensor containing the C matrix, or `nullptr`. Values default to 0 when not provided. If provided, this tensor's
    ///*Sizes* should be `{ BatchCount, ChannelCount, M, N }`.
    const(DML_TENSOR_DESC)* CTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor to write
    ///the results to. This tensor's *Sizes* are `{ BatchCount, ChannelCount, M, N }`.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: [**DML_MATRIX_TRANSFORM**](/windows/win32/api/directml/ne-directml-dml_matrix_transform) The transform to
    ///be applied to *ATensor*; either a transpose, or no transform.
    DML_MATRIX_TRANSFORM TransA;
    ///Type: [**DML_MATRIX_TRANSFORM**](/windows/win32/api/directml/ne-directml-dml_matrix_transform) The transform to
    ///be applied to *BTensor*; either a transpose, or no transform.
    DML_MATRIX_TRANSFORM TransB;
    ///Type: <b>FLOAT</b> The value of the scalar multiplier for the product of inputs *ATensor* and *BTensor*.
    float                Alpha;
    ///Type: <b>FLOAT</b> The value of the scalar multiplier for the optional input *CTensor*. If *CTensor* is not
    ///provided, then this value is ignored.
    float                Beta;
    ///Type: \_Maybenull\_ **const [DML_OPERATOR_DESC](/windows/win32/api/directml/ns-directml-dml_operator_desc)\*** An
    ///optional fused activation layer to apply after the GEMM.
    const(DML_OPERATOR_DESC)* FusedActivation;
}

///Outputs the reduction of elements (sum, product, minimum, and so on) within one or more dimensions of the input
///tensor. Each output element is the result of applying a reduction function on a subset of the input tensor. A
///reduction function, such as *sum*, maps `N` input elements to a single output element. The input elements involved in
///each reduction are determined by the provided input axes: `N` is equal to the product of the sizes of the reduced
///axes. If all input axes are specified, then the operator performs a reduction on the entire input tensor and produces
///a single output element.
struct DML_REDUCE_OPERATOR_DESC
{
    ///Type: [**DML_REDUCE_FUNCTION**](/windows/win32/api/directml/ne-directml-dml_reduce_function) Specifies the
    ///reduction function to apply to the input.
    DML_REDUCE_FUNCTION Function;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor to read
    ///from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor to write
    ///the results to. Each output element is the result of a reduction on a subset of elements from the *InputTensor*.
    ///- *DimensionCount* must match *InputTensor.DimensionCount* (the rank of the input tensor is preserved). - *Sizes*
    ///must match *InputTensor.Sizes*, except for dimensions included in the reduced *Axes*, which must be size 1.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The number of axes to reduce. This field determines
    ///the size of the *Axes* array.
    uint                AxisCount;
    ///Type: \_Field\_size\_(AxisCount) <b>const [UINT](/windows/desktop/winprog/windows-data-types)*</b> The axes along
    ///which to reduce. Values must be in the range `[0, InputTensor.DimensionCount - 1]`.
    const(uint)*        Axes;
}

///Averages values across the elements within the sliding window over the input tensor.
struct DML_AVERAGE_POOLING_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An input tensor of
    ///*Sizes* `{ BatchCount, ChannelCount, Height, Width }` for 4D, and `{ BatchCount, ChannelCount, Depth, Height,
    ///Weight }` for 5D.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A description of the
    ///output tensor. The sizes of the output tensor can be computed as follows. ```cpp OutputTensor->Sizes[0] =
    ///InputTensor->Sizes[0]; OutputTensor->Sizes[1] = InputTensor->Sizes[1]; for (UINT i = 0; i < DimensionCount; ++i)
    ///{ UINT PaddedSize = InputTensor->Sizes[i + 2] + StartPadding[i] + EndPadding[i]; OutputTensor->Sizes[i + 2] =
    ///(PaddedSize - WindowSizes[i]) / Strides[i] + 1; } ```
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The number of spatial dimensions of the input
    ///tensor *InputTensor*, which also corresponds to the number of dimensions of the sliding window *WindowSize*. This
    ///value also determines the size of the *Strides*, *StartPadding*, and *EndPadding* arrays. It should be set to 2
    ///when *InputTensor* is 4D, and 3 when it's a 5D tensor.
    uint         DimensionCount;
    ///Type: \_Field_size\_(DimensionCount) **const [UINT](/windows/desktop/WinProg/windows-data-types)\*** The strides
    ///for the sliding window dimensions of sizes `{ Height, Width }` when the *DimensionCount* is set to 2, or `{
    ///Depth, Height, Width }` when set to 3.
    const(uint)* Strides;
    ///Type: \_Field_size\_(DimensionCount) **const [UINT](/windows/desktop/WinProg/windows-data-types)\*** The
    ///dimensions of the sliding window in `{ Height, Width }` when *DimensionCount* is set to 2, or `{ Depth, Height,
    ///Width }` when set to 3.
    const(uint)* WindowSize;
    ///Type: \_Field_size\_(DimensionCount) **const [UINT](/windows/desktop/WinProg/windows-data-types)\*** The number
    ///of padding elements to be applied to the beginning of each spatial dimension of the input tensor *InputTensor*.
    ///The values are in `{ Height, Width }` when *DimensionCount* is set to 2, or `{ Depth, Height, Width }` when set
    ///to 3.
    const(uint)* StartPadding;
    ///Type: \_Field_size\_(DimensionCount) **const [UINT](/windows/desktop/WinProg/windows-data-types)\*** The number
    ///of padding elements to be applied to the end of each spatial dimension of the input tensor *InputTensor*. The
    ///values are in `{ Height, Width }` when *DimensionCount* is set to 2, or `{ Depth, Height, Width }` when set to 3.
    const(uint)* EndPadding;
    ///Type: <b>BOOL</b> Indicates whether to include the padding elements around the spatial edges when calculating the
    ///average value across all elements within the sliding window. When the value is set to **FALSE**, the padding
    ///elements are not counted as part of the divisor value of the averaging calculation.
    BOOL         IncludePadding;
}

///Computes the Lp-normalized value across the elements within the sliding window over the input tensor.
struct DML_LP_POOLING_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An input tensor with
    ///*Sizes* `{ BatchCount, ChannelCount, Height, Width }` for 4D, and `{ BatchCount, ChannelCount, Depth, Height,
    ///Width }` for 5D.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write to. The *Sizes* of the output tensor can be computed as follows. ```cpp OutputTensor->Sizes[0] =
    ///InputTensor->Sizes[0]; OutputTensor->Sizes[1] = InputTensor->Sizes[1]; for (UINT i = 0; i < DimensionCount; ++i)
    ///{ UINT PaddedSize = InputTensor->Sizes[i + 2] + StartPadding[i] + EndPadding[i]; OutputTensor->Sizes[i + 2] =
    ///(PaddedSize - WindowSizes[i]) / Strides[i] + 1; } ```
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The number of spatial dimensions of the input
    ///tensor *InputTensor*, which also corresponds to the number of dimensions of the sliding window *WindowSize*. This
    ///value also determines the size of the *Strides*, *StartPadding*, and *EndPadding* arrays. It should be set to 2
    ///when *InputTensor* is 4D, and 3 when it's a 5D tensor.
    uint         DimensionCount;
    ///Type: \_Field\_size\_(DimensionCount) <b>const [UINT](/windows/desktop/winprog/windows-data-types)*</b> An array
    ///containing the strides for the sliding window dimensions of sizes `{ Height, Width }` when the *DimensionCount*
    ///is set to 2, or `{ Depth, Height, Width }` when set to 3.
    const(uint)* Strides;
    ///Type: \_Field\_size\_(DimensionCount) <b>const [UINT](/windows/desktop/winprog/windows-data-types)*</b> An array
    ///containing the dimensions of the sliding window in `{ Height, Width }`when *DimensionCount* is set to 2, or `{
    ///Depth, Height, Width }` when set to 3.
    const(uint)* WindowSize;
    ///Type: \_Field\_size\_(DimensionCount) <b>const [UINT](/windows/desktop/winprog/windows-data-types)*</b> An array
    ///containing the number of padding elements to be applied to the beginning of each spatial dimension of the input
    ///tensor *InputTensor*. The values are in `{ Height, Width }` when *DimensionCount* is set to 2, or `{ Depth,
    ///Height, Width }` when set to 3.
    const(uint)* StartPadding;
    ///Type: \_Field\_size\_(DimensionCount) <b>const [UINT](/windows/desktop/winprog/windows-data-types)*</b> An array
    ///containing the number of padding elements to be applied to the end of each spatial dimension of the input tensor
    ///*InputTensor*. The values are in `{ Height, Width }` when *DimensionCount* is set to 2, or `{ Depth, Height,
    ///Width }` when set to 3.
    const(uint)* EndPadding;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The value of the `P` variable in the
    ///Lp-normalization function `Y = (X1^P + X2^P + ... + Xn^P) ^ (1/P)`, where `X1` to `Xn` representing each of the
    ///values within the sliding window. In common use cases, this value is either set to 1 or 2, representing either
    ///the L1 or L2 normalization respectively.
    uint         P;
}

///Computes the maximum value across the elements within the sliding window over the input tensor.
struct DML_MAX_POOLING_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An input tensor of
    ///*Sizes* `{ BatchCount, ChannelCount, Height, Width }` if *InputTensor.DimensionCount* is 4, and `{ BatchCount,
    ///ChannelCount, Depth, Height, Weight }` if *InputTensor.DimensionCount* is 5.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An output tensor to
    ///write the results to. The sizes of the output tensor can be computed as follows. ```cpp OutputTensor->Sizes[0] =
    ///InputTensor->Sizes[0]; OutputTensor->Sizes[1] = InputTensor->Sizes[1]; for (UINT i = 0; i < DimensionCount; ++i)
    ///{ UINT PaddedSize = InputTensor->Sizes[i + 2] + StartPadding[i] + EndPadding[i]; OutputTensor->Sizes[i + 2] =
    ///(PaddedSize - WindowSizes[i]) / Strides[i] + 1; } ```
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The number of spatial dimensions of the input
    ///tensor *InputTensor*, which also corresponds to the number of dimensions of the sliding window *WindowSize*. This
    ///value also determines the size of the *Strides*, *StartPadding*, and *EndPadding* arrays. It should be set to 2
    ///when *InputTensor* is 4D, and 3 when it's a 5D tensor.
    uint         DimensionCount;
    ///Type: <b>const [UINT](/windows/desktop/winprog/windows-data-types)*</b> The strides for the sliding window
    ///dimensions of sizes `{ Height, Width }` when the *DimensionCount* is set to 2, or `{ Depth, Height, Width }` when
    ///set to 3.
    const(uint)* Strides;
    ///Type: \_Field\_size\_(DimensionCount) <b>const [UINT](/windows/desktop/winprog/windows-data-types)*</b> The
    ///dimensions of the sliding window in `{ Height, Width }` when *DimensionCount* is set to 2, or `{ Depth, Height,
    ///Width }` when set to 3.
    const(uint)* WindowSize;
    ///Type: \_Field\_size\_(DimensionCount) <b>const [UINT](/windows/desktop/winprog/windows-data-types)*</b> The
    ///number of padding elements to be applied to the beginning of each spatial dimension of the input tensor
    ///*InputTensor*. The values are in `{ Height, Width }` when *DimensionCount* is set to 2, or `{ Depth, Height,
    ///Width }` when set to 3.
    const(uint)* StartPadding;
    ///Type: \_Field\_size\_(DimensionCount) <b>const [UINT](/windows/desktop/winprog/windows-data-types)*</b> The
    ///number of padding elements to be applied to the end of each spatial dimension of the input tensor *InputTensor*.
    ///The values are in `{ Height, Width }` when *DimensionCount* is set to 2, or `{ Depth, Height, Width }` when set
    ///to 3.
    const(uint)* EndPadding;
}

///Computes the maximum value across the elements within the sliding window over the input tensor, and optionally
///returns the indices of the maximum values selected.
struct DML_MAX_POOLING1_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An input tensor of
    ///*Sizes* `{ BatchCount, ChannelCount, Height, Width }` if *InputTensor.DimensionCount* is 4, and `{ BatchCount,
    ///ChannelCount, Depth, Height, Weight } `if *InputTensor.DimensionCount* is 5.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An output tensor to
    ///write the results to. The sizes of the output tensor can be computed as follows. ```cpp OutputTensor->Sizes[0] =
    ///InputTensor->Sizes[0]; OutputTensor->Sizes[1] = InputTensor->Sizes[1]; for (UINT i = 0; i < DimensionCount; ++i)
    ///{ UINT PaddedSize = InputTensor->Sizes[i + 2] + StartPadding[i] + EndPadding[i]; OutputTensor->Sizes[i + 2] =
    ///(PaddedSize - WindowSizes[i]) / Strides[i] + 1; } ```
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: \_Maybenull\_ **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An
    ///optional output tensor of indices to the input tensor *InputTensor* of the maximum values produced and stored in
    ///the *OutputTensor*. These index values are zero-based and treat the input tensor as a contiguous one-dimensional
    ///array. When multiple elements within the sliding window have the same value, the later equal values are ignored
    ///and the index points to the first value encountered. Both the *OutputTensor* and *OutputIndicesTensor* have the
    ///same tensor sizes.
    const(DML_TENSOR_DESC)* OutputIndicesTensor;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The number of spatial dimensions of the input
    ///tensor *InputTensor*, which also corresponds to the number of dimensions of the sliding window *WindowSize*. This
    ///value also determines the size of the *Strides*, *StartPadding*, and *EndPadding* arrays. It should be set to 2
    ///when *InputTensor* is 4D, and 3 when it's a 5D tensor.
    uint         DimensionCount;
    ///Type: \_Field\_size\_(DimensionCount) <b>const [UINT](/windows/desktop/winprog/windows-data-types)*</b> The
    ///strides for the sliding window dimensions of sizes `{ Height, Width }` when the *DimensionCount* is set to 2, or
    ///`{ Depth, Height, Width }` when set to 3.
    const(uint)* Strides;
    ///Type: \_Field\_size\_(DimensionCount) <b>const [UINT](/windows/desktop/winprog/windows-data-types)*</b> The
    ///dimensions of the sliding window in `{ Height, Width }` when *DimensionCount* is set to 2, or `{ Depth, Height,
    ///Width }` when set to 3.
    const(uint)* WindowSize;
    ///Type: \_Field\_size\_(DimensionCount) <b>const [UINT](/windows/desktop/winprog/windows-data-types)*</b> The
    ///number of padding elements to be applied to the beginning of each spatial dimension of the input tensor
    ///*InputTensor*. The values are in `{ Height, Width }` when *DimensionCount* is set to 2, or `{ Depth, Height,
    ///Width }` when set to 3.
    const(uint)* StartPadding;
    ///Type: \_Field\_size\_(DimensionCount) <b>const [UINT](/windows/desktop/winprog/windows-data-types)*</b> The
    ///number of padding elements to be applied to the end of each spatial dimension of the input tensor *InputTensor*.
    ///The values are in `{ Height, Width }` when *DimensionCount* is set to 2, or `{ Depth, Height, Width }` when set
    ///to 3.
    const(uint)* EndPadding;
}

///Performs a MaxPool function across the input tensor (according to regions of interest, or ROIs). For each output
///element, the coordinates of its corresponding ROI in the input are computed by the following equations. Let `Y` be an
///index into the third dimension of *InputTensor* (`{ BatchSize, ChannelCount, **height**, width }`). Let `X` be an
///index into the fourth dimension of *InputTensor* (`{ BatchSize, ChannelCount, height, **width** }`). ``` x1 =
///round(RoiX1 * SpatialScale) x2 = round(RoiX2 * SpatialScale) y1 = round(RoiY1 * SpatialScale) y2 = round(RoiY2 *
///SpatialScale) RegionHeight = y2 - y1 + 1 RegionWidth = x2 - x1 + 1 StartY = (OutputIndices.Y * RegionHeight) /
///PooledSize.Height + y1 StartX = (OutputIndices.X * RegionWidth) / PooledSize.Width + x1 EndY = ((OutputIndices.Y + 1)
///* RegionHeight + PooledSize.Height - 1) / PooledSize.Height + y1 EndX = ((OutputIndices.X + 1) * RegionWidth +
///PooledSize.Width - 1) / PooledSize.Width + x1 ``` If the computed coordinates are out of bounds, then they are
///clamped to the input boundaries.
struct DML_ROI_POOLING_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the input data with dimensions `{ BatchCount, ChannelCount, InputHeight, InputWidth }`.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the regions of interest (ROI) data. The expected dimensions of `ROITensor` are `{ 1, 1, NumROIs, 5 }` and the
    ///data for each ROI is `[BatchID, x1, y1, x2, y2]`. x1, y1, x2, y2 are the inclusive coordinates of the corners of
    ///each ROI and x2 >= x1, y2 >= y1.
    const(DML_TENSOR_DESC)* ROITensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the output data. The expected dimensions of *OutputTensor* are `{ NumROIs, InputChannelCount, PooledSize.Height,
    ///PooledSize.Width }`.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: <b>FLOAT</b> Multiplicative spatial scale factor used to translate the ROI coordinates from their input
    ///scale to the scale used when pooling.
    float       SpatialScale;
    ///Type: [**DML_SIZE_2D**](/windows/win32/api/directml/ns-directml-dml_size_2d) The ROI pool output size (height,
    ///width), which must match the last 2 dimensions of *OutputTensor*.
    DML_SIZE_2D PooledSize;
}

///Extracts a single subregion (a "slice") of an input tensor. The elements copied in the slice are determined using
///three values for each dimension. - The *offset* marks the first element to copy in a dimension. - The *size* marks
///the number of elements to copy in a dimension. - The *stride* indicates the element increment or step in a dimension.
///The provided *Offsets*, *Sizes*, and *Strides* must only copy elements that are within the bounds of the input tensor
///(out-of-bounds reads are not permitted). The *Sizes* of the slice must exactly match the output tensor sizes. In
///general, the elements copied are calculated as follows. ``` OutputTensor[OutputCoordinates] = InputTensor[Offsets +
///Strides * OutputCoordinates] ```
struct DML_SLICE_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor to
    ///extract slices from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor to write
    ///the sliced data results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The number of dimensions. This field determines the
    ///size of the *Offsets*, *Sizes*, and *Strides* arrays. This value must match the *DimensionCount* of the input and
    ///output tensors. This value must be between 1 and 8, inclusively, starting from `DML_FEATURE_LEVEL_3_0`; earlier
    ///feature levels require a value of either 4 or 5.
    uint         DimensionCount;
    ///Type: \_Field\_size\_(DimensionCount) <b>const [UINT](/windows/desktop/winprog/windows-data-types)*</b> An array
    ///containing the slice's start along each dimension of the input tensor, in elements.
    const(uint)* Offsets;
    ///Type: \_Field\_size\_(DimensionCount) <b>const [UINT](/windows/desktop/winprog/windows-data-types)*</b> An array
    ///containing the slice's size along each dimension, in elements. The values in this array must match the sizes
    ///specified in the output tensor.
    const(uint)* Sizes;
    ///Type: \_Field\_size\_(DimensionCount) <b>const [UINT](/windows/desktop/winprog/windows-data-types)*</b> An array
    ///containing the slice's stride along each dimension of the input tensor, in elements. A stride larger than 1
    ///indicates that elements of the input tensor may be skipped (for example, a stride of 2 will select every second
    ///element along the dimension).
    const(uint)* Strides;
}

///Casts each element in the input to the data type of the output tensor, and stores the result in the corresponding
///element of the output.
struct DML_CAST_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor to write
    ///the results to. This tensor's *Sizes* should match *InputTensor*.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A pointer to a
    ///constant [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc) containing the description of
    ///the tensor to write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
}

///Splits an input tensor along an axis into multiple output tensors. All input and output tensors must have the same
///sizes, except for the split axis. The size of input tensor in the split axis determines the possible splits. For
///example, if the input tensor's split axis has size 3, then there are these potential splits: 1+1+1 (3 outputs), 1+2
///(2 outputs), 2+1 (2 outputs), or 3 (1 output, which is simply a copy of the input tensor). The output tensors' split
///axis sizes must sum up to exactly the input tensor's split axis size. These constraints are illustrated in the
///pseudocode below. ``` splitSize = 0; for (i = 0; i < OutputCount; i++) { assert(outputTensors[i]->DimensionCount ==
///inputTensor->DimensionCount); for (dim = 0; dim < inputTensor->DimensionCount; dim++) { if (dim == Axis) { splitSize
///+= outputTensors[i]->Sizes[dim]; } else { assert(outputTensors[i]->Sizes[dim] == inputTensor->Sizes[dim]); } } }
///assert(splitSize == inputTensor->Sizes[Axis]); ``` Splitting into a single output tensor simply produces a copy of
///the input tensor. This operator is the inverse of
///[DML_JOIN_OPERATOR_DESC](/windows/win32/api/directml/ns-directml-dml_join_operator_desc).
struct DML_SPLIT_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor to split
    ///into multiple output tensors.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) This field determines the size of the
    ///*OutputTensors* array. This value must be greater than 0.
    uint OutputCount;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An array containing
    ///the descriptions of the tensors split off from the input tensor. The output sizes must have the same sizes as the
    ///input tensor except for the split axis.
    const(DML_TENSOR_DESC)* OutputTensors;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The index of the dimension of the input tensor to
    ///split. All input and output tensors must have identical sizes in all dimensions except for this axis. This value
    ///must be in the range `[0, InputTensor.DimensionCount - 1]`.
    uint Axis;
}

///Concatenates an array of input tensors along a specified axis. Input tensors may only be joined if their sizes are
///identical in all dimensions except for the join axis, which may contain any non-zero size. The output sizes are equal
///to the input sizes except for the join axis, which is the sum of all inputs' join axis size. These constraints are
///illustrated in the pseudocode below. ``` joinSize = 0; for (i = 0; i < InputCount; i++) {
///assert(inputTensors[i]->DimensionCount == outputTensor->DimensionCount); for (dim = 0; dim <
///outputTensor->DimensionCount; dim++) { if (dim == Axis) { joinSize += inputTensors[i]->Sizes[dim]; } else {
///assert(inputTensors[i]->Sizes[dim] == outputTensor->Sizes[dim]); } } } assert(joinSize == outputTensor->Sizes[Axis]);
///``` Joining a single input tensor simply produces a copy of the input tensor. This operator is the inverse of
///[DML_SPLIT_OPERATOR_DESC](/windows/win32/api/directml/ns-directml-dml_split_operator_desc).
struct DML_JOIN_OPERATOR_DESC
{
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) This field determines the size of the
    ///*InputTensors* array. This value must be greater than 0.
    uint InputCount;
    ///Type: \_Field\_size\_(InputCount) **const
    ///[DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An array containing the
    ///descriptions of the tensors to join into a single output tensor. All input tensors in this array must have the
    ///same sizes except for the join axis, which may have any non-zero value.
    const(DML_TENSOR_DESC)* InputTensors;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor to write
    ///the joined input tensors into. The output sizes must have the same sizes as all input tensors except for the join
    ///axis, which must be equal to the sum of all inputs' join axis size.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The index of the dimension of the input tensors to
    ///join. All input and output tensors must have identical sizes in all dimensions except for this axis. This value
    ///must be in the range `[0, OutputTensor.DimensionCount - 1]`.
    uint Axis;
}

///Inflates the input tensor with constant or mirrored values on the edges, and writes the result to the output.
struct DML_PADDING_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the input data.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the output data. For each dimension `i`, `OutputTensor.Sizes[i] = InputTensor.Sizes[i] + StartPadding[i] +
    ///EndPadding[i]`.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: [DML_PADDING_MODE](/windows/win32/api/directml/ne-directml-dml_padding_mode) The padding mode to use when
    ///filling the padding regions. - **DML_PADDING_MODE_CONSTANT**. Uses a single constant value defined by
    ///*PaddingValue* for all padding values (see **Example 1**). - **DML_PADDING_MODE_EDGE**. For each dimension, use
    ///the edge values of that dimension for all padding values (see **Example 2**). - **DML_PADDING_MODE_REFLECTION**.
    ///Mirror the values of the tensor as if we folded it right on the edges, which means that edges are not mirrored.
    ///Note that `StartPadding[i] >= InputTensor.Sizes[i]`, and `EndPadding[i] >= InputTensor.Sizes[i]` is valid, which
    ///means that we can mirror new padding regions periodically by folding them over previous padding regions (see
    ///**Example 3**). - **DML_PADDING_MODE_SYMMETRIC**. Similar to **DML_PADDING_MODE_REFLECTION**, but edges are also
    ///mirrored. Note that `StartPadding[i] > InputTensor.Sizes[i]`, and `EndPadding[i] > InputTensor.Sizes[i]` is
    ///valid, which means that we can mirror new padding regions periodically by folding them over previous padding
    ///regions (see **Example 4**). **This mode was introduced in feature level `DML_FEATURE_LEVEL_3_0`**.
    DML_PADDING_MODE PaddingMode;
    ///Type: <b>FLOAT</b> The padding value to use when `PaddingMode == DML_PADDING_MODE_CONSTANT`. This value is
    ///ignored for other padding modes. Note that if the *DataType* of the tensors is not
    ///[DML_TENSOR_DATA_TYPE_FLOAT16](/windows/win32/api/directml/ne-directml-dml_tensor_data_type) or
    ///**DML_TENSOR_DATA_TYPE_FLOAT32**, then the value might be truncated (for example, 10.6 will become 10).
    float            PaddingValue;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The size of the arrays pointed to by *StartPadding*
    ///and *EndPadding*. This value can only be 4 or 5, and must be the same value as the dimension count of
    ///*InputTensor* and *OutputTensor*.
    uint             DimensionCount;
    ///Type: \_Field\_size\_(DimensionCount) <b>const [UINT](/windows/desktop/winprog/windows-data-types)*</b> The sizes
    ///of the padding regions to add at the beginning of each dimension. For each dimension `i`, `StartPadding[i] =
    ///OutputTensor.Sizes[i] - InputTensor.Sizes[i] - EndPadding[i]`.
    const(uint)*     StartPadding;
    ///Type: \_Field\_size\_(DimensionCount) <b>const [UINT](/windows/desktop/winprog/windows-data-types)*</b> The sizes
    ///of the padding regions to add at the end of each dimension. For each dimension `i`, `EndPadding[i] =
    ///OutputTensor.Sizes[i] - InputTensor.Sizes[i] - StartPadding[i]`.
    const(uint)*     EndPadding;
}

///Performs an element-wise scale-and-bias function, `Output = Scale * Input + Bias`. This operator is similar to using
///an
///[DML_ELEMENT_WISE_IDENTITY_OPERATOR_DESC](/windows/win32/api/directml/ns-directml-dml_element_wise_identity_operator_desc)
///with a scale and bias, except that **DML_VALUE_SCALE_2D_OPERATOR_DESC** applies a different bias for each channel,
///rather than a single bias for the entire tensor.
struct DML_VALUE_SCALE_2D_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the Input data. This tensor's dimensions should be `{ BatchCount, ChannelCount, Height, Width }`.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor with which
    ///to write the results to. This tensor's dimensions should match the *InputTensor*'s dimensions.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: <b>FLOAT</b> Scale value to be applied to all input values.
    float         Scale;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) This field determines the size of the Bias array.
    ///This field must be set to either 1 or 3, and must also match the size of the Channel dimension of the input
    ///tensor.
    uint          ChannelCount;
    ///Type: <b>const FLOAT*</b> An array of *FLOAT* values containing the bias term for each dimension of the input
    ///tensor.
    const(float)* Bias;
}

///Upsamples the input image, writing the result into the output tensor. The order of the dimensions should be NCHW
///(BatchSize, ChannelCount, Height, Width) or NCDHW (BatchSize, ChannelCount, Depth, Height, Width), but strides can be
///used if the data is stored in a different format. Unlike
///[DML_RESAMPLE_OPERATOR_DESC](/windows/win32/api/directml/ns-directml-dml_resample_operator_desc), only the last 2
///dimensions (height and width) can be upsampled. If available, you should prefer
///[DML_RESAMPLE_OPERATOR_DESC](/windows/win32/api/directml/ns-directml-dml_resample_operator_desc) since it is a more
///flexible version of **DML_UPSAMPLE_2D_OPERATOR_DESC**.
struct DML_UPSAMPLE_2D_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the input data. The expected dimensions of the InputTensor are `{ InputBatchCount, InputChannelCount,
    ///InputHeight, InputWidth }` for 4D, and `{ InputBatchCount, InputChannelCount, InputDepth, InputHeight, InputWidth
    ///}` for 5D.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the input data. The expected dimensions of the OutputTensor are `{ InputBatchCount, InputChannelCount,
    ///InputHeight * HeightScale, InputWidth * WidthScale }` for 4D, and `{ InputBatchCount, InputChannelCount,
    ///InputDepth, InputHeight * HeightScale, InputWidth * WidthScale }` for 5D.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: [**DML_SIZE_2D**](/windows/win32/api/directml/ns-directml-dml_size_2d) The width and height scales of type
    ///UINT to apply when upsampling the input. `0 < ScaleSize.Height <= UINT_MAX / InputHeight` and `0 <
    ///ScaleSize.Width <= UINT_MAX / InputWidth`.
    DML_SIZE_2D ScaleSize;
    ///Type: **[DML_INTERPOLATION_MODE](/windows/win32/api/directml/ne-directml-dml_interpolation_mode)** This field
    ///determines the kind of interpolation used to choose output pixels. -
    ///[DML_INTERPOLATION_MODE_NEAREST_NEIGHBOR](/windows/win32/api/directml/ne-directml-dml_interpolation_mode). Uses
    ///the *Nearest Neighbor* algorithm, which chooses the input element nearest to the corresponding pixel center for
    ///each output element. - **DML_INTERPOLATION_MODE_LINEAR**. Uses the *Bilinear* algorithm, which computes the
    ///output element by doing the weighted average of the 2 nearest neighboring input elements in the height dimension,
    ///and the 2 nearest neighboring input elements in the width dimension, for a total of 4 elements. This is true even
    ///if the input/output DimensionCount is 5. That is, samples are only ever averaged along the width and height
    ///dimensions, and never along the batch, channel, or depth.
    DML_INTERPOLATION_MODE InterpolationMode;
}

///Gathers elements from the input tensor along **Axis**, using **IndicesTensor** to remap indices. This operator
///performs the following pseudocode, where "..." represents a series of coordinates, with the exact behavior determined
///by the axis and indices dimension count: ``` output[...] = input[..., indices[...], ...] ```
struct DML_GATHER_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor to read
    ///from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the indices. The *DimensionCount* of this tensor must match *InputTensor.DimensionCount*. Starting with
    ///`DML_FEATURE_LEVEL_3_0`, this operator supports negative index values when using a signed integral type with this
    ///tensor. Negative indices are interpreted as being relative to the end of the axis dimension. For example, an
    ///index of -1 refers to the last element along that dimension.
    const(DML_TENSOR_DESC)* IndicesTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor to write
    ///the results to. The *DimensionCount* and *DataType* of this tensor must match *InputTensor.DimensionCount*. The
    ///expected *OutputTensor.Sizes* are the concatenation of the *InputTensor.Sizes* leading and trailing segments
    ///split at the current *Axis* with the *IndicesTensor.Sizes* inserted between. ``` OutputTensor.Sizes = {
    ///InputTensor.Sizes[0..Axis], IndicesTensor.Sizes[(IndicesTensor.DimensionCount - IndexDimensions) ..
    ///IndicesTensor.DimensionCount], InputTensor.Sizes[(Axis+1) .. InputTensor.DimensionCount] } ``` The dimensions are
    ///right-aligned such that any leading 1 values from the input sizes are cropped which would otherwise overflow the
    ///output *DimensionCount*. The number of relevant dimensions in this tensor depends on *IndexDimensions* and the
    ///*original rank* of *InputTensor*. The original rank is the number of dimensions prior to any padding with leading
    ///ones. The number of relevant dimensions in the output can be computed by the *original rank* of *InputTensor* +
    ///*IndexDimensions* - 1. This value must be less than or equal to the *DimensionCount* of *OutputTensor*.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The axis dimension of *InputTensor* to gather on,
    ///ranging `[0, *InputTensor.DimensionCount*)`.
    uint Axis;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The number of actual index dimensions within the
    ///`IndicesTensor` after ignoring any irrelevant leading ones, ranging [0, `IndicesTensor.DimensionCount`). For
    ///example, given `IndicesTensor.Sizes` = `{ 1, 1, 4, 6 }` and `IndexDimensions` = 3, the actual meaningful indices
    ///are `{ 1, 4, 6 }`.
    uint IndexDimensions;
}

///Rearranges blocks of spatial data into depth. The operator outputs a copy of the input tensor where values from the
///height and width dimensions are moved to the depth dimension. This is the inverse transformation of
///[DML_DEPTH_TO_SPACE_OPERATOR_DESC](/windows/win32/api/directml/ns-directml-dml_depth_to_space_operator_desc).
struct DML_SPACE_TO_DEPTH_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor to read
    ///from. The input tensor's dimensions are `{ Batch, Channels, Height, Width }`.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor to write
    ///the results to. The output tensor's dimensions are `{ Batch, Channels / (BlockSize * BlockSize), Height *
    ///BlockSize, Width * BlockSize }`.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The width and height of the Blocks that are moved.
    uint BlockSize;
}

///Rearranges (permutes) data from depth into blocks of spatial data. The operator outputs a copy of the input tensor
///where values from the depth dimension are moved in spatial blocks to the height and width dimensions. This is the
///inverse transformation of
///[DML_SPACE_TO_DEPTH_OPERATOR_DESC](/windows/win32/api/directml/ns-directml-dml_space_to_depth_operator_desc).
struct DML_DEPTH_TO_SPACE_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor to read
    ///from. The input tensor's dimensions are `{ BatchCount, InputChannelCount, InputHeight, InputWidth }`.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor to write
    ///the results to. The output tensor's dimensions are `{ BatchCount, OutputChannelCount, OutputHeight, OutputWidth
    ///}`, where: * OutputChannelCount is computed as InputChannelCount / (*BlockSize* * *BlockSize*). * OutputHeight is
    ///computed as InputHeight * *BlockSize*. * OutputWidth is computed as InputWidth * *BlockSize*.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The width and height of the blocks that are moved.
    uint BlockSize;
}

///Constructs an output tensor by tiling the input tensor. The elements in each dimension of the input tensor are
///repeated by a multiple in the *Repeats* array.
struct DML_TILE_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor to read
    ///from, which contains the elements to be tiled.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor to write
    ///to, which will hold the tiled output. For each dimension `i` in `[0, InputTensor.DimensionCount-1]`, the output
    ///size is calculated as `OutputTensor.Sizes[i] = InputTensor.Sizes[i] * Repeats[i]`. This tensor must have the same
    ///*DimensionCount* as the input tensor.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) This field determines the size of the *Repeats*
    ///array. This value must be the same as the *InputTensor.DimensionCount*.
    uint         RepeatsCount;
    ///Type: <b>const [UINT](/windows/desktop/winprog/windows-data-types)*</b> Each value in this array corresponds to
    ///one of the input tensor's dimensions (in order). Each value is the number of tiled copies to make of that
    ///dimension. Values must be larger than 0.
    const(uint)* Repeats;
}

///Selects the largest *K* elements from each sequence along an axis of the *InputTensor*, and returns the values and
///indices of those elements in the *OutputValueTensor* and *OutputIndexTensor*, respectively. A *sequence* refers to
///one of the sets of elements that exist along the *Axis* dimension of the *InputTensor*.
struct DML_TOP_K_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor
    ///containing elements to select.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the values of the top *K* elements to. This tensor must have sizes equal to the *InputTensor*, *except* for
    ///the dimension specified by the *Axis* parameter, which must have a size equal to *K*. The *K* values selected
    ///from each input sequence are guaranteed to be sorted descending (largest to smallest).
    const(DML_TENSOR_DESC)* OutputValueTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the indices of the top *K* elements to. This tensor must have sizes equal to the *InputTensor*, *except*
    ///for the dimension specified by the *Axis* parameter, which must have a size equal to *K*. The indices returned in
    ///this tensor are measured relative to the beginning of their sequence (as opposed to the beginning of the tensor).
    ///For example, an index of 0 always refers to the first element for all sequences in an axis. In cases where two or
    ///more elements in the top-K have the same value (that is, when there is a tie), the indices of both elements are
    ///included, and are guaranteed to be ordered by ascending element index.
    const(DML_TENSOR_DESC)* OutputIndexTensor;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The index of the dimension to select elements
    ///across. This value must be less than the *DimensionCount* of the *InputTensor*.
    uint Axis;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The number of elements to select. *K* must be
    ///greater than 0, but less than the number of elements in the *InputTensor* along the dimension specified by
    ///*Axis*.
    uint K;
}

///Performs a batch normalization on the input. This operator performs the following computation: `Output =
///FusedActivation(Scale * ((Input - Mean) / sqrt(Variance + Epsilon)) + Bias)`.
struct DML_BATCH_NORMALIZATION_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the Input data. This tensor's dimensions should be `{ BatchCount, ChannelCount, Height, Width }`.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the Mean data. This tensor's dimensions should be `{ MeanBatchCount, ChannelCount, MeanHeight, MeanWidth }`. The
    ///dimensions MeanBatchCount, MeanHeight, and MeanWidth should either match *InputTensor*, or be set to 1 to
    ///automatically broadcast those dimensions across the input.
    const(DML_TENSOR_DESC)* MeanTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the Variance data. This tensor's dimensions should be `{ VarianceBatchCount, ChannelCount, VarianceHeight,
    ///VarianceWidth }`. The dimensions VarianceBatchCount, VarianceHeight, and VarianceWidth should either match
    ///*InputTensor*, or be set to 1 to automatically broadcast those dimensions across the input.
    const(DML_TENSOR_DESC)* VarianceTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the Scale data. This tensor's dimensions should be `{ ScaleBatchCount, ChannelCount, ScaleHeight, ScaleWidth }`.
    ///The dimensions ScaleBatchCount, ScaleHeight, and ScaleWidth should either match *InputTensor*, or be set to 1 to
    ///automatically broadcast those dimensions across the input.
    const(DML_TENSOR_DESC)* ScaleTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the Bias data. This tensor's dimensions should be `{ BiasBatchCount, ChannelCount, BiasHeight, BiasWidth }`. The
    ///dimensions BiasBatchCount, BiasHeight, and BiasWidth should either match *InputTensor*, or be set to 1 to
    ///automatically broadcast those dimensions across the input.
    const(DML_TENSOR_DESC)* BiasTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor to write
    ///the results to. This tensor's dimensions should match *InputTensor*.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: <b>BOOL</b> **TRUE** to specify that locations are spatial, otherwise **FALSE**. Setting this to **FALSE**
    ///will require the Width and Height dimensions of *MeanTensor* and *VarianceTensor* to not be broadcast.
    BOOL  Spatial;
    ///Type: <b>FLOAT</b> The epsilon value to use to avoid division by zero.
    float Epsilon;
    ///Type: \_Maybenull\_ **const [DML_OPERATOR_DESC](/windows/win32/api/directml/ns-directml-dml_operator_desc)\*** An
    ///optional fused activation layer to apply after the normalization.
    const(DML_OPERATOR_DESC)* FusedActivation;
}

///Performs a mean variance normalization function on the input tensor. This operator will calculate the mean and
///variance of the input tensor to perform normalization. This operator performs the following computation. ``` Output =
///FusedActivation(Scale * ((Input - Mean) / sqrt(Variance + Epsilon)) + Bias). ```
struct DML_MEAN_VARIANCE_NORMALIZATION_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the Input data. This tensor's dimensions should be `{ BatchCount, ChannelCount, Height, Width }`.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: \_Maybenull\_ **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An
    ///optional tensor containing the Scale data. This tensor's dimensions should be `{ BatchCount, ChannelCount,
    ///Height, Width }`. Any dimension can be replaced with 1 to broadcast in that dimension. This tensor is required if
    ///the *BiasTensor* is used.
    const(DML_TENSOR_DESC)* ScaleTensor;
    ///Type: \_Maybenull\_ **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An
    ///optional tensor containing the bias data. This tensor's dimensions should be `{ BatchCount, ChannelCount, Height,
    ///Width }`. Any dimension can be replaced with 1 to broadcast in that dimension. This tensor is required if the
    ///*ScaleTensor* is used.
    const(DML_TENSOR_DESC)* BiasTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor to write
    ///the results to. This tensor's dimensions are `{ BatchCount, ChannelCount, Height, Width }`.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: <b>BOOL</b> **TRUE** if the MeanVariance layer includes channels in the Mean and Variance calculations.
    ///Otherwise, **FALSE**.
    BOOL  CrossChannel;
    ///Type: <b>BOOL</b> **TRUE** if the Normalization layer includes Variance in the normalization calculation.
    ///Otherwise, **FALSE**. If **FALSE**, then normalization equation is `Output = FusedActivation(Scale * (Input -
    ///Mean) + Bias)`.
    BOOL  NormalizeVariance;
    ///Type: <b>FLOAT</b> The epsilon value to use to avoid division by zero. A value of 0.00001 is recommended as
    ///default.
    float Epsilon;
    ///Type: \_Maybenull\_ **const [DML_OPERATOR_DESC](/windows/win32/api/directml/ns-directml-dml_operator_desc)\*** An
    ///optional fused activation layer to apply after the normalization.
    const(DML_OPERATOR_DESC)* FusedActivation;
}

///Performs a local response normalization (LRN) function on the input. This operator performs the following
///computation. ``` Output = Input / (Bias + (Alpha / LocalSize) * sum(Input^2 for every Input in the local
///region))^Beta ``` The data type and size of the input and output tensors must be the same.
struct DML_LOCAL_RESPONSE_NORMALIZATION_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor
    ///containing the input data. This tensor's *Sizes* should be `{ BatchCount, ChannelCount, Height, Width }`.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor to write
    ///the results to. This tensor's *Sizes* should match the *InputTensor*.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: <b>BOOL</b> **TRUE** if the LRN layer sums across channels; otherwise, **FALSE**.
    BOOL  CrossChannel;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The number of elements to sum over per dimension:
    ///Width, Height, and and optionally Channel (if *CrossChannel* is set).
    uint  LocalSize;
    ///Type: <b>FLOAT</b> The value of the scaling parameter. A value of 0.0001 is recommended as default.
    float Alpha;
    ///Type: <b>FLOAT</b> The value of the exponent. A value of 0.75 is recommended as default.
    float Beta;
    ///Type: <b>FLOAT</b> The value of bias. A value of 1 is recommended as default.
    float Bias;
}

///Performs an Lp-normalization function along the specified axis of the input tensor.
struct DML_LP_NORMALIZATION_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor
    ///containing the input data.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor to write
    ///the results to. This tensor's *Sizes* should match the *InputTensor*.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The axis on which to apply normalization.
    uint  Axis;
    ///Type: <b>FLOAT</b> The epsilon value to use to avoid division by zero. A value of 0.00001 is recommended as
    ///default.
    float Epsilon;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The order of the normalization (either 1 or 2).
    uint  P;
}

///Performs a one-layer simple recurrent neural network (RNN) function on the input. This function is often referred to
///as the Input Gate. This operator performs this function multiple times in a loop, dictated by the sequence length
///dimension and the *SequenceLengthsTensor*.
struct DML_RNN_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the input data, X. Packed (and potentially padded) into one 4-D tensor with the sizes of `{ 1, seq_length,
    ///batch_size, input_size }`. seq_length is the dimension that is mapped to the index, t.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the weight data, W. Concatenation of W_i and W_Bi (if bidirectional). The tensor has sizes `{ 1, num_directions,
    ///hidden_size, input_size }`.
    const(DML_TENSOR_DESC)* WeightTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An optional tensor
    ///containing the recurrence weight data, R. Concatenation of R_i and R_Bi (if bidirectional). This tensor has sizes
    ///`{ 1, num_directions, hidden_size, hidden_size }`.
    const(DML_TENSOR_DESC)* RecurrenceTensor;
    ///Type: \_Maybenull\_ **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An
    ///optional tensor containing the bias data for the input gate, B. Concatenation of `{ W_bi, R_bi }`, and `{ W_Bbi,
    ///R_Bbi }` (if bidirectional). This tensor has sizes `{ 1, 1, num_directions, 2 * hidden_size }`. If not specified,
    ///then defaults to 0.
    const(DML_TENSOR_DESC)* BiasTensor;
    ///Type: \_Maybenull\_ **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An
    ///optional tensor containing the hidden node initializer tensor, H_[t-1] for the first loop index t. If not
    ///specified, then defaults to 0. This tensor has sizes `{ 1, num_directions, batch_size, hidden_size }`.
    const(DML_TENSOR_DESC)* HiddenInitTensor;
    ///Type: \_Maybenull\_ **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An
    ///optional tensor containing an independent seq_length for each element in the batch. If not specified, then all
    ///sequences in the batch have length seq_length. This tensor has sizes `{ 1, 1, 1, batch_size }`.
    const(DML_TENSOR_DESC)* SequenceLengthsTensor;
    ///Type: \_Maybenull\_ **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An
    ///optional tensor with which to write the concatenation of all the intermediate layer output values of the hidden
    ///nodes, H_t. This tensor has sizes `{ seq_length, num_directions, batch_size, hidden_size }`. seq_length is mapped
    ///to the loop index t.
    const(DML_TENSOR_DESC)* OutputSequenceTensor;
    ///Type: \_Maybenull\_ **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An
    ///optional tensor with which to write the final output value of the hidden nodes, H_t. This tensor has sizes `{ 1,
    ///num_directions, batch_size, hidden_size }`.
    const(DML_TENSOR_DESC)* OutputSingleTensor;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) This field determines the size of the
    ///*ActivationDescs* array.
    uint ActivationDescCount;
    ///Type: \_Field\_size\_(ActivationDescCount) **const
    ///[DML_OPERATOR_DESC](/windows/win32/api/directml/ns-directml-dml_operator_desc)\*** An array of
    ///[DML_OPERATOR_DESC](/windows/win32/api/directml/ns-directml-dml_operator_desc) containing the descriptions of the
    ///activation operators, f(). The number of activation functions is equal to the number of directions. For forwards
    ///and backwards directions there is expected to be 1 activation fuction. For Bidirectional there are expected to be
    ///2.
    const(DML_OPERATOR_DESC)* ActivationDescs;
    ///Type:
    ///**[DML_RECURRENT_NETWORK_DIRECTION](/windows/win32/api/directml/ne-directml-dml_recurrent_network_direction)**
    ///The direction of the operator: forward, backward, or bidirectional.
    DML_RECURRENT_NETWORK_DIRECTION Direction;
}

///Performs a one-layer long short term memory (LSTM) function on the input. This operator uses multiple gates to
///perform this layer. These gates are performed multiple times in a loop, dictated by the sequence length dimension and
///the *SequenceLengthsTensor*.
struct DML_LSTM_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the input data, X. Packed (and potentially padded) into one 4-D tensor with the sizes of `{ 1, seq_length,
    ///batch_size, input_size }`. seq_length is the dimension that is mapped to the index, t.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the weight data, W. Concatenation of W_[iofc] and W_B[iofc] (if bidirectional). The tensor has sizes `{ 1,
    ///num_directions, 4 * hidden_size, input_size }`.
    const(DML_TENSOR_DESC)* WeightTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the recurrence data, R. Concatenation of R_[iofc] and R_B[iofc] (if bidirectional). This tensor has sizes `{ 1,
    ///num_directions, 4 * hidden_size, hidden_size }`.
    const(DML_TENSOR_DESC)* RecurrenceTensor;
    ///Type: \_Maybenull\_ **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An
    ///optional tensor containing the bias data, B. Concatenation of `{ W_b[iofc], R_b[iofc] }`, and `{ W_Bb[iofc],
    ///R_Bb[iofc] }` (if bidirectional). This tensor has sizes `{ 1, 1, num_directions, 8 * hidden_size }`. If not
    ///specified, then defaults to 0 bias.
    const(DML_TENSOR_DESC)* BiasTensor;
    ///Type: \_Maybenull\_ **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An
    ///optional tensor containing the hidden node initializer data, H_(t-1). Contents of this tensor are only used on
    ///the first loop index t. If not specified, then defaults to 0. This tensor has sizes `{ 1, num_directions,
    ///batch_size, hidden_size }`.
    const(DML_TENSOR_DESC)* HiddenInitTensor;
    ///Type: \_Maybenull\_ **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An
    ///optional tensor containing the cell initializer data, C_(t-1). Contents of this tensor are only used on the first
    ///loop index t. If not specified, then defaults to 0. This tensor has sizes `{ 1, num_directions, batch_size,
    ///hidden_size }`.
    const(DML_TENSOR_DESC)* CellMemInitTensor;
    ///Type: \_Maybenull\_ **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An
    ///optional tensor containing an independent seq_length for each element in the batch. If not specified, then all
    ///sequences in the batch have length seq_length. This tensor has sizes `{ 1, 1, 1, batch_size }`.
    const(DML_TENSOR_DESC)* SequenceLengthsTensor;
    ///Type: \_Maybenull\_ **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An
    ///optional tensor containing the weight data for peepholes, P. If not specified, then defaults to 0. Concatenation
    ///of P_[iof] and P_B[iof] (if bidirectional). This tensor has sizes `{ 1, 1, num_directions, 3 * hidden_size }`.
    const(DML_TENSOR_DESC)* PeepholeTensor;
    ///Type: \_Maybenull\_ **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An
    ///optional tensor with which to write the concatenation of all the intermediate output values of the hidden nodes,
    ///H_t. This tensor has sizes `{ seq_length, num_directions, batch_size, hidden_size }`. seq_length is mapped to the
    ///loop index t.
    const(DML_TENSOR_DESC)* OutputSequenceTensor;
    ///Type: \_Maybenull\_ **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An
    ///optional tensor with which to write the last output value of the hidden nodes, H_t. This tensor has sizes `{ 1,
    ///num_directions, batch_size, hidden_size }`.
    const(DML_TENSOR_DESC)* OutputSingleTensor;
    ///Type: \_Maybenull\_ **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An
    ///optional tensor with which to write the last output value of the cell, C_t. This tensor has sizes `{ 1,
    ///num_directions, batch_size, hidden_size }`.
    const(DML_TENSOR_DESC)* OutputCellSingleTensor;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) This field determines the size of the
    ///*ActivationDescs* array.
    uint  ActivationDescCount;
    ///Type: \_Field\_size\_(ActivationDescCount) **const
    ///[DML_OPERATOR_DESC](/windows/win32/api/directml/ns-directml-dml_operator_desc)\*** An array of
    ///[DML_OPERATOR_DESC](/windows/win32/api/directml/ns-directml-dml_operator_desc) containing the descriptions of the
    ///activation operators f(), g(), and h(). f(), g(), and h() are defined independently of direction, meaning that if
    ///[DML_RECURRENT_NETWORK_DIRECTION_FORWARD](/windows/win32/api/directml/ne-directml-dml_recurrent_network_direction)
    ///or **DML_RECURRENT_NETWORK_DIRECTION_BACKWARD** are supplied in *Direction*, then three activations must be
    ///provided. If **DML_RECURRENT_NETWORK_DIRECTION_BIDIRECTIONAL** is defined, then six activations must be provided.
    ///For bidirectional, activations must be provided f(), g(), and h() for forward followed by f(), g(), and h() for
    ///backwards.
    const(DML_OPERATOR_DESC)* ActivationDescs;
    ///Type: **const
    ///[DML_RECURRENT_NETWORK_DIRECTION](/windows/win32/api/directml/ne-directml-dml_recurrent_network_direction)\***
    ///The direction of the operator: forward, backward, or bidirectional.
    DML_RECURRENT_NETWORK_DIRECTION Direction;
    ///Type: <b>float</b> The cell clip threshold. Clipping bounds the elements of a tensor in the range of
    ///[-`ClipThreshold`, +`ClipThreshold`], and is applied to the input of activations.
    float ClipThreshold;
    ///Type: <b>BOOL</b> **TRUE** if *ClipThreshold* should be used. Otherwise, **FALSE**.
    BOOL  UseClipThreshold;
    ///Type: <b>BOOL</b> **TRUE** if the input and forget gates should be coupled. Otherwise, **FALSE**.
    BOOL  CoupleInputForget;
}

///Performs a (standard layers) one-layer gated recurrent unit (GRU) function on the input. This operator uses multiple
///gates to perform this layer. These gates are performed multiple times in a loop dictated by the sequence length
///dimension and the *SequenceLengthsTensor*.
struct DML_GRU_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the input data, X. Packed (and potentially padded) into one 4D tensor with the *Sizes* of `{ 1, seq_length,
    ///batch_size, input_size }`. seq_length is the dimension that is mapped to the index, t.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the weight data, W. Concatenation of W_[zrh] and W_B[zrh] (if bidirectional). The tensor has *Sizes* `{ 1,
    ///num_directions, 3 * hidden_size, input_size }`.
    const(DML_TENSOR_DESC)* WeightTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the recurrence data, R. Concatenation of R_[zrh] and R_B[zrh] (if bidirectional). The tensor has *Sizes* `{ 1,
    ///num_directions, 3 * hidden_size, hidden_size }`.
    const(DML_TENSOR_DESC)* RecurrenceTensor;
    ///Type: \_Maybenull\_ **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An
    ///optional tensor containing the bias data, B. Concatenation of (W_b[zrh], R_b[zrh]) and (W_Bb[zrh], R_Bb[zrh]) (if
    ///bidirectional). The tensor has *Sizes* `{ 1, 1, num_directions, 6 * hidden_size }`.
    const(DML_TENSOR_DESC)* BiasTensor;
    ///Type: \_Maybenull\_ **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An
    ///optional tensor containing the hidden node initializer tensor, H_t-1 for the first loop index t. If not
    ///specified, then defaults to 0. This tensor has *Sizes* `{ 1, num_directions, batch_size, hidden_size }`.
    const(DML_TENSOR_DESC)* HiddenInitTensor;
    ///Type: \_Maybenull\_ **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An
    ///optional tensor containing an independent seq_length for each element in the batch. If not specified, then all
    ///sequences in the batch have length seq_length. This tensor has *Sizes* `{ 1, 1, 1, batch_size }`.
    const(DML_TENSOR_DESC)* SequenceLengthsTensor;
    ///Type: \_Maybenull\_ **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An
    ///optional tensor with which to write the concatenation of all the intermediate output values of the hidden nodes,
    ///H_t. This tensor has *Sizes* `{ seq_length, num_directions, batch_size, hidden_size }`. seq_length is mapped to
    ///the loop index t.
    const(DML_TENSOR_DESC)* OutputSequenceTensor;
    ///Type: \_Maybenull\_ **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An
    ///optional tensor with which to write the last output value of the hidden nodes, H_t. This tensor has *Sizes* `{ 1,
    ///num_directions, batch_size, hidden_size }`.
    const(DML_TENSOR_DESC)* OutputSingleTensor;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) This field determines the size of the
    ///*ActivationDescs* array.
    uint ActivationDescCount;
    ///Type: \_Field\_size\_(ActivationDescCount) **const
    ///[DML_OPERATOR_DESC](/windows/win32/api/directml/ns-directml-dml_operator_desc)\*** An array of
    ///[DML_OPERATOR_DESC](/windows/win32/api/directml/ns-directml-dml_operator_desc) containing the descriptions of the
    ///activation operators, f() and g(). Both f() and g() are defined independently of direction, meaning that if
    ///[DML_RECURRENT_NETWORK_DIRECTION_FORWARD](/windows/win32/api/directml/ne-directml-dml_recurrent_network_direction)
    ///or **DML_RECURRENT_NETWORK_DIRECTION_BACKWARD** are supplied in *Direction*, then two activations must be
    ///provided. If **DML_RECURRENT_NETWORK_DIRECTION_BIDIRECTIONAL** is supplied, then four activations must be
    ///provided. For bidirectional, activations must be provided f() and g() for forward followed by f() and g() for
    ///backwards.
    const(DML_OPERATOR_DESC)* ActivationDescs;
    ///Type: **const
    ///[DML_RECURRENT_NETWORK_DIRECTION](/windows/win32/api/directml/ne-directml-dml_recurrent_network_direction)\***
    ///The direction of the operator&mdash;forward, backwards, or bidirectional.
    DML_RECURRENT_NETWORK_DIRECTION Direction;
    ///Type: <b>BOOL</b> **TRUE** to specify that, when computing the output of the hidden gate, the linear
    ///transformation should be applied before multiplying by the output of the reset gate. Otherwise, **FALSE**.
    BOOL LinearBeforeReset;
}

///Returns a value representing the sign of each element of *InputTensor*, placing the result into the corresponding
///element of *OutputTensor*. ``` f(x) = -1, if x < 0 1, if x > 0 0, otherwise // This includes negative zero. ``` This
///operator supports in-place execution, meaning that *OutputTensor* is permitted to alias *InputTensor* during binding.
struct DML_ELEMENT_WISE_SIGN_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](./ns-directml-dml_tensor_desc.md)\*** The input tensor to read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](./ns-directml-dml_tensor_desc.md)\*** The output tensor to write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
}

///For each element of the input tensor, returns 1 if the input is NaN (as defined by IEEE-754), and 0 otherwise. The
///result is placed into the corresponding element of the output tensor.
struct DML_ELEMENT_WISE_IS_NAN_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
}

///Performs the Gaussian error function (erf) on each element of *InputTensor*, placing the result into the
///corresponding element of *OutputTensor*. ``` f(x) = 2 / sqrt(pi) * integrate( i = 0 to x, exp(-(i^2)) ) ``` Where
///exp(x) is the natural exponentiation function. This operator supports in-place execution, meaning that *OutputTensor*
///is permitted to alias *InputTensor* during binding.
struct DML_ELEMENT_WISE_ERF_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: \_Maybenull\_ **const [DML_SCALE_BIAS](/windows/win32/api/directml/ns-directml-dml_scale_bias)\*** An
    ///optional scale and bias to apply to the input. If present, this has the effect of applying the function `g(x) = x
    ///* scale + bias` to each *input* element prior to computing this operator.
    const(DML_SCALE_BIAS)* ScaleBias;
}

///Computes the hyperbolic sine of each element of *InputTensor*, placing the result into the corresponding element of
///*OutputTensor*. ``` f(x) = sinh(x) ``` This operator supports in-place execution, meaning that *OutputTensor* is
///permitted to alias *InputTensor* during binding.
struct DML_ELEMENT_WISE_SINH_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: \_Maybenull\_ **const [DML_SCALE_BIAS](/windows/win32/api/directml/ns-directml-dml_scale_bias)\*** An
    ///optional scale and bias to apply to the input. If present, this has the effect of applying the function `g(x) = x
    ///* scale + bias` to each *input* element prior to computing this operator.
    const(DML_SCALE_BIAS)* ScaleBias;
}

///Computes the hyperbolic cosine of each element of *InputTensor*, placing the result into the corresponding element of
///*OutputTensor*. ``` f(x) = cosh(x) ``` This operator supports in-place execution, meaning that *OutputTensor* is
///permitted to alias *InputTensor* during binding.
struct DML_ELEMENT_WISE_COSH_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: \_Maybenull\_ **const [DML_SCALE_BIAS](/windows/win32/api/directml/ns-directml-dml_scale_bias)\*** An
    ///optional scale and bias to apply to the input. If present, this has the effect of applying the function `g(x) = x
    ///* scale + bias` to each *input* element prior to computing this operator.
    const(DML_SCALE_BIAS)* ScaleBias;
}

///Computes the hyperbolic tangent of element of *InputTensor*, placing the result into the corresponding element of
///*OutputTensor*. ``` f(x) = tanh(x) ``` This operator supports in-place execution, meaning that *OutputTensor* is
///permitted to alias *InputTensor* during binding.
struct DML_ELEMENT_WISE_TANH_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: \_Maybenull\_ **const [DML_SCALE_BIAS](/windows/win32/api/directml/ns-directml-dml_scale_bias)\***
    const(DML_SCALE_BIAS)* ScaleBias;
}

///Computes the hyperbolic arcsine for each element of *InputTensor*, placing the result into the corresponding element
///of *OutputTensor*. ``` f(x) = asinh(x) // ln(x + sqrt(x * x + 1)) ``` This operator supports in-place execution,
///meaning that *OutputTensor* is permitted to alias *InputTensor* during binding.
struct DML_ELEMENT_WISE_ASINH_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: \_Maybenull\_ **const [DML_SCALE_BIAS](/windows/win32/api/directml/ns-directml-dml_scale_bias)\*** An
    ///optional scale and bias to apply to the input. If present, this has the effect of applying the function `g(x) = x
    ///* scale + bias` to each *input* element prior to computing this operator.
    const(DML_SCALE_BIAS)* ScaleBias;
}

///Computes the hyperbolic arccosine for each element of *InputTensor*, placing the result into the corresponding
///element of *OutputTensor*. ``` f(x) = acosh(x) // ln(x + sqrt(x * x - 1)) ``` This operator supports in-place
///execution, meaning that *OutputTensor* is permitted to alias *InputTensor* during binding.
struct DML_ELEMENT_WISE_ACOSH_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: \_Maybenull\_ **const [DML_SCALE_BIAS](/windows/win32/api/directml/ns-directml-dml_scale_bias)\*** An
    ///optional scale and bias to apply to the input. If present, this has the effect of applying the function `g(x) = x
    ///* scale + bias` to each *input* element prior to computing this operator.
    const(DML_SCALE_BIAS)* ScaleBias;
}

///Computes the hyperbolic arctangent for each element of *InputTensor*, placing the result into the corresponding
///element of *OutputTensor*. ``` f(x) = atanh(x) // ln((1 + x) / (1 - x)) / 2 ``` This operator supports in-place
///execution, meaning that *OutputTensor* is permitted to alias *InputTensor* during binding.
struct DML_ELEMENT_WISE_ATANH_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The input tensor to
    ///read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: \_Maybenull\_ **const [DML_SCALE_BIAS](/windows/win32/api/directml/ns-directml-dml_scale_bias)\*** An
    ///optional scale and bias to apply to the input. If present, this has the effect of applying the function `g(x) = x
    ///* scale + bias` to each *input* element prior to computing this operator.
    const(DML_SCALE_BIAS)* ScaleBias;
}

///Selects elements either from *ATensor* or *BTensor*, depending on the value of the corresponding element in
///*ConditionTensor*. Non-zero elements of *ConditionTensor* select from *ATensor*, while zero-valued elements select
///from *BTensor*. ``` f(cond, a, b) = a, if cond != 0 b, otherwise Example: [[1, 0], [1, 1]] // ConditionTensor [[1,
///2], [3, 4]] // ATensor [[9, 8], [7, 6]] // BTensor [[1, 8], [3, 4]] // Output ```
struct DML_ELEMENT_WISE_IF_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The condition tensor
    ///to read from.
    const(DML_TENSOR_DESC)* ConditionTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the left-hand side inputs.
    const(DML_TENSOR_DESC)* ATensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the right-hand side inputs.
    const(DML_TENSOR_DESC)* BTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
}

///Performs the shrink activation function on every element in *InputTensor*, placing the result into the corresponding
///element of *OutputTensor*. ``` f(x) = x - Bias, if x > Threshold x + Bias, if x < -Threshold 0, otherwise ``` This
///operator supports in-place execution, meaning that the output tensor is permitted to alias *InputTensor* during
///binding.
struct DML_ACTIVATION_SHRINK_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](./ns-directml-dml_tensor_desc.md)\*** The input tensor to read from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](./ns-directml-dml_tensor_desc.md)\*** The output tensor to write the results to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: **[FLOAT](/windows/desktop/WinProg/windows-data-types)** The value of the bias. A typical default for this
    ///value is 0.0.
    float Bias;
    ///Type: **[FLOAT](/windows/desktop/WinProg/windows-data-types)** The value of the threshold. A typical default for
    ///this value is 0.5.
    float Threshold;
}

///Inverts a max-pooling operation (see
///[DML_MAX_POOLING_OPERATOR1_DESC](/windows/win32/api/directml/ns-directml-dml_max_pooling1_operator_desc) for details)
///by filling the output tensor *OutputTensor* with the values in the input tensor *InputTensor*, as obtained from a
///max-pooling operation, according to the index values provided in the *IndicesTensor*. The elements in the output
///tensor untouched by this process are left with zero values.
struct DML_MAX_UNPOOLING_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An input tensor of
    ///*Sizes* `{ Batch, Channel, Height, Width }`. The tensor values are obtained from the values in the *OutputTensor*
    ///of a max-pooling operation.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor of indices
    ///to the output tensor *OutputTensor* for the values given in the input tensor *InputTensor*. These index values
    ///are zero-based, and treat the output tensor as a contiguous one-dimensional array. Both the *InputTensor* and
    ///*IndicesTensor* have the same tensor sizes. The tensor values are obtained from the *OutputIndicesTensor* of a
    ///max-pooling operation.
    const(DML_TENSOR_DESC)* IndicesTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** An output tensor of
    ///the same number of dimensions as the input tensor.
    const(DML_TENSOR_DESC)* OutputTensor;
}

///Generates an identity-like matrix with ones (or other explicit value) on the major diagonal, and zeros everywhere
///else. The diagonal ones may be shifted (via *Offset*) where `OutputTensor[i, i + Offset]` = *Value*, meaning that an
///argument of *Offset* greater than zero shifts all values to the right, and less than zero shifts them to the left.
///This generator operator is useful for models to avoid storing a large constant tensor. Any leading dimensions before
///the last two are treated as a batch count, meaning that the tensor is treated as stack of 2D matrices. This operator
///performs the following pseudocode. ``` for each coordinate in OutputTensor OutputTensor[coordinate] = if
///(coordinate.y + Offset == coordinate.x) then Value else 0 endfor ```
struct DML_DIAGONAL_MATRIX_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor to write
    ///the results to. The dimensions are `{ Batch1, Batch2, OutputHeight, OutputWidth }`. The height and width don't
    ///need to be square.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: **[INT](/windows/desktop/winprog/windows-data-types)** An offset to shift the diagonal lines of *Value*,
    ///with positive offsets shifting the written value to the right/up (viewing the output as a matrix with the top
    ///left as 0,0), and negative offsets to the left/down.
    int   Offset;
    ///Type: **[FLOAT](/windows/desktop/winprog/windows-data-types)** A value to fill along the 2D diagonal. The
    ///standard value is 1.0. Note that if the *DataType* of the tensors is not
    ///[DML_TENSOR_DATA_TYPE_FLOAT16](/windows/win32/api/directml/ne-directml-dml_tensor_data_type) or
    ///**DML_TENSOR_DATA_TYPE_FLOAT32**, then the value might be truncated (for example, 10.6 will become 10).
    float Value;
}

///Copies the whole input tensor to the output, then overwrites selected indices with corresponding values from the
///updates tensor. This operator performs the following pseudocode. ``` output = input output[index[i, j, k, ...], j, k,
///...] = updates[i, j, k, ...] // if axis == 0 output[i, index[i, j, k, ...], k, ...] = updates[i, j, k, ...] // if
///axis == 1 output[i, j, index[i, j, k, ...], ...] = updates[i, j, k, ...] // if axis == 2 ... ``` If two output
///element indices overlap (which is invalid), then there's no guarantee of which last write wins.
///**DML_SCATTER_OPERATOR_DESC** is the inverse of
///[DML_GATHER_OPERATOR_DESC](/windows/win32/api/directml/ns-directml-dml_gather_operator_desc).
struct DML_SCATTER_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor to read
    ///from.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the indices into the output tensor. The *Sizes* must match *InputTensor.Sizes* for every dimension except *Axis*.
    ///Starting with `DML_FEATURE_LEVEL_3_0`, this operator supports negative index values when using a signed integral
    ///type with this tensor. Negative indices are interpreted as being relative to the end of the axis dimension. For
    ///example, an index of -1 refers to the last element along that dimension.
    const(DML_TENSOR_DESC)* IndicesTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the new values to replace the existing input values at the corresponding indices. The *Sizes* of this tensor must
    ///match *IndicesTensor.Sizes*. The *DataType* must match *InputTensor.DataType*.
    const(DML_TENSOR_DESC)* UpdatesTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor to write
    ///the results to. The *Sizes* and *DataType* of this tensor must match *InputTensor*.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The axis dimension to use for indexing in
    ///*OutputTensor*, ranging `[0, OutputTensor.DimensionCount)`.
    uint Axis;
}

///Produces a tensor filled with *one-hot encoded* values. This operator produces an output tensor where, for all
///sequences in a chosen axis, all but one element in that sequence is set to *OffValue*, and the remaining single
///element is set to *OnValue*. A *sequence* refers to one of the sets of elements that exist along the *Axis* dimension
///of the *OutputTensor*. The location of the *OnValue* for each sequence and the choice of *OnValue*/*OffValue* are
///determined by the *IndicesTensor* and *ValuesTensor*, respectively.
struct DML_ONE_HOT_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** A tensor containing
    ///the index in elements of the *OnValue*, for each sequence along the *Axis*. Indices are measured relative to the
    ///beginning of their sequence (as opposed to the beginning of the tensor). For example, an index of 0 always refers
    ///to the first element for all sequences in an axis. If an index value for a sequence exceeds the number of
    ///elements along the *Axis* dimension in the *OutputTensor*, then that index value is ignored, and all elements in
    ///that sequence will be set to *OffValue*. Starting with `DML_FEATURE_LEVEL_3_0`, this operator supports negative
    ///index values when using a signed integral type with this tensor. Negative indices are interpreted as being
    ///relative to the end of the sequence. For example, an index of -1 refers to the last element in the sequence. This
    ///tensor must have dimension count and sizes equal to the *OutputTensor*, *except* for the dimension specified by
    ///the *Axis* parameter. The size of the *Axis* dimension must be 1. For example if the *OutputTensor* has sizes of
    ///`{2,3,4,5}` and *Axis* is 1, the sizes of the *IndicesTensor* must be `{2,1,4,5}`.
    const(DML_TENSOR_DESC)* IndicesTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** This tensor may have
    ///any size, so long as it contains at least two elements. The 0th element of this tensor is interpreted as the
    ///*OffValue*, and the 1st element along the fastest-changing dimension of size >1 is interpreted as the *OnValue*.
    const(DML_TENSOR_DESC)* ValuesTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The output tensor to
    ///write the results to. This tensor must have dimension count and sizes equal to the *IndicesTensor*, *except* for
    ///the dimension specified by the *Axis* parameter. The size of the *Axis* dimension in this tensor may have any
    ///value greater than 0.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The index of the dimension to produce one-hot
    ///encoded sequences along. This value must be less than the DimensionCount of the *IndicesTensor*.
    uint Axis;
}

///Resamples elements from the source to the destination tensor, using the scale factors to compute the destination
///tensor size. You can use a linear or nearest-neighbor interpolation mode. The operator supports interpolation across
///multiple dimensions, not just 2D. So you can keep the same spatial size, but interpolate across channels or across
///batches.
struct DML_RESAMPLE_OPERATOR_DESC
{
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor
    ///containing the input data.
    const(DML_TENSOR_DESC)* InputTensor;
    ///Type: **const [DML_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_tensor_desc)\*** The tensor to write
    ///the output data to.
    const(DML_TENSOR_DESC)* OutputTensor;
    ///Type: [**DML_INTERPOLATION_MODE**](/windows/win32/api/directml/ne-directml-dml_interpolation_mode) This field
    ///determines the kind of interpolation used to choose output pixels. - **DML_INTERPOLATION_MODE_NEAREST_NEIGHBOR**.
    ///Uses the *Nearest Neighbor* algorithm, which chooses the input element nearest to the corresponding pixel center
    ///for each output element. - **DML_INTERPOLATION_MODE_LINEAR**. Uses the *Quadrilinear* algorithm, which computes
    ///the output element by doing the weighted average of the 2 nearest neighboring input elements per dimension. Since
    ///all 4 dimensions can be resampled, the weighted average is computed on a total of 16 input elements for each
    ///output element.
    DML_INTERPOLATION_MODE InterpolationMode;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The number of values in the array *Scales* points
    ///to. This value must match the dimension count of *InputTensor* and *OutputTensor*, which has to be 4.
    uint          ScaleCount;
    ///Type: \_Field\_size\_(ScaleCount) **const [FLOAT](/windows/desktop/WinProg/windows-data-types)\*** The scales to
    ///apply when resampling the input, where scales > 1 scale up the image and scales < 1 scale down the image for that
    ///dimension. Note that the scales don't need to be exactly `OutputSize / InputSize`. If the input after scaling is
    ///larger than the output bound, then we crop it to the output size. On the other hand, if the input after scaling
    ///is smaller than the output bound, the output edges are clamped.
    const(float)* Scales;
}

///Used to query a DirectML device for its support for a particular data type within tensors. See
///[IDMLDevice::CheckFeatureSupport](/windows/win32/api/directml/nf-directml-idmldevice-checkfeaturesupport). The query
///type is <b>DML_FEATURE_QUERY_TENSOR_DATA_TYPE_SUPPORT</b>, and the support data type is
///[DML_FEATURE_DATA_TENSOR_DATA_TYPE_SUPPORT](/windows/win32/api/directml/ns-directml-dml_feature_data_tensor_data_type_support).
struct DML_FEATURE_QUERY_TENSOR_DATA_TYPE_SUPPORT
{
    DML_TENSOR_DATA_TYPE DataType;
}

///Provides detail about whether a DirectML device supports a particular data type within tensors. See
///[IDMLDevice::CheckFeatureSupport](/windows/win32/api/directml/nf-directml-idmldevice-checkfeaturesupport). The query
///type is
///[DML_FEATURE_QUERY_TENSOR_DATA_TYPE_SUPPORT](/windows/win32/api/directml/ns-directml-dml_feature_query_tensor_data_type_support),
///and the support data type is <b>DML_FEATURE_DATA_TENSOR_DATA_TYPE_SUPPORT</b>.
struct DML_FEATURE_DATA_TENSOR_DATA_TYPE_SUPPORT
{
    ///Type: <b>BOOL</b> <b>TRUE</b> if the tensor data type is supported within tensors by the DirectML device.
    ///Otherwise, <b>FALSE</b>.
    BOOL IsSupported;
}

///Used to query a DirectML device for its support for one or more feature levels. See
///[IDMLDevice::CheckFeatureSupport](/windows/win32/api/directml/nf-directml-idmldevice-checkfeaturesupport). The
///feature constant is **DML_FEATURE_FEATURE_LEVELS**, and the support data type is
///[DML_FEATURE_DATA_FEATURE_LEVELS](/windows/win32/api/directml/ns-directml-dml_feature_data_feature_levels).
struct DML_FEATURE_QUERY_FEATURE_LEVELS
{
    ///Type: **[UINT](/windows/desktop/WinProg/windows-data-types)** The number of elements in the
    ///*RequestedFeatureLevels* array.
    uint RequestedFeatureLevelCount;
    ///Type: \_Field\_size\_(RequestedFeatureLevelCount)
    ///**[DML_FEATURE_LEVEL](/windows/win32/api/directml/ne-directml-dml_feature_level)\*** An array of feature levels
    ///to query support for. When
    ///[IDMLDevice::CheckFeatureSupport](/windows/win32/api/directml/nf-directml-idmldevice-checkfeaturesupport)
    ///returns, the
    ///[DML_FEATURE_DATA_FEATURE_LEVELS](/windows/win32/api/directml/ns-directml-dml_feature_data_feature_levels) struct
    ///contains the highest feature level in this array that is supported by the device.
    const(DML_FEATURE_LEVEL)* RequestedFeatureLevels;
}

///Provides detail about the feature levels supported by a DirectML device. See
///[IDMLDevice::CheckFeatureSupport](/windows/win32/api/directml/nf-directml-idmldevice-checkfeaturesupport). The
///feature constant is **DML_FEATURE_FEATURE_LEVELS**, and the query data type is
///[DML_FEATURE_QUERY_FEATURE_LEVELS](/windows/win32/api/directml/ns-directml-dml_feature_query_feature_levels).
struct DML_FEATURE_DATA_FEATURE_LEVELS
{
    ///Type: **[DML_FEATURE_LEVEL](/windows/win32/direct3d12/ne-directml-dml_feature_level)** The highest feature level
    ///supplied in the query structure's *RequestedFeatureLevels* (see
    ///[DML_FEATURE_DATA_FEATURE_LEVELS](/windows/win32/direct3d12/ns-directml-dml_feature_data_feature_levels)) that is
    ///supported by this device. > [!NOTE] > Because this feature query only ever returns one of the values supplied in
    ///*RequestedFeatureLevels*, it's possible that the device supports an even higher feature level than the one
    ///returned by this query. For example, DirectML version `1.4.0` supports a feature level of
    ///`DML_FEATURE_LEVEL_3_0`. If the *RequestedFeatureLevels* array contained only `DML_FEATURE_LEVEL_1_0` and
    ///`DML_FEATURE_LEVEL_2_0`, then this query would return `DML_FEATURE_LEVEL_2_0`, which is lower than the true
    ///feature level (3_0) supported by the device.
    DML_FEATURE_LEVEL MaxSupportedFeatureLevel;
}

///Specifies parameters to
///[IDMLDevice::CreateBindingTable](/windows/win32/api/directml/nf-directml-idmldevice-createbindingtable) and
///[IDMLBindingTable::Reset](/windows/win32/api/directml/nf-directml-idmlbindingtable-reset).
struct DML_BINDING_TABLE_DESC
{
    ///Type: <b>[IDMLDispatchable](/windows/win32/api/directml/nn-directml-idmldispatchable)*</b> A pointer to an
    ///[IDMLDispatchable](/windows/win32/api/directml/nn-directml-idmldispatchable) interface representing the
    ///dispatchable object (an operator initializer, or a compiled operator) for which this binding table will represent
    ///the bindings—either an [IDMLCompiledOperator](/windows/win32/api/directml/nn-directml-idmlcompiledoperator) or
    ///an [IDMLOperatorInitializer](/windows/win32/api/directml/nn-directml-idmloperatorinitializer). The binding table
    ///maintains a strong reference to this interface pointer. This value may not be null.
    IDMLDispatchable Dispatchable;
    ///Type: <b>D3D12_CPU_DESCRIPTOR_HANDLE</b> A valid CPU descriptor handle representing the start of a range into a
    ///constant buffer view (CBV)/shader resource view (SRV)/ unordered access view (UAV) descriptor heap into which
    ///DirectML may write descriptors.
    D3D12_CPU_DESCRIPTOR_HANDLE CPUDescriptorHandle;
    ///Type: <b>D3D12_GPU_DESCRIPTOR_HANDLE</b> A valid GPU descriptor handle representing the start of a range into a
    ///constant buffer view (CBV)/shader resource view (SRV)/ unordered access view (UAV) descriptor heap that DirectML
    ///may use to bind resources to the pipeline.
    D3D12_GPU_DESCRIPTOR_HANDLE GPUDescriptorHandle;
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The size of the binding table, in descriptors. This
    ///is the maximum number of descriptors that DirectML is permitted to write, from the start of both the supplied CPU
    ///and GPU descriptor handles. Call
    ///[IDMLDispatchable::GetBindingProperties](/windows/win32/api/directml/nf-directml-idmldispatchable-getbindingproperties)
    ///to determine the number of descriptors required to execute a dispatchable object.
    uint             SizeInDescriptors;
}

///Contains information about the binding requirements of a particular compiled operator, or operator initializer. This
///struct is retrieved from
///[IDMLDispatchable::GetBindingProperties](/windows/win32/api/directml/nf-directml-idmldispatchable-getbindingproperties).
struct DML_BINDING_PROPERTIES
{
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The minimum size, in descriptors, of the binding
    ///table required for a particular dispatchable object (an operator initializer, or a compiled operator).
    uint  RequiredDescriptorCount;
    ///Type: <b>UINT64</b> The minimum size in bytes of the temporary resource that must be bound to the binding table
    ///for a particular dispatchable object. A value of zero means that a temporary resource is not required.
    ulong TemporaryResourceSize;
    ///Type: <b>UINT64</b> The minimum size in bytes of the persistent resource that must be bound to the binding table
    ///for a particular dispatchable object. Persistent resources must be supplied during initialization of a compiled
    ///operator (where it is bound as an output of the operator initializer) as well as during execution. A value of
    ///zero means that a persistent resource is not required. Only compiled operators have persistent
    ///resources—operator initializers always return a value of 0 for this member.
    ulong PersistentResourceSize;
}

///Contains the description of a binding so that you can add it to the binding table via a call to one of the
///[IDMLBindingTable](/windows/win32/api/directml/nn-directml-idmlbindingtable) methods. A binding can refer to an input
///or an output tensor resource, or to a persistent or a temporary resource, and there are methods on
///[IDMLBindingTable](/windows/win32/api/directml/nn-directml-idmlbindingtable) to bind each kind. The type of the
///structure pointed to by <i>Desc</i> depends on the value of <i>Type</i>.
struct DML_BINDING_DESC
{
    ///Type: [**DML_BINDING_TYPE**](/windows/win32/api/directml/ne-directml-dml_binding_type) A
    ///[DML_BINDING_TYPE](/windows/win32/api/directml/ne-directml-dml_binding_type) specifying the type of the binding;
    ///whether it refers to a single buffer, or to an array of buffers.
    DML_BINDING_TYPE Type;
    ///Type: <b>const void*</b> A pointer to a constant structure whose type depends on the value <i>Type</i>. If
    ///<i>Type</i> is [DML_BINDING_TYPE_BUFFER](/windows/win32/api/directml/ne-directml-dml_binding_type), then
    ///<i>Desc</i> should point to a [DML_BUFFER_BINDING](/windows/win32/api/directml/ns-directml-dml_buffer_binding).
    ///If <i>Type</i> is [DML_BINDING_TYPE_BUFFER_ARRAY](/windows/win32/api/directml/ne-directml-dml_binding_type), then
    ///<i>Desc</i> should point to a
    ///[DML_BUFFER_ARRAY_BINDING](/windows/win32/api/directml/ns-directml-dml_buffer_array_binding).
    const(void)*     Desc;
}

///Specifies a resource binding described by a range of bytes in a Direct3D 12 buffer, represented by an offset and size
///into an ID3D12Resource.
struct DML_BUFFER_BINDING
{
    ///Type: <b>ID3D12Resource*</b> An optional pointer to an ID3D12Resource interface representing a buffer. The
    ///resource must have dimension D3D12_RESOURCE_DIMENSION_BUFFER, and the range described by this struct must lie
    ///within the bounds of the buffer. You may supply <b>nullptr</b> for this member to indicate 'no binding'.
    ID3D12Resource Buffer;
    ///Type: <b>UINT64</b> The offset, in bytes, from the start of the buffer where the range begins. This offset must
    ///be aligned to a multiple of
    ///[DML_MINIMUM_BUFFER_TENSOR_ALIGNMENT](/windows/desktop/direct3d12/direct3d-directml-constants) or the
    ///<b>GuaranteedBaseOffsetAlignment</b> supplied as part of the
    ///[DML_BUFFER_TENSOR_DESC](/windows/win32/api/directml/ns-directml-dml_buffer_tensor_desc).
    ulong          Offset;
    ///Type: <b>UINT64</b> The size of the range, in bytes.
    ulong          SizeInBytes;
}

///Specifies a resource binding that is an array of individual buffer bindings.
struct DML_BUFFER_ARRAY_BINDING
{
    ///Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The number of individual buffer ranges to bind to
    ///this slot. This field determines the size of the <i>Bindings</i> array.
    uint BindingCount;
    ///Type: <b>const [DML_BUFFER_BINDING](/windows/win32/api/directml/ns-directml-dml_buffer_binding)*</b> The
    ///individual buffer ranges to bind.
    const(DML_BUFFER_BINDING)* Bindings;
}

// Functions

///Creates a DirectML device for a given Direct3D 12 device.
///Params:
///    d3d12Device = Type: <b>ID3D12Device*</b> A pointer to an [ID3D12Device](/windows/win32/api/d3d12/nn-d3d12-id3d12device)
///                  representing the Direct3D 12 device to create the DirectML device over. DirectML supports any D3D feature level,
///                  and Direct3D 12 devices created on any adapter, including WARP. However, not all features in DirectML may be
///                  available depending on the capabilities of the Direct3D 12 device. See
///                  [IDMLDevice::CheckFeatureSupport](/windows/win32/api/directml/nf-directml-idmldevice-checkfeaturesupport) for
///                  more info. If the call to **DMLCreateDevice** is successful, then the DirectML device maintains a strong
///                  reference to the supplied Direct3D 12 device.
///    flags = Type: <b>DML_CREATE_DEVICE_FLAGS</b> A
///            [DML_CREATE_DEVICE_FLAGS](/windows/win32/api/directml/ne-directml-dml_create_device_flags) value specifying
///            additional device creation options.
///    riid = Type: <b>REFIID</b> A reference to the globally unique identifier (GUID) of the interface that you wish to be
///           returned in <i>device</i>. This is expected to be the GUID of
///           [IDMLDevice](/windows/win32/api/directml/nn-directml-idmldevice).
///    ppv = Type: \_COM\_Outptr\_opt\_ <b>void**</b> A pointer to a memory block that receives a pointer to the device. This
///          is the address of a pointer to an [IDMLDevice](/windows/win32/api/directml/nn-directml-idmldevice), representing
///          the DirectML device created.
///Returns:
///    Type: [**HRESULT**](/windows/desktop/winprog/windows-data-types) If the function succeeds, it returns
///    <b>S_OK</b>. Otherwise, it returns an [HRESULT](/windows/desktop/winprog/windows-data-types) error code. The
///    Graphics Tools Feature on Demand (FOD) must be installed in order to use the DirectML debug layers. If the
///    [DML_CREATE_DEVICE_FLAG_DEBUG](/windows/win32/api/directml/ne-directml-dml_create_device_flags) flag is specified
///    in *flags* and the debug layers are not installed, then **DMLCreateDevice** returns
///    **DXGI_ERROR_SDK_COMPONENT_MISSING**.
///    
@DllImport("DirectML")
HRESULT DMLCreateDevice(ID3D12Device d3d12Device, DML_CREATE_DEVICE_FLAGS flags, const(GUID)* riid, void** ppv);

@DllImport("DirectML")
HRESULT DMLCreateDevice1(ID3D12Device d3d12Device, DML_CREATE_DEVICE_FLAGS flags, 
                         DML_FEATURE_LEVEL minimumFeatureLevel, const(GUID)* riid, void** ppv);


// Interfaces

///An interface from which IDMLDevice and IDMLDeviceChild inherit directly (and all other interfaces, indirectly).
@GUID("C8263AAC-9E0C-4A2D-9B8E-007521A3317C")
interface IDMLObject : IUnknown
{
    ///Gets application-defined data from a DirectML device object. This method is thread-safe.
    ///Params:
    ///    guid = Type: **[REFGUID](/openspecs/windows_protocols/ms-oaut/6e7d7108-c213-40bc-8294-ac13fe68fd50)** The
    ///           <b>GUID</b> that is associated with the data.
    ///    dataSize = Type: <b>[UINT](/windows/desktop/winprog/windows-data-types)*</b> A pointer to a variable that on input
    ///               contains the size, in bytes, of the buffer that <i>data</i> points to, and on output contains the size, in
    ///               bytes, of the amount of data that <b>GetPrivateData</b> retrieved.
    ///    data = Type: <b>void*</b> A pointer to a memory block that receives the data from the device object if
    ///           <i>dataSize</i> points to a value that specifies a buffer large enough to hold the data.
    ///Returns:
    ///    Type: [**HRESULT**](/windows/desktop/winprog/windows-data-types) If this method succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an **HRESULT** error code.
    ///    
    HRESULT GetPrivateData(const(GUID)* guid, uint* dataSize, void* data);
    ///Sets application-defined data to a DirectML device object, and associates that data with an application-defined
    ///<b>GUID</b>. This method is thread-safe.
    ///Params:
    ///    guid = Type: <b>REFGUID</b> The <b>GUID</b> to associate with the data.
    ///    dataSize = Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The size in bytes of the data.
    ///    data = Type: <b>const void*</b> A pointer to a memory block that contains the data to be stored with this DirectML
    ///           device object. If <i>data</i> is <b>NULL</b>, then <i>dataSize</i> must be 0, and any data that was
    ///           previously associated with the <b>GUID</b> specified in <i>guid</i> will be destroyed.
    ///Returns:
    ///    Type: [**HRESULT**](/windows/desktop/winprog/windows-data-types) If this method succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an **HRESULT** error code.
    ///    
    HRESULT SetPrivateData(const(GUID)* guid, uint dataSize, const(void)* data);
    ///Associates an IUnknown-derived interface with the DirectML device object, and associates that interface with an
    ///application-defined <b>GUID</b>. This method is thread-safe.
    ///Params:
    ///    guid = Type: <b>REFGUID</b> The <b>GUID</b> to associate with the interface.
    ///    data = Type: <b>const IUnknown*</b> A pointer to the IUnknown-derived interface to be associated with the device
    ///           object.
    ///Returns:
    ///    Type: [**HRESULT**](/windows/desktop/winprog/windows-data-types) If this method succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an **HRESULT** error code.
    ///    
    HRESULT SetPrivateDataInterface(const(GUID)* guid, IUnknown data);
    ///Associates a name with the DirectML device object. This name is for use in debug diagnostics and tools. This
    ///method is thread-safe.
    ///Params:
    ///    name = Type: <b>PCWSTR</b> A <b>NULL</b>-terminated <b>UNICODE</b> string that contains the name to associate with
    ///           the DirectML device object.
    ///Returns:
    ///    Type: [**HRESULT**](/windows/desktop/winprog/windows-data-types) If this method succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an **HRESULT** error code.
    ///    
    HRESULT SetName(const(PWSTR) name);
}

///Represents a DirectML device, which is used to create operators, binding tables, command recorders, and other
///objects. The **IDMLDevice** interface inherits from [IDMLObject](/windows/win32/api/directml/nn-directml-idmlobject).
///A DirectML device is always associated with exactly one underlying Direct3D 12 device. All objects created by the
///DirectML device maintain a strong reference to their parent device. Unlike the Direct3D 12 device, the DML device is
///not a singleton. Therefore, it's possible to create multiple DirectML devices over the same Direct3D 12 device.
///However, this isn't recommended as the DirectML device has no mutable state, so there's little advantage to creating
///multiple DML devices over the same Direct3D 12 device. This object is thread-safe.
@GUID("6DBD6437-96FD-423F-A98C-AE5E7C2A573F")
interface IDMLDevice : IDMLObject
{
    ///Gets information about the optional features and capabilities that are supported by the DirectML device.
    ///Params:
    ///    feature = Type: [**DML_FEATURE**](/windows/win32/api/directml/ne-directml-dml_feature) A constant from the
    ///              [DML_FEATURE](/windows/win32/api/directml/ne-directml-dml_feature) enumeration describing the feature(s) that
    ///              you want to query for support.
    ///    featureQueryDataSize = Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The size of the structure pointed to by the
    ///                           <i>featureQueryData</i> parameter, if provided, otherwise 0.
    ///    featureQueryData = Type: <b>const void*</b> An optional pointer to a query structure that corresponds to the value of the
    ///                       <i>feature</i> parameter. To determine the corresponding query type for each constant, see
    ///                       [DML_FEATURE](/windows/win32/api/directml/ne-directml-dml_feature).
    ///    featureSupportDataSize = Type: [**UINT**](/windows/desktop/winprog/windows-data-types) The size of the structure pointed to by the
    ///                             <i>featureSupportData</i> parameter.
    ///    featureSupportData = Type: <b>void*</b> A pointer to a support data structure that corresponds to the value of the <i>feature</i>
    ///                         parameter. To determine the corresponding support data type for each constant, see
    ///                         [DML_FEATURE](/windows/win32/api/directml/ne-directml-dml_feature).
    ///Returns:
    ///    Type: [**HRESULT**](/windows/desktop/winprog/windows-data-types) If this method succeeds, it returns
    ///    **S_OK**. Otherwise, it returns **DXGI_ERROR_UNSUPPORTED** if the
    ///    [DML_FEATURE](/windows/win32/api/directml/ne-directml-dml_feature) is unrecognized or unsupported, and
    ///    **E_INVALIDARG** if the parameters are incorrect.
    ///    
    HRESULT CheckFeatureSupport(DML_FEATURE feature, uint featureQueryDataSize, const(void)* featureQueryData, 
                                uint featureSupportDataSize, void* featureSupportData);
    ///Creates a DirectML operator. In DirectML, an operator represents an abstract bundle of functionality, which can
    ///be compiled into a form suitable for execution on the GPU. Operator objects cannot be executed directly; they
    ///must first be compiled into an
    ///[IDMLCompiledOperator](/windows/win32/api/directml/nn-directml-idmlcompiledoperator).
    ///Params:
    ///    desc = Type: **const [DML_OPERATOR_DESC](/windows/win32/api/directml/ns-directml-dml_operator_desc)\*** The
    ///           description of the operator to be created.
    ///    riid = Type: <b>REFIID</b> A reference to the globally unique identifier (GUID) of the interface that you wish to be
    ///           returned in <i>ppv</i>. This is expected to be the GUID of
    ///           [IDMLOperator](/windows/win32/api/directml/nn-directml-idmloperator).
    ///    ppv = Type: <b>void**</b> A pointer to a memory block that receives a pointer to the operator. This is the address
    ///          of a pointer to an [IDMLOperator](/windows/win32/api/directml/nn-directml-idmloperator), representing the
    ///          operator created.
    ///Returns:
    ///    Type: [**HRESULT**](/windows/desktop/winprog/windows-data-types) If this method succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an **HRESULT** error code.
    ///    
    HRESULT CreateOperator(const(DML_OPERATOR_DESC)* desc, const(GUID)* riid, void** ppv);
    ///Compiles an operator into an object that can be dispatched to the GPU. A compiled operator represents the
    ///efficient, baked form of an operator suitable for execution on the GPU. A compiled operator holds state (such as
    ///shaders and other objects) required for execution. Because a compiled operator implements the
    ///[IDMLPageable](/windows/win32/api/directml/nn-directml-idmlpageable) interface, you're able to evict one from GPU
    ///memory if you wish. See [IDMLDevice::Evict](/windows/win32/api/directml/nf-directml-idmldevice-evict) and
    ///[IDMLDevice::MakeResident](/windows/win32/api/directml/nf-directml-idmldevice-makeresident) for more info. The
    ///compiled operator maintains a strong reference to the supplied
    ///[IDMLOperator](/windows/win32/api/directml/nn-directml-idmloperator) pointer.
    ///Params:
    ///    op = Type: <b>[IDMLOperator](/windows/win32/api/directml/nn-directml-idmloperator)*</b> The operator (created with
    ///         [IDMLDevice::CreateOperator](/windows/win32/api/directml/nf-directml-idmldevice-createoperator)) to compile.
    ///    flags = Type: [**DML_EXECUTION_FLAGS**](/windows/win32/api/directml/ne-directml-dml_execution_flags) Any flags to
    ///            control the execution of this operator.
    ///    riid = Type: <b>REFIID</b> A reference to the globally unique identifier (GUID) of the interface that you wish to be
    ///           returned in <i>ppv</i>. This is expected to be the GUID of
    ///           [IDMLCompiledOperator](/windows/win32/api/directml/nn-directml-idmlcompiledoperator).
    ///    ppv = Type: <b>void**</b> A pointer to a memory block that receives a pointer to the compiled operator. This is the
    ///          address of a pointer to an
    ///          [IDMLCompiledOperator](/windows/win32/api/directml/nn-directml-idmlcompiledoperator), representing the
    ///          compiled operator created.
    ///Returns:
    ///    Type: [**HRESULT**](/windows/desktop/winprog/windows-data-types) If this method succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an **HRESULT** error code.
    ///    
    HRESULT CompileOperator(IDMLOperator op, DML_EXECUTION_FLAGS flags, const(GUID)* riid, void** ppv);
    ///Creates an object that can be used to initialize compiled operators. Once compiled, an operator must be
    ///initialized exactly once on the GPU before it can be executed. The operator initializer holds the state necessary
    ///for initialization of one or more target compiled operators. Once instantiated, dispatch of the operator
    ///initializer can be recorded in a command list via
    ///[IDMLCommandRecorder::RecordDispatch](/windows/win32/api/directml/nf-directml-idmlcommandrecorder-recorddispatch).
    ///After execution completes on the GPU, all compiled operators that are targets of the initializer enter the
    ///initialized state. An operator initializer can be reused to initialize different sets of compiled operators. See
    ///[IDMLOperatorInitializer::Reset](/windows/win32/api/directml/nf-directml-idmloperatorinitializer-reset) for more
    ///info. An operator initializer can be created with no target operators. Executing such an initializer is a no-op.
    ///Creating an operator initializer with no target operators may be useful if you wish to create an initializer
    ///up-front, but don't yet know which operators it will be used to initialize.
    ///[IDMLOperatorInitializer::Reset](/windows/win32/api/directml/nf-directml-idmloperatorinitializer-reset) can be
    ///used to reset which operators to target.
    ///Params:
    ///    operatorCount = Type: [**UINT**](/windows/desktop/winprog/windows-data-types) This parameter determines the number of
    ///                    elements in the array passed in the <i>operators</i> parameter.
    ///    operators = Type: <b>[IDMLCompiledOperator](/windows/win32/api/directml/nn-directml-idmlcompiledoperator)*</b> An
    ///                optional pointer to a constant array of
    ///                [IDMLCompiledOperator](/windows/win32/api/directml/nn-directml-idmlcompiledoperator) pointers containing the
    ///                set of operators that this initializer will target. Upon execution of the initializer, the target operators
    ///                become initialized. This array may be null or empty, indicating that the initializer has no target operators.
    ///    riid = Type: <b>REFIID</b> A reference to the globally unique identifier (GUID) of the interface that you wish to be
    ///           returned in <i>ppv</i>. This is expected to be the GUID of
    ///           [IDMLOperatorInitializer](/windows/win32/api/directml/nn-directml-idmloperatorinitializer).
    ///    ppv = Type: <b>void**</b> A pointer to a memory block that receives a pointer to the operator initializer. This is
    ///          the address of a pointer to an
    ///          [IDMLOperatorInitializer](/windows/win32/api/directml/nn-directml-idmloperatorinitializer), representing the
    ///          operator initializer created.
    ///Returns:
    ///    Type: [**HRESULT**](/windows/desktop/winprog/windows-data-types) If this method succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an **HRESULT** error code.
    ///    
    HRESULT CreateOperatorInitializer(uint operatorCount, IDMLCompiledOperator* operators, const(GUID)* riid, 
                                      void** ppv);
    ///Creates a DirectML command recorder. A command recorder allows your application to record the initialization and
    ///execution of compiled operators into existing Direct3D 12 command lists. The command recorder is a stateless
    ///object: it does not own command lists or operators, nor does it execute any GPU work. Instead, it merely records
    ///the commands necessary for dispatching initialization or execution into an application-supplied command list.
    ///Your application is then responsible for submitting the execution of that command list to the Direct3D 12 command
    ///queue.
    ///Params:
    ///    riid = Type: <b>REFIID</b> A reference to the globally unique identifier (GUID) of the interface that you wish to be
    ///           returned in <i>ppv</i>. This is expected to be the GUID of
    ///           [IDMLCommandRecorder](/windows/win32/api/directml/nn-directml-idmlcommandrecorder).
    ///    ppv = Type: <b>void**</b> A pointer to a memory block that receives a pointer to the command recorder. This is the
    ///          address of a pointer to an
    ///          [IDMLCommandRecorder](/windows/win32/api/directml/nn-directml-idmlcommandrecorder), representing the command
    ///          recorder created.
    ///Returns:
    ///    Type: [**HRESULT**](/windows/desktop/winprog/windows-data-types) If this method succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an **HRESULT** error code.
    ///    
    HRESULT CreateCommandRecorder(const(GUID)* riid, void** ppv);
    ///Creates a binding table, which is an object that can be used to bind resources (such as tensors) to the pipeline.
    ///The binding table wraps a range of an application-managed descriptor heap using the provided descriptor handles
    ///and count. Binding tables are used by DirectML to manage the binding of resources by writing descriptors into the
    ///descriptor heap at the offset specified by the <b>CPUDescriptorHandle</b>, and binding those descriptors to the
    ///pipeline using the descriptors at the offset specified by the <b>GPUDescriptorHandle</b>. The order in which
    ///DirectML writes descriptors into the heap is unspecified, so your application must take care not to overwrite the
    ///descriptors wrapped by the binding table. The supplied CPU and GPU descriptor handles may come from different
    ///heaps, however it is then your application's responsibility to ensure that the entire descriptor range referred
    ///to by the CPU descriptor handle is copied into the range referred to by the GPU descriptor handle prior to
    ///execution using this binding table. The descriptor heap from which the handles are supplied must have type
    ///D3D12_DESCRIPTOR_HEAP_TYPE_CBV_SRV_UAV. Additionally, the heap referred to by the <b>GPUDescriptorHandle</b> must
    ///be a shader-visible descriptor heap. You must not delete the heap referred to by the GPU descriptor handle until
    ///all work referencing it has completed execution on the GPU. You may, however, reset or release the binding table
    ///itself as soon as the dispatch has been recorded into the command list. Similar to the relationship between
    ///ID3D12CommandList and ID3D12CommandAllocator, the
    ///[IDMLBindingTable](/windows/win32/api/directml/nn-directml-idmlbindingtable) doesn't own the underlying memory
    ///referenced by the descriptor handles. Rather, the ID3D12DescriptorHeap does. Therefore, you're permitted to reset
    ///or release a DirectML binding table before work using the binding table has completed execution on the GPU.
    ///Params:
    ///    desc = Type: <b>const [DML_BINDING_TABLE_DESC](/windows/win32/api/directml/ns-directml-dml_binding_table_desc)*</b>
    ///           An optional pointer to a
    ///           [DML_BINDING_TABLE_DESC](/windows/win32/api/directml/ns-directml-dml_binding_table_desc) containing the
    ///           binding table parameters. This may be <b>nullptr</b>, indicating an empty binding table.
    ///    riid = Type: <b>REFIID</b> A reference to the globally unique identifier (GUID) of the interface that you wish to be
    ///           returned in <i>ppv</i>. This is expected to be the GUID of
    ///           [IDMLBindingTable](/windows/win32/api/directml/nn-directml-idmlbindingtable).
    ///    ppv = Type: <b>void**</b> A pointer to a memory block that receives a pointer to the binding table. This is the
    ///          address of a pointer to an [IDMLBindingTable](/windows/win32/api/directml/nn-directml-idmlbindingtable),
    ///          representing the binding table created.
    ///Returns:
    ///    Type: [**HRESULT**](/windows/desktop/winprog/windows-data-types) If this method succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an **HRESULT** error code.
    ///    
    HRESULT CreateBindingTable(const(DML_BINDING_TABLE_DESC)* desc, const(GUID)* riid, void** ppv);
    ///Evicts one or more pageable objects from GPU memory. Also see
    ///[IDMLDevice::MakeResident](/windows/win32/api/directml/nf-directml-idmldevice-makeresident).
    ///Params:
    ///    count = Type: [**UINT**](/windows/desktop/winprog/windows-data-types) This parameter determines the number of
    ///            elements in the array passed in the <i>ppObjects</i> parameter.
    ///    ppObjects = Type: <b>[IDMLPageable](/windows/win32/api/directml/nn-directml-idmlpageable)*</b> A pointer to a constant
    ///                array of [IDMLPageable](/windows/win32/api/directml/nn-directml-idmlpageable) pointers containing the
    ///                pageable objects to evict from GPU memory.
    ///Returns:
    ///    Type: [**HRESULT**](/windows/desktop/winprog/windows-data-types) If this method succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an **HRESULT** error code.
    ///    
    HRESULT Evict(uint count, IDMLPageable* ppObjects);
    ///Causes one or more pageable objects to become resident in GPU memory. Also see
    ///[IDMLDevice::Evict](/windows/win32/api/directml/nf-directml-idmldevice-evict).
    ///Params:
    ///    count = Type: <b>UINT</b> This parameter determines the number of elements in the array passed in the
    ///            <i>ppObjects</i> parameter.
    ///    ppObjects = Type: <b>[IDMLPageable](/windows/win32/api/directml/nn-directml-idmlpageable)*</b> A pointer to a constant
    ///                array of [IDMLPageable](/windows/win32/api/directml/nn-directml-idmlpageable) pointers containing the
    ///                pageable objects to make resident in GPU memory.
    ///Returns:
    ///    Type: [**HRESULT**](/windows/desktop/winprog/windows-data-types) If this method succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an **HRESULT** error code.
    ///    
    HRESULT MakeResident(uint count, IDMLPageable* ppObjects);
    ///Retrieves the reason that the DirectML device was removed.
    ///Returns:
    ///    Type: [**HRESULT**](/windows/desktop/winprog/windows-data-types) An
    ///    [HRESULT](/windows/desktop/winprog/windows-data-types) containing the reason that the device was removed, or
    ///    **S_OK** if the device has not been removed.
    ///    
    HRESULT GetDeviceRemovedReason();
    ///Retrieves the Direct3D 12 device that was used to create this DirectML device.
    ///Params:
    ///    riid = Type: <b>REFIID</b> A reference to the globally unique identifier (GUID) of the interface that you wish to be
    ///           returned in <i>ppv</i>. This is expected to be the GUID of ID3D12Device.
    ///    ppv = Type: <b>void**</b> A pointer to a memory block that receives a pointer to the device. This is the address of
    ///          a pointer to an ID3D12Device, representing the device.
    ///Returns:
    ///    Type: [**HRESULT**](/windows/desktop/winprog/windows-data-types) If this method succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an **HRESULT** error code.
    ///    
    HRESULT GetParentDevice(const(GUID)* riid, void** ppv);
}

///An interface implemented by all objects created from the DirectML device. The **IDMLDeviceChild** interface inherits
///from [IDMLObject](/windows/win32/api/directml/nn-directml-idmlobject).
@GUID("27E83142-8165-49E3-974E-2FD66E4CB69D")
interface IDMLDeviceChild : IDMLObject
{
    ///Retrieves the DirectML device that was used to create this object.
    ///Params:
    ///    riid = Type: <b>REFIID</b> A reference to the globally unique identifier (GUID) of the interface that you wish to be
    ///           returned in <i>ppv</i>. This is expected to be the GUID of
    ///           [IDMLDevice](/windows/win32/api/directml/nn-directml-idmldevice).
    ///    ppv = Type: <b>void**</b> A pointer to a memory block that receives a pointer to the DirectML device. This is the
    ///          address of a pointer to an [IDMLDevice](/windows/win32/api/directml/nn-directml-idmldevice), representing the
    ///          DirectML device.
    ///Returns:
    ///    Type: [**HRESULT**](/windows/desktop/winprog/windows-data-types) If this method succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an **HRESULT** error code.
    ///    
    HRESULT GetDevice(const(GUID)* riid, void** ppv);
}

///Implemented by objects that can be evicted from GPU memory, and hence that can be supplied to
///[IDMLDevice::Evict](/windows/win32/api/directml/nf-directml-idmldevice-evict) and
///[IDMLDevice::MakeResident](/windows/win32/api/directml/nf-directml-idmldevice-makeresident). The **IDMLOperator**
///interface inherits from [IDMLDeviceChild](/windows/win32/api/directml/nn-directml-idmldevicechild).
@GUID("B1AB0825-4542-4A4B-8617-6DDE6E8F6201")
interface IDMLPageable : IDMLDeviceChild
{
}

///Represents a DirectML operator. The **IDMLOperator** interface inherits from
///[IDMLDeviceChild](/windows/win32/api/directml/nn-directml-idmldevicechild).
@GUID("26CAAE7A-3081-4633-9581-226FBE57695D")
interface IDMLOperator : IDMLDeviceChild
{
}

///Implemented by objects that can be recorded into a command list for dispatch on the GPU, using
///[IDMLCommandRecorder::RecordDispatch](/windows/win32/api/directml/nf-directml-idmlcommandrecorder-recorddispatch).
///The **IDMLDispatchable** interface inherits from
///[IDMLPageable](/windows/win32/api/directml/nn-directml-idmlpageable). This interface is implemented by
///[IDMLCompiledOperator](/windows/win32/api/directml/nn-directml-idmlcompiledoperator) and
///[IDMLOperatorInitializer](/windows/win32/api/directml/nn-directml-idmloperatorinitializer).
@GUID("DCB821A8-1039-441E-9F1C-B1759C2F3CEC")
interface IDMLDispatchable : IDMLPageable
{
    ///Retrieves the binding properties for a dispatchable object (an operator initializer, or a compiled operator). The
    ///binding properties value contains the required size of the binding table in descriptors, as well as the required
    ///size in bytes of the temporary and persistent resources required to execute this object. When called on an
    ///operator initializer, the binding properties of the object may be different if retrieved both before and after a
    ///call to [IDMLOperatorInitializer::Reset](/windows/win32/api/directml/nf-directml-idmloperatorinitializer-reset).
    ///Returns:
    ///    Type: [**DML_BINDING_PROPERTIES**](/windows/win32/api/directml/ns-directml-dml_binding_properties) A
    ///    [DML_BINDING_PROPERTIES](/windows/win32/api/directml/ns-directml-dml_binding_properties) value containing
    ///    binding properties.
    ///    
    DML_BINDING_PROPERTIES GetBindingProperties();
}

///Represents a compiled, efficient form of an operator suitable for execution on the GPU. To create this object, call
///[IDMLDevice::CompileOperator](/windows/win32/api/directml/nf-directml-idmldevice-compileoperator). The
///**IDMLCompiledOperator** interface inherits from
///[IDMLDispatchable](/windows/win32/api/directml/nn-directml-idmldispatchable). Unlike
///[IDMLOperator](/windows/win32/api/directml/nn-directml-idmloperator), compiled operators are "baked", and can be
///executed directly by the GPU. After an operator is compiled, you must initialize it exactly once before it can be
///executed. It's an error to initialize an operator more than once. Operator initializers are used to initialize
///compiled operators. You can use
///[IDMLCommandRecorder::RecordDispatch](/windows/win32/api/directml/nf-directml-idmlcommandrecorder-recorddispatch) to
///record the dispatch of an operator initializer which, when executed on the GPU, will initialize one or more
///operators. In addition to input and output tensors, operators may require additional memory for execution. This
///additional memory must be provided by your application in the form of temporary and persistent resources. A temporary
///resource is scratch memory that is only used during the execution of the operator, and doesn't need to persist after
///the call to
///[IDMLCommandRecorder::RecordDispatch](/windows/win32/api/directml/nf-directml-idmlcommandrecorder-recorddispatch)
///completes on the GPU. This means that your application may release or overwrite the temporary resource in between
///dispatches of the compiled operator. In contrast, the persistent resource must live at least until the last execute
///of the operator has completed on the GPU. Additionally, the contents of the persistent resource are opaque and must
///be preserved between executions of the operator. The size of the temporary and persistent resources varies per
///operator. Call
///[IDMLDispatchable::GetBindingProperties](/windows/win32/api/directml/nf-directml-idmldispatchable-getbindingproperties)
///to query the required size, in bytes, of the persistent and temporary resources for this compiled operator. See
///IDMLBindingTable::BindTemporaryResource and IDMLBindingTable::BindPersistentResource for more information on binding
///temporary and persistent resources. All methods on this interface are thread-safe.
@GUID("6B15E56A-BF5C-4902-92D8-DA3A650AFEA4")
interface IDMLCompiledOperator : IDMLDispatchable
{
}

///Represents a specialized object whose purpose is to initialize compiled operators. To create an instance of this
///object, call
///[IDMLDevice::CreateOperatorInitializer](/windows/win32/api/directml/nf-directml-idmldevice-createoperatorinitializer).
///The **IDMLOperatorInitializer** interface inherits from
///[IDMLDispatchable](/windows/win32/api/directml/nn-directml-idmldispatchable). An operator initializer is associated
///with one or more compiled operators, which are the targets for initialization. You can record operator initialization
///onto a command list using
///[IDMLCommandRecorder::RecordDispatch](/windows/win32/api/directml/nf-directml-idmlcommandrecorder-recorddispatch).
///When the initialization completes execution on the GPU, all of the target operators enter the initialized state. You
///must initialize all operators exactly once before they can be executed.
@GUID("427C1113-435C-469C-8676-4D5DD072F813")
interface IDMLOperatorInitializer : IDMLDispatchable
{
    ///Resets the initializer to handle initialization of a new set of operators. You may use an initializer only to
    ///initialize a fixed set of operators, which are provided either during creation
    ///([IDMLDevice::CreateOperatorInitializer](/windows/win32/api/directml/nf-directml-idmldevice-createoperatorinitializer)),
    ///or when the initializer is reset. Resetting the initializer allows your application to reuse an existing
    ///initializer object to initialize a new set of operators. You must not call <b>Reset</b> until all outstanding
    ///work using the initializer has completed execution on the GPU. This method is not thread-safe.
    ///Params:
    ///    operatorCount = Type: <b>UINT</b> This parameter determines the number of elements in the array passed in the
    ///                    <i>operators</i> parameter.
    ///    operators = Type: <b>[IDMLCompiledOperator](/windows/win32/api/directml/nn-directml-idmlcompiledoperator)*</b> An
    ///                optional pointer to a constant array of
    ///                [IDMLCompiledOperator](/windows/win32/api/directml/nn-directml-idmlcompiledoperator) pointers containing the
    ///                operators that the initializer should initialize.
    ///Returns:
    ///    Type: [**HRESULT**](/windows/desktop/winprog/windows-data-types) If this method succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an **HRESULT** error code.
    ///    
    HRESULT Reset(uint operatorCount, IDMLCompiledOperator* operators);
}

///Wraps a range of an application-managed descriptor heap, and is used by DirectML to create bindings for resources. To
///create this object, call
///[IDMLDevice::CreateBindingTable](/windows/win32/api/directml/nf-directml-idmldevice-createbindingtable). The
///**IDMLBindingTable** interface inherits from
///[IDMLDeviceChild](/windows/win32/api/directml/nn-directml-idmldevicechild). The binding table is created over a range
///of CPU and GPU descriptor handles. When an IDMLBindingTable::Bind* method is called, DirectML writes one or more
///descriptors into the range of CPU descriptors. When you use the binding table during a call to
///[IDMLCommandRecorder::RecordDispatch](/windows/win32/api/directml/nf-directml-idmlcommandrecorder-recorddispatch),
///DirectML binds the corresponding GPU descriptors to the pipeline. The CPU and GPU descriptor handles aren't required
///to point to the same entries in a descriptor heap, however it is then your application's responsibility to ensure
///that the entire descriptor range referred to by the CPU descriptor handle is copied into the range referred to by the
///GPU descriptor handle prior to execution using this binding table. It is your application's responsibility to perform
///correct synchronization between the CPU and GPU work that uses this binding table. For example, you must take care
///not to overwrite the bindings created by the binding table (for example, by calling Bind* again on the binding table,
///or by overwriting the descriptor heap manually) until all work using the binding table has completed execution on the
///GPU. In addition, since the binding table doesn't maintain a reference on the descriptor heap it writes into, you
///must not release the backing shader-visible descriptor heap until all work using that binding table has completed
///execution on the GPU. The binding table is associated with exactly one dispatchable object (an operator initializer,
///or a compiled operator), and represents the bindings for that particular object. You can reuse a binding table by
///calling [IDMLBindingTable::Reset](/windows/win32/api/directml/nf-directml-idmlbindingtable-reset), however. Note that
///since the binding table doesn't own the descriptor heap itself, it is safe to call <b>Reset</b> and reuse the binding
///table for a different dispatchable object even before any outstanding executions have completed on the GPU. The
///binding table doesn't keep strong references on any resources bound using it—your application must ensure that
///resources are not deleted while still in use by the GPU. This object is not thread safe—your application must not
///call methods on the binding table simultaneously from different threads without synchronization.
@GUID("29C687DC-DE74-4E3B-AB00-1168F2FC3CFC")
interface IDMLBindingTable : IDMLDeviceChild
{
    ///Binds a set of resources as input tensors. If binding for a compiled operator, the number of bindings must
    ///exactly match the number of inputs of the operator, including optional tensors. This can be determined from the
    ///operator description used to create the operator. If too many or too few bindings are provided, device removal
    ///will occur. For optional tensors, you may use
    ///[DML_BINDING_TYPE_NONE](/windows/win32/api/directml/ne-directml-dml_binding_type) to specify 'no binding'.
    ///Otherwise, the binding type must match the tensor type when the operator was created. For operator initializers,
    ///input bindings are expected to be of type
    ///[DML_BINDING_TYPE_BUFFER_ARRAY](/windows/win32/api/directml/ne-directml-dml_binding_type) with one input binding
    ///per operator to initialize, supplied in the order that you specified the operators during creation or reset of
    ///the initializer. Each buffer array should have a size equal to the number of inputs of its corresponding operator
    ///to initialize. Input tensors that had the
    ///[DML_TENSOR_FLAG_OWNED_BY_DML](/windows/win32/api/directml/ne-directml-dml_tensor_flags) flag set should be bound
    ///during initialize&mdash;otherwise, nothing should be bound for that tensor. If there is nothing to be bound as
    ///input for initialization of an operator (that is, there are no tensors with the
    ///[DML_TENSOR_FLAG_OWNED_BY_DML](/windows/win32/api/directml/ne-directml-dml_tensor_flags) flag set) then you may
    ///supply `nullptr` or an empty
    ///[DML_BUFFER_ARRAY_BINDING](/windows/win32/api/directml/ns-directml-dml_buffer_array_binding) to indicate 'no
    ///binding'. To unbind all input resources, supply a *rangeCount* of 0, and a value of `nullptr` for *bindings*. If
    ///an input tensor has the [DML_TENSOR_FLAG_OWNED_BY_DML](/windows/win32/api/directml/ne-directml-dml_tensor_flags)
    ///flag set, it may only be bound when executing an operator initializer. Otherwise, if the
    ///[DML_TENSOR_FLAG_OWNED_BY_DML](/windows/win32/api/directml/ne-directml-dml_tensor_flags) flag is not set, the
    ///opposite is true&mdash;the input tensor must not be bound when executing the initializer, but must be bound when
    ///executing the operator itself. All buffers being bound as input must have heap type
    ///[D3D12_HEAP_TYPE_DEFAULT](/windows/win32/api/d3d12/ne-d3d12-d3d12_heap_type), except when the
    ///[DML_TENSOR_FLAG_OWNED_BY_DML](/windows/win32/api/directml/ne-directml-dml_tensor_flags) flag is set. If the
    ///[DML_TENSOR_FLAG_OWNED_BY_DML](/windows/win32/api/directml/ne-directml-dml_tensor_flags) is set for a tensor that
    ///is being bound as input for an initializer, the buffer's heap type may be either
    ///[D3D12_HEAP_TYPE_DEFAULT](/windows/win32/api/d3d12/ne-d3d12-d3d12_heap_type) or
    ///[D3D12_HEAP_TYPE_UPLOAD](/windows/win32/api/d3d12/ne-d3d12-d3d12_heap_type). Each binding is not required to
    ///point to a unique resource. It is legal, for example, to supply all inputs as suballocations from the same
    ///Direct3D 12 buffer resource. Ranges for inputs are permitted to overlap. No Direct3D 12 resource bound for input
    ///may simultaneously be bound for output, except if the operator explicitly permits in-place execution. If using
    ///in-place execution, the input and output tensors must have the exact same sizes, strides, and total tensor size.
    ///Additionally, the input and output bindings must have the exact same offset size.
    ///Params:
    ///    bindingCount = Type: [**UINT**](/windows/desktop/winprog/windows-data-types) This parameter determines the size of the
    ///                   *bindings* array (if provided).
    ///    bindings = Type: **const [DML_BINDING_DESC](/windows/win32/api/directml/ns-directml-dml_binding_desc)\*** An optional
    ///               pointer to a constant array of [DML_BINDING_DESC](/windows/win32/api/directml/ns-directml-dml_binding_desc)
    ///               containing descriptions of the tensor resources to bind.
    void    BindInputs(uint bindingCount, const(DML_BINDING_DESC)* bindings);
    ///Binds a set of resources as output tensors. If binding for a compiled operator, the number of bindings must
    ///exactly match the number of inputs of the operator, including optional tensors. This can be determined from the
    ///operator description used to create the operator. If too many or too few bindings are provided, device removal
    ///will occur. For optional tensors, you may use
    ///DML_BINDING_TYPE_NONE](/windows/win32/api/directml/ne-directml-dml_binding_type) to specify 'no binding'.
    ///Otherwise, the binding type must match the tensor type when the operator was created. For operator initializers,
    ///the output bindings are the persistent resources of each operator, supplied in the order the operators were given
    ///when creating or resetting the initializer. If a particular operator does not require a persistent resource, you
    ///should prove an empty binding in that slot. To unbind all input resources, supply a <i>rangeCount</i> of 0, and a
    ///value of <b>nullptr</b> for <i>bindings</i>. The writeable areas of two output tensors must not overlap with one
    ///another. The 'writeable area' of an output buffer being bound is defined as being the start offset of the buffer
    ///range, up to the <i>TotalTensorSizeInBytes</i> as specified in the tensors description. All buffers being bound
    ///as output must have heap type D3D12_HEAP_TYPE_DEFAULT.
    ///Params:
    ///    bindingCount = Type: [**UINT**](/windows/desktop/winprog/windows-data-types) This parameter determines the size of the
    ///                   <i>bindings</i> array (if provided).
    ///    bindings = Type: <b>const [DML_BINDING_DESC](/windows/win32/api/directml/ns-directml-dml_binding_desc)*</b> An optional
    ///               pointer to a constant array of [DML_BINDING_DESC](/windows/win32/api/directml/ns-directml-dml_binding_desc)
    ///               containing descriptions of the tensor resources to bind.
    void    BindOutputs(uint bindingCount, const(DML_BINDING_DESC)* bindings);
    ///Binds a buffer to use as temporary scratch memory. You can determine the required size of this buffer range by
    ///calling
    ///[IDMLDispatchable::GetBindingProperties](/windows/win32/api/directml/nf-directml-idmldispatchable-getbindingproperties).
    ///If the binding properties for the [IDMLDispatchable](/windows/win32/api/directml/nn-directml-idmldispatchable)
    ///specify a size of zero for the temporary resource, then you may supply <b>nullptr</b> to this method (which
    ///indicates no resource to bind). Otherwise, a binding of type
    ///[DML_BINDING_TYPE_BUFFER](/windows/win32/api/directml/ne-directml-dml_binding_type) must be supplied that is at
    ///least as large as the required <b>TemporaryResourceSize</b> returned by
    ///[IDMLDispatchable::GetBindingProperties](/windows/win32/api/directml/nf-directml-idmldispatchable-getbindingproperties).
    ///The temporary resource is typically used as scratch memory during execution of an operator. The contents of a
    ///temporary resource need not be defined prior to execution. For example, DirectML doesn't require that you zero
    ///the contents of the temporary resource prior to binding or executing an operator. You don't need to preserve the
    ///contents of the temporary buffer, and your application is free to overwrite or reuse its contents as soon as
    ///execution of an operator or initializer completes on the GPU. This is in contrast to a persistent resource, whose
    ///contents must be preserved and lifetime extended for the lifetime of the operator. The supplied buffer range to
    ///be bound as the temporary buffer must have its start offset aligned to
    ///[DML_TEMPORARY_BUFFER_ALIGNMENT](/windows/desktop/direct3d12/direct3d-directml-constants). The type of the heap
    ///underlying the buffer must be D3D12_HEAP_TYPE_DEFAULT.
    ///Params:
    ///    binding = Type: <b>const [DML_BINDING_DESC](/windows/win32/api/directml/ns-directml-dml_binding_desc)*</b> An optional
    ///              pointer to a [DML_BINDING_DESC](/windows/win32/api/directml/ns-directml-dml_binding_desc) containing the
    ///              description of a tensor resource to bind.
    void    BindTemporaryResource(const(DML_BINDING_DESC)* binding);
    ///Binds a buffer as a persistent resource. You can determine the required size of this buffer range by calling
    ///[IDMLDispatchable::GetBindingProperties](/windows/win32/api/directml/nf-directml-idmldispatchable-getbindingproperties).
    ///If the binding properties for the operator specify a size of zero for the persistent resource, then you may
    ///supply <b>nullptr</b> to this method (which indicates no resource to bind). Otherwise, a binding of type
    ///[DML_BINDING_TYPE_BUFFER](/windows/win32/api/directml/ne-directml-dml_binding_type) must be supplied that is at
    ///least as large as the required <b>PersistentResourceSize</b> returned by
    ///[IDMLDispatchable::GetBindingProperties](/windows/win32/api/directml/nf-directml-idmldispatchable-getbindingproperties).
    ///Unlike the temporary resource, the persistent resource's contents and lifetime must persist as long as the
    ///compiled operator does. That is, if an operator requires a persistent resource, then your application must supply
    ///it during initialization and subsequently also supply it to all future executes of the operator without modifying
    ///its contents. The persistent resource is typically used by DirectML to store lookup tables or other long-lived
    ///data that is computed during initialization of an operator and reused on future executions of that operator. As
    ///the persistent resource's data is opaque, once initialized it cannot be copied or moved to another buffer. The
    ///persistent resource is only written to during initialization of an operator and is thereafter immutable; all
    ///subsequent executions are guaranteed not to write to the persistent resource. The supplied buffer range to be
    ///bound as the persistent buffer must have its start offset aligned to
    ///[DML_PERSISTENT_BUFFER_ALIGNMENT](/windows/desktop/direct3d12/direct3d-directml-constants). The type of the heap
    ///underlying the buffer must be D3D12_HEAP_TYPE_DEFAULT.
    ///Params:
    ///    binding = Type: <b>const [DML_BINDING_DESC](/windows/win32/api/directml/ns-directml-dml_binding_desc)*</b> An optional
    ///              pointer to a [DML_BINDING_DESC](/windows/win32/api/directml/ns-directml-dml_binding_desc) containing the
    ///              description of a tensor resource to bind.
    void    BindPersistentResource(const(DML_BINDING_DESC)* binding);
    ///Resets the binding table to wrap a new range of descriptors, potentially for a different operator or initializer.
    ///This allows dynamic reuse of the binding table. Resetting a binding table doesn't modify any previous bindings
    ///created by the table. Because of this, it is safe to reset the binding table immediately after supplying it to
    ///[IDMLCommandRecorder::RecordDispatch](/windows/win32/api/directml/nf-directml-idmlcommandrecorder-recorddispatch),
    ///even if that work has not yet completed execution on the GPU, so long as the underlying descriptors remain valid.
    ///See [IDMLDevice::CreateBindingTable](/windows/win32/api/directml/nf-directml-idmldevice-createbindingtable) for
    ///more information on the parameters supplied to this method.
    ///Params:
    ///    desc = Type: <b>const [DML_BINDING_TABLE_DESC](/windows/win32/api/directml/ns-directml-dml_binding_table_desc)*</b>
    ///           An optional pointer to a
    ///           [DML_BINDING_TABLE_DESC](/windows/win32/api/directml/ns-directml-dml_binding_table_desc) containing the
    ///           binding table parameters. This may be <b>nullptr</b>, indicating an empty binding table.
    ///Returns:
    ///    Type: [**HRESULT**](/windows/desktop/winprog/windows-data-types) If this method succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an **HRESULT** error code.
    ///    
    HRESULT Reset(const(DML_BINDING_TABLE_DESC)* desc);
}

///Records dispatches of DirectML work into a Direct3D 12 command list. The **IDMLCommandRecorder** interface inherits
///from [IDMLDeviceChild](/windows/win32/api/directml/nn-directml-idmldevicechild). The command recorder is a stateless
///object whose purpose is to record commands into a Direct3D 12 command list. DirectML doesn't create command lists,
///command allocators, nor command queues; nor does it directly submit any work for execution on the GPU. Instead, your
///application manages its own command lists and queues, and it uses the <b>IDMLCommandRecorder</b> to record work into
///its existing command lists. You're then responsible for executing the command list on a queue of your choice. This
///object is thread-safe.
@GUID("E6857A76-2E3E-4FDD-BFF4-5D2BA10FB453")
interface IDMLCommandRecorder : IDMLDeviceChild
{
    ///Records execution of a dispatchable object (an operator initializer, or a compiled operator) onto a command list.
    ///This method doesn't submit the execution to the GPU; it merely records it onto the command list. You are
    ///responsible for closing the command list and submitting it to the Direct3D 12 command queue. Prior to execution
    ///of this call on the GPU, all resources bound must be in the D3D12_RESOURCE_STATE_UNORDERED_ACCESS state, or a
    ///state implicitly promotable to <b>D3D12_RESOURCE_STATE_UNORDERED_ACCESS</b>, such as
    ///<b>D3D12_RESOURCE_STATE_COMMON</b>. After this call completes, the resources remain in the
    ///<b>D3D12_RESOURCE_STATE_UNORDERED_ACCESS</b> state. The only exception to this is for upload heaps bound when
    ///executing an operator initializer and while one or more tensors has the
    ///[DML_TENSOR_FLAG_OWNED_BY_DML](/windows/win32/api/directml/ne-directml-dml_tensor_flags) flag set. In that case,
    ///any upload heaps bound for input must be in the <b>D3D12_RESOURCE_STATE_GENERIC_READ</b> state and will remain in
    ///that state, as required by all upload heaps. This method resets the following state on the command list. <ul>
    ///<li>Compute root signature</li> <li>Pipeline state</li> </ul>No other command list state is modified. Although
    ///this method takes a binding table representing the resources to bind to the pipeline, it doesn't set the
    ///descriptor heaps containing the descriptors themselves. Therefore, your application is responsible for calling
    ///ID3D12GraphicsCommandList::SetDescriptorHeaps to bind the correct descriptor heaps to the pipeline. If
    ///[DML_EXECUTION_FLAG_DESCRIPTORS_VOLATILE](/windows/win32/api/directml/ne-directml-dml_execution_flags) was not
    ///set when compiling the operator, then all bindings must be set on the binding table before <b>RecordDispatch</b>
    ///is called, otherwise the behavior is undefined. Otherwise, if the <b>_DESCRIPTORS_VOLATILE</b> flag is set,
    ///binding of resources may be deferred until the Direct3D 12 command list is submitted to the command queue for
    ///execution. This method acts logically like a call to ID3D12GraphicsCommandList::Dispatch. As such, unordered
    ///access view (UAV) barriers are necessary to ensure correct ordering if there are data dependencies between
    ///dispatches. This method does not insert UAV barriers on input nor output resources. Your application must ensure
    ///that the correct UAV barriers are performed on any inputs if their contents depend on an upstream dispatch, and
    ///on any outputs if there are downstream dispatches that depend on those outputs. This method doesn't hold
    ///references to any of the interfaces passed in. It is your responsibility to ensure that the
    ///[IDMLDispatchable](/windows/win32/api/directml/nn-directml-idmldispatchable) object is not released until all
    ///dispatches using it have completed execution on the GPU.
    ///Params:
    ///    commandList = Type: <b>ID3D12CommandList*</b> A pointer to an ID3D12CommandList interface representing the command list to
    ///                  record the execution into. The command list must be open and must have type D3D12_COMMAND_LIST_TYPE_DIRECT or
    ///                  <b>D3D12_COMMAND_LIST_TYPE_COMPUTE</b>.
    ///    dispatchable = Type: <b>[IDMLDispatchable](/windows/win32/api/directml/nn-directml-idmldispatchable)*</b> A pointer to an
    ///                   [IDMLDispatchable](/windows/win32/api/directml/nn-directml-idmldispatchable) interface representing the
    ///                   object (an operator initializer, or a compiled operator) whose execution will be recorded into the command
    ///                   list.
    ///    bindings = Type: <b>[IDMLBindingTable](/windows/win32/api/directml/nn-directml-idmlbindingtable)*</b> A pointer to an
    ///               [IDMLBindingTable](/windows/win32/api/directml/nn-directml-idmlbindingtable) interface representing the
    ///               bindings to use for executing the dispatchable object. If the
    ///               [DML_EXECUTION_FLAG_DESCRIPTORS_VOLATILE](/windows/win32/api/directml/ne-directml-dml_execution_flags) flag
    ///               was not set, then you must fill out all required bindings, otherwise an error will result.
    void RecordDispatch(ID3D12CommandList commandList, IDMLDispatchable dispatchable, IDMLBindingTable bindings);
}

///Controls the DirectML debug layers.
@GUID("7D6F3AC9-394A-4AC3-92A7-390CC57A8217")
interface IDMLDebugDevice : IUnknown
{
    ///Determine whether to mute DirectML from sending messages to the ID3D12InfoQueue.
    ///Params:
    ///    mute = Type: <b>BOOL</b> If <b>TRUE</b>, DirectML is muted, and it will not send messages to the ID3D12InfoQueue. If
    ///           <b>FALSE</b>, DirectML is not muted, and it will send messages to the <b>ID3D12InfoQueue</b>. The default
    ///           value is <b>FALSE</b>.
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
