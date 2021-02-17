// Written in the D programming language.

module windows.otherdevicetechnologies;

public import windows.core;
public import windows.audio : IPropertyStore;
public import windows.com : HRESULT, IUnknown;
public import windows.security : CERT_CONTEXT;
public import windows.structuredstorage : PROPVARIANT;
public import windows.systemservices : BOOL, HANDLE, IServiceProvider;
public import windows.windowspropertiessystem : PROPERTYKEY;

extern(Windows):


// Enums


///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions.] Qualifies the filter conditions used
///for searching for function instances. This enumeration is used when adding a constraint to a query using the
///IFunctionInstanceCollectionQuery::AddPropertyConstraint method. A function instance will only match a property
///constraint when the property key (PKEY) passed to AddPropertyConstraint has the same PROPVARIANT type as the PKEY in
///the function instance's property store and the PROPVARIANT value satisfies the constraint's filter conditions.
enum PropertyConstraint : int
{
    ///The constraint's PKEY and the function instance's PKEY must be equal.
    QC_EQUALS             = 0x00000000,
    ///The constraint's PKEY and the function instance's PKEY must not be equal.
    QC_NOTEQUAL           = 0x00000001,
    ///The constraint's PKEY must be less than the function instance's PKEY. This value can be used only with numbers.
    QC_LESSTHAN           = 0x00000002,
    ///The constraint's PKEY must be less than or equal to the function instance's PKEY. This value can be used only
    ///with numbers.
    QC_LESSTHANOREQUAL    = 0x00000003,
    ///The constraint's PKEY must be greater than the function instance's PKEY. This value can be used only with
    ///numbers.
    QC_GREATERTHAN        = 0x00000004,
    ///The constraint's PKEY must be greater than or equal to the function instance's PKEY. This value can be used only
    ///with numbers.
    QC_GREATERTHANOREQUAL = 0x00000005,
    ///The constraint's PKEY must be the start of the function instance's PKEY. This value can be used with strings
    ///only.
    QC_STARTSWITH         = 0x00000006,
    ///The property must exist.
    QC_EXISTS             = 0x00000007,
    ///The property must not exist.
    QC_DOESNOTEXIST       = 0x00000008,
    ///The constraint's PKEY value must be contained within the function instance's PKEY value. This filter is only
    ///supported for PROPVARIANTs of type VT_LPWSTR or VT_VECTOR|VT_LPWSTR. For PROPVARIANTs of type VT_LPWSTR, the
    ///constraint PKEY value must be a substring of the function instance's PKEY value. For PROPVARIANTs of type
    ///VT_VECTOR|VT_LPWSTR, the constraint PKEY value must have exactly one element, and matching function instances
    ///must have a PKEY with at least one vector element that exactly matches the constraint PKEY value.
    QC_CONTAINS           = 0x00000009,
}

///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions.] Determines the visibility of the
///function instance's data.
enum SystemVisibilityFlags : int
{
    ///The function instance's data is available to all users on the system.
    SVF_SYSTEM = 0x00000000,
    ///The function instance's data is accessible only to the current user.
    SVF_USER   = 0x00000001,
}

///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions.] Represents the type of action
///Function Discovery is performing on the specified function instance. This information is used by the client program's
///change notification handler.
enum QueryUpdateAction : int
{
    ///Function Discovery is adding the specified function instance.
    QUA_ADD    = 0x00000000,
    ///Function Discovery is removing the specified function instance.
    QUA_REMOVE = 0x00000001,
    ///Function Discovery is modifying the specified function instance.
    QUA_CHANGE = 0x00000002,
}

enum QueryCategoryType : int
{
    QCT_PROVIDER = 0x00000000,
    QCT_LAYERED  = 0x00000001,
}

alias __MIDL___MIDL_itf_wsdxml_0000_0000_0001 = int;
enum : int
{
    OpNone                  = 0x00000000,
    OpEndOfTable            = 0x00000001,
    OpBeginElement_         = 0x00000002,
    OpBeginAnyElement       = 0x00000003,
    OpEndElement            = 0x00000004,
    OpElement_              = 0x00000005,
    OpAnyElement            = 0x00000006,
    OpAnyElements           = 0x00000007,
    OpAnyText               = 0x00000008,
    OpAttribute_            = 0x00000009,
    OpBeginChoice           = 0x0000000a,
    OpEndChoice             = 0x0000000b,
    OpBeginSequence         = 0x0000000c,
    OpEndSequence           = 0x0000000d,
    OpBeginAll              = 0x0000000e,
    OpEndAll                = 0x0000000f,
    OpAnything              = 0x00000010,
    OpAnyNumber             = 0x00000011,
    OpOneOrMore             = 0x00000012,
    OpOptional              = 0x00000013,
    OpFormatBool_           = 0x00000014,
    OpFormatInt8_           = 0x00000015,
    OpFormatInt16_          = 0x00000016,
    OpFormatInt32_          = 0x00000017,
    OpFormatInt64_          = 0x00000018,
    OpFormatUInt8_          = 0x00000019,
    OpFormatUInt16_         = 0x0000001a,
    OpFormatUInt32_         = 0x0000001b,
    OpFormatUInt64_         = 0x0000001c,
    OpFormatUnicodeString_  = 0x0000001d,
    OpFormatDom_            = 0x0000001e,
    OpFormatStruct_         = 0x0000001f,
    OpFormatUri_            = 0x00000020,
    OpFormatUuidUri_        = 0x00000021,
    OpFormatName_           = 0x00000022,
    OpFormatListInsertTail_ = 0x00000023,
    OpFormatType_           = 0x00000024,
    OpFormatDynamicType_    = 0x00000025,
    OpFormatLookupType_     = 0x00000026,
    OpFormatDuration_       = 0x00000027,
    OpFormatDateTime_       = 0x00000028,
    OpFormatFloat_          = 0x00000029,
    OpFormatDouble_         = 0x0000002a,
    OpProcess_              = 0x0000002b,
    OpQualifiedAttribute_   = 0x0000002c,
    OpFormatXMLDeclaration_ = 0x0000002d,
    OpFormatMax             = 0x0000002e,
}

///Specifies the kind of data stored in a WSD_CONFIG_PARAM structure.
alias WSD_CONFIG_PARAM_TYPE = int;
enum : int
{
    ///The <i>pConfigData</i> member is a pointer to a <b>DWORD</b> that specifies the maximum size, in octets, of an
    ///inbound message. The <i>dwConfigDataSize</i> member is 4.
    WSD_CONFIG_MAX_INBOUND_MESSAGE_SIZE                  = 0x00000001,
    ///The <i>pConfigData</i> member is a pointer to a <b>DWORD</b> that specifies the maximum size, in octets, of an
    ///outbound message. The <i>dwConfigDataSize</i> member is 4.
    WSD_CONFIG_MAX_OUTBOUND_MESSAGE_SIZE                 = 0x00000002,
    ///Used to pass in the client certificate that WSDAPI will use for client authentication in an SSL connection. The
    ///<i>pConfigData</i> member is a pointer to a CERT_CONTEXT structure that represents the client certificate. The
    ///caller needs to have read access to the private key of the certificate. The <i>dwConfigDataSize</i> member is the
    ///size of the CERT_CONTEXT structure.
    WSD_SECURITY_SSL_CERT_FOR_CLIENT_AUTH                = 0x00000003,
    ///Used to pass in the SSL server certificate validation information into WSDAPI. When establishing the SSL
    ///connection, WSDAPI will accept only a server certificate that matches the criteria specified by the
    ///WSD_SECURITY_CERT_VALIDATION structure. The <i>pConfigData</i> member is a pointer to a
    ///WSD_SECURITY_CERT_VALIDATION structure. The <i>dwConfigDataSize</i> member is the size of the
    ///WSD_SECURITY_CERT_VALIDATION structure.
    WSD_SECURITY_SSL_SERVER_CERT_VALIDATION              = 0x00000004,
    ///Used to pass in the SSL client certificate validation information into WSDAPI. On incoming SSL connections, if a
    ///client certificate is available, WSDAPI will reject the connection if the client certificate doesn't match the
    ///validation criteria specified by the WSD_SECURITY_CERT_VALIDATION structure. The <i>pConfigData</i> member is a
    ///pointer to a WSD_SECURITY_CERT_VALIDATION structure. The <i>dwConfigDataSize</i> member is the size of the
    ///WSD_SECURITY_CERT_VALIDATION structure.
    WSD_SECURITY_SSL_CLIENT_CERT_VALIDATION              = 0x00000005,
    ///Specifies that on incoming SSL connections, WSDAPI will request a client certificate from the SSL client if one
    ///is not already made available by the client. If the remote entity cannot provide a client certificate, the
    ///connection will be rejected. Note that the SSL record that is created for that port must expclicitly allow for
    ///client certificate negotiation. The <i>pConfigData</i> member is <b>NULL</b>. The <i>dwConfigDataSize</i> member
    ///is 0.
    WSD_SECURITY_SSL_NEGOTIATE_CLIENT_CERT               = 0x00000006,
    ///Used to specify which certificate is to be used by WSDAPI to sign outbound WS_Discovery UDP messages. The
    ///<i>pConfigData</i> member is a pointer to a CERT_CONTEXT structure that represents the signing certificate. The
    ///caller needs to have read access to the certificate's private key.. The <i>dwConfigDataSize</i> member is the
    ///size of the CERT_CONTEXT structure.
    WSD_SECURITY_COMPACTSIG_SIGNING_CERT                 = 0x00000007,
    ///This is used to specify the parameters used to verify inbound signed WS_Discovery UDP message. The
    ///<i>pConfigData</i> member is a pointer to a WSD_SECURITY_SIGNATURE_VALIDATION structure. The
    ///<i>dwConfigDataSize</i> member is the size of the WSD_SECURITY_SIGNATURE_VALIDATION structure.
    WSD_SECURITY_COMPACTSIG_VALIDATION                   = 0x00000008,
    ///This applies only to the WSDCreateDeviceHost2 function. It is used to specify an array of addresses on which the
    ///device host should be hosted on. The equivalent is functionality provided through the <i>ppHostAddresses</i> and
    ///<i>dwHostAddressCount</i> parameters of the WSDCreateDeviceHostAdvanced function. The <i>pConfigData</i> member
    ///is a pointer to a WSD_CONFIG_ADDRESSES structure. The <b>addresses</b> member of this structure points to an
    ///array of IWSDAddress objects, each of which is an address on which the device host will listen on. The
    ///<i>dwConfigDataSize</i> member is the size of the WSD_CONFIG_ADDRESSES structure.
    WSD_CONFIG_HOSTING_ADDRESSES                         = 0x00000009,
    ///This applies only to the WSDCreateDeviceProxy2 function. It is used to specify an address for the device for
    ///which the proxy is created. The equivalent is functionality provided through the <i>deviceConfig</i> parameter of
    ///the WSDCreateDeviceProxyAdvanced function. The <i>pConfigData</i> member is a pointer to a WSD_CONFIG_ADDRESSES
    ///structure. The <b>addresses</b> member of this structure points to an array of IWSDAddress objects, each of which
    ///is an address of the device to which the proxy is created. Currently only one such address is allowed. The
    ///<i>dwConfigDataSize</i> member is the size of the WSD_CONFIG_ADDRESSES structure.
    WSD_CONFIG_DEVICE_ADDRESSES                          = 0x0000000a,
    ///Indicates a requirement for HTTP Authentication using one of the auth schemes specified through
    ///WSD_SECURITY_HTTP_AUTH_SCHEMES. Specific scenarios include: <ul> <li> When specified during a WSDCreateDeviceHost
    ///operation, DPWS clients will be required to authenticate messages sent to the Hosted Services of the WSDAPI
    ///device host using HTTP Authentication. </li> <li> If this is value is expressed in conjunction with
    ///WSD_SECURITY_SSL_NEGOTIATE_CLIENT_CERT, then WSDAPI will require HTTP clients to send a client certificate and
    ///utilize HTTP authentication. </li> </ul>
    WSD_SECURITY_REQUIRE_HTTP_CLIENT_AUTH                = 0x0000000b,
    ///When this value is specified, WSDAPI will request HTTP clients to send a client certificate. If the client cannot
    ///provide one, then WSDAPI will require HTTP authentication. If the client can do neither, it will be rejected by
    ///WSDAPI. Specific scenarios include: <ul> <li> When specified during a WSDCreateDeviceHost operation, this
    ///behavior will apply to web service messages from DPWS clients. </li> </ul> <div class="alert"><b>Note</b> This
    ///parameter cannot be used in conjunction with WSD_SECURITY_SSL_NEGOTIATE_CLIENT_CERT. If it is, WSDAPI will return
    ///E_INVALIDARG.</div> <div> </div>
    WSD_SECURITY_REQUIRE_CLIENT_CERT_OR_HTTP_CLIENT_AUTH = 0x0000000c,
    WSD_SECURITY_USE_HTTP_CLIENT_AUTH                    = 0x0000000d,
}

///Identifies the type of UDP message.
enum WSDUdpMessageType : int
{
    ///The message is a one-way UDP message without a corresponding response. Hello and Bye messages are one-way
    ///messages.
    ONE_WAY = 0x00000000,
    TWO_WAY = 0x00000001,
}

enum DeviceDiscoveryMechanism : int
{
    MulticastDiscovery      = 0x00000000,
    DirectedDiscovery       = 0x00000001,
    SecureDirectedDiscovery = 0x00000002,
}

///Identifies the type of protocol supported by a port.
alias WSD_PROTOCOL_TYPE = int;
enum : int
{
    ///No protocols supported.
    WSD_PT_NONE  = 0x00000000,
    ///The UDP protocol is supported.
    WSD_PT_UDP   = 0x00000001,
    ///The HTTP protocol is supported.
    WSD_PT_HTTP  = 0x00000002,
    ///The HTTPS protocol is supported.
    WSD_PT_HTTPS = 0x00000004,
    ///The UDP, HTTP, and HTTPS protocols are supported.
    WSD_PT_ALL   = 0x000000ff,
}

///Identifies the type of event produced by the session layer.
enum WSDEventType : int
{
    ///No events were detected.
    WSDET_NONE                 = 0x00000000,
    ///An incoming message was detected.
    WSDET_INCOMING_MESSAGE     = 0x00000001,
    ///An incoming message fault was detected.
    WSDET_INCOMING_FAULT       = 0x00000002,
    ///A message transmission failure was detected.
    WSDET_TRANSMISSION_FAILURE = 0x00000003,
    WSDET_RESPONSE_TIMEOUT     = 0x00000004,
}

// Callbacks

///Describes a stub function used to handle an incoming message. This function should only be implemented in and used by
///generated code.
///Params:
///    server = Pointer to the service object that was registered as a handler for messages of this type. Service objects are
///             registered by calling one of the following methods: IWSDDeviceHost::RegisterService,
///             IWSDDeviceHost::AddDynamicService, or IWSDServiceProxy::SubscribeToOperation.
///    session = Pointer to an IWSDServiceMessaging object used for sending a fault or message response.
///    event = Pointer to a WSD_EVENT structure that contains the data for the current request.
alias WSD_STUB_FUNCTION = HRESULT function(IUnknown server, IWSDServiceMessaging session, WSD_EVENT* event);
///References a SOAP message handler for incoming messages. This is an internal function pointer, and it should not be
///used by WSDAPI clients or services.
///Params:
///    thisUnknown = Pointer to the object calling this function.
///    event = A WSD_EVENT structure containing the message to be handled.
alias PWSD_SOAP_MESSAGE_HANDLER = HRESULT function(IUnknown thisUnknown, WSD_EVENT* event);

// Structs


struct IFunctionInstanceQuery2
{
}

struct IFunctionInstanceCollectionQuery2
{
}

struct IFunctionInstanceCollectionQueryCollection
{
}

struct IFunctionDiscoveryProviderRefresh
{
}

///Represents a timestamp.
struct WSD_DATETIME
{
    ///<b>TRUE</b> if <i>year</i> value is positive.
    BOOL  isPositive;
    ///Year value (for example, 2005). This number is a value between 0 and max(ULONG).
    uint  year;
    ///One-based month value (1 = January, through 12 = December).
    ubyte month;
    ///One-based day of the month value (1-31).
    ubyte day;
    ///Zero-based hour value (0 through 23). <i>hour</i>=24 is only allowed if both <i>minute</i> and <i>second</i> are
    ///0.
    ubyte hour;
    ///Zero-based minute value (0 through 59).
    ubyte minute;
    ///Zero-based second value (0 through 59).
    ubyte second;
    ///Millisecond value (0-999). When this structure is converted to XML, the millisecond value is expressed as a
    ///fraction of a second in decimal form. For example, if <b>millisecond</b> has a value of 9, then the XML output
    ///will be 0.009.
    uint  millisecond;
    ///<b>TRUE</b> if date and time are based on the local time zone, <b>FALSE</b> if UTC + offset.
    BOOL  TZIsLocal;
    ///<b>TRUE</b> if time zone offset specified by <i>TZHour</i> and <i>TZMinute</i> is positive relative to UTC,
    ///<b>FALSE</b> if offset is negative. Not valid if <i>TZIsLocal</i> is <b>TRUE</b>.
    BOOL  TZIsPositive;
    ///Time zone offset relative to UTC (0-13). <i>TZhour</i>=14 is allowed if <i>TZMinute</i> is 0. Not valid if
    ///<i>TZIsLocal</i> is <b>TRUE</b>.
    ubyte TZHour;
    ubyte TZMinute;
}

///Represents a length of time.
struct WSD_DURATION
{
    ///This parameter is <b>TRUE</b> if the entire duration is positive.
    BOOL isPositive;
    ///The year value. This number is a value between 0 and max(ULONG).
    uint year;
    ///The month value. This number is a value between 0 and max(ULONG).
    uint month;
    ///The day value. This number is a value between 0 and max(ULONG).
    uint day;
    ///The hour value. This number is a value between 0 and max(ULONG).
    uint hour;
    ///The minute value. This number is a value between 0 and max(ULONG).
    uint minute;
    ///The second value. This number is a value between 0 and max(ULONG).
    uint second;
    ///The millisecond value (0-999).
    uint millisecond;
}

///Represents configuration parameters for creating <code>WSDAPI</code> objects.
struct WSD_CONFIG_PARAM
{
    ///A WSD_CONFIG_PARAM_TYPE value that indicates the type configuration data contained in this structure.
    WSD_CONFIG_PARAM_TYPE configParamType;
    ///A pointer to a single configuration data structure. The <i>configParamType</i> member specifies the type of data
    ///passed in.
    void* pConfigData;
    uint  dwConfigDataSize;
}

///Represents the criteria for matching client certificates against those of an HTTPS server. Do not use
///WSD_SECURITY_CERT_VALIDATION_V1 directly in your code; using <b>WSD_SECURITY_CERT_VALIDATION</b> instead ensures that
///the proper version, based on the Windows version.
struct WSD_SECURITY_CERT_VALIDATION_V1
{
    ///An array of CERT_CONTEXT structures that contain certificates to be matched against those provided by the HTTPS
    ///server or client. Only one matching certificate is required for validatation. This parameter can be NULL.
    CERT_CONTEXT** certMatchArray;
    ///The count of certificates in <i>certMatchArray</i>.
    uint           dwCertMatchArrayCount;
    ///A handle to a certificate store that contains certificates to be matched against those provided by the HTTPS
    ///server or client. Only one matching certificate is required for validatation. This parameter can be NULL.
    void*          hCertMatchStore;
    ///A handle to a certificate store that contains root certificates against which a certificate from the HTTPS server
    ///or client should chain to. Validation succeeds as long as the certificate chains up to at least one root
    ///certificate. This parameter can be NULL.
    void*          hCertIssuerStore;
    ///A bitwise OR combination of values that specify which certificate checks to ignore. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="WSDAPI_SSL_CERT_DEFAULT_CHECKS"></a><a
    ///id="wsdapi_ssl_cert_default_checks"></a><dl> <dt><b>WSDAPI_SSL_CERT_DEFAULT_CHECKS</b></dt> <dt>0x0</dt> </dl>
    ///</td> <td width="60%"> Handle any revoked certificate errors. </td> </tr> <tr> <td width="40%"><a
    ///id="WSDAPI_SSL_CERT_IGNORE_REVOCATION"></a><a id="wsdapi_ssl_cert_ignore_revocation"></a><dl>
    ///<dt><b>WSDAPI_SSL_CERT_IGNORE_REVOCATION</b></dt> <dt>0x1</dt> </dl> </td> <td width="60%"> Ignore revoked
    ///certificate errors. </td> </tr> <tr> <td width="40%"><a id="WSDAPI_SSL_CERT_IGNORE_EXPIRY"></a><a
    ///id="wsdapi_ssl_cert_ignore_expiry"></a><dl> <dt><b>WSDAPI_SSL_CERT_IGNORE_EXPIRY</b></dt> <dt>0x2</dt> </dl>
    ///</td> <td width="60%"> Ignore expired certificate errors. </td> </tr> <tr> <td width="40%"><a
    ///id="WSDAPI_SSL_CERT_IGNORE_WRONG_USAGE"></a><a id="wsdapi_ssl_cert_ignore_wrong_usage"></a><dl>
    ///<dt><b>WSDAPI_SSL_CERT_IGNORE_WRONG_USAGE</b></dt> <dt>0x4</dt> </dl> </td> <td width="60%"> Ignore certificate
    ///use errors. </td> </tr> <tr> <td width="40%"><a id="WSDAPI_SSL_CERT_IGNORE_UNKNOWN_CA"></a><a
    ///id="wsdapi_ssl_cert_ignore_unknown_ca"></a><dl> <dt><b>WSDAPI_SSL_CERT_IGNORE_UNKNOWN_CA</b></dt> <dt>0x8</dt>
    ///</dl> </td> <td width="60%"> Ignore unknown certificate authority errors. </td> </tr> <tr> <td width="40%"><a
    ///id="WSDAPI_SSL_CERT_IGNORE_INVALID_CN"></a><a id="wsdapi_ssl_cert_ignore_invalid_cn"></a><dl>
    ///<dt><b>WSDAPI_SSL_CERT_IGNORE_INVALID_CN</b></dt> <dt>0x10</dt> </dl> </td> <td width="60%"> Ignore invalid
    ///common name certificate errors. </td> </tr> </table>
    uint           dwCertCheckOptions;
}

///Represents the criteria for matching client certificates against those of an HTTPS server. Do not use
///WSD_SECURITY_CERT_VALIDATION_V1 directly in your code; using <b>WSD_SECURITY_CERT_VALIDATION</b> instead ensures that
///the proper version, based on the Windows version.
struct WSD_SECURITY_CERT_VALIDATION
{
    ///An array of CERT_CONTEXT structures that contain certificates to be matched against those provided by the HTTPS
    ///server or client. Only one matching certificate is required for validatation. This parameter can be NULL.
    CERT_CONTEXT** certMatchArray;
    ///The count of certificates in <i>certMatchArray</i>.
    uint           dwCertMatchArrayCount;
    ///A handle to a certificate store that contains certificates to be matched against those provided by the HTTPS
    ///server or client. Only one matching certificate is required for validatation. This parameter can be NULL.
    void*          hCertMatchStore;
    ///A handle to a certificate store that contains root certificates against which a certificate from the HTTPS server
    ///or client should chain to. Validation succeeds as long as the certificate chains up to at least one root
    ///certificate. This parameter can be NULL.
    void*          hCertIssuerStore;
    ///A bitwise OR combination of values that specify which certificate checks to ignore. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="WSDAPI_SSL_CERT_DEFAULT_CHECKS"></a><a
    ///id="wsdapi_ssl_cert_default_checks"></a><dl> <dt><b>WSDAPI_SSL_CERT_DEFAULT_CHECKS</b></dt> <dt>0x0</dt> </dl>
    ///</td> <td width="60%"> Handle any revoked certificate errors. </td> </tr> <tr> <td width="40%"><a
    ///id="WSDAPI_SSL_CERT_IGNORE_REVOCATION"></a><a id="wsdapi_ssl_cert_ignore_revocation"></a><dl>
    ///<dt><b>WSDAPI_SSL_CERT_IGNORE_REVOCATION</b></dt> <dt>0x1</dt> </dl> </td> <td width="60%"> Ignore revoked
    ///certificate errors. </td> </tr> <tr> <td width="40%"><a id="WSDAPI_SSL_CERT_IGNORE_EXPIRY"></a><a
    ///id="wsdapi_ssl_cert_ignore_expiry"></a><dl> <dt><b>WSDAPI_SSL_CERT_IGNORE_EXPIRY</b></dt> <dt>0x2</dt> </dl>
    ///</td> <td width="60%"> Ignore expired certificate errors. </td> </tr> <tr> <td width="40%"><a
    ///id="WSDAPI_SSL_CERT_IGNORE_WRONG_USAGE"></a><a id="wsdapi_ssl_cert_ignore_wrong_usage"></a><dl>
    ///<dt><b>WSDAPI_SSL_CERT_IGNORE_WRONG_USAGE</b></dt> <dt>0x4</dt> </dl> </td> <td width="60%"> Ignore certificate
    ///use errors. </td> </tr> <tr> <td width="40%"><a id="WSDAPI_SSL_CERT_IGNORE_UNKNOWN_CA"></a><a
    ///id="wsdapi_ssl_cert_ignore_unknown_ca"></a><dl> <dt><b>WSDAPI_SSL_CERT_IGNORE_UNKNOWN_CA</b></dt> <dt>0x8</dt>
    ///</dl> </td> <td width="60%"> Ignore unknown certificate authority errors. </td> </tr> <tr> <td width="40%"><a
    ///id="WSDAPI_SSL_CERT_IGNORE_INVALID_CN"></a><a id="wsdapi_ssl_cert_ignore_invalid_cn"></a><dl>
    ///<dt><b>WSDAPI_SSL_CERT_IGNORE_INVALID_CN</b></dt> <dt>0x10</dt> </dl> </td> <td width="60%"> Ignore invalid
    ///common name certificate errors. </td> </tr> </table>
    uint           dwCertCheckOptions;
    const(wchar)*  pszCNGHashAlgId;
    ubyte*         pbCertHash;
    uint           dwCertHashSize;
}

///Represents the criteria for matching client compact signatures against messages.
struct WSD_SECURITY_SIGNATURE_VALIDATION
{
    ///An array of CERT_CONTEXT stuctures that contain certificates to be matched against a message. Only one matching
    ///certificate is required for validatation. This parameter can be <b>NULL</b>.
    CERT_CONTEXT** signingCertArray;
    ///The count of certificates in <i>signingMatchArray</i>.
    uint           dwSigningCertArrayCount;
    ///A handle to a certificate store that contains certificates to be matched against a message. Only one matching
    ///certificate is required for validatation. This parameter can be <b>NULL</b>.
    void*          hSigningCertStore;
    ///A flag that specifies how unsigned messages are handled. If set to <b>WSDAPI_COMPACTSIG_ACCEPT_ALL_MESSAGES</b>,
    ///then the discovery object will accept unsigned messages, signed-and-verified messages and signed-but-verified,
    ///(that is, those for which the signing cert could not be found either in the store or the certificate array)
    ///messages. If this flag is not set, then only the signed-and-verified messages will be accepted. If
    ///<b>WSDAPI_COMPACTSIG_ACCEPT_ALL_MESSAGES</b> is specified, the caller will not be able use the
    ///IWSDSignatureProperty interface to learn whether the message was signed or not.
    uint           dwFlags;
}

///Information about specific addresses that a host should listen on.
struct WSD_CONFIG_ADDRESSES
{
    ///An array of pointers to IWSDAddress interfaces. If <i>pszLocalId</i> contains a logical address, the resulting
    ///behavior is a mapping between the logical address and a specific set of physical addresses (instead of a mapping
    ///between the logical address and a default physical address).
    IWSDAddress* addresses;
    uint         dwAddressCount;
}

///Defines the parameters for repeating a message transimission.
struct WSDUdpRetransmitParams
{
    ///Time to wait before sending the first transmission, in milliseconds. Specify zero for no delay. Cannot be
    ///INFINITE.
    uint ulSendDelay;
    ///Maximum number of transmissions to send. Specify a value between 1 and 256, inclusively.
    uint ulRepeat;
    ///Minimum value of the range used to generate the initial delay value, in milliseconds. This value must be less
    ///than or equal to <b>ulRepeatMaxDelay</b>, can be zero, but cannot be INFINITE. See Remarks.
    uint ulRepeatMinDelay;
    ///Maximum value of the range used to generate the initial delay value, in milliseconds. This value be less than or
    ///equal to <b>ulRepeatUpperDelay</b>, can be zero, but cannot be INFINITE. See Remarks.
    uint ulRepeatMaxDelay;
    ///Maximum delay to wait before sending message, in milliseconds. This value be can be zero, but cannot be INFINITE.
    uint ulRepeatUpperDelay;
}

struct SOCKADDR_STORAGE
{
}

///Describes an operation as defined by WSDL in terms of one or two messages. This structure is populated by generated
///code.
struct WSD_OPERATION
{
    ///Reference to a WSDXML_TYPE structure that specifies the request type of an incoming message.
    WSDXML_TYPE*      RequestType;
    ///Reference to a WSDXML_TYPE structure that specifies the response type of an outgoing message.
    WSDXML_TYPE*      ResponseType;
    WSD_STUB_FUNCTION RequestStubFunction;
}

///Specifies the context for handling incoming messages.
struct WSD_HANDLER_CONTEXT
{
    ///PSWD_SOAP_MESSAGE_HANDLER function that specifies the incoming message handler.
    PWSD_SOAP_MESSAGE_HANDLER Handler;
    ///The value supplied by the <i>pVoidContext</i> parameter of the IWSDSession::AddPort,
    ///IWSDSession::RegisterForIncomingRequests, or IWSDSession::RegisterForIncomingResponse methods.
    void*    PVoid;
    IUnknown Unknown;
}

///Provides a context for handling the response to a two-way request.
struct WSD_SYNCHRONOUS_RESPONSE_CONTEXT
{
    ///The result code of the last operation performed using this response context.
    HRESULT hr;
    ///The event handle to be signaled when the response is ready.
    HANDLE  eventHandle;
    ///A pointer to an IWSDMessageParameters object that contains transport information associated with the response.
    IWSDMessageParameters messageParameters;
    void*   results;
}

///Supplies data about a port type. This structure is populated by generated code.
struct WSD_PORT_TYPE
{
    ///The encoded qualified name of the port type.
    uint              EncodedName;
    ///The number of operations in the array referenced by the <b>Operations</b> member.
    uint              OperationCount;
    ///Reference to an array of WSD_OPERATION structures that specifies the operations comprising the port type.
    WSD_OPERATION*    Operations;
    WSD_PROTOCOL_TYPE ProtocolType;
}

///Provides metadata about the relationship between two or more services.
struct WSD_RELATIONSHIP_METADATA
{
    ///A WS-Discovery Type.
    const(wchar)*      Type;
    ///Reference to a WSD_HOST_METADATA structure that contains metadata for all services hosted by a device.
    WSD_HOST_METADATA* Data;
    WSDXML_ELEMENT*    Any;
}

///Represents a node in a single-linked list of service metadata structures.
struct WSD_SERVICE_METADATA_LIST
{
    ///Reference to the next node in the linked list of <b>WSD_SERVICE_METADATA_LIST</b> structures.
    WSD_SERVICE_METADATA_LIST* Next;
    ///Reference to a WSD_SERVICE_METADATA structure that represents the service metadata referenced by this node.
    WSD_SERVICE_METADATA* Element;
}

///Provides metadata for all services hosted by a device.
struct WSD_HOST_METADATA
{
    ///Reference to a WSD_SERVICE_METADATA structure that describes the parent service or the device.
    WSD_SERVICE_METADATA* Host;
    WSD_SERVICE_METADATA_LIST* Hosted;
}

///Represents a node in a single-linked list of WSD_ENDPOINT_REFERENCE structures.
struct WSD_ENDPOINT_REFERENCE_LIST
{
    ///Reference to the next node in the linked list of <b>WSD_ENDPOINT_REFERENCE_LIST</b> structures.
    WSD_ENDPOINT_REFERENCE_LIST* Next;
    ///Reference to a WSD_ENDPOINT_REFERENCE structure that contains the endpoint referenced by this node.
    WSD_ENDPOINT_REFERENCE* Element;
}

///Provides metadata regarding a service hosted by a device.
struct WSD_SERVICE_METADATA
{
    ///Reference to a WSD_ENDPOINT_REFERENCE_LIST structure that specifies the endpoints at which the service is
    ///available.
    WSD_ENDPOINT_REFERENCE_LIST* EndpointReference;
    ///Reference to a WSD_NAME_LIST structure that contains a list of WS-Discovery Types.
    WSD_NAME_LIST*  Types;
    ///The URI of the service. This URI must be valid when a <b>WSD_SERVICE_METADATA</b> structure is passed to
    ///IWSDDeviceHost::SetMetadata. Applications are responsible for URI validation.
    const(wchar)*   ServiceId;
    WSDXML_ELEMENT* Any;
}

///Specifies metadata that is unique to a specific device.
struct WSD_THIS_DEVICE_METADATA
{
    ///Reference to a WSD_LOCALIZED_STRING_LIST structure that contains the list of localized friendly names for the
    ///device. It should be set to fewer than 256 characters.
    WSD_LOCALIZED_STRING_LIST* FriendlyName;
    ///The firmware version of the device. It should be set to fewer than 256 characters.
    const(wchar)*   FirmwareVersion;
    ///The serial number of the device. It should be set to fewer than 256 characters.
    const(wchar)*   SerialNumber;
    ///Reference to a WSDXML_ELEMENT structure that provides an extensible space for devices to add custom metadata to
    ///the device specific section. For example, you can use this to add a user-defined name for the device.
    WSDXML_ELEMENT* Any;
}

///Provides model-specific information relating to the device.
struct WSD_THIS_MODEL_METADATA
{
    ///Reference to a WSD_LOCALIZED_STRING_LIST structure that contains the manufacturer name. The name should be set to
    ///fewer than 2048 characters.
    WSD_LOCALIZED_STRING_LIST* Manufacturer;
    ///The URL to a Web site for the device manufacturer. The URL should have fewer than 2048 characters.
    const(wchar)*   ManufacturerUrl;
    ///Reference to a WSD_LOCALIZED_STRING_LIST structure that specifies model names. This is a list of localized
    ///friendly names that should be set to fewer than 256 characters.
    WSD_LOCALIZED_STRING_LIST* ModelName;
    ///The model number. This should be set to fewer than 256 characters.
    const(wchar)*   ModelNumber;
    ///The URL to a Web site for this device model. The URL should have fewer than 2048 characters.
    const(wchar)*   ModelUrl;
    ///An HTML page for this device. This can be relative to a base URL set by XML Base. The URL should have fewer than
    ///2048 characters.
    const(wchar)*   PresentationUrl;
    ///Reference to a WSDXML_ELEMENT structure that specifies extension content allowed by the XML <b>ANY</b> keyword.
    WSDXML_ELEMENT* Any;
}

