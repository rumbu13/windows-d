// Written in the D programming language.

module windows.upnp;

public import windows.core;
public import windows.automation : BSTR, IDispatch, VARIANT;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : BOOL;

extern(Windows):


// Interfaces

@GUID("4C1FC63A-695C-47E8-A339-1A194BE3D0B8")
struct UIAnimationManager;

@GUID("D25D8842-8884-4A4A-B321-091314379BDD")
struct UIAnimationManager2;

@GUID("1D6322AD-AA85-4EF5-A828-86D71067D145")
struct UIAnimationTransitionLibrary;

@GUID("812F944A-C5C8-4CD9-B0A6-B3DA802F228D")
struct UIAnimationTransitionLibrary2;

@GUID("8A9B1CDD-FCD7-419C-8B44-42FD17DB1887")
struct UIAnimationTransitionFactory;

@GUID("84302F97-7F7B-4040-B190-72AC9D18E420")
struct UIAnimationTransitionFactory2;

@GUID("BFCD4A0C-06B6-4384-B768-0DAA792C380E")
struct UIAnimationTimer;

@GUID("E2085F28-FEB7-404A-B8E7-E659BDEAAA02")
struct UPnPDeviceFinder;

@GUID("B9E84FFD-AD3C-40A4-B835-0882EBCBAAA8")
struct UPnPDevices;

@GUID("A32552C5-BA61-457A-B59A-A2561E125E33")
struct UPnPDevice;

@GUID("C0BC4B4A-A406-4EFC-932F-B8546B8100CC")
struct UPnPServices;

@GUID("C624BA95-FBCB-4409-8C03-8CCEEC533EF1")
struct UPnPService;

@GUID("1D8A9B47-3A28-4CE2-8A4B-BD34E45BCEEB")
struct UPnPDescriptionDocument;

@GUID("181B54FC-380B-4A75-B3F1-4AC45E9605B0")
struct UPnPDeviceFinderEx;

@GUID("33FD0563-D81A-4393-83CC-0195B1DA2F91")
struct UPnPDescriptionDocumentEx;

@GUID("204810B9-73B2-11D4-BF42-00B0D0118B56")
struct UPnPRegistrar;

@GUID("2E5E84E9-4049-4244-B728-2D24227157C7")
struct UPnPRemoteEndpointInfo;

///The <b>IUPnPDeviceFinder</b> interface enables an application to find a device.
@GUID("ADDA3D55-6F72-4319-BFF9-18600A539B10")
interface IUPnPDeviceFinder : IDispatch
{
    ///The <b>FindByType</b> method searches synchronously for devices by device type or service type.
    ///Params:
    ///    bstrTypeURI = Specifies the type URI for the device or service type for which to search.
    ///    dwFlags = Must be zero. This parameter is reserved for future use.
    ///    pDevices = Receives a reference to a collection of IUPnPDevices devices that were found.
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, the method returns one of the COM error codes
    ///    defined in WinError.h.
    ///    
    HRESULT FindByType(BSTR bstrTypeURI, uint dwFlags, IUPnPDevices* pDevices);
    ///The <b>CreateAsyncFind</b> method creates an asynchronous search operation.
    ///Params:
    ///    bstrTypeURI = Specifies the uniform resource identifier (URI) for which to search.
    ///    dwFlags = Specify zero. This parameter is reserved for future use.
    ///    punkDeviceFinderCallback = Reference to an IUnknown interface object that specifies the callback that the UPnP framework must use to
    ///                               communicate the results of this asynchronous search. The object referred to by <i>pUnkCallback</i> must
    ///                               support either the IUPnPDeviceFinderCallback interface or the IDispatch interface. The object referred to by
    ///                               <i>pUnkCallback</i> might support the IUPnPDeviceFinderAddCallbackWithInterface interface, in addition to the
    ///                               <b>IUPnPDeviceFinderCallback</b> interface.
    ///    plFindData = Reference to a <b>LONG</b> that receives the identifier for this particular search. The application must
    ///                 supply this identifier to other asynchronous search methods that are called.
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, the method returns one of the COM error codes
    ///    defined in WinError.h.
    ///    
    HRESULT CreateAsyncFind(BSTR bstrTypeURI, uint dwFlags, IUnknown punkDeviceFinderCallback, int* plFindData);
    ///The <b>StartAsyncFind</b> method starts an asynchronous search operation.
    ///Params:
    ///    lFindData = Specifies the search to start. The value of <i>lFindData</i> is the value returned by a previous call to
    ///                IUPnPDeviceFinder::CreateAsyncFind.
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, the method returns one of the COM error codes
    ///    defined in WinError.h.
    ///    
    HRESULT StartAsyncFind(int lFindData);
    ///The <b>CancelAsyncFind</b> method cancels an asynchronous search.
    ///Params:
    ///    lFindData = Specifies the search to cancel. The value of <i>lFindData</i> is the value returned by a previous call to
    ///                IUPnPDeviceFinder::CreateAsyncFind.
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, the method returns one of the COM error codes
    ///    defined in WinError.h.
    ///    
    HRESULT CancelAsyncFind(int lFindData);
    ///The <b>FindByUDN</b> method searches synchronously for a device by its unique device name (UDN).
    ///Params:
    ///    bstrUDN = Specifies the UDN for which to search. This value is case sensitive, and should be provided as lower-case
    ///              (e.g. uuid:e8f85dfd-ff...).
    ///    pDevice = Receives a reference to an IUPnPDevice object that contains the requested device. Receives <b>NULL</b> if the
    ///              specified device is not found.
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, the method returns S_FALSE.
    ///    
    HRESULT FindByUDN(BSTR bstrUDN, IUPnPDevice* pDevice);
}

///The <b>IUPnPAddressFamilyControl</b> interface accesses the address family flag of the Device Finder object.
@GUID("E3BF6178-694E-459F-A5A6-191EA0FFA1C7")
interface IUPnPAddressFamilyControl : IUnknown
{
    ///The <b>SetAddressFamily</b> method sets the address family flag of the Device Finder object, which uses this flag
    ///to filter the devices found. The application sets the address family flag before starting a search. The
    ///application will be notified only about devices that have IP addresses that are of the specified address family.
    ///Params:
    ///    dwFlags = Integer (4-byte value) that specifies the address family to be used by the Device Finder object to filter the
    ///              devices found. The following values are valid. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///              width="40%"><a id="UPNP_ADDRESSFAMILY_IPv4"></a><a id="upnp_addressfamily_ipv4"></a><a
    ///              id="UPNP_ADDRESSFAMILY_IPV4"></a><dl> <dt><b>UPNP_ADDRESSFAMILY_IPv4</b></dt> </dl> </td> <td width="60%">
    ///              IPv4 (IP version 4) </td> </tr> <tr> <td width="40%"><a id="UPNP_ADDRESSFAMILY_IPv6"></a><a
    ///              id="upnp_addressfamily_ipv6"></a><a id="UPNP_ADDRESSFAMILY_IPV6"></a><dl>
    ///              <dt><b>UPNP_ADDRESSFAMILY_IPv6</b></dt> </dl> </td> <td width="60%"> IPv6 (IP version 6) </td> </tr> <tr> <td
    ///              width="40%"><a id="UPNP_ADDRESSFAMILY_BOTH"></a><a id="upnp_addressfamily_both"></a><dl>
    ///              <dt><b>UPNP_ADDRESSFAMILY_BOTH</b></dt> </dl> </td> <td width="60%"> IPv4 and IPv6 </td> </tr> </table>
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, the method returns one of the COM error codes
    ///    defined in WinError.h.
    ///    
    HRESULT SetAddressFamily(int dwFlags);
    ///The <b>GetAddressFamily</b> method retrieves the current value of the address family flag of the Device Finder
    ///object.
    ///Params:
    ///    pdwFlags = Pointer to an integer (4-byte value) that indicates the address family. The following values are valid.
    ///               <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///               id="UPNP_ADDRESSFAMILY_IPv4"></a><a id="upnp_addressfamily_ipv4"></a><a id="UPNP_ADDRESSFAMILY_IPV4"></a><dl>
    ///               <dt><b>UPNP_ADDRESSFAMILY_IPv4</b></dt> </dl> </td> <td width="60%"> IPv4 (IP version 4) </td> </tr> <tr> <td
    ///               width="40%"><a id="UPNP_ADDRESSFAMILY_IPv6"></a><a id="upnp_addressfamily_ipv6"></a><a
    ///               id="UPNP_ADDRESSFAMILY_IPV6"></a><dl> <dt><b>UPNP_ADDRESSFAMILY_IPv6</b></dt> </dl> </td> <td width="60%">
    ///               IPv6 (IP version 6) </td> </tr> <tr> <td width="40%"><a id="UPNP_ADDRESSFAMILY_BOTH"></a><a
    ///               id="upnp_addressfamily_both"></a><dl> <dt><b>UPNP_ADDRESSFAMILY_BOTH</b></dt> </dl> </td> <td width="60%">
    ///               IPv4 and IPv6 </td> </tr> </table>
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, the method returns one of the COM error codes
    ///    defined in WinError.h.
    ///    
    HRESULT GetAddressFamily(int* pdwFlags);
}

///The <b>IUPnPHttpHeaderControl</b> interface enables the caller to specify additional HTTP headers sent in HTTP
///requests to a device.
@GUID("0405AF4F-8B5C-447C-80F2-B75984A31F3C")
interface IUPnPHttpHeaderControl : IUnknown
{
    ///The IUPnPHttpHeaderControl::<b>AddRequestHeaders</b> method adds the supplied HTTP header to an HTTP request.
    ///Params:
    ///    bstrHttpHeaders = String value that contains the HTTP header to attach to the request. For example, "User-Agent:
    ///                      DLNADOC/1.50\r\n". <div class="alert"><b>Note</b> For Windows 7 and Windows Server 2008 R2, only the User
    ///                      Agent HTTP header is supported.</div> <div> </div>
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, the method returns one of the COM error codes
    ///    defined in WinError.h.
    ///    
    HRESULT AddRequestHeaders(BSTR bstrHttpHeaders);
}

///The <b>IUPnPDeviceFinderCallback</b> interface allows the UPnP framework to communicate the results of an
///asynchronous search to an application.
@GUID("415A984A-88B3-49F3-92AF-0508BEDF0D6C")
interface IUPnPDeviceFinderCallback : IUnknown
{
    ///The <b>DeviceAdded</b> method is invoked by the UPnP framework to notify the application that a device has been
    ///added to the network.
    ///Params:
    ///    lFindData = Specifies the search for which the UPnP framework is returning results. The value of <i>lFindData</i> is the
    ///                value returned to the caller by IUPnPDeviceFinder::CreateAsyncFind.
    ///    pDevice = Reference to a IUPnPDevice object that contains the new device.
    ///Returns:
    ///    The UPnP framework does not expect the application to return any specific value; any value returned is
    ///    ignored by the UPnP framework.
    ///    
    HRESULT DeviceAdded(int lFindData, IUPnPDevice pDevice);
    ///The <b>DeviceRemoved</b> method is invoked by the UPnP framework to notify the application that a device has been
    ///removed from the network.
    ///Params:
    ///    lFindData = Specifies the search for which the UPnP framework is returning results. The value of <i>lFindData</i> is the
    ///                value returned to the caller by IUPnPDeviceFinder::CreateAsyncFind.
    ///    bstrUDN = Specifies the UDN of the device that was removed from the network.
    ///Returns:
    ///    The application should return S_OK.
    ///    
    HRESULT DeviceRemoved(int lFindData, BSTR bstrUDN);
    ///The <b>SearchComplete</b> method is invoked by the UPnP framework to notify the application that the initial
    ///search for network devices has been completed. This method is invoked when the UPnP framework has finished
    ///sending IUPnPDeviceFinderCallback::DeviceAdded or
    ///IUPnPDeviceFinderAddCallbackWithInterface::DeviceAddedWithInterface callbacks for all devices that were present
    ///on the network at the time the search was started. These callbacks reflect the state of the network at the time
    ///the search was started.
    ///Params:
    ///    lFindData = Specifies the search for which the UPnP framework is returning results. The value of <i>lFindData</i> is the
    ///                value returned to the caller by IUPnPDeviceFinder::CreateAsyncFind.
    ///Returns:
    ///    The application should return S_OK.
    ///    
    HRESULT SearchComplete(int lFindData);
}

