// Written in the D programming language.

module windows.windowsconnectnow;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : PWSTR;

extern(Windows) @nogc nothrow:


// Enums


///The <b>WCN_ATTRIBUTE_TYPE</b> enumeration defines the attribute buffer types defined for Wi-Fi Protected Setup. The
///overall size occupied by each attribute buffer includes an additional 4 bytes (2 bytes of ID, 2 bytes of Length).
alias WCN_ATTRIBUTE_TYPE = int;
enum : int
{
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///is a value containing data that specifies the 802.11 channel the access point is hosting.
    WCN_TYPE_AP_CHANNEL                          = 0x00000000,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///is a value containing the association state or configuration information defined by
    ///WCN_VALUE_TYPE_ASSOCIATION_STATE.
    WCN_TYPE_ASSOCIATION_STATE                   = 0x00000001,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///is a value containing an authentication type defined by WCN_VALUE_TYPE_AUTHENTICATION_TYPE.
    WCN_TYPE_AUTHENTICATION_TYPE                 = 0x00000002,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///is a value containing data that specifies the network authentication capabilities of the Enrollee (access point
    ///or station) by providing a value defined by WCN_VALUE_TYPE_AUTHENTICATION_TYPE.
    WCN_TYPE_AUTHENTICATION_TYPE_FLAGS           = 0x00000003,
    ///This attribute value indicates that the <i>wszString</i> parameter of the IWCNDevice::GetStringAttribute method
    ///is a buffer containing a keyed hash of data. <div class="alert"><b>Note</b> Security is handled transparently by
    ///Windows. As a result, applications do not need to query or set this attribute.</div> <div> </div>
    WCN_TYPE_AUTHENTICATOR                       = 0x00000004,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///contains values, defined by WCN_VALUE_TYPE_CONFIG_METHODS, that specify the configuration methods supported by
    ///the Enrollee or Registrar. Additionally, access points and stations that support the UPnP Management Interface
    ///must also support this attribute, which is used to control the configuration methods that are enabled on the
    ///access point.
    WCN_TYPE_CONFIG_METHODS                      = 0x00000005,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///is a value, defined by WCN_VALUE_TYPE_CONFIGURATION_ERROR, that specifies the result of the device attempting to
    ///configure itself and associate with the WLAN. If a configuration session fails with the error code
    ///WCN_E_CONNECTION_REJECTED, any error code returned by the remote device can be obtained by querying this
    ///attribute. It is important to note that some devices will return WCN_VALUE_CE_NO_ERROR even if an error has
    ///occurred.
    WCN_TYPE_CONFIGURATION_ERROR                 = 0x00000006,
    ///This attribute value indicates that the <i>wszString</i> parameter of the IWCNDevice::GetStringAttribute method
    ///is a buffer that contains data representing the URL (IPv4 address based) provided by the Registrar to the
    ///Enrollee for use in posting confirmation once settings have been successfully applied and the network has been
    ///joined. This configuration parameter is optional for a Registrar, and it is optional for the Enrollee to post to
    ///the URL if the Registrar includes it. <div class="alert"><b>Note</b> An Enrollee must not connect to a
    ///confirmation URL that is on a different subnet.</div> <div> </div>
    WCN_TYPE_CONFIRMATION_URL4                   = 0x00000007,
    ///This attribute value indicates that the <i>wszString</i> parameter of the IWCNDevice::GetStringAttribute method
    ///is a buffer that contains data representing the URL (IPv6 address based) provided by the Registrar to the
    ///Enrollee for use in posting a confirmation once settings have been successfully applied and the network has been
    ///joined. This configuration parameter is optional for a Registrar and it is optional for the Enrollee to post to
    ///the URL if the Registrar includes it. <div class="alert"><b>Note</b> The Enrollee must not connect to a
    ///confirmation URL that is on a different subnet.</div> <div> </div>
    WCN_TYPE_CONFIRMATION_URL6                   = 0x00000008,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///contains a value, defined by WCN_VALUE_TYPE_CONNECTION_TYPE, that specifies the connection capability of the
    ///Enrollee.
    WCN_TYPE_CONNECTION_TYPE                     = 0x00000009,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///contains a value, defined by WCN_VALUE_TYPE_CONNECTION_TYPE, that specifies the connection capability of the
    ///Enrollee.
    WCN_TYPE_CONNECTION_TYPE_FLAGS               = 0x0000000a,
    ///This compound attribute value indicates that the <i>pbBuffer</i> parameter of the IWCNDevice::GetAttribute method
    ///contains a single WLAN Credential. There can be either multiple Credential attributes for each Network Key, or
    ///multiple Network Keys in a single Credential attribute, which is accomplished by repeating the Network Key Index
    ///and attributes that follow it. Generally, multiple keys in a single Credential for a single SSID should be used,
    ///and multiple Credential attributes for separate SSIDs should be used. The following attributes are contained in
    ///each instance of Credential: <ul> <li>WCN_TYPE_AUTHENTICATION_TYPE</li> <li>WCN_TYPE_ENCRYPTION_TYPE</li>
    ///<li>WCN_TYPE_SSID</li> <li>WCN_TYPE_NETWORK_INDEX</li> </ul> If an application intends to use the network
    ///credential with the WLAN API, it should use IWCNDevice::GetNetworkProfile to get a compatible XML network profile
    ///directly.
    WCN_TYPE_CREDENTIAL                          = 0x0000000b,
    ///This attribute value indicates that the <i>wszString</i> parameter of the IWCNDevice::GetStringAttribute method
    ///is a buffer that contains a user-friendly description of the device encoded in UTF-8. Typically, the component
    ///would be a unique identifier that describes the product in a way that is recognizable to the user.
    WCN_TYPE_DEVICE_NAME                         = 0x0000000c,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///contains a value, defined by WCN VALUE TYPE DEVICE_PASSWORD_ID, that is used to identify a device password.
    WCN_TYPE_DEVICE_PASSWORD_ID                  = 0x0000000d,
    ///This attribute value indicates that the <i>pbBuffer</i> parameter of the IWCNDevice::GetAttribute method contains
    ///the HMAC-SHA-256 hash of the first half of the device password and the Enrollee’s first secret nonce. <div
    ///class="alert"><b>Note</b> Security is handled transparently by Windows. As a result, applications do not need to
    ///query or set this attribute.</div> <div> </div>
    WCN_TYPE_E_HASH1                             = 0x0000000e,
    ///This attribute value indicates that the <i>pbBuffer</i> parameter of the IWCNDevice::GetAttribute method contains
    ///the HMAC-SHA-256 hash of the second half of the device password, and the Enrollee’s second secret nonce. <div
    ///class="alert"><b>Note</b> Security is handled transparently by Windows. As a result, applications do not need to
    ///query or set this attribute.</div> <div> </div>
    WCN_TYPE_E_HASH2                             = 0x0000000f,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///contains the first nonce used by the Enrollee with the first half of the device password. <div
    ///class="alert"><b>Note</b> Security is handled transparently by Windows. As a result, applications do not need to
    ///query or set this attribute.</div> <div> </div>
    WCN_TYPE_E_SNONCE1                           = 0x00000010,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///contains the second nonce used by the Enrollee with the second half of the device password. <div
    ///class="alert"><b>Note</b> Security is handled transparently by Windows. As a result, applications do not need to
    ///query or set this attribute.</div> <div> </div>
    WCN_TYPE_E_SNONCE2                           = 0x00000011,
    ///This attribute value indicates that the <i>pbBuffer</i> parameter of the IWCNDevice::GetAttribute method contains
    ///an initialization vector (IV) followed by a set of encrypted Wi-Fi Protected Setup TLV attributes. The last
    ///attribute in the encrypted set is a Key Wrap Authenticator computed according to the procedure described in
    ///section 6.5. <div class="alert"><b>Note</b> Security is handled transparently by Windows. As a result,
    ///applications do not need to query or set this attribute.</div> <div> </div>
    WCN_TYPE_ENCRYPTED_SETTINGS                  = 0x00000012,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///contains a value, defined by WCN_VALUE_TYPE_ENCRYPTION_TYPE, for the Enrollee (AP or station) to use.
    WCN_TYPE_ENCRYPTION_TYPE                     = 0x00000013,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///contains a value, defined by WCN_VALUE_TYPE_ENCRYPTION_TYPE, for the Enrollee (AP or station) to use.
    WCN_TYPE_ENCRYPTION_TYPE_FLAGS               = 0x00000014,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///contains a randomly generated binary value that is created by the Enrollee for setup operations. <div
    ///class="alert"><b>Note</b> Security is handled transparently by Windows. As a result, applications do not need to
    ///query or set this attribute.</div> <div> </div>
    WCN_TYPE_ENROLLEE_NONCE                      = 0x00000015,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///contains data that indicates a particular feature build for an operating system running on the device. The most
    ///significant bit of the 4 byte integer is reserved, and always set to one.
    WCN_TYPE_FEATURE_ID                          = 0x00000016,
    ///Reserved. Do not use.
    WCN_TYPE_IDENTITY                            = 0x00000017,
    ///Reserved. Do not use.
    WCN_TYPE_IDENTITY_PROOF                      = 0x00000018,
    ///This attribute value indicates that the <i>wszString</i> parameter of the IWCNDevice::GetStringAttribute method
    ///is a 8 byte buffer containing the first 64 bits of the HMAC-SHA-256 computed over the data to be encrypted with
    ///the key wrap algorithm. It is appended to the end of the ConfigData prior to encryption. <div
    ///class="alert"><b>Note</b> Security is handled transparently by Windows. As a result, applications do not need to
    ///query or set this attribute.</div> <div> </div>
    WCN_TYPE_KEY_WRAP_AUTHENTICATOR              = 0x00000019,
    ///This attribute value indicates that the <i>wszString</i> parameter of the IWCNDevice::GetAttribute method is a 16
    ///byte buffer containing a 128-bit key identifier. If this attribute immediately precedes an Encrypted Data or
    ///Authenticator attribute, then the key corresponding to the 128-bit identifier should be used to decrypt or verify
    ///the Data field.
    WCN_TYPE_KEY_IDENTIFIER                      = 0x0000001a,
    ///This attribute value indicates that the <i>pbBuffer</i> parameter of the IWCNDevice::GetAttribute method is a 6
    ///byte buffer containing the 48 bit value of the MAC Address. For example: 0x00 0x07 0xE9 0x4C 0xA8 0x1C. This
    ///address is supplied by the remote device. Some Access Points give the MAC address of their Ethernet interface, in
    ///which case, the address cannot be used to locate the AP’s wireless radio. If an application needs to locate an
    ///AP’s radio, the application should query the WCN_TYPE_BSSID attribute, which is populated by Windows and is
    ///generally more reliable.
    WCN_TYPE_MAC_ADDRESS                         = 0x0000001b,
    ///This attribute value indicates that the <i>pbBuffer</i> parameter of the IWCNDevice::GetAttribute method is a
    ///buffer containing a string that identifies the manufacturer of the device. Generally, this field should allow a
    ///user to make an association with a device with the labeling on the device.
    WCN_TYPE_MANUFACTURER                        = 0x0000001c,
    ///Reserved. Do not use.
    WCN_TYPE_MESSAGE_TYPE                        = 0x0000001d,
    ///This attribute value indicates that the <i>wszString</i> parameter of the IWCNDevice::GetStringAttribute method
    ///is a buffer that identifies the model of the device. Generally, this field should allow a user to create an
    ///association of a device with the labeling on the device.
    WCN_TYPE_MODEL_NAME                          = 0x0000001e,
    ///This attribute value indicates that the <i>wszString</i> parameter of the IWCNDevice::GetStringAttribute method
    ///is a string containing additional descriptive data associated with the device.
    WCN_TYPE_MODEL_NUMBER                        = 0x0000001f,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///is a 1 byte buffer used to get and set network settings for devices that host more than one network. The default
    ///value is '1' which refers to the primary WLAN network on the device.
    WCN_TYPE_NETWORK_INDEX                       = 0x00000020,
    ///This attribute value indicates that the <i>wszString</i> parameter of the IWCNDevice::GetStringAttribute method
    ///is a buffer containing the wireless encryption key to be used by the Enrollee. Note that it is recommended that
    ///applications implement IWCNDevice::GetNetworkProfile to get network settings in a convenient format that is ready
    ///to be used with the WLAN connection and profile management APIs.
    WCN_TYPE_NETWORK_KEY                         = 0x00000021,
    ///Reserved. Do not use.
    WCN_TYPE_NETWORK_KEY_INDEX                   = 0x00000022,
    ///Reserved. Do not use.
    WCN_TYPE_NEW_DEVICE_NAME                     = 0x00000023,
    ///Reserved. Do not use.
    WCN_TYPE_NEW_PASSWORD                        = 0x00000024,
    ///Reserved. Do not use.
    WCN_TYPE_OOB_DEVICE_PASSWORD                 = 0x00000025,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///is a 4 byte buffer that contains the operating system version running on the device. The most significant bit of
    ///this 4 byte field is reserved, and always set to one.
    WCN_TYPE_OS_VERSION                          = 0x00000026,
    ///Reserved. Do not use.
    WCN_TYPE_POWER_LEVEL                         = 0x00000027,
    ///Reserved. Do not use.
    WCN_TYPE_PSK_CURRENT                         = 0x00000028,
    ///Reserved. Do not use.
    WCN_TYPE_PSK_MAX                             = 0x00000029,
    ///Reserved. Do not use. We recommend that a shared secret be sent by way of a vendor extension or that you find
    ///another way to do cryptography.
    WCN_TYPE_PUBLIC_KEY                          = 0x0000002a,
    ///Reserved. Do not use.
    WCN_TYPE_RADIO_ENABLED                       = 0x0000002b,
    ///Reserved. Do not use.
    WCN_TYPE_REBOOT                              = 0x0000002c,
    ///Reserved. Do not use.
    WCN_TYPE_REGISTRAR_CURRENT                   = 0x0000002d,
    ///Reserved. Do not use.
    WCN_TYPE_REGISTRAR_ESTABLISHED               = 0x0000002e,
    ///Reserved. Do not use.
    WCN_TYPE_REGISTRAR_LIST                      = 0x0000002f,
    ///Reserved. Do not use.
    WCN_TYPE_REGISTRAR_MAX                       = 0x00000030,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///is a 16 byte buffer containing a randomly generated binary value created by the Registrar for setup. <div
    ///class="alert"><b>Note</b> Security is handled transparently by Windows. As a result, applications do not need to
    ///query or set this attribute.</div> <div> </div>
    WCN_TYPE_REGISTRAR_NONCE                     = 0x00000031,
    ///Reserved. Do not use.
    WCN_TYPE_REQUEST_TYPE                        = 0x00000032,
    ///Reserved. Do not use.
    WCN_TYPE_RESPONSE_TYPE                       = 0x00000033,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///is an integer value, defined by WCN_VALUE_TYPE_RF_BANDS, that indicates which RF band is utilized during message
    ///exchange, permitting end points and proxies to communicate over a consistent radio interface. It may also be used
    ///as an optional attribute in a <b>WCN_TYPE_CREDENTIAL</b> or <b>WCN_TYPE_ENCRYPTED_SETTINGS</b> to indicate a
    ///specific (or group) of RF bands to which a setting applies.
    WCN_TYPE_RF_BANDS                            = 0x00000034,
    ///This attribute value indicates that the <i>wszString</i> parameter of the IWCNDevice::GetStringAttribute method
    ///is a 32 byte buffer that containing the HMAC-SHA-256 hash of the first half of the device password and the
    ///Registrar’s first secret nonce. <div class="alert"><b>Note</b> Security is handled transparently by Windows. As
    ///a result, applications do not need to query or set this attribute.</div> <div> </div>
    WCN_TYPE_R_HASH1                             = 0x00000035,
    ///This attribute value indicates that the <i>wszString</i> parameter of the IWCNDevice::GetStringAttribute method
    ///is a 32 byte buffer containing the HMAC-SHA-256 hash of the second half of the device password and the
    ///Registrar’s second secret nonce. <div class="alert"><b>Note</b> Security is handled transparently by Windows.
    ///As a result, applications do not need to query or set this attribute.</div> <div> </div>
    WCN_TYPE_R_HASH2                             = 0x00000036,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///is a 16 byte buffer containing the first nonce used by the Registrar with the first half of the device password.
    ///<div class="alert"><b>Note</b> Security is handled transparently by Windows. As a result, applications do not
    ///need to query or set this attribute.</div> <div> </div>
    WCN_TYPE_R_SNONCE1                           = 0x00000037,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///is a 16 byte buffer containing the second nonce used by the Registrar with the second half of the device
    ///password. <div class="alert"><b>Note</b> Security is handled transparently by Windows. As a result, applications
    ///do not need to query or set this attribute.</div> <div> </div>
    WCN_TYPE_R_SNONCE2                           = 0x00000038,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///is an integer value, defined by WCN_VALUE_TYPE_BOOLEAN, that indicates if a Registrar has been selected by a user
    ///and that an Enrollee can proceed with setting up an 802.1X uncontrolled data port with the Registrar.
    WCN_TYPE_SELECTED_REGISTRAR                  = 0x00000039,
    ///This attribute value indicates that the <i>wszString</i> parameter of the IWCNDevice::GetStringAttribute method
    ///is a string containing the serial number of the Enrollee. <div class="alert"><b>Note</b> Not all devices supply a
    ///serial number. Some devices return a string of non-numeric characters, and as a result it is not always possible
    ///to convert this value to a number. </div> <div> </div>
    WCN_TYPE_SERIAL_NUMBER                       = 0x0000003a,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///an integer value, defined by WCN_VALUE_TYPE_WI_FI_PROTECTED_SETUP, that indicates if a device is configured.
    WCN_TYPE_WI_FI_PROTECTED_SETUP_STATE         = 0x0000003b,
    ///This attribute value indicates that the <i>pbData</i> parameter of the IWCNDevice::GetAttribute method is a
    ///buffer, up to 32 bytes in size, containing the Service Set Identifier (SSID) or network name. Instead of querying
    ///this attribute, it is recommended that applications implement IWCNDevice::GetNetworkProfile to retrieve network
    ///settings in a convenient format that is ready to be used with the WLAN connection and profile management APIs.
    WCN_TYPE_SSID                                = 0x0000003c,
    ///Reserved. Do not use.
    WCN_TYPE_TOTAL_NETWORKS                      = 0x0000003d,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///is a 16 byte buffer containing the Universally Unique Identifier (UUID) generated by the Enrollee. It uniquely
    ///identifies an operational device and should survive reboots and resets. The UUID is provided in binary format. If
    ///the device also supports UPnP, then the UUID corresponds to the UPnP UUID. Instead of querying this attribute,
    ///applications should instead query the WCN_TYPE_UUID attribute, as it is available for both enrollees and
    ///registrars. WCN_TYPE_UUID_E_ is only available for devices that act as an enrollee.
    WCN_TYPE_UUID_E                              = 0x0000003e,
    ///This attribute value indicates that the <i>pbBuffer</i> parameter of the IWCNDevice::GetAttribute method is a 16
    ///byte buffer containing the Universally Unique Identifier (UUID) element generated by the Registrar. It uniquely
    ///identifies an operational device and should survive reboots and resets. The UUID is provided in binary format. If
    ///the device also supports UPnP, then the UUID corresponds to the UPnP UUID. Instead of querying this attribute,
    ///applications should instead query the WCN_TYPE_UUID attribute, as it is available for both enrollees and
    ///registrars.
    WCN_TYPE_UUID_R                              = 0x0000003f,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetAttribute method is a
    ///buffer, up to 1024 bytes in size, that permits the use of vendor extensions in the Wi-Fi Protected Setup TLV
    ///framework. The Vendor Extension figure illustrates the implementation of vendor extensions. Vendor ID is the SMI
    ///network management private enterprise code. Instead of querying this value, implementation of the
    ///IWCNDevice::GetVendorExtension API is recommended for convenience and flexibilty while accessing the raw vendor
    ///extension attribute directly.
    WCN_TYPE_VENDOR_EXTENSION                    = 0x00000040,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///is an integer value that indicates the Wi-Fi Protected Setup version. The one-byte field is broken into a
    ///four-bit major part using the top MSBs and four-bit minor part using the LSBs. As an example, version 3.2 would
    ///be 0x32. <div class="alert"><b>Note</b> Windows will automatically use the correct WPS version for each device,
    ///so applications are not required to query or set this value.</div> <div> </div> <div class="alert"><b>Note</b>
    ///When using WPS 2.0, <b>WCN_TYPE_VERSION</b> will always be set to 0x10 and <b>WCN_TYPE_VERSION2</b> is used
    ///instead</div> <div> </div>
    WCN_TYPE_VERSION                             = 0x00000041,
    ///This attribute value indicates that the <i>pbBuffer</i> parameter of the IWCNDevice::GetAttribute method is a
    ///buffer containing an X.509 certificate request payload as specified in RFC 2511.
    WCN_TYPE_X_509_CERTIFICATE_REQUEST           = 0x00000042,
    ///This attribute value indicates that the <i>pbBuffer</i> parameter of the IWCNDevice::GetAttribute method is a
    ///buffer containing an X.509 certificate.
    WCN_TYPE_X_509_CERTIFICATE                   = 0x00000043,
    ///Reserved. Do not use.
    WCN_TYPE_EAP_IDENTITY                        = 0x00000044,
    ///Reserved. Do not use.
    WCN_TYPE_MESSAGE_COUNTER                     = 0x00000045,
    ///This attribute value indicates that the <i>wszString</i> parameter of the IWCNDevice::GetStringAttribute method
    ///is a 20 byte buffer containing the first 160 bits of the SHA-256 hash of a public key. <div
    ///class="alert"><b>Note</b> Security is handled transparently by Windows. As a result, applications do not need to
    ///query or set this attribute.</div> <div> </div>
    WCN_TYPE_PUBLIC_KEY_HASH                     = 0x00000046,
    ///Reserved. Do not use.
    WCN_TYPE_REKEY_KEY                           = 0x00000047,
    ///Reserved. Do not use.
    WCN_TYPE_KEY_LIFETIME                        = 0x00000048,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///is an integer defined by WCN_VALUE_TYPE_CONFIG_METHODS, that indicates which of the configuration methods
    ///supported by the device are enabled.
    WCN_TYPE_PERMITTED_CONFIG_METHODS            = 0x00000049,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///is an integer defined by WCN_VALUE_TYPE_CONFIG_METHODS, that is used in Probe Response messages to convey the
    ///current supported Config Methods of a specific Registrar.
    WCN_TYPE_SELECTED_REGISTRAR_CONFIG_METHODS   = 0x0000004a,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///is an 8 byte buffer containing values, contained in WCN_VALUE_TYPE_PRIMARY_DEVICE_TYPE, that indicates the
    ///primary type of the device. It is recommended that applications instead query the
    ///WCN_TYPE_PRIMARY_DEVICE_TYPE_CATEGORY, WCN_TYPE_PRIMARY_DEVICE_TYPE_SUBCATEGORY_OUI, and
    ///WCN_TYPE_PRIMARY_DEVICE_TYPE_SUBCATEGORY attributes as they are more convenient.
    WCN_TYPE_PRIMARY_DEVICE_TYPE                 = 0x0000004b,
    ///Reserved. Do not use.
    WCN_TYPE_SECONDARY_DEVICE_TYPE_LIST          = 0x0000004c,
    ///Reserved. Do not use.
    WCN_TYPE_PORTABLE_DEVICE                     = 0x0000004d,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///is a buffer containing a value, defined by WCN_VALUE_TYPE_BOOLEAN, that indicates if the access point has entered
    ///a state in which it will refuse to allow an external Registrar to attempt to run the Registration Protocol using
    ///the AP’s PIN (with the AP acting as Enrollee). The AP should enter this state if it believes a brute force
    ///attack is underway against the AP’s PIN. When the AP is in this state, it MUST continue to allow other
    ///Enrollees to connect and run the Registration Protocol with any external Registrars or the AP’s built-in
    ///Registrar (if any). It is only the use of the AP’s PIN for adding external Registrars that is disabled in this
    ///state. The AP Setup Locked state can be reset to <b>FALSE</b> through an authenticated call to SetAPSettings. APs
    ///may provide other implementation-specific methods of resetting the AP Setup Locked state as well.
    WCN_TYPE_AP_SETUP_LOCKED                     = 0x0000004e,
    ///This attribute value indicates that the <i>pvBuffer</i> parameter of the IWCNDevice::GetAttribute method is a
    ///buffer, up to 512 bytes in size, used to pass parameters for enabling applications during the WSC exchange. It is
    ///similar to the Vendor Extension attribute except that instead of a 3-byte Vendor ID prefix to the Vendor Data
    ///field, a 16-byte UUID (as defined in RFC 4122) is used. This provides a virtually unlimited application ID space
    ///with a regular structure that can be easily mapped onto a generic application extension API. Furthermore, the
    ///16-byte UUID value can be used to derive applicationspecific AMSKs as described in Section 6.3 or pass any
    ///necessary keying directly.
    WCN_TYPE_APPLICATION_EXTENSION               = 0x0000004f,
    ///Reserved. Do not use.
    WCN_TYPE_EAP_TYPE                            = 0x00000050,
    ///Reserved. Do not use.
    WCN_TYPE_INITIALIZATION_VECTOR               = 0x00000051,
    ///Reserved. Do not use.
    WCN_TYPE_KEY_PROVIDED_AUTOMATICALLY          = 0x00000052,
    ///Reserved. Do not use.
    WCN_TYPE_802_1X_ENABLED                      = 0x00000053,
    ///This attribute value represents the buffer, up to 128 bytes in size, containing data that indicates an exchange
    ///of application specific session keys and, alternatively, may be used to calculate AMSKs.
    WCN_TYPE_APPSESSIONKEY                       = 0x00000054,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///is a 1 byte buffer containing data that identifies the Key Index value used as the Access Point transmit key for
    ///WEP configurations.
    WCN_TYPE_WEPTRANSMITKEY                      = 0x00000055,
    ///This compound attribute indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute
    ///method is a 16 byte buffer that contains data that is always equal to the UUID of the device, regardless if the
    ///device is enrollee or registrar. (Effectively, merges WCN_TYPE_UUID_E and WCN_TYPE_UUID_R).
    WCN_TYPE_UUID                                = 0x00000056,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute is an
    ///integer that represents the major device category of a WCN device. The major device category is one of the
    ///WCN_VALUE_TYPE_DEVICE_TYPE_CATEGORY values.
    WCN_TYPE_PRIMARY_DEVICE_TYPE_CATEGORY        = 0x00000057,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute is an
    ///integer that represents the OUI that defines the device subcategory of a WCN device. The most common OUI is
    ///WCN_VALUE_DT_SUBTYPE_WIFI_OUI which indicates that the subcategory is defined by the Wi-Fi Alliance.
    WCN_TYPE_PRIMARY_DEVICE_TYPE_SUBCATEGORY_OUI = 0x00000058,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute is an
    ///integer that represents the device subcategory of a WCN device. The subcategory must be interpreted along with
    ///the OUI from WCN_TYPE_PRIMARY_DEVICE_TYPE_SUBCATEGORY_OUI. For devices using the Wi-Fi Alliance OUI. The
    ///subcategory is one of the WCN_VALUE_TYPE_DEVICE_TYPE_SUBCATEGORY values.
    WCN_TYPE_PRIMARY_DEVICE_TYPE_SUBCATEGORY     = 0x00000059,
    ///This attribute value indicates that the <i>wszString</i> parameter of the IWCNDevice::GetStringAttribute method
    ///is buffer, up to 32 bytes in size, containing the current SSID of a wireless access point.
    WCN_TYPE_CURRENT_SSID                        = 0x0000005a,
    ///Reserved. Do not use.
    WCN_TYPE_BSSID                               = 0x0000005b,
    ///Reserved. Do not use.
    WCN_TYPE_DOT11_MAC_ADDRESS                   = 0x0000005c,
    ///. This attribute value indicates that a registrar is providing a list of MAC addresses that are authorized to
    ///start WSC. The <i>pbBuffer</i> parameter of the IWCNDevice::GetAttribute method is a 6-30 byte buffer containing
    ///the 48 bit value of each MAC Address in the list of authorized MACs. For example: 0x00 0x07 0xE9 0x4C 0xA8 0x1C.
    ///<div class="alert"><b>Note</b> Only available in Windows 8.</div> <div> </div>
    WCN_TYPE_AUTHORIZED_MACS                     = 0x0000005d,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///is a 1 byte buffer used to get and set network settings for devices that host more than one network. A value of
    ///'1' indicates that the Network Key may be shared with other devices. <div class="alert"><b>Note</b> Only
    ///available in Windows 8.</div> <div> </div>
    WCN_TYPE_NETWORK_KEY_SHAREABLE               = 0x0000005e,
    ///Reserved. Do not use.
    WCN_TYPE_REQUEST_TO_ENROLL                   = 0x0000005f,
    ///Reserved. Do not use.
    WCN_TYPE_REQUESTED_DEVICE_TYPE               = 0x00000060,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///is a 1 byte buffer indicating the estimated length of time (in seconds) that an access point will require to
    ///reconfigure itself and become available, or that a device will require to apply settings and connect to a
    ///network. <div class="alert"><b>Note</b> Only available in Windows 8.</div> <div> </div>
    WCN_TYPE_SETTINGS_DELAY_TIME                 = 0x00000061,
    ///This attribute value indicates that the <i>puInteger</i> parameter of the IWCNDevice::GetIntegerAttribute method
    ///is an integer value that indicates the Wi-Fi Protected Setup version. The one-byte field is broken into a
    ///four-bit major part using the top MSBs and four-bit minor part using the LSBs. As an example, version 3.2 would
    ///be 0x32. <div class="alert"><b>Note</b> Windows will automatically use the correct WPS version for each device,
    ///so applications are not required to query or set this value.</div> <div> </div> <div class="alert"><b>Note</b>
    ///Only available in Windows 8.</div> <div> </div>
    WCN_TYPE_VERSION2                            = 0x00000062,
    ///Reserved. Do not use. <div class="alert"><b>Note</b> The attributes within the WFA vendor extension may be
    ///queried directly.</div> <div> </div>
    WCN_TYPE_VENDOR_EXTENSION_WFA                = 0x00000063,
    WCN_NUM_ATTRIBUTE_TYPES                      = 0x00000064,
}