///Represents a node in a single-linked list of localized strings.
struct WSD_LOCALIZED_STRING_LIST
{
    ///Reference to the next node in the linked list of <b>WSD_LOCALIZED_STRING_LIST</b> structures.
    WSD_LOCALIZED_STRING_LIST* Next;
    WSD_LOCALIZED_STRING* Element;
}

///A collection of reason codes associated with a WSD_SOAP_FAULT. A reason code is a human readable explanation of the
///fault.
struct WSD_SOAP_FAULT_REASON
{
    ///A WSD_LOCALIZED_STRING_LIST structure that contains a collection of localized reason codes.
    WSD_LOCALIZED_STRING_LIST* Text;
}

///Represents a generated SOAP fault subcode. Subcodes can be nested.
struct WSD_SOAP_FAULT_SUBCODE
{
    ///A WSDXML_NAME structure that contains the qualified name of the SOAP fault subcode.
    WSDXML_NAME* Value;
    ///A <b>WSD_SOAP_FAULT_SUBCODE</b> structure that contains a fault subcode.
    WSD_SOAP_FAULT_SUBCODE* Subcode;
}

///Represents a generated SOAP fault code.
struct WSD_SOAP_FAULT_CODE
{
    ///A WSDXML_NAME structure that contains the qualified name of the SOAP fault code.
    WSDXML_NAME* Value;
    ///A WSD_SOAP_FAULT_SUBCODE structure that contains the fault subcode.
    WSD_SOAP_FAULT_SUBCODE* Subcode;
}

///Represents a generated SOAP fault.
struct WSD_SOAP_FAULT
{
    ///A WSD_SOAP_FAULT_CODE structure that contains a SOAP fault code.
    WSD_SOAP_FAULT_CODE* Code;
    ///A WSD_SOAP_FAULT_REASON structure that contains localized human readable explanations of the fault.
    WSD_SOAP_FAULT_REASON* Reason;
    ///The SOAP node on the SOAP message path that caused the fault.
    const(wchar)*        Node;
    ///The SOAP role in which the <b>Node</b> was acting at the time the fault occurred.
    const(wchar)*        Role;
    ///A WSDXML_ELEMENT structure that contains application-specific error information pertaining to the fault.
    WSDXML_ELEMENT*      Detail;
}

///Represents application sequence information relating to WS-Discovery messages.
struct WSD_APP_SEQUENCE
{
    ///The instance identifier.
    ulong         InstanceId;
    ///The sequence identifier.
    const(wchar)* SequenceId;
    ///The message number.
    ulong         MessageNumber;
}

///Represents a RelatesTo SOAP envelope header block, as specified by the WS-Addressing specification.
struct WSD_HEADER_RELATESTO
{
    ///Reference to a WSDXML_NAME structure that contains the relationship type as a qualified name.
    WSDXML_NAME*  RelationshipType;
    const(wchar)* MessageID;
}

///Provides SOAP header data for the WSD_SOAP_MESSAGE structure.
struct WSD_SOAP_HEADER
{
    ///The URI to which the SOAP message is addressed.
    const(wchar)*        To;
    ///The action encoded by the SOAP message.
    const(wchar)*        Action;
    ///An identifier that distinguishes the message from others from the same sender.
    const(wchar)*        MessageID;
    ///In response messages, specifies the message ID of the matching request message.
    WSD_HEADER_RELATESTO RelatesTo;
    ///In request messages, a reference to a WSD_ENDPOINT_REFERENCE structure that specifies to the endpoint to which
    ///responses should be sent.
    WSD_ENDPOINT_REFERENCE* ReplyTo;
    ///Reference to a WSD_ENDPOINT_REFERENCE structure that specifies the endpoint from which the SOAP message was sent.
    WSD_ENDPOINT_REFERENCE* From;
    ///Reference to a WSD_ENDPOINT_REFERENCE structure that specifies to the endpoint to which fault messages should be
    ///sent.
    WSD_ENDPOINT_REFERENCE* FaultTo;
    ///In discovery messages, a reference to a WSD_APP_SEQUENCE structure that helps the recipient determine the order
    ///in which messages were issued by the sender.
    WSD_APP_SEQUENCE*    AppSequence;
    WSDXML_ELEMENT*      AnyHeaders;
}

///The contents of a WSD SOAP message. This structure is used for Probe messages, ProbeMatch messages, Resolve messages,
///and ResolveMatch messages, among others.
struct WSD_SOAP_MESSAGE
{
    ///A WSD_SOAP_HEADER structure that specifies the header of the SOAP message.
    WSD_SOAP_HEADER Header;
    ///The body of the SOAP message.
    void*           Body;
    ///Reference to a WSDXML_TYPE structure that specifies the type of the SOAP message body.
    WSDXML_TYPE*    BodyType;
}

///Represents a ResolveMatches message.
struct WSD_RESOLVE_MATCHES
{
    ///Reference to a WSD_RESOLVE_MATCH structure that contains a child ResolveMatch message.
    WSD_RESOLVE_MATCH* ResolveMatch;
    ///Reference to a WSDXML_ELEMENT structure that specifies extension content allowed by the XML <b>ANY</b> keyword.
    WSDXML_ELEMENT*    Any;
}

///Represents a ResolveMatch message.
struct WSD_RESOLVE_MATCH
{
    ///Reference to a WSD_ENDPOINT_REFERENCE structure that specifies the matching endpoint.
    WSD_ENDPOINT_REFERENCE* EndpointReference;
    ///Reference to a WSD_NAME_LIST structure that contains a list of WS-Discovery Types.
    WSD_NAME_LIST*  Types;
    ///Reference to a WSD_SCOPES structure that contains a list of WS-Discovery Scopes.
    WSD_SCOPES*     Scopes;
    ///Reference to a WSD_URI_LIST structure that contains a list of WS-Discovery XAddrs.
    WSD_URI_LIST*   XAddrs;
    ///The metadata version of this message.
    ulong           MetadataVersion;
    ///Reference to a WSDXML_ELEMENT structure that specifies extension content allowed by the XML <b>ANY</b> keyword.
    WSDXML_ELEMENT* Any;
}

///Represents a Resolve message.
struct WSD_RESOLVE
{
    ///Reference to a WSD_ENDPOINT_REFERENCE structure that specifies the endpoint to match.
    WSD_ENDPOINT_REFERENCE* EndpointReference;
    ///Reference to a WSDXML_ELEMENT structure that specifies extension content allowed by the XML <b>ANY</b> keyword.
    WSDXML_ELEMENT* Any;
}

///Represents a ProbeMatch message.
struct WSD_PROBE_MATCH
{
    ///Reference to a WSD_ENDPOINT_REFERENCE structure that specifies the matching endpoint.
    WSD_ENDPOINT_REFERENCE* EndpointReference;
    ///Reference to a WSD_NAME_LIST structure that contains a list of WS-Discovery Types.
    WSD_NAME_LIST*  Types;
    ///Reference to a WSD_SCOPES structure that contains a list of WS-Discovery Scopes.
    WSD_SCOPES*     Scopes;
    ///Reference to a WSD_URI_LIST structure that contains a list of WS-Discovery XAddrs.
    WSD_URI_LIST*   XAddrs;
    ///The metadata version of this message.
    ulong           MetadataVersion;
    ///Reference to a WSDXML_ELEMENT structure that specifies extension content allowed by the XML <b>ANY</b> keyword.
    WSDXML_ELEMENT* Any;
}

///Represents a node in a single-linked list of ProbeMatch message structures.
struct WSD_PROBE_MATCH_LIST
{
    ///Reference to the next node in the linked list of <b>WSD_PROBE_MATCH_LIST</b> structures.
    WSD_PROBE_MATCH_LIST* Next;
    ///Reference to a WSD_PROBE_MATCH structure that contains the ProbeMatch message referenced by this node.
    WSD_PROBE_MATCH* Element;
}

///Represents a ProbeMatches message.
struct WSD_PROBE_MATCHES
{
    ///Reference to a WSD_PROBE_MATCH_LIST structure that contains the list of matches to the Probe message.
    WSD_PROBE_MATCH_LIST* ProbeMatch;
    ///Reference to a WSDXML_ELEMENT structure that specifies extension content allowed by the XML <b>ANY</b> keyword.
    WSDXML_ELEMENT* Any;
}

///Represents a Probe message.
struct WSD_PROBE
{
    ///Reference to a WSD_NAME_LIST structure that contains a list of WS-Discovery Types.
    WSD_NAME_LIST*  Types;
    ///Reference to a WSD_SCOPES structure that contains a list of WS-Discovery Scopes.
    WSD_SCOPES*     Scopes;
    ///Reference to a WSDXML_ELEMENT structure that specifies extension content allowed by the XML <b>ANY</b> keyword.
    WSDXML_ELEMENT* Any;
}

///Represents a Bye message.
struct WSD_BYE
{
    ///Reference to a WSD_ENDPOINT_REFERENCE structure that specifies either the sending or receiving endpoint of the
    ///Bye message.
    WSD_ENDPOINT_REFERENCE* EndpointReference;
    ///Reference to a WSDXML_ELEMENT structure that specifies content allowed by the XML <b>ANY</b> keyword.
    WSDXML_ELEMENT* Any;
}

///A collection of scopes used in WS-Discovery messaging.
struct WSD_SCOPES
{
    ///A matching rule used for scopes.
    const(wchar)* MatchBy;
    WSD_URI_LIST* Scopes;
}

///Represents a node in a single-linked list of XML name structures.
struct WSD_NAME_LIST
{
    ///Reference to the next node in the linked list of <b>WSD_NAME_LIST</b> structures.
    WSD_NAME_LIST* Next;
    WSDXML_NAME*   Element;
}

///Represents a Hello message.
struct WSD_HELLO
{
    ///Reference to a WSD_ENDPOINT_REFERENCE structure that specifies the endpoint announcing the Hello message.
    WSD_ENDPOINT_REFERENCE* EndpointReference;
    ///Reference to a WSD_NAME_LIST structure that contains a list of WS-Discovery Types.
    WSD_NAME_LIST*  Types;
    ///Reference to a WSD_SCOPES structure that contains a list of WS-Discovery Scopes.
    WSD_SCOPES*     Scopes;
    ///Reference to a WSD_URI_LIST structure that contains a list of WS-Discovery XAddrs.
    WSD_URI_LIST*   XAddrs;
    ///The metadata version of this message.
    ulong           MetadataVersion;
    ///Reference to a WSDXML_ELEMENT structure that specifies extension content allowed by the XML <b>ANY</b> keyword.
    WSDXML_ELEMENT* Any;
}

///Specifies opaque data that is used by an endpoint.
struct WSD_REFERENCE_PARAMETERS
{
    ///Reference to a WSDXML_ELEMENT structure that specifies extension content allowed by the XML <b>ANY</b> keyword.
    WSDXML_ELEMENT* Any;
}

///Specifies additional data used to uniquely identify an endpoint.
struct WSD_REFERENCE_PROPERTIES
{
    ///Reference to a WSDXML_ELEMENT structure that specifies extension content allowed by the XML <b>ANY</b> keyword.
    WSDXML_ELEMENT* Any;
}

///Represents a WS-Addressing endpoint reference.
struct WSD_ENDPOINT_REFERENCE
{
    ///The endpoint address.
    const(wchar)*   Address;
    ///WSD_REFERENCE_PROPERTIES structure that specifies additional data used to uniquely identify the endpoint.
    WSD_REFERENCE_PROPERTIES ReferenceProperties;
    ///WSD_REFERENCE_PARAMETERS structure that specifies additional opaque data used by the endpoint.
    WSD_REFERENCE_PARAMETERS ReferenceParameters;
    ///Reference to a WSDXML_NAME structure that specifies the port type of the service at the referenced endpoint.
    WSDXML_NAME*    PortType;
    ///Reference to a WSDXML_NAME structure that specifies the service name of the service at the referenced endpoint.
    WSDXML_NAME*    ServiceName;
    WSDXML_ELEMENT* Any;
}

///Represents a section of metadata in a generic form. <div class="alert"><b>Note</b> Only one of the <b>Data</b>,
///<b>MetadataReference</b>, or <b>Location</b> members should be specified.</div><div> </div>
struct WSD_METADATA_SECTION
{
    ///The format and version of the metadata section. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="http___schemas.xmlsoap.org_ws_2006_02_devprof_ThisModel"></a><a
    ///id="http___schemas.xmlsoap.org_ws_2006_02_devprof_thismodel"></a><a
    ///id="HTTP___SCHEMAS.XMLSOAP.ORG_WS_2006_02_DEVPROF_THISMODEL"></a><dl>
    ///<dt><b>http://schemas.xmlsoap.org/ws/2006/02/devprof/ThisModel</b></dt> </dl> </td> <td width="60%"> The metadata
    ///section contains model-specific information relating to the device. If the <b>Data</b> member is specified, then
    ///its type is WSD_THIS_MODEL_METADATA. </td> </tr> <tr> <td width="40%"><a
    ///id="http___schemas.xmlsoap.org_ws_2006_02_devprof_ThisDevice"></a><a
    ///id="http___schemas.xmlsoap.org_ws_2006_02_devprof_thisdevice"></a><a
    ///id="HTTP___SCHEMAS.XMLSOAP.ORG_WS_2006_02_DEVPROF_THISDEVICE"></a><dl>
    ///<dt><b>http://schemas.xmlsoap.org/ws/2006/02/devprof/ThisDevice</b></dt> </dl> </td> <td width="60%"> The
    ///metadata section contains metadata that is unique to a specific device. If the <b>Data</b> member is specified,
    ///then its type is WSD_THIS_DEVICE_METADATA. </td> </tr> <tr> <td width="40%"><a
    ///id="http___schemas.xmlsoap.org_ws_2006_02_devprof_Relationship"></a><a
    ///id="http___schemas.xmlsoap.org_ws_2006_02_devprof_relationship"></a><a
    ///id="HTTP___SCHEMAS.XMLSOAP.ORG_WS_2006_02_DEVPROF_RELATIONSHIP"></a><dl>
    ///<dt><b>http://schemas.xmlsoap.org/ws/2006/02/devprof/Relationship</b></dt> </dl> </td> <td width="60%"> The
    ///metadata section contains metadata about the relationship between two or more services. If the <b>Data</b> member
    ///is specified, then its type is WSD_RELATIONSHIP_METADATA. </td> </tr> </table>
    const(wchar)*   Dialect;
    ///The dialect-specific identifier for the scope/domain/namespace of the metadata section.
    const(wchar)*   Identifier;
    ///Reference to a binary representation of the metadata. The type of metadata is specified by <b>Dialect</b>. This
    ///member is ignored if <b>Dialect</b> does not have a value of
    ///http://schemas.xmlsoap.org/ws/2006/02/devprof/ThisModel,
    ///http://schemas.xmlsoap.org/ws/2006/02/devprof/ThisDevice, or
    ///http://schemas.xmlsoap.org/ws/2006/02/devprof/Relationship.
    void*           Data;
    ///Reference to a WSD_ENDPOINT_REFERENCE structure used identify the endpoint from which metadata can be retrieved.
    WSD_ENDPOINT_REFERENCE* MetadataReference;
    ///A URI that specifies the location from which metadata can be retrieved.
    const(wchar)*   Location;
    WSDXML_ELEMENT* Any;
}

///Represents a node in a single-linked list of metadata sections.
struct WSD_METADATA_SECTION_LIST
{
    ///Reference to the next node in the linked list of <b>WSD_METADATA_SECTION_LIST</b> structures.
    WSD_METADATA_SECTION_LIST* Next;
    WSD_METADATA_SECTION* Element;
}

///Represents a node in a linked list of URIs.
struct WSD_URI_LIST
{
    ///Reference to the next node in the single-linked list of <b>WSD_URI_LIST</b> structures.
    WSD_URI_LIST* Next;
    const(wchar)* Element;
}

///Represents a boolean expression used for filtering events
struct WSD_EVENTING_FILTER_ACTION
{
    ///Reference to a WSD_URI_LIST structure that specifies the URIs used for filtering notifications.
    WSD_URI_LIST* Actions;
}

///Represents an event filter used in WS-Eventing Subscribe messages.
struct WSD_EVENTING_FILTER
{
    ///Specifies the language or dialect use to represent the boolean expression used by the filter. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="http___schemas.xmlsoap.org_ws_2006_02_devprof_Action"></a><a
    ///id="http___schemas.xmlsoap.org_ws_2006_02_devprof_action"></a><a
    ///id="HTTP___SCHEMAS.XMLSOAP.ORG_WS_2006_02_DEVPROF_ACTION"></a><dl>
    ///<dt><b>http://schemas.xmlsoap.org/ws/2006/02/devprof/Action</b></dt> </dl> </td> <td width="60%"> The boolean
    ///expression uses the Action filter dialect. </td> </tr> </table>
    const(wchar)* Dialect;
    WSD_EVENTING_FILTER_ACTION* FilterAction;
    void*         Data;
}

///Represents the expiration time of a WS-Eventing message.
struct WSD_EVENTING_EXPIRES
{
    ///Reference to a WSD_DURATION structure that specifies the length of time a request or response is valid.
    WSD_DURATION* Duration;
    WSD_DATETIME* DateTime;
}

///Represents the endpoint reference used for push delivery of events in a WS-Eventing Subscribe message.
struct WSD_EVENTING_DELIVERY_MODE_PUSH
{
    WSD_ENDPOINT_REFERENCE* NotifyTo;
}

///Represents the delivery mode used in a WS-Eventing Subscribe message.
struct WSD_EVENTING_DELIVERY_MODE
{
    ///Specifies the delivery mode for event delivery. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="http___schemas.xmlsoap.org_ws_2004_08_eventing_DeliveryModes_Push"></a><a
    ///id="http___schemas.xmlsoap.org_ws_2004_08_eventing_deliverymodes_push"></a><a
    ///id="HTTP___SCHEMAS.XMLSOAP.ORG_WS_2004_08_EVENTING_DELIVERYMODES_PUSH"></a><dl>
    ///<dt><b>http://schemas.xmlsoap.org/ws/2004/08/eventing/DeliveryModes/Push</b></dt> </dl> </td> <td width="60%">
    ///Push mode delivery is used. </td> </tr> </table>
    const(wchar)* Mode;
    WSD_EVENTING_DELIVERY_MODE_PUSH* Push;
    void*         Data;
}

///Represents a single localized string.
struct WSD_LOCALIZED_STRING
{
    ///The standard language code used for localization. Valid language codes are specified in RFC 1766.
    const(wchar)* lang;
    ///The string data in the localized language.
    const(wchar)* String;
}

///Represents a WS-MetadataExchange GetMetadata response message.
struct RESPONSEBODY_GetMetadata
{
    WSD_METADATA_SECTION_LIST* Metadata;
}

///Represents a WS-Eventing Subscribe request message.
struct REQUESTBODY_Subscribe
{
    ///Reference to a WSD_ENDPOINT_REFERENCE structure that represents the endpoint reference of the event recipient.
    WSD_ENDPOINT_REFERENCE* EndTo;
    ///Reference to a WSD_EVENTING_DELIVERY_MODE structure that specifies the delivery mode. Only push delivery is
    ///supported.
    WSD_EVENTING_DELIVERY_MODE* Delivery;
    ///Reference to a WSD_EVENTING_EXPIRES structure that specifies when the subscription will expire.
    WSD_EVENTING_EXPIRES* Expires;
    ///Reference to a WSD_EVENTING_FILTER structure that specifies a boolean expression used for event filtering.
    WSD_EVENTING_FILTER* Filter;
    WSDXML_ELEMENT*      Any;
}

///Represents a WS-Eventing Subscribe response message.
struct RESPONSEBODY_Subscribe
{
    ///Reference to a WSD_ENDPOINT_REFERENCE structure that represents the endpoint reference of the subscription
    ///manager.
    WSD_ENDPOINT_REFERENCE* SubscriptionManager;
    ///Reference to a WSD_EVENTING_EXPIRES structure that specifies when the subscription expires.
    WSD_EVENTING_EXPIRES* expires;
    WSDXML_ELEMENT* any;
}

///Represents a WS-Eventing Renew request message.
struct REQUESTBODY_Renew
{
    ///Reference to a WSD_EVENTING_EXPIRES structure that specifies when the renewed subscription will expire.
    WSD_EVENTING_EXPIRES* Expires;
    WSDXML_ELEMENT* Any;
}

///Represents a WS-Eventing Renew response message.
struct RESPONSEBODY_Renew
{
    ///Reference to a WSD_EVENTING_EXPIRES structure that specifies when the subscription expires.
    WSD_EVENTING_EXPIRES* expires;
    WSDXML_ELEMENT* any;
}

///Represents a WS-Eventing GetStatus request message.
struct REQUESTBODY_GetStatus
{
    WSDXML_ELEMENT* Any;
}

///Represents a WS-Eventing GetStatus response message.
struct RESPONSEBODY_GetStatus
{
    ///Reference to a WSD_EVENTING_EXPIRES structure that specifies when the subscription expires.
    WSD_EVENTING_EXPIRES* expires;
    WSDXML_ELEMENT* any;
}

///Represents a WS-Eventing Unsubscribe request message.
struct REQUESTBODY_Unsubscribe
{
    WSDXML_ELEMENT* any;
}

///Represents a WS-Eventing SubscriptionEnd response message.
struct RESPONSEBODY_SubscriptionEnd
{
    ///Reference to a WSD_ENDPOINT_REFERENCE structure that represents the endpoint reference of the subscription
    ///manager.
    WSD_ENDPOINT_REFERENCE* SubscriptionManager;
    ///A string that describes the reason the subscription ended. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="http___schemas.xmlsoap.org_ws_2004_08_eventing_SourceShuttingDown"></a><a
    ///id="http___schemas.xmlsoap.org_ws_2004_08_eventing_sourceshuttingdown"></a><a
    ///id="HTTP___SCHEMAS.XMLSOAP.ORG_WS_2004_08_EVENTING_SOURCESHUTTINGDOWN"></a><dl>
    ///<dt><b>http://schemas.xmlsoap.org/ws/2004/08/eventing/SourceShuttingDown</b></dt> </dl> </td> <td width="60%">
    ///The event source is shutting down. </td> </tr> <tr> <td width="40%"><a
    ///id="http___schemas.xmlsoap.org_ws_2004_08_eventing_SourceCancelling"></a><a
    ///id="http___schemas.xmlsoap.org_ws_2004_08_eventing_sourcecancelling"></a><a
    ///id="HTTP___SCHEMAS.XMLSOAP.ORG_WS_2004_08_EVENTING_SOURCECANCELLING"></a><dl>
    ///<dt><b>http://schemas.xmlsoap.org/ws/2004/08/eventing/SourceCancelling</b></dt> </dl> </td> <td width="60%"> The
    ///event source canceled the subscription for another reason. </td> </tr> <tr> <td width="40%"><a
    ///id="http___schemas.xmlsoap.org_ws_2004_08_eventing_DeliveryFailure"></a><a
    ///id="http___schemas.xmlsoap.org_ws_2004_08_eventing_deliveryfailure"></a><a
    ///id="HTTP___SCHEMAS.XMLSOAP.ORG_WS_2004_08_EVENTING_DELIVERYFAILURE"></a><dl>
    ///<dt><b>http://schemas.xmlsoap.org/ws/2004/08/eventing/DeliveryFailure</b></dt> </dl> </td> <td width="60%"> The
    ///event source ended the subscription because the delivery of notifications failed. </td> </tr> </table>
    const(wchar)*   Status;
    ///Reference to a WSD_LOCALIZED_STRING that contains a human-readable explanation of the reason the subscription
    ///ended.
    WSD_LOCALIZED_STRING* Reason;
    WSDXML_ELEMENT* Any;
}

///Represents an XML element that could not be parsed.
struct WSD_UNKNOWN_LOOKUP
{
    WSDXML_ELEMENT* Any;
}

///Provides an internal representation of a SOAP message.
struct WSD_EVENT
{
    ///The result code of the event.
    HRESULT             Hr;
    ///The event type.
    uint                EventType;
    ///Pointer to the protocol string when dispatch by tags is required.
    ushort*             DispatchTag;
    ///Reference to a WSD_HANDLER_CONTEXT structure that specifies the handler context.
    WSD_HANDLER_CONTEXT HandlerContext;
    ///Reference to a WSD_SOAP_MESSAGE structure that describes the event.
    WSD_SOAP_MESSAGE*   Soap;
    ///Reference to a WSD_OPERATION structure that specifies the operation performed.
    WSD_OPERATION*      Operation;
    IWSDMessageParameters MessageParameters;
}

///Specifies an XML namespace.
struct WSDXML_NAMESPACE
{
    ///The URI that identifies the namespace.
    const(wchar)* Uri;
    ///The preferred prefix to be used in XML prefix mappings.
    const(wchar)* PreferredPrefix;
    ///Reference to an array of WSDXML_NAME structures that specify the names in the namespace.
    WSDXML_NAME*  Names;
    ///The number of names in the <b>Names</b> array.
    ushort        NamesCount;
    ///The encoded reference for the namespace.
    ushort        Encoding;
}

///Specifies an XML qualified name.
struct WSDXML_NAME
{
    ///Reference to a WSDXML_NAMESPACE structure that specifies the namespace of the qualified name.
    WSDXML_NAMESPACE* Space;
    ///The local name of the qualified name.
    ushort*           LocalName;
}

///Describes an XSD type. This structure is populated by generated code.
struct WSDXML_TYPE
{
    ///The optional URI that identifies the type.
    const(wchar)* Uri;
    const(ubyte)* Table;
}

///Describes an XML namespace prefix.
struct WSDXML_PREFIX_MAPPING
{
    ///The number of references to the mapping. When the value reaches zero, the mapping is deleted.
    uint              Refs;
    ///Reference to the next node in a linked list of <b>WSDXML_PREFIX_MAPPING</b> structures.
    WSDXML_PREFIX_MAPPING* Next;
    ///Reference to a WSDXML_NAMESPACE structure.
    WSDXML_NAMESPACE* Space;
    ushort*           Prefix;
}

///Describes an XML attribute.
struct WSDXML_ATTRIBUTE
{
    ///Reference to a WSDXML_ELEMENT structure that specifies parent element of the attribute.
    WSDXML_ELEMENT*   Element;
    ///Reference to a <b>WSDXML_ATTRIBUTE</b> structure that specifies the next sibling attribute, if any.
    WSDXML_ATTRIBUTE* Next;
    ///Reference to a WSDXML_NAME structure that specifies the qualified name of the attribute.
    WSDXML_NAME*      Name;
    ///The value of the attribute.
    ushort*           Value;
}

///Describes an XML node.
struct WSDXML_NODE
{
    int             Type;
    ///Reference to the parent node in a linked list of WSDXML_ELEMENT structures.
    WSDXML_ELEMENT* Parent;
    ///Reference to the next node in the linked list of <b>WSDXML_NODE</b> structures.
    WSDXML_NODE*    Next;
    int             ElementType = 0x00000000;
    int             TextType    = 0x00000001;
}

///Describes an XML element.
struct WSDXML_ELEMENT
{
    ///Reference to a WSDXML_NODE structure that specifies the parent element, next sibling and type of the node.
    WSDXML_NODE       Node;
    ///Reference to a WSDXML_NAME structure that specifies name.
    WSDXML_NAME*      Name;
    ///Reference to a WSDXML_ATTRIBUTE structure that specifies the first attribute.
    WSDXML_ATTRIBUTE* FirstAttribute;
    ///Reference to a WSDXML_NODE structure that specifies the first child.
    WSDXML_NODE*      FirstChild;
    ///Reference to a WSDXML_PREFIX_MAPPING structure that specifies the prefix mappings.
    WSDXML_PREFIX_MAPPING* PrefixMappings;
}

///Describes the text in an XML node.
struct WSDXML_TEXT
{
    ///The current node in a linked list of WSDXML_NODE structures.
    WSDXML_NODE Node;
    ///The text contained in the XML node. The maximum length of this string is WSD_MAX_TEXT_LENGTH (8192). The text
    ///must consist of UTF-16 encoded characters. The text cannot contain raw XML, as special characters are rendered
    ///using the equivalent entity reference. For example, <code>&lt;</code> is rendered as <code>&amp;lt;</code>.
    ushort*     Text;
}

///Represents a node in a linked list of XML elements.
struct WSDXML_ELEMENT_LIST
{
    ///Reference to the next node in the linked list of <b>WSDXML_ELEMENT_LIST</b> structures.
    WSDXML_ELEMENT_LIST* Next;
    WSDXML_ELEMENT*      Element;
}

// Functions

///Gets a specified name from the built-in namespace.
///Params:
///    pszNamespace = The namespace to match with a built-in namespace.
///    pszName = The name to match with a built-in name.
///    ppName = Reference to a WSDXML_NAME structure that contains the returned built-in name. The memory usage of <i>ppName</i>
///             is managed elsewhere. Consequently, the calling application should not attempt to deallocate <i>ppName</i>.
@DllImport("wsdapi")
HRESULT WSDXMLGetNameFromBuiltinNamespace(const(wchar)* pszNamespace, const(wchar)* pszName, WSDXML_NAME** ppName);

///Creates a new IWSDXMLContext object.
///Params:
///    ppContext = Pointer to a newly allocated IWSDXMLContext object. If the function fails, this parameter can be <b>NULL</b>.
@DllImport("wsdapi")
HRESULT WSDXMLCreateContext(IWSDXMLContext* ppContext);

///Retrieves a pointer to the IWSDUdpMessageParameters interface.
///Params:
///    ppTxParams = Pointer to the IWSDUdpMessageParameters interface that you use to specify how often WSD repeats the message
///                 transmission.
@DllImport("wsdapi")
HRESULT WSDCreateUdpMessageParameters(IWSDUdpMessageParameters* ppTxParams);

///Creates an IWSDUdpAddress object.
///Params:
///    ppAddress = An IWSDUdpAddress interface pointer. This parameter cannot be <b>NULL</b>.
@DllImport("wsdapi")
HRESULT WSDCreateUdpAddress(IWSDUdpAddress* ppAddress);

///Creates an IWSDHttpMessageParameters object.
///Params:
///    ppTxParams = Returns a reference to the initialized IWSDHttpMessageParameters object. Cannot be <b>NULL</b>.
@DllImport("wsdapi")
HRESULT WSDCreateHttpMessageParameters(IWSDHttpMessageParameters* ppTxParams);

///Creates an IWSDHttpAddress object.
///Params:
///    ppAddress = Returns a reference to the initialized IWSDHttpAddress object. Cannot be <b>NULL</b>.
@DllImport("wsdapi")
HRESULT WSDCreateHttpAddress(IWSDHttpAddress* ppAddress);

///Sets a WSDAPI configuration option.
///Params:
///    dwOption = The type of configuration data to set. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///               id="WSDAPI_OPTION_MAX_INBOUND_MESSAGE_SIZE"></a><a id="wsdapi_option_max_inbound_message_size"></a><dl>
///               <dt><b>WSDAPI_OPTION_MAX_INBOUND_MESSAGE_SIZE</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%"> Set the
///               maximum size, in bytes, of an inbound message. </td> </tr> </table>
///    pVoid = Pointer to the configuration data. If <i>dwOption</i> is set to WSDAPI_OPTION_MAX_INBOUND_MESSAGE_SIZE, then
///            <i>pVoid</i> should point to a DWORD that represents the size of an inbound message. The size of the message is a
///            value between 32768 and 1048576.
///    cbInBuffer = The size, in bytes, of the data pointed to by <i>pVoid</i>. If <i>dwOption</i> is set to
///                 WSDAPI_OPTION_MAX_INBOUND_MESSAGE_SIZE, this parameter should be set to <code>sizeof(DWORD)</code>.
@DllImport("wsdapi")
HRESULT WSDSetConfigurationOption(uint dwOption, char* pVoid, uint cbInBuffer);

///Gets a WSDAPI configuration option.
///Params:
///    dwOption = The type of configuration data to get. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///               id="WSDAPI_OPTION_MAX_INBOUND_MESSAGE_SIZE"></a><a id="wsdapi_option_max_inbound_message_size"></a><dl>
///               <dt><b>WSDAPI_OPTION_MAX_INBOUND_MESSAGE_SIZE</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%"> Get the
///               maximum size, in bytes, of an inbound message. This message size is a value between 32768 and 1048576. </td>
///               </tr> </table>
///    pVoid = Pointer to the configuration data.
///    cbOutBuffer = The size, in bytes, of the data pointed to by <i>pVoid</i>. If <i>dwOption</i> is set to
///                  WSDAPI_OPTION_MAX_INBOUND_MESSAGE_SIZE, then this parameter should be set to <code>sizeof(DWORD)</code>.
@DllImport("wsdapi")
HRESULT WSDGetConfigurationOption(uint dwOption, char* pVoid, uint cbOutBuffer);

///Allocates a linked memory block.
///Params:
///    pParent = Pointer to the parent memory block.
///    cbSize = Size of the memory block to be allocated.
///Returns:
///    Pointer to the newly allocated memory block.
///    
@DllImport("wsdapi")
void* WSDAllocateLinkedMemory(void* pParent, size_t cbSize);

///Frees a memory block previously allocated with WSDAllocateLinkedMemory.
///Params:
///    pVoid = Pointer to the memory block to be freed.
@DllImport("wsdapi")
void WSDFreeLinkedMemory(void* pVoid);

///Attaches a child memory block to a parent memory block. Multiple children can be attached to a parent memory block.
///Params:
///    pParent = Pointer to the parent memory block.
///    pChild = Pointer to the child memory block.
@DllImport("wsdapi")
void WSDAttachLinkedMemory(void* pParent, void* pChild);

///Detaches a child memory block from its parent memory block.
///Params:
///    pVoid = Pointer to the memory block to be detached.
@DllImport("wsdapi")
void WSDDetachLinkedMemory(void* pVoid);

