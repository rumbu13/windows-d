module windows.wpfbitmapeffects;

public import system;
public import windows.automation;
public import windows.com;
public import windows.windowsimagingcomponent;

extern(Windows):

struct MilMatrix3x2D
{
    double S_11;
    double S_12;
    double S_21;
    double S_22;
    double DX;
    double DY;
}

struct MilRectD
{
    double left;
    double top;
    double right;
    double bottom;
}

struct MilPoint2D
{
    double X;
    double Y;
}

struct MILMatrixF
{
    double _11;
    double _12;
    double _13;
    double _14;
    double _21;
    double _22;
    double _23;
    double _24;
    double _31;
    double _32;
    double _33;
    double _34;
    double _41;
    double _42;
    double _43;
    double _44;
}

const GUID IID_IMILBitmapEffectConnectorInfo = {0xF66D2E4B, 0xB46B, 0x42FC, [0x85, 0x9E, 0x3D, 0xA0, 0xEC, 0xDB, 0x3C, 0x43]};
@GUID(0xF66D2E4B, 0xB46B, 0x42FC, [0x85, 0x9E, 0x3D, 0xA0, 0xEC, 0xDB, 0x3C, 0x43]);
interface IMILBitmapEffectConnectorInfo : IUnknown
{
    HRESULT GetIndex(uint* puiIndex);
    HRESULT GetOptimalFormat(Guid* pFormat);
    HRESULT GetNumberFormats(uint* pulNumberFormats);
    HRESULT GetFormat(uint ulIndex, Guid* pFormat);
}

const GUID IID_IMILBitmapEffectConnectionsInfo = {0x476B538A, 0xC765, 0x4237, [0xBA, 0x4A, 0xD6, 0xA8, 0x80, 0xFF, 0x0C, 0xFC]};
@GUID(0x476B538A, 0xC765, 0x4237, [0xBA, 0x4A, 0xD6, 0xA8, 0x80, 0xFF, 0x0C, 0xFC]);
interface IMILBitmapEffectConnectionsInfo : IUnknown
{
    HRESULT GetNumberInputs(uint* puiNumInputs);
    HRESULT GetNumberOutputs(uint* puiNumOutputs);
    HRESULT GetInputConnectorInfo(uint uiIndex, IMILBitmapEffectConnectorInfo* ppConnectorInfo);
    HRESULT GetOutputConnectorInfo(uint uiIndex, IMILBitmapEffectConnectorInfo* ppConnectorInfo);
}

const GUID IID_IMILBitmapEffectConnections = {0xC2B5D861, 0x9B1A, 0x4374, [0x89, 0xB0, 0xDE, 0xC4, 0x87, 0x4D, 0x6A, 0x81]};
@GUID(0xC2B5D861, 0x9B1A, 0x4374, [0x89, 0xB0, 0xDE, 0xC4, 0x87, 0x4D, 0x6A, 0x81]);
interface IMILBitmapEffectConnections : IUnknown
{
    HRESULT GetInputConnector(uint uiIndex, IMILBitmapEffectInputConnector* ppConnector);
    HRESULT GetOutputConnector(uint uiIndex, IMILBitmapEffectOutputConnector* ppConnector);
}

const GUID IID_IMILBitmapEffect = {0x8A6FF321, 0xC944, 0x4A1B, [0x99, 0x44, 0x99, 0x54, 0xAF, 0x30, 0x12, 0x58]};
@GUID(0x8A6FF321, 0xC944, 0x4A1B, [0x99, 0x44, 0x99, 0x54, 0xAF, 0x30, 0x12, 0x58]);
interface IMILBitmapEffect : IUnknown
{
    HRESULT GetOutput(uint uiIndex, IMILBitmapEffectRenderContext pContext, IWICBitmapSource* ppBitmapSource);
    HRESULT GetParentEffect(IMILBitmapEffectGroup* ppParentEffect);
    HRESULT SetInputSource(uint uiIndex, IWICBitmapSource pBitmapSource);
}

