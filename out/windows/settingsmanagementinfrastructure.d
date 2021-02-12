module windows.settingsmanagementinfrastructure;

public import system;
public import windows.automation;
public import windows.com;
public import windows.structuredstorage;
public import windows.systemservices;

extern(Windows):

const GUID CLSID_SettingsEngine = {0x9F7D7BB5, 0x20B3, 0x11DA, [0x81, 0xA5, 0x00, 0x30, 0xF1, 0x64, 0x2E, 0x3C]};
@GUID(0x9F7D7BB5, 0x20B3, 0x11DA, [0x81, 0xA5, 0x00, 0x30, 0xF1, 0x64, 0x2E, 0x3C]);
struct SettingsEngine;

enum WcmTargetMode
{
    OfflineMode = 1,
    OnlineMode = 2,
}

enum WcmNamespaceEnumerationFlags
{
    SharedEnumeration = 1,
    UserEnumeration = 2,
    AllEnumeration = 3,
}

enum WcmDataType
{
    dataTypeByte = 1,
    dataTypeSByte = 2,
    dataTypeUInt16 = 3,
    dataTypeInt16 = 4,
    dataTypeUInt32 = 5,
    dataTypeInt32 = 6,
    dataTypeUInt64 = 7,
    dataTypeInt64 = 8,
    dataTypeBoolean = 11,
    dataTypeString = 12,
    dataTypeFlagArray = 32768,
}

enum WcmSettingType
{
    settingTypeScalar = 1,
    settingTypeComplex = 2,
    settingTypeList = 3,
}

enum WcmRestrictionFacets
{
    restrictionFacetMaxLength = 1,
    restrictionFacetEnumeration = 2,
    restrictionFacetMaxInclusive = 4,
    restrictionFacetMinInclusive = 8,
}

enum WcmUserStatus
{
    UnknownStatus = 0,
    UserRegistered = 1,
    UserUnregistered = 2,
    UserLoaded = 3,
    UserUnloaded = 4,
}

enum WcmNamespaceAccess
{
    ReadOnlyAccess = 1,
    ReadWriteAccess = 2,
}

const GUID IID_IItemEnumerator = {0x9F7D7BB7, 0x20B3, 0x11DA, [0x81, 0xA5, 0x00, 0x30, 0xF1, 0x64, 0x2E, 0x3C]};
@GUID(0x9F7D7BB7, 0x20B3, 0x11DA, [0x81, 0xA5, 0x00, 0x30, 0xF1, 0x64, 0x2E, 0x3C]);
interface IItemEnumerator : IUnknown
{
    HRESULT Current(VARIANT* Item);
    HRESULT MoveNext(int* ItemValid);
    HRESULT Reset();
}

const GUID IID_ISettingsIdentity = {0x9F7D7BB6, 0x20B3, 0x11DA, [0x81, 0xA5, 0x00, 0x30, 0xF1, 0x64, 0x2E, 0x3C]};
@GUID(0x9F7D7BB6, 0x20B3, 0x11DA, [0x81, 0xA5, 0x00, 0x30, 0xF1, 0x64, 0x2E, 0x3C]);
interface ISettingsIdentity : IUnknown
{
    HRESULT GetAttribute(void* Reserved, const(wchar)* Name, BSTR* Value);
    HRESULT SetAttribute(void* Reserved, const(wchar)* Name, const(wchar)* Value);
    HRESULT GetFlags(uint* Flags);
    HRESULT SetFlags(uint Flags);
}

const GUID IID_ITargetInfo = {0x9F7D7BB8, 0x20B3, 0x11DA, [0x81, 0xA5, 0x00, 0x30, 0xF1, 0x64, 0x2E, 0x3C]};
@GUID(0x9F7D7BB8, 0x20B3, 0x11DA, [0x81, 0xA5, 0x00, 0x30, 0xF1, 0x64, 0x2E, 0x3C]);
interface ITargetInfo : IUnknown
{
    HRESULT GetTargetMode(WcmTargetMode* TargetMode);
    HRESULT SetTargetMode(WcmTargetMode TargetMode);
    HRESULT GetTemporaryStoreLocation(BSTR* TemporaryStoreLocation);
    HRESULT SetTemporaryStoreLocation(const(wchar)* TemporaryStoreLocation);
    HRESULT GetTargetID(BSTR* TargetID);
    HRESULT SetTargetID(Guid TargetID);
    HRESULT GetTargetProcessorArchitecture(BSTR* ProcessorArchitecture);
    HRESULT SetTargetProcessorArchitecture(const(wchar)* ProcessorArchitecture);
    HRESULT GetProperty(BOOL Offline, const(wchar)* Property, BSTR* Value);
    HRESULT SetProperty(BOOL Offline, const(wchar)* Property, const(wchar)* Value);
    HRESULT GetEnumerator(IItemEnumerator* Enumerator);
    HRESULT ExpandTarget(BOOL Offline, const(wchar)* Location, BSTR* ExpandedLocation);
    HRESULT ExpandTargetPath(BOOL Offline, const(wchar)* Location, BSTR* ExpandedLocation);
    HRESULT SetModulePath(const(wchar)* Module, const(wchar)* Path);
    HRESULT LoadModule(const(wchar)* Module, int* ModuleHandle);
    HRESULT SetWow64Context(const(wchar)* InstallerModule, ubyte* Wow64Context);
    HRESULT TranslateWow64(const(wchar)* ClientArchitecture, const(wchar)* Value, BSTR* TranslatedValue);
    HRESULT SetSchemaHiveLocation(const(wchar)* pwzHiveDir);
    HRESULT GetSchemaHiveLocation(BSTR* pHiveLocation);
    HRESULT SetSchemaHiveMountName(const(wchar)* pwzMountName);
    HRESULT GetSchemaHiveMountName(BSTR* pMountName);
}