///Creates an XML element with a specified name and value. The created element can be used as the child of an XML
///<b>any</b> element.
///Params:
///    pElementName = Reference to a WSDXML_NAME structure that contains the name of the created element.
///    pszText = The text value of the created element.
///    ppAny = Reference to a WSDXML_ELEMENT that contains the created element. <i>ppAny</i> must be freed with a call to
///            WSDFreeLinkedMemory.
@DllImport("wsdapi")
HRESULT WSDXMLBuildAnyForSingleElement(WSDXML_NAME* pElementName, const(wchar)* pszText, WSDXML_ELEMENT** ppAny);

///Retrieves a text value from a specified child element of an XML <b>any</b> element.
///Params:
///    pszNamespace = The namespace of the element to retrieve.
///    pszName = The name of the element to retrieve.
///    pAny = Reference to a WSDXML_ELEMENT structure that contains the <b>any</b> element that is the parent of the element to
///           retrieve.
///    ppszValue = The text value of the element specified by <i>pszNamespace</i> and <i>pszName</i>. The memory usage of
///                <i>ppszValue</i> is managed elsewhere. Consequently, the calling application should not attempt to deallocate
///                <i>ppszValue</i>.
@DllImport("wsdapi")
HRESULT WSDXMLGetValueFromAny(const(wchar)* pszNamespace, const(wchar)* pszName, WSDXML_ELEMENT* pAny, 
                              ushort** ppszValue);

///Adds a sibling element.
///Params:
///    pFirst = Reference to a WSDXML_ELEMENT structure that contains the first sibling.
///    pSecond = Reference to a WSDXML_ELEMENT structure that contains the second sibling.
@DllImport("wsdapi")
HRESULT WSDXMLAddSibling(WSDXML_ELEMENT* pFirst, WSDXML_ELEMENT* pSecond);

///Adds a child element.
///Params:
///    pParent = Reference to a WSDXML_ELEMENT structure that contains the parent element.
///    pChild = Reference to a WSDXML_ELEMENT structure that contains the child element.
@DllImport("wsdapi")
HRESULT WSDXMLAddChild(WSDXML_ELEMENT* pParent, WSDXML_ELEMENT* pChild);

///Frees memory associated with an XML element.
///Params:
///    pAny = Reference to a WSDXML_ELEMENT structure that specifies extension content allowed by the XML <b>ANY</b> keyword.
@DllImport("wsdapi")
HRESULT WSDXMLCleanupElement(WSDXML_ELEMENT* pAny);

///Generates a SOAP fault.
///Params:
///    pszCode = A SOAP fault code. The list of possible fault codes follows. For a description of each fault code, see the <a
///              href="https://www.w3.org/TR/2003/REC-soap12-part1-20030624/
///    pszSubCode = A fault subcode.
///    pszReason = A human readable explanation of the fault.
///    pszDetail = Contains application-specific error information pertaining to the fault.
///    pContext = An IWSDXMLContext interface that represents the context in which to generate the fault.
///    ppFault = A WSD_SOAP_FAULT structure that contains the generated fault. When the calling application is done with this
///              data, <i>ppFault</i> must be freed with a call to WSDFreeLinkedMemory.
///Returns:
///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method
///    completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
///    width="60%"> <i>pszCode</i>, <i>pszReason</i>, or <i>pContext</i> is <b>NULL</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>ppFault</i> is <b>NULL</b>. </td>
///    </tr> </table>
///    
@DllImport("wsdapi")
HRESULT WSDGenerateFault(const(wchar)* pszCode, const(wchar)* pszSubCode, const(wchar)* pszReason, 
                         const(wchar)* pszDetail, IWSDXMLContext pContext, WSD_SOAP_FAULT** ppFault);

///Generates a SOAP fault.
///Params:
///    pCode = A SOAP fault code. The list of possible fault codes follows. For a description of each fault code, see the <a
///            href="https://www.w3.org/TR/2003/REC-soap12-part1-20030624/
///    pSubCode = A fault subcode.
///    pReasons = A WSD_LOCALIZED_STRING_LIST structure that contains a list of localized reason codes.
///    pszDetail = Contains application-specific error information pertaining to the fault.
///    ppFault = A WSD_SOAP_FAULT structure that contains the generated fault. <i>ppFault</i> must be freed with a call to
///              WSDFreeLinkedMemory.
///Returns:
///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method
///    completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
///    width="60%"> <i>pszCode</i> or <i>pReasons</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>ppFault</i> is <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("wsdapi")
HRESULT WSDGenerateFaultEx(WSDXML_NAME* pCode, WSDXML_NAME* pSubCode, WSD_LOCALIZED_STRING_LIST* pReasons, 
                           const(wchar)* pszDetail, WSD_SOAP_FAULT** ppFault);

///Encodes a URI according to URI encoding rules in RFC2396.
///Params:
///    source = Contains the URI to be encoded.
///    cchSource = Specifies the length of <i>source</i> in characters.
///    destOut = Pointer to a string that contains the encoded URI. If <i>destOut</i> is not <b>NULL</b>, the calling application
///              should free the allocated string by calling WSDFreeLinkedMemory.
///    cchDestOut = Specifies the length of <i>destOut</i> in characters.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Function completed successfully. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>source</i> is
///    <b>NULL</b> or <i>cchSource</i> is 0. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td>
///    <td width="60%"> The length in characters of <i>source</i> exceeds <b>WSD_MAX_TEXT_LENGTH</b> (8192). </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>destOut</i> is <b>NULL</b>.
///    </td> </tr> </table>
///    
@DllImport("wsdapi")
HRESULT WSDUriEncode(const(wchar)* source, uint cchSource, char* destOut, uint* cchDestOut);

///Decodes a URI according to the rules in RFC2396.
///Params:
///    source = Contains the URI to be decoded.
///    cchSource = Specifies the length of <i>source</i> in characters.
///    destOut = Pointer to a string that contains the decoded URI. If <i>destOut</i> is not <b>NULL</b>, the calling application
///              should free the allocated string by calling WSDFreeLinkedMemory.
///    cchDestOut = Specifies the length of <i>destOut</i> in characters.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Function completed successfully. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>source</i> is
///    <b>NULL</b> or <i>cchSource</i> is 0. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td>
///    <td width="60%"> The length in characters of <i>source</i> exceeds <b>WSD_MAX_TEXT_LENGTH</b> (8192). </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>destOut</i> is <b>NULL</b>.
///    </td> </tr> </table>
///    
@DllImport("wsdapi")
HRESULT WSDUriDecode(const(wchar)* source, uint cchSource, char* destOut, uint* cchDestOut);

///Creates a device host and returns a pointer to the IWSDDeviceHost interface.
///Params:
///    pszLocalId = The logical or physical address of the device. A logical address is of the form <code>urn:uuid:{guid}</code>. If
///                 <i>pszLocalId</i> is a logical address, the host will announce the logical address and then convert the address
///                 to a physical address when it receives Resolve or Probe messages. If <i>pszLocalId</i> is a physical address
///                 (such as URL prefixed by http or https), the host will use the address as the physical address and will host on
///                 that address instead of the default one. For secure communication, <i>pszLocalId</i> must be an URL prefixed by
///                 https, and the host will use the SSL/TLS protocol on the port specified in the URL. The recommended port is port
///                 5358, as this port is reserved for secure connections with WSDAPI. If no port is specified, then the host will
///                 use port 443. The host port must be configured with an SSL server certificate before calling
///                 <b>WSDCreateDeviceHost</b>. For more information about the configuration of host ports, see
///                 HttpSetServiceConfiguration. Any URL (http or https) must be terminated with a trailing slash. The URL must
///                 contain a valid IP address or hostname. The following list shows some example values for <i>pszLocalId</i>. It is
///                 not a complete list of valid values. <ul> <li>http://192.168.0.1:5357/</li> <li>http://localhost/</li>
///                 <li>http://myHostname:5357/ </li> <li>https://192.168.0.1:5358/ </li> <li>https://myHostname/ </li>
///                 <li>https://myHostname/myDevice/ </li> <li>https://myHostname:5358/ </li> </ul>
///    pContext = An IWSDXMLContext object that defines custom message types or namespaces. If <b>NULL</b>, a default context
///               representing the built-in message types and namespaces is used.
///    ppDeviceHost = Pointer to an IWSDDeviceHost object that you use to expose the WSD-specific device semantics associated with a
///                   server that responds to incoming requests.
///Returns:
///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method
///    completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
///    width="60%"> <i>pszLocalId</i> is <b>NULL</b> or the length in characters of <i>pszLocalId</i> exceeds
///    WSD_MAX_TEXT_LENGTH (8192). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
///    width="60%"> <i>ppDeviceHost</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the operation. </td>
///    </tr> </table>
///    
@DllImport("wsdapi")
HRESULT WSDCreateDeviceHost(const(wchar)* pszLocalId, IWSDXMLContext pContext, IWSDDeviceHost* ppDeviceHost);

///Creates a device host and returns a pointer to the IWSDDeviceHost interface.
///Params:
///    pszLocalId = The logical or physical address of the device. A logical address is of the form <code>urn:uuid:{guid}</code>. If
///                 <i>pszLocalId</i> is a logical address, the host will announce the logical address and then convert the address
///                 to a physical address when it receives Resolve or Probe messages. If <i>pszLocalId</i> is a physical address
///                 (such as URL prefixed by http or https), the host will use the address as the physical address and will host on
///                 that address instead of the default one. For secure communication, <i>pszLocalId</i> must be an URL prefixed by
///                 https, and the host will use the SSL/TLS protocol on the port specified in the URL. The recommended port is port
///                 5358, as this port is reserved for secure connections with WSDAPI. If no port is specified, then the host will
///                 use port 443. The host port must be configured with an SSL server certificate before calling
///                 <b>WSDCreateDeviceHostAdvanced</b>. For more information about the configuration of host ports, see
///                 HttpSetServiceConfiguration. If either <i>pszLocalId</i> or the transport address referenced by
///                 <i>ppHostAddresses</i> is an URL prefixed by https, then both URLs must be identical. If this is not the case,
///                 <b>WSDCreateDeviceHostAdvanced</b> will return E_INVALIDARG. Any URL (http or https) must be terminated with a
///                 trailing slash. The URL must contain a valid IP address or hostname. The following list shows some example values
///                 for <i>pszLocalId</i>. It is not a complete list of valid values. <ul> <li>http://192.168.0.1:5357/</li>
///                 <li>http://localhost/</li> <li>http://myHostname:5357/ </li> <li>https://192.168.0.1:5358/ </li>
///                 <li>https://myHostname/ </li> <li>https://myHostname/myDevice/ </li> <li>https://myHostname:5358/ </li> </ul>
///    pContext = An IWSDXMLContext interface that defines custom message types or namespaces. If <b>NULL</b>, a default context
///               representing the built-in message types and namespaces is used.
///    ppHostAddresses = A single IWSDAddress interface or IWSDTransportAddress interface. The objects provide information about specific
///                      addresses that the host should listen on. If <i>pszLocalId</i> contains a logical address, the resulting behavior
///                      is a mapping between the logical address and a specific set of physical addresses (instead of a mapping between
///                      the logical address and a default physical address).
///    dwHostAddressCount = The number of items in the <i>ppHostAddresses</i> array. If <i>ppHostAddresses</i> is an IWSDAddress interface,
///                         count must be 1.
///    ppDeviceHost = Pointer to the IWSDDeviceHost interface that you use to expose the WSD-specific device semantics associated with
///                   a server that responds to incoming requests.
///Returns:
///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method
///    completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
///    width="60%"> <i>pszLocalId</i> is <b>NULL</b>, the length in characters of <i>pszLocalId</i> exceeds
///    WSD_MAX_TEXT_LENGTH (8192), or <i>pszLocalId</i> points to an URL prefixed by https and that URL does not match
///    the URL of the transport address referenced by <i>ppHostAddresses</i>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>ppDeviceHost</i> is <b>NULL</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the
///    operation. </td> </tr> </table>
///    
@DllImport("wsdapi")
HRESULT WSDCreateDeviceHostAdvanced(const(wchar)* pszLocalId, IWSDXMLContext pContext, char* ppHostAddresses, 
                                    uint dwHostAddressCount, IWSDDeviceHost* ppDeviceHost);

///Creates a device host that can support signed messages and returns a pointer to the IWSDDeviceHost interface.
///Params:
///    pszLocalId = The logical or physical address of the device. A logical address is of the form <code>urn:uuid:{guid}</code>. If
///                 <i>pszLocalId</i> is a logical address, the host will announce the logical address and then convert the address
///                 to a physical address when it receives Resolve or Probe messages. If <i>pszLocalId</i> is a physical address
///                 (such as URL prefixed by http or https), the host will use the address as the physical address and will host on
///                 that address instead of the default one. If <i>pszLocalId</i> is an HTTPS URL, the recommended port is port 5358,
///                 as this port is reserved for secure connections with WSDAPI. If no port is specified, then the host will use port
///                 443. The host port must be configured with an SSL server certificate before calling WSDCreateDeviceHost. For more
///                 information about the configuration of host ports, see HttpSetServiceConfiguration. Any URL (http or https) must
///                 be terminated with a trailing slash. The URL must contain a valid IP address or hostname. The following list
///                 shows some example values for <i>pszLocalId</i>. It is not a complete list of valid values. <ul>
///                 <li>http://192.168.0.1:5357/</li> <li>http://localhost/</li> <li>http://myHostname:5357/ </li>
///                 <li>https://192.168.0.1:5358/ </li> <li>https://myHostname/ </li> <li>https://myHostname/myDevice/ </li>
///                 <li>https://myHostname:5358/ </li> </ul>
///    pContext = An IWSDXMLContext object that defines custom message types or namespaces. If <b>NULL</b>, a default context
///               representing the built-in message types and namespaces is used.
///    pConfigParams = An array of WSD_CONFIG_PARAM structures that contain the parameters for creating the object.
///    dwConfigParamCount = The total number of structures passed in <i>pConfigParams</i>.
///    ppDeviceHost = Pointer to an IWSDDeviceHost object that you use to expose the WSD-specific device semantics associated with a
///                   server that responds to incoming requests.
///Returns:
///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Function
///    completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
///    width="60%"> <i>pszLocalId</i> is <b>NULL</b> or the length in characters of <i>pszLocalId</i> exceeds
///    WSD_MAX_TEXT_LENGTH (8192). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
///    width="60%"> <i>ppDeviceHost</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the operation. </td>
///    </tr> </table>
///    
@DllImport("wsdapi")
HRESULT WSDCreateDeviceHost2(const(wchar)* pszLocalId, IWSDXMLContext pContext, char* pConfigParams, 
                             uint dwConfigParamCount, IWSDDeviceHost* ppDeviceHost);

///Creates a device proxy and returns a pointer to the IWSDDeviceProxy interface.
///Params:
///    pszDeviceId = The logical or physical address of the device. A logical address is of the form <code>urn:uuid:{guid}</code>. A
///                  physical address is a URI prefixed by http or https. If this address is a URI prefixed by https, then the proxy
///                  will use the SSL/TLS protocol. The device address may be prefixed with the @ character. When <i>pszDeviceId</i>
///                  begins with @, this function does not retrieve the device metadata when creating the device proxy.
///    pszLocalId = The logical or physical address of the client, which is used to identify the proxy and to act as an event sink
///                 endpoint. A logical address is of the form <code>urn:uuid:{guid}</code>. If the client uses a secure channel to
///                 receive events, then the address is a URI prefixed by https. This URI should specify port 5358, as this port is
///                 reserved for secure connections with WSDAPI. The port must be configured with an SSL server certificate before
///                 calling WSDCreateDeviceProxyAdvanced. For more information about port configuration, see
///                 HttpSetServiceConfiguration.
///    pContext = An IWSDXMLContext object that defines custom message types or namespaces. If <b>NULL</b>, a default context
///               representing the built-in message types and namespaces is used.
///    ppDeviceProxy = Pointer to an IWSDDeviceProxy object that you use to represent a remote WSD device for client applications and
///                    middleware.
///Returns:
///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method
///    completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
///    width="60%"> <i>pszDeviceId</i> is <b>NULL</b>, <i>pszLocalId</i> is <b>NULL</b>, the length in characters of
///    <i>pszDeviceId</i> exceeds WSD_MAX_TEXT_LENGTH (8192), or the length in characters of <i>pszLocalId</i> exceeds
///    WSD_MAX_TEXT_LENGTH (8192). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
///    width="60%"> <i>ppDeviceProxy</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the operation. </td>
///    </tr> </table>
///    
@DllImport("wsdapi")
HRESULT WSDCreateDeviceProxy(const(wchar)* pszDeviceId, const(wchar)* pszLocalId, IWSDXMLContext pContext, 
                             IWSDDeviceProxy* ppDeviceProxy);

///Creates a device proxy and returns a pointer to the IWSDDeviceProxy interface.
///Params:
///    pszDeviceId = The logical or physical address of the device. A logical address is of the form <code>urn:uuid:{guid}</code>. A
///                  physical address is a URI prefixed by http or https. If this address is a URI prefixed by https, then the proxy
///                  will use the SSL/TLS protocol. If either <i>pszDeviceId</i> or the <i>pszLocalId</i> is an URL prefixed by https,
///                  then both URLs must be identical. If this is not the case, <b>WSDCreateDeviceProxyAdvanced</b> will return
///                  E_INVALIDARG. The device address may be prefixed with the @ character. When <i>pszDeviceId</i> begins with @,
///                  this function does not retrieve the device metadata when creating the device proxy.
///    pDeviceAddress = An IWSDAddress interface that defines the device transport address. When <i>pDeviceAddress</i> is specified, a
///                     device proxy can be created without requiring the resolution of a logical address passed to <i>pszDeviceId</i>.
///                     This parameter may be <b>NULL</b>.
///    pszLocalId = The logical or physical address of the client, which is used to identify the proxy and to act as an event sink
///                 endpoint. A logical address is of the form <code>urn:uuid:{guid}</code>. If the client uses a secure channel to
///                 receive events, then the address is a URI prefixed by https. This URI should specify port 5358, as this port is
///                 reserved for secure connections with WSDAPI. The port must be configured with an SSL server certificate before
///                 calling <b>WSDCreateDeviceProxyAdvanced</b>. For more information about port configuration, see
///                 HttpSetServiceConfiguration.
///    pContext = An IWSDXMLContext interface that defines custom message types or namespaces. If <b>NULL</b>, a default context
///               representing the built-in message types and namespaces is used.
///    ppDeviceProxy = Pointer to the IWSDDeviceProxy interface that you use to represent a remote WSD device for client applications
///                    and middleware.
///Returns:
///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method
///    completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
///    width="60%"> <i>pszDeviceId</i> is <b>NULL</b>, <i>pszLocalId</i> is <b>NULL</b>, the length in characters of
///    <i>pszDeviceId</i> exceeds WSD_MAX_TEXT_LENGTH (8192), the length in characters of <i>pszLocalId</i> exceeds
///    WSD_MAX_TEXT_LENGTH (8192), or <i>pszDeviceId</i> points to a URI prefixed by https and that URL does not match
///    the URI passed to <i>pszLocalId</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
///    <td width="60%"> <i>ppDeviceProxy</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the operation. </td>
///    </tr> </table>
///    
@DllImport("wsdapi")
HRESULT WSDCreateDeviceProxyAdvanced(const(wchar)* pszDeviceId, IWSDAddress pDeviceAddress, 
                                     const(wchar)* pszLocalId, IWSDXMLContext pContext, 
                                     IWSDDeviceProxy* ppDeviceProxy);

///Creates a device proxy that can support signed messages and returns a pointer to the IWSDDeviceProxy interface.
///Params:
///    pszDeviceId = The logical or physical address of the device. A logical address is of the form <code>urn:uuid:{guid}</code>. A
///                  physical address is a URI prefixed by http or https. If this address is a URI prefixed by https, then the proxy
///                  will use the SSL/TLS protocol. The device address may be prefixed with the @ character. When <i>pszDeviceId</i>
///                  begins with @, this function does not retrieve the device metadata when creating the device proxy.
///    pszLocalId = The logical or physical address of the client, which is used to identify the proxy and to act as an event sink
///                 endpoint. A logical address is of the form <code>urn:uuid:{guid}</code>. If the client uses a secure channel to
///                 receive events, then the address is a URI prefixed by https. This URI should specify port 5358, as this port is
///                 reserved for secure connections with WSDAPI. The port must be configured with an SSL server certificate before
///                 calling WSDCreateDeviceProxyAdvanced. For more information about port configuration, see
///                 HttpSetServiceConfiguration.
///    pContext = An IWSDXMLContext object that defines custom message types or namespaces. If <b>NULL</b>, a default context
///               representing the built-in message types and namespaces is used.
///    pConfigParams = An array of WSD_CONFIG_PARAM structures that contain the parameters for creating the object.
///    dwConfigParamCount = The total number of structures passed in <i>pConfigParams</i>.
///    ppDeviceProxy = Pointer to an IWSDDeviceProxy object that you use to represent a remote WSD device for client applications and
///                    middleware.
///Returns:
///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Function
///    completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
///    width="60%"> <i>pszDeviceId</i> is <b>NULL</b>, <i>pszLocalId</i> is <b>NULL</b>, the length in characters of
///    <i>pszDeviceId</i> exceeds WSD_MAX_TEXT_LENGTH (8192), or the length in characters of <i>pszLocalId</i> exceeds
///    WSD_MAX_TEXT_LENGTH (8192). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
///    width="60%"> <i>ppDeviceProxy</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the operation. </td>
///    </tr> </table>
///    
@DllImport("wsdapi")
HRESULT WSDCreateDeviceProxy2(const(wchar)* pszDeviceId, const(wchar)* pszLocalId, IWSDXMLContext pContext, 
                              char* pConfigParams, uint dwConfigParamCount, IWSDDeviceProxy* ppDeviceProxy);

///Creates an IWSDiscoveryProvider object.
///Params:
///    pContext = An IWSDXMLContext interface that defines custom message types or namespaces. If <b>NULL</b>, a default context
///               representing the built-in message types and namespaces is used.
///    ppProvider = Returns a reference to the initialized IWSDiscoveryProvider object. Cannot be <b>NULL</b>.
@DllImport("wsdapi")
HRESULT WSDCreateDiscoveryProvider(IWSDXMLContext pContext, IWSDiscoveryProvider* ppProvider);

///Creates an IWSDiscoveryProvider object that supports signed messages.
///Params:
///    pContext = An IWSDXMLContext interface that defines custom message types or namespaces. If <b>NULL</b>, a default context
///               representing the built-in message types and namespaces is used.
///    pConfigParams = An array of WSD_CONFIG_PARAM structures that contain the parameters for creating the object.
///    dwConfigParamCount = The total number of structures passed in <i>pConfigParams</i>.
///    ppProvider = Returns a reference to the initialized IWSDiscoveryProvider object. Cannot be <b>NULL</b>.
@DllImport("wsdapi")
HRESULT WSDCreateDiscoveryProvider2(IWSDXMLContext pContext, char* pConfigParams, uint dwConfigParamCount, 
                                    IWSDiscoveryProvider* ppProvider);

///Creates an IWSDiscoveryPublisher object.
///Params:
///    pContext = An IWSDXMLContext interface that defines custom message types or namespaces. If <b>NULL</b>, a default context
///               representing the built-in message types and namespaces is used.
///    ppPublisher = Returns a reference to the initialized IWSDiscoveryPublisher object. Cannot be <b>NULL</b>.
@DllImport("wsdapi")
HRESULT WSDCreateDiscoveryPublisher(IWSDXMLContext pContext, IWSDiscoveryPublisher* ppPublisher);

///Creates an IWSDiscoveryPublisher object that supports signed messages.
///Params:
///    pContext = An IWSDXMLContext interface that defines custom message types or namespaces. If <b>NULL</b>, a default context
///               representing the built-in message types and namespaces is used.
///    pConfigParams = An array of WSD_CONFIG_PARAM structures that contain the parameters for creating the object.
///    dwConfigParamCount = The total number of structures passed in <i>pConfigParams</i>.
///    ppPublisher = Returns a reference to the initialized IWSDiscoveryPublisher object. Cannot be <b>NULL</b>.
@DllImport("wsdapi")
HRESULT WSDCreateDiscoveryPublisher2(IWSDXMLContext pContext, char* pConfigParams, uint dwConfigParamCount, 
                                     IWSDiscoveryPublisher* ppPublisher);

///Creates an IWSDOutboundAttachment object.
///Params:
///    ppAttachment = Returns a reference to the initialized IWSDOutboundAttachment object. Cannot be <b>NULL</b>.
@DllImport("wsdapi")
HRESULT WSDCreateOutboundAttachment(IWSDOutboundAttachment* ppAttachment);


// Interfaces

@GUID("CEE8CCC9-4F6B-4469-A235-5A22869EEF03")
struct PNPXAssociation;

@GUID("B8A27942-ADE7-4085-AA6E-4FADC7ADA1EF")
struct PNPXPairingHandler;

///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions.] This interface is implemented by the
///client program to support asynchronous queries and is called by Function Discovery to notify the client program when
///a function instance that meets the query parameters has been added or removed.
@GUID("5F6C1BA8-5330-422E-A368-572B244D3F87")
interface IFunctionDiscoveryNotification : IUnknown
{
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Indicates that a function
    ///instance has been added, removed, or changed. This method is implemented by the client program and is called by
    ///Function Discovery.
    ///Params:
    ///    enumQueryUpdateAction = A QueryUpdateAction value that specifies the type of action Function Discovery is performing on the specified
    ///                            function instance.
    ///    fdqcQueryContext = The context registered for change notification. The type <b>FDQUERYCONTEXT</b> is defined as a DWORDLONG.
    ///                       This parameter can be <b>NULL</b>.
    ///    pIFunctionInstance = An IFunctionInstance interface pointer that represents the function instance being affected by the update.
    ///Returns:
    ///    The client program's implementation of the <b>OnUpdate</b> method should return one of the following
    ///    <b>HRESULT</b> values to the caller. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value of one
    ///    of the input parameters is invalid. </td> </tr> </table>
    ///    
    HRESULT OnUpdate(QueryUpdateAction enumQueryUpdateAction, ulong fdqcQueryContext, 
                     IFunctionInstance pIFunctionInstance);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Receives errors that occur during
    ///asynchronous query processing.
    ///Params:
    ///    hr = The query error that is being reported.
    ///    fdqcQueryContext = The context registered for change notification. The type <b>FDQUERYCONTEXT</b> is defined as a DWORDLONG.
    ///    pszProvider = The name of the provider.
    ///Returns:
    ///    The client program's implementation of the <b>OnError</b> method should return one of the following
    ///    <b>HRESULT</b> values to the caller. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value of one
    ///    of the input parameters is invalid. </td> </tr> </table>
    ///    
    HRESULT OnError(HRESULT hr, ulong fdqcQueryContext, const(wchar)* pszProvider);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Receives any add, remove, or
    ///update events during a notification.
    ///Params:
    ///    dwEventID = The type of event. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///                id="FD_EVENTID_SEARCHCOMPLETE"></a><a id="fd_eventid_searchcomplete"></a><dl>
    ///                <dt><b>FD_EVENTID_SEARCHCOMPLETE</b></dt> <dt>1000</dt> </dl> </td> <td width="60%"> The search was completed
    ///                by a provider. Typically, this notification is sent by network protocol providers where the protocol
    ///                specifies a defined interval in which search results will be accepted. Both the WSD and SSDP providers use
    ///                this event type. Once this notification is sent, a query ignores all incoming responses to the initial search
    ///                or probe request. However, the query will still monitor for Hello or Bye messages (used to indicate when a
    ///                device is added or removed). The query will continue to monitor for these events until <b>Release</b> is
    ///                called on the query object. This notification will not be sent if a catastrophic error occurs. For
    ///                information about how this event is implemented or used by a specific provider, follow the link to the
    ///                provider documentation from the Built-in Providers topic. </td> </tr> <tr> <td width="40%"><a
    ///                id="FD_EVENTID_ASYNCTHREADEXIT"></a><a id="fd_eventid_asyncthreadexit"></a><dl>
    ///                <dt><b>FD_EVENTID_ASYNCTHREADEXIT</b></dt> <dt>1001</dt> </dl> </td> <td width="60%"> Not used by Function
    ///                Discovery clients. </td> </tr> <tr> <td width="40%"><a id="FD_EVENTID_SEARCHSTART"></a><a
    ///                id="fd_eventid_searchstart"></a><dl> <dt><b>FD_EVENTID_SEARCHSTART</b></dt> <dt>1002</dt> </dl> </td> <td
    ///                width="60%"> Not used by Function Discovery clients. </td> </tr> <tr> <td width="40%"><a
    ///                id="FD_EVENTID_IPADDRESSCHANGE"></a><a id="fd_eventid_ipaddresschange"></a><dl>
    ///                <dt><b>FD_EVENTID_IPADDRESSCHANGE</b></dt> <dt>1003</dt> </dl> </td> <td width="60%"> The IP address of the
    ///                NIC changed. The WSD provider implements this notification. Events may be sent when a power event occurs (for
    ///                example, when machine wakes from sleep) or when roaming with a laptop. <div class="alert"><b>Note</b> This
    ///                value is not available for use on Windows Vista. It is available on Windows Vista with SP1, Windows Server
    ///                2008, and subsequent versions of the operating system.</div> <div> </div> </td> </tr> </table>
    ///    fdqcQueryContext = The context registered for change notification. The type <b>FDQUERYCONTEXT</b> is defined as a
    ///                       <b>DWORDLONG</b>. This parameter can be <b>NULL</b>.
    ///    pszProvider = The name of the provider.
    ///Returns:
    ///    The client program's implementation of the <b>OnEvent</b> method should return one of the following
    ///    <b>HRESULT</b> values to the caller. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value of one
    ///    of the input parameters is invalid. </td> </tr> </table>
    ///    
    HRESULT OnEvent(uint dwEventID, ulong fdqcQueryContext, const(wchar)* pszProvider);
}

