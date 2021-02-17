// Written in the D programming language.

module windows.settingsmanagementinfrastructure;

public import windows.core;
public import windows.automation : BSTR, VARIANT;
public import windows.com : HRESULT, IUnknown;
public import windows.structuredstorage : IStream;
public import windows.systemservices : BOOL;

extern(Windows):


// Enums


///Enumerates the various target modes. A target mode identifies how the redirections, from the target, are handled.
enum WcmTargetMode : int
{
    ///This value indicates that the only expansions that will be performed on environment variables are those defined
    ///in the target.
    OfflineMode = 0x00000001,
    OnlineMode  = 0x00000002,
}

///Describes the types of enumeration flags.
enum WcmNamespaceEnumerationFlags : int
{
    ///Describes a shared enumeration. It enumerates all namespaces that have been compiled for the machine space.
    SharedEnumeration = 0x00000001,
    ///Describes a user-specific enumeration. It enumerates the namespaces that have been compiled for a specific user.
    UserEnumeration   = 0x00000002,
    ///A logical "OR" of shared and user enumeration.
    AllEnumeration    = 0x00000003,
}

///Enumerates the data types returned from the ISettingsItem::GetDataType method. The values correspond appropriately to
///typical programming types. An exception is the flag value <b>dataTypeFlagArray</b>. This flag may appear combined
///with <b>dataTypeByte</b> or <b>dataTypeString</b> to indicate xsd:hexBinary or wcm:multiString settings
///(respectively). Each of the following constants correspond to a data type.
enum WcmDataType : int
{
    ///Corresponds to a byte.
    dataTypeByte      = 0x00000001,
    ///Corresponds to a signed byte.
    dataTypeSByte     = 0x00000002,
    ///Corresponds to an unsigned 16-bit integer.
    dataTypeUInt16    = 0x00000003,
    ///Corresponds to a 16-bit integer.
    dataTypeInt16     = 0x00000004,
    ///Corresponds to an unsigned 32-bit integer.
    dataTypeUInt32    = 0x00000005,
    ///Corresponds to a 32-bit integer.
    dataTypeInt32     = 0x00000006,
    ///Corresponds to an unsigned 64-bit integer.
    dataTypeUInt64    = 0x00000007,
    ///Corresponds to a 64-bit integer.
    dataTypeInt64     = 0x00000008,
    ///Corresponds to a Boolean.
    dataTypeBoolean   = 0x0000000b,
    ///Corresponds to a string.
    dataTypeString    = 0x0000000c,
    dataTypeFlagArray = 0x00008000,
}

///Describes setting types that are returned from the ISettingsItem::GetSettingType method and defines the object model
///type for the calling ISettingsItem interface.
enum WcmSettingType : int
{
    ///For items of this type, you can call the ISettingsItem::GetDataType, ISettingsItem::GetValue,
    ///ISettingsItem::GetValueRaw, ISettingsItem::GetRestriction, ISettingsItem::GetRestrictionFacets,
    ///ISettingsItem::SetValue, and ISettingsItem::SetValueRaw methods.
    settingTypeScalar  = 0x00000001,
    ///Items of this type may have children. You may call the ISettingsItem::Children, ISettingsItem::GetChild, or
    ///ISettingsItem::HasChild methods on this setting type.
    settingTypeComplex = 0x00000002,
    ///Items of this type may have children. You may call the ISettingsItem::Children, ISettingsItem::GetChild, or
    ///ISettingsItem::HasChild methods on this setting type. You can also call the ISettingsItem::CreateListElement and
    ///ISettingsItem::RemoveListElement methods on children of items of this type.
    settingTypeList    = 0x00000003,
}

///Enumerates the facet values that may be returned by the ISettingsItem::GetRestrictionFacets method. The facet values
///are combined by performing an <b>OR</b> operation to provide a full identification of the facets that are defined on
///the base type for a particular setting. This enumeration type is also used as an input to the
///ISettingsItem::GetRestriction method to specify a facet and retrieve the corresponding information for that facet.
///The facet values roughly conform to the restrictions defined in Data Type Facets. Simple data types (both built-in
///and derived) have facets. A facet is a single defining aspect that helps determine the set of values for a simple
///type. For example, <i>MaxLength</i>, <i>minInclusive</i>, and <i>maxInclusive</i> are common facets for the built-in
///data types. All of the facets for a simple type define the set of legal values for that simple type.
enum WcmRestrictionFacets : int
{
    ///Maximum number of units of length. Units of length depend on the data type. This value must be a
    ///nonNegativeInteger.
    restrictionFacetMaxLength    = 0x00000001,
    ///Specified set of values. This limits a data type to the specified values.
    restrictionFacetEnumeration  = 0x00000002,
    ///Maximum value. This value must be the same data type as the inherited data type.
    restrictionFacetMaxInclusive = 0x00000004,
    restrictionFacetMinInclusive = 0x00000008,
}

///Describes the status of the user.
enum WcmUserStatus : int
{
    ///Indicates a problem with the store.
    UnknownStatus    = 0x00000000,
    ///Indicates that the store is registered, but is not currently loaded for use.
    UserRegistered   = 0x00000001,
    ///Indicates that the store does not currently exist.
    UserUnregistered = 0x00000002,
    ///Indicates that the store is registered, loaded, and ready for use.
    UserLoaded       = 0x00000003,
    ///This has the same semantics as <b>UserRegistered</b>.
    UserUnloaded     = 0x00000004,
}

///Describes the options passed to the ISettingsEngine::GetNamespace method to choose how the namespace must be
///accessed. Read and write access must be used if the intent is to change settings and read-only access must be used if
///the intent is only to inspect the settings.
enum WcmNamespaceAccess : int
{
    ///Request read-only access.
    ReadOnlyAccess  = 0x00000001,
    ReadWriteAccess = 0x00000002,
}

// Interfaces

@GUID("9F7D7BB5-20B3-11DA-81A5-0030F1642E3C")
struct SettingsEngine;

