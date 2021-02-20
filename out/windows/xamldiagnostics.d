// Written in the D programming language.

module windows.xamldiagnostics;

public import windows.core;
public import windows.automation : BSTR, SAFEARRAY;
public import windows.com : HRESULT, IUnknown;
public import windows.displaydevices : RECT;
public import windows.dxgi : DXGI_ALPHA_MODE, DXGI_FORMAT;
public import windows.systemservices : BOOL, PWSTR;
public import windows.winrt : IInspectable;

extern(Windows) @nogc nothrow:


// Enums


///Defines constants that specify whether the element was added to or removed from the live visual tree.
enum VisualMutationType : int
{
    ///The child element was added to the visual tree of the parent element.
    Add     = 0x00000000,
    ///The child element was removed from the visual tree of the parent element.
    Remove  = 0x00000001,
}

///Defines constants that specify where the effective value of a property was set.
enum BaseValueSource : int
{
    ///The source of the property value is not known.
    BaseValueSourceUnknown      = 0x00000000,
    ///The value has not been set locally or by any styles, so it has the default value defined in generic.xaml.
    BaseValueSourceDefault      = 0x00000001,
    ///The value was set by a built-in style.
    BaseValueSourceBuiltInStyle = 0x00000002,
    ///The value was set by a style.
    BaseValueSourceStyle        = 0x00000003,
    ///The value was set locally.
    BaseValueSourceLocal        = 0x00000004,
    ///The value was inherited from a parent element.
    Inherited                   = 0x00000005,
    ///The value was set by a default style trigger.
    DefaultStyleTrigger         = 0x00000006,
    ///The value was set by a template style.
    TemplateTrigger             = 0x00000007,
    ///The value was set by a style trigger.
    StyleTrigger                = 0x00000008,
    ///The value was set by an implicit style reference.
    ImplicitStyleReference      = 0x00000009,
    ///The value was set by a parent template.
    ParentTemplate              = 0x0000000a,
    ///The value was set by a parent template trigger.
    ParentTemplateTrigger       = 0x0000000b,
    ///The value was set by an animation.
    Animation                   = 0x0000000c,
    ///The value was coerced in code.
    Coercion                    = 0x0000000d,
    BaseValueSourceVisualState  = 0x0000000e,
}

///Defines constants that are used to define the PropertyChainValue returned from XAML Diagnostics.
enum MetadataBit : int
{
    ///No special bits are set.
    None                           = 0x00000000,
    ///The value represents a string representation of an <b>InstanceHandle</b>.
    IsValueHandle                  = 0x00000001,
    ///The property is read only and cannot be set locally.
    IsPropertyReadOnly             = 0x00000002,
    ///The value represents a collection object. (When set, <b>IsValueHandle</b> is also set.)
    IsValueCollection              = 0x00000004,
    ///The value represents a read only collection.
    IsValueCollectionReadOnly      = 0x00000008,
    ///The value represents the evaluated value of a binding expression.
    IsValueBindingExpression       = 0x00000010,
    ///The value is <b>null</b>. (Introduced in Windows 10, version 1607.)
    IsValueNull                    = 0x00000020,
    IsValueHandleAndEvaluatedValue = 0x00000040,
}

///Defines constants that specify what parts of the visual tree should be rendered.
enum RenderTargetBitmapOptions : int
{
    ///Only the texture associated with the visual should be rendered.
    RenderTarget            = 0x00000000,
    ///The texture associated with the visual and its children should be rendered.
    RenderTargetAndChildren = 0x00000001,
}

///Defines constants that specify the type of a resource in a resource dictionary.
enum ResourceType : int
{
    ///The resource is a StaticResource.
    ResourceTypeStatic = 0x00000000,
    ///The resource is a ThemeResource.
    ResourceTypeTheme  = 0x00000001,
}

///Defines constants that specify the state of an element in the visual tree.
enum VisualElementState : int
{
    ///The error has been fixed.
    ErrorResolved         = 0x00000000,
    ///The resource could not be resolved.
    ErrorResourceNotFound = 0x00000001,
    ///The resource was found, but does not match the property.
    ErrorInvalidResource  = 0x00000002,
}

// Structs


///Represents information about an object’s XAML source document.
struct SourceInfo
{
    ///The name of the source document file where the element is declared.
    BSTR FileName;
    ///The line number in the source document where the element is declared.
    uint LineNumber;
    ///The position on the line in the source document where the element is declared.
    uint ColumnNumber;
    ///The character position in the source document.
    uint CharPosition;
    BSTR Hash;
}

