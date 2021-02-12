module windows.directcomposition;

public import system;
public import windows.com;
public import windows.direct2d;
public import windows.direct3d9;
public import windows.displaydevices;
public import windows.dxgi;
public import windows.systemservices;
public import windows.windowsandmessaging;

extern(Windows):

enum DCOMPOSITION_BITMAP_INTERPOLATION_MODE
{
    DCOMPOSITION_BITMAP_INTERPOLATION_MODE_NEAREST_NEIGHBOR = 0,
    DCOMPOSITION_BITMAP_INTERPOLATION_MODE_LINEAR = 1,
    DCOMPOSITION_BITMAP_INTERPOLATION_MODE_INHERIT = -1,
}

enum DCOMPOSITION_BORDER_MODE
{
    DCOMPOSITION_BORDER_MODE_SOFT = 0,
    DCOMPOSITION_BORDER_MODE_HARD = 1,
    DCOMPOSITION_BORDER_MODE_INHERIT = -1,
}

enum DCOMPOSITION_COMPOSITE_MODE
{
    DCOMPOSITION_COMPOSITE_MODE_SOURCE_OVER = 0,
    DCOMPOSITION_COMPOSITE_MODE_DESTINATION_INVERT = 1,
    DCOMPOSITION_COMPOSITE_MODE_MIN_BLEND = 2,
    DCOMPOSITION_COMPOSITE_MODE_INHERIT = -1,
}

enum DCOMPOSITION_BACKFACE_VISIBILITY
{
    DCOMPOSITION_BACKFACE_VISIBILITY_VISIBLE = 0,
    DCOMPOSITION_BACKFACE_VISIBILITY_HIDDEN = 1,
    DCOMPOSITION_BACKFACE_VISIBILITY_INHERIT = -1,
}

enum DCOMPOSITION_OPACITY_MODE
{
    DCOMPOSITION_OPACITY_MODE_LAYER = 0,
    DCOMPOSITION_OPACITY_MODE_MULTIPLY = 1,
    DCOMPOSITION_OPACITY_MODE_INHERIT = -1,
}

enum DCOMPOSITION_DEPTH_MODE
{
    DCOMPOSITION_DEPTH_MODE_TREE = 0,
    DCOMPOSITION_DEPTH_MODE_SPATIAL = 1,
    DCOMPOSITION_DEPTH_MODE_SORTED = 3,
    DCOMPOSITION_DEPTH_MODE_INHERIT = -1,
}

struct DCOMPOSITION_FRAME_STATISTICS
{
    LARGE_INTEGER lastFrameTime;
    DXGI_RATIONAL currentCompositionRate;
    LARGE_INTEGER currentTime;
    LARGE_INTEGER timeFrequency;
    LARGE_INTEGER nextEstimatedFrameTime;
}

const GUID IID_IDCompositionAnimation = {0xCBFD91D9, 0x51B2, 0x45E4, [0xB3, 0xDE, 0xD1, 0x9C, 0xCF, 0xB8, 0x63, 0xC5]};
@GUID(0xCBFD91D9, 0x51B2, 0x45E4, [0xB3, 0xDE, 0xD1, 0x9C, 0xCF, 0xB8, 0x63, 0xC5]);
interface IDCompositionAnimation : IUnknown
{
    HRESULT Reset();
    HRESULT SetAbsoluteBeginTime(LARGE_INTEGER beginTime);
    HRESULT AddCubic(double beginOffset, float constantCoefficient, float linearCoefficient, float quadraticCoefficient, float cubicCoefficient);
    HRESULT AddSinusoidal(double beginOffset, float bias, float amplitude, float frequency, float phase);
    HRESULT AddRepeat(double beginOffset, double durationToRepeat);
    HRESULT End(double endOffset, float endValue);
}

