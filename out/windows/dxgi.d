module windows.dxgi;

public import system;
public import windows.com;
public import windows.displaydevices;
public import windows.gdi;
public import windows.kernel;
public import windows.systemservices;
public import windows.windowsandmessaging;

extern(Windows):

@DllImport("dxgi.dll")
HRESULT CreateDXGIFactory(const(Guid)* riid, void** ppFactory);

@DllImport("dxgi.dll")
HRESULT CreateDXGIFactory1(const(Guid)* riid, void** ppFactory);

@DllImport("dxgi.dll")
HRESULT CreateDXGIFactory2(uint Flags, const(Guid)* riid, void** ppFactory);

@DllImport("dxgi.dll")
HRESULT DXGIGetDebugInterface1(uint Flags, const(Guid)* riid, void** pDebug);

@DllImport("dxgi.dll")
HRESULT DXGIDeclareAdapterRemovalSupport();

struct DXGI_RATIONAL
{
    uint Numerator;
    uint Denominator;
}

struct DXGI_SAMPLE_DESC
{
    uint Count;
    uint Quality;
}

enum DXGI_COLOR_SPACE_TYPE
{
    DXGI_COLOR_SPACE_RGB_FULL_G22_NONE_P709 = 0,
    DXGI_COLOR_SPACE_RGB_FULL_G10_NONE_P709 = 1,
    DXGI_COLOR_SPACE_RGB_STUDIO_G22_NONE_P709 = 2,
    DXGI_COLOR_SPACE_RGB_STUDIO_G22_NONE_P2020 = 3,
    DXGI_COLOR_SPACE_RESERVED = 4,
    DXGI_COLOR_SPACE_YCBCR_FULL_G22_NONE_P709_X601 = 5,
    DXGI_COLOR_SPACE_YCBCR_STUDIO_G22_LEFT_P601 = 6,
    DXGI_COLOR_SPACE_YCBCR_FULL_G22_LEFT_P601 = 7,
    DXGI_COLOR_SPACE_YCBCR_STUDIO_G22_LEFT_P709 = 8,
    DXGI_COLOR_SPACE_YCBCR_FULL_G22_LEFT_P709 = 9,
    DXGI_COLOR_SPACE_YCBCR_STUDIO_G22_LEFT_P2020 = 10,
    DXGI_COLOR_SPACE_YCBCR_FULL_G22_LEFT_P2020 = 11,
    DXGI_COLOR_SPACE_RGB_FULL_G2084_NONE_P2020 = 12,
    DXGI_COLOR_SPACE_YCBCR_STUDIO_G2084_LEFT_P2020 = 13,
    DXGI_COLOR_SPACE_RGB_STUDIO_G2084_NONE_P2020 = 14,
    DXGI_COLOR_SPACE_YCBCR_STUDIO_G22_TOPLEFT_P2020 = 15,
    DXGI_COLOR_SPACE_YCBCR_STUDIO_G2084_TOPLEFT_P2020 = 16,
    DXGI_COLOR_SPACE_RGB_FULL_G22_NONE_P2020 = 17,
    DXGI_COLOR_SPACE_YCBCR_STUDIO_GHLG_TOPLEFT_P2020 = 18,
    DXGI_COLOR_SPACE_YCBCR_FULL_GHLG_TOPLEFT_P2020 = 19,
    DXGI_COLOR_SPACE_RGB_STUDIO_G24_NONE_P709 = 20,
    DXGI_COLOR_SPACE_RGB_STUDIO_G24_NONE_P2020 = 21,
    DXGI_COLOR_SPACE_YCBCR_STUDIO_G24_LEFT_P709 = 22,
    DXGI_COLOR_SPACE_YCBCR_STUDIO_G24_LEFT_P2020 = 23,
    DXGI_COLOR_SPACE_YCBCR_STUDIO_G24_TOPLEFT_P2020 = 24,
    DXGI_COLOR_SPACE_CUSTOM = -1,
}

enum DXGI_FORMAT
{
    DXGI_FORMAT_UNKNOWN = 0,
    DXGI_FORMAT_R32G32B32A32_TYPELESS = 1,
    DXGI_FORMAT_R32G32B32A32_FLOAT = 2,
    DXGI_FORMAT_R32G32B32A32_UINT = 3,
    DXGI_FORMAT_R32G32B32A32_SINT = 4,
    DXGI_FORMAT_R32G32B32_TYPELESS = 5,
    DXGI_FORMAT_R32G32B32_FLOAT = 6,
    DXGI_FORMAT_R32G32B32_UINT = 7,
    DXGI_FORMAT_R32G32B32_SINT = 8,
    DXGI_FORMAT_R16G16B16A16_TYPELESS = 9,
    DXGI_FORMAT_R16G16B16A16_FLOAT = 10,
    DXGI_FORMAT_R16G16B16A16_UNORM = 11,
    DXGI_FORMAT_R16G16B16A16_UINT = 12,
    DXGI_FORMAT_R16G16B16A16_SNORM = 13,
    DXGI_FORMAT_R16G16B16A16_SINT = 14,
    DXGI_FORMAT_R32G32_TYPELESS = 15,
    DXGI_FORMAT_R32G32_FLOAT = 16,
    DXGI_FORMAT_R32G32_UINT = 17,
    DXGI_FORMAT_R32G32_SINT = 18,
    DXGI_FORMAT_R32G8X24_TYPELESS = 19,
    DXGI_FORMAT_D32_FLOAT_S8X24_UINT = 20,
    DXGI_FORMAT_R32_FLOAT_X8X24_TYPELESS = 21,
    DXGI_FORMAT_X32_TYPELESS_G8X24_UINT = 22,
    DXGI_FORMAT_R10G10B10A2_TYPELESS = 23,
    DXGI_FORMAT_R10G10B10A2_UNORM = 24,
    DXGI_FORMAT_R10G10B10A2_UINT = 25,
    DXGI_FORMAT_R11G11B10_FLOAT = 26,
    DXGI_FORMAT_R8G8B8A8_TYPELESS = 27,
    DXGI_FORMAT_R8G8B8A8_UNORM = 28,
    DXGI_FORMAT_R8G8B8A8_UNORM_SRGB = 29,
    DXGI_FORMAT_R8G8B8A8_UINT = 30,
    DXGI_FORMAT_R8G8B8A8_SNORM = 31,
    DXGI_FORMAT_R8G8B8A8_SINT = 32,
    DXGI_FORMAT_R16G16_TYPELESS = 33,
    DXGI_FORMAT_R16G16_FLOAT = 34,
    DXGI_FORMAT_R16G16_UNORM = 35,
    DXGI_FORMAT_R16G16_UINT = 36,
    DXGI_FORMAT_R16G16_SNORM = 37,
    DXGI_FORMAT_R16G16_SINT = 38,
    DXGI_FORMAT_R32_TYPELESS = 39,
    DXGI_FORMAT_D32_FLOAT = 40,
    DXGI_FORMAT_R32_FLOAT = 41,
    DXGI_FORMAT_R32_UINT = 42,
    DXGI_FORMAT_R32_SINT = 43,
    DXGI_FORMAT_R24G8_TYPELESS = 44,
    DXGI_FORMAT_D24_UNORM_S8_UINT = 45,
    DXGI_FORMAT_R24_UNORM_X8_TYPELESS = 46,
    DXGI_FORMAT_X24_TYPELESS_G8_UINT = 47,
    DXGI_FORMAT_R8G8_TYPELESS = 48,
    DXGI_FORMAT_R8G8_UNORM = 49,
    DXGI_FORMAT_R8G8_UINT = 50,
    DXGI_FORMAT_R8G8_SNORM = 51,
    DXGI_FORMAT_R8G8_SINT = 52,
    DXGI_FORMAT_R16_TYPELESS = 53,
    DXGI_FORMAT_R16_FLOAT = 54,
    DXGI_FORMAT_D16_UNORM = 55,
    DXGI_FORMAT_R16_UNORM = 56,
    DXGI_FORMAT_R16_UINT = 57,
    DXGI_FORMAT_R16_SNORM = 58,
    DXGI_FORMAT_R16_SINT = 59,
    DXGI_FORMAT_R8_TYPELESS = 60,
    DXGI_FORMAT_R8_UNORM = 61,
    DXGI_FORMAT_R8_UINT = 62,
    DXGI_FORMAT_R8_SNORM = 63,
    DXGI_FORMAT_R8_SINT = 64,
    DXGI_FORMAT_A8_UNORM = 65,
    DXGI_FORMAT_R1_UNORM = 66,
    DXGI_FORMAT_R9G9B9E5_SHAREDEXP = 67,
    DXGI_FORMAT_R8G8_B8G8_UNORM = 68,
    DXGI_FORMAT_G8R8_G8B8_UNORM = 69,
    DXGI_FORMAT_BC1_TYPELESS = 70,
    DXGI_FORMAT_BC1_UNORM = 71,
    DXGI_FORMAT_BC1_UNORM_SRGB = 72,
    DXGI_FORMAT_BC2_TYPELESS = 73,
    DXGI_FORMAT_BC2_UNORM = 74,
    DXGI_FORMAT_BC2_UNORM_SRGB = 75,
    DXGI_FORMAT_BC3_TYPELESS = 76,
    DXGI_FORMAT_BC3_UNORM = 77,
    DXGI_FORMAT_BC3_UNORM_SRGB = 78,
    DXGI_FORMAT_BC4_TYPELESS = 79,
    DXGI_FORMAT_BC4_UNORM = 80,
    DXGI_FORMAT_BC4_SNORM = 81,
    DXGI_FORMAT_BC5_TYPELESS = 82,
    DXGI_FORMAT_BC5_UNORM = 83,
    DXGI_FORMAT_BC5_SNORM = 84,
    DXGI_FORMAT_B5G6R5_UNORM = 85,
    DXGI_FORMAT_B5G5R5A1_UNORM = 86,
    DXGI_FORMAT_B8G8R8A8_UNORM = 87,
    DXGI_FORMAT_B8G8R8X8_UNORM = 88,
    DXGI_FORMAT_R10G10B10_XR_BIAS_A2_UNORM = 89,
    DXGI_FORMAT_B8G8R8A8_TYPELESS = 90,
    DXGI_FORMAT_B8G8R8A8_UNORM_SRGB = 91,
    DXGI_FORMAT_B8G8R8X8_TYPELESS = 92,
    DXGI_FORMAT_B8G8R8X8_UNORM_SRGB = 93,
    DXGI_FORMAT_BC6H_TYPELESS = 94,
    DXGI_FORMAT_BC6H_UF16 = 95,
    DXGI_FORMAT_BC6H_SF16 = 96,
    DXGI_FORMAT_BC7_TYPELESS = 97,
    DXGI_FORMAT_BC7_UNORM = 98,
    DXGI_FORMAT_BC7_UNORM_SRGB = 99,
    DXGI_FORMAT_AYUV = 100,
    DXGI_FORMAT_Y410 = 101,
    DXGI_FORMAT_Y416 = 102,
    DXGI_FORMAT_NV12 = 103,
    DXGI_FORMAT_P010 = 104,
    DXGI_FORMAT_P016 = 105,
    DXGI_FORMAT_420_OPAQUE = 106,
    DXGI_FORMAT_YUY2 = 107,
    DXGI_FORMAT_Y210 = 108,
    DXGI_FORMAT_Y216 = 109,
    DXGI_FORMAT_NV11 = 110,
    DXGI_FORMAT_AI44 = 111,
    DXGI_FORMAT_IA44 = 112,
    DXGI_FORMAT_P8 = 113,
    DXGI_FORMAT_A8P8 = 114,
    DXGI_FORMAT_B4G4R4A4_UNORM = 115,
    DXGI_FORMAT_P208 = 130,
    DXGI_FORMAT_V208 = 131,
    DXGI_FORMAT_V408 = 132,
    DXGI_FORMAT_SAMPLER_FEEDBACK_MIN_MIP_OPAQUE = 189,
    DXGI_FORMAT_SAMPLER_FEEDBACK_MIP_REGION_USED_OPAQUE = 190,
    DXGI_FORMAT_FORCE_UINT = 4294967295,
}

