// Written in the D programming language.

module windows.windowssync;

public import windows.core;
public import windows.audio : IPropertyStore;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : BOOL, HANDLE;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Enums


///Represents the role of a provider, relative to the other provider in the synchronization session.
alias SYNC_PROVIDER_ROLE = int;
enum : int
{
    ///The provider is the source provider.
    SPR_SOURCE      = 0x00000000,
    ///The provider is the destination provider.
    SPR_DESTINATION = 0x00000001,
}

///Represents the options for the concurrency conflict resolution policy to use for the synchronization session.
alias CONFLICT_RESOLUTION_POLICY = int;
enum : int
{
    ///The change applier notifies the synchronization application of each conflict as it occurs, by using the
    ///ISyncCallback::OnConflict method. The application examines the conflicting items and specifies the conflict
    ///resolution action by calling IChangeConflict::SetResolveActionForChange or
    ///IChangeConflict::SetResolveActionForChangeUnit.
    CRP_NONE                      = 0x00000000,
    ///The change made on the destination replica always wins. This supports the case in which the destination replica
    ///does not consume changes that are made by remote clients.
    CRP_DESTINATION_PROVIDER_WINS = 0x00000001,
    ///The change made on the source replica always wins. This supports a read-only synchronization solution in which
    ///the destination replica is not to be trusted.
    CRP_SOURCE_PROVIDER_WINS      = 0x00000002,
    ///A placeholder for the last element in the enumeration. Do not use this value.
    CRP_LAST                      = 0x00000003,
}

///Represents the stages of a synchronization session.
alias SYNC_PROGRESS_STAGE = int;
enum : int
{
    ///Changes are being detected on the source replica.
    SPS_CHANGE_DETECTION   = 0x00000000,
    ///Changes from the source replica are being enumerated.
    SPS_CHANGE_ENUMERATION = 0x00000001,
    ///Changes are being applied to the destination replica.
    SPS_CHANGE_APPLICATION = 0x00000002,
}

///Represents the action to be taken by an application in response to ISyncCallback::OnFullEnumerationNeeded.
alias SYNC_FULL_ENUMERATION_ACTION = int;
enum : int
{
    ///Perform a full enumeration. This is the default option when the application does not register an ISyncCallback
    ///interface.
    SFEA_FULL_ENUMERATION = 0x00000000,
    ///Perform a partial synchronization. When this option is specified, the learned knowledge is applied as single item
    ///exceptions.
    SFEA_PARTIAL_SYNC     = 0x00000001,
    ///Cancel the synchronization session. All methods will return errors as if they were canceled.
    SFEA_ABORT            = 0x00000002,
}

///Represents actions that are taken to resolve a specific concurrency conflict.
alias SYNC_RESOLVE_ACTION = int;
enum : int
{
    ///Ignore the conflict and do not apply the change. The change applier does not pass the conflict data to the
    ///destination provider.
    SRA_DEFER                       = 0x00000000,
    ///The change made on the destination replica wins. Only version information for the item is updated in the metadata
    ///on the destination replica. No item data changes are made.
    SRA_ACCEPT_DESTINATION_PROVIDER = 0x00000001,
    ///The change made on the source replica wins. The change is applied to the destination replica exactly like any
    ///non-conflicting change.
    SRA_ACCEPT_SOURCE_PROVIDER      = 0x00000002,
    ///Merge the data from the source item into the destination item. The destination provider combines the source item
    ///data and the destination item data, and applies the result to the destination replica.
    SRA_MERGE                       = 0x00000003,
    ///Log the conflict and do not apply the change.
    SRA_TRANSFER_AND_DEFER          = 0x00000004,
    ///A placeholder for the last element in the enumeration. Do not use this value.
    SRA_LAST                        = 0x00000005,
}

///Represents types of statistics that convey information about a component.
alias SYNC_STATISTICS = int;
enum : int
{
    ///Indicates that the statistic represents the number of ranges that are contained in an ISyncKnowledge object.
    SYNC_STATISTICS_RANGE_COUNT = 0x00000000,
}

///Represents the version of Microsoft Sync Framework that a particular component is compatible with. For an overview of
///what is involved in building synchronization providers using Microsoft Sync Framework, see Options for Building a
///Synchronization Provider.
alias SYNC_SERIALIZATION_VERSION = int;
enum : int
{
    ///Indicates a component is compatible with Sync Framework 1.0.
    SYNC_SERIALIZATION_VERSION_V1 = 0x00000001,
    ///Indicates a component is compatible with Sync Framework 2.0.
    SYNC_SERIALIZATION_VERSION_V2 = 0x00000004,
    SYNC_SERIALIZATION_VERSION_V3 = 0x00000005,
}

///Indicates the type of information that is included in a change batch during filtered synchronization.
alias FILTERING_TYPE = int;
enum : int
{
    ///The change batch includes data and metadata for items that are currently in the filter.
    FT_CURRENT_ITEMS_ONLY                             = 0x00000000,
    FT_CURRENT_ITEMS_AND_VERSIONS_FOR_MOVED_OUT_ITEMS = 0x00000001,
}

alias __MIDL___MIDL_itf_winsync_0000_0000_0009 = int;
enum : int
{
    SCRA_DEFER                       = 0x00000000,
    SCRA_ACCEPT_DESTINATION_PROVIDER = 0x00000001,
    SCRA_ACCEPT_SOURCE_PROVIDER      = 0x00000002,
    SCRA_TRANSFER_AND_DEFER          = 0x00000003,
    SCRA_MERGE                       = 0x00000004,
    SCRA_RENAME_SOURCE               = 0x00000005,
    SCRA_RENAME_DESTINATION          = 0x00000006,
}

alias __MIDL___MIDL_itf_winsync_0000_0000_0010 = int;
enum : int
{
    CCR_OTHER     = 0x00000000,
    CCR_COLLISION = 0x00000001,
    CCR_NOPARENT  = 0x00000002,
    CCR_IDENTITY  = 0x00000003,
}

///Represents the possible results when a knowledge cookie is compared with a knowledge object by using
///ISyncKnowledge2::CompareToKnowledgeCookie.
alias KNOWLEDGE_COOKIE_COMPARISON_RESULT = int;
enum : int
{
    ///The knowledge cookie is equal to the specified knowledge.
    KCCR_COOKIE_KNOWLEDGE_EQUAL          = 0x00000000,
    ///The knowledge cookie is contained by the specified knowledge.
    KCCR_COOKIE_KNOWLEDGE_CONTAINED      = 0x00000001,
    ///The knowledge cookie contains the specified knowledge.
    KCCR_COOKIE_KNOWLEDGE_CONTAINS       = 0x00000002,
    ///The knowledge cookie cannot be compared to the specified knowledge.
    KCCR_COOKIE_KNOWLEDGE_NOT_COMPARABLE = 0x00000003,
}

alias __MIDL___MIDL_itf_winsync_0000_0036_0001 = int;
enum : int
{
    FCT_INTERSECTION = 0x00000000,
}

///Represents the different types of synchronization registration events.
alias SYNC_REGISTRATION_EVENT = int;
enum : int
{
    ///A synchronization provider registration has been added.
    SRE_PROVIDER_ADDED         = 0x00000000,
    ///A synchronization provider registration has been removed.
    SRE_PROVIDER_REMOVED       = 0x00000001,
    ///The property store (represented by the <b>IPropertyStore</b> interface) of a synchronization provider or a
    ///synchronization provider configuration UI has changed.
    SRE_PROVIDER_UPDATED       = 0x00000002,
    ///The synchronization provider state has changed.
    SRE_PROVIDER_STATE_CHANGED = 0x00000003,
    ///A synchronization provider configuration UI has been added.
    SRE_CONFIGUI_ADDED         = 0x00000004,
    ///A synchronization provider configuration UI has been removed.
    SRE_CONFIGUI_REMOVED       = 0x00000005,
    ///A synchronization provider configuration UI has been updated.
    SRE_CONFIGUI_UPDATED       = 0x00000006,
}

// Structs


///Represents the format of a synchronization entity ID.
struct ID_PARAMETER_PAIR
{
    ///<b>TRUE</b> if the ID is variable length; otherwise, <b>FALSE</b>.
    BOOL   fIsVariable;
    ///The length of the ID when <i>fIsVariable</i> is <b>FALSE</b>. The maximum length of the ID when
    ///<i>fIsVariable</i> is <b>TRUE</b>. Must be greater than zero.
    ushort cbIdSize;
}

///Represents the format schema for the group of IDs that are used to identify entities in a synchronization session.
struct ID_PARAMETERS
{
    ///The number of bytes in the <b>ID_PARAMETERS</b> structure.
    uint              dwSize;
    ///The ID format that is expected for replica IDs.
    ID_PARAMETER_PAIR replicaId;
    ///The ID format that is expected for item IDs.
    ID_PARAMETER_PAIR itemId;
    ///The ID format that is expected for change unit IDs.
    ID_PARAMETER_PAIR changeUnitId;
}

///Represents statistics about a single, unidirectional synchronization session.
struct SYNC_SESSION_STATISTICS
{
    ///The total number of changes that were successfully applied during the synchronization session. This value is the
    ///sum of item changes plus change unit changes.
    uint dwChangesApplied;
    ///The total number of changes that were not applied during a session. This value is the sum of item changes plus
    ///change unit changes.
    uint dwChangesFailed;
}

///Represents a version for an item or a change unit.
struct SYNC_VERSION
{
    ///The replica key that is associated with the version.
    uint  dwLastUpdatingReplicaKey;
    ///The tick count that is associated with the version.
    ulong ullTickCount;
}

///Represents a range of item IDs.
struct SYNC_RANGE
{
    ///The closed lower bound of item IDs that are contained in the range.
    ubyte* pbClosedLowerBound;
    ///The closed upper bound of item IDs that are contained in the range.
    ubyte* pbClosedUpperBound;
}

///Represents a date-and-time value.
struct SYNC_TIME
{
    ///The date portion of the value.
    uint dwDate;
    ///The time portion of the value.
    uint dwTime;
}

struct SYNC_FILTER_CHANGE
{
    BOOL         fMoveIn;
    SYNC_VERSION moveVersion;
}

///Represents the information for a synchronization provider configuration. This structure is passed to the
///ISyncProviderRegistration::CreateSyncProviderRegistrationInstance method when a registration instance is created.
struct SyncProviderConfiguration
{
    ///The xersion of the synchronization provider. The constant value <b>SYNC_PROVIDER_CONFIGURATION_VERSION.</b>
    uint dwVersion;
    ///The unique instance ID of the synchronization provider.
    GUID guidInstanceId;
    ///The COM CLSID of the synchronization provider.
    GUID clsidProvider;
    ///The instance ID of the configuration UI used to create this synchronization provider, or <b>GUID_NULL</b> if no
    ///configuration UI was used.
    GUID guidConfigUIInstanceId;
    ///The GUID that identifies the content type.
    GUID guidContentType;
    ///One of the following constants that represent the capabilities of the synchronization provider. <ul>
    ///<li><b>SPC_DEFAULT</b> ((DWORD)0x00000000)</li> </ul>
    uint dwCapabilities;
    ///One of the following constants that represent the architectures supported by the synchronization provider. This
    ///value corresponds to the architectures that the synchronization provider CLSID (<b>clsidProvider</b>) is
    ///registered for. These values can be combined, and can be used as bitmasks. <ul> <li><b>SYNC_32_BIT_SUPPORTED</b>
    ///((DWORD)0x00000001)</li> <li><b>SYNC_64_BIT_SUPPORTED</b> ((DWORD)0x00000002)</li> </ul>
    uint dwSupportedArchitecture;
}

///Represents the information for a synchronization provider configuration UI.
struct SyncProviderConfigUIConfiguration
{
    ///The version of the configuration UI.
    uint dwVersion;
    ///The unique instance ID of the configuration UI.
    GUID guidInstanceId;
    ///The COM CLSID of the configuration UI.
    GUID clsidConfigUI;
    ///The GUID that identifies the content type supported by the synchronization provider that is created by the
    ///configuration UI.
    GUID guidContentType;
    ///One of the following constants that represent the capabilities of the synchronization provider configuration UI.
    ///These values are masks that can be combined. <ul> <li><b>SCC_DEFAULT</b> ((DWORD)0x00000000) The configuration UI
    ///supports the default capabilities of creating and modifying a synchronization provider with a UI displayed. </li>
    ///<li><b>SCC_CAN_CREATE_WITHOUT_UI</b> ((DWORD)0x00000001) The configuration UI creates providers without
    ///displaying the UI. This value is not compatible with <b>SCC_CREATE_NOT_SUPPORTED</b>. </li>
    ///<li><b>SCC_CAN_MODIFY_WITHOUT_UI</b> ((DWORD)0x00000002) The configuration UI modifies providers without
    ///displaying the UI. This value is not compatible with <b>SCC_MODIFY_NOT_SUPPORTED</b>. </li>
    ///<li><b>SCC_CREATE_NOT_SUPPORTED</b> ((DWORD)0x00000004) The configuration UI cannot create new configured
    ///providers. This value is not compatible with <b>SCC_CAN_CREATE_WITHOUT_UI</b>. </li>
    ///<li><b>SCC_MODIFY_NOT_SUPPORTED</b> ((DWORD)0x00000008) The configuration UI cannot modify providers. This value
    ///is not compatible with <b>SCC_CAN_MODIFY_WITHOUT_UI</b>. </li> </ul>
    uint dwCapabilities;
    ///One of the following constants that represent the architectures supported by the synchronization provider
    ///configuration UI. This value corresponds to the architectures that the synchronization provider configuration UI
    ///CLSID (<b>clsidConfigUI</b>) is registered for. These values can be combined, and can be used as bitmasks. <ul>
    ///<li><b>SYNC_32_BIT_SUPPORTED</b> ((DWORD)0x00000001)</li> <li><b>SYNC_64_BIT_SUPPORTED</b>
    ///((DWORD)0x00000002)</li> </ul>
    uint dwSupportedArchitecture;
    ///Reserved for future use. At this time, the value should always be <b>FALSE</b>.
    BOOL fIsGlobal;
}

// Interfaces

@GUID("F82B4EF1-93A9-4DDE-8015-F7950A1A6E31")
struct SyncProviderRegistration;

///Represents a clock vector element of a knowledge structure.
@GUID("E71C4250-ADF8-4A07-8FAE-5669596909C1")
interface IClockVectorElement : IUnknown
{
    ///Gets the replica key for the replica that is associated with this clock vector element.
    ///Params:
    ///    pdwReplicaKey = Returns the replica key for the replica that is associated with this clock vector element.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetReplicaKey(uint* pdwReplicaKey);
    ///Gets the tick count that defines the upper bound on the range of tick counts that are contained in this clock
    ///vector element.
    ///Params:
    ///    pullTickCount = Returns the tick count that defines the upper bound on the range of tick counts that are contained in this
    ///                    clock vector element.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetTickCount(ulong* pullTickCount);
}

///Represents a clock vector element that contains FeedSync information.
@GUID("A40B46D2-E97B-4156-B6DA-991F501B0F05")
interface IFeedClockVectorElement : IClockVectorElement
{
    ///Gets a SYNC_TIME value that corresponds to the <b>when</b> value for the item.
    ///Params:
    ///    pSyncTime = Returns a SYNC_TIME value that corresponds to the <b>when</b> value for the item.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT GetSyncTime(SYNC_TIME* pSyncTime);
    ///Gets flags that specify additional information about the clock vector element.
    ///Params:
    ///    pbFlags = Returns flags that specify additional information about the clock vector element. These flags will be a
    ///              combination of the <b>SYNC_VERSION_FLAG</b> flags.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT GetFlags(ubyte* pbFlags);
}

///Represents a clock vector in a knowledge structure.
@GUID("14B2274A-8698-4CC6-9333-F89BD1D47BC4")
interface IClockVector : IUnknown
{
    ///Returns an enumerator that iterates through the clock vector elements.
    ///Params:
    ///    riid = The IID of the enumeration interface that is requested. Must be either <b>IID_IEnumClockVector</b> or
    ///           <b>IID_IEnumFeedClockVector</b>.
    ///    ppiEnumClockVector = Returns an object that implements <i>riid</i> and that can enumerate the clock vector elements.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"> <i>riid</i> is not <b>IID_IEnumClockVector</b> or
    ///    <b>IID_IEnumFeedClockVector</b>. </td> </tr> </table>
    ///    
    HRESULT GetClockVectorElements(const(GUID)* riid, void** ppiEnumClockVector);
    ///Gets the number of elements that are contained in the clock vector.
    ///Params:
    ///    pdwCount = Returns the number of elements that are contained in the clock vector.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetClockVectorElementCount(uint* pdwCount);
}

///Represents a clock vector that contains FeedSync information.
@GUID("8D1D98D1-9FB8-4EC9-A553-54DD924E0F67")
interface IFeedClockVector : IClockVector
{
    ///Gets the number of updates that have been made to the FeedSync item.
    ///Params:
    ///    pdwUpdateCount = Returns the number of updates that have been made to the FeedSync item. This value corresponds to the
    ///                     <b>updates</b> attribute of the FeedSync item.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetUpdateCount(uint* pdwUpdateCount);
    ///Gets a value that indicates whether conflicts are preserved for the FeedSync item.
    ///Params:
    ///    pfIsNoConflictsSpecified = TRUE if conflicts are not preserved for the item; otherwise, <b>FALSE</b>. This value corresponds to the
    ///                               <b>noconflicts</b> attribute of the FeedSync item.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT IsNoConflictsSpecified(int* pfIsNoConflictsSpecified);
}

///Enumerates the clock vector elements that are stored in a clock vector.
@GUID("525844DB-2837-4799-9E80-81A66E02220C")
interface IEnumClockVector : IUnknown
{
    ///Returns the next elements in the clock vector, if they are available.
    ///Params:
    ///    cClockVectorElements = The number of clock vector elements to retrieve in the range of zero to 1000.
    ///    ppiClockVectorElements = Returns the next <i>pcFetched</i> clock vector elements.
    ///    pcFetched = Returns the number of clock vector elements that were retrieved. This value can be <b>NULL</b> if
    ///                <i>cClockVectorElements</i> is 1; otherwise, it cannot be <b>NULL</b>.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> If there are no more elements to retrieve. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT Next(uint cClockVectorElements, IClockVectorElement* ppiClockVectorElements, uint* pcFetched);
    ///Skips the specified number of clock vector elements.
    ///Params:
    ///    cSyncVersions = The number of elements to skip.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> The enumerator reaches the end of its list before it skips <i>cSyncVersions</i>.
    ///    In this case, the enumerator skips as many elements as possible. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT Skip(uint cSyncVersions);
    ///Resets the enumerator to the beginning of the clock vector.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Reset();
    ///Clones the enumerator and returns a new enumerator that is in the same state as the current one.
    ///Params:
    ///    ppiEnum = Returns the newly cloned enumerator.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT Clone(IEnumClockVector* ppiEnum);
}

///Enumerates the clock vector elements that are stored in a clock vector that contains FeedSync information.
@GUID("550F763D-146A-48F6-ABEB-6C88C7F70514")
interface IEnumFeedClockVector : IUnknown
{
    ///Returns the next elements in the clock vector, if available.
    ///Params:
    ///    cClockVectorElements = The number of clock vector elements to retrieve.
    ///    ppiClockVectorElements = Returns the next <i>pcFetched</i> clock vector elements.
    ///    pcFetched = Returns the number of clock vector elements that were retrieved. This value can be <b>NULL</b> if
    ///                <i>cClockVectorElements</i> is 1; otherwise, it cannot be <b>NULL</b>.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> If there are no more elements to retrieve. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT Next(uint cClockVectorElements, IFeedClockVectorElement* ppiClockVectorElements, uint* pcFetched);
    ///Skips the specified number of clock vector elements.
    ///Params:
    ///    cSyncVersions = The number of elements to skip.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> The enumerator reaches the end of its list before it can skip
    ///    <i>cSyncVersions</i> elements. In this case, the enumerator skips as many elements as possible. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT Skip(uint cSyncVersions);
    ///Resets the enumerator to the beginning of the clock vector.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Reset();
    ///Clones the enumerator and returns a new enumerator that is in the same state as the current one.
    ///Params:
    ///    ppiEnum = Returns the newly cloned enumerator.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT Clone(IEnumFeedClockVector* ppiEnum);
}