///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions.] This interface is used by client
///programs to discover function instances, get the default function instance for a category, and create advanced
///Function Discovery query objects that enable registering Function Discovery defaults, among other things.
@GUID("4DF99B70-E148-4432-B004-4C9EEB535A5E")
interface IFunctionDiscovery : IUnknown
{
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Gets the specified collection of
    ///function instances, based on category and subcategory.
    ///Params:
    ///    pszCategory = The identifier of the category to be enumerated. See Category Definitions.
    ///    pszSubCategory = The identifier of the subcategory to be enumerated. See Subcategory Definitions. This parameter can be
    ///                     <b>NULL</b>.
    ///    fIncludeAllSubCategories = If <b>TRUE</b>, this method recursively enumerates all the subcategories of the category specified in
    ///                               <i>pszCategory</i>, returning a collection containing function instances from all the subcategories of
    ///                               <i>pszCategory</i>. If <b>FALSE</b>, this method restricts itself to returning function instances in the
    ///                               category specified by <i>pszCategory</i> and the subcategory specified by <i>pszSubCategory</i>.
    ///    ppIFunctionInstanceCollection = A pointer to an IFunctionInstanceCollection interface pointer that receives the function instance collection
    ///                                    containing the requested function instances. The collection is empty if no qualifying function instances are
    ///                                    found.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return
    ///    code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The method completed successfully. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value of <i>pszCategory</i> is invalid. The
    ///    value returned in <i>ppIFunctionInstanceCollection</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method is unable to allocate
    ///    the memory required to perform this operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)</b></dt> <dt>0x80070002</dt> </dl> </td> <td width="60%"> The
    ///    value of <i>pszCategory</i> or <i>pszSubCategory</i> is unknown. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_PENDING</b></dt> </dl> </td> <td width="60%"> The call was executed for a provider that returns
    ///    results asynchronously. </td> </tr> </table>
    ///    
    HRESULT GetInstanceCollection(const(wchar)* pszCategory, const(wchar)* pszSubCategory, 
                                  BOOL fIncludeAllSubCategories, 
                                  IFunctionInstanceCollection* ppIFunctionInstanceCollection);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Gets the specified function
    ///instance, based on identifier.
    ///Params:
    ///    pszFunctionInstanceIdentity = The identifier of the function instance (see GetID).
    ///    ppIFunctionInstance = A pointer to an IFunctionInstance interface pointer used to return the interface.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return
    ///    code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The method completed successfully. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value of <i>pszFunctionInstanceIdentity</i> is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    The method is unable to allocate the memory required to perform this operation. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_OBJECT_NOT_FOUND)</b></dt> <dt>0x800710d8</dt> </dl> </td>
    ///    <td width="60%"> The function instance represented by the specified ID does not exist on this computer. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_PENDING</b></dt> </dl> </td> <td width="60%"> The call was executed
    ///    for a provider that returns results asynchronously. </td> </tr> </table>
    ///    
    HRESULT GetInstance(const(wchar)* pszFunctionInstanceIdentity, IFunctionInstance* ppIFunctionInstance);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Creates a query for a collection
    ///of specific function instances.
    ///Params:
    ///    pszCategory = The category for the query. See Category Definitions.
    ///    pszSubCategory = The subcategory for the query. See Subcategory Definitions. This parameter can be <b>NULL</b>. Subcategory
    ///                     queries are only supported for layered categories and some provider categories. The Registry Provider, the
    ///                     PnP-X association provider, and the publication provider support subcategory queries. Custom providers can be
    ///                     explicitly designed to support subcategory queries. This means the <i>pszSubCategory</i> parameter should be
    ///                     set to a non-<b>NULL</b> value only when the <i>pszCategory</i> parameter is set to
    ///                     <b>FCTN_CATEGORY_REGISTRY</b>, <b>FCTN_CATEGORY_PUBLICATION</b>, <b>FCTN_CATEGORY_PNPXASSOCIATION</b>, or a
    ///                     custom category value defined for either a layered category or a custom provider supporting subcategory
    ///                     queries.
    ///    fIncludeAllSubCategories = If <b>TRUE</b>, this method recursively creates a query for all the subcategories of the category specified
    ///                               in <i>pszCategory</i>, returning a collection containing function instances from all the subcategories of
    ///                               <i>pszCategory</i>. If <b>FALSE</b>, this method restricts the created query to returning function instances
    ///                               in the category specified by <i>pszCategory</i> and the subcategory specified by <i>pszSubCategory</i>.
    ///    pIFunctionDiscoveryNotification = A pointer to the IFunctionDiscoveryNotification interface implemented by the calling application. This
    ///                                      parameter can be <b>NULL</b>. This pointer is valid until the returned query object is released.
    ///    pfdqcQueryContext = A pointer to the context in which the query was created. The type <b>FDQUERYCONTEXT</b> is defined as a
    ///                        DWORDLONG.
    ///    ppIFunctionInstanceCollectionQuery = A pointer to the IFunctionInstanceCollectionQuery interface pointer.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return
    ///    code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The method completed successfully. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value of <i>pszCategory</i> or <i>pIID</i> is
    ///    invalid. The value returned in <i>ppIFunctionInstanceCollectionQuery</i> parameter is <b>NULL</b>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method is
    ///    unable to allocate the memory required to perform this operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)</b></dt> <dt>0x80070002</dt> </dl> </td> <td width="60%"> The
    ///    value of <i>pszCategory</i> or <i>pszSubCategory</i> is unknown. </td> </tr> </table>
    ///    
    HRESULT CreateInstanceCollectionQuery(const(wchar)* pszCategory, const(wchar)* pszSubCategory, 
                                          BOOL fIncludeAllSubCategories, 
                                          IFunctionDiscoveryNotification pIFunctionDiscoveryNotification, 
                                          ulong* pfdqcQueryContext, 
                                          IFunctionInstanceCollectionQuery* ppIFunctionInstanceCollectionQuery);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Creates a query for a specific
    ///function instance.
    ///Params:
    ///    pszFunctionInstanceIdentity = The identifier of the function instance.
    ///    pIFunctionDiscoveryNotification = A pointer to the IFunctionDiscoveryNotification interface implemented by the calling application. If
    ///                                      specified, it enables the Function Discovery change notification process. This parameter can be <b>NULL</b>;
    ///                                      however it is required for network providers.
    ///    pfdqcQueryContext = A pointer to the context in which the query was created. The type <b>FDQUERYCONTEXT</b> is defined as a
    ///                        DWORDLONG.
    ///    ppIFunctionInstanceQuery = A pointer to an IFunctionInstanceQuery interface pointer used to return the generated query.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> <i>ppIFunctionInstanceQuery</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method is unable to allocate the memory
    ///    required to perform this operation. </td> </tr> </table>
    ///    
    HRESULT CreateInstanceQuery(const(wchar)* pszFunctionInstanceIdentity, 
                                IFunctionDiscoveryNotification pIFunctionDiscoveryNotification, 
                                ulong* pfdqcQueryContext, IFunctionInstanceQuery* ppIFunctionInstanceQuery);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Creates or modifies a function
    ///instance.
    ///Params:
    ///    enumSystemVisibility = A SystemVisibilityFlags value that specifies whether the created function instance is visible system wide or
    ///                           only to the current user. <div class="alert"><b>Note</b> The function instance is stored in
    ///                           HKEY_LOCAL_MACHINE regardless of the <i>enumSystemVisibility</i> value. The user must have Administrator
    ///                           access to add a function instance.</div> <div> </div>
    ///    pszCategory = The category of the created function instance. See Category Definitions.
    ///    pszSubCategory = The subcategory of the created function instance. See Subcategory Definitions. The maximum length of this
    ///                     string is MAX_PATH.
    ///    pszCategoryIdentity = The provider instance identifier string. This string is returned from GetProviderInstanceID.
    ///    ppIFunctionInstance = A pointer to an IFunctionInstance interface pointer that receives the function instance.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return
    ///    code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The method completed successfully. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value of <i>enumSystemVisibility</i>,
    ///    <i>pszCategory</i>, or <i>pszCategoryIdentity</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method is unable to allocate the memory
    ///    required to perform this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt>
    ///    </dl> </td> <td width="60%"> The user has insufficient access permission to perform the requested action.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The provider does
    ///    not support adding function instances directly using the AddInstance method. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)</b></dt> <dt>0x80070002</dt> </dl> </td>
    ///    <td width="60%"> The value of <i>pszCategory</i> or <i>pszSubCategory</i> is unknown. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>STRSAFE_E_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid
    ///    parameter was specified. This error is returned when the length of the <i>pszSubCategory</i> string exceeds
    ///    MAX_PATH. </td> </tr> </table>
    ///    
    HRESULT AddInstance(SystemVisibilityFlags enumSystemVisibility, const(wchar)* pszCategory, 
                        const(wchar)* pszSubCategory, const(wchar)* pszCategoryIdentity, 
                        IFunctionInstance* ppIFunctionInstance);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Removes the specified function
    ///instance, based on category and subcategory.
    ///Params:
    ///    enumSystemVisibility = A SystemVisibilityFlags value that specifies whether the function instance is removed system-wide or only for
    ///                           the current user.
    ///    pszCategory = The category of the function instance. See Category Definitions.
    ///    pszSubCategory = The subcategory of the function instance to be removed. See Subcategory Definitions. This parameter can be
    ///                     <b>NULL</b>.
    ///    pszCategoryIdentity = The provider instance identifier string. This string is returned from GetProviderInstanceID.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return
    ///    code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The method completed successfully. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value of <i>pszCategoryIdentity</i> is invalid.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method
    ///    is unable to allocate the memory required to perform this operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The user has insufficient access permission to
    ///    perform the requested action. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)</b></dt> <dt>0x80070002</dt> </dl> </td> <td width="60%"> The
    ///    value of <i>pszCategory</i> or <i>pszSubCategory</i> is unknown. </td> </tr> </table>
    ///    
    HRESULT RemoveInstance(SystemVisibilityFlags enumSystemVisibility, const(wchar)* pszCategory, 
                           const(wchar)* pszSubCategory, const(wchar)* pszCategoryIdentity);
}

///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions.] A function instance is created as the
///result of calling one of the IFunctionDiscovery methods; client program do not create these objects themselves.
@GUID("33591C10-0BED-4F02-B0AB-1530D5533EE9")
interface IFunctionInstance : IServiceProvider
{
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Gets the identifier string for
    ///the function instance. This identifier can be saved and later used to re-query for the same function instance
    ///through IFunctionDiscovery::GetInstance.
    ///Params:
    ///    ppszCoMemIdentity = The function instance identifier string. There is no upper limit on the size of this string. This string is a
    ///                        composed string generated by Function Discovery. It has the provider instance identifier string as a
    ///                        substring. For more information about provider identifiers, see IFunctionInstance::GetProviderInstanceID. For
    ///                        function instances returned by a built-in provider, this identifier is guaranteed to uniquely identify a
    ///                        resource on a system, even if the resource is disconnected and reconnected. For function instances returned
    ///                        by custom providers, the function instance identifier is unique if the provider has a unique provider
    ///                        identifier. This identifier should not be manipulated or manufactured programmatically. The string should
    ///                        only be used to retrieve function instances and for comparison purposes. Be sure to free this buffer using
    ///                        CoTaskMemFree.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> The value of <i>ppszCoMemID</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method is unable to allocate the memory
    ///    required to perform this operation. </td> </tr> </table>
    ///    
    HRESULT GetID(ushort** ppszCoMemIdentity);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Gets the identifier string for
    ///the provider instance. This string is the unique identifier for the provider instance.
    ///Params:
    ///    ppszCoMemProviderInstanceIdentity = The provider instance identifier string. For root devices, this string has the same value as
    ///                                        PKEY_PNPX_GlobalIdentity. Be sure to free this buffer using CoTaskMemFree.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> The value of <i>ppszCoMemProviderInstanceID</i> is invalid. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method is unable to allocate
    ///    the memory required to perform this operation. </td> </tr> </table>
    ///    
    HRESULT GetProviderInstanceID(ushort** ppszCoMemProviderInstanceIdentity);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Opens the property store for the
    ///function instance. The property store contains metadata about the function instance, such as its name, icon,
    ///installation date, and other information.
    ///Params:
    ///    dwStgAccess = The access mode to be assigned to the open stream. For this method, the following access modes are supported:
    ///                  <a id="STGM_READ"></a> <a id="stgm_read"></a>
    ///    ppIPropertyStore = A pointer to an IPropertyStore interface pointer.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>STG_E_ACCESSDENIED</b></dt>
    ///    </dl> </td> <td width="60%"> The method could not open a writeable property store because the caller has
    ///    insufficient access or the discovery provider does not allow write access to its property store. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value of
    ///    <i>dwStgAccess</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
    ///    <td width="60%"> The <i>ppIPropertyStore</i> points to invalid memory. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method is unable to allocate the memory
    ///    required to perform this operation. </td> </tr> </table>
    ///    
    HRESULT OpenPropertyStore(uint dwStgAccess, IPropertyStore* ppIPropertyStore);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Gets the category and subcategory
    ///strings for the function instance.
    ///Params:
    ///    ppszCoMemCategory = The null-terminated identifier string of the category. See Category Definitions. Be sure to free this buffer
    ///                        using CoTaskMemFree.
    ///    ppszCoMemSubCategory = The null-terminated identifier string of the subcategory. See Subcategory Definitions.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
    ///    </td> <td width="60%"> The method is unable to allocate the memory required to perform this operation. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetCategory(ushort** ppszCoMemCategory, ushort** ppszCoMemSubCategory);
}

///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions.] This interface represents a group of
///IFunctionInstance objects returned as the result of a query or get instance request through one of the
///IFunctionDiscovery methods; client program do not create these collections themselves.
@GUID("F0A3D895-855C-42A2-948D-2F97D450ECB1")
interface IFunctionInstanceCollection : IUnknown
{
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Gets the number of function
    ///instances in the collection.
    ///Params:
    ///    pdwCount = The number of function instances.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> The <i>pdwCount</i> parameter is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetCount(uint* pdwCount);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Gets the specified function
    ///instance and its index from the collection.
    ///Params:
    ///    pszInstanceIdentity = The identifier of the function instance to be retrieved (see GetID).
    ///    pdwIndex = The index number.
    ///    ppIFunctionInstance = A pointer to an IFunctionInstance interface pointer that receives the function instance.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td
    ///    width="60%"> The function instance identified by <i>pInstanceIdentity</i> is not present in the function
    ///    instance collection. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The value of <i>pdwIndex</i> or <i>pInstanceIdentity</i> is invalid. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method is unable to allocate
    ///    the memory required to perform this operation. </td> </tr> </table>
    ///    
    HRESULT Get(const(wchar)* pszInstanceIdentity, uint* pdwIndex, IFunctionInstance* ppIFunctionInstance);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Gets the specified function
    ///instance, by index.
    ///Params:
    ///    dwIndex = The zero-based index of the function instance to be retrieved.
    ///    ppIFunctionInstance = A pointer to an IFunctionInstance interface pointer that receives the function instance.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> The <i>ppFunctionInstance</i> parameter is <b>NULL</b> or <i>dwIndex</i> is out of
    ///    range. </td> </tr> </table>
    ///    
    HRESULT Item(uint dwIndex, IFunctionInstance* ppIFunctionInstance);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Adds a function instance to the
    ///collection.
    ///Params:
    ///    pIFunctionInstance = A pointer to an IFunctionInstance interface for the function instance to be added to the collection.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> The value of <i>pIFunctionInstance</i> is invalid. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method is unable to allocate the memory
    ///    required to perform this operation. </td> </tr> </table>
    ///    
    HRESULT Add(IFunctionInstance pIFunctionInstance);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Deletes the specified function
    ///instance and returns a pointer to the function instance being removed.
    ///Params:
    ///    dwIndex = The index number within the collection.
    ///    ppIFunctionInstance = A pointer to an IFunctionInstance interface pointer that receives the function instance.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> The value of <i>dwIndex</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method is unable to allocate the memory
    ///    required to perform this operation. </td> </tr> </table>
    ///    
    HRESULT Remove(uint dwIndex, IFunctionInstance* ppIFunctionInstance);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Removes the specified function
    ///instance from the collection.
    ///Params:
    ///    dwIndex = The index number of the item to be removed from the collection.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> The value of <i>dwIndex</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method is unable to allocate the memory
    ///    required to perform this operation. </td> </tr> </table>
    ///    
    HRESULT Delete(uint dwIndex);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Removes all function instances
    ///from the collection.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DeleteAll();
}

@GUID("D14D9C30-12D2-42D8-BCE4-C60C2BB226FA")
interface IPropertyStoreCollection : IUnknown
{
    HRESULT GetCount(uint* pdwCount);
    HRESULT Get(const(wchar)* pszInstanceIdentity, uint* pdwIndex, IPropertyStore* ppIPropertyStore);
    HRESULT Item(uint dwIndex, IPropertyStore* ppIPropertyStore);
    HRESULT Add(IPropertyStore pIPropertyStore);
    HRESULT Remove(uint dwIndex, IPropertyStore* pIPropertyStore);
    HRESULT Delete(uint dwIndex);
    HRESULT DeleteAll();
}

///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions.] This interface implements the
///asynchronous query for a function instance based on category and subcategory. A pointer to this interface is returned
///when the query is created by the client program.
@GUID("6242BC6B-90EC-4B37-BB46-E229FD84ED95")
interface IFunctionInstanceQuery : IUnknown
{
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Performs the query defined by
    ///IFunctionDiscovery::CreateInstanceQuery.
    ///Params:
    ///    ppIFunctionInstance = A pointer to an IFunctionInstance interface pointer that receives the requested function instance.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return
    ///    code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The method completed successfully. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>ppIFunctionInstance</i> parameter is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> The method is unable to allocate the memory required to perform this operation. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_PENDING</b></dt> </dl> </td> <td width="60%"> The results to be returned by a
    ///    provider will come through asynchronous notification. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_OBJECT_NOT_FOUND)</b></dt> <dt>0x800710d8</dt> </dl> </td> <td width="60%">
    ///    The function instance represented by the specified ID does not exist on this computer. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_KEY_DELETED)</b></dt> <dt>0x800703fa</dt> </dl> </td> <td
    ///    width="60%"> The function instance could not be returned because the key corresponding to the function
    ///    instance was deleted by another process. This error is returned by the registry provider if a key is deleted
    ///    while query processing is taking place. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)</b></dt> <dt>0x80070002</dt> </dl> </td> <td width="60%"> The
    ///    function instance could not be returned because the key corresponding to the function instance could not be
    ///    found. This error is returned by the registry provider when the provider could not find matching instances
    ///    for an instance query. </td> </tr> </table> A predefined query is a query of a layered category. When a
    ///    predefined query is executed, each provider that returns a function instance also returns an HRESULT value.
    ///    The provider HRESULT values are aggregated, and the value returned by the Execute method reflects these
    ///    aggregate results. Results are aggregated as follows: <ul> <li>If all providers return S_OK, Execute returns
    ///    S_OK.</li> <li>If at least one provider returns E_PENDING, and all other providers return either S_OK or
    ///    E_PENDING, Execute returns E_PENDING.</li> <li>If all providers return an error value (that is, a value other
    ///    than S_OK or E_PENDING), Execute returns the error value returned by the network provider that was last
    ///    queried. Also, if the client's IFunctionDiscoveryNotification callback routine was provided to
    ///    IFunctionDiscovery::CreateInstanceCollectionQuery, an OnError notification is sent for each provider. Each
    ///    <b>OnError</b> notification contains the HRESULT returned by the provider.</li> <li>If at least one provider
    ///    returns an error value, and all other providers return S_OK, Execute returns S_OK. OnError notification(s)
    ///    are sent as described above.</li> <li>If at least one provider returns an error value, and at least one
    ///    provider returns E_PENDING, Execute returns E_PENDING. OnError notification(s) are sent as described
    ///    above.</li> </ul>
    ///    
    HRESULT Execute(IFunctionInstance* ppIFunctionInstance);
}

///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions.] This interface implements the
///asynchronous query for a collection of function instances based on category and subcategory. A pointer to this
///interface is returned when the collection query is created by the client program.
@GUID("57CC6FD2-C09A-4289-BB72-25F04142058E")
interface IFunctionInstanceCollectionQuery : IUnknown
{
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] The <b>AddQueryConstraint</b>
    ///method adds a query constraint to the query. This method enables the application to filter the result set to only
    ///those instances that fulfill this constraint.
    ///Params:
    ///    pszConstraintName = The query constraint.
    ///    pszConstraintValue = The constraint value.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
    ///    </td> <td width="60%"> The method is unable to allocate the memory required to perform this operation. </td>
    ///    </tr> </table>
    ///    
    HRESULT AddQueryConstraint(const(wchar)* pszConstraintName, const(wchar)* pszConstraintValue);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Adds a property constraint to the
    ///query. This method limits query results to only function instances with a property key (PKEY) matching the
    ///specified constraint.
    ///Params:
    ///    Key = The property key (PKEY) for the constraint. For more information about PKEYs, see Key Definitions.
    ///    pv = A <b>PROPVARIANT</b> used for the constraint. This type must match the PROPVARIANT type associated with
    ///         <i>Key</i>. The following shows possible values. Note that only a subset of the PROPVARIANT types supported
    ///         by the built-in providers can be used as a property constraint. <p class="indent">VT_BOOL <p
    ///         class="indent">VT_I2 <p class="indent">VT_I4 <p class="indent">VT_I8 <p class="indent">VT_INT <p
    ///         class="indent">VT_LPWSTR <p class="indent">VT_LPWSTR|VT_VECTOR <p class="indent">VT_UI2 <p
    ///         class="indent">VT_UI4 <p class="indent">VT_UI8 <p class="indent">VT_UINT
    ///    enumPropertyConstraint = A PropertyConstraint value that specifies the type of comparison to use when comparing the constraint's PKEY
    ///                             to the function instance's PKEY.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
    ///    </td> <td width="60%"> The method is unable to allocate the memory required to perform this operation. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl> </td> <td
    ///    width="60%"> The constraint specified for the query is not supported. Either the constraint is not supported
    ///    for a specific <b>VARENUM</b> type, or the <b>VARENUM</b> type is not supported at all. </td> </tr> </table>
    ///    
    HRESULT AddPropertyConstraint(const(PROPERTYKEY)* Key, const(PROPVARIANT)* pv, 
                                  PropertyConstraint enumPropertyConstraint);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Performs the query defined by
    ///IFunctionDiscovery::CreateInstanceCollectionQuery.
    ///Params:
    ///    ppIFunctionInstanceCollection = A pointer to an IFunctionInstanceCollection interface pointer that receives the requested function instance
    ///                                    collection.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. Results are returned synchronously in <i>ppIFunctonInstanceCollecton</i>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method
    ///    is unable to allocate the memory required to perform this operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_PENDING</b></dt> </dl> </td> <td width="60%"> Some of the results will be returned by asynchronous
    ///    notification. See the remarks for details. </td> </tr> </table> A predefined query is a query of a layered
    ///    category. When a predefined query is executed, each provider that returns a function instance also returns an
    ///    HRESULT value. The provider HRESULT values are aggregated, and the value returned by the <b>Execute</b>
    ///    method reflects these aggregate results. Results are aggregated as follows: <ul> <li>If all providers return
    ///    <b>S_OK</b>, <b>Execute</b> returns <b>S_OK</b>.</li> <li>If at least one provider returns <b>E_PENDING</b>,
    ///    and all other providers return either <b>S_OK</b> or <b>E_PENDING</b>, <b>Execute</b> returns
    ///    <b>E_PENDING</b>.</li> <li>If all providers return an error value (that is, a value other than <b>S_OK</b> or
    ///    <b>E_PENDING</b>), <b>Execute</b> returns the error value returned by the network provider that was last
    ///    queried. Also, if the client's IFunctionDiscoveryNotification callback routine was provided to
    ///    IFunctionDiscovery::CreateInstanceCollectionQuery, an OnError notification is sent for each provider. Each
    ///    <b>OnError</b> notification contains the HRESULT returned by the provider.</li> <li>If at least one provider
    ///    returns an error value, and all other providers return <b>S_OK</b>, <b>Execute</b> returns <b>S_OK</b>.
    ///    OnError notifications are sent as described above.</li> <li>If at least one provider returns an error value,
    ///    and at least one provider returns <b>E_PENDING</b>, <b>Execute</b> returns <b>E_PENDING</b>. OnError
    ///    notifications are sent as described above.</li> </ul> When <b>Execute</b> returns <b>S_OK</b>,
    ///    <i>ppIFunctionInstanceCollection</i> contains the results of the query. If an IFunctionDiscoveryNotification
    ///    interface is provided to the CreateInstanceCollectionQuery method of IFunctionDiscovery, then changes to the
    ///    results will be communicated using that interface. When <b>Execute</b> returns <b>E_PENDING</b>, the result
    ///    set will be returned asynchronously through the IFunctionDiscoveryNotification interface provided to the
    ///    CreateInstanceCollectionQuery method of IFunctionDiscovery. <i>ppIFunctionInstanceCollection</i> may be
    ///    <b>NULL</b> or may contain a partial result set. The enumeration is complete once the OnEvent method of
    ///    <b>IFunctionDiscoveryNotification</b> is called with <b>FD_EVENTID_SEARCHCOMPLETE</b>. After the
    ///    <b>FD_EVENTID_SEARCHCOMPLETE</b> event is received, additional notifications are updates to the results.
    ///    
    HRESULT Execute(IFunctionInstanceCollection* ppIFunctionInstanceCollection);
}

interface CFunctionDiscoveryNotificationWrapper : IFunctionDiscoveryNotification
{
}

///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions.] This is the main interface
///implemented by a discovery provider. It is the primary interface the Function Discovery infrastructure uses to
///communicate with the provider and its resources. You should only implement and use this interface if you are writing
///a discovery provider. You should only write a discovery provider if you must discover devices using a method that is
///not supported by the built-in providers. If you are writing a client program that discovers and queries devices, use
///the IFunctionDiscovery interface instead. The Function Discovery Provider Sample implements the
///<b>IFunctionDiscoveryProvider</b> interface.
@GUID("DCDE394F-1478-4813-A402-F6FB10657222")
interface IFunctionDiscoveryProvider : IUnknown
{
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Initializes the Function
    ///Discovery provider object. This method is intended to be called immediately after the object is created.
    ///Params:
    ///    pIFunctionDiscoveryProviderFactory = A pointer to the IFunctionDiscoveryProviderFactory interface. The provider should use this interface to
    ///                                         create new Function Discovery objects.
    ///    pIFunctionDiscoveryNotification = A pointer to an IFunctionDiscoveryNotification interface. The provider should use this interface to send
    ///                                      OnUpdate, OnEvent, and OnError notifications to the Function Discovery notification queue. Queued
    ///                                      notifications are sent to client programs by Function Discovery.
    ///    lcidUserDefault = The locale identifier of the caller. The provider should use <i>lcidUserDefault</i> to return localized
    ///                      strings for the resource enumerated by the provider.
    ///    pdwStgAccessCapabilities = Specifies the least restrictive possible access mode of the property stores associated with the function
    ///                               instances created by this provider. If the DWORD value is set to -1, InstancePropertyStoreValidateAccess will
    ///                               be called every time OpenPropertyStore is called on a function instance created by this provider. Otherwise,
    ///                               the value specified by this parameter determines the least restrictive possible access mode for all property
    ///                               stores associated with all function insteances created by this provider. A more restrictive access mode will
    ///                               be applied to an individual property store if a client calls <b>OpenPropertyStore</b> with the
    ///                               <i>dwStgAccess</i> parameter set to a value that is more restrictive than the specified
    ///                               <i>pdwStgAccessCapabilities</i> value. For efficiency, specify a <i>pdwStgAccessCapabilities</i> value
    ///                               whenever possible. The following modes are supported: <a id="STGM_READ"></a> <a id="stgm_read"></a>
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters contains an invalid argument. </td> </tr> </table>
    ///    
    HRESULT Initialize(IFunctionDiscoveryProviderFactory pIFunctionDiscoveryProviderFactory, 
                       IFunctionDiscoveryNotification pIFunctionDiscoveryNotification, uint lcidUserDefault, 
                       uint* pdwStgAccessCapabilities);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Retrieves a collection of
    ///function instances that meet the specified constraints.
    ///Params:
    ///    pIFunctionDiscoveryProviderQuery = A pointer to an IFunctionDiscoveryProviderQuery interface that contains parameters that define the query
    ///                                       criteria.
    ///    ppIFunctionInstanceCollection = A pointer to an IFunctionInstanceCollection interface that the provider should use to return function
    ///                                    instances synchronously in response to the given query. When you implement the <b>Query</b> method, you can
    ///                                    set this parameter to <b>NULL</b> if your provider supports notifications, that is, your provider returns
    ///                                    results asynchronously. Asynchronous results should be returned using the IFunctionDiscoveryNotification
    ///                                    interface passed to the provider's Initialize method. If the client application has not implemented
    ///                                    notifications, it may pass a <b>NULL</b> parameter.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully and the results are being returned synchronously. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>pIFunctionDiscoveryProviderQuery</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_PENDING</b></dt> </dl> </td> <td width="60%"> The method completed successfully and the results are
    ///    being returned asynchronously. </td> </tr> </table>
    ///    
    HRESULT Query(IFunctionDiscoveryProviderQuery pIFunctionDiscoveryProviderQuery, 
                  IFunctionInstanceCollection* ppIFunctionInstanceCollection);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Terminates a query being executed
    ///by a provider.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters contains an invalid argument. </td> </tr> </table>
    ///    
    HRESULT EndQuery();
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Verifies that the provider
    ///supports the requested access. It is called when OpenPropertyStore is called on a function instance to verify
    ///that the provider supports the access mode passed by the <i>dwStgAccess</i> parameter. This method is only called
    ///when a provider's Initialize method returns a <i>pdwStgAccessCapabilities</i> parameter value of -1.
    ///Params:
    ///    pIFunctionInstance = A pointer to the IFunctionInstance interface.
    ///    iProviderInstanceContext = The context associated with the specific function instance.
    ///    dwStgAccess = The access mode to be verified. For this method, the following modes are supported: <a id="STGM_READ"></a> <a
    ///                  id="stgm_read"></a>
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td>
    ///    <td width="60%"> The provider does not implement an instance property store. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>STG_E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The method could not open a
    ///    writeable property store because the caller has insufficient access, the discovery provider does not allow
    ///    write access to its property store, or another property store is already open for this function instance.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value of
    ///    <i>dwStgAccess</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
    ///    </td> <td width="60%"> The method is unable to allocate the memory required to perform this operation. </td>
    ///    </tr> </table>
    ///    
    HRESULT InstancePropertyStoreValidateAccess(IFunctionInstance pIFunctionInstance, 
                                                ptrdiff_t iProviderInstanceContext, const(uint) dwStgAccess);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Opens the property store of the
    ///provider. This method is called whenever IFunctionInstance::OpenPropertyStore is called if the provider did not
    ///provide a property store at creation time. The provider can provide the property store at this time, or handle
    ///the IProviderProperties methods as they are called.
    ///Params:
    ///    pIFunctionInstance = A pointer to the IFunctionInstance interface for the store that is to be opened. Each property store is
    ///                         associated with a function instance.
    ///    iProviderInstanceContext = The context associated with the specific function instance.
    ///    dwStgAccess = The access mode to be assigned to the open stream. For this method, the following modes are supported: <a
    ///                  id="STGM_READ"></a> <a id="stgm_read"></a>
    ///    ppIPropertyStore = A pointer to an <b>IPropertyStore</b> interface pointer.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td>
    ///    <td width="60%"> The provider does not implement an instance property store. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>STG_E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The method could not open a
    ///    writeable property store because the caller has insufficient access, the discovery provider does not allow
    ///    write access to its property store, or another property store is already open for this function instance.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
    ///    parameters contains an invalid argument. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt>
    ///    </dl> </td> <td width="60%"> The method is unable to allocate the memory required to perform this operation.
    ///    </td> </tr> </table>
    ///    
    HRESULT InstancePropertyStoreOpen(IFunctionInstance pIFunctionInstance, ptrdiff_t iProviderInstanceContext, 
                                      const(uint) dwStgAccess, IPropertyStore* ppIPropertyStore);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Provides a mechanism for the
    ///provider to persist properties without having to implement IProviderProperties. This method is called whenever
    ///IPropertyStore::Commit is called by the client on the function instance property store.
    ///Params:
    ///    pIFunctionInstance = A pointer to the IFunctionInstance interface.
    ///    iProviderInstanceContext = The context associated with the specific function instance.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The provider does not implement an
    ///    instance property store. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> One of the parameters contains an invalid argument. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method is unable to allocate the memory
    ///    required to perform this operation. </td> </tr> </table>
    ///    
    HRESULT InstancePropertyStoreFlush(IFunctionInstance pIFunctionInstance, ptrdiff_t iProviderInstanceContext);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Creates a provider-specific COM
    ///object for the function instance. Provider writers can implement this method to offer additional functionality
    ///through the COM object.
    ///Params:
    ///    pIFunctionInstance = A pointer to the IFunctionInstance interface.
    ///    iProviderInstanceContext = The context associated with the specific function instance.
    ///    guidService = The unique identifier of the service (a SID). This is the service ID defined by the provider writer. For an
    ///                  example, see FunctionDiscoveryServiceIDs.h.
    ///    riid = The unique identifier of the interface the caller wishes to receive for the service.
    ///    ppIUnknown = A pointer that receives the interface pointer of the service. The caller is responsible for calling
    ///                 <b>Release</b> through this interface pointer when the service is no longer needed.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl>
    ///    </td> <td width="60%"> The provider does implement the service identified by <i>guidService</i> but does not
    ///    implement the interface identified by <i>rrid</i>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method is unable to allocate the memory
    ///    required to perform this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl>
    ///    </td> <td width="60%"> The provider does not implement the IFunctionInstance::QueryService method, or the
    ///    service identifier specified by <i>guidService</i> does not match the provider's service identifier. </td>
    ///    </tr> </table>
    ///    
    HRESULT InstanceQueryService(IFunctionInstance pIFunctionInstance, ptrdiff_t iProviderInstanceContext, 
                                 const(GUID)* guidService, const(GUID)* riid, IUnknown* ppIUnknown);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Releases the specified function
    ///instance and frees the memory previously allocated.
    ///Params:
    ///    pIFunctionInstance = A pointer to an IFunctionInstance interface.
    ///    iProviderInstanceContext = The context associated with the specific function instance.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters contains an
    ///    invalid argument. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> The method is unable to allocate the memory required to perform this operation. </td> </tr>
    ///    </table>
    ///    
    HRESULT InstanceReleased(IFunctionInstance pIFunctionInstance, ptrdiff_t iProviderInstanceContext);
}

///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions.] This interface is optionally
///implemented by discovery providers to directly create and manage their own property store. If this interface is
///implemented, the provider can use its property store for its own internal use, but all queries from the property
///store implemented by this interface will go directly to the provider, and the internal property store will never be
///exposed to a client calling IFunctionInstance::OpenPropertyStore.
@GUID("CF986EA6-3B5F-4C5F-B88A-2F8B20CEEF17")
interface IProviderProperties : IUnknown
{
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Gets the number of properties in
    ///the property store.
    ///Params:
    ///    pIFunctionInstance = An IFunctionInstance interface pointer.
    ///    iProviderInstanceContext = The context associated with the specific function instance.
    ///    pdwCount = The number of properties in the property store.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters contains an invalid argument. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pdwCount</i> parameter is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetCount(IFunctionInstance pIFunctionInstance, ptrdiff_t iProviderInstanceContext, uint* pdwCount);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Gets the property key at the
    ///specified index.
    ///Params:
    ///    pIFunctionInstance = A pointer to an IFunctionInstance interface.
    ///    iProviderInstanceContext = The context associated with the specific function instance.
    ///    dwIndex = The index of the property key.
    ///    pKey = The property key.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the input parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>pKey</i> parameter is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetAt(IFunctionInstance pIFunctionInstance, ptrdiff_t iProviderInstanceContext, uint dwIndex, 
                  PROPERTYKEY* pKey);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Gets the value of the specified
    ///property key.
    ///Params:
    ///    pIFunctionInstance = An IFunctionInstance interface pointer.
    ///    iProviderInstanceContext = The context associated with the specific function instance.
    ///    Key = The property key reference.
    ///    ppropVar = The value of the property key specified by <i>Key</i>. The <b>PROPVARIANT</b> type is VT_EMPTY if the key is
    ///               not found in the property store.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters contains an invalid argument. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>ppropVar</i> parameter is <b>NULL</b>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method is
    ///    unable to allocate enough memory to perform the operation. </td> </tr> </table>
    ///    
    HRESULT GetValue(IFunctionInstance pIFunctionInstance, ptrdiff_t iProviderInstanceContext, 
                     const(PROPERTYKEY)* Key, PROPVARIANT* ppropVar);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Sets the value of the specified
    ///property key.
    ///Params:
    ///    pIFunctionInstance = An IFunctionInstance interface.
    ///    iProviderInstanceContext = The context associated with the specific function instance.
    ///    Key = The property key for the property to be set.
    ///    ppropVar = The property data. To remove the property from the store, specify a <b>PROPVARIANT</b> with the type
    ///               VT_EMPTY.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
    ///    <td width="60%"> The <i>pIFunctionInstance</i>, <i>pvProviderInstanceContext</i>, or <i>ppropVar</i>
    ///    parameter is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT SetValue(IFunctionInstance pIFunctionInstance, ptrdiff_t iProviderInstanceContext, 
                     const(PROPERTYKEY)* Key, const(PROPVARIANT)* ppropVar);
}

///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions.] This interface is implemented by a
///discovery provider to enable a client program to add and remove function instances.
@GUID("CD1B9A04-206C-4A05-A0C8-1635A21A2B7C")
interface IProviderPublishing : IUnknown
{
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Creates a new function instance.
    ///Params:
    ///    enumVisibilityFlags = A SystemVisibilityFlags enumeration value that specifies the visibility of the function instance which the
    ///                          provider is about to create. It is up to the provider whether or not to honor this flag, however the current
    ///                          user visibility can be used to allow processes running in a non-Administrator security context to still be
    ///                          able to add function instances.
    ///    pszSubCategory = The subcategory string for the function instance.
    ///    pszProviderInstanceIdentity = The provider instance identifier.
    ///    ppIFunctionInstance = A pointer to an IFunctionInstance interface pointer used to return the newly created function instance.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters contains an invalid argument. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pszSubCategory</i>,
    ///    <i>pszProviderInstanceIdentity</i>, or <i>ppInstance</i> parameter is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT CreateInstance(SystemVisibilityFlags enumVisibilityFlags, const(wchar)* pszSubCategory, 
                           const(wchar)* pszProviderInstanceIdentity, IFunctionInstance* ppIFunctionInstance);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Deletes an existing function
    ///instance.
    ///Params:
    ///    enumVisibilityFlags = A SystemVisibilityFlags enumeration value which specifies the visibility of the function instance which the
    ///                          provider is about to delete. It is up to the provider whether or not to honor this setting, however the
    ///                          current user visibility can be used to allow processes running in a non-Administrator security context to
    ///                          still be able to remove function instances.
    ///    pszSubCategory = The subcategory string of the function instance.
    ///    pszProviderInstanceIdentity = The provider instance identifier.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters contains an invalid argument. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>pSiteInfo</i>, <i>pszSubCategory</i>, or
    ///    <i>pszProviderInstanceIdentity</i> parameter is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT RemoveInstance(SystemVisibilityFlags enumVisibilityFlags, const(wchar)* pszSubCategory, 
                           const(wchar)* pszProviderInstanceIdentity);
}

