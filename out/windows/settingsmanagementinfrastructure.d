module windows.settingsmanagementinfrastructure;

public import windows.core;
public import windows.automation : BSTR, VARIANT;
public import windows.com : HRESULT, IUnknown;
public import windows.structuredstorage : IStream;
public import windows.systemservices : BOOL;

extern(Windows):


// Enums


enum WcmTargetMode : int
{
    OfflineMode = 0x00000001,
    OnlineMode  = 0x00000002,
}

enum WcmNamespaceEnumerationFlags : int
{
    SharedEnumeration = 0x00000001,
    UserEnumeration   = 0x00000002,
    AllEnumeration    = 0x00000003,
}

enum WcmDataType : int
{
    dataTypeByte      = 0x00000001,
    dataTypeSByte     = 0x00000002,
    dataTypeUInt16    = 0x00000003,
    dataTypeInt16     = 0x00000004,
    dataTypeUInt32    = 0x00000005,
    dataTypeInt32     = 0x00000006,
    dataTypeUInt64    = 0x00000007,
    dataTypeInt64     = 0x00000008,
    dataTypeBoolean   = 0x0000000b,
    dataTypeString    = 0x0000000c,
    dataTypeFlagArray = 0x00008000,
}

enum WcmSettingType : int
{
    settingTypeScalar  = 0x00000001,
    settingTypeComplex = 0x00000002,
    settingTypeList    = 0x00000003,
}

enum WcmRestrictionFacets : int
{
    restrictionFacetMaxLength    = 0x00000001,
    restrictionFacetEnumeration  = 0x00000002,
    restrictionFacetMaxInclusive = 0x00000004,
    restrictionFacetMinInclusive = 0x00000008,
}

enum WcmUserStatus : int
{
    UnknownStatus    = 0x00000000,
    UserRegistered   = 0x00000001,
    UserUnregistered = 0x00000002,
    UserLoaded       = 0x00000003,
    UserUnloaded     = 0x00000004,
}

enum WcmNamespaceAccess : int
{
    ReadOnlyAccess  = 0x00000001,
    ReadWriteAccess = 0x00000002,
}

// Interfaces

@GUID("9F7D7BB5-20B3-11DA-81A5-0030F1642E3C")
struct SettingsEngine;

@GUID("9F7D7BB7-20B3-11DA-81A5-0030F1642E3C")
interface IItemEnumerator : IUnknown
{
    HRESULT Current(VARIANT* Item);
    HRESULT MoveNext(int* ItemValid);
    HRESULT Reset();
}

@GUID("9F7D7BB6-20B3-11DA-81A5-0030F1642E3C")
interface ISettingsIdentity : IUnknown
{
    HRESULT GetAttribute(void* Reserved, const(wchar)* Name, BSTR* Value);
    HRESULT SetAttribute(void* Reserved, const(wchar)* Name, const(wchar)* Value);
    HRESULT GetFlags(uint* Flags);
    HRESULT SetFlags(uint Flags);
}

@GUID("9F7D7BB8-20B3-11DA-81A5-0030F1642E3C")
interface ITargetInfo : IUnknown
{
    HRESULT GetTargetMode(WcmTargetMode* TargetMode);
    HRESULT SetTargetMode(WcmTargetMode TargetMode);
    HRESULT GetTemporaryStoreLocation(BSTR* TemporaryStoreLocation);
    HRESULT SetTemporaryStoreLocation(const(wchar)* TemporaryStoreLocation);
    HRESULT GetTargetID(BSTR* TargetID);
    HRESULT SetTargetID(GUID TargetID);
    HRESULT GetTargetProcessorArchitecture(BSTR* ProcessorArchitecture);
    HRESULT SetTargetProcessorArchitecture(const(wchar)* ProcessorArchitecture);
    HRESULT GetProperty(BOOL Offline, const(wchar)* Property, BSTR* Value);
    HRESULT SetProperty(BOOL Offline, const(wchar)* Property, const(wchar)* Value);
    HRESULT GetEnumerator(IItemEnumerator* Enumerator);
    HRESULT ExpandTarget(BOOL Offline, const(wchar)* Location, BSTR* ExpandedLocation);
    HRESULT ExpandTargetPath(BOOL Offline, const(wchar)* Location, BSTR* ExpandedLocation);
    HRESULT SetModulePath(const(wchar)* Module, const(wchar)* Path);
    HRESULT LoadModule(const(wchar)* Module, ptrdiff_t* ModuleHandle);
    HRESULT SetWow64Context(const(wchar)* InstallerModule, ubyte* Wow64Context);
    HRESULT TranslateWow64(const(wchar)* ClientArchitecture, const(wchar)* Value, BSTR* TranslatedValue);
    HRESULT SetSchemaHiveLocation(const(wchar)* pwzHiveDir);
    HRESULT GetSchemaHiveLocation(BSTR* pHiveLocation);
    HRESULT SetSchemaHiveMountName(const(wchar)* pwzMountName);
    HRESULT GetSchemaHiveMountName(BSTR* pMountName);
}

