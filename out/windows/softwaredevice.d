// Written in the D programming language.

module windows.softwaredevice;

public import windows.core;
public import windows.com : HRESULT;
public import windows.security : SECURITY_DESCRIPTOR;
public import windows.systemservices : BOOL, DEVPROPERTY, PWSTR;

extern(Windows) @nogc nothrow:


// Enums


alias SW_DEVICE_CAPABILITIES = int;
enum : int
{
    SWDeviceCapabilitiesNone           = 0x00000000,
    SWDeviceCapabilitiesRemovable      = 0x00000001,
    SWDeviceCapabilitiesSilentInstall  = 0x00000002,
    SWDeviceCapabilitiesNoDisplayInUI  = 0x00000004,
    SWDeviceCapabilitiesDriverRequired = 0x00000008,
}

alias SW_DEVICE_LIFETIME = int;
enum : int
{
    SWDeviceLifetimeHandle        = 0x00000000,
    SWDeviceLifetimeParentPresent = 0x00000001,
    SWDeviceLifetimeMax           = 0x00000002,
}

// Callbacks

///Provides a device with backing in the registry and allows the caller to then make calls to Software Device API
///functions with the <i>hSwDevice</i> handle.
///Params:
///    hSwDevice = The handle for the software device.
///    CreateResult = An HRESULT that indicates if the enumeration of the software device was successful.
///    pContext = The context that was optionally supplied by the client app to SwDeviceCreate.
///    pszDeviceInstanceId = The device instance ID that PnP assigned to the device.
alias SW_DEVICE_CREATE_CALLBACK = void function(HSWDEVICE__* hSwDevice, HRESULT CreateResult, void* pContext, 
                                                const(PWSTR) pszDeviceInstanceId);

// Structs