///The <b>IUPnPServices</b> interface enumerates a collection of services.
@GUID("3F8C8E9E-9A7A-4DC8-BC41-FF31FA374956")
interface IUPnPServices : IDispatch
{
    ///The <b>Count</b> property specifies the number of services in the collection.
    ///Params:
    ///    plCount = Receives a reference to the number of services in the collection.
    ///Returns:
    ///    For C++: If this property's "get" method succeeds, the return value is S_OK. Otherwise, the method returns
    ///    one of the COM error codes defined in WinError.h, or one of the following UPnP-specific return values.
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_DOCUMENT_INVALID</b></dt> </dl> </td> <td width="60%"> The service description contained an
    ///    error. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>UPNP_E_EVENT_SUBSCRIPTION_FAILED</b></dt> </dl> </td>
    ///    <td width="60%"> Failed to subscribe to the event source. </td> </tr> </table>
    ///    
    HRESULT get_Count(int* plCount);
    ///The <b>_NewEnum</b> property specifies either the IEnumVARIANT or IEnumUnknown enumerator interface for the
    ///collection.
    ///Params:
    ///    ppunk = Receives a reference to the enumerator interface.
    ///Returns:
    ///    For C++: If this property's "get" method succeeds, the return value is S_OK. Otherwise, the method returns
    ///    one of the COM error codes defined in WinError.h, or one of the following UPnP-specific return values.
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_DOCUMENT_INVALID</b></dt> </dl> </td> <td width="60%"> The service description contained an
    ///    error. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>UPNP_E_EVENT_SUBSCRIPTION_FAILED</b></dt> </dl> </td>
    ///    <td width="60%"> Failed to subscribe to the event source. </td> </tr> </table>
    ///    
    HRESULT get__NewEnum(IUnknown* ppunk);
    ///The <b>Item</b> property specifies the IUPnPService interface for a service, identified by the service ID, in the
    ///collection.
    ///Params:
    ///    bstrServiceId = Specifies a service in the collection.
    ///    ppService = Receives a reference to an IUPnPService interface for the specified service.
    ///Returns:
    ///    For C++: If this property's "get" method succeeds, the return value is S_OK. Otherwise, the method returns
    ///    one of the COM error codes defined in WinError.h, or one of the following UPnP-specific return values.
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_DOCUMENT_INVALID</b></dt> </dl> </td> <td width="60%"> The service description contained an
    ///    error. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>UPNP_E_EVENT_SUBSCRIPTION_FAILED</b></dt> </dl> </td>
    ///    <td width="60%"> Failed to subscribe to the event source. </td> </tr> </table>
    ///    
    HRESULT get_Item(BSTR bstrServiceId, IUPnPService* ppService);
}

///The <b>IUPnPService</b> interface enables an application to query state variables and invoke actions on an instance
///of a service.
@GUID("A295019C-DC65-47DD-90DC-7FE918A1AB44")
interface IUPnPService : IDispatch
{
    ///The <b>QueryStateVariable</b> method returns the value of the specified service's state variable.
    ///Params:
    ///    bstrVariableName = Specifies the state variable for which to return a value.
    ///    pValue = Receives a reference to the value of the variable specified by <i>bstrVariableName</i>. The type of the data
    ///             returned depends on the state variable for which the query was invoked. To free this parameter, use
    ///             VariantClear.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns either one of the COM
    ///    error codes defined in WinError.h or one of the UPnP-specific return values listed in the following table.
    ///    Some of these values indicate that an error was received from a UPnP-certified device. For more information,
    ///    see Device Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>UPNP_E_DEVICE_ERROR</b></dt> </dl> </td> <td width="60%"> The variable is not evented and the
    ///    remote query returned an error code. This is not a transport error; the device received the request, but it
    ///    returned an error. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>UPNP_E_DEVICE_TIMEOUT</b></dt> </dl> </td>
    ///    <td width="60%"> The device has not responded within the 30 second time-out period. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>UPNP_E_INVALID_VARIABLE</b></dt> </dl> </td> <td width="60%"> The variable does not
    ///    exist. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>UPNP_E_PROTOCOL_ERROR</b></dt> </dl> </td> <td
    ///    width="60%"> The query did not complete because of problems at the UPnP protocol level. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>UPNP_E_TRANSPORT_ERROR</b></dt> </dl> </td> <td width="60%"> The variable is not
    ///    evented and the remote query for the value failed because of an HTTP problem. To retrieve the HTTP error
    ///    code, use IUPnPService::LastTransportStatus. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_VARIABLE_VALUE_UNKNOWN</b></dt> </dl> </td> <td width="60%"> The variable is evented, but the
    ///    UPnP software cannot return a value because it is still waiting for an event notification. </td> </tr>
    ///    </table>
    ///    
    HRESULT QueryStateVariable(BSTR bstrVariableName, VARIANT* pValue);
    ///The <b>InvokeAction</b> method invokes a method on the device.
    ///Params:
    ///    bstrActionName = Specifies the method to invoke.
    ///    vInActionArgs = Specifies an array of input arguments to the method. If the action has no input arguments, this parameter
    ///                    must contain an empty array. The contents of this array are service-specific.
    ///    pvOutActionArgs = On input, contains a reference to an empty array. On output, receives a reference to the array of output
    ///                      arguments. If the action has no output arguments, this parameter contains an empty array. The contents of
    ///                      this parameter are service-specific. Free this parameter with VariantClear.
    ///    pvRetVal = On input, contains a reference to an empty array. On output, receives a reference to a <b>VARIANT</b> that
    ///               contains the return value of this action. If the device returns an error after the action is invoked on it
    ///               and this parameter is not set to <b>NULL</b>, this parameter will contain specific text describing the error
    ///               upon return. For more information on the errors returned by devices, please refer to the Device Error Codes
    ///               documentation. Free this parameter with VariantClear.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns one of the COM error
    ///    codes defined in WinError.h or one of the UPnP-specific return values shown in the following table. Some of
    ///    these values indicate that an error was received from a UPnP-certified device. For more information, see
    ///    Device Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_ACTION_REQUEST_FAILED</b></dt> </dl> </td> <td width="60%"> The device had an internal error;
    ///    the request could not be executed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>UPNP_E_DEVICE_ERROR</b></dt>
    ///    </dl> </td> <td width="60%"> An unknown error occurred. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_DEVICE_TIMEOUT</b></dt> </dl> </td> <td width="60%"> The device has not responded within the 30
    ///    second time-out period. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_ERROR_PROCESSING_RESPONSE</b></dt> </dl> </td> <td width="60%"> The device has sent a response
    ///    that cannot be processed; for example, the response was corrupted. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_INVALID_ACTION</b></dt> </dl> </td> <td width="60%"> The action is not supported by the device.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>UPNP_E_INVALID_ARGUMENTS</b></dt> </dl> </td> <td width="60%">
    ///    One or more of the arguments passed in <i>vInActionArgs</i> is invalid. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>UPNP_E_PROTOCOL_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred at the UPnP
    ///    control-protocol level. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>UPNP_E_TRANSPORT_ERROR</b></dt> </dl>
    ///    </td> <td width="60%"> An HTTP error occurred. Use the IUPnPService::LastTransportStatus property to obtain
    ///    the actual HTTP status code. <div class="alert"><b>Note</b> This error code is also returned when the SOAP
    ///    response exceeds 100 kilobytes.</div> <div> </div> </td> </tr> </table>
    ///    
    HRESULT InvokeAction(BSTR bstrActionName, VARIANT vInActionArgs, VARIANT* pvOutActionArgs, VARIANT* pvRetVal);
    ///The <b>ServiceTypeIdentifier</b> property specifies the service type identifier for the device.
    ///Params:
    ///    pVal = Receives a reference to a string that contains the service type identifier. Release this string with
    ///           SysFreeString when it is no longer required.
    ///Returns:
    ///    For C++: If this property's "get" method succeeds, the return value is S_OK. Otherwise, the method returns
    ///    one of the COM error codes defined in WinError.h.
    ///    
    HRESULT get_ServiceTypeIdentifier(BSTR* pVal);
    ///The <b>AddCallback</b> method registers an application's callback with the UPnP framework.
    ///Params:
    ///    pUnkCallback = Specifies the reference to the interface that contains the callback to register. The object referred to by
    ///                   <i>pUnkCallback</i> must either support the IUPnPServiceCallback interface or the IDispatch interface.
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, the method returns one of the COM error codes
    ///    defined in WinError.h.
    ///    
    HRESULT AddCallback(IUnknown pUnkCallback);
    ///The <b>Id</b> property specifies the service ID for the service.
    ///Params:
    ///    pbstrId = Receives a reference to the service ID. Release this string with SysFreeString when it is no longer
    ///              required..
    ///Returns:
    ///    For C++: If this property's "get" method succeeds, the return value is S_OK. Otherwise, the method returns
    ///    one of the COM error codes defined in WinError.h.
    ///    
    HRESULT get_Id(BSTR* pbstrId);
    ///For queries related to evented variables, the <b>LastTransportStatus</b> property specifies the HTTP status of
    ///the last IUPnPService::InvokeAction operation. For queries related to non-evented variables, the
    ///<b>LastTransportStatus</b> property specifies the last IUPnPService::QueryStateVariable operation, if the caller
    ///invoked a query for a non-evented variable.
    ///Params:
    ///    plValue = Receives a reference to the status. If <i>plValue</i> is the HTTP status 200, the operation was successful.
    ///Returns:
    ///    For C++: If this property's "get" method succeeds, the return value is S_OK. Otherwise, the method returns
    ///    one of the COM error codes defined in WinError.h.
    ///    
    HRESULT get_LastTransportStatus(int* plValue);
}

///The IUPnPAsyncResult interface is used to notify the UPnP control point of a completed asynchronous I/O operation.
@GUID("4D65FD08-D13E-4274-9C8B-DD8D028C8644")
interface IUPnPAsyncResult : IUnknown
{
    ///The <b>AsyncOperationComplete</b> callback method provides notification of the completion of an asynchronous I/O
    ///operation.
    ///Params:
    ///    ullRequestID = The handle identifier corresponding to the completed asynchronous I/O operation.
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, the method returns one of the COM error codes
    ///    defined in WinError.h
    ///    
    HRESULT AsyncOperationComplete(ulong ullRequestID);
}