///Associates a parent object with a child object.
struct ParentChildRelation
{
    ///A handle to the parent object.
    ulong Parent;
    ///A handle to the child object.
    ulong Child;
    uint  ChildIndex;
}

///Represents a XAML element in the Live Visual Tree in Microsoft Visual Studio.
struct VisualElement
{
    ///A handle to the object.
    ulong      Handle;
    ///Information about the XAML source document.
    SourceInfo SrcInfo;
    ///The type of the object.
    BSTR       Type;
    ///The name of the XAML element, if it has an x:Name defined in markup.
    BSTR       Name;
    uint       NumChildren;
}

///Represents the source object (a Style) of a target type.
struct PropertyChainSource
{
    ///A handle to the style.
    ulong           Handle;
    ///The target type of the style, defined in markup.
    BSTR            TargetType;
    ///The name of the style, if it has an x:Name defined in markup.
    BSTR            Name;
    ///Where the style is defined in the application .
    BaseValueSource Source;
    SourceInfo      SrcInfo;
}

///Represents a property defined on an element.
struct PropertyChainValue
{
    ///The index of property in the XAML runtime.
    uint Index;
    ///The type of the object.
    BSTR Type;
    ///The base type of the object.
    BSTR DeclaringType;
    ///The type of the current value of the property.
    BSTR ValueType;
    ///Collection item type, or <b>null</b> if not a collection.
    BSTR ItemType;
    ///The value of the property. (Represents an <b>InstanceHandle</b> if MetadataBit is set.)
    BSTR Value;
    ///Indicates whether the property is overridden by some property in the value chain.
    BOOL Overridden;
    ///A bit field that represents MetadataBits.
    long MetadataBits;
    ///The name of the property.
    BSTR PropertyName;
    uint PropertyChainIndex;
}

///Represents a XAML Runtime enumeration.
struct EnumType
{
    ///The name of the enumeration.
    BSTR       Name;
    ///An array of int values in the enumeration.
    SAFEARRAY* ValueInts;
    SAFEARRAY* ValueStrings;
}

///Represents an element in a collection.
struct CollectionElementValue
{
    ///The collection index where the element was found.
    uint Index;
    ///The type of the element object.
    BSTR ValueType;
    ///The value of the element.
    BSTR Value;
    long MetadataBits;
}

///Represents information about the bitmap stored in IBitmapData.
struct BitmapDescription
{
    ///The width of the bitmap.
    uint            Width;
    ///The height of the bitmap.
    uint            Height;
    ///The format of the bitmap.
    DXGI_FORMAT     Format;
    DXGI_ALPHA_MODE AlphaMode;
}

// Functions

@DllImport("Windows.UI.Xaml")
HRESULT InitializeXamlDiagnostic(const(PWSTR) endPointName, uint pid, const(PWSTR) wszDllXamlDiagnostics, 
                                 const(PWSTR) wszTAPDllName, GUID tapClsid);

///Initializes a Xaml Diagnostics session. This is the entry point for any debugging tool using the XAML Diagnostic
///APIs.
///Params:
///    endPointName = The end point name for Visual Diagnostics.
///    pid = The pid of the process to connect to.
///    wszDllXamlDiagnostics = The path to XamlDiagnostics.dll.
///    wszTAPDllName = The name of the DLL to be injected in the process.
///    tapClsid = The COM CLSID of the DLL to be injected in the process.
@DllImport("Windows.UI.Xaml")
HRESULT InitializeXamlDiagnosticsEx(const(PWSTR) endPointName, uint pid, const(PWSTR) wszDllXamlDiagnostics, 
                                    const(PWSTR) wszTAPDllName, GUID tapClsid, const(PWSTR) wszInitializationData);


// Interfaces

///Communicates the state of the visual tree.
@GUID("AA7A8931-80E4-4FEC-8F3B-553F87B4966E")
interface IVisualTreeServiceCallback : IUnknown
{
    ///Communicates the state of the visual tree when it changes.
    ///Params:
    ///    relation = The association of a parent object with a child object.
    ///    element = The XAML element in the visual tree.
    ///    mutationType = A value that indicates whether the change was an add or remove.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT OnVisualTreeChange(ParentChildRelation relation, VisualElement element, 
                               VisualMutationType mutationType);
}