///Describes info that PnP uses to create the software device.
struct SW_DEVICE_CREATE_INFO
{
    ///The size in bytes of this structure. Use it as a version field. Initialize it to sizeof(SW_DEVICE_CREATE_INFO).
    uint         cbSize;
    ///A string that represents the instance ID portion of the device instance ID. This value is used for
    ///IRP_MN_QUERY_ID <b>BusQueryInstanceID</b>. Because all software devices are considered "UniqueId" devices, this
    ///string must be a unique name for all devices on this software device enumerator. For more info, see Instance IDs.
    const(PWSTR) pszInstanceId;
    ///A list of strings for the hardware IDs for the software device. This value is used for IRP_MN_QUERY_ID
    ///<b>BusQueryHardwareIDs</b>. If a client expects a driver or device metadata to bind to the device, the client
    ///specifies hardware IDs.
    /*FIELD ATTR: NullNullTerminated : CustomAttributeSig([], [])*/const(PWSTR) pszzHardwareIds;
    ///A list of strings for the compatible IDs for the software device. This value is used for IRP_MN_QUERY_ID
    ///<b>BusQueryCompatibleIDs</b>. If a client expects a class driver to load, the client specifies compatible IDs
    ///that match the class driver. If a driver isn't needed, we recommend to specify a compatible ID to classify the
    ///type of software device. In addition to the compatible IDs specified in this member, SWD\Generic and possibly
    ///SWD\GenericRaw will always be added as the least specific compatible IDs.
    /*FIELD ATTR: NullNullTerminated : CustomAttributeSig([], [])*/const(PWSTR) pszzCompatibleIds;
    ///A value that is used to control the base container ID for the software device. This value will be used for
    ///IRP_MN_QUERY_ID <b>BusQueryContainerIDs</b>. For typical situations, we recommend to set this member to
    ///<b>NULL</b> and use the <b>SWDeviceCapabilitiesRemovable</b> flag to control whether the device inherits the
    ///parent's container ID or if PnP assigns a new random container ID. If the client needs to explicitly control the
    ///container ID, specify a <b>GUID</b> in the variable that this member points to.
    const(GUID)* pContainerId;
    ///A combination of <b>SW_DEVICE_CAPABILITIES</b> values that are combined by using a bitwise OR operation. The
    ///resulting value specifies capabilities of the software device. The capability that you can specify when you
    ///create a software device are a subset of the capabilities that a bus driver can specify by using the
    ///<b>DEVICE_CAPABILTIES</b> structure. Only capabilities that make sense to allow changing for a software only
    ///device are supported. The rest receive appropriate default values. Here are possible values: <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SWDeviceCapabilitiesNone"></a><a
    ///id="swdevicecapabilitiesnone"></a><a id="SWDEVICECAPABILITIESNONE"></a><dl>
    ///<dt><b>SWDeviceCapabilitiesNone</b></dt> <dt>0x00000000</dt> </dl> </td> <td width="60%"> No capabilities have
    ///been specified. </td> </tr> <tr> <td width="40%"><a id="SWDeviceCapabilitiesRemovable"></a><a
    ///id="swdevicecapabilitiesremovable"></a><a id="SWDEVICECAPABILITIESREMOVABLE"></a><dl>
    ///<dt><b>SWDeviceCapabilitiesRemovable</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> This bit specifies
    ///that the device is removable from its parent. Setting this flag is equivalent to a bus driver setting the
    ///<b>Removable</b> member of the <b>DEVICE_CAPABILTIES</b> structure for a PDO. </td> </tr> <tr> <td width="40%"><a
    ///id="SWDeviceCapabilitiesSilentInstall"></a><a id="swdevicecapabilitiessilentinstall"></a><a
    ///id="SWDEVICECAPABILITIESSILENTINSTALL"></a><dl> <dt><b>SWDeviceCapabilitiesSilentInstall</b></dt>
    ///<dt>0x00000002</dt> </dl> </td> <td width="60%"> This bit suppresses UI that would normally be shown during
    ///installation. Setting this flag is equivalent to a bus driver setting the <b>SilentInstall</b> member of the
    ///<b>DEVICE_CAPABILTIES</b> structure for a PDO. </td> </tr> <tr> <td width="40%"><a
    ///id="SWDeviceCapabilitiesNoDisplayInUI"></a><a id="swdevicecapabilitiesnodisplayinui"></a><a
    ///id="SWDEVICECAPABILITIESNODISPLAYINUI"></a><dl> <dt><b>SWDeviceCapabilitiesNoDisplayInUI</b></dt>
    ///<dt>0x00000004</dt> </dl> </td> <td width="60%"> This bit prevents the device from being displayed in some UI.
    ///Setting this flag is equivalent to a bus driver setting the <b>NoDisplayInUI</b> member of the
    ///<b>DEVICE_CAPABILTIES</b> structure for a PDO. </td> </tr> <tr> <td width="40%"><a
    ///id="SWDeviceCapabilitiesDriverRequired"></a><a id="swdevicecapabilitiesdriverrequired"></a><a
    ///id="SWDEVICECAPABILITIESDRIVERREQUIRED"></a><dl> <dt><b>SWDeviceCapabilitiesDriverRequired</b></dt>
    ///<dt>0x00000008</dt> </dl> </td> <td width="60%"> Specify this bit when the client wants a driver to be loaded on
    ///the device and when this driver is required for correct function of the client’s feature. When this bit is
    ///specified, at least one of <b>pszzHardwareIds</b> or <b>pszzCompatibleIds</b> must be filled in. If this bit is
    ///specified and if a driver can't be found, the device shows a yellow bang in <b>Device Manager</b> to indicate
    ///that the device has a problem, and Troubleshooters flag this as a device with a problem. Setting this bit is
    ///equivalent to a bus driver not setting the <b>RawDeviceOK</b> member of the <b>DEVICE_CAPABILTIES</b> structure
    ///for a PDO. When this bit is specified, the driver owns creating interfaces for the device, and you can't call
    ///SwDeviceInterfaceRegister for the device. </td> </tr> </table>
    uint         CapabilityFlags;
    ///A string that contains the text that is displayed for the device name in the UI. This value is used for
    ///IRP_MN_QUERY_DEVICE_TEXT <b>DeviceTextDescription</b>. <div class="alert"><b>Note</b> <p class="note">When an INF
    ///is matched against the device, the name from the INF overrides this name unless steps are taken to preserve this
    ///name. <p class="note">We recommend that this string be a reference to a localizable resource. For the syntax of
    ///referencing resources, see DEVPROP_TYPE_STRING_INDIRECT. </div> <div> </div>
    const(PWSTR) pszDeviceDescription;
    ///A string that contains the text that is displayed for the device location in the UI. This value is used for
    ///IRP_MN_QUERY_DEVICE_TEXT <b>DeviceTextLocationInformation</b>. <div class="alert"><b>Note</b> Specifying a
    ///location is uncommon.</div> <div> </div>
    const(PWSTR) pszDeviceLocation;
    ///A pointer to a SECURITY_DESCRIPTOR structure that contains the security information associated with the software
    ///device. If this member is <b>NULL</b>, the I/O Manager assigns the default security descriptor to the device. If
    ///a custom security descriptor is needed, specify a self-relative security descriptor.
    const(SECURITY_DESCRIPTOR)* pSecurityDescriptor;
}