///Enumerates the items of a collection of settings and attributes.
@GUID("9F7D7BB7-20B3-11DA-81A5-0030F1642E3C")
interface IItemEnumerator : IUnknown
{
    ///Retrieves an item from the current position of the enumerator.
    ///Params:
    ///    Item = A variant that contains the key value for the collection. For most collections, the key is the name of the
    ///           item.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT Current(VARIANT* Item);
    ///Moves the current position to the next item in the enumerator if available.
    ///Params:
    ///    ItemValid = Returns <b>True</b> if a valid item is found in the position after the move.
    ///Returns:
    ///    This method returns an HRESULT value. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Indicates success. </td> </tr> </table>
    ///    
    HRESULT MoveNext(int* ItemValid);
    ///Resets the state of the enumerator to its initialized state. You must immediately follow
    ///<b>IItemEnumerator::Reset</b> with a call to IItemEnumerator::MoveNext on the enumerator in order to set the
    ///current pointer at the first position in the enumeration.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT Reset();
}

///Identifies a namespace to open or use.
@GUID("9F7D7BB6-20B3-11DA-81A5-0030F1642E3C")
interface ISettingsIdentity : IUnknown
{
    ///Gets an identity attribute for a namespace identity.
    ///Params:
    ///    Reserved = Reserved. Must be <b>NULL</b>.
    ///    Name = The name of the attribute.
    ///    Value = The value of the attribute.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success. If the attribute specified by Name is
    ///    not recognized, this function returns <b>WCM_E_ATTRIBUTENOTFOUND</b>.
    ///    
    HRESULT GetAttribute(void* Reserved, const(wchar)* Name, BSTR* Value);
    ///Sets an identity attribute for a namespace identity.
    ///Params:
    ///    Reserved = Reserved. Must be <b>NULL</b>.
    ///    Name = The name of the attribute.
    ///    Value = The value of the attribute.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success. It returns
    ///    <b>WCM_E_ATTRIBUTENOTALLOWED</b> if the attribute specified by Name is not recognized.
    ///    
    HRESULT SetAttribute(void* Reserved, const(wchar)* Name, const(wchar)* Value);
    ///Returns the flags for a namespace identity.
    ///Params:
    ///    Flags = The identity flags for the namespace identity.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT GetFlags(uint* Flags);
    ///Sets the identity flags for a namespace identity.
    ///Params:
    ///    Flags = The identity flags.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT SetFlags(uint Flags);
}

///Defines the offline target information, specifically, file and registry locations as well as wow64 information.
@GUID("9F7D7BB8-20B3-11DA-81A5-0030F1642E3C")
interface ITargetInfo : IUnknown
{
    ///Gets the current target mode.
    ///Params:
    ///    TargetMode = The current target mode. The target mode identifies the way in which the redirections from the target are
    ///                 handled.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT GetTargetMode(WcmTargetMode* TargetMode);
    ///Sets the target mode.
    ///Params:
    ///    TargetMode = The target mode.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT SetTargetMode(WcmTargetMode TargetMode);
    ///Gets the current temporary store location.
    ///Params:
    ///    TemporaryStoreLocation = The current temporary store location.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT GetTemporaryStoreLocation(BSTR* TemporaryStoreLocation);
    ///Sets the current temporary store location.
    ///Params:
    ///    TemporaryStoreLocation = The current temporary store location.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Indicates success. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32 (ERROR_INVALID_OPERATION)</b></dt> </dl> </td> <td
    ///    width="60%"> Indicates that the target processor architecture has already been set. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%"> Indicates that system resources
    ///    are low. </td> </tr> </table>
    ///    
    HRESULT SetTemporaryStoreLocation(const(wchar)* TemporaryStoreLocation);
    ///Gets the unique identifier associated with the current target.
    ///Params:
    ///    TargetID = The unique identifier associated with the current target.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success. It may return <b>E_OUTOFMEMORY</b> if
    ///    there are insufficient resources to return information to the user.
    ///    
    HRESULT GetTargetID(BSTR* TargetID);
    ///Sets the unique identifier associated with current target.
    ///Params:
    ///    TargetID = The unique identifier associated with current target.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT SetTargetID(GUID TargetID);
    ///Gets processor architecture associated with the current target.
    ///Params:
    ///    ProcessorArchitecture = The processor architecture associated with the current target.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT GetTargetProcessorArchitecture(BSTR* ProcessorArchitecture);
    ///Sets the processor architecture associated with the current target.
    ///Params:
    ///    ProcessorArchitecture = The processor architecture associated with the current target.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success. Returns <b>HRESULT_FROM_WIN32</b>
    ///    (<b>ERROR_INVALID_OPERATION</b>) if the target processor architecture has been set. May return
    ///    <b>E_OUTOFMEMORY</b> if system resources are low.
    ///    
    HRESULT SetTargetProcessorArchitecture(const(wchar)* ProcessorArchitecture);
    ///Gets a property value for the offline installation location.
    ///Params:
    ///    Offline = <b>True</b> if the installation location is offline.
    ///    Property = The name of the property.
    ///    Value = The value of the property.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Indicates success. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> Indicates that the requested
    ///    property does not exist. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> Indicates that there are insufficient resources to return information to the user. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetProperty(BOOL Offline, const(wchar)* Property, BSTR* Value);
    ///Sets a property value for the offline installation location.
    ///Params:
    ///    Offline = <b>True</b> if installation location is offline.
    ///    Property = The name of the property.
    ///    Value = The value of the property.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT SetProperty(BOOL Offline, const(wchar)* Property, const(wchar)* Value);
    ///Gets the enumerator used to access the collection of offline properties.
    ///Params:
    ///    Enumerator = A pointer to an IItemEnumerator object that provides access to the collection of offline properties.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT GetEnumerator(IItemEnumerator* Enumerator);
    ///Expands a location string to indicate the offline installation location.
    ///Params:
    ///    Offline = <b>True</b> if the installation location is offline.
    ///    Location = The location string.
    ///    ExpandedLocation = The expanded location string.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success. This method may return
    ///    <b>E_OUTOFMEMORY</b> if there are insufficient resources to return information to the user.
    ///    
    HRESULT ExpandTarget(BOOL Offline, const(wchar)* Location, BSTR* ExpandedLocation);
    ///Expands a location string to indicate the offline installation location.
    ///Params:
    ///    Offline = <b>True</b> if the installation location is offline.
    ///    Location = The location string.
    ///    ExpandedLocation = The expanded location target path.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success. This method may return
    ///    <b>E_OUTOFMEMORY</b> if there are insufficient resources to return information to the user.
    ///    
    HRESULT ExpandTargetPath(BOOL Offline, const(wchar)* Location, BSTR* ExpandedLocation);
    ///Sets the module path for the offline installation location.
    ///Params:
    ///    Module = The name of the module.
    ///    Path = The module path.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT SetModulePath(const(wchar)* Module, const(wchar)* Path);
    ///Loads the module from the offline installation location.
    ///Params:
    ///    Module = The name of the module.
    ///    ModuleHandle = The module handle.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT LoadModule(const(wchar)* Module, ptrdiff_t* ModuleHandle);
    ///Sets an opaque context object for wow64 redirection.
    ///Params:
    ///    InstallerModule = The name of the installer module.
    ///    Wow64Context = The opaque context object for wow64 redirection.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT SetWow64Context(const(wchar)* InstallerModule, ubyte* Wow64Context);
    ///Translates paths for wow64 redirection.
    ///Params:
    ///    ClientArchitecture = The name of the client architecture.
    ///    Value = The original path value.
    ///    TranslatedValue = The translated path value.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT TranslateWow64(const(wchar)* ClientArchitecture, const(wchar)* Value, BSTR* TranslatedValue);
    ///Sets the location of the schema hive.
    ///Params:
    ///    pwzHiveDir = A pointer to the location of the schema hive.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Indicates success. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b> E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Indicates that the system
    ///    is low on resources. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> Indicates that the location <i>pwzHiveDir</i> is not a directory. </td> </tr> </table>
    ///    
    HRESULT SetSchemaHiveLocation(const(wchar)* pwzHiveDir);
    ///Get the location of the schema hive.
    ///Params:
    ///    pHiveLocation = A pointer to the schema hive location.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success. It returns <b>S_FALSE</b> if the
    ///    location is not set. It may return <b>E_OUTOFMEMORY</b> if there are insufficient resources to return
    ///    information to the user.
    ///    
    HRESULT GetSchemaHiveLocation(BSTR* pHiveLocation);
    ///Sets the name of the mount location of the schema hive.
    ///Params:
    ///    pwzMountName = The mount location of the schema hive.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success. May return <b>E_OUTOFMEMORY</b> if the
    ///    system is low on resources.
    ///    
    HRESULT SetSchemaHiveMountName(const(wchar)* pwzMountName);
    ///Gets the name of the mount location of the schema hive.
    ///Params:
    ///    pMountName = The name of the mount location of the schema hive. The value of <i>pMountName</i> is <b>NULL</b> on return if
    ///                 the default name is to be used.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success. It may return <b>E_OUTOFMEMORY</b> if
    ///    there are insufficient resources to return information to the user.
    ///    
    HRESULT GetSchemaHiveMountName(BSTR* pMountName);
}

