// Written in the D programming language.

module windows.enhancedstorage;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : BOOL, PWSTR;
public import windows.windowsportabledevices : IPortableDevice;

extern(Windows) @nogc nothrow:


// Enums


alias ACT_AUTHORIZATION_STATE_VALUE = int;
enum : int
{
    ACT_UNAUTHORIZED = 0x00000000,
    ACT_AUTHORIZED   = 0x00000001,
}

// Structs


///The <b>ENHANCED_STORAGE_PASSWORD_SILO_INFORMATION</b> structure contains data that defines the capabilities and
///requirements of a password silo.
struct ENHANCED_STORAGE_PASSWORD_SILO_INFORMATION
{
    ///This is the current number of consecutive unsuccessful authentication attempts using administrator password. This
    ///value is reset to 0 after a successful authentication.
    ubyte  CurrentAdminFailures;
    ///This is the current number of consecutive unsuccessful authentication attempts using user password. This value is
    ///reset to 0 after a successful authentication.
    ubyte  CurrentUserFailures;
    ///Total number of authentication attempts attempted on this silo using the user password.
    uint   TotalUserAuthenticationCount;
    ///Total number of authentication attempts attempted on this silo using the administrator password.
    uint   TotalAdminAuthenticationCount;
    ///<b>TRUE</b> if the silo claims compliance with the Federal Information Processing Standard (FIPS); otherwise,
    ///<b>FALSE</b>.
    BOOL   FipsCompliant;
    ///<b>TRUE</b> if a device-unique security identifier provided by the manufacturer is available; otherwise,
    ///<b>FALSE</b>.
    BOOL   SecurityIDAvailable;
    ///<b>TRUE</b> if an initialization is in progress; otherwise, <b>FALSE</b>.
    BOOL   InitializeInProgress;
    ///<b>TRUE</b> if the silo is set to prepare for initalization to the default state set by the manufacturer;
    ///otherwise, <b>FALSE</b>.
    BOOL   ITMSArmed;
    ///<b>TRUE</b> if the silo is capable of initializing to the default state set by the manufacturer; otherwise,
    ///<b>FALSE</b>.
    BOOL   ITMSArmable;
    ///<b>TRUE</b> if the user account has been created in the password silo; otherwise, <b>FALSE</b>.
    BOOL   UserCreated;
    ///<b>TRUE</b> if the silo resets Administrator authentication failure count to zero upon power cycle. This is the
    ///default behavior for the silo. If <b>FALSE</b>, the silo will not reset Administrator authentication failure
    ///count to zero upon power cycle.
    BOOL   ResetOnPORDefault;
    ///<b>TRUE</b> if the silo is currently set to reset Administrator authentication failure count to zero upon power
    ///cycle; Otherwise <b>FALSE</b>. This configuration is affected by changes introduced by the host or the
    ///implementation of factory default settings.
    BOOL   ResetOnPORCurrent;
    ///This is the maximum number of consecutive unsuccessful authentication attempts using administrator password
    ///allowed by the silo before it will block the administrator.
    ubyte  MaxAdminFailures;
    ///This is the maximum number of consecutive unsuccessful authentication attempts using user password allowed by the
    ///silo before it will block user.
    ubyte  MaxUserFailures;
    ///Estimated time (in milliseconds) for the device to complete the initialize to manufacturing function.
    uint   TimeToCompleteInitialization;
    ///Time remaining (in milliseconds) for the silo to complete the initialize to manufacturing function. The value of
    ///this field is zero if the silo is currently not in the process of initialization.
    uint   TimeRemainingToCompleteInitialization;
    ///Minimum time (in milliseconds) the silo will require to complete an authentication operation.
    uint   MinTimeToAuthenticate;
    ///This is the maximum number of bytes that the silo supports for administrator password.
    ubyte  MaxAdminPasswordSize;
    ///This is the minimum number of bytes that the silo requires for administrator password.
    ubyte  MinAdminPasswordSize;
    ///This is the maximum number of bytes that the silo supports for administrator password hint.
    ubyte  MaxAdminHintSize;
    ///This is the maximum number of bytes that the silo supports for user password.
    ubyte  MaxUserPasswordSize;
    ///This is the minimum number of bytes that the silo requires for user password.
    ubyte  MinUserPasswordSize;
    ///This is the maximum number of bytes that the silo supports for user password hint.
    ubyte  MaxUserHintSize;
    ///This is the maximum number of bytes that the silo supports for friendly user name.
    ubyte  MaxUserNameSize;
    ///The maximum number of bytes that the silo supports for the silo name.
    ubyte  MaxSiloNameSize;
    ///The maximum number of bytes that the device supports for challenge.
    ushort MaxChallengeSize;
}

