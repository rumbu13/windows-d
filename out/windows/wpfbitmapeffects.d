// Written in the D programming language.

module windows.wpfbitmapeffects;

public import windows.core;
public import windows.automation : BSTR;
public import windows.com : HRESULT, IUnknown;
public import windows.windowsimagingcomponent : IWICBitmapSource;

extern(Windows) @nogc nothrow:


// Structs


///Describes the width, height, and location of a rectangle.
struct MilRectD
{
    ///Type: <b>DOUBLE</b> The location of the rectangle's left side.
    double left;
    ///Type: <b>DOUBLE</b> The location of the rectangle's top side.
    double top;
    ///Type: <b>DOUBLE</b> The location of the rectangle's right side.
    double right;
    double bottom;
}

///Represents an x- and y-coordinate pair in two-dimensional space.
struct MilPoint2D
{
    ///Type: <b>DOUBLE</b> The x-coordinate value of the point.
    double X;
    double Y;
}

///Represents a 4x4 affine transformation matrix.
struct MILMatrixF
{
    ///Type: <b>DOUBLE</b> The value of the first row and first column of the matrix.
    double _11;
    ///Type: <b>DOUBLE</b> The value of the first row and second column of the matrix.
    double _12;
    ///Type: <b>DOUBLE</b> The value of the first row and third column of the matrix.
    double _13;
    ///Type: <b>DOUBLE</b> The value of the first row and forth column of the matrix.
    double _14;
    ///Type: <b>DOUBLE</b> The value of the second row and first column of the matrix.
    double _21;
    ///Type: <b>DOUBLE</b> The value of the second row and second column of the matrix.
    double _22;
    ///Type: <b>DOUBLE</b> The value of the fisecondrst row and third column of the matrix.
    double _23;
    ///Type: <b>DOUBLE</b> The value of the second row and forth column of the matrix.
    double _24;
    ///Type: <b>DOUBLE</b> The value of the third row and first column of the matrix.
    double _31;
    ///Type: <b>DOUBLE</b> The value of the third row and second column of the matrix.
    double _32;
    ///Type: <b>DOUBLE</b> The value of the third row and third column of the matrix.
    double _33;
    ///Type: <b>DOUBLE</b> The value of the third row and forth column of the matrix.
    double _34;
    ///Type: <b>DOUBLE</b> The value of the forth row and first column of the matrix.
    double _41;
    ///Type: <b>DOUBLE</b> The value of the forth row and second column of the matrix.
    double _42;
    ///Type: <b>DOUBLE</b> The value of the forth row and thrid column of the matrix.
    double _43;
    double _44;
}

///Represents a 3x3 matrix.
struct MilMatrix3x2D
{
align (1):
    ///Type: <b>DOUBLE</b> The value of the first row and first column of the matrix.
    double S_11;
    ///Type: <b>DOUBLE</b> The value of the first row and first second of the matrix.
    double S_12;
    ///Type: <b>DOUBLE</b> The value of the second row and first column of the matrix.
    double S_21;
    ///Type: <b>DOUBLE</b> The value of the second row and second column of the matrix.
    double S_22;
    ///Type: <b>DOUBLE</b>
    double DX;
    double DY;
}

// Interfaces

///Exposes methods that retrieve information about a specific input or output connector pin.
@GUID("F66D2E4B-B46B-42FC-859E-3DA0ECDB3C43")
interface IMILBitmapEffectConnectorInfo : IUnknown
{
    ///Retrieves the zero based index value for the pin.
    ///Params:
    ///    puiIndex = Type: <b>ULONG*</b> When this method returns, contains the zero based index value for the pin.
    HRESULT GetIndex(uint* puiIndex);
    ///Retrieves the optimal pixel format for the pin.
    ///Params:
    ///    pFormat = Type: <b>WICPixelFormatGUID*</b> When this method returns, contains the optimal pixel format for the pin.
    HRESULT GetOptimalFormat(GUID* pFormat);
    ///Retrieves the number of pixel formats supported by the pin.
    ///Params:
    ///    pulNumberFormats = Type: <b>ULONG*</b> When this method returns, contains the number of pixel formats supported by the pin.
    HRESULT GetNumberFormats(uint* pulNumberFormats);
    ///Retrieves the pixel format for the given pin.
    ///Params:
    ///    ulIndex = Type: <b>ULONG</b> A zero based index value indicating the pin to retrieve the pixel format.
    ///    pFormat = Type: <b>WICPixelFormatGUID*</b> When this method returns, contains the pixel format of the given pin.
    HRESULT GetFormat(uint ulIndex, GUID* pFormat);
}