///The central interface for opening namespaces and controlling how they are opened.Unless otherwise specified, all
///methods return an HRESULT value.
@GUID("9F7D7BB9-20B3-11DA-81A5-0030F1642E3C")
interface ISettingsEngine : IUnknown
{
    ///Returns an enumerator to the installed namespaces.
    ///Params:
    ///    Flags = A WcmNamespaceEnumerationFlags value that specifies the context to include in the collection of namespaces.
    ///    Reserved = Reserved. Must be <b>NULL</b>.
    ///    Namespaces = An IItemEnumerator interface pointer whose methods can be used to access members of the collection.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success. It returns <b>WCM_E_USERNOTFOUND</b> if
    ///    the store is not loaded.
    ///    
    HRESULT GetNamespaces(WcmNamespaceEnumerationFlags Flags, void* Reserved, IItemEnumerator* Namespaces);
    ///Opens an existing namespace as specified by the ISettingsIdentity parameter.
    ///Params:
    ///    SettingsID = An ISettingsIdentity object that specifies an existing namespace to get.
    ///    Access = A WcmNamespaceAccess value that specifies the type of access, whether it is read-only or read and write
    ///             access.
    ///    Reserved = Reserved. Must be <b>NULL</b>.
    ///    NamespaceItem = A pointer to an ISettingsNamespace object that is the result of the get operation.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Indicates success. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>WCM_E_USERNOTFOUND</b></dt> </dl> </td> <td width="60%"> Indicates that the
    ///    store is not currently loaded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WCM_E_NAMESPACENOTFOUND</b></dt>
    ///    </dl> </td> <td width="60%"> Indicates that the provided identity does not match a namespace registered in
    ///    the store. </td> </tr> </table>
    ///    
    HRESULT GetNamespace(ISettingsIdentity SettingsID, WcmNamespaceAccess Access, void* Reserved, 
                         ISettingsNamespace* NamespaceItem);
    ///Retrieves a text message for a returned HRESULT code.
    ///Params:
    ///    HResult = The HRESULT code for which this method retrieves the error description.
    ///    Message = The text message that corresponds to the HRESULT code.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success. It may return <b>E_OUTOFMEMORY</b> if
    ///    there are insufficient resources to allocate the string returned in the message.
    ///    
    HRESULT GetErrorDescription(int HResult, BSTR* Message);
    ///Creates an empty settings identity.
    ///Params:
    ///    SettingsID = A value that returns a pointer to an empty ISettingsIdentity object.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success. It may return <b>E_OUTOFMEMORY</b> if
    ///    there are insufficient resources to allocate the ISettingsIdentity object.
    ///    
    HRESULT CreateSettingsIdentity(ISettingsIdentity* SettingsID);
    ///Gets the status of the schema store.
    ///Params:
    ///    Reserved = Reserved. Must be <b>NULL</b>.
    ///    Status = A WcmUserStatus value that indicates the status of the store.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT GetStoreStatus(void* Reserved, WcmUserStatus* Status);
    ///Initializes and loads the schema store hive.
    ///Params:
    ///    Flags = Flags must have a value 0 or have the value <b>LINK_STORE_TO_ENGINE_INSTANCE</b>. In a normal operation,
    ///            loading the store is a persistent operation which affects the overall state of the system. The store is not
    ///            cleaned up after the process exits. The developer must call UnloadStore to avoid a leak in the hive. A leak
    ///            in the hive can cause future issues when accessing the same image.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT LoadStore(uint Flags);
    ///Unloads the schema store hive and frees resources. If there are currently unreleased SMI objects when calling
    ///this method, it fails and returns an error value <b>E_ACCESSDENIED</b>. You must release all SMI objects before
    ///calling <b>UnloadStore</b>.
    ///Params:
    ///    Reserved = Reserved.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success. If there are currently unreleased SMI
    ///    objects when calling <b>UnloadStore</b>, <b>UnloadStore</b> will fail and return <b>E_ACCESSDENIED</b>.
    ///    Before calling <b>UnloadStore</b>, release all SMI objects. If the store was not already loaded, it may
    ///    return <b>E_INVALIDARG</b>.
    ///    
    HRESULT UnloadStore(void* Reserved);
    ///Registers a namespace from a stream. The stream passed as a parameter to this method must be the XML for the
    ///configuration section of a manifest. This method is deprecated.
    ///Params:
    ///    SettingsID = An ISettingsIdentity value that identifies the namespace to be registered.
    ///    Stream = The stream that specifies the configuration.
    ///    PushSettings = When this flag is set to <b>TRUE</b>, settings are pushed to the registry or to the initialization files. If
    ///                   the flag is not set, only the store for settings is changed.
    ///    Results = Results is a variant of type <b>VT_VARIANT</b> or <b>VT_ARRAY</b>, each of which points to an ISettingsResult
    ///              object which describes an error or warning uncovered during manifest compilation.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT RegisterNamespace(ISettingsIdentity SettingsID, IStream Stream, BOOL PushSettings, VARIANT* Results);
    ///Unregisters an existing namespace. This method is deprecated.
    ///Params:
    ///    SettingsID = An ISettingsIdentity interface value that identifies the namespace to be unregistered.
    ///    RemoveSettings = When <b>true</b>, specifies that settings must be removed.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT UnregisterNamespace(ISettingsIdentity SettingsID, BOOL RemoveSettings);
    ///Creates an empty target.
    ///Params:
    ///    Target = An ITargetInfo interface pointer to an empty target.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success. It may return <b>E_OUTOFMEMORY</b> if
    ///    there are insufficient resources to create an ITargetInfo object.
    ///    
    HRESULT CreateTargetInfo(ITargetInfo* Target);
    ///Gets the current offline target for the engine.
    ///Params:
    ///    Target = A pointer to an ITargetInfo object that is the current target for the engine.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT GetTargetInfo(ITargetInfo* Target);
    ///Sets the current offline target for the engine.
    ///Params:
    ///    Target = An ITargetInfo value that specifies the target.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT SetTargetInfo(ITargetInfo Target);
    ///Creates a settings context.
    ///Params:
    ///    Flags = The value of the Flags parameter may be 0, indicating "normal mode" or 0x00000001, indicating
    ///            <b>LIMITED_VALIDATION_MODE</b>. In normal mode, the settings context validates any changes made to list items
    ///            against the current state of the target image. For example, if an attempt is made to create a list element
    ///            that already exists in the image, the create operation fails. In <b>LIMITED_VALIDATION_MODE</b>,
    ///            contradictory data is not accepted. You cannot modify and then add a list item. However, no attempt is made
    ///            to verify the changes made against the current state of the system. Only use <b>LIMITED_VALIDATION_MODE</b>
    ///            when the intention is to author a context which is to be serialized. Do not specify this flag when creating a
    ///            context to be used for ISettingsEngine::ApplySettingsContext. If used, the context may not be sufficiently
    ///            validated and may fail during an application.
    ///    Reserved = Reserved. Must be <b>NULL</b>.
    ///    SettingsContext = A pointer to an ISettingsContext object that represents the created context.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success. This method may return
    ///    <b>E_OUTOFMEMORY</b> if there were insufficient resources to create the ISettingsContext object.
    ///    
    HRESULT CreateSettingsContext(uint Flags, void* Reserved, ISettingsContext* SettingsContext);
    HRESULT SetSettingsContext(ISettingsContext SettingsContext);
    ///Applies a settings context.
    ///Params:
    ///    SettingsContext = The context that contains the setting data to apply.
    ///    pppwzIdentities = Identities of the namespaces that were applied to the system in a string format.
    ///    pcIdentities = The number of identities in <i>pppwzIdentities</i>.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT ApplySettingsContext(ISettingsContext SettingsContext, ushort*** pppwzIdentities, size_t* pcIdentities);
    HRESULT GetSettingsContext(ISettingsContext* SettingsContext);
}