///Represents additional capabilities of an IVisualTreeServiceCallback object.
@GUID("BAD9EB88-AE77-4397-B948-5FA2DB0A19EA")
interface IVisualTreeServiceCallback2 : IVisualTreeServiceCallback
{
    ///Communicates the state of an element in the visual tree when it changes.
    ///Params:
    ///    element = The XAML element in the visual tree.
    ///    elementState = The state of the element.
    ///    context = The path to the element.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnElementStateChanged(ulong element, VisualElementState elementState, const(PWSTR) context);
}

///Provides methods to manage a XAML visual tree.
@GUID("A593B11A-D17F-48BB-8F66-83910731C8A5")
interface IVisualTreeService : IUnknown
{
    ///Starts listening for changes to the visual tree.
    ///Params:
    ///    pCallback = The callback to register for mutation events.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT AdviseVisualTreeChange(IVisualTreeServiceCallback pCallback);
    ///Stops listening for changes to the visual tree.
    ///Params:
    ///    pCallback = The callback to unregister for mutation events.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT UnadviseVisualTreeChange(IVisualTreeServiceCallback pCallback);
    ///Gets an array of all the enums defined in the XAML runtime and the total count.
    ///Params:
    ///    pCount = The count of enums in the array.
    ///    ppEnums = An array of enums defined in the XAML runtime.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code. This
    ///    method should not fail in normal conditions.
    ///    
    HRESULT GetEnums(uint* pCount, EnumType** ppEnums);
    ///Creates an instance of any XAML runtime, enum, or primitive type.
    ///Params:
    ///    typeName = The type name. (Should be from PropertyChainValue.Type.)
    ///    value = The value to set on a primitive or enum type. <b>null</b> if creating a XAML runtime type.
    ///    pInstanceHandle = An instance handle to newly created instance.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT CreateInstance(BSTR typeName, BSTR value, ulong* pInstanceHandle);
    ///Gets an array of all the properties set on the element passed in, and an array of all the styles involved in
    ///setting the effective values of the properties.
    ///Params:
    ///    instanceHandle = A handle to the element to query properties on.
    ///    pSourceCount = The count of the property sources array.
    ///    ppPropertySources = An array of property sources.
    ///    pPropertyCount = The count of the property values array.
    ///    ppPropertyValues = An array of property values.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code. This
    ///    method should not fail in normal conditions.
    ///    
    HRESULT GetPropertyValuesChain(ulong instanceHandle, uint* pSourceCount, 
                                   PropertyChainSource** ppPropertySources, uint* pPropertyCount, 
                                   PropertyChainValue** ppPropertyValues);
    ///Sets a property value on a XAML element.
    ///Params:
    ///    instanceHandle = A handle to the element to set the property on.
    ///    value = A handle to the value to set on the element property.
    ///    propertyIndex = The index (in the XAML runtime cache) of the property to set.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetProperty(ulong instanceHandle, ulong value, uint propertyIndex);
    ///Clears the specified property on a XAML element.
    ///Params:
    ///    instanceHandle = A handle to the element to set the property on.
    ///    propertyIndex = The index (in the XAML runtime cache) of the property to clear.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT ClearProperty(ulong instanceHandle, uint propertyIndex);
    ///Gets the count of a collection.
    ///Params:
    ///    instanceHandle = A handle to the collection object.
    ///    pCollectionSize = The number of elements in the collection.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCollectionCount(ulong instanceHandle, uint* pCollectionSize);
    ///Gets the elements in a collection.
    ///Params:
    ///    instanceHandle = A handle to the collection object.
    ///    startIndex = The index in the collection to start getting elements from.
    ///    pElementCount = The count of elements in the returned array.
    ///    ppElementValues = An array of elements returned from the collection.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCollectionElements(ulong instanceHandle, uint startIndex, uint* pElementCount, 
                                  CollectionElementValue** ppElementValues);
    ///Adds a child element to the collection at the specified index.
    ///Params:
    ///    parent = A handle to the collection object.
    ///    child = A handle to the element to place into the collection. This can be newly created through CreateInstance or
    ///            shared, such as <b>SolidColorBrush</b>.
    ///    index = Location in <i>parent</i> collection at which to insert <i>child</i> element.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT AddChild(ulong parent, ulong child, uint index);
    ///Removes the child element from the specified index.
    ///Params:
    ///    parent = A handle to the collection object.
    ///    index = Location in <i>parent</i> collection at which to remove the child element.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code. The
    ///    method will fail if index is outside of the collection range.
    ///    
    HRESULT RemoveChild(ulong parent, uint index);
    ///Clears all child elements from the parent collection.
    ///Params:
    ///    parent = A handle to the collection object.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT ClearChildren(ulong parent);
}