const GUID IID_ISettingsEngine = {0x9F7D7BB9, 0x20B3, 0x11DA, [0x81, 0xA5, 0x00, 0x30, 0xF1, 0x64, 0x2E, 0x3C]};
@GUID(0x9F7D7BB9, 0x20B3, 0x11DA, [0x81, 0xA5, 0x00, 0x30, 0xF1, 0x64, 0x2E, 0x3C]);
interface ISettingsEngine : IUnknown
{
    HRESULT GetNamespaces(WcmNamespaceEnumerationFlags Flags, void* Reserved, IItemEnumerator* Namespaces);
    HRESULT GetNamespace(ISettingsIdentity SettingsID, WcmNamespaceAccess Access, void* Reserved, ISettingsNamespace* NamespaceItem);
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
    HRESULT ApplySettingsContext(ISettingsContext SettingsContext, ushort*** pppwzIdentities, uint* pcIdentities);
    HRESULT GetSettingsContext(ISettingsContext* SettingsContext);
}

const GUID IID_ISettingsItem = {0x9F7D7BBB, 0x20B3, 0x11DA, [0x81, 0xA5, 0x00, 0x30, 0xF1, 0x64, 0x2E, 0x3C]};
@GUID(0x9F7D7BBB, 0x20B3, 0x11DA, [0x81, 0xA5, 0x00, 0x30, 0xF1, 0x64, 0x2E, 0x3C]);
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

const GUID IID_ISettingsNamespace = {0x9F7D7BBA, 0x20B3, 0x11DA, [0x81, 0xA5, 0x00, 0x30, 0xF1, 0x64, 0x2E, 0x3C]};
@GUID(0x9F7D7BBA, 0x20B3, 0x11DA, [0x81, 0xA5, 0x00, 0x30, 0xF1, 0x64, 0x2E, 0x3C]);
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

const GUID IID_ISettingsResult = {0x9F7D7BBC, 0x20B3, 0x11DA, [0x81, 0xA5, 0x00, 0x30, 0xF1, 0x64, 0x2E, 0x3C]};
@GUID(0x9F7D7BBC, 0x20B3, 0x11DA, [0x81, 0xA5, 0x00, 0x30, 0xF1, 0x64, 0x2E, 0x3C]);
interface ISettingsResult : IUnknown
{
    HRESULT GetDescription(BSTR* description);
    HRESULT GetErrorCode(int* hrOut);
    HRESULT GetContextDescription(BSTR* description);
    HRESULT GetLine(uint* dwLine);
    HRESULT GetColumn(uint* dwColumn);
    HRESULT GetSource(BSTR* file);
}

const GUID IID_ISettingsContext = {0x9F7D7BBD, 0x20B3, 0x11DA, [0x81, 0xA5, 0x00, 0x30, 0xF1, 0x64, 0x2E, 0x3C]};
@GUID(0x9F7D7BBD, 0x20B3, 0x11DA, [0x81, 0xA5, 0x00, 0x30, 0xF1, 0x64, 0x2E, 0x3C]);
interface ISettingsContext : IUnknown
{
    HRESULT Serialize(IStream pStream, ITargetInfo pTarget);
    HRESULT Deserialize(IStream pStream, ITargetInfo pTarget, ISettingsResult** pppResults, uint* pcResultCount);
    HRESULT SetUserData(void* pUserData);
    HRESULT GetUserData(void** pUserData);
    HRESULT GetNamespaces(IItemEnumerator* ppNamespaceIds);
    HRESULT GetStoredSettings(ISettingsIdentity pIdentity, IItemEnumerator* ppAddedSettings, IItemEnumerator* ppModifiedSettings, IItemEnumerator* ppDeletedSettings);
    HRESULT RevertSetting(ISettingsIdentity pIdentity, const(wchar)* pwzSetting);
}