struct DXGI_RGB
{
    float Red;
    float Green;
    float Blue;
}

struct DXGI_RGBA
{
    float r;
    float g;
    float b;
    float a;
}

struct DXGI_GAMMA_CONTROL
{
    DXGI_RGB Scale;
    DXGI_RGB Offset;
    DXGI_RGB GammaCurve;
}

struct DXGI_GAMMA_CONTROL_CAPABILITIES
{
    BOOL ScaleAndOffsetSupported;
    float MaxConvertedValue;
    float MinConvertedValue;
    uint NumGammaControlPoints;
    float ControlPointPositions;
}

enum DXGI_MODE_SCANLINE_ORDER
{
    DXGI_MODE_SCANLINE_ORDER_UNSPECIFIED = 0,
    DXGI_MODE_SCANLINE_ORDER_PROGRESSIVE = 1,
    DXGI_MODE_SCANLINE_ORDER_UPPER_FIELD_FIRST = 2,
    DXGI_MODE_SCANLINE_ORDER_LOWER_FIELD_FIRST = 3,
}

enum DXGI_MODE_SCALING
{
    DXGI_MODE_SCALING_UNSPECIFIED = 0,
    DXGI_MODE_SCALING_CENTERED = 1,
    DXGI_MODE_SCALING_STRETCHED = 2,
}

enum DXGI_MODE_ROTATION
{
    DXGI_MODE_ROTATION_UNSPECIFIED = 0,
    DXGI_MODE_ROTATION_IDENTITY = 1,
    DXGI_MODE_ROTATION_ROTATE90 = 2,
    DXGI_MODE_ROTATION_ROTATE180 = 3,
    DXGI_MODE_ROTATION_ROTATE270 = 4,
}

struct DXGI_MODE_DESC
{
    uint Width;
    uint Height;
    DXGI_RATIONAL RefreshRate;
    DXGI_FORMAT Format;
    DXGI_MODE_SCANLINE_ORDER ScanlineOrdering;
    DXGI_MODE_SCALING Scaling;
}

struct DXGI_JPEG_DC_HUFFMAN_TABLE
{
    ubyte CodeCounts;
    ubyte CodeValues;
}

struct DXGI_JPEG_AC_HUFFMAN_TABLE
{
    ubyte CodeCounts;
    ubyte CodeValues;
}

struct DXGI_JPEG_QUANTIZATION_TABLE
{
    ubyte Elements;
}

struct DXGI_FRAME_STATISTICS
{
    uint PresentCount;
    uint PresentRefreshCount;
    uint SyncRefreshCount;
    LARGE_INTEGER SyncQPCTime;
    LARGE_INTEGER SyncGPUTime;
}

struct DXGI_MAPPED_RECT
{
    int Pitch;
    ubyte* pBits;
}

struct DXGI_ADAPTER_DESC
{
    ushort Description;
    uint VendorId;
    uint DeviceId;
    uint SubSysId;
    uint Revision;
    uint DedicatedVideoMemory;
    uint DedicatedSystemMemory;
    uint SharedSystemMemory;
    LUID AdapterLuid;
}

struct DXGI_OUTPUT_DESC
{
    ushort DeviceName;
    RECT DesktopCoordinates;
    BOOL AttachedToDesktop;
    DXGI_MODE_ROTATION Rotation;
    int Monitor;
}

struct DXGI_SHARED_RESOURCE
{
    HANDLE Handle;
}

enum DXGI_RESIDENCY
{
    DXGI_RESIDENCY_FULLY_RESIDENT = 1,
    DXGI_RESIDENCY_RESIDENT_IN_SHARED_MEMORY = 2,
    DXGI_RESIDENCY_EVICTED_TO_DISK = 3,
}

struct DXGI_SURFACE_DESC
{
    uint Width;
    uint Height;
    DXGI_FORMAT Format;
    DXGI_SAMPLE_DESC SampleDesc;
}

enum DXGI_SWAP_EFFECT
{
    DXGI_SWAP_EFFECT_DISCARD = 0,
    DXGI_SWAP_EFFECT_SEQUENTIAL = 1,
    DXGI_SWAP_EFFECT_FLIP_SEQUENTIAL = 3,
    DXGI_SWAP_EFFECT_FLIP_DISCARD = 4,
}

enum DXGI_SWAP_CHAIN_FLAG
{
    DXGI_SWAP_CHAIN_FLAG_NONPREROTATED = 1,
    DXGI_SWAP_CHAIN_FLAG_ALLOW_MODE_SWITCH = 2,
    DXGI_SWAP_CHAIN_FLAG_GDI_COMPATIBLE = 4,
    DXGI_SWAP_CHAIN_FLAG_RESTRICTED_CONTENT = 8,
    DXGI_SWAP_CHAIN_FLAG_RESTRICT_SHARED_RESOURCE_DRIVER = 16,
    DXGI_SWAP_CHAIN_FLAG_DISPLAY_ONLY = 32,
    DXGI_SWAP_CHAIN_FLAG_FRAME_LATENCY_WAITABLE_OBJECT = 64,
    DXGI_SWAP_CHAIN_FLAG_FOREGROUND_LAYER = 128,
    DXGI_SWAP_CHAIN_FLAG_FULLSCREEN_VIDEO = 256,
    DXGI_SWAP_CHAIN_FLAG_YUV_VIDEO = 512,
    DXGI_SWAP_CHAIN_FLAG_HW_PROTECTED = 1024,
    DXGI_SWAP_CHAIN_FLAG_ALLOW_TEARING = 2048,
    DXGI_SWAP_CHAIN_FLAG_RESTRICTED_TO_ALL_HOLOGRAPHIC_DISPLAYS = 4096,
}

struct DXGI_SWAP_CHAIN_DESC
{
    DXGI_MODE_DESC BufferDesc;
    DXGI_SAMPLE_DESC SampleDesc;
    uint BufferUsage;
    uint BufferCount;
    HWND OutputWindow;
    BOOL Windowed;
    DXGI_SWAP_EFFECT SwapEffect;
    uint Flags;
}