///Represents a XAML Diagnostics session.
@GUID("18C9E2B6-3F43-4116-9F2B-FF935D7770D2")
interface IXamlDiagnostics : IUnknown
{
    ///Gets the core dispatcher used to access elements on the UI thread.
    ///Params:
    ///    ppDispatcher = The core dispatcher.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetDispatcher(IInspectable* ppDispatcher);
    ///Gets the visual diagnostics root that can be used to draw on for highlighting elements in the tree.
    ///Params:
    ///    ppLayer = The visual diagnostics root.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetUiLayer(IInspectable* ppLayer);
    ///Gets an instance of the application.
    ///Params:
    ///    ppApplication = The application.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetApplication(IInspectable* ppApplication);
    ///Gets the IInspectable from the XAML Diagnostics cache.
    ///Params:
    ///    instanceHandle = A handle to the object.
    ///    ppInstance = The object as an IInspectable.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetIInspectableFromHandle(ulong instanceHandle, IInspectable* ppInstance);
    ///Gets an <b>InstanceHandle</b> representation of an IInspectable.
    ///Params:
    ///    pInstance = An instance of the object as an IInspectable.
    ///    pHandle = A handle to the object.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetHandleFromIInspectable(IInspectable pInstance, ulong* pHandle);
    ///Gets all elements in the visual tree that fall within the specified rectangle.
    ///Params:
    ///    rect = The area to hit test.
    ///    pCount = The size of the array.
    ///    ppInstanceHandles = An array containing all elements.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT HitTest(RECT rect, uint* pCount, ulong** ppInstanceHandles);
    ///Adds an IInspectable to the XAML Diagnostics cache and returns the newly created <b>InstanceHandle</b> for the
    ///object.
    ///Params:
    ///    pInstance = An instance of the object.
    ///    pInstanceHandle = A handle to the object.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT RegisterInstance(IInspectable pInstance, ulong* pInstanceHandle);
    ///Gets the initialization data passed in to XAML Diagnostics.
    ///Params:
    ///    pInitializationData = The initialization data.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetInitializationData(BSTR* pInitializationData);
}

///Represents an image associated with a node in the visual tree.
@GUID("D1A34EF2-CAD8-4635-A3D2-FCDA8D3F3CAF")
interface IBitmapData : IUnknown
{
    ///Copies up to the specified maximum number of bytes from the given offset in the bitmap data into the caller’s
    ///buffer (<i>pvBytes</i>), and returns the number of bytes copied.
    ///Params:
    ///    sourceOffsetInBytes = The place in the bitmap data to start copying from, in bytes.
    ///    maxBytesToCopy = The maximum number of bytes to copy.
    ///    pvBytes = The buffer into which the bytes are copied.
    ///    numberOfBytesCopied = The number of bytes copied.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CopyBytesTo(uint sourceOffsetInBytes, uint maxBytesToCopy, ubyte* pvBytes, uint* numberOfBytesCopied);
    ///Gets the stride of the data. This is the length in bytes of each row of the bitmap.
    ///Params:
    ///    pStride = The length in bytes of each row of the bitmap.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetStride(uint* pStride);
    ///Gets a BitmapDescription that describes the bitmap data stored in the IBitmapData.
    ///Params:
    ///    pBitmapDescription = Information about the bitmap stored in the IBitmapData.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetBitmapDescription(BitmapDescription* pBitmapDescription);
    ///Gets a BitmapDescription that describes the original format of the bitmap data stored in the IBitmapData.
    ///Params:
    ///    pBitmapDescription = Information about the original format of the bitmap stored in the IBitmapData.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSourceBitmapDescription(BitmapDescription* pBitmapDescription);
}

