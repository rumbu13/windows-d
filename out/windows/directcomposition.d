module windows.directcomposition;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.direct2d : D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE, D2D1_BLEND_MODE, D2D1_BORDER_MODE,
                                 D2D1_COLORMATRIX_ALPHA_MODE, D2D1_COMPOSITE_MODE, D2D1_TURBULENCE_NOISE,
                                 D2D_MATRIX_3X2_F, D2D_MATRIX_4X4_F, D2D_MATRIX_5X4_F, D2D_RECT_F, D2D_VECTOR_2F,
                                 D2D_VECTOR_4F;
public import windows.direct3d9 : D3DMATRIX;
public import windows.displaydevices : POINT, RECT;
public import windows.dxgi : DXGI_ALPHA_MODE, DXGI_FORMAT, DXGI_RATIONAL, DXGI_RGBA, IDXGIDevice;
public import windows.systemservices : BOOL, HANDLE, LARGE_INTEGER, SECURITY_ATTRIBUTES;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Enums


enum : int
{
    DCOMPOSITION_BITMAP_INTERPOLATION_MODE_NEAREST_NEIGHBOR = 0x00000000,
    DCOMPOSITION_BITMAP_INTERPOLATION_MODE_LINEAR           = 0x00000001,
    DCOMPOSITION_BITMAP_INTERPOLATION_MODE_INHERIT          = 0xffffffff,
}
alias DCOMPOSITION_BITMAP_INTERPOLATION_MODE = int;

enum : int
{
    DCOMPOSITION_BORDER_MODE_SOFT    = 0x00000000,
    DCOMPOSITION_BORDER_MODE_HARD    = 0x00000001,
    DCOMPOSITION_BORDER_MODE_INHERIT = 0xffffffff,
}
alias DCOMPOSITION_BORDER_MODE = int;

enum : int
{
    DCOMPOSITION_COMPOSITE_MODE_SOURCE_OVER        = 0x00000000,
    DCOMPOSITION_COMPOSITE_MODE_DESTINATION_INVERT = 0x00000001,
    DCOMPOSITION_COMPOSITE_MODE_MIN_BLEND          = 0x00000002,
    DCOMPOSITION_COMPOSITE_MODE_INHERIT            = 0xffffffff,
}
alias DCOMPOSITION_COMPOSITE_MODE = int;

enum : int
{
    DCOMPOSITION_BACKFACE_VISIBILITY_VISIBLE = 0x00000000,
    DCOMPOSITION_BACKFACE_VISIBILITY_HIDDEN  = 0x00000001,
    DCOMPOSITION_BACKFACE_VISIBILITY_INHERIT = 0xffffffff,
}
alias DCOMPOSITION_BACKFACE_VISIBILITY = int;

enum : int
{
    DCOMPOSITION_OPACITY_MODE_LAYER    = 0x00000000,
    DCOMPOSITION_OPACITY_MODE_MULTIPLY = 0x00000001,
    DCOMPOSITION_OPACITY_MODE_INHERIT  = 0xffffffff,
}
alias DCOMPOSITION_OPACITY_MODE = int;

enum : int
{
    DCOMPOSITION_DEPTH_MODE_TREE    = 0x00000000,
    DCOMPOSITION_DEPTH_MODE_SPATIAL = 0x00000001,
    DCOMPOSITION_DEPTH_MODE_SORTED  = 0x00000003,
    DCOMPOSITION_DEPTH_MODE_INHERIT = 0xffffffff,
}
alias DCOMPOSITION_DEPTH_MODE = int;

// Structs


struct DCOMPOSITION_FRAME_STATISTICS
{
    LARGE_INTEGER lastFrameTime;
    DXGI_RATIONAL currentCompositionRate;
    LARGE_INTEGER currentTime;
    LARGE_INTEGER timeFrequency;
    LARGE_INTEGER nextEstimatedFrameTime;
}

// Functions

@DllImport("dcomp")
HRESULT DCompositionCreateDevice(IDXGIDevice dxgiDevice, const(GUID)* iid, void** dcompositionDevice);

@DllImport("dcomp")
HRESULT DCompositionCreateDevice2(IUnknown renderingDevice, const(GUID)* iid, void** dcompositionDevice);

@DllImport("dcomp")
HRESULT DCompositionCreateDevice3(IUnknown renderingDevice, const(GUID)* iid, void** dcompositionDevice);

@DllImport("dcomp")
HRESULT DCompositionCreateSurfaceHandle(uint desiredAccess, SECURITY_ATTRIBUTES* securityAttributes, 
                                        HANDLE* surfaceHandle);

@DllImport("dcomp")
HRESULT DCompositionAttachMouseWheelToHwnd(IDCompositionVisual visual, HWND hwnd, BOOL enable);

@DllImport("dcomp")
HRESULT DCompositionAttachMouseDragToHwnd(IDCompositionVisual visual, HWND hwnd, BOOL enable);