const GUID IID_IDXGIObject = {0xAEC22FB8, 0x76F3, 0x4639, [0x9B, 0xE0, 0x28, 0xEB, 0x43, 0xA6, 0x7A, 0x2E]};
@GUID(0xAEC22FB8, 0x76F3, 0x4639, [0x9B, 0xE0, 0x28, 0xEB, 0x43, 0xA6, 0x7A, 0x2E]);
interface IDXGIObject : IUnknown
{
    HRESULT SetPrivateData(const(Guid)* Name, uint DataSize, char* pData);
    HRESULT SetPrivateDataInterface(const(Guid)* Name, const(IUnknown) pUnknown);
    HRESULT GetPrivateData(const(Guid)* Name, uint* pDataSize, char* pData);
    HRESULT GetParent(const(Guid)* riid, void** ppParent);
}

const GUID IID_IDXGIDeviceSubObject = {0x3D3E0379, 0xF9DE, 0x4D58, [0xBB, 0x6C, 0x18, 0xD6, 0x29, 0x92, 0xF1, 0xA6]};
@GUID(0x3D3E0379, 0xF9DE, 0x4D58, [0xBB, 0x6C, 0x18, 0xD6, 0x29, 0x92, 0xF1, 0xA6]);
interface IDXGIDeviceSubObject : IDXGIObject
{
    HRESULT GetDevice(const(Guid)* riid, void** ppDevice);
}

const GUID IID_IDXGIResource = {0x035F3AB4, 0x482E, 0x4E50, [0xB4, 0x1F, 0x8A, 0x7F, 0x8B, 0xD8, 0x96, 0x0B]};
@GUID(0x035F3AB4, 0x482E, 0x4E50, [0xB4, 0x1F, 0x8A, 0x7F, 0x8B, 0xD8, 0x96, 0x0B]);
interface IDXGIResource : IDXGIDeviceSubObject
{
    HRESULT GetSharedHandle(HANDLE* pSharedHandle);
    HRESULT GetUsage(uint* pUsage);
    HRESULT SetEvictionPriority(uint EvictionPriority);
    HRESULT GetEvictionPriority(uint* pEvictionPriority);
}

const GUID IID_IDXGIKeyedMutex = {0x9D8E1289, 0xD7B3, 0x465F, [0x81, 0x26, 0x25, 0x0E, 0x34, 0x9A, 0xF8, 0x5D]};
@GUID(0x9D8E1289, 0xD7B3, 0x465F, [0x81, 0x26, 0x25, 0x0E, 0x34, 0x9A, 0xF8, 0x5D]);
interface IDXGIKeyedMutex : IDXGIDeviceSubObject
{
    HRESULT AcquireSync(ulong Key, uint dwMilliseconds);
    HRESULT ReleaseSync(ulong Key);
}

const GUID IID_IDXGISurface = {0xCAFCB56C, 0x6AC3, 0x4889, [0xBF, 0x47, 0x9E, 0x23, 0xBB, 0xD2, 0x60, 0xEC]};
@GUID(0xCAFCB56C, 0x6AC3, 0x4889, [0xBF, 0x47, 0x9E, 0x23, 0xBB, 0xD2, 0x60, 0xEC]);
interface IDXGISurface : IDXGIDeviceSubObject
{
    HRESULT GetDesc(DXGI_SURFACE_DESC* pDesc);
    HRESULT Map(DXGI_MAPPED_RECT* pLockedRect, uint MapFlags);
    HRESULT Unmap();
}

const GUID IID_IDXGISurface1 = {0x4AE63092, 0x6327, 0x4C1B, [0x80, 0xAE, 0xBF, 0xE1, 0x2E, 0xA3, 0x2B, 0x86]};
@GUID(0x4AE63092, 0x6327, 0x4C1B, [0x80, 0xAE, 0xBF, 0xE1, 0x2E, 0xA3, 0x2B, 0x86]);
interface IDXGISurface1 : IDXGISurface
{
    HRESULT GetDC(BOOL Discard, HDC* phdc);
    HRESULT ReleaseDC(RECT* pDirtyRect);
}

const GUID IID_IDXGIAdapter = {0x2411E7E1, 0x12AC, 0x4CCF, [0xBD, 0x14, 0x97, 0x98, 0xE8, 0x53, 0x4D, 0xC0]};
@GUID(0x2411E7E1, 0x12AC, 0x4CCF, [0xBD, 0x14, 0x97, 0x98, 0xE8, 0x53, 0x4D, 0xC0]);
interface IDXGIAdapter : IDXGIObject
{
    HRESULT EnumOutputs(uint Output, IDXGIOutput* ppOutput);
    HRESULT GetDesc(DXGI_ADAPTER_DESC* pDesc);
    HRESULT CheckInterfaceSupport(const(Guid)* InterfaceName, LARGE_INTEGER* pUMDVersion);
}

const GUID IID_IDXGIOutput = {0xAE02EEDB, 0xC735, 0x4690, [0x8D, 0x52, 0x5A, 0x8D, 0xC2, 0x02, 0x13, 0xAA]};
@GUID(0xAE02EEDB, 0xC735, 0x4690, [0x8D, 0x52, 0x5A, 0x8D, 0xC2, 0x02, 0x13, 0xAA]);
interface IDXGIOutput : IDXGIObject
{
    HRESULT GetDesc(DXGI_OUTPUT_DESC* pDesc);
    HRESULT GetDisplayModeList(DXGI_FORMAT EnumFormat, uint Flags, uint* pNumModes, char* pDesc);
    HRESULT FindClosestMatchingMode(const(DXGI_MODE_DESC)* pModeToMatch, DXGI_MODE_DESC* pClosestMatch, IUnknown pConcernedDevice);
    HRESULT WaitForVBlank();
    HRESULT TakeOwnership(IUnknown pDevice, BOOL Exclusive);
    void ReleaseOwnership();
    HRESULT GetGammaControlCapabilities(DXGI_GAMMA_CONTROL_CAPABILITIES* pGammaCaps);
    HRESULT SetGammaControl(const(DXGI_GAMMA_CONTROL)* pArray);
    HRESULT GetGammaControl(DXGI_GAMMA_CONTROL* pArray);
    HRESULT SetDisplaySurface(IDXGISurface pScanoutSurface);
    HRESULT GetDisplaySurfaceData(IDXGISurface pDestination);
    HRESULT GetFrameStatistics(DXGI_FRAME_STATISTICS* pStats);
}

const GUID IID_IDXGISwapChain = {0x310D36A0, 0xD2E7, 0x4C0A, [0xAA, 0x04, 0x6A, 0x9D, 0x23, 0xB8, 0x88, 0x6A]};
@GUID(0x310D36A0, 0xD2E7, 0x4C0A, [0xAA, 0x04, 0x6A, 0x9D, 0x23, 0xB8, 0x88, 0x6A]);
interface IDXGISwapChain : IDXGIDeviceSubObject
{
    HRESULT Present(uint SyncInterval, uint Flags);
    HRESULT GetBuffer(uint Buffer, const(Guid)* riid, void** ppSurface);
    HRESULT SetFullscreenState(BOOL Fullscreen, IDXGIOutput pTarget);
    HRESULT GetFullscreenState(int* pFullscreen, IDXGIOutput* ppTarget);
    HRESULT GetDesc(DXGI_SWAP_CHAIN_DESC* pDesc);
    HRESULT ResizeBuffers(uint BufferCount, uint Width, uint Height, DXGI_FORMAT NewFormat, uint SwapChainFlags);
    HRESULT ResizeTarget(const(DXGI_MODE_DESC)* pNewTargetParameters);
    HRESULT GetContainingOutput(IDXGIOutput* ppOutput);
    HRESULT GetFrameStatistics(DXGI_FRAME_STATISTICS* pStats);
    HRESULT GetLastPresentCount(uint* pLastPresentCount);
}

const GUID IID_IDXGIFactory = {0x7B7166EC, 0x21C7, 0x44AE, [0xB2, 0x1A, 0xC9, 0xAE, 0x32, 0x1A, 0xE3, 0x69]};
@GUID(0x7B7166EC, 0x21C7, 0x44AE, [0xB2, 0x1A, 0xC9, 0xAE, 0x32, 0x1A, 0xE3, 0x69]);
interface IDXGIFactory : IDXGIObject
{
    HRESULT EnumAdapters(uint Adapter, IDXGIAdapter* ppAdapter);
    HRESULT MakeWindowAssociation(HWND WindowHandle, uint Flags);
    HRESULT GetWindowAssociation(HWND* pWindowHandle);
    HRESULT CreateSwapChain(IUnknown pDevice, DXGI_SWAP_CHAIN_DESC* pDesc, IDXGISwapChain* ppSwapChain);
    HRESULT CreateSoftwareAdapter(int Module, IDXGIAdapter* ppAdapter);
}

const GUID IID_IDXGIDevice = {0x54EC77FA, 0x1377, 0x44E6, [0x8C, 0x32, 0x88, 0xFD, 0x5F, 0x44, 0xC8, 0x4C]};
@GUID(0x54EC77FA, 0x1377, 0x44E6, [0x8C, 0x32, 0x88, 0xFD, 0x5F, 0x44, 0xC8, 0x4C]);
interface IDXGIDevice : IDXGIObject
{
    HRESULT GetAdapter(IDXGIAdapter* pAdapter);
    HRESULT CreateSurface(const(DXGI_SURFACE_DESC)* pDesc, uint NumSurfaces, uint Usage, const(DXGI_SHARED_RESOURCE)* pSharedResource, IDXGISurface* ppSurface);
    HRESULT QueryResourceResidency(char* ppResources, char* pResidencyStatus, uint NumResources);
    HRESULT SetGPUThreadPriority(int Priority);
    HRESULT GetGPUThreadPriority(int* pPriority);
}

