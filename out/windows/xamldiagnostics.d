module windows.xamldiagnostics;

public import windows.core;
public import windows.automation : BSTR, SAFEARRAY;
public import windows.com : HRESULT, IUnknown;
public import windows.displaydevices : RECT;
public import windows.dxgi : DXGI_ALPHA_MODE, DXGI_FORMAT;
public import windows.systemservices : BOOL;
public import windows.winrt : IInspectable;

extern(Windows):


// Enums


enum VisualMutationType : int
{
    Add     = 0x00000000,
    Remove  = 0x00000001,
}

enum BaseValueSource : int
{
    BaseValueSourceUnknown      = 0x00000000,
    BaseValueSourceDefault      = 0x00000001,
    BaseValueSourceBuiltInStyle = 0x00000002,
    BaseValueSourceStyle        = 0x00000003,
    BaseValueSourceLocal        = 0x00000004,
    Inherited                   = 0x00000005,
    DefaultStyleTrigger         = 0x00000006,
    TemplateTrigger             = 0x00000007,
    StyleTrigger                = 0x00000008,
    ImplicitStyleReference      = 0x00000009,
    ParentTemplate              = 0x0000000a,
    ParentTemplateTrigger       = 0x0000000b,
    Animation                   = 0x0000000c,
    Coercion                    = 0x0000000d,
    BaseValueSourceVisualState  = 0x0000000e,
}

enum MetadataBit : int
{
    None                           = 0x00000000,
    IsValueHandle                  = 0x00000001,
    IsPropertyReadOnly             = 0x00000002,
    IsValueCollection              = 0x00000004,
    IsValueCollectionReadOnly      = 0x00000008,
    IsValueBindingExpression       = 0x00000010,
    IsValueNull                    = 0x00000020,
    IsValueHandleAndEvaluatedValue = 0x00000040,
}

enum RenderTargetBitmapOptions : int
{
    RenderTarget            = 0x00000000,
    RenderTargetAndChildren = 0x00000001,
}

enum ResourceType : int
{
    ResourceTypeStatic = 0x00000000,
    ResourceTypeTheme  = 0x00000001,
}

enum VisualElementState : int
{
    ErrorResolved         = 0x00000000,
    ErrorResourceNotFound = 0x00000001,
    ErrorInvalidResource  = 0x00000002,
}

// Structs


struct SourceInfo
{
    BSTR FileName;
    uint LineNumber;
    uint ColumnNumber;
    uint CharPosition;
    BSTR Hash;
}

struct ParentChildRelation
{
    ulong Parent;
    ulong Child;
    uint  ChildIndex;
}

struct VisualElement
{
    ulong      Handle;
    SourceInfo SrcInfo;
    BSTR       Type;
    BSTR       Name;
    uint       NumChildren;
}

struct PropertyChainSource
{
    ulong           Handle;
    BSTR            TargetType;
    BSTR            Name;
    BaseValueSource Source;
    SourceInfo      SrcInfo;
}

struct PropertyChainValue
{
    uint Index;
    BSTR Type;
    BSTR DeclaringType;
    BSTR ValueType;
    BSTR ItemType;
    BSTR Value;
    BOOL Overridden;
    long MetadataBits;
    BSTR PropertyName;
    uint PropertyChainIndex;
}

struct EnumType
{
    BSTR       Name;
    SAFEARRAY* ValueInts;
    SAFEARRAY* ValueStrings;
}

struct CollectionElementValue
{
    uint Index;
    BSTR ValueType;
    BSTR Value;
    long MetadataBits;
}

struct BitmapDescription
{
    uint            Width;
    uint            Height;
    DXGI_FORMAT     Format;
    DXGI_ALPHA_MODE AlphaMode;
}

// Interfaces

@GUID("AA7A8931-80E4-4FEC-8F3B-553F87B4966E")
interface IVisualTreeServiceCallback : IUnknown
{
    HRESULT OnVisualTreeChange(ParentChildRelation relation, VisualElement element, 
                               VisualMutationType mutationType);
}

