// Written in the D programming language.

module windows.systemeventnotificationservice;

public import windows.core;
public import windows.automation : BSTR, IDispatch;
public import windows.com : HRESULT;
public import windows.systemservices : BOOL;

extern(Windows):


// Structs


///The <b>QOCINFO</b> structure is returned by the IsDestinationReachable function and provides Quality of Connection
///information to the caller.
struct QOCINFO
{
    ///Upon calling IsDestinationReachable, the caller must specify the size of the <b>QOCINFO</b> structure being
    ///provided to the function using dwSize. The size should be specified in bytes. Upon return from
    ///IsDestinationReachable, dwSize contains the size of the provided structure in bytes.
    uint dwSize;
    ///Provides information on the type of network connection available. The following table lists the possible values.
    ///<table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="NETWORK_ALIVE_LAN"></a><a
    ///id="network_alive_lan"></a><dl> <dt><b>NETWORK_ALIVE_LAN</b></dt> <dt>0x00000001</dt> </dl> </td> <td
    ///width="60%"> The computer has one or more active LAN cards. </td> </tr> <tr> <td width="40%"><a
    ///id="NETWORK_ALIVE_WAN"></a><a id="network_alive_wan"></a><dl> <dt><b>NETWORK_ALIVE_WAN</b></dt>
    ///<dt>0x00000002</dt> </dl> </td> <td width="60%"> The computer has one or more active RAS connections. </td> </tr>
    ///<tr> <td width="40%"><a id="NETWORK_ALIVE_AOL"></a><a id="network_alive_aol"></a><dl>
    ///<dt><b>NETWORK_ALIVE_AOL</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%"> This flag is not supported.
    ///</td> </tr> </table>
    uint dwFlags;
    ///Speed of data coming in from the destination in bytes per second.
    uint dwInSpeed;
    ///Speed of data sent to the destination in bytes per second.
    uint dwOutSpeed;
}

///The <b>SENS_QOCINFO</b> structure is used by the ISensNetwork::ConnectionMade method. This structure contains Quality
///of Connection information to the sink object in an application that subscribes to SENS.
struct SENS_QOCINFO
{
    ///This member contains the actual size of the structure that was filled in.
    uint dwSize;
    ///Speed of connection. Flag bits indicate whether the connection is slow, medium, fast.
    uint dwFlags;
    ///Speed of data sent to the destination in bits per second.
    uint dwOutSpeed;
    ///Speed of data coming in from the destination in bits per second.
    uint dwInSpeed;
}

// Functions

///The <b>IsDestinationReachable</b> function determines whether or not a specified destination can be reached, and
///provides Quality of Connection (QOC) information for a destination. <b>Windows Vista and later, Windows Server 2008
///and later: </b>This function is not supported and always returns <b>ERROR_CALL_NOT_IMPLEMENTED</b>.
///Params:
///    lpszDestination = A pointer to a <b>null</b>-terminated string that specifies a destination. The destination can be an IP address,
///                      UNC name, or URL.
///    lpQOCInfo = A pointer to the QOCINFO structure that receives the Quality of Connection (QOC) information. You can supply a
///                <b>NULL</b> pointer if you do not want to receive the QOC information.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>TRUE</b></dt>
///    </dl> </td> <td width="60%"> A destination can be reached. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>FALSE</b></dt> </dl> </td> <td width="60%"> A destination cannot be reached. To get extended error
///    information, call GetLastError. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CALL_NOT_IMPLEMENTED</b></dt>
///    </dl> </td> <td width="60%"> This function is not available on Windows Vista. </td> </tr> </table>
///    
@DllImport("SensApi")
BOOL IsDestinationReachableA(const(char)* lpszDestination, QOCINFO* lpQOCInfo);