enum DXGI_ADAPTER_FLAG
{
    DXGI_ADAPTER_FLAG_NONE = 0,
    DXGI_ADAPTER_FLAG_REMOTE = 1,
    DXGI_ADAPTER_FLAG_SOFTWARE = 2,
}

struct DXGI_ADAPTER_DESC1
{
    ushort Description;
    uint VendorId;
    uint DeviceId;
    uint SubSysId;
    uint Revision;
    uint DedicatedVideoMemory;
    uint DedicatedSystemMemory;
    uint SharedSystemMemory;
    LUID AdapterLuid;
    uint Flags;
}

struct DXGI_DISPLAY_COLOR_SPACE
{
    float PrimaryCoordinates;
    float WhitePoints;
}

const GUID IID_IDXGIFactory1 = {0x770AAE78, 0xF26F, 0x4DBA, [0xA8, 0x29, 0x25, 0x3C, 0x83, 0xD1, 0xB3, 0x87]};
@GUID(0x770AAE78, 0xF26F, 0x4DBA, [0xA8, 0x29, 0x25, 0x3C, 0x83, 0xD1, 0xB3, 0x87]);
interface IDXGIFactory1 : IDXGIFactory
{
    HRESULT EnumAdapters1(uint Adapter, IDXGIAdapter1* ppAdapter);
    BOOL IsCurrent();
}

const GUID IID_IDXGIAdapter1 = {0x29038F61, 0x3839, 0x4626, [0x91, 0xFD, 0x08, 0x68, 0x79, 0x01, 0x1A, 0x05]};
@GUID(0x29038F61, 0x3839, 0x4626, [0x91, 0xFD, 0x08, 0x68, 0x79, 0x01, 0x1A, 0x05]);
interface IDXGIAdapter1 : IDXGIAdapter
{
    HRESULT GetDesc1(DXGI_ADAPTER_DESC1* pDesc);
}

const GUID IID_IDXGIDevice1 = {0x77DB970F, 0x6276, 0x48BA, [0xBA, 0x28, 0x07, 0x01, 0x43, 0xB4, 0x39, 0x2C]};
@GUID(0x77DB970F, 0x6276, 0x48BA, [0xBA, 0x28, 0x07, 0x01, 0x43, 0xB4, 0x39, 0x2C]);
interface IDXGIDevice1 : IDXGIDevice
{
    HRESULT SetMaximumFrameLatency(uint MaxLatency);
    HRESULT GetMaximumFrameLatency(uint* pMaxLatency);
}

const GUID IID_IDXGIDisplayControl = {0xEA9DBF1A, 0xC88E, 0x4486, [0x85, 0x4A, 0x98, 0xAA, 0x01, 0x38, 0xF3, 0x0C]};
@GUID(0xEA9DBF1A, 0xC88E, 0x4486, [0x85, 0x4A, 0x98, 0xAA, 0x01, 0x38, 0xF3, 0x0C]);
interface IDXGIDisplayControl : IUnknown
{
    BOOL IsStereoEnabled();
    void SetStereoEnabled(BOOL enabled);
}

struct DXGI_OUTDUPL_MOVE_RECT
{
    POINT SourcePoint;
    RECT DestinationRect;
}

struct DXGI_OUTDUPL_DESC
{
    DXGI_MODE_DESC ModeDesc;
    DXGI_MODE_ROTATION Rotation;
    BOOL DesktopImageInSystemMemory;
}

struct DXGI_OUTDUPL_POINTER_POSITION
{
    POINT Position;
    BOOL Visible;
}

enum DXGI_OUTDUPL_POINTER_SHAPE_TYPE
{
    DXGI_OUTDUPL_POINTER_SHAPE_TYPE_MONOCHROME = 1,
    DXGI_OUTDUPL_POINTER_SHAPE_TYPE_COLOR = 2,
    DXGI_OUTDUPL_POINTER_SHAPE_TYPE_MASKED_COLOR = 4,
}

struct DXGI_OUTDUPL_POINTER_SHAPE_INFO
{
    uint Type;
    uint Width;
    uint Height;
    uint Pitch;
    POINT HotSpot;
}

struct DXGI_OUTDUPL_FRAME_INFO
{
    LARGE_INTEGER LastPresentTime;
    LARGE_INTEGER LastMouseUpdateTime;
    uint AccumulatedFrames;
    BOOL RectsCoalesced;
    BOOL ProtectedContentMaskedOut;
    DXGI_OUTDUPL_POINTER_POSITION PointerPosition;
    uint TotalMetadataBufferSize;
    uint PointerShapeBufferSize;
}

const GUID IID_IDXGIOutputDuplication = {0x191CFAC3, 0xA341, 0x470D, [0xB2, 0x6E, 0xA8, 0x64, 0xF4, 0x28, 0x31, 0x9C]};
@GUID(0x191CFAC3, 0xA341, 0x470D, [0xB2, 0x6E, 0xA8, 0x64, 0xF4, 0x28, 0x31, 0x9C]);
interface IDXGIOutputDuplication : IDXGIObject
{
    void GetDesc(DXGI_OUTDUPL_DESC* pDesc);
    HRESULT AcquireNextFrame(uint TimeoutInMilliseconds, DXGI_OUTDUPL_FRAME_INFO* pFrameInfo, IDXGIResource* ppDesktopResource);
    HRESULT GetFrameDirtyRects(uint DirtyRectsBufferSize, char* pDirtyRectsBuffer, uint* pDirtyRectsBufferSizeRequired);
    HRESULT GetFrameMoveRects(uint MoveRectsBufferSize, char* pMoveRectBuffer, uint* pMoveRectsBufferSizeRequired);
    HRESULT GetFramePointerShape(uint PointerShapeBufferSize, char* pPointerShapeBuffer, uint* pPointerShapeBufferSizeRequired, DXGI_OUTDUPL_POINTER_SHAPE_INFO* pPointerShapeInfo);
    HRESULT MapDesktopSurface(DXGI_MAPPED_RECT* pLockedRect);
    HRESULT UnMapDesktopSurface();
    HRESULT ReleaseFrame();
}

enum DXGI_ALPHA_MODE
{
    DXGI_ALPHA_MODE_UNSPECIFIED = 0,
    DXGI_ALPHA_MODE_PREMULTIPLIED = 1,
    DXGI_ALPHA_MODE_STRAIGHT = 2,
    DXGI_ALPHA_MODE_IGNORE = 3,
    DXGI_ALPHA_MODE_FORCE_DWORD = 4294967295,
}

const GUID IID_IDXGISurface2 = {0xABA496DD, 0xB617, 0x4CB8, [0xA8, 0x66, 0xBC, 0x44, 0xD7, 0xEB, 0x1F, 0xA2]};
@GUID(0xABA496DD, 0xB617, 0x4CB8, [0xA8, 0x66, 0xBC, 0x44, 0xD7, 0xEB, 0x1F, 0xA2]);
interface IDXGISurface2 : IDXGISurface1
{
    HRESULT GetResource(const(Guid)* riid, void** ppParentResource, uint* pSubresourceIndex);
}

const GUID IID_IDXGIResource1 = {0x30961379, 0x4609, 0x4A41, [0x99, 0x8E, 0x54, 0xFE, 0x56, 0x7E, 0xE0, 0xC1]};
@GUID(0x30961379, 0x4609, 0x4A41, [0x99, 0x8E, 0x54, 0xFE, 0x56, 0x7E, 0xE0, 0xC1]);
interface IDXGIResource1 : IDXGIResource
{
    HRESULT CreateSubresourceSurface(uint index, IDXGISurface2* ppSurface);
    HRESULT CreateSharedHandle(const(SECURITY_ATTRIBUTES)* pAttributes, uint dwAccess, const(wchar)* lpName, HANDLE* pHandle);
}

enum DXGI_OFFER_RESOURCE_PRIORITY
{
    DXGI_OFFER_RESOURCE_PRIORITY_LOW = 1,
    DXGI_OFFER_RESOURCE_PRIORITY_NORMAL = 2,
    DXGI_OFFER_RESOURCE_PRIORITY_HIGH = 3,
}

const GUID IID_IDXGIDevice2 = {0x05008617, 0xFBFD, 0x4051, [0xA7, 0x90, 0x14, 0x48, 0x84, 0xB4, 0xF6, 0xA9]};
@GUID(0x05008617, 0xFBFD, 0x4051, [0xA7, 0x90, 0x14, 0x48, 0x84, 0xB4, 0xF6, 0xA9]);
interface IDXGIDevice2 : IDXGIDevice1
{
    HRESULT OfferResources(uint NumResources, char* ppResources, DXGI_OFFER_RESOURCE_PRIORITY Priority);
    HRESULT ReclaimResources(uint NumResources, char* ppResources, char* pDiscarded);
    HRESULT EnqueueSetEvent(HANDLE hEvent);
}