@GUID("9F7D7BB9-20B3-11DA-81A5-0030F1642E3C")
interface ISettingsEngine : IUnknown
{
    HRESULT GetNamespaces(WcmNamespaceEnumerationFlags Flags, void* Reserved, IItemEnumerator* Namespaces);
    HRESULT GetNamespace(ISettingsIdentity SettingsID, WcmNamespaceAccess Access, void* Reserved, 
                         ISettingsNamespace* NamespaceItem);
    HRESULT GetErrorDescription(int HResult, BSTR* Message);
    HRESULT CreateSettingsIdentity(ISettingsIdentity* SettingsID);
    HRESULT GetStoreStatus(void* Reserved, WcmUserStatus* Status);
    HRESULT LoadStore(uint Flags);
    HRESULT UnloadStore(void* Reserved);
    HRESULT RegisterNamespace(ISettingsIdentity SettingsID, IStream Stream, BOOL PushSettings, VARIANT* Results);
    HRESULT UnregisterNamespace(ISettingsIdentity SettingsID, BOOL RemoveSettings);
    HRESULT CreateTargetInfo(ITargetInfo* Target);
    HRESULT GetTargetInfo(ITargetInfo* Target);
    HRESULT SetTargetInfo(ITargetInfo Target);
    HRESULT CreateSettingsContext(uint Flags, void* Reserved, ISettingsContext* SettingsContext);
    HRESULT SetSettingsContext(ISettingsContext SettingsContext);
    HRESULT ApplySettingsContext(ISettingsContext SettingsContext, ushort*** pppwzIdentities, size_t* pcIdentities);
    HRESULT GetSettingsContext(ISettingsContext* SettingsContext);
}

@GUID("9F7D7BBB-20B3-11DA-81A5-0030F1642E3C")
interface ISettingsItem : IUnknown
{
    HRESULT GetName(BSTR* Name);
    HRESULT GetValue(VARIANT* Value);
    HRESULT SetValue(const(VARIANT)* Value);
    HRESULT GetSettingType(WcmSettingType* Type);
    HRESULT GetDataType(WcmDataType* Type);
    HRESULT GetValueRaw(ubyte** Data, uint* DataSize);
    HRESULT SetValueRaw(int DataType, const(ubyte)* Data, uint DataSize);
    HRESULT HasChild(int* ItemHasChild);
    HRESULT Children(IItemEnumerator* Children);
    HRESULT GetChild(const(wchar)* Name, ISettingsItem* Child);
    HRESULT GetSettingByPath(const(wchar)* Path, ISettingsItem* Setting);
    HRESULT CreateSettingByPath(const(wchar)* Path, ISettingsItem* Setting);
    HRESULT RemoveSettingByPath(const(wchar)* Path);
    HRESULT GetListKeyInformation(BSTR* KeyName, WcmDataType* DataType);
    HRESULT CreateListElement(const(VARIANT)* KeyData, ISettingsItem* Child);
    HRESULT RemoveListElement(const(wchar)* ElementName);
    HRESULT Attributes(IItemEnumerator* Attributes);
    HRESULT GetAttribute(const(wchar)* Name, VARIANT* Value);
    HRESULT GetPath(BSTR* Path);
    HRESULT GetRestrictionFacets(WcmRestrictionFacets* RestrictionFacets);
    HRESULT GetRestriction(WcmRestrictionFacets RestrictionFacet, VARIANT* FacetData);
    HRESULT GetKeyValue(VARIANT* Value);
}

@GUID("9F7D7BBA-20B3-11DA-81A5-0030F1642E3C")
interface ISettingsNamespace : IUnknown
{
    HRESULT GetIdentity(ISettingsIdentity* SettingsID);
    HRESULT Settings(IItemEnumerator* Settings);
    HRESULT Save(BOOL PushSettings, ISettingsResult* Result);
    HRESULT GetSettingByPath(const(wchar)* Path, ISettingsItem* Setting);
    HRESULT CreateSettingByPath(const(wchar)* Path, ISettingsItem* Setting);
    HRESULT RemoveSettingByPath(const(wchar)* Path);
    HRESULT GetAttribute(const(wchar)* Name, VARIANT* Value);
}

@GUID("9F7D7BBC-20B3-11DA-81A5-0030F1642E3C")
interface ISettingsResult : IUnknown
{
    HRESULT GetDescription(BSTR* description);
    HRESULT GetErrorCode(int* hrOut);
    HRESULT GetContextDescription(BSTR* description);
    HRESULT GetLine(uint* dwLine);
    HRESULT GetColumn(uint* dwColumn);
    HRESULT GetSource(BSTR* file);
}

@GUID("9F7D7BBD-20B3-11DA-81A5-0030F1642E3C")
interface ISettingsContext : IUnknown
{
    HRESULT Serialize(IStream pStream, ITargetInfo pTarget);
    HRESULT Deserialize(IStream pStream, ITargetInfo pTarget, ISettingsResult** pppResults, size_t* pcResultCount);
    HRESULT SetUserData(void* pUserData);
    HRESULT GetUserData(void** pUserData);
    HRESULT GetNamespaces(IItemEnumerator* ppNamespaceIds);
    HRESULT GetStoredSettings(ISettingsIdentity pIdentity, IItemEnumerator* ppAddedSettings, 
                              IItemEnumerator* ppModifiedSettings, IItemEnumerator* ppDeletedSettings);
    HRESULT RevertSetting(ISettingsIdentity pIdentity, const(wchar)* pwzSetting);
}


// GUIDs

const GUID CLSID_SettingsEngine = GUIDOF!SettingsEngine;

const GUID IID_IItemEnumerator    = GUIDOF!IItemEnumerator;
const GUID IID_ISettingsContext   = GUIDOF!ISettingsContext;
const GUID IID_ISettingsEngine    = GUIDOF!ISettingsEngine;
const GUID IID_ISettingsIdentity  = GUIDOF!ISettingsIdentity;
const GUID IID_ISettingsItem      = GUIDOF!ISettingsItem;
const GUID IID_ISettingsNamespace = GUIDOF!ISettingsNamespace;
const GUID IID_ISettingsResult    = GUIDOF!ISettingsResult;
const GUID IID_ITargetInfo        = GUIDOF!ITargetInfo;