///The <b>IsDestinationReachable</b> function determines whether or not a specified destination can be reached, and
///provides Quality of Connection (QOC) information for a destination. <b>Windows Vista and later, Windows Server 2008
///and later: </b>This function is not supported and always returns <b>ERROR_CALL_NOT_IMPLEMENTED</b>.
///Params:
///    lpszDestination = A pointer to a <b>null</b>-terminated string that specifies a destination. The destination can be an IP address,
///                      UNC name, or URL.
///    lpQOCInfo = A pointer to the QOCINFO structure that receives the Quality of Connection (QOC) information. You can supply a
///                <b>NULL</b> pointer if you do not want to receive the QOC information.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>TRUE</b></dt>
///    </dl> </td> <td width="60%"> A destination can be reached. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>FALSE</b></dt> </dl> </td> <td width="60%"> A destination cannot be reached. To get extended error
///    information, call GetLastError. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CALL_NOT_IMPLEMENTED</b></dt>
///    </dl> </td> <td width="60%"> This function is not available on Windows Vista. </td> </tr> </table>
///    
@DllImport("SensApi")
BOOL IsDestinationReachableW(const(wchar)* lpszDestination, QOCINFO* lpQOCInfo);

///The <b>IsNetworkAlive</b> function determines whether or not a local system is connected to a network, and identifies
///the type of network connection, for example, a LAN, WAN, or both.
///Params:
///    lpdwFlags = The type of network connection that is available. This parameter can be one of the following values:
///Returns:
///    Always call GetLastError before checking the return code of this function. If the last error is not 0, the
///    <b>IsNetworkAlive</b> function has failed and the following <b>TRUE</b> and <b>FALSE</b> values do not apply.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>TRUE</b></dt>
///    </dl> </td> <td width="60%"> If the last error is 0 and the function returns <b>TRUE</b>, SENS has determined
///    that a local system is connected to a network. For information about the type of connection, see the
///    <i>lpdwFlags</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FALSE</b></dt> </dl> </td> <td
///    width="60%"> If the last error is 0 and the function returns <b>FALSE</b>, SENS has determined there is no
///    connection. </td> </tr> </table>
///    
@DllImport("SensApi")
BOOL IsNetworkAlive(uint* lpdwFlags);


// Interfaces

@GUID("D597CAFE-5B9F-11D1-8DD2-00AA004ABD5E")
struct SENS;

///The <b>ISensNetwork</b> interface handles network events fired by the System Event Notification Service (SENS).
@GUID("D597BAB1-5B9F-11D1-8DD2-00AA004ABD5E")
interface ISensNetwork : IDispatch
{
    ///The <b>ConnectionMade</b> method notifies your application that the specified connection has been established.
    ///<div class="alert"><b>Note</b> This method is only available for TCP/IP connections.</div><div> </div>
    ///Params:
    ///    bstrConnection = For WAN connections, the information passed is the connection name. For WAN connections, the connection name
    ///                     is the name of the phone book entry. For LAN connections, the information passed is "LAN connection".
    ///    ulType = Connection type. This value can be CONNECTION_LAN (0) or CONNECTION_WAN (1).
    ///    lpQOCInfo = Pointer to the SENS_QOCINFO structure which contains Quality of Connection information.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method returned successfully. </td>
    ///    </tr> </table>
    ///    
    HRESULT ConnectionMade(BSTR bstrConnection, uint ulType, SENS_QOCINFO* lpQOCInfo);
    ///The <b>ConnectionMadeNoQOCInfo</b> method notifies your application that the specified connection has been
    ///established with no Quality of Connection information available. <div class="alert"><b>Note</b> This method is
    ///only available for TCP/IP connections.</div><div> </div>
    ///Params:
    ///    bstrConnection = For WAN connections, the information passed is the connection name. For WAN connections, the connection name
    ///                     is the name of the phone book entry. For LAN connections, the information passed is "LAN connection".
    ///    ulType = Connection type. This value can be CONNECTION_LAN (0) or CONNECTION_WAN (1).
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method returned successfully. </td>
    ///    </tr> </table>
    ///    
    HRESULT ConnectionMadeNoQOCInfo(BSTR bstrConnection, uint ulType);
    ///The <b>ConnectionLost</b> method notifies your application that the specified connection has been dropped. <div
    ///class="alert"><b>Note</b> This method is only available for TCP/IP connections.</div><div> </div>
    ///Params:
    ///    bstrConnection = For WAN connections, the information passed is the connection name. For WAN connections, the connection name
    ///                     is the name of the phone book entry. For LAN connections, the information passed is "LAN connection".
    ///    ulType = Connection type. This value can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///             </tr> <tr> <td width="40%"><a id="CONNECTION_LAN"></a><a id="connection_lan"></a><dl>
    ///             <dt><b>CONNECTION_LAN</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The connection is to a Local Area
    ///             Network (LAN). </td> </tr> <tr> <td width="40%"><a id="CONNECTION_WAN"></a><a id="connection_wan"></a><dl>
    ///             <dt><b>CONNECTION_WAN</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The connection is to a Wide Area
    ///             Network (WAN). </td> </tr> </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method returned successfully. </td>
    ///    </tr> </table>
    ///    
    HRESULT ConnectionLost(BSTR bstrConnection, uint ulType);
    HRESULT DestinationReachable(BSTR bstrDestination, BSTR bstrConnection, uint ulType, SENS_QOCINFO* lpQOCInfo);
    HRESULT DestinationReachableNoQOCInfo(BSTR bstrDestination, BSTR bstrConnection, uint ulType);
}

