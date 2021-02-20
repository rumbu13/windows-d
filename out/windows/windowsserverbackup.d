// Written in the D programming language.

module windows.windowsserverbackup;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : PWSTR;

extern(Windows) @nogc nothrow:


// Enums


///The <b>WSB_OB_STATUS_ENTRY_PAIR_TYPE</b> enumeration indicates the type of the parameter value contained in the
///WSB_OB_STATUS_ENTRY_VALUE_TYPE_PAIR structure.
alias WSB_OB_STATUS_ENTRY_PAIR_TYPE = int;
enum : int
{
    ///The value type is undefined.
    WSB_OB_ET_UNDEFINED = 0x00000000,
    ///The value type is string.
    WSB_OB_ET_STRING    = 0x00000001,
    ///The value type is integer.
    WSB_OB_ET_NUMBER    = 0x00000002,
    ///The value type is datetime which represents an instant in time, typically expressed as a date and time of day.
    ///All time-related values are specified in Coordinated Universal Time (UTC) format.
    WSB_OB_ET_DATETIME  = 0x00000003,
    ///The value type is time. All time-related values are specified in UTC format.
    WSB_OB_ET_TIME      = 0x00000004,
    ///The value type is size.
    WSB_OB_ET_SIZE      = 0x00000005,
    ///The maximum enumeration value for this enumeration.
    WSB_OB_ET_MAX       = 0x00000006,
}

// Structs


///The <b>WSB_OB_STATUS_ENTRY_VALUE_TYPE_PAIR</b> structure contains the value and value type for a parameter used to
///expand the value resource string in the WSB_OB_STATUS_ENTRY structure.
struct WSB_OB_STATUS_ENTRY_VALUE_TYPE_PAIR
{
    ///Specifies the value for the parameter.
    PWSTR m_wszObStatusEntryPairValue;
    ///Specifies the type of the value for the parameter.
    WSB_OB_STATUS_ENTRY_PAIR_TYPE m_ObStatusEntryPairType;
}

///The <b>WSB_OB_STATUS_ENTRY</b> structure contains status information for one entry to be shown in the Windows Server
///Backup MMC snap-in.
struct WSB_OB_STATUS_ENTRY
{
    ///The resource identifier of the icon to be shown with the status entry. A value of zero indicates no icon is to be
    ///shown.
    uint m_dwIcon;
    ///The resource identifier of the name of the status entry.
    uint m_dwStatusEntryName;
    ///The resource identifier of the value of the status entry.
    uint m_dwStatusEntryValue;
    ///The number of WSB_OB_STATUS_ENTRY_VALUE_TYPE_PAIR structures pointed to by the <b>m_rgValueTypePair</b> member.
    uint m_cValueTypePair;
    ///The list of parameters used to expand the value string contained in the <b>m_dwStatusEntryValue</b> member.
    WSB_OB_STATUS_ENTRY_VALUE_TYPE_PAIR* m_rgValueTypePair;
}

///The <b>WSB_OB_STATUS_INFO</b> structure contains information to update the cloud backup provider status in the
///Windows Server Backup MMC snap-in.
struct WSB_OB_STATUS_INFO
{
    ///The snap-in identifier of the cloud backup provider registered with Windows Server Backup.
    GUID                 m_guidSnapinId;
    ///The number of status entries contained in the <b>m_rgStatusEntry</b> member. The maximum number of entries
    ///allowed is five.
    uint                 m_cStatusEntry;
    ///A pointer to one or more WSB_OB_STATUS_ENTRY structures, each containing cloud backup provider status information
    ///for one entry to be shown in the Windows Server Backup MMC snap-in.
    WSB_OB_STATUS_ENTRY* m_rgStatusEntry;
}

///The <b>WSB_OB_REGISTRATION_INFO</b> structure contains information to register a cloud backup provider with Windows
///Server Backup.
struct WSB_OB_REGISTRATION_INFO
{
    ///The complete path to the resource DLL where the provider name and icon resources can be loaded from.
    PWSTR m_wszResourceDLL;
    ///The snap-in identifier of the cloud backup provider to be registered with Windows Server Backup.
    GUID  m_guidSnapinId;
    ///The resource identifier of the cloud backup provider name. This name will be shown in the Windows Server Backup
    ///MMC snap-in.
    uint  m_dwProviderName;
    ///The resource identifier of the cloud backup provider icon. This icon will be shown in the Windows Server Backup
    ///MMC snap-in.
    uint  m_dwProviderIcon;
    ///A flag to indicate whether the cloud backup provider can communicate with a remote cloud backup provider engine.
    ubyte m_bSupportsRemoting;
}

// Interfaces