///Represents knowledge of all items in the scope for a specific set of change units.
@GUID("613B2AB5-B304-47D9-9C31-CE6C54401A15")
interface ICoreFragment : IUnknown
{
    ///Returns the next change unit ID in the set of change unit IDs that this knowledge fragment applies to.
    ///Params:
    ///    pChangeUnitId = Returns the next change unit ID in the set.
    ///    pChangeUnitIdSize = Specifies the number of bytes in <i>pChangeUnitId</i>. Returns the number of bytes written, or the number of
    ///                        bytes that are required to retrieve the ID when <i>pChangeUnitId</i> is too small.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> There are no more change unit IDs to enumerate. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The change unit ID is a
    ///    variable-length ID and <i>pChangeUnitIdSize</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt> </dl> </td> <td width="60%"> <i>pChangeUnitId</i> is too
    ///    small. In this situation, the required number of bytes is returned in <i>pChangeUnitIdSize</i>. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>SYNC_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The
    ///    knowledge object contained within this object has changed since this object was created. </td> </tr> </table>
    ///    
    HRESULT NextColumn(ubyte* pChangeUnitId, uint* pChangeUnitIdSize);
    ///Returns the next range that is contained in this knowledge fragment, and the clock vector that defines what is
    ///known about the items in the range.
    ///Params:
    ///    pItemId = Returns the closed lower bound of item IDs in this range. This value is also the open upper bound of item IDs
    ///              in the previous range when it is not the first in the range set.
    ///    pItemIdSize = Specifies the number of bytes in <i>pItemId</i>. Returns the number of bytes written, or the number of bytes
    ///                  that are required to retrieve the ID when <i>pItemId</i> is too small.
    ///    piClockVector = Returns the clock vector that defines what is known about the items in the range.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> There are no more ranges to enumerate. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The item ID is a variable-length ID and
    ///    <i>pItemIdSize</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt> </dl> </td> <td width="60%"> <i>pItemId</i> is too small.
    ///    In this situation, the required number of bytes is returned in <i>pItemIdSize</i>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>SYNC_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The knowledge object
    ///    that is contained in this object has changed since this object was created. </td> </tr> </table>
    ///    
    HRESULT NextRange(ubyte* pItemId, uint* pItemIdSize, IClockVector* piClockVector);
    ///Resets both the column and range enumerators to the beginning of their respective sets.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The knowledge object contained in this
    ///    object has changed since this object was created. </td> </tr> </table>
    ///    
    HRESULT Reset();
    ///Gets the number of columns that are contained in this knowledge fragment.
    ///Params:
    ///    pColumnCount = Returns the number of columns that are contained in this knowledge fragment.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetColumnCount(uint* pColumnCount);
    ///Gets the number of ranges that are contained in this knowledge fragment.
    ///Params:
    ///    pRangeCount = Returns the number of ranges that are contained in this knowledge fragment.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetRangeCount(uint* pRangeCount);
}

///Enumerates the <b>ICoreFragment</b> objects that are contained in a knowledge object.
@GUID("F7FCC5FD-AE26-4679-BA16-96AAC583C134")
interface ICoreFragmentInspector : IUnknown
{
    ///Returns the next <b>ICoreFragment</b> objects in the knowledge, if they are available.
    ///Params:
    ///    requestedCount = The number of <b>ICoreFragment</b> objects to retrieve.
    ///    ppiCoreFragments = Receives a pointer to the next <i>pFetchedCount</i> <b>ICoreFragment</b> objects. The size of the array is
    ///                       the value specified in the <i>requestedCount</i> parameter. The length is <code>*(pFetchedCount)</code>. The
    ///                       caller must release the interface pointer.
    ///    pFetchedCount = Receives the number of <b>ICoreFragment</b> objects that were retrieved in the <i>ppiCoreFragments</i>
    ///                    parameter. This value can be <b>NULL</b> only if <i> requestedCount</i> is 1.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> There are no more <b>ICoreFragment</b> objects to retrieve, or the number of
    ///    <b>ICoreFragment</b> objects retrieved is less than <i>requestedCount</i>. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>SYNC_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The knowledge object
    ///    contained in this object has changed since this object was created. </td> </tr> </table>
    ///    
    HRESULT NextCoreFragments(uint requestedCount, ICoreFragment* ppiCoreFragments, uint* pFetchedCount);
    ///Resets the enumerator to the beginning of the knowledge.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The knowledge object that is associated
    ///    with this object has changed since this object was created. </td> </tr> </table>
    ///    
    HRESULT Reset();
}

///Represents an item ID range to exclude from a knowledge object.
@GUID("75AE8777-6848-49F7-956C-A3A92F5096E8")
interface IRangeException : IUnknown
{
    ///Gets the lower bound of the range of item IDs to exclude.
    ///Params:
    ///    pbClosedRangeStart = Returns the lower bound of the range of item IDs to exclude.
    ///    pcbIdSize = Specifies the number of bytes in <i>pbClosedRangeStart</i>. Returns the number of bytes to retrieve the ID
    ///                when <i>pbClosedRangeStart</i> is too small, or returns the number of bytes written.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt> </dl> </td> <td width="60%">
    ///    When<i>pbClosedRangeStart</i> is too small. In this case, the required number of bytes is returned in
    ///    <i>pcbIdSize</i>. </td> </tr> </table>
    ///    
    HRESULT GetClosedRangeStart(ubyte* pbClosedRangeStart, uint* pcbIdSize);
    ///Gets the upper bound of the range of item IDs to exclude.
    ///Params:
    ///    pbClosedRangeEnd = Returns the upper bound of the range of item IDs to exclude.
    ///    pcbIdSize = Specifies the number of bytes in <i>pbClosedRangeEnd</i>. Returns the number of bytes required to retrieve
    ///                the ID when <i>pbClosedRangeEnd</i> is too small, or returns the number of bytes written.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt> </dl> </td> <td width="60%"> <i>pbClosedRangeEnd</i> is
    ///    too small. In this case, the required number of bytes is returned in <i>pcbIdSize</i>. </td> </tr> </table>
    ///    
    HRESULT GetClosedRangeEnd(ubyte* pbClosedRangeEnd, uint* pcbIdSize);
    ///Gets the clock vector that is associated with this exception.
    ///Params:
    ///    riid = The IID of the object to retrieve. Must be <b>IID_IEnumClockVector</b>.
    ///    ppUnk = Returns an object that implements <i>riid</i> and represents the clock vector that is associated with this
    ///            exception.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT GetClockVector(const(GUID)* riid, void** ppUnk);
}

///Enumerates range exceptions that are stored in a knowledge object.
@GUID("0944439F-DDB1-4176-B703-046FF22A2386")
interface IEnumRangeExceptions : IUnknown
{
    ///Returns the next elements in the change unit exception set, if they are available.
    ///Params:
    ///    cExceptions = The number of range exception elements to retrieve in the range from zero to 1000.
    ///    ppRangeException = Returns the next <i>pcFetched</i> range exceptions.
    ///    pcFetched = Returns the number of range exceptions returned. This value can be <b>NULL</b> only if <i>cExceptions</i> is
    ///                1.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> There are no more elements to retrieve. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT Next(uint cExceptions, IRangeException* ppRangeException, uint* pcFetched);
    ///Skips the specified number of range exceptions.
    ///Params:
    ///    cExceptions = The number of range exceptions to skip.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> The enumerator reaches the end of the list before it can skip <i>cExceptions</i>
    ///    range exceptions. In this case, the enumerator skips as many elements as possible. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARGS</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT Skip(uint cExceptions);
    ///Resets the enumerator to the beginning of the range exception set.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Reset();
    ///Clones the enumerator and returns a new enumerator that is in the same state as the current one.
    ///Params:
    ///    ppEnum = Returns the newly cloned enumerator.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT Clone(IEnumRangeExceptions* ppEnum);
}

///Represents an item to exclude from a knowledge object.
@GUID("892FB9B0-7C55-4A18-9316-FDF449569B64")
interface ISingleItemException : IUnknown
{
    ///Gets the ID of the item that is specified in the exception.
    ///Params:
    ///    pbItemId = Returns the ID of the item that is specified in the exception.
    ///    pcbIdSize = Specifies the number of bytes in <i>pbItemId</i>. Returns the number of bytes required to retrieve the ID
    ///                when <i>pbItemId</i> is too small, or returns the number of bytes written.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG
    ///    </b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt> </dl> </td> <td width="60%"> <i>pbItemId</i> is too
    ///    small. In this case, the required number of bytes is returned in <i>pcbIdSize</i>. </td> </tr> </table>
    ///    
    HRESULT GetItemId(ubyte* pbItemId, uint* pcbIdSize);
    ///Gets the clock vector that is associated with the item exception.
    ///Params:
    ///    riid = The IID of the object to retrieve. Must be <b>IID_IEnumClockVector</b>.
    ///    ppUnk = Returns an object that implements <i>riid</i> and represents the clock vector that is associated with this
    ///            exception.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG
    ///    </b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT GetClockVector(const(GUID)* riid, void** ppUnk);
}

///Enumerates single-item exceptions that are stored in a knowledge object.
@GUID("E563381C-1B4D-4C66-9796-C86FACCDCD40")
interface IEnumSingleItemExceptions : IUnknown
{
    ///Returns the next elements in the single-item exception set, if they are available.
    ///Params:
    ///    cExceptions = The number of single-item exceptions to retrieve in the range from zero to 1000.
    ///    ppSingleItemException = Returns the next <i>pcFetched</i> single-item exceptions.
    ///    pcFetched = Returns the number of single-item exceptions returned. This value can be <b>NULL</b> only if
    ///                <i>cExceptions</i> is 1.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> There are no more single-item exceptions to retrieve. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT Next(uint cExceptions, ISingleItemException* ppSingleItemException, uint* pcFetched);
    ///Skips the specified number of single-item exceptions.
    ///Params:
    ///    cExceptions = The number of single-item exceptions to skip.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> The enumerator reaches the end of the list before it can skip <i>cExceptions</i>
    ///    single-item exceptions. In this case, the enumerator skips as many elements as possible. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT Skip(uint cExceptions);
    ///Resets the enumerator to the beginning of the single-item exception set.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Reset();
    ///Clones the enumerator and returns a new enumerator that is in the same state as the current one.
    ///Params:
    ///    ppEnum = Returns the newly cloned enumerator.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT Clone(IEnumSingleItemExceptions* ppEnum);
}

///Represents a change unit to exclude from a knowledge object.
@GUID("0CD7EE7C-FEC0-4021-99EE-F0E5348F2A5F")
interface IChangeUnitException : IUnknown
{
    ///Gets the item ID for the item that contains the change unit that is associated with the exception.
    ///Params:
    ///    pbItemId = Returns the item ID that contains the change unit that is associated with the exception.
    ///    pcbIdSize = Specifies the number of bytes in <i>pbItemId</i>. Returns the number of bytes required to retrieve the ID
    ///                when <i>pbItemId</i> is too small, or the number of bytes written.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt> </dl> </td> <td width="60%"> <i>pbItemId</i> is too
    ///    small. In this case, the required number of bytes is returned in <i>pcbIdSize</i>. </td> </tr> </table>
    ///    
    HRESULT GetItemId(ubyte* pbItemId, uint* pcbIdSize);
    ///Gets the change unit ID for the change unit that is associated with the exception.
    ///Params:
    ///    pbChangeUnitId = Returns the change unit ID that is associated with the exception.
    ///    pcbIdSize = Specifies the number of bytes in <i>pbChangeUnitId</i>. Returns the number of bytes required to retrieve the
    ///                ID when <i>pbChangeUnitId</i> is too small, or the number of bytes written.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pbChangeUnitId</i> is null. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt> </dl> </td> <td width="60%">
    ///    <i>pbChangeUnitId</i> is too small. In this case, the required number of bytes is returned in
    ///    <i>pcbIdSize</i>. </td> </tr> </table>
    ///    
    HRESULT GetChangeUnitId(ubyte* pbChangeUnitId, uint* pcbIdSize);
    ///Gets the clock vector that is associated with this exception.
    ///Params:
    ///    riid = The IID of the object to retrieve. Must be <b>IID_IEnumClockVector</b>.
    ///    ppUnk = Returns an object that implements <i>riid</i> and that represents the clock vector that is associated with
    ///            this exception.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT GetClockVector(const(GUID)* riid, void** ppUnk);
}

///Enumerates change unit exceptions that are stored in a knowledge object.
@GUID("3074E802-9319-4420-BE21-1022E2E21DA8")
interface IEnumChangeUnitExceptions : IUnknown
{
    ///Returns the next elements in the change unit exception set, if they are available.
    ///Params:
    ///    cExceptions = The number of change unit exceptions to retrieve in the range of zero to 1000.
    ///    ppChangeUnitException = Returns the next <i>pcFetched</i> change unit exceptions.
    ///    pcFetched = Returns the number of change unit exceptions that are retrieved. This value can be <b>NULL</b> only if
    ///                <i>cExceptions</i> is 1.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> If there are no more change unit exceptions to retrieve. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT Next(uint cExceptions, IChangeUnitException* ppChangeUnitException, uint* pcFetched);
    ///Skips the specified number of change unit exceptions.
    ///Params:
    ///    cExceptions = The number of change unit exceptions to skip.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> The enumerator reaches the end of the list before it can skip the specified
    ///    number of change unit exceptions. In this case, the enumerator skips as many elements as possible. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr>
    ///    </table>
    ///    
    HRESULT Skip(uint cExceptions);
    ///Resets the enumerator to the beginning of the change unit exception set.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Reset();
    ///Clones the enumerator and returns a new enumerator that is in the same state as the current one.
    ///Params:
    ///    ppEnum = Returns the newly cloned enumerator.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT Clone(IEnumChangeUnitExceptions* ppEnum);
}

///Represents a mapping between replica keys and replica IDs.
@GUID("2209F4FC-FD10-4FF0-84A8-F0A1982E440E")
interface IReplicaKeyMap : IUnknown
{
    ///Gets the replica key that corresponds to the specified replica ID.
    ///Params:
    ///    pbReplicaId = The replica ID to look up.
    ///    pdwReplicaKey = Returns the replica key that corresponds to <i>pbReplicaId</i>.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl> <dt><b>SYNC_E_ID_FORMAT_MISMATCH</b></dt>
    ///    </dl> </td> <td width="60%"> When <i>pbReplicaId</i> is not in the format that is specified by the ID format
    ///    schema of the provider. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SYNC_E_REPLICA_NOT_FOUND</b></dt> </dl>
    ///    </td> <td width="60%"> When <i>pbReplicaId</i> is not found. </td> </tr> </table>
    ///    
    HRESULT LookupReplicaKey(const(ubyte)* pbReplicaId, uint* pdwReplicaKey);
    ///Gets the replica ID that corresponds to the specified replica key.
    ///Params:
    ///    dwReplicaKey = The replica key to look up.
    ///    pbReplicaId = Returns the replica ID that corresponds to <i>dwReplicaKey</i>.
    ///    pcbIdSize = Specifies the number of bytes in <i>pbReplicaId</i>. Returns the number of bytes required to retrieve the ID
    ///                when <i>pbReplicaId</i> is too small, or returns the number of bytes written.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_REPLICA_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> <i>dwReplicaKey</i> is not found. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt> </dl> </td> <td
    ///    width="60%"> <i>pbReplicaId</i> is too small. In this case, the required number of bytes is returned in
    ///    <i>pcbIdSize</i>. </td> </tr> </table>
    ///    
    HRESULT LookupReplicaId(uint dwReplicaKey, ubyte* pbReplicaId, uint* pcbIdSize);
    ///Serializes the replica key map data to a byte array.
    ///Params:
    ///    pbReplicaKeyMap = The byte array that receives the serialized data.
    ///    pcbReplicaKeyMap = Specifies the number of bytes in <i>pbReplicaKeyMap</i>. Returns the number of bytes required to serialize
    ///                       the replica key map data when <i>pbReplicaKeyMap</i> is too small, or returns the number of bytes written.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A replica ID or replica key stored in the map is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"></td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt> </dl>
    ///    </td> <td width="60%"> <i>pbReplicaKeyMap</i> is too small. In this case, the required number of bytes is
    ///    returned in <i>pcbReplicaKeyMap</i>. </td> </tr> </table>
    ///    
    HRESULT Serialize(ubyte* pbReplicaKeyMap, uint* pcbReplicaKeyMap);
}

///Adds entries to an <b>IReplicaKeyMap</b> object.
@GUID("DED10970-EC85-4115-B52C-4405845642A5")
interface IConstructReplicaKeyMap : IUnknown
{
    ///Adds entries to or finds entries in an <b>IReplicaKeyMap</b> object.
    ///Params:
    ///    pbReplicaId = The ID of the replica to add or find.
    ///    pdwReplicaKey = The key of the replica in the map. If an entry for <i>pbReplicaId</i> does not exist in the map, an entry is
    ///                    created and a new key is assigned to it.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_ID_FORMAT_MISMATCH</b></dt> </dl> </td> <td width="60%"> <i>pbReplicaId</i> is not of the
    ///    format that the provider specified. </td> </tr> </table>
    ///    
    HRESULT FindOrAddReplica(const(ubyte)* pbReplicaId, uint* pdwReplicaKey);
}