// Interfaces

@GUID("CBFD91D9-51B2-45E4-B3DE-D19CCFB863C5")
interface IDCompositionAnimation : IUnknown
{
    HRESULT Reset();
    HRESULT SetAbsoluteBeginTime(LARGE_INTEGER beginTime);
    HRESULT AddCubic(double beginOffset, float constantCoefficient, float linearCoefficient, 
                     float quadraticCoefficient, float cubicCoefficient);
    HRESULT AddSinusoidal(double beginOffset, float bias, float amplitude, float frequency, float phase);
    HRESULT AddRepeat(double beginOffset, double durationToRepeat);
    HRESULT End(double endOffset, float endValue);
}

@GUID("C37EA93A-E7AA-450D-B16F-9746CB0407F3")
interface IDCompositionDevice : IUnknown
{
    HRESULT Commit();
    HRESULT WaitForCommitCompletion();
    HRESULT GetFrameStatistics(DCOMPOSITION_FRAME_STATISTICS* statistics);
    HRESULT CreateTargetForHwnd(HWND hwnd, BOOL topmost, IDCompositionTarget* target);
    HRESULT CreateVisual(IDCompositionVisual* visual);
    HRESULT CreateSurface(uint width, uint height, DXGI_FORMAT pixelFormat, DXGI_ALPHA_MODE alphaMode, 
                          IDCompositionSurface* surface);
    HRESULT CreateVirtualSurface(uint initialWidth, uint initialHeight, DXGI_FORMAT pixelFormat, 
                                 DXGI_ALPHA_MODE alphaMode, IDCompositionVirtualSurface* virtualSurface);
    HRESULT CreateSurfaceFromHandle(HANDLE handle, IUnknown* surface);
    HRESULT CreateSurfaceFromHwnd(HWND hwnd, IUnknown* surface);
    HRESULT CreateTranslateTransform(IDCompositionTranslateTransform* translateTransform);
    HRESULT CreateScaleTransform(IDCompositionScaleTransform* scaleTransform);
    HRESULT CreateRotateTransform(IDCompositionRotateTransform* rotateTransform);
    HRESULT CreateSkewTransform(IDCompositionSkewTransform* skewTransform);
    HRESULT CreateMatrixTransform(IDCompositionMatrixTransform* matrixTransform);
    HRESULT CreateTransformGroup(char* transforms, uint elements, IDCompositionTransform* transformGroup);
    HRESULT CreateTranslateTransform3D(IDCompositionTranslateTransform3D* translateTransform3D);
    HRESULT CreateScaleTransform3D(IDCompositionScaleTransform3D* scaleTransform3D);
    HRESULT CreateRotateTransform3D(IDCompositionRotateTransform3D* rotateTransform3D);
    HRESULT CreateMatrixTransform3D(IDCompositionMatrixTransform3D* matrixTransform3D);
    HRESULT CreateTransform3DGroup(char* transforms3D, uint elements, IDCompositionTransform3D* transform3DGroup);
    HRESULT CreateEffectGroup(IDCompositionEffectGroup* effectGroup);
    HRESULT CreateRectangleClip(IDCompositionRectangleClip* clip);
    HRESULT CreateAnimation(IDCompositionAnimation* animation);
    HRESULT CheckDeviceState(int* pfValid);
}

@GUID("EACDD04C-117E-4E17-88F4-D1B12B0E3D89")
interface IDCompositionTarget : IUnknown
{
    HRESULT SetRoot(IDCompositionVisual visual);
}

@GUID("4D93059D-097B-4651-9A60-F0F25116E2F3")
interface IDCompositionVisual : IUnknown
{
    HRESULT SetOffsetX(float offsetX);
    HRESULT SetOffsetX(IDCompositionAnimation animation);
    HRESULT SetOffsetY(float offsetY);
    HRESULT SetOffsetY(IDCompositionAnimation animation);
    HRESULT SetTransform(const(D2D_MATRIX_3X2_F)* matrix);
    HRESULT SetTransform(IDCompositionTransform transform);
    HRESULT SetTransformParent(IDCompositionVisual visual);
    HRESULT SetEffect(IDCompositionEffect effect);
    HRESULT SetBitmapInterpolationMode(DCOMPOSITION_BITMAP_INTERPOLATION_MODE interpolationMode);
    HRESULT SetBorderMode(DCOMPOSITION_BORDER_MODE borderMode);
    HRESULT SetClip(const(D2D_RECT_F)* rect);
    HRESULT SetClip(IDCompositionClip clip);
    HRESULT SetContent(IUnknown content);
    HRESULT AddVisual(IDCompositionVisual visual, BOOL insertAbove, IDCompositionVisual referenceVisual);
    HRESULT RemoveVisual(IDCompositionVisual visual);
    HRESULT RemoveAllVisuals();
    HRESULT SetCompositeMode(DCOMPOSITION_COMPOSITE_MODE compositeMode);
}

