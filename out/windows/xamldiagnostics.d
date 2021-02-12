module windows.xamldiagnostics;

public import windows.automation;
public import windows.com;
public import windows.displaydevices;
public import windows.dxgi;
public import windows.systemservices;
public import windows.winrt;

extern(Windows):

enum VisualMutationType
{
    Add = 0,
    Remove = 1,
}

enum BaseValueSource
{
    BaseValueSourceUnknown = 0,
    BaseValueSourceDefault = 1,
    BaseValueSourceBuiltInStyle = 2,
    BaseValueSourceStyle = 3,
    BaseValueSourceLocal = 4,
    Inherited = 5,
    DefaultStyleTrigger = 6,
    TemplateTrigger = 7,
    StyleTrigger = 8,
    ImplicitStyleReference = 9,
    ParentTemplate = 10,
    ParentTemplateTrigger = 11,
    Animation = 12,
    Coercion = 13,
    BaseValueSourceVisualState = 14,
}

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
    uint ChildIndex;
}

struct VisualElement
{
    ulong Handle;
    SourceInfo SrcInfo;
    BSTR Type;
    BSTR Name;
    uint NumChildren;
}

struct PropertyChainSource
{
    ulong Handle;
    BSTR TargetType;
    BSTR Name;
    BaseValueSource Source;
    SourceInfo SrcInfo;
}