///Exposes methods that retrieves information about what input and output pins are exposed by the bitmap effect.
@GUID("476B538A-C765-4237-BA4A-D6A880FF0CFC")
interface IMILBitmapEffectConnectionsInfo : IUnknown
{
    ///Retrieves the number of input pins the bitmap effect implements.
    ///Params:
    ///    puiNumInputs = Type: <b>ULONG*</b> When this method returns, contains the number of input pins the bitmap effect implements.
    HRESULT GetNumberInputs(uint* puiNumInputs);
    ///Retrieves the number of output pins the bitmap effect implements.
    ///Params:
    ///    puiNumOutputs = Type: <b>ULONG*</b> When this method returns, contains the number of output pins the bitmap effect
    ///                    implements.
    HRESULT GetNumberOutputs(uint* puiNumOutputs);
    ///Retrieves the IMILBitmapEffectConnectorInfo associated with the given input pin.
    ///Params:
    ///    uiIndex = Type: <b>ULONG</b> A zero based index value indicating which input pin to query for connector information.
    ///    ppConnectorInfo = Type: <b>IMILBitmapEffectConnectorInfo**</b> When this method returns, contain the connector information for
    ///                      the given input pin.
    HRESULT GetInputConnectorInfo(uint uiIndex, IMILBitmapEffectConnectorInfo* ppConnectorInfo);
    ///Retrieves the IMILBitmapEffectConnectorInfo associated with the given output pin.
    ///Params:
    ///    uiIndex = Type: <b>ULONG</b> A zero based index value indicating which output pin to query for connector information.
    ///    ppConnectorInfo = Type: <b>IMILBitmapEffectConnectorInfo**</b> When this method returns, contain the connector information for
    ///                      the given output pin.
    HRESULT GetOutputConnectorInfo(uint uiIndex, IMILBitmapEffectConnectorInfo* ppConnectorInfo);
}

///Exposes methods used to retrieve input and output connectors exposed by the bitmap effect.
@GUID("C2B5D861-9B1A-4374-89B0-DEC4874D6A81")
interface IMILBitmapEffectConnections : IUnknown
{
    ///Retrieves the input connector associated with the given pin index.
    ///Params:
    ///    uiIndex = Type: <b>ULONG</b> A zero based index value indicating which input pin to use to retrieve the input
    ///              connector.
    ///    ppConnector = Type: <b>IMILBitmapEffectInputConnector**</b> When this method returns, contains the input connector for the
    ///                  given input pin.
    HRESULT GetInputConnector(uint uiIndex, IMILBitmapEffectInputConnector* ppConnector);
    ///Retrieves the output connector associated with the given pin index.
    ///Params:
    ///    uiIndex = Type: <b>ULONG</b> A zero based index value indicating which output pin to use to retrieve the output
    ///              connector.
    ///    ppConnector = Type: <b>IMILBitmapEffectOutputConnector**</b> When this method returns, contains the output connector for
    ///                  the given output pin.
    HRESULT GetOutputConnector(uint uiIndex, IMILBitmapEffectOutputConnector* ppConnector);
}