struct HSWDEVICE__
{
    int unused;
}

// Functions

///Initiates the enumeration of a software device.
///Params:
///    pszEnumeratorName = A string that names the enumerator of the software device. Choose a name that represents the component that
///                        enumerates the devices.
///    pszParentDeviceInstance = A string that specifies the device instance ID of the device that is the parent of the software device. This can
///                              be HTREE\ROOT\0, but we recommend to keep children of the root device to a minimum. We also recommend that the
///                              preferred parent of a software device be a real device that the software device is extending the functionality
///                              for. In situations where a software device doesn't have such a natural parent, create a device as a child of the
///                              root that can collect all the software devices that a component will enumerate; then, enumerate the actual
///                              software devices as children of this device grouping node. This keeps the children of the root device to a
///                              manageable number.
///    pCreateInfo = A pointer to a SW_DEVICE_CREATE_INFO structure that describes info that PnP uses to create the device.
///    cPropertyCount = The number of DEVPROPERTY structures in the <i>pProperties</i> array.
///    pProperties = An optional array of DEVPROPERTY structures. These properties are set on the device after it is created but
///                  before a notification that the device has been created are sent. For more info, see Remarks. This pointer can be
///                  <b>NULL</b>.
///    pCallback = The SW_DEVICE_CREATE_CALLBACK callback function that the operating system calls after PnP enumerates the device.
///    pContext = An optional client context that the operating system passes to the callback function. This pointer can be
///               <b>NULL</b>.
///    phSwDevice = A pointer to a variable that receives the <b>HSWDEVICE</b> handle that represents the device. Call SwDeviceClose
///                 to close this handle after the client app wants PnP to remove the device. <pre class="syntax"
///                 xml:space="preserve"><code> DECLARE_HANDLE(HSWDEVICE); typedef HSWDEVICE *PHSWDEVICE; </code></pre>
///Returns:
///    S_OK is returned if device enumeration was successfully initiated. This does not mean that the device has been
///    successfully enumerated. Check the <i>CreateResult</i> parameter of the SW_DEVICE_CREATE_CALLBACK callback
///    function to determine if the device was successfully enumerated.
///    
@DllImport("api-ms-win-devices-swdevice-l1-1-0")
HRESULT SwDeviceCreate(const(PWSTR) pszEnumeratorName, const(PWSTR) pszParentDeviceInstance, 
                       const(SW_DEVICE_CREATE_INFO)* pCreateInfo, uint cPropertyCount, 
                       const(DEVPROPERTY)* pProperties, SW_DEVICE_CREATE_CALLBACK pCallback, void* pContext, 
                       HSWDEVICE__** phSwDevice);