enum MetadataBit
{
    None = 0,
    IsValueHandle = 1,
    IsPropertyReadOnly = 2,
    IsValueCollection = 4,
    IsValueCollectionReadOnly = 8,
    IsValueBindingExpression = 16,
    IsValueNull = 32,
    IsValueHandleAndEvaluatedValue = 64,
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
    BSTR Name;
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

enum RenderTargetBitmapOptions
{
    RenderTarget = 0,
    RenderTargetAndChildren = 1,
}

struct BitmapDescription
{
    uint Width;
    uint Height;
    DXGI_FORMAT Format;
    DXGI_ALPHA_MODE AlphaMode;
}

enum ResourceType
{
    ResourceTypeStatic = 0,
    ResourceTypeTheme = 1,
}

enum VisualElementState
{
    ErrorResolved = 0,
    ErrorResourceNotFound = 1,
    ErrorInvalidResource = 2,
}

const GUID IID_IVisualTreeServiceCallback = {0xAA7A8931, 0x80E4, 0x4FEC, [0x8F, 0x3B, 0x55, 0x3F, 0x87, 0xB4, 0x96, 0x6E]};
@GUID(0xAA7A8931, 0x80E4, 0x4FEC, [0x8F, 0x3B, 0x55, 0x3F, 0x87, 0xB4, 0x96, 0x6E]);
interface IVisualTreeServiceCallback : IUnknown
{
    HRESULT OnVisualTreeChange(ParentChildRelation relation, VisualElement element, VisualMutationType mutationType);
}

const GUID IID_IVisualTreeServiceCallback2 = {0xBAD9EB88, 0xAE77, 0x4397, [0xB9, 0x48, 0x5F, 0xA2, 0xDB, 0x0A, 0x19, 0xEA]};
@GUID(0xBAD9EB88, 0xAE77, 0x4397, [0xB9, 0x48, 0x5F, 0xA2, 0xDB, 0x0A, 0x19, 0xEA]);
interface IVisualTreeServiceCallback2 : IVisualTreeServiceCallback
{
    HRESULT OnElementStateChanged(ulong element, VisualElementState elementState, const(wchar)* context);
}

const GUID IID_IVisualTreeService = {0xA593B11A, 0xD17F, 0x48BB, [0x8F, 0x66, 0x83, 0x91, 0x07, 0x31, 0xC8, 0xA5]};
@GUID(0xA593B11A, 0xD17F, 0x48BB, [0x8F, 0x66, 0x83, 0x91, 0x07, 0x31, 0xC8, 0xA5]);
interface IVisualTreeService : IUnknown
{
    HRESULT AdviseVisualTreeChange(IVisualTreeServiceCallback pCallback);
    HRESULT UnadviseVisualTreeChange(IVisualTreeServiceCallback pCallback);
    HRESULT GetEnums(uint* pCount, char* ppEnums);
    HRESULT CreateInstance(BSTR typeName, BSTR value, ulong* pInstanceHandle);
    HRESULT GetPropertyValuesChain(ulong instanceHandle, uint* pSourceCount, char* ppPropertySources, uint* pPropertyCount, char* ppPropertyValues);
    HRESULT SetProperty(ulong instanceHandle, ulong value, uint propertyIndex);
    HRESULT ClearProperty(ulong instanceHandle, uint propertyIndex);
    HRESULT GetCollectionCount(ulong instanceHandle, uint* pCollectionSize);
    HRESULT GetCollectionElements(ulong instanceHandle, uint startIndex, uint* pElementCount, char* ppElementValues);
    HRESULT AddChild(ulong parent, ulong child, uint index);
    HRESULT RemoveChild(ulong parent, uint index);
    HRESULT ClearChildren(ulong parent);
}

const GUID IID_IXamlDiagnostics = {0x18C9E2B6, 0x3F43, 0x4116, [0x9F, 0x2B, 0xFF, 0x93, 0x5D, 0x77, 0x70, 0xD2]};
@GUID(0x18C9E2B6, 0x3F43, 0x4116, [0x9F, 0x2B, 0xFF, 0x93, 0x5D, 0x77, 0x70, 0xD2]);
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

const GUID IID_IBitmapData = {0xD1A34EF2, 0xCAD8, 0x4635, [0xA3, 0xD2, 0xFC, 0xDA, 0x8D, 0x3F, 0x3C, 0xAF]};
@GUID(0xD1A34EF2, 0xCAD8, 0x4635, [0xA3, 0xD2, 0xFC, 0xDA, 0x8D, 0x3F, 0x3C, 0xAF]);
interface IBitmapData : IUnknown
{
    HRESULT CopyBytesTo(uint sourceOffsetInBytes, uint maxBytesToCopy, char* pvBytes, uint* numberOfBytesCopied);
    HRESULT GetStride(uint* pStride);
    HRESULT GetBitmapDescription(BitmapDescription* pBitmapDescription);
    HRESULT GetSourceBitmapDescription(BitmapDescription* pBitmapDescription);
}

const GUID IID_IVisualTreeService2 = {0x130F5136, 0xEC43, 0x4F61, [0x89, 0xC7, 0x98, 0x01, 0xA3, 0x6D, 0x2E, 0x95]};
@GUID(0x130F5136, 0xEC43, 0x4F61, [0x89, 0xC7, 0x98, 0x01, 0xA3, 0x6D, 0x2E, 0x95]);
interface IVisualTreeService2 : IVisualTreeService
{
    HRESULT GetPropertyIndex(ulong object, const(wchar)* propertyName, uint* pPropertyIndex);
    HRESULT GetProperty(ulong object, uint propertyIndex, ulong* pValue);
    HRESULT ReplaceResource(ulong resourceDictionary, ulong key, ulong newValue);
    HRESULT RenderTargetBitmap(ulong handle, RenderTargetBitmapOptions options, uint maxPixelWidth, uint maxPixelHeight, IBitmapData* ppBitmapData);
}

const GUID IID_IVisualTreeService3 = {0x0E79C6E0, 0x85A0, 0x4BE8, [0xB4, 0x1A, 0x65, 0x5C, 0xF1, 0xFD, 0x19, 0xBD]};
@GUID(0x0E79C6E0, 0x85A0, 0x4BE8, [0xB4, 0x1A, 0x65, 0x5C, 0xF1, 0xFD, 0x19, 0xBD]);
interface IVisualTreeService3 : IVisualTreeService2
{
    HRESULT ResolveResource(ulong resourceContext, const(wchar)* resourceName, ResourceType resourceType, uint propertyIndex);
    HRESULT GetDictionaryItem(ulong dictionaryHandle, const(wchar)* resourceName, BOOL resourceIsImplicitStyle, ulong* resourceHandle);
    HRESULT AddDictionaryItem(ulong dictionaryHandle, ulong resourceKey, ulong resourceHandle);
    HRESULT RemoveDictionaryItem(ulong dictionaryHandle, ulong resourceKey);
}