///Navigates the settings tree, retrieves the metadata for a particular setting, and retrieves or modify its value.
@GUID("9F7D7BBB-20B3-11DA-81A5-0030F1642E3C")
interface ISettingsItem : IUnknown
{
    ///Gets the name of the item.
    ///Params:
    ///    Name = The name of the item.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success. It may return <b>E_OUTOFMEMORY</b> if
    ///    there are insufficient resources to allocate Name.
    ///    
    HRESULT GetName(BSTR* Name);
    ///Gets the current value from the item.
    ///Params:
    ///    Value = The value of the item.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Indicates success. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32 (ERROR_INVALID_OPERATION)</b></dt> </dl> </td> <td
    ///    width="60%"> Indicates that the item is not a scalar setting. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%"> Indicates that there are insufficient resources
    ///    to allocate the return data. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td
    ///    width="60%"> Indicates that there is no value for the item. </td> </tr> </table>
    ///    
    HRESULT GetValue(VARIANT* Value);
    ///Sets the value of an item.
    ///Params:
    ///    Value = Variant that contains the value of the item.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Indicates success. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>WCM_E_INVALIDVALUE, WCM_E_INVALIDVALUEFORMAT, or WCM_E_INVALIDDATATYPE</b></dt>
    ///    </dl> </td> <td width="60%"> Indicates that the value is not of the correct type for the item, or that the
    ///    value cannot be coerced to the correct type. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WCM_E_READONLYITEM</b></dt> </dl> </td> <td width="60%"> Indicates that the item cannot be written,
    ///    either because it is a read-only item, or because the namespace was opened in ReadOnly mode. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetValue(const(VARIANT)* Value);
    ///Gets the setting type for the item.
    ///Params:
    ///    Type = A WcmSettingType value that contains the setting type of the item.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT GetSettingType(WcmSettingType* Type);
    ///Gets the type information for the item.
    ///Params:
    ///    Type = A WcmDataType value that indicates the data type of the item.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT GetDataType(WcmDataType* Type);
    ///Gets the value from the current item as a byte array. <div class="alert"><b>Note</b> The caller must release the
    ///returned byte array by calling CoTaskMemFree.</div><div> </div>
    ///Params:
    ///    Data = An array of BYTE pointers, allocated with CoTaskMemAlloc, of length DataSize.
    ///    DataSize = The length of the data.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Indicates success. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32 (ERROR_INVALID_OPERATION)</b></dt> </dl> </td> <td
    ///    width="60%"> Indicates that the item is not a scalar setting. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%"> Indicates that there are insufficient resources
    ///    to allocate the return data. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td
    ///    width="60%"> Indicates that there is no value for the item. </td> </tr> </table>
    ///    
    HRESULT GetValueRaw(ubyte** Data, uint* DataSize);
    ///Sets the value of the current item by supplying data in raw form.
    ///Params:
    ///    DataType = The data type of the item.
    ///    Data = A byte array that contains the value of the item.
    ///    DataSize = The size of the byte array.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Indicates success. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>WCM_E_INVALIDVALUE, WCM_E_INVALIDVALUEFORMAT, or WCM_E_INVALIDDATATYPE</b></dt>
    ///    </dl> </td> <td width="60%"> Indicates that the value is not of the correct type for the item, or that the
    ///    value cannot be coerced to the correct type. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WCM_E_READONLYITEM</b></dt> </dl> </td> <td width="60%"> Indicates that the item cannot be written,
    ///    either because it is a read-only item, or because the namespace was opened in ReadOnly mode. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetValueRaw(int DataType, const(ubyte)* Data, uint DataSize);
    ///Determines whether the current item has a child item.
    ///Params:
    ///    ItemHasChild = <b>True</b> if a child item is present, <b>false</b> otherwise.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT HasChild(int* ItemHasChild);
    ///Gets the dictionary of the child items that correspond to this item.
    ///Params:
    ///    Children = An IItemEnumerator interface pointer used to access the children.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Indicates success. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Indicates that there are
    ///    insufficient resources to allocate an enumerator for the children. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32 (ERROR_INVALID_OPERATION)</b></dt> </dl> </td> <td width="60%"> Indicates that the
    ///    item does not support having children. </td> </tr> </table>
    ///    
    HRESULT Children(IItemEnumerator* Children);
    ///Gets the child item that has the specified name.
    ///Params:
    ///    Name = The name of the child item.
    ///    Child = A pointer to an ISettingsItem object that corresponds to the child item.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Indicates success. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>WCM_E_STATENODENOTFOUND</b></dt> </dl> </td> <td width="60%"> Indicates that the
    ///    requested name is not a child of the item. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WCM_E_WRONGESCAPESTRING</b></dt> </dl> </td> <td width="60%"> Indicates that the name contains an
    ///    unrecognized XML escape sequence. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WCM_E_INVALIDPATH</b></dt>
    ///    </dl> </td> <td width="60%"> Indicates that the name is not formatted correctly. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WCM_E_INVALIDKEY </b></dt> </dl> </td> <td width="60%"> Indicates that the path is
    ///    incorrectly specified and references the wrong key for the list item. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_OPERATION)</b></dt> </dl> </td> <td width="60%"> Indicates that the
    ///    item does not support children. </td> </tr> </table>
    ///    
    HRESULT GetChild(const(wchar)* Name, ISettingsItem* Child);
    ///Gets a setting based on the given path.
    ///Params:
    ///    Path = Path of the list element or attribute to retrieve. The path is relative to the current setting.
    ///    Setting = An ISettingsItem interface pointer used to access the item.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Indicates success. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>WCM_E_STATENODENOTFOUND</b></dt> </dl> </td> <td width="60%"> Indicates an
    ///    attempt to get an item that does not exist. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WCM_E_WRONGESCAPESTRING</b></dt> </dl> </td> <td width="60%"> Indicates that the path contains an
    ///    unrecognized XML escape sequence. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WCM_E_INVALIDPATH</b></dt>
    ///    </dl> </td> <td width="60%"> Indicates that the path is incorrectly formatted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WCM_E_INVALIDKEY </b></dt> </dl> </td> <td width="60%"> Indicates that the path is
    ///    incorrectly specified and references the wrong key for the list item. </td> </tr> </table>
    ///    
    HRESULT GetSettingByPath(const(wchar)* Path, ISettingsItem* Setting);
    ///Creates a setting object specified by the path.
    ///Params:
    ///    Path = A pointer to the path.
    ///    Setting = A pointer to the newly created ISettingsItem item.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Indicates success. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>WCM_E_STATENODENOTFOUND</b></dt> </dl> </td> <td width="60%"> Indicates that the
    ///    method is called to create an item that is not a list element or does not already exist. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WCM_E_READONLYITEM</b></dt> </dl> </td> <td width="60%"> Indicates that the item
    ///    cannot be written, such as if it is a read only item, or the namespace was opened in ReadOnly mode. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>WCM_E_INVALIDVALUE, WCM_E_INVALIDVALUEFORMAT, or
    ///    WCM_E_INVALIDDATATYPE</b></dt> </dl> </td> <td width="60%"> Indicates that the value provided for the key
    ///    cannot be coerced to the appropriate type, such as a string value coerced to an unsigned integer. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>WCM_E_WRONGESCAPESTRING</b></dt> </dl> </td> <td width="60%"> Indicates
    ///    that the path contains an unrecognized XML escape sequence. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WCM_E_INVALIDKEY</b></dt> </dl> </td> <td width="60%"> Indicates that the path is incorrectly
    ///    specified and references the wrong key for a list item. </td> </tr> </table>
    ///    
    HRESULT CreateSettingByPath(const(wchar)* Path, ISettingsItem* Setting);
    ///Removes a setting object specified by its path. Unlike GetSettingByPath, the use of
    ///<b>ISettingsItem::RemoveSettingByPath</b> is not advocated for attributes.
    ///Params:
    ///    Path = The path of the item to remove. The path is relative to the current item.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Indicates success. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>WCM_E_STATENODENOTFOUND </b></dt> </dl> </td> <td width="60%"> Indicates an
    ///    attempt to remove an item that does not exist. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32 (ERROR_INVALID_OPERATION)</b></dt> </dl> </td> <td width="60%"> Indicates an
    ///    attempt to remove an element that is not a list element. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WCM_E_READONLYITEM </b></dt> </dl> </td> <td width="60%"> Indicates that the item cannot be written,
    ///    either because it is a read-only item, or because the namespace was opened in ReadOnly mode. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>WCM_E_WRONGESCAPESTRING</b></dt> </dl> </td> <td width="60%"> Indicates that the
    ///    path contains an unrecognized XML escape sequence. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WCM_E_INVALIDPATH</b></dt> </dl> </td> <td width="60%"> Indicates that the path is incorrectly
    ///    formatted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WCM_E_INVALIDKEY </b></dt> </dl> </td> <td
    ///    width="60%"> Indicates that the path is incorrectly specified and references the wrong key for the list item.
    ///    </td> </tr> </table>
    ///    
    HRESULT RemoveSettingByPath(const(wchar)* Path);
    ///Gets the list information for this item.
    ///Params:
    ///    KeyName = The name of the key.
    ///    DataType = A WcmDataType value that indicates the data type of the item.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Indicates success. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_FALSE </b></dt> </dl> </td> <td width="60%"> Indicates that the list is keyed
    ///    by keyValue, and KeyName is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_OPERATION)</b></dt> </dl> </td> <td width="60%"> Indicates that the
    ///    item is not a list or list element. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt>
    ///    </dl> </td> <td width="60%"> Indicates that there are insufficient resources to complete the operation. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetListKeyInformation(BSTR* KeyName, WcmDataType* DataType);
    ///Creates a new list element.
    ///Params:
    ///    KeyData = The information for the key that defines the identity of the new list item. To determine the correct value
    ///              for the key data parameter, consult the information returned from ISettingsItem::GetListKeyInformation. The
    ///              variant obtained from <b>ISettingsItem::GetListKeyInformation</b> should be coercible to the type of the key.
    ///              If the <b>ISettingsItem::GetListKeyInformation</b> method returns <b>S_FALSE</b>, use a string type for the
    ///              key data.
    ///    Child = A pointer to the newly created ISettingsItem list item.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Indicates success. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32 (ERROR_INVALID_OPERATION)</b></dt> </dl> </td> <td
    ///    width="60%"> Indicates that the method is called on an item that is not of setting type list. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>WCM_E_INVALIDVALUE, WCM_E_INVALIDVALUEFORMAT, or
    ///    WCM_E_INVALIDDATATYPE</b></dt> </dl> </td> <td width="60%"> Indicates an attempt to create a list where the
    ///    key cannot be coerced to the correct type. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WCM_E_READONLYITEM
    ///    </b></dt> </dl> </td> <td width="60%"> Indicates that the item cannot be written, either because it is a
    ///    read-only item, or because the namespace was opened in ReadOnly mode. </td> </tr> </table>
    ///    
    HRESULT CreateListElement(const(VARIANT)* KeyData, ISettingsItem* Child);
    ///Removes an existing list element of the supplied name.There cannot be multiples with same name because the name
    ///must be unique. If an item of the specified name is not present, the method returns
    ///<b>WCM_E_STATENOTNOTFOUND</b>.
    ///Params:
    ///    ElementName = The name of the element to be removed.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Indicates success. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>WCM_E_STATENODENOTFOUND </b></dt> </dl> </td> <td width="60%"> Indicates an
    ///    attempt to remove an item that does not exist. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Indicates that the item that is not of setting type
    ///    list. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WCM_E_READONLYITEM </b></dt> </dl> </td> <td width="60%">
    ///    Indicates that the item cannot be written, either because it is a read-only item, or because the namespace
    ///    was opened in ReadOnly mode. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WCM_E_WRONGESCAPESTRING</b></dt>
    ///    </dl> </td> <td width="60%"> Indicates that the path contains an unrecognized XML escape sequence. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>WCM_E_INVALIDPATH</b></dt> </dl> </td> <td width="60%"> Indicates
    ///    that the path is incorrectly formatted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WCM_E_INVALIDKEY
    ///    </b></dt> </dl> </td> <td width="60%"> Indicates that the path is incorrectly specified and references the
    ///    wrong key for the list item. </td> </tr> </table>
    ///    
    HRESULT RemoveListElement(const(wchar)* ElementName);
    ///Gets the dictionary of attributes.
    ///Params:
    ///    Attributes = A pointer to an IItemEnumerator object that represents the dictionary of attributes.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success. It may return <b>E_OUTOFMEMORY</b> if
    ///    there are insufficient resources to allocate attributes.
    ///    
    HRESULT Attributes(IItemEnumerator* Attributes);
    ///Gets the value of an attribute by specifying its name.
    ///Params:
    ///    Name = The name of the attribute.
    ///    Value = The value of the attribute.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Indicates success. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>WCM_E_ATTRIBUTENOTFOUND</b></dt> </dl> </td> <td width="60%"> Indicates that the
    ///    attribute requested is not specified on the item. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Indicates that there are insufficient resources to
    ///    return information to the user. </td> </tr> </table>
    ///    
    HRESULT GetAttribute(const(wchar)* Name, VARIANT* Value);
    ///Gets the path for the item.
    ///Params:
    ///    Path = The path to the current setting. This path should be handled as opaque, and should be used only for
    ///           invocations of CreateSettingByPath, GetSettingByPath, or RemoveSettingByPath.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success. It may return <b>E_OUTOFMEMORY</b> if
    ///    there are insufficient resources.
    ///    
    HRESULT GetPath(BSTR* Path);
    ///Gets the restrictions defined for this item.
    ///Params:
    ///    RestrictionFacets = A bitmask of the WcmRestrictionFacets values that are defined for this item.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Indicates success. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32 (ERROR_INVALID_OPERATION)</b></dt> </dl> </td> <td
    ///    width="60%"> Indicates that the item is not a scalar setting. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> Indicates that there is no value for the item. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetRestrictionFacets(WcmRestrictionFacets* RestrictionFacets);
    ///Gets the information for a given restriction.
    ///Params:
    ///    RestrictionFacet = A WcmRestrictionFacets value that indicates the type of restriction facet.
    ///    FacetData = A pointer to the facet data.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Indicates success. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32 (ERROR_INVALID_OPERATION)</b></dt> </dl> </td> <td
    ///    width="60%"> Indicates that the method was called on a non-scalar setting. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Indicates that the requested restriction facet
    ///    is not defined for this item. </td> </tr> </table>
    ///    
    HRESULT GetRestriction(WcmRestrictionFacets RestrictionFacet, VARIANT* FacetData);
    ///Extracts key values for any list that already exists in the image, for example, DNS, http settings, and user
    ///account information.
    ///Params:
    ///    Value = The value of the key for the list element. The type of the value returned is the actual type of the key. For
    ///            example, the type is a string in the case of a dynamically keyed list. The value is unescaped appropriately
    ///            to reverse the changes made by SMI for the purpose of storing it. The VARIANT type is overwritten with the
    ///            correct type if the predefined VARIANT type is incorrect.
    ///Returns:
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32 (ERROR_INVALID_OPERATION)</b></dt> </dl> </td> <td width="60%"> The item is not a
    ///    list element. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> There are insufficient resources to return information to the user. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value is null. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetKeyValue(VARIANT* Value);
}

