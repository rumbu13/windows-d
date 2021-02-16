module windows.wpfbitmapeffects;

public import windows.core;
public import windows.automation : BSTR;
public import windows.com : HRESULT, IUnknown;
public import windows.windowsimagingcomponent : IWICBitmapSource;

extern(Windows):


// Structs


struct MilMatrix3x2D
{
align (1):
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

// Interfaces

@GUID("F66D2E4B-B46B-42FC-859E-3DA0ECDB3C43")
interface IMILBitmapEffectConnectorInfo : IUnknown
{
    HRESULT GetIndex(uint* puiIndex);
    HRESULT GetOptimalFormat(GUID* pFormat);
    HRESULT GetNumberFormats(uint* pulNumberFormats);
    HRESULT GetFormat(uint ulIndex, GUID* pFormat);
}

@GUID("476B538A-C765-4237-BA4A-D6A880FF0CFC")
interface IMILBitmapEffectConnectionsInfo : IUnknown
{
    HRESULT GetNumberInputs(uint* puiNumInputs);
    HRESULT GetNumberOutputs(uint* puiNumOutputs);
    HRESULT GetInputConnectorInfo(uint uiIndex, IMILBitmapEffectConnectorInfo* ppConnectorInfo);
    HRESULT GetOutputConnectorInfo(uint uiIndex, IMILBitmapEffectConnectorInfo* ppConnectorInfo);
}

@GUID("C2B5D861-9B1A-4374-89B0-DEC4874D6A81")
interface IMILBitmapEffectConnections : IUnknown
{
    HRESULT GetInputConnector(uint uiIndex, IMILBitmapEffectInputConnector* ppConnector);
    HRESULT GetOutputConnector(uint uiIndex, IMILBitmapEffectOutputConnector* ppConnector);
}

@GUID("8A6FF321-C944-4A1B-9944-9954AF301258")
interface IMILBitmapEffect : IUnknown
{
    HRESULT GetOutput(uint uiIndex, IMILBitmapEffectRenderContext pContext, IWICBitmapSource* ppBitmapSource);
    HRESULT GetParentEffect(IMILBitmapEffectGroup* ppParentEffect);
    HRESULT SetInputSource(uint uiIndex, IWICBitmapSource pBitmapSource);
}

@GUID("CC2468F2-9936-47BE-B4AF-06B5DF5DBCBB")
interface IMILBitmapEffectImpl : IUnknown
{
    HRESULT IsInPlaceModificationAllowed(IMILBitmapEffectOutputConnector pOutputConnector, short* pfModifyInPlace);
    HRESULT SetParentEffect(IMILBitmapEffectGroup pParentEffect);
    HRESULT GetInputSource(uint uiIndex, IWICBitmapSource* ppBitmapSource);
    HRESULT GetInputSourceBounds(uint uiIndex, MilRectD* pRect);
    HRESULT GetInputBitmapSource(uint uiIndex, IMILBitmapEffectRenderContext pRenderContext, 
                                 short* pfModifyInPlace, IWICBitmapSource* ppBitmapSource);
    HRESULT GetOutputBitmapSource(uint uiIndex, IMILBitmapEffectRenderContext pRenderContext, 
                                  short* pfModifyInPlace, IWICBitmapSource* ppBitmapSource);
    HRESULT Initialize(IUnknown pInner);
}

@GUID("2F952360-698A-4AC6-81A1-BCFDF08EB8E8")
interface IMILBitmapEffectGroup : IUnknown
{
    HRESULT GetInteriorInputConnector(uint uiIndex, IMILBitmapEffectOutputConnector* ppConnector);
    HRESULT GetInteriorOutputConnector(uint uiIndex, IMILBitmapEffectInputConnector* ppConnector);
    HRESULT Add(IMILBitmapEffect pEffect);
}

@GUID("78FED518-1CFC-4807-8B85-6B6E51398F62")
interface IMILBitmapEffectGroupImpl : IUnknown
{
    HRESULT Preprocess(IMILBitmapEffectRenderContext pContext);
    HRESULT GetNumberChildren(uint* puiNumberChildren);
    HRESULT GetChildren(IMILBitmapEffects* pChildren);
}

@GUID("12A2EC7E-2D33-44B2-B334-1ABB7846E390")
interface IMILBitmapEffectRenderContext : IUnknown
{
    HRESULT SetOutputPixelFormat(GUID* format);
    HRESULT GetOutputPixelFormat(GUID* pFormat);
    HRESULT SetUseSoftwareRenderer(short fSoftware);
    HRESULT SetInitialTransform(MILMatrixF* pMatrix);
    HRESULT GetFinalTransform(MILMatrixF* pMatrix);
    HRESULT SetOutputDPI(double dblDpiX, double dblDpiY);
    HRESULT GetOutputDPI(double* pdblDpiX, double* pdblDpiY);
    HRESULT SetRegionOfInterest(MilRectD* pRect);
}

@GUID("4D25ACCB-797D-4FD2-B128-DFFEFF84FCC3")
interface IMILBitmapEffectRenderContextImpl : IUnknown
{
    HRESULT GetUseSoftwareRenderer(short* pfSoftware);
    HRESULT GetTransform(MILMatrixF* pMatrix);
    HRESULT UpdateTransform(MILMatrixF* pMatrix);
    HRESULT GetOutputBounds(MilRectD* pRect);
    HRESULT UpdateOutputBounds(MilRectD* pRect);
}

@GUID("33A9DF34-A403-4EC7-B07E-BC0682370845")
interface IMILBitmapEffectFactory : IUnknown
{
    HRESULT CreateEffect(const(GUID)* pguidEffect, IMILBitmapEffect* ppEffect);
    HRESULT CreateContext(IMILBitmapEffectRenderContext* ppContext);
    HRESULT CreateEffectOuter(IMILBitmapEffect* ppEffect);
}

@GUID("67E31025-3091-4DFC-98D6-DD494551461D")
interface IMILBitmapEffectPrimitive : IUnknown
{
    HRESULT GetOutput(uint uiIndex, IMILBitmapEffectRenderContext pContext, short* pfModifyInPlace, 
                      IWICBitmapSource* ppBitmapSource);
    HRESULT TransformPoint(uint uiIndex, MilPoint2D* p, short fForwardTransform, 
                           IMILBitmapEffectRenderContext pContext, short* pfPointTransformed);
    HRESULT TransformRect(uint uiIndex, MilRectD* p, short fForwardTransform, 
                          IMILBitmapEffectRenderContext pContext);
    HRESULT HasAffineTransform(uint uiIndex, short* pfAffine);
    HRESULT HasInverseTransform(uint uiIndex, short* pfHasInverse);
    HRESULT GetAffineMatrix(uint uiIndex, MilMatrix3x2D* pMatrix);
}

@GUID("CE41E00B-EFA6-44E7-B007-DD042E3AE126")
interface IMILBitmapEffectPrimitiveImpl : IUnknown
{
    HRESULT IsDirty(uint uiOutputIndex, short* pfDirty);
    HRESULT IsVolatile(uint uiOutputIndex, short* pfVolatile);
}

@GUID("51AC3DCE-67C5-448B-9180-AD3EABDDD5DD")
interface IMILBitmapEffects : IUnknown
{
    HRESULT _NewEnum(IUnknown* ppiuReturn);
    HRESULT get_Parent(IMILBitmapEffectGroup* ppEffect);
    HRESULT Item(uint uindex, IMILBitmapEffect* ppEffect);
    HRESULT get_Count(uint* puiCount);
}

@GUID("F59567B3-76C1-4D47-BA1E-79F955E350EF")
interface IMILBitmapEffectConnector : IMILBitmapEffectConnectorInfo
{
    HRESULT IsConnected(short* pfConnected);
    HRESULT GetBitmapEffect(IMILBitmapEffect* ppEffect);
}

@GUID("A9B4ECAA-7A3C-45E7-8573-F4B81B60DD6C")
interface IMILBitmapEffectInputConnector : IMILBitmapEffectConnector
{
    HRESULT ConnectTo(IMILBitmapEffectOutputConnector pConnector);
    HRESULT GetConnection(IMILBitmapEffectOutputConnector* ppConnector);
}

@GUID("92957AAD-841B-4866-82EC-8752468B07FD")
interface IMILBitmapEffectOutputConnector : IMILBitmapEffectConnector
{
    HRESULT GetNumberConnections(uint* puiNumberConnections);
    HRESULT GetConnection(uint uiIndex, IMILBitmapEffectInputConnector* ppConnection);
}

@GUID("21FAE777-8B39-4BFA-9F2D-F3941ED36913")
interface IMILBitmapEffectOutputConnectorImpl : IUnknown
{
    HRESULT AddBackLink(IMILBitmapEffectInputConnector pConnection);
    HRESULT RemoveBackLink(IMILBitmapEffectInputConnector pConnection);
}

@GUID("20287E9E-86A2-4E15-953D-EB1438A5B842")
interface IMILBitmapEffectInteriorInputConnector : IUnknown
{
    HRESULT GetInputConnector(IMILBitmapEffectInputConnector* pInputConnector);
}

@GUID("00BBB6DC-ACC9-4BFC-B344-8BEE383DFEFA")
interface IMILBitmapEffectInteriorOutputConnector : IUnknown
{
    HRESULT GetOutputConnector(IMILBitmapEffectOutputConnector* pOutputConnector);
}

@GUID("2E880DD8-F8CE-457B-8199-D60BB3D7EF98")
interface IMILBitmapEffectEvents : IUnknown
{
    HRESULT PropertyChange(IMILBitmapEffect pEffect, BSTR bstrPropertyName);
    HRESULT DirtyRegion(IMILBitmapEffect pEffect, MilRectD* pRect);
}


// GUIDs


const GUID IID_IMILBitmapEffect                        = GUIDOF!IMILBitmapEffect;
const GUID IID_IMILBitmapEffectConnections             = GUIDOF!IMILBitmapEffectConnections;
const GUID IID_IMILBitmapEffectConnectionsInfo         = GUIDOF!IMILBitmapEffectConnectionsInfo;
const GUID IID_IMILBitmapEffectConnector               = GUIDOF!IMILBitmapEffectConnector;
const GUID IID_IMILBitmapEffectConnectorInfo           = GUIDOF!IMILBitmapEffectConnectorInfo;
const GUID IID_IMILBitmapEffectEvents                  = GUIDOF!IMILBitmapEffectEvents;
const GUID IID_IMILBitmapEffectFactory                 = GUIDOF!IMILBitmapEffectFactory;
const GUID IID_IMILBitmapEffectGroup                   = GUIDOF!IMILBitmapEffectGroup;
const GUID IID_IMILBitmapEffectGroupImpl               = GUIDOF!IMILBitmapEffectGroupImpl;
const GUID IID_IMILBitmapEffectImpl                    = GUIDOF!IMILBitmapEffectImpl;
const GUID IID_IMILBitmapEffectInputConnector          = GUIDOF!IMILBitmapEffectInputConnector;
const GUID IID_IMILBitmapEffectInteriorInputConnector  = GUIDOF!IMILBitmapEffectInteriorInputConnector;
const GUID IID_IMILBitmapEffectInteriorOutputConnector = GUIDOF!IMILBitmapEffectInteriorOutputConnector;
const GUID IID_IMILBitmapEffectOutputConnector         = GUIDOF!IMILBitmapEffectOutputConnector;
const GUID IID_IMILBitmapEffectOutputConnectorImpl     = GUIDOF!IMILBitmapEffectOutputConnectorImpl;
const GUID IID_IMILBitmapEffectPrimitive               = GUIDOF!IMILBitmapEffectPrimitive;
const GUID IID_IMILBitmapEffectPrimitiveImpl           = GUIDOF!IMILBitmapEffectPrimitiveImpl;
const GUID IID_IMILBitmapEffectRenderContext           = GUIDOF!IMILBitmapEffectRenderContext;
const GUID IID_IMILBitmapEffectRenderContextImpl       = GUIDOF!IMILBitmapEffectRenderContextImpl;
const GUID IID_IMILBitmapEffects                       = GUIDOF!IMILBitmapEffects;