///The <b>ACT_AUTHORIZATION_STATE</b> structure contains data that describes the current authorization state of a
///Addressable Command Target (ACT).
struct ACT_AUTHORIZATION_STATE
{
    uint ulState;
}

///The <b>SILO_INFO</b> structure contains information that identifies and describes the silo.
struct SILO_INFO
{
    ///Silo Type Identifier for the silo assigned by IEEE 1667 Working Group.
    uint  ulSTID;
    ///Major version of the specification implemented in the silo.
    ubyte SpecificationMajor;
    ///Minor version of the specification implemented in the silo.
    ubyte SpecificationMinor;
    ///Major version of the firmware implemented in the silo.
    ubyte ImplementationMajor;
    ///Minor version of the firmware implemented in the silo.
    ubyte ImplementationMinor;
    ///Type of the silo.
    ubyte type;
    ubyte capabilities;
}

// Interfaces

@GUID("FE841493-835C-4FA3-B6CC-B4B2D4719848")
struct EnumEnhancedStorageACT;

@GUID("AF076A15-2ECE-4AD4-BB21-29F040E176D8")
struct EnhancedStorageACT;

@GUID("CB25220C-76C7-4FEE-842B-F3383CD022BC")
struct EnhancedStorageSilo;

@GUID("886D29DD-B506-466B-9FBF-B44FF383FB3F")
struct EnhancedStorageSiloAction;

///Use this interface as the top level enumerator for all IEEE 1667 Addressable Contact Targets (ACT).
@GUID("09B224BD-1335-4631-A7FF-CFD3A92646D7")
interface IEnumEnhancedStorageACT : IUnknown
{
    ///Returns an enumeration of all the Addressable Command Targets (ACT) currently connected to the system. If at
    ///least one ACT is present, the Enhanced Storage API allocates an array of 1 or more IEnumEnhancedStorageACT
    ///pointers.
    ///Params:
    ///    pppIEnhancedStorageACTs = Array of IEnhancedStorageACT interface pointers that represent the ACTs for all devices connected to the
    ///                              system. This array is allocated within the API.
    ///    pcEnhancedStorageACTs = Count of IEnhancedStorageACT pointers returned. This is the dimension of the array represented by
    ///                            <i>pppIEnhancedStorageACTs</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> One or more ACTs were found. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    pppIEnhancedStorageACTs or pcEnhancedStorageACTs is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Operation failed due to insufficient memory. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetACTs(IEnhancedStorageACT** pppIEnhancedStorageACTs, uint* pcEnhancedStorageACTs);
    ///Returns the Addressable Command Target (ACT) associated with the volume specified via the string supplied by the
    ///client.
    ///Params:
    ///    szVolume = A string that specifies the volume for which a matching ACT is searched for.
    ///    ppIEnhancedStorageACT = Pointer to an <b>IEnhancedStorageACT</b> interface pointer that represents the matching ACT. If no matching
    ///                            ACT is found the error <b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b> is returned.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> A matching ACT was successfully
    ///    found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>szVolume</i> or <i>ppIEnhancedStorageACT</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> A matching ACT wasn't found.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl> </td>
    ///    <td width="60%"> Enhanced storage is not supported on the device containing <i>szVolume</i>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_FUNCTION)</b></dt> </dl> </td> <td width="60%">
    ///    Enhanced storage is not supported on the device containing <i>szVolume</i>. </td> </tr> </table>
    ///    
    HRESULT GetMatchingACT(const(PWSTR) szVolume, IEnhancedStorageACT* ppIEnhancedStorageACT);
}