const GUID IID_IMILBitmapEffectImpl = {0xCC2468F2, 0x9936, 0x47BE, [0xB4, 0xAF, 0x06, 0xB5, 0xDF, 0x5D, 0xBC, 0xBB]};
@GUID(0xCC2468F2, 0x9936, 0x47BE, [0xB4, 0xAF, 0x06, 0xB5, 0xDF, 0x5D, 0xBC, 0xBB]);
interface IMILBitmapEffectImpl : IUnknown
{
    HRESULT IsInPlaceModificationAllowed(IMILBitmapEffectOutputConnector pOutputConnector, short* pfModifyInPlace);
    HRESULT SetParentEffect(IMILBitmapEffectGroup pParentEffect);
    HRESULT GetInputSource(uint uiIndex, IWICBitmapSource* ppBitmapSource);
    HRESULT GetInputSourceBounds(uint uiIndex, MilRectD* pRect);
    HRESULT GetInputBitmapSource(uint uiIndex, IMILBitmapEffectRenderContext pRenderContext, short* pfModifyInPlace, IWICBitmapSource* ppBitmapSource);
    HRESULT GetOutputBitmapSource(uint uiIndex, IMILBitmapEffectRenderContext pRenderContext, short* pfModifyInPlace, IWICBitmapSource* ppBitmapSource);
    HRESULT Initialize(IUnknown pInner);
}

const GUID IID_IMILBitmapEffectGroup = {0x2F952360, 0x698A, 0x4AC6, [0x81, 0xA1, 0xBC, 0xFD, 0xF0, 0x8E, 0xB8, 0xE8]};
@GUID(0x2F952360, 0x698A, 0x4AC6, [0x81, 0xA1, 0xBC, 0xFD, 0xF0, 0x8E, 0xB8, 0xE8]);
interface IMILBitmapEffectGroup : IUnknown
{
    HRESULT GetInteriorInputConnector(uint uiIndex, IMILBitmapEffectOutputConnector* ppConnector);
    HRESULT GetInteriorOutputConnector(uint uiIndex, IMILBitmapEffectInputConnector* ppConnector);
    HRESULT Add(IMILBitmapEffect pEffect);
}

const GUID IID_IMILBitmapEffectGroupImpl = {0x78FED518, 0x1CFC, 0x4807, [0x8B, 0x85, 0x6B, 0x6E, 0x51, 0x39, 0x8F, 0x62]};
@GUID(0x78FED518, 0x1CFC, 0x4807, [0x8B, 0x85, 0x6B, 0x6E, 0x51, 0x39, 0x8F, 0x62]);
interface IMILBitmapEffectGroupImpl : IUnknown
{
    HRESULT Preprocess(IMILBitmapEffectRenderContext pContext);
    HRESULT GetNumberChildren(uint* puiNumberChildren);
    HRESULT GetChildren(IMILBitmapEffects* pChildren);
}

const GUID IID_IMILBitmapEffectRenderContext = {0x12A2EC7E, 0x2D33, 0x44B2, [0xB3, 0x34, 0x1A, 0xBB, 0x78, 0x46, 0xE3, 0x90]};
@GUID(0x12A2EC7E, 0x2D33, 0x44B2, [0xB3, 0x34, 0x1A, 0xBB, 0x78, 0x46, 0xE3, 0x90]);
interface IMILBitmapEffectRenderContext : IUnknown
{
    HRESULT SetOutputPixelFormat(Guid* format);
    HRESULT GetOutputPixelFormat(Guid* pFormat);
    HRESULT SetUseSoftwareRenderer(short fSoftware);
    HRESULT SetInitialTransform(MILMatrixF* pMatrix);
    HRESULT GetFinalTransform(MILMatrixF* pMatrix);
    HRESULT SetOutputDPI(double dblDpiX, double dblDpiY);
    HRESULT GetOutputDPI(double* pdblDpiX, double* pdblDpiY);
    HRESULT SetRegionOfInterest(MilRectD* pRect);
}

const GUID IID_IMILBitmapEffectRenderContextImpl = {0x4D25ACCB, 0x797D, 0x4FD2, [0xB1, 0x28, 0xDF, 0xFE, 0xFF, 0x84, 0xFC, 0xC3]};
@GUID(0x4D25ACCB, 0x797D, 0x4FD2, [0xB1, 0x28, 0xDF, 0xFE, 0xFF, 0x84, 0xFC, 0xC3]);
interface IMILBitmapEffectRenderContextImpl : IUnknown
{
    HRESULT GetUseSoftwareRenderer(short* pfSoftware);
    HRESULT GetTransform(MILMatrixF* pMatrix);
    HRESULT UpdateTransform(MILMatrixF* pMatrix);
    HRESULT GetOutputBounds(MilRectD* pRect);
    HRESULT UpdateOutputBounds(MilRectD* pRect);
}