///Represents knowledge that a replica has about its item store.
@GUID("615BBB53-C945-4203-BF4B-2CB65919A0AA")
interface ISyncKnowledge : IUnknown
{
    ///Gets the ID of the replica that owns this knowledge.
    ///Params:
    ///    pbReplicaId = Returns the ID of the replica that owns this knowledge.
    ///    pcbIdSize = Specifies the number of bytes in <i>pbReplicaId</i>. Returns the number of bytes required to retrieve the ID
    ///                when <i>pbReplicaId</i> is too small, or returns the number of bytes written.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt> </dl> </td> <td width="60%"> <i>pbReplicaId</i> is too
    ///    small. In this case, the required number of bytes is returned in <i>pcbIdSize</i>. </td> </tr> </table>
    ///    
    HRESULT GetOwnerReplicaId(ubyte* pbReplicaId, uint* pcbIdSize);
    ///Serializes the knowledge object data to a byte array.
    ///Params:
    ///    fSerializeReplicaKeyMap = <b>TRUE</b> to serialize the <b>IReplicaKeyMap</b> object that is contained in the knowledge; otherwise,
    ///                              <b>FALSE</b>.
    ///    pbKnowledge = The byte array that receives the serialized knowledge data.
    ///    pcbKnowledge = Specifies the number of bytes in <i>pbKnowledge</i>. Returns the number of bytes required to serialize the
    ///                   replica key map data when <i>pbKnowledge</i> is too small, or returns the number of bytes written.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt> </dl> </td> <td width="60%"> <i>pbKnowledge</i> is too
    ///    small. In this case, the required number of bytes is returned in <i>pbKnowledge</i>. </td> </tr> </table>
    ///    
    HRESULT Serialize(BOOL fSerializeReplicaKeyMap, ubyte* pbKnowledge, uint* pcbKnowledge);
    ///Sets the tick count for the replica that owns this knowledge.
    ///Params:
    ///    ullTickCount = The current tick count for the replica that owns this knowledge.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT SetLocalTickCount(ulong ullTickCount);
    ///Indicates whether the specified item change is known by this knowledge.
    ///Params:
    ///    pbVersionOwnerReplicaId = The ID of the replica that originated the change.
    ///    pgidItemId = The ID of the item that changed.
    ///    pSyncVersion = The version of the change.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> The specified change is not contained in the knowledge. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT ContainsChange(const(ubyte)* pbVersionOwnerReplicaId, const(ubyte)* pgidItemId, 
                           const(SYNC_VERSION)* pSyncVersion);
    ///Indicates whether the specified change unit change is known by this knowledge.
    ///Params:
    ///    pbVersionOwnerReplicaId = The ID of the replica that originated the change unit change.
    ///    pbItemId = The ID of the item that contains the change unit to look up.
    ///    pbChangeUnitId = The ID of the change unit to look up.
    ///    pSyncVersion = The version of the change unit change to look up.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The specified change unit change is contained in the knowledge. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The specified change unit change is
    ///    not contained in the knowledge. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT ContainsChangeUnit(const(ubyte)* pbVersionOwnerReplicaId, const(ubyte)* pbItemId, 
                               const(ubyte)* pbChangeUnitId, const(SYNC_VERSION)* pSyncVersion);
    ///Gets the clock vector that defines the changes that are contained in the knowledge.
    ///Params:
    ///    riid = The IID of the object to retrieve. Must be <b>IID_IClockVector</b>.
    ///    ppUnk = Returns an object that implements <i>riid</i> and that represents the clock vector that defines the changes
    ///            that are contained in the knowledge.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT GetScopeVector(const(GUID)* riid, void** ppUnk);
    ///Gets the <b>IReplicaKeyMap</b> object that is associated with this knowledge.
    ///Params:
    ///    ppReplicaKeyMap = Returns the <b>IReplicaKeyMap</b> object that is associated with this knowledge.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT GetReplicaKeyMap(IReplicaKeyMap* ppReplicaKeyMap);
    ///Creates a new instance of this object, and copies the data from this object to the new object.
    ///Params:
    ///    ppClonedKnowledge = Returns the newly created knowledge object.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT Clone(ISyncKnowledge* ppClonedKnowledge);
    ///Converts a version from another replica into one that is compatible with the replica that owns this knowledge.
    ///Params:
    ///    pKnowledgeIn = A knowledge that is valid for <i>pbCurrentOwnerId</i> and that contains <i>pVersionIn</i>.
    ///    pbCurrentOwnerId = The ID of the replica that owns <i>pVersionIn</i>.
    ///    pVersionIn = The version to convert.
    ///    pbNewOwnerId = Returns the ID of the replica that owns the converted version.
    ///    pcbIdSize = Specifies the number of bytes in <i>pbNewOwnerId</i>. Returns the number of bytes required to retrieve the ID
    ///                when <i>pbNewOwnerId</i> is too small, or returns the number of bytes written.
    ///    pVersionOut = Returns the version. This is converted to be valid for the replica that owns this knowledge.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt> </dl> </td> <td width="60%"> <i>pbNewOwnerId</i> is too
    ///    small. In this case, the required number of bytes is returned in <i>pcbIdSize</i>. </td> </tr> </table>
    ///    
    HRESULT ConvertVersion(ISyncKnowledge pKnowledgeIn, const(ubyte)* pbCurrentOwnerId, 
                           const(SYNC_VERSION)* pVersionIn, ubyte* pbNewOwnerId, uint* pcbIdSize, 
                           SYNC_VERSION* pVersionOut);
    ///Converts a knowledge object from another replica into one that is compatible with the replica that owns this
    ///knowledge.
    ///Params:
    ///    pRemoteKnowledge = A knowledge object that is owned by another replica.
    ///    ppMappedKnowledge = Returns the knowledge object, converted for use by the replica that owns this knowledge.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT MapRemoteToLocal(ISyncKnowledge pRemoteKnowledge, ISyncKnowledge* ppMappedKnowledge);
    ///Combines the specified knowledge with the current knowledge.
    ///Params:
    ///    pKnowledge = The knowledge to combine with the current knowledge.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT Union(ISyncKnowledge pKnowledge);
    ///Gets the knowledge for the specified item.
    ///Params:
    ///    pbItemId = The ID of the item to look up.
    ///    ppKnowledgeOut = Returns a knowledge object that contains only the item specified by <i>pbItemId</i>.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT ProjectOntoItem(const(ubyte)* pbItemId, ISyncKnowledge* ppKnowledgeOut);
    ///Gets the knowledge for the specified change unit.
    ///Params:
    ///    pbItemId = The ID of the item that contains the change unit to look up.
    ///    pbChangeUnitId = The ID of the change unit to look up.
    ///    ppKnowledgeOut = Returns a knowledge object that contains only the change unit specified by <i>pbChangeUnitId</i>.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT ProjectOntoChangeUnit(const(ubyte)* pbItemId, const(ubyte)* pbChangeUnitId, 
                                  ISyncKnowledge* ppKnowledgeOut);
    ///Gets the knowledge for the specified range of item IDs.
    ///Params:
    ///    psrngSyncRange = The range of item IDs to look up.
    ///    ppKnowledgeOut = Returns a knowledge object that contains only the range of item IDs specified by <i>psrngSyncRange</i>.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT ProjectOntoRange(const(SYNC_RANGE)* psrngSyncRange, ISyncKnowledge* ppKnowledgeOut);
    ///Removes knowledge about the specified item from the knowledge.
    ///Params:
    ///    pbItemId = The ID of the item to remove from the knowledge.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT ExcludeItem(const(ubyte)* pbItemId);
    ///Removes knowledge about the specified change unit from the knowledge.
    ///Params:
    ///    pbItemId = The ID of the item that contains the change unit to exclude from the knowledge.
    ///    pbChangeUnitId = The ID of the change unit to exclude from the knowledge.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT ExcludeChangeUnit(const(ubyte)* pbItemId, const(ubyte)* pbChangeUnitId);
    ///Indicates whether the specified knowledge is known by this knowledge.
    ///Params:
    ///    pKnowledge = The knowledge to look up.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> <i>pSyncKnowledge</i> is known. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> <i>pSyncKnowledge</i> is not known. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT ContainsKnowledge(ISyncKnowledge pKnowledge);
    ///Finds the minimum tick count in the knowledge for the specified replica.
    ///Params:
    ///    pbReplicaId = The ID of the replica to look up.
    ///    pullReplicaTickCount = Returns the minimum tick count in the knowledge for <i>pbReplicaId</i>.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT FindMinTickCountForReplica(const(ubyte)* pbReplicaId, ulong* pullReplicaTickCount);
    ///Gets an object that can enumerate the <b>IRangeException</b> objects that are stored in the knowledge.
    ///Params:
    ///    riid = The IID of the object to retrieve. Must be <b>IID_IEnumRangeExceptions</b>.
    ///    ppUnk = Returns an object that implements <i>riid</i> and that can enumerate the list of <b>IRangeException</b>
    ///            objects that is contained in the knowledge.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT GetRangeExceptions(const(GUID)* riid, void** ppUnk);
    ///Gets an object that can enumerate the <b>ISingleItemException</b> objects that are stored in the knowledge.
    ///Params:
    ///    riid = The IID of the object to retrieve. Must be <b>IID_IEnumSingleItemExceptions</b>.
    ///    ppUnk = Returns an object that implements <i>riid</i> and that can enumerate the list of <b>ISingleItemException</b>
    ///            objects that is contained in the knowledge.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT GetSingleItemExceptions(const(GUID)* riid, void** ppUnk);
    ///Gets an object that can enumerate the <b>IChangeUnitException</b> objects that are stored in the knowledge.
    ///Params:
    ///    riid = The IID of the object to retrieve. Must be <b>IID_IEnumChangeUnitExceptions</b>.
    ///    ppUnk = Returns an object that implements <i>riid</i> and that can enumerate the list of <b>IChangeUnitException</b>
    ///            objects that is contained in the knowledge.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT GetChangeUnitExceptions(const(GUID)* riid, void** ppUnk);
    ///Gets the clock vector that is associated with the specified item ID.
    ///Params:
    ///    pbItemId = The ID of the item that is associated with the clock vector to find.
    ///    riid = The IID of the object to retrieve. Must be <b>IID_IFeedClockVector</b> or <b>IID_IClockVector</b>.
    ///    ppUnk = Returns an object that implements <i>riid</i> and that represents the clock vector associated with
    ///            <i>pbItemId</i>.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT FindClockVectorForItem(const(ubyte)* pbItemId, const(GUID)* riid, void** ppUnk);
    ///Gets the clock vector that is associated with the specified change unit ID.
    ///Params:
    ///    pbItemId = The ID of the item that contains the change unit that is associated with the clock vector to retrieve.
    ///    pbChangeUnitId = The ID of the change unit that is associated with the clock vector to retrieve.
    ///    riid = The IID of the object to retrieve. Must be <b>IID_IEnumClockVector</b>.
    ///    ppUnk = Returns an object that implements <i>riid</i> and that can enumerate the list of IClockVector objects that is
    ///            associated with <i>pbChangeUnitId</i>.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT FindClockVectorForChangeUnit(const(ubyte)* pbItemId, const(ubyte)* pbChangeUnitId, const(GUID)* riid, 
                                         void** ppUnk);
    ///Gets the version of this knowledge structure.
    ///Params:
    ///    pdwVersion = Returns the version of this knowledge structure. is one of the values in the SYNC_SERIALIZATION_VERSION
    ///                 enumeration.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetVersion(uint* pdwVersion);
}

///Represents knowledge that has been forgotten because of tombstone cleanup.
@GUID("456E0F96-6036-452B-9F9D-BCC4B4A85DB2")
interface IForgottenKnowledge : ISyncKnowledge
{
    ///Updates the forgotten knowledge to reflect that all versions that are less than or equal to the specified version
    ///might have been forgotten, and that corresponding tombstones might have been deleted.
    ///Params:
    ///    pKnowledge = The current knowledge of the replica that owns this forgotten knowledge object.
    ///    pVersion = The version of the tombstone that has been cleaned up.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT ForgetToVersion(ISyncKnowledge pKnowledge, const(SYNC_VERSION)* pVersion);
}

///Represents additional information about the knowledge that a replica has about its item store.
@GUID("ED0ADDC0-3B4B-46A1-9A45-45661D2114C8")
interface ISyncKnowledge2 : ISyncKnowledge
{
    ///Gets the ID format schema of the provider.
    ///Params:
    ///    pIdParameters = The ID format schema of the provider.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>dwSize</i> member of <i>pIdParameters</i> is
    ///    not equal to <code>sizeof(ID_PARAMETERS)</code>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetIdParameters(ID_PARAMETERS* pIdParameters);
    ///Returns the knowledge for the specified set of change units for all the items that are contained in this object.
    ///Params:
    ///    ppColumns = The set of change unit IDs to look up.
    ///    count = The number of change unit IDs that are contained in <i>ppColumns</i>.
    ///    ppiKnowledgeOut = A knowledge object that contains only the change units that are specified by <i>ppColumns</i> for all items
    ///                      contained in this object.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>count</i> is zero. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>SYNC_E_ID_FORMAT_MISMATCH</b></dt> </dl> </td> <td width="60%"> The format of
    ///    the change unit IDs that is contained in <i>ppColumns</i> is not of the format that the format schema of the
    ///    provider specified. </td> </tr> </table>
    ///    
    HRESULT ProjectOntoColumnSet(const(ubyte)** ppColumns, uint count, ISyncKnowledge2* ppiKnowledgeOut);
    ///Serializes the knowledge object data to a byte array based on the specified version and serialization options.
    ///Params:
    ///    targetFormatVersion = The serialized knowledge is compatible with this version.
    ///    dwFlags = Options that specify additional information about how to serialize the object. Must be zero or a combination
    ///              of the values specified by the <b>SYNC_SERIALIZE</b> flags (see Remarks). When zero is specified, the replica
    ///              key map is not included as part of the serialized knowledge data.
    ///    pbBuffer = The serialized knowledge object data is serialized to this buffer.
    ///    pdwSerializedSize = Specifies the number of bytes in <i>pBuffer</i>. Returns either the number of bytes that are required to
    ///                        serialize the knowledge data when <i>pBuffer</i> is too small, or the number of bytes written.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt> </dl> </td> <td width="60%"> <i>pBuffer</i> is too small.
    ///    In this situation, the required number of bytes is returned in <i>pdwSerializedSize</i>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>SYNC_E_INVALID_VERSION</b></dt> </dl> </td> <td width="60%"> The value of
    ///    <i>targetFormatVersion</i> is higher than the version of the object, or the object contains elements that are
    ///    not compatible with <i>targetFormatVersion</i>. </td> </tr> </table>
    ///    
    HRESULT SerializeWithOptions(SYNC_SERIALIZATION_VERSION targetFormatVersion, uint dwFlags, ubyte* pbBuffer, 
                                 uint* pdwSerializedSize);
    ///Returns the lowest item ID that is not contained in this knowledge and that is contained in the specified
    ///knowledge.
    ///Params:
    ///    piSyncKnowledge = The item ID that is returned in <i>pbItemId</i> is contained in <i>piSyncKnowledge</i>.
    ///    pbItemId = The lowest item ID that is contained in <i>piSyncKnowledge</i> and is not contained in this knowledge.
    ///    pcbItemIdSize = The number of bytes in <i>pbItemId</i>. Returns either the number of bytes that are required to retrieve the
    ///                    ID when <i>pbItemId</i> is too small, or the number of bytes written.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> <i>piSyncKnowledge</i> is contained in this knowledge. In this situation, there
    ///    is no uncontained item ID to return. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
    ///    </dl> </td> <td width="60%"> The ID format schema of <i>piSyncKnowledge</i> is not the same as the ID format
    ///    schema of this knowledge. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt> </dl> </td> <td width="60%"> <i>pbItemId</i> is too
    ///    small. In this situation, the required number of bytes is returned in <i>pcbItemIdSize</i>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetLowestUncontainedId(ISyncKnowledge2 piSyncKnowledge, ubyte* pbItemId, uint* pcbItemIdSize);
    ///Returns an object that can be used to retrieve the contents of the knowledge object.
    ///Params:
    ///    riid = The IID of the requested inspector. Must be <b>IID_ICoreFragmentInspector</b>.
    ///    ppiInspector = An object that implements <i>riid</i>, and that can retrieve the contents of the knowledge object.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"> <i>riid</i> is not
    ///    <b>IID_ICoreFragmentInspector</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetInspector(const(GUID)* riid, void** ppiInspector);
    ///Gets the minimum supported version of Microsoft Sync Framework components that can be used with this object.
    ///Params:
    ///    pVersion = The minimum supported version of Microsoft Sync Framework components that can be used with this object.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetMinimumSupportedVersion(SYNC_SERIALIZATION_VERSION* pVersion);
    ///Gets the specified statistic data that is contained in this object.
    ///Params:
    ///    which = Specifies which statistic to retrieve.
    ///    pValue = The specified statistic data.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>which</i> is not a member of the
    ///    <b>SYNC_STATISTICS</b> enumeration. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetStatistics(SYNC_STATISTICS which, uint* pValue);
    ///Indicates whether the specified knowledge of the specified item is known by this knowledge.
    ///Params:
    ///    pKnowledge = The knowledge object that contains knowledge about <i>pbItemId</i>.
    ///    pbItemId = The ID of the item to look up.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> This object contains the knowledge known by <i>pKnowledge</i> about <i>pbItemId</i>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> This object does
    ///    not contain the knowledge known by <i>pKnowledge</i> about <i>pbItemId</i>. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER </b></dt> </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>SYNC_E_ID_FORMAT_MISMATCH</b></dt> </dl> </td> <td width="60%"> <i>pbItemId</i> is
    ///    not of the format specified by the provider. </td> </tr> </table>
    ///    
    HRESULT ContainsKnowledgeForItem(ISyncKnowledge pKnowledge, const(ubyte)* pbItemId);
    ///Indicates whether the specified knowledge of the specified change unit is known by this knowledge.
    ///Params:
    ///    pKnowledge = The knowledge object that contains knowledge about <i>pbChangeUnitId</i>.
    ///    pbItemId = The ID of the item that contains the change unit to look up.
    ///    pbChangeUnitId = The ID of the change unit to look up.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> This object contains the knowledge known by <i>pKnowledge</i> about
    ///    <i>pbChangeUnitId</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td
    ///    width="60%"> This object does not contain the knowledge known by <i>pKnowledge</i> about
    ///    <i>pbChangeUnitId</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER </b></dt> </dl> </td> <td
    ///    width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_ID_FORMAT_MISMATCH</b></dt> </dl> </td> <td width="60%"> <i>pbChangeUnitId</i> is not of the
    ///    format specified by the provider. </td> </tr> </table>
    ///    
    HRESULT ContainsKnowledgeForChangeUnit(ISyncKnowledge pKnowledge, const(ubyte)* pbItemId, 
                                           const(ubyte)* pbChangeUnitId);
    ///Returns knowledge about the knowledge fragments that are specified by the template knowledge, when the template
    ///knowledge contains the prerequisite knowledge for the specified fragments.
    ///Params:
    ///    pPrerequisiteKnowledge = Specifies the knowledge that <i>pTemplateKnowledge</i> must contain for knowledge to be added to
    ///                             <i>ppProjectedKnowledge</i>.
    ///    pTemplateKnowledge = Specifies the set of knowledge fragments to be added to <i>ppProjectedKnowledge</i>.
    ///    ppProjectedKnowledge = A knowledge object that contains the knowledge fragments that are specified by <i>pTemplateKnowledge</i> when
    ///                           <i>pTemplateKnowledge</i> contains the knowledge that is contained in <i>pPrerequisiteKnowledge</i> for the
    ///                           specified fragments.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_ID_FORMAT_MISMATCH</b></dt> </dl> </td> <td width="60%"> The ID format schema that is contained
    ///    in <i>pPrerequisiteKnowledge</i> or <i>pTemplateKnowledge</i> differs from the ID format schema of this
    ///    object. </td> </tr> </table>
    ///    
    HRESULT ProjectOntoKnowledgeWithPrerequisite(ISyncKnowledge pPrerequisiteKnowledge, 
                                                 ISyncKnowledge pTemplateKnowledge, 
                                                 ISyncKnowledge* ppProjectedKnowledge);
    ///Returns the knowledge that is contained in this object but that is not contained in the specified knowledge.
    ///Params:
    ///    pSyncKnowledge = The knowledge to remove from this object to calculate the result of the complement operation.
    ///    ppComplementedKnowledge = The knowledge that is contained in this object but that is not contained in the specified knowledge.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER
    ///    </b></dt> </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT Complement(ISyncKnowledge pSyncKnowledge, ISyncKnowledge* ppComplementedKnowledge);
    ///Indicates whether the specified knowledge intersects with this knowledge.
    ///Params:
    ///    pSyncKnowledge = The knowledge that is checked against this object to determine whether there is an intersection.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The specified knowledge intersects with this knowledge. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The specified knowledge does not
    ///    intersect with this knowledge. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
    ///    <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT IntersectsWithKnowledge(ISyncKnowledge pSyncKnowledge);
    ///Gets a lightweight, read-only representation of this knowledge object that can be used for fast comparisons.
    ///Params:
    ///    ppKnowledgeCookie = A lightweight, read-only representation of this knowledge object that can be used for fast comparisons.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetKnowledgeCookie(IUnknown* ppKnowledgeCookie);
    ///Performs a fast comparison between the specified knowledge cookie and this knowledge object.
    ///Params:
    ///    pKnowledgeCookie = The knowledge cookie to compare against this object.
    ///    pResult = The result of the comparison.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER
    ///    </b></dt> </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT CompareToKnowledgeCookie(IUnknown pKnowledgeCookie, KNOWLEDGE_COOKIE_COMPARISON_RESULT* pResult);
}

///Represents information about a recoverable error.
@GUID("B37C4A0A-4B7D-4C2D-9711-3B00D119B1C8")
interface IRecoverableErrorData : IUnknown
{
    ///Initializes the object by using the specified display name of the item that caused the error and a description of
    ///the error.
    ///Params:
    ///    pcszItemDisplayName = The display name of the item that caused the error.
    ///    pcszErrorDescription = The description of the error.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Provider-determined error codes.</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT Initialize(const(wchar)* pcszItemDisplayName, const(wchar)* pcszErrorDescription);
    ///Gets the display name of the item that caused the error.
    ///Params:
    ///    pszItemDisplayName = Returns the display name of the item that caused the error.
    ///    pcchItemDisplayName = Specifies the number of characters in <i>pszItemDisplayName</i>. Returns the required number of characters
    ///                          for <i>pszItemDisplayName</i> when <i>pcchItemDisplayName</i> is too small; otherwise, returns the number of
    ///                          characters written.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt> </dl> </td> <td width="60%"> <i>pszItemDisplayName</i> is
    ///    too small. In this case, the required number of characters is returned in <i>pcchItemDisplayName</i>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>Provider-determined error codes.</b></dt> </dl> </td> <td
    ///    width="60%"></td> </tr> </table>
    ///    
    HRESULT GetItemDisplayName(const(wchar)* pszItemDisplayName, uint* pcchItemDisplayName);
    ///Gets the description of the error.
    ///Params:
    ///    pszErrorDescription = Returns the description of the error.
    ///    pcchErrorDescription = Specifies the number of characters in <i>pszErrorDescription</i>. Returns the required number of characters
    ///                           for <i>pszErrorDescription</i> when <i>pcchErrorDescription</i> is too small; otherwise, returns the number
    ///                           of characters written.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt> </dl> </td> <td width="60%"> <i>pszErrorDescription</i>
    ///    is too small. In this case, the required number of characters is returned in <i>pcchErrorDescription</i>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Provider-determined error codes.</b></dt> </dl> </td> <td
    ///    width="60%"></td> </tr> </table>
    ///    
    HRESULT GetErrorDescription(const(wchar)* pszErrorDescription, uint* pcchErrorDescription);
}

///Represents a recoverable error that occurred when an item was loaded or when an item was saved.
@GUID("0F5625E8-0A7B-45EE-9637-1CE13645909E")
interface IRecoverableError : IUnknown
{
    ///Gets the stage in the synchronization session when the error occurred.
    ///Params:
    ///    pStage = Returns the stage in the synchronization session when the error occurred.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetStage(SYNC_PROGRESS_STAGE* pStage);
    ///Gets the role of the provider that skipped the item change.
    ///Params:
    ///    pProviderRole = Returns the role of the provider that skipped the item change.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetProvider(SYNC_PROVIDER_ROLE* pProviderRole);
    ///Gets the item change that caused the error.
    ///Params:
    ///    ppChangeWithRecoverableError = Returns the item change that caused the error.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetChangeWithRecoverableError(ISyncChange* ppChangeWithRecoverableError);
    ///Gets additional data about the recoverable error.
    ///Params:
    ///    phrError = Returns the error code that is associated with the error that prevented the change unit data from being
    ///               applied.
    ///    ppErrorData = Returns additional information about the error.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetRecoverableErrorDataForChange(int* phrError, IRecoverableErrorData* ppErrorData);
    ///Gets additional data about the recoverable error for a specified change unit.
    ///Params:
    ///    pChangeUnit = The change unit that is associated with the error.
    ///    phrError = Returns the error code that is associated with the error that prevented the change unit data from being
    ///               applied.
    ///    ppErrorData = Returns additional information about the error.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetRecoverableErrorDataForChangeUnit(ISyncChangeUnit pChangeUnit, int* phrError, 
                                                 IRecoverableErrorData* ppErrorData);
}