///Use this interface to obtain information and perform operations for an 1667 Addressable Contact Target (ACT).
@GUID("6E7781F4-E0F2-4239-B976-A01ABAB52930")
interface IEnhancedStorageACT : IUnknown
{
    ///Associates the Addressable Command Target (ACT) with the <b>Authorized</b> state defined by
    ///ACT_AUTHORIZATION_STATE, and ensures the authentication of each individual silo according to the required
    ///sequence and logical combination necessary to authorize access to the ACT.
    ///Params:
    ///    hwndParent = Not used.
    ///    dwFlags = Not used.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Authorization completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The
    ///    authorization operation has failed. </td> </tr> </table>
    ///    
    HRESULT Authorize(uint hwndParent, uint dwFlags);
    ///Associates the Addressable Command Target (ACT) with the <b>Unauthorized</b> state defined by
    ///ACT_AUTHORIZATION_STATE, and ensures the deauthentication of each individual silo according to the required
    ///sequence and logical combination necessary to restrict access to the ACT.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Unauthorization completed
    ///    successfully. </td> </tr> </table>
    ///    
    HRESULT Unauthorize();
    ///Returns the current authorization state of the ACT.
    ///Params:
    ///    pState = Pointer to a ACT_AUTHORIZATION_STATE that specifies the current authorization state of the ACT.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> The current authorization state was
    ///    retrieved successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> <i>pState</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetAuthorizationState(ACT_AUTHORIZATION_STATE* pState);
    ///Returns the volume associated with the Addressable Command Target (ACT).
    ///Params:
    ///    ppwszVolume = Pointer to a string that represents the volume associated with the ACT.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The associated volume was
    ///    successfully returned. </td> </tr> </table>
    ///    
    HRESULT GetMatchingVolume(PWSTR* ppwszVolume);
    ///Retrieves the unique identity of the Addressable Command Targer (ACT).
    ///Params:
    ///    ppwszIdentity = Pointer to a string that represents the unique identity of the ACT.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The unique identity was retrieved
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> <i>ppwszIdentity</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetUniqueIdentity(PWSTR* ppwszIdentity);
    ///Returns an enumeration of all silos associated with the Addressable Command Target (ACT).
    ///Params:
    ///    pppIEnhancedStorageSilos = Returns an array of one or more IEnhancedStorageSilo interface pointers associated with the ACT.
    ///    pcEnhancedStorageSilos = Count of IEnhancedStorageSilo pointers returned. This value indicates the dimension of the array represented
    ///                             by <i>pppIEnhancedStorageSilos</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Command was sent successfully and all
    ///    associated silos have been enumerated. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt>
    ///    </dl> </td> <td width="60%"> Command failed due to insufficient memory allocation. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pppIEnhancedStorageSilos</i>
    ///    or <i>pcEnhancedStorageSilos</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetSilos(IEnhancedStorageSilo** pppIEnhancedStorageSilos, uint* pcEnhancedStorageSilos);
}

///The <b>IEnhancedStorageACT2</b> interface is used to obtain information for a 1667 Addressable Contact Target (ACT).
@GUID("4DA57D2E-8EB3-41F6-A07E-98B52B88242B")
interface IEnhancedStorageACT2 : IEnhancedStorageACT
{
    ///The <b>IEnhancedStorageACT2::GetDeviceName</b> method returns the device name associated with the Addressable
    ///Command Target (ACT).
    ///Params:
    ///    ppwszDeviceName = Pointer to a string that represents the device name associated with the ACT.
    ///Returns:
    ///    This method can return one of the following values: <table> <tr> <th>Return code</th> <th>Description</th>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The associated volume was
    ///    successfully returned. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> <i>ppwszDeviceName</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The operation failed due to insufficient memory
    ///    allocation. </td> </tr> </table>
    ///    
    HRESULT GetDeviceName(PWSTR* ppwszDeviceName);
    ///The <b>IEnhancedStorageACT2::IsDeviceRemovable</b> method returns information that indicates if the device
    ///associated with the ACT is removable.
    ///Params:
    ///    pIsDeviceRemovable = Pointer to a boolean value that indicates if the device associated with the ACT is removable.
    ///Returns:
    ///    This method can return one of the following values: <table> <tr> <th>Return code</th> <th>Description</th>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The information was
    ///    successfully retrieved. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> <i>pIsDeviceRemovable</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT IsDeviceRemovable(BOOL* pIsDeviceRemovable);
}

@GUID("022150A1-113D-11DF-BB61-001AA01BBC58")
interface IEnhancedStorageACT3 : IEnhancedStorageACT2
{
    HRESULT UnauthorizeEx(uint dwFlags);
    HRESULT IsQueueFrozen(BOOL* pIsQueueFrozen);
    HRESULT GetShellExtSupport(BOOL* pShellExtSupport);
}