const GUID IID_IMILBitmapEffectFactory = {0x33A9DF34, 0xA403, 0x4EC7, [0xB0, 0x7E, 0xBC, 0x06, 0x82, 0x37, 0x08, 0x45]};
@GUID(0x33A9DF34, 0xA403, 0x4EC7, [0xB0, 0x7E, 0xBC, 0x06, 0x82, 0x37, 0x08, 0x45]);
interface IMILBitmapEffectFactory : IUnknown
{
    HRESULT CreateEffect(const(Guid)* pguidEffect, IMILBitmapEffect* ppEffect);
    HRESULT CreateContext(IMILBitmapEffectRenderContext* ppContext);
    HRESULT CreateEffectOuter(IMILBitmapEffect* ppEffect);
}

const GUID IID_IMILBitmapEffectPrimitive = {0x67E31025, 0x3091, 0x4DFC, [0x98, 0xD6, 0xDD, 0x49, 0x45, 0x51, 0x46, 0x1D]};
@GUID(0x67E31025, 0x3091, 0x4DFC, [0x98, 0xD6, 0xDD, 0x49, 0x45, 0x51, 0x46, 0x1D]);
interface IMILBitmapEffectPrimitive : IUnknown
{
    HRESULT GetOutput(uint uiIndex, IMILBitmapEffectRenderContext pContext, short* pfModifyInPlace, IWICBitmapSource* ppBitmapSource);
    HRESULT TransformPoint(uint uiIndex, MilPoint2D* p, short fForwardTransform, IMILBitmapEffectRenderContext pContext, short* pfPointTransformed);
    HRESULT TransformRect(uint uiIndex, MilRectD* p, short fForwardTransform, IMILBitmapEffectRenderContext pContext);
    HRESULT HasAffineTransform(uint uiIndex, short* pfAffine);
    HRESULT HasInverseTransform(uint uiIndex, short* pfHasInverse);
    HRESULT GetAffineMatrix(uint uiIndex, MilMatrix3x2D* pMatrix);
}

const GUID IID_IMILBitmapEffectPrimitiveImpl = {0xCE41E00B, 0xEFA6, 0x44E7, [0xB0, 0x07, 0xDD, 0x04, 0x2E, 0x3A, 0xE1, 0x26]};
@GUID(0xCE41E00B, 0xEFA6, 0x44E7, [0xB0, 0x07, 0xDD, 0x04, 0x2E, 0x3A, 0xE1, 0x26]);
interface IMILBitmapEffectPrimitiveImpl : IUnknown
{
    HRESULT IsDirty(uint uiOutputIndex, short* pfDirty);
    HRESULT IsVolatile(uint uiOutputIndex, short* pfVolatile);
}

const GUID IID_IMILBitmapEffects = {0x51AC3DCE, 0x67C5, 0x448B, [0x91, 0x80, 0xAD, 0x3E, 0xAB, 0xDD, 0xD5, 0xDD]};
@GUID(0x51AC3DCE, 0x67C5, 0x448B, [0x91, 0x80, 0xAD, 0x3E, 0xAB, 0xDD, 0xD5, 0xDD]);
interface IMILBitmapEffects : IUnknown
{
    HRESULT _NewEnum(IUnknown* ppiuReturn);
    HRESULT get_Parent(IMILBitmapEffectGroup* ppEffect);
    HRESULT Item(uint uindex, IMILBitmapEffect* ppEffect);
    HRESULT get_Count(uint* puiCount);
}

const GUID IID_IMILBitmapEffectConnector = {0xF59567B3, 0x76C1, 0x4D47, [0xBA, 0x1E, 0x79, 0xF9, 0x55, 0xE3, 0x50, 0xEF]};
@GUID(0xF59567B3, 0x76C1, 0x4D47, [0xBA, 0x1E, 0x79, 0xF9, 0x55, 0xE3, 0x50, 0xEF]);
interface IMILBitmapEffectConnector : IMILBitmapEffectConnectorInfo
{
    HRESULT IsConnected(short* pfConnected);
    HRESULT GetBitmapEffect(IMILBitmapEffect* ppEffect);
}