///Represents a conflict between two items.
@GUID("014EBF97-9F20-4F7A-BDD4-25979C77C002")
interface IChangeConflict : IUnknown
{
    ///Gets the change metadata from the destination provider.
    ///Params:
    ///    ppConflictingChange = Returns the change metadata from the destination provider.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_INTERNAL_ERROR</b></dt> </dl> </td> <td width="60%"> The change from the destination provider
    ///    does not exist. </td> </tr> </table>
    ///    
    HRESULT GetDestinationProviderConflictingChange(ISyncChange* ppConflictingChange);
    ///Gets the change metadata from the source provider.
    ///Params:
    ///    ppConflictingChange = Returns the change metadata from the source provider.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_INTERNAL_ERROR </b></dt> </dl> </td> <td width="60%"> The change from the source provider does
    ///    not exist. </td> </tr> </table>
    ///    
    HRESULT GetSourceProviderConflictingChange(ISyncChange* ppConflictingChange);
    ///Gets an object that can be used to retrieve item data for the change item from the destination replica.
    ///Params:
    ///    ppConflictingData = Returns an object that can be used to retrieve item data for the change item from the destination replica.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_INTERNAL_ERROR </b></dt> </dl> </td> <td width="60%"> An internal error has occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>Provider-specified error codes.</b></dt> </dl> </td> <td width="60%">
    ///    The provider cannot load the data for the change. </td> </tr> </table>
    ///    
    HRESULT GetDestinationProviderConflictingData(IUnknown* ppConflictingData);
    ///Gets an object that can be used to retrieve item data for the change item from the source replica.
    ///Params:
    ///    ppConflictingData = Returns an object that can be used to retrieve item data for the change item from the source replica.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_INTERNAL_ERROR </b></dt> </dl> </td> <td width="60%"> An internal error has occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>Provider-specified error codes.</b></dt> </dl> </td> <td width="60%">
    ///    The provider cannot load the data for the change. </td> </tr> </table>
    ///    
    HRESULT GetSourceProviderConflictingData(IUnknown* ppConflictingData);
    ///Gets the conflict resolution action for the conflict.
    ///Params:
    ///    pResolveAction = Returns the conflict resolution action for the conflict.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetResolveActionForChange(SYNC_RESOLVE_ACTION* pResolveAction);
    ///Sets a conflict resolution action for the conflict.
    ///Params:
    ///    resolveAction = The conflict resolution action for the conflict.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_INTERNAL_ERROR </b></dt> </dl> </td> <td width="60%"> An internal error has occurred. </td>
    ///    </tr> </table>
    ///    
    HRESULT SetResolveActionForChange(SYNC_RESOLVE_ACTION resolveAction);
    ///Gets the conflict resolution action for the conflicting change unit change.
    ///Params:
    ///    pChangeUnit = The change unit for which to retrieve the conflict resolution action.
    ///    pResolveAction = The conflict resolution action that is specified for <i>pChangeUnit</i>.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetResolveActionForChangeUnit(ISyncChangeUnit pChangeUnit, SYNC_RESOLVE_ACTION* pResolveAction);
    ///Sets a conflict resolution action for the conflicting change unit change.
    ///Params:
    ///    pChangeUnit = The change unit for which to set the conflict resolution action.
    ///    resolveAction = The conflict resolution action to set for <i>pChangeUnit</i>.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_INTERNAL_ERROR </b></dt> </dl> </td> <td width="60%"> When the conflict is an update-delete
    ///    conflict, or when no conflict exists. </td> </tr> </table>
    ///    
    HRESULT SetResolveActionForChangeUnit(ISyncChangeUnit pChangeUnit, SYNC_RESOLVE_ACTION resolveAction);
}

@GUID("00D2302E-1CF8-4835-B85F-B7CA4F799E0A")
interface IConstraintConflict : IUnknown
{
    HRESULT GetDestinationProviderConflictingChange(ISyncChange* ppConflictingChange);
    HRESULT GetSourceProviderConflictingChange(ISyncChange* ppConflictingChange);
    HRESULT GetDestinationProviderOriginalChange(ISyncChange* ppOriginalChange);
    HRESULT GetDestinationProviderConflictingData(IUnknown* ppConflictingData);
    HRESULT GetSourceProviderConflictingData(IUnknown* ppConflictingData);
    HRESULT GetDestinationProviderOriginalData(IUnknown* ppOriginalData);
    HRESULT GetConstraintResolveActionForChange(__MIDL___MIDL_itf_winsync_0000_0000_0009* pConstraintResolveAction);
    HRESULT SetConstraintResolveActionForChange(__MIDL___MIDL_itf_winsync_0000_0000_0009 constraintResolveAction);
    HRESULT GetConstraintResolveActionForChangeUnit(ISyncChangeUnit pChangeUnit, 
                                                    __MIDL___MIDL_itf_winsync_0000_0000_0009* pConstraintResolveAction);
    HRESULT SetConstraintResolveActionForChangeUnit(ISyncChangeUnit pChangeUnit, 
                                                    __MIDL___MIDL_itf_winsync_0000_0000_0009 constraintResolveAction);
    HRESULT GetConstraintConflictReason(__MIDL___MIDL_itf_winsync_0000_0000_0010* pConstraintConflictReason);
    HRESULT IsTemporary();
}

///Represents application callbacks that are used to notify the application of synchronization events.
@GUID("0599797F-5ED9-485C-AE36-0C5D1BF2E7A5")
interface ISyncCallback : IUnknown
{
    ///Occurs periodically during the synchronization session to report progress.
    ///Params:
    ///    provider = The role of the provider that is associated with this event.
    ///    syncStage = The current stage of the synchronization session.
    ///    dwCompletedWork = The amount of work that is currently completed in the session. This value is interpreted as being a part of
    ///                      <i>dwTotalWork</i>.
    ///    dwTotalWork = The total work for the session.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Application-determined error codes.</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT OnProgress(SYNC_PROVIDER_ROLE provider, SYNC_PROGRESS_STAGE syncStage, uint dwCompletedWork, 
                       uint dwTotalWork);
    ///Occurs before a change is applied.
    ///Params:
    ///    pSyncChange = The item change that is about to be applied.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Application-determined error codes.</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT OnChange(ISyncChange pSyncChange);
    ///Occurs when a conflict is detected when the concurrency conflict resolution policy is set to CRP_NONE.
    ///Params:
    ///    pConflict = Information about the conflict. This includes metadata and item data for the two changes that are in
    ///                conflict.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Application-determined error codes.</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT OnConflict(IChangeConflict pConflict);
    ///Occurs when the forgotten knowledge from the source provider is not contained in the current knowledge of the
    ///destination provider.
    ///Params:
    ///    pFullEnumerationAction = Specifies how a synchronization session should handle the full enumeration.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Application-determined error codes.</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT OnFullEnumerationNeeded(SYNC_FULL_ENUMERATION_ACTION* pFullEnumerationAction);
    ///Occurs when a synchronization provider sets a recoverable error when it is loading or saving an item.
    ///Params:
    ///    pRecoverableError = The recoverable error.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Application-determined error codes.</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT OnRecoverableError(IRecoverableError pRecoverableError);
}

///Represents additional application callbacks that are used to notify the application of synchronization events.
@GUID("47CE84AF-7442-4EAD-8630-12015E030AD7")
interface ISyncCallback2 : ISyncCallback
{
    ///Occurs after a change is successfully applied.
    ///Params:
    ///    dwChangesApplied = The number of changes that have been successfully applied during the synchronization session. This value is
    ///                       the sum of item changes plus change unit changes.
    ///    dwChangesFailed = The number of changes that have failed to apply during the synchronization session. This value is the sum of
    ///                      item changes plus change unit changes.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Application-determined error codes</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT OnChangeApplied(uint dwChangesApplied, uint dwChangesFailed);
    ///Occurs after a change fails to apply.
    ///Params:
    ///    dwChangesApplied = The number of changes that have been successfully applied during the synchronization session. This value is
    ///                       the sum of item changes plus change unit changes.
    ///    dwChangesFailed = The number of changes that have failed to apply during the synchronization session. This value is the sum of
    ///                      item changes plus change unit changes.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Application-determined error codes</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT OnChangeFailed(uint dwChangesApplied, uint dwChangesFailed);
}

@GUID("8AF3843E-75B3-438C-BB51-6F020D70D3CB")
interface ISyncConstraintCallback : IUnknown
{
    HRESULT OnConstraintConflict(IConstraintConflict pConflict);
}

///Represents a synchronization provider that can be used by a synchronization session to synchronize data with another
///synchronization provider.
@GUID("8F657056-2BCE-4A17-8C68-C7BB7898B56F")
interface ISyncProvider : IUnknown
{
    ///Gets the ID format schema of the provider.
    ///Params:
    ///    pIdParameters = Returns the ID format schema of the provider.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Provider-determined error codes.</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT GetIdParameters(ID_PARAMETERS* pIdParameters);
}

///Represents information about the current synchronization session.
@GUID("B8A940FE-9F01-483B-9434-C37D361225D9")
interface ISyncSessionState : IUnknown
{
    ///Indicates whether the synchronization session has been canceled.
    ///Params:
    ///    pfIsCanceled = Returns <b>TRUE</b> if the synchronization session has been canceled; otherwise, returns <b>FALSE</b>.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT IsCanceled(int* pfIsCanceled);
    ///Retrieves stored data for a serialized change applier.
    ///Params:
    ///    pbChangeApplierInfo = Returns the serialized change applier data.
    ///    pcbChangeApplierInfo = Specifies the number of bytes in <i>pbChangeApplierInfo</i>. Returns the number of bytes required to retrieve
    ///                           the change applier data when <i>pcbChangeApplierInfo</i> is too small, or returns the number of bytes
    ///                           written.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt> </dl> </td> <td width="60%"> <i>pbChangeApplierInfo</i>
    ///    is too small. In this case, the required number of bytes is returned in <i>pcbChangeApplierInfo</i>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetInfoForChangeApplication(ubyte* pbChangeApplierInfo, uint* pcbChangeApplierInfo);
    ///Stores data for a serialized change applier.
    ///Params:
    ///    pbChangeApplierInfo = The serialized change applier data.
    ///    cbChangeApplierInfo = Specifies the number of bytes in <i>pbChangeApplierInfo</i>.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pbChangeApplierInfo</i> is not <b>NULL</b> and
    ///    <i>cbChangeApplierInfo</i> is zero. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_DESERIALIZATION</b></dt> </dl> </td> <td width="60%"> The serialized data is not valid. </td>
    ///    </tr> </table>
    ///    
    HRESULT LoadInfoFromChangeApplication(const(ubyte)* pbChangeApplierInfo, uint cbChangeApplierInfo);
    ///Gets the lower bound of the recovery range when the session is performing forgotten knowledge recovery.
    ///Params:
    ///    pbRangeStart = Returns the lower bound of the recovery range when the session is performing forgotten knowledge recovery.
    ///    pcbRangeStart = Specifies the number of bytes in <i>pbRangeStart</i>. Returns the number of bytes required to retrieve the
    ///                    range value when <i>pcbRangeStart</i> is too small, or the number of bytes written.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt> </dl> </td> <td width="60%"> <i>pcbRangeStart</i> is too
    ///    small. In this case, the required number of bytes is returned in <i>pcbRangeStart</i>. </td> </tr> </table>
    ///    
    HRESULT GetForgottenKnowledgeRecoveryRangeStart(ubyte* pbRangeStart, uint* pcbRangeStart);
    ///Gets the upper bound of the recovery range when the session is performing forgotten knowledge recovery.
    ///Params:
    ///    pbRangeEnd = Returns the upper bound of the recovery range when the session is performing forgotten knowledge recovery.
    ///    pcbRangeEnd = Specifies the number of bytes in <i>pbRangeEnd</i>. Returns the number of bytes required to retrieve the
    ///                  range value when <i>pcbRangeEnd</i> is too small, or the number of bytes written.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt> </dl> </td> <td width="60%"> <i>pcbRangeEnd</i> is too
    ///    small. In this case, the required number of bytes is returned in <i>pcbRangeEnd</i>. </td> </tr> </table>
    ///    
    HRESULT GetForgottenKnowledgeRecoveryRangeEnd(ubyte* pbRangeEnd, uint* pcbRangeEnd);
    ///Sets the recovery range when the session is performing forgotten knowledge recovery.
    ///Params:
    ///    pRange = The lower and upper bounds that define the range of IDs to be recovered.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_ID_FORMAT_MISMATCH</b></dt> </dl> </td> <td width="60%"> An item ID in <i>pRange</i> is not in
    ///    the format that is specified by the ID format schema of the provider. </td> </tr> </table>
    ///    
    HRESULT SetForgottenKnowledgeRecoveryRange(const(SYNC_RANGE)* pRange);
    ///Reports synchronization progress to the application.
    ///Params:
    ///    provider = The role of the provider that is sending this event.
    ///    syncStage = The current stage of the synchronization session.
    ///    dwCompletedWork = The amount of work that is currently completed in the session. This value is interpreted as being a part of
    ///                      <i>dwTotalWork</i>.
    ///    dwTotalWork = The total work for the session.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>provider</i> or <i>syncStage</i> is not a valid
    ///    value. </td> </tr> </table>
    ///    
    HRESULT OnProgress(SYNC_PROVIDER_ROLE provider, SYNC_PROGRESS_STAGE syncStage, uint dwCompletedWork, 
                       uint dwTotalWork);
}

///Represents information about which provider caused synchronization to fail.
@GUID("326C6810-790A-409B-B741-6999388761EB")
interface ISyncSessionExtendedErrorInfo : IUnknown
{
    ///Gets the ISyncProvider interface of the provider that caused synchronization to fail.
    ///Params:
    ///    ppProviderWithError = The ISyncProvider interface of the provider that caused synchronization to fail.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> A synchronization session was not
    ///    started. </td> </tr> </table>
    ///    
    HRESULT GetSyncProviderWithError(ISyncProvider* ppProviderWithError);
}

///Represents additional information about the current synchronization session.
@GUID("9E37CFA3-9E38-4C61-9CA3-FFE810B45CA2")
interface ISyncSessionState2 : ISyncSessionState
{
    ///Indicates which provider caused synchronization to fail.
    ///Params:
    ///    fSelf = <b>TRUE</b> when the provider that calls this method is the provider that caused the error. Otherwise,<b>
    ///            FALSE</b>.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> A synchronization session does not
    ///    exist. </td> </tr> </table>
    ///    
    HRESULT SetProviderWithError(BOOL fSelf);
    ///Gets the error value that indicates why the synchronization session failed.
    ///Params:
    ///    phrSessionError = The error value that indicates why the synchronization session failed.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER
    ///    </b></dt> </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetSessionErrorStatus(int* phrSessionError);
}

///Represents information about a filter that is used to control the data that is included in an <b>ISyncChangeBatch</b>
///object.
@GUID("794EAAF8-3F2E-47E6-9728-17E6FCF94CB7")
interface ISyncFilterInfo : IUnknown
{
    ///Serializes the filter data to an array of bytes.
    ///Params:
    ///    pbBuffer = Returns the serialized filter information. Set this value to <b>NULL</b> to request the required size of the
    ///               buffer.
    ///    pcbBuffer = Specifies the number of bytes in <i>pbBuffer</i>. Returns the number of bytes required to serialize the
    ///                filter when <i>pcbBuffer</i> is too small, or the number of bytes written.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>0x800700EA (HRESULT_FROM_WIN32(ERROR_MORE_DATA))</b></dt> </dl> </td> <td width="60%"> <i>pbBuffer</i>
    ///    is <b>NULL</b> or <i>pcbBuffer</i> is too small. In this case, the number of bytes required to serialize the
    ///    filter is returned in <i>pcbBuffer</i>. </td> </tr> </table>
    ///    
    HRESULT Serialize(ubyte* pbBuffer, uint* pcbBuffer);
}

///Represents additional information about a filter that can be used to control which changes are included in an
///<b>ISyncChangeBatch</b> object.
@GUID("19B394BA-E3D0-468C-934D-321968B2AB34")
interface ISyncFilterInfo2 : ISyncFilterInfo
{
    ///Gets the flags that specify additional information about the filter information object.
    ///Params:
    ///    pdwFlags = Gets the flags that specify additional information about the filter information object. This will be one of
    ///               the <b>SYNC_FILTER_INFO_FLAG</b> values (See Remarks).
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetFlags(uint* pdwFlags);
}

///Represents a filter that can be used to control which change units are included for items in an
///<b>ISyncChangeBatch</b> object.
@GUID("F2837671-0BDF-43FA-B502-232375FB50C2")
interface IChangeUnitListFilterInfo : ISyncFilterInfo
{
    ///Initializes a new instance of the <b>IChangeUnitListFilterInfo</b> class that contains the specified array of
    ///change unit IDs.
    ///Params:
    ///    ppbChangeUnitIds = The array of change unit IDs that indicate which change units are included by this filter.
    ///    dwChangeUnitCount = The number of change unit IDs that are contained in <i>ppbChangeUnitIds</i>.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>dwChangeUnitCount</i> is 0, or any ID that is
    ///    contained in <i>ppbChangeUnitIds</i> is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT Initialize(const(ubyte)** ppbChangeUnitIds, uint dwChangeUnitCount);
    ///Gets the number of change unit IDs that define the filter.
    ///Params:
    ///    pdwChangeUnitIdCount = Returns the number of change unit IDs that define the filter.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetChangeUnitIdCount(uint* pdwChangeUnitIdCount);
    ///Gets the change unit ID that is stored at the specified index in the array of change unit IDs that define the
    ///filter.
    ///Params:
    ///    dwChangeUnitIdIndex = The index of the change unit ID to look up.
    ///    pbChangeUnitId = Returns the change unit ID that is stored at the index that is specified by <i>dwChangeUnitIdIndex</i>.
    ///    pcbIdSize = Specifies the number of bytes in <i>pbChangeUnitId</i>. Returns the number of bytes that are required to
    ///                retrieve the ID when <i>pbChangeUnitId</i> is too small, or the number of bytes written.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> No filter is defined, or <i>dwChangeUnitIdIndex</i>
    ///    is larger than the number of change unit IDs that are stored in this object. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt> </dl> </td> <td width="60%">
    ///    <i>pbChangeUnitId</i> is too small. In this case, the required number of bytes is returned in
    ///    <i>pcbIdSize</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SYNC_E_ID_FORMAT_MISMATCH</b></dt> </dl>
    ///    </td> <td width="60%"> The change unit ID to be returned is not valid. </td> </tr> </table>
    ///    
    HRESULT GetChangeUnitId(uint dwChangeUnitIdIndex, ubyte* pbChangeUnitId, uint* pcbIdSize);
}

@GUID("087A3F15-0FCB-44C1-9639-53C14E2B5506")
interface ISyncFilter : IUnknown
{
    HRESULT IsIdentical(ISyncFilter pSyncFilter);
    HRESULT Serialize(ubyte* pbSyncFilter, uint* pcbSyncFilter);
}

@GUID("B45B7A72-E5C7-46BE-9C82-77B8B15DAB8A")
interface ISyncFilterDeserializer : IUnknown
{
    HRESULT DeserializeSyncFilter(const(ubyte)* pbSyncFilter, uint dwCbSyncFilter, ISyncFilter* ppISyncFilter);
}

@GUID("1D335DFF-6F88-4E4D-91A8-A3F351CFD473")
interface ICustomFilterInfo : ISyncFilterInfo
{
    HRESULT GetSyncFilter(ISyncFilter* pISyncFilter);
}

@GUID("11F9DE71-2818-4779-B2AC-42D450565F45")
interface ICombinedFilterInfo : ISyncFilterInfo
{
    HRESULT GetFilterCount(uint* pdwFilterCount);
    HRESULT GetFilterInfo(uint dwFilterIndex, ISyncFilterInfo* ppIFilterInfo);
    HRESULT GetFilterCombinationType(__MIDL___MIDL_itf_winsync_0000_0036_0001* pFilterCombinationType);
}

///Enumerates a list of item changes.
@GUID("5F86BE4A-5E78-4E32-AC1C-C24FD223EF85")
interface IEnumSyncChanges : IUnknown
{
    ///Returns the next item change.
    ///Params:
    ///    cChanges = The number of changes to fetch. The only valid value is 1.
    ///    ppChange = Returns the next item change.
    ///    pcFetched = Returns the number of changes that are fetched.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"></td> </tr> </table>
    ///    
    HRESULT Next(uint cChanges, ISyncChange* ppChange, uint* pcFetched);
    ///This method is not implemented.
    ///Params:
    ///    cChanges = The number of changes to skip.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt>
    ///    </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT Skip(uint cChanges);
    ///Resets the enumerator to the beginning of the list.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Reset();
    ///This method is not implemented.
    ///Params:
    ///    ppEnum = Returns the cloned enumerator.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt>
    ///    </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT Clone(IEnumSyncChanges* ppEnum);
}

///Provides additional data for an item change.
@GUID("56F14771-8677-484F-A170-E386E418A676")
interface ISyncChangeBuilder : IUnknown
{
    ///Adds change unit metadata to an item change.
    ///Params:
    ///    pbChangeUnitId = The ID of the change unit to add to the item change.
    ///    pChangeUnitVersion = The version of the change unit change to add to the item change.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_ID_FORMAT_MISMATCH</b></dt> </dl> </td> <td width="60%"> The format of the change unit ID that
    ///    is contained in <i>pbChangeUnitId</i> does not match the format that is specified by the ID format schema of
    ///    the provider. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SYNC_E_INVALID_OPERATION</b></dt> </dl> </td> <td
    ///    width="60%"> The item change to which to add this change unit to has <b>SYNC_CHANGE_FLAG_DELETE</b> or
    ///    <b>SYNC_CHANGE_FLAG_DOES_NOT_EXIST</b> set as one of its flags. </td> </tr> </table>
    ///    
    HRESULT AddChangeUnitMetadata(const(ubyte)* pbChangeUnitId, const(SYNC_VERSION)* pChangeUnitVersion);
}

@GUID("295024A0-70DA-4C58-883C-CE2AFB308D0B")
interface IFilterTrackingSyncChangeBuilder : IUnknown
{
    HRESULT AddFilterChange(uint dwFilterKey, const(SYNC_FILTER_CHANGE)* pFilterChange);
    HRESULT SetAllChangeUnitsPresentFlag();
}