///The <b>WCN_VALUE_TYPE_VERSION</b> enumeration defines the supported version of Wi-Fi Protected Setup (WPS).
alias WCN_VALUE_TYPE_VERSION = int;
enum : int
{
    ///Specifies WPS 1.0. Indicates compliance with Wi-Fi Alliance protocol specification for Wi-Fi Protected Setup
    ///(WPS) 1.0h.
    WCN_VALUE_VERSION_1_0 = 0x00000010,
    ///Specifies WPS 2.0. Indicates compliance with Wi-Fi Alliance protocol specification for Wi-Fi Simple Configuration
    ///(WSC) 2.0.
    WCN_VALUE_VERSION_2_0 = 0x00000020,
}

///The <b>WCN_VALUE_TYPE_BOOLEAN</b> enumeration defines values used to represent true/false conditions encountered
///during device setup and association.
alias WCN_VALUE_TYPE_BOOLEAN = int;
enum : int
{
    ///The argument is false.
    WCN_VALUE_FALSE = 0x00000000,
    ///The argument is true.
    WCN_VALUE_TRUE  = 0x00000001,
}

///The <b>WCN_VALUE_TYPE_ASSOCIATION_STATE</b> enumeration defines the possible association states of a wireless station
///during a Discovery request.
alias WCN_VALUE_TYPE_ASSOCIATION_STATE = int;
enum : int
{
    ///The wireless station is not associated.
    WCN_VALUE_AS_NOT_ASSOCIATED        = 0x00000000,
    ///The connection was successfully established.
    WCN_VALUE_AS_CONNECTION_SUCCESS    = 0x00000001,
    ///The wireless station is not properly configured.
    WCN_VALUE_AS_CONFIGURATION_FAILURE = 0x00000002,
    ///Association has failed.
    WCN_VALUE_AS_ASSOCIATION_FAILURE   = 0x00000003,
    ///The specified IP address could not be connected to, and may be invalid.
    WCN_VALUE_AS_IP_FAILURE            = 0x00000004,
}