///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions.] Provides factory methods to create
///Function Discovery objects. Synchronous query results are passed using the IFunctionInstanceCollection parameter of
///IFunctionDiscoveryProvider::Query method.
@GUID("86443FF0-1AD5-4E68-A45A-40C2C329DE3B")
interface IFunctionDiscoveryProviderFactory : IUnknown
{
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Enables providers to reuse the
    ///in-memory property store implementation.
    ///Params:
    ///    ppIPropertyStore = A pointer to an <b>IPropertyStore</b> interface pointer.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreatePropertyStore(IPropertyStore* ppIPropertyStore);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Creates a function instance. All
    ///function instances should be created using this method. Other implementations that support IFunctionInstance
    ///should not be used.
    ///Params:
    ///    pszSubCategory = The subcategory string for the function instance. See Subcategory Definitions.
    ///    pszProviderInstanceIdentity = The provider instance identifier. Function Discovery uses this identifier to ensure that function instance
    ///                                  identifiers returned by IFunctionInstance::GetID are unique. To that end, Function Discovery attaches a
    ///                                  prefix to the identifier passed to <i>pszProviderInstanceIdentity</i> to ensure that a given function
    ///                                  instance identifier is unique across all providers. Implementers only need to ensure that
    ///                                  <i>pszProviderInstanceIdentity</i> uniquely identifies the device, resource, or instance within the scope of
    ///                                  the provider. This string is returned to client applications that call
    ///                                  IFunctionInstance::GetProviderInstanceID. There is no upper limit on the size of this string.
    ///    iProviderInstanceContext = The context associated with the specific function instance.
    ///    pIPropertyStore = A pointer to an <b>IPropertyStore</b> interface.
    ///    pIFunctionDiscoveryProvider = A pointer to the IFunctionDiscoveryProvider provider instance creating this function instance.
    ///    ppIFunctionInstance = A pointer to an IFunctionInstance interface.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateInstance(const(wchar)* pszSubCategory, const(wchar)* pszProviderInstanceIdentity, 
                           ptrdiff_t iProviderInstanceContext, IPropertyStore pIPropertyStore, 
                           IFunctionDiscoveryProvider pIFunctionDiscoveryProvider, 
                           IFunctionInstance* ppIFunctionInstance);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Creates a function instance
    ///collection.
    ///Params:
    ///    ppIFunctionInstanceCollection = A pointer to an IFunctionInstanceCollection interface pointer.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value of
    ///    <i>ppIFunctionInstanceCollection</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method is unable to allocate the memory
    ///    required to perform this operation. </td> </tr> </table>
    ///    
    HRESULT CreateFunctionInstanceCollection(IFunctionInstanceCollection* ppIFunctionInstanceCollection);
}

///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions.] This interface is passed to all
///IFunctionDiscoveryProvider::Query method calls and contains query definition information. Providers should use this
///to determine what the constraints are for each query request they receive.
@GUID("6876EA98-BAEC-46DB-BC20-75A76E267A3A")
interface IFunctionDiscoveryProviderQuery : IUnknown
{
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Determines whether a query is for
    ///a single function instance or multiple function instances.
    ///Params:
    ///    pisInstanceQuery = If this parameter is <b>TRUE</b>, there is a provider instance identifier constraint in the query constraints
    ///                       collection.
    ///    ppszConstraintValue = The value of the provider instance identifier constraint.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT IsInstanceQuery(int* pisInstanceQuery, ushort** ppszConstraintValue);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Determines whether a query is for
    ///function instances in a specific subcategory.
    ///Params:
    ///    pisSubcategoryQuery = If this parameter is <b>TRUE</b>, there is a subcategory constraint in the query constraints collection.
    ///    ppszConstraintValue = The value of the subcategory constraint.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT IsSubcategoryQuery(int* pisSubcategoryQuery, ushort** ppszConstraintValue);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Retrieves the current query
    ///constraints.
    ///Params:
    ///    ppIProviderQueryConstraints = A pointer to an IProviderQueryConstraintCollection interface pointer that receives the collection of query
    ///                                  constraints.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetQueryConstraints(IProviderQueryConstraintCollection* ppIProviderQueryConstraints);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Retrieves the current property
    ///constraints.
    ///Params:
    ///    ppIProviderPropertyConstraints = A pointer to an IProviderPropertyConstraintCollection interface pointer that receives the collection of
    ///                                     property constraints.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPropertyConstraints(IProviderPropertyConstraintCollection* ppIProviderPropertyConstraints);
}

///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions.] This interface is accessible to the
///provider through the IFunctionDiscoveryProviderQuery::GetQueryConstraints method.
@GUID("9C243E11-3261-4BCD-B922-84A873D460AE")
interface IProviderQueryConstraintCollection : IUnknown
{
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Gets the number of items in the
    ///collection.
    ///Params:
    ///    pdwCount = The number of items.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCount(uint* pdwCount);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Gets the value of the specified
    ///query constraint, by name.
    ///Params:
    ///    pszConstraintName = The constraint name.
    ///    ppszConstraintValue = The constraint value.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td
    ///    width="60%"> The method completed successfully, but the property key was not found in the collection. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>pszConstraintName</i> or <i>ppszConstraintValue</i> parameter is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT Get(const(wchar)* pszConstraintName, ushort** ppszConstraintValue);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Gets the name and value of the
    ///specified query constraint, by index.
    ///Params:
    ///    dwIndex = The index of the item in the collection.
    ///    ppszConstraintName = The constraint name.
    ///    ppszConstraintValue = The constraint value.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
    ///    <td width="60%"> The <i>pszConstraintName</i> or <i>ppszConstraintValue</i> parameter is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT Item(uint dwIndex, ushort** ppszConstraintName, ushort** ppszConstraintValue);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Gets the name and value of the
    ///next query constraint in the collection.
    ///Params:
    ///    ppszConstraintName = The constraint name.
    ///    ppszConstraintValue = The constraint value.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Next(ushort** ppszConstraintName, ushort** ppszConstraintValue);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Skips the next item in the
    ///collection.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> </table>
    ///    
    HRESULT Skip();
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Resets the current index to the
    ///start of the collection.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> </table>
    ///    
    HRESULT Reset();
}

///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions.] This interface is accessible to the
///provider through IFunctionDiscoveryProviderQuery::GetPropertyConstraints.
@GUID("F4FAE42F-5778-4A13-8540-B5FD8C1398DD")
interface IProviderPropertyConstraintCollection : IUnknown
{
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Gets the number of items in the
    ///collection.
    ///Params:
    ///    pdwCount = The number of items.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> </table>
    ///    
    HRESULT GetCount(uint* pdwCount);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Gets the name and value of the
    ///specified property constraint, by property key.
    ///Params:
    ///    Key = The property key.
    ///    pPropVar = A <b>VARIANT</b> used for the property key constraint value.
    ///    pdwPropertyConstraint = The type of constraint to apply.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td
    ///    width="60%"> The method completed successfully, but the property key was not found in the collection. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>ppropVar</i>
    ///    or <i>pdwPropertyConstraint</i> parameter is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT Get(const(PROPERTYKEY)* Key, PROPVARIANT* pPropVar, uint* pdwPropertyConstraint);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Gets the name and value of the
    ///specified property constraint, by index.
    ///Params:
    ///    dwIndex = The index of the item in the collection.
    ///    pKey = The property key.
    ///    pPropVar = A <b>PROPVARIANT</b> used for the property constraint data.
    ///    pdwPropertyConstraint = The type of constraint to apply.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
    ///    <td width="60%"> The <i>ppropVar</i> or <i>pdwPropertyConstraint</i> parameter is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT Item(uint dwIndex, PROPERTYKEY* pKey, PROPVARIANT* pPropVar, uint* pdwPropertyConstraint);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Gets the name and value of the
    ///next property constraint in the collection.
    ///Params:
    ///    pKey = The property key.
    ///    pPropVar = A <b>PROPVARIANT</b> used for the property constraint data.
    ///    pdwPropertyConstraint = The type of constraint to apply.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
    ///    <td width="60%"> The <i>ppropVar</i> or <i>pdwPropertyConstraint</i> parameter is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT Next(PROPERTYKEY* pKey, PROPVARIANT* pPropVar, uint* pdwPropertyConstraint);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Skips the next item in the
    ///collection.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Skip();
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Resets the current index to the
    ///start of the collection.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Reset();
}

///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions.] This interface is implemented to
///create and initialize objects to provide a specified access interface to a resource represented by the function
///instance. After the object is created, the Initialize method is called to initialize the object.
@GUID("4C81ED02-1B04-43F2-A451-69966CBCD1C2")
interface IFunctionDiscoveryServiceProvider : IUnknown
{
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Initializes an object that
    ///provides a specific interface that has been bound to the resource represented by the function instance.
    ///Params:
    ///    pIFunctionInstance = A pointer to an IFunctionInstance interface that represents the underlying resource.
    ///    riid = A reference to the identifier of the interface to be used to communicate with the object.
    ///    ppv = The interface pointer requested in <i>riid</i>. Upon successful return, <i>*ppv</i> contains the requested
    ///          interface pointer. Upon failure, <i>*ppv</i> contains <b>NULL</b>.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One of the parameters contains an invalid argument. </td> </tr> </table>
    ///    
    HRESULT Initialize(IFunctionInstance pIFunctionInstance, const(GUID)* riid, void** ppv);
}

///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions.] Defines methods to manage the
///association database entries for PnP-X devices. . These methods send notifications when the corresponding PnP devnode
///changes. An application calls <b>IPNPXAssociation</b> methods when the application programmatically manages PnP-X
///device association, either through a custom user interface or through some other method. Usually, the <b>Network
///Explorer</b> is used to manage PnP-X device association.
@GUID("0BD7E521-4DA6-42D5-81BA-1981B6B94075")
interface IPNPXAssociation : IUnknown
{
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Marks an association database
    ///entry as associated. If there is no association database entry for the function instance, one is created;
    ///otherwise the existing entry is updated.
    ///Params:
    ///    pszSubcategory = The subcategory of the association database in which the entry is stored. This parameter can be <b>NULL</b>.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%">
    ///    The method failed. </td> </tr> </table>
    ///    
    HRESULT Associate(const(wchar)* pszSubcategory);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Marks an association database
    ///entry as unassociated. If a function instance is unassociated, then it is a <i>not present</i> instance and the
    ///device corresponding to the function instance is not available for use.
    ///Params:
    ///    pszSubcategory = The subcategory of the association database in which the entry is stored. This parameter can be <b>NULL</b>.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%">
    ///    The method failed. </td> </tr> </table>
    ///    
    HRESULT Unassociate(const(wchar)* pszSubcategory);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Removes an entry from the
    ///association database.
    ///Params:
    ///    pszSubcategory = The subcategory of the association database in which the entry is stored. This parameter can be <b>NULL</b>.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%">
    ///    The method failed. </td> </tr> </table>
    ///    
    HRESULT Delete(const(wchar)* pszSubcategory);
}

///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions.] Defines methods to manage the
///association database entries for PnP-X devices. These methods send notifications when the corresponding PnP devnode
///changes. An application calls <b>IPNPXDeviceAssociation</b> methods when the application programmatically manages
///PnP-X device association, either through a custom user interface or through some other method. Usually, the
///<b>Network Explorer</b> is used to manage PnP-X device association.
@GUID("EED366D0-35B8-4FC5-8D20-7E5BD31F6DED")
interface IPNPXDeviceAssociation : IUnknown
{
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Marks an association database
    ///entry as associated and sends an appropriate notification. If there is no association database entry for the
    ///function instance, one is created; otherwise the existing entry is updated. Any notification sent reflects the
    ///online presence of the device, as reported by the Plug and Play (PnP) component.
    ///Params:
    ///    pszSubCategory = The subcategory of the association database in which the entry is stored. This parameter can be <b>NULL</b>.
    ///    pIFunctionDiscoveryNotification = An IFunctionDiscoveryNotification object that is registered for notifications with Function Discovery.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method failed. </td> </tr>
    ///    </table>
    ///    
    HRESULT Associate(const(wchar)* pszSubCategory, IFunctionDiscoveryNotification pIFunctionDiscoveryNotification);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Marks an association database
    ///entry as unassociated and sends an appropriate notification.
    ///Params:
    ///    pszSubCategory = The subcategory of the association database in which the entry is stored. This parameter can be <b>NULL</b>.
    ///    pIFunctionDiscoveryNotification = An IFunctionDiscoveryNotification object that is registered for notifications with Function Discovery.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%">
    ///    The method failed. </td> </tr> </table>
    ///    
    HRESULT Unassociate(const(wchar)* pszSubCategory, 
                        IFunctionDiscoveryNotification pIFunctionDiscoveryNotification);
    ///<p class="CCE_Message">[Function Discovery is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions.] Removes an entry from the
    ///association database and sends an appropriate notification.
    ///Params:
    ///    pszSubcategory = The subcategory of the association database in which the entry is stored. This parameter can be <b>NULL</b>.
    ///    pIFunctionDiscoveryNotification = An IFunctionDiscoveryNotification object that is registered for notifications with Function Discovery.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%">
    ///    The method failed. </td> </tr> </table>
    ///    
    HRESULT Delete(const(wchar)* pszSubcategory, IFunctionDiscoveryNotification pIFunctionDiscoveryNotification);
}

///Is a collection of namespaces and types used in a WSDAPI stack.
@GUID("75D8F3EE-3E5A-43B4-A15A-BCF6887460C0")
interface IWSDXMLContext : IUnknown
{
    ///Creates an object that represents a namespace in an XML context. If the namespace already exists, no new
    ///namespace will be added, and the namespace object for the existing name will be returned.
    ///Params:
    ///    pszUri = The URI of the namespace.
    ///    pszSuggestedPrefix = The namespace prefix to use when generating XML. If the namespace already exists, <i>pszSuggestedPrefix</i>
    ///                         will overwrite the prefix currently associated with the namespace. The XML context may assign a different
    ///                         namespace prefix. The prefix assigned by the XML context takes precedence over the suggested prefix. The
    ///                         <b>PreferredPrefix</b> member of the structure pointed to by <i>ppNamespace</i> contains the prefix assigned
    ///                         by the XML context.
    ///    ppNamespace = Pointer to the address of the WSDXML_NAMESPACE structure that represents the namespace. You must deallocate
    ///                  <i>ppNamespace</i> by calling WSDFreeLinkedMemory. This parameter is optional.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> <i>pszUri</i> is <b>NULL</b>, the length in characters of the URI string exceeds
    ///    WSD_MAX_TEXT_LENGTH (8192), <i>pszSuggestedPrefix</i> is <b>NULL</b>, or the length in characters of the
    ///    prefix string exceeds WSD_MAX_TEXT_LENGTH (8192). </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the operation.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method failed.
    ///    </td> </tr> </table>
    ///    
    HRESULT AddNamespace(const(wchar)* pszUri, const(wchar)* pszSuggestedPrefix, WSDXML_NAMESPACE** ppNamespace);
    ///Creates an object that represents a name in a namespace in an XML context. If the name already exists in the
    ///namespace, no new name will be added, and the name object for the existing name will be returned.
    ///Params:
    ///    pszUri = The URI of the XML namespace in which this name will be created. If this namespace does not already exist in
    ///             the XML context, a new namespace structure will be generated automatically.
    ///    pszName = The name to add to the namespace specified by <i>pszUri</i>.
    ///    ppName = A WSDXML_NAME structure for the newly created name. You must deallocate <i>ppName</i> by calling
    ///             WSDFreeLinkedMemory. This parameter is optional.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> <i>pszUri</i> is <b>NULL</b> or the length in characters of the URI string exceeds
    ///    WSD_MAX_TEXT_LENGTH (8192). <i>pszName</i> is <b>NULL</b> or the length in characters of the name string
    ///    exceeds WSD_MAX_TEXT_LENGTH (8192). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt>
    ///    </dl> </td> <td width="60%"> Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT AddNameToNamespace(const(wchar)* pszUri, const(wchar)* pszName, WSDXML_NAME** ppName);
    ///Associates custom namespaces with the XML context object. This method should only be called by generated code,
    ///and should not be called directly by a WSDAPI client. Instead, the code generator will provide wrappers that
    ///access this method properly.
    ///Params:
    ///    pNamespaces = An array of WSDXML_NAMESPACE structures.
    ///    wNamespacesCount = The number of namespaces in the <i>pNamespaces</i> array.
    ///    bLayerNumber = The layer number associated with the generated service code.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> <i>pNamespaces</i> is <b>NULL</b> or <i>bLayerNumber</i> is greater than or equal to
    ///    WSD_XMLCONTEXT_NUM_LAYERS (16). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
    ///    </td> <td width="60%"> Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT SetNamespaces(char* pNamespaces, ushort wNamespacesCount, ubyte bLayerNumber);
    ///Associates custom message types with the XML context object. This method should only be called by generated code,
    ///and should not be called directly by a WSDAPI client. Instead, the code generator will provide wrappers that
    ///access this method properly.
    ///Params:
    ///    pTypes = An array of WSDXML_TYPE structures that represent the set of messages for the generated code.
    ///    dwTypesCount = The number of types in the <i>pTypes</i> array.
    ///    bLayerNumber = The layer number associated with the generated service code.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> <i>pTypes</i> is <b>NULL</b> or <i>bLayerNumber</i> is greater than or equal to
    ///    WSD_XMLCONTEXT_NUM_LAYERS (16). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
    ///    </td> <td width="60%"> Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT SetTypes(char* pTypes, uint dwTypesCount, ubyte bLayerNumber);
}

///Provides access to the individual components of a transport address.
@GUID("B9574C6C-12A6-4F74-93A1-3318FF605759")
interface IWSDAddress : IUnknown
{
    ///Assembles the component parts of the address into a string.
    ///Params:
    ///    pszBuffer = Buffer to receive the assembled address.
    ///    cchLength = Length of <i>pszBuffer</i>, in bytes.
    ///    fSafe = If <b>TRUE</b>, the resulting string will be network safe. For example, if you used IWSDTransportAddress to
    ///            build an IPv6 address, the serialized string will not contain the IPv6 scope identifier. However, if
    ///            <i>fSafe</i> is <b>FALSE</b>, then the resulting string will contain the IPv6 scope identifier. For all other
    ///            IWSDAddress derived objects, there is no specific meaning for this parameter (other than ensuring that the
    ///            method generate portable addresses).
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
    ///    <td width="60%"> <i>pszBuffer</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The method could not be completed. </td> </tr> </table>
    ///    
    HRESULT Serialize(const(wchar)* pszBuffer, uint cchLength, BOOL fSafe);
    ///Parses the address, validates its component parts and saves them in the object.
    ///Params:
    ///    pszBuffer = Address to save in the object.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> <i>pszBuffer</i> is <b>NULL</b>, its length in characters exceeds WSD_MAX_TEXT_LENGTH
    ///    (8192), or it does not contain an address in a valid format. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the operation.
    ///    </td> </tr> </table>
    ///    
    HRESULT Deserialize(const(wchar)* pszBuffer);
}

///Represents an IP-based transport address. You should not create an instance of the <b>IWSDTransportAddress</b>
///interface. Instead, create an instance of either the IWSDHttpAddress or IWSDUdpAddress interface if an address object
///is required.
@GUID("70D23498-4EE6-4340-A3DF-D845D2235467")
interface IWSDTransportAddress : IWSDAddress
{
    ///Gets the IP port number associated with this transport address.
    ///Params:
    ///    pwPort = Port number associated with the address object.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pwPort</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetPort(ushort* pwPort);
    HRESULT SetPortA(ushort wPort);
    ///Gets a pointer to a string representation of the address object. The format of the string varies, and is
    ///determined by the implementing interface (either IWSDHttpAddress or IWSDUdpAddress).
    ///Params:
    ///    ppszAddress = String representation of the address object. Do not deallocate this pointer.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>ppszAddress</i> is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The transport
    ///    address has not yet been set. To set the transport address, call SetTransportAddress with a non-<b>NULL</b>
    ///    address. </td> </tr> </table>
    ///    
    HRESULT GetTransportAddress(ushort** ppszAddress);
    ///Gets a pointer to a string representation of the address object. The format of the string varies, and is
    ///determined by the implementing interface (either IWSDHttpAddress or IWSDUdpAddress).
    ///Params:
    ///    fSafe = Specifies whether the scope identifier for an IPv6 address is included in the returned <i>ppszAddress</i>
    ///            string. For example, if the address object represents an IPv6 link local address and <i>fSafe</i> is
    ///            <b>FALSE</b>, then the IPv6 scope identifier will be included in the returned <i>ppszAddress</i> string. If
    ///            the address object represents an IPv4 address or a host name, this parameter is ignored.
    ///    ppszAddress = String representation of the address object. Do not deallocate this pointer.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>ppszAddress</i> is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The transport
    ///    address has not yet been set. To set the transport address, call SetTransportAddress with a non-<b>NULL</b>
    ///    address. </td> </tr> </table>
    ///    
    HRESULT GetTransportAddressEx(BOOL fSafe, ushort** ppszAddress);
    ///Sets the string representation of the transport address. The format of the string varies, and is determined by
    ///the implementing interface (either IWSDHttpAddress or IWSDUdpAddress).
    ///Params:
    ///    pszAddress = String representation of the transport address.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The length in characters of the
    ///    address string pointed to by <i>ppszAddress</i> exceeds WSD_MAX_TEXT_LENGTH (8192), <i>ppszAddress</i> is
    ///    <b>NULL</b>, or the format of <i>ppszAddress</i> was not recognized. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the operation.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetTransportAddress(const(wchar)* pszAddress);
}

///Use this interface to communicate message specific information up and down the protocol stack.
@GUID("1FAFE8A2-E6FC-4B80-B6CF-B7D45C416D7C")
interface IWSDMessageParameters : IUnknown
{
    ///Retrieves the generic address object representing the local address that received the message.
    ///Params:
    ///    ppAddress = An IWSDAddress interface that represents the local address that received the message.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>ppAddress</i> is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetLocalAddress(IWSDAddress* ppAddress);
    ///Sets a generic address object representing the source address that should send the message.
    ///Params:
    ///    pAddress = An IWSDAddress interface that represents the source address that should send the message.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> </table>
    ///    
    HRESULT SetLocalAddress(IWSDAddress pAddress);
    ///Retrieves the generic address object representing the remote address from which the message was sent.
    ///Params:
    ///    ppAddress = An IWSDAddress interface that represents the remote address from which the message was sent.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>ppAddress</i> is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetRemoteAddress(IWSDAddress* ppAddress);
    ///Sets the generic address object representing the remote address to where the message is sent.
    ///Params:
    ///    pAddress = An IWSDAddress interface that represents the remote address to where the message is sent.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> </table>
    ///    
    HRESULT SetRemoteAddress(IWSDAddress pAddress);
    ///Retrieves message parameters from the layer below this layer in the protocol stack.
    ///Params:
    ///    ppTxParams = An IWSDMessageParameters interface that you use to communicate message specific information up and down the
    ///                 protocol stack.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The method was not implemented.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetLowerParameters(IWSDMessageParameters* ppTxParams);
}

///Use this interface to specify how often WSD repeats the message transmission. To get this interface from a UDP
///message sent during discovery, call the <b>QueryInterface</b> method of IWSDMessageParameters passing
///__uuidof(IWSDUdpMessageParameters) as the interface identifier. You can also call WSDCreateUdpMessageParameters to
///retrieve this interface.
@GUID("9934149F-8F0C-447B-AA0B-73124B0CA7F0")
interface IWSDUdpMessageParameters : IWSDMessageParameters
{
    ///Sets the values that WSD uses to determine how often to repeat the message transmission.
    ///Params:
    ///    pParams = Pointer to a WSDUdpRetransmitParams structure. The structure contains values that determine how often WSD
    ///              repeats the message transmission.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> </table>
    ///    
    HRESULT SetRetransmitParams(const(WSDUdpRetransmitParams)* pParams);
    ///Retrieves the values that WSD uses to determine how often to repeat the message transmission.
    ///Params:
    ///    pParams = Pointer to a WSDUdpRetransmitParams structure. The structure contains values that determine how often WSD
    ///              repeats the message transmission.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
    ///    <td width="60%"> <i>pParams</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetRetransmitParams(WSDUdpRetransmitParams* pParams);
}

///Provides access to the individual components of a UDP address.
@GUID("74D6124A-A441-4F78-A1EB-97A8D1996893")
interface IWSDUdpAddress : IWSDTransportAddress
{
    ///Sets the socket address information.
    ///Params:
    ///    pSockAddr = Pointer to a SOCKADDR_STORAGE structure.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> <i>pSockAddr</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the operation.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(WSAEINVAL)</b></dt> </dl> </td> <td
    ///    width="60%"> The specified address is not a valid socket address, or no transport provider supports the
    ///    indicated address family. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(WSANOTINITIALISED)</b></dt> </dl> </td> <td width="60%"> The Winsock 2 DLL has not
    ///    been initialized. The application must first call WSAStartup to initialize Winsock 2. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(WSAENOBUFS)</b></dt> </dl> </td> <td width="60%"> No buffer space
    ///    available. </td> </tr> </table>
    ///    
    HRESULT SetSockaddr(const(SOCKADDR_STORAGE)* pSockAddr);
    ///Gets the socket address information.
    ///Params:
    ///    pSockAddr = Pointer to a SOCKADDR_STORAGE structure that contains the address information.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
    ///    <td width="60%"> <i>pSockAddr</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT GetSockaddr(SOCKADDR_STORAGE* pSockAddr);
    ///Controls whether the socket is in exclusive mode.
    ///Params:
    ///    fExclusive = A value of <b>TRUE</b> indicates that the socket should be set to exclusive mode. A value of <b>FALSE</b>
    ///                 indicates that the socket should not be in exclusive mode.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> </table>
    ///    
    HRESULT SetExclusive(BOOL fExclusive);
    ///Determines whether the socket is in exclusive mode.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    socket is in exclusive mode. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td
    ///    width="60%"> The socket is not in exclusive mode. </td> </tr> </table>
    ///    
    HRESULT GetExclusive();
    ///Sets the message type for this UDP address configuration. There are two types of messages: one-way messages,
    ///which do not require responses, and two-way messages, which do require responses.
    ///Params:
    ///    messageType = A WSDUdpMessageType value that specifies the message type used for this address configuration.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetMessageType(WSDUdpMessageType messageType);
    ///Gets the message type for this UDP address configuration. There are two types of messages; one-way messages,
    ///which do not require responses, and two-way messages, which do require responses.
    ///Params:
    ///    pMessageType = Pointer to a WSDUdpMessageType value that specifies the message type used for this address configuration.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pMessageType</i> is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetMessageType(WSDUdpMessageType* pMessageType);
    ///Sets the time-to-live (TTL) for all outbound packets using this address.
    ///Params:
    ///    dwTTL = The TTL of outgoing UDP packets. Generally, the TTL represents the maximum number of hops before a packet is
    ///            discarded. Some implementations interpret the TTL differently.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> <i>dwTTL</i> is greater than 255. </td> </tr> </table>
    ///    
    HRESULT SetTTL(uint dwTTL);
    ///Gets the time-to-live (TTL) for all outbound packets using this address.
    ///Params:
    ///    pdwTTL = Pointer to the TTL of outgoing UDP packets. Generally, the TTL represents the maximum number of hops before a
    ///             packet is discarded. Some implementations interpret the TTL differently.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pdwTTL</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetTTL(uint* pdwTTL);
    ///Sets the alias for the discovery address. This method is reserved for internal use and should not be called.
    ///Params:
    ///    pAlias = A pointer to the alias of the discovery address.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> </table>
    ///    
    HRESULT SetAlias(const(GUID)* pAlias);
    ///Gets the alias for the discovery address. This method is reserved for internal use and should not be called.
    ///Params:
    ///    pAlias = Pointer to the alias of the discovery address.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
    ///    <td width="60%"> <i>pAlias</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetAlias(GUID* pAlias);
}

///Provides access to the HTTP headers used when transmitting messages via SOAP-over-HTTP.
@GUID("540BD122-5C83-4DEC-B396-EA62A2697FDF")
interface IWSDHttpMessageParameters : IWSDMessageParameters
{
    ///Sets the HTTP headers used for inbound SOAP-over-HTTP transmissions.
    ///Params:
    ///    pszHeaders = The HTTP headers to be set.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> The length in characters of <i>pszHeaders</i> exceeds WSD_MAX_TEXT_LENGTH (8192).
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT SetInboundHttpHeaders(const(wchar)* pszHeaders);
    ///Retrieves the current HTTP headers used for inbound SOAP-over-HTTP transmissions.
    ///Params:
    ///    ppszHeaders = Pointer used to receive the current HTTP headers in use. Do not deallocate this pointer.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppszHeaders</i> is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> There
    ///    are no headers available. </td> </tr> </table>
    ///    
    HRESULT GetInboundHttpHeaders(ushort** ppszHeaders);
    ///Sets the HTTP headers used for outbound SOAP-over-HTTP transmissions.
    ///Params:
    ///    pszHeaders = The HTTP headers to be set.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> The length in characters of <i>pszHeaders</i> exceeds WSD_MAX_TEXT_LENGTH (8192).
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT SetOutboundHttpHeaders(const(wchar)* pszHeaders);
    ///Retrieves the current HTTP headers used for outbound SOAP-over-HTTP transmissions.
    ///Params:
    ///    ppszHeaders = Pointer used to receive the current HTTP headers in use. Do not deallocate this pointer.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppszHeaders</i> is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> There
    ///    are no headers available. </td> </tr> </table>
    ///    
    HRESULT GetOutboundHttpHeaders(ushort** ppszHeaders);
    ///Sets the transport ID for the current transaction.
    ///Params:
    ///    pszId = Pointer to the desired transport ID for the current transaction.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> <i>pszId</i> is <b>NULL</b> or the length in characters of <i>pszId</i> exceeds
    ///    WSD_MAX_TEXT_LENGTH (8192). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td>
    ///    <td width="60%"> Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT SetID(const(wchar)* pszId);
    ///Retrieves the transport ID for the current transaction.
    ///Params:
    ///    ppszId = Pointer used to return the transport ID for the current transaction. Do not deallocate this pointer.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppszId</i> is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The transport ID
    ///    is not available. </td> </tr> </table>
    ///    
    HRESULT GetID(ushort** ppszId);
    ///Sets the private transmission context for the current transaction.
    ///Params:
    ///    pContext = Pointer to the desired private transmission context for the current transaction.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> </table>
    ///    
    HRESULT SetContext(IUnknown pContext);
    ///Retrieves the private transmission context for the current transaction.
    ///Params:
    ///    ppContext = Pointer to the pointer used to retrieve the desired private transmission context for the current transaction.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppContext</i> is NULL. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Could not retrieve the
    ///    context. </td> </tr> </table>
    ///    
    HRESULT GetContext(IUnknown* ppContext);
    ///Clears the HTTP headers used for SOAP-over-HTTP transmissions.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> </table>
    ///    
    HRESULT Clear();
}

///Provides access to the individual components of an HTTP address.
@GUID("D09AC7BD-2A3E-4B85-8605-2737FF3E4EA0")
interface IWSDHttpAddress : IWSDTransportAddress
{
    ///Retrieves the status on whether TLS secure sessions are enabled for this address.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> TLS secure sessions are enabled for this address. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> TLS secure sessions are
    ///    disabled for this address. </td> </tr> </table>
    ///    
    HRESULT GetSecure();
    ///Enables or disables TLS secure sessions for this address.
    ///Params:
    ///    fSecure = <b>TRUE</b> to enable TLS secure session communications for this address, <b>FALSE</b> to disable TLS.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> </table>
    ///    
    HRESULT SetSecure(BOOL fSecure);
    ///Gets the URI path for this address.
    ///Params:
    ///    ppszPath = Pointer to the URI path for this address. Do not release this object.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>ppszPath</i> is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetPath(ushort** ppszPath);
    ///Sets the URI path for this address.
    ///Params:
    ///    pszPath = The URI path to use for this address.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The length in characters of
    ///    <i>pszPath</i> exceeds WSD_MAX_TEXT_LENGTH (8192). </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT SetPath(const(wchar)* pszPath);
}

///Retrieves the client SSL certificate.
@GUID("DE105E87-A0DA-418E-98AD-27B9EED87BDC")
interface IWSDSSLClientCertificate : IUnknown
{
    ///Gets the client certificate.
    ///Params:
    ///    ppCertContext = A pointer to a CERT_CONTEXT structure that contains the client SSL certificate. Upon completion, the caller
    ///                    should free this memory by calling CertFreeCertificateContext.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTFOUND</b></dt> </dl> </td> <td
    ///    width="60%"> A certificate is not available. </td> </tr> </table>
    ///    
    HRESULT GetClientCertificate(CERT_CONTEXT** ppCertContext);
    ///Gets the mapped access token.
    ///Params:
    ///    phToken = A handle for the mapped access token. Upon completion, the caller must free the handle by calling
    ///              CloseHandle.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%">
    ///    The token associated with the specified handle is not available. </td> </tr> </table>
    ///    
    HRESULT GetMappedAccessToken(HANDLE* phToken);
}