struct DXGI_MODE_DESC1
{
    uint Width;
    uint Height;
    DXGI_RATIONAL RefreshRate;
    DXGI_FORMAT Format;
    DXGI_MODE_SCANLINE_ORDER ScanlineOrdering;
    DXGI_MODE_SCALING Scaling;
    BOOL Stereo;
}

enum DXGI_SCALING
{
    DXGI_SCALING_STRETCH = 0,
    DXGI_SCALING_NONE = 1,
    DXGI_SCALING_ASPECT_RATIO_STRETCH = 2,
}

struct DXGI_SWAP_CHAIN_DESC1
{
    uint Width;
    uint Height;
    DXGI_FORMAT Format;
    BOOL Stereo;
    DXGI_SAMPLE_DESC SampleDesc;
    uint BufferUsage;
    uint BufferCount;
    DXGI_SCALING Scaling;
    DXGI_SWAP_EFFECT SwapEffect;
    DXGI_ALPHA_MODE AlphaMode;
    uint Flags;
}

struct DXGI_SWAP_CHAIN_FULLSCREEN_DESC
{
    DXGI_RATIONAL RefreshRate;
    DXGI_MODE_SCANLINE_ORDER ScanlineOrdering;
    DXGI_MODE_SCALING Scaling;
    BOOL Windowed;
}

struct DXGI_PRESENT_PARAMETERS
{
    uint DirtyRectsCount;
    RECT* pDirtyRects;
    RECT* pScrollRect;
    POINT* pScrollOffset;
}

const GUID IID_IDXGISwapChain1 = {0x790A45F7, 0x0D42, 0x4876, [0x98, 0x3A, 0x0A, 0x55, 0xCF, 0xE6, 0xF4, 0xAA]};
@GUID(0x790A45F7, 0x0D42, 0x4876, [0x98, 0x3A, 0x0A, 0x55, 0xCF, 0xE6, 0xF4, 0xAA]);
interface IDXGISwapChain1 : IDXGISwapChain
{
    HRESULT GetDesc1(DXGI_SWAP_CHAIN_DESC1* pDesc);
    HRESULT GetFullscreenDesc(DXGI_SWAP_CHAIN_FULLSCREEN_DESC* pDesc);
    HRESULT GetHwnd(HWND* pHwnd);
    HRESULT GetCoreWindow(const(Guid)* refiid, void** ppUnk);
    HRESULT Present1(uint SyncInterval, uint PresentFlags, const(DXGI_PRESENT_PARAMETERS)* pPresentParameters);
    BOOL IsTemporaryMonoSupported();
    HRESULT GetRestrictToOutput(IDXGIOutput* ppRestrictToOutput);
    HRESULT SetBackgroundColor(const(DXGI_RGBA)* pColor);
    HRESULT GetBackgroundColor(DXGI_RGBA* pColor);
    HRESULT SetRotation(DXGI_MODE_ROTATION Rotation);
    HRESULT GetRotation(DXGI_MODE_ROTATION* pRotation);
}

const GUID IID_IDXGIFactory2 = {0x50C83A1C, 0xE072, 0x4C48, [0x87, 0xB0, 0x36, 0x30, 0xFA, 0x36, 0xA6, 0xD0]};
@GUID(0x50C83A1C, 0xE072, 0x4C48, [0x87, 0xB0, 0x36, 0x30, 0xFA, 0x36, 0xA6, 0xD0]);
interface IDXGIFactory2 : IDXGIFactory1
{
    BOOL IsWindowedStereoEnabled();
    HRESULT CreateSwapChainForHwnd(IUnknown pDevice, HWND hWnd, const(DXGI_SWAP_CHAIN_DESC1)* pDesc, const(DXGI_SWAP_CHAIN_FULLSCREEN_DESC)* pFullscreenDesc, IDXGIOutput pRestrictToOutput, IDXGISwapChain1* ppSwapChain);
    HRESULT CreateSwapChainForCoreWindow(IUnknown pDevice, IUnknown pWindow, const(DXGI_SWAP_CHAIN_DESC1)* pDesc, IDXGIOutput pRestrictToOutput, IDXGISwapChain1* ppSwapChain);
    HRESULT GetSharedResourceAdapterLuid(HANDLE hResource, LUID* pLuid);
    HRESULT RegisterStereoStatusWindow(HWND WindowHandle, uint wMsg, uint* pdwCookie);
    HRESULT RegisterStereoStatusEvent(HANDLE hEvent, uint* pdwCookie);
    void UnregisterStereoStatus(uint dwCookie);
    HRESULT RegisterOcclusionStatusWindow(HWND WindowHandle, uint wMsg, uint* pdwCookie);
    HRESULT RegisterOcclusionStatusEvent(HANDLE hEvent, uint* pdwCookie);
    void UnregisterOcclusionStatus(uint dwCookie);
    HRESULT CreateSwapChainForComposition(IUnknown pDevice, const(DXGI_SWAP_CHAIN_DESC1)* pDesc, IDXGIOutput pRestrictToOutput, IDXGISwapChain1* ppSwapChain);
}

enum DXGI_GRAPHICS_PREEMPTION_GRANULARITY
{
    DXGI_GRAPHICS_PREEMPTION_DMA_BUFFER_BOUNDARY = 0,
    DXGI_GRAPHICS_PREEMPTION_PRIMITIVE_BOUNDARY = 1,
    DXGI_GRAPHICS_PREEMPTION_TRIANGLE_BOUNDARY = 2,
    DXGI_GRAPHICS_PREEMPTION_PIXEL_BOUNDARY = 3,
    DXGI_GRAPHICS_PREEMPTION_INSTRUCTION_BOUNDARY = 4,
}

enum DXGI_COMPUTE_PREEMPTION_GRANULARITY
{
    DXGI_COMPUTE_PREEMPTION_DMA_BUFFER_BOUNDARY = 0,
    DXGI_COMPUTE_PREEMPTION_DISPATCH_BOUNDARY = 1,
    DXGI_COMPUTE_PREEMPTION_THREAD_GROUP_BOUNDARY = 2,
    DXGI_COMPUTE_PREEMPTION_THREAD_BOUNDARY = 3,
    DXGI_COMPUTE_PREEMPTION_INSTRUCTION_BOUNDARY = 4,
}

struct DXGI_ADAPTER_DESC2
{
    ushort Description;
    uint VendorId;
    uint DeviceId;
    uint SubSysId;
    uint Revision;
    uint DedicatedVideoMemory;
    uint DedicatedSystemMemory;
    uint SharedSystemMemory;
    LUID AdapterLuid;
    uint Flags;
    DXGI_GRAPHICS_PREEMPTION_GRANULARITY GraphicsPreemptionGranularity;
    DXGI_COMPUTE_PREEMPTION_GRANULARITY ComputePreemptionGranularity;
}

const GUID IID_IDXGIAdapter2 = {0x0AA1AE0A, 0xFA0E, 0x4B84, [0x86, 0x44, 0xE0, 0x5F, 0xF8, 0xE5, 0xAC, 0xB5]};
@GUID(0x0AA1AE0A, 0xFA0E, 0x4B84, [0x86, 0x44, 0xE0, 0x5F, 0xF8, 0xE5, 0xAC, 0xB5]);
interface IDXGIAdapter2 : IDXGIAdapter1
{
    HRESULT GetDesc2(DXGI_ADAPTER_DESC2* pDesc);
}

const GUID IID_IDXGIOutput1 = {0x00CDDEA8, 0x939B, 0x4B83, [0xA3, 0x40, 0xA6, 0x85, 0x22, 0x66, 0x66, 0xCC]};
@GUID(0x00CDDEA8, 0x939B, 0x4B83, [0xA3, 0x40, 0xA6, 0x85, 0x22, 0x66, 0x66, 0xCC]);
interface IDXGIOutput1 : IDXGIOutput
{
    HRESULT GetDisplayModeList1(DXGI_FORMAT EnumFormat, uint Flags, uint* pNumModes, char* pDesc);
    HRESULT FindClosestMatchingMode1(const(DXGI_MODE_DESC1)* pModeToMatch, DXGI_MODE_DESC1* pClosestMatch, IUnknown pConcernedDevice);
    HRESULT GetDisplaySurfaceData1(IDXGIResource pDestination);
    HRESULT DuplicateOutput(IUnknown pDevice, IDXGIOutputDuplication* ppOutputDuplication);
}

const GUID IID_IDXGIDevice3 = {0x6007896C, 0x3244, 0x4AFD, [0xBF, 0x18, 0xA6, 0xD3, 0xBE, 0xDA, 0x50, 0x23]};
@GUID(0x6007896C, 0x3244, 0x4AFD, [0xBF, 0x18, 0xA6, 0xD3, 0xBE, 0xDA, 0x50, 0x23]);
interface IDXGIDevice3 : IDXGIDevice2
{
    void Trim();
}

struct DXGI_MATRIX_3X2_F
{
    float _11;
    float _12;
    float _21;
    float _22;
    float _31;
    float _32;
}