///The <b>WCN_VALUE_TYPE_AUTHENTICATION_TYPE</b> enumeration defines the authentication types supported by the Enrollee
///(access point or station).
alias WCN_VALUE_TYPE_AUTHENTICATION_TYPE = int;
enum : int
{
    ///Specifies IEEE 802.11 Open System authentication.
    WCN_VALUE_AT_OPEN             = 0x00000001,
    ///Specifies WPA security. Authentication is performed between the supplicant and authenticator over IEEE 802.1X.
    ///Encryption keys are dynamic and are derived through the preshared key used by the supplicant and authenticator.
    ///<div class="alert"><b>Note</b> Not supported in WPS 2.0.</div> <div> </div>
    WCN_VALUE_AT_WPAPSK           = 0x00000002,
    ///Specifies IEEE 802.11 Shared Key authentication that uses a preshared WEP key. <div class="alert"><b>Note</b> Not
    ///supported in WPS 2.0.</div> <div> </div>
    WCN_VALUE_AT_SHARED           = 0x00000004,
    ///Specifies WPA security. Authentication is performed between the supplicant, authenticator, and authentication
    ///server over IEEE 802.1X. Encryption keys are dynamic and are derived through the authentication process. <div
    ///class="alert"><b>Note</b> Not supported by most access points, consider WPA2PSK authentication instead.</div>
    ///<div> </div> <div class="alert"><b>Note</b> Not supported in WPS 2.0.</div> <div> </div>
    WCN_VALUE_AT_WPA              = 0x00000008,
    ///Specifies WPA2 security. Authentication is performed between the supplicant, authenticator, and authentication
    ///server over IEEE 802.1X. Encryption keys are dynamic and are derived through the authentication process. <div
    ///class="alert"><b>Note</b> Not supported by most access points, consider WPA2PSK authentication instead.</div>
    ///<div> </div>
    WCN_VALUE_AT_WPA2             = 0x00000010,
    ///Specifies WPA2 security. Authentication is performed between the supplicant and authenticator over IEEE 802 1X.
    ///Encryption keys are dynamic and are derived through the preshared key used by the supplicant and authenticator.
    WCN_VALUE_AT_WPA2PSK          = 0x00000020,
    ///Specifies WPAPSK/WPA2PSK mixed-mode encryption. <div class="alert"><b>Note</b> Available starting in Windows
    ///8.1.</div> <div> </div>
    WCN_VALUE_AT_WPAWPA2PSK_MIXED = 0x00000022,
}