///The <b>IEnhancedStorageSilo</b> interface is the point of access for an IEEE 1667 silo and is used to obtain
///information and perform operations at the silo level.
@GUID("5AEF78C6-2242-4703-BF49-44B29357A359")
interface IEnhancedStorageSilo : IUnknown
{
    ///Returns the descriptive information associated with the silo object.
    ///Params:
    ///    pSiloInfo = Pointer to a SILO_INFO object containing descriptive information associated with the silo.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Silo information was retrieved
    ///    successfully. </td> </tr> </table>
    ///    
    HRESULT GetInfo(SILO_INFO* pSiloInfo);
    ///Returns an enumeration of all actions available to the silo object.
    ///Params:
    ///    pppIEnhancedStorageSiloActions = Array of pointers to IEnhancedStorageAction interface objects that represent the actions available for the
    ///                                     silo object. This array is allocated within the API when at least one action is available to the silo.
    ///    pcEnhancedStorageSiloActions = Count of IEnhancedStorageAction pointers returned. This value indicates the dimension of the array
    ///                                   represented by <i>pppIEnhancedStorageSilos</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> One or more ACTs were found. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>pppIEnhancedStorageSiloActions</i> or <i>pcEnhancedStorageSiloActions</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetActions(IEnhancedStorageSiloAction** pppIEnhancedStorageSiloActions, 
                       uint* pcEnhancedStorageSiloActions);
    ///Sends a raw silo command to the silo object. This method is utilized to communicate with a silo which is not
    ///represented by a driver.
    ///Params:
    ///    Command = The silo command to be issued. 8 bits of this value are placed in the byte at position 3 of the CDB sent to
    ///              the device; i.e. the second byte of the <b>SecurityProtocolSpecific</b> field.
    ///    pbCommandBuffer = The command payload sent to the device in the send data phase of the command.
    ///    cbCommandBuffer = The count of bytes contained in the <i>pbCommandBuffer</i> buffer.
    ///    pbResponseBuffer = The response payload that is returned to the host from the device in the receive data phase of the command.
    ///    pcbResponseBuffer = On method entry, contains the size of <i>pbResponseBuffer</i> in bytes. On method exit, it contains the count
    ///                        of bytes contained in the returned <i>pbResponse</i> buffer.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Silo command completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    pbCommandBuffer, pbResponseBuffer, or pcbResponseBuffer parameter is <b>NULL</b>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_ENOUGH_MEMORY)</b></dt> </dl> </td> <td width="60%">
    ///    The size of pbResponseBuffer is insufficient to contain the response data. </td> </tr> </table>
    ///    
    HRESULT SendCommand(ubyte Command, ubyte* pbCommandBuffer, uint cbCommandBuffer, ubyte* pbResponseBuffer, 
                        uint* pcbResponseBuffer);
    ///Obtains an IPortableDevice pointer used to issue commands to the corresponding Enhanced Storage silo driver.
    ///Params:
    ///    ppIPortableDevice = Pointer to a pointer to an IPortableDevice object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Pointer to IPortableDevice was
    ///    obtained successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> <i>ppIPortableDevice</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetPortableDevice(IPortableDevice* ppIPortableDevice);
    ///Retrieves the path to the silo device node. The returned string is suitable for passing to <b>Windows System</b>
    ///APIs such as CreateFile or SetupDiOpenDeviceInterface.
    ///Params:
    ///    ppwszSiloDevicePath = A pointer to a string that represents the path to the Silo device node.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Device path string was retrieved
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> <i>ppwszSiloDevicePath</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetDevicePath(PWSTR* ppwszSiloDevicePath);
}

///Use this interface as a point of access for actions involving IEEE 1667 silos.
@GUID("B6F7F311-206F-4FF8-9C4B-27EFEE77A86F")
interface IEnhancedStorageSiloAction : IUnknown
{
    ///Returns a string for the name of the action specified by the IEnhancedStorageSiloAction object.
    ///Params:
    ///    ppwszActionName = Pointer to a string that represents the silo action by name.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The action name was retrieved
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The <i>ppwszActionName</i> parameter is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetName(PWSTR* ppwszActionName);
    ///Returns a descriptive string for the action specified by the IEnhancedStorageSiloAction object.
    ///Params:
    ///    ppwszActionDescription = Pointer to a string that describes the silo action.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The descriptive string was retrieved
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The <i>ppwszDescription</i> parameter is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetDescription(PWSTR* ppwszActionDescription);
    ///Performs the action specified by an IEnhancedStorageSiloAction object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The action was invoked successfully.
    ///    </td> </tr> </table>
    ///    
    HRESULT Invoke();
}


// GUIDs

const GUID CLSID_EnhancedStorageACT        = GUIDOF!EnhancedStorageACT;
const GUID CLSID_EnhancedStorageSilo       = GUIDOF!EnhancedStorageSilo;
const GUID CLSID_EnhancedStorageSiloAction = GUIDOF!EnhancedStorageSiloAction;
const GUID CLSID_EnumEnhancedStorageACT    = GUIDOF!EnumEnhancedStorageACT;

const GUID IID_IEnhancedStorageACT        = GUIDOF!IEnhancedStorageACT;
const GUID IID_IEnhancedStorageACT2       = GUIDOF!IEnhancedStorageACT2;
const GUID IID_IEnhancedStorageACT3       = GUIDOF!IEnhancedStorageACT3;
const GUID IID_IEnhancedStorageSilo       = GUIDOF!IEnhancedStorageSilo;
const GUID IID_IEnhancedStorageSiloAction = GUIDOF!IEnhancedStorageSiloAction;
const GUID IID_IEnumEnhancedStorageACT    = GUIDOF!IEnumEnhancedStorageACT;