///Performs operations to set, retrieve, and validate settings, and save changes for a namespace instance. To retrieve
///an <b>ISettingsNamespace</b> interface pointer, call the ISettingsEngine::GetNamespace method.
@GUID("9F7D7BBA-20B3-11DA-81A5-0030F1642E3C")
interface ISettingsNamespace : IUnknown
{
    ///Gets the identity of the namespace.
    ///Params:
    ///    SettingsID = A pointer to an ISettingsIdentity object that represents the namespace identity.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success. It may return <b>E_OUTOFMEMORY</b> if
    ///    there are insufficient resources to return information to the user.
    ///    
    HRESULT GetIdentity(ISettingsIdentity* SettingsID);
    ///Retrieves an enumerator for the top-level settings for the namespace.
    ///Params:
    ///    Settings = A pointer to an IItemEnumerator object that provides methods to access all the settings for this namespace.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success. It may return <b>E_OUTOFMEMORY</b> if
    ///    there are insufficient resources to return information to the user.
    ///    
    HRESULT Settings(IItemEnumerator* Settings);
    ///Updates the settings namespace to persistent and visible.
    ///Params:
    ///    PushSettings = Not used. A flag that controls whether to transfer settings to the registry or to an initialization file.
    ///    Result = A pointer to an ISettingsResult object that contains any error that may have occurred while saving the
    ///             namespace.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT Save(BOOL PushSettings, ISettingsResult* Result);
    ///Gets the setting object specified by a path.
    ///Params:
    ///    Path = The path of the object.
    ///    Setting = A pointer to an ISettingsItem object that represents the retrieved object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Indicates success. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>WCM_E_STATENODENOTFOUND</b></dt> </dl> </td> <td width="60%"> Indicates an
    ///    attempt to get an item that does not exist. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WCM_E_INVALIDPATH</b></dt> </dl> </td> <td width="60%"> Indicates that the path is not formatted
    ///    correctly. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WCM_E_INVALIDKEY</b></dt> </dl> </td> <td
    ///    width="60%"> Indicates that the path contains an unrecognized XML escape sequence. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WCM_E_WRONGESCAPESTRING</b></dt> </dl> </td> <td width="60%"> Indicates that the
    ///    path is incorrectly specified and references the wrong key for a list item. </td> </tr> </table>
    ///    
    HRESULT GetSettingByPath(const(wchar)* Path, ISettingsItem* Setting);
    ///Creates a setting object specified by its path.
    ///Params:
    ///    Path = The path of the setting object.
    ///    Setting = A pointer to an ISettingsItem object that represents the created setting.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Indicates success. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>WCM_E_STATENODENOTFOUND</b></dt> </dl> </td> <td width="60%"> Indicates an
    ///    attempt to create a new item that is not a list element. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WCM_E_INVALIDVALUE, WCM_E_INVALIDVALUEFORMAT, or WCM_E_INVALIDDATATYPE</b></dt> </dl> </td> <td
    ///    width="60%"> Indicates an attempt to create a list item where the value provided for the key cannot be
    ///    coerced to the appropriate type. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WCM_E_READONLYITEM</b></dt>
    ///    </dl> </td> <td width="60%"> Indicates that the item cannot be written, either because it is a read-only
    ///    item, or because the namespace was opened in ReadOnly mode. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WCM_E_INVALIDPATH</b></dt> </dl> </td> <td width="60%"> Indicates that the path is incorrectly
    ///    formatted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WCM_E_WRONGESCAPESTRING</b></dt> </dl> </td> <td
    ///    width="60%"> Indicates that the path contains an unrecognized XML escape sequence. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WCM_E_INVALIDKEY</b></dt> </dl> </td> <td width="60%"> Indicates that the path is
    ///    incorrectly specified and references the wrong key for a list item. </td> </tr> </table>
    ///    
    HRESULT CreateSettingByPath(const(wchar)* Path, ISettingsItem* Setting);
    ///Removes the setting object specified by a path.
    ///Params:
    ///    Path = The path of the setting object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Indicates success. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>WCM_E_STATENODENOTFOUND</b></dt> </dl> </td> <td width="60%"> Indicates an
    ///    attempt to remove an item that does not exist. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_OPERATION)</b></dt> </dl> </td> <td width="60%"> Indicates an attempt
    ///    to remove an element that is not in the list. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WCM_E_READONLYITEM</b></dt> </dl> </td> <td width="60%"> Indicates that the item cannot be written,
    ///    either because it is a read-only item, or the namespace was opened in ReadOnly mode. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WCM_E_INVALIDPATH</b></dt> </dl> </td> <td width="60%"> Indicates that the path is
    ///    incorrectly formatted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WCM_E_WRONGESCAPESTRING </b></dt> </dl>
    ///    </td> <td width="60%"> Indicates that the path contains an unrecognized XML escape sequence. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>WCM_E_INVALIDKEY</b></dt> </dl> </td> <td width="60%"> Indicates that the path
    ///    is incorrectly specified and references the wrong key for the list item. </td> </tr> </table>
    ///    
    HRESULT RemoveSettingByPath(const(wchar)* Path);
    ///Gets the value of an attribute of the namespace.
    ///Params:
    ///    Name = The name of the attribute.
    ///    Value = The value of the attribute.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Indicates success. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>WCM_E_ATTRIBUTENOTFOUND</b></dt> </dl> </td> <td width="60%"> Indicates that the
    ///    requested attribute is not specified for the item. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Indicates that there are insufficient resources to
    ///    return information to the user. </td> </tr> </table>
    ///    
    HRESULT GetAttribute(const(wchar)* Name, VARIANT* Value);
}