///Represents metadata for a set of changes.
@GUID("52F6E694-6A71-4494-A184-A8311BF5D227")
interface ISyncChangeBatchBase : IUnknown
{
    ///Gets an IEnumSyncChanges object that enumerates the item changes in this change batch.
    ///Params:
    ///    ppEnum = Returns an enumerator that contains the item changes in this change batch.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER
    ///    </b></dt> </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT GetChangeEnumerator(IEnumSyncChanges* ppEnum);
    ///Gets a flag that indicates whether the changes in this change batch are the last batch of a synchronization
    ///session.
    ///Params:
    ///    pfLastBatch = Returns a flag that indicates whether this batch is the last batch.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER
    ///    </b></dt> </dl> </td> <td width="60%"> <i>pfLastBatch</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetIsLastBatch(int* pfLastBatch);
    ///Gets the work estimate for the batch.
    ///Params:
    ///    pdwWorkForBatch = Returns the work estimate for the batch. The default value is 0.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetWorkEstimateForBatch(uint* pdwWorkForBatch);
    ///Gets the estimate of the remaining work for the session.
    ///Params:
    ///    pdwRemainingWorkForSession = The estimated remaining work for the session. The default value is 0.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetRemainingWorkEstimateForSession(uint* pdwRemainingWorkForSession);
    ///Opens an ordered group in the change batch. This group is ordered by item ID.
    ///Params:
    ///    pbLowerBound = The closed lower bound of item IDs for this ordered group. To specify a lower bound of zero, use <b>NULL</b>.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> A group is already open or an empty
    ///    group was previously added to the batch. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_CHANGE_BATCH_IS_READ_ONLY</b></dt> </dl> </td> <td width="60%"> The object is an
    ///    <b>ISyncFullEnumerationChangeBatch</b> object and a group has already been added to the batch. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>SYNC_E_RANGE_OUT_OF_ORDER</b></dt> </dl> </td> <td width="60%"> The object
    ///    is an <b>ISyncFullEnumerationChangeBatch</b> object and <i>pbLowerBound</i> is greater than the lower bound
    ///    ID that was used to create the batch. </td> </tr> </table>
    ///    
    HRESULT BeginOrderedGroup(const(ubyte)* pbLowerBound);
    ///Closes a previously opened ordered group in the change batch.
    ///Params:
    ///    pbUpperBound = The closed upper bound of item IDs for this ordered group. To specify an upper bound of infinity, use
    ///                   <b>NULL</b>.
    ///    pMadeWithKnowledge = The knowledge of the replica that made this group.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> No group is open or an unordered group
    ///    is open. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SYNC_E_RANGE_OUT_OF_ORDER</b></dt> </dl> </td> <td
    ///    width="60%"> <i>pbUpperBound</i> is less than the ID of the last item that was added to the group. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>SYNC_E_CHANGE_BATCH_IS_READ_ONLY</b></dt> </dl> </td> <td
    ///    width="60%"> The object is an <b>ISyncFullEnumerationChangeBatch</b> object and a group has already been
    ///    added to the batch. </td> </tr> </table>
    ///    
    HRESULT EndOrderedGroup(const(ubyte)* pbUpperBound, ISyncKnowledge pMadeWithKnowledge);
    ///Adds a specified item change to the group that is currently open.
    ///Params:
    ///    pbOwnerReplicaId = The replica ID of the replica where <i>pChangeVersion</i> and <i>pCreationVersion</i> are valid. The ID
    ///                       format must match the format that is specified by the ID_PARAMETERS structure of the provider.
    ///    pbItemId = The ID of the item. The ID format must match the format that is specified by the ID_PARAMETERS structure of
    ///               the provider.
    ///    pChangeVersion = The version of this change.
    ///    pCreationVersion = The creation version of the item.
    ///    dwFlags = Flags that specify the state of the item change. For the flag values, see ISyncChange::GetFlags.
    ///    dwWorkForChange = The work estimate for the change. This value is used during change application to report completed work to
    ///                      the application.
    ///    ppChangeBuilder = Returns an object that can be used to add change unit information to the change.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>dwFlags</i> contains a flag value that is not
    ///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SYNC_E_INVALID_OPERATION</b></dt> </dl> </td> <td
    ///    width="60%"> No group is open or an empty group was previously added to the batch. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>SYNC_E_RANGE_OUT_OF_ORDER</b></dt> </dl> </td> <td width="60%"> An ordered group is
    ///    open and <i>pbItemId</i> is less than the item ID of the previous item that was added to the group, or less
    ///    than the item ID that was specified when the group was opened. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_CHANGE_BATCH_IS_READ_ONLY</b></dt> </dl> </td> <td width="60%"> The <b>ISyncChangeBatchBase</b>
    ///    object has been sent to a change applier or to the synchronization session. </td> </tr> </table>
    ///    
    HRESULT AddItemMetadataToGroup(const(ubyte)* pbOwnerReplicaId, const(ubyte)* pbItemId, 
                                   const(SYNC_VERSION)* pChangeVersion, const(SYNC_VERSION)* pCreationVersion, 
                                   uint dwFlags, uint dwWorkForChange, ISyncChangeBuilder* ppChangeBuilder);
    ///Gets the knowledge that the destination replica learns when the destination provider applies all the changes in
    ///this change batch.
    ///Params:
    ///    ppLearnedKnowledge = Returns the knowledge that a replica will learn when a provider applies all the changes in this change batch
    ///                         to the replica. This knowledge is valid only when the current knowledge of the replica contains the
    ///                         prerequisite knowledge of the change batch. The prerequisite knowledge can be obtained by calling
    ///                         ISyncChangeBatchBase::GetPrerequisiteKnowledge.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The last group added to the batch was
    ///    not ended. </td> </tr> </table>
    ///    
    HRESULT GetLearnedKnowledge(ISyncKnowledge* ppLearnedKnowledge);
    ///Gets the minimum knowledge that a destination provider is required to have to process this change batch.
    ///Params:
    ///    ppPrerequisteKnowledge = Returns the minimum knowledge that a destination provider is required to have to process this change batch.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetPrerequisiteKnowledge(ISyncKnowledge* ppPrerequisteKnowledge);
    ///Gets the forgotten knowledge of the source replica.
    ///Params:
    ///    ppSourceForgottenKnowledge = Returns the forgotten knowledge of the source replica.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetSourceForgottenKnowledge(IForgottenKnowledge* ppSourceForgottenKnowledge);
    ///Sets a flag that indicates there are no more changes to be enumerated in the synchronization session.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetLastBatch();
    ///Sets the work estimate for the batch.
    ///Params:
    ///    dwWorkForBatch = The work estimate for the batch.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetWorkEstimateForBatch(uint dwWorkForBatch);
    ///Sets the estimate of the remaining work for the session.
    ///Params:
    ///    dwRemainingWorkForSession = The estimate of the remaining work for the session.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetRemainingWorkEstimateForSession(uint dwRemainingWorkForSession);
    ///Serializes the change batch to an array of bytes.
    ///Params:
    ///    pbChangeBatch = The byte array that receives the change batch data.
    ///    pcbChangeBatch = Specifies the number of bytes in <i>pbChangeBatch</i>. Returns the number of bytes required for
    ///                     <i>pbChangeBatch</i> when <i>pbChangeBatch</i> is too small, or the number of bytes written to
    ///                     <i>pbChangeBatch</i> when data is written.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt> </dl> </td> <td width="60%"> <i>pbChangeBatch</i> is too
    ///    small. In this case, the required number of bytes is stored in <i>pcbChangeBatch</i>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>SYNC_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The last group added
    ///    to the batch was not ended. </td> </tr> </table>
    ///    
    HRESULT Serialize(ubyte* pbChangeBatch, uint* pcbChangeBatch);
}

///Represents metadata for a set of changes.
@GUID("70C64DEE-380F-4C2E-8F70-31C55BD5F9B3")
interface ISyncChangeBatch : ISyncChangeBatchBase
{
    ///Opens an unordered group in the change batch. Item changes in this group can be in any order.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> A group is already open or an empty
    ///    group was previously added to the batch. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_CHANGE_BATCH_IS_READ_ONLY</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT BeginUnorderedGroup();
    ///Closes a previously opened unordered group in the change batch.
    ///Params:
    ///    pMadeWithKnowledge = The made-with knowledge for the changes in the group. Typically, this is the knowledge of the replica that
    ///                         made this group.
    ///    fAllChangesForKnowledge = <b>TRUE</b> when all the changes contained in <i>pMadeWithKnowledge</i> are included in this change batch;
    ///                              otherwise, <b>FALSE</b>.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> No group is open or an ordered group is
    ///    open. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SYNC_E_CHANGE_BATCH_IS_READ_ONLY</b></dt> </dl> </td> <td
    ///    width="60%"></td> </tr> </table>
    ///    
    HRESULT EndUnorderedGroup(ISyncKnowledge pMadeWithKnowledge, BOOL fAllChangesForKnowledge);
    ///Adds metadata that represents a conflict to the change batch.
    ///Params:
    ///    pbOwnerReplicaId = The ID of the replica that made the change in conflict.
    ///    pbItemId = The ID of the item.
    ///    pChangeVersion = The version of the change.
    ///    pCreationVersion = The creation version of the item.
    ///    dwFlags = Flags that specify the state of the item change. For the SYNC_CHANGE_FLAG values, see the Remarks section of
    ///              the ISyncChange::GetFlags method.
    ///    dwWorkForChange = The work estimate for the change. This value is used during change application to report completed work to
    ///                      the application.
    ///    pConflictKnowledge = The conflict knowledge that was saved when the conflict was logged.
    ///    ppChangeBuilder = Returns an object that can be used to add change unit information to the change.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_CHANGE_BATCH_IS_READ_ONLY</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT AddLoggedConflict(const(ubyte)* pbOwnerReplicaId, const(ubyte)* pbItemId, 
                              const(SYNC_VERSION)* pChangeVersion, const(SYNC_VERSION)* pCreationVersion, 
                              uint dwFlags, uint dwWorkForChange, ISyncKnowledge pConflictKnowledge, 
                              ISyncChangeBuilder* ppChangeBuilder);
}

///Represents the metadata for a set of changes that is created as part of a recovery synchronization.
@GUID("EF64197D-4F44-4EA2-B355-4524713E3BED")
interface ISyncFullEnumerationChangeBatch : ISyncChangeBatchBase
{
    ///Gets the knowledge the destination replica will learn after it applies all the changes in the recovery
    ///synchronization.
    ///Params:
    ///    ppLearnedKnowledgeAfterRecoveryComplete = Returns the knowledge that the destination replica will learn after it applies all the changes in the
    ///                                              recovery synchronization.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> No group was added to the batch, or a
    ///    group was opened but not ended. </td> </tr> </table>
    ///    
    HRESULT GetLearnedKnowledgeAfterRecoveryComplete(ISyncKnowledge* ppLearnedKnowledgeAfterRecoveryComplete);
    ///Gets the closed lower bound on item IDs that require destination versions.
    ///Params:
    ///    pbClosedLowerBoundItemId = Returns the closed lower bound on item IDs that require destination versions.
    ///    pcbIdSize = Specifies the number of bytes in <i>pbClosedLowerBoundItemId</i>. Returns the number of bytes required for
    ///                the size of <i>pbClosedLowerBoundItemId</i> when <i>pcbIdSize</i> is too small, or the number of bytes
    ///                written to <i>pbClosedLowerBoundItemId</i>.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt> </dl> </td> <td width="60%">
    ///    <i>pbClosedLowerBoundItemId</i> is too small. In this case, the required number of bytes is stored in
    ///    <i>pcbIdSize</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SYNC_E_INVALID_OPERATION</b></dt> </dl> </td>
    ///    <td width="60%"> No group was added to the batch, or a group was opened but not ended. </td> </tr> </table>
    ///    
    HRESULT GetClosedLowerBoundItemId(ubyte* pbClosedLowerBoundItemId, uint* pcbIdSize);
    ///Gets the closed upper bound on item IDs that require destination versions.
    ///Params:
    ///    pbClosedUpperBoundItemId = Returns the closed upper bound on item IDs that require destination versions.
    ///    pcbIdSize = Specifies the number of bytes in <i>pbClosedUpperBoundItemId</i>. Returns the number of bytes required for
    ///                the size of <i>pbClosedUpperBoundItemId</i> when <i>pcbIdSize</i> is too small, or the number of bytes
    ///                written to <i>pbClosedUpperBoundItemId</i>.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt> </dl> </td> <td width="60%">
    ///    <i>pbClosedLowerBoundItemId</i> is too small. In this case, the required number of bytes is stored in
    ///    <i>pcbIdSize</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SYNC_E_INVALID_OPERATION</b></dt> </dl> </td>
    ///    <td width="60%"> No group was added to the batch, or a group was opened but not ended. </td> </tr> </table>
    ///    
    HRESULT GetClosedUpperBoundItemId(ubyte* pbClosedUpperBoundItemId, uint* pcbIdSize);
}

///Represents metadata about a change batch that is based on the prerequisite knowledge associated with the change
///batch.
@GUID("097F13BE-5B92-4048-B3F2-7B42A2515E07")
interface ISyncChangeBatchWithPrerequisite : ISyncChangeBatchBase
{
    ///Sets the minimum knowledge that a destination provider is required to have to process this change batch.
    ///Params:
    ///    pPrerequisiteKnowledge = The minimum knowledge that a destination provider is required to have to process this change batch.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT SetPrerequisiteKnowledge(ISyncKnowledge pPrerequisiteKnowledge);
    ///Gets the knowledge that the destination replica learns when the destination provider applies all the changes in
    ///this change batch, based on the prerequisite knowledge of the change batch.
    ///Params:
    ///    pDestinationKnowledge = A knowledge fragment is added to the returned learned knowledge only if <i>pDestinationKnowledge</i> contains
    ///                            the prerequisite knowledge for that fragment.
    ///    ppLearnedWithPrerequisiteKnowledge = The knowledge that the destination replica learns when the destination provider applies all the changes in
    ///                                         this change batch, based on the prerequisite knowledge of the change batch.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetLearnedKnowledgeWithPrerequisite(ISyncKnowledge pDestinationKnowledge, 
                                                ISyncKnowledge* ppLearnedWithPrerequisiteKnowledge);
    ///Gets the forgotten knowledge that the destination replica learns when the destination provider applies all the
    ///changes in this change batch during recovery synchronization.
    ///Params:
    ///    ppLearnedForgottenKnowledge = Returns the forgotten knowledge that the destination replica learns when the destination provider applies all
    ///                                  the changes in this change batch during recovery synchronization.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The change batch object is not an
    ///    ISyncFullEnumerationChangeBatch object. </td> </tr> </table>
    ///    
    HRESULT GetLearnedForgottenKnowledge(IForgottenKnowledge* ppLearnedForgottenKnowledge);
}

///Represents additional capabilities of an ISyncChangeBatchBase object.
@GUID("6FDB596A-D755-4584-BD0C-C0C23A548FBF")
interface ISyncChangeBatchBase2 : ISyncChangeBatchBase
{
    ///Serializes the change batch object data to a byte array, based on the specified version and serialization
    ///options.
    ///Params:
    ///    targetFormatVersion = The serialized change batch is compatible with this version.
    ///    dwFlags = Reserved. Must be zero.
    ///    pbBuffer = The serialized change batch object data is serialized to this buffer.
    ///    pdwSerializedSize = The number of bytes in <i>pbBuffer</i>. Returns either the number of bytes that are required to serialize the
    ///                        change batch data when <i>pbBuffer</i> is too small, or the number of bytes written.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>dwFlags</i> is not zero, or the version that is
    ///    specified by <i>targetFormatVersion</i> is incompatible with the change batch object data. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt> </dl> </td> <td width="60%">
    ///    <i>pBuffer</i> is too small. In this situation, the required number of bytes is returned in
    ///    <i>pdwSerializedSize</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SYNC_E_INVALID_OPERATION</b></dt>
    ///    </dl> </td> <td width="60%"> The change batch contains a group that was started but not ended. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>SYNC_E_INVALID_VERSION</b></dt> </dl> </td> <td width="60%"> The value of
    ///    <i>targetFormatVersion</i> is higher than the version of the object, or the object contains elements that are
    ///    not compatible with <i>targetFormatVersion</i>. </td> </tr> </table>
    ///    
    HRESULT SerializeWithOptions(SYNC_SERIALIZATION_VERSION targetFormatVersion, uint dwFlags, ubyte* pbBuffer, 
                                 uint* pdwSerializedSize);
}

///Represents additional information about a set of changes.
@GUID("0F1A4995-CBC8-421D-B550-5D0BEBF3E9A5")
interface ISyncChangeBatchAdvanced : IUnknown
{
    ///Gets the ISyncFilterInfo that was specified when the change batch was created.
    ///Params:
    ///    ppFilterInfo = Returns the <b>ISyncFilterInfo</b> that was specified when the change batch was created. <b>NULL</b>
    ///                   indicates that no filter was specified when the change batch was created.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> No filter was specified when the change batch was created. In this situation,
    ///    <b>NULL</b> is returned in <i>ppFilterInfo</i>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetFilterInfo(ISyncFilterInfo* ppFilterInfo);
    ///Converts an ISyncFullEnumerationChangeBatch object to an ISyncChangeBatch object.
    ///Params:
    ///    ppChangeBatch = Returns this change batch object, which is represented as an ISyncChangeBatch object.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> This change batch object is not an
    ///    ISyncFullEnumerationChangeBatch object. </td> </tr> </table>
    ///    
    HRESULT ConvertFullEnumerationChangeBatchToRegularChangeBatch(ISyncChangeBatch* ppChangeBatch);
    ///Gets the highest item ID that is represented in the knowledge of any group in the change batch.
    ///Params:
    ///    pbItemId = Returns the highest item ID that is represented in the knowledge of any group in the change batch.
    ///    pcbIdSize = Specifies the number of bytes in <i>pbItemId</i>. Returns the number of bytes that are necessary to retrieve
    ///                the ID when <i>pbItemId</i> is too small, or returns the number of bytes written.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt> </dl> </td> <td width="60%"> When <i>pbItemId</i> is too
    ///    small. In this situation, the required number of bytes is returned in <i>pcbIdSize</i>. </td> </tr> </table>
    ///    
    HRESULT GetUpperBoundItemId(ubyte* pbItemId, uint* pcbIdSize);
    ///Gets a value that indicates whether the learned knowledge for the batch must be saved after the batch is applied
    ///to the destination replica.
    ///Params:
    ///    pfBatchKnowledgeShouldBeApplied = Returns a value that indicates whether the learned knowledge for the batch must be saved after the batch is
    ///                                      applied to the destination replica.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_BATCH_NEEDS_KNOWLEDGE</b></dt> </dl> </td> <td width="60%"> The change batch contains no
    ///    changes and no knowledge. </td> </tr> </table>
    ///    
    HRESULT GetBatchLevelKnowledgeShouldBeApplied(int* pfBatchKnowledgeShouldBeApplied);
}

@GUID("225F4A33-F5EE-4CC7-B039-67A262B4B2AC")
interface ISyncChangeBatch2 : ISyncChangeBatch
{
    HRESULT AddMergeTombstoneMetadataToGroup(const(ubyte)* pbOwnerReplicaId, const(ubyte)* pbWinnerItemId, 
                                             const(ubyte)* pbItemId, const(SYNC_VERSION)* pChangeVersion, 
                                             const(SYNC_VERSION)* pCreationVersion, uint dwWorkForChange, 
                                             ISyncChangeBuilder* ppChangeBuilder);
    HRESULT AddMergeTombstoneLoggedConflict(const(ubyte)* pbOwnerReplicaId, const(ubyte)* pbWinnerItemId, 
                                            const(ubyte)* pbItemId, const(SYNC_VERSION)* pChangeVersion, 
                                            const(SYNC_VERSION)* pCreationVersion, uint dwWorkForChange, 
                                            ISyncKnowledge pConflictKnowledge, ISyncChangeBuilder* ppChangeBuilder);
}

@GUID("E06449F4-A205-4B65-9724-01B22101EEC1")
interface ISyncFullEnumerationChangeBatch2 : ISyncFullEnumerationChangeBatch
{
    HRESULT AddMergeTombstoneMetadataToGroup(const(ubyte)* pbOwnerReplicaId, const(ubyte)* pbWinnerItemId, 
                                             const(ubyte)* pbItemId, const(SYNC_VERSION)* pChangeVersion, 
                                             const(SYNC_VERSION)* pCreationVersion, uint dwWorkForChange, 
                                             ISyncChangeBuilder* ppChangeBuilder);
}