///The <b>WCN_VALUE_TYPE_CONFIG_METHODS</b> enumeration defines the configuration methods supported by the Enrollee or
///Registrar. One or more of the following configuration methods must be supported.
alias WCN_VALUE_TYPE_CONFIG_METHODS = int;
enum : int
{
    ///USB-A (flash drive) configuration is supported. <div class="alert"><b>Note</b> Not supported in Windows 7 and
    ///later. Not supported in WPS 2.0.</div> <div> </div>
    WCN_VALUE_CM_USBA            = 0x00000001,
    ///Ethernet configuration is supported. <div class="alert"><b>Note</b> Not supported in Windows 7 and later. Not
    ///supported in WPS 2.0.</div> <div> </div>
    WCN_VALUE_CM_ETHERNET        = 0x00000002,
    ///Label configuration is supported. To authenticate with the default password ID, call IWCNDevice::SetPassword with
    ///the PIN password type defined by WCN_PASSWORD_TYPE.
    WCN_VALUE_CM_LABEL           = 0x00000004,
    ///Display configuration is supported. To authenticate with the default password ID, call IWCNDevice::SetPassword
    ///with the PIN password type defined by WCN_PASSWORD_TYPE. <div class="alert"><b>Note</b> For WPS 2.0, use
    ///<b>WCN_VALUE_CM_VIRT_DISPLAY</b> or <b>WCN_VALUE_CM_PHYS_DISPLAY</b>.</div> <div> </div>
    WCN_VALUE_CM_DISPLAY         = 0x00000008,
    ///External near-field communication (NFC) token configuration is supported. <div class="alert"><b>Note</b> Not
    ///supported in Windows 7.</div> <div> </div>
    WCN_VALUE_CM_EXTERNAL_NFC    = 0x00000010,
    ///Integrated NFC token configuration is supported. <div class="alert"><b>Note</b> Not supported in Windows 7.</div>
    ///<div> </div>
    WCN_VALUE_CM_INTEGRATED_NFC  = 0x00000020,
    ///NFC interface configuration is supported. <div class="alert"><b>Note</b> Not supported in Windows 7.</div> <div>
    ///</div>
    WCN_VALUE_CM_NFC_INTERFACE   = 0x00000040,
    ///Push button configuration is supported. To authenticate with the default password ID, call
    ///IWCNDevice::SetPassword with the push button password type defined by WCN_PASSWORD_TYPE. <div
    ///class="alert"><b>Note</b> For WPS 2.0, use <b>WCN_VALUE_CM_VIRT_PUSHBUTTON</b> or
    ///<b>WCN_VALUE_CM_PHYS_PUSHBUTTON</b>.</div> <div> </div>
    WCN_VALUE_CM_PUSHBUTTON      = 0x00000080,
    ///Keypad configuration is supported. <div class="alert"><b>Note</b> Not supported in Windows 7.</div> <div> </div>
    WCN_VALUE_CM_KEYPAD          = 0x00000100,
    ///Virtual push button configuration is supported. To authenticate with the default password ID, call
    ///IWCNDevice::SetPassword with the push button password type defined by WCN_PASSWORD_TYPE. <div
    ///class="alert"><b>Note</b> Only available in Windows 8.</div> <div> </div>
    WCN_VALUE_CM_VIRT_PUSHBUTTON = 0x00000280,
    ///Physical push button configuration is supported. To authenticate with the default password ID, call
    ///IWCNDevice::SetPassword with the push button password type defined by WCN_PASSWORD_TYPE. <div
    ///class="alert"><b>Note</b> Only available in Windows 8.</div> <div> </div>
    WCN_VALUE_CM_PHYS_PUSHBUTTON = 0x00000480,
    ///Virtual display configuration is supported. To authenticate with the default password ID, call
    ///IWCNDevice::SetPassword with the PIN password type defined by WCN_PASSWORD_TYPE. <div class="alert"><b>Note</b>
    ///Only available in Windows 8.</div> <div> </div>
    WCN_VALUE_CM_VIRT_DISPLAY    = 0x00002008,
    ///Physical display configuration is supported. To authenticate with the default password ID, call
    ///IWCNDevice::SetPassword with the PIN password type defined by WCN_PASSWORD_TYPE. <div class="alert"><b>Note</b>
    ///Only available in Windows 8.</div> <div> </div>
    WCN_VALUE_CM_PHYS_DISPLAY    = 0x00004008,
}