///Use this interface to asynchronously query state variables and invoke actions on an instance of a service . This
///interface can be obtained through a QueryInterface off the IUPnPService object.
@GUID("098BDAF5-5EC1-49E7-A260-B3A11DD8680C")
interface IUPnPServiceAsync : IUnknown
{
    ///The <b>BeginInvokeAction</b> method invokes an action on a device in asynchronous mode. Additionally, if a
    ///delayed SCPD download and event subscription is opted-in, and it has not taken place already, this method will
    ///initiate SCPD download.
    ///Params:
    ///    bstrActionName = Specifies the method to invoke.
    ///    vInActionArgs = Specifies an array of input arguments to the method. If the action has no input arguments, this parameter
    ///                    must contain an empty array. The contents of this array are service-specific.
    ///    pAsyncResult = Pointer to a IUPnPAsyncResult object. When the <b>BeginInvokeAction</b> call is complete, UPnP will use the
    ///                   IUPnPAsyncResult::AsyncOperationComplete method to notify the control point.
    ///    pullRequestID = Pointer to a 64-bit <b>ULONG</b> value used to identify the asynchronous I/O operation. The control point
    ///                    must use this handle as a cookie while ending or cancelling this operation with EndInvokeAction.
    ///Returns:
    ///    Returns <b>S_OK</b> on success. Otherwise, the method returns a COM error code defined in <b>WinError.h</b>
    ///    or one of the following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_PENDING</b></dt> </dl> </td> <td width="60%"> Another async operation is being
    ///    done on this IUPnPServiceAsync object. Create another <b>IUPnPServiceAsync</b> instance or cancel the running
    ///    operation by using IUPnPServiceAsync::CancelAsyncOperation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Failed to initiate the operation. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>UPNP_E_INVALID_ACTION</b></dt> </dl> </td> <td width="60%"> This action is not
    ///    supported by the device. </td> </tr> </table> <div class="alert"><b>Note</b> Some values can indicate that an
    ///    error was received from a UPnP-certified device. For more information, see Device Error Codes.</div> <div>
    ///    </div>
    ///    
    HRESULT BeginInvokeAction(BSTR bstrActionName, VARIANT vInActionArgs, IUPnPAsyncResult pAsyncResult, 
                              ulong* pullRequestID);
    ///The <b>EndInvokeAction</b> method retrieves the results of a previous BeginInvokeAction operation and retrieves
    ///the resultant output arguments.
    ///Params:
    ///    ullRequestID = On input, contains a reference to an empty array. On output, receives a reference to the array of
    ///                   service-specific output arguments. In the event the action doesn't have output arguments, this parameter
    ///                   contains an empty array. <div class="alert"><b>Note</b> Clear this parameter with VariantClear.</div> <div>
    ///                   </div>
    ///    pvOutActionArgs = On input contains a reference to an empty array. On output, receives a reference to a VARIANT that contains
    ///                      the return value of the invoked action. <div class="alert"><b>Note</b> Clear this parameter with
    ///                      VariantClear.</div> <div> </div>
    ///    pvRetVal = A 64-bit <b>ULONG</b> value that corresponds to the BeginInvokeAction operation initiated prior to this call.
    ///Returns:
    ///    Returns <b>S_OK</b> on success. Otherwise, the method returns a COM error code defined in <b>WinError.h</b>
    ///    or one of the following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>UPNP_E_DEVICE_TIMEOUT</b></dt> </dl> </td> <td width="60%"> The device has not
    ///    responded within the 30 second time-out period. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_DEVICE_ERROR</b></dt> </dl> </td> <td width="60%"> An unknown error has occurred. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>UPNP_E_INVALID_ARGUMENTS</b></dt> </dl> </td> <td width="60%"> One or more
    ///    of the arguments passed is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_INVALID_ACTION</b></dt> </dl> </td> <td width="60%"> This action is not supported by the
    ///    device. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>UPNP_E_ERROR_PROCESSING_RESPONSE</b></dt> </dl> </td>
    ///    <td width="60%"> The device has sent a response that cannot be processed; for example, the response was
    ///    corrupted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>UPNP_E_PROTOCOL_ERROR</b></dt> </dl> </td> <td
    ///    width="60%"> An error occurred at the UPnP control-protocol level. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_TRANSPORT_ERROR</b></dt> </dl> </td> <td width="60%"> An HTTP error occurred. Use the
    ///    IUPnPService::LastTransportStatus property to obtain the actual HTTP status code. <div
    ///    class="alert"><b>Note</b> This error code is also returned when the SOAP response exceeds 100 kilobytes.
    ///    </div> <div> </div> </td> </tr> </table> <div class="alert"><b>Note</b> Some values can indicate that an
    ///    error was received from a UPnP-certified device. For more information, see Device Error Codes.</div> <div>
    ///    </div>
    ///    
    HRESULT EndInvokeAction(ulong ullRequestID, VARIANT* pvOutActionArgs, VARIANT* pvRetVal);
    ///The <b>BeginQueryStateVariable</b> method initiates an asynchronous request for the state variable value from a
    ///specific service. Additionally, if opt-in is indicated for a delayed Service Control Protocol Description (SCPD)
    ///download and event subscription, and it has not taken place already, this method will initiate SCPD download and
    ///event subscription.
    ///Params:
    ///    bstrVariableName = Specifies the requested state variable value.
    ///    pAsyncResult = Pointer to a IUPnPAsyncResult object. When the <b>BeginQueryStateVariable</b> call is complete, UPnP will use
    ///                   the IUPnPAsyncResult::AsyncOperationComplete method to notify the control point.
    ///    pullRequestID = Pointer to a 64-bit <b>ULONG</b> value used to identify the asynchronous I/O operation. The UPnP control
    ///                    point must use this handle when ending or cancelling this operation with EndQueryStateVariable.
    ///Returns:
    ///    Returns <b>S_OK</b> on success. Otherwise, the method returns a COM error code defined in <b>WinError.h</b>
    ///    or one of the following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Failed to initiate the asynchronous
    ///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>UPNP_E_INVALID_VARIABLE</b></dt> </dl> </td> <td
    ///    width="60%"> The requested state variable, indicated by <i>bstrVariableName</i>, does not exist. </td> </tr>
    ///    </table> <div class="alert"><b>Note</b> Some values can indicate that an error was received from a
    ///    UPnP-certified device. For more information, see Device Error Codes.</div> <div> </div>
    ///    
    HRESULT BeginQueryStateVariable(BSTR bstrVariableName, IUPnPAsyncResult pAsyncResult, ulong* pullRequestID);
    ///The <b>EndQueryStateVariable</b> method retrieves the results of a previous BeginQueryStateVariable operation and
    ///retrieves the resultant service-specific state variable value.
    ///Params:
    ///    ullRequestID = Pointer to a 64-bit <b>ULONG</b> value that corresponds to the BeginQueryStateVariable operation initiated
    ///                   prior to this call.
    ///    pValue = On input, contains an empty array. On output, receives a reference to the value of the variable specified in
    ///             BeginQueryStateVariable by <i>bstrVariableName</i>. The type of the data returned depends on the state
    ///             variable for which the query was invoked. <div class="alert"><b>Note</b> Clear this parameter with
    ///             VariantClear.</div> <div> </div>
    ///Returns:
    ///    Returns <b>S_OK</b> on success. Otherwise, the method returns a COM error code defined in <b>WinError.h</b>
    ///    or one of the following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>UPNP_E_DEVICE_ERROR</b></dt> </dl> </td> <td width="60%"> The state variable is not
    ///    evented and the remote query returned an error code. This is not a transport error; the device received the
    ///    request, but it returned an error. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_INVALID_VARIABLE</b></dt> </dl> </td> <td width="60%"> The requested state variable does not
    ///    exist. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>UPNP_E_DEVICE_TIMEOUT</b></dt> </dl> </td> <td
    ///    width="60%"> The device has not responded within the 30 second time-out period. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>UPNP_E_INVALID_ARGUMENTS</b></dt> </dl> </td> <td width="60%"> One or more of the
    ///    arguments passed with <i>vInActionArgs</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_PROTOCOL_ERROR</b></dt> </dl> </td> <td width="60%"> The query did not complete because of
    ///    problems at the UPnP protocol level. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_TRANSPORT_ERROR</b></dt> </dl> </td> <td width="60%"> The state variable is not evented and the
    ///    remote query for the value failed because of an HTTP problem. To retrieve the HTTP error code, use
    ///    IUPnPService::LastTransportStatus. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_VARIABLE_VALUE_UNKNOWN</b></dt> </dl> </td> <td width="60%"> The state variable is evented, but
    ///    the UPnP software cannot return a value because it is still waiting for an event notification. </td> </tr>
    ///    </table> <div class="alert"><b>Note</b> Some values can indicate that an error was received from a
    ///    UPnP-certified device. For more information, see Device Error Codes.</div> <div> </div>
    ///    
    HRESULT EndQueryStateVariable(ulong ullRequestID, VARIANT* pValue);
    ///The <b>BeginSubscribeToEvents</b> initiates event subscription in asynchronous mode and registers the application
    ///callback with the UPnP framework.
    ///Params:
    ///    pUnkCallback = Specifies the reference to the interface object that contains the callback to register. This object must
    ///                   either support the IUPnPServiceCallback interface or the IDispatch interface.
    ///    pAsyncResult = Specifies a reference to IUPnPAsyncResult object. When the <b>BeginSubscribeToEvents</b> call is complete,
    ///                   UPnP will use the IUPnPAsyncResult::AsyncOperationComplete method to notify the control point.
    ///    pullRequestID = Pointer to a 64-bit <b>ULONG</b> value used to identify the asynchronous I/O operation. The control point
    ///                    must use this handle while ending or cancelling the operation via EndSubscribeToEvents or
    ///                    CancelAsyncOperation.
    ///Returns:
    ///    Returns <b>S_OK</b> on success. Otherwise, the method returns a COM error code defined in <b>WinError.h</b>
    ///    or one of the following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Failed to initiate the asynchronous
    ///    operation. </td> </tr> </table> <div class="alert"><b>Note</b> Some values can indicate that an error was
    ///    received from a UPnP-certified device. For more information, see Device Error Codes.</div> <div> </div>
    ///    
    HRESULT BeginSubscribeToEvents(IUnknown pUnkCallback, IUPnPAsyncResult pAsyncResult, ulong* pullRequestID);
    ///The <b>EndSubscribeToEvents</b> method retrieves the results of a previous BeginSubscribeToEvents operation.
    ///Params:
    ///    ullRequestID = A 64-bit <b>ULONG</b> value that corresponds to the BeginSubscribeToEvents operation requested prior to this
    ///                   call.
    ///Returns:
    ///    Returns <b>S_OK</b> on success. Otherwise, the method returns a COM error code defined in <b>WinError.h</b>
    ///    or one of the following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>UPNP_E_DEVICE_ERROR</b></dt> </dl> </td> <td width="60%"> The device received the
    ///    request, but returned an error. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>UPNP_E_DEVICE_TIMEOUT</b></dt>
    ///    </dl> </td> <td width="60%"> The device has not responded within the 30 second time-out period. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>UPNP_E_PROTOCOL_ERROR</b></dt> </dl> </td> <td width="60%"> The query did
    ///    not complete due to problems at the UPnP protocol level. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_TRANSPORT_ERROR</b></dt> </dl> </td> <td width="60%"> The remote operation failed due to an
    ///    HTTP problem. To retrieve the HTTP error code, use IUPnPService::LastTransportStatus. </td> </tr> </table>
    ///    <div class="alert"><b>Note</b> Some values can indicate that an error was received from a UPnP-certified
    ///    device. For more information, see Device Error Codes.</div> <div> </div>
    ///    
    HRESULT EndSubscribeToEvents(ulong ullRequestID);
    ///The <b>BeginSCPDDownload</b> method initiates the asynchronous download of an Service Control Protocol
    ///Description (SCPD) document.
    ///Params:
    ///    pAsyncResult = Specifies a pointer to an IUPnPAsyncResult object. When the <b>BeginSCPDDownload</b> call is complete, UPnP
    ///                   will use the IUPnPAsyncResult::AsyncOperationComplete method to notify the control point.
    ///    pullRequestID = Pointer to a 64-bit <b>ULONG</b> value used to identify the <b>BeginSCPDDownload</b> operation requested
    ///                    prior to this call.
    ///Returns:
    ///    Returns <b>S_OK</b> on success. Otherwise, the method returns a COM error code defined in <b>WinError.h</b>
    ///    or one of the following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Failed to initiate the SCPD download.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>pAsyncResult</i> is invalid. </td> </tr> </table>
    ///    
    HRESULT BeginSCPDDownload(IUPnPAsyncResult pAsyncResult, ulong* pullRequestID);
    ///The <b>EndSCPDDownload</b> method retrieves the results of a previous asynchronous download of an Service Control
    ///Protocol Description (SCPD) document.
    ///Params:
    ///    ullRequestID = Pointer to a 64-bit <b>ULONG</b> value that corresponds to the BeginSCPDDownload operation requested prior to
    ///                   this call.
    ///    pbstrSCPDDoc = A buffer containing the SCPD document.
    ///Returns:
    ///    Returns <b>S_OK</b> on success. Otherwise, the method returns a COM error code defined in <b>WinError.h</b>
    ///    or one of the following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Failed to finalize the SCPD download
    ///    and retrieve the document string. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> <i>ullRequestID</i> does not match the pending async call. </td> </tr> </table>
    ///    
    HRESULT EndSCPDDownload(ulong ullRequestID, BSTR* pbstrSCPDDoc);
    ///The <b>CancelAsyncOperation</b> method cancels a pending asynchronous operation initiated by the
    ///BeginInvokeAction, BeginQueryStateVariable, BeginSubscribeToEvents, or BeginSCPDDownload methods.
    ///Params:
    ///    ullRequestID = A 64-bit <b>ULONG</b> value that corresponds to the pending asynchronous UPnP operation.
    ///Returns:
    ///    Returns <b>S_OK</b> on success. Otherwise, the method returns a COM error code defined in <b>WinError.h</b>
    ///    or one of the following values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Failed to cancel the asynchronous
    ///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>ullRequestID</i> does not match the pending asynchronous call. </td> </tr> </table>
    ///    
    HRESULT CancelAsyncOperation(ulong ullRequestID);
}