const GUID IID_IDXGISwapChain2 = {0xA8BE2AC4, 0x199F, 0x4946, [0xB3, 0x31, 0x79, 0x59, 0x9F, 0xB9, 0x8D, 0xE7]};
@GUID(0xA8BE2AC4, 0x199F, 0x4946, [0xB3, 0x31, 0x79, 0x59, 0x9F, 0xB9, 0x8D, 0xE7]);
interface IDXGISwapChain2 : IDXGISwapChain1
{
    HRESULT SetSourceSize(uint Width, uint Height);
    HRESULT GetSourceSize(uint* pWidth, uint* pHeight);
    HRESULT SetMaximumFrameLatency(uint MaxLatency);
    HRESULT GetMaximumFrameLatency(uint* pMaxLatency);
    HANDLE GetFrameLatencyWaitableObject();
    HRESULT SetMatrixTransform(const(DXGI_MATRIX_3X2_F)* pMatrix);
    HRESULT GetMatrixTransform(DXGI_MATRIX_3X2_F* pMatrix);
}

const GUID IID_IDXGIOutput2 = {0x595E39D1, 0x2724, 0x4663, [0x99, 0xB1, 0xDA, 0x96, 0x9D, 0xE2, 0x83, 0x64]};
@GUID(0x595E39D1, 0x2724, 0x4663, [0x99, 0xB1, 0xDA, 0x96, 0x9D, 0xE2, 0x83, 0x64]);
interface IDXGIOutput2 : IDXGIOutput1
{
    BOOL SupportsOverlays();
}

const GUID IID_IDXGIFactory3 = {0x25483823, 0xCD46, 0x4C7D, [0x86, 0xCA, 0x47, 0xAA, 0x95, 0xB8, 0x37, 0xBD]};
@GUID(0x25483823, 0xCD46, 0x4C7D, [0x86, 0xCA, 0x47, 0xAA, 0x95, 0xB8, 0x37, 0xBD]);
interface IDXGIFactory3 : IDXGIFactory2
{
    uint GetCreationFlags();
}

struct DXGI_DECODE_SWAP_CHAIN_DESC
{
    uint Flags;
}

enum DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAGS
{
    DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAG_NOMINAL_RANGE = 1,
    DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAG_BT709 = 2,
    DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAG_xvYCC = 4,
}

const GUID IID_IDXGIDecodeSwapChain = {0x2633066B, 0x4514, 0x4C7A, [0x8F, 0xD8, 0x12, 0xEA, 0x98, 0x05, 0x9D, 0x18]};
@GUID(0x2633066B, 0x4514, 0x4C7A, [0x8F, 0xD8, 0x12, 0xEA, 0x98, 0x05, 0x9D, 0x18]);
interface IDXGIDecodeSwapChain : IUnknown
{
    HRESULT PresentBuffer(uint BufferToPresent, uint SyncInterval, uint Flags);
    HRESULT SetSourceRect(const(RECT)* pRect);
    HRESULT SetTargetRect(const(RECT)* pRect);
    HRESULT SetDestSize(uint Width, uint Height);
    HRESULT GetSourceRect(RECT* pRect);
    HRESULT GetTargetRect(RECT* pRect);
    HRESULT GetDestSize(uint* pWidth, uint* pHeight);
    HRESULT SetColorSpace(DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAGS ColorSpace);
    DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAGS GetColorSpace();
}

const GUID IID_IDXGIFactoryMedia = {0x41E7D1F2, 0xA591, 0x4F7B, [0xA2, 0xE5, 0xFA, 0x9C, 0x84, 0x3E, 0x1C, 0x12]};
@GUID(0x41E7D1F2, 0xA591, 0x4F7B, [0xA2, 0xE5, 0xFA, 0x9C, 0x84, 0x3E, 0x1C, 0x12]);
interface IDXGIFactoryMedia : IUnknown
{
    HRESULT CreateSwapChainForCompositionSurfaceHandle(IUnknown pDevice, HANDLE hSurface, const(DXGI_SWAP_CHAIN_DESC1)* pDesc, IDXGIOutput pRestrictToOutput, IDXGISwapChain1* ppSwapChain);
    HRESULT CreateDecodeSwapChainForCompositionSurfaceHandle(IUnknown pDevice, HANDLE hSurface, DXGI_DECODE_SWAP_CHAIN_DESC* pDesc, IDXGIResource pYuvDecodeBuffers, IDXGIOutput pRestrictToOutput, IDXGIDecodeSwapChain* ppSwapChain);
}

enum DXGI_FRAME_PRESENTATION_MODE
{
    DXGI_FRAME_PRESENTATION_MODE_COMPOSED = 0,
    DXGI_FRAME_PRESENTATION_MODE_OVERLAY = 1,
    DXGI_FRAME_PRESENTATION_MODE_NONE = 2,
    DXGI_FRAME_PRESENTATION_MODE_COMPOSITION_FAILURE = 3,
}

struct DXGI_FRAME_STATISTICS_MEDIA
{
    uint PresentCount;
    uint PresentRefreshCount;
    uint SyncRefreshCount;
    LARGE_INTEGER SyncQPCTime;
    LARGE_INTEGER SyncGPUTime;
    DXGI_FRAME_PRESENTATION_MODE CompositionMode;
    uint ApprovedPresentDuration;
}

const GUID IID_IDXGISwapChainMedia = {0xDD95B90B, 0xF05F, 0x4F6A, [0xBD, 0x65, 0x25, 0xBF, 0xB2, 0x64, 0xBD, 0x84]};
@GUID(0xDD95B90B, 0xF05F, 0x4F6A, [0xBD, 0x65, 0x25, 0xBF, 0xB2, 0x64, 0xBD, 0x84]);
interface IDXGISwapChainMedia : IUnknown
{
    HRESULT GetFrameStatisticsMedia(DXGI_FRAME_STATISTICS_MEDIA* pStats);
    HRESULT SetPresentDuration(uint Duration);
    HRESULT CheckPresentDurationSupport(uint DesiredPresentDuration, uint* pClosestSmallerPresentDuration, uint* pClosestLargerPresentDuration);
}

enum DXGI_OVERLAY_SUPPORT_FLAG
{
    DXGI_OVERLAY_SUPPORT_FLAG_DIRECT = 1,
    DXGI_OVERLAY_SUPPORT_FLAG_SCALING = 2,
}

const GUID IID_IDXGIOutput3 = {0x8A6BB301, 0x7E7E, 0x41F4, [0xA8, 0xE0, 0x5B, 0x32, 0xF7, 0xF9, 0x9B, 0x18]};
@GUID(0x8A6BB301, 0x7E7E, 0x41F4, [0xA8, 0xE0, 0x5B, 0x32, 0xF7, 0xF9, 0x9B, 0x18]);
interface IDXGIOutput3 : IDXGIOutput2
{
    HRESULT CheckOverlaySupport(DXGI_FORMAT EnumFormat, IUnknown pConcernedDevice, uint* pFlags);
}

enum DXGI_SWAP_CHAIN_COLOR_SPACE_SUPPORT_FLAG
{
    DXGI_SWAP_CHAIN_COLOR_SPACE_SUPPORT_FLAG_PRESENT = 1,
    DXGI_SWAP_CHAIN_COLOR_SPACE_SUPPORT_FLAG_OVERLAY_PRESENT = 2,
}

const GUID IID_IDXGISwapChain3 = {0x94D99BDB, 0xF1F8, 0x4AB0, [0xB2, 0x36, 0x7D, 0xA0, 0x17, 0x0E, 0xDA, 0xB1]};
@GUID(0x94D99BDB, 0xF1F8, 0x4AB0, [0xB2, 0x36, 0x7D, 0xA0, 0x17, 0x0E, 0xDA, 0xB1]);
interface IDXGISwapChain3 : IDXGISwapChain2
{
    uint GetCurrentBackBufferIndex();
    HRESULT CheckColorSpaceSupport(DXGI_COLOR_SPACE_TYPE ColorSpace, uint* pColorSpaceSupport);
    HRESULT SetColorSpace1(DXGI_COLOR_SPACE_TYPE ColorSpace);
    HRESULT ResizeBuffers1(uint BufferCount, uint Width, uint Height, DXGI_FORMAT Format, uint SwapChainFlags, char* pCreationNodeMask, char* ppPresentQueue);
}

enum DXGI_OVERLAY_COLOR_SPACE_SUPPORT_FLAG
{
    DXGI_OVERLAY_COLOR_SPACE_SUPPORT_FLAG_PRESENT = 1,
}

const GUID IID_IDXGIOutput4 = {0xDC7DCA35, 0x2196, 0x414D, [0x9F, 0x53, 0x61, 0x78, 0x84, 0x03, 0x2A, 0x60]};
@GUID(0xDC7DCA35, 0x2196, 0x414D, [0x9F, 0x53, 0x61, 0x78, 0x84, 0x03, 0x2A, 0x60]);
interface IDXGIOutput4 : IDXGIOutput3
{
    HRESULT CheckOverlayColorSpaceSupport(DXGI_FORMAT Format, DXGI_COLOR_SPACE_TYPE ColorSpace, IUnknown pConcernedDevice, uint* pFlags);
}

const GUID IID_IDXGIFactory4 = {0x1BC6EA02, 0xEF36, 0x464F, [0xBF, 0x0C, 0x21, 0xCA, 0x39, 0xE5, 0x16, 0x8A]};
@GUID(0x1BC6EA02, 0xEF36, 0x464F, [0xBF, 0x0C, 0x21, 0xCA, 0x39, 0xE5, 0x16, 0x8A]);
interface IDXGIFactory4 : IDXGIFactory3
{
    HRESULT EnumAdapterByLuid(LUID AdapterLuid, const(Guid)* riid, void** ppvAdapter);
    HRESULT EnumWarpAdapter(const(Guid)* riid, void** ppvAdapter);
}