///Exposes methods that define a Windows Presentation Foundation (WPF) bitmap effect.
@GUID("8A6FF321-C944-4A1B-9944-9954AF301258")
interface IMILBitmapEffect : IUnknown
{
    ///Gets the output of the effect.
    ///Params:
    ///    uiIndex = Type: <b>ULONG</b> The output index.
    ///    pContext = Type: <b>IMILBitmapEffectRenderContext*</b> A pointer to the render context of the effect.
    ///    ppBitmapSource = Type: <b>IWICBitmapSource**</b> A pointer that receives a pointer to the effect's output.
    HRESULT GetOutput(uint uiIndex, IMILBitmapEffectRenderContext pContext, IWICBitmapSource* ppBitmapSource);
    ///Gets a parent of the effect.
    ///Params:
    ///    ppParentEffect = Type: <b>IMILBitmapEffectGroup**</b> A pointer that receives a pointer to the IMILBitmapEffectGroup.
    HRESULT GetParentEffect(IMILBitmapEffectGroup* ppParentEffect);
    ///Sets the effect input source.
    ///Params:
    ///    uiIndex = Type: <b>ULONG</b> The input index.
    ///    pBitmapSource = Type: <b>IWICBitmapSource*</b> A pointer to the effect's bitmap source.
    HRESULT SetInputSource(uint uiIndex, IWICBitmapSource pBitmapSource);
}

///Exposes methods that define an an out IMILBitmapEffect object.
@GUID("CC2468F2-9936-47BE-B4AF-06B5DF5DBCBB")
interface IMILBitmapEffectImpl : IUnknown
{
    ///Determines whether the effect allows in-place modifications.
    ///Params:
    ///    pOutputConnector = Type: <b>IMILBitmapEffectOutputConnector*</b> The output connect to check if in-place modifications are
    ///                       allowed.
    ///    pfModifyInPlace = Type: <b>VARIANT_BOOL*</b> A pointer that receives <code>TRUE</code> if in-place modifications are allowed;
    ///                      otherwise, <code>FALSE</code>.
    HRESULT IsInPlaceModificationAllowed(IMILBitmapEffectOutputConnector pOutputConnector, short* pfModifyInPlace);
    ///Sets the parent of the effect.
    ///Params:
    ///    pParentEffect = Type: <b>IMILBitmapEffectGroup*</b> The IMILBitmapEffectGroup parent of the effect.
    HRESULT SetParentEffect(IMILBitmapEffectGroup pParentEffect);
    ///Retrieves the input IWICBitmapSource Interface.
    ///Params:
    ///    uiIndex = Type: <b>ULONG</b> The index of the input source.
    ///    ppBitmapSource = Type: <b>IWICBitmapSource**</b> A pointer that receives a pointer to the input bitmap source.
    HRESULT GetInputSource(uint uiIndex, IWICBitmapSource* ppBitmapSource);
    ///Gets the bounds of the input source.
    ///Params:
    ///    uiIndex = Type: <b>ULONG</b> The index of the bitmap source to retrieve.
    ///    pRect = Type: <b>MIL_RECTD*</b> Pointer that receives the bounds of the input source.
    HRESULT GetInputSourceBounds(uint uiIndex, MilRectD* pRect);
    ///Gets the input bitmap source of the effect of the given render context.
    ///Params:
    ///    uiIndex = Type: <b>ULONG</b> The index of the of the input bitmap source.
    ///    pRenderContext = Type: <b>IMILBitmapEffectRenderContext*</b> A pointer to the IMILBitmapEffectRenderContext.
    ///    pfModifyInPlace = Type: <b>VARIANT_BOOL*</b> A value that indicates whether to modify in-place.
    ///    ppBitmapSource = Type: <b>IWICBitmapSource**</b> A pointer that receives a pointer to the input IWICBitmapSource Interface.
    HRESULT GetInputBitmapSource(uint uiIndex, IMILBitmapEffectRenderContext pRenderContext, 
                                 short* pfModifyInPlace, IWICBitmapSource* ppBitmapSource);
    ///Gets the output bitmap source of the effect of the given render context.
    ///Params:
    ///    uiIndex = Type: <b>ULONG</b> The index of the of the output bitmap source.
    ///    pRenderContext = Type: <b>IMILBitmapEffectRenderContext*</b> A pointer to the IMILBitmapEffectRenderContext.
    ///    pfModifyInPlace = Type: <b>VARIANT_BOOL*</b> A value that indicates whether to modify in-place.
    ///    ppBitmapSource = Type: <b>IWICBitmapSource**</b> A pointer that receives a pointer to the output IWICBitmapSource Interface.
    HRESULT GetOutputBitmapSource(uint uiIndex, IMILBitmapEffectRenderContext pRenderContext, 
                                  short* pfModifyInPlace, IWICBitmapSource* ppBitmapSource);
    ///Initializes the effect with the given object.
    ///Params:
    ///    pInner = Type: <b>IUnknown*</b> The object to initialize the effect with.
    HRESULT Initialize(IUnknown pInner);
}