///The <b>IUPnPServiceCallback</b> interface is used to send event notifications to clients of Service objects.
@GUID("31FADCA9-AB73-464B-B67D-5C1D0F83C8B8")
interface IUPnPServiceCallback : IUnknown
{
    ///The <b>StateVariableChanged</b> method is invoked when a state variable has changed.
    ///Params:
    ///    pus = Reference to an IUPnPService object that specifies the service about which the UPnP framework is sending the
    ///          notification.
    ///    pcwszStateVarName = Reference to a string that specifies the name of the state variable that has changed.
    ///    vaValue = Specifies the new value. The type of the data returned depends on the data type of the state variable for
    ///              which the notification is sent.
    ///Returns:
    ///    The application should return S_OK.
    ///    
    HRESULT StateVariableChanged(IUPnPService pus, const(wchar)* pcwszStateVarName, VARIANT vaValue);
    ///The <b>ServiceInstanceDied</b> method is invoked when a service is no longer sending events.
    ///Params:
    ///    pus = Reference to an IUPnPService object that specifies the service about which the UPnP framework is sending the
    ///          notification.
    ///Returns:
    ///    The application should return S_OK.
    ///    
    HRESULT ServiceInstanceDied(IUPnPService pus);
}

///Use this interface to delay Service Control Protocol Description (SCPD) download and event subscription on the
///IUPnPService objects enumerated from the IUPnPServices object. This interface can be obtained through a
///QueryInterface off the IUPnPServices object.
@GUID("38873B37-91BB-49F4-B249-2E8EFBB8A816")
interface IUPnPServiceEnumProperty : IUnknown
{
    ///The <b>SetServiceEnumProperty</b> method is used to indicate opt-in to the delayed Service Control Protocol
    ///Description (SCPD) download and event subscription for the IUPnPService objects enumerated from the IUPnPServices
    ///object.
    ///Params:
    ///    dwMask = Specifies a bit-wise flag to indicate an opt-in to the delayed SCPD download and even subscription. Possible
    ///             values include: <table> <tr> <th>Flag</th> <th>Value</th> </tr> <tr>
    ///             <td>UPNP_SERVICE_DELAY_SCPD_AND_SUBSCRIPTION</td> <td>0x1</td> </tr> </table>
    ///Returns:
    ///    Returns <b>S_OK</b> on success. Otherwise, this method returns <b>E_FAIL</b>.
    ///    
    HRESULT SetServiceEnumProperty(uint dwMask);
}

///Use this interface to retrieve and provide the Service Control Protocol Description (SCPD) document to a UPnP control
///point application to expose actions supported by the service and provide information about state variables.
@GUID("21905529-0A5E-4589-825D-7E6D87EA6998")
interface IUPnPServiceDocumentAccess : IUnknown
{
    ///The <b>GetDocumentURL</b> method retrieves the Service Control Protocol Description (SCPD) URL for a service
    ///object. Using this URL, the UPnP control point can download the complete SCPD document.
    ///Params:
    ///    pbstrDocUrl = The URL to the complete SCPD document.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns <b>E_FAIL</b>. This
    ///    method will fail if called after a service enumeration has already started.
    ///    
    HRESULT GetDocumentURL(BSTR* pbstrDocUrl);
    ///The <b>GetDocument</b> method retrieves the Service Control Protocol Description (SCPD) document for a service
    ///object. The information provided by this document enables the user to pre-determine which actions are supported
    ///by the service, or review information about state variables.
    ///Params:
    ///    pbstrDoc = The complete SCPD document.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns <b>E_FAIL</b>.
    ///    
    HRESULT GetDocument(BSTR* pbstrDoc);
}

///The <b>IUPnPDevices</b> interface enumerates a collection of devices.
@GUID("FDBC0C73-BDA3-4C66-AC4F-F2D96FDAD68C")
interface IUPnPDevices : IDispatch
{
    ///The <b>Count</b> property specifies the number of devices in the collection.
    ///Params:
    ///    plCount = Receives a reference to the number of devices in the collection.
    ///Returns:
    ///    For C++: If this property's "get" method succeeds, the return value is S_OK. Otherwise, the method returns
    ///    one of the COM error codes defined in WinError.h.
    ///    
    HRESULT get_Count(int* plCount);
    ///The <b>_NewEnum</b> property specifies either the IEnumVARIANT or IEnumUnknown enumerator interface for the
    ///collection.
    ///Params:
    ///    ppunk = Receives a reference to the enumerator interface.
    ///Returns:
    ///    For C++: If this property's "get" method succeeds, the return value is S_OK. Otherwise, the method returns
    ///    one of the COM error codes defined in WinError.h.
    ///    
    HRESULT get__NewEnum(IUnknown* ppunk);
    ///The <b>Item</b> property specifies the IUPnPDevice interface for a device, identified by the UDN, in the
    ///collection.
    ///Params:
    ///    bstrUDN = Specifies a device in the collection.
    ///    ppDevice = Receives a reference to an IUPnPDevice interface for the specified device.
    ///Returns:
    ///    For C++: If this property's "get" method succeeds, the return value is S_OK. Otherwise, the method returns
    ///    one of the COM error codes defined in WinError.h.
    ///    
    HRESULT get_Item(BSTR bstrUDN, IUPnPDevice* ppDevice);
}

///The <b>IUPnPDevice</b> interface enables an application to retrieve information about a specific device.
@GUID("3D44D0D1-98C9-4889-ACD1-F9D674BF2221")
interface IUPnPDevice : IDispatch
{
    ///The <b>IsRootDevice</b> property specifies whether the device is the topmost device in the device tree.
    ///Params:
    ///    pvarb = Receives a reference to a <b>VARIANT_BOOL</b> that contains the value VARIANT_TRUE if the device is the
    ///            topmost device in the device tree; otherwise, it contains the value VARIANT_FALSE.
    ///Returns:
    ///    For C++: If this property's "get" method succeeds, the return value is S_OK. Otherwise, the method returns
    ///    one of the COM error codes defined in WinError.h.
    ///    
    HRESULT get_IsRootDevice(short* pvarb);
    ///The <b>RootDevice</b> property specifies the topmost device in the device tree. The root device represents a
    ///physical object.
    ///Params:
    ///    ppudRootDevice = Receives a reference to an IUPnPDevice object that describes the root device. This reference must be released
    ///                     when it is no longer required.
    ///Returns:
    ///    For C++: If this property's "get" method succeeds, the return value is S_OK. Otherwise, the method returns
    ///    one of the COM error codes defined in WinError.h.
    ///    
    HRESULT get_RootDevice(IUPnPDevice* ppudRootDevice);
    ///The <b>ParentDevice</b> property specifies the parent of the device.
    ///Params:
    ///    ppudDeviceParent = Receives a reference to an IUPnPDevice object that describes the parent device. This reference must be
    ///                       released when it is no longer required. If the device has no parent, it is a topmost device, and the
    ///                       parameter receives <b>NULL</b>.
    ///Returns:
    ///    For C++: If this property's "get" method succeeds, the return value is S_OK. If the device is a topmost
    ///    device, the return value is S_FALSE. Otherwise, the method returns one of the COM error codes defined in
    ///    WinError.h.
    ///    
    HRESULT get_ParentDevice(IUPnPDevice* ppudDeviceParent);
    ///The <b>HasChildren</b> property specifies whether the device has any child devices.
    ///Params:
    ///    pvarb = Receives a reference to a <b>VARIANT_BOOL</b> that contains the value VARIANT_TRUE if the device has one or
    ///            more child devices; otherwise, it contains the value VARIANT_FALSE.
    ///Returns:
    ///    For C++: If this property's "get" method succeeds, the return value is S_OK. Otherwise, the method returns
    ///    one of the COM error codes defined in WinError.h.
    ///    
    HRESULT get_HasChildren(short* pvarb);
    ///The <b>Children</b> property specifies all the child devices of the device. The devices are stored in an
    ///IUPnPDevices collection.
    ///Params:
    ///    ppudChildren = Receives a reference to an IUPnPDevices collection that enumerates the child devices of the device. This
    ///                   reference must be released when it is no longer required. If the device has no child devices, the collection
    ///                   object has a length of zero.
    ///Returns:
    ///    For C++: If this property's "get" method succeeds, the return value is S_OK. Otherwise, the method returns
    ///    one of the COM error codes defined in WinError.h.
    ///    
    HRESULT get_Children(IUPnPDevices* ppudChildren);
    ///The <b>UniqueDeviceName</b> property specifies the unique device name (UDN) of the device. A UDN is unique; no
    ///two devices can have the same UDN.
    ///Params:
    ///    pbstr = Receives a reference to a string that contains the UDN of the device. Release this string with SysFreeString
    ///            when it is no longer required.
    ///Returns:
    ///    For C++: If this property's "get" method succeeds, the return value is S_OK. Otherwise, the method returns
    ///    one of the COM error codes defined in WinError.h.
    ///    
    HRESULT get_UniqueDeviceName(BSTR* pbstr);
    ///The <b>FriendlyName</b> property specifies the device display name for the device.
    ///Params:
    ///    pbstr = Receives a reference to a string that contains the device display name. Release this string with
    ///            SysFreeString when it is no longer required.
    ///Returns:
    ///    For C++: If this property's "get" method succeeds, the return value is S_OK. Otherwise, the method returns
    ///    one of the COM error codes defined in WinError.h.
    ///    
    HRESULT get_FriendlyName(BSTR* pbstr);
    ///The <b>Type</b> method specifies the device type uniform resource identifier (URI) for the device.
    ///Params:
    ///    pbstr = Receives a reference to a string that contains the device type's URI. Release this string with SysFreeString
    ///            when it is no longer required.
    ///Returns:
    ///    For C++: If this property's "get" method succeeds, the return value is S_OK. Otherwise, the method returns
    ///    one of the COM error codes defined in WinError.h.
    ///    
    HRESULT get_Type(BSTR* pbstr);
    ///The <b>PresentationURL</b> property specifies the presentation URL for a Web page that controls the device.
    ///Params:
    ///    pbstr = Receives a reference to a string that contains the presentation URL for the Web page. This URL is an absolute
    ///            URL. Release this string with SysFreeString when it is no longer used. If the device does not specify a
    ///            presentation URL, this parameter receives an empty string.
    ///Returns:
    ///    For C++: If this property's "get" method succeeds, the return value is S_OK. If the device did not specify a
    ///    presentation URL, the return value is S_FALSE. Otherwise, the method returns one of the COM error codes
    ///    defined in WinError.h.
    ///    
    HRESULT get_PresentationURL(BSTR* pbstr);
    ///The <b>ManufacturerName</b> property specifies a human-readable form of the manufacturer name of the device.
    ///Params:
    ///    pbstr = Receives a reference to a string that contains the manufacturer's name. Release this string with
    ///            SysFreeString when it is no longer required.
    ///Returns:
    ///    For C++: If this property's "get" method succeeds, the return value is S_OK. Otherwise, the method returns
    ///    one of the COM error codes defined in WinError.h.
    ///    
    HRESULT get_ManufacturerName(BSTR* pbstr);
    ///The <b>ManufacturerURL</b> property specifies the URL for the manufacturer's Web site.
    ///Params:
    ///    pbstr = Receives a reference to a string that contains the URL. Release this string with SysFreeString when it is no
    ///            longer required. If the device does not specify this URL, this parameter is set to <b>NULL</b>.
    ///Returns:
    ///    For C++: If this property's "get" method succeeds, the return value is S_OK. If the device does not specify
    ///    this URL, the return value is S_FALSE and <i>pbstr</i> is <b>NULL</b>. Otherwise, the method returns one of
    ///    the COM error codes defined in WinError.h.
    ///    
    HRESULT get_ManufacturerURL(BSTR* pbstr);
    ///The <b>ModelName</b> property specifies a human-readable form of the model name of the device.
    ///Params:
    ///    pbstr = Receives a reference to a string that contains the model name. Release this string with SysFreeString when it
    ///            is no longer required.
    ///Returns:
    ///    For C++: If this property's "get" method succeeds, the return value is S_OK. Otherwise, the method returns
    ///    one of the COM error codes defined in WinError.h.
    ///    
    HRESULT get_ModelName(BSTR* pbstr);
    ///The <b>ModelNumber</b> property specifies a human-readable form of the model number of the device.
    ///Params:
    ///    pbstr = Receives a reference to a string that contains the model number. Release this string with SysFreeString when
    ///            it is no longer required. If the device does not specify a model number, this parameter is set to
    ///            <b>NULL</b>.
    ///Returns:
    ///    For C++: If this property's "get" method succeeds, the return value is S_OK. If the device does not specify a
    ///    model number, the return value is S_FALSE and <i>pbstr</i> is <b>NULL</b>. Otherwise, the method returns one
    ///    of the COM error codes defined in WinError.h.
    ///    
    HRESULT get_ModelNumber(BSTR* pbstr);
    ///The <b>Description</b> property specifies a human-readable summary of the device's functionality.
    ///Params:
    ///    pbstr = Receives a reference to a string that contains a short description of the intended functionality of devices
    ///            of this type. Release this string with SysFreeString when it is no longer required. If the device does not
    ///            specify a description, this parameter is set to <b>NULL</b>.
    ///Returns:
    ///    For C++: If this property's "get" method succeeds, the return value is S_OK. If the device does not specify
    ///    this URL, the return value is S_FALSE and <i>pbstr</i> is <b>NULL</b>. Otherwise, the method returns one of
    ///    the COM error codes defined in WinError.h.
    ///    
    HRESULT get_Description(BSTR* pbstr);
    ///The <b>ModelURL</b> property specifies the URL for a Web page that contains model-specific information for the
    ///device.
    ///Params:
    ///    pbstr = Receives a reference to a string that contains the URL. Release this string with SysFreeString when it is no
    ///            longer required. If the device does not specify this URL, this parameter is set to <b>NULL</b>.
    ///Returns:
    ///    For C++: If this property's "get" method succeeds, the return value is S_OK. If the device does not specify
    ///    this URL, the return value is S_FALSE and <i>pbstr</i> is <b>NULL</b>. Otherwise, the method returns one of
    ///    the COM error codes defined in WinError.h.
    ///    
    HRESULT get_ModelURL(BSTR* pbstr);
    ///The <b>UPC</b> property specifies a human-readable form of the product code.
    ///Params:
    ///    pbstr = Receives a reference to a string that contains the product code. Release this string with SysFreeString when
    ///            it is no longer required. If the device does not specify a product code, this parameter receives an empty
    ///            string.
    ///Returns:
    ///    For C++: If this property's "get" method succeeds, the return value is S_OK. If the device did not specify a
    ///    product code, the return value is S_FALSE. Otherwise, the method returns one of the COM error codes defined
    ///    in WinError.h.
    ///    
    HRESULT get_UPC(BSTR* pbstr);
    ///The <b>SerialNumber</b> property specifies a human-readable form of the serial number of the device.
    ///Params:
    ///    pbstr = Receives a reference to a string that contains the serial number. Release this string with SysFreeString when
    ///            it is no longer used. This property is optional and the device may not have a serial number.
    ///Returns:
    ///    For C++: If this property's "get" method succeeds, the return value is S_OK. If the device did not specify a
    ///    serial number, the return value is S_FALSE. Otherwise, the method returns one of the COM error codes defined
    ///    in WinError.h.
    ///    
    HRESULT get_SerialNumber(BSTR* pbstr);
    ///The <b>IconURL</b> method returns a URL from which an icon of the specified format can be loaded.
    ///Params:
    ///    bstrEncodingFormat = Specifies the MIME type of the encoding format that is requested for the icon.
    ///    lSizeX = Specifies the width of the icon, in pixels. Standard values are 16, 32, or 48.
    ///    lSizeY = Specifies the height of the icon, in pixels. Standard values are 16, 32, or 48 pixels.
    ///    lBitDepth = Specifies the bit depth of the icon. Standard values are 8, 16, or 24.
    ///    pbstrIconURL = Receives a reference to a string that contains the URL from which the icon is to be loaded. Release this
    ///                   string with SysFreeString when it is no longer required.
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, the method returns one of the COM error codes
    ///    defined in WinError.h.
    ///    
    HRESULT IconURL(BSTR bstrEncodingFormat, int lSizeX, int lSizeY, int lBitDepth, BSTR* pbstrIconURL);
    ///The <b>Services</b> property specifies the list of services provided by the device.
    ///Params:
    ///    ppusServices = Receives a reference to an IUPnPServices collection that enumerates the services provided by the device. This
    ///                   reference must be released when it is no longer required.
    ///Returns:
    ///    For C++: If this property's "get" method succeeds, the return value is S_OK. Otherwise, the method returns
    ///    one of the COM error codes defined in WinError.h.
    ///    
    HRESULT get_Services(IUPnPServices* ppusServices);
}