///Closes the software device handle. When the handle is closed, PnP will initiate the process of removing the device.
///Params:
///    hSwDevice = The <b>HSWDEVICE</b> handle to close.
@DllImport("api-ms-win-devices-swdevice-l1-1-0")
void SwDeviceClose(HSWDEVICE__* hSwDevice);

///Manages the lifetime of a software device.
///Params:
///    hSwDevice = The <b>HSWDEVICE</b> handle to the software device to manage.
///    Lifetime = A <b>SW_DEVICE_LIFETIME</b>-typed value that indicates the new lifetime value for the software device. Here are
///               possible values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///               id="SWDeviceLifetimeHandle"></a><a id="swdevicelifetimehandle"></a><a id="SWDEVICELIFETIMEHANDLE"></a><dl>
///               <dt><b>SWDeviceLifetimeHandle</b></dt> </dl> </td> <td width="60%"> Indicates that the lifetime of the software
///               device is determined by the lifetime of the handle that is associated with the software device. As long as the
///               handle is open, the software device is enumerated by PnP. </td> </tr> <tr> <td width="40%"><a
///               id="SWDeviceLifetimeParentPresent"></a><a id="swdevicelifetimeparentpresent"></a><a
///               id="SWDEVICELIFETIMEPARENTPRESENT"></a><dl> <dt><b>SWDeviceLifetimeParentPresent</b></dt> </dl> </td> <td
///               width="60%"> Indicates that the lifetime of the software device is tied to the lifetime of its parent. </td>
///               </tr> </table>
///Returns:
///    S_OK is returned if <b>SwDeviceSetLifetime</b> successfully updated the lifetime.
///    
@DllImport("api-ms-win-devices-swdevice-l1-1-1")
HRESULT SwDeviceSetLifetime(HSWDEVICE__* hSwDevice, SW_DEVICE_LIFETIME Lifetime);

///Gets the lifetime of a software device.
///Params:
///    hSwDevice = The <b>HSWDEVICE</b> handle to the software device to retrieve.
///    pLifetime = A pointer to a variable that receives a <b>SW_DEVICE_LIFETIME</b>-typed value that indicates the current lifetime
///                value for the software device. Here are possible values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///                <td width="40%"><a id="SWDeviceLifetimeHandle"></a><a id="swdevicelifetimehandle"></a><a
///                id="SWDEVICELIFETIMEHANDLE"></a><dl> <dt><b>SWDeviceLifetimeHandle</b></dt> </dl> </td> <td width="60%">
///                Indicates that the lifetime of the software device is determined by the lifetime of the handle that is associated
///                with the software device. As long as the handle is open, the software device is enumerated by PnP. </td> </tr>
///                <tr> <td width="40%"><a id="SWDeviceLifetimeParentPresent"></a><a id="swdevicelifetimeparentpresent"></a><a
///                id="SWDEVICELIFETIMEPARENTPRESENT"></a><dl> <dt><b>SWDeviceLifetimeParentPresent</b></dt> </dl> </td> <td
///                width="60%"> Indicates that the lifetime of the software device is tied to the lifetime of its parent. </td>
///                </tr> </table>
@DllImport("api-ms-win-devices-swdevice-l1-1-1")
HRESULT SwDeviceGetLifetime(HSWDEVICE__* hSwDevice, SW_DEVICE_LIFETIME* pLifetime);

///Sets properties on a software device.
///Params:
///    hSwDevice = The <b>HSWDEVICE</b> handle to the software device to set properties for.
///    cPropertyCount = The number of DEVPROPERTY structures in the <i>pProperties</i> array.
///    pProperties = An array of DEVPROPERTY structures containing the properties to set.
///Returns:
///    S_OK is returned if <b>SwDevicePropertySet</b> successfully set the properties; otherwise, an appropriate error
///    value.
///    
@DllImport("api-ms-win-devices-swdevice-l1-1-0")
HRESULT SwDevicePropertySet(HSWDEVICE__* hSwDevice, uint cPropertyCount, const(DEVPROPERTY)* pProperties);