///Defines a method for checking the consistency of the application's VSS writer's components.
@GUID("1EFF3510-4A27-46AD-B9E0-08332F0F4F6D")
interface IWsbApplicationBackupSupport : IUnknown
{
    ///Checks the consistency of the VSS writer's components in the shadow copy after shadow copies are created for the
    ///volumes to be backed up.
    ///Params:
    ///    wszWriterMetadata = A string that contains the VSS writer's metadata.
    ///    wszComponentName = The name of the component or component set to be checked. This should match the name in the metadata that the
    ///                       <i>wszWriterMetadata</i> parameter points to.
    ///    wszComponentLogicalPath = The logical path of the component or component set to be checked. This should match the logical path in the
    ///                              metadata that the <i>wszWriterMetadata</i> parameter points to.
    ///    cVolumes = The number of shadow copy volumes. The value of this parameter can range from 0 to <b>MAX_VOLUMES</b>.
    ///    rgwszSourceVolumePath = A pointer to an array of volume <b>GUID</b> paths, one for each of the source volumes. The format of a volume
    ///                            <b>GUID</b> path is "\\?&
    ///    rgwszSnapshotVolumePath = A pointer to an array of volume <b>GUID</b> paths, one for each of the shadow copy volumes. The consistency
    ///                              check is performed on these volumes.
    ///    ppAsync = A pointer to a variable that will receive an IWsbApplicationAsync interface pointer that can be used to
    ///              retrieve the status of the consistency-check operation. This pointer can be <b>NULL</b> if a consistency
    ///              check is not required. When the consistency-check operation is complete, the IUnknown::Release method must be
    ///              called to free all resources held by the <b>IWsbApplicationAsync</b> object.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise. Possible return values include the following.
    ///    
    HRESULT CheckConsistency(PWSTR wszWriterMetadata, PWSTR wszComponentName, PWSTR wszComponentLogicalPath, 
                             uint cVolumes, PWSTR* rgwszSourceVolumePath, PWSTR* rgwszSnapshotVolumePath, 
                             IWsbApplicationAsync* ppAsync);
}

///Defines methods for performing application-specific restore tasks.
@GUID("8D3BDB38-4EE8-4718-85F9-C7DBC4AB77AA")
interface IWsbApplicationRestoreSupport : IUnknown
{
    ///Performs application-specific PreRestore operations.
    ///Params:
    ///    wszWriterMetadata = A string that contains the VSS writer's metadata.
    ///    wszComponentName = The name of the component or component set. This should match the name in the metadata that the
    ///                       <i>wszWriterMetadata</i> parameter points to.
    ///    wszComponentLogicalPath = The logical path of the component or component set. This should match the logical path in the metadata that
    ///                              the <i>wszWriterMetadata</i> parameter points to.
    ///    bNoRollForward = Set to <b>TRUE</b> if a previous point-in-time recovery operation is in progress and no application
    ///                     rollforward should be performed. The previous logs for the application will be deleted before the application
    ///                     restore operation is performed.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise. Possible return values include the following.
    ///    
    HRESULT PreRestore(PWSTR wszWriterMetadata, PWSTR wszComponentName, PWSTR wszComponentLogicalPath, 
                       ubyte bNoRollForward);
    ///Performs application-specific PostRestore operations.
    ///Params:
    ///    wszWriterMetadata = A string that contains the VSS writer's metadata.
    ///    wszComponentName = The name of the component or component set. This should match the name in the metadata that the
    ///                       <i>wszWriterMetadata</i> parameter points to.
    ///    wszComponentLogicalPath = The logical path of the component or component set. This should match the logical path in the metadata that
    ///                              the <i>wszWriterMetadata</i> parameter points to.
    ///    bNoRollForward = Set to <b>TRUE</b> if a previous point-in-time recovery operation is in progress and no application
    ///                     rollforward should be performed. The previous logs for the application will be deleted before the application
    ///                     restore operation is performed.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise. Possible return values include the following.
    ///    
    HRESULT PostRestore(PWSTR wszWriterMetadata, PWSTR wszComponentName, PWSTR wszComponentLogicalPath, 
                        ubyte bNoRollForward);
    ///Specifies the order in which application components are to be restored.
    ///Params:
    ///    cComponents = The number of components to be restored. The value of this parameter can range from 0 to MAX_COMPONENTS.
    ///    rgComponentName = An array of <i>cComponents</i> names of components to be restored.
    ///    rgComponentLogicalPaths = An array of <i>cComponents</i> logical paths of components to be restored.
    ///    prgComponentName = An array of <i>cComponents</i> names of components to be restored, in the order in which they are to be
    ///                       restored. This parameter receives <b>NULL</b> if no specific restore order is required.
    ///    prgComponentLogicalPath = An array of <i>cComponents</i> logical paths of components to be restored, in the order in which they are to
    ///                              be restored. This parameter receives <b>NULL</b> if no specific restore order is required.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise. Possible return values include the following.
    ///    
    HRESULT OrderComponents(uint cComponents, PWSTR* rgComponentName, PWSTR* rgComponentLogicalPaths, 
                            PWSTR** prgComponentName, PWSTR** prgComponentLogicalPath);
    ///Reports whether the application supports roll-forward restore.
    ///Params:
    ///    pbRollForwardSupported = Receives <b>TRUE</b> if roll-forward restore is supported, or <b>FALSE</b> otherwise.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT IsRollForwardSupported(ubyte* pbRollForwardSupported);
}

///Defines methods to monitor and control the progress of an asynchronous operation.
@GUID("0843F6F7-895C-44A6-B0C2-05A5022AA3A1")
interface IWsbApplicationAsync : IUnknown
{
    ///Queries the status of an asynchronous operation.
    ///Params:
    ///    phrResult = The address of an <b>HRESULT</b> value that receives the status of the current asynchronous operation. If the
    ///                asynchronous operation fails, this parameter receives the failure status code. Possible values include the
    ///                following.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT QueryStatus(HRESULT* phrResult);
    ///Cancels an incomplete asynchronous operation.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT Abort();
}


// GUIDs


const GUID IID_IWsbApplicationAsync          = GUIDOF!IWsbApplicationAsync;
const GUID IID_IWsbApplicationBackupSupport  = GUIDOF!IWsbApplicationBackupSupport;
const GUID IID_IWsbApplicationRestoreSupport = GUIDOF!IWsbApplicationRestoreSupport;