@GUID("EC81B08F-BFCB-4E8D-B193-A915587999E8")
interface IDCompositionEffect : IUnknown
{
}

@GUID("71185722-246B-41F2-AAD1-0443F7F4BFC2")
interface IDCompositionTransform3D : IDCompositionEffect
{
}

@GUID("FD55FAA7-37E0-4C20-95D2-9BE45BC33F55")
interface IDCompositionTransform : IDCompositionTransform3D
{
}

@GUID("06791122-C6F0-417D-8323-269E987F5954")
interface IDCompositionTranslateTransform : IDCompositionTransform
{
    HRESULT SetOffsetX(float offsetX);
    HRESULT SetOffsetX(IDCompositionAnimation animation);
    HRESULT SetOffsetY(float offsetY);
    HRESULT SetOffsetY(IDCompositionAnimation animation);
}

@GUID("71FDE914-40EF-45EF-BD51-68B037C339F9")
interface IDCompositionScaleTransform : IDCompositionTransform
{
    HRESULT SetScaleX(float scaleX);
    HRESULT SetScaleX(IDCompositionAnimation animation);
    HRESULT SetScaleY(float scaleY);
    HRESULT SetScaleY(IDCompositionAnimation animation);
    HRESULT SetCenterX(float centerX);
    HRESULT SetCenterX(IDCompositionAnimation animation);
    HRESULT SetCenterY(float centerY);
    HRESULT SetCenterY(IDCompositionAnimation animation);
}

@GUID("641ED83C-AE96-46C5-90DC-32774CC5C6D5")
interface IDCompositionRotateTransform : IDCompositionTransform
{
    HRESULT SetAngle(float angle);
    HRESULT SetAngle(IDCompositionAnimation animation);
    HRESULT SetCenterX(float centerX);
    HRESULT SetCenterX(IDCompositionAnimation animation);
    HRESULT SetCenterY(float centerY);
    HRESULT SetCenterY(IDCompositionAnimation animation);
}

@GUID("E57AA735-DCDB-4C72-9C61-0591F58889EE")
interface IDCompositionSkewTransform : IDCompositionTransform
{
    HRESULT SetAngleX(float angleX);
    HRESULT SetAngleX(IDCompositionAnimation animation);
    HRESULT SetAngleY(float angleY);
    HRESULT SetAngleY(IDCompositionAnimation animation);
    HRESULT SetCenterX(float centerX);
    HRESULT SetCenterX(IDCompositionAnimation animation);
    HRESULT SetCenterY(float centerY);
    HRESULT SetCenterY(IDCompositionAnimation animation);
}

@GUID("16CDFF07-C503-419C-83F2-0965C7AF1FA6")
interface IDCompositionMatrixTransform : IDCompositionTransform
{
    HRESULT SetMatrix(const(D2D_MATRIX_3X2_F)* matrix);
    HRESULT SetMatrixElement(int row, int column, float value);
    HRESULT SetMatrixElement(int row, int column, IDCompositionAnimation animation);
}

@GUID("A7929A74-E6B2-4BD6-8B95-4040119CA34D")
interface IDCompositionEffectGroup : IDCompositionEffect
{
    HRESULT SetOpacity(float opacity);
    HRESULT SetOpacity(IDCompositionAnimation animation);
    HRESULT SetTransform3D(IDCompositionTransform3D transform3D);
}

@GUID("91636D4B-9BA1-4532-AAF7-E3344994D788")
interface IDCompositionTranslateTransform3D : IDCompositionTransform3D
{
    HRESULT SetOffsetX(float offsetX);
    HRESULT SetOffsetX(IDCompositionAnimation animation);
    HRESULT SetOffsetY(float offsetY);
    HRESULT SetOffsetY(IDCompositionAnimation animation);
    HRESULT SetOffsetZ(float offsetZ);
    HRESULT SetOffsetZ(IDCompositionAnimation animation);
}

@GUID("2A9E9EAD-364B-4B15-A7C4-A1997F78B389")
interface IDCompositionScaleTransform3D : IDCompositionTransform3D
{
    HRESULT SetScaleX(float scaleX);
    HRESULT SetScaleX(IDCompositionAnimation animation);
    HRESULT SetScaleY(float scaleY);
    HRESULT SetScaleY(IDCompositionAnimation animation);
    HRESULT SetScaleZ(float scaleZ);
    HRESULT SetScaleZ(IDCompositionAnimation animation);
    HRESULT SetCenterX(float centerX);
    HRESULT SetCenterX(IDCompositionAnimation animation);
    HRESULT SetCenterY(float centerY);
    HRESULT SetCenterY(IDCompositionAnimation animation);
    HRESULT SetCenterZ(float centerZ);
    HRESULT SetCenterZ(IDCompositionAnimation animation);
}