///The <b>ISensOnNow</b> interface handles AC and battery power events fired by the System Event Notification Service
///(SENS).
@GUID("D597BAB2-5B9F-11D1-8DD2-00AA004ABD5E")
interface ISensOnNow : IDispatch
{
    ///SENS calls the <b>OnACPower</b> method to notify your application that the computer is using AC power.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method returned successfully. </td>
    ///    </tr> </table>
    ///    
    HRESULT OnACPower();
    ///SENS calls the <b>OnBatteryPower</b> method to notify an application that a computer is using battery power.
    ///Params:
    ///    dwBatteryLifePercent = The percent of battery power that remains.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method returns successfully.
    ///    </td> </tr> </table>
    ///    
    HRESULT OnBatteryPower(uint dwBatteryLifePercent);
    ///The <b>BatteryLow</b> method notifies an application that battery power is low. SENS calls the <b>BatteryLow</b>
    ///method to notify an application that a computer is using battery power. Low battery power is signaled when a
    ///system is on battery power and the battery is low according to the same logic used by the Advanced Power
    ///Management (APM) event PBT_APMBATTERYLOW. This event is broadcast when a system APM BIOS sends an APM battery low
    ///notification. Some APM BIOS implementations do not provide notifications when batteries are low, which means that
    ///this event may never be broadcast on some computers.
    ///Params:
    ///    dwBatteryLifePercent = The percent of battery power that remains.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method returns successfully.
    ///    </td> </tr> </table>
    ///    
    HRESULT BatteryLow(uint dwBatteryLifePercent);
}