///Retrieves the code and description for errors and warnings returned by various operations.
@GUID("9F7D7BBC-20B3-11DA-81A5-0030F1642E3C")
interface ISettingsResult : IUnknown
{
    ///Returns the description of the error.
    ///Params:
    ///    description = The text that describes the error.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success. It may return <b>E_OUTOFMEMORY</b> if
    ///    there are insufficient resources to return information to the user.
    ///    
    HRESULT GetDescription(BSTR* description);
    ///Returns the HRESULT error code value.
    ///Params:
    ///    hrOut = The error code value.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT GetErrorCode(int* hrOut);
    ///Returns the description of the context that surrounds the error.
    ///Params:
    ///    description = The text that describes the context.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success. It may return <b>E_OUTOFMEMORY</b> if
    ///    there are insufficient resources to return information to the user.
    ///    
    HRESULT GetContextDescription(BSTR* description);
    ///Returns the line number where the error has occurred.
    ///Params:
    ///    dwLine = The line number where the error has occurred.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT GetLine(uint* dwLine);
    ///Returns the column number where the error occurred.
    ///Params:
    ///    dwColumn = The column which is the source of the error.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT GetColumn(uint* dwColumn);
    ///Returns the file or path where the error has occurred.
    ///Params:
    ///    file = The file or path where the error has occurred.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success. It may return <b>E_OUTOFMEMORY</b> if
    ///    there are insufficient resources to return information to the user.
    ///    
    HRESULT GetSource(BSTR* file);
}