@GUID("D8F5B23F-D429-4A91-B55A-D2F45FD75B18")
interface IDCompositionRotateTransform3D : IDCompositionTransform3D
{
    HRESULT SetAngle(float angle);
    HRESULT SetAngle(IDCompositionAnimation animation);
    HRESULT SetAxisX(float axisX);
    HRESULT SetAxisX(IDCompositionAnimation animation);
    HRESULT SetAxisY(float axisY);
    HRESULT SetAxisY(IDCompositionAnimation animation);
    HRESULT SetAxisZ(float axisZ);
    HRESULT SetAxisZ(IDCompositionAnimation animation);
    HRESULT SetCenterX(float centerX);
    HRESULT SetCenterX(IDCompositionAnimation animation);
    HRESULT SetCenterY(float centerY);
    HRESULT SetCenterY(IDCompositionAnimation animation);
    HRESULT SetCenterZ(float centerZ);
    HRESULT SetCenterZ(IDCompositionAnimation animation);
}

@GUID("4B3363F0-643B-41B7-B6E0-CCF22D34467C")
interface IDCompositionMatrixTransform3D : IDCompositionTransform3D
{
    HRESULT SetMatrix(const(D3DMATRIX)* matrix);
    HRESULT SetMatrixElement(int row, int column, float value);
    HRESULT SetMatrixElement(int row, int column, IDCompositionAnimation animation);
}

@GUID("64AC3703-9D3F-45EC-A109-7CAC0E7A13A7")
interface IDCompositionClip : IUnknown
{
}

@GUID("9842AD7D-D9CF-4908-AED7-48B51DA5E7C2")
interface IDCompositionRectangleClip : IDCompositionClip
{
    HRESULT SetLeft(float left);
    HRESULT SetLeft(IDCompositionAnimation animation);
    HRESULT SetTop(float top);
    HRESULT SetTop(IDCompositionAnimation animation);
    HRESULT SetRight(float right);
    HRESULT SetRight(IDCompositionAnimation animation);
    HRESULT SetBottom(float bottom);
    HRESULT SetBottom(IDCompositionAnimation animation);
    HRESULT SetTopLeftRadiusX(float radius);
    HRESULT SetTopLeftRadiusX(IDCompositionAnimation animation);
    HRESULT SetTopLeftRadiusY(float radius);
    HRESULT SetTopLeftRadiusY(IDCompositionAnimation animation);
    HRESULT SetTopRightRadiusX(float radius);
    HRESULT SetTopRightRadiusX(IDCompositionAnimation animation);
    HRESULT SetTopRightRadiusY(float radius);
    HRESULT SetTopRightRadiusY(IDCompositionAnimation animation);
    HRESULT SetBottomLeftRadiusX(float radius);
    HRESULT SetBottomLeftRadiusX(IDCompositionAnimation animation);
    HRESULT SetBottomLeftRadiusY(float radius);
    HRESULT SetBottomLeftRadiusY(IDCompositionAnimation animation);
    HRESULT SetBottomRightRadiusX(float radius);
    HRESULT SetBottomRightRadiusX(IDCompositionAnimation animation);
    HRESULT SetBottomRightRadiusY(float radius);
    HRESULT SetBottomRightRadiusY(IDCompositionAnimation animation);
}

@GUID("BB8A4953-2C99-4F5A-96F5-4819027FA3AC")
interface IDCompositionSurface : IUnknown
{
    HRESULT BeginDraw(const(RECT)* updateRect, const(GUID)* iid, void** updateObject, POINT* updateOffset);
    HRESULT EndDraw();
    HRESULT SuspendDraw();
    HRESULT ResumeDraw();
    HRESULT Scroll(const(RECT)* scrollRect, const(RECT)* clipRect, int offsetX, int offsetY);
}

@GUID("AE471C51-5F53-4A24-8D3E-D0C39C30B3F0")
interface IDCompositionVirtualSurface : IDCompositionSurface
{
    HRESULT Resize(uint width, uint height);
    HRESULT Trim(char* rectangles, uint count);
}