///Represents a synchronization provider that uses knowledge to perform synchronization.
@GUID("43434A49-8DA4-47F2-8172-AD7B8B024978")
interface IKnowledgeSyncProvider : ISyncProvider
{
    ///Notifies the provider that it is joining a synchronization session.
    ///Params:
    ///    role = The role of this provider, relative to the other provider in the session.
    ///    pSessionState = The current status of the corresponding session.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Provider-determined error codes</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT BeginSession(SYNC_PROVIDER_ROLE role, ISyncSessionState pSessionState);
    ///Gets the requested number of item changes that will be included in change batches, and the current knowledge for
    ///the synchronization scope.
    ///Params:
    ///    ppSyncKnowledge = Returns the current knowledge for the synchronization scope, or a newly created knowledge object if no
    ///                      current knowledge exists.
    ///    pdwRequestedBatchSize = Returns the requested number of item changes that will be included in change batches returned by the source
    ///                            provider.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Provider-determined error codes</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT GetSyncBatchParameters(ISyncKnowledge* ppSyncKnowledge, uint* pdwRequestedBatchSize);
    ///Gets a change batch that contains item metadata for items that are not contained in the specified knowledge from
    ///the destination provider.
    ///Params:
    ///    dwBatchSize = The requested number of changes to include in the change batch.
    ///    pSyncKnowledge = The knowledge from the destination provider. This knowledge must be mapped by calling
    ///                     ISyncKnowledge::MapRemoteToLocal on the source knowledge before it can be used for change enumeration.
    ///    ppSyncChangeBatch = Returns a change batch that contains item metadata for items that are not contained in <i>pSyncKnowledge</i>.
    ///    ppUnkDataRetriever = Returns an object that can be used to retrieve change data. It can be an ISynchronousDataRetriever object or
    ///                         a provider-specific object.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Provider-determined error codes</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT GetChangeBatch(uint dwBatchSize, ISyncKnowledge pSyncKnowledge, ISyncChangeBatch* ppSyncChangeBatch, 
                           IUnknown* ppUnkDataRetriever);
    ///Gets a change batch that contains item metadata for items that have IDs greater than the specified lower bound,
    ///as part of a full enumeration.
    ///Params:
    ///    dwBatchSize = The number of changes to include in the change batch.
    ///    pbLowerEnumerationBound = The lower bound for item IDs. This method returns changes that have IDs greater than or equal to this ID
    ///                              value.
    ///    pSyncKnowledge = If an item change is contained in this knowledge object, data for that item already exists on the destination
    ///                     replica.
    ///    ppSyncChangeBatch = Returns a change batch that contains item metadata for items that have IDs greater than the specified lower
    ///                        bound.
    ///    ppUnkDataRetriever = Returns an object that can be used to retrieve change data. It can be an ISynchronousDataRetriever object or
    ///                         a provider-specific object.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Provider-determined error codes</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT GetFullEnumerationChangeBatch(uint dwBatchSize, const(ubyte)* pbLowerEnumerationBound, 
                                          ISyncKnowledge pSyncKnowledge, 
                                          ISyncFullEnumerationChangeBatch* ppSyncChangeBatch, 
                                          IUnknown* ppUnkDataRetriever);
    ///Processes a set of changes by detecting conflicts and applying changes to the item store.
    ///Params:
    ///    resolutionPolicy = The conflict resolution policy to use when this method applies changes.
    ///    pSourceChangeBatch = A batch of changes from the source provider to be applied locally.
    ///    pUnkDataRetriever = An object that can be used to retrieve change data. It can be an ISynchronousDataRetriever object or a
    ///                        provider-specific object.
    ///    pCallback = An object that receives event notifications during change application.
    ///    pSyncSessionStatistics = Tracks change statistics. For a provider that uses custom change application, this object must be updated
    ///                             with the results of the change application.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Provider-determined error codes</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT ProcessChangeBatch(CONFLICT_RESOLUTION_POLICY resolutionPolicy, ISyncChangeBatch pSourceChangeBatch, 
                               IUnknown pUnkDataRetriever, ISyncCallback pCallback, 
                               SYNC_SESSION_STATISTICS* pSyncSessionStatistics);
    ///Processes a set of changes for a full enumeration by applying changes to the item store.
    ///Params:
    ///    resolutionPolicy = The conflict resolution policy to use when this method applies changes.
    ///    pSourceChangeBatch = A batch of changes from the source provider to be applied locally.
    ///    pUnkDataRetriever = An object that can be used to retrieve change data. It can be an <b>ISynchronousDataRetriever</b> object or a
    ///                        provider-specific object.
    ///    pCallback = An object that receives event notifications during change application.
    ///    pSyncSessionStatistics = Tracks change statistics. For a provider that uses custom change application, this object must be updated
    ///                             with the results of the change application.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Provider-determined error codes</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT ProcessFullEnumerationChangeBatch(CONFLICT_RESOLUTION_POLICY resolutionPolicy, 
                                              ISyncFullEnumerationChangeBatch pSourceChangeBatch, 
                                              IUnknown pUnkDataRetriever, ISyncCallback pCallback, 
                                              SYNC_SESSION_STATISTICS* pSyncSessionStatistics);
    ///Notifies the provider that a synchronization session to which it was enlisted has finished.
    ///Params:
    ///    pSessionState = The current status of the corresponding session.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Provider-determined error codes</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT EndSession(ISyncSessionState pSessionState);
}

///Represents a change to a change unit that is contained in an item.
@GUID("60EDD8CA-7341-4BB7-95CE-FAB6394B51CB")
interface ISyncChangeUnit : IUnknown
{
    ///Gets the item change that contains this change unit change.
    ///Params:
    ///    ppSyncChange = Returns the item change that contains this change unit change.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetItemChange(ISyncChange* ppSyncChange);
    ///Retrieves the ID for this change unit.
    ///Params:
    ///    pbChangeUnitId = Returns the ID of the change unit.
    ///    pcbIdSize = Specifies the number of bytes in <i>pbChangeUnitId</i>. Returns the number of bytes required to retrieve the
    ///                ID if <i>pbChangeUnitId</i> is too small, or returns the number of bytes written.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt> </dl> </td> <td width="60%"> <i>pbChangeUnitId</i> is too
    ///    small. In this case, the required number of bytes is returned in <i>pcbIdSize</i>. </td> </tr> </table>
    ///    
    HRESULT GetChangeUnitId(ubyte* pbChangeUnitId, uint* pcbIdSize);
    ///Gets the version for the change unit change.
    ///Params:
    ///    pbCurrentReplicaId = The ID of the replica that originated the change to retrieve.
    ///    pVersion = Returns the version of the change.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pbCurrentReplicaId</i> is not the correct
    ///    replica ID. </td> </tr> </table>
    ///    
    HRESULT GetChangeUnitVersion(const(ubyte)* pbCurrentReplicaId, SYNC_VERSION* pVersion);
}

///Enumerates a list of change units.
@GUID("346B35F1-8703-4C6D-AB1A-4DBCA2CFF97F")
interface IEnumSyncChangeUnits : IUnknown
{
    ///Returns the next change unit.
    ///Params:
    ///    cChanges = The number of change units to fetch. The only valid value is 1.
    ///    ppChangeUnit = Returns the next change unit object.
    ///    pcFetched = Returns the number of change units that are fetched.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"></td> </tr> </table>
    ///    
    HRESULT Next(uint cChanges, ISyncChangeUnit* ppChangeUnit, uint* pcFetched);
    ///This method is not implemented.
    ///Params:
    ///    cChanges = The number of change units to skip.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt>
    ///    </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT Skip(uint cChanges);
    ///Resets the enumerator to the beginning of the list.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Reset();
    ///This method is not implemented.
    ///Params:
    ///    ppEnum = Returns the cloned enumerator.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt>
    ///    </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT Clone(IEnumSyncChangeUnits* ppEnum);
}

///Represents a change to an item.
@GUID("A1952BEB-0F6B-4711-B136-01DA85B968A6")
interface ISyncChange : IUnknown
{
    ///Gets the ID of the replica that originated this change.
    ///Params:
    ///    pbReplicaId = Returns the ID of the replica that originated this change.
    ///    pcbIdSize = Specifies the number of bytes in <i>pbReplicaId</i>. Returns the number of bytes required to retrieve the ID
    ///                when <i>pbReplicaId</i> is too small, or returns the number of bytes written.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt> </dl> </td> <td width="60%"> <i>pbReplicaId</i> is too
    ///    small. In this case, the required number of bytes is returned in <i>pcbIdSize</i>. </td> </tr> </table>
    ///    
    HRESULT GetOwnerReplicaId(ubyte* pbReplicaId, uint* pcbIdSize);
    ///Gets the ID of the changed item.
    ///Params:
    ///    pbRootItemId = Returns the ID of the item.
    ///    pcbIdSize = Specifies the number of bytes in <i>pbRootItemId</i>. Returns the number of bytes required to retrieve the ID
    ///                when <i>pbRootItemId</i> is too small, or returns the number of bytes written.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt> </dl> </td> <td width="60%"> <i>pbRootItemId</i> is too
    ///    small. In this case, the required number of bytes is returned in <i>pcbIdSize</i>. </td> </tr> </table>
    ///    
    HRESULT GetRootItemId(ubyte* pbRootItemId, uint* pcbIdSize);
    ///Gets the version that is associated with this change.
    ///Params:
    ///    pbCurrentReplicaId = The ID of the replica that owns this change. The ID format must match the format that is specified by the
    ///                         ID_PARAMETERS property of the provider.
    ///    pVersion = Returns the change version of the item.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i> pbCurrentReplicaId</i> is not the correct
    ///    replica ID. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SYNC_E_ITEM_HAS_NO_VERSION_DATA</b></dt> </dl>
    ///    </td> <td width="60%"> The item has been forgotten. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_ID_FORMAT_MISMATCH</b></dt> </dl> </td> <td width="60%"> <i> pbCurrentReplicaId</i> is not in
    ///    the format that is specified by the ID format schema of the provider. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_ITEM_HAS_CHANGE_UNITS</b></dt> </dl> </td> <td width="60%"> The item has change units. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetChangeVersion(const(ubyte)* pbCurrentReplicaId, SYNC_VERSION* pVersion);
    ///Gets the creation version of the changed item.
    ///Params:
    ///    pbCurrentReplicaId = The ID of the replica that owns this change. The ID format must match the format that is specified by the
    ///                         ID_PARAMETERS property of the provider.
    ///    pVersion = Returns the creation version of the item.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i> pbCurrentReplicaId</i> is not the correct
    ///    replica ID. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SYNC_E_ID_FORMAT_MISMATCH</b></dt> </dl> </td> <td
    ///    width="60%"> <i> pbCurrentReplicaId</i> is not in the format that is specified by the ID format schema of the
    ///    provider. </td> </tr> </table>
    ///    
    HRESULT GetCreationVersion(const(ubyte)* pbCurrentReplicaId, SYNC_VERSION* pVersion);
    ///Gets flags that are associated with this change.
    ///Params:
    ///    pdwFlags = Returns the flags that are associated with this change. This will be a combination of <b>SYNC_CHANGE_FLAG</b>
    ///               values (See Remarks).
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetFlags(uint* pdwFlags);
    ///Gets the work estimate for this change.
    ///Params:
    ///    pdwWork = The work estimate for this change. The default value is zero.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetWorkEstimate(uint* pdwWork);
    ///Gets an object that can enumerate change units that are contained in this change.
    ///Params:
    ///    ppEnum = Returns a change unit enumerator. Returns <b>NULL</b> when this change does not contain change units.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_ITEM_HAS_NO_CHANGE_UNITS</b></dt> </dl> </td> <td width="60%"> The change contains no change
    ///    units. </td> </tr> </table>
    ///    
    HRESULT GetChangeUnits(IEnumSyncChangeUnits* ppEnum);
    ///Gets the made-with knowledge for this change.
    ///Params:
    ///    ppMadeWithKnowledge = Returns the made-with knowledge for this change. The made-with knowledge for a change is typically the
    ///                          knowledge that the replica had when this change was made. This knowledge is only meaningful when the
    ///                          <b>ISyncChange</b> object represents a change from the source provider.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_CHANGE_NEEDS_KNOWLEDGE</b></dt> </dl> </td> <td width="60%"> This item does not contain
    ///    made-with knowledge. </td> </tr> </table>
    ///    
    HRESULT GetMadeWithKnowledge(ISyncKnowledge* ppMadeWithKnowledge);
    ///Gets the knowledge that a replica will learn when this change is applied to its item store.
    ///Params:
    ///    ppLearnedKnowledge = Returns the knowledge that a replica will learn when this change is applied to its item store. This knowledge
    ///                         is valid only when the current knowledge of the replica contains the prerequisite knowledge of the change
    ///                         batch that contains this change. This knowledge is only meaningful when the <b>ISyncChange</b> object
    ///                         represents a change from the source provider.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> When <i> pbCurrentReplicaId</i> is not the correct
    ///    replica ID. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SYNC_E_CHANGE_NEEDS_KNOWLEDGE</b></dt> </dl> </td>
    ///    <td width="60%"> When the change has not been added to a change batch group or if the change batch group has
    ///    not been ended. </td> </tr> </table>
    ///    
    HRESULT GetLearnedKnowledge(ISyncKnowledge* ppLearnedKnowledge);
    ///Sets the work estimate for this change.
    ///Params:
    ///    dwWork = The work estimate for this change.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetWorkEstimate(uint dwWork);
}

///Represents metadata about a change that is based on the prerequisite knowledge that is associated with the change.
@GUID("9E38382F-1589-48C3-92E4-05ECDCB4F3F7")
interface ISyncChangeWithPrerequisite : IUnknown
{
    ///Gets the minimum knowledge that a destination provider is required to have to process this change.
    ///Params:
    ///    ppPrerequisiteKnowledge = The minimum knowledge that a destination provider is required to have to process this change.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> This object contains no prerequisite knowledge. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Invalid pointer. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetPrerequisiteKnowledge(ISyncKnowledge* ppPrerequisiteKnowledge);
    ///Gets the knowledge that the destination replica learns when the destination provider applies this change, based
    ///on the prerequisite knowledge that is associated with the change.
    ///Params:
    ///    pDestinationKnowledge = The knowledge of a change unit that is contained in this change is not added to the returned learned
    ///                            knowledge when <i>pDestinationKnowledge</i> contains the prerequisite knowledge for the change unit.
    ///    ppLearnedKnowledgeWithPrerequisite = The knowledge that the destination replica learns when the destination provider applies this change, based on
    ///                                         the prerequisite knowledge that is associated with the change.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There was not enough memory available to return
    ///    the knowledge. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SYNC_E_CHANGE_NEEDS_KNOWLEDGE</b></dt> </dl>
    ///    </td> <td width="60%"> This object does not contain prerequisite knowledge. </td> </tr> </table>
    ///    
    HRESULT GetLearnedKnowledgeWithPrerequisite(ISyncKnowledge pDestinationKnowledge, 
                                                ISyncKnowledge* ppLearnedKnowledgeWithPrerequisite);
}

///Represents additional information about an <b>ISyncChange</b> object during recovery synchronization.
@GUID("9785E0BD-BDFF-40C4-98C5-B34B2F1991B3")
interface ISyncFullEnumerationChange : IUnknown
{
    ///Gets the knowledge the destination replica will learn after it applies the changes in the full enumeration.
    ///Params:
    ///    ppLearnedKnowledge = The knowledge that the destination replica will learn after it applies this change during recovery
    ///                         synchronization.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_CHANGE_NEEDS_KNOWLEDGE</b></dt> </dl> </td> <td width="60%"> This change does not contain
    ///    made-with knowledge. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SYNC_E_INVALID_OPERATION</b></dt> </dl>
    ///    </td> <td width="60%"> Recovery synchronization is not in process. </td> </tr> </table>
    ///    
    HRESULT GetLearnedKnowledgeAfterRecoveryComplete(ISyncKnowledge* ppLearnedKnowledge);
    ///Gets the forgotten knowledge that the destination replica learns when the destination provider applies this
    ///change during recovery synchronization.
    ///Params:
    ///    ppLearnedForgottenKnowledge = The forgotten knowledge that the destination replica learns when the destination provider applies this change
    ///                                  during recovery synchronization.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> This object does not contain source forgotten knowledge. In this case,
    ///    <i>ppLearnedForgottenKnowledge</i> will return <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetLearnedForgottenKnowledge(IForgottenKnowledge* ppLearnedForgottenKnowledge);
}

@GUID("6EC62597-0903-484C-AD61-36D6E938F47B")
interface ISyncMergeTombstoneChange : IUnknown
{
    HRESULT GetWinnerItemId(ubyte* pbWinnerItemId, uint* pcbIdSize);
}

@GUID("43AA3F61-4B2E-4B60-83DF-B110D3E148F1")
interface IEnumItemIds : IUnknown
{
    HRESULT Next(ubyte* pbItemId, uint* pcbItemIdSize);
}

@GUID("CA169652-07C6-4708-A3DA-6E4EBA8D2297")
interface IFilterKeyMap : IUnknown
{
    HRESULT GetCount(uint* pdwCount);
    HRESULT AddFilter(ISyncFilter pISyncFilter, uint* pdwFilterKey);
    HRESULT GetFilter(uint dwFilterKey, ISyncFilter* ppISyncFilter);
    HRESULT Serialize(ubyte* pbFilterKeyMap, uint* pcbFilterKeyMap);
}

@GUID("BFE1EF00-E87D-42FD-A4E9-242D70414AEF")
interface ISyncChangeWithFilterKeyMap : IUnknown
{
    HRESULT GetFilterCount(uint* pdwFilterCount);
    HRESULT GetFilterChange(uint dwFilterKey, SYNC_FILTER_CHANGE* pFilterChange);
    HRESULT GetAllChangeUnitsPresentFlag(int* pfAllChangeUnitsPresent);
    HRESULT GetFilterForgottenKnowledge(uint dwFilterKey, ISyncKnowledge* ppIFilterForgottenKnowledge);
    HRESULT GetFilteredReplicaLearnedKnowledge(ISyncKnowledge pDestinationKnowledge, IEnumItemIds pNewMoveins, 
                                               ISyncKnowledge* ppLearnedKnowledge);
    HRESULT GetLearnedFilterForgottenKnowledge(ISyncKnowledge pDestinationKnowledge, IEnumItemIds pNewMoveins, 
                                               uint dwFilterKey, ISyncKnowledge* ppLearnedFilterForgottenKnowledge);
    HRESULT GetFilteredReplicaLearnedForgottenKnowledge(ISyncKnowledge pDestinationKnowledge, 
                                                        IEnumItemIds pNewMoveins, 
                                                        ISyncKnowledge* ppLearnedForgottenKnowledge);
    HRESULT GetFilteredReplicaLearnedForgottenKnowledgeAfterRecoveryComplete(ISyncKnowledge pDestinationKnowledge, 
                                                                             IEnumItemIds pNewMoveins, 
                                                                             ISyncKnowledge* ppLearnedForgottenKnowledge);
    HRESULT GetLearnedFilterForgottenKnowledgeAfterRecoveryComplete(ISyncKnowledge pDestinationKnowledge, 
                                                                    IEnumItemIds pNewMoveins, uint dwFilterKey, 
                                                                    ISyncKnowledge* ppLearnedFilterForgottenKnowledge);
}

@GUID("DE247002-566D-459A-A6ED-A5AAB3459FB7")
interface ISyncChangeBatchWithFilterKeyMap : IUnknown
{
    HRESULT GetFilterKeyMap(IFilterKeyMap* ppIFilterKeyMap);
    HRESULT SetFilterKeyMap(IFilterKeyMap pIFilterKeyMap);
    HRESULT SetFilterForgottenKnowledge(uint dwFilterKey, ISyncKnowledge pFilterForgottenKnowledge);
    HRESULT GetFilteredReplicaLearnedKnowledge(ISyncKnowledge pDestinationKnowledge, IEnumItemIds pNewMoveins, 
                                               ISyncKnowledge* ppLearnedForgottenKnowledge);
    HRESULT GetLearnedFilterForgottenKnowledge(ISyncKnowledge pDestinationKnowledge, IEnumItemIds pNewMoveins, 
                                               uint dwFilterKey, ISyncKnowledge* ppLearnedFilterForgottenKnowledge);
    HRESULT GetFilteredReplicaLearnedForgottenKnowledge(ISyncKnowledge pDestinationKnowledge, 
                                                        IEnumItemIds pNewMoveins, 
                                                        ISyncKnowledge* ppLearnedForgottenKnowledge);
    HRESULT GetFilteredReplicaLearnedForgottenKnowledgeAfterRecoveryComplete(ISyncKnowledge pDestinationKnowledge, 
                                                                             IEnumItemIds pNewMoveins, 
                                                                             ISyncKnowledge* ppLearnedForgottenKnowledge);
    HRESULT GetLearnedFilterForgottenKnowledgeAfterRecoveryComplete(ISyncKnowledge pDestinationKnowledge, 
                                                                    IEnumItemIds pNewMoveins, uint dwFilterKey, 
                                                                    ISyncKnowledge* ppLearnedFilterForgottenKnowledge);
}

///Represents methods that an <b>IAsynchronousDataRetriever</b> object can call to indicate that processing has been
///completed on an <b>IAsynchronousDataRetriever</b> method.
@GUID("71B4863B-F969-4676-BBC3-3D9FDC3FB2C7")
interface IDataRetrieverCallback : IUnknown
{
    ///Indicates that IAsynchronousDataRetriever::LoadChangeData has finished successfully.
    ///Params:
    ///    pUnkData = An object that can be used to access the data that was loaded by <b>LoadChangeData</b>.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT LoadChangeDataComplete(IUnknown pUnkData);
    ///Indicates that an <b>IAsynchronousDataRetriever</b> method failed.
    ///Params:
    ///    hrError = The error code that represents the reason for the failure.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT LoadChangeDataError(HRESULT hrError);
}