///The <b>IUPnPDeviceDocumentAccess</b> interface enables an application to obtain the URL of the device description
///document. <div class="alert"><b>Note</b> This interface does not support scripting.</div><div> </div>
@GUID("E7772804-3287-418E-9072-CF2B47238981")
interface IUPnPDeviceDocumentAccess : IUnknown
{
    ///The <b>GetDocumentURL</b> method returns the URL from which the device description document can be loaded.
    ///Params:
    ///    pbstrDocument = Receives the URL from which the device description document can be downloaded.
    ///Returns:
    ///    If the method succeeds, the return value is as specified above. Otherwise, the method returns one of the COM
    ///    error codes specified in winerror.h.
    ///    
    HRESULT GetDocumentURL(BSTR* pbstrDocument);
}

///The <b>IUPnPDeviceDocumentAccessEx</b> interface provides a method to obtain the entire XML device description
///document for a specific device.
@GUID("C4BC4050-6178-4BD1-A4B8-6398321F3247")
interface IUPnPDeviceDocumentAccessEx : IUnknown
{
    ///The <b>GetDocument</b> method retrieves the XML device description document for a UPnP device.
    ///Params:
    ///    pbstrDocument = Receives the XML device description document for the device. After obtaining the XML device document, the
    ///                    memory for this parameter must be free by passing it to SysFreeString.
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, the method returns one of the COM error codes
    ///    defined in WinError.h.
    ///    
    HRESULT GetDocument(BSTR* pbstrDocument);
}

///The <b>IUPnPDescriptionDocument</b> interface enables an application to load a device description.
@GUID("11D1C1B2-7DAA-4C9E-9595-7F82ED206D1E")
interface IUPnPDescriptionDocument : IDispatch
{
    ///The <b>ReadyState</b> property specifies the status of the document load operation. This status indicates the
    ///state of the IUPnPDescriptionDocument::Load or IUPnPDescriptionDocument::LoadAsync method. These states are the
    ///standard ready-state values for loading XML documents.
    ///Params:
    ///    plReadyState = Receives a reference to the ready state. The values this parameter can receive are (in the order they are
    ///                   used by Universal Plug and Play): <table> <tr> <th>plReadyState Value</th> <th>Meaning</th> </tr> <tr> <td
    ///                   width="40%"><a id="READYSTATE_UNINITIALIZED"></a><a id="readystate_uninitialized"></a><dl>
    ///                   <dt><b>READYSTATE_UNINITIALIZED</b></dt> </dl> </td> <td width="60%"> The document object has been created.
    ///                   </td> </tr> <tr> <td width="40%"><a id="READYSTATE__LOADING"></a><a id="readystate__loading"></a><dl>
    ///                   <dt><b>READYSTATE _LOADING</b></dt> </dl> </td> <td width="60%"> The load operation has started. </td> </tr>
    ///                   <tr> <td width="40%"><a id="READYSTATE__COMPLETE"></a><a id="readystate__complete"></a><dl> <dt><b>READYSTATE
    ///                   _COMPLETE</b></dt> </dl> </td> <td width="60%"> The load operation is finished; the document has been
    ///                   downloaded and the XML has been parsed. </td> </tr> <tr> <td width="40%"><a
    ///                   id="READYSTATE__INTERACTIVE"></a><a id="readystate__interactive"></a><dl> <dt><b>READYSTATE
    ///                   _INTERACTIVE</b></dt> </dl> </td> <td width="60%"> Reserved for future use. </td> </tr> <tr> <td
    ///                   width="40%"><a id="READYSTATE__LOADED"></a><a id="readystate__loaded"></a><dl> <dt><b>READYSTATE
    ///                   _LOADED</b></dt> </dl> </td> <td width="60%"> Reserved for future use. </td> </tr> </table>
    ///Returns:
    ///    For C++: If this property's "get" method succeeds, the return value is S_OK. Otherwise, the method returns
    ///    one of the COM error codes defined in WinError.h.
    ///    
    HRESULT get_ReadyState(int* plReadyState);
    ///The <b>Load</b> method loads a document synchronously. This method does not return control to the caller until
    ///the load operation is complete.
    ///Params:
    ///    bstrUrl = Specifies the URL of the document to load.
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, the method returns one of the COM error codes
    ///    defined in WinError.h, or one of the following UPnP return values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>UPNP_E_DEVICE_ELEMENT_EXPECTED</b></dt> </dl>
    ///    </td> <td width="60%"> XML document does not have a device element. It is missing either from the root
    ///    element or the DeviceList element. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPnP_E_DEVICE_ELEMENT_EXPECTED</b></dt> </dl> </td> <td width="60%"> There is no Device element in the
    ///    specified description document. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_DEVICE_NODE_INCOMPLETE</b></dt> </dl> </td> <td width="60%"> XML document is missing one of the
    ///    required elements from the Device element. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_ICON_ELEMENT_EXPECTED</b></dt> </dl> </td> <td width="60%"> XML document does not have an icon
    ///    element. It is missing from the IconList element, or the DeviceList element does not contain an IconList
    ///    element. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>UPnP_E_ICON_ELEMENT_EXPECTED</b></dt> </dl> </td> <td
    ///    width="60%"> There is no Icon element in the specified description document. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>UPNP_E_ICON_NODE_INCOMPLETE</b></dt> </dl> </td> <td width="60%"> XML document is
    ///    missing one of the required elements from the Icon element. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPnP_E_ICON_NODE_INCOMPLETE</b></dt> </dl> </td> <td width="60%"> There is no Icon Node in the
    ///    specified description document. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_ROOT_ELEMENT_EXPECTED</b></dt> </dl> </td> <td width="60%"> XML document does not have a root
    ///    element at the top level of the document. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPnP_E_ROOT_ELEMENT_EXPECTED</b></dt> </dl> </td> <td width="60%"> There is no Root element in the
    ///    specified description document. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_SERVICE_ELEMENT_EXPECTED</b></dt> </dl> </td> <td width="60%"> XML document does not have a
    ///    service element. It is missing from the ServiceList element, or the DeviceList element does not contain a
    ///    ServiceList element. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>UPNP_E_SERVICE_NODE_INCOMPLETE</b></dt>
    ///    </dl> </td> <td width="60%"> XML document is missing one of the required elements from the Service element.
    ///    </td> </tr> </table>
    ///    
    HRESULT Load(BSTR bstrUrl);
    ///The <b>LoadAsync</b> method loads a document asynchronously. This method returns control to the caller
    ///immediately, and uses the specified callback to notify the caller when the operation is complete.
    ///Params:
    ///    bstrUrl = Specifies the URL of the document to load. If the URL specified is a relative URL, the server name is
    ///              prepended to the value of <i>bstrUrl</i>.
    ///    punkCallback = Reference to an <b>IUnknown</b> specifying the callback that the UPnP framework uses to notify the caller
    ///                   when the operation is complete. If the load operation did not fail immediately, this callback indicates
    ///                   whether or not the load operation succeeded or failed. The object referred to by <i>pUnkCallback</i> must
    ///                   support either the IUPnPDescriptionDocumentCallback interface or the IDispatch interface.
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, the method returns one of the COM error codes
    ///    defined in WinError.h, or one of the following UPnP return values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>UPNP_E_DEVICE_ELEMENT_EXPECTED</b></dt> </dl>
    ///    </td> <td width="60%"> The XML document does not have a device element It is missing either from the root
    ///    element or the <b>DeviceList</b> element. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_DEVICE_NODE_INCOMPLETE</b></dt> </dl> </td> <td width="60%"> The XML document is missing one of
    ///    the required elements from the <b>Device</b> element. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_ICON_ELEMENT_EXPECTED</b></dt> </dl> </td> <td width="60%"> The XML document does not have an
    ///    icon element. It is missing from the <b>IconList</b> element, or the <b>DeviceList</b> element does not
    ///    contain an <b>IconList</b> element. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_ICON_NODE_INCOMPLETE</b></dt> </dl> </td> <td width="60%"> The XML document is missing one of
    ///    the required elements from the <b>Icon</b> element. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_ROOT_ELEMENT_EXPECTED</b></dt> </dl> </td> <td width="60%"> The XML document does not have a
    ///    root element at the top level of the document. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_SERVICE_ELEMENT_EXPECTED</b></dt> </dl> </td> <td width="60%"> The XML document does not have a
    ///    service element. It is missing from the <b>ServiceList</b> element, or the <b>DeviceList</b> element does not
    ///    contain a <b>ServiceList</b> element. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_SERVICE_NODE_INCOMPLETE</b></dt> </dl> </td> <td width="60%"> The XML document is missing one
    ///    of the required elements from the <b>Service</b> element. </td> </tr> </table>
    ///    
    HRESULT LoadAsync(BSTR bstrUrl, IUnknown punkCallback);
    ///The <b>LoadResult</b> property specifies the success or failure code of a completed load operation.
    ///Params:
    ///    phrError = Receives a reference to the success or failure code. The values this parameter can receive are: <table> <tr>
    ///               <th>phrError Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="E_FAIL"></a><a
    ///               id="e_fail"></a><dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The load operation failed. </td>
    ///               </tr> <tr> <td width="40%"><a id="E_PENDING"></a><a id="e_pending"></a><dl> <dt><b>E_PENDING</b></dt> </dl>
    ///               </td> <td width="60%"> The load operation is not yet completed. </td> </tr> <tr> <td width="40%"><a
    ///               id="E_UNEXPECTED"></a><a id="e_unexpected"></a><dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%">
    ///               An unexpected error occurred during the load operation. </td> </tr> <tr> <td width="40%"><a id="S_OK"></a><a
    ///               id="s_ok"></a><dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The load operation succeeded. </td>
    ///               </tr> </table>
    ///Returns:
    ///    For C++: If this property's "get" method succeeds, the return value is S_OK. Otherwise, the method returns
    ///    one of the COM error codes defined in WinError.h.
    ///    
    HRESULT get_LoadResult(int* phrError);
    ///The <b>Abort</b> method stops an asynchronous load operation started by IUPnPDescriptionDocument::LoadAsync.
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, the method returns one of the COM error codes
    ///    defined in WinError.h.
    ///    
    HRESULT Abort();
    ///The <b>RootDevice</b> method returns the root device of the currently loaded document's device tree.
    ///Params:
    ///    ppudRootDevice = Receives a reference to an IUPnPDevice object that describes the device. This reference must be released when
    ///                     it is no longer required.
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, the method returns one of the COM error codes
    ///    defined in WinError.h.
    ///    
    HRESULT RootDevice(IUPnPDevice* ppudRootDevice);
    ///The <b>DeviceByUDN</b> method returns the device with the specified unique device name (UDN) contained within the
    ///loaded description document.
    ///Params:
    ///    bstrUDN = Specifies the UDN of the device.
    ///    ppudDevice = Receives a reference to an IUPnPDevice object that describes the device. This reference must be released when
    ///                 it is no longer used.
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, the method returns one of the COM error codes
    ///    defined in WinError.h.
    ///    
    HRESULT DeviceByUDN(BSTR bstrUDN, IUPnPDevice* ppudDevice);
}