@GUID("75F6468D-1B8E-447C-9BC6-75FEA80B5B25")
interface IDCompositionDevice2 : IUnknown
{
    HRESULT Commit();
    HRESULT WaitForCommitCompletion();
    HRESULT GetFrameStatistics(DCOMPOSITION_FRAME_STATISTICS* statistics);
    HRESULT CreateVisual(IDCompositionVisual2* visual);
    HRESULT CreateSurfaceFactory(IUnknown renderingDevice, IDCompositionSurfaceFactory* surfaceFactory);
    HRESULT CreateSurface(uint width, uint height, DXGI_FORMAT pixelFormat, DXGI_ALPHA_MODE alphaMode, 
                          IDCompositionSurface* surface);
    HRESULT CreateVirtualSurface(uint initialWidth, uint initialHeight, DXGI_FORMAT pixelFormat, 
                                 DXGI_ALPHA_MODE alphaMode, IDCompositionVirtualSurface* virtualSurface);
    HRESULT CreateTranslateTransform(IDCompositionTranslateTransform* translateTransform);
    HRESULT CreateScaleTransform(IDCompositionScaleTransform* scaleTransform);
    HRESULT CreateRotateTransform(IDCompositionRotateTransform* rotateTransform);
    HRESULT CreateSkewTransform(IDCompositionSkewTransform* skewTransform);
    HRESULT CreateMatrixTransform(IDCompositionMatrixTransform* matrixTransform);
    HRESULT CreateTransformGroup(char* transforms, uint elements, IDCompositionTransform* transformGroup);
    HRESULT CreateTranslateTransform3D(IDCompositionTranslateTransform3D* translateTransform3D);
    HRESULT CreateScaleTransform3D(IDCompositionScaleTransform3D* scaleTransform3D);
    HRESULT CreateRotateTransform3D(IDCompositionRotateTransform3D* rotateTransform3D);
    HRESULT CreateMatrixTransform3D(IDCompositionMatrixTransform3D* matrixTransform3D);
    HRESULT CreateTransform3DGroup(char* transforms3D, uint elements, IDCompositionTransform3D* transform3DGroup);
    HRESULT CreateEffectGroup(IDCompositionEffectGroup* effectGroup);
    HRESULT CreateRectangleClip(IDCompositionRectangleClip* clip);
    HRESULT CreateAnimation(IDCompositionAnimation* animation);
}

@GUID("5F4633FE-1E08-4CB8-8C75-CE24333F5602")
interface IDCompositionDesktopDevice : IDCompositionDevice2
{
    HRESULT CreateTargetForHwnd(HWND hwnd, BOOL topmost, IDCompositionTarget* target);
    HRESULT CreateSurfaceFromHandle(HANDLE handle, IUnknown* surface);
    HRESULT CreateSurfaceFromHwnd(HWND hwnd, IUnknown* surface);
}

@GUID("A1A3C64A-224F-4A81-9773-4F03A89D3C6C")
interface IDCompositionDeviceDebug : IUnknown
{
    HRESULT EnableDebugCounters();
    HRESULT DisableDebugCounters();
}

@GUID("E334BC12-3937-4E02-85EB-FCF4EB30D2C8")
interface IDCompositionSurfaceFactory : IUnknown
{
    HRESULT CreateSurface(uint width, uint height, DXGI_FORMAT pixelFormat, DXGI_ALPHA_MODE alphaMode, 
                          IDCompositionSurface* surface);
    HRESULT CreateVirtualSurface(uint initialWidth, uint initialHeight, DXGI_FORMAT pixelFormat, 
                                 DXGI_ALPHA_MODE alphaMode, IDCompositionVirtualSurface* virtualSurface);
}

@GUID("E8DE1639-4331-4B26-BC5F-6A321D347A85")
interface IDCompositionVisual2 : IDCompositionVisual
{
    HRESULT SetOpacityMode(DCOMPOSITION_OPACITY_MODE mode);
    HRESULT SetBackFaceVisibility(DCOMPOSITION_BACKFACE_VISIBILITY visibility);
}

@GUID("FED2B808-5EB4-43A0-AEA3-35F65280F91B")
interface IDCompositionVisualDebug : IDCompositionVisual2
{
    HRESULT EnableHeatMap(const(DXGI_RGBA)* color);
    HRESULT DisableHeatMap();
    HRESULT EnableRedrawRegions();
    HRESULT DisableRedrawRegions();
}

@GUID("2775F462-B6C1-4015-B0BE-B3E7D6A4976D")
interface IDCompositionVisual3 : IDCompositionVisualDebug
{
    HRESULT SetDepthMode(DCOMPOSITION_DEPTH_MODE mode);
    HRESULT SetOffsetZ(float offsetZ);
    HRESULT SetOffsetZ(IDCompositionAnimation animation);
    HRESULT SetOpacity(float opacity);
    HRESULT SetOpacity(IDCompositionAnimation animation);
    HRESULT SetTransform(const(D2D_MATRIX_4X4_F)* matrix);
    HRESULT SetTransform(IDCompositionTransform3D transform);
    HRESULT SetVisible(BOOL visible);
}