///Represents information about a change to be loaded from the item store.
@GUID("44A4AACA-EC39-46D5-B5C9-D633C0EE67E2")
interface ILoadChangeContext : IUnknown
{
    ///Gets the change item for which the change data should be retrieved from the item store.
    ///Params:
    ///    ppSyncChange = Returns the change item for which the change data should be retrieved from the item store.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_INTERNAL_ERROR</b></dt> </dl> </td> <td width="60%"> When an internal error occurs. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetSyncChange(ISyncChange* ppSyncChange);
    ///Indicates a recoverable error on this change has occurred.
    ///Params:
    ///    hrError = The error code that is associated with the error that prevented the item data from being loaded.
    ///    pErrorData = Additional information about the error.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>hrError</i> does not specify an error. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>SYNC_E_INTERNAL_ERROR</b></dt> </dl> </td> <td width="60%"> An
    ///    internal error has occurred. </td> </tr> </table>
    ///    
    HRESULT SetRecoverableErrorOnChange(HRESULT hrError, IRecoverableErrorData pErrorData);
    ///Indicates that a recoverable error occurred when data for the specified change unit was loaded from the item
    ///store.
    ///Params:
    ///    hrError = The error code that is associated with the error that prevented the change unit data from being loaded.
    ///    pChangeUnit = The change unit change that caused the error.
    ///    pErrorData = Additional information about the error.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>hrError</i> does not specify an error. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Invalid pointer.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SYNC_E_ON_CREATE_MUST_FAIL_ENTIRE_ITEM</b></dt> </dl> </td> <td
    ///    width="60%"> The change that contains this change unit refers to an item creation. In this case, the error
    ///    must be reported on the item change by using ILoadChangeContext::SetRecoverableErrorOnChange. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>SYNC_E_INTERNAL_ERROR</b></dt> </dl> </td> <td width="60%"> An internal
    ///    error has occurred. </td> </tr> </table>
    ///    
    HRESULT SetRecoverableErrorOnChangeUnit(HRESULT hrError, ISyncChangeUnit pChangeUnit, 
                                            IRecoverableErrorData pErrorData);
}

///Represents the mechanism by which the destination provider retrieves item data from the source provider.
@GUID("9B22F2A9-A4CD-4648-9D8E-3A510D4DA04B")
interface ISynchronousDataRetriever : IUnknown
{
    ///Gets the ID format schema of the provider.
    ///Params:
    ///    pIdParameters = Returns the ID format schema of the provider.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Provider-determined error codes.</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT GetIdParameters(ID_PARAMETERS* pIdParameters);
    ///Retrieves item data for a change.
    ///Params:
    ///    pLoadChangeContext = Metadata that describes the change for which data should be retrieved.
    ///    ppUnkData = Returns the item data for the change specified in <i>pLoadChangeContext</i>.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Provider-determined error codes.</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT LoadChangeData(ILoadChangeContext pLoadChangeContext, IUnknown* ppUnkData);
}

///Represents the mechanism by which the destination provider asynchronously retrieves item data from the source
///provider.
@GUID("9FC7E470-61EA-4A88-9BE4-DF56A27CFEF2")
interface IAsynchronousDataRetriever : IUnknown
{
    ///Gets the ID format schema of the provider.
    ///Params:
    ///    pIdParameters = Returns the ID format schema of the provider.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Provider-determined error codes.</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT GetIdParameters(ID_PARAMETERS* pIdParameters);
    ///Registers a callback interface that will be called by the <b>IAsynchronousDataRetriever</b> object when an
    ///asynchronous method finishes processing.
    ///Params:
    ///    pDataRetrieverCallback = The callback interface to register.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Provider-determined error codes.</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT RegisterCallback(IDataRetrieverCallback pDataRetrieverCallback);
    ///Indicates that the <b>IAsynchronousDataRetriever</b> object must no longer use the specified callback interface
    ///and must release any references to it.
    ///Params:
    ///    pDataRetrieverCallback = The callback interface to release.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Provider-determined error codes.</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT RevokeCallback(IDataRetrieverCallback pDataRetrieverCallback);
    ///Retrieves item data for a change.
    ///Params:
    ///    pLoadChangeContext = Metadata that describes the change for which data should be retrieved.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Provider-determined error codes.</b></dt> </dl> </td> <td width="60%"> See Remarks. </td> </tr>
    ///    </table>
    ///    
    HRESULT LoadChangeData(ILoadChangeContext pLoadChangeContext);
}

///Mediates filter negotiation between a destination provider and a source provider.
@GUID("82DF8873-6360-463A-A8A1-EDE5E1A1594D")
interface IFilterRequestCallback : IUnknown
{
    ///Requests that the filter that is specified by the destination provider be used by the source provider during
    ///change enumeration.
    ///Params:
    ///    pFilter = The filter that is specified by the destination provider. This filter is passed to the source provider to be
    ///              used during change enumeration.
    ///    filteringType = A FILTERING_TYPE enumeration value that indicates the type of information that is included in a change batch
    ///                    during filtered synchronization.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_FILTER_NOT_SUPPPORTED</b></dt> </dl> </td> <td width="60%"> When the filter that is specified
    ///    by <i>pFilter</i> is not supported by the source provider. This is also returned when the source provider
    ///    does not implement ISupportFilteredSync. </td> </tr> </table>
    ///    
    HRESULT RequestFilter(IUnknown pFilter, FILTERING_TYPE filteringType);
}

///When implemented by a derived class, represents a destination provider that can specify a filter to be used by the
///source provider during change enumeration.
@GUID("2E020184-6D18-46A7-A32A-DA4AEB06696C")
interface IRequestFilteredSync : IUnknown
{
    ///When implemented by a derived class, negotiates which filter is used by the source provider during change
    ///enumeration.
    ///Params:
    ///    pCallback = The callback interface that is used by the destination provider to request that a filter be used by the
    ///                source provider during change enumeration.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Provider-determined error codes.</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT SpecifyFilter(IFilterRequestCallback pCallback);
}

///When implemented by a derived class, represents a source provider that supports filtered change enumeration, and that
///can negotiate the type of filter that is used.
@GUID("3D128DED-D555-4E0D-BF4B-FB213A8A9302")
interface ISupportFilteredSync : IUnknown
{
    ///Sets the filter that is used for change enumeration by the source provider, when implemented by a derived class.
    ///Params:
    ///    pFilter = The filter that is used for change enumeration by the source provider.
    ///    filteringType = A FILTERING_TYPE enumeration value that indicates the type of information that is included in a change batch
    ///                    during filtered synchronization.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_FILTER_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> When the type of filter that is
    ///    specified by <i>pFilter</i> is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Provider-determined error codes.</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT AddFilter(IUnknown pFilter, FILTERING_TYPE filteringType);
}

@GUID("713CA7BB-C858-4674-B4B6-1122436587A9")
interface IFilterTrackingRequestCallback : IUnknown
{
    HRESULT RequestTrackedFilter(ISyncFilter pFilter);
}

@GUID("743383C0-FC4E-45BA-AD81-D9D84C7A24F8")
interface IFilterTrackingProvider : IUnknown
{
    HRESULT SpecifyTrackedFilters(IFilterTrackingRequestCallback pCallback);
    HRESULT AddTrackedFilter(ISyncFilter pFilter);
}

///Represents a synchronization provider that is able to report the date and time when an item or change unit was last
///changed. This ability is useful to an application that implements last-writer-wins conflict resolution.
@GUID("EADF816F-D0BD-43CA-8F40-5ACDC6C06F7A")
interface ISupportLastWriteTime : IUnknown
{
    ///Gets the date and time when the specified item was last changed.
    ///Params:
    ///    pbItemId = The ID of the item to look up.
    ///    pullTimestamp = The date and time when the specified item was last changed.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Provider-determined error codes</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT GetItemChangeTime(const(ubyte)* pbItemId, ulong* pullTimestamp);
    ///Gets the date and time when the specified change unit was last changed.
    ///Params:
    ///    pbItemId = The ID of the item that contains the change unit to look up.
    ///    pbChangeUnitId = The ID of the change unit to look up.
    ///    pullTimestamp = The date and time when the specified change unit was last changed.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Provider-determined error codes</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT GetChangeUnitChangeTime(const(ubyte)* pbItemId, const(ubyte)* pbChangeUnitId, ulong* pullTimestamp);
}

///When implemented by a derived class, represents an object that can convert an <b>ISyncProvider</b> object to an
///<b>IKnowledgeSyncProvider</b> object.
@GUID("809B7276-98CF-4957-93A5-0EBDD3DDDFFD")
interface IProviderConverter : IUnknown
{
    ///When implemented by a derived class, initializes the <b>IProviderConverter</b> object with the
    ///<b>ISyncProvider</b> object to be converted to <b>IKnowledgeSyncProvider</b>.
    ///Params:
    ///    pISyncProvider = The <b>ISyncProvider</b> object to be converted.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Converter-determined error codes.</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///    
    HRESULT Initialize(ISyncProvider pISyncProvider);
}

@GUID("435D4861-68D5-44AA-A0F9-72A0B00EF9CF")
interface ISyncDataConverter : IUnknown
{
    HRESULT ConvertDataRetrieverFromProviderFormat(IUnknown pUnkDataRetrieverIn, IEnumSyncChanges pEnumSyncChanges, 
                                                   IUnknown* ppUnkDataOut);
    HRESULT ConvertDataRetrieverToProviderFormat(IUnknown pUnkDataRetrieverIn, IEnumSyncChanges pEnumSyncChanges, 
                                                 IUnknown* ppUnkDataOut);
    HRESULT ConvertDataFromProviderFormat(ILoadChangeContext pDataContext, IUnknown pUnkDataIn, 
                                          IUnknown* ppUnkDataOut);
    HRESULT ConvertDataToProviderFormat(ILoadChangeContext pDataContext, IUnknown pUnkDataOut, 
                                        IUnknown* ppUnkDataout);
}

///Represents synchronization provider registration. This is the core registration interface that contains methods for
///creating, modifying, and enumerating registered synchronization providers and configuration UIs. This interface can
///be retrieved by calling <b>CoCreate</b>.
@GUID("CB45953B-7624-47BC-A472-EB8CAC6B222E")
interface ISyncProviderRegistration : IUnknown
{
    ///Creates an in-memory instance of a synchronization provider configuration UI.
    ///Params:
    ///    pConfigUIConfig = A SyncProviderConfigUIConfiguration structure that contains the configuration UI registration information.
    ///    ppConfigUIInfo = Returns a pointer to an ISyncProviderConfigUIInfo interface that is used to store the configuration UI’s UX
    ///                     elements and any necessary persisted configuration information.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_REGISTRATION_ALREADYREGISTERED </b></dt> </dl> </td> <td width="60%"> The same CLSID and
    ///    content type combination, or the same unique instance ID has already been registered for a configuration UI.
    ///    </td> </tr> </table>
    ///    
    HRESULT CreateSyncProviderConfigUIRegistrationInstance(const(SyncProviderConfigUIConfiguration)* pConfigUIConfig, 
                                                           ISyncProviderConfigUIInfo* ppConfigUIInfo);
    ///Unregisters and removes the specified synchronization provider configuration UI from the registration store.
    ///Params:
    ///    pguidInstanceId = The unique instance ID of the synchronization provider configuration UI.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_REGISTRATION_NOTREGISTERED </b></dt> </dl> </td> <td width="60%"> The CLSID and content type
    ///    combination does not exist in the registration store for a configuration UI. </td> </tr> </table>
    ///    
    HRESULT UnregisterSyncProviderConfigUI(GUID* pguidInstanceId);
    ///Returns an IEnumSyncProviderConfigUIInfos enumeration interface that enumerates all registered
    ///<b>ISyncProviderConfigUIInfo</b> objects for the specified criteria.
    ///Params:
    ///    pguidContentType = The LPCGUID of the specified content type. If this parameter is <b>NULL</b>, all content types will be
    ///                       enumerated.
    ///    dwSupportedArchitecture = One, or a combination of, the following flags that represent the architectures of the providers to be
    ///                              enumerated. If <b>SYNC_32_BIT_SUPPORTED</b> is specified, all providers that support 32 bits or 32 and 64
    ///                              bits will be enumerated. If <b>SYNC_32_BIT_SUPPORTED</b> | <b>SYNC_64_BIT_SUPPORTED</b> is specified, only
    ///                              those providers that support both 32 bits and 64 bits will be enumerated. <ul>
    ///                              <li><b>SYNC_32_BIT_SUPPORTED</b> ((DWORD)0x00000001)</li> <li><b>SYNC_64_BIT_SUPPORTED</b>
    ///                              ((DWORD)0x00000002)</li> </ul> If this parameter is set to zero, synchronization providers for all
    ///                              architectures will be enumerated.
    ///    ppEnumSyncProviderConfigUIInfos = A reference to an <b>IEnumSyncProviderConfigUIInfos</b>
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There was not enough memory available to register
    ///    the provider. </td> </tr> </table>
    ///    
    HRESULT EnumerateSyncProviderConfigUIs(GUID* pguidContentType, uint dwSupportedArchitecture, 
                                           IEnumSyncProviderConfigUIInfos* ppEnumSyncProviderConfigUIInfos);
    ///Creates an in-memory instance of a synchronization provider.
    ///Params:
    ///    pProviderConfiguration = A SyncProviderConfiguration structure that contains the synchronization provider registration information.
    ///    ppProviderInfo = Returns a pointer to an ISyncProviderInfo interface that is used to obtain information about the
    ///                     synchronization provider and access the configuration property store in order to store the synchronization
    ///                     provider configuration.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_REGISTRATION_ALREADYREGISTERED </b></dt> </dl> </td> <td width="60%"> The same unique instance
    ///    ID has already been registered for a synchronization provider. </td> </tr> </table>
    ///    
    HRESULT CreateSyncProviderRegistrationInstance(const(SyncProviderConfiguration)* pProviderConfiguration, 
                                                   ISyncProviderInfo* ppProviderInfo);
    ///Unregisters and removes the specified synchronization provider from the registration store.
    ///Params:
    ///    pguidInstanceId = The unique instance ID of the synchronization provider.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_REGISTRATION_NOTREGISTERED </b></dt> </dl> </td> <td width="60%"> A synchronization provider
    ///    with the specified instance ID is not currently registered. </td> </tr> </table>
    ///    
    HRESULT UnregisterSyncProvider(GUID* pguidInstanceId);
    ///Returns an ISyncProviderConfigUIInfo object for the specified synchronization provider instance ID.
    ///Params:
    ///    pguidProviderInstanceId = The unique instance ID of the synchronization provider.
    ///    ppProviderConfigUIInfo = The configuration UI information object.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> No configuration UI was specified for the synchronization provider. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Invalid pointer. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There was not
    ///    enough memory available to return the synchronization provider. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_REGISTRATION_NOTREGISTERED </b></dt> </dl> </td> <td width="60%"> The specified instance ID
    ///    does not match a registered synchronization provider, or the requested configuration UI is not registered.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetSyncProviderConfigUIInfoforProvider(GUID* pguidProviderInstanceId, 
                                                   ISyncProviderConfigUIInfo* ppProviderConfigUIInfo);
    ///Returns an IEnumSyncProviderInfos enumeration interface that enumerates all registered <b>ISyncProviderInfo</b>
    ///objects for the specified criteria.
    ///Params:
    ///    pguidContentType = The LPCGUID of the specified content type. If this parameter is <b>NULL</b>, all content types will be
    ///                       enumerated.
    ///    dwStateFlagsToFilterMask = A synchronization provider state flag that can be used to mask (preserve or remove) the existing state. If
    ///                               this parameter is set to zero, all synchronization provider states will be enumerated. See the
    ///                               <i>dwStateFlagsToFilter</i> parameter description for a list of flags.
    ///    dwStateFlagsToFilter = One of the following flags that represent the synchronization provider state. <ul>
    ///                           <li><b>SYNC_PROVIDER_STATE_ENABLED</b> ((DWORD)0x00000001)The provider is enabled and available for
    ///                           synchronization. </li> <li><b>SYNC_PROVIDER_STATE_DIRTY</b> ((DWORD)0x00000002)The active provider has been
    ///                           updated and has new data to synchronize. </li> </ul> If this parameter is set to zero, all synchronization
    ///                           provider states will be enumerated.
    ///    refProviderClsId = The REFCLSID of a particular provider. If this parameter is set to <b>CLSID_NULL</b>, all providers will be
    ///                       enumerated.
    ///    dwSupportedArchitecture = One, or a combination of, the following flags that represent the architectures of the providers to be
    ///                              enumerated. If <b>SYNC_32_BIT_SUPPORTED</b> is specified, all providers that support 32 bits or 32 and 64
    ///                              bits will be enumerated. If <b>SYNC_32_BIT_SUPPORTED</b> | <b>SYNC_64_BIT_SUPPORTED</b> is specified, only
    ///                              those providers that support both 32 bits and 64 bits will be enumerated. <ul>
    ///                              <li><b>SYNC_32_BIT_SUPPORTED</b> ((DWORD)0x00000001)</li> <li><b>SYNC_64_BIT_SUPPORTED</b>
    ///                              ((DWORD)0x00000002)</li> </ul> If this parameter is set to zero, synchronization providers for all
    ///                              architectures will be enumerated.
    ///    ppEnumSyncProviderInfos = The <b>IEnumSyncProviderInfos</b> enumeration interface that will enumerate all <b>ISyncProviderInfo</b>
    ///                              objects that match the specified criteria.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There was not enough memory available to return
    ///    the enumeration interface. </td> </tr> </table>
    ///    
    HRESULT EnumerateSyncProviders(GUID* pguidContentType, uint dwStateFlagsToFilterMask, 
                                   uint dwStateFlagsToFilter, const(GUID)* refProviderClsId, 
                                   uint dwSupportedArchitecture, IEnumSyncProviderInfos* ppEnumSyncProviderInfos);
    ///Returns an ISyncProviderInfo object for the specific synchronization provider instance ID.
    ///Params:
    ///    pguidInstanceId = The unique instance ID of the synchronization provider.
    ///    ppProviderInfo = The synchronization provider information object.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_REGISTRATION_NOTREGISTERED </b></dt> </dl> </td> <td width="60%"> The specified instance ID
    ///    does not match a registered synchronization provider. </td> </tr> </table>
    ///    
    HRESULT GetSyncProviderInfo(GUID* pguidInstanceId, ISyncProviderInfo* ppProviderInfo);
    ///Returns an initialized and instantiated IRegisteredSyncProvider object for the specific unique instance ID.
    ///Params:
    ///    pguidInstanceId = The unique instance ID of the <b>IRegisteredSyncProvider</b> object.
    ///    dwClsContext = The context in which the code that manages the newly created object will run. The only context supported is
    ///                   <b>CLSCTX_INPROC_SERVER</b>.
    ///    ppSyncProvider = The initialized and instantiated synchronization provider object.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The instance ID is <b>GUID_NULL</b>. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There was not enough
    ///    memory available to create the synchronization provider. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>REGDB_E_CLASSNOTREG</b></dt> </dl> </td> <td width="60%"> The synchronization provider’s CLSID is
    ///    not registered with the requested context or the provider has not had its DLL registered. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>SYNC_E_REGISTRATION_NOTREGISTERED </b></dt> </dl> </td> <td width="60%"> A
    ///    synchronization provider with the specified instance ID was not registered. </td> </tr> </table>
    ///    
    HRESULT GetSyncProviderFromInstanceId(GUID* pguidInstanceId, uint dwClsContext, 
                                          IRegisteredSyncProvider* ppSyncProvider);
    ///Returns an ISyncProviderConfigUIInfo object for the given unique instance ID.
    ///Params:
    ///    pguidInstanceId = The unique instance ID of the <b>ISyncProviderConfigUIInfo</b> object.
    ///    ppConfigUIInfo = The configuration UI information object.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There was not enough memory available to return
    ///    the configuration UI. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SYNC_E_REGISTRATION_NOTREGISTERED
    ///    </b></dt> </dl> </td> <td width="60%"> A configuration UI with the specified instance ID was not registered.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetSyncProviderConfigUIInfo(GUID* pguidInstanceId, ISyncProviderConfigUIInfo* ppConfigUIInfo);
    ///Returns an initialized and instantiated ISyncProviderConfigUI object for the given unique instance ID.
    ///Params:
    ///    pguidInstanceId = The unique instance ID of the <b>ISyncProviderConfigUI</b> object.
    ///    dwClsContext = The context in which the code that manages the newly created object will run. The only context supported is
    ///                   <b>CLSCTX_INPROC_SERVER</b>.
    ///    ppConfigUI = The initialized and instantiated configuration UI object.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The instance ID is <b>GUID_NULL</b>. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There was not enough
    ///    memory available to create the configuration UI. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>REGDB_E_CLASSNOTREG</b></dt> </dl> </td> <td width="60%"> The synchronization provider’s CLSID is
    ///    not registered with the requested context or the configuration UI has not had its DLL registered. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>SYNC_E_REGISTRATION_NOTREGISTERED </b></dt> </dl> </td> <td width="60%"> A
    ///    configuration UI with the specified instance ID was not registered. </td> </tr> </table>
    ///    
    HRESULT GetSyncProviderConfigUIFromInstanceId(GUID* pguidInstanceId, uint dwClsContext, 
                                                  ISyncProviderConfigUI* ppConfigUI);
    ///Returns the state of the specified synchronization provider.
    ///Params:
    ///    pguidInstanceId = The unique instance ID of the synchronization provider.
    ///    pdwStateFlags = One of the following flags that represent the synchronization provider state. <ul>
    ///                    <li><b>SYNC_PROVIDER_STATE_ENABLED</b> ((DWORD)0x00000001)The provider is enabled and available for
    ///                    synchronization. </li> <li><b>SYNC_PROVIDER_STATE_DIRTY</b> ((DWORD)0x00000002)The active provider has been
    ///                    updated and has new data to synchronize. </li> </ul>
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_REGISTRATION_NOTREGISTERED </b></dt> </dl> </td> <td width="60%"> A synchronization provider
    ///    with the specified instance ID was not registered. </td> </tr> </table>
    ///    
    HRESULT GetSyncProviderState(GUID* pguidInstanceId, uint* pdwStateFlags);
    ///Sets the state of the specified synchronization provider.
    ///Params:
    ///    pguidInstanceId = The unique instance ID of the synchronization provider.
    ///    dwStateFlagsMask = A synchronization provider state flag that can be used to mask (preserve or remove) the existing state. If
    ///                       this parameter is set to zero, all synchronization provider states will be enumerated. See the
    ///                       <i>dwStateFlags</i> parameter description for a list of flags.
    ///    dwStateFlags = One of the following flags that represent the synchronization provider state. <ul>
    ///                   <li><b>SYNC_PROVIDER_STATE_ENABLED</b> ((DWORD)0x00000001)The provider is enabled and available for
    ///                   synchronization. </li> <li><b>SYNC_PROVIDER_STATE_DIRTY</b> ((DWORD)0x00000002)The active provider has been
    ///                   updated and has new data to synchronize. </li> </ul> If this parameter is set to zero, all synchronization
    ///                   provider states will be enumerated.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SYNC_E_REGISTRATION_NOTREGISTERED </b></dt> </dl> </td> <td width="60%"> A synchronization provider
    ///    with the specified instance ID was not registered. </td> </tr> </table>
    ///    
    HRESULT SetSyncProviderState(GUID* pguidInstanceId, uint dwStateFlagsMask, uint dwStateFlags);
    ///Registers the user to receive notification of the arrival of new registration events that oocur when changes are
    ///made to the registration store.
    ///Params:
    ///    phEvent = A <b>HANDLE</b> to a synchronization event that is used to notify the caller about the arrival of new
    ///              registration events. <div class="alert"><b>Note</b> The caller must not <b>Close</b> the returned
    ///              <b>HANDLE</b>. The registration store will manage the memory for the <b>HANDLE</b> and will close it when the
    ///              event is revoked by passing the <b>HANDLE</b> to RevokeEvent, or before the store object is freed from
    ///              memory.</div> <div> </div>
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT RegisterForEvent(HANDLE* phEvent);
    ///Unregisters the user from the notification of the arrival of new registration events.
    ///Params:
    ///    hEvent = The <b>HANDLE</b> returned by the RegisterForEvent method.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The specified event has not been registered. </td>
    ///    </tr> </table>
    ///    
    HRESULT RevokeEvent(HANDLE hEvent);
    ///Gets an ISyncRegistrationChange object that represents a new registration event.
    ///Params:
    ///    hEvent = A <b>HANDLE</b> returned by the RegisterForEvent method.
    ///    ppChange = The ISyncRegistrationChange object that contains the event, and the ID of the synchronization provider or
    ///               synchronization provider configuration UI that has changed.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> All outstanding events have been retrieved. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetChange(HANDLE hEvent, ISyncRegistrationChange* ppChange);
}