///Exposes methods used to access a group of effects.
@GUID("2F952360-698A-4AC6-81A1-BCFDF08EB8E8")
interface IMILBitmapEffectGroup : IUnknown
{
    ///Retrieves the input connector for an effect at the given index.
    ///Params:
    ///    uiIndex = Type: <b>ULONG</b> The index of the effect to retrieve the connector.
    ///    ppConnector = Type: <b>IMILBitmapEffectOutputConnector**</b> A pointer that receives a pointer to the desired effects input
    ///                  connector.
    HRESULT GetInteriorInputConnector(uint uiIndex, IMILBitmapEffectOutputConnector* ppConnector);
    ///Retrieves the output connector for an effect at the given index.
    ///Params:
    ///    uiIndex = Type: <b>ULONG</b> The index of the effect to retrieve the connector.
    ///    ppConnector = Type: <b>IMILBitmapEffectInputConnector**</b> A pointer that receives a pointer to the desired effects output
    ///                  connector.
    HRESULT GetInteriorOutputConnector(uint uiIndex, IMILBitmapEffectInputConnector* ppConnector);
    ///Adds an effect to the IMILBitmapEffectGroup.
    ///Params:
    ///    pEffect = Type: <b>IMILBitmapEffect*</b> A pointer to the effect to add to the group.
    HRESULT Add(IMILBitmapEffect pEffect);
}

///Exposes methods that define an effect group.
@GUID("78FED518-1CFC-4807-8B85-6B6E51398F62")
interface IMILBitmapEffectGroupImpl : IUnknown
{
    ///Pre-process the given render context.
    ///Params:
    ///    pContext = Type: <b>IMILBitmapEffectRenderContext*</b> A pointer to the IMILBitmapEffectRenderContext to process.
    HRESULT Preprocess(IMILBitmapEffectRenderContext pContext);
    ///Retrieves the number of children in an effect group.
    ///Params:
    ///    puiNumberChildren = Type: <b>ULONG*</b> A pointer that receives the number of effects in the group.
    HRESULT GetNumberChildren(uint* puiNumberChildren);
    ///Gets the children of the effect group.
    ///Params:
    ///    pChildren = Type: <b>IMILBitmapEffects**</b> A pointer that receives a pointer to the IMILBitmapEffects group.
    HRESULT GetChildren(IMILBitmapEffects* pChildren);
}