///Represents additional capabilities of an IVisualTreeService object.
@GUID("130F5136-EC43-4F61-89C7-9801A36D2E95")
interface IVisualTreeService2 : IVisualTreeService
{
    ///Gets the property index for the specified property name.
    ///Params:
    ///    object = The dependency object to get the property index from.
    ///    propertyName = The name of the dependency property for which to get the index.
    ///    pPropertyIndex = The index of the specified property.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> No property with <i>propertyName</i> was found, or
    ///    the property cannot be applied to <i>object</i>. </td> </tr> </table>
    ///    
    HRESULT GetPropertyIndex(ulong object, const(PWSTR) propertyName, uint* pPropertyIndex);
    ///Gets the effective value of the specified dependency property.
    ///Params:
    ///    object = The dependency object to get the property value from.
    ///    propertyIndex = The index of the property to get the value from.
    ///    pValue = The effective value of the property.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetProperty(ulong object, uint propertyIndex, ulong* pValue);
    ///Replaces an existing resource with a new one of the same type.
    ///Params:
    ///    resourceDictionary = The dictionary that contains the resource to replace.
    ///    key = The key of the resource to replace.
    ///    newValue = The value to replace the resource with.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ReplaceResource(ulong resourceDictionary, ulong key, ulong newValue);
    ///Returns an image that represents the object described by handle, or returns an error if the object does not have
    ///or cannot provide such an image.
    ///Params:
    ///    handle = The handle associated with the visual for which the caller is requesting a bitmap.
    ///    options = A flag that specifies whether only the texture associated with the visual should be rendered, or whether the
    ///              texture and its children should be rendered.
    ///    maxPixelWidth = The maximum width, in pixels, of the returned bitmap.
    ///    maxPixelHeight = The maximum height, in pixels, of the returned bitmap.
    ///    ppBitmapData = The structure containing the requested bitmap information as well as information pertaining to that bitmap.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. <i>ppBitmapData</i> will be set to an IBitmapData containing an
    ///    image. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The image
    ///    could not be acquired or converted. <i>ppBitmapData</i> will be set to <b>NULL</b>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i> handle</i> does not refer to
    ///    an object that can return an image, the <i>options</i> value is invalid, or <i>ppBitmapData</i> is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT RenderTargetBitmap(ulong handle, RenderTargetBitmapOptions options, uint maxPixelWidth, 
                               uint maxPixelHeight, IBitmapData* ppBitmapData);
}

///Represents additional capabilities of an IVisualTreeService2 object.
@GUID("0E79C6E0-85A0-4BE8-B41A-655CF1FD19BD")
interface IVisualTreeService3 : IVisualTreeService2
{
    ///Resolves a resource for an element in the tree and applies the resource to the property provided by the specified
    ///property index.
    ///Params:
    ///    resourceContext = The context of the resource.
    ///    resourceName = The name of the resource.
    ///    resourceType = The type of the resource.
    ///    propertyIndex = The index of the property to apply the resource to.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ResolveResource(ulong resourceContext, const(PWSTR) resourceName, ResourceType resourceType, 
                            uint propertyIndex);
    ///Gets an item from a ResourceDictionary.
    ///Params:
    ///    dictionaryHandle = The dictionary to get the resource from.
    ///    resourceName = The name of the resource to get.
    ///    resourceIsImplicitStyle = <b>true</b> if the resource is an implicit style; otherwise, <b>false</b>.
    ///    resourceHandle = The resource that was retrieved.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetDictionaryItem(ulong dictionaryHandle, const(PWSTR) resourceName, BOOL resourceIsImplicitStyle, 
                              ulong* resourceHandle);
    ///Adds an item to a ResourceDictionary, and re-resolves all elements in the tree that reference a resource with the
    ///specified key.
    ///Params:
    ///    dictionaryHandle = The dictionary to add the resource to.
    ///    resourceKey = The key of the resource to add.
    ///    resourceHandle = The resource to add.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddDictionaryItem(ulong dictionaryHandle, ulong resourceKey, ulong resourceHandle);
    ///Removes an item from a ResourceDictionary, and re-resolves all elements in the tree that reference a resource
    ///with the specified key.
    ///Params:
    ///    dictionaryHandle = The dictionary to remove the resource from.
    ///    resourceKey = The key of the resource to remove.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RemoveDictionaryItem(ulong dictionaryHandle, ulong resourceKey);
}


// GUIDs


const GUID IID_IBitmapData                 = GUIDOF!IBitmapData;
const GUID IID_IVisualTreeService          = GUIDOF!IVisualTreeService;
const GUID IID_IVisualTreeService2         = GUIDOF!IVisualTreeService2;
const GUID IID_IVisualTreeService3         = GUIDOF!IVisualTreeService3;
const GUID IID_IVisualTreeServiceCallback  = GUIDOF!IVisualTreeServiceCallback;
const GUID IID_IVisualTreeServiceCallback2 = GUIDOF!IVisualTreeServiceCallback2;
const GUID IID_IXamlDiagnostics            = GUIDOF!IXamlDiagnostics;
