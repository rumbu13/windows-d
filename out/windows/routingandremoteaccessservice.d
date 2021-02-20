// Written in the D programming language.

module windows.routingandremoteaccessservice;

public import windows.core;
public import windows.kernel : LUID;
public import windows.mib : MIB_IPMCAST_MFE;
public import windows.security : CRYPTOAPI_BLOB;
public import windows.systemservices : BOOL, HANDLE, HINSTANCE, PSTR, PWSTR;
public import windows.winsock : in6_addr, in_addr;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME;

extern(Windows) @nogc nothrow:


// Enums


alias RASAPIVERSION = int;
enum : int
{
    RASAPIVERSION_500 = 0x00000001,
    RASAPIVERSION_501 = 0x00000002,
    RASAPIVERSION_600 = 0x00000003,
    RASAPIVERSION_601 = 0x00000004,
}

alias tagRASCONNSTATE = int;
enum : int
{
    RASCS_OpenPort             = 0x00000000,
    RASCS_PortOpened           = 0x00000001,
    RASCS_ConnectDevice        = 0x00000002,
    RASCS_DeviceConnected      = 0x00000003,
    RASCS_AllDevicesConnected  = 0x00000004,
    RASCS_Authenticate         = 0x00000005,
    RASCS_AuthNotify           = 0x00000006,
    RASCS_AuthRetry            = 0x00000007,
    RASCS_AuthCallback         = 0x00000008,
    RASCS_AuthChangePassword   = 0x00000009,
    RASCS_AuthProject          = 0x0000000a,
    RASCS_AuthLinkSpeed        = 0x0000000b,
    RASCS_AuthAck              = 0x0000000c,
    RASCS_ReAuthenticate       = 0x0000000d,
    RASCS_Authenticated        = 0x0000000e,
    RASCS_PrepareForCallback   = 0x0000000f,
    RASCS_WaitForModemReset    = 0x00000010,
    RASCS_WaitForCallback      = 0x00000011,
    RASCS_Projected            = 0x00000012,
    RASCS_StartAuthentication  = 0x00000013,
    RASCS_CallbackComplete     = 0x00000014,
    RASCS_LogonNetwork         = 0x00000015,
    RASCS_SubEntryConnected    = 0x00000016,
    RASCS_SubEntryDisconnected = 0x00000017,
    RASCS_ApplySettings        = 0x00000018,
    RASCS_Interactive          = 0x00001000,
    RASCS_RetryAuthentication  = 0x00001001,
    RASCS_CallbackSetByCaller  = 0x00001002,
    RASCS_PasswordExpired      = 0x00001003,
    RASCS_InvokeEapUI          = 0x00001004,
    RASCS_Connected            = 0x00002000,
    RASCS_Disconnected         = 0x00002001,
}

alias tagRASCONNSUBSTATE = int;
enum : int
{
    RASCSS_None         = 0x00000000,
    RASCSS_Dormant      = 0x00000001,
    RASCSS_Reconnecting = 0x00000002,
    RASCSS_Reconnected  = 0x00002000,
}

alias tagRASPROJECTION = int;
enum : int
{
    RASP_Amb     = 0x00010000,
    RASP_PppNbf  = 0x0000803f,
    RASP_PppIpx  = 0x0000802b,
    RASP_PppIp   = 0x00008021,
    RASP_PppCcp  = 0x000080fd,
    RASP_PppLcp  = 0x0000c021,
    RASP_PppIpv6 = 0x00008057,
}

///The <b>RASPROJECTION_INFO_TYPE</b> enumeration is used in the RAS_PROJECTION_INFO structure to represent either a
///RASPPP_PROJECTION_INFO or RASIKEV2_PROJECTION_INFO structure.
alias RASPROJECTION_INFO_TYPE = int;
enum : int
{
    ///Represents a RASPPP_PROJECTION_INFO structure.
    PROJECTION_INFO_TYPE_PPP   = 0x00000001,
    ///Represents a RASIKEV2_PROJECTION_INFO structure.
    PROJECTION_INFO_TYPE_IKEv2 = 0x00000002,
}

alias IKEV2_ID_PAYLOAD_TYPE = int;
enum : int
{
    IKEV2_ID_PAYLOAD_TYPE_INVALID      = 0x00000000,
    IKEV2_ID_PAYLOAD_TYPE_IPV4_ADDR    = 0x00000001,
    IKEV2_ID_PAYLOAD_TYPE_FQDN         = 0x00000002,
    IKEV2_ID_PAYLOAD_TYPE_RFC822_ADDR  = 0x00000003,
    IKEV2_ID_PAYLOAD_TYPE_RESERVED1    = 0x00000004,
    IKEV2_ID_PAYLOAD_TYPE_ID_IPV6_ADDR = 0x00000005,
    IKEV2_ID_PAYLOAD_TYPE_RESERVED2    = 0x00000006,
    IKEV2_ID_PAYLOAD_TYPE_RESERVED3    = 0x00000007,
    IKEV2_ID_PAYLOAD_TYPE_RESERVED4    = 0x00000008,
    IKEV2_ID_PAYLOAD_TYPE_DER_ASN1_DN  = 0x00000009,
    IKEV2_ID_PAYLOAD_TYPE_DER_ASN1_GN  = 0x0000000a,
    IKEV2_ID_PAYLOAD_TYPE_KEY_ID       = 0x0000000b,
    IKEV2_ID_PAYLOAD_TYPE_MAX          = 0x0000000c,
}

///The <b>ROUTER_INTERFACE_TYPE</b> type enumerates the different kinds of interfaces on a router.
alias ROUTER_INTERFACE_TYPE = int;
enum : int
{
    ///The interface is for a remote client.
    ROUTER_IF_TYPE_CLIENT      = 0x00000000,
    ///The interface is for a home router.
    ROUTER_IF_TYPE_HOME_ROUTER = 0x00000001,
    ///The interface is for a full router.
    ROUTER_IF_TYPE_FULL_ROUTER = 0x00000002,
    ///The interface is always connected. It is a LAN interface, or the interface is connected over a leased line.
    ROUTER_IF_TYPE_DEDICATED   = 0x00000003,
    ///The interface is an internal-only interface.
    ROUTER_IF_TYPE_INTERNAL    = 0x00000004,
    ///The interface is a loopback interface.
    ROUTER_IF_TYPE_LOOPBACK    = 0x00000005,
    ROUTER_IF_TYPE_TUNNEL1     = 0x00000006,
    ///The interface is a dial-on-demand (DOD) interface.
    ROUTER_IF_TYPE_DIALOUT     = 0x00000007,
    ROUTER_IF_TYPE_MAX         = 0x00000008,
}

///The <b>ROUTER_CONNECTION_STATE</b> type enumerates the possible states of an interface on a router.
alias ROUTER_CONNECTION_STATE = int;
enum : int
{
    ///The interface is unreachable. For a list of possible reasons, see Unreachability Reasons.
    ROUTER_IF_STATE_UNREACHABLE  = 0x00000000,
    ///The interface is reachable but disconnected.
    ROUTER_IF_STATE_DISCONNECTED = 0x00000001,
    ///The interface is in the process of connecting.
    ROUTER_IF_STATE_CONNECTING   = 0x00000002,
    ///The interface is connected.
    ROUTER_IF_STATE_CONNECTED    = 0x00000003,
}

///The <b>RAS_PORT_CONDITION</b> enumerated type specifies information regarding the connection condition of a given RAS
///port.
alias RAS_PORT_CONDITION = int;
enum : int
{
    ///The port is not operational.
    RAS_PORT_NON_OPERATIONAL = 0x00000000,
    ///The port is disconnected.
    RAS_PORT_DISCONNECTED    = 0x00000001,
    ///The port is in the process of a call back.
    RAS_PORT_CALLING_BACK    = 0x00000002,
    ///The port is listening for incoming calls.
    RAS_PORT_LISTENING       = 0x00000003,
    ///The port is authenticating a user.
    RAS_PORT_AUTHENTICATING  = 0x00000004,
    ///The port has authenticated a user.
    RAS_PORT_AUTHENTICATED   = 0x00000005,
    ///The port is initializing.
    RAS_PORT_INITIALIZING    = 0x00000006,
}

///The <b>RAS_HARDWARE_CONDITION</b> enumeration type specifies hardware status information about a given RAS port.
alias RAS_HARDWARE_CONDITION = int;
enum : int
{
    ///The port is operational.
    RAS_HARDWARE_OPERATIONAL = 0x00000000,
    ///The port is not operational, due to a hardware failure.
    RAS_HARDWARE_FAILURE     = 0x00000001,
}

///The <b>RAS_QUARANTINE_STATE</b> enumerated type indicates the quarantine state of a client connection.
alias RAS_QUARANTINE_STATE = int;
enum : int
{
    ///The connection state is normal.
    RAS_QUAR_STATE_NORMAL      = 0x00000000,
    ///The connection is quarantined.
    RAS_QUAR_STATE_QUARANTINE  = 0x00000001,
    ///The connection is in probation.
    RAS_QUAR_STATE_PROBATION   = 0x00000002,
    ///The connection state is unknown.
    RAS_QUAR_STATE_NOT_CAPABLE = 0x00000003,
}

///The <b>MPRAPI_OBJECT_TYPE</b> enumeration specifies the structure type in a MPRAPI_OBJECT_HEADER structure.
alias MPRAPI_OBJECT_TYPE = int;
enum : int
{
    ///The structure is a RAS_CONNECTION_EX structure.
    MPRAPI_OBJECT_TYPE_RAS_CONNECTION_OBJECT        = 0x00000001,
    ///The structure is a MPR_SERVER_EX structure.
    MPRAPI_OBJECT_TYPE_MPR_SERVER_OBJECT            = 0x00000002,
    ///The structure is a MPR_SERVER_SET_CONFIG_EX structure.
    MPRAPI_OBJECT_TYPE_MPR_SERVER_SET_CONFIG_OBJECT = 0x00000003,
    ///The structure is a AUTH_VALIDATION_EX structure.
    MPRAPI_OBJECT_TYPE_AUTH_VALIDATION_OBJECT       = 0x00000004,
    ///The structure is a [RAS_UPDATE_CONNECTION](/windows/desktop/api/mprapi/ns-mprapi-ras_update_connection)
    ///structure.
    MPRAPI_OBJECT_TYPE_UPDATE_CONNECTION_OBJECT     = 0x00000005,
    MPRAPI_OBJECT_TYPE_IF_CUSTOM_CONFIG_OBJECT      = 0x00000006,
}

alias MPR_VPN_TS_TYPE = int;
enum : int
{
    MPR_VPN_TS_IPv4_ADDR_RANGE = 0x00000007,
    MPR_VPN_TS_IPv6_ADDR_RANGE = 0x00000008,
}

///The <b>MGM_ENUM_TYPES</b> enumeration lists the types of group enumerations that the multicast group manager uses.
///This structure is used by the MgmGroupEnumerationStart function.
alias MGM_ENUM_TYPES = int;
enum : int
{
    ///Enumerate group entries that have at least one source.
    ANY_SOURCE  = 0x00000000,
    ///Enumerate all source entries for a group.
    ALL_SOURCES = 0x00000001,
}

///The <b>RTM_EVENT_TYPE</b> enumeration enumerates the events that the routing table manager can notify the client
///about using the RTM_EVENT_CALLBACK callback.
alias RTM_EVENT_TYPE = int;
enum : int
{
    ///A client has just registered with the routing table manager.
    RTM_ENTITY_REGISTERED   = 0x00000000,
    ///A client has just unregistered.
    RTM_ENTITY_DEREGISTERED = 0x00000001,
    ///A route has timed out.
    RTM_ROUTE_EXPIRED       = 0x00000002,
    ///A change notification has been made.
    RTM_CHANGE_NOTIFICATION = 0x00000003,
}

// Callbacks

///The <b>RasDialFunc</b> callback function is called by the RasDial function when a change of state occurs during a RAS
///connection process.
///Params:
///    Arg1 = 
///    Arg2 = 
///    Arg3 = 
alias RASDIALFUNC = void function(uint param0, tagRASCONNSTATE param1, uint param2);
///A <b>RasDialFunc1</b> function is called by the RasDial function when a change of state occurs during a remote access
///connection process. A <b>RasDialFunc1</b> function is comparable to a RasDialFunc function, but is enhanced by the
///addition of two parameters: a handle to the RAS connection, and an extended error code.
///Params:
///    Arg1 = 
///    Arg2 = 
///    Arg3 = 
///    Arg4 = 
///    Arg5 = 
alias RASDIALFUNC1 = void function(HRASCONN__* param0, uint param1, tagRASCONNSTATE param2, uint param3, 
                                   uint param4);
///A <b>RasDialFunc2</b> callback function is called by the RasDial function calls when a change of state occurs during
///a remote access connection process. A <b>RasDialFunc2</b> function is similar to the RasDialFunc1 callback function,
///except that it provides additional information for multilink connections.
///Params:
///    Arg1 = 
///    Arg2 = 
///    Arg3 = 
///    Arg4 = 
///    Arg5 = 
///    Arg6 = 
///    Arg7 = 
///Returns:
///    If the <b>RasDialFunc2</b> function returns a nonzero value, RasDial continues to send callback notifications. If
///    the <b>RasDialFunc2</b> function returns zero, RasDial stops sending callback notifications for all subentries.
///    
alias RASDIALFUNC2 = uint function(size_t param0, uint param1, HRASCONN__* param2, uint param3, 
                                   tagRASCONNSTATE param4, uint param5, uint param6);
///The <b>ORASADFunc</b> function is an application-defined callback function that is used to provide a customized user
///interface for autodialing. This prototype is provided for compatibility with earlier versions of Windows. New
///applications should use the RASADFunc callback function. Support for this prototype may be removed in future versions
///of RAS.
///Params:
///    Arg1 = 
///    Arg2 = 
///    Arg3 = 
///    Arg4 = 
///Returns:
///    If the callback function performs the dialing operation, return <b>TRUE</b>. Use the <i>lpdwRetCode</i> parameter
///    to indicate the results of the dialing operation. If the callback function does not perform the dialing
///    operation, return <b>FALSE</b>. In this case, the system uses the default user interface for dialing.
///    
alias ORASADFUNC = BOOL function(HWND param0, PSTR param1, uint param2, uint* param3);
///The <b>RASADFunc</b> function is an application-defined callback function that is used to provide a customized user
///interface for autodialing.
///Params:
///    Arg1 = 
///    Arg2 = 
///    Arg3 = 
///    Arg4 = 
///Returns:
///    If the application performs the dialing operation, return <b>TRUE</b>. Use the <i>lpdwRetCode</i> parameter to
///    indicate the results of the dialing operation. If the application does not perform the dialing operation, return
///    <b>FALSE</b>. In this case, the system uses the default user interface for dialing.
///    
alias RASADFUNCA = BOOL function(PSTR param0, PSTR param1, tagRASADPARAMS* param2, uint* param3);
///The <b>RASADFunc</b> function is an application-defined callback function that is used to provide a customized user
///interface for autodialing.
///Params:
///    Arg1 = 
///    Arg2 = 
///    Arg3 = 
///    Arg4 = 
///Returns:
///    If the application performs the dialing operation, return <b>TRUE</b>. Use the <i>lpdwRetCode</i> parameter to
///    indicate the results of the dialing operation. If the application does not perform the dialing operation, return
///    <b>FALSE</b>. In this case, the system uses the default user interface for dialing.
///    
alias RASADFUNCW = BOOL function(PWSTR param0, PWSTR param1, tagRASADPARAMS* param2, uint* param3);
///The custom-scripting DLL calls <i>RasGetBuffer</i> to allocate memory for sending or receiving data over the port
///connected to the server.
///Params:
///    ppBuffer = Pointer to a pointer that receives the address of the returned buffer.
///    pdwSize = Pointer to a <b>DWORD</b> variable that, on input, contains the requested size of the buffer. On output, this
///              variable contains the actual size of the buffer allocated.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    the following error code. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_OUT_OF_BUFFERS</b></dt> </dl> </td> <td width="60%"> RAS cannot allocate anymore buffer space. </td>
///    </tr> </table>
///    
alias PFNRASGETBUFFER = uint function(ubyte** ppBuffer, uint* pdwSize);
///The custom-scripting DLL calls <i>RasFreeBuffer</i> to release a memory buffer that was allocated by a previous call
///to RasGetBuffer.
///Params:
///    pBufer = 
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BUFFER_INVALID</b></dt> </dl> </td> <td width="60%"> The pointer to the buffer passed in the
///    <i>pBuffer</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PORT_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle specified by the <i>hPort</i>
///    parameter is invalid. </td> </tr> </table>
///    
alias PFNRASFREEBUFFER = uint function(ubyte* pBufer);
///The custom-scripting DLL calls the <i>RasSendBuffer</i> function to send data to the server over the specified port.
///The PFNRASSENDBUFFER type of the <b>RasCustomScriptExecute</b> callback defines a pointer to this function.
///<i>RasSendBuffer</i> is a placeholder for the application-defined function name.
///Params:
///    hPort = Handle to the port on which to send the data in the buffer. This handle should be the handle passed in by RAS as
///            the first parameter of the RasCustomScriptExecute function.
///    pBuffer = Pointer to a buffer of data to send over the port specified by the <i>hPort</i> parameter. Obtain this buffer
///              using RasGetBuffer function.
///    dwSize = Specifies the size of the data in the buffer pointed to by the <i>pBuffer</i> parameter.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value can
///    be one of the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_BUFFER_INVALID</b></dt> </dl> </td> <td width="60%"> The pointer to the buffer passed in the
///    <i>pBuffer</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PORT_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle specified by the <i>hPort</i>
///    parameter is invalid. </td> </tr> </table>
///    
alias PFNRASSENDBUFFER = uint function(HANDLE hPort, ubyte* pBuffer, uint dwSize);
///The custom-scripting DLL calls the <i>RasReceiveBuffer</i> function to inform RAS that it is ready to receive data
///from the server over the specified port. The PFNRASRECEIVEBUFFER type defines a pointer to this callback function.
///<i>RasReceiveBuffer</i> is a placeholder for the application-defined function name.
///Params:
///    hPort = Handle to the port on which to receive the data. This handle should be the handle passed in by RAS as the first
///            parameter of the RasCustomScriptExecute function.
///    pBuffer = Pointer to a buffer to receive the data from the port specified by the <i>hPort</i> parameter. Obtain this buffer
///              using RasGetBuffer function.
///    pdwSize = Pointer to a <b>DWORD</b> variable that receives the size of the data returned in the buffer pointed to by the
///              <i>pBuffer</i> parameter.
///    dwTimeOut = 
///    hEvent = Handle to an event object that RAS will signal when the received data is available.
///    dwTimeout = Specifies a time-out period in milliseconds after which the custom-scripting DLL will no longer wait for the
///                data.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value can
///    be one of the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_BUFFER_INVALID</b></dt> </dl> </td> <td width="60%"> The pointer to the buffer passed in the
///    <i>pBuffer</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PORT_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle specified by the <i>hPort</i>
///    parameter is invalid. </td> </tr> </table>
///    
alias PFNRASRECEIVEBUFFER = uint function(HANDLE hPort, ubyte* pBuffer, uint* pdwSize, uint dwTimeOut, 
                                          HANDLE hEvent);
///The custom-scripting DLL calls the <i>RasRetrieveBuffer</i> function to obtain data received from the RAS server over
///the specified port. The custom-scripting DLL should call <i>RasRetrieveBuffer</i> only after RAS has signaled the
///event object passed in the call to RasReceiveBuffer. The PFNRASRETRIEVEBUFFER type defines a pointer to this callback
///function. <i>RasRetrieveBuffer</i> is a placeholder for the application-defined function name.
///Params:
///    hPort = Handle to the port on which to receive the data. This handle should be the handle passed in by RAS as the first
///            parameter of the RasCustomScriptExecute function.
///    pBuffer = Pointer to a buffer to receive the data from the port specified by the <i>hPort</i> parameter. Obtain this buffer
///              using RasGetBuffer function. The value of this parameter may be the same as the pointer to the buffer passed into
///              the RasReceiveBuffer function.
///    pdwSize = Pointer to a <b>DWORD</b> variable that receives the size of the data returned in the buffer pointed to by the
///              <i>pBuffer</i> parameter.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value can
///    be one of the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_BUFFER_INVALID</b></dt> </dl> </td> <td width="60%"> The pointer to the buffer passed in the
///    <i>pBuffer</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PORT_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle specified by the <i>hPort</i>
///    parameter is invalid. </td> </tr> </table> RAS signals the event object if the port gets disconnected for some
///    reason before the data is posted. In this case, <i>RasRetrieveBuffer</i> returns an error defined in Raserror.h,
///    that indicates the cause of the failure.
///    
alias PFNRASRETRIEVEBUFFER = uint function(HANDLE hPort, ubyte* pBuffer, uint* pdwSize);
///RAS calls the <b>RasCustomScriptExecute</b> function when establishing a connection for a phone-book entry that has
///the RASEO_CustomScript option set.
///Params:
///    hPort = Handle to the port on which the connection is established. Use this handle when sending or receiving data on the
///            port.
///    lpszPhonebook = Pointer to a Unicode string that contains the path to the phone book in which the entry for the connection
///                    resides.
///    lpszEntryName = Pointer to a Unicode string that contains the name of the entry that was dialed to establish the connection.
///    pfnRasGetBuffer = Pointer to a function of type PFNRASGETBUFFER. The custom-scripting DLL should use this function to allocate
///                      memory to send data to the server.
///    pfnRasFreeBuffer = Pointer to a function of type PFNRASFREEBUFFER. The custom-scripting DLL should use this function to free memory
///                       allocated by the pfnRasGetBuffer function.
///    pfnRasSendBuffer = Pointer to a function of type PFNRASSENDBUFFER. The custom-scripting DLL uses this function to communicate with
///                       the server over the specified port.
///    pfnRasReceiveBuffer = Pointer to a function of type PFNRASRECEIVEBUFFER. The custom-scripting DLL uses this function to communicate
///                          with the server over the specified port.
///    pfnRasRetrieveBuffer = Pointer to a function of type PFNRASRETRIEVEBUFFER. The custom-scripting DLL uses this function to communicate
///                           with the server over the specified port.
///    hWnd = Handle to a window that the custom-scripting DLL can use to present a user interface to the user.
///    pRasDialParams = Pointer to a Unicode RASDIALPARAMS structure. This structure contains the authentication credentials for the
///                     user. The custom-scripting DLL can modify the <b>szUserName</b>, <b>szPassword</b>, and <b>szDomain</b> members
///                     of this structure. The Point-to-Point Protocol (PPP) will use whatever is stored in these members when
///                     <b>RasCustomScriptExecute</b> returns.
///    pvReserved = 
///Returns:
///    If the function succeeds, the return value should be <b>ERROR_SUCCESS</b>. If the function fails, the return
///    value should be an appropriate error code from Winerror.h or Raserror.h.
///    
alias RasCustomScriptExecuteFn = uint function(HANDLE hPort, const(PWSTR) lpszPhonebook, 
                                               const(PWSTR) lpszEntryName, PFNRASGETBUFFER pfnRasGetBuffer, 
                                               PFNRASFREEBUFFER pfnRasFreeBuffer, PFNRASSENDBUFFER pfnRasSendBuffer, 
                                               PFNRASRECEIVEBUFFER pfnRasReceiveBuffer, 
                                               PFNRASRETRIEVEBUFFER pfnRasRetrieveBuffer, HWND hWnd, 
                                               tagRASDIALPARAMSA* pRasDialParams, void* pvReserved);
///Call <b>RasSetCommSettings</b> from a custom-scripting DLL to change the settings on the port for the connection.
///Params:
///    hPort = Handle to the port on which to apply the settings. This handle is passed to the custom-scripting DLL in the
///            RasCustomScriptExecute function.
///    pRasCommSettings = Pointer to a RASCOMMSETTINGS structure that specifies the settings to be applied to the port.
///    pvReserved = Reserved for future use. This parameter must be <b>NULL</b>.
///Returns:
///    This callback function does not return a value.
///    
alias PFNRASSETCOMMSETTINGS = uint function(HANDLE hPort, tagRASCOMMSETTINGS* pRasCommSettings, void* pvReserved);
///The <b>RasCustomHangUp</b> function is an application-defined function that is exported by a third-party
///custom-dialing DLL. This function allows third-party vendors to implement custom connection hang-up routines.
///Params:
///    hRasConn = Handle to the RAS connection to hang up.
///Returns:
///    If the function succeeds, the return value should be <b>ERROR_SUCCESS</b>. If the function fails, the return
///    value should be a value from Routing and Remote Access Error Codes or Winerror.h.
///    
alias RasCustomHangUpFn = uint function(HRASCONN__* hRasConn);
///<p class="CCE_Message">[This function is not available as of Windows Server 2008. ] The <b>RasCustomDial</b> function
///is an application-defined function that is exported by a third-party custom-dialing DLL. This function allows
///third-party vendors to implement custom remote-access dialing routines.
///Params:
///    hInstDll = Handle to the instance of the custom-dial DLL that was loaded.
///    lpRasDialExtensions = Pointer to a RASDIALEXTENSIONS structure that specifies a set of RasDial extended features to enable. Set this
///                          parameter to <b>NULL</b> if there is no need to enable the extensions.
///    lpszPhonebook = Pointer to a <b>null</b>-terminated string that specifies the full path and file name of a phone-book (PBK) file.
///                    If this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book
///                    file is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up
///                    Networking</b> dialog box.
///    lpRasDialParams = Pointer to a RASDIALPARAMS structure that specifies calling parameters for the RAS connection. The caller must
///                      set the RASDIALPARAMS structure's <b>dwSize</b> member to sizeof(<b>RASDIALPARAMS</b>) to identify the version of
///                      the structure being passed.
///    dwNotifierType = This parameter is the same as the <i>dwNotifierType</i> parameter for the RasDial function. See the
///                     <b>RasDial</b> reference page for more information.
///    lpvNotifier = This parameter is the same as the <i>lpvNotifier</i> parameter for the RasDial function. See the <b>RasDial</b>
///                  reference page for more information.
///    lphRasConn = Pointer to a variable of type <b>HRASCONN</b>. Set the <b>HRASCONN</b> variable to <b>NULL</b> before calling
///                 RasDial. If <b>RasDial</b> succeeds, it stores a handle to the RAS connection into <i>*lphRasConn</i>.
///    dwFlags = This parameter reserved for future use.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b> and a handle to the RAS connection in the
///    variable pointed to by the <i>lphRasConn</i> parameter is returned. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt>
///    </dl> </td> <td width="60%"> The function could not allocate sufficient memory to complete the operation. </td>
///    </tr> </table>
///    
alias RasCustomDialFn = uint function(HINSTANCE hInstDll, tagRASDIALEXTENSIONS* lpRasDialExtensions, 
                                      const(PWSTR) lpszPhonebook, tagRASDIALPARAMSA* lpRasDialParams, 
                                      uint dwNotifierType, void* lpvNotifier, HRASCONN__** lphRasConn, uint dwFlags);
///The <i>RasCustomDeleteEntryNotify</i> function is an application-defined function that is exported by a third-party
///custom-dialing DLL. This function allows third-party vendors to implement custom dialogs for managing phone-book
///entries.
///Params:
///    lpszPhonebook = Pointer to a <b>null</b>-terminated string that specifies the full path and file name of a phone-book (PBK) file.
///                    If this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book
///                    file is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up
///                    Networking</b> dialog box.
///    lpszEntry = Pointer to a <b>null</b>-terminated string that contains the name of the phone-book entry to dial.
///    dwFlags = Specifies one or more of the following flags:
///Returns:
///    This function should return value <b>ERROR_SUCCESS</b> if successful.
///    
alias RasCustomDeleteEntryNotifyFn = uint function(const(PWSTR) lpszPhonebook, const(PWSTR) lpszEntry, 
                                                   uint dwFlags);
///The <b>RasPBDlgFunc</b> function is an application-defined callback function that receives notifications of user
///activity while the RasPhonebookDlg dialog box is open.
///Params:
///    Arg1 = 
///    Arg2 = 
///    Arg3 = 
///    Arg4 = 
alias RASPBDLGFUNCW = void function(size_t param0, uint param1, PWSTR param2, void* param3);
///The <b>RasPBDlgFunc</b> function is an application-defined callback function that receives notifications of user
///activity while the RasPhonebookDlg dialog box is open.
///Params:
///    Arg1 = 
///    Arg2 = 
///    Arg3 = 
///    Arg4 = 
alias RASPBDLGFUNCA = void function(size_t param0, uint param1, PSTR param2, void* param3);
///<p class="CCE_Message">[This function is not available as of Windows Server 2008. ] The <b>RasCustomDialDlg</b>
///function is an application-defined function that is exported by a third-party custom-dialing DLL. This function
///allows third-party vendors to implement custom RAS connection dialog boxes.
///Params:
///    hInstDll = Handle to the instance of the custom-dialing DLL that was loaded.
///    dwFlags = A set of bit flags that specify <b>RasCustomDialDlg</b> options. <table> <tr> <th>Value</th> <th>Meaning</th>
///              </tr> <tr> <td width="40%"><a id="RCD_Logon"></a><a id="rcd_logon"></a><a id="RCD_LOGON"></a><dl>
///              <dt><b>RCD_Logon</b></dt> </dl> </td> <td width="60%"> If this flag is set to one, the connection was dialed from
///              a Windows Logon context. RasDial uses this information to get the appropriate user preferences for the connection
///              entry. If <b>RasDial</b> is called from this entry point, the <i>dwfOptions</i> member of the
///              <i>lpRasDialExtension</i> parameter must have the <b>RDEOPT_NoUser</b> flag set to indicate the connection was
///              dialed from a Windows Logon context. </td> </tr> </table> <b>Windows Server 2003 and Windows XP/2000: </b>This
///              parameter is reserved and should not be used.
///    lpszPhonebook = Pointer to a <b>null</b>-terminated string that specifies the full path and file name of a phone-book (PBK) file.
///                    If this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book
///                    file is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up
///                    Networking</b> dialog box.
///    lpszEntry = Pointer to a <b>null</b>-terminated string that contains the name of the phone-book entry to dial.
///    lpszPhoneNumber = Pointer to a <b>null</b>-terminated string that contains a phone number that overrides the numbers stored in the
///                      phone-book entry. If this parameter is <b>NULL</b>, RasDialDlg uses the numbers in the phone-book entry.
///    lpInfo = Pointer to a RASDIALDLG structure that contains additional input and output parameters. On input, the
///             <b>dwSize</b> member of this structure must specify sizeof( <b>RASDIALDLG</b>). If an error occurs, the
///             <b>dwError</b> member returns an error code; otherwise, it returns zero.
///    pvInfo = Reserved for internal use. This parameter will always be <b>NULL</b>.
///Returns:
///    If the user creates, copies, or edits a phone-book entry, the return value should be <b>TRUE</b>. Otherwise, the
///    function should return <b>FALSE</b>. If an error occurs, RasCustomEntryDlg should set the <b>dwError</b> member
///    of the RASENTRYDLG structure to a value from Routing and Remote Access Error Codes or Winerror.h.
///    
alias RasCustomDialDlgFn = BOOL function(HINSTANCE hInstDll, uint dwFlags, PWSTR lpszPhonebook, PWSTR lpszEntry, 
                                         PWSTR lpszPhoneNumber, tagRASDIALDLG* lpInfo, void* pvInfo);
///The <b>RasCustomEntryDlg</b> function is an application-defined function that is exported by a third-party
///custom-dialing DLL. This function allows third-party vendors to implement custom dialogs for managing phone-book
///entries.
///Params:
///    hInstDll = Handle to the instance of the custom-dial DLL that was loaded.
///    lpszPhonebook = Pointer to a <b>null</b>-terminated string that specifies the full path and file name of a phone-book (PBK) file.
///                    If this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book
///                    file is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up
///                    Networking</b> dialog box.
///    lpszEntry = Pointer to a <b>null</b>-terminated string that contains the name of the phone-book entry to edit, copy, or
///                create. If you are editing or copying an entry, this parameter is the name of an existing phone-book entry. If
///                you are copying an entry, set the RASEDFLAG_CloneEntry flag in the <b>dwFlags</b> member of the RASENTRYDLG
///                structure. If you are creating an entry, this parameter is a default new entry name that the user can change. If
///                this parameter is <b>NULL</b>, the function provides a default name. If you are creating an entry, set the
///                RASEDFLAG_NewEntry flag in the <b>dwFlags</b> member of the RASENTRYDLG structure.
///    lpInfo = Pointer to a RASENTRYDLG structure that contains additional input and output parameters. On input, the
///             <b>dwSize</b> member of this structure must specify sizeof( <b>RASENTRYDLG</b>). Use the <b>dwSize</b> member to
///             indicate whether creating, editing, or copying an entry. If an error occurs, the <b>dwError</b> member returns an
///             error code; otherwise, it returns zero.
///    dwFlags = Reserved for future use.
///Returns:
///    If the user creates, copies, or edits a phone-book entry, the return value should be <b>TRUE</b>. Otherwise, the
///    function should return <b>FALSE</b>. If an error occurs, <b>RasCustomEntryDlg</b> should set the <b>dwError</b>
///    member of the RASENTRYDLG structure to a value from Routing and Remote Access Error Codes or Winerror.h.
///    
alias RasCustomEntryDlgFn = BOOL function(HINSTANCE hInstDll, PWSTR lpszPhonebook, PWSTR lpszEntry, 
                                          tagRASENTRYDLGA* lpInfo, uint dwFlags);
alias PMPRADMINGETIPADDRESSFORUSER = uint function(PWSTR param0, PWSTR param1, uint* param2, BOOL* param3);
alias PMPRADMINRELEASEIPADRESS = void function(PWSTR param0, PWSTR param1, uint* param2);
alias PMPRADMINGETIPV6ADDRESSFORUSER = uint function(PWSTR param0, PWSTR param1, in6_addr* param2, BOOL* param3);
alias PMPRADMINRELEASEIPV6ADDRESSFORUSER = void function(PWSTR param0, PWSTR param1, in6_addr* param2);
alias PMPRADMINACCEPTNEWCONNECTION = BOOL function(RAS_CONNECTION_0* param0, RAS_CONNECTION_1* param1);
alias PMPRADMINACCEPTNEWCONNECTION2 = BOOL function(RAS_CONNECTION_0* param0, RAS_CONNECTION_1* param1, 
                                                    RAS_CONNECTION_2* param2);
alias PMPRADMINACCEPTNEWCONNECTION3 = BOOL function(RAS_CONNECTION_0* param0, RAS_CONNECTION_1* param1, 
                                                    RAS_CONNECTION_2* param2, RAS_CONNECTION_3* param3);
alias PMPRADMINACCEPTNEWLINK = BOOL function(RAS_PORT_0* param0, RAS_PORT_1* param1);
alias PMPRADMINCONNECTIONHANGUPNOTIFICATION = void function(RAS_CONNECTION_0* param0, RAS_CONNECTION_1* param1);
alias PMPRADMINCONNECTIONHANGUPNOTIFICATION2 = void function(RAS_CONNECTION_0* param0, RAS_CONNECTION_1* param1, 
                                                             RAS_CONNECTION_2* param2);
alias PMPRADMINCONNECTIONHANGUPNOTIFICATION3 = void function(RAS_CONNECTION_0* param0, RAS_CONNECTION_1* param1, 
                                                             RAS_CONNECTION_2* param2, RAS_CONNECTION_3 param3);
alias PMPRADMINLINKHANGUPNOTIFICATION = void function(RAS_PORT_0* param0, RAS_PORT_1* param1);
alias PMPRADMINTERMINATEDLL = uint function();
alias PMPRADMINACCEPTREAUTHENTICATION = BOOL function(RAS_CONNECTION_0* param0, RAS_CONNECTION_1* param1, 
                                                      RAS_CONNECTION_2* param2, RAS_CONNECTION_3* param3);
alias PMPRADMINACCEPTNEWCONNECTIONEX = BOOL function(RAS_CONNECTION_EX* param0);
alias PMPRADMINACCEPTREAUTHENTICATIONEX = BOOL function(RAS_CONNECTION_EX* param0);
alias PMPRADMINACCEPTTUNNELENDPOINTCHANGEEX = BOOL function(RAS_CONNECTION_EX* param0);
alias PMPRADMINCONNECTIONHANGUPNOTIFICATIONEX = void function(RAS_CONNECTION_EX* param0);
alias PMPRADMINRASVALIDATEPREAUTHENTICATEDCONNECTIONEX = uint function(AUTH_VALIDATION_EX* param0);
alias RASSECURITYPROC = uint function();
///The <b>PMGM_RPF_CALLBACK</b> callback is a call into a routing protocol to determine if a given packet was received
///on the correct interface. This callback is invoked when a packet from a new source or destined for a new group is
///received. The multicast group manager invokes this callback to the routing protocol that owns the incoming interface
///towards the source.
///Params:
///    dwSourceAddr = Specifies the source address from which the multicast data was received. Zero indicates that data is received
///                   from all sources (a wildcard receiver for a group); otherwise, the value of <i>dwSourceAddr</i> is the IP address
///                   of the source or source network. To specify a range of source addresses, the multicast group manager specifies
///                   the source network using <i>dwSourceAddr</i>, and specifies a subnet mask using <i>dwSourceMask</i>.
///    dwSourceMask = Specifies the subnet mask that corresponds to <i>dwSourceAddr</i>. The <i>dwSourceAddr</i> and
///                   <i>dwSourceMask</i> parameters are used together to define a range of sources from which to receive multicast
///                   data. The multicast group manager specifies zero for this parameter if it also specified zero for
///                   <i>dwSourceAddr</i> (a wildcard receiver).
///    dwGroupAddr = Specifies the multicast group for which the data is destined. Zero indicates that all groups are received (a
///                  wildcard receiver); otherwise, the value of <i>dwGroupAddr</i> is the IP address of the group. To specify a range
///                  of group addresses, the multicast group manager specifies the group address using <i>dwGroupAddr</i>, and
///                  specifies a subnet mask using <i>dwGroupMask</i>.
///    dwGroupMask = Specifies the subnet mask that corresponds to <i>dwGroupAddr</i>. The <i>dwGroupAddr</i> and <i>dwGroupMask</i>
///                  parameters are used together to define a range of multicast groups. The multicast group manager specifies zero
///                  for this parameter if it also specified zero for <i>dwGroupAddr</i> (a wildcard receiver).
///    pdwInIfIndex = On input, a pointer to a <b>DWORD</b>-sized memory location that specifies the index of the interface on which
///                   data from the source is expected to be received, based on the multicast view of the routing table. On output,
///                   <i>pdwInIfIndex</i> points to a <b>DWORD</b>-sized memory location that contains the index of the interface on
///                   which the protocol expects to receive packets. The interface index may differ on output from the index specified
///                   on input.
///    pdwInIfNextHopAddr = On input, <i>pdwInIfNextHopAddr</i> specifies the address of the next hop that corresponds to the index specified
///                         by <i>dwIfIndex</i>. The <i>dwIfIndex</i> and <i>dwIfNextHopIPAddr</i> parameters uniquely identify a next hop on
///                         point-to-multipoint interfaces. A point-to-multipoint interface is a connection where one interface connects to
///                         multiple networks. Examples of point-to-multipoint interfaces include non-broadcast multiple access (NBMA)
///                         interfaces and the internal interface on which all dial-up clients connect. For broadcast interfaces (such as
///                         Ethernet interfaces) or point-to-point interfaces, which are identified by only the value of <i>dwIfIndex</i>,
///                         specify zero. On output, <i>pdwInIfNextHopAddr</i> points to the next hop that corresponds to
///                         <i>pdwInIfIndex</i>.
///    pdwUpStreamNbr = On input, <i>pdwUpStreamNbr</i> points to a <b>DWORD</b> value specifying the immediate upstream neighbor towards
///                     the source (the source is found in the multicast view of the routing table). On output, <i>pdwUpStreamNbr</i> may
///                     have been modified by the protocol. This parameter is for informational purposes only.
///    dwHdrSize = Specifies, in bytes, the size of the buffer pointed to by <i>pbPacketHdr</i>.
///    pbPacketHdr = Pointer to a buffer that contains the IP header of the packet, including the IP options and a fragment of the
///                  data. This parameter is used by those protocols that examine the contents of the packet header.
///    pbRoute = On input, <i>pbRoute</i> points to a buffer that contains the route towards the source. The buffer contains an
///              RTM_DEST_INFO structure. On output, <i>pbRoute</i> points to a buffer that contains the route used by the
///              protocol to determine the interface towards the source.
///Returns:
///    RRAS does not expect the application to return any specific value; any value returned is ignored by RRAS.
///    
alias PMGM_RPF_CALLBACK = uint function(uint dwSourceAddr, uint dwSourceMask, uint dwGroupAddr, uint dwGroupMask, 
                                        uint* pdwInIfIndex, uint* pdwInIfNextHopAddr, uint* pdwUpStreamNbr, 
                                        uint dwHdrSize, ubyte* pbPacketHdr, ubyte* pbRoute);
///The <b>PMGM_CREATION_ALERT_CALLBACK</b> callback is a call into a routing protocol. This call determines the subset
///of interfaces owned by the routing protocol on which a multicast packet from a new source should be forwarded. When a
///packet sent from a new source, or destined for a new group, arrives on an interface, the multicast group manager
///creates a new MFE. The multicast group manager then invokes this callback to those routing protocols that have
///outgoing interfaces in this new MFE. A routing protocol can choose to disable the forwarding of data from the source
///to the group on specific interfaces.
///Params:
///    dwSourceAddr = Specifies the source address from which the multicast data was received. Zero indicates that data is received
///                   from all sources (a wildcard receiver for a group); otherwise, the value of <i>dwSourceAddr</i> is the IP address
///                   of the source or source network. To specify a range of source addresses, the multicast group manager specifies
///                   the source network using <i>dwSourceAddr</i>, and specifies a subnet mask using <i>dwSourceMask</i>.
///    dwSourceMask = Specifies the subnet mask that corresponds to <i>dwSourceAddr</i>. The <i>dwSourceAddr</i> and
///                   <i>dwSourceMask</i> parameters are used together to define a range of sources from which to receive multicast
///                   data. The multicast group manager specifies zero for this parameter if it also specified zero for
///                   <i>dwSourceAddr</i> (a wildcard receiver).
///    dwGroupAddr = Specifies the multicast group for which the data is destined. Zero indicates that all groups are received (a
///                  wildcard receiver); otherwise, the value of <i>dwGroupAddr</i> is the IP address of the group. To specify a range
///                  of group addresses, the multicast group manager specifies the group address using <i>dwGroupAddr</i>, and
///                  specifies a subnet mask using <i>dwGroupMask</i>.
///    dwGroupMask = Specifies the subnet mask that corresponds to <i>dwGroupAddr</i>. The <i>dwGroupAddr</i> and <i>dwGroupMask</i>
///                  parameters are used together to define a range of multicast groups. The multicast group manager specifies zero
///                  for this parameter if it also specified zero for <i>dwGroupAddr</i> (a wildcard receiver).
///    dwInIfIndex = Specifies the interface on which the multicast data from the source should arrive.
///    dwInIfNextHopAddr = Specifies the address of the next hop that corresponds to the index specified by <i>dwIfIndex</i>. The
///                        <i>dwIfIndex</i> and <i>dwIfNextHopIPAddr</i> parameters uniquely identify a next hop on point-to-multipoint
///                        interfaces. A point-to-multipoint interface is a connection where one interface connects to multiple networks.
///                        Examples of point-to-multipoint interfaces include non-broadcast multiple access (NBMA) interfaces and the
///                        internal interface on which all dial-up clients connect. For broadcast interfaces (such as Ethernet interfaces)
///                        or point-to-point interfaces, which are identified by only the value of <i>dwIfIndex</i>, specify zero.
///    dwIfCount = Specifies the number of interfaces in the buffer pointed to by <i>pmieOutIfList</i>.
///    pmieOutIfList = On input, a pointer to a buffer that contains the set of interfaces owned by the protocol on which data will be
///                    forwarded. On output, the client can set the <b>bIsEnabled</b> member of the corresponding MGM_IF_ENTRY structure
///                    to <b>FALSE</b> to prevent forwarding on any of its interfaces. A client may not be required to prevent
///                    forwarding; such a client would accept the default value of <b>bIsEnabled</b>.
///Returns:
///    RRAS does not expect the application to return any specific value; any value returned is ignored by RRAS.
///    
alias PMGM_CREATION_ALERT_CALLBACK = uint function(uint dwSourceAddr, uint dwSourceMask, uint dwGroupAddr, 
                                                   uint dwGroupMask, uint dwInIfIndex, uint dwInIfNextHopAddr, 
                                                   uint dwIfCount, MGM_IF_ENTRY* pmieOutIfList);
///The <b>PMGM_PRUNE_ALERT_CALLBACK</b> callback is a call into a routing protocol to notify the protocol that receivers
///are no longer present on interfaces owned by other routing protocols.
///Params:
///    dwSourceAddr = Specifies the source address from which to stop receiving multicast data. Zero indicates to stop receiving data
///                   from all sources (a wildcard receiver for a group); otherwise, the value of <i>dwSourceAddr</i> is the IP address
///                   of the source or source network. To specify a range of source addresses, the multicast group manager specifies
///                   the source network using <i>dwSourceAddr</i>, and specifies a subnet mask using <i>dwSourceMask</i>.
///    dwSourceMask = Specifies the subnet mask that corresponds to <i>dwSourceAddr</i>. The <i>dwSourceAddr</i> and
///                   <i>dwSourceMask</i> parameters are used together to define a range of sources from which to stop receiving
///                   receive multicast data. The multicast group manager specifies zero for this parameter if it also specified zero
///                   for <i>dwSourceAddr</i> (a wildcard receiver).
///    dwGroupAddr = Specifies the multicast group for which to stop receiving data. Zero indicates to stop receiving data for all
///                  groups (a wildcard receiver); otherwise, the value of <i>dwGroupAddr</i> is the IP address of the group. To
///                  specify a range of group addresses, the multicast group manager specifies the group address using
///                  <i>dwGroupAddr</i>, and specifies a subnet mask using <i>dwGroupMask</i>.
///    dwGroupMask = Specifies the subnet mask that corresponds to <i>dwGroupAddr</i>. The <i>dwGroupAddr</i> and <i>dwGroupMask</i>
///                  parameters are used together to define a range of multicast groups. The multicast group manager specifies zero
///                  for this parameter if it also specified zero for <i>dwGroupAddr</i> (a wildcard receiver).
///    dwIfIndex = Specifies the interface on which to stop receiving multicast data.
///    dwIfNextHopAddr = Specifies the address of the next hop that corresponds to the index specified by <i>dwIfIndex</i>. The
///                      <i>dwIfIndex</i> and <i>dwIfNextHopIPAddr</i> parameters uniquely identify a next hop on point-to-multipoint
///                      interfaces. A point-to-multipoint interface is a connection where one interface connects to multiple networks.
///                      Examples of point-to-multipoint interfaces include non-broadcast multiple access (NBMA) interfaces and the
///                      internal interface on which all dial-up clients connect. For broadcast interfaces (such as Ethernet interfaces)
///                      or point-to-point interfaces, which are identified by only the value of <i>dwIfIndex</i>, specify zero.
///    bMemberDelete = Specifies whether the callback was invoked because the MgmAddGroupMembershipEntry was called by a client (the
///                    multicast group manager sets this parameter to <b>TRUE</b>), or because an MFE was created or updated (the
///                    multicast group manager sets this parameter to <b>FALSE</b>).
///    pdwTimeout = On input, <i>pdwTimeout</i> points to a <b>DWORD</b>-sized memory location. If <i>bMemberDelete</i> is
///                 <b>FALSE</b>, this parameter can be used to specify how long the corresponding MFE should remain in the multicast
///                 forwarding cache. If the client does not specify a value, the default value is 900 seconds. On output,
///                 <i>pdwTimeout</i> receives the time-out value, in seconds, for this MFE.
///Returns:
///    RRAS does not expect the application to return any specific value; any value returned is ignored by RRAS.
///    
alias PMGM_PRUNE_ALERT_CALLBACK = uint function(uint dwSourceAddr, uint dwSourceMask, uint dwGroupAddr, 
                                                uint dwGroupMask, uint dwIfIndex, uint dwIfNextHopAddr, 
                                                BOOL bMemberDelete, uint* pdwTimeout);
///The <b>PMGM_JOIN_ALERT_CALLBACK</b> callback is a call into a routing protocol to notify the protocol that new
///receivers are present for one or more groups on interfaces that are owned by other routing protocols. Once a routing
///protocol receives this callback, it should begin forwarding multicast data for the specified source and group.
///Params:
///    dwSourceAddr = Specifies the source address from which the multicast data was received. Zero indicates that data is received
///                   from all sources (a wildcard receiver for a group); otherwise, the value of <i>dwSourceAddr</i> is the IP address
///                   of the source or source network. To specify a range of source addresses, the multicast group manager specifies
///                   the source network using <i>dwSourceAddr</i>, and specifies a subnet mask using <i>dwSourceMask</i>.
///    dwSourceMask = Specifies the subnet mask that corresponds to <i>dwSourceAddr</i>. The <i>dwSourceAddr</i> and
///                   <i>dwSourceMask</i> parameters are used together to define a range of sources from which to receive multicast
///                   data. The multicast group manager specifies zero for this parameter if it also specified zero for
///                   <i>dwSourceAddr</i> (a wildcard receiver).
///    dwGroupAddr = Specifies the multicast group for which the data is destined. Zero indicates that all groups are received (a
///                  wildcard receiver); otherwise, the value of <i>dwGroupAddr</i> is the IP address of the group. To specify a range
///                  of group addresses, the multicast group manager specifies the group address using <i>dwGroupAddr</i>, and
///                  specifies a subnet mask using <i>dwGroupMask</i>.
///    dwGroupMask = Specifies the subnet mask that corresponds to <i>dwGroupAddr</i>. The <i>dwGroupAddr</i> and <i>dwGroupMask</i>
///                  parameters are used together to define a range of multicast groups. The multicast group manager specifies zero
///                  for this parameter if it also specified zero for <i>dwGroupAddr</i> (a wildcard receiver).
///    bMemberUpdate = Specifies whether the callback was invoked because the MgmAddGroupMembershipEntry was called by a client (the
///                    multicast group manager sets this parameter to <b>TRUE</b>), or because an MFE was created or updated (the
///                    multicast group manager sets this parameter to <b>FALSE</b>).
///Returns:
///    RRAS does not expect the application to return any specific value; any value returned is ignored by RRAS.
///    
alias PMGM_JOIN_ALERT_CALLBACK = uint function(uint dwSourceAddr, uint dwSourceMask, uint dwGroupAddr, 
                                               uint dwGroupMask, BOOL bMemberUpdate);
///The <b>PMGM_WRONG_IF_CALLBACK</b> is a call into a routing protocol to notify the protocol that a packet has been
///received from the specified source and for the specified group on the wrong interface.
///Params:
///    dwSourceAddr = Specifies the source address from which the multicast data was received. Zero indicates that data is received
///                   from all sources (a wildcard receiver for a group); otherwise, the value of <i>dwSourceAddr</i> is the IP address
///                   of the source or source network.
///    dwGroupAddr = Specifies the multicast group for which the data is destined. Zero indicates that all groups are received (a
///                  wildcard receiver); otherwise, the value of <i>dwGroupAddr</i> is the IP address of the group.
///    dwIfIndex = Specifies the interface on which the packet arrived.
///    dwIfNextHopAddr = Specifies the address of the next hop that corresponds to the index specified by <i>dwIfIndex</i>. The
///                      <i>dwIfIndex</i> and <i>dwIfNextHopIPAddr</i> parameters uniquely identify a next hop on point-to-multipoint
///                      interfaces. A point-to-multipoint interface is a connection where one interface connects to multiple networks.
///                      Examples of point-to-multipoint interfaces include non-broadcast multiple access (NBMA) interfaces and the
///                      internal interface on which all dial-up clients connect. For broadcast interfaces (such as Ethernet interfaces)
///                      or point-to-point interfaces, which are identified by only the value of <i>dwIfIndex</i>, specify zero.
///    dwHdrSize = Specifies, in bytes, the size of the buffer pointed to by <i>pbPacketHdr</i>.
///    pbPacketHdr = Pointer to a buffer that contains the IP header of the packet, including the IP options and a fragment of the
///                  data. This parameter is used by those protocols that examine the contents of the packet header.
///Returns:
///    RRAS does not expect the application to return any specific value; any value returned is ignored by RRAS.
///    
alias PMGM_WRONG_IF_CALLBACK = uint function(uint dwSourceAddr, uint dwGroupAddr, uint dwIfIndex, 
                                             uint dwIfNextHopAddr, uint dwHdrSize, ubyte* pbPacketHdr);
///The <b>PMGM_LOCAL_JOIN_CALLBACK</b> callback is a call into a routing protocol to notify the protocol that IGMP has
///detected new receivers for a group on an interface that is currently owned by the routing protocol. This callback is
///invoked when the MgmAddGroupMembershipEntry function is called by IGMP.
///Params:
///    dwSourceAddr = Specifies the source address from which the multicast data was received. Zero indicates that data is received
///                   from all sources (a wildcard receiver for a group); otherwise, the value of <i>dwSourceAddr</i> is the IP address
///                   of the source or source network. To specify a range of source addresses, the multicast group manager specifies
///                   the source network using <i>dwSourceAddr</i>, and specifies a subnet mask using <i>dwSourceMask</i>.
///    dwSourceMask = Specifies the subnet mask that corresponds to <i>dwSourceAddr</i>. The <i>dwSourceAddr</i> and
///                   <i>dwSourceMask</i> parameters are used together to define a range of sources from which to receive multicast
///                   data. The multicast group manager specifies zero for this parameter if it also specified zero for
///                   <i>dwSourceAddr</i> (a wildcard receiver).
///    dwGroupAddr = Specifies the multicast group for which the data is destined. Zero indicates that all groups are received (a
///                  wildcard receiver); otherwise the value of <i>dwGroupAddr</i> is the IP address of the group. To specify a range
///                  of group addresses, the multicast group manager specifies the group address using <i>dwGroupAddr</i>, and
///                  specifies a subnet mask using <i>dwGroupMask</i>.
///    dwGroupMask = Specifies the subnet mask that corresponds to <i>dwGroupAddr</i>. The <i>dwGroupAddr</i> and <i>dwGroupMask</i>
///                  parameters are used together to define a range of multicast groups. The multicast group manager specifies zero
///                  for this parameter if it also specified zero for <i>dwGroupAddr</i> (a wildcard receiver).
///    dwIfIndex = Specifies the interface on which the multicast data from the source should arrive.
///    dwIfNextHopAddr = Specifies the address of the next hop that corresponds to the index specified by <i>dwIfIndex</i>. The
///                      <i>dwIfIndex</i> and <i>dwIfNextHopIPAddr</i> parameters uniquely identify a next hop on point-to-multipoint
///                      interfaces. A point-to-multipoint interface is a connection where one interface connects to multiple networks.
///                      Examples of point-to-multipoint interfaces include non-broadcast multiple access (NBMA) interfaces and the
///                      internal interface on which all dial-up clients connect. For broadcast interfaces (such as Ethernet interfaces)
///                      or point-to-point interfaces, which are identified by only the value of <i>dwIfIndex</i>, specify zero.
///Returns:
///    RRAS does not expect the application to return any specific value; any value returned is ignored by RRAS.
///    
alias PMGM_LOCAL_JOIN_CALLBACK = uint function(uint dwSourceAddr, uint dwSourceMask, uint dwGroupAddr, 
                                               uint dwGroupMask, uint dwIfIndex, uint dwIfNextHopAddr);
///The <b>PMGM_LOCAL_LEAVE_CALLBACK</b> callback is a call into a routing protocol to notify the routing protocol that
///the IGMP has detected that it no longer has receivers for a group on an interface that is currently owned by the
///routing protocol. This callback is invoked when the MgmDeleteGroupMembershipEntry function is called by IGMP.
///Params:
///    dwSourceAddr = Specifies the source address from which to stop receiving multicast data. Zero indicates to stop receiving data
///                   from all sources (a wildcard receiver for a group); otherwise, the value of <i>dwSourceAddr</i> is the IP address
///                   of the source or source network. To specify a range of source addresses, the multicast group manager specifies
///                   the source network using <i>dwSourceAddr</i>, and specifies a subnet mask using <i>dwSourceMask</i>.
///    dwSourceMask = Specifies the subnet mask that corresponds to <i>dwSourceAddr</i>. The <i>dwSourceAddr</i> and
///                   <i>dwSourceMask</i> parameters are used together to define a range of sources from which to stop receiving
///                   multicast data. The multicast group manager specifies zero for this parameter if it also specified zero for
///                   <i>dwSourceAddr</i> (a wildcard receiver).
///    dwGroupAddr = Specifies the multicast group for which to stop receiving data. Zero indicates to stop receiving data for all
///                  groups (a wildcard receiver); otherwise, the value of <i>dwGroupAddr</i> is the IP address of the group. To
///                  specify a range of group addresses, the multicast group manager specifies the group address using
///                  <i>dwGroupAddr</i>, and specifies a subnet mask using <i>dwGroupMask</i>.
///    dwGroupMask = Specifies the subnet mask that corresponds to <i>dwGroupAddr</i>. The <i>dwGroupAddr</i> and <i>dwGroupMask</i>
///                  parameters are used together to define a range of multicast groups. The multicast group manager specifies zero
///                  for this parameter if it also specified zero for <i>dwGroupAddr</i> (a wildcard receiver).
///    dwIfIndex = Specifies the interface on which to stop receiving multicast data.
///    dwIfNextHopAddr = Specifies the address of the next hop that corresponds to the index specified by <i>dwIfIndex</i>. The
///                      <i>dwIfIndex</i> and <i>dwIfNextHopIPAddr</i> parameters uniquely identify a next hop on point-to-multipoint
///                      interfaces. A point-to-multipoint interface is a connection where one interface connects to multiple networks.
///                      Examples of point-to-multipoint interfaces include non-broadcast multiple access (NBMA) interfaces and the
///                      internal interface on which all dial-up clients connect. For broadcast interfaces (such as Ethernet interfaces)
///                      or point-to-point interfaces, which are identified by only the value of <i>dwIfIndex</i>, specify zero.
///Returns:
///    RRAS does not expect the application to return any specific value; any value returned is ignored by RRAS.
///    
alias PMGM_LOCAL_LEAVE_CALLBACK = uint function(uint dwSourceAddr, uint dwSourceMask, uint dwGroupAddr, 
                                                uint dwGroupMask, uint dwIfIndex, uint dwIfNextHopAddr);
///The <b>PMGM_DISABLE_IGMP_CALLBACK</b> callback is a call into IGMP to notify it that a routing protocol is taking or
///releasing ownership of an interface on which IGMP is enabled. When this callback is invoked, IGMP should stop adding
///and deleting group memberships on the specified interface.
///Params:
///    dwIfIndex = Specifies the interface on which to disable IGMP.
///    dwIfNextHopAddr = Specifies the address of the next hop that corresponds to the index specified by <i>dwIfIndex</i>. The
///                      <i>dwIfIndex</i> and <i>dwIfNextHopIPAddr</i> parameters uniquely identify a next hop on point-to-multipoint
///                      interfaces. A point-to-multipoint interface is a connection where one interface connects to multiple networks.
///                      Examples of point-to-multipoint interfaces include non-broadcast multiple access (NBMA) interfaces and the
///                      internal interface on which all dial-up clients connect. For broadcast interfaces (such as Ethernet interfaces)
///                      or point-to-point interfaces, which are identified by only the value of <i>dwIfIndex</i>, specify zero.
///Returns:
///    RRAS does not expect the application to return any specific value; any value returned is ignored by RRAS.
///    
alias PMGM_DISABLE_IGMP_CALLBACK = uint function(uint dwIfIndex, uint dwIfNextHopAddr);
///The <b>PMGM_ENABLE_IGMP_CALLBACK</b> callback is a call into IGMP to notify it that a routing protocol has finished
///taking or releasing ownership of an interface. When this callback is invoked, IGMP should add all its group
///memberships on the specified interface using calls to the MgmAddGroupMembershipEntry function.
///Params:
///    dwIfIndex = Specifies the index of the interface on which to enable IGMP.
///    dwIfNextHopAddr = Specifies the address of the next hop that corresponds to the index specified by <i>dwIfIndex</i>. The
///                      <i>dwIfIndex</i> and <i>dwIfNextHopIPAddr</i> parameters uniquely identify a next hop on point-to-multipoint
///                      interfaces. A point-to-multipoint interface is a connection where one interface connects to multiple networks.
///                      Examples of point-to-multipoint interfaces include non-broadcast multiple access (NBMA) interfaces and the
///                      internal interface on which all dial-up clients connect. For broadcast interfaces (such as Ethernet interfaces)
///                      or point-to-point interfaces, which are identified by only the value of <i>dwIfIndex</i>, specify zero.
///Returns:
///    RRAS does not expect the application to return any specific value; any value returned is ignored by RRAS.
///    
alias PMGM_ENABLE_IGMP_CALLBACK = uint function(uint dwIfIndex, uint dwIfNextHopAddr);
///The <b>RTM_EVENT_CALLBACK</b> callback is used by the routing table manager to inform a client that the specified
///event occurred.
///Params:
///    RtmRegHandle = Handle to the client to which the routing table manager is sending the notification.
///    EventType = Specifies the event about which the routing table manager is notifying the client. The following values are used.
///                <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RTM_ENTITY_REGISTERED"></a><a
///                id="rtm_entity_registered"></a><dl> <dt><b>RTM_ENTITY_REGISTERED</b></dt> </dl> </td> <td width="60%"> A client
///                has just registered with the routing table manager. </td> </tr> <tr> <td width="40%"><a
///                id="RTM_ENTITY_DEREGISTERED"></a><a id="rtm_entity_deregistered"></a><dl> <dt><b>RTM_ENTITY_DEREGISTERED</b></dt>
///                </dl> </td> <td width="60%"> A client has just unregistered. </td> </tr> <tr> <td width="40%"><a
///                id="RTM_ROUTE_EXPIRED"></a><a id="rtm_route_expired"></a><dl> <dt><b>RTM_ROUTE_EXPIRED</b></dt> </dl> </td> <td
///                width="60%"> A route has timed out. </td> </tr> <tr> <td width="40%"><a id="RTM_CHANGE_NOTIFICATION"></a><a
///                id="rtm_change_notification"></a><dl> <dt><b>RTM_CHANGE_NOTIFICATION</b></dt> </dl> </td> <td width="60%"> A
///                change notification has been made. </td> </tr> </table>
///    Context1 = For RTM_ENTITY_REGISTERED calls: Contains the handle to the entity that registered. For RTM_ENTITY_DEREGISTERED
///               calls: Contains the handle to the entity that unregistered. For RTM_ROUTE_EXPIRED calls: Contains the handle to
///               the route that timed out. For RTM_CHANGE_NOTIFICATION calls: Contains the handle to the change notification.
///    Context2 = For RTM_ENTITY_REGISTERED calls: Contains a pointer to the RTM_ENTITY_INFO structure referred to by the handle in
///               <i>Context1</i>. If the client must retain this information, the client must copy it to a structure it has
///               allocated. For RTM_ENTITY_DEREGISTERED calls: Contains a pointer to the RTM_ENTITY_INFO structure referred to by
///               the handle in <i>Context1</i>. If the client must retain this information, the client must copy it to a structure
///               it has allocated. For RTM_ROUTE_EXPIRED calls: Contains a pointer to the RTM_ROUTE_INFO structure referred to by
///               the handle in <i>Context1</i>. If the client must retain this information, the client must copy it to a structure
///               it has allocated. For RTM_CHANGE_NOTIFICATION calls: Contains the notification context that was given to the
///               client by a previous call to RtmRegisterForChangeNotification.
///Returns:
///    If the routing table manager issues an RTM_ROUTE_EXPIRED callback, and the client returns to the routing table
///    manager the value ERROR_NOT_SUPPORTED, the routing table manager will delete the route from the routing table.
///    All other errors returned by the client are ignored.
///    
alias _EVENT_CALLBACK = uint function(ptrdiff_t RtmRegHandle, RTM_EVENT_TYPE EventType, void* Context1, 
                                      void* Context2);
alias RTM_EVENT_CALLBACK = uint function();
alias PRTM_EVENT_CALLBACK = uint function();
///The <b>RTM_ENTITY_EXPORT_METHOD</b> callback is the prototype for any method exported by a client.
///Params:
///    CallerHandle = Handle to the calling client.
///    CalleeHandle = Handle to the client being called.
///    Input = Handle to the method to be invoked. Contains an input buffer.
///    Output = An array of RTM_ENTITY_METHOD_OUTPUT structures. Each structure consists of a (method identifier, correct output)
///             tuple.
alias _ENTITY_METHOD = void function(ptrdiff_t CallerHandle, ptrdiff_t CalleeHandle, 
                                     RTM_ENTITY_METHOD_INPUT* Input, RTM_ENTITY_METHOD_OUTPUT* Output);
alias RTM_ENTITY_EXPORT_METHOD = void function();
alias PRTM_ENTITY_EXPORT_METHOD = void function();

// Structs


struct RASIPADDR
{
    ubyte a;
    ubyte b;
    ubyte c;
    ubyte d;
}

struct tagRASTUNNELENDPOINT
{
    uint dwType;
union
    {
        in_addr  ipv4;
        in6_addr ipv6;
    }
}

struct HRASCONN__
{
    int unused;
}

struct tagRASCONNW
{
    uint        dwSize;
    HRASCONN__* hrasconn;
    ushort[257] szEntryName;
    ushort[17]  szDeviceType;
    ushort[129] szDeviceName;
    ushort[260] szPhonebook;
    uint        dwSubEntry;
    GUID        guidEntry;
    uint        dwFlags;
    LUID        luid;
    GUID        guidCorrelationId;
}

struct tagRASCONNA
{
    uint        dwSize;
    HRASCONN__* hrasconn;
    byte[257]   szEntryName;
    byte[17]    szDeviceType;
    byte[129]   szDeviceName;
    byte[260]   szPhonebook;
    uint        dwSubEntry;
    GUID        guidEntry;
    uint        dwFlags;
    LUID        luid;
    GUID        guidCorrelationId;
}

struct tagRASCONNSTATUSW
{
    uint                 dwSize;
    tagRASCONNSTATE      rasconnstate;
    uint                 dwError;
    ushort[17]           szDeviceType;
    ushort[129]          szDeviceName;
    ushort[129]          szPhoneNumber;
    tagRASTUNNELENDPOINT localEndPoint;
    tagRASTUNNELENDPOINT remoteEndPoint;
    tagRASCONNSUBSTATE   rasconnsubstate;
}

struct tagRASCONNSTATUSA
{
    uint                 dwSize;
    tagRASCONNSTATE      rasconnstate;
    uint                 dwError;
    byte[17]             szDeviceType;
    byte[129]            szDeviceName;
    byte[129]            szPhoneNumber;
    tagRASTUNNELENDPOINT localEndPoint;
    tagRASTUNNELENDPOINT remoteEndPoint;
    tagRASCONNSUBSTATE   rasconnsubstate;
}

struct tagRASDIALPARAMSW
{
    uint        dwSize;
    ushort[257] szEntryName;
    ushort[129] szPhoneNumber;
    ushort[129] szCallbackNumber;
    ushort[257] szUserName;
    ushort[257] szPassword;
    ushort[16]  szDomain;
    uint        dwSubEntry;
    size_t      dwCallbackId;
    uint        dwIfIndex;
    PWSTR       szEncPassword;
}

struct tagRASDIALPARAMSA
{
    uint      dwSize;
    byte[257] szEntryName;
    byte[129] szPhoneNumber;
    byte[129] szCallbackNumber;
    byte[257] szUserName;
    byte[257] szPassword;
    byte[16]  szDomain;
    uint      dwSubEntry;
    size_t    dwCallbackId;
    uint      dwIfIndex;
    PSTR      szEncPassword;
}

struct tagRASEAPINFO
{
    uint   dwSizeofEapInfo;
    ubyte* pbEapInfo;
}

///The <b>RASDEVSPECIFICINFO</b> structure is used to send a cookie for server validation and bypass point-to-point
///(PPP) authentication.
struct RASDEVSPECIFICINFO
{
    ///The size, in bytes, of the cookie in <b>pbDevSpecificInfo</b>.
    uint   dwSize;
    ///A pointer to a BLOB that contains the authentication cookie.
    ubyte* pbDevSpecificInfo;
}

struct tagRASDIALEXTENSIONS
{
    uint               dwSize;
    uint               dwfOptions;
    HWND               hwndParent;
    size_t             reserved;
    size_t             reserved1;
    tagRASEAPINFO      RasEapInfo;
    BOOL               fSkipPppAuth;
    RASDEVSPECIFICINFO RasDevSpecificInfo;
}

struct tagRASENTRYNAMEW
{
    uint        dwSize;
    ushort[257] szEntryName;
    uint        dwFlags;
    ushort[261] szPhonebookPath;
}

struct tagRASENTRYNAMEA
{
    uint      dwSize;
    byte[257] szEntryName;
    uint      dwFlags;
    byte[261] szPhonebookPath;
}

struct tagRASAMBW
{
    uint       dwSize;
    uint       dwError;
    ushort[17] szNetBiosError;
    ubyte      bLana;
}

struct tagRASAMBA
{
    uint     dwSize;
    uint     dwError;
    byte[17] szNetBiosError;
    ubyte    bLana;
}

struct tagRASPPPNBFW
{
    uint       dwSize;
    uint       dwError;
    uint       dwNetBiosError;
    ushort[17] szNetBiosError;
    ushort[17] szWorkstationName;
    ubyte      bLana;
}

struct tagRASPPPNBFA
{
    uint     dwSize;
    uint     dwError;
    uint     dwNetBiosError;
    byte[17] szNetBiosError;
    byte[17] szWorkstationName;
    ubyte    bLana;
}

struct tagRASIPXW
{
    uint       dwSize;
    uint       dwError;
    ushort[22] szIpxAddress;
}

struct tagRASPPPIPXA
{
    uint     dwSize;
    uint     dwError;
    byte[22] szIpxAddress;
}

struct tagRASPPPIPW
{
    uint       dwSize;
    uint       dwError;
    ushort[16] szIpAddress;
    ushort[16] szServerIpAddress;
    uint       dwOptions;
    uint       dwServerOptions;
}

struct tagRASPPPIPA
{
    uint     dwSize;
    uint     dwError;
    byte[16] szIpAddress;
    byte[16] szServerIpAddress;
    uint     dwOptions;
    uint     dwServerOptions;
}

struct tagRASPPPIPV6
{
    uint     dwSize;
    uint     dwError;
    ubyte[8] bLocalInterfaceIdentifier;
    ubyte[8] bPeerInterfaceIdentifier;
    ubyte[2] bLocalCompressionProtocol;
    ubyte[2] bPeerCompressionProtocol;
}

struct tagRASPPPLCPW
{
    uint         dwSize;
    BOOL         fBundled;
    uint         dwError;
    uint         dwAuthenticationProtocol;
    uint         dwAuthenticationData;
    uint         dwEapTypeId;
    uint         dwServerAuthenticationProtocol;
    uint         dwServerAuthenticationData;
    uint         dwServerEapTypeId;
    BOOL         fMultilink;
    uint         dwTerminateReason;
    uint         dwServerTerminateReason;
    ushort[1024] szReplyMessage;
    uint         dwOptions;
    uint         dwServerOptions;
}

struct tagRASPPPLCPA
{
    uint       dwSize;
    BOOL       fBundled;
    uint       dwError;
    uint       dwAuthenticationProtocol;
    uint       dwAuthenticationData;
    uint       dwEapTypeId;
    uint       dwServerAuthenticationProtocol;
    uint       dwServerAuthenticationData;
    uint       dwServerEapTypeId;
    BOOL       fMultilink;
    uint       dwTerminateReason;
    uint       dwServerTerminateReason;
    byte[1024] szReplyMessage;
    uint       dwOptions;
    uint       dwServerOptions;
}

struct tagRASPPPCCP
{
    uint dwSize;
    uint dwError;
    uint dwCompressionAlgorithm;
    uint dwOptions;
    uint dwServerCompressionAlgorithm;
    uint dwServerOptions;
}

///The <b>RASPPP_PROJECTION_INFO</b> structure contains information obtained during Point-to-Point (PPP) negotiation of
///Internet Protocol version 4 (IPv4) and IPv6 projection operations, and PPP Link Control Protocol (LCP)/multilink, and
///Compression Control Protocol (CCP) negotiation.
struct RASPPP_PROJECTION_INFO
{
    ///A value that specifies the result of PPP IPv4 network control protocol negotiation. A value of zero indicates
    ///Ipv4 has been negotiated successfully. A nonzero value indicates failure, and is the fatal error that occurred
    ///during the control protocol negotiation.
    uint     dwIPv4NegotiationError;
    ///A RASIPV4ADDR that contains a null-terminated Unicode string that specifies the IPv4 address of the local client.
    ///This string has the form "a.b.c.d". <b>ipv4Address</b> is valid only if <b>dwIPv4NegotiationError</b> is zero.
    in_addr  ipv4Address;
    ///A RASIPV4ADDR structure that contains a Unicode string that specifies the IPv4 address of the remote server. This
    ///string has the form "a.b.c.d". <b>ipv4ServerAddress</b> is valid only if <b>dwIPv4NegotiationError</b> is zero.
    ///If the address is not available, this member is an empty string.
    in_addr  ipv4ServerAddress;
    ///A value that specifies Internet Protocol Control Protocol (IPCP) options for the local client. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RASIPO_VJ"></a><a id="rasipo_vj"></a><dl>
    ///<dt><b>RASIPO_VJ</b></dt> </dl> </td> <td width="60%"> Indicates that IP datagrams sent by the local client are
    ///compressed using Van Jacobson compression. </td> </tr> </table>
    uint     dwIPv4Options;
    ///A value that specifies IPCP options for the remote server. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="RASIPO_VJ"></a><a id="rasipo_vj"></a><dl> <dt><b>RASIPO_VJ</b></dt> </dl> </td> <td
    ///width="60%"> Indicates that IP datagrams sent by the remote server (that is, received by the local computer) are
    ///compressed using Van Jacobson compression. </td> </tr> </table>
    uint     dwIPv4ServerOptions;
    ///A value that specifies the result of PPP IPv6 network control protocol negotiation. A value of zero indicates
    ///Ipv6 has been negotiated successfully. A nonzero value indicates failure, and is the fatal error that occurred
    ///during the control protocol negotiation.
    uint     dwIPv6NegotiationError;
    ///An array that specifies the 64-bit IPv6 interface identifier of the client. The last 64 bits of a 128-bit IPv6
    ///internet address are considered the "interface identifier," which provides a strong level of uniqueness for the
    ///preceding 64-bits. <b>bInterfaceIdentifier</b> must not be zero and is valid only if
    ///<b>dwIPv6NegotiationError</b> is zero.
    ubyte[8] bInterfaceIdentifier;
    ///An array that specifies the 64-bit IPv6 interface identifier of the server. The last 64 bits of a 128-bit IPv6
    ///internet address are considered the "interface identifier," which provides a strong level of uniqueness for the
    ///preceding 64-bits. <b>bServerInterfaceIdentifier</b> must not be zero and is valid only if
    ///<b>dwIPv6NegotiationError</b> is zero.
    ubyte[8] bServerInterfaceIdentifier;
    ///A <b>BOOL</b> that is <b>TRUE</b> if the connection is composed of multiple links and <b>FALSE</b> otherwise.
    BOOL     fBundled;
    ///A <b>BOOL</b> that is <b>TRUE</b> if the connection supports multiple links and <b>FALSE</b> otherwise.
    BOOL     fMultilink;
    ///A value that specifies the authentication protocol used to authenticate the local client. This member can be one
    ///of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="RASLCPAP_PAP"></a><a id="raslcpap_pap"></a><dl> <dt><b>RASLCPAP_PAP</b></dt> </dl> </td> <td width="60%">
    ///Password Authentication Protocol. </td> </tr> <tr> <td width="40%"><a id="RASLCPAP_SPAP"></a><a
    ///id="raslcpap_spap"></a><dl> <dt><b>RASLCPAP_SPAP</b></dt> </dl> </td> <td width="60%"> Shiva Password
    ///Authentication Protocol. </td> </tr> <tr> <td width="40%"><a id="RASLCPAP_CHAP"></a><a
    ///id="raslcpap_chap"></a><dl> <dt><b>RASLCPAP_CHAP</b></dt> </dl> </td> <td width="60%"> Challenge Handshake
    ///Authentication Protocol. </td> </tr> <tr> <td width="40%"><a id="RASLCPAP_EAP"></a><a id="raslcpap_eap"></a><dl>
    ///<dt><b>RASLCPAP_EAP</b></dt> </dl> </td> <td width="60%"> Extensible Authentication Protocol. </td> </tr>
    ///</table>
    uint     dwAuthenticationProtocol;
    ///A value that specifies additional information about the authentication protocol specified by
    ///<b>dwAuthenticationProtocol</b>. <b>dwAuthenticationData</b> and <b>dwServerAuthenticationData</b> when different
    ///authentication protocols on the client and server. This member can be one of the following values: <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RASLCPAD_CHAP_MD5"></a><a
    ///id="raslcpad_chap_md5"></a><dl> <dt><b>RASLCPAD_CHAP_MD5</b></dt> </dl> </td> <td width="60%"> MD5 CHAP. </td>
    ///</tr> <tr> <td width="40%"><a id="RASLCPAD_CHAP_MS"></a><a id="raslcpad_chap_ms"></a><dl>
    ///<dt><b>RASLCPAD_CHAP_MS</b></dt> </dl> </td> <td width="60%"> Microsoft CHAP. </td> </tr> <tr> <td width="40%"><a
    ///id="RASLCPAD_CHAP_MSV2"></a><a id="raslcpad_chap_msv2"></a><dl> <dt><b>RASLCPAD_CHAP_MSV2</b></dt> </dl> </td>
    ///<td width="60%"> Microsoft CHAP version 2. </td> </tr> </table>
    uint     dwAuthenticationData;
    ///A value that specifies the authentication protocol used to authenticate the remote server. This member can be one
    ///of the following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="RASLCPAP_PAP"></a><a id="raslcpap_pap"></a><dl> <dt><b>RASLCPAP_PAP</b></dt> </dl> </td> <td width="60%">
    ///Password Authentication Protocol. </td> </tr> <tr> <td width="40%"><a id="RASLCPAP_SPAP"></a><a
    ///id="raslcpap_spap"></a><dl> <dt><b>RASLCPAP_SPAP</b></dt> </dl> </td> <td width="60%"> Shiva Password
    ///Authentication Protocol. </td> </tr> <tr> <td width="40%"><a id="RASLCPAP_CHAP"></a><a
    ///id="raslcpap_chap"></a><dl> <dt><b>RASLCPAP_CHAP</b></dt> </dl> </td> <td width="60%"> Challenge Handshake
    ///Authentication Protocol. </td> </tr> <tr> <td width="40%"><a id="RASLCPAP_EAP"></a><a id="raslcpap_eap"></a><dl>
    ///<dt><b>RASLCPAP_EAP</b></dt> </dl> </td> <td width="60%"> Extensible Authentication Protocol. </td> </tr>
    ///</table>
    uint     dwServerAuthenticationProtocol;
    ///A value that specifies additional information about the authentication protocol specified by
    ///<b>dwServerAuthenticationProtocol</b>. <b>dwAuthenticationData</b> and <b>dwServerAuthenticationData</b> when
    ///different authentication protocols on the client and server. This member can be one of the following values:
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RASLCPAD_CHAP_MD5"></a><a
    ///id="raslcpad_chap_md5"></a><dl> <dt><b>RASLCPAD_CHAP_MD5</b></dt> </dl> </td> <td width="60%"> MD5 CHAP. </td>
    ///</tr> <tr> <td width="40%"><a id="RASLCPAD_CHAP_MS"></a><a id="raslcpad_chap_ms"></a><dl>
    ///<dt><b>RASLCPAD_CHAP_MS</b></dt> </dl> </td> <td width="60%"> Microsoft CHAP. </td> </tr> <tr> <td width="40%"><a
    ///id="RASLCPAD_CHAP_MSV2"></a><a id="raslcpad_chap_msv2"></a><dl> <dt><b>RASLCPAD_CHAP_MSV2</b></dt> </dl> </td>
    ///<td width="60%"> Microsoft CHAP version 2. </td> </tr> </table>
    uint     dwServerAuthenticationData;
    ///A value that specifies the type identifier of the Extensible Authentication Protocol (EAP) used to authenticate
    ///the local client. The value of this member is valid only if <b>dwAuthenticationProtocol</b> is
    ///<b>RASLCPAPP_EAP.</b>.
    uint     dwEapTypeId;
    ///A value that specifies the type identifier of the Extensible Authentication Protocol (EAP) used to authenticate
    ///the remote server. The value of this member is valid only if <b>dwRemoteAuthenticationProtocol</b> is
    ///<b>RASLCPAPP_EAP.</b>.
    uint     dwServerEapTypeId;
    ///A value that specifies information about LCP options in use by the local client. This member is a combination of
    ///the following flags: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="RASLCPO_PFC"></a><a id="raslcpo_pfc"></a><dl> <dt><b>RASLCPO_PFC</b></dt> </dl> </td> <td width="60%"> The
    ///connection is using Protocol Field Compression (RFC 1172). </td> </tr> <tr> <td width="40%"><a
    ///id="RASLCPO_ACFC"></a><a id="raslcpo_acfc"></a><dl> <dt><b>RASLCPO_ACFC</b></dt> </dl> </td> <td width="60%"> The
    ///connection is using Address and Control Field Compression (RFC 1172). </td> </tr> <tr> <td width="40%"><a
    ///id="RASLCPO_SSHF"></a><a id="raslcpo_sshf"></a><dl> <dt><b>RASLCPO_SSHF</b></dt> </dl> </td> <td width="60%"> The
    ///connection is using Short Sequence Number Header Format (see RFC 1990). </td> </tr> <tr> <td width="40%"><a
    ///id="RASLCPO_DES_56"></a><a id="raslcpo_des_56"></a><dl> <dt><b>RASLCPO_DES_56</b></dt> </dl> </td> <td
    ///width="60%"> The connection is using DES 56-bit encryption. </td> </tr> <tr> <td width="40%"><a
    ///id="RASLCPO_3_DES"></a><a id="raslcpo_3_des"></a><dl> <dt><b>RASLCPO_3_DES</b></dt> </dl> </td> <td width="60%">
    ///The connection is using Triple DES Encryption. </td> </tr> </table>
    uint     dwLcpOptions;
    ///A value that specifies information about LCP options in use by the remote server. This member is a combination of
    ///the following flags: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="RASLCPO_PFC"></a><a id="raslcpo_pfc"></a><dl> <dt><b>RASLCPO_PFC</b></dt> </dl> </td> <td width="60%"> The
    ///connection is using Protocol Field Compression (RFC 1172). </td> </tr> <tr> <td width="40%"><a
    ///id="RASLCPO_ACFC"></a><a id="raslcpo_acfc"></a><dl> <dt><b>RASLCPO_ACFC</b></dt> </dl> </td> <td width="60%"> The
    ///connection is using Address and Control Field Compression (RFC 1172). </td> </tr> <tr> <td width="40%"><a
    ///id="RASLCPO_SSHF"></a><a id="raslcpo_sshf"></a><dl> <dt><b>RASLCPO_SSHF</b></dt> </dl> </td> <td width="60%"> The
    ///connection is using Short Sequence Number Header Format (see RFC 1990). </td> </tr> <tr> <td width="40%"><a
    ///id="RASLCPO_DES_56"></a><a id="raslcpo_des_56"></a><dl> <dt><b>RASLCPO_DES_56</b></dt> </dl> </td> <td
    ///width="60%"> The connection is using DES 56-bit encryption. </td> </tr> <tr> <td width="40%"><a
    ///id="RASLCPO_3_DES"></a><a id="raslcpo_3_des"></a><dl> <dt><b>RASLCPO_3_DES</b></dt> </dl> </td> <td width="60%">
    ///The connection is using Triple DES Encryption. </td> </tr> </table>
    uint     dwLcpServerOptions;
    uint     dwCcpError;
    ///A value that specifies the compression algorithm used by the local client. The following table shows the possible
    ///values for this member. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="RASCCPCA_MPPC"></a><a id="rasccpca_mppc"></a><dl> <dt><b>RASCCPCA_MPPC</b></dt> </dl> </td> <td width="60%">
    ///Microsoft Point-to-Point Compression (MPPC) Protocol (RFC 2118). </td> </tr> <tr> <td width="40%"><a
    ///id="RASCCPCA_STAC"></a><a id="rasccpca_stac"></a><dl> <dt><b>RASCCPCA_STAC</b></dt> </dl> </td> <td width="60%">
    ///STAC option 4 (RFC 1974). </td> </tr> </table>
    uint     dwCcpCompressionAlgorithm;
    ///A value that specifies the compression algorithm used by the remote server. The following algorithms are
    ///supported: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RASCCPCA_MPPC"></a><a
    ///id="rasccpca_mppc"></a><dl> <dt><b>RASCCPCA_MPPC</b></dt> </dl> </td> <td width="60%"> Microsoft Point-to-Point
    ///Compression (MPPC) Protocol ( RFC 2118). </td> </tr> <tr> <td width="40%"><a id="RASCCPCA_STAC"></a><a
    ///id="rasccpca_stac"></a><dl> <dt><b>RASCCPCA_STAC</b></dt> </dl> </td> <td width="60%"> STAC option 4 ( RFC 1974).
    ///</td> </tr> </table>
    uint     dwCcpServerCompressionAlgorithm;
    ///A value that specifies the compression types available on the local client. The following types are supported:
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RASCCPO_COMPRESSION"></a><a
    ///id="rasccpo_compression"></a><dl> <dt><b>RASCCPO_COMPRESSION</b></dt> </dl> </td> <td width="60%"> Compression
    ///without encryption. </td> </tr> <tr> <td width="40%"><a id="RASCCPO_HISTORYLESS"></a><a
    ///id="rasccpo_historyless"></a><dl> <dt><b>RASCCPO_HISTORYLESS</b></dt> </dl> </td> <td width="60%"> Microsoft
    ///Point-to-Point Encryption (MPPE) in stateless mode. The session key is changed after every packet. This mode
    ///improves performance on high latency networks, or networks that experience significant packet loss. </td> </tr>
    ///<tr> <td width="40%"><a id="RASCCPO_ENCRYPTION40BITOLD"></a><a id="rasccpo_encryption40bitold"></a><dl>
    ///<dt><b>RASCCPO_ENCRYPTION40BITOLD</b></dt> </dl> </td> <td width="60%"> MPPE compression using 40-bit keys. </td>
    ///</tr> <tr> <td width="40%"><a id="RASCCPO_ENCRYPTION40BIT"></a><a id="rasccpo_encryption40bit"></a><dl>
    ///<dt><b>RASCCPO_ENCRYPTION40BIT</b></dt> </dl> </td> <td width="60%"> MPPE compression using 40-bit keys. </td>
    ///</tr> <tr> <td width="40%"><a id="RASCCPO_ENCRYPTION56BIT"></a><a id="rasccpo_encryption56bit"></a><dl>
    ///<dt><b>RASCCPO_ENCRYPTION56BIT</b></dt> </dl> </td> <td width="60%"> MPPE compression using 56-bit keys. </td>
    ///</tr> <tr> <td width="40%"><a id="RASCCPO_ENCRYPTION128BIT"></a><a id="rasccpo_encryption128bit"></a><dl>
    ///<dt><b>RASCCPO_ENCRYPTION128BIT</b></dt> </dl> </td> <td width="60%"> MPPE compression using 128-bit keys. </td>
    ///</tr> </table>
    uint     dwCcpOptions;
    ///A value that specifies the compression types available on the remote server. The following types are supported:
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RASCCPO_COMPRESSION"></a><a
    ///id="rasccpo_compression"></a><dl> <dt><b>RASCCPO_COMPRESSION</b></dt> </dl> </td> <td width="60%"> Compression
    ///without encryption. </td> </tr> <tr> <td width="40%"><a id="RASCCPO_HISTORYLESS"></a><a
    ///id="rasccpo_historyless"></a><dl> <dt><b>RASCCPO_HISTORYLESS</b></dt> </dl> </td> <td width="60%"> Microsoft
    ///Point-to-Point Encryption (MPPE) in stateless mode. The session key is changed after every packet. This mode
    ///improves performance on high latency networks, or networks that experience significant packet loss. </td> </tr>
    ///<tr> <td width="40%"><a id="RASCCPO_ENCRYPTION40BITOLD"></a><a id="rasccpo_encryption40bitold"></a><dl>
    ///<dt><b>RASCCPO_ENCRYPTION40BITOLD</b></dt> </dl> </td> <td width="60%"> MPPE compression using 40-bit keys. </td>
    ///</tr> <tr> <td width="40%"><a id="RASCCPO_ENCRYPTION40BIT"></a><a id="rasccpo_encryption40bit"></a><dl>
    ///<dt><b>RASCCPO_ENCRYPTION40BIT</b></dt> </dl> </td> <td width="60%"> MPPE compression using 40-bit keys. </td>
    ///</tr> <tr> <td width="40%"><a id="RASCCPO_ENCRYPTION56BIT"></a><a id="rasccpo_encryption56bit"></a><dl>
    ///<dt><b>RASCCPO_ENCRYPTION56BIT</b></dt> </dl> </td> <td width="60%"> MPPE compression using 56-bit keys. </td>
    ///</tr> <tr> <td width="40%"><a id="RASCCPO_ENCRYPTION128BIT"></a><a id="rasccpo_encryption128bit"></a><dl>
    ///<dt><b>RASCCPO_ENCRYPTION128BIT</b></dt> </dl> </td> <td width="60%"> MPPE compression using 128-bit keys. </td>
    ///</tr> </table>
    uint     dwCcpServerOptions;
}

///The <b>RASIKEV2_PROJECTION_INFO</b> structure contains projection information obtained during Internet Key Exchange
///(IKE) negotiation.
struct RASIKEV2_PROJECTION_INFO
{
    ///A value that specifies the result of IPv4 negotiation. A value of zero indicates an IPv4 address has been
    ///assigned successfully. A nonzero value indicates failure, and is the fatal error that occurred during
    ///negotiation.
    uint      dwIPv4NegotiationError;
    ///A RASIPV4ADDR structure that contains a null-terminated Unicode string that specifies the IPv4 address of the
    ///local client. This string has the form "a.b.c.d". <b>ipv4Address</b> is valid only if
    ///<b>dwIPv4NegotiationError</b> is zero.
    in_addr   ipv4Address;
    ///A RASIPV4ADDR structure that contains a null-terminated Unicode string that specifies the IPv4 address of the
    ///remote server. This string has the form "a.b.c.d". <b>ipv4ServerAddress</b> is valid only if
    ///<b>dwIPv4NegotiationError</b> is zero. If the address is not available, this member is an empty string.
    in_addr   ipv4ServerAddress;
    ///A value that specifies the result of IPv6 negotiation. A value of zero indicates an IPv6 address has been
    ///negotiated successfully. A nonzero value indicates failure, and is the fatal error that occurred during
    ///negotiation.
    uint      dwIPv6NegotiationError;
    ///A RASIPV6ADDR structure that contains a null-terminated Unicode string that specifies the IPv6 address of the
    ///local client. <b>ipv6Address</b> is valid only if <b>dwIPv6NegotiationError</b> is zero.
    in6_addr  ipv6Address;
    ///A RASIPV6ADDR structure that contains a null-terminated Unicode string that specifies the IPv6 address of the
    ///remote server. <b>ipv6ServerAddress</b> is valid only if <b>dwIPv6NegotiationError</b> is zero. If the address is
    ///not available, this member is an empty string.
    in6_addr  ipv6ServerAddress;
    ///A value that specifies the length, in bits, of the IPv6 address prefix.
    uint      dwPrefixLength;
    ///A value that specifies the authentication protocol used to authenticate the remote server. The following
    ///authentication protocols are supported: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="RASIKEv2_AUTH_MACHINECERTIFICATES"></a><a id="rasikev2_auth_machinecertificates"></a><a
    ///id="RASIKEV2_AUTH_MACHINECERTIFICATES"></a><dl> <dt><b>RASIKEv2_AUTH_MACHINECERTIFICATES</b></dt> </dl> </td> <td
    ///width="60%"> X.509 Public Key Infrastructure Certificate (RFC 2459). </td> </tr> <tr> <td width="40%"><a
    ///id="RASIKEv2_AUTH_EAP"></a><a id="rasikev2_auth_eap"></a><a id="RASIKEV2_AUTH_EAP"></a><dl>
    ///<dt><b>RASIKEv2_AUTH_EAP</b></dt> </dl> </td> <td width="60%"> Extensible Authentication Protocol. </td> </tr>
    ///</table>
    uint      dwAuthenticationProtocol;
    ///A value that specifies the type identifier of the Extensible Authentication Protocol (EAP) used to authenticate
    ///the local client. The value of this member is valid only if <b>dwAuthenticationProtocol</b> is
    ///<b>RASIKEv2_AUTH_EAP</b>.
    uint      dwEapTypeId;
    ///A bitmap of flags that can be any combination of the following values: <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="RASIKEv2_FLAGS_MOBIKESUPPORTED"></a><a
    ///id="rasikev2_flags_mobikesupported"></a><a id="RASIKEV2_FLAGS_MOBIKESUPPORTED"></a><dl>
    ///<dt><b>RASIKEv2_FLAGS_MOBIKESUPPORTED</b></dt> </dl> </td> <td width="60%"> The client supports Mobile IKE
    ///(MOBIKE). </td> </tr> <tr> <td width="40%"><a id="RASIKEv2_FLAGS_BEHIND_NAT"></a><a
    ///id="rasikev2_flags_behind_nat"></a><a id="RASIKEV2_FLAGS_BEHIND_NAT"></a><dl>
    ///<dt><b>RASIKEv2_FLAGS_BEHIND_NAT</b></dt> </dl> </td> <td width="60%"> The client is behind Network Address
    ///Translation (NAT). </td> </tr> <tr> <td width="40%"><a id="RASIKEv2_FLAGS_SERVERBEHIND_NAT"></a><a
    ///id="rasikev2_flags_serverbehind_nat"></a><a id="RASIKEV2_FLAGS_SERVERBEHIND_NAT"></a><dl>
    ///<dt><b>RASIKEv2_FLAGS_SERVERBEHIND_NAT</b></dt> </dl> </td> <td width="60%"> The server is behind Network Address
    ///Translation (NAT). </td> </tr> </table>
    uint      dwFlags;
    ///A value that specifies the encryption method used in the connection. The following encryption methods are
    ///supported: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_CIPHER_TYPE_3DES"></a><a id="ipsec_cipher_type_3des"></a><dl> <dt><b>IPSEC_CIPHER_TYPE_3DES</b></dt>
    ///</dl> </td> <td width="60%"> 3DES encryption. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_CIPHER_TYPE_AES_128"></a><a id="ipsec_cipher_type_aes_128"></a><dl>
    ///<dt><b>IPSEC_CIPHER_TYPE_AES_128</b></dt> </dl> </td> <td width="60%"> AES-128 encryption. </td> </tr> <tr> <td
    ///width="40%"><a id="IPSEC_CIPHER_TYPE_AES_192"></a><a id="ipsec_cipher_type_aes_192"></a><dl>
    ///<dt><b>IPSEC_CIPHER_TYPE_AES_192</b></dt> </dl> </td> <td width="60%"> AES-192 encryption. </td> </tr> <tr> <td
    ///width="40%"><a id="IPSEC_CIPHER_TYPE_AES_256"></a><a id="ipsec_cipher_type_aes_256"></a><dl>
    ///<dt><b>IPSEC_CIPHER_TYPE_AES_256</b></dt> </dl> </td> <td width="60%"> AES-256 encryption. </td> </tr> </table>
    uint      dwEncryptionMethod;
    ///The number of available IPv4 addresses the server can switch to on the IKEv2 connection.
    uint      numIPv4ServerAddresses;
    ///A pointer to a RASIPV4ADDR structure that contains the available IPv4 addresses the server can switch to on the
    ///IKEv2 connection.
    in_addr*  ipv4ServerAddresses;
    ///The number of available IPv6 addresses the server can switch to on the IKEv2 connection.
    uint      numIPv6ServerAddresses;
    ///A pointer to a RASIPV6ADDR structure that contains the available IPv6 addresses the server can switch to on the
    ///IKEv2 connection.
    in6_addr* ipv6ServerAddresses;
}

///The <b>RAS_PROJECTION_INFO</b> structure contains the Point-to-Point (PPP) or Internet Key Exchange version 2 (IKEv2)
///projection information for a RAS connection.
struct RAS_PROJECTION_INFO
{
    ///A RASAPIVERSION value that specifies the structure version.
    RASAPIVERSION version_;
    ///A RASPROJECTION_INFO_TYPE value that specifies the connection type in <b>union</b>.
    RASPROJECTION_INFO_TYPE type;
union
    {
        RASPPP_PROJECTION_INFO ppp;
        RASIKEV2_PROJECTION_INFO ikev2;
    }
}

struct tagRASDEVINFOW
{
    uint        dwSize;
    ushort[17]  szDeviceType;
    ushort[129] szDeviceName;
}

struct tagRASDEVINFOA
{
    uint      dwSize;
    byte[17]  szDeviceType;
    byte[129] szDeviceName;
}

struct RASCTRYINFO
{
    uint dwSize;
    uint dwCountryID;
    uint dwNextCountryID;
    uint dwCountryCode;
    uint dwCountryNameOffset;
}

struct tagRASENTRYA
{
    uint      dwSize;
    uint      dwfOptions;
    uint      dwCountryID;
    uint      dwCountryCode;
    byte[11]  szAreaCode;
    byte[129] szLocalPhoneNumber;
    uint      dwAlternateOffset;
    RASIPADDR ipaddr;
    RASIPADDR ipaddrDns;
    RASIPADDR ipaddrDnsAlt;
    RASIPADDR ipaddrWins;
    RASIPADDR ipaddrWinsAlt;
    uint      dwFrameSize;
    uint      dwfNetProtocols;
    uint      dwFramingProtocol;
    byte[260] szScript;
    byte[260] szAutodialDll;
    byte[260] szAutodialFunc;
    byte[17]  szDeviceType;
    byte[129] szDeviceName;
    byte[33]  szX25PadType;
    byte[201] szX25Address;
    byte[201] szX25Facilities;
    byte[201] szX25UserData;
    uint      dwChannels;
    uint      dwReserved1;
    uint      dwReserved2;
    uint      dwSubEntries;
    uint      dwDialMode;
    uint      dwDialExtraPercent;
    uint      dwDialExtraSampleSeconds;
    uint      dwHangUpExtraPercent;
    uint      dwHangUpExtraSampleSeconds;
    uint      dwIdleDisconnectSeconds;
    uint      dwType;
    uint      dwEncryptionType;
    uint      dwCustomAuthKey;
    GUID      guidId;
    byte[260] szCustomDialDll;
    uint      dwVpnStrategy;
    uint      dwfOptions2;
    uint      dwfOptions3;
    byte[256] szDnsSuffix;
    uint      dwTcpWindowSize;
    byte[260] szPrerequisitePbk;
    byte[257] szPrerequisiteEntry;
    uint      dwRedialCount;
    uint      dwRedialPause;
    in6_addr  ipv6addrDns;
    in6_addr  ipv6addrDnsAlt;
    uint      dwIPv4InterfaceMetric;
    uint      dwIPv6InterfaceMetric;
    in6_addr  ipv6addr;
    uint      dwIPv6PrefixLength;
    uint      dwNetworkOutageTime;
    byte[257] szIDi;
    byte[257] szIDr;
    BOOL      fIsImsConfig;
    IKEV2_ID_PAYLOAD_TYPE IdiType;
    IKEV2_ID_PAYLOAD_TYPE IdrType;
    BOOL      fDisableIKEv2Fragmentation;
}

struct tagRASENTRYW
{
    uint        dwSize;
    uint        dwfOptions;
    uint        dwCountryID;
    uint        dwCountryCode;
    ushort[11]  szAreaCode;
    ushort[129] szLocalPhoneNumber;
    uint        dwAlternateOffset;
    RASIPADDR   ipaddr;
    RASIPADDR   ipaddrDns;
    RASIPADDR   ipaddrDnsAlt;
    RASIPADDR   ipaddrWins;
    RASIPADDR   ipaddrWinsAlt;
    uint        dwFrameSize;
    uint        dwfNetProtocols;
    uint        dwFramingProtocol;
    ushort[260] szScript;
    ushort[260] szAutodialDll;
    ushort[260] szAutodialFunc;
    ushort[17]  szDeviceType;
    ushort[129] szDeviceName;
    ushort[33]  szX25PadType;
    ushort[201] szX25Address;
    ushort[201] szX25Facilities;
    ushort[201] szX25UserData;
    uint        dwChannels;
    uint        dwReserved1;
    uint        dwReserved2;
    uint        dwSubEntries;
    uint        dwDialMode;
    uint        dwDialExtraPercent;
    uint        dwDialExtraSampleSeconds;
    uint        dwHangUpExtraPercent;
    uint        dwHangUpExtraSampleSeconds;
    uint        dwIdleDisconnectSeconds;
    uint        dwType;
    uint        dwEncryptionType;
    uint        dwCustomAuthKey;
    GUID        guidId;
    ushort[260] szCustomDialDll;
    uint        dwVpnStrategy;
    uint        dwfOptions2;
    uint        dwfOptions3;
    ushort[256] szDnsSuffix;
    uint        dwTcpWindowSize;
    ushort[260] szPrerequisitePbk;
    ushort[257] szPrerequisiteEntry;
    uint        dwRedialCount;
    uint        dwRedialPause;
    in6_addr    ipv6addrDns;
    in6_addr    ipv6addrDnsAlt;
    uint        dwIPv4InterfaceMetric;
    uint        dwIPv6InterfaceMetric;
    in6_addr    ipv6addr;
    uint        dwIPv6PrefixLength;
    uint        dwNetworkOutageTime;
    ushort[257] szIDi;
    ushort[257] szIDr;
    BOOL        fIsImsConfig;
    IKEV2_ID_PAYLOAD_TYPE IdiType;
    IKEV2_ID_PAYLOAD_TYPE IdrType;
    BOOL        fDisableIKEv2Fragmentation;
}

struct tagRASADPARAMS
{
    uint dwSize;
    HWND hwndOwner;
    uint dwFlags;
    int  xDlg;
    int  yDlg;
}

struct tagRASSUBENTRYA
{
    uint      dwSize;
    uint      dwfFlags;
    byte[17]  szDeviceType;
    byte[129] szDeviceName;
    byte[129] szLocalPhoneNumber;
    uint      dwAlternateOffset;
}

struct tagRASSUBENTRYW
{
    uint        dwSize;
    uint        dwfFlags;
    ushort[17]  szDeviceType;
    ushort[129] szDeviceName;
    ushort[129] szLocalPhoneNumber;
    uint        dwAlternateOffset;
}

struct tagRASCREDENTIALSA
{
    uint      dwSize;
    uint      dwMask;
    byte[257] szUserName;
    byte[257] szPassword;
    byte[16]  szDomain;
}

struct tagRASCREDENTIALSW
{
    uint        dwSize;
    uint        dwMask;
    ushort[257] szUserName;
    ushort[257] szPassword;
    ushort[16]  szDomain;
}

struct tagRASAUTODIALENTRYA
{
    uint      dwSize;
    uint      dwFlags;
    uint      dwDialingLocation;
    byte[257] szEntry;
}

struct tagRASAUTODIALENTRYW
{
    uint        dwSize;
    uint        dwFlags;
    uint        dwDialingLocation;
    ushort[257] szEntry;
}

struct tagRASEAPUSERIDENTITYA
{
    byte[257] szUserName;
    uint      dwSizeofEapInfo;
    ubyte[1]  pbEapInfo;
}

struct tagRASEAPUSERIDENTITYW
{
    ushort[257] szUserName;
    uint        dwSizeofEapInfo;
    ubyte[1]    pbEapInfo;
}

struct tagRASCOMMSETTINGS
{
    uint  dwSize;
    ubyte bParity;
    ubyte bStop;
    ubyte bByteSize;
    ubyte bAlign;
}

struct tagRASCUSTOMSCRIPTEXTENSIONS
{
    uint dwSize;
    PFNRASSETCOMMSETTINGS pfnRasSetCommSettings;
}

///The <b>RAS_STATS</b> structure stores the statistics for a single-link RAS connection, or for one of the links in a
///multilink RAS connection.
struct RAS_STATS
{
    ///Specifies the version of the structure. Set this member to sizeof(<b>RAS_STATS</b>) before using the structure in
    ///a function call.
    uint dwSize;
    ///The number of bytes transmitted through this connection or link.
    uint dwBytesXmited;
    ///The number of bytes received through this connection or link.
    uint dwBytesRcved;
    ///The number frames transmitted through this connection or link.
    uint dwFramesXmited;
    ///The number of frames received through this connection or link.
    uint dwFramesRcved;
    ///The number of cyclic redundancy check (CRC) errors on this connection or link.
    uint dwCrcErr;
    ///The number of timeout errors on this connection or link.
    uint dwTimeoutErr;
    ///The number of alignment errors on this connection or link.
    uint dwAlignmentErr;
    ///The number of hardware overrun errors on this connection or link.
    uint dwHardwareOverrunErr;
    ///The number of framing errors on this connection or link.
    uint dwFramingErr;
    ///The number of buffer overrun errors on this connection or link.
    uint dwBufferOverrunErr;
    ///The compression ratio for the data being received on this connection or link. <div class="alert"><b>Note</b> This
    ///element is only valid for a single link connection or a single link in a multilink connection.</div> <div> </div>
    uint dwCompressionRatioIn;
    ///The compression ratio for the data being transmitted on this connection or link. <div class="alert"><b>Note</b>
    ///This element is only valid for a single link connection or a single link in a multilink connection.</div> <div>
    ///</div>
    uint dwCompressionRatioOut;
    ///The speed of the connection or link, in bits per second. For a single-link connection and for individual links in
    ///a multilink connection, this speed is negotiated at the time the connection or link is established. For multilink
    ///connections, this speed is equal to the sum of the speeds of the individual links. For multilink connections,
    ///this speed varies as links are added or deleted. This speed is not equal to the throughput of the connection or
    ///link. To calculate the average throughput, divide the number of bytes transmitted (<b>dwBytesXmited</b>) and
    ///received (<b>dwBytesRcved</b>) by the amount of time the connection or link has been up
    ///(<b>dwConnectDuration</b>).
    uint dwBps;
    ///The amount of time, in milliseconds, that the connection or link has been connected.
    uint dwConnectDuration;
}

struct tagRASUPDATECONN
{
    RASAPIVERSION        version_;
    uint                 dwSize;
    uint                 dwFlags;
    uint                 dwIfIndex;
    tagRASTUNNELENDPOINT localEndPoint;
    tagRASTUNNELENDPOINT remoteEndPoint;
}

struct tagRASNOUSERW
{
    uint        dwSize;
    uint        dwFlags;
    uint        dwTimeoutMs;
    ushort[257] szUserName;
    ushort[257] szPassword;
    ushort[16]  szDomain;
}

struct tagRASNOUSERA
{
    uint      dwSize;
    uint      dwFlags;
    uint      dwTimeoutMs;
    byte[257] szUserName;
    byte[257] szPassword;
    byte[16]  szDomain;
}

struct tagRASPBDLGW
{
    uint          dwSize;
    HWND          hwndOwner;
    uint          dwFlags;
    int           xDlg;
    int           yDlg;
    size_t        dwCallbackId;
    RASPBDLGFUNCW pCallback;
    uint          dwError;
    size_t        reserved;
    size_t        reserved2;
}

struct tagRASPBDLGA
{
    uint          dwSize;
    HWND          hwndOwner;
    uint          dwFlags;
    int           xDlg;
    int           yDlg;
    size_t        dwCallbackId;
    RASPBDLGFUNCA pCallback;
    uint          dwError;
    size_t        reserved;
    size_t        reserved2;
}

struct tagRASENTRYDLGW
{
    uint        dwSize;
    HWND        hwndOwner;
    uint        dwFlags;
    int         xDlg;
    int         yDlg;
    ushort[257] szEntry;
    uint        dwError;
    size_t      reserved;
    size_t      reserved2;
}

struct tagRASENTRYDLGA
{
    uint      dwSize;
    HWND      hwndOwner;
    uint      dwFlags;
    int       xDlg;
    int       yDlg;
    byte[257] szEntry;
    uint      dwError;
    size_t    reserved;
    size_t    reserved2;
}

struct tagRASDIALDLG
{
    uint   dwSize;
    HWND   hwndOwner;
    uint   dwFlags;
    int    xDlg;
    int    yDlg;
    uint   dwSubEntry;
    uint   dwError;
    size_t reserved;
    size_t reserved2;
}

///The <b>MPR_INTERFACE_0</b> structure contains information for a particular router interface.
struct MPR_INTERFACE_0
{
    ///Pointer to a Unicode string that contains the name of the interface.
    ushort[257] wszInterfaceName;
    ///Handle to the interface.
    HANDLE      hInterface;
    ///Specifies whether the interface is enabled. This member is <b>TRUE</b> if the interface is enabled, <b>FALSE</b>
    ///if the interface is administratively disabled.
    BOOL        fEnabled;
    ///Specifies the type of interface.
    ROUTER_INTERFACE_TYPE dwIfType;
    ///Specifies the current state of the interface, for example connected, disconnected, or unreachable. For a list of
    ///possible states, see ROUTER_CONNECTION_STATE.
    ROUTER_CONNECTION_STATE dwConnectionState;
    ///Specifies a value that represents a reason why the interface cannot be reached. See Unreachability Reasons for a
    ///list of possible values.
    uint        fUnReachabilityReasons;
    ///Specifies a nonzero value if the interface fails to connect.
    uint        dwLastError;
}

struct MPR_IPINIP_INTERFACE_0
{
    ushort[257] wszFriendlyName;
    GUID        Guid;
}

///The <b>MPR_INTERFACE_1</b> structure contains configuration and status information for a particular router interface.
struct MPR_INTERFACE_1
{
    ///Pointer to a Unicode string that contains the name of the interface.
    ushort[257] wszInterfaceName;
    ///Handle to the interface.
    HANDLE      hInterface;
    ///Specifies whether the interface is enabled. This value is <b>TRUE</b> if the interface is enabled, <b>FALSE</b>
    ///if the interface is administratively disabled.
    BOOL        fEnabled;
    ///Specifies the type of interface.
    ROUTER_INTERFACE_TYPE dwIfType;
    ///Specifies the current state of the interface, for example connected, disconnected, or unreachable. For a list of
    ///possible states, see ROUTER_CONNECTION_STATE.
    ROUTER_CONNECTION_STATE dwConnectionState;
    ///Specifies a value that represents a reason why the interface was unreachable. See Unreachability Reasons for a
    ///list of possible values.
    uint        fUnReachabilityReasons;
    ///Specifies a nonzero value if the interface fails to connect.
    uint        dwLastError;
    ///Pointer to a Unicode string that specifies the times during which dial-out is restricted. The format for this
    ///string is: <pre class="syntax" xml:space="preserve"><code>&lt;day&gt;&lt;space&gt;&lt;time
    ///range&gt;&lt;space&gt;&lt;time range&gt; . . . &lt;NULL&gt;&lt;day&gt;. . . &lt;NULL&gt;&lt;NULL&gt;
    ///</code></pre> Where day is a numeral that corresponds to a day of the week. <table> <tr> <th>Numeral</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0</dt> </dl> </td> <td width="60%"> Sunday </td> </tr> <tr>
    ///<td width="40%"> <dl> <dt>1</dt> </dl> </td> <td width="60%"> Monday </td> </tr> <tr> <td width="40%"> <dl>
    ///<dt>2</dt> </dl> </td> <td width="60%"> Tuesday </td> </tr> <tr> <td width="40%"> <dl> <dt>3</dt> </dl> </td> <td
    ///width="60%"> Wednesday </td> </tr> <tr> <td width="40%"> <dl> <dt>4</dt> </dl> </td> <td width="60%"> Thursday
    ///</td> </tr> <tr> <td width="40%"> <dl> <dt>5</dt> </dl> </td> <td width="60%"> Friday </td> </tr> <tr> <td
    ///width="40%"> <dl> <dt>6</dt> </dl> </td> <td width="60%"> Saturday </td> </tr> </table> Time range is of the form
    ///HH:MM-HH:MM, using 24-hour notation. The string &lt;space&gt; in the preceding syntax denotes a space character.
    ///The string &lt;NULL&gt; denotes a null character. The restriction string is terminated by two consecutive null
    ///characters. Example: <pre class="syntax" xml:space="preserve"><code>2 09:00-12:00 13:00-17:30&lt;NULL&gt;4
    ///09:00-12:00 13:00-17:30&lt;NULL&gt;&lt;NULL&gt; </code></pre> The preceding string restricts dial-out to Tuesdays
    ///and Thursdays from 9:00 AM to 12:00 PM and from 1:00 PM to 5:30 PM.
    PWSTR       lpwsDialoutHoursRestriction;
}

///The <b>MPR_INTERFACE_2</b> structure contains data for a router demand-dial interface.
struct MPR_INTERFACE_2
{
    ///A pointer to a Unicode string that contains the name of the interface.
    ushort[257] wszInterfaceName;
    ///A handle to the interface.
    HANDLE      hInterface;
    ///A value that specifies whether the interface is enabled. This value is <b>TRUE</b> if the interface is enabled,
    ///<b>FALSE</b> if the interface is administratively disabled.
    BOOL        fEnabled;
    ///A value that identifies the interface type.
    ROUTER_INTERFACE_TYPE dwIfType;
    ///A value that describes the current state of the interface, for example, connected, disconnected, or unreachable.
    ///For more information and a list of possible states, see ROUTER_CONNECTION_STATE.
    ROUTER_CONNECTION_STATE dwConnectionState;
    ///A value that describes the reason why the interface is unreachable. For more information and a list of possible
    ///values, see Unreachability Reasons.
    uint        fUnReachabilityReasons;
    ///A value that contains a nonzero value if the interface fails to connect.
    uint        dwLastError;
    ///A value that specifies bit flags that are used to set connection options. You can set one of the flags listed in
    ///the following table. <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="MPRIO_SpecificIpAddr"></a><a id="mprio_specificipaddr"></a><a id="MPRIO_SPECIFICIPADDR"></a><dl>
    ///<dt><b>MPRIO_SpecificIpAddr</b></dt> </dl> </td> <td width="60%"> If this flag is set, RRAS attempts to use the
    ///IP address specified by <b>ipaddr</b> as the IP address for the dial-up connection. If this flag is not set, the
    ///value of the <b>ipaddr</b> member is ignored. Setting the <b>MPRIO_SpecificIpAddr</b> flag corresponds to
    ///selecting the <b>Specify an IP Address</b> setting in the TCP/IP settings dialog box. Clearing the
    ///<b>MPRIO_SpecificIpAddr</b> flag corresponds to selecting the <b>Server Assigned IP Address</b> setting in the
    ///<b>TCP/IP Settings</b> dialog box. Currently, an IP address set in the phone-book entry properties or retrieved
    ///from a server overrides the IP address set in the network control panel. </td> </tr> <tr> <td width="40%"><a
    ///id="MPRIO_SpecificNameServers"></a><a id="mprio_specificnameservers"></a><a
    ///id="MPRIO_SPECIFICNAMESERVERS"></a><dl> <dt><b>MPRIO_SpecificNameServers</b></dt> </dl> </td> <td width="60%"> If
    ///this flag is set, RRAS uses the <b>ipaddrDns</b>, <b>ipaddrDnsAlt</b>, <b>ipaddrWins</b>, and
    ///<b>ipaddrWinsAlt</b> members to specify the name server addresses for the dial-up connection. If this flag is not
    ///set, RRAS ignores these members. Setting the MPRIO_SpecificNameServers flag corresponds to selecting the
    ///<b>Specify Name Server Addresses</b> setting in the TCP/IP Settings dialog box. Clearing the
    ///<b>MPRIO_SpecificNameServers</b> flag corresponds to selecting the <b>Server Assigned Name Server Addresses</b>
    ///setting in the <b>TCP/IP Settings</b> dialog box. </td> </tr> <tr> <td width="40%"><a
    ///id="MPRIO_IpHeaderCompression"></a><a id="mprio_ipheadercompression"></a><a
    ///id="MPRIO_IPHEADERCOMPRESSION"></a><dl> <dt><b>MPRIO_IpHeaderCompression</b></dt> </dl> </td> <td width="60%"> If
    ///this flag is set, RRAS negotiates to use IP header compression on PPP connections. IP header compression can
    ///significantly improve performance. If this flag is not set, IP header compression is not negotiated. This flag
    ///corresponds to the <b>Use IP Header Compression</b> check box in the <b>TCP/IP Settings</b> dialog box. The flag
    ///should be cleared only when connecting to a server that does not correctly negotiate IP header compression. </td>
    ///</tr> <tr> <td width="40%"><a id="MPRIO_RemoteDefaultGateway"></a><a id="mprio_remotedefaultgateway"></a><a
    ///id="MPRIO_REMOTEDEFAULTGATEWAY"></a><dl> <dt><b>MPRIO_RemoteDefaultGateway</b></dt> </dl> </td> <td width="60%">
    ///If this flag is set, the default route for IP packets is through the dial-up adapter when the connection is
    ///active. If this flag is cleared, the default route is not modified. This flag corresponds to the <b>Use Default
    ///Gateway on Remote Network</b> check box in the <b>TCP/IP Settings</b> dialog box. </td> </tr> <tr> <td
    ///width="40%"><a id="MPRIO_DisableLcpExtensions"></a><a id="mprio_disablelcpextensions"></a><a
    ///id="MPRIO_DISABLELCPEXTENSIONS"></a><dl> <dt><b>MPRIO_DisableLcpExtensions</b></dt> </dl> </td> <td width="60%">
    ///If this flag is set, RRAS disables the PPP LCP extensions defined in RFC 1570. Disabling the PPP LCP extensions
    ///may be necessary to connect to certain older PPP implementations, but it interferes with features such as server
    ///callback. Do not set this flag unless it is specifically required. </td> </tr> <tr> <td width="40%"><a
    ///id="MPRIO_SwCompression"></a><a id="mprio_swcompression"></a><a id="MPRIO_SWCOMPRESSION"></a><dl>
    ///<dt><b>MPRIO_SwCompression</b></dt> </dl> </td> <td width="60%"> If this flag is set, software compression is
    ///negotiated on the link. Setting this flag causes the PPP driver to attempt to negotiate Compression Control
    ///Protocol (CCP) with the server. This flag should be set by default, but clearing it can reduce the negotiation
    ///period if the server does not support a compatible compression protocol. </td> </tr> <tr> <td width="40%"><a
    ///id="MPRIO_RequireEncryptedPw"></a><a id="mprio_requireencryptedpw"></a><a id="MPRIO_REQUIREENCRYPTEDPW"></a><dl>
    ///<dt><b>MPRIO_RequireEncryptedPw</b></dt> </dl> </td> <td width="60%"> If this flag is set, only secure password
    ///schemes can be used to authenticate the client with the server. This prevents the PPP driver from using the PAP
    ///plain-text authentication protocol to authenticate the client. However, the MS-CHAP, MD5-CHAP, and SPAP
    ///authentication protocols are supported. For increased security, set this flag. For increased interoperability,
    ///clear this flag. This flag corresponds to the <b>Require Encrypted Password</b> check box in the <b>Security</b>
    ///dialog box. For more information, see <b>MPRIO_RequireMsEncryptedPw</b>. </td> </tr> <tr> <td width="40%"><a
    ///id="MPRIO_RequireMsEncryptedPw"></a><a id="mprio_requiremsencryptedpw"></a><a
    ///id="MPRIO_REQUIREMSENCRYPTEDPW"></a><dl> <dt><b>MPRIO_RequireMsEncryptedPw</b></dt> </dl> </td> <td width="60%">
    ///If this flag is set, only the Microsoft secure password schemes can be used to authenticate the client with the
    ///server. This prevents the PPP driver from using the PAP plain-text authentication protocol, MD5-CHAP, or SPAP.
    ///For increased security, set this flag. For increased interoperability, clear this flag. This flag takes
    ///precedence over <b>MPRIO_RequireEncryptedPw</b>. This flag corresponds to the <b>Require Microsoft Encrypted
    ///Password</b> check box in the <b>Security</b> dialog box. For more information, see
    ///<b>MPRIO_RequireDataEncryption</b>. </td> </tr> <tr> <td width="40%"><a id="MPRIO_RequireDataEncryption"></a><a
    ///id="mprio_requiredataencryption"></a><a id="MPRIO_REQUIREDATAENCRYPTION"></a><dl>
    ///<dt><b>MPRIO_RequireDataEncryption</b></dt> </dl> </td> <td width="60%"> If this flag is set, data encryption
    ///must be negotiated successfully or the connection should be dropped. This flag is ignored unless
    ///<b>MPRIO_RequireMsEncryptedPw</b> is also set. This flag corresponds to the <b>Require Data Encryption</b> check
    ///box in the <b>Security</b> dialog box. </td> </tr> <tr> <td width="40%"><a id="MPRIO_NetworkLogon"></a><a
    ///id="mprio_networklogon"></a><a id="MPRIO_NETWORKLOGON"></a><dl> <dt><b>MPRIO_NetworkLogon</b></dt> </dl> </td>
    ///<td width="60%"> This flag is reserved for future use. </td> </tr> <tr> <td width="40%"><a
    ///id="MPRIO_UseLogonCredentials"></a><a id="mprio_uselogoncredentials"></a><a
    ///id="MPRIO_USELOGONCREDENTIALS"></a><dl> <dt><b>MPRIO_UseLogonCredentials</b></dt> </dl> </td> <td width="60%"> If
    ///this flag is set, RRAS uses the user name, password, and domain of the currently logged-on user when dialing this
    ///entry. This flag is ignored unless <b>MPRIO_RequireMsEncryptedPw</b> is also set. This setting is ignored by the
    ///RasDial function where specifying empty strings for the <b>szUserName</b> and <b>szPassword</b> members of the
    ///RASDIALPARAMS structure provides the same result. This flag corresponds to the <b>Use Current Username and
    ///Password</b> check box in the <b>Security</b> dialog box. </td> </tr> <tr> <td width="40%"><a
    ///id="MPRIO_PromoteAlternates"></a><a id="mprio_promotealternates"></a><a id="MPRIO_PROMOTEALTERNATES"></a><dl>
    ///<dt><b>MPRIO_PromoteAlternates</b></dt> </dl> </td> <td width="60%"> This flag has an effect when alternate phone
    ///numbers are defined by the <b>szAlternates</b> member. If this flag is set, an alternate phone number that
    ///connects successfully becomes the primary phone number, and the current primary phone number is moved to the
    ///alternate list. This flag corresponds to the check box in the <b>Alternate Numbers</b> dialog box. </td> </tr>
    ///<tr> <td width="40%"><a id="MPRIO_SecureLocalFiles"></a><a id="mprio_securelocalfiles"></a><a
    ///id="MPRIO_SECURELOCALFILES"></a><dl> <dt><b>MPRIO_SecureLocalFiles</b></dt> </dl> </td> <td width="60%"> If this
    ///flag is set, RRAS checks for existing remote file system and remote printer bindings before making a connection
    ///with this entry. Typically, you set this flag on phone-book entries for public networks to remind users to break
    ///connections to their private network before connecting to a public network. </td> </tr> <tr> <td width="40%"><a
    ///id="MPRIO_RequireEAP"></a><a id="mprio_requireeap"></a><a id="MPRIO_REQUIREEAP"></a><dl>
    ///<dt><b>MPRIO_RequireEAP</b></dt> </dl> </td> <td width="60%"> If this flag is set, Extensible Authentication
    ///Protocol (EAP) must be supported for authentication. </td> </tr> <tr> <td width="40%"><a
    ///id="MPRIO_RequirePAP"></a><a id="mprio_requirepap"></a><a id="MPRIO_REQUIREPAP"></a><dl>
    ///<dt><b>MPRIO_RequirePAP</b></dt> </dl> </td> <td width="60%"> If this flag is set, Password Authentication
    ///Protocol must be supported for authentication. </td> </tr> <tr> <td width="40%"><a id="MPRIO_RequireSPAP"></a><a
    ///id="mprio_requirespap"></a><a id="MPRIO_REQUIRESPAP"></a><dl> <dt><b>MPRIO_RequireSPAP</b></dt> </dl> </td> <td
    ///width="60%"> If this flag is set, Shiva's Password Authentication Protocol (SPAP) must be supported for
    ///authentication. </td> </tr> <tr> <td width="40%"><a id="MPRIO_SharedPhoneNumbers"></a><a
    ///id="mprio_sharedphonenumbers"></a><a id="MPRIO_SHAREDPHONENUMBERS"></a><dl>
    ///<dt><b>MPRIO_SharedPhoneNumbers</b></dt> </dl> </td> <td width="60%"> If this flag is set, phone numbers are
    ///shared. </td> </tr> <tr> <td width="40%"><a id="MPRIO_RequireCHAP"></a><a id="mprio_requirechap"></a><a
    ///id="MPRIO_REQUIRECHAP"></a><dl> <dt><b>MPRIO_RequireCHAP</b></dt> </dl> </td> <td width="60%"> If this flag is
    ///set, the Challenge Handshake Authentication Protocol must be supported for authentication. </td> </tr> <tr> <td
    ///width="40%"><a id="MPRIO_RequireMsCHAP"></a><a id="mprio_requiremschap"></a><a id="MPRIO_REQUIREMSCHAP"></a><dl>
    ///<dt><b>MPRIO_RequireMsCHAP</b></dt> </dl> </td> <td width="60%"> If this flag is set, the Microsoft Challenge
    ///Handshake Authentication Protocol must be supported for authentication. </td> </tr> <tr> <td width="40%"><a
    ///id="MPRIO_RequireMsCHAP2"></a><a id="mprio_requiremschap2"></a><a id="MPRIO_REQUIREMSCHAP2"></a><dl>
    ///<dt><b>MPRIO_RequireMsCHAP2</b></dt> </dl> </td> <td width="60%"> If this flag is set, version 2 of the Microsoft
    ///Challenge Handshake Authentication Protocol must be supported for authentication. </td> </tr> <tr> <td
    ///width="40%"><a id="MPRIO_IpSecPreSharedKey"></a><a id="mprio_ipsecpresharedkey"></a><a
    ///id="MPRIO_IPSECPRESHAREDKEY"></a><dl> <dt><b>MPRIO_IpSecPreSharedKey</b></dt> </dl> </td> <td width="60%"> If
    ///this flag is set for <b>dwfOptions</b> in the <b>MPR_INTERFACE_2</b> structure and is used in
    ///MprAdminInterfaceSetInfo, it configures the demand dial interface to use preshared key. </td> </tr> <tr> <td
    ///width="40%"><a id="MPRIO_RequireMachineCertificates"></a><a id="mprio_requiremachinecertificates"></a><a
    ///id="MPRIO_REQUIREMACHINECERTIFICATES"></a><dl> <dt><b>MPRIO_RequireMachineCertificates</b></dt> </dl> </td> <td
    ///width="60%"> Windows 8 or later: If this flag is set, machine certificates are used for IKEv2 authentication.
    ///</td> </tr> <tr> <td width="40%"><a id="MPRIO_UsePreSharedKeyForIkev2Initiator"></a><a
    ///id="mprio_usepresharedkeyforikev2initiator"></a><a id="MPRIO_USEPRESHAREDKEYFORIKEV2INITIATOR"></a><dl>
    ///<dt><b>MPRIO_UsePreSharedKeyForIkev2Initiator</b></dt> </dl> </td> <td width="60%"> Windows 8 or later: If this
    ///flag is set, a pre-shared key is used by the initiator of the IKEv2 connection for authentication. </td> </tr>
    ///<tr> <td width="40%"><a id="MPRIO_UsePreSharedKeyForIkev2Responder"></a><a
    ///id="mprio_usepresharedkeyforikev2responder"></a><a id="MPRIO_USEPRESHAREDKEYFORIKEV2RESPONDER"></a><dl>
    ///<dt><b>MPRIO_UsePreSharedKeyForIkev2Responder</b></dt> </dl> </td> <td width="60%"> Windows 8 or later: If this
    ///flag is set, a pre-shared key is used by the responder of the IKEv2 connection for authentication. </td> </tr>
    ///</table>
    uint        dwfOptions;
    ///A value that specifies a null-terminated string that contains a telephone number.
    ushort[129] szLocalPhoneNumber;
    ///A pointer to a list of consecutive null-terminated Unicode strings. The last string is terminated by two
    ///consecutive null characters. The strings are alternate phone numbers that the router dials, in the order listed,
    ///if the primary number fails to connect. For more information, see <b>szLocalPhoneNumber</b>.
    PWSTR       szAlternates;
    ///A value that specifies the IP address to be used while this connection is active. This member is ignored unless
    ///<b>dwfOptions</b> specifies the <b>MPRIO_SpecificIpAddr</b> flag.
    uint        ipaddr;
    ///A value that specifies the IP address of the DNS server to be used while this connection is active. This member
    ///is ignored unless <b>dwfOptions</b> specifies the <b>MPRIO_SpecificNameServers</b> flag.
    uint        ipaddrDns;
    ///A value that specifies the IP address of a secondary or backup DNS server to be used while this connection is
    ///active. This member is ignored unless <b>dwfOptions</b> specifies the <b>MPRIO_SpecificNameServers</b> flag.
    uint        ipaddrDnsAlt;
    ///A value that specifies the IP address of the WINS server to be used while this connection is active. This member
    ///is ignored unless <b>dwfOptions</b> specifies the <b>MPRIO_SpecificNameServers</b> flag.
    uint        ipaddrWins;
    ///A value that specifies the IP address of a secondary WINS server to be used while this connection is active. This
    ///member is ignored unless <b>dwfOptions</b> specifies the <b>MPRIO_SpecificNameServers</b> flag.
    uint        ipaddrWinsAlt;
    ///A value that specifies the network protocols to negotiate. This member can be a combination of the following
    ///flags. <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MPRNP_Ipx"></a><a
    ///id="mprnp_ipx"></a><a id="MPRNP_IPX"></a><dl> <dt><b>MPRNP_Ipx</b></dt> </dl> </td> <td width="60%"> Negotiate
    ///the IPX protocol. </td> </tr> <tr> <td width="40%"><a id="MPRNP_Ip"></a><a id="mprnp_ip"></a><a
    ///id="MPRNP_IP"></a><dl> <dt><b>MPRNP_Ip</b></dt> </dl> </td> <td width="60%"> Negotiate the TCP/IP protocol. </td>
    ///</tr> </table> <b>64-bit Windows: </b>The <b>MPRNP_Ipx</b> flag is not supported
    uint        dwfNetProtocols;
    ///A value that specifies a null-terminated string that indicates the RRAS device type that is referenced by
    ///<b>szDeviceName</b>. This member can be one of the following string constants. <table> <tr> <th>String</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="MPRDT_Modem"></a><a id="mprdt_modem"></a><a
    ///id="MPRDT_MODEM"></a><dl> <dt><b>MPRDT_Modem</b></dt> </dl> </td> <td width="60%"> A modem that is accessed
    ///through a COM port. </td> </tr> <tr> <td width="40%"><a id="MPRDT_Isdn"></a><a id="mprdt_isdn"></a><a
    ///id="MPRDT_ISDN"></a><dl> <dt><b>MPRDT_Isdn</b></dt> </dl> </td> <td width="60%"> An ISDN adapter with the
    ///corresponding NDISWAN driver installed. </td> </tr> <tr> <td width="40%"><a id="MPRDT_X25"></a><a
    ///id="mprdt_x25"></a><dl> <dt><b>MPRDT_X25</b></dt> </dl> </td> <td width="60%"> An X.25 adapter with the
    ///corresponding NDISWAN driver installed. </td> </tr> <tr> <td width="40%"><a id="MPRDT_Vpn"></a><a
    ///id="mprdt_vpn"></a><a id="MPRDT_VPN"></a><dl> <dt><b>MPRDT_Vpn</b></dt> </dl> </td> <td width="60%"> A virtual
    ///private network (VPN) connection. </td> </tr> <tr> <td width="40%"><a id="MPRDT_Pad"></a><a id="mprdt_pad"></a><a
    ///id="MPRDT_PAD"></a><dl> <dt><b>MPRDT_Pad</b></dt> </dl> </td> <td width="60%"> A packet assembler/disassembler.
    ///</td> </tr> <tr> <td width="40%"><a id="MPRDT_Generic"></a><a id="mprdt_generic"></a><a
    ///id="MPRDT_GENERIC"></a><dl> <dt><b>MPRDT_Generic</b></dt> </dl> </td> <td width="60%"> Generic. </td> </tr> <tr>
    ///<td width="40%"><a id="MPRDT_Serial"></a><a id="mprdt_serial"></a><a id="MPRDT_SERIAL"></a><dl>
    ///<dt><b>MPRDT_Serial</b></dt> </dl> </td> <td width="60%"> Direct serial connection through a serial port. </td>
    ///</tr> <tr> <td width="40%"><a id="MPRDT_FrameRelay"></a><a id="mprdt_framerelay"></a><a
    ///id="MPRDT_FRAMERELAY"></a><dl> <dt><b>MPRDT_FrameRelay</b></dt> </dl> </td> <td width="60%"> Frame Relay. </td>
    ///</tr> <tr> <td width="40%"><a id="MPRDT_Atm"></a><a id="mprdt_atm"></a><a id="MPRDT_ATM"></a><dl>
    ///<dt><b>MPRDT_Atm</b></dt> </dl> </td> <td width="60%"> Asynchronous Transfer Mode. </td> </tr> <tr> <td
    ///width="40%"><a id="MPRDT_Sonet"></a><a id="mprdt_sonet"></a><a id="MPRDT_SONET"></a><dl>
    ///<dt><b>MPRDT_Sonet</b></dt> </dl> </td> <td width="60%"> Sonet. </td> </tr> <tr> <td width="40%"><a
    ///id="MPRDT_SW56"></a><a id="mprdt_sw56"></a><dl> <dt><b>MPRDT_SW56</b></dt> </dl> </td> <td width="60%"> Switched
    ///56K Access. </td> </tr> <tr> <td width="40%"><a id="MPRDT_Irda"></a><a id="mprdt_irda"></a><a
    ///id="MPRDT_IRDA"></a><dl> <dt><b>MPRDT_Irda</b></dt> </dl> </td> <td width="60%"> An Infrared Data Association
    ///(IrDA)-compliant device. </td> </tr> <tr> <td width="40%"><a id="MPRDT_Parallel"></a><a
    ///id="mprdt_parallel"></a><a id="MPRDT_PARALLEL"></a><dl> <dt><b>MPRDT_Parallel</b></dt> </dl> </td> <td
    ///width="60%"> Direct parallel connection through a parallel port. </td> </tr> </table>
    ushort[17]  szDeviceType;
    ///Contains a null-terminated string that contains the name of a TAPI device to use with this phone-book entry, for
    ///example, "Fabrikam Inc 28800 External". To enumerate all available RAS-capable devices, use the RasEnumDevices
    ///function.
    ushort[129] szDeviceName;
    ///A data type that contains a null-terminated string that identifies the X.25 PAD type. Set this member to an empty
    ///string ("") unless the entry should dial using an X.25 PAD. <b>Windows 2000 and Windows NT: </b>The
    ///<b>szX25PadType</b> string maps to a section name in PAD.INF.
    ushort[33]  szX25PadType;
    ///Contains a null-terminated string that identifies the X.25 address to connect to. Set this member to an empty
    ///string ("") unless the entry should dial using an X.25 PAD or native X.25 device.
    ushort[201] szX25Address;
    ///Contains a null-terminated string that specifies the facilities to request from the X.25 host at connection time.
    ///This member is ignored if <b>szX25Address</b> is an empty string ("").
    ushort[201] szX25Facilities;
    ///Contains a null-terminated string that specifies additional connection data supplied to the X.25 host at
    ///connection time. This member is ignored if <b>szX25Address</b> is an empty string ("").
    ushort[201] szX25UserData;
    ///Reserved for future use.
    uint        dwChannels;
    ///A value that specifies the number of multilink subentries associated with this entry. When calling
    ///RasSetEntryProperties, set this member to zero. To add subentries to a phone-book entry, use the
    ///RasSetSubEntryProperties function.
    uint        dwSubEntries;
    ///Indicates whether RRAS should dial all of this entry's multilink subentries when the entry is first connected.
    ///This member can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="MPRDM_DialAll"></a><a id="mprdm_dialall"></a><a id="MPRDM_DIALALL"></a><dl>
    ///<dt><b>MPRDM_DialAll</b></dt> </dl> </td> <td width="60%"> Dial all subentries initially. </td> </tr> <tr> <td
    ///width="40%"><a id="MPRDM_DialAsNeeded"></a><a id="mprdm_dialasneeded"></a><a id="MPRDM_DIALASNEEDED"></a><dl>
    ///<dt><b>MPRDM_DialAsNeeded</b></dt> </dl> </td> <td width="60%"> Adjust the number of subentries as bandwidth is
    ///required. RRAS uses the <b>dwDialExtraPercent</b>, <b>dwDialExtraSampleSeconds</b>,
    ///<b>dwDialHangUpExtraPercent</b>, and <b>dwHangUpExtraSampleSeconds</b> members to determine when to dial or
    ///disconnect a subentry. </td> </tr> </table>
    uint        dwDialMode;
    ///A value that specifies the percentage of the total bandwidth that is available from the currently connected
    ///subentries. RRAS dials an additional subentry when the total bandwidth that is used exceeds
    ///<b>dwDialExtraPercent</b> percent of the available bandwidth for at least <b>dwDialExtraSampleSeconds</b>
    ///seconds. This member is ignored unless the <b>dwDialMode</b> member specifies the <b>MPRDM_DialAsNeeded</b> flag.
    uint        dwDialExtraPercent;
    ///A value that specifies the time, in seconds, for which current bandwidth usage must exceed the threshold that is
    ///specified by <b>dwDialExtraPercent</b> before RRAS dials an additional subentry. This member is ignored unless
    ///the <b>dwDialMode</b> member specifies the <b>MPRDM_DialAsNeeded</b> flag.
    uint        dwDialExtraSampleSeconds;
    ///A value that specifies the percentage of the total bandwidth that is available from the currently connected
    ///subentries. RRAS terminates (hangs up) an existing subentry connection when the total bandwidth used is less than
    ///<b>dwHangUpExtraPercent</b> percent of the available bandwidth for at least <b>dwHangUpExtraSampleSeconds</b>
    ///seconds. This member is ignored unless the <b>dwDialMode</b> member specifies the <b>MPRDM_DialAsNeeded</b> flag.
    uint        dwHangUpExtraPercent;
    ///A value that specifies the time, in seconds, for which current bandwidth usage must be less than the threshold
    ///that is specified by <b>dwHangUpExtraPercent</b> before RRAS terminates an existing subentry connection. This
    ///member is ignored unless the <b>dwDialMode</b> member specifies the <b>MPRDM_DialAsNeeded</b> flag.
    uint        dwHangUpExtraSampleSeconds;
    ///A value that specifies the time, in seconds, after which an inactive connection is terminated. Unless the idle
    ///time-out is disabled, the entire connection is terminated if the connection is idle for the specified interval.
    ///This member can specify either a time-out value, or one of the following values. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="MPRIDS_Disabled"></a><a id="mprids_disabled"></a><a
    ///id="MPRIDS_DISABLED"></a><dl> <dt><b>MPRIDS_Disabled</b></dt> </dl> </td> <td width="60%"> There is no idle
    ///time-out for this connection. </td> </tr> <tr> <td width="40%"><a id="MPRIDS_UseGlobalValue"></a><a
    ///id="mprids_useglobalvalue"></a><a id="MPRIDS_USEGLOBALVALUE"></a><dl> <dt><b>MPRIDS_UseGlobalValue</b></dt> </dl>
    ///</td> <td width="60%"> Use the user preference value as the default. </td> </tr> </table>
    uint        dwIdleDisconnectSeconds;
    ///A value that specifies the type of phone-book entry. This member can be one of the following types. <table> <tr>
    ///<th>Type</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MPRET_Phone"></a><a id="mpret_phone"></a><a
    ///id="MPRET_PHONE"></a><dl> <dt><b>MPRET_Phone</b></dt> </dl> </td> <td width="60%"> Phone line, for example,
    ///modem, ISDN, or X.25. </td> </tr> <tr> <td width="40%"><a id="MPRET_Vpn"></a><a id="mpret_vpn"></a><a
    ///id="MPRET_VPN"></a><dl> <dt><b>MPRET_Vpn</b></dt> </dl> </td> <td width="60%"> Virtual Private Network. </td>
    ///</tr> <tr> <td width="40%"><a id="MPRET_Direct"></a><a id="mpret_direct"></a><a id="MPRET_DIRECT"></a><dl>
    ///<dt><b>MPRET_Direct</b></dt> </dl> </td> <td width="60%"> Direct serial or parallel connection. </td> </tr>
    ///</table>
    uint        dwType;
    ///A value that specifies the type of encryption to use for Microsoft Point-to-Point Encryption (MPPE) with the
    ///connection. This member can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="MPR_ET_None"></a><a id="mpr_et_none"></a><a id="MPR_ET_NONE"></a><dl>
    ///<dt><b>MPR_ET_None</b></dt> </dl> </td> <td width="60%"> Do not use encryption. </td> </tr> <tr> <td
    ///width="40%"><a id="MPR_ET_Require"></a><a id="mpr_et_require"></a><a id="MPR_ET_REQUIRE"></a><dl>
    ///<dt><b>MPR_ET_Require</b></dt> </dl> </td> <td width="60%"> Use encryption. </td> </tr> <tr> <td width="40%"><a
    ///id="MPR_ET_RequireMax"></a><a id="mpr_et_requiremax"></a><a id="MPR_ET_REQUIREMAX"></a><dl>
    ///<dt><b>MPR_ET_RequireMax</b></dt> </dl> </td> <td width="60%"> Use maximum-strength encryption. </td> </tr> <tr>
    ///<td width="40%"><a id="MPR_ET_Optional"></a><a id="mpr_et_optional"></a><a id="MPR_ET_OPTIONAL"></a><dl>
    ///<dt><b>MPR_ET_Optional</b></dt> </dl> </td> <td width="60%"> If possible, use encryption. </td> </tr> </table>
    ///The value of <b>dwEncryptionType</b> does not affect how passwords are encrypted. Whether passwords are encrypted
    ///and how passwords are encrypted is determined by the authentication protocol, for example, PAP, MS-CHAP, or EAP.
    uint        dwEncryptionType;
    ///A value that specifies the authentication key to be provided to an Extensible Authentication Protocol (EAP)
    ///vendor.
    uint        dwCustomAuthKey;
    ///A value that specifies the size of the data pointed to by the <b>lpbCustomAuthData</b> member.
    uint        dwCustomAuthDataSize;
    ///A pointer to authentication data to use with EAP.
    ubyte*      lpbCustomAuthData;
    ///The globally unique identifier (GUID) that represents this phone-book entry. This member is read-only.
    GUID        guidId;
    ///The VPN strategy to use when dialing a VPN connection. This member can have one of the following values. <table>
    ///<tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MPR_VS_Default"></a><a
    ///id="mpr_vs_default"></a><a id="MPR_VS_DEFAULT"></a><dl> <dt><b>MPR_VS_Default</b></dt> </dl> </td> <td
    ///width="60%"> RRAS dials PPTP first. If PPTP fails, L2TP is attempted. The protocol that succeeds is tried first
    ///in subsequent dialing for this entry. </td> </tr> <tr> <td width="40%"><a id="MPR_VS_PptpOnly"></a><a
    ///id="mpr_vs_pptponly"></a><a id="MPR_VS_PPTPONLY"></a><dl> <dt><b>MPR_VS_PptpOnly</b></dt> </dl> </td> <td
    ///width="60%"> RAS dials only PPTP. </td> </tr> <tr> <td width="40%"><a id="MPR_VS_PptpFirst"></a><a
    ///id="mpr_vs_pptpfirst"></a><a id="MPR_VS_PPTPFIRST"></a><dl> <dt><b>MPR_VS_PptpFirst</b></dt> </dl> </td> <td
    ///width="60%"> RAS always dials PPTP first, L2TP second. </td> </tr> <tr> <td width="40%"><a
    ///id="MPR_VS_L2tpOnly"></a><a id="mpr_vs_l2tponly"></a><a id="MPR_VS_L2TPONLY"></a><dl>
    ///<dt><b>MPR_VS_L2tpOnly</b></dt> </dl> </td> <td width="60%"> RAS dials only L2TP. </td> </tr> <tr> <td
    ///width="40%"><a id="MPR_VS_L2tpFirst"></a><a id="mpr_vs_l2tpfirst"></a><a id="MPR_VS_L2TPFIRST"></a><dl>
    ///<dt><b>MPR_VS_L2tpFirst</b></dt> </dl> </td> <td width="60%"> RAS dials L2TP first, PPTP second. </td> </tr>
    ///</table>
    uint        dwVpnStrategy;
}

///The <b>MPR_INTERFACE_3</b> structure contains data for a router demand-dial interface.
struct MPR_INTERFACE_3
{
    ///A pointer to a Unicode string that contains the name of the interface.
    ushort[257] wszInterfaceName;
    ///A handle to the interface.
    HANDLE      hInterface;
    ///A value that specifies whether the interface is enabled. This value is <b>TRUE</b> if the interface is enabled,
    ///<b>FALSE</b> if the interface is administratively disabled.
    BOOL        fEnabled;
    ///A value that identifies the interface type.
    ROUTER_INTERFACE_TYPE dwIfType;
    ///A value that describes the current state of the interface, for example, connected, disconnected, or unreachable.
    ///For more information and a list of possible states, see ROUTER_CONNECTION_STATE.
    ROUTER_CONNECTION_STATE dwConnectionState;
    ///A value that describes the reason why the interface is unreachable. For more information and a list of possible
    ///values, see Unreachability Reasons.
    uint        fUnReachabilityReasons;
    ///A value that contains a nonzero value if the interface fails to connect.
    uint        dwLastError;
    ///A value that specifies bit flags that are used to set connection options. You can set one of the flags listed in
    ///the following table. <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="MPRIO_SpecificIpAddr"></a><a id="mprio_specificipaddr"></a><a id="MPRIO_SPECIFICIPADDR"></a><dl>
    ///<dt><b>MPRIO_SpecificIpAddr</b></dt> </dl> </td> <td width="60%"> If this flag is set, RRAS attempts to use the
    ///IP address specified by <b>ipaddr</b> as the IP address for the dial-up connection. If this flag is not set, the
    ///value of the <b>ipaddr</b> member is ignored. Setting the <b>MPRIO_SpecificIpAddr</b> flag corresponds to
    ///selecting the <b>Specify an IP Address</b> setting in the TCP/IP settings dialog box. Clearing the
    ///<b>MPRIO_SpecificIpAddr</b> flag corresponds to selecting the <b>Server Assigned IP Address</b> setting in the
    ///<b>TCP/IP Settings</b> dialog box. Currently, an IP address set in the phone-book entry properties or retrieved
    ///from a server overrides the IP address set in the network control panel. </td> </tr> <tr> <td width="40%"><a
    ///id="MPRIO_SpecificNameServers"></a><a id="mprio_specificnameservers"></a><a
    ///id="MPRIO_SPECIFICNAMESERVERS"></a><dl> <dt><b>MPRIO_SpecificNameServers</b></dt> </dl> </td> <td width="60%"> If
    ///this flag is set, RRAS uses the <b>ipaddrDns</b>, <b>ipaddrDnsAlt</b>, <b>ipaddrWins</b>, and
    ///<b>ipaddrWinsAlt</b> members to specify the name server addresses for the dial-up connection. If this flag is not
    ///set, RRAS ignores these members. Setting the MPRIO_SpecificNameServers flag corresponds to selecting the
    ///<b>Specify Name Server Addresses</b> setting in the TCP/IP Settings dialog box. Clearing the
    ///<b>MPRIO_SpecificNameServers</b> flag corresponds to selecting the <b>Server Assigned Name Server Addresses</b>
    ///setting in the <b>TCP/IP Settings</b> dialog box. </td> </tr> <tr> <td width="40%"><a
    ///id="MPRIO_IpHeaderCompression"></a><a id="mprio_ipheadercompression"></a><a
    ///id="MPRIO_IPHEADERCOMPRESSION"></a><dl> <dt><b>MPRIO_IpHeaderCompression</b></dt> </dl> </td> <td width="60%"> If
    ///this flag is set, RRAS negotiates to use IP header compression on PPP connections. IP header compression can
    ///significantly improve performance. If this flag is not set, IP header compression is not negotiated. This flag
    ///corresponds to the <b>Use IP Header Compression</b> check box in the <b>TCP/IP Settings</b> dialog box. The flag
    ///should be cleared only when connecting to a server that does not correctly negotiate IP header compression. </td>
    ///</tr> <tr> <td width="40%"><a id="MPRIO_RemoteDefaultGateway"></a><a id="mprio_remotedefaultgateway"></a><a
    ///id="MPRIO_REMOTEDEFAULTGATEWAY"></a><dl> <dt><b>MPRIO_RemoteDefaultGateway</b></dt> </dl> </td> <td width="60%">
    ///If this flag is set, the default route for IP packets is through the dial-up adapter when the connection is
    ///active. If this flag is cleared, the default route is not modified. This flag corresponds to the <b>Use Default
    ///Gateway on Remote Network</b> check box in the <b>TCP/IP Settings</b> dialog box. </td> </tr> <tr> <td
    ///width="40%"><a id="MPRIO_DisableLcpExtensions"></a><a id="mprio_disablelcpextensions"></a><a
    ///id="MPRIO_DISABLELCPEXTENSIONS"></a><dl> <dt><b>MPRIO_DisableLcpExtensions</b></dt> </dl> </td> <td width="60%">
    ///If this flag is set, RRAS disables the PPP LCP extensions defined in RFC 1570. Disabling the PPP LCP extensions
    ///may be necessary to connect to certain older PPP implementations, but it interferes with features such as server
    ///callback. Do not set this flag unless it is specifically required. </td> </tr> <tr> <td width="40%"><a
    ///id="MPRIO_SwCompression"></a><a id="mprio_swcompression"></a><a id="MPRIO_SWCOMPRESSION"></a><dl>
    ///<dt><b>MPRIO_SwCompression</b></dt> </dl> </td> <td width="60%"> If this flag is set, software compression is
    ///negotiated on the link. Setting this flag causes the PPP driver to attempt to negotiate Compression Control
    ///Protocol (CCP) with the server. This flag should be set by default, but clearing it can reduce the negotiation
    ///period if the server does not support a compatible compression protocol. </td> </tr> <tr> <td width="40%"><a
    ///id="MPRIO_RequireEncryptedPw"></a><a id="mprio_requireencryptedpw"></a><a id="MPRIO_REQUIREENCRYPTEDPW"></a><dl>
    ///<dt><b>MPRIO_RequireEncryptedPw</b></dt> </dl> </td> <td width="60%"> If this flag is set, only secure password
    ///schemes can be used to authenticate the client with the server. This prevents the PPP driver from using the PAP
    ///plain-text authentication protocol to authenticate the client. However, the MS-CHAP, MD5-CHAP, and SPAP
    ///authentication protocols are supported. For increased security, set this flag. For increased interoperability,
    ///clear this flag. This flag corresponds to the <b>Require Encrypted Password</b> check box in the <b>Security</b>
    ///dialog box. For more information, see <b>MPRIO_RequireMsEncryptedPw</b>. </td> </tr> <tr> <td width="40%"><a
    ///id="MPRIO_RequireMsEncryptedPw"></a><a id="mprio_requiremsencryptedpw"></a><a
    ///id="MPRIO_REQUIREMSENCRYPTEDPW"></a><dl> <dt><b>MPRIO_RequireMsEncryptedPw</b></dt> </dl> </td> <td width="60%">
    ///If this flag is set, only the Microsoft secure password schemes can be used to authenticate the client with the
    ///server. This prevents the PPP driver from using the PAP plain-text authentication protocol, MD5-CHAP, or SPAP.
    ///For increased security, set this flag. For increased interoperability, clear this flag. This flag takes
    ///precedence over <b>MPRIO_RequireEncryptedPw</b>. This flag corresponds to the <b>Require Microsoft Encrypted
    ///Password</b> check box in the <b>Security</b> dialog box. For more information, see
    ///<b>MPRIO_RequireDataEncryption</b>. </td> </tr> <tr> <td width="40%"><a id="MPRIO_RequireDataEncryption"></a><a
    ///id="mprio_requiredataencryption"></a><a id="MPRIO_REQUIREDATAENCRYPTION"></a><dl>
    ///<dt><b>MPRIO_RequireDataEncryption</b></dt> </dl> </td> <td width="60%"> If this flag is set, data encryption
    ///must be negotiated successfully or the connection should be dropped. This flag is ignored unless
    ///<b>MPRIO_RequireMsEncryptedPw</b> is also set. This flag corresponds to the <b>Require Data Encryption</b> check
    ///box in the <b>Security</b> dialog box. </td> </tr> <tr> <td width="40%"><a id="MPRIO_NetworkLogon"></a><a
    ///id="mprio_networklogon"></a><a id="MPRIO_NETWORKLOGON"></a><dl> <dt><b>MPRIO_NetworkLogon</b></dt> </dl> </td>
    ///<td width="60%"> This flag is reserved for future use. </td> </tr> <tr> <td width="40%"><a
    ///id="MPRIO_UseLogonCredentials"></a><a id="mprio_uselogoncredentials"></a><a
    ///id="MPRIO_USELOGONCREDENTIALS"></a><dl> <dt><b>MPRIO_UseLogonCredentials</b></dt> </dl> </td> <td width="60%"> If
    ///this flag is set, RRAS uses the user name, password, and domain of the currently logged-on user when dialing this
    ///entry. This flag is ignored unless <b>MPRIO_RequireMsEncryptedPw</b> is also set. This setting is ignored by the
    ///RasDial function where specifying empty strings for the <b>szUserName</b> and <b>szPassword</b> members of the
    ///RASDIALPARAMS structure provides the same result. This flag corresponds to the <b>Use Current Username and
    ///Password</b> check box in the <b>Security</b> dialog box. </td> </tr> <tr> <td width="40%"><a
    ///id="MPRIO_PromoteAlternates"></a><a id="mprio_promotealternates"></a><a id="MPRIO_PROMOTEALTERNATES"></a><dl>
    ///<dt><b>MPRIO_PromoteAlternates</b></dt> </dl> </td> <td width="60%"> This flag has an effect when alternate phone
    ///numbers are defined by the <b>szAlternates</b> member. If this flag is set, an alternate phone number that
    ///connects successfully becomes the primary phone number, and the current primary phone number is moved to the
    ///alternate list. This flag corresponds to the check box in the <b>Alternate Numbers</b> dialog box. </td> </tr>
    ///<tr> <td width="40%"><a id="MPRIO_SecureLocalFiles"></a><a id="mprio_securelocalfiles"></a><a
    ///id="MPRIO_SECURELOCALFILES"></a><dl> <dt><b>MPRIO_SecureLocalFiles</b></dt> </dl> </td> <td width="60%"> If this
    ///flag is set, RRAS checks for existing remote file system and remote printer bindings before making a connection
    ///with this entry. Typically, you set this flag on phone-book entries for public networks to remind users to break
    ///connections to their private network before connecting to a public network. </td> </tr> <tr> <td width="40%"><a
    ///id="MPRIO_RequireEAP"></a><a id="mprio_requireeap"></a><a id="MPRIO_REQUIREEAP"></a><dl>
    ///<dt><b>MPRIO_RequireEAP</b></dt> </dl> </td> <td width="60%"> If this flag is set, Extensible Authentication
    ///Protocol (EAP) must be supported for authentication. </td> </tr> <tr> <td width="40%"><a
    ///id="MPRIO_RequirePAP"></a><a id="mprio_requirepap"></a><a id="MPRIO_REQUIREPAP"></a><dl>
    ///<dt><b>MPRIO_RequirePAP</b></dt> </dl> </td> <td width="60%"> If this flag is set, Password Authentication
    ///Protocol must be supported for authentication. </td> </tr> <tr> <td width="40%"><a id="MPRIO_RequireSPAP"></a><a
    ///id="mprio_requirespap"></a><a id="MPRIO_REQUIRESPAP"></a><dl> <dt><b>MPRIO_RequireSPAP</b></dt> </dl> </td> <td
    ///width="60%"> If this flag is set, Shiva's Password Authentication Protocol (SPAP) must be supported for
    ///authentication. </td> </tr> <tr> <td width="40%"><a id="MPRIO_SharedPhoneNumbers"></a><a
    ///id="mprio_sharedphonenumbers"></a><a id="MPRIO_SHAREDPHONENUMBERS"></a><dl>
    ///<dt><b>MPRIO_SharedPhoneNumbers</b></dt> </dl> </td> <td width="60%"> If this flag is set, phone numbers are
    ///shared. </td> </tr> <tr> <td width="40%"><a id="MPRIO_RequireCHAP"></a><a id="mprio_requirechap"></a><a
    ///id="MPRIO_REQUIRECHAP"></a><dl> <dt><b>MPRIO_RequireCHAP</b></dt> </dl> </td> <td width="60%"> If this flag is
    ///set, the Challenge Handshake Authentication Protocol must be supported for authentication. </td> </tr> <tr> <td
    ///width="40%"><a id="MPRIO_RequireMsCHAP"></a><a id="mprio_requiremschap"></a><a id="MPRIO_REQUIREMSCHAP"></a><dl>
    ///<dt><b>MPRIO_RequireMsCHAP</b></dt> </dl> </td> <td width="60%"> If this flag is set, the Microsoft Challenge
    ///Handshake Authentication Protocol must be supported for authentication. </td> </tr> <tr> <td width="40%"><a
    ///id="MPRIO_RequireMsCHAP2"></a><a id="mprio_requiremschap2"></a><a id="MPRIO_REQUIREMSCHAP2"></a><dl>
    ///<dt><b>MPRIO_RequireMsCHAP2</b></dt> </dl> </td> <td width="60%"> If this flag is set, version 2 of the Microsoft
    ///Challenge Handshake Authentication Protocol must be supported for authentication. </td> </tr> </table>
    uint        dwfOptions;
    ///A value that specifies a null-terminated string that contains a telephone number or an IPv6 address.
    ushort[129] szLocalPhoneNumber;
    ///A pointer to a list of consecutive null-terminated Unicode strings. The last string is terminated by two
    ///consecutive null characters. The strings are alternate phone numbers that the router dials, in the order listed,
    ///if the primary number fails to connect. For more information, see <b>szLocalPhoneNumber</b>.
    PWSTR       szAlternates;
    ///A value that specifies the IP address to be used while this connection is active. This member is ignored unless
    ///<b>dwfOptions</b> specifies the <b>MPRIO_SpecificIpAddr</b> flag.
    uint        ipaddr;
    ///A value that specifies the IP address of the DNS server to be used while this connection is active. This member
    ///is ignored unless <b>dwfOptions</b> specifies the <b>MPRIO_SpecificNameServers</b> flag.
    uint        ipaddrDns;
    ///A value that specifies the IP address of a secondary or backup DNS server to be used while this connection is
    ///active. This member is ignored unless <b>dwfOptions</b> specifies the <b>MPRIO_SpecificNameServers</b> flag.
    uint        ipaddrDnsAlt;
    ///A value that specifies the IP address of the WINS server to be used while this connection is active. This member
    ///is ignored unless <b>dwfOptions</b> specifies the <b>MPRIO_SpecificNameServers</b> flag.
    uint        ipaddrWins;
    ///A value that specifies the IP address of a secondary WINS server to be used while this connection is active. This
    ///member is ignored unless <b>dwfOptions</b> specifies the <b>MPRIO_SpecificNameServers</b> flag.
    uint        ipaddrWinsAlt;
    ///A value that specifies the network protocols to negotiate. This member can be a combination of the following
    ///flags. <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MPRNP_Ipx"></a><a
    ///id="mprnp_ipx"></a><a id="MPRNP_IPX"></a><dl> <dt><b>MPRNP_Ipx</b></dt> </dl> </td> <td width="60%"> Negotiate
    ///the IPX protocol. </td> </tr> <tr> <td width="40%"><a id="MPRNP_Ip"></a><a id="mprnp_ip"></a><a
    ///id="MPRNP_IP"></a><dl> <dt><b>MPRNP_Ip</b></dt> </dl> </td> <td width="60%"> Negotiate the TCP/IP protocol. </td>
    ///</tr> </table> <b>64-bit Windows: </b>The <b>MPRNP_Ipx</b> flag is not supported
    uint        dwfNetProtocols;
    ///A value that specifies a null-terminated string that indicates the RRAS device type that is referenced by
    ///<b>szDeviceName</b>. This member can be one of the following string constants. <table> <tr> <th>String</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="MPRDT_Modem"></a><a id="mprdt_modem"></a><a
    ///id="MPRDT_MODEM"></a><dl> <dt><b>MPRDT_Modem</b></dt> </dl> </td> <td width="60%"> A modem that is accessed
    ///through a COM port. </td> </tr> <tr> <td width="40%"><a id="MPRDT_Isdn"></a><a id="mprdt_isdn"></a><a
    ///id="MPRDT_ISDN"></a><dl> <dt><b>MPRDT_Isdn</b></dt> </dl> </td> <td width="60%"> An ISDN adapter with the
    ///corresponding NDISWAN driver installed. </td> </tr> <tr> <td width="40%"><a id="MPRDT_X25"></a><a
    ///id="mprdt_x25"></a><dl> <dt><b>MPRDT_X25</b></dt> </dl> </td> <td width="60%"> An X.25 adapter with the
    ///corresponding NDISWAN driver installed. </td> </tr> <tr> <td width="40%"><a id="MPRDT_Vpn"></a><a
    ///id="mprdt_vpn"></a><a id="MPRDT_VPN"></a><dl> <dt><b>MPRDT_Vpn</b></dt> </dl> </td> <td width="60%"> A virtual
    ///private network (VPN) connection. </td> </tr> <tr> <td width="40%"><a id="MPRDT_Pad"></a><a id="mprdt_pad"></a><a
    ///id="MPRDT_PAD"></a><dl> <dt><b>MPRDT_Pad</b></dt> </dl> </td> <td width="60%"> A packet assembler/disassembler.
    ///</td> </tr> <tr> <td width="40%"><a id="MPRDT_Generic"></a><a id="mprdt_generic"></a><a
    ///id="MPRDT_GENERIC"></a><dl> <dt><b>MPRDT_Generic</b></dt> </dl> </td> <td width="60%"> Generic. </td> </tr> <tr>
    ///<td width="40%"><a id="MPRDT_Serial"></a><a id="mprdt_serial"></a><a id="MPRDT_SERIAL"></a><dl>
    ///<dt><b>MPRDT_Serial</b></dt> </dl> </td> <td width="60%"> Direct serial connection through a serial port. </td>
    ///</tr> <tr> <td width="40%"><a id="MPRDT_FrameRelay"></a><a id="mprdt_framerelay"></a><a
    ///id="MPRDT_FRAMERELAY"></a><dl> <dt><b>MPRDT_FrameRelay</b></dt> </dl> </td> <td width="60%"> Frame Relay. </td>
    ///</tr> <tr> <td width="40%"><a id="MPRDT_Atm"></a><a id="mprdt_atm"></a><a id="MPRDT_ATM"></a><dl>
    ///<dt><b>MPRDT_Atm</b></dt> </dl> </td> <td width="60%"> Asynchronous Transfer Mode. </td> </tr> <tr> <td
    ///width="40%"><a id="MPRDT_Sonet"></a><a id="mprdt_sonet"></a><a id="MPRDT_SONET"></a><dl>
    ///<dt><b>MPRDT_Sonet</b></dt> </dl> </td> <td width="60%"> Sonet. </td> </tr> <tr> <td width="40%"><a
    ///id="MPRDT_SW56"></a><a id="mprdt_sw56"></a><dl> <dt><b>MPRDT_SW56</b></dt> </dl> </td> <td width="60%"> Switched
    ///56K Access. </td> </tr> <tr> <td width="40%"><a id="MPRDT_Irda"></a><a id="mprdt_irda"></a><a
    ///id="MPRDT_IRDA"></a><dl> <dt><b>MPRDT_Irda</b></dt> </dl> </td> <td width="60%"> An Infrared Data Association
    ///(IrDA)-compliant device. </td> </tr> <tr> <td width="40%"><a id="MPRDT_Parallel"></a><a
    ///id="mprdt_parallel"></a><a id="MPRDT_PARALLEL"></a><dl> <dt><b>MPRDT_Parallel</b></dt> </dl> </td> <td
    ///width="60%"> Direct parallel connection through a parallel port. </td> </tr> </table>
    ushort[17]  szDeviceType;
    ///Contains a null-terminated string that contains the name of a TAPI device to use with this phone-book entry, for
    ///example, "Fabrikam Inc 28800 External". To enumerate all available RAS-capable devices, use the RasEnumDevices
    ///function.
    ushort[129] szDeviceName;
    ///A data type that contains a null-terminated string that identifies the X.25 PAD type. Set this member to an empty
    ///string ("") unless the entry should dial using an X.25 PAD. <b>Windows 2000 and Windows NT: </b>The
    ///<b>szX25PadType</b> string maps to a section name in PAD.INF.
    ushort[33]  szX25PadType;
    ///Contains a null-terminated string that identifies the X.25 address to connect to. Set this member to an empty
    ///string ("") unless the entry should dial using an X.25 PAD or native X.25 device.
    ushort[201] szX25Address;
    ///Contains a null-terminated string that specifies the facilities to request from the X.25 host at connection time.
    ///This member is ignored if <b>szX25Address</b> is an empty string ("").
    ushort[201] szX25Facilities;
    ///Contains a null-terminated string that specifies additional connection data supplied to the X.25 host at
    ///connection time. This member is ignored if <b>szX25Address</b> is an empty string ("").
    ushort[201] szX25UserData;
    ///Reserved for future use.
    uint        dwChannels;
    ///A value that specifies the number of multilink subentries associated with this entry. When calling
    ///RasSetEntryProperties, set this member to zero. To add subentries to a phone-book entry, use the
    ///RasSetSubEntryProperties function.
    uint        dwSubEntries;
    ///Indicates whether RRAS should dial all of this entry's multilink subentries when the entry is first connected.
    ///This member can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="MPRDM_DialAll"></a><a id="mprdm_dialall"></a><a id="MPRDM_DIALALL"></a><dl>
    ///<dt><b>MPRDM_DialAll</b></dt> </dl> </td> <td width="60%"> Dial all subentries initially. </td> </tr> <tr> <td
    ///width="40%"><a id="MPRDM_DialAsNeeded"></a><a id="mprdm_dialasneeded"></a><a id="MPRDM_DIALASNEEDED"></a><dl>
    ///<dt><b>MPRDM_DialAsNeeded</b></dt> </dl> </td> <td width="60%"> Adjust the number of subentries as bandwidth is
    ///required. RRAS uses the <b>dwDialExtraPercent</b>, <b>dwDialExtraSampleSeconds</b>,
    ///<b>dwDialHangUpExtraPercent</b>, and <b>dwHangUpExtraSampleSeconds</b> members to determine when to dial or
    ///disconnect a subentry. </td> </tr> </table>
    uint        dwDialMode;
    ///A value that specifies the percentage of the total bandwidth that is available from the currently connected
    ///subentries. RRAS dials an additional subentry when the total bandwidth that is used exceeds
    ///<b>dwDialExtraPercent</b> percent of the available bandwidth for at least <b>dwDialExtraSampleSeconds</b>
    ///seconds. This member is ignored unless the <b>dwDialMode</b> member specifies the <b>MPRDM_DialAsNeeded</b> flag.
    uint        dwDialExtraPercent;
    ///A value that specifies the time, in seconds, for which current bandwidth usage must exceed the threshold that is
    ///specified by <b>dwDialExtraPercent</b> before RRAS dials an additional subentry. This member is ignored unless
    ///the <b>dwDialMode</b> member specifies the <b>MPRDM_DialAsNeeded</b> flag.
    uint        dwDialExtraSampleSeconds;
    ///A value that specifies the percentage of the total bandwidth that is available from the currently connected
    ///subentries. RRAS terminates (hangs up) an existing subentry connection when the total bandwidth used is less than
    ///<b>dwHangUpExtraPercent</b> percent of the available bandwidth for at least <b>dwHangUpExtraSampleSeconds</b>
    ///seconds. This member is ignored unless the <b>dwDialMode</b> member specifies the <b>MPRDM_DialAsNeeded</b> flag.
    uint        dwHangUpExtraPercent;
    ///A value that specifies the time, in seconds, for which current bandwidth usage must be less than the threshold
    ///that is specified by <b>dwHangUpExtraPercent</b> before RRAS terminates an existing subentry connection. This
    ///member is ignored unless the <b>dwDialMode</b> member specifies the <b>MPRDM_DialAsNeeded</b> flag.
    uint        dwHangUpExtraSampleSeconds;
    ///A value that specifies the time, in seconds, after which an inactive connection is terminated. Unless the idle
    ///time-out is disabled, the entire connection is terminated if the connection is idle for the specified interval.
    ///This member can specify either a time-out value, or one of the following values. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="MPRIDS_Disabled"></a><a id="mprids_disabled"></a><a
    ///id="MPRIDS_DISABLED"></a><dl> <dt><b>MPRIDS_Disabled</b></dt> </dl> </td> <td width="60%"> There is no idle
    ///time-out for this connection. </td> </tr> <tr> <td width="40%"><a id="MPRIDS_UseGlobalValue"></a><a
    ///id="mprids_useglobalvalue"></a><a id="MPRIDS_USEGLOBALVALUE"></a><dl> <dt><b>MPRIDS_UseGlobalValue</b></dt> </dl>
    ///</td> <td width="60%"> Use the user preference value as the default. </td> </tr> </table>
    uint        dwIdleDisconnectSeconds;
    ///A value that specifies the type of phone-book entry. This member can be one of the following types. <table> <tr>
    ///<th>Type</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MPRET_Phone"></a><a id="mpret_phone"></a><a
    ///id="MPRET_PHONE"></a><dl> <dt><b>MPRET_Phone</b></dt> </dl> </td> <td width="60%"> Phone line, for example,
    ///modem, ISDN, or X.25. </td> </tr> <tr> <td width="40%"><a id="MPRET_Vpn"></a><a id="mpret_vpn"></a><a
    ///id="MPRET_VPN"></a><dl> <dt><b>MPRET_Vpn</b></dt> </dl> </td> <td width="60%"> Virtual Private Network. </td>
    ///</tr> <tr> <td width="40%"><a id="MPRET_Direct"></a><a id="mpret_direct"></a><a id="MPRET_DIRECT"></a><dl>
    ///<dt><b>MPRET_Direct</b></dt> </dl> </td> <td width="60%"> Direct serial or parallel connection. </td> </tr>
    ///</table>
    uint        dwType;
    ///A value that specifies the type of encryption to use for Microsoft Point-to-Point Encryption (MPPE) with the
    ///connection. This member can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="MPR_ET_None"></a><a id="mpr_et_none"></a><a id="MPR_ET_NONE"></a><dl>
    ///<dt><b>MPR_ET_None</b></dt> </dl> </td> <td width="60%"> Do not use encryption. </td> </tr> <tr> <td
    ///width="40%"><a id="MPR_ET_Require"></a><a id="mpr_et_require"></a><a id="MPR_ET_REQUIRE"></a><dl>
    ///<dt><b>MPR_ET_Require</b></dt> </dl> </td> <td width="60%"> Use encryption. </td> </tr> <tr> <td width="40%"><a
    ///id="MPR_ET_RequireMax"></a><a id="mpr_et_requiremax"></a><a id="MPR_ET_REQUIREMAX"></a><dl>
    ///<dt><b>MPR_ET_RequireMax</b></dt> </dl> </td> <td width="60%"> Use maximum-strength encryption. </td> </tr> <tr>
    ///<td width="40%"><a id="MPR_ET_Optional"></a><a id="mpr_et_optional"></a><a id="MPR_ET_OPTIONAL"></a><dl>
    ///<dt><b>MPR_ET_Optional</b></dt> </dl> </td> <td width="60%"> If possible, use encryption. </td> </tr> </table>
    ///The value of <b>dwEncryptionType</b> does not affect how passwords are encrypted. Whether passwords are encrypted
    ///and how passwords are encrypted is determined by the authentication protocol, for example, PAP, MS-CHAP, or EAP.
    uint        dwEncryptionType;
    ///A value that specifies the authentication key to be provided to an Extensible Authentication Protocol (EAP)
    ///vendor.
    uint        dwCustomAuthKey;
    ///A value that specifies the size of the data pointed to by the <b>lpbCustomAuthData</b> member.
    uint        dwCustomAuthDataSize;
    ///A pointer to authentication data to use with EAP.
    ubyte*      lpbCustomAuthData;
    ///The globally unique identifier (GUID) that represents this phone-book entry. This member is read-only.
    GUID        guidId;
    ///The VPN strategy to use when dialing a VPN connection. This member can have one of the following values. <table>
    ///<tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MPR_VS_Default"></a><a
    ///id="mpr_vs_default"></a><a id="MPR_VS_DEFAULT"></a><dl> <dt><b>MPR_VS_Default</b></dt> </dl> </td> <td
    ///width="60%"> RRAS dials PPTP first. If PPTP fails, L2TP is attempted. The protocol that succeeds is tried first
    ///in subsequent dialing for this entry. </td> </tr> <tr> <td width="40%"><a id="MPR_VS_PptpOnly"></a><a
    ///id="mpr_vs_pptponly"></a><a id="MPR_VS_PPTPONLY"></a><dl> <dt><b>MPR_VS_PptpOnly</b></dt> </dl> </td> <td
    ///width="60%"> RAS dials only PPTP. </td> </tr> <tr> <td width="40%"><a id="MPR_VS_PptpFirst"></a><a
    ///id="mpr_vs_pptpfirst"></a><a id="MPR_VS_PPTPFIRST"></a><dl> <dt><b>MPR_VS_PptpFirst</b></dt> </dl> </td> <td
    ///width="60%"> RAS always dials PPTP first, L2TP second. </td> </tr> <tr> <td width="40%"><a
    ///id="MPR_VS_L2tpOnly"></a><a id="mpr_vs_l2tponly"></a><a id="MPR_VS_L2TPONLY"></a><dl>
    ///<dt><b>MPR_VS_L2tpOnly</b></dt> </dl> </td> <td width="60%"> RAS dials only L2TP. </td> </tr> <tr> <td
    ///width="40%"><a id="MPR_VS_L2tpFirst"></a><a id="mpr_vs_l2tpfirst"></a><a id="MPR_VS_L2TPFIRST"></a><dl>
    ///<dt><b>MPR_VS_L2tpFirst</b></dt> </dl> </td> <td width="60%"> RAS dials L2TP first, PPTP second. </td> </tr>
    ///</table>
    uint        dwVpnStrategy;
    ///Not used.
    uint        AddressCount;
    ///A value that specifies the IP address of the DNS server to be used while this connection is active.
    in6_addr    ipv6addrDns;
    ///A value that specifies the IP address of a secondary or backup DNS server to be used while this connection is
    ///active.
    in6_addr    ipv6addrDnsAlt;
    ///Not used.
    in6_addr*   ipv6addr;
}

///The <b>MPR_DEVICE_0</b> structure stores information about a device used for a link in a multilinked demand dial
///interface.
struct MPR_DEVICE_0
{
    ///Specifies a null-terminated string that indicates the RAS device type referenced by <b>szDeviceName</b>. See
    ///MPR_INTERFACE_2 for a list of possible device types.
    ushort[17]  szDeviceType;
    ///Specifies a null-terminated string that contains the name of the TAPI device to use with this phone-book entry.
    ushort[129] szDeviceName;
}

///The <b>MPR_DEVICE_1</b> structure stores information about a device used for a link in a multilinked demand dial
///interface. In addition to the information in MPR_DEVICE_0, <b>MPR_DEVICE_1</b> contains phone-number information.
struct MPR_DEVICE_1
{
    ///Specifies a null-terminated string that indicates the device type referenced by <b>szDeviceName</b>. See
    ///MPR_INTERFACE_2 for a list of possible device types.
    ushort[17]  szDeviceType;
    ///Specifies a null-terminated string that contains the name of the TAPI device to use with this phone-book entry.
    ushort[129] szDeviceName;
    ///Specifies a null-terminated Unicode string that contains a telephone number. The router uses the
    ///<b>szLocalPhoneNumber</b> string as the entire phone number.
    ushort[129] szLocalPhoneNumber;
    ///Pointer to a list of consecutive null-terminated Unicode strings. The last string is terminated by two
    ///consecutive null characters. The strings are alternate phone numbers that the router dials in the order listed if
    ///the primary number (see <b>szLocalPhoneNumber</b>) fails to connect.
    PWSTR       szAlternates;
}

///The <b>MPR_CREDENTIALSEX_0</b> structure contains extended credentials information such as the information used by
///Extensible Authentication Protocols (EAPs).
struct MPR_CREDENTIALSEX_0
{
    ///Specifies the size of the data pointed to by the <b>lpbCredentialsInfo</b> member.
    uint   dwSize;
    ///Pointer to the extended credentials information.
    ubyte* lpbCredentialsInfo;
}

///The <b>MPR_CREDENTIALSEX_1</b> structure contains a pre-shared key used by a demand-dial interface.
struct MPR_CREDENTIALSEX_1
{
    ///Specifies the size of the data pointed to by the <b>lpbCredentialsInfo</b> member.
    uint   dwSize;
    ///Pointer to the pre-shared key.
    ubyte* lpbCredentialsInfo;
}

///The <b>MPR_TRANSPORT_0</b> structure contains information for a particular transport.
struct MPR_TRANSPORT_0
{
    ///A <b>DWORD</b> value that identifies the transport protocol type. Supported transport protocol types are listed
    ///on Transport Identifiers.
    uint       dwTransportId;
    ///Handle to the transport.
    HANDLE     hTransport;
    ///A Unicode string that contains the name of the transport.
    ushort[41] wszTransportName;
}

///The <b>MPR_IFTRANSPORT_0</b> structure contains information for a particular interface transport.
struct MPR_IFTRANSPORT_0
{
    ///Identifies the transport.
    uint       dwTransportId;
    ///Handle to the interface transport.
    HANDLE     hIfTransport;
    ///Specifies a Unicode string that contains the name of the interface transport.
    ushort[41] wszIfTransportName;
}

///The <b>MPR_SERVER_0</b> structure is used to retrieve information about a device.
struct MPR_SERVER_0
{
    ///A <b>BOOL</b> that specifies whether the Demand Dial Manager (DDM) is running on the device. If <b>TRUE</b>, the
    ///DDM is not running on the device. Otherwise, it is <b>FALSE</b>.
    BOOL fLanOnlyMode;
    ///Specifies the elapsed time, in seconds, since the device was started.
    uint dwUpTime;
    ///Specifies the number of ports on the device.
    uint dwTotalPorts;
    ///Specifies the number of ports currently in use on the device.
    uint dwPortsInUse;
}

///The <b>MPR_SERVER_1</b> structure is used to retrieve and set the number of ports available for the Point-to-Point
///Tunneling Protocol (PPTP) and Layer 2 Tunneling Protocol (L2TP) on a device.
struct MPR_SERVER_1
{
    ///Specifies the number of ports configured for PPTP on the device. The maximum values for <i>dwNumPptpPorts</i> are
    ///listed in the following table. The value zero is not allowed. <table> <tr> <th>Maximum Value</th> <th>Windows
    ///Version</th> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td width="60%"> Windows Server 2003, Web
    ///Edition </td> </tr> <tr> <td width="40%"> <dl> <dt>1000</dt> </dl> </td> <td width="60%"> Windows Server 2003,
    ///Standard Edition </td> </tr> <tr> <td width="40%"> <dl> <dt>16,384</dt> </dl> </td> <td width="60%"> Windows
    ///Server 2003, Datacenter Edition and Windows Server 2003, Enterprise Edition </td> </tr> </table> If
    ///<i>dwNumPptpPorts</i> contains a value beyond the limit configured in the registry at service start time (the
    ///default is 1000 for Windows Server 2003, Standard Edition and Windows Server 2003, Enterprise Edition), the
    ///MprConfigServerSetInfo and MprAdminServerSetInfo functions will return <b>ERROR_SUCCESS_REBOOT_REQUIRED</b>.
    uint dwNumPptpPorts;
    ///A set of bitflags that indicate if RAS or Routing is enabled on the device. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="MPR_ENABLE_RAS_ON_DEVICE"></a><a
    ///id="mpr_enable_ras_on_device"></a><dl> <dt><b>MPR_ENABLE_RAS_ON_DEVICE</b></dt> </dl> </td> <td width="60%"> If
    ///set, RAS is enabled on the device. </td> </tr> <tr> <td width="40%"><a id="MPR_ENABLE_ROUTING_ON_DEVICE"></a><a
    ///id="mpr_enable_routing_on_device"></a><dl> <dt><b>MPR_ENABLE_ROUTING_ON_DEVICE</b></dt> </dl> </td> <td
    ///width="60%"> If set, Routing is enabled on the device. </td> </tr> </table>
    uint dwPptpPortFlags;
    ///Specifies the number of ports configured for L2TP on the device. The maximum values for <i>dwNumL2tpPorts</i> are
    ///listed in the following table. The value zero is not allowed. <table> <tr> <th>Maximum Value</th> <th>Windows
    ///Version</th> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td width="60%"> Windows Server 2003, Web
    ///Edition </td> </tr> <tr> <td width="40%"> <dl> <dt>1000</dt> </dl> </td> <td width="60%"> Windows Server 2003,
    ///Standard Edition </td> </tr> <tr> <td width="40%"> <dl> <dt>30,000</dt> </dl> </td> <td width="60%"> Windows
    ///Server 2003, Datacenter Edition and Windows Server 2003, Enterprise Edition </td> </tr> </table> If
    ///<i>dwNumL2tpPorts</i> contains a value beyond the limit configured in the registry at service start time (the
    ///default is 1000 for Windows Server 2003, Standard Edition and Windows Server 2003, Enterprise Edition), the
    ///MprConfigServerSetInfo and MprAdminServerSetInfo functions will return <b>ERROR_SUCCESS_REBOOT_REQUIRED</b>.
    uint dwNumL2tpPorts;
    ///A set of bitflags that indicate if RAS or Routing is enabled on the device. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="MPR_ENABLE_RAS_ON_DEVICE"></a><a
    ///id="mpr_enable_ras_on_device"></a><dl> <dt><b>MPR_ENABLE_RAS_ON_DEVICE</b></dt> </dl> </td> <td width="60%"> If
    ///set, RAS is enabled on the device. </td> </tr> <tr> <td width="40%"><a id="MPR_ENABLE_ROUTING_ON_DEVICE"></a><a
    ///id="mpr_enable_routing_on_device"></a><dl> <dt><b>MPR_ENABLE_ROUTING_ON_DEVICE</b></dt> </dl> </td> <td
    ///width="60%"> If set, Routing is enabled on the device. </td> </tr> </table>
    uint dwL2tpPortFlags;
}

///The <b>MPR_SERVER_2</b> structure is used to retrieve and set the number of ports available for the Point-to-Point
///Tunneling Protocol (PPTP), Layer 2 Tunneling Protocol (L2TP), and Secure Socket Tunneling Protocol (SSTP) on a
///device.
struct MPR_SERVER_2
{
    ///Specifies the number of ports configured for PPTP on the device. The maximum values for <i>dwNumPptpPorts</i> are
    ///listed in the following table. The value zero is not allowed. <table> <tr> <th>Maximum Value</th> <th>Windows
    ///Version</th> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td width="60%"> Windows Web Server 2008
    ///</td> </tr> <tr> <td width="40%"> <dl> <dt>1000</dt> </dl> </td> <td width="60%"> Windows Server 2008 Standard
    ///</td> </tr> <tr> <td width="40%"> <dl> <dt>16,384</dt> </dl> </td> <td width="60%"> Windows Server 2008
    ///Datacenter and Windows Server 2008 Enterprise </td> </tr> </table> If <i>dwNumPptpPorts</i> contains a value
    ///beyond the limit configured in the registry at service start time (the default is 1000 for Windows Server 2008
    ///Standard and Windows Server 2008 Enterprise), the MprConfigServerSetInfo and MprAdminServerSetInfo functions will
    ///return <b>ERROR_SUCCESS_REBOOT_REQUIRED</b>.
    uint dwNumPptpPorts;
    ///A set of bitflags that indicate if RAS or Routing is enabled on the device. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="MPR_ENABLE_RAS_ON_DEVICE"></a><a
    ///id="mpr_enable_ras_on_device"></a><dl> <dt><b>MPR_ENABLE_RAS_ON_DEVICE</b></dt> </dl> </td> <td width="60%"> If
    ///set, RAS is enabled on the device. </td> </tr> <tr> <td width="40%"><a id="MPR_ENABLE_ROUTING_ON_DEVICE"></a><a
    ///id="mpr_enable_routing_on_device"></a><dl> <dt><b>MPR_ENABLE_ROUTING_ON_DEVICE</b></dt> </dl> </td> <td
    ///width="60%"> If set, Routing is enabled on the device. </td> </tr> </table>
    uint dwPptpPortFlags;
    ///Specifies the number of ports configured for L2TP on the device. The maximum values for <i>dwNumL2tpPorts</i> are
    ///listed in the following table. The value zero is not allowed. <table> <tr> <th>Maximum Value</th> <th>Windows
    ///Version</th> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td width="60%"> Windows Web Server 2008
    ///</td> </tr> <tr> <td width="40%"> <dl> <dt>1000</dt> </dl> </td> <td width="60%"> Windows Server 2008 Standard
    ///</td> </tr> <tr> <td width="40%"> <dl> <dt>30,000</dt> </dl> </td> <td width="60%"> Windows Server 2008
    ///Datacenter and Windows Server 2008 Enterprise </td> </tr> </table> If <i>dwNumL2tpPorts</i> contains a value
    ///beyond the limit configured in the registry at service start time (the default is 1000 for Windows Server 2008
    ///Standard and Windows Server 2008 Enterprise), the MprConfigServerSetInfo and MprAdminServerSetInfo functions will
    ///return <b>ERROR_SUCCESS_REBOOT_REQUIRED</b>.
    uint dwNumL2tpPorts;
    ///A set of bitflags that indicate if RAS or Routing is enabled on the device. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="MPR_ENABLE_RAS_ON_DEVICE"></a><a
    ///id="mpr_enable_ras_on_device"></a><dl> <dt><b>MPR_ENABLE_RAS_ON_DEVICE</b></dt> </dl> </td> <td width="60%"> If
    ///set, RAS is enabled on the device. </td> </tr> <tr> <td width="40%"><a id="MPR_ENABLE_ROUTING_ON_DEVICE"></a><a
    ///id="mpr_enable_routing_on_device"></a><dl> <dt><b>MPR_ENABLE_ROUTING_ON_DEVICE</b></dt> </dl> </td> <td
    ///width="60%"> If set, Routing is enabled on the device. </td> </tr> </table>
    uint dwL2tpPortFlags;
    ///Specifies the number of ports configured for SSTP on the device. The maximum values for <i>dwNumSstpPorts</i> are
    ///listed in the following table. The value zero is not allowed. <table> <tr> <th>Maximum Value</th> <th>Windows
    ///Version</th> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td width="60%"> Windows Web Server 2008
    ///</td> </tr> <tr> <td width="40%"> <dl> <dt>1000</dt> </dl> </td> <td width="60%"> Windows Server 2008 Standard
    ///</td> </tr> <tr> <td width="40%"> <dl> <dt>30,000</dt> </dl> </td> <td width="60%"> Windows Server 2008
    ///Datacenter and Windows Server 2008 Enterprise </td> </tr> </table> If <i>dwNumSstpPorts</i> contains a value
    ///beyond the limit configured in the registry at service start time (the default is 1000 for Windows Server 2008
    ///Standard and Windows Server 2008 Enterprise), the MprConfigServerSetInfo and MprAdminServerSetInfo functions will
    ///return <b>ERROR_SUCCESS_REBOOT_REQUIRED</b>.
    uint dwNumSstpPorts;
    ///A set of bitflags that indicate if RAS is enabled on the device. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="MPR_ENABLE_RAS_ON_DEVICE"></a><a id="mpr_enable_ras_on_device"></a><dl>
    ///<dt><b>MPR_ENABLE_RAS_ON_DEVICE</b></dt> </dl> </td> <td width="60%"> If set, RAS is enabled on the device. </td>
    ///</tr> </table>
    uint dwSstpPortFlags;
}

///The <b>RAS_PORT_0</b> structure contains general information regarding a specific RAS port, such as port condition
///and port name. For more detailed information about a specific port, such as line speed or errors, see RAS_PORT_1.
struct RAS_PORT_0
{
    ///Handle to the port.
    HANDLE             hPort;
    ///Handle to the connection.
    HANDLE             hConnection;
    ///RAS_PORT_CONDITION structure.
    RAS_PORT_CONDITION dwPortCondition;
    ///Specifies the cumulative number of calls this port has serviced.
    uint               dwTotalNumberOfCalls;
    ///Specifies the duration of the current connection, in seconds.
    uint               dwConnectDuration;
    ///Specifies the port name.
    ushort[17]         wszPortName;
    ///Specifies the media name.
    ushort[17]         wszMediaName;
    ///Specifies the device name.
    ushort[129]        wszDeviceName;
    ///Specifies the device type.
    ushort[17]         wszDeviceType;
}

///The <b>RAS_PORT_1</b> structure contains detailed information regarding a specific RAS port, such as line speed or
///errors. For more general information about a port, such as port condition or port name, see RAS_PORT_0.
struct RAS_PORT_1
{
    ///Handle to the port.
    HANDLE hPort;
    ///Handle to the connection.
    HANDLE hConnection;
    ///Specifies a RAS_HARDWARE_CONDITION structure.
    RAS_HARDWARE_CONDITION dwHardwareCondition;
    ///Specifies the line speed of the port, represented in bits per second.
    uint   dwLineSpeed;
    ///Specifies the bytes transmitted on the port. This value is the number of bytes of compressed data.
    uint   dwBytesXmited;
    ///Specifies the bytes received on the port. This value is the number of bytes of compressed data.
    uint   dwBytesRcved;
    ///Specifies the frames transmitted on the port.
    uint   dwFramesXmited;
    ///Specifies the frames received on the port.
    uint   dwFramesRcved;
    ///Specifies the CRC errors on the port.
    uint   dwCrcErr;
    ///Specifies the time-out errors on the port.
    uint   dwTimeoutErr;
    ///Specifies the alignment errors on the port.
    uint   dwAlignmentErr;
    ///Specifies the hardware overrun errors on the port.
    uint   dwHardwareOverrunErr;
    ///Specifies the framing errors on the port.
    uint   dwFramingErr;
    ///Specifies the buffer overrun errors on the port.
    uint   dwBufferOverrunErr;
    ///Specifies a percentage that indicates the degree to which data received on this connection is compressed. The
    ///ratio is the size of the compressed data divided by the size of the same data in an uncompressed state.
    uint   dwCompressionRatioIn;
    ///Specifies a percentage indicating the degree to which data transmitted on this connection is compressed. The
    ///ratio is the size of the compressed data divided by the size of the same data in an uncompressed state.
    uint   dwCompressionRatioOut;
}

struct RAS_PORT_2
{
    HANDLE      hPort;
    HANDLE      hConnection;
    uint        dwConn_State;
    ushort[17]  wszPortName;
    ushort[17]  wszMediaName;
    ushort[129] wszDeviceName;
    ushort[17]  wszDeviceType;
    RAS_HARDWARE_CONDITION dwHardwareCondition;
    uint        dwLineSpeed;
    uint        dwCrcErr;
    uint        dwSerialOverRunErrs;
    uint        dwTimeoutErr;
    uint        dwAlignmentErr;
    uint        dwHardwareOverrunErr;
    uint        dwFramingErr;
    uint        dwBufferOverrunErr;
    uint        dwCompressionRatioIn;
    uint        dwCompressionRatioOut;
    uint        dwTotalErrors;
    ulong       ullBytesXmited;
    ulong       ullBytesRcved;
    ulong       ullFramesXmited;
    ulong       ullFramesRcved;
    ulong       ullBytesTxUncompressed;
    ulong       ullBytesTxCompressed;
    ulong       ullBytesRcvUncompressed;
    ulong       ullBytesRcvCompressed;
}

///The <b>PPP_NBFCP_INFO</b> structure contains the result of a PPP NetBEUI Framer (NBF) projection operation.
struct PPP_NBFCP_INFO
{
    ///Specifies the result of the PPP control protocol negotiation. A value of zero indicates success. A nonzero value
    ///indicates failure, and is the actual fatal error that occurred during the control protocol negotiation.
    uint       dwError;
    ///Specifies a Unicode string that is the local workstation's computer name. This unique computer name is the
    ///closest NetBIOS equivalent to a client's NetBEUI address on a remote access connection.
    ushort[17] wszWksta;
}

///The <b>PPP_IPCP_INFO</b> structure contains the result of a PPP Internet Protocol (IP) negotiation.
struct PPP_IPCP_INFO
{
    ///Specifies the result of the PPP control protocol negotiation. A value of zero indicates success. A nonzero value
    ///indicates failure, and is the actual fatal error that occurred during the control protocol negotiation.
    uint       dwError;
    ///Specifies a Unicode string that holds the local computer's IP address for the connection. This string has the
    ///form <i>a</i><b>.</b><i>b</i><b>.</b><i>c</i><b>.</b><i>d</i>; for example, "10.102.235.84". The
    ///<b>PPP_IPCP_INFO</b> structures provides address information from the perspective of the server. For example, if
    ///a remote access client is connecting to a RAS server, this member holds the IP address of the server.
    ushort[16] wszAddress;
    ///Specifies a Unicode string that holds the IP address of the remote computer. This string has the form
    ///<i>a</i><b>.</b><i>b</i><b>.</b><i>c</i><b>.</b><i>d</i>. If the address is not available, this member is an
    ///empty string. The <b>PPP_IPCP_INFO</b> structures provides address information from the perspective of the
    ///server. For example, if a remote access client is connecting to a RAS server, this member holds the IP address of
    ///the client.
    ushort[16] wszRemoteAddress;
}

///The <b>PPP_IPCP_INFO2</b> structure contains the result of a PPP Internet Protocol (IP) negotiation.
struct PPP_IPCP_INFO2
{
    ///Specifies the result of the PPP control protocol negotiation. A value of zero indicates success. A nonzero value
    ///indicates failure, and is the actual fatal error that occurred during the control protocol negotiation.
    uint       dwError;
    ///Specifies a Unicode string that holds the local computer's IP address for the connection. This string has the
    ///form <i>a</i><b>.</b><i>b</i><b>.</b><i>c</i><b>.</b><i>d</i>; for example, "10.102.235.84". The
    ///<b>PPP_IPCP_INFO2</b> structures provides address information from the perspective of the server. For example, if
    ///a remote access client is connecting to a RAS server, this member holds the IP address of the server.
    ushort[16] wszAddress;
    ///Specifies a Unicode string that holds the IP address of the remote computer. This string has the form
    ///<i>a</i><b>.</b><i>b</i><b>.</b><i>c</i><b>.</b><i>d</i>. If the address is not available, this member specifies
    ///an empty string. The <b>PPP_IPCP_INFO2</b> structures provides address information from the perspective of the
    ///server. For example, if a remote access client is connecting to a RAS server, this member holds the IP address of
    ///the client.
    ushort[16] wszRemoteAddress;
    ///Specifies IPCP options for the local computer. Currently, the only option is PPP_IPCP_VJ. This option indicates
    ///that IP datagrams sent by the local computer are compressed using Van Jacobson compression.
    uint       dwOptions;
    ///Specifies IPCP options for the remote peer. Currently, the only option is PPP_IPCP_VJ. This option indicates that
    ///IP datagrams sent by the remote peer (that is, received by the local computer) are compressed using Van Jacobson
    ///compression.
    uint       dwRemoteOptions;
}

///The <b>PPP_IPXCP_INFO</b> structure contains the result of a PPP Internetwork Packet Exchange (IPX) projection
///operation.
struct PPP_IPXCP_INFO
{
    ///Specifies the result of the PPP control protocol negotiation. A value of zero indicates success. A nonzero value
    ///indicates failure, and is the actual fatal error that occurred during the control protocol negotiation.
    uint       dwError;
    ///Specifies a Unicode string that holds the client's IPX address on the RAS connection. This address string has the
    ///form <i>net</i><b>.</b><i>node</i>, for example, "1234ABCD.12AB34CD56EF".
    ushort[23] wszAddress;
}

///The <b>PPP_ATCP_INFO</b> structure contains the result of a PPP AppleTalk projection operation.
struct PPP_ATCP_INFO
{
    ///Specifies the result of the PPP control protocol negotiation. A value of zero indicates success. A nonzero value
    ///indicates failure, and is the actual fatal error that occurred during the control protocol negotiation.
    uint       dwError;
    ///Specifies a Unicode string that holds the client's AppleTalk address on the RAS connection.
    ushort[33] wszAddress;
}

///The <b>PPP_IPV6_CP_INFO</b> structure contains the result of an IPv6 control protocol negotiation.
struct PPP_IPV6_CP_INFO
{
    ///The version of the <b>PPP_IPV6_CP_INFO</b> structure used.
    uint     dwVersion;
    ///The size, in bytes, of this <b>PPP_IPV6_CP_INFO</b> structure.
    uint     dwSize;
    ///Specifies the result of the PPP control protocol negotiation. A value of zero indicates success. A nonzero value
    ///indicates failure, and is the actual fatal error that occurred during the control protocol negotiation.
    uint     dwError;
    ///Specifies the 64 bit interface identifier of the IPv6 server interface.
    ubyte[8] bInterfaceIdentifier;
    ///Specifies the 64 bit interface identifier of the IPv6 client interface.
    ubyte[8] bRemoteInterfaceIdentifier;
    ///Reserved. Must be set to 0.
    uint     dwOptions;
    ///Reserved. Must be set to 0.
    uint     dwRemoteOptions;
    ///Specifies the address prefix of the IPv6 client interface.
    ubyte[8] bPrefix;
    ///The length, in bits, of the address prefix.
    uint     dwPrefixLength;
}

///The <b>PPP_INFO</b> structure is used to report the results of the various Point-to-Point (PPP) projection operations
///for a connection.
struct PPP_INFO
{
    ///A PPP_NBFCP_INFO structure that contains PPP NetBEUI Framer (NBF) projection information.
    PPP_NBFCP_INFO nbf;
    ///A PPP_IPCP_INFO structure that contains PPP Internet Protocol (IP) projection information.
    PPP_IPCP_INFO  ip;
    ///A PPP_IPXCP_INFO structure that contains PPP Internetwork Packet Exchange (IPX) projection information.
    PPP_IPXCP_INFO ipx;
    ///A PPP_ATCP_INFO structure that contains PPP AppleTalk projection information.
    PPP_ATCP_INFO  at;
}

///The <b>PPP_CCP_INFO</b> structure contains information that describes the results of a Compression Control Protocol
///(CCP) negotiation.
struct PPP_CCP_INFO
{
    ///Specifies an error if the negotiation is unsuccessful.
    uint dwError;
    ///Specifies the compression algorithm used by the local computer. The following table shows the possible values for
    ///this member. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RASCCPCA_MPPC"></a><a
    ///id="rasccpca_mppc"></a><dl> <dt><b>RASCCPCA_MPPC</b></dt> </dl> </td> <td width="60%"> Microsoft Point-to-Point
    ///Compression (MPPC) Protocol </td> </tr> <tr> <td width="40%"><a id="RASCCPCA_STAC"></a><a
    ///id="rasccpca_stac"></a><dl> <dt><b>RASCCPCA_STAC</b></dt> </dl> </td> <td width="60%"> STAC option 4 </td> </tr>
    ///</table>
    uint dwCompressionAlgorithm;
    ///Specifies the compression options on the local computer. The following options are supported. <table> <tr>
    ///<th>Option</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PPP_CCP_COMPRESSION"></a><a
    ///id="ppp_ccp_compression"></a><dl> <dt><b>PPP_CCP_COMPRESSION</b></dt> </dl> </td> <td width="60%"> Compression
    ///without encryption. </td> </tr> <tr> <td width="40%"><a id="PPP_CCP_HISTORYLESS"></a><a
    ///id="ppp_ccp_historyless"></a><dl> <dt><b>PPP_CCP_HISTORYLESS</b></dt> </dl> </td> <td width="60%"> Microsoft
    ///Point-to-Point Encryption (MPPE) in stateless mode. The session key is changed after every packet. This mode
    ///improves performance on high latency networks, or networks that experience significant packet loss. </td> </tr>
    ///<tr> <td width="40%"><a id="PPP_CCP_ENCRYPTION40BITOLD"></a><a id="ppp_ccp_encryption40bitold"></a><dl>
    ///<dt><b>PPP_CCP_ENCRYPTION40BITOLD</b></dt> </dl> </td> <td width="60%"> MPPE using 40-bit keys. </td> </tr> <tr>
    ///<td width="40%"><a id="PPP_CCP_ENCRYPTION40BIT"></a><a id="ppp_ccp_encryption40bit"></a><dl>
    ///<dt><b>PPP_CCP_ENCRYPTION40BIT</b></dt> </dl> </td> <td width="60%"> MPPE using 40-bit keys. </td> </tr> <tr> <td
    ///width="40%"><a id="PPP_CCP_ENCRYPTION56BIT"></a><a id="ppp_ccp_encryption56bit"></a><dl>
    ///<dt><b>PPP_CCP_ENCRYPTION56BIT</b></dt> </dl> </td> <td width="60%"> MPPE using 56-bit keys. </td> </tr> <tr> <td
    ///width="40%"><a id="PPP_CCP_ENCRYPTION128BIT"></a><a id="ppp_ccp_encryption128bit"></a><dl>
    ///<dt><b>PPP_CCP_ENCRYPTION128BIT</b></dt> </dl> </td> <td width="60%"> MPPE using 128-bit keys. </td> </tr>
    ///</table>
    uint dwOptions;
    ///Specifies the compression algorithm used by the remote computer. The following table shows the possible values
    ///for this member. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="RASCCPCA_MPPC"></a><a id="rasccpca_mppc"></a><dl> <dt><b>RASCCPCA_MPPC</b></dt> </dl> </td> <td width="60%">
    ///Microsoft Point-to-Point Compression (MPPC) Protocol </td> </tr> <tr> <td width="40%"><a
    ///id="RASCCPCA_STAC"></a><a id="rasccpca_stac"></a><dl> <dt><b>RASCCPCA_STAC</b></dt> </dl> </td> <td width="60%">
    ///STAC option 4 </td> </tr> </table>
    uint dwRemoteCompressionAlgorithm;
    ///Specifies the compression options on the remote computer. The following options are supported. <table> <tr>
    ///<th>Option</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PPP_CCP_COMPRESSION"></a><a
    ///id="ppp_ccp_compression"></a><dl> <dt><b>PPP_CCP_COMPRESSION</b></dt> </dl> </td> <td width="60%"> Compression
    ///without encryption. </td> </tr> <tr> <td width="40%"><a id="PPP_CCP_HISTORYLESS"></a><a
    ///id="ppp_ccp_historyless"></a><dl> <dt><b>PPP_CCP_HISTORYLESS</b></dt> </dl> </td> <td width="60%"> Microsoft
    ///Point-to-Point Encryption (MPPE) in stateless mode. The session key is changed after every packet. This mode
    ///improves performance on high latency networks, or networks that experience significant packet loss. </td> </tr>
    ///<tr> <td width="40%"><a id="PPP_CCP_ENCRYPTION40BITOLD"></a><a id="ppp_ccp_encryption40bitold"></a><dl>
    ///<dt><b>PPP_CCP_ENCRYPTION40BITOLD</b></dt> </dl> </td> <td width="60%"> MPPE using 40-bit keys. </td> </tr> <tr>
    ///<td width="40%"><a id="PPP_CCP_ENCRYPTION40BIT"></a><a id="ppp_ccp_encryption40bit"></a><dl>
    ///<dt><b>PPP_CCP_ENCRYPTION40BIT</b></dt> </dl> </td> <td width="60%"> MPPE using 40-bit keys. </td> </tr> <tr> <td
    ///width="40%"><a id="PPP_CCP_ENCRYPTION56BIT"></a><a id="ppp_ccp_encryption56bit"></a><dl>
    ///<dt><b>PPP_CCP_ENCRYPTION56BIT</b></dt> </dl> </td> <td width="60%"> MPPE using 56-bit keys. </td> </tr> <tr> <td
    ///width="40%"><a id="PPP_CCP_ENCRYPTION128BIT"></a><a id="ppp_ccp_encryption128bit"></a><dl>
    ///<dt><b>PPP_CCP_ENCRYPTION128BIT</b></dt> </dl> </td> <td width="60%"> MPPE using 128-bit keys. </td> </tr>
    ///</table>
    uint dwRemoteOptions;
}

///The <b>PPP_LCP_INFO</b> structure contains information that describes the results of an PPP Link Control Protocol
///(LCP) negotiation.
struct PPP_LCP_INFO
{
    ///Specifies the error that occurred if the negotiation was unsuccessful.
    uint dwError;
    ///Specifies the authentication protocol used to authenticate the local computer. This member can be one of the
    ///following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="PPP_LCP_PAP"></a><a id="ppp_lcp_pap"></a><dl> <dt><b>PPP_LCP_PAP</b></dt> </dl> </td> <td width="60%">
    ///Password Authentication Protocol </td> </tr> <tr> <td width="40%"><a id="PPP_LCP_SPAP"></a><a
    ///id="ppp_lcp_spap"></a><dl> <dt><b>PPP_LCP_SPAP</b></dt> </dl> </td> <td width="60%"> Shiva Password
    ///Authentication Protocol </td> </tr> <tr> <td width="40%"><a id="PPP_LCP_CHAP"></a><a id="ppp_lcp_chap"></a><dl>
    ///<dt><b>PPP_LCP_CHAP</b></dt> </dl> </td> <td width="60%"> Challenge Handshake Authentication Protocol </td> </tr>
    ///<tr> <td width="40%"><a id="PPP_LCP_EAP"></a><a id="ppp_lcp_eap"></a><dl> <dt><b>PPP_LCP_EAP</b></dt> </dl> </td>
    ///<td width="60%"> Extensible Authentication Protocol </td> </tr> </table>
    uint dwAuthenticationProtocol;
    ///Specifies additional information about the authentication protocol specified by the
    ///<b>dwAuthenticationProtocol</b> member. This member can be one of the following values. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PPP_LCP_CHAP_MD5"></a><a
    ///id="ppp_lcp_chap_md5"></a><dl> <dt><b>PPP_LCP_CHAP_MD5</b></dt> </dl> </td> <td width="60%"> MD5 CHAP </td> </tr>
    ///<tr> <td width="40%"><a id="PPP_LCP_CHAP_MS"></a><a id="ppp_lcp_chap_ms"></a><dl> <dt><b>PPP_LCP_CHAP_MS</b></dt>
    ///</dl> </td> <td width="60%"> Microsoft CHAP </td> </tr> <tr> <td width="40%"><a id="PPP_LCP_CHAP_MSV2"></a><a
    ///id="ppp_lcp_chap_msv2"></a><dl> <dt><b>PPP_LCP_CHAP_MSV2</b></dt> </dl> </td> <td width="60%"> Microsoft CHAP
    ///version 2 </td> </tr> </table>
    uint dwAuthenticationData;
    ///Specifies the authentication protocol used to authenticate the remote computer. See the
    ///<b>dwAuthenticationProtocol</b> member for a list of possible values.
    uint dwRemoteAuthenticationProtocol;
    ///Specifies additional information about the authentication protocol specified by
    ///<b>dwRemoteAuthenticationProtocol</b>. See the <b>dwAuthenticationData</b> member for a list of possible values.
    uint dwRemoteAuthenticationData;
    ///Specifies the reason the connection was terminated by the local computer. This member always has a value of zero.
    uint dwTerminateReason;
    ///Specifies the reason the connection was terminated by the remote computer. This member always has a value of
    ///zero.
    uint dwRemoteTerminateReason;
    ///Specifies information about LCP options in use by the local computer. This member is a combination of the
    ///following flags. <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="PPP_LCP_MULTILINK_FRAMING"></a><a id="ppp_lcp_multilink_framing"></a><dl>
    ///<dt><b>PPP_LCP_MULTILINK_FRAMING</b></dt> </dl> </td> <td width="60%"> The connection is using multilink </td>
    ///</tr> <tr> <td width="40%"><a id="RASLCPO_PFC"></a><a id="raslcpo_pfc"></a><dl> <dt><b>RASLCPO_PFC</b></dt> </dl>
    ///</td> <td width="60%"> Protocol Field Compression (see RFC 1172) </td> </tr> <tr> <td width="40%"><a
    ///id="RASLCPO_ACFC"></a><a id="raslcpo_acfc"></a><dl> <dt><b>RASLCPO_ACFC</b></dt> </dl> </td> <td width="60%">
    ///Address and Control Field Compression (see RFC 1172) </td> </tr> <tr> <td width="40%"><a id="RASLCPO_SSHF"></a><a
    ///id="raslcpo_sshf"></a><dl> <dt><b>RASLCPO_SSHF</b></dt> </dl> </td> <td width="60%"> Short Sequence Number Header
    ///Format (see RFC 1990) </td> </tr> <tr> <td width="40%"><a id="RASLCPO_DES_56"></a><a id="raslcpo_des_56"></a><dl>
    ///<dt><b>RASLCPO_DES_56</b></dt> </dl> </td> <td width="60%"> DES 56-bit encryption </td> </tr> <tr> <td
    ///width="40%"><a id="RASLCPO_3_DES"></a><a id="raslcpo_3_des"></a><dl> <dt><b>RASLCPO_3_DES</b></dt> </dl> </td>
    ///<td width="60%"> Triple DES Encryption </td> </tr> </table>
    uint dwOptions;
    ///Specifies information about LCP options in use by the remote computer. This member is a combination of the
    ///following flags. <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="PPP_LCP_MULTILINK_FRAMING"></a><a id="ppp_lcp_multilink_framing"></a><dl>
    ///<dt><b>PPP_LCP_MULTILINK_FRAMING</b></dt> </dl> </td> <td width="60%"> The connection is using multilink. </td>
    ///</tr> <tr> <td width="40%"><a id="RASLCPO_PFC"></a><a id="raslcpo_pfc"></a><dl> <dt><b>RASLCPO_PFC</b></dt> </dl>
    ///</td> <td width="60%"> Protocol Field Compression (see RFC 1172) </td> </tr> <tr> <td width="40%"><a
    ///id="RASLCPO_ACFC"></a><a id="raslcpo_acfc"></a><dl> <dt><b>RASLCPO_ACFC</b></dt> </dl> </td> <td width="60%">
    ///Address and Control Field Compression (see RFC 1172) </td> </tr> <tr> <td width="40%"><a id="RASLCPO_SSHF"></a><a
    ///id="raslcpo_sshf"></a><dl> <dt><b>RASLCPO_SSHF</b></dt> </dl> </td> <td width="60%"> Short Sequence Number Header
    ///Format (see RFC 1990) </td> </tr> <tr> <td width="40%"><a id="RASLCPO_DES_56"></a><a id="raslcpo_des_56"></a><dl>
    ///<dt><b>RASLCPO_DES_56</b></dt> </dl> </td> <td width="60%"> DES 56-bit encryption </td> </tr> <tr> <td
    ///width="40%"><a id="RASLCPO_3_DES"></a><a id="raslcpo_3_des"></a><dl> <dt><b>RASLCPO_3_DES</b></dt> </dl> </td>
    ///<td width="60%"> Triple DES Encryption </td> </tr> </table>
    uint dwRemoteOptions;
    ///Specifies the type identifier of the Extensible Authentication Protocol (EAP) used to authenticate the local
    ///computer. The value of this member is valid only if <b>dwAuthenticationProtocol</b> is PPP_LCP_EAP.
    uint dwEapTypeId;
    ///Specifies the type identifier of the Extensible Authentication Protocol (EAP) used to authenticate the remote
    ///computer. The value of this member is valid only if <b>dwRemoteAuthenticationProtocol</b> is PPP_LCP_EAP.
    uint dwRemoteEapTypeId;
}

///The <b>PPP_INFO_2</b> structure is used to report the results of the various Point-to-Point (PPP) projection
///operations for a connection.
struct PPP_INFO_2
{
    ///A PPP_NBFCP_INFO structure that contains PPP NetBEUI Framer (NBF) projection information.
    PPP_NBFCP_INFO nbf;
    ///A PPP_IPCP_INFO2 structure that contains PPP Internet Protocol (IP) projection information.
    PPP_IPCP_INFO2 ip;
    ///A PPP_IPXCP_INFO structure that contains PPP Internetwork Packet Exchange (IPX) projection information.
    PPP_IPXCP_INFO ipx;
    ///A PPP_ATCP_INFO structure that contains PPP AppleTalk projection information.
    PPP_ATCP_INFO  at;
    ///A PPP_CCP_INFO structure that contains Compression Control Protocol (CCP) projection information.
    PPP_CCP_INFO   ccp;
    ///A PPP_LCP_INFO structure that contains PPP Link Control Protocol (LCP) projection information.
    PPP_LCP_INFO   lcp;
}

///The <b>PPP_INFO_3</b> structure is used to report the results of the various Point-to-Point (PPP) projection
///operations for a connection.
struct PPP_INFO_3
{
    ///A PPP_NBFCP_INFO structure that contains PPP NetBEUI Framer (NBF) projection information.
    PPP_NBFCP_INFO   nbf;
    ///A PPP_IPCP_INFO2 structure that contains PPP Internet Protocol (IP) projection information.
    PPP_IPCP_INFO2   ip;
    ///A PPP_IPV6_CP_INFO structure that contains IPv6 control protocol projection information.
    PPP_IPV6_CP_INFO ipv6;
    ///A PPP_CCP_INFO structure that contains Compression Control Protocol (CCP) projection information.
    PPP_CCP_INFO     ccp;
    ///A PPP_LCP_INFO structure that contains PPP Link Control Protocol (LCP) projection information.
    PPP_LCP_INFO     lcp;
}

///The <b>RAS_CONNECTION_0</b> structure contains general information regarding a specific connection, such as user name
///or domain. For more detailed information about a specific connection, such as bytes sent or received, see
///RAS_CONNECTION_1.
struct RAS_CONNECTION_0
{
    ///A handle to the connection.
    HANDLE      hConnection;
    ///A handle to the interface.
    HANDLE      hInterface;
    ///A value that represent the duration of the connection, in seconds.
    uint        dwConnectDuration;
    ///A ROUTER_INTERFACE_TYPE enumeration that identifies the type of connection interface.
    ROUTER_INTERFACE_TYPE dwInterfaceType;
    ///A bitmap of flags that specify connection attributes. <b>dwConnectionFlags</b> must contain at least one of the
    ///following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="RAS_FLAGS_PPP_CONNECTION"></a><a id="ras_flags_ppp_connection"></a><dl>
    ///<dt><b>RAS_FLAGS_PPP_CONNECTION</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> The connection is using
    ///Point-to-Point Protocol (PPP). </td> </tr> <tr> <td width="40%"><a id="RAS_FLAGS_MESSENGER_PRESENT"></a><a
    ///id="ras_flags_messenger_present"></a><dl> <dt><b>RAS_FLAGS_MESSENGER_PRESENT</b></dt> <dt>0x00000002</dt> </dl>
    ///</td> <td width="60%"> The messenger service is active on the client and messages can be sent to the client using
    ///MprAdminSendUserMessage. </td> </tr> <tr> <td width="40%"><a id="RAS_FLAGS_QUARANTINE_PRESENT"></a><a
    ///id="ras_flags_quarantine_present"></a><dl> <dt><b>RAS_FLAGS_QUARANTINE_PRESENT</b></dt> <dt>0x00000008</dt> </dl>
    ///</td> <td width="60%"> The connection is currently in quarantine. For information on how to remove the connection
    ///from quarantine, please see MprAdminConnectionRemoveQuarantine. </td> </tr> <tr> <td width="40%"><a
    ///id="RAS_FLAGS_ARAP_CONNECTION"></a><a id="ras_flags_arap_connection"></a><dl>
    ///<dt><b>RAS_FLAGS_ARAP_CONNECTION</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> The connection is
    ///using AppleTalk Remote Access Protocol (ARAP). </td> </tr> <tr> <td width="40%"><a
    ///id="RAS_FLAGS_IKEV2_CONNECTION"></a><a id="ras_flags_ikev2_connection"></a><dl>
    ///<dt><b>RAS_FLAGS_IKEV2_CONNECTION</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> The connection is
    ///using IKEv2. </td> </tr> <tr> <td width="40%"><a id="RAS_FLAGS_DORMANT"></a><a id="ras_flags_dormant"></a><dl>
    ///<dt><b>RAS_FLAGS_DORMANT</b></dt> <dt>0x00000020</dt> </dl> </td> <td width="60%"> The connection is using IKEv2
    ///and the server is not reachable. </td> </tr> </table>
    uint        dwConnectionFlags;
    ///A null-terminated Unicode string that contains the name of the interface for this connection.
    ushort[257] wszInterfaceName;
    ///A null-terminated Unicode string that contains the name of the user logged on to the connection.
    ushort[257] wszUserName;
    ///A null-terminated Unicode string that contains the domain on which the connected user is authenticated.
    ushort[16]  wszLogonDomain;
    ///A null-terminated Unicode string that contains the name of the remote computer.
    ushort[17]  wszRemoteComputer;
}

///The <b>RAS_CONNECTION_1</b> structure contains detailed information regarding a specific connection, such as error
///counts and bytes received. For more general information about a specific connection, such as user name or domain, see
///RAS_CONNECTION_0.
struct RAS_CONNECTION_1
{
    ///A handle to the connection.
    HANDLE   hConnection;
    ///A handle to the interface.
    HANDLE   hInterface;
    ///A PPP_INFO structure that contains Point-to-Point (PPP) projection operation information for a connection.
    PPP_INFO PppInfo;
    ///A value that specifies the number of bytes transmitted on the connection.
    uint     dwBytesXmited;
    ///A value that specifies the number of bytes received on the connection.
    uint     dwBytesRcved;
    ///A value that specifies the number of frames transmitted on the connection.
    uint     dwFramesXmited;
    ///A value that specifies the number of frames received on the connection.
    uint     dwFramesRcved;
    ///A value that specifies the number of Cyclic Redundancy Check (CRC) errors on the connection.
    uint     dwCrcErr;
    ///A value that specifies the number of time-out errors on the connection.
    uint     dwTimeoutErr;
    ///A value that specifies the number of alignment errors on the connection.
    uint     dwAlignmentErr;
    ///A value that specifies the number of hardware overrun errors on the connection.
    uint     dwHardwareOverrunErr;
    ///A value that specifies the number of framing errors on the connection.
    uint     dwFramingErr;
    ///A value that specifies the number of buffer overrun errors on the connection.
    uint     dwBufferOverrunErr;
    ///A value that specifies the percentage by which data received on this connection is compressed.
    ///<b>dwCompressionRatioIn</b> is the size of the compressed data divided by the size of the same data in an
    ///uncompressed state.
    uint     dwCompressionRatioIn;
    ///A value that specifies the percentage by which data transmitted on this connection is compressed. The ratio is
    ///the size of the compressed data divided by the size of the same data in an uncompressed state.
    uint     dwCompressionRatioOut;
}

///The <b>RAS_CONNECTION_2</b> structure contains information for a connection, including the Globally Unique Identifier
///(GUID) that identifies the connection.
struct RAS_CONNECTION_2
{
    ///A handle to the connection.
    HANDLE      hConnection;
    ///A null-terminated Unicode string that contains the name of the user logged on to the connection.
    ushort[257] wszUserName;
    ///A ROUTER_INTERFACE_TYPE enumeration that identifies the type of connection interface.
    ROUTER_INTERFACE_TYPE dwInterfaceType;
    ///A GUID that identifies the connection. For incoming connections, this GUID is valid only as long as the
    ///connection is active.
    GUID        guid;
    ///A PPP_INFO_2 structure that contains Point-to-Point (PPP) projection operation information for a connection.
    PPP_INFO_2  PppInfo2;
}

///The <b>RAS_CONNECTION_3</b> structure contains information for the connection, including the Globally Unique
///Identifier (GUID) that identifies the connection and the quarantine state of the connection.
struct RAS_CONNECTION_3
{
    ///The version of the <b>RAS_CONNECTION_3</b> structure used.
    uint                 dwVersion;
    ///The size, in bytes, of this <b>RAS_CONNECTION_3</b> structure.
    uint                 dwSize;
    ///A handle to the connection.
    HANDLE               hConnection;
    ///A null-terminated Unicode string that contains the name of the user logged on to the connection.
    ushort[257]          wszUserName;
    ///A ROUTER_INTERFACE_TYPE enumeration that identifies the type of connection interface.
    ROUTER_INTERFACE_TYPE dwInterfaceType;
    ///A GUID that identifies the connection. For incoming connections, this GUID is valid only as long as the
    ///connection is active.
    GUID                 guid;
    ///A PPP_INFO_3 structure that contains Point-to-Point (PPP) projection operation information for a connection.
    PPP_INFO_3           PppInfo3;
    ///A RAS_QUARANTINE_STATE structure that specifies the Network Access Protection (NAP) quarantine state of the
    ///connection.
    RAS_QUARANTINE_STATE rasQuarState;
    ///A FILETIME structure that specifies the time required for the connection to come out of quarantine after which
    ///the connection will be dropped. This value is valid only if <b>rasQuarState</b> has a value of
    ///<b>RAS_QUAR_STATE_PROBATION</b>.
    FILETIME             timer;
}

///The <b>RAS_USER_0</b> structure contains information for a particular Remote Access Service user.
struct RAS_USER_0
{
    ///Specifies the types of remote access privilege available to the RAS user. The following remote access privilege
    ///constants are defined in Mprapi.h. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="RASPRIV_DialinPrivilege"></a><a id="raspriv_dialinprivilege"></a><a id="RASPRIV_DIALINPRIVILEGE"></a><dl>
    ///<dt><b>RASPRIV_DialinPrivilege</b></dt> </dl> </td> <td width="60%"> The user has permission to dial in to the
    ///RAS server. </td> </tr> <tr> <td width="40%"><a id="RASPRIV_NoCallback"></a><a id="raspriv_nocallback"></a><a
    ///id="RASPRIV_NOCALLBACK"></a><dl> <dt><b>RASPRIV_NoCallback</b></dt> </dl> </td> <td width="60%"> The RAS server
    ///will not call back the user to establish a connection. </td> </tr> <tr> <td width="40%"><a
    ///id="RASPRIV_AdminSetCallback"></a><a id="raspriv_adminsetcallback"></a><a id="RASPRIV_ADMINSETCALLBACK"></a><dl>
    ///<dt><b>RASPRIV_AdminSetCallback</b></dt> </dl> </td> <td width="60%"> When the user calls, the RAS server hangs
    ///up and calls a preset call-back phone number stored in the user account database. The <b>wszPhoneNumber</b>
    ///member of the <b>RAS_USER_0</b> structure contains the user's call-back phone number. </td> </tr> <tr> <td
    ///width="40%"><a id="RASPRIV_CallerSetCallback"></a><a id="raspriv_callersetcallback"></a><a
    ///id="RASPRIV_CALLERSETCALLBACK"></a><dl> <dt><b>RASPRIV_CallerSetCallback</b></dt> </dl> </td> <td width="60%">
    ///When the user calls, the RAS server provides the option of specifying a call-back phone number. The user can also
    ///choose to connect immediately without a call back. The <b>wszPhoneNumber</b> member contains a default number
    ///that the user can override. </td> </tr> </table> <div> </div> Use the following constant as a mask to isolate the
    ///call-back privilege. (This constant is also defined in Mprapi.h.) RASPRIV_CallbackType
    ubyte       bfPrivilege;
    ///Pointer to a Unicode string containing the phone number at which the RAS user should be called back.
    ushort[129] wszPhoneNumber;
}

///The <b>RAS_USER_1</b> structure contains information for a particular Remote Access Service user. The
///<b>RAS_USER_1</b> structure is similar to the RAS_USER_0 structure, except that <b>RAS_USER_1</b> supports an
///additional member, <b>bfPrivilege2</b>.
struct RAS_USER_1
{
    ///Specifies the types of remote access privilege available to the RAS user. The following remote access privilege
    ///constants are defined in Mprapi.h. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="RASPRIV_DialinPrivilege"></a><a id="raspriv_dialinprivilege"></a><a id="RASPRIV_DIALINPRIVILEGE"></a><dl>
    ///<dt><b>RASPRIV_DialinPrivilege</b></dt> </dl> </td> <td width="60%"> The user has permission to dial in to the
    ///RAS server. </td> </tr> <tr> <td width="40%"><a id="RASPRIV_NoCallback"></a><a id="raspriv_nocallback"></a><a
    ///id="RASPRIV_NOCALLBACK"></a><dl> <dt><b>RASPRIV_NoCallback</b></dt> </dl> </td> <td width="60%"> The RAS server
    ///will not call back the user to establish a connection. </td> </tr> <tr> <td width="40%"><a
    ///id="RASPRIV_AdminSetCallback"></a><a id="raspriv_adminsetcallback"></a><a id="RASPRIV_ADMINSETCALLBACK"></a><dl>
    ///<dt><b>RASPRIV_AdminSetCallback</b></dt> </dl> </td> <td width="60%"> When the user calls, the RAS server hangs
    ///up and calls a preset call-back phone number stored in the user account database. The <b>wszPhoneNumber</b>
    ///member of the RAS_USER_0 structure contains the user's call-back phone number. </td> </tr> <tr> <td
    ///width="40%"><a id="RASPRIV_CallerSetCallback"></a><a id="raspriv_callersetcallback"></a><a
    ///id="RASPRIV_CALLERSETCALLBACK"></a><dl> <dt><b>RASPRIV_CallerSetCallback</b></dt> </dl> </td> <td width="60%">
    ///When the user calls, the RAS server provides the option of specifying a call-back phone number. The user can also
    ///choose to connect immediately without a call back. The <b>wszPhoneNumber</b> member contains a default number
    ///that the user can override. </td> </tr> </table> <div> </div> Use the following constant as a mask to isolate the
    ///call back privilege. (This constant is also defined in Mprapi.h.) RASPRIV_CallbackType
    ubyte       bfPrivilege;
    ///Pointer to a Unicode string containing the phone number at which the RAS user should be called back.
    ushort[129] wszPhoneNumber;
    ///Specifies flags that grant additional remote access privileges to the RAS user. The following remote access
    ///privilege constants are defined in Mprapi.h. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="RASPRIV2_DialinPolicy"></a><a id="raspriv2_dialinpolicy"></a><a
    ///id="RASPRIV2_DIALINPOLICY"></a><dl> <dt><b>RASPRIV2_DialinPolicy</b></dt> </dl> </td> <td width="60%"> Remote
    ///access policies determine whether the user is allowed dial-in access. </td> </tr> </table>
    ubyte       bfPrivilege2;
}

///The <b>MPR_FILTER_0</b> structure contains static filter configuration information.
struct MPR_FILTER_0
{
    ///A <b>BOOL</b> that specifies the state of the static filters. Set to <b>TRUE</b> if static filters are enabled
    ///and <b>FALSE</b> otherwise.
    BOOL fEnable;
}

///The [RAS_UPDATE_CONNECTION](/windows/desktop/api/mprapi/ns-mprapi-ras_update_connection), AUTH_VALIDATION_EX
///structures, and the structure version used by the MprAdminConnectionEnumEx method.
struct MPRAPI_OBJECT_HEADER
{
    ///A value that represents the version of the structure specified by <b>type</b>. Possible values are: <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MPRAPI_RAS_CONNECTION_OBJECT_REVISION_1"></a><a
    ///id="mprapi_ras_connection_object_revision_1"></a><dl> <dt><b>MPRAPI_RAS_CONNECTION_OBJECT_REVISION_1</b></dt>
    ///<dt>0x01</dt> </dl> </td> <td width="60%"> Represents version 1 of the RAS_CONNECTION_EX structure if <b>type</b>
    ///is <b>MPRAPI_OBJECT_TYPE_RAS_CONNECTION_OBJECT</b>. </td> </tr> <tr> <td width="40%"><a
    ///id="MPRAPI_MPR_SERVER_OBJECT_REVISION_1"></a><a id="mprapi_mpr_server_object_revision_1"></a><dl>
    ///<dt><b>MPRAPI_MPR_SERVER_OBJECT_REVISION_1</b></dt> <dt>0x01</dt> </dl> </td> <td width="60%"> Represents version
    ///1 of the MPR_SERVER_EX structure if <b>type</b> is <b>MPRAPI_OBJECT_TYPE_MPR_SERVER_OBJECT</b>. </td> </tr> <tr>
    ///<td width="40%"><a id="MPRAPI_MPR_SERVER_SET_CONFIG_OBJECT_REVISION_1"></a><a
    ///id="mprapi_mpr_server_set_config_object_revision_1"></a><dl>
    ///<dt><b>MPRAPI_MPR_SERVER_SET_CONFIG_OBJECT_REVISION_1</b></dt> <dt>0x01</dt> </dl> </td> <td width="60%">
    ///Represents version 1 of the MPR_SERVER_SET_CONFIG_EX structure if <b>type</b> is
    ///<b>MPRAPI_OBJECT_TYPE_MPR_SERVER_SET_CONFIG_OBJECT</b>. </td> </tr> </table>
    ubyte  revision;
    ubyte  type;
    ushort size;
}

///The <b>PPP_PROJECTION_INFO</b> structure contains information obtained during Point-to-Point (PPP) negotiation for
///Secure Socket Tunneling Protocol (SSTP), Point-to-Point Tunneling Protocol (PPTP), and Layer 2 Tunneling Protocol
///(L2TP).
struct PPP_PROJECTION_INFO
{
    ///A value that specifies the result of PPP IPv4 Network control protocol negotiation. A value of zero indicates
    ///Ipv4 has been negotiated successfully. A nonzero value indicates failure, and is the fatal error that occurred
    ///during the control protocol negotiation.
    uint       dwIPv4NegotiationError;
    ///An array that contains a Unicode string that specifies the IPv4 address of the local client. This string has the
    ///form "a.b.c.d". <b>wszAddress</b> is valid only if <b>dwIPv4NegotiationError</b> is zero.
    ushort[16] wszAddress;
    ///An array that contains a Unicode string that specifies the IPv4 address of the remote server. This string has the
    ///form "a.b.c.d". <b>wszRemoteAddress</b> is valid only if <b>dwIPv4NegotiationError</b> is zero. If the address is
    ///not available, this member is an empty string.
    ushort[16] wszRemoteAddress;
    ///A value that specifies IPCP options for the local client. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td width="40%"><a id="PPP_IPCP_VJ"></a><a id="ppp_ipcp_vj"></a><dl> <dt><b>PPP_IPCP_VJ</b></dt> </dl> </td> <td
    ///width="60%"> Indicates that IP datagrams sent by the local client are compressed using Van Jacobson compression.
    ///</td> </tr> </table>
    uint       dwIPv4Options;
    ///A value that specifies IPCP options for the remote server. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="PPP_IPCP_VJ"></a><a id="ppp_ipcp_vj"></a><dl> <dt><b>PPP_IPCP_VJ</b></dt> </dl> </td>
    ///<td width="60%"> Indicates that IP datagrams sent by the remote server (that is, received by the local computer)
    ///are compressed using Van Jacobson compression. </td> </tr> </table>
    uint       dwIPv4RemoteOptions;
    ///A value that specifies the IPv4 subinterface index corresponding to the connection on the server.
    ulong      IPv4SubInterfaceIndex;
    ///A value that specifies the result of PPP IPv6 Network control protocol negotiation. A value of zero indicates
    ///Ipv6 has been negotiated successfully. A nonzero value indicates failure, and is the fatal error that occurred
    ///during the control protocol negotiation.
    uint       dwIPv6NegotiationError;
    ///An array that specifies the 64-bit IPv6 interface identifier of the client. The last 64 bits of a 128-bit IPv6
    ///internet address are considered the "interface identifier," which provides a strong level of uniqueness for the
    ///preceding 64-bits. <b>bInterfaceIdentifier</b> is valid only if <b>dwIPv6NegotiationError</b> is zero and must
    ///not be zero.
    ubyte[8]   bInterfaceIdentifier;
    ///An array that specifies the 64-bit IPv6 interface identifier of the server. The last 64 bits of a 128-bit IPv6
    ///internet address are considered the "interface identifier," which provides a strong level of uniqueness for the
    ///preceding 64-bits. <b>bInterfaceIdentifier</b> is valid only if <b>dwIPv6NegotiationError</b> is zero and must
    ///not be zero.
    ubyte[8]   bRemoteInterfaceIdentifier;
    ///A value that specifies the client interface IPv6 address prefix.
    ubyte[8]   bPrefix;
    ///A value that specifies the length, in bits, of <b>bPrefix</b>.
    uint       dwPrefixLength;
    ///A value that specifies the IPv6 subinterface index corresponding to the connection on the server.
    ulong      IPv6SubInterfaceIndex;
    ///A value that specifies the result of PPP LCP negotiation. A value of zero indicates LCP has been negotiated
    ///successfully. A nonzero value indicates failure, and is the fatal error that occurred during the control protocol
    ///negotiation.
    uint       dwLcpError;
    ///A value that specifies the authentication protocol used to authenticate the local client. This member can be one
    ///of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="PPP_LCP_PAP"></a><a id="ppp_lcp_pap"></a><dl> <dt><b>PPP_LCP_PAP</b></dt> </dl> </td> <td width="60%">
    ///Password Authentication Protocol. </td> </tr> <tr> <td width="40%"><a id="PPP_LCP_CHAP"></a><a
    ///id="ppp_lcp_chap"></a><dl> <dt><b>PPP_LCP_CHAP</b></dt> </dl> </td> <td width="60%"> Challenge Handshake
    ///Authentication Protocol. </td> </tr> <tr> <td width="40%"><a id="PPP_LCP_EAP"></a><a id="ppp_lcp_eap"></a><dl>
    ///<dt><b>PPP_LCP_EAP</b></dt> </dl> </td> <td width="60%"> Extensible Authentication Protocol. </td> </tr> </table>
    uint       dwAuthenticationProtocol;
    ///A value that specifies additional information about the authentication protocol specified by
    ///<b>dwAuthenticationProtocol</b>. This member can be one of the following values: <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="PPP_LCP_CHAP_MD5"></a><a id="ppp_lcp_chap_md5"></a><dl>
    ///<dt><b>PPP_LCP_CHAP_MD5</b></dt> </dl> </td> <td width="60%"> MD5 CHAP </td> </tr> <tr> <td width="40%"><a
    ///id="PPP_LCP_CHAP_MS"></a><a id="ppp_lcp_chap_ms"></a><dl> <dt><b>PPP_LCP_CHAP_MS</b></dt> </dl> </td> <td
    ///width="60%"> Microsoft CHAP. </td> </tr> <tr> <td width="40%"><a id="PPP_LCP_CHAP_MSV2"></a><a
    ///id="ppp_lcp_chap_msv2"></a><dl> <dt><b>PPP_LCP_CHAP_MSV2</b></dt> </dl> </td> <td width="60%"> Microsoft CHAP
    ///version 2. </td> </tr> </table>
    uint       dwAuthenticationData;
    ///A value that specifies the authentication protocol used to authenticate the remote server.
    ///<b>dwAuthenticationProtocol</b> and <b>dwRemoteAuthenticationProtocol</b> will differ when demand dial uses
    ///different authentication protocols on the client and server. This member can be one of the following values:
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PPP_LCP_PAP"></a><a
    ///id="ppp_lcp_pap"></a><dl> <dt><b>PPP_LCP_PAP</b></dt> </dl> </td> <td width="60%"> Password Authentication
    ///Protocol. </td> </tr> <tr> <td width="40%"><a id="PPP_LCP_CHAP"></a><a id="ppp_lcp_chap"></a><dl>
    ///<dt><b>PPP_LCP_CHAP</b></dt> </dl> </td> <td width="60%"> Challenge Handshake Authentication Protocol. </td>
    ///</tr> <tr> <td width="40%"><a id="PPP_LCP_EAP"></a><a id="ppp_lcp_eap"></a><dl> <dt><b>PPP_LCP_EAP</b></dt> </dl>
    ///</td> <td width="60%"> Extensible Authentication Protocol. </td> </tr> </table>
    uint       dwRemoteAuthenticationProtocol;
    ///A value that specifies additional information about the authentication protocol specified by
    ///<b>dwRemoteAuthenticationProtocol</b>. <b>dwAuthenticationData</b> and <b>dwRemoteAuthenticationData</b> will
    ///differ when demand dial uses different authentication protocols on the client and server. This member can be one
    ///of the following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="PPP_LCP_CHAP_MD5"></a><a id="ppp_lcp_chap_md5"></a><dl> <dt><b>PPP_LCP_CHAP_MD5</b></dt> </dl> </td> <td
    ///width="60%"> MD5 CHAP. </td> </tr> <tr> <td width="40%"><a id="PPP_LCP_CHAP_MS"></a><a
    ///id="ppp_lcp_chap_ms"></a><dl> <dt><b>PPP_LCP_CHAP_MS</b></dt> </dl> </td> <td width="60%"> Microsoft CHAP. </td>
    ///</tr> <tr> <td width="40%"><a id="PPP_LCP_CHAP_MSV2"></a><a id="ppp_lcp_chap_msv2"></a><dl>
    ///<dt><b>PPP_LCP_CHAP_MSV2</b></dt> </dl> </td> <td width="60%"> Microsoft CHAP version 2. </td> </tr> </table>
    uint       dwRemoteAuthenticationData;
    ///Reserved for future use. Must be zero.
    uint       dwLcpTerminateReason;
    ///Reserved for future use. Must be zero.
    uint       dwLcpRemoteTerminateReason;
    ///A value that specifies information about LCP options in use by the local client. This member is a combination of
    ///the following flags: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="PPP_LCP_MULTILINK_FRAMING"></a><a id="ppp_lcp_multilink_framing"></a><dl>
    ///<dt><b>PPP_LCP_MULTILINK_FRAMING</b></dt> </dl> </td> <td width="60%"> The connection is using multilink. </td>
    ///</tr> <tr> <td width="40%"><a id="PPP_LCP_PFC"></a><a id="ppp_lcp_pfc"></a><dl> <dt><b>PPP_LCP_PFC</b></dt> </dl>
    ///</td> <td width="60%"> The connection is using Protocol Field Compression (RFC 1172). </td> </tr> <tr> <td
    ///width="40%"><a id="PPP_LCP_ACFC_"></a><a id="ppp_lcp_acfc_"></a><dl> <dt><b>PPP_LCP_ACFC </b></dt> </dl> </td>
    ///<td width="60%"> The connection is using Address and Control Field Compression (RFC 1172). </td> </tr> <tr> <td
    ///width="40%"><a id="PPP_LCP_SSHF"></a><a id="ppp_lcp_sshf"></a><dl> <dt><b>PPP_LCP_SSHF</b></dt> </dl> </td> <td
    ///width="60%"> The connection is using Short Sequence Number Header Format (see RFC 1990). </td> </tr> <tr> <td
    ///width="40%"><a id="PPP_LCP_DES_56"></a><a id="ppp_lcp_des_56"></a><dl> <dt><b>PPP_LCP_DES_56</b></dt> </dl> </td>
    ///<td width="60%"> The connection is using DES 56-bit encryption. </td> </tr> <tr> <td width="40%"><a
    ///id="PPP_LCP_3_DES"></a><a id="ppp_lcp_3_des"></a><dl> <dt><b>PPP_LCP_3_DES</b></dt> </dl> </td> <td width="60%">
    ///The connection is using Triple DES Encryption. </td> </tr> <tr> <td width="40%"><a id="PPP_LCP_AES_128"></a><a
    ///id="ppp_lcp_aes_128"></a><dl> <dt><b>PPP_LCP_AES_128</b></dt> </dl> </td> <td width="60%"> The connection is
    ///using 128-bit AES Encryption. </td> </tr> <tr> <td width="40%"><a id="PPP_LCP_AES_256"></a><a
    ///id="ppp_lcp_aes_256"></a><dl> <dt><b>PPP_LCP_AES_256</b></dt> </dl> </td> <td width="60%"> The connection is
    ///using 256-bit AES Encryption. </td> </tr> </table>
    uint       dwLcpOptions;
    ///A value that specifies information about LCP options in use by the remote server. This member is a combination of
    ///the following flags: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="PPP_LCP_MULTILINK_FRAMING"></a><a id="ppp_lcp_multilink_framing"></a><dl>
    ///<dt><b>PPP_LCP_MULTILINK_FRAMING</b></dt> </dl> </td> <td width="60%"> The connection is using multilink. </td>
    ///</tr> <tr> <td width="40%"><a id="PPP_LCP_PFC"></a><a id="ppp_lcp_pfc"></a><dl> <dt><b>PPP_LCP_PFC</b></dt> </dl>
    ///</td> <td width="60%"> The connection is using Protocol Field Compression (RFC 1172). </td> </tr> <tr> <td
    ///width="40%"><a id="PPP_LCP_ACFC_"></a><a id="ppp_lcp_acfc_"></a><dl> <dt><b>PPP_LCP_ACFC </b></dt> </dl> </td>
    ///<td width="60%"> The connection is using Address and Control Field Compression (RFC 1172). </td> </tr> <tr> <td
    ///width="40%"><a id="PPP_LCP_SSHF"></a><a id="ppp_lcp_sshf"></a><dl> <dt><b>PPP_LCP_SSHF</b></dt> </dl> </td> <td
    ///width="60%"> The connection is using Short Sequence Number Header Format (see RFC 1990). </td> </tr> <tr> <td
    ///width="40%"><a id="PPP_LCP_DES_56"></a><a id="ppp_lcp_des_56"></a><dl> <dt><b>PPP_LCP_DES_56</b></dt> </dl> </td>
    ///<td width="60%"> The connection is using DES 56-bit encryption. </td> </tr> <tr> <td width="40%"><a
    ///id="PPP_LCP_3_DES"></a><a id="ppp_lcp_3_des"></a><dl> <dt><b>PPP_LCP_3_DES</b></dt> </dl> </td> <td width="60%">
    ///The connection is using Triple DES Encryption. </td> </tr> <tr> <td width="40%"><a id="PPP_LCP_AES_128"></a><a
    ///id="ppp_lcp_aes_128"></a><dl> <dt><b>PPP_LCP_AES_128</b></dt> </dl> </td> <td width="60%"> The connection is
    ///using 128-bit AES Encryption </td> </tr> <tr> <td width="40%"><a id="PPP_LCP_AES_256"></a><a
    ///id="ppp_lcp_aes_256"></a><dl> <dt><b>PPP_LCP_AES_256</b></dt> </dl> </td> <td width="60%"> The connection is
    ///using 256-bit AES Encryption. </td> </tr> </table>
    uint       dwLcpRemoteOptions;
    ///A value that specifies the type identifier of the Extensible Authentication Protocol (EAP) used to authenticate
    ///the local client. The value of this member is valid only if <b>dwAuthenticationProtocol</b> is
    ///<b>PPP_LCP_EAP</b>.
    uint       dwEapTypeId;
    ///A value that specifies the type identifier of the Extensible Authentication Protocol (EAP) used to authenticate
    ///the remote server. The value of this member is valid only if <b>dwRemoteAuthenticationProtocol</b> is
    ///<b>PPP_LCP_EAP</b>.
    uint       dwRemoteEapTypeId;
    ///A value that specifies the result of PPP CCP negotiation. A value of zero indicates CCP has been negotiated
    ///successfully. A nonzero value indicates failure, and is the fatal error that occurred during the control protocol
    ///negotiation.
    uint       dwCcpError;
    ///A value that specifies the compression algorithm used by the local client. The following table shows the possible
    ///values for this member. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="RASCCPCA_MPPC"></a><a id="rasccpca_mppc"></a><dl> <dt><b>RASCCPCA_MPPC</b></dt> </dl> </td> <td width="60%">
    ///Microsoft Point-to-Point Compression (MPPC) Protocol (RFC 2118). </td> </tr> <tr> <td width="40%"><a
    ///id="RASCCPCA_STAC"></a><a id="rasccpca_stac"></a><dl> <dt><b>RASCCPCA_STAC</b></dt> </dl> </td> <td width="60%">
    ///STAC option 4 (RFC 1974). </td> </tr> </table>
    uint       dwCompressionAlgorithm;
    ///A value that specifies the compression types available on the local client. The following types are supported:
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PPP_CCP_COMPRESSION"></a><a
    ///id="ppp_ccp_compression"></a><dl> <dt><b>PPP_CCP_COMPRESSION</b></dt> </dl> </td> <td width="60%"> Compression
    ///without encryption. </td> </tr> <tr> <td width="40%"><a id="PPP_CCP_HISTORYLESS"></a><a
    ///id="ppp_ccp_historyless"></a><dl> <dt><b>PPP_CCP_HISTORYLESS</b></dt> </dl> </td> <td width="60%"> Microsoft
    ///Point-to-Point Encryption (MPPE) in stateless mode. The session key is changed after every packet. This mode
    ///improves performance on high latency networks, or networks that experience significant packet loss. </td> </tr>
    ///<tr> <td width="40%"><a id="PPP_CCP_ENCRYPTION40BITOLD"></a><a id="ppp_ccp_encryption40bitold"></a><dl>
    ///<dt><b>PPP_CCP_ENCRYPTION40BITOLD</b></dt> </dl> </td> <td width="60%"> MPPE compression using 40-bit keys. </td>
    ///</tr> <tr> <td width="40%"><a id="PPP_CCP_ENCRYPTION40BIT"></a><a id="ppp_ccp_encryption40bit"></a><dl>
    ///<dt><b>PPP_CCP_ENCRYPTION40BIT</b></dt> </dl> </td> <td width="60%"> MPPE compression using 40-bit keys. </td>
    ///</tr> <tr> <td width="40%"><a id="PPP_CCP_ENCRYPTION56BIT"></a><a id="ppp_ccp_encryption56bit"></a><dl>
    ///<dt><b>PPP_CCP_ENCRYPTION56BIT</b></dt> </dl> </td> <td width="60%"> MPPE compression using 56-bit keys. </td>
    ///</tr> <tr> <td width="40%"><a id="PPP_CCP_ENCRYPTION128BIT"></a><a id="ppp_ccp_encryption128bit"></a><dl>
    ///<dt><b>PPP_CCP_ENCRYPTION128BIT</b></dt> </dl> </td> <td width="60%"> MPPE compression using 128-bit keys. </td>
    ///</tr> </table> The last three options are used when a connection is made over Layer 2 Tunneling Protocol (L2TP),
    ///and the connection uses IPSec encryption.
    uint       dwCcpOptions;
    ///A value that specifies the compression algorithm used by the remote server. The following algorithms are
    ///supported: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RASCCPCA_MPPC"></a><a
    ///id="rasccpca_mppc"></a><dl> <dt><b>RASCCPCA_MPPC</b></dt> </dl> </td> <td width="60%"> Microsoft Point-to-Point
    ///Compression (MPPC) Protocol ( RFC 2118). </td> </tr> <tr> <td width="40%"><a id="RASCCPCA_STAC"></a><a
    ///id="rasccpca_stac"></a><dl> <dt><b>RASCCPCA_STAC</b></dt> </dl> </td> <td width="60%"> STAC option 4 ( RFC 1974).
    ///</td> </tr> </table>
    uint       dwRemoteCompressionAlgorithm;
    ///A value that specifies the compression types available on the remote server. The following types are supported:
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PPP_CCP_COMPRESSION"></a><a
    ///id="ppp_ccp_compression"></a><dl> <dt><b>PPP_CCP_COMPRESSION</b></dt> </dl> </td> <td width="60%"> Compression
    ///without encryption. </td> </tr> <tr> <td width="40%"><a id="PPP_CCP_HISTORYLESS"></a><a
    ///id="ppp_ccp_historyless"></a><dl> <dt><b>PPP_CCP_HISTORYLESS</b></dt> </dl> </td> <td width="60%"> Microsoft
    ///Point-to-Point Encryption (MPPE) in stateless mode. The session key is changed after every packet. This mode
    ///improves performance on high latency networks, or networks that experience significant packet loss. </td> </tr>
    ///<tr> <td width="40%"><a id="PPP_CCP_ENCRYPTION40BITOLD"></a><a id="ppp_ccp_encryption40bitold"></a><dl>
    ///<dt><b>PPP_CCP_ENCRYPTION40BITOLD</b></dt> </dl> </td> <td width="60%"> MPPE compression using 40-bit keys. </td>
    ///</tr> <tr> <td width="40%"><a id="PPP_CCP_ENCRYPTION40BIT"></a><a id="ppp_ccp_encryption40bit"></a><dl>
    ///<dt><b>PPP_CCP_ENCRYPTION40BIT</b></dt> </dl> </td> <td width="60%"> MPPE compression using 40-bit keys. </td>
    ///</tr> <tr> <td width="40%"><a id="PPP_CCP_ENCRYPTION56BIT"></a><a id="ppp_ccp_encryption56bit"></a><dl>
    ///<dt><b>PPP_CCP_ENCRYPTION56BIT</b></dt> </dl> </td> <td width="60%"> MPPE compression using 56-bit keys. </td>
    ///</tr> <tr> <td width="40%"><a id="PPP_CCP_ENCRYPTION128BIT"></a><a id="ppp_ccp_encryption128bit"></a><dl>
    ///<dt><b>PPP_CCP_ENCRYPTION128BIT</b></dt> </dl> </td> <td width="60%"> MPPE compression using 128-bit keys. </td>
    ///</tr> <tr> <td width="40%"><a id="ERROR_PPP_NOT_CONVERGING"></a><a id="error_ppp_not_converging"></a><dl>
    ///<dt><b>ERROR_PPP_NOT_CONVERGING</b></dt> </dl> </td> <td width="60%"> The remote computer and RRAS could not
    ///converge on address negotiation. </td> </tr> </table> The last three options are used when a connection is made
    ///over Layer 2 Tunneling Protocol (L2TP), and the connection uses IPSec encryption.
    uint       dwCcpRemoteOptions;
}

///Contains information obtained during Point-to-Point (PPP) negotiation for Secure Socket Tunneling Protocol (SSTP),
///Point-to-Point Tunneling Protocol (PPTP), and Layer 2 Tunneling Protocol (L2TP).
struct PPP_PROJECTION_INFO2
{
    ///A value that specifies the result of PPP IPv4 Network control protocol negotiation. A value of 0 indicates IPv4
    ///has been negotiated successfully. A nonzero value indicates failure, and also represents the fatal error that
    ///occurred during the control protocol negotiation.
    uint       dwIPv4NegotiationError;
    ///A null-terminated Unicode string that specifies the IPv4 address of the local client. This string has the form
    ///"a.b.c.d". The <b>wszAddress</b> member is valid only if dwIPv4NegotiationError is 0.
    ushort[16] wszAddress;
    ///An array that contains a Unicode string that specifies the IPv4 address of the remote server. This string has the
    ///form "a.b.c.d". The <b>wszRemoteAddress</b> member is valid only if the <b>dwIPv4NegotiationError</b> member is
    ///zero. If the address is not available, this member is an empty string.
    ushort[16] wszRemoteAddress;
    ///A value that specifies IPCP options for the local client. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td width="40%"><a id="PPP_IPCP_VJ"></a><a id="ppp_ipcp_vj"></a><dl> <dt><b>PPP_IPCP_VJ</b></dt> </dl> </td> <td
    ///width="60%"> Indicates that IP datagrams sent by the local client are compressed using Van Jacobson compression.
    ///</td> </tr> </table>
    uint       dwIPv4Options;
    ///A value that specifies IPCP options for the remote server. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="PPP_IPCP_VJ"></a><a id="ppp_ipcp_vj"></a><dl> <dt><b>PPP_IPCP_VJ</b></dt> </dl> </td>
    ///<td width="60%"> Indicates that IP datagrams sent by the remote server (that is, received by the local computer)
    ///are compressed using Van Jacobson compression. </td> </tr> </table>
    uint       dwIPv4RemoteOptions;
    ///A value that specifies the IPv4 subinterface index corresponding to the connection on the server.
    ulong      IPv4SubInterfaceIndex;
    ///A value that specifies the result of PPP IPv6 Network control protocol negotiation. A value of zero indicates
    ///Ipv6 has been negotiated successfully. A nonzero value indicates failure, and is the fatal error that occurred
    ///during the control protocol negotiation.
    uint       dwIPv6NegotiationError;
    ///An array that specifies the 64-bit IPv6 interface identifier of the client. The last 64 bits of a 128-bit IPv6
    ///internet address are considered the interface identifier, which provides a strong level of uniqueness for the
    ///preceding 64 bits. The <b>bInterfaceIdentifier</b> member must not be 0 and is valid only if the
    ///<b>dwIPv6NegotiationError</b> member is 0.
    ubyte[8]   bInterfaceIdentifier;
    ///An array that specifies the 64-bit IPv6 interface identifier of the server. The last 64 bits of a 128-bit IPv6
    ///internet address are considered the interface identifier, which provides a strong level of uniqueness for the
    ///preceding 64 bits. The <b>bInterfaceIdentifier</b> member must not be 0 and is valid only if the
    ///<b>dwIPv6NegotiationError</b> member is 0.
    ubyte[8]   bRemoteInterfaceIdentifier;
    ///A value that specifies the client interface IPv6 address prefix.
    ubyte[8]   bPrefix;
    ///A value that specifies the length, in bits, of the <b>bPrefix</b> member.
    uint       dwPrefixLength;
    ///A value that specifies the IPv6 subinterface index corresponding to the connection on the server.
    ulong      IPv6SubInterfaceIndex;
    ///A value that specifies the result of PPP LCP negotiation. A value of zero indicates LCP has been negotiated
    ///successfully. A nonzero value indicates failure and represents the fatal error that occurred during the control
    ///protocol negotiation.
    uint       dwLcpError;
    ///A value that specifies the authentication protocol used to authenticate the local client. This member can be one
    ///of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="PPP_LCP_PAP"></a><a id="ppp_lcp_pap"></a><dl> <dt><b>PPP_LCP_PAP</b></dt> </dl> </td> <td width="60%">
    ///Password Authentication Protocol </td> </tr> <tr> <td width="40%"><a id="PPP_LCP_CHAP"></a><a
    ///id="ppp_lcp_chap"></a><dl> <dt><b>PPP_LCP_CHAP</b></dt> </dl> </td> <td width="60%"> Challenge Handshake
    ///Authentication Protocol </td> </tr> <tr> <td width="40%"><a id="PPP_LCP_EAP"></a><a id="ppp_lcp_eap"></a><dl>
    ///<dt><b>PPP_LCP_EAP</b></dt> </dl> </td> <td width="60%"> Extensible Authentication Protocol </td> </tr> </table>
    uint       dwAuthenticationProtocol;
    ///A value that specifies additional information about the authentication protocol specified by the
    ///<b>dwAuthenticationProtocol</b> member. This member can be one of the following values. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PPP_LCP_CHAP_MD5"></a><a
    ///id="ppp_lcp_chap_md5"></a><dl> <dt><b>PPP_LCP_CHAP_MD5</b></dt> </dl> </td> <td width="60%"> MD5 CHAP </td> </tr>
    ///<tr> <td width="40%"><a id="PPP_LCP_CHAP_MS"></a><a id="ppp_lcp_chap_ms"></a><dl> <dt><b>PPP_LCP_CHAP_MS</b></dt>
    ///</dl> </td> <td width="60%"> Microsoft CHAP </td> </tr> <tr> <td width="40%"><a id="PPP_LCP_CHAP_MSV2"></a><a
    ///id="ppp_lcp_chap_msv2"></a><dl> <dt><b>PPP_LCP_CHAP_MSV2</b></dt> </dl> </td> <td width="60%"> Microsoft CHAP
    ///version 2 </td> </tr> </table>
    uint       dwAuthenticationData;
    ///A value that specifies the authentication protocol used to authenticate the remote server. The
    ///<b>dwAuthenticationProtocol</b> member and the <b>dwRemoteAuthenticationProtocol</b> member will differ when
    ///demand dial uses different authentication protocols on the client and server. This member can be one of the
    ///following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="PPP_LCP_PAP"></a><a id="ppp_lcp_pap"></a><dl> <dt><b>PPP_LCP_PAP</b></dt> </dl> </td> <td width="60%">
    ///Password Authentication Protocol </td> </tr> <tr> <td width="40%"><a id="PPP_LCP_CHAP"></a><a
    ///id="ppp_lcp_chap"></a><dl> <dt><b>PPP_LCP_CHAP</b></dt> </dl> </td> <td width="60%"> Challenge Handshake
    ///Authentication Protocol </td> </tr> <tr> <td width="40%"><a id="PPP_LCP_EAP"></a><a id="ppp_lcp_eap"></a><dl>
    ///<dt><b>PPP_LCP_EAP</b></dt> </dl> </td> <td width="60%"> Extensible Authentication Protocol </td> </tr> </table>
    uint       dwRemoteAuthenticationProtocol;
    ///A value that specifies additional information about the authentication protocol specified by the
    ///<b>dwRemoteAuthenticationProtocol</b> member. The <b>dwAuthenticationData</b> member and the
    ///<b>dwRemoteAuthenticationData</b> member will differ when demand dial uses different authentication protocols on
    ///the client and server. This member can be one of the following values. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="PPP_LCP_CHAP_MD5"></a><a id="ppp_lcp_chap_md5"></a><dl>
    ///<dt><b>PPP_LCP_CHAP_MD5</b></dt> </dl> </td> <td width="60%"> MD5 CHAP </td> </tr> <tr> <td width="40%"><a
    ///id="PPP_LCP_CHAP_MS"></a><a id="ppp_lcp_chap_ms"></a><dl> <dt><b>PPP_LCP_CHAP_MS</b></dt> </dl> </td> <td
    ///width="60%"> Microsoft CHAP </td> </tr> <tr> <td width="40%"><a id="PPP_LCP_CHAP_MSV2"></a><a
    ///id="ppp_lcp_chap_msv2"></a><dl> <dt><b>PPP_LCP_CHAP_MSV2</b></dt> </dl> </td> <td width="60%"> Microsoft CHAP
    ///version 2 </td> </tr> </table>
    uint       dwRemoteAuthenticationData;
    ///Not Implemented. Must be 0.
    uint       dwLcpTerminateReason;
    ///Not Implemented. Must be 0.
    uint       dwLcpRemoteTerminateReason;
    ///A value that specifies information about LCP options in use by the local client. This member is a combination of
    ///the following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="PPP_LCP_MULTILINK_FRAMING"></a><a id="ppp_lcp_multilink_framing"></a><dl>
    ///<dt><b>PPP_LCP_MULTILINK_FRAMING</b></dt> </dl> </td> <td width="60%"> The connection is using multilink. </td>
    ///</tr> <tr> <td width="40%"><a id="PPP_LCP_PFC"></a><a id="ppp_lcp_pfc"></a><dl> <dt><b>PPP_LCP_PFC</b></dt> </dl>
    ///</td> <td width="60%"> The connection is using Protocol Field Compression. </td> </tr> <tr> <td width="40%"><a
    ///id="PPP_LCP_ACFC"></a><a id="ppp_lcp_acfc"></a><dl> <dt><b>PPP_LCP_ACFC</b></dt> </dl> </td> <td width="60%"> The
    ///connection is using Address and Control Field Compression. </td> </tr> <tr> <td width="40%"><a
    ///id="PPP_LCP_SSHF"></a><a id="ppp_lcp_sshf"></a><dl> <dt><b>PPP_LCP_SSHF</b></dt> </dl> </td> <td width="60%"> The
    ///connection is using Short Sequence Number Header Format. </td> </tr> <tr> <td width="40%"><a
    ///id="PPP_LCP_DES_56"></a><a id="ppp_lcp_des_56"></a><dl> <dt><b>PPP_LCP_DES_56</b></dt> </dl> </td> <td
    ///width="60%"> The connection is using DES 56-bit encryption. </td> </tr> <tr> <td width="40%"><a
    ///id="PPP_LCP_3_DES"></a><a id="ppp_lcp_3_des"></a><dl> <dt><b>PPP_LCP_3_DES</b></dt> </dl> </td> <td width="60%">
    ///The connection is using Triple DES Encryption. </td> </tr> <tr> <td width="40%"><a id="PPP_LCP_AES_128"></a><a
    ///id="ppp_lcp_aes_128"></a><dl> <dt><b>PPP_LCP_AES_128</b></dt> </dl> </td> <td width="60%"> The connection is
    ///using 128-bit AES Encryption. </td> </tr> <tr> <td width="40%"><a id="PPP_LCP_AES_256"></a><a
    ///id="ppp_lcp_aes_256"></a><dl> <dt><b>PPP_LCP_AES_256</b></dt> </dl> </td> <td width="60%"> The connection is
    ///using 256-bit AES Encryption. </td> </tr> </table>
    uint       dwLcpOptions;
    ///A value that specifies information about LCP options in use by the remote server. This member is a combination of
    ///the following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="PPP_LCP_MULTILINK_FRAMING"></a><a id="ppp_lcp_multilink_framing"></a><dl>
    ///<dt><b>PPP_LCP_MULTILINK_FRAMING</b></dt> </dl> </td> <td width="60%"> The connection is using multilink. </td>
    ///</tr> <tr> <td width="40%"><a id="PPP_LCP_PFC"></a><a id="ppp_lcp_pfc"></a><dl> <dt><b>PPP_LCP_PFC</b></dt> </dl>
    ///</td> <td width="60%"> The connection is using Protocol Field Compression. </td> </tr> <tr> <td width="40%"><a
    ///id="PPP_LCP_ACFC_"></a><a id="ppp_lcp_acfc_"></a><dl> <dt><b>PPP_LCP_ACFC </b></dt> </dl> </td> <td width="60%">
    ///The connection is using Address and Control Field Compression. </td> </tr> <tr> <td width="40%"><a
    ///id="PPP_LCP_SSHF"></a><a id="ppp_lcp_sshf"></a><dl> <dt><b>PPP_LCP_SSHF</b></dt> </dl> </td> <td width="60%"> The
    ///connection is using Short Sequence Number Header Format. </td> </tr> <tr> <td width="40%"><a
    ///id="PPP_LCP_DES_56"></a><a id="ppp_lcp_des_56"></a><dl> <dt><b>PPP_LCP_DES_56</b></dt> </dl> </td> <td
    ///width="60%"> The connection is using DES 56-bit encryption. </td> </tr> <tr> <td width="40%"><a
    ///id="PPP_LCP_3_DES"></a><a id="ppp_lcp_3_des"></a><dl> <dt><b>PPP_LCP_3_DES</b></dt> </dl> </td> <td width="60%">
    ///The connection is using Triple DES Encryption. </td> </tr> <tr> <td width="40%"><a id="PPP_LCP_AES_128"></a><a
    ///id="ppp_lcp_aes_128"></a><dl> <dt><b>PPP_LCP_AES_128</b></dt> </dl> </td> <td width="60%"> The connection is
    ///using 128-bit AES Encryption. </td> </tr> <tr> <td width="40%"><a id="PPP_LCP_AES_256"></a><a
    ///id="ppp_lcp_aes_256"></a><dl> <dt><b>PPP_LCP_AES_256</b></dt> </dl> </td> <td width="60%"> The connection is
    ///using 256-bit AES Encryption. </td> </tr> </table>
    uint       dwLcpRemoteOptions;
    ///A value that specifies the type identifier of the Extensible Authentication Protocol (EAP) used to authenticate
    ///the local client. The value of this member is valid only if the <b>dwAuthenticationProtocol</b> member is
    ///<b>PPP_LCP_EAP</b>.
    uint       dwEapTypeId;
    ///A value that specifies the type identifier of the inner EAP method used in the EAP authentication. The value of
    ///this member is valid only if the <b>dwEapTypeId</b> member is set to PEAP defined in IANA-EAP.
    uint       dwEmbeddedEAPTypeId;
    ///A value that specifies the type identifier of the Extensible Authentication Protocol (EAP) used to authenticate
    ///the remote server. The value of this member is valid only if the <b>dwRemoteAuthenticationProtocol</b> member is
    ///<b>PPP_LCP_EAP</b>.
    uint       dwRemoteEapTypeId;
    ///A value that specifies the result of PPP CCP negotiation. A value of 0 indicates CCP has been negotiated
    ///successfully. A nonzero value indicates failure, and represents the fatal error that occurred during the control
    ///protocol negotiation.
    uint       dwCcpError;
    ///A value that specifies the compression algorithm used by the local client. The following table shows the possible
    ///values for this member. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="RASCCPCA_MPPC"></a><a id="rasccpca_mppc"></a><dl> <dt><b>RASCCPCA_MPPC</b></dt> </dl> </td> <td width="60%">
    ///Microsoft Point-to-Point Compression (MPPC) Protocol. </td> </tr> <tr> <td width="40%"><a
    ///id="RASCCPCA_STAC"></a><a id="rasccpca_stac"></a><dl> <dt><b>RASCCPCA_STAC</b></dt> </dl> </td> <td width="60%">
    ///STAC option 4. </td> </tr> </table>
    uint       dwCompressionAlgorithm;
    ///A value that specifies the compression types available on the local client. The following types are supported.
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PPP_CCP_COMPRESSION"></a><a
    ///id="ppp_ccp_compression"></a><dl> <dt><b>PPP_CCP_COMPRESSION</b></dt> </dl> </td> <td width="60%"> Compression
    ///without encryption. </td> </tr> <tr> <td width="40%"><a id="PPP_CCP_HISTORYLESS"></a><a
    ///id="ppp_ccp_historyless"></a><dl> <dt><b>PPP_CCP_HISTORYLESS</b></dt> </dl> </td> <td width="60%"> Microsoft
    ///Point-to-Point Encryption (MPPE) in stateless mode. The session key is changed after every packet. This mode
    ///improves performance on high latency networks, or networks that experience significant packet loss. </td> </tr>
    ///<tr> <td width="40%"><a id="PPP_CCP_ENCRYPTION40BITOLD"></a><a id="ppp_ccp_encryption40bitold"></a><dl>
    ///<dt><b>PPP_CCP_ENCRYPTION40BITOLD</b></dt> </dl> </td> <td width="60%"> MPPE compression using 40-bit keys. </td>
    ///</tr> <tr> <td width="40%"><a id="PPP_CCP_ENCRYPTION40BIT"></a><a id="ppp_ccp_encryption40bit"></a><dl>
    ///<dt><b>PPP_CCP_ENCRYPTION40BIT</b></dt> </dl> </td> <td width="60%"> MPPE compression using 40-bit keys. </td>
    ///</tr> <tr> <td width="40%"><a id="PPP_CCP_ENCRYPTION56BIT"></a><a id="ppp_ccp_encryption56bit"></a><dl>
    ///<dt><b>PPP_CCP_ENCRYPTION56BIT</b></dt> </dl> </td> <td width="60%"> MPPE compression using 56-bit keys. </td>
    ///</tr> <tr> <td width="40%"><a id="PPP_CCP_ENCRYPTION128BIT"></a><a id="ppp_ccp_encryption128bit"></a><dl>
    ///<dt><b>PPP_CCP_ENCRYPTION128BIT</b></dt> </dl> </td> <td width="60%"> MPPE compression using 128-bit keys. </td>
    ///</tr> </table> The last three options are used when a connection is made over Layer 2 Tunneling Protocol (L2TP),
    ///and the connection uses IPSec encryption.
    uint       dwCcpOptions;
    ///A value that specifies the compression algorithm used by the remote server. The following algorithms are
    ///supported. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RASCCPCA_MPPC"></a><a
    ///id="rasccpca_mppc"></a><dl> <dt><b>RASCCPCA_MPPC</b></dt> </dl> </td> <td width="60%"> Microsoft Point-to-Point
    ///Compression (MPPC) Protocol. </td> </tr> <tr> <td width="40%"><a id="RASCCPCA_STAC"></a><a
    ///id="rasccpca_stac"></a><dl> <dt><b>RASCCPCA_STAC</b></dt> </dl> </td> <td width="60%"> STAC option 4. </td> </tr>
    ///</table>
    uint       dwRemoteCompressionAlgorithm;
    uint       dwCcpRemoteOptions;
}

///The <b>IKEV2_PROJECTION_INFO</b> structure contains information obtained during Internet Key Exchange (IKE)
///negotiation.
struct IKEV2_PROJECTION_INFO
{
    ///A value that specifies the result of IPv4 negotiation. A value of zero indicates an IPv4 address has been
    ///assigned successfully. A nonzero value indicates failure, and is the fatal error that occurred during
    ///negotiation.
    uint       dwIPv4NegotiationError;
    ///An array that contains a Unicode string that specifies the IPv4 address of the local client. This string has the
    ///form "a.b.c.d". <b>wszAddress</b> is valid only if <b>dwIPv4NegotiationError</b> is zero.
    ushort[16] wszAddress;
    ///An array that contains a Unicode string that specifies the IPv4 address of the remote server. This string has the
    ///form "a.b.c.d". <b>wszRemoteAddress</b> is valid only if <b>dwIPv4NegotiationError</b> is zero. If the address is
    ///not available, this member is an empty string.
    ushort[16] wszRemoteAddress;
    ///A value that specifies the IPv4 subinterface index corresponding to the connection on the server.
    ulong      IPv4SubInterfaceIndex;
    ///A value that specifies the result of IPv6 negotiation. A value of zero indicates an IPv6 address has been
    ///negotiated successfully. A nonzero value indicates failure, and is the fatal error that occurred during
    ///negotiation.
    uint       dwIPv6NegotiationError;
    ///An array that specifies the 64-bit IPv6 interface identifier of the client. The last 64 bits of a 128-bit IPv6
    ///internet address are considered the "interface identifier," which provides a strong level of uniqueness for the
    ///preceding 64-bits. <b>bInterfaceIdentifier</b> is valid only if <b>dwIPv6NegotiationError</b> is zero and must
    ///not be zero.
    ubyte[8]   bInterfaceIdentifier;
    ///An array that specifies the 64-bit IPv6 interface identifier of the server. The last 64 bits of a 128-bit IPv6
    ///internet address are considered the "interface identifier," which provides a strong level of uniqueness for the
    ///preceding 64-bits. <b>bInterfaceIdentifier</b> is valid only if <b>dwIPv6NegotiationError</b> is zero and must
    ///not be zero.
    ubyte[8]   bRemoteInterfaceIdentifier;
    ///A value that specifies the client interface IPv6 address prefix.
    ubyte[8]   bPrefix;
    ///A value that specifies the length, in bits, of <b>bPrefix</b>.
    uint       dwPrefixLength;
    ///A value that specifies the IPv6 subinterface index corresponding to the connection on the server.
    ulong      IPv6SubInterfaceIndex;
    ///Not used.
    uint       dwOptions;
    ///A value that specifies the authentication protocol used to authenticate the remote server. The following
    ///authentication protocols are supported: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="MPRAPI_IKEV2_AUTH_USING_CERT"></a><a id="mprapi_ikev2_auth_using_cert"></a><dl>
    ///<dt><b>MPRAPI_IKEV2_AUTH_USING_CERT</b></dt> </dl> </td> <td width="60%"> X.509 Public Key Infrastructure
    ///Certificate (RFC 2459) </td> </tr> <tr> <td width="40%"><a id="MPRAPI_IKEV2_AUTH_USING_EAP"></a><a
    ///id="mprapi_ikev2_auth_using_eap"></a><dl> <dt><b>MPRAPI_IKEV2_AUTH_USING_EAP</b></dt> </dl> </td> <td
    ///width="60%"> Extensible Authentication Protocol </td> </tr> </table>
    uint       dwAuthenticationProtocol;
    ///A value that specifies the type identifier of the Extensible Authentication Protocol (EAP) used to authenticate
    ///the local client. The value of this member is valid only if <b>dwAuthenticationProtocol</b> is
    ///<b>MPRAPI_IKEV2_AUTH_USING_EAP</b>.
    uint       dwEapTypeId;
    ///Not used.
    uint       dwCompressionAlgorithm;
    ///A value that specifies the encryption method used in the connection. The following encryption methods are
    ///supported: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_CIPHER_TYPE_3DES"></a><a id="ipsec_cipher_type_3des"></a><dl> <dt><b>IPSEC_CIPHER_TYPE_3DES</b></dt>
    ///</dl> </td> <td width="60%"> 3DES encryption </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_CIPHER_TYPE_AES_128"></a><a id="ipsec_cipher_type_aes_128"></a><dl>
    ///<dt><b>IPSEC_CIPHER_TYPE_AES_128</b></dt> </dl> </td> <td width="60%"> AES-128 encryption </td> </tr> <tr> <td
    ///width="40%"><a id="IPSEC_CIPHER_TYPE_AES_192"></a><a id="ipsec_cipher_type_aes_192"></a><dl>
    ///<dt><b>IPSEC_CIPHER_TYPE_AES_192</b></dt> </dl> </td> <td width="60%"> AES-192 encryption </td> </tr> <tr> <td
    ///width="40%"><a id="IPSEC_CIPHER_TYPE_AES_256"></a><a id="ipsec_cipher_type_aes_256"></a><dl>
    ///<dt><b>IPSEC_CIPHER_TYPE_AES_256</b></dt> </dl> </td> <td width="60%"> AES-256 encryption </td> </tr> </table>
    uint       dwEncryptionMethod;
}

///Contains information obtained during Internet Key Exchange (IKE) negotiation.
struct IKEV2_PROJECTION_INFO2
{
    ///A value that specifies the result of IPv4 negotiation. A value of zero indicates an IPv4 address has been
    ///assigned successfully. A nonzero value indicates failure, and is the fatal error that occurred during
    ///negotiation.
    uint       dwIPv4NegotiationError;
    ///An null-terminated Unicode string that specifies the IPv4 address of the local client. The string has the form
    ///"a.b.c.d". The <b>wszAddress</b> member is valid only if the <b>dwIPv4NegotiationError</b> member is 0.
    ushort[16] wszAddress;
    ///A null-terminated Unicode string that specifies the IPv4 address of the remote server. This string has the form
    ///"a.b.c.d". The <b>wszRemoteAddress</b> member is valid only if the <b>dwIPv4NegotiationError</b> member is zero.
    ///If the address is not available, this member is an empty string.
    ushort[16] wszRemoteAddress;
    ///A value that specifies the IPv4 subinterface index corresponding to the connection on the server.
    ulong      IPv4SubInterfaceIndex;
    ///A value that specifies the result of IPv6 negotiation. A value of 0 indicates an IPv6 address has been negotiated
    ///successfully. A nonzero value indicates failure, and is the fatal error that occurred during negotiation.
    uint       dwIPv6NegotiationError;
    ///An array that specifies the 64-bit IPv6 interface identifier of the client. The last 64-bits of a 128-bit IPv6
    ///internet address are considered the interface identifier, which provides a strong level of uniqueness for the
    ///preceding 64-bits. The <b>bInterfaceIdentifier</b> member is valid only if the <b>dwIPv6NegotiationError</b>
    ///member is 0. The <i>bInterfaceIdentifier</i> member must not be 0.
    ubyte[8]   bInterfaceIdentifier;
    ///An array that specifies the 64-bit IPv6 interface identifier of the server. The last 64 bits of a 128-bit IPv6
    ///internet address are considered the interface identifier, which provides a strong level of uniqueness for the
    ///preceding 64 bits. The <b>bInterfaceIdentifier</b> member must not be 0 and is valid only if the
    ///<b>dwIPv6NegotiationError</b> member is zero.
    ubyte[8]   bRemoteInterfaceIdentifier;
    ///A value that specifies the client interface IPv6 address prefix.
    ubyte[8]   bPrefix;
    ///A value that specifies the length, in bits, of the <b>bPrefix</b> member.
    uint       dwPrefixLength;
    ///A value that specifies the IPv6 subinterface index corresponding to the connection on the server.
    ulong      IPv6SubInterfaceIndex;
    ///Not implemented.
    uint       dwOptions;
    ///A value that specifies the authentication protocol used to authenticate the remote server. The following
    ///authentication protocols are supported: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="MPRAPI_IKEV2_AUTH_USING_CERT"></a><a id="mprapi_ikev2_auth_using_cert"></a><dl>
    ///<dt><b>MPRAPI_IKEV2_AUTH_USING_CERT</b></dt> </dl> </td> <td width="60%"> X.509 Public Key Infrastructure
    ///Certificate (described in RFC 2459) </td> </tr> <tr> <td width="40%"><a id="MPRAPI_IKEV2_AUTH_USING_EAP"></a><a
    ///id="mprapi_ikev2_auth_using_eap"></a><dl> <dt><b>MPRAPI_IKEV2_AUTH_USING_EAP</b></dt> </dl> </td> <td
    ///width="60%"> Extensible Authentication Protocol </td> </tr> </table>
    uint       dwAuthenticationProtocol;
    ///A value that specifies the type identifier of the Extensible Authentication Protocol (EAP) used to authenticate
    ///the local client. The value of this member is valid only if the <b>dwAuthenticationProtocol</b> member is
    ///<b>MPRAPI_IKEV2_AUTH_USING_EAP</b>.
    uint       dwEapTypeId;
    ///A value that specifies the type identifier of the inner EAP method used in the EAP authentication. The value of
    ///this member is valid only if the <b>dwEapTypeId</b> member is set to <b>PEAP</b> defined in IANA-EAP.
    uint       dwEmbeddedEAPTypeId;
    ///Not implemented.
    uint       dwCompressionAlgorithm;
    uint       dwEncryptionMethod;
}

///The <b>PROJECTION_INFO</b> structure is used in the RAS_CONNECTION_EX structure as a placeholder for the
///PPP_PROJECTION_INFO and IKEV2_PROJECTION_INFO structures.
struct PROJECTION_INFO
{
    ///A value that specifies if the projection is for a Point-to-Point (PPP) or an Internet Key Exchange version 2
    ///(IKEv2) based tunnel. The following values are supported: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td width="40%"><a id="MPRAPI_PPP_PROJECTION_INFO_TYPE"></a><a id="mprapi_ppp_projection_info_type"></a><dl>
    ///<dt><b>MPRAPI_PPP_PROJECTION_INFO_TYPE</b></dt> </dl> </td> <td width="60%"> Data is a PPP_PROJECTION_INFO
    ///structure. </td> </tr> <tr> <td width="40%"><a id="MPRAPI_IKEV2_PROJECTION_INFO_TYPE"></a><a
    ///id="mprapi_ikev2_projection_info_type"></a><dl> <dt><b>MPRAPI_IKEV2_PROJECTION_INFO_TYPE</b></dt> </dl> </td> <td
    ///width="60%"> Data is a IKEV2_PROJECTION_INFO structure. </td> </tr> </table>
    ubyte projectionInfoType;
union
    {
        PPP_PROJECTION_INFO PppProjectionInfo;
        IKEV2_PROJECTION_INFO Ikev2ProjectionInfo;
    }
}

///Used in the RAS_CONNECTION_4 structure as a placeholder for the PPP_PROJECTION_INFO2 and IKEV2_PROJECTION_INFO2
///structures.
struct PROJECTION_INFO2
{
    ///A value that specifies if the projection is for a Point-to-Point (PPP) or an Internet Key Exchange version 2
    ///(IKEv2) based tunnel. The following values are supported. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td width="40%"><a id="MPRAPI_PPP_PROJECTION_INFO_TYPE"></a><a id="mprapi_ppp_projection_info_type"></a><dl>
    ///<dt><b>MPRAPI_PPP_PROJECTION_INFO_TYPE</b></dt> </dl> </td> <td width="60%"> The data is a PPP_PROJECTION_INFO2
    ///structure. </td> </tr> <tr> <td width="40%"><a id="MPRAPI_IKEV2_PROJECTION_INFO_TYPE"></a><a
    ///id="mprapi_ikev2_projection_info_type"></a><dl> <dt><b>MPRAPI_IKEV2_PROJECTION_INFO_TYPE</b></dt> </dl> </td> <td
    ///width="60%"> The data is a IKEV2_PROJECTION_INFO2 structure. </td> </tr> </table>
    ubyte projectionInfoType;
union
    {
        PPP_PROJECTION_INFO2 PppProjectionInfo;
        IKEV2_PROJECTION_INFO2 Ikev2ProjectionInfo;
    }
}

///The <b>RAS_CONNECTION_EX</b> structure contains specific information for the connection that includes: the user name,
///domain, and Globally Unique Identifier (GUID) associated with the connection, its Network Access Protection (NAP)
///quarantine state, its packet statistics, as well as its Point-to-Point(PPP) and Internet Key Exchange version 2
///(IKEv2) related information. The <b>RAS_CONNECTION_EX</b> structure contains most of the same information as the
///RAS_CONNECTION_0, RAS_CONNECTION_1, RAS_CONNECTION_2, and RAS_CONNECTION_3 combined structures.
struct RAS_CONNECTION_EX
{
    ///A MPRAPI_OBJECT_HEADER structure that specifies the version of the <b>RAS_CONNECTION_EX</b> structure. <div
    ///class="alert"><b>Note</b> The <b>revision</b> member of <b>Header</b> must be
    ///<b>MPRAPI_RAS_CONNECTION_OBJECT_REVISION_1</b> and <b>type</b> must be
    ///<b>MPRAPI_OBJECT_TYPE_RAS_CONNECTION_OBJECT</b>.</div> <div> </div>
    MPRAPI_OBJECT_HEADER Header;
    ///A value that represent the duration of the connection, in seconds.
    uint                 dwConnectDuration;
    ///A ROUTER_INTERFACE_TYPE enumeration that identifies the type of connection interface.
    ROUTER_INTERFACE_TYPE dwInterfaceType;
    ///A bitmap of flags that specify connection attributes. <b>dwConnectionFlags</b> must contain at least one of the
    ///following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="RAS_FLAGS_PPP_CONNECTION"></a><a id="ras_flags_ppp_connection"></a><dl>
    ///<dt><b>RAS_FLAGS_PPP_CONNECTION</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> The connection is using
    ///Point-to-Point Protocol (PPP). </td> </tr> <tr> <td width="40%"><a id="RAS_FLAGS_MESSENGER_PRESENT"></a><a
    ///id="ras_flags_messenger_present"></a><dl> <dt><b>RAS_FLAGS_MESSENGER_PRESENT</b></dt> <dt>0x00000002</dt> </dl>
    ///</td> <td width="60%"> The messenger service is active on the client and messages can be sent to the client using
    ///MprAdminSendUserMessage. </td> </tr> <tr> <td width="40%"><a id="RAS_FLAGS_QUARANTINE_PRESENT"></a><a
    ///id="ras_flags_quarantine_present"></a><dl> <dt><b>RAS_FLAGS_QUARANTINE_PRESENT</b></dt> <dt>0x00000008</dt> </dl>
    ///</td> <td width="60%"> The connection is currently in quarantine. For information on how to remove the connection
    ///from quarantine, please see MprAdminConnectionRemoveQuarantine. </td> </tr> <tr> <td width="40%"><a
    ///id="RAS_FLAGS_ARAP_CONNECTION"></a><a id="ras_flags_arap_connection"></a><dl>
    ///<dt><b>RAS_FLAGS_ARAP_CONNECTION</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> The connection is
    ///using AppleTalk Remote Access Protocol (ARAP). </td> </tr> <tr> <td width="40%"><a
    ///id="RAS_FLAGS_IKEV2_CONNECTION"></a><a id="ras_flags_ikev2_connection"></a><dl>
    ///<dt><b>RAS_FLAGS_IKEV2_CONNECTION</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> The connection is
    ///using IKEv2. </td> </tr> <tr> <td width="40%"><a id="RAS_FLAGS_DORMANT"></a><a id="ras_flags_dormant"></a><dl>
    ///<dt><b>RAS_FLAGS_DORMANT</b></dt> <dt>0x00000020</dt> </dl> </td> <td width="60%"> The connection is using IKEv2
    ///and the server is not reachable. </td> </tr> </table>
    uint                 dwConnectionFlags;
    ///A null-terminated Unicode string that contains the name of the interface for this connection.
    ushort[257]          wszInterfaceName;
    ///A null-terminated Unicode string that contains the name of the user logged on to the connection.
    ushort[257]          wszUserName;
    ///A null-terminated Unicode string that contains the domain on which the connected user is authenticated.
    ushort[16]           wszLogonDomain;
    ///A null-terminated Unicode string that contains the name of the remote computer.
    ushort[17]           wszRemoteComputer;
    ///A GUID that identifies the connection. For incoming connections, this GUID is valid only as long as the
    ///connection is active.
    GUID                 guid;
    ///A RAS_QUARANTINE_STATE structure that specifies the NAP quarantine state of the connection.
    RAS_QUARANTINE_STATE rasQuarState;
    ///A FILETIME structure that specifies the time required for the connection to come out of quarantine after which
    ///the connection will be dropped. This value is valid only if <b>rasQuarState</b> has a value of
    ///<b>RAS_QUAR_STATE_PROBATION</b>.
    FILETIME             probationTime;
    ///A value that specifies the number of bytes transmitted on the connection.
    uint                 dwBytesXmited;
    ///A value that specifies the number of bytes received on the connection.
    uint                 dwBytesRcved;
    ///A value that specifies the number of frames transmitted on the connection.
    uint                 dwFramesXmited;
    ///A value that specifies the number of frames received on the connection.
    uint                 dwFramesRcved;
    ///A value that specifies the number of Cyclic Redundancy Check (CRC) errors on the connection.
    uint                 dwCrcErr;
    ///A value that specifies the number of time-out errors on the connection.
    uint                 dwTimeoutErr;
    ///A value that specifies the number of alignment errors on the connection.
    uint                 dwAlignmentErr;
    ///A value that specifies the number of hardware overrun errors on the connection.
    uint                 dwHardwareOverrunErr;
    ///A value that specifies the number of framing errors on the connection.
    uint                 dwFramingErr;
    ///A value that specifies the number of buffer overrun errors on the connection.
    uint                 dwBufferOverrunErr;
    ///A value that specifies the percentage by which data received on this connection is compressed.
    ///<b>dwCompressionRatioIn</b> is the size of the compressed data divided by the size of the same data in an
    ///uncompressed state.
    uint                 dwCompressionRatioIn;
    ///A value that specifies the percentage by which data transmitted on this connection is compressed. The ratio is
    ///the size of the compressed data divided by the size of the same data in an uncompressed state.
    uint                 dwCompressionRatioOut;
    ///A value that specifies the number of IKEv2 Mobility and Multihoming Protocol (MOBIKE) switches that have occurred
    ///on the connection as defined in RFC4555. <b>dwNumSwitchOvers</b>is only valid if <b>dwConnectionFlags</b> is
    ///<b>RAS_FLAGS_IKEV2_CONNECTION</b>.
    uint                 dwNumSwitchOvers;
    ///A null-terminated Unicode string that contains the IP address of the remote computer in the connection. This
    ///string is of the form "a.b.c.d".
    ushort[65]           wszRemoteEndpointAddress;
    ///A null-terminated Unicode string that contains the IP address of the local computer in the connection. This
    ///string is of the form "a.b.c.d".
    ushort[65]           wszLocalEndpointAddress;
    ///A PROJECTION_INFO structure that contains either a PPP_PROJECTION_INFO or IKEV2_PROJECTION_INFO structure.
    PROJECTION_INFO      ProjectionInfo;
    ///A handle to the RAS connection.
    HANDLE               hConnection;
    ///A handle to the RAS connection interface.
    HANDLE               hInterface;
}

///Contains specific information for the connection that includes: the user name, domain, Globally Unique Identifier
///(GUID) associated with the connection, Network Access Protection (NAP) quarantine state, packet statistics, as well
///as its Point-to-Point (PPP) and Internet Key Exchange version 2 (IKEv2) related information.
struct RAS_CONNECTION_4
{
    ///A value that represent the duration of the connection in seconds.
    uint                 dwConnectDuration;
    ///A ROUTER_INTERFACE_TYPE enumeration that identifies the type of connection interface.
    ROUTER_INTERFACE_TYPE dwInterfaceType;
    ///A bitmap of flags that specify connection attributes. The <b>dwConnectionFlags</b> member must contain at least
    ///one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="RAS_FLAGS_PPP_CONNECTION"></a><a id="ras_flags_ppp_connection"></a><dl>
    ///<dt><b>RAS_FLAGS_PPP_CONNECTION</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> The connection is using
    ///Point-to-Point Protocol (PPP). </td> </tr> <tr> <td width="40%"><a id="RAS_FLAGS_MESSENGER_PRESENT"></a><a
    ///id="ras_flags_messenger_present"></a><dl> <dt><b>RAS_FLAGS_MESSENGER_PRESENT</b></dt> <dt>0x00000002</dt> </dl>
    ///</td> <td width="60%"> The messenger service is active on the client and messages can be sent to the client using
    ///the MprAdminSendUserMessage function. </td> </tr> <tr> <td width="40%"><a
    ///id="RAS_FLAGS_QUARANTINE_PRESENT"></a><a id="ras_flags_quarantine_present"></a><dl>
    ///<dt><b>RAS_FLAGS_QUARANTINE_PRESENT</b></dt> <dt>0x00000008</dt> </dl> </td> <td width="60%"> The connection is
    ///currently in quarantine. For information on how to remove the connection from quarantine, please see
    ///MprAdminConnectionRemoveQuarantine. </td> </tr> <tr> <td width="40%"><a id="RAS_FLAGS_ARAP_CONNECTION"></a><a
    ///id="ras_flags_arap_connection"></a><dl> <dt><b>RAS_FLAGS_ARAP_CONNECTION</b></dt> <dt>0x00000010</dt> </dl> </td>
    ///<td width="60%"> The connection is using AppleTalk Remote Access Protocol (ARAP). </td> </tr> <tr> <td
    ///width="40%"><a id="RAS_FLAGS_IKEV2_CONNECTION"></a><a id="ras_flags_ikev2_connection"></a><dl>
    ///<dt><b>RAS_FLAGS_IKEV2_CONNECTION</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> The connection is
    ///using IKEv2. </td> </tr> <tr> <td width="40%"><a id="RAS_FLAGS_DORMANT"></a><a id="ras_flags_dormant"></a><dl>
    ///<dt><b>RAS_FLAGS_DORMANT</b></dt> <dt>0x00000020</dt> </dl> </td> <td width="60%"> The connection is using IKEv2
    ///and the server is not reachable. </td> </tr> </table>
    uint                 dwConnectionFlags;
    ///A null-terminated Unicode string that contains the name of the interface for this connection.
    ushort[257]          wszInterfaceName;
    ///A null-terminated Unicode string that contains the name of the user logged on to the connection.
    ushort[257]          wszUserName;
    ///A null-terminated Unicode string that contains the domain on which the connected user is authenticated.
    ushort[16]           wszLogonDomain;
    ///A null-terminated Unicode string that contains the name of the remote computer.
    ushort[17]           wszRemoteComputer;
    ///A GUID that identifies the connection. For incoming connections, this GUID is valid only as long as the
    ///connection is active.
    GUID                 guid;
    ///A RAS_QUARANTINE_STATE structure that specifies the NAP quarantine state of the connection.
    RAS_QUARANTINE_STATE rasQuarState;
    ///A FILETIME structure that specifies the time required for the connection to come out of quarantine after which
    ///the connection will be dropped. This value is valid only if the <b>rasQuarState</b> member has a value of
    ///<b>RAS_QUAR_STATE_PROBATION</b>.
    FILETIME             probationTime;
    ///A FILETIME structure that specifies the connection start time in UTC.
    FILETIME             connectionStartTime;
    ///A value that specifies the number of bytes transmitted on the connection.
    ulong                ullBytesXmited;
    ///A value that specifies the number of bytes received on the connection.
    ulong                ullBytesRcved;
    ///A value that specifies the number of frames transmitted on the connection.
    uint                 dwFramesXmited;
    ///A value that specifies the number of frames received on the connection.
    uint                 dwFramesRcved;
    ///A value that specifies the number of Cyclic Redundancy Check (CRC) errors on the connection.
    uint                 dwCrcErr;
    ///A value that specifies the number of time-out errors on the connection.
    uint                 dwTimeoutErr;
    ///A value that specifies the number of alignment errors on the connection.
    uint                 dwAlignmentErr;
    ///A value that specifies the number of hardware overrun errors on the connection.
    uint                 dwHardwareOverrunErr;
    ///A value that specifies the number of framing errors on the connection.
    uint                 dwFramingErr;
    ///A value that specifies the number of buffer overrun errors on the connection.
    uint                 dwBufferOverrunErr;
    ///A value that specifies the percentage by which data received on this connection is compressed. The
    ///<b>dwCompressionRatioIn</b> member is the size of the compressed data divided by the size of the same data in an
    ///uncompressed state.
    uint                 dwCompressionRatioIn;
    ///A value that specifies the percentage by which data transmitted on this connection is compressed. The ratio is
    ///the size of the compressed data divided by the size of the same data in an uncompressed state.
    uint                 dwCompressionRatioOut;
    ///A value that specifies the number of IKEv2 Mobility and Multihoming Protocol (MOBIKE) switches that have occurred
    ///on the connection. The <b>dwNumSwitchOvers</b> member is only valid if the <b>dwConnectionFlags</b> member is
    ///<b>RAS_FLAGS_IKEV2_CONNECTION</b>.
    uint                 dwNumSwitchOvers;
    ///A null-terminated Unicode string that contains the IP address of the remote computer in the connection. This
    ///string is of the form "a.b.c.d".
    ushort[65]           wszRemoteEndpointAddress;
    ///A null-terminated Unicode string that contains the IP address of the local computer in the connection. This
    ///string is of the form "a.b.c.d".
    ushort[65]           wszLocalEndpointAddress;
    ///A PROJECTION_INFO2 structure that contains either a PPP_PROJECTION_INFO2 structure or a IKEV2_PROJECTION_INFO2
    ///structure.
    PROJECTION_INFO2     ProjectionInfo;
    ///A handle to the RAS connection.
    HANDLE               hConnection;
    ///A handle to the RAS connection interface.
    HANDLE               hInterface;
    uint                 dwDeviceType;
}

///Contains the IKEv2 main mode and quick mode policy configuration. Do not use the <b>ROUTER_CUSTOM_IKEv2_POLICY0</b>
///structure directly in your code; using ROUTER_CUSTOM_IKEv2_POLICY instead ensures that the proper version, based on
///the operating system the code in compiled under, is used.
struct ROUTER_CUSTOM_IKEv2_POLICY0
{
    ///A value that specifies the integrity algorithm to be negotiated during IKEv2 main mode SA negotiation. The
    ///allowed values for this member are defined in
    ///[IKEEXT_INTEGRITY_TYPE](/windows/desktop/api/iketypes/ne-iketypes-ikeext_integrity_type).
    uint dwIntegrityMethod;
    ///A value that specifies the encryption algorithm to be negotiated during IKEv2 main mode SA negotiation. The
    ///allowed valued for this member are defined in
    ///[IKEEXT_CIPHER_TYPE](/windows/desktop/api/iketypes/ne-iketypes-ikeext_cipher_type).
    uint dwEncryptionMethod;
    ///A value that specifies the encryption algorithm to be negotiated during IKEv2 quick mode SA negotiation. The
    ///allowed valued for this member are defined in
    ///[IPSEC_CIPHER_TYPE](/windows/desktop/api/ipsectypes/ne-ipsectypes-ipsec_cipher_type).
    uint dwCipherTransformConstant;
    ///A value that specifies the hash algorithm to be negotiated during IKEv2 quick mode SA negotiation. The allowed
    ///valued for this member are defined in
    ///[IPSEC_AUTH_TYPE](/windows/desktop/api/ipsectypes/ne-ipsectypes-ipsec_auth_type).
    uint dwAuthTransformConstant;
    ///A value that specifies the Diffie Hellman algorithm that should be used for Quick Mode PFS (Perfect Forward
    ///Secrecy). The allowed valued for this member are defined in
    ///[IPSEC_PFS_GROUP](/windows/desktop/api/ipsectypes/ne-ipsectypes-ipsec_pfs_group).
    uint dwPfsGroup;
    uint dwDhGroup;
}

///Gets or sets IKEv2 tunnel configuration parameter for IKEv2 tunnel based demand dial interfaces. Do not use the
///<b>ROUTER_IKEv2_IF_CUSTOM_CONFIG0</b> structure directly in your code; using ROUTER_IKEv2_IF_CUSTOM_CONFIG instead
///ensures that the proper version, based on the operating system the code in compiled under, is used.
struct ROUTER_IKEv2_IF_CUSTOM_CONFIG0
{
    ///A value that specifies the lifetime of a security association (SA) after which the SA is no longer valid. This
    ///value must be between 300 and 17,279,999 seconds.
    uint           dwSaLifeTime;
    ///A value that specifies the number of kilobytes that are allowed to transfer using a SA. Afterwards, the SA will
    ///be renegotiated. This value must be greater than or equal to 1024 KB.
    uint           dwSaDataSize;
    ///A value that specifies the configured certificate that will be sent to the peer for authentication during the
    ///main mode SA negotiation for the IKE2 tunnel based VPN connections.
    CRYPTOAPI_BLOB certificateName;
    ROUTER_CUSTOM_IKEv2_POLICY0* customPolicy;
}

///Gets or sets tunnel specific custom configuration for a demand dial interfaces. Do not use the
///<b>MPR_IF_CUSTOMINFOEX0</b> structure directly in your code; using MPR_IF_CUSTOMINFOEX instead ensures that the
///proper version, based on the operating system the code in compiled under, is used.
struct MPR_IF_CUSTOMINFOEX0
{
    ///A MPRAPI_OBJECT_HEADER structure that specifies the version of the <b>MPR_IF_CUSTOMINFOEX0</b> structure.
    MPRAPI_OBJECT_HEADER Header;
    ///A value that specifies the tunnel type for which the custom configuration is available. The following values are
    ///supported. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0x0</dt> </dl> </td>
    ///<td width="60%"> No custom configuration available. </td> </tr> <tr> <td width="40%"><a
    ///id="MPRAPI_IF_CUSTOM_CONFIG_FOR_IKEV2_"></a><a id="mprapi_if_custom_config_for_ikev2_"></a><dl>
    ///<dt><b>MPRAPI_IF_CUSTOM_CONFIG_FOR_IKEV2 </b></dt> <dt>0x1</dt> </dl> </td> <td width="60%"> IKEv2 tunnel
    ///specific configuration is available. </td> </tr> </table>
    uint                 dwFlags;
    ///A ROUTER_IKEv2_IF_CUSTOM_CONFIG0 structure that specifies the IKEv2 tunnel configuration parameters.
    ROUTER_IKEv2_IF_CUSTOM_CONFIG0 customIkev2Config;
}

struct MPR_CERT_EKU
{
    uint  dwSize;
    BOOL  IsEKUOID;
    PWSTR pwszEKU;
}

struct VPN_TS_IP_ADDRESS
{
    ushort Type;
union
    {
        in_addr  v4;
        in6_addr v6;
    }
}

struct _MPR_VPN_SELECTOR
{
    MPR_VPN_TS_TYPE   type;
    ubyte             protocolId;
    ushort            portStart;
    ushort            portEnd;
    ushort            tsPayloadId;
    VPN_TS_IP_ADDRESS addrStart;
    VPN_TS_IP_ADDRESS addrEnd;
}

struct MPR_VPN_TRAFFIC_SELECTORS
{
    uint               numTsi;
    uint               numTsr;
    _MPR_VPN_SELECTOR* tsI;
    _MPR_VPN_SELECTOR* tsR;
}

struct ROUTER_IKEv2_IF_CUSTOM_CONFIG2
{
    uint           dwSaLifeTime;
    uint           dwSaDataSize;
    CRYPTOAPI_BLOB certificateName;
    ROUTER_CUSTOM_IKEv2_POLICY0* customPolicy;
    CRYPTOAPI_BLOB certificateHash;
    uint           dwMmSaLifeTime;
    MPR_VPN_TRAFFIC_SELECTORS vpnTrafficSelectors;
}

struct MPR_IF_CUSTOMINFOEX2
{
    MPRAPI_OBJECT_HEADER Header;
    uint                 dwFlags;
    ROUTER_IKEv2_IF_CUSTOM_CONFIG2 customIkev2Config;
}

struct IKEV2_TUNNEL_CONFIG_PARAMS4
{
    uint            dwIdleTimeout;
    uint            dwNetworkBlackoutTime;
    uint            dwSaLifeTime;
    uint            dwSaDataSizeForRenegotiation;
    uint            dwConfigOptions;
    uint            dwTotalCertificates;
    CRYPTOAPI_BLOB* certificateNames;
    CRYPTOAPI_BLOB  machineCertificateName;
    uint            dwEncryptionType;
    ROUTER_CUSTOM_IKEv2_POLICY0* customPolicy;
    uint            dwTotalEkus;
    MPR_CERT_EKU*   certificateEKUs;
    CRYPTOAPI_BLOB  machineCertificateHash;
    uint            dwMmSaLifeTime;
}

struct ROUTER_IKEv2_IF_CUSTOM_CONFIG1
{
    uint           dwSaLifeTime;
    uint           dwSaDataSize;
    CRYPTOAPI_BLOB certificateName;
    ROUTER_CUSTOM_IKEv2_POLICY0* customPolicy;
    CRYPTOAPI_BLOB certificateHash;
}

struct MPR_IF_CUSTOMINFOEX1
{
    MPRAPI_OBJECT_HEADER Header;
    uint                 dwFlags;
    ROUTER_IKEv2_IF_CUSTOM_CONFIG1 customIkev2Config;
}

struct IKEV2_TUNNEL_CONFIG_PARAMS3
{
    uint            dwIdleTimeout;
    uint            dwNetworkBlackoutTime;
    uint            dwSaLifeTime;
    uint            dwSaDataSizeForRenegotiation;
    uint            dwConfigOptions;
    uint            dwTotalCertificates;
    CRYPTOAPI_BLOB* certificateNames;
    CRYPTOAPI_BLOB  machineCertificateName;
    uint            dwEncryptionType;
    ROUTER_CUSTOM_IKEv2_POLICY0* customPolicy;
    uint            dwTotalEkus;
    MPR_CERT_EKU*   certificateEKUs;
    CRYPTOAPI_BLOB  machineCertificateHash;
}

///Gets or sets tunnel parameters for Internet Key Exchange version 2 (IKEv2) devices. Do not use the
///<b>IKEV2_TUNNEL_CONFIG_PARAMS2</b> structure directly in your code; using IKEV2_TUNNEL_CONFIG_PARAMS instead ensures
///that the proper version, based on the operating system the code in compiled under, is used.
struct IKEV2_TUNNEL_CONFIG_PARAMS2
{
    ///A value that specifies the time, in seconds, after which the connection will be disconnected if there is no
    ///traffic.
    uint            dwIdleTimeout;
    ///A value that specifies the retransmission timeout for IKEv2 request packets. IKEv2 expects a response for every
    ///request packet sent, this value specifies the time after which the connection is deleted in case a response is
    ///not received.
    uint            dwNetworkBlackoutTime;
    ///A value that specifies the lifetime, in seconds, of a security association (SA), after which the SA is no longer
    ///valid.
    uint            dwSaLifeTime;
    ///A value that specifies the number of kilobytes that are allowed to be transferred using a SA before it must be
    ///renegotiated.
    uint            dwSaDataSizeForRenegotiation;
    ///Not implemented. Must be set to 0.
    uint            dwConfigOptions;
    ///A value that specifies the number of certificates in <b>certificateNames</b>.
    uint            dwTotalCertificates;
    ///An array of CERT_NAME_BLOB structures that contain X.509 public key infrastructure certificates.
    CRYPTOAPI_BLOB* certificateNames;
    ///The encryption type to be used for IKEv2.
    CRYPTOAPI_BLOB  machineCertificateName;
    ///A value that that specifies the encryption type to be negotiated during the SA negotiation for the IKE2 tunnel
    ///based VPN connections. The <i>dwEncryptionType</i> parameter must have one of the following values. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0</dt> </dl> </td> <td width="60%"> RRAS
    ///will not negotiate encryption. </td> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td width="60%">
    ///RRAS requests encryption during negotiation. Negotiation will succeed even if remote RRAS does not support
    ///encryption. </td> </tr> <tr> <td width="40%"> <dl> <dt>2</dt> </dl> </td> <td width="60%"> RRAS requires
    ///encryption to be negotiated. </td> </tr> <tr> <td width="40%"> <dl> <dt>3</dt> </dl> </td> <td width="60%"> RRAS
    ///requires maximum strength encryption to be negotiated. </td> </tr> </table>
    uint            dwEncryptionType;
    ROUTER_CUSTOM_IKEv2_POLICY0* customPolicy;
}

struct L2TP_TUNNEL_CONFIG_PARAMS2
{
    uint dwIdleTimeout;
    uint dwEncryptionType;
    uint dwSaLifeTime;
    uint dwSaDataSizeForRenegotiation;
    ROUTER_CUSTOM_IKEv2_POLICY0* customPolicy;
    uint dwMmSaLifeTime;
}

struct L2TP_TUNNEL_CONFIG_PARAMS1
{
    uint dwIdleTimeout;
    uint dwEncryptionType;
    uint dwSaLifeTime;
    uint dwSaDataSizeForRenegotiation;
    ROUTER_CUSTOM_IKEv2_POLICY0* customPolicy;
}

///The <b>IKEV2_CONFIG_PARAMS</b> structure is used to get or set parameters for Internet Key Exchange version 2 (IKEv2)
///devices (RFC 4306).
struct IKEV2_CONFIG_PARAMS
{
    ///A value that specifies the number of ports configured on the RRAS server to accept IKEv2 connections.
    uint dwNumPorts;
    ///A value that specifies the type of ports configured on the RRAS server for IKEv2. The following values are
    ///supported: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="MPR_ENABLE_RAS_ON_DEVICE"></a><a id="mpr_enable_ras_on_device"></a><dl>
    ///<dt><b>MPR_ENABLE_RAS_ON_DEVICE</b></dt> </dl> </td> <td width="60%"> Remote Access is enabled for IKEv2. </td>
    ///</tr> </table>
    uint dwPortFlags;
    ///A value that specifies if the user is able to set the tunnel configuration parameters. The following values are
    ///supported: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="MPRAPI_IKEV2_SET_TUNNEL_CONFIG_PARAMS"></a><a id="mprapi_ikev2_set_tunnel_config_params"></a><dl>
    ///<dt><b>MPRAPI_IKEV2_SET_TUNNEL_CONFIG_PARAMS</b></dt> <dt>0x01</dt> </dl> </td> <td width="60%"> If set, the
    ///<b>dwNumPorts</b>, <b>dwPortFlags</b>, and <b>TunnelConfigParams</b> fields are valid. </td> </tr> </table>
    uint dwTunnelConfigParamFlags;
    ///An IKEV2_TUNNEL_CONFIG_PARAMS structure that contains IKEv2 tunnel information.
    IKEV2_TUNNEL_CONFIG_PARAMS4 TunnelConfigParams;
}

///The <b>PPTP_CONFIG_PARAMS</b> structure is used to get and set the device configuration for Point-to-Point Tunneling
///Protocool (PPTP) on a RAS Server.
struct PPTP_CONFIG_PARAMS
{
    ///A value that specifies the number of ports configured on the RRAS server to accept PPTP connections. The maximum
    ///values for <b>dwNumPorts</b> are listed in the following table. The value zero is not allowed. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td width="60%"> Windows
    ///Web Server 2008 </td> </tr> <tr> <td width="40%"> <dl> <dt>1000</dt> </dl> </td> <td width="60%"> Windows Server
    ///2008 Standard </td> </tr> <tr> <td width="40%"> <dl> <dt>30000</dt> </dl> </td> <td width="60%"> Windows Server
    ///2008 Datacenterand Windows Server 2008 Enterprise </td> </tr> </table> <div class="alert"><b>Note</b> If
    ///<b>dwNumPorts</b> contains a value beyond the limit configured in the registry at service start time (the default
    ///is 1000 for Windows Server 2008 Standard and Windows Server 2008 Enterprise), the MprConfigServerGetInfoEx and
    ///MprConfigServerSetInfoEx functions will return <b>ERROR_SUCCESS_REBOOT_REQUIRED</b>.</div> <div> </div>
    uint dwNumPorts;
    ///A value that specifies the type of ports configured on the RRAS server for PPTP. The following values are
    ///supported: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="MPR_ENABLE_RAS_ON_DEVICE"></a><a id="mpr_enable_ras_on_device"></a><dl>
    ///<dt><b>MPR_ENABLE_RAS_ON_DEVICE</b></dt> </dl> </td> <td width="60%"> If set, RAS is enabled on the device. </td>
    ///</tr> <tr> <td width="40%"><a id="MPR_ENABLE_ROUTING_ON_DEVICE"></a><a id="mpr_enable_routing_on_device"></a><dl>
    ///<dt><b>MPR_ENABLE_ROUTING_ON_DEVICE</b></dt> </dl> </td> <td width="60%"> If set, routing is enabled on the
    ///device. </td> </tr> </table>
    uint dwPortFlags;
}

///The <b>L2TP_CONFIG_PARAMS</b> structure is used to get and set the device configuration for Layer 2 Tunneling
///Protocool (L2TP) on a RAS Server.
struct L2TP_CONFIG_PARAMS1
{
    ///A value that specifies the number of ports configured on the RRAS server to accept L2TP connections. The maximum
    ///values for <b>dwNumPorts</b> are listed in the following table. The value zero is not allowed. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td width="60%"> Windows
    ///Web Server 2008 </td> </tr> <tr> <td width="40%"> <dl> <dt>1000</dt> </dl> </td> <td width="60%"> Windows Server
    ///2008 Standard </td> </tr> <tr> <td width="40%"> <dl> <dt>30000</dt> </dl> </td> <td width="60%"> Windows Server
    ///2008 Datacenterand Windows Server 2008 Enterprise </td> </tr> </table> <div class="alert"><b>Note</b> If
    ///<b>dwNumPorts</b> contains a value beyond the limit configured in the registry at service start time (the default
    ///is 1000 for Windows Server 2008 Standard and Windows Server 2008 Enterprise), the MprConfigServerGetInfoEx and
    ///MprConfigServerSetInfoEx functions will return <b>ERROR_SUCCESS_REBOOT_REQUIRED</b>.</div> <div> </div>
    uint dwNumPorts;
    ///A value that specifies the type of ports configured on the RRAS server for L2TP. The following values are
    ///supported: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="MPR_ENABLE_RAS_ON_DEVICE"></a><a id="mpr_enable_ras_on_device"></a><dl>
    ///<dt><b>MPR_ENABLE_RAS_ON_DEVICE</b></dt> </dl> </td> <td width="60%"> If set, RAS is enabled on the device. </td>
    ///</tr> <tr> <td width="40%"><a id="MPR_ENABLE_ROUTING_ON_DEVICE"></a><a id="mpr_enable_routing_on_device"></a><dl>
    ///<dt><b>MPR_ENABLE_ROUTING_ON_DEVICE</b></dt> </dl> </td> <td width="60%"> If set, routing is enabled on the
    ///device. </td> </tr> </table>
    uint dwPortFlags;
    uint dwTunnelConfigParamFlags;
    L2TP_TUNNEL_CONFIG_PARAMS2 TunnelConfigParams;
}

struct GRE_CONFIG_PARAMS0
{
    uint dwNumPorts;
    uint dwPortFlags;
}

///The <b>L2TP_CONFIG_PARAMS</b> structure is used to get and set the device configuration for Layer 2 Tunneling
///Protocool (L2TP) on a RAS Server.
struct L2TP_CONFIG_PARAMS0
{
    ///A value that specifies the number of ports configured on the RRAS server to accept L2TP connections. The maximum
    ///values for <b>dwNumPorts</b> are listed in the following table. The value zero is not allowed. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td width="60%"> Windows
    ///Web Server 2008 </td> </tr> <tr> <td width="40%"> <dl> <dt>1000</dt> </dl> </td> <td width="60%"> Windows Server
    ///2008 Standard </td> </tr> <tr> <td width="40%"> <dl> <dt>30000</dt> </dl> </td> <td width="60%"> Windows Server
    ///2008 Datacenterand Windows Server 2008 Enterprise </td> </tr> </table> <div class="alert"><b>Note</b> If
    ///<b>dwNumPorts</b> contains a value beyond the limit configured in the registry at service start time (the default
    ///is 1000 for Windows Server 2008 Standard and Windows Server 2008 Enterprise), the MprConfigServerGetInfoEx and
    ///MprConfigServerSetInfoEx functions will return <b>ERROR_SUCCESS_REBOOT_REQUIRED</b>.</div> <div> </div>
    uint dwNumPorts;
    ///A value that specifies the type of ports configured on the RRAS server for L2TP. The following values are
    ///supported: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="MPR_ENABLE_RAS_ON_DEVICE"></a><a id="mpr_enable_ras_on_device"></a><dl>
    ///<dt><b>MPR_ENABLE_RAS_ON_DEVICE</b></dt> </dl> </td> <td width="60%"> If set, RAS is enabled on the device. </td>
    ///</tr> <tr> <td width="40%"><a id="MPR_ENABLE_ROUTING_ON_DEVICE"></a><a id="mpr_enable_routing_on_device"></a><dl>
    ///<dt><b>MPR_ENABLE_ROUTING_ON_DEVICE</b></dt> </dl> </td> <td width="60%"> If set, routing is enabled on the
    ///device. </td> </tr> </table>
    uint dwPortFlags;
}

///The <b>SSTP_CERT_INFO</b> structure contains information about a Secure Socket Tunneling Protocool (SSTP) based
///certificate.
struct SSTP_CERT_INFO
{
    ///A value that is <b>TRUE</b> if this is the default mode, and <b>FALSE</b> otherwise. <div
    ///class="alert"><b>Note</b> Default mode is when the administrator has not explicitly configured the device and the
    ///SSTP service automatically chooses a valid certificate.</div> <div> </div>
    BOOL           isDefault;
    ///A CRYPT_HASH_BLOB structure that contains the SSTP based certificate hash. The <b>cbData</b> member contains the
    ///length, in bytes, of the certificate hash in the <b>pbData</b> member. If <b>cbData</b> is zero, the SSTP
    ///certificate configuration is cleaned and the SSTP service automatically chooses a valid certificate. The hashing
    ///algorithm used to calculate <b>pbData</b> is defined by the <b>certAlgorithm</b> member of the SSTP_CONFIG_PARAMS
    ///structure.
    CRYPTOAPI_BLOB certBlob;
}

///The <b>SSTP_CONFIG_PARAMS</b> structure is used to get and set the device configuration for Secure Socket Tunneling
///Protocool (SSTP) on a RAS Server.
struct SSTP_CONFIG_PARAMS
{
    ///A value that specifies the number of ports configured on the RRAS server to accept SSTP connections. The maximum
    ///values for <b>dwNumPorts</b> are listed in the following table. The value zero is not allowed. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td width="60%"> Windows
    ///Web Server 2008 </td> </tr> <tr> <td width="40%"> <dl> <dt>1000</dt> </dl> </td> <td width="60%"> Windows Server
    ///2008 Standard </td> </tr> <tr> <td width="40%"> <dl> <dt>30000</dt> </dl> </td> <td width="60%"> Windows Server
    ///2008 Datacenterand Windows Server 2008 Enterprise </td> </tr> </table> <div class="alert"><b>Note</b> If
    ///<b>dwNumPorts</b> contains a value beyond the limit configured in the registry at service start time (the default
    ///is 1000 for Windows Server 2008 Standard and Windows Server 2008 Enterprise), the MprConfigServerGetInfoEx and
    ///MprConfigServerSetInfoEx functions will return <b>ERROR_SUCCESS_REBOOT_REQUIRED</b>.</div> <div> </div>
    uint           dwNumPorts;
    ///A value that specifies the type of ports configured on the RRAS server for SSTP. The following values are
    ///supported: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="MPR_ENABLE_RAS_ON_DEVICE"></a><a id="mpr_enable_ras_on_device"></a><dl>
    ///<dt><b>MPR_ENABLE_RAS_ON_DEVICE</b></dt> </dl> </td> <td width="60%"> If set, RAS is enabled on the device. </td>
    ///</tr> </table>
    uint           dwPortFlags;
    ///A value that is <b>TRUE</b> if HTTPS is used and <b>FALSE</b> otherwise.
    BOOL           isUseHttps;
    ///A value that specifies the certificate hashing algorithm used. The following values are supported: <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="CALG_SHA_256"></a><a id="calg_sha_256"></a><dl>
    ///<dt><b>CALG_SHA_256</b></dt> </dl> </td> <td width="60%"> 256-bit SHA hashing algorithm </td> </tr> </table>
    uint           certAlgorithm;
    ///An SSTP_CERT_INFO structure that contains the SSTP based certificate hash.
    SSTP_CERT_INFO sstpCertDetails;
}

///The <b>MPRAPI_TUNNEL_CONFIG_PARAMS</b> structure is used to get or set configuration of tunnel parameters on a RAS
///Server.
struct MPRAPI_TUNNEL_CONFIG_PARAMS0
{
    ///A IKEV2_CONFIG_PARAMS structure that contains Internet Key Exchange version 2 (IKEv2) tunnel parameters.
    IKEV2_CONFIG_PARAMS IkeConfigParams;
    ///A PPTP_CONFIG_PARAMS structure that contains Point-to-Point Tunneling Protocol (PPTP) tunnel parameters.
    PPTP_CONFIG_PARAMS  PptpConfigParams;
    ///A L2TP_CONFIG_PARAMS structure that contains Layer 2 Tunneling Protocol (L2TP) tunnel parameters.
    L2TP_CONFIG_PARAMS1 L2tpConfigParams;
    ///A SSTP_CONFIG_PARAMS structure that contains Secure Socket Tunneling Protocol (SSTP) tunnel parameters.
    SSTP_CONFIG_PARAMS  SstpConfigParams;
}

///The <b>MPRAPI_TUNNEL_CONFIG_PARAMS</b> structure is used to get or set configuration of tunnel parameters on a RAS
///Server.
struct MPRAPI_TUNNEL_CONFIG_PARAMS1
{
    ///A IKEV2_CONFIG_PARAMS structure that contains Internet Key Exchange version 2 (IKEv2) tunnel parameters.
    IKEV2_CONFIG_PARAMS IkeConfigParams;
    ///A PPTP_CONFIG_PARAMS structure that contains Point-to-Point Tunneling Protocol (PPTP) tunnel parameters.
    PPTP_CONFIG_PARAMS  PptpConfigParams;
    ///A L2TP_CONFIG_PARAMS structure that contains Layer 2 Tunneling Protocol (L2TP) tunnel parameters.
    L2TP_CONFIG_PARAMS1 L2tpConfigParams;
    ///A SSTP_CONFIG_PARAMS structure that contains Secure Socket Tunneling Protocol (SSTP) tunnel parameters.
    SSTP_CONFIG_PARAMS  SstpConfigParams;
    GRE_CONFIG_PARAMS0  GREConfigParams;
}

///The <b>MPR_SERVER_EX</b> structure is used to get or set the configuration of a RAS server.
struct MPR_SERVER_EX0
{
    ///A MPRAPI_OBJECT_HEADER structure that specifies the version of the <b>MPR_SERVER_EX</b> structure. <div
    ///class="alert"><b>Note</b> The <b>revision</b> member of <b>Header</b> must be
    ///<b>MPRAPI_MPR_SERVER_OBJECT_REVISION_1</b> and <b>type</b> must be
    ///<b>MPRAPI_OBJECT_TYPE_MPR_SERVER_OBJECT</b>.</div> <div> </div>
    MPRAPI_OBJECT_HEADER Header;
    ///A BOOL that is <b>TRUE</b> if the RRAS server is running in LAN-only mode and <b>FALSE</b> if it is functioning
    ///as a router.
    uint                 fLanOnlyMode;
    ///A value that specifies the elapsed time, in seconds, since the RAS server was started.
    uint                 dwUpTime;
    ///A value that specifies the number of ports on the RAS server.
    uint                 dwTotalPorts;
    ///A value that specifies the number of ports currently in use on the RAS server.
    uint                 dwPortsInUse;
    ///Reserved. This value must be zero.
    uint                 Reserved;
    ///A MPRAPI_TUNNEL_CONFIG_PARAMS structure that contains Point-to-Point (PPTP), Secure Socket Tunneling Protocol
    ///(SSTP), Layer 2 Tunneling Protocol (L2TP), and Internet Key version 2 (IKEv2) tunnel configuration information
    ///for the RAS server.
    MPRAPI_TUNNEL_CONFIG_PARAMS0 ConfigParams;
}

///The <b>MPR_SERVER_EX</b> structure is used to get or set the configuration of a RAS server.
struct MPR_SERVER_EX1
{
    ///A MPRAPI_OBJECT_HEADER structure that specifies the version of the <b>MPR_SERVER_EX</b> structure. <div
    ///class="alert"><b>Note</b> The <b>revision</b> member of <b>Header</b> must be
    ///<b>MPRAPI_MPR_SERVER_OBJECT_REVISION_1</b> and <b>type</b> must be
    ///<b>MPRAPI_OBJECT_TYPE_MPR_SERVER_OBJECT</b>.</div> <div> </div>
    MPRAPI_OBJECT_HEADER Header;
    ///A BOOL that is <b>TRUE</b> if the RRAS server is running in LAN-only mode and <b>FALSE</b> if it is functioning
    ///as a router.
    uint                 fLanOnlyMode;
    ///A value that specifies the elapsed time, in seconds, since the RAS server was started.
    uint                 dwUpTime;
    ///A value that specifies the number of ports on the RAS server.
    uint                 dwTotalPorts;
    ///A value that specifies the number of ports currently in use on the RAS server.
    uint                 dwPortsInUse;
    ///Reserved. This value must be zero.
    uint                 Reserved;
    ///A MPRAPI_TUNNEL_CONFIG_PARAMS structure that contains Point-to-Point (PPTP), Secure Socket Tunneling Protocol
    ///(SSTP), Layer 2 Tunneling Protocol (L2TP), and Internet Key version 2 (IKEv2) tunnel configuration information
    ///for the RAS server.
    MPRAPI_TUNNEL_CONFIG_PARAMS1 ConfigParams;
}

///The <b>MPR_SERVER_SET_CONFIG_EX</b> structure is used to get or set the tunnel configuration information of a RAS
///server.
struct MPR_SERVER_SET_CONFIG_EX0
{
    ///A MPRAPI_OBJECT_HEADER structure that specifies the version of the <b>MPR_SERVER_SET_CONFIG_EX</b> structure.
    ///<div class="alert"><b>Note</b> The <b>revision</b> member of <b>Header</b> must be
    ///<b>MPRAPI_MPR_SERVER_SET_CONFIG_OBJECT_REVISION_1</b> and <b>type</b> must be
    ///<b>MPRAPI_OBJECT_TYPE_MPR_SERVER_SET_CONFIG_OBJECT</b>.</div> <div> </div>
    MPRAPI_OBJECT_HEADER Header;
    ///A value that specifies the tunnel type in <b>ConfigParams</b>. The following tunnel types are supported: <table>
    ///<tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="MPRAPI_SET_CONFIG_PROTOCOL_FOR_PPTP_________________"></a><a
    ///id="mprapi_set_config_protocol_for_pptp_________________"></a><dl> <dt><b>MPRAPI_SET_CONFIG_PROTOCOL_FOR_PPTP
    ///</b></dt> </dl> </td> <td width="60%"> Point-to-Point Protocol (PPTP) </td> </tr> <tr> <td width="40%"><a
    ///id="MPRAPI_SET_CONFIG_PROTOCOL_FOR_L2TP_________________"></a><a
    ///id="mprapi_set_config_protocol_for_l2tp_________________"></a><dl> <dt><b>MPRAPI_SET_CONFIG_PROTOCOL_FOR_L2TP
    ///</b></dt> </dl> </td> <td width="60%"> Layer 2 Tunneling Protocol (L2TP) </td> </tr> <tr> <td width="40%"><a
    ///id="MPRAPI_SET_CONFIG_PROTOCOL_FOR_SSTP_________________"></a><a
    ///id="mprapi_set_config_protocol_for_sstp_________________"></a><dl> <dt><b>MPRAPI_SET_CONFIG_PROTOCOL_FOR_SSTP
    ///</b></dt> </dl> </td> <td width="60%"> Secure Socket Tunneling Protocol (SSTP) </td> </tr> <tr> <td
    ///width="40%"><a id="MPRAPI_SET_CONFIG_PROTOCOL_FOR_IKEV2_________________"></a><a
    ///id="mprapi_set_config_protocol_for_ikev2_________________"></a><dl> <dt><b>MPRAPI_SET_CONFIG_PROTOCOL_FOR_IKEV2
    ///</b></dt> </dl> </td> <td width="60%"> Internet Key version 2 (IKEV2) </td> </tr> </table>
    uint                 setConfigForProtocols;
    ///A MPRAPI_TUNNEL_CONFIG_PARAMS structure that contains the tunnel configuration information for the tunnel type
    ///specified in <b>setConfigForProtocols</b>.
    MPRAPI_TUNNEL_CONFIG_PARAMS0 ConfigParams;
}

///The <b>MPR_SERVER_SET_CONFIG_EX</b> structure is used to get or set the tunnel configuration information of a RAS
///server.
struct MPR_SERVER_SET_CONFIG_EX1
{
    ///A MPRAPI_OBJECT_HEADER structure that specifies the version of the <b>MPR_SERVER_SET_CONFIG_EX</b> structure.
    ///<div class="alert"><b>Note</b> The <b>revision</b> member of <b>Header</b> must be
    ///<b>MPRAPI_MPR_SERVER_SET_CONFIG_OBJECT_REVISION_1</b> and <b>type</b> must be
    ///<b>MPRAPI_OBJECT_TYPE_MPR_SERVER_SET_CONFIG_OBJECT</b>.</div> <div> </div>
    MPRAPI_OBJECT_HEADER Header;
    ///A value that specifies the tunnel type in <b>ConfigParams</b>. The following tunnel types are supported: <table>
    ///<tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="MPRAPI_SET_CONFIG_PROTOCOL_FOR_PPTP_________________"></a><a
    ///id="mprapi_set_config_protocol_for_pptp_________________"></a><dl> <dt><b>MPRAPI_SET_CONFIG_PROTOCOL_FOR_PPTP
    ///</b></dt> </dl> </td> <td width="60%"> Point-to-Point Protocol (PPTP) </td> </tr> <tr> <td width="40%"><a
    ///id="MPRAPI_SET_CONFIG_PROTOCOL_FOR_L2TP_________________"></a><a
    ///id="mprapi_set_config_protocol_for_l2tp_________________"></a><dl> <dt><b>MPRAPI_SET_CONFIG_PROTOCOL_FOR_L2TP
    ///</b></dt> </dl> </td> <td width="60%"> Layer 2 Tunneling Protocol (L2TP) </td> </tr> <tr> <td width="40%"><a
    ///id="MPRAPI_SET_CONFIG_PROTOCOL_FOR_SSTP_________________"></a><a
    ///id="mprapi_set_config_protocol_for_sstp_________________"></a><dl> <dt><b>MPRAPI_SET_CONFIG_PROTOCOL_FOR_SSTP
    ///</b></dt> </dl> </td> <td width="60%"> Secure Socket Tunneling Protocol (SSTP) </td> </tr> <tr> <td
    ///width="40%"><a id="MPRAPI_SET_CONFIG_PROTOCOL_FOR_IKEV2_________________"></a><a
    ///id="mprapi_set_config_protocol_for_ikev2_________________"></a><dl> <dt><b>MPRAPI_SET_CONFIG_PROTOCOL_FOR_IKEV2
    ///</b></dt> </dl> </td> <td width="60%"> Internet Key version 2 (IKEV2) </td> </tr> </table>
    uint                 setConfigForProtocols;
    ///A MPRAPI_TUNNEL_CONFIG_PARAMS structure that contains the tunnel configuration information for the tunnel type
    ///specified in <b>setConfigForProtocols</b>.
    MPRAPI_TUNNEL_CONFIG_PARAMS1 ConfigParams;
}

///The <b>AUTH_VALIDATION_EX</b> structure is used for enabling clients to bypass Point-to-Point (PPP) authentication
///during Secure Socket Tunneling Protocol (SSTP) connection establishment.
struct AUTH_VALIDATION_EX
{
    ///A MPRAPI_OBJECT_HEADER structure that specifies the version of the <b>AUTH_VALIDATION_EX</b> structure. <div
    ///class="alert"><b>Note</b> The <b>revision</b> member of <b>Header</b> must be <b>0x01</b> and <b>type</b> must be
    ///<b>MPRAPI_OBJECT_TYPE_AUTH_VALIDATION_OBJECT</b>.</div> <div> </div>
    MPRAPI_OBJECT_HEADER Header;
    ///A handle to the RAS connection for which PPP authentication is being bypassed. This can be a handle returned by
    ///the RasDial or RasEnumConnections function.
    HANDLE               hRasConnection;
    ///A null-terminated Unicode string that contains the name of the user logging on to the connection.
    ushort[257]          wszUserName;
    ///A null-terminated Unicode string that contains the domain on which the connected user is authenticating.
    ushort[16]           wszLogonDomain;
    ///The size, in bytes, of the user authentication information in <b>AuthInfo</b>.
    uint                 AuthInfoSize;
    ///A <b>BYTE</b> array that contains the user authentication information required to bypass PPP authentication
    ///during SSTP connection negotiation.
    ubyte[1]             AuthInfo;
}

///The RAS_UPDATE_CONNECTION structure is used to update an active RAS connection.
struct RAS_UPDATE_CONNECTION
{
    ///A MPRAPI_OBJECT_HEADER structure that specifies the version of the RAS_UPDATE_CONNECTION structure. <div
    ///class="alert"><b>Note</b> The <b>revision</b> member of <b>Header</b> must be <b>0x01</b> and <b>type</b> must be
    ///<b>MPRAPI_OBJECT_TYPE_UPDATE_CONNECTION_OBJECT</b>.</div> <div> </div>
    MPRAPI_OBJECT_HEADER Header;
    ///A value that specifies the new interface index of the Virtual Private Network (VPN) endpoint.
    uint                 dwIfIndex;
    ///A null-terminated Unicode string that contains the new IP address of the local computer in the connection. This
    ///string is of the form "a.b.c.d".
    ushort[65]           wszLocalEndpointAddress;
    ///A null-terminated Unicode string that contains the new IP address of the remote computer in the connection. This
    ///string is of the form "a.b.d.c".
    ushort[65]           wszRemoteEndpointAddress;
}

///The <b>MPRAPI_ADMIN_DLL_CALLBACKS</b> structure is used by the MprAdminInitializeDllEx function to register the
///callback function pointers.
struct MPRAPI_ADMIN_DLL_CALLBACKS
{
    ///A value that represents the version of this structure. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td width="40%"><a id="MPRAPI_ADMIN_DLL_VERSION_1"></a><a id="mprapi_admin_dll_version_1"></a><dl>
    ///<dt><b>MPRAPI_ADMIN_DLL_VERSION_1</b></dt> </dl> </td> <td width="60%"> The RAS_CONNECTION_EX structure and the
    ///callback function pointers that use it as a parameter are not supported by this structure. </td> </tr> <tr> <td
    ///width="40%"><a id="MPRAPI_ADMIN_DLL_VERSION_2"></a><a id="mprapi_admin_dll_version_2"></a><dl>
    ///<dt><b>MPRAPI_ADMIN_DLL_VERSION_2</b></dt> </dl> </td> <td width="60%"> The RAS_CONNECTION_EX structure and the
    ///callback function pointers that use it as a parameter are supported by this structure. </td> </tr> </table>
    ubyte revision;
    ///A function pointer to an instance of the MprAdminGetIpAddressForUser callback. The callback prototype is defined
    ///as: ```cpp typedef DWORD (APIENTRY * PMPRADMINGETIPADDRESSFORUSER)(WCHAR *, WCHAR *, DWORD *, BOOL *); ```
    PMPRADMINGETIPADDRESSFORUSER lpfnMprAdminGetIpAddressForUser;
    ///A function pointer to an instance of the MprAdminReleaseIpAddress callback. The callback prototype is defined as:
    ///```cpp typedef VOID (APIENTRY * PMPRADMINRELEASEIPADRESS)(WCHAR *, WCHAR *, DWORD *); ```
    PMPRADMINRELEASEIPADRESS lpfnMprAdminReleaseIpAddress;
    ///A function pointer to an instance of the MprAdminGetIpv6AddressForUser callback. The callback prototype is
    ///defined as: ```cpp typedef DWORD (APIENTRY * PMPRADMINGETIPV6ADDRESSFORUSER)(WCHAR *, WCHAR *, IN6_ADDR *, BOOL
    ///*); ```
    PMPRADMINGETIPV6ADDRESSFORUSER lpfnMprAdminGetIpv6AddressForUser;
    ///A function pointer to an instance of the MprAdminReleaseIpv6AddressForUser callback. The callback prototype is
    ///defined as: ```cpp typedef VOID (APIENTRY * PMPRADMINRELEASEIPV6ADDRESSFORUSER)(WCHAR *, WCHAR *, IN6_ADDR *);
    ///```
    PMPRADMINRELEASEIPV6ADDRESSFORUSER lpfnMprAdminReleaseIpV6AddressForUser;
    ///A function pointer to an instance of the MprAdminAcceptNewLink callback. The callback prototype is defined as:
    ///```cpp typedef BOOL (APIENTRY * PMPRADMINACCEPTNEWLINK)(RAS_PORT_0 *, RAS_PORT_1 *); ```
    PMPRADMINACCEPTNEWLINK lpfnRasAdminAcceptNewLink;
    ///A function pointer to an instance of the MprAdminLinkHangupNotification callback. The callback prototype is
    ///defined as: ```cpp typedef VOID (APIENTRY * PMPRADMINLINKHANGUPNOTIFICATION)(RAS_PORT_0 *, RAS_PORT_1 *); ```
    PMPRADMINLINKHANGUPNOTIFICATION lpfnRasAdminLinkHangupNotification;
    ///A function pointer to an instance of the MprAdminTerminateDll callback. The callback prototype is defined as:
    ///```cpp typedef DWORD (APIENTRY * PMPRADMINTERMINATEDLL)(); ```
    PMPRADMINTERMINATEDLL lpfnRasAdminTerminateDll;
    ///A function pointer to an instance of the MprAdminAcceptNewConnectionEx callback. The callback prototype is
    ///defined as: ```cpp typedef BOOL (APIENTRY * PMPRADMINACCEPTNEWCONNECTIONEX)(RAS_CONNECTION_EX *); ```
    PMPRADMINACCEPTNEWCONNECTIONEX lpfnRasAdminAcceptNewConnectionEx;
    PMPRADMINACCEPTTUNNELENDPOINTCHANGEEX lpfnRasAdminAcceptEndpointChangeEx;
    ///A function pointer to an instance of the MprAdminAcceptReauthenticationEx callback. The callback prototype is
    ///defined as: ```cpp typedef BOOL (APIENTRY * PMPRADMINACCEPTREAUTHENTICATIONEX)(RAS_CONNECTION_EX *); ```
    PMPRADMINACCEPTREAUTHENTICATIONEX lpfnRasAdminAcceptReauthenticationEx;
    ///A function pointer to an instance of the MprAdminConnectionHangupNotificationEx callback. The callback prototype
    ///is defined as: ```cpp typedef VOID (APIENTRY * PMPRADMINCONNECTIONHANGUPNOTIFICATIONEX)(RAS_CONNECTION_EX *); ```
    PMPRADMINCONNECTIONHANGUPNOTIFICATIONEX lpfnRasAdminConnectionHangupNotificationEx;
    PMPRADMINRASVALIDATEPREAUTHENTICATEDCONNECTIONEX lpfnRASValidatePreAuthenticatedConnectionEx;
}

///The <b>SECURITY_MESSAGE</b> structure is used with the RasSecurityDialogComplete function to indicate the results of
///a RAS security DLL authentication transaction.
struct SECURITY_MESSAGE
{
    ///Indicates whether the RAS server should grant access to the remote user. This member can be one of the following
    ///values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="SECURITYMSG_SUCCESS"></a><a id="securitymsg_success"></a><dl> <dt><b>SECURITYMSG_SUCCESS</b></dt> </dl> </td>
    ///<td width="60%"> The security DLL successfully authenticated the remote user identified by the <b>UserName</b>
    ///member. The RAS server proceeds with its PPP authentication. </td> </tr> <tr> <td width="40%"><a
    ///id="SECURITYMSG_FAILURE"></a><a id="securitymsg_failure"></a><dl> <dt><b>SECURITYMSG_FAILURE</b></dt> </dl> </td>
    ///<td width="60%"> The security DLL denied access to the remote user identified by the <b>UserName</b> member. The
    ///RAS server hangs up the call and records the failed authentication in the event log. </td> </tr> <tr> <td
    ///width="40%"><a id="SECURITYMSG_ERROR"></a><a id="securitymsg_error"></a><dl> <dt><b>SECURITYMSG_ERROR</b></dt>
    ///</dl> </td> <td width="60%"> An error occurred that prevented validation of the remote user. The RAS server hangs
    ///up the call and records the error in the event log. </td> </tr> </table>
    uint      dwMsgId;
    ///Specifies the port handle that the RAS server passed to the security DLL in the RasSecurityDialogBegin call for
    ///this authentication transaction.
    ptrdiff_t hPort;
    ///Specifies an error code. If <b>dwMsgId</b> is SECURITYMSG_ERROR, set <b>dwError</b> to one of the nonzero error
    ///codes defined in Winerror.h or Raserror.h. The RAS server records this error code in the event log. If the
    ///<b>dwMsgId</b> member indicates success or failure, set <b>dwError</b> to zero.
    uint      dwError;
    ///Specifies the name of the remote user if <b>dwMsgId</b> is SECURITYMSG_SUCCESS or SECURITYMSG_FAILURE. This
    ///string can be empty if <b>dwMsgId</b> is SECURITYMSG_ERROR.
    byte[257] UserName;
    ///Specifies the name of the logon domain for the remote user if <b>dwMsgId</b> is SECURITYMSG_SUCCESS or
    ///SECURITYMSG_FAILURE. This string can be empty if <b>dwMsgId</b> is SECURITYMSG_ERROR.
    byte[16]  Domain;
}

///The <b>RAS_SECURITY_INFO</b> structure is used with the RasSecurityDialogGetInfo function to return information about
///the RAS port associated with a RAS security DLL authentication transaction.
struct RAS_SECURITY_INFO
{
    ///Specifies an error code that indicates the state of the last RasSecurityDialogReceive call for the port. If the
    ///receive operation failed, <b>LastError</b> is one of the error codes defined in Raserror.h or Winerror.h.
    ///Otherwise, <b>LastError</b> is one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="SUCCESS"></a><a id="success"></a><dl> <dt><b>SUCCESS</b></dt> </dl> </td> <td
    ///width="60%"> The receive operation has been successfully completed. The <b>BytesReceived</b> member indicates the
    ///number of bytes received. </td> </tr> <tr> <td width="40%"><a id="PENDING"></a><a id="pending"></a><dl>
    ///<dt><b>PENDING</b></dt> </dl> </td> <td width="60%"> The receive operation is pending completion. </td> </tr>
    ///</table>
    uint      LastError;
    ///Specifies the number of bytes received in the most recent RasSecurityDialogReceive operation. This member is
    ///valid only if the value of the <b>LastError</b> member is SUCCESS.
    uint      BytesReceived;
    ///Specifies a null-terminated string that contains the user-friendly display name of the device on the port, such
    ///as Hayes SmartModem 9600.
    byte[129] DeviceName;
}

///The <b>MGM_IF_ENTRY</b> structure describes a router interface. This structure is used in the
///PMGM_CREATION_ALERT_CALLBACK. In the context of this callback, the routing protocol must enable or disable multicast
///forwarding on each interface, notifying the multicast group manager by using the <b>bIsEnabled</b> member.
struct MGM_IF_ENTRY
{
    ///Specifies the index of the interface.
    uint dwIfIndex;
    ///Specifies the address of the next hop that corresponds to the index specified by <b>dwIfIndex</b>. The
    ///<b>dwIfIndex</b> and <b>dwIfNextHopIPAddr</b> members uniquely identify a next hop on point-to-multipoint
    ///interfaces. A point-to-multipoint interface is a connection where one interface connects to multiple networks.
    ///Examples of point-to-multipoint interfaces include non-broadcast multiple access (NBMA) interfaces and the
    ///internal interface on which all dial-up clients connect. For broadcast interfaces (such as Ethernet interfaces)
    ///or point-to-point interfaces, which are identified by only the value of <b>dwIfIndex</b>, specify zero.
    uint dwIfNextHopAddr;
    ///Indicates whether or not IGMP is enabled on this interface. If <b>bIGMP</b> is <b>TRUE</b>, then IGMP is enabled
    ///on this interface. If <b>bIGMP</b> is <b>FALSE</b>, then IGMP is not enabled on this interface.
    BOOL bIGMP;
    ///Indicates whether or not multicast forwarding is enabled on this interface. If <b>bIsEnabled</b> is <b>TRUE</b>,
    ///multicast forwarding is enabled on this interface. If <b>bIsEnabled</b> is <b>FALSE</b>, multicast forwarding is
    ///disabled on this interface.
    BOOL bIsEnabled;
}

///The <b>ROUTING_PROTOCOL_CONFIG</b> structure describes the routing protocol configuration information that is passed
///to the multicast group manager when a protocol registers with the multicast group manager.
struct ROUTING_PROTOCOL_CONFIG
{
    ///Reserved for future use.
    uint              dwCallbackFlags;
    ///Callback into a routing protocol to perform an RPF check.
    PMGM_RPF_CALLBACK pfnRpfCallback;
    ///Callback into a routing protocol to determine the subset of interfaces owned by the routing protocol on which a
    ///multicast packet from a new source or to a new group should be forwarded.
    PMGM_CREATION_ALERT_CALLBACK pfnCreationAlertCallback;
    ///Callback into a routing protocol to notify the protocol that receivers for the specified source and group are no
    ///longer present on an interface owned by other routing protocols.
    PMGM_PRUNE_ALERT_CALLBACK pfnPruneAlertCallback;
    ///Callback into a routing protocol to notify the protocol that new receivers for the specified source and group are
    ///present on an interface owned by another routing protocol.
    PMGM_JOIN_ALERT_CALLBACK pfnJoinAlertCallback;
    ///Callback into a routing protocol to notify the protocol that a packet has been received from the specified source
    ///and for the specified group on the wrong interface.
    PMGM_WRONG_IF_CALLBACK pfnWrongIfCallback;
    ///Callback into a routing protocol to notify the protocol that IGMP has detected new receivers for a group on an
    ///interface.
    PMGM_LOCAL_JOIN_CALLBACK pfnLocalJoinCallback;
    ///Callback into a routing protocol to notify the protocol that IGMP has detected that there are no more receivers
    ///for a group on an interface.
    PMGM_LOCAL_LEAVE_CALLBACK pfnLocalLeaveCallback;
    ///Callback into IGMP to notify IGMP that a protocol is taking or releasing ownership of an interface on which IGMP
    ///is enabled.
    PMGM_DISABLE_IGMP_CALLBACK pfnDisableIgmpCallback;
    ///Callback into IGMP to notify IGMP that a protocol has finished taking or releasing ownership of an interface on
    ///which IGMP is enabled.
    PMGM_ENABLE_IGMP_CALLBACK pfnEnableIgmpCallback;
}

///The <b>SOURCE_GROUP_ENTRY</b> structure describes the entry returned by the group enumeration function
///MgmGroupEnumerationGetNext.
struct SOURCE_GROUP_ENTRY
{
    ///Specifies the source address from which to receive multicast data. Specify zero to receive data from all sources
    ///(a wildcard receiver for a group); otherwise, specify the IP address of the source or source network. To specify
    ///a range of source addresses, specify the source network using <b>dwSourceAddr</b>, and specify a subnet mask
    ///using <b>dwSourceMask</b>.
    uint dwSourceAddr;
    ///Specifies the subnet mask that corresponds to <b>dwSourceAddr</b>. The <b>dwSourceAddr</b> and
    ///<b>dwSourceMask</b> parameters are used together to define a range of sources from which to receive multicast
    ///data. Specify zero for this parameter if zero was specified for <b>dwSourceAddr</b> (a wildcard receiver).
    uint dwSourceMask;
    ///Specifies the multicast group for which to receive data. Specify zero to receive all groups (a wildcard
    ///receiver); otherwise, specify the IP address of the group. To specify a range of group addresses, specify the
    ///group address using <b>dwGroupAddr</b>, and specify a subnet mask using <b>dwGroupMask</b>.
    uint dwGroupAddr;
    ///Specifies the subnet mask that corresponds to <b>dwGroupAddr</b>. The <b>dwGroupAddr</b> and <b>dwGroupMask</b>
    ///parameters are used together to define a range of multicast groups. Specify zero for this parameter if zero was
    ///specified for <b>dwGroupAddr</b> (a wildcard receiver).
    uint dwGroupMask;
}

///The <b>RTM_REGN_PROFILE</b> structure contains information returned during the registration process. The information
///is used for later function calls (such as the maximum number of routes that can be returned by a call to
///RtmGetEnumRoutes).
struct RTM_REGN_PROFILE
{
    ///Specifies the maximum number of equal-cost next hops in a route.
    uint MaxNextHopsInRoute;
    ///Specifies the maximum number of handles that can be returned in one call to RtmGetEnumDests, RtmGetChangedDests,
    ///RtmGetEnumRoutes, or RtmGetListEnumRoutes. The number of handles that can be returned is limited (and
    ///configurable) to improve efficiency and performance of the routing table manager.
    uint MaxHandlesInEnum;
    ///Views supported by this address family.
    uint ViewsSupported;
    ///Number of views.
    uint NumberOfViews;
}

///The RTM_NET_ADDRESS structure is used to communicate address information to the routing table manager for any address
///family. The address family must use only with contiguous address masks that are less than 8 bytes.
struct RTM_NET_ADDRESS
{
    ///Specifies the type of network address for this address (such as IPv4).
    ushort    AddressFamily;
    ///Specifies the number of bits in the network part of the <b>AddrBits</b> bit array (for example, 192.168.0.0 has 8
    ///bits).
    ushort    NumBits;
    ///Specifies an array of bits that form the address prefix.
    ubyte[16] AddrBits;
}

///The <b>RTM_PREF_INFO</b> structure contains the information used when comparing any two routes. The value of the
///<b>Preference</b> member is given more weight than the value of the <b>Metric</b> member.
struct RTM_PREF_INFO
{
    ///Specifies a metric. The metric is specific to a particular routing protocol.
    uint Metric;
    ///Specifies a preference. The preference is determined by the router policy.
    uint Preference;
}

///The <b>RTM_NEXTHOP_LIST</b> structure contains a list of next hops used to determine equal-cost paths in a route.
struct RTM_NEXTHOP_LIST
{
    ///Specifies the number of equal cost next hops in <b>NextHops</b>.
    ushort       NumNextHops;
    ///Array of next-hop handles.
    ptrdiff_t[1] NextHops;
}

///The <b>RTM_DEST_INFO</b> structure is used to exchange destination information with clients registered with the
///routing table manager.
struct RTM_DEST_INFO
{
    ///Handle to the destination.
    ptrdiff_t       DestHandle;
    ///Specifies the destination network address as an address and a mask.
    RTM_NET_ADDRESS DestAddress;
    ///Specifies the last time this destination was updated.
    FILETIME        LastChanged;
    ///Specifies the views to which this destination belongs.
    uint            BelongsToViews;
    ///Indicates the number of ViewInfo structures present in this destination.
    uint            NumberOfViews;
struct
    {
        int       ViewId;
        uint      NumRoutes;
        ptrdiff_t Route;
        ptrdiff_t Owner;
        uint      DestFlags;
        ptrdiff_t HoldRoute;
    }
}

///The <b>RTM_ROUTE_INFO</b> structure is used to exchange route information with the routing table manager. Do not
///change the read-only information.
struct RTM_ROUTE_INFO
{
    ///Handle to the destination that owns the route.
    ptrdiff_t        DestHandle;
    ///Handle to the client that owns this route.
    ptrdiff_t        RouteOwner;
    ///Handle to the neighbor that informed the routing table manager of this route. This member is <b>NULL</b> for a
    ///link-state protocol.
    ptrdiff_t        Neighbour;
    ///Flags the specify the state of this route. The following flags are used. <table> <tr> <th>Constant</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="RTM_ROUTE_STATE_CREATED"></a><a
    ///id="rtm_route_state_created"></a><dl> <dt><b>RTM_ROUTE_STATE_CREATED</b></dt> </dl> </td> <td width="60%"> Route
    ///has been created. </td> </tr> <tr> <td width="40%"><a id="RTM_ROUTE_STATE_DELETING"></a><a
    ///id="rtm_route_state_deleting"></a><dl> <dt><b>RTM_ROUTE_STATE_DELETING</b></dt> </dl> </td> <td width="60%">
    ///Route is being deleted. </td> </tr> <tr> <td width="40%"><a id="RTM_ROUTE_STATE_DELETED"></a><a
    ///id="rtm_route_state_deleted"></a><dl> <dt><b>RTM_ROUTE_STATE_DELETED</b></dt> </dl> </td> <td width="60%"> Route
    ///has been deleted. </td> </tr> </table>
    ubyte            State;
    ///Flags used for compatibility with RTMv1.
    ubyte            Flags1;
    ///Flags used to specify information about the route. The following flags are used. <table> <tr> <th>Constant</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="RTM_ROUTE_FLAGS_ANY_BCAST"></a><a
    ///id="rtm_route_flags_any_bcast"></a><dl> <dt><b>RTM_ROUTE_FLAGS_ANY_BCAST</b></dt> </dl> </td> <td width="60%">
    ///The route is one of the following broadcast types: RTM_ROUTE_FLAGS_LIMITED_BC, RTM_ROUTE_FLAGS_ONES_NETBC,
    ///RTM_ROUTE_FLAGS_ONES_SUBNET_BC, RTM_ROUTE_FLAGS_ZEROS_NETBC, RTM_ROUTE_FLAGS_ZEROS_SUBNETBC </td> </tr> <tr> <td
    ///width="40%"><a id="RTM_ROUTE_FLAGS_ANY_MCAST"></a><a id="rtm_route_flags_any_mcast"></a><dl>
    ///<dt><b>RTM_ROUTE_FLAGS_ANY_MCAST</b></dt> </dl> </td> <td width="60%"> The route is one of the following
    ///multicast types: RTM_ROUTE_FLAGS_MCAST, RTM_ROUTE_FLAGS_LOCAL_MCAST </td> </tr> <tr> <td width="40%"><a
    ///id="RTM_ROUTE_FLAGS_ANY_UNICAST"></a><a id="rtm_route_flags_any_unicast"></a><dl>
    ///<dt><b>RTM_ROUTE_FLAGS_ANY_UNICAST</b></dt> </dl> </td> <td width="60%"> The route is one of the following
    ///unicast types: RTM_ROUTE_FLAGS_LOCAL, RTM_ROUTE_FLAGS_REMOTE, RTM_ROUTE_FLAGS_MYSELF </td> </tr> <tr> <td
    ///width="40%"><a id="RTM_ROUTE_FLAGS_LIMITED_BC"></a><a id="rtm_route_flags_limited_bc"></a><dl>
    ///<dt><b>RTM_ROUTE_FLAGS_LIMITED_BC</b></dt> </dl> </td> <td width="60%"> Indicates that this route is a limited
    ///broadcast address. Packets to this destination should not be forwarded. </td> </tr> <tr> <td width="40%"><a
    ///id="RTM_ROUTE_FLAGS_LOCAL"></a><a id="rtm_route_flags_local"></a><dl> <dt><b>RTM_ROUTE_FLAGS_LOCAL</b></dt> </dl>
    ///</td> <td width="60%"> Indicates a destination is on a directly reachable network. </td> </tr> <tr> <td
    ///width="40%"><a id="RTM_ROUTE_FLAGS_LOCAL_MCAST"></a><a id="rtm_route_flags_local_mcast"></a><dl>
    ///<dt><b>RTM_ROUTE_FLAGS_LOCAL_MCAST</b></dt> </dl> </td> <td width="60%"> Indicates that this route is a route to
    ///a local multicast address. </td> </tr> <tr> <td width="40%"><a id="RTM_ROUTE_FLAGS_MCAST"></a><a
    ///id="rtm_route_flags_mcast"></a><dl> <dt><b>RTM_ROUTE_FLAGS_MCAST</b></dt> </dl> </td> <td width="60%"> Indicates
    ///that this route is a route to a multicast address. </td> </tr> <tr> <td width="40%"><a
    ///id="RTM_ROUTE_FLAGS_MYSELF"></a><a id="rtm_route_flags_myself"></a><dl> <dt><b>RTM_ROUTE_FLAGS_MYSELF</b></dt>
    ///</dl> </td> <td width="60%"> Indicates the destination is one of the router's addresses. </td> </tr> <tr> <td
    ///width="40%"><a id="RTM_ROUTE_FLAGS_NET_BCAST"></a><a id="rtm_route_flags_net_bcast"></a><dl>
    ///<dt><b>RTM_ROUTE_FLAGS_NET_BCAST</b></dt> </dl> </td> <td width="60%"> Flag grouping that contains:
    ///RTM_ROUTE_FLAGS_ONES_NETBC, RTM_ROUTE_FLAGS_ZEROS_NETBC </td> </tr> <tr> <td width="40%"><a
    ///id="RTM_ROUTE_FLAGS_ONES_NETBC"></a><a id="rtm_route_flags_ones_netbc"></a><dl>
    ///<dt><b>RTM_ROUTE_FLAGS_ONES_NETBC</b></dt> </dl> </td> <td width="60%"> Indicates that the destination matches an
    ///interface's <i>all-ones</i> broadcast address. If broadcast forwarding is enabled, packets should be received and
    ///resent out all appropriate interfaces. </td> </tr> <tr> <td width="40%"><a
    ///id="RTM_ROUTE_FLAGS_ONES_SUBNETBC"></a><a id="rtm_route_flags_ones_subnetbc"></a><dl>
    ///<dt><b>RTM_ROUTE_FLAGS_ONES_SUBNETBC</b></dt> </dl> </td> <td width="60%"> Indicates that the destination matches
    ///an interface's all-ones subnet broadcast address. If subnet broadcast forwarding is enabled, packets should be
    ///received and resent out all appropriate interfaces. </td> </tr> <tr> <td width="40%"><a
    ///id="RTM_ROUTE_FLAGS_REMOTE"></a><a id="rtm_route_flags_remote"></a><dl> <dt><b>RTM_ROUTE_FLAGS_REMOTE</b></dt>
    ///</dl> </td> <td width="60%"> Indicates that the destination is not on a directly reachable network. </td> </tr>
    ///<tr> <td width="40%"><a id="RTM_ROUTE_FLAGS_ZEROS_SUBNETBC"></a><a id="rtm_route_flags_zeros_subnetbc"></a><dl>
    ///<dt><b>RTM_ROUTE_FLAGS_ZEROS_SUBNETBC</b></dt> </dl> </td> <td width="60%"> Indicates that the destination
    ///matches an interface's <i>all-zeros</i> subnet broadcast address. If subnet broadcast forwarding is enabled,
    ///packets should be received and resent out all appropriate interfaces. </td> </tr> <tr> <td width="40%"><a
    ///id="RTM_ROUTE_FLAGS_ZEROS_NETBC"></a><a id="rtm_route_flags_zeros_netbc"></a><dl>
    ///<dt><b>RTM_ROUTE_FLAGS_ZEROS_NETBC</b></dt> </dl> </td> <td width="60%"> Indicates that the destination matches
    ///an interface's all-zeros broadcast address. If broadcast forwarding is enabled, packets should be received and
    ///resent out all appropriate interfaces. </td> </tr> </table>
    ushort           Flags;
    ///Specifies the preference and metric information for this route.
    RTM_PREF_INFO    PrefInfo;
    ///Specifies the views in which this route is included.
    uint             BelongsToViews;
    ///Contains the client-specific information for the client that owns this route.
    void*            EntitySpecificInfo;
    ///Specifies a list of equal-cost next hops.
    RTM_NEXTHOP_LIST NextHopsList;
}

///The <b>RTM_NEXTHOP_INFO</b> structure is used to exchange next-hop information with the routing table manager.
struct RTM_NEXTHOP_INFO
{
    ///Specifies the network address for this next hop.
    RTM_NET_ADDRESS NextHopAddress;
    ///Handle to the client that owns this next hop.
    ptrdiff_t       NextHopOwner;
    ///Specifies the outgoing interface index.
    uint            InterfaceIndex;
    ///Flags that indicates the state of this next hop. The following flags are used. <table> <tr> <th>Constant</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="RTM_NEXTHOP_STATE_CREATED"></a><a
    ///id="rtm_nexthop_state_created"></a><dl> <dt><b>RTM_NEXTHOP_STATE_CREATED</b></dt> </dl> </td> <td width="60%">
    ///The next hop has been created. </td> </tr> <tr> <td width="40%"><a id="RTM_NEXTHOP_STATE_DELETED"></a><a
    ///id="rtm_nexthop_state_deleted"></a><dl> <dt><b>RTM_NEXTHOP_STATE_DELETED</b></dt> </dl> </td> <td width="60%">
    ///The next hop has been deleted. </td> </tr> </table>
    ushort          State;
    ///Flags that convey status information for the next hop. The following flags are used. <table> <tr>
    ///<th>Constant</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RTM_NEXTHOP_FLAGS_REMOTE"></a><a
    ///id="rtm_nexthop_flags_remote"></a><dl> <dt><b>RTM_NEXTHOP_FLAGS_REMOTE</b></dt> </dl> </td> <td width="60%"> This
    ///next hop points to a remote destination that is not directly reachable. To obtain the complete path, the client
    ///must perform a recursive lookup. </td> </tr> <tr> <td width="40%"><a id="RTM_NEXTHOP_FLAGS_DOWN"></a><a
    ///id="rtm_nexthop_flags_down"></a><dl> <dt><b>RTM_NEXTHOP_FLAGS_DOWN</b></dt> </dl> </td> <td width="60%"> This
    ///flag is reserved for future use. </td> </tr> </table>
    ushort          Flags;
    ///Contains information specific to the client that owns this next hop.
    void*           EntitySpecificInfo;
    ///Handle to the destination with the indirect next-hop address. This member is only valid when the <b>Flags</b>
    ///member is set to RTM_NEXTHOP_FLAGS_REMOTE. This cached handle can prevent multiple lookups for this indirect next
    ///hop.
    ptrdiff_t       RemoteNextHop;
}

///The <b>RTM_ENTITY_ID</b> structure is used to uniquely identify a client to the routing table manager. The protocol
///identifier and the instance identifier are the values that are used to uniquely identify a client.
struct RTM_ENTITY_ID
{
union
    {
struct
        {
            uint EntityProtocolId;
            uint EntityInstanceId;
        }
        ulong EntityId;
    }
}

///The <b>RTM_ENTITY_INFO</b> structure is used to exchange client information with the routing table manager.
struct RTM_ENTITY_INFO
{
    ///Specifies the instance of the routing table manager with which the client registered.
    ushort        RtmInstanceId;
    ///Specifies the address family to which the client belongs.
    ushort        AddressFamily;
    ///Specifies the identifier that uniquely identifies a client.
    RTM_ENTITY_ID EntityId;
}

///The <b>RTM_ENTITY_METHOD_INPUT</b> structure is used to pass information to a client when invoking its method.
struct RTM_ENTITY_METHOD_INPUT
{
    ///Specifies the method.
    uint     MethodType;
    ///Specifies the size, in bytes, of <b>InputData</b>.
    uint     InputSize;
    ///Buffer for input data for the method.
    ubyte[1] InputData;
}

///The <b>RTM_ENTITY_METHOD_OUTPUT</b> structure is used to pass information to the calling client when the routing
///table manager invokes a method.
struct RTM_ENTITY_METHOD_OUTPUT
{
    ///Specifies the method identifier.
    uint     MethodType;
    ///Receives the status of the method after execution.
    uint     MethodStatus;
    ///Specifies the size, in bytes, of <b>OutputData</b>.
    uint     OutputSize;
    ///Buffer for data returned by the method.
    ubyte[1] OutputData;
}

///The <b>RTM_ENTITY_EXPORT_METHODS</b> structure contains the set of methods exported by a client.
struct RTM_ENTITY_EXPORT_METHODS
{
    ///Specifies the number of methods exported by the client in the <b>Methods</b> member.
    uint         NumMethods;
    ///Specifies which methods the client is exporting.
    ptrdiff_t[1] Methods;
}

// Functions

///The <b>RasDial</b> function establishes a RAS connection between a RAS client and a RAS server. The connection data
///includes callback and user-authentication information.
///Params:
///    arg1 = Pointer to a RASDIALEXTENSIONS structure that specifies a set of <b>RasDial</b> extended features to enable. Set
///           this parameter to <b>NULL</b> if there is not a need to enable these features.
///    arg2 = Pointer to a null-terminated string that specifies the full path and file name of a phone-book (PBK) file. If
///           this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book file
///           is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up Networking</b>
///           dialog box.
///    arg3 = Pointer to a RASDIALPARAMS structure that specifies calling parameters for the RAS connection. Use the
///           RasGetEntryDialParams function to retrieve a copy of this structure for a particular phone-book entry. The caller
///           must set the RASDIALPARAMS structure's <b>dwSize</b> member to sizeof(<b>RASDIALPARAMS</b>) to identify the
///           version of the structure being passed. If the <b>szPhoneNumber</b> member of the RASDIALPARAMS structure is an
///           empty string, <b>RasDial</b> uses the phone number stored in the phone-book entry.
///    arg4 = Specifies the nature of the <i>lpvNotifier</i> parameter. If <i>lpvNotifier</i> is <b>NULL</b>,
///           <i>dwNotifierType</i> is ignored. If <i>lpvNotifier</i> is not <b>NULL</b>, set <i>dwNotifierType</i> to one of
///           the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl>
///           <dt><b>0</b></dt> </dl> </td> <td width="60%"> The <i>lpvNotifier</i> parameter points to a RasDialFunc callback
///           function. </td> </tr> <tr> <td width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td width="60%"> The
///           <i>lpvNotifier</i> parameter points to a RasDialFunc1 callback function. </td> </tr> <tr> <td width="40%"><a
///           id="2"></a><dl> <dt><b>2</b></dt> </dl> </td> <td width="60%"> The <i>lpvNotifier</i> parameter points to a
///           RasDialFunc2 callback function. </td> </tr> </table>
///    arg5 = Specifies a window handle or a RasDialFunc, RasDialFunc1, or RasDialFunc2 callback function to receive
///           <b>RasDial</b> event notifications. The <i>dwNotifierType</i> parameter specifies the nature of
///           <i>lpvNotifier</i>. Please refer to its description preceding for further detail. If this parameter is not
///           <b>NULL</b>, <b>RasDial</b> sends the window a message, or calls the callback function, for each <b>RasDial</b>
///           event. Additionally, the <b>RasDial</b> call operates asynchronously: <b>RasDial</b> returns immediately, before
///           the connection is established, and communicates its progress via the window or callback function. If
///           <i>lpvNotifier</i> is <b>NULL</b>, the <b>RasDial</b> call operates synchronously: <b>RasDial</b> does not return
///           until the connection attempt has completed successfully or failed. If <i>lpvNotifier</i> is not <b>NULL</b>,
///           notifications to the window or callback function can occur at any time after the initial call to <b>RasDial</b>.
///           Notifications end when one of the following events occurs: <ul> <li>The connection is established. In other
///           words, the RAS connection state is RASCS_Connected.</li> <li>The connection fails. In other words, <i>dwError</i>
///           is nonzero.</li> <li> RasHangUp is called on the connection.</li> </ul> The callback notifications are made in
///           the context of a thread captured during the initial call to <b>RasDial</b>.
///    arg6 = Pointer to a variable of type <b>HRASCONN</b>. Set the <b>HRASCONN</b> variable to <b>NULL</b> before calling
///           <b>RasDial</b>. If <b>RasDial</b> succeeds, it stores a handle to the RAS connection into <i>*lphRasConn</i>.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b> and a handle to the RAS connection is returned
///    in the variable pointed to by <i>lphRasConn</i>. If the function fails, the return value is from Routing and
///    Remote Access Error Codes or Winerror.h.
///    
@DllImport("RASAPI32")
uint RasDialA(tagRASDIALEXTENSIONS* param0, const(PSTR) param1, tagRASDIALPARAMSA* param2, uint param3, 
              void* param4, HRASCONN__** param5);

///The <b>RasDial</b> function establishes a RAS connection between a RAS client and a RAS server. The connection data
///includes callback and user-authentication information.
///Params:
///    arg1 = Pointer to a RASDIALEXTENSIONS structure that specifies a set of <b>RasDial</b> extended features to enable. Set
///           this parameter to <b>NULL</b> if there is not a need to enable these features.
///    arg2 = Pointer to a null-terminated string that specifies the full path and file name of a phone-book (PBK) file. If
///           this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book file
///           is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up Networking</b>
///           dialog box.
///    arg3 = Pointer to a RASDIALPARAMS structure that specifies calling parameters for the RAS connection. Use the
///           RasGetEntryDialParams function to retrieve a copy of this structure for a particular phone-book entry. The caller
///           must set the RASDIALPARAMS structure's <b>dwSize</b> member to sizeof(<b>RASDIALPARAMS</b>) to identify the
///           version of the structure being passed. If the <b>szPhoneNumber</b> member of the RASDIALPARAMS structure is an
///           empty string, <b>RasDial</b> uses the phone number stored in the phone-book entry.
///    arg4 = Specifies the nature of the <i>lpvNotifier</i> parameter. If <i>lpvNotifier</i> is <b>NULL</b>,
///           <i>dwNotifierType</i> is ignored. If <i>lpvNotifier</i> is not <b>NULL</b>, set <i>dwNotifierType</i> to one of
///           the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl>
///           <dt><b>0</b></dt> </dl> </td> <td width="60%"> The <i>lpvNotifier</i> parameter points to a RasDialFunc callback
///           function. </td> </tr> <tr> <td width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td width="60%"> The
///           <i>lpvNotifier</i> parameter points to a RasDialFunc1 callback function. </td> </tr> <tr> <td width="40%"><a
///           id="2"></a><dl> <dt><b>2</b></dt> </dl> </td> <td width="60%"> The <i>lpvNotifier</i> parameter points to a
///           RasDialFunc2 callback function. </td> </tr> </table>
///    arg5 = Specifies a window handle or a RasDialFunc, RasDialFunc1, or RasDialFunc2 callback function to receive
///           <b>RasDial</b> event notifications. The <i>dwNotifierType</i> parameter specifies the nature of
///           <i>lpvNotifier</i>. Please refer to its description preceding for further detail. If this parameter is not
///           <b>NULL</b>, <b>RasDial</b> sends the window a message, or calls the callback function, for each <b>RasDial</b>
///           event. Additionally, the <b>RasDial</b> call operates asynchronously: <b>RasDial</b> returns immediately, before
///           the connection is established, and communicates its progress via the window or callback function. If
///           <i>lpvNotifier</i> is <b>NULL</b>, the <b>RasDial</b> call operates synchronously: <b>RasDial</b> does not return
///           until the connection attempt has completed successfully or failed. If <i>lpvNotifier</i> is not <b>NULL</b>,
///           notifications to the window or callback function can occur at any time after the initial call to <b>RasDial</b>.
///           Notifications end when one of the following events occurs: <ul> <li>The connection is established. In other
///           words, the RAS connection state is RASCS_Connected.</li> <li>The connection fails. In other words, <i>dwError</i>
///           is nonzero.</li> <li> RasHangUp is called on the connection.</li> </ul> The callback notifications are made in
///           the context of a thread captured during the initial call to <b>RasDial</b>.
///    arg6 = Pointer to a variable of type <b>HRASCONN</b>. Set the <b>HRASCONN</b> variable to <b>NULL</b> before calling
///           <b>RasDial</b>. If <b>RasDial</b> succeeds, it stores a handle to the RAS connection into <i>*lphRasConn</i>.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b> and a handle to the RAS connection is returned
///    in the variable pointed to by <i>lphRasConn</i>. If the function fails, the return value is from Routing and
///    Remote Access Error Codes or Winerror.h.
///    
@DllImport("RASAPI32")
uint RasDialW(tagRASDIALEXTENSIONS* param0, const(PWSTR) param1, tagRASDIALPARAMSW* param2, uint param3, 
              void* param4, HRASCONN__** param5);

///The <b>RasEnumConnections</b> function lists all active RAS connections. It returns each connection's handle and
///phone-book entry name.
///Params:
///    arg1 = Pointer to a buffer that receives, on output, an array of RASCONN structures, one for each RAS connection. On
///           input, an application must set the <b>dwSize</b> member of the first RASCONN structure in the buffer to
///           sizeof(<b>RASCONN</b>) in order to identify the version of the structure being passed.
///    arg2 = Pointer to a variable that, on input, contains the size, in bytes, of the buffer specified by <i>lprasconn</i>.
///           On output, the function sets this variable to the number of bytes required to enumerate the RAS connections. <div
///           class="alert"><b>Note</b> <p class="note">To determine the required buffer size, call <b>RasEnumConnections</b>
///           with <i>lprasconn</i> set to <b>NULL</b>. The variable pointed to by <i>lpcb</i> should be set to zero. The
///           function will return the required buffer size in <i>lpcb</i> and an error code of <b>ERROR_BUFFER_TOO_SMALL</b>.
///           </div> <div> </div>
///    arg3 = Pointer to a variable that receives the number of RASCONN structures written to the buffer specified by
///           <i>lprasconn</i>.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    from Routing and Remote Access Error Codes or Winerror.h. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUFFER_TOO_SMALL</b></dt> </dl> </td> <td width="60%"> The
///    <i>lprasconn</i> buffer is not large enough. The <i>lpcb</i>parameter is less than the <b>dwSize</b> member in
///    the <i>lprasconn</i>parameter which is should be set prior to calling the function. The function returns the
///    required buffer size in the variable pointed to by <i>lpcb</i>. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasEnumConnectionsA(tagRASCONNA* param0, uint* param1, uint* param2);

///The <b>RasEnumConnections</b> function lists all active RAS connections. It returns each connection's handle and
///phone-book entry name.
///Params:
///    arg1 = Pointer to a buffer that receives, on output, an array of RASCONN structures, one for each RAS connection. On
///           input, an application must set the <b>dwSize</b> member of the first RASCONN structure in the buffer to
///           sizeof(<b>RASCONN</b>) in order to identify the version of the structure being passed.
///    arg2 = Pointer to a variable that, on input, contains the size, in bytes, of the buffer specified by <i>lprasconn</i>.
///           On output, the function sets this variable to the number of bytes required to enumerate the RAS connections. <div
///           class="alert"><b>Note</b> <p class="note">To determine the required buffer size, call <b>RasEnumConnections</b>
///           with <i>lprasconn</i> set to <b>NULL</b>. The variable pointed to by <i>lpcb</i> should be set to zero. The
///           function will return the required buffer size in <i>lpcb</i> and an error code of <b>ERROR_BUFFER_TOO_SMALL</b>.
///           </div> <div> </div>
///    arg3 = Pointer to a variable that receives the number of RASCONN structures written to the buffer specified by
///           <i>lprasconn</i>.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    from Routing and Remote Access Error Codes or Winerror.h. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUFFER_TOO_SMALL</b></dt> </dl> </td> <td width="60%"> The
///    <i>lprasconn</i> buffer is not large enough. The <i>lpcb</i>parameter is less than the <b>dwSize</b> member in
///    the <i>lprasconn</i>parameter which is should be set prior to calling the function. The function returns the
///    required buffer size in the variable pointed to by <i>lpcb</i>. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasEnumConnectionsW(tagRASCONNW* param0, uint* param1, uint* param2);

///The <b>RasEnumEntries</b> function lists all entry names in a remote access phone book.
///Params:
///    arg1 = Reserved; must be <b>NULL</b>.
///    arg2 = Pointer to a null-terminated string that specifies the full path and file name of a phone-book (PBK) file. If
///           this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book file
///           is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up Networking</b>
///           dialog box. If this parameter is <b>NULL</b>, the entries are enumerated from all the remote access phone-book
///           files in the AllUsers profile and the user's profile.
///    arg3 = Pointer to a buffer that, on output, receives an array of RASENTRYNAME structures, one for each phone-book entry.
///           On input, an application must set the <b>dwSize</b> member of the first RASENTRYNAME structure in the buffer to
///           sizeof(<b>RASENTRYNAME</b>) in order to identify the version of the structure being passed.
///    arg4 = Pointer to a variable that, on input, contains the size, in bytes, of the buffer specified by
///           <i>lprasentryname</i>. Pointer to a variable that, on output, contains the size, in bytes, of the array of
///           RASENTRYNAME structures required for the phone-book entries. <b>Windows Vista or later: </b>To determine the
///           required buffer size, call <b>RasEnumEntries</b> with <i>lprasentryname</i> set to <b>NULL</b>. The variable
///           pointed to by <i>lpcb</i> should be set to zero. The function will return the required buffer size in <i>lpcb</i>
///           and an error code of <b>ERROR_BUFFER_TOO_SMALL</b>.
///    arg5 = Pointer to a variable that receives to the number of phone-book entries written to the buffer specified by
///           <i>lprasentryname</i>.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUFFER_TOO_SMALL</b></dt>
///    </dl> </td> <td width="60%"> The <i>lprasentryname</i> buffer is not large enough. The <i>lpcb</i>parameter is
///    less than the <b>dwSize</b> member in the <i>lprasentryname</i>parameter which should be set prior to calling the
///    function. The function returns the required buffer size in the variable pointed to by <i>lpcb</i>. <b>Windows
///    Vista or later: </b>The <i>lprasentryname</i> buffer may be set to <b>NULL</b> and the variable pointed to by
///    <i>lpcb</i> may be set to zero. The function will return the required buffer size in the variable pointed to by
///    <i>lpcb</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_SIZE</b></dt> </dl> </td> <td
///    width="60%"> The value of <b>dwSize</b> in the RASENTRYNAME structure pointed to by <i>lprasentryname</i>,
///    specifies a version of the structure that is not supported on the current platform. For example, on Windows 95,
///    <b>RasEnumEntries</b> returns this error if <b>dwSize</b> indicates that RASENTRYNAME includes the <b>dwFlags</b>
///    and <b>szPhonebookPath</b> members, since these members are not supported on Windows 95 (they are supported only
///    on Windows 2000 and later). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl>
///    </td> <td width="60%"> The function could not allocate sufficient memory to complete the operation. </td> </tr>
///    </table>
///    
@DllImport("RASAPI32")
uint RasEnumEntriesA(const(PSTR) param0, const(PSTR) param1, tagRASENTRYNAMEA* param2, uint* param3, uint* param4);

///The <b>RasEnumEntries</b> function lists all entry names in a remote access phone book.
///Params:
///    arg1 = Reserved; must be <b>NULL</b>.
///    arg2 = Pointer to a null-terminated string that specifies the full path and file name of a phone-book (PBK) file. If
///           this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book file
///           is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up Networking</b>
///           dialog box. If this parameter is <b>NULL</b>, the entries are enumerated from all the remote access phone-book
///           files in the AllUsers profile and the user's profile.
///    arg3 = Pointer to a buffer that, on output, receives an array of RASENTRYNAME structures, one for each phone-book entry.
///           On input, an application must set the <b>dwSize</b> member of the first RASENTRYNAME structure in the buffer to
///           sizeof(<b>RASENTRYNAME</b>) in order to identify the version of the structure being passed.
///    arg4 = Pointer to a variable that, on input, contains the size, in bytes, of the buffer specified by
///           <i>lprasentryname</i>. Pointer to a variable that, on output, contains the size, in bytes, of the array of
///           RASENTRYNAME structures required for the phone-book entries. <b>Windows Vista or later: </b>To determine the
///           required buffer size, call <b>RasEnumEntries</b> with <i>lprasentryname</i> set to <b>NULL</b>. The variable
///           pointed to by <i>lpcb</i> should be set to zero. The function will return the required buffer size in <i>lpcb</i>
///           and an error code of <b>ERROR_BUFFER_TOO_SMALL</b>.
///    arg5 = Pointer to a variable that receives to the number of phone-book entries written to the buffer specified by
///           <i>lprasentryname</i>.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUFFER_TOO_SMALL</b></dt>
///    </dl> </td> <td width="60%"> The <i>lprasentryname</i> buffer is not large enough. The <i>lpcb</i>parameter is
///    less than the <b>dwSize</b> member in the <i>lprasentryname</i>parameter which should be set prior to calling the
///    function. The function returns the required buffer size in the variable pointed to by <i>lpcb</i>. <b>Windows
///    Vista or later: </b>The <i>lprasentryname</i> buffer may be set to <b>NULL</b> and the variable pointed to by
///    <i>lpcb</i> may be set to zero. The function will return the required buffer size in the variable pointed to by
///    <i>lpcb</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_SIZE</b></dt> </dl> </td> <td
///    width="60%"> The value of <b>dwSize</b> in the RASENTRYNAME structure pointed to by <i>lprasentryname</i>,
///    specifies a version of the structure that is not supported on the current platform. For example, on Windows 95,
///    <b>RasEnumEntries</b> returns this error if <b>dwSize</b> indicates that RASENTRYNAME includes the <b>dwFlags</b>
///    and <b>szPhonebookPath</b> members, since these members are not supported on Windows 95 (they are supported only
///    on Windows 2000 and later). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl>
///    </td> <td width="60%"> The function could not allocate sufficient memory to complete the operation. </td> </tr>
///    </table>
///    
@DllImport("RASAPI32")
uint RasEnumEntriesW(const(PWSTR) param0, const(PWSTR) param1, tagRASENTRYNAMEW* param2, uint* param3, 
                     uint* param4);

///The <b>RasGetConnectStatus</b> function retrieves information on the current status of the specified remote access
///connection. An application can use this call to determine when an asynchronous RasDial call is complete.
///Params:
///    arg1 = Specifies the remote access connection for which to retrieve the status. This handle must have been obtained from
///           RasDial or RasEnumConnections.
///    arg2 = Pointer to the RASCONNSTATUS structure that, on output, receives the status information. On input, set the
///           <b>dwSize</b> member of the structure to sizeof(RASCONNSTATUS) in order to identify the version of the structure
///           being passed.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt>
///    </dl> </td> <td width="60%"> The function could not allocate sufficient memory to complete the operation. </td>
///    </tr> </table>
///    
@DllImport("RASAPI32")
uint RasGetConnectStatusA(HRASCONN__* param0, tagRASCONNSTATUSA* param1);

///The <b>RasGetConnectStatus</b> function retrieves information on the current status of the specified remote access
///connection. An application can use this call to determine when an asynchronous RasDial call is complete.
///Params:
///    arg1 = Specifies the remote access connection for which to retrieve the status. This handle must have been obtained from
///           RasDial or RasEnumConnections.
///    arg2 = Pointer to the RASCONNSTATUS structure that, on output, receives the status information. On input, set the
///           <b>dwSize</b> member of the structure to sizeof(RASCONNSTATUS) in order to identify the version of the structure
///           being passed.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt>
///    </dl> </td> <td width="60%"> The function could not allocate sufficient memory to complete the operation. </td>
///    </tr> </table>
///    
@DllImport("RASAPI32")
uint RasGetConnectStatusW(HRASCONN__* param0, tagRASCONNSTATUSW* param1);

///The <b>RasGetErrorString</b> function obtains an error message string for a specified RAS error value.
///Params:
///    ResourceId = Specifies the error value of interest. These are values returned by one of the RAS functions: those listed in the
///                 RasError.h header file.
///    lpszString = Pointer to a buffer that receives the error string. This parameter must not be <b>NULL</b>.
///    InBufSize = Specifies the size, in characters, of the buffer pointed to by <i>lpszErrorString</i>.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. There is no
///    GetLastError information set by the <b>RasGetErrorString</b> function. <table> <tr> <th>Value</th>
///    <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> An invalid parameter was passed into the function. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasGetErrorStringA(uint ResourceId, PSTR lpszString, uint InBufSize);

///The <b>RasGetErrorString</b> function obtains an error message string for a specified RAS error value.
///Params:
///    ResourceId = Specifies the error value of interest. These are values returned by one of the RAS functions: those listed in the
///                 RasError.h header file.
///    lpszString = Pointer to a buffer that receives the error string. This parameter must not be <b>NULL</b>.
///    InBufSize = Specifies the size, in characters, of the buffer pointed to by <i>lpszErrorString</i>.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. There is no
///    GetLastError information set by the <b>RasGetErrorString</b> function. <table> <tr> <th>Value</th>
///    <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> An invalid parameter was passed into the function. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasGetErrorStringW(uint ResourceId, PWSTR lpszString, uint InBufSize);

///The <b>RasHangUp</b> function terminates a remote access connection. The connection is specified with a RAS
///connection handle. The function releases all RASAPI32.DLL resources associated with the handle.
///Params:
///    Arg1 = Specifies the remote access connection to terminate. This is a handle returned from a previous call to RasDial or
///           RasEnumConnections.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl>
///    </td> <td width="60%"> The handle specified in <i>hrasconn</i> is invalid. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasHangUpA(HRASCONN__* param0);

///The <b>RasHangUp</b> function terminates a remote access connection. The connection is specified with a RAS
///connection handle. The function releases all RASAPI32.DLL resources associated with the handle.
///Params:
///    Arg1 = Specifies the remote access connection to terminate. This is a handle returned from a previous call to RasDial or
///           RasEnumConnections.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl>
///    </td> <td width="60%"> The handle specified in <i>hrasconn</i> is invalid. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasHangUpW(HRASCONN__* param0);

///The <b>RasGetProjectionInfo</b> function obtains information about a remote access projection operation for a
///specified remote access component protocol.
///Params:
///    arg1 = Handle to the remote access connection of interest. An application obtains a RAS connection handle from the
///           RasDial or RasEnumConnections function.
///    arg2 = Specifies the RASPROJECTION enumerated type value that identifies the protocol of interest.
///    arg3 = Pointer to a buffer that receives the information specified by the <i>rasprojection</i> parameter. The
///           information is in a structure appropriate to the <i>rasprojection</i> value. <table> <tr> <th>rasprojection
///           value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RASP_Amb"></a><a id="rasp_amb"></a><a
///           id="RASP_AMB"></a><dl> <dt><b>RASP_Amb</b></dt> </dl> </td> <td width="60%"> RASAMB <div
///           class="alert"><b>Note</b> Supported on Windows 2000 or earlier.</div> <div> </div> </td> </tr> <tr> <td
///           width="40%"><a id="RASP_PppCcp"></a><a id="rasp_pppccp"></a><a id="RASP_PPPCCP"></a><dl>
///           <dt><b>RASP_PppCcp</b></dt> </dl> </td> <td width="60%"> RASPPPCCP <div class="alert"><b>Note</b> Supported on
///           Windows 2000 or later.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a id="RASP_PppIp"></a><a
///           id="rasp_pppip"></a><a id="RASP_PPPIP"></a><dl> <dt><b>RASP_PppIp</b></dt> </dl> </td> <td width="60%"> RASPPPIP
///           </td> </tr> <tr> <td width="40%"><a id="RASP_PppIpv6"></a><a id="rasp_pppipv6"></a><a id="RASP_PPPIPV6"></a><dl>
///           <dt><b>RASP_PppIpv6</b></dt> </dl> </td> <td width="60%"> RASPPPIPV6 <div class="alert"><b>Note</b> Supported on
///           Windows Vista or later.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a id="RASP_PppIpx"></a><a
///           id="rasp_pppipx"></a><a id="RASP_PPPIPX"></a><dl> <dt><b>RASP_PppIpx</b></dt> </dl> </td> <td width="60%">
///           RASPPPIPX <div class="alert"><b>Note</b> Not supported on 64-bit Microsoft Windows.</div> <div> </div> </td>
///           </tr> <tr> <td width="40%"><a id="RASP_PppLcp"></a><a id="rasp_ppplcp"></a><a id="RASP_PPPLCP"></a><dl>
///           <dt><b>RASP_PppLcp</b></dt> </dl> </td> <td width="60%"> RASPPPLCP <div class="alert"><b>Note</b> Supported on
///           Windows 2000 or later.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a id="RASP_PppNbf"></a><a
///           id="rasp_pppnbf"></a><a id="RASP_PPPNBF"></a><dl> <dt><b>RASP_PppNbf</b></dt> </dl> </td> <td width="60%">
///           RASPPPNBF <div class="alert"><b>Note</b> Supported on Windows 2000 or earlier.</div> <div> </div> </td> </tr>
///           <tr> <td width="40%"><a id="RASP_Slip"></a><a id="rasp_slip"></a><a id="RASP_SLIP"></a><dl>
///           <dt><b>RASP_Slip</b></dt> </dl> </td> <td width="60%"> RASPSLIP <div class="alert"><b>Note</b> Supported on
///           Windows Server 2003 or earlier.</div> <div> </div> </td> </tr> </table>
///    arg4 = Pointer to a variable that, on input, specifies the size, in bytes, of the buffer pointed to by
///           <i>lpprojection</i>. On output, this variable receives the size, in bytes, of the <i>lpprojection</i> buffer.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUFFER_TOO_SMALL</b></dt>
///    </dl> </td> <td width="60%"> The buffer pointed to by <i>lpprojection</i> is not large enough to contain the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td>
///    <td width="60%"> The <i>hrasconn</i> parameter is not a valid handle. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the parameters is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_SIZE</b></dt> </dl> </td> <td width="60%"> The
///    <b>dwSize</b> member of the structure pointed to by <i>lpprojection</i> specifies an invalid size. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_PROTOCOL_NOT_CONFIGURED</b></dt> </dl> </td> <td width="60%"> The control
///    protocol for which information was requested neither succeeded nor failed, because the connection's phone-book
///    entry did not require that an attempt to negotiate the protocol be made. This is a RAS error code. </td> </tr>
///    </table>
///    
@DllImport("RASAPI32")
uint RasGetProjectionInfoA(HRASCONN__* param0, tagRASPROJECTION param1, void* param2, uint* param3);

///The <b>RasGetProjectionInfo</b> function obtains information about a remote access projection operation for a
///specified remote access component protocol.
///Params:
///    arg1 = Handle to the remote access connection of interest. An application obtains a RAS connection handle from the
///           RasDial or RasEnumConnections function.
///    arg2 = Specifies the RASPROJECTION enumerated type value that identifies the protocol of interest.
///    arg3 = Pointer to a buffer that receives the information specified by the <i>rasprojection</i> parameter. The
///           information is in a structure appropriate to the <i>rasprojection</i> value. <table> <tr> <th>rasprojection
///           value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RASP_Amb"></a><a id="rasp_amb"></a><a
///           id="RASP_AMB"></a><dl> <dt><b>RASP_Amb</b></dt> </dl> </td> <td width="60%"> RASAMB <div
///           class="alert"><b>Note</b> Supported on Windows 2000 or earlier.</div> <div> </div> </td> </tr> <tr> <td
///           width="40%"><a id="RASP_PppCcp"></a><a id="rasp_pppccp"></a><a id="RASP_PPPCCP"></a><dl>
///           <dt><b>RASP_PppCcp</b></dt> </dl> </td> <td width="60%"> RASPPPCCP <div class="alert"><b>Note</b> Supported on
///           Windows 2000 or later.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a id="RASP_PppIp"></a><a
///           id="rasp_pppip"></a><a id="RASP_PPPIP"></a><dl> <dt><b>RASP_PppIp</b></dt> </dl> </td> <td width="60%"> RASPPPIP
///           </td> </tr> <tr> <td width="40%"><a id="RASP_PppIpv6"></a><a id="rasp_pppipv6"></a><a id="RASP_PPPIPV6"></a><dl>
///           <dt><b>RASP_PppIpv6</b></dt> </dl> </td> <td width="60%"> RASPPPIPV6 <div class="alert"><b>Note</b> Supported on
///           Windows Vista or later.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a id="RASP_PppIpx"></a><a
///           id="rasp_pppipx"></a><a id="RASP_PPPIPX"></a><dl> <dt><b>RASP_PppIpx</b></dt> </dl> </td> <td width="60%">
///           RASPPPIPX <div class="alert"><b>Note</b> Not supported on 64-bit Microsoft Windows.</div> <div> </div> </td>
///           </tr> <tr> <td width="40%"><a id="RASP_PppLcp"></a><a id="rasp_ppplcp"></a><a id="RASP_PPPLCP"></a><dl>
///           <dt><b>RASP_PppLcp</b></dt> </dl> </td> <td width="60%"> RASPPPLCP <div class="alert"><b>Note</b> Supported on
///           Windows 2000 or later.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a id="RASP_PppNbf"></a><a
///           id="rasp_pppnbf"></a><a id="RASP_PPPNBF"></a><dl> <dt><b>RASP_PppNbf</b></dt> </dl> </td> <td width="60%">
///           RASPPPNBF <div class="alert"><b>Note</b> Supported on Windows 2000 or earlier.</div> <div> </div> </td> </tr>
///           <tr> <td width="40%"><a id="RASP_Slip"></a><a id="rasp_slip"></a><a id="RASP_SLIP"></a><dl>
///           <dt><b>RASP_Slip</b></dt> </dl> </td> <td width="60%"> RASPSLIP <div class="alert"><b>Note</b> Supported on
///           Windows Server 2003 or earlier.</div> <div> </div> </td> </tr> </table>
///    arg4 = Pointer to a variable that, on input, specifies the size, in bytes, of the buffer pointed to by
///           <i>lpprojection</i>. On output, this variable receives the size, in bytes, of the <i>lpprojection</i> buffer.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUFFER_TOO_SMALL</b></dt>
///    </dl> </td> <td width="60%"> The buffer pointed to by <i>lpprojection</i> is not large enough to contain the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td>
///    <td width="60%"> The <i>hrasconn</i> parameter is not a valid handle. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the parameters is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_SIZE</b></dt> </dl> </td> <td width="60%"> The
///    <b>dwSize</b> member of the structure pointed to by <i>lpprojection</i> specifies an invalid size. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_PROTOCOL_NOT_CONFIGURED</b></dt> </dl> </td> <td width="60%"> The control
///    protocol for which information was requested neither succeeded nor failed, because the connection's phone-book
///    entry did not require that an attempt to negotiate the protocol be made. This is a RAS error code. </td> </tr>
///    </table>
///    
@DllImport("RASAPI32")
uint RasGetProjectionInfoW(HRASCONN__* param0, tagRASPROJECTION param1, void* param2, uint* param3);

///<p class="CCE_Message">[This function has been deprecated as of Windows Vista and its functionality has been replaced
///by RasDialDlg. ] The <b>RasCreatePhonebookEntry</b> function creates a new phone-book entry. The function displays a
///dialog box in which the user types information for the phone-book entry.
///Params:
///    arg1 = Handle to the parent window of the dialog box.
///    arg2 = Pointer to a <b>null</b>-terminated string that specifies the full path and file name of a phone-book (PBK) file.
///           If this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book
///           file is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up
///           Networking</b> dialog box.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANNOT_OPEN_PHONEBOOK</b></dt> </dl> </td> <td width="60%"> The phone book is corrupted or missing
///    components. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasCreatePhonebookEntryA(HWND param0, const(PSTR) param1);

///<p class="CCE_Message">[This function has been deprecated as of Windows Vista and its functionality has been replaced
///by RasDialDlg. ] The <b>RasCreatePhonebookEntry</b> function creates a new phone-book entry. The function displays a
///dialog box in which the user types information for the phone-book entry.
///Params:
///    arg1 = Handle to the parent window of the dialog box.
///    arg2 = Pointer to a <b>null</b>-terminated string that specifies the full path and file name of a phone-book (PBK) file.
///           If this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book
///           file is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up
///           Networking</b> dialog box.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANNOT_OPEN_PHONEBOOK</b></dt> </dl> </td> <td width="60%"> The phone book is corrupted or missing
///    components. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasCreatePhonebookEntryW(HWND param0, const(PWSTR) param1);

///<p class="CCE_Message">[This function has been deprecated as of Windows Vista and its functionality has been replaced
///by RasEntryDlg.] The <b>RasEditPhonebookEntry</b> function edits an existing phone-book entry. The function displays
///a dialog box in which the user can modify the existing information.
///Params:
///    arg1 = Handle to the parent window of the dialog box.
///    arg2 = Pointer to a null-terminated string that specifies the full path and file name of a phone-book (PBK) file. If
///           this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book file
///           is the one selected by the user in the <b>User Preferences</b> property sheet of the<b> Dial-Up Networking</b>
///           dialog box.
///    arg3 = Pointer to a null-terminated string that specifies the name of an existing entry in the phone-book file.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BUFFER_INVALID</b></dt> </dl> </td> <td width="60%"> The phone-book entry buffer is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_OPEN_PHONEBOOK</b></dt> </dl> </td> <td width="60%"> The
///    phone book is corrupted or missing components. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANNOT_FIND_PHONEBOOK_ENTRY</b></dt> </dl> </td> <td width="60%"> The phone-book entry does not
///    exist. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasEditPhonebookEntryA(HWND param0, const(PSTR) param1, const(PSTR) param2);

///<p class="CCE_Message">[This function has been deprecated as of Windows Vista and its functionality has been replaced
///by RasEntryDlg.] The <b>RasEditPhonebookEntry</b> function edits an existing phone-book entry. The function displays
///a dialog box in which the user can modify the existing information.
///Params:
///    arg1 = Handle to the parent window of the dialog box.
///    arg2 = Pointer to a null-terminated string that specifies the full path and file name of a phone-book (PBK) file. If
///           this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book file
///           is the one selected by the user in the <b>User Preferences</b> property sheet of the<b> Dial-Up Networking</b>
///           dialog box.
///    arg3 = Pointer to a null-terminated string that specifies the name of an existing entry in the phone-book file.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BUFFER_INVALID</b></dt> </dl> </td> <td width="60%"> The phone-book entry buffer is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_OPEN_PHONEBOOK</b></dt> </dl> </td> <td width="60%"> The
///    phone book is corrupted or missing components. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANNOT_FIND_PHONEBOOK_ENTRY</b></dt> </dl> </td> <td width="60%"> The phone-book entry does not
///    exist. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasEditPhonebookEntryW(HWND param0, const(PWSTR) param1, const(PWSTR) param2);

///The <b>RasSetEntryDialParams</b> function changes the connection information saved by the last successful call to the
///RasDial or <b>RasSetEntryDialParams</b> function for a specified phone-book entry.
///Params:
///    arg1 = Pointer to a null-terminated string that specifies the full path and file name of a phone-book (PBK) file. If
///           this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book file
///           is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up Networking</b>
///           dialog box. <b>Windows Me/98/95: </b>This parameter should always be <b>NULL</b>. Dial-up networking stores
///           phone-book entries in the registry rather than in a phone-book file.
///    arg2 = Pointer to the RASDIALPARAMS structure that specifies the connection parameters to be associated with the
///           phone-book entry. <b>RasSetEntryDialParams</b> uses the structure's members as follows. <table> <tr>
///           <th>Member</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="dwSize"></a><a id="dwsize"></a><a
///           id="DWSIZE"></a><dl> <dt><b><b>dwSize</b></b></dt> </dl> </td> <td width="60%"> Must specify the size of
///           (RASDIALPARAMS) to identify the version of the structure. </td> </tr> <tr> <td width="40%"><a
///           id="szEntryName"></a><a id="szentryname"></a><a id="SZENTRYNAME"></a><dl> <dt><b><b>szEntryName</b></b></dt>
///           </dl> </td> <td width="60%"> A null-terminated string that identifies the phone-book entry to set parameters for.
///           </td> </tr> <tr> <td width="40%"><a id="szPhoneNumber"></a><a id="szphonenumber"></a><a
///           id="SZPHONENUMBER"></a><dl> <dt><b><b>szPhoneNumber</b></b></dt> </dl> </td> <td width="60%"> Not used. Set to
///           <b>NULL</b>. </td> </tr> <tr> <td width="40%"><a id="szCallbackNumber"></a><a id="szcallbacknumber"></a><a
///           id="SZCALLBACKNUMBER"></a><dl> <dt><b><b>szCallbackNumber</b></b></dt> </dl> </td> <td width="60%"> A
///           null-terminated string that contains the callback phone number. If <b>szCallbackNumber</b> is an empty string (
///           "" ), the callback number is not changed. </td> </tr> <tr> <td width="40%"><a id="szUserName"></a><a
///           id="szusername"></a><a id="SZUSERNAME"></a><dl> <dt><b><b>szUserName</b></b></dt> </dl> </td> <td width="60%"> A
///           null-terminated string that contains the logon name of the user associated with this entry. If <b>szUserName</b>
///           is an empty string, the user name is not changed. </td> </tr> <tr> <td width="40%"><a id="szPassword"></a><a
///           id="szpassword"></a><a id="SZPASSWORD"></a><dl> <dt><b><b>szPassword</b></b></dt> </dl> </td> <td width="60%"> A
///           null-terminated string that contains the password for the user specified by <b>szUserName</b>. If
///           <b>szUserName</b> is an empty string, the password is not changed. If <b>szPassword</b> is an empty string and
///           <i>fRemovePassword</i> is <b>FALSE</b>, the password is set to the empty string. If <i>fRemovePassword</i> is
///           <b>TRUE</b>, the password stored in this phone-book entry for the user specified by <b>szUserName</b> is removed
///           regardless of the contents of the <b>szPassword</b> string. <b>Windows NT 4.0: </b>The password is changed to the
///           string specified by <b>szPassword</b> regardless of whether <b>szUserName</b> is an empty string. <b>Windows
///           XP/2000: </b>If <b>szPassword</b> contains the password handle returned by RasGetCredentials or
///           RasGetEntryDialParams, <b>RasSetEntryDialParams</b> returns successfully without changing any currently saved
///           password. </td> </tr> <tr> <td width="40%"><a id="szDomain"></a><a id="szdomain"></a><a id="SZDOMAIN"></a><dl>
///           <dt><b><b>szDomain</b></b></dt> </dl> </td> <td width="60%"> A null-terminated string that contains the name of
///           the domain on which to log on. If <b>szDomain</b> is an empty string, the domain name is not changed. </td> </tr>
///           <tr> <td width="40%"><a id="dwSubEntry"></a><a id="dwsubentry"></a><a id="DWSUBENTRY"></a><dl>
///           <dt><b><b>dwSubEntry</b></b></dt> </dl> </td> <td width="60%"> Specifies the (one-based) index of the initial
///           subentry to dial when establishing the connection. </td> </tr> <tr> <td width="40%"><a id="dwCallbackId"></a><a
///           id="dwcallbackid"></a><a id="DWCALLBACKID"></a><dl> <dt><b><b>dwCallbackId</b></b></dt> </dl> </td> <td
///           width="60%"> Specifies an application-defined value that RAS passes to the RasDialFunc2 callback function. </td>
///           </tr> </table>
///    arg3 = Specifies whether to remove the phone-book entry's stored password for the user indicated by
///           <i>lprasdialparams</i>-&gt;<b>szUserName</b>. If <i>fRemovePassword</i> is <b>TRUE</b>, the password is removed.
///           Setting fRemovePassword to <b>TRUE</b> is equivalent to checking the "Unsave Password" check box in Dial-Up
///           Networking. When setting the password or other properties of a phone book entry, set <i>fRemovePassword</i> to
///           <b>FALSE</b>.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUFFER_INVALID</b></dt>
///    </dl> </td> <td width="60%"> The address or buffer specified by <i>lprasdialparams</i> is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_OPEN_PHONEBOOK</b></dt> </dl> </td> <td width="60%"> The phone
///    book is corrupted or missing components. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANNOT_FIND_PHONEBOOK_ENTRY</b></dt> </dl> </td> <td width="60%"> The phone-book entry does not
///    exist. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasSetEntryDialParamsA(const(PSTR) param0, tagRASDIALPARAMSA* param1, BOOL param2);

///The <b>RasSetEntryDialParams</b> function changes the connection information saved by the last successful call to the
///RasDial or <b>RasSetEntryDialParams</b> function for a specified phone-book entry.
///Params:
///    arg1 = Pointer to a null-terminated string that specifies the full path and file name of a phone-book (PBK) file. If
///           this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book file
///           is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up Networking</b>
///           dialog box. <b>Windows Me/98/95: </b>This parameter should always be <b>NULL</b>. Dial-up networking stores
///           phone-book entries in the registry rather than in a phone-book file.
///    arg2 = Pointer to the RASDIALPARAMS structure that specifies the connection parameters to be associated with the
///           phone-book entry. <b>RasSetEntryDialParams</b> uses the structure's members as follows. <table> <tr>
///           <th>Member</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="dwSize"></a><a id="dwsize"></a><a
///           id="DWSIZE"></a><dl> <dt><b><b>dwSize</b></b></dt> </dl> </td> <td width="60%"> Must specify the size of
///           (RASDIALPARAMS) to identify the version of the structure. </td> </tr> <tr> <td width="40%"><a
///           id="szEntryName"></a><a id="szentryname"></a><a id="SZENTRYNAME"></a><dl> <dt><b><b>szEntryName</b></b></dt>
///           </dl> </td> <td width="60%"> A null-terminated string that identifies the phone-book entry to set parameters for.
///           </td> </tr> <tr> <td width="40%"><a id="szPhoneNumber"></a><a id="szphonenumber"></a><a
///           id="SZPHONENUMBER"></a><dl> <dt><b><b>szPhoneNumber</b></b></dt> </dl> </td> <td width="60%"> Not used. Set to
///           <b>NULL</b>. </td> </tr> <tr> <td width="40%"><a id="szCallbackNumber"></a><a id="szcallbacknumber"></a><a
///           id="SZCALLBACKNUMBER"></a><dl> <dt><b><b>szCallbackNumber</b></b></dt> </dl> </td> <td width="60%"> A
///           null-terminated string that contains the callback phone number. If <b>szCallbackNumber</b> is an empty string (
///           "" ), the callback number is not changed. </td> </tr> <tr> <td width="40%"><a id="szUserName"></a><a
///           id="szusername"></a><a id="SZUSERNAME"></a><dl> <dt><b><b>szUserName</b></b></dt> </dl> </td> <td width="60%"> A
///           null-terminated string that contains the logon name of the user associated with this entry. If <b>szUserName</b>
///           is an empty string, the user name is not changed. </td> </tr> <tr> <td width="40%"><a id="szPassword"></a><a
///           id="szpassword"></a><a id="SZPASSWORD"></a><dl> <dt><b><b>szPassword</b></b></dt> </dl> </td> <td width="60%"> A
///           null-terminated string that contains the password for the user specified by <b>szUserName</b>. If
///           <b>szUserName</b> is an empty string, the password is not changed. If <b>szPassword</b> is an empty string and
///           <i>fRemovePassword</i> is <b>FALSE</b>, the password is set to the empty string. If <i>fRemovePassword</i> is
///           <b>TRUE</b>, the password stored in this phone-book entry for the user specified by <b>szUserName</b> is removed
///           regardless of the contents of the <b>szPassword</b> string. <b>Windows NT 4.0: </b>The password is changed to the
///           string specified by <b>szPassword</b> regardless of whether <b>szUserName</b> is an empty string. <b>Windows
///           XP/2000: </b>If <b>szPassword</b> contains the password handle returned by RasGetCredentials or
///           RasGetEntryDialParams, <b>RasSetEntryDialParams</b> returns successfully without changing any currently saved
///           password. </td> </tr> <tr> <td width="40%"><a id="szDomain"></a><a id="szdomain"></a><a id="SZDOMAIN"></a><dl>
///           <dt><b><b>szDomain</b></b></dt> </dl> </td> <td width="60%"> A null-terminated string that contains the name of
///           the domain on which to log on. If <b>szDomain</b> is an empty string, the domain name is not changed. </td> </tr>
///           <tr> <td width="40%"><a id="dwSubEntry"></a><a id="dwsubentry"></a><a id="DWSUBENTRY"></a><dl>
///           <dt><b><b>dwSubEntry</b></b></dt> </dl> </td> <td width="60%"> Specifies the (one-based) index of the initial
///           subentry to dial when establishing the connection. </td> </tr> <tr> <td width="40%"><a id="dwCallbackId"></a><a
///           id="dwcallbackid"></a><a id="DWCALLBACKID"></a><dl> <dt><b><b>dwCallbackId</b></b></dt> </dl> </td> <td
///           width="60%"> Specifies an application-defined value that RAS passes to the RasDialFunc2 callback function. </td>
///           </tr> </table>
///    arg3 = Specifies whether to remove the phone-book entry's stored password for the user indicated by
///           <i>lprasdialparams</i>-&gt;<b>szUserName</b>. If <i>fRemovePassword</i> is <b>TRUE</b>, the password is removed.
///           Setting fRemovePassword to <b>TRUE</b> is equivalent to checking the "Unsave Password" check box in Dial-Up
///           Networking. When setting the password or other properties of a phone book entry, set <i>fRemovePassword</i> to
///           <b>FALSE</b>.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUFFER_INVALID</b></dt>
///    </dl> </td> <td width="60%"> The address or buffer specified by <i>lprasdialparams</i> is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_OPEN_PHONEBOOK</b></dt> </dl> </td> <td width="60%"> The phone
///    book is corrupted or missing components. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANNOT_FIND_PHONEBOOK_ENTRY</b></dt> </dl> </td> <td width="60%"> The phone-book entry does not
///    exist. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasSetEntryDialParamsW(const(PWSTR) param0, tagRASDIALPARAMSW* param1, BOOL param2);

///The <b>RasGetEntryDialParams</b> function retrieves the connection information saved by the last successful call to
///the RasDial or RasSetEntryDialParams function for a specified phone-book entry.
///Params:
///    arg1 = Pointer to a <b>null</b>-terminated string that specifies the full path and file name of a phone-book (PBK) file.
///           If this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book
///           file is the one selected by the user in the <b>User Preferences</b> property sheet of the <i>Dial-Up
///           Networking</i> dialog box. <b>Windows Me/98/95: </b>This parameter should always be <b>NULL</b>. Dial-up
///           networking stores phone-book entries in the registry rather than in a phone-book file.
///    arg2 = Pointer to a RASDIALPARAMS structure. On input, the <b>dwSize</b> member specifies the size of the RASDIALPARAMS
///           structure, and the <b>szEntryName</b> member specifies a valid phone-book entry. On output, the structure
///           receives the connection parameters associated with the specified phone-book entry. Note that the
///           <b>szPhoneNumber</b> member of the structure does not receive the phone number associated with the phone-book
///           entry. To get the phone number associated with a phone-book entry, call the RasGetEntryProperties function. If
///           <b>szPhoneNumber</b> is an empty string in the RASDIALPARAMS structure passed to RasDial, <b>RasDial</b> uses the
///           phone number stored in the phone-book entry. The <b>szPassword</b> member of the RASDIALPARAMS structure does not
///           return the actual password. Instead, <b>szPassword</b> contains a handle to the saved password. Substitute this
///           handle for the saved password in subsequent calls to RasSetEntryDialParams and RasDial. When presented with this
///           handle, <b>RasDial</b> retrieves and uses the saved password. The value of this handle may change in future
///           versions of the operating system; do not develop code that depends on the contents or format of this value.
///           <b>Windows NT and Windows Me/98/95: </b>Secure password feature not supported.
///    arg3 = Pointer to a flag that indicates whether the function retrieved the password associated with the user name for
///           the phone-book entry. The <i>lpfPassword</i> parameter is <b>TRUE</b> if the system has saved a password for the
///           specified entry. If the system has no password saved for this entry, <i>lpfPassword</i> is <b>FALSE</b>.
///           <b>Windows NT and Windows Me/98/95: </b>The function sets this flag to <b>TRUE</b> if the user's password was
///           returned in the <b>szPassword</b> member of the RASDIALPARAMS structure pointed to by <i>lprasdialparams</i>.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUFFER_INVALID</b></dt>
///    </dl> </td> <td width="60%"> The <i>lprasdialparams</i> or <i>lpfPassword</i> pointer is invalid, or the
///    <i>lprasdialparams</i> buffer is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANNOT_OPEN_PHONEBOOK</b></dt> </dl> </td> <td width="60%"> The phone book is corrupted or missing
///    components. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_FIND_PHONEBOOK_ENTRY</b></dt> </dl> </td>
///    <td width="60%"> The phone-book entry does not exist. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasGetEntryDialParamsA(const(PSTR) param0, tagRASDIALPARAMSA* param1, int* param2);

///The <b>RasGetEntryDialParams</b> function retrieves the connection information saved by the last successful call to
///the RasDial or RasSetEntryDialParams function for a specified phone-book entry.
///Params:
///    arg1 = Pointer to a <b>null</b>-terminated string that specifies the full path and file name of a phone-book (PBK) file.
///           If this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book
///           file is the one selected by the user in the <b>User Preferences</b> property sheet of the <i>Dial-Up
///           Networking</i> dialog box. <b>Windows Me/98/95: </b>This parameter should always be <b>NULL</b>. Dial-up
///           networking stores phone-book entries in the registry rather than in a phone-book file.
///    arg2 = Pointer to a RASDIALPARAMS structure. On input, the <b>dwSize</b> member specifies the size of the RASDIALPARAMS
///           structure, and the <b>szEntryName</b> member specifies a valid phone-book entry. On output, the structure
///           receives the connection parameters associated with the specified phone-book entry. Note that the
///           <b>szPhoneNumber</b> member of the structure does not receive the phone number associated with the phone-book
///           entry. To get the phone number associated with a phone-book entry, call the RasGetEntryProperties function. If
///           <b>szPhoneNumber</b> is an empty string in the RASDIALPARAMS structure passed to RasDial, <b>RasDial</b> uses the
///           phone number stored in the phone-book entry. The <b>szPassword</b> member of the RASDIALPARAMS structure does not
///           return the actual password. Instead, <b>szPassword</b> contains a handle to the saved password. Substitute this
///           handle for the saved password in subsequent calls to RasSetEntryDialParams and RasDial. When presented with this
///           handle, <b>RasDial</b> retrieves and uses the saved password. The value of this handle may change in future
///           versions of the operating system; do not develop code that depends on the contents or format of this value.
///           <b>Windows NT and Windows Me/98/95: </b>Secure password feature not supported.
///    arg3 = Pointer to a flag that indicates whether the function retrieved the password associated with the user name for
///           the phone-book entry. The <i>lpfPassword</i> parameter is <b>TRUE</b> if the system has saved a password for the
///           specified entry. If the system has no password saved for this entry, <i>lpfPassword</i> is <b>FALSE</b>.
///           <b>Windows NT and Windows Me/98/95: </b>The function sets this flag to <b>TRUE</b> if the user's password was
///           returned in the <b>szPassword</b> member of the RASDIALPARAMS structure pointed to by <i>lprasdialparams</i>.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUFFER_INVALID</b></dt>
///    </dl> </td> <td width="60%"> The <i>lprasdialparams</i> or <i>lpfPassword</i> pointer is invalid, or the
///    <i>lprasdialparams</i> buffer is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANNOT_OPEN_PHONEBOOK</b></dt> </dl> </td> <td width="60%"> The phone book is corrupted or missing
///    components. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_FIND_PHONEBOOK_ENTRY</b></dt> </dl> </td>
///    <td width="60%"> The phone-book entry does not exist. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasGetEntryDialParamsW(const(PWSTR) param0, tagRASDIALPARAMSW* param1, int* param2);

///The <b>RasEnumDevices</b> function returns the name and type of all available RAS-capable devices.
///Params:
///    arg1 = Pointer to a buffer that receives an array of RASDEVINFO structures, one for each RAS-capable device. Before
///           calling the function, set the <b>dwSize</b> member of the first <b>RASDEVINFO</b> structure in the buffer to
///           sizeof(<b>RASDEVINFO</b>) to identify the version of the structure.
///    arg2 = Pointer to a variable that, on input, contains the size, in bytes, of the <i>lpRasDevInfo</i> buffer. On output,
///           the function sets this variable to the number of bytes required to enumerate the devices. <div
///           class="alert"><b>Note</b> <p class="note">To determine the required buffer size, call <b>RasEnumDevices</b> with
///           <i>lpRasDevInfo</i> set to <b>NULL</b>. The variable pointed to by <i>lpcb</i> should be set to zero. The
///           function will return the required buffer size in <i>lpcb</i> and an error code of <b>ERROR_BUFFER_TOO_SMALL</b>.
///           </div> <div> </div>
///    arg3 = Pointer to a variable that receives the number of RASDEVINFO structures written to the <i>lpRasDevInfo</i>
///           buffer.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUFFER_TOO_SMALL</b></dt>
///    </dl> </td> <td width="60%"> The <i>lpRasDevInfo</i> buffer is not large enough. The <i>lpcb</i>parameter is less
///    than the <b>dwSize</b> member in the <i>lpRasDevInfo</i>parameter which should be set prior to calling the
///    function. The function returns the required buffer size in the variable pointed to by <i>lpcb</i>. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Indicates
///    insufficient memory. The <i>lpRasDevInfo</i>parameter is non-<b>NULL</b>, the <i>lpcb</i>parameter is
///    non-<b>NULL</b> and an internal memory allocation failed. This is possibly due to a low-memory condition. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> Indicates
///    an invalid parameter value. The <i>lpcb</i>parameter is <b>NULL</b> or the <i>lpcDevices</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_USER_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> The address or buffer specified by <i>lpRasDevInfo</i> is invalid. The <b>dwSize</b>member of the
///    <i>lpRasDevInfo</i> parameter does not equal sizeof(RASDEVINFO). </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasEnumDevicesA(tagRASDEVINFOA* param0, uint* param1, uint* param2);

///The <b>RasEnumDevices</b> function returns the name and type of all available RAS-capable devices.
///Params:
///    arg1 = Pointer to a buffer that receives an array of RASDEVINFO structures, one for each RAS-capable device. Before
///           calling the function, set the <b>dwSize</b> member of the first <b>RASDEVINFO</b> structure in the buffer to
///           sizeof(<b>RASDEVINFO</b>) to identify the version of the structure.
///    arg2 = Pointer to a variable that, on input, contains the size, in bytes, of the <i>lpRasDevInfo</i> buffer. On output,
///           the function sets this variable to the number of bytes required to enumerate the devices. <div
///           class="alert"><b>Note</b> <p class="note">To determine the required buffer size, call <b>RasEnumDevices</b> with
///           <i>lpRasDevInfo</i> set to <b>NULL</b>. The variable pointed to by <i>lpcb</i> should be set to zero. The
///           function will return the required buffer size in <i>lpcb</i> and an error code of <b>ERROR_BUFFER_TOO_SMALL</b>.
///           </div> <div> </div>
///    arg3 = Pointer to a variable that receives the number of RASDEVINFO structures written to the <i>lpRasDevInfo</i>
///           buffer.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUFFER_TOO_SMALL</b></dt>
///    </dl> </td> <td width="60%"> The <i>lpRasDevInfo</i> buffer is not large enough. The <i>lpcb</i>parameter is less
///    than the <b>dwSize</b> member in the <i>lpRasDevInfo</i>parameter which should be set prior to calling the
///    function. The function returns the required buffer size in the variable pointed to by <i>lpcb</i>. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Indicates
///    insufficient memory. The <i>lpRasDevInfo</i>parameter is non-<b>NULL</b>, the <i>lpcb</i>parameter is
///    non-<b>NULL</b> and an internal memory allocation failed. This is possibly due to a low-memory condition. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> Indicates
///    an invalid parameter value. The <i>lpcb</i>parameter is <b>NULL</b> or the <i>lpcDevices</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_USER_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> The address or buffer specified by <i>lpRasDevInfo</i> is invalid. The <b>dwSize</b>member of the
///    <i>lpRasDevInfo</i> parameter does not equal sizeof(RASDEVINFO). </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasEnumDevicesW(tagRASDEVINFOW* param0, uint* param1, uint* param2);

///The <b>RasGetCountryInfo</b> function retrieves country/region-specific dialing information from the Windows
///Telephony list of countries/regions. For more information about country/region-specific dialing information and
///Telephony Application Programming Interface (TAPI) country/region identifiers, see the TAPI portion of the Platform
///Software Development Kit (SDK).
///Params:
///    arg1 = Pointer to a RASCTRYINFO structure that, on output, receives the country/region-specific dialing information
///           followed by additional bytes for a country/region description string. On input, set the <b>dwSize</b> member of
///           the structure to sizeof(RASCTRYINFO) to identify the version of the structure. Also, set the <b>dwCountryId</b>
///           member to the TAPI country/region identifier of the country/region for which to get information. Allocate at
///           least 256 bytes for the buffer.
///    arg2 = Pointer to a variable that, on input, specifies the size, in bytes, of the buffer pointed to by the
///           <i>lpRasCtryInfo</i> parameter. On output, this variable receives the number of bytes required.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_USER_BUFFER</b></dt>
///    </dl> </td> <td width="60%"> The address or buffer specified by <i>lpRasCtryInfo</i> is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <b>dwCountryId</b>
///    member of the structure pointed to by <i>lpRasCtryInfo</i> was not a valid value. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_BUFFER_TOO_SMALL</b></dt> </dl> </td> <td width="60%"> The size of the
///    <i>lpRasCtryInfo</i> buffer specified by the <i>lpdwSize</i> parameter was not large enough to store the
///    information for the country/region identified by the <b>dwCountryId</b> member. The function returns the required
///    buffer size in the variable pointed to by <i>lpdwSize</i>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_TAPI_CONFIGURATION</b></dt> </dl> </td> <td width="60%"> TAPI subsystem information was corrupted.
///    </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasGetCountryInfoA(RASCTRYINFO* param0, uint* param1);

///The <b>RasGetCountryInfo</b> function retrieves country/region-specific dialing information from the Windows
///Telephony list of countries/regions. For more information about country/region-specific dialing information and
///Telephony Application Programming Interface (TAPI) country/region identifiers, see the TAPI portion of the Platform
///Software Development Kit (SDK).
///Params:
///    arg1 = Pointer to a RASCTRYINFO structure that, on output, receives the country/region-specific dialing information
///           followed by additional bytes for a country/region description string. On input, set the <b>dwSize</b> member of
///           the structure to sizeof(RASCTRYINFO) to identify the version of the structure. Also, set the <b>dwCountryId</b>
///           member to the TAPI country/region identifier of the country/region for which to get information. Allocate at
///           least 256 bytes for the buffer.
///    arg2 = Pointer to a variable that, on input, specifies the size, in bytes, of the buffer pointed to by the
///           <i>lpRasCtryInfo</i> parameter. On output, this variable receives the number of bytes required.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_USER_BUFFER</b></dt>
///    </dl> </td> <td width="60%"> The address or buffer specified by <i>lpRasCtryInfo</i> is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <b>dwCountryId</b>
///    member of the structure pointed to by <i>lpRasCtryInfo</i> was not a valid value. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_BUFFER_TOO_SMALL</b></dt> </dl> </td> <td width="60%"> The size of the
///    <i>lpRasCtryInfo</i> buffer specified by the <i>lpdwSize</i> parameter was not large enough to store the
///    information for the country/region identified by the <b>dwCountryId</b> member. The function returns the required
///    buffer size in the variable pointed to by <i>lpdwSize</i>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_TAPI_CONFIGURATION</b></dt> </dl> </td> <td width="60%"> TAPI subsystem information was corrupted.
///    </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasGetCountryInfoW(RASCTRYINFO* param0, uint* param1);

///The <b>RasGetEntryProperties</b> function retrieves the properties of a phone-book entry.
///Params:
///    arg1 = Pointer to a <b>null</b>-terminated string that specifies the full path and file name of a phone-book (PBK) file.
///           If this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book
///           file is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up
///           Networking</b> dialog box. <b>Windows Me/98/95: </b>This parameter should always be <b>NULL</b>. Dial-up
///           networking stores phone-book entries in the registry rather than in a phone-book file.
///    arg2 = Pointer to a <b>null</b>-terminated string that specifies an existing entry name. If an empty string is
///           specified, the function returns default values in the buffers pointed to by the <i>lpRasEntry</i> and
///           <i>lpbDeviceInfo</i> parameters.
///    arg3 = Pointer to a RASENTRY structure followed by additional bytes for the alternate phone number list, if there is
///           one. On output, the structure receives the connection data associated with the phone-book entry specified by the
///           <i>lpszEntry</i> parameter. On input, set the <b>dwSize</b> member of the structure to sizeof(RASENTRY) to
///           identify the version of the structure. This parameter can be <b>NULL</b>. <b>Windows Me/98 and Windows 95 OSR2:
///           </b>The Microsoft Layer for Unicode does not support <b>dwAlternateOffset</b> in RASENTRY.
///    arg4 = Pointer to a variable that, on input, specifies the size, in bytes, of the <i>lpRasEntry</i> buffer. On output,
///           this variable receives the number of bytes required. This parameter can be <b>NULL</b> if the <i>lpRasEntry</i>
///           parameter is <b>NULL</b>. To determine the required buffer size, call <b>RasGetEntryProperties</b> with
///           <i>lpRasEntry</i> set to <b>NULL</b> and <i>*lpdwEntryInfoSize</i> set to zero. The function returns the required
///           buffer size in <i>*lpdwEntryInfoSize</i>.
///    arg5 = This parameter is no longer used. The calling function should set this parameter to <b>NULL</b>. <b>Windows
///           Me/98/95: </b>Pointer to a buffer that receives device-specific configuration information. Do not directly
///           manipulate this opaque TAPI device information. For more information about TAPI device configuration, see the
///           lineGetDevConfig function in the TAPI Programmer's Reference in the Platform SDK. This parameter can be
///           <b>NULL</b>.
///    arg6 = This parameter is unused. The calling function should set this parameter to <b>NULL</b>. <b>Windows Me/98/95:
///           </b>Pointer to a variable that, on input, specifies the size, in bytes, of the buffer specified by the
///           <i>lpbDeviceInfo</i> parameter. On output, this variable receives the number of bytes required. This parameter
///           can be <b>NULL</b> if the <i>lpbDeviceInfo</i> parameter s <b>NULL</b>. To determine the required buffer size,
///           call <b>RasGetEntryProperties</b> with <i>lpbDeviceInfo</i> set to <b>NULL</b> and <i>*lpdwDeviceInfoSize</i> set
///           to zero. The function returns the required buffer size in <i>*lpdwDeviceInfoSize</i>.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt>
///    </dl> </td> <td width="60%"> The function was called with an invalid parameter. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_SIZE</b></dt> </dl> </td> <td width="60%"> The value of the dwSize member of the
///    <i>lpRasEntry</i> is too small. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUFFER_INVALID</b></dt> </dl>
///    </td> <td width="60%"> The address or buffer specified by <i>lpRasEntry</i> is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_BUFFER_TOO_SMALL</b></dt> </dl> </td> <td width="60%"> The buffer size indicated
///    in <i>lpdwEntryInfoSize</i> is too small. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANNOT_FIND_PHONEBOOK_ENTRY</b></dt> </dl> </td> <td width="60%"> The phone-book entry does not
///    exist, or the phone-book file is corrupted and/or has missing components. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasGetEntryPropertiesA(const(PSTR) param0, const(PSTR) param1, tagRASENTRYA* param2, uint* param3, 
                            ubyte* param4, uint* param5);

///The <b>RasGetEntryProperties</b> function retrieves the properties of a phone-book entry.
///Params:
///    arg1 = Pointer to a <b>null</b>-terminated string that specifies the full path and file name of a phone-book (PBK) file.
///           If this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book
///           file is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up
///           Networking</b> dialog box. <b>Windows Me/98/95: </b>This parameter should always be <b>NULL</b>. Dial-up
///           networking stores phone-book entries in the registry rather than in a phone-book file.
///    arg2 = Pointer to a <b>null</b>-terminated string that specifies an existing entry name. If an empty string is
///           specified, the function returns default values in the buffers pointed to by the <i>lpRasEntry</i> and
///           <i>lpbDeviceInfo</i> parameters.
///    arg3 = Pointer to a RASENTRY structure followed by additional bytes for the alternate phone number list, if there is
///           one. On output, the structure receives the connection data associated with the phone-book entry specified by the
///           <i>lpszEntry</i> parameter. On input, set the <b>dwSize</b> member of the structure to sizeof(RASENTRY) to
///           identify the version of the structure. This parameter can be <b>NULL</b>. <b>Windows Me/98 and Windows 95 OSR2:
///           </b>The Microsoft Layer for Unicode does not support <b>dwAlternateOffset</b> in RASENTRY.
///    arg4 = Pointer to a variable that, on input, specifies the size, in bytes, of the <i>lpRasEntry</i> buffer. On output,
///           this variable receives the number of bytes required. This parameter can be <b>NULL</b> if the <i>lpRasEntry</i>
///           parameter is <b>NULL</b>. To determine the required buffer size, call <b>RasGetEntryProperties</b> with
///           <i>lpRasEntry</i> set to <b>NULL</b> and <i>*lpdwEntryInfoSize</i> set to zero. The function returns the required
///           buffer size in <i>*lpdwEntryInfoSize</i>.
///    arg5 = This parameter is no longer used. The calling function should set this parameter to <b>NULL</b>. <b>Windows
///           Me/98/95: </b>Pointer to a buffer that receives device-specific configuration information. Do not directly
///           manipulate this opaque TAPI device information. For more information about TAPI device configuration, see the
///           lineGetDevConfig function in the TAPI Programmer's Reference in the Platform SDK. This parameter can be
///           <b>NULL</b>.
///    arg6 = This parameter is unused. The calling function should set this parameter to <b>NULL</b>. <b>Windows Me/98/95:
///           </b>Pointer to a variable that, on input, specifies the size, in bytes, of the buffer specified by the
///           <i>lpbDeviceInfo</i> parameter. On output, this variable receives the number of bytes required. This parameter
///           can be <b>NULL</b> if the <i>lpbDeviceInfo</i> parameter s <b>NULL</b>. To determine the required buffer size,
///           call <b>RasGetEntryProperties</b> with <i>lpbDeviceInfo</i> set to <b>NULL</b> and <i>*lpdwDeviceInfoSize</i> set
///           to zero. The function returns the required buffer size in <i>*lpdwDeviceInfoSize</i>.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt>
///    </dl> </td> <td width="60%"> The function was called with an invalid parameter. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_SIZE</b></dt> </dl> </td> <td width="60%"> The value of the dwSize member of the
///    <i>lpRasEntry</i> is too small. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUFFER_INVALID</b></dt> </dl>
///    </td> <td width="60%"> The address or buffer specified by <i>lpRasEntry</i> is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_BUFFER_TOO_SMALL</b></dt> </dl> </td> <td width="60%"> The buffer size indicated
///    in <i>lpdwEntryInfoSize</i> is too small. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANNOT_FIND_PHONEBOOK_ENTRY</b></dt> </dl> </td> <td width="60%"> The phone-book entry does not
///    exist, or the phone-book file is corrupted and/or has missing components. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasGetEntryPropertiesW(const(PWSTR) param0, const(PWSTR) param1, tagRASENTRYW* param2, uint* param3, 
                            ubyte* param4, uint* param5);

///The <b>RasSetEntryProperties</b> function changes the connection information for an entry in the phone book or
///creates a new phone-book entry.
///Params:
///    arg1 = Pointer to a null-terminated string that specifies the full path and file name of a phone-book (PBK) file. If
///           this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book file
///           is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up Networking</b>
///           dialog box.
///    arg2 = Pointer to a null-terminated string that specifies an entry name. If the entry name matches an existing entry,
///           <b>RasSetEntryProperties</b> modifies the properties of that entry. If the entry name does not match an existing
///           entry, <b>RasSetEntryProperties</b> creates a new phone-book entry. For new entries, call the
///           RasValidateEntryName function to validate the entry name before calling <b>RasSetEntryProperties</b>.
///    arg3 = Pointer to the RASENTRY structure that specifies the new connection data to be associated with the phone-book
///           entry indicated by the <i>lpszEntry</i> parameter. The caller must provide values for the following members in
///           the RASENTRY structure. <ul> <li><b>dwSize</b></li> <li><b>szLocalPhoneNumber</b></li>
///           <li><b>szDeviceName</b></li> <li><b>szDeviceType</b></li> <li><b>dwFramingProtocol</b></li>
///           <li><b>dwfOptions</b></li> <li><b>dwType</b></li> </ul> <b>Windows XP or later: </b><b>dwType</b> is supported.
///           If values are not provided for these members, <b>RasSetEntryProperties</b> fails with
///           <b>ERROR_INVALID_PARAMETER</b>. The structure might be followed by an array of null-terminated alternate phone
///           number strings. The last string is terminated by two consecutive null characters. The <b>dwAlternateOffset</b>
///           member of the RASENTRY structure contains the offset to the first string.
///    arg4 = Specifies the size, in bytes, of the buffer identified by the <i>lpRasEntry</i> parameter.
///    arg5 = Pointer to a buffer that specifies device-specific configuration information. This is opaque TAPI device
///           configuration information. For more information about TAPI device configuration, see the lineGetDevConfig
///           function in Telephony Application Programming Interfaces (TAPI) in the Platform SDK. <b>Windows XP: </b>This
///           parameter is unused. The calling function should set this parameter to <b>NULL</b>.
///    arg6 = Specifies the size, in bytes, of the <i>lpbDeviceInfo</i> buffer. <b>Windows XP: </b>This parameter is unused.
///           The calling function should set this parameter to zero.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or WinError.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl>
///    </td> <td width="60%"> The user does not have the correct privileges. Only an administrator can complete this
///    task. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUFFER_INVALID</b></dt> </dl> </td> <td width="60%">
///    The address or buffer specified by <i>lpRasEntry</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANNOT_OPEN_PHONEBOOK</b></dt> </dl> </td> <td width="60%"> The phone book is corrupted or missing
///    components. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The RASENTRY structure pointed to by the <i>lpRasEntry</i> parameter does not contain adequate
///    information, or the specified entry does not exist in the phone book. See the description for <i>lpRasEntry</i>
///    to see what information is required. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasSetEntryPropertiesA(const(PSTR) param0, const(PSTR) param1, tagRASENTRYA* param2, uint param3, 
                            ubyte* param4, uint param5);

///The <b>RasSetEntryProperties</b> function changes the connection information for an entry in the phone book or
///creates a new phone-book entry.
///Params:
///    arg1 = Pointer to a null-terminated string that specifies the full path and file name of a phone-book (PBK) file. If
///           this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book file
///           is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up Networking</b>
///           dialog box.
///    arg2 = Pointer to a null-terminated string that specifies an entry name. If the entry name matches an existing entry,
///           <b>RasSetEntryProperties</b> modifies the properties of that entry. If the entry name does not match an existing
///           entry, <b>RasSetEntryProperties</b> creates a new phone-book entry. For new entries, call the
///           RasValidateEntryName function to validate the entry name before calling <b>RasSetEntryProperties</b>.
///    arg3 = Pointer to the RASENTRY structure that specifies the new connection data to be associated with the phone-book
///           entry indicated by the <i>lpszEntry</i> parameter. The caller must provide values for the following members in
///           the RASENTRY structure. <ul> <li><b>dwSize</b></li> <li><b>szLocalPhoneNumber</b></li>
///           <li><b>szDeviceName</b></li> <li><b>szDeviceType</b></li> <li><b>dwFramingProtocol</b></li>
///           <li><b>dwfOptions</b></li> <li><b>dwType</b></li> </ul> <b>Windows XP or later: </b><b>dwType</b> is supported.
///           If values are not provided for these members, <b>RasSetEntryProperties</b> fails with
///           <b>ERROR_INVALID_PARAMETER</b>. The structure might be followed by an array of null-terminated alternate phone
///           number strings. The last string is terminated by two consecutive null characters. The <b>dwAlternateOffset</b>
///           member of the RASENTRY structure contains the offset to the first string.
///    arg4 = Specifies the size, in bytes, of the buffer identified by the <i>lpRasEntry</i> parameter.
///    arg5 = Pointer to a buffer that specifies device-specific configuration information. This is opaque TAPI device
///           configuration information. For more information about TAPI device configuration, see the lineGetDevConfig
///           function in Telephony Application Programming Interfaces (TAPI) in the Platform SDK. <b>Windows XP: </b>This
///           parameter is unused. The calling function should set this parameter to <b>NULL</b>.
///    arg6 = Specifies the size, in bytes, of the <i>lpbDeviceInfo</i> buffer. <b>Windows XP: </b>This parameter is unused.
///           The calling function should set this parameter to zero.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or WinError.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl>
///    </td> <td width="60%"> The user does not have the correct privileges. Only an administrator can complete this
///    task. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUFFER_INVALID</b></dt> </dl> </td> <td width="60%">
///    The address or buffer specified by <i>lpRasEntry</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANNOT_OPEN_PHONEBOOK</b></dt> </dl> </td> <td width="60%"> The phone book is corrupted or missing
///    components. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The RASENTRY structure pointed to by the <i>lpRasEntry</i> parameter does not contain adequate
///    information, or the specified entry does not exist in the phone book. See the description for <i>lpRasEntry</i>
///    to see what information is required. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasSetEntryPropertiesW(const(PWSTR) param0, const(PWSTR) param1, tagRASENTRYW* param2, uint param3, 
                            ubyte* param4, uint param5);

///The <b>RasRenameEntry</b> function changes the name of an entry in a phone book.
///Params:
///    arg1 = Pointer to a null-terminated string that specifies the full path and file name of a phone-book (PBK) file. If
///           this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book file
///           is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up Networking</b>
///           dialog box. <b>Windows Me/98/95: </b>This parameter should always be <b>NULL</b>. Dial-up networking stores
///           phone-book entries in the registry rather than in a phone-book file.
///    arg2 = Pointer to a null-terminated string that specifies an existing entry name.
///    arg3 = Pointer to a null-terminated string that specifies the new entry name. Before calling <b>RasRenameEntry</b>, call
///           the RasValidateEntryName function to validate the new entry name.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt>
///    </dl> </td> <td width="60%"> The function could not allocate sufficient memory to complete the operation. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_NAME</b></dt> </dl> </td> <td width="60%"> The
///    <i>lpszNewEntry</i> name is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ALREADY_EXISTS</b></dt>
///    </dl> </td> <td width="60%"> An entry with the <i>lpszNewEntry</i> name already exists. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_CANNOT_FIND_PHONEBOOK_ENTRY</b></dt> </dl> </td> <td width="60%"> The phone-book
///    entry does not exist. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasRenameEntryA(const(PSTR) param0, const(PSTR) param1, const(PSTR) param2);

///The <b>RasRenameEntry</b> function changes the name of an entry in a phone book.
///Params:
///    arg1 = Pointer to a null-terminated string that specifies the full path and file name of a phone-book (PBK) file. If
///           this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book file
///           is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up Networking</b>
///           dialog box. <b>Windows Me/98/95: </b>This parameter should always be <b>NULL</b>. Dial-up networking stores
///           phone-book entries in the registry rather than in a phone-book file.
///    arg2 = Pointer to a null-terminated string that specifies an existing entry name.
///    arg3 = Pointer to a null-terminated string that specifies the new entry name. Before calling <b>RasRenameEntry</b>, call
///           the RasValidateEntryName function to validate the new entry name.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt>
///    </dl> </td> <td width="60%"> The function could not allocate sufficient memory to complete the operation. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_NAME</b></dt> </dl> </td> <td width="60%"> The
///    <i>lpszNewEntry</i> name is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ALREADY_EXISTS</b></dt>
///    </dl> </td> <td width="60%"> An entry with the <i>lpszNewEntry</i> name already exists. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_CANNOT_FIND_PHONEBOOK_ENTRY</b></dt> </dl> </td> <td width="60%"> The phone-book
///    entry does not exist. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasRenameEntryW(const(PWSTR) param0, const(PWSTR) param1, const(PWSTR) param2);

///The <b>RasDeleteEntry</b> function deletes an entry from a phone book.
///Params:
///    arg1 = Pointer to a null-terminated string that specifies the full path and file name of a phone-book (PBK) file. If
///           this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book file
///           is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up Networking</b>
///           dialog box. <b>Windows Me/98/95: </b>This parameter should always be <b>NULL</b>. Dial-up networking stores
///           phone-book entries in the registry rather than in a phone-book file.
///    arg2 = Pointer to a null-terminated string that specifies the name of an existing entry to be deleted.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl>
///    </td> <td width="60%"> The user does not have correct privileges. Only an administrator can complete this task.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_NAME</b></dt> </dl> </td> <td width="60%"> The entry
///    name specified in <i>lpszEntry</i> does not exist. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasDeleteEntryA(const(PSTR) param0, const(PSTR) param1);

///The <b>RasDeleteEntry</b> function deletes an entry from a phone book.
///Params:
///    arg1 = Pointer to a null-terminated string that specifies the full path and file name of a phone-book (PBK) file. If
///           this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book file
///           is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up Networking</b>
///           dialog box. <b>Windows Me/98/95: </b>This parameter should always be <b>NULL</b>. Dial-up networking stores
///           phone-book entries in the registry rather than in a phone-book file.
///    arg2 = Pointer to a null-terminated string that specifies the name of an existing entry to be deleted.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl>
///    </td> <td width="60%"> The user does not have correct privileges. Only an administrator can complete this task.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_NAME</b></dt> </dl> </td> <td width="60%"> The entry
///    name specified in <i>lpszEntry</i> does not exist. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasDeleteEntryW(const(PWSTR) param0, const(PWSTR) param1);

///The <b>RasValidateEntryName</b> function validates the format of a connection entry name. The name must contain at
///least one non-white-space alphanumeric character.
///Params:
///    arg1 = A pointer to a null-terminated string that specifies the full path and file name of a phone-book (PBK) file. If
///           this parameter is <b>NULL</b>, the function uses the current default phone-book file. <b>Windows Me/98/95:
///           </b>This parameter should always be <b>NULL</b>. Dial-up networking stores phone-book entries in the registry
///           rather than in a phone-book file.
///    arg2 = Pointer to a null-terminated string that specifies an entry name. The following characters are not allowed in an
///           entry name. <table> <tr> <th>Character</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="_"></a><dl>
///           <dt><b>|</b></dt> </dl> </td> <td width="60%"> vertical bar </td> </tr> <tr> <td width="40%"><a id="_"></a><dl>
///           <dt><b>&gt;</b></dt> </dl> </td> <td width="60%"> greater than symbol </td> </tr> <tr> <td width="40%"><a
///           id="_"></a><dl> <dt><b>&lt;</b></dt> </dl> </td> <td width="60%"> less than symbol </td> </tr> <tr> <td
///           width="40%"><a id="__"></a><dl> <dt><b>? </b></dt> </dl> </td> <td width="60%"> question mark </td> </tr> <tr>
///           <td width="40%"><a id="_"></a><dl> <dt><b>*</b></dt> </dl> </td> <td width="60%"> asterisk </td> </tr> <tr> <td
///           width="40%"><a id="_"></a><dl> <dt><b>\</b></dt> </dl> </td> <td width="60%"> backward slash </td> </tr> <tr> <td
///           width="40%"><a id="_"></a><dl> <dt><b>/</b></dt> </dl> </td> <td width="60%"> forward slash </td> </tr> <tr> <td
///           width="40%"><a id="__"></a><dl> <dt><b>: </b></dt> </dl> </td> <td width="60%"> colon </td> </tr> </table>
///           <b>Windows 2000 or later: </b>The entry name cannot begin with a period (".").
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ALREADY_EXISTS</b></dt> </dl>
///    </td> <td width="60%"> The entry name already exists in the specified phonebook. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_CANNOT_FIND_PHONEBOOK</b></dt> </dl> </td> <td width="60%"> The specified
///    phonebook doesn't exist. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_NAME</b></dt> </dl> </td>
///    <td width="60%"> The format of the specified entry name is invalid. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasValidateEntryNameA(const(PSTR) param0, const(PSTR) param1);

///The <b>RasValidateEntryName</b> function validates the format of a connection entry name. The name must contain at
///least one non-white-space alphanumeric character.
///Params:
///    arg1 = A pointer to a null-terminated string that specifies the full path and file name of a phone-book (PBK) file. If
///           this parameter is <b>NULL</b>, the function uses the current default phone-book file. <b>Windows Me/98/95:
///           </b>This parameter should always be <b>NULL</b>. Dial-up networking stores phone-book entries in the registry
///           rather than in a phone-book file.
///    arg2 = Pointer to a null-terminated string that specifies an entry name. The following characters are not allowed in an
///           entry name. <table> <tr> <th>Character</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="_"></a><dl>
///           <dt><b>|</b></dt> </dl> </td> <td width="60%"> vertical bar </td> </tr> <tr> <td width="40%"><a id="_"></a><dl>
///           <dt><b>&gt;</b></dt> </dl> </td> <td width="60%"> greater than symbol </td> </tr> <tr> <td width="40%"><a
///           id="_"></a><dl> <dt><b>&lt;</b></dt> </dl> </td> <td width="60%"> less than symbol </td> </tr> <tr> <td
///           width="40%"><a id="__"></a><dl> <dt><b>? </b></dt> </dl> </td> <td width="60%"> question mark </td> </tr> <tr>
///           <td width="40%"><a id="_"></a><dl> <dt><b>*</b></dt> </dl> </td> <td width="60%"> asterisk </td> </tr> <tr> <td
///           width="40%"><a id="_"></a><dl> <dt><b>\</b></dt> </dl> </td> <td width="60%"> backward slash </td> </tr> <tr> <td
///           width="40%"><a id="_"></a><dl> <dt><b>/</b></dt> </dl> </td> <td width="60%"> forward slash </td> </tr> <tr> <td
///           width="40%"><a id="__"></a><dl> <dt><b>: </b></dt> </dl> </td> <td width="60%"> colon </td> </tr> </table>
///           <b>Windows 2000 or later: </b>The entry name cannot begin with a period (".").
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ALREADY_EXISTS</b></dt> </dl>
///    </td> <td width="60%"> The entry name already exists in the specified phonebook. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_CANNOT_FIND_PHONEBOOK</b></dt> </dl> </td> <td width="60%"> The specified
///    phonebook doesn't exist. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_NAME</b></dt> </dl> </td>
///    <td width="60%"> The format of the specified entry name is invalid. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasValidateEntryNameW(const(PWSTR) param0, const(PWSTR) param1);

///The <b>RasConnectionNotification</b> function specifies an event object that the system sets to the signaled state
///when a RAS connection is created or terminated.
///Params:
///    arg1 = A handle to the RAS connection that receives the notifications. This can be a handle returned by the RasDial or
///           RasEnumConnections function. If this parameter is <b>INVALID_HANDLE_VALUE</b>, notifications are received for all
///           RAS connections on the local client.
///    arg2 = Specifies the handle of an event object. Use the CreateEvent function to create an event object.
///    arg3 = Specifies the RAS event that causes the system to signal the event object specified by the <i>hEvent</i>
///           parameter. This parameter is a combination of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
///           </tr> <tr> <td width="40%"><a id="RASCN_Connection"></a><a id="rascn_connection"></a><a
///           id="RASCN_CONNECTION"></a><dl> <dt><b>RASCN_Connection</b></dt> </dl> </td> <td width="60%"> If <i>hrasconn</i>
///           is <b>INVALID_HANDLE_VALUE</b>, <i>hEvent</i> is signaled when any RAS connection is created. </td> </tr> <tr>
///           <td width="40%"><a id="RASCN_Disconnection"></a><a id="rascn_disconnection"></a><a
///           id="RASCN_DISCONNECTION"></a><dl> <dt><b>RASCN_Disconnection</b></dt> </dl> </td> <td width="60%"> <i>hEvent</i>
///           is signaled when the <i>hrasconn</i> connection is terminated. If <i>hrasconn</i> is a multilink connection, the
///           event is signaled when all subentries are disconnected. If <i>hrasconn</i> is <b>INVALID_HANDLE_VALUE</b>, the
///           event is signaled when any RAS connection is terminated. </td> </tr> <tr> <td width="40%"><a
///           id="RASCN_BandwidthAdded"></a><a id="rascn_bandwidthadded"></a><a id="RASCN_BANDWIDTHADDED"></a><dl>
///           <dt><b>RASCN_BandwidthAdded</b></dt> </dl> </td> <td width="60%"> <b>Windows NT: </b>If <i>hrasconn</i> is a
///           handle to a combined multilink connection, <i>hEvent</i> is signaled when a subentry is connected. </td> </tr>
///           <tr> <td width="40%"><a id="RASCN_BandwidthRemoved"></a><a id="rascn_bandwidthremoved"></a><a
///           id="RASCN_BANDWIDTHREMOVED"></a><dl> <dt><b>RASCN_BandwidthRemoved</b></dt> </dl> </td> <td width="60%">
///           <b>Windows NT: </b>If <i>hrasconn</i> is a handle to a combined multilink connection, <i>hEvent</i> is signaled
///           when a subentry is disconnected. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is a
///    non-zero error code from Routing and Remote Access Error Codes or Winerror.h.
///    
@DllImport("RASAPI32")
uint RasConnectionNotificationA(HRASCONN__* param0, HANDLE param1, uint param2);

///The <b>RasConnectionNotification</b> function specifies an event object that the system sets to the signaled state
///when a RAS connection is created or terminated.
///Params:
///    arg1 = A handle to the RAS connection that receives the notifications. This can be a handle returned by the RasDial or
///           RasEnumConnections function. If this parameter is <b>INVALID_HANDLE_VALUE</b>, notifications are received for all
///           RAS connections on the local client.
///    arg2 = Specifies the handle of an event object. Use the CreateEvent function to create an event object.
///    arg3 = Specifies the RAS event that causes the system to signal the event object specified by the <i>hEvent</i>
///           parameter. This parameter is a combination of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
///           </tr> <tr> <td width="40%"><a id="RASCN_Connection"></a><a id="rascn_connection"></a><a
///           id="RASCN_CONNECTION"></a><dl> <dt><b>RASCN_Connection</b></dt> </dl> </td> <td width="60%"> If <i>hrasconn</i>
///           is <b>INVALID_HANDLE_VALUE</b>, <i>hEvent</i> is signaled when any RAS connection is created. </td> </tr> <tr>
///           <td width="40%"><a id="RASCN_Disconnection"></a><a id="rascn_disconnection"></a><a
///           id="RASCN_DISCONNECTION"></a><dl> <dt><b>RASCN_Disconnection</b></dt> </dl> </td> <td width="60%"> <i>hEvent</i>
///           is signaled when the <i>hrasconn</i> connection is terminated. If <i>hrasconn</i> is a multilink connection, the
///           event is signaled when all subentries are disconnected. If <i>hrasconn</i> is <b>INVALID_HANDLE_VALUE</b>, the
///           event is signaled when any RAS connection is terminated. </td> </tr> <tr> <td width="40%"><a
///           id="RASCN_BandwidthAdded"></a><a id="rascn_bandwidthadded"></a><a id="RASCN_BANDWIDTHADDED"></a><dl>
///           <dt><b>RASCN_BandwidthAdded</b></dt> </dl> </td> <td width="60%"> <b>Windows NT: </b>If <i>hrasconn</i> is a
///           handle to a combined multilink connection, <i>hEvent</i> is signaled when a subentry is connected. </td> </tr>
///           <tr> <td width="40%"><a id="RASCN_BandwidthRemoved"></a><a id="rascn_bandwidthremoved"></a><a
///           id="RASCN_BANDWIDTHREMOVED"></a><dl> <dt><b>RASCN_BandwidthRemoved</b></dt> </dl> </td> <td width="60%">
///           <b>Windows NT: </b>If <i>hrasconn</i> is a handle to a combined multilink connection, <i>hEvent</i> is signaled
///           when a subentry is disconnected. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is a
///    non-zero error code from Routing and Remote Access Error Codes or Winerror.h.
///    
@DllImport("RASAPI32")
uint RasConnectionNotificationW(HRASCONN__* param0, HANDLE param1, uint param2);

///The <b>RasGetSubEntryHandle</b> function retrieves a connection handle for a specified subentry of a multilink
///connection.
///Params:
///    arg1 = Specifies the <b>HRASCONN</b> connection handle returned by the RasDial function for a multilink phone-book
///           entry.
///    arg2 = Specifies a valid subentry index for the phone-book entry.
///    arg3 = Pointer to the <b>HRASCONN</b> variable that receives a connection handle that represents the subentry
///           connection.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl>
///    </td> <td width="60%"> The <i>hRasConn</i> connection handle does not represent a connected phone-book entry.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_PORT_NOT_OPEN</b></dt> </dl> </td> <td width="60%"> The
///    <i>hRasConn</i> and <i>dwSubEntry</i> parameters are valid, but the specified subentry is not connected. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> The value
///    specified by <i>dwSubEntry</i> exceeds the maximum number of subentries for the phone-book entry. </td> </tr>
///    </table>
///    
@DllImport("RASAPI32")
uint RasGetSubEntryHandleA(HRASCONN__* param0, uint param1, HRASCONN__** param2);

///The <b>RasGetSubEntryHandle</b> function retrieves a connection handle for a specified subentry of a multilink
///connection.
///Params:
///    arg1 = Specifies the <b>HRASCONN</b> connection handle returned by the RasDial function for a multilink phone-book
///           entry.
///    arg2 = Specifies a valid subentry index for the phone-book entry.
///    arg3 = Pointer to the <b>HRASCONN</b> variable that receives a connection handle that represents the subentry
///           connection.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl>
///    </td> <td width="60%"> The <i>hRasConn</i> connection handle does not represent a connected phone-book entry.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_PORT_NOT_OPEN</b></dt> </dl> </td> <td width="60%"> The
///    <i>hRasConn</i> and <i>dwSubEntry</i> parameters are valid, but the specified subentry is not connected. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> The value
///    specified by <i>dwSubEntry</i> exceeds the maximum number of subentries for the phone-book entry. </td> </tr>
///    </table>
///    
@DllImport("RASAPI32")
uint RasGetSubEntryHandleW(HRASCONN__* param0, uint param1, HRASCONN__** param2);

///The <b>RasGetCredentials</b> function retrieves the user credentials associated with a specified RAS phone-book
///entry.
///Params:
///    arg1 = Pointer to a <b>null</b>-terminated string that specifies the full path and file name of a phone-book (PBK) file.
///           If this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book
///           file is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up
///           Networking</b> dialog box.
///    arg2 = Pointer to a <b>null</b>-terminated string that specifies the name of a phone-book entry.
///    arg3 = Pointer to the RASCREDENTIALS structure that, on output, receives the user credentials associated with the
///           specified phone-book entry. On input, set the <b>dwSize</b> member of the structure to sizeof(RASCREDENTIALS),
///           and set the <b>dwMask</b> member to indicate the credential information to retrieve. When the function returns,
///           <b>dwMask</b> indicates the members that were successfully retrieved.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_OPEN_PHONEBOOK</b></dt>
///    </dl> </td> <td width="60%"> The specified phone book cannot be found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANNOT_FIND_PHONEBOOK_ENTRY</b></dt> </dl> </td> <td width="60%"> The specified entry does not exist
///    in the phone book. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The <i>lpCredentials</i> parameter was <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_SIZE</b></dt> </dl> </td> <td width="60%"> The <b>dwSize</b> member of the RASCREDENTIALS
///    structure is an unrecognized value. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasGetCredentialsA(const(PSTR) param0, const(PSTR) param1, tagRASCREDENTIALSA* param2);

///The <b>RasGetCredentials</b> function retrieves the user credentials associated with a specified RAS phone-book
///entry.
///Params:
///    arg1 = Pointer to a <b>null</b>-terminated string that specifies the full path and file name of a phone-book (PBK) file.
///           If this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book
///           file is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up
///           Networking</b> dialog box.
///    arg2 = Pointer to a <b>null</b>-terminated string that specifies the name of a phone-book entry.
///    arg3 = Pointer to the RASCREDENTIALS structure that, on output, receives the user credentials associated with the
///           specified phone-book entry. On input, set the <b>dwSize</b> member of the structure to sizeof(RASCREDENTIALS),
///           and set the <b>dwMask</b> member to indicate the credential information to retrieve. When the function returns,
///           <b>dwMask</b> indicates the members that were successfully retrieved.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_OPEN_PHONEBOOK</b></dt>
///    </dl> </td> <td width="60%"> The specified phone book cannot be found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANNOT_FIND_PHONEBOOK_ENTRY</b></dt> </dl> </td> <td width="60%"> The specified entry does not exist
///    in the phone book. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The <i>lpCredentials</i> parameter was <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_SIZE</b></dt> </dl> </td> <td width="60%"> The <b>dwSize</b> member of the RASCREDENTIALS
///    structure is an unrecognized value. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasGetCredentialsW(const(PWSTR) param0, const(PWSTR) param1, tagRASCREDENTIALSW* param2);

///The <b>RasSetCredentials</b> function sets the user credentials associated with a specified RAS phone-book entry.
///Params:
///    arg1 = A pointer to a null-terminated string that specifies the full path and file name of a phone-book (PBK) file. If
///           this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book file
///           is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up Networking</b>
///           dialog box.
///    arg2 = A pointer to a null-terminated string that specifies the name of a phone-book entry.
///    arg3 = A pointer to a RASCREDENTIALS structure that specifies the user credentials to set for the specified phone-book
///           entry. Before calling <b>RasSetCredentials</b>, set the <b>dwSize</b> member of the structure to
///           <code>sizeof(RASCREDENTIALS)</code> and set the <b>dwMask</b> member to indicate the credential information to be
///           set.
///    arg4 = A value that specifies whether <b>RasSetCredentials</b> clears existing credentials by setting them to the empty
///           string, "". If this flag is <b>TRUE</b>, the <b>dwMask</b> member of the RASCREDENTIALS structure indicates which
///           credentials that the function sets to the empty string. If this flag is <b>FALSE</b>, the function sets the
///           indicated credentials according to the contents of their corresponding <b>RASCREDENTIALS</b> members.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or WinError.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_OPEN_PHONEBOOK</b></dt>
///    </dl> </td> <td width="60%"> The specified phone book cannot be found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>lpCredentials</i> parameter was
///    <b>NULL</b>, or the specified entry does not exist in the phone book. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> One of the following conditions occurred: <ul>
///    <li>The calling application attempted to set default credentials for a per-user connection. Default credentials
///    can be set only for an all-user connection.</li> <li>The user does not have the correct privileges to set
///    pre-shared keys or credentials for all users in case of all-user connectoids. Only administrators can complete
///    these tasks.</li> </ul> </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasSetCredentialsA(const(PSTR) param0, const(PSTR) param1, tagRASCREDENTIALSA* param2, BOOL param3);

///The <b>RasSetCredentials</b> function sets the user credentials associated with a specified RAS phone-book entry.
///Params:
///    arg1 = A pointer to a null-terminated string that specifies the full path and file name of a phone-book (PBK) file. If
///           this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book file
///           is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up Networking</b>
///           dialog box.
///    arg2 = A pointer to a null-terminated string that specifies the name of a phone-book entry.
///    arg3 = A pointer to a RASCREDENTIALS structure that specifies the user credentials to set for the specified phone-book
///           entry. Before calling <b>RasSetCredentials</b>, set the <b>dwSize</b> member of the structure to
///           <code>sizeof(RASCREDENTIALS)</code> and set the <b>dwMask</b> member to indicate the credential information to be
///           set.
///    arg4 = A value that specifies whether <b>RasSetCredentials</b> clears existing credentials by setting them to the empty
///           string, "". If this flag is <b>TRUE</b>, the <b>dwMask</b> member of the RASCREDENTIALS structure indicates which
///           credentials that the function sets to the empty string. If this flag is <b>FALSE</b>, the function sets the
///           indicated credentials according to the contents of their corresponding <b>RASCREDENTIALS</b> members.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or WinError.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_OPEN_PHONEBOOK</b></dt>
///    </dl> </td> <td width="60%"> The specified phone book cannot be found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>lpCredentials</i> parameter was
///    <b>NULL</b>, or the specified entry does not exist in the phone book. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> One of the following conditions occurred: <ul>
///    <li>The calling application attempted to set default credentials for a per-user connection. Default credentials
///    can be set only for an all-user connection.</li> <li>The user does not have the correct privileges to set
///    pre-shared keys or credentials for all users in case of all-user connectoids. Only administrators can complete
///    these tasks.</li> </ul> </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasSetCredentialsW(const(PWSTR) param0, const(PWSTR) param1, tagRASCREDENTIALSW* param2, BOOL param3);

///The <b>RasGetSubEntryProperties</b> function retrieves information about a subentry for a specified phone-book entry.
///Params:
///    arg1 = Pointer to a <b>null</b>-terminated string that specifies the full path and file name of a phone-book (PBK) file.
///           If this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book
///           file is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up
///           Networking</b> dialog box. <b>Windows Me/98/95: </b>This parameter should always be <b>NULL</b>. Dial-up
///           networking stores phone-book entries in the registry rather than in a phone-book file.
///    arg2 = Pointer to a <b>null</b>-terminated string that specifies the name of an existing entry in the phone book.
///    arg3 = Specifies the one-based index of the subentry.
///    arg4 = Pointer to the RASSUBENTRY structure followed by additional bytes for the alternate phone number list, if there
///           is one. On output, the structure receives information about the specified subentry. On input, the <b>dwSize</b>
///           member specifies the size of the structure. The size identifies the version of the structure. Obtain this size
///           using sizeof(RASSUBENTRY). This parameter can be <b>NULL</b>.
///    arg5 = Pointer to a variable that specifies, on input, the size, in bytes, of the <i>lpRasSubEntry</i> buffer. On
///           output, the variable receives the number of bytes returned, or the number of bytes required if the buffer is too
///           small. This parameter can be <b>NULL</b> if <i>lpRasSubEntry</i> is <b>NULL</b>.
///    arg6 = Pointer to a TAPI device configuration block. This parameter is currently unused. The caller should pass
///           <b>NULL</b> for this parameter. For more information about TAPI device configuration blocks, see the function
///           lineGetDevConfig.
///    arg7 = Pointer to a <b>DWORD</b> that specifies the size of the TAPI device configuration block. This parameter is
///           currently unused. The caller should pass <b>NULL</b> for this parameter.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt>
///    </dl> </td> <td width="60%"> The function was called with an invalid parameter. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_BUFFER_INVALID</b></dt> </dl> </td> <td width="60%"> The address or buffer specified by
///    <i>lpRasSubEntry</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUFFER_TOO_SMALL</b></dt>
///    </dl> </td> <td width="60%"> The <i>lpRasSubEntry</i> buffer is too small. The <i>lpdwcb</i> variable receives
///    the required buffer size. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_OPEN_PHONEBOOK</b></dt>
///    </dl> </td> <td width="60%"> The phone book is corrupted or is missing components. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_CANNOT_FIND_PHONEBOOK_ENTRY</b></dt> </dl> </td> <td width="60%"> The phone-book
///    entry does not exist. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasGetSubEntryPropertiesA(const(PSTR) param0, const(PSTR) param1, uint param2, tagRASSUBENTRYA* param3, 
                               uint* param4, ubyte* param5, uint* param6);

///The <b>RasGetSubEntryProperties</b> function retrieves information about a subentry for a specified phone-book entry.
///Params:
///    arg1 = Pointer to a <b>null</b>-terminated string that specifies the full path and file name of a phone-book (PBK) file.
///           If this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book
///           file is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up
///           Networking</b> dialog box. <b>Windows Me/98/95: </b>This parameter should always be <b>NULL</b>. Dial-up
///           networking stores phone-book entries in the registry rather than in a phone-book file.
///    arg2 = Pointer to a <b>null</b>-terminated string that specifies the name of an existing entry in the phone book.
///    arg3 = Specifies the one-based index of the subentry.
///    arg4 = Pointer to the RASSUBENTRY structure followed by additional bytes for the alternate phone number list, if there
///           is one. On output, the structure receives information about the specified subentry. On input, the <b>dwSize</b>
///           member specifies the size of the structure. The size identifies the version of the structure. Obtain this size
///           using sizeof(RASSUBENTRY). This parameter can be <b>NULL</b>.
///    arg5 = Pointer to a variable that specifies, on input, the size, in bytes, of the <i>lpRasSubEntry</i> buffer. On
///           output, the variable receives the number of bytes returned, or the number of bytes required if the buffer is too
///           small. This parameter can be <b>NULL</b> if <i>lpRasSubEntry</i> is <b>NULL</b>.
///    arg6 = Pointer to a TAPI device configuration block. This parameter is currently unused. The caller should pass
///           <b>NULL</b> for this parameter. For more information about TAPI device configuration blocks, see the function
///           lineGetDevConfig.
///    arg7 = Pointer to a <b>DWORD</b> that specifies the size of the TAPI device configuration block. This parameter is
///           currently unused. The caller should pass <b>NULL</b> for this parameter.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt>
///    </dl> </td> <td width="60%"> The function was called with an invalid parameter. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_BUFFER_INVALID</b></dt> </dl> </td> <td width="60%"> The address or buffer specified by
///    <i>lpRasSubEntry</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUFFER_TOO_SMALL</b></dt>
///    </dl> </td> <td width="60%"> The <i>lpRasSubEntry</i> buffer is too small. The <i>lpdwcb</i> variable receives
///    the required buffer size. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_OPEN_PHONEBOOK</b></dt>
///    </dl> </td> <td width="60%"> The phone book is corrupted or is missing components. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_CANNOT_FIND_PHONEBOOK_ENTRY</b></dt> </dl> </td> <td width="60%"> The phone-book
///    entry does not exist. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasGetSubEntryPropertiesW(const(PWSTR) param0, const(PWSTR) param1, uint param2, tagRASSUBENTRYW* param3, 
                               uint* param4, ubyte* param5, uint* param6);

///The <b>RasSetSubEntryProperties</b> function creates a new subentry or modifies an existing subentry of a specified
///phone-book entry.
///Params:
///    arg1 = Pointer to a <b>null</b>-terminated string that specifies the full path and file name of a phone-book (PBK) file.
///           If this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book
///           file is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up
///           Networking</b> dialog box. <b>Windows Me/98/95: </b>This parameter should always be <b>NULL</b>. Dial-up
///           networking stores phone-book entries in the registry rather than in a phone-book file.
///    arg2 = Pointer to a <b>null</b>-terminated string that specifies the name of an existing entry in the phone book.
///    arg3 = Specifies the one-based index of the subentry. If the index matches an existing subentry index, the function
///           changes the properties of that subentry. If the index does not match an existing index, the function creates a
///           new subentry.
///    arg4 = Pointer to the RASSUBENTRY structure that specifies the data for the subentry. The structure might be followed by
///           an array of <b>null</b>-terminated alternate phone number strings. The last string is terminated by two
///           consecutive <b>null</b> characters. The <b>dwAlternateOffset</b> member of the RASSUBENTRY structure contains the
///           offset to the first string.
///    arg5 = Specifies the size, in bytes, of the <i>lpRasSubEntry</i> buffer.
///    arg6 = Pointer to a TAPI device configuration block. This parameter is currently unused. The caller should pass
///           <b>NULL</b> for this parameter. For more information about TAPI device configuration blocks, see the function
///           lineGetDevConfig.
///    arg7 = Specifies the size of the TAPI device configuration block. This parameter is currently unused. The caller should
///           pass zero for this parameter.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUFFER_INVALID</b></dt> </dl>
///    </td> <td width="60%"> The address or buffer specified by <i>lpRasEntry</i> is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_CANNOT_FIND_PHONEBOOK_ENTRY</b></dt> </dl> </td> <td width="60%"> The phone-book
///    entry does not exist. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_OPEN_PHONEBOOK</b></dt> </dl>
///    </td> <td width="60%"> The phone book is corrupted or missing components. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The function was called with an invalid
///    parameter. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasSetSubEntryPropertiesA(const(PSTR) param0, const(PSTR) param1, uint param2, tagRASSUBENTRYA* param3, 
                               uint param4, ubyte* param5, uint param6);

///The <b>RasSetSubEntryProperties</b> function creates a new subentry or modifies an existing subentry of a specified
///phone-book entry.
///Params:
///    arg1 = Pointer to a <b>null</b>-terminated string that specifies the full path and file name of a phone-book (PBK) file.
///           If this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book
///           file is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up
///           Networking</b> dialog box. <b>Windows Me/98/95: </b>This parameter should always be <b>NULL</b>. Dial-up
///           networking stores phone-book entries in the registry rather than in a phone-book file.
///    arg2 = Pointer to a <b>null</b>-terminated string that specifies the name of an existing entry in the phone book.
///    arg3 = Specifies the one-based index of the subentry. If the index matches an existing subentry index, the function
///           changes the properties of that subentry. If the index does not match an existing index, the function creates a
///           new subentry.
///    arg4 = Pointer to the RASSUBENTRY structure that specifies the data for the subentry. The structure might be followed by
///           an array of <b>null</b>-terminated alternate phone number strings. The last string is terminated by two
///           consecutive <b>null</b> characters. The <b>dwAlternateOffset</b> member of the RASSUBENTRY structure contains the
///           offset to the first string.
///    arg5 = Specifies the size, in bytes, of the <i>lpRasSubEntry</i> buffer.
///    arg6 = Pointer to a TAPI device configuration block. This parameter is currently unused. The caller should pass
///           <b>NULL</b> for this parameter. For more information about TAPI device configuration blocks, see the function
///           lineGetDevConfig.
///    arg7 = Specifies the size of the TAPI device configuration block. This parameter is currently unused. The caller should
///           pass zero for this parameter.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUFFER_INVALID</b></dt> </dl>
///    </td> <td width="60%"> The address or buffer specified by <i>lpRasEntry</i> is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_CANNOT_FIND_PHONEBOOK_ENTRY</b></dt> </dl> </td> <td width="60%"> The phone-book
///    entry does not exist. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_OPEN_PHONEBOOK</b></dt> </dl>
///    </td> <td width="60%"> The phone book is corrupted or missing components. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The function was called with an invalid
///    parameter. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasSetSubEntryPropertiesW(const(PWSTR) param0, const(PWSTR) param1, uint param2, tagRASSUBENTRYW* param3, 
                               uint param4, ubyte* param5, uint param6);

///The <b>RasGetAutodialAddress</b> function retrieves information about all the AutoDial entries associated with a
///network address in the AutoDial mapping database.
///Params:
///    arg1 = Pointer to a <b>null</b>-terminated string that specifies the address for which information is requested. This
///           can be an IP address, Internet host name ("www.microsoft.com"), or NetBIOS name ("products1"). If this parameter
///           is <b>NULL</b>, the function retrieves the default Internet connection. The function returns the per-user default
///           Internet connection if one is configured. Otherwise, the function returns the global default Internet connection.
///           If no default Internet connections are configured, the function returns zero for the <i>lpdwcbAutoDialEntries</i>
///           and <i>lpdwcAutoDialEntries</i> parameters.
///    arg2 = Reserved; must be <b>NULL</b>.
///    arg3 = Pointer to a buffer that, on output, receives an array of RASAUTODIALENTRY structures, one for each AutoDial
///           entry associated with the address specified by the <i>lpszAddress</i> parameter. On input, set the <b>dwSize</b>
///           member of the first RASAUTODIALENTRY structure in the buffer to sizeof(RASAUTODIALENTRY) to identify the version
///           of the structure. If <i>lpAutoDialEntries</i> is <b>NULL</b>, <b>RasGetAutodialAddress</b> sets the
///           <i>lpdwcbAutoDialEntries</i> and <i>lpdwcAutoDialEntries</i> parameters to indicate the required buffer size, in
///           bytes, and the number of AutoDial entries.
///    arg4 = Pointer to a variable that, on input, specifies the size, in bytes, of the <i>lpAutoDialEntries</i> buffer. On
///           output, this variable receives the number of bytes returned, or the number of bytes required if the buffer is too
///           small.
///    arg5 = Pointer to a variable that receives the number of structure elements returned in the <i>lpAutoDialEntries</i>
///           buffer.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_SIZE</b></dt> </dl>
///    </td> <td width="60%"> The <b>dwSize</b> member of the RASAUTODIALENTRY structure is an invalid value. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The
///    <i>lpszAddress</i>, <i>lpdwcbAutoDialEntries</i>, or <i>lpdwcAutoDialEntries</i> parameter was <b>NULL</b>. </td>
///    </tr> </table>
///    
@DllImport("RASAPI32")
uint RasGetAutodialAddressA(const(PSTR) param0, uint* param1, tagRASAUTODIALENTRYA* param2, uint* param3, 
                            uint* param4);

///The <b>RasGetAutodialAddress</b> function retrieves information about all the AutoDial entries associated with a
///network address in the AutoDial mapping database.
///Params:
///    arg1 = Pointer to a <b>null</b>-terminated string that specifies the address for which information is requested. This
///           can be an IP address, Internet host name ("www.microsoft.com"), or NetBIOS name ("products1"). If this parameter
///           is <b>NULL</b>, the function retrieves the default Internet connection. The function returns the per-user default
///           Internet connection if one is configured. Otherwise, the function returns the global default Internet connection.
///           If no default Internet connections are configured, the function returns zero for the <i>lpdwcbAutoDialEntries</i>
///           and <i>lpdwcAutoDialEntries</i> parameters.
///    arg2 = Reserved; must be <b>NULL</b>.
///    arg3 = Pointer to a buffer that, on output, receives an array of RASAUTODIALENTRY structures, one for each AutoDial
///           entry associated with the address specified by the <i>lpszAddress</i> parameter. On input, set the <b>dwSize</b>
///           member of the first RASAUTODIALENTRY structure in the buffer to sizeof(RASAUTODIALENTRY) to identify the version
///           of the structure. If <i>lpAutoDialEntries</i> is <b>NULL</b>, <b>RasGetAutodialAddress</b> sets the
///           <i>lpdwcbAutoDialEntries</i> and <i>lpdwcAutoDialEntries</i> parameters to indicate the required buffer size, in
///           bytes, and the number of AutoDial entries.
///    arg4 = Pointer to a variable that, on input, specifies the size, in bytes, of the <i>lpAutoDialEntries</i> buffer. On
///           output, this variable receives the number of bytes returned, or the number of bytes required if the buffer is too
///           small.
///    arg5 = Pointer to a variable that receives the number of structure elements returned in the <i>lpAutoDialEntries</i>
///           buffer.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_SIZE</b></dt> </dl>
///    </td> <td width="60%"> The <b>dwSize</b> member of the RASAUTODIALENTRY structure is an invalid value. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The
///    <i>lpszAddress</i>, <i>lpdwcbAutoDialEntries</i>, or <i>lpdwcAutoDialEntries</i> parameter was <b>NULL</b>. </td>
///    </tr> </table>
///    
@DllImport("RASAPI32")
uint RasGetAutodialAddressW(const(PWSTR) param0, uint* param1, tagRASAUTODIALENTRYW* param2, uint* param3, 
                            uint* param4);

///The <b>RasSetAutodialAddress</b> function can add an address to the AutoDial mapping database. Alternatively, the
///function can delete or modify the data associated with an existing address in the database.
///Params:
///    arg1 = Pointer to a <b>null</b>-terminated string that specifies the address to add, delete, or modify. This address can
///           be an IP address, Internet host name ("www.microsoft.com"), or NetBIOS name ("products1"). If this parameter is
///           <b>NULL</b>, the function sets the default Internet connection (see Remarks). If this parameter points to a
///           zero-length string, the function deletes the default Internet connection.
///    arg2 = Reserved; must be zero.
///    arg3 = Pointer to an array of one or more RASAUTODIALENTRY structures to be associated with the <i>lpszAddress</i>
///           address. If <i>lpAutoDialEntries</i> is <b>NULL</b> and <i>dwcbAutoDialEntries</i> is zero,
///           <b>RasSetAutodialAddress</b> deletes all structures associated with <i>lpszAddress</i> from the mapping database.
///    arg4 = Specifies the size, in bytes, of the <i>lpAutoDialEntries</i> buffer.
///    arg5 = Specifies the number of RASAUTODIALENTRY structures in the <i>lpAutoDialEntries</i> buffer.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_SIZE</b></dt> </dl>
///    </td> <td width="60%"> The <b>dwSize</b> member of the RASAUTODIALENTRY structure is an invalid value. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The
///    <i>lpszAddress</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANNOT_FIND_PHONEBOOK_ENTRY</b></dt> </dl> </td> <td width="60%"> The connection name specified in
///    <i>lpAutoDialEntries</i> does not exist. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasSetAutodialAddressA(const(PSTR) param0, uint param1, tagRASAUTODIALENTRYA* param2, uint param3, 
                            uint param4);

///The <b>RasSetAutodialAddress</b> function can add an address to the AutoDial mapping database. Alternatively, the
///function can delete or modify the data associated with an existing address in the database.
///Params:
///    arg1 = Pointer to a <b>null</b>-terminated string that specifies the address to add, delete, or modify. This address can
///           be an IP address, Internet host name ("www.microsoft.com"), or NetBIOS name ("products1"). If this parameter is
///           <b>NULL</b>, the function sets the default Internet connection (see Remarks). If this parameter points to a
///           zero-length string, the function deletes the default Internet connection.
///    arg2 = Reserved; must be zero.
///    arg3 = Pointer to an array of one or more RASAUTODIALENTRY structures to be associated with the <i>lpszAddress</i>
///           address. If <i>lpAutoDialEntries</i> is <b>NULL</b> and <i>dwcbAutoDialEntries</i> is zero,
///           <b>RasSetAutodialAddress</b> deletes all structures associated with <i>lpszAddress</i> from the mapping database.
///    arg4 = Specifies the size, in bytes, of the <i>lpAutoDialEntries</i> buffer.
///    arg5 = Specifies the number of RASAUTODIALENTRY structures in the <i>lpAutoDialEntries</i> buffer.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_SIZE</b></dt> </dl>
///    </td> <td width="60%"> The <b>dwSize</b> member of the RASAUTODIALENTRY structure is an invalid value. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The
///    <i>lpszAddress</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANNOT_FIND_PHONEBOOK_ENTRY</b></dt> </dl> </td> <td width="60%"> The connection name specified in
///    <i>lpAutoDialEntries</i> does not exist. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasSetAutodialAddressW(const(PWSTR) param0, uint param1, tagRASAUTODIALENTRYW* param2, uint param3, 
                            uint param4);

///The <b>RasEnumAutodialAddresses</b> function returns a list of all addresses in the AutoDial mapping database.
///Params:
///    lppRasAutodialAddresses = Pointer to an array of string pointers, with additional space for the storage of the strings themselves at the
///                              end of the buffer. On output, each string receives the name of an address in the AutoDial mapping database. If
///                              <i>lppAddresses</i> is <b>NULL</b> on input, <b>RasEnumAutodialAddresses</b> sets the <i>lpdwcbAddresses</i> and
///                              <i>lpdwcAddresses</i> parameters to indicate the required size, in bytes, and the number of address entries in
///                              the database.
///    lpdwcbRasAutodialAddresses = Pointer to a variable that, on input, contains the size, in bytes, of the buffer specified by the
///                                 <i>lpRasEnumAutodialAddressespAddresses</i> parameter. <div class="alert"><b>Note</b> <p class="note">To
///                                 determine the required buffer size, call <b>RasEnumAutodialAddresses</b> with <i>lppAddresses</i> set to
///                                 <b>NULL</b>. The variable pointed to by <i>lpdwcbAddresses</i> should be set to zero. The function will return
///                                 the required buffer size in <i>lpdwcbAddresses</i> and an error code of <b>ERROR_BUFFER_TOO_SMALL</b>. </div>
///                                 <div> </div>
///    lpdwcRasAutodialAddresses = Pointer to a variable that receives the number of address strings returned in the <i>lppAddresses</i> buffer.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt>
///    </dl> </td> <td width="60%"> <b>NULL</b> was passed for the <i>lpdwcbAddresses</i> or <i>lpdwcAddresses</i>
///    parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUFFER_TOO_SMALL</b></dt> </dl> </td> <td
///    width="60%"> The <i>lppAddresses</i> buffer was <b>NULL</b> and <i>lpdwcbAddresses</i> was zero. The function
///    returns the required buffer size in the variable pointed to by <i>lpdwcbAddresses</i>. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasEnumAutodialAddressesA(PSTR* lppRasAutodialAddresses, uint* lpdwcbRasAutodialAddresses, 
                               uint* lpdwcRasAutodialAddresses);

///The <b>RasEnumAutodialAddresses</b> function returns a list of all addresses in the AutoDial mapping database.
///Params:
///    lppRasAutodialAddresses = Pointer to an array of string pointers, with additional space for the storage of the strings themselves at the
///                              end of the buffer. On output, each string receives the name of an address in the AutoDial mapping database. If
///                              <i>lppAddresses</i> is <b>NULL</b> on input, <b>RasEnumAutodialAddresses</b> sets the <i>lpdwcbAddresses</i> and
///                              <i>lpdwcAddresses</i> parameters to indicate the required size, in bytes, and the number of address entries in
///                              the database.
///    lpdwcbRasAutodialAddresses = Pointer to a variable that, on input, contains the size, in bytes, of the buffer specified by the
///                                 <i>lpRasEnumAutodialAddressespAddresses</i> parameter. <div class="alert"><b>Note</b> <p class="note">To
///                                 determine the required buffer size, call <b>RasEnumAutodialAddresses</b> with <i>lppAddresses</i> set to
///                                 <b>NULL</b>. The variable pointed to by <i>lpdwcbAddresses</i> should be set to zero. The function will return
///                                 the required buffer size in <i>lpdwcbAddresses</i> and an error code of <b>ERROR_BUFFER_TOO_SMALL</b>. </div>
///                                 <div> </div>
///    lpdwcRasAutodialAddresses = Pointer to a variable that receives the number of address strings returned in the <i>lppAddresses</i> buffer.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt>
///    </dl> </td> <td width="60%"> <b>NULL</b> was passed for the <i>lpdwcbAddresses</i> or <i>lpdwcAddresses</i>
///    parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUFFER_TOO_SMALL</b></dt> </dl> </td> <td
///    width="60%"> The <i>lppAddresses</i> buffer was <b>NULL</b> and <i>lpdwcbAddresses</i> was zero. The function
///    returns the required buffer size in the variable pointed to by <i>lpdwcbAddresses</i>. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasEnumAutodialAddressesW(PWSTR* lppRasAutodialAddresses, uint* lpdwcbRasAutodialAddresses, 
                               uint* lpdwcRasAutodialAddresses);

///The <b>RasGetAutodialEnable</b> function indicates whether the AutoDial feature is enabled for a specified TAPI
///dialing location. For more information about TAPI dialing locations, see the TAPI Programmer's Reference in the
///Platform Software Development Kit (SDK).
///Params:
///    arg1 = Specifies the identifier of a TAPI dialing location.
///    arg2 = Pointer to a BOOL variable that receives a nonzero value if AutoDial is enabled for the specified dialing
///           location, or zero if it is not enabled.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    from Routing and Remote Access Error Codes or Winerror.h.
///    
@DllImport("RASAPI32")
uint RasGetAutodialEnableA(uint param0, int* param1);

///The <b>RasGetAutodialEnable</b> function indicates whether the AutoDial feature is enabled for a specified TAPI
///dialing location. For more information about TAPI dialing locations, see the TAPI Programmer's Reference in the
///Platform Software Development Kit (SDK).
///Params:
///    arg1 = Specifies the identifier of a TAPI dialing location.
///    arg2 = Pointer to a BOOL variable that receives a nonzero value if AutoDial is enabled for the specified dialing
///           location, or zero if it is not enabled.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    from Routing and Remote Access Error Codes or Winerror.h.
///    
@DllImport("RASAPI32")
uint RasGetAutodialEnableW(uint param0, int* param1);

///The <b>RasSetAutodialEnable</b> function enables or disables the AutoDial feature for a specified TAPI dialing
///location. For more information about TAPI dialing locations, see Telephony Application Programming Interfaces (TAPI)
///in the Platform Software Development Kit (SDK).
///Params:
///    arg1 = Specifies the identifier of a TAPI dialing location.
///    arg2 = Specifies <b>TRUE</b> to enable AutoDial for the dialing location indicated by the <i>dwDialingLocation</i>
///           parameter. Specifies <b>FALSE</b> to disable it.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is a
///    non-zero error code from Routing and Remote Access Error Codes or Winerror.h.
///    
@DllImport("RASAPI32")
uint RasSetAutodialEnableA(uint param0, BOOL param1);

///The <b>RasSetAutodialEnable</b> function enables or disables the AutoDial feature for a specified TAPI dialing
///location. For more information about TAPI dialing locations, see Telephony Application Programming Interfaces (TAPI)
///in the Platform Software Development Kit (SDK).
///Params:
///    arg1 = Specifies the identifier of a TAPI dialing location.
///    arg2 = Specifies <b>TRUE</b> to enable AutoDial for the dialing location indicated by the <i>dwDialingLocation</i>
///           parameter. Specifies <b>FALSE</b> to disable it.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is a
///    non-zero error code from Routing and Remote Access Error Codes or Winerror.h.
///    
@DllImport("RASAPI32")
uint RasSetAutodialEnableW(uint param0, BOOL param1);

///The <b>RasGetAutodialParam</b> function retrieves the value of an AutoDial parameter.
///Params:
///    arg1 = Specifies the AutoDial parameter to retrieve. This parameter can be one of the following values. <table> <tr>
///           <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RASADP_DisableConnectionQuery"></a><a
///           id="rasadp_disableconnectionquery"></a><a id="RASADP_DISABLECONNECTIONQUERY"></a><dl>
///           <dt><b>RASADP_DisableConnectionQuery</b></dt> </dl> </td> <td width="60%"> The <i>lpvValue</i> parameter returns
///           a <b>DWORD</b> value. If this value is zero (the default), AutoDial displays a dialog box to query the user
///           before creating a connection. If this value is 1, and the AutoDial database has the phone-book entry to dial,
///           AutoDial creates a connection without displaying the dialog box. </td> </tr> <tr> <td width="40%"><a
///           id="RASADP_LoginSessionDisable"></a><a id="rasadp_loginsessiondisable"></a><a
///           id="RASADP_LOGINSESSIONDISABLE"></a><dl> <dt><b>RASADP_LoginSessionDisable</b></dt> </dl> </td> <td width="60%">
///           The <i>lpvValue</i> parameter returns a <b>DWORD</b> value. If this value is 1, the system disables all AutoDial
///           connections for the current logon session. If this value is zero (the default), AutoDial connections are enabled.
///           The AutoDial system service changes this value to zero when a new user logs on to the workstation. </td> </tr>
///           <tr> <td width="40%"><a id="RASADP_SavedAddressesLimit"></a><a id="rasadp_savedaddresseslimit"></a><a
///           id="RASADP_SAVEDADDRESSESLIMIT"></a><dl> <dt><b>RASADP_SavedAddressesLimit</b></dt> </dl> </td> <td width="60%">
///           The <i>lpvValue</i> parameter returns a <b>DWORD</b> value that indicates the maximum number of addresses that
///           AutoDial stores in the registry. AutoDial first stores addresses that it used to create an AutoDial connection;
///           then it stores addresses that it learned after a RAS connection was created. Addresses written using the
///           RasSetAutodialAddress function are always saved, and are not included in calculating the limit. The default value
///           is 100. </td> </tr> <tr> <td width="40%"><a id="RASADP_FailedConnectionTimeout"></a><a
///           id="rasadp_failedconnectiontimeout"></a><a id="RASADP_FAILEDCONNECTIONTIMEOUT"></a><dl>
///           <dt><b>RASADP_FailedConnectionTimeout</b></dt> </dl> </td> <td width="60%"> The <i>lpvValue</i> parameter returns
///           a <b>DWORD</b> value that indicates a time-out value, in seconds. When an AutoDial connection attempt fails, the
///           AutoDial system service disables subsequent attempts to reach the same address for the time-out period. This
///           prevents AutoDial from displaying multiple connection dialog boxes for the same logical request by an
///           application. The default value is 5. </td> </tr> <tr> <td width="40%"><a
///           id="RASADP_ConnectionQueryTimeout"></a><a id="rasadp_connectionquerytimeout"></a><a
///           id="RASADP_CONNECTIONQUERYTIMEOUT"></a><dl> <dt><b>RASADP_ConnectionQueryTimeout</b></dt> </dl> </td> <td
///           width="60%"> The <i>lpvValue</i> parameter points to a <b>DWORD</b> value that indicates a time-out value, in
///           seconds. Before attempting an AutoDial connection, the system will display a dialog asking the user to confirm
///           that the system should dial. The dialog has a countdown timer that terminates the dialog with a "Do not dial"
///           selection if the user takes no action. The <b>DWORD</b> value pointed to by <i>lpvValue</i> specifies the initial
///           time on this countdown timer. </td> </tr> </table>
///    arg2 = Pointer to a buffer that receives the value for the specified parameter.
///    arg3 = Pointer to a <b>DWORD</b> value. On input, set this value to indicate the size, in bytes, of the <i>lpvValue</i>
///           buffer. On output, this value indicates the actual size of the value written to the buffer.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt>
///    </dl> </td> <td width="60%"> The <i>dwKey</i> or <i>lpvValue</i> parameter is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_SIZE</b></dt> </dl> </td> <td width="60%"> The size specified by the
///    <i>lpdwcbValue</i> is too small. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasGetAutodialParamA(uint param0, void* param1, uint* param2);

///The <b>RasGetAutodialParam</b> function retrieves the value of an AutoDial parameter.
///Params:
///    arg1 = Specifies the AutoDial parameter to retrieve. This parameter can be one of the following values. <table> <tr>
///           <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RASADP_DisableConnectionQuery"></a><a
///           id="rasadp_disableconnectionquery"></a><a id="RASADP_DISABLECONNECTIONQUERY"></a><dl>
///           <dt><b>RASADP_DisableConnectionQuery</b></dt> </dl> </td> <td width="60%"> The <i>lpvValue</i> parameter returns
///           a <b>DWORD</b> value. If this value is zero (the default), AutoDial displays a dialog box to query the user
///           before creating a connection. If this value is 1, and the AutoDial database has the phone-book entry to dial,
///           AutoDial creates a connection without displaying the dialog box. </td> </tr> <tr> <td width="40%"><a
///           id="RASADP_LoginSessionDisable"></a><a id="rasadp_loginsessiondisable"></a><a
///           id="RASADP_LOGINSESSIONDISABLE"></a><dl> <dt><b>RASADP_LoginSessionDisable</b></dt> </dl> </td> <td width="60%">
///           The <i>lpvValue</i> parameter returns a <b>DWORD</b> value. If this value is 1, the system disables all AutoDial
///           connections for the current logon session. If this value is zero (the default), AutoDial connections are enabled.
///           The AutoDial system service changes this value to zero when a new user logs on to the workstation. </td> </tr>
///           <tr> <td width="40%"><a id="RASADP_SavedAddressesLimit"></a><a id="rasadp_savedaddresseslimit"></a><a
///           id="RASADP_SAVEDADDRESSESLIMIT"></a><dl> <dt><b>RASADP_SavedAddressesLimit</b></dt> </dl> </td> <td width="60%">
///           The <i>lpvValue</i> parameter returns a <b>DWORD</b> value that indicates the maximum number of addresses that
///           AutoDial stores in the registry. AutoDial first stores addresses that it used to create an AutoDial connection;
///           then it stores addresses that it learned after a RAS connection was created. Addresses written using the
///           RasSetAutodialAddress function are always saved, and are not included in calculating the limit. The default value
///           is 100. </td> </tr> <tr> <td width="40%"><a id="RASADP_FailedConnectionTimeout"></a><a
///           id="rasadp_failedconnectiontimeout"></a><a id="RASADP_FAILEDCONNECTIONTIMEOUT"></a><dl>
///           <dt><b>RASADP_FailedConnectionTimeout</b></dt> </dl> </td> <td width="60%"> The <i>lpvValue</i> parameter returns
///           a <b>DWORD</b> value that indicates a time-out value, in seconds. When an AutoDial connection attempt fails, the
///           AutoDial system service disables subsequent attempts to reach the same address for the time-out period. This
///           prevents AutoDial from displaying multiple connection dialog boxes for the same logical request by an
///           application. The default value is 5. </td> </tr> <tr> <td width="40%"><a
///           id="RASADP_ConnectionQueryTimeout"></a><a id="rasadp_connectionquerytimeout"></a><a
///           id="RASADP_CONNECTIONQUERYTIMEOUT"></a><dl> <dt><b>RASADP_ConnectionQueryTimeout</b></dt> </dl> </td> <td
///           width="60%"> The <i>lpvValue</i> parameter points to a <b>DWORD</b> value that indicates a time-out value, in
///           seconds. Before attempting an AutoDial connection, the system will display a dialog asking the user to confirm
///           that the system should dial. The dialog has a countdown timer that terminates the dialog with a "Do not dial"
///           selection if the user takes no action. The <b>DWORD</b> value pointed to by <i>lpvValue</i> specifies the initial
///           time on this countdown timer. </td> </tr> </table>
///    arg2 = Pointer to a buffer that receives the value for the specified parameter.
///    arg3 = Pointer to a <b>DWORD</b> value. On input, set this value to indicate the size, in bytes, of the <i>lpvValue</i>
///           buffer. On output, this value indicates the actual size of the value written to the buffer.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt>
///    </dl> </td> <td width="60%"> The <i>dwKey</i> or <i>lpvValue</i> parameter is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_SIZE</b></dt> </dl> </td> <td width="60%"> The size specified by the
///    <i>lpdwcbValue</i> is too small. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasGetAutodialParamW(uint param0, void* param1, uint* param2);

///The <b>RasSetAutodialParam</b> function sets the value of an AutoDial parameter.
///Params:
///    arg1 = Specifies the AutoDial parameter to set. This parameter can be one of the following values. <table> <tr>
///           <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RASADP_DisableConnectionQuery"></a><a
///           id="rasadp_disableconnectionquery"></a><a id="RASADP_DISABLECONNECTIONQUERY"></a><dl>
///           <dt><b>RASADP_DisableConnectionQuery</b></dt> </dl> </td> <td width="60%"> The <i>lpvValue</i> parameter points
///           to a <b>DWORD</b> value. If this value is zero (the default), AutoDial displays a dialog box to query the user
///           before creating a connection. If this value is one, and the AutoDial database has the phone-book entry to dial,
///           AutoDial creates a connection without displaying the dialog box. </td> </tr> <tr> <td width="40%"><a
///           id="RASADP_LoginSessionDisable"></a><a id="rasadp_loginsessiondisable"></a><a
///           id="RASADP_LOGINSESSIONDISABLE"></a><dl> <dt><b>RASADP_LoginSessionDisable</b></dt> </dl> </td> <td width="60%">
///           The <i>lpvValue</i> parameter points to a <b>DWORD</b> value. If this value is one, the system disables all
///           AutoDial connections for the current logon session. If this value is zero (the default), AutoDial connections are
///           enabled. The AutoDial system service changes this value to zero when a new user logs on to the workstation. </td>
///           </tr> <tr> <td width="40%"><a id="RASADP_SavedAddressesLimit"></a><a id="rasadp_savedaddresseslimit"></a><a
///           id="RASADP_SAVEDADDRESSESLIMIT"></a><dl> <dt><b>RASADP_SavedAddressesLimit</b></dt> </dl> </td> <td width="60%">
///           The <i>lpvValue</i> parameter points to a <b>DWORD</b> value that indicates the maximum number of addresses that
///           AutoDial stores in the registry. AutoDial first stores addresses that it used to create an AutoDial connection;
///           then it stores addresses that it learned after a RAS connection was created. Addresses written using the
///           RasSetAutodialAddress function are always saved, and are not included in calculating the limit. The default value
///           is 100. </td> </tr> <tr> <td width="40%"><a id="RASADP_FailedConnectionTimeout"></a><a
///           id="rasadp_failedconnectiontimeout"></a><a id="RASADP_FAILEDCONNECTIONTIMEOUT"></a><dl>
///           <dt><b>RASADP_FailedConnectionTimeout</b></dt> </dl> </td> <td width="60%"> The <i>lpvValue</i> parameter points
///           to a <b>DWORD</b> value that indicates a time-out value, in seconds. When an AutoDial connection attempt fails,
///           the AutoDial system service disables subsequent attempts to reach the same address for the time-out period. This
///           prevents AutoDial from displaying multiple connection dialog boxes for the same logical request by an
///           application. The default value is five. </td> </tr> <tr> <td width="40%"><a
///           id="RASADP_ConnectionQueryTimeout"></a><a id="rasadp_connectionquerytimeout"></a><a
///           id="RASADP_CONNECTIONQUERYTIMEOUT"></a><dl> <dt><b>RASADP_ConnectionQueryTimeout</b></dt> </dl> </td> <td
///           width="60%"> The <i>lpvValue</i> parameter points to a <b>DWORD</b> value that indicates a time-out value, in
///           seconds. Before attempting an AutoDial connection, the system will display a dialog asking the user to confirm
///           that the system should dial. The dialog has a countdown timer that terminates the dialog with a "Do not dial"
///           selection if the user takes no action. The <b>DWORD</b> value pointed to by lpvValue specifies the initial time
///           on this countdown timer. </td> </tr> </table>
///    arg2 = Pointer to a buffer that contains the new value for the specified parameter.
///    arg3 = Specifies the size, in bytes, of the value in the <i>lpvValue</i> buffer.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt>
///    </dl> </td> <td width="60%"> The <i>dwKey</i> or <i>lpvValue</i> parameter is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_SIZE</b></dt> </dl> </td> <td width="60%"> The size specified by the
///    <i>dwcbValue</i> is invalid. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasSetAutodialParamA(uint param0, void* param1, uint param2);

///The <b>RasSetAutodialParam</b> function sets the value of an AutoDial parameter.
///Params:
///    arg1 = Specifies the AutoDial parameter to set. This parameter can be one of the following values. <table> <tr>
///           <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RASADP_DisableConnectionQuery"></a><a
///           id="rasadp_disableconnectionquery"></a><a id="RASADP_DISABLECONNECTIONQUERY"></a><dl>
///           <dt><b>RASADP_DisableConnectionQuery</b></dt> </dl> </td> <td width="60%"> The <i>lpvValue</i> parameter points
///           to a <b>DWORD</b> value. If this value is zero (the default), AutoDial displays a dialog box to query the user
///           before creating a connection. If this value is one, and the AutoDial database has the phone-book entry to dial,
///           AutoDial creates a connection without displaying the dialog box. </td> </tr> <tr> <td width="40%"><a
///           id="RASADP_LoginSessionDisable"></a><a id="rasadp_loginsessiondisable"></a><a
///           id="RASADP_LOGINSESSIONDISABLE"></a><dl> <dt><b>RASADP_LoginSessionDisable</b></dt> </dl> </td> <td width="60%">
///           The <i>lpvValue</i> parameter points to a <b>DWORD</b> value. If this value is one, the system disables all
///           AutoDial connections for the current logon session. If this value is zero (the default), AutoDial connections are
///           enabled. The AutoDial system service changes this value to zero when a new user logs on to the workstation. </td>
///           </tr> <tr> <td width="40%"><a id="RASADP_SavedAddressesLimit"></a><a id="rasadp_savedaddresseslimit"></a><a
///           id="RASADP_SAVEDADDRESSESLIMIT"></a><dl> <dt><b>RASADP_SavedAddressesLimit</b></dt> </dl> </td> <td width="60%">
///           The <i>lpvValue</i> parameter points to a <b>DWORD</b> value that indicates the maximum number of addresses that
///           AutoDial stores in the registry. AutoDial first stores addresses that it used to create an AutoDial connection;
///           then it stores addresses that it learned after a RAS connection was created. Addresses written using the
///           RasSetAutodialAddress function are always saved, and are not included in calculating the limit. The default value
///           is 100. </td> </tr> <tr> <td width="40%"><a id="RASADP_FailedConnectionTimeout"></a><a
///           id="rasadp_failedconnectiontimeout"></a><a id="RASADP_FAILEDCONNECTIONTIMEOUT"></a><dl>
///           <dt><b>RASADP_FailedConnectionTimeout</b></dt> </dl> </td> <td width="60%"> The <i>lpvValue</i> parameter points
///           to a <b>DWORD</b> value that indicates a time-out value, in seconds. When an AutoDial connection attempt fails,
///           the AutoDial system service disables subsequent attempts to reach the same address for the time-out period. This
///           prevents AutoDial from displaying multiple connection dialog boxes for the same logical request by an
///           application. The default value is five. </td> </tr> <tr> <td width="40%"><a
///           id="RASADP_ConnectionQueryTimeout"></a><a id="rasadp_connectionquerytimeout"></a><a
///           id="RASADP_CONNECTIONQUERYTIMEOUT"></a><dl> <dt><b>RASADP_ConnectionQueryTimeout</b></dt> </dl> </td> <td
///           width="60%"> The <i>lpvValue</i> parameter points to a <b>DWORD</b> value that indicates a time-out value, in
///           seconds. Before attempting an AutoDial connection, the system will display a dialog asking the user to confirm
///           that the system should dial. The dialog has a countdown timer that terminates the dialog with a "Do not dial"
///           selection if the user takes no action. The <b>DWORD</b> value pointed to by lpvValue specifies the initial time
///           on this countdown timer. </td> </tr> </table>
///    arg2 = Pointer to a buffer that contains the new value for the specified parameter.
///    arg3 = Specifies the size, in bytes, of the value in the <i>lpvValue</i> buffer.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt>
///    </dl> </td> <td width="60%"> The <i>dwKey</i> or <i>lpvValue</i> parameter is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_SIZE</b></dt> </dl> </td> <td width="60%"> The size specified by the
///    <i>dwcbValue</i> is invalid. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasSetAutodialParamW(uint param0, void* param1, uint param2);

@DllImport("RASAPI32")
uint RasGetPCscf(PWSTR lpszPCscf);

///The <b>RasInvokeEapUI</b> function displays a custom user interface to obtain Extensible Authentication Protocol
///(EAP) information from the user.
///Params:
///    arg1 = Handle to the connection returned by RasDial.
///    arg2 = Specifies the subentry returned in the callback.
///    arg3 = Pointer to the RASDIALEXTENSIONS structure. This structure should be the same as that passed to RasDial when
///           restarting from a paused state. Ensure that the <b>dwSize</b> member of the <b>RASDIALEXTENSIONS</b> structure
///           specifies the size of the structure. Obtain the size using sizeof(<b>RASDIALEXTENSIONS</b>). This parameter
///           cannot be <b>NULL</b>.
///    arg4 = Handle to the parent window to use when displaying the EAP user interface.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl>
///    </td> <td width="60%"> The <i>hRasConn</i> parameter is zero, or the <i>lpExtensions</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_SIZE</b></dt> </dl> </td> <td
///    width="60%"> The value of the <b>dwSize</b> member of the RASDIALEXTENSIONS structure specifies a version of the
///    structure that isn't supported by the operating system in use. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to retrieve the system error message that
///    corresponds to the error code returned. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasInvokeEapUI(HRASCONN__* param0, uint param1, tagRASDIALEXTENSIONS* param2, HWND param3);

///The <b>RasGetLinkStatistics</b> function retrieves accumulated statistics for the specified link in a RAS multilink
///connection.
///Params:
///    hRasConn = Handle to the connection. Use RasDial or RasEnumConnections to obtain this handle.
///    dwSubEntry = Specifies the subentry that corresponds to the link for which to retrieve statistics.
///    lpStatistics = Pointer to the RAS_STATS structure that, on output, receives the statistics. On input, the <b>dwSize</b> member
///                   of this structure specifies the size of RAS_STATS. Use sizeof(<b>RAS_STATS</b>) to obtain this size. This
///                   parameter cannot be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALID_ARG</b></dt> </dl> </td>
///    <td width="60%"> At least one of the following is true: the <i>hRasConn</i> parameter is zero, the
///    <i>dwSubEntry</i> parameter is zero, the <i>lpStatistics</i> parameter is <b>NULL</b>, or the value specified by
///    the <b>dwSize</b> member of the RAS_STATS structure specifies a version of the structure that is not supported by
///    the operating system in use. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl>
///    </td> <td width="60%"> The function could not allocate sufficient memory to complete the operation. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to retrieve the
///    system error message that corresponds to the error code returned. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasGetLinkStatistics(HRASCONN__* hRasConn, uint dwSubEntry, RAS_STATS* lpStatistics);

///The <b>RasGetConnectionStatistics</b> function retrieves accumulated connection statistics for the specified
///connection.
///Params:
///    hRasConn = Handle to the connection. Use RasDial or RasEnumConnections to obtain this handle.
///    lpStatistics = Pointer to the RAS_STATS structure that, on output, receives the statistics. On input, set the <b>dwSize</b>
///                   member of this structure to sizeof(RAS_STATS). This parameter cannot be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td>
///    <td width="60%"> At least one of the following is true: the <i>hRasConn</i> parameter is zero, the
///    <i>lpStatistics</i> parameter is <b>NULL</b>, or the value specified by the <b>dwSize</b> member of the RAS_STATS
///    structure specifies a version of the structure that is not supported by the operating system in use. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> The function
///    could not allocate sufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to retrieve the system error message that
///    corresponds to the error code returned. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasGetConnectionStatistics(HRASCONN__* hRasConn, RAS_STATS* lpStatistics);

///The <b>RasClearLinkStatistics</b> functions clears any accumulated statistics for the specified link in a RAS
///multilink connection.
///Params:
///    hRasConn = Handle to the connection. Use RasDial or RasEnumConnections to obtain this handle.
///    dwSubEntry = Specifies the subentry that corresponds to the link for which to clear statistics.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl>
///    </td> <td width="60%"> The <i>hRasConn</i> parameter does not specify a valid connection. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>dwSubEntry</i>
///    parameter is zero. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_CONNECTION</b></dt> </dl> </td> <td
///    width="60%"> RAS could not find a connected port that corresponds to the value in the <i>dwSubEntry</i>
///    parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> The function could not allocate sufficient memory to complete the operation. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to retrieve the system
///    error message that corresponds to the error code returned. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasClearLinkStatistics(HRASCONN__* hRasConn, uint dwSubEntry);

///The <b>RasClearConnectionStatistics</b> functions clears any accumulated statistics for the specified RAS connection.
///Params:
///    hRasConn = Handle to the connection. Use RasDial or RasEnumConnections to obtain this handle.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl>
///    </td> <td width="60%"> The <i>hRasConn</i> parameter does not specify a valid connection. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> The function could not
///    allocate sufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to retrieve the system error message that
///    corresponds to the error code returned. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasClearConnectionStatistics(HRASCONN__* hRasConn);

///Use the <b>RasGetEapUserData</b> function to retrieve user-specific Extensible Authentication Protocol (EAP)
///information for the specified phone-book entry.
///Params:
///    hToken = Handle to a primary or impersonation access token that represents the user for which to retrieve data. This
///             parameter can be <b>NULL</b> if the function is called from a process already running in the user's context.
///    pszPhonebook = Pointer to a null-terminated string that specifies the full path of the phone-book (PBK) file. If this parameter
///                   is <b>NULL</b>, the function uses the system phone book.
///    pszEntry = Pointer to a null-terminated string that specifies an existing entry name.
///    pbEapData = Pointer to a buffer that receives the retrieved EAP data for the user. The caller should allocate the memory for
///                this buffer. If the buffer is not large enough, <b>RasGetEapUserData</b> returns <b>ERROR_BUFFER_TOO_SMALL</b>,
///                and the <i>pdwSizeofEapData</i> parameter contains the required size.
///    pdwSizeofEapData = Pointer to a <b>DWORD</b> variable that, on input, specifies the size of the buffer pointed to by the
///                       <i>pbEapData</i> parameter. If the buffer specified by the <i>pbEapData</i> parameter is not large enough,
///                       <i>pdwSizeofEapData</i> receives, on output, the required size.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td>
///    <td width="60%"> The <i>pdwSizeofEapData</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BUFFER_TOO_SMALL</b></dt> </dl> </td> <td width="60%"> The buffer pointed to by <i>pbEapData</i> is
///    too small to receive the data. The <i>pdwSizeofEapData</i> contains the required size. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_CANNOT_OPEN_PHONEBOOK</b></dt> </dl> </td> <td width="60%"> RasGetEapUserData was
///    unable to open the specified phone-book file. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANNOT_FIND_PHONEBOOK_ENTRY</b></dt> </dl> </td> <td width="60%"> RasGetEapUserData was unable to
///    find the specified entry in the phone book. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl>
///    </td> <td width="60%"> Use FormatMessage to retrieve the system error message that corresponds to the error code
///    returned. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasGetEapUserDataA(HANDLE hToken, const(PSTR) pszPhonebook, const(PSTR) pszEntry, ubyte* pbEapData, 
                        uint* pdwSizeofEapData);

///Use the <b>RasGetEapUserData</b> function to retrieve user-specific Extensible Authentication Protocol (EAP)
///information for the specified phone-book entry.
///Params:
///    hToken = Handle to a primary or impersonation access token that represents the user for which to retrieve data. This
///             parameter can be <b>NULL</b> if the function is called from a process already running in the user's context.
///    pszPhonebook = Pointer to a null-terminated string that specifies the full path of the phone-book (PBK) file. If this parameter
///                   is <b>NULL</b>, the function uses the system phone book.
///    pszEntry = Pointer to a null-terminated string that specifies an existing entry name.
///    pbEapData = Pointer to a buffer that receives the retrieved EAP data for the user. The caller should allocate the memory for
///                this buffer. If the buffer is not large enough, <b>RasGetEapUserData</b> returns <b>ERROR_BUFFER_TOO_SMALL</b>,
///                and the <i>pdwSizeofEapData</i> parameter contains the required size.
///    pdwSizeofEapData = Pointer to a <b>DWORD</b> variable that, on input, specifies the size of the buffer pointed to by the
///                       <i>pbEapData</i> parameter. If the buffer specified by the <i>pbEapData</i> parameter is not large enough,
///                       <i>pdwSizeofEapData</i> receives, on output, the required size.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td>
///    <td width="60%"> The <i>pdwSizeofEapData</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BUFFER_TOO_SMALL</b></dt> </dl> </td> <td width="60%"> The buffer pointed to by <i>pbEapData</i> is
///    too small to receive the data. The <i>pdwSizeofEapData</i> contains the required size. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_CANNOT_OPEN_PHONEBOOK</b></dt> </dl> </td> <td width="60%"> RasGetEapUserData was
///    unable to open the specified phone-book file. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANNOT_FIND_PHONEBOOK_ENTRY</b></dt> </dl> </td> <td width="60%"> RasGetEapUserData was unable to
///    find the specified entry in the phone book. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl>
///    </td> <td width="60%"> Use FormatMessage to retrieve the system error message that corresponds to the error code
///    returned. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasGetEapUserDataW(HANDLE hToken, const(PWSTR) pszPhonebook, const(PWSTR) pszEntry, ubyte* pbEapData, 
                        uint* pdwSizeofEapData);

///Use the <b>RasSetEapUserData</b> function to store user-specific Extensible Authentication Protocol (EAP) information
///for the specified phone-book entry in the registry.
///Params:
///    hToken = Handle to a primary or impersonation access token that represents the user for which to store data. This
///             parameter can be <b>NULL</b> if the function is called from a process already running in the user's context.
///    pszPhonebook = Pointer to a <b>null</b>-terminated string that specifies the full path of the phone-book (PBK) file. If this
///                   parameter is <b>NULL</b>, the function uses the system phone book.
///    pszEntry = Pointer to a <b>null</b>-terminated string that specifies an existing entry name.
///    pbEapData = Pointer to the data to store for the user.
///    dwSizeofEapData = Specifies the size of the data pointed to by the <i>pbEapData</i> parameter.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td>
///    <td width="60%"> The <i>dwSizeofEapData</i> parameter is zero, or the <i>pbEapData</i> parameter is <b>NULL</b>.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_OPEN_PHONEBOOK</b></dt> </dl> </td> <td width="60%">
///    <b>RasSetEapUserData</b> was unable to open the specified phone-book file. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANNOT_FIND_PHONEBOOK_ENTRY</b></dt> </dl> </td> <td width="60%"> <b>RasSetEapUserData</b> was
///    unable to find the specified entry in the phone book. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to retrieve the system error message that
///    corresponds to the error code returned. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasSetEapUserDataA(HANDLE hToken, const(PSTR) pszPhonebook, const(PSTR) pszEntry, ubyte* pbEapData, 
                        uint dwSizeofEapData);

///Use the <b>RasSetEapUserData</b> function to store user-specific Extensible Authentication Protocol (EAP) information
///for the specified phone-book entry in the registry.
///Params:
///    hToken = Handle to a primary or impersonation access token that represents the user for which to store data. This
///             parameter can be <b>NULL</b> if the function is called from a process already running in the user's context.
///    pszPhonebook = Pointer to a <b>null</b>-terminated string that specifies the full path of the phone-book (PBK) file. If this
///                   parameter is <b>NULL</b>, the function uses the system phone book.
///    pszEntry = Pointer to a <b>null</b>-terminated string that specifies an existing entry name.
///    pbEapData = Pointer to the data to store for the user.
///    dwSizeofEapData = Specifies the size of the data pointed to by the <i>pbEapData</i> parameter.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td>
///    <td width="60%"> The <i>dwSizeofEapData</i> parameter is zero, or the <i>pbEapData</i> parameter is <b>NULL</b>.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_OPEN_PHONEBOOK</b></dt> </dl> </td> <td width="60%">
///    <b>RasSetEapUserData</b> was unable to open the specified phone-book file. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANNOT_FIND_PHONEBOOK_ENTRY</b></dt> </dl> </td> <td width="60%"> <b>RasSetEapUserData</b> was
///    unable to find the specified entry in the phone book. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to retrieve the system error message that
///    corresponds to the error code returned. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasSetEapUserDataW(HANDLE hToken, const(PWSTR) pszPhonebook, const(PWSTR) pszEntry, ubyte* pbEapData, 
                        uint dwSizeofEapData);

///Use the <b>RasGetCustomAuthData</b> function to retrieve connection-specific authentication information. This
///information is not specific to a particular user.
///Params:
///    pszPhonebook = Pointer to a <b>null</b>-terminated string that specifies the full path of the phone-book (PBK) file. If this
///                   parameter is <b>NULL</b>, the function uses the system phone book.
///    pszEntry = Pointer to a <b>null</b>-terminated string that specifies an existing entry name.
///    pbCustomAuthData = Pointer to a buffer that receives the authentication data. The caller should allocate the memory for this buffer.
///                       If the buffer is not large enough, <b>RasGetCustomAuthData</b> returns ERROR_BUFFER_TOO_SMALL, and the
///                       <i>pdwSizeofEapData</i> parameter contains the required size.
///    pdwSizeofCustomAuthData = Pointer to a <b>DWORD</b> variable that, on input, specifies the size of the buffer pointed to by the
///                              <i>pbCustomAuthData</i> parameter. If the buffer specified by the <i>pbCustomAuthData</i> parameter is not large
///                              enough, <i>pdwSizeofEapData</i> receives, on output, the required size.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td>
///    <td width="60%"> The <i>pdwSizeofCustomAuthData</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_BUFFER_TOO_SMALL</b></dt> </dl> </td> <td width="60%"> The buffer pointed to by
///    <i>pbCustomAuthData</i> is too small to receive the data. The <i>pdwSizeofCustomAuthData</i> contains the
///    required size. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_OPEN_PHONEBOOK</b></dt> </dl> </td> <td
///    width="60%"> RasGetEapUserData was unable to open the specified phone-book file. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_CANNOT_FIND_PHONEBOOK_ENTRY</b></dt> </dl> </td> <td width="60%">
///    RasGetEapUserData was unable to find the specified entry in the phone book. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to retrieve the system error message
///    that corresponds to the error code returned. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasGetCustomAuthDataA(const(PSTR) pszPhonebook, const(PSTR) pszEntry, ubyte* pbCustomAuthData, 
                           uint* pdwSizeofCustomAuthData);

///Use the <b>RasGetCustomAuthData</b> function to retrieve connection-specific authentication information. This
///information is not specific to a particular user.
///Params:
///    pszPhonebook = Pointer to a <b>null</b>-terminated string that specifies the full path of the phone-book (PBK) file. If this
///                   parameter is <b>NULL</b>, the function uses the system phone book.
///    pszEntry = Pointer to a <b>null</b>-terminated string that specifies an existing entry name.
///    pbCustomAuthData = Pointer to a buffer that receives the authentication data. The caller should allocate the memory for this buffer.
///                       If the buffer is not large enough, <b>RasGetCustomAuthData</b> returns ERROR_BUFFER_TOO_SMALL, and the
///                       <i>pdwSizeofEapData</i> parameter contains the required size.
///    pdwSizeofCustomAuthData = Pointer to a <b>DWORD</b> variable that, on input, specifies the size of the buffer pointed to by the
///                              <i>pbCustomAuthData</i> parameter. If the buffer specified by the <i>pbCustomAuthData</i> parameter is not large
///                              enough, <i>pdwSizeofEapData</i> receives, on output, the required size.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td>
///    <td width="60%"> The <i>pdwSizeofCustomAuthData</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_BUFFER_TOO_SMALL</b></dt> </dl> </td> <td width="60%"> The buffer pointed to by
///    <i>pbCustomAuthData</i> is too small to receive the data. The <i>pdwSizeofCustomAuthData</i> contains the
///    required size. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_OPEN_PHONEBOOK</b></dt> </dl> </td> <td
///    width="60%"> RasGetEapUserData was unable to open the specified phone-book file. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_CANNOT_FIND_PHONEBOOK_ENTRY</b></dt> </dl> </td> <td width="60%">
///    RasGetEapUserData was unable to find the specified entry in the phone book. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to retrieve the system error message
///    that corresponds to the error code returned. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasGetCustomAuthDataW(const(PWSTR) pszPhonebook, const(PWSTR) pszEntry, ubyte* pbCustomAuthData, 
                           uint* pdwSizeofCustomAuthData);

///Use the <b>RasSetCustomAuthData</b> function to set connection-specific authentication information. This information
///should not be specific to a particular user.
///Params:
///    pszPhonebook = Pointer to a <b>null</b>-terminated string that specifies the full path of the phone-book (PBK) file. If this
///                   parameter is <b>NULL</b>, the function uses the system phone book.
///    pszEntry = Pointer to a <b>null</b>-terminated string that specifies an existing entry name.
///    pbCustomAuthData = Pointer to a buffer that specifies the new authentication data.
///    dwSizeofCustomAuthData = Specifies the size of the data pointed to by the <i>pbCustomAuthData</i> parameter.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td>
///    <td width="60%"> The <i>dwSizeofCustomAuthData</i> parameter is zero, or the <i>pbCustomAuthData</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_OPEN_PHONEBOOK</b></dt> </dl> </td> <td
///    width="60%"> RasSetEapUserData was unable to open the specified phone-book file. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_CANNOT_FIND_PHONEBOOK_ENTRY</b></dt> </dl> </td> <td width="60%">
///    RasSetEapUserData was unable to find the specified entry in the phone book. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to retrieve the system error message
///    that corresponds to the error code returned. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasSetCustomAuthDataA(const(PSTR) pszPhonebook, const(PSTR) pszEntry, ubyte* pbCustomAuthData, 
                           uint dwSizeofCustomAuthData);

///Use the <b>RasSetCustomAuthData</b> function to set connection-specific authentication information. This information
///should not be specific to a particular user.
///Params:
///    pszPhonebook = Pointer to a <b>null</b>-terminated string that specifies the full path of the phone-book (PBK) file. If this
///                   parameter is <b>NULL</b>, the function uses the system phone book.
///    pszEntry = Pointer to a <b>null</b>-terminated string that specifies an existing entry name.
///    pbCustomAuthData = Pointer to a buffer that specifies the new authentication data.
///    dwSizeofCustomAuthData = Specifies the size of the data pointed to by the <i>pbCustomAuthData</i> parameter.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td>
///    <td width="60%"> The <i>dwSizeofCustomAuthData</i> parameter is zero, or the <i>pbCustomAuthData</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_OPEN_PHONEBOOK</b></dt> </dl> </td> <td
///    width="60%"> RasSetEapUserData was unable to open the specified phone-book file. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_CANNOT_FIND_PHONEBOOK_ENTRY</b></dt> </dl> </td> <td width="60%">
///    RasSetEapUserData was unable to find the specified entry in the phone book. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to retrieve the system error message
///    that corresponds to the error code returned. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasSetCustomAuthDataW(const(PWSTR) pszPhonebook, const(PWSTR) pszEntry, ubyte* pbCustomAuthData, 
                           uint dwSizeofCustomAuthData);

///The <b>RasGetEapUserIdentity</b> function retrieves identity information for the current user. Use this information
///to call RasDial with a phone-book entry that requires Extensible Authentication Protocol (EAP).
///Params:
///    pszPhonebook = Pointer to a <b>null</b>-terminated string that specifies the full path of the phone-book (PBK) file. If this
///                   parameter is <b>NULL</b>, the function uses the system phone book.
///    pszEntry = Pointer to a <b>null</b>-terminated string that specifies an existing entry name.
///    dwFlags = Specifies zero or more of the following flags that qualify the authentication process. <table> <tr> <th>Flag</th>
///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RASEAPF_NonInteractive"></a><a
///              id="raseapf_noninteractive"></a><a id="RASEAPF_NONINTERACTIVE"></a><dl> <dt><b>RASEAPF_NonInteractive</b></dt>
///              </dl> </td> <td width="60%"> Specifies that the authentication protocol should not bring up a graphical
///              user-interface. If this flag is not present, it is okay for the protocol to display a user interface. </td> </tr>
///              <tr> <td width="40%"><a id="RASEAPF_Logon"></a><a id="raseapf_logon"></a><a id="RASEAPF_LOGON"></a><dl>
///              <dt><b>RASEAPF_Logon</b></dt> </dl> </td> <td width="60%"> Specifies that the user data is obtained from
///              WinLogon. </td> </tr> <tr> <td width="40%"><a id="RASEAPF_Preview"></a><a id="raseapf_preview"></a><a
///              id="RASEAPF_PREVIEW"></a><dl> <dt><b>RASEAPF_Preview</b></dt> </dl> </td> <td width="60%"> Specifies that the
///              user should be prompted for identity information before dialing. </td> </tr> </table>
///    hwnd = Handle to the parent window for the UI dialog. If the <i>fInvokeUI</i> parameter is <b>FALSE</b>, then
///           <i>hwnd</i> should be <b>NULL</b>.
///    ppRasEapUserIdentity = Pointer to a pointer that, on successful return, receives the address of the RASEAPUSERIDENTITY structure that
///                           contains EAP user identity information. <b>RasGetEapUserIdentity</b> allocates the memory buffer for the
///                           <b>RASEAPUSERIDENTITY</b> structure. Free this memory by calling RasFreeEapUserIdentity.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALID_ARG</b></dt> </dl> </td>
///    <td width="60%"> The <i>pcbEapUserIdentity</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INTERACTIVE_MODE</b></dt> </dl> </td> <td width="60%"> The function was called with the
///    RASEAPF_NonInteractive flag. However, the authentication protocol must display a UI in order to obtain the
///    required identity information from the user. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_FUNCTION_FOR_ENTRY</b></dt> </dl> </td> <td width="60%"> Either the authentication method
///    for this phone-book entry is not EAP, or the authentication method is EAP but the protocol uses the standard
///    Windows NT/Windows 2000 credentials dialog to obtain user identity information. In either case, the caller does
///    not need to pass EAP identity information to RasDial. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_RASMAN_CANNOT_INITIALIZE</b></dt> </dl> </td> <td width="60%"> The Remote Access Service failed to
///    initialize properly. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%">
///    Use FormatMessage to retrieve the system error message that corresponds to the error code returned. </td> </tr>
///    </table>
///    
@DllImport("RASAPI32")
uint RasGetEapUserIdentityW(const(PWSTR) pszPhonebook, const(PWSTR) pszEntry, uint dwFlags, HWND hwnd, 
                            tagRASEAPUSERIDENTITYW** ppRasEapUserIdentity);

///The <b>RasGetEapUserIdentity</b> function retrieves identity information for the current user. Use this information
///to call RasDial with a phone-book entry that requires Extensible Authentication Protocol (EAP).
///Params:
///    pszPhonebook = Pointer to a <b>null</b>-terminated string that specifies the full path of the phone-book (PBK) file. If this
///                   parameter is <b>NULL</b>, the function uses the system phone book.
///    pszEntry = Pointer to a <b>null</b>-terminated string that specifies an existing entry name.
///    dwFlags = Specifies zero or more of the following flags that qualify the authentication process. <table> <tr> <th>Flag</th>
///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RASEAPF_NonInteractive"></a><a
///              id="raseapf_noninteractive"></a><a id="RASEAPF_NONINTERACTIVE"></a><dl> <dt><b>RASEAPF_NonInteractive</b></dt>
///              </dl> </td> <td width="60%"> Specifies that the authentication protocol should not bring up a graphical
///              user-interface. If this flag is not present, it is okay for the protocol to display a user interface. </td> </tr>
///              <tr> <td width="40%"><a id="RASEAPF_Logon"></a><a id="raseapf_logon"></a><a id="RASEAPF_LOGON"></a><dl>
///              <dt><b>RASEAPF_Logon</b></dt> </dl> </td> <td width="60%"> Specifies that the user data is obtained from
///              WinLogon. </td> </tr> <tr> <td width="40%"><a id="RASEAPF_Preview"></a><a id="raseapf_preview"></a><a
///              id="RASEAPF_PREVIEW"></a><dl> <dt><b>RASEAPF_Preview</b></dt> </dl> </td> <td width="60%"> Specifies that the
///              user should be prompted for identity information before dialing. </td> </tr> </table>
///    hwnd = Handle to the parent window for the UI dialog. If the <i>fInvokeUI</i> parameter is <b>FALSE</b>, then
///           <i>hwnd</i> should be <b>NULL</b>.
///    ppRasEapUserIdentity = Pointer to a pointer that, on successful return, receives the address of the RASEAPUSERIDENTITY structure that
///                           contains EAP user identity information. <b>RasGetEapUserIdentity</b> allocates the memory buffer for the
///                           <b>RASEAPUSERIDENTITY</b> structure. Free this memory by calling RasFreeEapUserIdentity.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALID_ARG</b></dt> </dl> </td>
///    <td width="60%"> The <i>pcbEapUserIdentity</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INTERACTIVE_MODE</b></dt> </dl> </td> <td width="60%"> The function was called with the
///    RASEAPF_NonInteractive flag. However, the authentication protocol must display a UI in order to obtain the
///    required identity information from the user. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_FUNCTION_FOR_ENTRY</b></dt> </dl> </td> <td width="60%"> Either the authentication method
///    for this phone-book entry is not EAP, or the authentication method is EAP but the protocol uses the standard
///    Windows NT/Windows 2000 credentials dialog to obtain user identity information. In either case, the caller does
///    not need to pass EAP identity information to RasDial. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_RASMAN_CANNOT_INITIALIZE</b></dt> </dl> </td> <td width="60%"> The Remote Access Service failed to
///    initialize properly. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%">
///    Use FormatMessage to retrieve the system error message that corresponds to the error code returned. </td> </tr>
///    </table>
///    
@DllImport("RASAPI32")
uint RasGetEapUserIdentityA(const(PSTR) pszPhonebook, const(PSTR) pszEntry, uint dwFlags, HWND hwnd, 
                            tagRASEAPUSERIDENTITYA** ppRasEapUserIdentity);

///Use the <b>RasFreeEapUserIdentity</b> function to free the memory buffer returned by RasGetEapUserIdentity.
///Params:
///    pRasEapUserIdentity = Pointer to the RASEAPUSERIDENTITY structure returned by the RasGetEapUserIdentity function.
///                          <b>RasFreeEapUserIdentity</b> frees the memory occupied by this structure.
@DllImport("RASAPI32")
void RasFreeEapUserIdentityW(tagRASEAPUSERIDENTITYW* pRasEapUserIdentity);

///Use the <b>RasFreeEapUserIdentity</b> function to free the memory buffer returned by RasGetEapUserIdentity.
///Params:
///    pRasEapUserIdentity = Pointer to the RASEAPUSERIDENTITY structure returned by the RasGetEapUserIdentity function.
///                          <b>RasFreeEapUserIdentity</b> frees the memory occupied by this structure.
@DllImport("RASAPI32")
void RasFreeEapUserIdentityA(tagRASEAPUSERIDENTITYA* pRasEapUserIdentity);

///The <b>RasDeleteSubEntry</b> function deletes the specified subentry from the specified phone-book entry.
///Params:
///    pszPhonebook = Pointer to a <b>null</b>-terminated string that specifies the full path and file name of a phone-book (PBK) file.
///                   If this parameter is <b>NULL</b>, the function uses the current default phone-book file.
///    pszEntry = Pointer to a <b>null</b>-terminated string that contains the name of an existing entry from which a subentry is
///               to be deleted.
///    dwSubentryId = TBD
///    dwSubEntryId = Specifies the one-based index of the subentry.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h.
///    
@DllImport("RASAPI32")
uint RasDeleteSubEntryA(const(PSTR) pszPhonebook, const(PSTR) pszEntry, uint dwSubentryId);

///The <b>RasDeleteSubEntry</b> function deletes the specified subentry from the specified phone-book entry.
///Params:
///    pszPhonebook = Pointer to a <b>null</b>-terminated string that specifies the full path and file name of a phone-book (PBK) file.
///                   If this parameter is <b>NULL</b>, the function uses the current default phone-book file.
///    pszEntry = Pointer to a <b>null</b>-terminated string that contains the name of an existing entry from which a subentry is
///               to be deleted.
///    dwSubEntryId = Specifies the one-based index of the subentry.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h.
///    
@DllImport("RASAPI32")
uint RasDeleteSubEntryW(const(PWSTR) pszPhonebook, const(PWSTR) pszEntry, uint dwSubEntryId);

///The <b>RasUpdateConnection</b> function updates the tunnel endpoints of an Internet Key Exchange version 2 (IKEv2)
///connection.
///Params:
///    hrasconn = A handle to the IKEv2 RAS connection for which the tunnel endpoints are to be changed. This can be a handle
///               returned by the RasDial or RasEnumConnections function.
///    lprasupdateconn = A pointer to a RASUPDATECONN structure that contains the new tunnel endpoints for the RAS connection specified by
///                      <i>hrasconn</i>.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the error codes from Routing and Remote Access Error Codes or Winerror.h.
///    
@DllImport("RASAPI32")
uint RasUpdateConnection(HRASCONN__* hrasconn, tagRASUPDATECONN* lprasupdateconn);

///The <b>RasGetProjectionInfoEx</b> function obtains information about Point-to-Point Protocol (PPP) or Internet Key
///Exchange version 2 (IKEv2) remote access projection operations for all RAS connections on the local client.
///Params:
///    hrasconn = A handle to the RAS connection for which the tunnel endpoints are to be changed. This can be a handle returned by
///               the RasDial or RasEnumConnections function.
///    pRasProjection = A pointer to a RAS_PROJECTION_INFO structure that receives the projection information for the RAS connections.
///    lpdwSize = A pointer, in input, that specifies the size, in bytes, of the buffer pointed to by pRasProjection. On output,
///               this variable receives the size, in bytes, of the buffer needed to store the number of RAS_PROJECTION_INFO
///               structures pointed to by <i>pRasProjection</i>.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes or a value from Routing and Remote Access Error Codes or Winerror.h. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUFFER_TOO_SMALL</b></dt>
///    </dl> </td> <td width="60%"> The buffer pointed to by <i>pRasProjection</i> is not large enough to contain the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td>
///    <td width="60%"> The <i>hrasconn</i> parameter is not a valid handle. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The function was called with an invalid
///    parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_SIZE</b></dt> </dl> </td> <td width="60%">
///    The <i>dwSize</i> member of the structure pointed to by <i>pRasProjection</i> specifies an invalid size. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_PROTOCOL_NOT_CONFIGURED</b></dt> </dl> </td> <td width="60%"> The
///    control protocol for which information was requested neither succeeded nor failed, because the connection's
///    phone-book entry did not require that an attempt to negotiate the protocol be made. </td> </tr> </table>
///    
@DllImport("RASAPI32")
uint RasGetProjectionInfoEx(HRASCONN__* hrasconn, RAS_PROJECTION_INFO* pRasProjection, uint* lpdwSize);

///The <b>RasPhonebookDlg</b> function displays the main <b>Dial-Up Networking</b> dialog box. From this modal dialog
///box, the user can dial, edit, or delete a selected phone-book entry, create a new phone-book entry, or specify user
///preferences. The <b>RasPhonebookDlg</b> function returns when the dialog box closes.
///Params:
///    lpszPhonebook = Pointer to a <b>null</b>-terminated string that specifies the full path and file name of a phone-book (PBK) file.
///                    If this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book
///                    file is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up
///                    Networking</b> dialog box.
///    lpszEntry = Pointer to a <b>null</b>-terminated string that specifies the name of the phone-book entry to highlight
///                initially. If this parameter is <b>NULL</b>, or if the specified entry does not exist, the dialog box highlights
///                the first entry in the alphabetic list.
///    lpInfo = Pointer to the RASPBDLG structure that specifies additional input and output parameters. On input, the
///             <b>dwSize</b> member of this structure must specify the sizeof( RASPBDLG). If an error occurs, the <b>dwError</b>
///             member of the structure receives, on output, an error code; otherwise, it receives zero.
///Returns:
///    If the user selects the <b>Connect</b> button and the function establishes a connection, the return value is
///    <b>TRUE</b>. Otherwise, the function returns <b>FALSE</b>. If an error occurs, the <b>dwError</b> member of the
///    RASPBDLG structure returns a value from Routing and Remote Access Error Codes or Winerror.h. The following sample
///    code brings up the <b>Dial-Up Networking</b> dialog. The dialog displays dialing information for the first entry
///    from the default phonebook file. ```cpp #include <windows.h> #include <stdio.h> #include "ras.h" #include
///    "rasdlg.h" #pragma comment(lib, "rasapi32.lib") int main (){ // Initialize the return code BOOL nRet = TRUE; //
///    Allocate heap memory for the RASPBLDG structure RASPBDLG * lpInfo = (LPRASPBDLG)HeapAlloc(GetProcessHeap(),
///    HEAP_ZERO_MEMORY, sizeof(RASPBDLG)); // The dwsize member of lpInfo must contain the structure size, or the //
///    call to RasPhonebookDlg will fail lpInfo->dwSize = sizeof(RASPBDLG); // Open a user dialog box nRet =
///    RasPhonebookDlg(NULL,NULL,lpInfo); if(nRet == TRUE){ // The user dialed a connection successfully printf("User
///    pressed Connect\n"); }else{ if(lpInfo->dwError != 0){ printf("RasPhonebookDlg failed: Error = %d\n",
///    lpInfo->dwError); }else{ // The user closed the dialog box manually printf("User pressed Close\n"); } } // Free
///    the heap memory for the RASPBLDG structure HeapFree(GetProcessHeap(), 0, lpInfo); return 0; } ```
///    
@DllImport("RASDLG")
BOOL RasPhonebookDlgA(PSTR lpszPhonebook, PSTR lpszEntry, tagRASPBDLGA* lpInfo);

///The <b>RasPhonebookDlg</b> function displays the main <b>Dial-Up Networking</b> dialog box. From this modal dialog
///box, the user can dial, edit, or delete a selected phone-book entry, create a new phone-book entry, or specify user
///preferences. The <b>RasPhonebookDlg</b> function returns when the dialog box closes.
///Params:
///    lpszPhonebook = Pointer to a <b>null</b>-terminated string that specifies the full path and file name of a phone-book (PBK) file.
///                    If this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book
///                    file is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up
///                    Networking</b> dialog box.
///    lpszEntry = Pointer to a <b>null</b>-terminated string that specifies the name of the phone-book entry to highlight
///                initially. If this parameter is <b>NULL</b>, or if the specified entry does not exist, the dialog box highlights
///                the first entry in the alphabetic list.
///    lpInfo = Pointer to the RASPBDLG structure that specifies additional input and output parameters. On input, the
///             <b>dwSize</b> member of this structure must specify the sizeof( RASPBDLG). If an error occurs, the <b>dwError</b>
///             member of the structure receives, on output, an error code; otherwise, it receives zero.
///Returns:
///    If the user selects the <b>Connect</b> button and the function establishes a connection, the return value is
///    <b>TRUE</b>. Otherwise, the function returns <b>FALSE</b>. If an error occurs, the <b>dwError</b> member of the
///    RASPBDLG structure returns a value from Routing and Remote Access Error Codes or Winerror.h. The following sample
///    code brings up the <b>Dial-Up Networking</b> dialog. The dialog displays dialing information for the first entry
///    from the default phonebook file. ```cpp #include <windows.h> #include <stdio.h> #include "ras.h" #include
///    "rasdlg.h" #pragma comment(lib, "rasapi32.lib") int main (){ // Initialize the return code BOOL nRet = TRUE; //
///    Allocate heap memory for the RASPBLDG structure RASPBDLG * lpInfo = (LPRASPBDLG)HeapAlloc(GetProcessHeap(),
///    HEAP_ZERO_MEMORY, sizeof(RASPBDLG)); // The dwsize member of lpInfo must contain the structure size, or the //
///    call to RasPhonebookDlg will fail lpInfo->dwSize = sizeof(RASPBDLG); // Open a user dialog box nRet =
///    RasPhonebookDlg(NULL,NULL,lpInfo); if(nRet == TRUE){ // The user dialed a connection successfully printf("User
///    pressed Connect\n"); }else{ if(lpInfo->dwError != 0){ printf("RasPhonebookDlg failed: Error = %d\n",
///    lpInfo->dwError); }else{ // The user closed the dialog box manually printf("User pressed Close\n"); } } // Free
///    the heap memory for the RASPBLDG structure HeapFree(GetProcessHeap(), 0, lpInfo); return 0; } ```
///    
@DllImport("RASDLG")
BOOL RasPhonebookDlgW(PWSTR lpszPhonebook, PWSTR lpszEntry, tagRASPBDLGW* lpInfo);

///The <b>RasEntryDlg</b> function displays modal property sheets that allow a user to manipulate phone-book entries. If
///editing or copying an existing phone-book entry, the function displays a phone-book entry property sheet. The
///<b>RasEntryDlg</b> function returns when the user closes the property sheet.
///Params:
///    lpszPhonebook = Pointer to a <b>null</b>-terminated string that specifies the full path and file name of a phone-book (PBK) file.
///                    If this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book
///                    file is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up
///                    Networking</b> dialog box.
///    lpszEntry = Pointer to a <b>null</b>-terminated string that specifies the name of the phone-book entry to edit, copy, or
///                create. If you are editing or copying an entry, this parameter is the name of an existing phone-book entry. If
///                you are copying an entry, set the <b>RASEDFLAG_CloneEntry</b> flag in the <b>dwFlags</b> member of the
///                RASENTRYDLG structure. <div class="alert"><b>Note</b> The R<b>RASEDFLAG_CloneEntry</b> flag has been deprecated,
///                as of Windows Vista and Windows Server 2008. It may be altered or unavailable in subsequent versions. Instead,
///                copy an entry by calling RasGetEntryProperties to get the entry and then calling RasSetEntryProperties to save
///                the entry with a new name.</div> <div> </div> If you are creating an entry, this parameter is a default new entry
///                name that the user can change. If this parameter is <b>NULL</b>, the function provides a default name. If you are
///                creating an entry, set the <b>RASEDFLAG_NewEntry</b> flag in the <b>dwFlags</b> member of the RASENTRYDLG
///                structure.
///    lpInfo = Pointer to a RASENTRYDLG structure that specifies additional input and output parameters. The <b>dwSize</b>
///             member of this structure must specify sizeof(<b>RASENTRYDLG</b>). Use the <b>dwFlags</b> member to indicate
///             whether you are creating, editing, or copying an entry. If an error occurs, the <b>dwError</b> member returns an
///             error code; otherwise, it returns zero.
///Returns:
///    If the user creates, copies, or edits a phone-book entry, the return value is <b>TRUE</b>. Otherwise, the
///    function returns <b>FALSE</b>. If an error occurs, <b>RasEntryDlg</b> sets the <b>dwError</b> member of the
///    RASENTRYDLG structure to a value from Routing and Remote Access Error Codes or Winerror.h.
///    
@DllImport("RASDLG")
BOOL RasEntryDlgA(PSTR lpszPhonebook, PSTR lpszEntry, tagRASENTRYDLGA* lpInfo);

///The <b>RasEntryDlg</b> function displays modal property sheets that allow a user to manipulate phone-book entries. If
///editing or copying an existing phone-book entry, the function displays a phone-book entry property sheet. The
///<b>RasEntryDlg</b> function returns when the user closes the property sheet.
///Params:
///    lpszPhonebook = Pointer to a <b>null</b>-terminated string that specifies the full path and file name of a phone-book (PBK) file.
///                    If this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book
///                    file is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up
///                    Networking</b> dialog box.
///    lpszEntry = Pointer to a <b>null</b>-terminated string that specifies the name of the phone-book entry to edit, copy, or
///                create. If you are editing or copying an entry, this parameter is the name of an existing phone-book entry. If
///                you are copying an entry, set the <b>RASEDFLAG_CloneEntry</b> flag in the <b>dwFlags</b> member of the
///                RASENTRYDLG structure. <div class="alert"><b>Note</b> The R<b>RASEDFLAG_CloneEntry</b> flag has been deprecated,
///                as of Windows Vista and Windows Server 2008. It may be altered or unavailable in subsequent versions. Instead,
///                copy an entry by calling RasGetEntryProperties to get the entry and then calling RasSetEntryProperties to save
///                the entry with a new name.</div> <div> </div> If you are creating an entry, this parameter is a default new entry
///                name that the user can change. If this parameter is <b>NULL</b>, the function provides a default name. If you are
///                creating an entry, set the <b>RASEDFLAG_NewEntry</b> flag in the <b>dwFlags</b> member of the RASENTRYDLG
///                structure.
///    lpInfo = Pointer to a RASENTRYDLG structure that specifies additional input and output parameters. The <b>dwSize</b>
///             member of this structure must specify sizeof(<b>RASENTRYDLG</b>). Use the <b>dwFlags</b> member to indicate
///             whether you are creating, editing, or copying an entry. If an error occurs, the <b>dwError</b> member returns an
///             error code; otherwise, it returns zero.
///Returns:
///    If the user creates, copies, or edits a phone-book entry, the return value is <b>TRUE</b>. Otherwise, the
///    function returns <b>FALSE</b>. If an error occurs, <b>RasEntryDlg</b> sets the <b>dwError</b> member of the
///    RASENTRYDLG structure to a value from Routing and Remote Access Error Codes or Winerror.h.
///    
@DllImport("RASDLG")
BOOL RasEntryDlgW(PWSTR lpszPhonebook, PWSTR lpszEntry, tagRASENTRYDLGW* lpInfo);

///The <b>RasDialDlg</b> function establishes a RAS connection using a specified phone-book entry and the credentials of
///the logged-on user. The function displays a stream of dialog boxes that indicate the state of the connection
///operation.
///Params:
///    lpszPhonebook = Pointer to a null-terminated string that specifies the full path and file name of a phone-book (PBK) file. If
///                    this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book file
///                    is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up Networking</b>
///                    dialog box.
///    lpszEntry = Pointer to a null-terminated string that specifies the name of the phone-book entry to dial.
///    lpszPhoneNumber = Pointer to a null-terminated string that specifies a phone number that overrides the numbers stored in the
///                      phone-book entry. If this parameter is <b>NULL</b>, <b>RasDialDlg</b> uses the numbers in the phone-book entry.
///    lpInfo = Pointer to a RASDIALDLG structure that specifies additional input and output parameters. The <b>dwSize</b> member
///             of this structure must specify sizeof(<b>RASDIALDLG</b>). If an error occurs, the <b>dwError</b> member returns
///             an error code; otherwise, it returns zero.
///Returns:
///    If the function establishes a RAS connection, the return value is <b>TRUE</b>. Otherwise, the function should
///    return <b>FALSE</b>. If an error occurs, <b>RasDialDlg</b> should set the <b>dwError</b> member of the RASDIALDLG
///    structure to a value from Routing and Remote Access Error Codes or Winerror.h.
///    
@DllImport("RASDLG")
BOOL RasDialDlgA(PSTR lpszPhonebook, PSTR lpszEntry, PSTR lpszPhoneNumber, tagRASDIALDLG* lpInfo);

///The <b>RasDialDlg</b> function establishes a RAS connection using a specified phone-book entry and the credentials of
///the logged-on user. The function displays a stream of dialog boxes that indicate the state of the connection
///operation.
///Params:
///    lpszPhonebook = Pointer to a null-terminated string that specifies the full path and file name of a phone-book (PBK) file. If
///                    this parameter is <b>NULL</b>, the function uses the current default phone-book file. The default phone-book file
///                    is the one selected by the user in the <b>User Preferences</b> property sheet of the <b>Dial-Up Networking</b>
///                    dialog box.
///    lpszEntry = Pointer to a null-terminated string that specifies the name of the phone-book entry to dial.
///    lpszPhoneNumber = Pointer to a null-terminated string that specifies a phone number that overrides the numbers stored in the
///                      phone-book entry. If this parameter is <b>NULL</b>, <b>RasDialDlg</b> uses the numbers in the phone-book entry.
///    lpInfo = Pointer to a RASDIALDLG structure that specifies additional input and output parameters. The <b>dwSize</b> member
///             of this structure must specify sizeof(<b>RASDIALDLG</b>). If an error occurs, the <b>dwError</b> member returns
///             an error code; otherwise, it returns zero.
///Returns:
///    If the function establishes a RAS connection, the return value is <b>TRUE</b>. Otherwise, the function should
///    return <b>FALSE</b>. If an error occurs, <b>RasDialDlg</b> should set the <b>dwError</b> member of the RASDIALDLG
///    structure to a value from Routing and Remote Access Error Codes or Winerror.h.
///    
@DllImport("RASDLG")
BOOL RasDialDlgW(PWSTR lpszPhonebook, PWSTR lpszEntry, PWSTR lpszPhoneNumber, tagRASDIALDLG* lpInfo);

///The <b>MprAdminConnectionEnumEx</b> function enumerates the active connections for a specified RRAS server.
///Params:
///    hRasServer = A handle to the RAS server on which connections are enumerated. Obtain this handle by calling
///                 MprAdminServerConnect.
///    pObjectHeader = A pointer to an MPRAPI_OBJECT_HEADER structure that specifies the structure version received by <i>ppRasConn</i>.
///    dwPreferedMaxLen = A value that specifies the preferred maximum length of returned data in 8-bit bytes. If <i>dwPrefMaxLen</i> is
///                       -1, the buffer returned is large enough to hold all available information.
///    lpdwEntriesRead = A pointer to a <b>DWORD</b> that receives the total number of connections enumerated from the current resume
///                      position.
///    lpdwTotalEntries = A pointer to a <b>DWORD</b> that receives the total number of connections that could have been enumerated from
///                       the current resume position.
///    ppRasConn = A pointer, on output, to an array of RAS_CONNECTION_EX structures that contain the active connection information
///                for the RRAS server in <i>hRasServer</i>. The number of array elements is determined by the value pointed to by
///                <i>lpdwEntriesRead</i>.
///    lpdwResumeHandle = A pointer to a <b>DWORD</b> variable that specifies a resume handle used to continue the enumeration. The
///                       <i>lpdwResumeHandle</i> parameter is <b>NULL</b> on the first call, and left unchanged on subsequent calls. If
///                       the return code is <b>ERROR_MORE_DATA</b>, another call may be made using this handle to retrieve more data. If
///                       the handle is <b>NULL</b> upon return, the enumeration is complete. This handle is invalid for other types of
///                       error returns.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DDM_NOT_RUNNING</b></dt> </dl> </td> <td
///    width="60%"> The Demand Dial Manager (DDM) is not running. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> Not all of the data was returned with this call. To
///    obtain additional data, call the function again using the resume handle. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_PROC_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified procedure could not be found.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> An error from
///    MprError.h, RasError.h, or WinError.h. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminConnectionEnumEx(ptrdiff_t hRasServer, MPRAPI_OBJECT_HEADER* pObjectHeader, uint dwPreferedMaxLen, 
                              uint* lpdwEntriesRead, uint* lpdwTotalEntries, RAS_CONNECTION_EX** ppRasConn, 
                              uint* lpdwResumeHandle);

///The <b>MprAdminConnectionGetInfoEx</b> function retrieves the connection information for a specific connection on a
///specified RRAS server.
///Params:
///    hRasServer = A handle to the computer from which the connection information is retrieved. To obtain this handle, call
///                 MprAdminServerConnect.
///    hRasConnection = A handle to the connection to retrieve data about. To obtain this handle, call MprAdminConnectionEnum.
///    pRasConnection = A pointer, on output, to a RAS_CONNECTION_EX structure that contains the connection information for the RRAS
///                     server in <i>hRasServer</i>. To free this memory, call MprAdminBufferFree.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DDM_NOT_RUNNING</b></dt> </dl> </td> <td
///    width="60%"> The Demand Dial Manager (DDM) is not running. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_PROC_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified procedure could not be found.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> An error from
///    MprError.h, RasError.h, or WinError.h. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminConnectionGetInfoEx(ptrdiff_t hRasServer, HANDLE hRasConnection, RAS_CONNECTION_EX* pRasConnection);

///The <b>MprAdminServerGetInfoEx</b> function retrieves port information about the specified RRAS server.
///Params:
///    hMprServer = A handle to the server to query. Obtain this handle by calling MprAdminServerConnect.
///    pServerInfo = A pointer, on output, to a MPR_SERVER_EX structure that contains the port information for the RRAS server in
///                  <i>hMprServer</i>. To free this memory, call MprAdminBufferFree.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DDM_NOT_RUNNING</b></dt> </dl> </td> <td
///    width="60%"> The Demand Dial Manager (DDM) is not running. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_PROC_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified procedure could not be found.
///    </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminServerGetInfoEx(ptrdiff_t hMprServer, MPR_SERVER_EX1* pServerInfo);

///The <b>MprAdminServerSetInfoEx</b> function sets port information on a specified RRAS server.
///Params:
///    hMprServer = A handle to the router to query. Obtain this handle by calling MprAdminServerConnect.
///    pServerInfo = A pointer to a MPR_SERVER_SET_CONFIG_EX structure that contains the port information being set on the server in
///                  <i>hMprServer</i>.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DDM_NOT_RUNNING</b></dt> </dl> </td> <td
///    width="60%"> The Demand Dial Manager (DDM) is not running. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_PROC_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified procedure could not be found.
///    </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminServerSetInfoEx(ptrdiff_t hMprServer, MPR_SERVER_SET_CONFIG_EX1* pServerInfo);

///The <b>MprConfigServerGetInfoEx</b> function retrieves port information for a specified server.
///Params:
///    hMprConfig = A handle to the router configuration. Obtain this handle by calling MprConfigServerConnect.
///    pServerInfo = A pointer, on output, to a MPR_SERVER_EX structure that contains the port information for the RRAS server in
///                  <i>hMprConfig</i>. To free this memory, call MprAdminBufferFree.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DDM_NOT_RUNNING</b></dt> </dl> </td> <td
///    width="60%"> The Demand Dial Manager (DDM) is not running. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_PROC_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified procedure could not be found.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to
///    retrieve the system error message that corresponds to the error code returned. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprConfigServerGetInfoEx(HANDLE hMprConfig, MPR_SERVER_EX1* pServerInfo);

///The <b>MprConfigServerSetInfoEx</b> function sets port information on a specified RRAS server.
///Params:
///    hMprConfig = A handle to the router configuration. Obtain this handle by calling MprConfigServerConnect.
///    pSetServerConfig = A pointer to a MPR_SERVER_SET_CONFIG_EX structure that contains the port information being set on the server in
///                       <i>hMprServer</i>.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The <b>pSetServerConfig</b> parameter is <b>NULL</b> or the <b>Header</b> field values are
///    erroneous. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DDM_NOT_RUNNING</b></dt> </dl> </td> <td
///    width="60%"> The Demand Dial Manager (DDM) is not running. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to retrieve the system error message that
///    corresponds to the error code returned. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprConfigServerSetInfoEx(HANDLE hMprConfig, MPR_SERVER_SET_CONFIG_EX1* pSetServerConfig);

@DllImport("MPRAPI")
uint MprAdminUpdateConnection(ptrdiff_t hRasServer, HANDLE hRasConnection, 
                              RAS_UPDATE_CONNECTION* pRasUpdateConnection);

///The <b>MprAdminIsServiceInitialized</b> function checks whether the RRAS service is running on a specified server if
///the calling process has access.
///Params:
///    lpwsServerName = A pointer to a <b>null</b>-terminated Unicode string that specifies the name of the server to query. If this
///                     parameter is <b>NULL</b>, the function queries the local machine.
///    fIsServiceInitialized = On output, a pointer to a BOOL that specifies whether the RRAS service is running on the server in
///                            <i>lpwsServerName</i>: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                            id="TRUE"></a><a id="true"></a><dl> <dt><b>TRUE</b></dt> </dl> </td> <td width="60%"> The service is running on
///                            the specified server. </td> </tr> <tr> <td width="40%"><a id="FALSE"></a><a id="false"></a><dl>
///                            <dt><b>FALSE</b></dt> </dl> </td> <td width="60%"> The service is not running on the specified server and/or the
///                            calling process does not have access to the RRAS service. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>fIsServiceInitialized</i> parameter
///    is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SERVICE_NOT_ACTIVE</b></dt> </dl> </td> <td
///    width="60%"> The RRAS service is not running on the server. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminIsServiceInitialized(PWSTR lpwsServerName, BOOL* fIsServiceInitialized);

///Sets the tunnel specific custom configuration for a specified demand dial interface on a specified server.
///Params:
///    hMprServer = The handle to the router to query. This handle is obtained by a previous call to the MprAdminServerConnect
///                 function.
///    hInterface = The handle to the interface. This handle is obtained by a previous call to the MprAdminInterfaceCreate function
///                 or the MprAdminInterfaceGetHandle function.
///    pCustomInfo = A pointer to a MPR_IF_CUSTOMINFOEX structure that contains tunnel specific custom configuration.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have
///    sufficient privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td>
///    <td width="60%"> The <i>hInterface</i> value is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>pCustomInfo</i> parameter is
///    <b>NULL</b> or the interface type is not <b>ROUTER_IF_TYPE_FULL_ROUTER</b>. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There were insufficient resources to
///    complete the operation. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminInterfaceSetCustomInfoEx(ptrdiff_t hMprServer, HANDLE hInterface, MPR_IF_CUSTOMINFOEX2* pCustomInfo);

///Retrieves tunnel-specific configuration for a specified demand dial interface on a specified server.
///Params:
///    hMprServer = A handle to the router to query. This handle is obtained by a previous call to the MprAdminServerConnect
///                 function.
///    hInterface = A handle to the interface. This handle is obtained by a previous call to the MprAdminInterfaceCreate function.
///    pCustomInfo = A pointer to a MPR_IF_CUSTOMINFOEX structure. When you have finished using the structure, free the memory by
///                  calling the MprAdminBufferFree function.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have
///    sufficient privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td>
///    <td width="60%"> The <i>hInterface</i> value is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>hInterface</i> value is not valid or
///    if the interface type is not <b>ROUTER_IF_TYPE_FULL_ROUTER</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There were insufficient resources to
///    complete the operation. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminInterfaceGetCustomInfoEx(ptrdiff_t hMprServer, HANDLE hInterface, MPR_IF_CUSTOMINFOEX2* pCustomInfo);

///Retrieves the custom IKEv2 policy configuration for the specified interface.
///Params:
///    hMprConfig = The handle to the router configuration. This handle is obtained by calling the MprConfigServerConnect function.
///    hRouterInterface = The handle to the interface configuration being updated. Obtain this handle by calling the
///                       MprConfigInterfaceCreate function, the MprConfigInterfaceGetHandle function, or the MprConfigInterfaceEnum
///                       function.
///    pCustomInfo = A pointer to a MPR_IF_CUSTOMINFOEX structure. When you have finished using the structure, free the buffer by
///                  calling the MprConfigBufferFree function.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> At least one of the following is true:
///    <ul> <li>The <i>hMprConfig</i> parameter is <b>NULL</b>.</li> <li>The <i>hRouterInterface</i> parameter is
///    <b>NULL</b>.</li> <li>The <i>pCustomInfo</i> parameter is <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There were insufficient
///    resources to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_SUCH_INTERFACE</b></dt> </dl> </td> <td width="60%"> The interface that corresponds to
///    <i>hRouterInterface</i> parameter is not present in the router configuration. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprConfigInterfaceGetCustomInfoEx(HANDLE hMprConfig, HANDLE hRouterInterface, 
                                       MPR_IF_CUSTOMINFOEX2* pCustomInfo);

///Sets the custom IKEv2 policy configuration for the specified interface.
///Params:
///    hMprConfig = The handle to the router configuration. Obtain this handle by calling the MprConfigServerConnect function.
///    hRouterInterface = The handle to the interface configuration being updated. Obtain this handle by calling the
///                       MprConfigInterfaceCreate function, the MprConfigInterfaceGetHandle function, or the MprConfigInterfaceEnum
///                       function.
///    pCustomInfo = A pointer to a MPR_IF_CUSTOMINFOEX structure.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> At least one of the following is true:
///    <ul> <li>The <i>hMprConfig</i> parameter is <b>NULL</b>.</li> <li>The <i>hRouterInterface</i> parameter is
///    <b>NULL</b>.</li> <li>The <i>pCustomInfo</i> parameter is <b>NULL</b>.</li> <li>The interface type is not
///    <b>ROUTER_IF_TYPE_FULL_ROUTER</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_SUCH_INTERFACE</b></dt> </dl> </td> <td width="60%"> The interface that corresponds to
///    <i>hRouterInterface</i> is not present in the router configuration. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprConfigInterfaceSetCustomInfoEx(HANDLE hMprConfig, HANDLE hRouterInterface, 
                                       MPR_IF_CUSTOMINFOEX2* pCustomInfo);

///The <b>MprAdminConnectionEnum</b> function enumerates all active connections.
///Params:
///    hRasServer = Handle to the RAS server on which connections are enumerated. Obtain this handle by calling
///                 MprAdminServerConnect.
///    dwLevel = A DWORD value that describes the format in which the information is returned in the <i>lplpbBuffer</i> parameter.
///              Acceptable values for <i>dwLevel</i> include 0, 1, 2, and 3, as listed in the following table. <b>Windows NT 4.0:
///              </b>This parameter must be zero. <table> <tr> <th>Value</th> <th>Structure Format</th> </tr> <tr> <td>0</td> <td>
///              RAS_CONNECTION_0 </td> </tr> <tr> <td>1</td> <td>Windows 2000 or later: RAS_CONNECTION_1 </td> </tr> <tr>
///              <td>2</td> <td>Windows 2000 or later: RAS_CONNECTION_2 </td> </tr> <tr> <td>3</td> <td>Windows Server 2008 or
///              later: RAS_CONNECTION_3 </td> </tr> </table>
///    lplpbBuffer = On successful completion, a pointer to an array of structures that describe the connection. These structures are
///                  of type RAS_CONNECTION_0, RAS_CONNECTION_1, RAS_CONNECTION_2, or RAS_CONNECTION_3, depending on the value of the
///                  <i>dwLevel</i> parameter. To free this memory, call MprAdminBufferFree.
///    dwPrefMaxLen = Specifies the preferred maximum length of returned data in 8-bit bytes. If <i>dwPrefMaxLen</i> is -1, the buffer
///                   returned is large enough to hold all available information.
///    lpdwEntriesRead = Pointer to a <b>DWORD</b> variable. This variable receives the total number of connections enumerated from the
///                      current resume position.
///    lpdwTotalEntries = Pointer to a <b>DWORD</b> variable. This variable receives the total number of connections that could have been
///                       enumerated from the current resume position.
///    lpdwResumeHandle = Pointer to a <b>DWORD</b> variable. This variable specifies a resume handle used to continue the enumeration. The
///                       <i>lpdwResumeHandle</i> parameter is zero on the first call, and left unchanged on subsequent calls. If the
///                       return code is ERROR_MORE_DATA, another call may be made using this handle to retrieve more data. If the handle
///                       is <b>NULL</b> upon return, the enumeration is complete. This handle is invalid for other types of error returns.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DDM_NOT_RUNNING</b></dt> </dl> </td> <td width="60%"> The Demand Dial Manager (DDM) is not running,
///    possibly because the Dynamic Interface Manager (DIM) is configured to run only on a LAN. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_LEVEL</b></dt> </dl> </td> <td width="60%"> The value passed for
///    <i>dwLevel</i> is not zero, one, two, or three. Levels one and two are supported only on Windows 2000 or later.
///    Level three is supported only on Windows Server 2008 or later. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> At least one of the following parameters is
///    <b>NULL</b> or does not point to valid memory: <i>lplpBuffer</i>, <i>lpdwEntriesRead</i>, or
///    <i>lpdwTotalEntries</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td
///    width="60%"> Not all of the data was returned with this call. To obtain additional data, call the function again
///    using the resume handle. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td>
///    <td width="60%"> The handle passed in the <i>hRasServer</i> parameter is <b>NULL</b> or invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> An error from MprError.h, RasError.h, or
///    WinError.h. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminConnectionEnum(ptrdiff_t hRasServer, uint dwLevel, ubyte** lplpbBuffer, uint dwPrefMaxLen, 
                            uint* lpdwEntriesRead, uint* lpdwTotalEntries, uint* lpdwResumeHandle);

///The <b>MprAdminPortEnum</b> function enumerates all active ports in a specific connection, or all ports available for
///use or currently used by RAS.
///Params:
///    hRasServer = A handle to the RAS server whose ports are to be enumerated. To obtain this handle, call MprAdminServerConnect.
///    dwLevel = A DWORD value that describes the format in which the information is returned in the <i>lplpbBuffer</i> parameter.
///              Must be zero.
///    hRasConnection = A handle to a connection for which the active ports are enumerated. If this parameter is
///                     <b>INVALID_HANDLE_VALUE</b>, all the ports in use or available for use by RRAS are enumerated. To obtain this
///                     handle, call MprAdminConnectionEnum.
///    lplpbBuffer = On successful completion, a pointer to an array of RAS_PORT_0 structures that describes the port. Free this
///                  memory by calling MprAdminBufferFree.
///    dwPrefMaxLen = A value that specifies the preferred maximum length of returned data, in 8-bit bytes. If this parameter is -1,
///                   the buffer that is returned is large enough to hold all available data.
///    lpdwEntriesRead = A pointer to a <b>DWORD</b> variable. This variable receives the total number of ports that are enumerated from
///                      the current resume position.
///    lpdwTotalEntries = A pointer to a <b>DWORD</b> variable. This variable receives the total number of ports that could have been
///                       enumerated from the current resume position.
///    lpdwResumeHandle = A pointer to a <b>DWORD</b> variable. On successful execution, this parameter specifies a handle that can be used
///                       to resume the enumeration. This parameter should be zero on the first call and left unchanged on subsequent
///                       calls. If the return code is <b>ERROR_MORE_DATA</b>, the call can be reissued with the handle to retrieve more
///                       data. If the handle is <b>NULL</b> on return, the enumeration cannot be continued. This handle is invalid for
///                       other types of error returns.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the error codes listed in the following table. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does
///    not have sufficient privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DDM_NOT_RUNNING</b></dt>
///    </dl> </td> <td width="60%"> The Demand Dial Manager (DDM) is not running, possibly because the Dynamic Interface
///    Manager (DIM) is configured to run only on a LAN. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> At least one of the following parameters is
///    <b>NULL</b> or does not point to valid memory: <i>lplpBuffer</i>, <i>lpdwEntriesRead</i>, or
///    <i>lpdwTotalEntries</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td
///    width="60%"> Not all of the data was returned with this call. To obtain additional data, call the function again
///    using the handle that was returned in the <i>IpdwResumeHandle</i> parameter. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The <i>dwLevel</i> parameter is not zero.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    <i>hConnection</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl>
///    </td> <td width="60%"> An error from MprError.h, RasError.h, or WinError.h. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminPortEnum(ptrdiff_t hRasServer, uint dwLevel, HANDLE hRasConnection, ubyte** lplpbBuffer, 
                      uint dwPrefMaxLen, uint* lpdwEntriesRead, uint* lpdwTotalEntries, uint* lpdwResumeHandle);

///The <b>MprAdminConnectionGetInfo</b> function retrieves data about a specific connection.
///Params:
///    hRasServer = A handle to the computer from which the connection information is retrieved. To obtain this handle, call
///                 MprAdminServerConnect.
///    dwLevel = A DWORD value that describes the format in which the information is returned in the <i>lplpbBuffer</i> parameter.
///              Acceptable values for <i>dwLevel</i> include 0, 1, 2, and 3, as listed in the following table. <b>Windows NT 4.0:
///              </b>This parameter must be zero. <table> <tr> <th>Value</th> <th>Structure Format</th> </tr> <tr> <td>0</td> <td>
///              RAS_CONNECTION_0 </td> </tr> <tr> <td>1</td> <td>Windows 2000 or later: RAS_CONNECTION_1 </td> </tr> <tr>
///              <td>2</td> <td>Windows 2000 or later: RAS_CONNECTION_2 </td> </tr> <tr> <td>3</td> <td>Windows Server 2008 or
///              later: RAS_CONNECTION_3 </td> </tr> </table>
///    hRasConnection = A handle to the connection to retrieve data about. To obtain this handle, call MprAdminConnectionEnum.
///    lplpbBuffer = On successful completion, a pointer to an array of structures that describe the connection. These structures are
///                  of type RAS_CONNECTION_0, RAS_CONNECTION_1, RAS_CONNECTION_2, or RAS_CONNECTION_3, depending on the value of the
///                  <i>dwLevel</i> parameter. To free this memory, call MprAdminBufferFree.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the error codes listed in the following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The handle to the RAS
///    server or the handle to the RAS connection is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_LEVEL</b></dt> </dl> </td> <td width="60%"> The value passed for <i>dwLevel</i> is not zero,
///    one, two, or three. Levels one and two are supported only on Windows 2000 or later. Level three is supported only
///    on Windows Server 2008 or later. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INTERFACE_NOT_CONNECTED</b></dt> </dl> </td> <td width="60%"> The <i>hConnection</i> handle is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td
///    width="60%"> The <i>hRasServer</i> handle is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> An error from MprError.h, RasError.h, or WinError.h. </td>
///    </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminConnectionGetInfo(ptrdiff_t hRasServer, uint dwLevel, HANDLE hRasConnection, ubyte** lplpbBuffer);

///The <b>MprAdminPortGetInfo</b> function gets information for a specific port.
///Params:
///    hRasServer = Handle to the RAS server computer on which to collect port information. Obtain this handle by calling
///                 MprAdminServerConnect.
///    dwLevel = A DWORD value that describes the format in which the information is returned in the <i>lplpbBuffer</i> parameter.
///              Acceptable values for <i>dwLevel</i> include 0 and 1 as listed in the following table. <table> <tr>
///              <th>Value</th> <th>Structure Format</th> </tr> <tr> <td>0</td> <td> RAS_PORT_0 </td> </tr> <tr> <td>1</td> <td>
///              RAS_PORT_1 </td> </tr> </table>
///    hPort = Handle to the port for which to collect information. Obtain this handle by calling MprAdminPortEnum.
///    lplpbBuffer = On successful completion, a pointer to a structure that describes the port. These structures are of type
///                  RAS_PORT_0 or RAS_PORT_1 depending on the value of the <i>dwLevel</i> parameter. Free this memory by calling
///                  MprAdminBufferFree.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DDM_NOT_RUNNING</b></dt> </dl> </td> <td
///    width="60%"> The Demand Dial Manager (DDM) is not running, possibly because the Dynamic Interface Manager (DIM)
///    is configured to run only on a LAN. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> At least one of the following parameters is
///    <b>NULL</b> or does not point to valid memory: <i>lplpBuffer</i>, <i>lpdwEntriesRead</i>, or
///    <i>lpdwTotalEntries</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PORT_HANDLE</b></dt> </dl>
///    </td> <td width="60%"> The <i>hPort</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The <i>dwLevel</i> parameter is not zero. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> An error from MprError.h,
///    RasError.h, or WinError.h. </td> </tr> </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprAdminPortGetInfo(ptrdiff_t hRasServer, uint dwLevel, HANDLE hPort, ubyte** lplpbBuffer);

///The <b>MprAdminConnectionClearStats</b> function resets the statistics counters for the specified connection.
///Params:
///    hRasServer = Handle to the Remote Access Server on which to execute <b>MprAdminConnectionClearStats</b>. Obtain this handle by
///                 calling MprAdminServerConnect.
///    hRasConnection = Handle to the connection for which to reset the statistics. Obtain this handle by calling MprAdminConnectionEnum.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DDM_NOT_RUNNING</b></dt> </dl> </td> <td
///    width="60%"> The Demand Dial Manager (DDM) is not running, possibly because the Dynamic Interface Manager (DIM)
///    is configured to run only on a LAN. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The handle to the port is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> This function
///    was called with <i>hRasServer</i> parameter equal to <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> An error from MprError.h, RasError.h, or WinError.h. </td>
///    </tr> </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprAdminConnectionClearStats(ptrdiff_t hRasServer, HANDLE hRasConnection);

///The <b>MprAdminPortClearStats</b> function resets the statistics for the specified port.
///Params:
///    hRasServer = Handle to the RAS server on which to clear the statistics for the specified port. Obtain this handle by calling
///                 MprAdminServerConnect.
///    hPort = Handle to the port for which statistics are reset. Obtain this handle by calling MprAdminPortEnum.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DDM_NOT_RUNNING</b></dt> </dl> </td> <td
///    width="60%"> The Demand Dial Manager (DDM) is not running, possibly because the Dynamic Interface Manager (DIM)
///    is configured to run only on a LAN. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_BINDING</b></dt>
///    </dl> </td> <td width="60%"> The handle to the RAS server or the handle to the port is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> An error from MprError.h, RasError.h, or
///    WinError.h. </td> </tr> </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprAdminPortClearStats(ptrdiff_t hRasServer, HANDLE hPort);

///The <b>MprAdminPortReset</b> function resets the communication device attached to the specified port.
///Params:
///    hRasServer = Handle to the RAS server on which to reset the specified port. Obtain this handle by calling
///                 MprAdminServerConnect.
///    hPort = Handle to the port to be reset. Obtain this handle by calling MprAdminPortEnum.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DDM_NOT_RUNNING</b></dt> </dl> </td> <td
///    width="60%"> The Demand Dial Manager (DDM) is not running, possibly because the Dynamic Interface Manager (DIM)
///    is configured to run only on a LAN. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The handle to the RAS server or the handle
///    to the port is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%">
///    An error from MprError.h, RasError.h, or WinError.h. </td> </tr> </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprAdminPortReset(ptrdiff_t hRasServer, HANDLE hPort);

///The <b>MprAdminPortDisconnect</b> function disconnects a connection on a specific port.
///Params:
///    hRasServer = Handle to the RAS server on which to disconnect the port. Obtain this handle by calling MprAdminServerConnect.
///    hPort = Handle to the port to disconnect. Obtain this handle by calling MprAdminPortEnum.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DDM_NOT_RUNNING</b></dt> </dl> </td> <td
///    width="60%"> The Demand Dial Manager (DDM) is not running, possibly because the Dynamic Interface Manager (DIM)
///    is configured to run only on a LAN. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The handle to the RAS server or the handle
///    to the port is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%">
///    An error from MprError.h, RasError.h, or WinError.h. </td> </tr> </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprAdminPortDisconnect(ptrdiff_t hRasServer, HANDLE hPort);

///The <b>MprAdminConnectionRemoveQuarantine</b> function removes quarantine filters on a dialed-in RAS client if the
///filters were applied as a result of Internet Authentication Service (IAS) policies.
///Params:
///    hRasServer = Handle to the RAS server that services the connection. Obtain this handle by calling MprAdminServerConnect.
///    hRasConnection = Handle to connection for the RAS client for which to remove the quarantine filters. Obtain this handle by calling
///                     MprAdminConnectionEnum. Alternatively, this parameter specifies the IP address of the RAS client for which to
///                     remove the quarantine filter. The IP address should be specified as a <b>DWORD</b> in network byte order. Obtain
///                     the IP address by calling MprAdminConnectionEnum. If this parameter specifies an IP address, the
///                     <i>fIsIpAddress</i> parameter should specify a <b>TRUE</b> value.
///    fIsIpAddress = Specifies a Boolean value that indicates whether the <i>hRasConnection</i> parameter specifies the IP address of
///                   the client for which to remove the quarantine filters. If this parameter is a <b>TRUE</b> value,
///                   <i>hRasConnection</i> specifies an IP address. Otherwise, <i>hRasConnection</i> specifies a handle to a
///                   connection.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The handle to the RAS server or the handle
///    to the RAS connection is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl>
///    </td> <td width="60%"> The RAS client is not in quarantine. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> An error from MprError.h, RasError.h, or WinError.h. </td>
///    </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminConnectionRemoveQuarantine(HANDLE hRasServer, HANDLE hRasConnection, BOOL fIsIpAddress);

///The <b>MprAdminUserGetInfo</b> function retrieves all RAS information for a particular user.
///Params:
///    lpszServer = Pointer to a Unicode string that specifies the name of the server with the master User Accounts Subsystem (UAS).
///                 If the remote access server is part of a domain, the computer with the UAS is either the primary domain
///                 controller or the backup domain controller. If the remote access server is not part of a domain, then the server
///                 itself stores the UAS. In either case, call the MprAdminGetPDCServer function to obtain the value for this
///                 parameter. If the server itself stores the UAS, this parameter can be <b>NULL</b>.
///    lpszUser = Pointer to a Unicode string that specifies the name of the user for which to get RAS information.
///    dwLevel = This parameter may be zero or one. <b>Windows NT Server 4.0 with SP3 and later: </b>This parameter must be zero.
///    lpbBuffer = Pointer to a RAS_USER_0 or RAS_USER_1 structure. The caller must allocate (and free) the memory for this
///                structure. Upon successful return, this structure contains the RAS data for the specified user. <b>Windows NT
///                Server 4.0 with SP3 and later: </b>If the <i>dwLevel</i> parameter specifies zero, <i>lpbBuffer</i> should point
///                to a RAS_USER_0 structure.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails the return value is one of the
///    following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have sufficient privileges.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_LEVEL</b></dt> </dl> </td> <td width="60%"> The value
///    of <i>dwLevel</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt>
///    </dl> </td> <td width="60%"> <i>lpbBuffer</i> is <b>NULL</b> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_SUCH_USER</b></dt> </dl> </td> <td width="60%"> The user specified by <i>lpwsUserName</i> does
///    not exist on the server specified by <i>lpwsServerName</i>. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminUserGetInfo(const(PWSTR) lpszServer, const(PWSTR) lpszUser, uint dwLevel, ubyte* lpbBuffer);

///The <b>MprAdminUserSetInfo</b> function sets RAS information for the specified user.
///Params:
///    lpszServer = Pointer to a Unicode string that specifies the name of the server with the master User Accounts Subsystem (UAS).
///                 If the remote access server is part of a domain, the computer with the UAS is either the primary domain
///                 controller or the backup domain controller. If the remote access server is not part of a domain, then the server
///                 itself stores the UAS. In either case, call the MprAdminGetPDCServer function to obtain the value for this
///                 parameter. If the server itself stores the UAS, this parameter can be <b>NULL</b>.
///    lpszUser = Pointer to a Unicode string that specifies the name of the user for which to set RAS information.
///    dwLevel = This parameter can be zero or one, corresponding to the structure type pointed to by the <i>lpbBuffer</i>
///              parameter. <b>Windows NT Server 4.0 with SP3 and later: </b>This parameter must be zero.
///    lpbBuffer = Pointer to a RAS_USER_0 or RAS_USER_1 structure that specifies the new RAS information for the user. <b>Windows
///                NT Server 4.0 with SP3 and later: </b>If the <i>dwLevel</i> parameter specifies zero, <i>lpbBuffer</i> should
///                point to a RAS_USER_0 structure.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have sufficient privileges.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR _INVALID_LEVEL</b></dt> </dl> </td> <td width="60%"> The
///    value of <i>dwLevel</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient resources to complete the
///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SUCH_USER</b></dt> </dl> </td> <td width="60%">
///    The user specified by <i>lpwsUserName</i> does not exist on the server specified by <i>lpwsServerName</i>. </td>
///    </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminUserSetInfo(const(PWSTR) lpszServer, const(PWSTR) lpszUser, uint dwLevel, const(ubyte)* lpbBuffer);

///The <b>MprAdminSendUserMessage</b> function sends a message to the user connected on the specified connection.
///Params:
///    hMprServer = Handle to the RAS server on which the user is connected. Obtain this handle by calling MprAdminServerConnect.
///    hConnection = Handle to the connection on which the user is connected. Use MprAdminConnectionEnum to obtain this handle.
///    lpwszMessage = Pointer to a Unicode string that specifies the message to the user.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have sufficient privileges.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DDM_NOT_RUNNING</b></dt> </dl> </td> <td width="60%"> The
///    Demand Dial Manager (DDM) is not running, possibly because the Dynamic Interface Manager (DIM) is configured to
///    run only on a LAN. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INTERFACE_NOT_CONNECTED</b></dt> </dl>
///    </td> <td width="60%"> The <i>hConnection</i> parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>lpwszMessage</i> parameter is
///    <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminSendUserMessage(ptrdiff_t hMprServer, HANDLE hConnection, PWSTR lpwszMessage);

///The <b>MprAdminGetPDCServer</b> function retrieves the name of the server with the master User Accounts Subsystem
///(UAS) from either a domain name or a server name. Either the domain name parameter or the server name parameter may
///be <b>NULL</b>, but not both.
///Params:
///    lpszDomain = Pointer to a null-terminated Unicode string that specifies the name of the domain to which the RAS server
///                 belongs. This parameter can be <b>NULL</b> if you are running your RAS administration application on a Windows
///                 NT/Windows 2000 server that is not participating in a domain. If this parameter is <b>NULL</b>, the
///                 <i>lpwsServerName</i> parameter must not be <b>NULL</b>.
///    lpszServer = Pointer to a null-terminated Unicode string that specifies the name of the Windows NT/Windows 2000 RAS server.
///                 Specify the name with leading "\\" characters, in the form: <b>\\servername</b>. This parameter can be
///                 <b>NULL</b> if the <i>lpwsDomain</i> parameter is not <b>NULL</b>.
///    lpszPDCServer = Pointer to a buffer that receives a null-terminated Unicode string that contains the name of a domain controller
///                    that has the user account database. The buffer should be big enough to hold the server name (UNCLEN +1). The
///                    function prefixes the returned server name with leading "\\" characters, in the form: <b>\\servername</b>.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails the return value is one of
///    the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_SUCH_DOMAIN</b></dt> </dl> </td> <td width="60%"> The domain specified is not valid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>NERR_InvalidComputer</b></dt> </dl> </td> <td width="60%"> The
///    <i>lpwsDomainName</i> parameter is <b>NULL</b>, and <i>lpwsServerName</i> parameter is not valid. </td> </tr>
///    </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprAdminGetPDCServer(const(PWSTR) lpszDomain, const(PWSTR) lpszServer, PWSTR lpszPDCServer);

///The <b>MprAdminIsServiceRunning</b> function checks whether the RRAS service is running on a specified server if the
///calling process has access.
///Params:
///    lpwsServerName = A pointer to a <b>null</b>-terminated Unicode string that specifies the name of the server to query. If this
///                     parameter is <b>NULL</b>, the function queries the local machine.
///Returns:
///    The return value is one of the following Boolean values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>TRUE</b></dt> </dl> </td> <td width="60%"> The service is running on the specified
///    server. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FALSE</b></dt> </dl> </td> <td width="60%"> The service is
///    not running on the specified server and/or the calling process does not have access to the RRAS service. </td>
///    </tr> </table>
///    
@DllImport("MPRAPI")
BOOL MprAdminIsServiceRunning(PWSTR lpwsServerName);

///The <b>MprAdminServerConnect</b> function establishes a connection to a router for the purpose of administering that
///router. Call this function before making any other calls to the server. Use the handle returned in subsequent calls
///to administer interfaces on the server.
///Params:
///    lpwsServerName = A pointer to a <b>null</b>-terminated Unicode string that specifies the name of the remote server. If this
///                     parameter is <b>NULL</b>, the function returns a handle to the local machine.
///    phMprServer = A pointer to a <b>HANDLE</b> variable that receives a handle to the server. Use this handle in subsequent calls
///                  to administer the server.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privilege. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td
///    width="60%"> This function was called with <i>phMprServer</i> parameter equal to <b>NULL</b>. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>RPC_S_UNKNOWN_IF</b></dt> </dl> </td> <td width="60%"> The specified computer is not
///    running the Routing and RAS service. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminServerConnect(PWSTR lpwsServerName, ptrdiff_t* phMprServer);

///The <b>MprAdminServerDisconnect</b> function disconnects the connection made by a previous call to
///MprAdminServerConnect.
///Params:
///    hMprServer = Handle to the router from which to disconnect. Obtain this handle by calling MprAdminServerConnect.
@DllImport("MPRAPI")
void MprAdminServerDisconnect(ptrdiff_t hMprServer);

///The <b>MprAdminServerGetCredentials</b> function retrieves the pre-shared key for the specified server.
///Params:
///    hMprServer = Handle to a Windows server. Obtain this handle by calling MprAdminMIBServerConnect.
///    dwLevel = A DWORD value that describes the format in which the information is returned in the <i>lplpbBuffer</i> parameter.
///              Must be zero.
///    lplpbBuffer = On successful completion, a pointer to an MPR_CREDENTIALSEX_1 structure that contains the pre-shared key for the
///                  server. Free the memory occupied by this structure with MprAdminBufferFree.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The <i>lplpbBuffer</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The <i>dwLevel</i> parameter is not zero. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to retrieve
///    the system error message that corresponds to the error code returned. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminServerGetCredentials(ptrdiff_t hMprServer, uint dwLevel, ubyte** lplpbBuffer);

///The <b>MprAdminServerSetCredentials</b> functions sets the pre-shared key for the specified server.
///Params:
///    hMprServer = Handle to a Windows server. Obtain this handle by calling MprAdminMIBServerConnect.
///    dwLevel = A DWORD value that describes the format in which the information is structured in the <i>lpbBuffer</i> parameter.
///              Must be zero.
///    lpbBuffer = A pointer to an MPR_CREDENTIALSEX_1 structure that contains the pre-shared key for the server.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The <i>lpbBuffer</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The <i>dwLevel</i> parameter is not zero. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to retrieve
///    the system error message that corresponds to the error code returned. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminServerSetCredentials(ptrdiff_t hMprServer, uint dwLevel, ubyte* lpbBuffer);

///The <b>MprAdminBufferFree</b> function frees memory buffers returned by: MprAdminDeviceEnum,
///MprAdminInterfaceGetInfo, MprAdminInterfaceDeviceGetInfo, MprAdminInterfaceEnum, MprAdminServerGetInfo,
///MprAdminInterfaceTransportGetInfo, and MprAdminTransportGetInfo.
///Params:
///    pBuffer = Pointer to the memory buffer to free.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is the following
///    error code. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>pBuffer</i> parameter is <b>NULL</b>.
///    </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminBufferFree(void* pBuffer);

///The <b>MprAdminGetErrorString</b> function returns the string associated with a router error from Mprerror.h.
///Params:
///    dwError = Specifies the error code for a router error.
///    lplpwsErrorString = Pointer to an <b>LPWSTR</b> variable that points to the text associated with the <i>dwError</i> code on
///                        successful return. Free this memory by calling LocalFree.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MR_MID_NOT_FOUND</b></dt> </dl> </td> <td
///    width="60%"> The error code in <i>dwError</i> is unknown. </td> </tr> </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprAdminGetErrorString(uint dwError, PWSTR* lplpwsErrorString);

///The <b>MprAdminServerGetInfo</b> function retrieves information about the specified RRAS server.
///Params:
///    hMprServer = Handle to the router to query. Obtain this handle by calling MprAdminServerConnect.
///    dwLevel = A DWORD value that describes the format in which the information is returned in the <i>lplpBuffer</i> parameter.
///              Acceptable values for <i>dwLevel</i> include 0, 1, and 2 as listed in the following table. <table> <tr>
///              <th>Value</th> <th>Structure Format</th> </tr> <tr> <td>0</td> <td>Windows 2000 Server or later: MPR_SERVER_0
///              </td> </tr> <tr> <td>1</td> <td>Windows Server 2003 or later: MPR_SERVER_1 </td> </tr> <tr> <td>2</td>
///              <td>Windows Server 2008 or later: MPR_SERVER_2 </td> </tr> </table>
///    lplpbBuffer = On successful completion, a pointer to a MPR_SERVER_0, MPR_SERVER_1, or MPR_SERVER_2 structure. The
///                  <i>dwLevel</i> parameter indicates the type of structure. Free the memory for this buffer using
///                  MprAdminBufferFree
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The <i>lplpbBuffer</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The <i>hMprServer</i> parameter is
///    <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminServerGetInfo(ptrdiff_t hMprServer, uint dwLevel, ubyte** lplpbBuffer);

///The <b>MprAdminServerSetInfo</b> function is used to set the number of ports for L2TP, PPTP, and SSTP devices when
///the RRAS service is running.
///Params:
///    hMprServer = Handle to the router to query. Obtain this handle by calling MprAdminServerConnect.
///    dwLevel = A DWORD value that describes the format in which the information is structured in the <i>lpbBuffer</i> parameter.
///              Acceptable values for <i>dwLevel</i> include 1 and 2 as listed in the following table. <table> <tr>
///              <th>Value</th> <th>Structure Format</th> </tr> <tr> <td>1</td> <td>Windows Server 2003 or later: MPR_SERVER_1
///              </td> </tr> <tr> <td>2</td> <td>Windows Server 2008 or later: MPR_SERVER_2 </td> </tr> </table>
///    lpbBuffer = A pointer to a MPR_SERVER_1 or MPR_SERVER_2 structure. The <i>dwLevel</i> parameter indicates the type of
///                structure.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS_REBOOT_REQUIRED</b></dt> </dl> </td> <td
///    width="60%"> A system reboot is required for such a change to take affect. Change the port count using the
///    MprConfigServerSetInfo call and reboot. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> If you try to set the number of ports to
///    more than the system supported limits as defined on the MPR_SERVER_1 and MPR_SERVER_2 topics. Returns this error
///    if you try to set the number of PPTP ports to 0. Returns this error if the flags are not valid or if
///    <i>lpbBuffer</i> or <i>hMprServer</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DDM_NOT_RUNNING</b></dt> </dl> </td> <td width="60%"> RRAS service is not running on this server.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The value
///    of <i>dwLevel</i> is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl>
///    </td> <td width="60%"> <i>hMprServer</i> handle is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to retrieve the system error message that
///    corresponds to the error code returned. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminServerSetInfo(ptrdiff_t hMprServer, uint dwLevel, ubyte* lpbBuffer);

///The MprAdminEstablishDomainRasServer function establishes the given machine as a Remote Access Server in the domain.
///This function must be executed only on a machine joined to a domain.
///Params:
///    pszDomain = The domain in which you want the server to be advertised.
///    pszMachine = The name of the RAS server.
///    bEnable = A <b>BOOL</b> that is <b>TRUE</b> if the RAS server should be advertised in the domain. Otherwise, it is
///              <b>FALSE</b>.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DS_SERVER_DOWN</b></dt> </dl> </td> <td width="60%"> pszDomain is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> pszMachine is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_DS_OPERATIONS_ERROR</b></dt> </dl> </td> <td width="60%"> User is a
///    non-domain user. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SUCH_DOMAIN</b></dt> </dl> </td> <td
///    width="60%"> Function executed on a machine not joined to any domain. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminEstablishDomainRasServer(PWSTR pszDomain, PWSTR pszMachine, BOOL bEnable);

///The MprAdminIsDomainRasServer function returns information regarding whether the given machine is registered as the
///remote access server in the domain.
///Params:
///    pszDomain = The domain in which you want to query the remote access server.
///    pszMachine = The name of the remote access server.
///    pbIsRasServer = Returns <b>TRUE</b> if the machine is registered in the domain, otherwise it returns <b>FALSE</b>.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DS_SERVER_DOWN</b></dt> </dl> </td> <td width="60%"> pszDomain is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> pszMachine is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_DS_OPERATIONS_ERROR</b></dt> </dl> </td> <td width="60%"> User is a
///    non-domain user. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SUCH_DOMAIN</b></dt> </dl> </td> <td
///    width="60%"> Function executed on a machine not joined to any domain. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminIsDomainRasServer(PWSTR pszDomain, PWSTR pszMachine, BOOL* pbIsRasServer);

///The <b>MprAdminTransportCreate</b> function loads a new transport, and starts the router manager for the transport.
///Params:
///    hMprServer = Handle to the router on which to set the information. Obtain this handle by calling MprAdminServerConnect.
///    dwTransportId = A <b>DWORD</b> value that describes the transport configuration type to set. Acceptable values for
///                    <i>dwTransportId</i> are listed in the following table. <table> <tr> <th>Value</th> <th>Transport (Protocol
///                    Family)</th> </tr> <tr> <td>PID_ATALK</td> <td>AppleTalk</td> </tr> <tr> <td>PID_IP</td> <td>Internet Protocol
///                    version 4</td> </tr> <tr> <td>PID_IPX</td> <td>Internet Packet Exchange</td> </tr> <tr> <td>PID_NBF</td>
///                    <td>NetBIOS Frames Protocol</td> </tr> <tr> <td>PID_IPV6</td> <td>Windows Server 2008 or later: Internet Protocol
///                    version 6</td> </tr> </table>
///    lpwsTransportName = Pointer to a <b>null</b>-terminated Unicode string that specifies the name of the transport.
///    pGlobalInfo = Pointer to a buffer that specifies global information for the transport. Use the Information Header Functions to
///                  manipulate information headers.
///    dwGlobalInfoSize = Specifies the size, in bytes, of the data pointed to by the <i>pGlobalInfo</i> parameter.
///    pClientInterfaceInfo = Pointer to a buffer that specifies default client interface information for the transport. This parameter is
///                           optional. If the calling application specifies <b>NULL</b> for this parameter, the function does not set the
///                           default client interface information.
///    dwClientInterfaceInfoSize = Specifies the size, in bytes, of the buffer pointed to by the <i>pClientInterfaceInfo</i> parameter.
///    lpwsDLLPath = Pointer to a <b>null</b>-terminated Unicode string that specifies the path to the DLL for the transport.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The <i>pGlobalInfo</i> parameter and the <i>pClientInterfaceInfo</i> parameter are both <b>NULL</b>.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%">
///    Insufficient resources to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_PROTOCOL_ALREADY_INSTALLED</b></dt> </dl> </td> <td width="60%"> The specified transport is already
///    running on the specified router. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_UNKNOWN_PROTOCOL_ID</b></dt>
///    </dl> </td> <td width="60%"> The <i>dwTransportId</i> value does not match any supported transport protocol.
///    </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminTransportCreate(ptrdiff_t hMprServer, uint dwTransportId, PWSTR lpwsTransportName, ubyte* pGlobalInfo, 
                             uint dwGlobalInfoSize, ubyte* pClientInterfaceInfo, uint dwClientInterfaceInfoSize, 
                             PWSTR lpwsDLLPath);

///The <b>MprAdminTransportSetInfo</b> function sets global information, or default client interface information, or
///both, for a specified transport.
///Params:
///    hMprServer = Handle to the router on which information is being set. This handle is obtained from a previous call to
///                 MprAdminServerConnect.
///    dwTransportId = A <b>DWORD</b> value that describes the transport type to set. Acceptable values for <i>dwTransportId</i> are
///                    listed in the following table. <table> <tr> <th>Value</th> <th>Transport (Protocol Family)</th> </tr> <tr>
///                    <td>PID_ATALK</td> <td>AppleTalk</td> </tr> <tr> <td>PID_IP</td> <td>Internet Protocol version 4</td> </tr> <tr>
///                    <td>PID_IPX</td> <td>Internet Packet Exchange</td> </tr> <tr> <td>PID_NBF</td> <td>NetBIOS Frames Protocol</td>
///                    </tr> <tr> <td>PID_IPV6</td> <td>Windows Server 2008 or later: Internet Protocol version 6</td> </tr> </table>
///    pGlobalInfo = Pointer to a buffer that specifies global information for the transport. Use the Information Header Functions to
///                  manipulate information headers. This parameter is optional. If the calling application specifies <b>NULL</b> for
///                  this parameter, the function does not set the global information.
///    dwGlobalInfoSize = Specifies the size, in bytes, of the buffer pointed to by the <i>pGlobalInfo</i> parameter.
///    pClientInterfaceInfo = Pointer to a buffer that specifies default client interface information for the transport. This parameter is
///                           optional. If the calling application specifies <b>NULL</b> for this parameter, the function does not set the
///                           default client interface information.
///    dwClientInterfaceInfoSize = Specifies the size, in bytes, of the buffer pointed to by the <i>pClientInterfaceInfo</i> parameter.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The <i>pGlobalInfo</i> parameter and the <i>pClientInterfaceInfo</i> parameter are both <b>NULL</b>.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%">
///    Insufficient resources to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_UNKNOWN_PROTOCOL_ID</b></dt> </dl> </td> <td width="60%"> The <i>dwTransportId</i> value does not
///    match any supported transport protocols. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminTransportSetInfo(ptrdiff_t hMprServer, uint dwTransportId, ubyte* pGlobalInfo, uint dwGlobalInfoSize, 
                              ubyte* pClientInterfaceInfo, uint dwClientInterfaceInfoSize);

///The <b>MprAdminTransportGetInfo</b> function retrieves global information, default client interface information, or
///both, for a specified transport.
///Params:
///    hMprServer = Handle to the router from which information is being retrieved. This handle is obtained from a previous call to
///                 MprAdminServerConnect.
///    dwTransportId = A <b>DWORD</b> value that describes the transport type to retrieve. Acceptable values for <i>dwTransportId</i>
///                    are listed in the following table. <table> <tr> <th>Value</th> <th>Transport (Protocol Family)</th> </tr> <tr>
///                    <td>PID_ATALK</td> <td>AppleTalk</td> </tr> <tr> <td>PID_IP</td> <td>Internet Protocol version 4</td> </tr> <tr>
///                    <td>PID_IPX</td> <td>Internet Packet Exchange</td> </tr> <tr> <td>PID_NBF</td> <td>NetBIOS Frames Protocol</td>
///                    </tr> <tr> <td>PID_IPV6</td> <td>Windows Server 2008 or later: Internet Protocol version 6</td> </tr> </table>
///    ppGlobalInfo = Pointer to a pointer variable. This variable points to an information header that receives global information for
///                   this transport. Use the Information Header Functions to manipulate information headers. Free this memory by
///                   calling MprAdminBufferFree. This parameter is optional. If the calling application specifies <b>NULL</b> for this
///                   parameter, the function does not retrieve the global information.
///    lpdwGlobalInfoSize = Pointer to a <b>DWORD</b> variable. This variable receives the size, in bytes, of the global information for the
///                         transport.
///    ppClientInterfaceInfo = Pointer to a pointer variable. This variable points to default client interface information for this transport.
///                            Free this memory by calling MprAdminBufferFree. This parameter is optional. If the calling application specifies
///                            <b>NULL</b> for this parameter, the function does not retrieve the client interface information.
///    lpdwClientInterfaceInfoSize = Pointer to a <b>DWORD</b> variable. This variable receives the size, in bytes, of the client interface
///                                  information.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One of the following is true: <ul> <li>The <i>ppGlobalInfo</i> parameter and the
///    <i>ppClientInterfaceInfo</i> parameter are both <b>NULL</b>.</li> <li>The <i>ppGlobalInfo</i> parameter does not
///    point to valid memory.</li> <li>The <i>ppClientInterfaceInfo</i> parameter does not point to valid memory.</li>
///    </ul> </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%">
///    Insufficient resources to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_UNKNOWN_PROTOCOL_ID</b></dt> </dl> </td> <td width="60%"> The <i>dwTransportId</i> value does not
///    match any installed transport. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminTransportGetInfo(ptrdiff_t hMprServer, uint dwTransportId, ubyte** ppGlobalInfo, 
                              uint* lpdwGlobalInfoSize, ubyte** ppClientInterfaceInfo, 
                              uint* lpdwClientInterfaceInfoSize);

///The <b>MprAdminDeviceEnum</b>function is called to enumerate RAS capable devices installed on the computer that can
///return their name and type.
///Params:
///    hMprServer = Handle to the router on which to execute this call. Obtain this handle by calling MprAdminServerConnect.
///    dwLevel = A DWORD value that describes the format in which the information is returned in the <i>lplpbBuffer</i> parameter.
///              Must be zero.
///    lplpbBuffer = On successful completion, an array of MPR_DEVICE_0 structures that contains the RAS capable device information.
///                  Free this memory by calling MprAdminBufferFree.
///    lpdwTotalEntries = The number of entries of type MPR_DEVICE_0 in <i>lplpbBuffer</i>.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED </b></dt> </dl> </td> <td width="60%"> The <i>dwlevel</i> parameter does not equal
///    zero. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER </b></dt> </dl> </td> <td
///    width="60%"> The <i>lplpbBuffer</i> or <i>lpdwTotalEntries</i> parameter is <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminDeviceEnum(ptrdiff_t hMprServer, uint dwLevel, ubyte** lplpbBuffer, uint* lpdwTotalEntries);

///The <b>MprAdminInterfaceGetHandle</b> function retrieves a handle to a specified interface.
///Params:
///    hMprServer = Handle to the router on which to execute this call. Obtain this handle by calling MprAdminServerConnect.
///    lpwsInterfaceName = Pointer to a <b>null</b>-terminated Unicode string that specifies the name of the interface to be retrieved.
///    phInterface = Pointer to a <b>HANDLE</b> variable that receives a handle to the interface specified by
///                  <i>lpwsInterfaceName</i>.
///    fIncludeClientInterfaces = Specifies whether the function returns a client interface. If this parameter is <b>FALSE</b>, interfaces of type
///                               <b>ROUTER_IF_TYPE_CLIENT</b> are ignored in the search for the interface with the name specified by
///                               <i>lpwsInterfaceName</i>. If this parameter is <b>TRUE</b> and an interface with the specified name exists,
///                               <b>MprAdminInterfaceGetHandle</b> returns a handle to an interface of type <b>ROUTER_IF_TYPE_CLIENT</b>. Since it
///                               is possible that there are several interfaces of type <b>ROUTER_IF_TYPE_CLIENT</b>, the handle returned
///                               references the first interface found with the name specified by <i>lpwsInterfaceName</i>.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SUCH_INTERFACE</b></dt> </dl> </td> <td
///    width="60%"> No interface exists with the name specified by <i>lpwsInterfaceName</i>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The passed in handle to the
///    server is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_X_NULL_REF_POINTER</b></dt> </dl> </td>
///    <td width="60%"> <i>lpwsInterfaceName</i> is <b>NULL</b>. </td> </tr> </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprAdminInterfaceGetHandle(ptrdiff_t hMprServer, PWSTR lpwsInterfaceName, HANDLE* phInterface, 
                                BOOL fIncludeClientInterfaces);

///The <b>MprAdminInterfaceCreate</b> function creates an interface on a specified server.
///Params:
///    hMprServer = Handle to the router on which to execute this call. Obtain this handle by calling MprAdminServerConnect.
///    dwLevel = A DWORD value that describes the format in which the information is structured in the <i>lpBuffer</i> parameter.
///              Acceptable values for <i>dwLevel</i> include 0, 1, 2, and 3, as listed in the following table. <table> <tr>
///              <th>Value</th> <th>Structure Format</th> </tr> <tr> <td>0</td> <td> MPR_INTERFACE_0 </td> </tr> <tr> <td>1</td>
///              <td> MPR_INTERFACE_1 </td> </tr> <tr> <td>2</td> <td> MPR_INTERFACE_2 </td> </tr> <tr> <td>3</td> <td>Windows
///              Server 2008 or later: MPR_INTERFACE_3 </td> </tr> </table>
///    lpbBuffer = A pointer to a MPR_INTERFACE_0, MPR_INTERFACE_1, MPR_INTERFACE_2, or MPR_INTERFACE_3 structure. The
///                <i>dwLevel</i> parameter indicates the type of structure.
///    phInterface = Pointer to a <b>HANDLE</b> variable. The variable receives a handle to use in all subsequent calls to manage this
///                  interface.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DDM_NOT_RUNNING</b></dt> </dl> </td> <td
///    width="60%"> The router interface type is not supported because the Dynamic Interface Manager is configured to
///    run only on a LAN. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INTERFACE_ALREADY_EXISTS</b></dt> </dl>
///    </td> <td width="60%"> An interface with the same name already exists. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient resources to complete the
///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td
///    width="60%"> The <i>dwLevel</i> value is invalid. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminInterfaceCreate(ptrdiff_t hMprServer, uint dwLevel, ubyte* lpbBuffer, HANDLE* phInterface);

///The <b>MprAdminInterfaceGetInfo</b> function retrieves information for a specified interface on a specified server.
///Params:
///    hMprServer = Handle to the router to query. This handle is obtained from a previous call to MprAdminServerConnect.
///    hInterface = Handle to the interface obtained by a previous call to MprAdminInterfaceCreate.
///    dwLevel = A DWORD value that describes the format in which the information is structured in the <i>lplpbBuffer</i>
///              parameter. Acceptable values for <i>dwLevel</i> include 0, 1, 2, and 3, as listed in the following table. <table>
///              <tr> <th>Value</th> <th>Structure Format</th> </tr> <tr> <td>0</td> <td> MPR_INTERFACE_0 </td> </tr> <tr>
///              <td>1</td> <td> MPR_INTERFACE_1 </td> </tr> <tr> <td>2</td> <td> MPR_INTERFACE_2 </td> </tr> <tr> <td>3</td>
///              <td>Windows Server 2008 or later: MPR_INTERFACE_3 </td> </tr> </table> Values of 1, 2, and 3 are valid only for
///              interfaces of type ROUTER_CONNECTION_STATE.
///    lplpbBuffer = A pointer to a MPR_INTERFACE_0, MPR_INTERFACE_1, MPR_INTERFACE_2, or MPR_INTERFACE_3 structure. The
///                  <i>dwLevel</i> parameter indicates the type of structure. Free this memory by calling MprAdminBufferFree.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_LEVEL</b></dt> </dl> </td> <td
///    width="60%"> The <i>dwLevel</i> is 2, but that level is not supported for the interface. For example, the type of
///    interface, as defined in the MPR_INTERFACE_X structure, is not <b>IF_TYPE_FULL_ROUTER</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The <i>hInterface</i> value
///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The <i>lplpbBuffer</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient resources to complete the
///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td
///    width="60%"> The <i>dwLevel</i> value is invalid. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminInterfaceGetInfo(ptrdiff_t hMprServer, HANDLE hInterface, uint dwLevel, ubyte** lplpbBuffer);

///The <b>MprAdminInterfaceSetInfo</b> function sets information for a specified interface on a specified server.
///Params:
///    hMprServer = Handle to the router to query. This handle is obtained from a previous call to MprAdminServerConnect.
///    hInterface = Handle to the interface obtained by a previous call to MprAdminInterfaceCreate.
///    dwLevel = A DWORD value that describes the format in which the information is structured in the <i>lpbBuffer</i> parameter.
///              Acceptable values for <i>dwLevel</i> include 0, 1, 2, and 3, as listed in the following table. <table> <tr>
///              <th>Value</th> <th>Structure Format</th> </tr> <tr> <td>0</td> <td> MPR_INTERFACE_0 </td> </tr> <tr> <td>1</td>
///              <td> MPR_INTERFACE_1 </td> </tr> <tr> <td>2</td> <td> MPR_INTERFACE_2 </td> </tr> <tr> <td>3</td> <td>Windows
///              Server 2008 or later: MPR_INTERFACE_3 </td> </tr> </table>
///    lpbBuffer = A pointer to a MPR_INTERFACE_0, MPR_INTERFACE_1, MPR_INTERFACE_2, or MPR_INTERFACE_3 structure. The
///                <i>dwLevel</i> parameter indicates the type of structure.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> The <i>hInterface</i> value is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>lplpbBuffer</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> Insufficient resources to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The <i>dwLevel</i> value is invalid. </td> </tr>
///    </table>
///    
@DllImport("MPRAPI")
uint MprAdminInterfaceSetInfo(ptrdiff_t hMprServer, HANDLE hInterface, uint dwLevel, ubyte* lpbBuffer);

///The <b>MprAdminInterfaceDelete</b> function deletes an interface on a specified server.
///Params:
///    hMprServer = Handle to the router on which to execute this call. Obtain this handle by calling MprAdminServerConnect.
///    hInterface = Handle to the interface to delete. Obtain this handle by calling MprAdminInterfaceCreate.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INTERFACE_CONNECTED</b></dt> </dl> </td> <td
///    width="60%"> The interface specified is a demand-dial interface and is currently connected. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The <i>hInterface</i> value
///    is invalid. </td> </tr> </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprAdminInterfaceDelete(ptrdiff_t hMprServer, HANDLE hInterface);

///The <b>MprAdminInterfaceDeviceGetInfo</b> retrieves information about a device that is used in a router demand-dial
///interface.
///Params:
///    hMprServer = Handle to router on which to execute this call. Obtain this handle by calling MprAdminServerConnect.
///    hInterface = Handle to the interface. Obtain this handle from a previous call to MprAdminInterfaceCreate, or by calling
///                 MprAdminInterfaceEnum
///    dwIndex = Specifies the one-based index of the device. A multi-linked demand-dial interface uses multiple devices.
///    dwLevel = A DWORD value that describes the format in which the information is returned in the <i>lplpBuffer</i> parameter.
///              Acceptable values for <i>dwLevel</i> include 0 or 1 as listed in the following table. <table> <tr> <th>Value</th>
///              <th>Structure Format</th> </tr> <tr> <td>0</td> <td> MPR_DEVICE_0 </td> </tr> <tr> <td>1</td> <td> MPR_DEVICE_1
///              </td> </tr> </table>
///    lplpBuffer = On successful completion, a pointer to a MPR_DEVICE_0 or MPR_DEVICE_1 structure. The <i>dwLevel</i> parameter
///                 indicates the type of structure. Free this memory by calling MprAdminBufferFree.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> The <i>hInterface</i> value is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>lplpbBuffer</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> Insufficient resources to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The <i>dwLevel</i> value is invalid. </td> </tr>
///    </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprAdminInterfaceDeviceGetInfo(ptrdiff_t hMprServer, HANDLE hInterface, uint dwIndex, uint dwLevel, 
                                    ubyte** lplpBuffer);

///The <b>MprAdminInterfaceDeviceSetInfo</b> creates or modifies a device that is used in a router demand-dial
///interface.
///Params:
///    hMprServer = Handle to the router on which to execute this call. Obtain this handle by calling MprAdminServerConnect.
///    hInterface = Handle to the interface. Obtain this handle from a previous call to MprAdminInterfaceCreate, or by calling
///                 MprAdminInterfaceEnum.
///    dwIndex = Specifies the one-based index of the device. A multi-linked demand-dial interface uses multiple devices.
///    dwLevel = A DWORD value that describes the format in which the information is structured in the <i>lplpBuffer</i>
///              parameter. Acceptable values for <i>dwLevel</i> include 0 or 1 as listed in the following table. <table> <tr>
///              <th>Value</th> <th>Structure Format</th> </tr> <tr> <td>0</td> <td> MPR_DEVICE_0 </td> </tr> <tr> <td>1</td> <td>
///              MPR_DEVICE_1 </td> </tr> </table>
///    lpbBuffer = A pointer to a MPR_DEVICE_0 or MPR_DEVICE_1 structure. The <i>dwLevel</i> parameter indicates the type of
///                structure.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> The <i>hInterface</i> value is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>lplpBuffer</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> Insufficient resources to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The <i>dwLevel</i> value is invalid. </td> </tr>
///    </table>
///    
@DllImport("MPRAPI")
uint MprAdminInterfaceDeviceSetInfo(ptrdiff_t hMprServer, HANDLE hInterface, uint dwIndex, uint dwLevel, 
                                    ubyte* lpbBuffer);

///The <b>MprAdminInterfaceTransportRemove</b> function removes a transport (for example, IP or IPX) from a specified
///interface.
///Params:
///    hMprServer = Handle to the router from which the transport is being removed. Obtain this handle by calling
///                 MprAdminServerConnect.
///    hInterface = Handle to the interface from which the transport is being removed. Obtain this handle by calling
///                 MprAdminInterfaceCreate.
///    dwTransportId = A <b>DWORD</b> value that describes the transport type to remove. Acceptable values for <i>dwTransportId</i> are
///                    listed in the following table. <table> <tr> <th>Value</th> <th>Transport (Protocol Family)</th> </tr> <tr>
///                    <td>PID_ATALK</td> <td>AppleTalk</td> </tr> <tr> <td>PID_IP</td> <td>Internet Protocol version 4</td> </tr> <tr>
///                    <td>PID_IPX</td> <td>Internet Packet Exchange</td> </tr> <tr> <td>PID_NBF</td> <td>NetBIOS Frames Protocol</td>
///                    </tr> <tr> <td>PID_IPV6</td> <td>Windows Server 2008 or later: Internet Protocol version 6</td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INTERFACE_CONNECTED</b></dt> </dl> </td> <td
///    width="60%"> The interface specified is a demand-dial interface and is currently connected. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The <i>hInterface</i> value
///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SUCH_INTERFACE</b></dt> </dl> </td> <td
///    width="60%"> The specified transport is not running on the specified interface. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_UNKNOWN_PROTOCOL_ID</b></dt> </dl> </td> <td width="60%"> The <i>dwTransportId</i> value does
///    not match any supported transport. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminInterfaceTransportRemove(ptrdiff_t hMprServer, HANDLE hInterface, uint dwTransportId);

///The <b>MprAdminInterfaceTransportAdd</b> function adds a transport (for example, IP or IPX) to a specified interface.
///Params:
///    hMprServer = Handle to the router on which information is being added. Obtain this handle by calling MprAdminServerConnect.
///    hInterface = Handle to the interface on which the transport is being added. This handle is obtained by a previous call to
///                 MprAdminInterfaceCreate.
///    dwTransportId = A <b>DWORD</b> value that describes the transport type to add to the interface. Acceptable values for
///                    <i>dwTransportId</i> are listed in the following table. <table> <tr> <th>Value</th> <th>Transport (Protocol
///                    Family)</th> </tr> <tr> <td>PID_ATALK</td> <td>AppleTalk</td> </tr> <tr> <td>PID_IP</td> <td>Internet Protocol
///                    version 4</td> </tr> <tr> <td>PID_IPX</td> <td>Internet Packet Exchange</td> </tr> <tr> <td>PID_NBF</td>
///                    <td>NetBIOS Frames Protocol</td> </tr> <tr> <td>PID_IPV6</td> <td>Windows Server 2008 or later: Internet Protocol
///                    version 6</td> </tr> </table>
///    pInterfaceInfo = Pointer to an information header that specifies interface information for this transport. Use the Information
///                     Header Functions to manipulate information headers.
///    dwInterfaceInfoSize = Specifies the size, in bytes, of the information pointed to by <i>pInterfaceInfo</i>.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> The <i>hInterface</i> value is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>pInterfaceInfo</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_UNKNOWN_PROTOCOL_ID</b></dt> </dl> </td> <td
///    width="60%"> The <i>dwTransportId</i> value does not match any supported transport. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminInterfaceTransportAdd(ptrdiff_t hMprServer, HANDLE hInterface, uint dwTransportId, 
                                   ubyte* pInterfaceInfo, uint dwInterfaceInfoSize);

///The <b>MprAdminInterfaceTransportGetInfo</b> function retrieves information about a transport running on a specified
///interface.
///Params:
///    hMprServer = Handle to the router from which information is being retrieved. Obtain this handle by calling
///                 MprAdminServerConnect.
///    hInterface = Handle to the interface. This handle is obtained from a previous call to MprAdminInterfaceCreate.
///    dwTransportId = A <b>DWORD</b> value that describes the transport for which information is requested. Acceptable values for
///                    <i>dwTransportId</i> are listed in the following table. <table> <tr> <th>Value</th> <th>Transport (Protocol
///                    Family)</th> </tr> <tr> <td>PID_ATALK</td> <td>AppleTalk</td> </tr> <tr> <td>PID_IP</td> <td>Internet Protocol
///                    version 4</td> </tr> <tr> <td>PID_IPX</td> <td>Internet Packet Exchange</td> </tr> <tr> <td>PID_NBF</td>
///                    <td>NetBIOS Frames Protocol</td> </tr> <tr> <td>PID_IPV6</td> <td>Windows Server 2008 or later: Internet Protocol
///                    version 6</td> </tr> </table>
///    ppInterfaceInfo = Pointer to a pointer variable. The pointer variable points to an information header that receives information for
///                      the specified interface and transport. Use the Information Header Functions to manipulate information headers.
///                      Free this memory by calling MprAdminBufferFree.
///    lpdwInterfaceInfoSize = Pointer to a <b>DWORD</b> variable. This variable receives the size in bytes of the interface information
///                            returned through the <i>ppInterfaceInfo</i> parameter. This parameter is optional. If the calling application
///                            specifies <b>NULL</b> for this parameter, the function does not return the size of the interface information.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> The <i>hInterface</i> value is invalid, or if the interface specified is administratively disabled.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SUCH_INTERFACE</b></dt> </dl> </td> <td width="60%"> The
///    specified transport is not running on the specified interface. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient resources to complete the
///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_UNKNOWN_PROTOCOL_ID</b></dt> </dl> </td> <td
///    width="60%"> The <i>dwTransportId</i> value does not match any supported transports. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminInterfaceTransportGetInfo(ptrdiff_t hMprServer, HANDLE hInterface, uint dwTransportId, 
                                       ubyte** ppInterfaceInfo, uint* lpdwInterfaceInfoSize);

///The <b>MprAdminInterfaceTransportSetInfo</b> function sets information for a transport running on a specified
///interface.
///Params:
///    hMprServer = Handle to the router on which the transport is being set. Obtain the handle by calling MprAdminServerConnect.
///    hInterface = Handle to the interface on which the transport is being set. Obtain this handle by calling
///                 MprAdminInterfaceCreate.
///    dwTransportId = A <b>DWORD</b> value that describes the transport type to set. Acceptable values for <i>dwTransportId</i> are
///                    listed in the following table. <table> <tr> <th>Value</th> <th>Transport (Protocol Family)</th> </tr> <tr>
///                    <td>PID_ATALK</td> <td>AppleTalk</td> </tr> <tr> <td>PID_IP</td> <td>Internet Protocol version 4</td> </tr> <tr>
///                    <td>PID_IPX</td> <td>Internet Packet Exchange</td> </tr> <tr> <td>PID_NBF</td> <td>NetBIOS Frames Protocol</td>
///                    </tr> <tr> <td>PID_IPV6</td> <td>Windows Server 2008 or later: Internet Protocol version 6</td> </tr> </table>
///    pInterfaceInfo = Pointer to an information header that contains information for the specified interface and transport. Use the
///                     Information Header Functions to manipulate information headers.
///    dwInterfaceInfoSize = Specifies the size, in bytes, of the information pointed to by <i>pInterfaceInfo</i>.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> The <i>hInterface</i> value is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>pInterfaceInfo</i> parameter is NULL.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SUCH_INTERFACE</b></dt> </dl> </td> <td width="60%"> The
///    specified transport is not running on the specified interface. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_UNKNOWN_PROTOCOL_ID</b></dt> </dl> </td> <td width="60%"> The <i>dwTransportId</i> value does not
///    match any supported transport. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminInterfaceTransportSetInfo(ptrdiff_t hMprServer, HANDLE hInterface, uint dwTransportId, 
                                       ubyte* pInterfaceInfo, uint dwInterfaceInfoSize);

///The <b>MprAdminInterfaceEnum</b> function enumerates all the interfaces on a specified server.
///Params:
///    hMprServer = Handle to the router on which to execute this call. Obtain this handle by calling MprAdminServerConnect.
///    dwLevel = A DWORD value that describes the format in which the information is returned in the <i>lplpbBuffer</i> parameter.
///              Must be zero.
///    lplpbBuffer = On successful completion, a pointer to an array of MPR_INTERFACE_0 structures. Free this memory buffer by calling
///                  MprAdminBufferFree.
///    dwPrefMaxLen = Specifies the preferred maximum length of returned data (in 8-bit bytes). If this parameter is -1, the buffer
///                   returned is large enough to hold all available information.
///    lpdwEntriesRead = Pointer to a <b>DWORD</b> variable. This variable receives the total number of interfaces that were enumerated
///                      from the current position in the enumeration.
///    lpdwTotalEntries = Pointer to a <b>DWORD</b> variable. This variable receives the total number of interfaces that could have been
///                       enumerated from the current resume position.
///    lpdwResumeHandle = Pointer to a <b>DWORD</b> variable. This variable specifies a resume handle that can be used to continue the
///                       enumeration. The handle should be zero on the first call, and left unchanged on subsequent calls. If the return
///                       code is ERROR_MORE_DATA then the call can be re-issued using the handle to retrieve more data. If on return, the
///                       handle is <b>NULL</b>, the enumeration cannot be continued. For other types of error returns, this handle is
///                       invalid. This parameter is optional. If the calling application specifies <b>NULL</b> for this parameter, the
///                       function does not return a resume handle.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%">
///    More information is available; the enumeration can be continued. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient resources to complete the
///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td
///    width="60%"> The value of <i>dwLevel</i> is invalid. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminInterfaceEnum(ptrdiff_t hMprServer, uint dwLevel, ubyte** lplpbBuffer, uint dwPrefMaxLen, 
                           uint* lpdwEntriesRead, uint* lpdwTotalEntries, uint* lpdwResumeHandle);

///Use <b>MprAdminInterfaceSetCredentials</b> function to set the domain, user name, and password that will be used for
///dialing out on the specified demand-dial interface.
///Params:
///    lpwsServer = Pointer to a <b>null</b>-terminated Unicode string that specifies the name of the router on which to execute this
///                 call. This parameter is optional. If the calling application specifies <b>NULL</b> for this parameter, the call
///                 is executed on the local machine.
///    lpwsInterfaceName = Pointer to a <b>null</b>-terminated Unicode string that specifies the name of the demand-dial interface. Use
///                        MprAdminInterfaceGetInfo to obtain the interface name.
///    lpwsUserName = Pointer to a <b>null</b>-terminated Unicode string that specifies the user name. This parameter is optional. If
///                   the calling application specifies <b>NULL</b> for this parameter, the function does not change the user name
///                   associated with this interface.
///    lpwsDomainName = Pointer to a <b>null</b>-terminated Unicode string that specifies the domain name. This parameter is optional. If
///                     the calling application specifies <b>NULL</b> for this parameter, the function does not change the domain name
///                     associated with this interface.
///    lpwsPassword = Pointer to a <b>null</b>-terminated Unicode string that specifies the password. This parameter is optional. If
///                   the calling application specifies <b>NULL</b> for this parameter, the function does not change the password
///                   associated with this interface.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> At least one of the following is true: <ul>
///    <li>The <i>lpwsInterfaceName</i> parameter is <b>NULL</b>, or it is longer than MAX_INTERFACE_NAME_LEN.</li>
///    <li>At least one of the <i>lpwsUserName</i>, <i>lpwsPassword</i>, and <i>lpwsDomainName</i> parameters is too
///    long, and therefore invalid. See the Remarks section for more information.</li> </ul> </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to
///    create a new data structure to contain the credentials. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to retrieve the system error message that
///    corresponds to the error code returned. </td> </tr> </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprAdminInterfaceSetCredentials(PWSTR lpwsServer, PWSTR lpwsInterfaceName, PWSTR lpwsUserName, 
                                     PWSTR lpwsDomainName, PWSTR lpwsPassword);

///Use the <b>MprAdminInterfaceGetCredentials</b> function to retrieve the domain, user name, and password for dialing
///out on the specified demand-dial interface.
///Params:
///    lpwsServer = Pointer to a <b>null</b>-terminated Unicode string that specifies the name of the router on which to execute this
///                 call. This parameter is optional. If the calling application specifies <b>NULL</b> for this parameter, the call
///                 is executed on the local machine.
///    lpwsInterfaceName = Pointer to a <b>null</b>-terminated Unicode string that specifies the name of the demand-dial interface. Use
///                        MprAdminInterfaceGetInfo to obtain the interface name.
///    lpwsUserName = Pointer to a Unicode string that receives the name of the user. This string should be UNLEN+1 long. This
///                   parameter is optional. If the calling application specifies <b>NULL</b> for this parameter, the function does not
///                   return the user name.
///    lpwsPassword = Pointer to a Unicode string that receives the password. This string should be PWLEN+1 long. This parameter is
///                   optional. If the calling application specifies <b>NULL</b> for this parameter, the function does not return the
///                   password.
///    lpwsDomainName = Pointer to a Unicode string that receives the domain name. This string should be DNLEN+1 long. This parameter is
///                     optional. If the calling application specifies <b>NULL</b> for this parameter, the function does not return the
///                     domain name.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANNOT_FIND_PHONEBOOK_ENTRY</b></dt> </dl> </td> <td width="60%"> The specified interface does not
///    have any demand-dial parameters associated with it. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>lpwsInterfaceName</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NO_ERROR</b></dt> </dl> </td> <td width="60%"> The
///    <i>lpwsUserName</i>, <i>lpwsPassword</i>, and <i>lpwsDomainName</i> parameters are all <b>NULL</b>. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to retrieve the
///    system error message that corresponds to the error code returned. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminInterfaceGetCredentials(PWSTR lpwsServer, PWSTR lpwsInterfaceName, PWSTR lpwsUserName, 
                                     PWSTR lpwsPassword, PWSTR lpwsDomainName);

///Use the <b>MprAdminInterfaceSetCredentialsEx</b> function to set extended credentials information for an interface.
///Use this function to set credentials information used for Extensible Authentication Protocols (EAPs).
///Params:
///    hMprServer = Handle to a router. This handle is obtained from a previous call to MprAdminServerConnect.
///    hInterface = Handle to the interface. This handle is obtained from a previous call to MprAdminInterfaceCreate.
///    dwLevel = A DWORD value that describes the format in which the information is structured in the <i>lpbBuffer</i> parameter.
///              Acceptable values for <i>dwLevel</i> include 0 or 1 as listed in the following table. A value of 1 indicates the
///              information is a pre-shared key for the interface. <table> <tr> <th>Value</th> <th>Structure Format</th> </tr>
///              <tr> <td>0</td> <td>Windows 2000 Server: MPR_CREDENTIALSEX_0 </td> </tr> <tr> <td>1</td> <td>Windows Server 2003
///              or later: MPR_CREDENTIALSEX_1 </td> </tr> </table>
///    lpbBuffer = A pointer to a MPR_CREDENTIALSEX_0 or MPR_CREDENTIALSEX_1 structure. The <i>dwLevel</i> parameter indicates the
///                type of structure.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> The <i>hInterface</i> value is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>lplpbBuffer</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> Insufficient resources to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The <i>dwLevel</i> value is invalid. </td> </tr>
///    </table>
///    
@DllImport("MPRAPI")
uint MprAdminInterfaceSetCredentialsEx(ptrdiff_t hMprServer, HANDLE hInterface, uint dwLevel, ubyte* lpbBuffer);

///Use the <b>MprAdminInterfaceGetCredentialsEx</b> function to retrieve extended credentials information for the
///specified interface. Use this function to retrieve credentials information used for Extensible Authentication
///Protocols (EAPs).
///Params:
///    hMprServer = Handle to a router. This handle is obtained from a previous call to MprAdminServerConnect.
///    hInterface = Handle to the interface. This handle is obtained from a previous call to MprAdminInterfaceCreate.
///    dwLevel = A DWORD value that describes the format in which the information is returned in the <i>lplpbBuffer</i> parameter.
///              Acceptable values for <i>dwLevel</i> include 0 or 1, as listed in the following table. <table> <tr>
///              <th>Value</th> <th>Structure Format</th> </tr> <tr> <td>0</td> <td>Windows 2000 Server: MPR_CREDENTIALSEX_0 </td>
///              </tr> <tr> <td>1</td> <td>Windows Server 2003 or later: MPR_CREDENTIALSEX_1 </td> </tr> </table> A value of 1
///              indicates the information is a pre-shared key for the interface, which is in an encrypted format.
///    lplpbBuffer = On successful completion, a pointer to a MPR_CREDENTIALSEX_0 or MPR_CREDENTIALSEX_1 structure. The <i>dwLevel</i>
///                  parameter indicates the type of structure. Free the memory occupied by this structure with MprAdminBufferFree.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> The <i>hInterface</i> value is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>lplpbBuffer</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> Insufficient resources to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The <i>dwLevel</i> value is invalid. </td> </tr>
///    </table>
///    
@DllImport("MPRAPI")
uint MprAdminInterfaceGetCredentialsEx(ptrdiff_t hMprServer, HANDLE hInterface, uint dwLevel, ubyte** lplpbBuffer);

///The <b>MprAdminInterfaceConnect</b> function creates a connection to the specified WAN interface.
///Params:
///    hMprServer = Handle to the router on which to execute this call. Obtain this handle by calling MprAdminServerConnect.
///    hInterface = Handle to the interface. This handle is obtained from a previous call to MprAdminInterfaceCreate.
///    hEvent = Handle to an event that is signaled after the attempt to connect the interface has completed. The function
///             initiates the connection attempt and returns immediately. After the event is signaled, you can obtain the result
///             of the connection attempt by calling MprAdminInterfaceGetInfo. If this parameter is <b>NULL</b>, and
///             <i>fBlocking</i> is <b>TRUE</b>, then this call is synchronous, that is, the function does not return until the
///             connection attempt has completed. The calling application must specify <b>NULL</b> for this parameter, if
///             <i>hMprServer</i> specifies a remote router.
///    fSynchronous = If <i>hEvent</i> is <b>NULL</b> and this parameter is set to <b>TRUE</b>, the function does not return until the
///                   connection attempt has completed. If <i>hEvent</i> is <b>NULL</b>, and this parameter is set to <b>FALSE</b>, the
///                   function will return immediately. A return value of PENDING indicates that the connection attempt was initiated
///                   successfully. If <i>hEvent</i> is not <b>NULL</b>, this parameter is ignored.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ALREADY_CONNECTING</b></dt> </dl> </td> <td
///    width="60%"> A connection is already in progress on this interface. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DDM_NOT_RUNNING</b></dt> </dl> </td> <td width="60%"> The Demand Dial Manager (DDM) is not running.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INTERFACE_DISABLED</b></dt> </dl> </td> <td width="60%"> The
///    interface is currently disabled. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INTERFACE_HAS_NO_DEVICES</b></dt> </dl> </td> <td width="60%"> No adapters are available for this
///    interface. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> The <i>hInterface</i> value is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SERVICE_IS_PAUSED</b></dt> </dl> </td> <td width="60%"> The Demand Dial service is currently paused.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PENDING</b></dt> </dl> </td> <td width="60%"> The interface is in
///    the process of connecting. The calling application must wait on the <i>hEvent</i> handle, if one was specified.
///    After the event is signaled, you can obtain the state of the connection and any associated error by calling
///    MprAdminInterfaceGetInfo. </td> </tr> </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprAdminInterfaceConnect(ptrdiff_t hMprServer, HANDLE hInterface, HANDLE hEvent, BOOL fSynchronous);

///The <b>MprAdminInterfaceDisconnect</b> function disconnects a connected WAN interface.
///Params:
///    hMprServer = Handle to the router on which to execute this call. Obtain this handle by calling MprAdminServerConnect.
///    hInterface = Handle to the interface. This handle is obtained from a previous call to MprAdminInterfaceCreate.
@DllImport("MPRAPI")
uint MprAdminInterfaceDisconnect(ptrdiff_t hMprServer, HANDLE hInterface);

///The <b>MprAdminInterfaceUpdateRoutes</b> function requests a specified router manager to update its routing
///information for a specified interface.
///Params:
///    hMprServer = Handle to the router on which information is being updated. Obtain this handle by calling MprAdminServerConnect.
///    hInterface = Handle to the interface being updated. Obtain this handle by calling MprAdminInterfaceCreate.
///    dwProtocolId = A <b>DWORD</b> value that specifies which router manager is updating its routing information. The router uses a
///                   different router manager for each transport protocol. Acceptable values for <i>dwTransportId</i> are listed in
///                   the following table. <table> <tr> <th>Value</th> <th>Transport (Protocol Family)</th> </tr> <tr>
///                   <td>PID_ATALK</td> <td>AppleTalk</td> </tr> <tr> <td>PID_IP</td> <td>Internet Protocol version 4</td> </tr> <tr>
///                   <td>PID_IPX</td> <td>Internet Packet Exchange</td> </tr> <tr> <td>PID_NBF</td> <td>NetBIOS Frames Protocol</td>
///                   </tr> <tr> <td>PID_IPV6</td> <td>Windows Server 2008 or later: Internet Protocol version 6</td> </tr> </table>
///    hEvent = Handle to an event that is signaled when the attempt to update routing information for the specified interface
///             has completed. If <b>NULL</b>, then the function is synchronous. The calling application must specify <b>NULL</b>
///             for this parameter, if <i>hMprServer</i> specifies a remote router.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INTERFACE_NOT_CONNECTED</b></dt> </dl> </td> <td
///    width="60%"> The specified interface is not connected. Therefore, routes cannot be updated. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The <i>hInterface</i> value
///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SUCH_INTERFACE</b></dt> </dl> </td> <td
///    width="60%"> The specified transport is not running on the specified interface. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_UNKNOWN_PROTOCOL_ID</b></dt> </dl> </td> <td width="60%"> The <i>dwTransportId</i> value does
///    not match any of the router managers. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_UPDATE_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> A routing information update operation is
///    already in progress on this interface. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PENDING</b></dt> </dl> </td>
///    <td width="60%"> The interface is in the process of updating routing information. The calling application must
///    wait on the event object specified by <i>hEvent</i>. After the event is signaled, the status of the update
///    operation can be obtained by calling MprAdminInterfaceQueryUpdateResult. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminInterfaceUpdateRoutes(ptrdiff_t hMprServer, HANDLE hInterface, uint dwProtocolId, HANDLE hEvent);

///The <b>MprAdminInterfaceQueryUpdateResult</b> function returns the result of the last request to a specified router
///manager to update its routes for an interface. For more information, see MprAdminInterfaceUpdateRoutes.
///Params:
///    hMprServer = Handle to the router from which information is being retrieved. Obtain this handle by calling
///                 MprAdminServerConnect.
///    hInterface = Handle to the interface. This handle is obtained from a previous call to MprAdminInterfaceCreate.
///    dwProtocolId = A <b>DWORD</b> value that specifies which router manager is being queried. The router uses a different router
///                   manager for each transport protocol. Acceptable values for <i>dwTransportId</i> are listed in the following
///                   table. <table> <tr> <th>Value</th> <th>Transport (Protocol Family)</th> </tr> <tr> <td>PID_ATALK</td>
///                   <td>AppleTalk</td> </tr> <tr> <td>PID_IP</td> <td>Internet Protocol version 4</td> </tr> <tr> <td>PID_IPX</td>
///                   <td>Internet Packet Exchange</td> </tr> <tr> <td>PID_NBF</td> <td>NetBIOS Frames Protocol</td> </tr> <tr>
///                   <td>PID_IPV6</td> <td>Windows Server 2008 or later: Internet Protocol version 6</td> </tr> </table>
///    lpdwUpdateResult = Pointer to a <b>DWORD</b> variable. This variable receives the result of the last call to
///                       MprAdminInterfaceUpdateRoutes.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INTERFACE_NOT_CONNECTED</b></dt> </dl> </td> <td
///    width="60%"> The specified interface is not connected; the result of the last update is no longer available.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    <i>hInterface</i> value is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>lpdwUpdateResult</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SUCH_INTERFACE</b></dt> </dl> </td> <td
///    width="60%"> The specified transport is not running on the specified interface. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_UNKNOWN_PROTOCOL_ID</b></dt> </dl> </td> <td width="60%"> The <i>dwProtocolId</i> value does
///    not match any supported router manager. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminInterfaceQueryUpdateResult(ptrdiff_t hMprServer, HANDLE hInterface, uint dwProtocolId, 
                                        uint* lpdwUpdateResult);

///The <b>MprAdminInterfaceUpdatePhonebookInfo</b> function forces the router to pick up changes made on a specified
///demand-dial interface. Call this function after changes are made to a phone-book entry for a demand-dial interface.
///Params:
///    hMprServer = Handle to the router on which to execute this call. Obtain the handle by calling MprAdminServerConnect.
///    hInterface = Handle to a demand-dial interface. Obtain this handle by calling MprAdminInterfaceCreate.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_LOAD_PHONEBOOK</b></dt> </dl> </td> <td
///    width="60%"> The function could not load the phone book into memory. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANNOT_OPEN_PHONEBOOK</b></dt> </dl> </td> <td width="60%"> The function could not find the
///    phone-book file. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DDM_NOT_RUNNING</b></dt> </dl> </td> <td
///    width="60%"> The Demand Dial Manager (DDM) is not running. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INTERFACE_HAS_NO_DEVICES</b></dt> </dl> </td> <td width="60%"> No device is currently associated
///    with this interface. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> The <i>hInterface</i> value is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient resources to complete the
///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use
///    FormatMessage to retrieve the system error message that corresponds to the error code returned. </td> </tr>
///    </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprAdminInterfaceUpdatePhonebookInfo(ptrdiff_t hMprServer, HANDLE hInterface);

///The <b>MprAdminRegisterConnectionNotification</b> function registers an event object with the Demand Dial Manager
///(DDM) so that, if an interface connects or disconnects, the event is signaled.
///Params:
///    hMprServer = Handle to the router on which to execute this call. Obtain this handle by calling MprAdminServerConnect.
///    hEventNotification = Handle to an event object. This event is signaled whenever an interface connects or disconnects.
///Returns:
///    If the function is successful, the return value is NO_ERROR. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DDM_NOT_RUNNING</b></dt> </dl> </td> <td
///    width="60%"> The Demand Dial Manager (DDM) is not running. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>hEventNotification</i> parameter is
///    <b>NULL</b> or is an invalid handle. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td
///    width="60%"> Use FormatMessage to retrieve the system error message that corresponds to the error code returned.
///    </td> </tr> </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprAdminRegisterConnectionNotification(ptrdiff_t hMprServer, HANDLE hEventNotification);

///The <b>MprAdminDeregisterConnectionNotification</b> function deregisters an event object that was previously
///registered using MprAdminRegisterConnectionNotification. Once deregistered, this event is no longer signaled when an
///interface connects or disconnects.
///Params:
///    hMprServer = Handle to the router on which to execute this call. Obtain this handle by calling MprAdminServerConnect.
///    hEventNotification = Handle to an event object to deregister. This event is no longer signaled when an interface connects or
///                         disconnects.
///Returns:
///    If the function is successful, the return value is NO_ERROR. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DDM_NOT_RUNNING</b></dt> </dl> </td> <td
///    width="60%"> The Demand Dial Manager (DDM) is not running. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>hEventNotification</i> parameter is
///    <b>NULL</b> or is an invalid handle. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td
///    width="60%"> Use FormatMessage to retrieve the system error message that corresponds to the error code returned.
///    </td> </tr> </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprAdminDeregisterConnectionNotification(ptrdiff_t hMprServer, HANDLE hEventNotification);

///The <b>MprAdminMIBServerConnect</b> function establishes a connection to the router being administered. This call
///should be made before any other calls to the server. The handle returned by this function is used in subsequent MIB
///calls.
///Params:
///    lpwsServerName = Pointer to a Unicode string that specifies the name of the remote server. If the caller specifies <b>NULL</b> for
///                     this parameter, the function returns a handle to the local server.
///    phMibServer = Pointer to a handle variable. This variable receives a handle to the server.
///Returns:
///    If the function succeeds, the return value is NO_ERROR.
///    
@DllImport("MPRAPI")
uint MprAdminMIBServerConnect(PWSTR lpwsServerName, ptrdiff_t* phMibServer);

///The <b>MprAdminMIBServerDisconnect</b> function disconnects the connection made by a previous call to
///MprAdminMIBServerConnect.
///Params:
///    hMibServer = Handle to the router from which to disconnect. Obtain this handle by calling MprAdminMIBServerConnect.
@DllImport("MPRAPI")
void MprAdminMIBServerDisconnect(ptrdiff_t hMibServer);

///The <b>MprAdminMIBEntryCreate</b> function creates an entry for one of the variables exported by a routing protocol
///or router manager.
///Params:
///    hMibServer = Handle to the router on which to execute this call. Obtain this handle by calling MprAdminMIBServerConnect.
///    dwPid = Receives the router manager that exported the variable.
///    dwRoutingPid = Specifies the routing protocol that exported the variable.
///    lpEntry = Pointer to an opaque data structure. The data structure's format is determined by the router manager or router
///              manager client servicing the call. The data structure should contain information that specifies the variable
///              being created and the value to assign to the variable.
///    dwEntrySize = Specifies the size, in bytes, of the data pointed to by the <i>lpEntry</i> parameter.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have sufficient privileges.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CAN_NOT_COMPLETE</b></dt> </dl> </td> <td width="60%"> The
///    <i>dwRoutingPid</i> variable does not match any installed routing protocol. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient resources to complete the
///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_UNKNOWN_PROTOCOL_ID</b></dt> </dl> </td> <td
///    width="60%"> The <i>dwTransportId</i> value does not match any installed router manager. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminMIBEntryCreate(ptrdiff_t hMibServer, uint dwPid, uint dwRoutingPid, void* lpEntry, uint dwEntrySize);

///The <b>MprAdminMIBEntryDelete</b> function deletes an entry for one of the variables exported by a routing protocol
///or router manager.
///Params:
///    hMibServer = Handle to the router on which to execute this call. Obtain this handle by calling MprAdminMIBServerConnect.
///    dwProtocolId = Specifies the router manager that exported the variable.
///    dwRoutingPid = Specifies the routing protocol that exported the variable.
///    lpEntry = Pointer to an opaque data structure. The data structure's format is determined by the module servicing the call.
///              The data structure should contain information that specifies the variable to be deleted.
///    dwEntrySize = Specifies the size, in bytes, of the data pointed to by <i>lpEntry</i> parameter.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have sufficient privileges.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_COMPLETE</b></dt> </dl> </td> <td width="60%"> The
///    <i>dwRoutingPid</i> variable does not match any installed routing protocol. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_UNKNOWN_PROTOCOL_ID</b></dt> </dl> </td> <td width="60%"> The <i>dwTransportId</i> value does
///    not match any installed router manager. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminMIBEntryDelete(ptrdiff_t hMibServer, uint dwProtocolId, uint dwRoutingPid, void* lpEntry, 
                            uint dwEntrySize);

///The <b>MprAdminMIBEntrySet</b> function sets the value of one of the variables exported by a routing protocol or
///router manager.
///Params:
///    hMibServer = Handle to the router on which to execute this call. Obtain this handle by calling MprAdminMIBServerConnect.
///    dwProtocolId = Specifies the router manager that exported the variable.
///    dwRoutingPid = Specifies the routing protocol that exported the variable.
///    lpEntry = Pointer to an opaque data structure. The data structure's format is determined by the module that services the
///              call. The data structure should contain information that specifies the variable being set and the value to be
///              assigned to the variable.
///    dwEntrySize = Specifies the size, in bytes, of the data pointed to by the <i>lpEntry</i> parameter.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have sufficient privileges.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_COMPLETE</b></dt> </dl> </td> <td width="60%"> The
///    <i>dwRoutingPid</i> variable does not match any installed routing protocol. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_UNKNOWN_PROTOCOL_ID</b></dt> </dl> </td> <td width="60%"> The <i>dwTransportId</i> value does
///    not match any installed router manager. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminMIBEntrySet(ptrdiff_t hMibServer, uint dwProtocolId, uint dwRoutingPid, void* lpEntry, 
                         uint dwEntrySize);

///The <b>MprAdminMIBEntryGet</b> function retrieves the value of one of the variables exported by a routing protocol or
///router manager.
///Params:
///    hMibServer = Handle to the router on which to execute this call. Obtain this handle by calling MprAdminMIBServerConnect.
///    dwProtocolId = Specifies the router manager that exported the variable.
///    dwRoutingPid = Specifies the routing protocol that exported the variable.
///    lpInEntry = Pointer to an opaque data structure. The data structure's format is determined by the module servicing the call.
///                The data structure should contain information that specifies the variable being queried.
///    dwInEntrySize = Specifies the size, in bytes, of the data structure pointed to by <i>lpInEntry</i>.
///    lplpOutEntry = Pointer to a pointer variable. On successful return, this pointer variable points to an opaque data structure.
///                   The data structure's format is determined by the module servicing the call. The data structure receives the value
///                   of the variable that was queried. Free this memory by calling MprAdminMIBBufferFree.
///    lpOutEntrySize = Pointer to a <b>DWORD</b> variable that, on successful return, receives the size in bytes of the data structure
///                     returned through the <i>lplpOutEntry</i> parameter.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have sufficient privileges.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_COMPLETE</b></dt> </dl> </td> <td width="60%"> The
///    <i>dwRoutingPid</i> variable does not match any installed routing protocol. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_UNKNOWN_PROTOCOL_ID</b></dt> </dl> </td> <td width="60%"> The <i>dwTransportId</i> value does
///    not match any installed router manager. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient resources to complete the
///    operation. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminMIBEntryGet(ptrdiff_t hMibServer, uint dwProtocolId, uint dwRoutingPid, void* lpInEntry, 
                         uint dwInEntrySize, void** lplpOutEntry, uint* lpOutEntrySize);

///The <b>MprAdminMIBEntryGetFirst</b> function retrieves the first variable of some set of variables exported by a
///protocol or router manager. The module that services the call defines <i>first</i>.
///Params:
///    hMibServer = Handle to the router on which to execute this call. Obtain this handle by calling MprAdminMIBServerConnect.
///    dwProtocolId = Specifies the router manager that exported the variable.
///    dwRoutingPid = Specifies the routing protocol that exported the variable.
///    lpInEntry = Pointer to an opaque data structure. The data structure's format is determined by the module servicing the call.
///                The data structure should contain information that specifies the variable being queried.
///    dwInEntrySize = Specifies the size, in bytes, of the data pointed to by <i>lpInEntry</i>.
///    lplpOutEntry = Pointer to a pointer variable. On successful return, this pointer variable points to an opaque data structure.
///                   The data structure's format is determined by the module servicing the call. The data structure receives the value
///                   of the first variable from the set of variables exported. Free this memory by calling MprAdminMIBBufferFree.
///    lpOutEntrySize = Pointer to a <b>DWORD</b> variable. On successful return, this variable receives the size, in bytes, of the data
///                     structure that was returned through the <i>lplpOutEntry</i> parameter.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have sufficient privileges.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_COMPLETE</b></dt> </dl> </td> <td width="60%"> The
///    <i>dwRoutingPid</i> variable does not match any installed routing protocol. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_UNKNOWN_PROTOCOL_ID</b></dt> </dl> </td> <td width="60%"> The <i>dwTransportId</i> value does
///    not match any installed transport/router manager. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient resources to complete the
///    operation. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminMIBEntryGetFirst(ptrdiff_t hMibServer, uint dwProtocolId, uint dwRoutingPid, void* lpInEntry, 
                              uint dwInEntrySize, void** lplpOutEntry, uint* lpOutEntrySize);

///The <b>MprAdminMIBEntryGetNext</b> function retrieves the next variable of some set of variables exported by a
///protocol or router manager. The module that services the call defines <i>next</i>.
///Params:
///    hMibServer = Handle to the router on which to execute this call. This handle is obtained from a previous call to
///                 MprAdminMIBServerConnect.
///    dwProtocolId = Specifies the router manager that exported the variable.
///    dwRoutingPid = Specifies the routing protocol that exported the variable.
///    lpInEntry = Pointer to an opaque data structure. The data structure's format is determined by the module that services the
///                call. The data structure should contain information that specifies the variable being queried.
///    dwInEntrySize = Specifies the size, in bytes, of the data structure pointed to by <i>lpInEntry</i>.
///    lplpOutEntry = Pointer to a pointer variable. On successful return, this pointer variable points to an opaque data structure.
///                   The data structure's format is determined by the module that services the call. The data structure receives the
///                   value of the next variable from the set of variables exported. Free this memory by calling MprAdminMIBBufferFree.
///    lpOutEntrySize = Pointer to a <b>DWORD</b> variable. This variable receives the size in bytes of the data structure returned
///                     through the <i>lplpOutEntry</i> parameter.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have sufficient privileges.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_COMPLETE</b></dt> </dl> </td> <td width="60%"> The
///    <i>dwRoutingPid</i> variable does not match any installed routing protocol. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_UNKNOWN_PROTOCOL_ID</b></dt> </dl> </td> <td width="60%"> The <i>dwTransportId</i> value does
///    not match any installed router manager. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient resources to complete the
///    operation. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprAdminMIBEntryGetNext(ptrdiff_t hMibServer, uint dwProtocolId, uint dwRoutingPid, void* lpInEntry, 
                             uint dwInEntrySize, void** lplpOutEntry, uint* lpOutEntrySize);

///The <b>MprAdminMIBBufferFree</b> function frees buffers returned by the following functions: <ul> <li>
///MprAdminMIBEntryGet </li> <li> MprAdminMIBEntryGetFirst </li> <li> MprAdminMIBEntryGetNext </li> </ul>
///Params:
///    pBuffer = Pointer to a memory buffer to free.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>pBuffer</i> parameter is <b>NULL</b>.
///    </td> </tr> </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprAdminMIBBufferFree(void* pBuffer);

///The <b>MprConfigServerInstall</b> function configures Routing and Remote Access Service with a default configuration.
///Params:
///    dwLevel = This parameter is reserved for future use, and should be zero.
///    pBuffer = This parameter is reserved for future use, and should be <b>NULL</b>.
///Returns:
///    If the functions succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the following is true: <ul>
///    <li><i>dwLevel</i> is not zero.</li> <li><i>pBuffer</i> is non-<b>NULL</b>.</li> </ul> </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprConfigServerInstall(uint dwLevel, void* pBuffer);

///The <b>MprConfigServerConnect</b> function connects to the router to be configured. Call this function before making
///any other calls to the server. The handle returned by this function is used in subsequent calls to configure
///interfaces and transports on the server.
///Params:
///    lpwsServerName = Pointer to a Unicode string that specifies the name of the remote server to configure. If this parameter is
///                     <b>NULL</b>, the function returns a handle to the router configuration on the local machine.
///    phMprConfig = Pointer to a handle variable. This variable receives a handle to the router configuration.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>phMprConfig</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> Insufficient resources to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to retrieve the system error message that
///    corresponds to the error code returned. </td> </tr> </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprConfigServerConnect(PWSTR lpwsServerName, HANDLE* phMprConfig);

///The <b>MprConfigServerDisconnect</b> function disconnects a connection made by a previous call to
///MprConfigServerConnect.
///Params:
///    hMprConfig = Handle to a router configuration obtained from a previous call to MprConfigServerConnect.
@DllImport("MPRAPI")
void MprConfigServerDisconnect(HANDLE hMprConfig);

@DllImport("MPRAPI")
uint MprConfigServerRefresh(HANDLE hMprConfig);

///The <b>MprConfigBufferFree</b> function frees buffers allocated by calls to the following functions: MprConfigXEnum
///MprConfigXGetInfo where X stands for Server, Interface, Transport, or InterfaceTransport.
///Params:
///    pBuffer = Pointer to a memory buffer allocated by a previous call to: MprConfigXEnum MprConfigXGetInfo where X stands for
///              Server, Interface, Transport, or InterfaceTransport.
///Returns:
///    If the function succeeds, the return value is NO_ERROR.
///    
@DllImport("MPRAPI")
uint MprConfigBufferFree(void* pBuffer);

///The <b>MprConfigServerGetInfo</b> function retrieves server-level configuration information for the specified router.
///Params:
///    hMprConfig = Handle to the router configuration. Obtain this handle by calling MprConfigServerConnect.
///    dwLevel = A DWORD value that describes the format in which the information is returned in the <i>lplpBuffer</i> parameter.
///              Acceptable values for <i>dwLevel</i> include 0, 1, and 2 as listed in the following table. <table> <tr>
///              <th>Value</th> <th>Structure Format</th> </tr> <tr> <td>0</td> <td>Windows 2000 Server or later: MPR_SERVER_0
///              </td> </tr> <tr> <td>1</td> <td>Windows Server 2003 or later: MPR_SERVER_1 </td> </tr> <tr> <td>2</td>
///              <td>Windows Server 2008 or later: MPR_SERVER_2 </td> </tr> </table>
///    lplpbBuffer = On successful completion, a pointer to a MPR_SERVER_0, MPR_SERVER_1, or MPR_SERVER_2 structure. The
///                  <i>dwLevel</i> parameter indicates the type of structure. Free the memory for this buffer using
///                  MprConfigBufferFree.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> At least one of the following is true: <ul>
///    <li>The <i>hMprConfig</i> parameter is <b>NULL</b>.</li> <li>The <i>dwLevel</i> parameter is not zero.</li>
///    <li>The <i>lplpBuffer</i> parameter is <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient resources to complete the
///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use
///    FormatMessage to retrieve the system error message that corresponds to the error code returned. </td> </tr>
///    </table>
///    
@DllImport("MPRAPI")
uint MprConfigServerGetInfo(HANDLE hMprConfig, uint dwLevel, ubyte** lplpbBuffer);

///The <b>MprConfigServerSetInfo</b> function is used to set the port count for L2TP, PPTP, and SSTP ports and enable or
///disable RRAS on them in the registry when the RRAS service is not running so that it is picked up next time the
///system restarts.
///Params:
///    hMprServer = Handle to the router configuration. Obtain this handle by calling MprConfigServerConnect.
///    dwLevel = A DWORD value that describes the format in which the information is structured in the <i>lpbBuffer</i> parameter.
///              Acceptable values for <i>dwLevel</i> include 1 and 2 as listed in the following table. <table> <tr>
///              <th>Value</th> <th>Structure Format</th> </tr> <tr> <td>1</td> <td>Windows Server 2003 or later: MPR_SERVER_1
///              </td> </tr> <tr> <td>2</td> <td>Windows Server 2008 or later: MPR_SERVER_2 </td> </tr> </table>
///    lpbBuffer = A pointer to a MPR_SERVER_1 or MPR_SERVER_2 structure. The <i>dwLevel</i> parameter indicates the type of
///                structure.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS_REBOOT_REQUIRED</b></dt> </dl> </td> <td
///    width="60%"> A system reboot is required for such a change to take affect. Change the port count using the
///    MprConfigServerSetInfo call and reboot. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> If you try to set the number of ports to
///    more than the system supported limits as defined on the MPR_SERVER_1 and MPR_SERVER_2 topics. Returns this error
///    if you try to set the number of PPTP ports to 0. Returns this error if the flags are not valid or if
///    <i>lpbBuffer</i> or <i>hMprServer</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The value of dwLevel is not valid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> <i>hMprServer</i>
///    handle is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use
///    FormatMessage to retrieve the system error message that corresponds to the error code returned. </td> </tr>
///    </table>
///    
@DllImport("MPRAPI")
uint MprConfigServerSetInfo(ptrdiff_t hMprServer, uint dwLevel, ubyte* lpbBuffer);

///The <b>MprConfigServerBackup</b> function creates a backup of the router-manager, interface, and phone-book
///configuration for the router.
///Params:
///    hMprConfig = Handle to the router configuration. Obtain this handle by calling MprConfigServerConnect.
///    lpwsPath = Pointer to a <b>null</b>-terminated Unicode string that specifies the path to the directory in which to write the
///               backup files. This path should end with a trailing backslash.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>hMprConfig</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> Insufficient resources to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to retrieve the system error message that
///    corresponds to the error code returned. </td> </tr> </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprConfigServerBackup(HANDLE hMprConfig, PWSTR lpwsPath);

///The <b>MprConfigServerRestore</b> function restores the router-manager, interface, and phone-book configuration from
///a backup created by a previous call to MprConfigServerBackup.
///Params:
///    hMprConfig = Handle to the router configuration. Obtain this handle by calling MprConfigServerConnect.
///    lpwsPath = Pointer to a Unicode string that specifies the path to the directory that contains the backup files. This path
///               should end with a trailing backslash.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>hMprConfig</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> Insufficient resources to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to retrieve the system error message that
///    corresponds to the error code returned. </td> </tr> </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprConfigServerRestore(HANDLE hMprConfig, PWSTR lpwsPath);

///The <b>MprConfigTransportCreate</b> function adds the specified transport to the list of transport protocols present
///in the specified router configuration.
///Params:
///    hMprConfig = Handle to the router configuration to which to add the transport. Obtain this handle by calling
///                 MprConfigServerConnect.
///    dwTransportId = A <b>DWORD</b> value that describes the transport to add to the configuration. This parameter also identifies the
///                    router manager for the transport. Acceptable values for <i>dwTransportId</i> are listed in the following table.
///                    <table> <tr> <th>Value</th> <th>Transport (Protocol Family)</th> </tr> <tr> <td>PID_ATALK</td> <td>AppleTalk</td>
///                    </tr> <tr> <td>PID_IP</td> <td>Internet Protocol version 4</td> </tr> <tr> <td>PID_IPX</td> <td>Internet Packet
///                    Exchange</td> </tr> <tr> <td>PID_NBF</td> <td>NetBIOS Frames Protocol</td> </tr> <tr> <td>PID_IPV6</td>
///                    <td>Windows Server 2008 or later: Internet Protocol version 6</td> </tr> </table>
///    lpwsTransportName = Pointer to a <b>null</b>-terminated Unicode string that specifies the name of the transport being added. If this
///                        parameter is not specified, the <i>dwTransportId</i> parameter is converted into a string and used as the
///                        transport name.
///    pGlobalInfo = Pointer to an information header that specifies global information for the transport. The router manager for the
///                  transport interprets this information. Use the Information Header Functions to manipulate information headers.
///    dwGlobalInfoSize = Specifies the size, in bytes, of the data pointed to by the <i>pGlobalInfo</i> parameter.
///    pClientInterfaceInfo = Pointer to an information header that specifies default interface information for client routers. This
///                           information is used to configure dynamic interfaces for client routers for this transport. Use the Information
///                           Header Functions to manipulate information headers. This parameter is optional; the calling application can
///                           specify <b>NULL</b> for this parameter.
///    dwClientInterfaceInfoSize = Specifies the size, in bytes, of the data pointed to by the <i>pClientInterfaceInfo</i> parameter. If the calling
///                                application specifies <b>NULL</b> for <i>pClientInterfaceInfo</i>, the calling application should specify zero
///                                for this parameter.
///    lpwsDLLPath = Pointer to a <b>null</b>-terminated Unicode string that specifies the name of the router manager DLL for the
///                  specified transport. If this name is specified, the function sets the DLL path for this transport to this name.
///                  This parameter is optional; the calling application can specify <b>NULL</b> for this parameter.
///    phRouterTransport = A pointer to a <b>HANDLE</b> variable that receives the transport configuration handle type indicated in the
///                        <i>dwTransportId</i> parameter.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>hMprConfig</i> parameter is
///    <b>NULL</b>, or the <i>phRouterTransport</i> parameter is <b>NULL</b>, or both are <b>NULL</b>. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient resources
///    to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td
///    width="60%"> Use FormatMessage to retrieve the system error message that corresponds to the error code returned.
///    </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprConfigTransportCreate(HANDLE hMprConfig, uint dwTransportId, PWSTR lpwsTransportName, ubyte* pGlobalInfo, 
                              uint dwGlobalInfoSize, ubyte* pClientInterfaceInfo, uint dwClientInterfaceInfoSize, 
                              PWSTR lpwsDLLPath, HANDLE* phRouterTransport);

///The <b>MprConfigTransportDelete</b> function removes the specified transport from the list of transports present in
///the specified router configuration.
///Params:
///    hMprConfig = Handle to the router configuration from which to remove the transport. Obtain this handle by calling
///                 MprConfigServerConnect.
///    hRouterTransport = Handle to the configuration for the transport being deleted. Obtain this handle by calling
///                       MprConfigTransportCreate or MprConfigTransportGetHandle.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>hMprConfig</i> parameter is
///    <b>NULL</b>, or the <i>hRouterTransport</i> parameter is <b>NULL</b>, or both are <b>NULL</b>. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient resources
///    to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td
///    width="60%"> Use FormatMessage to retrieve the system error message that corresponds to the error code returned.
///    </td> </tr> </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprConfigTransportDelete(HANDLE hMprConfig, HANDLE hRouterTransport);

///The <b>MprConfigTransportGetHandle</b> function retrieves a handle to the specified transport protocol's
///configuration in the specified router configuration.
///Params:
///    hMprConfig = Handle to the router configuration. The handle is obtained from a previous call to MprConfigServerConnect.
///    dwTransportId = A <b>DWORD</b> value that describes the transport configuration handle type in the <i>phRouterTransport</i>
///                    parameter. Acceptable values for <i>dwTransportId</i> are listed in the following table. <table> <tr>
///                    <th>Value</th> <th>Transport (Protocol Family)</th> </tr> <tr> <td>PID_ATALK</td> <td>AppleTalk</td> </tr> <tr>
///                    <td>PID_IP</td> <td>Internet Protocol version 4</td> </tr> <tr> <td>PID_IPX</td> <td>Internet Packet
///                    Exchange</td> </tr> <tr> <td>PID_NBF</td> <td>NetBIOS Frames Protocol</td> </tr> <tr> <td>PID_IPV6</td>
///                    <td>Windows Server 2008 or later: Internet Protocol version 6</td> </tr> </table>
///    phRouterTransport = A pointer to a <b>HANDLE</b> variable that receives the transport configuration handle type indicated in the
///                        <i>dwTransportId</i> parameter.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>hMprConfig</i> parameter and/or the
///    <i>phRouterTransport</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient resources to complete the
///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_UNKNOWN_PROTOCOL_ID</b></dt> </dl> </td> <td
///    width="60%"> The transport protocol specified by <i>dwTransportId</i> was not found in the router configuration.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to
///    retrieve the system error message that corresponds to the error code returned. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprConfigTransportGetHandle(HANDLE hMprConfig, uint dwTransportId, HANDLE* phRouterTransport);

///The <b>MprConfigTransportSetInfo</b> function changes the configuration for the specified transport protocol in the
///specified router configuration.
///Params:
///    hMprConfig = Handle to the router configuration. Obtain this handle by calling MprConfigServerConnect.
///    hRouterTransport = Handle to the transport protocol configuration being updated. Obtain this handle by calling
///                       MprConfigTransportCreate, MprConfigTransportGetHandle, or MprConfigTransportEnum. Supported transport protocol
///                       types are listed on Transport Identifiers.
///    pGlobalInfo = Pointer to an information header that specifies global information for the transport protocol. The router manager
///                  for the transport interprets this information. Use the Information Header Functions to manipulate information
///                  headers. This parameter is optional; the calling application may specify <b>NULL</b> for this parameter.
///    dwGlobalInfoSize = Specifies the size, in bytes, of the data pointed to by <i>pGlobalInfo</i>. If the calling application specifies
///                       <b>NULL</b> for <i>pGlobalInfo</i>, the calling application should specify zero for this parameter.
///    pClientInterfaceInfo = Pointer to an information header that specifies default interface information for client routers. The information
///                           is used to configure dynamic interfaces for client routers for this transport. Use the Information Header
///                           Functions to manipulate information headers. This parameter is optional; the calling application can specify
///                           <b>NULL</b> for this parameter.
///    dwClientInterfaceInfoSize = Specifies the size, in bytes, of the data pointed to by <i>pClientInterfaceInfo</i>. If the calling application
///                                specifies <b>NULL</b> for <i>pClientInterfaceInfo</i>, the calling application should specify zero for this
///                                parameter.
///    lpwsDLLPath = Pointer to a <b>null</b>-terminated Unicode string that specifies the name of the router manager DLL for the
///                  specified transport. This parameter is optional; the calling application may specify <b>NULL</b> for this
///                  parameter.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. For more information, see the Remarks section later in
///    this topic. If the function fails, the return value is one of the following error codes. <table> <tr>
///    <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> The <i>hMprConfig</i> parameter is <b>NULL</b>, the <i>hRouterTransport</i> parameter is
///    <b>NULL</b>, or both are <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_UNKNOWN_PROTOCOL_ID</b></dt> </dl> </td> <td width="60%"> The transport protocol configuration that
///    corresponds to <i>hRouterTransport</i> was not found in the router configuration. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to retrieve the system
///    error message that corresponds to the error code returned. </td> </tr> </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprConfigTransportSetInfo(HANDLE hMprConfig, HANDLE hRouterTransport, ubyte* pGlobalInfo, 
                               uint dwGlobalInfoSize, ubyte* pClientInterfaceInfo, uint dwClientInterfaceInfoSize, 
                               PWSTR lpwsDLLPath);

///The <b>MprConfigTransportGetInfo</b> function retrieves the configuration for the specified transport protocol from
///the router.
///Params:
///    hMprConfig = Handle to the router configuration. Obtain this handle by calling MprConfigServerConnect.
///    hRouterTransport = Handle to the transport protocol configuration being retrieved. Obtain this handle by calling
///                       MprConfigTransportCreate, MprConfigTransportGetHandle, or MprConfigTransportEnum. Supported transport protocol
///                       types are listed on Transport Identifiers.
///    ppGlobalInfo = On input, pointer to a pointer variable. On output, this pointer variable points to an information header that
///                   contains global information for the transport. Use the Information Header Functions to manipulate information
///                   headers. Free this buffer by calling MprConfigBufferFree. This parameter is optional. If the calling application
///                   specifies <b>NULL</b> for this parameter, the function does not retrieve the global information.
///    lpdwGlobalInfoSize = Pointer to a <b>DWORD</b> variable. This variable receives the size, in bytes, of the buffer returned through the
///                         <i>ppGlobalInfo</i> parameter. This parameter is optional; the calling application may specify <b>NULL</b> for
///                         this parameter. However, if <i>ppGlobalInfo</i> is not <b>NULL</b>, this parameter cannot be <b>NULL</b>.
///    ppClientInterfaceInfo = On input, pointer to a pointer variable. On output, this pointer points to an information header that contains
///                            default interface information for client routers for this transport. Use the Information Header Functions to
///                            manipulate information headers. Free the buffer by calling MprConfigBufferFree. This parameter is optional. If
///                            the calling application specifies <b>NULL</b> for this parameter, the function does not retrieve the interface
///                            information.
///    lpdwClientInterfaceInfoSize = Pointer to a <b>DWORD</b> variable. This variable receives the size, in bytes, of the buffer returned through the
///                                  <i>ppClientInterfaceInfo</i> parameter. This parameter is optional; the calling application may specify
///                                  <b>NULL</b> for this parameter. However, if <i>ppClientInterfaceInfo</i> is not <b>NULL</b>, this parameter
///                                  cannot be <b>NULL</b>.
///    lplpwsDLLPath = On input, pointer to a pointer to a <b>null</b>-terminated Unicode string. On output, the Unicode string receives
///                    the name of the router manager DLL for the specified transport. This parameter is optional. If the calling
///                    application specifies <b>NULL</b> for this parameter, the function does not retrieve the name of the router
///                    manager DLL.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> At least one of the following is true: <ul>
///    <li><i>hMprConfig</i> is <b>NULL</b></li> <li><i>hRouterTransport</i> is <b>NULL</b></li> <li><i>ppGlobalInfo</i>
///    is not <b>NULL</b>, but <i>lpdwGlobalInfoSize</i> is <b>NULL</b>.</li> <li><i>ppClientInterfaceInfo</i> is not
///    <b>NULL</b>, but <i>lpdwClientInterfaceInfo</i> is <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_UNKNOWN_PROTOCOL_ID</b></dt> </dl> </td> <td width="60%"> The transport protocol configuration that
///    corresponds to <i>hRouterTransport</i> was not found in the router configuration. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient resources to
///    complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%">
///    Use FormatMessage to retrieve the system error message that corresponds to the error code returned. </td> </tr>
///    </table>
///    
@DllImport("MPRAPI")
uint MprConfigTransportGetInfo(HANDLE hMprConfig, HANDLE hRouterTransport, ubyte** ppGlobalInfo, 
                               uint* lpdwGlobalInfoSize, ubyte** ppClientInterfaceInfo, 
                               uint* lpdwClientInterfaceInfoSize, PWSTR* lplpwsDLLPath);

///The <b>MprConfigTransportEnum</b> function enumerates the transports configured on the router.
///Params:
///    hMprConfig = Handle to the router configuration for the transports. Obtain this handle by calling MprConfigServerConnect.
///    dwLevel = A <b>DWORD</b> value that describes the format in which the information is returned in the <i>lplpBuffer</i>
///              parameter. Must be zero.
///    lplpBuffer = On input, a non-<b>NULL</b> pointer. On successful completion, a pointer to an array of MPR_TRANSPORT_0
///                 structures. Free this memory buffer by calling MprConfigBufferFree.
///    dwPrefMaxLen = Specifies the preferred maximum length of returned data in 8-bit bytes. If this parameter is -1, the buffer
///                   returned will be large enough to hold all available information.
///    lpdwEntriesRead = Pointer to a <b>DWORD</b> variable. This variable receives the total number of entries that were enumerated from
///                      the current resume position.
///    lpdwTotalEntries = Pointer to a <b>DWORD</b> variable. This variable receives the total number of entries that could have been
///                       enumerated from the current resume position.
///    lpdwResumeHandle = Pointer to a <b>DWORD</b> variable. On input, the handle should be zero on the first call and left unchanged on
///                       subsequent calls. On output, this variable contains a resume handle used to continue the enumeration. If the
///                       handle is <b>NULL</b>, the enumeration is complete. If an error occurs in the enumeration, this handle is
///                       invalid. This parameter is optional. If the calling application specifies <b>NULL</b> for this parameter, the
///                       function does not return a resume handle.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> At least one of the following is true: <ul>
///    <li><i>hMprConfig</i> is <b>NULL</b>.</li> <li><i>dwLevel</i> is not zero.</li> <li><i>lplpBuffer</i> is
///    <b>NULL</b>.</li> <li><i>dwPrefMaxLen</i> is smaller than the size of a single MPR_TRANSPORT_0 structure.</li>
///    <li><i>lpdwEntriesRead</i> is <b>NULL</b>.</li> <li><i>lpdwTotalEntries</i> is <b>NULL</b>.</li> </ul> </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%">
///    Insufficient resources to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> No more entries available from the current
///    resume position. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use
///    FormatMessage to retrieve the system error message that corresponds to the error code returned. </td> </tr>
///    </table>
///    
@DllImport("MPRAPI")
uint MprConfigTransportEnum(HANDLE hMprConfig, uint dwLevel, ubyte** lplpBuffer, uint dwPrefMaxLen, 
                            uint* lpdwEntriesRead, uint* lpdwTotalEntries, uint* lpdwResumeHandle);

///The <b>MprConfigInterfaceCreate</b> function creates a router interface in the specified router configuration.
///Params:
///    hMprConfig = Handle to the router configuration. Obtain this handle by calling MprConfigServerConnect.
///    dwLevel = A DWORD value that describes the format in which the information is structured in the <i>lpbBuffer</i> parameter.
///              Acceptable values for <i>dwLevel</i> include 0, 1, 2, and 3, as listed in the following table. <table> <tr>
///              <th>Value</th> <th>Structure Format</th> </tr> <tr> <td>0</td> <td> MPR_INTERFACE_0 </td> </tr> <tr> <td>1</td>
///              <td> MPR_INTERFACE_1 </td> </tr> <tr> <td>2</td> <td> MPR_INTERFACE_2 </td> </tr> <tr> <td>3</td> <td>Windows
///              Server 2008 or later: MPR_INTERFACE_3 </td> </tr> </table>
///    lpbBuffer = A pointer to a MPR_INTERFACE_0, MPR_INTERFACE_1, MPR_INTERFACE_2, or MPR_INTERFACE_3 structure. The
///                <i>dwLevel</i> parameter indicates the type of structure.
///    phRouterInterface = Pointer to a handle variable. This variable receives a handle to the interface configuration.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> At least one of the following is true: <ul>
///    <li><i>hMprConfig</i> is <b>NULL</b></li> <li><i>dwLevel</i> is not 0, 1, 2, or 3.</li> <li><i>lpbBuffer</i> is
///    <b>NULL</b></li> <li><i>phRouterInterface</i> is <b>NULL</b></li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient resources to complete the
///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use
///    FormatMessage to retrieve the system error message that corresponds to the error code returned. </td> </tr>
///    </table>
///    
@DllImport("MPRAPI")
uint MprConfigInterfaceCreate(HANDLE hMprConfig, uint dwLevel, ubyte* lpbBuffer, HANDLE* phRouterInterface);

///The <b>MprConfigInterfaceDelete</b> function removes a router interface from the router configuration. All transport
///information associated with this interface is also removed.
///Params:
///    hMprConfig = Handle to the router configuration. Obtain this handle by calling MprConfigServerConnect.
///    hRouterInterface = Handle to the interface configuration. Obtain this handle by calling MprConfigInterfaceCreate,
///                       MprConfigInterfaceGetHandle, or MprConfigInterfaceEnum.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>hMprConfig</i> parameter is
///    <b>NULL</b>, or the <i>hRouterInterface</i> parameter is <b>NULL</b>, or both parameters are <b>NULL</b>. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%">
///    Insufficient resources to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt>
///    </dl> </td> <td width="60%"> Use FormatMessage to retrieve the system error message that corresponds to the error
///    code returned. </td> </tr> </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprConfigInterfaceDelete(HANDLE hMprConfig, HANDLE hRouterInterface);

///The <b>MprConfigInterfaceGetHandle</b> function retrieves a handle to the specified interface's configuration in the
///specified router configuration.
///Params:
///    hMprConfig = Handle to the router configuration. Obtain this handle by calling MprConfigServerConnect.
///    lpwsInterfaceName = Pointer to a <b>null</b>-terminated Unicode string that specifies the name of the interface for which the
///                        configuration handle is requested. Use the interface GUID as the name of a LAN interface.
///    phRouterInterface = Pointer to a handle variable. This variable receives a handle to the interface configuration.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>hMprConfig</i> parameter is
///    <b>NULL</b>, or the <i>lpwsInterfaceName</i> parameter is <b>NULL</b>, or both parameters are <b>NULL</b>. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%">
///    Insufficient resources to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_SUCH_INTERFACE</b></dt> </dl> </td> <td width="60%"> The specified interface was not found in the
///    router configuration. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%">
///    Use FormatMessage to retrieve the system error message that corresponds to the error code returned. </td> </tr>
///    </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprConfigInterfaceGetHandle(HANDLE hMprConfig, PWSTR lpwsInterfaceName, HANDLE* phRouterInterface);

///The <b>MprConfigInterfaceGetInfo</b> function retrieves the configuration for the specified interface from the
///router.
///Params:
///    hMprConfig = Handle to the router configuration. Obtain this handle by calling MprConfigServerConnect.
///    hRouterInterface = Handle to the interface configuration for which to retrieve information. Obtain this handle by calling
///                       MprConfigInterfaceCreate, MprConfigInterfaceGetHandle, or MprConfigInterfaceEnum.
///    dwLevel = A DWORD value that describes the format in which the information is returned in the <i>lplpBuffer</i> parameter.
///              Acceptable values for <i>dwLevel</i> include 0, 1, 2 and 3, as listed in the following table. <table> <tr>
///              <th>Value</th> <th>Structure Format</th> </tr> <tr> <td>0</td> <td> MPR_INTERFACE_0 </td> </tr> <tr> <td>1</td>
///              <td> MPR_INTERFACE_1 </td> </tr> <tr> <td>2</td> <td> MPR_INTERFACE_2 </td> </tr> <tr> <td>3</td> <td>Windows
///              Server 2008 or later: MPR_INTERFACE_3 </td> </tr> </table>
///    lplpBuffer = On input, a non-<b>NULL</b> pointer. On successful completion, a pointer to an array of MPR_INTERFACE_0,
///                 MPR_INTERFACE_1, MPR_INTERFACE_2, or MPR_INTERFACE_3 structure. The <i>dwLevel</i> parameter indicates the type
///                 of structure. Free this buffer by calling MprConfigBufferFree.
///    lpdwBufferSize = Pointer to a <b>DWORD</b> variable. This variable receives the size, in bytes, of the data returned through
///                     <i>lplpBuffer</i>.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> At least one of the following is true: <ul>
///    <li><i>hMprConfig</i> is <b>NULL</b></li> <li><i>hRouterInterface</i> is <b>NULL</b></li> <li><i>dwLevel</i> is
///    not 0, 1, 2, or 3.</li> <li><i>lplpBuffer</i> is <b>NULL</b></li> <li><i>lpdwBufferSize</i> is <b>NULL</b></li>
///    </ul> </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%">
///    Insufficient resources to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_SUCH_INTERFACE</b></dt> </dl> </td> <td width="60%"> The interface that corresponds to
///    <i>hRouterInterface</i> is not present in the router configuration. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprConfigInterfaceGetInfo(HANDLE hMprConfig, HANDLE hRouterInterface, uint dwLevel, ubyte** lplpBuffer, 
                               uint* lpdwBufferSize);

///The <b>MprConfigInterfaceSetInfo</b> function sets the configuration for the specified interface.
///Params:
///    hMprConfig = Handle to the router configuration. Obtain this handle by calling MprConfigServerConnect.
///    hRouterInterface = Handle to the interface configuration being updated. Obtain this handle by calling MprConfigInterfaceCreate,
///                       MprConfigInterfaceGetHandle, or MprConfigInterfaceEnum.
///    dwLevel = A DWORD value that describes the format in which the information is structured in the <i>lpBuffer</i> parameter.
///              Acceptable values for <i>dwLevel</i> include 0, 1, 2, and 3, as listed in the following table. <table> <tr>
///              <th>Value</th> <th>Structure Format</th> </tr> <tr> <td>0</td> <td> MPR_INTERFACE_0 </td> </tr> <tr> <td>1</td>
///              <td> MPR_INTERFACE_1 </td> </tr> <tr> <td>2</td> <td> MPR_INTERFACE_2 </td> </tr> <tr> <td>3</td> <td>Windows
///              Server 2008 or later: MPR_INTERFACE_3 </td> </tr> </table>
///    lpbBuffer = A pointer to a MPR_INTERFACE_0, MPR_INTERFACE_1, MPR_INTERFACE_2, or MPR_INTERFACE_3 structure. The
///                <i>dwLevel</i> parameter indicates the type of structure. The information in this structure is used to update the
///                interface configuration.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> At least one of the following is true: <ul>
///    <li><i>hMprConfig</i> is <b>NULL</b>.</li> <li><i>hRouterInterface</i> is <b>NULL</b>.</li> <li><i>dwLevel</i> is
///    not 0, 1, 2, or 3.</li> <li><i>lpBuffer</i> is <b>NULL</b>.</li> </ul> Also returns this error code if the
///    interface is of type ROUTER_IF_TYPE_DEDICATED or <b>ROUTER_IF_TYPE_INTERNAL</b> and the interface is enabled.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SUCH_INTERFACE</b></dt> </dl> </td> <td width="60%"> The
///    interface that corresponds to <i>hRouterInterface</i> is not present in the router configuration. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to retrieve the
///    system error message that corresponds to the error code returned. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprConfigInterfaceSetInfo(HANDLE hMprConfig, HANDLE hRouterInterface, uint dwLevel, ubyte* lpbBuffer);

///The <b>MprConfigInterfaceEnum</b> function enumerates the interfaces that are configured for the router.
///Params:
///    hMprConfig = Handle to the router configuration. Obtain this handle by calling MprConfigServerConnect.
///    dwLevel = A <b>DWORD</b> value that describes the format in which the information is returned in the <i>lplpBuffer</i>
///              parameter. Must be zero.
///    lplpBuffer = On input, a non-<b>NULL</b> pointer. On successful completion, a pointer to an array of MPR_INTERFACE_0
///                 structures. Free this memory buffer by calling MprConfigBufferFree.
///    dwPrefMaxLen = Specifies the preferred maximum length of returned data (in 8-bit bytes). If this parameter is -1, the buffer
///                   returned will be large enough to hold all available information.
///    lpdwEntriesRead = Pointer to a <b>DWORD</b> variable. This variable receives the total number of entries that were enumerated from
///                      the current resume position.
///    lpdwTotalEntries = Pointer to a <b>DWORD</b> variable. This variable receives the total number of entries that could have been
///                       enumerated from the current resume position.
///    lpdwResumeHandle = Pointer to a <b>DWORD</b> variable. On input, the handle should be zero on the first call, and left unchanged on
///                       subsequent calls to continue the enumeration. On output, contains a resume handle that can be used to continue
///                       the enumeration. If the handle is <b>NULL</b>, the enumeration is complete. If an error occurs in the
///                       enumeration, this handle is invalid. This parameter is optional. If the calling application specifies <b>NULL</b>
///                       for this parameter, the function does not return a resume handle.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the following is true: <ul>
///    <li><i>hMprConfig</i> is <b>NULL</b>.</li> <li><i>dwLevel</i> is not zero.</li> <li><i>lplpBuffer</i> is
///    <b>NULL</b>.</li> <li><i>dwPrefMaxLen</i> is smaller than the size of a single MPR_INTERFACE_0 structure.</li>
///    <li><i>lpdwEntriesRead</i> is <b>NULL</b>.</li> <li><i>lpdwTotalEntries</i> is <b>NULL</b>.</li> </ul> </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%">
///    Insufficient resources to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> No more entries available from the current
///    resume position. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use
///    FormatMessage to retrieve the system error message that corresponds to the error code returned. </td> </tr>
///    </table>
///    
@DllImport("MPRAPI")
uint MprConfigInterfaceEnum(HANDLE hMprConfig, uint dwLevel, ubyte** lplpBuffer, uint dwPrefMaxLen, 
                            uint* lpdwEntriesRead, uint* lpdwTotalEntries, uint* lpdwResumeHandle);

///The <b>MprConfigInterfaceTransportAdd</b> function adds a transport protocol to an interface configuration on the
///router.
///Params:
///    hMprConfig = Handle to the router configuration. Obtain this handle by calling MprConfigServerConnect.
///    hRouterInterface = Handle to the interface configuration to which the specified transport is added. Obtain this handle by calling
///                       MprConfigInterfaceCreate, MprConfigInterfaceGetHandle, or MprConfigInterfaceEnum.
///    dwTransportId = A <b>DWORD</b> value that describes the transport to add to the configuration. This parameter also identifies the
///                    router manager for the transport. Acceptable values for <i>dwTransportId</i> are listed in the following table.
///                    <table> <tr> <th>Value</th> <th>Transport (Protocol Family)</th> </tr> <tr> <td>PID_ATALK</td> <td>AppleTalk</td>
///                    </tr> <tr> <td>PID_IP</td> <td>Internet Protocol version 4</td> </tr> <tr> <td>PID_IPX</td> <td>Internet Packet
///                    Exchange</td> </tr> <tr> <td>PID_NBF</td> <td>NetBIOS Frames Protocol</td> </tr> <tr> <td>PID_IPV6</td>
///                    <td>Windows Server 2008 or later: Internet Protocol version 6</td> </tr> </table>
///    lpwsTransportName = Pointer to a <b>null</b>-terminated Unicode string that specifies the name for the transport being added. If this
///                        parameter is not specified and the transport is IP or IPX, <b>MprConfigInterfaceTransportAdd</b> uses IP or IPX.
///                        If this parameter is not specified and the transport is other than IP or IPX,
///                        <b>MprConfigInterfaceTransportAdd</b> converts the <i>dwTransportId</i> parameter into a string and uses that as
///                        the transport name.
///    pInterfaceInfo = Pointer to an information header that contains information for the specified interface and transport. The router
///                     manager for the specified transport interprets this information. Use the Information Header Functions to
///                     manipulate information headers.
///    dwInterfaceInfoSize = Specifies the size, in bytes, of the data pointed to by <i>pInterfaceInfo</i>.
///    phRouterIfTransport = A pointer to a <b>HANDLE</b> variable that receives the transport configuration handle type for this interface
///                          indicated in the <i>dwTransportId</i> parameter.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the following is true: <ul>
///    <li><i>hMprConfig</i> is <b>NULL</b>.</li> <li><i>hRouterInterface</i> is <b>NULL</b>.</li>
///    <li><i>phRouterIfTransport</i> is <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient resources to complete the
///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use
///    FormatMessage to retrieve the system error message that corresponds to the error code returned. </td> </tr>
///    </table>
///    
@DllImport("MPRAPI")
uint MprConfigInterfaceTransportAdd(HANDLE hMprConfig, HANDLE hRouterInterface, uint dwTransportId, 
                                    PWSTR lpwsTransportName, ubyte* pInterfaceInfo, uint dwInterfaceInfoSize, 
                                    HANDLE* phRouterIfTransport);

///The <b>MprConfigInterfaceTransportRemove</b> function removes the specified transport from the specified interface
///configuration on the router.
///Params:
///    hMprConfig = Handle to the router configuration. The handle is obtained from a previous call to MprConfigServerConnect.
///    hRouterInterface = Handle to the interface configuration from which to delete the specified transport. Obtain this handle by calling
///                       MprConfigInterfaceCreate, MprConfigInterfaceGetHandle, or MprConfigInterfaceEnum.
///    hRouterIfTransport = Handle to the interface transport configuration to be deleted. Obtain this handle by calling
///                         MprConfigInterfaceTransportAdd, MprConfigInterfaceTransportGetHandle, or MprConfigInterfaceTransportEnum.
///                         Supported transport protocol types are listed on Transport Identifiers.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the following is true: <ul>
///    <li><i>hMprConfig</i> is <b>NULL</b>.</li> <li><i>hRouterInterface</i> is <b>NULL</b>.</li>
///    <li><i>phRouterIfTransport</i> is <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to retrieve the system error message that
///    corresponds to the error code returned. </td> </tr> </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprConfigInterfaceTransportRemove(HANDLE hMprConfig, HANDLE hRouterInterface, HANDLE hRouterIfTransport);

///The <b>MprConfigInterfaceTransportGetHandle</b> function retrieves a handle to the transport configuration of an
///interface in the specified router configuration.
///Params:
///    hMprConfig = Handle to the router configuration. Obtain this handle by calling MprConfigServerConnect.
///    hRouterInterface = Handle to the interface configuration. Obtain this handle by calling MprConfigInterfaceCreate,
///                       MprConfigInterfaceGetHandle, or MprConfigInterfaceEnum.
///    dwTransportId = A <b>DWORD</b> value that describes the transport configuration handle type in the <i>phRouterIfTransport</i>
///                    parameter. Acceptable values for <i>dwTransportId</i> are listed in the following table. <table> <tr>
///                    <th>Value</th> <th>Transport (Protocol Family)</th> </tr> <tr> <td>PID_ATALK</td> <td>AppleTalk</td> </tr> <tr>
///                    <td>PID_IP</td> <td>Internet Protocol version 4</td> </tr> <tr> <td>PID_IPX</td> <td>Internet Packet
///                    Exchange</td> </tr> <tr> <td>PID_NBF</td> <td>NetBIOS Frames Protocol</td> </tr> <tr> <td>PID_IPV6</td>
///                    <td>Windows Server 2008 or later: Internet Protocol version 6</td> </tr> </table>
///    phRouterIfTransport = A pointer to a <b>HANDLE</b> variable that receives the transport configuration handle type for this interface
///                          indicated in the <i>dwTransportId</i> parameter.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> At least one of the following is true: <ul>
///    <li><i>hMprConfig</i> is <b>NULL</b>.</li> <li><i>hRouterInterface</i> is <b>NULL</b>.</li>
///    <li><i>phRouterIfTransport</i> is <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient resources to complete the
///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SUCH_INTERFACE</b></dt> </dl> </td> <td
///    width="60%"> The interface specified by <i>hRouterInterface</i> was not found in the router configuration, or the
///    transport specified by <i>dwTransportId</i> was not enabled on the specified interface. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to retrieve the system
///    error message that corresponds to the error code returned. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprConfigInterfaceTransportGetHandle(HANDLE hMprConfig, HANDLE hRouterInterface, uint dwTransportId, 
                                          HANDLE* phRouterIfTransport);

///The <b>MprConfigInterfaceTransportGetInfo</b> function retrieves the configuration information for the specified
///client on the specified interface.
///Params:
///    hMprConfig = Handle to the router configuration. Obtain this handle by calling MprConfigServerConnect.
///    hRouterInterface = Handle to the interface configuration from which to retrieve the specified client information. Obtain this handle
///                       by calling MprConfigInterfaceCreate, MprConfigInterfaceGetHandle, or MprConfigInterfaceEnum.
///    hRouterIfTransport = Handle to the transport configuration from which to retrieve the specified client information. Obtain this handle
///                         by calling MprConfigInterfaceTransportAdd, MprConfigInterfaceTransportGetHandle, or
///                         MprConfigInterfaceTransportEnum. Supported transport protocol types are listed on Transport Identifiers.
///    ppInterfaceInfo = On input, pointer to a pointer variable. On output, this pointer variable points to an information header that
///                      contains configuration information for the client. Use the Information Header Functions to manipulate information
///                      headers. Free this memory by calling MprConfigBufferFree. This parameter is optional. If the calling application
///                      specifies <b>NULL</b> for this parameter, the function does not return the configuration information.
///    lpdwInterfaceInfoSize = Pointer to a <b>DWORD</b> variable. This variable receives the size, in bytes, of the data pointed to by
///                            <i>ppInterfaceInfo</i>. This parameter is optional; the calling application may specify <b>NULL</b> for this
///                            parameter. However, if <i>ppInterfaceInfo</i> is not <b>NULL</b>, this parameter cannot be <b>NULL</b>. For more
///                            information, see the Remarks section later in this topic.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. For more information, see the Remarks section later in
///    this topic. If the function fails, the return value is one of the following error codes. <table> <tr>
///    <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> One of the following is true: <ul> <li><i>hMprConfig</i> is <b>NULL</b>.</li>
///    <li><i>hRouterInterface</i> is <b>NULL</b>.</li> <li><i>hRouterIfTransport</i> is <b>NULL</b>.</li>
///    <li><i>ppInterfaceInfo</i> is not <b>NULL</b>, but <i>lpdwInterfaceInfoSize</i> is <b>NULL</b>.</li> </ul> </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SUCH_INTERFACE</b></dt> </dl> </td> <td width="60%"> The
///    interface specified by <i>hRouterIfTransport</i> was not found in the router configuration, or the transport
///    specified by <i>hRouterIfTransport</i> was not enabled on the specified interface. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient resources to
///    complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%">
///    Use FormatMessage to retrieve the system error message that corresponds to the error code returned. </td> </tr>
///    </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprConfigInterfaceTransportGetInfo(HANDLE hMprConfig, HANDLE hRouterInterface, HANDLE hRouterIfTransport, 
                                        ubyte** ppInterfaceInfo, uint* lpdwInterfaceInfoSize);

///The <b>MprConfigInterfaceTransportSetInfo</b> function updates the configuration information for the client on the
///specified interface and transport protocol.
///Params:
///    hMprConfig = Handle to the router configuration. Obtain this handle by calling MprConfigServerConnect.
///    hRouterInterface = Handle to the interface configuration in which to update the information. Obtain this handle by calling
///                       MprConfigInterfaceCreate or MprConfigInterfaceEnum.
///    hRouterIfTransport = Handle to the transport configuration in which to update the information for the client. Obtain this handle by
///                         calling MprConfigInterfaceTransportAdd, MprConfigInterfaceTransportGetHandle, or MprConfigInterfaceTransportEnum.
///                         Supported transport protocol types are listed on Transport Identifiers.
///    pInterfaceInfo = Pointer to an information header that contains configuration information for the client on the specified
///                     interface and transport. The router manager for the specified transport interprets this information. Use the
///                     Information Header Functions to manipulate information headers. This parameter is optional. If the calling
///                     application specifies <b>NULL</b> for this parameter, the function does not update the configuration information
///                     for the client.
///    dwInterfaceInfoSize = Specifies the size, in bytes, of the data pointed to by <i>pInterfaceInfo</i>. This parameter is optional; the
///                          calling application may specify zero for this parameter. However, if <i>pInterfaceInfo</i> is not <b>NULL</b>,
///                          this parameter cannot be zero. For more information, see the Remarks section later in this topic.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. For more information, see the Remarks section later in
///    this topic. If the function fails, the return value is one of the following error codes. <table> <tr>
///    <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> At least one of the following is true: <ul> <li><i>hMprConfig</i> is <b>NULL</b>.</li>
///    <li><i>hRouterInterface</i> is <b>NULL</b>.</li> <li><i>hRouterIfTransport</i> is <b>NULL</b>.</li> </ul> </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SUCH_INTERFACE</b></dt> </dl> </td> <td width="60%"> The
///    interface specified by <i>hRouterInterface</i> is no longer present in the router configuration, or the transport
///    specified by <i>hRouterInterface</i> is no longer present on the interface. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to retrieve the system error message
///    that corresponds to the error code returned. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprConfigInterfaceTransportSetInfo(HANDLE hMprConfig, HANDLE hRouterInterface, HANDLE hRouterIfTransport, 
                                        ubyte* pInterfaceInfo, uint dwInterfaceInfoSize);

///The <b>MprConfigInterfaceTransportEnum</b> function enumerates the transports configured on the specified interface.
///Params:
///    hMprConfig = Handle to the router configuration. Obtain this handle by calling MprConfigServerConnect.
///    hRouterInterface = Handle to the interface configuration from which to enumerate the transports. Obtain this handle by calling
///                       MprConfigInterfaceCreate, or MprConfigInterfaceEnum.
///    dwLevel = A <b>DWORD</b> value that describes the format in which the information is returned in the <i>lplpBuffer</i>
///              parameter. Must be zero.
///    lplpBuffer = On input, a non-<b>NULL</b> pointer. On successful completion, a pointer to an array of MPR_IFTRANSPORT_0
///                 structures. Free this memory buffer by calling MprConfigBufferFree.
///    dwPrefMaxLen = Specifies the preferred maximum length of returned data (in 8-bit bytes). If this parameter is -1, the buffer
///                   returned is large enough to hold all available information.
///    lpdwEntriesRead = Pointer to a <b>DWORD</b> variable. This variable receives the total number of entries that were enumerated from
///                      the current resume position.
///    lpdwTotalEntries = Pointer to a <b>DWORD</b> variable. This variable receives the total number of entries that could have been
///                       enumerated from the current resume position.
///    lpdwResumeHandle = Pointer to a <b>DWORD</b> variable. On input, the handle should be zero on the first call and left unchanged on
///                       subsequent calls. On output, this variable contains a resume handle used to continue the enumeration. If the
///                       handle is <b>NULL</b>, the enumeration is complete. If an error occurs in the enumeration, this handle is
///                       invalid. This parameter is optional. If the calling application specifies <b>NULL</b> for this parameter, the
///                       function does not return a resume handle.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the following is true: <ul>
///    <li><i>hMprConfig</i> is <b>NULL</b>.</li> <li><i>HRouterInterface</i> is <b>NULL</b>.</li> <li><i>dwLevel</i> is
///    not zero.</li> <li><i>lplpBuffer</i> is <b>NULL</b>.</li> <li><i>dwPrefMaxLen</i> is smaller than the size of a
///    single MPR_IFTRANSPORT_0 structure.</li> <li><i>lpdwEntriesRead</i> is <b>NULL</b>.</li>
///    <li><i>lpdwTotalEntries</i> is <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient resources to complete the
///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td
///    width="60%"> No more entries available from the current resume position. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to retrieve the system error message that
///    corresponds to the error code returned. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprConfigInterfaceTransportEnum(HANDLE hMprConfig, HANDLE hRouterInterface, uint dwLevel, ubyte** lplpBuffer, 
                                     uint dwPrefMaxLen, uint* lpdwEntriesRead, uint* lpdwTotalEntries, 
                                     uint* lpdwResumeHandle);

///The <b>MprConfigGetFriendlyName</b> function returns the friendly name for an interface that corresponds to the
///specified GUID name.
///Params:
///    hMprConfig = Handle to the router configuration. Obtain this handle by calling MprConfigServerConnect.
///    pszGuidName = Pointer to a <b>null</b>-terminated Unicode string that specifies the GUID name for the interface.
///    pszBuffer = Pointer to a buffer that receives the friendly name for the interface.
///    dwBufferSize = Specifies the size, in bytes, of the buffer pointed to by <i>pszBuffer</i>.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BUFFER_OVERFLOW</b></dt> </dl> </td> <td width="60%"> The buffer pointed to by <i>pszBuffer</i> is
///    not large enough to hold the returned GUID name. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the following parameters
///    <i>hMprConfig</i>, <i>pszGuidName</i>, or <i>pszBuffer</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No GUID name was found that corresponds to the
///    specified friendly name. </td> </tr> </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprConfigGetFriendlyName(HANDLE hMprConfig, PWSTR pszGuidName, PWSTR pszBuffer, uint dwBufferSize);

///The <b>MprConfigGetGuidName</b> function returns the GUID name for an interface that corresponds to the specified
///friendly name.
///Params:
///    hMprConfig = Handle to the router configuration. Obtain this handle by calling MprConfigServerConnect.
///    pszFriendlyName = Pointer to a Unicode string that specifies the friendly name for the interface.
///    pszBuffer = Pointer to a buffer that receives the GUID name for the interface.
///    dwBufferSize = Specifies the size, in bytes, of the buffer pointed to by <i>pszBuffer</i>.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BUFFER_OVERFLOW</b></dt> </dl> </td> <td width="60%"> The buffer pointed to by <i>pszBuffer</i> is
///    not large enough to hold the returned GUID name. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> At least one of the parameters
///    <i>hMprConfig</i>, <i>pszFriendlyName</i>, or <i>pszBuffer</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No GUID name was found that corresponds to the
///    specified friendly name. </td> </tr> </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprConfigGetGuidName(HANDLE hMprConfig, PWSTR pszFriendlyName, PWSTR pszBuffer, uint dwBufferSize);

///The <b>MprConfigFilterGetInfo</b> function returns static filtering information for a specified transport protocol
///type.
///Params:
///    hMprConfig = Handle to the router configuration. Obtain this handle by calling MprConfigServerConnect.
///    dwLevel = A <b>DWORD</b> value that describes the format in which the information is returned in the <i>lpBuffer</i>
///              parameter. Must be zero.
///    dwTransportId = A <b>DWORD</b> value that describes the transport protocol type of the static filtering information in the
///                    <i>lpBuffer</i> parameter. Acceptable values for <i>dwTransportId</i> are listed in the following table. <table>
///                    <tr> <th>Value</th> <th>Transport (Protocol Family)</th> </tr> <tr> <td>PID_ATALK</td> <td>AppleTalk</td> </tr>
///                    <tr> <td>PID_IP</td> <td>Internet Protocol version 4</td> </tr> <tr> <td>PID_IPX</td> <td>Internet Packet
///                    Exchange</td> </tr> <tr> <td>PID_NBF</td> <td>NetBIOS Frames Protocol</td> </tr> <tr> <td>PID_IPV6</td>
///                    <td>Windows Server 2008 or later: Internet Protocol version 6</td> </tr> </table>
///    lpBuffer = On successful completion, a pointer to a MPR_FILTER_0 structure that contains the filter driver configuration
///               information. Free this memory buffer by calling MprConfigBufferFree.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> <i>hMprConfig</i> or <i>lpBuffer</i> is
///    <b>NULL</b>, or <i>dwLevel</i> is not set to 0. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprConfigFilterGetInfo(HANDLE hMprConfig, uint dwLevel, uint dwTransportId, ubyte* lpBuffer);

///The <b>MprConfigFilterSetInfo</b> function sets the static filtering information for a specified transport protocol
///type.
///Params:
///    hMprConfig = Handle to the router configuration. Obtain this handle by calling MprConfigServerConnect.
///    dwLevel = A <b>DWORD</b> value that describes the format in which the information is structured in the <i>lpBuffer</i>
///              parameter. Must be zero.
///    dwTransportId = A <b>DWORD</b> value that describes the transport protocol type of the static filtering information in the
///                    <i>lpBuffer</i> parameter. Acceptable values for <i>dwTransportId</i> are listed in the following table. <table>
///                    <tr> <th>Value</th> <th>Transport (Protocol Family)</th> </tr> <tr> <td>PID_ATALK</td> <td>AppleTalk</td> </tr>
///                    <tr> <td>PID_IP</td> <td>Internet Protocol version 4</td> </tr> <tr> <td>PID_IPX</td> <td>Internet Packet
///                    Exchange</td> </tr> <tr> <td>PID_NBF</td> <td>NetBIOS Frames Protocol</td> </tr> <tr> <td>PID_IPV6</td>
///                    <td>Windows Server 2008 or later: Internet Protocol version 6</td> </tr> </table>
///    lpBuffer = A pointer to a MPR_FILTER_0 structure that contains the filter driver configuration information.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> <i>hMprConfig</i> or <i>lpBuffer</i> is
///    <b>NULL</b>, or <i>dwLevel</i> is not set to 0. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprConfigFilterSetInfo(HANDLE hMprConfig, uint dwLevel, uint dwTransportId, ubyte* lpBuffer);

///The <b>MprInfoCreate</b> function creates a new information header.
///Params:
///    dwVersion = Specifies the version of the information header structure to be created. The only value currently supported is
///                RTR_INFO_BLOCK_VERSION, as declared in Mprapi.h.
///    lplpNewHeader = Pointer to the allocated and initialized header.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>lplpNewHeader</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> The requested memory allocation could not be completed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> The call failed. Use FormatMessage to retrieve the error
///    message that corresponds to the returned error code. </td> </tr> </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprInfoCreate(uint dwVersion, void** lplpNewHeader);

///The <b>MprInfoDelete</b> function deletes an information header created using MprInfoCreate, or retrieved by
///MprInfoBlockAdd, MprInfoBlockRemove, or MprInfoBlockSet.
///Params:
///    lpHeader = Pointer to the header to be deallocated.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails the return value is one of the
///    following values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>lpHeader</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> The call
///    failed. Use FormatMessage to retrieve the error message that corresponds to the returned error code. </td> </tr>
///    </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprInfoDelete(void* lpHeader);

///The <b>MprInfoRemoveAll</b> function removes all information blocks from the specified header.
///Params:
///    lpHeader = Pointer to the information header from which to remove all information blocks.
///    lplpNewHeader = Pointer to a pointer variable. On successful return, this variable points to the information header with all
///                    information blocks removed.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> Either the <i>lpHeader</i> parameter is
///    <b>NULL</b> or the <i>lplpNewHeader</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to retrieve the error message that
///    corresponds to the returned error code. </td> </tr> </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprInfoRemoveAll(void* lpHeader, void** lplpNewHeader);

///The <b>MprInfoDuplicate</b> function duplicates an existing information header.
///Params:
///    lpHeader = Pointer to the information header to duplicate.
///    lplpNewHeader = Pointer to a pointer variable. On successful return, this variable points to the new (duplicate) information
///                    header.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>lplpNewHeader</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> The requested memory allocation could not be completed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> The call failed. Use FormatMessage to retrieve the error
///    message that corresponds to the returned error code. </td> </tr> </table> <div> </div>
///    
@DllImport("MPRAPI")
uint MprInfoDuplicate(void* lpHeader, void** lplpNewHeader);

///The <b>MprInfoBlockAdd</b> function creates a new header that is identical to an existing header with the addition of
///a new block.
///Params:
///    lpHeader = Pointer to the header in which to add the new block.
///    dwInfoType = Specifies the type of block to add. The types available depend on the transport: IPv4, IPv6, or IPX. <b>Windows
///                 Server 2008: </b>If <i>dwInfoTYpe</i> contains IP_ROUTE_INFO, <i>lpItemData</i> must point to a
///                 INTERFACE_ROUTE_INFO structure.
///    dwItemSize = Specifies the size of each item in the block to be added.
///    dwItemCount = Specifies the number of items of size <i>dwItemSize</i> to be copied as data for the new block.
///    lpItemData = Pointer to the data for the new block. The size in bytes of this buffer should be equal to the product of
///                 <i>dwItemSize</i> and <i>dwItemCount</i>.
///    lplpNewHeader = Pointer to a pointer variable that, on successful return, points to the new header.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>lpHeader</i>, <i>lplpNewHeader</i>,
///    or <i>lpItemData</i> parameter is <b>NULL</b>, or a block of type <i>dwInfoType</i> already exists in the header.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> The call failed. Use
///    FormatMessage to retrieve the error message that corresponds to the returned error code. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprInfoBlockAdd(void* lpHeader, uint dwInfoType, uint dwItemSize, uint dwItemCount, ubyte* lpItemData, 
                     void** lplpNewHeader);

///The <b>MprInfoBlockRemove</b> function creates a new header that is identical to an existing header with a specified
///block removed.
///Params:
///    lpHeader = Pointer to the header from which the block should be removed.
///    dwInfoType = Specifies the type of block to be removed. The types available depend on the transport: IP or IPX.
///    lplpNewHeader = Pointer to a pointer variable that receives the new header.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>lpHeader</i> parameter is
///    <b>NULL</b>, or no block of type <i>dwInfoType</i> exists in the header. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> The memory allocation required for
///    successful execution of MprInfoBlockRemove could not be completed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> The call failed. Use FormatMessage to retrieve the error
///    message that corresponds to the returned error code. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprInfoBlockRemove(void* lpHeader, uint dwInfoType, void** lplpNewHeader);

///The <b>MprInfoBlockSet</b> creates a new header that is identical to an existing header with a specified block
///modified.
///Params:
///    lpHeader = Pointer to the header in which to modify the specified block.
///    dwInfoType = Specifies the type of block to change. The types available depend on the transport: IP or IPX.
///    dwItemSize = Specifies the size of each item in the block's new data.
///    dwItemCount = Specifies the number of items of size <i>dwItemSize</i> to be copied as the new data for the block.
///    lpItemData = Pointer to the new data for the block. This should point to a buffer with a size (in bytes) equal to the product
///                 of <i>dwItemSize</i> and <i>dwItemCount</i>.
///    lplpNewHeader = Pointer to a pointer variable that, on successful return, points to the new header.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One (or more) required parameters is
///    <b>NULL</b>, or no block of type <i>dwInfoType</i> exists in the header. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> The call failed. Use FormatMessage to retrieve the error
///    message that corresponds to the returned error code. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprInfoBlockSet(void* lpHeader, uint dwInfoType, uint dwItemSize, uint dwItemCount, ubyte* lpItemData, 
                     void** lplpNewHeader);

///The <b>MprInfoBlockFind</b> function locates a specified block in an information header, and retrieves information
///about the block.
///Params:
///    lpHeader = Specifies the header in which to locate the block.
///    dwInfoType = Specifies the type of block to locate. The types available depend on the transport: IP or IPX.
///    lpdwItemSize = Pointer to a <b>DWORD</b> variable that receives the size of each item in the located block's data. This
///                   parameter is optional. If this parameter is <b>NULL</b>, the item size is not returned.
///    lpdwItemCount = Pointer to a <b>DWORD</b> variable that receives the number of items of size <i>dwItemSize</i> contained in the
///                    block's data. This parameter is optional. If this parameter is <b>NULL</b>, the item count is not returned.
///    lplpItemData = Pointer to a pointer that, on successful return, points to the data for the located block. This parameter is
///                   optional. If this parameter is <b>NULL</b>, the data is not returned.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>lpInfoHeader</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%">
///    No block of type <i>dwInfoType</i> exists in the header. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> The call failed. Use FormatMessage to retrieve the error
///    message that corresponds to the returned error code. </td> </tr> </table>
///    
@DllImport("MPRAPI")
uint MprInfoBlockFind(void* lpHeader, uint dwInfoType, uint* lpdwItemSize, uint* lpdwItemCount, 
                      ubyte** lplpItemData);

///The <b>MprInfoBlockQuerySize</b> function returns the returns the size of the information header.
///Params:
///    lpHeader = Pointer to the information header for which to return the size.
///Returns:
///    <b>MprInfoBlockQuerySize</b> returns the size of the information header.
///    
@DllImport("MPRAPI")
uint MprInfoBlockQuerySize(void* lpHeader);

///The <b>MgmRegisterMProtocol</b> function is used by clients to register with the multicast group manager. When the
///registration is complete, the multicast group manager returns a handle to the client. The client must supply this
///handle in subsequent MGM function calls.
///Params:
///    prpiInfo = Pointer to a ROUTING_PROTOCOL_CONFIG structure that contains pointers to callbacks into the client.
///    dwProtocolId = Specifies the ID of the client. The ID is unique for each client.
///    dwComponentId = Specifies the component ID for a specific instance of the client. This parameter is used with <i>dwProtocolId</i>
///                    to uniquely identify an instance of a client.
///    phProtocol = On input, the client must supply a pointer to a handle. On output, <i>phProtocol</i> receives the registration
///                 handle for the client. This handle must be used in subsequent calls to the multicast group manager.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ALREADY_EXISTS</b></dt> </dl> </td> <td width="60%"> Cannot register the specified client because an
///    entry with the same protocol ID and component ID already exists. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CAN_NOT_COMPLETE</b></dt> </dl> </td> <td width="60%"> Could not complete the call to this function.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Not
///    enough memory to complete this operation. </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint MgmRegisterMProtocol(ROUTING_PROTOCOL_CONFIG* prpiInfo, uint dwProtocolId, uint dwComponentId, 
                          HANDLE* phProtocol);

///The <b>MgmDeRegisterMProtocol</b> function deregisters a client handle obtained from a call to MgmRegisterMProtocol.
///Params:
///    hProtocol = Handle to the protocol obtained from a previous call to MgmRegisterMProtocol.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CAN_NOT_COMPLETE</b></dt> </dl> </td> <td width="60%"> Could not complete the call to this function.
///    The client did not first release the interfaces it owns. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> Invalid handle to a client. </td> </tr>
///    </table> <div> </div>
///    
@DllImport("rtm")
uint MgmDeRegisterMProtocol(HANDLE hProtocol);

///The <b>MgmTakeInterfaceOwnership</b> function is called by a client (such as a routing protocol) when it is enabled
///on an interface. Only one client can take ownership of a given interface at any time. The only exception to this rule
///is the IGMP. IGMP can coexist with another client on an interface.
///Params:
///    hProtocol = Handle to the protocol obtained from a previous call to MgmRegisterMProtocol.
///    dwIfIndex = Specifies the index of the interface of which to take ownership.
///    dwIfNextHopAddr = Specifies the address of the next hop that corresponds to the index specified by <i>dwIfIndex</i>. The
///                      <i>dwIfIndex</i> and <i>dwIfNextHopIPAddr</i> parameters uniquely identify a next hop on point-to-multipoint
///                      interfaces. A point-to-multipoint interface is a connection where one interface connects to multiple networks.
///                      Examples of point-to-multipoint interfaces include non-broadcast multiple access (NBMA) interfaces and the
///                      internal interface on which all dial-up clients connect. For broadcast interfaces (such as Ethernet interfaces)
///                      or point-to-point interfaces, which are identified by only the value of <i>dwIfIndex</i>, specify zero.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ALREADY_EXISTS</b></dt> </dl> </td> <td width="60%"> The specified interface is already owned by
///    another routing protocol. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CAN_NOT_COMPLETE</b></dt> </dl>
///    </td> <td width="60%"> Could not complete the call to this function. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> Invalid handle to a client. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory to
///    complete this operation. </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint MgmTakeInterfaceOwnership(HANDLE hProtocol, uint dwIfIndex, uint dwIfNextHopAddr);

///The <b>MgmReleaseInterfaceOwnership</b> function is used by a client to relinquish ownership of an interface. When
///this function is called, all MFEs maintained by the multicast group manager on behalf of the client and for the
///specified interface are deleted.
///Params:
///    hProtocol = Handle to the protocol obtained from a previous call to MgmRegisterMProtocol.
///    dwIfIndex = Specifies the index of the interface to release.
///    dwIfNextHopAddr = Specifies the address of the next hop that corresponds to the index specified by <i>dwIfIndex</i>. The
///                      <i>dwIfIndex</i> and <i>dwIfNextHopIPAddr</i> parameters uniquely identify a next hop on point-to-multipoint
///                      interfaces. A point-to-multipoint interface is a connection where one interface connects to multiple networks.
///                      Examples of point-to-multipoint interfaces include non-broadcast multiple access (NBMA) interfaces and the
///                      internal interface on which all dial-up clients connect. For broadcast interfaces (such as Ethernet interfaces)
///                      or point-to-point interfaces, which are identified by only the value of <i>dwIfIndex</i>, specify zero.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CAN_NOT_COMPLETE</b></dt> </dl> </td> <td width="60%"> Could not complete the call to this function.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%">
///    Invalid handle to a client, or the interface was not found. </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint MgmReleaseInterfaceOwnership(HANDLE hProtocol, uint dwIfIndex, uint dwIfNextHopAddr);

///The <b>MgmGetProtocolOnInterface</b> function retrieves the protocol ID of the multicast routing protocol that owns
///the specified interface.
///Params:
///    dwIfIndex = Specifies the index of the interface for which to retrieve the protocol ID.
///    dwIfNextHopAddr = Specifies the address of the next hop that corresponds to the index specified by <i>dwIfIndex</i>. The
///                      <i>dwIfIndex</i> and <i>dwIfNextHopIPAddr</i> parameters uniquely identify a next hop on point-to-multipoint
///                      interfaces. A point-to-multipoint interface is a connection where one interface connects to multiple networks.
///                      Examples of point-to-multipoint interfaces include non-broadcast multiple access (NBMA) interfaces and the
///                      internal interface on which all dial-up clients connect. For broadcast interfaces (such as Ethernet interfaces)
///                      or point-to-point interfaces, which are identified by only the value of <i>dwIfIndex</i>, specify zero.
///    pdwIfProtocolId = On input, the client must supply a pointer to a <b>DWORD</b>-sized memory location. On output,
///                      <i>pdwIfProtocolId</i> receives the ID of the protocol on the interface specified by <i>dwIfIndex</i>.
///    pdwIfComponentId = On input, the client must supply a pointer to a <b>DWORD</b> value. On output, <i>pdwIfComponentId</i> receives
///                       the component ID for the instance of the protocol on the interface. This parameter is used with
///                       <i>pdwIfProtocolId</i> to uniquely identify an instance of a routing protocol.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CAN_NOT_COMPLETE</b></dt> </dl> </td> <td width="60%"> Could not complete the call to this function.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified
///    interface was not found by the multicast group manager. </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint MgmGetProtocolOnInterface(uint dwIfIndex, uint dwIfNextHopAddr, uint* pdwIfProtocolId, uint* pdwIfComponentId);

///The <b>MgmAddGroupMembershipEntry</b> function notifies the multicast group manager that there are new receivers for
///the specified groups on the specified interface. The receivers can restrict the set of sources from which they should
///receive multicast data by specifying a source range. A multicast routing protocol calls this function when it is
///notified that there are receivers for a multicast group on an interface. The protocol must call this function so that
///multicast data can be forwarded out over an interface.
///Params:
///    hProtocol = Handle to the protocol obtained from a previous call to MgmRegisterMProtocol.
///    dwSourceAddr = Specifies the source address from which to receive multicast data. Specify zero to receive data from all sources
///                   (a wildcard receiver for a group); otherwise, specify the IP address of the source or source network. To specify
///                   a range of source addresses, specify the source network using <i>dwSourceAddr</i>, and specify a subnet mask
///                   using <i>dwSourceMask</i>.
///    dwSourceMask = Specifies the subnet mask that corresponds to <i>dwSourceAddr</i>. The <i>dwSourceAddr</i> and
///                   <i>dwSourceMask</i> parameters are used together to define a range of sources from which to receive multicast
///                   data. Specify zero for this parameter if zero was specified for <i>dwSourceAddr</i> (a wildcard receiver).
///    dwGroupAddr = Specifies the multicast group for which to receive data. Specify zero to receive all groups (a wildcard
///                  receiver); otherwise, specify the IP address of the group. To specify a range of group addresses, specify the
///                  group address using <i>dwGroupAddr</i>, and specify a subnet mask using <i>dwGroupMask</i>.
///    dwGroupMask = Specifies the subnet mask that corresponds to <i>dwGroupAddr</i>. The <i>dwGroupAddr</i> and <i>dwGroupMask</i>
///                  parameters are used together to define a range of multicast groups. Specify zero for this parameter if zero was
///                  specified for <i>dwGroupAddr</i> (a wildcard receiver).
///    dwIfIndex = Specifies the interface on which to add the group membership. Multicast data for the specified groups will be
///                forwarded out over this interface.
///    dwIfNextHopIPAddr = Specifies the address of the next hop that corresponds to the index specified by <i>dwIfIndex</i>. The
///                        <i>dwIfIndex</i> and <i>dwIfNextHopIPAddr</i> parameters uniquely identify a next hop on point-to-multipoint
///                        interfaces. A point-to-multipoint interface is a connection where one interface connects to multiple networks.
///                        Examples of point-to-multipoint interfaces include non-broadcast multiple access (NBMA) interfaces and the
///                        internal interface on which all dial-up clients connect. For broadcast interfaces (such as Ethernet interfaces)
///                        or point-to-point interfaces, which are identified by only the value of <i>dwIfIndex</i>, specify zero.
///    dwFlags = Specifies any additional processing that must take place when the group membership is added. Valid values are:
///              <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MGM_JOIN_STATE_FLAG"></a><a
///              id="mgm_join_state_flag"></a><dl> <dt><b>MGM_JOIN_STATE_FLAG</b></dt> </dl> </td> <td width="60%"> Add group
///              membership for the specified source and group. Update any forwarding entries for the specified source group to
///              reflect this change in group membership. </td> </tr> <tr> <td width="40%"><a id="MGM_FORWARD_STATE"></a><a
///              id="mgm_forward_state"></a><dl> <dt><b>MGM_FORWARD_STATE</b></dt> </dl> </td> <td width="60%"> Add the specified
///              interface to the list of outgoing interfaces for the forwarding entry that corresponds to the specified source
///              and group. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CAN_NOT_COMPLETE</b></dt> </dl> </td> <td width="60%"> Could not complete the call to this function.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%">
///    Invalid handle to the protocol. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt>
///    </dl> </td> <td width="60%"> Not enough memory to complete this operation. </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint MgmAddGroupMembershipEntry(HANDLE hProtocol, uint dwSourceAddr, uint dwSourceMask, uint dwGroupAddr, 
                                uint dwGroupMask, uint dwIfIndex, uint dwIfNextHopIPAddr, uint dwFlags);

///The <b>MgmDeleteGroupMembershipEntry</b> function notifies the multicast group manager that there are no more
///receivers present for the specified groups on the specified interface. A multicast routing protocol calls this
///function after it is notified that there are no more receivers for a multicast group on an interface. The protocol
///must call this function to stop multicast data from being forwarded out over an interface.
///Params:
///    hProtocol = Handle to the protocol obtained from a previous call to MgmRegisterMProtocol.
///    dwSourceAddr = Specifies the source address from which to stop receiving multicast data. Specify zero to stop receiving data
///                   from all sources (a wildcard receiver for a group); otherwise, specify the IP address of the source or source
///                   network. To specify a range of source addresses, specify the source network using <i>dwSourceAddr</i>, and
///                   specify a subnet mask using <i>dwSourceMask</i>.
///    dwSourceMask = Specifies the subnet mask that corresponds to <i>dwSourceAddr</i>. The <i>dwSourceAddr</i> and
///                   <i>dwSourceMask</i> parameters are used together to define a range of sources from which to stop receiving
///                   multicast data. Specify zero for this parameter if zero was specified for <i>dwSourceAddr</i> (a wildcard
///                   receiver).
///    dwGroupAddr = Specifies the multicast group for which to stop receiving data. Specify zero to stop receiving all groups (a
///                  wildcard receiver); otherwise, specify the IP address of the group. To specify a range of group addresses,
///                  specify the group address using <i>dwGroupAddr</i>, and specify a subnet mask using <i>dwGroupMask</i>.
///    dwGroupMask = Specifies the subnet mask that corresponds to <i>dwGroupAddr</i>. The <i>dwGroupAddr</i> and <i>dwGroupMask</i>
///                  parameters are used together to define a range of multicast groups. Specify zero for this parameter if zero was
///                  specified for <i>dwGroupAddr</i> (a wildcard receiver).
///    dwIfIndex = Specifies the interface on which to delete the group membership. Multicast data for the specified groups are no
///                longer forwarded out over this interface.
///    dwIfNextHopIPAddr = Specifies the address of the next hop that corresponds to the index specified by <i>dwIfIndex</i>. The
///                        <i>dwIfIndex</i> and <i>dwIfNextHopIPAddr</i> parameters uniquely identify a next hop on point-to-multipoint
///                        interfaces. A point-to-multipoint interface is a connection where one interface connects to multiple networks.
///                        Examples of point-to-multipoint interfaces include non-broadcast multiple access (NBMA) interfaces and the
///                        internal interface on which all dial-up clients connect. For broadcast interfaces (such as Ethernet interfaces)
///                        or point-to-point interfaces, which are identified by only the value of <i>dwIfIndex</i>, specify zero.
///    dwFlags = Specifies any additional processing that must take place when the group membership is removed. Valid values are:
///              <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MGM_JOIN_STATE_FLAG"></a><a
///              id="mgm_join_state_flag"></a><dl> <dt><b>MGM_JOIN_STATE_FLAG</b></dt> </dl> </td> <td width="60%"> Remove group
///              membership for the specified source and group. Update any forwarding entries for the specified source group to
///              reflect this change in group membership. </td> </tr> <tr> <td width="40%"><a id="MGM_FORWARD_STATE"></a><a
///              id="mgm_forward_state"></a><dl> <dt><b>MGM_FORWARD_STATE</b></dt> </dl> </td> <td width="60%"> Remove the
///              specified interface from the list of outgoing interfaces for the forwarding entry that corresponds to the
///              specified source and group. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CAN_NOT_COMPLETE</b></dt> </dl> </td> <td width="60%"> Could not complete the call to this function.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%">
///    Invalid handle to a protocol, or the interface is owned by another protocol. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified interface was not found. </td>
///    </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint MgmDeleteGroupMembershipEntry(HANDLE hProtocol, uint dwSourceAddr, uint dwSourceMask, uint dwGroupAddr, 
                                   uint dwGroupMask, uint dwIfIndex, uint dwIfNextHopIPAddr, uint dwFlags);

///The <b>MgmGetMfe</b> function retrieves a specific MFE.
///Params:
///    pimm = Pointer to a MIB_IPMCAST_MFE structure that specifies the MFE to retrieve. The information to be returned is
///           indicated by the <b>dwSource</b> and <b>dwGroup</b> members of the <b>MIB_IPMCAST_MFE</b> structure.
///    pdwBufferSize = On input, <i>pdwBufferSize</i> is a pointer to a <b>DWORD</b>-sized memory location that contains the size, in
///                    bytes, of the buffer pointed to by <i>pbBuffer</i>. On output, if the return value is ERROR_INSUFFICIENT_BUFFER,
///                    <i>pdwBufferSize</i> receives the minimum size the buffer pointed to by <i>pbBuffer</i> must be to hold the MFE;
///                    otherwise the value of <i>pdwBufferSize</i> remains unchanged.
///    pbBuffer = On input, the client must supply a pointer to a buffer. On output, <i>pbBuffer</i> contains the specified MFE.
///               The MFE is a MIB_IPMCAST_MFE structure.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CAN_NOT_COMPLETE</b></dt> </dl> </td> <td width="60%"> Could not complete the call to this function.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The
///    specified buffer is too small to hold the MFE. The client should check the value of <i>pdwBufferSize</i> for the
///    minimum buffer size required to retrieve the MFE. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified MFE was not found. </td> </tr>
///    </table>
///    
@DllImport("rtm")
uint MgmGetMfe(MIB_IPMCAST_MFE* pimm, uint* pdwBufferSize, ubyte* pbBuffer);

///The <b>MgmGetFirstMfe</b> function retrieves MFEs starting at the beginning of the MFE list. The function can
///retrieve zero, one, or more MFEs. The number of MFEs returned depends on the size of the MFEs and the size of the
///buffer supplied by the client when the function is called. The data returned in the buffer is ordered first by group,
///and then by the sources within a group.
///Params:
///    pdwBufferSize = On input, <i>pdwBufferSize</i> is a pointer to a <b>DWORD</b>-sized memory location containing the size, in
///                    bytes, of <i>pbBuffer</i>. On output, if the return value is ERROR_INSUFFICIENT_BUFFER, <i>pdwBufferSize</i>
///                    receives the minimum size <i>pbBuffer</i> must be to hold the MFE; otherwise, the value of <i>pdwBufferSize</i>
///                    remains unchanged.
///    pbBuffer = On input, the client must supply a pointer to a buffer. On output, <i>pbBuffer</i> contains one or more MFEs.
///               Each MFE is a MIB_IPMCAST_MFE structure.
///    pdwNumEntries = On input, the client must supply a pointer to a <b>DWORD</b>-sized memory location. On output,
///                    <i>pdwNumEntries</i> receives the number of MFEs contained in <i>pbBuffer</i>.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CAN_NOT_COMPLETE</b></dt> </dl> </td> <td width="60%"> Could not complete the call to this function.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The
///    specified buffer is too small for even one MFE. The client should check the value of <i>pdwBufferSize</i> for the
///    minimum buffer size required to retrieve one MFE. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> More MFEs are available. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> No more MFEs are available.
///    Zero or more MFEs were returned; check the value of <i>pdwNumEntries</i> to verify how many MFEs were returned.
///    </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint MgmGetFirstMfe(uint* pdwBufferSize, ubyte* pbBuffer, uint* pdwNumEntries);

///The <b>MgmGetNextMfe</b> function retrieves one or more MFEs. The routing table manager starts retrieving MFEs
///starting with the MFE that follows the specified MFE. The function can retrieve zero, one, or more MFEs. The number
///of MFEs returned depends on the size of the MFEs and the size of the buffer supplied by the client when the function
///is called. The data returned in the buffer is ordered first by group, and then by the sources within a group.
///Params:
///    pimmStart = Pointer to a MIB_IPMCAST_MFE structure that specifies from where to begin retrieving MFEs. The <b>dwSource</b>
///                and <b>dwGroup</b> members of the <b>MIB_IPMCAST_MFE</b> structure identify an MFE. Specify the source and group
///                of the last MFE that was returned by the previous call to MgmGetFirstMfe or <b>MgmGetNextMfe</b>.
///    pdwBufferSize = On input, <i>pdwBufferSize</i> is a pointer to a <b>DWORD</b>-sized memory location containing the size, in
///                    bytes, of <i>pbBuffer</i>. On output, if the return value is ERROR_INSUFFICIENT_BUFFER, <i>pdwBufferSize</i>
///                    receives the minimum size <i>pbBuffer</i> must be to hold the MFE; otherwise, the value of <i>pdwBufferSize</i>
///                    remains unchanged.
///    pbBuffer = On input, the client must supply a pointer to a buffer. On output, <i>pbBuffer</i> contains one or more MFEs.
///               Each MFE is a MIB_IPMCAST_MFE structure.
///    pdwNumEntries = On input, the client must supply a pointer to a <b>DWORD</b>-sized memory location. On output,
///                    <i>pdwNumEntries</i> receives the number of MFEs contained in <i>pbBuffer</i>.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CAN_NOT_COMPLETE</b></dt> </dl> </td> <td width="60%"> Could not complete the call to this function.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The
///    specified buffer is too small for even one MFE. The client should check the value of <i>pdwBufferSize</i> for the
///    minimum buffer size required to retrieve one MFE. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> More MFEs are available. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> No more MFEs are available.
///    Zero or more MFEs were returned; check the value of <i>pdwNumEntries</i> to verify how many MFEs were returned.
///    </td> </tr> </table>
///    
@DllImport("rtm")
uint MgmGetNextMfe(MIB_IPMCAST_MFE* pimmStart, uint* pdwBufferSize, ubyte* pbBuffer, uint* pdwNumEntries);

///The <b>MgmGetMfeStats</b> function retrieves the statistics for a specific MFE. The statistics returned include the
///packets received, bytes received, and the packets forwarded on each outgoing interface.
///Params:
///    pimm = Pointer to a MIB_IPMCAST_MFE structure that specifies the MFE for which to retrieve statistics. The information
///           to be returned is indicated by the <b>dwSource</b> and <b>dwGroup</b> members of the <b>MIB_IPMCAST_MFE</b>
///           structure.
///    pdwBufferSize = On input, <i>pdwBufferSize</i> is a pointer to a <b>DWORD</b>-sized memory location that contains the size, in
///                    bytes, of the buffer pointed to by <i>pbBuffer</i>. On output, if the return value is ERROR_INSUFFICIENT_BUFFER,
///                    <i>pdwBufferSize</i> receives the minimum size the buffer pointed to by <i>pbBuffer</i> must be to hold the set
///                    of MFE statistics; otherwise the value of <i>pdwBufferSize</i> remains unchanged.
///    pbBuffer = On input, the client must supply a pointer to a buffer. On output, <i>pbBuffer</i> contains the specified set of
///               MFE statistics.
///    dwFlags = Determines the data structure returned. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="MGM_MFE_STATS_0"></a><a id="mgm_mfe_stats_0"></a><dl> <dt><b>MGM_MFE_STATS_0</b></dt> </dl>
///              </td> <td width="60%"> Include statistics corresponding to MIB_IPMCAST_MFE_STATS. </td> </tr> <tr> <td
///              width="40%"><a id="MGM_MFE_STATS_1"></a><a id="mgm_mfe_stats_1"></a><dl> <dt><b>MGM_MFE_STATS_1</b></dt> </dl>
///              </td> <td width="60%"> Include statistics corresponding to MIB_IPMCAST_MFE_STATS_EX. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CAN_NOT_COMPLETE</b></dt> </dl> </td> <td width="60%"> Could not complete the call to this function.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The
///    specified buffer is too small for the statistics for even one MFE. The client should check the value of
///    <i>pdwBufferSize</i> for the minimum buffer size required to retrieve statistics for one MFE. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified MFE was not
///    found. </td> </tr> </table>
///    
@DllImport("rtm")
uint MgmGetMfeStats(MIB_IPMCAST_MFE* pimm, uint* pdwBufferSize, ubyte* pbBuffer, uint dwFlags);

///The <b>MgmGetFirstMfeStats</b> function retrieves MFE statistics starting at the beginning of the MFE list. The
///function can retrieve zero, one, or more sets of MFE statistics. The number of sets returned depends on the size of
///the entries and the size of the buffer supplied by the client when the function is called. The data returned in the
///buffer is ordered first by group, and then by the sources within a group. The statistics returned include the packets
///received, bytes received, and packets forwarded on each outgoing interface.
///Params:
///    pdwBufferSize = On input, <i>pdwBufferSize</i> is a pointer to a <b>DWORD</b>-sized memory location containing the size, in
///                    bytes, of <i>pbBuffer</i>. On output, if the return value is ERROR_INSUFFICIENT_BUFFER, <i>pdwBufferSize</i>
///                    receives the minimum size <i>pbBuffer</i> must be to hold a set of MFE statistics; otherwise, the value of
///                    <i>pdwBufferSize</i> remains unchanged.
///    pbBuffer = On input, the client must supply a pointer to a buffer. On output, <i>pbBuffer</i> contains one or more sets of
///               MFE statistics. Each set of MFE statistics is a MIB_IPMCAST_MFE_STATS structure.
///    pdwNumEntries = On input, the client must supply a pointer to a <b>DWORD</b>-sized memory location. On output,
///                    <i>pdwNumEntries</i> receives the number of sets of MFE statistics contained in <i>pbBuffer</i>.
///    dwFlags = Determines the data structure returned. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="MGM_MFE_STATS_0"></a><a id="mgm_mfe_stats_0"></a><dl> <dt><b>MGM_MFE_STATS_0</b></dt> </dl>
///              </td> <td width="60%"> Include statistics corresponding to MIB_IPMCAST_MFE_STATS. </td> </tr> <tr> <td
///              width="40%"><a id="MGM_MFE_STATS_1"></a><a id="mgm_mfe_stats_1"></a><dl> <dt><b>MGM_MFE_STATS_1</b></dt> </dl>
///              </td> <td width="60%"> Include statistics corresponding to MIB_IPMCAST_MFE_STATS_EX. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CAN_NOT_COMPLETE</b></dt> </dl> </td> <td width="60%"> Could not complete the call to this function.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The
///    specified buffer is too small for even one set of MFE statistics. The client should check the value of
///    <i>pdwBufferSize</i> for the minimum buffer size required to retrieve one set of statistics. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> More MFE statistics are available.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> No more
///    MFE statistics are available. Zero or more sets of MFE statistics were returned; check the value of
///    <i>pdwNumEntries</i> to verify how many sets of statistics were returned. </td> </tr> </table>
///    
@DllImport("rtm")
uint MgmGetFirstMfeStats(uint* pdwBufferSize, ubyte* pbBuffer, uint* pdwNumEntries, uint dwFlags);

///The <b>MgmGetNextMfeStats</b> function retrieves one or more sets of MFE statistics. The routing table manager starts
///retrieving statistics starting with the MFE that follows the specified MFE. The function can retrieve zero, one, or
///more sets of MFE statistics. The number of sets returned depends on the size of the entries and the size of the
///buffer supplied by the client when the function is called. The data returned in the buffer is ordered first by group,
///and then by the sources within a group. The statistics returned include the packets received, bytes received, and
///packets forwarded on each outgoing interface.
///Params:
///    pimmStart = Pointer to a MIB_IPMCAST_MFE structure that specifies from where to begin retrieving MFE statistics. The
///                <b>dwSource</b> and <b>dwGroup</b> members of the <b>MIB_IPMCAST_MFE</b> structure identify an MFE. Specify the
///                source and group of the last MFE that was returned by the previous call to MgmGetFirstMfeStats or
///                <b>MgmGetNextMfeStats</b>.
///    pdwBufferSize = On input, <i>pdwBufferSize</i> is a pointer to a <b>DWORD</b>-sized memory location that contains the size, in
///                    bytes, of <i>pbBuffer</i>. On output, if the return value is <b>ERROR_INSUFFICIENT_BUFFER</b>,
///                    <i>pdwBufferSize</i> receives the minimum size <i>pbBuffer</i> must be to hold a set of MFE statistics;
///                    otherwise, the value of <i>pdwBufferSize</i> remains unchanged.
///    pbBuffer = On input, the client must supply a pointer to a buffer. On output, <i>pbBuffer</i> contains one or more sets of
///               MFE statistics. Each set of MFE statistics is a MIB_IPMCAST_MFE_STATS structure.
///    pdwNumEntries = On input, the client must supply a pointer to a <b>DWORD</b>-sized memory location. On output,
///                    <i>pdwNumEntries</i> receives the number of sets of MFE statistics contained in <i>pbBuffer</i>.
///    dwFlags = Determines the data structure returned. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="MGM_MFE_STATS_0"></a><a id="mgm_mfe_stats_0"></a><dl> <dt><b>MGM_MFE_STATS_0</b></dt> </dl>
///              </td> <td width="60%"> Include statistics corresponding to MIB_IPMCAST_MFE_STATS. </td> </tr> <tr> <td
///              width="40%"><a id="MGM_MFE_STATS_1"></a><a id="mgm_mfe_stats_1"></a><dl> <dt><b>MGM_MFE_STATS_1</b></dt> </dl>
///              </td> <td width="60%"> Include statistics corresponding to MIB_IPMCAST_MFE_STATS_EX. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CAN_NOT_COMPLETE</b></dt> </dl> </td> <td width="60%"> Could not complete the call to this function.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The
///    specified buffer is too small for even one set of MFE statistics. The client should check the value of
///    <i>pdwBufferSize</i> for the minimum buffer size required to retrieve one set of statistics. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> More MFE statistics are available.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> No more
///    MFE statistics are available. Zero or more sets of MFE statistics were returned; check the value of
///    <i>pdwNumEntries</i> to verify how many sets of statistics were returned. </td> </tr> </table>
///    
@DllImport("rtm")
uint MgmGetNextMfeStats(MIB_IPMCAST_MFE* pimmStart, uint* pdwBufferSize, ubyte* pbBuffer, uint* pdwNumEntries, 
                        uint dwFlags);

///The <b>MgmGroupEnumerationStart</b> function obtains an enumeration handle that is later used to obtain the list of
///groups that have been joined. After the client obtains the handle, it should use the MgmGroupEnumerationGetNext
///function to enumerate the groups.
///Params:
///    hProtocol = Handle to the protocol obtained from a previous call to MgmRegisterMProtocol.
///    metEnumType = Specifies the type of enumeration. The following enumerations are available. <table> <tr> <th>Enumeration</th>
///                  <th>Meaning</th> </tr> <tr> <td width="40%"><a id="ALL_SOURCES"></a><a id="all_sources"></a><dl>
///                  <dt><b>ALL_SOURCES</b></dt> </dl> </td> <td width="60%"> Retrieves wildcard joins (*, g) and source-specific
///                  joins (s, g). </td> </tr> <tr> <td width="40%"><a id="ANY_SOURCE"></a><a id="any_source"></a><dl>
///                  <dt><b>ANY_SOURCE</b></dt> </dl> </td> <td width="60%"> Retrieves group entries that have at least one source
///                  specified. </td> </tr> </table>
///    phEnumHandle = Receives the handle to the enumeration. Use this handle in calls to MgmGroupEnumerationGetNext and
///                   MgmGroupEnumerationEnd.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CAN_NOT_COMPLETE</b></dt> </dl> </td> <td width="60%"> Could not complete the call to this function.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%">
///    Invalid handle to a protocol. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt>
///    </dl> </td> <td width="60%"> Not enough memory to complete this operation. </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint MgmGroupEnumerationStart(HANDLE hProtocol, MGM_ENUM_TYPES metEnumType, HANDLE* phEnumHandle);

///The <b>MgmGroupEnumerationGetNext</b> function retrieves the next set of group entries. The information that is
///returned by this function is a list of groups joined and the sources requested, if any. The groups are not returned
///in any particular order.
///Params:
///    hEnum = Handle to the enumeration that was obtained from a previous call to MgmGroupEnumerationStart.
///    pdwBufferSize = On input, <i>pdwBufferSize</i> is a pointer to a <b>DWORD</b>-sized memory location that contains the size, in
///                    bytes, of the buffer pointed to by <i>pbBuffer</i>. On output, if the return value is ERROR_INSUFFICIENT_BUFFER,
///                    <i>pdwBufferSize</i> receives the minimum size that the buffer pointed to by <i>pbBuffer</i> must be to hold a
///                    group entry; otherwise the value of <i>pdwBufferSize</i> remains unchanged.
///    pbBuffer = On input, the client must supply a pointer to a buffer. On output, <i>pbBuffer</i> contains one or more group
///               entries. Each group entry is a SOURCE_GROUP_ENTRY structure.
///    pdwNumEntries = On input, the client must supply a pointer to a <b>DWORD</b> value. On output, <i>pdwNumEntries</i> receives the
///                    number of groups in <i>pbBuffer</i>.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CAN_NOT_COMPLETE</b></dt> </dl> </td> <td width="60%"> Could not complete the call to this function.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The
///    specified buffer is too small to hold even one group. The client should check the value of <i>pdwBufferSize</i>
///    for the minimum buffer size required to retrieve one group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> Invalid handle to an enumeration. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> More groups are
///    available. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td
///    width="60%"> No more groups are available. Zero or more groups were returned; check the value of
///    <i>pdwNumEntries</i> to verify how many groups were returned. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory to complete this
///    operation. </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint MgmGroupEnumerationGetNext(HANDLE hEnum, uint* pdwBufferSize, ubyte* pbBuffer, uint* pdwNumEntries);

///The <b>MgmGroupEnumerationEnd</b> function releases the specified enumeration handle that was obtained from a
///previous call to MgmGroupEnumerationStart.
///Params:
///    hEnum = Specifies the enumeration handle to release.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CAN_NOT_COMPLETE</b></dt> </dl> </td> <td width="60%"> Could not complete the call to this function.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%">
///    Invalid enumeration handle. </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint MgmGroupEnumerationEnd(HANDLE hEnum);

@DllImport("rtm")
uint RtmConvertNetAddressToIpv6AddressAndLength(RTM_NET_ADDRESS* pNetAddress, in6_addr* pAddress, uint* pLength, 
                                                uint dwAddressSize);

@DllImport("rtm")
uint RtmConvertIpv6AddressAndLengthToNetAddress(RTM_NET_ADDRESS* pNetAddress, in6_addr Address, uint dwLength, 
                                                uint dwAddressSize);

///The <b>RtmRegisterEntity</b> function registers a client with an instance of the routing table manager for a specific
///address family. The routing table manager returns a registration handle and a profile of the instance. The profile
///contains a list of values that are used when calling other functions. Values include the maximum number of
///destinations returned in a buffer by a single call. Registration is the first action a client should take.
///Params:
///    RtmEntityInfo = Pointer to an RTM_ENTITY_INFO structure. This structure contains information that identifies the client to the
///                    routing table manager, such as the routing table manager instance and address family with which to register.
///    ExportMethods = Pointer to a RTM_ENTITY_EXPORT_METHODS structure that contains a list of methods exported by the client. This
///                    parameter is optional and can be set to <b>NULL</b> if the calling client has no methods to export.
///    EventCallback = A <b>RTM_EVENT_CALLBACK</b> structure that specifies the callback the routing table manager uses to notify the
///                    client of events. The events are when a client registers and unregisters, when routes expire, and when changes to
///                    the best route to a destination have occurred. Only those changes specified when the client called
///                    RtmRegisterForChangeNotification.
///    ReserveOpaquePointer = Specifies whether to reserve an opaque pointer in each destination for this instance of the protocol. Specify
///                           <b>TRUE</b> to reserve an opaque pointer in each destination. Specify <b>FALSE</b> to skip this action. These
///                           opaque pointers can be used to point to a private, protocol-specific context for each destination.
///    RtmRegProfile = On input, <i>RtmRegProfile</i> is a pointer to an RTM_REGN_PROFILE structure. On output, <i>RtmRegProfile</i> is
///                    filled with the requested registration profile structure. The client must use the information returned in other
///                    function calls (information returned includes the number of equal-cost next hops and the maximum number of items
///                    returned by an enumeration function call).
///    RtmRegHandle = Receives a registration handle for the client. This handle must be used in all subsequent calls to the routing
///                   table manager.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ALREADY_EXISTS</b></dt> </dl> </td> <td width="60%"> The specified client has already registered
///    with the routing table manager. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_CONFIGURATION</b></dt>
///    </dl> </td> <td width="60%"> Registry information for the routing table manager is corrupt. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> Registry information for the
///    routing table manager was not found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_DATA</b></dt>
///    </dl> </td> <td width="60%"> A parameter contains incorrect information. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter contains incorrect information.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SYSTEM_RESOURCES</b></dt> </dl> </td> <td width="60%">
///    There are not enough available system resources to complete this operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to complete
///    this operation. </td> </tr> </table>
///    
@DllImport("rtm")
uint RtmRegisterEntity(RTM_ENTITY_INFO* RtmEntityInfo, RTM_ENTITY_EXPORT_METHODS* ExportMethods, 
                       RTM_EVENT_CALLBACK EventCallback, BOOL ReserveOpaquePointer, RTM_REGN_PROFILE* RtmRegProfile, 
                       ptrdiff_t* RtmRegHandle);

///The <b>RtmDeregisterEntity</b> function unregisters a client from a routing table manager instance and address
///family.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. </td> </tr> </table>
///    <div> </div>
///    
@DllImport("rtm")
uint RtmDeregisterEntity(ptrdiff_t RtmRegHandle);

///The <b>RtmGetRegisteredEntities</b> function returns information about all clients that have registered with the
///specified instance of the routing table manager and specified address family.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    NumEntities = On input, <i>NumEntities</i> is a pointer to a <b>UINT</b> value, which specifies the maximum number of clients
///                  that can be received by <i>EntityInfos</i>. On output, <i>NumEntities</i> receives the actual number of clients
///                  received by <i>EntityInfos</i>.
///    EntityHandles = If handles must be returned: On input, <i>EntityHandles</i> is a pointer to <b>NULL</b>. On output,
///                    <i>EntityHandles</i> receives a pointer to an array of entity handle; otherwise, <i>EntityHandles</i> remains
///                    unchanged. If handles do not need to be returned: On input, <i>EntityHandles</i> is <b>NULL</b>.
///    EntityInfos = If a pointer must be returned: On input, <i>EntityInfos</i> is a pointer to <b>NULL</b>. On output,
///                  <i>EntityInfos</i> receives a pointer to an array of RTM_ENTITY_INFO structures; otherwise, <i>EntityInfos</i>
///                  remains unchanged. If a pointer does not need to be returned: On input, <i>EntityInfos</i> is <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer supplied is not large enough to
///    hold all the requested information. </td> </tr> </table>
///    
@DllImport("rtm")
uint RtmGetRegisteredEntities(ptrdiff_t RtmRegHandle, uint* NumEntities, ptrdiff_t* EntityHandles, 
                              RTM_ENTITY_INFO* EntityInfos);

///The <b>RtmReleaseEntities</b> function releases the client handles returned by RtmGetRegisteredEntities.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    NumEntities = Specifies the number of clients in <i>EntityHandles</i>.
///    EntityHandles = Pointer to an array of client handles to release. The handles were obtained from a previous call to
///                    RtmGetRegisteredEntities.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. </td> </tr> </table>
///    <div> </div>
///    
@DllImport("rtm")
uint RtmReleaseEntities(ptrdiff_t RtmRegHandle, uint NumEntities, ptrdiff_t* EntityHandles);

///The <b>RtmLockDestination</b> function locks or unlocks a destination in the routing table. Use this function to
///protect a destination while changing opaque pointers.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    DestHandle = Handle to the destination to lock.
///    Exclusive = Specifies whether to lock or unlock the destination in an exclusive (<b>TRUE</b>) or shared (<b>FALSE</b>) mode.
///    LockDest = Specifies whether to lock or unlock the destination. Specify <b>TRUE</b> to lock the destination; specify
///               <b>FALSE</b> to unlock it.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling client does not own this
///    destination. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> The handle is invalid. </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint RtmLockDestination(ptrdiff_t RtmRegHandle, ptrdiff_t DestHandle, BOOL Exclusive, BOOL LockDest);

///The <b>RtmGetOpaqueInformationPointer</b> function returns a pointer to the opaque information field in a destination
///that is reserved for this client. The pointer enables the client to store client-specific information with the
///destination in the routing table.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    DestHandle = Handle to the destination.
///    OpaqueInfoPointer = On input, <i>OpaqueInfoPointer</i> is a pointer to <b>NULL</b>. On output, <i>OpaqueInfoPointer</i> receives a
///                        pointer to the opaque information pointer. If a client has not reserved an opaque pointer during registration,
///                        this parameter remains unchanged.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No opaque pointer was reserved by
///    the client. </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint RtmGetOpaqueInformationPointer(ptrdiff_t RtmRegHandle, ptrdiff_t DestHandle, void** OpaqueInfoPointer);

///The <b>RtmGetEntityMethods</b> function queries the specified client to determine which methods are available for
///another client to invoke.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    EntityHandle = Handle to the client for which to obtain methods.
///    NumMethods = On input, <i>NumMethods</i> specifies a valid pointer to a <b>UINT</b> value. Specify zero to return the number
///                 of methods available to be exported. On output, <i>NumMethods</i> receives the number of methods exported by the
///                 client.
///    ExptMethods = Receives a pointer to an RTM_ENTITY_EXPORT_METHOD structure that contains the set of method identifiers requested
///                  by the calling client.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer supplied is not large enough to
///    hold all the requested information. </td> </tr> </table>
///    
@DllImport("rtm")
uint RtmGetEntityMethods(ptrdiff_t RtmRegHandle, ptrdiff_t EntityHandle, uint* NumMethods, 
                         PRTM_ENTITY_EXPORT_METHOD ExptMethods);

///The <b>RtmInvokeMethod</b> function invokes a method exported by another client.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    EntityHandle = Handle to the client whose methods are being invoked.
///    Input = Pointer to an RTM_ENTITY_METHOD_INPUT structure that contains the method to be invoked and a common input buffer.
///    OutputSize = On input, <i>OutputSize</i> is a pointer to a <b>UINT</b> value that specifies the size, in bytes, of
///                 <i>Output</i>. On output, <i>OutputSize</i> receives a pointer to a <b>UINT</b> value that specifies the actual
///                 size, in bytes, of <i>Output</i>.
///    Output = Receives a pointer to an array of RTM_ENTITY_METHOD_OUTPUT structures. Each structure consists of a (method
///             identifier, correct output) tuple.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. </td> </tr> </table>
///    <div> </div>
///    
@DllImport("rtm")
uint RtmInvokeMethod(ptrdiff_t RtmRegHandle, ptrdiff_t EntityHandle, RTM_ENTITY_METHOD_INPUT* Input, 
                     uint* OutputSize, RTM_ENTITY_METHOD_OUTPUT* Output);

///The <b>RtmBlockMethods</b> function blocks or unblocks the execution of methods for a specified destination, route,
///or next hop, or for all destinations, routes, and next hops.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    TargetHandle = Handle to a destination, route, or next hop for which to block methods. This parameter is optional and can be set
///                   to <b>NULL</b> to block methods for all targets.
///    TargetType = Specifies the type of the handle in <i>TargetHandle</i>. This parameter is optional and can be set to <b>NULL</b>
///                 to block methods for all targets. The following flags are used. <table> <tr> <th>Type</th> <th>Meaning</th> </tr>
///                 <tr> <td width="40%"><a id="DEST_TYPE"></a><a id="dest_type"></a><dl> <dt><b>DEST_TYPE</b></dt> </dl> </td> <td
///                 width="60%"> <i>TargetHandle</i> is a destination. </td> </tr> <tr> <td width="40%"><a id="NEXTHOP_TYPE"></a><a
///                 id="nexthop_type"></a><dl> <dt><b>NEXTHOP_TYPE</b></dt> </dl> </td> <td width="60%"> <i>TargetHandle</i> is a
///                 next hop. </td> </tr> <tr> <td width="40%"><a id="ROUTE_TYPE"></a><a id="route_type"></a><dl>
///                 <dt><b>ROUTE_TYPE</b></dt> </dl> </td> <td width="60%"> <i>TargetHandle</i> is a route. </td> </tr> </table>
///    BlockingFlag = Specifies whether to block or unblock methods. The following flags are used. <table> <tr> <th>Constant</th>
///                   <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RTM_BLOCK_METHODS"></a><a id="rtm_block_methods"></a><dl>
///                   <dt><b>RTM_BLOCK_METHODS</b></dt> </dl> </td> <td width="60%"> Block methods for the specified target. </td>
///                   </tr> <tr> <td width="40%"><a id="RTM_RESUME_METHODS"></a><a id="rtm_resume_methods"></a><dl>
///                   <dt><b>RTM_RESUME_METHODS</b></dt> </dl> </td> <td width="60%"> Unblock methods for the specified target. </td>
///                   </tr> </table>
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is the following
///    error code. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. </td> </tr> </table>
///    <div> </div>
///    
@DllImport("rtm")
uint RtmBlockMethods(ptrdiff_t RtmRegHandle, HANDLE TargetHandle, ubyte TargetType, uint BlockingFlag);

///The <b>RtmGetEntityInfo</b> function returns information about a previously registered client.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    EntityHandle = Handle to the client for which to return information.
///    EntityInfo = On input, <i>EntityInfo</i> is a pointer to an RTM_ENTITY_INFO structure. On output, <i>EntityInfo</i> receives
///                 the requested information.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. </td> </tr> </table>
///    <div> </div>
///    
@DllImport("rtm")
uint RtmGetEntityInfo(ptrdiff_t RtmRegHandle, ptrdiff_t EntityHandle, RTM_ENTITY_INFO* EntityInfo);

///The <b>RtmGetDestInfo</b> function returns information about a destination.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    DestHandle = Handle to the destination for which to return information.
///    ProtocolId = Specifies the protocol identifier. The <i>ProtocolID</i> is not part of the search criteria. The routing table
///                 manager uses this identifier to determine which route information to return. For example, if a client specifies
///                 the RIP protocol identifier, the best RIP route is returned, even if a non-RIP route is the best route to the
///                 destination. Specify RTM_BEST_PROTOCOL to return a route regardless of which protocol owns it. Specify
///                 RTM_THIS_PROTOCOL to return the best route for the calling protocol.
///    TargetViews = Specifies the views from which to return information. If the client specifies RTM_VIEW_MASK_ANY, destination
///                  information is returned from all views; however, no view-specific information is returned.
///    DestInfo = On input, <i>DestInfo</i> is a pointer to an RTM_DEST_INFO structure. On output, <i>DestInfo</i> is filled with
///               the requested destination information.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. </td> </tr> </table>
///    <div> </div>
///    
@DllImport("rtm")
uint RtmGetDestInfo(ptrdiff_t RtmRegHandle, ptrdiff_t DestHandle, uint ProtocolId, uint TargetViews, 
                    RTM_DEST_INFO* DestInfo);

///The <b>RtmGetRouteInfo</b> function returns information for the specified route.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    RouteHandle = Handle to the route to find.
///    RouteInfo = If a pointer must be returned: On input, <i>RouteInfo</i> is a pointer to <b>NULL</b>. On output,
///                <i>RouteInfo</i> receives a pointer to the route; otherwise, <i>RouteInfo</i> remains unchanged. If a pointer
///                does not need to be returned: On input, <i>RouteInfo</i> is <b>NULL</b>.
///    DestAddress = If a pointer must be returned: On input, <i>DestAddress</i> is a pointer to <b>NULL</b>. On output,
///                  <i>DestAddress</i> receives a pointer to the destination's RTM_NET_ADDRESS structure; otherwise,
///                  <i>DestAddress</i> remains unchanged. If a pointer does not need to be returned: On input, <i>DestAddress</i> is
///                  <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. </td> </tr> </table>
///    <div> </div>
///    
@DllImport("rtm")
uint RtmGetRouteInfo(ptrdiff_t RtmRegHandle, ptrdiff_t RouteHandle, RTM_ROUTE_INFO* RouteInfo, 
                     RTM_NET_ADDRESS* DestAddress);

///The <b>RtmGetNextHopInfo</b> function returns information about the specified next hop.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    NextHopHandle = Handle to the next hop.
///    NextHopInfo = On input, <i>NextHopInfo</i> a pointer to an RTM_NEXTHOP_INFO structure. On output, <i>NextHopInfo</i> is filled
///                  with the requested next-hop information.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. </td> </tr> </table>
///    <div> </div>
///    
@DllImport("rtm")
uint RtmGetNextHopInfo(ptrdiff_t RtmRegHandle, ptrdiff_t NextHopHandle, RTM_NEXTHOP_INFO* NextHopInfo);

///The <b>RtmReleaseEntityInfo</b> function releases a client structure.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    EntityInfo = Pointer to the handle to release. The handle was obtained with a previous call to RtmGetEntityInfo.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. </td> </tr> </table>
///    <div> </div>
///    
@DllImport("rtm")
uint RtmReleaseEntityInfo(ptrdiff_t RtmRegHandle, RTM_ENTITY_INFO* EntityInfo);

///The <b>RtmReleaseDestInfo</b> function releases a destination structure.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    DestInfo = Pointer to the destination to release. The destination was obtained from a previous call to a function that
///               returns an RTM_DEST_INFO structure.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. </td> </tr> </table>
///    <div> </div>
///    
@DllImport("rtm")
uint RtmReleaseDestInfo(ptrdiff_t RtmRegHandle, RTM_DEST_INFO* DestInfo);

///The <b>RtmReleaseRouteInfo</b> function releases a route structure.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    RouteInfo = Pointer to the RTM_ROUTE_INFO structure to release. The route was obtained with a previous call to
///                RtmGetRouteInfo.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. </td> </tr> </table>
///    <div> </div>
///    
@DllImport("rtm")
uint RtmReleaseRouteInfo(ptrdiff_t RtmRegHandle, RTM_ROUTE_INFO* RouteInfo);

///The <b>RtmReleaseNextHopInfo</b> function releases a next-hop structure.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    NextHopInfo = Pointer to the RTM_NEXTHOP_INFO structure to release. The next hop was obtained with a previous call to
///                  RtmGetNextHopInfo.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. </td> </tr> </table>
///    <div> </div>
///    
@DllImport("rtm")
uint RtmReleaseNextHopInfo(ptrdiff_t RtmRegHandle, RTM_NEXTHOP_INFO* NextHopInfo);

///The <b>RtmAddRouteToDest</b> function adds a new route to the routing table or updates an existing route in the
///routing table. If the best route changes, a change notification is generated.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    RouteHandle = If the client has a handle (updating a route): On input, <i>RouteHandle</i> is a pointer to the route handle. On
///                  output, <i>RouteHandle</i> is unchanged. If the client does not have a handle and a handle must be returned
///                  (client is adding or updating a route): On input, <i>RouteHandle</i> is a pointer to <b>NULL</b>. On output,
///                  <i>RouteHandle</i> receives a pointer to the route handle. The values in <i>RouteInfo</i> are used to identify
///                  the route to update. If a handle does not need to be returned (client is adding or updating a route): On input,
///                  <i>RouteHandle</i> is <b>NULL</b>. The values in <i>RouteInfo</i> are used to identify the route to update.
///    DestAddress = Pointer to the destination network address to which the route is being added or updated.
///    RouteInfo = Pointer to the route information to add or update.
///    TimeToLive = Specifies the time, in milliseconds, after which the route is expired. Specify INFINITE to prevent routes from
///                 expiring.
///    RouteListHandle = Handle to a route list to which to move the route. This parameter is optional and can be set to <b>NULL</b>.
///    NotifyType = Set this parameter to <b>NULL</b>. This parameter is reserved for future use.
///    NotifyHandle = Set this parameter to <b>NULL</b>. This parameter is reserved for future use.
///    ChangeFlags = On input, <i>ChangeFlags</i> is a pointer to an <b>RTM_ROUTE_CHANGE_FLAGS</b> data type that indicates whether
///                  the routing table manager should add a new route or update an existing one. On output, <i>ChangeFlags</i> is a
///                  pointer to an <b>RTM_ROUTE_CHANGE_FLAGS</b> data type that receives the flag indicating the type of change that
///                  was actually performed, and if the best route was changed. The following flags are used. <table> <tr>
///                  <th>Constant</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RTM_ROUTE_CHANGE_FIRST"></a><a
///                  id="rtm_route_change_first"></a><dl> <dt><b>RTM_ROUTE_CHANGE_FIRST</b></dt> </dl> </td> <td width="60%">
///                  Indicates that the routing table manager should not check the <b>Neighbour</b> member of the <i>RouteInfo</i>
///                  parameter when determining if two routes are equal. </td> </tr> <tr> <td width="40%"><a
///                  id="RTM_ROUTE_CHANGE_NEW"></a><a id="rtm_route_change_new"></a><dl> <dt><b>RTM_ROUTE_CHANGE_NEW</b></dt> </dl>
///                  </td> <td width="60%"> Returned by the routing table manager to indicate a new route was created. </td> </tr>
///                  <tr> <td width="40%"><a id="RTM_ROUTE_CHANGE_BEST"></a><a id="rtm_route_change_best"></a><dl>
///                  <dt><b>RTM_ROUTE_CHANGE_BEST</b></dt> </dl> </td> <td width="60%"> Returned by the routing table manager to
///                  indicate that the route that was added or updated was the best route, or that because of the change, a new route
///                  became the best route. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling client does not own this route.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    handle is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> A parameter contains incorrect information. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to complete this
///    operation. </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint RtmAddRouteToDest(ptrdiff_t RtmRegHandle, ptrdiff_t* RouteHandle, RTM_NET_ADDRESS* DestAddress, 
                       RTM_ROUTE_INFO* RouteInfo, uint TimeToLive, ptrdiff_t RouteListHandle, uint NotifyType, 
                       ptrdiff_t NotifyHandle, uint* ChangeFlags);

///The <b>RtmDeleteRouteToDest</b> function deletes a route from the routing table and updates the best-route
///information for the corresponding destination, if the best route changed. If the best route changes, a change
///notification is generated.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    RouteHandle = Handle to the route to delete.
///    ChangeFlags = On input, <i>ChangeFlags</i> is a pointer to <b>RTM_ROUTE_CHANGE_FLAGS</b> data type. On output,
///                  <i>ChangeFlags</i> receives RTM_ROUTE_CHANGE_BEST flag if the best route was changed.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling client does not own this route.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    handle is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td
///    width="60%"> The specified route was not found. </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint RtmDeleteRouteToDest(ptrdiff_t RtmRegHandle, ptrdiff_t RouteHandle, uint* ChangeFlags);

///The <b>RtmHoldDestination</b> function marks a destination to be put in the hold-down state for a certain amount of
///time. A hold down only happens if the last route for the destination in any view is deleted. Routing protocols that
///use hold-down states continue to advertise the last route until the hold-down expires, even if newer routes arrive in
///the meantime. The route is advertised as a deleted route. The newer routes are, however, used by the routing
///protocols for forwarding purposes. New routes are advertised when the hold down expires.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    DestHandle = Handle to the destination to mark for holding.
///    TargetViews = Specifies the views in which to hold the destination.
///    HoldTime = Specifies how long, in milliseconds, to hold the destination.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The hold time specified was zero. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is
///    invalid. </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint RtmHoldDestination(ptrdiff_t RtmRegHandle, ptrdiff_t DestHandle, uint TargetViews, uint HoldTime);

///The <b>RtmGetRoutePointer</b> function obtains a direct pointer to a route that allows the owner of the route read
///access.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    RouteHandle = Handle to the route.
///    RoutePointer = On input, <i>RoutePointer</i> is a pointer to <b>NULL</b>. On output, <i>RoutePointer</i> receives a pointer to
///                   the route.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling client does not own this route.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    handle is invalid. </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint RtmGetRoutePointer(ptrdiff_t RtmRegHandle, ptrdiff_t RouteHandle, RTM_ROUTE_INFO** RoutePointer);

///The <b>RtmLockRoute</b> function locks or unlocks a route in the routing table. This protects the route while a
///client makes the necessary changes to the opaque route pointers owned by the client.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    RouteHandle = Handle to the route to lock.
///    Exclusive = Specifies whether to lock or unlock the route in an exclusive (<b>TRUE</b>) or shared (<b>FALSE</b>) mode.
///    LockRoute = Specifies whether to lock or unlock the route. Specify <b>TRUE</b> to lock the route; specify <b>FALSE</b> to
///                unlock it.
///    RoutePointer = If a pointer must be returned: On input, <i>RoutePointer</i> is a pointer to <b>NULL</b>. On output, if the
///                   client owns the route, <i>RoutePointer</i> receives a pointer to the next-hop; otherwise, <i>RoutePointer</i>
///                   remains unchanged. If a handle does not need to be returned: On input, <i>RoutePointer</i> is <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling client does not own this route.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    handle is invalid. </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint RtmLockRoute(ptrdiff_t RtmRegHandle, ptrdiff_t RouteHandle, BOOL Exclusive, BOOL LockRoute, 
                  RTM_ROUTE_INFO** RoutePointer);

///The <b>RtmUpdateAndUnlockRoute</b> function updates the position of the route in the set of routes for a destination,
///and adjusts the best route information for the destination. This function is used after a client has locked a route
///and updated it directly (also known as <i>in-place updating</i>).
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    RouteHandle = Handle to the route to change.
///    TimeToLive = Specifies the time, in milliseconds, after which the route is expired. Specify INFINITE to prevent routes from
///                 expiring.
///    RouteListHandle = Handle to an optional route list to which to move the route. This parameter is optional and can be set to
///                      <b>NULL</b>.
///    NotifyType = Set this parameter to <b>NULL</b>. <i>NotifyType</i> is reserved for future use.
///    NotifyHandle = Set this parameter to <b>NULL</b>. <i>NotifyHandle</i> is reserved for future use.
///    ChangeFlags = Receives RTM_ROUTE_CHANGE_BEST if the best route was changed.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling client does not own this route.
///    </td> </tr> </table>
///    
@DllImport("rtm")
uint RtmUpdateAndUnlockRoute(ptrdiff_t RtmRegHandle, ptrdiff_t RouteHandle, uint TimeToLive, 
                             ptrdiff_t RouteListHandle, uint NotifyType, ptrdiff_t NotifyHandle, uint* ChangeFlags);

///The <b>RtmGetExactMatchDestination</b> function searches the routing table for a destination that exactly matches the
///specified network address and subnet mask. If an exact match is found, the information for that destination is
///returned.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    DestAddress = Pointer to the destination network address.
///    ProtocolId = Specifies the protocol identifier. The <i>ProtocolID</i> is not part of the search criteria. The routing table
///                 manager uses this identifier to determine which destination and route information to return. For example, if a
///                 client specifies the RIP protocol identifier, the best RIP route is returned, even if a non-RIP route is the best
///                 route to the destination. Specify RTM_BEST_PROTOCOL to return a route regardless of which protocol owns it.
///                 Specify RTM_THIS_PROTOCOL to return the best route for the calling protocol.
///    TargetViews = Specifies the views from which to return information. If the client specifies RTM_VIEW_MASK_ANY, destination
///                  information is returned from all views; however, no view-specific information is returned.
///    DestInfo = On input, <i>DestInfo</i> is a pointer to an RTM_DEST_INFO structure. On output, <i>DestInfo</i> is filled with
///               the requested destination information.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified destination was not found. </td> </tr>
///    </table> <div> </div>
///    
@DllImport("rtm")
uint RtmGetExactMatchDestination(ptrdiff_t RtmRegHandle, RTM_NET_ADDRESS* DestAddress, uint ProtocolId, 
                                 uint TargetViews, RTM_DEST_INFO* DestInfo);

///The <b>RtmGetMostSpecificDestination</b> function searches the routing table for a destination with the exact match
///for a specified network address and subnet mask; if the exact match is not found, the best prefix is matched. The
///destination information is returned.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    DestAddress = Pointer to the destination network address.
///    ProtocolId = Specifies the protocol identifier. The <i>ProtocolID</i> is not part of the search criteria. The routing table
///                 manager uses this identifier to determine which route information to return. For example, if a client specifies
///                 the RIP protocol identifier, the best RIP route is returned, even if a non-RIP route is the best route to the
///                 destination. Specify RTM_BEST_PROTOCOL to return a route regardless of which protocol owns it. Specify
///                 RTM_THIS_PROTOCOL to return the best route for the calling protocol.
///    TargetViews = Specifies the views from which to return information. If the client specifies RTM_VIEW_MASK_ANY, destination
///                  information is returned from all views; however, no view-specific information is returned.
///    DestInfo = On input, <i>DestInfo</i> is a pointer to an RTM_DEST_INFO structure. On output, <i>DestInfo</i> is filled with
///               the requested destination information.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle was invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified destination was not
///    found. </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint RtmGetMostSpecificDestination(ptrdiff_t RtmRegHandle, RTM_NET_ADDRESS* DestAddress, uint ProtocolId, 
                                   uint TargetViews, RTM_DEST_INFO* DestInfo);

///The <b>RtmGetLessSpecificDestination</b> function searches the routing table for a destination with the
///next-best-match (longest) prefix, given a destination prefix. The requested destination information is returned.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    DestHandle = Handle to the destination.
///    ProtocolId = Specifies the protocol identifier. The <i>ProtocolID</i> is not part of the search criteria. The routing table
///                 manager uses this identifier to determine which route information to return. For example, if a client specifies
///                 the RIP protocol identifier, the best RIP route is returned, even if a non-RIP route is the best route to the
///                 destination. Specify RTM_BEST_PROTOCOL to return a route regardless of which protocol owns it. Specify
///                 RTM_THIS_PROTOCOL to return the best route for the calling protocol.
///    TargetViews = Specifies the views from which to return information. If the client specifies RTM_VIEW_MASK_ANY, destination
///                  information is returned from all views; however, no view-specific information is returned.
///    DestInfo = On input, <i>DestInfo</i> is a pointer to an RTM_DEST_INFO structure. On output, <i>DestInfo</i> is filled with
///               the requested destination information.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter contains incorrect information.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The next best
///    destination cannot be found. </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint RtmGetLessSpecificDestination(ptrdiff_t RtmRegHandle, ptrdiff_t DestHandle, uint ProtocolId, uint TargetViews, 
                                   RTM_DEST_INFO* DestInfo);

///The <b>RtmGetExactMatchRoute</b> function searches the routing table for a route that exactly matches the specified
///route. The route to search for is indicated by a network address, subnet mask, and other route-matching criteria. If
///an exact match is found, the route information is returned.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    DestAddress = Pointer to the destination network address.
///    MatchingFlags = Specifies the criteria to use when searching for the route. The following flags are used. <table> <tr>
///                    <th>Constant</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RTM_MATCH_FULL"></a><a
///                    id="rtm_match_full"></a><dl> <dt><b>RTM_MATCH_FULL</b></dt> </dl> </td> <td width="60%"> Match routes with all
///                    criteria. </td> </tr> <tr> <td width="40%"><a id="RTM_MATCH_INTERFACE"></a><a id="rtm_match_interface"></a><dl>
///                    <dt><b>RTM_MATCH_INTERFACE</b></dt> </dl> </td> <td width="60%"> Match routes that are on the same interface.
///                    </td> </tr> <tr> <td width="40%"><a id="RTM_MATCH_NEIGHBOUR"></a><a id="rtm_match_neighbour"></a><dl>
///                    <dt><b>RTM_MATCH_NEIGHBOUR</b></dt> </dl> </td> <td width="60%"> Match routes with the same neighbor. </td> </tr>
///                    <tr> <td width="40%"><a id="RTM_MATCH_NEXTHOP"></a><a id="rtm_match_nexthop"></a><dl>
///                    <dt><b>RTM_MATCH_NEXTHOP</b></dt> </dl> </td> <td width="60%"> Match routes that have the same next hop. </td>
///                    </tr> <tr> <td width="40%"><a id="RTM_MATCH_NONE"></a><a id="rtm_match_none"></a><dl>
///                    <dt><b>RTM_MATCH_NONE</b></dt> </dl> </td> <td width="60%"> Match none of the criteria; all routes for the
///                    destination are returned. </td> </tr> <tr> <td width="40%"><a id="RTM_MATCH_OWNER"></a><a
///                    id="rtm_match_owner"></a><dl> <dt><b>RTM_MATCH_OWNER</b></dt> </dl> </td> <td width="60%"> Match routes with the
///                    same owner. </td> </tr> <tr> <td width="40%"><a id="RTM_MATCH_PREF"></a><a id="rtm_match_pref"></a><dl>
///                    <dt><b>RTM_MATCH_PREF</b></dt> </dl> </td> <td width="60%"> Match routes that have the same preference. </td>
///                    </tr> </table>
///    RouteInfo = On input, <i>RouteInfo</i> is a pointer an RTM_ROUTE_INFO structure that contains the criteria that specifies the
///                route to find. On output, <i>RouteInfo</i> receives the route information for the route that matched the
///                criteria.
///    InterfaceIndex = If RTM_MATCH_INTERFACE is specified in <i>MatchingFlags</i>, <i>InterfaceIndex</i> specifies the interface on
///                     which the route must be present (that is, the route has a next hop on that interface).
///    TargetViews = Specifies the views from which to return information. If the client specifies RTM_VIEW_MASK_ANY, destination
///                  information is returned from all views; however, no view-specific information is returned.
///    RouteHandle = If a handle must be returned: On input, <i>RouteHandle</i> is a pointer to <b>NULL</b>. On output,
///                  <i>RouteHandle</i> receives a pointer to the route handle; otherwise, <i>RouteHandle</i> remains unchanged. If a
///                  handle does not need to be returned: On input, <i>RouteHandle</i> is <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified route was not found. </td> </tr>
///    </table> <div> </div>
///    
@DllImport("rtm")
uint RtmGetExactMatchRoute(ptrdiff_t RtmRegHandle, RTM_NET_ADDRESS* DestAddress, uint MatchingFlags, 
                           RTM_ROUTE_INFO* RouteInfo, uint InterfaceIndex, uint TargetViews, ptrdiff_t* RouteHandle);

///The <b>RtmIsBestRoute</b> function returns the set of views in which the specified route is the best route to a
///destination.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    RouteHandle = Handle to the route to check.
///    BestInViews = Receives a pointer to the set of views for which the specified route is the best route.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. </td> </tr> </table>
///    <div> </div>
///    
@DllImport("rtm")
uint RtmIsBestRoute(ptrdiff_t RtmRegHandle, ptrdiff_t RouteHandle, uint* BestInViews);

///The <b>RtmAddNextHop</b> function adds a new next-hop entry or updates an existing next-hop entry to a client's
///next-hop list. If a next hop already exists, the routing table manager returns a handle to the next hop. This handle
///can then be used to specify a next hop to a destination when adding or updating a route.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    NextHopInfo = Pointer to a structure that contains information identifying the next hop to add or update. The
///                  <b>NextHopOwner</b> and <b>State</b> members are ignored; these members are set by the routing table manager. The
///                  <b>Flags</b> member can be one of the following values. <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr>
///                  <td width="40%"><a id="RTM_NEXTHOP_FLAGS_REMOTE"></a><a id="rtm_nexthop_flags_remote"></a><dl>
///                  <dt><b>RTM_NEXTHOP_FLAGS_REMOTE</b></dt> </dl> </td> <td width="60%"> This next hop points to a remote
///                  destination that is not directly reachable. To obtain the complete path, the client must perform a recursive
///                  lookup. </td> </tr> <tr> <td width="40%"><a id="RTM_NEXTHOP_FLAGS_DOWN"></a><a
///                  id="rtm_nexthop_flags_down"></a><dl> <dt><b>RTM_NEXTHOP_FLAGS_DOWN</b></dt> </dl> </td> <td width="60%"> This
///                  flag is reserved for future use. </td> </tr> </table>
///    NextHopHandle = If the client has a handle (client is updating a next hop): On input, <i>NextHopHandle</i> is a pointer to the
///                    next-hop handle. On output, <i>NextHopHandle</i> is unchanged. If the client does not have a handle and a handle
///                    must be returned (client is adding or updating a next hop): On input, <i>NextHopHandle</i> is a pointer to
///                    <b>NULL</b>. On output, <i>NextHopHandle</i> receives a pointer to the next-hop handle. The values in
///                    <i>NextHopInfo</i> are used to identify the next hop to update. If a handle does not need to be returned (client
///                    is adding or updating a next hop): On input, <i>NextHopHandle</i> is <b>NULL</b>. The values in
///                    <i>NextHopInfo</i> are used to identify the next hop to update.
///    ChangeFlags = On input, <i>ChangeFlags</i> is a pointer to an <b>RTM_NEXTHOP_CHANGE_FLAGS</b> data type. On output,
///                  <i>ChangeFlags</i> receives a flag indicating whether a next hop was added or updated. If <i>ChangeFlags</i> is
///                  zero, a next hop was updated; if <i>ChangeFlags</i> is <b>RTM_NEXTHOP_CHANGE_NEW</b>, a next hop was added.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling client does not own this next hop.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There
///    is not enough memory to complete this operation. </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint RtmAddNextHop(ptrdiff_t RtmRegHandle, RTM_NEXTHOP_INFO* NextHopInfo, ptrdiff_t* NextHopHandle, 
                   uint* ChangeFlags);

///The <b>RtmFindNextHop</b> function finds a specific next hop in a client's next-hop list.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    NextHopInfo = Pointer to an RTM_NEXTHOP_INFO structure that contains information identifying the next hop to find. Use the
///                  <b>NextHopAddress</b> and <b>InterfaceIndex</b> members to identify the next hop to find.
///    NextHopHandle = If a handle must be returned: On input, <i>NextHopPointer</i> is a pointer to <b>NULL</b>. On output, if the
///                    client owns the next hop, <i>NextHopPointer</i> receives a pointer to the next-hop handle; otherwise,
///                    <i>NextHopPointer</i> remains unchanged. If a handle does not need to be returned: On input,
///                    <i>NextHopPointer</i> is <b>NULL</b>.
///    NextHopPointer = If a pointer must be returned: On input, <i>NextHopPointer</i> is a pointer to <b>NULL</b>. On output, if the
///                     client owns the next hop, <i>NextHopPointer</i> receives a pointer to the next-hop; otherwise,
///                     <i>NextHopPointer</i> remains unchanged. If a pointer does not need to be returned: On input,
///                     <i>NextHopPointer</i> is <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling client does not own this next hop.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified
///    next hop was not found. </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint RtmFindNextHop(ptrdiff_t RtmRegHandle, RTM_NEXTHOP_INFO* NextHopInfo, ptrdiff_t* NextHopHandle, 
                    RTM_NEXTHOP_INFO** NextHopPointer);

///The <b>RtmDeleteNextHop</b> function deletes a next hop from the next-hop list.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    NextHopHandle = Handle to the next hop to delete. This parameter is optional and can be set to <b>NULL</b>; if it is <b>NULL</b>,
///                    the values in <i>NextHopInfo</i> are used to identify the next hop to delete.
///    NextHopInfo = Pointer to a structure that contains information identifying the next hop to delete. This parameter is optional
///                  and can be set to <b>NULL</b>; if it is <b>NULL</b>, the handle in <i>NextHopHandle</i> is used to identify the
///                  next hop to delete.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling client does not own this next hop.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There
///    is not enough memory to complete this operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified next hop was not found. </td> </tr>
///    </table> <div> </div>
///    
@DllImport("rtm")
uint RtmDeleteNextHop(ptrdiff_t RtmRegHandle, ptrdiff_t NextHopHandle, RTM_NEXTHOP_INFO* NextHopInfo);

///The <b>RtmGetNextHopPointer</b> function obtains a direct pointer to the specified next hop. The pointer allows the
///next-hop owner direct read access to the routing table manager's RTM_NEXTHOP_INFO structure.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    NextHopHandle = Handle to the next hop.
///    NextHopPointer = If the client is the owner of the next hop, <i>NextHopPointer</i> receives a pointer to the next hop.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling client does not own this next hop.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    handle is invalid. </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint RtmGetNextHopPointer(ptrdiff_t RtmRegHandle, ptrdiff_t NextHopHandle, RTM_NEXTHOP_INFO** NextHopPointer);

///The <b>RtmLockNextHop</b> function locks or unlocks a next hop. This function should be called by the next hop's
///owner to lock the next hop before making changes to the next hop. A pointer to the next hop is returned.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    NextHopHandle = Handle to the next hop to lock or unlock.
///    Exclusive = Specifies whether to lock or unlock the next hop in an exclusive (<b>TRUE</b>) or shared (<b>FALSE</b>) mode.
///    LockNextHop = Specifies whether to lock or unlock the next hop. Specify <b>TRUE</b> to lock the next hop; specify <b>FALSE</b>
///                  to unlock it.
///    NextHopPointer = On input, <i>NextHopPointer</i> is a pointer to <b>NULL</b>. On output, if the client owns the next hop,
///                     <i>NextHopPointer</i> receives a pointer to the next-hop; otherwise, <i>NextHopPointer</i> remains unchanged.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling client does not own this next hop.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified
///    next hop was not found. </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint RtmLockNextHop(ptrdiff_t RtmRegHandle, ptrdiff_t NextHopHandle, BOOL Exclusive, BOOL LockNextHop, 
                    RTM_NEXTHOP_INFO** NextHopPointer);

///The <b>RtmCreateDestEnum</b> function starts an enumeration of the destinations in the routing table. A client can
///enumerate destinations for one or more views, or for all views.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    TargetViews = Specifies the set of views to use when creating the enumeration. The following flags are used. <table> <tr>
///                  <th>Constant</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RTM_VIEW_MASK_ANY"></a><a
///                  id="rtm_view_mask_any"></a><dl> <dt><b>RTM_VIEW_MASK_ANY</b></dt> </dl> </td> <td width="60%"> Return
///                  destinations from all views. This is the default value. </td> </tr> <tr> <td width="40%"><a
///                  id="RTM_VIEW_MASK_UCAST"></a><a id="rtm_view_mask_ucast"></a><dl> <dt><b>RTM_VIEW_MASK_UCAST</b></dt> </dl> </td>
///                  <td width="60%"> Return destinations from the unicast view. </td> </tr> <tr> <td width="40%"><a
///                  id="RTM_VIEW_MASK_MCAST"></a><a id="rtm_view_mask_mcast"></a><dl> <dt><b>RTM_VIEW_MASK_MCAST</b></dt> </dl> </td>
///                  <td width="60%"> Return destinations from the multicast view. </td> </tr> </table>
///    EnumFlags = Specifies which destinations to include in the enumeration. Two sets of flags are used; use one flag from each
///                set (for example, use RTM_ENUM_ALL_DESTS and RTM_ENUM_START). <table> <tr> <th>Constant</th> <th>Meaning</th>
///                </tr> <tr> <td width="40%"><a id="RTM_ENUM_ALL_DESTS"></a><a id="rtm_enum_all_dests"></a><dl>
///                <dt><b>RTM_ENUM_ALL_DESTS</b></dt> </dl> </td> <td width="60%"> Return all destinations. </td> </tr> <tr> <td
///                width="40%"><a id="RTM_ENUM_OWN_DESTS"></a><a id="rtm_enum_own_dests"></a><dl> <dt><b>RTM_ENUM_OWN_DESTS</b></dt>
///                </dl> </td> <td width="60%"> Return destinations for which the client owns the best route to a destination in any
///                of the specified views. </td> </tr> </table> <table> <tr> <th>Constant</th> <th>Meaning</th> </tr> <tr> <td
///                width="40%"><a id="RTM_ENUM_NEXT"></a><a id="rtm_enum_next"></a><dl> <dt><b>RTM_ENUM_NEXT</b></dt> </dl> </td>
///                <td width="60%"> Enumerate destinations starting at the specified address/mask length (such as 10/8). The
///                enumeration continues to the end of the routing table. </td> </tr> <tr> <td width="40%"><a
///                id="RTM_ENUM_RANGE"></a><a id="rtm_enum_range"></a><dl> <dt><b>RTM_ENUM_RANGE</b></dt> </dl> </td> <td
///                width="60%"> Enumerate destinations in the range specified by the address/mask length (such as 10/8). </td> </tr>
///                <tr> <td width="40%"><a id="RTM_ENUM_START"></a><a id="rtm_enum_start"></a><dl> <dt><b>RTM_ENUM_START</b></dt>
///                </dl> </td> <td width="60%"> Enumerate destinations starting at 0/0. Specify <b>NULL</b> for <i>NetAddress</i>.
///                </td> </tr> </table>
///    NetAddress = Pointer to an RTM_NET_ADDRESS structure that contains the starting address of the enumeration. Specify
///                 <b>NULL</b> if <i>EnumFlags</i> contains RTM_ENUM_START.
///    ProtocolId = Specifies the protocol identifier used to determine the best route information returned by the RtmGetEnumDests
///                 function. The <i>ProtocolID</i> is not part of the search criteria. The routing table manager uses this
///                 identifier to determine which route information to return (for example, if a client specifies the RIP protocol
///                 identifier, the best RIP route is returned, even if a non-RIP route is the best route to the destination).
///                 Specify RTM_BEST_PROTOCOL to return a route regardless of which protocol owns it. Specify RTM_THIS_PROTOCOL to
///                 return the best route for the calling protocol.
///    RtmEnumHandle = On input, <i>RtmEnumHandle</i> is a pointer to <b>NULL</b>. On output, <i>RtmEnumHandle</i> receives a pointer to
///                    a handle to the enumeration. Use this handle in all subsequent calls to RtmGetEnumDests, RtmReleaseDests, and
///                    RtmDeleteEnumHandle.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter contains incorrect information.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There
///    is not enough memory to complete this operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> One or more of the specified views is not
///    supported. </td> </tr> </table>
///    
@DllImport("rtm")
uint RtmCreateDestEnum(ptrdiff_t RtmRegHandle, uint TargetViews, uint EnumFlags, RTM_NET_ADDRESS* NetAddress, 
                       uint ProtocolId, ptrdiff_t* RtmEnumHandle);

///The <b>RtmGetEnumDests</b> function retrieves the next set of destinations in the specified enumeration.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    EnumHandle = Handle to the destination enumeration.
///    NumDests = On input, <i>NumDests</i> is a pointer to a <b>UINT</b> value specifying the maximum number of destinations that
///               can be received by <i>DestInfos</i>. On output, <i>NumDests</i> receives the actual number of destinations
///               received by <i>DestInfos</i>.
///    DestInfos = On input, <i>DestInfos</i> is a pointer to an RTM_DEST_INFO structure. On output, <i>DestInfos</i> receives an
///                array of handles to destinations.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The value pointed to by <i>NumRoutes</i> is
///    larger than the maximum number of routes a client is allowed to retrieve with one call. Check RTM_REGN_PROFILE
///    for the maximum number of destinations that the client is allowed to retrieve with one call. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> There are no more destinations
///    to enumerate. </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint RtmGetEnumDests(ptrdiff_t RtmRegHandle, ptrdiff_t EnumHandle, uint* NumDests, RTM_DEST_INFO* DestInfos);

///The <b>RtmReleaseDests</b> function releases the destination handles.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    NumDests = Specifies the number of destinations in <i>DestInfos</i>.
///    DestInfos = Pointer to an array of RTM_DEST_INFO structures to release. The destinations were obtained from a previous call
///                to RtmGetEnumDests.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. </td> </tr> </table>
///    
@DllImport("rtm")
uint RtmReleaseDests(ptrdiff_t RtmRegHandle, uint NumDests, RTM_DEST_INFO* DestInfos);

///The <b>RtmCreateRouteEnum</b> function creates an enumeration of the routes for a particular destination or range of
///destinations in the routing table. A client can enumerate routes for one or more views, or for all views.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    DestHandle = Handle to the destination for which to enumerate routes. This parameter is optional, and can be set to
///                 <b>NULL</b>; specifying <b>NULL</b> enumerates all routes for all destinations. Specify <b>NULL</b> if
///                 <i>EnumFlags</i> contains RTM_ENUM_START.
///    TargetViews = Specifies the set of views to use when creating the enumeration. The following flags are used. <table> <tr>
///                  <th>Constant</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RTM_VIEW_MASK_ANY"></a><a
///                  id="rtm_view_mask_any"></a><dl> <dt><b>RTM_VIEW_MASK_ANY</b></dt> </dl> </td> <td width="60%"> Return
///                  destinations from all views. This is the default value. </td> </tr> <tr> <td width="40%"><a
///                  id="RTM_VIEW_MASK_UCAST"></a><a id="rtm_view_mask_ucast"></a><dl> <dt><b>RTM_VIEW_MASK_UCAST</b></dt> </dl> </td>
///                  <td width="60%"> Return destinations from the unicast view. </td> </tr> <tr> <td width="40%"><a
///                  id="RTM_VIEW_MASK_MCAST"></a><a id="rtm_view_mask_mcast"></a><dl> <dt><b>RTM_VIEW_MASK_MCAST</b></dt> </dl> </td>
///                  <td width="60%"> Return destinations from the multicast view. </td> </tr> </table>
///    EnumFlags = Specifies which routes to include in the enumeration. Two sets of flags are used; use one flag from each set
///                (such as RTM_ENUM_ALL_ROUTES and RTM_ENUM_START). <table> <tr> <th>Constant</th> <th>Meaning</th> </tr> <tr> <td
///                width="40%"><a id="RTM_ENUM_ALL_ROUTES"></a><a id="rtm_enum_all_routes"></a><dl>
///                <dt><b>RTM_ENUM_ALL_ROUTES</b></dt> </dl> </td> <td width="60%"> Return all routes. </td> </tr> <tr> <td
///                width="40%"><a id="RTM_ENUM_OWN_ROUTES"></a><a id="rtm_enum_own_routes"></a><dl>
///                <dt><b>RTM_ENUM_OWN_ROUTES</b></dt> </dl> </td> <td width="60%"> Return only those routes that the client owns.
///                </td> </tr> </table> <table> <tr> <th>Constant</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                id="RTM_ENUM_NEXT"></a><a id="rtm_enum_next"></a><dl> <dt><b>RTM_ENUM_NEXT</b></dt> </dl> </td> <td width="60%">
///                Enumerate routes starting at the specified address/mask length (such as 10/8). The enumeration continues to the
///                end of the routing table. </td> </tr> <tr> <td width="40%"><a id="RTM_ENUM_RANGE"></a><a
///                id="rtm_enum_range"></a><dl> <dt><b>RTM_ENUM_RANGE</b></dt> </dl> </td> <td width="60%"> Enumerate routes in the
///                specified range specified by the address/mask length (such as 10/8). </td> </tr> <tr> <td width="40%"><a
///                id="RTM_ENUM_START"></a><a id="rtm_enum_start"></a><dl> <dt><b>RTM_ENUM_START</b></dt> </dl> </td> <td
///                width="60%"> Enumerate routes starting at 0/0. Specify <b>NULL</b> for <i>NetAddress</i>. </td> </tr> </table>
///    StartDest = Pointer to an RTM_NET_ADDRESS structure that contains the starting address of the enumeration. This parameter is
///                ignored if <i>EnumFlags</i> contains RTM_ENUM_START.
///    MatchingFlags = Specifies the elements of the route to match. Only routes that match the criteria specified in
///                    <i>CriteriaRoute</i> and <i>CriteriaInterface</i> are returned, unless otherwise noted. The following flags are
///                    used. <table> <tr> <th>Constant</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RTM_MATCH_FULL"></a><a
///                    id="rtm_match_full"></a><dl> <dt><b>RTM_MATCH_FULL</b></dt> </dl> </td> <td width="60%"> Match routes with all
///                    criteria. </td> </tr> <tr> <td width="40%"><a id="RTM_MATCH_INTERFACE"></a><a id="rtm_match_interface"></a><dl>
///                    <dt><b>RTM_MATCH_INTERFACE</b></dt> </dl> </td> <td width="60%"> Match routes that are on the same interface. The
///                    client can specify <b>NULL</b> for <i>CriteriaRoute</i>. </td> </tr> <tr> <td width="40%"><a
///                    id="RTM_MATCH_NEIGHBOUR"></a><a id="rtm_match_neighbour"></a><dl> <dt><b>RTM_MATCH_NEIGHBOUR</b></dt> </dl> </td>
///                    <td width="60%"> Match routes with the same neighbor. </td> </tr> <tr> <td width="40%"><a
///                    id="RTM_MATCH_NEXTHOP"></a><a id="rtm_match_nexthop"></a><dl> <dt><b>RTM_MATCH_NEXTHOP</b></dt> </dl> </td> <td
///                    width="60%"> Match routes that have the same next hop. </td> </tr> <tr> <td width="40%"><a
///                    id="RTM_MATCH_NONE"></a><a id="rtm_match_none"></a><dl> <dt><b>RTM_MATCH_NONE</b></dt> </dl> </td> <td
///                    width="60%"> Match none of the criteria; all routes for the destination are returned. The <i>CriteriaRoute</i>
///                    parameter is ignored if this flag is set. </td> </tr> <tr> <td width="40%"><a id="RTM_MATCH_OWNER"></a><a
///                    id="rtm_match_owner"></a><dl> <dt><b>RTM_MATCH_OWNER</b></dt> </dl> </td> <td width="60%"> Match routes with same
///                    owner. </td> </tr> <tr> <td width="40%"><a id="RTM_MATCH_PREF"></a><a id="rtm_match_pref"></a><dl>
///                    <dt><b>RTM_MATCH_PREF</b></dt> </dl> </td> <td width="60%"> Match routes that have the same preference. </td>
///                    </tr> </table>
///    CriteriaRoute = Specifies which routes to enumerate. This parameter is optional and can be set to <b>NULL</b> if
///                    <i>MatchingFlags</i> contains RTM_MATCH_INTERFACE or RTM_MATCH_NONE.
///    CriteriaInterface = Pointer to a <b>ULONG</b> that specifies on which interfaces routes should be located. This parameter is ignored
///                        unless <i>MatchingFlags</i> contains RTM_MATCH_INTERFACE.
///    RtmEnumHandle = On input, <i>RtmEnumHandle</i> is a pointer to <b>NULL</b>. On output, <i>RtmEnumHandle</i> receives a pointer to
///                    a handle to the enumeration. Use this handle in all subsequent calls to RtmGetEnumRoutes, RtmReleaseRoutes, and
///                    RtmDeleteEnumHandle.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter contains incorrect information.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There
///    is not enough memory to complete this operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> One or more of the specified views is not
///    supported. </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint RtmCreateRouteEnum(ptrdiff_t RtmRegHandle, ptrdiff_t DestHandle, uint TargetViews, uint EnumFlags, 
                        RTM_NET_ADDRESS* StartDest, uint MatchingFlags, RTM_ROUTE_INFO* CriteriaRoute, 
                        uint CriteriaInterface, ptrdiff_t* RtmEnumHandle);

///The <b>RtmGetEnumRoutes</b> function retrieves the next set of routes in the specified enumeration.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    EnumHandle = Handle to the route enumeration.
///    NumRoutes = On input, <i>NumRoutes</i> is a pointer to a <b>UINT</b> value that specifies the maximum number of routes that
///                can be received by <i>RouteHandles</i>. On output, <i>NumRoutes</i> receives the actual number of routes received
///                by <i>RouteHandles</i>.
///    RouteHandles = On input, <i>RouteHandles</i> is a pointer to an RTM_ROUTE_INFO structure. On output, <i>RouteHandles</i>
///                   receives an array of handles to routes.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The value pointed to by <i>NumRoutes</i> is
///    larger than the maximum number of routes a client is allowed to retrieve with one call. Check RTM_REGN_PROFILE
///    for the maximum number of routes that the client is allowed to retrieve with one call. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> There are no more routes to
///    enumerate. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> There is not enough memory to complete this operation. </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint RtmGetEnumRoutes(ptrdiff_t RtmRegHandle, ptrdiff_t EnumHandle, uint* NumRoutes, ptrdiff_t* RouteHandles);

///The <b>RtmReleaseRoutes</b> function releases the route handles.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    NumRoutes = Specifies the number of routes in <i>RouteHandles</i>.
///    RouteHandles = Pointer to an array of route handles to release. The handles were obtained with a previous call to
///                   RtmGetEnumRoutes.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. </td> </tr> </table>
///    <div> </div>
///    
@DllImport("rtm")
uint RtmReleaseRoutes(ptrdiff_t RtmRegHandle, uint NumRoutes, ptrdiff_t* RouteHandles);

///The <b>RtmCreateNextHopEnum</b> enumerates the next hops in the next-hop list.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    EnumFlags = Specifies which next hops to include in the enumeration. The following flags are used. <table> <tr>
///                <th>Constant</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RTM_ENUM_NEXT"></a><a
///                id="rtm_enum_next"></a><dl> <dt><b>RTM_ENUM_NEXT</b></dt> </dl> </td> <td width="60%"> Enumerate next hops
///                starting at the specified address/mask length (such as 10/8). The enumeration continues to the end of the next
///                hop list. </td> </tr> <tr> <td width="40%"><a id="RTM_ENUM_RANGE"></a><a id="rtm_enum_range"></a><dl>
///                <dt><b>RTM_ENUM_RANGE</b></dt> </dl> </td> <td width="60%"> Enumerate next hops in the specified range specified
///                by the address/mask length (such as 10/8). </td> </tr> <tr> <td width="40%"><a id="RTM_ENUM_START"></a><a
///                id="rtm_enum_start"></a><dl> <dt><b>RTM_ENUM_START</b></dt> </dl> </td> <td width="60%"> Enumerate next hops
///                starting at 0/0. Specify <b>NULL</b> for <i>NetAddress</i>. </td> </tr> </table>
///    NetAddress = Pointer to an RTM_NET_ADDRESS structure that contains the starting address of the enumeration. Specify
///                 <b>NULL</b> if <i>EnumFlags</i> contains RTM_ENUM_START.
///    RtmEnumHandle = On input, <i>RtmEnumHandle</i> is a pointer to <b>NULL</b>. On output, <i>RtmEnumHandle</i> receives a pointer to
///                    a handle to the enumeration. Use this handle in all subsequent calls to RtmGetEnumNextHops, RtmReleaseNextHops,
///                    and RtmDeleteEnumHandle.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter contains incorrect information.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There
///    is not enough memory to complete this operation. </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint RtmCreateNextHopEnum(ptrdiff_t RtmRegHandle, uint EnumFlags, RTM_NET_ADDRESS* NetAddress, 
                          ptrdiff_t* RtmEnumHandle);

///The <b>RtmGetEnumNextHops</b> function retrieves the next set of next hops in the specified enumeration.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    EnumHandle = Handle to the next-hop enumeration.
///    NumNextHops = On input, <i>NumNextHops</i> is a pointer to a <b>UINT</b> value specifying the maximum number of next hops that
///                  can be received by <i>NextHopHandles</i>. On output, <i>NumNextHops</i> receives the actual number of next hops
///                  received by <i>NextHopHandles</i>.
///    NextHopHandles = On input, <i>NextHopHandles</i> pointers to an RTM_NEXTHOP_INFO structure. On output, <i>NextHopHandles</i>
///                     receives an array of handles to next hops.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The value pointed to by <i>NumRoutes</i> is
///    larger than the maximum number of routes a client is allowed to retrieve with one call. Check RTM_REGN_PROFILE
///    for the maximum number of next hops that the client is allowed to retrieve with one call. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> There are no more next hops to
///    enumerate. </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint RtmGetEnumNextHops(ptrdiff_t RtmRegHandle, ptrdiff_t EnumHandle, uint* NumNextHops, ptrdiff_t* NextHopHandles);

///The <b>RtmReleaseNextHops</b> function releases the next-hop handles.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    NumNextHops = Specifies the number of next hops in <i>NextHopHandles</i>.
///    NextHopHandles = Pointer to an array of next-hop handles to release. The handles were obtained with a previous call to
///                     RtmGetEnumNextHops.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. </td> </tr> </table>
///    <div> </div>
///    
@DllImport("rtm")
uint RtmReleaseNextHops(ptrdiff_t RtmRegHandle, uint NumNextHops, ptrdiff_t* NextHopHandles);

///The <b>RtmDeleteEnumHandle</b> function deletes the specified enumeration handle and frees all resources allocated
///for the enumeration.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    EnumHandle = Handle to be released. Any resources associated with the handle are also freed.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. </td> </tr> </table>
///    <div> </div>
///    
@DllImport("rtm")
uint RtmDeleteEnumHandle(ptrdiff_t RtmRegHandle, ptrdiff_t EnumHandle);

///The <b>RtmRegisterForChangeNotification</b> function informs the routing table manager that the client should receive
///change notifications for the specified types of changes. The routing table manager returns a change notification
///handle, which the client must use when requesting change information after receiving a change notification message.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    TargetViews = Specifies the views in which to register for change notification.
///    NotifyFlags = Specifies the flags that indicate the type of changes for which the client requests notification. The following
///                  flags are used. (The flags are to be joined using a logical OR.) <table> <tr> <th>Constant</th> <th>Meaning</th>
///                  </tr> <tr> <td width="40%"><a id="RTM_CHANGE_TYPE_ALL"></a><a id="rtm_change_type_all"></a><dl>
///                  <dt><b>RTM_CHANGE_TYPE_ALL</b></dt> </dl> </td> <td width="60%"> Notify the client of any change to a
///                  destination. </td> </tr> <tr> <td width="40%"><a id="RTM_CHANGE_TYPE_BEST"></a><a
///                  id="rtm_change_type_best"></a><dl> <dt><b>RTM_CHANGE_TYPE_BEST</b></dt> </dl> </td> <td width="60%"> Notify the
///                  client of changes to the current best route, or when the best route changes. </td> </tr> <tr> <td width="40%"><a
///                  id="RTM_CHANGE_TYPE_FORWARDING"></a><a id="rtm_change_type_forwarding"></a><dl>
///                  <dt><b>RTM_CHANGE_TYPE_FORWARDING</b></dt> </dl> </td> <td width="60%"> Notify the client of any best route
///                  changes that affect forwarding, such as next hop changes. </td> </tr> <tr> <td width="40%"><a
///                  id="RTM_NOTIFY_ONLY_MARKED_DESTS"></a><a id="rtm_notify_only_marked_dests"></a><dl>
///                  <dt><b>RTM_NOTIFY_ONLY_MARKED_DESTS</b></dt> </dl> </td> <td width="60%"> Notify the client of changes to
///                  destinations that the client has marked. If this flag is not specified, change notification messages for all
///                  destinations are sent. </td> </tr> </table>
///    NotifyContext = Specifies the notification context that the RTM_EVENT_CALLBACK uses to indicate new changes. The notification
///                    context is the <i>Context2</i> parameter of the <b>RTM_EVENT_CALLBACK</b> callback.
///    NotifyHandle = Receives a handle to a change notification. The handle must be used when calling RtmGetChangedDests.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter contains incorrect information.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SYSTEM_RESOURCES</b></dt> </dl> </td> <td width="60%">
///    There are not enough available system resources to complete this operation. The routing table manager has
///    exceeded the maximum number of change notifications that can be cached. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to complete this
///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td
///    width="60%"> One or more of the specified views is not supported. </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint RtmRegisterForChangeNotification(ptrdiff_t RtmRegHandle, uint TargetViews, uint NotifyFlags, 
                                      void* NotifyContext, ptrdiff_t* NotifyHandle);

///The <b>RtmGetChangedDests</b> function returns a set of destinations with changed information.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    NotifyHandle = Handle to a change notification obtained from a previous call to RtmRegisterForChangeNotification.
///    NumDests = On input, <i>NumDests</i> is a pointer to a <b>UINT</b> value that specifies the maximum number of destinations
///               that can be received by <i>ChangedDests</i>. On output, <i>NumDests</i> receives the actual number of
///               destinations received by <i>ChangedDests</i>.
///    ChangedDests = On input, <i>ChangedDests</i> is a pointer to an array of RTM_DEST_INFO structures. On output,
///                   <i>ChangedDests</i> is filled with the changed destination information.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter contains incorrect information.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> No more
///    changed destinations to retrieve. </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint RtmGetChangedDests(ptrdiff_t RtmRegHandle, ptrdiff_t NotifyHandle, uint* NumDests, 
                        RTM_DEST_INFO* ChangedDests);

///The <b>RtmReleaseChangedDests</b> function releases the changed destination handles.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    NotifyHandle = Handle to a change notification, obtained from a previous call to RtmRegisterForChangeNotification.
///    NumDests = Specifies the number of destinations in <i>ChangedDests</i>.
///    ChangedDests = Pointer to an array of RTM_DEST_INFO structures to release. The changed destinations were obtained from a prior
///                   call to RtmGetChangedDests.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. </td> </tr> </table>
///    <div> </div>
///    
@DllImport("rtm")
uint RtmReleaseChangedDests(ptrdiff_t RtmRegHandle, ptrdiff_t NotifyHandle, uint NumDests, 
                            RTM_DEST_INFO* ChangedDests);

///The <b>RtmIgnoreChangedDests</b> function skips the next change for each destination if it has already occurred. This
///function can be used after RtmGetChangeStatus to prevent the routing table manager returning this change in response
///to a call to RtmGetChangedDests.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    NotifyHandle = Handle to a change notification.
///    NumDests = Specifies the number of destinations in <i>ChangedDests</i>.
///    ChangedDests = Pointer to an array of <b>RTM_DEST_HANDLE</b> handles that indicate the destinations for which to ignore any
///                   pending changes.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. </td> </tr> </table>
///    
@DllImport("rtm")
uint RtmIgnoreChangedDests(ptrdiff_t RtmRegHandle, ptrdiff_t NotifyHandle, uint NumDests, ptrdiff_t* ChangedDests);

///The <b>RtmGetChangeStatus</b> function checks whether there are pending changes that have not been retrieved with
///RtmGetChangedDests.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    NotifyHandle = Handle to a change notification.
///    DestHandle = Handle to the destination for which to return change status.
///    ChangeStatus = On input, <i>ChangeStatus</i> is a pointer to a <b>BOOL</b> value. On output, <i>ChangeStatus</i> receives either
///                   <b>TRUE</b> or <b>FALSE</b> to indicate if the destination specified by <i>DestHandle</i> has a change
///                   notification pending.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. </td> </tr> </table>
///    <div> </div>
///    
@DllImport("rtm")
uint RtmGetChangeStatus(ptrdiff_t RtmRegHandle, ptrdiff_t NotifyHandle, ptrdiff_t DestHandle, BOOL* ChangeStatus);

///The <b>RtmMarkDestForChangeNotification</b> function marks a destination for a client. A marked destination indicates
///to the routing table manager that it should send the client change notification messages for the marked destination.
///The client receives change notification messages when a destination changes. The change notifications inform the
///client of changes to best-route information for the specified destination. This function should be used when
///RtmRegisterForChangeNotification is called to request changes for specific destinations
///(RTM_NOTIFY_ONLY_MARKED_DESTS).
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    NotifyHandle = Handle to a change notification obtained via a previous call to RtmRegisterForChangeNotification.
///    DestHandle = Handle to the destination that the client is marking for notification of changes.
///    MarkDest = Specifies whether to mark a destination and receive change notifications. Specify <b>TRUE</b> to mark a
///               destination and start receive change notifications for the specified destination. Specify <b>FALSE</b> to stop
///               receiving change notifications a previously marked destination.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. </td> </tr> </table>
///    <div> </div>
///    
@DllImport("rtm")
uint RtmMarkDestForChangeNotification(ptrdiff_t RtmRegHandle, ptrdiff_t NotifyHandle, ptrdiff_t DestHandle, 
                                      BOOL MarkDest);

///The <b>RtmIsMarkedForChangeNotification</b> function queries the routing table manager to determine if a destination
///has previously been marked by a call to RtmMarkDestForChangeNotification.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    NotifyHandle = Handle to a change notification, obtained from a previous call to RtmRegisterForChangeNotification.
///    DestHandle = Handle to the destination to check.
///    DestMarked = Pointer to a <b>BOOL</b> variable that is <b>TRUE</b> if the destination is marked, <b>FALSE</b> if it is not.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. </td> </tr> </table>
///    
@DllImport("rtm")
uint RtmIsMarkedForChangeNotification(ptrdiff_t RtmRegHandle, ptrdiff_t NotifyHandle, ptrdiff_t DestHandle, 
                                      BOOL* DestMarked);

///The <b>RtmDeregisterFromChangeNotification</b> function unregisters a client from change notification and frees all
///resources allocated to the notification.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterForChangeNotification.
///    NotifyHandle = Handle to the change notification to unregister that is obtained from a previous call to
///                   RtmRegisterForChangeNotification.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. </td> </tr> </table>
///    <div> </div>
///    
@DllImport("rtm")
uint RtmDeregisterFromChangeNotification(ptrdiff_t RtmRegHandle, ptrdiff_t NotifyHandle);

///The <b>RtmCreateRouteList</b> function creates a list in which the caller can keep a copy of the routes it owns.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    RouteListHandle = On input, <i>RouteListHandle</i> is a pointer to <b>NULL</b>. On output, <i>RouteListHandle</i> receives a
///                      pointer to a handle to the new route list.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to complete this
///    operation. </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint RtmCreateRouteList(ptrdiff_t RtmRegHandle, ptrdiff_t* RouteListHandle);

///The <b>RtmInsertInRouteList</b> function inserts the specified set of routes into the client's route list. If a route
///is already in another list, the route is removed from the old list and inserted into the new one.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    RouteListHandle = Handle to the route list to which to add routes. Specify <b>NULL</b> to remove the specified routes from their
///                      old lists.
///    NumRoutes = Specifies the number of routes in <i>RouteHandles</i>.
///    RouteHandles = Pointer to an array of route handles to move from the old list to the new list.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. </td> </tr> </table>
///    
@DllImport("rtm")
uint RtmInsertInRouteList(ptrdiff_t RtmRegHandle, ptrdiff_t RouteListHandle, uint NumRoutes, 
                          ptrdiff_t* RouteHandles);

///The <b>RtmCreateRouteListEnum</b> function creates an enumeration of routes on the specified route list.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    RouteListHandle = Handle to the route list to enumerate that is obtained from a previous call to RtmCreateRouteList.
///    RtmEnumHandle = On input, <i>RtmEnumHandle</i> is a pointer to <b>NULL</b>. On output, <i>RtmEnumHandle</i> receives a pointer to
///                    a handle to the enumeration. Use this handle in all subsequent calls to functions that enumerate the list of
///                    routes.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to complete this
///    operation. </td> </tr> </table> <div> </div>
///    
@DllImport("rtm")
uint RtmCreateRouteListEnum(ptrdiff_t RtmRegHandle, ptrdiff_t RouteListHandle, ptrdiff_t* RtmEnumHandle);

///The <b>RtmGetListEnumRoutes</b> function enumerates a set of routes in a specified route list.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    EnumHandle = Handle to the route list to enumerate.
///    NumRoutes = On input, <i>NumRoutes</i> is a pointer to a <b>UINT</b> value that specifies the maximum number of routes that
///                can be received by <i>RouteHandles</i>. On output, <i>NumRoutes</i> receives the actual number of routes received
///                by <i>RouteHandles</i>.
///    RouteHandles = On input, <i>DestInfo</i> is a pointer to an array of RTM_DEST_INFO structures. On output, <i>DestInfo</i> is
///                   filled with the requested destination information.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The value pointed to by <i>NumRoutes</i> is
///    larger than the maximum number of routes a client is allowed to retrieve with one call. Check RTM_REGN_PROFILE
///    for the maximum number of routes that the client is allowed to retrieve with one call. </td> </tr> </table> <div>
///    </div>
///    
@DllImport("rtm")
uint RtmGetListEnumRoutes(ptrdiff_t RtmRegHandle, ptrdiff_t EnumHandle, uint* NumRoutes, ptrdiff_t* RouteHandles);

///The <b>RtmDeleteRouteList</b> function removes all routes from a client-specific route list, then frees any resources
///allocated to the list.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    RouteListHandle = Handle to the route list to delete.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. </td> </tr> </table>
///    <div> </div>
///    
@DllImport("rtm")
uint RtmDeleteRouteList(ptrdiff_t RtmRegHandle, ptrdiff_t RouteListHandle);

///The <b>RtmReferenceHandles</b> function increases the reference count for objects pointed to by one or more handles
///that the routing manager used to access those objects. A client should use this function when the client must keep a
///handle but release the rest of the information structure associated with the handle.
///Params:
///    RtmRegHandle = Handle to the client obtained from a previous call to RtmRegisterEntity.
///    NumHandles = Specifies the number of handles in <i>RtmHandles</i>.
///    RtmHandles = Array of handles to increase the reference count for.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle is invalid. </td> </tr> </table>
///    <div> </div>
///    
@DllImport("rtm")
uint RtmReferenceHandles(ptrdiff_t RtmRegHandle, uint NumHandles, HANDLE* RtmHandles);