///Exposes methods that define a <b>IMILBitmapEffectRenderContext</b> object.
@GUID("12A2EC7E-2D33-44B2-B334-1ABB7846E390")
interface IMILBitmapEffectRenderContext : IUnknown
{
    ///Sets the output pixel format.
    ///Params:
    ///    format = Type: <b>REFWICPixelFormatGUID</b> The GUID of the output pixel format.
    HRESULT SetOutputPixelFormat(GUID* format);
    ///Gets the output pixel format GUID.
    ///Params:
    ///    pFormat = Type: <b>WICPixelFormatGUID*</b> The output pixel format GUID
    HRESULT GetOutputPixelFormat(GUID* pFormat);
    ///Sets a value to indicate whether to use software rendering.
    ///Params:
    ///    fSoftware = Type: <b>VARIANT_BOOL</b> A value indicating whether to use software rendering.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetUseSoftwareRenderer(short fSoftware);
    ///Gets the initial MILMatrixF transform.
    ///Params:
    ///    pMatrix = Type: <b>MILMatrixF*</b> The initial transform.
    HRESULT SetInitialTransform(MILMatrixF* pMatrix);
    ///Gets the final MILMatrixF transform.
    ///Params:
    ///    pMatrix = Type: <b>MILMatrixF*</b> The final transform.
    HRESULT GetFinalTransform(MILMatrixF* pMatrix);
    ///Sets the output dots per inch (dpi).
    ///Params:
    ///    dblDpiX = Type: <b>double</b> The horizontal resolution.
    ///    dblDpiY = Type: <b>double</b> The vertical resolution.
    HRESULT SetOutputDPI(double dblDpiX, double dblDpiY);
    ///Gets the output dots per inch (dpi).
    ///Params:
    ///    pdblDpiX = Type: <b>double*</b> A pointer that receives the horizontal resolution.
    ///    pdblDpiY = Type: <b>double*</b> A pointer that receives the vertical resolution.
    HRESULT GetOutputDPI(double* pdblDpiX, double* pdblDpiY);
    ///Sets the region of interest for the effect.
    ///Params:
    ///    pRect = Type: <b>MIL_RECTD*</b> The region of interest.
    HRESULT SetRegionOfInterest(MilRectD* pRect);
}

///Exposes methods that define a IMILBitmapEffectRenderContext.
@GUID("4D25ACCB-797D-4FD2-B128-DFFEFF84FCC3")
interface IMILBitmapEffectRenderContextImpl : IUnknown
{
    ///Gets a value that indicates whether to use software rendering.
    ///Params:
    ///    pfSoftware = Type: <b>VARIANT_BOOL*</b> A pointer that receives a value that indicates whether to use software rendering.
    HRESULT GetUseSoftwareRenderer(short* pfSoftware);
    ///Gets the matrix transform of the render context.
    ///Params:
    ///    pMatrix = Type: <b>MILMatrixF*</b> The matrix transform of the render context.
    HRESULT GetTransform(MILMatrixF* pMatrix);
    ///Updates the output transform with the new matrix.
    ///Params:
    ///    pMatrix = Type: <b>MILMatrixF*</b> The new transform to use.
    HRESULT UpdateTransform(MILMatrixF* pMatrix);
    ///Gets the output bounds of the render context.
    ///Params:
    ///    pRect = Type: <b>MIL_RECTD*</b> The output bounds.
    HRESULT GetOutputBounds(MilRectD* pRect);
    ///Updates the output bounds with the given region.
    ///Params:
    ///    pRect = Type: <b>MIL_RECTD*</b> The new output bounds to use.
    HRESULT UpdateOutputBounds(MilRectD* pRect);
}

///Exposes methods used to create Windows Presentation Foundation (WPF) Microsoft Win32 bitmap effect objects.
@GUID("33A9DF34-A403-4EC7-B07E-BC0682370845")
interface IMILBitmapEffectFactory : IUnknown
{
    ///Creates an IMILBitmapEffect object.
    ///Params:
    ///    pguidEffect = Type: <b>const GUID*</b> A pointer to the GUID of the effect to create.
    ///    ppEffect = Type: <b>IMILBitmapEffect**</b> A pointer that receives a pointer to a new IMILBitmapEffectPrimitive object.
    HRESULT CreateEffect(const(GUID)* pguidEffect, IMILBitmapEffect* ppEffect);
    ///Creates an IMILBitmapEffectRenderContext object.
    ///Params:
    ///    ppContext = Type: <b>IMILBitmapEffectRenderContext**</b> A pointer that receives a pointer to a new
    ///                IMILBitmapEffectRenderContext.
    HRESULT CreateContext(IMILBitmapEffectRenderContext* ppContext);
    ///Creates an outer IMILBitmapEffect object.
    ///Params:
    ///    ppEffect = Type: <b>IMILBitmapEffect**</b> A pointer that receives a pointer to the new IMILBitmapEffect object.
    HRESULT CreateEffectOuter(IMILBitmapEffect* ppEffect);
}