///The <b>WCN_VALUE_TYPE_CONFIGURATION_ERROR</b> enumeration defines possible error values returned to a device while
///attempting to configure to, and associate with, the WLAN.
alias WCN_VALUE_TYPE_CONFIGURATION_ERROR = int;
enum : int
{
    ///No error. An application must be prepared to handle devices that signal 'No Error' even if the device detected an
    ///error.
    WCN_VALUE_CE_NO_ERROR                       = 0x00000000,
    ///Could not read the out-of-band (OOB) interface.
    WCN_VALUE_CE_OOB_INTERFACE_READ_ERROR       = 0x00000001,
    ///Could not decrypt the Cyclic Redundancy Check (CRC) value.
    WCN_VALUE_CE_DECRYPTION_CRC_FAILURE         = 0x00000002,
    ///The 2.4 GHz channel is not supported.
    WCN_VALUE_CE_2_4_CHANNEL_NOT_SUPPORTED      = 0x00000003,
    ///The 5.0 GHz channel is not supported.
    WCN_VALUE_CE_5_0_CHANNEL_NOT_SUPPORTED      = 0x00000004,
    ///The wireless signal is not strong enough to initiate a connection. <div class="alert"><b>Note</b> Not supported
    ///in WPS 2.0.</div> <div> </div>
    WCN_VALUE_CE_SIGNAL_TOO_WEAK                = 0x00000005,
    ///Network authentication failed. <div class="alert"><b>Note</b> Not supported in WPS 2.0.</div> <div> </div>
    WCN_VALUE_CE_NETWORK_AUTHENTICATION_FAILURE = 0x00000006,
    ///Network association failed. <div class="alert"><b>Note</b> Not supported in WPS 2.0.</div> <div> </div>
    WCN_VALUE_CE_NETWORK_ASSOCIATION_FAILURE    = 0x00000007,
    ///The DHCP server did not respond. <div class="alert"><b>Note</b> Not supported in WPS 2.0.</div> <div> </div>
    WCN_VALUE_CE_NO_DHCP_RESPONSE               = 0x00000008,
    ///DHCP configuration failed. <div class="alert"><b>Note</b> Not supported in WPS 2.0.</div> <div> </div>
    WCN_VALUE_CE_FAILED_DHCP_CONFIG             = 0x00000009,
    ///There was an IP address conflict. <div class="alert"><b>Note</b> Not supported in WPS 2.0.</div> <div> </div>
    WCN_VALUE_CE_IP_ADDRESS_CONFLICT            = 0x0000000a,
    ///Could not connect to the registrar.
    WCN_VALUE_CE_COULD_NOT_CONNECT_TO_REGISTRAR = 0x0000000b,
    ///Multiple push button configuration (PBC) sessions were detected.
    WCN_VALUE_CE_MULTIPLE_PBC_SESSIONS_DETECTED = 0x0000000c,
    ///Rogue activity is suspected.
    WCN_VALUE_CE_ROGUE_ACTIVITY_SUSPECTED       = 0x0000000d,
    ///The device is busy.
    WCN_VALUE_CE_DEVICE_BUSY                    = 0x0000000e,
    ///Setup is locked.
    WCN_VALUE_CE_SETUP_LOCKED                   = 0x0000000f,
    ///The message timed out. <div class="alert"><b>Note</b> Not supported in WPS 2.0.</div> <div> </div>
    WCN_VALUE_CE_MESSAGE_TIMEOUT                = 0x00000010,
    ///The registration session timed out. <div class="alert"><b>Note</b> Not supported in WPS 2.0.</div> <div> </div>
    WCN_VALUE_CE_REGISTRATION_SESSION_TIMEOUT   = 0x00000011,
    ///Device password authentication failed.
    WCN_VALUE_CE_DEVICE_PASSWORD_AUTH_FAILURE   = 0x00000012,
}

///The <b>WCN_VALUE_TYPE_CONNECTION_TYPE</b> enumeration defines the connection capabilities of the Enrollee.
alias WCN_VALUE_TYPE_CONNECTION_TYPE = int;
enum : int
{
    ///Specifies an ESS (infrastructure network) connection.
    WCN_VALUE_CT_ESS  = 0x00000001,
    ///Specifies an IBSS (ad-hoc network) connection.
    WCN_VALUE_CT_IBSS = 0x00000002,
}