///Use this interface to retrieve the access token or authorization scheme used during the authentication of a client.
@GUID("0B476DF0-8DAC-480D-B05C-99781A5884AA")
interface IWSDHttpAuthParameters : IUnknown
{
    ///The <b>GetClientAccessToken</b> method retrieves the client access token that can be used to either authenticate
    ///or impersonate the client.
    ///Params:
    ///    phToken = Pointer to a variable that on return receives the token handle.
    ///Returns:
    ///    This method returns S_OK on success.
    ///    
    HRESULT GetClientAccessToken(HANDLE* phToken);
    ///The <b>GetAuthType</b> method retrieves the HTTP authentication scheme used during the authentication of the
    ///client.
    ///Params:
    ///    pAuthType = Pointer to an HTTP_REQUEST_AUTH_TYPE value that indicates the HTTP authentication scheme used during
    ///                authentication. Possible values include: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///                width="40%"><a id="WSD_SECURITY_HTTP_AUTH_SCHEME_NEGOTIATE_"></a><a
    ///                id="wsd_security_http_auth_scheme_negotiate_"></a><dl> <dt><b>WSD_SECURITY_HTTP_AUTH_SCHEME_NEGOTIATE
    ///                </b></dt> <dt>0x1</dt> </dl> </td> <td width="60%"> Negotiate authentication. </td> </tr> <tr> <td
    ///                width="40%"><a id="WSD_SECURITY_HTTP_AUTH_SCHEME_NTLM"></a><a
    ///                id="wsd_security_http_auth_scheme_ntlm"></a><dl> <dt><b>WSD_SECURITY_HTTP_AUTH_SCHEME_NTLM</b></dt>
    ///                <dt>0x2</dt> </dl> </td> <td width="60%"> NTLM authentication. </td> </tr> </table>
    ///Returns:
    ///    This method returns S_OK on success.
    ///    
    HRESULT GetAuthType(uint* pAuthType);
}

///Provides properties of signed messages.
@GUID("03CE20AA-71C4-45E2-B32E-3766C61C790F")
interface IWSDSignatureProperty : IUnknown
{
    ///Specifies if a message is signed.
    ///Params:
    ///    pbSigned = A pointer to a boolean that specifies if a message signature is signed.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method succeeded. </td> </tr> </table>
    ///    
    HRESULT IsMessageSigned(int* pbSigned);
    ///Specifies if a message signature is trusted.
    ///Params:
    ///    pbSignatureTrusted = A pointer to a boolean that specifies if a message signature is trusted.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method succeeded. </td> </tr> </table>
    ///    
    HRESULT IsMessageSignatureTrusted(int* pbSignatureTrusted);
    HRESULT GetKeyInfo(char* pbKeyInfo, uint* pdwKeyInfoSize);
    ///Gets the signature of a message.
    ///Params:
    ///    pbSignature = A pointer to a buffer that will be filled with the signature of the message.
    ///    pdwSignatureSize = On input, the size of <i>pbSignature</i> in bytes. On output, <i>pdwSignatureSize</i> contains the actual
    ///                       size of the buffer that was written.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTAVAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The message is not signed. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt> </dl> </td> <td width="60%"> <i>pbSignature</i> is not
    ///    large enough to hold the information. <i>pdwSignatureSize</i> now specifies the required buffer size. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetSignature(char* pbSignature, uint* pdwSignatureSize);
    ///Gets the hash of a message signature.
    ///Params:
    ///    pbSignedInfoHash = A pointer to a buffer that will be filled with the hash of the message signature.
    ///    pdwHashSize = On input, the size of <i>pbSignedInfoHash</i> in bytes. On output, <i>pdwHashSize</i> contains the actual
    ///                  size of the buffer that was written.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTAVAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The message is not signed. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</b></dt> </dl> </td> <td width="60%"> <i>pbSignedInfoHash</i> is
    ///    not large enough to hold the information. <i>pdwHashSize</i> now specifies the required buffer size. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetSignedInfoHash(char* pbSignedInfoHash, uint* pdwHashSize);
}

///Represents a DPWS-compliant device . The device host will announce its presence on the network using the WS-Discovery
///protocol. The device host will also automatically respond to discovery queries and metadata requests. The caller can
///register user-implemented services with the device host. These services will be exposed in the device metadata and
///the services will be available over the network. Messages bound for these services will be automatically dispatched
///into the service object. Call WSDCreateDeviceHost or WSDCreateDeviceHostAdvanced to create an object that exposes
///this interface.
@GUID("917FE891-3D13-4138-9809-934C8ABEB12C")
interface IWSDDeviceHost : IUnknown
{
    ///Initializes an instance of an IWSDDeviceHost object, which is the host-side representation of a device.
    ///Params:
    ///    pszLocalId = The logical or physical address of the device. A logical address is of the form <code>urn:uuid:{guid}</code>.
    ///                 If <i>pszLocalId</i> is a logical address, the host will announce the logical address and then convert the
    ///                 address to a physical address when it receives Resolve or Probe messages. If <i>pszLocalId</i> is a physical
    ///                 address (such as URL prefixed by http or https), the host will use the address as the physical address and
    ///                 will host on that address instead of the default one. For secure communication, <i>pszLocalId</i> must be an
    ///                 URL prefixed by https, and the host will use the SSL/TLS protocol on the port specified in the URL. The
    ///                 recommended port is port 5358, as this port is reserved for secure connections with WSDAPI. If no port is
    ///                 specified, then the host will use port 443. The host port must be configured with an SSL server certificate.
    ///                 For more information about the configuration of host ports, see HttpSetServiceConfiguration. Any URL (http or
    ///                 https) must be terminated with a trailing slash. The URL must contain a valid IP address or hostname. The
    ///                 following list shows some example values for <i>pszLocalId</i>. It is not a complete list of valid values.
    ///                 <ul> <li>http://192.168.0.1:5357/</li> <li>http://localhost/</li> <li>http://myHostname:5357/ </li>
    ///                 <li>https://192.168.0.1:5358/ </li> <li>https://myHostname/ </li> <li>https://myHostname/myDevice/ </li>
    ///                 <li>https://myHostname:5358/ </li> </ul>
    ///    pContext = An IWSDXMLContext interface that defines custom message types or namespaces.
    ///    ppHostAddresses = A single IWSDAddress object or IWSDTransportAddress object. The objects provide information about specific
    ///                      addresses that the host should listen on. If <i>pszLocalId</i> contains a local address, the resulting
    ///                      behavior is a mapping between the logical address and the supplied physical address (instead of a mapping
    ///                      between the logical address and the default physical address).
    ///    dwHostAddressCount = The number of items in the <i>ppHostAddresses</i> array. If <i>ppHostAddresses</i> is an IWSDAddress
    ///                         interface, count must be 1.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> <i>pszLocalId</i> is <b>NULL</b>, the length in characters of <i>pszLocalId</i>
    ///    exceeds WSD_MAX_TEXT_LENGTH (8192), or the number of addresses referenced by <i>ppHostAddresses</i> does not
    ///    match <i>dwHostAddressCount</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td>
    ///    <td width="60%"> The device host is in an unexpected state. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the operation.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> Initialization
    ///    could not be completed. </td> </tr> </table>
    ///    
    HRESULT Init(const(wchar)* pszLocalId, IWSDXMLContext pContext, char* ppHostAddresses, uint dwHostAddressCount);
    ///Starts the device host and publishes the device host using a WS-Discovery Hello message. If a notification sink
    ///is passed to this method, then the notification sink is also registered. After <b>Start</b> has been called
    ///successfully, the device host will automatically respond to Probe and Resolve messages.
    ///Params:
    ///    ullInstanceId = The instance identifier. If no identifier is provided, the current instance value + 1 is used as the default.
    ///                    <div class="alert"><b>Note</b> For compatibility with the WS-Discovery specification, this value must be less
    ///                    than or equal to UINT_MAX (4294967295).</div> <div> </div>
    ///    pScopeList = Scope of the device host. If <b>NULL</b>, no scopes are associated with the host.
    ///    pNotificationSink = Reference to an IWSDDeviceHostNotify object that specifies the notification sink.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td
    ///    width="60%"> The device host has already been started. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method failed. It may have failed because the host
    ///    has not been initialized. Call Init to initialize a device host. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> There is no metadata associated with the host. </td>
    ///    </tr> </table>
    ///    
    HRESULT Start(ulong ullInstanceId, const(WSD_URI_LIST)* pScopeList, IWSDDeviceHostNotify pNotificationSink);
    ///Sends a WS-Discovery Bye message and stops the host. After a host has been successfully stopped, it must be
    ///terminated with IWSDDeviceHost::Terminate before being released.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td
    ///    width="60%"> The host has already stopped. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt>
    ///    </dl> </td> <td width="60%"> The host is not initialized or the host is not started. </td> </tr> </table>
    ///    
    HRESULT Stop();
    ///Terminates the host and releases any attached services. If a notification sink was passed to the Start method,
    ///then the notification sink is released.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The host is uninitialized or the host has already been terminated. </td> </tr> </table>
    ///    
    HRESULT Terminate();
    ///Registers a port type for incoming messages. All port types listed in the service host metadata must be
    ///registered.
    ///Params:
    ///    pPortType = Reference to a WSD_PORT_TYPE structure that describes the port type.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
    ///    </td> <td width="60%"> Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The port type specified by <i>pPortType</i> has already
    ///    been registered. </td> </tr> </table>
    ///    
    HRESULT RegisterPortType(const(WSD_PORT_TYPE)* pPortType);
    ///Sets the metadata for a device, excluding user-defined service metadata.
    ///Params:
    ///    pThisModelMetadata = Reference to a WSD_THIS_MODEL_METADATA structure which specifies metadata that is common to all instances of
    ///                         the model of this device. The <b>Manufacturer</b>, <b>ModelNames</b>, and <b>ModelNumber</b> members of the
    ///                         structure must contain non-<b>NULL</b>, non-blank entries.
    ///    pThisDeviceMetadata = Reference to a WSD_THIS_DEVICE_METADATA structure which specifies metadata unique to this device. The
    ///                          <b>FriendlyName</b>, <b>FirmwareVersion</b>, and <b>SerialNumber</b> members of this structure must contain
    ///                          non-<b>NULL</b>, non-blank entries.
    ///    pHostMetadata = Reference to a WSD_HOST_METADATA structure that specifies service host metadata, which the specific data and
    ///                    characteristics of the device (for example, a printer supports color or has a stapler.).
    ///    pCustomMetadata = Reference to a WSD_METADATA_SECTION_LIST structure which specifies additional custom metadata associated with
    ///                      this device.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> <i>pThisDeviceMetadata</i> is <b>NULL</b>, <i>pThisModelMetadata</i> is <b>NULL</b>,
    ///    or either structure does not contain the required members. See the parameter descriptions for a list of
    ///    required members. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT SetMetadata(const(WSD_THIS_MODEL_METADATA)* pThisModelMetadata, 
                        const(WSD_THIS_DEVICE_METADATA)* pThisDeviceMetadata, 
                        const(WSD_HOST_METADATA)* pHostMetadata, const(WSD_METADATA_SECTION_LIST)* pCustomMetadata);
    ///Registers a service object for incoming requests and adds the service to the device host metadata.
    ///Params:
    ///    pszServiceId = The ID of the service to be registered. This ID must appear in the device's service host metadata.
    ///    pService = The service object that will handle requests addressed to the specified service.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> <i>pszServiceId</i> is <b>NULL</b>, the length in characters of <i>pszServiceId</i>
    ///    exceeds WSD_MAX_TEXT_LENGTH (8192), or a service matching <i>pszServiceId</i> has already been registered.
    ///    </td> </tr> </table>
    ///    
    HRESULT RegisterService(const(wchar)* pszServiceId, IUnknown pService);
    ///Unregisters a service object that was registered using RegisterService and removes the service from the device
    ///host metadata.
    ///Params:
    ///    pszServiceId = The ID of the service to be removed.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
    ///    <td width="60%"> <i>pszServiceId</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The length in characters of <i>pszServiceId</i>
    ///    exceeds WSD_MAX_TEXT_LENGTH (8192), or <i>pszServiceId</i> was not found in the list of registered services.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method failed.
    ///    It may have failed because the host has not been initialized. Call Init to initialize a device host. </td>
    ///    </tr> </table>
    ///    
    HRESULT RetireService(const(wchar)* pszServiceId);
    ///Registers a service object for incoming requests, but does not add the service to the device host metadata. This
    ///is used for transient (dynamic) services.
    ///Params:
    ///    pszServiceId = The ID for the dynamic service. The service ID must be distinct from all the service IDs in the service host
    ///                   metadata and from any other registered dynamic service. The <i>pszServiceId</i> must be a URI.
    ///    pszEndpointAddress = An optional URI to use as the endpoint address for this service. If none is specified, the device host will
    ///                         assume the service should be available on all local transport addresses.
    ///    pPortType = Reference to a WSD_PORT_TYPE structure that specifies the port type. May be <b>NULL</b>. Specify only one of
    ///                <i>pPortType</i> and <i>pPortName</i>.
    ///    pPortName = Reference to a WSDXML_NAME structure that specifies the type of the service, with associating the service
    ///                with a specified port. Specify only one of <i>pPortType</i> and <i>pPortName</i>.
    ///    pAny = Optional reference to an extensible section to be included in the dynamic service metadata.
    ///    pService = Optional reference to a host service object to register.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
    ///    <td width="60%"> <i>pszServiceId</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The length in characters of <i>pszServiceId</i> or
    ///    <i>pszEndpointAddress</i> exceeds WSD_MAX_TEXT_LENGTH (8192), or both <i>pPortType</i> and <i>pPortName</i>
    ///    are specified. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The
    ///    method failed. It may have failed because the host has not been initialized, or the service specified by
    ///    <i>pszServiceId</i> could not be found. Call Init to initialize a device host. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete
    ///    the operation. </td> </tr> </table>
    ///    
    HRESULT AddDynamicService(const(wchar)* pszServiceId, const(wchar)* pszEndpointAddress, 
                              const(WSD_PORT_TYPE)* pPortType, const(WSDXML_NAME)* pPortName, 
                              const(WSDXML_ELEMENT)* pAny, IUnknown pService);
    ///Unregisters a service object that was registered using AddDynamicService. An unregistered service object does not
    ///receive incoming requests.
    ///Params:
    ///    pszServiceId = The ID for the dynamic service to be removed.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> <i>pszServiceId</i> is <b>NULL</b>, the length in characters of <i>pszServiceId</i>
    ///    exceeds WSD_MAX_TEXT_LENGTH (8192), or <i>pszServiceId</i> was not found in the list of dynamic services.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method failed.
    ///    It may have failed because the host has not been initialized. Call Init to initialize a device host. </td>
    ///    </tr> </table>
    ///    
    HRESULT RemoveDynamicService(const(wchar)* pszServiceId);
    ///Controls whether or not the service is advertised using WS-Discovery.
    ///Params:
    ///    pszServiceId = The ID for the service.
    ///    fDiscoverable = <b>TRUE</b> if the service can be found using WS-Discovery, <b>FALSE</b> if the service is not visible to
    ///                    WS-Discovery.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pszServiceId</i> is
    ///    <b>NULL</b>, the length in characters of <i>pszServiceId</i> exceeds WSD_MAX_TEXT_LENGTH (8192), or
    ///    <i>pszServiceId</i> does not correspond to a registered service. </td> </tr> </table>
    ///    
    HRESULT SetServiceDiscoverable(const(wchar)* pszServiceId, BOOL fDiscoverable);
    ///Notifies all subscribed clients that an event has occurred.
    ///Params:
    ///    pszServiceId = The ID of the service that generates the event.
    ///    pBody = The body of the event.
    ///    pOperation = Reference to a WSD_OPERATION structure that specifies the operation.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The host is not started. Call Start to start the device host. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pszServiceId</i> is <b>NULL</b>,
    ///    <i>pOperation</i> is <b>NULL</b>, the length in characters of <i>pszServiceId</i> exceeds WSD_MAX_TEXT_LENGTH
    ///    (8192), there is no <i>ResponseType</i> structure associated with <i>pOperation</i>, or the service specified
    ///    by <i>pszServiceId</i> is not subscribed to the event specified by the <i>ResponseType</i> member of
    ///    <i>pOperation</i>. </td> </tr> </table>
    ///    
    HRESULT SignalEvent(const(wchar)* pszServiceId, const(void)* pBody, const(WSD_OPERATION)* pOperation);
}

///Provides device-related notifications to an instance of an IWSDDeviceHost object.
@GUID("B5BEE9F9-EEDA-41FE-96F7-F45E14990FB0")
interface IWSDDeviceHostNotify : IUnknown
{
    ///Retrieves a service object that is not currently registered.
    ///Params:
    ///    pszServiceId = The ID of the service to be produced.
    ///    ppService = A reference to an IWSDServiceProxy object for the specified service.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> </table>
    ///    
    HRESULT GetService(const(wchar)* pszServiceId, IUnknown* ppService);
}

///The <b>IWSDServiceMessaging</b> interface is used by generated stub code to send faults or responses to incoming
///messages.
@GUID("94974CF4-0CAB-460D-A3F6-7A0AD623C0E6")
interface IWSDServiceMessaging : IUnknown
{
    ///Sends a response message matching a given request context. This method should be called only from generated code.
    ///Params:
    ///    pBody = Pointer to the message body to send in the response message.
    ///    pOperation = Pointer to a WSD_OPERATION structure that contains the type of response to send.
    ///    pMessageParameters = Pointer to an IWSDMessageParameters object that contains the message parameters from the original request
    ///                         message.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> <i>pOperation</i> or <i>pMessageParameters</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The method could not be completed. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to
    ///    complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT SendResponse(void* pBody, WSD_OPERATION* pOperation, IWSDMessageParameters pMessageParameters);
    ///Sends a fault matching a given request context. This method should be called only from generated code.
    ///Params:
    ///    pRequestHeader = Pointer to a WSD_SOAP_HEADER structure that contains the SOAP header of the original request that caused the
    ///                     fault.
    ///    pMessageParameters = Pointer to an IWSDMessageParameters object that contains the message parameters for the original request that
    ///                         caused the fault.
    ///    pFault = Pointer to a WSD_SOAP_FAULT structure that describes the fault to serialize and send. If this parameter is
    ///             omitted, a fault of type <b>wsa:EndpointUnavailable</b> will be sent.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> <i>pRequestHeader</i> or <i>pMessageParameters</i> is <b>NULL</b>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The method could not be completed.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt>
    ///    </dl> </td> <td width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT FaultRequest(WSD_SOAP_HEADER* pRequestHeader, IWSDMessageParameters pMessageParameters, 
                         WSD_SOAP_FAULT* pFault);
}

///Implements a device services messaging proxy.
@GUID("1860D430-B24C-4975-9F90-DBB39BAA24EC")
interface IWSDEndpointProxy : IUnknown
{
    ///Sends a one-way request message.
    ///Params:
    ///    pBody = The body of the message.
    ///    pOperation = Reference to a WSD_OPERATION structure that specifies the operation to perform.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
    ///    <td width="60%"> <i>pOperation</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT SendOneWayRequest(const(void)* pBody, const(WSD_OPERATION)* pOperation);
    ///Sends a two-way request message using a synchronous call pattern.
    ///Params:
    ///    pBody = The body of the message.
    ///    pOperation = Reference to a WSD_OPERATION structure that specifies the operation to perform.
    ///    pResponseContext = Reference to a WSD_SYNCHRONOUS_RESPONSE_CONTEXT structure or other context structure that specifies the
    ///                       context for handling the response to the request.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
    ///    <td width="60%"> <i>pOperation</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT SendTwoWayRequest(const(void)* pBody, const(WSD_OPERATION)* pOperation, 
                              const(WSD_SYNCHRONOUS_RESPONSE_CONTEXT)* pResponseContext);
    ///Sends a two-way request message using an asynchronous call pattern.
    ///Params:
    ///    pBody = The body of the message.
    ///    pOperation = Reference to a WSD_OPERATION structure that specifies the operation to perform.
    ///    pAsyncState = Anonymous data passed to <i>pCallback</i> when the operation has completed. This data is used to associate a
    ///                  client object with the pending operation. This parameter may be optional.
    ///    pCallback = Reference to an IWSDAsyncCallback object which performs the message status callback notification. This
    ///                parameter may be optional.
    ///    pResult = Reference to an IWSDAsyncResult object that specifies the results of the operation.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
    ///    <td width="60%"> <i>pOperation</i> or <i>pResult</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the operation.
    ///    </td> </tr> </table>
    ///    
    HRESULT SendTwoWayRequestAsync(const(void)* pBody, const(WSD_OPERATION)* pOperation, IUnknown pAsyncState, 
                                   IWSDAsyncCallback pCallback, IWSDAsyncResult* pResult);
    ///Aborts a pending asynchronous operation.
    ///Params:
    ///    pAsyncResult = Calls the Abort method to end the asynchronous operation.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pAsyncResult</i> is
    ///    <b>NULL</b> or <i>pAsyncResult</i> does not support the IWSDAsyncCallback interface. </td> </tr> </table>
    ///    
    HRESULT AbortAsyncOperation(IWSDAsyncResult pAsyncResult);
    ///Processes a SOAP fault retrieved by GetFaultInfo.
    ///Params:
    ///    pFault = Pointer to a WSD_SOAP_FAULT structure containing the fault data.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
    ///    <td width="60%"> <i>pFault</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> The fault was not stored in memory. </td> </tr> </table>
    ///    
    HRESULT ProcessFault(const(WSD_SOAP_FAULT)* pFault);
    ///Retrieves information on the last error.
    ///Params:
    ///    ppszErrorInfo = Pointer to a buffer containing the data for the last recorded error.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
    ///    <td width="60%"> <i>ppszErrorInfo</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetErrorInfo(ushort** ppszErrorInfo);
    ///Retrieves information on the last received fault.
    ///Params:
    ///    ppFault = Pointer to a pointer to a WSD_SOAP_FAULT structure containing the SOAP fault information.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
    ///    <td width="60%"> <i>ppFault</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetFaultInfo(WSD_SOAP_FAULT** ppFault);
}

///Is the base class for other objects which access metadata.
@GUID("06996D57-1D67-4928-9307-3D7833FDB846")
interface IWSDMetadataExchange : IUnknown
{
    ///Retrieves metadata for an object.
    ///Params:
    ///    MetadataOut = Pointer to a linked list of structures containing the requested metadata.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
    ///    <td width="60%"> <i>MetadataOut</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetMetadata(WSD_METADATA_SECTION_LIST** MetadataOut);
}

///Represents a remote WSD service for client applications and middleware.
@GUID("D4C7FB9C-03AB-4175-9D67-094FAFEBF487")
interface IWSDServiceProxy : IWSDMetadataExchange
{
    ///Initiates an asynchronous metadata exchange request with the remote service.
    ///Params:
    ///    ppResult = An IWSDAsyncResult interface that you use to poll for the result, register a callback object, or configure an
    ///               event to be signaled when the response is received.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
    ///    <td width="60%"> <i>ppResult</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The method could not be completed. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete
    ///    the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The
    ///    method failed. </td> </tr> </table>
    ///    
    HRESULT BeginGetMetadata(IWSDAsyncResult* ppResult);
    ///Completes the asynchronous metadata exchange request and retrieves the service metadata from the response.
    ///Params:
    ///    pResult = An IWSDAsyncResult interface that represents the result of the request. Release this object when done.
    ///    ppMetadata = Requested metadata. For details, see WSD_METADATA_SECTION_LIST. Do not release this object.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> </table>
    ///    
    HRESULT EndGetMetadata(IWSDAsyncResult pResult, WSD_METADATA_SECTION_LIST** ppMetadata);
    ///Retrieves the metadata for the IWSDServiceProxy object.
    ///Params:
    ///    ppServiceMetadata = Reference to a WSD_SERVICE_METADATA structure that specifies service metadata. Do not release this object.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
    ///    <td width="60%"> <i>ppServiceMetadata</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetServiceMetadata(WSD_SERVICE_METADATA** ppServiceMetadata);
    ///Subscribes to a notification or solicit/response event.
    ///Params:
    ///    pOperation = Reference to a WSD_OPERATION structure that specifies the operation to subscribe to.
    ///    pUnknown = Anonymous data passed to a client eventing callback function. This data is used to associate a client object
    ///               with the subscription.
    ///    pAny = Extensible data to be added to the body of the subscription request. You can use the IWSDXML* interfaces to
    ///           build the data. For details, see WSDXML_ELEMENT.
    ///    ppAny = Extensible data that the remote device can add to the subscription response. This allows services to provide
    ///            additional customization of event subscriptions. When done, call WSDFreeLinkedMemory to free the memory. For
    ///            details, see WSDXML_ELEMENT. Do not release this object.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> The proxy has already subscribed to the operation specified by <i>pOperation</i>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt>
    ///    </dl> </td> <td width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT SubscribeToOperation(const(WSD_OPERATION)* pOperation, IUnknown pUnknown, const(WSDXML_ELEMENT)* pAny, 
                                 WSDXML_ELEMENT** ppAny);
    ///Cancels a subscription to a notification or solicit/response event.
    ///Params:
    ///    pOperation = Reference to a WSD_OPERATION structure that specifies the operation subscribed to.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> The proxy is not subscribed to the notification specified by <i>pOperation</i>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pOperation</i> is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT UnsubscribeToOperation(const(WSD_OPERATION)* pOperation);
    ///Sets or clears the eventing status callback.
    ///Params:
    ///    pStatus = An IWSDEventingStatus interface that lets the client know of status changes in event subscriptions. If
    ///              <b>NULL</b>, existing eventing status callbacks are cleared.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> </table>
    ///    
    HRESULT SetEventingStatusCallback(IWSDEventingStatus pStatus);
    ///Gets the endpoint proxy for the device.
    ///Params:
    ///    ppProxy = Pointer to an IWSDEndpointProxy interface.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
    ///    <td width="60%"> <i>ppProxy</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetEndpointProxy(IWSDEndpointProxy* ppProxy);
}

///Represents a remote WSD service for client applications and middleware. This interface allows for the implementation
///of multiple asynchronous operations.
@GUID("F9279D6D-1012-4A94-B8CC-FD35D2202BFE")
interface IWSDServiceProxyEventing : IWSDServiceProxy
{
    ///Subscribes to a collection of notifications or solicit/response events.
    ///Params:
    ///    pOperations = Pointer to an array of references to WSD_OPERATION structures that specify the operations of whcih to
    ///                  subscribe.
    ///    dwOperationCount = The number of elements in the array in <i>pOperations</i>.
    ///    pUnknown = Anonymous data passed to a client eventing callback function. This data is used to associate a client object
    ///               with the subscription.
    ///    pExpires = Pointer to a WSD_EVENTING_EXPIRES structure that specifies requested duration for the subscription.
    ///    pAny = Pointer to extensible data to be added to the body of the request. This parameter is optional.
    ///    ppExpires = Pointer to a pointer to a WSD_EVENTING_EXPIRES structure that specfies the duration of the subscription. Upon
    ///                completion, call WSDFreeLinkedMemory to free the memory. This parameter is optional.
    ///    ppAny = Extensible data that the remote device can add to the subscription response. This allows services to provide
    ///            additional customization of event subscriptions. When done, call WSDFreeLinkedMemory to free the memory. For
    ///            details, see WSDXML_ELEMENT. This parameter is optional.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> The proxy has already subscribed to the operation specified by <i>pOperation</i>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt>
    ///    </dl> </td> <td width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT SubscribeToMultipleOperations(char* pOperations, uint dwOperationCount, IUnknown pUnknown, 
                                          const(WSD_EVENTING_EXPIRES)* pExpires, const(WSDXML_ELEMENT)* pAny, 
                                          WSD_EVENTING_EXPIRES** ppExpires, WSDXML_ELEMENT** ppAny);
    ///Initializes an asynchronous operation that subscribes to a collection of notifications or solicit/response
    ///events.
    ///Params:
    ///    pOperations = Pointer to an array of references to WSD_OPERATION structures that specify the operations of which to
    ///                  subscribe.
    ///    dwOperationCount = The number of elements in the array in <i>pOperations</i>.
    ///    pUnknown = Anonymous data passed to a client eventing callback function. This data is used to associate a client object
    ///               with the subscription.
    ///    pExpires = Pointer to a WSD_EVENTING_EXPIRES structure that specifies the requested duration for the subscription.
    ///    pAny = Pointer to extensible data to be added to the body of the request. This parameter is optional.
    ///    pAsyncState = Anonymous data passed to <i>pAsyncCallback</i> when the callback is called. This data is used to associate a
    ///                  client object with the pending operation. This parameter is optional.
    ///    pAsyncCallback = Reference to an IWSDAsyncCallback object that performs the message callback status notifications. This
    ///                     parameter is optional.
    ///    ppResult = Pointer to a pointer to an IWSDAsyncResult interface that will represent the result of the requests upon
    ///               completion.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT BeginSubscribeToMultipleOperations(char* pOperations, uint dwOperationCount, IUnknown pUnknown, 
                                               const(WSD_EVENTING_EXPIRES)* pExpires, const(WSDXML_ELEMENT)* pAny, 
                                               IUnknown pAsyncState, IWSDAsyncCallback pAsyncCallback, 
                                               IWSDAsyncResult* ppResult);
    ///Completes an asynchronous operation that subscribes to a collection of notifications or solicit/response events.
    ///Params:
    ///    pOperations = Pointer to an array of references to WSD_OPERATION structures that specify the subscribed operations.
    ///    dwOperationCount = The number of elements in the array in <i>pOperations</i>.
    ///    pResult = Pointer to an IWSDAsyncResult interface that represents the result of the requests upon completion.
    ///    ppExpires = Pointer to a pointer to a WSD_EVENTING_EXPIRES structure that specfies the duration of the subscription. Upon
    ///                completion, call WSDFreeLinkedMemory to free the memory. This parameter is optional.
    ///    ppAny = Extensible data that the remote device can add to the subscription response. This allows services to provide
    ///            additional customization of event subscriptions. When done, call WSDFreeLinkedMemory to free the memory. For
    ///            details, see WSDXML_ELEMENT. This parameter is optional.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EndSubscribeToMultipleOperations(char* pOperations, uint dwOperationCount, IWSDAsyncResult pResult, 
                                             WSD_EVENTING_EXPIRES** ppExpires, WSDXML_ELEMENT** ppAny);
    ///Cancels a collection of subscriptions to notifications or solicit/response events.
    ///Params:
    ///    pOperations = Pointer to an array of references to WSD_OPERATION structures that specify the operations to unsubscribe
    ///                  from.
    ///    dwOperationCount = The number of elements in the array in <i>pOperations</i>.
    ///    pAny = Pointer to extensible data to be added to the body of the request.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> The proxy is not subscribed to the notification specified by <i>pOperation</i>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pOperation</i> is
    ///    NULL. </td> </tr> </table>
    ///    
    HRESULT UnsubscribeToMultipleOperations(char* pOperations, uint dwOperationCount, const(WSDXML_ELEMENT)* pAny);
    ///Initializes an asynchronous cancelation request for a subscription to a collection of notifications or
    ///solicit/response events.
    ///Params:
    ///    pOperations = Pointer to an array of references to WSD_OPERATION structures that specify the operations to unsubscribe
    ///                  from.
    ///    dwOperationCount = The number of elements in the array in <i>pOperations</i>.
    ///    pAny = Pointer to extensible data to be added to the body of the request. This parameter is optional.
    ///    pAsyncState = Anonymous data passed to <i>pAsyncCallback</i> when the callback is called. This data is used to associate a
    ///                  client object with the pending operation. This parameter is optional.
    ///    pAsyncCallback = Reference to an IWSDAsyncCallback object that performs the message callback status notifications. This
    ///                     parameter is optional.
    ///    ppResult = Pointer to a pointer to an IWSDAsyncResult interface that will represent the result of the requests upon
    ///               completion.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT BeginUnsubscribeToMultipleOperations(char* pOperations, uint dwOperationCount, 
                                                 const(WSDXML_ELEMENT)* pAny, IUnknown pAsyncState, 
                                                 IWSDAsyncCallback pAsyncCallback, IWSDAsyncResult* ppResult);
    ///Completes an asynchronous cancellation request for a subscription to a collection of notifications or
    ///solicit/response events.
    ///Params:
    ///    pOperations = Pointer to an array of references to WSD_OPERATION structures that specifies the operations from which to
    ///                  unsubscribe.
    ///    dwOperationCount = The number of elements in the array in <i>pOperations</i>.
    ///    pResult = Pointer to an IWSDAsyncResult interface that will represent the result of the requests upon completion.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EndUnsubscribeToMultipleOperations(char* pOperations, uint dwOperationCount, IWSDAsyncResult pResult);
    ///Renews a collection of existing notification subscriptions by submitting a new duration.
    ///Params:
    ///    pOperations = Pointer to an array of references to WSD_OPERATION structures that specify the operation subscriptions to
    ///                  renew.
    ///    dwOperationCount = The number of elements in the array in <i>pOperations</i>.
    ///    pExpires = Pointer to a WSD_EVENTING_EXPIRES structure that specifies requested duration for the subscription.
    ///    pAny = Pointer to extensible data to be added to the body of the request. This parameter is optional.
    ///    ppExpires = Pointer to a pointer to a WSD_EVENTING_EXPIRES structure that specifies the duration of the subscription that
    ///                was just renewed. Upon completion, call WSDFreeLinkedMemory to free the memory. This parameter is optional.
    ///    ppAny = Extensible data that the remote device can add to the subscription response. This allows services to provide
    ///            additional customization of renew requests. When done, call WSDFreeLinkedMemory to free the memory. For
    ///            details, see WSDXML_ELEMENT. This parameter is optional.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RenewMultipleOperations(char* pOperations, uint dwOperationCount, 
                                    const(WSD_EVENTING_EXPIRES)* pExpires, const(WSDXML_ELEMENT)* pAny, 
                                    WSD_EVENTING_EXPIRES** ppExpires, WSDXML_ELEMENT** ppAny);
    ///Initializes an asynchronous operation that renews a collection of existing notification subscriptions by
    ///submitting a new duration.
    ///Params:
    ///    pOperations = Pointer to an array of references to WSD_OPERATION structures that specify the operation subscriptions to
    ///                  renew.
    ///    dwOperationCount = The number of elements in the array in <i>pOperations</i>.
    ///    pExpires = Pointer to a WSD_EVENTING_EXPIRES structure that specifies requested duration for the subscription.
    ///    pAny = Pointer to extensible data to be added to the body of the request. This parameter is optional.
    ///    pAsyncState = Anonymous data passed to <i>pAsyncCallback</i> when the callback is called. This data is used to associate a
    ///                  client object with the pending operation. This parameter is optional.
    ///    pAsyncCallback = Reference to an IWSDAsyncCallback object that performs the message callback status notifications. This
    ///                     parameter is optional.
    ///    ppResult = Pointer to a pointer to an IWSDAsyncResult interface that will represent the result of the requests upon
    ///               completion.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT BeginRenewMultipleOperations(char* pOperations, uint dwOperationCount, 
                                         const(WSD_EVENTING_EXPIRES)* pExpires, const(WSDXML_ELEMENT)* pAny, 
                                         IUnknown pAsyncState, IWSDAsyncCallback pAsyncCallback, 
                                         IWSDAsyncResult* ppResult);
    ///Completes an asynchronous operation that renews a collection of existing notification subscriptions by submitting
    ///a new duration.
    ///Params:
    ///    pOperations = Pointer to an array of references to WSD_OPERATION structures that specify the operation subscriptions to
    ///                  renew.
    ///    dwOperationCount = The number of elements in the array in <i>pOperations</i>.
    ///    pResult = Pointer to an IWSDAsyncResult interface that represents the result of the requests upon completion.
    ///    ppExpires = Pointer to a pointer to a WSD_EVENTING_EXPIRES structure that specfies the duration of the subscription that
    ///                was just renewed. Upon completion, call WSDFreeLinkedMemory to free the memory. This parameter is optional.
    ///    ppAny = Extensible data that the remote device can add to the subscription response. This allows services to provide
    ///            additional customization of event subscriptions. When done, call WSDFreeLinkedMemory to free the memory. For
    ///            details, see WSDXML_ELEMENT. This parameter is optional.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EndRenewMultipleOperations(char* pOperations, uint dwOperationCount, IWSDAsyncResult pResult, 
                                       WSD_EVENTING_EXPIRES** ppExpires, WSDXML_ELEMENT** ppAny);
    ///Retrieves the current status for a collection of event subscriptions.
    ///Params:
    ///    pOperations = Pointer to an array of references to WSD_OPERATION structures that specify the operation subscriptions to get
    ///                  status on.
    ///    dwOperationCount = The number of elements in the array in <i>pOperations</i>.
    ///    pAny = Pointer to extensible data to be added to the body of the request. This parameter is optional.
    ///    ppExpires = Pointer to a pointer to a WSD_EVENTING_EXPIRES structure that specfies the duration of the subscription. Upon
    ///                completion, call WSDFreeLinkedMemory to free the memory. This parameter is optional.
    ///    ppAny = Extensible data that the remote device can add to the subscription response. This allows services to provide
    ///            additional customization of getstatus requests. When done, call WSDFreeLinkedMemory to free the memory. For
    ///            details, see WSDXML_ELEMENT. This parameter is optional.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetStatusForMultipleOperations(char* pOperations, uint dwOperationCount, const(WSDXML_ELEMENT)* pAny, 
                                           WSD_EVENTING_EXPIRES** ppExpires, WSDXML_ELEMENT** ppAny);
    ///Begins an asynchronous operation that retrieves the current status for a collection of event subscriptions.
    ///Params:
    ///    pOperations = Pointer to an array of references to WSD_OPERATION structures that specify the operation subscriptions to get
    ///                  status on.
    ///    dwOperationCount = The number of elements in the array in <i>pOperations</i>.
    ///    pAny = Pointer to extensible data to be added to the body of the request. This parameter is optional.
    ///    pAsyncState = Anonymous data passed to <i>pAsyncCallback</i> when the callback is called. This data is used to associate a
    ///                  client object with the pending operation. This parameter is optional.
    ///    pAsyncCallback = Reference to an IWSDAsyncCallback object that performs the message callback status notifications. This
    ///                     parameter is optional.
    ///    ppResult = Pointer to a pointer to an IWSDAsyncResult interface that will represent the result of the requests upon
    ///               completion.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT BeginGetStatusForMultipleOperations(char* pOperations, uint dwOperationCount, 
                                                const(WSDXML_ELEMENT)* pAny, IUnknown pAsyncState, 
                                                IWSDAsyncCallback pAsyncCallback, IWSDAsyncResult* ppResult);
    ///Completes an asynchronous operation that retrieves the current status for a collection of event subscriptions.
    ///Params:
    ///    pOperations = Pointer to an array of references to WSD_OPERATION structures that specify the operation subscriptions to get
    ///                  status on.
    ///    dwOperationCount = The number of elements in the array in <i>pOperations</i>.
    ///    pResult = Pointer to an IWSDAsyncResult interface that represents the result of the requests upon completion.
    ///    ppExpires = Pointer to a pointer to a WSD_EVENTING_EXPIRES structure that specfies the duration of the subscription. Upon
    ///                completion, call WSDFreeLinkedMemory to free the memory. This parameter is optional.
    ///    ppAny = Extensible data that the remote device can add to the subscription response. This allows services to provide
    ///            additional customization of getstatu requests. When done, call WSDFreeLinkedMemory to free the memory. For
    ///            details, see WSDXML_ELEMENT. This parameter is optional.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EndGetStatusForMultipleOperations(char* pOperations, uint dwOperationCount, IWSDAsyncResult pResult, 
                                              WSD_EVENTING_EXPIRES** ppExpires, WSDXML_ELEMENT** ppAny);
}