const GUID IID_IMILBitmapEffectInputConnector = {0xA9B4ECAA, 0x7A3C, 0x45E7, [0x85, 0x73, 0xF4, 0xB8, 0x1B, 0x60, 0xDD, 0x6C]};
@GUID(0xA9B4ECAA, 0x7A3C, 0x45E7, [0x85, 0x73, 0xF4, 0xB8, 0x1B, 0x60, 0xDD, 0x6C]);
interface IMILBitmapEffectInputConnector : IMILBitmapEffectConnector
{
    HRESULT ConnectTo(IMILBitmapEffectOutputConnector pConnector);
    HRESULT GetConnection(IMILBitmapEffectOutputConnector* ppConnector);
}

const GUID IID_IMILBitmapEffectOutputConnector = {0x92957AAD, 0x841B, 0x4866, [0x82, 0xEC, 0x87, 0x52, 0x46, 0x8B, 0x07, 0xFD]};
@GUID(0x92957AAD, 0x841B, 0x4866, [0x82, 0xEC, 0x87, 0x52, 0x46, 0x8B, 0x07, 0xFD]);
interface IMILBitmapEffectOutputConnector : IMILBitmapEffectConnector
{
    HRESULT GetNumberConnections(uint* puiNumberConnections);
    HRESULT GetConnection(uint uiIndex, IMILBitmapEffectInputConnector* ppConnection);
}

const GUID IID_IMILBitmapEffectOutputConnectorImpl = {0x21FAE777, 0x8B39, 0x4BFA, [0x9F, 0x2D, 0xF3, 0x94, 0x1E, 0xD3, 0x69, 0x13]};
@GUID(0x21FAE777, 0x8B39, 0x4BFA, [0x9F, 0x2D, 0xF3, 0x94, 0x1E, 0xD3, 0x69, 0x13]);
interface IMILBitmapEffectOutputConnectorImpl : IUnknown
{
    HRESULT AddBackLink(IMILBitmapEffectInputConnector pConnection);
    HRESULT RemoveBackLink(IMILBitmapEffectInputConnector pConnection);
}

const GUID IID_IMILBitmapEffectInteriorInputConnector = {0x20287E9E, 0x86A2, 0x4E15, [0x95, 0x3D, 0xEB, 0x14, 0x38, 0xA5, 0xB8, 0x42]};
@GUID(0x20287E9E, 0x86A2, 0x4E15, [0x95, 0x3D, 0xEB, 0x14, 0x38, 0xA5, 0xB8, 0x42]);
interface IMILBitmapEffectInteriorInputConnector : IUnknown
{
    HRESULT GetInputConnector(IMILBitmapEffectInputConnector* pInputConnector);
}

const GUID IID_IMILBitmapEffectInteriorOutputConnector = {0x00BBB6DC, 0xACC9, 0x4BFC, [0xB3, 0x44, 0x8B, 0xEE, 0x38, 0x3D, 0xFE, 0xFA]};
@GUID(0x00BBB6DC, 0xACC9, 0x4BFC, [0xB3, 0x44, 0x8B, 0xEE, 0x38, 0x3D, 0xFE, 0xFA]);
interface IMILBitmapEffectInteriorOutputConnector : IUnknown
{
    HRESULT GetOutputConnector(IMILBitmapEffectOutputConnector* pOutputConnector);
}

const GUID IID_IMILBitmapEffectEvents = {0x2E880DD8, 0xF8CE, 0x457B, [0x81, 0x99, 0xD6, 0x0B, 0xB3, 0xD7, 0xEF, 0x98]};
@GUID(0x2E880DD8, 0xF8CE, 0x457B, [0x81, 0x99, 0xD6, 0x0B, 0xB3, 0xD7, 0xEF, 0x98]);
interface IMILBitmapEffectEvents : IUnknown
{
    HRESULT PropertyChange(IMILBitmapEffect pEffect, BSTR bstrPropertyName);
    HRESULT DirtyRegion(IMILBitmapEffect pEffect, MilRectD* pRect);
}