///The <b>WCN_VALUE_TYPE_DEVICE_PASSWORD_ID</b> enumeration defines values that specify the origin or 'type' of a
///password.
alias WCN_VALUE_TYPE_DEVICE_PASSWORD_ID = int;
enum : int
{
    ///The PIN password, obtained from the label, or display will be used. This password may correspond to the label,
    ///display, or a user-defined password that has been configured to replace the original device password. To
    ///authenticate with the default password ID, call IWCNDevice::SetPassword with the PIN password type defined by
    ///WCN_PASSWORD_TYPE.
    WCN_VALUE_DP_DEFAULT                 = 0x00000000,
    ///The user has overridden the default password with a manually selected value. <div class="alert"><b>Note</b> Not
    ///supported in Windows 7.</div> <div> </div>
    WCN_VALUE_DP_USER_SPECIFIED          = 0x00000001,
    ///The default PIN password has been overridden by a strong, machine-generated device password value. <div
    ///class="alert"><b>Note</b> Not supported in Windows 7.</div> <div> </div>
    WCN_VALUE_DP_MACHINE_SPECIFIED       = 0x00000002,
    ///The 256-bit rekeying password associated with the device will be used. <div class="alert"><b>Note</b> Not
    ///supported in Windows 7.</div> <div> </div>
    WCN_VALUE_DP_REKEY                   = 0x00000003,
    ///A password entered via a push button interface will be used. To authenticate with the default password ID, call
    ///IWCNDevice::SetPassword with the push button password type defined by WCN_PASSWORD_TYPE.
    WCN_VALUE_DP_PUSHBUTTON              = 0x00000004,
    ///A PIN has been obtained from the Registrar via a display or other out-of-band method. <div
    ///class="alert"><b>Note</b> Not supported in Windows 7.</div> <div> </div>
    WCN_VALUE_DP_REGISTRAR_SPECIFIED     = 0x00000005,
    WCN_VALUE_DP_NFC_CONNECTION_HANDOVER = 0x00000007,
    WCN_VALUE_DP_WFD_SERVICES            = 0x00000008,
    WCN_VALUE_DP_OUTOFBAND_MIN           = 0x00000010,
    WCN_VALUE_DP_OUTOFBAND_MAX           = 0x0000ffff,
}

///The <b>WCN_VALUE_TYPE_ENCRYPTION_TYPE</b> enumeration defines the supported WLAN encryption types.
alias WCN_VALUE_TYPE_ENCRYPTION_TYPE = int;
enum : int
{
    ///Specifies support for unsecured wireless activity.
    WCN_VALUE_ET_NONE           = 0x00000001,
    ///Specifies support for the Wired Equivalent Privacy (WEP) encryption method. <div class="alert"><b>Note</b> Not
    ///available for WPS 2.0.</div> <div> </div>
    WCN_VALUE_ET_WEP            = 0x00000002,
    ///Specifies support for the Temporal Key Integrity Protocol (TKIP) encryption method. <div
    ///class="alert"><b>Note</b> Not available for WPS 2.0.</div> <div> </div>
    WCN_VALUE_ET_TKIP           = 0x00000004,
    ///Specifies support for the Advanced Encryption Standard (AES) encryption method.
    WCN_VALUE_ET_AES            = 0x00000008,
    ///Specifies support for WPAPSK/WPA2PSK mixed-mode encryption. <div class="alert"><b>Note</b> Not supported in WPS
    ///1.0. Only available in Windows 8.</div> <div> </div>
    WCN_VALUE_ET_TKIP_AES_MIXED = 0x0000000c,
}

alias WCN_VALUE_TYPE_MESSAGE_TYPE = int;
enum : int
{
    WCN_VALUE_MT_BEACON         = 0x00000001,
    WCN_VALUE_MT_PROBE_REQUEST  = 0x00000002,
    WCN_VALUE_MT_PROBE_RESPONSE = 0x00000003,
    WCN_VALUE_MT_M1             = 0x00000004,
    WCN_VALUE_MT_M2             = 0x00000005,
    WCN_VALUE_MT_M2D            = 0x00000006,
    WCN_VALUE_MT_M3             = 0x00000007,
    WCN_VALUE_MT_M4             = 0x00000008,
    WCN_VALUE_MT_M5             = 0x00000009,
    WCN_VALUE_MT_M6             = 0x0000000a,
    WCN_VALUE_MT_M7             = 0x0000000b,
    WCN_VALUE_MT_M8             = 0x0000000c,
    WCN_VALUE_MT_ACK            = 0x0000000d,
    WCN_VALUE_MT_NACK           = 0x0000000e,
    WCN_VALUE_MT_DONE           = 0x0000000f,
}

alias WCN_VALUE_TYPE_REQUEST_TYPE = int;
enum : int
{
    WCN_VALUE_ReqT_ENROLLEE_INFO     = 0x00000000,
    WCN_VALUE_ReqT_ENROLLEE_OPEN_1X  = 0x00000001,
    WCN_VALUE_ReqT_REGISTRAR         = 0x00000002,
    WCN_VALUE_ReqT_MANAGER_REGISTRAR = 0x00000003,
}

alias WCN_VALUE_TYPE_RESPONSE_TYPE = int;
enum : int
{
    WCN_VALUE_RspT_ENROLLEE_INFO    = 0x00000000,
    WCN_VALUE_RspT_ENROLLEE_OPEN_1X = 0x00000001,
    WCN_VALUE_RspT_REGISTRAR        = 0x00000002,
    WCN_VALUE_RspT_AP               = 0x00000003,
}

///The <b>WCN_VALUE_TYPE_RF_BANDS</b> enumeration defines the possible radio frequency bands on which an enrollee can
///send Discovery requests.
alias WCN_VALUE_TYPE_RF_BANDS = int;
enum : int
{
    ///The request is being sent on the 2.4 GHz frequency band.
    WCN_VALUE_RB_24GHZ = 0x00000001,
    ///The request is being sent on the 5.0 Ghz frequency band.
    WCN_VALUE_RB_50GHZ = 0x00000002,
}

///The <b>WCN_VALUE_TYPE_WI_FI_PROTECTED_SETUP_STATE</b> enumeration defines values that indicate if a device is
///configured.
alias WCN_VALUE_TYPE_WI_FI_PROTECTED_SETUP_STATE = int;
enum : int
{
    ///This value is reserved.
    WCN_VALUE_SS_RESERVED00     = 0x00000000,
    ///The device is not configured.
    WCN_VALUE_SS_NOT_CONFIGURED = 0x00000001,
    ///The device is configured.
    WCN_VALUE_SS_CONFIGURED     = 0x00000002,
}

///The <b>WCN_PASSWORD_TYPE</b> enumeration defines the authentication that will be used in a WPS session.
alias WCN_PASSWORD_TYPE = int;
enum : int
{
    ///Indicates the device uses a WPS button interface to put the device into wireless provisioning mode. If this value
    ///is specified when calling IWCNDevice::SetPassword, set <i>dwPasswordLength</i> to zero and <i>pbPassword</i> to
    ///<b>NULL</b>.
    WCN_PASSWORD_TYPE_PUSH_BUTTON             = 0x00000000,
    ///Indicates that authentication is secured via a PIN. The user must provide the PIN of the device. Usually, the PIN
    ///is a 4 or 8-digit number printed on a label attached to the device, or displayed on the screen. If this value is
    ///specified when calling IWCNDevice::SetPassword, set <i>dwPasswordLength</i> to the number of digits in the
    ///password, and <i>pbPassword</i> to point to a buffer containing the ASCII representation of the pin.
    WCN_PASSWORD_TYPE_PIN                     = 0x00000001,
    ///Indicates that authentication is secured via a PIN, as above, but that the PIN is specified by the registrar.
    ///<div class="alert"><b>Note</b> Only available in Windows 8.</div> <div> </div>
    WCN_PASSWORD_TYPE_PIN_REGISTRAR_SPECIFIED = 0x00000002,
    WCN_PASSWORD_TYPE_OOB_SPECIFIED           = 0x00000003,
    WCN_PASSWORD_TYPE_WFDS                    = 0x00000004,
}

///The <b>WCN_SESSION_STATUS</b> enumeration defines the outcome status of a WPS session.
alias WCN_SESSION_STATUS = int;
enum : int
{
    ///Indicates that the session is successful.
    WCN_SESSION_STATUS_SUCCESS         = 0x00000000,
    WCN_SESSION_STATUS_FAILURE_GENERIC = 0x00000001,
    WCN_SESSION_STATUS_FAILURE_TIMEOUT = 0x00000002,
}

// Structs