///Exposes methods that create a bitmap effect's output. This interface must be implemented to create third party
///Windows Presentation Foundation (WPF) bitmap effects.
@GUID("67E31025-3091-4DFC-98D6-DD494551461D")
interface IMILBitmapEffectPrimitive : IUnknown
{
    ///Performs pixel processing for the bitmap effect.
    ///Params:
    ///    uiIndex = Type: <b>ULONG</b> A zero based index value indicating which output pin to use for output.
    ///    pContext = Type: <b>IMILBitmapEffectRenderContext*</b> The render context to use to determine how the effect should be
    ///               rendered.
    ///    pfModifyInPlace = Type: <b>VARIANT_BOOL*</b> A value that indicates whether the effect should attempt to modify the input image
    ///                      in place.
    ///    ppBitmapSource = Type: <b>IWICBitmapSource**</b> When this method returns, contains a pointer to the effect output.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetOutput(uint uiIndex, IMILBitmapEffectRenderContext pContext, short* pfModifyInPlace, 
                      IWICBitmapSource* ppBitmapSource);
    ///Transforms the given point.
    ///Params:
    ///    uiIndex = Type: <b>ULONG</b> A zero based index value indicating the output pin through which to transform the point.
    ///    p = Type: <b>MIL_2DPOINTD*</b> A pointer to the point to transform.
    ///    fForwardTransform = Type: <b>VARIANT_BOOL</b> A value indicating whether the point is being transformed from front to back in the
    ///                        effects graph.
    ///    pContext = Type: <b>IMILBitmapEffectRenderContext*</b> The render context to use for the transformation.
    ///    pfPointTransformed = Type: <b>VARIANT_BOOL*</b> When this method returns, contains a value indicating whether the point
    ///                         transformed to a known location.
    HRESULT TransformPoint(uint uiIndex, MilPoint2D* p, short fForwardTransform, 
                           IMILBitmapEffectRenderContext pContext, short* pfPointTransformed);
    ///Transforms the output of the given rectangle.
    ///Params:
    ///    uiIndex = Type: <b>ULONG</b> A zero based index value indicating the output pin through which to transform the
    ///              rectangle.
    ///    p = Type: <b>MIL_RECTD*</b> A pointer to the rectangle to transform.
    ///    fForwardTransform = Type: <b>VARIANT_BOOL</b> A value indicating whether the rectangle is being transformed from front to back in
    ///                        the effects graph.
    ///    pContext = Type: <b>IMILBitmapEffectRenderContext*</b> The render context to use for the transformation.
    HRESULT TransformRect(uint uiIndex, MilRectD* p, short fForwardTransform, 
                          IMILBitmapEffectRenderContext pContext);
    ///Determines whether the effect has an affine transform.
    ///Params:
    ///    uiIndex = Type: <b>ULONG</b> A zero based index value indicating the output pin through which to query.
    ///    pfAffine = Type: <b>VARIANT_BOOL*</b> When this method returns, contains a value indicating whether the effect has an
    ///               affine transform.
    HRESULT HasAffineTransform(uint uiIndex, short* pfAffine);
    ///Determines whether the effect has an inverse transform.
    ///Params:
    ///    uiIndex = Type: <b>ULONG</b> A zero based index value indicating the output pin through which to query.
    ///    pfHasInverse = Type: <b>VARIANT_BOOL*</b> When this method returns, contains a value indicating whether the effect has an
    ///                   inverse transform.
    HRESULT HasInverseTransform(uint uiIndex, short* pfHasInverse);
    ///Retrieves the affine transormation matrix for the effect.
    ///Params:
    ///    uiIndex = Type: <b>ULONG</b> A zero based index value indicating the output pin through which to retrieve the affine
    ///              matrix.
    ///    pMatrix = Type: <b>MIL_MATRIX3X2D*</b> When this method returns, contains a pointer to the affine matrix describing the
    ///              effects transform.
    HRESULT GetAffineMatrix(uint uiIndex, MilMatrix3x2D* pMatrix);
}