enum DXGI_MEMORY_SEGMENT_GROUP
{
    DXGI_MEMORY_SEGMENT_GROUP_LOCAL = 0,
    DXGI_MEMORY_SEGMENT_GROUP_NON_LOCAL = 1,
}

struct DXGI_QUERY_VIDEO_MEMORY_INFO
{
    ulong Budget;
    ulong CurrentUsage;
    ulong AvailableForReservation;
    ulong CurrentReservation;
}

const GUID IID_IDXGIAdapter3 = {0x645967A4, 0x1392, 0x4310, [0xA7, 0x98, 0x80, 0x53, 0xCE, 0x3E, 0x93, 0xFD]};
@GUID(0x645967A4, 0x1392, 0x4310, [0xA7, 0x98, 0x80, 0x53, 0xCE, 0x3E, 0x93, 0xFD]);
interface IDXGIAdapter3 : IDXGIAdapter2
{
    HRESULT RegisterHardwareContentProtectionTeardownStatusEvent(HANDLE hEvent, uint* pdwCookie);
    void UnregisterHardwareContentProtectionTeardownStatus(uint dwCookie);
    HRESULT QueryVideoMemoryInfo(uint NodeIndex, DXGI_MEMORY_SEGMENT_GROUP MemorySegmentGroup, DXGI_QUERY_VIDEO_MEMORY_INFO* pVideoMemoryInfo);
    HRESULT SetVideoMemoryReservation(uint NodeIndex, DXGI_MEMORY_SEGMENT_GROUP MemorySegmentGroup, ulong Reservation);
    HRESULT RegisterVideoMemoryBudgetChangeNotificationEvent(HANDLE hEvent, uint* pdwCookie);
    void UnregisterVideoMemoryBudgetChangeNotification(uint dwCookie);
}

enum DXGI_OUTDUPL_FLAG
{
    DXGI_OUTDUPL_COMPOSITED_UI_CAPTURE_ONLY = 1,
}

const GUID IID_IDXGIOutput5 = {0x80A07424, 0xAB52, 0x42EB, [0x83, 0x3C, 0x0C, 0x42, 0xFD, 0x28, 0x2D, 0x98]};
@GUID(0x80A07424, 0xAB52, 0x42EB, [0x83, 0x3C, 0x0C, 0x42, 0xFD, 0x28, 0x2D, 0x98]);
interface IDXGIOutput5 : IDXGIOutput4
{
    HRESULT DuplicateOutput1(IUnknown pDevice, uint Flags, uint SupportedFormatsCount, char* pSupportedFormats, IDXGIOutputDuplication* ppOutputDuplication);
}

enum DXGI_HDR_METADATA_TYPE
{
    DXGI_HDR_METADATA_TYPE_NONE = 0,
    DXGI_HDR_METADATA_TYPE_HDR10 = 1,
    DXGI_HDR_METADATA_TYPE_HDR10PLUS = 2,
}

struct DXGI_HDR_METADATA_HDR10
{
    ushort RedPrimary;
    ushort GreenPrimary;
    ushort BluePrimary;
    ushort WhitePoint;
    uint MaxMasteringLuminance;
    uint MinMasteringLuminance;
    ushort MaxContentLightLevel;
    ushort MaxFrameAverageLightLevel;
}

struct DXGI_HDR_METADATA_HDR10PLUS
{
    ubyte Data;
}

const GUID IID_IDXGISwapChain4 = {0x3D585D5A, 0xBD4A, 0x489E, [0xB1, 0xF4, 0x3D, 0xBC, 0xB6, 0x45, 0x2F, 0xFB]};
@GUID(0x3D585D5A, 0xBD4A, 0x489E, [0xB1, 0xF4, 0x3D, 0xBC, 0xB6, 0x45, 0x2F, 0xFB]);
interface IDXGISwapChain4 : IDXGISwapChain3
{
    HRESULT SetHDRMetaData(DXGI_HDR_METADATA_TYPE Type, uint Size, char* pMetaData);
}

enum DXGI_OFFER_RESOURCE_FLAGS
{
    DXGI_OFFER_RESOURCE_FLAG_ALLOW_DECOMMIT = 1,
}

enum DXGI_RECLAIM_RESOURCE_RESULTS
{
    DXGI_RECLAIM_RESOURCE_RESULT_OK = 0,
    DXGI_RECLAIM_RESOURCE_RESULT_DISCARDED = 1,
    DXGI_RECLAIM_RESOURCE_RESULT_NOT_COMMITTED = 2,
}

const GUID IID_IDXGIDevice4 = {0x95B4F95F, 0xD8DA, 0x4CA4, [0x9E, 0xE6, 0x3B, 0x76, 0xD5, 0x96, 0x8A, 0x10]};
@GUID(0x95B4F95F, 0xD8DA, 0x4CA4, [0x9E, 0xE6, 0x3B, 0x76, 0xD5, 0x96, 0x8A, 0x10]);
interface IDXGIDevice4 : IDXGIDevice3
{
    HRESULT OfferResources1(uint NumResources, char* ppResources, DXGI_OFFER_RESOURCE_PRIORITY Priority, uint Flags);
    HRESULT ReclaimResources1(uint NumResources, char* ppResources, char* pResults);
}

enum DXGI_FEATURE
{
    DXGI_FEATURE_PRESENT_ALLOW_TEARING = 0,
}

const GUID IID_IDXGIFactory5 = {0x7632E1F5, 0xEE65, 0x4DCA, [0x87, 0xFD, 0x84, 0xCD, 0x75, 0xF8, 0x83, 0x8D]};
@GUID(0x7632E1F5, 0xEE65, 0x4DCA, [0x87, 0xFD, 0x84, 0xCD, 0x75, 0xF8, 0x83, 0x8D]);
interface IDXGIFactory5 : IDXGIFactory4
{
    HRESULT CheckFeatureSupport(DXGI_FEATURE Feature, char* pFeatureSupportData, uint FeatureSupportDataSize);
}

enum DXGI_ADAPTER_FLAG3
{
    DXGI_ADAPTER_FLAG3_NONE = 0,
    DXGI_ADAPTER_FLAG3_REMOTE = 1,
    DXGI_ADAPTER_FLAG3_SOFTWARE = 2,
    DXGI_ADAPTER_FLAG3_ACG_COMPATIBLE = 4,
    DXGI_ADAPTER_FLAG3_SUPPORT_MONITORED_FENCES = 8,
    DXGI_ADAPTER_FLAG3_SUPPORT_NON_MONITORED_FENCES = 16,
    DXGI_ADAPTER_FLAG3_KEYED_MUTEX_CONFORMANCE = 32,
    DXGI_ADAPTER_FLAG3_FORCE_DWORD = 4294967295,
}

struct DXGI_ADAPTER_DESC3
{
    ushort Description;
    uint VendorId;
    uint DeviceId;
    uint SubSysId;
    uint Revision;
    uint DedicatedVideoMemory;
    uint DedicatedSystemMemory;
    uint SharedSystemMemory;
    LUID AdapterLuid;
    DXGI_ADAPTER_FLAG3 Flags;
    DXGI_GRAPHICS_PREEMPTION_GRANULARITY GraphicsPreemptionGranularity;
    DXGI_COMPUTE_PREEMPTION_GRANULARITY ComputePreemptionGranularity;
}

const GUID IID_IDXGIAdapter4 = {0x3C8D99D1, 0x4FBF, 0x4181, [0xA8, 0x2C, 0xAF, 0x66, 0xBF, 0x7B, 0xD2, 0x4E]};
@GUID(0x3C8D99D1, 0x4FBF, 0x4181, [0xA8, 0x2C, 0xAF, 0x66, 0xBF, 0x7B, 0xD2, 0x4E]);
interface IDXGIAdapter4 : IDXGIAdapter3
{
    HRESULT GetDesc3(DXGI_ADAPTER_DESC3* pDesc);
}

struct DXGI_OUTPUT_DESC1
{
    ushort DeviceName;
    RECT DesktopCoordinates;
    BOOL AttachedToDesktop;
    DXGI_MODE_ROTATION Rotation;
    int Monitor;
    uint BitsPerColor;
    DXGI_COLOR_SPACE_TYPE ColorSpace;
    float RedPrimary;
    float GreenPrimary;
    float BluePrimary;
    float WhitePoint;
    float MinLuminance;
    float MaxLuminance;
    float MaxFullFrameLuminance;
}

enum DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAGS
{
    DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAG_FULLSCREEN = 1,
    DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAG_WINDOWED = 2,
    DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAG_CURSOR_STRETCHED = 4,
}

const GUID IID_IDXGIOutput6 = {0x068346E8, 0xAAEC, 0x4B84, [0xAD, 0xD7, 0x13, 0x7F, 0x51, 0x3F, 0x77, 0xA1]};
@GUID(0x068346E8, 0xAAEC, 0x4B84, [0xAD, 0xD7, 0x13, 0x7F, 0x51, 0x3F, 0x77, 0xA1]);
interface IDXGIOutput6 : IDXGIOutput5
{
    HRESULT GetDesc1(DXGI_OUTPUT_DESC1* pDesc);
    HRESULT CheckHardwareCompositionSupport(uint* pFlags);
}