///Represents a remote Devices Profile for Web Services (DPWS) device for client applications and middleware. To get
///this interface, you can call WSDCreateDeviceProxy.
@GUID("EEE0C031-C578-4C0E-9A3B-973C35F409DB")
interface IWSDDeviceProxy : IUnknown
{
    ///Initializes the device proxy, optionally sharing a session with a previously initialized sponsoring device proxy.
    ///Params:
    ///    pszDeviceId = The logical address (ID) of the device.
    ///    pDeviceAddress = Reference to an IWSDAddress object that contains the device configuration data.
    ///    pszLocalId = The logical address of the client. The logical address is of the form, urn:uuid:{guid}. Used when the server
    ///                 needs to initiate a connection to the client.
    ///    pContext = Reference to an IWSDXMLContext object that defines custom message types or namespaces. If <b>NULL</b>, a
    ///               default context representing the built-in message types and namespaces is used.
    ///    pSponsor = Reference to an IWSDDeviceProxy object that is an optional device with which to share a session and lower
    ///               layers.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> <i>pszDeviceId</i> is <b>NULL</b>, <i>pszLocalId</i> is <b>NULL</b>, or the length in
    ///    characters of either identifier string exceeds WSD_MAX_TEXT_LENGTH (8192). </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the
    ///    operation. </td> </tr> </table>
    ///    
    HRESULT Init(const(wchar)* pszDeviceId, IWSDAddress pDeviceAddress, const(wchar)* pszLocalId, 
                 IWSDXMLContext pContext, IWSDDeviceProxy pSponsor);
    ///Sends an asynchronous request for metadata.
    ///Params:
    ///    ppResult = Returns an IWSDAsyncResult object that can be used to determine whether an operation has completed.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>ppResult</i> is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The method could
    ///    not be completed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT BeginGetMetadata(IWSDAsyncResult* ppResult);
    ///Ends an asynchronous request for metadata and returns the metadata related to a device.
    ///Params:
    ///    pResult = The IWSDAsyncResult object returned by BeginGetMetadata.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> <i>pResult</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The method could not be completed. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method failed. The metadata was not
    ///    returned, was invalid, or a fault was generated. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the operation.
    ///    </td> </tr> </table>
    ///    
    HRESULT EndGetMetadata(IWSDAsyncResult pResult);
    ///Retrieves class-specific metadata for the device describing the features of the device and the services it hosts.
    ///Params:
    ///    ppHostMetadata = Reference to a WSD_HOST_METADATA structure that specifies metadata. Do not release this object.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>ppHostMetadata</i> is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetHostMetadata(WSD_HOST_METADATA** ppHostMetadata);
    ///Retrieves model-specific metadata for the device.
    ///Params:
    ///    ppManufacturerMetadata = Reference to a WSD_THIS_MODEL_METADATA structure that specifies manufacturer and model-specific metadata. Do
    ///                             not release this object.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>ppManufacturerMetadata</i> is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetThisModelMetadata(WSD_THIS_MODEL_METADATA** ppManufacturerMetadata);
    ///Retrieves device-specific metadata for this device.
    ///Params:
    ///    ppThisDeviceMetadata = Reference to a WSD_THIS_DEVICE_METADATA structure that specifies the device-specific metadata of this device.
    ///                           Do not release this object.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>ppThisDeviceMetadata</i> is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetThisDeviceMetadata(WSD_THIS_DEVICE_METADATA** ppThisDeviceMetadata);
    ///Retrieves all metadata for this device.
    ///Params:
    ///    ppMetadata = Reference to a WSD_METADATA_SECTION_LIST structure that specifies all metadata related to a device. Do not
    ///                 release this object.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>ppMetadata</i> is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetAllMetadata(WSD_METADATA_SECTION_LIST** ppMetadata);
    ///Retrieves a generic IWSDServiceProxy service proxy by service ID. Service IDs can be obtained by examining the
    ///service host metadata.
    ///Params:
    ///    pszServiceId = The service ID.
    ///    ppServiceProxy = Pointer to an IWSDServiceProxy object for the specified service proxy.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
    ///    <td width="60%"> <i>ppServiceProxy</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The length in characters of <i>pszServiceId</i>
    ///    exceeds WSD_MAX_TEXT_LENGTH (8192), or there is no metadata associated with the service specified by
    ///    <i>pszServiceId</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> There is no endpoint associated with the service proxy.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetServiceProxyById(const(wchar)* pszServiceId, IWSDServiceProxy* ppServiceProxy);
    ///Retrieves a generic IWSDServiceProxy proxy for a service exposed by the device by port type name.
    ///Params:
    ///    pType = Reference to a WSDXML_NAME structure that specifies the port type name.
    ///    ppServiceProxy = Pointer to the IWSDServiceProxy object associated with the specified service.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
    ///    <td width="60%"> <i>pType</i> or <i>ppServiceProxy</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> There is no metadata associated with the service
    ///    specified by <i>pType</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td>
    ///    <td width="60%"> Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> There is no endpoint associated with the service proxy.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetServiceProxyByType(const(WSDXML_NAME)* pType, IWSDServiceProxy* ppServiceProxy);
    ///Retrieves the endpoint proxy for the device.
    ///Params:
    ///    ppProxy = An IWSDEndpointProxy interface that implements a device services messaging proxy for this device.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>ppProxy</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetEndpointProxy(IWSDEndpointProxy* ppProxy);
}

///Represents an asynchronous operation.
@GUID("11A9852A-8DD8-423E-B537-9356DB4FBFB8")
interface IWSDAsyncResult : IUnknown
{
    ///Specifies a callback interface to call when the asynchronous operation has completed.
    ///Params:
    ///    pCallback = Pointer to a IWSDAsyncCallback object that contains the callback implemented by the user.
    ///    pAsyncState = User-defined state information to pass to the callback.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pCallback</i> is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetCallback(IWSDAsyncCallback pCallback, IUnknown pAsyncState);
    ///Specifies a wait handle to set when the operation completes.
    ///Params:
    ///    hWaitHandle = The wait handle to set.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> <i>hWaitHandle</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT SetWaitHandle(HANDLE hWaitHandle);
    ///Indicates whether the operation has completed.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation completed. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The operation has not completed. </td> </tr>
    ///    </table>
    ///    
    HRESULT HasCompleted();
    ///Gets the state of the asynchronous operation.
    ///Params:
    ///    ppAsyncState = User-defined state information.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>ppAsyncState</i> is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetAsyncState(IUnknown* ppAsyncState);
    ///Aborts the asynchronous operation.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> </table>
    ///    
    HRESULT Abort();
    ///Retrieves a WSD_EVENT structure that contains the result of the event.
    ///Params:
    ///    pEvent = Reference to a WSD_EVENT structure that provides data about the event.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pEvent</i> is <b>NULL</b>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Event is not yet
    ///    available or the asynchronous operation has not completed. </td> </tr> </table>
    ///    
    HRESULT GetEvent(WSD_EVENT* pEvent);
    ///Retrieves the endpoint proxy for the asynchronous operation.
    ///Params:
    ///    ppEndpoint = An IWSDEndpointProxy interface that implements an endpoint proxy.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>ppEndpoint</i> is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetEndpointProxy(IWSDEndpointProxy* ppEndpoint);
}

///Handles callbacks for the completion of an asynchronous operation.
@GUID("A63E109D-CE72-49E2-BA98-E845F5EE1666")
interface IWSDAsyncCallback : IUnknown
{
    ///Indicates that the asynchronous operation has completed.
    ///Params:
    ///    pAsyncResult = Pointer to an IWSDAsyncResult object that contains the user-defined state information passed to
    ///                   IWSDAsyncResult::SetCallback.
    ///    pAsyncState = The state of the asynchronous operation.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> </table>
    ///    
    HRESULT AsyncOperationComplete(IWSDAsyncResult pAsyncResult, IUnknown pAsyncState);
}

///Implement this interface to receive notification when status changes occur in event subscriptions.
@GUID("49B17F52-637A-407A-AE99-FBE82A4D38C0")
interface IWSDEventingStatus : IUnknown
{
    ///Called when the subscription for the specified event action was successfully renewed.
    ///Params:
    ///    pszSubscriptionAction = URI of the event action.
    void SubscriptionRenewed(const(wchar)* pszSubscriptionAction);
    ///Called when the subscription for the specified event action could not be renewed.
    ///Params:
    ///    pszSubscriptionAction = URI of the event action.
    ///    hr = HRESULT indicating the nature of the error.
    void SubscriptionRenewalFailed(const(wchar)* pszSubscriptionAction, HRESULT hr);
    ///Called when the device terminated the subscription.
    ///Params:
    ///    pszSubscriptionAction = URI of the event action.
    void SubscriptionEnded(const(wchar)* pszSubscriptionAction);
}

///This interface is used to discover services on the network advertised by WS-Discovery. To get this interface, you can
///call WSDCreateDiscoveryProvider.
@GUID("8FFC8E55-F0EB-480F-88B7-B435DD281D45")
interface IWSDiscoveryProvider : IUnknown
{
    ///Specifies the IP address family (IPv4, IPv6, or both) to search when discovering WSD devices.
    ///Params:
    ///    dwAddressFamily = The address family to search when discovering devices. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///                      <tr> <td width="40%"><a id="WSDAPI_ADDRESSFAMILY_IPV4"></a><a id="wsdapi_addressfamily_ipv4"></a><dl>
    ///                      <dt><b>WSDAPI_ADDRESSFAMILY_IPV4</b></dt> </dl> </td> <td width="60%"> Search over IPv4 addresses. </td>
    ///                      </tr> <tr> <td width="40%"><a id="WSDAPI_ADDRESSFAMILY_IPV6"></a><a id="wsdapi_addressfamily_ipv6"></a><dl>
    ///                      <dt><b>WSDAPI_ADDRESSFAMILY_IPV6</b></dt> </dl> </td> <td width="60%"> Search over IPv6 addresses. </td>
    ///                      </tr> <tr> <td width="40%"><a id="WSDAPI_ADDRESSFAMILY_IPV4___WSDAPI_ADDRESSFAMILY_IPV6"></a><a
    ///                      id="wsdapi_addressfamily_ipv4___wsdapi_addressfamily_ipv6"></a><dl> <dt><b>WSDAPI_ADDRESSFAMILY_IPV4 |
    ///                      WSDAPI_ADDRESSFAMILY_IPV6</b></dt> </dl> </td> <td width="60%"> Search over IPv4 and IPv6 addresses. </td>
    ///                      </tr> </table>
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>dwAddressFamily</i> has a
    ///    value other than WSDAPI_ADDRESSFAMILY_IPV4, WSDAPI_ADDRESSFAMILY_IPV6, or WSDAPI_ADDRESSFAMILY_IPV4 |
    ///    WSDAPI_ADDRESSFAMILY_IPV6. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>STG_E_INVALIDFUNCTION</b></dt> </dl>
    ///    </td> <td width="60%"> The address family has already been set for this publisher. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(WSAESOCKTNOSUPPORT)</b></dt> </dl> </td> <td width="60%"> The
    ///    system does not support the address family specified by <i>dwAddressFamily</i>. </td> </tr> </table>
    ///    
    HRESULT SetAddressFamily(uint dwAddressFamily);
    ///Attaches a callback interface to the discovery provider.
    ///Params:
    ///    pSink = Interface to receive callback notifications. Search results as well as the Hello and Bye messages are
    ///            communicated to this interface via the callbacks.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
    ///    <td width="60%"> <i>pSink</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ABORT</b></dt>
    ///    </dl> </td> <td width="60%"> A callback interface has already been attached to the provider. </td> </tr>
    ///    </table>
    ///    
    HRESULT Attach(IWSDiscoveryProviderNotify pSink);
    ///Detaches a callback interface from the discovery provider.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td
    ///    width="60%"> A callback interface has not been attached. You must call Attach before calling this method.
    ///    </td> </tr> </table>
    ///    
    HRESULT Detach();
    ///Initializes a search for WS-Discovery hosts by device identifier.
    ///Params:
    ///    pszId = Device identifier of the desired discovery provider.
    ///    pszTag = Optional identifier tag for this search. May be <b>NULL</b>.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> <i>pszId</i> is <b>NULL</b>, the length in characters of <i>pszId</i> exceeds
    ///    WSD_MAX_TEXT_LENGTH (8192), or the length in characters of <i>pszTag</i> exceeds WSD_MAX_TEXT_LENGTH (8192).
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> A callback
    ///    interface has not been attached. You must call Attach before calling this method. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory exists to
    ///    perform the operation. </td> </tr> </table>
    ///    
    HRESULT SearchById(const(wchar)* pszId, const(wchar)* pszTag);
    ///Initializes a search for WS-Discovery hosts by device address.
    ///Params:
    ///    pszAddress = The HTTP transport address of the device.
    ///    pszTag = Optional identifier tag for this search. May be <b>NULL</b>.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> <i>pszAddress</i> is <b>NULL</b>, the length in characters of <i>pszAddress</i>
    ///    exceeds WSD_MAX_TEXT_LENGTH (8192), or the length in characters of <i>pszTag</i> exceeds WSD_MAX_TEXT_LENGTH
    ///    (8192). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> A
    ///    callback interface has not been attached. You must call Attach before calling this method. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory exists to
    ///    perform the operation. </td> </tr> </table>
    ///    
    HRESULT SearchByAddress(const(wchar)* pszAddress, const(wchar)* pszTag);
    ///Initializes a search for WS-Discovery hosts by device type.
    ///Params:
    ///    pTypesList = Pointer to a WSD_NAME_LIST structure that represents the list of discovery provider types to search for. May
    ///                 be <b>NULL</b>.
    ///    pScopesList = Pointer to a WSD_URI_LIST structure that represents the list of discovery provider scopes to search for. May
    ///                  be <b>NULL</b>.
    ///    pszMatchBy = Matching rule used for scopes. May be <b>NULL</b>.
    ///    pszTag = Optional identifier tag for this search. May be <b>NULL</b>.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> The length in characters of <i>pszMatchBy</i> exceeds WSD_MAX_TEXT_LENGTH (8192) or
    ///    the length in characters of <i>pszTag</i> exceeds WSD_MAX_TEXT_LENGTH (8192). </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> A callback interface has not been
    ///    attached. You must call Attach before calling this method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory exists to perform the operation.
    ///    </td> </tr> </table>
    ///    
    HRESULT SearchByType(const(WSD_NAME_LIST)* pTypesList, const(WSD_URI_LIST)* pScopesList, 
                         const(wchar)* pszMatchBy, const(wchar)* pszTag);
    ///Gets the XML context associated with this provider.
    ///Params:
    ///    ppContext = Pointer to a pointer variable containing the XML context.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> <i>ppContext</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The discovery provider has not been created. Call
    ///    WSDCreateDiscoveryProvider to create a provider. </td> </tr> </table>
    ///    
    HRESULT GetXMLContext(IWSDXMLContext* ppContext);
}

///Is implemented by the client program to receive callback notifications from IWSDiscoveryProvider.
@GUID("73EE3CED-B6E6-4329-A546-3E8AD46563D2")
interface IWSDiscoveryProviderNotify : IUnknown
{
    ///Provides information on either a newly announced discovery host (from a Hello message), or a match to a user
    ///initiated query.
    ///Params:
    ///    pService = A pointer to an IWSDiscoveredService interface that represents a remote discovery host.
    ///Returns:
    ///    The return value is not meaningful. An implementer should return S_OK.
    ///    
    HRESULT Add(IWSDiscoveredService pService);
    ///Provides information on a recently departed discovery host (from a Bye message).
    ///Params:
    ///    pService = A pointer to an IWSDiscoveredService interface that represents a remote discovery host.
    ///Returns:
    ///    The return value is not meaningful. An implementer should return S_OK.
    ///    
    HRESULT Remove(IWSDiscoveredService pService);
    ///Is called to indicate a user initiated search has failed.
    ///Params:
    ///    hr = Cause of the search failure which initiated this callback. A value of <b>S_FALSE</b> indicates the search
    ///         completed without issuing any Add callbacks.
    ///    pszTag = Optional identifier tag for this search. May be <b>NULL</b>.
    ///Returns:
    ///    The return value is not meaningful. An implementer should return <b>S_OK</b>.
    ///    
    HRESULT SearchFailed(HRESULT hr, const(wchar)* pszTag);
    ///Called to indicate a user initiated search has successfully completed and no more matches for the search will be
    ///accepted.
    ///Params:
    ///    pszTag = Search tag passed to the IWSDiscoveryProvider search method.
    ///Returns:
    ///    The return value is not meaningful. An implementer should return S_OK.
    ///    
    HRESULT SearchComplete(const(wchar)* pszTag);
}

///This interface represents a remotely discovered host. WSDAPI returns this interface when calling
///IWSDiscoveryProviderNotify::Add and IWSDiscoveryProviderNotify::Remove. The interface is populated when a match for
///an outstanding query issued using IWSDiscoveryProvider::SearchByType, IWSDiscoveryProvider::SearchByAddress, or
///IWSDiscoveryProvider::SearchById is received, or if a device on the network announces itself with a Hello message.
@GUID("4BAD8A3B-B374-4420-9632-AAC945B374AA")
interface IWSDiscoveredService : IUnknown
{
    ///Retrieves a WS-Addressing address referencing an endpoint of the remote device.
    ///Params:
    ///    ppEndpointReference = A WS-Addressing address referencing an endpoint of the remote device. For details, see
    ///                          WSD_ENDPOINT_REFERENCE. Do not deallocate the output structure.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>ppEndPointReference</i> is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetEndpointReference(WSD_ENDPOINT_REFERENCE** ppEndpointReference);
    ///Retrieves a list of WS-Discovery Types.
    ///Params:
    ///    ppTypesList = List of WS-Discovery Types provided in the Hello, ProbeMatch, or ResolveMatch message sent by the remote
    ///                  device. For details, see WSD_NAME_LIST. Do not deallocate the output structure.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>ppTypesList</i> is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetTypes(WSD_NAME_LIST** ppTypesList);
    ///Retrieves a list of WS-Discovery Scopes.
    ///Params:
    ///    ppScopesList = List of WS-Discovery Scopes provided in the Hello, ProbeMatch, or ResolveMatch message sent by the remote
    ///                   device. For details, see WSD_URI_LIST. Do not deallocate the output structure.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>ppScopesList</i> is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetScopes(WSD_URI_LIST** ppScopesList);
    ///Retrieves a list of WS-Discovery XAddrs.
    ///Params:
    ///    ppXAddrsList = List of WS-Discovery XAddrs provided in the Hello, ProbeMatch, or ResolveMatch message sent by the remote
    ///                   device. For details, see WSD_URI_LIST. Do not deallocate the output structure.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>ppXAddrsList</i> is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetXAddrs(WSD_URI_LIST** ppXAddrsList);
    ///Retrieves the metadata version of this message.
    ///Params:
    ///    pullMetadataVersion = Metadata version of this message.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pullMetadataVersion</i> is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetMetadataVersion(ulong* pullMetadataVersion);
    ///Retrieves custom or extensible data provided in the header or body of the SOAP message.
    ///Params:
    ///    ppHeaderAny = Custom data added to the header portion of the SOAP message. For details, see WSDXML_ELEMENT. Do not
    ///                  deallocate the output structure.
    ///    ppBodyAny = Custom data added to the body portion of the SOAP message. For details, see WSDXML_ELEMENT. Do not deallocate
    ///                the output structure.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> </table>
    ///    
    HRESULT GetExtendedDiscoXML(WSDXML_ELEMENT** ppHeaderAny, WSDXML_ELEMENT** ppBodyAny);
    ///Retrieves the search tag corresponding to this discovered service object.
    ///Params:
    ///    ppszTag = Search tag passed to the IWSDiscoveryProvider search method that this IWSDiscoveredService object corresponds
    ///              to. If the <b>IWSDiscoveredService</b> is the result of a Hello message, the tag is <b>NULL</b>. Do not
    ///              deallocate the output string.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>ppszTag</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetProbeResolveTag(ushort** ppszTag);
    ///Retrieves the string representation of the remote transport (IP) address.
    ///Params:
    ///    ppszRemoteTransportAddress = String representation of the remote transport (IP) address. Is <b>NULL</b> if not available. Do not
    ///                                 deallocate the output string.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>ppszRemoteTransportAddress</i> is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetRemoteTransportAddress(ushort** ppszRemoteTransportAddress);
    ///Retrieves the string representation of the local transport (IP) address.
    ///Params:
    ///    ppszLocalTransportAddress = String representation of the local transport (IP) address. Is <b>NULL</b> if not available. Do not deallocate
    ///                                the output string.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>ppszLocalTransportAddress</i> is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetLocalTransportAddress(ushort** ppszLocalTransportAddress);
    ///Retrieves the GUID of the local network interface over which the message was received.
    ///Params:
    ///    pGuid = GUID of the local network interface over which the message was received. Structure will be cleared if the
    ///            local interface GUID is not available.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pGuid</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetLocalInterfaceGUID(GUID* pGuid);
    ///Retrieves the instance identifier of this message.
    ///Params:
    ///    pullInstanceId = A pointer to the instance identifier of this message.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pullInstanceId</i> is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetInstanceId(ulong* pullInstanceId);
}