///Exposes methods that report the state of a bitmap effect. This interface must be implemented to create third party
///Windows Presentation Foundation (WPF) bitmap effects.
@GUID("CE41E00B-EFA6-44E7-B007-DD042E3AE126")
interface IMILBitmapEffectPrimitiveImpl : IUnknown
{
    ///Determines whether the effect needs to be updated.
    ///Params:
    ///    uiOutputIndex = Type: <b>ULONG</b> A zero based index value indicating the output pin to query.
    ///    pfDirty = Type: <b>VARIANT_BOOL*</b> When this method returns, contains a value indicating whether the effect needs to
    ///              be updated.
    HRESULT IsDirty(uint uiOutputIndex, short* pfDirty);
    ///Determines whether the current effect is considered volatile. If an effect is volatile, the effects framework
    ///will not attempt to cache the effect's output.
    ///Params:
    ///    uiOutputIndex = Type: <b>ULONG</b> A zero based index value indicating the output pin to query.
    ///    pfVolatile = Type: <b>VARIANT_BOOL*</b> When this method returns, contains a value indicating whether the effect is
    ///                 considered volatile.
    HRESULT IsVolatile(uint uiOutputIndex, short* pfVolatile);
}

///Exposes methods that define an enumeration of effects.
@GUID("51AC3DCE-67C5-448B-9180-AD3EABDDD5DD")
interface IMILBitmapEffects : IUnknown
{
    ///Retrieves a new enumeration.
    ///Params:
    ///    ppiuReturn = Type: <b>IUnknown**</b> A pointer that receives a pointer to the new enumeration item.
    HRESULT _NewEnum(IUnknown* ppiuReturn);
    ///Retrieves the parent effect group of enumeration.
    ///Params:
    ///    ppEffect = Type: <b>IMILBitmapEffectGroup**</b> A pointer that receives a pointer to the parent group.
    HRESULT get_Parent(IMILBitmapEffectGroup* ppEffect);
    ///Retrieves the effect at the given index.
    ///Params:
    ///    uindex = Type: <b>ULONG</b> The index of the effect.
    ///    ppEffect = Type: <b>IMILBitmapEffect**</b> A pointer that receives a pointer to the bitmap effect.
    HRESULT Item(uint uindex, IMILBitmapEffect* ppEffect);
    ///Retrieves the number of items in the enumeration.
    ///Params:
    ///    puiCount = Type: <b>ULONG*</b> A pointer that receives the number of items in the enumeration.
    HRESULT get_Count(uint* puiCount);
}

///Exposes methods that define an effect output pin.
@GUID("F59567B3-76C1-4D47-BA1E-79F955E350EF")
interface IMILBitmapEffectConnector : IMILBitmapEffectConnectorInfo
{
    ///Determines whether the connector is connected to an effect.
    ///Params:
    ///    pfConnected = Type: <b>VARIANT_BOOL*</b> A pointer that receives <code>TRUE</code> if the connector is connected to an
    ///                  effect; otherwise, <code>FALSE</code>.
    HRESULT IsConnected(short* pfConnected);
    ///Gets the IMILBitmapEffect associated with the connector.
    ///Params:
    ///    ppEffect = Type: <b>IMILBitmapEffect**</b> A pointer that receives a pointer to the bitmap effect.
    HRESULT GetBitmapEffect(IMILBitmapEffect* ppEffect);
}