enum DXGI_GPU_PREFERENCE
{
    DXGI_GPU_PREFERENCE_UNSPECIFIED = 0,
    DXGI_GPU_PREFERENCE_MINIMUM_POWER = 1,
    DXGI_GPU_PREFERENCE_HIGH_PERFORMANCE = 2,
}

const GUID IID_IDXGIFactory6 = {0xC1B6694F, 0xFF09, 0x44A9, [0xB0, 0x3C, 0x77, 0x90, 0x0A, 0x0A, 0x1D, 0x17]};
@GUID(0xC1B6694F, 0xFF09, 0x44A9, [0xB0, 0x3C, 0x77, 0x90, 0x0A, 0x0A, 0x1D, 0x17]);
interface IDXGIFactory6 : IDXGIFactory5
{
    HRESULT EnumAdapterByGpuPreference(uint Adapter, DXGI_GPU_PREFERENCE GpuPreference, const(Guid)* riid, void** ppvAdapter);
}

const GUID IID_IDXGIFactory7 = {0xA4966EED, 0x76DB, 0x44DA, [0x84, 0xC1, 0xEE, 0x9A, 0x7A, 0xFB, 0x20, 0xA8]};
@GUID(0xA4966EED, 0x76DB, 0x44DA, [0x84, 0xC1, 0xEE, 0x9A, 0x7A, 0xFB, 0x20, 0xA8]);
interface IDXGIFactory7 : IDXGIFactory6
{
    HRESULT RegisterAdaptersChangedEvent(HANDLE hEvent, uint* pdwCookie);
    HRESULT UnregisterAdaptersChangedEvent(uint dwCookie);
}

enum DXGI_DEBUG_RLO_FLAGS
{
    DXGI_DEBUG_RLO_SUMMARY = 1,
    DXGI_DEBUG_RLO_DETAIL = 2,
    DXGI_DEBUG_RLO_IGNORE_INTERNAL = 4,
    DXGI_DEBUG_RLO_ALL = 7,
}

enum DXGI_INFO_QUEUE_MESSAGE_CATEGORY
{
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_UNKNOWN = 0,
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_MISCELLANEOUS = 1,
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_INITIALIZATION = 2,
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_CLEANUP = 3,
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_COMPILATION = 4,
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_STATE_CREATION = 5,
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_STATE_SETTING = 6,
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_STATE_GETTING = 7,
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_RESOURCE_MANIPULATION = 8,
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_EXECUTION = 9,
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_SHADER = 10,
}

enum DXGI_INFO_QUEUE_MESSAGE_SEVERITY
{
    DXGI_INFO_QUEUE_MESSAGE_SEVERITY_CORRUPTION = 0,
    DXGI_INFO_QUEUE_MESSAGE_SEVERITY_ERROR = 1,
    DXGI_INFO_QUEUE_MESSAGE_SEVERITY_WARNING = 2,
    DXGI_INFO_QUEUE_MESSAGE_SEVERITY_INFO = 3,
    DXGI_INFO_QUEUE_MESSAGE_SEVERITY_MESSAGE = 4,
}

struct DXGI_INFO_QUEUE_MESSAGE
{
    Guid Producer;
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY Category;
    DXGI_INFO_QUEUE_MESSAGE_SEVERITY Severity;
    int ID;
    const(byte)* pDescription;
    uint DescriptionByteLength;
}

struct DXGI_INFO_QUEUE_FILTER_DESC
{
    uint NumCategories;
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY* pCategoryList;
    uint NumSeverities;
    DXGI_INFO_QUEUE_MESSAGE_SEVERITY* pSeverityList;
    uint NumIDs;
    int* pIDList;
}

struct DXGI_INFO_QUEUE_FILTER
{
    DXGI_INFO_QUEUE_FILTER_DESC AllowList;
    DXGI_INFO_QUEUE_FILTER_DESC DenyList;
}

const GUID IID_IDXGIInfoQueue = {0xD67441C7, 0x672A, 0x476F, [0x9E, 0x82, 0xCD, 0x55, 0xB4, 0x49, 0x49, 0xCE]};
@GUID(0xD67441C7, 0x672A, 0x476F, [0x9E, 0x82, 0xCD, 0x55, 0xB4, 0x49, 0x49, 0xCE]);
interface IDXGIInfoQueue : IUnknown
{
    HRESULT SetMessageCountLimit(Guid Producer, ulong MessageCountLimit);
    void ClearStoredMessages(Guid Producer);
    HRESULT GetMessageA(Guid Producer, ulong MessageIndex, char* pMessage, uint* pMessageByteLength);
    ulong GetNumStoredMessagesAllowedByRetrievalFilters(Guid Producer);
    ulong GetNumStoredMessages(Guid Producer);
    ulong GetNumMessagesDiscardedByMessageCountLimit(Guid Producer);
    ulong GetMessageCountLimit(Guid Producer);
    ulong GetNumMessagesAllowedByStorageFilter(Guid Producer);
    ulong GetNumMessagesDeniedByStorageFilter(Guid Producer);
    HRESULT AddStorageFilterEntries(Guid Producer, DXGI_INFO_QUEUE_FILTER* pFilter);
    HRESULT GetStorageFilter(Guid Producer, char* pFilter, uint* pFilterByteLength);
    void ClearStorageFilter(Guid Producer);
    HRESULT PushEmptyStorageFilter(Guid Producer);
    HRESULT PushDenyAllStorageFilter(Guid Producer);
    HRESULT PushCopyOfStorageFilter(Guid Producer);
    HRESULT PushStorageFilter(Guid Producer, DXGI_INFO_QUEUE_FILTER* pFilter);
    void PopStorageFilter(Guid Producer);
    uint GetStorageFilterStackSize(Guid Producer);
    HRESULT AddRetrievalFilterEntries(Guid Producer, DXGI_INFO_QUEUE_FILTER* pFilter);
    HRESULT GetRetrievalFilter(Guid Producer, char* pFilter, uint* pFilterByteLength);
    void ClearRetrievalFilter(Guid Producer);
    HRESULT PushEmptyRetrievalFilter(Guid Producer);
    HRESULT PushDenyAllRetrievalFilter(Guid Producer);
    HRESULT PushCopyOfRetrievalFilter(Guid Producer);
    HRESULT PushRetrievalFilter(Guid Producer, DXGI_INFO_QUEUE_FILTER* pFilter);
    void PopRetrievalFilter(Guid Producer);
    uint GetRetrievalFilterStackSize(Guid Producer);
    HRESULT AddMessage(Guid Producer, DXGI_INFO_QUEUE_MESSAGE_CATEGORY Category, DXGI_INFO_QUEUE_MESSAGE_SEVERITY Severity, int ID, const(char)* pDescription);
    HRESULT AddApplicationMessage(DXGI_INFO_QUEUE_MESSAGE_SEVERITY Severity, const(char)* pDescription);
    HRESULT SetBreakOnCategory(Guid Producer, DXGI_INFO_QUEUE_MESSAGE_CATEGORY Category, BOOL bEnable);
    HRESULT SetBreakOnSeverity(Guid Producer, DXGI_INFO_QUEUE_MESSAGE_SEVERITY Severity, BOOL bEnable);
    HRESULT SetBreakOnID(Guid Producer, int ID, BOOL bEnable);
    BOOL GetBreakOnCategory(Guid Producer, DXGI_INFO_QUEUE_MESSAGE_CATEGORY Category);
    BOOL GetBreakOnSeverity(Guid Producer, DXGI_INFO_QUEUE_MESSAGE_SEVERITY Severity);
    BOOL GetBreakOnID(Guid Producer, int ID);
    void SetMuteDebugOutput(Guid Producer, BOOL bMute);
    BOOL GetMuteDebugOutput(Guid Producer);
}

const GUID IID_IDXGIDebug = {0x119E7452, 0xDE9E, 0x40FE, [0x88, 0x06, 0x88, 0xF9, 0x0C, 0x12, 0xB4, 0x41]};
@GUID(0x119E7452, 0xDE9E, 0x40FE, [0x88, 0x06, 0x88, 0xF9, 0x0C, 0x12, 0xB4, 0x41]);
interface IDXGIDebug : IUnknown
{
    HRESULT ReportLiveObjects(Guid apiid, DXGI_DEBUG_RLO_FLAGS flags);
}

const GUID IID_IDXGIDebug1 = {0xC5A05F0C, 0x16F2, 0x4ADF, [0x9F, 0x4D, 0xA8, 0xC4, 0xD5, 0x8A, 0xC5, 0x50]};
@GUID(0xC5A05F0C, 0x16F2, 0x4ADF, [0x9F, 0x4D, 0xA8, 0xC4, 0xD5, 0x8A, 0xC5, 0x50]);
interface IDXGIDebug1 : IDXGIDebug
{
    void EnableLeakTrackingForThread();
    void DisableLeakTrackingForThread();
    BOOL IsLeakTrackingEnabledForThread();
}