@GUID("0987CB06-F916-48BF-8D35-CE7641781BD9")
interface IDCompositionDevice3 : IDCompositionDevice2
{
    HRESULT CreateGaussianBlurEffect(IDCompositionGaussianBlurEffect* gaussianBlurEffect);
    HRESULT CreateBrightnessEffect(IDCompositionBrightnessEffect* brightnessEffect);
    HRESULT CreateColorMatrixEffect(IDCompositionColorMatrixEffect* colorMatrixEffect);
    HRESULT CreateShadowEffect(IDCompositionShadowEffect* shadowEffect);
    HRESULT CreateHueRotationEffect(IDCompositionHueRotationEffect* hueRotationEffect);
    HRESULT CreateSaturationEffect(IDCompositionSaturationEffect* saturationEffect);
    HRESULT CreateTurbulenceEffect(IDCompositionTurbulenceEffect* turbulenceEffect);
    HRESULT CreateLinearTransferEffect(IDCompositionLinearTransferEffect* linearTransferEffect);
    HRESULT CreateTableTransferEffect(IDCompositionTableTransferEffect* tableTransferEffect);
    HRESULT CreateCompositeEffect(IDCompositionCompositeEffect* compositeEffect);
    HRESULT CreateBlendEffect(IDCompositionBlendEffect* blendEffect);
    HRESULT CreateArithmeticCompositeEffect(IDCompositionArithmeticCompositeEffect* arithmeticCompositeEffect);
    HRESULT CreateAffineTransform2DEffect(IDCompositionAffineTransform2DEffect* affineTransform2dEffect);
}

@GUID("30C421D5-8CB2-4E9F-B133-37BE270D4AC2")
interface IDCompositionFilterEffect : IDCompositionEffect
{
    HRESULT SetInput(uint index, IUnknown input, uint flags);
}

@GUID("45D4D0B7-1BD4-454E-8894-2BFA68443033")
interface IDCompositionGaussianBlurEffect : IDCompositionFilterEffect
{
    HRESULT SetStandardDeviation(float amount);
    HRESULT SetStandardDeviation(IDCompositionAnimation animation);
    HRESULT SetBorderMode(D2D1_BORDER_MODE mode);
}

@GUID("6027496E-CB3A-49AB-934F-D798DA4F7DA6")
interface IDCompositionBrightnessEffect : IDCompositionFilterEffect
{
    HRESULT SetWhitePoint(const(D2D_VECTOR_2F)* whitePoint);
    HRESULT SetBlackPoint(const(D2D_VECTOR_2F)* blackPoint);
    HRESULT SetWhitePointX(float whitePointX);
    HRESULT SetWhitePointX(IDCompositionAnimation animation);
    HRESULT SetWhitePointY(float whitePointY);
    HRESULT SetWhitePointY(IDCompositionAnimation animation);
    HRESULT SetBlackPointX(float blackPointX);
    HRESULT SetBlackPointX(IDCompositionAnimation animation);
    HRESULT SetBlackPointY(float blackPointY);
    HRESULT SetBlackPointY(IDCompositionAnimation animation);
}

@GUID("C1170A22-3CE2-4966-90D4-55408BFC84C4")
interface IDCompositionColorMatrixEffect : IDCompositionFilterEffect
{
    HRESULT SetMatrix(const(D2D_MATRIX_5X4_F)* matrix);
    HRESULT SetMatrixElement(int row, int column, float value);
    HRESULT SetMatrixElement(int row, int column, IDCompositionAnimation animation);
    HRESULT SetAlphaMode(D2D1_COLORMATRIX_ALPHA_MODE mode);
    HRESULT SetClampOutput(BOOL clamp);
}

@GUID("4AD18AC0-CFD2-4C2F-BB62-96E54FDB6879")
interface IDCompositionShadowEffect : IDCompositionFilterEffect
{
    HRESULT SetStandardDeviation(float amount);
    HRESULT SetStandardDeviation(IDCompositionAnimation animation);
    HRESULT SetColor(const(D2D_VECTOR_4F)* color);
    HRESULT SetRed(float amount);
    HRESULT SetRed(IDCompositionAnimation animation);
    HRESULT SetGreen(float amount);
    HRESULT SetGreen(IDCompositionAnimation animation);
    HRESULT SetBlue(float amount);
    HRESULT SetBlue(IDCompositionAnimation animation);
    HRESULT SetAlpha(float amount);
    HRESULT SetAlpha(IDCompositionAnimation animation);
}

@GUID("6DB9F920-0770-4781-B0C6-381912F9D167")
interface IDCompositionHueRotationEffect : IDCompositionFilterEffect
{
    HRESULT SetAngle(float amountDegrees);
    HRESULT SetAngle(IDCompositionAnimation animation);
}

@GUID("A08DEBDA-3258-4FA4-9F16-9174D3FE93B1")
interface IDCompositionSaturationEffect : IDCompositionFilterEffect
{
    HRESULT SetSaturation(float ratio);
    HRESULT SetSaturation(IDCompositionAnimation animation);
}

@GUID("A6A55BDA-C09C-49F3-9193-A41922C89715")
interface IDCompositionTurbulenceEffect : IDCompositionFilterEffect
{
    HRESULT SetOffset(const(D2D_VECTOR_2F)* offset);
    HRESULT SetBaseFrequency(const(D2D_VECTOR_2F)* frequency);
    HRESULT SetSize(const(D2D_VECTOR_2F)* size);
    HRESULT SetNumOctaves(uint numOctaves);
    HRESULT SetSeed(uint seed);
    HRESULT SetNoise(D2D1_TURBULENCE_NOISE noise);
    HRESULT SetStitchable(BOOL stitchable);
}