///Enumerates ISyncProviderConfigUIInfo objects that contain configuration UI information used to build and register a
///synchronization provider.
@GUID("F6BE2602-17C6-4658-A2D7-68ED3330F641")
interface IEnumSyncProviderConfigUIInfos : IUnknown
{
    ///Returns the next <b>ISyncProviderConfigUIInfo</b> object.
    ///Params:
    ///    cFactories = The number of <b>ISyncProviderConfigUIInfo</b> objects to retrieve in the range of zero to 1.
    ///    ppSyncProviderConfigUIInfo = Returns the next <i>pcFetched</i><b>ISyncProviderConfigUIInfo</b> objects.
    ///    pcFetched = Returns the number of <b>ISyncProviderConfigUIInfo</b> objects that are retrieved.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> The requested number of objects was not available. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There was not enough memory
    ///    available to return the next <b>ISyncProviderConfigUIInfo</b> object. </td> </tr> </table>
    ///    
    HRESULT Next(uint cFactories, char* ppSyncProviderConfigUIInfo, uint* pcFetched);
    ///Skips the specified number of <b>ISyncProviderConfigUIInfo</b> objects.
    ///Params:
    ///    cFactories = The number of <b>ISyncProviderConfigUIInfo</b> objects to skip.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> The end of the collection was reached before the specified number of items was
    ///    skipped. </td> </tr> </table>
    ///    
    HRESULT Skip(uint cFactories);
    ///Resets the enumerator to the beginning of the collection of <b>ISyncProviderConfigUIInfo</b> objects.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Reset();
    ///Clones the enumerator and returns a new enumerator that is in the same state as the current one.
    ///Params:
    ///    ppEnum = Returns the newly cloned enumerator.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There was not enough memory available to clone the
    ///    enumerator. </td> </tr> </table>
    ///    
    HRESULT Clone(IEnumSyncProviderConfigUIInfos* ppEnum);
}

///Enumerates ISyncProviderInfo objects that contain the information used to create an instance of a synchronization
///provider.
@GUID("A04BA850-5EB1-460D-A973-393FCB608A11")
interface IEnumSyncProviderInfos : IUnknown
{
    ///Returns the next <b>ISyncProviderInfo</b> object.
    ///Params:
    ///    cInstances = The number of <b>ISyncProviderInfo</b> objects to retrieve in the range of zero to 1.
    ///    ppSyncProviderInfo = Returns the next <i>pcFetched</i><b>ISyncProviderInfo</b> objects.
    ///    pcFetched = Returns the number of <b>ISyncProviderInfo</b> objects that are retrieved.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> The requested number of objects was not available. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There was not enough memory
    ///    available to return the next <b>ISyncProviderInfo</b> object. </td> </tr> </table>
    ///    
    HRESULT Next(uint cInstances, char* ppSyncProviderInfo, uint* pcFetched);
    ///Skips the specified number of <b>ISyncProviderInfo</b> objects.
    ///Params:
    ///    cInstances = The number of <b>ISyncProviderInfo</b> objects to skip.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> The end of the collection was reached before the specified number of items was
    ///    skipped. </td> </tr> </table>
    ///    
    HRESULT Skip(uint cInstances);
    ///Resets the enumerator to the beginning of the <b>ISyncProviderInfo</b> set.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Reset();
    ///Clones the enumerator and returns a new enumerator that is in the same state as the current one.
    ///Params:
    ///    ppEnum = Returns the newly cloned enumerator.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There was not enough memory available to clone the
    ///    enumerator. </td> </tr> </table>
    ///    
    HRESULT Clone(IEnumSyncProviderInfos* ppEnum);
}

///Represents the information and properties needed to create an instance of a synchronization provider.
@GUID("1EE135DE-88A4-4504-B0D0-F7920D7E5BA6")
interface ISyncProviderInfo : IPropertyStore
{
    ///Creates an instance of the synchronization provider.
    ///Params:
    ///    dwClsContext = The context in which the code that manages the newly created object will run. The only context supported is
    ///                   <b>CLSCTX_INPROC_SERVER</b>.
    ///    ppSyncProvider = The instance of the synchronization provider.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There was not enough memory available to create
    ///    the synchronization provider. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_DATA)</b></dt> </dl> </td> <td width="60%"> Information stored in the
    ///    registration store is an unexpected size. </td> </tr> </table>
    ///    
    HRESULT GetSyncProvider(uint dwClsContext, IRegisteredSyncProvider* ppSyncProvider);
}

///Represents the information and properties needed to create an instance of a synchronization provider configuration
///UI.
@GUID("214141AE-33D7-4D8D-8E37-F227E880CE50")
interface ISyncProviderConfigUIInfo : IPropertyStore
{
    ///Creates an instance of a synchronization provider configuration UI.
    ///Params:
    ///    dwClsContext = The context in which the code that manages the newly created object will run. The only context supported is
    ///                   <b>CLSCTX_INPROC_SERVER</b>.
    ///    ppSyncProviderConfigUI = The instance of the synchronization provider configuration UI.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There was not enough memory available to create
    ///    the configuration UI. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_DATA)</b></dt> </dl> </td> <td width="60%"> Information stored in the
    ///    registration store is an unexpected size. </td> </tr> </table>
    ///    
    HRESULT GetSyncProviderConfigUI(uint dwClsContext, ISyncProviderConfigUI* ppSyncProviderConfigUI);
}

///Represents configuration UI information used to build and register a synchronization provider.
@GUID("7B0705F6-CBCD-4071-AB05-3BDC364D4A0C")
interface ISyncProviderConfigUI : IUnknown
{
    ///Initializes the configuration UI for a synchronization provider.
    ///Params:
    ///    pguidInstanceId = The instance ID of the configuration UI.
    ///    pguidContentType = A GUID that represents the content type that is associated with the synchronization provider that this
    ///                       configuration UI will create.
    ///    pConfigurationProperties = The properties that should be specified when the configuration UI is registering the synchronization
    ///                               provider. These properties are also used to properly initialize the configuration UI object.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Init(GUID* pguidInstanceId, GUID* pguidContentType, IPropertyStore pConfigurationProperties);
    ///Obtains configuration UI properties for reading and writing.
    ///Params:
    ///    ppConfigUIProperties = Returns the <b>IPropertyStore</b> object that contains the configuration UI properties for reading and
    ///                           writing. Both the ISyncProviderInfo and ISyncProviderConfigUIInfo interfaces inherit from
    ///                           <b>IPropertyStore</b>.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetRegisteredProperties(IPropertyStore* ppConfigUIProperties);
    ///Creates and registers a new synchronization provider.
    ///Params:
    ///    hwndParent = HWND serving as the parent for the configuration UI that needs to be presented before the synchronization
    ///                 provider can be created. The HWND should be <b>NULL</b> only if the <b>dwCapabilities</b> member of the
    ///                 SyncProviderConfigUIConfiguration structure is set to not support a UI.
    ///    pUnkContext = Pointer to an interface containing additional information needed to generate the synchronization provider.
    ///                  The pointer will be <b>NULL</b> if no additional information is needed.
    ///    ppProviderInfo = An ISyncProviderInfo object that contains information about the newly created and registered synchronization
    ///                     provider.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There was not enough memory available to create
    ///    and register the synchronization provider. </td> </tr> </table>
    ///    
    HRESULT CreateAndRegisterNewSyncProvider(HWND hwndParent, IUnknown pUnkContext, 
                                             ISyncProviderInfo* ppProviderInfo);
    ///Updates the ISyncProviderInfo of the synchronization provider that is configured by this
    ///<b>ISyncProviderConfigUI</b>.
    ///Params:
    ///    hwndParent = HWND serving as the parent for the configuration UI that needs to be presented before the synchronization
    ///                 provider can be created. The HWND should be <b>NULL</b> only if the <b>dwCapabilities</b> member of the
    ///                 SyncProviderConfigUIConfiguration structure is set to not support a UI.
    ///    pUnkContext = Pointer to an interface containing additional information needed to generate the synchronization provider.
    ///                  The pointer will be <b>NULL</b> if no additional information is needed.
    ///    pProviderInfo = An ISyncProviderInfo that provides information about the synchronization provider that is being modified.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT ModifySyncProvider(HWND hwndParent, IUnknown pUnkContext, ISyncProviderInfo pProviderInfo);
}

///Represents a registered synchronization provider. This interface is implemented by the writer of a synchronization
///provider.
@GUID("913BCF76-47C1-40B5-A896-5E8A9C414C14")
interface IRegisteredSyncProvider : IUnknown
{
    ///Initializes the synchronization provider before it is ready for a synchronization session.
    ///Params:
    ///    pguidInstanceId = The instance ID of the synchronization provider.
    ///    pguidContentType = A GUID that represents the content type that this provider will synchronize.
    ///    pContextPropertyStore = The properties needed to initialize the synchronization provider. These properties are also provided when the
    ///                            synchronization provider is registered.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Init(GUID* pguidInstanceId, GUID* pguidContentType, IPropertyStore pContextPropertyStore);
    ///Returns the synchronization provider's instance ID.
    ///Params:
    ///    pguidInstanceId = The instance ID of the synchronization provider.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetInstanceId(GUID* pguidInstanceId);
    ///Resets a synchronization provider so that it looks like a new replica in the next synchronization session.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Reset();
}

///Represents a change to the registration of a synchronization provider or a synchronization provider configuration UI.
///The changes are reported as registration events.
@GUID("EEA0D9AE-6B29-43B4-9E70-E3AE33BB2C3B")
interface ISyncRegistrationChange : IUnknown
{
    ///Gets the next pending registration event.
    ///Params:
    ///    psreEvent = The registration event.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetEvent(SYNC_REGISTRATION_EVENT* psreEvent);
    ///Gets the instance ID of the synchronization provider or synchronization provider configuration UI associated with
    ///the event.
    ///Params:
    ///    pguidInstanceId = The instance ID.
    ///Returns:
    ///    The possible return codes include, but are not limited to, the values shown in the following table. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetInstanceId(GUID* pguidInstanceId);
}


// GUIDs

const GUID CLSID_SyncProviderRegistration = GUIDOF!SyncProviderRegistration;

const GUID IID_IAsynchronousDataRetriever       = GUIDOF!IAsynchronousDataRetriever;
const GUID IID_IChangeConflict                  = GUIDOF!IChangeConflict;
const GUID IID_IChangeUnitException             = GUIDOF!IChangeUnitException;
const GUID IID_IChangeUnitListFilterInfo        = GUIDOF!IChangeUnitListFilterInfo;
const GUID IID_IClockVector                     = GUIDOF!IClockVector;
const GUID IID_IClockVectorElement              = GUIDOF!IClockVectorElement;
const GUID IID_ICombinedFilterInfo              = GUIDOF!ICombinedFilterInfo;
const GUID IID_IConstraintConflict              = GUIDOF!IConstraintConflict;
const GUID IID_IConstructReplicaKeyMap          = GUIDOF!IConstructReplicaKeyMap;
const GUID IID_ICoreFragment                    = GUIDOF!ICoreFragment;
const GUID IID_ICoreFragmentInspector           = GUIDOF!ICoreFragmentInspector;
const GUID IID_ICustomFilterInfo                = GUIDOF!ICustomFilterInfo;
const GUID IID_IDataRetrieverCallback           = GUIDOF!IDataRetrieverCallback;
const GUID IID_IEnumChangeUnitExceptions        = GUIDOF!IEnumChangeUnitExceptions;
const GUID IID_IEnumClockVector                 = GUIDOF!IEnumClockVector;
const GUID IID_IEnumFeedClockVector             = GUIDOF!IEnumFeedClockVector;
const GUID IID_IEnumItemIds                     = GUIDOF!IEnumItemIds;
const GUID IID_IEnumRangeExceptions             = GUIDOF!IEnumRangeExceptions;
const GUID IID_IEnumSingleItemExceptions        = GUIDOF!IEnumSingleItemExceptions;
const GUID IID_IEnumSyncChangeUnits             = GUIDOF!IEnumSyncChangeUnits;
const GUID IID_IEnumSyncChanges                 = GUIDOF!IEnumSyncChanges;
const GUID IID_IEnumSyncProviderConfigUIInfos   = GUIDOF!IEnumSyncProviderConfigUIInfos;
const GUID IID_IEnumSyncProviderInfos           = GUIDOF!IEnumSyncProviderInfos;
const GUID IID_IFeedClockVector                 = GUIDOF!IFeedClockVector;
const GUID IID_IFeedClockVectorElement          = GUIDOF!IFeedClockVectorElement;
const GUID IID_IFilterKeyMap                    = GUIDOF!IFilterKeyMap;
const GUID IID_IFilterRequestCallback           = GUIDOF!IFilterRequestCallback;
const GUID IID_IFilterTrackingProvider          = GUIDOF!IFilterTrackingProvider;
const GUID IID_IFilterTrackingRequestCallback   = GUIDOF!IFilterTrackingRequestCallback;
const GUID IID_IFilterTrackingSyncChangeBuilder = GUIDOF!IFilterTrackingSyncChangeBuilder;
const GUID IID_IForgottenKnowledge              = GUIDOF!IForgottenKnowledge;
const GUID IID_IKnowledgeSyncProvider           = GUIDOF!IKnowledgeSyncProvider;
const GUID IID_ILoadChangeContext               = GUIDOF!ILoadChangeContext;
const GUID IID_IProviderConverter               = GUIDOF!IProviderConverter;
const GUID IID_IRangeException                  = GUIDOF!IRangeException;
const GUID IID_IRecoverableError                = GUIDOF!IRecoverableError;
const GUID IID_IRecoverableErrorData            = GUIDOF!IRecoverableErrorData;
const GUID IID_IRegisteredSyncProvider          = GUIDOF!IRegisteredSyncProvider;
const GUID IID_IReplicaKeyMap                   = GUIDOF!IReplicaKeyMap;
const GUID IID_IRequestFilteredSync             = GUIDOF!IRequestFilteredSync;
const GUID IID_ISingleItemException             = GUIDOF!ISingleItemException;
const GUID IID_ISupportFilteredSync             = GUIDOF!ISupportFilteredSync;
const GUID IID_ISupportLastWriteTime            = GUIDOF!ISupportLastWriteTime;
const GUID IID_ISyncCallback                    = GUIDOF!ISyncCallback;
const GUID IID_ISyncCallback2                   = GUIDOF!ISyncCallback2;
const GUID IID_ISyncChange                      = GUIDOF!ISyncChange;
const GUID IID_ISyncChangeBatch                 = GUIDOF!ISyncChangeBatch;
const GUID IID_ISyncChangeBatch2                = GUIDOF!ISyncChangeBatch2;
const GUID IID_ISyncChangeBatchAdvanced         = GUIDOF!ISyncChangeBatchAdvanced;
const GUID IID_ISyncChangeBatchBase             = GUIDOF!ISyncChangeBatchBase;
const GUID IID_ISyncChangeBatchBase2            = GUIDOF!ISyncChangeBatchBase2;
const GUID IID_ISyncChangeBatchWithFilterKeyMap = GUIDOF!ISyncChangeBatchWithFilterKeyMap;
const GUID IID_ISyncChangeBatchWithPrerequisite = GUIDOF!ISyncChangeBatchWithPrerequisite;
const GUID IID_ISyncChangeBuilder               = GUIDOF!ISyncChangeBuilder;
const GUID IID_ISyncChangeUnit                  = GUIDOF!ISyncChangeUnit;
const GUID IID_ISyncChangeWithFilterKeyMap      = GUIDOF!ISyncChangeWithFilterKeyMap;
const GUID IID_ISyncChangeWithPrerequisite      = GUIDOF!ISyncChangeWithPrerequisite;
const GUID IID_ISyncConstraintCallback          = GUIDOF!ISyncConstraintCallback;
const GUID IID_ISyncDataConverter               = GUIDOF!ISyncDataConverter;
const GUID IID_ISyncFilter                      = GUIDOF!ISyncFilter;
const GUID IID_ISyncFilterDeserializer          = GUIDOF!ISyncFilterDeserializer;
const GUID IID_ISyncFilterInfo                  = GUIDOF!ISyncFilterInfo;
const GUID IID_ISyncFilterInfo2                 = GUIDOF!ISyncFilterInfo2;
const GUID IID_ISyncFullEnumerationChange       = GUIDOF!ISyncFullEnumerationChange;
const GUID IID_ISyncFullEnumerationChangeBatch  = GUIDOF!ISyncFullEnumerationChangeBatch;
const GUID IID_ISyncFullEnumerationChangeBatch2 = GUIDOF!ISyncFullEnumerationChangeBatch2;
const GUID IID_ISyncKnowledge                   = GUIDOF!ISyncKnowledge;
const GUID IID_ISyncKnowledge2                  = GUIDOF!ISyncKnowledge2;
const GUID IID_ISyncMergeTombstoneChange        = GUIDOF!ISyncMergeTombstoneChange;
const GUID IID_ISyncProvider                    = GUIDOF!ISyncProvider;
const GUID IID_ISyncProviderConfigUI            = GUIDOF!ISyncProviderConfigUI;
const GUID IID_ISyncProviderConfigUIInfo        = GUIDOF!ISyncProviderConfigUIInfo;
const GUID IID_ISyncProviderInfo                = GUIDOF!ISyncProviderInfo;
const GUID IID_ISyncProviderRegistration        = GUIDOF!ISyncProviderRegistration;
const GUID IID_ISyncRegistrationChange          = GUIDOF!ISyncRegistrationChange;
const GUID IID_ISyncSessionExtendedErrorInfo    = GUIDOF!ISyncSessionExtendedErrorInfo;
const GUID IID_ISyncSessionState                = GUIDOF!ISyncSessionState;
const GUID IID_ISyncSessionState2               = GUIDOF!ISyncSessionState2;
const GUID IID_ISynchronousDataRetriever        = GUIDOF!ISynchronousDataRetriever;