///Registers a device interface for a software device and optionally sets properties on that interface.
///Params:
///    hSwDevice = The <b>HSWDEVICE</b> handle to the software device to register a device interface for.
///    pInterfaceClassGuid = A pointer to the interface class GUID that names the contract that this interface implements.
///    pszReferenceString = An optional reference string that differentiates multiple interfaces of the same class for this device. This
///                         pointer can be <b>NULL</b>.
///    cPropertyCount = The number of DEVPROPERTY structures in the <i>pProperties</i> array.
///    pProperties = An optional array of DEVPROPERTY structures for the properties to set on the interface. This pointer can be
///                  <b>NULL</b>. Set these properties on the interface after it is created but before a notification that the
///                  interface has been created are sent. For more info, see Remarks. This pointer can be <b>NULL</b>.
///    fEnabled = A Boolean value that indicates whether to either enable or disable the interface. <b>TRUE</b> to enable;
///               <b>FALSE</b> to disable.
///    ppszDeviceInterfaceId = A pointer to a variable that receives a pointer to the device interface ID for the interface. The caller must
///                            free this value with SwMemFree. This value can be <b>NULL</b> if the client app doesn't need to retrieve the
///                            name.
///Returns:
///    S_OK is returned if <b>SwDeviceInterfaceRegister</b> successfully registered the interface; otherwise, an
///    appropriate error value.
///    
@DllImport("api-ms-win-devices-swdevice-l1-1-0")
HRESULT SwDeviceInterfaceRegister(HSWDEVICE__* hSwDevice, const(GUID)* pInterfaceClassGuid, 
                                  const(PWSTR) pszReferenceString, uint cPropertyCount, 
                                  const(DEVPROPERTY)* pProperties, BOOL fEnabled, PWSTR* ppszDeviceInterfaceId);

///Frees memory that other Software Device API functions allocated.
///Params:
///    pMem = A pointer to the block of memory to free.
@DllImport("api-ms-win-devices-swdevice-l1-1-0")
void SwMemFree(void* pMem);

///Enables or disables a device interface for a software device.
///Params:
///    hSwDevice = The <b>HSWDEVICE</b> handle to the software device to register a device interface for.
///    pszDeviceInterfaceId = A string that identifies the interface to enable or disable.
///    fEnabled = A Boolean value that indicates whether to either enable or disable the interface. <b>TRUE</b> to enable;
///               <b>FALSE</b> to disable.
///Returns:
///    S_OK is returned if <b>SwDeviceInterfaceSetState</b> successfully enabled or disabled the interface; otherwise,
///    an appropriate error value.
///    
@DllImport("api-ms-win-devices-swdevice-l1-1-0")
HRESULT SwDeviceInterfaceSetState(HSWDEVICE__* hSwDevice, const(PWSTR) pszDeviceInterfaceId, BOOL fEnabled);

///Sets properties on a software device interface.
///Params:
///    hSwDevice = The <b>HSWDEVICE</b> handle to the software device of the interface to set properties for.
///    pszDeviceInterfaceId = A string that identifies the interface to set properties on.
///    cPropertyCount = The number of DEVPROPERTY structures in the <i>pProperties</i> array.
///    pProperties = An array of DEVPROPERTY structures containing the properties to set on the interface.
///Returns:
///    S_OK is returned if <b>SwDeviceInterfacePropertySet</b> successfully set the properties on the interface;
///    otherwise, an appropriate error value.
///    
@DllImport("api-ms-win-devices-swdevice-l1-1-0")
HRESULT SwDeviceInterfacePropertySet(HSWDEVICE__* hSwDevice, const(PWSTR) pszDeviceInterfaceId, 
                                     uint cPropertyCount, const(DEVPROPERTY)* pProperties);