@GUID("4305EE5B-C4A0-4C88-9385-67124E017683")
interface IDCompositionLinearTransferEffect : IDCompositionFilterEffect
{
    HRESULT SetRedYIntercept(float redYIntercept);
    HRESULT SetRedYIntercept(IDCompositionAnimation animation);
    HRESULT SetRedSlope(float redSlope);
    HRESULT SetRedSlope(IDCompositionAnimation animation);
    HRESULT SetRedDisable(BOOL redDisable);
    HRESULT SetGreenYIntercept(float greenYIntercept);
    HRESULT SetGreenYIntercept(IDCompositionAnimation animation);
    HRESULT SetGreenSlope(float greenSlope);
    HRESULT SetGreenSlope(IDCompositionAnimation animation);
    HRESULT SetGreenDisable(BOOL greenDisable);
    HRESULT SetBlueYIntercept(float blueYIntercept);
    HRESULT SetBlueYIntercept(IDCompositionAnimation animation);
    HRESULT SetBlueSlope(float blueSlope);
    HRESULT SetBlueSlope(IDCompositionAnimation animation);
    HRESULT SetBlueDisable(BOOL blueDisable);
    HRESULT SetAlphaYIntercept(float alphaYIntercept);
    HRESULT SetAlphaYIntercept(IDCompositionAnimation animation);
    HRESULT SetAlphaSlope(float alphaSlope);
    HRESULT SetAlphaSlope(IDCompositionAnimation animation);
    HRESULT SetAlphaDisable(BOOL alphaDisable);
    HRESULT SetClampOutput(BOOL clampOutput);
}

@GUID("9B7E82E2-69C5-4EB4-A5F5-A7033F5132CD")
interface IDCompositionTableTransferEffect : IDCompositionFilterEffect
{
    HRESULT SetRedTable(char* tableValues, uint count);
    HRESULT SetGreenTable(char* tableValues, uint count);
    HRESULT SetBlueTable(char* tableValues, uint count);
    HRESULT SetAlphaTable(char* tableValues, uint count);
    HRESULT SetRedDisable(BOOL redDisable);
    HRESULT SetGreenDisable(BOOL greenDisable);
    HRESULT SetBlueDisable(BOOL blueDisable);
    HRESULT SetAlphaDisable(BOOL alphaDisable);
    HRESULT SetClampOutput(BOOL clampOutput);
    HRESULT SetRedTableValue(uint index, float value);
    HRESULT SetRedTableValue(uint index, IDCompositionAnimation animation);
    HRESULT SetGreenTableValue(uint index, float value);
    HRESULT SetGreenTableValue(uint index, IDCompositionAnimation animation);
    HRESULT SetBlueTableValue(uint index, float value);
    HRESULT SetBlueTableValue(uint index, IDCompositionAnimation animation);
    HRESULT SetAlphaTableValue(uint index, float value);
    HRESULT SetAlphaTableValue(uint index, IDCompositionAnimation animation);
}

@GUID("576616C0-A231-494D-A38D-00FD5EC4DB46")
interface IDCompositionCompositeEffect : IDCompositionFilterEffect
{
    HRESULT SetMode(D2D1_COMPOSITE_MODE mode);
}

@GUID("33ECDC0A-578A-4A11-9C14-0CB90517F9C5")
interface IDCompositionBlendEffect : IDCompositionFilterEffect
{
    HRESULT SetMode(D2D1_BLEND_MODE mode);
}

@GUID("3B67DFA8-E3DD-4E61-B640-46C2F3D739DC")
interface IDCompositionArithmeticCompositeEffect : IDCompositionFilterEffect
{
    HRESULT SetCoefficients(const(D2D_VECTOR_4F)* coefficients);
    HRESULT SetClampOutput(BOOL clampoutput);
    HRESULT SetCoefficient1(float Coeffcient1);
    HRESULT SetCoefficient1(IDCompositionAnimation animation);
    HRESULT SetCoefficient2(float Coefficient2);
    HRESULT SetCoefficient2(IDCompositionAnimation animation);
    HRESULT SetCoefficient3(float Coefficient3);
    HRESULT SetCoefficient3(IDCompositionAnimation animation);
    HRESULT SetCoefficient4(float Coefficient4);
    HRESULT SetCoefficient4(IDCompositionAnimation animation);
}

@GUID("0B74B9E8-CDD6-492F-BBBC-5ED32157026D")
interface IDCompositionAffineTransform2DEffect : IDCompositionFilterEffect
{
    HRESULT SetInterpolationMode(D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE interpolationMode);
    HRESULT SetBorderMode(D2D1_BORDER_MODE borderMode);
    HRESULT SetTransformMatrix(const(D2D_MATRIX_3X2_F)* transformMatrix);
    HRESULT SetTransformMatrixElement(int row, int column, float value);
    HRESULT SetTransformMatrixElement(int row, int column, IDCompositionAnimation animation);
    HRESULT SetSharpness(float sharpness);
    HRESULT SetSharpness(IDCompositionAnimation animation);
}