@GUID("BAD9EB88-AE77-4397-B948-5FA2DB0A19EA")
interface IVisualTreeServiceCallback2 : IVisualTreeServiceCallback
{
    HRESULT OnElementStateChanged(ulong element, VisualElementState elementState, const(wchar)* context);
}

@GUID("A593B11A-D17F-48BB-8F66-83910731C8A5")
interface IVisualTreeService : IUnknown
{
    HRESULT AdviseVisualTreeChange(IVisualTreeServiceCallback pCallback);
    HRESULT UnadviseVisualTreeChange(IVisualTreeServiceCallback pCallback);
    HRESULT GetEnums(uint* pCount, char* ppEnums);
    HRESULT CreateInstance(BSTR typeName, BSTR value, ulong* pInstanceHandle);
    HRESULT GetPropertyValuesChain(ulong instanceHandle, uint* pSourceCount, char* ppPropertySources, 
                                   uint* pPropertyCount, char* ppPropertyValues);
    HRESULT SetProperty(ulong instanceHandle, ulong value, uint propertyIndex);
    HRESULT ClearProperty(ulong instanceHandle, uint propertyIndex);
    HRESULT GetCollectionCount(ulong instanceHandle, uint* pCollectionSize);
    HRESULT GetCollectionElements(ulong instanceHandle, uint startIndex, uint* pElementCount, 
                                  char* ppElementValues);
    HRESULT AddChild(ulong parent, ulong child, uint index);
    HRESULT RemoveChild(ulong parent, uint index);
    HRESULT ClearChildren(ulong parent);
}

@GUID("18C9E2B6-3F43-4116-9F2B-FF935D7770D2")
interface IXamlDiagnostics : IUnknown
{
    HRESULT GetDispatcher(IInspectable* ppDispatcher);
    HRESULT GetUiLayer(IInspectable* ppLayer);
    HRESULT GetApplication(IInspectable* ppApplication);
    HRESULT GetIInspectableFromHandle(ulong instanceHandle, IInspectable* ppInstance);
    HRESULT GetHandleFromIInspectable(IInspectable pInstance, ulong* pHandle);
    HRESULT HitTest(RECT rect, uint* pCount, char* ppInstanceHandles);
    HRESULT RegisterInstance(IInspectable pInstance, ulong* pInstanceHandle);
    HRESULT GetInitializationData(BSTR* pInitializationData);
}

@GUID("D1A34EF2-CAD8-4635-A3D2-FCDA8D3F3CAF")
interface IBitmapData : IUnknown
{
    HRESULT CopyBytesTo(uint sourceOffsetInBytes, uint maxBytesToCopy, char* pvBytes, uint* numberOfBytesCopied);
    HRESULT GetStride(uint* pStride);
    HRESULT GetBitmapDescription(BitmapDescription* pBitmapDescription);
    HRESULT GetSourceBitmapDescription(BitmapDescription* pBitmapDescription);
}

@GUID("130F5136-EC43-4F61-89C7-9801A36D2E95")
interface IVisualTreeService2 : IVisualTreeService
{
    HRESULT GetPropertyIndex(ulong object, const(wchar)* propertyName, uint* pPropertyIndex);
    HRESULT GetProperty(ulong object, uint propertyIndex, ulong* pValue);
    HRESULT ReplaceResource(ulong resourceDictionary, ulong key, ulong newValue);
    HRESULT RenderTargetBitmap(ulong handle, RenderTargetBitmapOptions options, uint maxPixelWidth, 
                               uint maxPixelHeight, IBitmapData* ppBitmapData);
}

@GUID("0E79C6E0-85A0-4BE8-B41A-655CF1FD19BD")
interface IVisualTreeService3 : IVisualTreeService2
{
    HRESULT ResolveResource(ulong resourceContext, const(wchar)* resourceName, ResourceType resourceType, 
                            uint propertyIndex);
    HRESULT GetDictionaryItem(ulong dictionaryHandle, const(wchar)* resourceName, BOOL resourceIsImplicitStyle, 
                              ulong* resourceHandle);
    HRESULT AddDictionaryItem(ulong dictionaryHandle, ulong resourceKey, ulong resourceHandle);
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