///An interface to a backing store that is used to store setting changes made through the other SMI APIs, and provides
///operations to serialize to and deserialize from a representation.
@GUID("9F7D7BBD-20B3-11DA-81A5-0030F1642E3C")
interface ISettingsContext : IUnknown
{
    ///Serializes the data in this context into the provided stream.
    ///Params:
    ///    pStream = The stream into which the XML, produced by the method, is inserted.
    ///    pTarget = Defines the parameters of the image against which the context must be serialized. This should match the
    ///              target used while constructing the context.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT Serialize(IStream pStream, ITargetInfo pTarget);
    ///Deserializes the data in the stream that is provided to this context.
    ///Params:
    ///    pStream = A pointer to an IStream initialized stream object containing the XML representing a settings section of an
    ///              answer (Unattend.xml) file. An answers file is a file that facilitates the unattend process during setup or
    ///              migration to execute all of its tasks automatically, without user intervention.
    ///    pTarget = A pointer that identifies ITargetInfo target object that should be used while deserializing the stream. This
    ///              target should match the target which will be used on the engine alongside this context.
    ///    pppResults = A pointer to an array of ISettingsResult interface pointers. Each interface pointer identifies an issue which
    ///                 may have occurred during deserialization.
    ///    pcResultCount = The number of ISettingsResult objects in the array pppResults.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success. It returns
    ///    <b>WCM_E_NAMESPACENOTFOUND</b> if pIdentity references a namespace that is not in the context. This method
    ///    may return <b>E_OUTOFMEMORY</b> if there are insufficient resources on the system to allocate the
    ///    enumerators.
    ///    
    HRESULT Deserialize(IStream pStream, ITargetInfo pTarget, ISettingsResult** pppResults, size_t* pcResultCount);
    ///Sets the user-defined data.
    ///Params:
    ///    pUserData = A pointer to the user-defined data.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT SetUserData(void* pUserData);
    ///Gets a user-defined data.
    ///Params:
    ///    pUserData = The user-defined data.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT GetUserData(void** pUserData);
    ///Gets the namespaces that exist in the context.
    ///Params:
    ///    ppNamespaceIds = An IItemEnumerator interface pointer that represents the collection of namespaces.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success.
    ///    
    HRESULT GetNamespaces(IItemEnumerator* ppNamespaceIds);
    ///Gets the stored setting changes from the context for the given namespace. This method returns a pointer to an
    ///address of an enumerator for each of the parameters <i>ppAddedSettings</i>, <i>ppModifiedSettings</i>, and
    ///<i>ppDeletedSettings</i> that identifies the set of paths for the added, modified, and deleted settings
    ///respectively. These strings may then be passed to ISettingsContext::RevertSetting.
    ///Params:
    ///    pIdentity = The ISettingsIdentity object that specifies the namespace to get the settings for. This namespace identity
    ///                should be fully-specified.
    ///    ppAddedSettings = A pointer to a newly allocated IItemEnumerator object that lists the set of paths for the added settings.
    ///                      Each path identifies a setting added to the context.
    ///    ppModifiedSettings = A pointer to a newly-allocated IItemEnumerator object that lists the set of paths for the modified settings.
    ///    ppDeletedSettings = A pointer to a newly-allocated IItemEnumerator object that lists the set of paths for the deleted settings.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success. It returns
    ///    <b>WCM_E_NAMESPACENOTFOUND</b> if <i>pIdentity</i> references a namespace that is not in the context. It may
    ///    return <b>E_OUTOFMEMORY</b> if there are insufficient resources on the system to allocate the enumerators.
    ///    
    HRESULT GetStoredSettings(ISettingsIdentity pIdentity, IItemEnumerator* ppAddedSettings, 
                              IItemEnumerator* ppModifiedSettings, IItemEnumerator* ppDeletedSettings);
    ///Reverts a setting in the namespace.
    ///Params:
    ///    pIdentity = The fully-specified identity for the namespace that holds the setting to be reverted.
    ///    pwzSetting = A path to a setting within the namespace that has been overridden in this context.
    ///Returns:
    ///    This method returns an HRESULT value. <b>S_OK</b> indicates success. It returns
    ///    <b>WCM_E_NAMESPACENOTFOUND</b> if <i>pIdentity</i> specifies a namespace that is not currently in the
    ///    context. It returns <b>WCM_E_STATENODENOTFOUND</b> if <i>pwzSetting</i> is not changed in the context.
    ///    
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