///The <b>WCN_VALUE_TYPE_PRIMARY_DEVICE_TYPE</b> structure contains information that identifies the device type by
///category, sub-category, and a manufacturer specific OUI (Organization ID).
struct WCN_VALUE_TYPE_PRIMARY_DEVICE_TYPE
{
align (1):
    ///Specifies the primary device type category. This data is supplied in network byte order. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WCN_VALUE_DT_CATEGORY_COMPUTER"></a><a
    ///id="wcn_value_dt_category_computer"></a><dl> <dt><b>WCN_VALUE_DT_CATEGORY_COMPUTER</b></dt> <dt>0x1</dt> </dl>
    ///</td> <td width="60%"> Indicates a computer. </td> </tr> <tr> <td width="40%"><a
    ///id="WCN_VALUE_DT_CATEGORY_INPUT_DEVICE"></a><a id="wcn_value_dt_category_input_device"></a><dl>
    ///<dt><b>WCN_VALUE_DT_CATEGORY_INPUT_DEVICE</b></dt> <dt>0x2</dt> </dl> </td> <td width="60%"> Indicates an input
    ///device. </td> </tr> <tr> <td width="40%"><a id="WCN_VALUE_DT_CATEGORY_PRINTER"></a><a
    ///id="wcn_value_dt_category_printer"></a><dl> <dt><b>WCN_VALUE_DT_CATEGORY_PRINTER</b></dt> <dt>0x3</dt> </dl>
    ///</td> <td width="60%"> Indicates a printer. </td> </tr> <tr> <td width="40%"><a
    ///id="WCN_VALUE_DT_CATEGORY_CAMERA"></a><a id="wcn_value_dt_category_camera"></a><dl>
    ///<dt><b>WCN_VALUE_DT_CATEGORY_CAMERA</b></dt> <dt>0x4</dt> </dl> </td> <td width="60%"> Indicates a camera. </td>
    ///</tr> <tr> <td width="40%"><a id="WCN_VALUE_DT_CATEGORY_STORAGE"></a><a
    ///id="wcn_value_dt_category_storage"></a><dl> <dt><b>WCN_VALUE_DT_CATEGORY_STORAGE</b></dt> <dt>0x5</dt> </dl>
    ///</td> <td width="60%"> Indicates a storage device. </td> </tr> <tr> <td width="40%"><a
    ///id="WCN_VALUE_DT_CATEGORY_NETWORK_INFRASTRUCTURE"></a><a
    ///id="wcn_value_dt_category_network_infrastructure"></a><dl>
    ///<dt><b>WCN_VALUE_DT_CATEGORY_NETWORK_INFRASTRUCTURE</b></dt> <dt>0x6</dt> </dl> </td> <td width="60%"> Indicates
    ///a network. </td> </tr> <tr> <td width="40%"><a id="WCN_VALUE_DT_CATEGORY_DISPLAY"></a><a
    ///id="wcn_value_dt_category_display"></a><dl> <dt><b>WCN_VALUE_DT_CATEGORY_DISPLAY</b></dt> <dt>0x7</dt> </dl>
    ///</td> <td width="60%"> Indicates a display. </td> </tr> <tr> <td width="40%"><a
    ///id="WCN_VALUE_DT_CATEGORY_MULTIMEDIA_DEVICE"></a><a id="wcn_value_dt_category_multimedia_device"></a><dl>
    ///<dt><b>WCN_VALUE_DT_CATEGORY_MULTIMEDIA_DEVICE</b></dt> <dt>0x8</dt> </dl> </td> <td width="60%"> Indicates a
    ///multimedia device. </td> </tr> <tr> <td width="40%"><a id="WCN_VALUE_DT_CATEGORY_GAMING_DEVICE"></a><a
    ///id="wcn_value_dt_category_gaming_device"></a><dl> <dt><b>WCN_VALUE_DT_CATEGORY_GAMING_DEVICE</b></dt>
    ///<dt>0x9</dt> </dl> </td> <td width="60%"> Indicates a gaming device. </td> </tr> <tr> <td width="40%"><a
    ///id="WCN_VALUE_DT_CATEGORY_TELEPHONE"></a><a id="wcn_value_dt_category_telephone"></a><dl>
    ///<dt><b>WCN_VALUE_DT_CATEGORY_TELEPHONE</b></dt> <dt>0xa</dt> </dl> </td> <td width="60%"> Indicates a telephone.
    ///</td> </tr> <tr> <td width="40%"><a id="WCN_VALUE_DT_CATEGORY_AUDIO_DEVICE"></a><a
    ///id="wcn_value_dt_category_audio_device"></a><dl> <dt><b>WCN_VALUE_DT_CATEGORY_AUDIO_DEVICE</b></dt> <dt>0xb</dt>
    ///</dl> </td> <td width="60%"> Indicates an audio device. <div class="alert"><b>Note</b> Only available in Windows
    ///8.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a id="WCN_VALUE_DT_CATEGORY_OTHER"></a><a
    ///id="wcn_value_dt_category_other"></a><dl> <dt><b>WCN_VALUE_DT_CATEGORY_OTHER</b></dt> <dt>0xff</dt> </dl> </td>
    ///<td width="60%"> Indicates an unspecified device. <div class="alert"><b>Note</b> Only available in Windows
    ///8.</div> <div> </div> </td> </tr> </table>
    ushort Category;
    ///Specifies the unique manufacturer OUI associated with the device. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="WCN_VALUE_DT_SUBTYPE_WIFI_OUI"></a><a
    ///id="wcn_value_dt_subtype_wifi_oui"></a><dl> <dt><b>WCN_VALUE_DT_SUBTYPE_WIFI_OUI</b></dt> <dt>0x50f204</dt> </dl>
    ///</td> <td width="60%"> Indicates the specific manufacturer Organization ID (OUI) for a wireless device. </td>
    ///</tr> </table>
    uint   SubCategoryOUI;
    ushort SubCategory;
}

///The <b>WCN_VENDOR_EXTENSION_SPEC</b> structure contains data that defines a vendor extension.
struct WCN_VENDOR_EXTENSION_SPEC
{
    ///Set this value to the SMI Enterprise ID Number of the vendor that defines the vendor extension. For example, the
    ///Microsoft ID is '311' (WCN_MICROSOFT_VENDOR_ID).
    uint VendorId;
    ///The subtype, as defined by the first two bytes of the vendor extension. If the vendor has not provided the
    ///two-byte subtype prefix, use WCN_NO_SUBTYPE.
    uint SubType;
    ///Distinguishes between multiple vendor extensions with the same VendorID and SubType. The index begins at zero.
    uint Index;
    uint Flags;
}

// Interfaces

@GUID("C100BEA7-D33A-4A4B-BF23-BBEF4663D017")
struct WCNDeviceObject;