///Provides methods for announcing hosts and managing incoming queries to hosts. To get this interface, call
///WSDCreateDiscoveryPublisher.
@GUID("AE01E1A8-3FF9-4148-8116-057CC616FE13")
interface IWSDiscoveryPublisher : IUnknown
{
    ///Specifies the IP address family (IPv4, IPv6, or both) over which the host will be published.
    ///Params:
    ///    dwAddressFamily = The address family over which the host will be published. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///                      <tr> <td width="40%"><a id="WSDAPI_ADDRESSFAMILY_IPV4"></a><a id="wsdapi_addressfamily_ipv4"></a><dl>
    ///                      <dt><b>WSDAPI_ADDRESSFAMILY_IPV4</b></dt> </dl> </td> <td width="60%"> Publish the host over IPv4 addresses.
    ///                      </td> </tr> <tr> <td width="40%"><a id="WSDAPI_ADDRESSFAMILY_IPV6"></a><a
    ///                      id="wsdapi_addressfamily_ipv6"></a><dl> <dt><b>WSDAPI_ADDRESSFAMILY_IPV6</b></dt> </dl> </td> <td
    ///                      width="60%"> Publish the host over IPv6 addresses. </td> </tr> <tr> <td width="40%"><a
    ///                      id="WSDAPI_ADDRESSFAMILY_IPV4___WSDAPI_ADDRESSFAMILY_IPV6"></a><a
    ///                      id="wsdapi_addressfamily_ipv4___wsdapi_addressfamily_ipv6"></a><dl> <dt><b>WSDAPI_ADDRESSFAMILY_IPV4 |
    ///                      WSDAPI_ADDRESSFAMILY_IPV6</b></dt> </dl> </td> <td width="60%"> Publish the host over IPv4 and IPv6
    ///                      addresses. </td> </tr> </table>
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> <i>dwAddressFamily</i> has a value other than WSDAPI_ADDRESSFAMILY_IPV4,
    ///    WSDAPI_ADDRESSFAMILY_IPV6, or WSDAPI_ADDRESSFAMILY_IPV4 | WSDAPI_ADDRESSFAMILY_IPV6. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>STG_E_INVALIDFUNCTION</b></dt> </dl> </td> <td width="60%"> The address family has
    ///    already been set for this publisher. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(WSAESOCKTNOSUPPORT)</b></dt> </dl> </td> <td width="60%"> The system does not
    ///    support the address family specified by <i>dwAddressFamily</i>. </td> </tr> </table>
    ///    
    HRESULT SetAddressFamily(uint dwAddressFamily);
    ///Attaches a callback notification sink to the discovery publisher.
    ///Params:
    ///    pSink = Pointer to an IWSDiscoveryPublisherNotify object that represents the initialized interface to receive
    ///            callback notifications. This parameter cannot be <b>NULL</b>.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> <i>pSink</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the operation.
    ///    </td> </tr> </table>
    ///    
    HRESULT RegisterNotificationSink(IWSDiscoveryPublisherNotify pSink);
    ///Detaches a callback notification sink from the discovery publisher.
    ///Params:
    ///    pSink = Pointer to the IWSDiscoveryPublisherNotify interface that will stop receiving callback notifications.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> <i>pSink</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT UnRegisterNotificationSink(IWSDiscoveryPublisherNotify pSink);
    ///Announces the presence of a network host by sending a Hello message.
    ///Params:
    ///    pszId = The logical or physical address of the device, which is used as the device endpoint address. A logical
    ///            address is of the form <code>urn:uuid:{guid}</code>. A physical address can be a URI prefixed by http or
    ///            https, or simply a URI prefixed by <code>uri</code>. Whenever possible, use a logical address.
    ///    ullMetadataVersion = Current metadata version. <div class="alert"><b>Note</b> For compatibility with the WS-Discovery
    ///                         specification, this value must be less than or equal to UINT_MAX (4294967295).</div> <div> </div>
    ///    ullInstanceId = Identifier for the current instance of the device being published. This identifier must be incremented
    ///                    whenever the service is restarted. For more information about instance identifiers, see Appendix I of the
    ///                    WS-Discovery specification. <div class="alert"><b>Note</b> For compatibility with the WS-Discovery
    ///                    specification, this value must be less than or equal to UINT_MAX (4294967295).</div> <div> </div>
    ///    ullMessageNumber = Counter within the scope of the instance identifier for the current message. The message number must be
    ///                       incremented for each message. <div class="alert"><b>Note</b> For compatibility with the WS-Discovery
    ///                       specification, this value must be less than or equal to UINT_MAX (4294967295).</div> <div> </div>
    ///    pszSessionId = Unique identifier within the scope of the instance identifier for the current session. This parameter
    ///                   corresponds to the sequence identifier in the AppSequence block in the Probe message. For more information
    ///                   about sequence identifiers, see Appendix I of the WS-Discovery specification. This parameter may be
    ///                   <b>NULL</b>.
    ///    pTypesList = Pointer to a WSD_NAME_LIST structure that represents the list of types supported by the publishing host. May
    ///                 be <b>NULL</b>.
    ///    pScopesList = Pointer to a WSD_URI_LIST structure that represents the list of matching scopes supported by the publishing
    ///                  host. The list contains hash values in string form. May be <b>NULL</b>.
    ///    pXAddrsList = Pointer to a WSD_URI_LIST structure that represents the list of transport addresses supported by the
    ///                  publishing host. Each transport address string contains an address and port number which can be used for
    ///                  connection by a remote host. May be <b>NULL</b>.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One or more of the following conditions is true: <ul> <li><i>pszId</i> is
    ///    <b>NULL</b>.</li> <li>The length in characters of <i>pszId</i> exceeds WSD_MAX_TEXT_LENGTH (8192). </li>
    ///    <li>The length in characters of <i>pszSessionId</i> exceeds WSD_MAX_TEXT_LENGTH (8192). </li> </ul> </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NO_CALLBACK_ACTIVE)</b></dt> </dl> </td> <td
    ///    width="60%"> There is no registered notification sink. To attach a sink, call RegisterNotificationSink. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The publisher has not
    ///    been started. Attaching a notification sink starts the publisher. To attach a sink, call
    ///    RegisterNotificationSink. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td>
    ///    <td width="60%"> Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT Publish(const(wchar)* pszId, ulong ullMetadataVersion, ulong ullInstanceId, ulong ullMessageNumber, 
                    const(wchar)* pszSessionId, const(WSD_NAME_LIST)* pTypesList, const(WSD_URI_LIST)* pScopesList, 
                    const(WSD_URI_LIST)* pXAddrsList);
    ///Announces the departure of a network host by sending a Bye message.
    ///Params:
    ///    pszId = The logical or physical address of the device, which is used as the device endpoint address. A logical
    ///            address is of the form <code>urn:uuid:{guid}</code>. A physical address can be a URI prefixed by http or
    ///            https, or simply a URI prefixed by <code>uri</code>. Whenever possible, use a logical address.
    ///    ullInstanceId = Identifier for the current instance of the device being published. This identifier must be incremented
    ///                    whenever the service is restarted. For more information about instance identifiers, see Appendix I of the
    ///                    WS-Discovery specification. <div class="alert"><b>Note</b> For compatibility with the WS-Discovery
    ///                    specification, this value must be less than or equal to UINT_MAX (4294967295).</div> <div> </div>
    ///    ullMessageNumber = Counter within the scope of the instance identifier for the current message. The message number must be
    ///                       incremented for each message. <div class="alert"><b>Note</b> For compatibility with the WS-Discovery
    ///                       specification, this value must be less than or equal to UINT_MAX (4294967295).</div> <div> </div>
    ///    pszSessionId = Unique identifier within the scope of the instance identifier for the current session. This parameter
    ///                   corresponds to the sequence identifier in the AppSequence block in the Probe message. For more information
    ///                   about sequence identifiers, see Appendix I of the WS-Discovery specification. This parameter may be
    ///                   <b>NULL</b>.
    ///    pAny = Pointer to a WSDXML_ELEMENT structure that contains an XML element to be inserted in the "ANY" section of the
    ///           message body.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One or more of the following conditions is true: <ul> <li><i>pszId</i> is
    ///    <b>NULL</b>.</li> <li>The length of <i>pszId</i> exceeds WSD_MAX_TEXT_LENGTH (8192). </li> <li>The length of
    ///    <i>pszSessionId</i> exceeds WSD_MAX_TEXT_LENGTH (8192). </li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The publisher has not been started. Attaching a
    ///    notification sink starts the publisher. To attach a sink, call RegisterNotificationSink. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete
    ///    the operation. </td> </tr> </table>
    ///    
    HRESULT UnPublish(const(wchar)* pszId, ulong ullInstanceId, ulong ullMessageNumber, const(wchar)* pszSessionId, 
                      const(WSDXML_ELEMENT)* pAny);
    ///Determines whether a Probe message matches the specified host and sends a WS-Discovery ProbeMatches message if
    ///the match is made.
    ///Params:
    ///    pProbeMessage = Pointer to a WSD_SOAP_MESSAGE structure that represents the Probe message passed to the notification sink's
    ///                    ProbeHandler.
    ///    pMessageParameters = Pointer to an IWSDMessageParameters object that represents the transmission parameters passed in to the
    ///                         notification sink's ProbeHandler.
    ///    pszId = The logical or physical address of the device, which is used as the device endpoint address. A logical
    ///            address is of the form <code>urn:uuid:{guid}</code>. A physical address can be a URI prefixed by http or
    ///            https, or simply a URI prefixed by <code>uri</code>. Whenever possible, use a logical address.
    ///    ullMetadataVersion = The current metadata version. <div class="alert"><b>Note</b> For compatibility with the WS-Discovery
    ///                         specification, this value must be less than or equal to UINT_MAX (4294967295).</div> <div> </div>
    ///    ullInstanceId = Identifier for the current instance of the device being published. This identifier must be incremented
    ///                    whenever the service is restarted. For more information about instance identifiers, see Appendix I of the
    ///                    WS-Discovery specification. <div class="alert"><b>Note</b> For compatibility with the WS-Discovery
    ///                    specification, this value must be less than or equal to UINT_MAX (4294967295).</div> <div> </div>
    ///    ullMessageNumber = Counter within the scope of the instance identifier for the current message. The message number must be
    ///                       incremented for each message. <div class="alert"><b>Note</b> For compatibility with the WS-Discovery
    ///                       specification, this value must be less than or equal to UINT_MAX (4294967295).</div> <div> </div>
    ///    pszSessionId = Unique identifier within the scope of the instance identifier for the current session. This parameter
    ///                   corresponds to the sequence identifier in the AppSequence block in the Probe message. For more information
    ///                   about sequence identifiers, see Appendix I of the WS-Discovery specification. This parameter may be
    ///                   <b>NULL</b>.
    ///    pTypesList = Pointer to a WSD_NAME_LIST structure that represents the list of types supported by the publishing host. May
    ///                 be <b>NULL</b>. If <i>pTypesList</i> is specified, <b>MatchProbe</b> will use WS-Discovery matching logic to
    ///                 verify that the types in the list match the types specified in <i>pProbeMessage</i>.
    ///    pScopesList = Pointer to a WSD_URI_LIST structure that represents the list of matching scopes supported by the publishing
    ///                  host. The list contains hash values in string form. May be <b>NULL</b>. If <i>pScopesList</i> is specified,
    ///                  <b>MatchProbe</b> will use WS-Discovery matching logic to verify that the scopes in the list match the scopes
    ///                  specified in <i>pProbeMessage</i>.
    ///    pXAddrsList = Pointer to a WSD_URI_LIST structure that represents the list of transport addresses supported by the
    ///                  publishing host. Each transport address string contains an address and port number which can be used for
    ///                  connection by a remote host. May be <b>NULL</b>.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One or more of the following conditions is true: <ul> <li><i>pszId</i> is
    ///    <b>NULL</b>.</li> <li>The length in characters of <i>pszId</i> exceeds WSD_MAX_TEXT_LENGTH (8192). </li>
    ///    <li>The length in characters of <i>pszSessionId</i> exceeds WSD_MAX_TEXT_LENGTH (8192). </li>
    ///    <li><i>pProbeMessage</i> is <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The publisher has not been started. Attaching a
    ///    notification sink starts the publisher. To attach a sink, call RegisterNotificationSink. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete
    ///    the operation. </td> </tr> </table>
    ///    
    HRESULT MatchProbe(const(WSD_SOAP_MESSAGE)* pProbeMessage, IWSDMessageParameters pMessageParameters, 
                       const(wchar)* pszId, ulong ullMetadataVersion, ulong ullInstanceId, ulong ullMessageNumber, 
                       const(wchar)* pszSessionId, const(WSD_NAME_LIST)* pTypesList, 
                       const(WSD_URI_LIST)* pScopesList, const(WSD_URI_LIST)* pXAddrsList);
    ///Determines whether a Resolve message matches the specified host and sends a WS-Discovery ResolveMatches message
    ///if the match is made.
    ///Params:
    ///    pResolveMessage = Pointer to a WSD_SOAP_MESSAGE structure that represents the Resolve message passed in to the notification
    ///                      sink's ResolveHandler.
    ///    pMessageParameters = Pointer to an IWSDMessageParameters object that represents the transmission parameters passed in to the
    ///                         notification sink's ResolveHandler.
    ///    pszId = The logical or physical address of the device, which is used as the device endpoint address. A logical
    ///            address is of the form <code>urn:uuid:{guid}</code>. A physical address can be a URI prefixed by http or
    ///            https, or simply a URI prefixed by <code>uri</code>. Whenever possible, use a logical address.
    ///    ullMetadataVersion = Current metadata version. <div class="alert"><b>Note</b> For compatibility with the WS-Discovery
    ///                         specification, this value must be less than or equal to UINT_MAX (4294967295).</div> <div> </div>
    ///    ullInstanceId = Identifier for the current instance of the device being published. This identifier must be incremented
    ///                    whenever the service is restarted. For more information about instance identifiers, see Appendix I of the
    ///                    WS-Discovery specification. <div class="alert"><b>Note</b> For compatibility with the WS-Discovery
    ///                    specification, this value must be less than or equal to UINT_MAX (4294967295).</div> <div> </div>
    ///    ullMessageNumber = Counter within the scope of the instance identifier for the current message. The message number must be
    ///                       incremented for each message. <div class="alert"><b>Note</b> For compatibility with the WS-Discovery
    ///                       specification, this value must be less than or equal to UINT_MAX (4294967295).</div> <div> </div>
    ///    pszSessionId = Unique identifier within the scope of the instance identifier for the current session. This parameter
    ///                   corresponds to the sequence identifier in the AppSequence block in the Probe message. For more information
    ///                   about sequence identifiers, see Appendix I of the WS-Discovery specification. This parameter may be
    ///                   <b>NULL</b>.
    ///    pTypesList = Pointer to a WSD_NAME_LIST structure that represents the list of types supported by the publishing host. May
    ///                 be <b>NULL</b>. If <i>pTypesList</i> is specified, <b>MatchResolve</b> will use WS-Discovery matching logic
    ///                 to verify that the types match those specified in <i>pResolveMessage</i>.
    ///    pScopesList = Pointer to a WSD_URI_LIST structure that represents the list of matching scopes supported by the publishing
    ///                  host. The list contains hash values in string form. May be <b>NULL</b>. If <i>pScopesList</i> is specified,
    ///                  <b>MatchResolve</b> will use WS-Discovery matching logic to verify that the scopes match those specified in
    ///                  <i>pResolveMessage</i>.
    ///    pXAddrsList = Pointer to a WSD_URI_LIST structure that represents the list of transport addresses supported by the
    ///                  publishing host. Each transport address string contains an address and port number which can be used for
    ///                  connection by a remote host.<i>pXAddrsList</i> and <i>pXAddrsList-&gt;Element</i> may not be <b>NULL</b>.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One or more of the following conditions is true: <ul> <li><i>pszId</i> is
    ///    <b>NULL</b>.</li> <li>The length in characters of <i>pszId</i> exceeds WSD_MAX_TEXT_LENGTH (8192). </li>
    ///    <li>The length in characters of <i>pszSessionId</i> exceeds WSD_MAX_TEXT_LENGTH (8192). </li>
    ///    <li><i>pProbeMessage</i> is <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The publisher has not been started. Attaching a
    ///    notification sink starts the publisher. To attach a sink, call RegisterNotificationSink. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete
    ///    the operation. </td> </tr> </table>
    ///    
    HRESULT MatchResolve(const(WSD_SOAP_MESSAGE)* pResolveMessage, IWSDMessageParameters pMessageParameters, 
                         const(wchar)* pszId, ulong ullMetadataVersion, ulong ullInstanceId, ulong ullMessageNumber, 
                         const(wchar)* pszSessionId, const(WSD_NAME_LIST)* pTypesList, 
                         const(WSD_URI_LIST)* pScopesList, const(WSD_URI_LIST)* pXAddrsList);
    ///Announces the presence of a network host by sending a Hello message with extended information.
    ///Params:
    ///    pszId = The logical or physical address of the device, which is used as the device endpoint address. A logical
    ///            address is of the form <code>urn:uuid:{guid}</code>. A physical address can be a URI prefixed by http or
    ///            https, or simply a URI prefixed by <code>uri</code>. Whenever possible, use a logical address.
    ///    ullMetadataVersion = Current metadata version. <div class="alert"><b>Note</b> For compatibility with the WS-Discovery
    ///                         specification, this value must be less than or equal to UINT_MAX (4294967295).</div> <div> </div>
    ///    ullInstanceId = Identifier for the current instance of the device being published. This identifier must be incremented
    ///                    whenever the service is restarted. For more information about instance identifiers, see Appendix I of the
    ///                    WS-Discovery specification. <div class="alert"><b>Note</b> For compatibility with the WS-Discovery
    ///                    specification, this value must be less than or equal to UINT_MAX (4294967295).</div> <div> </div>
    ///    ullMessageNumber = Counter within the scope of the instance identifier for the current message. The message number must be
    ///                       incremented for each message. <div class="alert"><b>Note</b> For compatibility with the WS-Discovery
    ///                       specification, this value must be less than or equal to UINT_MAX (4294967295).</div> <div> </div>
    ///    pszSessionId = Unique identifier within the scope of the instance identifier for the current session. This parameter
    ///                   corresponds to the sequence identifier in the AppSequence block in the Probe message. For more information
    ///                   about sequence identifiers, see Appendix I of the WS-Discovery specification. This parameter may be
    ///                   <b>NULL</b>.
    ///    pTypesList = Pointer to a WSD_NAME_LIST structure that represents the list of types supported by the publishing host. May
    ///                 be <b>NULL</b>.
    ///    pScopesList = Pointer to a WSD_URI_LIST structure that represents the list of matching scopes supported by the publishing
    ///                  host. The list contains hash values in string form. May be <b>NULL</b>.
    ///    pXAddrsList = Pointer to a WSD_URI_LIST structure that represents the list of transport addresses supported by the
    ///                  publishing host. Each transport address string contains an address and port number which can be used for
    ///                  connection by a remote host. May be <b>NULL</b>.
    ///    pHeaderAny = Pointer to a WSDXML_ELEMENT structure that contains an XML element to be inserted in the "ANY" section of the
    ///                 header.
    ///    pReferenceParameterAny = Pointer to a WSDXML_ELEMENT structure that contains an XML element to be inserted in the "ANY" section of the
    ///                             reference parameter properties.
    ///    pPolicyAny = Not used.
    ///    pEndpointReferenceAny = Pointer to a WSDXML_ELEMENT structure that contains an XML element to be inserted in the "ANY" section of the
    ///                            endpoint.
    ///    pAny = Pointer to a WSDXML_ELEMENT structure that contains an XML element to be inserted in the "ANY" section of the
    ///           message body.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One or more of the following conditions is true: <ul> <li><i>pszId</i> is
    ///    <b>NULL</b>.</li> <li>The length in characters of <i>pszId</i> exceeds WSD_MAX_TEXT_LENGTH (8192). </li>
    ///    <li>The length in characters of <i>pszSessionId</i> exceeds WSD_MAX_TEXT_LENGTH (8192). </li> </ul> </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NO_CALLBACK_ACTIVE)</b></dt> </dl> </td> <td
    ///    width="60%"> There is no registered notification sink. To attach a sink, call RegisterNotificationSink. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The publisher has not
    ///    been started. Attaching a notification sink starts the publisher. To attach a sink, call
    ///    RegisterNotificationSink. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td>
    ///    <td width="60%"> Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT PublishEx(const(wchar)* pszId, ulong ullMetadataVersion, ulong ullInstanceId, ulong ullMessageNumber, 
                      const(wchar)* pszSessionId, const(WSD_NAME_LIST)* pTypesList, const(WSD_URI_LIST)* pScopesList, 
                      const(WSD_URI_LIST)* pXAddrsList, const(WSDXML_ELEMENT)* pHeaderAny, 
                      const(WSDXML_ELEMENT)* pReferenceParameterAny, const(WSDXML_ELEMENT)* pPolicyAny, 
                      const(WSDXML_ELEMENT)* pEndpointReferenceAny, const(WSDXML_ELEMENT)* pAny);
    ///Determines whether a Probe message matches the specified host and sends a WS-Discovery ProbeMatches message with
    ///extended information if the match is made.
    ///Params:
    ///    pProbeMessage = Pointer to a WSD_SOAP_MESSAGE structure that represents the Probe message passed to the notification sink's
    ///                    ProbeHandler.
    ///    pMessageParameters = Pointer to an IWSDMessageParameters object that represents the transmission parameters passed in to the
    ///                         notification sink's ProbeHandler.
    ///    pszId = The logical or physical address of the device, which is used as the device endpoint address. A logical
    ///            address is of the form <code>urn:uuid:{guid}</code>. A physical address can be a URI prefixed by http or
    ///            https, or simply a URI prefixed by <code>uri</code>. Whenever possible, use a logical address.
    ///    ullMetadataVersion = Current metadata version. <div class="alert"><b>Note</b> For compatibility with the WS-Discovery
    ///                         specification, this value must be less than or equal to UINT_MAX (4294967295).</div> <div> </div>
    ///    ullInstanceId = Identifier for the current instance of the device being published. This identifier must be incremented
    ///                    whenever the service is restarted. For more information about instance identifiers, see Appendix I of the
    ///                    WS-Discovery specification. <div class="alert"><b>Note</b> For compatibility with the WS-Discovery
    ///                    specification, this value must be less than or equal to UINT_MAX (4294967295).</div> <div> </div>
    ///    ullMessageNumber = Counter within the scope of the instance identifier for the current message. The message number must be
    ///                       incremented for each message. <div class="alert"><b>Note</b> For compatibility with the WS-Discovery
    ///                       specification, this value must be less than or equal to UINT_MAX (4294967295).</div> <div> </div>
    ///    pszSessionId = Unique identifier within the scope of the instance identifier for the current session. This parameter
    ///                   corresponds to the sequence identifier in the AppSequence block in the Probe message. For more information
    ///                   about sequence identifiers, see Appendix I of the WS-Discovery specification. This parameter may be
    ///                   <b>NULL</b>.
    ///    pTypesList = Pointer to a WSD_NAME_LIST structure that represents the list of types supported by the publishing host. May
    ///                 be <b>NULL</b>. If <i>pTypesList</i> is specified, MatchProbe will use WS-Discovery matching logic to verify
    ///                 that the types in the list match the types specified in <i>pProbeMessage</i>.
    ///    pScopesList = Pointer to a WSD_URI_LIST structure that represents the list of matching scopes supported by the publishing
    ///                  host. The list contains hash values in string form. May be <b>NULL</b>. If <i>pScopesList</i> is specified,
    ///                  MatchProbe will use WS-Discovery matching logic to verify that the scopes in the list match the scopes
    ///                  specified in <i>pProbeMessage</i>.
    ///    pXAddrsList = Pointer to a WSD_URI_LIST structure that represents the list of transport addresses supported by the
    ///                  publishing host. Each transport address string contains an address and port number which can be used for
    ///                  connection by a remote host. May be <b>NULL</b>.
    ///    pHeaderAny = Pointer to a WSDXML_ELEMENT structure that contains an XML element to be inserted in the "ANY" section of the
    ///                 header.
    ///    pReferenceParameterAny = Pointer to a WSDXML_ELEMENT structure that contains an XML element to be inserted in the "ANY" section of the
    ///                             reference parameter properties.
    ///    pPolicyAny = Not used.
    ///    pEndpointReferenceAny = Pointer to a WSDXML_ELEMENT structure that contains an XML element to be inserted in the "ANY" section of the
    ///                            endpoint.
    ///    pAny = Pointer to a WSDXML_ELEMENT structure that contains an XML element to be inserted in the "ANY" section of the
    ///           message body.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One or more of the following conditions is true: <ul> <li><i>pszId</i> is
    ///    <b>NULL</b>.</li> <li>The length in characters of <i>pszId</i> exceeds WSD_MAX_TEXT_LENGTH (8192). </li>
    ///    <li>The length in characters of <i>pszSessionId</i> exceeds WSD_MAX_TEXT_LENGTH (8192). </li>
    ///    <li><i>pProbeMessage</i> is <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The publisher has not been started. Attaching a
    ///    notification sink starts the publisher. To attach a sink, call RegisterNotificationSink. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete
    ///    the operation. </td> </tr> </table>
    ///    
    HRESULT MatchProbeEx(const(WSD_SOAP_MESSAGE)* pProbeMessage, IWSDMessageParameters pMessageParameters, 
                         const(wchar)* pszId, ulong ullMetadataVersion, ulong ullInstanceId, ulong ullMessageNumber, 
                         const(wchar)* pszSessionId, const(WSD_NAME_LIST)* pTypesList, 
                         const(WSD_URI_LIST)* pScopesList, const(WSD_URI_LIST)* pXAddrsList, 
                         const(WSDXML_ELEMENT)* pHeaderAny, const(WSDXML_ELEMENT)* pReferenceParameterAny, 
                         const(WSDXML_ELEMENT)* pPolicyAny, const(WSDXML_ELEMENT)* pEndpointReferenceAny, 
                         const(WSDXML_ELEMENT)* pAny);
    ///Determines whether a Resolve message matches the specified host and sends a WS-Discovery ResolveMatches message
    ///with extended information if the match is made.
    ///Params:
    ///    pResolveMessage = Pointer to a WSD_SOAP_MESSAGE structure that represents the Resolve message passed in to the notification
    ///                      sink's ResolveHandler.
    ///    pMessageParameters = Pointer to an IWSDMessageParameters object that represents the transmission parameters passed in to the
    ///                         notification sink's ResolveHandler.
    ///    pszId = The logical or physical address of the device, which is used as the device endpoint address. A logical
    ///            address is of the form <code>urn:uuid:{guid}</code>. A physical address can be a URI prefixed by http or
    ///            https, or simply a URI prefixed by <code>uri</code>. Whenever possible, use a logical address.
    ///    ullMetadataVersion = Current metadata version. <div class="alert"><b>Note</b> For compatibility with the WS-Discovery
    ///                         specification, this value must be less than or equal to UINT_MAX (4294967295).</div> <div> </div>
    ///    ullInstanceId = Identifier for the current instance of the device being published. This identifier must be incremented
    ///                    whenever the service is restarted. For more information about instance identifiers, see Appendix I of the
    ///                    WS-Discovery specification. <div class="alert"><b>Note</b> For compatibility with the WS-Discovery
    ///                    specification, this value must be less than or equal to UINT_MAX (4294967295).</div> <div> </div>
    ///    ullMessageNumber = Counter within the scope of the instance identifier for the current message. The message number must be
    ///                       incremented for each message. <div class="alert"><b>Note</b> For compatibility with the WS-Discovery
    ///                       specification, this value must be less than or equal to UINT_MAX (4294967295).</div> <div> </div>
    ///    pszSessionId = Unique identifier within the scope of the instance identifier for the current session. This parameter
    ///                   corresponds to the sequence identifier in the AppSequence block in the Probe message. For more information
    ///                   about sequence identifiers, see Appendix I of the WS-Discovery specification. This parameter may be
    ///                   <b>NULL</b>.
    ///    pTypesList = Pointer to a WSD_NAME_LIST structure that represents the list of types supported by the publishing host. May
    ///                 be <b>NULL</b>. If <i>pTypesList</i> is specified, <b>MatchResolveEx</b> will use WS-Discovery matching logic
    ///                 to verify that the types match those specified in <i>pResolveMessage</i>.
    ///    pScopesList = Pointer to a WSD_URI_LIST structure that represents the list of matching scopes supported by the publishing
    ///                  host. The list contains hash values in string form. May be <b>NULL</b>. If <i>pScopesList</i> is specified,
    ///                  <b>MatchResolveEx</b> will use WS-Discovery matching logic to verify that the scopes match those specified in
    ///                  <i>pResolveMessage</i>.
    ///    pXAddrsList = Pointer to a WSD_URI_LIST structure that represents the list of transport addresses supported by the
    ///                  publishing host. Each transport address string contains an address and port number which can be used for
    ///                  connection by a remote host. <i>pXAddrsList</i> and <i>pXAddrsList-&gt;Element</i> may not be <b>NULL</b>.
    ///    pHeaderAny = Pointer to a WSDXML_ELEMENT structure that contains an XML element to be inserted in the "ANY" section of the
    ///                 header.
    ///    pReferenceParameterAny = Pointer to a WSDXML_ELEMENT structure that contains an XML element to be inserted in the "ANY" section of the
    ///                             reference parameter properties.
    ///    pPolicyAny = Not used.
    ///    pEndpointReferenceAny = Pointer to a WSDXML_ELEMENT structure that contains an XML element to be inserted in the "ANY" section of the
    ///                            endpoint.
    ///    pAny = Pointer to a WSDXML_ELEMENT structure that contains an XML element to be inserted in the "ANY" section of the
    ///           message body.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One or more of the following conditions is true: <ul> <li><i>pszId</i> is
    ///    <b>NULL</b>.</li> <li>The length in characters of <i>pszId</i> exceeds WSD_MAX_TEXT_LENGTH (8192). </li>
    ///    <li>The length in characters of <i>pszSessionId</i> exceeds WSD_MAX_TEXT_LENGTH (8192). </li>
    ///    <li><i>pProbeMessage</i> is <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The publisher has not been started. Attaching a
    ///    notification sink starts the publisher. To attach a sink, call RegisterNotificationSink. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete
    ///    the operation. </td> </tr> </table>
    ///    
    HRESULT MatchResolveEx(const(WSD_SOAP_MESSAGE)* pResolveMessage, IWSDMessageParameters pMessageParameters, 
                           const(wchar)* pszId, ulong ullMetadataVersion, ulong ullInstanceId, 
                           ulong ullMessageNumber, const(wchar)* pszSessionId, const(WSD_NAME_LIST)* pTypesList, 
                           const(WSD_URI_LIST)* pScopesList, const(WSD_URI_LIST)* pXAddrsList, 
                           const(WSDXML_ELEMENT)* pHeaderAny, const(WSDXML_ELEMENT)* pReferenceParameterAny, 
                           const(WSDXML_ELEMENT)* pPolicyAny, const(WSDXML_ELEMENT)* pEndpointReferenceAny, 
                           const(WSDXML_ELEMENT)* pAny);
    ///Adds support for a custom scope matching rule.
    ///Params:
    ///    pScopeMatchingRule = Pointer to an IWSDScopeMatchingRule object that represents a custom scope matching rule.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> <i>pScopeMatchingRule</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the operation.
    ///    </td> </tr> </table>
    ///    
    HRESULT RegisterScopeMatchingRule(IWSDScopeMatchingRule pScopeMatchingRule);
    ///Removes support for a custom scope matching rule.
    ///Params:
    ///    pScopeMatchingRule = Pointer to an IWSDScopeMatchingRule object that represents a custom scope matching rule.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> <i>pScopeMatchingRule</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT UnRegisterScopeMatchingRule(IWSDScopeMatchingRule pScopeMatchingRule);
    ///Gets the XML context associated with the device.
    ///Params:
    ///    ppContext = Pointer to a pointer to an IWSDXMLContext object that represents the XML context.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> <i>ppContext</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The publisher has not been started. Attaching a
    ///    notification sink starts the publisher. To attach a sink, call RegisterNotificationSink. </td> </tr> </table>
    ///    
    HRESULT GetXMLContext(IWSDXMLContext* ppContext);
}

///Is implemented by the client program to receive callback notifications from IWSDiscoveryPublisher.
@GUID("E67651B0-337A-4B3C-9758-733388568251")
interface IWSDiscoveryPublisherNotify : IUnknown
{
    ///Is called when a Probe is received by the discovery publisher.
    ///Params:
    ///    pSoap = Pointer to a WSD_SOAP_MESSAGE structure that contains the Probe message received by the discovery publisher.
    ///    pMessageParameters = Pointer to an IWSDMessageParameters interface that contains transport information associated with the
    ///                         received message.
    ///Returns:
    ///    The return value is not meaningful. An implementer should return S_OK.
    ///    
    HRESULT ProbeHandler(const(WSD_SOAP_MESSAGE)* pSoap, IWSDMessageParameters pMessageParameters);
    ///Is called when a Resolve is received by the discovery publisher.
    ///Params:
    ///    pSoap = Pointer to a WSD_SOAP_MESSAGE structure that contains the Resolve message received by the discovery
    ///            publisher.
    ///    pMessageParameters = Pointer to an IWSDMessageParameters interface that contains transport information associated with the
    ///                         received message.
    ///Returns:
    ///    The return value is not meaningful. An implementer should return S_OK.
    ///    
    HRESULT ResolveHandler(const(WSD_SOAP_MESSAGE)* pSoap, IWSDMessageParameters pMessageParameters);
}

///Is implemented by the client program to supply a custom scope matching rule which can be used to extend the standard
///scope matching rules defined in WS-Discovery.
@GUID("FCAFE424-FEF5-481A-BD9F-33CE0574256F")
interface IWSDScopeMatchingRule : IUnknown
{
    ///Is called to return a URI defining the implemented scope matching rule.
    ///Params:
    ///    ppszScopeMatchingRule = Pointer to the scope matching rule. The implementor must allocate memory using WSDAllocateLinkedMemory and
    ///                            the caller must release memory using WSDFreeLinkedMemory.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> </table>
    ///    
    HRESULT GetScopeRule(ushort** ppszScopeMatchingRule);
    ///Is called to compare two scopes to determine if they match.
    ///Params:
    ///    pszScope1 = Pointer to the first scope matching rule.
    ///    pszScope2 = Pointer to the second scope matching rule.
    ///    pfMatch = Set to <b>TRUE</b> if the scopes received via <i>pszScope1</i> and <i>pszScope2</i> match, <b>FALSE</b>
    ///              otherwise.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> </table>
    ///    
    HRESULT MatchScopes(const(wchar)* pszScope1, const(wchar)* pszScope2, int* pfMatch);
}

///Is the base interface for all other attachment types.
@GUID("5D55A616-9DF8-4B09-B156-9BA351A48B76")
interface IWSDAttachment : IUnknown
{
}

///Enables applications to send attachment data in a message using a MIME container.
@GUID("AA302F8D-5A22-4BA5-B392-AA8486F4C15D")
interface IWSDOutboundAttachment : IWSDAttachment
{
    ///Sends attachment data to the remote host using a MIME container.
    ///Params:
    ///    pBuffer = Pointer to a buffer containing the output data. The application program is responsible for allocating and
    ///              freeing this data buffer.
    ///    dwBytesToWrite = Number of bytes to send to the remote host from <i>pBuffer</i>.
    ///    pdwNumberOfBytesWritten = Pointer to a <b>DWORD</b> containing the number of bytes of data actually sent to the remote host.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
    ///    <td width="60%"> <i>pdwNumberofBytesWritten</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pBuffer</i> is <b>NULL</b>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_OPERATION)</b></dt> </dl> </td> <td width="60%">
    ///    The outbound attachment interface has not been initialized. Call WSDCreateOutboundAttachment to initialize
    ///    the interface. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>STG_S_BLOCK</b></dt> </dl> </td> <td
    ///    width="60%"> Internal buffers were not available. The data was not accepted and queued for transmission.
    ///    </td> </tr> </table>
    ///    
    HRESULT Write(char* pBuffer, uint dwBytesToWrite, uint* pdwNumberOfBytesWritten);
    ///Closes the current attachment MIME data stream.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. All data in the attachment stream was successfully transferred. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_OPERATION)</b></dt> </dl> </td> <td
    ///    width="60%"> Close was called before Write was called. You must call <b>Write</b> before closing the
    ///    attachment stream. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>STG_S_BLOCK</b></dt> </dl> </td> <td
    ///    width="60%"> Internal buffers were not available. The data in the attachment stream was not successfully
    ///    transferred. </td> </tr> </table>
    ///    
    HRESULT Close();
    ///Aborts the transfer of data on the attachment MIME data stream. When <b>Abort</b> is called, any pending data may
    ///be discarded.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_OPERATION)</b></dt> </dl> </td> <td width="60%"> Abort was called
    ///    before Write was called. You must call <b>Write</b> before terminating the attachment stream. </td> </tr>
    ///    </table>
    ///    
    HRESULT Abort();
}

///Allows applications to read MIME-encoded attachment data from an incoming message.
@GUID("5BD6CA65-233C-4FB8-9F7A-2641619655C9")
interface IWSDInboundAttachment : IWSDAttachment
{
    ///Retrieves attachment data from a message sent by a remote host.
    ///Params:
    ///    pBuffer = Pointer to a buffer receiving the data read from the attachment stream. The application program is
    ///              responsible for allocating and freeing this data buffer.
    ///    dwBytesToRead = Size of the <i>pBuffer</i> input buffer, in bytes.
    ///    pdwNumberOfBytesRead = Pointer to a <b>DWORD</b> containing the number of bytes of data read from the attachment stream into the
    ///                           <i>pBuffer</i> input buffer.
    ///Returns:
    ///    Possible return values include, but are not limited to, the following: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td
    ///    width="60%"> The end of the attachment stream has been reached. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pBuffer</i> is <b>NULL</b>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pdwNumberofBytesRead</i> is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT Read(char* pBuffer, uint dwBytesToRead, uint* pdwNumberOfBytesRead);
    ///Closes the current attachment MIME data stream.
    ///Returns:
    ///    This method can return one of these values. Possible return values include, but are not limited to, the
    ///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method completed successfully. </td> </tr> </table>
    ///    
    HRESULT Close();
}


// GUIDs

const GUID CLSID_PNPXAssociation    = GUIDOF!PNPXAssociation;
const GUID CLSID_PNPXPairingHandler = GUIDOF!PNPXPairingHandler;

const GUID IID_IFunctionDiscovery                    = GUIDOF!IFunctionDiscovery;
const GUID IID_IFunctionDiscoveryNotification        = GUIDOF!IFunctionDiscoveryNotification;
const GUID IID_IFunctionDiscoveryProvider            = GUIDOF!IFunctionDiscoveryProvider;
const GUID IID_IFunctionDiscoveryProviderFactory     = GUIDOF!IFunctionDiscoveryProviderFactory;
const GUID IID_IFunctionDiscoveryProviderQuery       = GUIDOF!IFunctionDiscoveryProviderQuery;
const GUID IID_IFunctionDiscoveryServiceProvider     = GUIDOF!IFunctionDiscoveryServiceProvider;
const GUID IID_IFunctionInstance                     = GUIDOF!IFunctionInstance;
const GUID IID_IFunctionInstanceCollection           = GUIDOF!IFunctionInstanceCollection;
const GUID IID_IFunctionInstanceCollectionQuery      = GUIDOF!IFunctionInstanceCollectionQuery;
const GUID IID_IFunctionInstanceQuery                = GUIDOF!IFunctionInstanceQuery;
const GUID IID_IPNPXAssociation                      = GUIDOF!IPNPXAssociation;
const GUID IID_IPNPXDeviceAssociation                = GUIDOF!IPNPXDeviceAssociation;
const GUID IID_IPropertyStoreCollection              = GUIDOF!IPropertyStoreCollection;
const GUID IID_IProviderProperties                   = GUIDOF!IProviderProperties;
const GUID IID_IProviderPropertyConstraintCollection = GUIDOF!IProviderPropertyConstraintCollection;
const GUID IID_IProviderPublishing                   = GUIDOF!IProviderPublishing;
const GUID IID_IProviderQueryConstraintCollection    = GUIDOF!IProviderQueryConstraintCollection;
const GUID IID_IWSDAddress                           = GUIDOF!IWSDAddress;
const GUID IID_IWSDAsyncCallback                     = GUIDOF!IWSDAsyncCallback;
const GUID IID_IWSDAsyncResult                       = GUIDOF!IWSDAsyncResult;
const GUID IID_IWSDAttachment                        = GUIDOF!IWSDAttachment;
const GUID IID_IWSDDeviceHost                        = GUIDOF!IWSDDeviceHost;
const GUID IID_IWSDDeviceHostNotify                  = GUIDOF!IWSDDeviceHostNotify;
const GUID IID_IWSDDeviceProxy                       = GUIDOF!IWSDDeviceProxy;
const GUID IID_IWSDEndpointProxy                     = GUIDOF!IWSDEndpointProxy;
const GUID IID_IWSDEventingStatus                    = GUIDOF!IWSDEventingStatus;
const GUID IID_IWSDHttpAddress                       = GUIDOF!IWSDHttpAddress;
const GUID IID_IWSDHttpAuthParameters                = GUIDOF!IWSDHttpAuthParameters;
const GUID IID_IWSDHttpMessageParameters             = GUIDOF!IWSDHttpMessageParameters;
const GUID IID_IWSDInboundAttachment                 = GUIDOF!IWSDInboundAttachment;
const GUID IID_IWSDMessageParameters                 = GUIDOF!IWSDMessageParameters;
const GUID IID_IWSDMetadataExchange                  = GUIDOF!IWSDMetadataExchange;
const GUID IID_IWSDOutboundAttachment                = GUIDOF!IWSDOutboundAttachment;
const GUID IID_IWSDSSLClientCertificate              = GUIDOF!IWSDSSLClientCertificate;
const GUID IID_IWSDScopeMatchingRule                 = GUIDOF!IWSDScopeMatchingRule;
const GUID IID_IWSDServiceMessaging                  = GUIDOF!IWSDServiceMessaging;
const GUID IID_IWSDServiceProxy                      = GUIDOF!IWSDServiceProxy;
const GUID IID_IWSDServiceProxyEventing              = GUIDOF!IWSDServiceProxyEventing;
const GUID IID_IWSDSignatureProperty                 = GUIDOF!IWSDSignatureProperty;
const GUID IID_IWSDTransportAddress                  = GUIDOF!IWSDTransportAddress;
const GUID IID_IWSDUdpAddress                        = GUIDOF!IWSDUdpAddress;
const GUID IID_IWSDUdpMessageParameters              = GUIDOF!IWSDUdpMessageParameters;
const GUID IID_IWSDXMLContext                        = GUIDOF!IWSDXMLContext;
const GUID IID_IWSDiscoveredService                  = GUIDOF!IWSDiscoveredService;
const GUID IID_IWSDiscoveryProvider                  = GUIDOF!IWSDiscoveryProvider;
const GUID IID_IWSDiscoveryProviderNotify            = GUIDOF!IWSDiscoveryProviderNotify;
const GUID IID_IWSDiscoveryPublisher                 = GUIDOF!IWSDiscoveryPublisher;
const GUID IID_IWSDiscoveryPublisherNotify           = GUIDOF!IWSDiscoveryPublisherNotify;