///Exposes methods that define an input connect.
@GUID("A9B4ECAA-7A3C-45E7-8573-F4B81B60DD6C")
interface IMILBitmapEffectInputConnector : IMILBitmapEffectConnector
{
    ///Connects the input connector to the given output connector.
    ///Params:
    ///    pConnector = Type: <b>IMILBitmapEffectOutputConnector*</b> A pointer to the connector to connect the input to.
    HRESULT ConnectTo(IMILBitmapEffectOutputConnector pConnector);
    ///Gets the IMILBitmapEffectOutputConnector the input connector is connected to.
    ///Params:
    ///    ppConnector = Type: <b>IMILBitmapEffectOutputConnector**</b> A pointer that receives a pointer to the associated output
    ///                  connector.
    HRESULT GetConnection(IMILBitmapEffectOutputConnector* ppConnector);
}

///Exposes methods that define an output connector.
@GUID("92957AAD-841B-4866-82EC-8752468B07FD")
interface IMILBitmapEffectOutputConnector : IMILBitmapEffectConnector
{
    ///Retrieves the number of connections the output connector has.
    ///Params:
    ///    puiNumberConnections = Type: <b>ULONG*</b> The number of connects the output connector has.
    HRESULT GetNumberConnections(uint* puiNumberConnections);
    ///Gets the IMILBitmapEffectInputConnector associated with the output connector.
    ///Params:
    ///    uiIndex = Type: <b>ULONG</b> The index of the desired input connector.
    ///    ppConnection = Type: <b>IMILBitmapEffectInputConnector**</b> A pointer that receives a pointer to the associated input
    ///                   connector.
    HRESULT GetConnection(uint uiIndex, IMILBitmapEffectInputConnector* ppConnection);
}

///Exposes methods that define an output connector.
@GUID("21FAE777-8B39-4BFA-9F2D-F3941ED36913")
interface IMILBitmapEffectOutputConnectorImpl : IUnknown
{
    ///Params:
    ///    pConnection = Type: <b>IMILBitmapEffectInputConnector*</b>
    HRESULT AddBackLink(IMILBitmapEffectInputConnector pConnection);
    ///Params:
    ///    pConnection = Type: <b>IMILBitmapEffectInputConnector*</b>
    HRESULT RemoveBackLink(IMILBitmapEffectInputConnector pConnection);
}

///Exposes methods that define an interior input connector.
@GUID("20287E9E-86A2-4E15-953D-EB1438A5B842")
interface IMILBitmapEffectInteriorInputConnector : IUnknown
{
    ///Gets the IMILBitmapEffectInputConnector associated with the interior connector.
    ///Params:
    ///    pInputConnector = Type: <b>IMILBitmapEffectInputConnector**</b> A pointer that receives a pointer to the
    ///                      IMILBitmapEffectInputConnector.
    HRESULT GetInputConnector(IMILBitmapEffectInputConnector* pInputConnector);
}

///Exposes methods that define an interior output connector.
@GUID("00BBB6DC-ACC9-4BFC-B344-8BEE383DFEFA")
interface IMILBitmapEffectInteriorOutputConnector : IUnknown
{
    ///Gets the IMILBitmapEffectOutputConnector associated with the interior output connector.
    ///Params:
    ///    pOutputConnector = Type: <b>IMILBitmapEffectOutputConnector**</b>
    HRESULT GetOutputConnector(IMILBitmapEffectOutputConnector* pOutputConnector);
}

///Exposes methods that define an effect event.
@GUID("2E880DD8-F8CE-457B-8199-D60BB3D7EF98")
interface IMILBitmapEffectEvents : IUnknown
{
    ///Notifies an IMILBitmapEffectPrimitive of a property change.
    ///Params:
    ///    pEffect = Type: <b>IMILBitmapEffect*</b> The effect primitive to notify.
    ///    bstrPropertyName = Type: <b>BSTR</b> The property that has changed.
    HRESULT PropertyChange(IMILBitmapEffect pEffect, BSTR bstrPropertyName);
    ///Invalidates the specified region of the given IMILBitmapEffectPrimitive.
    ///Params:
    ///    pEffect = Type: <b>IMILBitmapEffect*</b> A pointer to the primitive to dirty.
    ///    pRect = Type: <b>MIL_RECTD*</b> A pointer to the rectangle to dirty.
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