const GUID IID_IDCompositionDevice = {0xC37EA93A, 0xE7AA, 0x450D, [0xB1, 0x6F, 0x97, 0x46, 0xCB, 0x04, 0x07, 0xF3]};
@GUID(0xC37EA93A, 0xE7AA, 0x450D, [0xB1, 0x6F, 0x97, 0x46, 0xCB, 0x04, 0x07, 0xF3]);
interface IDCompositionDevice : IUnknown
{
    HRESULT Commit();
    HRESULT WaitForCommitCompletion();
    HRESULT GetFrameStatistics(DCOMPOSITION_FRAME_STATISTICS* statistics);
    HRESULT CreateTargetForHwnd(HWND hwnd, BOOL topmost, IDCompositionTarget* target);
    HRESULT CreateVisual(IDCompositionVisual* visual);
    HRESULT CreateSurface(uint width, uint height, DXGI_FORMAT pixelFormat, DXGI_ALPHA_MODE alphaMode, IDCompositionSurface* surface);
    HRESULT CreateVirtualSurface(uint initialWidth, uint initialHeight, DXGI_FORMAT pixelFormat, DXGI_ALPHA_MODE alphaMode, IDCompositionVirtualSurface* virtualSurface);
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

const GUID IID_IDCompositionTarget = {0xEACDD04C, 0x117E, 0x4E17, [0x88, 0xF4, 0xD1, 0xB1, 0x2B, 0x0E, 0x3D, 0x89]};
@GUID(0xEACDD04C, 0x117E, 0x4E17, [0x88, 0xF4, 0xD1, 0xB1, 0x2B, 0x0E, 0x3D, 0x89]);
interface IDCompositionTarget : IUnknown
{
    HRESULT SetRoot(IDCompositionVisual visual);
}

const GUID IID_IDCompositionVisual = {0x4D93059D, 0x097B, 0x4651, [0x9A, 0x60, 0xF0, 0xF2, 0x51, 0x16, 0xE2, 0xF3]};
@GUID(0x4D93059D, 0x097B, 0x4651, [0x9A, 0x60, 0xF0, 0xF2, 0x51, 0x16, 0xE2, 0xF3]);
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

const GUID IID_IDCompositionEffect = {0xEC81B08F, 0xBFCB, 0x4E8D, [0xB1, 0x93, 0xA9, 0x15, 0x58, 0x79, 0x99, 0xE8]};
@GUID(0xEC81B08F, 0xBFCB, 0x4E8D, [0xB1, 0x93, 0xA9, 0x15, 0x58, 0x79, 0x99, 0xE8]);
interface IDCompositionEffect : IUnknown
{
}

const GUID IID_IDCompositionTransform3D = {0x71185722, 0x246B, 0x41F2, [0xAA, 0xD1, 0x04, 0x43, 0xF7, 0xF4, 0xBF, 0xC2]};
@GUID(0x71185722, 0x246B, 0x41F2, [0xAA, 0xD1, 0x04, 0x43, 0xF7, 0xF4, 0xBF, 0xC2]);
interface IDCompositionTransform3D : IDCompositionEffect
{
}

const GUID IID_IDCompositionTransform = {0xFD55FAA7, 0x37E0, 0x4C20, [0x95, 0xD2, 0x9B, 0xE4, 0x5B, 0xC3, 0x3F, 0x55]};
@GUID(0xFD55FAA7, 0x37E0, 0x4C20, [0x95, 0xD2, 0x9B, 0xE4, 0x5B, 0xC3, 0x3F, 0x55]);
interface IDCompositionTransform : IDCompositionTransform3D
{
}

const GUID IID_IDCompositionTranslateTransform = {0x06791122, 0xC6F0, 0x417D, [0x83, 0x23, 0x26, 0x9E, 0x98, 0x7F, 0x59, 0x54]};
@GUID(0x06791122, 0xC6F0, 0x417D, [0x83, 0x23, 0x26, 0x9E, 0x98, 0x7F, 0x59, 0x54]);
interface IDCompositionTranslateTransform : IDCompositionTransform
{
    HRESULT SetOffsetX(float offsetX);
    HRESULT SetOffsetX(IDCompositionAnimation animation);
    HRESULT SetOffsetY(float offsetY);
    HRESULT SetOffsetY(IDCompositionAnimation animation);
}

const GUID IID_IDCompositionScaleTransform = {0x71FDE914, 0x40EF, 0x45EF, [0xBD, 0x51, 0x68, 0xB0, 0x37, 0xC3, 0x39, 0xF9]};
@GUID(0x71FDE914, 0x40EF, 0x45EF, [0xBD, 0x51, 0x68, 0xB0, 0x37, 0xC3, 0x39, 0xF9]);
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

const GUID IID_IDCompositionRotateTransform = {0x641ED83C, 0xAE96, 0x46C5, [0x90, 0xDC, 0x32, 0x77, 0x4C, 0xC5, 0xC6, 0xD5]};
@GUID(0x641ED83C, 0xAE96, 0x46C5, [0x90, 0xDC, 0x32, 0x77, 0x4C, 0xC5, 0xC6, 0xD5]);
interface IDCompositionRotateTransform : IDCompositionTransform
{
    HRESULT SetAngle(float angle);
    HRESULT SetAngle(IDCompositionAnimation animation);
    HRESULT SetCenterX(float centerX);
    HRESULT SetCenterX(IDCompositionAnimation animation);
    HRESULT SetCenterY(float centerY);
    HRESULT SetCenterY(IDCompositionAnimation animation);
}

const GUID IID_IDCompositionSkewTransform = {0xE57AA735, 0xDCDB, 0x4C72, [0x9C, 0x61, 0x05, 0x91, 0xF5, 0x88, 0x89, 0xEE]};
@GUID(0xE57AA735, 0xDCDB, 0x4C72, [0x9C, 0x61, 0x05, 0x91, 0xF5, 0x88, 0x89, 0xEE]);
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

const GUID IID_IDCompositionMatrixTransform = {0x16CDFF07, 0xC503, 0x419C, [0x83, 0xF2, 0x09, 0x65, 0xC7, 0xAF, 0x1F, 0xA6]};
@GUID(0x16CDFF07, 0xC503, 0x419C, [0x83, 0xF2, 0x09, 0x65, 0xC7, 0xAF, 0x1F, 0xA6]);
interface IDCompositionMatrixTransform : IDCompositionTransform
{
    HRESULT SetMatrix(const(D2D_MATRIX_3X2_F)* matrix);
    HRESULT SetMatrixElement(int row, int column, float value);
    HRESULT SetMatrixElement(int row, int column, IDCompositionAnimation animation);
}

const GUID IID_IDCompositionEffectGroup = {0xA7929A74, 0xE6B2, 0x4BD6, [0x8B, 0x95, 0x40, 0x40, 0x11, 0x9C, 0xA3, 0x4D]};
@GUID(0xA7929A74, 0xE6B2, 0x4BD6, [0x8B, 0x95, 0x40, 0x40, 0x11, 0x9C, 0xA3, 0x4D]);
interface IDCompositionEffectGroup : IDCompositionEffect
{
    HRESULT SetOpacity(float opacity);
    HRESULT SetOpacity(IDCompositionAnimation animation);
    HRESULT SetTransform3D(IDCompositionTransform3D transform3D);
}

const GUID IID_IDCompositionTranslateTransform3D = {0x91636D4B, 0x9BA1, 0x4532, [0xAA, 0xF7, 0xE3, 0x34, 0x49, 0x94, 0xD7, 0x88]};
@GUID(0x91636D4B, 0x9BA1, 0x4532, [0xAA, 0xF7, 0xE3, 0x34, 0x49, 0x94, 0xD7, 0x88]);
interface IDCompositionTranslateTransform3D : IDCompositionTransform3D
{
    HRESULT SetOffsetX(float offsetX);
    HRESULT SetOffsetX(IDCompositionAnimation animation);
    HRESULT SetOffsetY(float offsetY);
    HRESULT SetOffsetY(IDCompositionAnimation animation);
    HRESULT SetOffsetZ(float offsetZ);
    HRESULT SetOffsetZ(IDCompositionAnimation animation);
}

const GUID IID_IDCompositionScaleTransform3D = {0x2A9E9EAD, 0x364B, 0x4B15, [0xA7, 0xC4, 0xA1, 0x99, 0x7F, 0x78, 0xB3, 0x89]};
@GUID(0x2A9E9EAD, 0x364B, 0x4B15, [0xA7, 0xC4, 0xA1, 0x99, 0x7F, 0x78, 0xB3, 0x89]);
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

const GUID IID_IDCompositionRotateTransform3D = {0xD8F5B23F, 0xD429, 0x4A91, [0xB5, 0x5A, 0xD2, 0xF4, 0x5F, 0xD7, 0x5B, 0x18]};
@GUID(0xD8F5B23F, 0xD429, 0x4A91, [0xB5, 0x5A, 0xD2, 0xF4, 0x5F, 0xD7, 0x5B, 0x18]);
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

const GUID IID_IDCompositionMatrixTransform3D = {0x4B3363F0, 0x643B, 0x41B7, [0xB6, 0xE0, 0xCC, 0xF2, 0x2D, 0x34, 0x46, 0x7C]};
@GUID(0x4B3363F0, 0x643B, 0x41B7, [0xB6, 0xE0, 0xCC, 0xF2, 0x2D, 0x34, 0x46, 0x7C]);
interface IDCompositionMatrixTransform3D : IDCompositionTransform3D
{
    HRESULT SetMatrix(const(D3DMATRIX)* matrix);
    HRESULT SetMatrixElement(int row, int column, float value);
    HRESULT SetMatrixElement(int row, int column, IDCompositionAnimation animation);
}

const GUID IID_IDCompositionClip = {0x64AC3703, 0x9D3F, 0x45EC, [0xA1, 0x09, 0x7C, 0xAC, 0x0E, 0x7A, 0x13, 0xA7]};
@GUID(0x64AC3703, 0x9D3F, 0x45EC, [0xA1, 0x09, 0x7C, 0xAC, 0x0E, 0x7A, 0x13, 0xA7]);
interface IDCompositionClip : IUnknown
{
}

const GUID IID_IDCompositionRectangleClip = {0x9842AD7D, 0xD9CF, 0x4908, [0xAE, 0xD7, 0x48, 0xB5, 0x1D, 0xA5, 0xE7, 0xC2]};
@GUID(0x9842AD7D, 0xD9CF, 0x4908, [0xAE, 0xD7, 0x48, 0xB5, 0x1D, 0xA5, 0xE7, 0xC2]);
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

const GUID IID_IDCompositionSurface = {0xBB8A4953, 0x2C99, 0x4F5A, [0x96, 0xF5, 0x48, 0x19, 0x02, 0x7F, 0xA3, 0xAC]};
@GUID(0xBB8A4953, 0x2C99, 0x4F5A, [0x96, 0xF5, 0x48, 0x19, 0x02, 0x7F, 0xA3, 0xAC]);
interface IDCompositionSurface : IUnknown
{
    HRESULT BeginDraw(const(RECT)* updateRect, const(Guid)* iid, void** updateObject, POINT* updateOffset);
    HRESULT EndDraw();
    HRESULT SuspendDraw();
    HRESULT ResumeDraw();
    HRESULT Scroll(const(RECT)* scrollRect, const(RECT)* clipRect, int offsetX, int offsetY);
}

const GUID IID_IDCompositionVirtualSurface = {0xAE471C51, 0x5F53, 0x4A24, [0x8D, 0x3E, 0xD0, 0xC3, 0x9C, 0x30, 0xB3, 0xF0]};
@GUID(0xAE471C51, 0x5F53, 0x4A24, [0x8D, 0x3E, 0xD0, 0xC3, 0x9C, 0x30, 0xB3, 0xF0]);
interface IDCompositionVirtualSurface : IDCompositionSurface
{
    HRESULT Resize(uint width, uint height);
    HRESULT Trim(char* rectangles, uint count);
}

const GUID IID_IDCompositionDevice2 = {0x75F6468D, 0x1B8E, 0x447C, [0x9B, 0xC6, 0x75, 0xFE, 0xA8, 0x0B, 0x5B, 0x25]};
@GUID(0x75F6468D, 0x1B8E, 0x447C, [0x9B, 0xC6, 0x75, 0xFE, 0xA8, 0x0B, 0x5B, 0x25]);
interface IDCompositionDevice2 : IUnknown
{
    HRESULT Commit();
    HRESULT WaitForCommitCompletion();
    HRESULT GetFrameStatistics(DCOMPOSITION_FRAME_STATISTICS* statistics);
    HRESULT CreateVisual(IDCompositionVisual2* visual);
    HRESULT CreateSurfaceFactory(IUnknown renderingDevice, IDCompositionSurfaceFactory* surfaceFactory);
    HRESULT CreateSurface(uint width, uint height, DXGI_FORMAT pixelFormat, DXGI_ALPHA_MODE alphaMode, IDCompositionSurface* surface);
    HRESULT CreateVirtualSurface(uint initialWidth, uint initialHeight, DXGI_FORMAT pixelFormat, DXGI_ALPHA_MODE alphaMode, IDCompositionVirtualSurface* virtualSurface);
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

const GUID IID_IDCompositionDesktopDevice = {0x5F4633FE, 0x1E08, 0x4CB8, [0x8C, 0x75, 0xCE, 0x24, 0x33, 0x3F, 0x56, 0x02]};
@GUID(0x5F4633FE, 0x1E08, 0x4CB8, [0x8C, 0x75, 0xCE, 0x24, 0x33, 0x3F, 0x56, 0x02]);
interface IDCompositionDesktopDevice : IDCompositionDevice2
{
    HRESULT CreateTargetForHwnd(HWND hwnd, BOOL topmost, IDCompositionTarget* target);
    HRESULT CreateSurfaceFromHandle(HANDLE handle, IUnknown* surface);
    HRESULT CreateSurfaceFromHwnd(HWND hwnd, IUnknown* surface);
}

const GUID IID_IDCompositionDeviceDebug = {0xA1A3C64A, 0x224F, 0x4A81, [0x97, 0x73, 0x4F, 0x03, 0xA8, 0x9D, 0x3C, 0x6C]};
@GUID(0xA1A3C64A, 0x224F, 0x4A81, [0x97, 0x73, 0x4F, 0x03, 0xA8, 0x9D, 0x3C, 0x6C]);
interface IDCompositionDeviceDebug : IUnknown
{
    HRESULT EnableDebugCounters();
    HRESULT DisableDebugCounters();
}

const GUID IID_IDCompositionSurfaceFactory = {0xE334BC12, 0x3937, 0x4E02, [0x85, 0xEB, 0xFC, 0xF4, 0xEB, 0x30, 0xD2, 0xC8]};
@GUID(0xE334BC12, 0x3937, 0x4E02, [0x85, 0xEB, 0xFC, 0xF4, 0xEB, 0x30, 0xD2, 0xC8]);
interface IDCompositionSurfaceFactory : IUnknown
{
    HRESULT CreateSurface(uint width, uint height, DXGI_FORMAT pixelFormat, DXGI_ALPHA_MODE alphaMode, IDCompositionSurface* surface);
    HRESULT CreateVirtualSurface(uint initialWidth, uint initialHeight, DXGI_FORMAT pixelFormat, DXGI_ALPHA_MODE alphaMode, IDCompositionVirtualSurface* virtualSurface);
}

const GUID IID_IDCompositionVisual2 = {0xE8DE1639, 0x4331, 0x4B26, [0xBC, 0x5F, 0x6A, 0x32, 0x1D, 0x34, 0x7A, 0x85]};
@GUID(0xE8DE1639, 0x4331, 0x4B26, [0xBC, 0x5F, 0x6A, 0x32, 0x1D, 0x34, 0x7A, 0x85]);
interface IDCompositionVisual2 : IDCompositionVisual
{
    HRESULT SetOpacityMode(DCOMPOSITION_OPACITY_MODE mode);
    HRESULT SetBackFaceVisibility(DCOMPOSITION_BACKFACE_VISIBILITY visibility);
}

const GUID IID_IDCompositionVisualDebug = {0xFED2B808, 0x5EB4, 0x43A0, [0xAE, 0xA3, 0x35, 0xF6, 0x52, 0x80, 0xF9, 0x1B]};
@GUID(0xFED2B808, 0x5EB4, 0x43A0, [0xAE, 0xA3, 0x35, 0xF6, 0x52, 0x80, 0xF9, 0x1B]);
interface IDCompositionVisualDebug : IDCompositionVisual2
{
    HRESULT EnableHeatMap(const(DXGI_RGBA)* color);
    HRESULT DisableHeatMap();
    HRESULT EnableRedrawRegions();
    HRESULT DisableRedrawRegions();
}

const GUID IID_IDCompositionVisual3 = {0x2775F462, 0xB6C1, 0x4015, [0xB0, 0xBE, 0xB3, 0xE7, 0xD6, 0xA4, 0x97, 0x6D]};
@GUID(0x2775F462, 0xB6C1, 0x4015, [0xB0, 0xBE, 0xB3, 0xE7, 0xD6, 0xA4, 0x97, 0x6D]);
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

const GUID IID_IDCompositionDevice3 = {0x0987CB06, 0xF916, 0x48BF, [0x8D, 0x35, 0xCE, 0x76, 0x41, 0x78, 0x1B, 0xD9]};
@GUID(0x0987CB06, 0xF916, 0x48BF, [0x8D, 0x35, 0xCE, 0x76, 0x41, 0x78, 0x1B, 0xD9]);
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

const GUID IID_IDCompositionFilterEffect = {0x30C421D5, 0x8CB2, 0x4E9F, [0xB1, 0x33, 0x37, 0xBE, 0x27, 0x0D, 0x4A, 0xC2]};
@GUID(0x30C421D5, 0x8CB2, 0x4E9F, [0xB1, 0x33, 0x37, 0xBE, 0x27, 0x0D, 0x4A, 0xC2]);
interface IDCompositionFilterEffect : IDCompositionEffect
{
    HRESULT SetInput(uint index, IUnknown input, uint flags);
}

const GUID IID_IDCompositionGaussianBlurEffect = {0x45D4D0B7, 0x1BD4, 0x454E, [0x88, 0x94, 0x2B, 0xFA, 0x68, 0x44, 0x30, 0x33]};
@GUID(0x45D4D0B7, 0x1BD4, 0x454E, [0x88, 0x94, 0x2B, 0xFA, 0x68, 0x44, 0x30, 0x33]);
interface IDCompositionGaussianBlurEffect : IDCompositionFilterEffect
{
    HRESULT SetStandardDeviation(float amount);
    HRESULT SetStandardDeviation(IDCompositionAnimation animation);
    HRESULT SetBorderMode(D2D1_BORDER_MODE mode);
}

const GUID IID_IDCompositionBrightnessEffect = {0x6027496E, 0xCB3A, 0x49AB, [0x93, 0x4F, 0xD7, 0x98, 0xDA, 0x4F, 0x7D, 0xA6]};
@GUID(0x6027496E, 0xCB3A, 0x49AB, [0x93, 0x4F, 0xD7, 0x98, 0xDA, 0x4F, 0x7D, 0xA6]);
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

const GUID IID_IDCompositionColorMatrixEffect = {0xC1170A22, 0x3CE2, 0x4966, [0x90, 0xD4, 0x55, 0x40, 0x8B, 0xFC, 0x84, 0xC4]};
@GUID(0xC1170A22, 0x3CE2, 0x4966, [0x90, 0xD4, 0x55, 0x40, 0x8B, 0xFC, 0x84, 0xC4]);
interface IDCompositionColorMatrixEffect : IDCompositionFilterEffect
{
    HRESULT SetMatrix(const(D2D_MATRIX_5X4_F)* matrix);
    HRESULT SetMatrixElement(int row, int column, float value);
    HRESULT SetMatrixElement(int row, int column, IDCompositionAnimation animation);
    HRESULT SetAlphaMode(D2D1_COLORMATRIX_ALPHA_MODE mode);
    HRESULT SetClampOutput(BOOL clamp);
}

const GUID IID_IDCompositionShadowEffect = {0x4AD18AC0, 0xCFD2, 0x4C2F, [0xBB, 0x62, 0x96, 0xE5, 0x4F, 0xDB, 0x68, 0x79]};
@GUID(0x4AD18AC0, 0xCFD2, 0x4C2F, [0xBB, 0x62, 0x96, 0xE5, 0x4F, 0xDB, 0x68, 0x79]);
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

const GUID IID_IDCompositionHueRotationEffect = {0x6DB9F920, 0x0770, 0x4781, [0xB0, 0xC6, 0x38, 0x19, 0x12, 0xF9, 0xD1, 0x67]};
@GUID(0x6DB9F920, 0x0770, 0x4781, [0xB0, 0xC6, 0x38, 0x19, 0x12, 0xF9, 0xD1, 0x67]);
interface IDCompositionHueRotationEffect : IDCompositionFilterEffect
{
    HRESULT SetAngle(float amountDegrees);
    HRESULT SetAngle(IDCompositionAnimation animation);
}

const GUID IID_IDCompositionSaturationEffect = {0xA08DEBDA, 0x3258, 0x4FA4, [0x9F, 0x16, 0x91, 0x74, 0xD3, 0xFE, 0x93, 0xB1]};
@GUID(0xA08DEBDA, 0x3258, 0x4FA4, [0x9F, 0x16, 0x91, 0x74, 0xD3, 0xFE, 0x93, 0xB1]);
interface IDCompositionSaturationEffect : IDCompositionFilterEffect
{
    HRESULT SetSaturation(float ratio);
    HRESULT SetSaturation(IDCompositionAnimation animation);
}

const GUID IID_IDCompositionTurbulenceEffect = {0xA6A55BDA, 0xC09C, 0x49F3, [0x91, 0x93, 0xA4, 0x19, 0x22, 0xC8, 0x97, 0x15]};
@GUID(0xA6A55BDA, 0xC09C, 0x49F3, [0x91, 0x93, 0xA4, 0x19, 0x22, 0xC8, 0x97, 0x15]);
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

const GUID IID_IDCompositionLinearTransferEffect = {0x4305EE5B, 0xC4A0, 0x4C88, [0x93, 0x85, 0x67, 0x12, 0x4E, 0x01, 0x76, 0x83]};
@GUID(0x4305EE5B, 0xC4A0, 0x4C88, [0x93, 0x85, 0x67, 0x12, 0x4E, 0x01, 0x76, 0x83]);
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

const GUID IID_IDCompositionTableTransferEffect = {0x9B7E82E2, 0x69C5, 0x4EB4, [0xA5, 0xF5, 0xA7, 0x03, 0x3F, 0x51, 0x32, 0xCD]};
@GUID(0x9B7E82E2, 0x69C5, 0x4EB4, [0xA5, 0xF5, 0xA7, 0x03, 0x3F, 0x51, 0x32, 0xCD]);
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

const GUID IID_IDCompositionCompositeEffect = {0x576616C0, 0xA231, 0x494D, [0xA3, 0x8D, 0x00, 0xFD, 0x5E, 0xC4, 0xDB, 0x46]};
@GUID(0x576616C0, 0xA231, 0x494D, [0xA3, 0x8D, 0x00, 0xFD, 0x5E, 0xC4, 0xDB, 0x46]);
interface IDCompositionCompositeEffect : IDCompositionFilterEffect
{
    HRESULT SetMode(D2D1_COMPOSITE_MODE mode);
}

const GUID IID_IDCompositionBlendEffect = {0x33ECDC0A, 0x578A, 0x4A11, [0x9C, 0x14, 0x0C, 0xB9, 0x05, 0x17, 0xF9, 0xC5]};
@GUID(0x33ECDC0A, 0x578A, 0x4A11, [0x9C, 0x14, 0x0C, 0xB9, 0x05, 0x17, 0xF9, 0xC5]);
interface IDCompositionBlendEffect : IDCompositionFilterEffect
{
    HRESULT SetMode(D2D1_BLEND_MODE mode);
}

const GUID IID_IDCompositionArithmeticCompositeEffect = {0x3B67DFA8, 0xE3DD, 0x4E61, [0xB6, 0x40, 0x46, 0xC2, 0xF3, 0xD7, 0x39, 0xDC]};
@GUID(0x3B67DFA8, 0xE3DD, 0x4E61, [0xB6, 0x40, 0x46, 0xC2, 0xF3, 0xD7, 0x39, 0xDC]);
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

const GUID IID_IDCompositionAffineTransform2DEffect = {0x0B74B9E8, 0xCDD6, 0x492F, [0xBB, 0xBC, 0x5E, 0xD3, 0x21, 0x57, 0x02, 0x6D]};
@GUID(0x0B74B9E8, 0xCDD6, 0x492F, [0xBB, 0xBC, 0x5E, 0xD3, 0x21, 0x57, 0x02, 0x6D]);
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

@DllImport("dcomp.dll")
HRESULT DCompositionCreateDevice(IDXGIDevice dxgiDevice, const(Guid)* iid, void** dcompositionDevice);

@DllImport("dcomp.dll")
HRESULT DCompositionCreateDevice2(IUnknown renderingDevice, const(Guid)* iid, void** dcompositionDevice);

@DllImport("dcomp.dll")
HRESULT DCompositionCreateDevice3(IUnknown renderingDevice, const(Guid)* iid, void** dcompositionDevice);

@DllImport("dcomp.dll")
HRESULT DCompositionCreateSurfaceHandle(uint desiredAccess, SECURITY_ATTRIBUTES* securityAttributes, HANDLE* surfaceHandle);

@DllImport("dcomp.dll")
HRESULT DCompositionAttachMouseWheelToHwnd(IDCompositionVisual visual, HWND hwnd, BOOL enable);

@DllImport("dcomp.dll")
HRESULT DCompositionAttachMouseDragToHwnd(IDCompositionVisual visual, HWND hwnd, BOOL enable);