///The <b>IUPnPDeviceFinderAddCallbackWithInterface</b> interface allows the UPnP framework to communicate to an
///application: <ul> <li>The devices found during an asynchronous search.</li> <li>The network interface through which
///the device advertisement came.</li> </ul>
@GUID("983DFC0B-1796-44DF-8975-CA545B620EE5")
interface IUPnPDeviceFinderAddCallbackWithInterface : IUnknown
{
    ///The <b>DeviceAddedWithInterface</b> method is invoked by the UPnP framework to notify the application that a
    ///device has been added to the network.
    ///Params:
    ///    lFindData = Specifies the search for which the UPnP framework is returning results. The value of <i>lFindData</i> is the
    ///                value returned to the caller by IUPnPDeviceFinder::CreateAsyncFind.
    ///    pDevice = Pointer to a IUPnPDevice object that contains the new device.
    ///    pguidInterface = GUID of the network adapter through which the device advertisement came.
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, the method returns one of the COM error codes
    ///    defined in WinError.h.
    ///    
    HRESULT DeviceAddedWithInterface(int lFindData, IUPnPDevice pDevice, GUID* pguidInterface);
}

///The <b>IUPnPDescriptionDocumentCallback</b> interface allows the UPnP framework to communicate the results of an
///asynchronous load operation to an application.
@GUID("77394C69-5486-40D6-9BC3-4991983E02DA")
interface IUPnPDescriptionDocumentCallback : IUnknown
{
    ///The <b>LoadComplete</b> method is invoked when the UPnP framework has finished loading a device description.
    ///Params:
    ///    hrLoadResult = Specifies the load operation that the UPnP framework has completed. Possible return values are: <table> <tr>
    ///                   <th>UPnP-specific return value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///                   id="UPNP_E_DEVICE_ELEMENT_EXPECTED"></a><a id="upnp_e_device_element_expected"></a><dl>
    ///                   <dt><b>UPNP_E_DEVICE_ELEMENT_EXPECTED</b></dt> </dl> </td> <td width="60%"> The XML document does not have a
    ///                   device element. It is missing either from the root element or the <b>DeviceList</b> element. </td> </tr> <tr>
    ///                   <td width="40%"><a id="UPNP_E_DEVICE_NODE_INCOMPLETE"></a><a id="upnp_e_device_node_incomplete"></a><dl>
    ///                   <dt><b>UPNP_E_DEVICE_NODE_INCOMPLETE</b></dt> </dl> </td> <td width="60%"> The XML document is missing one of
    ///                   the required elements from the <b>Device</b> element. </td> </tr> <tr> <td width="40%"><a
    ///                   id="UPNP_E_ICON_ELEMENT_EXPECTED"></a><a id="upnp_e_icon_element_expected"></a><dl>
    ///                   <dt><b>UPNP_E_ICON_ELEMENT_EXPECTED</b></dt> </dl> </td> <td width="60%"> The XML document does not have an
    ///                   icon element. It is missing from the <b>IconList</b> element, or the <b>DeviceList</b> element does not
    ///                   contain an <b>IconList</b> element. </td> </tr> <tr> <td width="40%"><a
    ///                   id="UPNP_E_ICON_NODE_INCOMPLETE"></a><a id="upnp_e_icon_node_incomplete"></a><dl>
    ///                   <dt><b>UPNP_E_ICON_NODE_INCOMPLETE</b></dt> </dl> </td> <td width="60%"> The XML document is missing one of
    ///                   the required elements from the <b>Icon</b> element. </td> </tr> <tr> <td width="40%"><a
    ///                   id="UPNP_E_ROOT_ELEMENT_EXPECTED"></a><a id="upnp_e_root_element_expected"></a><dl>
    ///                   <dt><b>UPNP_E_ROOT_ELEMENT_EXPECTED</b></dt> </dl> </td> <td width="60%"> The XML document does not have a
    ///                   root element at the top level of the document. </td> </tr> <tr> <td width="40%"><a
    ///                   id="UPNP_E_SERVICE_ELEMENT_EXPECTED"></a><a id="upnp_e_service_element_expected"></a><dl>
    ///                   <dt><b>UPNP_E_SERVICE_ELEMENT_EXPECTED</b></dt> </dl> </td> <td width="60%"> The XML document does not have a
    ///                   service element. It is missing from the <b>ServiceList</b> element, or the <b>DeviceList</b> element does not
    ///                   contain a <b>ServiceList</b> element. </td> </tr> <tr> <td width="40%"><a
    ///                   id="UPNP_E_SERVICE_NODE_INCOMPLETE"></a><a id="upnp_e_service_node_incomplete"></a><dl>
    ///                   <dt><b>UPNP_E_SERVICE_NODE_INCOMPLETE</b></dt> </dl> </td> <td width="60%"> The XML document is missing one
    ///                   of the required elements from the <b>Service</b> element. </td> </tr> </table>
    ///Returns:
    ///    The application should return S_OK.
    ///    
    HRESULT LoadComplete(HRESULT hrLoadResult);
}

///The <b>IUPnPEventSink</b> interface allows a hosted service to send event notifications to the device host.
@GUID("204810B4-73B2-11D4-BF42-00B0D0118B56")
interface IUPnPEventSink : IUnknown
{
    ///The <b>OnStateChanged</b> method sends an event to the device host with the list of DISPIDs of the state
    ///variables that have changed. The device host must query the service object to obtain the new value for each state
    ///variable that has changed. This method is unavailable to Visual Basic developers, and those using other languages
    ///that do not support native arrays. These developers must use OnStateChangedSafe instead.
    ///Params:
    ///    cChanges = Specifies the number of variables in <i>rgdispidChanges</i>. The value indicates the number of variables
    ///               whose values have changed.
    ///    rgdispidChanges = Contains a list of the DISPIDs of the state variables that have changed. The number of elements in this
    ///                      buffer is specified by <i>cChanges</i>.
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, the method returns one of the COM error codes
    ///    defined in WinError.h. If <i>cChanges</i> is zero or <i>rgdispidChanges</i> is <b>NULL</b>, E_INVALIDARG is
    ///    returned.
    ///    
    HRESULT OnStateChanged(uint cChanges, char* rgdispidChanges);
    ///The <b>OnStateChangedSafe</b> method sends an event to the device host with the list of DISPIDs that have
    ///changed. The device host must query the service object to obtain the new value for each state variable that has
    ///changed. The <b>OnStateChangedSafe</b> method can only be used by Visual Basic developers and those using
    ///languages that do not support native arrays.
    ///Params:
    ///    varsadispidChanges = Contains a safearray of the DISPIDs of the state variables that have changed.
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, the method returns one of the COM error codes
    ///    defined in WinError.h.
    ///    
    HRESULT OnStateChangedSafe(VARIANT varsadispidChanges);
}

///The <b>IUPnPEventSource</b> interface allows the device host to manage event subscriptions for the hosted service.
@GUID("204810B5-73B2-11D4-BF42-00B0D0118B56")
interface IUPnPEventSource : IUnknown
{
    ///The <b>Advise</b> method is invoked by the device host to begin receiving events from the hosted service. The
    ///device host passes a pointer to its IUnknown interface. The hosted service must query this <b>IUnknown</b>
    ///interface for the IUPnPEventSink interface the service must use to send event notifications.
    ///Params:
    ///    pesSubscriber = Pointer to the device host's IUPnPEventSink interface.
    ///Returns:
    ///    When implementing this method, return S_OK if the method succeeds. Otherwise, return one of the COM error
    ///    codes defined in WinError.h.
    ///    
    HRESULT Advise(IUPnPEventSink pesSubscriber);
    ///The <b>Unadvise</b> method is invoked by the device host to stop receiving events. The device host passes in the
    ///same pointer that it did when it invoked the IUPnPEventSource::Advise method. After this method is invoked, the
    ///hosted service releases the reference to the event sink that it held.
    ///Params:
    ///    pesSubscriber = Pointer to the device host's IUPnPEventSink interface. This must be the same pointer that was passed when
    ///                    IUPnPEventSource::Advise was invoked.
    ///Returns:
    ///    When implementing this method, return S_OK if the method succeeds. Otherwise, return one of the COM error
    ///    codes defined in WinError.h.
    ///    
    HRESULT Unadvise(IUPnPEventSink pesSubscriber);
}