///The <b>ISensLogon</b> interface handles logon events fired by SENS.
@GUID("D597BAB3-5B9F-11D1-8DD2-00AA004ABD5E")
interface ISensLogon : IDispatch
{
    ///The <b>Logon</b> method notifies an application that a user is logged on.
    ///Params:
    ///    bstrUserName = The name of a user who is logged on.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method returns successfully.
    ///    </td> </tr> </table>
    ///    
    HRESULT Logon(BSTR bstrUserName);
    ///The <b>Logoff</b> method notifies an application that a user is logged off.
    ///Params:
    ///    bstrUserName = The name of a user who logs off.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method returns successfully.
    ///    </td> </tr> </table>
    ///    
    HRESULT Logoff(BSTR bstrUserName);
    ///The <b>StartShell</b> method notifies an application that the shell is started.
    ///Params:
    ///    bstrUserName = The name of a current user.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method returns successfully.
    ///    </td> </tr> </table>
    ///    
    HRESULT StartShell(BSTR bstrUserName);
    ///The <b>DisplayLock</b> method notifies an application that the screen display is locked.
    ///Params:
    ///    bstrUserName = The name of a current user.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method returns successfully.
    ///    </td> </tr> </table>
    ///    
    HRESULT DisplayLock(BSTR bstrUserName);
    ///The <b>DisplayUnLock</b> method notifies an application that the screen display is unlocked.
    ///Params:
    ///    bstrUserName = The name of a current user.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method returns successfully.
    ///    </td> </tr> </table>
    ///    
    HRESULT DisplayUnlock(BSTR bstrUserName);
    ///The <b>StartScreenSaver</b> method notifies an application that a screen saver is started.
    ///Params:
    ///    bstrUserName = The name of a current user.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method returns successfully.
    ///    </td> </tr> </table>
    ///    
    HRESULT StartScreenSaver(BSTR bstrUserName);
    ///The <b>StopScreenSaver</b> method notifies an application that a screen saver is stopped.
    ///Params:
    ///    bstrUserName = The name of a current user.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method returns successfully.
    ///    </td> </tr> </table>
    ///    
    HRESULT StopScreenSaver(BSTR bstrUserName);
}

///The <b>ISensLogon2</b> interface handles logon events fired by SENS.
@GUID("D597BAB4-5B9F-11D1-8DD2-00AA004ABD5E")
interface ISensLogon2 : IDispatch
{
    ///The <b>Logon</b> method notifies an application that a user is logged on.
    ///Params:
    ///    bstrUserName = The name of a user who is logged on.
    ///    dwSessionId = The session identifier of a session.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method returns successfully.
    ///    </td> </tr> </table>
    ///    
    HRESULT Logon(BSTR bstrUserName, uint dwSessionId);
    ///The <b>Logoff</b> method notifies an application that a user is logged off.
    ///Params:
    ///    bstrUserName = The name of a user who logs off.
    ///    dwSessionId = The session identifier of a session.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method returns successfully.
    ///    </td> </tr> </table>
    ///    
    HRESULT Logoff(BSTR bstrUserName, uint dwSessionId);
    ///The <b>SessionDisconnect</b> method is used to disconnect from a Fast User Switching session or a Remote Desktop
    ///Connection. This is different from logging off from a session, because when you use this method the session is
    ///disconnected.
    ///Params:
    ///    bstrUserName = The name of a current user.
    ///    dwSessionId = The session identifier of a session.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method returns successfully.
    ///    </td> </tr> </table>
    ///    
    HRESULT SessionDisconnect(BSTR bstrUserName, uint dwSessionId);
    ///The session was reconnected. The <b>SessionReconnect</b> method is used when you reconnect to a Fast User
    ///Switching session or a Remote Desktop Connection. This is different from logging on to a new session.
    ///Params:
    ///    bstrUserName = Name of the current user.
    ///    dwSessionId = The session identifier of the session.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method returned successfully. </td>
    ///    </tr> </table>
    ///    
    HRESULT SessionReconnect(BSTR bstrUserName, uint dwSessionId);
    ///Use the <b>PostShell</b> method when a user has logged on and Windows Explorer is running. This method is
    ///different from the Logon method because <b>Logon</b> is called after logon when the Shell may not yet be running.
    ///Params:
    ///    bstrUserName = Name of the current user.
    ///    dwSessionId = The session identifier of the session.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method returned successfully. </td>
    ///    </tr> </table>
    ///    
    HRESULT PostShell(BSTR bstrUserName, uint dwSessionId);
}


// GUIDs

const GUID CLSID_SENS = GUIDOF!SENS;

const GUID IID_ISensLogon   = GUIDOF!ISensLogon;
const GUID IID_ISensLogon2  = GUIDOF!ISensLogon2;
const GUID IID_ISensNetwork = GUIDOF!ISensNetwork;
const GUID IID_ISensOnNow   = GUIDOF!ISensOnNow;