///Use this interface to configure the device and initiate the session.
@GUID("C100BE9C-D33A-4A4B-BF23-BBEF4663D017")
interface IWCNDevice : IUnknown
{
    ///The <b>IWCNDevice::SetPassword</b> method configures the authentication method value, and if required, a password
    ///used for the pending session. This method may only be called prior to IWCNDevice::Connect.
    ///Params:
    ///    Type = A <b>WCN_PASSWORD_TYPE</b> value that specifies the authentication method used for the session. <table> <tr>
    ///           <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WCN_PASSWORD_TYPE_PUSH_BUTTON"></a><a
    ///           id="wcn_password_type_push_button"></a><dl> <dt><b>WCN_PASSWORD_TYPE_PUSH_BUTTON</b></dt> </dl> </td> <td
    ///           width="60%"> Use PushButton authentication. The value of <i>dwPasswordLength</i> must be <b>NULL</b>. </td>
    ///           </tr> <tr> <td width="40%"><a id="WCN_PASSWORD_TYPE_PIN"></a><a id="wcn_password_type_pin"></a><dl>
    ///           <dt><b>WCN_PASSWORD_TYPE_PIN</b></dt> </dl> </td> <td width="60%"> Use PIN-based authentication. </td> </tr>
    ///           </table>
    ///    dwPasswordLength = Number of bytes in the buffer <i>pbPassword</i>.
    ///    pbPassword = A byte array of the password, encoded in ASCII.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The password will be used for the
    ///    pending session. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The password type is WCN_PASSWORD_TYPE_PUSH_BUTTON and the password length is not zero. The
    ///    password type is not WCN_PASSWORD_TYPE_PUSH_BUTTON or WCN_PASSWORD_TYPE_PIN. </td> </tr> </table>
    ///    
    HRESULT SetPassword(WCN_PASSWORD_TYPE Type, uint dwPasswordLength, const(ubyte)* pbPassword);
    ///The <b>IWCNDevice::Connect</b> method initiates the session.
    ///Params:
    ///    pNotify = A pointer to the implemented IWCNConnectNotify callback interface which specifies if a connection has been
    ///              successfully established.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation has succeeded. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt> </dl> </td> <td
    ///    width="60%"> The device does not support the connection options queued via IWCNDevice::Set. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>WCN_E_PEER_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The device could not
    ///    be located on the network. </td> </tr> </table>
    ///    
    HRESULT Connect(IWCNConnectNotify pNotify);
    ///The <b>IWCNDevice::GetAttribute</b> method gets a cached attribute from the device.
    ///Params:
    ///    AttributeType = A <b>WCN_ATTRIBUTE_TYPE</b> value that represents a specific attribute value (for example,
    ///                    <b>WCN_PASSWORD_TYPE</b>).
    ///    dwMaxBufferSize = The allocated size, in bytes, of <i>pbBuffer</i>.
    ///    pbBuffer = A user-allocated buffer that, on successful return, contains the contents of the attribute.
    ///    pdwBufferUsed = On return, contains the size of the attribute in bytes.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The attribute was retrieved
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt>
    ///    </dl> </td> <td width="60%"> The attribute specified is not available. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER)</b></dt> </dl> </td> <td width="60%"> The buffer
    ///    specified by <i>pbBuffer</i> is not large enough to contain the returned attribute value. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetAttribute(WCN_ATTRIBUTE_TYPE AttributeType, uint dwMaxBufferSize, ubyte* pbBuffer, 
                         uint* pdwBufferUsed);
    ///The GetIntegerAttribute method gets a cached attribute from the device as an integer.
    ///Params:
    ///    AttributeType = A <b>WCN_ATTRIBUTE_TYPE</b> value that represents a specific attribute value (for example,
    ///                    <b>WCN_PASSWORD_TYPE</b>).
    ///    puInteger = Pointer to an unsigned-integer that represents the retrieved attribute value.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The attribute was retrieved
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt>
    ///    </dl> </td> <td width="60%"> The attribute specified is not available. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER)</b></dt> </dl> </td> <td width="60%"> The buffer
    ///    specified by <i>pbBuffer</i> is not large enough to contain the returned attribute value. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_DATATYPE)</b></dt> </dl> </td> <td width="60%">
    ///    This attribute cannot be expressed as an integer. For example, if it is a string. </td> </tr> </table>
    ///    
    HRESULT GetIntegerAttribute(WCN_ATTRIBUTE_TYPE AttributeType, uint* puInteger);
    ///The <b>IWCNDevice::GetStringAttribute</b> method gets a cached attribute from the device as a string.
    ///Params:
    ///    AttributeType = A <b>WCN_ATTRIBUTE_TYPE</b> value that represents a specific attribute value (for example,
    ///                    <b>WCN_PASSWORD_TYPE</b>). If the attribute is not natively a string data type (for example,
    ///                    <b>WCN_TYPE_VERSION</b> is natively an integer, and <b>WNC_TYPE_SSID</b> is natively a blob), this function
    ///                    will fail with <b>HRESULT_FROM_WIN32(ERROR_INVALID_DATATYPE)</b>.
    ///    cchMaxString = The size of the buffer <i>wszString</i>, in characters.
    ///    wszString = A user-allocated buffer that, on successful return, contains a <b>NULL</b>-terminated string value of the
    ///                vendor extension.
    ///Returns:
    ///    ... <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The attribute was retrieved successfully. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> The
    ///    attribute specified is not available. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER)</b></dt> </dl> </td> <td width="60%"> The buffer
    ///    specified by <i>wszString</i> is not large enough to contain the returned attribute value. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_DATATYPE)</b></dt> </dl> </td> <td width="60%">
    ///    This attribute cannot be expressed as a string. For example, if it is an integer. </td> </tr> </table>
    ///    
    HRESULT GetStringAttribute(WCN_ATTRIBUTE_TYPE AttributeType, uint cchMaxString, ushort* wszString);
    ///The <b>IWCNDevice::GetNetworkProfile</b> method gets a network profile from the device.
    ///Params:
    ///    cchMaxStringLength = The allocated size, in characters, of <i>wszProfile</i>.
    ///    wszProfile = A string that specifies the XML WLAN network profile type.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The network profile was successfully
    ///    retrieved. </td> </tr> </table>
    ///    
    HRESULT GetNetworkProfile(uint cchMaxStringLength, PWSTR wszProfile);
    ///The <b>IWCNDevice::SetNetworkProfile</b> method queues an XML WLAN profile to be provisioned to the device. This
    ///method may only be called prior to IWCNDevice::Connect.
    ///Params:
    ///    pszProfileXml = The XML WLAN profile XML string.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The attribute was retrieved
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</b></dt>
    ///    </dl> </td> <td width="60%"> The WLAN profile is not supported for WCN connections. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_BAD_PROFILE)</b></dt> </dl> </td> <td width="60%"> The
    ///    provided XML profile cannot be read. </td> </tr> </table>
    ///    
    HRESULT SetNetworkProfile(const(PWSTR) pszProfileXml);
    ///The <b>GetVendorExtension</b> method gets a cached vendor extension from the device.
    ///Params:
    ///    pVendorExtSpec = A pointer to a user-defined <b>WCN_VENDOR_EXTENSION_SPEC</b> structure that describes the vendor extension to
    ///                     query for.
    ///    dwMaxBufferSize = The size, in bytes, of <i>pbBuffer</i>.
    ///    pbBuffer = An allocated buffer that, on return, contains the contents of the vendor extension.
    ///    pdwBufferUsed = On return, contains the size of the vendor extension in bytes.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The vendor extension was retrieved
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</b></dt>
    ///    </dl> </td> <td width="60%"> The vendor extension specified is not available. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER)</b></dt> </dl> </td> <td width="60%">
    ///    The buffer specified by <i>pbBuffer</i> is not large enough to contain the returned vendor extension. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetVendorExtension(const(WCN_VENDOR_EXTENSION_SPEC)* pVendorExtSpec, uint dwMaxBufferSize, 
                               ubyte* pbBuffer, uint* pdwBufferUsed);
    ///The <b>IWCNDevice::SetVendorExtension</b> method queues a vendor extension for use in the pending session. This
    ///function may only be called prior to IWCNDevice::Connect.
    ///Params:
    ///    pVendorExtSpec = A pointer to a <b>WCN_VENDOR_EXTENSION_SPEC</b> structure that contains the vendor extension specification.
    ///    cbBuffer = The number of bytes contained in <i>pbBuffer</i>.
    ///    pbBuffer = Pointer to a buffer that contains the data to set in the vendor extension.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The vendor extension will be sent in
    ///    the pending session. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The specified <b>WCN_VENDOR_EXTENSION_SPEC</b> contains an illegal VendorID, sub-type, or flag.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_IMPLEMENTATION_LIMIT)</b></dt> </dl>
    ///    </td> <td width="60%"> The number of vendor extensions has exceeded the current implementation limit, which
    ///    is currently equal to 25 vendor extensions per session. </td> </tr> </table>
    ///    
    HRESULT SetVendorExtension(const(WCN_VENDOR_EXTENSION_SPEC)* pVendorExtSpec, uint cbBuffer, 
                               const(ubyte)* pbBuffer);
    ///The <b>IWCNDevice::Unadvise</b> method removes any callback previously set via IWCNDevice::Connect.
    ///Returns:
    ///    This method does not return a value.
    ///    
    HRESULT Unadvise();
    HRESULT SetNFCPasswordParams(WCN_PASSWORD_TYPE Type, uint dwOOBPasswordID, uint dwPasswordLength, 
                                 const(ubyte)* pbPassword, uint dwRemotePublicKeyHashLength, 
                                 const(ubyte)* pbRemotePublicKeyHash, uint dwDHKeyBlobLength, 
                                 const(ubyte)* pbDHKeyBlob);
}

///Use this interface to receive a success or failure notification when a Windows Connect Now connect session completes.
@GUID("C100BE9F-D33A-4A4B-BF23-BBEF4663D017")
interface IWCNConnectNotify : IUnknown
{
    ///The <b>IWCNConnectNotify::ConnectSucceeded</b> callback method that indicates a successful IWCNDevice::Connect
    ///operation.
    ///Returns:
    ///    ...
    ///    
    HRESULT ConnectSucceeded();
    ///The <b>IWCNConnectNotify::ConnectFailed</b> callback method indicates a IWCNDevice::Connect failure.
    ///Params:
    ///    hrFailure = An <b>HRESULT</b> that specifies the reason for the connection failure.
    ///Returns:
    ///    This method does not return a value.
    ///    
    HRESULT ConnectFailed(HRESULT hrFailure);
}


// GUIDs

const GUID CLSID_WCNDeviceObject = GUIDOF!WCNDeviceObject;

const GUID IID_IWCNConnectNotify = GUIDOF!IWCNConnectNotify;
const GUID IID_IWCNDevice        = GUIDOF!IWCNDevice;