///The <b>IUPnPRegistrar</b> interface registers the devices that run in the context of the device host.
@GUID("204810B6-73B2-11D4-BF42-00B0D0118B56")
interface IUPnPRegistrar : IUnknown
{
    ///The <b>RegisterDevice</b> method registers a device with the device host. The device information is stored by the
    ///device host. Then, the device host returns a device identifier and publishes and announces the device on the
    ///network.
    ///Params:
    ///    bstrXMLDesc = Specifies the XML device description template of the device to register.
    ///    bstrProgIDDeviceControlClass = Specifies the ProgID of a device control object that implements the IUPnPDeviceControl interface. This
    ///                                   interface must be an in-process COM server (CLSCTX_INPROC_SERVER) and must be accessible to LocalService.
    ///    bstrInitString = Identifies the initialization string specific to the device. This string is later passed to
    ///                     IUPnPDeviceControl::Initialize.
    ///    bstrContainerId = Specifies a string that identifies the process group in which the device belongs. All devices with the same
    ///                      container ID are contained in the same process.
    ///    bstrResourcePath = Specifies the location of the resource directory of the device. This resource directory contains the icon
    ///                       files and service descriptions that are specified in the device description template <i>bstrXMLDesc</i>. The
    ///                       resource directory may also contain the presentation files. However, this is optional.
    ///    nLifeTime = Specifies the lifetime of the device announcement, in seconds. After the timeout expires, the announcements
    ///                are refreshed. If you specify zero, the default value of 1800 (30 minutes) is used. The minimum allowable
    ///                value is 900 (15 minutes); if you specify anything less than 900, an error is returned.
    ///    pbstrDeviceIdentifier = Receives the device identifier. Use this identifier when unregistering or re-registering the device. Save
    ///                            this Device ID; you must use it when calling UnregisterDevice.
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, the method returns one of the COM error codes
    ///    defined in WinError.h, or one of the following UPnP-specific error codes. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>UPNP_E_DUPLICATE_SERVICE_ID</b></dt> </dl> </td>
    ///    <td width="60%"> A duplicate service ID for a service within the same parent device exists. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>UPNP_E_INVALID_DESCRIPTION</b></dt> </dl> </td> <td width="60%"> The device
    ///    description is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>UPNP_E_INVALID_ICON</b></dt> </dl>
    ///    </td> <td width="60%"> An error is present in the icon element of the device description. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>UPNP_E_INVALID_SERVICE</b></dt> </dl> </td> <td width="60%"> An error is present
    ///    in a service element in the device description. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_REQUIRED_ELEMENT_ERROR</b></dt> </dl> </td> <td width="60%"> A required element is missing.
    ///    </td> </tr> </table>
    ///    
    HRESULT RegisterDevice(BSTR bstrXMLDesc, BSTR bstrProgIDDeviceControlClass, BSTR bstrInitString, 
                           BSTR bstrContainerId, BSTR bstrResourcePath, int nLifeTime, BSTR* pbstrDeviceIdentifier);
    ///The <b>RegisterRunningDevice</b> method registers a running device with the device host. The device information
    ///is stored by the device host. Then, the device host returns a device identifier and publishes and announces the
    ///device on the network. The publication of this device does not persist across system boots.
    ///Params:
    ///    bstrXMLDesc = Specifies the XML device description template of the device to register.
    ///    punkDeviceControl = Specifies the <b>IUnknown</b> pointer to the device's device control object.
    ///    bstrInitString = Identifies the initialization string specific to the device. This string is later passed to
    ///                     IUPnPDeviceControl::Initialize.
    ///    bstrResourcePath = Specifies the location of the resource directory of the device. This resource directory contains the icon
    ///                       files and service descriptions that are specified in the device description template <i>bstrXMLDesc</i>.
    ///    nLifeTime = Specifies the lifetime of the device announcement, in seconds. After the timeout expires, the announcements
    ///                are refreshed. If you specify zero, the default value of 1800 (30 minutes) is used. The minimum allowable
    ///                value is 900 (15 minutes); if you specify anything less than 900, an error is returned.
    ///    pbstrDeviceIdentifier = Receives the device identifier. Use this identifier when unregistering or re-registering the device. Save
    ///                            this Device ID; you must use it when calling UnregisterDevice.
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, the method returns one of the COM error codes
    ///    defined in WinError.h, or one of the following UPnP-specific error codes. <div class="alert"><b>Note</b> If
    ///    bstrResourcePath is too long, this method returns the value 0x80070002.</div> <div> </div> <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_DUPLICATE_NOT_ALLOWED</b></dt> </dl> </td> <td width="60%"> A duplicate element exists. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>UPNP_E_DUPLICATE_SERVICE_ID</b></dt> </dl> </td> <td width="60%"> A
    ///    duplicate service ID for a service within the same parent device exists. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>UPNP_E_INVALID_DESCRIPTION</b></dt> </dl> </td> <td width="60%"> The device description is not
    ///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>UPNP_E_INVALID_ICON</b></dt> </dl> </td> <td
    ///    width="60%"> An error is present in the icon element of the device description. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>UPNP_E_INVALID_SERVICE</b></dt> </dl> </td> <td width="60%"> An error is present in
    ///    a service element in the device description. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_REQUIRED_ELEMENT_ERROR</b></dt> </dl> </td> <td width="60%"> A required element is missing.
    ///    </td> </tr> </table>
    ///    
    HRESULT RegisterRunningDevice(BSTR bstrXMLDesc, IUnknown punkDeviceControl, BSTR bstrInitString, 
                                  BSTR bstrResourcePath, int nLifeTime, BSTR* pbstrDeviceIdentifier);
    ///The <b>RegisterDeviceProvider</b> method registers a device provider with the device host. The device provider is
    ///not published on the network. Instead, it creates devices dynamically and registers them using
    ///RegisterRunningDevice.
    ///Params:
    ///    bstrProviderName = Specifies the name of the device provider.
    ///    bstrProgIDProviderClass = Specifies the ProgID of object that implements the IUPnPDeviceProvider interface. This object must already be
    ///                              registered with COM. This object must be an in-process COM server (CLSCTX_INPROC_SERVER) and must be
    ///                              accessible to LocalService.
    ///    bstrInitString = Identifies an initialization string specific to a device provider.
    ///    bstrContainerId = Specifies a string that identifies the process group in which the device provider belongs. All devices and
    ///                      device providers with the same container ID are contained in the same process.
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, the method returns one of the COM error codes
    ///    defined in WinError.h.
    ///    
    HRESULT RegisterDeviceProvider(BSTR bstrProviderName, BSTR bstrProgIDProviderClass, BSTR bstrInitString, 
                                   BSTR bstrContainerId);
    ///The <b>GetUniqueDeviceName</b> method retrieves the UDN for the specified device. The UDN has been generated by
    ///the device host for each embedded device. The template UDN in the device description is replaced by this
    ///generated UDN for each embedded device when the device is registered. This method is re-entrant.
    ///Params:
    ///    bstrDeviceIdentifier = Specifies the identifier returned by RegisterDevice or RegisterRunningDevice.
    ///    bstrTemplateUDN = Specifies the UDN from the device description template.
    ///    pbstrUDN = Receives the device's UDN that was generated by the device host.
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, the method returns one of the COM error codes
    ///    defined in WinError.h.
    ///    
    HRESULT GetUniqueDeviceName(BSTR bstrDeviceIdentifier, BSTR bstrTemplateUDN, BSTR* pbstrUDN);
    ///The <b>UnregisterDevice</b> method unregisters the device from the device host. A device is either temporarily or
    ///permanently unregistered.
    ///Params:
    ///    bstrDeviceIdentifier = Specifies the device identifier of the device to unregister. The device identifier was returned from a
    ///                           previous call to RegisterDevice or RegisterRunningDevice.
    ///    fPermanent = Specifies whether to permanently or temporarily unregister the device. Specify <b>TRUE</b> to unregister the
    ///                 device permanently from the device host. Specify <b>FALSE</b> to unregister it temporarily.
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, the method returns one of the COM error codes
    ///    defined in WinError.h.
    ///    
    HRESULT UnregisterDevice(BSTR bstrDeviceIdentifier, BOOL fPermanent);
    ///The <b>UnregisterDeviceProvider</b> method permanently unregisters and unloads the device provider from the
    ///device host. The IUPnPDeviceProvider::Stop method is invoked.
    ///Params:
    ///    bstrProviderName = Specifies the provider name. Use the same name that was used in the call to RegisterDeviceProvider.
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, the method returns one of the COM error codes
    ///    defined in WinError.h.
    ///    
    HRESULT UnregisterDeviceProvider(BSTR bstrProviderName);
}

///The <b>IUPnPReregistrar</b> interface allows the application to re-register a UPnP-based device with the device host.
@GUID("204810B7-73B2-11D4-BF42-00B0D0118B56")
interface IUPnPReregistrar : IUnknown
{
    ///The <b>ReregisterDevice</b> method re-registers a device with the device host. The device information is stored
    ///by the device host. Then, the device host returns a device identifier and publishes and announces the device on
    ///the network.
    ///Params:
    ///    bstrDeviceIdentifier = Specifies the device identifier of the device. Use the identifier returned by IUPnPRegistrar::RegisterDevice.
    ///    bstrXMLDesc = Specifies the XML device description template of the device to register.
    ///    bstrProgIDDeviceControlClass = Specifies the ProgID of a device control object that implements the IUPnPDeviceControl interface. This
    ///                                   interface must be an in-process COM server (CLSCTX_INPROC_SERVER) and must be accessible to LocalService.
    ///    bstrInitString = Identifies the initialization string specific to the device. This string is later passed to
    ///                     IUPnPDeviceControl::Initialize.
    ///    bstrContainerId = Specifies a string that identifies the process group in which the device belongs. All devices with the same
    ///                      container ID are contained in the same process.
    ///    bstrResourcePath = Specifies the location of the resource directory of the device. This resource directory contains the icon
    ///                       files and service descriptions that are specified in the device description template <i>bstrXMLDesc</i>. The
    ///                       resource directory may also contain the presentation files. However, this is optional.
    ///    nLifeTime = Specifies the lifetime of the device announcement, in seconds. After the timeout expires, the announcements
    ///                are refreshed. If you specify zero, the default value of 1800 (30 minutes) is used. The minimum allowable
    ///                value is 900 (15 minutes); if you specify anything less than 900, an error is returned.
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, the method returns one of the COM error codes
    ///    defined in WinError.h, or one of the following UPnP-specific error codes. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>UPNP_E_DEVICE_NOTREGISTERED</b></dt> </dl> </td>
    ///    <td width="60%"> The device has not been registered. Use RegisterRunningDevice to register an unregistered
    ///    device. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>UPNP_E_DEVICE_RUNNING</b></dt> </dl> </td> <td
    ///    width="60%"> The device is currently running. Use ReregisterRunningDevice to reregister a device while it is
    ///    running. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>UPNP_E_DUPLICATE_NOT_ALLOWED</b></dt> </dl> </td> <td
    ///    width="60%"> A duplicate element exists. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_DUPLICATE_SERVICE_ID</b></dt> </dl> </td> <td width="60%"> A duplicate service ID for a service
    ///    within the same parent device exists. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_INVALID_DESCRIPTION</b></dt> </dl> </td> <td width="60%"> The device description is not valid.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>UPNP_E_INVALID_ICON</b></dt> </dl> </td> <td width="60%"> An
    ///    error is present in the icon element of the device description. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_INVALID_SERVICE</b></dt> </dl> </td> <td width="60%"> An error is present in a service element
    ///    in the device description. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_REQUIRED_ELEMENT_ERROR</b></dt> </dl> </td> <td width="60%"> A required element is missing.
    ///    </td> </tr> </table>
    ///    
    HRESULT ReregisterDevice(BSTR bstrDeviceIdentifier, BSTR bstrXMLDesc, BSTR bstrProgIDDeviceControlClass, 
                             BSTR bstrInitString, BSTR bstrContainerId, BSTR bstrResourcePath, int nLifeTime);
    ///The <b>ReregisterRunningDevice</b> method re-registers a running device with the device host. The device
    ///information is stored by the device host. Then, the device host returns a device identifier and publishes and
    ///announces the device on the network. The publication of this device does not persist across system boots.
    ///Params:
    ///    bstrDeviceIdentifier = Specifies the device identifier of the device. This must be the same identifier returned by
    ///                           IUPnPRegistrar::RegisterRunningDevice in the <i>pbstrDeviceIdentifier</i> parameter.
    ///    bstrXMLDesc = Specifies the XML device description template of the device to register.
    ///    punkDeviceControl = Specifies the <b>IUnknown</b> pointer to the device's device control object.
    ///    bstrInitString = Identifies the initialization string specific to the device. This string is later passed to
    ///                     IUPnPDeviceControl::Initialize.
    ///    bstrResourcePath = Specifies the location of the resource directory of the device. This resource directory contains the icon
    ///                       files and service descriptions that are specified in the device description template <i>bstrXMLDesc</i>.
    ///    nLifeTime = Specifies the lifetime of the device announcement, in seconds. After the timeout expires, the announcements
    ///                are refreshed. If you specify zero, the default value of 1800 (30 minutes) is used. The minimum allowable
    ///                value is 900 (15 minutes); if you specify anything less than 900, an error is returned.
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, the method returns one of the COM error codes
    ///    defined in WinError.h, or one of the following UPnP-specific error codes. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>UPNP_E_DEVICE_NOTREGISTERED</b></dt> </dl> </td>
    ///    <td width="60%"> The device has not been registered. Use RegisterRunningDevice to register an unregistered
    ///    device. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>UPNP_E_DUPLICATE_NOT_ALLOWED</b></dt> </dl> </td> <td
    ///    width="60%"> A duplicate element exists. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_DUPLICATE_SERVICE_ID</b></dt> </dl> </td> <td width="60%"> A duplicate service ID for a service
    ///    within the same parent device exists. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_INVALID_DESCRIPTION</b></dt> </dl> </td> <td width="60%"> The device description is not valid.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>UPNP_E_INVALID_ICON</b></dt> </dl> </td> <td width="60%"> An
    ///    error is present in the icon element of the device description. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_INVALID_SERVICE</b></dt> </dl> </td> <td width="60%"> An error is present in a service element
    ///    in the device description. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>UPNP_E_REQUIRED_ELEMENT_ERROR</b></dt> </dl> </td> <td width="60%"> A required element is missing.
    ///    </td> </tr> </table>
    ///    
    HRESULT ReregisterRunningDevice(BSTR bstrDeviceIdentifier, BSTR bstrXMLDesc, IUnknown punkDeviceControl, 
                                    BSTR bstrInitString, BSTR bstrResourcePath, int nLifeTime);
}