// GUIDs


const GUID IID_IDCompositionAffineTransform2DEffect   = GUIDOF!IDCompositionAffineTransform2DEffect;
const GUID IID_IDCompositionAnimation                 = GUIDOF!IDCompositionAnimation;
const GUID IID_IDCompositionArithmeticCompositeEffect = GUIDOF!IDCompositionArithmeticCompositeEffect;
const GUID IID_IDCompositionBlendEffect               = GUIDOF!IDCompositionBlendEffect;
const GUID IID_IDCompositionBrightnessEffect          = GUIDOF!IDCompositionBrightnessEffect;
const GUID IID_IDCompositionClip                      = GUIDOF!IDCompositionClip;
const GUID IID_IDCompositionColorMatrixEffect         = GUIDOF!IDCompositionColorMatrixEffect;
const GUID IID_IDCompositionCompositeEffect           = GUIDOF!IDCompositionCompositeEffect;
const GUID IID_IDCompositionDesktopDevice             = GUIDOF!IDCompositionDesktopDevice;
const GUID IID_IDCompositionDevice                    = GUIDOF!IDCompositionDevice;
const GUID IID_IDCompositionDevice2                   = GUIDOF!IDCompositionDevice2;
const GUID IID_IDCompositionDevice3                   = GUIDOF!IDCompositionDevice3;
const GUID IID_IDCompositionDeviceDebug               = GUIDOF!IDCompositionDeviceDebug;
const GUID IID_IDCompositionEffect                    = GUIDOF!IDCompositionEffect;
const GUID IID_IDCompositionEffectGroup               = GUIDOF!IDCompositionEffectGroup;
const GUID IID_IDCompositionFilterEffect              = GUIDOF!IDCompositionFilterEffect;
const GUID IID_IDCompositionGaussianBlurEffect        = GUIDOF!IDCompositionGaussianBlurEffect;
const GUID IID_IDCompositionHueRotationEffect         = GUIDOF!IDCompositionHueRotationEffect;
const GUID IID_IDCompositionLinearTransferEffect      = GUIDOF!IDCompositionLinearTransferEffect;
const GUID IID_IDCompositionMatrixTransform           = GUIDOF!IDCompositionMatrixTransform;
const GUID IID_IDCompositionMatrixTransform3D         = GUIDOF!IDCompositionMatrixTransform3D;
const GUID IID_IDCompositionRectangleClip             = GUIDOF!IDCompositionRectangleClip;
const GUID IID_IDCompositionRotateTransform           = GUIDOF!IDCompositionRotateTransform;
const GUID IID_IDCompositionRotateTransform3D         = GUIDOF!IDCompositionRotateTransform3D;
const GUID IID_IDCompositionSaturationEffect          = GUIDOF!IDCompositionSaturationEffect;
const GUID IID_IDCompositionScaleTransform            = GUIDOF!IDCompositionScaleTransform;
const GUID IID_IDCompositionScaleTransform3D          = GUIDOF!IDCompositionScaleTransform3D;
const GUID IID_IDCompositionShadowEffect              = GUIDOF!IDCompositionShadowEffect;
const GUID IID_IDCompositionSkewTransform             = GUIDOF!IDCompositionSkewTransform;
const GUID IID_IDCompositionSurface                   = GUIDOF!IDCompositionSurface;
const GUID IID_IDCompositionSurfaceFactory            = GUIDOF!IDCompositionSurfaceFactory;
const GUID IID_IDCompositionTableTransferEffect       = GUIDOF!IDCompositionTableTransferEffect;
const GUID IID_IDCompositionTarget                    = GUIDOF!IDCompositionTarget;
const GUID IID_IDCompositionTransform                 = GUIDOF!IDCompositionTransform;
const GUID IID_IDCompositionTransform3D               = GUIDOF!IDCompositionTransform3D;
const GUID IID_IDCompositionTranslateTransform        = GUIDOF!IDCompositionTranslateTransform;
const GUID IID_IDCompositionTranslateTransform3D      = GUIDOF!IDCompositionTranslateTransform3D;
const GUID IID_IDCompositionTurbulenceEffect          = GUIDOF!IDCompositionTurbulenceEffect;
const GUID IID_IDCompositionVirtualSurface            = GUIDOF!IDCompositionVirtualSurface;
const GUID IID_IDCompositionVisual                    = GUIDOF!IDCompositionVisual;
const GUID IID_IDCompositionVisual2                   = GUIDOF!IDCompositionVisual2;
const GUID IID_IDCompositionVisual3                   = GUIDOF!IDCompositionVisual3;
const GUID IID_IDCompositionVisualDebug               = GUIDOF!IDCompositionVisualDebug;
