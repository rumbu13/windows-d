// Written in the D programming language.

module windows.direct3d11;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.displaydevices : RECT;
public import windows.dxgi : DXGI_FORMAT, DXGI_SAMPLE_DESC, DXGI_SWAP_CHAIN_DESC,
                             IDXGIAdapter, IDXGISwapChain;
public import windows.mediafoundation : D3D11_FEATURE_VIDEO, D3D11_VIDEO_DECODER_BUFFER_TYPE,
                                        D3D11_VIDEO_DECODER_DESC,
                                        D3D11_VIDEO_DECODER_SUB_SAMPLE_MAPPING_BLOCK,
                                        ID3D11CryptoSession, ID3D11VideoContext2,
                                        ID3D11VideoDecoder, ID3D11VideoDecoderOutputView,
                                        ID3D11VideoDevice1;
public import windows.systemservices : BOOL, HANDLE, PSTR, PWSTR, SECURITY_ATTRIBUTES;

extern(Windows) @nogc nothrow:


// Enums


///Driver type options. > [!NOTE] > For programming with Direct3D 10, this API has a type alias that begins `D3D10_`
///instead of `D3D_`. These Direct3D 10 type aliases are defined in `d3d10.h`, `d3d10misc.h`, and `d3d10shader.h`.
alias D3D_DRIVER_TYPE = int;
enum : int
{
    ///The driver type is unknown.
    D3D_DRIVER_TYPE_UNKNOWN   = 0x00000000,
    ///A hardware driver, which implements Direct3D features in hardware. This is the primary driver that you should use
    ///in your Direct3D applications because it provides the best performance. A hardware driver uses hardware
    ///acceleration (on supported hardware) but can also use software for parts of the pipeline that are not supported
    ///in hardware. This driver type is often referred to as a hardware abstraction layer or HAL.
    D3D_DRIVER_TYPE_HARDWARE  = 0x00000001,
    ///A reference driver, which is a software implementation that supports every Direct3D feature. A reference driver
    ///is designed for accuracy rather than speed and as a result is slow but accurate. The rasterizer portion of the
    ///driver does make use of special CPU instructions whenever it can, but it is not intended for retail applications;
    ///use it only for feature testing, demonstration of functionality, debugging, or verifying bugs in other drivers.
    ///The reference device for this driver is installed by the Windows SDK 8.0 or later and is intended only as a debug
    ///aid for development purposes. This driver may be referred to as a REF driver, a reference driver, or a reference
    ///rasterizer. <div class="alert"><b>Note</b> When you use the REF driver in Windows Store apps, the REF driver
    ///renders correctly but doesn't display any output on the screen. To verify bugs in hardware drivers for Windows
    ///Store apps, use D3D_DRIVER_TYPE_WARP for the WARP driver instead.</div> <div> </div>
    D3D_DRIVER_TYPE_REFERENCE = 0x00000002,
    ///A NULL driver, which is a reference driver without render capability. This driver is commonly used for debugging
    ///non-rendering API calls, it is not appropriate for retail applications. This driver is installed by the DirectX
    ///SDK.
    D3D_DRIVER_TYPE_NULL      = 0x00000003,
    ///A software driver, which is a driver implemented completely in software. The software implementation is not
    ///intended for a high-performance application due to its very slow performance.
    D3D_DRIVER_TYPE_SOFTWARE  = 0x00000004,
    ///A WARP driver, which is a high-performance software rasterizer. The rasterizer supports feature levels 9_1
    ///through level 10_1 with a high performance software implementation. For information about limitations creating a
    ///WARP device on certain feature levels, see Limitations Creating WARP and Reference Devices. For more information
    ///about using a WARP driver, see Windows Advanced Rasterization Platform (WARP) In-Depth Guide. <div
    ///class="alert"><b>Note</b> The WARP driver that Windows 8 includes supports feature levels 9_1 through level
    ///11_1.</div> <div> </div> <div class="alert"><b>Note</b> The WARP driver that Windows 8.1 includes fully supports
    ///feature level 11_1, including tiled resources, IDXGIDevice3::Trim, shared BCn surfaces, minblend, and map
    ///default. </div> <div> </div>
    D3D_DRIVER_TYPE_WARP      = 0x00000005,
}

///Describes the set of features targeted by a Direct3D device.
alias D3D_FEATURE_LEVEL = int;
enum : int
{
    ///Allows Microsoft Compute Driver Model (MCDM) devices to be used, or more feature-rich devices (such as
    ///traditional GPUs) that support a superset of the functionality. MCDM is the overall driver model for
    ///compute-only; it's a scaled-down peer of the larger scoped Windows Device Driver Model (WDDM).
    D3D_FEATURE_LEVEL_1_0_CORE = 0x00001000,
    ///Targets features supported by [feature
    ///level](/windows/desktop/direct3d11/overviews-direct3d-11-devices-downlevel-intro) 9.1, including shader model 2.
    D3D_FEATURE_LEVEL_9_1      = 0x00009100,
    ///Targets features supported by [feature
    ///level](/windows/desktop/direct3d11/overviews-direct3d-11-devices-downlevel-intro) 9.2, including shader model 2.
    D3D_FEATURE_LEVEL_9_2      = 0x00009200,
    ///Targets features supported by [feature
    ///level](/windows/desktop/direct3d11/overviews-direct3d-11-devices-downlevel-intro) 9.3, including shader model
    ///2.0b.
    D3D_FEATURE_LEVEL_9_3      = 0x00009300,
    ///Targets features supported by Direct3D 10.0, including shader model 4.
    D3D_FEATURE_LEVEL_10_0     = 0x0000a000,
    ///Targets features supported by Direct3D 10.1, including shader model 4.
    D3D_FEATURE_LEVEL_10_1     = 0x0000a100,
    ///Targets features supported by Direct3D 11.0, including shader model 5.
    D3D_FEATURE_LEVEL_11_0     = 0x0000b000,
    ///Targets features supported by Direct3D 11.1, including shader model 5 and logical blend operations. This feature
    ///level requires a display driver that is at least implemented to WDDM for Windows 8 (WDDM 1.2).
    D3D_FEATURE_LEVEL_11_1     = 0x0000b100,
    ///Targets features supported by Direct3D 12.0, including shader model 5.
    D3D_FEATURE_LEVEL_12_0     = 0x0000c000,
    ///Targets features supported by Direct3D 12.1, including shader model 5.
    D3D_FEATURE_LEVEL_12_1     = 0x0000c100,
}

///Values that indicate how the pipeline interprets vertex data that is bound to the input-assembler stage. These
///primitive topology values determine how the vertex data is rendered on screen. > [!NOTE] > For programming with
///Direct3D 10, this API has a type alias that begins `D3D10_` instead of `D3D_`. These Direct3D 10 type aliases are
///defined in `d3d10.h`, `d3d10misc.h`, and `d3d10shader.h`.
alias D3D_PRIMITIVE_TOPOLOGY = int;
enum : int
{
    ///The IA stage has not been initialized with a primitive topology. The IA stage will not function properly unless a
    ///primitive topology is defined.
    D3D_PRIMITIVE_TOPOLOGY_UNDEFINED                    = 0x00000000,
    ///Interpret the vertex data as a list of points.
    D3D_PRIMITIVE_TOPOLOGY_POINTLIST                    = 0x00000001,
    ///Interpret the vertex data as a list of lines.
    D3D_PRIMITIVE_TOPOLOGY_LINELIST                     = 0x00000002,
    ///Interpret the vertex data as a line strip.
    D3D_PRIMITIVE_TOPOLOGY_LINESTRIP                    = 0x00000003,
    ///Interpret the vertex data as a list of triangles.
    D3D_PRIMITIVE_TOPOLOGY_TRIANGLELIST                 = 0x00000004,
    ///Interpret the vertex data as a triangle strip.
    D3D_PRIMITIVE_TOPOLOGY_TRIANGLESTRIP                = 0x00000005,
    ///Interpret the vertex data as a list of lines with adjacency data.
    D3D_PRIMITIVE_TOPOLOGY_LINELIST_ADJ                 = 0x0000000a,
    ///Interpret the vertex data as a line strip with adjacency data.
    D3D_PRIMITIVE_TOPOLOGY_LINESTRIP_ADJ                = 0x0000000b,
    ///Interpret the vertex data as a list of triangles with adjacency data.
    D3D_PRIMITIVE_TOPOLOGY_TRIANGLELIST_ADJ             = 0x0000000c,
    ///Interpret the vertex data as a triangle strip with adjacency data.
    D3D_PRIMITIVE_TOPOLOGY_TRIANGLESTRIP_ADJ            = 0x0000000d,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_1_CONTROL_POINT_PATCHLIST    = 0x00000021,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_2_CONTROL_POINT_PATCHLIST    = 0x00000022,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_3_CONTROL_POINT_PATCHLIST    = 0x00000023,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_4_CONTROL_POINT_PATCHLIST    = 0x00000024,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_5_CONTROL_POINT_PATCHLIST    = 0x00000025,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_6_CONTROL_POINT_PATCHLIST    = 0x00000026,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_7_CONTROL_POINT_PATCHLIST    = 0x00000027,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_8_CONTROL_POINT_PATCHLIST    = 0x00000028,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_9_CONTROL_POINT_PATCHLIST    = 0x00000029,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_10_CONTROL_POINT_PATCHLIST   = 0x0000002a,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_11_CONTROL_POINT_PATCHLIST   = 0x0000002b,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_12_CONTROL_POINT_PATCHLIST   = 0x0000002c,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_13_CONTROL_POINT_PATCHLIST   = 0x0000002d,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_14_CONTROL_POINT_PATCHLIST   = 0x0000002e,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_15_CONTROL_POINT_PATCHLIST   = 0x0000002f,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_16_CONTROL_POINT_PATCHLIST   = 0x00000030,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_17_CONTROL_POINT_PATCHLIST   = 0x00000031,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_18_CONTROL_POINT_PATCHLIST   = 0x00000032,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_19_CONTROL_POINT_PATCHLIST   = 0x00000033,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_20_CONTROL_POINT_PATCHLIST   = 0x00000034,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_21_CONTROL_POINT_PATCHLIST   = 0x00000035,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_22_CONTROL_POINT_PATCHLIST   = 0x00000036,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_23_CONTROL_POINT_PATCHLIST   = 0x00000037,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_24_CONTROL_POINT_PATCHLIST   = 0x00000038,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_25_CONTROL_POINT_PATCHLIST   = 0x00000039,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_26_CONTROL_POINT_PATCHLIST   = 0x0000003a,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_27_CONTROL_POINT_PATCHLIST   = 0x0000003b,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_28_CONTROL_POINT_PATCHLIST   = 0x0000003c,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_29_CONTROL_POINT_PATCHLIST   = 0x0000003d,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_30_CONTROL_POINT_PATCHLIST   = 0x0000003e,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_31_CONTROL_POINT_PATCHLIST   = 0x0000003f,
    ///Interpret the vertex data as a patch list.
    D3D_PRIMITIVE_TOPOLOGY_32_CONTROL_POINT_PATCHLIST   = 0x00000040,
    ///The IA stage has not been initialized with a primitive topology. The IA stage will not function properly unless a
    ///primitive topology is defined.
    D3D10_PRIMITIVE_TOPOLOGY_UNDEFINED                  = 0x00000000,
    ///Interpret the vertex data as a list of points.
    D3D10_PRIMITIVE_TOPOLOGY_POINTLIST                  = 0x00000001,
    ///Interpret the vertex data as a list of lines.
    D3D10_PRIMITIVE_TOPOLOGY_LINELIST                   = 0x00000002,
    ///Interpret the vertex data as a line strip.
    D3D10_PRIMITIVE_TOPOLOGY_LINESTRIP                  = 0x00000003,
    ///Interpret the vertex data as a list of triangles.
    D3D10_PRIMITIVE_TOPOLOGY_TRIANGLELIST               = 0x00000004,
    ///Interpret the vertex data as a triangle strip.
    D3D10_PRIMITIVE_TOPOLOGY_TRIANGLESTRIP              = 0x00000005,
    ///Interpret the vertex data as a list of lines with adjacency data.
    D3D10_PRIMITIVE_TOPOLOGY_LINELIST_ADJ               = 0x0000000a,
    ///Interpret the vertex data as a line strip with adjacency data.
    D3D10_PRIMITIVE_TOPOLOGY_LINESTRIP_ADJ              = 0x0000000b,
    ///Interpret the vertex data as a list of triangles with adjacency data.
    D3D10_PRIMITIVE_TOPOLOGY_TRIANGLELIST_ADJ           = 0x0000000c,
    ///Interpret the vertex data as a triangle strip with adjacency data.
    D3D10_PRIMITIVE_TOPOLOGY_TRIANGLESTRIP_ADJ          = 0x0000000d,
    ///The IA stage has not been initialized with a primitive topology. The IA stage will not function properly unless a
    ///primitive topology is defined.
    D3D11_PRIMITIVE_TOPOLOGY_UNDEFINED                  = 0x00000000,
    ///Interpret the vertex data as a list of points.
    D3D11_PRIMITIVE_TOPOLOGY_POINTLIST                  = 0x00000001,
    ///Interpret the vertex data as a list of lines.
    D3D11_PRIMITIVE_TOPOLOGY_LINELIST                   = 0x00000002,
    ///Interpret the vertex data as a line strip.
    D3D11_PRIMITIVE_TOPOLOGY_LINESTRIP                  = 0x00000003,
    ///Interpret the vertex data as a list of triangles.
    D3D11_PRIMITIVE_TOPOLOGY_TRIANGLELIST               = 0x00000004,
    ///Interpret the vertex data as a triangle strip.
    D3D11_PRIMITIVE_TOPOLOGY_TRIANGLESTRIP              = 0x00000005,
    ///Interpret the vertex data as a list of lines with adjacency data.
    D3D11_PRIMITIVE_TOPOLOGY_LINELIST_ADJ               = 0x0000000a,
    ///Interpret the vertex data as a line strip with adjacency data.
    D3D11_PRIMITIVE_TOPOLOGY_LINESTRIP_ADJ              = 0x0000000b,
    ///Interpret the vertex data as a list of triangles with adjacency data.
    D3D11_PRIMITIVE_TOPOLOGY_TRIANGLELIST_ADJ           = 0x0000000c,
    ///Interpret the vertex data as a triangle strip with adjacency data.
    D3D11_PRIMITIVE_TOPOLOGY_TRIANGLESTRIP_ADJ          = 0x0000000d,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_1_CONTROL_POINT_PATCHLIST  = 0x00000021,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_2_CONTROL_POINT_PATCHLIST  = 0x00000022,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_3_CONTROL_POINT_PATCHLIST  = 0x00000023,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_4_CONTROL_POINT_PATCHLIST  = 0x00000024,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_5_CONTROL_POINT_PATCHLIST  = 0x00000025,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_6_CONTROL_POINT_PATCHLIST  = 0x00000026,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_7_CONTROL_POINT_PATCHLIST  = 0x00000027,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_8_CONTROL_POINT_PATCHLIST  = 0x00000028,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_9_CONTROL_POINT_PATCHLIST  = 0x00000029,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_10_CONTROL_POINT_PATCHLIST = 0x0000002a,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_11_CONTROL_POINT_PATCHLIST = 0x0000002b,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_12_CONTROL_POINT_PATCHLIST = 0x0000002c,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_13_CONTROL_POINT_PATCHLIST = 0x0000002d,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_14_CONTROL_POINT_PATCHLIST = 0x0000002e,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_15_CONTROL_POINT_PATCHLIST = 0x0000002f,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_16_CONTROL_POINT_PATCHLIST = 0x00000030,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_17_CONTROL_POINT_PATCHLIST = 0x00000031,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_18_CONTROL_POINT_PATCHLIST = 0x00000032,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_19_CONTROL_POINT_PATCHLIST = 0x00000033,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_20_CONTROL_POINT_PATCHLIST = 0x00000034,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_21_CONTROL_POINT_PATCHLIST = 0x00000035,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_22_CONTROL_POINT_PATCHLIST = 0x00000036,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_23_CONTROL_POINT_PATCHLIST = 0x00000037,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_24_CONTROL_POINT_PATCHLIST = 0x00000038,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_25_CONTROL_POINT_PATCHLIST = 0x00000039,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_26_CONTROL_POINT_PATCHLIST = 0x0000003a,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_27_CONTROL_POINT_PATCHLIST = 0x0000003b,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_28_CONTROL_POINT_PATCHLIST = 0x0000003c,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_29_CONTROL_POINT_PATCHLIST = 0x0000003d,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_30_CONTROL_POINT_PATCHLIST = 0x0000003e,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_31_CONTROL_POINT_PATCHLIST = 0x0000003f,
    ///Interpret the vertex data as a patch list.
    D3D11_PRIMITIVE_TOPOLOGY_32_CONTROL_POINT_PATCHLIST = 0x00000040,
}

///Indicates how the pipeline interprets geometry or hull shader input primitives. > [!NOTE] > For programming with
///Direct3D 10, this API has a type alias that begins `D3D10_` instead of `D3D_`. These Direct3D 10 type aliases are
///defined in `d3d10.h`, `d3d10misc.h`, and `d3d10shader.h`.
alias D3D_PRIMITIVE = int;
enum : int
{
    D3D_PRIMITIVE_UNDEFINED                = 0x00000000,
    D3D_PRIMITIVE_POINT                    = 0x00000001,
    D3D_PRIMITIVE_LINE                     = 0x00000002,
    D3D_PRIMITIVE_TRIANGLE                 = 0x00000003,
    D3D_PRIMITIVE_LINE_ADJ                 = 0x00000006,
    D3D_PRIMITIVE_TRIANGLE_ADJ             = 0x00000007,
    D3D_PRIMITIVE_1_CONTROL_POINT_PATCH    = 0x00000008,
    D3D_PRIMITIVE_2_CONTROL_POINT_PATCH    = 0x00000009,
    D3D_PRIMITIVE_3_CONTROL_POINT_PATCH    = 0x0000000a,
    D3D_PRIMITIVE_4_CONTROL_POINT_PATCH    = 0x0000000b,
    D3D_PRIMITIVE_5_CONTROL_POINT_PATCH    = 0x0000000c,
    D3D_PRIMITIVE_6_CONTROL_POINT_PATCH    = 0x0000000d,
    D3D_PRIMITIVE_7_CONTROL_POINT_PATCH    = 0x0000000e,
    D3D_PRIMITIVE_8_CONTROL_POINT_PATCH    = 0x0000000f,
    D3D_PRIMITIVE_9_CONTROL_POINT_PATCH    = 0x00000010,
    D3D_PRIMITIVE_10_CONTROL_POINT_PATCH   = 0x00000011,
    D3D_PRIMITIVE_11_CONTROL_POINT_PATCH   = 0x00000012,
    D3D_PRIMITIVE_12_CONTROL_POINT_PATCH   = 0x00000013,
    D3D_PRIMITIVE_13_CONTROL_POINT_PATCH   = 0x00000014,
    D3D_PRIMITIVE_14_CONTROL_POINT_PATCH   = 0x00000015,
    D3D_PRIMITIVE_15_CONTROL_POINT_PATCH   = 0x00000016,
    D3D_PRIMITIVE_16_CONTROL_POINT_PATCH   = 0x00000017,
    D3D_PRIMITIVE_17_CONTROL_POINT_PATCH   = 0x00000018,
    D3D_PRIMITIVE_18_CONTROL_POINT_PATCH   = 0x00000019,
    D3D_PRIMITIVE_19_CONTROL_POINT_PATCH   = 0x0000001a,
    D3D_PRIMITIVE_20_CONTROL_POINT_PATCH   = 0x0000001b,
    D3D_PRIMITIVE_21_CONTROL_POINT_PATCH   = 0x0000001c,
    D3D_PRIMITIVE_22_CONTROL_POINT_PATCH   = 0x0000001d,
    D3D_PRIMITIVE_23_CONTROL_POINT_PATCH   = 0x0000001e,
    D3D_PRIMITIVE_24_CONTROL_POINT_PATCH   = 0x0000001f,
    D3D_PRIMITIVE_25_CONTROL_POINT_PATCH   = 0x00000020,
    D3D_PRIMITIVE_26_CONTROL_POINT_PATCH   = 0x00000021,
    D3D_PRIMITIVE_27_CONTROL_POINT_PATCH   = 0x00000022,
    D3D_PRIMITIVE_28_CONTROL_POINT_PATCH   = 0x00000023,
    D3D_PRIMITIVE_29_CONTROL_POINT_PATCH   = 0x00000024,
    D3D_PRIMITIVE_30_CONTROL_POINT_PATCH   = 0x00000025,
    D3D_PRIMITIVE_31_CONTROL_POINT_PATCH   = 0x00000026,
    D3D_PRIMITIVE_32_CONTROL_POINT_PATCH   = 0x00000027,
    D3D10_PRIMITIVE_UNDEFINED              = 0x00000000,
    D3D10_PRIMITIVE_POINT                  = 0x00000001,
    D3D10_PRIMITIVE_LINE                   = 0x00000002,
    D3D10_PRIMITIVE_TRIANGLE               = 0x00000003,
    D3D10_PRIMITIVE_LINE_ADJ               = 0x00000006,
    D3D10_PRIMITIVE_TRIANGLE_ADJ           = 0x00000007,
    ///The shader has not been initialized with an input primitive type.
    D3D11_PRIMITIVE_UNDEFINED              = 0x00000000,
    ///Interpret the input primitive as a point.
    D3D11_PRIMITIVE_POINT                  = 0x00000001,
    ///Interpret the input primitive as a line.
    D3D11_PRIMITIVE_LINE                   = 0x00000002,
    ///Interpret the input primitive as a triangle.
    D3D11_PRIMITIVE_TRIANGLE               = 0x00000003,
    ///Interpret the input primitive as a line with adjacency data.
    D3D11_PRIMITIVE_LINE_ADJ               = 0x00000006,
    ///Interpret the input primitive as a triangle with adjacency data.
    D3D11_PRIMITIVE_TRIANGLE_ADJ           = 0x00000007,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_1_CONTROL_POINT_PATCH  = 0x00000008,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_2_CONTROL_POINT_PATCH  = 0x00000009,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_3_CONTROL_POINT_PATCH  = 0x0000000a,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_4_CONTROL_POINT_PATCH  = 0x0000000b,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_5_CONTROL_POINT_PATCH  = 0x0000000c,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_6_CONTROL_POINT_PATCH  = 0x0000000d,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_7_CONTROL_POINT_PATCH  = 0x0000000e,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_8_CONTROL_POINT_PATCH  = 0x0000000f,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_9_CONTROL_POINT_PATCH  = 0x00000010,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_10_CONTROL_POINT_PATCH = 0x00000011,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_11_CONTROL_POINT_PATCH = 0x00000012,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_12_CONTROL_POINT_PATCH = 0x00000013,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_13_CONTROL_POINT_PATCH = 0x00000014,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_14_CONTROL_POINT_PATCH = 0x00000015,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_15_CONTROL_POINT_PATCH = 0x00000016,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_16_CONTROL_POINT_PATCH = 0x00000017,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_17_CONTROL_POINT_PATCH = 0x00000018,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_18_CONTROL_POINT_PATCH = 0x00000019,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_19_CONTROL_POINT_PATCH = 0x0000001a,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_20_CONTROL_POINT_PATCH = 0x0000001b,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_21_CONTROL_POINT_PATCH = 0x0000001c,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_22_CONTROL_POINT_PATCH = 0x0000001d,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_23_CONTROL_POINT_PATCH = 0x0000001e,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_24_CONTROL_POINT_PATCH = 0x0000001f,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_25_CONTROL_POINT_PATCH = 0x00000020,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_26_CONTROL_POINT_PATCH = 0x00000021,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_27_CONTROL_POINT_PATCH = 0x00000022,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_28_CONTROL_POINT_PATCH = 0x00000023,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_29_CONTROL_POINT_PATCH = 0x00000024,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_30_CONTROL_POINT_PATCH = 0x00000025,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_31_CONTROL_POINT_PATCH = 0x00000026,
    ///Interpret the input primitive as a control point patch.
    D3D11_PRIMITIVE_32_CONTROL_POINT_PATCH = 0x00000027,
}

///Values that identify the type of resource to be viewed as a shader resource. > [!NOTE] > For programming with
///Direct3D 10, this API has a type alias that begins `D3D10_` instead of `D3D_`. These Direct3D 10 type aliases are
///defined in `d3d10.h`, `d3d10misc.h`, and `d3d10shader.h`.
alias D3D_SRV_DIMENSION = int;
enum : int
{
    ///The type is unknown.
    D3D_SRV_DIMENSION_UNKNOWN              = 0x00000000,
    ///The resource is a buffer.
    D3D_SRV_DIMENSION_BUFFER               = 0x00000001,
    ///The resource is a 1D texture.
    D3D_SRV_DIMENSION_TEXTURE1D            = 0x00000002,
    ///The resource is an array of 1D textures.
    D3D_SRV_DIMENSION_TEXTURE1DARRAY       = 0x00000003,
    ///The resource is a 2D texture.
    D3D_SRV_DIMENSION_TEXTURE2D            = 0x00000004,
    ///The resource is an array of 2D textures.
    D3D_SRV_DIMENSION_TEXTURE2DARRAY       = 0x00000005,
    ///The resource is a multisampling 2D texture.
    D3D_SRV_DIMENSION_TEXTURE2DMS          = 0x00000006,
    ///The resource is an array of multisampling 2D textures.
    D3D_SRV_DIMENSION_TEXTURE2DMSARRAY     = 0x00000007,
    ///The resource is a 3D texture.
    D3D_SRV_DIMENSION_TEXTURE3D            = 0x00000008,
    ///The resource is a cube texture.
    D3D_SRV_DIMENSION_TEXTURECUBE          = 0x00000009,
    ///The resource is an array of cube textures.
    D3D_SRV_DIMENSION_TEXTURECUBEARRAY     = 0x0000000a,
    ///The resource is a raw buffer. For more info about raw viewing of buffers, see Raw Views of Buffers.
    D3D_SRV_DIMENSION_BUFFEREX             = 0x0000000b,
    ///The type is unknown.
    D3D10_SRV_DIMENSION_UNKNOWN            = 0x00000000,
    ///The resource is a buffer.
    D3D10_SRV_DIMENSION_BUFFER             = 0x00000001,
    ///The resource is a 1D texture.
    D3D10_SRV_DIMENSION_TEXTURE1D          = 0x00000002,
    ///The resource is an array of 1D textures.
    D3D10_SRV_DIMENSION_TEXTURE1DARRAY     = 0x00000003,
    ///The resource is a 2D texture.
    D3D10_SRV_DIMENSION_TEXTURE2D          = 0x00000004,
    ///The resource is an array of 2D textures.
    D3D10_SRV_DIMENSION_TEXTURE2DARRAY     = 0x00000005,
    ///The resource is a multisampling 2D texture.
    D3D10_SRV_DIMENSION_TEXTURE2DMS        = 0x00000006,
    ///The resource is an array of multisampling 2D textures.
    D3D10_SRV_DIMENSION_TEXTURE2DMSARRAY   = 0x00000007,
    ///The resource is a 3D texture.
    D3D10_SRV_DIMENSION_TEXTURE3D          = 0x00000008,
    ///The resource is a cube texture.
    D3D10_SRV_DIMENSION_TEXTURECUBE        = 0x00000009,
    ///The type is unknown.
    D3D10_1_SRV_DIMENSION_UNKNOWN          = 0x00000000,
    ///The resource is a buffer.
    D3D10_1_SRV_DIMENSION_BUFFER           = 0x00000001,
    ///The resource is a 1D texture.
    D3D10_1_SRV_DIMENSION_TEXTURE1D        = 0x00000002,
    ///The resource is an array of 1D textures.
    D3D10_1_SRV_DIMENSION_TEXTURE1DARRAY   = 0x00000003,
    ///The resource is a 2D texture.
    D3D10_1_SRV_DIMENSION_TEXTURE2D        = 0x00000004,
    ///The resource is an array of 2D textures.
    D3D10_1_SRV_DIMENSION_TEXTURE2DARRAY   = 0x00000005,
    ///The resource is a multisampling 2D texture.
    D3D10_1_SRV_DIMENSION_TEXTURE2DMS      = 0x00000006,
    ///The resource is an array of multisampling 2D textures.
    D3D10_1_SRV_DIMENSION_TEXTURE2DMSARRAY = 0x00000007,
    ///The resource is a 3D texture.
    D3D10_1_SRV_DIMENSION_TEXTURE3D        = 0x00000008,
    ///The resource is a cube texture.
    D3D10_1_SRV_DIMENSION_TEXTURECUBE      = 0x00000009,
    ///The resource is an array of cube textures.
    D3D10_1_SRV_DIMENSION_TEXTURECUBEARRAY = 0x0000000a,
    ///The type is unknown.
    D3D11_SRV_DIMENSION_UNKNOWN            = 0x00000000,
    ///The resource is a buffer.
    D3D11_SRV_DIMENSION_BUFFER             = 0x00000001,
    ///The resource is a 1D texture.
    D3D11_SRV_DIMENSION_TEXTURE1D          = 0x00000002,
    ///The resource is an array of 1D textures.
    D3D11_SRV_DIMENSION_TEXTURE1DARRAY     = 0x00000003,
    ///The resource is a 2D texture.
    D3D11_SRV_DIMENSION_TEXTURE2D          = 0x00000004,
    ///The resource is an array of 2D textures.
    D3D11_SRV_DIMENSION_TEXTURE2DARRAY     = 0x00000005,
    ///The resource is a multisampling 2D texture.
    D3D11_SRV_DIMENSION_TEXTURE2DMS        = 0x00000006,
    ///The resource is an array of multisampling 2D textures.
    D3D11_SRV_DIMENSION_TEXTURE2DMSARRAY   = 0x00000007,
    ///The resource is a 3D texture.
    D3D11_SRV_DIMENSION_TEXTURE3D          = 0x00000008,
    ///The resource is a cube texture.
    D3D11_SRV_DIMENSION_TEXTURECUBE        = 0x00000009,
    ///The resource is an array of cube textures.
    D3D11_SRV_DIMENSION_TEXTURECUBEARRAY   = 0x0000000a,
    ///The resource is a raw buffer. For more info about raw viewing of buffers, see Raw Views of Buffers.
    D3D11_SRV_DIMENSION_BUFFEREX           = 0x0000000b,
}

///Values that indicate the location of a shader #include file. > [!NOTE] > For programming with Direct3D 10, this API
///has a type alias that begins `D3D10_` instead of `D3D_`. These Direct3D 10 type aliases are defined in `d3d10.h`,
///`d3d10misc.h`, and `d3d10shader.h`.
alias D3D_INCLUDE_TYPE = int;
enum : int
{
    ///The local directory.
    D3D_INCLUDE_LOCAL       = 0x00000000,
    ///The system directory.
    D3D_INCLUDE_SYSTEM      = 0x00000001,
    ///The local directory.
    D3D10_INCLUDE_LOCAL     = 0x00000000,
    ///The system directory.
    D3D10_INCLUDE_SYSTEM    = 0x00000001,
    ///Forces this enumeration to compile to 32 bits in size. Without this value, some compilers would allow this
    ///enumeration to compile to a size other than 32 bits. Do not use this value.
    D3D_INCLUDE_FORCE_DWORD = 0x7fffffff,
}

///Values that identify the class of a shader variable. > [!NOTE] > For programming with Direct3D 10, this API has a
///type alias that begins `D3D10_` instead of `D3D_`. These Direct3D 10 type aliases are defined in `d3d10.h`,
///`d3d10misc.h`, and `d3d10shader.h`.
alias D3D_SHADER_VARIABLE_CLASS = int;
enum : int
{
    ///The shader variable is a scalar.
    D3D_SVC_SCALAR              = 0x00000000,
    ///The shader variable is a vector.
    D3D_SVC_VECTOR              = 0x00000001,
    ///The shader variable is a row-major matrix.
    D3D_SVC_MATRIX_ROWS         = 0x00000002,
    ///The shader variable is a column-major matrix.
    D3D_SVC_MATRIX_COLUMNS      = 0x00000003,
    ///The shader variable is an object.
    D3D_SVC_OBJECT              = 0x00000004,
    ///The shader variable is a structure.
    D3D_SVC_STRUCT              = 0x00000005,
    ///The shader variable is a class.
    D3D_SVC_INTERFACE_CLASS     = 0x00000006,
    ///The shader variable is an interface.
    D3D_SVC_INTERFACE_POINTER   = 0x00000007,
    ///The shader variable is a scalar.
    D3D10_SVC_SCALAR            = 0x00000000,
    ///The shader variable is a vector.
    D3D10_SVC_VECTOR            = 0x00000001,
    ///The shader variable is a row-major matrix.
    D3D10_SVC_MATRIX_ROWS       = 0x00000002,
    ///The shader variable is a column-major matrix.
    D3D10_SVC_MATRIX_COLUMNS    = 0x00000003,
    ///The shader variable is an object.
    D3D10_SVC_OBJECT            = 0x00000004,
    ///The shader variable is a structure.
    D3D10_SVC_STRUCT            = 0x00000005,
    ///The shader variable is a class.
    D3D11_SVC_INTERFACE_CLASS   = 0x00000006,
    ///The shader variable is an interface.
    D3D11_SVC_INTERFACE_POINTER = 0x00000007,
    ///This value is not used by a programmer; it exists to force the enumeration to compile to 32 bits.
    D3D_SVC_FORCE_DWORD         = 0x7fffffff,
}

///Values that identify information about a shader variable. > [!NOTE] > For programming with Direct3D 10, this API has
///a type alias that begins `D3D10_` instead of `D3D_`. These Direct3D 10 type aliases are defined in `d3d10.h`,
///`d3d10misc.h`, and `d3d10shader.h`.
alias D3D_SHADER_VARIABLE_FLAGS = int;
enum : int
{
    ///Indicates that the registers assigned to this shader variable were explicitly declared in shader code (instead of
    ///automatically assigned by the compiler).
    D3D_SVF_USERPACKED            = 0x00000001,
    ///Indicates that this variable is used by this shader. This value confirms that a particular shader variable (which
    ///can be common to many different shaders) is indeed used by a particular shader.
    D3D_SVF_USED                  = 0x00000002,
    ///Indicates that this variable is an interface.
    D3D_SVF_INTERFACE_POINTER     = 0x00000004,
    ///Indicates that this variable is a parameter of an interface.
    D3D_SVF_INTERFACE_PARAMETER   = 0x00000008,
    ///Indicates that the registers assigned to this shader variable were explicitly declared in shader code (instead of
    ///automatically assigned by the compiler).
    D3D10_SVF_USERPACKED          = 0x00000001,
    ///Indicates that this variable is used by this shader. This value confirms that a particular shader variable (which
    ///can be common to many different shaders) is indeed used by a particular shader.
    D3D10_SVF_USED                = 0x00000002,
    ///Indicates that this variable is an interface.
    D3D11_SVF_INTERFACE_POINTER   = 0x00000004,
    ///Indicates that this variable is a parameter of an interface.
    D3D11_SVF_INTERFACE_PARAMETER = 0x00000008,
    ///This value is not used by a programmer; it exists to force the enumeration to compile to 32 bits.
    D3D_SVF_FORCE_DWORD           = 0x7fffffff,
}

///Values that identify various data, texture, and buffer types that can be assigned to a shader variable. > [!NOTE] >
///For programming with Direct3D 10, this API has a type alias that begins `D3D10_` instead of `D3D_`. These Direct3D 10
///type aliases are defined in `d3d10.h`, `d3d10misc.h`, and `d3d10shader.h`.
alias D3D_SHADER_VARIABLE_TYPE = int;
enum : int
{
    ///The variable is a void pointer.
    D3D_SVT_VOID                        = 0x00000000,
    ///The variable is a boolean.
    D3D_SVT_BOOL                        = 0x00000001,
    ///The variable is an integer.
    D3D_SVT_INT                         = 0x00000002,
    ///The variable is a floating-point number.
    D3D_SVT_FLOAT                       = 0x00000003,
    ///The variable is a string.
    D3D_SVT_STRING                      = 0x00000004,
    ///The variable is a texture.
    D3D_SVT_TEXTURE                     = 0x00000005,
    ///The variable is a 1D texture.
    D3D_SVT_TEXTURE1D                   = 0x00000006,
    ///The variable is a 2D texture.
    D3D_SVT_TEXTURE2D                   = 0x00000007,
    ///The variable is a 3D texture.
    D3D_SVT_TEXTURE3D                   = 0x00000008,
    ///The variable is a texture cube.
    D3D_SVT_TEXTURECUBE                 = 0x00000009,
    ///The variable is a sampler.
    D3D_SVT_SAMPLER                     = 0x0000000a,
    ///The variable is a 1D sampler.
    D3D_SVT_SAMPLER1D                   = 0x0000000b,
    ///The variable is a 2D sampler.
    D3D_SVT_SAMPLER2D                   = 0x0000000c,
    ///The variable is a 3D sampler.
    D3D_SVT_SAMPLER3D                   = 0x0000000d,
    ///The variable is a cube sampler.
    D3D_SVT_SAMPLERCUBE                 = 0x0000000e,
    ///The variable is a pixel shader.
    D3D_SVT_PIXELSHADER                 = 0x0000000f,
    ///The variable is a vertex shader.
    D3D_SVT_VERTEXSHADER                = 0x00000010,
    ///The variable is a pixel fragment.
    D3D_SVT_PIXELFRAGMENT               = 0x00000011,
    ///The variable is a vertex fragment.
    D3D_SVT_VERTEXFRAGMENT              = 0x00000012,
    ///The variable is an unsigned integer.
    D3D_SVT_UINT                        = 0x00000013,
    ///The variable is an 8-bit unsigned integer.
    D3D_SVT_UINT8                       = 0x00000014,
    ///The variable is a geometry shader.
    D3D_SVT_GEOMETRYSHADER              = 0x00000015,
    ///The variable is a rasterizer-state object.
    D3D_SVT_RASTERIZER                  = 0x00000016,
    ///The variable is a depth-stencil-state object.
    D3D_SVT_DEPTHSTENCIL                = 0x00000017,
    ///The variable is a blend-state object.
    D3D_SVT_BLEND                       = 0x00000018,
    ///The variable is a buffer.
    D3D_SVT_BUFFER                      = 0x00000019,
    ///The variable is a constant buffer.
    D3D_SVT_CBUFFER                     = 0x0000001a,
    ///The variable is a texture buffer.
    D3D_SVT_TBUFFER                     = 0x0000001b,
    ///The variable is a 1D-texture array.
    D3D_SVT_TEXTURE1DARRAY              = 0x0000001c,
    ///The variable is a 2D-texture array.
    D3D_SVT_TEXTURE2DARRAY              = 0x0000001d,
    ///The variable is a render-target view.
    D3D_SVT_RENDERTARGETVIEW            = 0x0000001e,
    ///The variable is a depth-stencil view.
    D3D_SVT_DEPTHSTENCILVIEW            = 0x0000001f,
    ///The variable is a 2D-multisampled texture.
    D3D_SVT_TEXTURE2DMS                 = 0x00000020,
    ///The variable is a 2D-multisampled-texture array.
    D3D_SVT_TEXTURE2DMSARRAY            = 0x00000021,
    ///The variable is a texture-cube array.
    D3D_SVT_TEXTURECUBEARRAY            = 0x00000022,
    ///The variable holds a compiled hull-shader binary.
    D3D_SVT_HULLSHADER                  = 0x00000023,
    ///The variable holds a compiled domain-shader binary.
    D3D_SVT_DOMAINSHADER                = 0x00000024,
    ///The variable is an interface.
    D3D_SVT_INTERFACE_POINTER           = 0x00000025,
    ///The variable holds a compiled compute-shader binary.
    D3D_SVT_COMPUTESHADER               = 0x00000026,
    ///The variable is a double precision (64-bit) floating-point number.
    D3D_SVT_DOUBLE                      = 0x00000027,
    ///The variable is a 1D read-and-write texture.
    D3D_SVT_RWTEXTURE1D                 = 0x00000028,
    ///The variable is an array of 1D read-and-write textures.
    D3D_SVT_RWTEXTURE1DARRAY            = 0x00000029,
    ///The variable is a 2D read-and-write texture.
    D3D_SVT_RWTEXTURE2D                 = 0x0000002a,
    ///The variable is an array of 2D read-and-write textures.
    D3D_SVT_RWTEXTURE2DARRAY            = 0x0000002b,
    ///The variable is a 3D read-and-write texture.
    D3D_SVT_RWTEXTURE3D                 = 0x0000002c,
    ///The variable is a read-and-write buffer.
    D3D_SVT_RWBUFFER                    = 0x0000002d,
    ///The variable is a byte-address buffer.
    D3D_SVT_BYTEADDRESS_BUFFER          = 0x0000002e,
    ///The variable is a read-and-write byte-address buffer.
    D3D_SVT_RWBYTEADDRESS_BUFFER        = 0x0000002f,
    ///The variable is a structured buffer. For more information about structured buffer, see the <b>Remarks</b>
    ///section.
    D3D_SVT_STRUCTURED_BUFFER           = 0x00000030,
    ///The variable is a read-and-write structured buffer.
    D3D_SVT_RWSTRUCTURED_BUFFER         = 0x00000031,
    ///The variable is an append structured buffer.
    D3D_SVT_APPEND_STRUCTURED_BUFFER    = 0x00000032,
    ///The variable is a consume structured buffer.
    D3D_SVT_CONSUME_STRUCTURED_BUFFER   = 0x00000033,
    ///The variable is an 8-byte FLOAT.
    D3D_SVT_MIN8FLOAT                   = 0x00000034,
    ///The variable is a 10-byte FLOAT.
    D3D_SVT_MIN10FLOAT                  = 0x00000035,
    ///The variable is a 16-byte FLOAT.
    D3D_SVT_MIN16FLOAT                  = 0x00000036,
    ///The variable is a 12-byte INT.
    D3D_SVT_MIN12INT                    = 0x00000037,
    ///The variable is a 16-byte INT.
    D3D_SVT_MIN16INT                    = 0x00000038,
    ///The variable is a 16-byte INT.
    D3D_SVT_MIN16UINT                   = 0x00000039,
    ///The variable is a void pointer.
    D3D10_SVT_VOID                      = 0x00000000,
    ///The variable is a boolean.
    D3D10_SVT_BOOL                      = 0x00000001,
    ///The variable is an integer.
    D3D10_SVT_INT                       = 0x00000002,
    ///The variable is a floating-point number.
    D3D10_SVT_FLOAT                     = 0x00000003,
    ///The variable is a string.
    D3D10_SVT_STRING                    = 0x00000004,
    ///The variable is a texture.
    D3D10_SVT_TEXTURE                   = 0x00000005,
    ///The variable is a 1D texture.
    D3D10_SVT_TEXTURE1D                 = 0x00000006,
    ///The variable is a 2D texture.
    D3D10_SVT_TEXTURE2D                 = 0x00000007,
    ///The variable is a 3D texture.
    D3D10_SVT_TEXTURE3D                 = 0x00000008,
    ///The variable is a texture cube.
    D3D10_SVT_TEXTURECUBE               = 0x00000009,
    ///The variable is a sampler.
    D3D10_SVT_SAMPLER                   = 0x0000000a,
    ///The variable is a 1D sampler.
    D3D10_SVT_SAMPLER1D                 = 0x0000000b,
    ///The variable is a 2D sampler.
    D3D10_SVT_SAMPLER2D                 = 0x0000000c,
    ///The variable is a 3D sampler.
    D3D10_SVT_SAMPLER3D                 = 0x0000000d,
    ///The variable is a cube sampler.
    D3D10_SVT_SAMPLERCUBE               = 0x0000000e,
    ///The variable is a pixel shader.
    D3D10_SVT_PIXELSHADER               = 0x0000000f,
    ///The variable is a vertex shader.
    D3D10_SVT_VERTEXSHADER              = 0x00000010,
    ///The variable is a pixel fragment.
    D3D10_SVT_PIXELFRAGMENT             = 0x00000011,
    ///The variable is a vertex fragment.
    D3D10_SVT_VERTEXFRAGMENT            = 0x00000012,
    ///The variable is an unsigned integer.
    D3D10_SVT_UINT                      = 0x00000013,
    ///The variable is an 8-bit unsigned integer.
    D3D10_SVT_UINT8                     = 0x00000014,
    ///The variable is a geometry shader.
    D3D10_SVT_GEOMETRYSHADER            = 0x00000015,
    ///The variable is a rasterizer-state object.
    D3D10_SVT_RASTERIZER                = 0x00000016,
    ///The variable is a depth-stencil-state object.
    D3D10_SVT_DEPTHSTENCIL              = 0x00000017,
    ///The variable is a blend-state object.
    D3D10_SVT_BLEND                     = 0x00000018,
    ///The variable is a buffer.
    D3D10_SVT_BUFFER                    = 0x00000019,
    ///The variable is a constant buffer.
    D3D10_SVT_CBUFFER                   = 0x0000001a,
    ///The variable is a texture buffer.
    D3D10_SVT_TBUFFER                   = 0x0000001b,
    ///The variable is a 1D-texture array.
    D3D10_SVT_TEXTURE1DARRAY            = 0x0000001c,
    ///The variable is a 2D-texture array.
    D3D10_SVT_TEXTURE2DARRAY            = 0x0000001d,
    ///The variable is a render-target view.
    D3D10_SVT_RENDERTARGETVIEW          = 0x0000001e,
    ///The variable is a depth-stencil view.
    D3D10_SVT_DEPTHSTENCILVIEW          = 0x0000001f,
    ///The variable is a 2D-multisampled texture.
    D3D10_SVT_TEXTURE2DMS               = 0x00000020,
    ///The variable is a 2D-multisampled-texture array.
    D3D10_SVT_TEXTURE2DMSARRAY          = 0x00000021,
    ///The variable is a texture-cube array.
    D3D10_SVT_TEXTURECUBEARRAY          = 0x00000022,
    ///The variable holds a compiled hull-shader binary.
    D3D11_SVT_HULLSHADER                = 0x00000023,
    ///The variable holds a compiled domain-shader binary.
    D3D11_SVT_DOMAINSHADER              = 0x00000024,
    ///The variable is an interface.
    D3D11_SVT_INTERFACE_POINTER         = 0x00000025,
    ///The variable holds a compiled compute-shader binary.
    D3D11_SVT_COMPUTESHADER             = 0x00000026,
    ///The variable is a double precision (64-bit) floating-point number.
    D3D11_SVT_DOUBLE                    = 0x00000027,
    ///The variable is a 1D read-and-write texture.
    D3D11_SVT_RWTEXTURE1D               = 0x00000028,
    ///The variable is an array of 1D read-and-write textures.
    D3D11_SVT_RWTEXTURE1DARRAY          = 0x00000029,
    ///The variable is a 2D read-and-write texture.
    D3D11_SVT_RWTEXTURE2D               = 0x0000002a,
    ///The variable is an array of 2D read-and-write textures.
    D3D11_SVT_RWTEXTURE2DARRAY          = 0x0000002b,
    ///The variable is a 3D read-and-write texture.
    D3D11_SVT_RWTEXTURE3D               = 0x0000002c,
    ///The variable is a read-and-write buffer.
    D3D11_SVT_RWBUFFER                  = 0x0000002d,
    ///The variable is a byte-address buffer.
    D3D11_SVT_BYTEADDRESS_BUFFER        = 0x0000002e,
    ///The variable is a read and write byte-address buffer.
    D3D11_SVT_RWBYTEADDRESS_BUFFER      = 0x0000002f,
    ///The variable is a structured buffer.
    D3D11_SVT_STRUCTURED_BUFFER         = 0x00000030,
    ///The variable is a read-and-write structured buffer.
    D3D11_SVT_RWSTRUCTURED_BUFFER       = 0x00000031,
    ///The variable is an append structured buffer.
    D3D11_SVT_APPEND_STRUCTURED_BUFFER  = 0x00000032,
    ///The variable is a consume structured buffer.
    D3D11_SVT_CONSUME_STRUCTURED_BUFFER = 0x00000033,
    ///This value is not used by a programmer; it exists to force the enumeration to compile to 32 bits.
    D3D_SVT_FORCE_DWORD                 = 0x7fffffff,
}

///Values that identify shader-input options. > [!NOTE] > For programming with Direct3D 10, this API has a type alias
///that begins `D3D10_` instead of `D3D_`. These Direct3D 10 type aliases are defined in `d3d10.h`, `d3d10misc.h`, and
///`d3d10shader.h`.
alias D3D_SHADER_INPUT_FLAGS = int;
enum : int
{
    ///Assign a shader input to a register based on the register assignment in the HLSL code (instead of letting the
    ///compiler choose the register).
    D3D_SIF_USERPACKED            = 0x00000001,
    ///Use a comparison sampler, which uses the SampleCmp (DirectX HLSL Texture Object) and SampleCmpLevelZero (DirectX
    ///HLSL Texture Object) sampling functions.
    D3D_SIF_COMPARISON_SAMPLER    = 0x00000002,
    ///A 2-bit value for encoding texture components.
    D3D_SIF_TEXTURE_COMPONENT_0   = 0x00000004,
    ///A 2-bit value for encoding texture components.
    D3D_SIF_TEXTURE_COMPONENT_1   = 0x00000008,
    ///A 2-bit value for encoding texture components.
    D3D_SIF_TEXTURE_COMPONENTS    = 0x0000000c,
    ///This value is reserved.
    D3D_SIF_UNUSED                = 0x00000010,
    ///Assign a shader input to a register based on the register assignment in the HLSL code (instead of letting the
    ///compiler choose the register).
    D3D10_SIF_USERPACKED          = 0x00000001,
    ///Use a comparison sampler, which uses the SampleCmp (DirectX HLSL Texture Object) and SampleCmpLevelZero (DirectX
    ///HLSL Texture Object) sampling functions.
    D3D10_SIF_COMPARISON_SAMPLER  = 0x00000002,
    ///A 2-bit value for encoding texture components.
    D3D10_SIF_TEXTURE_COMPONENT_0 = 0x00000004,
    ///A 2-bit value for encoding texture components.
    D3D10_SIF_TEXTURE_COMPONENT_1 = 0x00000008,
    ///A 2-bit value for encoding texture components.
    D3D10_SIF_TEXTURE_COMPONENTS  = 0x0000000c,
    ///Forces the enumeration to compile to 32 bits. This value is not used directly by titles.
    D3D_SIF_FORCE_DWORD           = 0x7fffffff,
}

///Values that identify resource types that can be bound to a shader and that are reflected as part of the resource
///description for the shader. > [!NOTE] > For programming with Direct3D 10, this API has a type alias that begins
///`D3D10_` instead of `D3D_`. These Direct3D 10 type aliases are defined in `d3d10.h`, `d3d10misc.h`, and
///`d3d10shader.h`.
alias D3D_SHADER_INPUT_TYPE = int;
enum : int
{
    ///The shader resource is a constant buffer.
    D3D_SIT_CBUFFER                         = 0x00000000,
    ///The shader resource is a texture buffer.
    D3D_SIT_TBUFFER                         = 0x00000001,
    ///The shader resource is a texture.
    D3D_SIT_TEXTURE                         = 0x00000002,
    ///The shader resource is a sampler.
    D3D_SIT_SAMPLER                         = 0x00000003,
    ///The shader resource is a read-and-write buffer.
    D3D_SIT_UAV_RWTYPED                     = 0x00000004,
    ///The shader resource is a structured buffer. For more information about structured buffer, see the <b>Remarks</b>
    ///section.
    D3D_SIT_STRUCTURED                      = 0x00000005,
    ///The shader resource is a read-and-write structured buffer.
    D3D_SIT_UAV_RWSTRUCTURED                = 0x00000006,
    ///The shader resource is a byte-address buffer.
    D3D_SIT_BYTEADDRESS                     = 0x00000007,
    ///The shader resource is a read-and-write byte-address buffer.
    D3D_SIT_UAV_RWBYTEADDRESS               = 0x00000008,
    ///The shader resource is an append-structured buffer.
    D3D_SIT_UAV_APPEND_STRUCTURED           = 0x00000009,
    ///The shader resource is a consume-structured buffer.
    D3D_SIT_UAV_CONSUME_STRUCTURED          = 0x0000000a,
    ///The shader resource is a read-and-write structured buffer that uses the built-in counter to append or consume.
    D3D_SIT_UAV_RWSTRUCTURED_WITH_COUNTER   = 0x0000000b,
    D3D_SIT_RTACCELERATIONSTRUCTURE         = 0x0000000c,
    D3D_SIT_UAV_FEEDBACKTEXTURE             = 0x0000000d,
    ///The shader resource is a constant buffer.
    D3D10_SIT_CBUFFER                       = 0x00000000,
    ///The shader resource is a texture buffer.
    D3D10_SIT_TBUFFER                       = 0x00000001,
    ///The shader resource is a texture.
    D3D10_SIT_TEXTURE                       = 0x00000002,
    ///The shader resource is a sampler.
    D3D10_SIT_SAMPLER                       = 0x00000003,
    ///The shader resource is a read-and-write buffer.
    D3D11_SIT_UAV_RWTYPED                   = 0x00000004,
    ///The shader resource is a structured buffer. For more information about structured buffer, see the <b>Remarks</b>
    ///section.
    D3D11_SIT_STRUCTURED                    = 0x00000005,
    ///The shader resource is a read-and-write structured buffer.
    D3D11_SIT_UAV_RWSTRUCTURED              = 0x00000006,
    ///The shader resource is a byte-address buffer.
    D3D11_SIT_BYTEADDRESS                   = 0x00000007,
    ///The shader resource is a read-and-write byte-address buffer.
    D3D11_SIT_UAV_RWBYTEADDRESS             = 0x00000008,
    ///The shader resource is an append-structured buffer.
    D3D11_SIT_UAV_APPEND_STRUCTURED         = 0x00000009,
    ///The shader resource is a consume-structured buffer.
    D3D11_SIT_UAV_CONSUME_STRUCTURED        = 0x0000000a,
    ///The shader resource is a read-and-write structured buffer that uses the built-in counter to append or consume.
    D3D11_SIT_UAV_RWSTRUCTURED_WITH_COUNTER = 0x0000000b,
}

///Values that identify the indended use of a constant-data buffer. > [!NOTE] > For programming with Direct3D 10, this
///API has a type alias that begins `D3D10_` instead of `D3D_`. These Direct3D 10 type aliases are defined in `d3d10.h`,
///`d3d10misc.h`, and `d3d10shader.h`.
alias D3D_SHADER_CBUFFER_FLAGS = int;
enum : int
{
    ///Bind the constant buffer to an input slot defined in HLSL code (instead of letting the compiler choose the input
    ///slot).
    D3D_CBF_USERPACKED   = 0x00000001,
    ///Bind the constant buffer to an input slot defined in HLSL code (instead of letting the compiler choose the input
    ///slot).
    D3D10_CBF_USERPACKED = 0x00000001,
    ///This value is not used by a programmer; it exists to force the enumeration to compile to 32 bits.
    D3D_CBF_FORCE_DWORD  = 0x7fffffff,
}

///Values that identify the intended use of constant-buffer data. > [!NOTE] > For programming with Direct3D 10, this API
///has a type alias that begins `D3D10_` instead of `D3D_`. These Direct3D 10 type aliases are defined in `d3d10.h`,
///`d3d10misc.h`, and `d3d10shader.h`.
alias D3D_CBUFFER_TYPE = int;
enum : int
{
    ///A buffer containing scalar constants.
    D3D_CT_CBUFFER              = 0x00000000,
    ///A buffer containing texture data.
    D3D_CT_TBUFFER              = 0x00000001,
    ///A buffer containing interface pointers.
    D3D_CT_INTERFACE_POINTERS   = 0x00000002,
    ///A buffer containing binding information.
    D3D_CT_RESOURCE_BIND_INFO   = 0x00000003,
    ///A buffer containing scalar constants.
    D3D10_CT_CBUFFER            = 0x00000000,
    ///A buffer containing texture data.
    D3D10_CT_TBUFFER            = 0x00000001,
    ///A buffer containing scalar constants.
    D3D11_CT_CBUFFER            = 0x00000000,
    ///A buffer containing texture data.
    D3D11_CT_TBUFFER            = 0x00000001,
    ///A buffer containing interface pointers.
    D3D11_CT_INTERFACE_POINTERS = 0x00000002,
    ///A buffer containing binding information.
    D3D11_CT_RESOURCE_BIND_INFO = 0x00000003,
}

///Values that identify shader parameters that use system-value semantics. > [!NOTE] > For programming with Direct3D 10,
///this API has a type alias that begins `D3D10_` instead of `D3D_`. These Direct3D 10 type aliases are defined in
///`d3d10.h`, `d3d10misc.h`, and `d3d10shader.h`.
alias D3D_NAME = int;
enum : int
{
    ///This parameter does not use a predefined system-value semantic.
    D3D_NAME_UNDEFINED                       = 0x00000000,
    ///This parameter contains position data.
    D3D_NAME_POSITION                        = 0x00000001,
    ///This parameter contains clip-distance data.
    D3D_NAME_CLIP_DISTANCE                   = 0x00000002,
    ///This parameter contains cull-distance data.
    D3D_NAME_CULL_DISTANCE                   = 0x00000003,
    ///This parameter contains a render-target-array index.
    D3D_NAME_RENDER_TARGET_ARRAY_INDEX       = 0x00000004,
    ///This parameter contains a viewport-array index.
    D3D_NAME_VIEWPORT_ARRAY_INDEX            = 0x00000005,
    ///This parameter contains a vertex ID.
    D3D_NAME_VERTEX_ID                       = 0x00000006,
    ///This parameter contains a primitive ID.
    D3D_NAME_PRIMITIVE_ID                    = 0x00000007,
    ///This parameter contains an instance ID.
    D3D_NAME_INSTANCE_ID                     = 0x00000008,
    ///This parameter contains data that identifies whether or not the primitive faces the camera.
    D3D_NAME_IS_FRONT_FACE                   = 0x00000009,
    ///This parameter contains a sampler-array index.
    D3D_NAME_SAMPLE_INDEX                    = 0x0000000a,
    ///This parameter contains one of four tessellation factors that correspond to the amount of parts that a quad patch
    ///is broken into along the given edge. This flag is used to tessellate a quad patch.
    D3D_NAME_FINAL_QUAD_EDGE_TESSFACTOR      = 0x0000000b,
    ///This parameter contains one of two tessellation factors that correspond to the amount of parts that a quad patch
    ///is broken into vertically and horizontally within the patch. This flag is used to tessellate a quad patch.
    D3D_NAME_FINAL_QUAD_INSIDE_TESSFACTOR    = 0x0000000c,
    ///This parameter contains one of three tessellation factors that correspond to the amount of parts that a tri patch
    ///is broken into along the given edge. This flag is used to tessellate a tri patch.
    D3D_NAME_FINAL_TRI_EDGE_TESSFACTOR       = 0x0000000d,
    ///This parameter contains the tessellation factor that corresponds to the amount of parts that a tri patch is
    ///broken into within the patch. This flag is used to tessellate a tri patch.
    D3D_NAME_FINAL_TRI_INSIDE_TESSFACTOR     = 0x0000000e,
    ///This parameter contains the tessellation factor that corresponds to the number of lines broken into within the
    ///patch. This flag is used to tessellate an isolines patch.
    D3D_NAME_FINAL_LINE_DETAIL_TESSFACTOR    = 0x0000000f,
    ///This parameter contains the tessellation factor that corresponds to the number of lines that are created within
    ///the patch. This flag is used to tessellate an isolines patch.
    D3D_NAME_FINAL_LINE_DENSITY_TESSFACTOR   = 0x00000010,
    ///This parameter contains barycentric coordinate data.
    D3D_NAME_BARYCENTRICS                    = 0x00000017,
    D3D_NAME_SHADINGRATE                     = 0x00000018,
    D3D_NAME_CULLPRIMITIVE                   = 0x00000019,
    ///This parameter contains render-target data.
    D3D_NAME_TARGET                          = 0x00000040,
    ///This parameter contains depth data.
    D3D_NAME_DEPTH                           = 0x00000041,
    ///This parameter contains alpha-coverage data.
    D3D_NAME_COVERAGE                        = 0x00000042,
    ///This parameter signifies that the value is greater than or equal to a reference value. This flag is used to
    ///specify conservative depth for a pixel shader.
    D3D_NAME_DEPTH_GREATER_EQUAL             = 0x00000043,
    ///This parameter signifies that the value is less than or equal to a reference value. This flag is used to specify
    ///conservative depth for a pixel shader.
    D3D_NAME_DEPTH_LESS_EQUAL                = 0x00000044,
    ///This parameter contains a stencil reference. See Shader Specified Stencil Reference Value.
    D3D_NAME_STENCIL_REF                     = 0x00000045,
    ///This parameter contains inner input coverage data. See Conservative Rasterization.
    D3D_NAME_INNER_COVERAGE                  = 0x00000046,
    ///This parameter does not use a predefined system-value semantic.
    D3D10_NAME_UNDEFINED                     = 0x00000000,
    ///This parameter contains position data.
    D3D10_NAME_POSITION                      = 0x00000001,
    ///This parameter contains clip-distance data.
    D3D10_NAME_CLIP_DISTANCE                 = 0x00000002,
    ///This parameter contains cull-distance data.
    D3D10_NAME_CULL_DISTANCE                 = 0x00000003,
    ///This parameter contains a render-target-array index.
    D3D10_NAME_RENDER_TARGET_ARRAY_INDEX     = 0x00000004,
    ///This parameter contains a viewport-array index.
    D3D10_NAME_VIEWPORT_ARRAY_INDEX          = 0x00000005,
    ///This parameter contains a vertex ID.
    D3D10_NAME_VERTEX_ID                     = 0x00000006,
    ///This parameter contains a primitive ID.
    D3D10_NAME_PRIMITIVE_ID                  = 0x00000007,
    ///This parameter contains a instance ID.
    D3D10_NAME_INSTANCE_ID                   = 0x00000008,
    ///This parameter contains data that identifies whether or not the primitive faces the camera.
    D3D10_NAME_IS_FRONT_FACE                 = 0x00000009,
    ///This parameter contains a sampler-array index.
    D3D10_NAME_SAMPLE_INDEX                  = 0x0000000a,
    ///This parameter contains render-target data.
    D3D10_NAME_TARGET                        = 0x00000040,
    ///This parameter contains depth data.
    D3D10_NAME_DEPTH                         = 0x00000041,
    ///This parameter contains alpha-coverage data.
    D3D10_NAME_COVERAGE                      = 0x00000042,
    ///This parameter contains one of four tessellation factors that correspond to the amount of parts that a quad patch
    ///is broken into along the given edge. This flag is used to tessellate a quad patch.
    D3D11_NAME_FINAL_QUAD_EDGE_TESSFACTOR    = 0x0000000b,
    ///This parameter contains one of two tessellation factors that correspond to the amount of parts that a quad patch
    ///is broken into vertically and horizontally within the patch. This flag is used to tessellate a quad patch.
    D3D11_NAME_FINAL_QUAD_INSIDE_TESSFACTOR  = 0x0000000c,
    ///This parameter contains one of three tessellation factors that correspond to the amount of parts that a tri patch
    ///is broken into along the given edge. This flag is used to tessellate a tri patch.
    D3D11_NAME_FINAL_TRI_EDGE_TESSFACTOR     = 0x0000000d,
    ///This parameter contains the tessellation factor that corresponds to the amount of parts that a tri patch is
    ///broken into within the patch. This flag is used to tessellate a tri patch.
    D3D11_NAME_FINAL_TRI_INSIDE_TESSFACTOR   = 0x0000000e,
    ///This parameter contains the tessellation factor that corresponds to the amount of lines broken into within the
    ///patch. This flag is used to tessellate an isolines patch.
    D3D11_NAME_FINAL_LINE_DETAIL_TESSFACTOR  = 0x0000000f,
    ///This parameter contains the tessellation factor that corresponds to the amount of lines that are created within
    ///the patch. This flag is used to tessellate an isolines patch.
    D3D11_NAME_FINAL_LINE_DENSITY_TESSFACTOR = 0x00000010,
    ///This parameter signifies that the value is greater than or equal to a reference value. This flag is used to
    ///specify conservative depth for a pixel shader.
    D3D11_NAME_DEPTH_GREATER_EQUAL           = 0x00000043,
    ///This parameter signifies that the value is less than or equal to a reference value. This flag is used to specify
    ///conservative depth for a pixel shader.
    D3D11_NAME_DEPTH_LESS_EQUAL              = 0x00000044,
    ///This parameter contains a stencil reference. See Shader Specified Stencil Reference Value.
    D3D11_NAME_STENCIL_REF                   = 0x00000045,
    ///This parameter contains inner input coverage data. See Conservative Rasterization.
    D3D11_NAME_INNER_COVERAGE                = 0x00000046,
    ///This parameter contains barycentric coordinate data.
    D3D12_NAME_BARYCENTRICS                  = 0x00000017,
    D3D12_NAME_SHADINGRATE                   = 0x00000018,
    D3D12_NAME_CULLPRIMITIVE                 = 0x00000019,
}

///Indicates return value type. > [!NOTE] > For programming with Direct3D 10, this API has a type alias that begins
///`D3D10_` instead of `D3D_`. These Direct3D 10 type aliases are defined in `d3d10.h`, `d3d10misc.h`, and
///`d3d10shader.h`.
alias D3D_RESOURCE_RETURN_TYPE = int;
enum : int
{
    D3D_RETURN_TYPE_UNORM       = 0x00000001,
    D3D_RETURN_TYPE_SNORM       = 0x00000002,
    D3D_RETURN_TYPE_SINT        = 0x00000003,
    D3D_RETURN_TYPE_UINT        = 0x00000004,
    D3D_RETURN_TYPE_FLOAT       = 0x00000005,
    D3D_RETURN_TYPE_MIXED       = 0x00000006,
    D3D_RETURN_TYPE_DOUBLE      = 0x00000007,
    D3D_RETURN_TYPE_CONTINUED   = 0x00000008,
    D3D10_RETURN_TYPE_UNORM     = 0x00000001,
    D3D10_RETURN_TYPE_SNORM     = 0x00000002,
    D3D10_RETURN_TYPE_SINT      = 0x00000003,
    D3D10_RETURN_TYPE_UINT      = 0x00000004,
    D3D10_RETURN_TYPE_FLOAT     = 0x00000005,
    D3D10_RETURN_TYPE_MIXED     = 0x00000006,
    ///Return type is UNORM.
    D3D11_RETURN_TYPE_UNORM     = 0x00000001,
    ///Return type is SNORM.
    D3D11_RETURN_TYPE_SNORM     = 0x00000002,
    ///Return type is SINT.
    D3D11_RETURN_TYPE_SINT      = 0x00000003,
    ///Return type is UINT.
    D3D11_RETURN_TYPE_UINT      = 0x00000004,
    ///Return type is FLOAT.
    D3D11_RETURN_TYPE_FLOAT     = 0x00000005,
    ///Return type is unknown.
    D3D11_RETURN_TYPE_MIXED     = 0x00000006,
    ///Return type is DOUBLE.
    D3D11_RETURN_TYPE_DOUBLE    = 0x00000007,
    ///Return type is a multiple-dword type, such as a double or uint64, and the component is continued from the
    ///previous component that was declared. The first component represents the lower bits.
    D3D11_RETURN_TYPE_CONTINUED = 0x00000008,
}

///Values that identify the data types that can be stored in a register. > [!NOTE] > For programming with Direct3D 10,
///this API has a type alias that begins `D3D10_` instead of `D3D_`. These Direct3D 10 type aliases are defined in
///`d3d10.h`, `d3d10misc.h`, and `d3d10shader.h`.
alias D3D_REGISTER_COMPONENT_TYPE = int;
enum : int
{
    ///The data type is unknown.
    D3D_REGISTER_COMPONENT_UNKNOWN   = 0x00000000,
    ///32-bit unsigned integer.
    D3D_REGISTER_COMPONENT_UINT32    = 0x00000001,
    ///32-bit signed integer.
    D3D_REGISTER_COMPONENT_SINT32    = 0x00000002,
    ///32-bit floating-point number.
    D3D_REGISTER_COMPONENT_FLOAT32   = 0x00000003,
    ///The data type is unknown.
    D3D10_REGISTER_COMPONENT_UNKNOWN = 0x00000000,
    ///32-bit unsigned integer.
    D3D10_REGISTER_COMPONENT_UINT32  = 0x00000001,
    ///32-bit signed integer.
    D3D10_REGISTER_COMPONENT_SINT32  = 0x00000002,
    ///32-bit floating-point number.
    D3D10_REGISTER_COMPONENT_FLOAT32 = 0x00000003,
}

///Domain options for tessellator data.
alias D3D_TESSELLATOR_DOMAIN = int;
enum : int
{
    D3D_TESSELLATOR_DOMAIN_UNDEFINED   = 0x00000000,
    D3D_TESSELLATOR_DOMAIN_ISOLINE     = 0x00000001,
    D3D_TESSELLATOR_DOMAIN_TRI         = 0x00000002,
    D3D_TESSELLATOR_DOMAIN_QUAD        = 0x00000003,
    ///The data type is undefined.
    D3D11_TESSELLATOR_DOMAIN_UNDEFINED = 0x00000000,
    ///Isoline data.
    D3D11_TESSELLATOR_DOMAIN_ISOLINE   = 0x00000001,
    ///Triangle data.
    D3D11_TESSELLATOR_DOMAIN_TRI       = 0x00000002,
    ///Quad data.
    D3D11_TESSELLATOR_DOMAIN_QUAD      = 0x00000003,
}

///Partitioning options.
alias D3D_TESSELLATOR_PARTITIONING = int;
enum : int
{
    D3D_TESSELLATOR_PARTITIONING_UNDEFINED         = 0x00000000,
    D3D_TESSELLATOR_PARTITIONING_INTEGER           = 0x00000001,
    D3D_TESSELLATOR_PARTITIONING_POW2              = 0x00000002,
    D3D_TESSELLATOR_PARTITIONING_FRACTIONAL_ODD    = 0x00000003,
    D3D_TESSELLATOR_PARTITIONING_FRACTIONAL_EVEN   = 0x00000004,
    ///The partitioning type is undefined.
    D3D11_TESSELLATOR_PARTITIONING_UNDEFINED       = 0x00000000,
    ///Partition with integers only.
    D3D11_TESSELLATOR_PARTITIONING_INTEGER         = 0x00000001,
    ///Partition with a power-of-two number only.
    D3D11_TESSELLATOR_PARTITIONING_POW2            = 0x00000002,
    ///Partition with an odd, fractional number.
    D3D11_TESSELLATOR_PARTITIONING_FRACTIONAL_ODD  = 0x00000003,
    ///Partition with an even, fractional number.
    D3D11_TESSELLATOR_PARTITIONING_FRACTIONAL_EVEN = 0x00000004,
}

///Output primitive types.
alias D3D_TESSELLATOR_OUTPUT_PRIMITIVE = int;
enum : int
{
    D3D_TESSELLATOR_OUTPUT_UNDEFINED      = 0x00000000,
    D3D_TESSELLATOR_OUTPUT_POINT          = 0x00000001,
    D3D_TESSELLATOR_OUTPUT_LINE           = 0x00000002,
    D3D_TESSELLATOR_OUTPUT_TRIANGLE_CW    = 0x00000003,
    D3D_TESSELLATOR_OUTPUT_TRIANGLE_CCW   = 0x00000004,
    ///The output primitive type is undefined.
    D3D11_TESSELLATOR_OUTPUT_UNDEFINED    = 0x00000000,
    ///The output primitive type is a point.
    D3D11_TESSELLATOR_OUTPUT_POINT        = 0x00000001,
    ///The output primitive type is a line.
    D3D11_TESSELLATOR_OUTPUT_LINE         = 0x00000002,
    ///The output primitive type is a clockwise triangle.
    D3D11_TESSELLATOR_OUTPUT_TRIANGLE_CW  = 0x00000003,
    ///The output primitive type is a counter clockwise triangle.
    D3D11_TESSELLATOR_OUTPUT_TRIANGLE_CCW = 0x00000004,
}

///Values that indicate the minimum desired interpolation precision.
alias D3D_MIN_PRECISION = int;
enum : int
{
    ///Default minimum precision, which is 32-bit precision.
    D3D_MIN_PRECISION_DEFAULT   = 0x00000000,
    ///Minimum precision is min16float, which is 16-bit floating point.
    D3D_MIN_PRECISION_FLOAT_16  = 0x00000001,
    ///Minimum precision is min10float, which is 10-bit floating point.
    D3D_MIN_PRECISION_FLOAT_2_8 = 0x00000002,
    ///Reserved
    D3D_MIN_PRECISION_RESERVED  = 0x00000003,
    ///Minimum precision is min16int, which is 16-bit signed integer.
    D3D_MIN_PRECISION_SINT_16   = 0x00000004,
    ///Minimum precision is min16uint, which is 16-bit unsigned integer.
    D3D_MIN_PRECISION_UINT_16   = 0x00000005,
    ///Minimum precision is any 16-bit value.
    D3D_MIN_PRECISION_ANY_16    = 0x000000f0,
    ///Minimum precision is any 10-bit value.
    D3D_MIN_PRECISION_ANY_10    = 0x000000f1,
}

///Specifies interpolation mode, which affects how values are calculated during rasterization.
alias D3D_INTERPOLATION_MODE = int;
enum : int
{
    ///The interpolation mode is undefined.
    D3D_INTERPOLATION_UNDEFINED                     = 0x00000000,
    ///Don't interpolate between register values.
    D3D_INTERPOLATION_CONSTANT                      = 0x00000001,
    ///Interpolate linearly between register values.
    D3D_INTERPOLATION_LINEAR                        = 0x00000002,
    ///Interpolate linearly between register values but centroid clamped when multisampling.
    D3D_INTERPOLATION_LINEAR_CENTROID               = 0x00000003,
    ///Interpolate linearly between register values but with no perspective correction.
    D3D_INTERPOLATION_LINEAR_NOPERSPECTIVE          = 0x00000004,
    ///Interpolate linearly between register values but with no perspective correction and centroid clamped when
    ///multisampling.
    D3D_INTERPOLATION_LINEAR_NOPERSPECTIVE_CENTROID = 0x00000005,
    ///Interpolate linearly between register values but sample clamped when multisampling.
    D3D_INTERPOLATION_LINEAR_SAMPLE                 = 0x00000006,
    ///Interpolate linearly between register values but with no perspective correction and sample clamped when
    ///multisampling.
    D3D_INTERPOLATION_LINEAR_NOPERSPECTIVE_SAMPLE   = 0x00000007,
}

///Indicates semantic flags for function parameters.
alias D3D_PARAMETER_FLAGS = int;
enum : int
{
    ///The parameter has no semantic flags.
    D3D_PF_NONE        = 0x00000000,
    ///Indicates an input parameter.
    D3D_PF_IN          = 0x00000001,
    ///Indicates an output parameter.
    D3D_PF_OUT         = 0x00000002,
    ///Forces this enumeration to compile to 32 bits in size. Without this value, some compilers would allow this
    ///enumeration to compile to a size other than 32 bits. This value is not used.
    D3D_PF_FORCE_DWORD = 0x7fffffff,
}

///Type of data contained in an input slot.
alias D3D11_INPUT_CLASSIFICATION = int;
enum : int
{
    ///Input data is per-vertex data.
    D3D11_INPUT_PER_VERTEX_DATA   = 0x00000000,
    ///Input data is per-instance data.
    D3D11_INPUT_PER_INSTANCE_DATA = 0x00000001,
}

///Determines the fill mode to use when rendering triangles.
alias D3D11_FILL_MODE = int;
enum : int
{
    ///Draw lines connecting the vertices. Adjacent vertices are not drawn.
    D3D11_FILL_WIREFRAME = 0x00000002,
    ///Fill the triangles formed by the vertices. Adjacent vertices are not drawn.
    D3D11_FILL_SOLID     = 0x00000003,
}

///Indicates triangles facing a particular direction are not drawn.
alias D3D11_CULL_MODE = int;
enum : int
{
    ///Always draw all triangles.
    D3D11_CULL_NONE  = 0x00000001,
    ///Do not draw triangles that are front-facing.
    D3D11_CULL_FRONT = 0x00000002,
    ///Do not draw triangles that are back-facing.
    D3D11_CULL_BACK  = 0x00000003,
}

///Identifies the type of resource being used.
alias D3D11_RESOURCE_DIMENSION = int;
enum : int
{
    ///Resource is of unknown type.
    D3D11_RESOURCE_DIMENSION_UNKNOWN   = 0x00000000,
    ///Resource is a buffer.
    D3D11_RESOURCE_DIMENSION_BUFFER    = 0x00000001,
    ///Resource is a 1D texture.
    D3D11_RESOURCE_DIMENSION_TEXTURE1D = 0x00000002,
    ///Resource is a 2D texture.
    D3D11_RESOURCE_DIMENSION_TEXTURE2D = 0x00000003,
    ///Resource is a 3D texture.
    D3D11_RESOURCE_DIMENSION_TEXTURE3D = 0x00000004,
}

///Specifies how to access a resource used in a depth-stencil view.
alias D3D11_DSV_DIMENSION = int;
enum : int
{
    ///<i>D3D11_DSV_DIMENSION_UNKNOWN</i> is not a valid value for D3D11_DEPTH_STENCIL_VIEW_DESC and is not used.
    D3D11_DSV_DIMENSION_UNKNOWN          = 0x00000000,
    ///The resource will be accessed as a 1D texture.
    D3D11_DSV_DIMENSION_TEXTURE1D        = 0x00000001,
    ///The resource will be accessed as an array of 1D textures.
    D3D11_DSV_DIMENSION_TEXTURE1DARRAY   = 0x00000002,
    ///The resource will be accessed as a 2D texture.
    D3D11_DSV_DIMENSION_TEXTURE2D        = 0x00000003,
    ///The resource will be accessed as an array of 2D textures.
    D3D11_DSV_DIMENSION_TEXTURE2DARRAY   = 0x00000004,
    ///The resource will be accessed as a 2D texture with multisampling.
    D3D11_DSV_DIMENSION_TEXTURE2DMS      = 0x00000005,
    ///The resource will be accessed as an array of 2D textures with multisampling.
    D3D11_DSV_DIMENSION_TEXTURE2DMSARRAY = 0x00000006,
}

///These flags identify the type of resource that will be viewed as a render target.
alias D3D11_RTV_DIMENSION = int;
enum : int
{
    ///Do not use this value, as it will cause ID3D11Device::CreateRenderTargetView to fail.
    D3D11_RTV_DIMENSION_UNKNOWN          = 0x00000000,
    ///The resource will be accessed as a buffer.
    D3D11_RTV_DIMENSION_BUFFER           = 0x00000001,
    ///The resource will be accessed as a 1D texture.
    D3D11_RTV_DIMENSION_TEXTURE1D        = 0x00000002,
    ///The resource will be accessed as an array of 1D textures.
    D3D11_RTV_DIMENSION_TEXTURE1DARRAY   = 0x00000003,
    ///The resource will be accessed as a 2D texture.
    D3D11_RTV_DIMENSION_TEXTURE2D        = 0x00000004,
    ///The resource will be accessed as an array of 2D textures.
    D3D11_RTV_DIMENSION_TEXTURE2DARRAY   = 0x00000005,
    ///The resource will be accessed as a 2D texture with multisampling.
    D3D11_RTV_DIMENSION_TEXTURE2DMS      = 0x00000006,
    ///The resource will be accessed as an array of 2D textures with multisampling.
    D3D11_RTV_DIMENSION_TEXTURE2DMSARRAY = 0x00000007,
    ///The resource will be accessed as a 3D texture.
    D3D11_RTV_DIMENSION_TEXTURE3D        = 0x00000008,
}

///Unordered-access view options.
alias D3D11_UAV_DIMENSION = int;
enum : int
{
    ///The view type is unknown.
    D3D11_UAV_DIMENSION_UNKNOWN        = 0x00000000,
    ///View the resource as a buffer.
    D3D11_UAV_DIMENSION_BUFFER         = 0x00000001,
    ///View the resource as a 1D texture.
    D3D11_UAV_DIMENSION_TEXTURE1D      = 0x00000002,
    ///View the resource as a 1D texture array.
    D3D11_UAV_DIMENSION_TEXTURE1DARRAY = 0x00000003,
    ///View the resource as a 2D texture.
    D3D11_UAV_DIMENSION_TEXTURE2D      = 0x00000004,
    ///View the resource as a 2D texture array.
    D3D11_UAV_DIMENSION_TEXTURE2DARRAY = 0x00000005,
    ///View the resource as a 3D texture array.
    D3D11_UAV_DIMENSION_TEXTURE3D      = 0x00000008,
}

///Identifies expected resource use during rendering. The usage directly reflects whether a resource is accessible by
///the CPU and/or the graphics processing unit (GPU).
alias D3D11_USAGE = int;
enum : int
{
    ///A resource that requires read and write access by the GPU. This is likely to be the most common usage choice.
    D3D11_USAGE_DEFAULT   = 0x00000000,
    ///A resource that can only be read by the GPU. It cannot be written by the GPU, and cannot be accessed at all by
    ///the CPU. This type of resource must be initialized when it is created, since it cannot be changed after creation.
    D3D11_USAGE_IMMUTABLE = 0x00000001,
    ///A resource that is accessible by both the GPU (read only) and the CPU (write only). A dynamic resource is a good
    ///choice for a resource that will be updated by the CPU at least once per frame. To update a dynamic resource, use
    ///a <b>Map</b> method. For info about how to use dynamic resources, see How to: Use dynamic resources.
    D3D11_USAGE_DYNAMIC   = 0x00000002,
    ///A resource that supports data transfer (copy) from the GPU to the CPU.
    D3D11_USAGE_STAGING   = 0x00000003,
}

///Identifies how to bind a resource to the pipeline.
alias D3D11_BIND_FLAG = int;
enum : int
{
    ///Bind a buffer as a vertex buffer to the input-assembler stage.
    D3D11_BIND_VERTEX_BUFFER    = 0x00000001,
    ///Bind a buffer as an index buffer to the input-assembler stage.
    D3D11_BIND_INDEX_BUFFER     = 0x00000002,
    ///Bind a buffer as a constant buffer to a shader stage; this flag may NOT be combined with any other bind flag.
    D3D11_BIND_CONSTANT_BUFFER  = 0x00000004,
    ///Bind a buffer or texture to a shader stage; this flag cannot be used with the D3D11_MAP_WRITE_NO_OVERWRITE flag.
    ///<div class="alert"><b>Note</b> The Direct3D 11.1 runtime, which is available starting with Windows 8, enables
    ///mapping dynamic constant buffers and shader resource views (SRVs) of dynamic buffers with
    ///D3D11_MAP_WRITE_NO_OVERWRITE. The Direct3D 11 and earlier runtimes limited mapping to vertex or index buffers. To
    ///determine if a Direct3D device supports these features, call ID3D11Device::CheckFeatureSupport with
    ///D3D11_FEATURE_D3D11_OPTIONS. <b>CheckFeatureSupport</b> fills members of a D3D11_FEATURE_DATA_D3D11_OPTIONS
    ///structure with the device's features. The relevant members here are <b>MapNoOverwriteOnDynamicConstantBuffer</b>
    ///and <b>MapNoOverwriteOnDynamicBufferSRV</b>.</div> <div> </div>
    D3D11_BIND_SHADER_RESOURCE  = 0x00000008,
    ///Bind an output buffer for the stream-output stage.
    D3D11_BIND_STREAM_OUTPUT    = 0x00000010,
    ///Bind a texture as a render target for the output-merger stage.
    D3D11_BIND_RENDER_TARGET    = 0x00000020,
    ///Bind a texture as a depth-stencil target for the output-merger stage.
    D3D11_BIND_DEPTH_STENCIL    = 0x00000040,
    ///Bind an unordered access resource.
    D3D11_BIND_UNORDERED_ACCESS = 0x00000080,
    ///Set this flag to indicate that a 2D texture is used to receive output from the decoder API. The common way to
    ///create resources for a decoder output is by calling the ID3D11Device::CreateTexture2D method to create an array
    ///of 2D textures. However, you cannot use texture arrays that are created with this flag in calls to
    ///ID3D11Device::CreateShaderResourceView. <b>Direct3D 11: </b>This value is not supported until Direct3D 11.1.
    D3D11_BIND_DECODER          = 0x00000200,
    ///Set this flag to indicate that a 2D texture is used to receive input from the video encoder API. The common way
    ///to create resources for a video encoder is by calling the ID3D11Device::CreateTexture2D method to create an array
    ///of 2D textures. However, you cannot use texture arrays that are created with this flag in calls to
    ///ID3D11Device::CreateShaderResourceView. <b>Direct3D 11: </b>This value is not supported until Direct3D 11.1.
    D3D11_BIND_VIDEO_ENCODER    = 0x00000400,
}

///Specifies the types of CPU access allowed for a resource.
alias D3D11_CPU_ACCESS_FLAG = int;
enum : int
{
    ///The resource is to be mappable so that the CPU can change its contents. Resources created with this flag cannot
    ///be set as outputs of the pipeline and must be created with either dynamic or staging usage (see D3D11_USAGE).
    D3D11_CPU_ACCESS_WRITE = 0x00010000,
    ///The resource is to be mappable so that the CPU can read its contents. Resources created with this flag cannot be
    ///set as either inputs or outputs to the pipeline and must be created with staging usage (see D3D11_USAGE).
    D3D11_CPU_ACCESS_READ  = 0x00020000,
}

///Identifies options for resources.
alias D3D11_RESOURCE_MISC_FLAG = int;
enum : int
{
    ///Enables MIP map generation by using ID3D11DeviceContext::GenerateMips on a texture resource. The resource must be
    ///created with the bind flags that specify that the resource is a render target and a shader resource.
    D3D11_RESOURCE_MISC_GENERATE_MIPS                   = 0x00000001,
    ///Enables resource data sharing between two or more Direct3D devices. The only resources that can be shared are 2D
    ///non-mipmapped textures. <b>D3D11_RESOURCE_MISC_SHARED</b> and <b>D3D11_RESOURCE_MISC_SHARED_KEYEDMUTEX</b> are
    ///mutually exclusive. <b>WARP</b> and <b>REF</b> devices do not support shared resources. If you try to create a
    ///resource with this flag on either a <b>WARP</b> or <b>REF</b> device, the create method will return an
    ///<b>E_OUTOFMEMORY</b> error code. <div class="alert"><b>Note</b> Starting with Windows 8, <b>WARP</b> devices
    ///fully support shared resources. </div> <div> </div> <div class="alert"><b>Note</b> Starting with Windows 8, we
    ///recommend that you enable resource data sharing between two or more Direct3D devices by using a combination of
    ///the D3D11_RESOURCE_MISC_SHARED_NTHANDLE and D3D11_RESOURCE_MISC_SHARED_KEYEDMUTEX flags instead. </div> <div>
    ///</div>
    D3D11_RESOURCE_MISC_SHARED                          = 0x00000002,
    ///Sets a resource to be a cube texture created from a Texture2DArray that contains 6 textures.
    D3D11_RESOURCE_MISC_TEXTURECUBE                     = 0x00000004,
    ///Enables instancing of GPU-generated content.
    D3D11_RESOURCE_MISC_DRAWINDIRECT_ARGS               = 0x00000010,
    ///Enables a resource as a byte address buffer.
    D3D11_RESOURCE_MISC_BUFFER_ALLOW_RAW_VIEWS          = 0x00000020,
    ///Enables a resource as a structured buffer.
    D3D11_RESOURCE_MISC_BUFFER_STRUCTURED               = 0x00000040,
    ///Enables a resource with MIP map clamping for use with ID3D11DeviceContext::SetResourceMinLOD.
    D3D11_RESOURCE_MISC_RESOURCE_CLAMP                  = 0x00000080,
    ///Enables the resource to be synchronized by using the IDXGIKeyedMutex::AcquireSync and
    ///IDXGIKeyedMutex::ReleaseSync APIs. The following Direct3D 11 resource creation APIs, that take
    ///D3D11_RESOURCE_MISC_FLAG parameters, have been extended to support the new flag. <ul> <li>
    ///ID3D11Device::CreateTexture1D </li> <li> ID3D11Device::CreateTexture2D </li> <li> ID3D11Device::CreateTexture3D
    ///</li> <li> ID3D11Device::CreateBuffer </li> </ul> If you call any of these methods with the
    ///<b>D3D11_RESOURCE_MISC_SHARED_KEYEDMUTEX</b> flag set, the interface returned will support the IDXGIKeyedMutex
    ///interface. You can retrieve a pointer to the <b>IDXGIKeyedMutex</b> interface from the resource by using
    ///IUnknown::QueryInterface. The <b>IDXGIKeyedMutex</b> interface implements the IDXGIKeyedMutex::AcquireSync and
    ///IDXGIKeyedMutex::ReleaseSync APIs to synchronize access to the surface. The device that creates the surface, and
    ///any other device that opens the surface by using OpenSharedResource, must call
    ///<b>IDXGIKeyedMutex::AcquireSync</b> before they issue any rendering commands to the surface. When those devices
    ///finish rendering, they must call <b>IDXGIKeyedMutex::ReleaseSync</b>. <b>D3D11_RESOURCE_MISC_SHARED</b> and
    ///<b>D3D11_RESOURCE_MISC_SHARED_KEYEDMUTEX</b> are mutually exclusive. <b>WARP</b> and <b>REF</b> devices do not
    ///support shared resources. If you try to create a resource with this flag on either a <b>WARP</b> or <b>REF</b>
    ///device, the create method will return an <b>E_OUTOFMEMORY</b> error code. <div class="alert"><b>Note</b> Starting
    ///with Windows 8, <b>WARP</b> devices fully support shared resources. </div> <div> </div>
    D3D11_RESOURCE_MISC_SHARED_KEYEDMUTEX               = 0x00000100,
    ///Enables a resource compatible with GDI. You must set the <b>D3D11_RESOURCE_MISC_GDI_COMPATIBLE</b> flag on
    ///surfaces that you use with GDI. Setting the <b>D3D11_RESOURCE_MISC_GDI_COMPATIBLE</b> flag allows GDI rendering
    ///on the surface via IDXGISurface1::GetDC. Consider the following programming tips for using
    ///D3D11_RESOURCE_MISC_GDI_COMPATIBLE when you create a texture or use that texture in a swap chain: <ul>
    ///<li>D3D11_RESOURCE_MISC_SHARED_KEYEDMUTEX and D3D11_RESOURCE_MISC_GDI_COMPATIBLE are mutually exclusive.
    ///Therefore, do not use them together.</li> <li>D3D11_RESOURCE_MISC_RESOURCE_CLAMP and
    ///D3D11_RESOURCE_MISC_GDI_COMPATIBLE are mutually exclusive. Therefore, do not use them together.</li> <li>You must
    ///bind the texture as a render target for the output-merger stage. For example, set the D3D11_BIND_RENDER_TARGET
    ///flag in the <b>BindFlags</b> member of the D3D11_TEXTURE2D_DESC structure. </li> <li>You must set the maximum
    ///number of MIP map levels to 1. For example, set the <b>MipLevels</b> member of the D3D11_TEXTURE2D_DESC structure
    ///to 1. </li> <li>You must specify that the texture requires read and write access by the GPU. For example, set the
    ///<b>Usage</b> member of the D3D11_TEXTURE2D_DESC structure to D3D11_USAGE_DEFAULT. </li> <li> You must set the
    ///texture format to one of the following types. <ul> <li>DXGI_FORMAT_B8G8R8A8_UNORM</li>
    ///<li>DXGI_FORMAT_B8G8R8A8_TYPELESS</li> <li>DXGI_FORMAT_B8G8R8A8_UNORM_SRGB</li> </ul>For example, set the
    ///<b>Format</b> member of the D3D11_TEXTURE2D_DESC structure to one of these types. </li> <li>You cannot use
    ///D3D11_RESOURCE_MISC_GDI_COMPATIBLE with multisampling. Therefore, set the <b>Count</b> member of the
    ///DXGI_SAMPLE_DESC structure to 1. Then, set the <b>SampleDesc</b> member of the D3D11_TEXTURE2D_DESC structure to
    ///this <b>DXGI_SAMPLE_DESC</b> structure. </li> </ul>
    D3D11_RESOURCE_MISC_GDI_COMPATIBLE                  = 0x00000200,
    ///Set this flag to enable the use of NT HANDLE values when you create a shared resource. By enabling this flag, you
    ///deprecate the use of existing HANDLE values. The value specifies a new shared resource type that directs the
    ///runtime to use NT HANDLE values for the shared resource. The runtime then must confirm that the shared resource
    ///works on all hardware at the specified feature level. Without this flag set, the runtime does not strictly
    ///validate shared resource parameters (that is, formats, flags, usage, and so on). When the runtime does not
    ///validate shared resource parameters, behavior of much of the Direct3D API might be undefined and might vary from
    ///driver to driver. <b>Direct3D 11 and earlier: </b>This value is not supported until Direct3D 11.1.
    D3D11_RESOURCE_MISC_SHARED_NTHANDLE                 = 0x00000800,
    ///Set this flag to indicate that the resource might contain protected content; therefore, the operating system
    ///should use the resource only when the driver and hardware support content protection. If the driver and hardware
    ///do not support content protection and you try to create a resource with this flag, the resource creation fails.
    ///<b>Direct3D 11: </b>This value is not supported until Direct3D 11.1.
    D3D11_RESOURCE_MISC_RESTRICTED_CONTENT              = 0x00001000,
    ///Set this flag to indicate that the operating system restricts access to the shared surface. You can use this flag
    ///together with the D3D11_RESOURCE_MISC_RESTRICT_SHARED_RESOURCE_DRIVER flag and only when you create a shared
    ///surface. The process that creates the shared resource can always open the shared resource. <b>Direct3D 11:
    ///</b>This value is not supported until Direct3D 11.1.
    D3D11_RESOURCE_MISC_RESTRICT_SHARED_RESOURCE        = 0x00002000,
    ///Set this flag to indicate that the driver restricts access to the shared surface. You can use this flag in
    ///conjunction with the D3D11_RESOURCE_MISC_RESTRICT_SHARED_RESOURCE flag and only when you create a shared surface.
    ///The process that creates the shared resource can always open the shared resource. <b>Direct3D 11: </b>This value
    ///is not supported until Direct3D 11.1.
    D3D11_RESOURCE_MISC_RESTRICT_SHARED_RESOURCE_DRIVER = 0x00004000,
    ///Set this flag to indicate that the resource is guarded. Such a resource is returned by the
    ///IDCompositionSurface::BeginDraw (DirectComposition) and ISurfaceImageSourceNative::BeginDraw (Windows Runtime)
    ///APIs. For these APIs, you provide a region of interest (ROI) on a surface to update. This surface isn't
    ///compatible with multiple render targets (MRT). A guarded resource automatically restricts all writes to the
    ///region that is related to one of the preceding APIs. Additionally, the resource enforces access to the ROI with
    ///these restrictions: <ul> <li>Copy operations from the resource by using ID3D11DeviceContext::CopyResource or
    ///ID3D11DeviceContext::CopySubresourceRegion are restricted to only copy from the ROI. </li> <li>When a guarded
    ///resource is set as a render target, it must be the only target.</li> </ul> <b>Direct3D 11: </b>This value is not
    ///supported until Direct3D 11.1.
    D3D11_RESOURCE_MISC_GUARDED                         = 0x00008000,
    ///Set this flag to indicate that the resource is a tile pool. <b>Direct3D 11: </b>This value is not supported until
    ///Direct3D 11.2.
    D3D11_RESOURCE_MISC_TILE_POOL                       = 0x00020000,
    ///Set this flag to indicate that the resource is a tiled resource. <b>Direct3D 11: </b>This value is not supported
    ///until Direct3D 11.2.
    D3D11_RESOURCE_MISC_TILED                           = 0x00040000,
    ///Set this flag to indicate that the resource should be created such that it will be protected by the hardware.
    ///Resource creation will fail if hardware content protection is not supported. This flag has the following
    ///restrictions: <ul> <li>This flag cannot be used with the following D3D11_USAGE values:<ul>
    ///<li><b>D3D11_USAGE_DYNAMIC</b></li> <li><b>D3D11_USAGE_STAGING</b></li> </ul> </li> <li>This flag cannot be used
    ///with the following D3D11_BIND_FLAG values.<ul> <li><b>D3D11_BIND_VERTEX_BUFFER</b></li>
    ///<li><b>D3D11_BIND_INDEX_BUFFER</b></li> </ul> </li> <li>No CPU access flags can be specified.</li> </ul> <div
    ///class="alert"><b>Note</b> <p class="note">Creating a texture using this flag does not automatically guarantee
    ///that hardware protection will be enabled for the underlying allocation. Some implementations require that the DRM
    ///components are first initialized prior to any guarantees of protection. </div> <div> </div> <b>Note</b> This
    ///enumeration value is supported starting with Windows 10.
    D3D11_RESOURCE_MISC_HW_PROTECTED                    = 0x00080000,
}

///Identifies a resource to be accessed for reading and writing by the CPU. Applications may combine one or more of
///these flags.
alias D3D11_MAP = int;
enum : int
{
    ///Resource is mapped for reading. The resource must have been created with read access (see D3D11_CPU_ACCESS_READ).
    D3D11_MAP_READ               = 0x00000001,
    ///Resource is mapped for writing. The resource must have been created with write access (see
    ///D3D11_CPU_ACCESS_WRITE).
    D3D11_MAP_WRITE              = 0x00000002,
    ///Resource is mapped for reading and writing. The resource must have been created with read and write access (see
    ///D3D11_CPU_ACCESS_READ and D3D11_CPU_ACCESS_WRITE).
    D3D11_MAP_READ_WRITE         = 0x00000003,
    ///Resource is mapped for writing; the previous contents of the resource will be undefined. The resource must have
    ///been created with write access and dynamic usage (See D3D11_CPU_ACCESS_WRITE and D3D11_USAGE_DYNAMIC).
    D3D11_MAP_WRITE_DISCARD      = 0x00000004,
    ///Resource is mapped for writing; the existing contents of the resource cannot be overwritten (see Remarks). This
    ///flag is only valid on vertex and index buffers. The resource must have been created with write access (see
    ///D3D11_CPU_ACCESS_WRITE). Cannot be used on a resource created with the D3D11_BIND_CONSTANT_BUFFER flag. <div
    ///class="alert"><b>Note</b> The Direct3D 11.1 runtime, which is available starting with Windows 8, enables mapping
    ///dynamic constant buffers and shader resource views (SRVs) of dynamic buffers with D3D11_MAP_WRITE_NO_OVERWRITE.
    ///The Direct3D 11 and earlier runtimes limited mapping to vertex or index buffers. To determine if a Direct3D
    ///device supports these features, call ID3D11Device::CheckFeatureSupport with D3D11_FEATURE_D3D11_OPTIONS.
    ///<b>CheckFeatureSupport</b> fills members of a D3D11_FEATURE_DATA_D3D11_OPTIONS structure with the device's
    ///features. The relevant members here are <b>MapNoOverwriteOnDynamicConstantBuffer</b> and
    ///<b>MapNoOverwriteOnDynamicBufferSRV</b>.</div> <div> </div>
    D3D11_MAP_WRITE_NO_OVERWRITE = 0x00000005,
}

///Specifies how the CPU should respond when an application calls the ID3D11DeviceContext::Map method on a resource that
///is being used by the GPU.
alias D3D11_MAP_FLAG = int;
enum : int
{
    ///Specifies that ID3D11DeviceContext::Map should return DXGI_ERROR_WAS_STILL_DRAWING when the GPU blocks the CPU
    ///from accessing a resource. For more information about this error code, see DXGI_ERROR.
    D3D11_MAP_FLAG_DO_NOT_WAIT = 0x00100000,
}

///Option(s) for raising an error to a non-continuable exception.
alias D3D11_RAISE_FLAG = int;
enum : int
{
    ///Raise an internal driver error to a non-continuable exception.
    D3D11_RAISE_FLAG_DRIVER_INTERNAL_ERROR = 0x00000001,
}

///Specifies the parts of the depth stencil to clear.
alias D3D11_CLEAR_FLAG = int;
enum : int
{
    ///Clear the depth buffer, using fast clear if possible, then place the resource in a compressed state.
    D3D11_CLEAR_DEPTH   = 0x00000001,
    ///Clear the stencil buffer, using fast clear if possible, then place the resource in a compressed state.
    D3D11_CLEAR_STENCIL = 0x00000002,
}

///Comparison options.
alias D3D11_COMPARISON_FUNC = int;
enum : int
{
    ///Never pass the comparison.
    D3D11_COMPARISON_NEVER         = 0x00000001,
    ///If the source data is less than the destination data, the comparison passes.
    D3D11_COMPARISON_LESS          = 0x00000002,
    ///If the source data is equal to the destination data, the comparison passes.
    D3D11_COMPARISON_EQUAL         = 0x00000003,
    ///If the source data is less than or equal to the destination data, the comparison passes.
    D3D11_COMPARISON_LESS_EQUAL    = 0x00000004,
    ///If the source data is greater than the destination data, the comparison passes.
    D3D11_COMPARISON_GREATER       = 0x00000005,
    ///If the source data is not equal to the destination data, the comparison passes.
    D3D11_COMPARISON_NOT_EQUAL     = 0x00000006,
    ///If the source data is greater than or equal to the destination data, the comparison passes.
    D3D11_COMPARISON_GREATER_EQUAL = 0x00000007,
    ///Always pass the comparison.
    D3D11_COMPARISON_ALWAYS        = 0x00000008,
}

///Identify the portion of a depth-stencil buffer for writing depth data.
alias D3D11_DEPTH_WRITE_MASK = int;
enum : int
{
    ///Turn off writes to the depth-stencil buffer.
    D3D11_DEPTH_WRITE_MASK_ZERO = 0x00000000,
    ///Turn on writes to the depth-stencil buffer.
    D3D11_DEPTH_WRITE_MASK_ALL  = 0x00000001,
}

///The stencil operations that can be performed during depth-stencil testing.
alias D3D11_STENCIL_OP = int;
enum : int
{
    ///Keep the existing stencil data.
    D3D11_STENCIL_OP_KEEP     = 0x00000001,
    ///Set the stencil data to 0.
    D3D11_STENCIL_OP_ZERO     = 0x00000002,
    ///Set the stencil data to the reference value set by calling ID3D11DeviceContext::OMSetDepthStencilState.
    D3D11_STENCIL_OP_REPLACE  = 0x00000003,
    ///Increment the stencil value by 1, and clamp the result.
    D3D11_STENCIL_OP_INCR_SAT = 0x00000004,
    ///Decrement the stencil value by 1, and clamp the result.
    D3D11_STENCIL_OP_DECR_SAT = 0x00000005,
    ///Invert the stencil data.
    D3D11_STENCIL_OP_INVERT   = 0x00000006,
    ///Increment the stencil value by 1, and wrap the result if necessary.
    D3D11_STENCIL_OP_INCR     = 0x00000007,
    ///Decrement the stencil value by 1, and wrap the result if necessary.
    D3D11_STENCIL_OP_DECR     = 0x00000008,
}

///Blend factors, which modulate values for the pixel shader and render target.
alias D3D11_BLEND = int;
enum : int
{
    ///The blend factor is (0, 0, 0, 0). No pre-blend operation.
    D3D11_BLEND_ZERO             = 0x00000001,
    ///The blend factor is (1, 1, 1, 1). No pre-blend operation.
    D3D11_BLEND_ONE              = 0x00000002,
    ///The blend factor is (Rₛ, Gₛ, Bₛ, Aₛ), that is color data (RGB) from a pixel shader. No pre-blend
    ///operation.
    D3D11_BLEND_SRC_COLOR        = 0x00000003,
    ///The blend factor is (1 - Rₛ, 1 - Gₛ, 1 - Bₛ, 1 - Aₛ), that is color data (RGB) from a pixel shader. The
    ///pre-blend operation inverts the data, generating 1 - RGB.
    D3D11_BLEND_INV_SRC_COLOR    = 0x00000004,
    ///The blend factor is (Aₛ, Aₛ, Aₛ, Aₛ), that is alpha data (A) from a pixel shader. No pre-blend operation.
    D3D11_BLEND_SRC_ALPHA        = 0x00000005,
    ///The blend factor is ( 1 - Aₛ, 1 - Aₛ, 1 - Aₛ, 1 - Aₛ), that is alpha data (A) from a pixel shader. The
    ///pre-blend operation inverts the data, generating 1 - A.
    D3D11_BLEND_INV_SRC_ALPHA    = 0x00000006,
    ///The blend factor is (A<sub>d</sub> A<sub>d</sub> A<sub>d</sub> A<sub>d</sub>), that is alpha data from a render
    ///target. No pre-blend operation.
    D3D11_BLEND_DEST_ALPHA       = 0x00000007,
    ///The blend factor is (1 - A<sub>d</sub> 1 - A<sub>d</sub> 1 - A<sub>d</sub> 1 - A<sub>d</sub>), that is alpha data
    ///from a render target. The pre-blend operation inverts the data, generating 1 - A.
    D3D11_BLEND_INV_DEST_ALPHA   = 0x00000008,
    ///The blend factor is (R<sub>d</sub>, G<sub>d</sub>, B<sub>d</sub>, A<sub>d</sub>), that is color data from a
    ///render target. No pre-blend operation.
    D3D11_BLEND_DEST_COLOR       = 0x00000009,
    ///The blend factor is (1 - R<sub>d</sub>, 1 - G<sub>d</sub>, 1 - B<sub>d</sub>, 1 - A<sub>d</sub>), that is color
    ///data from a render target. The pre-blend operation inverts the data, generating 1 - RGB.
    D3D11_BLEND_INV_DEST_COLOR   = 0x0000000a,
    ///The blend factor is (f, f, f, 1); where f = min(Aₛ, 1 - A<sub>d</sub>). The pre-blend operation clamps the data
    ///to 1 or less.
    D3D11_BLEND_SRC_ALPHA_SAT    = 0x0000000b,
    ///The blend factor is the blend factor set with ID3D11DeviceContext::OMSetBlendState. No pre-blend operation.
    D3D11_BLEND_BLEND_FACTOR     = 0x0000000e,
    ///The blend factor is the blend factor set with ID3D11DeviceContext::OMSetBlendState. The pre-blend operation
    ///inverts the blend factor, generating 1 - blend_factor.
    D3D11_BLEND_INV_BLEND_FACTOR = 0x0000000f,
    ///The blend factor is data sources both as color data output by a pixel shader. There is no pre-blend operation.
    ///This blend factor supports dual-source color blending.
    D3D11_BLEND_SRC1_COLOR       = 0x00000010,
    ///The blend factor is data sources both as color data output by a pixel shader. The pre-blend operation inverts the
    ///data, generating 1 - RGB. This blend factor supports dual-source color blending.
    D3D11_BLEND_INV_SRC1_COLOR   = 0x00000011,
    ///The blend factor is data sources as alpha data output by a pixel shader. There is no pre-blend operation. This
    ///blend factor supports dual-source color blending.
    D3D11_BLEND_SRC1_ALPHA       = 0x00000012,
    ///The blend factor is data sources as alpha data output by a pixel shader. The pre-blend operation inverts the
    ///data, generating 1 - A. This blend factor supports dual-source color blending.
    D3D11_BLEND_INV_SRC1_ALPHA   = 0x00000013,
}

///RGB or alpha blending operation.
alias D3D11_BLEND_OP = int;
enum : int
{
    ///Add source 1 and source 2.
    D3D11_BLEND_OP_ADD          = 0x00000001,
    ///Subtract source 1 from source 2.
    D3D11_BLEND_OP_SUBTRACT     = 0x00000002,
    ///Subtract source 2 from source 1.
    D3D11_BLEND_OP_REV_SUBTRACT = 0x00000003,
    ///Find the minimum of source 1 and source 2.
    D3D11_BLEND_OP_MIN          = 0x00000004,
    ///Find the maximum of source 1 and source 2.
    D3D11_BLEND_OP_MAX          = 0x00000005,
}

///Identify which components of each pixel of a render target are writable during blending.
alias D3D11_COLOR_WRITE_ENABLE = int;
enum : int
{
    ///Allow data to be stored in the red component.
    D3D11_COLOR_WRITE_ENABLE_RED   = 0x00000001,
    ///Allow data to be stored in the green component.
    D3D11_COLOR_WRITE_ENABLE_GREEN = 0x00000002,
    ///Allow data to be stored in the blue component.
    D3D11_COLOR_WRITE_ENABLE_BLUE  = 0x00000004,
    ///Allow data to be stored in the alpha component.
    D3D11_COLOR_WRITE_ENABLE_ALPHA = 0x00000008,
    ///Allow data to be stored in all components.
    D3D11_COLOR_WRITE_ENABLE_ALL   = 0x0000000f,
}

///The different faces of a cube texture.
alias D3D11_TEXTURECUBE_FACE = int;
enum : int
{
    ///Positive X face.
    D3D11_TEXTURECUBE_FACE_POSITIVE_X = 0x00000000,
    ///Negative X face.
    D3D11_TEXTURECUBE_FACE_NEGATIVE_X = 0x00000001,
    ///Positive Y face.
    D3D11_TEXTURECUBE_FACE_POSITIVE_Y = 0x00000002,
    ///Negative Y face.
    D3D11_TEXTURECUBE_FACE_NEGATIVE_Y = 0x00000003,
    ///Positive Z face.
    D3D11_TEXTURECUBE_FACE_POSITIVE_Z = 0x00000004,
    ///Negative Z face.
    D3D11_TEXTURECUBE_FACE_NEGATIVE_Z = 0x00000005,
}

///Identifies how to view a buffer resource.
alias D3D11_BUFFEREX_SRV_FLAG = int;
enum : int
{
    ///View the buffer as raw. For more info about raw viewing of buffers, see Raw Views of Buffers.
    D3D11_BUFFEREX_SRV_FLAG_RAW = 0x00000001,
}

///Depth-stencil view options.
alias D3D11_DSV_FLAG = int;
enum : int
{
    ///Indicates that depth values are read only.
    D3D11_DSV_READ_ONLY_DEPTH   = 0x00000001,
    ///Indicates that stencil values are read only.
    D3D11_DSV_READ_ONLY_STENCIL = 0x00000002,
}

///Identifies unordered-access view options for a buffer resource.
alias D3D11_BUFFER_UAV_FLAG = int;
enum : int
{
    ///Resource contains raw, unstructured data. Requires the UAV format to be DXGI_FORMAT_R32_TYPELESS. For more info
    ///about raw viewing of buffers, see Raw Views of Buffers.
    D3D11_BUFFER_UAV_FLAG_RAW     = 0x00000001,
    ///Allow data to be appended to the end of the buffer. <b>D3D11_BUFFER_UAV_FLAG_APPEND</b> flag must also be used
    ///for any view that will be used as a AppendStructuredBuffer or a ConsumeStructuredBuffer. Requires the UAV format
    ///to be DXGI_FORMAT_UNKNOWN.
    D3D11_BUFFER_UAV_FLAG_APPEND  = 0x00000002,
    ///Adds a counter to the unordered-access-view buffer. <b>D3D11_BUFFER_UAV_FLAG_COUNTER</b> can only be used on a
    ///UAV that is a RWStructuredBuffer and it enables the functionality needed for the IncrementCounterand
    ///DecrementCounter methods in HLSL. Requires the UAV format to be DXGI_FORMAT_UNKNOWN.
    D3D11_BUFFER_UAV_FLAG_COUNTER = 0x00000004,
}

///Filtering options during texture sampling.
alias D3D11_FILTER = int;
enum : int
{
    ///Use point sampling for minification, magnification, and mip-level sampling.
    D3D11_FILTER_MIN_MAG_MIP_POINT                          = 0x00000000,
    ///Use point sampling for minification and magnification; use linear interpolation for mip-level sampling.
    D3D11_FILTER_MIN_MAG_POINT_MIP_LINEAR                   = 0x00000001,
    ///Use point sampling for minification; use linear interpolation for magnification; use point sampling for mip-level
    ///sampling.
    D3D11_FILTER_MIN_POINT_MAG_LINEAR_MIP_POINT             = 0x00000004,
    ///Use point sampling for minification; use linear interpolation for magnification and mip-level sampling.
    D3D11_FILTER_MIN_POINT_MAG_MIP_LINEAR                   = 0x00000005,
    ///Use linear interpolation for minification; use point sampling for magnification and mip-level sampling.
    D3D11_FILTER_MIN_LINEAR_MAG_MIP_POINT                   = 0x00000010,
    ///Use linear interpolation for minification; use point sampling for magnification; use linear interpolation for
    ///mip-level sampling.
    D3D11_FILTER_MIN_LINEAR_MAG_POINT_MIP_LINEAR            = 0x00000011,
    ///Use linear interpolation for minification and magnification; use point sampling for mip-level sampling.
    D3D11_FILTER_MIN_MAG_LINEAR_MIP_POINT                   = 0x00000014,
    ///Use linear interpolation for minification, magnification, and mip-level sampling.
    D3D11_FILTER_MIN_MAG_MIP_LINEAR                         = 0x00000015,
    ///Use anisotropic interpolation for minification, magnification, and mip-level sampling.
    D3D11_FILTER_ANISOTROPIC                                = 0x00000055,
    ///Use point sampling for minification, magnification, and mip-level sampling. Compare the result to the comparison
    ///value.
    D3D11_FILTER_COMPARISON_MIN_MAG_MIP_POINT               = 0x00000080,
    ///Use point sampling for minification and magnification; use linear interpolation for mip-level sampling. Compare
    ///the result to the comparison value.
    D3D11_FILTER_COMPARISON_MIN_MAG_POINT_MIP_LINEAR        = 0x00000081,
    ///Use point sampling for minification; use linear interpolation for magnification; use point sampling for mip-level
    ///sampling. Compare the result to the comparison value.
    D3D11_FILTER_COMPARISON_MIN_POINT_MAG_LINEAR_MIP_POINT  = 0x00000084,
    ///Use point sampling for minification; use linear interpolation for magnification and mip-level sampling. Compare
    ///the result to the comparison value.
    D3D11_FILTER_COMPARISON_MIN_POINT_MAG_MIP_LINEAR        = 0x00000085,
    ///Use linear interpolation for minification; use point sampling for magnification and mip-level sampling. Compare
    ///the result to the comparison value.
    D3D11_FILTER_COMPARISON_MIN_LINEAR_MAG_MIP_POINT        = 0x00000090,
    ///Use linear interpolation for minification; use point sampling for magnification; use linear interpolation for
    ///mip-level sampling. Compare the result to the comparison value.
    D3D11_FILTER_COMPARISON_MIN_LINEAR_MAG_POINT_MIP_LINEAR = 0x00000091,
    ///Use linear interpolation for minification and magnification; use point sampling for mip-level sampling. Compare
    ///the result to the comparison value.
    D3D11_FILTER_COMPARISON_MIN_MAG_LINEAR_MIP_POINT        = 0x00000094,
    ///Use linear interpolation for minification, magnification, and mip-level sampling. Compare the result to the
    ///comparison value.
    D3D11_FILTER_COMPARISON_MIN_MAG_MIP_LINEAR              = 0x00000095,
    ///Use anisotropic interpolation for minification, magnification, and mip-level sampling. Compare the result to the
    ///comparison value.
    D3D11_FILTER_COMPARISON_ANISOTROPIC                     = 0x000000d5,
    ///Fetch the same set of texels as D3D11_FILTER_MIN_MAG_MIP_POINT and instead of filtering them return the minimum
    ///of the texels. Texels that are weighted 0 during filtering aren't counted towards the minimum. You can query
    ///support for this filter type from the <b>MinMaxFiltering</b> member in the D3D11_FEATURE_DATA_D3D11_OPTIONS1
    ///structure.
    D3D11_FILTER_MINIMUM_MIN_MAG_MIP_POINT                  = 0x00000100,
    ///Fetch the same set of texels as D3D11_FILTER_MIN_MAG_POINT_MIP_LINEAR and instead of filtering them return the
    ///minimum of the texels. Texels that are weighted 0 during filtering aren't counted towards the minimum. You can
    ///query support for this filter type from the <b>MinMaxFiltering</b> member in the
    ///D3D11_FEATURE_DATA_D3D11_OPTIONS1 structure.
    D3D11_FILTER_MINIMUM_MIN_MAG_POINT_MIP_LINEAR           = 0x00000101,
    ///Fetch the same set of texels as D3D11_FILTER_MIN_POINT_MAG_LINEAR_MIP_POINT and instead of filtering them return
    ///the minimum of the texels. Texels that are weighted 0 during filtering aren't counted towards the minimum. You
    ///can query support for this filter type from the <b>MinMaxFiltering</b> member in the
    ///D3D11_FEATURE_DATA_D3D11_OPTIONS1 structure.
    D3D11_FILTER_MINIMUM_MIN_POINT_MAG_LINEAR_MIP_POINT     = 0x00000104,
    ///Fetch the same set of texels as D3D11_FILTER_MIN_POINT_MAG_MIP_LINEAR and instead of filtering them return the
    ///minimum of the texels. Texels that are weighted 0 during filtering aren't counted towards the minimum. You can
    ///query support for this filter type from the <b>MinMaxFiltering</b> member in the
    ///D3D11_FEATURE_DATA_D3D11_OPTIONS1 structure.
    D3D11_FILTER_MINIMUM_MIN_POINT_MAG_MIP_LINEAR           = 0x00000105,
    ///Fetch the same set of texels as D3D11_FILTER_MIN_LINEAR_MAG_MIP_POINT and instead of filtering them return the
    ///minimum of the texels. Texels that are weighted 0 during filtering aren't counted towards the minimum. You can
    ///query support for this filter type from the <b>MinMaxFiltering</b> member in the
    ///D3D11_FEATURE_DATA_D3D11_OPTIONS1 structure.
    D3D11_FILTER_MINIMUM_MIN_LINEAR_MAG_MIP_POINT           = 0x00000110,
    ///Fetch the same set of texels as D3D11_FILTER_MIN_LINEAR_MAG_POINT_MIP_LINEAR and instead of filtering them return
    ///the minimum of the texels. Texels that are weighted 0 during filtering aren't counted towards the minimum. You
    ///can query support for this filter type from the <b>MinMaxFiltering</b> member in the
    ///D3D11_FEATURE_DATA_D3D11_OPTIONS1 structure.
    D3D11_FILTER_MINIMUM_MIN_LINEAR_MAG_POINT_MIP_LINEAR    = 0x00000111,
    ///Fetch the same set of texels as D3D11_FILTER_MIN_MAG_LINEAR_MIP_POINT and instead of filtering them return the
    ///minimum of the texels. Texels that are weighted 0 during filtering aren't counted towards the minimum. You can
    ///query support for this filter type from the <b>MinMaxFiltering</b> member in the
    ///D3D11_FEATURE_DATA_D3D11_OPTIONS1 structure.
    D3D11_FILTER_MINIMUM_MIN_MAG_LINEAR_MIP_POINT           = 0x00000114,
    ///Fetch the same set of texels as D3D11_FILTER_MIN_MAG_MIP_LINEAR and instead of filtering them return the minimum
    ///of the texels. Texels that are weighted 0 during filtering aren't counted towards the minimum. You can query
    ///support for this filter type from the <b>MinMaxFiltering</b> member in the D3D11_FEATURE_DATA_D3D11_OPTIONS1
    ///structure.
    D3D11_FILTER_MINIMUM_MIN_MAG_MIP_LINEAR                 = 0x00000115,
    ///Fetch the same set of texels as D3D11_FILTER_ANISOTROPIC and instead of filtering them return the minimum of the
    ///texels. Texels that are weighted 0 during filtering aren't counted towards the minimum. You can query support for
    ///this filter type from the <b>MinMaxFiltering</b> member in the D3D11_FEATURE_DATA_D3D11_OPTIONS1 structure.
    D3D11_FILTER_MINIMUM_ANISOTROPIC                        = 0x00000155,
    ///Fetch the same set of texels as D3D11_FILTER_MIN_MAG_MIP_POINT and instead of filtering them return the maximum
    ///of the texels. Texels that are weighted 0 during filtering aren't counted towards the maximum. You can query
    ///support for this filter type from the <b>MinMaxFiltering</b> member in the D3D11_FEATURE_DATA_D3D11_OPTIONS1
    ///structure.
    D3D11_FILTER_MAXIMUM_MIN_MAG_MIP_POINT                  = 0x00000180,
    ///Fetch the same set of texels as D3D11_FILTER_MIN_MAG_POINT_MIP_LINEAR and instead of filtering them return the
    ///maximum of the texels. Texels that are weighted 0 during filtering aren't counted towards the maximum. You can
    ///query support for this filter type from the <b>MinMaxFiltering</b> member in the
    ///D3D11_FEATURE_DATA_D3D11_OPTIONS1 structure.
    D3D11_FILTER_MAXIMUM_MIN_MAG_POINT_MIP_LINEAR           = 0x00000181,
    ///Fetch the same set of texels as D3D11_FILTER_MIN_POINT_MAG_LINEAR_MIP_POINT and instead of filtering them return
    ///the maximum of the texels. Texels that are weighted 0 during filtering aren't counted towards the maximum. You
    ///can query support for this filter type from the <b>MinMaxFiltering</b> member in the
    ///D3D11_FEATURE_DATA_D3D11_OPTIONS1 structure.
    D3D11_FILTER_MAXIMUM_MIN_POINT_MAG_LINEAR_MIP_POINT     = 0x00000184,
    ///Fetch the same set of texels as D3D11_FILTER_MIN_POINT_MAG_MIP_LINEAR and instead of filtering them return the
    ///maximum of the texels. Texels that are weighted 0 during filtering aren't counted towards the maximum. You can
    ///query support for this filter type from the <b>MinMaxFiltering</b> member in the
    ///D3D11_FEATURE_DATA_D3D11_OPTIONS1 structure.
    D3D11_FILTER_MAXIMUM_MIN_POINT_MAG_MIP_LINEAR           = 0x00000185,
    ///Fetch the same set of texels as D3D11_FILTER_MIN_LINEAR_MAG_MIP_POINT and instead of filtering them return the
    ///maximum of the texels. Texels that are weighted 0 during filtering aren't counted towards the maximum. You can
    ///query support for this filter type from the <b>MinMaxFiltering</b> member in the
    ///D3D11_FEATURE_DATA_D3D11_OPTIONS1 structure.
    D3D11_FILTER_MAXIMUM_MIN_LINEAR_MAG_MIP_POINT           = 0x00000190,
    ///Fetch the same set of texels as D3D11_FILTER_MIN_LINEAR_MAG_POINT_MIP_LINEAR and instead of filtering them return
    ///the maximum of the texels. Texels that are weighted 0 during filtering aren't counted towards the maximum. You
    ///can query support for this filter type from the <b>MinMaxFiltering</b> member in the
    ///D3D11_FEATURE_DATA_D3D11_OPTIONS1 structure.
    D3D11_FILTER_MAXIMUM_MIN_LINEAR_MAG_POINT_MIP_LINEAR    = 0x00000191,
    ///Fetch the same set of texels as D3D11_FILTER_MIN_MAG_LINEAR_MIP_POINT and instead of filtering them return the
    ///maximum of the texels. Texels that are weighted 0 during filtering aren't counted towards the maximum. You can
    ///query support for this filter type from the <b>MinMaxFiltering</b> member in the
    ///D3D11_FEATURE_DATA_D3D11_OPTIONS1 structure.
    D3D11_FILTER_MAXIMUM_MIN_MAG_LINEAR_MIP_POINT           = 0x00000194,
    ///Fetch the same set of texels as D3D11_FILTER_MIN_MAG_MIP_LINEAR and instead of filtering them return the maximum
    ///of the texels. Texels that are weighted 0 during filtering aren't counted towards the maximum. You can query
    ///support for this filter type from the <b>MinMaxFiltering</b> member in the D3D11_FEATURE_DATA_D3D11_OPTIONS1
    ///structure.
    D3D11_FILTER_MAXIMUM_MIN_MAG_MIP_LINEAR                 = 0x00000195,
    ///Fetch the same set of texels as D3D11_FILTER_ANISOTROPIC and instead of filtering them return the maximum of the
    ///texels. Texels that are weighted 0 during filtering aren't counted towards the maximum. You can query support for
    ///this filter type from the <b>MinMaxFiltering</b> member in the D3D11_FEATURE_DATA_D3D11_OPTIONS1 structure.
    D3D11_FILTER_MAXIMUM_ANISOTROPIC                        = 0x000001d5,
}

///Types of magnification or minification sampler filters.
alias D3D11_FILTER_TYPE = int;
enum : int
{
    ///Point filtering used as a texture magnification or minification filter. The texel with coordinates nearest to the
    ///desired pixel value is used. The texture filter to be used between mipmap levels is nearest-point mipmap
    ///filtering. The rasterizer uses the color from the texel of the nearest mipmap texture.
    D3D11_FILTER_TYPE_POINT  = 0x00000000,
    ///Bilinear interpolation filtering used as a texture magnification or minification filter. A weighted average of a
    ///2 x 2 area of texels surrounding the desired pixel is used. The texture filter to use between mipmap levels is
    ///trilinear mipmap interpolation. The rasterizer linearly interpolates pixel color, using the texels of the two
    ///nearest mipmap textures.
    D3D11_FILTER_TYPE_LINEAR = 0x00000001,
}

///Specifies the type of sampler filter reduction.
alias D3D11_FILTER_REDUCTION_TYPE = int;
enum : int
{
    ///Indicates standard (default) filter reduction.
    D3D11_FILTER_REDUCTION_TYPE_STANDARD   = 0x00000000,
    ///Indicates a comparison filter reduction.
    D3D11_FILTER_REDUCTION_TYPE_COMPARISON = 0x00000001,
    ///Indicates minimum filter reduction.
    D3D11_FILTER_REDUCTION_TYPE_MINIMUM    = 0x00000002,
    ///Indicates maximum filter reduction.
    D3D11_FILTER_REDUCTION_TYPE_MAXIMUM    = 0x00000003,
}

///Identify a technique for resolving texture coordinates that are outside of the boundaries of a texture.
alias D3D11_TEXTURE_ADDRESS_MODE = int;
enum : int
{
    ///Tile the texture at every (u,v) integer junction. For example, for u values between 0 and 3, the texture is
    ///repeated three times.
    D3D11_TEXTURE_ADDRESS_WRAP        = 0x00000001,
    ///Flip the texture at every (u,v) integer junction. For u values between 0 and 1, for example, the texture is
    ///addressed normally; between 1 and 2, the texture is flipped (mirrored); between 2 and 3, the texture is normal
    ///again; and so on.
    D3D11_TEXTURE_ADDRESS_MIRROR      = 0x00000002,
    ///Texture coordinates outside the range [0.0, 1.0] are set to the texture color at 0.0 or 1.0, respectively.
    D3D11_TEXTURE_ADDRESS_CLAMP       = 0x00000003,
    ///Texture coordinates outside the range [0.0, 1.0] are set to the border color specified in D3D11_SAMPLER_DESC or
    ///HLSL code.
    D3D11_TEXTURE_ADDRESS_BORDER      = 0x00000004,
    ///Similar to D3D11_TEXTURE_ADDRESS_MIRROR and D3D11_TEXTURE_ADDRESS_CLAMP. Takes the absolute value of the texture
    ///coordinate (thus, mirroring around 0), and then clamps to the maximum value.
    D3D11_TEXTURE_ADDRESS_MIRROR_ONCE = 0x00000005,
}

///Which resources are supported for a given format and given device (see ID3D11Device::CheckFormatSupport and
///ID3D11Device::CheckFeatureSupport).
alias D3D11_FORMAT_SUPPORT = int;
enum : int
{
    ///Buffer resources supported.
    D3D11_FORMAT_SUPPORT_BUFFER                      = 0x00000001,
    ///Vertex buffers supported.
    D3D11_FORMAT_SUPPORT_IA_VERTEX_BUFFER            = 0x00000002,
    ///Index buffers supported.
    D3D11_FORMAT_SUPPORT_IA_INDEX_BUFFER             = 0x00000004,
    ///Streaming output buffers supported.
    D3D11_FORMAT_SUPPORT_SO_BUFFER                   = 0x00000008,
    ///1D texture resources supported.
    D3D11_FORMAT_SUPPORT_TEXTURE1D                   = 0x00000010,
    ///2D texture resources supported.
    D3D11_FORMAT_SUPPORT_TEXTURE2D                   = 0x00000020,
    ///3D texture resources supported.
    D3D11_FORMAT_SUPPORT_TEXTURE3D                   = 0x00000040,
    ///Cube texture resources supported.
    D3D11_FORMAT_SUPPORT_TEXTURECUBE                 = 0x00000080,
    ///The HLSL Load function for texture objects is supported.
    D3D11_FORMAT_SUPPORT_SHADER_LOAD                 = 0x00000100,
    ///The HLSL Sample function for texture objects is supported. <div class="alert"><b>Note</b> If the device supports
    ///the format as a resource (1D, 2D, 3D, or cube map) but doesn't support this option, the resource can still use
    ///the Sample method but must use only the point filtering sampler state to perform the sample.</div> <div> </div>
    D3D11_FORMAT_SUPPORT_SHADER_SAMPLE               = 0x00000200,
    ///The HLSL SampleCmp and SampleCmpLevelZero functions for texture objects are supported. <div
    ///class="alert"><b>Note</b> Windows 8 and later might provide limited support for these functions on Direct3D
    ///feature levels 9_1, 9_2, and 9_3. For more info, see Implementing shadow buffers for Direct3D feature level 9.
    ///</div> <div> </div>
    D3D11_FORMAT_SUPPORT_SHADER_SAMPLE_COMPARISON    = 0x00000400,
    ///Reserved.
    D3D11_FORMAT_SUPPORT_SHADER_SAMPLE_MONO_TEXT     = 0x00000800,
    ///Mipmaps are supported.
    D3D11_FORMAT_SUPPORT_MIP                         = 0x00001000,
    ///Automatic generation of mipmaps is supported.
    D3D11_FORMAT_SUPPORT_MIP_AUTOGEN                 = 0x00002000,
    ///Render targets are supported.
    D3D11_FORMAT_SUPPORT_RENDER_TARGET               = 0x00004000,
    ///Blend operations supported.
    D3D11_FORMAT_SUPPORT_BLENDABLE                   = 0x00008000,
    ///Depth stencils supported.
    D3D11_FORMAT_SUPPORT_DEPTH_STENCIL               = 0x00010000,
    ///CPU locking supported.
    D3D11_FORMAT_SUPPORT_CPU_LOCKABLE                = 0x00020000,
    ///Multisample antialiasing (MSAA) resolve operations are supported. For more info, see
    ///ID3D11DeviceContex::ResolveSubresource.
    D3D11_FORMAT_SUPPORT_MULTISAMPLE_RESOLVE         = 0x00040000,
    ///Format can be displayed on screen.
    D3D11_FORMAT_SUPPORT_DISPLAY                     = 0x00080000,
    ///Format cannot be cast to another format.
    D3D11_FORMAT_SUPPORT_CAST_WITHIN_BIT_LAYOUT      = 0x00100000,
    ///Format can be used as a multisampled rendertarget.
    D3D11_FORMAT_SUPPORT_MULTISAMPLE_RENDERTARGET    = 0x00200000,
    ///Format can be used as a multisampled texture and read into a shader with the HLSL load function.
    D3D11_FORMAT_SUPPORT_MULTISAMPLE_LOAD            = 0x00400000,
    ///Format can be used with the HLSL gather function. This value is available in DirectX 10.1 or higher.
    D3D11_FORMAT_SUPPORT_SHADER_GATHER               = 0x00800000,
    ///Format supports casting when the resource is a back buffer.
    D3D11_FORMAT_SUPPORT_BACK_BUFFER_CAST            = 0x01000000,
    ///Format can be used for an unordered access view.
    D3D11_FORMAT_SUPPORT_TYPED_UNORDERED_ACCESS_VIEW = 0x02000000,
    ///Format can be used with the HLSL gather with comparison function.
    D3D11_FORMAT_SUPPORT_SHADER_GATHER_COMPARISON    = 0x04000000,
    ///Format can be used with the decoder output. <b>Direct3D 11: </b>This value is not supported until Direct3D 11.1.
    D3D11_FORMAT_SUPPORT_DECODER_OUTPUT              = 0x08000000,
    ///Format can be used with the video processor output. <b>Direct3D 11: </b>This value is not supported until
    ///Direct3D 11.1.
    D3D11_FORMAT_SUPPORT_VIDEO_PROCESSOR_OUTPUT      = 0x10000000,
    ///Format can be used with the video processor input. <b>Direct3D 11: </b>This value is not supported until Direct3D
    ///11.1.
    D3D11_FORMAT_SUPPORT_VIDEO_PROCESSOR_INPUT       = 0x20000000,
    ///Format can be used with the video encoder. <b>Direct3D 11: </b>This value is not supported until Direct3D 11.1.
    D3D11_FORMAT_SUPPORT_VIDEO_ENCODER               = 0x40000000,
}

///Unordered resource support options for a compute shader resource (see ID3D11Device::CheckFeatureSupport).
alias D3D11_FORMAT_SUPPORT2 = int;
enum : int
{
    ///Format supports atomic add.
    D3D11_FORMAT_SUPPORT2_UAV_ATOMIC_ADD                               = 0x00000001,
    ///Format supports atomic bitwise operations.
    D3D11_FORMAT_SUPPORT2_UAV_ATOMIC_BITWISE_OPS                       = 0x00000002,
    ///Format supports atomic compare with store or exchange.
    D3D11_FORMAT_SUPPORT2_UAV_ATOMIC_COMPARE_STORE_OR_COMPARE_EXCHANGE = 0x00000004,
    ///Format supports atomic exchange.
    D3D11_FORMAT_SUPPORT2_UAV_ATOMIC_EXCHANGE                          = 0x00000008,
    ///Format supports atomic min and max.
    D3D11_FORMAT_SUPPORT2_UAV_ATOMIC_SIGNED_MIN_OR_MAX                 = 0x00000010,
    ///Format supports atomic unsigned min and max.
    D3D11_FORMAT_SUPPORT2_UAV_ATOMIC_UNSIGNED_MIN_OR_MAX               = 0x00000020,
    ///Format supports a typed load.
    D3D11_FORMAT_SUPPORT2_UAV_TYPED_LOAD                               = 0x00000040,
    ///Format supports a typed store.
    D3D11_FORMAT_SUPPORT2_UAV_TYPED_STORE                              = 0x00000080,
    ///Format supports logic operations in blend state. <b>Direct3D 11: </b>This value is not supported until Direct3D
    ///11.1.
    D3D11_FORMAT_SUPPORT2_OUTPUT_MERGER_LOGIC_OP                       = 0x00000100,
    ///Format supports tiled resources. <b>Direct3D 11: </b>This value is not supported until Direct3D 11.2.
    D3D11_FORMAT_SUPPORT2_TILED                                        = 0x00000200,
    ///Format supports shareable resources. <div class="alert"><b>Note</b> DXGI_FORMAT_R8G8B8A8_UNORM and
    ///<b>DXGI_FORMAT_R8G8B8A8_UNORM_SRGB</b> are never shareable when using feature level 9, even if the device
    ///indicates optional feature support for <b>D3D11_FORMAT_SUPPORT_SHAREABLE</b>. Attempting to create shared
    ///resources with DXGI formats <b>DXGI_FORMAT_R8G8B8A8_UNORM</b> and <b>DXGI_FORMAT_R8G8B8A8_UNORM_SRGB</b> will
    ///always fail unless the feature level is 10_0 or higher. </div> <div> </div> <b>Direct3D 11: </b>This value is not
    ///supported until Direct3D 11.2.
    D3D11_FORMAT_SUPPORT2_SHAREABLE                                    = 0x00000400,
    ///Format supports multi-plane overlays.
    D3D11_FORMAT_SUPPORT2_MULTIPLANE_OVERLAY                           = 0x00004000,
}

///Optional flags that control the behavior of ID3D11DeviceContext::GetData.
alias D3D11_ASYNC_GETDATA_FLAG = int;
enum : int
{
    ///Do not flush the command buffer. This can potentially cause an infinite loop if GetData is continually called
    ///until it returns S_OK as there may still be commands in the command buffer that need to be processed in order for
    ///GetData to return S_OK. Since the commands in the command buffer are not flushed they will not be processed and
    ///therefore GetData will never return S_OK.
    D3D11_ASYNC_GETDATA_DONOTFLUSH = 0x00000001,
}

///Query types.
alias D3D11_QUERY = int;
enum : int
{
    ///Determines whether or not the GPU is finished processing commands. When the GPU is finished processing commands
    ///ID3D11DeviceContext::GetData will return S_OK, and pData will point to a BOOL with a value of <b>TRUE</b>. When
    ///using this type of query, ID3D11DeviceContext::Begin is disabled.
    D3D11_QUERY_EVENT                         = 0x00000000,
    ///Get the number of samples that passed the depth and stencil tests in between ID3D11DeviceContext::Begin and
    ///ID3D11DeviceContext::End. ID3D11DeviceContext::GetData returns a UINT64. If a depth or stencil test is disabled,
    ///then each of those tests will be counted as a pass.
    D3D11_QUERY_OCCLUSION                     = 0x00000001,
    ///Get a timestamp value where ID3D11DeviceContext::GetData returns a UINT64. This kind of query is only useful if
    ///two timestamp queries are done in the middle of a D3D11_QUERY_TIMESTAMP_DISJOINT query. The difference of two
    ///timestamps can be used to determine how many ticks have elapsed, and the D3D11_QUERY_TIMESTAMP_DISJOINT query
    ///will determine if that difference is a reliable value and also has a value that shows how to convert the number
    ///of ticks into seconds. See D3D11_QUERY_DATA_TIMESTAMP_DISJOINT. When using this type of query,
    ///ID3D11DeviceContext::Begin is disabled.
    D3D11_QUERY_TIMESTAMP                     = 0x00000002,
    ///Determines whether or not a D3D11_QUERY_TIMESTAMP is returning reliable values, and also gives the frequency of
    ///the processor enabling you to convert the number of elapsed ticks into seconds. ID3D11DeviceContext::GetData will
    ///return a D3D11_QUERY_DATA_TIMESTAMP_DISJOINT. This type of query should only be invoked once per frame or less.
    D3D11_QUERY_TIMESTAMP_DISJOINT            = 0x00000003,
    ///Get pipeline statistics, such as the number of pixel shader invocations in between ID3D11DeviceContext::Begin and
    ///ID3D11DeviceContext::End. ID3D11DeviceContext::GetData will return a D3D11_QUERY_DATA_PIPELINE_STATISTICS.
    D3D11_QUERY_PIPELINE_STATISTICS           = 0x00000004,
    ///Similar to D3D11_QUERY_OCCLUSION, except ID3D11DeviceContext::GetData returns a BOOL indicating whether or not
    ///any samples passed the depth and stencil tests - <b>TRUE</b> meaning at least one passed, <b>FALSE</b> meaning
    ///none passed.
    D3D11_QUERY_OCCLUSION_PREDICATE           = 0x00000005,
    ///Get streaming output statistics, such as the number of primitives streamed out in between
    ///ID3D11DeviceContext::Begin and ID3D11DeviceContext::End. ID3D11DeviceContext::GetData will return a
    ///D3D11_QUERY_DATA_SO_STATISTICS structure.
    D3D11_QUERY_SO_STATISTICS                 = 0x00000006,
    ///Determines whether or not any of the streaming output buffers overflowed in between ID3D11DeviceContext::Begin
    ///and ID3D11DeviceContext::End. ID3D11DeviceContext::GetData returns a BOOL - <b>TRUE</b> meaning there was an
    ///overflow, <b>FALSE</b> meaning there was not an overflow. If streaming output writes to multiple buffers, and one
    ///of the buffers overflows, then it will stop writing to all the output buffers. When an overflow is detected by
    ///Direct3D it is prevented from happening - no memory is corrupted. This predication may be used in conjunction
    ///with an SO_STATISTICS query so that when an overflow occurs the SO_STATISTIC query will let the application know
    ///how much memory was needed to prevent an overflow.
    D3D11_QUERY_SO_OVERFLOW_PREDICATE         = 0x00000007,
    ///Get streaming output statistics for stream 0, such as the number of primitives streamed out in between
    ///ID3D11DeviceContext::Begin and ID3D11DeviceContext::End. ID3D11DeviceContext::GetData will return a
    ///D3D11_QUERY_DATA_SO_STATISTICS structure.
    D3D11_QUERY_SO_STATISTICS_STREAM0         = 0x00000008,
    ///Determines whether or not the stream 0 output buffers overflowed in between ID3D11DeviceContext::Begin and
    ///ID3D11DeviceContext::End. ID3D11DeviceContext::GetData returns a BOOL - <b>TRUE</b> meaning there was an
    ///overflow, <b>FALSE</b> meaning there was not an overflow. If streaming output writes to multiple buffers, and one
    ///of the buffers overflows, then it will stop writing to all the output buffers. When an overflow is detected by
    ///Direct3D it is prevented from happening - no memory is corrupted. This predication may be used in conjunction
    ///with an SO_STATISTICS query so that when an overflow occurs the SO_STATISTIC query will let the application know
    ///how much memory was needed to prevent an overflow.
    D3D11_QUERY_SO_OVERFLOW_PREDICATE_STREAM0 = 0x00000009,
    ///Get streaming output statistics for stream 1, such as the number of primitives streamed out in between
    ///ID3D11DeviceContext::Begin and ID3D11DeviceContext::End. ID3D11DeviceContext::GetData will return a
    ///D3D11_QUERY_DATA_SO_STATISTICS structure.
    D3D11_QUERY_SO_STATISTICS_STREAM1         = 0x0000000a,
    ///Determines whether or not the stream 1 output buffers overflowed in between ID3D11DeviceContext::Begin and
    ///ID3D11DeviceContext::End. ID3D11DeviceContext::GetData returns a BOOL - <b>TRUE</b> meaning there was an
    ///overflow, <b>FALSE</b> meaning there was not an overflow. If streaming output writes to multiple buffers, and one
    ///of the buffers overflows, then it will stop writing to all the output buffers. When an overflow is detected by
    ///Direct3D it is prevented from happening - no memory is corrupted. This predication may be used in conjunction
    ///with an SO_STATISTICS query so that when an overflow occurs the SO_STATISTIC query will let the application know
    ///how much memory was needed to prevent an overflow.
    D3D11_QUERY_SO_OVERFLOW_PREDICATE_STREAM1 = 0x0000000b,
    ///Get streaming output statistics for stream 2, such as the number of primitives streamed out in between
    ///ID3D11DeviceContext::Begin and ID3D11DeviceContext::End. ID3D11DeviceContext::GetData will return a
    ///D3D11_QUERY_DATA_SO_STATISTICS structure.
    D3D11_QUERY_SO_STATISTICS_STREAM2         = 0x0000000c,
    ///Determines whether or not the stream 2 output buffers overflowed in between ID3D11DeviceContext::Begin and
    ///ID3D11DeviceContext::End. ID3D11DeviceContext::GetData returns a BOOL - <b>TRUE</b> meaning there was an
    ///overflow, <b>FALSE</b> meaning there was not an overflow. If streaming output writes to multiple buffers, and one
    ///of the buffers overflows, then it will stop writing to all the output buffers. When an overflow is detected by
    ///Direct3D it is prevented from happening - no memory is corrupted. This predication may be used in conjunction
    ///with an SO_STATISTICS query so that when an overflow occurs the SO_STATISTIC query will let the application know
    ///how much memory was needed to prevent an overflow.
    D3D11_QUERY_SO_OVERFLOW_PREDICATE_STREAM2 = 0x0000000d,
    ///Get streaming output statistics for stream 3, such as the number of primitives streamed out in between
    ///ID3D11DeviceContext::Begin and ID3D11DeviceContext::End. ID3D11DeviceContext::GetData will return a
    ///D3D11_QUERY_DATA_SO_STATISTICS structure.
    D3D11_QUERY_SO_STATISTICS_STREAM3         = 0x0000000e,
    ///Determines whether or not the stream 3 output buffers overflowed in between ID3D11DeviceContext::Begin and
    ///ID3D11DeviceContext::End. ID3D11DeviceContext::GetData returns a BOOL - <b>TRUE</b> meaning there was an
    ///overflow, <b>FALSE</b> meaning there was not an overflow. If streaming output writes to multiple buffers, and one
    ///of the buffers overflows, then it will stop writing to all the output buffers. When an overflow is detected by
    ///Direct3D it is prevented from happening - no memory is corrupted. This predication may be used in conjunction
    ///with an SO_STATISTICS query so that when an overflow occurs the SO_STATISTIC query will let the application know
    ///how much memory was needed to prevent an overflow.
    D3D11_QUERY_SO_OVERFLOW_PREDICATE_STREAM3 = 0x0000000f,
}

///Flags that describe miscellaneous query behavior.
alias D3D11_QUERY_MISC_FLAG = int;
enum : int
{
    ///Tell the hardware that if it is not yet sure if something is hidden or not to draw it anyway. This is only used
    ///with an occlusion predicate. Predication data cannot be returned to your application via
    ///ID3D11DeviceContext::GetData when using this flag.
    D3D11_QUERY_MISC_PREDICATEHINT = 0x00000001,
}

///Options for performance counters.
alias D3D11_COUNTER = int;
enum : int
{
    ///Define a performance counter that is dependent on the hardware device.
    D3D11_COUNTER_DEVICE_DEPENDENT_0 = 0x40000000,
}

///Data type of a performance counter.
alias D3D11_COUNTER_TYPE = int;
enum : int
{
    ///32-bit floating point.
    D3D11_COUNTER_TYPE_FLOAT32 = 0x00000000,
    ///16-bit unsigned integer.
    D3D11_COUNTER_TYPE_UINT16  = 0x00000001,
    ///32-bit unsigned integer.
    D3D11_COUNTER_TYPE_UINT32  = 0x00000002,
    ///64-bit unsigned integer.
    D3D11_COUNTER_TYPE_UINT64  = 0x00000003,
}

///Specifies a multi-sample pattern type.
alias D3D11_STANDARD_MULTISAMPLE_QUALITY_LEVELS = int;
enum : int
{
    ///Pre-defined multi-sample patterns required for Direct3D 11 and Direct3D 10.1 hardware.
    D3D11_STANDARD_MULTISAMPLE_PATTERN = 0xffffffff,
    ///Pattern where all of the samples are located at the pixel center.
    D3D11_CENTER_MULTISAMPLE_PATTERN   = 0xfffffffe,
}

///Device context options.
alias D3D11_DEVICE_CONTEXT_TYPE = int;
enum : int
{
    ///The device context is an immediate context.
    D3D11_DEVICE_CONTEXT_IMMEDIATE = 0x00000000,
    ///The device context is a deferred context.
    D3D11_DEVICE_CONTEXT_DEFERRED  = 0x00000001,
}

///Direct3D 11 feature options.
alias D3D11_FEATURE = int;
enum : int
{
    ///The driver supports multithreading. To see an example of testing a driver for multithread support, see How To:
    ///Check for Driver Support. Refer to D3D11_FEATURE_DATA_THREADING.
    D3D11_FEATURE_THREADING                      = 0x00000000,
    ///Supports the use of the double-precision shaders in HLSL. Refer to D3D11_FEATURE_DATA_DOUBLES.
    D3D11_FEATURE_DOUBLES                        = 0x00000001,
    ///Supports the formats in D3D11_FORMAT_SUPPORT. Refer to D3D11_FEATURE_DATA_FORMAT_SUPPORT.
    D3D11_FEATURE_FORMAT_SUPPORT                 = 0x00000002,
    ///Supports the formats in D3D11_FORMAT_SUPPORT2. Refer to D3D11_FEATURE_DATA_FORMAT_SUPPORT2.
    D3D11_FEATURE_FORMAT_SUPPORT2                = 0x00000003,
    ///Supports compute shaders and raw and structured buffers. Refer to D3D11_FEATURE_DATA_D3D10_X_HARDWARE_OPTIONS.
    D3D11_FEATURE_D3D10_X_HARDWARE_OPTIONS       = 0x00000004,
    ///Supports Direct3D 11.1 feature options. Refer to D3D11_FEATURE_DATA_D3D11_OPTIONS. <b>Direct3D 11: </b>This value
    ///is not supported until Direct3D 11.1.
    D3D11_FEATURE_D3D11_OPTIONS                  = 0x00000005,
    ///Supports specific adapter architecture. Refer to D3D11_FEATURE_DATA_ARCHITECTURE_INFO. <b>Direct3D 11: </b>This
    ///value is not supported until Direct3D 11.1.
    D3D11_FEATURE_ARCHITECTURE_INFO              = 0x00000006,
    ///Supports Direct3D 9 feature options. Refer to D3D11_FEATURE_DATA_D3D9_OPTIONS. <b>Direct3D 11: </b>This value is
    ///not supported until Direct3D 11.1.
    D3D11_FEATURE_D3D9_OPTIONS                   = 0x00000007,
    ///Supports minimum precision of shaders. For more info about HLSL minimum precision, see using HLSL minimum
    ///precision. Refer to D3D11_FEATURE_DATA_SHADER_MIN_PRECISION_SUPPORT. <b>Direct3D 11: </b>This value is not
    ///supported until Direct3D 11.1.
    D3D11_FEATURE_SHADER_MIN_PRECISION_SUPPORT   = 0x00000008,
    ///Supports Direct3D 9 shadowing feature. Refer to D3D11_FEATURE_DATA_D3D9_SHADOW_SUPPORT. <b>Direct3D 11: </b>This
    ///value is not supported until Direct3D 11.1.
    D3D11_FEATURE_D3D9_SHADOW_SUPPORT            = 0x00000009,
    ///Supports Direct3D 11.2 feature options. Refer to D3D11_FEATURE_DATA_D3D11_OPTIONS1. <b>Direct3D 11: </b>This
    ///value is not supported until Direct3D 11.2.
    D3D11_FEATURE_D3D11_OPTIONS1                 = 0x0000000a,
    ///Supports Direct3D 11.2 instancing options. Refer to D3D11_FEATURE_DATA_D3D9_SIMPLE_INSTANCING_SUPPORT.
    ///<b>Direct3D 11: </b>This value is not supported until Direct3D 11.2.
    D3D11_FEATURE_D3D9_SIMPLE_INSTANCING_SUPPORT = 0x0000000b,
    ///Supports Direct3D 11.2 marker options. Refer to D3D11_FEATURE_DATA_MARKER_SUPPORT. <b>Direct3D 11: </b>This value
    ///is not supported until Direct3D 11.2.
    D3D11_FEATURE_MARKER_SUPPORT                 = 0x0000000c,
    ///Supports Direct3D 9 feature options, which includes the Direct3D 9 shadowing feature and instancing support.
    ///Refer to D3D11_FEATURE_DATA_D3D9_OPTIONS1. <b>Direct3D 11: </b>This value is not supported until Direct3D 11.2.
    D3D11_FEATURE_D3D9_OPTIONS1                  = 0x0000000d,
    ///Supports Direct3D 11.3 conservative rasterization feature options. Refer to D3D11_FEATURE_DATA_D3D11_OPTIONS2.
    ///<b>Direct3D 11: </b>This value is not supported until Direct3D 11.3.
    D3D11_FEATURE_D3D11_OPTIONS2                 = 0x0000000e,
    ///Supports Direct3D 11.4 conservative rasterization feature options. Refer to D3D11_FEATURE_DATA_D3D11_OPTIONS3.
    ///<b>Direct3D 11: </b>This value is not supported until Direct3D 11.4.
    D3D11_FEATURE_D3D11_OPTIONS3                 = 0x0000000f,
    ///Supports GPU virtual addresses. Refer to D3D11_FEATURE_DATA_GPU_VIRTUAL_ADDRESS_SUPPORT.
    D3D11_FEATURE_GPU_VIRTUAL_ADDRESS_SUPPORT    = 0x00000010,
    ///Supports a single boolean for NV12 shared textures. Refer to D3D11_FEATURE_DATA_D3D11_OPTIONS4. <b>Direct3D 11:
    ///</b>This value is not supported until Direct3D 11.4.
    D3D11_FEATURE_D3D11_OPTIONS4                 = 0x00000011,
    ///Supports shader cache, described in D3D11_FEATURE_DATA_SHADER_CACHE.
    D3D11_FEATURE_SHADER_CACHE                   = 0x00000012,
    ///Supports a D3D11_SHARED_RESOURCE_TIER to indicate a tier for shared resource support. Refer to
    ///D3D11_FEATURE_DATA_D3D11_OPTIONS5.
    D3D11_FEATURE_D3D11_OPTIONS5                 = 0x00000013,
}

///<div class="alert"><b>Note</b> This enumeration is supported by the Direct3D 11.1 runtime, which is available on
///Windows 8 and later operating systems.</div><div> </div>Values that specify minimum precision levels at shader
///stages.
alias D3D11_SHADER_MIN_PRECISION_SUPPORT = int;
enum : int
{
    ///Minimum precision level is 10-bit.
    D3D11_SHADER_MIN_PRECISION_10_BIT = 0x00000001,
    ///Minimum precision level is 16-bit.
    D3D11_SHADER_MIN_PRECISION_16_BIT = 0x00000002,
}

///Indicates the tier level at which tiled resources are supported.
alias D3D11_TILED_RESOURCES_TIER = int;
enum : int
{
    ///Tiled resources are not supported.
    D3D11_TILED_RESOURCES_NOT_SUPPORTED = 0x00000000,
    ///Tier_1 tiled resources are supported. The device supports calls to CreateTexture2D and so on with the
    ///D3D11_RESOURCE_MISC_TILED flag. The device supports calls to CreateBuffer with the D3D11_RESOURCE_MISC_TILE_POOL
    ///flag. If you access tiles (read or write) that are <b>NULL</b>-mapped, you get undefined behavior, which includes
    ///device-removed. Apps can map all tiles to a single "default" tile to avoid this condition.
    D3D11_TILED_RESOURCES_TIER_1        = 0x00000001,
    ///Tier_2 tiled resources are supported. Superset of Tier_1 functionality, which includes this additional support:
    ///<ul> <li>On Tier_1, if the size of a texture mipmap level is an integer multiple of the standard tile shape for
    ///its format, it is guaranteed to be nonpacked. On Tier_2, this guarantee is expanded to include mipmap levels
    ///whose size is at least one standard tile shape. For more info, see D3D11_PACKED_MIP_DESC. </li> <li>Shader
    ///instructions are available for clamping level-of-detail (LOD) and for obtaining status about the shader
    ///operation. For info about one of these shader instructions, see Sample(S,float,int,float,uint). </li> <li>Reading
    ///from <b>NULL</b>-mapped tiles treat that sampled value as zero. Writes to <b>NULL</b>-mapped tiles are discarded.
    ///</li> </ul>
    D3D11_TILED_RESOURCES_TIER_2        = 0x00000002,
    ///Tier_3 tiled resources are supported. Superset of Tier_2 functionality, Tier 3 is essentially Tier 2 but with the
    ///additional support of Texture3D for Tiled Resources.
    D3D11_TILED_RESOURCES_TIER_3        = 0x00000003,
}

///Specifies if the hardware and driver support conservative rasterization and at what tier level.
alias D3D11_CONSERVATIVE_RASTERIZATION_TIER = int;
enum : int
{
    ///Conservative rasterization isn't supported.
    D3D11_CONSERVATIVE_RASTERIZATION_NOT_SUPPORTED = 0x00000000,
    ///Tier_1 conservative rasterization is supported.
    D3D11_CONSERVATIVE_RASTERIZATION_TIER_1        = 0x00000001,
    ///Tier_2 conservative rasterization is supported.
    D3D11_CONSERVATIVE_RASTERIZATION_TIER_2        = 0x00000002,
    ///Tier_3 conservative rasterization is supported.
    D3D11_CONSERVATIVE_RASTERIZATION_TIER_3        = 0x00000003,
}

///Describes the level of support for shader caching in the current graphics driver.
alias D3D11_SHADER_CACHE_SUPPORT_FLAGS = int;
enum : int
{
    ///Indicates that the driver does not support shader caching.
    D3D11_SHADER_CACHE_SUPPORT_NONE                   = 0x00000000,
    ///Indicates that the driver supports an OS-managed shader cache that stores compiled shaders in memory during the
    ///current run of the application.
    D3D11_SHADER_CACHE_SUPPORT_AUTOMATIC_INPROC_CACHE = 0x00000001,
    ///Indicates that the driver supports an OS-managed shader cache that stores compiled shaders on disk to accelerate
    ///future runs of the application.
    D3D11_SHADER_CACHE_SUPPORT_AUTOMATIC_DISK_CACHE   = 0x00000002,
}

///Defines constants that specify a tier for shared resource support.
alias D3D11_SHARED_RESOURCE_TIER = int;
enum : int
{
    ///Specifies the support available when
    ///[D3D11_FEATURE_DATA_D3D11_OPTIONS::ExtendedResourceSharing](./ns-d3d11-d3d11_feature_data_d3d11_options.md) is
    ///**FALSE**.
    D3D11_SHARED_RESOURCE_TIER_0 = 0x00000000,
    ///Specifies the support available when
    ///[D3D11_FEATURE_DATA_D3D11_OPTIONS::ExtendedResourceSharing](./ns-d3d11-d3d11_feature_data_d3d11_options.md) is
    ///**TRUE**.
    D3D11_SHARED_RESOURCE_TIER_1 = 0x00000001,
    ///Specifies the support available when
    ///[D3D11_FEATURE_DATA_D3D11_OPTIONS4::ExtendedNV12SharedTextureSupported](../d3d11_4/ns-d3d11_4-d3d11_feature_data_d3d11_options4.md)
    ///is **TRUE**. Also see [Extended NV12 texture support](/windows/win32/direct3d11/direct3d-11-4-features
    D3D11_SHARED_RESOURCE_TIER_2 = 0x00000002,
    ///Specifies that [DXGI_FORMAT_R11G11B10_FLOAT](../dxgiformat/ne-dxgiformat-dxgi_format.md) supports NT handle
    ///sharing. Also see [CreateSharedHandle](../dxgi1_2/nf-dxgi1_2-idxgiresource1-createsharedhandle.md).
    D3D11_SHARED_RESOURCE_TIER_3 = 0x00000003,
}

///Describes parameters that are used to create a device.
alias D3D11_CREATE_DEVICE_FLAG = uint;
enum : uint
{
    ///Use this flag if your application will only call methods of Direct3D 11 interfaces from a single thread. By
    ///default, the ID3D11Device object is thread-safe. By using this flag, you can increase performance. However, if
    ///you use this flag and your application calls methods of Direct3D 11 interfaces from multiple threads, undefined
    ///behavior might result.
    D3D11_CREATE_DEVICE_SINGLETHREADED                                = 0x00000001,
    ///Creates a device that supports the debug layer. To use this flag, you must have D3D11*SDKLayers.dll installed;
    ///otherwise, device creation fails. To get D3D11_1SDKLayers.dll, install the SDK for Windows 8.
    D3D11_CREATE_DEVICE_DEBUG                                         = 0x00000002,
    ///<div class="alert"><b>Note</b> This flag is not supported in Direct3D 11.</div> <div> </div>
    D3D11_CREATE_DEVICE_SWITCH_TO_REF                                 = 0x00000004,
    ///Prevents multiple threads from being created. When this flag is used with a Windows Advanced Rasterization
    ///Platform (WARP) device, no additional threads will be created by WARP and all rasterization will occur on the
    ///calling thread. This flag is not recommended for general use. See remarks.
    D3D11_CREATE_DEVICE_PREVENT_INTERNAL_THREADING_OPTIMIZATIONS      = 0x00000008,
    ///Creates a device that supports BGRA formats (DXGI_FORMAT_B8G8R8A8_UNORM and DXGI_FORMAT_B8G8R8A8_UNORM_SRGB). All
    ///10level9 and higher hardware with WDDM 1.1+ drivers support BGRA formats. <div class="alert"><b>Note</b> Required
    ///for Direct2D interoperability with Direct3D resources.</div> <div> </div>
    D3D11_CREATE_DEVICE_BGRA_SUPPORT                                  = 0x00000020,
    ///Causes the device and driver to keep information that you can use for shader debugging. The exact impact from
    ///this flag will vary from driver to driver. To use this flag, you must have D3D11_1SDKLayers.dll installed;
    ///otherwise, device creation fails. The created device supports the debug layer. To get D3D11_1SDKLayers.dll,
    ///install the SDK for Windows 8. If you use this flag and the current driver does not support shader debugging,
    ///device creation fails. Shader debugging requires a driver that is implemented to the WDDM for Windows 8 (WDDM
    ///1.2). <b>Direct3D 11: </b>This value is not supported until Direct3D 11.1.
    D3D11_CREATE_DEVICE_DEBUGGABLE                                    = 0x00000040,
    ///Causes the Direct3D runtime to ignore registry settings that turn on the debug layer. You can turn on the debug
    ///layer by using the DirectX Control Panel that was included as part of the DirectX SDK. We shipped the last
    ///version of the DirectX SDK in June 2010; you can download it from the Microsoft Download Center. You can set this
    ///flag in your app, typically in release builds only, to prevent end users from using the DirectX Control Panel to
    ///monitor how the app uses Direct3D. <div class="alert"><b>Note</b> You can also set this flag in your app to
    ///prevent Direct3D debugging tools, such as Visual Studio Ultimate 2012, from hooking your app.</div> <div> </div>
    ///<b>Windows 8.1: </b>This flag doesn't prevent Visual Studio 2013 and later running on Windows 8.1 and later from
    ///hooking your app; instead use ID3D11DeviceContext2::IsAnnotationEnabled. This flag still prevents Visual Studio
    ///2013 and later running on Windows 8 and earlier from hooking your app. <b>Direct3D 11: </b>This value is not
    ///supported until Direct3D 11.1.
    D3D11_CREATE_DEVICE_PREVENT_ALTERING_LAYER_SETTINGS_FROM_REGISTRY = 0x00000080,
    ///Use this flag if the device will produce GPU workloads that take more than two seconds to complete, and you want
    ///the operating system to allow them to successfully finish. If this flag is not set, the operating system performs
    ///timeout detection and recovery when it detects a GPU packet that took more than two seconds to execute. If this
    ///flag is set, the operating system allows such a long running packet to execute without resetting the GPU. We
    ///recommend not to set this flag if your device needs to be highly responsive so that the operating system can
    ///detect and recover from GPU timeouts. We recommend to set this flag if your device needs to perform time
    ///consuming background tasks such as compute, image recognition, and video encoding to allow such tasks to
    ///successfully finish. <b>Direct3D 11: </b>This value is not supported until Direct3D 11.1.
    D3D11_CREATE_DEVICE_DISABLE_GPU_TIMEOUT                           = 0x00000100,
    ///Forces the creation of the Direct3D device to fail if the display driver is not implemented to the WDDM for
    ///Windows 8 (WDDM 1.2). When the display driver is not implemented to WDDM 1.2, only a Direct3D device that is
    ///created with feature level 9.1, 9.2, or 9.3 supports video; therefore, if this flag is set, the runtime creates
    ///the Direct3D device only for feature level 9.1, 9.2, or 9.3. We recommend not to specify this flag for
    ///applications that want to favor Direct3D capability over video. If feature level 10 and higher is available, the
    ///runtime will use that feature level regardless of video support. If this flag is set, device creation on the
    ///Basic Render Device (BRD) will succeed regardless of the BRD's missing support for video decode. This is because
    ///the Media Foundation video stack operates in software mode on BRD. In this situation, if you force the video
    ///stack to create the Direct3D device twice (create the device once with this flag, next discover BRD, then again
    ///create the device without the flag), you actually degrade performance. If you attempt to create a Direct3D device
    ///with driver type D3D_DRIVER_TYPE_NULL, D3D_DRIVER_TYPE_REFERENCE, or D3D_DRIVER_TYPE_SOFTWARE, device creation
    ///fails at any feature level because none of the associated drivers provide video capability. If you attempt to
    ///create a Direct3D device with driver type D3D_DRIVER_TYPE_WARP, device creation succeeds to allow software
    ///fallback for video. <b>Direct3D 11: </b>This value is not supported until Direct3D 11.1.
    D3D11_CREATE_DEVICE_VIDEO_SUPPORT                                 = 0x00000800,
}

///Options for the amount of information to report about a device object's lifetime.
alias D3D11_RLDO_FLAGS = int;
enum : int
{
    ///Specifies to obtain a summary about a device object's lifetime.
    D3D11_RLDO_SUMMARY         = 0x00000001,
    ///Specifies to obtain detailed information about a device object's lifetime.
    D3D11_RLDO_DETAIL          = 0x00000002,
    ///This flag indicates to ignore objects which have no external refcounts keeping them alive. D3D objects are
    ///printed using an external refcount and an internal refcount. Typically, all objects are printed. This flag means
    ///ignore the objects whose external refcount is 0, because the application is not responsible for keeping them
    ///alive.
    D3D11_RLDO_IGNORE_INTERNAL = 0x00000004,
}

///Indicates which resource types to track.
alias D3D11_SHADER_TRACKING_RESOURCE_TYPE = int;
enum : int
{
    ///No resource types are tracked.
    D3D11_SHADER_TRACKING_RESOURCE_TYPE_NONE                 = 0x00000000,
    ///Track device memory that is created with unordered access view (UAV) bind flags.
    D3D11_SHADER_TRACKING_RESOURCE_TYPE_UAV_DEVICEMEMORY     = 0x00000001,
    ///Track device memory that is created without UAV bind flags.
    D3D11_SHADER_TRACKING_RESOURCE_TYPE_NON_UAV_DEVICEMEMORY = 0x00000002,
    ///Track all device memory.
    D3D11_SHADER_TRACKING_RESOURCE_TYPE_ALL_DEVICEMEMORY     = 0x00000003,
    ///Track all shaders that use group shared memory.
    D3D11_SHADER_TRACKING_RESOURCE_TYPE_GROUPSHARED_MEMORY   = 0x00000004,
    ///Track all device memory except device memory that is created without UAV bind flags.
    D3D11_SHADER_TRACKING_RESOURCE_TYPE_ALL_SHARED_MEMORY    = 0x00000005,
    ///Track all device memory except device memory that is created with UAV bind flags.
    D3D11_SHADER_TRACKING_RESOURCE_TYPE_GROUPSHARED_NON_UAV  = 0x00000006,
    ///Track all memory on the device.
    D3D11_SHADER_TRACKING_RESOURCE_TYPE_ALL                  = 0x00000007,
}

///Options that specify how to perform shader debug tracking.
alias D3D11_SHADER_TRACKING_OPTIONS = int;
enum : int
{
    ///No debug tracking is performed.
    D3D11_SHADER_TRACKING_OPTION_IGNORE                                       = 0x00000000,
    ///Track the reading of uninitialized data.
    D3D11_SHADER_TRACKING_OPTION_TRACK_UNINITIALIZED                          = 0x00000001,
    ///Track read-after-write hazards.
    D3D11_SHADER_TRACKING_OPTION_TRACK_RAW                                    = 0x00000002,
    ///Track write-after-read hazards.
    D3D11_SHADER_TRACKING_OPTION_TRACK_WAR                                    = 0x00000004,
    ///Track write-after-write hazards.
    D3D11_SHADER_TRACKING_OPTION_TRACK_WAW                                    = 0x00000008,
    ///Track that hazards are allowed in which data is written but the value does not change.
    D3D11_SHADER_TRACKING_OPTION_ALLOW_SAME                                   = 0x00000010,
    ///Track that only one type of atomic operation is used on an address.
    D3D11_SHADER_TRACKING_OPTION_TRACK_ATOMIC_CONSISTENCY                     = 0x00000020,
    ///Track read-after-write hazards across thread groups.
    D3D11_SHADER_TRACKING_OPTION_TRACK_RAW_ACROSS_THREADGROUPS                = 0x00000040,
    ///Track write-after-read hazards across thread groups.
    D3D11_SHADER_TRACKING_OPTION_TRACK_WAR_ACROSS_THREADGROUPS                = 0x00000080,
    ///Track write-after-write hazards across thread groups.
    D3D11_SHADER_TRACKING_OPTION_TRACK_WAW_ACROSS_THREADGROUPS                = 0x00000100,
    ///Track that only one type of atomic operation is used on an address across thread groups.
    D3D11_SHADER_TRACKING_OPTION_TRACK_ATOMIC_CONSISTENCY_ACROSS_THREADGROUPS = 0x00000200,
    ///Track hazards that are specific to unordered access views (UAVs).
    D3D11_SHADER_TRACKING_OPTION_UAV_SPECIFIC_FLAGS                           = 0x000003c0,
    ///Track all hazards.
    D3D11_SHADER_TRACKING_OPTION_ALL_HAZARDS                                  = 0x000003ee,
    ///Track all hazards and track that hazards are allowed in which data is written but the value does not change.
    D3D11_SHADER_TRACKING_OPTION_ALL_HAZARDS_ALLOWING_SAME                    = 0x000003fe,
    ///All of the preceding tracking options are set except <b>D3D11_SHADER_TRACKING_OPTION_IGNORE</b>.
    D3D11_SHADER_TRACKING_OPTION_ALL_OPTIONS                                  = 0x000003ff,
}

///Categories of debug messages. This will identify the category of a message when retrieving a message with
///ID3D11InfoQueue::GetMessage and when adding a message with ID3D11InfoQueue::AddMessage. When creating an info queue
///filter, these values can be used to allow or deny any categories of messages to pass through the storage and
///retrieval filters.
alias D3D11_MESSAGE_CATEGORY = int;
enum : int
{
    ///User defined message. See ID3D11InfoQueue::AddMessage.
    D3D11_MESSAGE_CATEGORY_APPLICATION_DEFINED   = 0x00000000,
    D3D11_MESSAGE_CATEGORY_MISCELLANEOUS         = 0x00000001,
    D3D11_MESSAGE_CATEGORY_INITIALIZATION        = 0x00000002,
    D3D11_MESSAGE_CATEGORY_CLEANUP               = 0x00000003,
    D3D11_MESSAGE_CATEGORY_COMPILATION           = 0x00000004,
    D3D11_MESSAGE_CATEGORY_STATE_CREATION        = 0x00000005,
    D3D11_MESSAGE_CATEGORY_STATE_SETTING         = 0x00000006,
    D3D11_MESSAGE_CATEGORY_STATE_GETTING         = 0x00000007,
    D3D11_MESSAGE_CATEGORY_RESOURCE_MANIPULATION = 0x00000008,
    D3D11_MESSAGE_CATEGORY_EXECUTION             = 0x00000009,
    ///<b>Direct3D 11: </b>This value is not supported until Direct3D 11.1.
    D3D11_MESSAGE_CATEGORY_SHADER                = 0x0000000a,
}

///Debug message severity levels for an information queue.
alias D3D11_MESSAGE_SEVERITY = int;
enum : int
{
    ///Defines some type of corruption which has occurred.
    D3D11_MESSAGE_SEVERITY_CORRUPTION = 0x00000000,
    ///Defines an error message.
    D3D11_MESSAGE_SEVERITY_ERROR      = 0x00000001,
    ///Defines a warning message.
    D3D11_MESSAGE_SEVERITY_WARNING    = 0x00000002,
    ///Defines an information message.
    D3D11_MESSAGE_SEVERITY_INFO       = 0x00000003,
    ///Defines a message other than corruption, error, warning, or information. <b>Direct3D 11: </b>This value is not
    ///supported until Direct3D 11.1.
    D3D11_MESSAGE_SEVERITY_MESSAGE    = 0x00000004,
}

///Debug messages for setting up an info-queue filter (see D3D11_INFO_QUEUE_FILTER); use these messages to allow or deny
///message categories to pass through the storage and retrieval filters. These IDs are used by methods such as
///ID3D11InfoQueue::GetMessage or ID3D11InfoQueue::AddMessage.
alias D3D11_MESSAGE_ID = int;
enum : int
{
    D3D11_MESSAGE_ID_UNKNOWN                                                                     = 0x00000000,
    D3D11_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_HAZARD                                            = 0x00000001,
    D3D11_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_HAZARD                                              = 0x00000002,
    D3D11_MESSAGE_ID_DEVICE_VSSETSHADERRESOURCES_HAZARD                                          = 0x00000003,
    D3D11_MESSAGE_ID_DEVICE_VSSETCONSTANTBUFFERS_HAZARD                                          = 0x00000004,
    D3D11_MESSAGE_ID_DEVICE_GSSETSHADERRESOURCES_HAZARD                                          = 0x00000005,
    D3D11_MESSAGE_ID_DEVICE_GSSETCONSTANTBUFFERS_HAZARD                                          = 0x00000006,
    D3D11_MESSAGE_ID_DEVICE_PSSETSHADERRESOURCES_HAZARD                                          = 0x00000007,
    D3D11_MESSAGE_ID_DEVICE_PSSETCONSTANTBUFFERS_HAZARD                                          = 0x00000008,
    D3D11_MESSAGE_ID_DEVICE_OMSETRENDERTARGETS_HAZARD                                            = 0x00000009,
    D3D11_MESSAGE_ID_DEVICE_SOSETTARGETS_HAZARD                                                  = 0x0000000a,
    D3D11_MESSAGE_ID_STRING_FROM_APPLICATION                                                     = 0x0000000b,
    D3D11_MESSAGE_ID_CORRUPTED_THIS                                                              = 0x0000000c,
    D3D11_MESSAGE_ID_CORRUPTED_PARAMETER1                                                        = 0x0000000d,
    D3D11_MESSAGE_ID_CORRUPTED_PARAMETER2                                                        = 0x0000000e,
    D3D11_MESSAGE_ID_CORRUPTED_PARAMETER3                                                        = 0x0000000f,
    D3D11_MESSAGE_ID_CORRUPTED_PARAMETER4                                                        = 0x00000010,
    D3D11_MESSAGE_ID_CORRUPTED_PARAMETER5                                                        = 0x00000011,
    D3D11_MESSAGE_ID_CORRUPTED_PARAMETER6                                                        = 0x00000012,
    D3D11_MESSAGE_ID_CORRUPTED_PARAMETER7                                                        = 0x00000013,
    D3D11_MESSAGE_ID_CORRUPTED_PARAMETER8                                                        = 0x00000014,
    D3D11_MESSAGE_ID_CORRUPTED_PARAMETER9                                                        = 0x00000015,
    D3D11_MESSAGE_ID_CORRUPTED_PARAMETER10                                                       = 0x00000016,
    D3D11_MESSAGE_ID_CORRUPTED_PARAMETER11                                                       = 0x00000017,
    D3D11_MESSAGE_ID_CORRUPTED_PARAMETER12                                                       = 0x00000018,
    D3D11_MESSAGE_ID_CORRUPTED_PARAMETER13                                                       = 0x00000019,
    D3D11_MESSAGE_ID_CORRUPTED_PARAMETER14                                                       = 0x0000001a,
    D3D11_MESSAGE_ID_CORRUPTED_PARAMETER15                                                       = 0x0000001b,
    D3D11_MESSAGE_ID_CORRUPTED_MULTITHREADING                                                    = 0x0000001c,
    D3D11_MESSAGE_ID_MESSAGE_REPORTING_OUTOFMEMORY                                               = 0x0000001d,
    D3D11_MESSAGE_ID_IASETINPUTLAYOUT_UNBINDDELETINGOBJECT                                       = 0x0000001e,
    D3D11_MESSAGE_ID_IASETVERTEXBUFFERS_UNBINDDELETINGOBJECT                                     = 0x0000001f,
    D3D11_MESSAGE_ID_IASETINDEXBUFFER_UNBINDDELETINGOBJECT                                       = 0x00000020,
    D3D11_MESSAGE_ID_VSSETSHADER_UNBINDDELETINGOBJECT                                            = 0x00000021,
    D3D11_MESSAGE_ID_VSSETSHADERRESOURCES_UNBINDDELETINGOBJECT                                   = 0x00000022,
    D3D11_MESSAGE_ID_VSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT                                   = 0x00000023,
    D3D11_MESSAGE_ID_VSSETSAMPLERS_UNBINDDELETINGOBJECT                                          = 0x00000024,
    D3D11_MESSAGE_ID_GSSETSHADER_UNBINDDELETINGOBJECT                                            = 0x00000025,
    D3D11_MESSAGE_ID_GSSETSHADERRESOURCES_UNBINDDELETINGOBJECT                                   = 0x00000026,
    D3D11_MESSAGE_ID_GSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT                                   = 0x00000027,
    D3D11_MESSAGE_ID_GSSETSAMPLERS_UNBINDDELETINGOBJECT                                          = 0x00000028,
    D3D11_MESSAGE_ID_SOSETTARGETS_UNBINDDELETINGOBJECT                                           = 0x00000029,
    D3D11_MESSAGE_ID_PSSETSHADER_UNBINDDELETINGOBJECT                                            = 0x0000002a,
    D3D11_MESSAGE_ID_PSSETSHADERRESOURCES_UNBINDDELETINGOBJECT                                   = 0x0000002b,
    D3D11_MESSAGE_ID_PSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT                                   = 0x0000002c,
    D3D11_MESSAGE_ID_PSSETSAMPLERS_UNBINDDELETINGOBJECT                                          = 0x0000002d,
    D3D11_MESSAGE_ID_RSSETSTATE_UNBINDDELETINGOBJECT                                             = 0x0000002e,
    D3D11_MESSAGE_ID_OMSETBLENDSTATE_UNBINDDELETINGOBJECT                                        = 0x0000002f,
    D3D11_MESSAGE_ID_OMSETDEPTHSTENCILSTATE_UNBINDDELETINGOBJECT                                 = 0x00000030,
    D3D11_MESSAGE_ID_OMSETRENDERTARGETS_UNBINDDELETINGOBJECT                                     = 0x00000031,
    D3D11_MESSAGE_ID_SETPREDICATION_UNBINDDELETINGOBJECT                                         = 0x00000032,
    D3D11_MESSAGE_ID_GETPRIVATEDATA_MOREDATA                                                     = 0x00000033,
    D3D11_MESSAGE_ID_SETPRIVATEDATA_INVALIDFREEDATA                                              = 0x00000034,
    D3D11_MESSAGE_ID_SETPRIVATEDATA_INVALIDIUNKNOWN                                              = 0x00000035,
    D3D11_MESSAGE_ID_SETPRIVATEDATA_INVALIDFLAGS                                                 = 0x00000036,
    D3D11_MESSAGE_ID_SETPRIVATEDATA_CHANGINGPARAMS                                               = 0x00000037,
    D3D11_MESSAGE_ID_SETPRIVATEDATA_OUTOFMEMORY                                                  = 0x00000038,
    D3D11_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDFORMAT                                             = 0x00000039,
    D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDSAMPLES                                                 = 0x0000003a,
    D3D11_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDUSAGE                                              = 0x0000003b,
    D3D11_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDBINDFLAGS                                          = 0x0000003c,
    D3D11_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDCPUACCESSFLAGS                                     = 0x0000003d,
    D3D11_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDMISCFLAGS                                          = 0x0000003e,
    D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDCPUACCESSFLAGS                                          = 0x0000003f,
    D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDBINDFLAGS                                               = 0x00000040,
    D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDINITIALDATA                                             = 0x00000041,
    D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDDIMENSIONS                                              = 0x00000042,
    D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDMIPLEVELS                                               = 0x00000043,
    D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDMISCFLAGS                                               = 0x00000044,
    D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDARG_RETURN                                              = 0x00000045,
    D3D11_MESSAGE_ID_CREATEBUFFER_OUTOFMEMORY_RETURN                                             = 0x00000046,
    D3D11_MESSAGE_ID_CREATEBUFFER_NULLDESC                                                       = 0x00000047,
    D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDCONSTANTBUFFERBINDINGS                                  = 0x00000048,
    D3D11_MESSAGE_ID_CREATEBUFFER_LARGEALLOCATION                                                = 0x00000049,
    D3D11_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDFORMAT                                          = 0x0000004a,
    D3D11_MESSAGE_ID_CREATETEXTURE1D_UNSUPPORTEDFORMAT                                           = 0x0000004b,
    D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDSAMPLES                                              = 0x0000004c,
    D3D11_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDUSAGE                                           = 0x0000004d,
    D3D11_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDBINDFLAGS                                       = 0x0000004e,
    D3D11_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDCPUACCESSFLAGS                                  = 0x0000004f,
    D3D11_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDMISCFLAGS                                       = 0x00000050,
    D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDCPUACCESSFLAGS                                       = 0x00000051,
    D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDBINDFLAGS                                            = 0x00000052,
    D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDINITIALDATA                                          = 0x00000053,
    D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDDIMENSIONS                                           = 0x00000054,
    D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDMIPLEVELS                                            = 0x00000055,
    D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDMISCFLAGS                                            = 0x00000056,
    D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDARG_RETURN                                           = 0x00000057,
    D3D11_MESSAGE_ID_CREATETEXTURE1D_OUTOFMEMORY_RETURN                                          = 0x00000058,
    D3D11_MESSAGE_ID_CREATETEXTURE1D_NULLDESC                                                    = 0x00000059,
    D3D11_MESSAGE_ID_CREATETEXTURE1D_LARGEALLOCATION                                             = 0x0000005a,
    D3D11_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDFORMAT                                          = 0x0000005b,
    D3D11_MESSAGE_ID_CREATETEXTURE2D_UNSUPPORTEDFORMAT                                           = 0x0000005c,
    D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDSAMPLES                                              = 0x0000005d,
    D3D11_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDUSAGE                                           = 0x0000005e,
    D3D11_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDBINDFLAGS                                       = 0x0000005f,
    D3D11_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDCPUACCESSFLAGS                                  = 0x00000060,
    D3D11_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDMISCFLAGS                                       = 0x00000061,
    D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDCPUACCESSFLAGS                                       = 0x00000062,
    D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDBINDFLAGS                                            = 0x00000063,
    D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDINITIALDATA                                          = 0x00000064,
    D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDDIMENSIONS                                           = 0x00000065,
    D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDMIPLEVELS                                            = 0x00000066,
    D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDMISCFLAGS                                            = 0x00000067,
    D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDARG_RETURN                                           = 0x00000068,
    D3D11_MESSAGE_ID_CREATETEXTURE2D_OUTOFMEMORY_RETURN                                          = 0x00000069,
    D3D11_MESSAGE_ID_CREATETEXTURE2D_NULLDESC                                                    = 0x0000006a,
    D3D11_MESSAGE_ID_CREATETEXTURE2D_LARGEALLOCATION                                             = 0x0000006b,
    D3D11_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDFORMAT                                          = 0x0000006c,
    D3D11_MESSAGE_ID_CREATETEXTURE3D_UNSUPPORTEDFORMAT                                           = 0x0000006d,
    D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDSAMPLES                                              = 0x0000006e,
    D3D11_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDUSAGE                                           = 0x0000006f,
    D3D11_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDBINDFLAGS                                       = 0x00000070,
    D3D11_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDCPUACCESSFLAGS                                  = 0x00000071,
    D3D11_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDMISCFLAGS                                       = 0x00000072,
    D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDCPUACCESSFLAGS                                       = 0x00000073,
    D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDBINDFLAGS                                            = 0x00000074,
    D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDINITIALDATA                                          = 0x00000075,
    D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDDIMENSIONS                                           = 0x00000076,
    D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDMIPLEVELS                                            = 0x00000077,
    D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDMISCFLAGS                                            = 0x00000078,
    D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDARG_RETURN                                           = 0x00000079,
    D3D11_MESSAGE_ID_CREATETEXTURE3D_OUTOFMEMORY_RETURN                                          = 0x0000007a,
    D3D11_MESSAGE_ID_CREATETEXTURE3D_NULLDESC                                                    = 0x0000007b,
    D3D11_MESSAGE_ID_CREATETEXTURE3D_LARGEALLOCATION                                             = 0x0000007c,
    D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_UNRECOGNIZEDFORMAT                                 = 0x0000007d,
    D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDDESC                                        = 0x0000007e,
    D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDFORMAT                                      = 0x0000007f,
    D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDDIMENSIONS                                  = 0x00000080,
    D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDRESOURCE                                    = 0x00000081,
    D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_TOOMANYOBJECTS                                     = 0x00000082,
    D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDARG_RETURN                                  = 0x00000083,
    D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_OUTOFMEMORY_RETURN                                 = 0x00000084,
    D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_UNRECOGNIZEDFORMAT                                   = 0x00000085,
    D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_UNSUPPORTEDFORMAT                                    = 0x00000086,
    D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDDESC                                          = 0x00000087,
    D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDFORMAT                                        = 0x00000088,
    D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDDIMENSIONS                                    = 0x00000089,
    D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDRESOURCE                                      = 0x0000008a,
    D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_TOOMANYOBJECTS                                       = 0x0000008b,
    D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDARG_RETURN                                    = 0x0000008c,
    D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_OUTOFMEMORY_RETURN                                   = 0x0000008d,
    D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_UNRECOGNIZEDFORMAT                                   = 0x0000008e,
    D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDDESC                                          = 0x0000008f,
    D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDFORMAT                                        = 0x00000090,
    D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDDIMENSIONS                                    = 0x00000091,
    D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDRESOURCE                                      = 0x00000092,
    D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_TOOMANYOBJECTS                                       = 0x00000093,
    D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDARG_RETURN                                    = 0x00000094,
    D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_OUTOFMEMORY_RETURN                                   = 0x00000095,
    D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_OUTOFMEMORY                                               = 0x00000096,
    D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_TOOMANYELEMENTS                                           = 0x00000097,
    D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDFORMAT                                             = 0x00000098,
    D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_INCOMPATIBLEFORMAT                                        = 0x00000099,
    D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDSLOT                                               = 0x0000009a,
    D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDINPUTSLOTCLASS                                     = 0x0000009b,
    D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_STEPRATESLOTCLASSMISMATCH                                 = 0x0000009c,
    D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDSLOTCLASSCHANGE                                    = 0x0000009d,
    D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDSTEPRATECHANGE                                     = 0x0000009e,
    D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDALIGNMENT                                          = 0x0000009f,
    D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_DUPLICATESEMANTIC                                         = 0x000000a0,
    D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_UNPARSEABLEINPUTSIGNATURE                                 = 0x000000a1,
    D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_NULLSEMANTIC                                              = 0x000000a2,
    D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_MISSINGELEMENT                                            = 0x000000a3,
    D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_NULLDESC                                                  = 0x000000a4,
    D3D11_MESSAGE_ID_CREATEVERTEXSHADER_OUTOFMEMORY                                              = 0x000000a5,
    D3D11_MESSAGE_ID_CREATEVERTEXSHADER_INVALIDSHADERBYTECODE                                    = 0x000000a6,
    D3D11_MESSAGE_ID_CREATEVERTEXSHADER_INVALIDSHADERTYPE                                        = 0x000000a7,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADER_OUTOFMEMORY                                            = 0x000000a8,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADER_INVALIDSHADERBYTECODE                                  = 0x000000a9,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADER_INVALIDSHADERTYPE                                      = 0x000000aa,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTOFMEMORY                            = 0x000000ab,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSHADERBYTECODE                  = 0x000000ac,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSHADERTYPE                      = 0x000000ad,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDNUMENTRIES                      = 0x000000ae,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTPUTSTREAMSTRIDEUNUSED               = 0x000000af,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UNEXPECTEDDECL                         = 0x000000b0,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_EXPECTEDDECL                           = 0x000000b1,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTPUTSLOT0EXPECTED                    = 0x000000b2,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDOUTPUTSLOT                      = 0x000000b3,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_ONLYONEELEMENTPERSLOT                  = 0x000000b4,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDCOMPONENTCOUNT                  = 0x000000b5,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSTARTCOMPONENTANDCOMPONENTCOUNT = 0x000000b6,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDGAPDEFINITION                   = 0x000000b7,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_REPEATEDOUTPUT                         = 0x000000b8,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDOUTPUTSTREAMSTRIDE              = 0x000000b9,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MISSINGSEMANTIC                        = 0x000000ba,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MASKMISMATCH                           = 0x000000bb,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_CANTHAVEONLYGAPS                       = 0x000000bc,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_DECLTOOCOMPLEX                         = 0x000000bd,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MISSINGOUTPUTSIGNATURE                 = 0x000000be,
    D3D11_MESSAGE_ID_CREATEPIXELSHADER_OUTOFMEMORY                                               = 0x000000bf,
    D3D11_MESSAGE_ID_CREATEPIXELSHADER_INVALIDSHADERBYTECODE                                     = 0x000000c0,
    D3D11_MESSAGE_ID_CREATEPIXELSHADER_INVALIDSHADERTYPE                                         = 0x000000c1,
    D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDFILLMODE                                       = 0x000000c2,
    D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDCULLMODE                                       = 0x000000c3,
    D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDDEPTHBIASCLAMP                                 = 0x000000c4,
    D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDSLOPESCALEDDEPTHBIAS                           = 0x000000c5,
    D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_TOOMANYOBJECTS                                        = 0x000000c6,
    D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_NULLDESC                                              = 0x000000c7,
    D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDDEPTHWRITEMASK                               = 0x000000c8,
    D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDDEPTHFUNC                                    = 0x000000c9,
    D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILFAILOP                       = 0x000000ca,
    D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILZFAILOP                      = 0x000000cb,
    D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILPASSOP                       = 0x000000cc,
    D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILFUNC                         = 0x000000cd,
    D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILFAILOP                        = 0x000000ce,
    D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILZFAILOP                       = 0x000000cf,
    D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILPASSOP                        = 0x000000d0,
    D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILFUNC                          = 0x000000d1,
    D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_TOOMANYOBJECTS                                      = 0x000000d2,
    D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_NULLDESC                                            = 0x000000d3,
    D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDSRCBLEND                                            = 0x000000d4,
    D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDDESTBLEND                                           = 0x000000d5,
    D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDBLENDOP                                             = 0x000000d6,
    D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDSRCBLENDALPHA                                       = 0x000000d7,
    D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDDESTBLENDALPHA                                      = 0x000000d8,
    D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDBLENDOPALPHA                                        = 0x000000d9,
    D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDRENDERTARGETWRITEMASK                               = 0x000000da,
    D3D11_MESSAGE_ID_CREATEBLENDSTATE_TOOMANYOBJECTS                                             = 0x000000db,
    D3D11_MESSAGE_ID_CREATEBLENDSTATE_NULLDESC                                                   = 0x000000dc,
    D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDFILTER                                            = 0x000000dd,
    D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDADDRESSU                                          = 0x000000de,
    D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDADDRESSV                                          = 0x000000df,
    D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDADDRESSW                                          = 0x000000e0,
    D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMIPLODBIAS                                        = 0x000000e1,
    D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMAXANISOTROPY                                     = 0x000000e2,
    D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDCOMPARISONFUNC                                    = 0x000000e3,
    D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMINLOD                                            = 0x000000e4,
    D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMAXLOD                                            = 0x000000e5,
    D3D11_MESSAGE_ID_CREATESAMPLERSTATE_TOOMANYOBJECTS                                           = 0x000000e6,
    D3D11_MESSAGE_ID_CREATESAMPLERSTATE_NULLDESC                                                 = 0x000000e7,
    D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_INVALIDQUERY                                         = 0x000000e8,
    D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_INVALIDMISCFLAGS                                     = 0x000000e9,
    D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_UNEXPECTEDMISCFLAG                                   = 0x000000ea,
    D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_NULLDESC                                             = 0x000000eb,
    D3D11_MESSAGE_ID_DEVICE_IASETPRIMITIVETOPOLOGY_TOPOLOGY_UNRECOGNIZED                         = 0x000000ec,
    D3D11_MESSAGE_ID_DEVICE_IASETPRIMITIVETOPOLOGY_TOPOLOGY_UNDEFINED                            = 0x000000ed,
    D3D11_MESSAGE_ID_IASETVERTEXBUFFERS_INVALIDBUFFER                                            = 0x000000ee,
    D3D11_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_OFFSET_TOO_LARGE                                  = 0x000000ef,
    D3D11_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_BUFFERS_EMPTY                                     = 0x000000f0,
    D3D11_MESSAGE_ID_IASETINDEXBUFFER_INVALIDBUFFER                                              = 0x000000f1,
    D3D11_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_FORMAT_INVALID                                      = 0x000000f2,
    D3D11_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_OFFSET_TOO_LARGE                                    = 0x000000f3,
    D3D11_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_OFFSET_UNALIGNED                                    = 0x000000f4,
    D3D11_MESSAGE_ID_DEVICE_VSSETSHADERRESOURCES_VIEWS_EMPTY                                     = 0x000000f5,
    D3D11_MESSAGE_ID_VSSETCONSTANTBUFFERS_INVALIDBUFFER                                          = 0x000000f6,
    D3D11_MESSAGE_ID_DEVICE_VSSETCONSTANTBUFFERS_BUFFERS_EMPTY                                   = 0x000000f7,
    D3D11_MESSAGE_ID_DEVICE_VSSETSAMPLERS_SAMPLERS_EMPTY                                         = 0x000000f8,
    D3D11_MESSAGE_ID_DEVICE_GSSETSHADERRESOURCES_VIEWS_EMPTY                                     = 0x000000f9,
    D3D11_MESSAGE_ID_GSSETCONSTANTBUFFERS_INVALIDBUFFER                                          = 0x000000fa,
    D3D11_MESSAGE_ID_DEVICE_GSSETCONSTANTBUFFERS_BUFFERS_EMPTY                                   = 0x000000fb,
    D3D11_MESSAGE_ID_DEVICE_GSSETSAMPLERS_SAMPLERS_EMPTY                                         = 0x000000fc,
    D3D11_MESSAGE_ID_SOSETTARGETS_INVALIDBUFFER                                                  = 0x000000fd,
    D3D11_MESSAGE_ID_DEVICE_SOSETTARGETS_OFFSET_UNALIGNED                                        = 0x000000fe,
    D3D11_MESSAGE_ID_DEVICE_PSSETSHADERRESOURCES_VIEWS_EMPTY                                     = 0x000000ff,
    D3D11_MESSAGE_ID_PSSETCONSTANTBUFFERS_INVALIDBUFFER                                          = 0x00000100,
    D3D11_MESSAGE_ID_DEVICE_PSSETCONSTANTBUFFERS_BUFFERS_EMPTY                                   = 0x00000101,
    D3D11_MESSAGE_ID_DEVICE_PSSETSAMPLERS_SAMPLERS_EMPTY                                         = 0x00000102,
    D3D11_MESSAGE_ID_DEVICE_RSSETVIEWPORTS_INVALIDVIEWPORT                                       = 0x00000103,
    D3D11_MESSAGE_ID_DEVICE_RSSETSCISSORRECTS_INVALIDSCISSOR                                     = 0x00000104,
    D3D11_MESSAGE_ID_CLEARRENDERTARGETVIEW_DENORMFLUSH                                           = 0x00000105,
    D3D11_MESSAGE_ID_CLEARDEPTHSTENCILVIEW_DENORMFLUSH                                           = 0x00000106,
    D3D11_MESSAGE_ID_CLEARDEPTHSTENCILVIEW_INVALID                                               = 0x00000107,
    D3D11_MESSAGE_ID_DEVICE_IAGETVERTEXBUFFERS_BUFFERS_EMPTY                                     = 0x00000108,
    D3D11_MESSAGE_ID_DEVICE_VSGETSHADERRESOURCES_VIEWS_EMPTY                                     = 0x00000109,
    D3D11_MESSAGE_ID_DEVICE_VSGETCONSTANTBUFFERS_BUFFERS_EMPTY                                   = 0x0000010a,
    D3D11_MESSAGE_ID_DEVICE_VSGETSAMPLERS_SAMPLERS_EMPTY                                         = 0x0000010b,
    D3D11_MESSAGE_ID_DEVICE_GSGETSHADERRESOURCES_VIEWS_EMPTY                                     = 0x0000010c,
    D3D11_MESSAGE_ID_DEVICE_GSGETCONSTANTBUFFERS_BUFFERS_EMPTY                                   = 0x0000010d,
    D3D11_MESSAGE_ID_DEVICE_GSGETSAMPLERS_SAMPLERS_EMPTY                                         = 0x0000010e,
    D3D11_MESSAGE_ID_DEVICE_SOGETTARGETS_BUFFERS_EMPTY                                           = 0x0000010f,
    D3D11_MESSAGE_ID_DEVICE_PSGETSHADERRESOURCES_VIEWS_EMPTY                                     = 0x00000110,
    D3D11_MESSAGE_ID_DEVICE_PSGETCONSTANTBUFFERS_BUFFERS_EMPTY                                   = 0x00000111,
    D3D11_MESSAGE_ID_DEVICE_PSGETSAMPLERS_SAMPLERS_EMPTY                                         = 0x00000112,
    D3D11_MESSAGE_ID_DEVICE_RSGETVIEWPORTS_VIEWPORTS_EMPTY                                       = 0x00000113,
    D3D11_MESSAGE_ID_DEVICE_RSGETSCISSORRECTS_RECTS_EMPTY                                        = 0x00000114,
    D3D11_MESSAGE_ID_DEVICE_GENERATEMIPS_RESOURCE_INVALID                                        = 0x00000115,
    D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDDESTINATIONSUBRESOURCE                         = 0x00000116,
    D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCESUBRESOURCE                              = 0x00000117,
    D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCEBOX                                      = 0x00000118,
    D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCE                                         = 0x00000119,
    D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDDESTINATIONSTATE                               = 0x0000011a,
    D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCESTATE                                    = 0x0000011b,
    D3D11_MESSAGE_ID_COPYRESOURCE_INVALIDSOURCE                                                  = 0x0000011c,
    D3D11_MESSAGE_ID_COPYRESOURCE_INVALIDDESTINATIONSTATE                                        = 0x0000011d,
    D3D11_MESSAGE_ID_COPYRESOURCE_INVALIDSOURCESTATE                                             = 0x0000011e,
    D3D11_MESSAGE_ID_UPDATESUBRESOURCE_INVALIDDESTINATIONSUBRESOURCE                             = 0x0000011f,
    D3D11_MESSAGE_ID_UPDATESUBRESOURCE_INVALIDDESTINATIONBOX                                     = 0x00000120,
    D3D11_MESSAGE_ID_UPDATESUBRESOURCE_INVALIDDESTINATIONSTATE                                   = 0x00000121,
    D3D11_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_DESTINATION_INVALID                               = 0x00000122,
    D3D11_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_DESTINATION_SUBRESOURCE_INVALID                   = 0x00000123,
    D3D11_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_SOURCE_INVALID                                    = 0x00000124,
    D3D11_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_SOURCE_SUBRESOURCE_INVALID                        = 0x00000125,
    D3D11_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_FORMAT_INVALID                                    = 0x00000126,
    D3D11_MESSAGE_ID_BUFFER_MAP_INVALIDMAPTYPE                                                   = 0x00000127,
    D3D11_MESSAGE_ID_BUFFER_MAP_INVALIDFLAGS                                                     = 0x00000128,
    D3D11_MESSAGE_ID_BUFFER_MAP_ALREADYMAPPED                                                    = 0x00000129,
    D3D11_MESSAGE_ID_BUFFER_MAP_DEVICEREMOVED_RETURN                                             = 0x0000012a,
    D3D11_MESSAGE_ID_BUFFER_UNMAP_NOTMAPPED                                                      = 0x0000012b,
    D3D11_MESSAGE_ID_TEXTURE1D_MAP_INVALIDMAPTYPE                                                = 0x0000012c,
    D3D11_MESSAGE_ID_TEXTURE1D_MAP_INVALIDSUBRESOURCE                                            = 0x0000012d,
    D3D11_MESSAGE_ID_TEXTURE1D_MAP_INVALIDFLAGS                                                  = 0x0000012e,
    D3D11_MESSAGE_ID_TEXTURE1D_MAP_ALREADYMAPPED                                                 = 0x0000012f,
    D3D11_MESSAGE_ID_TEXTURE1D_MAP_DEVICEREMOVED_RETURN                                          = 0x00000130,
    D3D11_MESSAGE_ID_TEXTURE1D_UNMAP_INVALIDSUBRESOURCE                                          = 0x00000131,
    D3D11_MESSAGE_ID_TEXTURE1D_UNMAP_NOTMAPPED                                                   = 0x00000132,
    D3D11_MESSAGE_ID_TEXTURE2D_MAP_INVALIDMAPTYPE                                                = 0x00000133,
    D3D11_MESSAGE_ID_TEXTURE2D_MAP_INVALIDSUBRESOURCE                                            = 0x00000134,
    D3D11_MESSAGE_ID_TEXTURE2D_MAP_INVALIDFLAGS                                                  = 0x00000135,
    D3D11_MESSAGE_ID_TEXTURE2D_MAP_ALREADYMAPPED                                                 = 0x00000136,
    D3D11_MESSAGE_ID_TEXTURE2D_MAP_DEVICEREMOVED_RETURN                                          = 0x00000137,
    D3D11_MESSAGE_ID_TEXTURE2D_UNMAP_INVALIDSUBRESOURCE                                          = 0x00000138,
    D3D11_MESSAGE_ID_TEXTURE2D_UNMAP_NOTMAPPED                                                   = 0x00000139,
    D3D11_MESSAGE_ID_TEXTURE3D_MAP_INVALIDMAPTYPE                                                = 0x0000013a,
    D3D11_MESSAGE_ID_TEXTURE3D_MAP_INVALIDSUBRESOURCE                                            = 0x0000013b,
    D3D11_MESSAGE_ID_TEXTURE3D_MAP_INVALIDFLAGS                                                  = 0x0000013c,
    D3D11_MESSAGE_ID_TEXTURE3D_MAP_ALREADYMAPPED                                                 = 0x0000013d,
    D3D11_MESSAGE_ID_TEXTURE3D_MAP_DEVICEREMOVED_RETURN                                          = 0x0000013e,
    D3D11_MESSAGE_ID_TEXTURE3D_UNMAP_INVALIDSUBRESOURCE                                          = 0x0000013f,
    D3D11_MESSAGE_ID_TEXTURE3D_UNMAP_NOTMAPPED                                                   = 0x00000140,
    D3D11_MESSAGE_ID_CHECKFORMATSUPPORT_FORMAT_DEPRECATED                                        = 0x00000141,
    D3D11_MESSAGE_ID_CHECKMULTISAMPLEQUALITYLEVELS_FORMAT_DEPRECATED                             = 0x00000142,
    D3D11_MESSAGE_ID_SETEXCEPTIONMODE_UNRECOGNIZEDFLAGS                                          = 0x00000143,
    D3D11_MESSAGE_ID_SETEXCEPTIONMODE_INVALIDARG_RETURN                                          = 0x00000144,
    D3D11_MESSAGE_ID_SETEXCEPTIONMODE_DEVICEREMOVED_RETURN                                       = 0x00000145,
    D3D11_MESSAGE_ID_REF_SIMULATING_INFINITELY_FAST_HARDWARE                                     = 0x00000146,
    D3D11_MESSAGE_ID_REF_THREADING_MODE                                                          = 0x00000147,
    D3D11_MESSAGE_ID_REF_UMDRIVER_EXCEPTION                                                      = 0x00000148,
    D3D11_MESSAGE_ID_REF_KMDRIVER_EXCEPTION                                                      = 0x00000149,
    D3D11_MESSAGE_ID_REF_HARDWARE_EXCEPTION                                                      = 0x0000014a,
    D3D11_MESSAGE_ID_REF_ACCESSING_INDEXABLE_TEMP_OUT_OF_RANGE                                   = 0x0000014b,
    D3D11_MESSAGE_ID_REF_PROBLEM_PARSING_SHADER                                                  = 0x0000014c,
    D3D11_MESSAGE_ID_REF_OUT_OF_MEMORY                                                           = 0x0000014d,
    D3D11_MESSAGE_ID_REF_INFO                                                                    = 0x0000014e,
    D3D11_MESSAGE_ID_DEVICE_DRAW_VERTEXPOS_OVERFLOW                                              = 0x0000014f,
    D3D11_MESSAGE_ID_DEVICE_DRAWINDEXED_INDEXPOS_OVERFLOW                                        = 0x00000150,
    D3D11_MESSAGE_ID_DEVICE_DRAWINSTANCED_VERTEXPOS_OVERFLOW                                     = 0x00000151,
    D3D11_MESSAGE_ID_DEVICE_DRAWINSTANCED_INSTANCEPOS_OVERFLOW                                   = 0x00000152,
    D3D11_MESSAGE_ID_DEVICE_DRAWINDEXEDINSTANCED_INSTANCEPOS_OVERFLOW                            = 0x00000153,
    D3D11_MESSAGE_ID_DEVICE_DRAWINDEXEDINSTANCED_INDEXPOS_OVERFLOW                               = 0x00000154,
    D3D11_MESSAGE_ID_DEVICE_DRAW_VERTEX_SHADER_NOT_SET                                           = 0x00000155,
    D3D11_MESSAGE_ID_DEVICE_SHADER_LINKAGE_SEMANTICNAME_NOT_FOUND                                = 0x00000156,
    D3D11_MESSAGE_ID_DEVICE_SHADER_LINKAGE_REGISTERINDEX                                         = 0x00000157,
    D3D11_MESSAGE_ID_DEVICE_SHADER_LINKAGE_COMPONENTTYPE                                         = 0x00000158,
    D3D11_MESSAGE_ID_DEVICE_SHADER_LINKAGE_REGISTERMASK                                          = 0x00000159,
    D3D11_MESSAGE_ID_DEVICE_SHADER_LINKAGE_SYSTEMVALUE                                           = 0x0000015a,
    D3D11_MESSAGE_ID_DEVICE_SHADER_LINKAGE_NEVERWRITTEN_ALWAYSREADS                              = 0x0000015b,
    D3D11_MESSAGE_ID_DEVICE_DRAW_VERTEX_BUFFER_NOT_SET                                           = 0x0000015c,
    D3D11_MESSAGE_ID_DEVICE_DRAW_INPUTLAYOUT_NOT_SET                                             = 0x0000015d,
    D3D11_MESSAGE_ID_DEVICE_DRAW_CONSTANT_BUFFER_NOT_SET                                         = 0x0000015e,
    D3D11_MESSAGE_ID_DEVICE_DRAW_CONSTANT_BUFFER_TOO_SMALL                                       = 0x0000015f,
    D3D11_MESSAGE_ID_DEVICE_DRAW_SAMPLER_NOT_SET                                                 = 0x00000160,
    D3D11_MESSAGE_ID_DEVICE_DRAW_SHADERRESOURCEVIEW_NOT_SET                                      = 0x00000161,
    D3D11_MESSAGE_ID_DEVICE_DRAW_VIEW_DIMENSION_MISMATCH                                         = 0x00000162,
    D3D11_MESSAGE_ID_DEVICE_DRAW_VERTEX_BUFFER_STRIDE_TOO_SMALL                                  = 0x00000163,
    D3D11_MESSAGE_ID_DEVICE_DRAW_VERTEX_BUFFER_TOO_SMALL                                         = 0x00000164,
    D3D11_MESSAGE_ID_DEVICE_DRAW_INDEX_BUFFER_NOT_SET                                            = 0x00000165,
    D3D11_MESSAGE_ID_DEVICE_DRAW_INDEX_BUFFER_FORMAT_INVALID                                     = 0x00000166,
    D3D11_MESSAGE_ID_DEVICE_DRAW_INDEX_BUFFER_TOO_SMALL                                          = 0x00000167,
    D3D11_MESSAGE_ID_DEVICE_DRAW_GS_INPUT_PRIMITIVE_MISMATCH                                     = 0x00000168,
    D3D11_MESSAGE_ID_DEVICE_DRAW_RESOURCE_RETURN_TYPE_MISMATCH                                   = 0x00000169,
    D3D11_MESSAGE_ID_DEVICE_DRAW_POSITION_NOT_PRESENT                                            = 0x0000016a,
    D3D11_MESSAGE_ID_DEVICE_DRAW_OUTPUT_STREAM_NOT_SET                                           = 0x0000016b,
    D3D11_MESSAGE_ID_DEVICE_DRAW_BOUND_RESOURCE_MAPPED                                           = 0x0000016c,
    D3D11_MESSAGE_ID_DEVICE_DRAW_INVALID_PRIMITIVETOPOLOGY                                       = 0x0000016d,
    D3D11_MESSAGE_ID_DEVICE_DRAW_VERTEX_OFFSET_UNALIGNED                                         = 0x0000016e,
    D3D11_MESSAGE_ID_DEVICE_DRAW_VERTEX_STRIDE_UNALIGNED                                         = 0x0000016f,
    D3D11_MESSAGE_ID_DEVICE_DRAW_INDEX_OFFSET_UNALIGNED                                          = 0x00000170,
    D3D11_MESSAGE_ID_DEVICE_DRAW_OUTPUT_STREAM_OFFSET_UNALIGNED                                  = 0x00000171,
    D3D11_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_LD_UNSUPPORTED                                  = 0x00000172,
    D3D11_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_SAMPLE_UNSUPPORTED                              = 0x00000173,
    D3D11_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_SAMPLE_C_UNSUPPORTED                            = 0x00000174,
    D3D11_MESSAGE_ID_DEVICE_DRAW_RESOURCE_MULTISAMPLE_UNSUPPORTED                                = 0x00000175,
    D3D11_MESSAGE_ID_DEVICE_DRAW_SO_TARGETS_BOUND_WITHOUT_SOURCE                                 = 0x00000176,
    D3D11_MESSAGE_ID_DEVICE_DRAW_SO_STRIDE_LARGER_THAN_BUFFER                                    = 0x00000177,
    D3D11_MESSAGE_ID_DEVICE_DRAW_OM_RENDER_TARGET_DOES_NOT_SUPPORT_BLENDING                      = 0x00000178,
    D3D11_MESSAGE_ID_DEVICE_DRAW_OM_DUAL_SOURCE_BLENDING_CAN_ONLY_HAVE_RENDER_TARGET_0           = 0x00000179,
    D3D11_MESSAGE_ID_DEVICE_REMOVAL_PROCESS_AT_FAULT                                             = 0x0000017a,
    D3D11_MESSAGE_ID_DEVICE_REMOVAL_PROCESS_POSSIBLY_AT_FAULT                                    = 0x0000017b,
    D3D11_MESSAGE_ID_DEVICE_REMOVAL_PROCESS_NOT_AT_FAULT                                         = 0x0000017c,
    D3D11_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE_INVALIDARG_RETURN                               = 0x0000017d,
    D3D11_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE_OUTOFMEMORY_RETURN                              = 0x0000017e,
    D3D11_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE_BADINTERFACE_RETURN                             = 0x0000017f,
    D3D11_MESSAGE_ID_DEVICE_DRAW_VIEWPORT_NOT_SET                                                = 0x00000180,
    D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_TRAILING_DIGIT_IN_SEMANTIC                                = 0x00000181,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_TRAILING_DIGIT_IN_SEMANTIC             = 0x00000182,
    D3D11_MESSAGE_ID_DEVICE_RSSETVIEWPORTS_DENORMFLUSH                                           = 0x00000183,
    D3D11_MESSAGE_ID_OMSETRENDERTARGETS_INVALIDVIEW                                              = 0x00000184,
    D3D11_MESSAGE_ID_DEVICE_SETTEXTFILTERSIZE_INVALIDDIMENSIONS                                  = 0x00000185,
    D3D11_MESSAGE_ID_DEVICE_DRAW_SAMPLER_MISMATCH                                                = 0x00000186,
    D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_TYPE_MISMATCH                                             = 0x00000187,
    D3D11_MESSAGE_ID_BLENDSTATE_GETDESC_LEGACY                                                   = 0x00000188,
    D3D11_MESSAGE_ID_SHADERRESOURCEVIEW_GETDESC_LEGACY                                           = 0x00000189,
    D3D11_MESSAGE_ID_CREATEQUERY_OUTOFMEMORY_RETURN                                              = 0x0000018a,
    D3D11_MESSAGE_ID_CREATEPREDICATE_OUTOFMEMORY_RETURN                                          = 0x0000018b,
    D3D11_MESSAGE_ID_CREATECOUNTER_OUTOFRANGE_COUNTER                                            = 0x0000018c,
    D3D11_MESSAGE_ID_CREATECOUNTER_SIMULTANEOUS_ACTIVE_COUNTERS_EXHAUSTED                        = 0x0000018d,
    D3D11_MESSAGE_ID_CREATECOUNTER_UNSUPPORTED_WELLKNOWN_COUNTER                                 = 0x0000018e,
    D3D11_MESSAGE_ID_CREATECOUNTER_OUTOFMEMORY_RETURN                                            = 0x0000018f,
    D3D11_MESSAGE_ID_CREATECOUNTER_NONEXCLUSIVE_RETURN                                           = 0x00000190,
    D3D11_MESSAGE_ID_CREATECOUNTER_NULLDESC                                                      = 0x00000191,
    D3D11_MESSAGE_ID_CHECKCOUNTER_OUTOFRANGE_COUNTER                                             = 0x00000192,
    D3D11_MESSAGE_ID_CHECKCOUNTER_UNSUPPORTED_WELLKNOWN_COUNTER                                  = 0x00000193,
    D3D11_MESSAGE_ID_SETPREDICATION_INVALID_PREDICATE_STATE                                      = 0x00000194,
    D3D11_MESSAGE_ID_QUERY_BEGIN_UNSUPPORTED                                                     = 0x00000195,
    D3D11_MESSAGE_ID_PREDICATE_BEGIN_DURING_PREDICATION                                          = 0x00000196,
    D3D11_MESSAGE_ID_QUERY_BEGIN_DUPLICATE                                                       = 0x00000197,
    D3D11_MESSAGE_ID_QUERY_BEGIN_ABANDONING_PREVIOUS_RESULTS                                     = 0x00000198,
    D3D11_MESSAGE_ID_PREDICATE_END_DURING_PREDICATION                                            = 0x00000199,
    D3D11_MESSAGE_ID_QUERY_END_ABANDONING_PREVIOUS_RESULTS                                       = 0x0000019a,
    D3D11_MESSAGE_ID_QUERY_END_WITHOUT_BEGIN                                                     = 0x0000019b,
    D3D11_MESSAGE_ID_QUERY_GETDATA_INVALID_DATASIZE                                              = 0x0000019c,
    D3D11_MESSAGE_ID_QUERY_GETDATA_INVALID_FLAGS                                                 = 0x0000019d,
    D3D11_MESSAGE_ID_QUERY_GETDATA_INVALID_CALL                                                  = 0x0000019e,
    D3D11_MESSAGE_ID_DEVICE_DRAW_PS_OUTPUT_TYPE_MISMATCH                                         = 0x0000019f,
    D3D11_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_GATHER_UNSUPPORTED                              = 0x000001a0,
    D3D11_MESSAGE_ID_DEVICE_DRAW_INVALID_USE_OF_CENTER_MULTISAMPLE_PATTERN                       = 0x000001a1,
    D3D11_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_STRIDE_TOO_LARGE                                  = 0x000001a2,
    D3D11_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_INVALIDRANGE                                      = 0x000001a3,
    D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_EMPTY_LAYOUT                                              = 0x000001a4,
    D3D11_MESSAGE_ID_DEVICE_DRAW_RESOURCE_SAMPLE_COUNT_MISMATCH                                  = 0x000001a5,
    D3D11_MESSAGE_ID_LIVE_OBJECT_SUMMARY                                                         = 0x000001a6,
    D3D11_MESSAGE_ID_LIVE_BUFFER                                                                 = 0x000001a7,
    D3D11_MESSAGE_ID_LIVE_TEXTURE1D                                                              = 0x000001a8,
    D3D11_MESSAGE_ID_LIVE_TEXTURE2D                                                              = 0x000001a9,
    D3D11_MESSAGE_ID_LIVE_TEXTURE3D                                                              = 0x000001aa,
    D3D11_MESSAGE_ID_LIVE_SHADERRESOURCEVIEW                                                     = 0x000001ab,
    D3D11_MESSAGE_ID_LIVE_RENDERTARGETVIEW                                                       = 0x000001ac,
    D3D11_MESSAGE_ID_LIVE_DEPTHSTENCILVIEW                                                       = 0x000001ad,
    D3D11_MESSAGE_ID_LIVE_VERTEXSHADER                                                           = 0x000001ae,
    D3D11_MESSAGE_ID_LIVE_GEOMETRYSHADER                                                         = 0x000001af,
    D3D11_MESSAGE_ID_LIVE_PIXELSHADER                                                            = 0x000001b0,
    D3D11_MESSAGE_ID_LIVE_INPUTLAYOUT                                                            = 0x000001b1,
    D3D11_MESSAGE_ID_LIVE_SAMPLER                                                                = 0x000001b2,
    D3D11_MESSAGE_ID_LIVE_BLENDSTATE                                                             = 0x000001b3,
    D3D11_MESSAGE_ID_LIVE_DEPTHSTENCILSTATE                                                      = 0x000001b4,
    D3D11_MESSAGE_ID_LIVE_RASTERIZERSTATE                                                        = 0x000001b5,
    D3D11_MESSAGE_ID_LIVE_QUERY                                                                  = 0x000001b6,
    D3D11_MESSAGE_ID_LIVE_PREDICATE                                                              = 0x000001b7,
    D3D11_MESSAGE_ID_LIVE_COUNTER                                                                = 0x000001b8,
    D3D11_MESSAGE_ID_LIVE_DEVICE                                                                 = 0x000001b9,
    D3D11_MESSAGE_ID_LIVE_SWAPCHAIN                                                              = 0x000001ba,
    D3D11_MESSAGE_ID_D3D10_MESSAGES_END                                                          = 0x000001bb,
    D3D11_MESSAGE_ID_D3D10L9_MESSAGES_START                                                      = 0x00100000,
    D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_STENCIL_NO_TWO_SIDED                                = 0x00100001,
    D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_DepthBiasClamp_NOT_SUPPORTED                          = 0x00100002,
    D3D11_MESSAGE_ID_CREATESAMPLERSTATE_NO_COMPARISON_SUPPORT                                    = 0x00100003,
    D3D11_MESSAGE_ID_CREATESAMPLERSTATE_EXCESSIVE_ANISOTROPY                                     = 0x00100004,
    D3D11_MESSAGE_ID_CREATESAMPLERSTATE_BORDER_OUT_OF_RANGE                                      = 0x00100005,
    D3D11_MESSAGE_ID_VSSETSAMPLERS_NOT_SUPPORTED                                                 = 0x00100006,
    D3D11_MESSAGE_ID_VSSETSAMPLERS_TOO_MANY_SAMPLERS                                             = 0x00100007,
    D3D11_MESSAGE_ID_PSSETSAMPLERS_TOO_MANY_SAMPLERS                                             = 0x00100008,
    D3D11_MESSAGE_ID_CREATERESOURCE_NO_ARRAYS                                                    = 0x00100009,
    D3D11_MESSAGE_ID_CREATERESOURCE_NO_VB_AND_IB_BIND                                            = 0x0010000a,
    D3D11_MESSAGE_ID_CREATERESOURCE_NO_TEXTURE_1D                                                = 0x0010000b,
    D3D11_MESSAGE_ID_CREATERESOURCE_DIMENSION_OUT_OF_RANGE                                       = 0x0010000c,
    D3D11_MESSAGE_ID_CREATERESOURCE_NOT_BINDABLE_AS_SHADER_RESOURCE                              = 0x0010000d,
    D3D11_MESSAGE_ID_OMSETRENDERTARGETS_TOO_MANY_RENDER_TARGETS                                  = 0x0010000e,
    D3D11_MESSAGE_ID_OMSETRENDERTARGETS_NO_DIFFERING_BIT_DEPTHS                                  = 0x0010000f,
    D3D11_MESSAGE_ID_IASETVERTEXBUFFERS_BAD_BUFFER_INDEX                                         = 0x00100010,
    D3D11_MESSAGE_ID_DEVICE_RSSETVIEWPORTS_TOO_MANY_VIEWPORTS                                    = 0x00100011,
    D3D11_MESSAGE_ID_DEVICE_IASETPRIMITIVETOPOLOGY_ADJACENCY_UNSUPPORTED                         = 0x00100012,
    D3D11_MESSAGE_ID_DEVICE_RSSETSCISSORRECTS_TOO_MANY_SCISSORS                                  = 0x00100013,
    D3D11_MESSAGE_ID_COPYRESOURCE_ONLY_TEXTURE_2D_WITHIN_GPU_MEMORY                              = 0x00100014,
    D3D11_MESSAGE_ID_COPYRESOURCE_NO_TEXTURE_3D_READBACK                                         = 0x00100015,
    D3D11_MESSAGE_ID_COPYRESOURCE_NO_TEXTURE_ONLY_READBACK                                       = 0x00100016,
    D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_UNSUPPORTED_FORMAT                                        = 0x00100017,
    D3D11_MESSAGE_ID_CREATEBLENDSTATE_NO_ALPHA_TO_COVERAGE                                       = 0x00100018,
    D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_DepthClipEnable_MUST_BE_TRUE                          = 0x00100019,
    D3D11_MESSAGE_ID_DRAWINDEXED_STARTINDEXLOCATION_MUST_BE_POSITIVE                             = 0x0010001a,
    D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_MUST_USE_LOWEST_LOD                                = 0x0010001b,
    D3D11_MESSAGE_ID_CREATESAMPLERSTATE_MINLOD_MUST_NOT_BE_FRACTIONAL                            = 0x0010001c,
    D3D11_MESSAGE_ID_CREATESAMPLERSTATE_MAXLOD_MUST_BE_FLT_MAX                                   = 0x0010001d,
    D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_FIRSTARRAYSLICE_MUST_BE_ZERO                       = 0x0010001e,
    D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_CUBES_MUST_HAVE_6_SIDES                            = 0x0010001f,
    D3D11_MESSAGE_ID_CREATERESOURCE_NOT_BINDABLE_AS_RENDER_TARGET                                = 0x00100020,
    D3D11_MESSAGE_ID_CREATERESOURCE_NO_DWORD_INDEX_BUFFER                                        = 0x00100021,
    D3D11_MESSAGE_ID_CREATERESOURCE_MSAA_PRECLUDES_SHADER_RESOURCE                               = 0x00100022,
    D3D11_MESSAGE_ID_CREATERESOURCE_PRESENTATION_PRECLUDES_SHADER_RESOURCE                       = 0x00100023,
    D3D11_MESSAGE_ID_CREATEBLENDSTATE_NO_INDEPENDENT_BLEND_ENABLE                                = 0x00100024,
    D3D11_MESSAGE_ID_CREATEBLENDSTATE_NO_INDEPENDENT_WRITE_MASKS                                 = 0x00100025,
    D3D11_MESSAGE_ID_CREATERESOURCE_NO_STREAM_OUT                                                = 0x00100026,
    D3D11_MESSAGE_ID_CREATERESOURCE_ONLY_VB_IB_FOR_BUFFERS                                       = 0x00100027,
    D3D11_MESSAGE_ID_CREATERESOURCE_NO_AUTOGEN_FOR_VOLUMES                                       = 0x00100028,
    D3D11_MESSAGE_ID_CREATERESOURCE_DXGI_FORMAT_R8G8B8A8_CANNOT_BE_SHARED                        = 0x00100029,
    D3D11_MESSAGE_ID_VSSHADERRESOURCES_NOT_SUPPORTED                                             = 0x0010002a,
    D3D11_MESSAGE_ID_GEOMETRY_SHADER_NOT_SUPPORTED                                               = 0x0010002b,
    D3D11_MESSAGE_ID_STREAM_OUT_NOT_SUPPORTED                                                    = 0x0010002c,
    D3D11_MESSAGE_ID_TEXT_FILTER_NOT_SUPPORTED                                                   = 0x0010002d,
    D3D11_MESSAGE_ID_CREATEBLENDSTATE_NO_SEPARATE_ALPHA_BLEND                                    = 0x0010002e,
    D3D11_MESSAGE_ID_CREATEBLENDSTATE_NO_MRT_BLEND                                               = 0x0010002f,
    D3D11_MESSAGE_ID_CREATEBLENDSTATE_OPERATION_NOT_SUPPORTED                                    = 0x00100030,
    D3D11_MESSAGE_ID_CREATESAMPLERSTATE_NO_MIRRORONCE                                            = 0x00100031,
    D3D11_MESSAGE_ID_DRAWINSTANCED_NOT_SUPPORTED                                                 = 0x00100032,
    D3D11_MESSAGE_ID_DRAWINDEXEDINSTANCED_NOT_SUPPORTED_BELOW_9_3                                = 0x00100033,
    D3D11_MESSAGE_ID_DRAWINDEXED_POINTLIST_UNSUPPORTED                                           = 0x00100034,
    D3D11_MESSAGE_ID_SETBLENDSTATE_SAMPLE_MASK_CANNOT_BE_ZERO                                    = 0x00100035,
    D3D11_MESSAGE_ID_CREATERESOURCE_DIMENSION_EXCEEDS_FEATURE_LEVEL_DEFINITION                   = 0x00100036,
    D3D11_MESSAGE_ID_CREATERESOURCE_ONLY_SINGLE_MIP_LEVEL_DEPTH_STENCIL_SUPPORTED                = 0x00100037,
    D3D11_MESSAGE_ID_DEVICE_RSSETSCISSORRECTS_NEGATIVESCISSOR                                    = 0x00100038,
    D3D11_MESSAGE_ID_SLOT_ZERO_MUST_BE_D3D10_INPUT_PER_VERTEX_DATA                               = 0x00100039,
    D3D11_MESSAGE_ID_CREATERESOURCE_NON_POW_2_MIPMAP                                             = 0x0010003a,
    D3D11_MESSAGE_ID_CREATESAMPLERSTATE_BORDER_NOT_SUPPORTED                                     = 0x0010003b,
    D3D11_MESSAGE_ID_OMSETRENDERTARGETS_NO_SRGB_MRT                                              = 0x0010003c,
    D3D11_MESSAGE_ID_COPYRESOURCE_NO_3D_MISMATCHED_UPDATES                                       = 0x0010003d,
    D3D11_MESSAGE_ID_D3D10L9_MESSAGES_END                                                        = 0x0010003e,
    D3D11_MESSAGE_ID_D3D11_MESSAGES_START                                                        = 0x00200000,
    D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDFLAGS                                         = 0x00200001,
    D3D11_MESSAGE_ID_CREATEVERTEXSHADER_INVALIDCLASSLINKAGE                                      = 0x00200002,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADER_INVALIDCLASSLINKAGE                                    = 0x00200003,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDNUMSTREAMS                      = 0x00200004,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSTREAMTORASTERIZER              = 0x00200005,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UNEXPECTEDSTREAMS                      = 0x00200006,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDCLASSLINKAGE                    = 0x00200007,
    D3D11_MESSAGE_ID_CREATEPIXELSHADER_INVALIDCLASSLINKAGE                                       = 0x00200008,
    D3D11_MESSAGE_ID_CREATEDEFERREDCONTEXT_INVALID_COMMANDLISTFLAGS                              = 0x00200009,
    D3D11_MESSAGE_ID_CREATEDEFERREDCONTEXT_SINGLETHREADED                                        = 0x0020000a,
    D3D11_MESSAGE_ID_CREATEDEFERREDCONTEXT_INVALIDARG_RETURN                                     = 0x0020000b,
    D3D11_MESSAGE_ID_CREATEDEFERREDCONTEXT_INVALID_CALL_RETURN                                   = 0x0020000c,
    D3D11_MESSAGE_ID_CREATEDEFERREDCONTEXT_OUTOFMEMORY_RETURN                                    = 0x0020000d,
    D3D11_MESSAGE_ID_FINISHDISPLAYLIST_ONIMMEDIATECONTEXT                                        = 0x0020000e,
    D3D11_MESSAGE_ID_FINISHDISPLAYLIST_OUTOFMEMORY_RETURN                                        = 0x0020000f,
    D3D11_MESSAGE_ID_FINISHDISPLAYLIST_INVALID_CALL_RETURN                                       = 0x00200010,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSTREAM                          = 0x00200011,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UNEXPECTEDENTRIES                      = 0x00200012,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UNEXPECTEDSTRIDES                      = 0x00200013,
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDNUMSTRIDES                      = 0x00200014,
    D3D11_MESSAGE_ID_DEVICE_HSSETSHADERRESOURCES_HAZARD                                          = 0x00200015,
    D3D11_MESSAGE_ID_DEVICE_HSSETCONSTANTBUFFERS_HAZARD                                          = 0x00200016,
    D3D11_MESSAGE_ID_HSSETSHADERRESOURCES_UNBINDDELETINGOBJECT                                   = 0x00200017,
    D3D11_MESSAGE_ID_HSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT                                   = 0x00200018,
    D3D11_MESSAGE_ID_CREATEHULLSHADER_INVALIDCALL                                                = 0x00200019,
    D3D11_MESSAGE_ID_CREATEHULLSHADER_OUTOFMEMORY                                                = 0x0020001a,
    D3D11_MESSAGE_ID_CREATEHULLSHADER_INVALIDSHADERBYTECODE                                      = 0x0020001b,
    D3D11_MESSAGE_ID_CREATEHULLSHADER_INVALIDSHADERTYPE                                          = 0x0020001c,
    D3D11_MESSAGE_ID_CREATEHULLSHADER_INVALIDCLASSLINKAGE                                        = 0x0020001d,
    D3D11_MESSAGE_ID_DEVICE_HSSETSHADERRESOURCES_VIEWS_EMPTY                                     = 0x0020001e,
    D3D11_MESSAGE_ID_HSSETCONSTANTBUFFERS_INVALIDBUFFER                                          = 0x0020001f,
    D3D11_MESSAGE_ID_DEVICE_HSSETCONSTANTBUFFERS_BUFFERS_EMPTY                                   = 0x00200020,
    D3D11_MESSAGE_ID_DEVICE_HSSETSAMPLERS_SAMPLERS_EMPTY                                         = 0x00200021,
    D3D11_MESSAGE_ID_DEVICE_HSGETSHADERRESOURCES_VIEWS_EMPTY                                     = 0x00200022,
    D3D11_MESSAGE_ID_DEVICE_HSGETCONSTANTBUFFERS_BUFFERS_EMPTY                                   = 0x00200023,
    D3D11_MESSAGE_ID_DEVICE_HSGETSAMPLERS_SAMPLERS_EMPTY                                         = 0x00200024,
    D3D11_MESSAGE_ID_DEVICE_DSSETSHADERRESOURCES_HAZARD                                          = 0x00200025,
    D3D11_MESSAGE_ID_DEVICE_DSSETCONSTANTBUFFERS_HAZARD                                          = 0x00200026,
    D3D11_MESSAGE_ID_DSSETSHADERRESOURCES_UNBINDDELETINGOBJECT                                   = 0x00200027,
    D3D11_MESSAGE_ID_DSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT                                   = 0x00200028,
    D3D11_MESSAGE_ID_CREATEDOMAINSHADER_INVALIDCALL                                              = 0x00200029,
    D3D11_MESSAGE_ID_CREATEDOMAINSHADER_OUTOFMEMORY                                              = 0x0020002a,
    D3D11_MESSAGE_ID_CREATEDOMAINSHADER_INVALIDSHADERBYTECODE                                    = 0x0020002b,
    D3D11_MESSAGE_ID_CREATEDOMAINSHADER_INVALIDSHADERTYPE                                        = 0x0020002c,
    D3D11_MESSAGE_ID_CREATEDOMAINSHADER_INVALIDCLASSLINKAGE                                      = 0x0020002d,
    D3D11_MESSAGE_ID_DEVICE_DSSETSHADERRESOURCES_VIEWS_EMPTY                                     = 0x0020002e,
    D3D11_MESSAGE_ID_DSSETCONSTANTBUFFERS_INVALIDBUFFER                                          = 0x0020002f,
    D3D11_MESSAGE_ID_DEVICE_DSSETCONSTANTBUFFERS_BUFFERS_EMPTY                                   = 0x00200030,
    D3D11_MESSAGE_ID_DEVICE_DSSETSAMPLERS_SAMPLERS_EMPTY                                         = 0x00200031,
    D3D11_MESSAGE_ID_DEVICE_DSGETSHADERRESOURCES_VIEWS_EMPTY                                     = 0x00200032,
    D3D11_MESSAGE_ID_DEVICE_DSGETCONSTANTBUFFERS_BUFFERS_EMPTY                                   = 0x00200033,
    D3D11_MESSAGE_ID_DEVICE_DSGETSAMPLERS_SAMPLERS_EMPTY                                         = 0x00200034,
    D3D11_MESSAGE_ID_DEVICE_DRAW_HS_XOR_DS_MISMATCH                                              = 0x00200035,
    D3D11_MESSAGE_ID_DEFERRED_CONTEXT_REMOVAL_PROCESS_AT_FAULT                                   = 0x00200036,
    D3D11_MESSAGE_ID_DEVICE_DRAWINDIRECT_INVALID_ARG_BUFFER                                      = 0x00200037,
    D3D11_MESSAGE_ID_DEVICE_DRAWINDIRECT_OFFSET_UNALIGNED                                        = 0x00200038,
    D3D11_MESSAGE_ID_DEVICE_DRAWINDIRECT_OFFSET_OVERFLOW                                         = 0x00200039,
    D3D11_MESSAGE_ID_RESOURCE_MAP_INVALIDMAPTYPE                                                 = 0x0020003a,
    D3D11_MESSAGE_ID_RESOURCE_MAP_INVALIDSUBRESOURCE                                             = 0x0020003b,
    D3D11_MESSAGE_ID_RESOURCE_MAP_INVALIDFLAGS                                                   = 0x0020003c,
    D3D11_MESSAGE_ID_RESOURCE_MAP_ALREADYMAPPED                                                  = 0x0020003d,
    D3D11_MESSAGE_ID_RESOURCE_MAP_DEVICEREMOVED_RETURN                                           = 0x0020003e,
    D3D11_MESSAGE_ID_RESOURCE_MAP_OUTOFMEMORY_RETURN                                             = 0x0020003f,
    D3D11_MESSAGE_ID_RESOURCE_MAP_WITHOUT_INITIAL_DISCARD                                        = 0x00200040,
    D3D11_MESSAGE_ID_RESOURCE_UNMAP_INVALIDSUBRESOURCE                                           = 0x00200041,
    D3D11_MESSAGE_ID_RESOURCE_UNMAP_NOTMAPPED                                                    = 0x00200042,
    D3D11_MESSAGE_ID_DEVICE_DRAW_RASTERIZING_CONTROL_POINTS                                      = 0x00200043,
    D3D11_MESSAGE_ID_DEVICE_IASETPRIMITIVETOPOLOGY_TOPOLOGY_UNSUPPORTED                          = 0x00200044,
    D3D11_MESSAGE_ID_DEVICE_DRAW_HS_DS_SIGNATURE_MISMATCH                                        = 0x00200045,
    D3D11_MESSAGE_ID_DEVICE_DRAW_HULL_SHADER_INPUT_TOPOLOGY_MISMATCH                             = 0x00200046,
    D3D11_MESSAGE_ID_DEVICE_DRAW_HS_DS_CONTROL_POINT_COUNT_MISMATCH                              = 0x00200047,
    D3D11_MESSAGE_ID_DEVICE_DRAW_HS_DS_TESSELLATOR_DOMAIN_MISMATCH                               = 0x00200048,
    D3D11_MESSAGE_ID_CREATE_CONTEXT                                                              = 0x00200049,
    D3D11_MESSAGE_ID_LIVE_CONTEXT                                                                = 0x0020004a,
    D3D11_MESSAGE_ID_DESTROY_CONTEXT                                                             = 0x0020004b,
    D3D11_MESSAGE_ID_CREATE_BUFFER                                                               = 0x0020004c,
    D3D11_MESSAGE_ID_LIVE_BUFFER_WIN7                                                            = 0x0020004d,
    D3D11_MESSAGE_ID_DESTROY_BUFFER                                                              = 0x0020004e,
    D3D11_MESSAGE_ID_CREATE_TEXTURE1D                                                            = 0x0020004f,
    D3D11_MESSAGE_ID_LIVE_TEXTURE1D_WIN7                                                         = 0x00200050,
    D3D11_MESSAGE_ID_DESTROY_TEXTURE1D                                                           = 0x00200051,
    D3D11_MESSAGE_ID_CREATE_TEXTURE2D                                                            = 0x00200052,
    D3D11_MESSAGE_ID_LIVE_TEXTURE2D_WIN7                                                         = 0x00200053,
    D3D11_MESSAGE_ID_DESTROY_TEXTURE2D                                                           = 0x00200054,
    D3D11_MESSAGE_ID_CREATE_TEXTURE3D                                                            = 0x00200055,
    D3D11_MESSAGE_ID_LIVE_TEXTURE3D_WIN7                                                         = 0x00200056,
    D3D11_MESSAGE_ID_DESTROY_TEXTURE3D                                                           = 0x00200057,
    D3D11_MESSAGE_ID_CREATE_SHADERRESOURCEVIEW                                                   = 0x00200058,
    D3D11_MESSAGE_ID_LIVE_SHADERRESOURCEVIEW_WIN7                                                = 0x00200059,
    D3D11_MESSAGE_ID_DESTROY_SHADERRESOURCEVIEW                                                  = 0x0020005a,
    D3D11_MESSAGE_ID_CREATE_RENDERTARGETVIEW                                                     = 0x0020005b,
    D3D11_MESSAGE_ID_LIVE_RENDERTARGETVIEW_WIN7                                                  = 0x0020005c,
    D3D11_MESSAGE_ID_DESTROY_RENDERTARGETVIEW                                                    = 0x0020005d,
    D3D11_MESSAGE_ID_CREATE_DEPTHSTENCILVIEW                                                     = 0x0020005e,
    D3D11_MESSAGE_ID_LIVE_DEPTHSTENCILVIEW_WIN7                                                  = 0x0020005f,
    D3D11_MESSAGE_ID_DESTROY_DEPTHSTENCILVIEW                                                    = 0x00200060,
    D3D11_MESSAGE_ID_CREATE_VERTEXSHADER                                                         = 0x00200061,
    D3D11_MESSAGE_ID_LIVE_VERTEXSHADER_WIN7                                                      = 0x00200062,
    D3D11_MESSAGE_ID_DESTROY_VERTEXSHADER                                                        = 0x00200063,
    D3D11_MESSAGE_ID_CREATE_HULLSHADER                                                           = 0x00200064,
    D3D11_MESSAGE_ID_LIVE_HULLSHADER                                                             = 0x00200065,
    D3D11_MESSAGE_ID_DESTROY_HULLSHADER                                                          = 0x00200066,
    D3D11_MESSAGE_ID_CREATE_DOMAINSHADER                                                         = 0x00200067,
    D3D11_MESSAGE_ID_LIVE_DOMAINSHADER                                                           = 0x00200068,
    D3D11_MESSAGE_ID_DESTROY_DOMAINSHADER                                                        = 0x00200069,
    D3D11_MESSAGE_ID_CREATE_GEOMETRYSHADER                                                       = 0x0020006a,
    D3D11_MESSAGE_ID_LIVE_GEOMETRYSHADER_WIN7                                                    = 0x0020006b,
    D3D11_MESSAGE_ID_DESTROY_GEOMETRYSHADER                                                      = 0x0020006c,
    D3D11_MESSAGE_ID_CREATE_PIXELSHADER                                                          = 0x0020006d,
    D3D11_MESSAGE_ID_LIVE_PIXELSHADER_WIN7                                                       = 0x0020006e,
    D3D11_MESSAGE_ID_DESTROY_PIXELSHADER                                                         = 0x0020006f,
    D3D11_MESSAGE_ID_CREATE_INPUTLAYOUT                                                          = 0x00200070,
    D3D11_MESSAGE_ID_LIVE_INPUTLAYOUT_WIN7                                                       = 0x00200071,
    D3D11_MESSAGE_ID_DESTROY_INPUTLAYOUT                                                         = 0x00200072,
    D3D11_MESSAGE_ID_CREATE_SAMPLER                                                              = 0x00200073,
    D3D11_MESSAGE_ID_LIVE_SAMPLER_WIN7                                                           = 0x00200074,
    D3D11_MESSAGE_ID_DESTROY_SAMPLER                                                             = 0x00200075,
    D3D11_MESSAGE_ID_CREATE_BLENDSTATE                                                           = 0x00200076,
    D3D11_MESSAGE_ID_LIVE_BLENDSTATE_WIN7                                                        = 0x00200077,
    D3D11_MESSAGE_ID_DESTROY_BLENDSTATE                                                          = 0x00200078,
    D3D11_MESSAGE_ID_CREATE_DEPTHSTENCILSTATE                                                    = 0x00200079,
    D3D11_MESSAGE_ID_LIVE_DEPTHSTENCILSTATE_WIN7                                                 = 0x0020007a,
    D3D11_MESSAGE_ID_DESTROY_DEPTHSTENCILSTATE                                                   = 0x0020007b,
    D3D11_MESSAGE_ID_CREATE_RASTERIZERSTATE                                                      = 0x0020007c,
    D3D11_MESSAGE_ID_LIVE_RASTERIZERSTATE_WIN7                                                   = 0x0020007d,
    D3D11_MESSAGE_ID_DESTROY_RASTERIZERSTATE                                                     = 0x0020007e,
    D3D11_MESSAGE_ID_CREATE_QUERY                                                                = 0x0020007f,
    D3D11_MESSAGE_ID_LIVE_QUERY_WIN7                                                             = 0x00200080,
    D3D11_MESSAGE_ID_DESTROY_QUERY                                                               = 0x00200081,
    D3D11_MESSAGE_ID_CREATE_PREDICATE                                                            = 0x00200082,
    D3D11_MESSAGE_ID_LIVE_PREDICATE_WIN7                                                         = 0x00200083,
    D3D11_MESSAGE_ID_DESTROY_PREDICATE                                                           = 0x00200084,
    D3D11_MESSAGE_ID_CREATE_COUNTER                                                              = 0x00200085,
    D3D11_MESSAGE_ID_DESTROY_COUNTER                                                             = 0x00200086,
    D3D11_MESSAGE_ID_CREATE_COMMANDLIST                                                          = 0x00200087,
    D3D11_MESSAGE_ID_LIVE_COMMANDLIST                                                            = 0x00200088,
    D3D11_MESSAGE_ID_DESTROY_COMMANDLIST                                                         = 0x00200089,
    D3D11_MESSAGE_ID_CREATE_CLASSINSTANCE                                                        = 0x0020008a,
    D3D11_MESSAGE_ID_LIVE_CLASSINSTANCE                                                          = 0x0020008b,
    D3D11_MESSAGE_ID_DESTROY_CLASSINSTANCE                                                       = 0x0020008c,
    D3D11_MESSAGE_ID_CREATE_CLASSLINKAGE                                                         = 0x0020008d,
    D3D11_MESSAGE_ID_LIVE_CLASSLINKAGE                                                           = 0x0020008e,
    D3D11_MESSAGE_ID_DESTROY_CLASSLINKAGE                                                        = 0x0020008f,
    D3D11_MESSAGE_ID_LIVE_DEVICE_WIN7                                                            = 0x00200090,
    D3D11_MESSAGE_ID_LIVE_OBJECT_SUMMARY_WIN7                                                    = 0x00200091,
    D3D11_MESSAGE_ID_CREATE_COMPUTESHADER                                                        = 0x00200092,
    D3D11_MESSAGE_ID_LIVE_COMPUTESHADER                                                          = 0x00200093,
    D3D11_MESSAGE_ID_DESTROY_COMPUTESHADER                                                       = 0x00200094,
    D3D11_MESSAGE_ID_CREATE_UNORDEREDACCESSVIEW                                                  = 0x00200095,
    D3D11_MESSAGE_ID_LIVE_UNORDEREDACCESSVIEW                                                    = 0x00200096,
    D3D11_MESSAGE_ID_DESTROY_UNORDEREDACCESSVIEW                                                 = 0x00200097,
    D3D11_MESSAGE_ID_DEVICE_SETSHADER_INTERFACES_FEATURELEVEL                                    = 0x00200098,
    D3D11_MESSAGE_ID_DEVICE_SETSHADER_INTERFACE_COUNT_MISMATCH                                   = 0x00200099,
    D3D11_MESSAGE_ID_DEVICE_SETSHADER_INVALID_INSTANCE                                           = 0x0020009a,
    D3D11_MESSAGE_ID_DEVICE_SETSHADER_INVALID_INSTANCE_INDEX                                     = 0x0020009b,
    D3D11_MESSAGE_ID_DEVICE_SETSHADER_INVALID_INSTANCE_TYPE                                      = 0x0020009c,
    D3D11_MESSAGE_ID_DEVICE_SETSHADER_INVALID_INSTANCE_DATA                                      = 0x0020009d,
    D3D11_MESSAGE_ID_DEVICE_SETSHADER_UNBOUND_INSTANCE_DATA                                      = 0x0020009e,
    D3D11_MESSAGE_ID_DEVICE_SETSHADER_INSTANCE_DATA_BINDINGS                                     = 0x0020009f,
    D3D11_MESSAGE_ID_DEVICE_CREATESHADER_CLASSLINKAGE_FULL                                       = 0x002000a0,
    D3D11_MESSAGE_ID_DEVICE_CHECKFEATURESUPPORT_UNRECOGNIZED_FEATURE                             = 0x002000a1,
    D3D11_MESSAGE_ID_DEVICE_CHECKFEATURESUPPORT_MISMATCHED_DATA_SIZE                             = 0x002000a2,
    D3D11_MESSAGE_ID_DEVICE_CHECKFEATURESUPPORT_INVALIDARG_RETURN                                = 0x002000a3,
    D3D11_MESSAGE_ID_DEVICE_CSSETSHADERRESOURCES_HAZARD                                          = 0x002000a4,
    D3D11_MESSAGE_ID_DEVICE_CSSETCONSTANTBUFFERS_HAZARD                                          = 0x002000a5,
    D3D11_MESSAGE_ID_CSSETSHADERRESOURCES_UNBINDDELETINGOBJECT                                   = 0x002000a6,
    D3D11_MESSAGE_ID_CSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT                                   = 0x002000a7,
    D3D11_MESSAGE_ID_CREATECOMPUTESHADER_INVALIDCALL                                             = 0x002000a8,
    D3D11_MESSAGE_ID_CREATECOMPUTESHADER_OUTOFMEMORY                                             = 0x002000a9,
    D3D11_MESSAGE_ID_CREATECOMPUTESHADER_INVALIDSHADERBYTECODE                                   = 0x002000aa,
    D3D11_MESSAGE_ID_CREATECOMPUTESHADER_INVALIDSHADERTYPE                                       = 0x002000ab,
    D3D11_MESSAGE_ID_CREATECOMPUTESHADER_INVALIDCLASSLINKAGE                                     = 0x002000ac,
    D3D11_MESSAGE_ID_DEVICE_CSSETSHADERRESOURCES_VIEWS_EMPTY                                     = 0x002000ad,
    D3D11_MESSAGE_ID_CSSETCONSTANTBUFFERS_INVALIDBUFFER                                          = 0x002000ae,
    D3D11_MESSAGE_ID_DEVICE_CSSETCONSTANTBUFFERS_BUFFERS_EMPTY                                   = 0x002000af,
    D3D11_MESSAGE_ID_DEVICE_CSSETSAMPLERS_SAMPLERS_EMPTY                                         = 0x002000b0,
    D3D11_MESSAGE_ID_DEVICE_CSGETSHADERRESOURCES_VIEWS_EMPTY                                     = 0x002000b1,
    D3D11_MESSAGE_ID_DEVICE_CSGETCONSTANTBUFFERS_BUFFERS_EMPTY                                   = 0x002000b2,
    D3D11_MESSAGE_ID_DEVICE_CSGETSAMPLERS_SAMPLERS_EMPTY                                         = 0x002000b3,
    D3D11_MESSAGE_ID_DEVICE_CREATEVERTEXSHADER_DOUBLEFLOATOPSNOTSUPPORTED                        = 0x002000b4,
    D3D11_MESSAGE_ID_DEVICE_CREATEHULLSHADER_DOUBLEFLOATOPSNOTSUPPORTED                          = 0x002000b5,
    D3D11_MESSAGE_ID_DEVICE_CREATEDOMAINSHADER_DOUBLEFLOATOPSNOTSUPPORTED                        = 0x002000b6,
    D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADER_DOUBLEFLOATOPSNOTSUPPORTED                      = 0x002000b7,
    D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_DOUBLEFLOATOPSNOTSUPPORTED      = 0x002000b8,
    D3D11_MESSAGE_ID_DEVICE_CREATEPIXELSHADER_DOUBLEFLOATOPSNOTSUPPORTED                         = 0x002000b9,
    D3D11_MESSAGE_ID_DEVICE_CREATECOMPUTESHADER_DOUBLEFLOATOPSNOTSUPPORTED                       = 0x002000ba,
    D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDSTRUCTURESTRIDE                                         = 0x002000bb,
    D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDFLAGS                                       = 0x002000bc,
    D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDRESOURCE                                   = 0x002000bd,
    D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDDESC                                       = 0x002000be,
    D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDFORMAT                                     = 0x002000bf,
    D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDDIMENSIONS                                 = 0x002000c0,
    D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_UNRECOGNIZEDFORMAT                                = 0x002000c1,
    D3D11_MESSAGE_ID_DEVICE_OMSETRENDERTARGETSANDUNORDEREDACCESSVIEWS_HAZARD                     = 0x002000c2,
    D3D11_MESSAGE_ID_DEVICE_OMSETRENDERTARGETSANDUNORDEREDACCESSVIEWS_OVERLAPPING_OLD_SLOTS      = 0x002000c3,
    D3D11_MESSAGE_ID_DEVICE_OMSETRENDERTARGETSANDUNORDEREDACCESSVIEWS_NO_OP                      = 0x002000c4,
    D3D11_MESSAGE_ID_CSSETUNORDEREDACCESSVIEWS_UNBINDDELETINGOBJECT                              = 0x002000c5,
    D3D11_MESSAGE_ID_PSSETUNORDEREDACCESSVIEWS_UNBINDDELETINGOBJECT                              = 0x002000c6,
    D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDARG_RETURN                                 = 0x002000c7,
    D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_OUTOFMEMORY_RETURN                                = 0x002000c8,
    D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_TOOMANYOBJECTS                                    = 0x002000c9,
    D3D11_MESSAGE_ID_DEVICE_CSSETUNORDEREDACCESSVIEWS_HAZARD                                     = 0x002000ca,
    D3D11_MESSAGE_ID_CLEARUNORDEREDACCESSVIEW_DENORMFLUSH                                        = 0x002000cb,
    D3D11_MESSAGE_ID_DEVICE_CSSETUNORDEREDACCESSS_VIEWS_EMPTY                                    = 0x002000cc,
    D3D11_MESSAGE_ID_DEVICE_CSGETUNORDEREDACCESSS_VIEWS_EMPTY                                    = 0x002000cd,
    D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDFLAGS                                      = 0x002000ce,
    D3D11_MESSAGE_ID_CREATESHADERRESESOURCEVIEW_TOOMANYOBJECTS                                   = 0x002000cf,
    D3D11_MESSAGE_ID_DEVICE_DISPATCHINDIRECT_INVALID_ARG_BUFFER                                  = 0x002000d0,
    D3D11_MESSAGE_ID_DEVICE_DISPATCHINDIRECT_OFFSET_UNALIGNED                                    = 0x002000d1,
    D3D11_MESSAGE_ID_DEVICE_DISPATCHINDIRECT_OFFSET_OVERFLOW                                     = 0x002000d2,
    D3D11_MESSAGE_ID_DEVICE_SETRESOURCEMINLOD_INVALIDCONTEXT                                     = 0x002000d3,
    D3D11_MESSAGE_ID_DEVICE_SETRESOURCEMINLOD_INVALIDRESOURCE                                    = 0x002000d4,
    D3D11_MESSAGE_ID_DEVICE_SETRESOURCEMINLOD_INVALIDMINLOD                                      = 0x002000d5,
    D3D11_MESSAGE_ID_DEVICE_GETRESOURCEMINLOD_INVALIDCONTEXT                                     = 0x002000d6,
    D3D11_MESSAGE_ID_DEVICE_GETRESOURCEMINLOD_INVALIDRESOURCE                                    = 0x002000d7,
    D3D11_MESSAGE_ID_OMSETDEPTHSTENCIL_UNBINDDELETINGOBJECT                                      = 0x002000d8,
    D3D11_MESSAGE_ID_CLEARDEPTHSTENCILVIEW_DEPTH_READONLY                                        = 0x002000d9,
    D3D11_MESSAGE_ID_CLEARDEPTHSTENCILVIEW_STENCIL_READONLY                                      = 0x002000da,
    D3D11_MESSAGE_ID_CHECKFEATURESUPPORT_FORMAT_DEPRECATED                                       = 0x002000db,
    D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_RETURN_TYPE_MISMATCH                             = 0x002000dc,
    D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_NOT_SET                                          = 0x002000dd,
    D3D11_MESSAGE_ID_DEVICE_DRAW_UNORDEREDACCESSVIEW_RENDERTARGETVIEW_OVERLAP                    = 0x002000de,
    D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_DIMENSION_MISMATCH                               = 0x002000df,
    D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_APPEND_UNSUPPORTED                               = 0x002000e0,
    D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_ATOMICS_UNSUPPORTED                              = 0x002000e1,
    D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_STRUCTURE_STRIDE_MISMATCH                        = 0x002000e2,
    D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_BUFFER_TYPE_MISMATCH                             = 0x002000e3,
    D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_RAW_UNSUPPORTED                                  = 0x002000e4,
    D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_FORMAT_LD_UNSUPPORTED                            = 0x002000e5,
    D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_FORMAT_STORE_UNSUPPORTED                         = 0x002000e6,
    D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_ATOMIC_ADD_UNSUPPORTED                           = 0x002000e7,
    D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_ATOMIC_BITWISE_OPS_UNSUPPORTED                   = 0x002000e8,
    D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_ATOMIC_CMPSTORE_CMPEXCHANGE_UNSUPPORTED          = 0x002000e9,
    D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_ATOMIC_EXCHANGE_UNSUPPORTED                      = 0x002000ea,
    D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_ATOMIC_SIGNED_MINMAX_UNSUPPORTED                 = 0x002000eb,
    D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_ATOMIC_UNSIGNED_MINMAX_UNSUPPORTED               = 0x002000ec,
    D3D11_MESSAGE_ID_DEVICE_DISPATCH_BOUND_RESOURCE_MAPPED                                       = 0x002000ed,
    D3D11_MESSAGE_ID_DEVICE_DISPATCH_THREADGROUPCOUNT_OVERFLOW                                   = 0x002000ee,
    D3D11_MESSAGE_ID_DEVICE_DISPATCH_THREADGROUPCOUNT_ZERO                                       = 0x002000ef,
    D3D11_MESSAGE_ID_DEVICE_SHADERRESOURCEVIEW_STRUCTURE_STRIDE_MISMATCH                         = 0x002000f0,
    D3D11_MESSAGE_ID_DEVICE_SHADERRESOURCEVIEW_BUFFER_TYPE_MISMATCH                              = 0x002000f1,
    D3D11_MESSAGE_ID_DEVICE_SHADERRESOURCEVIEW_RAW_UNSUPPORTED                                   = 0x002000f2,
    D3D11_MESSAGE_ID_DEVICE_DISPATCH_UNSUPPORTED                                                 = 0x002000f3,
    D3D11_MESSAGE_ID_DEVICE_DISPATCHINDIRECT_UNSUPPORTED                                         = 0x002000f4,
    D3D11_MESSAGE_ID_COPYSTRUCTURECOUNT_INVALIDOFFSET                                            = 0x002000f5,
    D3D11_MESSAGE_ID_COPYSTRUCTURECOUNT_LARGEOFFSET                                              = 0x002000f6,
    D3D11_MESSAGE_ID_COPYSTRUCTURECOUNT_INVALIDDESTINATIONSTATE                                  = 0x002000f7,
    D3D11_MESSAGE_ID_COPYSTRUCTURECOUNT_INVALIDSOURCESTATE                                       = 0x002000f8,
    D3D11_MESSAGE_ID_CHECKFORMATSUPPORT_FORMAT_NOT_SUPPORTED                                     = 0x002000f9,
    D3D11_MESSAGE_ID_DEVICE_CSSETUNORDEREDACCESSVIEWS_INVALIDVIEW                                = 0x002000fa,
    D3D11_MESSAGE_ID_DEVICE_CSSETUNORDEREDACCESSVIEWS_INVALIDOFFSET                              = 0x002000fb,
    D3D11_MESSAGE_ID_DEVICE_CSSETUNORDEREDACCESSVIEWS_TOOMANYVIEWS                               = 0x002000fc,
    D3D11_MESSAGE_ID_CLEARUNORDEREDACCESSVIEWFLOAT_INVALIDFORMAT                                 = 0x002000fd,
    D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_COUNTER_UNSUPPORTED                              = 0x002000fe,
    D3D11_MESSAGE_ID_REF_WARNING                                                                 = 0x002000ff,
    D3D11_MESSAGE_ID_DEVICE_DRAW_PIXEL_SHADER_WITHOUT_RTV_OR_DSV                                 = 0x00200100,
    D3D11_MESSAGE_ID_SHADER_ABORT                                                                = 0x00200101,
    D3D11_MESSAGE_ID_SHADER_MESSAGE                                                              = 0x00200102,
    D3D11_MESSAGE_ID_SHADER_ERROR                                                                = 0x00200103,
    D3D11_MESSAGE_ID_OFFERRESOURCES_INVALIDRESOURCE                                              = 0x00200104,
    D3D11_MESSAGE_ID_HSSETSAMPLERS_UNBINDDELETINGOBJECT                                          = 0x00200105,
    D3D11_MESSAGE_ID_DSSETSAMPLERS_UNBINDDELETINGOBJECT                                          = 0x00200106,
    D3D11_MESSAGE_ID_CSSETSAMPLERS_UNBINDDELETINGOBJECT                                          = 0x00200107,
    D3D11_MESSAGE_ID_HSSETSHADER_UNBINDDELETINGOBJECT                                            = 0x00200108,
    D3D11_MESSAGE_ID_DSSETSHADER_UNBINDDELETINGOBJECT                                            = 0x00200109,
    D3D11_MESSAGE_ID_CSSETSHADER_UNBINDDELETINGOBJECT                                            = 0x0020010a,
    D3D11_MESSAGE_ID_ENQUEUESETEVENT_INVALIDARG_RETURN                                           = 0x0020010b,
    D3D11_MESSAGE_ID_ENQUEUESETEVENT_OUTOFMEMORY_RETURN                                          = 0x0020010c,
    D3D11_MESSAGE_ID_ENQUEUESETEVENT_ACCESSDENIED_RETURN                                         = 0x0020010d,
    D3D11_MESSAGE_ID_DEVICE_OMSETRENDERTARGETSANDUNORDEREDACCESSVIEWS_NUMUAVS_INVALIDRANGE       = 0x0020010e,
    D3D11_MESSAGE_ID_USE_OF_ZERO_REFCOUNT_OBJECT                                                 = 0x0020010f,
    D3D11_MESSAGE_ID_D3D11_MESSAGES_END                                                          = 0x00200110,
    D3D11_MESSAGE_ID_D3D11_1_MESSAGES_START                                                      = 0x00300000,
    D3D11_MESSAGE_ID_CREATE_VIDEODECODER                                                         = 0x00300001,
    D3D11_MESSAGE_ID_CREATE_VIDEOPROCESSORENUM                                                   = 0x00300002,
    D3D11_MESSAGE_ID_CREATE_VIDEOPROCESSOR                                                       = 0x00300003,
    D3D11_MESSAGE_ID_CREATE_DECODEROUTPUTVIEW                                                    = 0x00300004,
    D3D11_MESSAGE_ID_CREATE_PROCESSORINPUTVIEW                                                   = 0x00300005,
    D3D11_MESSAGE_ID_CREATE_PROCESSOROUTPUTVIEW                                                  = 0x00300006,
    D3D11_MESSAGE_ID_CREATE_DEVICECONTEXTSTATE                                                   = 0x00300007,
    D3D11_MESSAGE_ID_LIVE_VIDEODECODER                                                           = 0x00300008,
    D3D11_MESSAGE_ID_LIVE_VIDEOPROCESSORENUM                                                     = 0x00300009,
    D3D11_MESSAGE_ID_LIVE_VIDEOPROCESSOR                                                         = 0x0030000a,
    D3D11_MESSAGE_ID_LIVE_DECODEROUTPUTVIEW                                                      = 0x0030000b,
    D3D11_MESSAGE_ID_LIVE_PROCESSORINPUTVIEW                                                     = 0x0030000c,
    D3D11_MESSAGE_ID_LIVE_PROCESSOROUTPUTVIEW                                                    = 0x0030000d,
    D3D11_MESSAGE_ID_LIVE_DEVICECONTEXTSTATE                                                     = 0x0030000e,
    D3D11_MESSAGE_ID_DESTROY_VIDEODECODER                                                        = 0x0030000f,
    D3D11_MESSAGE_ID_DESTROY_VIDEOPROCESSORENUM                                                  = 0x00300010,
    D3D11_MESSAGE_ID_DESTROY_VIDEOPROCESSOR                                                      = 0x00300011,
    D3D11_MESSAGE_ID_DESTROY_DECODEROUTPUTVIEW                                                   = 0x00300012,
    D3D11_MESSAGE_ID_DESTROY_PROCESSORINPUTVIEW                                                  = 0x00300013,
    D3D11_MESSAGE_ID_DESTROY_PROCESSOROUTPUTVIEW                                                 = 0x00300014,
    D3D11_MESSAGE_ID_DESTROY_DEVICECONTEXTSTATE                                                  = 0x00300015,
    D3D11_MESSAGE_ID_CREATEDEVICECONTEXTSTATE_INVALIDFLAGS                                       = 0x00300016,
    D3D11_MESSAGE_ID_CREATEDEVICECONTEXTSTATE_INVALIDFEATURELEVEL                                = 0x00300017,
    D3D11_MESSAGE_ID_CREATEDEVICECONTEXTSTATE_FEATURELEVELS_NOT_SUPPORTED                        = 0x00300018,
    D3D11_MESSAGE_ID_CREATEDEVICECONTEXTSTATE_INVALIDREFIID                                      = 0x00300019,
    D3D11_MESSAGE_ID_DEVICE_DISCARDVIEW_INVALIDVIEW                                              = 0x0030001a,
    D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION1_INVALIDCOPYFLAGS                                     = 0x0030001b,
    D3D11_MESSAGE_ID_UPDATESUBRESOURCE1_INVALIDCOPYFLAGS                                         = 0x0030001c,
    D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDFORCEDSAMPLECOUNT                              = 0x0030001d,
    D3D11_MESSAGE_ID_CREATEVIDEODECODER_OUTOFMEMORY_RETURN                                       = 0x0030001e,
    D3D11_MESSAGE_ID_CREATEVIDEODECODER_NULLPARAM                                                = 0x0030001f,
    D3D11_MESSAGE_ID_CREATEVIDEODECODER_INVALIDFORMAT                                            = 0x00300020,
    D3D11_MESSAGE_ID_CREATEVIDEODECODER_ZEROWIDTHHEIGHT                                          = 0x00300021,
    D3D11_MESSAGE_ID_CREATEVIDEODECODER_DRIVER_INVALIDBUFFERSIZE                                 = 0x00300022,
    D3D11_MESSAGE_ID_CREATEVIDEODECODER_DRIVER_INVALIDBUFFERUSAGE                                = 0x00300023,
    D3D11_MESSAGE_ID_GETVIDEODECODERPROFILECOUNT_OUTOFMEMORY                                     = 0x00300024,
    D3D11_MESSAGE_ID_GETVIDEODECODERPROFILE_NULLPARAM                                            = 0x00300025,
    D3D11_MESSAGE_ID_GETVIDEODECODERPROFILE_INVALIDINDEX                                         = 0x00300026,
    D3D11_MESSAGE_ID_GETVIDEODECODERPROFILE_OUTOFMEMORY_RETURN                                   = 0x00300027,
    D3D11_MESSAGE_ID_CHECKVIDEODECODERFORMAT_NULLPARAM                                           = 0x00300028,
    D3D11_MESSAGE_ID_CHECKVIDEODECODERFORMAT_OUTOFMEMORY_RETURN                                  = 0x00300029,
    D3D11_MESSAGE_ID_GETVIDEODECODERCONFIGCOUNT_NULLPARAM                                        = 0x0030002a,
    D3D11_MESSAGE_ID_GETVIDEODECODERCONFIGCOUNT_OUTOFMEMORY_RETURN                               = 0x0030002b,
    D3D11_MESSAGE_ID_GETVIDEODECODERCONFIG_NULLPARAM                                             = 0x0030002c,
    D3D11_MESSAGE_ID_GETVIDEODECODERCONFIG_INVALIDINDEX                                          = 0x0030002d,
    D3D11_MESSAGE_ID_GETVIDEODECODERCONFIG_OUTOFMEMORY_RETURN                                    = 0x0030002e,
    D3D11_MESSAGE_ID_GETDECODERCREATIONPARAMS_NULLPARAM                                          = 0x0030002f,
    D3D11_MESSAGE_ID_GETDECODERDRIVERHANDLE_NULLPARAM                                            = 0x00300030,
    D3D11_MESSAGE_ID_GETDECODERBUFFER_NULLPARAM                                                  = 0x00300031,
    D3D11_MESSAGE_ID_GETDECODERBUFFER_INVALIDBUFFER                                              = 0x00300032,
    D3D11_MESSAGE_ID_GETDECODERBUFFER_INVALIDTYPE                                                = 0x00300033,
    D3D11_MESSAGE_ID_GETDECODERBUFFER_LOCKED                                                     = 0x00300034,
    D3D11_MESSAGE_ID_RELEASEDECODERBUFFER_NULLPARAM                                              = 0x00300035,
    D3D11_MESSAGE_ID_RELEASEDECODERBUFFER_INVALIDTYPE                                            = 0x00300036,
    D3D11_MESSAGE_ID_RELEASEDECODERBUFFER_NOTLOCKED                                              = 0x00300037,
    D3D11_MESSAGE_ID_DECODERBEGINFRAME_NULLPARAM                                                 = 0x00300038,
    D3D11_MESSAGE_ID_DECODERBEGINFRAME_HAZARD                                                    = 0x00300039,
    D3D11_MESSAGE_ID_DECODERENDFRAME_NULLPARAM                                                   = 0x0030003a,
    D3D11_MESSAGE_ID_SUBMITDECODERBUFFERS_NULLPARAM                                              = 0x0030003b,
    D3D11_MESSAGE_ID_SUBMITDECODERBUFFERS_INVALIDTYPE                                            = 0x0030003c,
    D3D11_MESSAGE_ID_DECODEREXTENSION_NULLPARAM                                                  = 0x0030003d,
    D3D11_MESSAGE_ID_DECODEREXTENSION_INVALIDRESOURCE                                            = 0x0030003e,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORENUMERATOR_OUTOFMEMORY_RETURN                           = 0x0030003f,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORENUMERATOR_NULLPARAM                                    = 0x00300040,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORENUMERATOR_INVALIDFRAMEFORMAT                           = 0x00300041,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORENUMERATOR_INVALIDUSAGE                                 = 0x00300042,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORENUMERATOR_INVALIDINPUTFRAMERATE                        = 0x00300043,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORENUMERATOR_INVALIDOUTPUTFRAMERATE                       = 0x00300044,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORENUMERATOR_INVALIDWIDTHHEIGHT                           = 0x00300045,
    D3D11_MESSAGE_ID_GETVIDEOPROCESSORCONTENTDESC_NULLPARAM                                      = 0x00300046,
    D3D11_MESSAGE_ID_CHECKVIDEOPROCESSORFORMAT_NULLPARAM                                         = 0x00300047,
    D3D11_MESSAGE_ID_GETVIDEOPROCESSORCAPS_NULLPARAM                                             = 0x00300048,
    D3D11_MESSAGE_ID_GETVIDEOPROCESSORRATECONVERSIONCAPS_NULLPARAM                               = 0x00300049,
    D3D11_MESSAGE_ID_GETVIDEOPROCESSORRATECONVERSIONCAPS_INVALIDINDEX                            = 0x0030004a,
    D3D11_MESSAGE_ID_GETVIDEOPROCESSORCUSTOMRATE_NULLPARAM                                       = 0x0030004b,
    D3D11_MESSAGE_ID_GETVIDEOPROCESSORCUSTOMRATE_INVALIDINDEX                                    = 0x0030004c,
    D3D11_MESSAGE_ID_GETVIDEOPROCESSORFILTERRANGE_NULLPARAM                                      = 0x0030004d,
    D3D11_MESSAGE_ID_GETVIDEOPROCESSORFILTERRANGE_UNSUPPORTED                                    = 0x0030004e,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOR_OUTOFMEMORY_RETURN                                     = 0x0030004f,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOR_NULLPARAM                                              = 0x00300050,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTTARGETRECT_NULLPARAM                                 = 0x00300051,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTBACKGROUNDCOLOR_NULLPARAM                            = 0x00300052,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTBACKGROUNDCOLOR_INVALIDALPHA                         = 0x00300053,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTCOLORSPACE_NULLPARAM                                 = 0x00300054,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTALPHAFILLMODE_NULLPARAM                              = 0x00300055,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTALPHAFILLMODE_UNSUPPORTED                            = 0x00300056,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTALPHAFILLMODE_INVALIDSTREAM                          = 0x00300057,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTALPHAFILLMODE_INVALIDFILLMODE                        = 0x00300058,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTCONSTRICTION_NULLPARAM                               = 0x00300059,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTSTEREOMODE_NULLPARAM                                 = 0x0030005a,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTSTEREOMODE_UNSUPPORTED                               = 0x0030005b,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTEXTENSION_NULLPARAM                                  = 0x0030005c,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTTARGETRECT_NULLPARAM                                 = 0x0030005d,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTBACKGROUNDCOLOR_NULLPARAM                            = 0x0030005e,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTCOLORSPACE_NULLPARAM                                 = 0x0030005f,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTALPHAFILLMODE_NULLPARAM                              = 0x00300060,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTCONSTRICTION_NULLPARAM                               = 0x00300061,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTCONSTRICTION_UNSUPPORTED                             = 0x00300062,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTCONSTRICTION_INVALIDSIZE                             = 0x00300063,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTSTEREOMODE_NULLPARAM                                 = 0x00300064,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTEXTENSION_NULLPARAM                                  = 0x00300065,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFRAMEFORMAT_NULLPARAM                                = 0x00300066,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFRAMEFORMAT_INVALIDFORMAT                            = 0x00300067,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFRAMEFORMAT_INVALIDSTREAM                            = 0x00300068,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMCOLORSPACE_NULLPARAM                                 = 0x00300069,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMCOLORSPACE_INVALIDSTREAM                             = 0x0030006a,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMOUTPUTRATE_NULLPARAM                                 = 0x0030006b,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMOUTPUTRATE_INVALIDRATE                               = 0x0030006c,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMOUTPUTRATE_INVALIDFLAG                               = 0x0030006d,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMOUTPUTRATE_INVALIDSTREAM                             = 0x0030006e,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSOURCERECT_NULLPARAM                                 = 0x0030006f,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSOURCERECT_INVALIDSTREAM                             = 0x00300070,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSOURCERECT_INVALIDRECT                               = 0x00300071,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMDESTRECT_NULLPARAM                                   = 0x00300072,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMDESTRECT_INVALIDSTREAM                               = 0x00300073,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMDESTRECT_INVALIDRECT                                 = 0x00300074,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMALPHA_NULLPARAM                                      = 0x00300075,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMALPHA_INVALIDSTREAM                                  = 0x00300076,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMALPHA_INVALIDALPHA                                   = 0x00300077,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPALETTE_NULLPARAM                                    = 0x00300078,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPALETTE_INVALIDSTREAM                                = 0x00300079,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPALETTE_INVALIDCOUNT                                 = 0x0030007a,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPALETTE_INVALIDALPHA                                 = 0x0030007b,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPIXELASPECTRATIO_NULLPARAM                           = 0x0030007c,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPIXELASPECTRATIO_INVALIDSTREAM                       = 0x0030007d,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPIXELASPECTRATIO_INVALIDRATIO                        = 0x0030007e,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMLUMAKEY_NULLPARAM                                    = 0x0030007f,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMLUMAKEY_INVALIDSTREAM                                = 0x00300080,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMLUMAKEY_INVALIDRANGE                                 = 0x00300081,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMLUMAKEY_UNSUPPORTED                                  = 0x00300082,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSTEREOFORMAT_NULLPARAM                               = 0x00300083,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSTEREOFORMAT_INVALIDSTREAM                           = 0x00300084,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSTEREOFORMAT_UNSUPPORTED                             = 0x00300085,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSTEREOFORMAT_FLIPUNSUPPORTED                         = 0x00300086,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSTEREOFORMAT_MONOOFFSETUNSUPPORTED                   = 0x00300087,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSTEREOFORMAT_FORMATUNSUPPORTED                       = 0x00300088,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSTEREOFORMAT_INVALIDFORMAT                           = 0x00300089,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMAUTOPROCESSINGMODE_NULLPARAM                         = 0x0030008a,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMAUTOPROCESSINGMODE_INVALIDSTREAM                     = 0x0030008b,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFILTER_NULLPARAM                                     = 0x0030008c,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFILTER_INVALIDSTREAM                                 = 0x0030008d,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFILTER_INVALIDFILTER                                 = 0x0030008e,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFILTER_UNSUPPORTED                                   = 0x0030008f,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFILTER_INVALIDLEVEL                                  = 0x00300090,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMEXTENSION_NULLPARAM                                  = 0x00300091,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMEXTENSION_INVALIDSTREAM                              = 0x00300092,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMFRAMEFORMAT_NULLPARAM                                = 0x00300093,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMCOLORSPACE_NULLPARAM                                 = 0x00300094,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMOUTPUTRATE_NULLPARAM                                 = 0x00300095,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMSOURCERECT_NULLPARAM                                 = 0x00300096,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMDESTRECT_NULLPARAM                                   = 0x00300097,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMALPHA_NULLPARAM                                      = 0x00300098,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMPALETTE_NULLPARAM                                    = 0x00300099,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMPIXELASPECTRATIO_NULLPARAM                           = 0x0030009a,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMLUMAKEY_NULLPARAM                                    = 0x0030009b,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMSTEREOFORMAT_NULLPARAM                               = 0x0030009c,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMAUTOPROCESSINGMODE_NULLPARAM                         = 0x0030009d,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMFILTER_NULLPARAM                                     = 0x0030009e,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMEXTENSION_NULLPARAM                                  = 0x0030009f,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMEXTENSION_INVALIDSTREAM                              = 0x003000a0,
    D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_NULLPARAM                                                 = 0x003000a1,
    D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDSTREAMCOUNT                                        = 0x003000a2,
    D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_TARGETRECT                                                = 0x003000a3,
    D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDOUTPUT                                             = 0x003000a4,
    D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDPASTFRAMES                                         = 0x003000a5,
    D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDFUTUREFRAMES                                       = 0x003000a6,
    D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDSOURCERECT                                         = 0x003000a7,
    D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDDESTRECT                                           = 0x003000a8,
    D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDINPUTRESOURCE                                      = 0x003000a9,
    D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDARRAYSIZE                                          = 0x003000aa,
    D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDARRAY                                              = 0x003000ab,
    D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_RIGHTEXPECTED                                             = 0x003000ac,
    D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_RIGHTNOTEXPECTED                                          = 0x003000ad,
    D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_STEREONOTENABLED                                          = 0x003000ae,
    D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDRIGHTRESOURCE                                      = 0x003000af,
    D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_NOSTEREOSTREAMS                                           = 0x003000b0,
    D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INPUTHAZARD                                               = 0x003000b1,
    D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_OUTPUTHAZARD                                              = 0x003000b2,
    D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_OUTOFMEMORY_RETURN                             = 0x003000b3,
    D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_NULLPARAM                                      = 0x003000b4,
    D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_INVALIDTYPE                                    = 0x003000b5,
    D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_INVALIDBIND                                    = 0x003000b6,
    D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_UNSUPPORTEDFORMAT                              = 0x003000b7,
    D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_INVALIDMIP                                     = 0x003000b8,
    D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_UNSUPPORTEMIP                                  = 0x003000b9,
    D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_INVALIDARRAYSIZE                               = 0x003000ba,
    D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_INVALIDARRAY                                   = 0x003000bb,
    D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_INVALIDDIMENSION                               = 0x003000bc,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_OUTOFMEMORY_RETURN                            = 0x003000bd,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_NULLPARAM                                     = 0x003000be,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDTYPE                                   = 0x003000bf,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDBIND                                   = 0x003000c0,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDMISC                                   = 0x003000c1,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDUSAGE                                  = 0x003000c2,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDFORMAT                                 = 0x003000c3,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDFOURCC                                 = 0x003000c4,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDMIP                                    = 0x003000c5,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_UNSUPPORTEDMIP                                = 0x003000c6,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDARRAYSIZE                              = 0x003000c7,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDARRAY                                  = 0x003000c8,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDDIMENSION                              = 0x003000c9,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_OUTOFMEMORY_RETURN                           = 0x003000ca,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_NULLPARAM                                    = 0x003000cb,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_INVALIDTYPE                                  = 0x003000cc,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_INVALIDBIND                                  = 0x003000cd,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_INVALIDFORMAT                                = 0x003000ce,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_INVALIDMIP                                   = 0x003000cf,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_UNSUPPORTEDMIP                               = 0x003000d0,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_UNSUPPORTEDARRAY                             = 0x003000d1,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_INVALIDARRAY                                 = 0x003000d2,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_INVALIDDIMENSION                             = 0x003000d3,
    D3D11_MESSAGE_ID_DEVICE_DRAW_INVALID_USE_OF_FORCED_SAMPLE_COUNT                              = 0x003000d4,
    D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDLOGICOPS                                            = 0x003000d5,
    D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDDARRAYWITHDECODER                           = 0x003000d6,
    D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDDARRAYWITHDECODER                          = 0x003000d7,
    D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDDARRAYWITHDECODER                             = 0x003000d8,
    D3D11_MESSAGE_ID_DEVICE_LOCKEDOUT_INTERFACE                                                  = 0x003000d9,
    D3D11_MESSAGE_ID_REF_WARNING_ATOMIC_INCONSISTENT                                             = 0x003000da,
    D3D11_MESSAGE_ID_REF_WARNING_READING_UNINITIALIZED_RESOURCE                                  = 0x003000db,
    D3D11_MESSAGE_ID_REF_WARNING_RAW_HAZARD                                                      = 0x003000dc,
    D3D11_MESSAGE_ID_REF_WARNING_WAR_HAZARD                                                      = 0x003000dd,
    D3D11_MESSAGE_ID_REF_WARNING_WAW_HAZARD                                                      = 0x003000de,
    D3D11_MESSAGE_ID_CREATECRYPTOSESSION_NULLPARAM                                               = 0x003000df,
    D3D11_MESSAGE_ID_CREATECRYPTOSESSION_OUTOFMEMORY_RETURN                                      = 0x003000e0,
    D3D11_MESSAGE_ID_GETCRYPTOTYPE_NULLPARAM                                                     = 0x003000e1,
    D3D11_MESSAGE_ID_GETDECODERPROFILE_NULLPARAM                                                 = 0x003000e2,
    D3D11_MESSAGE_ID_GETCRYPTOSESSIONCERTIFICATESIZE_NULLPARAM                                   = 0x003000e3,
    D3D11_MESSAGE_ID_GETCRYPTOSESSIONCERTIFICATE_NULLPARAM                                       = 0x003000e4,
    D3D11_MESSAGE_ID_GETCRYPTOSESSIONCERTIFICATE_WRONGSIZE                                       = 0x003000e5,
    D3D11_MESSAGE_ID_GETCRYPTOSESSIONHANDLE_WRONGSIZE                                            = 0x003000e6,
    D3D11_MESSAGE_ID_NEGOTIATECRPYTOSESSIONKEYEXCHANGE_NULLPARAM                                 = 0x003000e7,
    D3D11_MESSAGE_ID_ENCRYPTIONBLT_UNSUPPORTED                                                   = 0x003000e8,
    D3D11_MESSAGE_ID_ENCRYPTIONBLT_NULLPARAM                                                     = 0x003000e9,
    D3D11_MESSAGE_ID_ENCRYPTIONBLT_SRC_WRONGDEVICE                                               = 0x003000ea,
    D3D11_MESSAGE_ID_ENCRYPTIONBLT_DST_WRONGDEVICE                                               = 0x003000eb,
    D3D11_MESSAGE_ID_ENCRYPTIONBLT_FORMAT_MISMATCH                                               = 0x003000ec,
    D3D11_MESSAGE_ID_ENCRYPTIONBLT_SIZE_MISMATCH                                                 = 0x003000ed,
    D3D11_MESSAGE_ID_ENCRYPTIONBLT_SRC_MULTISAMPLED                                              = 0x003000ee,
    D3D11_MESSAGE_ID_ENCRYPTIONBLT_DST_NOT_STAGING                                               = 0x003000ef,
    D3D11_MESSAGE_ID_ENCRYPTIONBLT_SRC_MAPPED                                                    = 0x003000f0,
    D3D11_MESSAGE_ID_ENCRYPTIONBLT_DST_MAPPED                                                    = 0x003000f1,
    D3D11_MESSAGE_ID_ENCRYPTIONBLT_SRC_OFFERED                                                   = 0x003000f2,
    D3D11_MESSAGE_ID_ENCRYPTIONBLT_DST_OFFERED                                                   = 0x003000f3,
    D3D11_MESSAGE_ID_ENCRYPTIONBLT_SRC_CONTENT_UNDEFINED                                         = 0x003000f4,
    D3D11_MESSAGE_ID_DECRYPTIONBLT_UNSUPPORTED                                                   = 0x003000f5,
    D3D11_MESSAGE_ID_DECRYPTIONBLT_NULLPARAM                                                     = 0x003000f6,
    D3D11_MESSAGE_ID_DECRYPTIONBLT_SRC_WRONGDEVICE                                               = 0x003000f7,
    D3D11_MESSAGE_ID_DECRYPTIONBLT_DST_WRONGDEVICE                                               = 0x003000f8,
    D3D11_MESSAGE_ID_DECRYPTIONBLT_FORMAT_MISMATCH                                               = 0x003000f9,
    D3D11_MESSAGE_ID_DECRYPTIONBLT_SIZE_MISMATCH                                                 = 0x003000fa,
    D3D11_MESSAGE_ID_DECRYPTIONBLT_DST_MULTISAMPLED                                              = 0x003000fb,
    D3D11_MESSAGE_ID_DECRYPTIONBLT_SRC_NOT_STAGING                                               = 0x003000fc,
    D3D11_MESSAGE_ID_DECRYPTIONBLT_DST_NOT_RENDER_TARGET                                         = 0x003000fd,
    D3D11_MESSAGE_ID_DECRYPTIONBLT_SRC_MAPPED                                                    = 0x003000fe,
    D3D11_MESSAGE_ID_DECRYPTIONBLT_DST_MAPPED                                                    = 0x003000ff,
    D3D11_MESSAGE_ID_DECRYPTIONBLT_SRC_OFFERED                                                   = 0x00300100,
    D3D11_MESSAGE_ID_DECRYPTIONBLT_DST_OFFERED                                                   = 0x00300101,
    D3D11_MESSAGE_ID_DECRYPTIONBLT_SRC_CONTENT_UNDEFINED                                         = 0x00300102,
    D3D11_MESSAGE_ID_STARTSESSIONKEYREFRESH_NULLPARAM                                            = 0x00300103,
    D3D11_MESSAGE_ID_STARTSESSIONKEYREFRESH_INVALIDSIZE                                          = 0x00300104,
    D3D11_MESSAGE_ID_FINISHSESSIONKEYREFRESH_NULLPARAM                                           = 0x00300105,
    D3D11_MESSAGE_ID_GETENCRYPTIONBLTKEY_NULLPARAM                                               = 0x00300106,
    D3D11_MESSAGE_ID_GETENCRYPTIONBLTKEY_INVALIDSIZE                                             = 0x00300107,
    D3D11_MESSAGE_ID_GETCONTENTPROTECTIONCAPS_NULLPARAM                                          = 0x00300108,
    D3D11_MESSAGE_ID_CHECKCRYPTOKEYEXCHANGE_NULLPARAM                                            = 0x00300109,
    D3D11_MESSAGE_ID_CHECKCRYPTOKEYEXCHANGE_INVALIDINDEX                                         = 0x0030010a,
    D3D11_MESSAGE_ID_CREATEAUTHENTICATEDCHANNEL_NULLPARAM                                        = 0x0030010b,
    D3D11_MESSAGE_ID_CREATEAUTHENTICATEDCHANNEL_UNSUPPORTED                                      = 0x0030010c,
    D3D11_MESSAGE_ID_CREATEAUTHENTICATEDCHANNEL_INVALIDTYPE                                      = 0x0030010d,
    D3D11_MESSAGE_ID_CREATEAUTHENTICATEDCHANNEL_OUTOFMEMORY_RETURN                               = 0x0030010e,
    D3D11_MESSAGE_ID_GETAUTHENTICATEDCHANNELCERTIFICATESIZE_INVALIDCHANNEL                       = 0x0030010f,
    D3D11_MESSAGE_ID_GETAUTHENTICATEDCHANNELCERTIFICATESIZE_NULLPARAM                            = 0x00300110,
    D3D11_MESSAGE_ID_GETAUTHENTICATEDCHANNELCERTIFICATE_INVALIDCHANNEL                           = 0x00300111,
    D3D11_MESSAGE_ID_GETAUTHENTICATEDCHANNELCERTIFICATE_NULLPARAM                                = 0x00300112,
    D3D11_MESSAGE_ID_GETAUTHENTICATEDCHANNELCERTIFICATE_WRONGSIZE                                = 0x00300113,
    D3D11_MESSAGE_ID_NEGOTIATEAUTHENTICATEDCHANNELKEYEXCHANGE_INVALIDCHANNEL                     = 0x00300114,
    D3D11_MESSAGE_ID_NEGOTIATEAUTHENTICATEDCHANNELKEYEXCHANGE_NULLPARAM                          = 0x00300115,
    D3D11_MESSAGE_ID_QUERYAUTHENTICATEDCHANNEL_NULLPARAM                                         = 0x00300116,
    D3D11_MESSAGE_ID_QUERYAUTHENTICATEDCHANNEL_WRONGCHANNEL                                      = 0x00300117,
    D3D11_MESSAGE_ID_QUERYAUTHENTICATEDCHANNEL_UNSUPPORTEDQUERY                                  = 0x00300118,
    D3D11_MESSAGE_ID_QUERYAUTHENTICATEDCHANNEL_WRONGSIZE                                         = 0x00300119,
    D3D11_MESSAGE_ID_QUERYAUTHENTICATEDCHANNEL_INVALIDPROCESSINDEX                               = 0x0030011a,
    D3D11_MESSAGE_ID_CONFIGUREAUTHENTICATEDCHANNEL_NULLPARAM                                     = 0x0030011b,
    D3D11_MESSAGE_ID_CONFIGUREAUTHENTICATEDCHANNEL_WRONGCHANNEL                                  = 0x0030011c,
    D3D11_MESSAGE_ID_CONFIGUREAUTHENTICATEDCHANNEL_UNSUPPORTEDCONFIGURE                          = 0x0030011d,
    D3D11_MESSAGE_ID_CONFIGUREAUTHENTICATEDCHANNEL_WRONGSIZE                                     = 0x0030011e,
    D3D11_MESSAGE_ID_CONFIGUREAUTHENTICATEDCHANNEL_INVALIDPROCESSIDTYPE                          = 0x0030011f,
    D3D11_MESSAGE_ID_VSSETCONSTANTBUFFERS_INVALIDBUFFEROFFSETORCOUNT                             = 0x00300120,
    D3D11_MESSAGE_ID_DSSETCONSTANTBUFFERS_INVALIDBUFFEROFFSETORCOUNT                             = 0x00300121,
    D3D11_MESSAGE_ID_HSSETCONSTANTBUFFERS_INVALIDBUFFEROFFSETORCOUNT                             = 0x00300122,
    D3D11_MESSAGE_ID_GSSETCONSTANTBUFFERS_INVALIDBUFFEROFFSETORCOUNT                             = 0x00300123,
    D3D11_MESSAGE_ID_PSSETCONSTANTBUFFERS_INVALIDBUFFEROFFSETORCOUNT                             = 0x00300124,
    D3D11_MESSAGE_ID_CSSETCONSTANTBUFFERS_INVALIDBUFFEROFFSETORCOUNT                             = 0x00300125,
    D3D11_MESSAGE_ID_NEGOTIATECRPYTOSESSIONKEYEXCHANGE_INVALIDSIZE                               = 0x00300126,
    D3D11_MESSAGE_ID_NEGOTIATEAUTHENTICATEDCHANNELKEYEXCHANGE_INVALIDSIZE                        = 0x00300127,
    D3D11_MESSAGE_ID_OFFERRESOURCES_INVALIDPRIORITY                                              = 0x00300128,
    D3D11_MESSAGE_ID_GETCRYPTOSESSIONHANDLE_OUTOFMEMORY                                          = 0x00300129,
    D3D11_MESSAGE_ID_ACQUIREHANDLEFORCAPTURE_NULLPARAM                                           = 0x0030012a,
    D3D11_MESSAGE_ID_ACQUIREHANDLEFORCAPTURE_INVALIDTYPE                                         = 0x0030012b,
    D3D11_MESSAGE_ID_ACQUIREHANDLEFORCAPTURE_INVALIDBIND                                         = 0x0030012c,
    D3D11_MESSAGE_ID_ACQUIREHANDLEFORCAPTURE_INVALIDARRAY                                        = 0x0030012d,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMROTATION_NULLPARAM                                   = 0x0030012e,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMROTATION_INVALIDSTREAM                               = 0x0030012f,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMROTATION_INVALID                                     = 0x00300130,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMROTATION_UNSUPPORTED                                 = 0x00300131,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMROTATION_NULLPARAM                                   = 0x00300132,
    D3D11_MESSAGE_ID_DEVICE_CLEARVIEW_INVALIDVIEW                                                = 0x00300133,
    D3D11_MESSAGE_ID_DEVICE_CREATEVERTEXSHADER_DOUBLEEXTENSIONSNOTSUPPORTED                      = 0x00300134,
    D3D11_MESSAGE_ID_DEVICE_CREATEVERTEXSHADER_SHADEREXTENSIONSNOTSUPPORTED                      = 0x00300135,
    D3D11_MESSAGE_ID_DEVICE_CREATEHULLSHADER_DOUBLEEXTENSIONSNOTSUPPORTED                        = 0x00300136,
    D3D11_MESSAGE_ID_DEVICE_CREATEHULLSHADER_SHADEREXTENSIONSNOTSUPPORTED                        = 0x00300137,
    D3D11_MESSAGE_ID_DEVICE_CREATEDOMAINSHADER_DOUBLEEXTENSIONSNOTSUPPORTED                      = 0x00300138,
    D3D11_MESSAGE_ID_DEVICE_CREATEDOMAINSHADER_SHADEREXTENSIONSNOTSUPPORTED                      = 0x00300139,
    D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADER_DOUBLEEXTENSIONSNOTSUPPORTED                    = 0x0030013a,
    D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADER_SHADEREXTENSIONSNOTSUPPORTED                    = 0x0030013b,
    D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_DOUBLEEXTENSIONSNOTSUPPORTED    = 0x0030013c,
    D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_SHADEREXTENSIONSNOTSUPPORTED    = 0x0030013d,
    D3D11_MESSAGE_ID_DEVICE_CREATEPIXELSHADER_DOUBLEEXTENSIONSNOTSUPPORTED                       = 0x0030013e,
    D3D11_MESSAGE_ID_DEVICE_CREATEPIXELSHADER_SHADEREXTENSIONSNOTSUPPORTED                       = 0x0030013f,
    D3D11_MESSAGE_ID_DEVICE_CREATECOMPUTESHADER_DOUBLEEXTENSIONSNOTSUPPORTED                     = 0x00300140,
    D3D11_MESSAGE_ID_DEVICE_CREATECOMPUTESHADER_SHADEREXTENSIONSNOTSUPPORTED                     = 0x00300141,
    D3D11_MESSAGE_ID_DEVICE_SHADER_LINKAGE_MINPRECISION                                          = 0x00300142,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMALPHA_UNSUPPORTED                                    = 0x00300143,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPIXELASPECTRATIO_UNSUPPORTED                         = 0x00300144,
    D3D11_MESSAGE_ID_DEVICE_CREATEVERTEXSHADER_UAVSNOTSUPPORTED                                  = 0x00300145,
    D3D11_MESSAGE_ID_DEVICE_CREATEHULLSHADER_UAVSNOTSUPPORTED                                    = 0x00300146,
    D3D11_MESSAGE_ID_DEVICE_CREATEDOMAINSHADER_UAVSNOTSUPPORTED                                  = 0x00300147,
    D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADER_UAVSNOTSUPPORTED                                = 0x00300148,
    D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UAVSNOTSUPPORTED                = 0x00300149,
    D3D11_MESSAGE_ID_DEVICE_CREATEPIXELSHADER_UAVSNOTSUPPORTED                                   = 0x0030014a,
    D3D11_MESSAGE_ID_DEVICE_CREATECOMPUTESHADER_UAVSNOTSUPPORTED                                 = 0x0030014b,
    D3D11_MESSAGE_ID_DEVICE_OMSETRENDERTARGETSANDUNORDEREDACCESSVIEWS_INVALIDOFFSET              = 0x0030014c,
    D3D11_MESSAGE_ID_DEVICE_OMSETRENDERTARGETSANDUNORDEREDACCESSVIEWS_TOOMANYVIEWS               = 0x0030014d,
    D3D11_MESSAGE_ID_DEVICE_CLEARVIEW_NOTSUPPORTED                                               = 0x0030014e,
    D3D11_MESSAGE_ID_SWAPDEVICECONTEXTSTATE_NOTSUPPORTED                                         = 0x0030014f,
    D3D11_MESSAGE_ID_UPDATESUBRESOURCE_PREFERUPDATESUBRESOURCE1                                  = 0x00300150,
    D3D11_MESSAGE_ID_GETDC_INACCESSIBLE                                                          = 0x00300151,
    D3D11_MESSAGE_ID_DEVICE_CLEARVIEW_INVALIDRECT                                                = 0x00300152,
    D3D11_MESSAGE_ID_DEVICE_DRAW_SAMPLE_MASK_IGNORED_ON_FL9                                      = 0x00300153,
    D3D11_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE1_NOT_SUPPORTED                                  = 0x00300154,
    D3D11_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE_BY_NAME_NOT_SUPPORTED                           = 0x00300155,
    D3D11_MESSAGE_ID_ENQUEUESETEVENT_NOT_SUPPORTED                                               = 0x00300156,
    D3D11_MESSAGE_ID_OFFERRELEASE_NOT_SUPPORTED                                                  = 0x00300157,
    D3D11_MESSAGE_ID_OFFERRESOURCES_INACCESSIBLE                                                 = 0x00300158,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDMSAA                                   = 0x00300159,
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_INVALIDMSAA                                  = 0x0030015a,
    D3D11_MESSAGE_ID_DEVICE_CLEARVIEW_INVALIDSOURCERECT                                          = 0x0030015b,
    D3D11_MESSAGE_ID_DEVICE_CLEARVIEW_EMPTYRECT                                                  = 0x0030015c,
    D3D11_MESSAGE_ID_UPDATESUBRESOURCE_EMPTYDESTBOX                                              = 0x0030015d,
    D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION_EMPTYSOURCEBOX                                        = 0x0030015e,
    D3D11_MESSAGE_ID_DEVICE_DRAW_OM_RENDER_TARGET_DOES_NOT_SUPPORT_LOGIC_OPS                     = 0x0030015f,
    D3D11_MESSAGE_ID_DEVICE_DRAW_DEPTHSTENCILVIEW_NOT_SET                                        = 0x00300160,
    D3D11_MESSAGE_ID_DEVICE_DRAW_RENDERTARGETVIEW_NOT_SET                                        = 0x00300161,
    D3D11_MESSAGE_ID_DEVICE_DRAW_RENDERTARGETVIEW_NOT_SET_DUE_TO_FLIP_PRESENT                    = 0x00300162,
    D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_NOT_SET_DUE_TO_FLIP_PRESENT                      = 0x00300163,
    D3D11_MESSAGE_ID_GETDATAFORNEWHARDWAREKEY_NULLPARAM                                          = 0x00300164,
    D3D11_MESSAGE_ID_CHECKCRYPTOSESSIONSTATUS_NULLPARAM                                          = 0x00300165,
    D3D11_MESSAGE_ID_GETCRYPTOSESSIONPRIVATEDATASIZE_NULLPARAM                                   = 0x00300166,
    D3D11_MESSAGE_ID_GETVIDEODECODERCAPS_NULLPARAM                                               = 0x00300167,
    D3D11_MESSAGE_ID_GETVIDEODECODERCAPS_ZEROWIDTHHEIGHT                                         = 0x00300168,
    D3D11_MESSAGE_ID_CHECKVIDEODECODERDOWNSAMPLING_NULLPARAM                                     = 0x00300169,
    D3D11_MESSAGE_ID_CHECKVIDEODECODERDOWNSAMPLING_INVALIDCOLORSPACE                             = 0x0030016a,
    D3D11_MESSAGE_ID_CHECKVIDEODECODERDOWNSAMPLING_ZEROWIDTHHEIGHT                               = 0x0030016b,
    D3D11_MESSAGE_ID_VIDEODECODERENABLEDOWNSAMPLING_NULLPARAM                                    = 0x0030016c,
    D3D11_MESSAGE_ID_VIDEODECODERENABLEDOWNSAMPLING_UNSUPPORTED                                  = 0x0030016d,
    D3D11_MESSAGE_ID_VIDEODECODERUPDATEDOWNSAMPLING_NULLPARAM                                    = 0x0030016e,
    D3D11_MESSAGE_ID_VIDEODECODERUPDATEDOWNSAMPLING_UNSUPPORTED                                  = 0x0030016f,
    D3D11_MESSAGE_ID_CHECKVIDEOPROCESSORFORMATCONVERSION_NULLPARAM                               = 0x00300170,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTCOLORSPACE1_NULLPARAM                                = 0x00300171,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTCOLORSPACE1_NULLPARAM                                = 0x00300172,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMCOLORSPACE1_NULLPARAM                                = 0x00300173,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMCOLORSPACE1_INVALIDSTREAM                            = 0x00300174,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMMIRROR_NULLPARAM                                     = 0x00300175,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMMIRROR_INVALIDSTREAM                                 = 0x00300176,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMMIRROR_UNSUPPORTED                                   = 0x00300177,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMCOLORSPACE1_NULLPARAM                                = 0x00300178,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMMIRROR_NULLPARAM                                     = 0x00300179,
    D3D11_MESSAGE_ID_RECOMMENDVIDEODECODERDOWNSAMPLING_NULLPARAM                                 = 0x0030017a,
    D3D11_MESSAGE_ID_RECOMMENDVIDEODECODERDOWNSAMPLING_INVALIDCOLORSPACE                         = 0x0030017b,
    D3D11_MESSAGE_ID_RECOMMENDVIDEODECODERDOWNSAMPLING_ZEROWIDTHHEIGHT                           = 0x0030017c,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTSHADERUSAGE_NULLPARAM                                = 0x0030017d,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTSHADERUSAGE_NULLPARAM                                = 0x0030017e,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETBEHAVIORHINTS_NULLPARAM                                    = 0x0030017f,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETBEHAVIORHINTS_INVALIDSTREAMCOUNT                           = 0x00300180,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETBEHAVIORHINTS_TARGETRECT                                   = 0x00300181,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETBEHAVIORHINTS_INVALIDSOURCERECT                            = 0x00300182,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETBEHAVIORHINTS_INVALIDDESTRECT                              = 0x00300183,
    D3D11_MESSAGE_ID_GETCRYPTOSESSIONPRIVATEDATASIZE_INVALID_KEY_EXCHANGE_TYPE                   = 0x00300184,
    D3D11_MESSAGE_ID_D3D11_1_MESSAGES_END                                                        = 0x00300185,
    D3D11_MESSAGE_ID_D3D11_2_MESSAGES_START                                                      = 0x00300186,
    D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDUSAGE                                                   = 0x00300187,
    D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDUSAGE                                                = 0x00300188,
    D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDUSAGE                                                = 0x00300189,
    D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_LEVEL9_STEPRATE_NOT_1                                     = 0x0030018a,
    D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_LEVEL9_INSTANCING_NOT_SUPPORTED                           = 0x0030018b,
    D3D11_MESSAGE_ID_UPDATETILEMAPPINGS_INVALID_PARAMETER                                        = 0x0030018c,
    D3D11_MESSAGE_ID_COPYTILEMAPPINGS_INVALID_PARAMETER                                          = 0x0030018d,
    D3D11_MESSAGE_ID_COPYTILES_INVALID_PARAMETER                                                 = 0x0030018e,
    D3D11_MESSAGE_ID_UPDATETILES_INVALID_PARAMETER                                               = 0x0030018f,
    D3D11_MESSAGE_ID_RESIZETILEPOOL_INVALID_PARAMETER                                            = 0x00300190,
    D3D11_MESSAGE_ID_TILEDRESOURCEBARRIER_INVALID_PARAMETER                                      = 0x00300191,
    D3D11_MESSAGE_ID_NULL_TILE_MAPPING_ACCESS_WARNING                                            = 0x00300192,
    D3D11_MESSAGE_ID_NULL_TILE_MAPPING_ACCESS_ERROR                                              = 0x00300193,
    D3D11_MESSAGE_ID_DIRTY_TILE_MAPPING_ACCESS                                                   = 0x00300194,
    D3D11_MESSAGE_ID_DUPLICATE_TILE_MAPPINGS_IN_COVERED_AREA                                     = 0x00300195,
    D3D11_MESSAGE_ID_TILE_MAPPINGS_IN_COVERED_AREA_DUPLICATED_OUTSIDE                            = 0x00300196,
    D3D11_MESSAGE_ID_TILE_MAPPINGS_SHARED_BETWEEN_INCOMPATIBLE_RESOURCES                         = 0x00300197,
    D3D11_MESSAGE_ID_TILE_MAPPINGS_SHARED_BETWEEN_INPUT_AND_OUTPUT                               = 0x00300198,
    D3D11_MESSAGE_ID_CHECKMULTISAMPLEQUALITYLEVELS_INVALIDFLAGS                                  = 0x00300199,
    D3D11_MESSAGE_ID_GETRESOURCETILING_NONTILED_RESOURCE                                         = 0x0030019a,
    D3D11_MESSAGE_ID_RESIZETILEPOOL_SHRINK_WITH_MAPPINGS_STILL_DEFINED_PAST_END                  = 0x0030019b,
    D3D11_MESSAGE_ID_NEED_TO_CALL_TILEDRESOURCEBARRIER                                           = 0x0030019c,
    D3D11_MESSAGE_ID_CREATEDEVICE_INVALIDARGS                                                    = 0x0030019d,
    D3D11_MESSAGE_ID_CREATEDEVICE_WARNING                                                        = 0x0030019e,
    D3D11_MESSAGE_ID_CLEARUNORDEREDACCESSVIEWUINT_HAZARD                                         = 0x0030019f,
    D3D11_MESSAGE_ID_CLEARUNORDEREDACCESSVIEWFLOAT_HAZARD                                        = 0x003001a0,
    D3D11_MESSAGE_ID_TILED_RESOURCE_TIER_1_BUFFER_TEXTURE_MISMATCH                               = 0x003001a1,
    D3D11_MESSAGE_ID_CREATE_CRYPTOSESSION                                                        = 0x003001a2,
    D3D11_MESSAGE_ID_CREATE_AUTHENTICATEDCHANNEL                                                 = 0x003001a3,
    D3D11_MESSAGE_ID_LIVE_CRYPTOSESSION                                                          = 0x003001a4,
    D3D11_MESSAGE_ID_LIVE_AUTHENTICATEDCHANNEL                                                   = 0x003001a5,
    D3D11_MESSAGE_ID_DESTROY_CRYPTOSESSION                                                       = 0x003001a6,
    D3D11_MESSAGE_ID_DESTROY_AUTHENTICATEDCHANNEL                                                = 0x003001a7,
    D3D11_MESSAGE_ID_D3D11_2_MESSAGES_END                                                        = 0x003001a8,
    D3D11_MESSAGE_ID_D3D11_3_MESSAGES_START                                                      = 0x003001a9,
    D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_INVALID_CONSERVATIVERASTERMODE                        = 0x003001aa,
    D3D11_MESSAGE_ID_DEVICE_DRAW_INVALID_SYSTEMVALUE                                             = 0x003001ab,
    D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_INVALIDCONTEXTTYPE                                   = 0x003001ac,
    D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_DECODENOTSUPPORTED                                   = 0x003001ad,
    D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_ENCODENOTSUPPORTED                                   = 0x003001ae,
    D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDPLANEINDEX                                  = 0x003001af,
    D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDVIDEOPLANEINDEX                             = 0x003001b0,
    D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_AMBIGUOUSVIDEOPLANEINDEX                           = 0x003001b1,
    D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDPLANEINDEX                                    = 0x003001b2,
    D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDVIDEOPLANEINDEX                               = 0x003001b3,
    D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_AMBIGUOUSVIDEOPLANEINDEX                             = 0x003001b4,
    D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDPLANEINDEX                                 = 0x003001b5,
    D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDVIDEOPLANEINDEX                            = 0x003001b6,
    D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_AMBIGUOUSVIDEOPLANEINDEX                          = 0x003001b7,
    D3D11_MESSAGE_ID_JPEGDECODE_INVALIDSCANDATAOFFSET                                            = 0x003001b8,
    D3D11_MESSAGE_ID_JPEGDECODE_NOTSUPPORTED                                                     = 0x003001b9,
    D3D11_MESSAGE_ID_JPEGDECODE_DIMENSIONSTOOLARGE                                               = 0x003001ba,
    D3D11_MESSAGE_ID_JPEGDECODE_INVALIDCOMPONENTS                                                = 0x003001bb,
    D3D11_MESSAGE_ID_JPEGDECODE_DESTINATIONNOT2D                                                 = 0x003001bc,
    D3D11_MESSAGE_ID_JPEGDECODE_TILEDRESOURCESUNSUPPORTED                                        = 0x003001bd,
    D3D11_MESSAGE_ID_JPEGDECODE_GUARDRECTSUNSUPPORTED                                            = 0x003001be,
    D3D11_MESSAGE_ID_JPEGDECODE_FORMATUNSUPPORTED                                                = 0x003001bf,
    D3D11_MESSAGE_ID_JPEGDECODE_INVALIDSUBRESOURCE                                               = 0x003001c0,
    D3D11_MESSAGE_ID_JPEGDECODE_INVALIDMIPLEVEL                                                  = 0x003001c1,
    D3D11_MESSAGE_ID_JPEGDECODE_EMPTYDESTBOX                                                     = 0x003001c2,
    D3D11_MESSAGE_ID_JPEGDECODE_DESTBOXNOT2D                                                     = 0x003001c3,
    D3D11_MESSAGE_ID_JPEGDECODE_DESTBOXNOTSUB                                                    = 0x003001c4,
    D3D11_MESSAGE_ID_JPEGDECODE_DESTBOXESINTERSECT                                               = 0x003001c5,
    D3D11_MESSAGE_ID_JPEGDECODE_XSUBSAMPLEMISMATCH                                               = 0x003001c6,
    D3D11_MESSAGE_ID_JPEGDECODE_YSUBSAMPLEMISMATCH                                               = 0x003001c7,
    D3D11_MESSAGE_ID_JPEGDECODE_XSUBSAMPLEODD                                                    = 0x003001c8,
    D3D11_MESSAGE_ID_JPEGDECODE_YSUBSAMPLEODD                                                    = 0x003001c9,
    D3D11_MESSAGE_ID_JPEGDECODE_OUTPUTDIMENSIONSTOOLARGE                                         = 0x003001ca,
    D3D11_MESSAGE_ID_JPEGDECODE_NONPOW2SCALEUNSUPPORTED                                          = 0x003001cb,
    D3D11_MESSAGE_ID_JPEGDECODE_FRACTIONALDOWNSCALETOLARGE                                       = 0x003001cc,
    D3D11_MESSAGE_ID_JPEGDECODE_CHROMASIZEMISMATCH                                               = 0x003001cd,
    D3D11_MESSAGE_ID_JPEGDECODE_LUMACHROMASIZEMISMATCH                                           = 0x003001ce,
    D3D11_MESSAGE_ID_JPEGDECODE_INVALIDNUMDESTINATIONS                                           = 0x003001cf,
    D3D11_MESSAGE_ID_JPEGDECODE_SUBBOXUNSUPPORTED                                                = 0x003001d0,
    D3D11_MESSAGE_ID_JPEGDECODE_1DESTUNSUPPORTEDFORMAT                                           = 0x003001d1,
    D3D11_MESSAGE_ID_JPEGDECODE_3DESTUNSUPPORTEDFORMAT                                           = 0x003001d2,
    D3D11_MESSAGE_ID_JPEGDECODE_SCALEUNSUPPORTED                                                 = 0x003001d3,
    D3D11_MESSAGE_ID_JPEGDECODE_INVALIDSOURCESIZE                                                = 0x003001d4,
    D3D11_MESSAGE_ID_JPEGDECODE_INVALIDCOPYFLAGS                                                 = 0x003001d5,
    D3D11_MESSAGE_ID_JPEGDECODE_HAZARD                                                           = 0x003001d6,
    D3D11_MESSAGE_ID_JPEGDECODE_UNSUPPORTEDSRCBUFFERUSAGE                                        = 0x003001d7,
    D3D11_MESSAGE_ID_JPEGDECODE_UNSUPPORTEDSRCBUFFERMISCFLAGS                                    = 0x003001d8,
    D3D11_MESSAGE_ID_JPEGDECODE_UNSUPPORTEDDSTTEXTUREUSAGE                                       = 0x003001d9,
    D3D11_MESSAGE_ID_JPEGDECODE_BACKBUFFERNOTSUPPORTED                                           = 0x003001da,
    D3D11_MESSAGE_ID_JPEGDECODE_UNSUPPRTEDCOPYFLAGS                                              = 0x003001db,
    D3D11_MESSAGE_ID_JPEGENCODE_NOTSUPPORTED                                                     = 0x003001dc,
    D3D11_MESSAGE_ID_JPEGENCODE_INVALIDSCANDATAOFFSET                                            = 0x003001dd,
    D3D11_MESSAGE_ID_JPEGENCODE_INVALIDCOMPONENTS                                                = 0x003001de,
    D3D11_MESSAGE_ID_JPEGENCODE_SOURCENOT2D                                                      = 0x003001df,
    D3D11_MESSAGE_ID_JPEGENCODE_TILEDRESOURCESUNSUPPORTED                                        = 0x003001e0,
    D3D11_MESSAGE_ID_JPEGENCODE_GUARDRECTSUNSUPPORTED                                            = 0x003001e1,
    D3D11_MESSAGE_ID_JPEGENCODE_XSUBSAMPLEMISMATCH                                               = 0x003001e2,
    D3D11_MESSAGE_ID_JPEGENCODE_YSUBSAMPLEMISMATCH                                               = 0x003001e3,
    D3D11_MESSAGE_ID_JPEGENCODE_FORMATUNSUPPORTED                                                = 0x003001e4,
    D3D11_MESSAGE_ID_JPEGENCODE_INVALIDSUBRESOURCE                                               = 0x003001e5,
    D3D11_MESSAGE_ID_JPEGENCODE_INVALIDMIPLEVEL                                                  = 0x003001e6,
    D3D11_MESSAGE_ID_JPEGENCODE_DIMENSIONSTOOLARGE                                               = 0x003001e7,
    D3D11_MESSAGE_ID_JPEGENCODE_HAZARD                                                           = 0x003001e8,
    D3D11_MESSAGE_ID_JPEGENCODE_UNSUPPORTEDDSTBUFFERUSAGE                                        = 0x003001e9,
    D3D11_MESSAGE_ID_JPEGENCODE_UNSUPPORTEDDSTBUFFERMISCFLAGS                                    = 0x003001ea,
    D3D11_MESSAGE_ID_JPEGENCODE_UNSUPPORTEDSRCTEXTUREUSAGE                                       = 0x003001eb,
    D3D11_MESSAGE_ID_JPEGENCODE_BACKBUFFERNOTSUPPORTED                                           = 0x003001ec,
    D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_UNSUPPORTEDCONTEXTTTYPEFORQUERY                      = 0x003001ed,
    D3D11_MESSAGE_ID_FLUSH1_INVALIDCONTEXTTYPE                                                   = 0x003001ee,
    D3D11_MESSAGE_ID_DEVICE_SETHARDWAREPROTECTION_INVALIDCONTEXT                                 = 0x003001ef,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTHDRMETADATA_NULLPARAM                                = 0x003001f0,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTHDRMETADATA_INVALIDSIZE                              = 0x003001f1,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTHDRMETADATA_NULLPARAM                                = 0x003001f2,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTHDRMETADATA_INVALIDSIZE                              = 0x003001f3,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMHDRMETADATA_NULLPARAM                                = 0x003001f4,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMHDRMETADATA_INVALIDSTREAM                            = 0x003001f5,
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMHDRMETADATA_INVALIDSIZE                              = 0x003001f6,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMHDRMETADATA_NULLPARAM                                = 0x003001f7,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMHDRMETADATA_INVALIDSTREAM                            = 0x003001f8,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMHDRMETADATA_INVALIDSIZE                              = 0x003001f9,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMFRAMEFORMAT_INVALIDSTREAM                            = 0x003001fa,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMCOLORSPACE_INVALIDSTREAM                             = 0x003001fb,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMOUTPUTRATE_INVALIDSTREAM                             = 0x003001fc,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMSOURCERECT_INVALIDSTREAM                             = 0x003001fd,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMDESTRECT_INVALIDSTREAM                               = 0x003001fe,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMALPHA_INVALIDSTREAM                                  = 0x003001ff,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMPALETTE_INVALIDSTREAM                                = 0x00300200,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMPIXELASPECTRATIO_INVALIDSTREAM                       = 0x00300201,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMLUMAKEY_INVALIDSTREAM                                = 0x00300202,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMSTEREOFORMAT_INVALIDSTREAM                           = 0x00300203,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMAUTOPROCESSINGMODE_INVALIDSTREAM                     = 0x00300204,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMFILTER_INVALIDSTREAM                                 = 0x00300205,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMROTATION_INVALIDSTREAM                               = 0x00300206,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMCOLORSPACE1_INVALIDSTREAM                            = 0x00300207,
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMMIRROR_INVALIDSTREAM                                 = 0x00300208,
    D3D11_MESSAGE_ID_CREATE_FENCE                                                                = 0x00300209,
    D3D11_MESSAGE_ID_LIVE_FENCE                                                                  = 0x0030020a,
    D3D11_MESSAGE_ID_DESTROY_FENCE                                                               = 0x0030020b,
    D3D11_MESSAGE_ID_CREATE_SYNCHRONIZEDCHANNEL                                                  = 0x0030020c,
    D3D11_MESSAGE_ID_LIVE_SYNCHRONIZEDCHANNEL                                                    = 0x0030020d,
    D3D11_MESSAGE_ID_DESTROY_SYNCHRONIZEDCHANNEL                                                 = 0x0030020e,
    D3D11_MESSAGE_ID_CREATEFENCE_INVALIDFLAGS                                                    = 0x0030020f,
    D3D11_MESSAGE_ID_D3D11_3_MESSAGES_END                                                        = 0x00300210,
    D3D11_MESSAGE_ID_D3D11_5_MESSAGES_START                                                      = 0x00300211,
    D3D11_MESSAGE_ID_NEGOTIATECRYPTOSESSIONKEYEXCHANGEMT_INVALIDKEYEXCHANGETYPE                  = 0x00300212,
    D3D11_MESSAGE_ID_NEGOTIATECRYPTOSESSIONKEYEXCHANGEMT_NOT_SUPPORTED                           = 0x00300213,
    D3D11_MESSAGE_ID_DECODERBEGINFRAME_INVALID_HISTOGRAM_COMPONENT_COUNT                         = 0x00300214,
    D3D11_MESSAGE_ID_DECODERBEGINFRAME_INVALID_HISTOGRAM_COMPONENT                               = 0x00300215,
    D3D11_MESSAGE_ID_DECODERBEGINFRAME_INVALID_HISTOGRAM_BUFFER_SIZE                             = 0x00300216,
    D3D11_MESSAGE_ID_DECODERBEGINFRAME_INVALID_HISTOGRAM_BUFFER_USAGE                            = 0x00300217,
    D3D11_MESSAGE_ID_DECODERBEGINFRAME_INVALID_HISTOGRAM_BUFFER_MISC_FLAGS                       = 0x00300218,
    D3D11_MESSAGE_ID_DECODERBEGINFRAME_INVALID_HISTOGRAM_BUFFER_OFFSET                           = 0x00300219,
    D3D11_MESSAGE_ID_CREATE_TRACKEDWORKLOAD                                                      = 0x0030021a,
    D3D11_MESSAGE_ID_LIVE_TRACKEDWORKLOAD                                                        = 0x0030021b,
    D3D11_MESSAGE_ID_DESTROY_TRACKEDWORKLOAD                                                     = 0x0030021c,
    D3D11_MESSAGE_ID_CREATE_TRACKED_WORKLOAD_NULLPARAM                                           = 0x0030021d,
    D3D11_MESSAGE_ID_CREATE_TRACKED_WORKLOAD_INVALID_MAX_INSTANCES                               = 0x0030021e,
    D3D11_MESSAGE_ID_CREATE_TRACKED_WORKLOAD_INVALID_DEADLINE_TYPE                               = 0x0030021f,
    D3D11_MESSAGE_ID_CREATE_TRACKED_WORKLOAD_INVALID_ENGINE_TYPE                                 = 0x00300220,
    D3D11_MESSAGE_ID_MULTIPLE_TRACKED_WORKLOADS                                                  = 0x00300221,
    D3D11_MESSAGE_ID_MULTIPLE_TRACKED_WORKLOAD_PAIRS                                             = 0x00300222,
    D3D11_MESSAGE_ID_INCOMPLETE_TRACKED_WORKLOAD_PAIR                                            = 0x00300223,
    D3D11_MESSAGE_ID_OUT_OF_ORDER_TRACKED_WORKLOAD_PAIR                                          = 0x00300224,
    D3D11_MESSAGE_ID_CANNOT_ADD_TRACKED_WORKLOAD                                                 = 0x00300225,
    D3D11_MESSAGE_ID_TRACKED_WORKLOAD_NOT_SUPPORTED                                              = 0x00300226,
    D3D11_MESSAGE_ID_TRACKED_WORKLOAD_ENGINE_TYPE_NOT_FOUND                                      = 0x00300227,
    D3D11_MESSAGE_ID_NO_TRACKED_WORKLOAD_SLOT_AVAILABLE                                          = 0x00300228,
    D3D11_MESSAGE_ID_END_TRACKED_WORKLOAD_INVALID_ARG                                            = 0x00300229,
    D3D11_MESSAGE_ID_TRACKED_WORKLOAD_DISJOINT_FAILURE                                           = 0x0030022a,
    D3D11_MESSAGE_ID_D3D11_5_MESSAGES_END                                                        = 0x0030022b,
}

///<div class="alert"><b>Note</b> This enumeration is supported by the Direct3D 11.1 runtime, which is available on
///Windows 8 and later operating systems.</div><div> </div>Specifies how to handle the existing contents of a resource
///during a copy or update operation of a region within that resource.
alias D3D11_COPY_FLAGS = int;
enum : int
{
    ///The existing contents of the resource cannot be overwritten.
    D3D11_COPY_NO_OVERWRITE = 0x00000001,
    ///The existing contents of the resource are undefined and can be discarded.
    D3D11_COPY_DISCARD      = 0x00000002,
}

///<div class="alert"><b>Note</b> This enumeration is supported by the Direct3D 11.1 runtime, which is available on
///Windows 8 and later operating systems.</div><div> </div>Specifies logical operations to configure for a render
///target.
alias D3D11_LOGIC_OP = int;
enum : int
{
    ///Clears the render target.
    D3D11_LOGIC_OP_CLEAR         = 0x00000000,
    ///Sets the render target.
    D3D11_LOGIC_OP_SET           = 0x00000001,
    ///Copys the render target.
    D3D11_LOGIC_OP_COPY          = 0x00000002,
    ///Performs an inverted-copy of the render target.
    D3D11_LOGIC_OP_COPY_INVERTED = 0x00000003,
    ///No operation is performed on the render target.
    D3D11_LOGIC_OP_NOOP          = 0x00000004,
    ///Inverts the render target.
    D3D11_LOGIC_OP_INVERT        = 0x00000005,
    ///Performs a logical AND operation on the render target.
    D3D11_LOGIC_OP_AND           = 0x00000006,
    ///Performs a logical NAND operation on the render target.
    D3D11_LOGIC_OP_NAND          = 0x00000007,
    ///Performs a logical OR operation on the render target.
    D3D11_LOGIC_OP_OR            = 0x00000008,
    ///Performs a logical NOR operation on the render target.
    D3D11_LOGIC_OP_NOR           = 0x00000009,
    ///Performs a logical XOR operation on the render target.
    D3D11_LOGIC_OP_XOR           = 0x0000000a,
    ///Performs a logical equal operation on the render target.
    D3D11_LOGIC_OP_EQUIV         = 0x0000000b,
    ///Performs a logical AND and reverse operation on the render target.
    D3D11_LOGIC_OP_AND_REVERSE   = 0x0000000c,
    ///Performs a logical AND and invert operation on the render target.
    D3D11_LOGIC_OP_AND_INVERTED  = 0x0000000d,
    ///Performs a logical OR and reverse operation on the render target.
    D3D11_LOGIC_OP_OR_REVERSE    = 0x0000000e,
    ///Performs a logical OR and invert operation on the render target.
    D3D11_LOGIC_OP_OR_INVERTED   = 0x0000000f,
}

///Describes flags that are used to create a device context state object (ID3DDeviceContextState) with the
///ID3D11Device1::CreateDeviceContextState method.
alias D3D11_1_CREATE_DEVICE_CONTEXT_STATE_FLAG = int;
enum : int
{
    ///You use this flag if your application will only call methods of Direct3D 11 and Direct3D 10 interfaces from a
    ///single thread. By default, Direct3D 11 and Direct3D 10 are thread-safe. By using this flag, you can increase
    ///performance. However, if you use this flag and your application calls methods from multiple threads, undefined
    ///behavior might result.
    D3D11_1_CREATE_DEVICE_CONTEXT_STATE_SINGLETHREADED = 0x00000001,
}

///Identifies how to perform a tile-mapping operation.
alias D3D11_TILE_MAPPING_FLAG = int;
enum : int
{
    ///Indicates that no overwriting of tiles occurs in the tile-mapping operation.
    D3D11_TILE_MAPPING_NO_OVERWRITE = 0x00000001,
}

///Specifies a range of tile mappings to use with ID3D11DeviceContext2::UpdateTiles.
alias D3D11_TILE_RANGE_FLAG = int;
enum : int
{
    ///The tile range is <b>NULL</b>.
    D3D11_TILE_RANGE_NULL              = 0x00000001,
    ///Skip the tile range.
    D3D11_TILE_RANGE_SKIP              = 0x00000002,
    ///Reuse a single tile in the tile range.
    D3D11_TILE_RANGE_REUSE_SINGLE_TILE = 0x00000004,
}

///Identifies how to check multisample quality levels.
alias D3D11_CHECK_MULTISAMPLE_QUALITY_LEVELS_FLAG = int;
enum : int
{
    ///Indicates to check the multisample quality levels of a tiled resource.
    D3D11_CHECK_MULTISAMPLE_QUALITY_LEVELS_TILED_RESOURCE = 0x00000001,
}

///Identifies how to copy a tile.
alias D3D11_TILE_COPY_FLAG = int;
enum : int
{
    ///Indicates that the GPU isn't currently referencing any of the portions of destination memory being written.
    D3D11_TILE_COPY_NO_OVERWRITE                             = 0x00000001,
    ///Indicates that the ID3D11DeviceContext2::CopyTiles operation involves copying a linear buffer to a swizzled tiled
    ///resource. This means to copy tile data from the specified buffer location, reading tiles sequentially, to the
    ///specified tile region (in x,y,z order if the region is a box), swizzling to optimal hardware memory layout as
    ///needed. In this <b>ID3D11DeviceContext2::CopyTiles</b> call, you specify the source data with the <i>pBuffer</i>
    ///parameter and the destination with the <i>pTiledResource</i> parameter.
    D3D11_TILE_COPY_LINEAR_BUFFER_TO_SWIZZLED_TILED_RESOURCE = 0x00000002,
    ///Indicates that the ID3D11DeviceContext2::CopyTiles operation involves copying a swizzled tiled resource to a
    ///linear buffer. This means to copy tile data from the tile region, reading tiles sequentially (in x,y,z order if
    ///the region is a box), to the specified buffer location, deswizzling to linear memory layout as needed. In this
    ///<b>ID3D11DeviceContext2::CopyTiles</b> call, you specify the source data with the <i>pTiledResource</i> parameter
    ///and the destination with the <i>pBuffer</i> parameter.
    D3D11_TILE_COPY_SWIZZLED_TILED_RESOURCE_TO_LINEAR_BUFFER = 0x00000004,
}

///Specifies the context in which a query occurs.
alias D3D11_CONTEXT_TYPE = int;
enum : int
{
    ///The query can occur in all contexts.
    D3D11_CONTEXT_TYPE_ALL     = 0x00000000,
    ///The query occurs in the context of a 3D command queue.
    D3D11_CONTEXT_TYPE_3D      = 0x00000001,
    ///The query occurs in the context of a 3D compute queue.
    D3D11_CONTEXT_TYPE_COMPUTE = 0x00000002,
    ///The query occurs in the context of a 3D copy queue.
    D3D11_CONTEXT_TYPE_COPY    = 0x00000003,
    ///The query occurs in the context of video.
    D3D11_CONTEXT_TYPE_VIDEO   = 0x00000004,
}

///Specifies texture layout options.
alias D3D11_TEXTURE_LAYOUT = int;
enum : int
{
    ///The texture layout is undefined, and is selected by the driver.
    D3D11_TEXTURE_LAYOUT_UNDEFINED            = 0x00000000,
    ///Data for the texture is stored in row major (sometimes called pitch-linear) order.
    D3D11_TEXTURE_LAYOUT_ROW_MAJOR            = 0x00000001,
    ///A default texture uses the standardized swizzle pattern.
    D3D11_TEXTURE_LAYOUT_64K_STANDARD_SWIZZLE = 0x00000002,
}

///Identifies whether conservative rasterization is on or off.
alias D3D11_CONSERVATIVE_RASTERIZATION_MODE = int;
enum : int
{
    ///Conservative rasterization is off.
    D3D11_CONSERVATIVE_RASTERIZATION_MODE_OFF = 0x00000000,
    ///Conservative rasterization is on.
    D3D11_CONSERVATIVE_RASTERIZATION_MODE_ON  = 0x00000001,
}

///Specifies fence options.
alias D3D11_FENCE_FLAG = int;
enum : int
{
    ///No options are specified.
    D3D11_FENCE_FLAG_NONE                 = 0x00000000,
    ///The fence is shared.
    D3D11_FENCE_FLAG_SHARED               = 0x00000002,
    ///The fence is shared with another GPU adapter.
    D3D11_FENCE_FLAG_SHARED_CROSS_ADAPTER = 0x00000004,
    D3D11_FENCE_FLAG_NON_MONITORED        = 0x00000008,
}

///Specifies indices for arrays of per component histogram infromation.
alias D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT = int;
enum : int
{
    ///If the format is a YUV format, indicates a histogram for the Y component.
    D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_Y = 0x00000000,
    ///If the format is a YUV format, indicates a histogram for the U component.
    D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_U = 0x00000001,
    ///If the format is a YUV format, indicates a histogram for the V component.
    D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_V = 0x00000002,
    ///If the format is an RGB/BGR format, indicates a histogram for the R component.
    D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_R = 0x00000000,
    ///If the format is an RGB/BGR format, indicates a histogram for the G component.
    D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_G = 0x00000001,
    ///If the format is an RGB/BGR format, indicates a histogram for the B component.
    D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_B = 0x00000002,
    ///If the format has an alpha channel, indicates a histogram for the A component.
    D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_A = 0x00000003,
}

///Flags for indicating a subset of components used with video decode histogram. This enumeration is used by the
///[D3D12_FEATURE_DATA_VIDEO_DECODE_HISTOGRAM](../d3d12video/ns-d3d12video-d3d12_feature_data_video_decode_histogram.md)
///structure.
alias D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_FLAGS = int;
enum : int
{
    ///No associated component.
    D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_FLAG_NONE = 0x00000000,
    ///If the format is a YUV format, indicates the Y component.
    D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_FLAG_Y    = 0x00000001,
    ///If the format is a YUV format, indicates the U component.
    D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_FLAG_U    = 0x00000002,
    ///If the format is a YUV format, indicates the V component.
    D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_FLAG_V    = 0x00000004,
    ///If the format is an RGB/BGR format, indicates the R component.
    D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_FLAG_R    = 0x00000001,
    ///If the format is an RGB/BGR format, indicates the G component.
    D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_FLAG_G    = 0x00000002,
    ///If the format is an RGB/BGR format, indicates the B component.
    D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_FLAG_B    = 0x00000004,
    ///If the format is an RGB/BGR format, indicates the A component.
    D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_FLAG_A    = 0x00000008,
}

alias D3D11_CRYPTO_SESSION_KEY_EXCHANGE_FLAGS = int;
enum : int
{
    D3D11_CRYPTO_SESSION_KEY_EXCHANGE_FLAG_NONE = 0x00000000,
}

///Indicates shader type.
alias D3D11_SHADER_VERSION_TYPE = int;
enum : int
{
    ///Pixel shader.
    D3D11_SHVER_PIXEL_SHADER    = 0x00000000,
    ///Vertex shader.
    D3D11_SHVER_VERTEX_SHADER   = 0x00000001,
    ///Geometry shader.
    D3D11_SHVER_GEOMETRY_SHADER = 0x00000002,
    ///Hull shader.
    D3D11_SHVER_HULL_SHADER     = 0x00000003,
    ///Domain shader.
    D3D11_SHVER_DOMAIN_SHADER   = 0x00000004,
    ///Compute shader.
    D3D11_SHVER_COMPUTE_SHADER  = 0x00000005,
    ///Indicates the end of the enumeration constants.
    D3D11_SHVER_RESERVED0       = 0x0000fff0,
}

///Identifies a shader type for tracing.
alias D3D11_SHADER_TYPE = int;
enum : int
{
    ///Identifies a vertex shader.
    D3D11_VERTEX_SHADER   = 0x00000001,
    ///Identifies a hull shader.
    D3D11_HULL_SHADER     = 0x00000002,
    ///Identifies a domain shader.
    D3D11_DOMAIN_SHADER   = 0x00000003,
    ///Identifies a geometry shader.
    D3D11_GEOMETRY_SHADER = 0x00000004,
    ///Identifies a pixel shader.
    D3D11_PIXEL_SHADER    = 0x00000005,
    ///Identifies a compute shader.
    D3D11_COMPUTE_SHADER  = 0x00000006,
}

///Identifies the type of geometry shader input primitive.
alias D3D11_TRACE_GS_INPUT_PRIMITIVE = int;
enum : int
{
    ///Identifies the geometry shader input primitive as undefined.
    D3D11_TRACE_GS_INPUT_PRIMITIVE_UNDEFINED    = 0x00000000,
    ///Identifies the geometry shader input primitive as a point.
    D3D11_TRACE_GS_INPUT_PRIMITIVE_POINT        = 0x00000001,
    ///Identifies the geometry shader input primitive as a line.
    D3D11_TRACE_GS_INPUT_PRIMITIVE_LINE         = 0x00000002,
    ///Identifies the geometry shader input primitive as a triangle.
    D3D11_TRACE_GS_INPUT_PRIMITIVE_TRIANGLE     = 0x00000003,
    ///Identifies the geometry shader input primitive as an adjacent line.
    D3D11_TRACE_GS_INPUT_PRIMITIVE_LINE_ADJ     = 0x00000006,
    ///Identifies the geometry shader input primitive as an adjacent triangle.
    D3D11_TRACE_GS_INPUT_PRIMITIVE_TRIANGLE_ADJ = 0x00000007,
}

///Identifies a type of trace register.
alias D3D11_TRACE_REGISTER_TYPE = int;
enum : int
{
    ///Output <b>NULL</b> register.
    D3D11_TRACE_OUTPUT_NULL_REGISTER                        = 0x00000000,
    ///Input register.
    D3D11_TRACE_INPUT_REGISTER                              = 0x00000001,
    ///Input primitive ID register.
    D3D11_TRACE_INPUT_PRIMITIVE_ID_REGISTER                 = 0x00000002,
    ///Immediate constant buffer.
    D3D11_TRACE_IMMEDIATE_CONSTANT_BUFFER                   = 0x00000003,
    ///Temporary register.
    D3D11_TRACE_TEMP_REGISTER                               = 0x00000004,
    ///Temporary register that can be indexed.
    D3D11_TRACE_INDEXABLE_TEMP_REGISTER                     = 0x00000005,
    ///Output register.
    D3D11_TRACE_OUTPUT_REGISTER                             = 0x00000006,
    ///Output oDepth register.
    D3D11_TRACE_OUTPUT_DEPTH_REGISTER                       = 0x00000007,
    ///Constant buffer.
    D3D11_TRACE_CONSTANT_BUFFER                             = 0x00000008,
    ///Immediate32 register.
    D3D11_TRACE_IMMEDIATE32                                 = 0x00000009,
    ///Sampler.
    D3D11_TRACE_SAMPLER                                     = 0x0000000a,
    ///Resource.
    D3D11_TRACE_RESOURCE                                    = 0x0000000b,
    ///Rasterizer.
    D3D11_TRACE_RASTERIZER                                  = 0x0000000c,
    ///Output coverage mask.
    D3D11_TRACE_OUTPUT_COVERAGE_MASK                        = 0x0000000d,
    ///Stream.
    D3D11_TRACE_STREAM                                      = 0x0000000e,
    ///This pointer.
    D3D11_TRACE_THIS_POINTER                                = 0x0000000f,
    ///Output control point ID register (this is actually an input; it defines the output that the thread controls).
    D3D11_TRACE_OUTPUT_CONTROL_POINT_ID_REGISTER            = 0x00000010,
    ///Input fork instance ID register.
    D3D11_TRACE_INPUT_FORK_INSTANCE_ID_REGISTER             = 0x00000011,
    ///Input join instance ID register.
    D3D11_TRACE_INPUT_JOIN_INSTANCE_ID_REGISTER             = 0x00000012,
    ///Input control point register.
    D3D11_TRACE_INPUT_CONTROL_POINT_REGISTER                = 0x00000013,
    ///Output control point register.
    D3D11_TRACE_OUTPUT_CONTROL_POINT_REGISTER               = 0x00000014,
    ///Input patch constant register.
    D3D11_TRACE_INPUT_PATCH_CONSTANT_REGISTER               = 0x00000015,
    ///Input domain point register.
    D3D11_TRACE_INPUT_DOMAIN_POINT_REGISTER                 = 0x00000016,
    ///Unordered-access view.
    D3D11_TRACE_UNORDERED_ACCESS_VIEW                       = 0x00000017,
    ///Thread group shared memory.
    D3D11_TRACE_THREAD_GROUP_SHARED_MEMORY                  = 0x00000018,
    ///Input thread ID register.
    D3D11_TRACE_INPUT_THREAD_ID_REGISTER                    = 0x00000019,
    ///Thread group ID register.
    D3D11_TRACE_INPUT_THREAD_GROUP_ID_REGISTER              = 0x0000001a,
    ///Input thread ID in-group register.
    D3D11_TRACE_INPUT_THREAD_ID_IN_GROUP_REGISTER           = 0x0000001b,
    ///Input coverage mask register.
    D3D11_TRACE_INPUT_COVERAGE_MASK_REGISTER                = 0x0000001c,
    ///Input thread ID in-group flattened register.
    D3D11_TRACE_INPUT_THREAD_ID_IN_GROUP_FLATTENED_REGISTER = 0x0000001d,
    ///Input geometry shader (GS) instance ID register.
    D3D11_TRACE_INPUT_GS_INSTANCE_ID_REGISTER               = 0x0000001e,
    ///Output oDepth greater than or equal register.
    D3D11_TRACE_OUTPUT_DEPTH_GREATER_EQUAL_REGISTER         = 0x0000001f,
    ///Output oDepth less than or equal register.
    D3D11_TRACE_OUTPUT_DEPTH_LESS_EQUAL_REGISTER            = 0x00000020,
    ///Immediate64 register.
    D3D11_TRACE_IMMEDIATE64                                 = 0x00000021,
    ///Cycle counter register.
    D3D11_TRACE_INPUT_CYCLE_COUNTER_REGISTER                = 0x00000022,
    ///Interface pointer.
    D3D11_TRACE_INTERFACE_POINTER                           = 0x00000023,
}

///Type for scan data.
alias D3DX11_SCAN_DATA_TYPE = int;
enum : int
{
    ///FLOAT data.
    D3DX11_SCAN_DATA_TYPE_FLOAT = 0x00000001,
    ///INT data.
    D3DX11_SCAN_DATA_TYPE_INT   = 0x00000002,
    ///UINT data.
    D3DX11_SCAN_DATA_TYPE_UINT  = 0x00000003,
}

///Scan opcodes.
alias D3DX11_SCAN_OPCODE = int;
enum : int
{
    ///Add values.
    D3DX11_SCAN_OPCODE_ADD = 0x00000001,
    ///Take the minimum value.
    D3DX11_SCAN_OPCODE_MIN = 0x00000002,
    ///Take the maximum value.
    D3DX11_SCAN_OPCODE_MAX = 0x00000003,
    ///Multiply the values.
    D3DX11_SCAN_OPCODE_MUL = 0x00000004,
    ///Perform a logical AND on the values.
    D3DX11_SCAN_OPCODE_AND = 0x00000005,
    ///Perform a logical OR on the values.
    D3DX11_SCAN_OPCODE_OR  = 0x00000006,
    ///Perform a logical XOR on the values.
    D3DX11_SCAN_OPCODE_XOR = 0x00000007,
}

///Direction to perform scan in.
alias D3DX11_SCAN_DIRECTION = int;
enum : int
{
    ///Scan forward.
    D3DX11_SCAN_DIRECTION_FORWARD  = 0x00000001,
    ///Scan backward.
    D3DX11_SCAN_DIRECTION_BACKWARD = 0x00000002,
}

///FFT data types.
alias D3DX11_FFT_DATA_TYPE = int;
enum : int
{
    ///Real numbers.
    D3DX11_FFT_DATA_TYPE_REAL    = 0x00000000,
    ///Complex numbers.
    D3DX11_FFT_DATA_TYPE_COMPLEX = 0x00000001,
}

///Number of dimensions for FFT data.
alias D3DX11_FFT_DIM_MASK = int;
enum : int
{
    ///One dimension.
    D3DX11_FFT_DIM_MASK_1D = 0x00000001,
    ///Two dimensions.
    D3DX11_FFT_DIM_MASK_2D = 0x00000003,
    ///Three dimensions.
    D3DX11_FFT_DIM_MASK_3D = 0x00000007,
}

///FFT creation flags.
alias D3DX11_FFT_CREATE_FLAG = int;
enum : int
{
    ///Do not AddRef or Release temp and precompute buffers, caller is responsible for holding references to these
    ///buffers.
    D3DX11_FFT_CREATE_FLAG_NO_PRECOMPUTE_BUFFERS = 0x00000001,
}

// Constants


enum uint D3D11_SDK_VERSION = 0x00000007;
enum int D3D_FL9_3_REQ_TEXTURE1D_U_DIMENSION = 0x00001000;
enum int D3D_FL9_3_REQ_TEXTURE2D_U_OR_V_DIMENSION = 0x00001000;
enum int D3D_FL9_3_REQ_TEXTURECUBE_DIMENSION = 0x00001000;
enum int D3D_FL9_1_DEFAULT_MAX_ANISOTROPY = 0x00000002;
enum int D3D_FL9_2_IA_PRIMITIVE_MAX_COUNT = 0x000fffff;
enum int D3D_FL9_3_SIMULTANEOUS_RENDER_TARGET_COUNT = 0x00000004;
enum int D3D_FL9_2_MAX_TEXTURE_REPEAT = 0x00000800;

enum : GUID
{
    WKPDID_D3DDebugObjectName  = GUID("429b8c22-9188-4b0c-8742-acb0bf85c200"),
    WKPDID_D3DDebugObjectNameW = GUID("4cca5fd8-921f-42c8-8566-70caf2a9b741"),
}

enum : GUID
{
    D3D_TEXTURE_LAYOUT_ROW_MAJOR             = GUID("b5dc234f-72bb-4bec-9705-8cf258df6b6c"),
    D3D_TEXTURE_LAYOUT_64KB_STANDARD_SWIZZLE = GUID("4c0f29e3-3f5f-4d35-84c9-bc0983b62c28"),
}

enum : int
{
    D3D_COMPONENT_MASK_Y = 0x00000002,
    D3D_COMPONENT_MASK_Z = 0x00000004,
    D3D_COMPONENT_MASK_W = 0x00000008,
}

// Callbacks

alias PFN_DESTRUCTION_CALLBACK = void function(void* pData);
alias PFN_D3D11_CREATE_DEVICE = HRESULT function(IDXGIAdapter param0, D3D_DRIVER_TYPE param1, ptrdiff_t param2, 
                                                 uint param3, const(D3D_FEATURE_LEVEL)* param4, uint FeatureLevels, 
                                                 uint param6, ID3D11Device* param7, D3D_FEATURE_LEVEL* param8, 
                                                 ID3D11DeviceContext* param9);
alias PFN_D3D11_CREATE_DEVICE_AND_SWAP_CHAIN = HRESULT function(IDXGIAdapter param0, D3D_DRIVER_TYPE param1, 
                                                                ptrdiff_t param2, uint param3, 
                                                                const(D3D_FEATURE_LEVEL)* param4, uint FeatureLevels, 
                                                                uint param6, const(DXGI_SWAP_CHAIN_DESC)* param7, 
                                                                IDXGISwapChain* param8, ID3D11Device* param9, 
                                                                D3D_FEATURE_LEVEL* param10, 
                                                                ID3D11DeviceContext* param11);

// Structs


///Defines a shader macro.
struct D3D_SHADER_MACRO
{
    ///The macro name.
    const(PSTR) Name;
    ///The macro definition.
    const(PSTR) Definition;
}

///A description of a single element for the input-assembler stage.
struct D3D11_INPUT_ELEMENT_DESC
{
    ///Type: <b>LPCSTR</b> The HLSL semantic associated with this element in a shader input-signature.
    const(PSTR) SemanticName;
    ///Type: <b>UINT</b> The semantic index for the element. A semantic index modifies a semantic, with an integer index
    ///number. A semantic index is only needed in a case where there is more than one element with the same semantic.
    ///For example, a 4x4 matrix would have four components each with the semantic name ``` matrix ``` , however each of
    ///the four component would have different semantic indices (0, 1, 2, and 3).
    uint        SemanticIndex;
    ///Type: <b>DXGI_FORMAT</b> The data type of the element data. See DXGI_FORMAT.
    DXGI_FORMAT Format;
    ///Type: <b>UINT</b> An integer value that identifies the input-assembler (see input slot). Valid values are between
    ///0 and 15, defined in D3D11.h.
    uint        InputSlot;
    ///Type: <b>UINT</b> Optional. Offset (in bytes) from the start of the vertex. Use D3D11_APPEND_ALIGNED_ELEMENT for
    ///convenience to define the current element directly after the previous one, including any packing if necessary.
    uint        AlignedByteOffset;
    ///Type: <b>D3D11_INPUT_CLASSIFICATION</b> Identifies the input data class for a single input slot (see
    ///D3D11_INPUT_CLASSIFICATION).
    D3D11_INPUT_CLASSIFICATION InputSlotClass;
    ///Type: <b>UINT</b> The number of instances to draw using the same per-instance data before advancing in the buffer
    ///by one element. This value must be 0 for an element that contains per-vertex data (the slot class is set to
    ///D3D11_INPUT_PER_VERTEX_DATA).
    uint        InstanceDataStepRate;
}

///Description of a vertex element in a vertex buffer in an output slot.
struct D3D11_SO_DECLARATION_ENTRY
{
    ///Type: <b>UINT</b> Zero-based, stream number.
    uint        Stream;
    ///Type: <b>LPCSTR</b> Type of output element; possible values include: <b>"POSITION"</b>, <b>"NORMAL"</b>, or
    ///<b>"TEXCOORD0"</b>. Note that if <i>SemanticName</i> is <b>NULL</b> then <i>ComponentCount</i> can be greater
    ///than 4 and the described entry will be a gap in the stream out where no data will be written.
    const(PSTR) SemanticName;
    ///Type: <b>UINT</b> Output element's zero-based index. Should be used if, for example, you have more than one
    ///texture coordinate stored in each vertex.
    uint        SemanticIndex;
    ///Type: <b>BYTE</b> Which component of the entry to begin writing out to. Valid values are 0 to 3. For example, if
    ///you only wish to output to the y and z components of a position, then StartComponent should be 1 and
    ///ComponentCount should be 2.
    ubyte       StartComponent;
    ///Type: <b>BYTE</b> The number of components of the entry to write out to. Valid values are 1 to 4. For example, if
    ///you only wish to output to the y and z components of a position, then StartComponent should be 1 and
    ///ComponentCount should be 2. Note that if <i>SemanticName</i> is <b>NULL</b> then <i>ComponentCount</i> can be
    ///greater than 4 and the described entry will be a gap in the stream out where no data will be written.
    ubyte       ComponentCount;
    ///Type: <b>BYTE</b> The associated stream output buffer that is bound to the pipeline (see
    ///ID3D11DeviceContext::SOSetTargets). The valid range for <i>OutputSlot</i> is 0 to 3.
    ubyte       OutputSlot;
}

///Defines the dimensions of a viewport.
struct D3D11_VIEWPORT
{
    ///Type: <b>FLOAT</b> X position of the left hand side of the viewport. Ranges between D3D11_VIEWPORT_BOUNDS_MIN and
    ///D3D11_VIEWPORT_BOUNDS_MAX.
    float TopLeftX;
    ///Type: <b>FLOAT</b> Y position of the top of the viewport. Ranges between D3D11_VIEWPORT_BOUNDS_MIN and
    ///D3D11_VIEWPORT_BOUNDS_MAX.
    float TopLeftY;
    ///Type: <b>FLOAT</b> Width of the viewport.
    float Width;
    ///Type: <b>FLOAT</b> Height of the viewport.
    float Height;
    ///Type: <b>FLOAT</b> Minimum depth of the viewport. Ranges between 0 and 1.
    float MinDepth;
    ///Type: <b>FLOAT</b> Maximum depth of the viewport. Ranges between 0 and 1.
    float MaxDepth;
}

///Arguments for draw instanced indirect.
struct D3D11_DRAW_INSTANCED_INDIRECT_ARGS
{
    ///The number of vertices to draw.
    uint VertexCountPerInstance;
    ///The number of instances to draw.
    uint InstanceCount;
    ///The index of the first vertex.
    uint StartVertexLocation;
    ///A value added to each index before reading per-instance data from a vertex buffer.
    uint StartInstanceLocation;
}

///Arguments for draw indexed instanced indirect.
struct D3D11_DRAW_INDEXED_INSTANCED_INDIRECT_ARGS
{
    ///The number of indices read from the index buffer for each instance.
    uint IndexCountPerInstance;
    ///The number of instances to draw.
    uint InstanceCount;
    ///The location of the first index read by the GPU from the index buffer.
    uint StartIndexLocation;
    ///A value added to each index before reading a vertex from the vertex buffer.
    int  BaseVertexLocation;
    ///A value added to each index before reading per-instance data from a vertex buffer.
    uint StartInstanceLocation;
}

///Defines a 3D box.
struct D3D11_BOX
{
    ///Type: <b>UINT</b> The x position of the left hand side of the box.
    uint left;
    ///Type: <b>UINT</b> The y position of the top of the box.
    uint top;
    ///Type: <b>UINT</b> The z position of the front of the box.
    uint front;
    ///Type: <b>UINT</b> The x position of the right hand side of the box.
    uint right;
    ///Type: <b>UINT</b> The y position of the bottom of the box.
    uint bottom;
    ///Type: <b>UINT</b> The z position of the back of the box.
    uint back;
}

///Stencil operations that can be performed based on the results of stencil test.
struct D3D11_DEPTH_STENCILOP_DESC
{
    ///Type: <b>D3D11_STENCIL_OP</b> The stencil operation to perform when stencil testing fails.
    D3D11_STENCIL_OP StencilFailOp;
    ///Type: <b>D3D11_STENCIL_OP</b> The stencil operation to perform when stencil testing passes and depth testing
    ///fails.
    D3D11_STENCIL_OP StencilDepthFailOp;
    ///Type: <b>D3D11_STENCIL_OP</b> The stencil operation to perform when stencil testing and depth testing both pass.
    D3D11_STENCIL_OP StencilPassOp;
    ///Type: <b>D3D11_COMPARISON_FUNC</b> A function that compares stencil data against existing stencil data. The
    ///function options are listed in D3D11_COMPARISON_FUNC.
    D3D11_COMPARISON_FUNC StencilFunc;
}

///Describes depth-stencil state.
struct D3D11_DEPTH_STENCIL_DESC
{
    ///Type: <b>BOOL</b> Enable depth testing.
    BOOL  DepthEnable;
    ///Type: <b>D3D11_DEPTH_WRITE_MASK</b> Identify a portion of the depth-stencil buffer that can be modified by depth
    ///data (see D3D11_DEPTH_WRITE_MASK).
    D3D11_DEPTH_WRITE_MASK DepthWriteMask;
    ///Type: <b>D3D11_COMPARISON_FUNC</b> A function that compares depth data against existing depth data. The function
    ///options are listed in D3D11_COMPARISON_FUNC.
    D3D11_COMPARISON_FUNC DepthFunc;
    ///Type: <b>BOOL</b> Enable stencil testing.
    BOOL  StencilEnable;
    ///Type: <b>UINT8</b> Identify a portion of the depth-stencil buffer for reading stencil data.
    ubyte StencilReadMask;
    ///Type: <b>UINT8</b> Identify a portion of the depth-stencil buffer for writing stencil data.
    ubyte StencilWriteMask;
    ///Type: <b>D3D11_DEPTH_STENCILOP_DESC</b> Identify how to use the results of the depth test and the stencil test
    ///for pixels whose surface normal is facing towards the camera (see D3D11_DEPTH_STENCILOP_DESC).
    D3D11_DEPTH_STENCILOP_DESC FrontFace;
    ///Type: <b>D3D11_DEPTH_STENCILOP_DESC</b> Identify how to use the results of the depth test and the stencil test
    ///for pixels whose surface normal is facing away from the camera (see D3D11_DEPTH_STENCILOP_DESC).
    D3D11_DEPTH_STENCILOP_DESC BackFace;
}

///Describes the blend state for a render target.
struct D3D11_RENDER_TARGET_BLEND_DESC
{
    ///Type: <b>BOOL</b> Enable (or disable) blending.
    BOOL           BlendEnable;
    ///Type: <b>D3D11_BLEND</b> This blend option specifies the operation to perform on the RGB value that the pixel
    ///shader outputs. The <b>BlendOp</b> member defines how to combine the <b>SrcBlend</b> and <b>DestBlend</b>
    ///operations.
    D3D11_BLEND    SrcBlend;
    ///Type: <b>D3D11_BLEND</b> This blend option specifies the operation to perform on the current RGB value in the
    ///render target. The <b>BlendOp</b> member defines how to combine the <b>SrcBlend</b> and <b>DestBlend</b>
    ///operations.
    D3D11_BLEND    DestBlend;
    ///Type: <b>D3D11_BLEND_OP</b> This blend operation defines how to combine the <b>SrcBlend</b> and <b>DestBlend</b>
    ///operations.
    D3D11_BLEND_OP BlendOp;
    ///Type: <b>D3D11_BLEND</b> This blend option specifies the operation to perform on the alpha value that the pixel
    ///shader outputs. Blend options that end in _COLOR are not allowed. The <b>BlendOpAlpha</b> member defines how to
    ///combine the <b>SrcBlendAlpha</b> and <b>DestBlendAlpha</b> operations.
    D3D11_BLEND    SrcBlendAlpha;
    ///Type: <b>D3D11_BLEND</b> This blend option specifies the operation to perform on the current alpha value in the
    ///render target. Blend options that end in _COLOR are not allowed. The <b>BlendOpAlpha</b> member defines how to
    ///combine the <b>SrcBlendAlpha</b> and <b>DestBlendAlpha</b> operations.
    D3D11_BLEND    DestBlendAlpha;
    ///Type: <b>D3D11_BLEND_OP</b> This blend operation defines how to combine the <b>SrcBlendAlpha</b> and
    ///<b>DestBlendAlpha</b> operations.
    D3D11_BLEND_OP BlendOpAlpha;
    ///Type: <b>UINT8</b> A write mask.
    ubyte          RenderTargetWriteMask;
}

///Describes the blend state that you use in a call to ID3D11Device::CreateBlendState to create a blend-state object.
struct D3D11_BLEND_DESC
{
    ///Type: <b>BOOL</b> Specifies whether to use alpha-to-coverage as a multisampling technique when setting a pixel to
    ///a render target. For more info about using alpha-to-coverage, see Alpha-To-Coverage.
    BOOL AlphaToCoverageEnable;
    ///Type: <b>BOOL</b> Specifies whether to enable independent blending in simultaneous render targets. Set to
    ///<b>TRUE</b> to enable independent blending. If set to <b>FALSE</b>, only the RenderTarget[0] members are used;
    ///RenderTarget[1..7] are ignored.
    BOOL IndependentBlendEnable;
    ///Type: <b>D3D11_RENDER_TARGET_BLEND_DESC[8]</b> An array of D3D11_RENDER_TARGET_BLEND_DESC structures that
    ///describe the blend states for render targets; these correspond to the eight render targets that can be bound to
    ///the output-merger stage at one time.
    D3D11_RENDER_TARGET_BLEND_DESC[8] RenderTarget;
}

///Describes rasterizer state.
struct D3D11_RASTERIZER_DESC
{
    ///Type: <b>D3D11_FILL_MODE</b> Determines the fill mode to use when rendering (see D3D11_FILL_MODE).
    D3D11_FILL_MODE FillMode;
    ///Type: <b>D3D11_CULL_MODE</b> Indicates triangles facing the specified direction are not drawn (see
    ///D3D11_CULL_MODE).
    D3D11_CULL_MODE CullMode;
    ///Type: <b>BOOL</b> Determines if a triangle is front- or back-facing. If this parameter is <b>TRUE</b>, a triangle
    ///will be considered front-facing if its vertices are counter-clockwise on the render target and considered
    ///back-facing if they are clockwise. If this parameter is <b>FALSE</b>, the opposite is true.
    BOOL            FrontCounterClockwise;
    ///Type: <b>INT</b> Depth value added to a given pixel. For info about depth bias, see Depth Bias.
    int             DepthBias;
    ///Type: <b>FLOAT</b> Maximum depth bias of a pixel. For info about depth bias, see Depth Bias.
    float           DepthBiasClamp;
    ///Type: <b>FLOAT</b> Scalar on a given pixel's slope. For info about depth bias, see Depth Bias.
    float           SlopeScaledDepthBias;
    ///Type: <b>BOOL</b> Enable clipping based on distance. The hardware always performs x and y clipping of rasterized
    ///coordinates. When <b>DepthClipEnable</b> is set to the default–<b>TRUE</b>, the hardware also clips the z value
    ///(that is, the hardware performs the last step of the following algorithm). <pre class="syntax"
    ///xml:space="preserve"><code> 0 &lt; w -w &lt;= x &lt;= w (or arbitrarily wider range if implementation uses a
    ///guard band to reduce clipping burden) -w &lt;= y &lt;= w (or arbitrarily wider range if implementation uses a
    ///guard band to reduce clipping burden) 0 &lt;= z &lt;= w </code></pre> When you set <b>DepthClipEnable</b> to
    ///<b>FALSE</b>, the hardware skips the z clipping (that is, the last step in the preceding algorithm). However, the
    ///hardware still performs the "0 &lt; w" clipping. When z clipping is disabled, improper depth ordering at the
    ///pixel level might result. However, when z clipping is disabled, stencil shadow implementations are simplified. In
    ///other words, you can avoid complex special-case handling for geometry that goes beyond the back clipping plane.
    BOOL            DepthClipEnable;
    ///Type: <b>BOOL</b> Enable scissor-rectangle culling. All pixels outside an active scissor rectangle are culled.
    BOOL            ScissorEnable;
    ///Type: <b>BOOL</b> Specifies whether to use the quadrilateral or alpha line anti-aliasing algorithm on multisample
    ///antialiasing (MSAA) render targets. Set to <b>TRUE</b> to use the quadrilateral line anti-aliasing algorithm and
    ///to <b>FALSE</b> to use the alpha line anti-aliasing algorithm. For more info about this member, see Remarks.
    BOOL            MultisampleEnable;
    ///Type: <b>BOOL</b> Specifies whether to enable line antialiasing; only applies if doing line drawing and
    ///<b>MultisampleEnable</b> is <b>FALSE</b>. For more info about this member, see Remarks.
    BOOL            AntialiasedLineEnable;
}

///Specifies data for initializing a subresource.
struct D3D11_SUBRESOURCE_DATA
{
    ///Type: <b>const void*</b> Pointer to the initialization data.
    const(void)* pSysMem;
    ///Type: <b>UINT</b> The distance (in bytes) from the beginning of one line of a texture to the next line.
    ///System-memory pitch is used only for 2D and 3D texture data as it is has no meaning for the other resource types.
    ///Specify the distance from the first pixel of one 2D slice of a 3D texture to the first pixel of the next 2D slice
    ///in that texture in the <b>SysMemSlicePitch</b> member.
    uint         SysMemPitch;
    ///Type: <b>UINT</b> The distance (in bytes) from the beginning of one depth level to the next. System-memory-slice
    ///pitch is only used for 3D texture data as it has no meaning for the other resource types.
    uint         SysMemSlicePitch;
}

///Provides access to subresource data.
struct D3D11_MAPPED_SUBRESOURCE
{
    ///Type: <b>void*</b> Pointer to the data. When ID3D11DeviceContext::Map provides the pointer, the runtime ensures
    ///that the pointer has a specific alignment, depending on the following feature levels: <ul> <li>For
    ///D3D_FEATURE_LEVEL_10_0 and higher, the pointer is aligned to 16 bytes.</li> <li>For lower than
    ///D3D_FEATURE_LEVEL_10_0, the pointer is aligned to 4 bytes.</li> </ul>
    void* pData;
    ///Type: <b>UINT</b> The row pitch, or width, or physical size (in bytes) of the data.
    uint  RowPitch;
    ///Type: <b>UINT</b> The depth pitch, or width, or physical size (in bytes)of the data.
    uint  DepthPitch;
}

///Describes a buffer resource.
struct D3D11_BUFFER_DESC
{
    ///Type: <b>UINT</b> Size of the buffer in bytes.
    uint        ByteWidth;
    ///Type: <b>D3D11_USAGE</b> Identify how the buffer is expected to be read from and written to. Frequency of update
    ///is a key factor. The most common value is typically D3D11_USAGE_DEFAULT; see D3D11_USAGE for all possible values.
    D3D11_USAGE Usage;
    ///Type: <b>UINT</b> Identify how the buffer will be bound to the pipeline. Flags (see D3D11_BIND_FLAG) can be
    ///combined with a logical OR.
    uint        BindFlags;
    ///Type: <b>UINT</b> CPU access flags (see D3D11_CPU_ACCESS_FLAG) or 0 if no CPU access is necessary. Flags can be
    ///combined with a logical OR.
    uint        CPUAccessFlags;
    ///Type: <b>UINT</b> Miscellaneous flags (see D3D11_RESOURCE_MISC_FLAG) or 0 if unused. Flags can be combined with a
    ///logical OR.
    uint        MiscFlags;
    ///Type: <b>UINT</b> The size of each element in the buffer structure (in bytes) when the buffer represents a
    ///structured buffer. For more info about structured buffers, see Structured Buffer. The size value in
    ///<b>StructureByteStride</b> must match the size of the format that you use for views of the buffer. For example,
    ///if you use a shader resource view (SRV) to read a buffer in a pixel shader, the SRV format size must match the
    ///size value in <b>StructureByteStride</b>.
    uint        StructureByteStride;
}

///Describes a 1D texture.
struct D3D11_TEXTURE1D_DESC
{
    ///Type: <b>UINT</b> Texture width (in texels). The range is from 1 to D3D11_REQ_TEXTURE1D_U_DIMENSION (16384).
    ///However, the range is actually constrained by the feature level at which you create the rendering device. For
    ///more information about restrictions, see Remarks.
    uint        Width;
    ///Type: <b>UINT</b> The maximum number of mipmap levels in the texture. See the remarks in D3D11_TEX1D_SRV. Use 1
    ///for a multisampled texture; or 0 to generate a full set of subtextures.
    uint        MipLevels;
    ///Type: <b>UINT</b> Number of textures in the array. The range is from 1 to
    ///D3D11_REQ_TEXTURE1D_ARRAY_AXIS_DIMENSION (2048). However, the range is actually constrained by the feature level
    ///at which you create the rendering device. For more information about restrictions, see Remarks.
    uint        ArraySize;
    ///Type: <b>DXGI_FORMAT</b> Texture format (see DXGI_FORMAT).
    DXGI_FORMAT Format;
    ///Type: <b>D3D11_USAGE</b> Value that identifies how the texture is to be read from and written to. The most common
    ///value is D3D11_USAGE_DEFAULT; see D3D11_USAGE for all possible values.
    D3D11_USAGE Usage;
    ///Type: <b>UINT</b> Flags (see D3D11_BIND_FLAG) for binding to pipeline stages. The flags can be combined by a
    ///logical OR. For a 1D texture, the allowable values are: D3D11_BIND_SHADER_RESOURCE, D3D11_BIND_RENDER_TARGET and
    ///D3D11_BIND_DEPTH_STENCIL.
    uint        BindFlags;
    ///Type: <b>UINT</b> Flags (see D3D11_CPU_ACCESS_FLAG) to specify the types of CPU access allowed. Use 0 if CPU
    ///access is not required. These flags can be combined with a logical OR.
    uint        CPUAccessFlags;
    ///Type: <b>UINT</b> Flags (see D3D11_RESOURCE_MISC_FLAG) that identify other, less common resource options. Use 0
    ///if none of these flags apply. These flags can be combined with a logical OR.
    uint        MiscFlags;
}

///Describes a 2D texture.
struct D3D11_TEXTURE2D_DESC
{
    ///Type: <b>UINT</b> Texture width (in texels). The range is from 1 to D3D11_REQ_TEXTURE2D_U_OR_V_DIMENSION (16384).
    ///For a texture cube-map, the range is from 1 to D3D11_REQ_TEXTURECUBE_DIMENSION (16384). However, the range is
    ///actually constrained by the feature level at which you create the rendering device. For more information about
    ///restrictions, see Remarks.
    uint             Width;
    ///Type: <b>UINT</b> Texture height (in texels). The range is from 1 to D3D11_REQ_TEXTURE2D_U_OR_V_DIMENSION
    ///(16384). For a texture cube-map, the range is from 1 to D3D11_REQ_TEXTURECUBE_DIMENSION (16384). However, the
    ///range is actually constrained by the feature level at which you create the rendering device. For more information
    ///about restrictions, see Remarks.
    uint             Height;
    ///Type: <b>UINT</b> The maximum number of mipmap levels in the texture. See the remarks in D3D11_TEX1D_SRV. Use 1
    ///for a multisampled texture; or 0 to generate a full set of subtextures.
    uint             MipLevels;
    ///Type: <b>UINT</b> Number of textures in the texture array. The range is from 1 to
    ///D3D11_REQ_TEXTURE2D_ARRAY_AXIS_DIMENSION (2048). For a texture cube-map, this value is a multiple of 6 (that is,
    ///6 times the value in the <b>NumCubes</b> member of D3D11_TEXCUBE_ARRAY_SRV), and the range is from 6 to 2046. The
    ///range is actually constrained by the feature level at which you create the rendering device. For more information
    ///about restrictions, see Remarks.
    uint             ArraySize;
    ///Type: <b>DXGI_FORMAT</b> Texture format (see DXGI_FORMAT).
    DXGI_FORMAT      Format;
    ///Type: <b>DXGI_SAMPLE_DESC</b> Structure that specifies multisampling parameters for the texture. See
    ///DXGI_SAMPLE_DESC.
    DXGI_SAMPLE_DESC SampleDesc;
    ///Type: <b>D3D11_USAGE</b> Value that identifies how the texture is to be read from and written to. The most common
    ///value is D3D11_USAGE_DEFAULT; see D3D11_USAGE for all possible values.
    D3D11_USAGE      Usage;
    ///Type: <b>UINT</b> Flags (see D3D11_BIND_FLAG) for binding to pipeline stages. The flags can be combined by a
    ///logical OR.
    uint             BindFlags;
    ///Type: <b>UINT</b> Flags (see D3D11_CPU_ACCESS_FLAG) to specify the types of CPU access allowed. Use 0 if CPU
    ///access is not required. These flags can be combined with a logical OR.
    uint             CPUAccessFlags;
    ///Type: <b>UINT</b> Flags (see D3D11_RESOURCE_MISC_FLAG) that identify other, less common resource options. Use 0
    ///if none of these flags apply. These flags can be combined by using a logical OR. For a texture cube-map, set the
    ///D3D11_RESOURCE_MISC_TEXTURECUBE flag. Cube-map arrays (that is, <b>ArraySize</b> &gt; 6) require feature level
    ///D3D_FEATURE_LEVEL_10_1 or higher.
    uint             MiscFlags;
}

///Describes a 3D texture.
struct D3D11_TEXTURE3D_DESC
{
    ///Type: <b>UINT</b> Texture width (in texels). The range is from 1 to D3D11_REQ_TEXTURE3D_U_V_OR_W_DIMENSION
    ///(2048). However, the range is actually constrained by the feature level at which you create the rendering device.
    ///For more information about restrictions, see Remarks.
    uint        Width;
    ///Type: <b>UINT</b> Texture height (in texels). The range is from 1 to D3D11_REQ_TEXTURE3D_U_V_OR_W_DIMENSION
    ///(2048). However, the range is actually constrained by the feature level at which you create the rendering device.
    ///For more information about restrictions, see Remarks.
    uint        Height;
    ///Type: <b>UINT</b> Texture depth (in texels). The range is from 1 to D3D11_REQ_TEXTURE3D_U_V_OR_W_DIMENSION
    ///(2048). However, the range is actually constrained by the feature level at which you create the rendering device.
    ///For more information about restrictions, see Remarks.
    uint        Depth;
    ///Type: <b>UINT</b> The maximum number of mipmap levels in the texture. See the remarks in D3D11_TEX1D_SRV. Use 1
    ///for a multisampled texture; or 0 to generate a full set of subtextures.
    uint        MipLevels;
    ///Type: <b>DXGI_FORMAT</b> Texture format (see DXGI_FORMAT).
    DXGI_FORMAT Format;
    ///Type: <b>D3D11_USAGE</b> Value that identifies how the texture is to be read from and written to. The most common
    ///value is D3D11_USAGE_DEFAULT; see D3D11_USAGE for all possible values.
    D3D11_USAGE Usage;
    ///Type: <b>UINT</b> Flags (see D3D11_BIND_FLAG) for binding to pipeline stages. The flags can be combined by a
    ///logical OR.
    uint        BindFlags;
    ///Type: <b>UINT</b> Flags (see D3D11_CPU_ACCESS_FLAG) to specify the types of CPU access allowed. Use 0 if CPU
    ///access is not required. These flags can be combined with a logical OR.
    uint        CPUAccessFlags;
    ///Type: <b>UINT</b> Flags (see D3D11_RESOURCE_MISC_FLAG) that identify other, less common resource options. Use 0
    ///if none of these flags apply. These flags can be combined with a logical OR.
    uint        MiscFlags;
}

///Specifies the elements in a buffer resource to use in a shader-resource view.
struct D3D11_BUFFER_SRV
{
union
    {
        uint FirstElement;
        uint ElementOffset;
    }
union
    {
        uint NumElements;
        uint ElementWidth;
    }
}

///Describes the elements in a raw buffer resource to use in a shader-resource view.
struct D3D11_BUFFEREX_SRV
{
    ///Type: <b>UINT</b> The index of the first element to be accessed by the view.
    uint FirstElement;
    ///Type: <b>UINT</b> The number of elements in the resource.
    uint NumElements;
    ///Type: <b>UINT</b> A D3D11_BUFFEREX_SRV_FLAG-typed value that identifies view options for the buffer. Currently,
    ///the only option is to identify a raw view of the buffer. For more info about raw viewing of buffers, see Raw
    ///Views of Buffers.
    uint Flags;
}

///Specifies the subresource from a 1D texture to use in a shader-resource view.
struct D3D11_TEX1D_SRV
{
    ///Type: <b>UINT</b> Index of the most detailed mipmap level to use; this number is between 0 and <b>MipLevels</b>
    ///(from the original Texture1D for which ID3D11Device::CreateShaderResourceView creates a view) -1.
    uint MostDetailedMip;
    ///Type: <b>UINT</b> The maximum number of mipmap levels for the view of the texture. See the remarks. Set to -1 to
    ///indicate all the mipmap levels from <b>MostDetailedMip</b> on down to least detailed.
    uint MipLevels;
}

///Specifies the subresources from an array of 1D textures to use in a shader-resource view.
struct D3D11_TEX1D_ARRAY_SRV
{
    ///Type: <b>UINT</b> Index of the most detailed mipmap level to use; this number is between 0 and <b>MipLevels</b>
    ///(from the original Texture1D for which ID3D11Device::CreateShaderResourceView creates a view) -1.
    uint MostDetailedMip;
    ///Type: <b>UINT</b> The maximum number of mipmap levels for the view of the texture. See the remarks in
    ///D3D11_TEX1D_SRV. Set to -1 to indicate all the mipmap levels from <b>MostDetailedMip</b> on down to least
    ///detailed.
    uint MipLevels;
    ///Type: <b>UINT</b> The index of the first texture to use in an array of textures.
    uint FirstArraySlice;
    ///Type: <b>UINT</b> Number of textures in the array.
    uint ArraySize;
}

///Specifies the subresource from a 2D texture to use in a shader-resource view.
struct D3D11_TEX2D_SRV
{
    ///Type: <b>UINT</b> Index of the most detailed mipmap level to use; this number is between 0 and <b>MipLevels</b>
    ///(from the original Texture2D for which ID3D11Device::CreateShaderResourceView creates a view) -1.
    uint MostDetailedMip;
    ///Type: <b>UINT</b> The maximum number of mipmap levels for the view of the texture. See the remarks in
    ///D3D11_TEX1D_SRV. Set to -1 to indicate all the mipmap levels from <b>MostDetailedMip</b> on down to least
    ///detailed.
    uint MipLevels;
}

///Specifies the subresources from an array of 2D textures to use in a shader-resource view.
struct D3D11_TEX2D_ARRAY_SRV
{
    ///Type: <b>UINT</b> Index of the most detailed mipmap level to use; this number is between 0 and <b>MipLevels</b>
    ///(from the original Texture2D for which ID3D11Device::CreateShaderResourceView creates a view) -1.
    uint MostDetailedMip;
    ///Type: <b>UINT</b> The maximum number of mipmap levels for the view of the texture. See the remarks in
    ///D3D11_TEX1D_SRV. Set to -1 to indicate all the mipmap levels from <b>MostDetailedMip</b> on down to least
    ///detailed.
    uint MipLevels;
    ///Type: <b>UINT</b> The index of the first texture to use in an array of textures.
    uint FirstArraySlice;
    ///Type: <b>UINT</b> Number of textures in the array.
    uint ArraySize;
}

///Specifies the subresources from a 3D texture to use in a shader-resource view.
struct D3D11_TEX3D_SRV
{
    ///Type: <b>UINT</b> Index of the most detailed mipmap level to use; this number is between 0 and <b>MipLevels</b>
    ///(from the original Texture3D for which ID3D11Device::CreateShaderResourceView creates a view) -1.
    uint MostDetailedMip;
    ///Type: <b>UINT</b> The maximum number of mipmap levels for the view of the texture. See the remarks in
    ///D3D11_TEX1D_SRV. Set to -1 to indicate all the mipmap levels from <b>MostDetailedMip</b> on down to least
    ///detailed.
    uint MipLevels;
}

///Specifies the subresource from a cube texture to use in a shader-resource view.
struct D3D11_TEXCUBE_SRV
{
    ///Type: <b>UINT</b> Index of the most detailed mipmap level to use; this number is between 0 and <b>MipLevels</b>
    ///(from the original TextureCube for which ID3D11Device::CreateShaderResourceView creates a view) -1.
    uint MostDetailedMip;
    ///Type: <b>UINT</b> The maximum number of mipmap levels for the view of the texture. See the remarks in
    ///D3D11_TEX1D_SRV. Set to -1 to indicate all the mipmap levels from <b>MostDetailedMip</b> on down to least
    ///detailed.
    uint MipLevels;
}

///Specifies the subresources from an array of cube textures to use in a shader-resource view.
struct D3D11_TEXCUBE_ARRAY_SRV
{
    ///Type: <b>UINT</b> Index of the most detailed mipmap level to use; this number is between 0 and <b>MipLevels</b>
    ///(from the original TextureCube for which ID3D11Device::CreateShaderResourceView creates a view) -1.
    uint MostDetailedMip;
    ///Type: <b>UINT</b> The maximum number of mipmap levels for the view of the texture. See the remarks in
    ///D3D11_TEX1D_SRV. Set to -1 to indicate all the mipmap levels from <b>MostDetailedMip</b> on down to least
    ///detailed.
    uint MipLevels;
    ///Type: <b>UINT</b> Index of the first 2D texture to use.
    uint First2DArrayFace;
    ///Type: <b>UINT</b> Number of cube textures in the array.
    uint NumCubes;
}

///Specifies the subresources from a multisampled 2D texture to use in a shader-resource view.
struct D3D11_TEX2DMS_SRV
{
    ///Type: <b>UINT</b> Integer of any value. See remarks.
    uint UnusedField_NothingToDefine;
}

///Specifies the subresources from an array of multisampled 2D textures to use in a shader-resource view.
struct D3D11_TEX2DMS_ARRAY_SRV
{
    ///Type: <b>UINT</b> The index of the first texture to use in an array of textures.
    uint FirstArraySlice;
    ///Type: <b>UINT</b> Number of textures to use.
    uint ArraySize;
}

///Describes a shader-resource view.
struct D3D11_SHADER_RESOURCE_VIEW_DESC
{
    ///Type: <b>DXGI_FORMAT</b> A DXGI_FORMAT specifying the viewing format. See remarks.
    DXGI_FORMAT       Format;
    ///Type: <b>D3D11_SRV_DIMENSION</b> The resource type of the view. See D3D11_SRV_DIMENSION. You must set
    ///*ViewDimension* to the same resource type as that of the underlying resource. This parameter also determines
    ///which _SRV to use in the union below.
    D3D_SRV_DIMENSION ViewDimension;
union
    {
        D3D11_BUFFER_SRV   Buffer;
        D3D11_TEX1D_SRV    Texture1D;
        D3D11_TEX1D_ARRAY_SRV Texture1DArray;
        D3D11_TEX2D_SRV    Texture2D;
        D3D11_TEX2D_ARRAY_SRV Texture2DArray;
        D3D11_TEX2DMS_SRV  Texture2DMS;
        D3D11_TEX2DMS_ARRAY_SRV Texture2DMSArray;
        D3D11_TEX3D_SRV    Texture3D;
        D3D11_TEXCUBE_SRV  TextureCube;
        D3D11_TEXCUBE_ARRAY_SRV TextureCubeArray;
        D3D11_BUFFEREX_SRV BufferEx;
    }
}

///Specifies the elements in a buffer resource to use in a render-target view.
struct D3D11_BUFFER_RTV
{
union
    {
        uint FirstElement;
        uint ElementOffset;
    }
union
    {
        uint NumElements;
        uint ElementWidth;
    }
}

///Specifies the subresource from a 1D texture to use in a render-target view.
struct D3D11_TEX1D_RTV
{
    ///Type: <b>UINT</b> The index of the mipmap level to use mip slice.
    uint MipSlice;
}

///Specifies the subresources from an array of 1D textures to use in a render-target view.
struct D3D11_TEX1D_ARRAY_RTV
{
    ///Type: <b>UINT</b> The index of the mipmap level to use mip slice.
    uint MipSlice;
    ///Type: <b>UINT</b> The index of the first texture to use in an array of textures.
    uint FirstArraySlice;
    ///Type: <b>UINT</b> Number of textures to use.
    uint ArraySize;
}

///Specifies the subresource from a 2D texture to use in a render-target view.
struct D3D11_TEX2D_RTV
{
    ///Type: <b>UINT</b> The index of the mipmap level to use mip slice.
    uint MipSlice;
}

///Specifies the subresource from a multisampled 2D texture to use in a render-target view.
struct D3D11_TEX2DMS_RTV
{
    ///Type: <b>UINT</b> Integer of any value. See remarks.
    uint UnusedField_NothingToDefine;
}

///Specifies the subresources from an array of 2D textures to use in a render-target view.
struct D3D11_TEX2D_ARRAY_RTV
{
    ///Type: <b>UINT</b> The index of the mipmap level to use mip slice.
    uint MipSlice;
    ///Type: <b>UINT</b> The index of the first texture to use in an array of textures.
    uint FirstArraySlice;
    ///Type: <b>UINT</b> Number of textures in the array to use in the render target view, starting from
    ///<b>FirstArraySlice</b>.
    uint ArraySize;
}

///Specifies the subresources from a an array of multisampled 2D textures to use in a render-target view.
struct D3D11_TEX2DMS_ARRAY_RTV
{
    ///Type: <b>UINT</b> The index of the first texture to use in an array of textures.
    uint FirstArraySlice;
    ///Type: <b>UINT</b> Number of textures to use.
    uint ArraySize;
}

///Specifies the subresources from a 3D texture to use in a render-target view.
struct D3D11_TEX3D_RTV
{
    ///Type: <b>UINT</b> The index of the mipmap level to use mip slice.
    uint MipSlice;
    ///Type: <b>UINT</b> First depth level to use.
    uint FirstWSlice;
    ///Type: <b>UINT</b> Number of depth levels to use in the render-target view, starting from <b>FirstWSlice</b>. A
    ///value of -1 indicates all of the slices along the w axis, starting from <b>FirstWSlice</b>.
    uint WSize;
}

///Specifies the subresources from a resource that are accessible using a render-target view.
struct D3D11_RENDER_TARGET_VIEW_DESC
{
    ///Type: <b>DXGI_FORMAT</b> The data format (see DXGI_FORMAT).
    DXGI_FORMAT         Format;
    ///Type: <b>D3D11_RTV_DIMENSION</b> The resource type (see D3D11_RTV_DIMENSION), which specifies how the
    ///render-target resource will be accessed.
    D3D11_RTV_DIMENSION ViewDimension;
union
    {
        D3D11_BUFFER_RTV  Buffer;
        D3D11_TEX1D_RTV   Texture1D;
        D3D11_TEX1D_ARRAY_RTV Texture1DArray;
        D3D11_TEX2D_RTV   Texture2D;
        D3D11_TEX2D_ARRAY_RTV Texture2DArray;
        D3D11_TEX2DMS_RTV Texture2DMS;
        D3D11_TEX2DMS_ARRAY_RTV Texture2DMSArray;
        D3D11_TEX3D_RTV   Texture3D;
    }
}

///Specifies the subresource from a 1D texture that is accessible to a depth-stencil view.
struct D3D11_TEX1D_DSV
{
    ///Type: <b>UINT</b> The index of the first mipmap level to use.
    uint MipSlice;
}

///Specifies the subresources from an array of 1D textures to use in a depth-stencil view.
struct D3D11_TEX1D_ARRAY_DSV
{
    ///Type: <b>UINT</b> The index of the first mipmap level to use.
    uint MipSlice;
    ///Type: <b>UINT</b> The index of the first texture to use in an array of textures.
    uint FirstArraySlice;
    ///Type: <b>UINT</b> Number of textures to use.
    uint ArraySize;
}

///Specifies the subresource from a 2D texture that is accessible to a depth-stencil view.
struct D3D11_TEX2D_DSV
{
    ///Type: <b>UINT</b> The index of the first mipmap level to use.
    uint MipSlice;
}

///Specifies the subresources from an array 2D textures that are accessible to a depth-stencil view.
struct D3D11_TEX2D_ARRAY_DSV
{
    ///Type: <b>UINT</b> The index of the first mipmap level to use.
    uint MipSlice;
    ///Type: <b>UINT</b> The index of the first texture to use in an array of textures.
    uint FirstArraySlice;
    ///Type: <b>UINT</b> Number of textures to use.
    uint ArraySize;
}

///Specifies the subresource from a multisampled 2D texture that is accessible to a depth-stencil view.
struct D3D11_TEX2DMS_DSV
{
    ///Type: <b>UINT</b> Unused.
    uint UnusedField_NothingToDefine;
}

///Specifies the subresources from an array of multisampled 2D textures for a depth-stencil view.
struct D3D11_TEX2DMS_ARRAY_DSV
{
    ///Type: <b>UINT</b> The index of the first texture to use in an array of textures.
    uint FirstArraySlice;
    ///Type: <b>UINT</b> Number of textures to use.
    uint ArraySize;
}

///Specifies the subresources of a texture that are accessible from a depth-stencil view.
struct D3D11_DEPTH_STENCIL_VIEW_DESC
{
    ///Type: <b>DXGI_FORMAT</b> Resource data format (see DXGI_FORMAT). See remarks for allowable formats.
    DXGI_FORMAT         Format;
    ///Type: <b>D3D11_DSV_DIMENSION</b> Type of resource (see D3D11_DSV_DIMENSION). Specifies how a depth-stencil
    ///resource will be accessed; the value is stored in the union in this structure.
    D3D11_DSV_DIMENSION ViewDimension;
    ///Type: <b>UINT</b> A value that describes whether the texture is read only. Pass 0 to specify that it is not read
    ///only; otherwise, pass one of the members of the D3D11_DSV_FLAG enumerated type.
    uint                Flags;
union
    {
        D3D11_TEX1D_DSV   Texture1D;
        D3D11_TEX1D_ARRAY_DSV Texture1DArray;
        D3D11_TEX2D_DSV   Texture2D;
        D3D11_TEX2D_ARRAY_DSV Texture2DArray;
        D3D11_TEX2DMS_DSV Texture2DMS;
        D3D11_TEX2DMS_ARRAY_DSV Texture2DMSArray;
    }
}

///Describes the elements in a buffer to use in a unordered-access view.
struct D3D11_BUFFER_UAV
{
    ///Type: <b>UINT</b> The zero-based index of the first element to be accessed.
    uint FirstElement;
    ///Type: <b>UINT</b> The number of elements in the resource. For structured buffers, this is the number of
    ///structures in the buffer.
    uint NumElements;
    ///Type: <b>UINT</b> View options for the resource (see D3D11_BUFFER_UAV_FLAG).
    uint Flags;
}

///Describes a unordered-access 1D texture resource.
struct D3D11_TEX1D_UAV
{
    ///Type: <b>UINT</b> The mipmap slice index.
    uint MipSlice;
}

///Describes an array of unordered-access 1D texture resources.
struct D3D11_TEX1D_ARRAY_UAV
{
    ///Type: <b>UINT</b> The mipmap slice index.
    uint MipSlice;
    ///Type: <b>UINT</b> The zero-based index of the first array slice to be accessed.
    uint FirstArraySlice;
    ///Type: <b>UINT</b> The number of slices in the array.
    uint ArraySize;
}

///Describes a unordered-access 2D texture resource.
struct D3D11_TEX2D_UAV
{
    ///Type: <b>UINT</b> The mipmap slice index.
    uint MipSlice;
}

///Describes an array of unordered-access 2D texture resources.
struct D3D11_TEX2D_ARRAY_UAV
{
    ///Type: <b>UINT</b> The mipmap slice index.
    uint MipSlice;
    ///Type: <b>UINT</b> The zero-based index of the first array slice to be accessed.
    uint FirstArraySlice;
    ///Type: <b>UINT</b> The number of slices in the array.
    uint ArraySize;
}

///Describes a unordered-access 3D texture resource.
struct D3D11_TEX3D_UAV
{
    ///Type: <b>UINT</b> The mipmap slice index.
    uint MipSlice;
    ///Type: <b>UINT</b> The zero-based index of the first depth slice to be accessed.
    uint FirstWSlice;
    ///Type: <b>UINT</b> The number of depth slices.
    uint WSize;
}

///Specifies the subresources from a resource that are accessible using an unordered-access view.
struct D3D11_UNORDERED_ACCESS_VIEW_DESC
{
    ///Type: <b>DXGI_FORMAT</b> The data format (see DXGI_FORMAT).
    DXGI_FORMAT         Format;
    ///Type: <b>D3D11_UAV_DIMENSION</b> The resource type (see D3D11_UAV_DIMENSION), which specifies how the resource
    ///will be accessed.
    D3D11_UAV_DIMENSION ViewDimension;
union
    {
        D3D11_BUFFER_UAV Buffer;
        D3D11_TEX1D_UAV  Texture1D;
        D3D11_TEX1D_ARRAY_UAV Texture1DArray;
        D3D11_TEX2D_UAV  Texture2D;
        D3D11_TEX2D_ARRAY_UAV Texture2DArray;
        D3D11_TEX3D_UAV  Texture3D;
    }
}

///Describes a sampler state.
struct D3D11_SAMPLER_DESC
{
    ///Type: <b>D3D11_FILTER</b> Filtering method to use when sampling a texture (see D3D11_FILTER).
    D3D11_FILTER Filter;
    ///Type: <b>D3D11_TEXTURE_ADDRESS_MODE</b> Method to use for resolving a u texture coordinate that is outside the 0
    ///to 1 range (see D3D11_TEXTURE_ADDRESS_MODE).
    D3D11_TEXTURE_ADDRESS_MODE AddressU;
    ///Type: <b>D3D11_TEXTURE_ADDRESS_MODE</b> Method to use for resolving a v texture coordinate that is outside the 0
    ///to 1 range.
    D3D11_TEXTURE_ADDRESS_MODE AddressV;
    ///Type: <b>D3D11_TEXTURE_ADDRESS_MODE</b> Method to use for resolving a w texture coordinate that is outside the 0
    ///to 1 range.
    D3D11_TEXTURE_ADDRESS_MODE AddressW;
    ///Type: <b>FLOAT</b> Offset from the calculated mipmap level. For example, if Direct3D calculates that a texture
    ///should be sampled at mipmap level 3 and MipLODBias is 2, then the texture will be sampled at mipmap level 5.
    float        MipLODBias;
    ///Type: <b>UINT</b> Clamping value used if D3D11_FILTER_ANISOTROPIC or D3D11_FILTER_COMPARISON_ANISOTROPIC is
    ///specified in Filter. Valid values are between 1 and 16.
    uint         MaxAnisotropy;
    ///Type: <b>D3D11_COMPARISON_FUNC</b> A function that compares sampled data against existing sampled data. The
    ///function options are listed in D3D11_COMPARISON_FUNC.
    D3D11_COMPARISON_FUNC ComparisonFunc;
    ///Type: <b>FLOAT[4]</b> Border color to use if D3D11_TEXTURE_ADDRESS_BORDER is specified for AddressU, AddressV, or
    ///AddressW. Range must be between 0.0 and 1.0 inclusive.
    float[4]     BorderColor;
    ///Type: <b>FLOAT</b> Lower end of the mipmap range to clamp access to, where 0 is the largest and most detailed
    ///mipmap level and any level higher than that is less detailed.
    float        MinLOD;
    ///Type: <b>FLOAT</b> Upper end of the mipmap range to clamp access to, where 0 is the largest and most detailed
    ///mipmap level and any level higher than that is less detailed. This value must be greater than or equal to MinLOD.
    ///To have no upper limit on LOD set this to a large value such as D3D11_FLOAT32_MAX.
    float        MaxLOD;
}

///Describes a query.
struct D3D11_QUERY_DESC
{
    ///Type: <b>D3D11_QUERY</b> Type of query (see D3D11_QUERY).
    D3D11_QUERY Query;
    ///Type: <b>UINT</b> Miscellaneous flags (see D3D11_QUERY_MISC_FLAG).
    uint        MiscFlags;
}

///Query information about the reliability of a timestamp query.
struct D3D11_QUERY_DATA_TIMESTAMP_DISJOINT
{
    ///Type: <b>UINT64</b> How frequently the GPU counter increments in Hz.
    ulong Frequency;
    ///Type: <b>BOOL</b> If this is <b>TRUE</b>, something occurred in between the query's ID3D11DeviceContext::Begin
    ///and ID3D11DeviceContext::End calls that caused the timestamp counter to become discontinuous or disjoint, such as
    ///unplugging the AC cord on a laptop, overheating, or throttling up/down due to laptop savings events. The
    ///timestamp returned by ID3D11DeviceContext::GetData for a timestamp query is only reliable if <b>Disjoint</b> is
    ///<b>FALSE</b>.
    BOOL  Disjoint;
}

///Query information about graphics-pipeline activity in between calls to ID3D11DeviceContext::Begin and
///ID3D11DeviceContext::End.
struct D3D11_QUERY_DATA_PIPELINE_STATISTICS
{
    ///Type: <b>UINT64</b> Number of vertices read by input assembler.
    ulong IAVertices;
    ///Type: <b>UINT64</b> Number of primitives read by the input assembler. This number can be different depending on
    ///the primitive topology used. For example, a triangle strip with 6 vertices will produce 4 triangles, however a
    ///triangle list with 6 vertices will produce 2 triangles.
    ulong IAPrimitives;
    ///Type: <b>UINT64</b> Number of times a vertex shader was invoked. Direct3D invokes the vertex shader once per
    ///vertex.
    ulong VSInvocations;
    ///Type: <b>UINT64</b> Number of times a geometry shader was invoked. When the geometry shader is set to
    ///<b>NULL</b>, this statistic may or may not increment depending on the hardware manufacturer.
    ulong GSInvocations;
    ///Type: <b>UINT64</b> Number of primitives output by a geometry shader.
    ulong GSPrimitives;
    ///Type: <b>UINT64</b> Number of primitives that were sent to the rasterizer. When the rasterizer is disabled, this
    ///will not increment.
    ulong CInvocations;
    ///Type: <b>UINT64</b> Number of primitives that were rendered. This may be larger or smaller than CInvocations
    ///because after a primitive is clipped sometimes it is either broken up into more than one primitive or completely
    ///culled.
    ulong CPrimitives;
    ///Type: <b>UINT64</b> Number of times a pixel shader was invoked.
    ulong PSInvocations;
    ///Type: <b>UINT64</b> Number of times a hull shader was invoked.
    ulong HSInvocations;
    ///Type: <b>UINT64</b> Number of times a domain shader was invoked.
    ulong DSInvocations;
    ///Type: <b>UINT64</b> Number of times a compute shader was invoked.
    ulong CSInvocations;
}

///Query information about the amount of data streamed out to the stream-output buffers in between
///ID3D11DeviceContext::Begin and ID3D11DeviceContext::End.
struct D3D11_QUERY_DATA_SO_STATISTICS
{
    ///Type: <b>UINT64</b> Number of primitives (that is, points, lines, and triangles) written to the stream-output
    ///buffers.
    ulong NumPrimitivesWritten;
    ///Type: <b>UINT64</b> Number of primitives that would have been written to the stream-output buffers if there had
    ///been enough space for them all.
    ulong PrimitivesStorageNeeded;
}

///Describes a counter.
struct D3D11_COUNTER_DESC
{
    ///Type: <b>D3D11_COUNTER</b> Type of counter (see D3D11_COUNTER).
    D3D11_COUNTER Counter;
    ///Type: <b>UINT</b> Reserved.
    uint          MiscFlags;
}

///Information about the video card's performance counter capabilities.
struct D3D11_COUNTER_INFO
{
    ///Type: <b>D3D11_COUNTER</b> Largest device-dependent counter ID that the device supports. If none are supported,
    ///this value will be 0. Otherwise it will be greater than or equal to D3D11_COUNTER_DEVICE_DEPENDENT_0. See
    ///D3D11_COUNTER.
    D3D11_COUNTER LastDeviceDependentCounter;
    ///Type: <b>UINT</b> Number of counters that can be simultaneously supported.
    uint          NumSimultaneousCounters;
    ///Type: <b>UINT8</b> Number of detectable parallel units that the counter is able to discern. Values are 1 ~ 4. Use
    ///NumDetectableParallelUnits to interpret the values of the VERTEX_PROCESSING, GEOMETRY_PROCESSING,
    ///PIXEL_PROCESSING, and OTHER_GPU_PROCESSING counters.
    ubyte         NumDetectableParallelUnits;
}

///Describes an HLSL class instance.
struct D3D11_CLASS_INSTANCE_DESC
{
    ///Type: <b>UINT</b> The instance ID of an HLSL class; the default value is 0.
    uint InstanceId;
    ///Type: <b>UINT</b> The instance index of an HLSL class; the default value is 0.
    uint InstanceIndex;
    ///Type: <b>UINT</b> The type ID of an HLSL class; the default value is 0.
    uint TypeId;
    ///Type: <b>UINT</b> Describes the constant buffer associated with an HLSL class; the default value is 0.
    uint ConstantBuffer;
    ///Type: <b>UINT</b> The base constant buffer offset associated with an HLSL class; the default value is 0.
    uint BaseConstantBufferOffset;
    ///Type: <b>UINT</b> The base texture associated with an HLSL class; the default value is 127.
    uint BaseTexture;
    ///Type: <b>UINT</b> The base sampler associated with an HLSL class; the default value is 15.
    uint BaseSampler;
    ///Type: <b>BOOL</b> True if the class was created; the default value is false.
    BOOL Created;
}

///Describes the multi-threading features that are supported by the current graphics driver.
struct D3D11_FEATURE_DATA_THREADING
{
    ///Type: <b>BOOL</b> <b>TRUE</b> means resources can be created concurrently on multiple threads while drawing;
    ///<b>FALSE</b> means that the presence of coarse synchronization will prevent concurrency.
    BOOL DriverConcurrentCreates;
    ///Type: <b>BOOL</b> <b>TRUE</b> means command lists are supported by the current driver; <b>FALSE</b> means that
    ///the API will emulate deferred contexts and command lists with software.
    BOOL DriverCommandLists;
}

///Describes double data type support in the current graphics driver.
struct D3D11_FEATURE_DATA_DOUBLES
{
    ///Type: <b>BOOL</b> Specifies whether double types are allowed. If <b>TRUE</b>, double types are allowed; otherwise
    ///<b>FALSE</b>. The runtime must set <b>DoublePrecisionFloatShaderOps</b> to <b>TRUE</b> in order for you to use
    ///any HLSL shader that is compiled with a double type.
    BOOL DoublePrecisionFloatShaderOps;
}

///Describes which resources are supported by the current graphics driver for a given format.
struct D3D11_FEATURE_DATA_FORMAT_SUPPORT
{
    ///Type: <b>DXGI_FORMAT</b> DXGI_FORMAT to return information on.
    DXGI_FORMAT InFormat;
    ///Type: <b>UINT</b> Combination of D3D11_FORMAT_SUPPORT flags indicating which resources are supported.
    uint        OutFormatSupport;
}

///Describes which unordered resource options are supported by the current graphics driver for a given format.
struct D3D11_FEATURE_DATA_FORMAT_SUPPORT2
{
    ///Type: <b>DXGI_FORMAT</b> DXGI_FORMAT to return information on.
    DXGI_FORMAT InFormat;
    ///Type: <b>UINT</b> Combination of D3D11_FORMAT_SUPPORT2 flags indicating which unordered resource options are
    ///supported.
    uint        OutFormatSupport2;
}

///Describes compute shader and raw and structured buffer support in the current graphics driver.
struct D3D11_FEATURE_DATA_D3D10_X_HARDWARE_OPTIONS
{
    ///Type: <b>BOOL</b> <b>TRUE</b> if compute shaders and raw and structured buffers are supported; otherwise
    ///<b>FALSE</b>.
    BOOL ComputeShaders_Plus_RawAndStructuredBuffers_Via_Shader_4_x;
}

///Describes Direct3D 11.1 feature options in the current graphics driver. > [!NOTE] > This structure is supported by
///the Direct3D 11.1 runtime, which is available on Windows 8 and later operating systems.
struct D3D11_FEATURE_DATA_D3D11_OPTIONS
{
    ///Specifies whether logic operations are available in blend state. The runtime sets this member to <b>TRUE</b> if
    ///logic operations are available in blend state and <b>FALSE</b> otherwise. This member is <b>FALSE</b> for feature
    ///level 9.1, 9.2, and 9.3. This member is optional for feature level 10, 10.1, and 11. This member is <b>TRUE</b>
    ///for feature level 11.1.
    BOOL OutputMergerLogicOp;
    ///Specifies whether the driver can render with no render target views (RTVs) or depth stencil views (DSVs), and
    ///only unordered access views (UAVs) bound. The runtime sets this member to <b>TRUE</b> if the driver can render
    ///with no RTVs or DSVs and only UAVs bound and <b>FALSE</b> otherwise. If <b>TRUE</b>, you can set the
    ///<b>ForcedSampleCount</b> member of D3D11_RASTERIZER_DESC1 to 1, 4, or 8 when you render with no RTVs or DSV and
    ///only UAVs bound. For feature level 11.1, this member is always <b>TRUE</b> and you can also set
    ///<b>ForcedSampleCount</b> to 16 in addition to 1, 4, or 8. The default value of <b>ForcedSampleCount</b> is 0,
    ///which means the same as if the value is set to 1. You can always set <b>ForcedSampleCount</b> to 0 or 1 for
    ///UAV-only rendering independently of how this member is set.
    BOOL UAVOnlyRenderingForcedSampleCount;
    ///Specifies whether the driver supports the ID3D11DeviceContext1::DiscardView and
    ///ID3D11DeviceContext1::DiscardResource methods. The runtime sets this member to <b>TRUE</b> if the driver supports
    ///these methods and <b>FALSE</b> otherwise. How this member is set does not indicate whether the driver actually
    ///uses these methods; that is, the driver might ignore these methods if they are not useful to the hardware. If
    ///<b>FALSE</b>, the runtime does not expose these methods to the driver because the driver does not support them.
    ///You can monitor this member during development to rule out legacy drivers on hardware where these methods might
    ///have otherwise been beneficial. You are not required to write separate code paths based on whether this member is
    ///<b>TRUE</b> or <b>FALSE</b>; you can call these methods whenever applicable.
    BOOL DiscardAPIsSeenByDriver;
    ///Specifies whether the driver supports new semantics for copy and update that are exposed by the
    ///ID3D11DeviceContext1::CopySubresourceRegion1 and ID3D11DeviceContext1::UpdateSubresource1 methods. The runtime
    ///sets this member to <b>TRUE</b> if the driver supports new semantics for copy and update. The runtime sets this
    ///member to <b>FALSE</b> only for legacy drivers. The runtime handles this member similarly to the
    ///<b>DiscardAPIsSeenByDriver</b> member.
    BOOL FlagsForUpdateAndCopySeenByDriver;
    ///Specifies whether the driver supports the ID3D11DeviceContext1::ClearView method. The runtime sets this member to
    ///<b>TRUE</b> if the driver supports this method and <b>FALSE</b> otherwise. If <b>FALSE</b>, the runtime does not
    ///expose this method to the driver because the driver does not support it. <div class="alert"><b>Note</b> For
    ///feature level 9.1, 9.2, and 9.3, this member is always <b>TRUE</b> because the option is emulated by the
    ///runtime.</div> <div> </div>
    BOOL ClearView;
    ///Specifies whether you can call ID3D11DeviceContext1::CopySubresourceRegion1 with overlapping source and
    ///destination rectangles. The runtime sets this member to <b>TRUE</b> if you can call <b>CopySubresourceRegion1</b>
    ///with overlapping source and destination rectangles and <b>FALSE</b> otherwise. If <b>FALSE</b>, the runtime does
    ///not expose this method to the driver because the driver does not support it. <div class="alert"><b>Note</b> For
    ///feature level 9.1, 9.2, and 9.3, this member is always <b>TRUE</b> because drivers already support the option for
    ///these feature levels.</div> <div> </div>
    BOOL CopyWithOverlap;
    ///Specifies whether the driver supports partial updates of constant buffers. The runtime sets this member to
    ///<b>TRUE</b> if the driver supports partial updates of constant buffers and <b>FALSE</b> otherwise. If
    ///<b>FALSE</b>, the runtime does not expose this operation to the driver because the driver does not support it.
    ///<div class="alert"><b>Note</b> For feature level 9.1, 9.2, and 9.3, this member is always <b>TRUE</b> because the
    ///option is emulated by the runtime.</div> <div> </div>
    BOOL ConstantBufferPartialUpdate;
    ///Specifies whether the driver supports new semantics for setting offsets in constant buffers for a shader. The
    ///runtime sets this member to <b>TRUE</b> if the driver supports allowing you to specify offsets when you call new
    ///methods like the ID3D11DeviceContext1::VSSetConstantBuffers1 method and <b>FALSE</b> otherwise. If <b>FALSE</b>,
    ///the runtime does not expose this operation to the driver because the driver does not support it. <div
    ///class="alert"><b>Note</b> For feature level 9.1, 9.2, and 9.3, this member is always <b>TRUE</b> because the
    ///option is emulated by the runtime.</div> <div> </div>
    BOOL ConstantBufferOffsetting;
    ///Specifies whether you can call ID3D11DeviceContext::Map with D3D11_MAP_WRITE_NO_OVERWRITE on a dynamic constant
    ///buffer (that is, whether the driver supports this operation). The runtime sets this member to <b>TRUE</b> if the
    ///driver supports this operation and <b>FALSE</b> otherwise. If <b>FALSE</b>, the runtime fails this method because
    ///the driver does not support the operation. <div class="alert"><b>Note</b> For feature level 9.1, 9.2, and 9.3,
    ///this member is always <b>TRUE</b> because the option is emulated by the runtime.</div> <div> </div>
    BOOL MapNoOverwriteOnDynamicConstantBuffer;
    ///Specifies whether you can call ID3D11DeviceContext::Map with D3D11_MAP_WRITE_NO_OVERWRITE on a dynamic buffer SRV
    ///(that is, whether the driver supports this operation). The runtime sets this member to <b>TRUE</b> if the driver
    ///supports this operation and <b>FALSE</b> otherwise. If <b>FALSE</b>, the runtime fails this method because the
    ///driver does not support the operation.
    BOOL MapNoOverwriteOnDynamicBufferSRV;
    ///Specifies whether the driver supports multisample rendering when you render with RTVs bound. If <b>TRUE</b>, you
    ///can set the <b>ForcedSampleCount</b> member of D3D11_RASTERIZER_DESC1 to 1 with a multisample RTV bound. The
    ///driver can support this option on feature level 10 and higher. If <b>FALSE</b>, the rasterizer-state creation
    ///will fail because the driver is legacy or the feature level is too low.
    BOOL MultisampleRTVWithForcedSampleCountOne;
    ///Specifies whether the hardware and driver support the msad4 intrinsic function in shaders. The runtime sets this
    ///member to <b>TRUE</b> if the hardware and driver support calls to <b>msad4</b> intrinsic functions in shaders. If
    ///<b>FALSE</b>, the driver is legacy or the hardware does not support the option; the runtime will fail shader
    ///creation for shaders that use <b>msad4</b>.
    BOOL SAD4ShaderInstructions;
    ///Specifies whether the hardware and driver support the fma intrinsic function and other extended doubles
    ///instructions (<b>DDIV</b> and <b>DRCP</b>) in shaders. The <b>fma</b> intrinsic function emits an extended
    ///doubles <b>DFMA</b> instruction. The runtime sets this member to <b>TRUE</b> if the hardware and driver support
    ///extended doubles instructions in shaders (shader model 5 and higher). Support of this option implies support of
    ///basic double-precision shader instructions as well. You can use the D3D11_FEATURE_DOUBLES value to query for
    ///support of double-precision shaders. If <b>FALSE</b>, the hardware and driver do not support the option; the
    ///runtime will fail shader creation for shaders that use extended doubles instructions.
    BOOL ExtendedDoublesShaderInstructions;
    ///Specifies whether the hardware and driver have [extended support for shared Texture2D resource types and
    ///formats](/windows/win32/direct3d11/direct3d-11-1-features
    BOOL ExtendedResourceSharing;
}

///<div class="alert"><b>Note</b> This structure is supported by the Direct3D 11.1 runtime, which is available on
///Windows 8 and later operating systems.</div><div> </div>Describes information about Direct3D 11.1 adapter
///architecture.
struct D3D11_FEATURE_DATA_ARCHITECTURE_INFO
{
    ///Specifies whether a rendering device batches rendering commands and performs multipass rendering into tiles or
    ///bins over a render area. Certain API usage patterns that are fine for TileBasedDefferredRenderers (TBDRs) can
    ///perform worse on non-TBDRs and vice versa. Applications that are careful about rendering can be friendly to both
    ///TBDR and non-TBDR architectures. <b>TRUE</b> if the rendering device batches rendering commands and <b>FALSE</b>
    ///otherwise.
    BOOL TileBasedDeferredRenderer;
}

///<div class="alert"><b>Note</b> This structure is supported by the Direct3D 11.1 runtime, which is available on
///Windows 8 and later operating systems.</div><div> </div>Describes Direct3D 9 feature options in the current graphics
///driver.
struct D3D11_FEATURE_DATA_D3D9_OPTIONS
{
    ///Specifies whether the driver supports the nonpowers-of-2-unconditionally feature. For more information about this
    ///feature, see feature level. The runtime sets this member to <b>TRUE</b> for hardware at Direct3D 10 and higher
    ///feature levels. For hardware at Direct3D 9.3 and lower feature levels, the runtime sets this member to
    ///<b>FALSE</b> if the hardware and driver support the powers-of-2 (2D textures must have widths and heights
    ///specified as powers of two) feature or the nonpowers-of-2-conditionally feature. For more information about this
    ///feature, see feature level.
    BOOL FullNonPow2TextureSupport;
}

///<div class="alert"><b>Note</b> This structure is supported by the Direct3D 11.1 runtime, which is available on
///Windows 8 and later operating systems.</div><div> </div>Describes Direct3D 9 shadow support in the current graphics
///driver.
struct D3D11_FEATURE_DATA_D3D9_SHADOW_SUPPORT
{
    ///Specifies whether the driver supports the shadowing feature with the comparison-filtering mode set to less than
    ///or equal to. The runtime sets this member to <b>TRUE</b> for hardware at Direct3D 10 and higher feature levels.
    ///For hardware at Direct3D 9.3 and lower feature levels, the runtime sets this member to <b>TRUE</b> only if the
    ///hardware and driver support the shadowing feature; otherwise <b>FALSE</b>.
    BOOL SupportsDepthAsTextureWithLessEqualComparisonFilter;
}

///<div class="alert"><b>Note</b> This structure is supported by the Direct3D 11.1 runtime, which is available on
///Windows 8 and later operating systems.</div><div> </div>Describes precision support options for shaders in the
///current graphics driver.
struct D3D11_FEATURE_DATA_SHADER_MIN_PRECISION_SUPPORT
{
    ///A combination of D3D11_SHADER_MIN_PRECISION_SUPPORT-typed values that are combined by using a bitwise OR
    ///operation. The resulting value specifies minimum precision levels that the driver supports for the pixel shader.
    ///A value of zero indicates that the driver supports only full 32-bit precision for the pixel shader.
    uint PixelShaderMinPrecision;
    ///A combination of D3D11_SHADER_MIN_PRECISION_SUPPORT-typed values that are combined by using a bitwise OR
    ///operation. The resulting value specifies minimum precision levels that the driver supports for all other shader
    ///stages. A value of zero indicates that the driver supports only full 32-bit precision for all other shader
    ///stages.
    uint AllOtherShaderStagesMinPrecision;
}

///> [!NOTE] > This structure is supported by the Direct3D 11.2 runtime, which is available on Windows 8.1 and later
///operating systems. Describes Direct3D 11.2 feature options in the current graphics driver.
struct D3D11_FEATURE_DATA_D3D11_OPTIONS1
{
    ///Type: <b>D3D11_TILED_RESOURCES_TIER</b> Specifies whether the hardware and driver support tiled resources. The
    ///runtime sets this member to a D3D11_TILED_RESOURCES_TIER-typed value that indicates if the hardware and driver
    ///support tiled resources and at what tier level.
    D3D11_TILED_RESOURCES_TIER TiledResourcesTier;
    ///Type: <b>BOOL</b> Specifies whether the hardware and driver support the filtering options (D3D11_FILTER) of
    ///comparing the result to the minimum or maximum value during texture sampling. The runtime sets this member to
    ///<b>TRUE</b> if the hardware and driver support these filtering options.
    BOOL MinMaxFiltering;
    ///Type: <b>BOOL</b> Specifies whether the hardware and driver also support the ID3D11DeviceContext1::ClearView
    ///method on depth formats. For info about valid depth formats, see D3D11_DEPTH_STENCIL_VIEW_DESC.
    BOOL ClearViewAlsoSupportsDepthOnlyFormats;
    ///Type: <b>BOOL</b> Specifies support for creating ID3D11Buffer resources that can be passed to the
    ///ID3D11DeviceContext::Map and ID3D11DeviceContext::Unmap methods. This means that the <b>CPUAccessFlags</b> member
    ///of the D3D11_BUFFER_DESC structure may be set with the desired D3D11_CPU_ACCESS_FLAG elements when the
    ///<b>Usage</b> member of <b>D3D11_BUFFER_DESC</b> is set to <b>D3D11_USAGE_DEFAULT</b>. The runtime sets this
    ///member to <b>TRUE</b> if the hardware is capable of at least <b>D3D_FEATURE_LEVEL_11_0</b> and the graphics
    ///device driver supports mappable default buffers.
    BOOL MapOnDefaultBuffers;
}

///<div class="alert"><b>Note</b> This structure is supported by the Direct3D 11.2 runtime, which is available on
///Windows 8.1 and later operating systems. </div><div> </div>Describes whether simple instancing is supported.
struct D3D11_FEATURE_DATA_D3D9_SIMPLE_INSTANCING_SUPPORT
{
    ///Specifies whether the hardware and driver support simple instancing. The runtime sets this member to <b>TRUE</b>
    ///if the hardware and driver support simple instancing.
    BOOL SimpleInstancingSupported;
}

///<div class="alert"><b>Note</b> This structure is supported by the Direct3D 11.2 runtime, which is available on
///Windows 8.1 and later operating systems.</div><div> </div>Describes whether a GPU profiling technique is supported.
struct D3D11_FEATURE_DATA_MARKER_SUPPORT
{
    ///Specifies whether the hardware and driver support a GPU profiling technique that can be used with development
    ///tools. The runtime sets this member to <b>TRUE</b> if the hardware and driver support data marking.
    BOOL Profile;
}

///<div class="alert"><b>Note</b> This structure is supported by the Direct3D 11.2 runtime, which is available on
///Windows 8.1 and later operating systems.</div><div> </div>Describes Direct3D 9 feature options in the current
///graphics driver.
struct D3D11_FEATURE_DATA_D3D9_OPTIONS1
{
    ///Specifies whether the driver supports the nonpowers-of-2-unconditionally feature. For more info about this
    ///feature, see feature level. The runtime sets this member to <b>TRUE</b> for hardware at Direct3D 10 and higher
    ///feature levels. For hardware at Direct3D 9.3 and lower feature levels, the runtime sets this member to
    ///<b>FALSE</b> if the hardware and driver support the powers-of-2 (2D textures must have widths and heights
    ///specified as powers of two) feature or the nonpowers-of-2-conditionally feature.
    BOOL FullNonPow2TextureSupported;
    ///Specifies whether the driver supports the shadowing feature with the comparison-filtering mode set to less than
    ///or equal to. The runtime sets this member to <b>TRUE</b> for hardware at Direct3D 10 and higher feature levels.
    ///For hardware at Direct3D 9.3 and lower feature levels, the runtime sets this member to <b>TRUE</b> only if the
    ///hardware and driver support the shadowing feature; otherwise <b>FALSE</b>.
    BOOL DepthAsTextureWithLessEqualComparisonFilterSupported;
    ///Specifies whether the hardware and driver support simple instancing. The runtime sets this member to <b>TRUE</b>
    ///if the hardware and driver support simple instancing.
    BOOL SimpleInstancingSupported;
    ///Specifies whether the hardware and driver support setting a single face of a TextureCube as a render target while
    ///the depth stencil surface that is bound alongside can be a Texture2D (as opposed to <b>TextureCube</b>). The
    ///runtime sets this member to <b>TRUE</b> if the hardware and driver support this feature; otherwise <b>FALSE</b>.
    ///If the hardware and driver don't support this feature, the app must match the render target surface type with the
    ///depth stencil surface type. Because hardware at Direct3D 9.3 and lower feature levels doesn't allow TextureCube
    ///depth surfaces, the only way to render a scene into a <b>TextureCube</b> while having depth buffering enabled is
    ///to render each <b>TextureCube</b> face separately to a Texture2D render target first (because that can be matched
    ///with a <b>Texture2D</b> depth), and then copy the results into the <b>TextureCube</b>. If the hardware and driver
    ///support this feature, the app can just render to the <b>TextureCube</b> faces directly while getting depth
    ///buffering out of a <b>Texture2D</b> depth buffer. You only need to query this feature from hardware at Direct3D
    ///9.3 and lower feature levels because hardware at Direct3D 10.0 and higher feature levels allow TextureCube depth
    ///surfaces.
    BOOL TextureCubeFaceRenderTargetWithNonCubeDepthStencilSupported;
}

///Describes Direct3D 11.3 feature options in the current graphics driver.
struct D3D11_FEATURE_DATA_D3D11_OPTIONS2
{
    ///Specifies whether the hardware and driver support <b>PSSpecifiedStencilRef</b>. The runtime sets this member to
    ///<b>TRUE</b> if the hardware and driver support this option.
    BOOL PSSpecifiedStencilRefSupported;
    ///Specifies whether the hardware and driver support <b>TypedUAVLoadAdditionalFormats</b>. The runtime sets this
    ///member to <b>TRUE</b> if the hardware and driver support this option.
    BOOL TypedUAVLoadAdditionalFormats;
    ///Specifies whether the hardware and driver support ROVs. The runtime sets this member to <b>TRUE</b> if the
    ///hardware and driver support this option.
    BOOL ROVsSupported;
    ///Specifies whether the hardware and driver support conservative rasterization. The runtime sets this member to a
    ///D3D11_CONSERVATIVE_RASTERIZATION_TIER-typed value that indicates if the hardware and driver support conservative
    ///rasterization and at what tier level.
    D3D11_CONSERVATIVE_RASTERIZATION_TIER ConservativeRasterizationTier;
    ///Specifies whether the hardware and driver support tiled resources. The runtime sets this member to a
    ///D3D11_TILED_RESOURCES_TIER-typed value that indicates if the hardware and driver support tiled resources and at
    ///what tier level.
    D3D11_TILED_RESOURCES_TIER TiledResourcesTier;
    ///Specifies whether the hardware and driver support mapping on default textures. The runtime sets this member to
    ///<b>TRUE</b> if the hardware and driver support this option.
    BOOL MapOnDefaultTextures;
    ///Specifies whether the hardware and driver support standard swizzle. The runtime sets this member to <b>TRUE</b>
    ///if the hardware and driver support this option.
    BOOL StandardSwizzle;
    ///Specifies whether the hardware and driver support Unified Memory Architecture. The runtime sets this member to
    ///<b>TRUE</b> if the hardware and driver support this option.
    BOOL UnifiedMemoryArchitecture;
}

///Describes Direct3D 11.3 feature options in the current graphics driver.
struct D3D11_FEATURE_DATA_D3D11_OPTIONS3
{
    ///Whether to use the VP and RT array index from any shader feeding the rasterizer.
    BOOL VPAndRTArrayIndexFromAnyShaderFeedingRasterizer;
}

///Describes feature data GPU virtual address support, including maximum address bits per resource and per process.
struct D3D11_FEATURE_DATA_GPU_VIRTUAL_ADDRESS_SUPPORT
{
    ///The maximum GPU virtual address bits per resource.
    uint MaxGPUVirtualAddressBitsPerResource;
    ///The maximum GPU virtual address bits per process.
    uint MaxGPUVirtualAddressBitsPerProcess;
}

///Describes the level of shader caching supported in the current graphics driver.
struct D3D11_FEATURE_DATA_SHADER_CACHE
{
    ///Indicates the level of caching supported.
    uint SupportFlags;
}

///Describes the level of support for shared resources in the current graphics driver.
struct D3D11_FEATURE_DATA_D3D11_OPTIONS5
{
    ///Type: **[D3D11_SHARED_RESOURCE_TIER](./ne-d3d11-d3d11_shared_resource_tier.md)** A shared resource support tier.
    D3D11_SHARED_RESOURCE_TIER SharedResourceTier;
}

struct CD3D11_VIDEO_DEFAULT
{
}

///Specifies the protection level for video content.
union D3D11_AUTHENTICATED_PROTECTION_FLAGS
{
struct Flags
    {
        uint _bitfield12;
    }
    ///Use this member to access all of the bits in the union.
    uint Value;
}

///A debug message in the Information Queue.
struct D3D11_MESSAGE
{
    ///Type: <b>D3D11_MESSAGE_CATEGORY</b> The category of the message. See D3D11_MESSAGE_CATEGORY.
    D3D11_MESSAGE_CATEGORY Category;
    ///Type: <b>D3D11_MESSAGE_SEVERITY</b> The severity of the message. See D3D11_MESSAGE_SEVERITY.
    D3D11_MESSAGE_SEVERITY Severity;
    ///Type: <b>D3D11_MESSAGE_ID</b> The ID of the message. See D3D11_MESSAGE_ID.
    D3D11_MESSAGE_ID ID;
    ///Type: <b>const char*</b> The message string.
    const(ubyte)*    pDescription;
    ///Type: <b>SIZE_T</b> The length of pDescription in bytes.
    size_t           DescriptionByteLength;
}

///Allow or deny certain types of messages to pass through a filter.
struct D3D11_INFO_QUEUE_FILTER_DESC
{
    ///Type: <b>UINT</b> Number of message categories to allow or deny.
    uint              NumCategories;
    ///Type: <b>D3D11_MESSAGE_CATEGORY*</b> Array of message categories to allow or deny. Array must have at least
    ///NumCategories members (see D3D11_MESSAGE_CATEGORY).
    D3D11_MESSAGE_CATEGORY* pCategoryList;
    ///Type: <b>UINT</b> Number of message severity levels to allow or deny.
    uint              NumSeverities;
    ///Type: <b>D3D11_MESSAGE_SEVERITY*</b> Array of message severity levels to allow or deny. Array must have at least
    ///NumSeverities members (see D3D11_MESSAGE_SEVERITY).
    D3D11_MESSAGE_SEVERITY* pSeverityList;
    ///Type: <b>UINT</b> Number of message IDs to allow or deny.
    uint              NumIDs;
    ///Type: <b>D3D11_MESSAGE_ID*</b> Array of message IDs to allow or deny. Array must have at least NumIDs members
    ///(see D3D11_MESSAGE_ID).
    D3D11_MESSAGE_ID* pIDList;
}

///Debug message filter; contains a lists of message types to allow or deny.
struct D3D11_INFO_QUEUE_FILTER
{
    ///Type: <b>D3D11_INFO_QUEUE_FILTER_DESC</b> Types of messages that you want to allow. See
    ///D3D11_INFO_QUEUE_FILTER_DESC.
    D3D11_INFO_QUEUE_FILTER_DESC AllowList;
    ///Type: <b>D3D11_INFO_QUEUE_FILTER_DESC</b> Types of messages that you want to deny.
    D3D11_INFO_QUEUE_FILTER_DESC DenyList;
}

///Describes the blend state for a render target. > [!NOTE] > This structure is supported by the Direct3D 11.1 runtime,
///which is available on Windows 8 and later operating systems.
struct D3D11_RENDER_TARGET_BLEND_DESC1
{
    ///Type: <b>BOOL</b> Enable (or disable) blending. > [!NOTE] > It's not valid for *LogicOpEnable* and *BlendEnable*
    ///to both be **TRUE**.
    BOOL           BlendEnable;
    ///Type: <b>BOOL</b> Enable (or disable) a logical operation. > [!NOTE] > If you set *LogicOpEnable* to **TRUE**,
    ///then *BlendEnable* must be **FALSE**, and the system's
    ///[**D3D11_FEATURE_DATA_D3D11_OPTIONS::OutputMergerLogicOp**](../d3d11/ns-d3d11-d3d11_feature_data_d3d11_options.md)
    ///option must be **TRUE**.
    BOOL           LogicOpEnable;
    ///Type: <b>D3D11_BLEND</b> This blend option specifies the operation to perform on the RGB value that the pixel
    ///shader outputs. The <b>BlendOp</b> member defines how to combine the <b>SrcBlend</b> and <b>DestBlend</b>
    ///operations.
    D3D11_BLEND    SrcBlend;
    ///Type: <b>D3D11_BLEND</b> This blend option specifies the operation to perform on the current RGB value in the
    ///render target. The <b>BlendOp</b> member defines how to combine the <b>SrcBlend</b> and <b>DestBlend</b>
    ///operations.
    D3D11_BLEND    DestBlend;
    ///Type: <b>D3D11_BLEND_OP</b> This blend operation defines how to combine the <b>SrcBlend</b> and <b>DestBlend</b>
    ///operations.
    D3D11_BLEND_OP BlendOp;
    ///Type: <b>D3D11_BLEND</b> This blend option specifies the operation to perform on the alpha value that the pixel
    ///shader outputs. Blend options that end in _COLOR are not allowed. The <b>BlendOpAlpha</b> member defines how to
    ///combine the <b>SrcBlendAlpha</b> and <b>DestBlendAlpha</b> operations.
    D3D11_BLEND    SrcBlendAlpha;
    ///Type: <b>D3D11_BLEND</b> This blend option specifies the operation to perform on the current alpha value in the
    ///render target. Blend options that end in _COLOR are not allowed. The <b>BlendOpAlpha</b> member defines how to
    ///combine the <b>SrcBlendAlpha</b> and <b>DestBlendAlpha</b> operations.
    D3D11_BLEND    DestBlendAlpha;
    ///Type: <b>D3D11_BLEND_OP</b> This blend operation defines how to combine the <b>SrcBlendAlpha</b> and
    ///<b>DestBlendAlpha</b> operations.
    D3D11_BLEND_OP BlendOpAlpha;
    ///Type: <b>D3D11_LOGIC_OP</b> A D3D11_LOGIC_OP-typed value that specifies the logical operation to configure for
    ///the render target.
    D3D11_LOGIC_OP LogicOp;
    ///Type: <b>UINT8</b> A write mask.
    ubyte          RenderTargetWriteMask;
}

///Describes the blend state that you use in a call to
///[**D3D11Device1::CreateBlendState1**](./nf-d3d11_1-id3d11device1-createblendstate1.md) to create a blend-state
///object. > [!NOTE] > This structure is supported by the Direct3D 11.1 runtime, which is available on Windows 8 and
///later operating systems.
struct D3D11_BLEND_DESC1
{
    ///Type: <b>BOOL</b> Specifies whether to use alpha-to-coverage as a multisampling technique when setting a pixel to
    ///a render target. For more info about using alpha-to-coverage, see Alpha-To-Coverage.
    BOOL AlphaToCoverageEnable;
    ///Type: <b>BOOL</b> Specifies whether to enable independent blending in simultaneous render targets. Set to
    ///<b>TRUE</b> to enable independent blending. If set to <b>FALSE</b>, only the <b>RenderTarget</b>[0] members are
    ///used; <b>RenderTarget</b>[1..7] are ignored. See the **Remarks** section for restrictions.
    BOOL IndependentBlendEnable;
    ///Type: <b>D3D11_RENDER_TARGET_BLEND_DESC1[8]</b> An array of D3D11_RENDER_TARGET_BLEND_DESC1 structures that
    ///describe the blend states for render targets; these correspond to the eight render targets that can be bound to
    ///the output-merger stage at one time.
    D3D11_RENDER_TARGET_BLEND_DESC1[8] RenderTarget;
}

///<div class="alert"><b>Note</b> This structure is supported by the Direct3D 11.1 runtime, which is available on
///Windows 8 and later operating systems.</div><div> </div>Describes rasterizer state.
struct D3D11_RASTERIZER_DESC1
{
    ///Type: <b>D3D11_FILL_MODE</b> Determines the fill mode to use when rendering.
    D3D11_FILL_MODE FillMode;
    ///Type: <b>D3D11_CULL_MODE</b> Indicates that triangles facing the specified direction are not drawn.
    D3D11_CULL_MODE CullMode;
    ///Type: <b>BOOL</b> Specifies whether a triangle is front- or back-facing. If <b>TRUE</b>, a triangle will be
    ///considered front-facing if its vertices are counter-clockwise on the render target and considered back-facing if
    ///they are clockwise. If <b>FALSE</b>, the opposite is true.
    BOOL            FrontCounterClockwise;
    ///Type: <b>INT</b> Depth value added to a given pixel. For info about depth bias, see Depth Bias.
    int             DepthBias;
    ///Type: <b>FLOAT</b> Maximum depth bias of a pixel. For info about depth bias, see Depth Bias.
    float           DepthBiasClamp;
    ///Type: <b>FLOAT</b> Scalar on a given pixel's slope. For info about depth bias, see Depth Bias.
    float           SlopeScaledDepthBias;
    ///Type: <b>BOOL</b> Specifies whether to enable clipping based on distance. The hardware always performs x and y
    ///clipping of rasterized coordinates. When <b>DepthClipEnable</b> is set to the default–<b>TRUE</b>, the hardware
    ///also clips the z value (that is, the hardware performs the last step of the following algorithm). <pre
    ///class="syntax" xml:space="preserve"><code> 0 &lt; w -w &lt;= x &lt;= w (or arbitrarily wider range if
    ///implementation uses a guard band to reduce clipping burden) -w &lt;= y &lt;= w (or arbitrarily wider range if
    ///implementation uses a guard band to reduce clipping burden) 0 &lt;= z &lt;= w </code></pre> When you set
    ///<b>DepthClipEnable</b> to <b>FALSE</b>, the hardware skips the z clipping (that is, the last step in the
    ///preceding algorithm). However, the hardware still performs the "0 &lt; w" clipping. When z clipping is disabled,
    ///improper depth ordering at the pixel level might result. However, when z clipping is disabled, stencil shadow
    ///implementations are simplified. In other words, you can avoid complex special-case handling for geometry that
    ///goes beyond the back clipping plane.
    BOOL            DepthClipEnable;
    ///Type: <b>BOOL</b> Specifies whether to enable scissor-rectangle culling. All pixels outside an active scissor
    ///rectangle are culled.
    BOOL            ScissorEnable;
    ///Type: <b>BOOL</b> Specifies whether to use the quadrilateral or alpha line anti-aliasing algorithm on multisample
    ///antialiasing (MSAA) render targets. Set to <b>TRUE</b> to use the quadrilateral line anti-aliasing algorithm and
    ///to <b>FALSE</b> to use the alpha line anti-aliasing algorithm. For more info about this member, see Remarks.
    BOOL            MultisampleEnable;
    ///Type: <b>BOOL</b> Specifies whether to enable line antialiasing; only applies if doing line drawing and
    ///<b>MultisampleEnable</b> is <b>FALSE</b>. For more info about this member, see Remarks.
    BOOL            AntialiasedLineEnable;
    ///Type: <b>UINT</b> The sample count that is forced while UAV rendering or rasterizing. Valid values are 0, 1, 2,
    ///4, 8, and optionally 16. 0 indicates that the sample count is not forced. <div class="alert"><b>Note</b> If you
    ///want to render with <b>ForcedSampleCount</b> set to 1 or greater, you must follow these guidelines: <ul>
    ///<li>Don't bind depth-stencil views.</li> <li>Disable depth testing.</li> <li>Ensure the shader doesn't output
    ///depth.</li> <li>If you have any render-target views bound (D3D11_BIND_RENDER_TARGET) and <b>ForcedSampleCount</b>
    ///is greater than 1, ensure that every render target has only a single sample.</li> <li>Don't operate the shader at
    ///sample frequency. Therefore, ID3D11ShaderReflection::IsSampleFrequencyShader returns <b>FALSE</b>.</li>
    ///</ul>Otherwise, rendering behavior is undefined. For info about how to configure depth-stencil, see Configuring
    ///Depth-Stencil Functionality.</div> <div> </div>
    uint            ForcedSampleCount;
}

///Describes the coordinates of a tiled resource.
struct D3D11_TILED_RESOURCE_COORDINATE
{
    ///Type: <b>UINT</b> The x position of a tiled resource. Used for buffer and 1D, 2D, and 3D textures.
    uint X;
    ///Type: <b>UINT</b> The y position of a tiled resource. Used for 2D and 3D textures.
    uint Y;
    ///Type: <b>UINT</b> The z position of a tiled resource. Used for 3D textures.
    uint Z;
    ///Type: <b>UINT</b> A subresource index value into mipmaps and arrays. Used for 1D, 2D, and 3D textures. For
    ///mipmaps that use nonstandard tiling, or are packed, or both use nonstandard tiling and are packed, any
    ///subresource value that indicates any of the packed mipmaps all refer to the same tile.
    uint Subresource;
}

///Describes the size of a tiled region.
struct D3D11_TILE_REGION_SIZE
{
    ///Type: <b>UINT</b> The number of tiles in the tiled region.
    uint   NumTiles;
    ///Type: <b>BOOL</b> Specifies whether the runtime uses the <b>Width</b>, <b>Height</b>, and <b>Depth</b> members to
    ///define the region. If <b>TRUE</b>, the runtime uses the <b>Width</b>, <b>Height</b>, and <b>Depth</b> members to
    ///define the region. If <b>FALSE</b>, the runtime ignores the <b>Width</b>, <b>Height</b>, and <b>Depth</b> members
    ///and uses the <b>NumTiles</b> member to traverse tiles in the resource linearly across x, then y, then z (as
    ///applicable) and then spills over mipmaps/arrays in subresource order. For example, use this technique to map an
    ///entire resource at once. Regardless of whether you specify <b>TRUE</b> or <b>FALSE</b> for <b>bUseBox</b>, you
    ///use a D3D11_TILED_RESOURCE_COORDINATE structure to specify the starting location for the region within the
    ///resource as a separate parameter outside of this structure by using x, y, and z coordinates. When the region
    ///includes mipmaps that are packed with nonstandard tiling, <b>bUseBox</b> must be <b>FALSE</b> because tile
    ///dimensions are not standard and the app only knows a count of how many tiles are consumed by the packed area,
    ///which is per array slice. The corresponding (separate) starting location parameter uses x to offset into the flat
    ///range of tiles in this case, and y and z coordinates must each be 0.
    BOOL   bUseBox;
    ///Type: <b>UINT</b> The width of the tiled region, in tiles. Used for buffer and 1D, 2D, and 3D textures.
    uint   Width;
    ///Type: <b>UINT16</b> The height of the tiled region, in tiles. Used for 2D and 3D textures.
    ushort Height;
    ///Type: <b>UINT16</b> The depth of the tiled region, in tiles. Used for 3D textures or arrays. For arrays, used for
    ///advancing in depth jumps to next slice of same mipmap size, which isn't contiguous in the subresource counting
    ///space if there are multiple mipmaps.
    ushort Depth;
}

///Describes a tiled subresource volume.
struct D3D11_SUBRESOURCE_TILING
{
    ///Type: <b>UINT</b> The width in tiles of the subresource.
    uint   WidthInTiles;
    ///Type: <b>UINT16</b> The height in tiles of the subresource.
    ushort HeightInTiles;
    ///Type: <b>UINT16</b> The depth in tiles of the subresource.
    ushort DepthInTiles;
    ///Type: <b>UINT</b> The index of the tile in the overall tiled subresource to start with. GetResourceTiling sets
    ///<b>StartTileIndexInOverallResource</b> to <b>D3D11_PACKED_TILE</b> (0xffffffff) to indicate that the whole
    ///<b>D3D11_SUBRESOURCE_TILING</b> structure is meaningless, and the info to which the <i>pPackedMipDesc</i>
    ///parameter of <b>GetResourceTiling</b> points applies. For packed tiles, the description of the packed mipmaps
    ///comes from a D3D11_PACKED_MIP_DESC structure instead.
    uint   StartTileIndexInOverallResource;
}

///Describes the shape of a tile by specifying its dimensions.
struct D3D11_TILE_SHAPE
{
    ///Type: <b>UINT</b> The width in texels of the tile.
    uint WidthInTexels;
    ///Type: <b>UINT</b> The height in texels of the tile.
    uint HeightInTexels;
    ///Type: <b>UINT</b> The depth in texels of the tile.
    uint DepthInTexels;
}

///Describes the tile structure of a tiled resource with mipmaps.
struct D3D11_PACKED_MIP_DESC
{
    ///Number of standard mipmaps in the tiled resource.
    ubyte NumStandardMips;
    ///Number of packed mipmaps in the tiled resource. This number starts from the least detailed mipmap (either sharing
    ///tiles or using non standard tile layout). This number is 0 if no such packing is in the resource. For array
    ///surfaces, this value is the number of mipmaps that are packed for a given array slice where each array slice
    ///repeats the same packing. On Tier_2 tiled resources hardware, mipmaps that fill at least one standard shaped tile
    ///in all dimensions are not allowed to be included in the set of packed mipmaps. On Tier_1 hardware, mipmaps that
    ///are an integer multiple of one standard shaped tile in all dimensions are not allowed to be included in the set
    ///of packed mipmaps. Mipmaps with at least one dimension less than the standard tile shape may or may not be
    ///packed. When a given mipmap needs to be packed, all coarser mipmaps for a given array slice are considered packed
    ///as well.
    ubyte NumPackedMips;
    ///Number of tiles for the packed mipmaps in the tiled resource. If there is no packing, this value is meaningless
    ///and is set to 0. Otherwise, it is set to the number of tiles that are needed to represent the set of packed
    ///mipmaps. The pixel layout within the packed mipmaps is hardware specific. If apps define only partial mappings
    ///for the set of tiles in packed mipmaps, read and write behavior is vendor specific and undefined. For arrays,
    ///this value is only the count of packed mipmaps within the subresources for each array slice.
    uint  NumTilesForPackedMips;
    ///Offset of the first packed tile for the resource in the overall range of tiles. If <b>NumPackedMips</b> is 0,
    ///this value is meaningless and is 0. Otherwise, it is the offset of the first packed tile for the resource in the
    ///overall range of tiles for the resource. A value of 0 for <b>StartTileIndexInOverallResource</b> means the entire
    ///resource is packed. For array surfaces, this is the offset for the tiles that contain the packed mipmaps for the
    ///first array slice. Packed mipmaps for each array slice in arrayed surfaces are at this offset past the beginning
    ///of the tiles for each array slice. <div class="alert"><b>Note</b> The number of overall tiles, packed or not, for
    ///a given array slice is simply the total number of tiles for the resource divided by the resource's array size, so
    ///it is easy to locate the range of tiles for any given array slice, out of which
    ///<b>StartTileIndexInOverallResource</b> identifies which of those are packed.</div> <div> </div>
    uint  StartTileIndexInOverallResource;
}

///Describes a 2D texture.
struct D3D11_TEXTURE2D_DESC1
{
    ///Texture width (in texels). The range is from 1 to D3D11_REQ_TEXTURE2D_U_OR_V_DIMENSION (16384). For a texture
    ///cube-map, the range is from 1 to D3D11_REQ_TEXTURECUBE_DIMENSION (16384). However, the range is actually
    ///constrained by the feature level at which you create the rendering device. For more information about
    ///restrictions, see Remarks.
    uint                 Width;
    ///Texture height (in texels). The range is from 1 to D3D11_REQ_TEXTURE2D_U_OR_V_DIMENSION (16384). For a texture
    ///cube-map, the range is from 1 to D3D11_REQ_TEXTURECUBE_DIMENSION (16384). However, the range is actually
    ///constrained by the feature level at which you create the rendering device. For more information about
    ///restrictions, see Remarks.
    uint                 Height;
    ///The maximum number of mipmap levels in the texture. See the remarks in D3D11_TEX1D_SRV. Use 1 for a multisampled
    ///texture; or 0 to generate a full set of subtextures.
    uint                 MipLevels;
    ///Number of textures in the texture array. The range is from 1 to D3D11_REQ_TEXTURE2D_ARRAY_AXIS_DIMENSION (2048).
    ///For a texture cube-map, this value is a multiple of 6 (that is, 6 times the value in the <b>NumCubes</b> member
    ///of D3D11_TEXCUBE_ARRAY_SRV), and the range is from 6 to 2046. The range is actually constrained by the feature
    ///level at which you create the rendering device. For more information about restrictions, see Remarks.
    uint                 ArraySize;
    ///Texture format (see DXGI_FORMAT).
    DXGI_FORMAT          Format;
    ///Structure that specifies multisampling parameters for the texture. See DXGI_SAMPLE_DESC.
    DXGI_SAMPLE_DESC     SampleDesc;
    ///Value that identifies how the texture is to be read from and written to. The most common value is
    ///D3D11_USAGE_DEFAULT; see D3D11_USAGE for all possible values.
    D3D11_USAGE          Usage;
    ///Flags (see D3D11_BIND_FLAG) for binding to pipeline stages. The flags can be combined by a logical OR.
    uint                 BindFlags;
    ///Flags (see D3D11_CPU_ACCESS_FLAG) to specify the types of CPU access allowed. Use 0 if CPU access is not
    ///required. These flags can be combined with a logical OR.
    uint                 CPUAccessFlags;
    ///Flags (see D3D11_RESOURCE_MISC_FLAG) that identify other, less common resource options. Use 0 if none of these
    ///flags apply. These flags can be combined by using a logical OR. For a texture cube-map, set the
    ///D3D11_RESOURCE_MISC_TEXTURECUBE flag. Cube-map arrays (that is, <b>ArraySize</b> &gt; 6) require feature level
    ///D3D_FEATURE_LEVEL_10_1 or higher.
    uint                 MiscFlags;
    ///A D3D11_TEXTURE_LAYOUT-typed value that identifies the layout of the texture. The TextureLayout parameter selects
    ///both the actual layout of the texture in memory and the layout visible to the application while the texture is
    ///mapped. These flags may not be requested without CPU access also requested. It is illegal to set CPU access flags
    ///on default textures without also setting TextureLayout to a value other than D3D11_TEXTURE_LAYOUT_UNDEFINED.
    ///D3D11_TEXTURE_LAYOUT_ROW_MAJOR may only be used to create non-multisampled, textures with a single subresource
    ///(Planar YUV textures are supported). These textures may only be used as a source and destination of copy
    ///operations, and BindFlags must be zero. D3D11_TEXTURE_LAYOUT_64K_STANDARD_SWIZZLE may only be used to create
    ///non-multisampled, non-depth-stencil textures.
    D3D11_TEXTURE_LAYOUT TextureLayout;
}

///Describes a 3D texture.
struct D3D11_TEXTURE3D_DESC1
{
    ///Texture width (in texels). The range is from 1 to D3D11_REQ_TEXTURE3D_U_V_OR_W_DIMENSION (2048). However, the
    ///range is actually constrained by the feature level at which you create the rendering device. For more information
    ///about restrictions, see Remarks.
    uint                 Width;
    ///Texture height (in texels). The range is from 1 to D3D11_REQ_TEXTURE3D_U_V_OR_W_DIMENSION (2048). However, the
    ///range is actually constrained by the feature level at which you create the rendering device. For more information
    ///about restrictions, see Remarks.
    uint                 Height;
    ///Texture depth (in texels). The range is from 1 to D3D11_REQ_TEXTURE3D_U_V_OR_W_DIMENSION (2048). However, the
    ///range is actually constrained by the feature level at which you create the rendering device. For more information
    ///about restrictions, see Remarks.
    uint                 Depth;
    ///The maximum number of mipmap levels in the texture. See the remarks in D3D11_TEX1D_SRV. Use 1 for a multisampled
    ///texture; or 0 to generate a full set of subtextures.
    uint                 MipLevels;
    ///Texture format (see DXGI_FORMAT).
    DXGI_FORMAT          Format;
    ///Value that identifies how the texture is to be read from and written to. The most common value is
    ///D3D11_USAGE_DEFAULT; see D3D11_USAGE for all possible values.
    D3D11_USAGE          Usage;
    ///Flags (see D3D11_BIND_FLAG) for binding to pipeline stages. The flags can be combined by a logical OR.
    uint                 BindFlags;
    ///Flags (see D3D11_CPU_ACCESS_FLAG) to specify the types of CPU access allowed. Use 0 if CPU access is not
    ///required. These flags can be combined with a logical OR.
    uint                 CPUAccessFlags;
    ///Flags (see D3D11_RESOURCE_MISC_FLAG) that identify other, less common resource options. Use 0 if none of these
    ///flags apply. These flags can be combined with a logical OR.
    uint                 MiscFlags;
    ///A D3D11_TEXTURE_LAYOUT-typed value that identifies the layout of the texture. The TextureLayout parameter selects
    ///both the actual layout of the texture in memory and the layout visible to the application while the texture is
    ///mapped. These flags may not be requested without CPU access also requested. It is illegal to set CPU access flags
    ///on default textures without also setting Layout to a value other than D3D11_TEXTURE_LAYOUT_UNDEFINED.
    ///D3D11_TEXTURE_LAYOUT_ROW_MAJOR may not be used with 3D textures. D3D11_TEXTURE_LAYOUT_64K_STANDARD_SWIZZLE may
    ///not be used with 3D textures that have mipmaps.
    D3D11_TEXTURE_LAYOUT TextureLayout;
}

///Describes rasterizer state.
struct D3D11_RASTERIZER_DESC2
{
    ///A D3D11_FILL_MODE-typed value that determines the fill mode to use when rendering.
    D3D11_FILL_MODE FillMode;
    ///A D3D11_CULL_MODE-typed value that indicates that triangles facing the specified direction are not drawn.
    D3D11_CULL_MODE CullMode;
    ///Specifies whether a triangle is front- or back-facing. If <b>TRUE</b>, a triangle will be considered front-facing
    ///if its vertices are counter-clockwise on the render target and considered back-facing if they are clockwise. If
    ///<b>FALSE</b>, the opposite is true.
    BOOL            FrontCounterClockwise;
    ///Depth value added to a given pixel. For info about depth bias, see Depth Bias.
    int             DepthBias;
    ///Maximum depth bias of a pixel. For info about depth bias, see Depth Bias.
    float           DepthBiasClamp;
    ///Scalar on a given pixel's slope. For info about depth bias, see Depth Bias.
    float           SlopeScaledDepthBias;
    ///Specifies whether to enable clipping based on distance. The hardware always performs x and y clipping of
    ///rasterized coordinates. When <b>DepthClipEnable</b> is set to the default–<b>TRUE</b>, the hardware also clips
    ///the z value (that is, the hardware performs the last step of the following algorithm). <pre class="syntax"
    ///xml:space="preserve"><code> 0 &lt; w -w &lt;= x &lt;= w (or arbitrarily wider range if implementation uses a
    ///guard band to reduce clipping burden) -w &lt;= y &lt;= w (or arbitrarily wider range if implementation uses a
    ///guard band to reduce clipping burden) 0 &lt;= z &lt;= w </code></pre> When you set <b>DepthClipEnable</b> to
    ///<b>FALSE</b>, the hardware skips the z clipping (that is, the last step in the preceding algorithm). However, the
    ///hardware still performs the "0 &lt; w" clipping. When z clipping is disabled, improper depth ordering at the
    ///pixel level might result. However, when z clipping is disabled, stencil shadow implementations are simplified. In
    ///other words, you can avoid complex special-case handling for geometry that goes beyond the back clipping plane.
    BOOL            DepthClipEnable;
    ///Specifies whether to enable scissor-rectangle culling. All pixels outside an active scissor rectangle are culled.
    BOOL            ScissorEnable;
    ///Specifies whether to use the quadrilateral or alpha line anti-aliasing algorithm on multisample antialiasing
    ///(MSAA) render targets. Set to <b>TRUE</b> to use the quadrilateral line anti-aliasing algorithm and to
    ///<b>FALSE</b> to use the alpha line anti-aliasing algorithm. For more info about this member, see Remarks.
    BOOL            MultisampleEnable;
    ///Specifies whether to enable line antialiasing; only applies if doing line drawing and <b>MultisampleEnable</b> is
    ///<b>FALSE</b>. For more info about this member, see Remarks.
    BOOL            AntialiasedLineEnable;
    ///The sample count that is forced while UAV rendering or rasterizing. Valid values are 0, 1, 2, 4, 8, and
    ///optionally 16. 0 indicates that the sample count is not forced. <div class="alert"><b>Note</b> If you want to
    ///render with <b>ForcedSampleCount</b> set to 1 or greater, you must follow these guidelines: <ul> <li>Don't bind
    ///depth-stencil views.</li> <li>Disable depth testing.</li> <li>Ensure the shader doesn't output depth.</li> <li>If
    ///you have any render-target views bound (D3D11_BIND_RENDER_TARGET) and <b>ForcedSampleCount</b> is greater than 1,
    ///ensure that every render target has only a single sample.</li> <li>Don't operate the shader at sample frequency.
    ///Therefore, ID3D11ShaderReflection::IsSampleFrequencyShader returns <b>FALSE</b>.</li> </ul>Otherwise, rendering
    ///behavior is undefined. For info about how to configure depth-stencil, see Configuring Depth-Stencil
    ///Functionality.</div> <div> </div>
    uint            ForcedSampleCount;
    ///A D3D11_CONSERVATIVE_RASTERIZATION_MODE-typed value that identifies whether conservative rasterization is on or
    ///off.
    D3D11_CONSERVATIVE_RASTERIZATION_MODE ConservativeRaster;
}

///Describes the subresource from a 2D texture to use in a shader-resource view.
struct D3D11_TEX2D_SRV1
{
    ///Index of the most detailed mipmap level to use; this number is between 0 and (<b>MipLevels</b> (from the original
    ///Texture2D for which ID3D11Device3::CreateShaderResourceView1creates a view) - 1 ).
    uint MostDetailedMip;
    ///The maximum number of mipmap levels for the view of the texture. See the remarks in D3D11_TEX1D_SRV. Set to -1 to
    ///indicate all the mipmap levels from <b>MostDetailedMip</b> on down to least detailed.
    uint MipLevels;
    ///The index (plane slice number) of the plane to use in the texture.
    uint PlaneSlice;
}

///Describes the subresources from an array of 2D textures to use in a shader-resource view.
struct D3D11_TEX2D_ARRAY_SRV1
{
    ///Index of the most detailed mipmap level to use; this number is between 0 and ( <b>MipLevels</b> (from the
    ///original Texture2D for which ID3D11Device3::CreateShaderResourceView1 creates a view) - 1).
    uint MostDetailedMip;
    ///The maximum number of mipmap levels for the view of the texture. See the remarks in D3D11_TEX1D_SRV. Set to -1 to
    ///indicate all the mipmap levels from <b>MostDetailedMip</b> on down to least detailed.
    uint MipLevels;
    ///The index of the first texture to use in an array of textures.
    uint FirstArraySlice;
    ///Number of textures in the array.
    uint ArraySize;
    ///The index (plane slice number) of the plane to use in an array of textures.
    uint PlaneSlice;
}

///Describes a shader-resource view.
struct D3D11_SHADER_RESOURCE_VIEW_DESC1
{
    ///A DXGI_FORMAT-typed value that specifies the viewing format. See remarks.
    DXGI_FORMAT       Format;
    ///A D3D11_SRV_DIMENSION-typed value that specifies the resource type of the view. This type is the same as the
    ///resource type of the underlying resource. This member also determines which _SRV to use in the union below.
    D3D_SRV_DIMENSION ViewDimension;
union
    {
        D3D11_BUFFER_SRV   Buffer;
        D3D11_TEX1D_SRV    Texture1D;
        D3D11_TEX1D_ARRAY_SRV Texture1DArray;
        D3D11_TEX2D_SRV1   Texture2D;
        D3D11_TEX2D_ARRAY_SRV1 Texture2DArray;
        D3D11_TEX2DMS_SRV  Texture2DMS;
        D3D11_TEX2DMS_ARRAY_SRV Texture2DMSArray;
        D3D11_TEX3D_SRV    Texture3D;
        D3D11_TEXCUBE_SRV  TextureCube;
        D3D11_TEXCUBE_ARRAY_SRV TextureCubeArray;
        D3D11_BUFFEREX_SRV BufferEx;
    }
}

///Describes the subresource from a 2D texture to use in a render-target view.
struct D3D11_TEX2D_RTV1
{
    ///The index of the mipmap level to use mip slice.
    uint MipSlice;
    ///The index (plane slice number) of the plane to use in the texture.
    uint PlaneSlice;
}

///Describes the subresources from an array of 2D textures to use in a render-target view.
struct D3D11_TEX2D_ARRAY_RTV1
{
    ///The index of the mipmap level to use mip slice.
    uint MipSlice;
    ///The index of the first texture to use in an array of textures.
    uint FirstArraySlice;
    ///Number of textures in the array to use in the render-target view, starting from <b>FirstArraySlice</b>.
    uint ArraySize;
    ///The index (plane slice number) of the plane to use in an array of textures.
    uint PlaneSlice;
}

///Describes the subresources from a resource that are accessible using a render-target view.
struct D3D11_RENDER_TARGET_VIEW_DESC1
{
    ///A DXGI_FORMAT-typed value that specifies the data format.
    DXGI_FORMAT         Format;
    ///A D3D11_RTV_DIMENSION-typed value that specifies the resource type and how the render-target resource will be
    ///accessed.
    D3D11_RTV_DIMENSION ViewDimension;
union
    {
        D3D11_BUFFER_RTV  Buffer;
        D3D11_TEX1D_RTV   Texture1D;
        D3D11_TEX1D_ARRAY_RTV Texture1DArray;
        D3D11_TEX2D_RTV1  Texture2D;
        D3D11_TEX2D_ARRAY_RTV1 Texture2DArray;
        D3D11_TEX2DMS_RTV Texture2DMS;
        D3D11_TEX2DMS_ARRAY_RTV Texture2DMSArray;
        D3D11_TEX3D_RTV   Texture3D;
    }
}

///Describes a unordered-access 2D texture resource.
struct D3D11_TEX2D_UAV1
{
    ///The mipmap slice index.
    uint MipSlice;
    ///The index (plane slice number) of the plane to use in the texture.
    uint PlaneSlice;
}

///Describes an array of unordered-access 2D texture resources.
struct D3D11_TEX2D_ARRAY_UAV1
{
    ///The mipmap slice index.
    uint MipSlice;
    ///The zero-based index of the first array slice to be accessed.
    uint FirstArraySlice;
    ///The number of slices in the array.
    uint ArraySize;
    ///The index (plane slice number) of the plane to use in an array of textures.
    uint PlaneSlice;
}

///Describes the subresources from a resource that are accessible using an unordered-access view.
struct D3D11_UNORDERED_ACCESS_VIEW_DESC1
{
    ///A DXGI_FORMAT-typed value that specifies the data format.
    DXGI_FORMAT         Format;
    ///A D3D11_UAV_DIMENSION-typed value that specifies the resource type of the view. This type is the same as the
    ///resource type of the underlying resource. This member also determines which _UAV to use in the union below.
    D3D11_UAV_DIMENSION ViewDimension;
union
    {
        D3D11_BUFFER_UAV Buffer;
        D3D11_TEX1D_UAV  Texture1D;
        D3D11_TEX1D_ARRAY_UAV Texture1DArray;
        D3D11_TEX2D_UAV1 Texture2D;
        D3D11_TEX2D_ARRAY_UAV1 Texture2DArray;
        D3D11_TEX3D_UAV  Texture3D;
    }
}

///Describes a query.
struct D3D11_QUERY_DESC1
{
    ///A D3D11_QUERY-typed value that specifies the type of query.
    D3D11_QUERY        Query;
    ///A combination of D3D11_QUERY_MISC_FLAG-typed values that are combined by using a bitwise OR operation. The
    ///resulting value specifies query behavior.
    uint               MiscFlags;
    ///A D3D11_CONTEXT_TYPE-typed value that specifies the context for the query.
    D3D11_CONTEXT_TYPE ContextType;
}

///Provides data for calls to
///[ID3D11VideoDevice2::CheckFeatureSupport](nf-d3d11_4-id3d11videodevice2-checkfeaturesupport.md) when the feature
///specified is [D3D11_FEATURE_VIDEO_DECODER_HISTOGRAM](ne-d3d11_4-d3d11_feature_video.md). Retrieves the histogram
///capabilities for the specified decoder configuration.
struct D3D11_FEATURE_DATA_VIDEO_DECODER_HISTOGRAM
{
    ///A [D3D11_VIDEO_DECODER_DESC](../d3d11/ns-d3d11-d3d11_video_decoder_desc.md) structure containing the decoder
    ///description for the decoder to be used with decode histogram.
    D3D11_VIDEO_DECODER_DESC DecoderDesc;
    ///A bitwise OR combination of values from the
    ///[D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_FLAGS](ne-d3d11_4-d3d11_video_decoder_histogram_component_flags.md)
    ///enumeration specifying the components of a DXGI_FORMAT for which histogram support will be queried.
    D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_FLAGS Components;
    ///The number of per component bins supported. This value must be greater than or equal to 64 and must be a power of
    ///2 (e.g. 64, 128, 256, 512...).
    uint BinCount;
    ///The bit depth of the bin counter. The counter is always stored in a 32-bit value and therefore this value must
    ///specify 32 bits or less. The counter is stored in the lower bits of the 32-bit storage. The upper bits are set to
    ///zero. If the bin count exceeds this bit depth, the value is set to the maximum counter value. Valid values for
    ///*CounterBitDepth* are 16, 24, and 32.
    uint CounterBitDepth;
}

struct D3D11_VIDEO_DECODER_BUFFER_DESC2
{
    D3D11_VIDEO_DECODER_BUFFER_TYPE BufferType;
    uint  DataOffset;
    uint  DataSize;
    void* pIV;
    uint  IVSize;
    D3D11_VIDEO_DECODER_SUB_SAMPLE_MAPPING_BLOCK* pSubSampleMappingBlock;
    uint  SubSampleMappingCount;
    uint  cBlocksStripeEncrypted;
    uint  cBlocksStripeClear;
}

///Describes Direct3D 11.4 feature options in the current graphics driver.
struct D3D11_FEATURE_DATA_D3D11_OPTIONS4
{
    ///Specifies a BOOL that determines if NV12 textures can be shared across processes and D3D devices.
    BOOL ExtendedNV12SharedTextureSupported;
}

///Describes a shader signature.
struct D3D11_SIGNATURE_PARAMETER_DESC
{
    ///Type: <b>LPCSTR</b> A per-parameter string that identifies how the data will be used. For more info, see
    ///Semantics.
    const(PSTR)       SemanticName;
    ///Type: <b>UINT</b> Semantic index that modifies the semantic. Used to differentiate different parameters that use
    ///the same semantic.
    uint              SemanticIndex;
    ///Type: <b>UINT</b> The register that will contain this variable's data.
    uint              Register;
    ///Type: <b>D3D_NAME</b> A D3D_NAME-typed value that identifies a predefined string that determines the
    ///functionality of certain pipeline stages.
    D3D_NAME          SystemValueType;
    ///Type: <b>D3D_REGISTER_COMPONENT_TYPE</b> A D3D_REGISTER_COMPONENT_TYPE-typed value that identifies the
    ///per-component-data type that is stored in a register. Each register can store up to four-components of data.
    D3D_REGISTER_COMPONENT_TYPE ComponentType;
    ///Type: <b>BYTE</b> Mask which indicates which components of a register are used.
    ubyte             Mask;
    ///Type: <b>BYTE</b> Mask which indicates whether a given component is never written (if the signature is an output
    ///signature) or always read (if the signature is an input signature).
    ubyte             ReadWriteMask;
    ///Type: <b>UINT</b> Indicates which stream the geometry shader is using for the signature parameter.
    uint              Stream;
    ///Type: <b>D3D_MIN_PRECISION</b> A D3D_MIN_PRECISION-typed value that indicates the minimum desired interpolation
    ///precision. For more info, see Using HLSL minimum precision.
    D3D_MIN_PRECISION MinPrecision;
}

///Describes a shader constant-buffer.
struct D3D11_SHADER_BUFFER_DESC
{
    ///Type: <b>LPCSTR</b> The name of the buffer.
    const(PSTR)      Name;
    ///Type: <b>D3D_CBUFFER_TYPE</b> A D3D_CBUFFER_TYPE-typed value that indicates the intended use of the constant
    ///data.
    D3D_CBUFFER_TYPE Type;
    ///Type: <b>UINT</b> The number of unique variables.
    uint             Variables;
    ///Type: <b>UINT</b> Buffer size (in bytes).
    uint             Size;
    ///Type: <b>UINT</b> A combination of D3D_SHADER_CBUFFER_FLAGS-typed values that are combined by using a bitwise OR
    ///operation. The resulting value specifies properties for the shader constant-buffer.
    uint             uFlags;
}

///Describes a shader variable.
struct D3D11_SHADER_VARIABLE_DESC
{
    ///Type: <b>LPCSTR</b> The variable name.
    const(PSTR) Name;
    ///Type: <b>UINT</b> Offset from the start of the parent structure to the beginning of the variable.
    uint        StartOffset;
    ///Type: <b>UINT</b> Size of the variable (in bytes).
    uint        Size;
    ///Type: <b>UINT</b> A combination of D3D_SHADER_VARIABLE_FLAGS-typed values that are combined by using a bitwise OR
    ///operation. The resulting value identifies shader-variable properties.
    uint        uFlags;
    ///Type: <b>LPVOID</b> The default value for initializing the variable.
    void*       DefaultValue;
    ///Type: <b>UINT</b> Offset from the start of the variable to the beginning of the texture.
    uint        StartTexture;
    ///Type: <b>UINT</b> The size of the texture, in bytes.
    uint        TextureSize;
    ///Type: <b>UINT</b> Offset from the start of the variable to the beginning of the sampler.
    uint        StartSampler;
    ///Type: <b>UINT</b> The size of the sampler, in bytes.
    uint        SamplerSize;
}

///Describes a shader-variable type.
struct D3D11_SHADER_TYPE_DESC
{
    ///Type: <b>D3D_SHADER_VARIABLE_CLASS</b> A D3D_SHADER_VARIABLE_CLASS-typed value that identifies the variable class
    ///as one of scalar, vector, matrix, object, and so on.
    D3D_SHADER_VARIABLE_CLASS Class;
    ///Type: <b>D3D_SHADER_VARIABLE_TYPE</b> A D3D_SHADER_VARIABLE_TYPE-typed value that identifies the variable type.
    D3D_SHADER_VARIABLE_TYPE Type;
    ///Type: <b>UINT</b> Number of rows in a matrix. Otherwise a numeric type returns 1, any other type returns 0.
    uint        Rows;
    ///Type: <b>UINT</b> Number of columns in a matrix. Otherwise a numeric type returns 1, any other type returns 0.
    uint        Columns;
    ///Type: <b>UINT</b> Number of elements in an array; otherwise 0.
    uint        Elements;
    ///Type: <b>UINT</b> Number of members in the structure; otherwise 0.
    uint        Members;
    ///Type: <b>UINT</b> Offset, in bytes, between the start of the parent structure and this variable. Can be 0 if not
    ///a structure member.
    uint        Offset;
    ///Type: <b>LPCSTR</b> Name of the shader-variable type. This member can be <b>NULL</b> if it isn't used. This
    ///member supports dynamic shader linkage interface types, which have names. For more info about dynamic shader
    ///linkage, see Dynamic Linking.
    const(PSTR) Name;
}

///Describes a shader.
struct D3D11_SHADER_DESC
{
    ///Type: <b>UINT</b> Shader version.
    uint          Version;
    ///Type: <b>LPCSTR</b> The name of the originator of the shader.
    const(PSTR)   Creator;
    ///Type: <b>UINT</b> Shader compilation/parse flags.
    uint          Flags;
    ///Type: <b>UINT</b> The number of shader-constant buffers.
    uint          ConstantBuffers;
    ///Type: <b>UINT</b> The number of resource (textures and buffers) bound to a shader.
    uint          BoundResources;
    ///Type: <b>UINT</b> The number of parameters in the input signature.
    uint          InputParameters;
    ///Type: <b>UINT</b> The number of parameters in the output signature.
    uint          OutputParameters;
    ///Type: <b>UINT</b> The number of intermediate-language instructions in the compiled shader.
    uint          InstructionCount;
    ///Type: <b>UINT</b> The number of temporary registers in the compiled shader.
    uint          TempRegisterCount;
    ///Type: <b>UINT</b> Number of temporary arrays used.
    uint          TempArrayCount;
    ///Type: <b>UINT</b> Number of constant defines.
    uint          DefCount;
    ///Type: <b>UINT</b> Number of declarations (input + output).
    uint          DclCount;
    ///Type: <b>UINT</b> Number of non-categorized texture instructions.
    uint          TextureNormalInstructions;
    ///Type: <b>UINT</b> Number of texture load instructions
    uint          TextureLoadInstructions;
    ///Type: <b>UINT</b> Number of texture comparison instructions
    uint          TextureCompInstructions;
    ///Type: <b>UINT</b> Number of texture bias instructions
    uint          TextureBiasInstructions;
    ///Type: <b>UINT</b> Number of texture gradient instructions.
    uint          TextureGradientInstructions;
    ///Type: <b>UINT</b> Number of floating point arithmetic instructions used.
    uint          FloatInstructionCount;
    ///Type: <b>UINT</b> Number of signed integer arithmetic instructions used.
    uint          IntInstructionCount;
    ///Type: <b>UINT</b> Number of unsigned integer arithmetic instructions used.
    uint          UintInstructionCount;
    ///Type: <b>UINT</b> Number of static flow control instructions used.
    uint          StaticFlowControlCount;
    ///Type: <b>UINT</b> Number of dynamic flow control instructions used.
    uint          DynamicFlowControlCount;
    ///Type: <b>UINT</b> Number of macro instructions used.
    uint          MacroInstructionCount;
    ///Type: <b>UINT</b> Number of array instructions used.
    uint          ArrayInstructionCount;
    ///Type: <b>UINT</b> Number of cut instructions used.
    uint          CutInstructionCount;
    ///Type: <b>UINT</b> Number of emit instructions used.
    uint          EmitInstructionCount;
    ///Type: <b>D3D_PRIMITIVE_TOPOLOGY</b> The D3D_PRIMITIVE_TOPOLOGY-typed value that represents the geometry shader
    ///output topology.
    D3D_PRIMITIVE_TOPOLOGY GSOutputTopology;
    ///Type: <b>UINT</b> Geometry shader maximum output vertex count.
    uint          GSMaxOutputVertexCount;
    ///Type: <b>D3D_PRIMITIVE</b> The D3D_PRIMITIVE-typed value that represents the input primitive for a geometry
    ///shader or hull shader.
    D3D_PRIMITIVE InputPrimitive;
    ///Type: <b>UINT</b> Number of parameters in the patch-constant signature.
    uint          PatchConstantParameters;
    ///Type: <b>UINT</b> Number of geometry shader instances.
    uint          cGSInstanceCount;
    ///Type: <b>UINT</b> Number of control points in the hull shader and domain shader.
    uint          cControlPoints;
    ///Type: <b>D3D_TESSELLATOR_OUTPUT_PRIMITIVE</b> The D3D_TESSELLATOR_OUTPUT_PRIMITIVE-typed value that represents
    ///the tessellator output-primitive type.
    D3D_TESSELLATOR_OUTPUT_PRIMITIVE HSOutputPrimitive;
    ///Type: <b>D3D_TESSELLATOR_PARTITIONING</b> The D3D_TESSELLATOR_PARTITIONING-typed value that represents the
    ///tessellator partitioning mode.
    D3D_TESSELLATOR_PARTITIONING HSPartitioning;
    ///Type: <b>D3D_TESSELLATOR_DOMAIN</b> The D3D_TESSELLATOR_DOMAIN-typed value that represents the tessellator
    ///domain.
    D3D_TESSELLATOR_DOMAIN TessellatorDomain;
    ///Type: <b>UINT</b> Number of barrier instructions in a compute shader.
    uint          cBarrierInstructions;
    ///Type: <b>UINT</b> Number of interlocked instructions in a compute shader.
    uint          cInterlockedInstructions;
    ///Type: <b>UINT</b> Number of texture writes in a compute shader.
    uint          cTextureStoreInstructions;
}

///Describes how a shader resource is bound to a shader input.
struct D3D11_SHADER_INPUT_BIND_DESC
{
    ///Type: <b>LPCSTR</b> Name of the shader resource.
    const(PSTR)       Name;
    ///Type: <b>D3D_SHADER_INPUT_TYPE</b> A D3D_SHADER_INPUT_TYPE-typed value that identifies the type of data in the
    ///resource.
    D3D_SHADER_INPUT_TYPE Type;
    ///Type: <b>UINT</b> Starting bind point.
    uint              BindPoint;
    ///Type: <b>UINT</b> Number of contiguous bind points for arrays.
    uint              BindCount;
    ///Type: <b>UINT</b> A combination of D3D_SHADER_INPUT_FLAGS-typed values for shader input-parameter options.
    uint              uFlags;
    ///Type: <b>D3D_RESOURCE_RETURN_TYPE</b> If the input is a texture, the D3D_RESOURCE_RETURN_TYPE-typed value that
    ///identifies the return type.
    D3D_RESOURCE_RETURN_TYPE ReturnType;
    ///Type: <b>D3D_SRV_DIMENSION</b> A D3D_SRV_DIMENSION-typed value that identifies the dimensions of the bound
    ///resource.
    D3D_SRV_DIMENSION Dimension;
    ///Type: <b>UINT</b> The number of samples for a multisampled texture; when a texture isn't multisampled, the value
    ///is set to -1 (0xFFFFFFFF).
    uint              NumSamples;
}

///Describes a library.
struct D3D11_LIBRARY_DESC
{
    ///Type: <b>LPCSTR</b> The name of the originator of the library.
    const(PSTR) Creator;
    ///Type: <b>UINT</b> A combination of D3DCOMPILE Constants that are combined by using a bitwise OR operation. The
    ///resulting value specifies how the compiler compiles.
    uint        Flags;
    ///Type: <b>UINT</b> The number of functions exported from the library.
    uint        FunctionCount;
}

///Describes a function.
struct D3D11_FUNCTION_DESC
{
    ///Type: <b>UINT</b> The shader version.
    uint              Version;
    ///Type: <b>LPCSTR</b> The name of the originator of the function.
    const(PSTR)       Creator;
    ///Type: <b>UINT</b> A combination of D3DCOMPILE Constants that are combined by using a bitwise OR operation. The
    ///resulting value specifies shader compilation and parsing.
    uint              Flags;
    ///Type: <b>UINT</b> The number of constant buffers for the function.
    uint              ConstantBuffers;
    ///Type: <b>UINT</b> The number of bound resources for the function.
    uint              BoundResources;
    ///Type: <b>UINT</b> The number of emitted instructions for the function.
    uint              InstructionCount;
    ///Type: <b>UINT</b> The number of temporary registers used by the function.
    uint              TempRegisterCount;
    ///Type: <b>UINT</b> The number of temporary arrays used by the function.
    uint              TempArrayCount;
    ///Type: <b>UINT</b> The number of constant defines for the function.
    uint              DefCount;
    ///Type: <b>UINT</b> The number of declarations (input + output) for the function.
    uint              DclCount;
    ///Type: <b>UINT</b> The number of non-categorized texture instructions for the function.
    uint              TextureNormalInstructions;
    ///Type: <b>UINT</b> The number of texture load instructions for the function.
    uint              TextureLoadInstructions;
    ///Type: <b>UINT</b> The number of texture comparison instructions for the function.
    uint              TextureCompInstructions;
    ///Type: <b>UINT</b> The number of texture bias instructions for the function.
    uint              TextureBiasInstructions;
    ///Type: <b>UINT</b> The number of texture gradient instructions for the function.
    uint              TextureGradientInstructions;
    ///Type: <b>UINT</b> The number of floating point arithmetic instructions used by the function.
    uint              FloatInstructionCount;
    ///Type: <b>UINT</b> The number of signed integer arithmetic instructions used by the function.
    uint              IntInstructionCount;
    ///Type: <b>UINT</b> The number of unsigned integer arithmetic instructions used by the function.
    uint              UintInstructionCount;
    ///Type: <b>UINT</b> The number of static flow control instructions used by the function.
    uint              StaticFlowControlCount;
    ///Type: <b>UINT</b> The number of dynamic flow control instructions used by the function.
    uint              DynamicFlowControlCount;
    ///Type: <b>UINT</b> The number of macro instructions used by the function.
    uint              MacroInstructionCount;
    ///Type: <b>UINT</b> The number of array instructions used by the function.
    uint              ArrayInstructionCount;
    ///Type: <b>UINT</b> The number of mov instructions used by the function.
    uint              MovInstructionCount;
    ///Type: <b>UINT</b> The number of movc instructions used by the function.
    uint              MovcInstructionCount;
    ///Type: <b>UINT</b> The number of type conversion instructions used by the function.
    uint              ConversionInstructionCount;
    ///Type: <b>UINT</b> The number of bitwise arithmetic instructions used by the function.
    uint              BitwiseInstructionCount;
    ///Type: <b>D3D_FEATURE_LEVEL</b> A D3D_FEATURE_LEVEL-typed value that specifies the minimum Direct3D feature level
    ///target of the function byte code.
    D3D_FEATURE_LEVEL MinFeatureLevel;
    ///Type: <b>UINT64</b> A value that contains a combination of one or more shader requirements flags; each flag
    ///specifies a requirement of the shader. A default value of 0 means there are no requirements. For a list of
    ///values, see ID3D11ShaderReflection::GetRequiresFlags.
    ulong             RequiredFeatureFlags;
    ///Type: <b>LPCSTR</b> The name of the function.
    const(PSTR)       Name;
    ///Type: <b>INT</b> The number of logical parameters in the function signature, not including the return value.
    int               FunctionParameterCount;
    ///Type: <b>BOOL</b> Indicates whether the function returns a value. <b>TRUE</b> indicates it returns a value;
    ///otherwise, <b>FALSE</b> (it is a subroutine).
    BOOL              HasReturn;
    ///Type: <b>BOOL</b> Indicates whether there is a Direct3D 10Level9 vertex shader blob. <b>TRUE</b> indicates there
    ///is a 10Level9 vertex shader blob; otherwise, <b>FALSE</b>.
    BOOL              Has10Level9VertexShader;
    ///Type: <b>BOOL</b> Indicates whether there is a Direct3D 10Level9 pixel shader blob. <b>TRUE</b> indicates there
    ///is a 10Level9 pixel shader blob; otherwise, <b>FALSE</b>.
    BOOL              Has10Level9PixelShader;
}

///Describes a function parameter.
struct D3D11_PARAMETER_DESC
{
    ///Type: <b>LPCSTR</b> The name of the function parameter.
    const(PSTR)         Name;
    ///Type: <b>LPCSTR</b> The HLSL semantic that is associated with this function parameter. This name includes the
    ///index, for example, SV_Target[n].
    const(PSTR)         SemanticName;
    ///Type: <b>D3D_SHADER_VARIABLE_TYPE</b> A D3D_SHADER_VARIABLE_TYPE-typed value that identifies the variable type
    ///for the parameter.
    D3D_SHADER_VARIABLE_TYPE Type;
    ///Type: <b>D3D_SHADER_VARIABLE_CLASS</b> A D3D_SHADER_VARIABLE_CLASS-typed value that identifies the variable class
    ///for the parameter as one of scalar, vector, matrix, object, and so on.
    D3D_SHADER_VARIABLE_CLASS Class;
    ///Type: <b>UINT</b> The number of rows for a matrix parameter.
    uint                Rows;
    ///Type: <b>UINT</b> The number of columns for a matrix parameter.
    uint                Columns;
    ///Type: <b>D3D_INTERPOLATION_MODE</b> A D3D_INTERPOLATION_MODE-typed value that identifies the interpolation mode
    ///for the parameter.
    D3D_INTERPOLATION_MODE InterpolationMode;
    ///Type: <b>D3D_PARAMETER_FLAGS</b> A combination of D3D_PARAMETER_FLAGS-typed values that are combined by using a
    ///bitwise OR operation. The resulting value specifies semantic flags for the parameter.
    D3D_PARAMETER_FLAGS Flags;
    ///Type: <b>UINT</b> The first input register for this parameter.
    uint                FirstInRegister;
    ///Type: <b>UINT</b> The first input register component for this parameter.
    uint                FirstInComponent;
    ///Type: <b>UINT</b> The first output register for this parameter.
    uint                FirstOutRegister;
    ///Type: <b>UINT</b> The first output register component for this parameter.
    uint                FirstOutComponent;
}

///Describes an instance of a vertex shader to trace.
struct D3D11_VERTEX_SHADER_TRACE_DESC
{
    ///The invocation number of the instance of the vertex shader.
    ulong Invocation;
}

///Describes an instance of a hull shader to trace.
struct D3D11_HULL_SHADER_TRACE_DESC
{
    ///The invocation number of the instance of the hull shader.
    ulong Invocation;
}

///Describes an instance of a domain shader to trace.
struct D3D11_DOMAIN_SHADER_TRACE_DESC
{
    ///The invocation number of the instance of the domain shader.
    ulong Invocation;
}

///Describes an instance of a geometry shader to trace.
struct D3D11_GEOMETRY_SHADER_TRACE_DESC
{
    ///The invocation number of the instance of the geometry shader.
    ulong Invocation;
}

///Describes an instance of a pixel shader to trace.
struct D3D11_PIXEL_SHADER_TRACE_DESC
{
    ///The invocation number of the instance of the pixel shader.
    ulong Invocation;
    ///The x-coordinate of the pixel.
    int   X;
    ///The y-coordinate of the pixel.
    int   Y;
    ///A value that describes a mask of pixel samples to trace. If this value specifies any of the masked samples, the
    ///trace is activated. The least significant bit (LSB) is sample 0. The non-multisample antialiasing (MSAA) counts
    ///as a sample count of 1; therefore, the LSB of <b>SampleMask</b> should be set. If set to zero, the pixel is not
    ///traced. However, pixel traces can still be enabled on an invocation basis.
    ulong SampleMask;
}

///Describes an instance of a compute shader to trace.
struct D3D11_COMPUTE_SHADER_TRACE_DESC
{
    ///The invocation number of the instance of the compute shader.
    ulong   Invocation;
    ///The SV_GroupThreadID to trace. This value identifies indexes of individual threads within a thread group that a
    ///compute shader executes in.
    uint[3] ThreadIDInGroup;
    ///The SV_GroupID to trace. This value identifies indexes of a thread group that the compute shader executes in.
    uint[3] ThreadGroupID;
}

///Describes a shader-trace object.
struct D3D11_SHADER_TRACE_DESC
{
    ///A D3D11_SHADER_TYPE-typed value that identifies the type of shader that the shader-trace object describes. This
    ///member also determines which shader-trace type to use in the following union.
    D3D11_SHADER_TYPE Type;
    ///A combination of the following flags that are combined by using a bitwise <b>OR</b> operation. The resulting
    ///value specifies how ID3D11ShaderTraceFactory::CreateShaderTrace creates the shader-trace object. <table> <tr>
    ///<th>Flag</th> <th>Description</th> </tr> <tr> <td>D3D11_SHADER_TRACE_FLAG_RECORD_REGISTER_WRITES (0x1)</td>
    ///<td>The shader trace object records register-writes.</td> </tr> <tr>
    ///<td>D3D11_SHADER_TRACE_FLAG_RECORD_REGISTER_READS (0x2)</td> <td>The shader trace object records
    ///register-reads.</td> </tr> </table>
    uint              Flags;
union
    {
        D3D11_VERTEX_SHADER_TRACE_DESC VertexShaderTraceDesc;
        D3D11_HULL_SHADER_TRACE_DESC HullShaderTraceDesc;
        D3D11_DOMAIN_SHADER_TRACE_DESC DomainShaderTraceDesc;
        D3D11_GEOMETRY_SHADER_TRACE_DESC GeometryShaderTraceDesc;
        D3D11_PIXEL_SHADER_TRACE_DESC PixelShaderTraceDesc;
        D3D11_COMPUTE_SHADER_TRACE_DESC ComputeShaderTraceDesc;
    }
}

///Specifies statistics about a trace.
struct D3D11_TRACE_STATS
{
    ///A D3D11_SHADER_TRACE_DESC structure that describes the shader trace object for which this structure specifies
    ///statistics.
    D3D11_SHADER_TRACE_DESC TraceDesc;
    ///The number of calls in the stamp for the trace. This value is always 1 for vertex shaders, hull shaders, domain
    ///shaders, geometry shaders, and compute shaders. This value is 4 for pixel shaders.
    ubyte        NumInvocationsInStamp;
    ///The index of the target stamp. This value is always 0 for vertex shaders, hull shaders, domain shaders, geometry
    ///shaders, and compute shaders. However, for pixel shaders this value indicates which of the four pixels in the
    ///stamp is the target for the trace. You can examine the traces for other pixels in the stamp to determine how
    ///derivative calculations occurred. You can make this determination by correlating the registers across traces.
    ubyte        TargetStampIndex;
    ///The total number of steps for the trace. This number is the same for all stamp calls.
    uint         NumTraceSteps;
    ///The component trace mask for each input v
    ubyte[32]    InputMask;
    ///The component trace mask for each output o
    ubyte[32]    OutputMask;
    ///The number of temps, that is, 4x32 bit r
    ushort       NumTemps;
    ///The maximum index
    ushort       MaxIndexableTempIndex;
    ///The number of temps for each indexable temp x
    ushort[4096] IndexableTempSize;
    ///The number of 4x32 bit values (if any) that are in the immediate constant buffer.
    ushort       ImmediateConstantBufferSize;
    uint[8]      PixelPosition;
    ///<div class="alert"><b>Note</b> This member is for pixel shaders only, [stampIndex].</div> <div> </div> A mask
    ///that indicates which MSAA samples are covered for each stamp. This coverage occurs before alpha-to-coverage,
    ///depth, and stencil operations are performed on the pixel. For non-MSAA, examine the least significant bit (LSB).
    ///This mask can be 0 for pixels that are only executed to support derivatives for neighboring pixels.
    ulong[4]     PixelCoverageMask;
    ///<div class="alert"><b>Note</b> This member is for pixel shaders only, [stampIndex].</div> <div> </div> A mask
    ///that indicates discarded samples. If the pixel shader runs at pixel-frequency, "discard" turns off all the
    ///samples. If all the samples are off, the following four mask members are also 0.
    ulong[4]     PixelDiscardedMask;
    ///<div class="alert"><b>Note</b> This member is for pixel shaders only, [stampIndex].</div> <div> </div> A mask
    ///that indicates the MSAA samples that are covered. For non-MSAA, examine the LSB.
    ulong[4]     PixelCoverageMaskAfterShader;
    ///<div class="alert"><b>Note</b> This member is for pixel shaders only, [stampIndex].</div> <div> </div> A mask
    ///that indicates the MSAA samples that are covered after alpha-to-coverage+sampleMask, but before depth and
    ///stencil. For non-MSAA, examine the LSB.
    ulong[4]     PixelCoverageMaskAfterA2CSampleMask;
    ///<div class="alert"><b>Note</b> This member is for pixel shaders only, [stampIndex].</div> <div> </div> A mask
    ///that indicates the MSAA samples that are covered after alpha-to-coverage+sampleMask+depth, but before stencil.
    ///For non-MSAA, examine the LSB.
    ulong[4]     PixelCoverageMaskAfterA2CSampleMaskDepth;
    ///<div class="alert"><b>Note</b> This member is for pixel shaders only, [stampIndex].</div> <div> </div> A mask
    ///that indicates the MSAA samples that are covered after alpha-to-coverage+sampleMask+depth+stencil. For non-MSAA,
    ///examine the LSB.
    ulong[4]     PixelCoverageMaskAfterA2CSampleMaskDepthStencil;
    ///A value that specifies whether this trace is for a pixel shader that outputs the oDepth register. TRUE indicates
    ///that the pixel shader outputs the oDepth register; otherwise, FALSE.
    BOOL         PSOutputsDepth;
    ///A value that specifies whether this trace is for a pixel shader that outputs the oMask register. TRUE indicates
    ///that the pixel shader outputs the oMask register; otherwise, FALSE.
    BOOL         PSOutputsMask;
    ///A D3D11_TRACE_GS_INPUT_PRIMITIVE-typed value that identifies the type of geometry shader input primitive. That
    ///is, this value identifies: {point, line, triangle, line_adj, triangle_adj} or the number of vertices: 1, 2, 3, 4,
    ///or 6 respectively. For example, for a line, input v[][
    D3D11_TRACE_GS_INPUT_PRIMITIVE GSInputPrimitive;
    ///A value that specifies whether this trace is for a geometry shader that inputs the PrimitiveID register. TRUE
    ///indicates that the geometry shader inputs the PrimitiveID register; otherwise, FALSE.
    BOOL         GSInputsPrimitiveID;
    ///<div class="alert"><b>Note</b> This member is for hull shaders only.</div> <div> </div> The component trace mask
    ///for the hull-shader output. For information about D3D11_TRACE_COMPONENT_MASK, see D3D11_TRACE_VALUE. The
    ///D3D11_TRACE_INPUT_PRIMITIVE_ID_REGISTER value is available through a call to the
    ///ID3D11ShaderTrace::GetInitialRegisterContents method.
    ubyte[32]    HSOutputPatchConstantMask;
    ///<div class="alert"><b>Note</b> This member is for domain shaders only.</div> <div> </div> The component trace
    ///mask for the domain-shader input. For information about D3D11_TRACE_COMPONENT_MASK, see D3D11_TRACE_VALUE. The
    ///following values are available through a call to the ID3D11ShaderTrace::GetInitialRegisterContents method: <ul>
    ///<li>D3D11_TRACE_INPUT_PRIMITIVE_ID_REGISTER</li> <li>D3D11_TRACE_INPUT_DOMAIN_POINT_REGISTER</li> </ul>
    ubyte[32]    DSInputPatchConstantMask;
}

///Describes a trace value.
struct D3D11_TRACE_VALUE
{
    ///An array of bits that make up the trace value. The [0] element is X. <div class="alert"><b>Note</b> This member
    ///can hold <b>float</b>, <b>UINT</b>, or <b>INT</b> data. The elements are specified as <b>UINT</b> rather than
    ///using a union to minimize the risk of x86 SNaN-&gt;QNaN quashing during float assignment. If the bits are
    ///displayed, they can be interpreted as <b>float</b> at the last moment. </div> <div> </div>
    uint[4] Bits;
    ///A combination of the following component values that are combined by using a bitwise <b>OR</b> operation. The
    ///resulting value specifies the component trace mask. <table> <tr> <th>Flag</th> <th>Description</th> </tr> <tr>
    ///<td>D3D11_TRACE_COMPONENT_X (0x1)</td> <td>The x component of the trace mask.</td> </tr> <tr>
    ///<td>D3D11_TRACE_COMPONENT_Y (0x2)</td> <td>The y component of the trace mask.</td> </tr> <tr>
    ///<td>D3D11_TRACE_COMPONENT_Z (0x4)</td> <td>The depth z component of the trace mask.</td> </tr> <tr>
    ///<td>D3D11_TRACE_COMPONENT_W (0x8)</td> <td>The depth w component of the trace mask.</td> </tr> </table> Ignore
    ///unmasked values, particularly if deltas are accumulated.
    ubyte   ValidMask;
}

///Describes a trace register.
struct D3D11_TRACE_REGISTER
{
    ///A D3D11_TRACE_REGISTER_TYPE-typed value that identifies the type of register that the shader-trace object uses.
    D3D11_TRACE_REGISTER_TYPE RegType;
union
    {
        ushort    Index1D;
        ushort[2] Index2D;
    }
    ///The index of the operand, which starts from 0.
    ubyte OperandIndex;
    ///A combination of the following flags that are combined by using a bitwise <b>OR</b> operation. The resulting
    ///value specifies more about the trace register. <table> <tr> <th>Flag</th> <th>Description</th> </tr> <tr>
    ///<td>D3D11_TRACE_REGISTER_FLAGS_RELATIVE_INDEXING (0x1)</td> <td>Access to the register is part of the relative
    ///indexing of a register.</td> </tr> </table>
    ubyte Flags;
}

///Describes a trace step, which is an instruction.
struct D3D11_TRACE_STEP
{
    ///A number that identifies the instruction, as an offset into the executable instructions that are present in the
    ///shader. HLSL debugging information uses the same convention. Therefore, HLSL instructions are matched to a set of
    ///IDs. You can then map an ID to a disassembled string that can be displayed to the user.
    uint   ID;
    ///A value that specifies whether the instruction is active. This value is TRUE if something happened; therefore,
    ///you should parse other data in this structure. Otherwise, nothing happened; for example, if an instruction is
    ///disabled due to flow control even though other pixels in the stamp execute it.
    BOOL   InstructionActive;
    ///The number of registers for the instruction that are written to. The range of registers is
    ///[0...NumRegistersWritten-1]. You can pass a register number to the <i>writtenRegisterIndex</i> parameter of
    ///ID3D11ShaderTrace::GetWrittenRegister to retrieve individual write-register information.
    ubyte  NumRegistersWritten;
    ///The number of registers for the instruction that are read from. The range of registers is
    ///[0...NumRegistersRead-1]. You can pass a register number to the <i>readRegisterIndex</i> parameter of
    ///ID3D11ShaderTrace::GetReadRegister to retrieve individual read-register information.
    ubyte  NumRegistersRead;
    ///A combination of the following values that are combined by using a bitwise <b>OR</b> operation. The resulting
    ///value specifies the mask for the trace miscellaneous operations. These flags indicate the possible effect of a
    ///shader operation when it does not write any output registers. For example, the "add r0, r1 ,r2" operation writes
    ///to the r0 register; therefore, you can look at the trace-written register's information to determine what the
    ///operation changed. However, some shader instructions do not write any registers, but still effect those
    ///registers. <table> <tr> <th>Flag</th> <th>Description</th> </tr> <tr> <td>D3D11_TRACE_MISC_GS_EMIT (0x1)</td>
    ///<td>The operation was a geometry shader data emit.</td> </tr> <tr> <td>D3D11_TRACE_MISC_GS_CUT (0x2)</td> <td>The
    ///operation was a geometry shader strip cut.</td> </tr> <tr> <td>D3D11_TRACE_MISC_PS_DISCARD (0x4)</td> <td>The
    ///operation was a pixel shader discard, which rejects the pixel.</td> </tr> <tr>
    ///<td>D3D11_TRACE_MISC_GS_EMIT_STREAM (0x8)</td> <td>Same as D3D11_TRACE_MISC_GS_EMIT, except in shader model 5
    ///where you can specify a particular stream to emit to.</td> </tr> <tr> <td>D3D11_TRACE_MISC_GS_CUT_STREAM
    ///(0x10)</td> <td>Same as D3D11_TRACE_MISC_GS_CUT, except in shader model 5 where you can specify a particular
    ///stream to strip cut.</td> </tr> <tr> <td>D3D11_TRACE_MISC_HALT (0x20)</td> <td>The operation was a shader halt
    ///instruction, which stops shader execution. The HLSL abort intrinsic function causes a halt.</td> </tr> <tr>
    ///<td>D3D11_TRACE_MISC_MESSAGE (0x40)</td> <td>The operation was a shader message output, which can be logged to
    ///the information queue. The HLSL printf and errorf intrinsic functions cause messages.</td> </tr> </table> If the
    ///<b>NumRegistersWritten</b> member is 0, examine this member although this member still might be empty (0).
    ushort MiscOperations;
    ///A number that specifies the type of instruction (for example, add, mul, and so on). You can ignore this member if
    ///you do not know the number for the instruction type. This member offers a minor convenience at the cost of
    ///bloating the trace slightly. You can use the <b>ID</b> member and map back to the original shader code to
    ///retrieve the full information about the instruction.
    uint   OpcodeType;
    ///The global cycle count for this step. You can use this member to correlate parallel thread execution via multiple
    ///simultaneous traces, for example, for the compute shader. <div class="alert"><b>Note</b> Multiple threads at the
    ///same point in execution might log the same <b>CurrentGlobalCycle</b>. </div> <div> </div>
    ulong  CurrentGlobalCycle;
}

///Describes an FFT.
struct D3DX11_FFT_DESC
{
    ///Type: <b>UINT</b> Number of dimension in the FFT.
    uint                 NumDimensions;
    ///Type: <b>UINT[D3DX11_FFT_MAX_DIMENSIONS]</b> Length of each dimension in the FFT.
    uint[32]             ElementLengths;
    ///Type: <b>UINT</b> Combination of D3DX11_FFT_DIM_MASK flags indicating the dimensions to transform.
    uint                 DimensionMask;
    ///Type: <b>D3DX11_FFT_DATA_TYPE</b> D3DX11_FFT_DATA_TYPE flag indicating the type of data being transformed.
    D3DX11_FFT_DATA_TYPE Type;
}

///Describes buffer requirements for an FFT.
struct D3DX11_FFT_BUFFER_INFO
{
    ///Type: <b>UINT</b> Number of temporary buffers needed. Allowed range is 0 to <b>D3DX11_FFT_MAX_TEMP_BUFFERS</b>.
    uint    NumTempBufferSizes;
    ///Type: <b>UINT[D3DX11_FFT_MAX_TEMP_BUFFERS]</b> Minimum sizes (in FLOATs) of temporary buffers.
    uint[4] TempBufferFloatSizes;
    ///Type: <b>UINT</b> Number of precompute buffers required. Allowed range is 0 to
    ///<b>D3DX11_FFT_MAX_PRECOMPUTE_BUFFERS</b>.
    uint    NumPrecomputeBufferSizes;
    ///Type: <b>UINT[D3DX11_FFT_MAX_PRECOMPUTE_BUFFERS]</b> Minimum sizes (in FLOATs) for precompute buffers.
    uint[4] PrecomputeBufferFloatSizes;
}

// Functions

///Creates a device that represents the display adapter.
///Params:
///    pAdapter = Type: <b>IDXGIAdapter*</b> A pointer to the video adapter to use when creating a device. Pass <b>NULL</b> to use
///               the default adapter, which is the first adapter that is enumerated by IDXGIFactory1::EnumAdapters. <div
///               class="alert"><b>Note</b> Do not mix the use of DXGI 1.0 (IDXGIFactory) and DXGI 1.1 (IDXGIFactory1) in an
///               application. Use <b>IDXGIFactory</b> or <b>IDXGIFactory1</b>, but not both in an application. </div> <div> </div>
///    DriverType = Type: <b>D3D_DRIVER_TYPE</b> The D3D_DRIVER_TYPE, which represents the driver type to create.
///    Software = Type: <b>HMODULE</b> A handle to a DLL that implements a software rasterizer. If <i>DriverType</i> is
///               <i>D3D_DRIVER_TYPE_SOFTWARE</i>, <i>Software</i> must not be <b>NULL</b>. Get the handle by calling LoadLibrary,
///               LoadLibraryEx , or GetModuleHandle.
///    Flags = Type: <b>UINT</b> The runtime layers to enable (see D3D11_CREATE_DEVICE_FLAG); values can be bitwise OR'd
///            together.
///    pFeatureLevels = Type: <b>const D3D_FEATURE_LEVEL*</b> A pointer to an array of D3D_FEATURE_LEVELs, which determine the order of
///                     feature levels to attempt to create. If <i>pFeatureLevels</i> is set to <b>NULL</b>, this function uses the
///                     following array of feature levels: ``` { D3D_FEATURE_LEVEL_11_0, D3D_FEATURE_LEVEL_10_1, D3D_FEATURE_LEVEL_10_0,
///                     D3D_FEATURE_LEVEL_9_3, D3D_FEATURE_LEVEL_9_2, D3D_FEATURE_LEVEL_9_1, }; ``` <div class="alert"><b>Note</b> If the
///                     Direct3D 11.1 runtime is present on the computer and <i>pFeatureLevels</i> is set to <b>NULL</b>, this function
///                     won't create a D3D_FEATURE_LEVEL_11_1 device. To create a <b>D3D_FEATURE_LEVEL_11_1</b> device, you must
///                     explicitly provide a <b>D3D_FEATURE_LEVEL</b> array that includes <b>D3D_FEATURE_LEVEL_11_1</b>. If you provide a
///                     <b>D3D_FEATURE_LEVEL</b> array that contains <b>D3D_FEATURE_LEVEL_11_1</b> on a computer that doesn't have the
///                     Direct3D 11.1 runtime installed, this function immediately fails with E_INVALIDARG. </div> <div> </div>
///    FeatureLevels = Type: <b>UINT</b> The number of elements in <i>pFeatureLevels</i>.
///    SDKVersion = Type: <b>UINT</b> The SDK version; use <i>D3D11_SDK_VERSION</i>.
///    ppDevice = Type: <b>ID3D11Device**</b> Returns the address of a pointer to an ID3D11Device object that represents the device
///               created. If this parameter is <b>NULL</b>, no ID3D11Device will be returned.
///    pFeatureLevel = Type: <b>D3D_FEATURE_LEVEL*</b> If successful, returns the first D3D_FEATURE_LEVEL from the <i>pFeatureLevels</i>
///                    array which succeeded. Supply <b>NULL</b> as an input if you don't need to determine which feature level is
///                    supported.
///    ppImmediateContext = Type: <b>ID3D11DeviceContext**</b> Returns the address of a pointer to an ID3D11DeviceContext object that
///                         represents the device context. If this parameter is <b>NULL</b>, no ID3D11DeviceContext will be returned.
///Returns:
///    Type: <b>HRESULT</b> This method can return one of the Direct3D 11 Return Codes. This method returns E_INVALIDARG
///    if you set the <i>pAdapter</i> parameter to a non-<b>NULL</b> value and the <i>DriverType</i> parameter to the
///    D3D_DRIVER_TYPE_HARDWARE value. This method returns DXGI_ERROR_SDK_COMPONENT_MISSING if you specify
///    D3D11_CREATE_DEVICE_DEBUG in <i>Flags</i> and the incorrect version of the debug layer is installed on your
///    computer. Install the latest Windows SDK to get the correct version.
///    
@DllImport("d3d11")
HRESULT D3D11CreateDevice(IDXGIAdapter pAdapter, D3D_DRIVER_TYPE DriverType, ptrdiff_t Software, 
                          D3D11_CREATE_DEVICE_FLAG Flags, const(D3D_FEATURE_LEVEL)* pFeatureLevels, 
                          uint FeatureLevels, uint SDKVersion, ID3D11Device* ppDevice, 
                          D3D_FEATURE_LEVEL* pFeatureLevel, ID3D11DeviceContext* ppImmediateContext);

///Creates a device that represents the display adapter and a swap chain used for rendering.
///Params:
///    pAdapter = Type: <b>IDXGIAdapter*</b> A pointer to the video adapter to use when creating a device. Pass <b>NULL</b> to use
///               the default adapter, which is the first adapter enumerated by IDXGIFactory1::EnumAdapters. <div
///               class="alert"><b>Note</b> Do not mix the use of DXGI 1.0 (IDXGIFactory) and DXGI 1.1 (IDXGIFactory1) in an
///               application. Use <b>IDXGIFactory</b> or <b>IDXGIFactory1</b>, but not both in an application. </div> <div> </div>
///    DriverType = Type: <b>D3D_DRIVER_TYPE</b> The D3D_DRIVER_TYPE, which represents the driver type to create.
///    Software = Type: <b>HMODULE</b> A handle to a DLL that implements a software rasterizer. If <i>DriverType</i> is
///               <i>D3D_DRIVER_TYPE_SOFTWARE</i>, <i>Software</i> must not be <b>NULL</b>. Get the handle by calling LoadLibrary,
///               LoadLibraryEx , or GetModuleHandle. The value should be non-<b>NULL</b>when D3D_DRIVER_TYPE is
///               <b>D3D_DRIVER_TYPE_SOFTWARE</b> and <b>NULL</b> otherwise.
///    Flags = Type: <b>UINT</b> The runtime layers to enable (see D3D11_CREATE_DEVICE_FLAG); values can be bitwise OR'd
///            together.
///    pFeatureLevels = Type: <b>const D3D_FEATURE_LEVEL*</b> A pointer to an array of D3D_FEATURE_LEVELs, which determine the order of
///                     feature levels to attempt to create. If <i>pFeatureLevels</i> is set to <b>NULL</b>, this function uses the
///                     following array of feature levels: ``` { D3D_FEATURE_LEVEL_11_0, D3D_FEATURE_LEVEL_10_1, D3D_FEATURE_LEVEL_10_0,
///                     D3D_FEATURE_LEVEL_9_3, D3D_FEATURE_LEVEL_9_2, D3D_FEATURE_LEVEL_9_1, }; ``` <div class="alert"><b>Note</b> If the
///                     Direct3D 11.1 runtime is present on the computer and <i>pFeatureLevels</i> is set to <b>NULL</b>, this function
///                     won't create a D3D_FEATURE_LEVEL_11_1 device. To create a <b>D3D_FEATURE_LEVEL_11_1</b> device, you must
///                     explicitly provide a <b>D3D_FEATURE_LEVEL</b> array that includes <b>D3D_FEATURE_LEVEL_11_1</b>. If you provide a
///                     <b>D3D_FEATURE_LEVEL</b> array that contains <b>D3D_FEATURE_LEVEL_11_1</b> on a computer that doesn't have the
///                     Direct3D 11.1 runtime installed, this function immediately fails with E_INVALIDARG. </div> <div> </div>
///    FeatureLevels = Type: <b>UINT</b> The number of elements in <i>pFeatureLevels</i>.
///    SDKVersion = Type: <b>UINT</b> The SDK version; use <i>D3D11_SDK_VERSION</i>.
///    pSwapChainDesc = Type: <b>const DXGI_SWAP_CHAIN_DESC*</b> A pointer to a swap chain description (see DXGI_SWAP_CHAIN_DESC) that
///                     contains initialization parameters for the swap chain.
///    ppSwapChain = Type: <b>IDXGISwapChain**</b> Returns the address of a pointer to the IDXGISwapChain object that represents the
///                  swap chain used for rendering.
///    ppDevice = Type: <b>ID3D11Device**</b> Returns the address of a pointer to an ID3D11Device object that represents the device
///               created. If this parameter is <b>NULL</b>, no ID3D11Device will be returned'.
///    pFeatureLevel = Type: <b>D3D_FEATURE_LEVEL*</b> Returns a pointer to a D3D_FEATURE_LEVEL, which represents the first element in
///                    an array of feature levels supported by the device. Supply <b>NULL</b> as an input if you don't need to determine
///                    which feature level is supported.
///    ppImmediateContext = Type: <b>ID3D11DeviceContext**</b> Returns the address of a pointer to an ID3D11DeviceContext object that
///                         represents the device context. If this parameter is <b>NULL</b>, no ID3D11DeviceContext will be returned.
///Returns:
///    Type: <b>HRESULT</b> This method can return one of the Direct3D 11 Return Codes. This method returns
///    DXGI_ERROR_NOT_CURRENTLY_AVAILABLE if you call it in a Session 0 process. This method returns E_INVALIDARG if you
///    set the <i>pAdapter</i> parameter to a non-<b>NULL</b> value and the <i>DriverType</i> parameter to the
///    D3D_DRIVER_TYPE_HARDWARE value. This method returns DXGI_ERROR_SDK_COMPONENT_MISSING if you specify
///    D3D11_CREATE_DEVICE_DEBUG in <i>Flags</i> and the incorrect version of the debug layer is installed on your
///    computer. Install the latest Windows SDK to get the correct version.
///    
@DllImport("d3d11")
HRESULT D3D11CreateDeviceAndSwapChain(IDXGIAdapter pAdapter, D3D_DRIVER_TYPE DriverType, ptrdiff_t Software, 
                                      D3D11_CREATE_DEVICE_FLAG Flags, const(D3D_FEATURE_LEVEL)* pFeatureLevels, 
                                      uint FeatureLevels, uint SDKVersion, 
                                      const(DXGI_SWAP_CHAIN_DESC)* pSwapChainDesc, IDXGISwapChain* ppSwapChain, 
                                      ID3D11Device* ppDevice, D3D_FEATURE_LEVEL* pFeatureLevel, 
                                      ID3D11DeviceContext* ppImmediateContext);

///Disassembles a section of compiled Microsoft High Level Shader Language (HLSL) code that is specified by shader trace
///steps.
///Params:
///    pSrcData = Type: <b>LPCVOID</b> A pointer to compiled shader data.
///    SrcDataSize = Type: <b>SIZE_T</b> The size, in bytes, of the block of memory that pSrcData points to.
///    pTrace = Type: <b>ID3D11ShaderTrace*</b> A pointer to the ID3D11ShaderTrace interface for the shader trace information
///             object.
///    StartStep = Type: <b>UINT</b> The number of the step in the trace from which D3DDisassemble11Trace starts the disassembly.
///    NumSteps = Type: <b>UINT</b> The number of trace steps to disassemble.
///    Flags = Type: <b>UINT</b> A combination of zero or more of the following flags that are combined by using a bitwise OR
///            operation. The resulting value specifies how D3DDisassemble11Trace disassembles the compiled shader data. <table>
///            <tr> <th>Flag</th> <th>Description</th> </tr> <tr> <td>D3D_DISASM_ENABLE_COLOR_CODE (0x01)</td> <td> Enable the
///            output of color codes.</td> </tr> <tr> <td>D3D_DISASM_ENABLE_DEFAULT_VALUE_PRINTS (0x02)</td> <td> Enable the
///            output of default values.</td> </tr> <tr> <td>D3D_DISASM_ENABLE_INSTRUCTION_NUMBERING (0x04)</td> <td> Enable
///            instruction numbering.</td> </tr> <tr> <td>D3D_DISASM_ENABLE_INSTRUCTION_CYCLE (0x08)</td> <td> No effect.</td>
///            </tr> <tr> <td>D3D_DISASM_DISABLE_DEBUG_INFO (0x10)</td> <td> Disable the output of debug information.</td> </tr>
///            <tr> <td>D3D_DISASM_ENABLE_INSTRUCTION_OFFSET (0x20)</td> <td> Enable the output of instruction offsets.</td>
///            </tr> <tr> <td>D3D_DISASM_INSTRUCTION_ONLY (0x40)</td> <td> Enable the output of the instruction cycle per step
///            in D3DDisassemble11Trace. This flag is similar to the D3D_DISASM_ENABLE_INSTRUCTION_NUMBERING and
///            D3D_DISASM_ENABLE_INSTRUCTION_OFFSET flags. This flag has no effect in the D3DDisassembleRegion function. Cycle
///            information comes from the trace; therefore, cycle information is available only in the trace disassembly. </td>
///            </tr> </table>
///    ppDisassembly = Type: <b>ID3D10Blob**</b> A pointer to a buffer that receives the ID3DBlob interface that accesses the
///                    disassembled HLSL code.
///Returns:
///    Type: <b>HRESULT</b> This method returns an HRESULT error code.
///    
@DllImport("D3DCOMPILER_47")
HRESULT D3DDisassemble11Trace(const(void)* pSrcData, size_t SrcDataSize, ID3D11ShaderTrace pTrace, uint StartStep, 
                              uint NumSteps, uint Flags, ID3DBlob* ppDisassembly);

///Creates a scan context.
///Params:
///    pDeviceContext = Type: <b>ID3D11DeviceContext*</b> The ID3D11DeviceContext the scan is associated with.
///    MaxElementScanSize = Type: <b>UINT</b> Maximum single scan size, in elements (FLOAT, UINT, or INT).
///    MaxScanCount = Type: <b>UINT</b> Maximum number of scans in multiscan.
///    ppScan = Type: <b>ID3DX11Scan**</b> Pointer to a ID3DX11Scan Interface pointer that will be set to the created interface
///             object.
///Returns:
///    Type: <b>HRESULT</b> The return value is one of the values listed in Direct3D 11 Return Codes.
///    
@DllImport("d3dcsx")
HRESULT D3DX11CreateScan(ID3D11DeviceContext pDeviceContext, uint MaxElementScanSize, uint MaxScanCount, 
                         ID3DX11Scan* ppScan);

///Creates a segmented scan context.
///Params:
///    pDeviceContext = Type: <b>ID3D11DeviceContext*</b> Pointer to an ID3D11DeviceContext interface.
///    MaxElementScanSize = Type: <b>UINT</b> Maximum single scan size, in elements (FLOAT, UINT, or INT).
///    ppScan = Type: <b>ID3DX11SegmentedScan**</b> Pointer to a ID3DX11SegmentedScan Interface pointer that will be set to the
///             created interface object.
///Returns:
///    Type: <b>HRESULT</b> The return value is one of the values listed in Direct3D 11 Return Codes.
///    
@DllImport("d3dcsx")
HRESULT D3DX11CreateSegmentedScan(ID3D11DeviceContext pDeviceContext, uint MaxElementScanSize, 
                                  ID3DX11SegmentedScan* ppScan);

///Creates an ID3DX11FFT COM interface object.
///Params:
///    pDeviceContext = Type: <b>ID3D11DeviceContext*</b> A pointer to the ID3D11DeviceContext interface to use for the FFT.
///    pDesc = Type: <b>const D3DX11_FFT_DESC*</b> A pointer to a D3DX11_FFT_DESC structure that describes the shape of the FFT
///            data as well as the scaling factors that should be used for forward and inverse transforms.
///    Flags = Type: <b>UINT</b> Flags that affect the behavior of the FFT, can be 0 or a combination of flags from
///            D3DX11_FFT_CREATE_FLAG.
///    pBufferInfo = Type: <b>D3DX11_FFT_BUFFER_INFO*</b> A pointer to a D3DX11_FFT_BUFFER_INFO structure that receives the buffer
///                  requirements to execute the FFT algorithms. Use this info to allocate raw buffers of the specified (or larger)
///                  sizes and then call the ID3DX11FFT::AttachBuffersAndPrecompute method to register the buffers with the FFT
///                  object.
///    ppFFT = Type: <b>ID3DX11FFT**</b> A pointer to a variable that receives a pointer to the ID3DX11FFT interface for the
///            created FFT object.
///Returns:
///    Type: <b>HRESULT</b> One of the Direct3D 11 Return Codes.
///    
@DllImport("d3dcsx")
HRESULT D3DX11CreateFFT(ID3D11DeviceContext pDeviceContext, const(D3DX11_FFT_DESC)* pDesc, uint Flags, 
                        D3DX11_FFT_BUFFER_INFO* pBufferInfo, ID3DX11FFT* ppFFT);

///Creates an ID3DX11FFT COM interface object.
///Params:
///    pDeviceContext = Type: <b>ID3D11DeviceContext*</b> A pointer to the ID3D11DeviceContext interface to use for the FFT.
///    X = Type: <b>UINT</b> Length of the first dimension of the FFT.
///    Flags = Type: <b>UINT</b> Flags that affect the behavior of the FFT, can be 0 or a combination of flags from
///            D3DX11_FFT_CREATE_FLAG.
///    pBufferInfo = Type: <b>D3DX11_FFT_BUFFER_INFO*</b> A pointer to a D3DX11_FFT_BUFFER_INFO structure that receives the buffer
///                  requirements to execute the FFT algorithms. Use this info to allocate raw buffers of the specified (or larger)
///                  sizes and then call the ID3DX11FFT::AttachBuffersAndPrecompute method to register the buffers with the FFT
///                  object.
///    ppFFT = Type: <b>ID3DX11FFT**</b> A pointer to a variable that receives a pointer to the ID3DX11FFT interface for the
///            created FFT object.
///Returns:
///    Type: <b>HRESULT</b> The return value is one of the values listed in Direct3D 11 Return Codes.
///    
@DllImport("d3dcsx")
HRESULT D3DX11CreateFFT1DReal(ID3D11DeviceContext pDeviceContext, uint X, uint Flags, 
                              D3DX11_FFT_BUFFER_INFO* pBufferInfo, ID3DX11FFT* ppFFT);

///Creates an ID3DX11FFT COM interface object.
///Params:
///    pDeviceContext = Type: <b>ID3D11DeviceContext*</b> A pointer to the ID3D11DeviceContext interface to use for the FFT.
///    X = Type: <b>UINT</b> Length of the first dimension of the FFT.
///    Flags = Type: <b>UINT</b> Flags that affect the behavior of the FFT, can be 0 or a combination of flags from
///            D3DX11_FFT_CREATE_FLAG.
///    pBufferInfo = Type: <b>D3DX11_FFT_BUFFER_INFO*</b> A pointer to a D3DX11_FFT_BUFFER_INFO structure that receives the buffer
///                  requirements to execute the FFT algorithms. Use this info to allocate raw buffers of the specified (or larger)
///                  sizes and then call the ID3DX11FFT::AttachBuffersAndPrecompute method to register the buffers with the FFT
///                  object.
///    ppFFT = Type: <b>ID3DX11FFT**</b> A pointer to a variable that receives a pointer to the ID3DX11FFT interface for the
///            created FFT object.
///Returns:
///    Type: <b>HRESULT</b> The return value is one of the values listed in Direct3D 11 Return Codes.
///    
@DllImport("d3dcsx")
HRESULT D3DX11CreateFFT1DComplex(ID3D11DeviceContext pDeviceContext, uint X, uint Flags, 
                                 D3DX11_FFT_BUFFER_INFO* pBufferInfo, ID3DX11FFT* ppFFT);

///Creates an ID3DX11FFT COM interface object.
///Params:
///    pDeviceContext = Type: <b>ID3D11DeviceContext*</b> A pointer to the ID3D11DeviceContext interface to use for the FFT.
///    X = Type: <b>UINT</b> Length of the first dimension of the FFT.
///    Y = Type: <b>UINT</b> Length of the second dimension of the FFT.
///    Flags = Type: <b>UINT</b> Flags that affect the behavior of the FFT, can be 0 or a combination of flags from
///            D3DX11_FFT_CREATE_FLAG.
///    pBufferInfo = Type: <b>D3DX11_FFT_BUFFER_INFO*</b> A pointer to a D3DX11_FFT_BUFFER_INFO structure that receives the buffer
///                  requirements to execute the FFT algorithms. Use this info to allocate raw buffers of the specified (or larger)
///                  sizes and then call the ID3DX11FFT::AttachBuffersAndPrecompute method to register the buffers with the FFT
///                  object.
///    ppFFT = Type: <b>ID3DX11FFT**</b> A pointer to a variable that receives a pointer to the ID3DX11FFT interface for the
///            created FFT object.
///Returns:
///    Type: <b>HRESULT</b> The return value is one of the values listed in Direct3D 11 Return Codes.
///    
@DllImport("d3dcsx")
HRESULT D3DX11CreateFFT2DReal(ID3D11DeviceContext pDeviceContext, uint X, uint Y, uint Flags, 
                              D3DX11_FFT_BUFFER_INFO* pBufferInfo, ID3DX11FFT* ppFFT);

///Creates an ID3DX11FFT COM interface object.
///Params:
///    pDeviceContext = Type: <b>ID3D11DeviceContext*</b> A pointer to the ID3D11DeviceContext interface to use for the FFT.
///    X = Type: <b>UINT</b> Length of the first dimension of the FFT.
///    Y = Type: <b>UINT</b> Length of the second dimension of the FFT.
///    Flags = Type: <b>UINT</b> Flags that affect the behavior of the FFT, can be 0 or a combination of flags from
///            D3DX11_FFT_CREATE_FLAG.
///    pBufferInfo = Type: <b>D3DX11_FFT_BUFFER_INFO*</b> A pointer to a D3DX11_FFT_BUFFER_INFO structure that receives the buffer
///                  requirements to execute the FFT algorithms. Use this info to allocate raw buffers of the specified (or larger)
///                  sizes and then call the ID3DX11FFT::AttachBuffersAndPrecompute method to register the buffers with the FFT
///                  object.
///    ppFFT = Type: <b>ID3DX11FFT**</b> A pointer to a variable that receives a pointer to the ID3DX11FFT interface for the
///            created FFT object.
///Returns:
///    Type: <b>HRESULT</b> The return value is one of the values listed in Direct3D 11 Return Codes.
///    
@DllImport("d3dcsx")
HRESULT D3DX11CreateFFT2DComplex(ID3D11DeviceContext pDeviceContext, uint X, uint Y, uint Flags, 
                                 D3DX11_FFT_BUFFER_INFO* pBufferInfo, ID3DX11FFT* ppFFT);

///Creates an ID3DX11FFT COM interface object.
///Params:
///    pDeviceContext = Type: <b>ID3D11DeviceContext*</b> A pointer to the ID3D11DeviceContext interface to use for the FFT.
///    X = Type: <b>UINT</b> Length of the first dimension of the FFT.
///    Y = Type: <b>UINT</b> Length of the second dimension of the FFT.
///    Z = Type: <b>UINT</b> Length of the third dimension of the FFT.
///    Flags = Type: <b>UINT</b> Flags that affect the behavior of the FFT, can be 0 or a combination of flags from
///            D3DX11_FFT_CREATE_FLAG.
///    pBufferInfo = Type: <b>D3DX11_FFT_BUFFER_INFO*</b> A pointer to a D3DX11_FFT_BUFFER_INFO structure that receives the buffer
///                  requirements to execute the FFT algorithms. Use this info to allocate raw buffers of the specified (or larger)
///                  sizes and then call the ID3DX11FFT::AttachBuffersAndPrecompute method to register the buffers with the FFT
///                  object.
///    ppFFT = Type: <b>ID3DX11FFT**</b> A pointer to a variable that receives a pointer to the ID3DX11FFT interface for the
///            created FFT object.
///Returns:
///    Type: <b>HRESULT</b> The return value is one of the values listed in Direct3D 11 Return Codes.
///    
@DllImport("d3dcsx")
HRESULT D3DX11CreateFFT3DReal(ID3D11DeviceContext pDeviceContext, uint X, uint Y, uint Z, uint Flags, 
                              D3DX11_FFT_BUFFER_INFO* pBufferInfo, ID3DX11FFT* ppFFT);

///Creates an ID3DX11FFT COM interface object.
///Params:
///    pDeviceContext = Type: <b>ID3D11DeviceContext*</b> A pointer to the ID3D11DeviceContext interface to use for the FFT.
///    X = Type: <b>UINT</b> Length of the first dimension of the FFT.
///    Y = Type: <b>UINT</b> Length of the second dimension of the FFT.
///    Z = Type: <b>UINT</b> Length of the third dimension of the FFT.
///    Flags = Type: <b>UINT</b> Flags that affect the behavior of the FFT, can be 0 or a combination of flags from
///            D3DX11_FFT_CREATE_FLAG.
///    pBufferInfo = Type: <b>D3DX11_FFT_BUFFER_INFO*</b> A pointer to a D3DX11_FFT_BUFFER_INFO structure that receives the buffer
///                  requirements to execute the FFT algorithms. Use this info to allocate raw buffers of the specified (or larger)
///                  sizes and then call the ID3DX11FFT::AttachBuffersAndPrecompute method to register the buffers with the FFT
///                  object.
///    ppFFT = Type: <b>ID3DX11FFT**</b> A pointer to a variable that receives a pointer to the ID3DX11FFT interface for the
///            created FFT object.
///Returns:
///    Type: <b>HRESULT</b> The return value is one of the values listed in Direct3D 11 Return Codes.
///    
@DllImport("d3dcsx")
HRESULT D3DX11CreateFFT3DComplex(ID3D11DeviceContext pDeviceContext, uint X, uint Y, uint Z, uint Flags, 
                                 D3DX11_FFT_BUFFER_INFO* pBufferInfo, ID3DX11FFT* ppFFT);


// Interfaces

@GUID("8BA5FB08-5195-40E2-AC58-0D989C3A0102")
interface ID3DBlob : IUnknown
{
    void*  GetBufferPointer();
    size_t GetBufferSize();
}

///**ID3DDestructionNotifier** is an interface that you can use to register for callbacks when a Direct3D nano-COM
///object is destroyed. To acquire an instance of this interface, call on a Direct3D object with the **IID** of
///**ID3DDestructionNotifier**. Using <b>ID3DDestructionNotifier</b> instead of
///<b>ID3D12Object::SetPrivateDataInterface</b> or Direct3D 11 equivalents provides stronger guarantees about the order
///of destruction. With <b>ID3DDestructionNotifier</b>, implicit relationships&mdash;such as an <b>ID3D11View</b>
///holding a reference to its underlying <b>ID3D11Resource</b>&mdash;are guaranteed to be valid and for the referenced
///object (here, the **ID3D11Object**) to still be alive when the destruction callback is invoked. With
///<b>ID3D12Object::SetPrivateDataInterface</b>, the implicit references can be released before the destruction callback
///is invoked. It isn't safe to access the object being destructed during the callback.
@GUID("A06EB39A-50DA-425B-8C31-4EECD6C270F3")
interface ID3DDestructionNotifier : IUnknown
{
    ///Registers a user-defined callback to be invoked on destruction of the object from which this
    ///[ID3DDestructionNotifier](./nn-d3dcommon-id3ddestructionotifier.md) was created.
    ///Params:
    ///    callbackFn = Type: <b>PFN_DESTRUCTION_CALLBACK</b> A user-defined callback to be invoked when the object is destroyed.
    ///    pData = Type: **void\*** The data to pass to *callbackFn* when invoked
    ///    pCallbackID = Type: **[UINT](/windows/win32/winprog/windows-data-types)\*** Pointer to a **UINT** used to identify the
    ///                  callback, and to pass to to unregister the callback.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If this function suceeds, it returns
    ///    **S_OK**.
    ///    
    HRESULT RegisterDestructionCallback(PFN_DESTRUCTION_CALLBACK callbackFn, void* pData, uint* pCallbackID);
    ///Unregisters a callback that was registered with
    ///[ID3DDestructionNotifier::RegisterDestructionCallback](./nf-d3dcommon-id3ddestructionotifier-registerdestructioncallback.md).
    ///Params:
    ///    callbackID = Type: **[UINT](/windows/win32/winprog/windows-data-types)** The **UINT** that was created by the
    ///                 *pCallbackID* argument to <b>ID3DDestructionNotifier::RegisterDestructionCallback</b>.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If this function suceeds, it returns
    ///    **S_OK**.
    ///    
    HRESULT UnregisterDestructionCallback(uint callbackID);
}

///<b>ID3DInclude</b> is an include interface that the user implements to allow an application to call user-overridable
///methods for opening and closing shader #include files.
interface ID3DInclude
{
    ///A user-implemented method for opening and reading the contents of a shader #include file.
    ///Params:
    ///    IncludeType = Type: <b>D3D_INCLUDE_TYPE</b> A D3D_INCLUDE_TYPE-typed value that indicates the location of the
    ///    pFileName = Type: <b>LPCSTR</b> Name of the
    ///    pParentData = Type: <b>LPCVOID</b> Pointer to the container that includes the
    ///    ppData = Type: <b>LPCVOID*</b> Pointer to the buffer that contains the include directives. This pointer remains valid
    ///             until you callID3DInclude::Close.
    ///    pBytes = Type: <b>UINT*</b> Pointer to the number of bytes that <b>Open</b> returns in <i>ppData</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> The user-implemented method must return S_OK. If <b>Open</b> fails when it reads the
    ///    #include file, the application programming interface (API) that caused <b>Open</b> to be called fails. This
    ///    failure can occur in one of the following situations: <ul> <li>The high-level shader language (HLSL) shader
    ///    fails one of the <b>D3D10CompileShader***</b> functions. </li> <li>The effect fails one of the
    ///    <b>D3D10CreateEffect***</b> functions. </li> </ul>
    ///    
    HRESULT Open(D3D_INCLUDE_TYPE IncludeType, const(PSTR) pFileName, const(void)* pParentData, void** ppData, 
                 uint* pBytes);
    ///A user-implemented method for closing a shader #include file.
    ///Params:
    ///    pData = Type: <b>LPCVOID</b> Pointer to the buffer that contains the include directives. This is the pointer that was
    ///            returned by the corresponding ID3DInclude::Open call.
    ///Returns:
    ///    Type: <b>HRESULT</b> The user-implemented <b>Close</b> method should return S_OK. If <b>Close</b> fails when
    ///    it closes the #include file, the application programming interface (API) that caused <b>Close</b> to be
    ///    called fails. This failure can occur in one of the following situations: <ul> <li>The high-level shader
    ///    language (HLSL) shader fails one of the <b>D3D10CompileShader***</b> functions. </li> <li>The effect fails
    ///    one of the <b>D3D10CreateEffect***</b> functions. </li> </ul>
    ///    
    HRESULT Close(const(void)* pData);
}

///A device-child interface accesses data used by a device.
@GUID("1841E5C8-16B0-489B-BCC8-44CFB0D5DEAE")
interface ID3D11DeviceChild : IUnknown
{
    ///Get a pointer to the device that created this interface.
    ///Params:
    ///    ppDevice = Type: <b>ID3D11Device**</b> Address of a pointer to a device (see ID3D11Device).
    void    GetDevice(ID3D11Device* ppDevice);
    ///Get application-defined data from a device child.
    ///Params:
    ///    guid = Type: <b>REFGUID</b> Guid associated with the data.
    ///    pDataSize = Type: <b>UINT*</b> A pointer to a variable that on input contains the size, in bytes, of the buffer that
    ///                <i>pData</i> points to, and on output contains the size, in bytes, of the amount of data that
    ///                <b>GetPrivateData</b>retrieved.
    ///    pData = Type: <b>void*</b> A pointer to a buffer that <b>GetPrivateData</b>fills with data from the device child if
    ///            <i>pDataSize</i> points to a value that specifies a buffer large enough to hold the data.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT GetPrivateData(const(GUID)* guid, uint* pDataSize, void* pData);
    ///Set application-defined data to a device child and associate that data with an application-defined guid.
    ///Params:
    ///    guid = Type: <b>REFGUID</b> Guid associated with the data.
    ///    DataSize = Type: <b>UINT</b> Size of the data.
    ///    pData = Type: <b>const void*</b> Pointer to the data to be stored with this device child. If pData is <b>NULL</b>,
    ///            DataSize must also be 0, and any data previously associated with the specified guid will be destroyed.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT SetPrivateData(const(GUID)* guid, uint DataSize, const(void)* pData);
    ///Associate an IUnknown-derived interface with this device child and associate that interface with an
    ///application-defined guid.
    ///Params:
    ///    guid = Type: <b>REFGUID</b> Guid associated with the interface.
    ///    pData = Type: <b>const IUnknown*</b> Pointer to an IUnknown-derived interface to be associated with the device child.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT SetPrivateDataInterface(const(GUID)* guid, const(IUnknown) pData);
}

///The depth-stencil-state interface holds a description for depth-stencil state that you can bind to the output-merger
///stage.
@GUID("03823EFB-8D8F-4E1C-9AA2-F64BB2CBFDF1")
interface ID3D11DepthStencilState : ID3D11DeviceChild
{
    ///Gets the description for depth-stencil state that you used to create the depth-stencil-state object.
    ///Params:
    ///    pDesc = Type: <b>D3D11_DEPTH_STENCIL_DESC*</b> A pointer to a D3D11_DEPTH_STENCIL_DESC structure that receives a
    ///            description of the depth-stencil state.
    void GetDesc(D3D11_DEPTH_STENCIL_DESC* pDesc);
}

///The blend-state interface holds a description for blending state that you can bind to the output-merger stage.
@GUID("75B68FAA-347D-4159-8F45-A0640F01CD9A")
interface ID3D11BlendState : ID3D11DeviceChild
{
    ///Gets the description for blending state that you used to create the blend-state object.
    ///Params:
    ///    pDesc = Type: <b>D3D11_BLEND_DESC*</b> A pointer to a D3D11_BLEND_DESC structure that receives a description of the
    ///            blend state.
    void GetDesc(D3D11_BLEND_DESC* pDesc);
}

///The rasterizer-state interface holds a description for rasterizer state that you can bind to the rasterizer stage.
@GUID("9BB4AB81-AB1A-4D8F-B506-FC04200B6EE7")
interface ID3D11RasterizerState : ID3D11DeviceChild
{
    ///Gets the description for rasterizer state that you used to create the rasterizer-state object.
    ///Params:
    ///    pDesc = Type: <b>D3D11_RASTERIZER_DESC*</b> A pointer to a D3D11_RASTERIZER_DESC structure that receives a
    ///            description of the rasterizer state.
    void GetDesc(D3D11_RASTERIZER_DESC* pDesc);
}

///A resource interface provides common actions on all resources.
@GUID("DC8E63F3-D12B-4952-B47B-5E45026A862D")
interface ID3D11Resource : ID3D11DeviceChild
{
    ///Get the type of the resource.
    ///Params:
    ///    pResourceDimension = Type: <b>D3D11_RESOURCE_DIMENSION*</b> Pointer to the resource type (see D3D11_RESOURCE_DIMENSION).
    void GetType(D3D11_RESOURCE_DIMENSION* pResourceDimension);
    ///Set the eviction priority of a resource.
    ///Params:
    ///    EvictionPriority = Type: <b>UINT</b> Eviction priority for the resource, which is one of the following values: <ul>
    ///                       <li>DXGI_RESOURCE_PRIORITY_MINIMUM</li> <li>DXGI_RESOURCE_PRIORITY_LOW</li>
    ///                       <li>DXGI_RESOURCE_PRIORITY_NORMAL</li> <li>DXGI_RESOURCE_PRIORITY_HIGH</li>
    ///                       <li>DXGI_RESOURCE_PRIORITY_MAXIMUM</li> </ul>
    void SetEvictionPriority(uint EvictionPriority);
    ///Get the eviction priority of a resource.
    ///Returns:
    ///    Type: <b>UINT</b> One of the following values, which specifies the eviction priority for the resource: <ul>
    ///    <li>DXGI_RESOURCE_PRIORITY_MINIMUM</li> <li>DXGI_RESOURCE_PRIORITY_LOW</li>
    ///    <li>DXGI_RESOURCE_PRIORITY_NORMAL</li> <li>DXGI_RESOURCE_PRIORITY_HIGH</li>
    ///    <li>DXGI_RESOURCE_PRIORITY_MAXIMUM</li> </ul>
    ///    
    uint GetEvictionPriority();
}

///A buffer interface accesses a buffer resource, which is unstructured memory. Buffers typically store vertex or index
///data.
@GUID("48570B85-D1EE-4FCD-A250-EB350722B037")
interface ID3D11Buffer : ID3D11Resource
{
    ///Get the properties of a buffer resource.
    ///Params:
    ///    pDesc = Type: <b>D3D11_BUFFER_DESC*</b> Pointer to a resource description (see D3D11_BUFFER_DESC) filled in by the
    ///            method.
    void GetDesc(D3D11_BUFFER_DESC* pDesc);
}

///A 1D texture interface accesses texel data, which is structured memory.
@GUID("F8FB5C27-C6B3-4F75-A4C8-439AF2EF564C")
interface ID3D11Texture1D : ID3D11Resource
{
    ///Get the properties of the texture resource.
    ///Params:
    ///    pDesc = Type: <b>D3D11_TEXTURE1D_DESC*</b> Pointer to a resource description (see D3D11_TEXTURE1D_DESC).
    void GetDesc(D3D11_TEXTURE1D_DESC* pDesc);
}

///A 2D texture interface manages texel data, which is structured memory.
@GUID("6F15AAF2-D208-4E89-9AB4-489535D34F9C")
interface ID3D11Texture2D : ID3D11Resource
{
    ///Get the properties of the texture resource.
    ///Params:
    ///    pDesc = Type: <b>D3D11_TEXTURE2D_DESC*</b> Pointer to a resource description (see D3D11_TEXTURE2D_DESC).
    void GetDesc(D3D11_TEXTURE2D_DESC* pDesc);
}

///A 3D texture interface accesses texel data, which is structured memory.
@GUID("037E866E-F56D-4357-A8AF-9DABBE6E250E")
interface ID3D11Texture3D : ID3D11Resource
{
    ///Get the properties of the texture resource.
    ///Params:
    ///    pDesc = Type: <b>D3D11_TEXTURE3D_DESC*</b> Pointer to a resource description (see D3D11_TEXTURE3D_DESC).
    void GetDesc(D3D11_TEXTURE3D_DESC* pDesc);
}

///A view interface specifies the parts of a resource the pipeline can access during rendering.
@GUID("839D1216-BB2E-412B-B7F4-A9DBEBE08ED1")
interface ID3D11View : ID3D11DeviceChild
{
    ///Get the resource that is accessed through this view.
    ///Params:
    ///    ppResource = Type: <b>ID3D11Resource**</b> Address of a pointer to the resource that is accessed through this view. (See
    ///                 ID3D11Resource.)
    void GetResource(ID3D11Resource* ppResource);
}

///A shader-resource-view interface specifies the subresources a shader can access during rendering. Examples of shader
///resources include a constant buffer, a texture buffer, and a texture.
@GUID("B0E06FE0-8192-4E1A-B1CA-36D7414710B2")
interface ID3D11ShaderResourceView : ID3D11View
{
    ///Get the shader resource view's description.
    ///Params:
    ///    pDesc = Type: <b>D3D11_SHADER_RESOURCE_VIEW_DESC*</b> A pointer to a D3D11_SHADER_RESOURCE_VIEW_DESC structure to be
    ///            filled with data about the shader resource view.
    void GetDesc(D3D11_SHADER_RESOURCE_VIEW_DESC* pDesc);
}

///A render-target-view interface identifies the render-target subresources that can be accessed during rendering.
@GUID("DFDBA067-0B8D-4865-875B-D7B4516CC164")
interface ID3D11RenderTargetView : ID3D11View
{
    ///Get the properties of a render target view.
    ///Params:
    ///    pDesc = Type: <b>D3D11_RENDER_TARGET_VIEW_DESC*</b> Pointer to the description of a render target view (see
    ///            D3D11_RENDER_TARGET_VIEW_DESC).
    void GetDesc(D3D11_RENDER_TARGET_VIEW_DESC* pDesc);
}

///A depth-stencil-view interface accesses a texture resource during depth-stencil testing.
@GUID("9FDAC92A-1876-48C3-AFAD-25B94F84A9B6")
interface ID3D11DepthStencilView : ID3D11View
{
    ///Get the depth-stencil view.
    ///Params:
    ///    pDesc = Type: <b>D3D11_DEPTH_STENCIL_VIEW_DESC*</b> Pointer to a depth-stencil-view description (see
    ///            D3D11_DEPTH_STENCIL_VIEW_DESC).
    void GetDesc(D3D11_DEPTH_STENCIL_VIEW_DESC* pDesc);
}

///A view interface specifies the parts of a resource the pipeline can access during rendering.
@GUID("28ACF509-7F5C-48F6-8611-F316010A6380")
interface ID3D11UnorderedAccessView : ID3D11View
{
    ///Get a description of the resource.
    ///Params:
    ///    pDesc = Type: <b>D3D11_UNORDERED_ACCESS_VIEW_DESC*</b> Pointer to a resource description (see
    ///            D3D11_UNORDERED_ACCESS_VIEW_DESC.)
    void GetDesc(D3D11_UNORDERED_ACCESS_VIEW_DESC* pDesc);
}

///A vertex-shader interface manages an executable program (a vertex shader) that controls the vertex-shader stage.
@GUID("3B301D64-D678-4289-8897-22F8928B72F3")
interface ID3D11VertexShader : ID3D11DeviceChild
{
}

///A hull-shader interface manages an executable program (a hull shader) that controls the hull-shader stage.
@GUID("8E5C6061-628A-4C8E-8264-BBE45CB3D5DD")
interface ID3D11HullShader : ID3D11DeviceChild
{
}

///A domain-shader interface manages an executable program (a domain shader) that controls the domain-shader stage.
@GUID("F582C508-0F36-490C-9977-31EECE268CFA")
interface ID3D11DomainShader : ID3D11DeviceChild
{
}

///A geometry-shader interface manages an executable program (a geometry shader) that controls the geometry-shader
///stage.
@GUID("38325B96-EFFB-4022-BA02-2E795B70275C")
interface ID3D11GeometryShader : ID3D11DeviceChild
{
}

///A pixel-shader interface manages an executable program (a pixel shader) that controls the pixel-shader stage.
@GUID("EA82E40D-51DC-4F33-93D4-DB7C9125AE8C")
interface ID3D11PixelShader : ID3D11DeviceChild
{
}

///A compute-shader interface manages an executable program (a compute shader) that controls the compute-shader stage.
@GUID("4F5B196E-C2BD-495E-BD01-1FDED38E4969")
interface ID3D11ComputeShader : ID3D11DeviceChild
{
}

///An input-layout interface holds a definition of how to feed vertex data that is laid out in memory into the
///input-assembler stage of the graphics pipeline.
@GUID("E4819DDC-4CF0-4025-BD26-5DE82A3E07B7")
interface ID3D11InputLayout : ID3D11DeviceChild
{
}

///The sampler-state interface holds a description for sampler state that you can bind to any shader stage of the
///pipeline for reference by texture sample operations.
@GUID("DA6FEA51-564C-4487-9810-F0D0F9B4E3A5")
interface ID3D11SamplerState : ID3D11DeviceChild
{
    ///Gets the description for sampler state that you used to create the sampler-state object.
    ///Params:
    ///    pDesc = Type: <b>D3D11_SAMPLER_DESC*</b> A pointer to a D3D11_SAMPLER_DESC structure that receives a description of
    ///            the sampler state.
    void GetDesc(D3D11_SAMPLER_DESC* pDesc);
}

///This interface encapsulates methods for retrieving data from the GPU asynchronously.
@GUID("4B35D0CD-1E15-4258-9C98-1B1333F6DD3B")
interface ID3D11Asynchronous : ID3D11DeviceChild
{
    ///Get the size of the data (in bytes) that is output when calling ID3D11DeviceContext::GetData.
    ///Returns:
    ///    Type: <b>UINT</b> Size of the data (in bytes) that is output when calling GetData.
    ///    
    uint GetDataSize();
}

///A query interface queries information from the GPU.
@GUID("D6C00747-87B7-425E-B84D-44D108560AFD")
interface ID3D11Query : ID3D11Asynchronous
{
    ///Get a query description.
    ///Params:
    ///    pDesc = Type: <b>D3D11_QUERY_DESC*</b> Pointer to a query description (see D3D11_QUERY_DESC).
    void GetDesc(D3D11_QUERY_DESC* pDesc);
}

///A predicate interface determines whether geometry should be processed depending on the results of a previous draw
///call.
@GUID("9EB576DD-9F77-4D86-81AA-8BAB5FE490E2")
interface ID3D11Predicate : ID3D11Query
{
}

///This interface encapsulates methods for measuring GPU performance.
@GUID("6E8C49FB-A371-4770-B440-29086022B741")
interface ID3D11Counter : ID3D11Asynchronous
{
    ///Get a counter description.
    ///Params:
    ///    pDesc = Type: <b>D3D11_COUNTER_DESC*</b> Pointer to a counter description (see D3D11_COUNTER_DESC).
    void GetDesc(D3D11_COUNTER_DESC* pDesc);
}

///This interface encapsulates an HLSL class.
@GUID("A6CD7FAA-B0B7-4A2F-9436-8662A65797CB")
interface ID3D11ClassInstance : ID3D11DeviceChild
{
    ///Gets the ID3D11ClassLinkage object associated with the current HLSL class.
    ///Params:
    ///    ppLinkage = Type: <b>ID3D11ClassLinkage**</b> A pointer to a ID3D11ClassLinkage interface pointer.
    void GetClassLinkage(ID3D11ClassLinkage* ppLinkage);
    ///Gets a description of the current HLSL class.
    ///Params:
    ///    pDesc = Type: <b>D3D11_CLASS_INSTANCE_DESC*</b> A pointer to a D3D11_CLASS_INSTANCE_DESC structure that describes the
    ///            current HLSL class.
    void GetDesc(D3D11_CLASS_INSTANCE_DESC* pDesc);
    ///Gets the instance name of the current HLSL class.
    ///Params:
    ///    pInstanceName = Type: <b>LPSTR</b> The instance name of the current HLSL class.
    ///    pBufferLength = Type: <b>SIZE_T*</b> The length of the <i>pInstanceName</i> parameter.
    void GetInstanceName(PSTR pInstanceName, size_t* pBufferLength);
    ///Gets the type of the current HLSL class.
    ///Params:
    ///    pTypeName = Type: <b>LPSTR</b> Type of the current HLSL class.
    ///    pBufferLength = Type: <b>SIZE_T*</b> The length of the <i>pTypeName</i> parameter.
    void GetTypeName(PSTR pTypeName, size_t* pBufferLength);
}

///This interface encapsulates an HLSL dynamic linkage.
@GUID("DDF57CBA-9543-46E4-A12B-F207A0FE7FED")
interface ID3D11ClassLinkage : ID3D11DeviceChild
{
    ///Gets the class-instance object that represents the specified HLSL class.
    ///Params:
    ///    pClassInstanceName = Type: <b>LPCSTR</b> The name of a class for which to get the class instance.
    ///    InstanceIndex = Type: <b>UINT</b> The index of the class instance.
    ///    ppInstance = Type: <b>ID3D11ClassInstance**</b> The address of a pointer to an ID3D11ClassInstance interface to
    ///                 initialize.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT GetClassInstance(const(PSTR) pClassInstanceName, uint InstanceIndex, ID3D11ClassInstance* ppInstance);
    ///Initializes a class-instance object that represents an HLSL class instance.
    ///Params:
    ///    pClassTypeName = Type: <b>LPCSTR</b> The type name of a class to initialize.
    ///    ConstantBufferOffset = Type: <b>UINT</b> Identifies the constant buffer that contains the class data.
    ///    ConstantVectorOffset = Type: <b>UINT</b> The four-component vector offset from the start of the constant buffer where the class data
    ///                           will begin. Consequently, this is not a byte offset.
    ///    TextureOffset = Type: <b>UINT</b> The texture slot for the first texture; there may be multiple textures following the
    ///                    offset.
    ///    SamplerOffset = Type: <b>UINT</b> The sampler slot for the first sampler; there may be multiple samplers following the
    ///                    offset.
    ///    ppInstance = Type: <b>ID3D11ClassInstance**</b> The address of a pointer to an ID3D11ClassInstance interface to
    ///                 initialize.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the following Direct3D 11 Return
    ///    Codes.
    ///    
    HRESULT CreateClassInstance(const(PSTR) pClassTypeName, uint ConstantBufferOffset, uint ConstantVectorOffset, 
                                uint TextureOffset, uint SamplerOffset, ID3D11ClassInstance* ppInstance);
}

///The <b>ID3D11CommandList</b> interface encapsulates a list of graphics commands for play back.
@GUID("A24BC4D1-769E-43F7-8013-98FF566C18E2")
interface ID3D11CommandList : ID3D11DeviceChild
{
    ///Gets the initialization flags associated with the deferred context that created the command list.
    ///Returns:
    ///    Type: <b>UINT</b> The context flag is reserved for future use and is always 0.
    ///    
    uint GetContextFlags();
}

///The <b>ID3D11DeviceContext</b> interface represents a device context which generates rendering commands. <div
///class="alert"><b>Note</b> The latest version of this interface is ID3D11DeviceContext4 introduced in the Windows 10
///Creators Update. Applications targetting Windows 10 Creators Update should use the <b>ID3D11DeviceContext4</b>
///interface instead of <b>ID3D11DeviceContext</b>.</div><div> </div>
@GUID("C0BFA96C-E089-44FB-8EAF-26F8796190DA")
interface ID3D11DeviceContext : ID3D11DeviceChild
{
    ///Sets the constant buffers used by the vertex shader pipeline stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin setting constant buffers to (ranges from
    ///                0 to <b>D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT</b> - 1).
    ///    NumBuffers = Type: <b>UINT</b> Number of buffers to set (ranges from 0 to
    ///                 <b>D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT</b> - <i>StartSlot</i>).
    ///    ppConstantBuffers = Type: <b>ID3D11Buffer*</b> Array of constant buffers (see ID3D11Buffer) being given to the device.
    void    VSSetConstantBuffers(uint StartSlot, uint NumBuffers, ID3D11Buffer* ppConstantBuffers);
    ///Bind an array of shader resources to the pixel shader stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin setting shader resources to (ranges from
    ///                0 to D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - 1).
    ///    NumViews = Type: <b>UINT</b> Number of shader resources to set. Up to a maximum of 128 slots are available for shader
    ///               resources (ranges from 0 to D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - StartSlot).
    ///    ppShaderResourceViews = Type: <b>ID3D11ShaderResourceView*</b> Array of shader resource view interfaces to set to the device.
    void    PSSetShaderResources(uint StartSlot, uint NumViews, ID3D11ShaderResourceView* ppShaderResourceViews);
    ///Sets a pixel shader to the device.
    ///Params:
    ///    pPixelShader = Type: <b>ID3D11PixelShader*</b> Pointer to a pixel shader (see ID3D11PixelShader). Passing in <b>NULL</b>
    ///                   disables the shader for this pipeline stage.
    ///    ppClassInstances = Type: <b>ID3D11ClassInstance*</b> A pointer to an array of class-instance interfaces (see
    ///                       ID3D11ClassInstance). Each interface used by a shader must have a corresponding class instance or the shader
    ///                       will get disabled. Set ppClassInstances to <b>NULL</b> if the shader does not use any interfaces.
    ///    NumClassInstances = Type: <b>UINT</b> The number of class-instance interfaces in the array.
    void    PSSetShader(ID3D11PixelShader pPixelShader, ID3D11ClassInstance* ppClassInstances, 
                        uint NumClassInstances);
    ///Set an array of sampler states to the pixel shader pipeline stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin setting samplers to (ranges from 0 to
    ///                D3D11_COMMONSHADER_SAMPLER_SLOT_COUNT - 1).
    ///    NumSamplers = Type: <b>UINT</b> Number of samplers in the array. Each pipeline stage has a total of 16 sampler slots
    ///                  available (ranges from 0 to D3D11_COMMONSHADER_SAMPLER_SLOT_COUNT - StartSlot).
    ///    ppSamplers = Type: <b>ID3D11SamplerState*</b> Pointer to an array of sampler-state interfaces (see ID3D11SamplerState).
    ///                 See Remarks.
    void    PSSetSamplers(uint StartSlot, uint NumSamplers, ID3D11SamplerState* ppSamplers);
    ///Set a vertex shader to the device.
    ///Params:
    ///    pVertexShader = Type: <b>ID3D11VertexShader*</b> Pointer to a vertex shader (see ID3D11VertexShader). Passing in <b>NULL</b>
    ///                    disables the shader for this pipeline stage.
    ///    ppClassInstances = Type: <b>ID3D11ClassInstance*</b> A pointer to an array of class-instance interfaces (see
    ///                       ID3D11ClassInstance). Each interface used by a shader must have a corresponding class instance or the shader
    ///                       will get disabled. Set ppClassInstances to <b>NULL</b> if the shader does not use any interfaces.
    ///    NumClassInstances = Type: <b>UINT</b> The number of class-instance interfaces in the array.
    void    VSSetShader(ID3D11VertexShader pVertexShader, ID3D11ClassInstance* ppClassInstances, 
                        uint NumClassInstances);
    ///Draw indexed, non-instanced primitives.
    ///Params:
    ///    IndexCount = Type: <b>UINT</b> Number of indices to draw.
    ///    StartIndexLocation = Type: <b>UINT</b> The location of the first index read by the GPU from the index buffer.
    ///    BaseVertexLocation = Type: <b>INT</b> A value added to each index before reading a vertex from the vertex buffer.
    void    DrawIndexed(uint IndexCount, uint StartIndexLocation, int BaseVertexLocation);
    ///Draw non-indexed, non-instanced primitives.
    ///Params:
    ///    VertexCount = Type: <b>UINT</b> Number of vertices to draw.
    ///    StartVertexLocation = Type: <b>UINT</b> Index of the first vertex, which is usually an offset in a vertex buffer.
    void    Draw(uint VertexCount, uint StartVertexLocation);
    ///Gets a pointer to the data contained in a subresource, and denies the GPU access to that subresource.
    ///Params:
    ///    pResource = Type: <b>ID3D11Resource*</b> A pointer to a ID3D11Resource interface.
    ///    Subresource = Type: <b>UINT</b> Index number of the subresource.
    ///    MapType = Type: <b>D3D11_MAP</b> A D3D11_MAP-typed value that specifies the CPU's read and write permissions for a
    ///              resource.
    ///    MapFlags = Type: <b>UINT</b> Flag that specifies what the CPU does when the GPU is busy. This flag is optional.
    ///    pMappedResource = Type: <b>D3D11_MAPPED_SUBRESOURCE*</b> A pointer to the D3D11_MAPPED_SUBRESOURCE structure for the mapped
    ///                      subresource. See the Remarks section regarding NULL pointers.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 11 Return Codes. This method also returns
    ///    <b>DXGI_ERROR_WAS_STILL_DRAWING</b> if <i>MapFlags</i> specifies <b>D3D11_MAP_FLAG_DO_NOT_WAIT</b> and the
    ///    GPU is not yet finished with the resource. This method also returns <b>DXGI_ERROR_DEVICE_REMOVED</b> if
    ///    <i>MapType</i> allows any CPU read access and the video card has been removed. For more information about
    ///    these error codes, see DXGI_ERROR.
    ///    
    HRESULT Map(ID3D11Resource pResource, uint Subresource, D3D11_MAP MapType, uint MapFlags, 
                D3D11_MAPPED_SUBRESOURCE* pMappedResource);
    ///Invalidate the pointer to a resource and reenable the GPU's access to that resource.
    ///Params:
    ///    pResource = Type: <b>ID3D11Resource*</b> A pointer to a ID3D11Resource interface.
    ///    Subresource = Type: <b>UINT</b> A subresource to be unmapped.
    void    Unmap(ID3D11Resource pResource, uint Subresource);
    ///Sets the constant buffers used by the pixel shader pipeline stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin setting constant buffers to (ranges from
    ///                0 to <b>D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT</b> - 1).
    ///    NumBuffers = Type: <b>UINT</b> Number of buffers to set (ranges from 0 to
    ///                 <b>D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT</b> - <i>StartSlot</i>).
    ///    ppConstantBuffers = Type: <b>ID3D11Buffer*</b> Array of constant buffers (see ID3D11Buffer) being given to the device.
    void    PSSetConstantBuffers(uint StartSlot, uint NumBuffers, ID3D11Buffer* ppConstantBuffers);
    ///Bind an input-layout object to the input-assembler stage.
    ///Params:
    ///    pInputLayout = Type: <b>ID3D11InputLayout*</b> A pointer to the input-layout object (see ID3D11InputLayout), which describes
    ///                   the input buffers that will be read by the IA stage.
    void    IASetInputLayout(ID3D11InputLayout pInputLayout);
    ///Bind an array of vertex buffers to the input-assembler stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> The first input slot for binding. The first vertex buffer is explicitly bound to the start
    ///                slot; this causes each additional vertex buffer in the array to be implicitly bound to each subsequent input
    ///                slot. The maximum of 16 or 32 input slots (ranges from 0 to D3D11_IA_VERTEX_INPUT_RESOURCE_SLOT_COUNT - 1)
    ///                are available; the maximum number of input slots depends on the feature level.
    ///    NumBuffers = Type: <b>UINT</b> The number of vertex buffers in the array. The number of buffers (plus the starting slot)
    ///                 can't exceed the total number of IA-stage input slots (ranges from 0 to
    ///                 D3D11_IA_VERTEX_INPUT_RESOURCE_SLOT_COUNT - StartSlot).
    ///    ppVertexBuffers = Type: <b>ID3D11Buffer*</b> A pointer to an array of vertex buffers (see ID3D11Buffer). The vertex buffers
    ///                      must have been created with the D3D11_BIND_VERTEX_BUFFER flag.
    ///    pStrides = Type: <b>const UINT*</b> Pointer to an array of stride values; one stride value for each buffer in the
    ///               vertex-buffer array. Each stride is the size (in bytes) of the elements that are to be used from that vertex
    ///               buffer.
    ///    pOffsets = Type: <b>const UINT*</b> Pointer to an array of offset values; one offset value for each buffer in the
    ///               vertex-buffer array. Each offset is the number of bytes between the first element of a vertex buffer and the
    ///               first element that will be used.
    void    IASetVertexBuffers(uint StartSlot, uint NumBuffers, ID3D11Buffer* ppVertexBuffers, 
                               const(uint)* pStrides, const(uint)* pOffsets);
    ///Bind an index buffer to the input-assembler stage.
    ///Params:
    ///    pIndexBuffer = Type: <b>ID3D11Buffer*</b> A pointer to an ID3D11Buffer object, that contains indices. The index buffer must
    ///                   have been created with the D3D11_BIND_INDEX_BUFFER flag.
    ///    Format = Type: <b>DXGI_FORMAT</b> A DXGI_FORMAT that specifies the format of the data in the index buffer. The only
    ///             formats allowed for index buffer data are 16-bit (DXGI_FORMAT_R16_UINT) and 32-bit (DXGI_FORMAT_R32_UINT)
    ///             integers.
    ///    Offset = Type: <b>UINT</b> Offset (in bytes) from the start of the index buffer to the first index to use.
    void    IASetIndexBuffer(ID3D11Buffer pIndexBuffer, DXGI_FORMAT Format, uint Offset);
    ///Draw indexed, instanced primitives.
    ///Params:
    ///    IndexCountPerInstance = Type: <b>UINT</b> Number of indices read from the index buffer for each instance.
    ///    InstanceCount = Type: <b>UINT</b> Number of instances to draw.
    ///    StartIndexLocation = Type: <b>UINT</b> The location of the first index read by the GPU from the index buffer.
    ///    BaseVertexLocation = Type: <b>INT</b> A value added to each index before reading a vertex from the vertex buffer.
    ///    StartInstanceLocation = Type: <b>UINT</b> A value added to each index before reading per-instance data from a vertex buffer.
    void    DrawIndexedInstanced(uint IndexCountPerInstance, uint InstanceCount, uint StartIndexLocation, 
                                 int BaseVertexLocation, uint StartInstanceLocation);
    ///Draw non-indexed, instanced primitives.
    ///Params:
    ///    VertexCountPerInstance = Type: <b>UINT</b> Number of vertices to draw.
    ///    InstanceCount = Type: <b>UINT</b> Number of instances to draw.
    ///    StartVertexLocation = Type: <b>UINT</b> Index of the first vertex.
    ///    StartInstanceLocation = Type: <b>UINT</b> A value added to each index before reading per-instance data from a vertex buffer.
    void    DrawInstanced(uint VertexCountPerInstance, uint InstanceCount, uint StartVertexLocation, 
                          uint StartInstanceLocation);
    ///Sets the constant buffers used by the geometry shader pipeline stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin setting constant buffers to (ranges from
    ///                0 to <b>D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT</b> - 1).
    ///    NumBuffers = Type: <b>UINT</b> Number of buffers to set (ranges from 0 to
    ///                 <b>D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT</b> - <i>StartSlot</i>).
    ///    ppConstantBuffers = Type: <b>ID3D11Buffer*</b> Array of constant buffers (see ID3D11Buffer) being given to the device.
    void    GSSetConstantBuffers(uint StartSlot, uint NumBuffers, ID3D11Buffer* ppConstantBuffers);
    ///Set a geometry shader to the device.
    ///Params:
    ///    pShader = Type: <b>ID3D11GeometryShader*</b> Pointer to a geometry shader (see ID3D11GeometryShader). Passing in
    ///              <b>NULL</b> disables the shader for this pipeline stage.
    ///    ppClassInstances = Type: <b>ID3D11ClassInstance*</b> A pointer to an array of class-instance interfaces (see
    ///                       ID3D11ClassInstance). Each interface used by a shader must have a corresponding class instance or the shader
    ///                       will get disabled. Set ppClassInstances to <b>NULL</b> if the shader does not use any interfaces.
    ///    NumClassInstances = Type: <b>UINT</b> The number of class-instance interfaces in the array.
    void    GSSetShader(ID3D11GeometryShader pShader, ID3D11ClassInstance* ppClassInstances, 
                        uint NumClassInstances);
    ///Bind information about the primitive type, and data order that describes input data for the input assembler
    ///stage.
    ///Params:
    ///    Topology = Type: <b>D3D11_PRIMITIVE_TOPOLOGY</b> The type of primitive and ordering of the primitive data (see
    ///               D3D11_PRIMITIVE_TOPOLOGY).
    void    IASetPrimitiveTopology(D3D_PRIMITIVE_TOPOLOGY Topology);
    ///Bind an array of shader resources to the vertex-shader stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin setting shader resources to (range is
    ///                from 0 to D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - 1).
    ///    NumViews = Type: <b>UINT</b> Number of shader resources to set. Up to a maximum of 128 slots are available for shader
    ///               resources (range is from 0 to D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - StartSlot).
    ///    ppShaderResourceViews = Type: <b>ID3D11ShaderResourceView*</b> Array of shader resource view interfaces to set to the device.
    void    VSSetShaderResources(uint StartSlot, uint NumViews, ID3D11ShaderResourceView* ppShaderResourceViews);
    ///Set an array of sampler states to the vertex shader pipeline stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin setting samplers to (ranges from 0 to
    ///                D3D11_COMMONSHADER_SAMPLER_SLOT_COUNT - 1).
    ///    NumSamplers = Type: <b>UINT</b> Number of samplers in the array. Each pipeline stage has a total of 16 sampler slots
    ///                  available (ranges from 0 to D3D11_COMMONSHADER_SAMPLER_SLOT_COUNT - StartSlot).
    ///    ppSamplers = Type: <b>ID3D11SamplerState*</b> Pointer to an array of sampler-state interfaces (see ID3D11SamplerState).
    ///                 See Remarks.
    void    VSSetSamplers(uint StartSlot, uint NumSamplers, ID3D11SamplerState* ppSamplers);
    ///Mark the beginning of a series of commands.
    ///Params:
    ///    pAsync = Type: <b>ID3D11Asynchronous*</b> A pointer to an ID3D11Asynchronous interface.
    void    Begin(ID3D11Asynchronous pAsync);
    ///Mark the end of a series of commands.
    ///Params:
    ///    pAsync = Type: <b>ID3D11Asynchronous*</b> A pointer to an ID3D11Asynchronous interface.
    void    End(ID3D11Asynchronous pAsync);
    ///Get data from the graphics processing unit (GPU) asynchronously.
    ///Params:
    ///    pAsync = Type: <b>ID3D11Asynchronous*</b> A pointer to an ID3D11Asynchronous interface for the object about which
    ///             <b>GetData</b> retrieves data.
    ///    pData = Type: <b>void*</b> Address of memory that will receive the data. If <b>NULL</b>, <b>GetData</b> will be used
    ///            only to check status. The type of data output depends on the type of asynchronous interface.
    ///    DataSize = Type: <b>UINT</b> Size of the data to retrieve or 0. Must be 0 when <i>pData</i> is <b>NULL</b>.
    ///    GetDataFlags = Type: <b>UINT</b> Optional flags. Can be 0 or any combination of the flags enumerated by
    ///                   D3D11_ASYNC_GETDATA_FLAG.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 11 Return Codes. A return value of S_OK
    ///    indicates that the data at <i>pData</i> is available for the calling application to access. A return value of
    ///    S_FALSE indicates that the data is not yet available. If the data is not yet available, the application must
    ///    call <b>GetData</b> until the data is available.
    ///    
    HRESULT GetData(ID3D11Asynchronous pAsync, void* pData, uint DataSize, uint GetDataFlags);
    ///Set a rendering predicate.
    ///Params:
    ///    pPredicate = Type: <b>ID3D11Predicate*</b> A pointer to the ID3D11Predicate interface that represents the rendering
    ///                 predicate. A <b>NULL</b> value indicates "no" predication; in this case, the value of <i>PredicateValue</i>
    ///                 is irrelevant but will be preserved for ID3D11DeviceContext::GetPredication.
    ///    PredicateValue = Type: <b>BOOL</b> If <b>TRUE</b>, rendering will be affected by when the predicate's conditions are met. If
    ///                     <b>FALSE</b>, rendering will be affected when the conditions are not met.
    void    SetPredication(ID3D11Predicate pPredicate, BOOL PredicateValue);
    ///Bind an array of shader resources to the geometry shader stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin setting shader resources to (ranges from
    ///                0 to D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - 1).
    ///    NumViews = Type: <b>UINT</b> Number of shader resources to set. Up to a maximum of 128 slots are available for shader
    ///               resources(ranges from 0 to D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - StartSlot).
    ///    ppShaderResourceViews = Type: <b>ID3D11ShaderResourceView*</b> Array of shader resource view interfaces to set to the device.
    void    GSSetShaderResources(uint StartSlot, uint NumViews, ID3D11ShaderResourceView* ppShaderResourceViews);
    ///Set an array of sampler states to the geometry shader pipeline stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin setting samplers to (ranges from 0 to
    ///                D3D11_COMMONSHADER_SAMPLER_SLOT_COUNT - 1).
    ///    NumSamplers = Type: <b>UINT</b> Number of samplers in the array. Each pipeline stage has a total of 16 sampler slots
    ///                  available (ranges from 0 to D3D11_COMMONSHADER_SAMPLER_SLOT_COUNT - StartSlot).
    ///    ppSamplers = Type: <b>ID3D11SamplerState*</b> Pointer to an array of sampler-state interfaces (see ID3D11SamplerState).
    ///                 See Remarks.
    void    GSSetSamplers(uint StartSlot, uint NumSamplers, ID3D11SamplerState* ppSamplers);
    ///Bind one or more render targets atomically and the depth-stencil buffer to the output-merger stage.
    ///Params:
    ///    NumViews = Type: <b>UINT</b> Number of render targets to bind (ranges between 0 and
    ///               <b>D3D11_SIMULTANEOUS_RENDER_TARGET_COUNT</b>). If this parameter is nonzero, the number of entries in the
    ///               array to which <i>ppRenderTargetViews</i> points must equal the number in this parameter.
    ///    ppRenderTargetViews = Type: <b>ID3D11RenderTargetView*</b> Pointer to an array of ID3D11RenderTargetView that represent the render
    ///                          targets to bind to the device. If this parameter is <b>NULL</b> and <i>NumViews</i> is 0, no render targets
    ///                          are bound.
    ///    pDepthStencilView = Type: <b>ID3D11DepthStencilView*</b> Pointer to a ID3D11DepthStencilView that represents the depth-stencil
    ///                        view to bind to the device. If this parameter is <b>NULL</b>, the depth-stencil view is not bound.
    void    OMSetRenderTargets(uint NumViews, ID3D11RenderTargetView* ppRenderTargetViews, 
                               ID3D11DepthStencilView pDepthStencilView);
    ///Binds resources to the output-merger stage.
    ///Params:
    ///    NumRTVs = Type: <b>UINT</b> Number of render targets to bind (ranges between 0 and
    ///              <b>D3D11_SIMULTANEOUS_RENDER_TARGET_COUNT</b>). If this parameter is nonzero, the number of entries in the
    ///              array to which <i>ppRenderTargetViews</i> points must equal the number in this parameter. If you set
    ///              <i>NumRTVs</i> to D3D11_KEEP_RENDER_TARGETS_AND_DEPTH_STENCIL (0xffffffff), this method does not modify the
    ///              currently bound render-target views (RTVs) and also does not modify depth-stencil view (DSV).
    ///    ppRenderTargetViews = Type: <b>ID3D11RenderTargetView*</b> Pointer to an array of ID3D11RenderTargetViews that represent the render
    ///                          targets to bind to the device. If this parameter is <b>NULL</b> and <i>NumRTVs</i> is 0, no render targets
    ///                          are bound.
    ///    pDepthStencilView = Type: <b>ID3D11DepthStencilView*</b> Pointer to a ID3D11DepthStencilView that represents the depth-stencil
    ///                        view to bind to the device. If this parameter is <b>NULL</b>, the depth-stencil view is not bound.
    ///    UAVStartSlot = Type: <b>UINT</b> Index into a zero-based array to begin setting unordered-access views (ranges from 0 to
    ///                   D3D11_PS_CS_UAV_REGISTER_COUNT - 1). For the Direct3D 11.1 runtime, which is available starting with Windows
    ///                   8, this value can range from 0 to D3D11_1_UAV_SLOT_COUNT - 1. D3D11_1_UAV_SLOT_COUNT is defined as 64. For
    ///                   pixel shaders, <i>UAVStartSlot</i> should be equal to the number of render-target views being bound.
    ///    NumUAVs = Type: <b>UINT</b> Number of unordered-access views (UAVs) in <i>ppUnorderedAccessViews</i>. If you set
    ///              <i>NumUAVs</i> to D3D11_KEEP_UNORDERED_ACCESS_VIEWS (0xffffffff), this method does not modify the currently
    ///              bound unordered-access views. For the Direct3D 11.1 runtime, which is available starting with Windows 8, this
    ///              value can range from 0 to D3D11_1_UAV_SLOT_COUNT - <i>UAVStartSlot</i>.
    ///    ppUnorderedAccessViews = Type: <b>ID3D11UnorderedAccessView*</b> Pointer to an array of ID3D11UnorderedAccessViews that represent the
    ///                             unordered-access views to bind to the device. If this parameter is <b>NULL</b> and <i>NumUAVs</i> is 0, no
    ///                             unordered-access views are bound.
    ///    pUAVInitialCounts = Type: <b>const UINT*</b> An array of append and consume buffer offsets. A value of -1 indicates to keep the
    ///                        current offset. Any other values set the hidden counter for that appendable and consumable UAV.
    ///                        <i>pUAVInitialCounts</i> is relevant only for UAVs that were created with either D3D11_BUFFER_UAV_FLAG_APPEND
    ///                        or <b>D3D11_BUFFER_UAV_FLAG_COUNTER</b> specified when the UAV was created; otherwise, the argument is
    ///                        ignored.
    void    OMSetRenderTargetsAndUnorderedAccessViews(uint NumRTVs, ID3D11RenderTargetView* ppRenderTargetViews, 
                                                      ID3D11DepthStencilView pDepthStencilView, uint UAVStartSlot, 
                                                      uint NumUAVs, 
                                                      ID3D11UnorderedAccessView* ppUnorderedAccessViews, 
                                                      const(uint)* pUAVInitialCounts);
    ///Set the blend state of the output-merger stage.
    ///Params:
    ///    pBlendState = Type: <b>ID3D11BlendState*</b> Pointer to a blend-state interface (see ID3D11BlendState). Pass <b>NULL</b>
    ///                  for a default blend state. For more info about default blend state, see Remarks.
    ///    BlendFactor = Type: <b>const FLOAT[4]</b> Array of blend factors, one for each RGBA component. The blend factors modulate
    ///                  values for the pixel shader, render target, or both. If you created the blend-state object with
    ///                  D3D11_BLEND_BLEND_FACTOR or D3D11_BLEND_INV_BLEND_FACTOR, the blending stage uses the non-NULL array of blend
    ///                  factors. If you didn't create the blend-state object with <b>D3D11_BLEND_BLEND_FACTOR</b> or
    ///                  <b>D3D11_BLEND_INV_BLEND_FACTOR</b>, the blending stage does not use the non-NULL array of blend factors; the
    ///                  runtime stores the blend factors, and you can later call ID3D11DeviceContext::OMGetBlendState to retrieve the
    ///                  blend factors. If you pass <b>NULL</b>, the runtime uses or stores a blend factor equal to { 1, 1, 1, 1 }.
    ///    SampleMask = Type: <b>UINT</b> 32-bit sample coverage. The default value is 0xffffffff. See remarks.
    void    OMSetBlendState(ID3D11BlendState pBlendState, const(float)* BlendFactor, uint SampleMask);
    ///Sets the depth-stencil state of the output-merger stage.
    ///Params:
    ///    pDepthStencilState = Type: <b>ID3D11DepthStencilState*</b> Pointer to a depth-stencil state interface (see
    ///                         ID3D11DepthStencilState) to bind to the device. Set this to <b>NULL</b> to use the default state listed in
    ///                         D3D11_DEPTH_STENCIL_DESC.
    ///    StencilRef = Type: <b>UINT</b> Reference value to perform against when doing a depth-stencil test. See remarks.
    void    OMSetDepthStencilState(ID3D11DepthStencilState pDepthStencilState, uint StencilRef);
    ///Set the target output buffers for the stream-output stage of the pipeline.
    ///Params:
    ///    NumBuffers = Type: <b>UINT</b> The number of buffer to bind to the device. A maximum of four output buffers can be set. If
    ///                 less than four are defined by the call, the remaining buffer slots are set to <b>NULL</b>. See Remarks.
    ///    ppSOTargets = Type: <b>ID3D11Buffer*</b> The array of output buffers (see ID3D11Buffer) to bind to the device. The buffers
    ///                  must have been created with the D3D11_BIND_STREAM_OUTPUT flag.
    ///    pOffsets = Type: <b>const UINT*</b> Array of offsets to the output buffers from <i>ppSOTargets</i>, one offset for each
    ///               buffer. The offset values must be in bytes.
    void    SOSetTargets(uint NumBuffers, ID3D11Buffer* ppSOTargets, const(uint)* pOffsets);
    ///Draw geometry of an unknown size.
    void    DrawAuto();
    ///Draw indexed, instanced, GPU-generated primitives.
    ///Params:
    ///    pBufferForArgs = Type: <b>ID3D11Buffer*</b> A pointer to an ID3D11Buffer, which is a buffer containing the GPU generated
    ///                     primitives.
    ///    AlignedByteOffsetForArgs = Type: <b>UINT</b> Offset in <i>pBufferForArgs</i> to the start of the GPU generated primitives.
    void    DrawIndexedInstancedIndirect(ID3D11Buffer pBufferForArgs, uint AlignedByteOffsetForArgs);
    ///Draw instanced, GPU-generated primitives.
    ///Params:
    ///    pBufferForArgs = Type: <b>ID3D11Buffer*</b> A pointer to an ID3D11Buffer, which is a buffer containing the GPU generated
    ///                     primitives.
    ///    AlignedByteOffsetForArgs = Type: <b>UINT</b> Offset in <i>pBufferForArgs</i> to the start of the GPU generated primitives.
    void    DrawInstancedIndirect(ID3D11Buffer pBufferForArgs, uint AlignedByteOffsetForArgs);
    ///Execute a command list from a thread group.
    ///Params:
    ///    ThreadGroupCountX = Type: <b>UINT</b> The number of groups dispatched in the x direction. <i>ThreadGroupCountX</i> must be less
    ///                        than or equal to D3D11_CS_DISPATCH_MAX_THREAD_GROUPS_PER_DIMENSION (65535).
    ///    ThreadGroupCountY = Type: <b>UINT</b> The number of groups dispatched in the y direction. <i>ThreadGroupCountY</i> must be less
    ///                        than or equal to D3D11_CS_DISPATCH_MAX_THREAD_GROUPS_PER_DIMENSION (65535).
    ///    ThreadGroupCountZ = Type: <b>UINT</b> The number of groups dispatched in the z direction. <i>ThreadGroupCountZ</i> must be less
    ///                        than or equal to D3D11_CS_DISPATCH_MAX_THREAD_GROUPS_PER_DIMENSION (65535). In feature level 10 the value for
    ///                        <i>ThreadGroupCountZ</i> must be 1.
    void    Dispatch(uint ThreadGroupCountX, uint ThreadGroupCountY, uint ThreadGroupCountZ);
    ///Execute a command list over one or more thread groups.
    ///Params:
    ///    pBufferForArgs = Type: <b>ID3D11Buffer*</b> A pointer to an ID3D11Buffer, which must be loaded with data that matches the
    ///                     argument list for ID3D11DeviceContext::Dispatch.
    ///    AlignedByteOffsetForArgs = Type: <b>UINT</b> A byte-aligned offset between the start of the buffer and the arguments.
    void    DispatchIndirect(ID3D11Buffer pBufferForArgs, uint AlignedByteOffsetForArgs);
    ///Set the rasterizer state for the rasterizer stage of the pipeline.
    ///Params:
    ///    pRasterizerState = Type: <b>ID3D11RasterizerState*</b> Pointer to a rasterizer-state interface (see ID3D11RasterizerState) to
    ///                       bind to the pipeline.
    void    RSSetState(ID3D11RasterizerState pRasterizerState);
    ///Bind an array of viewports to the rasterizer stage of the pipeline.
    ///Params:
    ///    NumViewports = Type: <b>UINT</b> Number of viewports to bind.
    ///    pViewports = Type: <b>const D3D11_VIEWPORT*</b> An array of D3D11_VIEWPORT structures to bind to the device. See the
    ///                 structure page for details about how the viewport size is dependent on the device feature level which has
    ///                 changed between Direct3D 11 and Direct3D 10.
    void    RSSetViewports(uint NumViewports, const(D3D11_VIEWPORT)* pViewports);
    ///Bind an array of scissor rectangles to the rasterizer stage.
    ///Params:
    ///    NumRects = Type: <b>UINT</b> Number of scissor rectangles to bind.
    ///    pRects = Type: <b>const D3D11_RECT*</b> An array of scissor rectangles (see D3D11_RECT).
    void    RSSetScissorRects(uint NumRects, const(RECT)* pRects);
    ///Copy a region from a source resource to a destination resource.
    ///Params:
    ///    pDstResource = Type: <b>ID3D11Resource*</b> A pointer to the destination resource (see ID3D11Resource).
    ///    DstSubresource = Type: <b>UINT</b> Destination subresource index.
    ///    DstX = Type: <b>UINT</b> The x-coordinate of the upper left corner of the destination region.
    ///    DstY = Type: <b>UINT</b> The y-coordinate of the upper left corner of the destination region. For a 1D subresource,
    ///           this must be zero.
    ///    DstZ = Type: <b>UINT</b> The z-coordinate of the upper left corner of the destination region. For a 1D or 2D
    ///           subresource, this must be zero.
    ///    pSrcResource = Type: <b>ID3D11Resource*</b> A pointer to the source resource (see ID3D11Resource).
    ///    SrcSubresource = Type: <b>UINT</b> Source subresource index.
    ///    pSrcBox = Type: <b>const D3D11_BOX*</b> A pointer to a 3D box (see D3D11_BOX) that defines the source subresource that
    ///              can be copied. If <b>NULL</b>, the entire source subresource is copied. The box must fit within the source
    ///              resource. An empty box results in a no-op. A box is empty if the top value is greater than or equal to the
    ///              bottom value, or the left value is greater than or equal to the right value, or the front value is greater
    ///              than or equal to the back value. When the box is empty, <b>CopySubresourceRegion</b> doesn't perform a copy
    ///              operation.
    void    CopySubresourceRegion(ID3D11Resource pDstResource, uint DstSubresource, uint DstX, uint DstY, 
                                  uint DstZ, ID3D11Resource pSrcResource, uint SrcSubresource, 
                                  const(D3D11_BOX)* pSrcBox);
    ///Copy the entire contents of the source resource to the destination resource using the GPU.
    ///Params:
    ///    pDstResource = Type: <b>ID3D11Resource*</b> A pointer to the ID3D11Resource interface that represents the destination
    ///                   resource.
    ///    pSrcResource = Type: <b>ID3D11Resource*</b> A pointer to the ID3D11Resource interface that represents the source resource.
    void    CopyResource(ID3D11Resource pDstResource, ID3D11Resource pSrcResource);
    ///The CPU copies data from memory to a subresource created in non-mappable memory.
    ///Params:
    ///    pDstResource = Type: <b>ID3D11Resource*</b> A pointer to the destination resource (see ID3D11Resource).
    ///    DstSubresource = Type: <b>UINT</b> A zero-based index, that identifies the destination subresource. See D3D11CalcSubresource
    ///                     for more details.
    ///    pDstBox = Type: <b>const D3D11_BOX*</b> A pointer to a box that defines the portion of the destination subresource to
    ///              copy the resource data into. Coordinates are in bytes for buffers and in texels for textures. If <b>NULL</b>,
    ///              the data is written to the destination subresource with no offset. The dimensions of the source must fit the
    ///              destination (see D3D11_BOX). An empty box results in a no-op. A box is empty if the top value is greater than
    ///              or equal to the bottom value, or the left value is greater than or equal to the right value, or the front
    ///              value is greater than or equal to the back value. When the box is empty, <b>UpdateSubresource</b> doesn't
    ///              perform an update operation.
    ///    pSrcData = Type: <b>const void*</b> A pointer to the source data in memory.
    ///    SrcRowPitch = Type: <b>UINT</b> The size of one row of the source data.
    ///    SrcDepthPitch = Type: <b>UINT</b> The size of one depth slice of source data.
    void    UpdateSubresource(ID3D11Resource pDstResource, uint DstSubresource, const(D3D11_BOX)* pDstBox, 
                              const(void)* pSrcData, uint SrcRowPitch, uint SrcDepthPitch);
    ///Copies data from a buffer holding variable length data.
    ///Params:
    ///    pDstBuffer = Type: <b>ID3D11Buffer*</b> Pointer to ID3D11Buffer. This can be any buffer resource that other copy commands,
    ///                 such as ID3D11DeviceContext::CopyResource or ID3D11DeviceContext::CopySubresourceRegion, are able to write
    ///                 to.
    ///    DstAlignedByteOffset = Type: <b>UINT</b> Offset from the start of <i>pDstBuffer</i> to write 32-bit UINT structure (vertex) count
    ///                           from <i>pSrcView</i>.
    ///    pSrcView = Type: <b>ID3D11UnorderedAccessView*</b> Pointer to an ID3D11UnorderedAccessView of a Structured Buffer
    ///               resource created with either D3D11_BUFFER_UAV_FLAG_APPEND or <b>D3D11_BUFFER_UAV_FLAG_COUNTER</b> specified
    ///               when the UAV was created. These types of resources have hidden counters tracking "how many" records have been
    ///               written.
    void    CopyStructureCount(ID3D11Buffer pDstBuffer, uint DstAlignedByteOffset, 
                               ID3D11UnorderedAccessView pSrcView);
    ///Set all the elements in a render target to one value.
    ///Params:
    ///    pRenderTargetView = Type: <b>ID3D11RenderTargetView*</b> Pointer to the render target.
    ///    ColorRGBA = Type: <b>const FLOAT[4]</b> A 4-component array that represents the color to fill the render target with.
    void    ClearRenderTargetView(ID3D11RenderTargetView pRenderTargetView, const(float)* ColorRGBA);
    ///Clears an unordered access resource with bit-precise values.
    ///Params:
    ///    pUnorderedAccessView = Type: <b>ID3D11UnorderedAccessView*</b> The ID3D11UnorderedAccessView to clear.
    ///    Values = Type: <b>const UINT[4]</b> Values to copy to corresponding channels, see remarks.
    void    ClearUnorderedAccessViewUint(ID3D11UnorderedAccessView pUnorderedAccessView, const(uint)* Values);
    ///Clears an unordered access resource with a float value.
    ///Params:
    ///    pUnorderedAccessView = Type: <b>ID3D11UnorderedAccessView*</b> The ID3D11UnorderedAccessView to clear.
    ///    Values = Type: <b>const FLOAT[4]</b> Values to copy to corresponding channels, see remarks.
    void    ClearUnorderedAccessViewFloat(ID3D11UnorderedAccessView pUnorderedAccessView, const(float)* Values);
    ///Clears the depth-stencil resource.
    ///Params:
    ///    pDepthStencilView = Type: <b>ID3D11DepthStencilView*</b> Pointer to the depth stencil to be cleared.
    ///    ClearFlags = Type: <b>UINT</b> Identify the type of data to clear (see D3D11_CLEAR_FLAG).
    ///    Depth = Type: <b>FLOAT</b> Clear the depth buffer with this value. This value will be clamped between 0 and 1.
    ///    Stencil = Type: <b>UINT8</b> Clear the stencil buffer with this value.
    void    ClearDepthStencilView(ID3D11DepthStencilView pDepthStencilView, uint ClearFlags, float Depth, 
                                  ubyte Stencil);
    ///Generates mipmaps for the given shader resource.
    ///Params:
    ///    pShaderResourceView = Type: <b>ID3D11ShaderResourceView*</b> A pointer to an ID3D11ShaderResourceView interface that represents the
    ///                          shader resource.
    void    GenerateMips(ID3D11ShaderResourceView pShaderResourceView);
    ///Sets the minimum level-of-detail (LOD) for a resource.
    ///Params:
    ///    pResource = Type: <b>ID3D11Resource*</b> A pointer to an ID3D11Resource that represents the resource.
    ///    MinLOD = Type: <b>FLOAT</b> The level-of-detail, which ranges between 0 and the maximum number of mipmap levels of the
    ///             resource. For example, the maximum number of mipmap levels of a 1D texture is specified in the
    ///             <b>MipLevels</b> member of the D3D11_TEXTURE1D_DESC structure.
    void    SetResourceMinLOD(ID3D11Resource pResource, float MinLOD);
    ///Gets the minimum level-of-detail (LOD).
    ///Params:
    ///    pResource = Type: <b>ID3D11Resource*</b> A pointer to an ID3D11Resource which represents the resource.
    ///Returns:
    ///    Type: <b>FLOAT</b> Returns the minimum LOD.
    ///    
    float   GetResourceMinLOD(ID3D11Resource pResource);
    ///Copy a multisampled resource into a non-multisampled resource.
    ///Params:
    ///    pDstResource = Type: <b>ID3D11Resource*</b> Destination resource. Must be a created with the D3D11_USAGE_DEFAULT flag and be
    ///                   single-sampled. See ID3D11Resource.
    ///    DstSubresource = Type: <b>UINT</b> A zero-based index, that identifies the destination subresource. Use D3D11CalcSubresource
    ///                     to calculate the index.
    ///    pSrcResource = Type: <b>ID3D11Resource*</b> Source resource. Must be multisampled.
    ///    SrcSubresource = Type: <b>UINT</b> The source subresource of the source resource.
    ///    Format = Type: <b>DXGI_FORMAT</b> A DXGI_FORMAT that indicates how the multisampled resource will be resolved to a
    ///             single-sampled resource. See remarks.
    void    ResolveSubresource(ID3D11Resource pDstResource, uint DstSubresource, ID3D11Resource pSrcResource, 
                               uint SrcSubresource, DXGI_FORMAT Format);
    ///Queues commands from a command list onto a device.
    ///Params:
    ///    pCommandList = Type: <b>ID3D11CommandList*</b> A pointer to an ID3D11CommandList interface that encapsulates a command list.
    ///    RestoreContextState = Type: <b>BOOL</b> A Boolean flag that determines whether the target context state is saved prior to and
    ///                          restored after the execution of a command list. Use <b>TRUE</b> to indicate that the runtime needs to save
    ///                          and restore the state. Use <b>FALSE</b> to indicate that no state shall be saved or restored, which causes
    ///                          the target context to return to its default state after the command list executes. Applications should
    ///                          typically use <b>FALSE</b> unless they will restore the state to be nearly equivalent to the state that the
    ///                          runtime would restore if <b>TRUE</b> were passed. When applications use <b>FALSE</b>, they can avoid
    ///                          unnecessary and inefficient state transitions.
    void    ExecuteCommandList(ID3D11CommandList pCommandList, BOOL RestoreContextState);
    ///Bind an array of shader resources to the hull-shader stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin setting shader resources to (ranges from
    ///                0 to D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - 1).
    ///    NumViews = Type: <b>UINT</b> Number of shader resources to set. Up to a maximum of 128 slots are available for shader
    ///               resources(ranges from 0 to D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - StartSlot).
    ///    ppShaderResourceViews = Type: <b>ID3D11ShaderResourceView*</b> Array of shader resource view interfaces to set to the device.
    void    HSSetShaderResources(uint StartSlot, uint NumViews, ID3D11ShaderResourceView* ppShaderResourceViews);
    ///Set a hull shader to the device.
    ///Params:
    ///    pHullShader = Type: <b>ID3D11HullShader*</b> Pointer to a hull shader (see ID3D11HullShader). Passing in <b>NULL</b>
    ///                  disables the shader for this pipeline stage.
    ///    ppClassInstances = Type: <b>ID3D11ClassInstance*</b> A pointer to an array of class-instance interfaces (see
    ///                       ID3D11ClassInstance). Each interface used by a shader must have a corresponding class instance or the shader
    ///                       will get disabled. Set ppClassInstances to <b>NULL</b> if the shader does not use any interfaces.
    ///    NumClassInstances = Type: <b>UINT</b> The number of class-instance interfaces in the array.
    void    HSSetShader(ID3D11HullShader pHullShader, ID3D11ClassInstance* ppClassInstances, 
                        uint NumClassInstances);
    ///Set an array of sampler states to the hull-shader stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the zero-based array to begin setting samplers to (ranges from 0 to
    ///                D3D11_COMMONSHADER_SAMPLER_SLOT_COUNT - 1).
    ///    NumSamplers = Type: <b>UINT</b> Number of samplers in the array. Each pipeline stage has a total of 16 sampler slots
    ///                  available (ranges from 0 to D3D11_COMMONSHADER_SAMPLER_SLOT_COUNT - StartSlot).
    ///    ppSamplers = Type: <b>ID3D11SamplerState*</b> Pointer to an array of sampler-state interfaces (see ID3D11SamplerState).
    ///                 See Remarks.
    void    HSSetSamplers(uint StartSlot, uint NumSamplers, ID3D11SamplerState* ppSamplers);
    ///Set the constant buffers used by the hull-shader stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin setting constant buffers to (ranges from
    ///                0 to <b>D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT</b> - 1).
    ///    NumBuffers = Type: <b>UINT</b> Number of buffers to set (ranges from 0 to
    ///                 <b>D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT</b> - <i>StartSlot</i>).
    ///    ppConstantBuffers = Type: <b>ID3D11Buffer*</b> Array of constant buffers (see ID3D11Buffer) being given to the device.
    void    HSSetConstantBuffers(uint StartSlot, uint NumBuffers, ID3D11Buffer* ppConstantBuffers);
    ///Bind an array of shader resources to the domain-shader stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin setting shader resources to (ranges from
    ///                0 to D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - 1).
    ///    NumViews = Type: <b>UINT</b> Number of shader resources to set. Up to a maximum of 128 slots are available for shader
    ///               resources(ranges from 0 to D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - StartSlot).
    ///    ppShaderResourceViews = Type: <b>ID3D11ShaderResourceView*</b> Array of shader resource view interfaces to set to the device.
    void    DSSetShaderResources(uint StartSlot, uint NumViews, ID3D11ShaderResourceView* ppShaderResourceViews);
    ///Set a domain shader to the device.
    ///Params:
    ///    pDomainShader = Type: <b>ID3D11DomainShader*</b> Pointer to a domain shader (see ID3D11DomainShader). Passing in <b>NULL</b>
    ///                    disables the shader for this pipeline stage.
    ///    ppClassInstances = Type: <b>ID3D11ClassInstance*</b> A pointer to an array of class-instance interfaces (see
    ///                       ID3D11ClassInstance). Each interface used by a shader must have a corresponding class instance or the shader
    ///                       will get disabled. Set ppClassInstances to <b>NULL</b> if the shader does not use any interfaces.
    ///    NumClassInstances = Type: <b>UINT</b> The number of class-instance interfaces in the array.
    void    DSSetShader(ID3D11DomainShader pDomainShader, ID3D11ClassInstance* ppClassInstances, 
                        uint NumClassInstances);
    ///Set an array of sampler states to the domain-shader stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin setting samplers to (ranges from 0 to
    ///                D3D11_COMMONSHADER_SAMPLER_SLOT_COUNT - 1).
    ///    NumSamplers = Type: <b>UINT</b> Number of samplers in the array. Each pipeline stage has a total of 16 sampler slots
    ///                  available (ranges from 0 to D3D11_COMMONSHADER_SAMPLER_SLOT_COUNT - StartSlot).
    ///    ppSamplers = Type: <b>ID3D11SamplerState*</b> Pointer to an array of sampler-state interfaces (see ID3D11SamplerState).
    ///                 See Remarks.
    void    DSSetSamplers(uint StartSlot, uint NumSamplers, ID3D11SamplerState* ppSamplers);
    ///Sets the constant buffers used by the domain-shader stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the zero-based array to begin setting constant buffers to (ranges from 0 to
    ///                <b>D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT</b> - 1).
    ///    NumBuffers = Type: <b>UINT</b> Number of buffers to set (ranges from 0 to
    ///                 <b>D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT</b> - <i>StartSlot</i>).
    ///    ppConstantBuffers = Type: <b>ID3D11Buffer*</b> Array of constant buffers (see ID3D11Buffer) being given to the device.
    void    DSSetConstantBuffers(uint StartSlot, uint NumBuffers, ID3D11Buffer* ppConstantBuffers);
    ///Bind an array of shader resources to the compute-shader stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin setting shader resources to (ranges from
    ///                0 to D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - 1).
    ///    NumViews = Type: <b>UINT</b> Number of shader resources to set. Up to a maximum of 128 slots are available for shader
    ///               resources(ranges from 0 to D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - StartSlot).
    ///    ppShaderResourceViews = Type: <b>ID3D11ShaderResourceView*</b> Array of shader resource view interfaces to set to the device.
    void    CSSetShaderResources(uint StartSlot, uint NumViews, ID3D11ShaderResourceView* ppShaderResourceViews);
    ///Sets an array of views for an unordered resource.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index of the first element in the zero-based array to begin setting (ranges from 0 to
    ///                D3D11_1_UAV_SLOT_COUNT - 1). D3D11_1_UAV_SLOT_COUNT is defined as 64.
    ///    NumUAVs = Type: <b>UINT</b> Number of views to set (ranges from 0 to D3D11_1_UAV_SLOT_COUNT - <i>StartSlot</i>).
    ///    ppUnorderedAccessViews = Type: <b>ID3D11UnorderedAccessView*</b> A pointer to an array of ID3D11UnorderedAccessView pointers to be set
    ///                             by the method.
    ///    pUAVInitialCounts = Type: <b>const UINT*</b> An array of append and consume buffer offsets. A value of -1 indicates to keep the
    ///                        current offset. Any other values set the hidden counter for that appendable and consumable UAV.
    ///                        <i>pUAVInitialCounts</i> is only relevant for UAVs that were created with either D3D11_BUFFER_UAV_FLAG_APPEND
    ///                        or <b>D3D11_BUFFER_UAV_FLAG_COUNTER</b> specified when the UAV was created; otherwise, the argument is
    ///                        ignored.
    void    CSSetUnorderedAccessViews(uint StartSlot, uint NumUAVs, 
                                      ID3D11UnorderedAccessView* ppUnorderedAccessViews, 
                                      const(uint)* pUAVInitialCounts);
    ///Set a compute shader to the device.
    ///Params:
    ///    pComputeShader = Type: <b>ID3D11ComputeShader*</b> Pointer to a compute shader (see ID3D11ComputeShader). Passing in
    ///                     <b>NULL</b> disables the shader for this pipeline stage.
    ///    ppClassInstances = Type: <b>ID3D11ClassInstance*</b> A pointer to an array of class-instance interfaces (see
    ///                       ID3D11ClassInstance). Each interface used by a shader must have a corresponding class instance or the shader
    ///                       will get disabled. Set ppClassInstances to <b>NULL</b> if the shader does not use any interfaces.
    ///    NumClassInstances = Type: <b>UINT</b> The number of class-instance interfaces in the array.
    void    CSSetShader(ID3D11ComputeShader pComputeShader, ID3D11ClassInstance* ppClassInstances, 
                        uint NumClassInstances);
    ///Set an array of sampler states to the compute-shader stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin setting samplers to (ranges from 0 to
    ///                D3D11_COMMONSHADER_SAMPLER_SLOT_COUNT - 1).
    ///    NumSamplers = Type: <b>UINT</b> Number of samplers in the array. Each pipeline stage has a total of 16 sampler slots
    ///                  available (ranges from 0 to D3D11_COMMONSHADER_SAMPLER_SLOT_COUNT - StartSlot).
    ///    ppSamplers = Type: <b>ID3D11SamplerState*</b> Pointer to an array of sampler-state interfaces (see ID3D11SamplerState).
    ///                 See Remarks.
    void    CSSetSamplers(uint StartSlot, uint NumSamplers, ID3D11SamplerState* ppSamplers);
    ///Sets the constant buffers used by the compute-shader stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the zero-based array to begin setting constant buffers to (ranges from 0 to
    ///                <b>D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT</b> - 1).
    ///    NumBuffers = Type: <b>UINT</b> Number of buffers to set (ranges from 0 to
    ///                 <b>D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT</b> - <i>StartSlot</i>).
    ///    ppConstantBuffers = Type: <b>ID3D11Buffer*</b> Array of constant buffers (see ID3D11Buffer) being given to the device.
    void    CSSetConstantBuffers(uint StartSlot, uint NumBuffers, ID3D11Buffer* ppConstantBuffers);
    ///Get the constant buffers used by the vertex shader pipeline stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin retrieving constant buffers from (ranges
    ///                from 0 to D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1).
    ///    NumBuffers = Type: <b>UINT</b> Number of buffers to retrieve (ranges from 0 to
    ///                 D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - StartSlot).
    ///    ppConstantBuffers = Type: <b>ID3D11Buffer**</b> Array of constant buffer interface pointers (see ID3D11Buffer) to be returned by
    ///                        the method.
    void    VSGetConstantBuffers(uint StartSlot, uint NumBuffers, ID3D11Buffer* ppConstantBuffers);
    ///Get the pixel shader resources.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin getting shader resources from (ranges
    ///                from 0 to D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - 1).
    ///    NumViews = Type: <b>UINT</b> The number of resources to get from the device. Up to a maximum of 128 slots are available
    ///               for shader resources (ranges from 0 to D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - StartSlot).
    ///    ppShaderResourceViews = Type: <b>ID3D11ShaderResourceView**</b> Array of shader resource view interfaces to be returned by the
    ///                            device.
    void    PSGetShaderResources(uint StartSlot, uint NumViews, ID3D11ShaderResourceView* ppShaderResourceViews);
    ///Get the pixel shader currently set on the device.
    ///Params:
    ///    ppPixelShader = Type: <b>ID3D11PixelShader**</b> Address of a pointer to a pixel shader (see ID3D11PixelShader) to be
    ///                    returned by the method.
    ///    ppClassInstances = Type: <b>ID3D11ClassInstance**</b> Pointer to an array of class instance interfaces (see
    ///                       ID3D11ClassInstance).
    ///    pNumClassInstances = Type: <b>UINT*</b> The number of class-instance elements in the array.
    void    PSGetShader(ID3D11PixelShader* ppPixelShader, ID3D11ClassInstance* ppClassInstances, 
                        uint* pNumClassInstances);
    ///Get an array of sampler states from the pixel shader pipeline stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into a zero-based array to begin getting samplers from (ranges from 0 to
    ///                D3D11_COMMONSHADER_SAMPLER_SLOT_COUNT - 1).
    ///    NumSamplers = Type: <b>UINT</b> Number of samplers to get from a device context. Each pipeline stage has a total of 16
    ///                  sampler slots available (ranges from 0 to D3D11_COMMONSHADER_SAMPLER_SLOT_COUNT - StartSlot).
    ///    ppSamplers = Type: <b>ID3D11SamplerState**</b> Arry of sampler-state interface pointers (see ID3D11SamplerState) to be
    ///                 returned by the device.
    void    PSGetSamplers(uint StartSlot, uint NumSamplers, ID3D11SamplerState* ppSamplers);
    ///Get the vertex shader currently set on the device.
    ///Params:
    ///    ppVertexShader = Type: <b>ID3D11VertexShader**</b> Address of a pointer to a vertex shader (see ID3D11VertexShader) to be
    ///                     returned by the method.
    ///    ppClassInstances = Type: <b>ID3D11ClassInstance**</b> Pointer to an array of class instance interfaces (see
    ///                       ID3D11ClassInstance).
    ///    pNumClassInstances = Type: <b>UINT*</b> The number of class-instance elements in the array.
    void    VSGetShader(ID3D11VertexShader* ppVertexShader, ID3D11ClassInstance* ppClassInstances, 
                        uint* pNumClassInstances);
    ///Get the constant buffers used by the pixel shader pipeline stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin retrieving constant buffers from (ranges
    ///                from 0 to D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1).
    ///    NumBuffers = Type: <b>UINT</b> Number of buffers to retrieve (ranges from 0 to
    ///                 D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - StartSlot).
    ///    ppConstantBuffers = Type: <b>ID3D11Buffer**</b> Array of constant buffer interface pointers (see ID3D11Buffer) to be returned by
    ///                        the method.
    void    PSGetConstantBuffers(uint StartSlot, uint NumBuffers, ID3D11Buffer* ppConstantBuffers);
    ///Get a pointer to the input-layout object that is bound to the input-assembler stage.
    ///Params:
    ///    ppInputLayout = Type: <b>ID3D11InputLayout**</b> A pointer to the input-layout object (see ID3D11InputLayout), which
    ///                    describes the input buffers that will be read by the IA stage.
    void    IAGetInputLayout(ID3D11InputLayout* ppInputLayout);
    ///Get the vertex buffers bound to the input-assembler stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> The input slot of the first vertex buffer to get. The first vertex buffer is explicitly
    ///                bound to the start slot; this causes each additional vertex buffer in the array to be implicitly bound to
    ///                each subsequent input slot. The maximum of 16 or 32 input slots (ranges from 0 to
    ///                D3D11_IA_VERTEX_INPUT_RESOURCE_SLOT_COUNT - 1) are available; the maximum number of input slots depends on
    ///                the feature level.
    ///    NumBuffers = Type: <b>UINT</b> The number of vertex buffers to get starting at the offset. The number of buffers (plus the
    ///                 starting slot) cannot exceed the total number of IA-stage input slots.
    ///    ppVertexBuffers = Type: <b>ID3D11Buffer**</b> A pointer to an array of vertex buffers returned by the method (see
    ///                      ID3D11Buffer).
    ///    pStrides = Type: <b>UINT*</b> Pointer to an array of stride values returned by the method; one stride value for each
    ///               buffer in the vertex-buffer array. Each stride value is the size (in bytes) of the elements that are to be
    ///               used from that vertex buffer.
    ///    pOffsets = Type: <b>UINT*</b> Pointer to an array of offset values returned by the method; one offset value for each
    ///               buffer in the vertex-buffer array. Each offset is the number of bytes between the first element of a vertex
    ///               buffer and the first element that will be used.
    void    IAGetVertexBuffers(uint StartSlot, uint NumBuffers, ID3D11Buffer* ppVertexBuffers, uint* pStrides, 
                               uint* pOffsets);
    ///Get a pointer to the index buffer that is bound to the input-assembler stage.
    ///Params:
    ///    pIndexBuffer = Type: <b>ID3D11Buffer**</b> A pointer to an index buffer returned by the method (see ID3D11Buffer).
    ///    Format = Type: <b>DXGI_FORMAT*</b> Specifies format of the data in the index buffer (see DXGI_FORMAT). These formats
    ///             provide the size and type of the data in the buffer. The only formats allowed for index buffer data are
    ///             16-bit (DXGI_FORMAT_R16_UINT) and 32-bit (DXGI_FORMAT_R32_UINT) integers.
    ///    Offset = Type: <b>UINT*</b> Offset (in bytes) from the start of the index buffer, to the first index to use.
    void    IAGetIndexBuffer(ID3D11Buffer* pIndexBuffer, DXGI_FORMAT* Format, uint* Offset);
    ///Get the constant buffers used by the geometry shader pipeline stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin retrieving constant buffers from (ranges
    ///                from 0 to D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1).
    ///    NumBuffers = Type: <b>UINT</b> Number of buffers to retrieve (ranges from 0 to
    ///                 D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - StartSlot).
    ///    ppConstantBuffers = Type: <b>ID3D11Buffer**</b> Array of constant buffer interface pointers (see ID3D11Buffer) to be returned by
    ///                        the method.
    void    GSGetConstantBuffers(uint StartSlot, uint NumBuffers, ID3D11Buffer* ppConstantBuffers);
    ///Get the geometry shader currently set on the device.
    ///Params:
    ///    ppGeometryShader = Type: <b>ID3D11GeometryShader**</b> Address of a pointer to a geometry shader (see ID3D11GeometryShader) to
    ///                       be returned by the method.
    ///    ppClassInstances = Type: <b>ID3D11ClassInstance**</b> Pointer to an array of class instance interfaces (see
    ///                       ID3D11ClassInstance).
    ///    pNumClassInstances = Type: <b>UINT*</b> The number of class-instance elements in the array.
    void    GSGetShader(ID3D11GeometryShader* ppGeometryShader, ID3D11ClassInstance* ppClassInstances, 
                        uint* pNumClassInstances);
    ///Get information about the primitive type, and data order that describes input data for the input assembler stage.
    ///Params:
    ///    pTopology = Type: <b>D3D11_PRIMITIVE_TOPOLOGY*</b> A pointer to the type of primitive, and ordering of the primitive data
    ///                (see D3D11_PRIMITIVE_TOPOLOGY).
    void    IAGetPrimitiveTopology(D3D_PRIMITIVE_TOPOLOGY* pTopology);
    ///Get the vertex shader resources.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin getting shader resources from (ranges
    ///                from 0 to D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - 1).
    ///    NumViews = Type: <b>UINT</b> The number of resources to get from the device. Up to a maximum of 128 slots are available
    ///               for shader resources (ranges from 0 to D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - StartSlot).
    ///    ppShaderResourceViews = Type: <b>ID3D11ShaderResourceView**</b> Array of shader resource view interfaces to be returned by the
    ///                            device.
    void    VSGetShaderResources(uint StartSlot, uint NumViews, ID3D11ShaderResourceView* ppShaderResourceViews);
    ///Get an array of sampler states from the vertex shader pipeline stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into a zero-based array to begin getting samplers from (ranges from 0 to
    ///                D3D11_COMMONSHADER_SAMPLER_SLOT_COUNT - 1).
    ///    NumSamplers = Type: <b>UINT</b> Number of samplers to get from a device context. Each pipeline stage has a total of 16
    ///                  sampler slots available (ranges from 0 to D3D11_COMMONSHADER_SAMPLER_SLOT_COUNT - StartSlot).
    ///    ppSamplers = Type: <b>ID3D11SamplerState**</b> Arry of sampler-state interface pointers (see ID3D11SamplerState) to be
    ///                 returned by the device.
    void    VSGetSamplers(uint StartSlot, uint NumSamplers, ID3D11SamplerState* ppSamplers);
    ///Get the rendering predicate state.
    ///Params:
    ///    ppPredicate = Type: <b>ID3D11Predicate**</b> Address of a pointer to a predicate (see ID3D11Predicate). Value stored here
    ///                  will be <b>NULL</b> upon device creation.
    ///    pPredicateValue = Type: <b>BOOL*</b> Address of a boolean to fill with the predicate comparison value. <b>FALSE</b> upon device
    ///                      creation.
    void    GetPredication(ID3D11Predicate* ppPredicate, BOOL* pPredicateValue);
    ///Get the geometry shader resources.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin getting shader resources from (ranges
    ///                from 0 to D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - 1).
    ///    NumViews = Type: <b>UINT</b> The number of resources to get from the device. Up to a maximum of 128 slots are available
    ///               for shader resources (ranges from 0 to D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - StartSlot).
    ///    ppShaderResourceViews = Type: <b>ID3D11ShaderResourceView**</b> Array of shader resource view interfaces to be returned by the
    ///                            device.
    void    GSGetShaderResources(uint StartSlot, uint NumViews, ID3D11ShaderResourceView* ppShaderResourceViews);
    ///Get an array of sampler state interfaces from the geometry shader pipeline stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into a zero-based array to begin getting samplers from (ranges from 0 to
    ///                D3D11_COMMONSHADER_SAMPLER_SLOT_COUNT - 1).
    ///    NumSamplers = Type: <b>UINT</b> Number of samplers to get from a device context. Each pipeline stage has a total of 16
    ///                  sampler slots available (ranges from 0 to D3D11_COMMONSHADER_SAMPLER_SLOT_COUNT - StartSlot).
    ///    ppSamplers = Type: <b>ID3D11SamplerState**</b> Pointer to an array of sampler-state interfaces (see ID3D11SamplerState).
    void    GSGetSamplers(uint StartSlot, uint NumSamplers, ID3D11SamplerState* ppSamplers);
    ///Get pointers to the resources bound to the output-merger stage.
    ///Params:
    ///    NumViews = Type: <b>UINT</b> Number of render targets to retrieve.
    ///    ppRenderTargetViews = Type: <b>ID3D11RenderTargetView**</b> Pointer to an array of ID3D11RenderTargetViews which represent render
    ///                          target views. Specify <b>NULL</b> for this parameter when retrieval of a render target is not needed.
    ///    ppDepthStencilView = Type: <b>ID3D11DepthStencilView**</b> Pointer to a ID3D11DepthStencilView, which represents a depth-stencil
    ///                         view. Specify <b>NULL</b> for this parameter when retrieval of the depth-stencil view is not needed.
    void    OMGetRenderTargets(uint NumViews, ID3D11RenderTargetView* ppRenderTargetViews, 
                               ID3D11DepthStencilView* ppDepthStencilView);
    ///Get pointers to the resources bound to the output-merger stage.
    ///Params:
    ///    NumRTVs = Type: <b>UINT</b> The number of render-target views to retrieve.
    ///    ppRenderTargetViews = Type: <b>ID3D11RenderTargetView**</b> Pointer to an array of ID3D11RenderTargetViews, which represent
    ///                          render-target views. Specify <b>NULL</b> for this parameter when retrieval of render-target views is not
    ///                          required.
    ///    ppDepthStencilView = Type: <b>ID3D11DepthStencilView**</b> Pointer to a ID3D11DepthStencilView, which represents a depth-stencil
    ///                         view. Specify <b>NULL</b> for this parameter when retrieval of the depth-stencil view is not required.
    ///    UAVStartSlot = Type: <b>UINT</b> Index into a zero-based array to begin retrieving unordered-access views (ranges from 0 to
    ///                   D3D11_PS_CS_UAV_REGISTER_COUNT - 1). For pixel shaders <i>UAVStartSlot</i> should be equal to the number of
    ///                   render-target views that are bound.
    ///    NumUAVs = Type: <b>UINT</b> Number of unordered-access views to return in <i>ppUnorderedAccessViews</i>. This number
    ///              ranges from 0 to D3D11_PS_CS_UAV_REGISTER_COUNT - <i>UAVStartSlot</i>.
    ///    ppUnorderedAccessViews = Type: <b>ID3D11UnorderedAccessView**</b> Pointer to an array of ID3D11UnorderedAccessViews, which represent
    ///                             unordered-access views that are retrieved. Specify <b>NULL</b> for this parameter when retrieval of
    ///                             unordered-access views is not required.
    void    OMGetRenderTargetsAndUnorderedAccessViews(uint NumRTVs, ID3D11RenderTargetView* ppRenderTargetViews, 
                                                      ID3D11DepthStencilView* ppDepthStencilView, uint UAVStartSlot, 
                                                      uint NumUAVs, 
                                                      ID3D11UnorderedAccessView* ppUnorderedAccessViews);
    ///Get the blend state of the output-merger stage.
    ///Params:
    ///    ppBlendState = Type: <b>ID3D11BlendState**</b> Address of a pointer to a blend-state interface (see ID3D11BlendState).
    ///    BlendFactor = Type: <b>FLOAT[4]</b> Array of blend factors, one for each RGBA component.
    ///    pSampleMask = Type: <b>UINT*</b> Pointer to a sample mask.
    void    OMGetBlendState(ID3D11BlendState* ppBlendState, float* BlendFactor, uint* pSampleMask);
    ///Gets the depth-stencil state of the output-merger stage.
    ///Params:
    ///    ppDepthStencilState = Type: <b>ID3D11DepthStencilState**</b> Address of a pointer to a depth-stencil state interface (see
    ///                          ID3D11DepthStencilState) to be filled with information from the device.
    ///    pStencilRef = Type: <b>UINT*</b> Pointer to the stencil reference value used in the depth-stencil test.
    void    OMGetDepthStencilState(ID3D11DepthStencilState* ppDepthStencilState, uint* pStencilRef);
    ///Get the target output buffers for the stream-output stage of the pipeline.
    ///Params:
    ///    NumBuffers = Type: <b>UINT</b> Number of buffers to get.
    ///    ppSOTargets = Type: <b>ID3D11Buffer**</b> An array of output buffers (see ID3D11Buffer) to be retrieved from the device.
    void    SOGetTargets(uint NumBuffers, ID3D11Buffer* ppSOTargets);
    ///Get the rasterizer state from the rasterizer stage of the pipeline.
    ///Params:
    ///    ppRasterizerState = Type: <b>ID3D11RasterizerState**</b> Address of a pointer to a rasterizer-state interface (see
    ///                        ID3D11RasterizerState) to fill with information from the device.
    void    RSGetState(ID3D11RasterizerState* ppRasterizerState);
    ///Gets the array of viewports bound to the rasterizer stage.
    ///Params:
    ///    pNumViewports = Type: <b>UINT*</b> A pointer to a variable that, on input, specifies the number of viewports (ranges from 0
    ///                    to <b>D3D11_VIEWPORT_AND_SCISSORRECT_OBJECT_COUNT_PER_PIPELINE</b>) in the <i>pViewports</i> array; on
    ///                    output, the variable contains the actual number of viewports that are bound to the rasterizer stage. If
    ///                    <i>pViewports</i> is <b>NULL</b>, <b>RSGetViewports</b> fills the variable with the number of viewports
    ///                    currently bound. <div class="alert"><b>Note</b> In some versions of the Windows SDK, a debug device will
    ///                    raise an exception if the input value in the variable to which <i>pNumViewports</i> points is greater than
    ///                    <b>D3D11_VIEWPORT_AND_SCISSORRECT_OBJECT_COUNT_PER_PIPELINE</b> even if <i>pViewports</i> is <b>NULL</b>. The
    ///                    regular runtime ignores the value in the variable to which <i>pNumViewports</i> points when <i>pViewports</i>
    ///                    is <b>NULL</b>. This behavior of a debug device might be corrected in a future release of the Windows SDK.
    ///                    </div> <div> </div>
    ///    pViewports = Type: <b>D3D11_VIEWPORT*</b> An array of D3D11_VIEWPORT structures for the viewports that are bound to the
    ///                 rasterizer stage. If the number of viewports (in the variable to which <i>pNumViewports</i> points) is
    ///                 greater than the actual number of viewports currently bound, unused elements of the array contain 0. For info
    ///                 about how the viewport size depends on the device feature level, which has changed between Direct3D 11 and
    ///                 Direct3D 10, see <b>D3D11_VIEWPORT</b>.
    void    RSGetViewports(uint* pNumViewports, D3D11_VIEWPORT* pViewports);
    ///Get the array of scissor rectangles bound to the rasterizer stage.
    ///Params:
    ///    pNumRects = Type: <b>UINT*</b> The number of scissor rectangles (ranges between 0 and
    ///                D3D11_VIEWPORT_AND_SCISSORRECT_OBJECT_COUNT_PER_PIPELINE) bound; set <i>pRects</i> to <b>NULL</b> to use
    ///                <i>pNumRects</i> to see how many rectangles would be returned.
    ///    pRects = Type: <b>D3D11_RECT*</b> An array of scissor rectangles (see D3D11_RECT). If NumRects is greater than the
    ///             number of scissor rects currently bound, then unused members of the array will contain 0.
    void    RSGetScissorRects(uint* pNumRects, RECT* pRects);
    ///Get the hull-shader resources.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin getting shader resources from (ranges
    ///                from 0 to D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - 1).
    ///    NumViews = Type: <b>UINT</b> The number of resources to get from the device. Up to a maximum of 128 slots are available
    ///               for shader resources (ranges from 0 to D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - StartSlot).
    ///    ppShaderResourceViews = Type: <b>ID3D11ShaderResourceView**</b> Array of shader resource view interfaces to be returned by the
    ///                            device.
    void    HSGetShaderResources(uint StartSlot, uint NumViews, ID3D11ShaderResourceView* ppShaderResourceViews);
    ///Get the hull shader currently set on the device.
    ///Params:
    ///    ppHullShader = Type: <b>ID3D11HullShader**</b> Address of a pointer to a hull shader (see ID3D11HullShader) to be returned
    ///                   by the method.
    ///    ppClassInstances = Type: <b>ID3D11ClassInstance**</b> Pointer to an array of class instance interfaces (see
    ///                       ID3D11ClassInstance).
    ///    pNumClassInstances = Type: <b>UINT*</b> The number of class-instance elements in the array.
    void    HSGetShader(ID3D11HullShader* ppHullShader, ID3D11ClassInstance* ppClassInstances, 
                        uint* pNumClassInstances);
    ///Get an array of sampler state interfaces from the hull-shader stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into a zero-based array to begin getting samplers from (ranges from 0 to
    ///                D3D11_COMMONSHADER_SAMPLER_SLOT_COUNT - 1).
    ///    NumSamplers = Type: <b>UINT</b> Number of samplers to get from a device context. Each pipeline stage has a total of 16
    ///                  sampler slots available (ranges from 0 to D3D11_COMMONSHADER_SAMPLER_SLOT_COUNT - StartSlot).
    ///    ppSamplers = Type: <b>ID3D11SamplerState**</b> Pointer to an array of sampler-state interfaces (see ID3D11SamplerState).
    void    HSGetSamplers(uint StartSlot, uint NumSamplers, ID3D11SamplerState* ppSamplers);
    ///Get the constant buffers used by the hull-shader stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin retrieving constant buffers from (ranges
    ///                from 0 to D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1).
    ///    NumBuffers = Type: <b>UINT</b> Number of buffers to retrieve (ranges from 0 to
    ///                 D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - StartSlot).
    ///    ppConstantBuffers = Type: <b>ID3D11Buffer**</b> Array of constant buffer interface pointers (see ID3D11Buffer) to be returned by
    ///                        the method.
    void    HSGetConstantBuffers(uint StartSlot, uint NumBuffers, ID3D11Buffer* ppConstantBuffers);
    ///Get the domain-shader resources.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin getting shader resources from (ranges
    ///                from 0 to D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - 1).
    ///    NumViews = Type: <b>UINT</b> The number of resources to get from the device. Up to a maximum of 128 slots are available
    ///               for shader resources (ranges from 0 to D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - StartSlot).
    ///    ppShaderResourceViews = Type: <b>ID3D11ShaderResourceView**</b> Array of shader resource view interfaces to be returned by the
    ///                            device.
    void    DSGetShaderResources(uint StartSlot, uint NumViews, ID3D11ShaderResourceView* ppShaderResourceViews);
    ///Get the domain shader currently set on the device.
    ///Params:
    ///    ppDomainShader = Type: <b>ID3D11DomainShader**</b> Address of a pointer to a domain shader (see ID3D11DomainShader) to be
    ///                     returned by the method.
    ///    ppClassInstances = Type: <b>ID3D11ClassInstance**</b> Pointer to an array of class instance interfaces (see
    ///                       ID3D11ClassInstance).
    ///    pNumClassInstances = Type: <b>UINT*</b> The number of class-instance elements in the array.
    void    DSGetShader(ID3D11DomainShader* ppDomainShader, ID3D11ClassInstance* ppClassInstances, 
                        uint* pNumClassInstances);
    ///Get an array of sampler state interfaces from the domain-shader stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into a zero-based array to begin getting samplers from (ranges from 0 to
    ///                D3D11_COMMONSHADER_SAMPLER_SLOT_COUNT - 1).
    ///    NumSamplers = Type: <b>UINT</b> Number of samplers to get from a device context. Each pipeline stage has a total of 16
    ///                  sampler slots available (ranges from 0 to D3D11_COMMONSHADER_SAMPLER_SLOT_COUNT - StartSlot).
    ///    ppSamplers = Type: <b>ID3D11SamplerState**</b> Pointer to an array of sampler-state interfaces (see ID3D11SamplerState).
    void    DSGetSamplers(uint StartSlot, uint NumSamplers, ID3D11SamplerState* ppSamplers);
    ///Get the constant buffers used by the domain-shader stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin retrieving constant buffers from (ranges
    ///                from 0 to D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1).
    ///    NumBuffers = Type: <b>UINT</b> Number of buffers to retrieve (ranges from 0 to
    ///                 D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - StartSlot).
    ///    ppConstantBuffers = Type: <b>ID3D11Buffer**</b> Array of constant buffer interface pointers (see ID3D11Buffer) to be returned by
    ///                        the method.
    void    DSGetConstantBuffers(uint StartSlot, uint NumBuffers, ID3D11Buffer* ppConstantBuffers);
    ///Get the compute-shader resources.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin getting shader resources from (ranges
    ///                from 0 to D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - 1).
    ///    NumViews = Type: <b>UINT</b> The number of resources to get from the device. Up to a maximum of 128 slots are available
    ///               for shader resources (ranges from 0 to D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - StartSlot).
    ///    ppShaderResourceViews = Type: <b>ID3D11ShaderResourceView**</b> Array of shader resource view interfaces to be returned by the
    ///                            device.
    void    CSGetShaderResources(uint StartSlot, uint NumViews, ID3D11ShaderResourceView* ppShaderResourceViews);
    ///Gets an array of views for an unordered resource.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index of the first element in the zero-based array to return (ranges from 0 to
    ///                D3D11_1_UAV_SLOT_COUNT - 1).
    ///    NumUAVs = Type: <b>UINT</b> Number of views to get (ranges from 0 to D3D11_1_UAV_SLOT_COUNT - StartSlot).
    ///    ppUnorderedAccessViews = Type: <b>ID3D11UnorderedAccessView**</b> A pointer to an array of interface pointers (see
    ///                             ID3D11UnorderedAccessView) to get.
    void    CSGetUnorderedAccessViews(uint StartSlot, uint NumUAVs, 
                                      ID3D11UnorderedAccessView* ppUnorderedAccessViews);
    ///Get the compute shader currently set on the device.
    ///Params:
    ///    ppComputeShader = Type: <b>ID3D11ComputeShader**</b> Address of a pointer to a Compute shader (see ID3D11ComputeShader) to be
    ///                      returned by the method.
    ///    ppClassInstances = Type: <b>ID3D11ClassInstance**</b> Pointer to an array of class instance interfaces (see
    ///                       ID3D11ClassInstance).
    ///    pNumClassInstances = Type: <b>UINT*</b> The number of class-instance elements in the array.
    void    CSGetShader(ID3D11ComputeShader* ppComputeShader, ID3D11ClassInstance* ppClassInstances, 
                        uint* pNumClassInstances);
    ///Get an array of sampler state interfaces from the compute-shader stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into a zero-based array to begin getting samplers from (ranges from 0 to
    ///                D3D11_COMMONSHADER_SAMPLER_SLOT_COUNT - 1).
    ///    NumSamplers = Type: <b>UINT</b> Number of samplers to get from a device context. Each pipeline stage has a total of 16
    ///                  sampler slots available (ranges from 0 to D3D11_COMMONSHADER_SAMPLER_SLOT_COUNT - StartSlot).
    ///    ppSamplers = Type: <b>ID3D11SamplerState**</b> Pointer to an array of sampler-state interfaces (see ID3D11SamplerState).
    void    CSGetSamplers(uint StartSlot, uint NumSamplers, ID3D11SamplerState* ppSamplers);
    ///Get the constant buffers used by the compute-shader stage.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin retrieving constant buffers from (ranges
    ///                from 0 to D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1).
    ///    NumBuffers = Type: <b>UINT</b> Number of buffers to retrieve (ranges from 0 to
    ///                 D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - StartSlot).
    ///    ppConstantBuffers = Type: <b>ID3D11Buffer**</b> Array of constant buffer interface pointers (see ID3D11Buffer) to be returned by
    ///                        the method.
    void    CSGetConstantBuffers(uint StartSlot, uint NumBuffers, ID3D11Buffer* ppConstantBuffers);
    ///Restore all default settings.
    void    ClearState();
    ///Sends queued-up commands in the command buffer to the graphics processing unit (GPU).
    void    Flush();
    ///Gets the type of device context.
    ///Returns:
    ///    Type: <b>D3D11_DEVICE_CONTEXT_TYPE</b> A member of D3D11_DEVICE_CONTEXT_TYPE that indicates the type of
    ///    device context.
    ///    
    D3D11_DEVICE_CONTEXT_TYPE GetType();
    ///Gets the initialization flags associated with the current deferred context.
    uint    GetContextFlags();
    ///Create a command list and record graphics commands into it.
    ///Params:
    ///    RestoreDeferredContextState = Type: <b>BOOL</b> A Boolean flag that determines whether the runtime saves deferred context state before it
    ///                                  executes <b>FinishCommandList</b> and restores it afterwards. Use <b>TRUE</b> to indicate that the runtime
    ///                                  needs to save and restore the state. Use <b>FALSE</b> to indicate that the runtime will not save or restore
    ///                                  any state. In this case, the deferred context will return to its default state after the call to
    ///                                  <b>FinishCommandList</b> completes. For information about default state, see ID3D11DeviceContext::ClearState.
    ///                                  Typically, use <b>FALSE</b> unless you restore the state to be nearly equivalent to the state that the
    ///                                  runtime would restore if you passed <b>TRUE</b>. When you use <b>FALSE</b>, you can avoid unnecessary and
    ///                                  inefficient state transitions. <div class="alert"><b>Note</b> This parameter does not affect the command list
    ///                                  that the current call to <b>FinishCommandList</b> returns. However, this parameter affects the command list
    ///                                  of the next call to <b>FinishCommandList</b> on the same deferred context. </div> <div> </div>
    ///    ppCommandList = Type: <b>ID3D11CommandList**</b> Upon completion of the method, the passed pointer to an ID3D11CommandList
    ///                    interface pointer is initialized with the recorded command list information. The resulting
    ///                    <b>ID3D11CommandList</b> object is immutable and can only be used with
    ///                    ID3D11DeviceContext::ExecuteCommandList.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the following: <ul> <li>Returns
    ///    DXGI_ERROR_DEVICE_REMOVED if the video card has been physically removed from the system, or a driver upgrade
    ///    for the video card has occurred. If this error occurs, you should destroy and recreate the device.</li>
    ///    <li>Returns DXGI_ERROR_INVALID_CALL if <b>FinishCommandList</b> cannot be called from the current context.
    ///    See remarks. </li> <li>Returns E_OUTOFMEMORY if the application has exhausted available memory.</li> </ul>
    ///    
    HRESULT FinishCommandList(BOOL RestoreDeferredContextState, ID3D11CommandList* ppCommandList);
}

///The device interface represents a virtual adapter; it is used to create resources. <div class="alert"><b>Note</b> The
///latest version of this interface is ID3D11Device5 introduced in the Windows 10 Creators Update. Applications
///targetting Windows 10 Creators Update should use the <b>ID3D11Device5</b> interface instead of
///<b>ID3D11Device</b>.</div><div> </div>
@GUID("DB6F6DDB-AC77-4E88-8253-819DF9BBF140")
interface ID3D11Device : IUnknown
{
    ///Creates a buffer (vertex buffer, index buffer, or shader-constant buffer).
    ///Params:
    ///    pDesc = Type: <b>const D3D11_BUFFER_DESC*</b> A pointer to a D3D11_BUFFER_DESC structure that describes the buffer.
    ///    pInitialData = Type: <b>const D3D11_SUBRESOURCE_DATA*</b> A pointer to a D3D11_SUBRESOURCE_DATA structure that describes the
    ///                   initialization data; use <b>NULL</b> to allocate space only (with the exception that it cannot be <b>NULL</b>
    ///                   if the usage flag is <b>D3D11_USAGE_IMMUTABLE</b>). If you don't pass anything to <i>pInitialData</i>, the
    ///                   initial content of the memory for the buffer is undefined. In this case, you need to write the buffer content
    ///                   some other way before the resource is read.
    ///    ppBuffer = Type: <b>ID3D11Buffer**</b> Address of a pointer to the ID3D11Buffer interface for the buffer object created.
    ///               Set this parameter to <b>NULL</b> to validate the other input parameters (<b>S_FALSE</b> indicates a pass).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns <b>E_OUTOFMEMORY</b> if there is insufficient memory to create the
    ///    buffer. See Direct3D 11 Return Codes for other possible return values.
    ///    
    HRESULT CreateBuffer(const(D3D11_BUFFER_DESC)* pDesc, const(D3D11_SUBRESOURCE_DATA)* pInitialData, 
                         ID3D11Buffer* ppBuffer);
    ///Creates an array of 1D textures.
    ///Params:
    ///    pDesc = Type: <b>const D3D11_TEXTURE1D_DESC*</b> A pointer to a D3D11_TEXTURE1D_DESC structure that describes a 1D
    ///            texture resource. To create a typeless resource that can be interpreted at runtime into different, compatible
    ///            formats, specify a typeless format in the texture description. To generate mipmap levels automatically, set
    ///            the number of mipmap levels to 0.
    ///    pInitialData = Type: <b>const D3D11_SUBRESOURCE_DATA*</b> A pointer to an array of D3D11_SUBRESOURCE_DATA structures that
    ///                   describe subresources for the 1D texture resource. Applications can't specify <b>NULL</b> for
    ///                   <i>pInitialData</i> when creating IMMUTABLE resources (see D3D11_USAGE). If the resource is multisampled,
    ///                   <i>pInitialData</i> must be <b>NULL</b> because multisampled resources cannot be initialized with data when
    ///                   they are created. If you don't pass anything to <i>pInitialData</i>, the initial content of the memory for
    ///                   the resource is undefined. In this case, you need to write the resource content some other way before the
    ///                   resource is read. You can determine the size of this array from values in the <b>MipLevels</b> and
    ///                   <b>ArraySize</b> members of the D3D11_TEXTURE1D_DESC structure to which <i>pDesc</i> points by using the
    ///                   following calculation: MipLevels * ArraySize For more information about this array size, see Remarks.
    ///    ppTexture1D = Type: <b>ID3D11Texture1D**</b> A pointer to a buffer that receives a pointer to a ID3D11Texture1D interface
    ///                  for the created texture. Set this parameter to <b>NULL</b> to validate the other input parameters (the method
    ///                  will return S_FALSE if the other input parameters pass validation).
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return code is S_OK. See Direct3D 11 Return Codes for
    ///    failing error codes.
    ///    
    HRESULT CreateTexture1D(const(D3D11_TEXTURE1D_DESC)* pDesc, const(D3D11_SUBRESOURCE_DATA)* pInitialData, 
                            ID3D11Texture1D* ppTexture1D);
    ///Create an array of 2D textures.
    ///Params:
    ///    pDesc = Type: <b>const D3D11_TEXTURE2D_DESC*</b> A pointer to a D3D11_TEXTURE2D_DESC structure that describes a 2D
    ///            texture resource. To create a typeless resource that can be interpreted at runtime into different, compatible
    ///            formats, specify a typeless format in the texture description. To generate mipmap levels automatically, set
    ///            the number of mipmap levels to 0.
    ///    pInitialData = Type: <b>const D3D11_SUBRESOURCE_DATA*</b> A pointer to an array of D3D11_SUBRESOURCE_DATA structures that
    ///                   describe subresources for the 2D texture resource. Applications can't specify <b>NULL</b> for
    ///                   <i>pInitialData</i> when creating IMMUTABLE resources (see D3D11_USAGE). If the resource is multisampled,
    ///                   <i>pInitialData</i> must be <b>NULL</b> because multisampled resources cannot be initialized with data when
    ///                   they are created. If you don't pass anything to <i>pInitialData</i>, the initial content of the memory for
    ///                   the resource is undefined. In this case, you need to write the resource content some other way before the
    ///                   resource is read. You can determine the size of this array from values in the <b>MipLevels</b> and
    ///                   <b>ArraySize</b> members of the D3D11_TEXTURE2D_DESC structure to which <i>pDesc</i> points by using the
    ///                   following calculation: MipLevels * ArraySize For more information about this array size, see Remarks.
    ///    ppTexture2D = Type: <b>ID3D11Texture2D**</b> A pointer to a buffer that receives a pointer to a ID3D11Texture2D interface
    ///                  for the created texture. Set this parameter to <b>NULL</b> to validate the other input parameters (the method
    ///                  will return S_FALSE if the other input parameters pass validation).
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return code is S_OK. See Direct3D 11 Return Codes for
    ///    failing error codes.
    ///    
    HRESULT CreateTexture2D(const(D3D11_TEXTURE2D_DESC)* pDesc, const(D3D11_SUBRESOURCE_DATA)* pInitialData, 
                            ID3D11Texture2D* ppTexture2D);
    ///Create a single 3D texture.
    ///Params:
    ///    pDesc = Type: <b>const D3D11_TEXTURE3D_DESC*</b> A pointer to a D3D11_TEXTURE3D_DESC structure that describes a 3D
    ///            texture resource. To create a typeless resource that can be interpreted at runtime into different, compatible
    ///            formats, specify a typeless format in the texture description. To generate mipmap levels automatically, set
    ///            the number of mipmap levels to 0.
    ///    pInitialData = Type: <b>const D3D11_SUBRESOURCE_DATA*</b> A pointer to an array of D3D11_SUBRESOURCE_DATA structures that
    ///                   describe subresources for the 3D texture resource. Applications cannot specify <b>NULL</b> for
    ///                   <i>pInitialData</i> when creating IMMUTABLE resources (see D3D11_USAGE). If the resource is multisampled,
    ///                   <i>pInitialData</i> must be <b>NULL</b> because multisampled resources cannot be initialized with data when
    ///                   they are created. If you don't pass anything to <i>pInitialData</i>, the initial content of the memory for
    ///                   the resource is undefined. In this case, you need to write the resource content some other way before the
    ///                   resource is read. You can determine the size of this array from the value in the <b>MipLevels</b> member of
    ///                   the D3D11_TEXTURE3D_DESC structure to which <i>pDesc</i> points. Arrays of 3D volume textures are not
    ///                   supported. For more information about this array size, see Remarks.
    ///    ppTexture3D = Type: <b>ID3D11Texture3D**</b> A pointer to a buffer that receives a pointer to a ID3D11Texture3D interface
    ///                  for the created texture. Set this parameter to <b>NULL</b> to validate the other input parameters (the method
    ///                  will return S_FALSE if the other input parameters pass validation).
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return code is S_OK. See Direct3D 11 Return Codes for
    ///    failing error codes.
    ///    
    HRESULT CreateTexture3D(const(D3D11_TEXTURE3D_DESC)* pDesc, const(D3D11_SUBRESOURCE_DATA)* pInitialData, 
                            ID3D11Texture3D* ppTexture3D);
    ///Create a shader-resource view for accessing data in a resource.
    ///Params:
    ///    pResource = Type: <b>ID3D11Resource*</b> Pointer to the resource that will serve as input to a shader. This resource must
    ///                have been created with the <a
    ///                href="/windows/desktop/api/d3d11/ne-d3d11-d3d11_bind_flag">D3D11_BIND_SHADER_RESOURCE </a> flag.
    ///    pDesc = Type: <b>const D3D11_SHADER_RESOURCE_VIEW_DESC*</b> Pointer to a shader-resource view description (see
    ///            D3D11_SHADER_RESOURCE_VIEW_DESC). Set this parameter to <b>NULL</b> to create a view that accesses the entire
    ///            resource (using the format the resource was created with).
    ///    ppSRView = Type: <b>ID3D11ShaderResourceView**</b> Address of a pointer to an ID3D11ShaderResourceView. Set this
    ///               parameter to <b>NULL</b> to validate the other input parameters (the method will return <b>S_FALSE</b> if the
    ///               other input parameters pass validation).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT CreateShaderResourceView(ID3D11Resource pResource, const(D3D11_SHADER_RESOURCE_VIEW_DESC)* pDesc, 
                                     ID3D11ShaderResourceView* ppSRView);
    ///Creates a view for accessing an unordered access resource.
    ///Params:
    ///    pResource = Type: <b>ID3D11Resource*</b> Pointer to an ID3D11Resource that represents a resources that will serve as an
    ///                input to a shader.
    ///    pDesc = Type: <b>const D3D11_UNORDERED_ACCESS_VIEW_DESC*</b> Pointer to an D3D11_UNORDERED_ACCESS_VIEW_DESC that
    ///            represents a shader-resource view description. Set this parameter to <b>NULL</b> to create a view that
    ///            accesses the entire resource (using the format the resource was created with).
    ///    ppUAView = Type: <b>ID3D11UnorderedAccessView**</b> Address of a pointer to an ID3D11UnorderedAccessView that represents
    ///               an unordered-access view. Set this parameter to <b>NULL</b> to validate the other input parameters (the
    ///               method will return S_FALSE if the other input parameters pass validation).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT CreateUnorderedAccessView(ID3D11Resource pResource, const(D3D11_UNORDERED_ACCESS_VIEW_DESC)* pDesc, 
                                      ID3D11UnorderedAccessView* ppUAView);
    ///Creates a render-target view for accessing resource data.
    ///Params:
    ///    pResource = Type: <b>ID3D11Resource*</b> Pointer to a ID3D11Resource that represents a render target. This resource must
    ///                have been created with the D3D11_BIND_RENDER_TARGET flag.
    ///    pDesc = Type: <b>const D3D11_RENDER_TARGET_VIEW_DESC*</b> Pointer to a D3D11_RENDER_TARGET_VIEW_DESC that represents
    ///            a render-target view description. Set this parameter to <b>NULL</b> to create a view that accesses all of the
    ///            subresources in mipmap level 0.
    ///    ppRTView = Type: <b>ID3D11RenderTargetView**</b> Address of a pointer to an ID3D11RenderTargetView. Set this parameter
    ///               to <b>NULL</b> to validate the other input parameters (the method will return S_FALSE if the other input
    ///               parameters pass validation).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT CreateRenderTargetView(ID3D11Resource pResource, const(D3D11_RENDER_TARGET_VIEW_DESC)* pDesc, 
                                   ID3D11RenderTargetView* ppRTView);
    ///Create a depth-stencil view for accessing resource data.
    ///Params:
    ///    pResource = Type: <b>ID3D11Resource*</b> Pointer to the resource that will serve as the depth-stencil surface. This
    ///                resource must have been created with the D3D11_BIND_DEPTH_STENCIL flag.
    ///    pDesc = Type: <b>const D3D11_DEPTH_STENCIL_VIEW_DESC*</b> Pointer to a depth-stencil-view description (see
    ///            D3D11_DEPTH_STENCIL_VIEW_DESC). Set this parameter to <b>NULL</b> to create a view that accesses mipmap level
    ///            0 of the entire resource (using the format the resource was created with).
    ///    ppDepthStencilView = Type: <b>ID3D11DepthStencilView**</b> Address of a pointer to an ID3D11DepthStencilView. Set this parameter
    ///                         to <b>NULL</b> to validate the other input parameters (the method will return S_FALSE if the other input
    ///                         parameters pass validation).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT CreateDepthStencilView(ID3D11Resource pResource, const(D3D11_DEPTH_STENCIL_VIEW_DESC)* pDesc, 
                                   ID3D11DepthStencilView* ppDepthStencilView);
    ///Create an input-layout object to describe the input-buffer data for the input-assembler stage.
    ///Params:
    ///    pInputElementDescs = Type: <b>const D3D11_INPUT_ELEMENT_DESC*</b> An array of the input-assembler stage input data types; each
    ///                         type is described by an element description (see D3D11_INPUT_ELEMENT_DESC).
    ///    NumElements = Type: <b>UINT</b> The number of input-data types in the array of input-elements.
    ///    pShaderBytecodeWithInputSignature = Type: <b>const void*</b> A pointer to the compiled shader. The compiled shader code contains a input
    ///                                        signature which is validated against the array of elements. See remarks.
    ///    BytecodeLength = Type: <b>SIZE_T</b> Size of the compiled shader.
    ///    ppInputLayout = Type: <b>ID3D11InputLayout**</b> A pointer to the input-layout object created (see ID3D11InputLayout). To
    ///                    validate the other input parameters, set this pointer to be <b>NULL</b> and verify that the method returns
    ///                    S_FALSE.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return code is S_OK. See Direct3D 11 Return Codes for
    ///    failing error codes.
    ///    
    HRESULT CreateInputLayout(const(D3D11_INPUT_ELEMENT_DESC)* pInputElementDescs, uint NumElements, 
                              const(void)* pShaderBytecodeWithInputSignature, size_t BytecodeLength, 
                              ID3D11InputLayout* ppInputLayout);
    ///Create a vertex-shader object from a compiled shader.
    ///Params:
    ///    pShaderBytecode = Type: <b>const void*</b> A pointer to the compiled shader.
    ///    BytecodeLength = Type: <b>SIZE_T</b> Size of the compiled vertex shader.
    ///    pClassLinkage = Type: <b>ID3D11ClassLinkage*</b> A pointer to a class linkage interface (see ID3D11ClassLinkage); the value
    ///                    can be <b>NULL</b>.
    ///    ppVertexShader = Type: <b>ID3D11VertexShader**</b> Address of a pointer to a ID3D11VertexShader interface. If this is
    ///                     <b>NULL</b>, all other parameters will be validated, and if all parameters pass validation this API will
    ///                     return <b>S_FALSE</b> instead of <b>S_OK</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT CreateVertexShader(const(void)* pShaderBytecode, size_t BytecodeLength, 
                               ID3D11ClassLinkage pClassLinkage, ID3D11VertexShader* ppVertexShader);
    ///Create a geometry shader.
    ///Params:
    ///    pShaderBytecode = Type: <b>const void*</b> A pointer to the compiled shader.
    ///    BytecodeLength = Type: <b>SIZE_T</b> Size of the compiled geometry shader.
    ///    pClassLinkage = Type: <b>ID3D11ClassLinkage*</b> A pointer to a class linkage interface (see ID3D11ClassLinkage); the value
    ///                    can be <b>NULL</b>.
    ///    ppGeometryShader = Type: <b>ID3D11GeometryShader**</b> Address of a pointer to a ID3D11GeometryShader interface. If this is
    ///                       <b>NULL</b>, all other parameters will be validated, and if all parameters pass validation this API will
    ///                       return S_FALSE instead of S_OK.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT CreateGeometryShader(const(void)* pShaderBytecode, size_t BytecodeLength, 
                                 ID3D11ClassLinkage pClassLinkage, ID3D11GeometryShader* ppGeometryShader);
    ///Creates a geometry shader that can write to streaming output buffers.
    ///Params:
    ///    pShaderBytecode = Type: <b>const void*</b> A pointer to the compiled geometry shader for a standard geometry shader plus stream
    ///                      output. For info on how to get this pointer, see Getting a Pointer to a Compiled Shader. To create the stream
    ///                      output without using a geometry shader, pass a pointer to the output signature for the prior stage. To obtain
    ///                      this output signature, call the D3DGetOutputSignatureBlob compiler function. You can also pass a pointer to
    ///                      the compiled shader for the prior stage (for example, the vertex-shader stage or domain-shader stage). This
    ///                      compiled shader provides the output signature for the data.
    ///    BytecodeLength = Type: <b>SIZE_T</b> Size of the compiled geometry shader.
    ///    pSODeclaration = Type: <b>const D3D11_SO_DECLARATION_ENTRY*</b> Pointer to a D3D11_SO_DECLARATION_ENTRY array. Cannot be
    ///                     <b>NULL</b> if NumEntries &gt; 0.
    ///    NumEntries = Type: <b>UINT</b> The number of entries in the stream output declaration ( ranges from 0 to
    ///                 D3D11_SO_STREAM_COUNT * D3D11_SO_OUTPUT_COMPONENT_COUNT ).
    ///    pBufferStrides = Type: <b>const UINT*</b> An array of buffer strides; each stride is the size of an element for that buffer.
    ///    NumStrides = Type: <b>UINT</b> The number of strides (or buffers) in <i>pBufferStrides</i> (ranges from 0 to
    ///                 D3D11_SO_BUFFER_SLOT_COUNT).
    ///    RasterizedStream = Type: <b>UINT</b> The index number of the stream to be sent to the rasterizer stage (ranges from 0 to
    ///                       D3D11_SO_STREAM_COUNT - 1). Set to D3D11_SO_NO_RASTERIZED_STREAM if no stream is to be rasterized.
    ///    pClassLinkage = Type: <b>ID3D11ClassLinkage*</b> A pointer to a class linkage interface (see ID3D11ClassLinkage); the value
    ///                    can be <b>NULL</b>.
    ///    ppGeometryShader = Type: <b>ID3D11GeometryShader**</b> Address of a pointer to an ID3D11GeometryShader interface, representing
    ///                       the geometry shader that was created. Set this to <b>NULL</b> to validate the other parameters; if validation
    ///                       passes, the method will return S_FALSE instead of S_OK.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT CreateGeometryShaderWithStreamOutput(const(void)* pShaderBytecode, size_t BytecodeLength, 
                                                 const(D3D11_SO_DECLARATION_ENTRY)* pSODeclaration, uint NumEntries, 
                                                 const(uint)* pBufferStrides, uint NumStrides, uint RasterizedStream, 
                                                 ID3D11ClassLinkage pClassLinkage, 
                                                 ID3D11GeometryShader* ppGeometryShader);
    ///Create a pixel shader.
    ///Params:
    ///    pShaderBytecode = Type: <b>const void*</b> A pointer to the compiled shader.
    ///    BytecodeLength = Type: <b>SIZE_T</b> Size of the compiled pixel shader.
    ///    pClassLinkage = Type: <b>ID3D11ClassLinkage*</b> A pointer to a class linkage interface (see ID3D11ClassLinkage); the value
    ///                    can be <b>NULL</b>.
    ///    ppPixelShader = Type: <b>ID3D11PixelShader**</b> Address of a pointer to a ID3D11PixelShader interface. If this is
    ///                    <b>NULL</b>, all other parameters will be validated, and if all parameters pass validation this API will
    ///                    return S_FALSE instead of S_OK.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT CreatePixelShader(const(void)* pShaderBytecode, size_t BytecodeLength, 
                              ID3D11ClassLinkage pClassLinkage, ID3D11PixelShader* ppPixelShader);
    ///Create a hull shader.
    ///Params:
    ///    pShaderBytecode = Type: <b>const void*</b> A pointer to a compiled shader.
    ///    BytecodeLength = Type: <b>SIZE_T</b> Size of the compiled shader.
    ///    pClassLinkage = Type: <b>ID3D11ClassLinkage*</b> A pointer to a class linkage interface (see ID3D11ClassLinkage); the value
    ///                    can be <b>NULL</b>.
    ///    ppHullShader = Type: <b>ID3D11HullShader**</b> Address of a pointer to a ID3D11HullShader interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT CreateHullShader(const(void)* pShaderBytecode, size_t BytecodeLength, ID3D11ClassLinkage pClassLinkage, 
                             ID3D11HullShader* ppHullShader);
    ///Create a domain shader.
    ///Params:
    ///    pShaderBytecode = Type: <b>const void*</b> A pointer to a compiled shader.
    ///    BytecodeLength = Type: <b>SIZE_T</b> Size of the compiled shader.
    ///    pClassLinkage = Type: <b>ID3D11ClassLinkage*</b> A pointer to a class linkage interface (see ID3D11ClassLinkage); the value
    ///                    can be <b>NULL</b>.
    ///    ppDomainShader = Type: <b>ID3D11DomainShader**</b> Address of a pointer to a ID3D11DomainShader interface. If this is
    ///                     <b>NULL</b>, all other parameters will be validated, and if all parameters pass validation this API will
    ///                     return <b>S_FALSE</b> instead of <b>S_OK</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT CreateDomainShader(const(void)* pShaderBytecode, size_t BytecodeLength, 
                               ID3D11ClassLinkage pClassLinkage, ID3D11DomainShader* ppDomainShader);
    ///Create a compute shader.
    ///Params:
    ///    pShaderBytecode = Type: <b>const void*</b> A pointer to a compiled shader.
    ///    BytecodeLength = Type: <b>SIZE_T</b> Size of the compiled shader in <i>pShaderBytecode</i>.
    ///    pClassLinkage = Type: <b>ID3D11ClassLinkage*</b> A pointer to a ID3D11ClassLinkage, which represents class linkage interface;
    ///                    the value can be <b>NULL</b>.
    ///    ppComputeShader = Type: <b>ID3D11ComputeShader**</b> Address of a pointer to an ID3D11ComputeShader interface. If this is
    ///                      <b>NULL</b>, all other parameters will be validated; if validation passes, CreateComputeShader returns
    ///                      S_FALSE instead of S_OK.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns E_OUTOFMEMORY if there is insufficient memory to create the compute
    ///    shader. See Direct3D 11 Return Codes for other possible return values.
    ///    
    HRESULT CreateComputeShader(const(void)* pShaderBytecode, size_t BytecodeLength, 
                                ID3D11ClassLinkage pClassLinkage, ID3D11ComputeShader* ppComputeShader);
    ///Creates class linkage libraries to enable dynamic shader linkage.
    ///Params:
    ///    ppLinkage = Type: <b>ID3D11ClassLinkage**</b> A pointer to a class-linkage interface pointer (see ID3D11ClassLinkage).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT CreateClassLinkage(ID3D11ClassLinkage* ppLinkage);
    ///Create a blend-state object that encapsules blend state for the output-merger stage.
    ///Params:
    ///    pBlendStateDesc = Type: <b>const D3D11_BLEND_DESC*</b> Pointer to a blend-state description (see D3D11_BLEND_DESC).
    ///    ppBlendState = Type: <b>ID3D11BlendState**</b> Address of a pointer to the blend-state object created (see
    ///                   ID3D11BlendState).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns E_OUTOFMEMORY if there is insufficient memory to create the
    ///    blend-state object. See Direct3D 11 Return Codes for other possible return values.
    ///    
    HRESULT CreateBlendState(const(D3D11_BLEND_DESC)* pBlendStateDesc, ID3D11BlendState* ppBlendState);
    ///Create a depth-stencil state object that encapsulates depth-stencil test information for the output-merger stage.
    ///Params:
    ///    pDepthStencilDesc = Type: <b>const D3D11_DEPTH_STENCIL_DESC*</b> Pointer to a depth-stencil state description (see
    ///                        D3D11_DEPTH_STENCIL_DESC).
    ///    ppDepthStencilState = Type: <b>ID3D11DepthStencilState**</b> Address of a pointer to the depth-stencil state object created (see
    ///                          ID3D11DepthStencilState).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT CreateDepthStencilState(const(D3D11_DEPTH_STENCIL_DESC)* pDepthStencilDesc, 
                                    ID3D11DepthStencilState* ppDepthStencilState);
    ///Create a rasterizer state object that tells the rasterizer stage how to behave.
    ///Params:
    ///    pRasterizerDesc = Type: <b>const D3D11_RASTERIZER_DESC*</b> Pointer to a rasterizer state description (see
    ///                      D3D11_RASTERIZER_DESC).
    ///    ppRasterizerState = Type: <b>ID3D11RasterizerState**</b> Address of a pointer to the rasterizer state object created (see
    ///                        ID3D11RasterizerState).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns E_OUTOFMEMORY if there is insufficient memory to create the compute
    ///    shader. See Direct3D 11 Return Codes for other possible return values.
    ///    
    HRESULT CreateRasterizerState(const(D3D11_RASTERIZER_DESC)* pRasterizerDesc, 
                                  ID3D11RasterizerState* ppRasterizerState);
    ///Create a sampler-state object that encapsulates sampling information for a texture.
    ///Params:
    ///    pSamplerDesc = Type: <b>const D3D11_SAMPLER_DESC*</b> Pointer to a sampler state description (see D3D11_SAMPLER_DESC).
    ///    ppSamplerState = Type: <b>ID3D11SamplerState**</b> Address of a pointer to the sampler state object created (see
    ///                     ID3D11SamplerState).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT CreateSamplerState(const(D3D11_SAMPLER_DESC)* pSamplerDesc, ID3D11SamplerState* ppSamplerState);
    ///This interface encapsulates methods for querying information from the GPU.
    ///Params:
    ///    pQueryDesc = Type: <b>const D3D11_QUERY_DESC*</b> Pointer to a query description (see D3D11_QUERY_DESC).
    ///    ppQuery = Type: <b>ID3D11Query**</b> Address of a pointer to the query object created (see ID3D11Query).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns E_OUTOFMEMORY if there is insufficient memory to create the query
    ///    object. See Direct3D 11 Return Codes for other possible return values.
    ///    
    HRESULT CreateQuery(const(D3D11_QUERY_DESC)* pQueryDesc, ID3D11Query* ppQuery);
    ///Creates a predicate.
    ///Params:
    ///    pPredicateDesc = Type: <b>const D3D11_QUERY_DESC*</b> Pointer to a query description where the type of query must be a
    ///                     D3D11_QUERY_SO_OVERFLOW_PREDICATE or D3D11_QUERY_OCCLUSION_PREDICATE (see D3D11_QUERY_DESC).
    ///    ppPredicate = Type: <b>ID3D11Predicate**</b> Address of a pointer to a predicate (see ID3D11Predicate).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT CreatePredicate(const(D3D11_QUERY_DESC)* pPredicateDesc, ID3D11Predicate* ppPredicate);
    ///Create a counter object for measuring GPU performance.
    ///Params:
    ///    pCounterDesc = Type: <b>const D3D11_COUNTER_DESC*</b> Pointer to a counter description (see D3D11_COUNTER_DESC).
    ///    ppCounter = Type: <b>ID3D11Counter**</b> Address of a pointer to a counter (see ID3D11Counter).
    ///Returns:
    ///    Type: <b>HRESULT</b> If this function succeeds, it will return S_OK. If it fails, possible return values are:
    ///    S_FALSE, E_OUTOFMEMORY, DXGI_ERROR_UNSUPPORTED, DXGI_ERROR_NONEXCLUSIVE, or E_INVALIDARG.
    ///    DXGI_ERROR_UNSUPPORTED is returned whenever the application requests to create a well-known counter, but the
    ///    current device does not support it. DXGI_ERROR_NONEXCLUSIVE indicates that another device object is currently
    ///    using the counters, so they cannot be used by this device at the moment. E_INVALIDARG is returned whenever an
    ///    out-of-range well-known or device-dependent counter is requested, or when the simulataneously active counters
    ///    have been exhausted.
    ///    
    HRESULT CreateCounter(const(D3D11_COUNTER_DESC)* pCounterDesc, ID3D11Counter* ppCounter);
    ///Creates a deferred context, which can record command lists.
    ///Params:
    ///    ContextFlags = Type: <b>UINT</b> Reserved for future use. Pass 0.
    ///    ppDeferredContext = Type: <b>ID3D11DeviceContext**</b> Upon completion of the method, the passed pointer to an
    ///                        ID3D11DeviceContext interface pointer is initialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the following: <ul> <li>Returns
    ///    <b>DXGI_ERROR_DEVICE_REMOVED</b> if the video card has been physically removed from the system, or a driver
    ///    upgrade for the video card has occurred. If this error occurs, you should destroy and recreate the device.
    ///    </li> <li>Returns <b>DXGI_ERROR_INVALID_CALL</b> if the <b>CreateDeferredContext</b> method cannot be called
    ///    from the current context. For example, if the device was created with the D3D11_CREATE_DEVICE_SINGLETHREADED
    ///    value, <b>CreateDeferredContext</b> returns <b>DXGI_ERROR_INVALID_CALL</b>. </li> <li>Returns
    ///    <b>E_INVALIDARG</b> if the <i>ContextFlags</i> parameter is invalid. </li> <li>Returns <b>E_OUTOFMEMORY</b>
    ///    if the application has exhausted available memory. </li> </ul>
    ///    
    HRESULT CreateDeferredContext(uint ContextFlags, ID3D11DeviceContext* ppDeferredContext);
    ///Give a device access to a shared resource created on a different device.
    ///Params:
    ///    hResource = Type: <b>HANDLE</b> A resource handle. See remarks.
    ///    ReturnedInterface = Type: <b>REFIID</b> The globally unique identifier (GUID) for the resource interface. See remarks.
    ///    ppResource = Type: <b>void**</b> Address of a pointer to the resource we are gaining access to.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT OpenSharedResource(HANDLE hResource, const(GUID)* ReturnedInterface, void** ppResource);
    ///Get the support of a given format on the installed video device.
    ///Params:
    ///    Format = Type: <b>DXGI_FORMAT</b> A DXGI_FORMAT enumeration that describes a format for which to check for support.
    ///    pFormatSupport = Type: <b>UINT*</b> A bitfield of D3D11_FORMAT_SUPPORT enumeration values describing how the specified format
    ///                     is supported on the installed device. The values are ORed together.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns E_INVALIDARG if the <i>Format</i>
    ///    parameter is <b>NULL</b>, or returns E_FAIL if the described format does not exist.
    ///    
    HRESULT CheckFormatSupport(DXGI_FORMAT Format, uint* pFormatSupport);
    ///Get the number of quality levels available during multisampling.
    ///Params:
    ///    Format = Type: <b>DXGI_FORMAT</b> The texture format. See DXGI_FORMAT.
    ///    SampleCount = Type: <b>UINT</b> The number of samples during multisampling.
    ///    pNumQualityLevels = Type: <b>UINT*</b> Number of quality levels supported by the adapter. See remarks.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT CheckMultisampleQualityLevels(DXGI_FORMAT Format, uint SampleCount, uint* pNumQualityLevels);
    ///Get a counter's information.
    ///Params:
    ///    pCounterInfo = Type: <b>D3D11_COUNTER_INFO*</b> Pointer to counter information (see D3D11_COUNTER_INFO).
    void    CheckCounterInfo(D3D11_COUNTER_INFO* pCounterInfo);
    ///Get the type, name, units of measure, and a description of an existing counter.
    ///Params:
    ///    pDesc = Type: <b>const D3D11_COUNTER_DESC*</b> Pointer to a counter description (see D3D11_COUNTER_DESC). Specifies
    ///            which counter information is to be retrieved about.
    ///    pType = Type: <b>D3D11_COUNTER_TYPE*</b> Pointer to the data type of a counter (see D3D11_COUNTER_TYPE). Specifies
    ///            the data type of the counter being retrieved.
    ///    pActiveCounters = Type: <b>UINT*</b> Pointer to the number of hardware counters that are needed for this counter type to be
    ///                      created. All instances of the same counter type use the same hardware counters.
    ///    szName = Type: <b>LPSTR</b> String to be filled with a brief name for the counter. May be <b>NULL</b> if the
    ///             application is not interested in the name of the counter.
    ///    pNameLength = Type: <b>UINT*</b> Length of the string returned to szName. Can be <b>NULL</b>.
    ///    szUnits = Type: <b>LPSTR</b> Name of the units a counter measures, provided the memory the pointer points to has enough
    ///              room to hold the string. Can be <b>NULL</b>. The returned string will always be in English.
    ///    pUnitsLength = Type: <b>UINT*</b> Length of the string returned to szUnits. Can be <b>NULL</b>.
    ///    szDescription = Type: <b>LPSTR</b> A description of the counter, provided the memory the pointer points to has enough room to
    ///                    hold the string. Can be <b>NULL</b>. The returned string will always be in English.
    ///    pDescriptionLength = Type: <b>UINT*</b> Length of the string returned to szDescription. Can be <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT CheckCounter(const(D3D11_COUNTER_DESC)* pDesc, D3D11_COUNTER_TYPE* pType, uint* pActiveCounters, 
                         PSTR szName, uint* pNameLength, PSTR szUnits, uint* pUnitsLength, PSTR szDescription, 
                         uint* pDescriptionLength);
    ///Gets information about the features that are supported by the current graphics driver.
    ///Params:
    ///    Feature = Type: <b>D3D11_FEATURE</b> A member of the D3D11_FEATURE enumerated type that describes which feature to
    ///              query for support.
    ///    pFeatureSupportData = Type: <b>void*</b> Upon completion of the method, the passed structure is filled with data that describes the
    ///                          feature support.
    ///    FeatureSupportDataSize = Type: <b>UINT</b> The size of the structure passed to the <i>pFeatureSupportData</i> parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns E_INVALIDARG if an unsupported data type
    ///    is passed to the <i>pFeatureSupportData</i> parameter or a size mismatch is detected for the
    ///    <i>FeatureSupportDataSize</i> parameter.
    ///    
    HRESULT CheckFeatureSupport(D3D11_FEATURE Feature, void* pFeatureSupportData, uint FeatureSupportDataSize);
    ///Get application-defined data from a device.
    ///Params:
    ///    guid = Type: <b>REFGUID</b> Guid associated with the data.
    ///    pDataSize = Type: <b>UINT*</b> A pointer to a variable that on input contains the size, in bytes, of the buffer that
    ///                <i>pData</i> points to, and on output contains the size, in bytes, of the amount of data that
    ///                <b>GetPrivateData</b> retrieved.
    ///    pData = Type: <b>void*</b> A pointer to a buffer that <b>GetPrivateData</b> fills with data from the device if
    ///            <i>pDataSize</i> points to a value that specifies a buffer large enough to hold the data.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the codes described in the topic Direct3D 11 Return Codes.
    ///    
    HRESULT GetPrivateData(const(GUID)* guid, uint* pDataSize, void* pData);
    ///Set data to a device and associate that data with a guid.
    ///Params:
    ///    guid = Type: <b>REFGUID</b> Guid associated with the data.
    ///    DataSize = Type: <b>UINT</b> Size of the data.
    ///    pData = Type: <b>const void*</b> Pointer to the data to be stored with this device. If pData is <b>NULL</b>, DataSize
    ///            must also be 0, and any data previously associated with the guid will be destroyed.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT SetPrivateData(const(GUID)* guid, uint DataSize, const(void)* pData);
    ///Associate an IUnknown-derived interface with this device child and associate that interface with an
    ///application-defined guid.
    ///Params:
    ///    guid = Type: <b>REFGUID</b> Guid associated with the interface.
    ///    pData = Type: <b>const IUnknown*</b> Pointer to an IUnknown-derived interface to be associated with the device child.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT SetPrivateDataInterface(const(GUID)* guid, const(IUnknown) pData);
    ///Gets the feature level of the hardware device.
    ///Returns:
    ///    Type: <b>D3D_FEATURE_LEVEL</b> A member of the D3D_FEATURE_LEVEL enumerated type that describes the feature
    ///    level of the hardware device.
    ///    
    D3D_FEATURE_LEVEL GetFeatureLevel();
    ///Get the flags used during the call to create the device with D3D11CreateDevice.
    ///Returns:
    ///    Type: <b>UINT</b> A bitfield containing the flags used to create the device. See D3D11_CREATE_DEVICE_FLAG.
    ///    
    uint    GetCreationFlags();
    ///Get the reason why the device was removed.
    ///Returns:
    ///    Type: <b>HRESULT</b> Possible return values include: <ul> <li>DXGI_ERROR_DEVICE_HUNG</li>
    ///    <li>DXGI_ERROR_DEVICE_REMOVED</li> <li>DXGI_ERROR_DEVICE_RESET</li> <li>DXGI_ERROR_DRIVER_INTERNAL_ERROR</li>
    ///    <li>DXGI_ERROR_INVALID_CALL</li> <li>S_OK</li> </ul> For more detail on these return codes, see DXGI_ERROR.
    ///    
    HRESULT GetDeviceRemovedReason();
    ///Gets an immediate context, which can play back command lists.
    ///Params:
    ///    ppImmediateContext = Type: <b>ID3D11DeviceContext**</b> Upon completion of the method, the passed pointer to an
    ///                         ID3D11DeviceContext interface pointer is initialized.
    void    GetImmediateContext(ID3D11DeviceContext* ppImmediateContext);
    ///Get the exception-mode flags.
    ///Params:
    ///    RaiseFlags = Type: <b>UINT</b> A value that contains one or more exception flags; each flag specifies a condition which
    ///                 will cause an exception to be raised. The flags are listed in D3D11_RAISE_FLAG. A default value of 0 means
    ///                 there are no flags.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT SetExceptionMode(uint RaiseFlags);
    ///Get the exception-mode flags.
    ///Returns:
    ///    Type: <b>UINT</b> A value that contains one or more exception flags; each flag specifies a condition which
    ///    will cause an exception to be raised. The flags are listed in D3D11_RAISE_FLAG. A default value of 0 means
    ///    there are no flags.
    ///    
    uint    GetExceptionMode();
}

///A debug interface controls debug settings, validates pipeline state and can only be used if the debug layer is turned
///on.
@GUID("79CF2233-7536-4948-9D36-1E4692DC5760")
interface ID3D11Debug : IUnknown
{
    ///Set a bit field of flags that will turn debug features on and off.
    ///Params:
    ///    Mask = Type: <b>UINT</b> A combination of feature-mask flags that are combined by using a bitwise OR operation. If a
    ///           flag is present, that feature will be set to on, otherwise the feature will be set to off. For descriptions
    ///           of the feature-mask flags, see Remarks.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT SetFeatureMask(uint Mask);
    ///Get a bitfield of flags that indicates which debug features are on or off.
    ///Returns:
    ///    Type: <b>UINT</b> Mask of feature-mask flags bitwise ORed together. If a flag is present, then that feature
    ///    will be set to on, otherwise the feature will be set to off. See ID3D11Debug::SetFeatureMask for a list of
    ///    possible feature-mask flags.
    ///    
    uint    GetFeatureMask();
    ///Set the number of milliseconds to sleep after IDXGISwapChain::Present is called.
    ///Params:
    ///    Milliseconds = Type: <b>UINT</b> Number of milliseconds to sleep after Present is called.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT SetPresentPerRenderOpDelay(uint Milliseconds);
    ///Get the number of milliseconds to sleep after IDXGISwapChain::Present is called.
    ///Returns:
    ///    Type: <b>UINT</b> Number of milliseconds to sleep after Present is called.
    ///    
    uint    GetPresentPerRenderOpDelay();
    ///Sets a swap chain that the runtime will use for automatically calling IDXGISwapChain::Present.
    ///Params:
    ///    pSwapChain = Type: <b>IDXGISwapChain*</b> Swap chain that the runtime will use for automatically calling
    ///                 IDXGISwapChain::Present; must have been created with the DXGI_SWAP_EFFECT_SEQUENTIAL swap-effect flag.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT SetSwapChain(IDXGISwapChain pSwapChain);
    ///Get the swap chain that the runtime will use for automatically calling IDXGISwapChain::Present.
    ///Params:
    ///    ppSwapChain = Type: <b>IDXGISwapChain**</b> Swap chain that the runtime will use for automatically calling
    ///                  IDXGISwapChain::Present.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT GetSwapChain(IDXGISwapChain* ppSwapChain);
    ///Check to see if the draw pipeline state is valid.
    ///Params:
    ///    pContext = Type: <b>ID3D11DeviceContext*</b> A pointer to the ID3D11DeviceContext, that represents a device context.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT ValidateContext(ID3D11DeviceContext pContext);
    ///Report information about a device object's lifetime.
    ///Params:
    ///    Flags = Type: <b>D3D11_RLDO_FLAGS</b> A value from the D3D11_RLDO_FLAGS enumeration.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT ReportLiveDeviceObjects(D3D11_RLDO_FLAGS Flags);
    ///Verifies whether the dispatch pipeline state is valid.
    ///Params:
    ///    pContext = Type: <b>ID3D11DeviceContext*</b> A pointer to the ID3D11DeviceContext that represents a device context.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the return codes described in the topic Direct3D 11 Return
    ///    Codes.
    ///    
    HRESULT ValidateContextForDispatch(ID3D11DeviceContext pContext);
}

///<div class="alert"><b>Note</b> The <b>ID3D11SwitchToRef</b> interface and its methods are not supported in Direct3D
///11. </div><div> </div>
@GUID("1EF337E3-58E7-4F83-A692-DB221F5ED47E")
interface ID3D11SwitchToRef : IUnknown
{
    ///<div class="alert"><b>Note</b> The ID3D11SwitchToRef interface and its methods are not supported in Direct3D
    ///11.</div><div> </div>
    ///Params:
    ///    UseRef = Type: <b>BOOL</b> Reserved.
    ///Returns:
    ///    Type: <b>BOOL</b> Reserved.
    ///    
    BOOL SetUseRef(BOOL UseRef);
    ///<div class="alert"><b>Note</b> The ID3D11SwitchToRef interface and its methods are not supported in Direct3D
    ///11.</div><div> </div>
    ///Returns:
    ///    Type: <b>BOOL</b> Reserved.
    ///    
    BOOL GetUseRef();
}

///The tracing device interface sets shader tracking information, which enables accurate logging and playback of shader
///execution.
@GUID("1911C771-1587-413E-A7E0-FB26C3DE0268")
interface ID3D11TracingDevice : IUnknown
{
    ///Sets the reference rasterizer's default race-condition tracking options for the specified resource types.
    ///Params:
    ///    ResourceTypeFlags = A D3D11_SHADER_TRACKING_RESOURCE_TYPE-typed value that specifies the type of resource to track.
    ///    Options = A combination of D3D11_SHADER_TRACKING_OPTIONS-typed flags that are combined by using a bitwise <b>OR</b>
    ///              operation. The resulting value identifies tracking options. If a flag is present, the tracking option that
    ///              the flag represents is set to "on," otherwise the tracking option is set to "off."
    ///Returns:
    ///    This method returns one of the Direct3D 11 return codes.
    ///    
    HRESULT SetShaderTrackingOptionsByType(uint ResourceTypeFlags, uint Options);
    ///Sets the reference rasterizer's race-condition tracking options for a specific shader.
    ///Params:
    ///    pShader = A pointer to the IUnknown interface of a shader.
    ///    Options = A combination of D3D11_SHADER_TRACKING_OPTIONS-typed flags that are combined by using a bitwise <b>OR</b>
    ///              operation. The resulting value identifies tracking options. If a flag is present, the tracking option that
    ///              the flag represents is set to "on"; otherwise the tracking option is set to "off."
    ///Returns:
    ///    This method returns one of the Direct3D 11 return codes.
    ///    
    HRESULT SetShaderTrackingOptions(IUnknown pShader, uint Options);
}

///The tracking interface sets reference tracking options.
@GUID("193DACDF-0DB2-4C05-A55C-EF06CAC56FD9")
interface ID3D11RefTrackingOptions : IUnknown
{
    ///Sets graphics processing unit (GPU) debug reference tracking options.
    ///Params:
    ///    uOptions = A combination of D3D11_SHADER_TRACKING_OPTIONS-typed flags that are combined by using a bitwise <b>OR</b>
    ///               operation. The resulting value identifies tracking options. If a flag is present, the tracking option that
    ///               the flag represents is set to "on"; otherwise the tracking option is set to "off."
    ///Returns:
    ///    This method returns one of the Direct3D 11 return codes.
    ///    
    HRESULT SetTrackingOptions(uint uOptions);
}

///The default tracking interface sets reference default tracking options.
@GUID("03916615-C644-418C-9BF4-75DB5BE63CA0")
interface ID3D11RefDefaultTrackingOptions : IUnknown
{
    ///Sets graphics processing unit (GPU) debug reference default tracking options for specific resource types.
    ///Params:
    ///    ResourceTypeFlags = A D3D11_SHADER_TRACKING_RESOURCE_TYPE-typed value that specifies the type of resource to track.
    ///    Options = A combination of D3D11_SHADER_TRACKING_OPTIONS-typed flags that are combined by using a bitwise <b>OR</b>
    ///              operation. The resulting value identifies tracking options. If a flag is present, the tracking option that
    ///              the flag represents is set to "on"; otherwise the tracking option is set to "off."
    ///Returns:
    ///    This method returns one of the Direct3D 11 return codes.
    ///    
    HRESULT SetTrackingOptions(uint ResourceTypeFlags, uint Options);
}

///An information-queue interface stores, retrieves, and filters debug messages. The queue consists of a message queue,
///an optional storage filter stack, and a optional retrieval filter stack.
@GUID("6543DBB6-1B48-42F5-AB82-E97EC74326F6")
interface ID3D11InfoQueue : IUnknown
{
    ///Set the maximum number of messages that can be added to the message queue.
    ///Params:
    ///    MessageCountLimit = Type: <b>UINT64</b> Maximum number of messages that can be added to the message queue. -1 means no limit.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT SetMessageCountLimit(ulong MessageCountLimit);
    ///Clear all messages from the message queue.
    void    ClearStoredMessages();
    HRESULT GetMessageA(ulong MessageIndex, D3D11_MESSAGE* pMessage, size_t* pMessageByteLength);
    ///Get the number of messages that were allowed to pass through a storage filter.
    ///Returns:
    ///    Type: <b>UINT64</b> Number of messages allowed by a storage filter.
    ///    
    ulong   GetNumMessagesAllowedByStorageFilter();
    ///Get the number of messages that were denied passage through a storage filter.
    ///Returns:
    ///    Type: <b>UINT64</b> Number of messages denied by a storage filter.
    ///    
    ulong   GetNumMessagesDeniedByStorageFilter();
    ///Get the number of messages currently stored in the message queue.
    ///Returns:
    ///    Type: <b>UINT64</b> Number of messages currently stored in the message queue.
    ///    
    ulong   GetNumStoredMessages();
    ///Get the number of messages that are able to pass through a retrieval filter.
    ///Returns:
    ///    Type: <b>UINT64</b> Number of messages allowed by a retrieval filter.
    ///    
    ulong   GetNumStoredMessagesAllowedByRetrievalFilter();
    ///Get the number of messages that were discarded due to the message count limit.
    ///Returns:
    ///    Type: <b>UINT64</b> Number of messages discarded.
    ///    
    ulong   GetNumMessagesDiscardedByMessageCountLimit();
    ///Get the maximum number of messages that can be added to the message queue.
    ///Returns:
    ///    Type: <b>UINT64</b> Maximum number of messages that can be added to the queue. -1 means no limit.
    ///    
    ulong   GetMessageCountLimit();
    ///Add storage filters to the top of the storage-filter stack.
    ///Params:
    ///    pFilter = Type: <b>D3D11_INFO_QUEUE_FILTER*</b> Array of storage filters (see D3D11_INFO_QUEUE_FILTER).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT AddStorageFilterEntries(D3D11_INFO_QUEUE_FILTER* pFilter);
    ///Get the storage filter at the top of the storage-filter stack.
    ///Params:
    ///    pFilter = Type: <b>D3D11_INFO_QUEUE_FILTER*</b> Storage filter at the top of the storage-filter stack.
    ///    pFilterByteLength = Type: <b>SIZE_T*</b> Size of the storage filter in bytes. If pFilter is <b>NULL</b>, the size of the storage
    ///                        filter will be output to this parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT GetStorageFilter(D3D11_INFO_QUEUE_FILTER* pFilter, size_t* pFilterByteLength);
    ///Remove a storage filter from the top of the storage-filter stack.
    void    ClearStorageFilter();
    ///Push an empty storage filter onto the storage-filter stack.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT PushEmptyStorageFilter();
    ///Push a copy of storage filter currently on the top of the storage-filter stack onto the storage-filter stack.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT PushCopyOfStorageFilter();
    ///Push a storage filter onto the storage-filter stack.
    ///Params:
    ///    pFilter = Type: <b>D3D11_INFO_QUEUE_FILTER*</b> Pointer to a storage filter (see D3D11_INFO_QUEUE_FILTER).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT PushStorageFilter(D3D11_INFO_QUEUE_FILTER* pFilter);
    ///Pop a storage filter from the top of the storage-filter stack.
    void    PopStorageFilter();
    ///Get the size of the storage-filter stack in bytes.
    ///Returns:
    ///    Type: <b>UINT</b> Size of the storage-filter stack in bytes.
    ///    
    uint    GetStorageFilterStackSize();
    ///Add storage filters to the top of the retrieval-filter stack.
    ///Params:
    ///    pFilter = Type: <b>D3D11_INFO_QUEUE_FILTER*</b> Array of retrieval filters (see D3D11_INFO_QUEUE_FILTER).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT AddRetrievalFilterEntries(D3D11_INFO_QUEUE_FILTER* pFilter);
    ///Get the retrieval filter at the top of the retrieval-filter stack.
    ///Params:
    ///    pFilter = Type: <b>D3D11_INFO_QUEUE_FILTER*</b> Retrieval filter at the top of the retrieval-filter stack.
    ///    pFilterByteLength = Type: <b>SIZE_T*</b> Size of the retrieval filter in bytes. If pFilter is <b>NULL</b>, the size of the
    ///                        retrieval filter will be output to this parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT GetRetrievalFilter(D3D11_INFO_QUEUE_FILTER* pFilter, size_t* pFilterByteLength);
    ///Remove a retrieval filter from the top of the retrieval-filter stack.
    void    ClearRetrievalFilter();
    ///Push an empty retrieval filter onto the retrieval-filter stack.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT PushEmptyRetrievalFilter();
    ///Push a copy of retrieval filter currently on the top of the retrieval-filter stack onto the retrieval-filter
    ///stack.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT PushCopyOfRetrievalFilter();
    ///Push a retrieval filter onto the retrieval-filter stack.
    ///Params:
    ///    pFilter = Type: <b>D3D11_INFO_QUEUE_FILTER*</b> Pointer to a retrieval filter (see D3D11_INFO_QUEUE_FILTER).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT PushRetrievalFilter(D3D11_INFO_QUEUE_FILTER* pFilter);
    ///Pop a retrieval filter from the top of the retrieval-filter stack.
    void    PopRetrievalFilter();
    ///Get the size of the retrieval-filter stack in bytes.
    ///Returns:
    ///    Type: <b>UINT</b> Size of the retrieval-filter stack in bytes.
    ///    
    uint    GetRetrievalFilterStackSize();
    ///Add a debug message to the message queue and send that message to debug output.
    ///Params:
    ///    Category = Type: <b>D3D11_MESSAGE_CATEGORY</b> Category of a message (see D3D11_MESSAGE_CATEGORY).
    ///    Severity = Type: <b>D3D11_MESSAGE_SEVERITY</b> Severity of a message (see D3D11_MESSAGE_SEVERITY).
    ///    ID = Type: <b>D3D11_MESSAGE_ID</b> Unique identifier of a message (see D3D11_MESSAGE_ID).
    ///    pDescription = Type: <b>LPCSTR</b> User-defined message.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT AddMessage(D3D11_MESSAGE_CATEGORY Category, D3D11_MESSAGE_SEVERITY Severity, D3D11_MESSAGE_ID ID, 
                       const(PSTR) pDescription);
    ///Add a user-defined message to the message queue and send that message to debug output.
    ///Params:
    ///    Severity = Type: <b>D3D11_MESSAGE_SEVERITY</b> Severity of a message (see D3D11_MESSAGE_SEVERITY).
    ///    pDescription = Type: <b>LPCSTR</b> Message string.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT AddApplicationMessage(D3D11_MESSAGE_SEVERITY Severity, const(PSTR) pDescription);
    ///Set a message category to break on when a message with that category passes through the storage filter.
    ///Params:
    ///    Category = Type: <b>D3D11_MESSAGE_CATEGORY</b> Message category to break on (see D3D11_MESSAGE_CATEGORY).
    ///    bEnable = Type: <b>BOOL</b> Turns this breaking condition on or off (true for on, false for off).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT SetBreakOnCategory(D3D11_MESSAGE_CATEGORY Category, BOOL bEnable);
    ///Set a message severity level to break on when a message with that severity level passes through the storage
    ///filter.
    ///Params:
    ///    Severity = Type: <b>D3D11_MESSAGE_SEVERITY</b> A D3D11_MESSAGE_SEVERITY, which represents a message severity level to
    ///               break on.
    ///    bEnable = Type: <b>BOOL</b> Turns this breaking condition on or off (true for on, false for off).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT SetBreakOnSeverity(D3D11_MESSAGE_SEVERITY Severity, BOOL bEnable);
    ///Set a message identifier to break on when a message with that identifier passes through the storage filter.
    ///Params:
    ///    ID = Type: <b>D3D11_MESSAGE_ID</b> Message identifier to break on (see D3D11_MESSAGE_ID).
    ///    bEnable = Type: <b>BOOL</b> Turns this breaking condition on or off (true for on, false for off).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT SetBreakOnID(D3D11_MESSAGE_ID ID, BOOL bEnable);
    ///Get a message category to break on when a message with that category passes through the storage filter.
    ///Params:
    ///    Category = Type: <b>D3D11_MESSAGE_CATEGORY</b> Message category to break on (see D3D11_MESSAGE_CATEGORY).
    ///Returns:
    ///    Type: <b>BOOL</b> Whether this breaking condition is turned on or off (true for on, false for off).
    ///    
    BOOL    GetBreakOnCategory(D3D11_MESSAGE_CATEGORY Category);
    ///Get a message severity level to break on when a message with that severity level passes through the storage
    ///filter.
    ///Params:
    ///    Severity = Type: <b>D3D11_MESSAGE_SEVERITY</b> Message severity level to break on (see D3D11_MESSAGE_SEVERITY).
    ///Returns:
    ///    Type: <b>BOOL</b> Whether this breaking condition is turned on or off (true for on, false for off).
    ///    
    BOOL    GetBreakOnSeverity(D3D11_MESSAGE_SEVERITY Severity);
    ///Get a message identifier to break on when a message with that identifier passes through the storage filter.
    ///Params:
    ///    ID = Type: <b>D3D11_MESSAGE_ID</b> Message identifier to break on (see D3D11_MESSAGE_ID).
    ///Returns:
    ///    Type: <b>BOOL</b> Whether this breaking condition is turned on or off (true for on, false for off).
    ///    
    BOOL    GetBreakOnID(D3D11_MESSAGE_ID ID);
    ///Set a boolean that turns the debug output on or off.
    ///Params:
    ///    bMute = Type: <b>BOOL</b> Disable/Enable the debug output (<b>TRUE</b> to disable or mute the output, <b>FALSE</b> to
    ///            enable the output).
    void    SetMuteDebugOutput(BOOL bMute);
    ///Get a boolean that turns the debug output on or off.
    ///Returns:
    ///    Type: <b>BOOL</b> Whether the debug output is on or off (true for on, false for off).
    ///    
    BOOL    GetMuteDebugOutput();
}

///The blend-state interface holds a description for blending state that you can bind to the output-merger stage. This
///blend-state interface supports logical operations as well as blending operations.
@GUID("CC86FABE-DA55-401D-85E7-E3C9DE2877E9")
interface ID3D11BlendState1 : ID3D11BlendState
{
    ///Gets the description for blending state that you used to create the blend-state object.
    ///Params:
    ///    pDesc = A pointer to a D3D11_BLEND_DESC1 structure that receives a description of the blend state. This blend state
    ///            can specify logical operations as well as blending operations.
    void GetDesc1(D3D11_BLEND_DESC1* pDesc);
}

///The rasterizer-state interface holds a description for rasterizer state that you can bind to the rasterizer stage.
///This rasterizer-state interface supports forced sample count.
@GUID("1217D7A6-5039-418C-B042-9CBE256AFD6E")
interface ID3D11RasterizerState1 : ID3D11RasterizerState
{
    ///Gets the description for rasterizer state that you used to create the rasterizer-state object.
    ///Params:
    ///    pDesc = A pointer to a D3D11_RASTERIZER_DESC1 structure that receives a description of the rasterizer state. This
    ///            rasterizer state can specify forced sample count.
    void GetDesc1(D3D11_RASTERIZER_DESC1* pDesc);
}

///The <b>ID3DDeviceContextState</b> interface represents a context state object, which holds state and behavior
///information about a Microsoft Direct3D device.
@GUID("5C1E0D8A-7C23-48F9-8C59-A92958CEFF11")
interface ID3DDeviceContextState : ID3D11DeviceChild
{
}

///The device context interface represents a device context; it is used to render commands. <b>ID3D11DeviceContext1</b>
///adds new methods to those in ID3D11DeviceContext.
@GUID("BB2C6FAA-B5FB-4082-8E6B-388B8CFA90E1")
interface ID3D11DeviceContext1 : ID3D11DeviceContext
{
    ///Copies a region from a source resource to a destination resource.
    ///Params:
    ///    pDstResource = Type: <b>ID3D11Resource*</b> A pointer to the destination resource.
    ///    DstSubresource = Type: <b>UINT</b> Destination subresource index.
    ///    DstX = Type: <b>UINT</b> The x-coordinate of the upper-left corner of the destination region.
    ///    DstY = Type: <b>UINT</b> The y-coordinate of the upper-left corner of the destination region. For a 1D subresource,
    ///           this must be zero.
    ///    DstZ = Type: <b>UINT</b> The z-coordinate of the upper-left corner of the destination region. For a 1D or 2D
    ///           subresource, this must be zero.
    ///    pSrcResource = Type: <b>ID3D11Resource*</b> A pointer to the source resource.
    ///    SrcSubresource = Type: <b>UINT</b> Source subresource index.
    ///    pSrcBox = Type: <b>const D3D11_BOX*</b> A pointer to a 3D box that defines the region of the source subresource that
    ///              <b>CopySubresourceRegion1</b> can copy. If <b>NULL</b>, <b>CopySubresourceRegion1</b> copies the entire
    ///              source subresource. The box must fit within the source resource. An empty box results in a no-op. A box is
    ///              empty if the top value is greater than or equal to the bottom value, or the left value is greater than or
    ///              equal to the right value, or the front value is greater than or equal to the back value. When the box is
    ///              empty, <b>CopySubresourceRegion1</b> doesn't perform a copy operation.
    ///    CopyFlags = Type: <b>UINT</b> A D3D11_COPY_FLAGS-typed value that specifies how to perform the copy operation. If you
    ///                specify zero for no copy option, <b>CopySubresourceRegion1</b> behaves like
    ///                ID3D11DeviceContext::CopySubresourceRegion. For existing display drivers that can't process these flags, the
    ///                runtime doesn't use them.
    void CopySubresourceRegion1(ID3D11Resource pDstResource, uint DstSubresource, uint DstX, uint DstY, uint DstZ, 
                                ID3D11Resource pSrcResource, uint SrcSubresource, const(D3D11_BOX)* pSrcBox, 
                                uint CopyFlags);
    ///The CPU copies data from memory to a subresource created in non-mappable memory.
    ///Params:
    ///    pDstResource = Type: <b>ID3D11Resource*</b> A pointer to the destination resource.
    ///    DstSubresource = Type: <b>UINT</b> A zero-based index that identifies the destination subresource. See D3D11CalcSubresource
    ///                     for more details.
    ///    pDstBox = Type: <b>const D3D11_BOX*</b> A pointer to a box that defines the portion of the destination subresource to
    ///              copy the resource data into. Coordinates are in bytes for buffers and in texels for textures. If <b>NULL</b>,
    ///              <b>UpdateSubresource1</b> writes the data to the destination subresource with no offset. The dimensions of
    ///              the source must fit the destination. An empty box results in a no-op. A box is empty if the top value is
    ///              greater than or equal to the bottom value, or the left value is greater than or equal to the right value, or
    ///              the front value is greater than or equal to the back value. When the box is empty, <b>UpdateSubresource1</b>
    ///              doesn't perform an update operation.
    ///    pSrcData = Type: <b>const void*</b> A pointer to the source data in memory.
    ///    SrcRowPitch = Type: <b>UINT</b> The size of one row of the source data.
    ///    SrcDepthPitch = Type: <b>UINT</b> The size of one depth slice of source data.
    ///    CopyFlags = Type: <b>UINT</b> A D3D11_COPY_FLAGS-typed value that specifies how to perform the update operation. If you
    ///                specify zero for no update option, <b>UpdateSubresource1</b> behaves like
    ///                ID3D11DeviceContext::UpdateSubresource. For existing display drivers that can't process these flags, the
    ///                runtime doesn't use them.
    void UpdateSubresource1(ID3D11Resource pDstResource, uint DstSubresource, const(D3D11_BOX)* pDstBox, 
                            const(void)* pSrcData, uint SrcRowPitch, uint SrcDepthPitch, uint CopyFlags);
    ///Discards a resource from the device context.
    ///Params:
    ///    pResource = Type: <b>ID3D11Resource*</b> A pointer to the ID3D11Resource interface for the resource to discard. The
    ///                resource must have been created with usage D3D11_USAGE_DEFAULT or D3D11_USAGE_DYNAMIC, otherwise the runtime
    ///                drops the call to <b>DiscardResource</b>; if the debug layer is enabled, the runtime returns an error
    ///                message.
    void DiscardResource(ID3D11Resource pResource);
    ///Discards a resource view from the device context.
    ///Params:
    ///    pResourceView = Type: <b>ID3D11View*</b> A pointer to the ID3D11View interface for the resource view to discard. The resource
    ///                    that underlies the view must have been created with usage D3D11_USAGE_DEFAULT or D3D11_USAGE_DYNAMIC,
    ///                    otherwise the runtime drops the call to <b>DiscardView</b>; if the debug layer is enabled, the runtime
    ///                    returns an error message.
    void DiscardView(ID3D11View pResourceView);
    ///Sets the constant buffers that the vertex shader pipeline stage uses.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin setting constant buffers to (ranges from
    ///                0 to D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1).
    ///    NumBuffers = Type: <b>UINT</b> Number of buffers to set (ranges from 0 to
    ///                 D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - <i>StartSlot</i>).
    ///    ppConstantBuffers = Type: <b>ID3D11Buffer*</b> Array of constant buffers being given to the device.
    ///    pFirstConstant = Type: <b>const UINT*</b> An array that holds the offsets into the buffers that <i>ppConstantBuffers</i>
    ///                     specifies. Each offset specifies where, from the shader's point of view, each constant buffer starts. Each
    ///                     offset is measured in shader constants, which are 16 bytes (4*32-bit components). Therefore, an offset of 16
    ///                     indicates that the start of the associated constant buffer is 256 bytes into the constant buffer. Each offset
    ///                     must be a multiple of 16 constants.
    ///    pNumConstants = Type: <b>const UINT*</b> An array that holds the numbers of constants in the buffers that
    ///                    <i>ppConstantBuffers</i> specifies. Each number specifies the number of constants that are contained in the
    ///                    constant buffer that the shader uses. Each number of constants starts from its respective offset that is
    ///                    specified in the <i>pFirstConstant</i> array. Each number of constants must be a multiple of 16 constants, in
    ///                    the range [0..4096].
    void VSSetConstantBuffers1(uint StartSlot, uint NumBuffers, ID3D11Buffer* ppConstantBuffers, 
                               const(uint)* pFirstConstant, const(uint)* pNumConstants);
    ///Sets the constant buffers that the hull-shader stage of the pipeline uses.
    ///Params:
    ///    StartSlot = Index into the device's zero-based array to begin setting constant buffers to (ranges from 0 to
    ///                D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1).
    ///    NumBuffers = Number of buffers to set (ranges from 0 to D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT -
    ///                 <i>StartSlot</i>).
    ///    ppConstantBuffers = Array of constant buffers being given to the device.
    ///    pFirstConstant = An array that holds the offsets into the buffers that <i>ppConstantBuffers</i> specifies. Each offset
    ///                     specifies where, from the shader's point of view, each constant buffer starts. Each offset is measured in
    ///                     shader constants, which are 16 bytes (4*32-bit components). Therefore, an offset of 16 indicates that the
    ///                     start of the associated constant buffer is 256 bytes into the constant buffer. Each offset must be a multiple
    ///                     of 16 constants.
    ///    pNumConstants = An array that holds the numbers of constants in the buffers that <i>ppConstantBuffers</i> specifies. Each
    ///                    number specifies the number of constants that are contained in the constant buffer that the shader uses. Each
    ///                    number of constants starts from its respective offset that is specified in the <i>pFirstConstant</i> array.
    ///                    Each number of constants must be a multiple of 16 constants, in the range [0..4096].
    void HSSetConstantBuffers1(uint StartSlot, uint NumBuffers, ID3D11Buffer* ppConstantBuffers, 
                               const(uint)* pFirstConstant, const(uint)* pNumConstants);
    ///Sets the constant buffers that the domain-shader stage uses.
    ///Params:
    ///    StartSlot = Index into the zero-based array to begin setting constant buffers to (ranges from 0 to
    ///                D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1).
    ///    NumBuffers = Number of buffers to set (ranges from 0 to D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT -
    ///                 <i>StartSlot</i>).
    ///    ppConstantBuffers = Array of constant buffers being given to the device.
    ///    pFirstConstant = An array that holds the offsets into the buffers that <i>ppConstantBuffers</i> specifies. Each offset
    ///                     specifies where, from the shader's point of view, each constant buffer starts. Each offset is measured in
    ///                     shader constants, which are 16 bytes (4*32-bit components). Therefore, an offset of 16 indicates that the
    ///                     start of the associated constant buffer is 256 bytes into the constant buffer. Each offset must be a multiple
    ///                     of 16 constants.
    ///    pNumConstants = An array that holds the numbers of constants in the buffers that <i>ppConstantBuffers</i> specifies. Each
    ///                    number specifies the number of constants that are contained in the constant buffer that the shader uses. Each
    ///                    number of constants starts from its respective offset that is specified in the <i>pFirstConstant</i> array.
    ///                    Each number of constants must be a multiple of 16 constants, in the range [0..4096].
    void DSSetConstantBuffers1(uint StartSlot, uint NumBuffers, ID3D11Buffer* ppConstantBuffers, 
                               const(uint)* pFirstConstant, const(uint)* pNumConstants);
    ///Sets the constant buffers that the geometry shader pipeline stage uses.
    ///Params:
    ///    StartSlot = Index into the device's zero-based array to begin setting constant buffers to (ranges from 0 to
    ///                D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1).
    ///    NumBuffers = Number of buffers to set (ranges from 0 to D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT -
    ///                 <i>StartSlot</i>).
    ///    ppConstantBuffers = Array of constant buffers (see ID3D11Buffer) being given to the device.
    ///    pFirstConstant = An array that holds the offsets into the buffers that <i>ppConstantBuffers</i> specifies. Each offset
    ///                     specifies where, from the shader's point of view, each constant buffer starts. Each offset is measured in
    ///                     shader constants, which are 16 bytes (4*32-bit components). Therefore, an offset of 16 indicates that the
    ///                     start of the associated constant buffer is 256 bytes into the constant buffer. Each offset must be a multiple
    ///                     of 16 constants.
    ///    pNumConstants = An array that holds the numbers of constants in the buffers that <i>ppConstantBuffers</i> specifies. Each
    ///                    number specifies the number of constants that are contained in the constant buffer that the shader uses. Each
    ///                    number of constants starts from its respective offset that is specified in the <i>pFirstConstant</i> array.
    ///                    Each number of constants must be a multiple of 16 constants, in the range [0..4096].
    void GSSetConstantBuffers1(uint StartSlot, uint NumBuffers, ID3D11Buffer* ppConstantBuffers, 
                               const(uint)* pFirstConstant, const(uint)* pNumConstants);
    ///Sets the constant buffers that the pixel shader pipeline stage uses, and enables the shader to access other parts
    ///of the buffer.
    ///Params:
    ///    StartSlot = Type: <b>UINT</b> Index into the device's zero-based array to begin setting constant buffers to (ranges from
    ///                0 to D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1).
    ///    NumBuffers = Type: <b>UINT</b> Number of buffers to set (ranges from 0 to
    ///                 D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - <i>StartSlot</i>).
    ///    ppConstantBuffers = Type: <b>ID3D11Buffer*</b> Array of constant buffers being given to the device.
    ///    pFirstConstant = Type: <b>const UINT*</b> An array that holds the offsets into the buffers that <i>ppConstantBuffers</i>
    ///                     specifies. Each offset specifies where, from the shader's point of view, each constant buffer starts. Each
    ///                     offset is measured in shader constants, which are 16 bytes (4*32-bit components). Therefore, an offset of 16
    ///                     indicates that the start of the associated constant buffer is 256 bytes into the constant buffer. Each offset
    ///                     must be a multiple of 16 constants.
    ///    pNumConstants = Type: <b>const UINT*</b> An array that holds the numbers of constants in the buffers that
    ///                    <i>ppConstantBuffers</i> specifies. Each number specifies the number of constants that are contained in the
    ///                    constant buffer that the shader uses. Each number of constants starts from its respective offset that is
    ///                    specified in the <i>pFirstConstant</i> array. Each number of constants must be a multiple of 16 constants, in
    ///                    the range [0..4096].
    void PSSetConstantBuffers1(uint StartSlot, uint NumBuffers, ID3D11Buffer* ppConstantBuffers, 
                               const(uint)* pFirstConstant, const(uint)* pNumConstants);
    ///Sets the constant buffers that the compute-shader stage uses.
    ///Params:
    ///    StartSlot = Index into the zero-based array to begin setting constant buffers to (ranges from 0 to
    ///                D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1).
    ///    NumBuffers = Number of buffers to set (ranges from 0 to D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT -
    ///                 <i>StartSlot</i>).
    ///    ppConstantBuffers = Array of constant buffers (see ID3D11Buffer) being given to the device.
    ///    pFirstConstant = An array that holds the offsets into the buffers that <i>ppConstantBuffers</i> specifies. Each offset
    ///                     specifies where, from the shader's point of view, each constant buffer starts. Each offset is measured in
    ///                     shader constants, which are 16 bytes (4*32-bit components). Therefore, an offset of 16 indicates that the
    ///                     start of the associated constant buffer is 256 bytes into the constant buffer. Each offset must be a multiple
    ///                     of 16 constants.
    ///    pNumConstants = An array that holds the numbers of constants in the buffers that <i>ppConstantBuffers</i> specifies. Each
    ///                    number specifies the number of constants that are contained in the constant buffer that the shader uses. Each
    ///                    number of constants starts from its respective offset that is specified in the <i>pFirstConstant</i> array.
    ///                    Each number of constants must be a multiple of 16 constants, in the range [0..4096].
    void CSSetConstantBuffers1(uint StartSlot, uint NumBuffers, ID3D11Buffer* ppConstantBuffers, 
                               const(uint)* pFirstConstant, const(uint)* pNumConstants);
    ///Gets the constant buffers that the vertex shader pipeline stage uses.
    ///Params:
    ///    StartSlot = Index into the device's zero-based array to begin retrieving constant buffers from (ranges from 0 to
    ///                D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1).
    ///    NumBuffers = Number of buffers to retrieve (ranges from 0 to D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT -
    ///                 <i>StartSlot</i>).
    ///    ppConstantBuffers = Array of constant buffer interface pointers to be returned by the method.
    ///    pFirstConstant = A pointer to an array that receives the offsets into the buffers that <i>ppConstantBuffers</i> specifies.
    ///                     Each offset specifies where, from the shader's point of view, each constant buffer starts. Each offset is
    ///                     measured in shader constants, which are 16 bytes (4*32-bit components). Therefore, an offset of 2 indicates
    ///                     that the start of the associated constant buffer is 32 bytes into the constant buffer. The runtime sets
    ///                     <i>pFirstConstant</i> to <b>NULL</b> if the buffers do not have offsets.
    ///    pNumConstants = A pointer to an array that receives the numbers of constants in the buffers that <i>ppConstantBuffers</i>
    ///                    specifies. Each number specifies the number of constants that are contained in the constant buffer that the
    ///                    shader uses. Each number of constants starts from its respective offset that is specified in the
    ///                    <i>pFirstConstant</i> array. The runtime sets <i>pNumConstants</i> to <b>NULL</b> if it doesn't specify the
    ///                    numbers of constants in each buffer.
    void VSGetConstantBuffers1(uint StartSlot, uint NumBuffers, ID3D11Buffer* ppConstantBuffers, 
                               uint* pFirstConstant, uint* pNumConstants);
    ///Gets the constant buffers that the hull-shader stage uses.
    ///Params:
    ///    StartSlot = Index into the device's zero-based array to begin retrieving constant buffers from (ranges from 0 to
    ///                D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1).
    ///    NumBuffers = Number of buffers to retrieve (ranges from 0 to D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT -
    ///                 <i>StartSlot</i>).
    ///    ppConstantBuffers = Array of constant buffer interface pointers to be returned by the method.
    ///    pFirstConstant = A pointer to an array that receives the offsets into the buffers that <i>ppConstantBuffers</i> specifies.
    ///                     Each offset specifies where, from the shader's point of view, each constant buffer starts. Each offset is
    ///                     measured in shader constants, which are 16 bytes (4*32-bit components). Therefore, an offset of 2 indicates
    ///                     that the start of the associated constant buffer is 32 bytes into the constant buffer. The runtime sets
    ///                     <i>pFirstConstant</i> to <b>NULL</b> if the buffers do not have offsets.
    ///    pNumConstants = A pointer to an array that receives the numbers of constants in the buffers that <i>ppConstantBuffers</i>
    ///                    specifies. Each number specifies the number of constants that are contained in the constant buffer that the
    ///                    shader uses. Each number of constants starts from its respective offset that is specified in the
    ///                    <i>pFirstConstant</i> array. The runtime sets <i>pNumConstants</i> to <b>NULL</b> if it doesn't specify the
    ///                    numbers of constants in each buffer.
    void HSGetConstantBuffers1(uint StartSlot, uint NumBuffers, ID3D11Buffer* ppConstantBuffers, 
                               uint* pFirstConstant, uint* pNumConstants);
    ///Gets the constant buffers that the domain-shader stage uses.
    ///Params:
    ///    StartSlot = Index into the device's zero-based array to begin retrieving constant buffers from (ranges from 0 to
    ///                D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1).
    ///    NumBuffers = Number of buffers to retrieve (ranges from 0 to D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT -
    ///                 <i>StartSlot</i>).
    ///    ppConstantBuffers = Array of constant buffer interface pointers to be returned by the method.
    ///    pFirstConstant = A pointer to an array that receives the offsets into the buffers that <i>ppConstantBuffers</i> specifies.
    ///                     Each offset specifies where, from the shader's point of view, each constant buffer starts. Each offset is
    ///                     measured in shader constants, which are 16 bytes (4*32-bit components). Therefore, an offset of 2 indicates
    ///                     that the start of the associated constant buffer is 32 bytes into the constant buffer. The runtime sets
    ///                     <i>pFirstConstant</i> to <b>NULL</b> if the buffers do not have offsets.
    ///    pNumConstants = A pointer to an array that receives the numbers of constants in the buffers that <i>ppConstantBuffers</i>
    ///                    specifies. Each number specifies the number of constants that are contained in the constant buffer that the
    ///                    shader uses. Each number of constants starts from its respective offset that is specified in the
    ///                    <i>pFirstConstant</i> array. The runtime sets <i>pNumConstants</i> to <b>NULL</b> if it doesn't specify the
    ///                    numbers of constants in each buffer.
    void DSGetConstantBuffers1(uint StartSlot, uint NumBuffers, ID3D11Buffer* ppConstantBuffers, 
                               uint* pFirstConstant, uint* pNumConstants);
    ///Gets the constant buffers that the geometry shader pipeline stage uses.
    ///Params:
    ///    StartSlot = Index into the device's zero-based array to begin retrieving constant buffers from (ranges from 0 to
    ///                D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1).
    ///    NumBuffers = Number of buffers to retrieve (ranges from 0 to D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT -
    ///                 <i>StartSlot</i>).
    ///    ppConstantBuffers = Array of constant buffer interface pointers to be returned by the method.
    ///    pFirstConstant = A pointer to an array that receives the offsets into the buffers that <i>ppConstantBuffers</i> specifies.
    ///                     Each offset specifies where, from the shader's point of view, each constant buffer starts. Each offset is
    ///                     measured in shader constants, which are 16 bytes (4*32-bit components). Therefore, an offset of 2 indicates
    ///                     that the start of the associated constant buffer is 32 bytes into the constant buffer. The runtime sets
    ///                     <i>pFirstConstant</i> to <b>NULL</b> if the buffers do not have offsets.
    ///    pNumConstants = A pointer to an array that receives the numbers of constants in the buffers that <i>ppConstantBuffers</i>
    ///                    specifies. Each number specifies the number of constants that are contained in the constant buffer that the
    ///                    shader uses. Each number of constants starts from its respective offset that is specified in the
    ///                    <i>pFirstConstant</i> array. The runtime sets <i>pNumConstants</i> to <b>NULL</b> if it doesn't specify the
    ///                    numbers of constants in each buffer.
    void GSGetConstantBuffers1(uint StartSlot, uint NumBuffers, ID3D11Buffer* ppConstantBuffers, 
                               uint* pFirstConstant, uint* pNumConstants);
    ///Gets the constant buffers that the pixel shader pipeline stage uses.
    ///Params:
    ///    StartSlot = Index into the device's zero-based array to begin retrieving constant buffers from (ranges from 0 to
    ///                D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1).
    ///    NumBuffers = Number of buffers to retrieve (ranges from 0 to D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT -
    ///                 <i>StartSlot</i>).
    ///    ppConstantBuffers = Array of constant buffer interface pointers to be returned by the method.
    ///    pFirstConstant = A pointer to an array that receives the offsets into the buffers that <i>ppConstantBuffers</i> specifies.
    ///                     Each offset specifies where, from the shader's point of view, each constant buffer starts. Each offset is
    ///                     measured in shader constants, which are 16 bytes (4*32-bit components). Therefore, an offset of 2 indicates
    ///                     that the start of the associated constant buffer is 32 bytes into the constant buffer. The runtime sets
    ///                     <i>pFirstConstant</i> to <b>NULL</b> if the buffers do not have offsets.
    ///    pNumConstants = A pointer to an array that receives the numbers of constants in the buffers that <i>ppConstantBuffers</i>
    ///                    specifies. Each number specifies the number of constants that are contained in the constant buffer that the
    ///                    shader uses. Each number of constants starts from its respective offset that is specified in the
    ///                    <i>pFirstConstant</i> array. The runtime sets <i>pNumConstants</i> to <b>NULL</b> if it doesn't specify the
    ///                    numbers of constants in each buffer.
    void PSGetConstantBuffers1(uint StartSlot, uint NumBuffers, ID3D11Buffer* ppConstantBuffers, 
                               uint* pFirstConstant, uint* pNumConstants);
    ///Gets the constant buffers that the compute-shader stage uses.
    ///Params:
    ///    StartSlot = Index into the device's zero-based array to begin retrieving constant buffers from (ranges from 0 to
    ///                D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1).
    ///    NumBuffers = Number of buffers to retrieve (ranges from 0 to D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT -
    ///                 <i>StartSlot</i>).
    ///    ppConstantBuffers = Array of constant buffer interface pointers to be returned by the method.
    ///    pFirstConstant = A pointer to an array that receives the offsets into the buffers that <i>ppConstantBuffers</i> specifies.
    ///                     Each offset specifies where, from the shader's point of view, each constant buffer starts. Each offset is
    ///                     measured in shader constants, which are 16 bytes (4*32-bit components). Therefore, an offset of 2 indicates
    ///                     that the start of the associated constant buffer is 32 bytes into the constant buffer. The runtime sets
    ///                     <i>pFirstConstant</i> to <b>NULL</b> if the buffers do not have offsets.
    ///    pNumConstants = A pointer to an array that receives the numbers of constants in the buffers that <i>ppConstantBuffers</i>
    ///                    specifies. Each number specifies the number of constants that are contained in the constant buffer that the
    ///                    shader uses. Each number of constants starts from its respective offset that is specified in the
    ///                    <i>pFirstConstant</i> array. The runtime sets <i>pNumConstants</i> to <b>NULL</b> if it doesn't specify the
    ///                    numbers of constants in each buffer.
    void CSGetConstantBuffers1(uint StartSlot, uint NumBuffers, ID3D11Buffer* ppConstantBuffers, 
                               uint* pFirstConstant, uint* pNumConstants);
    ///Activates the given context state object and changes the current device behavior to Direct3D 11, Direct3D 10.1,
    ///or Direct3D 10.
    ///Params:
    ///    pState = A pointer to the ID3DDeviceContextState interface for the context state object that was previously created
    ///             through the ID3D11Device1::CreateDeviceContextState method. If <b>SwapDeviceContextState</b> is called with
    ///             <i>pState</i> set to <b>NULL</b>, the call has no effect.
    ///    ppPreviousState = A pointer to a variable that receives a pointer to the ID3DDeviceContextState interface for the
    ///                      previously-activated context state object.
    void SwapDeviceContextState(ID3DDeviceContextState pState, ID3DDeviceContextState* ppPreviousState);
    ///Sets all the elements in a resource view to one value.
    ///Params:
    ///    pView = A pointer to the ID3D11View interface that represents the resource view to clear.
    ///    Color = A 4-component array that represents the color to use to clear the resource view.
    ///    pRect = An array of D3D11_RECT structures for the rectangles in the resource view to clear. If <b>NULL</b>,
    ///            <b>ClearView</b> clears the entire surface.
    ///    NumRects = Number of rectangles in the array that the <i>pRect</i> parameter specifies.
    void ClearView(ID3D11View pView, const(float)* Color, const(RECT)* pRect, uint NumRects);
    ///Discards the specified elements in a resource view from the device context.
    ///Params:
    ///    pResourceView = Type: <b>ID3D11View*</b> A pointer to the ID3D11View interface for the resource view to discard. The resource
    ///                    that underlies the view must have been created with usage D3D11_USAGE_DEFAULT or D3D11_USAGE_DYNAMIC,
    ///                    otherwise the runtime drops the call to <b>DiscardView1</b>; if the debug layer is enabled, the runtime
    ///                    returns an error message.
    ///    pRects = Type: <b>const D3D11_RECT*</b> An array of D3D11_RECT structures for the rectangles in the resource view to
    ///             discard. If <b>NULL</b>, <b>DiscardView1</b> discards the entire view and behaves the same as DiscardView.
    ///    NumRects = Type: <b>UINT</b> Number of rectangles in the array that the <i>pRects</i> parameter specifies.
    void DiscardView1(ID3D11View pResourceView, const(RECT)* pRects, uint NumRects);
}

///The device interface represents a virtual adapter; it is used to create resources. <b>ID3D11Device1</b> adds new
///methods to those in ID3D11Device.
@GUID("A04BFB29-08EF-43D6-A49C-A9BDBDCBE686")
interface ID3D11Device1 : ID3D11Device
{
    ///Gets an immediate context, which can play back command lists.
    ///Params:
    ///    ppImmediateContext = Upon completion of the method, the passed pointer to an ID3D11DeviceContext1 interface pointer is
    ///                         initialized.
    void    GetImmediateContext1(ID3D11DeviceContext1* ppImmediateContext);
    ///Creates a deferred context, which can record command lists.
    ///Params:
    ///    ContextFlags = Reserved for future use. Pass 0.
    ///    ppDeferredContext = Upon completion of the method, the passed pointer to an ID3D11DeviceContext1 interface pointer is
    ///                        initialized.
    ///Returns:
    ///    Returns S_OK if successful; otherwise, returns one of the following: <ul> <li>Returns
    ///    <b>DXGI_ERROR_DEVICE_REMOVED</b> if the graphics adapter has been physically removed from the computer or a
    ///    driver upgrade for the graphics adapter has occurred. If this error occurs, you should destroy and re-create
    ///    the device. </li> <li>Returns <b>DXGI_ERROR_INVALID_CALL</b> if the <b>CreateDeferredContext1</b> method
    ///    cannot be called from the current context. For example, if the device was created with the
    ///    D3D11_CREATE_DEVICE_SINGLETHREADED value, <b>CreateDeferredContext1</b> returns
    ///    <b>DXGI_ERROR_INVALID_CALL</b>. </li> <li>Returns <b>E_INVALIDARG</b> if the <i>ContextFlags</i> parameter is
    ///    invalid. </li> <li>Returns <b>E_OUTOFMEMORY</b> if the application has exhausted available memory. </li>
    ///    </ul>
    ///    
    HRESULT CreateDeferredContext1(uint ContextFlags, ID3D11DeviceContext1* ppDeferredContext);
    ///Creates a blend-state object that encapsulates blend state for the output-merger stage and allows the
    ///configuration of logic operations.
    ///Params:
    ///    pBlendStateDesc = A pointer to a D3D11_BLEND_DESC1 structure that describes blend state.
    ///    ppBlendState = Address of a pointer to the ID3D11BlendState1 interface for the blend-state object created.
    ///Returns:
    ///    This method returns E_OUTOFMEMORY if there is insufficient memory to create the blend-state object. See
    ///    Direct3D 11 Return Codes for other possible return values.
    ///    
    HRESULT CreateBlendState1(const(D3D11_BLEND_DESC1)* pBlendStateDesc, ID3D11BlendState1* ppBlendState);
    ///Creates a rasterizer state object that informs the rasterizer stage how to behave and forces the sample count
    ///while UAV rendering or rasterizing.
    ///Params:
    ///    pRasterizerDesc = A pointer to a D3D11_RASTERIZER_DESC1 structure that describes the rasterizer state.
    ///    ppRasterizerState = Address of a pointer to the ID3D11RasterizerState1 interface for the rasterizer state object created.
    ///Returns:
    ///    This method returns E_OUTOFMEMORY if there is insufficient memory to create the rasterizer state object. See
    ///    Direct3D 11 Return Codes for other possible return values.
    ///    
    HRESULT CreateRasterizerState1(const(D3D11_RASTERIZER_DESC1)* pRasterizerDesc, 
                                   ID3D11RasterizerState1* ppRasterizerState);
    ///Creates a context state object that holds all Microsoft Direct3D state and some Direct3D behavior.
    ///Params:
    ///    Flags = Type: <b>UINT</b> A combination of D3D11_1_CREATE_DEVICE_CONTEXT_STATE_FLAG values that are combined by using
    ///            a bitwise <b>OR</b> operation. The resulting value specifies how to create the context state object. The
    ///            D3D11_1_CREATE_DEVICE_CONTEXT_STATE_SINGLETHREADEDflag is currently the only defined flag. If the original
    ///            device was created with D3D11_CREATE_DEVICE_SINGLETHREADED, you must create all context state objects from
    ///            that device with the <b>D3D11_1_CREATE_DEVICE_CONTEXT_STATE_SINGLETHREADED</b>flag. If you set the
    ///            single-threaded flag for both the context state object and the device, you guarantee that you will call the
    ///            whole set of context methods and device methods only from one thread. You therefore do not need to use
    ///            critical sections to synchronize access to the device context, and the runtime can avoid working with those
    ///            processor-intensive critical sections.
    ///    pFeatureLevels = Type: <b>const D3D_FEATURE_LEVEL*</b> A pointer to an array of D3D_FEATURE_LEVEL values. The array can
    ///                     contain elements from the following list and determines the order of feature levels for which creation is
    ///                     attempted. Unlike D3D11CreateDevice, you can't set <i>pFeatureLevels</i> to <b>NULL</b> because there is no
    ///                     default feature level array. ``` { D3D_FEATURE_LEVEL_11_1, D3D_FEATURE_LEVEL_11_0, D3D_FEATURE_LEVEL_10_1,
    ///                     D3D_FEATURE_LEVEL_10_0, D3D_FEATURE_LEVEL_9_3, D3D_FEATURE_LEVEL_9_2, D3D_FEATURE_LEVEL_9_1, }; ```
    ///    FeatureLevels = Type: <b>UINT</b> The number of elements in <i>pFeatureLevels</i>. Unlike D3D11CreateDevice, you must set
    ///                    <i>FeatureLevels</i> to greater than 0 because you can't set <i>pFeatureLevels</i> to <b>NULL</b>.
    ///    SDKVersion = Type: <b>UINT</b> The SDK version. You must set this parameter to <b>D3D11_SDK_VERSION</b>.
    ///    EmulatedInterface = Type: <b>REFIID</b> The globally unique identifier (GUID) for the emulated interface. This value specifies
    ///                        the behavior of the device when the context state object is active. Valid values are obtained by using the
    ///                        <b>__uuidof</b> operator on the ID3D10Device, ID3D10Device1, ID3D11Device, and ID3D11Device1 interfaces. See
    ///                        Remarks.
    ///    pChosenFeatureLevel = Type: <b>D3D_FEATURE_LEVEL*</b> A pointer to a variable that receives a D3D_FEATURE_LEVEL value from the
    ///                          <i>pFeatureLevels</i> array. This is the first array value with which <b>CreateDeviceContextState</b>
    ///                          succeeded in creating the context state object. If the call to <b>CreateDeviceContextState</b> fails, the
    ///                          variable pointed to by <i>pChosenFeatureLevel</i> is set to zero.
    ///    ppContextState = Type: <b>ID3DDeviceContextState**</b> The address of a pointer to an ID3DDeviceContextState object that
    ///                     represents the state of a Direct3D device.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT CreateDeviceContextState(uint Flags, const(D3D_FEATURE_LEVEL)* pFeatureLevels, uint FeatureLevels, 
                                     uint SDKVersion, const(GUID)* EmulatedInterface, 
                                     D3D_FEATURE_LEVEL* pChosenFeatureLevel, ID3DDeviceContextState* ppContextState);
    ///Gives a device access to a shared resource that is referenced by a handle and that was created on a different
    ///device. You must have previously created the resource as shared and specified that it uses NT handles (that is,
    ///you set the D3D11_RESOURCE_MISC_SHARED_NTHANDLE flag).
    ///Params:
    ///    hResource = A handle to the resource to open. For more info about this parameter, see Remarks.
    ///    returnedInterface = The globally unique identifier (GUID) for the resource interface. For more info about this parameter, see
    ///                        Remarks.
    ///    ppResource = A pointer to a variable that receives a pointer to the interface for the shared resource object to access.
    ///Returns:
    ///    This method returns one of the Direct3D 11 return codes. This method also returns E_ACCESSDENIED if the
    ///    permissions to access the resource aren't valid. <b>Platform Update for Windows 7: </b>On Windows 7 or
    ///    Windows Server 2008 R2 with the Platform Update for Windows 7 installed, <b>OpenSharedResource1</b> fails
    ///    with E_NOTIMPL because NTHANDLES are used. For more info about the Platform Update for Windows 7, see
    ///    Platform Update for Windows 7.
    ///    
    HRESULT OpenSharedResource1(HANDLE hResource, const(GUID)* returnedInterface, void** ppResource);
    ///Gives a device access to a shared resource that is referenced by name and that was created on a different device.
    ///You must have previously created the resource as shared and specified that it uses NT handles (that is, you set
    ///the D3D11_RESOURCE_MISC_SHARED_NTHANDLE flag).
    ///Params:
    ///    lpName = The name of the resource to open. This parameter cannot be <b>NULL</b>.
    ///    dwDesiredAccess = The requested access rights to the resource. In addition to the generic access rights, DXGI defines the
    ///                      following values: <ul> <li><b>DXGI_SHARED_RESOURCE_READ</b> ( 0x80000000L ) - specifies read access to the
    ///                      resource.</li> <li><b>DXGI_SHARED_RESOURCE_WRITE</b> ( 1 ) - specifies write access to the resource.</li>
    ///                      </ul> You can combine values by using a bitwise <b>OR</b> operation.
    ///    returnedInterface = The globally unique identifier (GUID) for the resource interface. For more info, see Remarks.
    ///    ppResource = A pointer to a variable that receives a pointer to the interface for the shared resource object to access.
    ///Returns:
    ///    This method returns one of the Direct3D 11 return codes. This method also returns E_ACCESSDENIED if the
    ///    permissions to access the resource aren't valid. <b>Platform Update for Windows 7: </b>On Windows 7 or
    ///    Windows Server 2008 R2 with the Platform Update for Windows 7 installed, <b>OpenSharedResourceByName</b>
    ///    fails with E_NOTIMPL because NTHANDLES are used. For more info about the Platform Update for Windows 7, see
    ///    Platform Update for Windows 7.
    ///    
    HRESULT OpenSharedResourceByName(const(PWSTR) lpName, uint dwDesiredAccess, const(GUID)* returnedInterface, 
                                     void** ppResource);
}

///The <b>ID3DUserDefinedAnnotation</b> interface enables an application to describe conceptual sections and markers
///within the application's code flow. An appropriately enabled tool, such as Microsoft Visual Studio Ultimate 2012, can
///display these sections and markers visually along the tool's Microsoft Direct3D time line, while the tool debugs the
///application. These visual notes allow users of such a tool to navigate to parts of the time line that are of
///interest, or to understand what set of Direct3D calls are produced by certain sections of the application's code.
@GUID("B2DAAD8B-03D4-4DBF-95EB-32AB4B63D0AB")
interface ID3DUserDefinedAnnotation : IUnknown
{
    ///Marks the beginning of a section of event code.
    ///Params:
    ///    Name = A <b>NULL</b>-terminated <b>UNICODE</b> string that contains the name of the event. The name is not relevant
    ///           to the operating system. You can choose a name that is meaningful when the calling application is running
    ///           under the Direct3D profiling tool. A <b>NULL</b> pointer produces undefined results.
    ///Returns:
    ///    Returns the number of previous calls to <b>BeginEvent</b> that have not yet been finalized by calls to the
    ///    ID3DUserDefinedAnnotation::EndEvent method. The return value is –1 if the calling application is not
    ///    running under a Direct3D profiling tool.
    ///    
    int  BeginEvent(const(PWSTR) Name);
    ///Marks the end of a section of event code.
    ///Returns:
    ///    Returns the number of previous calls to the ID3DUserDefinedAnnotation::BeginEvent method that have not yet
    ///    been finalized by calls to <b>EndEvent</b>. The return value is –1 if the calling application is not
    ///    running under a Direct3D profiling tool.
    ///    
    int  EndEvent();
    ///Marks a single point of execution in code.
    ///Params:
    ///    Name = A <b>NULL</b>-terminated <b>UNICODE</b> string that contains the name of the marker. The name is not relevant
    ///           to the operating system. You can choose a name that is meaningful when the calling application is running
    ///           under the Direct3D profiling tool. A <b>NULL</b> pointer produces undefined results.
    void SetMarker(const(PWSTR) Name);
    ///Determines whether the calling application is running under a Microsoft Direct3D profiling tool.
    ///Returns:
    ///    The return value is nonzero if the calling application is running under a Direct3D profiling tool such as
    ///    Visual Studio Ultimate 2012, and zero otherwise.
    ///    
    BOOL GetStatus();
}

///The device context interface represents a device context; it is used to render commands. <b>ID3D11DeviceContext2</b>
///adds new methods to those in ID3D11DeviceContext1.
@GUID("420D5B32-B90C-4DA4-BEF0-359F6A24A83A")
interface ID3D11DeviceContext2 : ID3D11DeviceContext1
{
    ///Updates mappings of tile locations in tiled resources to memory locations in a tile pool.
    ///Params:
    ///    pTiledResource = Type: <b>ID3D11Resource*</b> A pointer to the tiled resource.
    ///    NumTiledResourceRegions = Type: <b>UINT</b> The number of tiled resource regions.
    ///    pTiledResourceRegionStartCoordinates = Type: <b>const D3D11_TILED_RESOURCE_COORDINATE*</b> An array of D3D11_TILED_RESOURCE_COORDINATE structures
    ///                                           that describe the starting coordinates of the tiled resource regions. The <i>NumTiledResourceRegions</i>
    ///                                           parameter specifies the number of <b>D3D11_TILED_RESOURCE_COORDINATE</b> structures in the array.
    ///    pTiledResourceRegionSizes = Type: <b>const D3D11_TILE_REGION_SIZE*</b> An array of D3D11_TILE_REGION_SIZE structures that describe the
    ///                                sizes of the tiled resource regions. The <i>NumTiledResourceRegions</i> parameter specifies the number of
    ///                                <b>D3D11_TILE_REGION_SIZE</b> structures in the array.
    ///    pTilePool = Type: <b>ID3D11Buffer*</b> A pointer to the tile pool.
    ///    NumRanges = Type: <b>UINT</b> The number of tile-pool ranges.
    ///    pRangeFlags = Type: <b>const UINT*</b> An array of D3D11_TILE_RANGE_FLAG values that describe each tile-pool range. The
    ///                  <i>NumRanges</i> parameter specifies the number of values in the array.
    ///    pTilePoolStartOffsets = Type: <b>const UINT*</b> An array of offsets into the tile pool. These are 0-based tile offsets, counting in
    ///                            tiles (not bytes).
    ///    pRangeTileCounts = Type: <b>const UINT*</b> An array of tiles. An array of values that specify the number of tiles in each
    ///                       tile-pool range. The <i>NumRanges</i> parameter specifies the number of values in the array.
    ///    Flags = Type: <b>UINT</b> A combination of D3D11_TILE_MAPPING_FLAGS values that are combined by using a bitwise OR
    ///            operation.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the following: <ul> <li>Returns
    ///    <b>E_INVALIDARG</b> if various conditions such as invalid flags result in the call being dropped.The debug
    ///    layer will emit an error. </li> <li>Returns <b>E_OUTOFMEMORY</b> if the call results in the driver having to
    ///    allocate space for new page table mappings but running out of memory.If out of memory occurs when this is
    ///    called in a commandlist and the commandlist is being executed, the device will be removed. Apps can avoid
    ///    this situation by only doing update calls that change existing mappings from tiled resources within
    ///    commandlists (so drivers will not have to allocate page table memory, only change the mapping). </li>
    ///    <li>Returns <b>DXGI_ERROR_DEVICE_REMOVED</b> if the video card has been physically removed from the system,
    ///    or a driver upgrade for the video card has occurred. </li> </ul>
    ///    
    HRESULT UpdateTileMappings(ID3D11Resource pTiledResource, uint NumTiledResourceRegions, 
                               const(D3D11_TILED_RESOURCE_COORDINATE)* pTiledResourceRegionStartCoordinates, 
                               const(D3D11_TILE_REGION_SIZE)* pTiledResourceRegionSizes, ID3D11Buffer pTilePool, 
                               uint NumRanges, const(uint)* pRangeFlags, const(uint)* pTilePoolStartOffsets, 
                               const(uint)* pRangeTileCounts, uint Flags);
    ///Copies mappings from a source tiled resource to a destination tiled resource.
    ///Params:
    ///    pDestTiledResource = Type: <b>ID3D11Resource*</b> A pointer to the destination tiled resource.
    ///    pDestRegionStartCoordinate = Type: <b>const D3D11_TILED_RESOURCE_COORDINATE*</b> A pointer to a D3D11_TILED_RESOURCE_COORDINATE structure
    ///                                 that describes the starting coordinates of the destination tiled resource.
    ///    pSourceTiledResource = Type: <b>ID3D11Resource*</b> A pointer to the source tiled resource.
    ///    pSourceRegionStartCoordinate = Type: <b>const D3D11_TILED_RESOURCE_COORDINATE*</b> A pointer to a D3D11_TILED_RESOURCE_COORDINATE structure
    ///                                   that describes the starting coordinates of the source tiled resource.
    ///    pTileRegionSize = Type: <b>const D3D11_TILE_REGION_SIZE*</b> A pointer to a D3D11_TILE_REGION_SIZE structure that describes the
    ///                      size of the tiled region.
    ///    Flags = Type: <b>UINT</b> A combination of D3D11_TILE_MAPPING_FLAGS values that are combined by using a bitwise OR
    ///            operation. The only valid value is <b>D3D11_TILE_MAPPING_NO_OVERWRITE</b>, which indicates that previously
    ///            submitted commands to the device that may still be executing do not reference any of the tile region being
    ///            updated. The device can then avoid having to flush previously submitted work to perform the tile mapping
    ///            update. If the app violates this promise by updating tile mappings for locations in tiled resources that are
    ///            still being referenced by outstanding commands, undefined rendering behavior results, including the potential
    ///            for significant slowdowns on some architectures. This is like the "no overwrite" concept that exists
    ///            elsewhere in the Direct3D API, except applied to the tile mapping data structure itself (which in hardware is
    ///            a page table). The absence of the <b>D3D11_TILE_MAPPING_NO_OVERWRITE</b> value requires that tile mapping
    ///            updates that <b>CopyTileMappings</b> specifies must be completed before any subsequent Direct3D command can
    ///            proceed.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the following: <ul> <li>Returns
    ///    <b>E_INVALIDARG</b> if various conditions such as invalid flags or passing in non Tiled Resources result in
    ///    the call being dropped. The dest and the source regions must each entirely fit in their resource or behavior
    ///    is undefined (debug layer will emit an error). </li> <li>Returns <b>E_OUTOFMEMORY</b> if the call results in
    ///    the driver having to allocate space for new page table mappings but running out of memory. If out of memory
    ///    occurs when this is called in a commandlist and the commandlist is being executed, the device will be
    ///    removed. Applications can avoid this situation by only doing update calls that change existing mappings from
    ///    Tiled Resources within commandlists (so drivers will not have to allocate page table memory, only change the
    ///    mapping). </li> </ul>
    ///    
    HRESULT CopyTileMappings(ID3D11Resource pDestTiledResource, 
                             const(D3D11_TILED_RESOURCE_COORDINATE)* pDestRegionStartCoordinate, 
                             ID3D11Resource pSourceTiledResource, 
                             const(D3D11_TILED_RESOURCE_COORDINATE)* pSourceRegionStartCoordinate, 
                             const(D3D11_TILE_REGION_SIZE)* pTileRegionSize, uint Flags);
    ///Copies tiles from buffer to tiled resource or vice versa.
    ///Params:
    ///    pTiledResource = Type: <b>ID3D11Resource*</b> A pointer to a tiled resource.
    ///    pTileRegionStartCoordinate = Type: <b>const D3D11_TILED_RESOURCE_COORDINATE*</b> A pointer to a D3D11_TILED_RESOURCE_COORDINATE structure
    ///                                 that describes the starting coordinates of the tiled resource.
    ///    pTileRegionSize = Type: <b>const D3D11_TILE_REGION_SIZE*</b> A pointer to a D3D11_TILE_REGION_SIZE structure that describes the
    ///                      size of the tiled region.
    ///    pBuffer = Type: <b>ID3D11Buffer*</b> A pointer to an ID3D11Buffer that represents a default, dynamic, or staging
    ///              buffer.
    ///    BufferStartOffsetInBytes = Type: <b>UINT64</b> The offset in bytes into the buffer at <i>pBuffer</i> to start the operation.
    ///    Flags = Type: <b>UINT</b> A combination of D3D11_TILE_COPY_FLAG-typed values that are combined by using a bitwise OR
    ///            operation and that identifies how to copy tiles.
    void    CopyTiles(ID3D11Resource pTiledResource, 
                      const(D3D11_TILED_RESOURCE_COORDINATE)* pTileRegionStartCoordinate, 
                      const(D3D11_TILE_REGION_SIZE)* pTileRegionSize, ID3D11Buffer pBuffer, 
                      ulong BufferStartOffsetInBytes, uint Flags);
    ///Updates tiles by copying from app memory to the tiled resource.
    ///Params:
    ///    pDestTiledResource = Type: <b>ID3D11Resource*</b> A pointer to a tiled resource to update.
    ///    pDestTileRegionStartCoordinate = Type: <b>const D3D11_TILED_RESOURCE_COORDINATE*</b> A pointer to a D3D11_TILED_RESOURCE_COORDINATE structure
    ///                                     that describes the starting coordinates of the tiled resource.
    ///    pDestTileRegionSize = Type: <b>const D3D11_TILE_REGION_SIZE*</b> A pointer to a D3D11_TILE_REGION_SIZE structure that describes the
    ///                          size of the tiled region.
    ///    pSourceTileData = Type: <b>const void*</b> A pointer to memory that contains the source tile data that <b>UpdateTiles</b> uses
    ///                      to update the tiled resource.
    ///    Flags = Type: <b>UINT</b> A combination of D3D11_TILE_COPY_FLAG-typed values that are combined by using a bitwise OR
    ///            operation. The only valid value is <b>D3D11_TILE_COPY_NO_OVERWRITE</b>. The other values aren't meaningful
    ///            here, though by definition the <b>D3D11_TILE_COPY_LINEAR_BUFFER_TO_SWIZZLED_TILED_RESOURCE</b> value is
    ///            basically what <b>UpdateTiles</b> does, but sources from app memory.
    void    UpdateTiles(ID3D11Resource pDestTiledResource, 
                        const(D3D11_TILED_RESOURCE_COORDINATE)* pDestTileRegionStartCoordinate, 
                        const(D3D11_TILE_REGION_SIZE)* pDestTileRegionSize, const(void)* pSourceTileData, uint Flags);
    ///Resizes a tile pool.
    ///Params:
    ///    pTilePool = Type: <b>ID3D11Buffer*</b> A pointer to an ID3D11Buffer for the tile pool to resize.
    ///    NewSizeInBytes = Type: <b>UINT64</b> The new size in bytes of the tile pool. The size must be a multiple of 64 KB or 0.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the following: <ul> <li>Returns
    ///    <b>E_INVALIDARG</b> if the new tile pool size isn't a multiple of 64 KB or 0.</li> <li>Returns
    ///    <b>E_OUTOFMEMORY</b> if the call results in the driver having to allocate space for new page table mappings
    ///    but running out of memory.</li> <li>Returns <b>DXGI_ERROR_DEVICE_REMOVED</b> if the video card has been
    ///    physically removed from the system, or a driver upgrade for the video card has occurred.</li> </ul> For
    ///    <b>E_INVALIDARG</b> or <b>E_OUTOFMEMORY</b>, the existing tile pool remains unchanged, which includes
    ///    existing mappings.
    ///    
    HRESULT ResizeTilePool(ID3D11Buffer pTilePool, ulong NewSizeInBytes);
    ///Specifies a data access ordering constraint between multiple tiled resources. For more info about this
    ///constraint, see Remarks.
    ///Params:
    ///    pTiledResourceOrViewAccessBeforeBarrier = Type: <b>ID3D11DeviceChild*</b> A pointer to an ID3D11Resource or ID3D11View for a resource that was created
    ///                                              with the D3D11_RESOURCE_MISC_TILED flag. Access operations on this object must complete before the access
    ///                                              operations on the object that <i>pTiledResourceOrViewAccessAfterBarrier</i> specifies.
    ///    pTiledResourceOrViewAccessAfterBarrier = Type: <b>ID3D11DeviceChild*</b> A pointer to an ID3D11Resource or ID3D11View for a resource that was created
    ///                                             with the D3D11_RESOURCE_MISC_TILED flag. Access operations on this object must begin after the access
    ///                                             operations on the object that <i>pTiledResourceOrViewAccessBeforeBarrier</i> specifies.
    void    TiledResourceBarrier(ID3D11DeviceChild pTiledResourceOrViewAccessBeforeBarrier, 
                                 ID3D11DeviceChild pTiledResourceOrViewAccessAfterBarrier);
    ///Allows apps to determine when either a capture or profiling request is enabled.
    ///Returns:
    ///    Returns <b>TRUE</b> if capture or profiling is enabled and <b>FALSE</b> otherwise.
    ///    
    BOOL    IsAnnotationEnabled();
    ///Allows applications to annotate graphics commands.
    ///Params:
    ///    pLabel = An optional string that will be logged to ETW when ETW logging is active. If <b>‘
    ///    Data = A signed data value that will be logged to ETW when ETW logging is active.
    void    SetMarkerInt(const(PWSTR) pLabel, int Data);
    ///Allows applications to annotate the beginning of a range of graphics commands.
    ///Params:
    ///    pLabel = An optional string that will be logged to ETW when ETW logging is active. If <b>‘
    ///    Data = A signed data value that will be logged to ETW when ETW logging is active.
    void    BeginEventInt(const(PWSTR) pLabel, int Data);
    ///Allows applications to annotate the end of a range of graphics commands.
    void    EndEvent();
}

///The device interface represents a virtual adapter; it is used to create resources. <b>ID3D11Device2</b> adds new
///methods to those in ID3D11Device1.
@GUID("9D06DFFA-D1E5-4D07-83A8-1BB123F2F841")
interface ID3D11Device2 : ID3D11Device1
{
    ///Gets an immediate context, which can play back command lists.
    ///Params:
    ///    ppImmediateContext = Type: <b>ID3D11DeviceContext2**</b> Upon completion of the method, the passed pointer to an
    ///                         ID3D11DeviceContext2 interface pointer is initialized.
    void    GetImmediateContext2(ID3D11DeviceContext2* ppImmediateContext);
    ///Creates a deferred context, which can record command lists.
    ///Params:
    ///    ContextFlags = Type: <b>UINT</b> Reserved for future use. Pass 0.
    ///    ppDeferredContext = Type: <b>ID3D11DeviceContext2**</b> Upon completion of the method, the passed pointer to an
    ///                        ID3D11DeviceContext2 interface pointer is initialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the following: <ul> <li>Returns
    ///    <b>DXGI_ERROR_DEVICE_REMOVED</b> if the video card has been physically removed from the system, or a driver
    ///    upgrade for the video card has occurred. If this error occurs, you should destroy and recreate the device.
    ///    </li> <li>Returns <b>DXGI_ERROR_INVALID_CALL</b> if the <b>CreateDeferredContext2</b> method can't be called
    ///    from the current context. For example, if the device was created with the D3D11_CREATE_DEVICE_SINGLETHREADED
    ///    value, <b>CreateDeferredContext2</b> returns <b>DXGI_ERROR_INVALID_CALL</b>. </li> <li>Returns
    ///    <b>E_INVALIDARG</b> if the <i>ContextFlags</i> parameter is invalid. </li> <li>Returns <b>E_OUTOFMEMORY</b>
    ///    if the app has exhausted available memory. </li> </ul>
    ///    
    HRESULT CreateDeferredContext2(uint ContextFlags, ID3D11DeviceContext2* ppDeferredContext);
    ///Gets info about how a tiled resource is broken into tiles.
    ///Params:
    ///    pTiledResource = Type: <b>ID3D11Resource*</b> A pointer to the tiled resource to get info about.
    ///    pNumTilesForEntireResource = Type: <b>UINT*</b> A pointer to a variable that receives the number of tiles needed to store the entire tiled
    ///                                 resource.
    ///    pPackedMipDesc = Type: <b>D3D11_PACKED_MIP_DESC*</b> A pointer to a D3D11_PACKED_MIP_DESC structure that
    ///                     <b>GetResourceTiling</b> fills with info about how the tiled resource's mipmaps are packed.
    ///    pStandardTileShapeForNonPackedMips = Type: <b>D3D11_TILE_SHAPE*</b> A pointer to a D3D11_TILE_SHAPE structure that <b>GetResourceTiling</b> fills
    ///                                         with info about the tile shape. This is info about how pixels fit in the tiles, independent of tiled
    ///                                         resource's dimensions, not including packed mipmaps. If the entire tiled resource is packed, this parameter
    ///                                         is meaningless because the tiled resource has no defined layout for packed mipmaps. In this situation,
    ///                                         <b>GetResourceTiling</b> sets the members of <b>D3D11_TILE_SHAPE</b> to zeros.
    ///    pNumSubresourceTilings = Type: <b>UINT*</b> A pointer to a variable that contains the number of tiles in the subresource. On input,
    ///                             this is the number of subresources to query tilings for; on output, this is the number that was actually
    ///                             retrieved at <i>pSubresourceTilingsForNonPackedMips</i> (clamped to what's available).
    ///    FirstSubresourceTilingToGet = Type: <b>UINT</b> The number of the first subresource tile to get. <b>GetResourceTiling</b> ignores this
    ///                                  parameter if the number that <i>pNumSubresourceTilings</i> points to is 0.
    ///    pSubresourceTilingsForNonPackedMips = Type: <b>D3D11_SUBRESOURCE_TILING*</b> A pointer to a D3D11_SUBRESOURCE_TILING structure that
    ///                                          <b>GetResourceTiling</b> fills with info about subresource tiles. If subresource tiles are part of packed
    ///                                          mipmaps, <b>GetResourceTiling</b> sets the members of D3D11_SUBRESOURCE_TILING to zeros, except the
    ///                                          <b>StartTileIndexInOverallResource</b> member, which <b>GetResourceTiling</b> sets to
    ///                                          <b>D3D11_PACKED_TILE</b> (0xffffffff). The <b>D3D11_PACKED_TILE</b> constant indicates that the whole
    ///                                          <b>D3D11_SUBRESOURCE_TILING</b> structure is meaningless for this situation, and the info that the
    ///                                          <i>pPackedMipDesc</i> parameter points to applies.
    void    GetResourceTiling(ID3D11Resource pTiledResource, uint* pNumTilesForEntireResource, 
                              D3D11_PACKED_MIP_DESC* pPackedMipDesc, 
                              D3D11_TILE_SHAPE* pStandardTileShapeForNonPackedMips, uint* pNumSubresourceTilings, 
                              uint FirstSubresourceTilingToGet, 
                              D3D11_SUBRESOURCE_TILING* pSubresourceTilingsForNonPackedMips);
    ///Get the number of quality levels available during multisampling.
    ///Params:
    ///    Format = Type: <b>DXGI_FORMAT</b> The texture format during multisampling.
    ///    SampleCount = Type: <b>UINT</b> The number of samples during multisampling.
    ///    Flags = Type: <b>UINT</b> A combination of D3D11_CHECK_MULTISAMPLE_QUALITY_LEVELS_FLAGS values that are combined by
    ///            using a bitwise OR operation. Currently, only D3D11_CHECK_MULTISAMPLE_QUALITY_LEVELS_TILED_RESOURCE is
    ///            supported.
    ///    pNumQualityLevels = Type: <b>UINT*</b> A pointer to a variable the receives the number of quality levels supported by the
    ///                        adapter. See Remarks.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT CheckMultisampleQualityLevels1(DXGI_FORMAT Format, uint SampleCount, uint Flags, 
                                           uint* pNumQualityLevels);
}

///A 2D texture interface represents texel data, which is structured memory.
@GUID("51218251-1E33-4617-9CCB-4D3A4367E7BB")
interface ID3D11Texture2D1 : ID3D11Texture2D
{
    ///Gets the properties of the texture resource.
    ///Params:
    ///    pDesc = Type: <b>D3D11_TEXTURE2D_DESC1*</b> A pointer to a D3D11_TEXTURE2D_DESC1 structure that receives the
    ///            description of the 2D texture.
    void GetDesc1(D3D11_TEXTURE2D_DESC1* pDesc);
}

///A 3D texture interface represents texel data, which is structured memory.
@GUID("0C711683-2853-4846-9BB0-F3E60639E46A")
interface ID3D11Texture3D1 : ID3D11Texture3D
{
    ///Gets the properties of the texture resource.
    ///Params:
    ///    pDesc = Type: <b>D3D11_TEXTURE3D_DESC1*</b> A pointer to a D3D11_TEXTURE3D_DESC1 structure that receives the
    ///            description of the 3D texture.
    void GetDesc1(D3D11_TEXTURE3D_DESC1* pDesc);
}

///The rasterizer-state interface holds a description for rasterizer state that you can bind to the rasterizer stage.
///This rasterizer-state interface supports forced sample count and conservative rasterization mode.
@GUID("6FBD02FB-209F-46C4-B059-2ED15586A6AC")
interface ID3D11RasterizerState2 : ID3D11RasterizerState1
{
    ///Gets the description for rasterizer state that you used to create the rasterizer-state object.
    ///Params:
    ///    pDesc = A pointer to a D3D11_RASTERIZER_DESC2 structure that receives a description of the rasterizer state. This
    ///            rasterizer state can specify forced sample count and conservative rasterization mode.
    void GetDesc2(D3D11_RASTERIZER_DESC2* pDesc);
}

///A shader-resource-view interface represents the subresources a shader can access during rendering. Examples of shader
///resources include a constant buffer, a texture buffer, and a texture.
@GUID("91308B87-9040-411D-8C67-C39253CE3802")
interface ID3D11ShaderResourceView1 : ID3D11ShaderResourceView
{
    ///Gets the shader-resource view's description.
    ///Params:
    ///    pDesc1 = Type: <b>D3D11_SHADER_RESOURCE_VIEW_DESC1*</b> A pointer to a D3D11_SHADER_RESOURCE_VIEW_DESC1 structure that
    ///             receives the description of the shader-resource view.
    void GetDesc1(D3D11_SHADER_RESOURCE_VIEW_DESC1* pDesc1);
}

///A render-target-view interface represents the render-target subresources that can be accessed during rendering.
@GUID("FFBE2E23-F011-418A-AC56-5CEED7C5B94B")
interface ID3D11RenderTargetView1 : ID3D11RenderTargetView
{
    ///Gets the properties of a render-target view.
    ///Params:
    ///    pDesc1 = Type: <b>D3D11_RENDER_TARGET_VIEW_DESC1*</b> A pointer to a D3D11_RENDER_TARGET_VIEW_DESC1 structure that
    ///             receives the description of the render-target view.
    void GetDesc1(D3D11_RENDER_TARGET_VIEW_DESC1* pDesc1);
}

///An unordered-access-view interface represents the parts of a resource the pipeline can access during rendering.
@GUID("7B3B6153-A886-4544-AB37-6537C8500403")
interface ID3D11UnorderedAccessView1 : ID3D11UnorderedAccessView
{
    ///Gets a description of the resource.
    ///Params:
    ///    pDesc1 = Type: <b>D3D11_UNORDERED_ACCESS_VIEW_DESC1*</b> A pointer to a D3D11_UNORDERED_ACCESS_VIEW_DESC1 structure
    ///             that receives the description of the unordered-access resource.
    void GetDesc1(D3D11_UNORDERED_ACCESS_VIEW_DESC1* pDesc1);
}

///Represents a query object for querying information from the graphics processing unit (GPU).
@GUID("631B4766-36DC-461D-8DB6-C47E13E60916")
interface ID3D11Query1 : ID3D11Query
{
    ///Gets a query description.
    ///Params:
    ///    pDesc1 = Type: <b>D3D11_QUERY_DESC1*</b> A pointer to a D3D11_QUERY_DESC1 structure that receives a description of the
    ///             query.
    void GetDesc1(D3D11_QUERY_DESC1* pDesc1);
}

///The device context interface represents a device context; it is used to render commands. <b>ID3D11DeviceContext3</b>
///adds new methods to those in ID3D11DeviceContext2.
@GUID("B4E3C01D-E79E-4637-91B2-510E9F4C9B8F")
interface ID3D11DeviceContext3 : ID3D11DeviceContext2
{
    ///Sends queued-up commands in the command buffer to the graphics processing unit (GPU), with a specified context
    ///type and an optional event handle to create an event query.
    ///Params:
    ///    ContextType = Type: <b>D3D11_CONTEXT_TYPE</b> A D3D11_CONTEXT_TYPE that specifies the context in which a query occurs, such
    ///                  as a 3D command queue, 3D compute queue, 3D copy queue, video, or image.
    ///    hEvent = Type: <b>HANDLE</b> An optional event handle. When specified, this method creates an event query.
    ///             <b>Flush1</b> operates asynchronously, therefore it can return either before or after the GPU finishes
    ///             executing the queued graphics commands, which will eventually complete. To create an event query, you can
    ///             call ID3D11Device::CreateQuery with the value D3D11_QUERY_EVENT value. To determine when the GPU is finished
    ///             processing the graphics commands, you can then use that event query in a call to
    ///             ID3D11DeviceContext::GetData.
    void Flush1(D3D11_CONTEXT_TYPE ContextType, HANDLE hEvent);
    ///Sets the hardware protection state.
    ///Params:
    ///    HwProtectionEnable = Type: <b>BOOL</b> Specifies whether to enable hardware protection.
    void SetHardwareProtectionState(BOOL HwProtectionEnable);
    ///Gets whether hardware protection is enabled.
    ///Params:
    ///    pHwProtectionEnable = Type: <b>BOOL*</b> After this method returns, points to a BOOL that indicates whether hardware protection is
    ///                          enabled.
    void GetHardwareProtectionState(BOOL* pHwProtectionEnable);
}

///Represents a fence, an object used for synchronization of the CPU and one or more GPUs. This interface is equivalent
///to the Direct3D 12 ID3D12Fence inteface, and is also used for synchronization between Direct3D 11 and Direct3D 12 in
///interop scenarios.
@GUID("AFFDE9D1-1DF7-4BB7-8A34-0F46251DAB80")
interface ID3D11Fence : ID3D11DeviceChild
{
    ///Creates a shared handle to a fence object. This method is equivalent to the Direct3D 12
    ///ID3D12Device::CreateSharedHandle method, and it applies in scenarios involving interoperation between Direct3D 11
    ///and Direct3D 12. In DirecX 11, you can open the shared fence handle with the ID3D11Device5::OpenSharedFence
    ///method. In DirecX 12, you can open the shared fence handle with the ID3D12Device::OpenSharedHandle method.
    ///Params:
    ///    pAttributes = Type: <b>const SECURITY_ATTRIBUTES*</b> A pointer to a SECURITY_ATTRIBUTESstructure that contains two
    ///                  separate but related data members: an optional security descriptor, and a <b>Boolean</b>value that determines
    ///                  whether child processes can inherit the returned handle. Set this parameter to <b>NULL</b> if you want child
    ///                  processes that the application might create to not inherit the handle returned by <b>CreateSharedHandle</b>,
    ///                  and if you want the resource that is associated with the returned handle to get a default security
    ///                  descriptor. The <b>lpSecurityDescriptor</b> member of the structure specifies a SECURITY_DESCRIPTOR for the
    ///                  resource. Set this member to <b>NULL</b> if you want the runtime to assign a default security descriptor to
    ///                  the resource that is associated with the returned handle. The ACLs in the default security descriptor for the
    ///                  resource come from the primary or impersonation token of the creator. For more info, see Synchronization
    ///                  Object Security and Access Rights.
    ///    dwAccess = Type: <b>DWORD</b> Currently the only value this parameter accepts is GENERIC_ALL.
    ///    lpName = Type: <b>LPCWSTR</b> A <b>NULL</b>-terminated <b>UNICODE</b> string that contains the name to associate with
    ///             the shared heap. The name is limited to MAX_PATH characters. Name comparison is case-sensitive. If
    ///             <i>Name</i> matches the name of an existing resource, <b>CreateSharedHandle</b> fails with
    ///             DXGI_ERROR_NAME_ALREADY_EXISTS. This occurs because these objects share the same namespace. The name can have
    ///             a "Global\" or "Local\" prefix to explicitly create the object in the global or session namespace. The
    ///             remainder of the name can contain any character except the backslash character (\\). For more information,
    ///             see Kernel Object Namespaces. Fast user switching is implemented using Terminal Services sessions. Kernel
    ///             object names must follow the guidelines outlined for Terminal Services so that applications can support
    ///             multiple users. The object can be created in a private namespace. For more information, see Object
    ///             Namespaces.
    ///    pHandle = Type: <b>HANDLE*</b> A pointer to a variable that receives the NT HANDLE value to the resource to share. You
    ///              can use this handle in calls to access the resource.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the following values: <ul>
    ///    <li>DXGI_ERROR_INVALID_CALL if one of the parameters is invalid. </li> <li>DXGI_ERROR_NAME_ALREADY_EXISTS if
    ///    the supplied name of the resource to share is already associated with another resource. </li>
    ///    <li>E_ACCESSDENIED if the object is being created in a protected namespace.</li> <li>E_OUTOFMEMORY if
    ///    sufficient memory is not available to create the handle.</li> <li>Possibly other error codes that are
    ///    described in the Direct3D 11 Return Codes topic. </li> </ul>
    ///    
    HRESULT CreateSharedHandle(const(SECURITY_ATTRIBUTES)* pAttributes, uint dwAccess, const(PWSTR) lpName, 
                               HANDLE* pHandle);
    ///Gets the current value of the fence. This member function is equivalent to the Direct3D 12
    ///ID3D12Fence::GetCompletedValue member function, and applies between Direct3D 11 and Direct3D 12 in interop
    ///scenarios.
    ///Returns:
    ///    Type: <b>UINT64</b> Returns the current value of the fence.
    ///    
    ulong   GetCompletedValue();
    ///Specifies an event that should be fired when the fence reaches a certain value. This member function is
    ///equivalent to the Direct3D 12 ID3D12Fence::SetEventOnCompletion member function, and applies between Direct3D 11
    ///and Direct3D 12 in interop scenarios.
    ///Params:
    ///    Value = Type: <b>UINT64</b> The fence value when the event is to be signaled.
    ///    hEvent = Type: <b>HANDLE</b> A handle to the event object.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns <b>E_OUTOFMEMORY</b> if the kernel components don’t have
    ///    sufficient memory to store the event in a list. See Direct3D 11 Return Codes for other possible return
    ///    values.
    ///    
    HRESULT SetEventOnCompletion(ulong Value, HANDLE hEvent);
}

///The device context interface represents a device context; it is used to render commands. <b>ID3D11DeviceContext4</b>
///adds new methods to those in ID3D11DeviceContext3. <div class="alert"><b>Note</b> This interface, introduced in the
///Windows 10 Creators Update, is the latest version of the ID3D11DeviceContext interface. Applications targetting
///Windows 10 Creators Update should use this interface instead of earlier versions.</div><div> </div>
@GUID("917600DA-F58C-4C33-98D8-3E15B390FA24")
interface ID3D11DeviceContext4 : ID3D11DeviceContext3
{
    ///Updates a fence to a specified value after all previous work has completed. This member function is equivalent to
    ///the Direct3D 12 ID3D12CommandQueue::Signal member function, and applies between Direct3D 11 and Direct3D 12 in
    ///interop scenarios. <div class="alert"><b>Note</b> This method only applies to immediate-mode contexts.</div><div>
    ///</div>
    ///Params:
    ///    pFence = Type: <b>ID3D11Fence*</b> A pointer to the ID3D11Fence object.
    ///    Value = Type: <b>UINT64</b> The value to set the fence to.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT Signal(ID3D11Fence pFence, ulong Value);
    ///Waits until the specified fence reaches or exceeds the specified value before future work can begin. This member
    ///function is equivalent to the Direct3D 12 ID3D12CommandQueue::Wait member function, and applies between Direct3D
    ///11 and Direct3D 12 in interop scenarios. <div class="alert"><b>Note</b> This method only applies to
    ///immediate-mode contexts.</div><div> </div>
    ///Params:
    ///    pFence = Type: <b>ID3D11Fence*</b> A pointer to the ID3D11Fence object.
    ///    Value = Type: <b>UINT64</b> The value that the device context is waiting for the fence to reach or exceed. So when
    ///            ID3D11Fence::GetCompletedValue is greater than or equal to <i>Value</i>, the wait is terminated.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT Wait(ID3D11Fence pFence, ulong Value);
}

///The device interface represents a virtual adapter; it is used to create resources. <b>ID3D11Device3</b> adds new
///methods to those in ID3D11Device2.
@GUID("A05C8C37-D2C6-4732-B3A0-9CE0B0DC9AE6")
interface ID3D11Device3 : ID3D11Device2
{
    ///Creates a 2D texture.
    ///Params:
    ///    pDesc1 = Type: <b>const D3D11_TEXTURE2D_DESC1*</b> A pointer to a D3D11_TEXTURE2D_DESC1 structure that describes a 2D
    ///             texture resource. To create a typeless resource that can be interpreted at runtime into different, compatible
    ///             formats, specify a typeless format in the texture description. To generate mipmap levels automatically, set
    ///             the number of mipmap levels to 0.
    ///    pInitialData = Type: <b>const D3D11_SUBRESOURCE_DATA*</b> A pointer to an array of D3D11_SUBRESOURCE_DATA structures that
    ///                   describe subresources for the 2D texture resource. Applications can't specify <b>NULL</b> for
    ///                   <i>pInitialData</i> when creating IMMUTABLE resources (see D3D11_USAGE). If the resource is multisampled,
    ///                   <i>pInitialData</i> must be <b>NULL</b> because multisampled resources can't be initialized with data when
    ///                   they're created. If you don't pass anything to <i>pInitialData</i>, the initial content of the memory for the
    ///                   resource is undefined. In this case, you need to write the resource content some other way before the
    ///                   resource is read. You can determine the size of this array from values in the <b>MipLevels</b> and
    ///                   <b>ArraySize</b> members of the <b>D3D11_TEXTURE2D_DESC1</b> structure to which <i>pDesc1</i> points by using
    ///                   the following calculation: MipLevels * ArraySize For more info about this array size, see Remarks.
    ///    ppTexture2D = Type: <b>ID3D11Texture2D1**</b> A pointer to a memory block that receives a pointer to a ID3D11Texture2D1
    ///                  interface for the created texture. Set this parameter to <b>NULL</b> to validate the other input parameters
    ///                  (the method will return <b>S_FALSE</b> if the other input parameters pass validation).
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return code is <b>S_OK</b>. See Direct3D 11 Return Codes for
    ///    failing error codes.
    ///    
    HRESULT CreateTexture2D1(const(D3D11_TEXTURE2D_DESC1)* pDesc1, const(D3D11_SUBRESOURCE_DATA)* pInitialData, 
                             ID3D11Texture2D1* ppTexture2D);
    ///Creates a 3D texture.
    ///Params:
    ///    pDesc1 = Type: <b>const D3D11_TEXTURE3D_DESC1*</b> A pointer to a D3D11_TEXTURE3D_DESC1 structure that describes a 3D
    ///             texture resource. To create a typeless resource that can be interpreted at runtime into different, compatible
    ///             formats, specify a typeless format in the texture description. To generate mipmap levels automatically, set
    ///             the number of mipmap levels to 0.
    ///    pInitialData = Type: <b>const D3D11_SUBRESOURCE_DATA*</b> A pointer to an array of D3D11_SUBRESOURCE_DATA structures that
    ///                   describe subresources for the 3D texture resource. Applications can't specify <b>NULL</b> for
    ///                   <i>pInitialData</i> when creating IMMUTABLE resources (see D3D11_USAGE). If the resource is multisampled,
    ///                   <i>pInitialData</i> must be <b>NULL</b> because multisampled resources can't be initialized with data when
    ///                   they are created. If you don't pass anything to <i>pInitialData</i>, the initial content of the memory for
    ///                   the resource is undefined. In this case, you need to write the resource content some other way before the
    ///                   resource is read. You can determine the size of this array from the value in the <b>MipLevels</b> member of
    ///                   the <b>D3D11_TEXTURE3D_DESC1</b> structure to which <i>pDesc1</i> points. Arrays of 3D volume textures aren't
    ///                   supported. For more information about this array size, see Remarks.
    ///    ppTexture3D = Type: <b>ID3D11Texture3D1**</b> A pointer to a memory block that receives a pointer to a ID3D11Texture3D1
    ///                  interface for the created texture. Set this parameter to <b>NULL</b> to validate the other input parameters
    ///                  (the method will return <b>S_FALSE</b> if the other input parameters pass validation).
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return code is <b>S_OK</b>. See Direct3D 11 Return Codes for
    ///    failing error codes.
    ///    
    HRESULT CreateTexture3D1(const(D3D11_TEXTURE3D_DESC1)* pDesc1, const(D3D11_SUBRESOURCE_DATA)* pInitialData, 
                             ID3D11Texture3D1* ppTexture3D);
    ///Creates a rasterizer state object that informs the rasterizer stage how to behave and forces the sample count
    ///while UAV rendering or rasterizing.
    ///Params:
    ///    pRasterizerDesc = Type: <b>const D3D11_RASTERIZER_DESC2*</b> A pointer to a D3D11_RASTERIZER_DESC2 structure that describes the
    ///                      rasterizer state.
    ///    ppRasterizerState = Type: <b>ID3D11RasterizerState2**</b> A pointer to a memory block that receives a pointer to a
    ///                        ID3D11RasterizerState2 interface for the created rasterizer state object. Set this parameter to <b>NULL</b>
    ///                        to validate the other input parameters (the method will return <b>S_FALSE</b> if the other input parameters
    ///                        pass validation).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns E_OUTOFMEMORY if there is insufficient memory to create the
    ///    rasterizer state object. See Direct3D 11 Return Codes for other possible return values.
    ///    
    HRESULT CreateRasterizerState2(const(D3D11_RASTERIZER_DESC2)* pRasterizerDesc, 
                                   ID3D11RasterizerState2* ppRasterizerState);
    ///Creates a shader-resource view for accessing data in a resource.
    ///Params:
    ///    pResource = Type: <b>ID3D11Resource*</b> Pointer to the resource that will serve as input to a shader. This resource must
    ///                have been created with the D3D11_BIND_SHADER_RESOURCE flag.
    ///    pDesc1 = Type: <b>const D3D11_SHADER_RESOURCE_VIEW_DESC1*</b> A pointer to a D3D11_SHADER_RESOURCE_VIEW_DESC1
    ///             structure that describes a shader-resource view. Set this parameter to <b>NULL</b> to create a view that
    ///             accesses the entire resource (using the format the resource was created with).
    ///    ppSRView1 = Type: <b>ID3D11ShaderResourceView1**</b> A pointer to a memory block that receives a pointer to a
    ///                ID3D11ShaderResourceView1 interface for the created shader-resource view. Set this parameter to <b>NULL</b>
    ///                to validate the other input parameters (the method will return <b>S_FALSE</b> if the other input parameters
    ///                pass validation).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns E_OUTOFMEMORY if there is insufficient memory to create the
    ///    shader-resource view. See Direct3D 11 Return Codes for other possible return values.
    ///    
    HRESULT CreateShaderResourceView1(ID3D11Resource pResource, const(D3D11_SHADER_RESOURCE_VIEW_DESC1)* pDesc1, 
                                      ID3D11ShaderResourceView1* ppSRView1);
    ///Creates a view for accessing an unordered access resource.
    ///Params:
    ///    pResource = Type: <b>ID3D11Resource*</b> Pointer to an ID3D11Resource that represents a resources that will serve as an
    ///                input to a shader.
    ///    pDesc1 = Type: <b>const D3D11_UNORDERED_ACCESS_VIEW_DESC1*</b> Pointer to a D3D11_UNORDERED_ACCESS_VIEW_DESC1
    ///             structure that represents an unordered-access view description. Set this parameter to <b>NULL</b> to create a
    ///             view that accesses the entire resource (using the format the resource was created with).
    ///    ppUAView1 = Type: <b>ID3D11UnorderedAccessView1**</b> A pointer to a memory block that receives a pointer to a
    ///                ID3D11UnorderedAccessView1 interface for the created unordered-access view. Set this parameter to <b>NULL</b>
    ///                to validate the other input parameters (the method will return <b>S_FALSE</b> if the other input parameters
    ///                pass validation).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns E_OUTOFMEMORY if there is insufficient memory to create the
    ///    unordered-access view. See Direct3D 11 Return Codes for other possible return values.
    ///    
    HRESULT CreateUnorderedAccessView1(ID3D11Resource pResource, const(D3D11_UNORDERED_ACCESS_VIEW_DESC1)* pDesc1, 
                                       ID3D11UnorderedAccessView1* ppUAView1);
    ///Creates a render-target view for accessing resource data.
    ///Params:
    ///    pResource = Type: <b>ID3D11Resource*</b> Pointer to a ID3D11Resource that represents a render target. This resource must
    ///                have been created with the D3D11_BIND_RENDER_TARGET flag.
    ///    pDesc1 = Type: <b>const D3D11_RENDER_TARGET_VIEW_DESC1*</b> Pointer to a D3D11_RENDER_TARGET_VIEW_DESC1 that
    ///             represents a render-target view description. Set this parameter to <b>NULL</b> to create a view that accesses
    ///             all of the subresources in mipmap level 0.
    ///    ppRTView1 = Type: <b>ID3D11RenderTargetView1**</b> A pointer to a memory block that receives a pointer to a
    ///                ID3D11RenderTargetView1 interface for the created render-target view. Set this parameter to <b>NULL</b> to
    ///                validate the other input parameters (the method will return <b>S_FALSE</b> if the other input parameters pass
    ///                validation).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT CreateRenderTargetView1(ID3D11Resource pResource, const(D3D11_RENDER_TARGET_VIEW_DESC1)* pDesc1, 
                                    ID3D11RenderTargetView1* ppRTView1);
    ///Creates a query object for querying information from the graphics processing unit (GPU).
    ///Params:
    ///    pQueryDesc1 = Type: <b>const D3D11_QUERY_DESC1*</b> Pointer to a D3D11_QUERY_DESC1 structure that represents a query
    ///                  description.
    ///    ppQuery1 = Type: <b>ID3D11Query1**</b> A pointer to a memory block that receives a pointer to a ID3D11Query1 interface
    ///               for the created query object. Set this parameter to <b>NULL</b> to validate the other input parameters (the
    ///               method will return <b>S_FALSE</b> if the other input parameters pass validation).
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns E_OUTOFMEMORY if there is insufficient memory to create the query
    ///    object. See Direct3D 11 Return Codes for other possible return values.
    ///    
    HRESULT CreateQuery1(const(D3D11_QUERY_DESC1)* pQueryDesc1, ID3D11Query1* ppQuery1);
    ///Gets an immediate context, which can play back command lists.
    ///Params:
    ///    ppImmediateContext = Type: <b>ID3D11DeviceContext3**</b> Upon completion of the method, the passed pointer to an
    ///                         ID3D11DeviceContext3 interface pointer is initialized.
    void    GetImmediateContext3(ID3D11DeviceContext3* ppImmediateContext);
    ///Creates a deferred context, which can record command lists.
    ///Params:
    ///    ContextFlags = Type: <b>UINT</b> Reserved for future use. Pass 0.
    ///    ppDeferredContext = Type: <b>ID3D11DeviceContext3**</b> Upon completion of the method, the passed pointer to an
    ///                        ID3D11DeviceContext3 interface pointer is initialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the following: <ul> <li>Returns
    ///    <b>DXGI_ERROR_DEVICE_REMOVED</b> if the video card has been physically removed from the system, or a driver
    ///    upgrade for the video card has occurred. If this error occurs, you should destroy and recreate the device.
    ///    </li> <li>Returns <b>DXGI_ERROR_INVALID_CALL</b> if the <b>CreateDeferredContext3</b>method can't be called
    ///    from the current context. For example, if the device was created with the D3D11_CREATE_DEVICE_SINGLETHREADED
    ///    value, <b>CreateDeferredContext3</b> returns <b>DXGI_ERROR_INVALID_CALL</b>. </li> <li>Returns
    ///    <b>E_INVALIDARG</b> if the <i>ContextFlags</i> parameter is invalid. </li> <li>Returns <b>E_OUTOFMEMORY</b>
    ///    if the app has exhausted available memory. </li> </ul>
    ///    
    HRESULT CreateDeferredContext3(uint ContextFlags, ID3D11DeviceContext3* ppDeferredContext);
    ///Copies data into a D3D11_USAGE_DEFAULTtexture which was mapped using ID3D11DeviceContext3::Mapwhile providing a
    ///NULL D3D11_MAPPED_SUBRESOURCEparameter.
    ///Params:
    ///    pDstResource = Type: <b>ID3D11Resource*</b> A pointer to the destination resource (an ID3D11Resource).
    ///    DstSubresource = Type: <b>UINT</b> A zero-based index, that identifies the destination subresource. For more details, see
    ///                     D3D11CalcSubresource.
    ///    pDstBox = Type: <b>const D3D11_BOX*</b> A pointer to a box that defines the portion of the destination subresource to
    ///              copy the resource data into. If NULL, the data is written to the destination subresource with no offset. The
    ///              dimensions of the source must fit the destination (see D3D11_BOX). An empty box results in a no-op. A box is
    ///              empty if the top value is greater than or equal to the bottom value, or the left value is greater than or
    ///              equal to the right value, or the front value is greater than or equal to the back value. When the box is
    ///              empty, this method doesn't perform any operation.
    ///    pSrcData = Type: <b>const void*</b> A pointer to the source data in memory.
    ///    SrcRowPitch = Type: <b>UINT</b> The size of one row of the source data.
    ///    SrcDepthPitch = Type: <b>UINT</b> The size of one depth slice of source data.
    void    WriteToSubresource(ID3D11Resource pDstResource, uint DstSubresource, const(D3D11_BOX)* pDstBox, 
                               const(void)* pSrcData, uint SrcRowPitch, uint SrcDepthPitch);
    ///Copies data from a D3D11_USAGE_DEFAULTtexture which was mapped using ID3D11DeviceContext3::Mapwhile providing a
    ///NULL D3D11_MAPPED_SUBRESOURCEparameter.
    ///Params:
    ///    pDstData = Type: <b>void*</b> A pointer to the destination data in memory.
    ///    DstRowPitch = Type: <b>UINT</b> The size of one row of the destination data.
    ///    DstDepthPitch = Type: <b>UINT</b> The size of one depth slice of destination data.
    ///    pSrcResource = Type: <b>ID3D11Resource*</b> A pointer to the source resource (see ID3D11Resource).
    ///    SrcSubresource = Type: <b>UINT</b> A zero-based index, that identifies the destination subresource. For more details, see
    ///                     D3D11CalcSubresource.
    ///    pSrcBox = Type: <b>const D3D11_BOX*</b> A pointer to a box that defines the portion of the destination subresource to
    ///              copy the resource data from. If NULL, the data is read from the destination subresource with no offset. The
    ///              dimensions of the destination must fit the destination (see D3D11_BOX). An empty box results in a no-op. A
    ///              box is empty if the top value is greater than or equal to the bottom value, or the left value is greater than
    ///              or equal to the right value, or the front value is greater than or equal to the back value. When the box is
    ///              empty, this method doesn't perform any operation.
    void    ReadFromSubresource(void* pDstData, uint DstRowPitch, uint DstDepthPitch, ID3D11Resource pSrcResource, 
                                uint SrcSubresource, const(D3D11_BOX)* pSrcBox);
}

///The device interface represents a virtual adapter; it is used to create resources. <b>ID3D11Device4</b> adds new
///methods to those in ID3D11Device3, such as <b>RegisterDeviceRemovedEvent</b> and <b>UnregisterDeviceRemoved</b>.
@GUID("8992AB71-02E6-4B8D-BA48-B056DCDA42C4")
interface ID3D11Device4 : ID3D11Device3
{
    ///Registers the "device removed" event and indicates when a Direct3D device has become removed for any reason,
    ///using an asynchronous notification mechanism.
    ///Params:
    ///    hEvent = Type: <b>HANDLE</b> The handle to the "device removed" event.
    ///    pdwCookie = Type: <b>DWORD*</b> A pointer to information about the "device removed" event, which can be used in
    ///                UnregisterDeviceRemoved to unregister the event.
    ///Returns:
    ///    Type: <b>HRESULT</b> See Direct3D 11 Return Codes.
    ///    
    HRESULT RegisterDeviceRemovedEvent(HANDLE hEvent, uint* pdwCookie);
    ///Unregisters the "device removed" event.
    ///Params:
    ///    dwCookie = Type: <b>DWORD</b> Information about the "device removed" event, retrieved during a successful
    ///               RegisterDeviceRemovedEvent call.
    void    UnregisterDeviceRemoved(uint dwCookie);
}

///The device interface represents a virtual adapter; it is used to create resources. <b>ID3D11Device5</b> adds new
///methods to those in ID3D11Device4. <div class="alert"><b>Note</b> This interface, introduced in the Windows 10
///Creators Update, is the latest version of the ID3D11Device interface. Applications targetting Windows 10 Creators
///Update should use this interface instead of earlier versions.</div><div> </div>
@GUID("8FFDE202-A0E7-45DF-9E01-E837801B5EA0")
interface ID3D11Device5 : ID3D11Device4
{
    ///Opens a handle for a shared fence by using HANDLE and REFIID. This member function is a limited version of the
    ///Direct3D 12 ID3D12Device::OpenSharedHandle member function, and applies between Direct3D 11 and Direct3D 12 in
    ///interop scenarios. Unlike <b>ID3D12Device::OpenSharedHandle</b> which operates on resources, heaps, and fences,
    ///the <b>ID3D11Device5::OpenSharedFence</b> function only operates on fences; in Direct3D 11, shared resources are
    ///opened with the [ID3D11Device::OpenSharedResource1](../d3d11_1/nf-d3d11_1-id3d11device1-opensharedresource1.md)
    ///member function.
    ///Params:
    ///    hFence = Type: <b>HANDLE</b> The handle that was returned by a call to ID3D11Fence::CreateSharedHandle or
    ///             ID3D12Device::CreateSharedHandle.
    ///    ReturnedInterface = Type: <b>REFIID</b> The globally unique identifier (<b>GUID</b>) for the ID3D11Fence interface. The
    ///                        <b>REFIID</b>, or <b>GUID</b>, of the interface can be obtained by using the __uuidof() macro. For example,
    ///                        __uuidof(ID3D11Fence) will get the <b>GUID</b> of the interface to the fence.
    ///    ppFence = Type: <b>void**</b> A pointer to a memory block that receives a pointer to the ID3D11Fence interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT OpenSharedFence(HANDLE hFence, const(GUID)* ReturnedInterface, void** ppFence);
    ///Creates a fence object. This member function is equivalent to the Direct3D 12 ID3D12Device::CreateFence member
    ///function, and applies between Direct3D 11 and Direct3D 12 in interop scenarios.
    ///Params:
    ///    InitialValue = Type: <b>UINT64</b> The initial value for the fence.
    ///    Flags = Type: <b>D3D11_FENCE_FLAG</b> A combination of D3D11_FENCE_FLAG-typed values that are combined by using a
    ///            bitwise OR operation. The resulting value specifies options for the fence.
    ///    ReturnedInterface = Type: <b>REFIID</b> The globally unique identifier (<b>GUID</b>) for the fence interface (ID3D11Fence). The
    ///                        <b>REFIID</b>, or <b>GUID</b>, of the interface to the fence can be obtained by using the __uuidof() macro.
    ///                        For example, __uuidof(ID3D11Fence) will get the <b>GUID</b> of the interface to a fence.
    ///    ppFence = Type: <b>void**</b> A pointer to a memory block that receives a pointer to the ID3D11Fence interface that is
    ///              used to access the fence.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns <b>S_OK</b> if successful; otherwise, returns one of the Direct3D 11 Return
    ///    Codes.
    ///    
    HRESULT CreateFence(ulong InitialValue, D3D11_FENCE_FLAG Flags, const(GUID)* ReturnedInterface, void** ppFence);
}

///Provides threading protection for critical sections of a multi-threaded application.
@GUID("9B7E4E00-342C-4106-A19F-4F2704F689F0")
interface ID3D11Multithread : IUnknown
{
    ///Enter a device's critical section.
    void Enter();
    ///Leave a device's critical section.
    void Leave();
    ///Turns multithread protection on or off.
    ///Params:
    ///    bMTProtect = Type: <b>BOOL</b> Set to true to turn multithread protection on, false to turn it off.
    ///Returns:
    ///    Type: <b>BOOL</b> True if multithread protection was already turned on prior to calling this method, false
    ///    otherwise.
    ///    
    BOOL SetMultithreadProtected(BOOL bMTProtect);
    ///Find out if multithread protection is turned on or not.
    ///Returns:
    ///    Type: <b>BOOL</b> Returns true if multithread protection is turned on, false otherwise.
    ///    
    BOOL GetMultithreadProtected();
}

///Provides the video decoding and video processing capabilities of a Microsoft Direct3D 11 device. Adds the
///[CheckFeatureSupport](nf-d3d11_4-id3d11videodevice2-checkfeaturesupport.md) method for querying for decoding
///capabilities.
@GUID("59C0CB01-35F0-4A70-8F67-87905C906A53")
interface ID3D11VideoDevice2 : ID3D11VideoDevice1
{
    ///Gets information about the features that are supported by the current video driver.
    ///Params:
    ///    Feature = A member of the [D3D11_FEATURE_VIDEO](ne-d3d11_4-d3d11_feature_video.md) enumeration that specifies the
    ///              feature to query for support.
    ///    pFeatureSupportData = A structure that contains data that describes the configuration details of the feature for which support is
    ///                          requested and, upon the completion of the call, is populated with details about the level of support
    ///                          available. For information on the structure that is associated with each type of feature support request, see
    ///                          the field descriptions for [D3D11_FEATURE_VIDEO](ne-d3d11_4-d3d11_feature_video.md).
    ///    FeatureSupportDataSize = The size of the structure passed to the *pFeatureSupportData* parameter.
    ///Returns:
    ///    Returns **S_OK** if successful; otherwise, returns **E_INVALIDARG** if an unsupported data type is passed to
    ///    the *pFeatureSupportData* parameter or a size mismatch is detected for the *FeatureSupportDataSize*
    ///    parameter.
    ///    
    HRESULT CheckFeatureSupport(D3D11_FEATURE_VIDEO Feature, void* pFeatureSupportData, 
                                uint FeatureSupportDataSize);
    HRESULT NegotiateCryptoSessionKeyExchangeMT(ID3D11CryptoSession pCryptoSession, 
                                                D3D11_CRYPTO_SESSION_KEY_EXCHANGE_FLAGS flags, uint DataSize, 
                                                void* pData);
}

///Provides the video functionality of a Microsoft Direct3D 11 device. This interface provides the
///[DecoderBeginFrame1](nf-d3d11_4-id3d11videocontext3-decoderbeginframe1.md) method, which provides support for decode
///histograms.
@GUID("A9E2FAA0-CB39-418F-A0B7-D8AAD4DE672E")
interface ID3D11VideoContext3 : ID3D11VideoContext2
{
    ///Starts a decoding operation to decode a video frame.
    ///Params:
    ///    pDecoder = A pointer to the [ID3D11VideoDecoder](../d3d11/nn-d3d11-id3d11videodecoder.md) interface. To get this
    ///               pointer, call
    ///               [ID3D11VideoDevice::CreateVideoDecoder](../d3d11/nf-d3d11-id3d11videodevice-createvideodecoder.md)
    ///    pView = A pointer to a [ID3D11VideoDecoderOutputView](../d3d11/nn-d3d11-id3d11videodecoderoutputview.md) interface.
    ///            This interface describes the resource that will receive the decoded frame. To get this pointer, call
    ///            [ID3D11VideoDevice::CreateVideoDecoderOutputView](../d3d11/nf-d3d11-id3d11videodevice-createvideodecoderoutputview.md
    ///            ).
    ///    ContentKeySize = The size of the content key that is specified in *pContentKey*. If *pContentKey* is NULL, set
    ///                     *ContentKeySize* to zero.
    ///    pContentKey = An optional pointer to a content key that was used to encrypt the frame data. If no content key was used, set
    ///                  this parameter to NULL. If the caller provides a content key, the caller must use the session key to encrypt
    ///                  the content key.
    ///    NumComponentHistograms = The number of components to record a histograms for. Use
    ///                             [D3D11_FEATURE_VIDEO_DECODE_HISTOGRAM](ne-d3d11_4-d3d11_feature_video.md) to check for support. Use zero when
    ///                             not recording histograms or when the feature is not supported. Specifying fewer components than are in the
    ///                             format implies that those components do not have histogram recording enabled. The maximum number of
    ///                             components is defined as **D3D11_4_VIDEO_DECODER_MAX_HISTOGRAM_COMPONENTS**.
    ///    pHistogramOffsets = An array of starting buffer offset locations within the *ppHistogramBuffers* parallel array. Use
    ///                        [D3D11_VIDEO_DECODE_HISTOGRAM_COMPONENT](ne-d3d11_4-d3d11_video_decoder_histogram_component.md) to index the
    ///                        array. If a component is not requested, specify an offset of zero. The offsets must be 256-byte aligned.
    ///    ppHistogramBuffers = An array of target buffers for hardware to write the components histogram. Use
    ///                         [D3D11_VIDEO_DECODE_HISTOGRAM_COMPONENT](ne-d3d11_4-d3d11_video_decoder_histogram_component.md) to index the
    ///                         array. Set this parameter to **nullptr** when the component histogram is disabled or unsupported
    ///Returns:
    ///    Returns **S\_OK** if successful.
    ///    
    HRESULT DecoderBeginFrame1(ID3D11VideoDecoder pDecoder, ID3D11VideoDecoderOutputView pView, 
                               uint ContentKeySize, const(void)* pContentKey, uint NumComponentHistograms, 
                               const(uint)* pHistogramOffsets, ID3D11Buffer* ppHistogramBuffers);
    HRESULT SubmitDecoderBuffers2(ID3D11VideoDecoder pDecoder, uint NumBuffers, 
                                  const(D3D11_VIDEO_DECODER_BUFFER_DESC2)* pBufferDesc);
}

///This shader-reflection interface provides access to variable type.
@GUID("6E6FFA6A-9BAE-4613-A51E-91652D508C21")
interface ID3D11ShaderReflectionType
{
    ///Get the description of a shader-reflection-variable type.
    ///Params:
    ///    pDesc = Type: <b>D3D11_SHADER_TYPE_DESC*</b> A pointer to a shader-type description (see D3D11_SHADER_TYPE_DESC).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT GetDesc(D3D11_SHADER_TYPE_DESC* pDesc);
    ///Get a shader-reflection-variable type by index.
    ///Params:
    ///    Index = Type: <b>UINT</b> Zero-based index.
    ///Returns:
    ///    Type: <b>ID3D11ShaderReflectionType*</b> A pointer to a ID3D11ShaderReflectionType Interface.
    ///    
    ID3D11ShaderReflectionType GetMemberTypeByIndex(uint Index);
    ///Get a shader-reflection-variable type by name.
    ///Params:
    ///    Name = Type: <b>LPCSTR</b> Member name.
    ///Returns:
    ///    Type: <b>ID3D11ShaderReflectionType*</b> A pointer to a ID3D11ShaderReflectionType Interface.
    ///    
    ID3D11ShaderReflectionType GetMemberTypeByName(const(PSTR) Name);
    ///Get a shader-reflection-variable type.
    ///Params:
    ///    Index = Type: <b>UINT</b> Zero-based index.
    ///Returns:
    ///    Type: <b>LPCSTR</b> The variable type.
    ///    
    PSTR    GetMemberTypeName(uint Index);
    ///Indicates whether two ID3D11ShaderReflectionType Interface pointers have the same underlying type.
    ///Params:
    ///    pType = Type: <b>ID3D11ShaderReflectionType*</b> A pointer to a ID3D11ShaderReflectionType Interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if the pointers have the same underlying type; otherwise returns S_FALSE.
    ///    
    HRESULT IsEqual(ID3D11ShaderReflectionType pType);
    ///Gets the base class of a class.
    ///Returns:
    ///    Type: <b>ID3D11ShaderReflectionType*</b> Returns a pointer to a ID3D11ShaderReflectionType Interface
    ///    containing the base class type. Returns <b>NULL</b> if the class does not have a base class.
    ///    
    ID3D11ShaderReflectionType GetSubType();
    ///Gets an ID3D11ShaderReflectionType Interface interface containing the variable base class type.
    ///Returns:
    ///    Type: <b>ID3D11ShaderReflectionType*</b> Returns A pointer to a ID3D11ShaderReflectionType Interface.
    ///    
    ID3D11ShaderReflectionType GetBaseClass();
    ///Gets the number of interfaces.
    ///Returns:
    ///    Type: <b>UINT</b> Returns the number of interfaces.
    ///    
    uint    GetNumInterfaces();
    ///Get an interface by index.
    ///Params:
    ///    uIndex = Type: <b>UINT</b> Zero-based index.
    ///Returns:
    ///    Type: <b>ID3D11ShaderReflectionType*</b> A pointer to a ID3D11ShaderReflectionType Interface.
    ///    
    ID3D11ShaderReflectionType GetInterfaceByIndex(uint uIndex);
    ///Indicates whether a variable is of the specified type.
    ///Params:
    ///    pType = Type: <b>ID3D11ShaderReflectionType*</b> A pointer to a ID3D11ShaderReflectionType Interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if object being queried is equal to or inherits from the type in the
    ///    <i>pType</i> parameter; otherwise returns S_FALSE.
    ///    
    HRESULT IsOfType(ID3D11ShaderReflectionType pType);
    ///Indicates whether a class type implements an interface.
    ///Params:
    ///    pBase = Type: <b>ID3D11ShaderReflectionType*</b> A pointer to a ID3D11ShaderReflectionType Interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if the interface is implemented; otherwise return S_FALSE.
    ///    
    HRESULT ImplementsInterface(ID3D11ShaderReflectionType pBase);
}

///This shader-reflection interface provides access to a variable.
@GUID("51F23923-F3E5-4BD1-91CB-606177D8DB4C")
interface ID3D11ShaderReflectionVariable
{
    ///Get a shader-variable description.
    ///Params:
    ///    pDesc = Type: <b>D3D11_SHADER_VARIABLE_DESC*</b> A pointer to a shader-variable description (see
    ///            D3D11_SHADER_VARIABLE_DESC).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT GetDesc(D3D11_SHADER_VARIABLE_DESC* pDesc);
    ///Get a shader-variable type.
    ///Returns:
    ///    Type: <b>ID3D11ShaderReflectionType*</b> A pointer to a ID3D11ShaderReflectionType Interface.
    ///    
    ID3D11ShaderReflectionType GetType();
    ///This method returns the buffer of the current ID3D11ShaderReflectionVariable.
    ///Returns:
    ///    Type: <b>ID3D11ShaderReflectionConstantBuffer*</b> Returns a pointer to the
    ///    ID3D11ShaderReflectionConstantBuffer of the present ID3D11ShaderReflectionVariable.
    ///    
    ID3D11ShaderReflectionConstantBuffer GetBuffer();
    ///Gets the corresponding interface slot for a variable that represents an interface pointer.
    ///Params:
    ///    uArrayIndex = Type: <b>UINT</b> Index of the array element to get the slot number for. For a non-array variable this value
    ///                  will be zero.
    ///Returns:
    ///    Type: <b>UINT</b> Returns the index of the interface in the interface array.
    ///    
    uint    GetInterfaceSlot(uint uArrayIndex);
}

///This shader-reflection interface provides access to a constant buffer.
@GUID("EB62D63D-93DD-4318-8AE8-C6F83AD371B8")
interface ID3D11ShaderReflectionConstantBuffer
{
    ///Get a constant-buffer description.
    ///Params:
    ///    pDesc = Type: <b>D3D11_SHADER_BUFFER_DESC*</b> A pointer to a D3D11_SHADER_BUFFER_DESC, which represents a
    ///            shader-buffer description.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT GetDesc(D3D11_SHADER_BUFFER_DESC* pDesc);
    ///Get a shader-reflection variable by index.
    ///Params:
    ///    Index = Type: <b>UINT</b> Zero-based index.
    ///Returns:
    ///    Type: <b>ID3D11ShaderReflectionVariable*</b> A pointer to a shader-reflection variable interface (see
    ///    ID3D11ShaderReflectionVariable Interface).
    ///    
    ID3D11ShaderReflectionVariable GetVariableByIndex(uint Index);
    ///Get a shader-reflection variable by name.
    ///Params:
    ///    Name = Type: <b>LPCSTR</b> Variable name.
    ///Returns:
    ///    Type: <b>ID3D11ShaderReflectionVariable*</b> Returns a sentinel object (end of list marker). To determine if
    ///    GetVariableByName successfully completed, call ID3D11ShaderReflectionVariable::GetDesc and check the returned
    ///    <b>HRESULT</b>; any return value other than success means that GetVariableByName failed.
    ///    
    ID3D11ShaderReflectionVariable GetVariableByName(const(PSTR) Name);
}

///A shader-reflection interface accesses shader information.
@GUID("8D536CA1-0CCA-4956-A837-786963755584")
interface ID3D11ShaderReflection : IUnknown
{
    ///Get a shader description.
    ///Params:
    ///    pDesc = Type: <b>D3D11_SHADER_DESC*</b> A pointer to a shader description. See D3D11_SHADER_DESC.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT GetDesc(D3D11_SHADER_DESC* pDesc);
    ///Get a constant buffer by index.
    ///Params:
    ///    Index = Type: <b>UINT</b> Zero-based index.
    ///Returns:
    ///    Type: <b>ID3D11ShaderReflectionConstantBuffer*</b> A pointer to a constant buffer (see
    ///    ID3D11ShaderReflectionConstantBuffer Interface).
    ///    
    ID3D11ShaderReflectionConstantBuffer GetConstantBufferByIndex(uint Index);
    ///Get a constant buffer by name.
    ///Params:
    ///    Name = Type: <b>LPCSTR</b> The constant-buffer name.
    ///Returns:
    ///    Type: <b>ID3D11ShaderReflectionConstantBuffer*</b> A pointer to a constant buffer (see
    ///    ID3D11ShaderReflectionConstantBuffer Interface).
    ///    
    ID3D11ShaderReflectionConstantBuffer GetConstantBufferByName(const(PSTR) Name);
    ///Get a description of how a resource is bound to a shader.
    ///Params:
    ///    ResourceIndex = Type: <b>UINT</b> A zero-based resource index.
    ///    pDesc = Type: <b>D3D11_SHADER_INPUT_BIND_DESC*</b> A pointer to an input-binding description. See
    ///            D3D11_SHADER_INPUT_BIND_DESC.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT GetResourceBindingDesc(uint ResourceIndex, D3D11_SHADER_INPUT_BIND_DESC* pDesc);
    ///Get an input-parameter description for a shader.
    ///Params:
    ///    ParameterIndex = Type: <b>UINT</b> A zero-based parameter index.
    ///    pDesc = Type: <b>D3D11_SIGNATURE_PARAMETER_DESC*</b> A pointer to a shader-input-signature description. See
    ///            D3D11_SIGNATURE_PARAMETER_DESC.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT GetInputParameterDesc(uint ParameterIndex, D3D11_SIGNATURE_PARAMETER_DESC* pDesc);
    ///Get an output-parameter description for a shader.
    ///Params:
    ///    ParameterIndex = Type: <b>UINT</b> A zero-based parameter index.
    ///    pDesc = Type: <b>D3D11_SIGNATURE_PARAMETER_DESC*</b> A pointer to a shader-output-parameter description. See
    ///            D3D11_SIGNATURE_PARAMETER_DESC.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT GetOutputParameterDesc(uint ParameterIndex, D3D11_SIGNATURE_PARAMETER_DESC* pDesc);
    ///Get a patch-constant parameter description for a shader.
    ///Params:
    ///    ParameterIndex = Type: <b>UINT</b> A zero-based parameter index.
    ///    pDesc = Type: <b>D3D11_SIGNATURE_PARAMETER_DESC*</b> A pointer to a shader-input-signature description. See
    ///            D3D11_SIGNATURE_PARAMETER_DESC.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT GetPatchConstantParameterDesc(uint ParameterIndex, D3D11_SIGNATURE_PARAMETER_DESC* pDesc);
    ///Gets a variable by name.
    ///Params:
    ///    Name = Type: <b>LPCSTR</b> A pointer to a string containing the variable name.
    ///Returns:
    ///    Type: <b>ID3D11ShaderReflectionVariable*</b> Returns a ID3D11ShaderReflectionVariable Interface interface.
    ///    
    ID3D11ShaderReflectionVariable GetVariableByName(const(PSTR) Name);
    ///Get a description of how a resource is bound to a shader.
    ///Params:
    ///    Name = Type: <b>LPCSTR</b> The constant-buffer name of the resource.
    ///    pDesc = Type: <b>D3D11_SHADER_INPUT_BIND_DESC*</b> A pointer to an input-binding description. See
    ///            D3D11_SHADER_INPUT_BIND_DESC.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT GetResourceBindingDescByName(const(PSTR) Name, D3D11_SHADER_INPUT_BIND_DESC* pDesc);
    ///Gets the number of Mov instructions.
    ///Returns:
    ///    Type: <b>UINT</b> Returns the number of Mov instructions.
    ///    
    uint    GetMovInstructionCount();
    ///Gets the number of Movc instructions.
    ///Returns:
    ///    Type: <b>UINT</b> Returns the number of Movc instructions.
    ///    
    uint    GetMovcInstructionCount();
    ///Gets the number of conversion instructions.
    ///Returns:
    ///    Type: <b>UINT</b> Returns the number of conversion instructions.
    ///    
    uint    GetConversionInstructionCount();
    ///Gets the number of bitwise instructions.
    ///Returns:
    ///    Type: <b>UINT</b> The number of bitwise instructions.
    ///    
    uint    GetBitwiseInstructionCount();
    ///Gets the geometry-shader input-primitive description.
    ///Returns:
    ///    Type: <b>D3D_PRIMITIVE</b> The input-primitive description. See D3D_PRIMITIVE_TOPOLOGY,
    ///    D3D11_PRIMITIVE_TOPOLOGY, or D3D10_PRIMITIVE_TOPOLOGY.
    ///    
    D3D_PRIMITIVE GetGSInputPrimitive();
    ///Indicates whether a shader is a sample frequency shader.
    ///Returns:
    ///    Type: <b>BOOL</b> Returns true if the shader is a sample frequency shader; otherwise returns false.
    ///    
    BOOL    IsSampleFrequencyShader();
    ///Gets the number of interface slots in a shader.
    ///Returns:
    ///    Type: <b>UINT</b> The number of interface slots in the shader.
    ///    
    uint    GetNumInterfaceSlots();
    ///Gets the minimum feature level.
    ///Params:
    ///    arg1 = Type: [out] <b>D3D_FEATURE_LEVEL*</b> A pointer to one of the enumerated values in D3D_FEATURE_LEVEL, which
    ///           represents the minimum feature level.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following Direct3D 11 Return Codes.
    ///    
    HRESULT GetMinFeatureLevel(D3D_FEATURE_LEVEL* pLevel);
    ///Retrieves the sizes, in units of threads, of the X, Y, and Z dimensions of the shader's thread-group grid.
    ///Params:
    ///    pSizeX = Type: <b>UINT*</b> A pointer to the size, in threads, of the x-dimension of the thread-group grid. The
    ///             maximum size is 1024.
    ///    pSizeY = Type: <b>UINT*</b> A pointer to the size, in threads, of the y-dimension of the thread-group grid. The
    ///             maximum size is 1024.
    ///    pSizeZ = Type: <b>UINT*</b> A pointer to the size, in threads, of the z-dimension of the thread-group grid. The
    ///             maximum size is 64.
    ///Returns:
    ///    Type: <b>UINT</b> Returns the total size, in threads, of the thread-group grid by calculating the product of
    ///    the size of each dimension. <pre class="syntax" xml:space="preserve"><code>*pSizeX * *pSizeY *
    ///    *pSizeZ;</code></pre>
    ///    
    uint    GetThreadGroupSize(uint* pSizeX, uint* pSizeY, uint* pSizeZ);
    ///Gets a group of flags that indicates the requirements of a shader.
    ///Returns:
    ///    Type: <b>UINT64</b> A value that contains a combination of one or more shader requirements flags; each flag
    ///    specifies a requirement of the shader. A default value of 0 means there are no requirements. <table> <tr>
    ///    <th>Shader requirement flag</th> <th>Description</th> </tr> <tr> <td><b>D3D_SHADER_REQUIRES_DOUBLES</b></td>
    ///    <td>Shader requires that the graphics driver and hardware support double data type. For more info, see
    ///    D3D11_FEATURE_DATA_DOUBLES.</td> </tr> <tr> <td><b>D3D_SHADER_REQUIRES_EARLY_DEPTH_STENCIL</b></td>
    ///    <td>Shader requires an early depth stencil.</td> </tr> <tr>
    ///    <td><b>D3D_SHADER_REQUIRES_UAVS_AT_EVERY_STAGE</b></td> <td>Shader requires unordered access views (UAVs) at
    ///    every pipeline stage.</td> </tr> <tr> <td><b>D3D_SHADER_REQUIRES_64_UAVS</b></td> <td>Shader requires 64
    ///    UAVs.</td> </tr> <tr> <td><b>D3D_SHADER_REQUIRES_MINIMUM_PRECISION</b></td> <td>Shader requires the graphics
    ///    driver and hardware to support minimum precision. For more info, see Using HLSL minimum precision.</td> </tr>
    ///    <tr> <td><b>D3D_SHADER_REQUIRES_11_1_DOUBLE_EXTENSIONS</b></td> <td>Shader requires that the graphics driver
    ///    and hardware support extended doubles instructions. For more info, see the
    ///    <b>ExtendedDoublesShaderInstructions</b> member of D3D11_FEATURE_DATA_D3D11_OPTIONS.</td> </tr> <tr>
    ///    <td><b>D3D_SHADER_REQUIRES_11_1_SHADER_EXTENSIONS</b></td> <td>Shader requires that the graphics driver and
    ///    hardware support the msad4 intrinsic function in shaders. For more info, see the
    ///    <b>SAD4ShaderInstructions</b> member of D3D11_FEATURE_DATA_D3D11_OPTIONS.</td> </tr> <tr>
    ///    <td><b>D3D_SHADER_REQUIRES_LEVEL_9_COMPARISON_FILTERING</b></td> <td>Shader requires that the graphics driver
    ///    and hardware support Direct3D 9 shadow support. For more info, see
    ///    D3D11_FEATURE_DATA_D3D9_SHADOW_SUPPORT.</td> </tr> <tr> <td><b>D3D_SHADER_REQUIRES_TILED_RESOURCES</b></td>
    ///    <td>Shader requires that the graphics driver and hardware support tiled resources. For more info, see
    ///    GetResourceTiling. </td> </tr> </table>
    ///    
    ulong   GetRequiresFlags();
}

///A library-reflection interface accesses library info. <div class="alert"><b>Note</b> This interface is part of the
///HLSL shader linking technology that you can use on all Direct3D 11 platforms to create precompiled HLSL functions,
///package them into libraries, and link them into full shaders at run time. </div> <div> </div>
@GUID("54384F1B-5B3E-4BB7-AE01-60BA3097CBB6")
interface ID3D11LibraryReflection : IUnknown
{
    ///Fills the library descriptor structure for the library reflection.
    ///Params:
    ///    pDesc = Type: <b>D3D11_LIBRARY_DESC*</b> A pointer to a D3D11_LIBRARY_DESC structure that receives a description of
    ///            the library reflection.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT GetDesc(D3D11_LIBRARY_DESC* pDesc);
    ///Gets the function reflector.
    ///Params:
    ///    FunctionIndex = Type: <b>INT</b> The zero-based index of the function reflector to retrieve.
    ///Returns:
    ///    Type: <b>ID3D11FunctionReflection*</b> A pointer to a ID3D11FunctionReflection interface that represents the
    ///    function reflector.
    ///    
    ID3D11FunctionReflection GetFunctionByIndex(int FunctionIndex);
}

///A function-reflection interface accesses function info. <div class="alert"><b>Note</b> This interface is part of the
///HLSL shader linking technology that you can use on all Direct3D 11 platforms to create precompiled HLSL functions,
///package them into libraries, and link them into full shaders at run time. </div> <div> </div>
@GUID("207BCECB-D683-4A06-A8A3-9B149B9F73A4")
interface ID3D11FunctionReflection
{
    ///Fills the function descriptor structure for the function.
    ///Params:
    ///    pDesc = Type: <b>D3D11_FUNCTION_DESC*</b> A pointer to a D3D11_FUNCTION_DESC structure that receives a description of
    ///            the function.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT GetDesc(D3D11_FUNCTION_DESC* pDesc);
    ///Gets a constant buffer by index for a function.
    ///Params:
    ///    BufferIndex = Type: <b>UINT</b> Zero-based index.
    ///Returns:
    ///    Type: <b>ID3D11ShaderReflectionConstantBuffer*</b> A pointer to a ID3D11ShaderReflectionConstantBuffer
    ///    interface that represents the constant buffer.
    ///    
    ID3D11ShaderReflectionConstantBuffer GetConstantBufferByIndex(uint BufferIndex);
    ///Gets a constant buffer by name for a function.
    ///Params:
    ///    Name = Type: <b>LPCSTR</b> The constant-buffer name.
    ///Returns:
    ///    Type: <b>ID3D11ShaderReflectionConstantBuffer*</b> A pointer to a ID3D11ShaderReflectionConstantBuffer
    ///    interface that represents the constant buffer.
    ///    
    ID3D11ShaderReflectionConstantBuffer GetConstantBufferByName(const(PSTR) Name);
    ///Gets a description of how a resource is bound to a function.
    ///Params:
    ///    ResourceIndex = Type: <b>UINT</b> A zero-based resource index.
    ///    pDesc = Type: <b>D3D11_SHADER_INPUT_BIND_DESC*</b> A pointer to a D3D11_SHADER_INPUT_BIND_DESC structure that
    ///            describes input binding of the resource.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT GetResourceBindingDesc(uint ResourceIndex, D3D11_SHADER_INPUT_BIND_DESC* pDesc);
    ///Gets a variable by name.
    ///Params:
    ///    Name = Type: <b>LPCSTR</b> A pointer to a string containing the variable name.
    ///Returns:
    ///    Type: <b>ID3D11ShaderReflectionVariable*</b> Returns a ID3D11ShaderReflectionVariable Interface interface.
    ///    
    ID3D11ShaderReflectionVariable GetVariableByName(const(PSTR) Name);
    ///Gets a description of how a resource is bound to a function.
    ///Params:
    ///    Name = Type: <b>LPCSTR</b> The constant-buffer name of the resource.
    ///    pDesc = Type: <b>D3D11_SHADER_INPUT_BIND_DESC*</b> A pointer to a D3D11_SHADER_INPUT_BIND_DESC structure that
    ///            describes input binding of the resource.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT GetResourceBindingDescByName(const(PSTR) Name, D3D11_SHADER_INPUT_BIND_DESC* pDesc);
    ///Gets the function parameter reflector.
    ///Params:
    ///    ParameterIndex = Type: <b>INT</b> The zero-based index of the function parameter reflector to retrieve.
    ///Returns:
    ///    Type: <b>ID3D11FunctionParameterReflection*</b> A pointer to a ID3D11FunctionParameterReflection interface
    ///    that represents the function parameter reflector.
    ///    
    ID3D11FunctionParameterReflection GetFunctionParameter(int ParameterIndex);
}

///A function-parameter-reflection interface accesses function-parameter info. <div class="alert"><b>Note</b> This
///interface is part of the HLSL shader linking technology that you can use on all Direct3D 11 platforms to create
///precompiled HLSL functions, package them into libraries, and link them into full shaders at run time. </div> <div>
///</div>
@GUID("42757488-334F-47FE-982E-1A65D08CC462")
interface ID3D11FunctionParameterReflection
{
    ///Fills the parameter descriptor structure for the function's parameter.
    ///Params:
    ///    pDesc = Type: <b>D3D11_PARAMETER_DESC*</b> A pointer to a D3D11_PARAMETER_DESC structure that receives a description
    ///            of the function's parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT GetDesc(D3D11_PARAMETER_DESC* pDesc);
}

///A module interface creates an instance of a module that is used for resource rebinding. <div
///class="alert"><b>Note</b> This interface is part of the HLSL shader linking technology that you can use on all
///Direct3D 11 platforms to create precompiled HLSL functions, package them into libraries, and link them into full
///shaders at run time. </div> <div> </div>
@GUID("CAC701EE-80FC-4122-8242-10B39C8CEC34")
interface ID3D11Module : IUnknown
{
    ///Initializes an instance of a shader module that is used for resource rebinding.
    ///Params:
    ///    pNamespace = Type: <b>LPCSTR</b> The name of a shader module to initialize. This can be <b>NULL</b> if you don't want to
    ///                 specify a name for the module.
    ///    ppModuleInstance = Type: <b>ID3D11ModuleInstance**</b> The address of a pointer to an ID3D11ModuleInstance interface to
    ///                       initialize.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT CreateInstance(const(PSTR) pNamespace, ID3D11ModuleInstance* ppModuleInstance);
}

///A module-instance interface is used for resource rebinding. <div class="alert"><b>Note</b> This interface is part of
///the HLSL shader linking technology that you can use on all Direct3D 11 platforms to create precompiled HLSL
///functions, package them into libraries, and link them into full shaders at run time. </div> <div> </div>
@GUID("469E07F7-045A-48D5-AA12-68A478CDF75D")
interface ID3D11ModuleInstance : IUnknown
{
    ///Rebinds a constant buffer from a source slot to a destination slot.
    ///Params:
    ///    uSrcSlot = Type: <b>UINT</b> The source slot number for rebinding.
    ///    uDstSlot = Type: <b>UINT</b> The destination slot number for rebinding.
    ///    cbDstOffset = Type: <b>UINT</b> The offset in bytes of the destination slot for rebinding. The offset must have 16-byte
    ///                  alignment.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns: <ul> <li><b>S_OK</b> for a valid rebinding </li> <li><b>S_FALSE</b> for
    ///    rebinding a nonexistent slot; that is, for which the shader reflection doesn’t have any data </li>
    ///    <li><b>E_FAIL</b> for an invalid rebinding, for example, the rebinding is out-of-bounds </li> <li>Possibly
    ///    one of the other Direct3D 11 Return Codes </li> </ul>
    ///    
    HRESULT BindConstantBuffer(uint uSrcSlot, uint uDstSlot, uint cbDstOffset);
    ///Rebinds a constant buffer by name to a destination slot.
    ///Params:
    ///    pName = Type: <b>LPCSTR</b> The name of the constant buffer for rebinding.
    ///    uDstSlot = Type: <b>UINT</b> The destination slot number for rebinding.
    ///    cbDstOffset = Type: <b>UINT</b> The offset in bytes of the destination slot for rebinding. The offset must have 16-byte
    ///                  alignment.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns: <ul> <li><b>S_OK</b> for a valid rebinding </li> <li><b>S_FALSE</b> for
    ///    rebinding a nonexistent slot; that is, for which the shader reflection doesn’t have any data </li>
    ///    <li><b>E_FAIL</b> for an invalid rebinding, for example, the rebinding is out-of-bounds </li> <li>Possibly
    ///    one of the other Direct3D 11 Return Codes </li> </ul>
    ///    
    HRESULT BindConstantBufferByName(const(PSTR) pName, uint uDstSlot, uint cbDstOffset);
    ///Rebinds a texture or buffer from source slot to destination slot.
    ///Params:
    ///    uSrcSlot = Type: <b>UINT</b> The first source slot number for rebinding.
    ///    uDstSlot = Type: <b>UINT</b> The first destination slot number for rebinding.
    ///    uCount = Type: <b>UINT</b> The number of slots for rebinding.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns: <ul> <li><b>S_OK</b> for a valid rebinding</li> <li><b>S_FALSE</b> for
    ///    rebinding a nonexistent slot; that is, for which the shader reflection doesn’t have any data</li>
    ///    <li><b>E_FAIL</b> for an invalid rebinding, for example, the rebinding is out-of-bounds</li> <li>Possibly one
    ///    of the other Direct3D 11 Return Codes </li> </ul>
    ///    
    HRESULT BindResource(uint uSrcSlot, uint uDstSlot, uint uCount);
    ///Rebinds a texture or buffer by name to destination slots.
    ///Params:
    ///    pName = Type: <b>LPCSTR</b> The name of the texture or buffer for rebinding.
    ///    uDstSlot = Type: <b>UINT</b> The first destination slot number for rebinding.
    ///    uCount = Type: <b>UINT</b> The number of slots for rebinding.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns: <ul> <li><b>S_OK</b> for a valid rebinding</li> <li><b>S_FALSE</b> for
    ///    rebinding a nonexistent slot; that is, for which the shader reflection doesn’t have any data</li>
    ///    <li><b>E_FAIL</b> for an invalid rebinding, for example, the rebinding is out-of-bounds</li> <li>Possibly one
    ///    of the other Direct3D 11 Return Codes </li> </ul>
    ///    
    HRESULT BindResourceByName(const(PSTR) pName, uint uDstSlot, uint uCount);
    ///Rebinds a sampler from source slot to destination slot.
    ///Params:
    ///    uSrcSlot = Type: <b>UINT</b> The first source slot number for rebinding.
    ///    uDstSlot = Type: <b>UINT</b> The first destination slot number for rebinding.
    ///    uCount = Type: <b>UINT</b> The number of slots for rebinding.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns: <ul> <li><b>S_OK</b> for a valid rebinding</li> <li><b>S_FALSE</b> for
    ///    rebinding a nonexistent slot; that is, for which the shader reflection doesn’t have any data</li>
    ///    <li><b>E_FAIL</b> for an invalid rebinding, for example, the rebinding is out-of-bounds</li> <li>Possibly one
    ///    of the other Direct3D 11 Return Codes </li> </ul>
    ///    
    HRESULT BindSampler(uint uSrcSlot, uint uDstSlot, uint uCount);
    ///Rebinds a sampler by name to destination slots.
    ///Params:
    ///    pName = Type: <b>LPCSTR</b> The name of the sampler for rebinding.
    ///    uDstSlot = Type: <b>UINT</b> The first destination slot number for rebinding.
    ///    uCount = Type: <b>UINT</b> The number of slots for rebinding.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns: <ul> <li><b>S_OK</b> for a valid rebinding</li> <li><b>S_FALSE</b> for
    ///    rebinding a nonexistent slot; that is, for which the shader reflection doesn’t have any data</li>
    ///    <li><b>E_FAIL</b> for an invalid rebinding, for example, the rebinding is out-of-bounds</li> <li>Possibly one
    ///    of the other Direct3D 11 Return Codes </li> </ul>
    ///    
    HRESULT BindSamplerByName(const(PSTR) pName, uint uDstSlot, uint uCount);
    ///Rebinds an unordered access view (UAV) from source slot to destination slot.
    ///Params:
    ///    uSrcSlot = Type: <b>UINT</b> The first source slot number for rebinding.
    ///    uDstSlot = Type: <b>UINT</b> The first destination slot number for rebinding.
    ///    uCount = Type: <b>UINT</b> The number of slots for rebinding.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns: <ul> <li><b>S_OK</b> for a valid rebinding</li> <li><b>S_FALSE</b> for
    ///    rebinding a nonexistent slot; that is, for which the shader reflection doesn’t have any data</li>
    ///    <li><b>E_FAIL</b> for an invalid rebinding, for example, the rebinding is out-of-bounds</li> <li>Possibly one
    ///    of the other Direct3D 11 Return Codes </li> </ul>
    ///    
    HRESULT BindUnorderedAccessView(uint uSrcSlot, uint uDstSlot, uint uCount);
    ///Rebinds an unordered access view (UAV) by name to destination slots.
    ///Params:
    ///    pName = Type: <b>LPCSTR</b> The name of the UAV for rebinding.
    ///    uDstSlot = Type: <b>UINT</b> The first destination slot number for rebinding.
    ///    uCount = Type: <b>UINT</b> The number of slots for rebinding.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns: <ul> <li><b>S_OK</b> for a valid rebinding</li> <li><b>S_FALSE</b> for
    ///    rebinding a nonexistent slot; that is, for which the shader reflection doesn’t have any data</li>
    ///    <li><b>E_FAIL</b> for an invalid rebinding, for example, the rebinding is out-of-bounds</li> <li>Possibly one
    ///    of the other Direct3D 11 Return Codes </li> </ul>
    ///    
    HRESULT BindUnorderedAccessViewByName(const(PSTR) pName, uint uDstSlot, uint uCount);
    ///Rebinds a resource as an unordered access view (UAV) from source slot to destination slot.
    ///Params:
    ///    uSrcSrvSlot = Type: <b>UINT</b> The first source slot number for rebinding.
    ///    uDstUavSlot = Type: <b>UINT</b> The first destination slot number for rebinding.
    ///    uCount = Type: <b>UINT</b> The number of slots for rebinding.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns: <ul> <li><b>S_OK</b> for a valid rebinding</li> <li><b>S_FALSE</b> for
    ///    rebinding a nonexistent slot; that is, for which the shader reflection doesn’t have any data</li>
    ///    <li><b>E_FAIL</b> for an invalid rebinding, for example, the rebinding is out-of-bounds</li> <li>Possibly one
    ///    of the other Direct3D 11 Return Codes </li> </ul>
    ///    
    HRESULT BindResourceAsUnorderedAccessView(uint uSrcSrvSlot, uint uDstUavSlot, uint uCount);
    ///Rebinds a resource by name as an unordered access view (UAV) to destination slots.
    ///Params:
    ///    pSrvName = Type: <b>LPCSTR</b> The name of the resource for rebinding.
    ///    uDstUavSlot = Type: <b>UINT</b> The first destination slot number for rebinding.
    ///    uCount = Type: <b>UINT</b> The number of slots for rebinding.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns: <ul> <li><b>S_OK</b> for a valid rebinding</li> <li><b>S_FALSE</b> for
    ///    rebinding a nonexistent slot; that is, for which the shader reflection doesn’t have any data</li>
    ///    <li><b>E_FAIL</b> for an invalid rebinding, for example, the rebinding is out-of-bounds</li> <li>Possibly one
    ///    of the other Direct3D 11 Return Codes </li> </ul>
    ///    
    HRESULT BindResourceAsUnorderedAccessViewByName(const(PSTR) pSrvName, uint uDstUavSlot, uint uCount);
}

///A linker interface is used to link a shader module. <div class="alert"><b>Note</b> This interface is part of the HLSL
///shader linking technology that you can use on all Direct3D 11 platforms to create precompiled HLSL functions, package
///them into libraries, and link them into full shaders at run time. </div> <div> </div>
@GUID("59A6CD0E-E10D-4C1F-88C0-63ABA1DAF30E")
interface ID3D11Linker : IUnknown
{
    ///Links the shader and produces a shader blob that the Direct3D runtime can use.
    ///Params:
    ///    pEntry = Type: <b>ID3D11ModuleInstance*</b> A pointer to the ID3D11ModuleInstance interface for the shader module
    ///             instance to link from.
    ///    pEntryName = Type: <b>LPCSTR</b> The name of the shader module instance to link from.
    ///    pTargetName = Type: <b>LPCSTR</b> The name for the shader blob that is produced.
    ///    uFlags = Type: <b>UINT</b> Reserved.
    ///    ppShaderBlob = Type: <b>ID3DBlob**</b> A pointer to a variable that receives a pointer to the ID3DBlob interface that you
    ///                   can use to access the compiled shader code.
    ///    ppErrorBuffer = Type: <b>ID3DBlob**</b> A pointer to a variable that receives a pointer to the ID3DBlob interface that you
    ///                    can use to access compiler error messages.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT Link(ID3D11ModuleInstance pEntry, const(PSTR) pEntryName, const(PSTR) pTargetName, uint uFlags, 
                 ID3DBlob* ppShaderBlob, ID3DBlob* ppErrorBuffer);
    ///Adds an instance of a library module to be used for linking.
    ///Params:
    ///    pLibraryMI = Type: <b>ID3D11ModuleInstance*</b> A pointer to the ID3D11ModuleInstance interface for the library module
    ///                 instance.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT UseLibrary(ID3D11ModuleInstance pLibraryMI);
    ///Adds a clip plane with the plane coefficients taken from a cbuffer entry for 10Level9 shaders.
    ///Params:
    ///    uCBufferSlot = Type: <b>UINT</b> The cbuffer slot number.
    ///    uCBufferEntry = Type: <b>UINT</b> The cbuffer entry number.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT AddClipPlaneFromCBuffer(uint uCBufferSlot, uint uCBufferEntry);
}

///A linking-node interface is used for shader linking. <div class="alert"><b>Note</b> This interface is part of the
///HLSL shader linking technology that you can use on all Direct3D 11 platforms to create precompiled HLSL functions,
///package them into libraries, and link them into full shaders at run time. </div> <div> </div>
@GUID("D80DD70C-8D2F-4751-94A1-03C79B3556DB")
interface ID3D11LinkingNode : IUnknown
{
}

///A function-linking-graph interface is used for constructing shaders that consist of a sequence of precompiled
///function calls that pass values to each other. <div class="alert"><b>Note</b> This interface is part of the HLSL
///shader linking technology that you can use on all Direct3D 11 platforms to create precompiled HLSL functions, package
///them into libraries, and link them into full shaders at run time. </div> <div> </div>
@GUID("54133220-1CE8-43D3-8236-9855C5CEECFF")
interface ID3D11FunctionLinkingGraph : IUnknown
{
    ///Initializes a shader module from the function-linking-graph object.
    ///Params:
    ///    ppModuleInstance = Type: <b>ID3D11ModuleInstance**</b> The address of a pointer to an ID3D11ModuleInstance interface for the
    ///                       shader module to initialize.
    ///    ppErrorBuffer = Type: <b>ID3DBlob**</b> An optional pointer to a variable that receives a pointer to the ID3DBlob interface
    ///                    that you can use to access compiler error messages, or <b>NULL</b> if there are no errors.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT CreateModuleInstance(ID3D11ModuleInstance* ppModuleInstance, ID3DBlob* ppErrorBuffer);
    ///Sets the input signature of the function-linking-graph.
    ///Params:
    ///    pInputParameters = Type: <b>const D3D11_PARAMETER_DESC*</b> An array of D3D11_PARAMETER_DESC structures for the parameters of
    ///                       the input signature.
    ///    cInputParameters = Type: <b>UINT</b> The number of input parameters in the <i>pInputParameters</i> array.
    ///    ppInputNode = Type: <b>ID3D11LinkingNode**</b> A pointer to a variable that receives a pointer to the ID3D11LinkingNode
    ///                  interface that represents the input signature of the function-linking-graph.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT SetInputSignature(const(D3D11_PARAMETER_DESC)* pInputParameters, uint cInputParameters, 
                              ID3D11LinkingNode* ppInputNode);
    ///Sets the output signature of the function-linking-graph.
    ///Params:
    ///    pOutputParameters = Type: <b>const D3D11_PARAMETER_DESC*</b> An array of D3D11_PARAMETER_DESC structures for the parameters of
    ///                        the output signature.
    ///    cOutputParameters = Type: <b>UINT</b> The number of output parameters in the <i>pOutputParameters</i> array.
    ///    ppOutputNode = Type: <b>ID3D11LinkingNode**</b> A pointer to a variable that receives a pointer to the ID3D11LinkingNode
    ///                   interface that represents the output signature of the function-linking-graph.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT SetOutputSignature(const(D3D11_PARAMETER_DESC)* pOutputParameters, uint cOutputParameters, 
                               ID3D11LinkingNode* ppOutputNode);
    ///Creates a call-function linking node to use in the function-linking-graph.
    ///Params:
    ///    pModuleInstanceNamespace = Type: <b>LPCSTR</b> The optional namespace for the function, or <b>NULL</b> if no namespace is needed.
    ///    pModuleWithFunctionPrototype = Type: <b>ID3D11Module*</b> A pointer to the ID3D11ModuleInstance interface for the library module that
    ///                                   contains the function prototype.
    ///    pFunctionName = Type: <b>LPCSTR</b> The name of the function.
    ///    ppCallNode = Type: <b>ID3D11LinkingNode**</b> A pointer to a variable that receives a pointer to the ID3D11LinkingNode
    ///                 interface that represents the function in the function-linking-graph.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT CallFunction(const(PSTR) pModuleInstanceNamespace, ID3D11Module pModuleWithFunctionPrototype, 
                         const(PSTR) pFunctionName, ID3D11LinkingNode* ppCallNode);
    ///Passes a value from a source linking node to a destination linking node.
    ///Params:
    ///    pSrcNode = Type: <b>ID3D11LinkingNode*</b> A pointer to the ID3D11LinkingNode interface for the source linking node.
    ///    SrcParameterIndex = Type: <b>INT</b> The zero-based index of the source parameter.
    ///    pDstNode = Type: <b>ID3D11LinkingNode*</b> A pointer to the ID3D11LinkingNode interface for the destination linking
    ///               node.
    ///    DstParameterIndex = Type: <b>INT</b> The zero-based index of the destination parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT PassValue(ID3D11LinkingNode pSrcNode, int SrcParameterIndex, ID3D11LinkingNode pDstNode, 
                      int DstParameterIndex);
    ///Passes a value with swizzle from a source linking node to a destination linking node.
    ///Params:
    ///    pSrcNode = Type: <b>ID3D11LinkingNode*</b> A pointer to the ID3D11LinkingNode interface for the source linking node.
    ///    SrcParameterIndex = Type: <b>INT</b> The zero-based index of the source parameter.
    ///    pSrcSwizzle = Type: <b>LPCSTR</b> The name of the source swizzle.
    ///    pDstNode = Type: <b>ID3D11LinkingNode*</b> A pointer to the ID3D11LinkingNode interface for the destination linking
    ///               node.
    ///    DstParameterIndex = Type: <b>INT</b> The zero-based index of the destination parameter.
    ///    pDstSwizzle = Type: <b>LPCSTR</b> The name of the destination swizzle.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT PassValueWithSwizzle(ID3D11LinkingNode pSrcNode, int SrcParameterIndex, const(PSTR) pSrcSwizzle, 
                                 ID3D11LinkingNode pDstNode, int DstParameterIndex, const(PSTR) pDstSwizzle);
    ///Gets the error from the last function call of the function-linking-graph.
    ///Params:
    ///    ppErrorBuffer = Type: <b>ID3DBlob**</b> An pointer to a variable that receives a pointer to the ID3DBlob interface that you
    ///                    can use to access the error.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT GetLastError(ID3DBlob* ppErrorBuffer);
    ///Generates Microsoft High Level Shader Language (HLSL) shader code that represents the function-linking-graph.
    ///Params:
    ///    uFlags = Type: <b>UINT</b> Reserved
    ///    ppBuffer = Type: <b>ID3DBlob**</b> An pointer to a variable that receives a pointer to the ID3DBlob interface that you
    ///               can use to access the HLSL shader source code that represents the function-linking-graph. You can compile
    ///               this HLSL code, but first you must add code or include statements for the functions called in the
    ///               function-linking-graph.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the Direct3D 11 Return Codes.
    ///    
    HRESULT GenerateHlsl(uint uFlags, ID3DBlob* ppBuffer);
}

///An <b>ID3D11ShaderTrace</b> interface implements methods for obtaining traces of shader executions.
@GUID("36B013E6-2811-4845-BAA7-D623FE0DF104")
interface ID3D11ShaderTrace : IUnknown
{
    ///Specifies that the shader trace recorded and is ready to use.
    ///Params:
    ///    pTestCount = An optional pointer to a variable that receives the number of times that a matching invocation for the trace
    ///                 occurred. If not used, set to NULL. For more information about this number, see Remarks.
    ///Returns:
    ///    <b>TraceReady</b> returns: <ul> <li><b>S_OK</b> if the trace is ready.</li> <li><b>S_FALSE</b> if the trace
    ///    is not ready.</li> <li><b>E_OUTOFMEMORY</b> if memory ran out while the trace was in the process of
    ///    recording. You can try to record the trace again by calling ID3D11ShaderTrace::ResetTrace and then redrawing.
    ///    If you decide not to record the trace again, release the ID3D11ShaderTrace interface.</li> <li>Possibly other
    ///    error codes that are described in Direct3D 11 Return Codes.</li> </ul>
    ///    
    HRESULT TraceReady(ulong* pTestCount);
    ///Resets the shader-trace object.
    void    ResetTrace();
    ///Returns statistics about the trace.
    ///Params:
    ///    pTraceStats = A pointer to a D3D11_TRACE_STATS structure. <b>GetTraceStats</b> fills the members of this structure with
    ///                  statistics about the trace.
    ///Returns:
    ///    <b>GetTraceStats</b> returns: <ul> <li>S_OK if statistics about the trace are successfully obtained.</li>
    ///    <li>E_FAIL if no trace statistics are available yet; ID3D11ShaderTrace::TraceReady must return S_OK before
    ///    <b>GetTraceStats</b> can succeed.</li> <li>E_INVALIDARG if <i>pTraceStats</i> is NULL.</li> <li>Possibly
    ///    other error codes that are described in Direct3D 11 Return Codes.</li> </ul>
    ///    
    HRESULT GetTraceStats(D3D11_TRACE_STATS* pTraceStats);
    ///Sets the specified pixel-shader stamp.
    ///Params:
    ///    stampIndex = The index of the stamp to select.
    ///Returns:
    ///    <b>PSSelectStamp</b> returns: <ul> <li><b>S_OK</b> if the method set the pixel-shader stamp, and if the
    ///    primitive covers the pixel and sample for the stamp.</li> <li><b>S_FALSE</b> if the method set the
    ///    pixel-shader stamp, and if the invocation for the selected stamp falls off the primitive.</li>
    ///    <li><b>E_FAIL</b> if you called the method for a vertex shader or geometry shader; <b>PSSelectStamp</b> is
    ///    meaningful only for pixel shaders.</li> <li><b>E_INVALIDARG</b> if <i>stampIndex</i> is out of range
    ///    [0..3].</li> <li>Possibly other error codes that are described in Direct3D 11 Return Codes.</li> </ul>
    ///    
    HRESULT PSSelectStamp(uint stampIndex);
    ///Retrieves the initial contents of the specified input register.
    ///Params:
    ///    pRegister = A pointer to a D3D11_TRACE_REGISTER structure that describes the input register to retrieve the initial
    ///                contents from. You can retrieve valid initial data from only the following input register types. That is, to
    ///                retrieve valid data, the <b>RegType</b> member of <b>D3D11_TRACE_REGISTER</b> must be one of the following
    ///                values: <ul> <li>D3D11_TRACE_INPUT_REGISTER</li> <li>D3D11_TRACE_INPUT_PRIMITIVE_ID_REGISTER</li>
    ///                <li>D3D11_TRACE_IMMEDIATE_CONSTANT_BUFFER</li> </ul> Valid data is indicated by the <b>ValidMask</b> member
    ///                of the D3D11_TRACE_VALUE structure that <i>pValue</i> points to.
    ///    pValue = A pointer to a D3D11_TRACE_VALUE structure. <b>GetInitialRegisterContents</b> fills the members of this
    ///             structure with information about the initial contents.
    ///Returns:
    ///    <b>GetInitialRegisterContents</b> returns: <ul> <li><b>S_OK</b> if the method retrieves the initial register
    ///    contents.</li> <li><b>E_FAIL</b> if a trace is not available.</li> <li><b>E_INVALIDARG</b> if
    ///    <i>pRegister</i> is invalid or NULL or if <i>pValue</i> is NULL.</li> <li>Possibly other error codes that are
    ///    described in Direct3D 11 Return Codes.</li> </ul>
    ///    
    HRESULT GetInitialRegisterContents(D3D11_TRACE_REGISTER* pRegister, D3D11_TRACE_VALUE* pValue);
    ///Retrieves information about the specified step in the trace.
    ///Params:
    ///    stepIndex = The index of the step within the trace. The range of the index is [0...NumTraceSteps-1], where
    ///                <b>NumTraceSteps</b> is a member of the D3D11_TRACE_STATS structure. You can retrieve information about a
    ///                step in any step order.
    ///    pTraceStep = A pointer to a D3D11_TRACE_STEP structure. <b>GetStep</b> fills the members of this structure with
    ///                 information about the trace step that is specified by the <i>stepIndex</i> parameter.
    ///Returns:
    ///    <b>GetStep</b> returns: <ul> <li><b>S_OK</b> if the method retrieves the step information.</li>
    ///    <li><b>E_FAIL</b> if a trace is not available.</li> <li><b>E_INVALIDARG</b> if <i>stepIndex</i> is out of
    ///    range or if <i>pTraceStep</i> is NULL.</li> <li>Possibly other error codes that are described in Direct3D 11
    ///    Return Codes.</li> </ul>
    ///    
    HRESULT GetStep(uint stepIndex, D3D11_TRACE_STEP* pTraceStep);
    ///Retrieves information about a register that was written by a step in the trace.
    ///Params:
    ///    stepIndex = The index of the step within the trace. The range of the index is [0...NumTraceSteps-1], where
    ///                <b>NumTraceSteps</b> is a member of the D3D11_TRACE_STATS structure. You can retrieve information in any step
    ///                order.
    ///    writtenRegisterIndex = The index of the register within the trace step. The range of the index is [0...NumRegistersWritten-1], where
    ///                           <b>NumRegistersWritten</b> is a member of the D3D11_TRACE_STEP structure.
    ///    pRegister = A pointer to a D3D11_TRACE_REGISTER structure. <b>GetWrittenRegister</b> fills the members of this structure
    ///                with information about the register that was written by the step in the trace.
    ///    pValue = A pointer to a D3D11_TRACE_VALUE structure. <b>GetWrittenRegister</b> fills the members of this structure
    ///             with information about the value that was written to the register.
    ///Returns:
    ///    <b>GetWrittenRegister</b> returns: <ul> <li><b>S_OK</b> if the method retrieves the register
    ///    information.</li> <li><b>E_FAIL</b> if a trace is not available or if the trace was not created with the
    ///    D3D11_SHADER_TRACE_FLAG_RECORD_REGISTER_WRITES flag.</li> <li><b>E_INVALIDARG</b> if <i>stepIndex</i> or
    ///    <i>writtenRegisterIndex</i> is out of range or if <i>pRegister</i> or <i>pValue</i> is NULL.</li>
    ///    <li>Possibly other error codes that are described in Direct3D 11 Return Codes.</li> </ul>
    ///    
    HRESULT GetWrittenRegister(uint stepIndex, uint writtenRegisterIndex, D3D11_TRACE_REGISTER* pRegister, 
                               D3D11_TRACE_VALUE* pValue);
    ///Retrieves information about a register that was read by a step in the trace.
    ///Params:
    ///    stepIndex = The index of the step within the trace. The range of the index is [0...NumTraceSteps-1], where
    ///                <b>NumTraceSteps</b> is a member of the D3D11_TRACE_STATS structure. You can retrieve information in any step
    ///                order.
    ///    readRegisterIndex = The index of the register within the trace step. The range of the index is [0...NumRegistersRead-1], where
    ///                        <b>NumRegistersRead</b> is a member of the D3D11_TRACE_STEP structure.
    ///    pRegister = A pointer to a D3D11_TRACE_REGISTER structure. <b>GetReadRegister</b> fills the members of this structure
    ///                with information about the register that was read by the step in the trace.
    ///    pValue = A pointer to a D3D11_TRACE_VALUE structure. <b>GetReadRegister</b> fills the members of this structure with
    ///             information about the value that was read from the register.
    ///Returns:
    ///    <b>GetReadRegister</b> returns: <ul> <li><b>S_OK</b> if the method retrieves the register information.</li>
    ///    <li><b>E_FAIL</b> if a trace is not available or if the trace was not created with the
    ///    D3D11_SHADER_TRACE_FLAG_RECORD_REGISTER_READS flag.</li> <li><b>E_INVALIDARG</b> if <i>stepIndex</i> or
    ///    <i>readRegisterIndex</i> is out of range or if <i>pRegister</i> or <i>pValue</i> is NULL.</li> <li>Possibly
    ///    other error codes that are described in Direct3D 11 Return Codes.</li> </ul>
    ///    
    HRESULT GetReadRegister(uint stepIndex, uint readRegisterIndex, D3D11_TRACE_REGISTER* pRegister, 
                            D3D11_TRACE_VALUE* pValue);
}

///An <b>ID3D11ShaderTraceFactory</b> interface implements a method for generating shader trace information objects.
@GUID("1FBAD429-66AB-41CC-9617-667AC10E4459")
interface ID3D11ShaderTraceFactory : IUnknown
{
    ///Creates a shader-trace interface for a shader-trace information object.
    ///Params:
    ///    pShader = A pointer to the interface of the shader to create the shader-trace interface for. For example,
    ///              <i>pShader</i> can be an instance of ID3D11VertexShader, ID3D11PixelShader, and so on.
    ///    pTraceDesc = A pointer to a D3D11_SHADER_TRACE_DESC structure that describes the shader-trace object to create. This
    ///                 parameter cannot be <b>NULL</b>.
    ///    ppShaderTrace = A pointer to a variable that receives a pointer to the ID3D11ShaderTrace interface for the shader-trace
    ///                    object that <b>CreateShaderTrace</b> creates.
    ///Returns:
    ///    <b>CreateShaderTrace</b> returns: <ul> <li><b>S_OK</b> if the method created the shader-trace information
    ///    object.</li> <li><b>E_FAIL</b> if the reference device, which supports tracing, is not being used.</li>
    ///    <li><b>E_OUTOFMEMORY</b> if memory is unavailable to complete the operation.</li> <li><b>E_INVALIDARG</b> if
    ///    any parameter is NULL or invalid.</li> <li>Possibly other error codes that are described in Direct3D 11
    ///    Return Codes.</li> </ul>
    ///    
    HRESULT CreateShaderTrace(IUnknown pShader, D3D11_SHADER_TRACE_DESC* pTraceDesc, 
                              ID3D11ShaderTrace* ppShaderTrace);
}

///Scan context.
interface ID3DX11Scan : IUnknown
{
    ///Sets which direction to perform scans in.
    ///Params:
    ///    Direction = Type: <b>D3DX11_SCAN_DIRECTION</b> Direction to perform scans in. See D3DX11_SCAN_DIRECTION.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the return codes described in the topic Direct3D 11 Return Codes.
    ///    
    HRESULT SetScanDirection(D3DX11_SCAN_DIRECTION Direction);
    ///Performs an unsegmented scan of a sequence.
    ///Params:
    ///    ElementType = Type: <b>D3DX11_SCAN_DATA_TYPE</b> The type of element in the sequence. See D3DX11_SCAN_DATA_TYPE for more
    ///                  information.
    ///    OpCode = Type: <b>D3DX11_SCAN_OPCODE</b> The binary operation to perform. See D3DX11_SCAN_OPCODE for more information.
    ///    ElementScanSize = Type: <b>UINT</b> Size of scan in elements.
    ///    pSrc = Type: <b>ID3D11UnorderedAccessView*</b> Input sequence on the device. Set <i>pSrc</i> and <i>pDst</i> to the
    ///           same value for in-place scans.
    ///    pDst = Type: <b>ID3D11UnorderedAccessView*</b> Output sequence on the device.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the return codes described in the topic Direct3D 11 Return Codes.
    ///    
    HRESULT Scan(D3DX11_SCAN_DATA_TYPE ElementType, D3DX11_SCAN_OPCODE OpCode, uint ElementScanSize, 
                 ID3D11UnorderedAccessView pSrc, ID3D11UnorderedAccessView pDst);
    ///Performs a multiscan of a sequence.
    ///Params:
    ///    ElementType = Type: <b>D3DX11_SCAN_DATA_TYPE</b> The type of element in the sequence. See D3DX11_SCAN_DATA_TYPE for more
    ///                  information.
    ///    OpCode = Type: <b>D3DX11_SCAN_OPCODE</b> The binary operation to perform. See D3DX11_SCAN_OPCODE for more information.
    ///    ElementScanSize = Type: <b>UINT</b> Size of scan in elements.
    ///    ElementScanPitch = Type: <b>UINT</b> Pitch of the next scan in elements.
    ///    ScanCount = Type: <b>UINT</b> Number of scans in the multiscan.
    ///    pSrc = Type: <b>ID3D11UnorderedAccessView*</b> Input sequence on the device. Set <i>pSrc</i> and <i>pDst</i> to the
    ///           same value for in-place scans.
    ///    pDst = Type: <b>ID3D11UnorderedAccessView*</b> Output sequence on the device.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the return codes described in the topic Direct3D 11 Return Codes.
    ///    
    HRESULT Multiscan(D3DX11_SCAN_DATA_TYPE ElementType, D3DX11_SCAN_OPCODE OpCode, uint ElementScanSize, 
                      uint ElementScanPitch, uint ScanCount, ID3D11UnorderedAccessView pSrc, 
                      ID3D11UnorderedAccessView pDst);
}

///Segmented scan context.
interface ID3DX11SegmentedScan : IUnknown
{
    ///Sets which direction to perform scans in.
    ///Params:
    ///    Direction = Type: <b>D3DX11_SCAN_DIRECTION</b> Direction to perform scans in. See D3DX11_SCAN_DIRECTION.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the return codes described in the topic Direct3D 11 Return Codes.
    ///    
    HRESULT SetScanDirection(D3DX11_SCAN_DIRECTION Direction);
    ///Performs a segmented scan of a sequence.
    ///Params:
    ///    ElementType = Type: <b>D3DX11_SCAN_DATA_TYPE</b> The type of element in the sequence. See D3DX11_SCAN_DATA_TYPE for more
    ///                  information.
    ///    OpCode = Type: <b>D3DX11_SCAN_OPCODE</b> The binary operation to perform. See D3DX11_SCAN_OPCODE for more information.
    ///    ElementScanSize = Type: <b>UINT</b> Size of scan in elements.
    ///    pSrc = Type: <b>ID3D11UnorderedAccessView*</b> Input sequence on the device. Set <i>pSrc</i> and <i>pDst</i> to the
    ///           same value for in-place scans.
    ///    pSrcElementFlags = Type: <b>ID3D11UnorderedAccessView*</b> Compact array of bits with one bit per element of <i>pSrc</i>. A set
    ///                       value indicates the start of a new segment.
    ///    pDst = Type: <b>ID3D11UnorderedAccessView*</b> Output sequence on the device.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the return codes described in the topic Direct3D 11 Return Codes.
    ///    
    HRESULT SegScan(D3DX11_SCAN_DATA_TYPE ElementType, D3DX11_SCAN_OPCODE OpCode, uint ElementScanSize, 
                    ID3D11UnorderedAccessView pSrc, ID3D11UnorderedAccessView pSrcElementFlags, 
                    ID3D11UnorderedAccessView pDst);
}

///Encapsulates forward and inverse FFTs.
interface ID3DX11FFT : IUnknown
{
    ///Sets the scale used for forward transforms.
    ///Params:
    ///    ForwardScale = Type: <b>FLOAT</b> The scale to use for forward transforms. Setting <i>ForwardScale</i> to 0 causes the
    ///                   default values of 1 to be used.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the return codes described in the topic Direct3D 11 Return Codes.
    ///    
    HRESULT SetForwardScale(float ForwardScale);
    ///Gets the scale for forward transforms.
    ///Returns:
    ///    Type: <b>FLOAT</b> Scale for forward transforms.
    ///    
    float   GetForwardScale();
    ///Sets the scale used for inverse transforms.
    ///Params:
    ///    InverseScale = Type: <b>FLOAT</b> Scale used for inverse transforms. Setting <i>InverseScale</i> to 0 causes the default
    ///                   value of 1/N to be used, where N is the product of the transformed dimension lengths.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the return codes described in the topic Direct3D 11 Return Codes.
    ///    
    HRESULT SetInverseScale(float InverseScale);
    ///Get the scale for inverse transforms.
    ///Returns:
    ///    Type: <b>FLOAT</b> Scale for inverse transforms.
    ///    
    float   GetInverseScale();
    ///Attaches buffers to an FFT context and performs any required precomputations.
    ///Params:
    ///    NumTempBuffers = Type: <b>UINT</b> Number of buffers in <i>ppTempBuffers</i>.
    ///    ppTempBuffers = Type: <b>ID3D11UnorderedAccessView*</b> A pointer to an array of ID3D11UnorderedAccessView pointers for the
    ///                    temporary buffers to attach. The FFT object might use these temporary buffers for its algorithm.
    ///    NumPrecomputeBuffers = Type: <b>UINT</b> Number of buffers in <i>ppPrecomputeBuffers</i>.
    ///    ppPrecomputeBufferSizes = Type: <b>ID3D11UnorderedAccessView*</b> A pointer to an array of ID3D11UnorderedAccessView pointers for the
    ///                              precompute buffers to attach. The FFT object might store precomputed data in these buffers.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the return codes described in the topic Direct3D 11 Return Codes.
    ///    
    HRESULT AttachBuffersAndPrecompute(uint NumTempBuffers, ID3D11UnorderedAccessView* ppTempBuffers, 
                                       uint NumPrecomputeBuffers, ID3D11UnorderedAccessView* ppPrecomputeBufferSizes);
    ///Performs a forward FFT.
    ///Params:
    ///    pInputBuffer = Type: <b>const ID3D11UnorderedAccessView*</b> Pointer to ID3D11UnorderedAccessView onto the input buffer.
    ///    ppOutputBuffer = Type: <b>ID3D11UnorderedAccessView**</b> Pointer to a ID3D11UnorderedAccessView pointer. If
    ///                     *<i>ppOutputBuffer</i> is <b>NULL</b>, the computation will switch between temp buffers; in addition, the
    ///                     last buffer written to is stored at *<i>ppOutputBuffer</i>. Otherwise, *<i>ppOutputBuffer</i> is used as the
    ///                     output buffer (which might incur an extra copy).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the return codes described in the topic Direct3D 11 Return Codes.
    ///    
    HRESULT ForwardTransform(const(ID3D11UnorderedAccessView) pInputBuffer, 
                             ID3D11UnorderedAccessView* ppOutputBuffer);
    ///Performs an inverse FFT.
    ///Params:
    ///    pInputBuffer = Type: <b>const ID3D11UnorderedAccessView*</b> Pointer to ID3D11UnorderedAccessView onto the input buffer.
    ///    ppOutputBuffer = Type: <b>ID3D11UnorderedAccessView**</b> Pointer to a ID3D11UnorderedAccessView pointer. If *<i>ppOutput</i>
    ///                     is <b>NULL</b>, then the computation will switch between temp buffers; in addition, the last buffer written
    ///                     to is stored at *<i>ppOutput</i>. Otherwise, *<i>ppOutput</i> is used as the output buffer (which might incur
    ///                     an extra copy).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the return codes described in the topic Direct3D 11 Return Codes.
    ///    
    HRESULT InverseTransform(const(ID3D11UnorderedAccessView) pInputBuffer, 
                             ID3D11UnorderedAccessView* ppOutputBuffer);
}


// GUIDs


const GUID IID_ID3D11Asynchronous                   = GUIDOF!ID3D11Asynchronous;
const GUID IID_ID3D11BlendState                     = GUIDOF!ID3D11BlendState;
const GUID IID_ID3D11BlendState1                    = GUIDOF!ID3D11BlendState1;
const GUID IID_ID3D11Buffer                         = GUIDOF!ID3D11Buffer;
const GUID IID_ID3D11ClassInstance                  = GUIDOF!ID3D11ClassInstance;
const GUID IID_ID3D11ClassLinkage                   = GUIDOF!ID3D11ClassLinkage;
const GUID IID_ID3D11CommandList                    = GUIDOF!ID3D11CommandList;
const GUID IID_ID3D11ComputeShader                  = GUIDOF!ID3D11ComputeShader;
const GUID IID_ID3D11Counter                        = GUIDOF!ID3D11Counter;
const GUID IID_ID3D11Debug                          = GUIDOF!ID3D11Debug;
const GUID IID_ID3D11DepthStencilState              = GUIDOF!ID3D11DepthStencilState;
const GUID IID_ID3D11DepthStencilView               = GUIDOF!ID3D11DepthStencilView;
const GUID IID_ID3D11Device                         = GUIDOF!ID3D11Device;
const GUID IID_ID3D11Device1                        = GUIDOF!ID3D11Device1;
const GUID IID_ID3D11Device2                        = GUIDOF!ID3D11Device2;
const GUID IID_ID3D11Device3                        = GUIDOF!ID3D11Device3;
const GUID IID_ID3D11Device4                        = GUIDOF!ID3D11Device4;
const GUID IID_ID3D11Device5                        = GUIDOF!ID3D11Device5;
const GUID IID_ID3D11DeviceChild                    = GUIDOF!ID3D11DeviceChild;
const GUID IID_ID3D11DeviceContext                  = GUIDOF!ID3D11DeviceContext;
const GUID IID_ID3D11DeviceContext1                 = GUIDOF!ID3D11DeviceContext1;
const GUID IID_ID3D11DeviceContext2                 = GUIDOF!ID3D11DeviceContext2;
const GUID IID_ID3D11DeviceContext3                 = GUIDOF!ID3D11DeviceContext3;
const GUID IID_ID3D11DeviceContext4                 = GUIDOF!ID3D11DeviceContext4;
const GUID IID_ID3D11DomainShader                   = GUIDOF!ID3D11DomainShader;
const GUID IID_ID3D11Fence                          = GUIDOF!ID3D11Fence;
const GUID IID_ID3D11FunctionLinkingGraph           = GUIDOF!ID3D11FunctionLinkingGraph;
const GUID IID_ID3D11FunctionParameterReflection    = GUIDOF!ID3D11FunctionParameterReflection;
const GUID IID_ID3D11FunctionReflection             = GUIDOF!ID3D11FunctionReflection;
const GUID IID_ID3D11GeometryShader                 = GUIDOF!ID3D11GeometryShader;
const GUID IID_ID3D11HullShader                     = GUIDOF!ID3D11HullShader;
const GUID IID_ID3D11InfoQueue                      = GUIDOF!ID3D11InfoQueue;
const GUID IID_ID3D11InputLayout                    = GUIDOF!ID3D11InputLayout;
const GUID IID_ID3D11LibraryReflection              = GUIDOF!ID3D11LibraryReflection;
const GUID IID_ID3D11Linker                         = GUIDOF!ID3D11Linker;
const GUID IID_ID3D11LinkingNode                    = GUIDOF!ID3D11LinkingNode;
const GUID IID_ID3D11Module                         = GUIDOF!ID3D11Module;
const GUID IID_ID3D11ModuleInstance                 = GUIDOF!ID3D11ModuleInstance;
const GUID IID_ID3D11Multithread                    = GUIDOF!ID3D11Multithread;
const GUID IID_ID3D11PixelShader                    = GUIDOF!ID3D11PixelShader;
const GUID IID_ID3D11Predicate                      = GUIDOF!ID3D11Predicate;
const GUID IID_ID3D11Query                          = GUIDOF!ID3D11Query;
const GUID IID_ID3D11Query1                         = GUIDOF!ID3D11Query1;
const GUID IID_ID3D11RasterizerState                = GUIDOF!ID3D11RasterizerState;
const GUID IID_ID3D11RasterizerState1               = GUIDOF!ID3D11RasterizerState1;
const GUID IID_ID3D11RasterizerState2               = GUIDOF!ID3D11RasterizerState2;
const GUID IID_ID3D11RefDefaultTrackingOptions      = GUIDOF!ID3D11RefDefaultTrackingOptions;
const GUID IID_ID3D11RefTrackingOptions             = GUIDOF!ID3D11RefTrackingOptions;
const GUID IID_ID3D11RenderTargetView               = GUIDOF!ID3D11RenderTargetView;
const GUID IID_ID3D11RenderTargetView1              = GUIDOF!ID3D11RenderTargetView1;
const GUID IID_ID3D11Resource                       = GUIDOF!ID3D11Resource;
const GUID IID_ID3D11SamplerState                   = GUIDOF!ID3D11SamplerState;
const GUID IID_ID3D11ShaderReflection               = GUIDOF!ID3D11ShaderReflection;
const GUID IID_ID3D11ShaderReflectionConstantBuffer = GUIDOF!ID3D11ShaderReflectionConstantBuffer;
const GUID IID_ID3D11ShaderReflectionType           = GUIDOF!ID3D11ShaderReflectionType;
const GUID IID_ID3D11ShaderReflectionVariable       = GUIDOF!ID3D11ShaderReflectionVariable;
const GUID IID_ID3D11ShaderResourceView             = GUIDOF!ID3D11ShaderResourceView;
const GUID IID_ID3D11ShaderResourceView1            = GUIDOF!ID3D11ShaderResourceView1;
const GUID IID_ID3D11ShaderTrace                    = GUIDOF!ID3D11ShaderTrace;
const GUID IID_ID3D11ShaderTraceFactory             = GUIDOF!ID3D11ShaderTraceFactory;
const GUID IID_ID3D11SwitchToRef                    = GUIDOF!ID3D11SwitchToRef;
const GUID IID_ID3D11Texture1D                      = GUIDOF!ID3D11Texture1D;
const GUID IID_ID3D11Texture2D                      = GUIDOF!ID3D11Texture2D;
const GUID IID_ID3D11Texture2D1                     = GUIDOF!ID3D11Texture2D1;
const GUID IID_ID3D11Texture3D                      = GUIDOF!ID3D11Texture3D;
const GUID IID_ID3D11Texture3D1                     = GUIDOF!ID3D11Texture3D1;
const GUID IID_ID3D11TracingDevice                  = GUIDOF!ID3D11TracingDevice;
const GUID IID_ID3D11UnorderedAccessView            = GUIDOF!ID3D11UnorderedAccessView;
const GUID IID_ID3D11UnorderedAccessView1           = GUIDOF!ID3D11UnorderedAccessView1;
const GUID IID_ID3D11VertexShader                   = GUIDOF!ID3D11VertexShader;
const GUID IID_ID3D11VideoContext3                  = GUIDOF!ID3D11VideoContext3;
const GUID IID_ID3D11VideoDevice2                   = GUIDOF!ID3D11VideoDevice2;
const GUID IID_ID3D11View                           = GUIDOF!ID3D11View;
const GUID IID_ID3DBlob                             = GUIDOF!ID3DBlob;
const GUID IID_ID3DDestructionNotifier              = GUIDOF!ID3DDestructionNotifier;
const GUID IID_ID3DDeviceContextState               = GUIDOF!ID3DDeviceContextState;
const GUID IID_ID3DUserDefinedAnnotation            = GUIDOF!ID3DUserDefinedAnnotation;