///The <b>IUPnPDeviceControl</b> interface is the central point of management for a device and its service objects.
@GUID("204810BA-73B2-11D4-BF42-00B0D0118B56")
interface IUPnPDeviceControl : IUnknown
{
    ///The <b>Initialize</b> method is used to initialize the device. The device host invokes this method.
    ///Params:
    ///    bstrXMLDesc = Specifies the full XML device description, as published by the device host. The device description is based
    ///                  on the template provided by the device.
    ///    bstrDeviceIdentifier = Identifies the device to initialize. This is the same identifier returned by IUPnPRegistrar::RegisterDevice
    ///                           or IUPnPRegistrar::RegisterRunningDevice. It is also used to retrieve the UDN of the device using
    ///                           IUPnPRegistrar::GetUniqueDeviceName.
    ///    bstrInitString = Specifies the initialization string used when this device was registered.
    ///Returns:
    ///    When implementing this method, return S_OK if the method succeeds. Otherwise, return one of the COM error
    ///    codes defined in WinError.h.
    ///    
    HRESULT Initialize(BSTR bstrXMLDesc, BSTR bstrDeviceIdentifier, BSTR bstrInitString);
    ///The <b>GetServiceObject</b> method is used to obtain the <b>IDispatch</b> pointer to a specific service object.
    ///The device host invokes this method once per service, the first time it receives a request for a service.
    ///Params:
    ///    bstrUDN = Specifies the UDN of the device.
    ///    bstrServiceId = Specifies the Service ID of the service for which to obtain the pointer.
    ///    ppdispService = Receives the <b>IDispatch</b> pointer to the service object.
    ///Returns:
    ///    When implementing this method, return S_OK if the method succeeds. Otherwise, return one of the COM error
    ///    codes defined in WinError.h.
    ///    
    HRESULT GetServiceObject(BSTR bstrUDN, BSTR bstrServiceId, IDispatch* ppdispService);
}

@GUID("204810BB-73B2-11D4-BF42-00B0D0118B56")
interface IUPnPDeviceControlHttpHeaders : IUnknown
{
    HRESULT GetAdditionalResponseHeaders(BSTR* bstrHttpResponseHeaders);
}

///The <b>IUPnPDeviceProvider</b> interface allows a device provider to start and stop its processing.
@GUID("204810B8-73B2-11D4-BF42-00B0D0118B56")
interface IUPnPDeviceProvider : IUnknown
{
    ///The <b>Start</b> method starts the device provider. The device host invokes this method after it loads the device
    ///provider This method performs any initialization required by the device provider.
    ///Params:
    ///    bstrInitString = Identifies the initialization string specific to a device provider. This string is the same as the one passed
    ///                     to IUPnPRegistrar::RegisterDeviceProvider at registration.
    ///Returns:
    ///    When implementing this method, return S_OK if the method succeeds. Otherwise, return one of the COM error
    ///    codes defined in WinError.h.
    ///    
    HRESULT Start(BSTR bstrInitString);
    ///The <b>Stop</b> method stops the device provider. This method is invoked by the device host before it unloads the
    ///device provider. This method is invoked when a service stops or the computer is shut down, and performs any
    ///cleanup processing required by the device provider.
    ///Returns:
    ///    When implementing this method, return S_OK if the method succeeds. Otherwise, return one of the COM error
    ///    codes defined in WinError.h.
    ///    
    HRESULT Stop();
}

///The <b>IUPnPRemoteEndpointInfo</b> interface allows a hosted device to obtain information about a requester (that is,
///a control point) and the request.
@GUID("C92EB863-0269-4AFF-9C72-75321BBA2952")
interface IUPnPRemoteEndpointInfo : IUnknown
{
    ///The <b>GetDwordValue</b> method gets a 4-byte value that provides information about either a request or
    ///requester.
    ///Params:
    ///    bstrValueName = String that specifies the category of information to be retrieved.
    ///    pdwValue = Pointer to a 4-byte value, the meaning of which depends on the value of <i>bstrValueName</i>. If
    ///               <i>bstrValueName</i> is "AddressFamily", the 4-byte value indicates the format of the requester's IP address
    ///               as follows. The values are defined in Winsock2.h. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///               width="40%"><a id="AF_INET"></a><a id="af_inet"></a><dl> <dt><b>AF_INET</b></dt> </dl> </td> <td width="60%">
    ///               IP (IP version 4) </td> </tr> <tr> <td width="40%"><a id="AF_INET6"></a><a id="af_inet6"></a><dl>
    ///               <dt><b>AF_INET6</b></dt> </dl> </td> <td width="60%"> IP6 (IP version 6) </td> </tr> </table>
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, the method returns one of the COM error codes
    ///    defined in WinError.h.
    ///    
    HRESULT GetDwordValue(BSTR bstrValueName, uint* pdwValue);
    ///The <b>GetStringValue</b> method gets a string that provides information about either a request or requester.
    ///Params:
    ///    bstrValueName = String that specifies the category of information to be retrieved.
    ///    pbstrValue = Pointer to a string, the meaning of which depends on the value of <i>bstrValueName</i>. If
    ///                 <i>bstrValueName</i> is "RemoteAddress", the string is the requester's IP address.<b>Windows 7: </b>To
    ///                 retrieve the HTTP UserAgent header, set <i>bstrValueName</i> to "HttpUserAgent".
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, the method returns one of the COM error codes
    ///    defined in WinError.h.
    ///    
    HRESULT GetStringValue(BSTR bstrValueName, BSTR* pbstrValue);
    ///The <b>GetGuidValue</b> method currently is not supported.
    ///Params:
    ///    bstrValueName = Not supported.
    ///    pguidValue = Not supported.
    ///Returns:
    ///    This method returns E_INVALIDARG, a COM error code defined in WinError.h.
    ///    
    HRESULT GetGuidValue(BSTR bstrValueName, GUID* pguidValue);
}


// GUIDs

const GUID CLSID_UIAnimationManager            = GUIDOF!UIAnimationManager;
const GUID CLSID_UIAnimationManager2           = GUIDOF!UIAnimationManager2;
const GUID CLSID_UIAnimationTimer              = GUIDOF!UIAnimationTimer;
const GUID CLSID_UIAnimationTransitionFactory  = GUIDOF!UIAnimationTransitionFactory;
const GUID CLSID_UIAnimationTransitionFactory2 = GUIDOF!UIAnimationTransitionFactory2;
const GUID CLSID_UIAnimationTransitionLibrary  = GUIDOF!UIAnimationTransitionLibrary;
const GUID CLSID_UIAnimationTransitionLibrary2 = GUIDOF!UIAnimationTransitionLibrary2;
const GUID CLSID_UPnPDescriptionDocument       = GUIDOF!UPnPDescriptionDocument;
const GUID CLSID_UPnPDescriptionDocumentEx     = GUIDOF!UPnPDescriptionDocumentEx;
const GUID CLSID_UPnPDevice                    = GUIDOF!UPnPDevice;
const GUID CLSID_UPnPDeviceFinder              = GUIDOF!UPnPDeviceFinder;
const GUID CLSID_UPnPDeviceFinderEx            = GUIDOF!UPnPDeviceFinderEx;
const GUID CLSID_UPnPDevices                   = GUIDOF!UPnPDevices;
const GUID CLSID_UPnPRegistrar                 = GUIDOF!UPnPRegistrar;
const GUID CLSID_UPnPRemoteEndpointInfo        = GUIDOF!UPnPRemoteEndpointInfo;
const GUID CLSID_UPnPService                   = GUIDOF!UPnPService;
const GUID CLSID_UPnPServices                  = GUIDOF!UPnPServices;

const GUID IID_IUPnPAddressFamilyControl                 = GUIDOF!IUPnPAddressFamilyControl;
const GUID IID_IUPnPAsyncResult                          = GUIDOF!IUPnPAsyncResult;
const GUID IID_IUPnPDescriptionDocument                  = GUIDOF!IUPnPDescriptionDocument;
const GUID IID_IUPnPDescriptionDocumentCallback          = GUIDOF!IUPnPDescriptionDocumentCallback;
const GUID IID_IUPnPDevice                               = GUIDOF!IUPnPDevice;
const GUID IID_IUPnPDeviceControl                        = GUIDOF!IUPnPDeviceControl;
const GUID IID_IUPnPDeviceControlHttpHeaders             = GUIDOF!IUPnPDeviceControlHttpHeaders;
const GUID IID_IUPnPDeviceDocumentAccess                 = GUIDOF!IUPnPDeviceDocumentAccess;
const GUID IID_IUPnPDeviceDocumentAccessEx               = GUIDOF!IUPnPDeviceDocumentAccessEx;
const GUID IID_IUPnPDeviceFinder                         = GUIDOF!IUPnPDeviceFinder;
const GUID IID_IUPnPDeviceFinderAddCallbackWithInterface = GUIDOF!IUPnPDeviceFinderAddCallbackWithInterface;
const GUID IID_IUPnPDeviceFinderCallback                 = GUIDOF!IUPnPDeviceFinderCallback;
const GUID IID_IUPnPDeviceProvider                       = GUIDOF!IUPnPDeviceProvider;
const GUID IID_IUPnPDevices                              = GUIDOF!IUPnPDevices;
const GUID IID_IUPnPEventSink                            = GUIDOF!IUPnPEventSink;
const GUID IID_IUPnPEventSource                          = GUIDOF!IUPnPEventSource;
const GUID IID_IUPnPHttpHeaderControl                    = GUIDOF!IUPnPHttpHeaderControl;
const GUID IID_IUPnPRegistrar                            = GUIDOF!IUPnPRegistrar;
const GUID IID_IUPnPRemoteEndpointInfo                   = GUIDOF!IUPnPRemoteEndpointInfo;
const GUID IID_IUPnPReregistrar                          = GUIDOF!IUPnPReregistrar;
const GUID IID_IUPnPService                              = GUIDOF!IUPnPService;
const GUID IID_IUPnPServiceAsync                         = GUIDOF!IUPnPServiceAsync;
const GUID IID_IUPnPServiceCallback                      = GUIDOF!IUPnPServiceCallback;
const GUID IID_IUPnPServiceDocumentAccess                = GUIDOF!IUPnPServiceDocumentAccess;
const GUID IID_IUPnPServiceEnumProperty                  = GUIDOF!IUPnPServiceEnumProperty;
const GUID IID_IUPnPServices                             = GUIDOF!IUPnPServices;
