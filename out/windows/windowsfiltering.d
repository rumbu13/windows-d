// Written in the D programming language.

module windows.windowsfiltering;

public import windows.core;
public import windows.kernel : COMPARTMENT_ID, LUID;
public import windows.security : ACL, SEC_WINNT_AUTH_IDENTITY_W, SID,
                                 SID_AND_ATTRIBUTES;
public import windows.systemservices : BOOL, HANDLE, PSTR, PWSTR;
public import windows.winsock : SCOPE_ID, in6_addr, in_addr;
public import windows.windowsprogramming : FILETIME;

extern(Windows) @nogc nothrow:


// Enums


///The <b>FWP_DIRECTION</b> enumerated type specifies direction of network traffic.
alias FWP_DIRECTION = int;
enum : int
{
    ///Specifies outbound traffic.
    FWP_DIRECTION_OUTBOUND = 0x00000000,
    ///Specifies inbound traffic.
    FWP_DIRECTION_INBOUND  = 0x00000001,
    FWP_DIRECTION_MAX      = 0x00000002,
}

///The <b>FWP_IP_VERSION</b> enumerated type specifies the IP version.
alias FWP_IP_VERSION = int;
enum : int
{
    ///Specifies IPv4.
    FWP_IP_VERSION_V4   = 0x00000000,
    ///Specifies IPv6.
    FWP_IP_VERSION_V6   = 0x00000001,
    ///Reserved.
    FWP_IP_VERSION_NONE = 0x00000002,
    FWP_IP_VERSION_MAX  = 0x00000003,
}

///The <b>FWP_AF</b> enumerated type specifies the address family.
alias FWP_AF = int;
enum : int
{
    ///Specifies an address as an IPv4 address.
    FWP_AF_INET  = 0x00000000,
    ///Specifies an address as an IPv6 address.
    FWP_AF_INET6 = 0x00000001,
    ///Reserved.
    FWP_AF_ETHER = 0x00000002,
    ///Placeholder value to be used when the address family is not yet identified.
    FWP_AF_NONE  = 0x00000003,
}

///The <b>FWP_ETHER_ENCAP_METHOD</b> enumerated type specifies the method of encapsulating Ethernet II and SNAP traffic.
///Reserved.
alias FWP_ETHER_ENCAP_METHOD = int;
enum : int
{
    ///Specifies Ethernet V2 encapsulation.
    FWP_ETHER_ENCAP_METHOD_ETHER_V2        = 0x00000000,
    ///Specifies Subnet Access Protocol (SNAP) encapsulation with an unknown Organizationally Unique Identifier (OUI)
    ///and Service Access Point (SAP) prefix.
    FWP_ETHER_ENCAP_METHOD_SNAP            = 0x00000001,
    ///Specifies SNAP encapsulation with a recognized OUI and a SAP prefix of 03.AA.AA.00.00.00 + Ethertype.
    FWP_ETHER_ENCAP_METHOD_SNAP_W_OUI_ZERO = 0x00000003,
}

///The [FWP_VALUE0](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_value0) or an
///[FWP_CONDITION_VALUE0](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_condition_value0)structure.
alias FWP_DATA_TYPE = int;
enum : int
{
    ///Indicates no data.
    FWP_EMPTY                         = 0x00000000,
    ///Indicates an unsigned 8-bit integer value.
    FWP_UINT8                         = 0x00000001,
    ///Indicates an unsigned 16-bit integer value.
    FWP_UINT16                        = 0x00000002,
    ///Indicates an unsigned 32-bit integer value.
    FWP_UINT32                        = 0x00000003,
    ///Indicates an unsigned 64-bit integer value.
    FWP_UINT64                        = 0x00000004,
    ///Indicates an signed 8-bit integer value.
    FWP_INT8                          = 0x00000005,
    ///Indicates an signed 16-bit integer value.
    FWP_INT16                         = 0x00000006,
    ///Indicates an signed 32-bit integer value.
    FWP_INT32                         = 0x00000007,
    ///Indicates an signed 64-bit integer value.
    FWP_INT64                         = 0x00000008,
    ///Indicates a pointer to a single-precision floating-point value.
    FWP_FLOAT                         = 0x00000009,
    ///Indicates a pointer to a double-precision floating-point value.
    FWP_DOUBLE                        = 0x0000000a,
    ///Indicates a pointer to an [FWP_BYTE_ARRAY16](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_byte_array16)
    ///structure.
    FWP_BYTE_ARRAY16_TYPE             = 0x0000000b,
    ///Indicates a pointer to an [FWP_BYTE_BLOB](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_byte_blob) structure.
    FWP_BYTE_BLOB_TYPE                = 0x0000000c,
    ///Indicates a pointer to a SID.
    FWP_SID                           = 0x0000000d,
    ///Indicates a pointer to an [FWP_BYTE_BLOB](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_byte_blob) structure that
    ///describes a security descriptor.
    FWP_SECURITY_DESCRIPTOR_TYPE      = 0x0000000e,
    ///Indicates a pointer to an [FWP_BYTE_BLOB](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_byte_blob) structure that
    ///describes token information.
    FWP_TOKEN_INFORMATION_TYPE        = 0x0000000f,
    ///Indicates a pointer to an [FWP_BYTE_BLOB](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_byte_blob) structure that
    ///describes token access information.
    FWP_TOKEN_ACCESS_INFORMATION_TYPE = 0x00000010,
    ///Indicates a pointer to a null-terminated unicode string.
    FWP_UNICODE_STRING_TYPE           = 0x00000011,
    ///Reserved.
    FWP_BYTE_ARRAY6_TYPE              = 0x00000012,
    FWP_BITMAP_INDEX_TYPE             = 0x00000013,
    FWP_BITMAP_ARRAY64_TYPE           = 0x00000014,
    ///Reserved for future use.
    FWP_SINGLE_DATA_TYPE_MAX          = 0x000000ff,
    ///Indicates a pointer to an [FWP_V4_ADDR_AND_MASK](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_v4_addr_and_mask)
    ///structure.
    FWP_V4_ADDR_MASK                  = 0x00000100,
    ///Indicates a pointer to an [FWP_V6_ADDR_AND_MASK](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_v6_addr_and_mask)
    ///structure.
    FWP_V6_ADDR_MASK                  = 0x00000101,
    ///Indicates a pointer to an [FWP_RANGE0](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_range0) structure.
    FWP_RANGE_TYPE                    = 0x00000102,
    ///Maximum value for testing purposes.
    FWP_DATA_TYPE_MAX                 = 0x00000103,
}

///The <b>FWP_MATCH_TYPE</b> enumerated type specifies different match types allowed in filter conditions.
alias FWP_MATCH_TYPE = int;
enum : int
{
    ///Tests whether the value is equal to the condition value. All data types support <b>FWP_MATCH_EQUAL</b>.
    FWP_MATCH_EQUAL                  = 0x00000000,
    ///Tests whether the value is greater than the condition value. Only sortable data types support
    ///<b>FWP_MATCH_GREATER</b>. Sortable data types consist of all integer types, FWP_BYTE_ARRAY16_TYPE,
    ///FWP_BYTE_BLOB_TYPE, and FWP_UNICODE_STRING_TYPE.
    FWP_MATCH_GREATER                = 0x00000001,
    ///Tests whether the value is less than the condition value. Only sortable data types support <b>FWP_MATCH_LESS</b>.
    FWP_MATCH_LESS                   = 0x00000002,
    ///Tests whether the value is greater than or equal to the condition value. Only sortable data types support
    ///<b>FWP_MATCH_GREATER_OR_EQUAL</b>.
    FWP_MATCH_GREATER_OR_EQUAL       = 0x00000003,
    ///Tests whether the value is less than or equal to the condition value. Only sortable data types support
    ///<b>FWP_MATCH_LESS_OR_EQUAL</b>.
    FWP_MATCH_LESS_OR_EQUAL          = 0x00000004,
    ///Tests whether the value is within a given range of condition values. Only sortable data types support
    ///<b>FWP_MATCH_RANGE</b>.
    FWP_MATCH_RANGE                  = 0x00000005,
    ///Tests whether all flags are set. Only unsigned integer data types support <b>FWP_MATCH_FLAGS_ALL_SET</b>.
    FWP_MATCH_FLAGS_ALL_SET          = 0x00000006,
    ///Tests whether any flags are set. Only unsigned integer data types support <b>FWP_MATCH_FLAGS_ANY_SET</b>.
    FWP_MATCH_FLAGS_ANY_SET          = 0x00000007,
    ///Tests whether no flags are set. Only unsigned integer data types support <b>FWP_MATCH_FLAGS_NONE_SET</b>.
    FWP_MATCH_FLAGS_NONE_SET         = 0x00000008,
    ///Tests whether the value is equal to the condition value. The test is case insensitive. Only the
    ///FWP_UNICODE_STRING_TYPE data type supports <b>FWP_MATCH_EQUAL_CASE_INSENSITIVE</b>.
    FWP_MATCH_EQUAL_CASE_INSENSITIVE = 0x00000009,
    ///Tests whether the value is not equal to the condition value. Only sortable data types support
    ///<b>FWP_MATCH_NOT_EQUAL</b>.<div class="alert"><b>Note</b> Available only in Windows 7 and Windows Server 2008
    ///R2.</div> <div> </div>
    FWP_MATCH_NOT_EQUAL              = 0x0000000a,
    FWP_MATCH_PREFIX                 = 0x0000000b,
    FWP_MATCH_NOT_PREFIX             = 0x0000000c,
    ///Maximum value for testing purposes.
    FWP_MATCH_TYPE_MAX               = 0x0000000d,
}

///The <b>FWP_CLASSIFY_OPTION_TYPE</b> enumerated type is used by callouts and shims during run-time classification.
///<b>FWP_CLASSIFY_OPTION_TYPE</b> specifies timeout options for unicast, multicast, and loose source mapping states and
///enables blocking or permission of state creation on outbound multicast and broadcast traffic.
alias FWP_CLASSIFY_OPTION_TYPE = int;
enum : int
{
    ///Specifies the multicast conditions on outbound traffic. See
    ///[FWPM_CLASSIFY_OPTION0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_classify_option0) for possible values.
    FWP_CLASSIFY_OPTION_MULTICAST_STATE                    = 0x00000000,
    ///Specifies the source mapping conditions for callout filters. See
    ///[FWPM_CLASSIFY_OPTION0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_classify_option0) for possible values.
    ///Loose source mapping allows unicast responses from a remote peer to match only the port number, instead of the
    ///entire source address.
    FWP_CLASSIFY_OPTION_LOOSE_SOURCE_MAPPING               = 0x00000001,
    ///Specifies the unicast state lifetime, in seconds.
    FWP_CLASSIFY_OPTION_UNICAST_LIFETIME                   = 0x00000002,
    ///Specifies the multicast/broadcast state lifetime, in seconds.
    FWP_CLASSIFY_OPTION_MCAST_BCAST_LIFETIME               = 0x00000003,
    ///Specifies that the callout can set secure socket settings on the endpoint. Such flags are only allowed to
    ///increase the overall security level. The possible values are defined in the <i>Mstcpip.h</i> header file. <table>
    ///<tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>SOCKET_SETTINGS_GUARANTEE_ENCRYPTION 0x00000001 </td>
    ///<td>Indicates that guaranteed encryption of traffic is required. This flag should be set if the default policy
    ///prefers methods of protection that do not use encryption. If this flag is set and encryption is not possible for
    ///any reason, no packets will be sent and a connection will not be established.</td> </tr> <tr>
    ///<td>SOCKET_SETTINGS_ALLOW_INSECURE 0x00000002 </td> <td>Indicates that clear text connections are allowed. If
    ///this flag is set, some or all of the sent packets will be sent in clear text, especially if security with the
    ///peer could not be negotiated.<div class="alert"><b>Note</b> If this flag is not set, it is guaranteed that
    ///packets will never be sent in clear text, even if security negotiation fails.</div> <div> </div> </td> </tr>
    ///</table> <div class="alert"><b>Note</b> Available only in Windows 7, Windows Server 2008 R2, and later.</div>
    ///<div> </div>
    FWP_CLASSIFY_OPTION_SECURE_SOCKET_SECURITY_FLAGS       = 0x00000004,
    ///Allows the callout to specify the specific main mode (MM) policy used for the connection. <div
    ///class="alert"><b>Note</b> Available only in Windows 7, Windows Server 2008 R2, and later.</div> <div> </div>
    FWP_CLASSIFY_OPTION_SECURE_SOCKET_AUTHIP_MM_POLICY_KEY = 0x00000005,
    ///Allows the callout to specify the specific quick mode (QM) policy used for the connection. <div
    ///class="alert"><b>Note</b> Available only in Windows 7, Windows Server 2008 R2, and later.</div> <div> </div>
    FWP_CLASSIFY_OPTION_SECURE_SOCKET_AUTHIP_QM_POLICY_KEY = 0x00000006,
    FWP_CLASSIFY_OPTION_LOCAL_ONLY_MAPPING                 = 0x00000007,
    ///Maximum value for testing purposes.
    FWP_CLASSIFY_OPTION_MAX                                = 0x00000008,
}

///The <b>FWP_VSWITCH_NETWORK_TYPE</b> enumeration specifies the network type of a vSwitch.
alias FWP_VSWITCH_NETWORK_TYPE = int;
enum : int
{
    ///Specifies an unknown network type.
    FWP_VSWITCH_NETWORK_TYPE_UNKNOWN  = 0x00000000,
    ///Specifies a private network.
    FWP_VSWITCH_NETWORK_TYPE_PRIVATE  = 0x00000001,
    ///Specifies an internal network.
    FWP_VSWITCH_NETWORK_TYPE_INTERNAL = 0x00000002,
    FWP_VSWITCH_NETWORK_TYPE_EXTERNAL = 0x00000003,
}

///The <b>FWP_FILTER_ENUM_TYPE</b> enumerated type specifies how the filter enum conditions should be interpreted.
alias FWP_FILTER_ENUM_TYPE = int;
enum : int
{
    ///Return only filters that fully contain the enum conditions.
    FWP_FILTER_ENUM_FULLY_CONTAINED = 0x00000000,
    ///Return filters that overlap with the enum conditions, including filters that fully contain the enum conditions.
    FWP_FILTER_ENUM_OVERLAPPING     = 0x00000001,
    FWP_FILTER_ENUM_TYPE_MAX        = 0x00000002,
}

///The <b>IKEEXT_KEY_MODULE_TYPE</b> enumerated type specifies the type of keying module.
alias IKEEXT_KEY_MODULE_TYPE = int;
enum : int
{
    ///Specifies Internet Key Exchange (IKE) keying module.
    IKEEXT_KEY_MODULE_IKE    = 0x00000000,
    ///Specifies Authenticated Internet Protocol (AuthIP) keying module.
    IKEEXT_KEY_MODULE_AUTHIP = 0x00000001,
    ///Specifies Internet Key Exchange version 2 (IKEv2) keying module. Available only on Windows 7, Windows Server 2008
    ///R2, and later.
    IKEEXT_KEY_MODULE_IKEV2  = 0x00000002,
    ///Maximum value for testing purposes.
    IKEEXT_KEY_MODULE_MAX    = 0x00000003,
}

///The <b>IKEEXT_AUTHENTICATION_METHOD_TYPE</b> enumerated type specifies the type of authentication method used by
///Internet Key Exchange (IKE), Authenticated Internet Protocol (AuthIP), or IKEv2..
alias IKEEXT_AUTHENTICATION_METHOD_TYPE = int;
enum : int
{
    ///Specifies pre-shared key authentication method. Available only for IKE.
    IKEEXT_PRESHARED_KEY                  = 0x00000000,
    ///Specifies certificate authentication method. Available only for IKE and IKEv2.
    IKEEXT_CERTIFICATE                    = 0x00000001,
    ///Specifies Kerberos authentication method.
    IKEEXT_KERBEROS                       = 0x00000002,
    ///Specifies anonymous authentication method. Available only for AuthIP.
    IKEEXT_ANONYMOUS                      = 0x00000003,
    ///Specifies Secure Sockets Layer (SSL) authentication method. Available only for AuthIP.
    IKEEXT_SSL                            = 0x00000004,
    ///Specifies Microsoft Windows NT LAN Manager (NTLM) V2 authentication method. Available only for AuthIP.
    IKEEXT_NTLM_V2                        = 0x00000005,
    ///Specifies IPv6 Cryptographically Generated Addresses (CGA) authentication method. Available only for IKE.
    IKEEXT_IPV6_CGA                       = 0x00000006,
    ///Specifies Elliptic Curve Digital Signature Algorithm (ECDSA) 256 certificate authentication method. Available
    ///only for IKE and IKEv2. <div class="alert"><b>Note</b> Available only on Windows Server 2008, Windows Vista with
    ///SP1, and later.</div> <div> </div>
    IKEEXT_CERTIFICATE_ECDSA_P256         = 0x00000007,
    ///Specifies ECDSA-384 certificate authentication method. Available only for IKE and IKEv2. <div
    ///class="alert"><b>Note</b> Available only on Windows Server 2008, Windows Vista with SP1, and later.</div> <div>
    ///</div>
    IKEEXT_CERTIFICATE_ECDSA_P384         = 0x00000008,
    ///Specifies ECDSA-256 SSL authentication method. Available only for AuthIP. <div class="alert"><b>Note</b>
    ///Available only on Windows Server 2008, Windows Vista with SP1, and later.</div> <div> </div>
    IKEEXT_SSL_ECDSA_P256                 = 0x00000009,
    ///Specifies ECDSA-384 SSL authentication method. Available only for AuthIP. <div class="alert"><b>Note</b>
    ///Available only on Windows Server 2008, Windows Vista with SP1, and later.</div> <div> </div>
    IKEEXT_SSL_ECDSA_P384                 = 0x0000000a,
    ///Specifies Extensible Authentication Protocol (EAP) authentication method. Available only for IKEv2. <div
    ///class="alert"><b>Note</b> Available only on Windows Server 2008 R2, Windows 7, and later.</div> <div> </div>
    IKEEXT_EAP                            = 0x0000000b,
    ///Reserved. Do not use. <div class="alert"><b>Note</b> Available only on Windows Server 2012, Windows 8, and
    ///later.</div> <div> </div>
    IKEEXT_RESERVED                       = 0x0000000c,
    ///Maximum value for testing purposes.
    IKEEXT_AUTHENTICATION_METHOD_TYPE_MAX = 0x0000000d,
}

///The <b>IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE</b> enumerated type specifies the type of impersonation to perform
///when Authenticated Internet Protocol (AuthIP) is used for authentication.
alias IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE = int;
enum : int
{
    ///Specifies no impersonation.
    IKEEXT_IMPERSONATION_NONE             = 0x00000000,
    ///Specifies socket principal impersonation.
    IKEEXT_IMPERSONATION_SOCKET_PRINCIPAL = 0x00000001,
    ///Maximum value for testing purposes.
    IKEEXT_IMPERSONATION_MAX              = 0x00000002,
}

///The <b>IKEEXT_CERT_CONFIG_TYPE</b> enumerated type indicates a type of certificate configuration.
alias IKEEXT_CERT_CONFIG_TYPE = int;
enum : int
{
    ///An explicit trust list will be used for authentication.
    IKEEXT_CERT_CONFIG_EXPLICIT_TRUST_LIST = 0x00000000,
    ///The enterprise store will be used as the trust list for authentication.
    IKEEXT_CERT_CONFIG_ENTERPRISE_STORE    = 0x00000001,
    ///The trusted root CA store will be used as the trust list for authentication.
    IKEEXT_CERT_CONFIG_TRUSTED_ROOT_STORE  = 0x00000002,
    ///No certificate authentication in the direction (inbound or outbound) specified by the configuration. Available
    ///only on Windows 7, Windows Server 2008 R2, and later.
    IKEEXT_CERT_CONFIG_UNSPECIFIED         = 0x00000003,
    ///Maximum value for testing purposes.
    IKEEXT_CERT_CONFIG_TYPE_MAX            = 0x00000004,
}

///The <b>IKEEXT_CERT_CRITERIA_NAME_TYPE</b> enumerated type specifies the type of NAME fields possible for a
///certificate selection "subject" criteria.
alias IKEEXT_CERT_CRITERIA_NAME_TYPE = int;
enum : int
{
    ///DNS name in the Subject Alternative Name of the certificate.
    IKEEXT_CERT_CRITERIA_DNS           = 0x00000000,
    ///UPN name in the Subject Alternative Name of the certificate.
    IKEEXT_CERT_CRITERIA_UPN           = 0x00000001,
    ///RFC 822 name in the Subject Alternative Name of the certificate.
    IKEEXT_CERT_CRITERIA_RFC822        = 0x00000002,
    ///CN in the Subject of the certificate.
    IKEEXT_CERT_CRITERIA_CN            = 0x00000003,
    ///OU in the Subject of the certificate.
    IKEEXT_CERT_CRITERIA_OU            = 0x00000004,
    ///O in the Subject of the certificate.
    IKEEXT_CERT_CRITERIA_O             = 0x00000005,
    ///DC in the Subject of the certificate.
    IKEEXT_CERT_CRITERIA_DC            = 0x00000006,
    IKEEXT_CERT_CRITERIA_NAME_TYPE_MAX = 0x00000007,
}

///The <b>IKEEXT_CIPHER_TYPE</b> enumerated type specifies the type of encryption algorithm used for encrypting the
///Internet Key Exchange (IKE) and Authenticated Internet Protocol (AuthIP) messages.
alias IKEEXT_CIPHER_TYPE = int;
enum : int
{
    ///Specifies DES encryption.
    IKEEXT_CIPHER_DES               = 0x00000000,
    ///Specifies 3DES encryption.
    IKEEXT_CIPHER_3DES              = 0x00000001,
    ///Specifies AES-128 encryption.
    IKEEXT_CIPHER_AES_128           = 0x00000002,
    ///Specifies AES-192 encryption.
    IKEEXT_CIPHER_AES_192           = 0x00000003,
    ///Specifies AES-256 encryption.
    IKEEXT_CIPHER_AES_256           = 0x00000004,
    IKEEXT_CIPHER_AES_GCM_128_16ICV = 0x00000005,
    IKEEXT_CIPHER_AES_GCM_256_16ICV = 0x00000006,
    ///Maximum value for testing purposes.
    IKEEXT_CIPHER_TYPE_MAX          = 0x00000007,
}

///The <b>IKEEXT_INTEGRITY_TYPE</b> enumerated type specifies the type of hash algorithm used for integrity protection
///of Internet Key Exchange (IKE) and Authenticated Internet Protocol (AuthIP) messages.
alias IKEEXT_INTEGRITY_TYPE = int;
enum : int
{
    ///Specifies MD5 hash algorithm.
    IKEEXT_INTEGRITY_MD5      = 0x00000000,
    ///Specifies SHA1 hash algorithm.
    IKEEXT_INTEGRITY_SHA1     = 0x00000001,
    ///Specifies a 256-bit SHA encryption. <div class="alert"><b>Note</b> Available only on Windows Server 2008, Windows
    ///Vista with SP1, and later.</div> <div> </div>
    IKEEXT_INTEGRITY_SHA_256  = 0x00000002,
    ///Specifies a 384-bit SHA encryption. <div class="alert"><b>Note</b> Available only on Windows Server 2008, Windows
    ///Vista with SP1, and later.</div> <div> </div>
    IKEEXT_INTEGRITY_SHA_384  = 0x00000003,
    ///Maximum value for testing purposes.
    IKEEXT_INTEGRITY_TYPE_MAX = 0x00000004,
}

///The <b>IKEEXT_DH_GROUP</b> enumerated type specifies the type of Diffie Hellman group used for Internet Key Exchange
///(IKE) and Authenticated Internet Protocol (AuthIP) key generation.
alias IKEEXT_DH_GROUP = int;
enum : int
{
    ///Specifies no Diffie Hellman group. Available only for AuthIP.
    IKEEXT_DH_GROUP_NONE = 0x00000000,
    ///Specifies Diffie Hellman group 1.
    IKEEXT_DH_GROUP_1    = 0x00000001,
    ///Specifies Diffie Hellman group 2.
    IKEEXT_DH_GROUP_2    = 0x00000002,
    ///Specifies Diffie Hellman group 14. <div class="alert"><b>Note</b> Available only for Windows 8 and Windows Server
    ///2012. </div> <div> </div>
    IKEEXT_DH_GROUP_14   = 0x00000003,
    ///Specifies Diffie Hellman group 14. <div class="alert"><b>Note</b> This group was called Diffie Hellman group 2048
    ///when it was introduced. The name has since been changed to match standard terminology.</div> <div> </div>
    IKEEXT_DH_GROUP_2048 = 0x00000003,
    ///Specifies Diffie Hellman ECP group 256.
    IKEEXT_DH_ECP_256    = 0x00000004,
    ///Specifies Diffie Hellman ECP group 384.
    IKEEXT_DH_ECP_384    = 0x00000005,
    ///Specifies Diffie Hellman group 24. <div class="alert"><b>Note</b> Available only for Windows 8 and Windows Server
    ///2012.</div> <div> </div>
    IKEEXT_DH_GROUP_24   = 0x00000006,
    ///Maximum value for testing purposes.
    IKEEXT_DH_GROUP_MAX  = 0x00000007,
}

///The <b>IKEEXT_MM_SA_STATE</b> enumerated type defines the states for the Main Mode (MM) negotiation exchanges that
///are part of the Authenticated Internet Protocol (AuthIP) and Internet Key Exchange (IKE) protocols.
alias IKEEXT_MM_SA_STATE = int;
enum : int
{
    ///Initial state. No packets have been sent to the peer.
    IKEEXT_MM_SA_STATE_NONE       = 0x00000000,
    ///First packet has been sent to the peer
    IKEEXT_MM_SA_STATE_SA_SENT    = 0x00000001,
    ///Second packet has been sent to the peer, for SSPI authentication.
    IKEEXT_MM_SA_STATE_SSPI_SENT  = 0x00000002,
    ///Third packet has been sent to the peer.
    IKEEXT_MM_SA_STATE_FINAL      = 0x00000003,
    ///Final packet has been sent to the peer.
    IKEEXT_MM_SA_STATE_FINAL_SENT = 0x00000004,
    ///MM has been completed.
    IKEEXT_MM_SA_STATE_COMPLETE   = 0x00000005,
    ///Maximum value for testing purposes.
    IKEEXT_MM_SA_STATE_MAX        = 0x00000006,
}

///The <b>IKEEXT_QM_SA_STATE</b> enumerated type defines the states for the Quick Mode (QM) negotiation exchanges that
///are part of the Authenticated Internet Protocol (AuthIP) and Internet Key Exchange (IKE) protocols.
alias IKEEXT_QM_SA_STATE = int;
enum : int
{
    ///Initial state. No QM packets have been sent to the peer.
    IKEEXT_QM_SA_STATE_NONE     = 0x00000000,
    ///First packet has been sent to the peer.
    IKEEXT_QM_SA_STATE_INITIAL  = 0x00000001,
    ///Final packet has been sent to the peer.
    IKEEXT_QM_SA_STATE_FINAL    = 0x00000002,
    ///QM has been completed.
    IKEEXT_QM_SA_STATE_COMPLETE = 0x00000003,
    ///Maximum value for testing purposes.
    IKEEXT_QM_SA_STATE_MAX      = 0x00000004,
}

///The <b>IKEEXT_EM_SA_STATE</b> enumerated type defines the states for the Extended Mode (EM) negotiation exchanges
///that are part of the Authenticated Internet Protocol (AuthIP) protocol.
alias IKEEXT_EM_SA_STATE = int;
enum : int
{
    ///Initial state. No Extended Mode packets have been sent to the peer.
    IKEEXT_EM_SA_STATE_NONE          = 0x00000000,
    ///First packet has been sent to the peer.
    IKEEXT_EM_SA_STATE_SENT_ATTS     = 0x00000001,
    ///Second packet has been sent to the peer.
    IKEEXT_EM_SA_STATE_SSPI_SENT     = 0x00000002,
    ///Third packet has been sent to the peer.
    IKEEXT_EM_SA_STATE_AUTH_COMPLETE = 0x00000003,
    ///Final packet has been sent to the peer.
    IKEEXT_EM_SA_STATE_FINAL         = 0x00000004,
    ///Extended mode has been completed.
    IKEEXT_EM_SA_STATE_COMPLETE      = 0x00000005,
    ///Maximum value for testing purposes.
    IKEEXT_EM_SA_STATE_MAX           = 0x00000006,
}

///The <b>IKEEXT_SA_ROLE</b> enumerated type defines the security association (SA) role for Internet Key Exchange (IKE)
///and Authenticated Internet Protocol (AuthIP) Main Mode or Quick Mode negotiations.
alias IKEEXT_SA_ROLE = int;
enum : int
{
    ///SA is the initiator.
    IKEEXT_SA_ROLE_INITIATOR = 0x00000000,
    ///SA is the responder.
    IKEEXT_SA_ROLE_RESPONDER = 0x00000001,
    ///Maximum value for testing purposes.
    IKEEXT_SA_ROLE_MAX       = 0x00000002,
}

///The <b>IPSEC_TRANSFORM_TYPE</b> enumerated type indicates the type of an IPsec security association (SA) transform.
alias IPSEC_TRANSFORM_TYPE = int;
enum : int
{
    ///Specifies Authentication Header (AH) transform.
    IPSEC_TRANSFORM_AH                  = 0x00000001,
    ///Specifies Encapsulating Security Payload (ESP) authentication-only transform.
    IPSEC_TRANSFORM_ESP_AUTH            = 0x00000002,
    ///Specifies ESP cipher transform.
    IPSEC_TRANSFORM_ESP_CIPHER          = 0x00000003,
    ///Specifies ESP authentication and cipher transform.
    IPSEC_TRANSFORM_ESP_AUTH_AND_CIPHER = 0x00000004,
    ///Specifies that the first packet should be sent twice: once with ESP/AH encapsulation, and once in clear text. The
    ///entire session is then sent in clear text. The initial packet will allow the existing firewall rules to apply to
    ///the connection. The subsequent clear text data stream allows intermediaries to modify the stream. <div
    ///class="alert"><b>Note</b> Available only on Windows Server 2008 R2, Windows 7, or later.</div> <div> </div>
    IPSEC_TRANSFORM_ESP_AUTH_FW         = 0x00000005,
    ///Maximum value for testing only.
    IPSEC_TRANSFORM_TYPE_MAX            = 0x00000006,
}

///The <b>IPSEC_AUTH_TYPE</b> enumerated type indicates the type of hash algorithm used in an IPsec SA for data origin
///authentication and integrity protection.
alias IPSEC_AUTH_TYPE = int;
enum : int
{
    ///Specifies MD5 hash algorithm. See RFC 1321 for further information.
    IPSEC_AUTH_MD5     = 0x00000000,
    ///Specifies SHA 1 hash algorithm. See NIST, FIPS PUB 180-1 for more information.
    IPSEC_AUTH_SHA_1   = 0x00000001,
    ///Specifies SHA 256 hash algorithm. See NIST, Draft FIPS PUB 180-2 for more information. <div
    ///class="alert"><b>Note</b> Available only on Windows Server 2008, Windows Vista with SP1, and later.</div> <div>
    ///</div>
    IPSEC_AUTH_SHA_256 = 0x00000002,
    ///Specifies 128-bit AES hash algorithm. <div class="alert"><b>Note</b> Available only on Windows Server 2008,
    ///Windows Vista with SP1, and later.</div> <div> </div>
    IPSEC_AUTH_AES_128 = 0x00000003,
    ///Specifies 192-bit AES hash algorithm. <div class="alert"><b>Note</b> Available only on Windows Server 2008,
    ///Windows Vista with SP1, and later.</div> <div> </div>
    IPSEC_AUTH_AES_192 = 0x00000004,
    ///Specifies 256-bit AES hash algorithm. <div class="alert"><b>Note</b> Available only on Windows Server 2008,
    ///Windows Vista with SP1, and later.</div> <div> </div>
    IPSEC_AUTH_AES_256 = 0x00000005,
    IPSEC_AUTH_MAX     = 0x00000006,
}

///The <b>IPSEC_CIPHER_TYPE</b> enumerated type indicates the type of encryption algorithm used in an IPsec SA for data
///privacy.
alias IPSEC_CIPHER_TYPE = int;
enum : int
{
    ///Specifies DES encryption.
    IPSEC_CIPHER_TYPE_DES     = 0x00000001,
    ///Specifies 3DES encryption.
    IPSEC_CIPHER_TYPE_3DES    = 0x00000002,
    ///Specifies AES-128 encryption.
    IPSEC_CIPHER_TYPE_AES_128 = 0x00000003,
    ///Specifies AES-192 encryption.
    IPSEC_CIPHER_TYPE_AES_192 = 0x00000004,
    ///Specifies AES-256 encryption.
    IPSEC_CIPHER_TYPE_AES_256 = 0x00000005,
    ///Maximum value for testing only.
    IPSEC_CIPHER_TYPE_MAX     = 0x00000006,
}

///The <b>IPSEC_PFS_GROUP</b> enumerated type specifies the Diffie Hellman algorithm that should be used for Quick Mode
///PFS (Perfect Forward Secrecy).
alias IPSEC_PFS_GROUP = int;
enum : int
{
    ///Specifies no Quick Mode PFS.
    IPSEC_PFS_NONE    = 0x00000000,
    ///Specifies Diffie Hellman group 1.
    IPSEC_PFS_1       = 0x00000001,
    ///Specifies Diffie Hellman group 2.
    IPSEC_PFS_2       = 0x00000002,
    ///Specifies Diffie Hellman group 14.
    IPSEC_PFS_2048    = 0x00000003,
    ///Specifies Diffie Hellman group 14. <div class="alert"><b>Note</b> This group was called Diffie Hellman group 2048
    ///when it was introduced. The name has since been changed to match standard terminology.</div> <div> </div> <div
    ///class="alert"><b>Note</b> Available only for Windows 8 and Windows Server 2012. </div> <div> </div>
    IPSEC_PFS_14      = 0x00000003,
    ///Specifies Diffie Hellman ECP group 256.
    IPSEC_PFS_ECP_256 = 0x00000004,
    ///Specifies Diffie Hellman ECP group 384.
    IPSEC_PFS_ECP_384 = 0x00000005,
    ///Use the same Diffie Hellman as the main mode that contains this quick mode.
    IPSEC_PFS_MM      = 0x00000006,
    ///Specifies Diffie Hellman group 24. <div class="alert"><b>Note</b> Available only for Windows 8 and Windows Server
    ///2012.</div> <div> </div>
    IPSEC_PFS_24      = 0x00000007,
    ///Maximum value for testing only.
    IPSEC_PFS_MAX     = 0x00000008,
}

///The <b>IPSEC_TOKEN_TYPE</b> enumerated type specifies an IPsec token type.
alias IPSEC_TOKEN_TYPE = int;
enum : int
{
    ///Machine token.
    IPSEC_TOKEN_TYPE_MACHINE       = 0x00000000,
    ///Impersonation token.
    IPSEC_TOKEN_TYPE_IMPERSONATION = 0x00000001,
    ///Maximum value for testing only.
    IPSEC_TOKEN_TYPE_MAX           = 0x00000002,
}

///The <b>IPSEC_TOKEN_PRINCIPAL</b> enumerated type specifies an access token principal.
alias IPSEC_TOKEN_PRINCIPAL = int;
enum : int
{
    ///The principal for the IPsec access token is "Local".
    IPSEC_TOKEN_PRINCIPAL_LOCAL = 0x00000000,
    ///The principal for the IPsec access token is "Peer".
    IPSEC_TOKEN_PRINCIPAL_PEER  = 0x00000001,
    ///Maximum value for testing only.
    IPSEC_TOKEN_PRINCIPAL_MAX   = 0x00000002,
}

///The <b>IPSEC_TOKEN_MODE</b> enumerated type specifies different IPsec modes in which a token can be obtained.
alias IPSEC_TOKEN_MODE = int;
enum : int
{
    ///Token was obtained in main mode.
    IPSEC_TOKEN_MODE_MAIN     = 0x00000000,
    ///Token was obtained in extended mode.
    IPSEC_TOKEN_MODE_EXTENDED = 0x00000001,
    ///Maximum value for testing only.
    IPSEC_TOKEN_MODE_MAX      = 0x00000002,
}

///The <b>IPSEC_TRAFFIC_TYPE</b> enumerated type specifies the type of IPsec traffic being described.
alias IPSEC_TRAFFIC_TYPE = int;
enum : int
{
    ///Specifies transport traffic.
    IPSEC_TRAFFIC_TYPE_TRANSPORT = 0x00000000,
    ///Specifies tunnel traffic.
    IPSEC_TRAFFIC_TYPE_TUNNEL    = 0x00000001,
    ///Maximum value for testing only.
    IPSEC_TRAFFIC_TYPE_MAX       = 0x00000002,
}

///The <b>IPSEC_SA_CONTEXT_EVENT_TYPE0</b> enumeration specifies the type of IPsec security association (SA) context
///change event.
alias IPSEC_SA_CONTEXT_EVENT_TYPE0 = int;
enum : int
{
    ///A new IPsec SA context was added.
    IPSEC_SA_CONTEXT_EVENT_ADD    = 0x00000001,
    ///An IPsec SA context was deleted.
    IPSEC_SA_CONTEXT_EVENT_DELETE = 0x00000002,
    ///Maximum value for testing purposes.
    IPSEC_SA_CONTEXT_EVENT_MAX    = 0x00000003,
}

///The <b>IPSEC_FAILURE_POINT</b> enumerated type specifies at what point IPsec has failed.
alias IPSEC_FAILURE_POINT = int;
enum : int
{
    ///IPsec has not failed.
    IPSEC_FAILURE_NONE      = 0x00000000,
    ///The local system is the failure point.
    IPSEC_FAILURE_ME        = 0x00000001,
    ///A peer system is the failure point.
    IPSEC_FAILURE_PEER      = 0x00000002,
    ///Maximum value for testing only.
    IPSEC_FAILURE_POINT_MAX = 0x00000003,
}

///The DL_ADDRESS_TYPE enumerated type specifies the type of datalink layer address.
alias DL_ADDRESS_TYPE = int;
enum : int
{
    ///Specifies a unicast datalink layer address.
    DlUnicast   = 0x00000000,
    ///Specifies a multicast datalink layer address.
    DlMulticast = 0x00000001,
    ///Specifies a broadcast datalink layer address.
    DlBroadcast = 0x00000002,
}

///The <b>FWPM_CHANGE_TYPE</b> enumerated type is used when dispatching change notifications to subscribers.
alias FWPM_CHANGE_TYPE = int;
enum : int
{
    ///Specifies an add change notification.
    FWPM_CHANGE_ADD      = 0x00000001,
    ///Specifies a delete change notification.
    FWPM_CHANGE_DELETE   = 0x00000002,
    FWPM_CHANGE_TYPE_MAX = 0x00000003,
}

///The <b>FWPM_SERVICE_STATE</b> enumeration specifies the current state of the filter engine.
alias FWPM_SERVICE_STATE = int;
enum : int
{
    ///The filter engine is not running.
    FWPM_SERVICE_STOPPED       = 0x00000000,
    ///The filter engine is starting.
    FWPM_SERVICE_START_PENDING = 0x00000001,
    ///The filter engine is stopping.
    FWPM_SERVICE_STOP_PENDING  = 0x00000002,
    ///The filter engine is running.
    FWPM_SERVICE_RUNNING       = 0x00000003,
    ///Maximum value for testing purposes.
    FWPM_SERVICE_STATE_MAX     = 0x00000004,
}

///The <b>FWPM_ENGINE_OPTION</b> enumerated type specifies configurable options for the filter engine.
alias FWPM_ENGINE_OPTION = int;
enum : int
{
    ///The filter engine will collect WFP network events.
    FWPM_ENGINE_COLLECT_NET_EVENTS           = 0x00000000,
    ///The filter engine will collect WFP network events that match any supplied key words.
    FWPM_ENGINE_NET_EVENT_MATCH_ANY_KEYWORDS = 0x00000001,
    ///Reserved for internal use. <div class="alert"><b>Note</b> Available only in Windows Server 2008 R2, Windows 7,
    ///and later.</div> <div> </div>
    FWPM_ENGINE_NAME_CACHE                   = 0x00000002,
    ///Enables the connection monitoring feature and starts logging creation and deletion events (and notifying any
    ///subscribers). If the ETW operational log is already enabled, FwpmEngineGetOption0 will return showing the option
    ///as enabled. FwpmEngineSetOption0 can be used set the value (but fails with FWP_E_STILL_ON ERROR when attempting
    ///to disable it). <div class="alert"><b>Note</b> Available only in Windows 8 and Windows Server 2012.</div> <div>
    ///</div>
    FWPM_ENGINE_MONITOR_IPSEC_CONNECTIONS    = 0x00000003,
    ///Enables inbound or forward packet queuing independently. When enabled, the system is able to evenly distribute
    ///CPU load to multiple CPUs for site-to-site IPsec tunnel scenarios. <div class="alert"><b>Note</b> Available only
    ///in Windows 8 and Windows Server 2012.</div> <div> </div>
    FWPM_ENGINE_PACKET_QUEUING               = 0x00000004,
    ///Transactions lasting longer than this time (in milliseconds) will trigger a watchdog event. <div
    ///class="alert"><b>Note</b> Available only in Windows 8 and Windows Server 2012.</div> <div> </div>
    FWPM_ENGINE_TXN_WATCHDOG_TIMEOUT_IN_MSEC = 0x00000005,
    ///Maximum value for testing purposes.
    FWPM_ENGINE_OPTION_MAX                   = 0x00000006,
}

///The <b>FWPM_PROVIDER_CONTEXT_TYPE</b> enumerated type specifies types of provider contexts that may be stored in Base
///Filtering Engine (BFE).
alias FWPM_PROVIDER_CONTEXT_TYPE = int;
enum : int
{
    ///Specifies keying context type.
    FWPM_IPSEC_KEYING_CONTEXT              = 0x00000000,
    ///Specifies IPsec IKE quick mode transport context type.
    FWPM_IPSEC_IKE_QM_TRANSPORT_CONTEXT    = 0x00000001,
    ///Specifies IPsec IKE quick mode tunnel context type.
    FWPM_IPSEC_IKE_QM_TUNNEL_CONTEXT       = 0x00000002,
    ///Specifies IPsec AuthIP quick mode transport context type.
    FWPM_IPSEC_AUTHIP_QM_TRANSPORT_CONTEXT = 0x00000003,
    ///Specifies IPsec Authip quick mode tunnel context type.
    FWPM_IPSEC_AUTHIP_QM_TUNNEL_CONTEXT    = 0x00000004,
    ///Specifies IKE main mode context type.
    FWPM_IPSEC_IKE_MM_CONTEXT              = 0x00000005,
    ///Specifies AuthIP main mode context type.
    FWPM_IPSEC_AUTHIP_MM_CONTEXT           = 0x00000006,
    ///Specifies classify options context type.
    FWPM_CLASSIFY_OPTIONS_CONTEXT          = 0x00000007,
    ///Specifies general context type.
    FWPM_GENERAL_CONTEXT                   = 0x00000008,
    ///Specifies IKE v2 quick mode tunnel context type. <div class="alert"><b>Note</b> Available only in Windows Server
    ///2008 R2, Windows 7, and later.</div> <div> </div>
    FWPM_IPSEC_IKEV2_QM_TUNNEL_CONTEXT     = 0x00000009,
    ///Specifies IKE v2 main mode tunnel context type. <div class="alert"><b>Note</b> Available only in Windows Server
    ///2008 R2, Windows 7, and later.</div> <div> </div>
    FWPM_IPSEC_IKEV2_MM_CONTEXT            = 0x0000000a,
    ///Specifies IPsec DoS Protection context type. <div class="alert"><b>Note</b> Available only in Windows Server 2008
    ///R2, Windows 7, and later.</div> <div> </div>
    FWPM_IPSEC_DOSP_CONTEXT                = 0x0000000b,
    ///Specifies IKE v2 quick mode transport context type. <div class="alert"><b>Note</b> Available only in Windows 8
    ///and Windows 8.</div> <div> </div>
    FWPM_IPSEC_IKEV2_QM_TRANSPORT_CONTEXT  = 0x0000000c,
    ///Maximum value for testing purposes.
    FWPM_PROVIDER_CONTEXT_TYPE_MAX         = 0x0000000d,
}

///The <b>FWPM_FIELD_TYPE</b> enumerated type provides additional information about how the field's data should be
///interpreted.
alias FWPM_FIELD_TYPE = int;
enum : int
{
    ///Value contains raw data.
    FWPM_FIELD_RAW_DATA   = 0x00000000,
    ///Value contains an IP address.
    FWPM_FIELD_IP_ADDRESS = 0x00000001,
    ///Value contains flags. <div class="alert"><b>Note</b> Available only on Windows Server 2008, Windows Vista with
    ///SP1, and later.</div> <div> </div>
    FWPM_FIELD_FLAGS      = 0x00000002,
    FWPM_FIELD_TYPE_MAX   = 0x00000003,
}

///The <b>FWPM_NET_EVENT_TYPE</b> enumerated type specifies the type of net event.
alias FWPM_NET_EVENT_TYPE = int;
enum : int
{
    ///An IKE/AuthIP main mode failure has occurred.
    FWPM_NET_EVENT_TYPE_IKEEXT_MM_FAILURE  = 0x00000000,
    ///An IKE/AuthIP quick mode failure has occurred.
    FWPM_NET_EVENT_TYPE_IKEEXT_QM_FAILURE  = 0x00000001,
    ///An AuthIP extended mode failure has occurred.
    FWPM_NET_EVENT_TYPE_IKEEXT_EM_FAILURE  = 0x00000002,
    ///A drop event has occurred.
    FWPM_NET_EVENT_TYPE_CLASSIFY_DROP      = 0x00000003,
    ///An IPsec kernel drop event has occurred.
    FWPM_NET_EVENT_TYPE_IPSEC_KERNEL_DROP  = 0x00000004,
    ///An IPsec DoS Protection drop event has occurred. <div class="alert"><b>Note</b> Available only in Windows 7,
    ///Windows Server 2008 R2, and later.</div> <div> </div>
    FWPM_NET_EVENT_TYPE_IPSEC_DOSP_DROP    = 0x00000005,
    ///An allow event has occurred. <div class="alert"><b>Note</b> Available only in Windows 8 and Windows Server
    ///2012.</div> <div> </div>
    FWPM_NET_EVENT_TYPE_CLASSIFY_ALLOW     = 0x00000006,
    ///An app container network capability drop event has occurred. <div class="alert"><b>Note</b> Available only in
    ///Windows 8 and Windows Server 2012.</div> <div> </div>
    FWPM_NET_EVENT_TYPE_CAPABILITY_DROP    = 0x00000007,
    ///An app container network capability allow event has occurred. <div class="alert"><b>Note</b> Available only in
    ///Windows 8 and Windows Server 2012.</div> <div> </div>
    FWPM_NET_EVENT_TYPE_CAPABILITY_ALLOW   = 0x00000008,
    ///A MAC layer drop event has occurred. <div class="alert"><b>Note</b> Available only in Windows 8 and Windows
    ///Server 2012.</div> <div> </div>
    FWPM_NET_EVENT_TYPE_CLASSIFY_DROP_MAC  = 0x00000009,
    FWPM_NET_EVENT_TYPE_LPM_PACKET_ARRIVAL = 0x0000000a,
    ///Maximum value for testing purposes.
    FWPM_NET_EVENT_TYPE_MAX                = 0x0000000b,
}

///The <b>FWPM_APPC_NETWORK_CAPABILITY_TYPE</b> enumeration specifies the type of app container network capability that
///is associated with the object or traffic in question.
alias FWPM_APPC_NETWORK_CAPABILITY_TYPE = int;
enum : int
{
    ///Allows the app container to make network requests to servers on the Internet. It acts as a client.
    FWPM_APPC_NETWORK_CAPABILITY_INTERNET_CLIENT          = 0x00000000,
    ///Allows the app container to make requests and to receive requests to and from the Internet. It acts as a client
    ///and also as a server.
    FWPM_APPC_NETWORK_CAPABILITY_INTERNET_CLIENT_SERVER   = 0x00000001,
    ///Allows the app container to make requests and to receive requests to and from private networks (such as a home
    ///network, work network, or the corporate domain network of the computer). It acts as a client and also as a
    ///server.
    FWPM_APPC_NETWORK_CAPABILITY_INTERNET_PRIVATE_NETWORK = 0x00000002,
}

///The <b>FWPM_SYSTEM_PORT_TYPE</b> enumerated type specifies the type of system port.
alias FWPM_SYSTEM_PORT_TYPE = int;
enum : int
{
    ///Specifies a system port used by an RPC endpoint mapper.
    FWPM_SYSTEM_PORT_RPC_EPMAP   = 0x00000000,
    ///Specifies a system port used by the Teredo service.
    FWPM_SYSTEM_PORT_TEREDO      = 0x00000001,
    ///Specifies an inbound system port used by the IP in conjunction with HTTPS implementation.
    FWPM_SYSTEM_PORT_IPHTTPS_IN  = 0x00000002,
    ///Specifies an outbound system port used by the IP in conjunction with HTTPS implementation.
    FWPM_SYSTEM_PORT_IPHTTPS_OUT = 0x00000003,
    ///Maximum value for testing purposes.
    FWPM_SYSTEM_PORT_TYPE_MAX    = 0x00000004,
}

///The <b>FWPM_CONNECTION_EVENT_TYPE</b> enumeration specifies the type of connection object change event.
alias FWPM_CONNECTION_EVENT_TYPE = int;
enum : int
{
    ///A new connection object was added.
    FWPM_CONNECTION_EVENT_ADD    = 0x00000000,
    ///A connection object was deleted.
    FWPM_CONNECTION_EVENT_DELETE = 0x00000001,
    ///Maximum value for testing purposes.
    FWPM_CONNECTION_EVENT_MAX    = 0x00000002,
}

///The <b>FWPM_VSWITCH_EVENT_TYPE</b> enumeration specifies the type of a vSwitch event.
alias FWPM_VSWITCH_EVENT_TYPE = int;
enum : int
{
    ///The filter engine is not enabled on all vSwitch instances. As a result, the filter(s) being added may not be
    ///fully enforced.
    FWPM_VSWITCH_EVENT_FILTER_ADD_TO_INCOMPLETE_LAYER         = 0x00000000,
    ///The filter engine to which the filter(s) are being added is not in its required position (typically the first
    ///filtering extension in the vSwitch instance). As a result, the filter(s) could be bypassed.
    FWPM_VSWITCH_EVENT_FILTER_ENGINE_NOT_IN_REQUIRED_POSITION = 0x00000001,
    ///The filter engine is being enabled for the vSwitch instance.
    FWPM_VSWITCH_EVENT_ENABLED_FOR_INSPECTION                 = 0x00000002,
    ///The filter engine is being disabled for the vSwitch instance.
    FWPM_VSWITCH_EVENT_DISABLED_FOR_INSPECTION                = 0x00000003,
    ///The filter engine is being reordered and may not be in the required position to enforce committed filters.
    FWPM_VSWITCH_EVENT_FILTER_ENGINE_REORDER                  = 0x00000004,
    ///Maximum value for testing purposes.
    FWPM_VSWITCH_EVENT_MAX                                    = 0x00000005,
}

alias IPV4_OPTION_TYPE = int;
enum : int
{
    IP_OPT_EOL          = 0x00000000,
    IP_OPT_NOP          = 0x00000001,
    IP_OPT_SECURITY     = 0x00000082,
    IP_OPT_LSRR         = 0x00000083,
    IP_OPT_TS           = 0x00000044,
    IP_OPT_RR           = 0x00000007,
    IP_OPT_SSRR         = 0x00000089,
    IP_OPT_SID          = 0x00000088,
    IP_OPT_ROUTER_ALERT = 0x00000094,
    IP_OPT_MULTIDEST    = 0x00000095,
}

alias IP_OPTION_TIMESTAMP_FLAGS = int;
enum : int
{
    IP_OPTION_TIMESTAMP_ONLY             = 0x00000000,
    IP_OPTION_TIMESTAMP_ADDRESS          = 0x00000001,
    IP_OPTION_TIMESTAMP_SPECIFIC_ADDRESS = 0x00000003,
}

alias ICMP4_UNREACH_CODE = int;
enum : int
{
    ICMP4_UNREACH_NET                = 0x00000000,
    ICMP4_UNREACH_HOST               = 0x00000001,
    ICMP4_UNREACH_PROTOCOL           = 0x00000002,
    ICMP4_UNREACH_PORT               = 0x00000003,
    ICMP4_UNREACH_FRAG_NEEDED        = 0x00000004,
    ICMP4_UNREACH_SOURCEROUTE_FAILED = 0x00000005,
    ICMP4_UNREACH_NET_UNKNOWN        = 0x00000006,
    ICMP4_UNREACH_HOST_UNKNOWN       = 0x00000007,
    ICMP4_UNREACH_ISOLATED           = 0x00000008,
    ICMP4_UNREACH_NET_ADMIN          = 0x00000009,
    ICMP4_UNREACH_HOST_ADMIN         = 0x0000000a,
    ICMP4_UNREACH_NET_TOS            = 0x0000000b,
    ICMP4_UNREACH_HOST_TOS           = 0x0000000c,
    ICMP4_UNREACH_ADMIN              = 0x0000000d,
}

alias ICMP4_TIME_EXCEED_CODE = int;
enum : int
{
    ICMP4_TIME_EXCEED_TRANSIT    = 0x00000000,
    ICMP4_TIME_EXCEED_REASSEMBLY = 0x00000001,
}

alias ARP_OPCODE = int;
enum : int
{
    ARP_REQUEST  = 0x00000001,
    ARP_RESPONSE = 0x00000002,
}

alias ARP_HARDWARE_TYPE = int;
enum : int
{
    ARP_HW_ENET = 0x00000001,
    ARP_HW_802  = 0x00000006,
}

alias IGMP_MAX_RESP_CODE_TYPE = int;
enum : int
{
    IGMP_MAX_RESP_CODE_TYPE_NORMAL = 0x00000000,
    IGMP_MAX_RESP_CODE_TYPE_FLOAT  = 0x00000001,
}

alias IPV6_OPTION_TYPE = int;
enum : int
{
    IP6OPT_PAD1         = 0x00000000,
    IP6OPT_PADN         = 0x00000001,
    IP6OPT_TUNNEL_LIMIT = 0x00000004,
    IP6OPT_ROUTER_ALERT = 0x00000005,
    IP6OPT_JUMBO        = 0x000000c2,
    IP6OPT_NSAP_ADDR    = 0x000000c3,
}

alias ND_OPTION_TYPE = int;
enum : int
{
    ND_OPT_SOURCE_LINKADDR        = 0x00000001,
    ND_OPT_TARGET_LINKADDR        = 0x00000002,
    ND_OPT_PREFIX_INFORMATION     = 0x00000003,
    ND_OPT_REDIRECTED_HEADER      = 0x00000004,
    ND_OPT_MTU                    = 0x00000005,
    ND_OPT_NBMA_SHORTCUT_LIMIT    = 0x00000006,
    ND_OPT_ADVERTISEMENT_INTERVAL = 0x00000007,
    ND_OPT_HOME_AGENT_INFORMATION = 0x00000008,
    ND_OPT_SOURCE_ADDR_LIST       = 0x00000009,
    ND_OPT_TARGET_ADDR_LIST       = 0x0000000a,
    ND_OPT_ROUTE_INFO             = 0x00000018,
    ND_OPT_RDNSS                  = 0x00000019,
    ND_OPT_DNSSL                  = 0x0000001f,
}

alias MLD_MAX_RESP_CODE_TYPE = int;
enum : int
{
    MLD_MAX_RESP_CODE_TYPE_NORMAL = 0x00000000,
    MLD_MAX_RESP_CODE_TYPE_FLOAT  = 0x00000001,
}

alias TUNNEL_SUB_TYPE = int;
enum : int
{
    TUNNEL_SUB_TYPE_NONE  = 0x00000000,
    TUNNEL_SUB_TYPE_CP    = 0x00000001,
    TUNNEL_SUB_TYPE_IPTLS = 0x00000002,
    TUNNEL_SUB_TYPE_HA    = 0x00000003,
}

alias NPI_MODULEID_TYPE = int;
enum : int
{
    MIT_GUID    = 0x00000001,
    MIT_IF_LUID = 0x00000002,
}

alias FALLBACK_INDEX = int;
enum : int
{
    FallbackIndexTcpFastopen = 0x00000000,
    FallbackIndexMax         = 0x00000001,
}

// Callbacks

///The <b>FWPM_PROVIDER_CHANGE_CALLBACK0</b> function is used to add custom behavior to the provider change notification
///process.
///Params:
///    context = Type: <b>void*</b> Optional context pointer. It contains the value of the <i>context</i> parameter passed to the
///              FwpmProviderSubscribeChanges0 function.
///    change = Type: [FWPM_PROVIDER_CHANGE0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_provider_change0)*</b> The change
///             notification information.
alias FWPM_PROVIDER_CHANGE_CALLBACK0 = void function(void* context, const(FWPM_PROVIDER_CHANGE0)* change);
///The <b>FWPM_PROVIDER_CONTEXT_CHANGE_CALLBACK0</b> function is used to add custom behavior to the provider context
///change notification process.
///Params:
///    context = Type: <b>void*</b> Optional context pointer. It contains the value of the <i>context</i> parameter passed to the
///              FwpmProviderContextSubscribeChanges0 function.
///    change = Type:
///             [FWPM_PROVIDER_CONTEXT_CHANGE0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_provider_context_change0)*</b>
///             The change notification information.
alias FWPM_PROVIDER_CONTEXT_CHANGE_CALLBACK0 = void function(void* context, 
                                                             const(FWPM_PROVIDER_CONTEXT_CHANGE0)* change);
///The <b>FWPM_SUBLAYER_CHANGE_CALLBACK0</b> function is used to added custom behavior to the sublayer change
///notification process.
///Params:
///    context = Type: <b>void*</b> Optional context pointer. It contains the value of the <i>context</i> parameter of the
///              FwpmSubLayerSubscribeChanges0 function.
///    change = Type: [FWPM_SUBLAYER_CHANGE0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_sublayer_change0)*</b> The change
///             notification information.
alias FWPM_SUBLAYER_CHANGE_CALLBACK0 = void function(void* context, const(FWPM_SUBLAYER_CHANGE0)* change);
///The <b>FWPM_CALLOUT_CHANGE_CALLBACK0</b> function is used to add custom behavior to the callout change notification
///process.
///Params:
///    context = Type: <b>void*</b> Optional context pointer. It contains the value of the <i>context</i> parameter of the
///              FwpmCalloutSubscribeChanges0 function.
///    change = Type: [FWPM_CALLOUT_CHANGE0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_callout_change0)*</b> The change
///             notification information.
alias FWPM_CALLOUT_CHANGE_CALLBACK0 = void function(void* context, const(FWPM_CALLOUT_CHANGE0)* change);
///The <b>FWPM_FILTER_CHANGE_CALLBACK0</b> function is used to added custom behavior to the filter change notification
///process.
///Params:
///    context = Type: <b>void*</b> Optional context pointer. It contains the value of the <i>context</i> parameter passed to the
///              FwpmFilterSubscribeChanges0 function.
///    change = Type: [FWPM_FILTER_CHANGE0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_filter_change0)*</b> The change
///             notification information.
alias FWPM_FILTER_CHANGE_CALLBACK0 = void function(void* context, const(FWPM_FILTER_CHANGE0)* change);
///The <b>IPSEC_SA_CONTEXT_CALLBACK0</b> function is used to add custom behavior to the IPsec security association (SA)
///context subscription process.
///Params:
///    context = Type: <b>void*</b> Optional context pointer. It contains the value of the <i>context</i> parameter of the
///              IPsecSaContextSubscribe0 function.
///    change = Type: <b>const IPSEC_SA_CONTEXT_CHANGE0*</b> The IPsec SA context information.
alias IPSEC_SA_CONTEXT_CALLBACK0 = void function(void* context, const(IPSEC_SA_CONTEXT_CHANGE0)* change);
///The <b>IPSEC_KEY_MANAGER_KEY_DICTATION_CHECK0</b> function indicates whether the Trusted Intermediary Agent (TIA)
///will dictate the keys for the SA being negotiated.
///Params:
///    ikeTraffic = Type: [IKEEXT_TRAFFIC0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_traffic0)*</b> Specifies the traffic for
///                 which keys should be set or retrieved.
///    willDictateKey = Type: <b>BOOL*</b> True if the TIA will dictate the keys; otherwise, false.
///    weight = Type: <b>UINT32*</b> Specifies the weight that this TIA should be given compared to any peers.
alias IPSEC_KEY_MANAGER_KEY_DICTATION_CHECK0 = void function(const(IKEEXT_TRAFFIC0)* ikeTraffic, 
                                                             BOOL* willDictateKey, uint* weight);
///The <b>IPSEC_KEY_MANAGER_DICTATE_KEY0</b> function is used by the Trusted Intermediary Agent (TIA) to dictate keys
///for the SA being negotiated.
///Params:
///    inboundSaDetails = Type: [IPSEC_SA_DETAILS1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_details1)*</b> Information about
///                       the inbound SA.
///    outboundSaDetails = Type: [IPSEC_SA_DETAILS1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_details1)*</b> Information about
///                        the outbound SA.
///    keyingModuleGenKey = Type: <b>BOOL*</b> True if the keying module should randomly generate keys in the event that the TIA is unable to
///                         supply keys; otherwise, false.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The keys were successfully dictated </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl> </td>
///    <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td> <td
///    width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
alias IPSEC_KEY_MANAGER_DICTATE_KEY0 = uint function(IPSEC_SA_DETAILS1* inboundSaDetails, 
                                                     IPSEC_SA_DETAILS1* outboundSaDetails, BOOL* keyingModuleGenKey);
///The IPSEC_KEY_MANAGER_NOTIFY_KEY0 function is used to notify Trusted Intermediary Agents (TIAs) of the keys for the
///SA being negotiated.
///Params:
///    inboundSa = Type: <b>const IPSEC_SA_DETAILS1*</b> Information about the inbound SA.
///    outboundSa = Type: <b>const IPSEC_SA_DETAILS1*</b> Information about the outbound SA.
alias IPSEC_KEY_MANAGER_NOTIFY_KEY0 = void function(const(IPSEC_SA_DETAILS1)* inboundSa, 
                                                    const(IPSEC_SA_DETAILS1)* outboundSa);
///The <b>FWPM_NET_EVENT_CALLBACK0</b> function is used to add custom behavior to the net event subscription process.
///<div class="alert"><b>Note</b> <b>FWPM_NET_EVENT_CALLBACK0</b> is the specific implementation of
///FWPM_NET_EVENT_CALLBACK used in Windows 7. See WFP Version-Independent Names and Targeting Specific Versions of
///Windows for more information. For Windows 8, FWPM_NET_EVENT_CALLBACK1 is available.</div><div> </div>
///Params:
///    context = Type: <b>void*</b> Optional context pointer. It contains the value of the <i>context</i> parameter of the
///              FwpmNetEventSubscribe0 function.
///    event = Type: [FWPM_NET_EVENT1](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_net_event1)*</b> The net event
///            information.
alias FWPM_NET_EVENT_CALLBACK0 = void function(void* context, const(FWPM_NET_EVENT1)* event);
///The <b>FWPM_NET_EVENT_CALLBACK1</b> function is used to add custom behavior to the net event subscription process.
///<div class="alert"><b>Note</b> <b>FWPM_NET_EVENT_CALLBACK1</b> is the specific implementation of
///FWPM_NET_EVENT_CALLBACK used in Windows 8 and later. See WFP Version-Independent Names and Targeting Specific
///Versions of Windows for more information. For Windows 7, FWPM_NET_EVENT_CALLBACK0 is available.</div><div> </div>
///Params:
///    context = Type: <b>void*</b> Optional context pointer. It contains the value of the <i>context</i> parameter of the
///              FwpmNetEventSubscribe1 function.
///    event = Type: <b>const FWPM_NET_EVENT2*</b> The net event information.
alias FWPM_NET_EVENT_CALLBACK1 = void function(void* context, const(FWPM_NET_EVENT2)* event);
///The <b>FWPM_NET_EVENT_CALLBACK2</b> function is used to add custom behavior to the net event subscription process.
///<div class="alert"><b>Note</b> <b>FWPM_NET_EVENT_CALLBACK2</b> is the specific implementation of
///FWPM_NET_EVENT_CALLBACK used in Windows 10, version 1607 and later. See WFP Version-Independent Names and Targeting
///Specific Versions of Windows for more information. For Windows 8, FWPM_NET_EVENT_CALLBACK1 is available. For Windows
///7, FWPM_NET_EVENT_CALLBACK0 is available.</div><div> </div>
///Params:
///    context = Optional context pointer. It contains the value of the <i>context</i> parameter of the FwpmNetEventSubscribe2
///              function.
///    event = The net event information.
alias FWPM_NET_EVENT_CALLBACK2 = void function(void* context, const(FWPM_NET_EVENT3)* event);
alias FWPM_NET_EVENT_CALLBACK3 = void function(void* context, const(FWPM_NET_EVENT4_)* event);
alias FWPM_NET_EVENT_CALLBACK4 = void function(void* context, const(FWPM_NET_EVENT5_)* event);
///The <b>FWPM_SYSTEM_PORTS_CALLBACK0</b> function is used to add custom behavior to the system port subscription
///process.
///Params:
///    context = Type: <b>void*</b> Optional context pointer. It contains the value of the <i>context</i> parameter of the
///              FwpmSystemPortsSubscribe0 function.
///    sysPorts = Type: [FWPM_SYSTEM_PORTS0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_system_ports0)*</b> The system port
///               information.
alias FWPM_SYSTEM_PORTS_CALLBACK0 = void function(void* context, const(FWPM_SYSTEM_PORTS0)* sysPorts);
///The <b>FWPM_CONNECTION_CALLBACK0</b> function is used to add custom behavior to the connection object subscription
///process.
///Params:
///    context = Type: <b>void*</b> Optional context pointer. It contains the value of the <i>context</i> parameter of the
///              FwpmConnectionSubscribe0 function.
///    eventType = Type: [FWPM_CONNECTION_EVENT_TYPE](/windows/desktop/api/fwpmtypes/ne-fwpmtypes-fwpm_connection_event_type)</b>
///                The type of connection object change event.
///    connection = Type: [FWPM_CONNECTION0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_connection0)*</b> The connection object
///                 change information.
alias FWPM_CONNECTION_CALLBACK0 = void function(void* context, FWPM_CONNECTION_EVENT_TYPE eventType, 
                                                const(FWPM_CONNECTION0)* connection);
///The <b>FWPM_VSWITCH_EVENT_CALLBACK0</b> function is used to add custom behavior to the vSwitch event subscription
///process.
///Params:
///    context = Type: <b>void*</b> Optional context pointer. It contains the value of the <i>context</i> parameter of the
///              FwpmvSwitchEventSubscribe0 function.
///    vSwitchEvent = Type: [FWPM_VSWITCH_EVENT0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_vswitch_event0)*</b> The vSwitch
///                   event information.
///Returns:
///    This callback function does not return a value.
///    
alias FWPM_VSWITCH_EVENT_CALLBACK0 = uint function(void* context, const(FWPM_VSWITCH_EVENT0)* vSwitchEvent);

// Structs


struct FWP_BITMAP_ARRAY64_
{
    ubyte[8] bitmapArray64;
}

///The <b>FWP_BYTE_ARRAY6</b> structure stores an array of exactly 6 bytes. Reserved.
struct FWP_BYTE_ARRAY6
{
    ///Array of 6 bytes.
    ubyte[6] byteArray6;
}

///The <b>FWP_BYTE_ARRAY16</b> structure stores an array of exactly 16 bytes.
struct FWP_BYTE_ARRAY16
{
    ///Array of 16 bytes.
    ubyte[16] byteArray16;
}

///The <b>FWP_BYTE_BLOB</b> structure stores an array containing a variable number of bytes.
struct FWP_BYTE_BLOB
{
    ///Number of bytes in the array.
    uint   size;
    ///Pointer to the array.
    ubyte* data;
}

///The <b>FWP_TOKEN_INFORMATION</b> structure defines a set of security identifiers that are used for user-mode
///classification.
struct FWP_TOKEN_INFORMATION
{
    ///The number of SID_AND_ATTRIBUTES structures stored in the <b>sids</b> array.
    uint                sidCount;
    ///An array of SID_AND_ATTRIBUTES structures containing user and group security information.
    SID_AND_ATTRIBUTES* sids;
    ///The number of SID_AND_ATTRIBUTES structures stored in the <b>restrictedSids</b> array.
    uint                restrictedSidCount;
    SID_AND_ATTRIBUTES* restrictedSids;
}

///The <b>FWP_VALUE0</b> structure defines a data value that can be one of a number of different data types.
struct FWP_VALUE0
{
    ///The type of data for this value. See [FWP_DATA_TYPE](/windows/desktop/api/fwptypes/ne-fwptypes-fwp_data_type) for
    ///more information.
    FWP_DATA_TYPE type;
union
    {
        ubyte                uint8;
        ushort               uint16;
        uint                 uint32;
        ulong*               uint64;
        byte                 int8;
        short                int16;
        int                  int32;
        long*                int64;
        float                float32;
        double*              double64;
        FWP_BYTE_ARRAY16*    byteArray16;
        FWP_BYTE_BLOB*       byteBlob;
        SID*                 sid;
        FWP_BYTE_BLOB*       sd;
        FWP_TOKEN_INFORMATION* tokenInformation;
        FWP_BYTE_BLOB*       tokenAccessInformation;
        PWSTR                unicodeString;
        FWP_BYTE_ARRAY6*     byteArray6;
        FWP_BITMAP_ARRAY64_* bitmapArray64;
    }
}

///The <b>FWP_V4_ADDR_AND_MASK</b> structure specifies IPv4 address and mask in host order..
struct FWP_V4_ADDR_AND_MASK
{
    ///Specifies an IPv4 address.
    uint addr;
    ///Specifies an IPv4 mask.
    uint mask;
}

///The <b>FWP_V6_ADDR_AND_MASK</b> structure specifies an IPv6 address and mask.
struct FWP_V6_ADDR_AND_MASK
{
    ///An array of size <b>FWP_V6_ADDR_SIZE</b> bytes containing an IPv6 address. <b>FWP_V6_ADDR_SIZE</b> maps to 16.
    ubyte[16] addr;
    ///Value specifying the prefix length of the IPv6 address.
    ubyte     prefixLength;
}

///The <b>FWP_RANGE0</b> structure specifies a range of values.
struct FWP_RANGE0
{
    ///Low value of the range. See [FWP_VALUE0](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_value0) for more
    ///information.
    FWP_VALUE0 valueLow;
    ///High value of the range. See [FWP_VALUE0](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_value0) for more
    ///information.
    FWP_VALUE0 valueHigh;
}

///The **FWP_CONDITION_VALUE0** structure contains values that are used in filter conditions when testing for matching
///filters.
struct FWP_CONDITION_VALUE0
{
    ///Specifies the data type of the condition value. See [FWP_DATA_TYPE](ne-fwptypes-fwp_data_type.md) for more
    ///information.
    FWP_DATA_TYPE type;
union
    {
        ubyte                uint8;
        ushort               uint16;
        uint                 uint32;
        ulong*               uint64;
        byte                 int8;
        short                int16;
        int                  int32;
        long*                int64;
        float                float32;
        double*              double64;
        FWP_BYTE_ARRAY16*    byteArray16;
        FWP_BYTE_BLOB*       byteBlob;
        SID*                 sid;
        FWP_BYTE_BLOB*       sd;
        FWP_TOKEN_INFORMATION* tokenInformation;
        FWP_BYTE_BLOB*       tokenAccessInformation;
        PWSTR                unicodeString;
        FWP_BYTE_ARRAY6*     byteArray6;
        FWP_BITMAP_ARRAY64_* bitmapArray64;
        FWP_V4_ADDR_AND_MASK* v4AddrMask;
        FWP_V6_ADDR_AND_MASK* v6AddrMask;
        FWP_RANGE0*          rangeValue;
    }
}

///The <b>FWPM_DISPLAY_DATA0</b> structure stores an optional friendly name and an optional description for an object.
struct FWPM_DISPLAY_DATA0
{
    ///Optional friendly name.
    PWSTR name;
    ///Optional description.
    PWSTR description;
}

///The <b>IPSEC_VIRTUAL_IF_TUNNEL_INFO0</b> structure is used to store information specific to virtual interface
///tunneling.
struct IPSEC_VIRTUAL_IF_TUNNEL_INFO0
{
    ///ID of the virtual interface tunnel state.
    ulong virtualIfTunnelId;
    ///ID of the virtual interface tunneling traffic selector(s).
    ulong trafficSelectorId;
}

///The <b>IKEEXT_PRESHARED_KEY_AUTHENTICATION0</b> structure stores information needed for pre-shared key
///authentication. [IKEEXT_PRESHARED_KEY_AUTHENTICATION1](./ns-iketypes-ikeext_certificate_authentication1.md) is
///available.</div><div> </div>
struct IKEEXT_PRESHARED_KEY_AUTHENTICATION0
{
    ///The pre-shared key specified by [FWP_BYTE_BLOB](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_byte_blob).
    FWP_BYTE_BLOB presharedKey;
}

///The <b>IKEEXT_PRESHARED_KEY_AUTHENTICATION1</b> structure stores information needed for pre-shared key
///authentication. [IKEEXT_PRESHARED_KEY_AUTHENTICATION0](./ns-iketypes-ikeext_eap_authentication0.md) is
///available.</div><div> </div>
struct IKEEXT_PRESHARED_KEY_AUTHENTICATION1
{
    ///The pre-shared key specified by [FWP_BYTE_BLOB](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_byte_blob).
    FWP_BYTE_BLOB presharedKey;
    ///A combination of the following values. <table> <tr> <th>Pre-shared key authentication flag</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="IKEEXT_PSK_FLAG_LOCAL_AUTH_ONLY"></a><a
    ///id="ikeext_psk_flag_local_auth_only"></a><dl> <dt><b>IKEEXT_PSK_FLAG_LOCAL_AUTH_ONLY</b></dt> </dl> </td> <td
    ///width="60%"> Specifies that the pre-shared key authentication will be used only to authenticate a local computer
    ///to a remote computer. Applicable only to IKEv2. </td> </tr> <tr> <td width="40%"><a
    ///id="IKEEXT_PSK_FLAG_REMOTE_AUTH_ONLY"></a><a id="ikeext_psk_flag_remote_auth_only"></a><dl>
    ///<dt><b>IKEEXT_PSK_FLAG_REMOTE_AUTH_ONLY</b></dt> </dl> </td> <td width="60%"> Specifies that the pre-shared key
    ///authentication will be used only to authenticate a remote computer to a local computer. Applicable only to IKEv2.
    ///</td> </tr> </table>
    uint          flags;
}

///The <b>IKEEXT_CERT_ROOT_CONFIG0</b> structure stores the IKE, AuthIP, or IKEv2 certificate root configuration.
struct IKEEXT_CERT_ROOT_CONFIG0
{
    ///X509/ASN.1 encoded name of the certificate root. See
    ///[FWP_BYTE_BLOB](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_byte_blob) for more information.
    FWP_BYTE_BLOB certData;
    ///A combination of the following values. <table> <tr> <th>IKE/AuthIP/IKEv2 certificate flag</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="IKEEXT_CERT_FLAG_ENABLE_ACCOUNT_MAPPING"></a><a
    ///id="ikeext_cert_flag_enable_account_mapping"></a><dl> <dt><b>IKEEXT_CERT_FLAG_ENABLE_ACCOUNT_MAPPING</b></dt>
    ///</dl> </td> <td width="60%"> Enable certificate-to-account mapping for the end-host certificate that chains to
    ///this root. </td> </tr> <tr> <td width="40%"><a id="IKEEXT_CERT_FLAG_DISABLE_REQUEST_PAYLOAD"></a><a
    ///id="ikeext_cert_flag_disable_request_payload"></a><dl> <dt><b>IKEEXT_CERT_FLAG_DISABLE_REQUEST_PAYLOAD</b></dt>
    ///</dl> </td> <td width="60%"> Do not send a Cert request payload for this root. </td> </tr> <tr> <td
    ///width="40%"><a id="IKEEXT_CERT_FLAG_USE_NAP_CERTIFICATE"></a><a
    ///id="ikeext_cert_flag_use_nap_certificate"></a><dl> <dt><b>IKEEXT_CERT_FLAG_USE_NAP_CERTIFICATE</b></dt> </dl>
    ///</td> <td width="60%"> Enable Network Access Protection (NAP) certificate handling. </td> </tr> <tr> <td
    ///width="40%"><a id="IKEEXT_CERT_FLAG_INTERMEDIATE_CA"></a><a id="ikeext_cert_flag_intermediate_ca"></a><dl>
    ///<dt><b>IKEEXT_CERT_FLAG_INTERMEDIATE_CA</b></dt> </dl> </td> <td width="60%"> The corresponding Certification
    ///Authority (CA) can be an intermediate CA and does not have to be a ROOT CA. If this flag is not specified, the
    ///name will have to refer to a ROOT CA. </td> </tr> <tr> <td width="40%"><a
    ///id="IKEEXT_CERT_FLAG_IGNORE_INIT_CERT_MAP_FAILURE"></a><a
    ///id="ikeext_cert_flag_ignore_init_cert_map_failure"></a><dl>
    ///<dt><b>IKEEXT_CERT_FLAG_IGNORE_INIT_CERT_MAP_FAILURE</b></dt> </dl> </td> <td width="60%"> Ignore mapping
    ///failures on the initiator. Available only for IKE and IKEv2. Can be set only if
    ///<b>IKEEXT_CERT_FLAG_ENABLE_ACCOUNT_MAPPING</b> is also specified. By default, IKE and IKEv2 will not ignore
    ///certificate to account mapping failures, even on the initiator. Available only on Windows 7, Windows Server 2008
    ///R2, and later. </td> </tr> <tr> <td width="40%"><a id="IKEEXT_CERT_FLAG_PREFER_NAP_CERTIFICATE_OUTBOUND"></a><a
    ///id="ikeext_cert_flag_prefer_nap_certificate_outbound"></a><dl>
    ///<dt><b>IKEEXT_CERT_FLAG_PREFER_NAP_CERTIFICATE_OUTBOUND</b></dt> </dl> </td> <td width="60%"> NAP certificates
    ///will be preferred for local certificate selection. </td> </tr> <tr> <td width="40%"><a
    ///id="IKEEXT_CERT_FLAG_SELECT_NAP_CERTIFICATE"></a><a id="ikeext_cert_flag_select_nap_certificate"></a><dl>
    ///<dt><b>IKEEXT_CERT_FLAG_SELECT_NAP_CERTIFICATE</b></dt> </dl> </td> <td width="60%"> Select a NAP certificate for
    ///outbound. Available only on Windows 8 and Windows Server 2012. </td> </tr> <tr> <td width="40%"><a
    ///id="IKEEXT_CERT_FLAG_VERIFY_NAP_CERTIFICATE"></a><a id="ikeext_cert_flag_verify_nap_certificate"></a><dl>
    ///<dt><b>IKEEXT_CERT_FLAG_VERIFY_NAP_CERTIFICATE</b></dt> </dl> </td> <td width="60%"> Verify that the inbound
    ///certificate is NAP. Available only on Windows 8 and Windows Server 2012. </td> </tr> <tr> <td width="40%"><a
    ///id="IKEEXT_CERT_FLAG_FOLLOW_RENEWAL_CERTIFICATE"></a><a id="ikeext_cert_flag_follow_renewal_certificate"></a><dl>
    ///<dt><b>IKEEXT_CERT_FLAG_FOLLOW_RENEWAL_CERTIFICATE</b></dt> </dl> </td> <td width="60%"> Follow the renewal
    ///property on the certificate when selecting local certificate for outbound. Only applicable when the hash of the
    ///certificate is specified. Available only on Windows 8 and Windows Server 2012. </td> </tr> </table>
    uint          flags;
}

///The
///[IKEEXT_CERTIFICATE_AUTHENTICATION1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_certificate_authentication1) is
///available. For Windows 8,
///[IKEEXT_CERTIFICATE_AUTHENTICATION2](/windows/desktop/api/iketypes/ns-iketypes-ikeext_certificate_authentication2) is
///available.</div> <div> </div>
struct IKEEXT_CERTIFICATE_AUTHENTICATION0
{
    ///Certificate configuration type for inbound peer certificate verification. See
    ///[IKEEXT_CERT_CONFIG_TYPE](/windows/desktop/api/iketypes/ne-iketypes-ikeext_cert_config_type) for more
    ///information.
    IKEEXT_CERT_CONFIG_TYPE inboundConfigType;
union
    {
struct
        {
            uint inboundRootArraySize;
            IKEEXT_CERT_ROOT_CONFIG0* inboundRootArray;
        }
        IKEEXT_CERT_ROOT_CONFIG0* inboundEnterpriseStoreConfig;
        IKEEXT_CERT_ROOT_CONFIG0* inboundTrustedRootStoreConfig;
    }
    ///Certificate configuration type for outbound local certificate verification. See
    ///[IKEEXT_CERT_CONFIG_TYPE](/windows/desktop/api/iketypes/ne-iketypes-ikeext_cert_config_type) for more
    ///information.
    IKEEXT_CERT_CONFIG_TYPE outboundConfigType;
union
    {
struct
        {
            uint outboundRootArraySize;
            IKEEXT_CERT_ROOT_CONFIG0* outboundRootArray;
        }
        IKEEXT_CERT_ROOT_CONFIG0* outboundEnterpriseStoreConfig;
        IKEEXT_CERT_ROOT_CONFIG0* outboundTrustedRootStoreConfig;
    }
    ///A combination of the following values that specifies the certificate authentication characteristics. <table> <tr>
    ///<th>IKE/AuthIP certificate authentication flag</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="IKEEXT_CERT_AUTH_FLAG_SSL_ONE_WAY"></a><a id="ikeext_cert_auth_flag_ssl_one_way"></a><dl>
    ///<dt><b>IKEEXT_CERT_AUTH_FLAG_SSL_ONE_WAY</b></dt> </dl> </td> <td width="60%"> Enable SSL one way authentication.
    ///Applicable only to AuthIP. </td> </tr> <tr> <td width="40%"><a
    ///id="IKEEXT_CERT_AUTH_FLAG_DISABLE_CRL_CHECK__"></a><a id="ikeext_cert_auth_flag_disable_crl_check__"></a><dl>
    ///<dt><b>IKEEXT_CERT_AUTH_FLAG_DISABLE_CRL_CHECK </b></dt> </dl> </td> <td width="60%"> Disable CRL checking. By
    ///default weak CRL checking is enabled. Weak checking means that a certificate will be rejected if and only if CRL
    ///is successfully looked up and the certificate is found to be revoked. </td> </tr> <tr> <td width="40%"><a
    ///id="IKEEXT_CERT_AUTH_ENABLE_CRL_CHECK_STRONG"></a><a id="ikeext_cert_auth_enable_crl_check_strong"></a><dl>
    ///<dt><b>IKEEXT_CERT_AUTH_ENABLE_CRL_CHECK_STRONG</b></dt> </dl> </td> <td width="60%"> Enable strong CRL checking.
    ///Strong checking means that a certificate will be rejected if certificate is found to be revoked, or if any other
    ///error (for example, CRL could not be retrieved) takes place while performing the revocation checking. </td> </tr>
    ///<tr> <td width="40%"><a id="IKEEXT_CERT_AUTH_DISABLE_SSL_CERT_VALIDATION"></a><a
    ///id="ikeext_cert_auth_disable_ssl_cert_validation"></a><dl>
    ///<dt><b>IKEEXT_CERT_AUTH_DISABLE_SSL_CERT_VALIDATION</b></dt> </dl> </td> <td width="60%"> SSL validation requires
    ///certain EKUs, like server auth EKU from a server. This flag disables the server authentication EKU check, but
    ///still performs the other IKE-style certificate verification. Applicable only to AuthIP. </td> </tr> <tr> <td
    ///width="40%"><a id="IKEEXT_CERT_AUTH_ALLOW_HTTP_CERT_LOOKUP"></a><a
    ///id="ikeext_cert_auth_allow_http_cert_lookup"></a><dl> <dt><b>IKEEXT_CERT_AUTH_ALLOW_HTTP_CERT_LOOKUP</b></dt>
    ///</dl> </td> <td width="60%"> Allow lookup of peer certificate information from an HTTP URL. Applicable only to
    ///IKEv2. Available only on Windows 7, Windows Server 2008 R2, and later. </td> </tr> <tr> <td width="40%"><a
    ///id="IKEEXT_CERT_AUTH_URL_CONTAINS_BUNDLE"></a><a id="ikeext_cert_auth_url_contains_bundle"></a><dl>
    ///<dt><b>IKEEXT_CERT_AUTH_URL_CONTAINS_BUNDLE</b></dt> </dl> </td> <td width="60%"> Indicates that the URL
    ///specified in the certificate authentication policy points to an encoded certificate bundle. If this flag is not
    ///specified, IKEv2 will assume that the URL points to an encoded certificate. Applicable only to IKEv2. Available
    ///only on Windows 7, Windows Server 2008 R2, and later. </td> </tr> </table>
    uint flags;
}

///The
///[IKEEXT_CERTIFICATE_AUTHENTICATION2](/windows/desktop/api/iketypes/ns-iketypes-ikeext_certificate_authentication2) is
///available. For Windows Vista,
///[IKEEXT_CERTIFICATE_AUTHENTICATION0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_certificate_authentication0) is
///available.</div> <div> </div>
struct IKEEXT_CERTIFICATE_AUTHENTICATION1
{
    ///Certificate configuration type for inbound peer certificate verification. See
    ///[IKEEXT_CERT_CONFIG_TYPE](/windows/desktop/api/iketypes/ne-iketypes-ikeext_cert_config_type) for more
    ///information.
    IKEEXT_CERT_CONFIG_TYPE inboundConfigType;
union
    {
struct
        {
            uint inboundRootArraySize;
            IKEEXT_CERT_ROOT_CONFIG0* inboundRootArray;
        }
        IKEEXT_CERT_ROOT_CONFIG0* inboundEnterpriseStoreConfig;
        IKEEXT_CERT_ROOT_CONFIG0* inboundTrustedRootStoreConfig;
    }
    ///Certificate configuration type for outbound local certificate verification. See
    ///[IKEEXT_CERT_CONFIG_TYPE](/windows/desktop/api/iketypes/ne-iketypes-ikeext_cert_config_type) for more
    ///information.
    IKEEXT_CERT_CONFIG_TYPE outboundConfigType;
union
    {
struct
        {
            uint outboundRootArraySize;
            IKEEXT_CERT_ROOT_CONFIG0* outboundRootArray;
        }
        IKEEXT_CERT_ROOT_CONFIG0* outboundEnterpriseStoreConfig;
        IKEEXT_CERT_ROOT_CONFIG0* outboundTrustedRootStoreConfig;
    }
    ///A combination of the following values that specifies the certificate authentication characteristics. <table> <tr>
    ///<th>IKE/AuthIP certificate authentication flag</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="IKEEXT_CERT_AUTH_FLAG_SSL_ONE_WAY"></a><a id="ikeext_cert_auth_flag_ssl_one_way"></a><dl>
    ///<dt><b>IKEEXT_CERT_AUTH_FLAG_SSL_ONE_WAY</b></dt> </dl> </td> <td width="60%"> Enable SSL one-way authentication.
    ///Applicable only to AuthIP. </td> </tr> <tr> <td width="40%"><a
    ///id="IKEEXT_CERT_AUTH_FLAG_DISABLE_CRL_CHECK__"></a><a id="ikeext_cert_auth_flag_disable_crl_check__"></a><dl>
    ///<dt><b>IKEEXT_CERT_AUTH_FLAG_DISABLE_CRL_CHECK </b></dt> </dl> </td> <td width="60%"> Disable CRL checking. By
    ///default weak CRL checking is enabled. Weak checking means that a certificate will be rejected if and only if CRL
    ///is successfully looked up and the certificate is found to be revoked. </td> </tr> <tr> <td width="40%"><a
    ///id="IKEEXT_CERT_AUTH_ENABLE_CRL_CHECK_STRONG"></a><a id="ikeext_cert_auth_enable_crl_check_strong"></a><dl>
    ///<dt><b>IKEEXT_CERT_AUTH_ENABLE_CRL_CHECK_STRONG</b></dt> </dl> </td> <td width="60%"> Enable strong CRL checking.
    ///Strong checking means that a certificate will be rejected if certificate is found to be revoked, or if any other
    ///error (for example, CRL could not be retrieved) takes place while performing the revocation checking. </td> </tr>
    ///<tr> <td width="40%"><a id="IKEEXT_CERT_AUTH_DISABLE_SSL_CERT_VALIDATION"></a><a
    ///id="ikeext_cert_auth_disable_ssl_cert_validation"></a><dl>
    ///<dt><b>IKEEXT_CERT_AUTH_DISABLE_SSL_CERT_VALIDATION</b></dt> </dl> </td> <td width="60%"> Disables the SSL server
    ///authentication extended key usage (EKU) check. Other types of AuthIP validation are still performed. Applicable
    ///only to AuthIP. </td> </tr> <tr> <td width="40%"><a id="IKEEXT_CERT_AUTH_ALLOW_HTTP_CERT_LOOKUP"></a><a
    ///id="ikeext_cert_auth_allow_http_cert_lookup"></a><dl> <dt><b>IKEEXT_CERT_AUTH_ALLOW_HTTP_CERT_LOOKUP</b></dt>
    ///</dl> </td> <td width="60%"> Allow lookup of peer certificate information from an HTTP URL. Applicable only to
    ///IKEv2. </td> </tr> <tr> <td width="40%"><a id="IKEEXT_CERT_AUTH_URL_CONTAINS_BUNDLE"></a><a
    ///id="ikeext_cert_auth_url_contains_bundle"></a><dl> <dt><b>IKEEXT_CERT_AUTH_URL_CONTAINS_BUNDLE</b></dt> </dl>
    ///</td> <td width="60%"> The URL specified in the certificate authentication policy points to an encoded
    ///certificate-bundle. If this flag is not specified, IKEv2 will assume that the URL points to an encoded
    ///certificate. Applicable only to IKEv2. </td> </tr> </table>
    uint          flags;
    ///HTTP URL pointing to an encoded certificate or certificate-bundle, that will be used by IKEv2 for authenticating
    ///local machine to a peer. Applicable only to IKEv2. See
    ///[FWP_BYTE_BLOB](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_byte_blob) for more information.
    FWP_BYTE_BLOB localCertLocationUrl;
}

///The <b>IKEEXT_CERT_EKUS0</b> structure contains information about the extended key usage (EKU) properties of a
///certificate.
struct IKEEXT_CERT_EKUS0
{
    ///Type: <b>ULONG</b> The number of EKUs in the <b>eku</b> member.
    uint  numEku;
    PSTR* eku;
}

///The <b>IKEEXT_CERT_NAME0</b> structure specifies certificate selection "subject" criteria for an authentication
///method.
struct IKEEXT_CERT_NAME0
{
    ///Type:
    ///[IKEEXT_CERT_CRITERIA_NAME_TYPE](/windows/desktop/api/iketypes/ne-iketypes-ikeext_cert_criteria_name_type)</b>
    ///The type of NAME field.
    IKEEXT_CERT_CRITERIA_NAME_TYPE nameType;
    ///Type: <b>LPWSTR</b> The string to be used for matching the "subject" criteria.
    PWSTR certName;
}

///The <b>IKEEXT_CERTIFICATE_CRITERIA0</b> structure contains a set of criteria to applied to an authentication method.
struct IKEEXT_CERTIFICATE_CRITERIA0
{
    ///Type: [FWP_BYTE_BLOB](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_byte_blob)</b> X509/ASN.1 encoded name of the
    ///root certificate. Should be empty when specifying Enterprise or trusted root store config.
    FWP_BYTE_BLOB      certData;
    ///Type: [FWP_BYTE_BLOB](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_byte_blob)</b> 16-character hexadecimal
    ///string that represents the ID, thumbprint or HASH of the end certificate.
    FWP_BYTE_BLOB      certHash;
    ///Type: [IKEEXT_CERT_EKUS0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_cert_ekus0)*</b> The specific extended
    ///key usage (EKU) object identifiers (OIDs) selected for the criteria on the end certificate.
    IKEEXT_CERT_EKUS0* eku;
    ///Type: [IKEEXT_CERT_NAME0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_cert_name0)*</b> The name/subject
    ///selected for the criteria on the end certificate.
    IKEEXT_CERT_NAME0* name;
    ///Type: <b>UINT32</b> Reserved for system use.
    uint               flags;
}

///The <b>IKEEXT_CERTIFICATE_AUTHENTICATION2</b> structure is used to specify various parameters for authentication with
///certificates.
///[IKEEXT_CERTIFICATE_AUTHENTICATION0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_certificate_authentication0) is
///available.</div><div> </div>
struct IKEEXT_CERTIFICATE_AUTHENTICATION2
{
    ///Type: [IKEEXT_CERT_CONFIG_TYPE](/windows/desktop/api/iketypes/ne-iketypes-ikeext_cert_config_type)</b>
    ///Certificate configuration type for inbound peer certificate verification.
    IKEEXT_CERT_CONFIG_TYPE inboundConfigType;
union
    {
struct
        {
            uint inboundRootArraySize;
            IKEEXT_CERTIFICATE_CRITERIA0* inboundRootCriteria;
        }
struct
        {
            uint inboundEnterpriseStoreArraySize;
            IKEEXT_CERTIFICATE_CRITERIA0* inboundEnterpriseStoreCriteria;
        }
struct
        {
            uint inboundRootStoreArraySize;
            IKEEXT_CERTIFICATE_CRITERIA0* inboundTrustedRootStoreCriteria;
        }
    }
    ///Type: [IKEEXT_CERT_CONFIG_TYPE](/windows/desktop/api/iketypes/ne-iketypes-ikeext_cert_config_type)</b>
    ///Certificate configuration type for outbound local certificate verification.
    IKEEXT_CERT_CONFIG_TYPE outboundConfigType;
union
    {
struct
        {
            uint outboundRootArraySize;
            IKEEXT_CERTIFICATE_CRITERIA0* outboundRootCriteria;
        }
struct
        {
            uint outboundEnterpriseStoreArraySize;
            IKEEXT_CERTIFICATE_CRITERIA0* outboundEnterpriseStoreCriteria;
        }
struct
        {
            uint outboundRootStoreArraySize;
            IKEEXT_CERTIFICATE_CRITERIA0* outboundTrustedRootStoreCriteria;
        }
    }
    ///Type: <b>UINT32</b> A combination of the following values that specifies the certificate authentication
    ///characteristics. <table> <tr> <th>IKE/AuthIP certificate authentication flag</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="IKEEXT_CERT_AUTH_FLAG_SSL_ONE_WAY"></a><a id="ikeext_cert_auth_flag_ssl_one_way"></a><dl>
    ///<dt><b>IKEEXT_CERT_AUTH_FLAG_SSL_ONE_WAY</b></dt> </dl> </td> <td width="60%"> Enable SSL one-way authentication.
    ///Applicable only to AuthIP. </td> </tr> <tr> <td width="40%"><a
    ///id="IKEEXT_CERT_AUTH_FLAG_DISABLE_CRL_CHECK__"></a><a id="ikeext_cert_auth_flag_disable_crl_check__"></a><dl>
    ///<dt><b>IKEEXT_CERT_AUTH_FLAG_DISABLE_CRL_CHECK </b></dt> </dl> </td> <td width="60%"> Disable CRL checking. By
    ///default weak CRL checking is enabled. Weak checking means that a certificate will be rejected if and only if CRL
    ///is successfully looked up and the certificate is found to be revoked. </td> </tr> <tr> <td width="40%"><a
    ///id="IKEEXT_CERT_AUTH_ENABLE_CRL_CHECK_STRONG"></a><a id="ikeext_cert_auth_enable_crl_check_strong"></a><dl>
    ///<dt><b>IKEEXT_CERT_AUTH_ENABLE_CRL_CHECK_STRONG</b></dt> </dl> </td> <td width="60%"> Enable strong CRL checking.
    ///Strong checking means that a certificate will be rejected if certificate is found to be revoked, or if any other
    ///error (for example, CRL could not be retrieved) takes place while performing the revocation checking. </td> </tr>
    ///<tr> <td width="40%"><a id="IKEEXT_CERT_AUTH_DISABLE_SSL_CERT_VALIDATION"></a><a
    ///id="ikeext_cert_auth_disable_ssl_cert_validation"></a><dl>
    ///<dt><b>IKEEXT_CERT_AUTH_DISABLE_SSL_CERT_VALIDATION</b></dt> </dl> </td> <td width="60%"> Disables the SSL server
    ///authentication extended key usage (EKU) check. Other types of AuthIP validation are still performed. Applicable
    ///only to AuthIP. </td> </tr> <tr> <td width="40%"><a id="IKEEXT_CERT_AUTH_ALLOW_HTTP_CERT_LOOKUP"></a><a
    ///id="ikeext_cert_auth_allow_http_cert_lookup"></a><dl> <dt><b>IKEEXT_CERT_AUTH_ALLOW_HTTP_CERT_LOOKUP</b></dt>
    ///</dl> </td> <td width="60%"> Allow lookup of peer certificate information from an HTTP URL. Applicable only to
    ///IKEv2. </td> </tr> <tr> <td width="40%"><a id="IKEEXT_CERT_AUTH_URL_CONTAINS_BUNDLE"></a><a
    ///id="ikeext_cert_auth_url_contains_bundle"></a><dl> <dt><b>IKEEXT_CERT_AUTH_URL_CONTAINS_BUNDLE</b></dt> </dl>
    ///</td> <td width="60%"> The URL specified in the certificate authentication policy points to an encoded
    ///certificate-bundle. If this flag is not specified, IKEv2 will assume that the URL points to an encoded
    ///certificate. Applicable only to IKEv2. </td> </tr> </table>
    uint          flags;
    ///Type: [FWP_BYTE_BLOB](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_byte_blob)</b> HTTP URL pointing to an
    ///encoded certificate or certificate-bundle, that will be used by IKEv2 for authenticating local machine to a peer.
    ///Applicable only to IKEv2.
    FWP_BYTE_BLOB localCertLocationUrl;
}

///The <b>IKEEXT_IPV6_CGA_AUTHENTICATION0</b> structure is used to specify various parameters for IPV6 cryptographically
///generated address (CGA) authentication.
struct IKEEXT_IPV6_CGA_AUTHENTICATION0
{
    ///Key container name of the public key/private key pair that was used to generate the CGA. Same semantics as the
    ///<b>pwszContainerName</b> member of the CRYPT_KEY_PROV_INFO structure.
    PWSTR            keyContainerName;
    ///Name of the CSP that stores the key container. If <b>NULL</b>, default provider will be used. Same semantics as
    ///the <b>pwszProvName</b> member of the CRYPT_KEY_PROV_INFO structure.
    PWSTR            cspName;
    ///Type of the CSP that stores the key container. Same semantics as the <b>dwProvType</b> member of the
    ///CRYPT_KEY_PROV_INFO structure.
    uint             cspType;
    ///A [FWP_BYTE_ARRAY16](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_byte_array16) structure containing a modifier
    ///used during CGA generation. See CGA RFC for more information.
    FWP_BYTE_ARRAY16 cgaModifier;
    ///Collision count used during CGA generation. See CGA RFC for more information.
    ubyte            cgaCollisionCount;
}

///The <b>IKEEXT_KERBEROS_AUTHENTICATION0</b> structure contains information needed for preshared key authentication.
///[IKEEXT_KERBEROS_AUTHENTICATION1](./ns-iketypes-ikeext_certificate_authentication1.md) is available.</div><div>
///</div>
struct IKEEXT_KERBEROS_AUTHENTICATION0
{
    ///A combination of the following values. <table> <tr> <th>Kerberos authentication flag</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="IKEEXT_KERB_AUTH_DISABLE_INITIATOR_TOKEN_GENERATION"></a><a
    ///id="ikeext_kerb_auth_disable_initiator_token_generation"></a><dl>
    ///<dt><b>IKEEXT_KERB_AUTH_DISABLE_INITIATOR_TOKEN_GENERATION</b></dt> </dl> </td> <td width="60%"> Disable
    ///initiator generation of peer token from the peer's name string. </td> </tr> <tr> <td width="40%"><a
    ///id="IKEEXT_KERB_AUTH_DONT_ACCEPT_EXPLICIT_CREDENTIALS"></a><a
    ///id="ikeext_kerb_auth_dont_accept_explicit_credentials"></a><dl>
    ///<dt><b>IKEEXT_KERB_AUTH_DONT_ACCEPT_EXPLICIT_CREDENTIALS</b></dt> </dl> </td> <td width="60%"> Refuse connections
    ///if the peer is using explicit credentials. Applicable only to AuthIP. </td> </tr> </table>
    uint flags;
}

///The <b>IKEEXT_KERBEROS_AUTHENTICATION1</b> structure contains information needed for preshared key authentication.
///[IKEEXT_KERBEROS_AUTHENTICATION0](./ns-iketypes-ikeext_eap_authentication0.md) is available.</div><div> </div>
struct IKEEXT_KERBEROS_AUTHENTICATION1
{
    ///Type: <b>UINT32</b> A combination of the following values. <table> <tr> <th>Kerberos authentication flag</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="IKEEXT_KERB_AUTH_DISABLE_INITIATOR_TOKEN_GENERATION"></a><a
    ///id="ikeext_kerb_auth_disable_initiator_token_generation"></a><dl>
    ///<dt><b>IKEEXT_KERB_AUTH_DISABLE_INITIATOR_TOKEN_GENERATION</b></dt> </dl> </td> <td width="60%"> Disable
    ///initiator generation of peer token from the peer's name string. </td> </tr> <tr> <td width="40%"><a
    ///id="IKEEXT_KERB_AUTH_DONT_ACCEPT_EXPLICIT_CREDENTIALS"></a><a
    ///id="ikeext_kerb_auth_dont_accept_explicit_credentials"></a><dl>
    ///<dt><b>IKEEXT_KERB_AUTH_DONT_ACCEPT_EXPLICIT_CREDENTIALS</b></dt> </dl> </td> <td width="60%"> Refuse connections
    ///if the peer is using explicit credentials. Applicable only to AuthIP. </td> </tr> <tr> <td width="40%"><a
    ///id="IKEEXT_KERB_AUTH_FORCE_PROXY_ON_INITIATOR_"></a><a id="ikeext_kerb_auth_force_proxy_on_initiator_"></a><dl>
    ///<dt><b>IKEEXT_KERB_AUTH_FORCE_PROXY_ON_INITIATOR </b></dt> </dl> </td> <td width="60%"> Force the use of a
    ///Kerberos proxy server when acting as initiator. </td> </tr> </table>
    uint  flags;
    ///Type: <b>wchar_t*</b> The Kerberos proxy server.
    PWSTR proxyServer;
}

///The <b>IKEEXT_RESERVED_AUTHENTICATION0</b> structure is reserved for internal use. Do not use.
struct IKEEXT_RESERVED_AUTHENTICATION0
{
    ///Type: <b>UINT32</b> A combination of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="IKEEXT_RESERVED_AUTH_DISABLE_INITIATOR_TOKEN_GENERATION"></a><a
    ///id="ikeext_reserved_auth_disable_initiator_token_generation"></a><dl>
    ///<dt><b>IKEEXT_RESERVED_AUTH_DISABLE_INITIATOR_TOKEN_GENERATION</b></dt> </dl> </td> <td width="60%"> Reserved for
    ///internal use. </td> </tr> </table>
    uint flags;
}

///The <b>IKEEXT_NTLM_V2_AUTHENTICATION0</b> structure contains information needed for Microsoft Windows NT LAN Manager
///(NTLM) V2 authentication.
struct IKEEXT_NTLM_V2_AUTHENTICATION0
{
    ///Possible value: <table> <tr> <th>NTLM authentication flag</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="IKEEXT_NTLM_V2_AUTH_DONT_ACCEPT_EXPLICIT_CREDENTIALS"></a><a
    ///id="ikeext_ntlm_v2_auth_dont_accept_explicit_credentials"></a><dl>
    ///<dt><b>IKEEXT_NTLM_V2_AUTH_DONT_ACCEPT_EXPLICIT_CREDENTIALS</b></dt> </dl> </td> <td width="60%"> Refuse
    ///connections if the peer is using explicit credentials. </td> </tr> </table>
    uint flags;
}

///The <b>IKEEXT_EAP_AUTHENTICATION0</b> structure stores information needed for Extensible Authentication Protocol
///(EAP) authentication. This structure is only applicable to IKEv2.
struct IKEEXT_EAP_AUTHENTICATION0
{
    ///A combination of the following values. <table> <tr> <th>Pre-shared key authentication flag.</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="IKEEXT_EAP_FLAG_LOCAL_AUTH_ONLY"></a><a
    ///id="ikeext_eap_flag_local_auth_only"></a><dl> <dt><b>IKEEXT_EAP_FLAG_LOCAL_AUTH_ONLY</b></dt> </dl> </td> <td
    ///width="60%"> Specifies that EAP authentication will be used only to authenticate a local computer to a remote
    ///computer. </td> </tr> <tr> <td width="40%"><a id="IKEEXT_EAP_FLAG_REMOTE_AUTH_ONLY"></a><a
    ///id="ikeext_eap_flag_remote_auth_only"></a><dl> <dt><b>IKEEXT_EAP_FLAG_REMOTE_AUTH_ONLY</b></dt> </dl> </td> <td
    ///width="60%"> Specifies that EAP authentication will be used only to authenticate a remote computer to a local
    ///computer. </td> </tr> </table>
    uint flags;
}

///The [IKEEXT_AUTHENTICATION_METHOD1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_authentication_method1) is
///available.For Windows 8,
///[IKEEXT_AUTHENTICATION_METHOD2](/windows/desktop/api/iketypes/ns-iketypes-ikeext_authentication_method2) is
///available. </div> <div> </div>
struct IKEEXT_AUTHENTICATION_METHOD0
{
    ///Type of authentication method specified by IKEEXT_AUTHENTICATION_METHOD_TYPE.
    IKEEXT_AUTHENTICATION_METHOD_TYPE authenticationMethodType;
union
    {
        IKEEXT_PRESHARED_KEY_AUTHENTICATION0 presharedKeyAuthentication;
        IKEEXT_CERTIFICATE_AUTHENTICATION0 certificateAuthentication;
        IKEEXT_KERBEROS_AUTHENTICATION0 kerberosAuthentication;
        IKEEXT_NTLM_V2_AUTHENTICATION0 ntlmV2Authentication;
        IKEEXT_CERTIFICATE_AUTHENTICATION0 sslAuthentication;
        IKEEXT_IPV6_CGA_AUTHENTICATION0 cgaAuthentication;
    }
}

///The [IKEEXT_AUTHENTICATION_METHOD0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_authentication_method0) is
///available.</div> <div> </div>
struct IKEEXT_AUTHENTICATION_METHOD1
{
    ///Type of authentication method specified by IKEEXT_AUTHENTICATION_METHOD_TYPE.
    IKEEXT_AUTHENTICATION_METHOD_TYPE authenticationMethodType;
union
    {
        IKEEXT_PRESHARED_KEY_AUTHENTICATION1 presharedKeyAuthentication;
        IKEEXT_CERTIFICATE_AUTHENTICATION1 certificateAuthentication;
        IKEEXT_KERBEROS_AUTHENTICATION0 kerberosAuthentication;
        IKEEXT_NTLM_V2_AUTHENTICATION0 ntlmV2Authentication;
        IKEEXT_CERTIFICATE_AUTHENTICATION1 sslAuthentication;
        IKEEXT_IPV6_CGA_AUTHENTICATION0 cgaAuthentication;
        IKEEXT_EAP_AUTHENTICATION0 eapAuthentication;
    }
}

///The <b>IKEEXT_AUTHENTICATION_METHOD2</b> structure specifies various parameters for IKE/Authip authentication.
///[IKEEXT_AUTHENTICATION_METHOD0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_authentication_method0) is
///available.</div><div> </div>
struct IKEEXT_AUTHENTICATION_METHOD2
{
    ///Type: <b>IKEEXT_AUTHENTICATION_METHOD_TYPE</b> Type of authentication method.
    IKEEXT_AUTHENTICATION_METHOD_TYPE authenticationMethodType;
union
    {
        IKEEXT_PRESHARED_KEY_AUTHENTICATION1 presharedKeyAuthentication;
        IKEEXT_CERTIFICATE_AUTHENTICATION2 certificateAuthentication;
        IKEEXT_KERBEROS_AUTHENTICATION1 kerberosAuthentication;
        IKEEXT_RESERVED_AUTHENTICATION0 reservedAuthentication;
        IKEEXT_NTLM_V2_AUTHENTICATION0 ntlmV2Authentication;
        IKEEXT_CERTIFICATE_AUTHENTICATION2 sslAuthentication;
        IKEEXT_IPV6_CGA_AUTHENTICATION0 cgaAuthentication;
        IKEEXT_EAP_AUTHENTICATION0 eapAuthentication;
    }
}

///The <b>IKEEXT_CIPHER_ALGORITHM0</b> structure stores information about the IKE/AuthIP encryption algorithm.
struct IKEEXT_CIPHER_ALGORITHM0
{
    ///The type of encryption algorithm. See
    ///[IKEEXT_CIPHER_TYPE](/windows/desktop/api/iketypes/ne-iketypes-ikeext_cipher_type) for more information.
    IKEEXT_CIPHER_TYPE algoIdentifier;
    ///Unused parameter, always set it to 0.
    uint               keyLen;
    ///Unused parameter, always set it to 0.
    uint               rounds;
}

///The <b>IKEEXT_INTEGRITY_ALGORITHM0</b> structure stores the IKE/AuthIP hash algorithm.
struct IKEEXT_INTEGRITY_ALGORITHM0
{
    ///The type of hash algorithm. See
    ///[IKEEXT_INTEGRITY_TYPE](/windows/desktop/api/iketypes/ne-iketypes-ikeext_integrity_type) for more information.
    IKEEXT_INTEGRITY_TYPE algoIdentifier;
}

///The <b>IKEEXT_PROPOSAL0</b> structure is used to store an IKE/AuthIP main mode proposal.
struct IKEEXT_PROPOSAL0
{
    ///Parameters for the encryption algorithm specified by
    ///[IKEEXT_CIPHER_ALGORITHM0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_cipher_algorithm0).
    IKEEXT_CIPHER_ALGORITHM0 cipherAlgorithm;
    ///Parameters for the hash algorithm specified by
    ///[IKEEXT_INTEGRITY_ALGORITHM0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_integrity_algorithm0).
    IKEEXT_INTEGRITY_ALGORITHM0 integrityAlgorithm;
    ///Main mode security association (SA) lifetime in seconds.
    uint            maxLifetimeSeconds;
    ///The Diffie Hellman group specified by
    ///[IKEEXT_DH_GROUP](/windows/desktop/api/iketypes/ne-iketypes-ikeext_dh_group).
    IKEEXT_DH_GROUP dhGroup;
    ///Maximum number of IPsec quick mode SAs that can be generated from this main mode SA. 0 (zero) means infinite.
    uint            quickModeLimit;
}

///The <b>IKEEXT_POLICY0</b> structure is used to store the IKE/AuthIP main mode negotiation policy.
///[IKEEXT_POLICY1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_policy1) is available. For Windows 8,
///[IKEEXT_POLICY2](/windows/desktop/api/iketypes/ns-iketypes-ikeext_policy2) is available.</div><div> </div>
struct IKEEXT_POLICY0
{
    ///Unused parameter, always set this to 0.
    uint              softExpirationTime;
    ///Number of authentication methods.
    uint              numAuthenticationMethods;
    ///Array of acceptable authentication methods. See
    ///[IKEEXT_AUTHENTICATION_METHOD0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_authentication_method0) for more
    ///information.
    IKEEXT_AUTHENTICATION_METHOD0* authenticationMethods;
    ///Type of impersonation. Applies only to AuthIP. See IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE for more information.
    IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE initiatorImpersonationType;
    ///Number of main mode proposals.
    uint              numIkeProposals;
    ///Array of main mode proposals. See [IKEEXT_PROPOSAL0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_proposal0)
    ///for more information.
    IKEEXT_PROPOSAL0* ikeProposals;
    ///A combination of the following values. <table> <tr> <th>IKE/AuthIP policy flag</th> <th>Meaning</th> </tr> <tr>
    ///<td width="40%"><a id="IKEEXT_POLICY_FLAG_DISABLE_DIAGNOSTICS"></a><a
    ///id="ikeext_policy_flag_disable_diagnostics"></a><dl> <dt><b>IKEEXT_POLICY_FLAG_DISABLE_DIAGNOSTICS</b></dt> </dl>
    ///</td> <td width="60%"> Disable special diagnostics mode for IKE/Authip. This will prevent IKE/AuthIp from
    ///accepting unauthenticated notifications from peer, or sending MS_STATUS notifications to peer. </td> </tr> <tr>
    ///<td width="40%"><a id="IKEEXT_POLICY_FLAG_NO_MACHINE_LUID_VERIFY"></a><a
    ///id="ikeext_policy_flag_no_machine_luid_verify"></a><dl> <dt><b>IKEEXT_POLICY_FLAG_NO_MACHINE_LUID_VERIFY</b></dt>
    ///</dl> </td> <td width="60%"> Disable SA verification of machine LUID. </td> </tr> <tr> <td width="40%"><a
    ///id="IKEEXT_POLICY_FLAG_NO_IMPERSONATION_LUID_VERIFY"></a><a
    ///id="ikeext_policy_flag_no_impersonation_luid_verify"></a><dl>
    ///<dt><b>IKEEXT_POLICY_FLAG_NO_IMPERSONATION_LUID_VERIFY</b></dt> </dl> </td> <td width="60%"> Disable SA
    ///verification of machine impersonation LUID. Applicable only to AuthIP. </td> </tr> <tr> <td width="40%"><a
    ///id="IKEEXT_POLICY_FLAG_ENABLE_OPTIONAL_DH"></a><a id="ikeext_policy_flag_enable_optional_dh"></a><dl>
    ///<dt><b>IKEEXT_POLICY_FLAG_ENABLE_OPTIONAL_DH</b></dt> </dl> </td> <td width="60%"> Allow the responder to accept
    ///any DH proposal, including no DH, regardless of what is configured in policy. Applicable only to AuthIP. </td>
    ///</tr> </table>
    uint              flags;
    ///Maximum number of dynamic IPsec filters per remote IP address and per transport layer that is allowed to be added
    ///for any SA negotiated using this policy. Set this to 0 to disable dynamic filter addition. Dynamic filters are
    ///added by IKE/AuthIP on responder, when the QM traffic proposed by initiator is a subset of responder's traffic
    ///configuration.
    uint              maxDynamicFilters;
}

///The <b>IKEEXT_POLICY1</b> structure is used to store the IKE/AuthIP main mode negotiation policy.
///[IKEEXT_POLICY0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_policy0) is available.</div><div> </div>
struct IKEEXT_POLICY1
{
    ///Lifetime of the IPsec soft SA, in seconds. The caller must set this to 0.
    uint              softExpirationTime;
    ///Number of authentication methods.
    uint              numAuthenticationMethods;
    ///Array of acceptable authentication methods. See
    ///[IKEEXT_AUTHENTICATION_METHOD1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_authentication_method1) for more
    ///information.
    IKEEXT_AUTHENTICATION_METHOD1* authenticationMethods;
    ///Type of impersonation. Applies only to AuthIP. See IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE for more information.
    IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE initiatorImpersonationType;
    ///Number of main mode proposals.
    uint              numIkeProposals;
    ///Array of main mode proposals. See [IKEEXT_PROPOSAL0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_proposal0)
    ///for more information.
    IKEEXT_PROPOSAL0* ikeProposals;
    ///A combination of the following values. <table> <tr> <th>IKE/AuthIP policy flag</th> <th>Meaning</th> </tr> <tr>
    ///<td width="40%"><a id="IKEEXT_POLICY_FLAG_DISABLE_DIAGNOSTICS"></a><a
    ///id="ikeext_policy_flag_disable_diagnostics"></a><dl> <dt><b>IKEEXT_POLICY_FLAG_DISABLE_DIAGNOSTICS</b></dt> </dl>
    ///</td> <td width="60%"> Disable special diagnostics mode for IKE/Authip. This will prevent IKE/AuthIp from
    ///accepting unauthenticated notifications from peer, or sending MS_STATUS notifications to peer. </td> </tr> <tr>
    ///<td width="40%"><a id="IKEEXT_POLICY_FLAG_NO_MACHINE_LUID_VERIFY"></a><a
    ///id="ikeext_policy_flag_no_machine_luid_verify"></a><dl> <dt><b>IKEEXT_POLICY_FLAG_NO_MACHINE_LUID_VERIFY</b></dt>
    ///</dl> </td> <td width="60%"> Disable SA verification of machine LUID. </td> </tr> <tr> <td width="40%"><a
    ///id="IKEEXT_POLICY_FLAG_NO_IMPERSONATION_LUID_VERIFY"></a><a
    ///id="ikeext_policy_flag_no_impersonation_luid_verify"></a><dl>
    ///<dt><b>IKEEXT_POLICY_FLAG_NO_IMPERSONATION_LUID_VERIFY</b></dt> </dl> </td> <td width="60%"> Disable SA
    ///verification of machine impersonation LUID. </td> </tr> <tr> <td width="40%"><a
    ///id="IKEEXT_POLICY_FLAG_ENABLE_OPTIONAL_DH"></a><a id="ikeext_policy_flag_enable_optional_dh"></a><dl>
    ///<dt><b>IKEEXT_POLICY_FLAG_ENABLE_OPTIONAL_DH</b></dt> </dl> </td> <td width="60%"> Allow the responder to accept
    ///any DH proposal, including no DH, regardless of what is configured in policy. This flag is valid only if AuthIP
    ///is used. </td> </tr> </table>
    uint              flags;
    ///Maximum number of dynamic IPsec filters per remote IP address and per transport layer that is allowed to be added
    ///for any SA negotiated using this policy. Set this to 0 to disable dynamic filter addition. Dynamic filters are
    ///added by IKE/AuthIP on responder, when the QM traffic proposed by initiator is a subset of responder's traffic
    ///configuration.
    uint              maxDynamicFilters;
    ///The number of seconds for which IKEv2 SA negotiation packets will be retransmitted before the SA times out. The
    ///caller must set this to at least 120 seconds.
    uint              retransmitDurationSecs;
}

///The <b>IKEEXT_POLICY2</b> structure is used to store the IKE/AuthIP main mode negotiation policy.
///[IKEEXT_POLICY0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_policy0) is available.</div><div> </div>
struct IKEEXT_POLICY2
{
    ///Type: <b>UINT32</b> Lifetime of the IPsec soft SA, in seconds. The caller must set this to 0.
    uint              softExpirationTime;
    ///Type: <b>UINT32</b> Number of authentication methods.
    uint              numAuthenticationMethods;
    ///Type:
    ///[IKEEXT_AUTHENTICATION_METHOD2](/windows/desktop/api/iketypes/ns-iketypes-ikeext_authentication_method2)*</b>
    ///Array of acceptable authentication methods.
    IKEEXT_AUTHENTICATION_METHOD2* authenticationMethods;
    ///Type: <b>IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE</b> Type of impersonation. Applies only to AuthIP.
    IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE initiatorImpersonationType;
    ///Type: <b>UINT32</b> Number of main mode proposals.
    uint              numIkeProposals;
    ///Type: [IKEEXT_PROPOSAL0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_proposal0)*</b> Array of main mode
    ///proposals.
    IKEEXT_PROPOSAL0* ikeProposals;
    ///Type: <b>UINT32</b> A combination of the following values. <table> <tr> <th>IKE/AuthIP policy flag</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="IKEEXT_POLICY_FLAG_DISABLE_DIAGNOSTICS"></a><a
    ///id="ikeext_policy_flag_disable_diagnostics"></a><dl> <dt><b>IKEEXT_POLICY_FLAG_DISABLE_DIAGNOSTICS</b></dt> </dl>
    ///</td> <td width="60%"> Disable special diagnostics mode for IKE/Authip. This will prevent IKE/AuthIp from
    ///accepting unauthenticated notifications from peer, or sending MS_STATUS notifications to peer. </td> </tr> <tr>
    ///<td width="40%"><a id="IKEEXT_POLICY_FLAG_NO_MACHINE_LUID_VERIFY"></a><a
    ///id="ikeext_policy_flag_no_machine_luid_verify"></a><dl> <dt><b>IKEEXT_POLICY_FLAG_NO_MACHINE_LUID_VERIFY</b></dt>
    ///</dl> </td> <td width="60%"> Disable SA verification of machine LUID. </td> </tr> <tr> <td width="40%"><a
    ///id="IKEEXT_POLICY_FLAG_NO_IMPERSONATION_LUID_VERIFY"></a><a
    ///id="ikeext_policy_flag_no_impersonation_luid_verify"></a><dl>
    ///<dt><b>IKEEXT_POLICY_FLAG_NO_IMPERSONATION_LUID_VERIFY</b></dt> </dl> </td> <td width="60%"> Disable SA
    ///verification of machine impersonation LUID. </td> </tr> <tr> <td width="40%"><a
    ///id="IKEEXT_POLICY_FLAG_ENABLE_OPTIONAL_DH"></a><a id="ikeext_policy_flag_enable_optional_dh"></a><dl>
    ///<dt><b>IKEEXT_POLICY_FLAG_ENABLE_OPTIONAL_DH</b></dt> </dl> </td> <td width="60%"> Allow the responder to accept
    ///any DH proposal, including no DH, regardless of what is configured in policy. This flag is valid only if AuthIP
    ///is used. </td> </tr> </table>
    uint              flags;
    ///Type: <b>UINT32</b> Maximum number of dynamic IPsec filters per remote IP address and per transport layer that is
    ///allowed to be added for any SA negotiated using this policy. Set this to 0 to disable dynamic filter addition.
    ///Dynamic filters are added by IKE/AuthIP on responder, when the QM traffic proposed by initiator is a subset of
    ///responder's traffic configuration.
    uint              maxDynamicFilters;
    ///Type: <b>UINT32</b> The number of seconds for which IKEv2 SA negotiation packets will be retransmitted before the
    ///SA times out. The caller must set this to at least 120 seconds.
    uint              retransmitDurationSecs;
}

///The <b>IKEEXT_EM_POLICY0</b> structure is used to store AuthIP's extended mode negotiation policy.
///[IKEEXT_EM_POLICY2](/windows/desktop/api/iketypes/ns-iketypes-ikeext_em_policy2) is available.</div><div> </div>
struct IKEEXT_EM_POLICY0
{
    ///Number of authentication methods in the array.
    uint numAuthenticationMethods;
    ///size_is(numAuthenticationMethods) Array of acceptable authentication methods as specified by
    ///[IKEEXT_AUTHENTICATION_METHOD0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_authentication_method0).
    IKEEXT_AUTHENTICATION_METHOD0* authenticationMethods;
    ///Type of impersonation. See IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE for more information.
    IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE initiatorImpersonationType;
}

///The <b>IKEEXT_EM_POLICY1</b> structure is used to store AuthIP's extended mode negotiation policy.
///[IKEEXT_EM_POLICY2](/windows/desktop/api/iketypes/ns-iketypes-ikeext_em_policy2) is available. For Windows Vista,
///[IKEEXT_EM_POLICY0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_em_policy0) is available.</div><div> </div>
struct IKEEXT_EM_POLICY1
{
    ///Number of authentication methods in the array.
    uint numAuthenticationMethods;
    ///size_is(numAuthenticationMethods) Array of acceptable authentication methods as specified by
    ///[IKEEXT_AUTHENTICATION_METHOD1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_authentication_method1).
    IKEEXT_AUTHENTICATION_METHOD1* authenticationMethods;
    ///Type of impersonation. See IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE for more information.
    IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE initiatorImpersonationType;
}

///The <b>IKEEXT_EM_POLICY2</b> structure is used to store AuthIP's extended mode negotiation policy.
///[IKEEXT_EM_POLICY0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_em_policy0) is available.</div><div> </div>
struct IKEEXT_EM_POLICY2
{
    ///Type: <b>UINT32</b> Number of authentication methods in the array.
    uint numAuthenticationMethods;
    ///Type:
    ///[IKEEXT_AUTHENTICATION_METHOD2](/windows/desktop/api/iketypes/ns-iketypes-ikeext_authentication_method2)*</b>
    ///size_is(numAuthenticationMethods) Array of acceptable authentication methods.
    IKEEXT_AUTHENTICATION_METHOD2* authenticationMethods;
    ///Type: <b>IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE</b> Type of impersonation.
    IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE initiatorImpersonationType;
}

///The <b>IKEEXT_IP_VERSION_SPECIFIC_KEYMODULE_STATISTICS0</b> structure contains various statistics specific to the
///keying module and IP version.
///[IKEEXT_IP_VERSION_SPECIFIC_KEYMODULE_STATISTICS1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_ip_version_specific_keymodule_statistics1)
///is available.</div><div> </div>
struct IKEEXT_IP_VERSION_SPECIFIC_KEYMODULE_STATISTICS0
{
    ///Current number of active Main Mode SAs.
    uint currentActiveMainModes;
    ///Total number of Main Mode negotiations.
    uint totalMainModesStarted;
    ///Total number of successful Main Mode negotiations.
    uint totalSuccessfulMainModes;
    ///Total number of failed Main Mode negotiations.
    uint totalFailedMainModes;
    ///Total number of Main Mode negotiations that were externally initiated by a peer.
    uint totalResponderMainModes;
    ///Current number of newly created responder Main Modes that are still in the initial state.
    uint currentNewResponderMainModes;
    ///Current number of active Quick Mode SAs.
    uint currentActiveQuickModes;
    ///Total number of Quick Mode negotiations.
    uint totalQuickModesStarted;
    ///Total number of successful Quick Mode negotiations.
    uint totalSuccessfulQuickModes;
    ///Total number of failed Quick Mode negotiations.
    uint totalFailedQuickModes;
    ///Total number of acquires received from BFE.
    uint totalAcquires;
    ///Total number of acquires that were internally reinitiated.
    uint totalReinitAcquires;
    ///Current number of active extended mode SAs.
    uint currentActiveExtendedModes;
    ///Total number of extended mode negotiations.
    uint totalExtendedModesStarted;
    ///Total number of successful extended mode negotiations.
    uint totalSuccessfulExtendedModes;
    ///Total number of failed extended mode negotiations.
    uint totalFailedExtendedModes;
    ///Total number of successful extended mode negotiations that used impersonation.
    uint totalImpersonationExtendedModes;
    uint totalImpersonationMainModes;
}

///The <b>IKEEXT_IP_VERSION_SPECIFIC_KEYMODULE_STATISTICS1</b> structure contains various statistics specific to the
///keying module (IKE, Authip, and IKEv2) and IP version. <div class="alert"><b>Note</b>
///<b>IKEEXT_IP_VERSION_SPECIFIC_KEYMODULE_STATISTICS1</b> is the specific implementation of
///IKEEXT_IP_VERSION_SPECIFIC_KEYMODULE_STATISTICS used in Windows 7 and later. See WFP Version-Independent Names and
///Targeting Specific Versions of Windows for more information. For Windows Vista,
///IKEEXT_IP_VERSION_SPECIFIC_KEYMODULE_STATISTICS0 is available.</div><div> </div>
struct IKEEXT_IP_VERSION_SPECIFIC_KEYMODULE_STATISTICS1
{
    ///Current number of active Main Mode SAs.
    uint currentActiveMainModes;
    ///Total number of Main Mode negotiations.
    uint totalMainModesStarted;
    ///Total number of successful Main Mode negotiations.
    uint totalSuccessfulMainModes;
    ///Total number of failed Main Mode negotiations.
    uint totalFailedMainModes;
    ///Total number of Main Mode negotiations that were externally initiated by a peer.
    uint totalResponderMainModes;
    ///Current number of newly created responder Main Modes that are still in the initial state.
    uint currentNewResponderMainModes;
    ///Current number of active Quick Mode SAs.
    uint currentActiveQuickModes;
    ///Total number of Quick Mode negotiations.
    uint totalQuickModesStarted;
    ///Total number of successful Quick Mode negotiations.
    uint totalSuccessfulQuickModes;
    ///Total number of failed Quick Mode negotiations.
    uint totalFailedQuickModes;
    ///Total number of acquires received from BFE.
    uint totalAcquires;
    ///Total number of acquires that were internally reinitiated.
    uint totalReinitAcquires;
    ///Current number of active extended mode SAs.
    uint currentActiveExtendedModes;
    ///Total number of extended mode negotiations.
    uint totalExtendedModesStarted;
    ///Total number of successful extended mode negotiations.
    uint totalSuccessfulExtendedModes;
    ///Total number of failed extended mode negotiations.
    uint totalFailedExtendedModes;
    ///Total number of successful extended mode negotiations that used impersonation.
    uint totalImpersonationExtendedModes;
    ///Total number of successful Main Mode mode negotiations that used impersonation.
    uint totalImpersonationMainModes;
}

///The <b>IKEEXT_KEYMODULE_STATISTICS0</b> structure contains various statistics specific to the keying module.
///[IKEEXT_KEYMODULE_STATISTICS1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_keymodule_statistics1) is
///available.</div><div> </div>
struct IKEEXT_KEYMODULE_STATISTICS0
{
    ///IPv4 common statistics. See IKEEXT_IP_VERSION_SPECIFIC_KEYMODULE_STATISTICS0 for more information.
    IKEEXT_IP_VERSION_SPECIFIC_KEYMODULE_STATISTICS0 v4Statistics;
    ///IPv6 common statistics. See IKEEXT_IP_VERSION_SPECIFIC_KEYMODULE_STATISTICS0 for more information.
    IKEEXT_IP_VERSION_SPECIFIC_KEYMODULE_STATISTICS0 v6Statistics;
    ///Table containing the frequencies of various IKE Win32 error codes encountered during negotiations. The error
    ///codes range from ERROR_IPSEC_IKE_NEG_STATUS_BEGIN to ERROR_IPSEC_IKE_NEG_STATUS_END. The table size,
    ///IKEEXT_ERROR_CODE_COUNT, is 84 (ERROR_IPSEC_IKE_NEG_STATUS_END - ERROR_IPSEC_IKE_NEG_STATUS_BEGIN).
    uint[97] errorFrequencyTable;
    ///Current Main Mode negotiation time.
    uint     mainModeNegotiationTime;
    ///Current Quick Mode negotiation time.
    uint     quickModeNegotiationTime;
    uint     extendedModeNegotiationTime;
}

///The <b>IKEEXT_KEYMODULE_STATISTICS1</b> structure contains various statistics specific to the keying module.
///[IKEEXT_KEYMODULE_STATISTICS0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_keymodule_statistics0) is
///available.</div><div> </div>
struct IKEEXT_KEYMODULE_STATISTICS1
{
    ///IPv4 common statistics. See IKEEXT_IP_VERSION_SPECIFIC_KEYMODULE_STATISTICS1 for more information.
    IKEEXT_IP_VERSION_SPECIFIC_KEYMODULE_STATISTICS1 v4Statistics;
    ///IPv6 common statistics. See IKEEXT_IP_VERSION_SPECIFIC_KEYMODULE_STATISTICS1 for more information.
    IKEEXT_IP_VERSION_SPECIFIC_KEYMODULE_STATISTICS1 v6Statistics;
    ///Table containing the frequencies of various IKE Win32 error codes encountered during negotiations. The error
    ///codes range from ERROR_IPSEC_IKE_NEG_STATUS_BEGIN to ERROR_IPSEC_IKE_NEG_STATUS_END. The table size,
    ///IKEEXT_ERROR_CODE_COUNT, is 84 (ERROR_IPSEC_IKE_NEG_STATUS_END - ERROR_IPSEC_IKE_NEG_STATUS_BEGIN).
    uint[97] errorFrequencyTable;
    ///Current Main Mode negotiation time.
    uint     mainModeNegotiationTime;
    ///Current Quick Mode negotiation time.
    uint     quickModeNegotiationTime;
    ///Current Extended Mode negotiation time. This member is applicable for AuthIp only.
    uint     extendedModeNegotiationTime;
}

///The <b>IKEEXT_IP_VERSION_SPECIFIC_COMMON_STATISTICS0</b> structure contains various statistics common to IKE and
///Authip.
///[IKEEXT_IP_VERSION_SPECIFIC_COMMON_STATISTICS1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_ip_version_specific_common_statistics1)
///is available.</div><div> </div>
struct IKEEXT_IP_VERSION_SPECIFIC_COMMON_STATISTICS0
{
    ///Total number of UDP 500/4500 socket receive failures.
    uint totalSocketReceiveFailures;
    uint totalSocketSendFailures;
}

///The <b>IKEEXT_IP_VERSION_SPECIFIC_COMMON_STATISTICS1</b> structure contains various statistics common to the keying
///module (IKE, Authip, and IKEv2).
///[IKEEXT_IP_VERSION_SPECIFIC_COMMON_STATISTICS0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_ip_version_specific_common_statistics0)
///is available.</div><div> </div>
struct IKEEXT_IP_VERSION_SPECIFIC_COMMON_STATISTICS1
{
    ///Total number of UDP 500/4500 socket receive failures.
    uint totalSocketReceiveFailures;
    ///Total number of UDP 500/4500 socket send failures.
    uint totalSocketSendFailures;
}

///The <b>IKEEXT_COMMON_STATISTICS0</b> structure contains various statistics common to IKE and Authip.
///[IKEEXT_COMMON_STATISTICS1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_common_statistics1) is
///available.</div><div> </div>
struct IKEEXT_COMMON_STATISTICS0
{
    ///IPv4 common statistics. See IKEEXT_IP_VERSION_SPECIFIC_COMMON_STATISTICS0 for more information.
    IKEEXT_IP_VERSION_SPECIFIC_COMMON_STATISTICS0 v4Statistics;
    ///IPv6 common statistics. See IKEEXT_IP_VERSION_SPECIFIC_COMMON_STATISTICS0 for more information.
    IKEEXT_IP_VERSION_SPECIFIC_COMMON_STATISTICS0 v6Statistics;
    ///Total number of packets received.
    uint totalPacketsReceived;
    ///Total number of invalid packets received.
    uint totalInvalidPacketsReceived;
    uint currentQueuedWorkitems;
}

///The <b>IKEEXT_COMMON_STATISTICS1</b> structure contains various statistics common to IKE, Authip, and IKEv2.
///[IKEEXT_COMMON_STATISTICS0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_common_statistics0) is
///available.</div><div> </div>
struct IKEEXT_COMMON_STATISTICS1
{
    ///IPv4 common statistics. See IKEEXT_IP_VERSION_SPECIFIC_COMMON_STATISTICS1 for more information.
    IKEEXT_IP_VERSION_SPECIFIC_COMMON_STATISTICS1 v4Statistics;
    ///IPv6 common statistics. See IKEEXT_IP_VERSION_SPECIFIC_COMMON_STATISTICS1 for more information.
    IKEEXT_IP_VERSION_SPECIFIC_COMMON_STATISTICS1 v6Statistics;
    ///Total number of packets received.
    uint totalPacketsReceived;
    ///Total number of invalid packets received.
    uint totalInvalidPacketsReceived;
    ///Current number of work items that are queued and waiting to be processed.
    uint currentQueuedWorkitems;
}

///The <b>IKEEXT_STATISTICS0</b> structure stores various IKE/AuthIP statistics.
///[IKEEXT_STATISTICS1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_statistics1) is available.</div><div> </div>
struct IKEEXT_STATISTICS0
{
    ///Statistics specific to IKE. See
    ///[IKEEXT_KEYMODULE_STATISTICS0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_keymodule_statistics0) for more
    ///information.
    IKEEXT_KEYMODULE_STATISTICS0 ikeStatistics;
    ///Statistics specific to AuthIP. See
    ///[IKEEXT_KEYMODULE_STATISTICS0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_keymodule_statistics0) for more
    ///information.
    IKEEXT_KEYMODULE_STATISTICS0 authipStatistics;
    ///Statistics common to IKE and AuthIP. See
    ///[IKEEXT_COMMON_STATISTICS0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_common_statistics0) for more
    ///information.
    IKEEXT_COMMON_STATISTICS0 commonStatistics;
}

///The [IKEEXT_STATISTICS1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_statistics0) structure stores various IKE,
///AuthIP, and IKEv2 statistics. [IKEEXT_STATISTICS1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_statistics0) is
///the specific implementation of IKEEXT_STATISTICS used in Windows 7 and later. See WFP Version-Independent Names and
///Targeting Specific Versions of Windows for more information. For Windows Vista, <b>IKEEXT_STATISTICS0</b> is
///available.
struct IKEEXT_STATISTICS1
{
    ///Statistics specific to IKE. See
    ///[IKEEXT_KEYMODULE_STATISTICS1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_keymodule_statistics1) for more
    ///information.
    IKEEXT_KEYMODULE_STATISTICS1 ikeStatistics;
    ///Statistics specific to AuthIP. See
    ///[IKEEXT_KEYMODULE_STATISTICS1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_keymodule_statistics1) for more
    ///information.
    IKEEXT_KEYMODULE_STATISTICS1 authipStatistics;
    ///Statistics specific to IKEv2. See
    ///[IKEEXT_KEYMODULE_STATISTICS1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_keymodule_statistics1) for more
    ///information.
    IKEEXT_KEYMODULE_STATISTICS1 ikeV2Statistics;
    ///Statistics common to IKE, AuthIP, and IKEv2. See
    ///[IKEEXT_COMMON_STATISTICS1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_common_statistics1) for more
    ///information.
    IKEEXT_COMMON_STATISTICS1 commonStatistics;
}

///The <b>IKEEXT_TRAFFIC0</b> structure specifies the IKE/Authip traffic.
struct IKEEXT_TRAFFIC0
{
    ///IP version specified by [FWP_IP_VERSION](/windows/desktop/api/fwptypes/ne-fwptypes-fwp_ip_version).
    FWP_IP_VERSION ipVersion;
union
    {
        uint      localV4Address;
        ubyte[16] localV6Address;
    }
union
    {
        uint      remoteV4Address;
        ubyte[16] remoteV6Address;
    }
    ///Filter ID from quick mode (QM) policy of matching extended mode (EM) filter.
    ulong          authIpFilterId;
}

///The <b>IKEEXT_COOKIE_PAIR0</b> structure used to store a pair of IKE/Authip cookies.
struct IKEEXT_COOKIE_PAIR0
{
    ///Initiator cookie. An IKEEXT_COOKIE is a UINT64.
    ulong initiator;
    ///Responder cookie. An IKEEXT_COOKIE is a UINT64.
    ulong responder;
}

///The <b>IKEEXT_CERTIFICATE_CREDENTIAL0</b> structure is used to store credential information specific to certificate
///authentication.
///[IKEEXT_CERTIFICATE_CREDENTIAL1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_certificate_credential1) is
///available.</div><div> </div>
struct IKEEXT_CERTIFICATE_CREDENTIAL0
{
    ///Encoded subject name of the certificate used for authentication. See
    ///[FWP_BYTE_BLOB](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_byte_blob) for more information.
    FWP_BYTE_BLOB subjectName;
    ///SHA thumbprint of the certificate. See [FWP_BYTE_BLOB](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_byte_blob)
    ///for more information.
    FWP_BYTE_BLOB certHash;
    ///Possible values: <a id="IKEEXT_CERT_CREDENTIAL_FLAG_NAP_CERT"></a> <a
    ///id="ikeext_cert_credential_flag_nap_cert"></a>
    uint          flags;
}

///The <b>IKEEXT_NAME_CREDENTIAL0</b> structure is used to store credential name information.
struct IKEEXT_NAME_CREDENTIAL0
{
    ///Name of the principal.
    PWSTR principalName;
}

///The <b>IKEEXT_CREDENTIAL0</b> structure is used to store credential information used for the authentication.
///[IKEEXT_CREDENTIAL1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credential1) is available. For Windows 8,
///[IKEEXT_CREDENTIAL2](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credential2) is available.</div><div> </div>
struct IKEEXT_CREDENTIAL0
{
    ///Type of authentication method. See IKEEXT_AUTHENTICATION_METHOD_TYPE for more information.
    IKEEXT_AUTHENTICATION_METHOD_TYPE authenticationMethodType;
    ///Type of impersonation. See IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE for more information.
    IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE impersonationType;
union
    {
        IKEEXT_PRESHARED_KEY_AUTHENTICATION0* presharedKey;
        IKEEXT_CERTIFICATE_CREDENTIAL0* certificate;
        IKEEXT_NAME_CREDENTIAL0* name;
    }
}

///The <b>IKEEXT_CREDENTIAL_PAIR0</b> structure is used to store credential information used for the authentication.
///[IKEEXT_CREDENTIAL_PAIR2](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credential_pair2) is available.</div><div>
///</div>
struct IKEEXT_CREDENTIAL_PAIR0
{
    ///Local credentials used for authentication. See
    ///[IKEEXT_CREDENTIAL0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credential0) for more information.
    IKEEXT_CREDENTIAL0 localCredentials;
    ///Peer credentials used for authentication. See
    ///[IKEEXT_CREDENTIAL0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credential0) for more information.
    IKEEXT_CREDENTIAL0 peerCredentials;
}

///The <b>IKEEXT_CREDENTIALS0</b> structure is used to store multiple credential pairs.
///[IKEEXT_CREDENTIALS1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credentials1) is available. For Windows 8,
///[IKEEXT_CREDENTIALS2](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credentials2) is available.</div><div> </div>
struct IKEEXT_CREDENTIALS0
{
    ///Number of [IKEEXT_CREDENTIAL_PAIR0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credential_pair0) structures
    ///in the array.
    uint numCredentials;
    ///[size_is(numCredentials)] Pointer to an array of
    ///[IKEEXT_CREDENTIAL_PAIR0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credential_pair0) structures.
    IKEEXT_CREDENTIAL_PAIR0* credentials;
}

///The <b>IKEEXT_SA_DETAILS0</b> structure is used to store information returned when enumerating IKE, AuthIP, or IKEv2
///security associations (SAs). [IKEEXT_SA_DETAILS2](/windows/desktop/api/iketypes/ns-iketypes-ikeext_sa_details2) is
///available. </div><div> </div>
struct IKEEXT_SA_DETAILS0
{
    ///LUID identifying the security association.
    ulong               saId;
    ///Key module type. See [IKEEXT_KEY_MODULE_TYPE](/windows/desktop/api/iketypes/ne-iketypes-ikeext_key_module_type)
    ///for more information.
    IKEEXT_KEY_MODULE_TYPE keyModuleType;
    ///IP version specified by [FWP_IP_VERSION](/windows/desktop/api/fwptypes/ne-fwptypes-fwp_ip_version).
    FWP_IP_VERSION      ipVersion;
union
    {
        IPSEC_V4_UDP_ENCAPSULATION0* v4UdpEncapsulation;
    }
    ///The traffic corresponding to this IKE SA specified by
    ///[IKEEXT_TRAFFIC0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_traffic0).
    IKEEXT_TRAFFIC0     ikeTraffic;
    ///The main mode proposal corresponding to this IKE SA specified by
    ///[IKEEXT_PROPOSAL0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_proposal0).
    IKEEXT_PROPOSAL0    ikeProposal;
    ///SA cookies specified by [IKEEXT_COOKIE_PAIR0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_cookie_pair0).
    IKEEXT_COOKIE_PAIR0 cookiePair;
    ///Credentials information for the SA specified by
    ///[IKEEXT_CREDENTIALS0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credentials0).
    IKEEXT_CREDENTIALS0 ikeCredentials;
    ///GUID of the main mode policy provider context corresponding to this SA.
    GUID                ikePolicyKey;
    ///ID/Handle to virtual interface tunneling state. Applicable only to IKEv2. Available only on Windows 7, Windows
    ///Server 2008 R2, and later.
    ulong               virtualIfTunnelId;
}

///The [IKEEXT_CERTIFICATE_CREDENTIAL0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_certificate_credential0) is
///available.</div> <div> </div>
struct IKEEXT_CERTIFICATE_CREDENTIAL1
{
    ///Encoded subject name of the certificate used for authentication. Use CertNameToStr to convert the encoded name to
    ///string. See [FWP_BYTE_BLOB](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_byte_blob) for more information.
    FWP_BYTE_BLOB subjectName;
    ///SHA thumbprint of the certificate. See [FWP_BYTE_BLOB](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_byte_blob)
    ///for more information.
    FWP_BYTE_BLOB certHash;
    ///Possible values: <a id="IKEEXT_CERT_CREDENTIAL_FLAG_NAP_CERT"></a> <a
    ///id="ikeext_cert_credential_flag_nap_cert"></a>
    uint          flags;
    ///The encoded certificate. Use CertCreateCertificateContext to create a certificate context from the encoded
    ///certificate. See [FWP_BYTE_BLOB](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_byte_blob) for more information.
    FWP_BYTE_BLOB certificate;
}

///The <b>IKEEXT_CREDENTIAL1</b> structure is used to store credential information used for the authentication.
///[IKEEXT_CREDENTIAL2](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credential2) is available. For Windows Vista,
///[IKEEXT_CREDENTIAL0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credential0) is available.</div><div> </div>
struct IKEEXT_CREDENTIAL1
{
    ///Type of authentication method. See IKEEXT_AUTHENTICATION_METHOD_TYPE for more information.
    IKEEXT_AUTHENTICATION_METHOD_TYPE authenticationMethodType;
    ///Type of impersonation. See IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE for more information.
    IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE impersonationType;
union
    {
        IKEEXT_PRESHARED_KEY_AUTHENTICATION1* presharedKey;
        IKEEXT_CERTIFICATE_CREDENTIAL1* certificate;
        IKEEXT_NAME_CREDENTIAL0* name;
    }
}

///The <b>IKEEXT_CREDENTIAL_PAIR1</b> structure is used to store credential information used for the authentication.
///[IKEEXT_CREDENTIAL_PAIR2](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credential_pair2) is available. For
///Windows Vista, [IKEEXT_CREDENTIAL_PAIR0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credential_pair0) is
///available.</div><div> </div>
struct IKEEXT_CREDENTIAL_PAIR1
{
    ///Local credentials used for authentication. See
    ///[IKEEXT_CREDENTIAL1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credential1) for more information.
    IKEEXT_CREDENTIAL1 localCredentials;
    ///Peer credentials used for authentication. See
    ///[IKEEXT_CREDENTIAL1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credential1) for more information.
    IKEEXT_CREDENTIAL1 peerCredentials;
}

///The <b>IKEEXT_CREDENTIALS1</b> structure is used to store multiple credential pairs.
///[IKEEXT_CREDENTIALS0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credentials0) is available.</div><div> </div>
struct IKEEXT_CREDENTIALS1
{
    ///Number of [IKEEXT_CREDENTIAL_PAIR1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credential_pair1) structures
    ///in the array.
    uint numCredentials;
    ///[size_is(numCredentials)] Pointer to an array of
    ///[IKEEXT_CREDENTIAL_PAIR1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credential_pair1) structures.
    IKEEXT_CREDENTIAL_PAIR1* credentials;
}

///The <b>IKEEXT_SA_DETAILS1</b> structure is used to store information returned when enumerating IKE, AuthIP, and IKEv2
///security associations (SAs). [IKEEXT_SA_DETAILS0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_sa_details0) is
///available.</div><div> </div>
struct IKEEXT_SA_DETAILS1
{
    ///LUID identifying the security association.
    ulong               saId;
    ///Key module type. See [IKEEXT_KEY_MODULE_TYPE](/windows/desktop/api/iketypes/ne-iketypes-ikeext_key_module_type)
    ///for more information.
    IKEEXT_KEY_MODULE_TYPE keyModuleType;
    ///IP version specified by [FWP_IP_VERSION](/windows/desktop/api/fwptypes/ne-fwptypes-fwp_ip_version).
    FWP_IP_VERSION      ipVersion;
union
    {
        IPSEC_V4_UDP_ENCAPSULATION0* v4UdpEncapsulation;
    }
    ///The traffic corresponding to this IKE SA specified by
    ///[IKEEXT_TRAFFIC0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_traffic0).
    IKEEXT_TRAFFIC0     ikeTraffic;
    ///The main mode proposal corresponding to this IKE SA specified by
    ///[IKEEXT_PROPOSAL0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_proposal0).
    IKEEXT_PROPOSAL0    ikeProposal;
    ///SA cookies specified by [IKEEXT_COOKIE_PAIR0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_cookie_pair0).
    IKEEXT_COOKIE_PAIR0 cookiePair;
    ///Credentials information for the SA specified by
    ///[IKEEXT_CREDENTIALS1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credentials1).
    IKEEXT_CREDENTIALS1 ikeCredentials;
    ///GUID of the main mode policy provider context corresponding to this SA.
    GUID                ikePolicyKey;
    ///ID/Handle to virtual interface tunneling state. Applicable only to IKEv2.
    ulong               virtualIfTunnelId;
    FWP_BYTE_BLOB       correlationKey;
}

///The <b>IKEEXT_CREDENTIAL2</b> structure is used to store credential information used for the authentication.
///[IKEEXT_CREDENTIAL1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credential1) is available. For Windows Vista,
///[IKEEXT_CREDENTIAL0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credential0) is available.</div><div> </div>
struct IKEEXT_CREDENTIAL2
{
    ///Type: <b>IKEEXT_AUTHENTICATION_METHOD_TYPE</b> Type of authentication method.
    IKEEXT_AUTHENTICATION_METHOD_TYPE authenticationMethodType;
    ///Type: <b>IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE</b> Type of impersonation.
    IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE impersonationType;
union
    {
        IKEEXT_PRESHARED_KEY_AUTHENTICATION1* presharedKey;
        IKEEXT_CERTIFICATE_CREDENTIAL1* certificate;
        IKEEXT_NAME_CREDENTIAL0* name;
    }
}

///The <b>IKEEXT_CREDENTIAL_PAIR2</b> structure is used to store credential information used for the authentication.
///[IKEEXT_CREDENTIAL_PAIR1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credential_pair1) is available. For
///Windows Vista, [IKEEXT_CREDENTIAL_PAIR0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credential_pair0) is
///available.</div><div> </div>
struct IKEEXT_CREDENTIAL_PAIR2
{
    ///Type: [IKEEXT_CREDENTIAL2](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credential2)</b> Local credentials
    ///used for authentication.
    IKEEXT_CREDENTIAL2 localCredentials;
    ///Type: [IKEEXT_CREDENTIAL2](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credential2)</b> Peer credentials
    ///used for authentication.
    IKEEXT_CREDENTIAL2 peerCredentials;
}

///The <b>IKEEXT_CREDENTIALS2</b> structure is used to store multiple credential pairs.
///[IKEEXT_CREDENTIALS1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credentials1) is available. For Windows Vista,
///[IKEEXT_CREDENTIALS0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credentials0) is available.</div><div> </div>
struct IKEEXT_CREDENTIALS2
{
    ///Type: <b>UINT32</b> Number of
    ///[IKEEXT_CREDENTIAL_PAIR2](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credential_pair2) structures in the
    ///array.
    uint numCredentials;
    ///Type: [IKEEXT_CREDENTIAL_PAIR2](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credential_pair2)*</b>
    ///[size_is(numCredentials)] Pointer to an array of
    ///[IKEEXT_CREDENTIAL_PAIR2](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credential_pair2) structures.
    IKEEXT_CREDENTIAL_PAIR2* credentials;
}

///The <b>IKEEXT_SA_DETAILS2</b> structure is used to store information returned when enumerating IKE, AuthIP, and IKEv2
///security associations (SAs). [IKEEXT_SA_DETAILS1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_sa_details1) is
///available. For Windows Vista, [IKEEXT_SA_DETAILS0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_sa_details0) is
///available.</div><div> </div>
struct IKEEXT_SA_DETAILS2
{
    ///Type: <b>UINT64</b> LUID identifying the security association.
    ulong               saId;
    ///Type: [IKEEXT_KEY_MODULE_TYPE](/windows/desktop/api/iketypes/ne-iketypes-ikeext_key_module_type)</b> Key module
    ///type.
    IKEEXT_KEY_MODULE_TYPE keyModuleType;
    ///Type: [FWP_IP_VERSION](/windows/desktop/api/fwptypes/ne-fwptypes-fwp_ip_version)</b> The IP version.
    FWP_IP_VERSION      ipVersion;
union
    {
        IPSEC_V4_UDP_ENCAPSULATION0* v4UdpEncapsulation;
    }
    ///Type: [IKEEXT_TRAFFIC0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_traffic0)</b> The traffic corresponding
    ///to this IKE SA.
    IKEEXT_TRAFFIC0     ikeTraffic;
    ///Type: [IKEEXT_PROPOSAL0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_proposal0)</b> The main mode proposal
    ///corresponding to this IKE SA.
    IKEEXT_PROPOSAL0    ikeProposal;
    ///Type: [IKEEXT_COOKIE_PAIR0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_cookie_pair0)</b> The SA cookies.
    IKEEXT_COOKIE_PAIR0 cookiePair;
    ///Type: [IKEEXT_CREDENTIALS2](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credentials2)</b> Credentials
    ///information for the SA.
    IKEEXT_CREDENTIALS2 ikeCredentials;
    ///Type: <b>GUID</b> GUID of the main mode policy provider context corresponding to this SA.
    GUID                ikePolicyKey;
    ///Type: <b>UINT64</b> ID/Handle to virtual interface tunneling state. Applicable only to IKEv2.
    ulong               virtualIfTunnelId;
    ///Type: [FWP_BYTE_BLOB](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_byte_blob)</b> Key derived from
    ///authentications to allow external applications to cryptographically bind their exchanges with this SA.
    FWP_BYTE_BLOB       correlationKey;
}

///The <b>IKEEXT_SA_ENUM_TEMPLATE0</b> structureis an enumeration template used for enumerating IKE/AuthIP security
///associations (SAs).
struct IKEEXT_SA_ENUM_TEMPLATE0
{
    ///Matches SAs whose local address is on the specified subnet. Must be of one of the following types. <ul>
    ///<li>FWP_UINT32</li> <li>FWP_BYTE_ARRAY16_TYPE</li> <li>FWP_V4_ADDR_MASK</li> <li>FWP_V6_ADDR_MASK</li> </ul> See
    ///[FWP_CONDITION_VALUE0](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_condition_value0) for more information.
    FWP_CONDITION_VALUE0 localSubNet;
    ///Matches SAs whose remote address is on the specified subnet. Must be of one of the following types. <ul>
    ///<li>FWP_UINT32</li> <li>FWP_BYTE_ARRAY16_TYPE</li> <li>FWP_V4_ADDR_MASK</li> <li>FWP_V6_ADDR_MASK</li> </ul> See
    ///[FWP_CONDITION_VALUE0](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_condition_value0) for more information.
    FWP_CONDITION_VALUE0 remoteSubNet;
    ///Matches SAs with a matching local main mode SHA thumbprint. If none exist, this member will have a length of
    ///zero. See [FWP_BYTE_BLOB](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_byte_blob) for more information.
    FWP_BYTE_BLOB        localMainModeCertHash;
}

///The <b>IPSEC_SA_LIFETIME0</b> structure stores the lifetime in seconds/kilobytes/packets for an IPsec security
///association (SA).
struct IPSEC_SA_LIFETIME0
{
    ///SA lifetime in seconds.
    uint lifetimeSeconds;
    ///SA lifetime in kilobytes.
    uint lifetimeKilobytes;
    ///SA lifetime in packets.
    uint lifetimePackets;
}

///The <b>IPSEC_AUTH_TRANSFORM_ID0</b> structure is used to uniquely identify the hash algorithm used in an IPsec
///security association (SA).
struct IPSEC_AUTH_TRANSFORM_ID0
{
    ///The type of the hash algorithm as specified by
    ///[IPSEC_AUTH_TYPE](/windows/desktop/api/ipsectypes/ne-ipsectypes-ipsec_auth_type).
    IPSEC_AUTH_TYPE authType;
    ///Additional configuration information for the IPsec SA hash algorithm as specified by a <b>IPSEC_AUTH_CONFIG</b>
    ///which maps to a <b>UINT8</b>. Possible values: <table> <tr> <th>IPsec authentication configuration</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="IPSEC_AUTH_CONFIG_HMAC_MD5_96"></a><a
    ///id="ipsec_auth_config_hmac_md5_96"></a><dl> <dt><b>IPSEC_AUTH_CONFIG_HMAC_MD5_96</b></dt> </dl> </td> <td
    ///width="60%"> HMAC (Hash Message Authentication Code) secret key authentication algorithm. MD5 (Message Digest)
    ///data integrity and data origin authentication algorithm. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_AUTH_CONFIG_HMAC_SHA_1_96"></a><a id="ipsec_auth_config_hmac_sha_1_96"></a><dl>
    ///<dt><b>IPSEC_AUTH_CONFIG_HMAC_SHA_1_96</b></dt> </dl> </td> <td width="60%"> HMAC secret key authentication
    ///algorithm. SHA-1 (Secure Hash Algorithm) data integrity and data origin authentication algorithm. </td> </tr>
    ///<tr> <td width="40%"><a id="IPSEC_AUTH_CONFIG_HMAC_SHA_256_128"></a><a
    ///id="ipsec_auth_config_hmac_sha_256_128"></a><dl> <dt><b>IPSEC_AUTH_CONFIG_HMAC_SHA_256_128</b></dt> </dl> </td>
    ///<td width="60%"> HMAC secret key authentication algorithm. SHA-256 data integrity and data origin authentication
    ///algorithm. <div class="alert"><b>Note</b> Available only on Windows Server 2008, Windows Vista with SP1, and
    ///later.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a id="IPSEC_AUTH_CONFIG_GCM_AES_128"></a><a
    ///id="ipsec_auth_config_gcm_aes_128"></a><dl> <dt><b>IPSEC_AUTH_CONFIG_GCM_AES_128</b></dt> </dl> </td> <td
    ///width="60%"> GCM (Galois Counter Mode) secret key authentication algorithm. AES(Advanced Encryption Standard)
    ///data integrity and data origin authentication algorithm, with 128-bit key. <div class="alert"><b>Note</b>
    ///Available only on Windows Server 2008, Windows Vista with SP1, and later.</div> <div> </div> </td> </tr> <tr> <td
    ///width="40%"><a id="IPSEC_AUTH_CONFIG_GCM_AES_192"></a><a id="ipsec_auth_config_gcm_aes_192"></a><dl>
    ///<dt><b>IPSEC_AUTH_CONFIG_GCM_AES_192</b></dt> </dl> </td> <td width="60%"> GCM secret key authentication
    ///algorithm. AES data integrity and data origin authentication algorithm, with 192-bit key. <div
    ///class="alert"><b>Note</b> Available only on Windows Server 2008, Windows Vista with SP1, and later.</div> <div>
    ///</div> </td> </tr> <tr> <td width="40%"><a id="IPSEC_AUTH_CONFIG_GCM_AES_256"></a><a
    ///id="ipsec_auth_config_gcm_aes_256"></a><dl> <dt><b>IPSEC_AUTH_CONFIG_GCM_AES_256</b></dt> </dl> </td> <td
    ///width="60%"> GCM secret key authentication algorithm. AES data integrity and data origin authentication
    ///algorithm, with 256-bit key. <div class="alert"><b>Note</b> Available only on Windows Server 2008, Windows Vista
    ///with SP1, and later.</div> <div> </div> </td> </tr> </table>
    ubyte           authConfig;
}

///The <b>IPSEC_AUTH_TRANSFORM0</b> structure specifies hash specific information for an SA transform.
struct IPSEC_AUTH_TRANSFORM0
{
    ///The identifier of the hash algorithm as specified by
    ///[IPSEC_AUTH_TRANSFORM_ID0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_auth_transform_id0). Possible
    ///values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_AUTH_TRANSFORM_ID_HMAC_MD5_96"></a><a id="ipsec_auth_transform_id_hmac_md5_96"></a><dl>
    ///<dt><b>IPSEC_AUTH_TRANSFORM_ID_HMAC_MD5_96</b></dt> </dl> </td> <td width="60%"> IPSEC_AUTH_MD5,
    ///IPSEC_AUTH_CONFIG_HMAC_MD5_96 </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_AUTH_TRANSFORM_ID_HMAC_SHA_1_96"></a><a id="ipsec_auth_transform_id_hmac_sha_1_96"></a><dl>
    ///<dt><b>IPSEC_AUTH_TRANSFORM_ID_HMAC_SHA_1_96</b></dt> </dl> </td> <td width="60%"> IPSEC_AUTH_SHA_1,
    ///IPSEC_AUTH_CONFIG_HMAC_SHA_1_96 </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_AUTH_TRANSFORM_ID_HMAC_SHA_256_128"></a><a id="ipsec_auth_transform_id_hmac_sha_256_128"></a><dl>
    ///<dt><b>IPSEC_AUTH_TRANSFORM_ID_HMAC_SHA_256_128</b></dt> </dl> </td> <td width="60%"> IPSEC_AUTH_SHA_256,
    ///IPSEC_AUTH_CONFIG_HMAC_SHA_256_128 <div class="alert"><b>Note</b> Available only on Windows Server 2008, Windows
    ///Vista with SP1, and later.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_AUTH_TRANSFORM_ID_GCM_AES_128"></a><a id="ipsec_auth_transform_id_gcm_aes_128"></a><dl>
    ///<dt><b>IPSEC_AUTH_TRANSFORM_ID_GCM_AES_128</b></dt> </dl> </td> <td width="60%"> IPSEC_AUTH_AES_128,
    ///IPSEC_AUTH_CONFIG_GCM_AES_128 <div class="alert"><b>Note</b> Available only on Windows Server 2008, Windows Vista
    ///with SP1, and later.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_AUTH_TRANSFORM_ID_GCM_AES_192"></a><a id="ipsec_auth_transform_id_gcm_aes_192"></a><dl>
    ///<dt><b>IPSEC_AUTH_TRANSFORM_ID_GCM_AES_192</b></dt> </dl> </td> <td width="60%"> IPSEC_AUTH_AES_192,
    ///IPSEC_AUTH_CONFIG_GCM_AES_192 <div class="alert"><b>Note</b> Available only on Windows Server 2008, Windows Vista
    ///with SP1, and later.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_AUTH_TRANSFORM_ID_GCM_AES_256"></a><a id="ipsec_auth_transform_id_gcm_aes_256"></a><dl>
    ///<dt><b>IPSEC_AUTH_TRANSFORM_ID_GCM_AES_256</b></dt> </dl> </td> <td width="60%"> IPSEC_AUTH_AES_256,
    ///IPSEC_AUTH_CONFIG_GCM_AES_256 <div class="alert"><b>Note</b> Available only on Windows Server 2008, Windows Vista
    ///with SP1, and later.</div> <div> </div> </td> </tr> </table>
    IPSEC_AUTH_TRANSFORM_ID0 authTransformId;
    ///Unused parameter, always set this to <b>NULL</b>.
    GUID* cryptoModuleId;
}

///The <b>IPSEC_CIPHER_TRANSFORM_ID0</b> structure specifies information used to uniquely identify the encryption
///algorithm used in an IPsec SA.
struct IPSEC_CIPHER_TRANSFORM_ID0
{
    ///The type of the encryption algorithm as specified by
    ///[IPSEC_CIPHER_TYPE](/windows/desktop/api/ipsectypes/ne-ipsectypes-ipsec_cipher_type).
    IPSEC_CIPHER_TYPE cipherType;
    ///Additional configuration information for the encryption algorithm as specified by <b>IPSEC_CIPHER_CONFIG</b>
    ///which maps to a <b>UINT8</b>. Possible values: <table> <tr> <th>IPsec encryption configuration</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="IPSEC_CIPHER_CONFIG_CBC_DES"></a><a
    ///id="ipsec_cipher_config_cbc_des"></a><dl> <dt><b>IPSEC_CIPHER_CONFIG_CBC_DES</b></dt> </dl> </td> <td
    ///width="60%"> DES (Data Encryption Standard) algorithm. CBC (Cipher Block Chaining) mode of operation. </td> </tr>
    ///<tr> <td width="40%"><a id="IPSEC_CIPHER_CONFIG_CBC_3DES"></a><a id="ipsec_cipher_config_cbc_3des"></a><dl>
    ///<dt><b>IPSEC_CIPHER_CONFIG_CBC_3DES</b></dt> </dl> </td> <td width="60%"> 3DES algorithm. CBC mode of operation.
    ///</td> </tr> <tr> <td width="40%"><a id="IPSEC_CIPHER_CONFIG_CBC_AES_128"></a><a
    ///id="ipsec_cipher_config_cbc_aes_128"></a><dl> <dt><b>IPSEC_CIPHER_CONFIG_CBC_AES_128</b></dt> </dl> </td> <td
    ///width="60%"> AES-128 (Advanced Encryption Standard) algorithm. CBC mode of operation. </td> </tr> <tr> <td
    ///width="40%"><a id="IPSEC_CIPHER_CONFIG_CBC_AES_192"></a><a id="ipsec_cipher_config_cbc_aes_192"></a><dl>
    ///<dt><b>IPSEC_CIPHER_CONFIG_CBC_AES_192</b></dt> </dl> </td> <td width="60%"> AES-192 algorithm. CBC mode of
    ///operation. </td> </tr> <tr> <td width="40%"><a id="IPSEC_CIPHER_CONFIG_CBC_AES_256"></a><a
    ///id="ipsec_cipher_config_cbc_aes_256"></a><dl> <dt><b>IPSEC_CIPHER_CONFIG_CBC_AES_256</b></dt> </dl> </td> <td
    ///width="60%"> AES-256 algorithm. CBC mode of operation. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_CIPHER_CONFIG_GCM_AES_128"></a><a id="ipsec_cipher_config_gcm_aes_128"></a><dl>
    ///<dt><b>IPSEC_CIPHER_CONFIG_GCM_AES_128</b></dt> </dl> </td> <td width="60%"> AES-128 algorithm. GCM (Galois
    ///Counter Mode) mode of operation. <div class="alert"><b>Note</b> Available only on Windows Server 2008, Windows
    ///Vista with SP1, and later.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_CIPHER_CONFIG_GCM_AES_192"></a><a id="ipsec_cipher_config_gcm_aes_192"></a><dl>
    ///<dt><b>IPSEC_CIPHER_CONFIG_GCM_AES_192</b></dt> </dl> </td> <td width="60%"> AES-192 algorithm. GCM (Galois
    ///Counter Mode) mode of operation. <div class="alert"><b>Note</b> Available only on Windows Server 2008, Windows
    ///Vista with SP1, and later.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_CIPHER_CONFIG_GCM_AES_256"></a><a id="ipsec_cipher_config_gcm_aes_256"></a><dl>
    ///<dt><b>IPSEC_CIPHER_CONFIG_GCM_AES_256</b></dt> </dl> </td> <td width="60%"> AES-256 algorithm. GCM (Galois
    ///Counter Mode) mode of operation. <div class="alert"><b>Note</b> Available only on Windows Server 2008, Windows
    ///Vista with SP1, and later.</div> <div> </div> </td> </tr> </table>
    ubyte             cipherConfig;
}

///The <b>IPSEC_CIPHER_TRANSFORM0</b> structure is used to store encryption specific information for an SA transform in
///an IPsec quick mode policy.
struct IPSEC_CIPHER_TRANSFORM0
{
    ///The identifier of the encryption algorithm as specified by
    ///[IPSEC_CIPHER_TRANSFORM_ID0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_cipher_transform_id0). Possible
    ///values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_CIPHER_TRANSFORM_ID_CBC_DES"></a><a id="ipsec_cipher_transform_id_cbc_des"></a><dl>
    ///<dt><b>IPSEC_CIPHER_TRANSFORM_ID_CBC_DES</b></dt> </dl> </td> <td width="60%"> IPSEC_CIPHER_TYPE_DES,
    ///IPSEC_CIPHER_CONFIG_CBC_DES </td> </tr> <tr> <td width="40%"><a id="IPSEC_CIPHER_TRANSFORM_ID_CBC_3DES"></a><a
    ///id="ipsec_cipher_transform_id_cbc_3des"></a><dl> <dt><b>IPSEC_CIPHER_TRANSFORM_ID_CBC_3DES</b></dt> </dl> </td>
    ///<td width="60%"> IPSEC_CIPHER_TYPE_3DES, IPSEC_CIPHER_CONFIG_CBC_3DES </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_CIPHER_TRANSFORM_ID_AES_128"></a><a id="ipsec_cipher_transform_id_aes_128"></a><dl>
    ///<dt><b>IPSEC_CIPHER_TRANSFORM_ID_AES_128</b></dt> </dl> </td> <td width="60%"> IPSEC_CIPHER_TYPE_AES_128,
    ///IPSEC_CIPHER_CONFIG_CBC_AES_128 </td> </tr> <tr> <td width="40%"><a id="IPSEC_CIPHER_TRANSFORM_ID_AES_192"></a><a
    ///id="ipsec_cipher_transform_id_aes_192"></a><dl> <dt><b>IPSEC_CIPHER_TRANSFORM_ID_AES_192</b></dt> </dl> </td> <td
    ///width="60%"> IPSEC_CIPHER_TYPE_AES_192, IPSEC_CIPHER_CONFIG_CBC_AES_192 </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_CIPHER_TRANSFORM_ID_AES_256_"></a><a id="ipsec_cipher_transform_id_aes_256_"></a><dl>
    ///<dt><b>IPSEC_CIPHER_TRANSFORM_ID_AES_256 </b></dt> </dl> </td> <td width="60%"> IPSEC_CIPHER_TYPE_AES_256,
    ///IPSEC_CIPHER_CONFIG_CBC_AES_256 </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_CIPHER_TRANSFORM_ID_GCM_AES_128_"></a><a id="ipsec_cipher_transform_id_gcm_aes_128_"></a><dl>
    ///<dt><b>IPSEC_CIPHER_TRANSFORM_ID_GCM_AES_128 </b></dt> </dl> </td> <td width="60%"> IPSEC_CIPHER_TYPE_AES_128,
    ///IPSEC_CIPHER_CONFIG_GCM_AES_128 <div class="alert"><b>Note</b> Available only on Windows Server 2008, Windows
    ///Vista with SP1, and later.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_CIPHER_TRANSFORM_ID_GCM_AES_192"></a><a id="ipsec_cipher_transform_id_gcm_aes_192"></a><dl>
    ///<dt><b>IPSEC_CIPHER_TRANSFORM_ID_GCM_AES_192</b></dt> </dl> </td> <td width="60%"> IPSEC_CIPHER_TYPE_AES_192,
    ///IPSEC_CIPHER_CONFIG_GCM_AES_192 <div class="alert"><b>Note</b> Available only on Windows Server 2008, Windows
    ///Vista with SP1, and later.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_CIPHER_TRANSFORM_ID_GCM_AES_256"></a><a id="ipsec_cipher_transform_id_gcm_aes_256"></a><dl>
    ///<dt><b>IPSEC_CIPHER_TRANSFORM_ID_GCM_AES_256</b></dt> </dl> </td> <td width="60%"> IPSEC_CIPHER_TYPE_AES_256,
    ///IPSEC_CIPHER_CONFIG_GCM_AES_256 <div class="alert"><b>Note</b> Available only on Windows Server 2008, Windows
    ///Vista with SP1, and later.</div> <div> </div> </td> </tr> </table>
    IPSEC_CIPHER_TRANSFORM_ID0 cipherTransformId;
    ///Unused parameter, always set this to <b>NULL</b>.
    GUID* cryptoModuleId;
}

///The <b>IPSEC_AUTH_AND_CIPHER_TRANSFORM0</b> structure is used to store hash and encryption specific information
///together for an SA transform in an IPsec quick mode policy.
struct IPSEC_AUTH_AND_CIPHER_TRANSFORM0
{
    ///Hash specific information as specified by
    ///[IPSEC_AUTH_TRANSFORM0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_auth_transform0).
    IPSEC_AUTH_TRANSFORM0 authTransform;
    ///Encryption specific information as specified by
    ///[IPSEC_CIPHER_TRANSFORM0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_cipher_transform0).
    IPSEC_CIPHER_TRANSFORM0 cipherTransform;
}

///The <b>IPSEC_SA_TRANSFORM0</b> structure is used to store an IPsec security association (SA) transform in an IPsec
///quick mode policy.
struct IPSEC_SA_TRANSFORM0
{
    ///Type of the SA transform. See
    ///[IPSEC_TRANSFORM_TYPE](/windows/desktop/api/ipsectypes/ne-ipsectypes-ipsec_transform_type) for more information.
    IPSEC_TRANSFORM_TYPE ipsecTransformType;
union
    {
        IPSEC_AUTH_TRANSFORM0* ahTransform;
        IPSEC_AUTH_TRANSFORM0* espAuthTransform;
        IPSEC_CIPHER_TRANSFORM0* espCipherTransform;
        IPSEC_AUTH_AND_CIPHER_TRANSFORM0* espAuthAndCipherTransform;
        IPSEC_AUTH_TRANSFORM0* espAuthFwTransform;
    }
}

///The <b>IPSEC_PROPOSAL0</b> structure is used to store an IPsec quick mode proposal.
struct IPSEC_PROPOSAL0
{
    ///Lifetime of the IPsec security association (SA) as specified by
    ///[IPSEC_SA_LIFETIME0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_lifetime0). Cannot be zero.
    IPSEC_SA_LIFETIME0   lifetime;
    ///Number of IPsec SA transforms. The only possible values are 1 and 2. Use 2 only when specifying AH plus ESP
    ///transforms.
    uint                 numSaTransforms;
    ///Array of IPsec SA transforms as specified by
    ///[IPSEC_SA_TRANSFORM0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_transform0).
    IPSEC_SA_TRANSFORM0* saTransforms;
    ///Perfect forward secrecy (PFS) group of the IPsec SA as specified by
    ///[IPSEC_PFS_GROUP](/windows/desktop/api/ipsectypes/ne-ipsectypes-ipsec_pfs_group).
    IPSEC_PFS_GROUP      pfsGroup;
}

///The <b>IPSEC_SA_IDLE_TIMEOUT0</b> structure specifies the security association (SA) idle timeout in IPsec policy.
struct IPSEC_SA_IDLE_TIMEOUT0
{
    ///Specifies the amount of time in seconds after which IPsec SAs should become idle.
    uint idleTimeoutSeconds;
    ///Specifies the amount of time in seconds after which IPsec SAs should become idle if the peer machine supports
    ///fail over.
    uint idleTimeoutSecondsFailOver;
}

struct IPSEC_TRAFFIC_SELECTOR0_
{
    ubyte          protocolId;
    ushort         portStart;
    ushort         portEnd;
    FWP_IP_VERSION ipVersion;
union
    {
        uint      startV4Address;
        ubyte[16] startV6Address;
    }
union
    {
        uint      endV4Address;
        ubyte[16] endV6Address;
    }
}

struct IPSEC_TRAFFIC_SELECTOR_POLICY0_
{
    uint flags;
    uint numLocalTrafficSelectors;
    IPSEC_TRAFFIC_SELECTOR0_* localTrafficSelectors;
    uint numRemoteTrafficSelectors;
    IPSEC_TRAFFIC_SELECTOR0_* remoteTrafficSelectors;
}

///The <b>IPSEC_TRANSPORT_POLICY0</b> structure stores the quick mode negotiation policy for transport mode IPsec.
///[IPSEC_TRANSPORT_POLICY2](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_transport_policy2) is available.
struct IPSEC_TRANSPORT_POLICY0
{
    ///Number of quick mode proposals in the policy.
    uint               numIpsecProposals;
    ///Array of quick mode proposals. See
    ///[IPSEC_PROPOSAL0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_proposal0) for more information.
    IPSEC_PROPOSAL0*   ipsecProposals;
    ///A combination of the following values. <table> <tr> <th>IPsec policy flag</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="IPSEC_POLICY_FLAG_ND_SECURE"></a><a id="ipsec_policy_flag_nd_secure"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_ND_SECURE</b></dt> </dl> </td> <td width="60%"> Do negotiation discovery in secure ring.
    ///</td> </tr> <tr> <td width="40%"><a id="IPSEC_POLICY_FLAG_ND_BOUNDARY"></a><a
    ///id="ipsec_policy_flag_nd_boundary"></a><dl> <dt><b>IPSEC_POLICY_FLAG_ND_BOUNDARY</b></dt> </dl> </td> <td
    ///width="60%"> Do negotiation discovery in the untrusted perimeter zone. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_POLICY_FLAG_NAT_ENCAP_ALLOW_PEER_BEHIND_NAT"></a><a
    ///id="ipsec_policy_flag_nat_encap_allow_peer_behind_nat"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_NAT_ENCAP_ALLOW_PEER_BEHIND_NAT</b></dt> </dl> </td> <td width="60%"> If set, IPsec
    ///expects that either the local or remote machine is behind a network address translation (NAT) device, but not
    ///both. This allows for less secure, but more flexible behavior. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_POLICY_FLAG_NAT_ENCAP_ALLOW_GENERAL_NAT_TRAVERSAL"></a><a
    ///id="ipsec_policy_flag_nat_encap_allow_general_nat_traversal"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_NAT_ENCAP_ALLOW_GENERAL_NAT_TRAVERSAL</b></dt> </dl> </td> <td width="60%"> If set,
    ///IPsec expects default ports when either the local, the remote, or both machines are behind a NAT device. </td>
    ///</tr> <tr> <td width="40%"><a id="IPSEC_POLICY_FLAG_DONT_NEGOTIATE_SECOND_LIFETIME"></a><a
    ///id="ipsec_policy_flag_dont_negotiate_second_lifetime"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_DONT_NEGOTIATE_SECOND_LIFETIME</b></dt> </dl> </td> <td width="60%"> If set, Internet
    ///Key Exchange (IKE) will not send the ISAKMP attribute for 'seconds' lifetime during quick mode negotiation. </td>
    ///</tr> <tr> <td width="40%"><a id="IPSEC_POLICY_FLAG_DONT_NEGOTIATE_BYTE_LIFETIME"></a><a
    ///id="ipsec_policy_flag_dont_negotiate_byte_lifetime"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_DONT_NEGOTIATE_BYTE_LIFETIME</b></dt> </dl> </td> <td width="60%"> If set, IKE will not
    ///send the ISAKMP attribute for 'byte' lifetime during quick mode negotiation. </td> </tr> </table>
    uint               flags;
    ///Timeout in seconds, after which the IPsec security association (SA) should stop accepting packets coming in the
    ///clear. Used for negotiation discovery.
    uint               ndAllowClearTimeoutSeconds;
    ///An [IPSEC_SA_IDLE_TIMEOUT0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_idle_timeout0) structure that
    ///specifies the SA idle timeout in IPsec policy.
    IPSEC_SA_IDLE_TIMEOUT0 saIdleTimeout;
    ///The AuthIP extended mode authentication policy. See
    ///[IKEEXT_EM_POLICY0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_em_policy0) for more information.
    IKEEXT_EM_POLICY0* emPolicy;
}

///The <b>IPSEC_TRANSPORT_POLICY1</b> structure stores the quick mode negotiation policy for transport mode IPsec.
///[IPSEC_TRANSPORT_POLICY2](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_transport_policy2) is available.
struct IPSEC_TRANSPORT_POLICY1
{
    ///Number of quick mode proposals in the policy.
    uint               numIpsecProposals;
    ///Array of quick mode proposals. See
    ///[IPSEC_PROPOSAL0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_proposal0) for more information.
    IPSEC_PROPOSAL0*   ipsecProposals;
    ///A combination of the following values. <table> <tr> <th>IPsec policy flag</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="IPSEC_POLICY_FLAG_ND_SECURE"></a><a id="ipsec_policy_flag_nd_secure"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_ND_SECURE</b></dt> </dl> </td> <td width="60%"> Do negotiation discovery in secure ring.
    ///</td> </tr> <tr> <td width="40%"><a id="IPSEC_POLICY_FLAG_ND_BOUNDARY"></a><a
    ///id="ipsec_policy_flag_nd_boundary"></a><dl> <dt><b>IPSEC_POLICY_FLAG_ND_BOUNDARY</b></dt> </dl> </td> <td
    ///width="60%"> Do negotiation discovery in the untrusted perimeter zone. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_POLICY_FLAG_NAT_ENCAP_ALLOW_PEER_BEHIND_NAT"></a><a
    ///id="ipsec_policy_flag_nat_encap_allow_peer_behind_nat"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_NAT_ENCAP_ALLOW_PEER_BEHIND_NAT</b></dt> </dl> </td> <td width="60%"> If set, IPsec
    ///expects that either the local or remote machine is behind a network address translation (NAT) device, but not
    ///both. This allows for less secure, but more flexible behavior. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_POLICY_FLAG_NAT_ENCAP_ALLOW_GENERAL_NAT_TRAVERSAL"></a><a
    ///id="ipsec_policy_flag_nat_encap_allow_general_nat_traversal"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_NAT_ENCAP_ALLOW_GENERAL_NAT_TRAVERSAL</b></dt> </dl> </td> <td width="60%"> If set,
    ///IPsec expects default ports when either the local, the remote, or both machines are behind a NAT device. </td>
    ///</tr> <tr> <td width="40%"><a id="IPSEC_POLICY_FLAG_DONT_NEGOTIATE_SECOND_LIFETIME"></a><a
    ///id="ipsec_policy_flag_dont_negotiate_second_lifetime"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_DONT_NEGOTIATE_SECOND_LIFETIME</b></dt> </dl> </td> <td width="60%"> If set, Internet
    ///Key Exchange (IKE) will not send the ISAKMP attribute for 'seconds' lifetime during quick mode negotiation. </td>
    ///</tr> <tr> <td width="40%"><a id="IPSEC_POLICY_FLAG_DONT_NEGOTIATE_BYTE_LIFETIME"></a><a
    ///id="ipsec_policy_flag_dont_negotiate_byte_lifetime"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_DONT_NEGOTIATE_BYTE_LIFETIME</b></dt> </dl> </td> <td width="60%"> If set, IKE will not
    ///send the ISAKMP attribute for 'byte' lifetime during quick mode negotiation. </td> </tr> </table>
    uint               flags;
    ///Timeout in seconds, after which the IPsec security association (SA) should stop accepting packets coming in the
    ///clear. Used for negotiation discovery.
    uint               ndAllowClearTimeoutSeconds;
    ///An [IPSEC_SA_IDLE_TIMEOUT0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_idle_timeout0) structure that
    ///specifies the SA idle timeout in IPsec policy.
    IPSEC_SA_IDLE_TIMEOUT0 saIdleTimeout;
    ///The AuthIP extended mode authentication policy. See
    ///[IKEEXT_EM_POLICY1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_em_policy1) for more information.
    IKEEXT_EM_POLICY1* emPolicy;
}

///The <b>IPSEC_TRANSPORT_POLICY2</b> structure stores the quick mode negotiation policy for transport mode IPsec.
///[IPSEC_TRANSPORT_POLICY0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_transport_policy0) is available.
struct IPSEC_TRANSPORT_POLICY2
{
    ///Type: <b>UINT32</b> Number of quick mode proposals in the policy.
    uint               numIpsecProposals;
    ///Type: [IPSEC_PROPOSAL0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_proposal0)*</b> Array of quick mode
    ///proposals.
    IPSEC_PROPOSAL0*   ipsecProposals;
    ///Type: <b>UINT32</b> A combination of the following values. <table> <tr> <th>IPsec policy flag</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="IPSEC_POLICY_FLAG_ND_SECURE"></a><a
    ///id="ipsec_policy_flag_nd_secure"></a><dl> <dt><b>IPSEC_POLICY_FLAG_ND_SECURE</b></dt> </dl> </td> <td
    ///width="60%"> Do negotiation discovery in secure ring. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_POLICY_FLAG_ND_BOUNDARY"></a><a id="ipsec_policy_flag_nd_boundary"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_ND_BOUNDARY</b></dt> </dl> </td> <td width="60%"> Do negotiation discovery in the
    ///untrusted perimeter zone. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_POLICY_FLAG_NAT_ENCAP_ALLOW_PEER_BEHIND_NAT"></a><a
    ///id="ipsec_policy_flag_nat_encap_allow_peer_behind_nat"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_NAT_ENCAP_ALLOW_PEER_BEHIND_NAT</b></dt> </dl> </td> <td width="60%"> If set, IPsec
    ///expects that either the local or remote machine is behind a network address translation (NAT) device, but not
    ///both. This allows for less secure, but more flexible behavior. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_POLICY_FLAG_NAT_ENCAP_ALLOW_GENERAL_NAT_TRAVERSAL"></a><a
    ///id="ipsec_policy_flag_nat_encap_allow_general_nat_traversal"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_NAT_ENCAP_ALLOW_GENERAL_NAT_TRAVERSAL</b></dt> </dl> </td> <td width="60%"> If set,
    ///IPsec expects default ports when either the local, the remote, or both machines are behind a NAT device. </td>
    ///</tr> <tr> <td width="40%"><a id="IPSEC_POLICY_FLAG_DONT_NEGOTIATE_SECOND_LIFETIME"></a><a
    ///id="ipsec_policy_flag_dont_negotiate_second_lifetime"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_DONT_NEGOTIATE_SECOND_LIFETIME</b></dt> </dl> </td> <td width="60%"> If set, Internet
    ///Key Exchange (IKE) will not send the ISAKMP attribute for 'seconds' lifetime during quick mode negotiation. </td>
    ///</tr> <tr> <td width="40%"><a id="IPSEC_POLICY_FLAG_DONT_NEGOTIATE_BYTE_LIFETIME"></a><a
    ///id="ipsec_policy_flag_dont_negotiate_byte_lifetime"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_DONT_NEGOTIATE_BYTE_LIFETIME</b></dt> </dl> </td> <td width="60%"> If set, IKE will not
    ///send the ISAKMP attribute for 'byte' lifetime during quick mode negotiation. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_POLICY_FLAG_KEY_MANAGER_ALLOW_DICTATE_KEY"></a><a
    ///id="ipsec_policy_flag_key_manager_allow_dictate_key"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_KEY_MANAGER_ALLOW_DICTATE_KEY</b></dt> </dl> </td> <td width="60%"> Allow key dictation
    ///for quick mode policy. Applicable only for AuthIP policy. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_POLICY_FLAG_KEY_MANAGER_ALLOW_NOTIFY_KEY_"></a><a
    ///id="ipsec_policy_flag_key_manager_allow_notify_key_"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_KEY_MANAGER_ALLOW_NOTIFY_KEY </b></dt> </dl> </td> <td width="60%"> Allow key
    ///notification for quick mode policy. Applicable for AuthIP/IKE/IKEv2 policy. </td> </tr> </table>
    uint               flags;
    ///Type: <b>UINT32</b> Timeout in seconds, after which the IPsec security association (SA) should stop accepting
    ///packets coming in the clear. Used for negotiation discovery.
    uint               ndAllowClearTimeoutSeconds;
    ///Type: [IPSEC_SA_IDLE_TIMEOUT0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_idle_timeout0)</b> The SA
    ///idle timeout in IPsec policy.
    IPSEC_SA_IDLE_TIMEOUT0 saIdleTimeout;
    ///Type: [IKEEXT_EM_POLICY2](/windows/desktop/api/iketypes/ns-iketypes-ikeext_em_policy2)*</b> The AuthIP extended
    ///mode authentication policy.
    IKEEXT_EM_POLICY2* emPolicy;
}

///The <b>IPSEC_TUNNEL_ENDPOINTS0</b> structure is used to store end points of a tunnel mode SA.
///[IPSEC_TUNNEL_ENDPOINTS2](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_tunnel_endpoints2) is available.
struct IPSEC_TUNNEL_ENDPOINTS0
{
    ///IP version of the addresses. See [FWP_IP_VERSION](/windows/desktop/api/fwptypes/ne-fwptypes-fwp_ip_version) for
    ///more information.
    FWP_IP_VERSION ipVersion;
union
    {
        uint      localV4Address;
        ubyte[16] localV6Address;
    }
union
    {
        uint      remoteV4Address;
        ubyte[16] remoteV6Address;
    }
}

///The <b>IPSEC_TUNNEL_ENDPOINT0</b> structure is used to store address information for an end point of a tunnel mode
///SA.
struct IPSEC_TUNNEL_ENDPOINT0
{
    ///Type: [FWP_IP_VERSION](/windows/desktop/api/fwptypes/ne-fwptypes-fwp_ip_version)</b> Specifies the IP version. In
    ///tunnel mode, this is the version of the outer header.
    FWP_IP_VERSION ipVersion;
union
    {
        uint      v4Address;
        ubyte[16] v6Address;
    }
}

///The <b>IPSEC_TUNNEL_ENDPOINTS2</b> structure is used to store end points of a tunnel mode SA.
///[IPSEC_TUNNEL_ENDPOINTS1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_tunnel_endpoints1) is available. For
///Windows Vista, [IPSEC_TUNNEL_ENDPOINTS0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_tunnel_endpoints0) is
///available.
struct IPSEC_TUNNEL_ENDPOINTS2
{
    ///Type: [FWP_IP_VERSION](/windows/desktop/api/fwptypes/ne-fwptypes-fwp_ip_version)</b> Specifies the IP version. In
    ///tunnel mode, this is the version of the outer header.
    FWP_IP_VERSION ipVersion;
union
    {
        uint      localV4Address;
        ubyte[16] localV6Address;
    }
union
    {
        uint      remoteV4Address;
        ubyte[16] remoteV6Address;
    }
    ///Type: <b>UINT64</b> Optional LUID of the local interface corresponding to the local address specified above.
    ulong          localIfLuid;
    ///Type: <b>wchar_t*</b> Configuration of multiple remote addresses and fully qualified domain names for asymmetric
    ///tunneling support.
    PWSTR          remoteFqdn;
    ///Type: <b>UINT32</b> The number of remote tunnel addresses.
    uint           numAddresses;
    ///Type: [IPSEC_TUNNEL_ENDPOINT0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_tunnel_endpoint0)*</b>
    ///[size_is(numAddresses)] The remote tunnel end point address information.
    IPSEC_TUNNEL_ENDPOINT0* remoteAddresses;
}

///The <b>IPSEC_TUNNEL_ENDPOINTS1</b> structure is used to store end points of a tunnel mode SA.
///[IPSEC_TUNNEL_ENDPOINTS2](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_tunnel_endpoints2) is available.
struct IPSEC_TUNNEL_ENDPOINTS1
{
    ///An [FWP_IP_VERSION](/windows/desktop/api/fwptypes/ne-fwptypes-fwp_ip_version) value that specifies the IP
    ///version. In tunnel mode, this is the version of the outer header.
    FWP_IP_VERSION ipVersion;
union
    {
        uint      localV4Address;
        ubyte[16] localV6Address;
    }
union
    {
        uint      remoteV4Address;
        ubyte[16] remoteV6Address;
    }
    ///Optional LUID of the local interface corresponding to the local address specified above.
    ulong          localIfLuid;
}

///The <b>IPSEC_TUNNEL_POLICY0</b> structure stores the quick mode negotiation policy for tunnel mode IPsec.
///[IPSEC_TUNNEL_POLICY2](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_tunnel_policy2) is available.
struct IPSEC_TUNNEL_POLICY0
{
    ///A combination of the following values. <table> <tr> <th>IPsec policy flag</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="IPSEC_POLICY_FLAG_ND_SECURE"></a><a id="ipsec_policy_flag_nd_secure"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_ND_SECURE</b></dt> </dl> </td> <td width="60%"> Do negotiation discovery in secure ring.
    ///</td> </tr> <tr> <td width="40%"><a id="IPSEC_POLICY_FLAG_ND_BOUNDARY"></a><a
    ///id="ipsec_policy_flag_nd_boundary"></a><dl> <dt><b>IPSEC_POLICY_FLAG_ND_BOUNDARY</b></dt> </dl> </td> <td
    ///width="60%"> Do negotiation discovery in the untrusted perimeter zone. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_POLICY_FLAG_CLEAR_DF_ON_TUNNEL"></a><a id="ipsec_policy_flag_clear_df_on_tunnel"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_CLEAR_DF_ON_TUNNEL</b></dt> </dl> </td> <td width="60%"> Clear the "DontFragment" bit on
    ///the outer IP header of an IPsec tunneled packet. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_POLICY_FLAG_DONT_NEGOTIATE_SECOND_LIFETIME"></a><a
    ///id="ipsec_policy_flag_dont_negotiate_second_lifetime"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_DONT_NEGOTIATE_SECOND_LIFETIME</b></dt> </dl> </td> <td width="60%"> If set, Internet
    ///Key Exchange (IKE) will not send the ISAKMP attribute for 'seconds' lifetime during quick mode negotiation. </td>
    ///</tr> <tr> <td width="40%"><a id="IPSEC_POLICY_FLAG_DONT_NEGOTIATE_BYTE_LIFETIME"></a><a
    ///id="ipsec_policy_flag_dont_negotiate_byte_lifetime"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_DONT_NEGOTIATE_BYTE_LIFETIME</b></dt> </dl> </td> <td width="60%"> If set, IKE will not
    ///send the ISAKMP attribute for 'byte' lifetime during quick mode negotiation. </td> </tr> </table>
    uint               flags;
    ///Number of quick mode proposals in the policy.
    uint               numIpsecProposals;
    ///Array of quick mode proposals. See
    ///[IPSEC_PROPOSAL0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_proposal0) for more information.
    IPSEC_PROPOSAL0*   ipsecProposals;
    ///Tunnel endpoints of the IPsec security association (SA) generated from this policy. See
    ///[IPSEC_TUNNEL_ENDPOINTS0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_tunnel_endpoints0) for more
    ///information.
    IPSEC_TUNNEL_ENDPOINTS0 tunnelEndpoints;
    ///An [IPSEC_SA_IDLE_TIMEOUT0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_idle_timeout0) structure that
    ///specifies the SA idle timeout in IPsec policy.
    IPSEC_SA_IDLE_TIMEOUT0 saIdleTimeout;
    ///The AuthIP extended mode authentication policy. See
    ///[IKEEXT_EM_POLICY0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_em_policy0) for more information.
    IKEEXT_EM_POLICY0* emPolicy;
}

///The <b>IPSEC_TUNNEL_POLICY1</b> structure stores the quick mode negotiation policy for tunnel mode IPsec.
///[IPSEC_TUNNEL_POLICY2](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_tunnel_policy2) is available.
struct IPSEC_TUNNEL_POLICY1
{
    ///A combination of the following values. <table> <tr> <th>IPsec policy flag</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="IPSEC_POLICY_FLAG_ND_SECURE"></a><a id="ipsec_policy_flag_nd_secure"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_ND_SECURE</b></dt> </dl> </td> <td width="60%"> Do negotiation discovery in secure ring.
    ///</td> </tr> <tr> <td width="40%"><a id="IPSEC_POLICY_FLAG_ND_BOUNDARY"></a><a
    ///id="ipsec_policy_flag_nd_boundary"></a><dl> <dt><b>IPSEC_POLICY_FLAG_ND_BOUNDARY</b></dt> </dl> </td> <td
    ///width="60%"> Do negotiation discovery in the untrusted perimeter zone. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_POLICY_FLAG_CLEAR_DF_ON_TUNNEL"></a><a id="ipsec_policy_flag_clear_df_on_tunnel"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_CLEAR_DF_ON_TUNNEL</b></dt> </dl> </td> <td width="60%"> Clear the "DontFragment" bit on
    ///the outer IP header of an IPsec tunneled packet. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_POLICY_FLAG_DONT_NEGOTIATE_SECOND_LIFETIME"></a><a
    ///id="ipsec_policy_flag_dont_negotiate_second_lifetime"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_DONT_NEGOTIATE_SECOND_LIFETIME</b></dt> </dl> </td> <td width="60%"> If set, Internet
    ///Key Exchange (IKE) will not send the ISAKMP attribute for 'seconds' lifetime during quick mode negotiation. </td>
    ///</tr> <tr> <td width="40%"><a id="IPSEC_POLICY_FLAG_DONT_NEGOTIATE_BYTE_LIFETIME"></a><a
    ///id="ipsec_policy_flag_dont_negotiate_byte_lifetime"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_DONT_NEGOTIATE_BYTE_LIFETIME</b></dt> </dl> </td> <td width="60%"> If set, IKE will not
    ///send the ISAKMP attribute for 'byte' lifetime during quick mode negotiation. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_POLICY_FLAG_ENABLE_V6_IN_V4_TUNNELING"></a><a id="ipsec_policy_flag_enable_v6_in_v4_tunneling"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_ENABLE_V6_IN_V4_TUNNELING</b></dt> </dl> </td> <td width="60%"> Negotiate IPv6 inside
    ///IPv4 IPsec tunneling. Applicable only for tunnel mode policy, and supported only by IKEv2. </td> </tr> <tr> <td
    ///width="40%"><a id="IPSEC_POLICY_FLAG_ENABLE_SERVER_ADDR_ASSIGNMENT"></a><a
    ///id="ipsec_policy_flag_enable_server_addr_assignment"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_ENABLE_SERVER_ADDR_ASSIGNMENT</b></dt> </dl> </td> <td width="60%"> Enable calls to RAS
    ///VPN server for address assignment. Applicable only for tunnel mode policy, and supported only by IKEv2. </td>
    ///</tr> <tr> <td width="40%"><a id="IPSEC_POLICY_FLAG_TUNNEL_ALLOW_OUTBOUND_CLEAR_CONNECTION"></a><a
    ///id="ipsec_policy_flag_tunnel_allow_outbound_clear_connection"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_TUNNEL_ALLOW_OUTBOUND_CLEAR_CONNECTION</b></dt> </dl> </td> <td width="60%"> Allow
    ///outbound connections to bypass the tunnel policy. Applicable only for tunnel mode policy on a tunnel gateway. Do
    ///not set on a tunnel client. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_POLICY_FLAG_TUNNEL_BYPASS_ALREADY_SECURE_CONNECTION"></a><a
    ///id="ipsec_policy_flag_tunnel_bypass_already_secure_connection"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_TUNNEL_BYPASS_ALREADY_SECURE_CONNECTION</b></dt> </dl> </td> <td width="60%"> Allow ESP
    ///or UDP 500/4500 traffic to bypass the tunnel. Applicable only for tunnel mode policy. </td> </tr> <tr> <td
    ///width="40%"><a id="IPSEC_POLICY_FLAG_TUNNEL_BYPASS_ICMPV6"></a><a
    ///id="ipsec_policy_flag_tunnel_bypass_icmpv6"></a><dl> <dt><b>IPSEC_POLICY_FLAG_TUNNEL_BYPASS_ICMPV6</b></dt> </dl>
    ///</td> <td width="60%"> Allow ICMPv6 traffic to bypass the tunnel. Applicable only for tunnel mode policy. </td>
    ///</tr> </table>
    uint               flags;
    ///Number of quick mode proposals in the policy.
    uint               numIpsecProposals;
    ///Array of quick mode proposals. See
    ///[IPSEC_PROPOSAL0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_proposal0) for more information.
    IPSEC_PROPOSAL0*   ipsecProposals;
    ///Tunnel endpoints of the IPsec security association (SA) generated from this policy. See
    ///[IPSEC_TUNNEL_ENDPOINTS1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_tunnel_endpoints1) for more
    ///information.
    IPSEC_TUNNEL_ENDPOINTS1 tunnelEndpoints;
    ///An [IPSEC_SA_IDLE_TIMEOUT0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_idle_timeout0) structure that
    ///specifies the SA idle timeout in IPsec policy.
    IPSEC_SA_IDLE_TIMEOUT0 saIdleTimeout;
    ///The AuthIP extended mode authentication policy. See
    ///[IKEEXT_EM_POLICY1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_em_policy1) for more information.
    IKEEXT_EM_POLICY1* emPolicy;
}

///The <b>IPSEC_TUNNEL_POLICY2</b> structure stores the quick mode negotiation policy for tunnel mode IPsec.
///[IPSEC_TUNNEL_POLICY1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_tunnel_policy1) is available. For Windows
///Vista, [IPSEC_TUNNEL_POLICY0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_tunnel_policy0) is available.
struct IPSEC_TUNNEL_POLICY2
{
    ///Type: <b>UINT32</b> A combination of the following values. <table> <tr> <th>IPsec policy flag</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="IPSEC_POLICY_FLAG_ND_SECURE"></a><a
    ///id="ipsec_policy_flag_nd_secure"></a><dl> <dt><b>IPSEC_POLICY_FLAG_ND_SECURE</b></dt> </dl> </td> <td
    ///width="60%"> Do negotiation discovery in secure ring. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_POLICY_FLAG_ND_BOUNDARY"></a><a id="ipsec_policy_flag_nd_boundary"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_ND_BOUNDARY</b></dt> </dl> </td> <td width="60%"> Do negotiation discovery in the
    ///untrusted perimeter zone. </td> </tr> <tr> <td width="40%"><a id="IPSEC_POLICY_FLAG_CLEAR_DF_ON_TUNNEL"></a><a
    ///id="ipsec_policy_flag_clear_df_on_tunnel"></a><dl> <dt><b>IPSEC_POLICY_FLAG_CLEAR_DF_ON_TUNNEL</b></dt> </dl>
    ///</td> <td width="60%"> Clear the "DontFragment" bit on the outer IP header of an IPsec tunneled packet. </td>
    ///</tr> <tr> <td width="40%"><a id="IPSEC_POLICY_FLAG_DONT_NEGOTIATE_SECOND_LIFETIME"></a><a
    ///id="ipsec_policy_flag_dont_negotiate_second_lifetime"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_DONT_NEGOTIATE_SECOND_LIFETIME</b></dt> </dl> </td> <td width="60%"> If set, Internet
    ///Key Exchange (IKE) will not send the ISAKMP attribute for 'seconds' lifetime during quick mode negotiation. </td>
    ///</tr> <tr> <td width="40%"><a id="IPSEC_POLICY_FLAG_DONT_NEGOTIATE_BYTE_LIFETIME"></a><a
    ///id="ipsec_policy_flag_dont_negotiate_byte_lifetime"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_DONT_NEGOTIATE_BYTE_LIFETIME</b></dt> </dl> </td> <td width="60%"> If set, IKE will not
    ///send the ISAKMP attribute for 'byte' lifetime during quick mode negotiation. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_POLICY_FLAG_ENABLE_V6_IN_V4_TUNNELING"></a><a id="ipsec_policy_flag_enable_v6_in_v4_tunneling"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_ENABLE_V6_IN_V4_TUNNELING</b></dt> </dl> </td> <td width="60%"> Negotiate IPv6 inside
    ///IPv4 IPsec tunneling. Applicable only for tunnel mode policy, and supported only by IKEv2. </td> </tr> <tr> <td
    ///width="40%"><a id="IPSEC_POLICY_FLAG_ENABLE_SERVER_ADDR_ASSIGNMENT"></a><a
    ///id="ipsec_policy_flag_enable_server_addr_assignment"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_ENABLE_SERVER_ADDR_ASSIGNMENT</b></dt> </dl> </td> <td width="60%"> Enable calls to RAS
    ///VPN server for address assignment. Applicable only for tunnel mode policy, and supported only by IKEv2. </td>
    ///</tr> <tr> <td width="40%"><a id="IPSEC_POLICY_FLAG_TUNNEL_ALLOW_OUTBOUND_CLEAR_CONNECTION"></a><a
    ///id="ipsec_policy_flag_tunnel_allow_outbound_clear_connection"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_TUNNEL_ALLOW_OUTBOUND_CLEAR_CONNECTION</b></dt> </dl> </td> <td width="60%"> Allow
    ///outbound connections to bypass the tunnel policy. Applicable only for tunnel mode policy on a tunnel gateway. Do
    ///not set on a tunnel client. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_POLICY_FLAG_TUNNEL_BYPASS_ALREADY_SECURE_CONNECTION"></a><a
    ///id="ipsec_policy_flag_tunnel_bypass_already_secure_connection"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_TUNNEL_BYPASS_ALREADY_SECURE_CONNECTION</b></dt> </dl> </td> <td width="60%"> Allow ESP
    ///or UDP 500/4500 traffic to bypass the tunnel. Applicable only for tunnel mode policy. </td> </tr> <tr> <td
    ///width="40%"><a id="IPSEC_POLICY_FLAG_TUNNEL_BYPASS_ICMPV6"></a><a
    ///id="ipsec_policy_flag_tunnel_bypass_icmpv6"></a><dl> <dt><b>IPSEC_POLICY_FLAG_TUNNEL_BYPASS_ICMPV6</b></dt> </dl>
    ///</td> <td width="60%"> Allow ICMPv6 traffic to bypass the tunnel. Applicable only for tunnel mode policy. </td>
    ///</tr> <tr> <td width="40%"><a id="IPSEC_POLICY_FLAG_KEY_MANAGER_ALLOW_DICTATE_KEY"></a><a
    ///id="ipsec_policy_flag_key_manager_allow_dictate_key"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_KEY_MANAGER_ALLOW_DICTATE_KEY</b></dt> </dl> </td> <td width="60%"> Allow key dictation
    ///for quick mode policy. Applicable only for AuthIP policy. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_POLICY_FLAG_KEY_MANAGER_ALLOW_NOTIFY_KEY_"></a><a
    ///id="ipsec_policy_flag_key_manager_allow_notify_key_"></a><dl>
    ///<dt><b>IPSEC_POLICY_FLAG_KEY_MANAGER_ALLOW_NOTIFY_KEY </b></dt> </dl> </td> <td width="60%"> Allow key
    ///notification for quick mode policy. Applicable for AuthIP/IKE/IKEv2 policy. </td> </tr> </table>
    uint               flags;
    ///Type: <b>UINT32</b> Number of quick mode proposals in the policy.
    uint               numIpsecProposals;
    ///Type: [IPSEC_PROPOSAL0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_proposal0)*</b> Array of quick mode
    ///proposals.
    IPSEC_PROPOSAL0*   ipsecProposals;
    ///Type: [IPSEC_TUNNEL_ENDPOINTS2](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_tunnel_endpoints2)</b> Tunnel
    ///endpoints of the IPsec security association (SA) generated from this policy.
    IPSEC_TUNNEL_ENDPOINTS2 tunnelEndpoints;
    ///Type: [IPSEC_SA_IDLE_TIMEOUT0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_idle_timeout0)</b>
    ///Specifies the SA idle timeout in IPsec policy.
    IPSEC_SA_IDLE_TIMEOUT0 saIdleTimeout;
    ///Type: [IKEEXT_EM_POLICY2](/windows/desktop/api/iketypes/ns-iketypes-ikeext_em_policy2)*</b> The AuthIP extended
    ///mode authentication policy.
    IKEEXT_EM_POLICY2* emPolicy;
    ///Type: <b>UINT32</b> The forward path SA lifetime indicating the length of time for this connection.
    uint               fwdPathSaLifetime;
}

struct IPSEC_TUNNEL_POLICY3_
{
    uint               flags;
    uint               numIpsecProposals;
    IPSEC_PROPOSAL0*   ipsecProposals;
    IPSEC_TUNNEL_ENDPOINTS2 tunnelEndpoints;
    IPSEC_SA_IDLE_TIMEOUT0 saIdleTimeout;
    IKEEXT_EM_POLICY2* emPolicy;
    uint               fwdPathSaLifetime;
    uint               compartmentId;
    uint               numTrafficSelectorPolicy;
    IPSEC_TRAFFIC_SELECTOR_POLICY0_* trafficSelectorPolicies;
}

///The [IPSEC_KEYING_POLICY1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_keying_policy1) is available.</div>
///<div> </div>
struct IPSEC_KEYING_POLICY0
{
    ///Number of keying modules in the array.
    uint  numKeyMods;
    ///Array of distinct keying modules.
    GUID* keyModKeys;
}

///The structure defines an unordered set of keying modules that will be tried for
///IPsec.[IPSEC_KEYING_POLICY0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_keying_policy0) is available.</div>
///<div> </div>
struct IPSEC_KEYING_POLICY1
{
    ///Type: <b>UINT32</b> Number of keying modules in the array.
    uint  numKeyMods;
    ///Type: <b>GUID*</b> Array of distinct keying modules.
    GUID* keyModKeys;
    ///Type: <b>UINT32</b> Possible values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_KEYING_POLICY_FLAG_TERMINATING_MATCH"></a><a id="ipsec_keying_policy_flag_terminating_match"></a><dl>
    ///<dt><b>IPSEC_KEYING_POLICY_FLAG_TERMINATING_MATCH</b></dt> </dl> </td> <td width="60%"> Forces the use of a
    ///Kerberos proxy server when acting as initiator. </td> </tr> </table>
    uint  flags;
}

///The <b>IPSEC_AGGREGATE_SA_STATISTICS0</b> structurestores aggregate IPsec kernel security association (SA)
///statistics.
struct IPSEC_AGGREGATE_SA_STATISTICS0
{
    ///Number of active SAs.
    uint activeSas;
    ///Number of pending SA negotiations.
    uint pendingSaNegotiations;
    ///Total number of SAs added.
    uint totalSasAdded;
    ///Total number of SAs deleted.
    uint totalSasDeleted;
    ///Number of successful re-keys.
    uint successfulRekeys;
    ///Number of active tunnels.
    uint activeTunnels;
    ///Number of offloaded SAs.
    uint offloadedSas;
}

///The <b>IPSEC_ESP_DROP_PACKET_STATISTICS0</b> structure stores ESP drop packet statistics.
struct IPSEC_ESP_DROP_PACKET_STATISTICS0
{
    ///Number of invalid SPIs on inbound.
    uint invalidSpisOnInbound;
    ///Number of decryption failures on inbound.
    uint decryptionFailuresOnInbound;
    ///Number of authentication failures on inbound.
    uint authenticationFailuresOnInbound;
    ///Number of replay check failures on inbound.
    uint replayCheckFailuresOnInbound;
    ///Number of inbound drops for packets received on SAs that were not fully initialized.
    uint saNotInitializedOnInbound;
}

///The <b>IPSEC_AH_DROP_PACKET_STATISTICS0</b> structure stores IPsec AH drop packet statistics.
struct IPSEC_AH_DROP_PACKET_STATISTICS0
{
    ///Number of invalid SPIs on inbound.
    uint invalidSpisOnInbound;
    ///Number of authentication failures on inbound.
    uint authenticationFailuresOnInbound;
    ///Number of replay check failures on inbound.
    uint replayCheckFailuresOnInbound;
    ///Number of inbound drops for packets received on SAs that were not fully initialized.
    uint saNotInitializedOnInbound;
}

///The
///[IPSEC_AGGREGATE_DROP_PACKET_STATISTICS1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_aggregate_drop_packet_statistics1)
///is available.</div> <div> </div>
struct IPSEC_AGGREGATE_DROP_PACKET_STATISTICS0
{
    ///Number of invalid SPIs on inbound.
    uint invalidSpisOnInbound;
    ///Number of decryption failures on inbound.
    uint decryptionFailuresOnInbound;
    ///Number of authentication failures on inbound.
    uint authenticationFailuresOnInbound;
    ///Number of UDP ESP validation failures on inbound.
    uint udpEspValidationFailuresOnInbound;
    ///Number of replay check failures on inbound.
    uint replayCheckFailuresOnInbound;
    ///Number of invalid clear text instances on inbound.
    uint invalidClearTextInbound;
    ///Number of inbound drops for packets received on SAs that were not fully initialized.
    uint saNotInitializedOnInbound;
    ///Number of inbound drops for packets received on SAs whose characteristics did not match the packet.
    uint receiveOverIncorrectSaInbound;
    ///Number of inbound IPsec secured packets that did not match any inbound IPsec transport layer filter.
    uint secureReceivesNotMatchingFilters;
}

///The <b>IPSEC_AGGREGATE_DROP_PACKET_STATISTICS1</b> structure stores aggregate IPsec kernel packet drop statistics.
///[IPSEC_AGGREGATE_DROP_PACKET_STATISTICS0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_aggregate_drop_packet_statistics0)
///is available.</div><div> </div>
struct IPSEC_AGGREGATE_DROP_PACKET_STATISTICS1
{
    ///Number of invalid SPIs on inbound.
    uint invalidSpisOnInbound;
    ///Number of decryption failures on inbound.
    uint decryptionFailuresOnInbound;
    ///Number of authentication failures on inbound.
    uint authenticationFailuresOnInbound;
    ///Number of UDP ESP validation failures on inbound.
    uint udpEspValidationFailuresOnInbound;
    ///Number of replay check failures on inbound.
    uint replayCheckFailuresOnInbound;
    ///Number of invalid clear text instances on inbound.
    uint invalidClearTextInbound;
    ///Number of inbound drops for packets received on SAs that were not fully initialized.
    uint saNotInitializedOnInbound;
    ///Number of inbound drops for packets received on SAs whose characteristics did not match the packet.
    uint receiveOverIncorrectSaInbound;
    ///Number of inbound IPsec secured packets that did not match any inbound IPsec transport layer filter.
    uint secureReceivesNotMatchingFilters;
    ///Number of inbound drops for all packets.
    uint totalDropPacketsInbound;
}

///The <b>IPSEC_TRAFFIC_STATISTICS0</b> structure stores IPsec traffic statistics.
///[IPSEC_TRAFFIC_STATISTICS1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_traffic_statistics1) is
///available.</div><div> </div>
struct IPSEC_TRAFFIC_STATISTICS0
{
    ///Specifies encrypted byte count.
    ulong encryptedByteCount;
    ///Specifies authenticated AH byte count.
    ulong authenticatedAHByteCount;
    ///Specifies authenticated ESP byte count.
    ulong authenticatedESPByteCount;
    ///Specifies transport byte count.
    ulong transportByteCount;
    ///Specifies tunnel byte count.
    ulong tunnelByteCount;
    ///Specifies offload byte count.
    ulong offloadByteCount;
}

///The <b>IPSEC_TRAFFIC_STATISTICS1</b> structure stores IPsec traffic statistics.
///[IPSEC_TRAFFIC_STATISTICS0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_traffic_statistics0) is
///available.</div><div> </div>
struct IPSEC_TRAFFIC_STATISTICS1
{
    ///Specifies encrypted byte count.
    ulong encryptedByteCount;
    ///Specifies authenticated AH byte count.
    ulong authenticatedAHByteCount;
    ///Specifies authenticated ESP byte count.
    ulong authenticatedESPByteCount;
    ///Specifies transport byte count.
    ulong transportByteCount;
    ///Specifies tunnel byte count.
    ulong tunnelByteCount;
    ///Specifies offload byte count.
    ulong offloadByteCount;
    ///The total number of packets that were successfully transmitted.
    ulong totalSuccessfulPackets;
}

///The <b>IPSEC_STATISTICS0</b> structure is the top-level of the IPsec statistics structures.
///[IPSEC_STATISTICS1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_statistics1) is available.</div><div> </div>
struct IPSEC_STATISTICS0
{
    ///IPSEC_AGGREGATE_SA_STATISTICS0 structure containing IPsec aggregate SA statistics.
    IPSEC_AGGREGATE_SA_STATISTICS0 aggregateSaStatistics;
    ///IPSEC_ESP_DROP_PACKET_STATISTICS0 structure containing IPsec ESP drop packet statistics.
    IPSEC_ESP_DROP_PACKET_STATISTICS0 espDropPacketStatistics;
    ///IPSEC_AH_DROP_PACKET_STATISTICS0 structure containing IPsec AH drop packet statistics.
    IPSEC_AH_DROP_PACKET_STATISTICS0 ahDropPacketStatistics;
    ///IPSEC_AGGREGATE_DROP_PACKET_STATISTICS0 structure containing IPsec aggregate drop packet statistics.
    IPSEC_AGGREGATE_DROP_PACKET_STATISTICS0 aggregateDropPacketStatistics;
    ///[IPSEC_TRAFFIC_STATISTICS0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_traffic_statistics0) structure
    ///containing IPsec inbound traffic statistics.
    IPSEC_TRAFFIC_STATISTICS0 inboundTrafficStatistics;
    ///[IPSEC_TRAFFIC_STATISTICS0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_traffic_statistics0) structure
    ///containing IPsec outbound traffic statistics.
    IPSEC_TRAFFIC_STATISTICS0 outboundTrafficStatistics;
}

///The <b>IPSEC_STATISTICS1</b> structure is the top-level of the IPsec statistics structures.
///[IPSEC_STATISTICS0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_statistics0) is available.</div><div> </div>
struct IPSEC_STATISTICS1
{
    ///IPSEC_AGGREGATE_SA_STATISTICS0 structure containing IPsec aggregate SA statistics.
    IPSEC_AGGREGATE_SA_STATISTICS0 aggregateSaStatistics;
    ///IPSEC_ESP_DROP_PACKET_STATISTICS0 structure containing IPsec ESP drop packet statistics.
    IPSEC_ESP_DROP_PACKET_STATISTICS0 espDropPacketStatistics;
    ///IPSEC_AH_DROP_PACKET_STATISTICS0 structure containing IPsec AH drop packet statistics.
    IPSEC_AH_DROP_PACKET_STATISTICS0 ahDropPacketStatistics;
    ///IPSEC_AGGREGATE_DROP_PACKET_STATISTICS1 structure containing IPsec aggregate drop packet statistics.
    IPSEC_AGGREGATE_DROP_PACKET_STATISTICS1 aggregateDropPacketStatistics;
    ///[IPSEC_TRAFFIC_STATISTICS1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_traffic_statistics1) structure
    ///containing IPsec inbound traffic statistics.
    IPSEC_TRAFFIC_STATISTICS1 inboundTrafficStatistics;
    ///[IPSEC_TRAFFIC_STATISTICS1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_traffic_statistics1) structure
    ///containing IPsec outbound traffic statistics.
    IPSEC_TRAFFIC_STATISTICS1 outboundTrafficStatistics;
}

///The <b>IPSEC_SA_AUTH_INFORMATION0</b> structure stores information about the authentication algorithm of an IPsec
///security association (SA).
struct IPSEC_SA_AUTH_INFORMATION0
{
    ///Authentication algorithm details as specified by
    ///[IPSEC_AUTH_TRANSFORM0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_auth_transform0).
    IPSEC_AUTH_TRANSFORM0 authTransform;
    ///Key used for the authentication algorithm stored in a
    ///[FWP_BYTE_BLOB](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_byte_blob) structure.
    FWP_BYTE_BLOB authKey;
}

///The <b>IPSEC_SA_CIPHER_INFORMATION0</b> structure stores information about the encryption algorithm of an IPsec
///security association (SA).
struct IPSEC_SA_CIPHER_INFORMATION0
{
    ///Encryption algorithm specific details as specified by
    ///[IPSEC_CIPHER_TRANSFORM0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_cipher_transform0).
    IPSEC_CIPHER_TRANSFORM0 cipherTransform;
    ///Key used for the encryption algorithm as specified by
    ///[FWP_BYTE_BLOB](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_byte_blob).
    FWP_BYTE_BLOB cipherKey;
}

///The <b>IPSEC_SA_AUTH_AND_CIPHER_INFORMATION0</b> structure stores information about the authentication and encryption
///algorithms of an IPsec security association (SA).
struct IPSEC_SA_AUTH_AND_CIPHER_INFORMATION0
{
    ///Encryption algorithm information as specified by
    ///[IPSEC_SA_CIPHER_INFORMATION0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_cipher_information0).
    IPSEC_SA_CIPHER_INFORMATION0 saCipherInformation;
    ///Authentication algorithm information as specified by
    ///[IPSEC_SA_AUTH_INFORMATION0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_auth_information0).
    IPSEC_SA_AUTH_INFORMATION0 saAuthInformation;
}

///The <b>IPSEC_SA0</b> structure is used to store information about an IPsec security association (SA).
struct IPSEC_SA0
{
    ///Security parameter index (SPI) of the IPsec SA. <b>IPSEC_SA_SPI</b> is defined in ipsectypes.h as UINT32.
    uint                 spi;
    ///Transform type of the SA specifying the IPsec security protocol. See
    ///[IPSEC_TRANSFORM_TYPE](/windows/desktop/api/ipsectypes/ne-ipsectypes-ipsec_transform_type) for more information.
    IPSEC_TRANSFORM_TYPE saTransformType;
union
    {
        IPSEC_SA_AUTH_INFORMATION0* ahInformation;
        IPSEC_SA_AUTH_INFORMATION0* espAuthInformation;
        IPSEC_SA_CIPHER_INFORMATION0* espCipherInformation;
        IPSEC_SA_AUTH_AND_CIPHER_INFORMATION0* espAuthAndCipherInformation;
        IPSEC_SA_AUTH_INFORMATION0* espAuthFwInformation;
    }
}

///The <b>IPSEC_KEYMODULE_STATE0</b> structure stores Internet Protocol Security (IPsec) keying module specific
///information.
struct IPSEC_KEYMODULE_STATE0
{
    ///The identifier of the keying module.
    GUID          keyModuleKey;
    ///A byte blob containing opaque keying module specific information.
    FWP_BYTE_BLOB stateBlob;
}

///The <b>IPSEC_TOKEN0</b> structure contains various information about an IPsec-specific access token.
struct IPSEC_TOKEN0
{
    ///An [IPSEC_TOKEN_TYPE](/windows/desktop/api/ipsectypes/ne-ipsectypes-ipsec_token_type) value that specifies the
    ///type of token.
    IPSEC_TOKEN_TYPE type;
    ///An [IPSEC_TOKEN_PRINCIPAL](/windows/desktop/api/ipsectypes/ne-ipsectypes-ipsec_token_principal) value that
    ///specifies the token principal.
    IPSEC_TOKEN_PRINCIPAL principal;
    ///An [IPSEC_TOKEN_MODE](/windows/desktop/api/ipsectypes/ne-ipsectypes-ipsec_token_mode) value that indicates in
    ///which mode the token was obtained.
    IPSEC_TOKEN_MODE mode;
    ///Handle to the access token. An <b>IPSEC_TOKEN_HANDLE</b> is of type <b>UINT64</b>.
    ulong            token;
}

///The <b>IPSEC_ID0</b> structure contains information corresponding to identities that are authenticated by IPsec.
struct IPSEC_ID0
{
    ///Optional main mode target service principal name (SPN). This is often the machine name.
    PWSTR         mmTargetName;
    ///Optional extended mode target SPN.
    PWSTR         emTargetName;
    ///Optional. Number of [IPSEC_TOKEN0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_token0) structures present
    ///in the <b>tokens</b> member.
    uint          numTokens;
    ///Optional array of [IPSEC_TOKEN0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_token0) structures.
    IPSEC_TOKEN0* tokens;
    ///Optional handle to explicit credentials.
    ulong         explicitCredentials;
    ///Unused parameter. This should always be 0.
    ulong         logonId;
}

///The <b>IPSEC_SA_BUNDLE0</b> structure is used to store information about an IPsec security association (SA) bundle.
///[IPSEC_SA_BUNDLE1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_bundle1) is available.</div><div> </div>
struct IPSEC_SA_BUNDLE0
{
    ///A combination of the following values. <table> <tr> <th>IPsec SA bundle flag</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="IPSEC_SA_BUNDLE_FLAG_ND_SECURE"></a><a id="ipsec_sa_bundle_flag_nd_secure"></a><dl>
    ///<dt><b>IPSEC_SA_BUNDLE_FLAG_ND_SECURE</b></dt> </dl> </td> <td width="60%"> Negotiation discovery is enabled in
    ///secure ring. </td> </tr> <tr> <td width="40%"><a id="IPSEC_SA_BUNDLE_FLAG_ND_BOUNDARY"></a><a
    ///id="ipsec_sa_bundle_flag_nd_boundary"></a><dl> <dt><b>IPSEC_SA_BUNDLE_FLAG_ND_BOUNDARY</b></dt> </dl> </td> <td
    ///width="60%"> Negotiation discovery in enabled in the untrusted perimeter zone. </td> </tr> <tr> <td
    ///width="40%"><a id="IPSEC_SA_BUNDLE_FLAG_ND_PEER_NAT_BOUNDARY"></a><a
    ///id="ipsec_sa_bundle_flag_nd_peer_nat_boundary"></a><dl> <dt><b>IPSEC_SA_BUNDLE_FLAG_ND_PEER_NAT_BOUNDARY</b></dt>
    ///</dl> </td> <td width="60%"> Peer is in untrusted perimeter zone ring and a NAT is in the way. Used with
    ///negotiation discovery. </td> </tr> <tr> <td width="40%"><a id="IPSEC_SA_BUNDLE_FLAG_GUARANTEE_ENCRYPTION"></a><a
    ///id="ipsec_sa_bundle_flag_guarantee_encryption"></a><dl> <dt><b>IPSEC_SA_BUNDLE_FLAG_GUARANTEE_ENCRYPTION</b></dt>
    ///</dl> </td> <td width="60%"> Indicates that this is an SA for connections that require guaranteed encryption.
    ///</td> </tr> <tr> <td width="40%"><a id="_IPSEC_SA_BUNDLE_FLAG_NLB"></a><a id="_ipsec_sa_bundle_flag_nlb"></a><dl>
    ///<dt><b> IPSEC_SA_BUNDLE_FLAG_NLB</b></dt> </dl> </td> <td width="60%"> Indicates that this is an SA to an NLB
    ///server. </td> </tr> <tr> <td width="40%"><a id="_IPSEC_SA_BUNDLE_FLAG_NO_MACHINE_LUID_VERIFY"></a><a
    ///id="_ipsec_sa_bundle_flag_no_machine_luid_verify"></a><dl> <dt><b>
    ///IPSEC_SA_BUNDLE_FLAG_NO_MACHINE_LUID_VERIFY</b></dt> </dl> </td> <td width="60%"> Indicates that this SA should
    ///bypass machine LUID verification. </td> </tr> <tr> <td width="40%"><a
    ///id="_IPSEC_SA_BUNDLE_FLAG_NO_IMPERSONATION_LUID_VERIFY"></a><a
    ///id="_ipsec_sa_bundle_flag_no_impersonation_luid_verify"></a><dl> <dt><b>
    ///IPSEC_SA_BUNDLE_FLAG_NO_IMPERSONATION_LUID_VERIFY</b></dt> </dl> </td> <td width="60%"> Indicates that this SA
    ///should bypass impersonation LUID verification. </td> </tr> <tr> <td width="40%"><a
    ///id="_IPSEC_SA_BUNDLE_FLAG_NO_EXPLICIT_CRED_MATCH"></a><a
    ///id="_ipsec_sa_bundle_flag_no_explicit_cred_match"></a><dl> <dt><b>
    ///IPSEC_SA_BUNDLE_FLAG_NO_EXPLICIT_CRED_MATCH</b></dt> </dl> </td> <td width="60%"> Indicates that this SA should
    ///bypass explicit credential handle matching. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_SA_BUNDLE_FLAG_ALLOW_NULL_TARGET_NAME_MATCH"></a><a
    ///id="ipsec_sa_bundle_flag_allow_null_target_name_match"></a><dl>
    ///<dt><b>IPSEC_SA_BUNDLE_FLAG_ALLOW_NULL_TARGET_NAME_MATCH</b></dt> </dl> </td> <td width="60%"> Allows an SA
    ///formed with a peer name to carry traffic that does not have an associated peer target. </td> </tr> <tr> <td
    ///width="40%"><a id="IPSEC_SA_BUNDLE_FLAG_CLEAR_DF_ON_TUNNEL"></a><a
    ///id="ipsec_sa_bundle_flag_clear_df_on_tunnel"></a><dl> <dt><b>IPSEC_SA_BUNDLE_FLAG_CLEAR_DF_ON_TUNNEL</b></dt>
    ///</dl> </td> <td width="60%"> Clears the <b>DontFragment</b> bit on the outer IP header of an IPsec-tunneled
    ///packet. This flag is applicable only to tunnel mode SAs. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_SA_BUNDLE_FLAG_ASSUME_UDP_CONTEXT_OUTBOUND"></a><a
    ///id="ipsec_sa_bundle_flag_assume_udp_context_outbound"></a><dl>
    ///<dt><b>IPSEC_SA_BUNDLE_FLAG_ASSUME_UDP_CONTEXT_OUTBOUND</b></dt> </dl> </td> <td width="60%"> Default
    ///encapsulation ports (4500 and 4000) can be used when matching this SA with packets on outbound connections that
    ///do not have an associated IPsec-NAT-shim context. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_SA_BUNDLE_FLAG_ND_PEER_BOUNDARY"></a><a id="ipsec_sa_bundle_flag_nd_peer_boundary"></a><dl>
    ///<dt><b>IPSEC_SA_BUNDLE_FLAG_ND_PEER_BOUNDARY</b></dt> </dl> </td> <td width="60%"> Peer has negotiation discovery
    ///enabled, and is on a perimeter network. </td> </tr> </table>
    uint               flags;
    ///Lifetime of all the SAs in the bundle as specified by
    ///[IPSEC_SA_LIFETIME0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_lifetime0).
    IPSEC_SA_LIFETIME0 lifetime;
    ///Timeout in seconds after which the SAs in the bundle will idle out (due to traffic inactivity) and expire.
    uint               idleTimeoutSeconds;
    ///Timeout in seconds, after which the IPsec SA should stop accepting packets coming in the clear. Used for
    ///negotiation discovery.
    uint               ndAllowClearTimeoutSeconds;
    ///Pointer to an [IPSEC_ID0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_id0) structure that contains
    ///optional IPsec identity info.
    IPSEC_ID0*         ipsecId;
    ///Network Access Protection (NAP) peer credentials information.
    uint               napContext;
    ///SA identifier used by IPsec when choosing the SA to expire. For an IPsec SA pair, the <b>qmSaId</b> must be the
    ///same between the initiating and responding machines and across inbound and outbound SA bundles. For different
    ///IPsec pairs, the <b>qmSaId</b> must be different.
    uint               qmSaId;
    ///Number of SAs in the bundle. The only possible values are 1 and 2. Use 2 only when specifying AH + ESP SAs.
    uint               numSAs;
    ///Array of IPsec SAs in the bundle. For AH + ESP SAs, use index [0] for ESP SA and index [1] for AH SA. See
    ///[IPSEC_SA0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa0) for more information.
    IPSEC_SA0*         saList;
    ///Optional keying module specific information as specified by
    ///[IPSEC_KEYMODULE_STATE0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_keymodule_state0).
    IPSEC_KEYMODULE_STATE0* keyModuleState;
    ///IP version as specified by [FWP_IP_VERSION](/windows/desktop/api/fwptypes/ne-fwptypes-fwp_ip_version).
    FWP_IP_VERSION     ipVersion;
union
    {
        uint peerV4PrivateAddress;
    }
    ///Use this ID to correlate this IPsec SA with the IKE SA that generated it.
    ulong              mmSaId;
    ///Specifies whether Quick Mode perfect forward secrecy (PFS) was enabled for this SA, and if so, contains the
    ///Diffie-Hellman group that was used for PFS. See
    ///[IPSEC_PFS_GROUP](/windows/desktop/api/ipsectypes/ne-ipsectypes-ipsec_pfs_group) for more information.
    IPSEC_PFS_GROUP    pfsGroup;
}

///The <b>IPSEC_SA_BUNDLE1</b> structure is used to store information about an IPsec security association (SA) bundle.
///[IPSEC_SA_BUNDLE0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_bundle0) is available.</div><div> </div>
struct IPSEC_SA_BUNDLE1
{
    ///A combination of the following values. <table> <tr> <th>IPsec SA bundle flag</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="IPSEC_SA_BUNDLE_FLAG_ND_SECURE"></a><a id="ipsec_sa_bundle_flag_nd_secure"></a><dl>
    ///<dt><b>IPSEC_SA_BUNDLE_FLAG_ND_SECURE</b></dt> </dl> </td> <td width="60%"> Negotiation discovery is enabled in
    ///secure ring. </td> </tr> <tr> <td width="40%"><a id="IPSEC_SA_BUNDLE_FLAG_ND_BOUNDARY"></a><a
    ///id="ipsec_sa_bundle_flag_nd_boundary"></a><dl> <dt><b>IPSEC_SA_BUNDLE_FLAG_ND_BOUNDARY</b></dt> </dl> </td> <td
    ///width="60%"> Negotiation discovery in enabled in the untrusted perimeter zone. </td> </tr> <tr> <td
    ///width="40%"><a id="IPSEC_SA_BUNDLE_FLAG_ND_PEER_NAT_BOUNDARY"></a><a
    ///id="ipsec_sa_bundle_flag_nd_peer_nat_boundary"></a><dl> <dt><b>IPSEC_SA_BUNDLE_FLAG_ND_PEER_NAT_BOUNDARY</b></dt>
    ///</dl> </td> <td width="60%"> Peer is in untrusted perimeter zone ring and a network address translation (NAT) is
    ///in the way. Used with negotiation discovery. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_SA_BUNDLE_FLAG_GUARANTEE_ENCRYPTION"></a><a id="ipsec_sa_bundle_flag_guarantee_encryption"></a><dl>
    ///<dt><b>IPSEC_SA_BUNDLE_FLAG_GUARANTEE_ENCRYPTION</b></dt> </dl> </td> <td width="60%"> Indicates that this is an
    ///SA for connections that require guaranteed encryption. </td> </tr> <tr> <td width="40%"><a
    ///id="_IPSEC_SA_BUNDLE_FLAG_NLB"></a><a id="_ipsec_sa_bundle_flag_nlb"></a><dl> <dt><b>
    ///IPSEC_SA_BUNDLE_FLAG_NLB</b></dt> </dl> </td> <td width="60%"> Indicates that this is an SA to an NLB server.
    ///</td> </tr> <tr> <td width="40%"><a id="_IPSEC_SA_BUNDLE_FLAG_NO_MACHINE_LUID_VERIFY"></a><a
    ///id="_ipsec_sa_bundle_flag_no_machine_luid_verify"></a><dl> <dt><b>
    ///IPSEC_SA_BUNDLE_FLAG_NO_MACHINE_LUID_VERIFY</b></dt> </dl> </td> <td width="60%"> Indicates that this SA should
    ///bypass machine LUID verification. </td> </tr> <tr> <td width="40%"><a
    ///id="_IPSEC_SA_BUNDLE_FLAG_NO_IMPERSONATION_LUID_VERIFY"></a><a
    ///id="_ipsec_sa_bundle_flag_no_impersonation_luid_verify"></a><dl> <dt><b>
    ///IPSEC_SA_BUNDLE_FLAG_NO_IMPERSONATION_LUID_VERIFY</b></dt> </dl> </td> <td width="60%"> Indicates that this SA
    ///should bypass impersonation LUID verification. </td> </tr> <tr> <td width="40%"><a
    ///id="_IPSEC_SA_BUNDLE_FLAG_NO_EXPLICIT_CRED_MATCH"></a><a
    ///id="_ipsec_sa_bundle_flag_no_explicit_cred_match"></a><dl> <dt><b>
    ///IPSEC_SA_BUNDLE_FLAG_NO_EXPLICIT_CRED_MATCH</b></dt> </dl> </td> <td width="60%"> Indicates that this SA should
    ///bypass explicit credential handle matching. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_SA_BUNDLE_FLAG_ALLOW_NULL_TARGET_NAME_MATCH"></a><a
    ///id="ipsec_sa_bundle_flag_allow_null_target_name_match"></a><dl>
    ///<dt><b>IPSEC_SA_BUNDLE_FLAG_ALLOW_NULL_TARGET_NAME_MATCH</b></dt> </dl> </td> <td width="60%"> Allows an SA
    ///formed with a peer name to carry traffic that does not have an associated peer target. </td> </tr> <tr> <td
    ///width="40%"><a id="IPSEC_SA_BUNDLE_FLAG_CLEAR_DF_ON_TUNNEL"></a><a
    ///id="ipsec_sa_bundle_flag_clear_df_on_tunnel"></a><dl> <dt><b>IPSEC_SA_BUNDLE_FLAG_CLEAR_DF_ON_TUNNEL</b></dt>
    ///</dl> </td> <td width="60%"> Clears the <b>DontFragment</b> bit on the outer IP header of an IPsec-tunneled
    ///packet. This flag is applicable only to tunnel mode SAs. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_SA_BUNDLE_FLAG_ASSUME_UDP_CONTEXT_OUTBOUND"></a><a
    ///id="ipsec_sa_bundle_flag_assume_udp_context_outbound"></a><dl>
    ///<dt><b>IPSEC_SA_BUNDLE_FLAG_ASSUME_UDP_CONTEXT_OUTBOUND</b></dt> </dl> </td> <td width="60%"> Default
    ///encapsulation ports (4500 and 4000) can be used when matching this SA with packets on outbound connections that
    ///do not have an associated IPsec-NAT-shim context. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_SA_BUNDLE_FLAG_ND_PEER_BOUNDARY"></a><a id="ipsec_sa_bundle_flag_nd_peer_boundary"></a><dl>
    ///<dt><b>IPSEC_SA_BUNDLE_FLAG_ND_PEER_BOUNDARY</b></dt> </dl> </td> <td width="60%"> Peer has negotiation discovery
    ///enabled, and is on a perimeter network. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_SA_BUNDLE_FLAG_SUPPRESS_DUPLICATE_DELETION"></a><a
    ///id="ipsec_sa_bundle_flag_suppress_duplicate_deletion"></a><dl>
    ///<dt><b>IPSEC_SA_BUNDLE_FLAG_SUPPRESS_DUPLICATE_DELETION</b></dt> </dl> </td> <td width="60%"> Suppresses the
    ///duplicate SA deletion logic. THis logic is performed by the kernel when an outbound SA is added, to prevent
    ///unnecessary duplicate SAs. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_SA_BUNDLE_FLAG_PEER_SUPPORTS_GUARANTEE_ENCRYPTION"></a><a
    ///id="ipsec_sa_bundle_flag_peer_supports_guarantee_encryption"></a><dl>
    ///<dt><b>IPSEC_SA_BUNDLE_FLAG_PEER_SUPPORTS_GUARANTEE_ENCRYPTION</b></dt> </dl> </td> <td width="60%"> Indicates
    ///that the peer computer supports negotiating a separate SA for connections that require guaranteed encryption.
    ///</td> </tr> </table>
    uint               flags;
    ///Lifetime of all the SAs in the bundle as specified by
    ///[IPSEC_SA_LIFETIME0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_lifetime0).
    IPSEC_SA_LIFETIME0 lifetime;
    ///Timeout in seconds after which the SAs in the bundle will idle out (due to traffic inactivity) and expire.
    uint               idleTimeoutSeconds;
    ///Timeout in seconds, after which the IPsec SA should stop accepting packets coming in the clear. Used for
    ///negotiation discovery.
    uint               ndAllowClearTimeoutSeconds;
    ///Pointer to an [IPSEC_ID0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_id0) structure that contains
    ///optional IPsec identity info.
    IPSEC_ID0*         ipsecId;
    ///Network Access Point (NAP) peer credentials information.
    uint               napContext;
    ///SA identifier used by IPsec when choosing the SA to expire. For an IPsec SA pair, the <b>qmSaId</b> must be the
    ///same between the initiating and responding machines and across inbound and outbound SA bundles. For different
    ///IPsec pairs, the <b>qmSaId</b> must be different.
    uint               qmSaId;
    ///Number of SAs in the bundle. The only possible values are 1 and 2. Use 2 only when specifying AH and ESP SAs.
    uint               numSAs;
    ///Array of IPsec SAs in the bundle. For AH and ESP SAs, use index 0 for ESP SA and index 1 for AH SA. See
    ///[IPSEC_SA0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa0) for more information.
    IPSEC_SA0*         saList;
    ///Optional keying module specific information as specified by
    ///[IPSEC_KEYMODULE_STATE0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_keymodule_state0).
    IPSEC_KEYMODULE_STATE0* keyModuleState;
    ///IP version as specified by [FWP_IP_VERSION](/windows/desktop/api/fwptypes/ne-fwptypes-fwp_ip_version).
    FWP_IP_VERSION     ipVersion;
union
    {
        uint peerV4PrivateAddress;
    }
    ///Use this ID to correlate this IPsec SA with the IKE SA that generated it.
    ulong              mmSaId;
    ///Specifies whether Quick Mode perfect forward secrecy (PFS) was enabled for this SA, and if so, contains the
    ///Diffie-Hellman group that was used for PFS. See
    ///[IPSEC_PFS_GROUP](/windows/desktop/api/ipsectypes/ne-ipsectypes-ipsec_pfs_group) for more information.
    IPSEC_PFS_GROUP    pfsGroup;
    ///SA lookup context which is propagated from the SA to data connections flowing over that SA. It is made available
    ///to any application that queries socket security properties using the Winsock API WSAQuerySocketSecurity function,
    ///allowing the application to obtain detailed IPsec authentication information for its connection.
    GUID               saLookupContext;
    ulong              qmFilterId;
}

///The <b>IPSEC_TRAFFIC0</b> structure specifies parameters to describe IPsec traffic.
///[IPSEC_TRAFFIC1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_traffic1) is available.</div><div> </div>
struct IPSEC_TRAFFIC0
{
    ///Internet Protocol (IP) version. See [FWP_IP_VERSION](/windows/desktop/api/fwptypes/ne-fwptypes-fwp_ip_version)
    ///for more information.
    FWP_IP_VERSION     ipVersion;
union
    {
        uint      localV4Address;
        ubyte[16] localV6Address;
    }
union
    {
        uint      remoteV4Address;
        ubyte[16] remoteV6Address;
    }
    ///Type of IPsec traffic. See [IPSEC_TRAFFIC_TYPE](/windows/desktop/api/ipsectypes/ne-ipsectypes-ipsec_traffic_type)
    ///for more information.
    IPSEC_TRAFFIC_TYPE trafficType;
union
    {
        ulong ipsecFilterId;
        ulong tunnelPolicyId;
    }
    ///The remote TCP/UDP port for this traffic. This is used when the remote port condition in the transport layer
    ///filter is more generic than the actual remote port.
    ushort             remotePort;
}

///The <b>IPSEC_TRAFFIC1</b> structure specifies parameters to describe IPsec traffic.
///[IPSEC_TRAFFIC0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_traffic0) is available.</div><div> </div>
struct IPSEC_TRAFFIC1
{
    ///An [FWP_IP_VERSION](/windows/desktop/api/fwptypes/ne-fwptypes-fwp_ip_version) value that specifies the IP
    ///version. In tunnel mode, this is the version of the outer header.
    FWP_IP_VERSION     ipVersion;
union
    {
        uint      localV4Address;
        ubyte[16] localV6Address;
    }
union
    {
        uint      remoteV4Address;
        ubyte[16] remoteV6Address;
    }
    ///Type of IPsec traffic. See [IPSEC_TRAFFIC_TYPE](/windows/desktop/api/ipsectypes/ne-ipsectypes-ipsec_traffic_type)
    ///for more information.
    IPSEC_TRAFFIC_TYPE trafficType;
union
    {
        ulong ipsecFilterId;
        ulong tunnelPolicyId;
    }
    ///The remote TCP/UDP port for this traffic. This is used when the remote port condition in the transport layer
    ///filter is more generic than the actual remote port.
    ushort             remotePort;
    ///The local TCP/UDP port for this traffic. This is used when the local port condition in the transport layer filter
    ///is more generic than the actual local port.
    ushort             localPort;
    ///The IP protocol for this traffic. This is used when the IP protocol condition in the transport layer filter is
    ///more generic than the actual IP protocol.
    ubyte              ipProtocol;
    ///The LUID of the local interface corresponding to the local address specified above.
    ulong              localIfLuid;
    ///The profile ID corresponding to the actual interface that the traffic is using.
    uint               realIfProfileId;
}

///The <b>IPSEC_V4_UDP_ENCAPSULATION0</b> structure stores the User Datagram Protocol (UDP) encapsulation ports for
///Encapsulating Security Payload (ESP) encapsulation.
struct IPSEC_V4_UDP_ENCAPSULATION0
{
    ///Source UDP encapsulation port.
    ushort localUdpEncapPort;
    ///Destination UDP encapsulation port.
    ushort remoteUdpEncapPort;
}

///The <b>IPSEC_GETSPI0</b> structure contains information that must be supplied when requesting a security parameter
///index (SPI) from the IPsec driver. [IPSEC_GETSPI1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_getspi1) is
///available.</div><div> </div>
struct IPSEC_GETSPI0
{
    ///An [IPSEC_TRAFFIC0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_traffic0) structure that describes
    ///traffic characteristics of the inbound IPsec SA.
    IPSEC_TRAFFIC0 inboundIpsecTraffic;
    ///A [FWP_IP_VERSION](/windows/desktop/api/fwptypes/ne-fwptypes-fwp_ip_version) value that indicates the IP version
    ///of the inbound IPsec traffic.
    FWP_IP_VERSION ipVersion;
union
    {
        IPSEC_V4_UDP_ENCAPSULATION0* inboundUdpEncapsulation;
    }
    ///Not used. A <b>IPSEC_CRYPTO_MODULE_ID</b> is a <b>GUID</b> value.
    GUID*          rngCryptoModuleID;
}

///The <b>IPSEC_GETSPI1</b> structure contains information that must be supplied when requesting a security parameter
///index (SPI) from the IPsec driver. [IPSEC_GETSPI0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_getspi0) is
///available.</div><div> </div>
struct IPSEC_GETSPI1
{
    ///An [IPSEC_TRAFFIC1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_traffic1) structure that describes
    ///traffic characteristics of the inbound IPsec SA.
    IPSEC_TRAFFIC1 inboundIpsecTraffic;
    ///An [FWP_IP_VERSION](/windows/desktop/api/fwptypes/ne-fwptypes-fwp_ip_version) value that indicates the IP version
    ///of the inbound IPsec traffic.
    FWP_IP_VERSION ipVersion;
union
    {
        IPSEC_V4_UDP_ENCAPSULATION0* inboundUdpEncapsulation;
    }
    ///Not used. An <b>IPSEC_CRYPTO_MODULE_ID</b> is a <b>GUID</b> value.
    GUID*          rngCryptoModuleID;
}

///The <b>IPSEC_SA_DETAILS0</b> structure is used to store information returned when enumerating IPsec security
///associations (SAs). [IPSEC_SA_DETAILS1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_details1) is
///available.</div><div> </div>
struct IPSEC_SA_DETAILS0
{
    ///Internet Protocol (IP) version as specified by
    ///[FWP_IP_VERSION](/windows/desktop/api/fwptypes/ne-fwptypes-fwp_ip_version).
    FWP_IP_VERSION   ipVersion;
    ///Indicates direction of the IPsec SA as specified by
    ///[FWP_DIRECTION](/windows/desktop/api/fwptypes/ne-fwptypes-fwp_direction).
    FWP_DIRECTION    saDirection;
    ///The traffic being secured by this IPsec SA as specified by
    ///[IPSEC_TRAFFIC0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_traffic0).
    IPSEC_TRAFFIC0   traffic;
    ///Various parameters of the SA as specified by
    ///[IPSEC_SA_BUNDLE0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_bundle0).
    IPSEC_SA_BUNDLE0 saBundle;
union
    {
        IPSEC_V4_UDP_ENCAPSULATION0* udpEncapsulation;
    }
    ///The transport layer filter corresponding to this IPsec SA as specified by
    ///[FWPM_FILTER0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_filter0).
    FWPM_FILTER0*    transportFilter;
}

///The <b>IPSEC_SA_DETAILS1</b> structure is used to store information returned when enumerating IPsec security
///associations (SAs). [IPSEC_SA_DETAILS0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_details0) is
///available.</div><div> </div>
struct IPSEC_SA_DETAILS1
{
    ///An [FWP_IP_VERSION](/windows/desktop/api/fwptypes/ne-fwptypes-fwp_ip_version) value that specifies the IP
    ///version. In tunnel mode, this is the version of the outer header.
    FWP_IP_VERSION   ipVersion;
    ///An [FWP_DIRECTION](/windows/desktop/api/fwptypes/ne-fwptypes-fwp_direction) value that indicates the direction of
    ///the IPsec SA.
    FWP_DIRECTION    saDirection;
    ///An [IPSEC_TRAFFIC1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_traffic1) structure that specifies the
    ///traffic being secured by this IPsec SA. In tunnel mode, this contains both the tunnel endpoints and Quick Mode
    ///(QM) traffic selectors.
    IPSEC_TRAFFIC1   traffic;
    ///An [IPSEC_SA_BUNDLE1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_bundle1) structure that specifies
    ///various parameters of the SA .
    IPSEC_SA_BUNDLE1 saBundle;
union
    {
        IPSEC_V4_UDP_ENCAPSULATION0* udpEncapsulation;
    }
    ///An [FWPM_FILTER0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_filter0) structure that specifies the
    ///transport layer filter that corresponds to this IPsec SA.
    FWPM_FILTER0*    transportFilter;
    ///An [IPSEC_VIRTUAL_IF_TUNNEL_INFO0](/windows/desktop/api/fwptypes/ns-fwptypes-ipsec_virtual_if_tunnel_info0)
    ///structure that specifies the virtual interface tunnel information. Only supported by Internet Key Exchange
    ///version 2 (IKEv2).
    IPSEC_VIRTUAL_IF_TUNNEL_INFO0 virtualIfTunnelInfo;
}

///The <b>IPSEC_SA_CONTEXT0</b> structure encapsulates an inbound and outbound SA pair.
///[IPSEC_SA_CONTEXT1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_context1) is available.</div><div> </div>
struct IPSEC_SA_CONTEXT0
{
    ///Identifies the SA context.
    ulong              saContextId;
    ///An [IPSEC_SA_DETAILS0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_details0) structure that contains
    ///information about the inbound SA.
    IPSEC_SA_DETAILS0* inboundSa;
    ///An [IPSEC_SA_DETAILS0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_details0) structure that contains
    ///information about the outbound SA.
    IPSEC_SA_DETAILS0* outboundSa;
}

///The <b>IPSEC_SA_CONTEXT1</b> structure encapsulates an inbound and outbound security association (SA) pair.
///[IPSEC_SA_CONTEXT0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_context0) is available.</div><div> </div>
struct IPSEC_SA_CONTEXT1
{
    ///Identifies the SA context.
    ulong              saContextId;
    ///An [IPSEC_SA_DETAILS1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_details1) structure that contains
    ///information about the inbound SA.
    IPSEC_SA_DETAILS1* inboundSa;
    ///An [IPSEC_SA_DETAILS1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_details1) structure that contains
    ///information about the outbound SA.
    IPSEC_SA_DETAILS1* outboundSa;
}

///The <b>IPSEC_SA_CONTEXT_ENUM_TEMPLATE0</b> structure is an enumeration template used to enumerate security
///association (SA) contexts.
struct IPSEC_SA_CONTEXT_ENUM_TEMPLATE0
{
    ///An [FWP_CONDITION_VALUE0](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_condition_value0) structure that
    ///specifies a subnet from which SA contexts that contain a local address will be returned. This member may be
    ///empty. Acceptable type values for this member are:
    ///[FWP_V6_ADDR_AND_MASK](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_v6_addr_and_mask).
    FWP_CONDITION_VALUE0 localSubNet;
    ///An [FWP_CONDITION_VALUE0](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_condition_value0) structure that
    ///specifies a subnet from which SA contexts that contain a remote address will be returned. This member may be
    ///empty. Acceptable type values for this member are:
    ///[FWP_V6_ADDR_AND_MASK](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_v6_addr_and_mask).
    FWP_CONDITION_VALUE0 remoteSubNet;
}

///The <b>IPSEC_SA_ENUM_TEMPLATE0</b> structure specifies a template used for restricting the enumeration of IPsec
///security associations (SAs).
struct IPSEC_SA_ENUM_TEMPLATE0
{
    ///Direction of the SA. See [FWP_DIRECTION](/windows/desktop/api/fwptypes/ne-fwptypes-fwp_direction) for more
    ///information.
    FWP_DIRECTION saDirection;
}

///The <b>IPSEC_SA_CONTEXT_SUBSCRIPTION0</b> structure stores information used to subscribe to notifications about a
///particular IPsec security association (SA) context.
struct IPSEC_SA_CONTEXT_SUBSCRIPTION0
{
    ///Type: <b>IPSEC_SA_CONTEXT_ENUM_TEMPLATE0*</b> Enumeration template for limiting the subscription.
    IPSEC_SA_CONTEXT_ENUM_TEMPLATE0* enumTemplate;
    ///Type: <b>UINT32</b> This member is reserved for system use.
    uint flags;
    ///Type: <b>GUID</b> Identifies the session that created the subscription.
    GUID sessionKey;
}

///The <b>IPSEC_SA_CONTEXT_CHANGE0</b> structure contains information about an IPsec security association (SA) context
///change.
struct IPSEC_SA_CONTEXT_CHANGE0
{
    ///Type:
    ///[IPSEC_SA_CONTEXT_EVENT_TYPE0](/windows/desktop/api/ipsectypes/ne-ipsectypes-ipsec_sa_context_event_type0)</b>
    ///The type of IPsec SA context change event.
    IPSEC_SA_CONTEXT_EVENT_TYPE0 changeType;
    ///Type: <b>UINT64</b> Identifier of the IPsec SA context that changed.
    ulong saContextId;
}

///The <b>IPSEC_ADDRESS_INFO0</b> structure is used to store mobile additional address information.
struct IPSEC_ADDRESS_INFO0
{
    ///The number of IPv4 addresses stored in the <b>v4Addresses</b> member.
    uint              numV4Addresses;
    ///Array of IPv4 local addresses to indicate to peer.
    uint*             v4Addresses;
    ///The number of IPv6 addresses stored in the <b>v6Addresses</b> member.
    uint              numV6Addresses;
    ///Array of IPv6 local addresses to indicate to peer.
    FWP_BYTE_ARRAY16* v6Addresses;
}

///The <b>IPSEC_DOSP_OPTIONS0</b> structure is used to store configuration parameters for IPsec DoS Protection.
struct IPSEC_DOSP_OPTIONS0
{
    ///The number of seconds before idle timeout. This value must be greater than 0.
    uint                 stateIdleTimeoutSeconds;
    ///The idle timeout for the per IP rate limit queue object. This value must be greater than 0.
    uint                 perIPRateLimitQueueIdleTimeoutSeconds;
    ///The DSCP marking for unauthenticated inbound IPv6 IPsec traffic. This value must be less than or equal to 63.
    ///Specify IPSEC_DOSP_DSCP_DISABLE_VALUE to disable DSCP marking for this category.
    ubyte                ipV6IPsecUnauthDscp;
    ///The rate limit for unauthenticated inbound IPv6 IPsec traffic. Specify IPSEC_DOSP_RATE_LIMIT_DISABLE_VALUE to
    ///disable rate limiting for this category.
    uint                 ipV6IPsecUnauthRateLimitBytesPerSec;
    ///The rate limit for unauthenticated inbound IPv6 IPsec traffic per internal IP address. Specify
    ///IPSEC_DOSP_RATE_LIMIT_DISABLE_VALUE to disable rate limiting for this category.
    uint                 ipV6IPsecUnauthPerIPRateLimitBytesPerSec;
    ///The DSCP marking for authenticated inbound IPv6 IPsec traffic. The value must be less than or equal to 63.
    ///Specify IPSEC_DOSP_DSCP_DISABLE_VALUE to disable DSCP marking for this category.
    ubyte                ipV6IPsecAuthDscp;
    ///The rate limit for authenticated inbound IPv6 IPsec traffic. Specify IPSEC_DOSP_RATE_LIMIT_DISABLE_VALUE to
    ///disable rate limiting for this category..
    uint                 ipV6IPsecAuthRateLimitBytesPerSec;
    ///The DSCP marking for inbound ICMPv6 traffic. The value must be less than or equal to 63. Specify
    ///IPSEC_DOSP_DSCP_DISABLE_VALUE to disable DSCP marking for this category.
    ubyte                icmpV6Dscp;
    ///The rate limit for inbound ICMPv6 traffic. Specify IPSEC_DOSP_RATE_LIMIT_DISABLE_VALUE to disable rate limiting
    ///for this category.
    uint                 icmpV6RateLimitBytesPerSec;
    ///The DSCP marking for inbound IPv6 filter exempted traffic. The value must be less than or equal to 63. Specify
    ///IPSEC_DOSP_DSCP_DISABLE_VALUE to disable DSCP marking for this category.
    ubyte                ipV6FilterExemptDscp;
    ///The rate limit for inbound IPV6 filter exempted traffic. Specify IPSEC_DOSP_RATE_LIMIT_DISABLE_VALUE to disable
    ///rate limiting for this category.
    uint                 ipV6FilterExemptRateLimitBytesPerSec;
    ///The DSCP marking for inbound default-block exempted traffic. The value must be less than or equal to 63. Specify
    ///IPSEC_DOSP_DSCP_DISABLE_VALUE to disable DSCP marking for this category.
    ubyte                defBlockExemptDscp;
    ///The rate limit for inbound default-block exempted traffic. Specify IPSEC_DOSP_RATE_LIMIT_DISABLE_VALUE to disable
    ///rate limiting for this category.
    uint                 defBlockExemptRateLimitBytesPerSec;
    ///The maximum number of state entries in the table. The value must be greater than 0.
    uint                 maxStateEntries;
    ///The maximum number of rate limit queues for inbound unauthenticated IPv6 IPsec traffic per internal IP address.
    ///The value must be greater than 0.
    uint                 maxPerIPRateLimitQueues;
    ///A combination of the following values. <table> <tr> <th>IPsec DoS Protection options flag</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="IPSEC_DOSP_FLAG_ENABLE_IKEV1"></a><a id="ipsec_dosp_flag_enable_ikev1"></a><dl>
    ///<dt><b>IPSEC_DOSP_FLAG_ENABLE_IKEV1</b></dt> </dl> </td> <td width="60%"> Allows the IKEv1 keying module. By
    ///default, it is blocked. </td> </tr> <tr> <td width="40%"><a id="IPSEC_DOSP_FLAG_ENABLE_IKEV2"></a><a
    ///id="ipsec_dosp_flag_enable_ikev2"></a><dl> <dt><b>IPSEC_DOSP_FLAG_ENABLE_IKEV2</b></dt> </dl> </td> <td
    ///width="60%"> Allows the IKEv2 keying module. By default, it is blocked. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_DOSP_FLAG_DISABLE_AUTHIP"></a><a id="ipsec_dosp_flag_disable_authip"></a><dl>
    ///<dt><b>IPSEC_DOSP_FLAG_DISABLE_AUTHIP</b></dt> </dl> </td> <td width="60%"> Blocks the AuthIP keying module. By
    ///default, it is allowed. </td> </tr> <tr> <td width="40%"><a id="IPSEC_DOSP_FLAG_DISABLE_DEFAULT_BLOCK"></a><a
    ///id="ipsec_dosp_flag_disable_default_block"></a><dl> <dt><b>IPSEC_DOSP_FLAG_DISABLE_DEFAULT_BLOCK</b></dt> </dl>
    ///</td> <td width="60%"> Allows all matching IPv4 traffic and non-IPsec IPv6 traffic. By default, all IPv4 traffic
    ///and non-IPsecIPv6 traffic, except IPv6 ICMP, will be blocked. </td> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_DOSP_FLAG_FILTER_BLOCK"></a><a id="ipsec_dosp_flag_filter_block"></a><dl>
    ///<dt><b>IPSEC_DOSP_FLAG_FILTER_BLOCK</b></dt> </dl> </td> <td width="60%"> Blocks all matching IPv6 traffic. </td>
    ///</tr> <tr> <td width="40%"><a id="IPSEC_DOSP_FLAG_FILTER_EXEMPT"></a><a
    ///id="ipsec_dosp_flag_filter_exempt"></a><dl> <dt><b>IPSEC_DOSP_FLAG_FILTER_EXEMPT</b></dt> </dl> </td> <td
    ///width="60%"> Allows all matching IPv6 traffic. </td> </tr> </table>
    uint                 flags;
    ///The number of public Internet facing interface identifiers for which DOS protection should be enabled.
    uint                 numPublicIFLuids;
    ///Pointer to an array of public Internet facing interface identifiers for which DOS protection should be enabled.
    ulong*               publicIFLuids;
    ///The number of internal network facing interface identifiers for which DOS protection should be enabled.
    uint                 numInternalIFLuids;
    ///Pointer to an array of internal network facing interface identifiers for which DOS protection should be enabled.
    ulong*               internalIFLuids;
    ///Optional public IPv6 address or subnet for this policy, as specified in
    ///[FWP_V6_ADDR_AND_MASK](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_v6_addr_and_mask).
    FWP_V6_ADDR_AND_MASK publicV6AddrMask;
    ///Optional internal IPv6 address or subnet for this policy, as specified in
    ///[FWP_V6_ADDR_AND_MASK](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_v6_addr_and_mask).
    FWP_V6_ADDR_AND_MASK internalV6AddrMask;
}

///The <b>IPSEC_DOSP_STATISTICS0</b> structure is used to store statistics for IPsec DoS Protection.
struct IPSEC_DOSP_STATISTICS0
{
    ///The total number of state entries that have been created since the computer was last started.
    ulong totalStateEntriesCreated;
    ///The current number of state entries in the table.
    ulong currentStateEntries;
    ///The total number of inbound IPv6 IPsec unauthenticated packets that have been allowed since the computer was last
    ///started.
    ulong totalInboundAllowedIPv6IPsecUnauthPkts;
    ///The total number of inbound IPv6 IPsec unauthenticated packets that have been discarded due to rate limiting
    ///since the computer was last started.
    ulong totalInboundRatelimitDiscardedIPv6IPsecUnauthPkts;
    ///The total number of inbound IPv6 IPsec unauthenticated packets that have been discarded due to per internal IP
    ///address rate limiting since the computer was last started.
    ulong totalInboundPerIPRatelimitDiscardedIPv6IPsecUnauthPkts;
    ///The total number of inbound IPV6 IPsec unauthenticated packets that have been discarded due to all other reasons
    ///since the computer was last started.
    ulong totalInboundOtherDiscardedIPv6IPsecUnauthPkts;
    ///The total number of inbound IPv6 IPsec authenticated packets that have been allowed since the computer was last
    ///started.
    ulong totalInboundAllowedIPv6IPsecAuthPkts;
    ///The total number of inbound IPv6 IPsec authenticated packets that have been discarded due to rate limiting since
    ///the computer was last started.
    ulong totalInboundRatelimitDiscardedIPv6IPsecAuthPkts;
    ///The total number of inbound IPV6 IPsec authenticated packets that have been discarded due to all other reasons
    ///since the computer was last started.
    ulong totalInboundOtherDiscardedIPv6IPsecAuthPkts;
    ///The total number of inbound ICMPv6 packets that have been allowed since the computer was last started.
    ulong totalInboundAllowedICMPv6Pkts;
    ///The total number of inbound ICMPv6 packets that have been discarded due to rate limiting since the computer was
    ///last started.
    ulong totalInboundRatelimitDiscardedICMPv6Pkts;
    ///The total number of inbound IPv6 filter exempted packets that have been allowed since the computer was last
    ///started.
    ulong totalInboundAllowedIPv6FilterExemptPkts;
    ///The total number of inbound IPv6 filter exempted packets that have been discarded due to rate limiting since the
    ///computer was last started.
    ulong totalInboundRatelimitDiscardedIPv6FilterExemptPkts;
    ///The total number of inbound IPv6 filter blocked packets that have been discarded since the computer was last
    ///started.
    ulong totalInboundDiscardedIPv6FilterBlockPkts;
    ///The total number of inbound default-block exempted packets that have been allowed since the computer was last
    ///started.
    ulong totalInboundAllowedDefBlockExemptPkts;
    ///The total number of inbound default-block exempted packets that have been discarded due to rate limiting since
    ///the computer was last started.
    ulong totalInboundRatelimitDiscardedDefBlockExemptPkts;
    ///The total number of inbound default-block packets that have been discarded since the computer was last started.
    ulong totalInboundDiscardedDefBlockPkts;
    ///The current number of per internal IP address rate limit queues for inbound IPv6 unauthenticated IPsec traffic.
    ulong currentInboundIPv6IPsecUnauthPerIPRateLimitQueues;
}

///The <b>IPSEC_DOSP_STATE0</b> structure is used to store state information for IPsec DoS Protection.
struct IPSEC_DOSP_STATE0
{
    ///The IPv6 address of the public host.
    ubyte[16] publicHostV6Addr;
    ///The IPv6 address of the internal host.
    ubyte[16] internalHostV6Addr;
    ///The total number of inbound IPv6 IPsec packets that have been allowed since the state entry was created.
    ulong     totalInboundIPv6IPsecAuthPackets;
    ///The total number of outbound IPv6 IPsec packets that have been allowed since the state entry was created.
    ulong     totalOutboundIPv6IPsecAuthPackets;
    ///The duration, in seconds, since the state entry was created.
    uint      durationSecs;
}

///The <b>IPSEC_DOSP_STATE_ENUM_TEMPLATE0</b> structure is used to enumerate IPsec DoS Protection state entries.
struct IPSEC_DOSP_STATE_ENUM_TEMPLATE0
{
    ///An [FWP_V6_ADDR_AND_MASK](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_v6_addr_and_mask) structure that
    ///specifies the public IPv6 address.
    FWP_V6_ADDR_AND_MASK publicV6AddrMask;
    ///An [FWP_V6_ADDR_AND_MASK](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_v6_addr_and_mask) structure that
    ///specifies the internal IPv6 address.
    FWP_V6_ADDR_AND_MASK internalV6AddrMask;
}

///The <b>IPSEC_KEY_MANAGER0</b> structure is used to register key management callbacks with IPsec.
struct IPSEC_KEY_MANAGER0
{
    ///Type: <b>GUID</b> Uniquely identifies the Key Manager.
    GUID               keyManagerKey;
    ///Type: [FWPM_DISPLAY_DATA0](/windows/desktop/api/fwptypes/ns-fwptypes-fwpm_display_data0)</b> Contains annotations
    ///associated with the filter.
    FWPM_DISPLAY_DATA0 displayData;
    ///Type: <b>UINT32</b> Possible values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="IPSEC_KEY_MANAGER_FLAG_DICTATE_KEY"></a><a id="ipsec_key_manager_flag_dictate_key"></a><dl>
    ///<dt><b>IPSEC_KEY_MANAGER_FLAG_DICTATE_KEY</b></dt> </dl> </td> <td width="60%"> Specifies that the TIA will be
    ///able to accept key notifications and also potentially dictate keys. If this flag is not set, the TIA can only
    ///accept key notifications and will not be able to dictate keys. </td> </tr> </table>
    uint               flags;
    ///Type: <b>UINT8</b> Time, in seconds, after which the <b>keyDictation</b> callback must return in order for
    ///registration to succeed. Set this field to <b>0</b> in order to use the default timeout (5 seconds).
    ubyte              keyDictationTimeoutHint;
}

///The <b>FWPM_SESSION0</b> structure stores the state associated with a client session.
struct FWPM_SESSION0
{
    ///Uniquely identifies the session. If this member is zero in the call to FwpmEngineOpen0, Base Filtering Engine
    ///(BFE) will generate a GUID.
    GUID               sessionKey;
    ///Allows sessions to be annotated in a human-readable form. See
    ///[FWPM_DISPLAY_DATA0](/windows/desktop/api/fwptypes/ns-fwptypes-fwpm_display_data0) for more information.
    FWPM_DISPLAY_DATA0 displayData;
    ///Settings to control session behavior. <table> <tr> <th>Session flag</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="FWPM_SESSION_FLAG_DYNAMIC"></a><a id="fwpm_session_flag_dynamic"></a><dl>
    ///<dt><b>FWPM_SESSION_FLAG_DYNAMIC</b></dt> </dl> </td> <td width="60%"> When this flag is set, any objects added
    ///during the session are automatically deleted when the session ends. </td> </tr> <tr> <td width="40%"><a
    ///id="FWPM_SESSION_FLAG_RESERVED"></a><a id="fwpm_session_flag_reserved"></a><dl>
    ///<dt><b>FWPM_SESSION_FLAG_RESERVED</b></dt> </dl> </td> <td width="60%"> Reserved. </td> </tr> </table>
    uint               flags;
    ///Time in milli-seconds that a client will wait to begin a transaction. If this member is zero, BFE will use a
    ///default timeout.
    uint               txnWaitTimeoutInMSec;
    ///Process ID of the client.
    uint               processId;
    ///SID of the client.
    SID*               sid;
    ///User name of the client.
    PWSTR              username;
    ///TRUE if this is a kernel-mode client.
    BOOL               kernelMode;
}

///The <b>FWPM_SESSION_ENUM_TEMPLATE0</b> structure is used for enumerating sessions.
struct FWPM_SESSION_ENUM_TEMPLATE0
{
    ///Reserved for system use.
    ulong reserved;
}

///The <b>FWPM_PROVIDER0</b> structure stores the state associated with a policy provider.
struct FWPM_PROVIDER0
{
    ///Uniquely identifies the provider. If the GUID is zero-initialized in the call to Add, Base Filtering Engine (BFE)
    ///will generate one.
    GUID               providerKey;
    ///Allows providers to be annotated in a human-readable form. The
    ///[FWPM_DISPLAY_DATA0](/windows/desktop/api/fwptypes/ns-fwptypes-fwpm_display_data0) structure is required.
    FWPM_DISPLAY_DATA0 displayData;
    ///Bit flags that indicate information about the persistence of the provider. <table> <tr> <th>Provider flag</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="FWPM_PROVIDER_FLAG_PERSISTENT"></a><a
    ///id="fwpm_provider_flag_persistent"></a><dl> <dt><b>FWPM_PROVIDER_FLAG_PERSISTENT</b></dt> </dl> </td> <td
    ///width="60%"> Provider is persistent. </td> </tr> <tr> <td width="40%"><a id="FWPM_PROVIDER_FLAG_DISABLED"></a><a
    ///id="fwpm_provider_flag_disabled"></a><dl> <dt><b>FWPM_PROVIDER_FLAG_DISABLED</b></dt> </dl> </td> <td
    ///width="60%"> Provider's filters were disabled when the BFE started because the provider has no associated Windows
    ///service name, or because the associated service was not set to auto-start. <div class="alert"><b>Note</b> This
    ///flag cannot be set when adding new providers. It can only be returned by BFE when getting or enumerating
    ///providers.</div> <div> </div> </td> </tr> </table>
    uint               flags;
    ///An [FWP_BYTE_BLOB](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_byte_blob) structure that contains optional
    ///provider-specific data that allows providers to store additional context info with the object.
    FWP_BYTE_BLOB      providerData;
    ///Optional name of the Windows service hosting the provider. This allows BFE to detect that a provider has been
    ///disabled.
    PWSTR              serviceName;
}

///The <b>FWPM_PROVIDER_ENUM_TEMPLATE0</b> structure is used for enumerating providers.
struct FWPM_PROVIDER_ENUM_TEMPLATE0
{
    ///Reserved for system use.
    ulong reserved;
}

///The <b>FWPM_PROVIDER_CHANGE0</b> structure specifies a change notification dispatched to subscribers.
struct FWPM_PROVIDER_CHANGE0
{
    ///Type of change. See [FWPM_CHANGE_TYPE](/windows/desktop/api/fwpmtypes/ne-fwpmtypes-fwpm_change_type) for more
    ///information.
    FWPM_CHANGE_TYPE changeType;
    ///GUID of the provider that changed.
    GUID             providerKey;
}

///The <b>FWPM_PROVIDER_SUBSCRIPTION0</b> structure is used to subscribe for change notifications.
struct FWPM_PROVIDER_SUBSCRIPTION0
{
    ///[unique] Enumeration template for limiting the subscription. See
    ///[FWPM_PROVIDER_ENUM_TEMPLATE0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_provider_enum_template0) for more
    ///information.
    FWPM_PROVIDER_ENUM_TEMPLATE0* enumTemplate;
    ///Possible values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="FWPM_SUBSCRIPTION_FLAG_NOTIFY_ON_ADD"></a><a id="fwpm_subscription_flag_notify_on_add"></a><dl>
    ///<dt><b>FWPM_SUBSCRIPTION_FLAG_NOTIFY_ON_ADD</b></dt> </dl> </td> <td width="60%"> Subscribe to provider add
    ///notifications. </td> </tr> <tr> <td width="40%"><a id="FWPM_SUBSCRIPTION_FLAG_NOTIFY_ON_DELETE"></a><a
    ///id="fwpm_subscription_flag_notify_on_delete"></a><dl> <dt><b>FWPM_SUBSCRIPTION_FLAG_NOTIFY_ON_DELETE</b></dt>
    ///</dl> </td> <td width="60%"> Subscribe to provider delete notifications. </td> </tr> </table>
    uint flags;
    ///Uniquely identifies the session.
    GUID sessionKey;
}

///The <b>FWPM_CLASSIFY_OPTION0</b> structure is used to define unicast and multicast timeout options and data.
struct FWPM_CLASSIFY_OPTION0
{
    ///An [FWP_CLASSIFY_OPTION_TYPE](/windows/desktop/api/fwptypes/ne-fwptypes-fwp_classify_option_type) value.
    FWP_CLASSIFY_OPTION_TYPE type;
    ///An [FWP_VALUE0](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_value0) structure.
    FWP_VALUE0 value;
}

///The <b>FWPM_CLASSIFY_OPTIONS0</b> structure is used to store <b>FWPM_CLASSIFY_OPTION0</b> structures.
struct FWPM_CLASSIFY_OPTIONS0
{
    ///Number of <b>FWPM_CLASSIFY_OPTION0</b> structures in the <b>options</b> member.
    uint numOptions;
    ///[size_is(numCredentials)] Pointer to an array of
    ///[FWPM_CLASSIFY_OPTION0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_classify_option0) structures.
    FWPM_CLASSIFY_OPTION0* options;
}

///The **FWPM_PROVIDER_CONTEXT0** structure stores the state associated with a provider context.
///[FWPM_PROVIDER_CONTEXT2](ns-fwpmtypes-fwpm_provider_context2.md) is available.
struct FWPM_PROVIDER_CONTEXT0
{
    ///Uniquely identifies the provider context. If the GUID is zero-initialized in the call to
    ///[FwpmProviderContextAdd0](../fwpmu/nf-fwpmu-fwpmprovidercontextadd0.md), Base Filtering Engine (BFE) will
    ///generate one.
    GUID               providerContextKey;
    ///Allows provider contexts to be annotated in a human-readable form. The
    ///[FWPM_DISPLAY_DATA0](../fwptypes/ns-fwptypes-fwpm_display_data0.md) structure is required.
    FWPM_DISPLAY_DATA0 displayData;
    ///Possible values: | Provider context flag | Meaning | | ----- | ------- | | FWPM_PROVIDER_CONTEXT_FLAG_PERSISTENT
    ///| The object is persistent, that is, it survives across BFE stop/start. |
    uint               flags;
    ///GUID of the policy provider that manages this object.
    GUID*              providerKey;
    ///An [FWP_BYTE_BLOB](../fwptypes/ns-fwptypes-fwp_byte_blob.md) structure that contains optional provider-specific
    ///data that allows providers to store additional context info with the object.
    FWP_BYTE_BLOB      providerData;
    ///A [FWPM_PROVIDER_CONTEXT_TYPE](ne-fwpmtypes-fwpm_provider_context_type.md) value specifying the type of provider
    ///context..
    FWPM_PROVIDER_CONTEXT_TYPE type;
union
    {
        IPSEC_KEYING_POLICY0* keyingPolicy;
        IPSEC_TRANSPORT_POLICY0* ikeQmTransportPolicy;
        IPSEC_TUNNEL_POLICY0* ikeQmTunnelPolicy;
        IPSEC_TRANSPORT_POLICY0* authipQmTransportPolicy;
        IPSEC_TUNNEL_POLICY0* authipQmTunnelPolicy;
        IKEEXT_POLICY0* ikeMmPolicy;
        IKEEXT_POLICY0* authIpMmPolicy;
        FWP_BYTE_BLOB*  dataBuffer;
        FWPM_CLASSIFY_OPTIONS0* classifyOptions;
    }
    ///LUID identifying the context. This is the context value stored in the **FWPS_FILTER0** structure for filters that
    ///reference a provider context. The **FWPS_FILTER0** structure is documented in the WDK.
    ulong              providerContextId;
}

///The **FWPM_PROVIDER_CONTEXT1** structure stores the state associated with a provider context.
///[FWPM_PROVIDER_CONTEXT2](ns-fwpmtypes-fwpm_provider_context2.md) is available. For Windows Vista,
///[FWPM_PROVIDER_CONTEXT0](ns-fwpmtypes-fwpm_provider_context0.md) is available.
struct FWPM_PROVIDER_CONTEXT1
{
    ///Uniquely identifies the provider context. If the GUID is zero-initialized in the call to
    ///[FwpmProviderContextAdd1](../fwpmu/nf-fwpmu-fwpmprovidercontextadd1.md), Base Filtering Engine (BFE) will
    ///generate one.
    GUID               providerContextKey;
    ///Allows provider contexts to be annotated in a human-readable form. The
    ///[FWPM_DISPLAY_DATA0](../fwptypes/ns-fwptypes-fwpm_display_data0.md) structure is required.
    FWPM_DISPLAY_DATA0 displayData;
    ///Possible values: | Provider context flag | Meaning | | ----- | ------- | | FWPM_PROVIDER_CONTEXT_FLAG_PERSISTENT
    ///| The object is persistent, that is, it survives across BFE stop/start. |
    uint               flags;
    ///GUID of the policy provider that manages this object.
    GUID*              providerKey;
    ///An [FWP_BYTE_BLOB](../fwptypes/ns-fwptypes-fwp_byte_blob.md) structure that contains optional provider-specific
    ///data that allows providers to store additional context info with the object.
    FWP_BYTE_BLOB      providerData;
    ///A [FWPM_PROVIDER_CONTEXT_TYPE](ne-fwpmtypes-fwpm_provider_context_type.md) value specifying the type of provider
    ///context..
    FWPM_PROVIDER_CONTEXT_TYPE type;
union
    {
        IPSEC_KEYING_POLICY0* keyingPolicy;
        IPSEC_TRANSPORT_POLICY1* ikeQmTransportPolicy;
        IPSEC_TUNNEL_POLICY1* ikeQmTunnelPolicy;
        IPSEC_TRANSPORT_POLICY1* authipQmTransportPolicy;
        IPSEC_TUNNEL_POLICY1* authipQmTunnelPolicy;
        IKEEXT_POLICY1*      ikeMmPolicy;
        IKEEXT_POLICY1*      authIpMmPolicy;
        FWP_BYTE_BLOB*       dataBuffer;
        FWPM_CLASSIFY_OPTIONS0* classifyOptions;
        IPSEC_TUNNEL_POLICY1* ikeV2QmTunnelPolicy;
        IKEEXT_POLICY1*      ikeV2MmPolicy;
        IPSEC_DOSP_OPTIONS0* idpOptions;
    }
    ///LUID identifying the context. This is the context value stored in the **FWPS_FILTER1** structure for filters that
    ///reference a provider context. The **FWPS_FILTER1** structure is documented in the WDK.
    ulong              providerContextId;
}

///The **FWPM_PROVIDER_CONTEXT2** structure stores the state associated with a provider context.
///[FWPM_PROVIDER_CONTEXT0](ns-fwpmtypes-fwpm_provider_context0.md) is available.
struct FWPM_PROVIDER_CONTEXT2
{
    ///Type: **GUID** Uniquely identifies the provider context. If the GUID is zero-initialized in the call to
    ///[FwpmProviderContextAdd2](../fwpmu/nf-fwpmu-fwpmprovidercontextadd2.md), Base Filtering Engine (BFE) will
    ///generate one.
    GUID               providerContextKey;
    ///Type: **[FWPM_DISPLAY_DATA0](../fwptypes/ns-fwptypes-fwpm_display_data0.md)** Allows provider contexts to be
    ///annotated in a human-readable form. The [FWPM_DISPLAY_DATA0](../fwptypes/ns-fwptypes-fwpm_display_data0.md)
    ///structure is required.
    FWPM_DISPLAY_DATA0 displayData;
    ///Type: **UINT32** Possible values: | Provider context flag | Meaning | | ----- | ------- | |
    ///FWPM_PROVIDER_CONTEXT_FLAG_PERSISTENT | The object is persistent, that is, it survives across BFE stop/start. | |
    ///FWPM_PROVIDER_CONTEXT_FLAG_DOWNLEVEL | Reserved for internal use. |
    uint               flags;
    ///Type: **GUID*** GUID of the policy provider that manages this object.
    GUID*              providerKey;
    ///Type: **[FWP_BYTE_BLOB](../fwptypes/ns-fwptypes-fwp_byte_blob.md)** Optional provider-specific data that allows
    ///providers to store additional context info with the object.
    FWP_BYTE_BLOB      providerData;
    ///Type: **[FWPM_PROVIDER_CONTEXT_TYPE](ne-fwpmtypes-fwpm_provider_context_type.md)** The type of provider context.
    FWPM_PROVIDER_CONTEXT_TYPE type;
union
    {
        IPSEC_KEYING_POLICY1* keyingPolicy;
        IPSEC_TRANSPORT_POLICY2* ikeQmTransportPolicy;
        IPSEC_TUNNEL_POLICY2* ikeQmTunnelPolicy;
        IPSEC_TRANSPORT_POLICY2* authipQmTransportPolicy;
        IPSEC_TUNNEL_POLICY2* authipQmTunnelPolicy;
        IKEEXT_POLICY2*      ikeMmPolicy;
        IKEEXT_POLICY2*      authIpMmPolicy;
        FWP_BYTE_BLOB*       dataBuffer;
        FWPM_CLASSIFY_OPTIONS0* classifyOptions;
        IPSEC_TUNNEL_POLICY2* ikeV2QmTunnelPolicy;
        IPSEC_TRANSPORT_POLICY2* ikeV2QmTransportPolicy;
        IKEEXT_POLICY2*      ikeV2MmPolicy;
        IPSEC_DOSP_OPTIONS0* idpOptions;
    }
    ///Type: **UINT64** LUID identifying the context. This is the context value stored in the **FWPS_FILTER1** structure
    ///for filters that reference a provider context. The **FWPS_FILTER1** structure is documented in the WDK.
    ulong              providerContextId;
}

struct FWPM_PROVIDER_CONTEXT3_
{
    GUID               providerContextKey;
    FWPM_DISPLAY_DATA0 displayData;
    uint               flags;
    GUID*              providerKey;
    FWP_BYTE_BLOB      providerData;
    FWPM_PROVIDER_CONTEXT_TYPE type;
union
    {
        IPSEC_KEYING_POLICY1* keyingPolicy;
        IPSEC_TRANSPORT_POLICY2* ikeQmTransportPolicy;
        IPSEC_TUNNEL_POLICY3_* ikeQmTunnelPolicy;
        IPSEC_TRANSPORT_POLICY2* authipQmTransportPolicy;
        IPSEC_TUNNEL_POLICY3_* authipQmTunnelPolicy;
        IKEEXT_POLICY2*      ikeMmPolicy;
        IKEEXT_POLICY2*      authIpMmPolicy;
        FWP_BYTE_BLOB*       dataBuffer;
        FWPM_CLASSIFY_OPTIONS0* classifyOptions;
        IPSEC_TUNNEL_POLICY3_* ikeV2QmTunnelPolicy;
        IPSEC_TRANSPORT_POLICY2* ikeV2QmTransportPolicy;
        IKEEXT_POLICY2*      ikeV2MmPolicy;
        IPSEC_DOSP_OPTIONS0* idpOptions;
    }
    ulong              providerContextId;
}

///The <b>FWPM_PROVIDER_CONTEXT_ENUM_TEMPLATE0</b> structure is used for enumerating provider contexts.
struct FWPM_PROVIDER_CONTEXT_ENUM_TEMPLATE0
{
    ///Uniquely identifies a provider. If this value is non-NULL, only options with the specifies provider will be
    ///returned.
    GUID* providerKey;
    ///Only return provider contexts of the specified type. See
    ///[FWPM_PROVIDER_CONTEXT_TYPE](/windows/desktop/api/fwpmtypes/ne-fwpmtypes-fwpm_provider_context_type) for more
    ///information.
    FWPM_PROVIDER_CONTEXT_TYPE providerContextType;
}

///The <b>FWPM_PROVIDER_CONTEXT_CHANGE0</b> structure contains a change notification dispatched to subscribers.
struct FWPM_PROVIDER_CONTEXT_CHANGE0
{
    ///Type of change. See [FWPM_CHANGE_TYPE](/windows/desktop/api/fwpmtypes/ne-fwpmtypes-fwpm_change_type) for more
    ///information.
    FWPM_CHANGE_TYPE changeType;
    ///GUID of the provider context that changed.
    GUID             providerContextKey;
    ///LUID of the provider context that changed.
    ulong            providerContextId;
}

///The <b>FWPM_PROVIDER_CONTEXT_SUBSCRIPTION0</b> structure is used to subscribe for change notifications.
struct FWPM_PROVIDER_CONTEXT_SUBSCRIPTION0
{
    ///Notifications are only dispatched for objects that match the template. If the template is <b>NULL</b>, it matches
    ///all objects. See FWPM_PROVIDER_CONTEXT_ENUM_TEMPLATE0 for more information
    FWPM_PROVIDER_CONTEXT_ENUM_TEMPLATE0* enumTemplate;
    ///The notifications to subscribe to, as one of the following values. <table> <tr> <th>Subscription flag</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="FWPM_SUBSCRIPTION_FLAG_NOTIFY_ON_ADD"></a><a
    ///id="fwpm_subscription_flag_notify_on_add"></a><dl> <dt><b>FWPM_SUBSCRIPTION_FLAG_NOTIFY_ON_ADD</b></dt> </dl>
    ///</td> <td width="60%"> Subscribe to provider add notifications. </td> </tr> <tr> <td width="40%"><a
    ///id="FWPM_SUBSCRIPTION_FLAG_NOTIFY_ON_DELETE"></a><a id="fwpm_subscription_flag_notify_on_delete"></a><dl>
    ///<dt><b>FWPM_SUBSCRIPTION_FLAG_NOTIFY_ON_DELETE</b></dt> </dl> </td> <td width="60%"> Subscribe to provider delete
    ///notifications. </td> </tr> </table>
    uint flags;
    ///Uniquely identifies this session.
    GUID sessionKey;
}

///The <b>FWPM_SUBLAYER0</b> structure stores the state associated with a sublayer.
struct FWPM_SUBLAYER0
{
    ///Uniquely identifies the sublayer. See Filtering Sublayer Identifiers for a list of built-in sublayers. If the
    ///GUID is zero-initialized in the call to FwpmSubLayerAdd0, the Base Filtering Engine (BFE) will generate one.
    GUID               subLayerKey;
    ///Allows sublayers to be annotated in human-readable form. The
    ///[FWPM_DISPLAY_DATA0](/windows/desktop/api/fwptypes/ns-fwptypes-fwpm_display_data0) structure is required.
    FWPM_DISPLAY_DATA0 displayData;
    ///Possible values: <table> <tr> <th>Sublayer flag</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="FWPM_SUBLAYER_FLAG_PERSISTENT"></a><a id="fwpm_sublayer_flag_persistent"></a><dl>
    ///<dt><b>FWPM_SUBLAYER_FLAG_PERSISTENT</b></dt> </dl> </td> <td width="60%"> Causes sublayer to be persistent,
    ///surviving across BFE stop/start. </td> </tr> </table>
    uint               flags;
    ///Uniquely identifies the provider that manages this sublayer.
    GUID*              providerKey;
    ///An [FWP_BYTE_BLOB](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_byte_blob) structure that contains optional
    ///provider-specific data that allows providers to store additional context info with the object.
    FWP_BYTE_BLOB      providerData;
    ///Weight of the sublayer. Higher-weighted sublayers are invoked first.
    ushort             weight;
}

///The <b>FWPM_SUBLAYER_ENUM_TEMPLATE0</b> structure is used for enumerating sublayers.
struct FWPM_SUBLAYER_ENUM_TEMPLATE0
{
    ///Uniquely identifies the provider associated with this sublayer. If this value is non-NULL, only options with the
    ///specifies provider will be returned.
    GUID* providerKey;
}

///The <b>FWPM_SUBLAYER_CHANGE0</b> structure specifies a change notification dispatched to subscribers.
struct FWPM_SUBLAYER_CHANGE0
{
    ///Type of change as specified by [FWPM_CHANGE_TYPE](/windows/desktop/api/fwpmtypes/ne-fwpmtypes-fwpm_change_type).
    FWPM_CHANGE_TYPE changeType;
    ///GUID of the sublayer that changed.
    GUID             subLayerKey;
}

///The <b>FWPM_SUBLAYER_SUBSCRIPTION0</b> structure is used to subscribe for change notifications.
struct FWPM_SUBLAYER_SUBSCRIPTION0
{
    ///Enumeration template for limiting the subscription. See
    ///[FWPM_SUBLAYER_ENUM_TEMPLATE0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_sublayer_enum_template0) for more
    ///information.
    FWPM_SUBLAYER_ENUM_TEMPLATE0* enumTemplate;
    ///A combination of the following values. <table> <tr> <th>Subscription flag</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="FWPM_SUBSCRIPTION_FLAG_NOTIFY_ON_ADD"></a><a
    ///id="fwpm_subscription_flag_notify_on_add"></a><dl> <dt><b>FWPM_SUBSCRIPTION_FLAG_NOTIFY_ON_ADD</b></dt> </dl>
    ///</td> <td width="60%"> Subscribe to sublayer add notifications. </td> </tr> <tr> <td width="40%"><a
    ///id="FWPM_SUBSCRIPTION_FLAG_NOTIFY_ON_DELETE"></a><a id="fwpm_subscription_flag_notify_on_delete"></a><dl>
    ///<dt><b>FWPM_SUBSCRIPTION_FLAG_NOTIFY_ON_DELETE</b></dt> </dl> </td> <td width="60%"> Subscribe to sublayer delete
    ///notifications. </td> </tr> </table>
    uint flags;
    ///Uniquely identifies this session.
    GUID sessionKey;
}

///The <b>FWPM_FIELD0</b> structure specifies schema information for a field.
struct FWPM_FIELD0
{
    ///Uniquely identifies the field. See FWPM_CONDITION_* identifiers in the topic Filtering Condition Identifiers.
    GUID*           fieldKey;
    ///Determines how <b>dataType</b> is interpreted. See
    ///[FWPM_FIELD_TYPE](/windows/desktop/api/fwpmtypes/ne-fwpmtypes-fwpm_field_type) for more information.
    FWPM_FIELD_TYPE type;
    ///Data type passed to classify. See [FWP_DATA_TYPE](/windows/desktop/api/fwptypes/ne-fwptypes-fwp_data_type) for
    ///more information.
    FWP_DATA_TYPE   dataType;
}

///The <b>FWPM_LAYER0</b> structure contains schema information for a layer.
struct FWPM_LAYER0
{
    ///Uniquely identifies the layer.
    GUID               layerKey;
    ///Allows layers to be annotated in a human-readable form. The
    ///[FWPM_DISPLAY_DATA0](/windows/desktop/api/fwptypes/ns-fwptypes-fwpm_display_data0) structure is not <b>NULL</b>.
    FWPM_DISPLAY_DATA0 displayData;
    ///Possible values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="FWPM_LAYER_FLAG_KERNEL"></a><a id="fwpm_layer_flag_kernel"></a><dl> <dt><b>FWPM_LAYER_FLAG_KERNEL</b></dt>
    ///</dl> </td> <td width="60%"> Layer classified in kernel-mode. </td> </tr> <tr> <td width="40%"><a
    ///id="FWPM_LAYER_FLAG_BUILTIN"></a><a id="fwpm_layer_flag_builtin"></a><dl> <dt><b>FWPM_LAYER_FLAG_BUILTIN</b></dt>
    ///</dl> </td> <td width="60%"> Layer built-in. Cannot be deleted. </td> </tr> <tr> <td width="40%"><a
    ///id="FWPM_LAYER_FLAG_CLASSIFY_MOSTLY"></a><a id="fwpm_layer_flag_classify_mostly"></a><dl>
    ///<dt><b>FWPM_LAYER_FLAG_CLASSIFY_MOSTLY</b></dt> </dl> </td> <td width="60%"> Layer optimized for classification
    ///rather than enumeration. </td> </tr> <tr> <td width="40%"><a id="FWPM_LAYER_FLAG_BUFFERED"></a><a
    ///id="fwpm_layer_flag_buffered"></a><dl> <dt><b>FWPM_LAYER_FLAG_BUFFERED</b></dt> </dl> </td> <td width="60%">
    ///Layer is buffered. </td> </tr> </table>
    uint               flags;
    ///Number of fields in the layer.
    uint               numFields;
    ///Schema information for the layer's fields. See
    ///[FWPM_FIELD0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_field0) for more information.
    FWPM_FIELD0*       field;
    ///Sublayer used when a filter is added with a null sublayer.
    GUID               defaultSubLayerKey;
    ///LUID that identifies this layer.
    ushort             layerId;
}

///The <b>FWPM_LAYER_ENUM_TEMPLATE0</b> structure is used for enumerating layers.
struct FWPM_LAYER_ENUM_TEMPLATE0
{
    ///Reserved for system use.
    ulong reserved;
}

///The <b>FWPM_CALLOUT0</b> structure stores the state associated with a callout.
struct FWPM_CALLOUT0
{
    ///Uniquely identifies the session. If the GUID is initialized to zero in the call to FwpmCalloutAdd0, the base
    ///filtering engine (BFE) will generate one.
    GUID               calloutKey;
    ///A [FWPM_DISPLAY_DATA0](/windows/desktop/api/fwptypes/ns-fwptypes-fwpm_display_data0) structure that contains
    ///human-readable annotations associated with the callout. The <b>name</b> member of the <b>FWPM_DISPLAY_DATA0</b>
    ///structure is required.
    FWPM_DISPLAY_DATA0 displayData;
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="FWPM_CALLOUT_FLAG_PERSISTENT"></a><a id="fwpm_callout_flag_persistent"></a><dl>
    ///<dt><b>FWPM_CALLOUT_FLAG_PERSISTENT</b></dt> </dl> </td> <td width="60%"> The callout is persistent across
    ///reboots. As a result, it can be referenced by boot-time and other persistent filters. </td> </tr> <tr> <td
    ///width="40%"><a id="FWPM_CALLOUT_FLAG_USES_PROVIDER_CONTEXT"></a><a
    ///id="fwpm_callout_flag_uses_provider_context"></a><dl> <dt><b>FWPM_CALLOUT_FLAG_USES_PROVIDER_CONTEXT</b></dt>
    ///</dl> </td> <td width="60%"> The callout needs access to the provider context stored in the filter invoking the
    ///callout. If this flag is set, the provider context will be copied from the
    ///[FWPM_FILTER0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_filter0) structure to the <b>FWPS_FILTER0</b>
    ///structure. The <b>FWPS_FILTER0</b> structure is documented in the WDK. </td> </tr> <tr> <td width="40%"><a
    ///id="FWPM_CALLOUT_FLAG_REGISTERED"></a><a id="fwpm_callout_flag_registered"></a><dl>
    ///<dt><b>FWPM_CALLOUT_FLAG_REGISTERED</b></dt> </dl> </td> <td width="60%"> The callout is currently registered in
    ///the kernel. This flag must not be set when adding new callouts. It is used only in querying the state of existing
    ///callouts. </td> </tr> </table>
    uint               flags;
    ///Uniquely identifies the provider associated with the callout. If the member is non-NULL, only objects associated
    ///with the specified provider will be returned.
    GUID*              providerKey;
    ///A [FWP_BYTE_BLOB](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_byte_blob) structure that contains optional
    ///provider-specific data that allows providers to store additional context information with the object.
    FWP_BYTE_BLOB      providerData;
    ///Specifies the layer in which the callout can be used. Only filters in this layer can invoke the callout. For more
    ///information, see Filtering Layer Identifiers.
    GUID               applicableLayer;
    ///LUID identifying the callout. This is the <b>calloutId</b> stored in the <b>FWPS_ACTION0</b> structure for
    ///filters that invoke a callout. The <b>FWPS_ACTION0</b> structure is documented in the WDK.
    uint               calloutId;
}

///The <b>FWPM_CALLOUT_ENUM_TEMPLATE0</b> structure is used for limiting callout enumerations.
struct FWPM_CALLOUT_ENUM_TEMPLATE0
{
    ///Uniquely identifies the provider associated with the callout. If this member is non-NULL, only objects associated
    ///with the specified provider will be returned.
    GUID* providerKey;
    ///Uniquely identifies a layer. If this member is non-NULL, only callouts associated with the specified layer will
    ///be returned.
    GUID  layerKey;
}

///The <b>FWPM_CALLOUT_CHANGE0</b> structure specifies a change notification dispatched to subscribers.
struct FWPM_CALLOUT_CHANGE0
{
    ///A [FWPM_CHANGE_TYPE](/windows/desktop/api/fwpmtypes/ne-fwpmtypes-fwpm_change_type) value that specifies the type
    ///of change.
    FWPM_CHANGE_TYPE changeType;
    ///GUID of the callout that changed.
    GUID             calloutKey;
    ///LUID of the callout that changed.
    uint             calloutId;
}

///The <b>FWPM_CALLOUT_SUBSCRIPTION0</b> structure is used to subscribe for change notifications.
struct FWPM_CALLOUT_SUBSCRIPTION0
{
    ///A [FWPM_CALLOUT_ENUM_TEMPLATE0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_callout_enum_template0)
    ///structure that is used to limit the subscription.
    FWPM_CALLOUT_ENUM_TEMPLATE0* enumTemplate;
    ///The notification type(s) received by the subscription. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td width="40%"><a id="FWPM_SUBSCRIPTION_FLAG_NOTIFY_ON_ADD"></a><a
    ///id="fwpm_subscription_flag_notify_on_add"></a><dl> <dt><b>FWPM_SUBSCRIPTION_FLAG_NOTIFY_ON_ADD</b></dt> </dl>
    ///</td> <td width="60%"> Subscribe to callout add notifications. </td> </tr> <tr> <td width="40%"><a
    ///id="FWPM_SUBSCRIPTION_FLAG_NOTIFY_ON_DELETE"></a><a id="fwpm_subscription_flag_notify_on_delete"></a><dl>
    ///<dt><b>FWPM_SUBSCRIPTION_FLAG_NOTIFY_ON_DELETE</b></dt> </dl> </td> <td width="60%"> Subscribe to callout delete
    ///notifications. </td> </tr> </table>
    uint flags;
    ///Uniquely identifies this session.
    GUID sessionKey;
}

///The <b>FWPM_ACTION0</b> structure specifies the action taken if all the filter conditions are true.
struct FWPM_ACTION0
{
    ///Action type as specified by <b>FWP_ACTION_TYPE</b> which maps to a <b>UINT32</b>. Possible values: <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="FWP_ACTION_BLOCK"></a><a
    ///id="fwp_action_block"></a><dl> <dt><b>FWP_ACTION_BLOCK</b></dt> </dl> </td> <td width="60%"> Block the traffic.
    ///0x00000001 | FWP_ACTION_FLAG_TERMINATING </td> </tr> <tr> <td width="40%"><a id="FWP_ACTION_PERMIT"></a><a
    ///id="fwp_action_permit"></a><dl> <dt><b>FWP_ACTION_PERMIT</b></dt> </dl> </td> <td width="60%"> Permit the
    ///traffic. 0x00000002 | FWP_ACTION_FLAG_TERMINATING </td> </tr> <tr> <td width="40%"><a
    ///id="FWP_ACTION_CALLOUT_TERMINATING"></a><a id="fwp_action_callout_terminating"></a><dl>
    ///<dt><b>FWP_ACTION_CALLOUT_TERMINATING</b></dt> </dl> </td> <td width="60%"> Invoke a callout that always returns
    ///block or permit. 0x00000003 | FWP_ACTION_FLAG_CALLOUT | FWP_ACTION_FLAG_TERMINATING </td> </tr> <tr> <td
    ///width="40%"><a id="FWP_ACTION_CALLOUT_INSPECTION"></a><a id="fwp_action_callout_inspection"></a><dl>
    ///<dt><b>FWP_ACTION_CALLOUT_INSPECTION</b></dt> </dl> </td> <td width="60%"> Invoke a callout that never returns
    ///block or permit. 0x00000004 | FWP_ACTION_FLAG_CALLOUT | FWP_ACTION_FLAG_NON_TERMINATING </td> </tr> <tr> <td
    ///width="40%"><a id="FWP_ACTION_CALLOUT_UNKNOWN"></a><a id="fwp_action_callout_unknown"></a><dl>
    ///<dt><b>FWP_ACTION_CALLOUT_UNKNOWN</b></dt> </dl> </td> <td width="60%"> Invoke a callout that may return block or
    ///permit. 0x00000005 | FWP_ACTION_FLAG_CALLOUT </td> </tr> </table>
    uint type;
union
    {
        GUID  filterType;
        GUID  calloutKey;
        ubyte bitmapIndex;
    }
}

///The <b>FWPM_FILTER_CONDITION0</b> structure expresses a filter condition that must be true for the action to be
///taken.
struct FWPM_FILTER_CONDITION0
{
    ///GUID of the field to be tested.
    GUID                 fieldKey;
    ///A [FWP_MATCH_TYPE](/windows/desktop/api/fwptypes/ne-fwptypes-fwp_match_type) value that specifies the type of
    ///match to be performed.
    FWP_MATCH_TYPE       matchType;
    ///A [FWP_CONDITION_VALUE0](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_condition_value0) structure that contains
    ///the value to match the field against.
    FWP_CONDITION_VALUE0 conditionValue;
}

///The <b>FWPM_FILTER0</b> structure stores the state associated with a filter.
struct FWPM_FILTER0
{
    ///Uniquely identifies the session. If the GUID is initialized to zero in the call to FwpmFilterAdd0, the Base
    ///Filtering Engine (BFE) will generate one.
    GUID               filterKey;
    ///A [FWPM_DISPLAY_DATA0](/windows/desktop/api/fwptypes/ns-fwptypes-fwpm_display_data0) structure that contains
    ///human-readable annotations associated with the filter. The <b>name</b> member of the <b>FWPM_DISPLAY_DATA0</b>
    ///structure is required.
    FWPM_DISPLAY_DATA0 displayData;
    ///A combination of the following values. <table> <tr> <th>Filter flag</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="FWPM_FILTER_FLAG_NONE"></a><a id="fwpm_filter_flag_none"></a><dl>
    ///<dt><b>FWPM_FILTER_FLAG_NONE</b></dt> </dl> </td> <td width="60%"> Default. </td> </tr> <tr> <td width="40%"><a
    ///id="FWPM_FILTER_FLAG_PERSISTENT"></a><a id="fwpm_filter_flag_persistent"></a><dl>
    ///<dt><b>FWPM_FILTER_FLAG_PERSISTENT</b></dt> </dl> </td> <td width="60%"> Filter is persistent, that is, it
    ///survives across BFE stop/start. <div class="alert"><b>Note</b> This flag cannot be set together with
    ///<b>FWPM_FILTER_FLAG_BOOTTIME</b>.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
    ///id="FWPM_FILTER_FLAG_BOOTTIME"></a><a id="fwpm_filter_flag_boottime"></a><dl>
    ///<dt><b>FWPM_FILTER_FLAG_BOOTTIME</b></dt> </dl> </td> <td width="60%"> Filter is enforced at boot-time, even
    ///before BFE starts. <div class="alert"><b>Note</b> This flag cannot be set together with
    ///<b>FWPM_FILTER_FLAG_PERSISTENT</b>.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
    ///id="FWPM_FILTER_FLAG_HAS_PROVIDER_CONTEXT"></a><a id="fwpm_filter_flag_has_provider_context"></a><dl>
    ///<dt><b>FWPM_FILTER_FLAG_HAS_PROVIDER_CONTEXT</b></dt> </dl> </td> <td width="60%"> Filter references a provider
    ///context. </td> </tr> <tr> <td width="40%"><a id="FWPM_FILTER_FLAG_CLEAR_ACTION_RIGHT"></a><a
    ///id="fwpm_filter_flag_clear_action_right"></a><dl> <dt><b>FWPM_FILTER_FLAG_CLEAR_ACTION_RIGHT</b></dt> </dl> </td>
    ///<td width="60%"> Clear filter action right. </td> </tr> <tr> <td width="40%"><a
    ///id="FWPM_FILTER_FLAG_PERMIT_IF_CALLOUT_UNREGISTERED"></a><a
    ///id="fwpm_filter_flag_permit_if_callout_unregistered"></a><dl>
    ///<dt><b>FWPM_FILTER_FLAG_PERMIT_IF_CALLOUT_UNREGISTERED</b></dt> </dl> </td> <td width="60%"> If the callout is
    ///not registered, the filter is treated as a permit filter. <div class="alert"><b>Note</b> This flag can be set
    ///only if the <b>action</b> type is <b>FWP_ACTION_CALLOUT_TERMINATING</b> or
    ///<b>FWP_ACTION_CALLOUT_UNKNOWN</b>.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
    ///id="FWPM_FILTER_FLAG_DISABLED"></a><a id="fwpm_filter_flag_disabled"></a><dl>
    ///<dt><b>FWPM_FILTER_FLAG_DISABLED</b></dt> </dl> </td> <td width="60%"> Filter is disabled. A provider's filters
    ///are disabled when the BFE starts if the provider has no associated Windows service name, or if the associated
    ///service is not set to auto-start. <div class="alert"><b>Note</b> This flag cannot be set when adding new filters.
    ///It can only be returned by BFE when getting or enumerating filters.</div> <div> </div> </td> </tr> <tr> <td
    ///width="40%"><a id="FWPM_FILTER_FLAG_INDEXED"></a><a id="fwpm_filter_flag_indexed"></a><dl>
    ///<dt><b>FWPM_FILTER_FLAG_INDEXED</b></dt> </dl> </td> <td width="60%"> Filter is indexed to help enable faster
    ///lookup during classification. <div class="alert"><b>Note</b> Available only in Windows 8 and Windows Server
    ///2012.</div> <div> </div> </td> </tr> </table>
    uint               flags;
    ///Optional GUID of the policy provider that manages this filter. See Built-in Provider Identifiers for a list of
    ///predefined policy providers.
    GUID*              providerKey;
    ///A [FWP_BYTE_BLOB](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_byte_blob) structure that contains optional
    ///provider-specific data used by providers to store additional context information with the object.
    FWP_BYTE_BLOB      providerData;
    ///GUID of the layer where the filter resides. See Filtering Layer Identifiers for a list of possible values.
    GUID               layerKey;
    ///GUID of the sub-layer where the filter resides. See Filtering Sub-Layer Identifiers for a list of built-in
    ///sub-layers. If this is set to IID_NULL, the filter is added to the default sublayer.
    GUID               subLayerKey;
    ///A [FWP_VALUE0](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_value0) structure that specifies the weight of the
    ///filter. Possible type values for <b>weight</b> are as follows. <table> <tr> <th><b>weight</b> type</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="FWP_UINT64"></a><a id="fwp_uint64"></a><dl>
    ///<dt><b>FWP_UINT64</b></dt> </dl> </td> <td width="60%"> BFE will use the supplied value as the filter's weight.
    ///</td> </tr> <tr> <td width="40%"><a id="FWP_UINT8"></a><a id="fwp_uint8"></a><dl> <dt><b>FWP_UINT8</b></dt>
    ///<dt>0–15</dt> </dl> </td> <td width="60%"> BFE will use the supplied value as a weight range index and will
    ///compute the filter's weight in that range. See Filter Weight Assignment for more information. </td> </tr> <tr>
    ///<td width="40%"><a id="FWP_EMPTY"></a><a id="fwp_empty"></a><dl> <dt><b>FWP_EMPTY</b></dt> </dl> </td> <td
    ///width="60%"> BFE will automatically assign a weight based on the filter conditions. </td> </tr> </table> See
    ///Filter Weight Identifiers for built-in constants that may be used to compute the filter weight.
    FWP_VALUE0         weight;
    ///Number of filter conditions.
    uint               numFilterConditions;
    ///Array of [FWPM_FILTER_CONDITION0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_filter_condition0) structures
    ///that contain all the filtering conditions. All must be true for the action to be performed. In other words, the
    ///conditions are evaluated using the AND operator. If no conditions are specified, the action is always performed.
    ///<div class="alert"><b>Note</b> In Windows 7 and Windows Server 2008 R2, consecutive conditions with the same
    ///fieldKey will be evaluated using the OR operator. </div> <div> </div>
    FWPM_FILTER_CONDITION0* filterCondition;
    ///A [FWPM_ACTION0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_action0) structure that specifies the action to
    ///be performed if all the filter conditions are true.
    FWPM_ACTION0       action;
union
    {
        ulong rawContext;
        GUID  providerContextKey;
    }
    ///Reserved for system use.
    GUID*              reserved;
    ///LUID identifying the filter. This is also the LUID of the corresponding <b>FWPS_FILTER0</b> structure, which is
    ///documented in the WDK.
    ulong              filterId;
    ///An [FWP_VALUE0](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_value0) structure that contains the weight assigned
    ///to <b>FWPS_FILTER0</b>, which is documented in the WDK.
    FWP_VALUE0         effectiveWeight;
}

///The <b>FWPM_FILTER_ENUM_TEMPLATE0</b> structure is used for enumerating filters.
struct FWPM_FILTER_ENUM_TEMPLATE0
{
    ///Uniquely identifies the provider associated with this filter.
    GUID*                providerKey;
    ///Layer whose fields are to be enumerated.
    GUID                 layerKey;
    ///A [FWP_FILTER_ENUM_TYPE](/windows/desktop/api/fwptypes/ne-fwptypes-fwp_filter_enum_type) value that determines
    ///how the filter conditions are interpreted.
    FWP_FILTER_ENUM_TYPE enumType;
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="FWP_FILTER_ENUM_FLAG_BEST_TERMINATING_MATCH_"></a><a
    ///id="fwp_filter_enum_flag_best_terminating_match_"></a><dl> <dt><b>FWP_FILTER_ENUM_FLAG_BEST_TERMINATING_MATCH
    ///</b></dt> </dl> </td> <td width="60%"> Only return the terminating filter with the highest weight. </td> </tr>
    ///<tr> <td width="40%"><a id="FWP_FILTER_ENUM_FLAG_SORTED"></a><a id="fwp_filter_enum_flag_sorted"></a><dl>
    ///<dt><b>FWP_FILTER_ENUM_FLAG_SORTED</b></dt> </dl> </td> <td width="60%"> Return all matching filters sorted by
    ///weight (highest to lowest). </td> </tr> <tr> <td width="40%"><a id="FWP_FILTER_ENUM_FLAG_BOOTTIME_ONLY"></a><a
    ///id="fwp_filter_enum_flag_boottime_only"></a><dl> <dt><b>FWP_FILTER_ENUM_FLAG_BOOTTIME_ONLY</b></dt> </dl> </td>
    ///<td width="60%"> Return only boot-time filters. </td> </tr> <tr> <td width="40%"><a
    ///id="FWP_FILTER_ENUM_FLAG_INCLUDE_BOOTTIME"></a><a id="fwp_filter_enum_flag_include_boottime"></a><dl>
    ///<dt><b>FWP_FILTER_ENUM_FLAG_INCLUDE_BOOTTIME</b></dt> </dl> </td> <td width="60%"> Include boot-time filters;
    ///ignored if the <b>FWP_FILTER_ENUM_FLAG_BOOTTIME_ONLY</b> flag is set. </td> </tr> <tr> <td width="40%"><a
    ///id="FWP_FILTER_ENUM_FLAG_INCLUDE_DISABLED"></a><a id="fwp_filter_enum_flag_include_disabled"></a><dl>
    ///<dt><b>FWP_FILTER_ENUM_FLAG_INCLUDE_DISABLED</b></dt> </dl> </td> <td width="60%"> Include disabled filters;
    ///ignored if the <b>FWP_FILTER_ENUM_FLAG_BOOTTIME_ONLY</b> flag is set. </td> </tr> </table>
    uint                 flags;
    ///A FWPM_PROVIDER_CONTEXT_ENUM_TEMPLATE0 structure that is used to limit the number of filters enumerated. If
    ///non-<b>NULL</b>, only enumerate filters whose provider context matches the template.
    FWPM_PROVIDER_CONTEXT_ENUM_TEMPLATE0* providerContextTemplate;
    ///Number of filter conditions. If zero, then all filters match.
    uint                 numFilterConditions;
    ///An array of [FWPM_FILTER_CONDITION0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_filter_condition0)
    ///structures that contain distinct filter conditions (duplicated filter conditions will generate an error).
    FWPM_FILTER_CONDITION0* filterCondition;
    ///Only filters whose action type contains at least one of the bits in <b>actionMask</b> will be returned. <table>
    ///<tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0xFFFFFFFF</dt> </dl> </td> <td
    ///width="60%"> Ignore the filter's action type when enumerating. </td> </tr> <tr> <td width="40%"><a
    ///id="FWP_ACTION_FLAG_CALLOUT"></a><a id="fwp_action_flag_callout"></a><dl> <dt><b>FWP_ACTION_FLAG_CALLOUT</b></dt>
    ///</dl> </td> <td width="60%"> Enumerate callouts only. <div class="alert"><b>Note</b> <b>calloutKey</b> must not
    ///be <b>NULL</b>.</div> <div> </div> </td> </tr> </table>
    uint                 actionMask;
    ///Uniquely identifies the callout.
    GUID*                calloutKey;
}

///The <b>FWPM_FILTER_CHANGE0</b> structure stores change notification dispatched to subscribers.
struct FWPM_FILTER_CHANGE0
{
    ///A [FWPM_CHANGE_TYPE](/windows/desktop/api/fwpmtypes/ne-fwpmtypes-fwpm_change_type) value that specifies the type
    ///of change notification to be dispatched.
    FWPM_CHANGE_TYPE changeType;
    ///GUID of the filter that changed.
    GUID             filterKey;
    ///LUID of the filter that changed.
    ulong            filterId;
}

///The <b>FWPM_FILTER_SUBSCRIPTION0</b> structure is used to subscribe for change notifications.
struct FWPM_FILTER_SUBSCRIPTION0
{
    ///A [FWPM_FILTER_ENUM_TEMPLATE0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_filter_enum_template0) structure
    ///used to limit the subscription.
    FWPM_FILTER_ENUM_TEMPLATE0* enumTemplate;
    ///The notification type(s) received by the subscription. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td width="40%"><a id="FWPM_SUBSCRIPTION_FLAG_NOTIFY_ON_ADD"></a><a
    ///id="fwpm_subscription_flag_notify_on_add"></a><dl> <dt><b>FWPM_SUBSCRIPTION_FLAG_NOTIFY_ON_ADD</b></dt> </dl>
    ///</td> <td width="60%"> Subscribe to filter add notifications. </td> </tr> <tr> <td width="40%"><a
    ///id="FWPM_SUBSCRIPTION_FLAG_NOTIFY_ON_DELETE"></a><a id="fwpm_subscription_flag_notify_on_delete"></a><dl>
    ///<dt><b>FWPM_SUBSCRIPTION_FLAG_NOTIFY_ON_DELETE</b></dt> </dl> </td> <td width="60%"> Subscribe to filter delete
    ///notifications. </td> </tr> </table>
    uint flags;
    ///Uniquely identifies this session.
    GUID sessionKey;
}

///The <b>FWPM_LAYER_STATISTICS0</b> structure stores statistics related to a layer.
struct FWPM_LAYER_STATISTICS0
{
    ///Type: <b>GUID</b> Identifier of the layer.
    GUID layerId;
    ///Type: <b>UINT32</b> Number of permitted connections.
    uint classifyPermitCount;
    ///Type: <b>UINT32</b> Number of blocked connections.
    uint classifyBlockCount;
    ///Type: <b>UINT32</b> Number of vetoed connections.
    uint classifyVetoCount;
    ///Type: <b>UINT32</b>
    uint numCacheEntries;
}

///The <b>FWPM_STATISTICS0</b> structure stores statistics related to connections at specific layers.
struct FWPM_STATISTICS0
{
    ///Type: <b>UINT32</b> Number of
    ///[FWPM_LAYER_STATISTICS0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_layer_statistics0) structures in the
    ///<b>layerStatistics</b> member.
    uint  numLayerStatistics;
    ///Type: [FWPM_LAYER_STATISTICS0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_layer_statistics0)*</b>
    ///Statistics related to the layer.
    FWPM_LAYER_STATISTICS0* layerStatistics;
    ///Type: <b>UINT32</b> Number of allowed IPv4 inbound connections.
    uint  inboundAllowedConnectionsV4;
    ///Type: <b>UINT32</b> Number of blocked IPv4 inbound connections.
    uint  inboundBlockedConnectionsV4;
    ///Type: <b>UINT32</b> Number of allowed IPv4 outbound connections.
    uint  outboundAllowedConnectionsV4;
    ///Type: <b>UINT32</b> Number of blocked IPv4 outbound connections.
    uint  outboundBlockedConnectionsV4;
    ///Type: <b>UINT32</b> Number of allowed IPv6 inbound connections.
    uint  inboundAllowedConnectionsV6;
    ///Type: <b>UINT32</b> Number of blocked IPv6 inbound connections.
    uint  inboundBlockedConnectionsV6;
    ///Type: <b>UINT32</b> Number of allowed IPv6 outbound connections.
    uint  outboundAllowedConnectionsV6;
    ///Type: <b>UINT32</b> Number of blocked IPv6 outbound connections.
    uint  outboundBlockedConnectionsV6;
    ///Type: <b>UINT32</b> Number of active IPv4 inbound connections.
    uint  inboundActiveConnectionsV4;
    ///Type: <b>UINT32</b> Number of active IPv4 outbound connections.
    uint  outboundActiveConnectionsV4;
    ///Type: <b>UINT32</b> Number of active IPv6 inbound connections.
    uint  inboundActiveConnectionsV6;
    ///Type: <b>UINT32</b> Number of active IPv6 outbound connections.
    uint  outboundActiveConnectionsV6;
    ulong reauthDirInbound;
    ulong reauthDirOutbound;
    ulong reauthFamilyV4;
    ulong reauthFamilyV6;
    ulong reauthProtoOther;
    ulong reauthProtoIPv4;
    ulong reauthProtoIPv6;
    ulong reauthProtoICMP;
    ulong reauthProtoICMP6;
    ulong reauthProtoUDP;
    ulong reauthProtoTCP;
    ulong reauthReasonPolicyChange;
    ulong reauthReasonNewArrivalInterface;
    ulong reauthReasonNewNextHopInterface;
    ulong reauthReasonProfileCrossing;
    ulong reauthReasonClassifyCompletion;
    ulong reauthReasonIPSecPropertiesChanged;
    ulong reauthReasonMidStreamInspection;
    ulong reauthReasonSocketPropertyChanged;
    ulong reauthReasonNewInboundMCastBCastPacket;
    ulong reauthReasonEDPPolicyChanged;
    ulong reauthReasonPreclassifyLocalAddrLayerChange;
    ulong reauthReasonPreclassifyRemoteAddrLayerChange;
    ulong reauthReasonPreclassifyLocalPortLayerChange;
    ulong reauthReasonPreclassifyRemotePortLayerChange;
    ulong reauthReasonProxyHandleChanged;
}

///The **FWPM_NET_EVENT_HEADER0** structure contains information common to all events.
///[FWPM_NET_EVENT_HEADER2](ns-fwpmtypes-fwpm_net_event_header2.md) is available.
struct FWPM_NET_EVENT_HEADER0
{
    ///A [FILETIME](../minwinbase/ns-minwinbase-filetime.md) structure that specifies the time the event occurred
    FILETIME       timeStamp;
    ///Flags indicating which of the following members are set. Unused fields must be zero-initialized. | Net event flag
    ///| Meaning | | -------------- | ------- | | FWPM_NET_EVENT_FLAG_IP_PROTOCOL_SET | The **ipProtocol** member is
    ///set. | | FWPM_NET_EVENT_FLAG_LOCAL_ADDR_SET | Either the **localAddrV4** member or the **localAddrV6** member is
    ///set. If this flag is present, **FWPM_NET_EVENT_FLAG_IP_VERSION_SET** must also be present. | |
    ///FWPM_NET_EVENT_FLAG_REMOTE_ADDR_SET | Either the **remoteAddrV4** member of the **remoteAddrV6** field is set. If
    ///this flag is present, **FWPM_NET_EVENT_FLAG_IP_VERSION_SET** must also be present. | |
    ///FWPM_NET_EVENT_FLAG_LOCAL_PORT_SET | The **localPort** member is set. | | FWPM_NET_EVENT_FLAG_REMOTE_PORT_SET |
    ///The **remotePort** member is set. | | FWPM_NET_EVENT_FLAG_APP_ID_SET | The **appId** member is set. | |
    ///FWPM_NET_EVENT_FLAG_USER_ID_SET | The **userId** member is set. | | FWPM_NET_EVENT_FLAG_SCOPE_ID_SET | The
    ///**scopeId** member is set. | | FWPM_NET_EVENT_FLAG_IP_VERSION_SET | The **ipVersion** member is set. |
    uint           flags;
    ///A [FWP_IP_VERSION](../fwptypes/ne-fwptypes-fwp_ip_version.md) value that specifies the IP version being used.
    FWP_IP_VERSION ipVersion;
    ///IP protocol specified as an IPPROTO value. See the [socket](/windows/desktop/api/winsock2/nf-winsock2-socket)
    ///reference topic for more information on possible protocol values.
    ubyte          ipProtocol;
union
    {
        uint             localAddrV4;
        FWP_BYTE_ARRAY16 localAddrV6;
    }
union
    {
        uint             remoteAddrV4;
        FWP_BYTE_ARRAY16 remoteAddrV6;
    }
    ///Specifies a local port.
    ushort         localPort;
    ///Specifies a remote port.
    ushort         remotePort;
    ///IPv6 scope ID.
    uint           scopeId;
    ///A [FWP_BYTE_BLOB](../fwptypes/ns-fwptypes-fwp_byte_blob.md) that contains the application ID of the local
    ///application associated with the event.
    FWP_BYTE_BLOB  appId;
    ///Contains a user ID that corresponds to the traffic.
    SID*           userId;
}

///The **FWPM_NET_EVENT_HEADER1** structure contains information common to all events. Reserved.
///[FWPM_NET_EVENT_HEADER2](ns-fwpmtypes-fwpm_net_event_header2.md) is available.
struct FWPM_NET_EVENT_HEADER1
{
    ///A [FILETIME](../minwinbase/ns-minwinbase-filetime.md) structure that specifies the time the event occurred.
    FILETIME       timeStamp;
    ///Flags indicating which of the following members are set. Unused fields must be zero-initialized. | Net event flag
    ///| Meaning | | -------------- | ------- | | FWPM_NET_EVENT_FLAG_IP_PROTOCOL_SET | The **ipProtocol** member is
    ///set. | | FWPM_NET_EVENT_FLAG_LOCAL_ADDR_SET | Either the **localAddrV4** member or the **localAddrV6** member is
    ///set. If this flag is present, **FWPM_NET_EVENT_FLAG_IP_VERSION_SET** must also be present. | |
    ///FWPM_NET_EVENT_FLAG_REMOTE_ADDR_SET | Either the **remoteAddrV4** member of the **remoteAddrV6** field is set. If
    ///this flag is present, **FWPM_NET_EVENT_FLAG_IP_VERSION_SET** must also be present. | |
    ///FWPM_NET_EVENT_FLAG_LOCAL_PORT_SET | The **localPort** member is set. | | FWPM_NET_EVENT_FLAG_REMOTE_PORT_SET |
    ///The **remotePort** member is set. | | FWPM_NET_EVENT_FLAG_APP_ID_SET | The **appId** member is set. | |
    ///FWPM_NET_EVENT_FLAG_USER_ID_SET | The **userId** member is set. | | FWPM_NET_EVENT_FLAG_SCOPE_ID_SET | The
    ///**scopeId** member is set. | | FWPM_NET_EVENT_FLAG_IP_VERSION_SET | The **ipVersion** member is set. |
    uint           flags;
    ///An [FWP_IP_VERSION](../fwptypes/ne-fwptypes-fwp_ip_version.md) value that specifies the IP version being used.
    FWP_IP_VERSION ipVersion;
    ///IP protocol specified as an IPPROTO value. See the [socket](../winsock2/nf-winsock2-socket.md) reference topic
    ///for more information on possible protocol values.
    ubyte          ipProtocol;
union
    {
        uint             localAddrV4;
        FWP_BYTE_ARRAY16 localAddrV6;
    }
union
    {
        uint             remoteAddrV4;
        FWP_BYTE_ARRAY16 remoteAddrV6;
    }
    ///Specifies a local port.
    ushort         localPort;
    ///Specifies a remote port.
    ushort         remotePort;
    ///IPv6 scope ID.
    uint           scopeId;
    ///An [FWP_BYTE_BLOB](../fwptypes/ns-fwptypes-fwp_byte_blob.md) that specifies the application ID of the local
    ///application associated with the event.
    FWP_BYTE_BLOB  appId;
    ///Contains a user ID that corresponds to the traffic.
    SID*           userId;
union
    {
struct
        {
            FWP_AF reserved1;
union
            {
struct
                {
                    FWP_BYTE_ARRAY6 reserved2;
                    FWP_BYTE_ARRAY6 reserved3;
                    uint            reserved4;
                    uint            reserved5;
                    ushort          reserved6;
                    uint            reserved7;
                    uint            reserved8;
                    ushort          reserved9;
                    ulong           reserved10;
                }
            }
        }
    }
}

///The **FWPM_NET_EVENT_HEADER2** structure contains information common to all events.
///[FWPM_NET_EVENT_HEADER0](ns-fwpmtypes-fwpm_net_event_header0.md) is available.
struct FWPM_NET_EVENT_HEADER2
{
    ///Type: **[FILETIME](../minwinbase/ns-minwinbase-filetime.md)** Time that the event occurred.
    FILETIME       timeStamp;
    ///Type: **UINT32** Flags indicating which of the following members are set. Unused fields must be zero-initialized.
    ///| Net event flag | Meaning | | -------------- | ------- | | FWPM_NET_EVENT_FLAG_IP_PROTOCOL_SET | The
    ///**ipProtocol** member is set. | | FWPM_NET_EVENT_FLAG_LOCAL_ADDR_SET | Either the **localAddrV4** member or the
    ///**localAddrV6** member is set. If this flag is present, **FWPM_NET_EVENT_FLAG_IP_VERSION_SET** must also be
    ///present. | | FWPM_NET_EVENT_FLAG_REMOTE_ADDR_SET | Either the **remoteAddrV4** member of the **remoteAddrV6**
    ///field is set. If this flag is present, **FWPM_NET_EVENT_FLAG_IP_VERSION_SET** must also be present. | |
    ///FWPM_NET_EVENT_FLAG_LOCAL_PORT_SET | The **localPort** member is set. | | FWPM_NET_EVENT_FLAG_REMOTE_PORT_SET |
    ///The **remotePort** member is set. | | FWPM_NET_EVENT_FLAG_APP_ID_SET | The **appId** member is set. | |
    ///FWPM_NET_EVENT_FLAG_USER_ID_SET | The **userId** member is set. | | FWPM_NET_EVENT_FLAG_SCOPE_ID_SET | The
    ///**scopeId** member is set. | | FWPM_NET_EVENT_FLAG_IP_VERSION_SET | The **ipVersion** member is set. | |
    ///FWPM_NET_EVENT_FLAG_REAUTH_REASON_SET | Indicates an existing connection was reauthorized. | |
    ///FWPM_NET_EVENT_FLAG_PACKAGE_ID_SET | The **packageSid** member is set. |
    uint           flags;
    ///Type: **[FWP_IP_VERSION](../fwptypes/ne-fwptypes-fwp_ip_version.md)** The IP version being used.
    FWP_IP_VERSION ipVersion;
    ///Type: **UINT8** The IP protocol specified as an IPPROTO value. See the
    ///[socket](../winsock2/nf-winsock2-socket.md) reference topic for more information on possible protocol values.
    ubyte          ipProtocol;
union
    {
        uint             localAddrV4;
        FWP_BYTE_ARRAY16 localAddrV6;
    }
union
    {
        uint             remoteAddrV4;
        FWP_BYTE_ARRAY16 remoteAddrV6;
    }
    ///Type: **UINT16** The local port.
    ushort         localPort;
    ///Type: **UINT16** The remote port.
    ushort         remotePort;
    ///Type: **UINT32** The IPv6 scope ID.
    uint           scopeId;
    ///Type: **[FWP_BYTE_BLOB](../fwptypes/ns-fwptypes-fwp_byte_blob.md)** The application ID of the local application
    ///associated with the event.
    FWP_BYTE_BLOB  appId;
    ///Type: **SID*** The user ID corresponding to the traffic.
    SID*           userId;
    ///Type: **[FWP_AF](../fwptypes/ne-fwptypes-fwp_af.md)** A superset of non-Internet protocols. Available when
    ///**ipVersion** is **FWP_IP_VERSION_NONE**.
    FWP_AF         addressFamily;
    ///Type: **SID*** The security identifier (SID) representing the package identifier (also referred to as the app
    ///container SID) intending to send or receive the network traffic.
    SID*           packageSid;
}

///The **FWPM_NET_EVENT_HEADER3** structure contains information common to all events.
///[FWPM_NET_EVENT_HEADER0](ns-fwpmtypes-fwpm_net_event_header0.md) is available.
struct FWPM_NET_EVENT_HEADER3
{
    ///Time that the event occurred.
    FILETIME       timeStamp;
    ///Flags indicating which of the following members are set. Unused fields must be zero-initialized. | Net event flag
    ///| Meaning | | -------------- | ------- | | FWPM_NET_EVENT_FLAG_IP_PROTOCOL_SET | The **ipProtocol** member is
    ///set. | | FWPM_NET_EVENT_FLAG_LOCAL_ADDR_SET | Either the **localAddrV4** member or the **localAddrV6** member is
    ///set. If this flag is present, **FWPM_NET_EVENT_FLAG_IP_VERSION_SET** must also be present. | |
    ///FWPM_NET_EVENT_FLAG_REMOTE_ADDR_SET | Either the **remoteAddrV4** member of the **remoteAddrV6** field is set. If
    ///this flag is present, **FWPM_NET_EVENT_FLAG_IP_VERSION_SET** must also be present. | |
    ///FWPM_NET_EVENT_FLAG_LOCAL_PORT_SET | The **localPort** member is set. | | FWPM_NET_EVENT_FLAG_REMOTE_PORT_SET |
    ///The **remotePort** member is set. | | FWPM_NET_EVENT_FLAG_APP_ID_SET | The **appId** member is set. | |
    ///FWPM_NET_EVENT_FLAG_USER_ID_SET | The **userId** member is set. | | FWPM_NET_EVENT_FLAG_SCOPE_ID_SET | The
    ///**scopeId** member is set. | | FWPM_NET_EVENT_FLAG_IP_VERSION_SET | The **ipVersion** member is set. | |
    ///FWPM_NET_EVENT_FLAG_REAUTH_REASON_SET | Indicates an existing connection was reauthorized. | |
    ///FWPM_NET_EVENT_FLAG_PACKAGE_ID_SET | The **packageSid** member is set. |
    uint           flags;
    ///The IP version being used.
    FWP_IP_VERSION ipVersion;
    ///The IP protocol specified as an IPPROTO value. See the [socket](../winsock2/nf-winsock2-socket.md) reference
    ///topic for more information on possible protocol values.
    ubyte          ipProtocol;
union
    {
        uint             localAddrV4;
        FWP_BYTE_ARRAY16 localAddrV6;
    }
union
    {
        uint             remoteAddrV4;
        FWP_BYTE_ARRAY16 remoteAddrV6;
    }
    ///The local port.
    ushort         localPort;
    ///The remote port.
    ushort         remotePort;
    ///The IPv6 scope ID.
    uint           scopeId;
    ///The application ID of the local application associated with the event.
    FWP_BYTE_BLOB  appId;
    ///The user ID corresponding to the traffic.
    SID*           userId;
    ///A superset of non-Internet protocols. Available when **ipVersion** is **FWP_IP_VERSION_NONE**.
    FWP_AF         addressFamily;
    ///The security identifier (SID) representing the package identifier (also referred to as the app container SID)
    ///intending to send or receive the network traffic.
    SID*           packageSid;
    ///The enterprise identifier for use with enterprise data protection (EDP).
    PWSTR          enterpriseId;
    ///The policy flags for EDP.
    ulong          policyFlags;
    ///The EDP remote server used for name-based policy.
    FWP_BYTE_BLOB  effectiveName;
}

///The **FWPM_NET_EVENT_IKEEXT_MM_FAILURE0** structure contains information that describes an IKE/AuthIP Main Mode (MM)
///failure. [FWPM_NET_EVENT_IKEEXT_MM_FAILURE1](ns-fwpmtypes-fwpm_net_event_ikeext_mm_failure1.md) is available.
struct FWPM_NET_EVENT_IKEEXT_MM_FAILURE0
{
    ///Windows error code for the failure.
    uint                failureErrorCode;
    ///An [IPSEC_FAILURE_POINT](../ipsectypes/ne-ipsectypes-ipsec_failure_point.md) value that indicates the IPsec state
    ///when the failure occurred.
    IPSEC_FAILURE_POINT failurePoint;
    ///Flags for the failure event. | Value | Meaning | | ----- | ------- | |
    ///FWPM_NET_EVENT_IKEEXT_MM_FAILURE_FLAG_BENIGN | Indicates that the failure was benign or expected. | |
    ///FWPM_NET_EVENT_IKEEXT_MM_FAILURE_FLAG_MULTIPLE | Indicates that multiple failure events have been reported. |
    uint                flags;
    ///An [IKEEXT_KEY_MODULE_TYPE](../iketypes/ne-iketypes-ikeext_key_module_type.md) value that specifies the type of
    ///keying module.
    IKEEXT_KEY_MODULE_TYPE keyingModuleType;
    ///An [IKEEXT_MM_SA_STATE](../iketypes/ne-iketypes-ikeext_mm_sa_state.md) value that indicates the Main Mode state
    ///when the failure occurred.
    IKEEXT_MM_SA_STATE  mmState;
    ///An [IKEEXT_SA_ROLE](../iketypes/ne-iketypes-ikeext_sa_role.md) value that specifies the security association (SA)
    ///role when the failure occurred.
    IKEEXT_SA_ROLE      saRole;
    ///An [IKEEXT_AUTHENTICATION_METHOD_TYPE](../iketypes/ne-iketypes-ikeext_authentication_method_type.md) value that
    ///specifies the authentication method.
    IKEEXT_AUTHENTICATION_METHOD_TYPE mmAuthMethod;
    ///SHA thumbprint hash of the end certificate corresponding to the failures that happen during building or
    ///validating certificate chains. **IKEEXT_CERT_HASH_LEN** maps to 20.
    ubyte[20]           endCertHash;
    ///LUID for the MM SA.
    ulong               mmId;
    ///Main mode filter ID.
    ulong               mmFilterId;
}

///The **FWPM_NET_EVENT_IKEEXT_MM_FAILURE1** structure contains information that describes an IKE/AuthIP Main Mode (MM)
///failure. [FWPM_NET_EVENT_IKEEXT_MM_FAILURE0](ns-fwpmtypes-fwpm_net_event_ikeext_mm_failure0.md) is available.
struct FWPM_NET_EVENT_IKEEXT_MM_FAILURE1
{
    ///Windows error code for the failure.
    uint                failureErrorCode;
    ///An [IPSEC_FAILURE_POINT](../ipsectypes/ne-ipsectypes-ipsec_failure_point.md) value that indicates the IPsec state
    ///when the failure occurred.
    IPSEC_FAILURE_POINT failurePoint;
    ///Flags for the failure event. | Value | Meaning | | ----- | ------- | |
    ///FWPM_NET_EVENT_IKEEXT_MM_FAILURE_FLAG_BENIGN | Indicates that the failure was benign or expected. | |
    ///FWPM_NET_EVENT_IKEEXT_MM_FAILURE_FLAG_MULTIPLE | Indicates that multiple failure events have been reported. |
    uint                flags;
    ///An [IKEEXT_KEY_MODULE_TYPE](../iketypes/ne-iketypes-ikeext_key_module_type.md) value that specifies the type of
    ///keying module.
    IKEEXT_KEY_MODULE_TYPE keyingModuleType;
    ///An [IKEEXT_MM_SA_STATE](../iketypes/ne-iketypes-ikeext_mm_sa_state.md) value that indicates the Main Mode state
    ///when the failure occurred.
    IKEEXT_MM_SA_STATE  mmState;
    ///An [IKEEXT_SA_ROLE](../iketypes/ne-iketypes-ikeext_sa_role.md) value that specifies the security association (SA)
    ///role when the failure occurred.
    IKEEXT_SA_ROLE      saRole;
    ///An [IKEEXT_AUTHENTICATION_METHOD_TYPE](../iketypes/ne-iketypes-ikeext_authentication_method_type.md) value that
    ///specifies the authentication method.
    IKEEXT_AUTHENTICATION_METHOD_TYPE mmAuthMethod;
    ///SHA thumbprint hash of the end certificate corresponding to the failures that happen during building or
    ///validating certificate chains. **IKEEXT_CERT_HASH_LEN** maps to 20.
    ubyte[20]           endCertHash;
    ///LUID for the MM SA.
    ulong               mmId;
    ///Main mode filter ID.
    ulong               mmFilterId;
    ///Name of the MM local security principal.
    PWSTR               localPrincipalNameForAuth;
    ///Name of the MM remote security principal.
    PWSTR               remotePrincipalNameForAuth;
    ///Number of groups in the local security principal's token.
    uint                numLocalPrincipalGroupSids;
    ///Groups in the local security principal's token.
    PWSTR*              localPrincipalGroupSids;
    ///Number of groups in the remote security principal's token.
    uint                numRemotePrincipalGroupSids;
    ///Groups in the remote security principal's token.
    PWSTR*              remotePrincipalGroupSids;
}

struct FWPM_NET_EVENT_IKEEXT_MM_FAILURE2_
{
    uint                failureErrorCode;
    IPSEC_FAILURE_POINT failurePoint;
    uint                flags;
    IKEEXT_KEY_MODULE_TYPE keyingModuleType;
    IKEEXT_MM_SA_STATE  mmState;
    IKEEXT_SA_ROLE      saRole;
    IKEEXT_AUTHENTICATION_METHOD_TYPE mmAuthMethod;
    ubyte[20]           endCertHash;
    ulong               mmId;
    ulong               mmFilterId;
    PWSTR               localPrincipalNameForAuth;
    PWSTR               remotePrincipalNameForAuth;
    uint                numLocalPrincipalGroupSids;
    PWSTR*              localPrincipalGroupSids;
    uint                numRemotePrincipalGroupSids;
    PWSTR*              remotePrincipalGroupSids;
    GUID*               providerContextKey;
}

///The <b>FWPM_NET_EVENT_IKEEXT_QM_FAILURE0</b> structure contains information that describes an IKE/AuthIP Quick Mode
///(QM) failure.
struct FWPM_NET_EVENT_IKEEXT_QM_FAILURE0
{
    ///Windows error code for the failure.
    uint                failureErrorCode;
    ///An [IPSEC_FAILURE_POINT](/windows/desktop/api/ipsectypes/ne-ipsectypes-ipsec_failure_point) value that indicates
    ///the IPsec state when the failure occurred.
    IPSEC_FAILURE_POINT failurePoint;
    ///An [IKEEXT_KEY_MODULE_TYPE](/windows/desktop/api/iketypes/ne-iketypes-ikeext_key_module_type) value that
    ///specifies the type of keying module.
    IKEEXT_KEY_MODULE_TYPE keyingModuleType;
    ///An [IKEEXT_QM_SA_STATE](/windows/desktop/api/iketypes/ne-iketypes-ikeext_qm_sa_state) value that specifies the QM
    ///state when the failure occurred.
    IKEEXT_QM_SA_STATE  qmState;
    ///An [IKEEXT_SA_ROLE](/windows/desktop/api/iketypes/ne-iketypes-ikeext_sa_role) value that specifies the SA role
    ///when the failure occurred.
    IKEEXT_SA_ROLE      saRole;
    ///An [IPSEC_TRAFFIC_TYPE](/windows/desktop/api/ipsectypes/ne-ipsectypes-ipsec_traffic_type) value that specifies
    ///the type of traffic.
    IPSEC_TRAFFIC_TYPE  saTrafficType;
union
    {
        FWP_CONDITION_VALUE0 localSubNet;
    }
union
    {
        FWP_CONDITION_VALUE0 remoteSubNet;
    }
    ///Quick Mode filter ID.
    ulong               qmFilterId;
}

struct FWPM_NET_EVENT_IKEEXT_QM_FAILURE1_
{
    uint                failureErrorCode;
    IPSEC_FAILURE_POINT failurePoint;
    IKEEXT_KEY_MODULE_TYPE keyingModuleType;
    IKEEXT_QM_SA_STATE  qmState;
    IKEEXT_SA_ROLE      saRole;
    IPSEC_TRAFFIC_TYPE  saTrafficType;
union
    {
        FWP_CONDITION_VALUE0 localSubNet;
    }
union
    {
        FWP_CONDITION_VALUE0 remoteSubNet;
    }
    ulong               qmFilterId;
    ulong               mmSaLuid;
    GUID                mmProviderContextKey;
}

///The **FWPM_NET_EVENT_IKEEXT_EM_FAILURE0** structure contains information that describes an IKE Extended Mode (EM)
///failure. [FWPM_NET_EVENT_IKEEXT_EM_FAILURE1](ns-fwpmtypes-fwpm_net_event_ikeext_em_failure1.md) is available.
struct FWPM_NET_EVENT_IKEEXT_EM_FAILURE0
{
    ///Windows error code for the failure.
    uint                failureErrorCode;
    ///An [IPSEC_FAILURE_POINT](../ipsectypes/ne-ipsectypes-ipsec_failure_point.md) value that indicates the IPsec state
    ///when the failure occurred.
    IPSEC_FAILURE_POINT failurePoint;
    ///Flags for the failure event. | Value | Meaning | | ----- | ------- | |
    ///FWPM_NET_EVENT_IKEEXT_EM_FAILURE_FLAG_MULTIPLE | Indicates that multiple IKE EM failure events have been
    ///reported. |
    uint                flags;
    ///An [IKEEXT_EM_SA_STATE](../iketypes/ne-iketypes-ikeext_em_sa_state.md) value that indicates the EM state when the
    ///failure occurred.
    IKEEXT_EM_SA_STATE  emState;
    ///An [IKEEXT_SA_ROLE](../iketypes/ne-iketypes-ikeext_sa_role.md) value that specifies the SA role when the failure
    ///occurred.
    IKEEXT_SA_ROLE      saRole;
    ///An [IKEEXT_AUTHENTICATION_METHOD_TYPE](../iketypes/ne-iketypes-ikeext_authentication_method_type.md) value that
    ///specifies the authentication method.
    IKEEXT_AUTHENTICATION_METHOD_TYPE emAuthMethod;
    ///SHA thumbprint hash of the end certificate corresponding to the failures that happen during building or
    ///validating certificate chains. **IKEEXT_CERT_HASH_LEN** maps to 20.
    ubyte[20]           endCertHash;
    ///LUID for the Main Mode (MM) SA.
    ulong               mmId;
    ///Quick Mode (QM) filter ID associated with this failure.
    ulong               qmFilterId;
}

///The **FWPM_NET_EVENT_IKEEXT_EM_FAILURE1** structure contains information that describes an IKE Extended mode (EM)
///failure. [FWPM_NET_EVENT_IKEEXT_EM_FAILURE0](ns-fwpmtypes-fwpm_net_event_ikeext_em_failure0.md) is available.
struct FWPM_NET_EVENT_IKEEXT_EM_FAILURE1
{
    ///Windows error code for the failure.
    uint                failureErrorCode;
    ///An [IPSEC_FAILURE_POINT](../ipsectypes/ne-ipsectypes-ipsec_failure_point.md) value that indicates the IPsec state
    ///when the failure occurred.
    IPSEC_FAILURE_POINT failurePoint;
    ///Flags for the failure event. | Value | Meaning | | ----- | ------- | |
    ///FWPM_NET_EVENT_IKEEXT_EM_FAILURE_FLAG_MULTIPLE | Indicates that multiple IKE EM failure events have been
    ///reported. | | FWPM_NET_EVENT_IKEEXT_EM_FAILURE_FLAG_BENIGN | Indicates that IKE EM failure events have been
    ///reported, but that the events are benign. |
    uint                flags;
    ///An [IKEEXT_EM_SA_STATE](../iketypes/ne-iketypes-ikeext_em_sa_state.md) value that indicates the EM state when the
    ///failure occurred.
    IKEEXT_EM_SA_STATE  emState;
    ///An [IKEEXT_SA_ROLE](../iketypes/ne-iketypes-ikeext_sa_role.md) value that specifies the SA role when the failure
    ///occurred.
    IKEEXT_SA_ROLE      saRole;
    ///An [IKEEXT_AUTHENTICATION_METHOD_TYPE](../iketypes/ne-iketypes-ikeext_authentication_method_type.md) value that
    ///specifies the authentication method.
    IKEEXT_AUTHENTICATION_METHOD_TYPE emAuthMethod;
    ///SHA thumbprint hash of the end certificate corresponding to the failures that happen during building or
    ///validating certificate chains. **IKEEXT_CERT_HASH_LEN** maps to 20.
    ubyte[20]           endCertHash;
    ///LUID for the Main Mode (MM) SA.
    ulong               mmId;
    ///Quick Mode (QM) filter ID associated with this failure.
    ulong               qmFilterId;
    ///Name of the EM local security principal.
    PWSTR               localPrincipalNameForAuth;
    ///Name of the EM remote security principal.
    PWSTR               remotePrincipalNameForAuth;
    ///Number of groups in the local security principal's token.
    uint                numLocalPrincipalGroupSids;
    ///Groups in the local security principal's token.
    PWSTR*              localPrincipalGroupSids;
    ///Number of groups in the remote security principal's token.
    uint                numRemotePrincipalGroupSids;
    ///Groups in the remote security principal's token.
    PWSTR*              remotePrincipalGroupSids;
    ///Type of traffic for which the embedded quick mode was being negotiated.
    IPSEC_TRAFFIC_TYPE  saTrafficType;
}

///The **FWPM_NET_EVENT_CLASSIFY_DROP0** structure contains information that describes a layer drop failure.
///[FWPM_NET_EVENT_CLASSIFY_DROP1](ns-fwpmtypes-fwpm_net_event_classify_drop1.md) is available. For Windows 8,
///[FWPM_NET_EVENT_CLASSIFY_DROP2](ns-fwpmtypes-fwpm_net_event_classify_drop2.md) is available.
struct FWPM_NET_EVENT_CLASSIFY_DROP0
{
    ///A LUID identifying the filter where the failure occurred.
    ulong  filterId;
    ///Indicates the identifier of the filtering layer where the failure occurred. For more information, see [Filtering
    ///Layer Identifiers](/windows/desktop/FWP/management-filtering-layer-identifiers-).
    ushort layerId;
}

///The **FWPM_NET_EVENT_CLASSIFY_DROP1** structure contains information that describes a layer drop failure.
///[FWPM_NET_EVENT_CLASSIFY_DROP0](ns-fwpmtypes-fwpm_net_event_classify_drop0.md) is available.
struct FWPM_NET_EVENT_CLASSIFY_DROP1
{
    ///A LUID identifying the filter where the failure occurred.
    ulong  filterId;
    ///Indicates the identifier of the filtering layer where the failure occurred. For more information, see [Filtering
    ///Layer Identifiers](/windows/desktop/FWP/management-filtering-layer-identifiers-).
    ushort layerId;
    ///Indicates the reason for reauthorizing a previously authorized connection.
    uint   reauthReason;
    ///Indicates the identifier of the profile to which the packet was received (or from which the packet was sent).
    uint   originalProfile;
    ///Indicates the identifier of the profile where the packet was when the failure occurred.
    uint   currentProfile;
    ///Indicates the direction of the packet transmission. Possible values: | Value | Meaning | | ----- | ------- | |
    ///FWP_DIRECTION_IN <br/> 0x00003900L | The packet is inbound. | | FWP_DIRECTION_OUT <br/> 0x00003901L | The packet
    ///is outbound. | | FWP_DIRECTION_FORWARD <br/> 0x00003902L | The packet is traversing an interface which it must
    ///pass through on the way to its destination. |
    uint   msFwpDirection;
    ///Indicates whether the packet originated from (or was heading to) the loopback adapter.
    BOOL   isLoopback;
}

///The **FWPM_NET_EVENT_CLASSIFY_DROP2** structure contains information that describes a layer drop failure.
///[FWPM_NET_EVENT_CLASSIFY_DROP1](ns-fwpmtypes-fwpm_net_event_classify_drop1.md) is available. For Windows Vista,
///[FWPM_NET_EVENT_CLASSIFY_DROP0](ns-fwpmtypes-fwpm_net_event_classify_drop0.md) is available.
struct FWPM_NET_EVENT_CLASSIFY_DROP2
{
    ///A LUID identifying the filter where the failure occurred.
    ulong         filterId;
    ///Indicates the identifier of the filtering layer where the failure occurred. For more information, see [Filtering
    ///Layer Identifiers](/windows/desktop/FWP/management-filtering-layer-identifiers-).
    ushort        layerId;
    ///Indicates the reason for reauthorizing a previously authorized connection.
    uint          reauthReason;
    ///Indicates the identifier of the profile to which the packet was received (or from which the packet was sent).
    uint          originalProfile;
    ///Indicates the identifier of the profile where the packet was when the failure occurred.
    uint          currentProfile;
    ///Indicates the direction of the packet transmission. Possible values: | Value | Meaning | | ----- | ------- | |
    ///FWP_DIRECTION_IN <br/> 0x00003900L | The packet is inbound. | | FWP_DIRECTION_OUT <br/> 0x00003901L | The packet
    ///is outbound. | | FWP_DIRECTION_FORWARD <br/> 0x00003902L | The packet is traversing an interface which it must
    ///pass through on the way to its destination. |
    uint          msFwpDirection;
    ///Indicates whether the packet originated from (or was heading to) the loopback adapter.
    BOOL          isLoopback;
    ///GUID identifier of a vSwitch.
    FWP_BYTE_BLOB vSwitchId;
    ///Transient source port of a packet within the vSwitch.
    uint          vSwitchSourcePort;
    ///Transient destination port of a packet within the vSwitch.
    uint          vSwitchDestinationPort;
}

///The <b>FWPM_NET_EVENT_CLASSIFY_DROP_MAC0</b> structure contains information that describes a MAC layer drop failure.
struct FWPM_NET_EVENT_CLASSIFY_DROP_MAC0
{
    ///The local MAC address.
    FWP_BYTE_ARRAY6 localMacAddr;
    ///The remote MAC address.
    FWP_BYTE_ARRAY6 remoteMacAddr;
    ///The media type of the NDIS port.
    uint            mediaType;
    ///The interface type, as defined by the Internet Assigned Names Authority (IANA). Possible values for the interface
    ///type are listed in the Ipifcons.h include file.
    uint            ifType;
    ///Indicates which protocol is encapsulated in the frame data. The values used for this field comes from the
    ///Ethernet V2 specification's numbering space.
    ushort          etherType;
    ///The number assigned to the NDIS port.
    uint            ndisPortNumber;
    ///Reserved for internal use.
    uint            reserved;
    ///The VLAN (802.1p/q) VID, CFI, and Priority fields marshaled into a 16-bit value. (See VLAN_TAG in netiodef.h.)
    ushort          vlanTag;
    ///The interface LUID corresponding to the network interface with which this packet is associated.
    ulong           ifLuid;
    ///The LUID identifying the filter where the failure occured.
    ulong           filterId;
    ///The identifier of the filtering layer where the failure occurred. For more information, see Filtering Layer
    ///Identifiers
    ushort          layerId;
    ///Indicates the reason for reauthorizing a previously authorized connection.
    uint            reauthReason;
    ///Indicates the identifier of the profile to which the packet was received (or from which the packet was sent).
    uint            originalProfile;
    ///Indicates the identifier of the profile where the packet was when the failure occurred.
    uint            currentProfile;
    ///Indicates the direction of the packet transmission. Possible values: <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="FWP_DIRECTION_IN"></a><a id="fwp_direction_in"></a><dl>
    ///<dt><b>FWP_DIRECTION_IN</b></dt> </dl> </td> <td width="60%"> The packet is inbound. 0x00003900L </td> </tr> <tr>
    ///<td width="40%"><a id="FWP_DIRECTION_OUT"></a><a id="fwp_direction_out"></a><dl>
    ///<dt><b>FWP_DIRECTION_OUT</b></dt> </dl> </td> <td width="60%"> The packet is outbound. 0x00003901L </td> </tr>
    ///<tr> <td width="40%"><a id="FWP_DIRECTION_FORWARD"></a><a id="fwp_direction_forward"></a><dl>
    ///<dt><b>FWP_DIRECTION_FORWARD</b></dt> </dl> </td> <td width="60%"> The packet is traversing an interface which it
    ///must pass through on the way to its destination. 0x00003902L </td> </tr> </table>
    uint            msFwpDirection;
    ///Indicates whether the packet originated from (or was heading to) the loopback adapter.
    BOOL            isLoopback;
    ///GUID identifier of a vSwitch.
    FWP_BYTE_BLOB   vSwitchId;
    ///Transient source port of a packet within the vSwitch.
    uint            vSwitchSourcePort;
    ///Transient destination port of a packet within the vSwitch.
    uint            vSwitchDestinationPort;
}

///The <b>FWPM_NET_EVENT_CLASSIFY_ALLOW0</b> structure contains information that describes allowed traffic as enforced
///by the WFP classify engine.
struct FWPM_NET_EVENT_CLASSIFY_ALLOW0
{
    ///Type: <b>UINT64</b> A LUID identifying the WFP filter allowing this traffic.
    ulong  filterId;
    ///Type: <b>UINT16</b> The identifier of the WFP filtering layer where the filter specified in <b>filterId</b> is
    ///stored. For more information, see Filtering Layer Identifiers.
    ushort layerId;
    ///Type: <b>UINT32</b> The reason for reauthorizing a previously authorized connection.
    uint   reauthReason;
    ///Type: <b>UINT32</b> The identifier of the profile to which the packet was received (or from which the packet was
    ///sent).
    uint   originalProfile;
    ///Type: <b>UINT32</b> The identifier of the profile where the packet was when the failure occurred.
    uint   currentProfile;
    ///Type: <b>UINT32</b> Indicates the direction of the packet transmission. Possible values are
    ///<b>FWP_DIRECTION_INBOUND</b> or <b>FWP_DIRECTION_OUTBOUND</b>.
    uint   msFwpDirection;
    ///Type: <b>BOOL</b> If true, indicates that the packet originated from (or was heading to) the loopback adapter;
    ///otherwise, false.
    BOOL   isLoopback;
}

///The <b>FWPM_NET_EVENT_IPSEC_KERNEL_DROP0</b> structure contains information that describes an IPsec kernel drop
///event.
struct FWPM_NET_EVENT_IPSEC_KERNEL_DROP0
{
    ///Contains the error code for the failure.
    int           failureStatus;
    ///An [FWP_DIRECTION](/windows/desktop/api/fwptypes/ne-fwptypes-fwp_direction) value that specifies whether the
    ///dropped packet is inbound or outbound.
    FWP_DIRECTION direction;
    ///Contains the security parameters index (SPI) on the IPsec header of the packet. This will be 0 for clear text
    ///packets. The <b>IPSEC_SA_SPI</b> is identical to a <b>UINT32</b>.
    uint          spi;
    ///Filter ID that corresponds to the IPsec callout filter. This will be available only if the packet was dropped by
    ///the IPsec callout.
    ulong         filterId;
    ///Layer ID that corresponds to the IPsec callout filter. This will be available only if the packet was dropped by
    ///the IPsec callout.
    ushort        layerId;
}

///The <b>FWPM_NET_EVENT_IPSEC_DOSP_DROP0</b> structure contains information that describes an IPsec DoS Protection drop
///event.
struct FWPM_NET_EVENT_IPSEC_DOSP_DROP0
{
    ///Internet Protocol (IP) version. See [FWP_IP_VERSION](/windows/desktop/api/fwptypes/ne-fwptypes-fwp_ip_version)
    ///for more information.
    FWP_IP_VERSION ipVersion;
union
    {
        uint      publicHostV4Addr;
        ubyte[16] publicHostV6Addr;
    }
union
    {
        uint      internalHostV4Addr;
        ubyte[16] internalHostV6Addr;
    }
    ///Contains the error code for the failure.
    int            failureStatus;
    ///An [FWP_DIRECTION](/windows/desktop/api/fwptypes/ne-fwptypes-fwp_direction) value that specifies whether the
    ///dropped packet is inbound or outbound.
    FWP_DIRECTION  direction;
}

///The <b>FWPM_NET_EVENT_CAPABILITY_DROP0</b> structure contains information about network traffic dropped in relation
///to an app container network capability. Traffic is dropped due to the specified app container network capability and
///enforced by the specified filter identifier.
struct FWPM_NET_EVENT_CAPABILITY_DROP0
{
    ///Type: <b>FWPM_APPC_NETWORK_CAPABILITY_TYPE</b> The specific app container network capability which was missing,
    ///therefore causing this traffic to be denied.
    FWPM_APPC_NETWORK_CAPABILITY_TYPE networkCapabilityId;
    ///Type: <b>UINT64</b> A LUID identifying the WFP filter where the traffic drop occurred.
    ulong filterId;
    ///Type: <b>BOOL</b> True if the packet originated from (or was heading to) the loopback adapter; otherwise, false.
    BOOL  isLoopback;
}

///The <b>FWPM_NET_EVENT_CAPABILITY_ALLOW0</b> structure contains information about network traffic allowed in relation
///to an app container network capability.. The specified app container network capability grants access to network
///resources, and the specified filter identifier enforces allowing access.
struct FWPM_NET_EVENT_CAPABILITY_ALLOW0
{
    ///Type: <b>FWPM_APPC_NETWORK_CAPABILITY_TYPE</b> The specific app container network capability allowing this
    ///traffic.
    FWPM_APPC_NETWORK_CAPABILITY_TYPE networkCapabilityId;
    ///Type: <b>UINT64</b> A LUID identifying the WFP filter enforcing the allowed access intended by the capability in
    ///<b>networkCapabilityId</b>.
    ulong filterId;
    ///Type: <b>BOOL</b> True if the packet originated from (or was heading to) the loopback adapter; otherwise, false.
    BOOL  isLoopback;
}

struct FWPM_NET_EVENT_LPM_PACKET_ARRIVAL0_
{
    uint spi;
}

///The **FWPM_NET_EVENT0** structure contains information about all event types.
///[FWPM_NET_EVENT1](ns-fwpmtypes-fwpm_net_event1.md) is available. For Windows 8,
///[FWPM_NET_EVENT2](ns-fwpmtypes-fwpm_net_event2.md) is available.
struct FWPM_NET_EVENT0
{
    ///A [FWPM_NET_EVENT_HEADER0](ns-fwpmtypes-fwpm_net_event_header0.md) structure that contains information common to
    ///all events.
    FWPM_NET_EVENT_HEADER0 header;
    ///A [FWPM_NET_EVENT_TYPE](ne-fwpmtypes-fwpm_net_event_type.md) value that specifies the type of event.
    FWPM_NET_EVENT_TYPE type;
union
    {
        FWPM_NET_EVENT_IKEEXT_MM_FAILURE0* ikeMmFailure;
        FWPM_NET_EVENT_IKEEXT_QM_FAILURE0* ikeQmFailure;
        FWPM_NET_EVENT_IKEEXT_EM_FAILURE0* ikeEmFailure;
        FWPM_NET_EVENT_CLASSIFY_DROP0* classifyDrop;
        FWPM_NET_EVENT_IPSEC_KERNEL_DROP0* ipsecDrop;
        FWPM_NET_EVENT_IPSEC_DOSP_DROP0* idpDrop;
    }
}

///The **FWPM_NET_EVENT1** structure contains information about all event types.
///[FWPM_NET_EVENT0](ns-fwpmtypes-fwpm_net_event0.md) is available.
struct FWPM_NET_EVENT1
{
    ///An [FWPM_NET_EVENT_HEADER1](ns-fwpmtypes-fwpm_net_event_header1.md) structure that contains information common to
    ///all events.
    FWPM_NET_EVENT_HEADER1 header;
    ///An [FWPM_NET_EVENT_TYPE](ne-fwpmtypes-fwpm_net_event_type.md) value that specifies the type of event.
    FWPM_NET_EVENT_TYPE type;
union
    {
        FWPM_NET_EVENT_IKEEXT_MM_FAILURE1* ikeMmFailure;
        FWPM_NET_EVENT_IKEEXT_QM_FAILURE0* ikeQmFailure;
        FWPM_NET_EVENT_IKEEXT_EM_FAILURE1* ikeEmFailure;
        FWPM_NET_EVENT_CLASSIFY_DROP1* classifyDrop;
        FWPM_NET_EVENT_IPSEC_KERNEL_DROP0* ipsecDrop;
        FWPM_NET_EVENT_IPSEC_DOSP_DROP0* idpDrop;
    }
}

///The **FWPM_NET_EVENT2** structure contains information about all event types.
///[FWPM_NET_EVENT0](ns-fwpmtypes-fwpm_net_event0.md) is available.
struct FWPM_NET_EVENT2
{
    ///Type: **[FWPM_NET_EVENT_HEADER2](ns-fwpmtypes-fwpm_net_event_header2.md)** Information common to all events.
    FWPM_NET_EVENT_HEADER2 header;
    ///Type: **[FWPM_NET_EVENT_TYPE](ne-fwpmtypes-fwpm_net_event_type.md)** The type of event.
    FWPM_NET_EVENT_TYPE type;
union
    {
        FWPM_NET_EVENT_IKEEXT_MM_FAILURE1* ikeMmFailure;
        FWPM_NET_EVENT_IKEEXT_QM_FAILURE0* ikeQmFailure;
        FWPM_NET_EVENT_IKEEXT_EM_FAILURE1* ikeEmFailure;
        FWPM_NET_EVENT_CLASSIFY_DROP2* classifyDrop;
        FWPM_NET_EVENT_IPSEC_KERNEL_DROP0* ipsecDrop;
        FWPM_NET_EVENT_IPSEC_DOSP_DROP0* idpDrop;
        FWPM_NET_EVENT_CLASSIFY_ALLOW0* classifyAllow;
        FWPM_NET_EVENT_CAPABILITY_DROP0* capabilityDrop;
        FWPM_NET_EVENT_CAPABILITY_ALLOW0* capabilityAllow;
        FWPM_NET_EVENT_CLASSIFY_DROP_MAC0* classifyDropMac;
    }
}

///The **FWPM_NET_EVENT3** structure contains information about all event types.
///[FWPM_NET_EVENT2](ns-fwpmtypes-fwpm_net_event2.md) is available. For Windows 7,
///[FWPM_NET_EVENT1](ns-fwpmtypes-fwpm_net_event1.md) is available. For Windows Vista,
///[FWPM_NET_EVENT0](ns-fwpmtypes-fwpm_net_event0.md) is available.
struct FWPM_NET_EVENT3
{
    ///Information common to all events.
    FWPM_NET_EVENT_HEADER3 header;
    ///The type of event.
    FWPM_NET_EVENT_TYPE type;
union
    {
        FWPM_NET_EVENT_IKEEXT_MM_FAILURE1* ikeMmFailure;
        FWPM_NET_EVENT_IKEEXT_QM_FAILURE0* ikeQmFailure;
        FWPM_NET_EVENT_IKEEXT_EM_FAILURE1* ikeEmFailure;
        FWPM_NET_EVENT_CLASSIFY_DROP2* classifyDrop;
        FWPM_NET_EVENT_IPSEC_KERNEL_DROP0* ipsecDrop;
        FWPM_NET_EVENT_IPSEC_DOSP_DROP0* idpDrop;
        FWPM_NET_EVENT_CLASSIFY_ALLOW0* classifyAllow;
        FWPM_NET_EVENT_CAPABILITY_DROP0* capabilityDrop;
        FWPM_NET_EVENT_CAPABILITY_ALLOW0* capabilityAllow;
        FWPM_NET_EVENT_CLASSIFY_DROP_MAC0* classifyDropMac;
    }
}

struct FWPM_NET_EVENT4_
{
    FWPM_NET_EVENT_HEADER3 header;
    FWPM_NET_EVENT_TYPE type;
union
    {
        FWPM_NET_EVENT_IKEEXT_MM_FAILURE2_* ikeMmFailure;
        FWPM_NET_EVENT_IKEEXT_QM_FAILURE1_* ikeQmFailure;
        FWPM_NET_EVENT_IKEEXT_EM_FAILURE1* ikeEmFailure;
        FWPM_NET_EVENT_CLASSIFY_DROP2* classifyDrop;
        FWPM_NET_EVENT_IPSEC_KERNEL_DROP0* ipsecDrop;
        FWPM_NET_EVENT_IPSEC_DOSP_DROP0* idpDrop;
        FWPM_NET_EVENT_CLASSIFY_ALLOW0* classifyAllow;
        FWPM_NET_EVENT_CAPABILITY_DROP0* capabilityDrop;
        FWPM_NET_EVENT_CAPABILITY_ALLOW0* capabilityAllow;
        FWPM_NET_EVENT_CLASSIFY_DROP_MAC0* classifyDropMac;
    }
}

struct FWPM_NET_EVENT5_
{
    FWPM_NET_EVENT_HEADER3 header;
    FWPM_NET_EVENT_TYPE type;
union
    {
        FWPM_NET_EVENT_IKEEXT_MM_FAILURE2_* ikeMmFailure;
        FWPM_NET_EVENT_IKEEXT_QM_FAILURE1_* ikeQmFailure;
        FWPM_NET_EVENT_IKEEXT_EM_FAILURE1* ikeEmFailure;
        FWPM_NET_EVENT_CLASSIFY_DROP2* classifyDrop;
        FWPM_NET_EVENT_IPSEC_KERNEL_DROP0* ipsecDrop;
        FWPM_NET_EVENT_IPSEC_DOSP_DROP0* idpDrop;
        FWPM_NET_EVENT_CLASSIFY_ALLOW0* classifyAllow;
        FWPM_NET_EVENT_CAPABILITY_DROP0* capabilityDrop;
        FWPM_NET_EVENT_CAPABILITY_ALLOW0* capabilityAllow;
        FWPM_NET_EVENT_CLASSIFY_DROP_MAC0* classifyDropMac;
        FWPM_NET_EVENT_LPM_PACKET_ARRIVAL0_* lpmPacketArrival;
    }
}

///The <b>FWPM_NET_EVENT_ENUM_TEMPLATE0</b> structure is used for enumerating net events.
struct FWPM_NET_EVENT_ENUM_TEMPLATE0
{
    ///A FILETIME structure that specifies the start time of the period to be checked for net events.
    FILETIME startTime;
    ///A FILETIME structure that specifies the end time of the period to be checked for net events. It must be greater
    ///than or equal to <b>startTime</b>.
    FILETIME endTime;
    ///Indicates the number of filter conditions in the <b>filterCondition</b> member. If this field is 0, all events
    ///will be returned.
    uint     numFilterConditions;
    ///An array of [FWPM_FILTER_CONDITION0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_filter_condition0)
    ///structures that contain distinct filter conditions (duplicated filter conditions will generate an error). All
    ///conditions must be true for the action to be performed. In other words, the conditions are AND'ed together. If no
    ///conditions are specified, the action is always performed. Supported filtering conditions. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="FWPM_CONDITION_IP_PROTOCOL"></a><a
    ///id="fwpm_condition_ip_protocol"></a><dl> <dt><b>FWPM_CONDITION_IP_PROTOCOL</b></dt> </dl> </td> <td width="60%">
    ///The IP protocol number, as specified in RFC 1700. </td> </tr> <tr> <td width="40%"><a
    ///id="FWPM_CONDITION_IP_LOCAL_ADDRESS"></a><a id="fwpm_condition_ip_local_address"></a><dl>
    ///<dt><b>FWPM_CONDITION_IP_LOCAL_ADDRESS</b></dt> </dl> </td> <td width="60%"> The local IP address. </td> </tr>
    ///<tr> <td width="40%"><a id="FWPM_CONDITION_IP_REMOTE_ADDRESS"></a><a
    ///id="fwpm_condition_ip_remote_address"></a><dl> <dt><b>FWPM_CONDITION_IP_REMOTE_ADDRESS</b></dt> </dl> </td> <td
    ///width="60%"> The remote IP address. </td> </tr> <tr> <td width="40%"><a id="FWPM_CONDITION_IP_LOCAL_PORT"></a><a
    ///id="fwpm_condition_ip_local_port"></a><dl> <dt><b>FWPM_CONDITION_IP_LOCAL_PORT</b></dt> </dl> </td> <td
    ///width="60%"> The local transport protocol port number. For ICMP, the message type. </td> </tr> <tr> <td
    ///width="40%"><a id="FWPM_CONDITION_IP_REMOTE_PORT"></a><a id="fwpm_condition_ip_remote_port"></a><dl>
    ///<dt><b>FWPM_CONDITION_IP_REMOTE_PORT</b></dt> </dl> </td> <td width="60%"> The remote transport protocol port
    ///number. For ICMP, the message code. </td> </tr> <tr> <td width="40%"><a id="FWPM_CONDITION_SCOPE_ID"></a><a
    ///id="fwpm_condition_scope_id"></a><dl> <dt><b>FWPM_CONDITION_SCOPE_ID</b></dt> </dl> </td> <td width="60%"> The
    ///interface IPv6 scope identifier. Reserved for internal use. </td> </tr> <tr> <td width="40%"><a
    ///id="FWPM_CONDITION_ALE_APP_ID"></a><a id="fwpm_condition_ale_app_id"></a><dl>
    ///<dt><b>FWPM_CONDITION_ALE_APP_ID</b></dt> </dl> </td> <td width="60%"> The full path of the application. </td>
    ///</tr> <tr> <td width="40%"><a id="FWPM_CONDITION_ALE_USER_ID"></a><a id="fwpm_condition_ale_user_id"></a><dl>
    ///<dt><b>FWPM_CONDITION_ALE_USER_ID</b></dt> </dl> </td> <td width="60%"> The identification of the local user.
    ///</td> </tr> </table>
    FWPM_FILTER_CONDITION0* filterCondition;
}

///The <b>FWPM_NET_EVENT_SUBSCRIPTION0</b> structure stores information used to subscribe to notifications about a
///network event.
struct FWPM_NET_EVENT_SUBSCRIPTION0
{
    ///Address of an
    ///[FWPM_NET_EVENT_ENUM_TEMPLATE0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_net_event_enum_template0)
    ///structure. Notifications are only dispatched for objects that match the template. If <b>enumTemplate</b> is
    ///<b>NULL</b>, it matches all objects.
    FWPM_NET_EVENT_ENUM_TEMPLATE0* enumTemplate;
    ///Unused.
    uint flags;
    ///Identifies the session which created the subscription.
    GUID sessionKey;
}

///The <b>FWPM_SYSTEM_PORTS_BY_TYPE0</b> structure contains information about the system ports of a specified type.
struct FWPM_SYSTEM_PORTS_BY_TYPE0
{
    ///An [FWPM_SYSTEM_PORT_TYPE](/windows/desktop/api/fwpmtypes/ne-fwpmtypes-fwpm_system_port_type) enumeration that
    ///specifies the type of port.
    FWPM_SYSTEM_PORT_TYPE type;
    ///The number of ports of the specified type.
    uint    numPorts;
    ///Array of IP port numbers for the specified type.
    ushort* ports;
}

///The <b>FWPM_SYSTEM_PORTS0</b> structure contains information about all of the system ports of all types.
struct FWPM_SYSTEM_PORTS0
{
    ///The number of types in the array.
    uint numTypes;
    ///A [FWPM_SYSTEM_PORTS_BY_TYPE0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_system_ports_by_type0) structure
    ///that specifies the array of system port types.
    FWPM_SYSTEM_PORTS_BY_TYPE0* types;
}

///The <b>FWPM_CONNECTION0</b> structure stores the state associated with a connection object.
struct FWPM_CONNECTION0
{
    ///Type: <b>UINT64</b> The run-time identifier for the connection.
    ulong              connectionId;
    ///Type: [FWP_IP_VERSION](/windows/desktop/api/fwptypes/ne-fwptypes-fwp_ip_version)</b> The IP version being used.
    FWP_IP_VERSION     ipVersion;
union
    {
        uint      localV4Address;
        ubyte[16] localV6Address;
    }
union
    {
        uint      remoteV4Address;
        ubyte[16] remoteV6Address;
    }
    ///Type: <b>GUID*</b> Uniquely identifies the provider associated with this connection.
    GUID*              providerKey;
    ///Type: [IPSEC_TRAFFIC_TYPE](/windows/desktop/api/ipsectypes/ne-ipsectypes-ipsec_traffic_type)</b> The type of
    ///IPsec traffic.
    IPSEC_TRAFFIC_TYPE ipsecTrafficModeType;
    ///Type: [IKEEXT_KEY_MODULE_TYPE](/windows/desktop/api/iketypes/ne-iketypes-ikeext_key_module_type)</b> The type of
    ///keying module.
    IKEEXT_KEY_MODULE_TYPE keyModuleType;
    ///Type: [IKEEXT_PROPOSAL0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_proposal0)</b> An IKE/AuthIP main mode
    ///proposal.
    IKEEXT_PROPOSAL0   mmCrypto;
    ///Type: [IKEEXT_CREDENTIAL2](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credential2)</b> Main mode credential
    ///information.
    IKEEXT_CREDENTIAL2 mmPeer;
    ///Type: [IKEEXT_CREDENTIAL2](/windows/desktop/api/iketypes/ns-iketypes-ikeext_credential2)</b> Extended mode
    ///credential information.
    IKEEXT_CREDENTIAL2 emPeer;
    ///Type: <b>UINT64</b> The total number of incoming bytes transferred by the connection.
    ulong              bytesTransferredIn;
    ///Type: <b>UINT64</b> The total number of outgoing bytes transferred by the connection.
    ulong              bytesTransferredOut;
    ///Type: <b>UINT64</b> The total number of bytes (incoming and outgoing) transferred by the connection.
    ulong              bytesTransferredTotal;
    ///Type: <b>FILETIME</b> Time that the connection was created.
    FILETIME           startSysTime;
}

///The <b>FWPM_CONNECTION_ENUM_TEMPLATE0</b> structure is used for limiting connection object enumerations.
struct FWPM_CONNECTION_ENUM_TEMPLATE0
{
    ///Uniquely identifies a connection object.
    ulong connectionId;
    uint  flags;
}

///The <b>FWPM_CONNECTION_SUBSCRIPTION0</b> structure stores information used to subscribe to notifications about a
///connection object.
struct FWPM_CONNECTION_SUBSCRIPTION0
{
    ///Enumeration template for limiting the subscription.
    FWPM_CONNECTION_ENUM_TEMPLATE0* enumTemplate;
    ///Reserved for system use.
    uint flags;
    ///Identifies the session that created the subscription.
    GUID sessionKey;
}

///The <b>FWPM_VSWITCH_EVENT0</b> structure contains information about a vSwitch event.
struct FWPM_VSWITCH_EVENT0
{
    ///Type: [FWPM_VSWITCH_EVENT_TYPE](/windows/desktop/api/fwpmtypes/ne-fwpmtypes-fwpm_vswitch_event_type)</b> The type
    ///of vSwitch event.
    FWPM_VSWITCH_EVENT_TYPE eventType;
    ///Type: <b>wchar_t*</b> GUID that identifies a vSwitch.
    PWSTR vSwitchId;
union
    {
struct positionInfo
        {
            uint   numvSwitchFilterExtensions;
            PWSTR* vSwitchFilterExtensions;
        }
struct reorderInfo
        {
            BOOL   inRequiredPosition;
            uint   numvSwitchFilterExtensions;
            PWSTR* vSwitchFilterExtensions;
        }
    }
}

///The <b>FWPM_VSWITCH_EVENT_SUBSCRIPTION0</b> structure stores information used to subscribe to notifications about a
///vSwitch event.
struct FWPM_VSWITCH_EVENT_SUBSCRIPTION0
{
    ///Type: <b>UINT32</b> This member is reserved for future use.
    uint flags;
    ///Type: <b>GUID</b> Identifies the session which created the subscription.
    GUID sessionKey;
}

///The <b>IPSEC_KEY_MANAGER_CALLBACKS0</b> structure specifies the set of callbacks which should be invoked by IPsec at
///various stages of SA negotiation
struct IPSEC_KEY_MANAGER_CALLBACKS0
{
    ///Type: <b>GUID</b> Reserved for system use.
    GUID reserved;
    ///Type: <b>UINT32</b> Reserved for system use.
    uint flags;
    ///Type: <b>IPSEC_KEY_MANAGER_KEY_DICTATION_CHECK0</b> Specifies that the Trusted Intermediary Agent (TIA) will
    ///dictate the keys for the SA being negotiated. Only used if the <b>IPSEC_DICTATE_KEY</b> flag is set.
    IPSEC_KEY_MANAGER_KEY_DICTATION_CHECK0 keyDictationCheck;
    ///Type: <b>IPSEC_KEY_MANAGER_DICTATE_KEY0</b> Allows the TIA to dictate the keys for the SA being negotiated. Only
    ///used if the <b>IPSEC_DICTATE_KEY</b> flag is set.
    IPSEC_KEY_MANAGER_DICTATE_KEY0 keyDictation;
    ///Type: <b>IPSEC_KEY_MANAGER_NOTIFY_KEY0</b> Notifies the TIA of the keys for the SA being negotiated.
    IPSEC_KEY_MANAGER_NOTIFY_KEY0 keyNotify;
}

union DL_OUI
{
    ubyte[3] Byte;
struct
    {
        ubyte _bitfield207;
    }
}

union DL_EI48
{
    ubyte[3] Byte;
}

union DL_EUI48
{
    ubyte[6] Byte;
struct
    {
        DL_OUI  Oui;
        DL_EI48 Ei48;
    }
}

union DL_EI64
{
    ubyte[5] Byte;
}

union DL_EUI64
{
    ubyte[8] Byte;
    ulong    Value;
struct
    {
        DL_OUI Oui;
union
        {
            DL_EI64 Ei64;
struct
            {
                ubyte   Type;
                ubyte   Tse;
                DL_EI48 Ei48;
            }
        }
    }
}

struct SNAP_HEADER
{
    ubyte    Dsap;
    ubyte    Ssap;
    ubyte    Control;
    ubyte[3] Oui;
    ushort   Type;
}

struct ETHERNET_HEADER
{
    DL_EUI48 Destination;
    DL_EUI48 Source;
union
    {
        ushort Type;
        ushort Length;
    }
}

struct VLAN_TAG
{
union
    {
        ushort Tag;
struct
        {
            ushort _bitfield208;
        }
    }
    ushort Type;
}

struct ICMP_HEADER
{
    ubyte  Type;
    ubyte  Code;
    ushort Checksum;
}

struct ICMP_MESSAGE
{
    ICMP_HEADER Header;
union Data
    {
        uint[1]   Data32;
        ushort[2] Data16;
        ubyte[4]  Data8;
    }
}

struct IPV4_HEADER
{
union
    {
        ubyte VersionAndHeaderLength;
struct
        {
            ubyte _bitfield209;
        }
    }
union
    {
        ubyte TypeOfServiceAndEcnField;
struct
        {
            ubyte _bitfield210;
        }
    }
    ushort  TotalLength;
    ushort  Identification;
union
    {
        ushort FlagsAndOffset;
struct
        {
            ushort _bitfield211;
        }
    }
    ubyte   TimeToLive;
    ubyte   Protocol;
    ushort  HeaderChecksum;
    in_addr SourceAddress;
    in_addr DestinationAddress;
}

struct IPV4_OPTION_HEADER
{
union
    {
        ubyte OptionType;
struct
        {
            ubyte _bitfield212;
        }
    }
    ubyte OptionLength;
}

struct IPV4_TIMESTAMP_OPTION
{
    IPV4_OPTION_HEADER OptionHeader;
    ubyte              Pointer;
union
    {
        ubyte FlagsOverflow;
struct
        {
            ubyte _bitfield213;
        }
    }
}

struct IPV4_ROUTING_HEADER
{
    IPV4_OPTION_HEADER OptionHeader;
    ubyte              Pointer;
}

struct ICMPV4_ROUTER_SOLICIT
{
    ICMP_MESSAGE RsHeader;
}

struct ICMPV4_ROUTER_ADVERT_HEADER
{
    ICMP_MESSAGE RaHeader;
}

struct ICMPV4_ROUTER_ADVERT_ENTRY
{
    in_addr RouterAdvertAddr;
    int     PreferenceLevel;
}

struct ICMPV4_TIMESTAMP_MESSAGE
{
    ICMP_MESSAGE Header;
    uint         OriginateTimestamp;
    uint         ReceiveTimestamp;
    uint         TransmitTimestamp;
}

struct ICMPV4_ADDRESS_MASK_MESSAGE
{
    ICMP_MESSAGE Header;
    uint         AddressMask;
}

struct ARP_HEADER
{
    ushort   HardwareAddressSpace;
    ushort   ProtocolAddressSpace;
    ubyte    HardwareAddressLength;
    ubyte    ProtocolAddressLength;
    ushort   Opcode;
    ubyte[1] SenderHardwareAddress;
}

struct IGMP_HEADER
{
union
    {
struct
        {
            ubyte _bitfield214;
        }
        ubyte VersionType;
    }
union
    {
        ubyte Reserved;
        ubyte MaxRespTime;
        ubyte Code;
    }
    ushort  Checksum;
    in_addr MulticastAddress;
}

struct IGMPV3_QUERY_HEADER
{
    ubyte   Type;
union
    {
        ubyte MaxRespCode;
struct
        {
            ubyte _bitfield215;
        }
    }
    ushort  Checksum;
    in_addr MulticastAddress;
    ubyte   _bitfield216;
union
    {
        ubyte QueriersQueryInterfaceCode;
struct
        {
            ubyte _bitfield217;
        }
    }
    ushort  SourceCount;
}

struct IGMPV3_REPORT_RECORD_HEADER
{
    ubyte   Type;
    ubyte   AuxillaryDataLength;
    ushort  SourceCount;
    in_addr MulticastAddress;
}

struct IGMPV3_REPORT_HEADER
{
    ubyte  Type;
    ubyte  Reserved;
    ushort Checksum;
    ushort Reserved2;
    ushort RecordCount;
}

struct IPV6_HEADER
{
union
    {
        uint VersionClassFlow;
struct
        {
            uint _bitfield218;
        }
    }
    ushort   PayloadLength;
    ubyte    NextHeader;
    ubyte    HopLimit;
    in6_addr SourceAddress;
    in6_addr DestinationAddress;
}

struct IPV6_FRAGMENT_HEADER
{
    ubyte NextHeader;
    ubyte Reserved;
union
    {
struct
        {
            ushort _bitfield219;
        }
        ushort OffsetAndFlags;
    }
    uint  Id;
}

struct IPV6_EXTENSION_HEADER
{
    ubyte NextHeader;
    ubyte Length;
}

struct IPV6_OPTION_HEADER
{
    ubyte Type;
    ubyte DataLength;
}

struct IPV6_OPTION_JUMBOGRAM
{
    IPV6_OPTION_HEADER Header;
    ubyte[4]           JumbogramLength;
}

struct IPV6_OPTION_ROUTER_ALERT
{
    IPV6_OPTION_HEADER Header;
    ubyte[2]           Value;
}

struct IPV6_ROUTING_HEADER
{
    ubyte    NextHeader;
    ubyte    Length;
    ubyte    RoutingType;
    ubyte    SegmentsLeft;
    ubyte[4] Reserved;
}

struct nd_router_solicit
{
    ICMP_MESSAGE nd_rs_hdr;
}

struct nd_router_advert
{
    ICMP_MESSAGE nd_ra_hdr;
    uint         nd_ra_reachable;
    uint         nd_ra_retransmit;
}

union IPV6_ROUTER_ADVERTISEMENT_FLAGS
{
struct
    {
        ubyte _bitfield220;
    }
    ubyte Value;
}

struct nd_neighbor_solicit
{
    ICMP_MESSAGE nd_ns_hdr;
    in6_addr     nd_ns_target;
}

struct nd_neighbor_advert
{
    ICMP_MESSAGE nd_na_hdr;
    in6_addr     nd_na_target;
}

union IPV6_NEIGHBOR_ADVERTISEMENT_FLAGS
{
struct
    {
        ubyte    _bitfield221;
        ubyte[3] Reserved2;
    }
    uint Value;
}

struct nd_redirect
{
    ICMP_MESSAGE nd_rd_hdr;
    in6_addr     nd_rd_target;
    in6_addr     nd_rd_dst;
}

struct nd_opt_hdr
{
    ubyte nd_opt_type;
    ubyte nd_opt_len;
}

struct nd_opt_prefix_info
{
    ubyte    nd_opt_pi_type;
    ubyte    nd_opt_pi_len;
    ubyte    nd_opt_pi_prefix_len;
union
    {
        ubyte nd_opt_pi_flags_reserved;
struct Flags
        {
            ubyte _bitfield222;
        }
    }
    uint     nd_opt_pi_valid_time;
    uint     nd_opt_pi_preferred_time;
union
    {
        uint nd_opt_pi_reserved2;
struct
        {
            ubyte[3] nd_opt_pi_reserved3;
            ubyte    nd_opt_pi_site_prefix_len;
        }
    }
    in6_addr nd_opt_pi_prefix;
}

struct nd_opt_rd_hdr
{
    ubyte  nd_opt_rh_type;
    ubyte  nd_opt_rh_len;
    ushort nd_opt_rh_reserved1;
    uint   nd_opt_rh_reserved2;
}

struct nd_opt_mtu
{
    ubyte  nd_opt_mtu_type;
    ubyte  nd_opt_mtu_len;
    ushort nd_opt_mtu_reserved;
    uint   nd_opt_mtu_mtu;
}

struct nd_opt_route_info
{
    ubyte    nd_opt_ri_type;
    ubyte    nd_opt_ri_len;
    ubyte    nd_opt_ri_prefix_len;
union
    {
        ubyte nd_opt_ri_flags_reserved;
struct Flags
        {
            ubyte _bitfield223;
        }
    }
    uint     nd_opt_ri_route_lifetime;
    in6_addr nd_opt_ri_prefix;
}

struct nd_opt_rdnss
{
    ubyte  nd_opt_rdnss_type;
    ubyte  nd_opt_rdnss_len;
    ushort nd_opt_rdnss_reserved;
    uint   nd_opt_rdnss_lifetime;
}

struct nd_opt_dnssl
{
    ubyte  nd_opt_dnssl_type;
    ubyte  nd_opt_dnssl_len;
    ushort nd_opt_dnssl_reserved;
    uint   nd_opt_dnssl_lifetime;
}

struct MLD_HEADER
{
    ICMP_HEADER IcmpHeader;
    ushort      MaxRespTime;
    ushort      Reserved;
    in6_addr    MulticastAddress;
}

struct MLDV2_QUERY_HEADER
{
    ICMP_HEADER IcmpHeader;
union
    {
        ushort MaxRespCode;
struct
        {
            ushort _bitfield224;
        }
    }
    ushort      Reserved;
    in6_addr    MulticastAddress;
    ubyte       _bitfield225;
union
    {
        ubyte QueriersQueryInterfaceCode;
struct
        {
            ubyte _bitfield226;
        }
    }
    ushort      SourceCount;
}

struct MLDV2_REPORT_RECORD_HEADER
{
    ubyte    Type;
    ubyte    AuxillaryDataLength;
    ushort   SourceCount;
    in6_addr MulticastAddress;
}

struct MLDV2_REPORT_HEADER
{
    ICMP_HEADER IcmpHeader;
    ushort      Reserved;
    ushort      RecordCount;
}

struct tcp_hdr
{
align (1):
    ushort th_sport;
    ushort th_dport;
    uint   th_seq;
    uint   th_ack;
    ubyte  _bitfield227;
    ubyte  th_flags;
    ushort th_win;
    ushort th_sum;
    ushort th_urp;
}

struct tcp_opt_mss
{
align (1):
    ubyte  Kind;
    ubyte  Length;
    ushort Mss;
}

struct tcp_opt_ws
{
    ubyte Kind;
    ubyte Length;
    ubyte ShiftCnt;
}

struct tcp_opt_sack_permitted
{
    ubyte Kind;
    ubyte Length;
}

struct tcp_opt_sack
{
    ubyte Kind;
    ubyte Length;
struct Block
    {
    align (1):
        uint Left;
        uint Right;
    }
}

struct tcp_opt_ts
{
align (1):
    ubyte Kind;
    ubyte Length;
    uint  Val;
    uint  EcR;
}

struct tcp_opt_unknown
{
    ubyte Kind;
    ubyte Length;
}

struct tcp_opt_fastopen
{
    ubyte    Kind;
    ubyte    Length;
    ubyte[1] Cookie;
}

struct DL_TUNNEL_ADDRESS
{
    COMPARTMENT_ID CompartmentId;
    SCOPE_ID       ScopeId;
    ubyte[1]       IpAddress;
}

struct DL_TEREDO_ADDRESS
{
    ubyte[6] Reserved;
union
    {
    align (1):
        DL_EUI64 Eui64;
struct
        {
        align (1):
            ushort  Flags;
            ushort  MappedPort;
            in_addr MappedAddress;
        }
    }
}

struct DL_TEREDO_ADDRESS_PRV
{
    ubyte[6] Reserved;
union
    {
    align (1):
        DL_EUI64 Eui64;
struct
        {
        align (1):
            ushort   Flags;
            ushort   MappedPort;
            in_addr  MappedAddress;
            in_addr  LocalAddress;
            uint     InterfaceIndex;
            ushort   LocalPort;
            DL_EUI48 DlDestination;
        }
    }
}

struct IPTLS_METADATA
{
align (1):
    ulong SequenceNumber;
}

struct NPI_MODULEID
{
    ushort            Length;
    NPI_MODULEID_TYPE Type;
union
    {
        GUID Guid;
        LUID IfLuid;
    }
}

// Functions

///The <b>FwpmFreeMemory0</b> function is used to release memory resources allocated by the Windows Filtering Platform
///(WFP) functions.
///Params:
///    p = Type: <b>void**</b> Address of the pointer to be freed.
@DllImport("fwpuclnt")
void FwpmFreeMemory0(void** p);

///The <b>FwpmEngineOpen0</b> function opens a session to the filter engine.
///Params:
///    serverName = Type: <b>const wchar_t*</b> This value must be <b>NULL</b>.
///    authnService = Type: <b>UINT32</b> Specifies the authentication service to use. Allowed services are RPC_C_AUTHN_WINNT and
///                   RPC_C_AUTHN_DEFAULT.
///    authIdentity = Type: <b>SEC_WINNT_AUTH_IDENTITY_W*</b> The authentication and authorization credentials for accessing the filter
///                   engine. This pointer is optional and can be <b>NULL</b>. If this pointer is <b>NULL</b>, the calling thread's
///                   credentials are used.
///    session = Type: [FWPM_SESSION0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_session0)*</b> Session-specific parameters
///              for the session being opened. This pointer is optional and can be <b>NULL</b>.
///    engineHandle = Type: <b>HANDLE*</b> Handle for the open session to the filter engine.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The session was started successfully. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_ALREADY_EXISTS</b></dt> <dt>0x80320009</dt> </dl> </td> <td
///    width="60%"> A session with the specified <b>sessionKey</b> is already opened. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows
///    Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to
///    communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmEngineOpen0(const(PWSTR) serverName, uint authnService, SEC_WINNT_AUTH_IDENTITY_W* authIdentity, 
                     const(FWPM_SESSION0)* session, HANDLE* engineHandle);

///The <b>FwpmEngineClose0</b> function closes a session to a filter engine.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The session was closed successfully. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl> </td>
///    <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td> <td
///    width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmEngineClose0(HANDLE engineHandle);

///The <b>FwpmEngineGetOption0</b> function retrieves a filter engine option.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    option = Type: [FWPM_ENGINE_OPTION](/windows/desktop/api/fwpmtypes/ne-fwpmtypes-fwpm_engine_option)</b> The option to be
///             retrieved.
///    value = Type: [FWP_VALUE0](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_value0)**</b> The option value. The data type
///            contained in the <i>value</i> parameter will be <b>FWP_UINT32</b>. If <i>option</i> is
///            <b>FWPM_ENGINE_COLLECT_NET_EVENTS</b>, <i>value</i> will be one of the following. <table> <tr> <th>Value</th>
///            <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0</dt> </dl> </td> <td width="60%"> Network events are not
///            being collected. </td> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td width="60%"> Network events
///            are being collected. </td> </tr> </table> If <i>option</i> is <b>FWPM_ENGINE_NET_EVENT_MATCH_ANY_KEYWORDS</b>,
///            <i>value</i> will be a bitwise combination of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
///            </tr> <tr> <td width="40%"><a id="FWPM_NET_EVENT_KEYWORD_INBOUND_MCAST"></a><a
///            id="fwpm_net_event_keyword_inbound_mcast"></a><dl> <dt><b>FWPM_NET_EVENT_KEYWORD_INBOUND_MCAST</b></dt>
///            <dt>1</dt> </dl> </td> <td width="60%"> Inbound multicast network events are being collected. </td> </tr> <tr>
///            <td width="40%"><a id="FWPM_NET_EVENT_KEYWORD_INBOUND_BCAST"></a><a
///            id="fwpm_net_event_keyword_inbound_bcast"></a><dl> <dt><b>FWPM_NET_EVENT_KEYWORD_INBOUND_BCAST</b></dt>
///            <dt>2</dt> </dl> </td> <td width="60%"> Inbound broadcast network events are not being collected. </td> </tr>
///            </table> If <i>option</i> is <b>FWPM_ENGINE_PACKET_QUEUING</b> (available only in Windows 8 and Windows Server
///            2012), <i>value</i> will be one of the following. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///            width="40%"><a id="FWPM_ENGINE_OPTION_PACKET_QUEUE_NONE_"></a><a
///            id="fwpm_engine_option_packet_queue_none_"></a><dl> <dt><b>FWPM_ENGINE_OPTION_PACKET_QUEUE_NONE </b></dt>
///            <dt>0</dt> </dl> </td> <td width="60%"> No packet queuing is enabled. </td> </tr> <tr> <td width="40%"><a
///            id="FWPM_ENGINE_OPTION_PACKET_QUEUE_INBOUND_"></a><a id="fwpm_engine_option_packet_queue_inbound_"></a><dl>
///            <dt><b>FWPM_ENGINE_OPTION_PACKET_QUEUE_INBOUND </b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Inbound packet
///            queuing is enabled. </td> </tr> <tr> <td width="40%"><a id="FWPM_ENGINE_OPTION_PACKET_QUEUE_OUTBOUND_"></a><a
///            id="fwpm_engine_option_packet_queue_outbound_"></a><dl> <dt><b>FWPM_ENGINE_OPTION_PACKET_QUEUE_OUTBOUND </b></dt>
///            <dt>2</dt> </dl> </td> <td width="60%"> Outbound packet queuing is enabled. </td> </tr> </table> If <i>option</i>
///            is <b>FWPM_ENGINE_MONITOR_IPSEC_CONNECTIONS</b> (available only in Windows 8 and Windows Server 2012),
///            <i>value</i> will be one of the following. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///            width="40%"> <dl> <dt>0</dt> </dl> </td> <td width="60%"> The IPsec Connection Monitoring feature is disabled. No
///            IPsec connection events or notifications are being logged. </td> </tr> <tr> <td width="40%"> <dl> <dt>1</dt>
///            </dl> </td> <td width="60%"> The IPsec Connection Monitoring feature is enabled. New IPsec connection events and
///            notifications are being logged. </td> </tr> </table> If <i>option</i> is
///            <b>FWPM_ENGINE_TXN_WATCHDOG_TIMEOUT_IN_MSEC</b> (available only in Windows 8 and Windows Server 2012),
///            <i>value</i> will be the time in milliseconds that specifies the maximum duration for a single WFP transaction.
///            Transactions taking longer than this duration will trigger a watchdog event. The <b>FWPM_ENGINE_NAME_CACHE</b>
///            option is reserved for internal use.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The option was retrieved successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmEngineGetOption0(HANDLE engineHandle, FWPM_ENGINE_OPTION option, FWP_VALUE0** value);

///The <b>FwpmEngineSetOption0</b> function changes the filter engine settings.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    option = Type: [FWPM_ENGINE_OPTION](/windows/desktop/api/fwpmtypes/ne-fwpmtypes-fwpm_engine_option)</b> The option to be
///             set.
///    newValue = Type: [FWP_VALUE0](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_value0)*</b> The new option value. The data type
///               contained in the <i>newValue</i> parameter should be <b>FWP_UINT32</b>. When <i>option</i> is
///               <b>FWPM_ENGINE_COLLECT_NET_EVENTS</b>, <i>newValue</i> should be one of the following. <table> <tr>
///               <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0</dt> </dl> </td> <td width="60%"> Do not
///               collect network events. </td> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td width="60%"> Collect
///               network events. This is the default setting. </td> </tr> </table> When <i>option</i> is
///               <b>FWPM_ENGINE_NET_EVENT_MATCH_ANY_KEYWORDS</b>, <i>newValue</i> should be either 0 (zero) or a bitwise
///               combination of the following values. <div class="alert"><b>Note</b> If <i>newValue</i> is 0 the collection of
///               inbound multicast and broadcast events is disabled. This is the default setting.</div> <div> </div> <table> <tr>
///               <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="FWPM_NET_EVENT_KEYWORD_INBOUND_MCAST"></a><a
///               id="fwpm_net_event_keyword_inbound_mcast"></a><dl> <dt><b>FWPM_NET_EVENT_KEYWORD_INBOUND_MCAST</b></dt>
///               <dt>1</dt> </dl> </td> <td width="60%"> Collect inbound multicast network events. </td> </tr> <tr> <td
///               width="40%"><a id="FWPM_NET_EVENT_KEYWORD_INBOUND_BCAST"></a><a
///               id="fwpm_net_event_keyword_inbound_bcast"></a><dl> <dt><b>FWPM_NET_EVENT_KEYWORD_INBOUND_BCAST</b></dt>
///               <dt>2</dt> </dl> </td> <td width="60%"> Collect inbound broadcast network events. </td> </tr> </table> When
///               <i>option</i> is <b>FWPM_ENGINE_PACKET_QUEUING</b> (available only in Windows 8 and Windows Server 2012),
///               <i>newValue</i> should be one of the following. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///               width="40%"><a id="FWPM_ENGINE_OPTION_PACKET_QUEUE_NONE_"></a><a
///               id="fwpm_engine_option_packet_queue_none_"></a><dl> <dt><b>FWPM_ENGINE_OPTION_PACKET_QUEUE_NONE </b></dt>
///               <dt>0</dt> </dl> </td> <td width="60%"> Do not enable packet queuing. </td> </tr> <tr> <td width="40%"><a
///               id="FWPM_ENGINE_OPTION_PACKET_QUEUE_INBOUND_"></a><a id="fwpm_engine_option_packet_queue_inbound_"></a><dl>
///               <dt><b>FWPM_ENGINE_OPTION_PACKET_QUEUE_INBOUND </b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Enable inbound
///               packet queuing. </td> </tr> <tr> <td width="40%"><a id="FWPM_ENGINE_OPTION_PACKET_QUEUE_OUTBOUND_"></a><a
///               id="fwpm_engine_option_packet_queue_outbound_"></a><dl> <dt><b>FWPM_ENGINE_OPTION_PACKET_QUEUE_OUTBOUND </b></dt>
///               <dt>2</dt> </dl> </td> <td width="60%"> Enable outbound packet queuing. </td> </tr> </table> When <i>option</i>
///               is <b>FWPM_ENGINE_MONITOR_IPSEC_CONNECTIONS</b> (available only in Windows 8 and Windows Server 2012),
///               <i>newValue</i> should be the following. (<b>FwpmEngineSetOption0</b> may be used to enable connections, but will
///               fail with <b>FWP_E_STILL_ON ERROR</b> when attempting to disable it.) <table> <tr> <th>Value</th>
///               <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td width="60%"> The IPsec Connection
///               Monitoring feature will be enabled. New IPsec connection events will be logged as well as notifications sent.
///               </td> </tr> </table> When <i>option</i> is <b>FWPM_ENGINE_TXN_WATCHDOG_TIMEOUT_IN_MSEC</b> (available only in
///               Windows 8 and Windows Server 2012), <i>newValue</i> should be the time in milliseconds that specifies the maximum
///               duration for a single WFP transaction. Transactions taking longer than this duration will trigger a watchdog
///               event. The <b>FWPM_ENGINE_NAME_CACHE</b> option is reserved for internal use.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The option was set successfully. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl> </td>
///    <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td> <td
///    width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmEngineSetOption0(HANDLE engineHandle, FWPM_ENGINE_OPTION option, const(FWP_VALUE0)* newValue);

///The <b>FwpmEngineGetSecurityInfo0</b> function retrieves a copy of the security descriptor for the filter engine.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    securityInfo = Type: <b>SECURITY_INFORMATION</b> The type of security information to retrieve.
///    sidOwner = Type: <b>PSID*</b> The owner security identifier (SID) in the returned security descriptor.
///    sidGroup = Type: <b>PSID*</b> The primary group security identifier (SID) in the returned security descriptor.
///    dacl = Type: <b>PACL*</b> The discretionary access control list (DACL) in the returned security descriptor.
///    sacl = Type: <b>PACL*</b> The system access control list (SACL) in the returned security descriptor.
///    securityDescriptor = Type: <b>PSECURITY_DESCRIPTOR*</b> The returned security descriptor.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The security descriptor was retrieved
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmEngineGetSecurityInfo0(HANDLE engineHandle, uint securityInfo, void** sidOwner, void** sidGroup, 
                                ACL** dacl, ACL** sacl, void** securityDescriptor);

///The <b>FwpmEngineSetSecurityInfo0</b> function sets specified security information in the security descriptor of the
///filter engine.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    securityInfo = Type: <b>SECURITY_INFORMATION</b> The type of security information to set.
///    sidOwner = Type: <b>const SID*</b> The owner's security identifier (SID) to be set in the security descriptor.
///    sidGroup = Type: <b>const SID*</b> The group's SID to be set in the security descriptor.
///    dacl = Type: <b>const ACL*</b> The discretionary access control list (DACL) to be set in the security descriptor.
///    sacl = Type: <b>const ACL*</b> The system access control list (SACL) to be set in the security descriptor.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The security descriptor was set
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmEngineSetSecurityInfo0(HANDLE engineHandle, uint securityInfo, const(SID)* sidOwner, const(SID)* sidGroup, 
                                const(ACL)* dacl, const(ACL)* sacl);

///The <b>FwpmSessionCreateEnumHandle0</b> function creates a handle used to enumerate a set of session objects.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumTemplate = Type: [FWPM_SESSION_ENUM_TEMPLATE0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_session_enum_template0)*</b>
///                   Template to selectively restrict the enumeration.
///    enumHandle = Type: <b>HANDLE*</b> Handle for filter enumeration.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The enumerator was created successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmSessionCreateEnumHandle0(HANDLE engineHandle, const(FWPM_SESSION_ENUM_TEMPLATE0)* enumTemplate, 
                                  HANDLE* enumHandle);

///The <b>FwpmSessionEnum0</b> function returns the next page of results from the session enumerator.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle for a session enumeration created by a call to FwpmSessionCreateEnumHandle0.
///    numEntriesRequested = Type: <b>UINT32</b> The number of session entries requested.
///    entries = Type: [FWPM_SESSION0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_session0)***</b> Addresses of the
///              enumeration entries.
///    numEntriesReturned = Type: <b>UINT32*</b> The number of session objects returned.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The sessions were enumerated successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmSessionEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, FWPM_SESSION0*** entries, 
                      uint* numEntriesReturned);

///The <b>FwpmSessionDestroyEnumHandle0</b> function frees a handle returned by FwpmSessionCreateEnumHandle0.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle for a session enumeration created by a call to FwpmSessionCreateEnumHandle0.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The enumerator was successfully deleted.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmSessionDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

///The <b>FwpmTransactionBegin0</b> function begins an explicit transaction within the current session.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    flags = Type: <b>UINT32</b> Possible values: <table> <tr> <th>Transaction flag</th> <th>Meaning</th> </tr> <tr> <td
///            width="40%"> <dl> <dt>0</dt> </dl> </td> <td width="60%"> Begin read/write transaction. </td> </tr> <tr> <td
///            width="40%"><a id="FWPM_TXN_READ_ONLY"></a><a id="fwpm_txn_read_only"></a><dl> <dt><b>FWPM_TXN_READ_ONLY</b></dt>
///            </dl> </td> <td width="60%"> Begin read-only transaction. </td> </tr> </table>
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The transaction was started successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmTransactionBegin0(HANDLE engineHandle, uint flags);

///The <b>FwpmTransactionCommit0</b> function commits the current transaction within the current session.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The transaction was committed successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmTransactionCommit0(HANDLE engineHandle);

///The <b>FwpmTransactionAbort0</b> function causes the current transaction within the current session to abort and
///rollback.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The transaction was aborted. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl> </td> <td
///    width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td> <td
///    width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmTransactionAbort0(HANDLE engineHandle);

///The <b>FwpmProviderAdd0</b> function adds a new provider to the system.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    provider = Type: [FWPM_PROVIDER0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_provider0)*</b> The provider object to be
///               added.
///    sd = Type: <b>PSECURITY_DESCRIPTOR</b> Security information for the provider object.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The provider was successfully added. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl> </td>
///    <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td> <td
///    width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderAdd0(HANDLE engineHandle, const(FWPM_PROVIDER0)* provider, void* sd);

///The <b>FwpmProviderDeleteByKey0</b> function removes a provider from the system.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    key = Type: <b>const GUID*</b> Unique identifier of the object being removed from the system. This is the same GUID
///          that was specified when the application called FwpmProviderAdd0.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The provider was successfully deleted.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderDeleteByKey0(HANDLE engineHandle, const(GUID)* key);

///The <b>FwpmProviderGetByKey0</b> function retrieves a provider.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    key = Type: <b>const GUID*</b> A runtime identifier for the desired object. This is the same GUID that was specified
///          when the application called FwpmProviderAdd0.
///    provider = Type: [FWPM_PROVIDER0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_provider0)**</b> The provider
///               information.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The provider was retrieved successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderGetByKey0(HANDLE engineHandle, const(GUID)* key, FWPM_PROVIDER0** provider);

///The <b>FwpmProviderCreateEnumHandle0</b> function creates a handle used to enumerate a set of providers.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumTemplate = Type:
///                   [FWPM_PROVIDER_ENUM_TEMPLATE0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_provider_enum_template0)*</b>
///                   Template to selectively restrict the enumeration.
///    enumHandle = Type: <b>HANDLE*</b> Handle for provider enumeration.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The enumerator was created successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderCreateEnumHandle0(HANDLE engineHandle, const(FWPM_PROVIDER_ENUM_TEMPLATE0)* enumTemplate, 
                                   HANDLE* enumHandle);

///The <b>FwpmProviderEnum0</b> function returns the next page of results from the provider enumerator.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle for a provider enumeration created by a call to FwpmProviderCreateEnumHandle0.
///    numEntriesRequested = Type: <b>UINT32</b> The number of provider entries requested.
///    entries = Type: [FWPM_PROVIDER0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_provider0)***</b> Addresses of the
///              enumeration entries.
///    numEntriesReturned = Type: <b>UINT32*</b> The number of provider objects returned.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The providers were enumerated successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, FWPM_PROVIDER0*** entries, 
                       uint* numEntriesReturned);

///The <b>FwpmProviderDestroyEnumHandle0</b> function frees a handle returned by FwpmProviderCreateEnumHandle0.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle of a provider enumeration created by a call to FwpmProviderCreateEnumHandle0.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The enumerator was successfully deleted.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

///The <b>FwpmProviderGetSecurityInfoByKey0</b> function retrieves a copy of the security descriptor for a provider
///object.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    key = Type: <b>const GUID*</b> Unique key of the object of interest. This must be the same GUID that was specified when
///          the application called FwpmProviderAdd0 for this object.
///    securityInfo = Type: <b>SECURITY_INFORMATION</b> The type of security information to retrieve.
///    sidOwner = Type: <b>PSID*</b> The owner security identifier (SID) in the returned security descriptor.
///    sidGroup = Type: <b>PSID*</b> The primary group security identifier (SID) in the returned security descriptor.
///    dacl = Type: <b>PACL*</b> The discretionary access control list (DACL) in the returned security descriptor.
///    sacl = Type: <b>PACL*</b> The system access control list (SACL) in the returned security descriptor.
///    securityDescriptor = Type: <b>PSECURITY_DESCRIPTOR*</b> The returned security descriptor.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The security descriptor was retrieved
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderGetSecurityInfoByKey0(HANDLE engineHandle, const(GUID)* key, uint securityInfo, void** sidOwner, 
                                       void** sidGroup, ACL** dacl, ACL** sacl, void** securityDescriptor);

///The <b>FwpmProviderSetSecurityInfoByKey0</b> function sets specified security information in the security descriptor
///of a provider object.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    key = Type: <b>const GUID*</b> Unique identifier of the provider. This is the same GUID that was specified when the
///          application called FwpmProviderAdd0 for this object.
///    securityInfo = Type: <b>SECURITY_INFORMATION</b> The type of security information to set.
///    sidOwner = Type: <b>const SID*</b> The owner's security identifier (SID) to be set in the security descriptor.
///    sidGroup = Type: <b>const SID*</b> The group's SID to be set in the security descriptor.
///    dacl = Type: <b>const ACL*</b> The discretionary access control list (DACL) to be set in the security descriptor.
///    sacl = Type: <b>const ACL*</b> The system access control list (SACL) to be set in the security descriptor.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The security descriptor was set
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderSetSecurityInfoByKey0(HANDLE engineHandle, const(GUID)* key, uint securityInfo, 
                                       const(SID)* sidOwner, const(SID)* sidGroup, const(ACL)* dacl, 
                                       const(ACL)* sacl);

///The <b>FwpmProviderSubscribeChanges0</b> function is used to request the delivery of notifications regarding changes
///in a particular provider.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    subscription = Type: [FWPM_PROVIDER_SUBSCRIPTION0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_provider_subscription0)*</b>
///                   The notifications to be delivered.
///    callback = Type: <b>FWPM_PROVIDER_CHANGE_CALLBACK0</b> Function pointer that will be invoked when a notification is ready
///               for delivery.
///    context = Type: <b>void*</b> Optional context pointer. This pointer is passed to the <i>callback</i> function along with
///              details of the change.
///    changeHandle = Type: <b>HANDLE*</b> Handle to the newly created subscription.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The subscription was created successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderSubscribeChanges0(HANDLE engineHandle, const(FWPM_PROVIDER_SUBSCRIPTION0)* subscription, 
                                   FWPM_PROVIDER_CHANGE_CALLBACK0 callback, void* context, HANDLE* changeHandle);

///The <b>FwpmProviderUnsubscribeChanges0</b> function is used to cancel a provider change subscription and stop
///receiving change notifications.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    changeHandle = Type: <b>HANDLE</b> Handle of the subscribed change notification. This is the handle returned by the call to
///                   FwpmProviderSubscribeChanges0.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The subscription was deleted successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderUnsubscribeChanges0(HANDLE engineHandle, HANDLE changeHandle);

///The <b>FwpmProviderSubscriptionsGet0</b> function retrieves an array of all the current provider change notification
///subscriptions.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    entries = Type:
///              [FWPM_PROVIDER_SUBSCRIPTION0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_provider_subscription0)***</b> The
///              current provider change notification subscriptions.
///    numEntries = Type: <b>UINT32*</b> Pointer to an <b>UINT32</b> variable that will contain the number of entries returned.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The subscriptions were retrieved
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderSubscriptionsGet0(HANDLE engineHandle, FWPM_PROVIDER_SUBSCRIPTION0*** entries, uint* numEntries);

///The <b>FwpmProviderContextAdd0</b> function adds a new provider context to the system.<div class="alert"><b>Note</b>
///<b>FwpmProviderContextAdd0</b> is the specific implementation of FwpmProviderContextAdd used in Windows Vista. See
///WFP Version-Independent Names and Targeting Specific Versions of Windows for more information. For Windows 7,
///FwpmProviderContextAdd1 is available. For Windows 8, FwpmProviderContextAdd2 is available. </div> <div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    providerContext = Type: [FWPM_PROVIDER_CONTEXT0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_provider_context0)*</b> The
///                      provider context object to be added.
///    sd = Type: <b>PSECURITY_DESCRIPTOR</b> Security information associated with the provider context object.
///    id = Type: <b>UINT64*</b> Pointer to a variable that receives a runtime identifier for this provider context.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The provider context was successfully
///    added. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> <dt>0x32</dt> </dl> </td> <td
///    width="60%"> The
///    [FWPM_IPSEC_IKE_MM_CONTEXT](/windows/desktop/api/fwpmtypes/ne-fwpmtypes-fwpm_provider_context_type)and the
///    [IKEEXT_IPV6_CGA](/windows/desktop/api/iketypes/ne-iketypes-ikeext_authentication_method_type) authentication
///    method in the <b>authenticationMethods</b> array, but cryptographically generated address (CGA) is not enabled in
///    the registry. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderContextAdd0(HANDLE engineHandle, const(FWPM_PROVIDER_CONTEXT0)* providerContext, void* sd, 
                             ulong* id);

///The <b>FwpmProviderContextAdd1</b> function adds a new provider context to the system.<div class="alert"><b>Note</b>
///<b>FwpmProviderContextAdd1</b> is the specific implementation of FwpmProviderContextAdd used in Windows 7. See WFP
///Version-Independent Names and Targeting Specific Versions of Windows for more information. For Windows 8,
///FwpmProviderContextAdd2 is available. For Windows Vista, FwpmProviderContextAdd0 is available.</div> <div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    providerContext = Type: [FWPM_PROVIDER_CONTEXT1](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_provider_context1)*</b> The
///                      provider context object to be added.
///    sd = Type: <b>PSECURITY_DESCRIPTOR</b> Security information associated with the provider context object.
///    id = Type: <b>UINT64*</b> Pointer to a variable that receives a runtime identifier for this provider context.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The provider context was successfully
///    added. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> <dt>0x32</dt> </dl> </td> <td
///    width="60%"> The [IKEEXT_IPV6_CGA](/windows/desktop/api/iketypes/ne-iketypes-ikeext_authentication_method_type)
///    authentication method in the <b>authenticationMethods</b> array, but cryptographically generated address (CGA) is
///    not enabled in the registry. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderContextAdd1(HANDLE engineHandle, const(FWPM_PROVIDER_CONTEXT1)* providerContext, void* sd, 
                             ulong* id);

///The <b>FwpmProviderContextAdd2</b> function adds a new provider context to the system. <div class="alert"><b>Note</b>
///<b>FwpmProviderContextAdd2</b> is the specific implementation of FwpmProviderContextAdd used in Windows 8. See WFP
///Version-Independent Names and Targeting Specific Versions of Windows for more information. For Windows 7,
///FwpmProviderContextAdd1 is available. For Windows Vista, FwpmProviderContextAdd0 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    providerContext = Type: [FWPM_PROVIDER_CONTEXT2](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_provider_context2)*</b> The
///                      provider context object to be added.
///    sd = Type: <b>PSECURITY_DESCRIPTOR</b> Security information associated with the provider context object.
///    id = Type: <b>UINT64*</b> Pointer to a variable that receives a runtime identifier for this provider context.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The provider context was successfully
///    added. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> <dt>0x32</dt> </dl> </td> <td
///    width="60%"> The
///    [FWPM_IPSEC_IKE_MM_CONTEXT](/windows/desktop/api/fwpmtypes/ne-fwpmtypes-fwpm_provider_context_type)and the
///    [IKEEXT_IPV6_CGA](/windows/desktop/api/iketypes/ne-iketypes-ikeext_authentication_method_type) authentication
///    method in the <b>authenticationMethods</b> array, but cryptographically generated address (CGA) is not enabled in
///    the registry. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderContextAdd2(HANDLE engineHandle, const(FWPM_PROVIDER_CONTEXT2)* providerContext, void* sd, 
                             ulong* id);

@DllImport("fwpuclnt")
uint FwpmProviderContextAdd3(HANDLE engineHandle, const(FWPM_PROVIDER_CONTEXT3_)* providerContext, void* sd, 
                             ulong* id);

///The <b>FwpmProviderContextDeleteById0</b> function removes a provider context from the system .
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    id = Type: <b>UINT64</b> A runtime identifier for the object being removed from the system. This is the runtime
///         identifier that was received from the system when the application called FwpmProviderContextAdd0 for this object.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The provider context was successfully
///    deleted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderContextDeleteById0(HANDLE engineHandle, ulong id);

///The <b>FwpmProviderContextDeleteByKey0</b> function removes a provider context from the system.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    key = Type: <b>const GUID*</b> Unique identifier of the object being removed from the system. This is a pointer to the
///          same GUID that was specified when the application called FwpmProviderContextAdd0 for this object.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The provider context was successfully
///    deleted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderContextDeleteByKey0(HANDLE engineHandle, const(GUID)* key);

///The <b>FwpmProviderContextGetById0</b> function retrieves a provider context. <div class="alert"><b>Note</b>
///<b>FwpmProviderContextGetById0</b> is the specific implementation of FwpmProviderContextGetById used in Windows
///Vista. See WFP Version-Independent Names and Targeting Specific Versions of Windows for more information. For Windows
///7, FwpmProviderContextGetById1 is available. For Windows 8, FwpmProviderContextGetById2 is available.</div><div>
///</div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    id = Type: <b>UINT64</b> A run-time identifier for the desired object. This must be the run-time identifier that was
///         received from the system when the application called FwpmProviderContextAdd0 for this object.
///    providerContext = Type: [FWPM_PROVIDER_CONTEXT0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_provider_context0)**</b> The
///                      provider context information.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The provider context was retrieved
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderContextGetById0(HANDLE engineHandle, ulong id, FWPM_PROVIDER_CONTEXT0** providerContext);

///The <b>FwpmProviderContextGetById1</b> function retrieves a provider context. <div class="alert"><b>Note</b>
///<b>FwpmProviderContextGetById1</b> is the specific implementation of FwpmProviderContextGetById used in Windows 7.
///See WFP Version-Independent Names and Targeting Specific Versions of Windows for more information. For Windows 8,
///FwpmProviderContextGetById2 is available. For Windows Vista, FwpmProviderContextGetById0 is available.</div><div>
///</div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    id = Type: <b>UINT64</b> A run-time identifier for the desired object. This must be the run-time identifier that was
///         received from the system when the application called FwpmProviderContextAdd1 for this object.
///    providerContext = Type: [FWPM_PROVIDER_CONTEXT1](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_provider_context1)**</b> The
///                      provider context information.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The provider context was retrieved
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderContextGetById1(HANDLE engineHandle, ulong id, FWPM_PROVIDER_CONTEXT1** providerContext);

///The <b>FwpmProviderContextGetById2</b> function retrieves a provider context. <div class="alert"><b>Note</b>
///<b>FwpmProviderContextGetById2</b> is the specific implementation of FwpmProviderContextGetById used in Windows 8.
///See WFP Version-Independent Names and Targeting Specific Versions of Windows for more information. For Windows 7,
///FwpmProviderContextGetById1 is available. For Windows Vista, FwpmProviderContextGetById0 is available.</div><div>
///</div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    id = Type: <b>UINT64</b> A run-time identifier for the desired object. This must be the run-time identifier that was
///         received from the system when the application called FwpmProviderContextAdd2 for this object.
///    providerContext = Type: [FWPM_PROVIDER_CONTEXT2](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_provider_context2)**</b> The
///                      provider context information.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The provider context was retrieved
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderContextGetById2(HANDLE engineHandle, ulong id, FWPM_PROVIDER_CONTEXT2** providerContext);

@DllImport("fwpuclnt")
uint FwpmProviderContextGetById3(HANDLE engineHandle, ulong id, FWPM_PROVIDER_CONTEXT3_** providerContext);

///The <b>FwpmProviderContextGetByKey0</b> function retrieves a provider context.<div class="alert"><b>Note</b>
///<b>FwpmProviderContextGetByKey0</b> is the specific implementation of FwpmProviderContextGetByKey used in Windows
///Vista. See WFP Version-Independent Names and Targeting Specific Versions of Windows for more information. For Windows
///7, FwpmProviderContextGetByKey1 is available. For Windows 8, FwpmProviderContextGetByKey2 is available. </div> <div>
///</div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    key = Type: <b>const GUID*</b> Pointer to a GUID that uniquely identifies the provider context. This is a pointer to
///          the same GUID that was specified when the application called FwpmProviderContextAdd0 for this object.
///    providerContext = Type: [FWPM_PROVIDER_CONTEXT0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_provider_context0)**</b> The
///                      provider context information.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The provider context was retrieved
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderContextGetByKey0(HANDLE engineHandle, const(GUID)* key, FWPM_PROVIDER_CONTEXT0** providerContext);

///The <b>FwpmProviderContextGetByKey1</b> function retrieves a provider context.<div class="alert"><b>Note</b>
///<b>FwpmProviderContextGetByKey1</b> is the specific implementation of FwpmProviderContextGetByKey used in Windows 7.
///See WFP Version-Independent Names and Targeting Specific Versions of Windows for more information. For Windows 8,
///FwpmProviderContextGetByKey2 is available. For Windows Vista, FwpmProviderContextGetByKey0 is available.</div> <div>
///</div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    key = Type: <b>const GUID*</b> Pointer to a GUID that uniquely identifies the provider context. This is a pointer to
///          the same GUID that was specified when the application called FwpmProviderContextAdd1 for this object.
///    providerContext = Type: [FWPM_PROVIDER_CONTEXT1](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_provider_context1)**</b> The
///                      provider context information.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The provider context was retrieved
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderContextGetByKey1(HANDLE engineHandle, const(GUID)* key, FWPM_PROVIDER_CONTEXT1** providerContext);

///The <b>FwpmProviderContextGetByKey2</b> function retrieves a provider context. <div class="alert"><b>Note</b>
///<b>FwpmProviderContextGetByKey2</b> is the specific implementation of FwpmProviderContextGetByKey used in Windows 8.
///See WFP Version-Independent Names and Targeting Specific Versions of Windows for more information. For Windows 7,
///FwpmProviderContextGetByKey1 is available. For Windows Vista, FwpmProviderContextGetByKey0 is available.</div><div>
///</div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    key = Type: <b>const GUID*</b> Pointer to a GUID that uniquely identifies the provider context. This is a pointer to
///          the same GUID that was specified when the application called FwpmProviderContextAdd2 for this object.
///    providerContext = Type: [FWPM_PROVIDER_CONTEXT2](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_provider_context2)**</b> The
///                      provider context information.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The provider context was retrieved
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderContextGetByKey2(HANDLE engineHandle, const(GUID)* key, FWPM_PROVIDER_CONTEXT2** providerContext);

@DllImport("fwpuclnt")
uint FwpmProviderContextGetByKey3(HANDLE engineHandle, const(GUID)* key, FWPM_PROVIDER_CONTEXT3_** providerContext);

///The <b>FwpmProviderContextCreateEnumHandle0</b> function creates a handle used to enumerate a set of provider
///contexts.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumTemplate = Type: <b>const FWPM_PROVIDER_CONTEXT_ENUM_TEMPLATE0*</b> Template to selectively restrict the enumeration.
///    enumHandle = Type: <b>HANDLE*</b> Handle for provider context enumeration.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The enumerator was created successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderContextCreateEnumHandle0(HANDLE engineHandle, 
                                          const(FWPM_PROVIDER_CONTEXT_ENUM_TEMPLATE0)* enumTemplate, 
                                          HANDLE* enumHandle);

///The <b>FwpmProviderContextEnum0</b> function returns the next page of results from the provider context enumerator.
///<div class="alert"><b>Note</b> <b>FwpmProviderContextEnum0</b> is the specific implementation of
///FwpmProviderContextEnum used in Windows Vista. See WFP Version-Independent Names and Targeting Specific Versions of
///Windows for more information. For Windows 7, FwpmProviderContextEnum1 is available. For Windows 8,
///FwpmProviderContextEnum2 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle for a provider context enumeration created by a call to
///                 FwpmProviderContextCreateEnumHandle0.
///    numEntriesRequested = Type: <b>UINT32</b> The number of provider context objects requested.
///    entries = Type: [FWPM_PROVIDER_CONTEXT0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_provider_context0)***</b> The
///              returned provider context objects.
///    numEntriesReturned = Type: <b>UINT32*</b> The number of provider context objects returned.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The provider contexts were enumerated
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderContextEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, 
                              FWPM_PROVIDER_CONTEXT0*** entries, uint* numEntriesReturned);

///The <b>FwpmProviderContextEnum1</b> function returns the next page of results from the provider context enumerator.
///<div class="alert"><b>Note</b> <b>FwpmProviderContextEnum1</b> is the specific implementation of
///FwpmProviderContextEnum used in Windows 7. See WFP Version-Independent Names and Targeting Specific Versions of
///Windows for more information. For Windows 8, FwpmProviderContextEnum2 is available. For Windows Vista,
///FwpmProviderContextEnum0 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle for a provider context enumeration created by a call to
///                 FwpmProviderContextCreateEnumHandle0.
///    numEntriesRequested = Type: <b>UINT32</b> The number of provider context objects requested.
///    entries = Type: [FWPM_PROVIDER_CONTEXT1](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_provider_context1)***</b> The
///              returned provider context objects.
///    numEntriesReturned = Type: <b>UINT32*</b> The number of provider context objects returned.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The provider contexts were enumerated
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderContextEnum1(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, 
                              FWPM_PROVIDER_CONTEXT1*** entries, uint* numEntriesReturned);

///The <b>FwpmProviderContextEnum2</b> function returns the next page of results from the provider context enumerator.
///<div class="alert"><b>Note</b> <b>FwpmProviderContextEnum2</b> is the specific implementation of
///FwpmProviderContextEnum used in Windows 8. See WFP Version-Independent Names and Targeting Specific Versions of
///Windows for more information. For Windows 7, FwpmProviderContextEnum1 is available. For Windows Vista,
///FwpmProviderContextEnum0 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle for a provider context enumeration created by a call to
///                 FwpmProviderContextCreateEnumHandle0.
///    numEntriesRequested = Type: <b>UINT32</b> Number of provider context objects requested.
///    entries = Type: [FWPM_PROVIDER_CONTEXT2](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_provider_context2)***</b> The
///              returned provider context objects.
///    numEntriesReturned = Type: <b>UINT32*</b> The number of provider context objects returned.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The provider contexts were enumerated
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderContextEnum2(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, 
                              FWPM_PROVIDER_CONTEXT2*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt")
uint FwpmProviderContextEnum3(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, 
                              FWPM_PROVIDER_CONTEXT3_*** entries, uint* numEntriesReturned);

///The <b>FwpmProviderContextDestroyEnumHandle0</b> function frees a handle returned by
///FwpmProviderContextCreateEnumHandle0.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle of a provider context enumeration created by a call to
///                 FwpmProviderContextCreateEnumHandle0.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The enumerator was successfully deleted.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderContextDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

///The <b>FwpmProviderContextGetSecurityInfoByKey0</b> function retrieves a copy of the security descriptor for a
///provider context object.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    key = Type: <b>const GUID*</b> Unique identifier of the provider context. This is a pointer to the same GUID that was
///          specified when the application called FwpmProviderContextAdd0 for this object.
///    securityInfo = Type: <b>SECURITY_INFORMATION</b> The type of security information to retrieve.
///    sidOwner = Type: <b>PSID*</b> The owner security identifier (SID) in the returned security descriptor.
///    sidGroup = Type: <b>PSID*</b> The primary group security identifier (SID) in the returned security descriptor.
///    dacl = Type: <b>PACL*</b> The discretionary access control list (DACL) in the returned security descriptor.
///    sacl = Type: <b>PACL*</b> The system access control list (SACL) in the returned security descriptor.
///    securityDescriptor = Type: <b>PSECURITY_DESCRIPTOR*</b> The returned security descriptor.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The security descriptor was retrieved
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderContextGetSecurityInfoByKey0(HANDLE engineHandle, const(GUID)* key, uint securityInfo, 
                                              void** sidOwner, void** sidGroup, ACL** dacl, ACL** sacl, 
                                              void** securityDescriptor);

///The <b>FwpmProviderContextSetSecurityInfoByKey0</b> function sets specified security information in the security
///descriptor of a provider context object.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    key = Type: <b>const GUID*</b> Unique identifier of the provider context object. This is a pointer to the same GUID
///          that was specified when the application called FwpmProviderContextAdd0 for this object.
///    securityInfo = Type: <b>SECURITY_INFORMATION</b> The type of security information to set.
///    sidOwner = Type: <b>const SID*</b> The owner's security identifier (SID) to be set in the security descriptor.
///    sidGroup = Type: <b>const SID*</b> The group's SID to be set in the security descriptor.
///    dacl = Type: <b>const ACL*</b> The discretionary access control list (DACL) to be set in the security descriptor.
///    sacl = Type: <b>const ACL*</b> The system access control list (SACL) to be set in the security descriptor.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The security descriptor was set
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderContextSetSecurityInfoByKey0(HANDLE engineHandle, const(GUID)* key, uint securityInfo, 
                                              const(SID)* sidOwner, const(SID)* sidGroup, const(ACL)* dacl, 
                                              const(ACL)* sacl);

///The <b>FwpmProviderContextSubscribeChanges0</b> function is used to request the delivery of notifications regarding
///changes in a particular provider context.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    subscription = Type: <b>const FWPM_PROVIDER_CONTEXT_SUBSCRIPTION0*</b> The notifications to be delivered.
///    callback = Type: <b>FWPM_PROVIDER_CONTEXT_CHANGE_CALLBACK0</b> Function pointer that will be invoked when a notification is
///               ready for delivery.
///    context = Type: <b>void*</b> Optional context pointer. This pointer is passed to the <i>callback</i> function along with
///              details of the change.
///    changeHandle = Type: <b>HANDLE*</b> Handle to the newly created subscription.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The subscription was created successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderContextSubscribeChanges0(HANDLE engineHandle, 
                                          const(FWPM_PROVIDER_CONTEXT_SUBSCRIPTION0)* subscription, 
                                          FWPM_PROVIDER_CONTEXT_CHANGE_CALLBACK0 callback, void* context, 
                                          HANDLE* changeHandle);

///The <b>FwpmProviderContextUnsubscribeChanges0</b> function is used to cancel a provider context change subscription
///and stop receiving change notifications.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    changeHandle = Type: <b>HANDLE</b> Handle of the subscribed change notification. This is the handle returned by
///                   FwpmProviderContextSubscribeChanges0.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The subscription was deleted successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderContextUnsubscribeChanges0(HANDLE engineHandle, HANDLE changeHandle);

///The <b>FwpmProviderContextSubscriptionsGet0</b> function retrieves an array of all the current provider context
///change notification subscriptions.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    entries = Type: <b>FWPM_PROVIDER_CONTEXT_SUBSCRIPTION0***</b> The current provider context change notification
///              subscriptions.
///    numEntries = Type: <b>UINT32*</b> The number of entries returned.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The subscriptions were retrieved
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmProviderContextSubscriptionsGet0(HANDLE engineHandle, FWPM_PROVIDER_CONTEXT_SUBSCRIPTION0*** entries, 
                                          uint* numEntries);

///The <b>FwpmSubLayerAdd0</b> function adds a new sublayer to the system.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    subLayer = Type: [FWPM_SUBLAYER0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_sublayer0)*</b> The sublayer to be added.
///    sd = Type: <b>PSECURITY_DESCRIPTOR</b> Security information for the sublayer object.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The sublayer was successfully added. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl> </td>
///    <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td> <td
///    width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmSubLayerAdd0(HANDLE engineHandle, const(FWPM_SUBLAYER0)* subLayer, void* sd);

///The <b>FwpmSubLayerDeleteByKey0</b> function deletes a sublayer from the system by its key.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    key = Type: <b>const GUID*</b> Unique identifier of the sublayer to be removed from the system. This is the same GUID
///          that was specified when the application called FwpmSubLayerAdd0.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The sublayer was successfully deleted.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmSubLayerDeleteByKey0(HANDLE engineHandle, const(GUID)* key);

///The <b>FwpmSubLayerGetByKey0</b> function retrieves a sublayer by its key.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    key = Type: <b>const GUID*</b> Unique identifier of the sublayer. This is the same GUID that was specified when the
///          application called FwpmSubLayerAdd0.
///    subLayer = Type: [FWPM_SUBLAYER0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_sublayer0)**</b> The sublayer
///               information.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The sublayer was retrieved successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmSubLayerGetByKey0(HANDLE engineHandle, const(GUID)* key, FWPM_SUBLAYER0** subLayer);

///The <b>FwpmSubLayerCreateEnumHandle0</b> function creates a handle used to enumerate a set of sublayers.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumTemplate = Type:
///                   [FWPM_SUBLAYER_ENUM_TEMPLATE0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_sublayer_enum_template0)*</b>
///                   Template to selectively restrict the enumeration.
///    enumHandle = Type: <b>HANDLE*</b> Handle for sublayer enumeration.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The enumerator was created successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmSubLayerCreateEnumHandle0(HANDLE engineHandle, const(FWPM_SUBLAYER_ENUM_TEMPLATE0)* enumTemplate, 
                                   HANDLE* enumHandle);

///The <b>FwpmSubLayerEnum0</b> function returns the next page of results from the sublayer enumerator.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle for a sublayer enumeration created by a call to FwpmSubLayerCreateEnumHandle0.
///    numEntriesRequested = Type: <b>UINT32</b> The number of sublayer entries requested.
///    entries = Type: [FWPM_SUBLAYER0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_sublayer0)***</b> Addresses of the
///              enumeration entries.
///    numEntriesReturned = Type: <b>UINT32*</b> The number of sublayer objects returned.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The sublayers were enumerated successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmSubLayerEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, FWPM_SUBLAYER0*** entries, 
                       uint* numEntriesReturned);

///The <b>FwpmSubLayerDestroyEnumHandle0</b> function frees a handle returned by FwpmSubLayerCreateEnumHandle0.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle of a sublayer enumeration created by a call to FwpmSubLayerCreateEnumHandle0.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The enumerator was successfully deleted.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmSubLayerDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

///The <b>FwpmSubLayerGetSecurityInfoByKey0</b> function retrieves a copy of the security descriptor for a sublayer.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    key = Type: <b>const GUID*</b> Unique identifier of the sublayer. This must be the same GUID that was specified when
///          the application called FwpmSubLayerAdd0.
///    securityInfo = Type: <b>SECURITY_INFORMATION</b> The type of security information to retrieve.
///    sidOwner = Type: <b>PSID*</b> The owner security identifier (SID) in the returned security descriptor.
///    sidGroup = Type: <b>PSID*</b> The primary group security identifier (SID) in the returned security descriptor.
///    dacl = Type: <b>PACL*</b> The discretionary access control list (DACL) in the returned security descriptor.
///    sacl = Type: <b>PACL*</b> The system access control list (SACL) in the returned security descriptor.
///    securityDescriptor = Type: <b>PSECURITY_DESCRIPTOR*</b> The returned security descriptor.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The security descriptor was retrieved
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmSubLayerGetSecurityInfoByKey0(HANDLE engineHandle, const(GUID)* key, uint securityInfo, void** sidOwner, 
                                       void** sidGroup, ACL** dacl, ACL** sacl, void** securityDescriptor);

///The <b>FwpmSubLayerSetSecurityInfoByKey0</b> function sets specified security information in the security descriptor
///of a sublayer.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    key = Type: <b>const GUID*</b> Unique identifier of the sublayer. This must be the same GUID that was specified when
///          the application called FwpmSubLayerAdd0.
///    securityInfo = Type: <b>SECURITY_INFORMATION</b> The type of security information to set.
///    sidOwner = Type: <b>const SID*</b> The owner's security identifier (SID) to be set in the security descriptor.
///    sidGroup = Type: <b>const SID*</b> The group's SID to be set in the security descriptor.
///    dacl = Type: <b>const ACL*</b> The discretionary access control list (DACL) to be set in the security descriptor.
///    sacl = Type: <b>const ACL*</b> The system access control list (SACL) to be set in the security descriptor.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The security descriptor was set
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmSubLayerSetSecurityInfoByKey0(HANDLE engineHandle, const(GUID)* key, uint securityInfo, 
                                       const(SID)* sidOwner, const(SID)* sidGroup, const(ACL)* dacl, 
                                       const(ACL)* sacl);

///The <b>FwpmSubLayerSubscribeChanges0</b> function is used to request the delivery of notifications regarding changes
///in a particular sublayer.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    subscription = Type: [FWPM_SUBLAYER_SUBSCRIPTION0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_sublayer_subscription0)*</b>
///                   The notifications to be delivered.
///    callback = Type: <b>FWPM_SUBLAYER_CHANGE_CALLBACK0</b> Function pointer that will be invoked when a notification is ready
///               for delivery.
///    context = Type: <b>void*</b> Optional context pointer. This pointer is passed to the <i>callback</i> function along with
///              details of the change.
///    changeHandle = Type: <b>HANDLE*</b> Handle to the newly created subscription.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The subscription was created successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmSubLayerSubscribeChanges0(HANDLE engineHandle, const(FWPM_SUBLAYER_SUBSCRIPTION0)* subscription, 
                                   FWPM_SUBLAYER_CHANGE_CALLBACK0 callback, void* context, HANDLE* changeHandle);

///The <b>FwpmSubLayerUnsubscribeChanges0</b> function is used to cancel a sublayer change subscription and stop
///receiving change notifications.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    changeHandle = Type: <b>HANDLE</b> Handle of the subscribed change notification. This is the returned handle from the call to
///                   FwpmSubLayerSubscribeChanges0.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The subscription was deleted successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmSubLayerUnsubscribeChanges0(HANDLE engineHandle, HANDLE changeHandle);

///The <b>FwpmSubLayerSubscriptionsGet0</b> function retrieves an array of all the current sub-layer change notification
///subscriptions.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    entries = Type:
///              [FWPM_SUBLAYER_SUBSCRIPTION0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_sublayer_subscription0)***</b> The
///              current sublayer change notification subscriptions.
///    numEntries = Type: <b>UINT32*</b> The number of entries returned.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The subscriptions were retrieved
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmSubLayerSubscriptionsGet0(HANDLE engineHandle, FWPM_SUBLAYER_SUBSCRIPTION0*** entries, uint* numEntries);

///The <b>FwpmLayerGetById0</b> function retrieves a layer object.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    id = Type: <b>UINT16</b> Identifier of the desired layer. For a list of possible values, see Run-time Filtering Layer
///         Identifiers in the WDK documentation for Windows Filtering Platform.
///    layer = Type: [FWPM_LAYER0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_layer0)**</b> The layer information.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The layer was retrieved successfully. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl> </td>
///    <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td> <td
///    width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmLayerGetById0(HANDLE engineHandle, ushort id, FWPM_LAYER0** layer);

///The <b>FwpmLayerGetByKey0</b> function retrieves a layer object.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    key = Type: <b>const GUID*</b> Unique identifier of the layer. See Filtering Layer Identifiers for a list of possible
///          GUID values.
///    layer = Type: [FWPM_LAYER0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_layer0)**</b> The layer information.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The layer was retrieved successfully. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl> </td>
///    <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td> <td
///    width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmLayerGetByKey0(HANDLE engineHandle, const(GUID)* key, FWPM_LAYER0** layer);

///The <b>FwpmLayerCreateEnumHandle0</b> function creates a handle used to enumerate a set of layer objects.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumTemplate = Type: [FWPM_LAYER_ENUM_TEMPLATE0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_layer_enum_template0)*</b>
///                   Template to selectively restrict the enumeration.
///    enumHandle = Type: <b>HANDLE*</b> Handle for the layer enumeration.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The enumerator was created successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmLayerCreateEnumHandle0(HANDLE engineHandle, const(FWPM_LAYER_ENUM_TEMPLATE0)* enumTemplate, 
                                HANDLE* enumHandle);

///The <b>FwpmLayerEnum0</b> function returns the next page of results from the layer enumerator.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle for a layer enumeration created by a call to FwpmLayerCreateEnumHandle0.
///    numEntriesRequested = Type: <b>UINT32</b> The number of layer entries requested.
///    entries = Type: [FWPM_LAYER0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_layer0)***</b> Addresses of the enumeration
///              entries.
///    numEntriesReturned = Type: <b>UINT32*</b> The number of layer entries returned.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The layers were enumerated successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmLayerEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, FWPM_LAYER0*** entries, 
                    uint* numEntriesReturned);

///The <b>FwpmLayerDestroyEnumHandle0</b> function frees a handle returned by FwpmFilterCreateEnumHandle0.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle of a layer enumeration created by a call to FwpmLayerCreateEnumHandle0.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The enumerator was successfully deleted.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmLayerDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

///The <b>FwpmLayerGetSecurityInfoByKey0</b> function retrieves a copy of the security descriptor for a layer object.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    key = Type: <b>const GUID*</b> Unique identifier of the layer. See Filtering Layer Identifiers for a list of possible
///          GUID values.
///    securityInfo = Type: <b>SECURITY_INFORMATION</b> The type of security information to retrieve.
///    sidOwner = Type: <b>PSID*</b> The owner security identifier (SID) in the returned security descriptor.
///    sidGroup = Type: <b>PSID*</b> The primary group security identifier (SID) in the returned security descriptor.
///    dacl = Type: <b>PACL*</b> The discretionary access control list (DACL) in the returned security descriptor.
///    sacl = Type: <b>PACL*</b> The system access control list (SACL) in the returned security descriptor.
///    securityDescriptor = Type: <b>PSECURITY_DESCRIPTOR*</b> The returned security descriptor.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The security descriptor was retrieved
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmLayerGetSecurityInfoByKey0(HANDLE engineHandle, const(GUID)* key, uint securityInfo, void** sidOwner, 
                                    void** sidGroup, ACL** dacl, ACL** sacl, void** securityDescriptor);

///The <b>FwpmLayerSetSecurityInfoByKey0</b> function sets specified security information in the security descriptor of
///a layer object.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    key = Type: <b>const GUID*</b> Unique identifier of the layer. See Filtering Layer Identifiers for a list of possible
///          GUID values.
///    securityInfo = Type: <b>SECURITY_INFORMATION</b> The type of security information to set.
///    sidOwner = Type: <b>const SID*</b> The owner's security identifier (SID) to be set in the security descriptor.
///    sidGroup = Type: <b>const SID*</b> The group's SID to be set in the security descriptor.
///    dacl = Type: <b>const ACL*</b> The discretionary access control list (DACL) to be set in the security descriptor.
///    sacl = Type: <b>const ACL*</b> The system access control list (SACL) to be set in the security descriptor.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The security descriptor was set
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmLayerSetSecurityInfoByKey0(HANDLE engineHandle, const(GUID)* key, uint securityInfo, const(SID)* sidOwner, 
                                    const(SID)* sidGroup, const(ACL)* dacl, const(ACL)* sacl);

///The <b>FwpmCalloutAdd0</b> function adds a new callout object to the system.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    callout = Type: [FWPM_CALLOUT0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_callout0)*</b> The callout object to be
///              added.
///    sd = Type: <b>PSECURITY_DESCRIPTOR</b> The security information associated with the callout.
///    id = Type: <b>UINT32*</b> Runtime identifier for this callout.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The callout was successfully added. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_INVALID_PARAMETER</b></dt> <dt>0x80320035</dt> </dl> </td> <td
///    width="60%"> FWPM_TUNNEL_FLAG_POINT_TO_POINT was not set and conditions other than local/remote address were
///    specified. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmCalloutAdd0(HANDLE engineHandle, const(FWPM_CALLOUT0)* callout, void* sd, uint* id);

///The <b>FwpmCalloutDeleteById0</b> function removes a callout object from the system.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    id = Type: <b>UINT32</b> The runtime identifier for the callout being removed from the system. This identifier was
///         received from the system when the application called FwpmCalloutAdd0 for this object.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The callout was successfully deleted. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl> </td>
///    <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td> <td
///    width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmCalloutDeleteById0(HANDLE engineHandle, uint id);

///The <b>FwpmCalloutDeleteByKey0</b> function removes a callout object from the system.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    key = Type: <b>const GUID*</b> Unique identifier of the callout being removed from the system. This GUID was specified
///          in the <b>calloutKey</b> member of the <i>callout</i> parameter when the application called FwpmCalloutAdd0 for
///          this object.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The callout was successfully deleted. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl> </td>
///    <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td> <td
///    width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmCalloutDeleteByKey0(HANDLE engineHandle, const(GUID)* key);

///The <b>FwpmCalloutGetById0</b> function retrieves a callout object.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    id = Type: <b>UINT32</b> The runtime identifier for the callout. This identifier was received from the system when the
///         application called FwpmCalloutAdd0 for this object.
///    callout = Type: [FWPM_CALLOUT0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_callout0)**</b> Information about the
///              state associated with the callout.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The callout was retrieved successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmCalloutGetById0(HANDLE engineHandle, uint id, FWPM_CALLOUT0** callout);

///The <b>FwpmCalloutGetByKey0</b> function retrieves a callout object.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    key = Type: <b>const GUID*</b> Unique identifier of the callout. This GUID was specified in the <b>calloutKey</b>
///          member of the <i>callout</i> parameter when the application called FwpmCalloutAdd0 for this object.
///    callout = Type: [FWPM_CALLOUT0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_callout0)**</b> Information about the
///              state associated with the callout.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The callout was retrieved successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmCalloutGetByKey0(HANDLE engineHandle, const(GUID)* key, FWPM_CALLOUT0** callout);

///The <b>FwpmCalloutCreateEnumHandle0</b> function creates a handle used to enumerate a set of callout objects.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumTemplate = Type: [FWPM_CALLOUT_ENUM_TEMPLATE0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_callout_enum_template0)*</b>
///                   Template to selectively restrict the enumeration.
///    enumHandle = Type: <b>HANDLE*</b> Handle of the newly created enumeration.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The enumerator was created successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmCalloutCreateEnumHandle0(HANDLE engineHandle, const(FWPM_CALLOUT_ENUM_TEMPLATE0)* enumTemplate, 
                                  HANDLE* enumHandle);

///The <b>FwpmCalloutEnum0</b> function returns the next page of results from the callout enumerator.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle for a callout enumeration created by a call to FwpmCalloutCreateEnumHandle0.
///    numEntriesRequested = Type: <b>UINT32</b> The number of callout objects requested.
///    entries = Type: [FWP_CALLOUT0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_callout0)***</b> Addresses of the
///              enumeration entries.
///    numEntriesReturned = Type: <b>UINT32*</b> The number of callouts returned.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The callouts were enumerated successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmCalloutEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, FWPM_CALLOUT0*** entries, 
                      uint* numEntriesReturned);

///The <b>FwpmCalloutDestroyEnumHandle0</b> function frees a handle returned by FwpmCalloutCreateEnumHandle0.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle of a callout enumeration created by a call to FwpmCalloutCreateEnumHandle0.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The enumerator was successfully deleted.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmCalloutDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

///The <b>FwpmCalloutGetSecurityInfoByKey0</b> function retrieves a copy of the security descriptor for a callout
///object.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    key = Type: <b>const GUID*</b> Pointer to a GUID that uniquely identifies the callout. This GUID was specified in the
///          <b>calloutKey</b> member of the <i>callout</i> parameter when the application called FwpmCalloutAdd0 for this
///          object.
///    securityInfo = Type: <b>SECURITY_INFORMATION</b> The type of security information to retrieve.
///    sidOwner = Type: <b>PSID*</b> The owner security identifier (SID) in the returned security descriptor.
///    sidGroup = Type: <b>PSID*</b> The primary group security identifier (SID) in the returned security descriptor.
///    dacl = Type: <b>PACL*</b> The discretionary access control list (DACL) in the returned security descriptor.
///    sacl = Type: <b>PACL*</b> The system access control list (SACL) in the returned security descriptor.
///    securityDescriptor = Type: <b>PSECURITY_DESCRIPTOR*</b> The returned security descriptor.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The security descriptor was retrieved
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmCalloutGetSecurityInfoByKey0(HANDLE engineHandle, const(GUID)* key, uint securityInfo, void** sidOwner, 
                                      void** sidGroup, ACL** dacl, ACL** sacl, void** securityDescriptor);

///The <b>FwpmCalloutSetSecurityInfoByKey0</b> function sets specified security information in the security descriptor
///of a callout object.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    key = Type: <b>const GUID*</b> Pointer to a GUID that uniquely identifies the callout. This GUID was specified in the
///          <b>calloutKey</b> member of the <i>callout</i> parameter when the application called FwpmCalloutAdd0 for this
///          object.
///    securityInfo = Type: <b>SECURITY_INFORMATION</b> The type of security information to set.
///    sidOwner = Type: <b>const SID*</b> The owner's security identifier (SID) to be set in the security descriptor.
///    sidGroup = Type: <b>const SID*</b> The group's SID to be set in the security descriptor.
///    dacl = Type: <b>const ACL*</b> The discretionary access control list (DACL) to be set in the security descriptor.
///    sacl = Type: <b>const ACL*</b> The system access control list (SACL) to be set in the security descriptor.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The security descriptor was set
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmCalloutSetSecurityInfoByKey0(HANDLE engineHandle, const(GUID)* key, uint securityInfo, 
                                      const(SID)* sidOwner, const(SID)* sidGroup, const(ACL)* dacl, const(ACL)* sacl);

///The <b>FwpmCalloutSubscribeChanges0</b> function is used to request the delivery of notifications regarding changes
///in a particular callout.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    subscription = Type: [FWPM_CALLOUT_SUBSCRIPTION0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_callout_subscription0)*</b>
///                   The notifications which will be delivered.
///    callback = Type: <b>FWPM_CALLOUT_CHANGE_CALLBACK0</b> Function pointer that will be invoked when a notification is ready for
///               delivery.
///    context = Type: <b>void*</b> Optional context pointer. This pointer is passed to the <i>callback</i> function along with
///              details of the change.
///    changeHandle = Type: <b>HANDLE*</b> Handle to the newly created subscription.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The subscription was created successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmCalloutSubscribeChanges0(HANDLE engineHandle, const(FWPM_CALLOUT_SUBSCRIPTION0)* subscription, 
                                  FWPM_CALLOUT_CHANGE_CALLBACK0 callback, void* context, HANDLE* changeHandle);

///The <b>FwpmCalloutUnsubscribeChanges0</b> function is used to cancel a callout change subscription and stop receiving
///change notifications.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    changeHandle = Type: <b>HANDLE</b> Handle of the subscribed change notification. This is the handle returned by the call to
///                   FwpmCalloutSubscribeChanges0.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The subscription was deleted successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmCalloutUnsubscribeChanges0(HANDLE engineHandle, HANDLE changeHandle);

///The <b>FwpmCalloutSubscriptionsGet0</b> function retrieves an array of all the current callout change notification
///subscriptions.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    entries = Type: [FWPM_CALLOUT_SUBSCRIPTION0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_callout_subscription0)***</b>
///              Addresses of the current callout change notification subscriptions.
///    numEntries = Type: <b>UINT32*</b> The number of entries returned.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The subscriptions were retrieved
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmCalloutSubscriptionsGet0(HANDLE engineHandle, FWPM_CALLOUT_SUBSCRIPTION0*** entries, uint* numEntries);

///The **FwpmFilterAdd0** function adds a new filter object to the system.
///Params:
///    engineHandle = Type: **HANDLE** Handle for an open session to the filter engine. Call
///                   [FwpmEngineOpen0](nf-fwpmu-fwpmengineopen0.md) to open a session to the filter engine.
///    filter = Type: **[FWPM_FILTER0](../fwpmtypes/ns-fwpmtypes-fwpm_filter0.md)*** The filter object to be added.
///    sd = Type: **[SECURITY_DESCRIPTOR](../winnt/ns-winnt-security_descriptor.md)** Security information about the filter
///         object.
///    id = Type: **UINT64*** The runtime identifier for this filter.
///Returns:
///    Type: **DWORD** | Return code/value | Description | | ----------------- | ----------- | | ERROR_SUCCESS <br/> 0 |
///    The filter was successfully added. | | ERROR_INVALID_SECURITY_DESCR <br/> 0x8007053A | The security descriptor
///    structure is invalid. Or, a filter condition contains a security descriptor in absolute format. | |
///    FWP_E_CALLOUT_NOTIFICATION_FAILED <br/> 0x80320037 | The caller added a callout filter and the callout returned
///    an error from its notification routine. | | FWP_E_* error code <br/> 0x80320001—0x80320039 | A Windows
///    Filtering Platform (WFP) specific error. See [WFP Error Codes](/windows/desktop/FWP/wfp-error-codes) for details.
///    | | RPC_* error code <br/> 0x80010001—0x80010122 | Failure to communicate with the remote or local firewall
///    engine. |
///    
@DllImport("fwpuclnt")
uint FwpmFilterAdd0(HANDLE engineHandle, const(FWPM_FILTER0)* filter, void* sd, ulong* id);

///The <b>FwpmFilterDeleteById0</b> function removes a filter object from the system.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    id = Type: <b>UINT64</b> Runtime identifier for the object being removed from the system. This value is returned by
///         the FwpmFilterAdd0 function.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The filter was successfully deleted. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl> </td>
///    <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td> <td
///    width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmFilterDeleteById0(HANDLE engineHandle, ulong id);

///The <b>FwpmFilterDeleteByKey0</b> function removes a filter object from the system.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    key = Type: <b>const GUID*</b> Unique identifier of the object being removed from the system. This is the same GUID
///          that was specified when the application called FwpmFilterAdd0 for this object.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The filter was successfully deleted. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl> </td>
///    <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td> <td
///    width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmFilterDeleteByKey0(HANDLE engineHandle, const(GUID)* key);

///The <b>FwpmFilterGetById0</b> function retrieves a filter object.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    id = Type: <b>UINT64</b> A runtime identifier for the desired object. This identifier was received from the system
///         when the application called FwpmFilterAdd0 for this object.
///    filter = Type: [FWPM_FILTER0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_filter0)**</b> The filter information.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The filter was retrieved successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmFilterGetById0(HANDLE engineHandle, ulong id, FWPM_FILTER0** filter);

///The <b>FwpmFilterGetByKey0</b> function retrieves a filter object.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    key = Type: <b>const GUID*</b> Unique identifier of the filter. This GUID was specified in the <b>filterKey</b> member
///          of the <i>filter</i> parameter when the application called FwpmFilterAdd0 for this object.
///    filter = Type: [FWPM_FILTER0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_filter0)**</b> The filter information.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The filter was retrieved successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmFilterGetByKey0(HANDLE engineHandle, const(GUID)* key, FWPM_FILTER0** filter);

///The <b>FwpmFilterCreateEnumHandle0</b> function creates a handle used to enumerate a set of filter objects.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumTemplate = Type: [FWPM_FILTER_ENUM_TEMPLATE0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_filter_enum_template0)*</b>
///                   Template to selectively restrict the enumeration.
///    enumHandle = Type: <b>HANDLE*</b> The handle for filter enumeration.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The enumerator was created successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmFilterCreateEnumHandle0(HANDLE engineHandle, const(FWPM_FILTER_ENUM_TEMPLATE0)* enumTemplate, 
                                 HANDLE* enumHandle);

///The <b>FwpmFilterEnum0</b> function returns the next page of results from the filter enumerator.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle for a filter enumeration created by a call to FwpmFilterCreateEnumHandle0.
///    numEntriesRequested = Type: <b>UINT32</b> The number of filter objects requested.
///    entries = Type: [FWPM_FILTER0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_filter0)***</b> Addresses of enumeration
///              entries.
///    numEntriesReturned = Type: <b>UINT32*</b> The number of filter objects returned.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The filters were enumerated successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmFilterEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, FWPM_FILTER0*** entries, 
                     uint* numEntriesReturned);

///The <b>FwpmFilterDestroyEnumHandle0</b> function frees a handle returned by FwpmFilterCreateEnumHandle0.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle of a filter enumeration created by a call to FwpmFilterCreateEnumHandle0.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The enumerator was successfully deleted.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmFilterDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

///The <b>FwpmFilterGetSecurityInfoByKey0</b> function retrieves a copy of the security descriptor for a filter object.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    key = Type: <b>const GUID*</b> Unique identifier of the filter. This GUID was specified in the <b>filterKey</b> member
///          of the <i>filter</i> parameter when the application called FwpmFilterAdd0 for this object.
///    securityInfo = Type: <b>SECURITY_INFORMATION</b> The type of security information to retrieve.
///    sidOwner = Type: <b>PSID*</b> The owner security identifier (SID) in the returned security descriptor.
///    sidGroup = Type: <b>PSID*</b> The primary group security identifier (SID) in the returned security descriptor.
///    dacl = Type: <b>PACL*</b> The discretionary access control list (DACL) in the returned security descriptor.
///    sacl = Type: <b>PACL*</b> The system access control list (SACL) in the returned security descriptor.
///    securityDescriptor = Type: <b>PSECURITY_DESCRIPTOR*</b> The returned security descriptor.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The security descriptor was retrieved
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmFilterGetSecurityInfoByKey0(HANDLE engineHandle, const(GUID)* key, uint securityInfo, void** sidOwner, 
                                     void** sidGroup, ACL** dacl, ACL** sacl, void** securityDescriptor);

///The <b>FwpmFilterSetSecurityInfoByKey0</b> function sets specified security information in the security descriptor of
///a filter object.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    key = Type: <b>const GUID*</b> Unique identifier of the filter. This GUID was specified in the <b>filterKey</b> member
///          of the <i>filter</i> parameter when the application called FwpmFilterAdd0 for this object.
///    securityInfo = Type: <b>SECURITY_INFORMATION</b> The type of security information to set.
///    sidOwner = Type: <b>const SID*</b> The owner's security identifier (SID) to be set in the security descriptor.
///    sidGroup = Type: <b>const SID*</b> The group's SID to be set in the security descriptor.
///    dacl = Type: <b>const ACL*</b> The discretionary access control list (DACL) to be set in the security descriptor.
///    sacl = Type: <b>const ACL*</b> The system access control list (SACL) to be set in the security descriptor.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The security descriptor was set
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmFilterSetSecurityInfoByKey0(HANDLE engineHandle, const(GUID)* key, uint securityInfo, 
                                     const(SID)* sidOwner, const(SID)* sidGroup, const(ACL)* dacl, const(ACL)* sacl);

///The <b>FwpmFilterSubscribeChanges0</b> function is used to request the delivery of notifications regarding changes in
///a particular filter.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    subscription = Type: [FWPM_FILTER_SUBSCRIPTION0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_filter_subscription0)*</b> The
///                   notifications to be delivered.
///    callback = Type: <b>FWPM_FILTER_CHANGE_CALLBACK0</b> The function pointer that will be invoked when a notification is ready
///               for delivery.
///    context = Type: <b>void*</b> Optional context pointer. This pointer is passed to the <i>callback</i> function along with
///              details of the change.
///    changeHandle = Type: <b>HANDLE*</b> Handle to the newly created subscription.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The subscription was created successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmFilterSubscribeChanges0(HANDLE engineHandle, const(FWPM_FILTER_SUBSCRIPTION0)* subscription, 
                                 FWPM_FILTER_CHANGE_CALLBACK0 callback, void* context, HANDLE* changeHandle);

///The <b>FwpmFilterUnsubscribeChanges0</b> function is used to cancel a filter change subscription and stop receiving
///change notifications.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    changeHandle = Type: <b>HANDLE</b> Handle of the subscribed change notification. This is the handle returned by the call to
///                   FwpmFilterSubscribeChanges0.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The subscription was deleted successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmFilterUnsubscribeChanges0(HANDLE engineHandle, HANDLE changeHandle);

///The <b>FwpmFilterSubscriptionsGet0</b> function retrieves an array of all the current filter change notification
///subscriptions.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    entries = Type: [FWPM_FILTER_SUBSCRIPTION0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_filter_subscription0)***</b>
///              The current filter change notification subscriptions.
///    numEntries = Type: <b>UINT32*</b> The number of entries returned.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The subscriptions were retrieved
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmFilterSubscriptionsGet0(HANDLE engineHandle, FWPM_FILTER_SUBSCRIPTION0*** entries, uint* numEntries);

///The <b>FwpmGetAppIdFromFileName0 </b> function retrieves an application identifier from a file name.
///Params:
///    fileName = Type: <b>const wchar_t*</b> File name from which the application identifier will be retrieved.
///    appId = Type: [FWP_BYTE_BLOB](/windows/desktop/api/fwptypes/ns-fwptypes-fwp_byte_blob)**</b> The retrieved application
///            identifier.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The application identifier was retrieved
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmGetAppIdFromFileName0(const(PWSTR) fileName, FWP_BYTE_BLOB** appId);

@DllImport("fwpuclnt")
uint FwpmBitmapIndexGet0(HANDLE engineHandle, const(GUID)* fieldId, ubyte* idx);

@DllImport("fwpuclnt")
uint FwpmBitmapIndexFree0(HANDLE engineHandle, const(GUID)* fieldId, ubyte* idx);

///The <b>FwpmIPsecTunnelAdd0</b> function adds a new Internet Protocol Security (IPsec) tunnel mode policy to the
///system. <div class="alert"><b>Note</b> <b>FwpmIPsecTunnelAdd0</b> is the specific implementation of
///FwpmIPsecTunnelAdd used in Windows Vista. See WFP Version-Independent Names and Targeting Specific Versions of
///Windows for more information. For Windows 7, FwpmIPsecTunnelAdd1 is available. For Windows 8, FwpmIPsecTunnelAdd2 is
///available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> A handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    flags = Type: <b>UINT32</b> Possible values: <table> <tr> <th>IPsec tunnel flag</th> <th>Meaning</th> </tr> <tr> <td
///            width="40%"><a id="FWPM_TUNNEL_FLAG_POINT_TO_POINT"></a><a id="fwpm_tunnel_flag_point_to_point"></a><dl>
///            <dt><b>FWPM_TUNNEL_FLAG_POINT_TO_POINT</b></dt> </dl> </td> <td width="60%"> Adds a point-to-point tunnel to the
///            system. </td> </tr> </table>
///    mainModePolicy = Type: [FWPM_PROVIDER_CONTEXT0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_provider_context0)*</b> The Main
///                     Mode policy for the IPsec tunnel.
///    tunnelPolicy = Type: [FWPM_PROVIDER_CONTEXT0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_provider_context0)*</b> The Quick
///                   Mode policy for the IPsec tunnel.
///    numFilterConditions = Type: <b>UINT32</b> Number of filter conditions present in the <i>filterConditions</i> parameter.
///    filterConditions = Type: [FWPM_FILTER_CONDITION0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_filter_condition0)*</b> Array of
///                       filter conditions that describe the traffic which should be tunneled by IPsec.
///    sd = Type: <b>PSECURITY_DESCRIPTOR</b> The security information associated with the IPsec tunnel.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The IPsec tunnel mode policy was
///    successfully added. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_INVALID_PARAMETER</b></dt>
///    <dt>0x80320035</dt> </dl> </td> <td width="60%"> FWPM_TUNNEL_FLAG_POINT_TO_POINT was not set and conditions other
///    than local/remote address were specified. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error
///    code</b></dt> <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP)
///    specific error. See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error
///    code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the
///    remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmIPsecTunnelAdd0(HANDLE engineHandle, uint flags, const(FWPM_PROVIDER_CONTEXT0)* mainModePolicy, 
                         const(FWPM_PROVIDER_CONTEXT0)* tunnelPolicy, uint numFilterConditions, 
                         const(FWPM_FILTER_CONDITION0)* filterConditions, void* sd);

///The <b>FwpmIPsecTunnelAdd1</b> function adds a new Internet Protocol Security (IPsec) tunnel mode policy to the
///system. <div class="alert"><b>Note</b> <b>FwpmIPsecTunnelAdd1</b> is the specific implementation of
///FwpmIPsecTunnelAdd used in Windows 7. See WFP Version-Independent Names and Targeting Specific Versions of Windows
///for more information. For Windows Vista, FwpmIPsecTunnelAdd0 is available. For Windows 8, FwpmIPsecTunnelAdd2 is
///available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> A handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    flags = Type: <b>UINT32</b> Possible values: <table> <tr> <th>IPsec tunnel flag</th> <th>Meaning</th> </tr> <tr> <td
///            width="40%"><a id="FWPM_TUNNEL_FLAG_POINT_TO_POINT"></a><a id="fwpm_tunnel_flag_point_to_point"></a><dl>
///            <dt><b>FWPM_TUNNEL_FLAG_POINT_TO_POINT</b></dt> </dl> </td> <td width="60%"> Adds a point-to-point tunnel to the
///            system. </td> </tr> <tr> <td width="40%"><a id="FWPM_TUNNEL_FLAG_ENABLE_VIRTUAL_IF_TUNNELING"></a><a
///            id="fwpm_tunnel_flag_enable_virtual_if_tunneling"></a><dl>
///            <dt><b>FWPM_TUNNEL_FLAG_ENABLE_VIRTUAL_IF_TUNNELING</b></dt> </dl> </td> <td width="60%"> Enables virtual
///            interface-based IPsec tunnel mode. </td> </tr> </table>
///    mainModePolicy = Type: [FWPM_PROVIDER_CONTEXT1](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_provider_context1)*</b> The Main
///                     Mode policy for the IPsec tunnel.
///    tunnelPolicy = Type: [FWPM_PROVIDER_CONTEXT1](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_provider_context1)*</b> The Quick
///                   Mode policy for the IPsec tunnel.
///    numFilterConditions = Type: <b>UINT32</b> Number of filter conditions present in the <i>filterConditions</i> parameter.
///    filterConditions = Type: <b>const FWPM_FILTER_CONDITION0*</b> Array of filter conditions that describe the traffic which should be
///                       tunneled by IPsec.
///    keyModKey = Type: <b>const GUID*</b> Pointer to a GUID that uniquely identifies the keying module key. If the caller supplies
///                this parameter, only that keying module will be used for the tunnel. Otherwise, the default keying policy
///                applies.
///    sd = Type: <b>PSECURITY_DESCRIPTOR</b> The security information associated with the IPsec tunnel.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The IPsec tunnel mode policy was
///    successfully added. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_INVALID_PARAMETER</b></dt>
///    <dt>0x80320035</dt> </dl> </td> <td width="60%"> FWPM_TUNNEL_FLAG_POINT_TO_POINT was not set and conditions other
///    than local/remote address were specified. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error
///    code</b></dt> <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP)
///    specific error. See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error
///    code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the
///    remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmIPsecTunnelAdd1(HANDLE engineHandle, uint flags, const(FWPM_PROVIDER_CONTEXT1)* mainModePolicy, 
                         const(FWPM_PROVIDER_CONTEXT1)* tunnelPolicy, uint numFilterConditions, 
                         const(FWPM_FILTER_CONDITION0)* filterConditions, const(GUID)* keyModKey, void* sd);

///The <b>FwpmIPsecTunnelAdd2</b> function adds a new Internet Protocol Security (IPsec) tunnel mode policy to the
///system. <div class="alert"><b>Note</b> <b>FwpmIPsecTunnelAdd2</b> is the specific implementation of
///FwpmIPsecTunnelAdd used in Windows 8. See WFP Version-Independent Names and Targeting Specific Versions of Windows
///for more information. For Windows 7, FwpmIPsecTunnelAdd1 is available. For Windows Vista, FwpmIPsecTunnelAdd0 is
///available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> A handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    flags = Type: <b>UINT32</b> Possible values: <table> <tr> <th>IPsec tunnel flag</th> <th>Meaning</th> </tr> <tr> <td
///            width="40%"><a id="FWPM_TUNNEL_FLAG_POINT_TO_POINT"></a><a id="fwpm_tunnel_flag_point_to_point"></a><dl>
///            <dt><b>FWPM_TUNNEL_FLAG_POINT_TO_POINT</b></dt> </dl> </td> <td width="60%"> Adds a point-to-point tunnel to the
///            system. </td> </tr> <tr> <td width="40%"><a id="FWPM_TUNNEL_FLAG_ENABLE_VIRTUAL_IF_TUNNELING"></a><a
///            id="fwpm_tunnel_flag_enable_virtual_if_tunneling"></a><dl>
///            <dt><b>FWPM_TUNNEL_FLAG_ENABLE_VIRTUAL_IF_TUNNELING</b></dt> </dl> </td> <td width="60%"> Enables virtual
///            interface-based IPsec tunnel mode. </td> </tr> </table>
///    mainModePolicy = Type: [FWPM_PROVIDER_CONTEXT2](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_provider_context2)*</b> The Main
///                     Mode policy for the IPsec tunnel.
///    tunnelPolicy = Type: [FWPM_PROVIDER_CONTEXT2](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_provider_context2)*</b> The Quick
///                   Mode policy for the IPsec tunnel.
///    numFilterConditions = Type: <b>UINT32</b> Number of filter conditions present in the <i>filterConditions</i> parameter.
///    filterConditions = Type: [FWPM_FILTER_CONDITION0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_filter_condition0)*</b> Array of
///                       filter conditions that describe the traffic which should be tunneled by IPsec.
///    keyModKey = Type: <b>const GUID*</b> Pointer to a GUID that uniquely identifies the keying module key. If the caller supplies
///                this parameter, only that keying module will be used for the tunnel. Otherwise, the default keying policy
///                applies.
///    sd = Type: <b>PSECURITY_DESCRIPTOR</b> The security information associated with the IPsec tunnel.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The IPsec tunnel mode policy was
///    successfully added. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_INVALID_PARAMETER</b></dt>
///    <dt>0x80320035</dt> </dl> </td> <td width="60%"> FWPM_TUNNEL_FLAG_POINT_TO_POINT was not set and conditions other
///    than local/remote address were specified. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error
///    code</b></dt> <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP)
///    specific error. See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error
///    code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the
///    remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmIPsecTunnelAdd2(HANDLE engineHandle, uint flags, const(FWPM_PROVIDER_CONTEXT2)* mainModePolicy, 
                         const(FWPM_PROVIDER_CONTEXT2)* tunnelPolicy, uint numFilterConditions, 
                         const(FWPM_FILTER_CONDITION0)* filterConditions, const(GUID)* keyModKey, void* sd);

@DllImport("fwpuclnt")
uint FwpmIPsecTunnelAdd3(HANDLE engineHandle, uint flags, const(FWPM_PROVIDER_CONTEXT3_)* mainModePolicy, 
                         const(FWPM_PROVIDER_CONTEXT3_)* tunnelPolicy, uint numFilterConditions, 
                         const(FWPM_FILTER_CONDITION0)* filterConditions, const(GUID)* keyModKey, void* sd);

///The <b>FwpmIPsecTunnelDeleteByKey0</b> function removes an Internet Protocol Security (IPsec) tunnel mode policy from
///the system.
///Params:
///    engineHandle = Type: <b>HANDLE</b> A handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    key = Type: <b>const GUID*</b> Unique identifier of the IPsec tunnel. This GUID was specified in the
///          <b>providerContextKey</b> member of the <i>tunnelPolicy</i> parameter of the FwpmIPsecTunnelAdd0 function.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The IPsec tunnel mode policy was
///    successfully deleted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmIPsecTunnelDeleteByKey0(HANDLE engineHandle, const(GUID)* key);

///The <b>IPsecGetStatistics0</b> function retrieves Internet Protocol Security (IPsec) statistics. <div
///class="alert"><b>Note</b> <b>IPsecGetStatistics0</b> is the specific implementation of IPsecGetStatistics used in
///Windows Vista. See WFP Version-Independent Names and Targeting Specific Versions of Windows for more information. For
///Windows 7 and later, IPsecGetStatistics1 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    ipsecStatistics = Type: [IPSEC_STATISTICS0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_statistics0)*</b> Top-level object
///                      of IPsec statistics organization.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The IPsec statistics were successfully
///    retrieved. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecGetStatistics0(HANDLE engineHandle, IPSEC_STATISTICS0* ipsecStatistics);

///The <b>IPsecGetStatistics1</b> function retrieves Internet Protocol Security (IPsec) statistics. <div
///class="alert"><b>Note</b> <b>IPsecGetStatistics1</b> is the specific implementation of IPsecGetStatistics used in
///Windows 7 and later. See WFP Version-Independent Names and Targeting Specific Versions of Windows for more
///information. For Windows Vista, IPsecGetStatistics0 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    ipsecStatistics = Type: [IPSEC_STATISTICS1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_statistics1)*</b> Top-level object
///                      of IPsec statistics organization.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The IPsec statistics were successfully
///    retrieved. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecGetStatistics1(HANDLE engineHandle, IPSEC_STATISTICS1* ipsecStatistics);

///The <b>IPsecSaContextCreate0</b> function creates an IPsec security association (SA) context. <div
///class="alert"><b>Note</b> <b>IPsecSaContextCreate0</b> is the specific implementation of IPsecSaContextCreate used in
///Windows Vista. See WFP Version-Independent Names and Targeting Specific Versions of Windows for more information. For
///Windows 7 and later, IPsecSaContextCreate1 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    outboundTraffic = Type: [IPSEC_TRAFFIC0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_traffic0)*</b> The outbound traffic of
///                      the SA.
///    inboundFilterId = Type: <b>UINT64*</b> Optional filter identifier of the cached inbound filter corresponding to the
///                      <i>outboundTraffic</i> parameter specified by the caller. Base filtering engine (BFE) may cache the inbound
///                      filter identifier and return the cached value, if available. Caller must handle the case when BFE does not have a
///                      cached value, in which case this parameter will be set to 0.
///    id = Type: <b>UINT64*</b> The identifier of the IPsec SA context.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The IPsec SA context was created
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecSaContextCreate0(HANDLE engineHandle, const(IPSEC_TRAFFIC0)* outboundTraffic, ulong* inboundFilterId, 
                           ulong* id);

///The <b>IPsecSaContextCreate1</b> function creates an IPsec security association (SA) context. <div
///class="alert"><b>Note</b> <b>IPsecSaContextCreate1</b> is the specific implementation of IPsecSaContextCreate used in
///Windows 7 and later. See WFP Version-Independent Names and Targeting Specific Versions of Windows for more
///information. For Windows Vista, IPsecSaContextCreate0 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    outboundTraffic = Type: [IPSEC_TRAFFIC1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_traffic0)*</b> The outbound traffic of
///                      the SA.
///    virtualIfTunnelInfo = Type:
///                          [IPSEC_VIRTUAL_IF_TUNNEL_INFO0](/windows/desktop/api/fwptypes/ns-fwptypes-ipsec_virtual_if_tunnel_info0)*</b>
///                          Details related to virtual interface tunneling.
///    inboundFilterId = Type: <b>UINT64*</b> Optional filter identifier of the cached inbound filter corresponding to the
///                      <i>outboundTraffic</i> parameter specified by the caller. Base filtering engine (BFE) may cache the inbound
///                      filter identifier and return the cached value, if available. Caller must handle the case when BFE does not have a
///                      cached value, in which case this parameter will be set to 0.
///    id = Type: <b>UINT64*</b> The identifier of the IPsec SA context.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The IPsec SA context was created
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecSaContextCreate1(HANDLE engineHandle, const(IPSEC_TRAFFIC1)* outboundTraffic, 
                           const(IPSEC_VIRTUAL_IF_TUNNEL_INFO0)* virtualIfTunnelInfo, ulong* inboundFilterId, 
                           ulong* id);

///The <b>IPsecSaContextDeleteById0</b> function deletes an IPsec security association (SA) context.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    id = Type: <b>UINT64</b> A runtime identifier for the object being removed from the system. This identifier was
///         received from the system when the application called IPsecSaContextCreate0.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The IPsec SA context was successfully
///    deleted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecSaContextDeleteById0(HANDLE engineHandle, ulong id);

///The <b>IPsecSaContextGetById0</b> function retrieves an IPsec security association (SA) context. <div
///class="alert"><b>Note</b> <b>IPsecSaContextGetById0</b> is the specific implementation of IPsecSaContextGetById used
///in Windows Vista. See WFP Version-Independent Names and Targeting Specific Versions of Windows for more information.
///For Windows 7 and later, IPsecSaContextGetById1 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    id = Type: <b>UINT64</b> A runtime identifier for the SA context. This identifier was received from the system when
///         the application called IPsecSaContextCreate0.
///    saContext = Type: [IPSEC_SA_CONTEXT0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_context0)**</b> Address of the
///                IPsec SA context.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The IPsec SA context was successfully
///    retrieved. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecSaContextGetById0(HANDLE engineHandle, ulong id, IPSEC_SA_CONTEXT0** saContext);

///The <b>IPsecSaContextGetById1</b> function retrieves an IPsec security association (SA) context. <div
///class="alert"><b>Note</b> <b>IPsecSaContextGetById1</b> is the specific implementation of IPsecSaContextGetById used
///in Windows 7 and later. See WFP Version-Independent Names and Targeting Specific Versions of Windows for more
///information. For Windows Vista, IPsecSaContextGetById0 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    id = Type: <b>UINT64</b> A runtime identifier for the SA context. This identifier was received from the system when
///         the application called IPsecSaContextCreate0.
///    saContext = Type: [IPSEC_SA_CONTEXT1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_context1)**</b> Address of the
///                IPsec SA context.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The IPsec SA context was successfully
///    retrieved. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecSaContextGetById1(HANDLE engineHandle, ulong id, IPSEC_SA_CONTEXT1** saContext);

///The <b>IPsecSaContextGetSpi0</b> function retrieves the security parameters index (SPI) for a security association
///(SA) context. <div class="alert"><b>Note</b> <b>IPsecSaContextGetSpi0</b> is the specific implementation of
///IPsecSaContextGetSpi used in Windows Vista. See WFP Version-Independent Names and Targeting Specific Versions of
///Windows for more information. For Windows 7 and later, IPsecSaContextGetSpi1 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    id = Type: <b>UINT64</b> A runtime identifier for the SA context. This identifier was received from the system when
///         the application called IPsecSaContextCreate0.
///    getSpi = Type: [IPSEC_GETSPI0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_getspi0)*</b> The inbound IPsec
///             traffic.
///    inboundSpi = Type: <b>IPSEC_SA_SPI*</b> The inbound SA SPI. The <b>IPSEC_SA_SPI</b> data type maps to the <b>UINT32</b> data
///                 type.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The SPI for the IPsec SA context was
///    retrieved successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecSaContextGetSpi0(HANDLE engineHandle, ulong id, const(IPSEC_GETSPI0)* getSpi, uint* inboundSpi);

///The <b>IPsecSaContextGetSpi1</b> function retrieves the security parameters index (SPI) for a security association
///(SA) context. <div class="alert"><b>Note</b> <b>IPsecSaContextGetSpi1</b> is the specific implementation of
///IPsecSaContextGetSpi used in Windows 7 and later. See WFP Version-Independent Names and Targeting Specific Versions
///of Windows for more information. For Windows Vista, IPsecSaContextGetSpi0 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    id = Type: <b>UINT64</b> A runtime identifier for the SA context. This identifier was received from the system when
///         the application called IPsecSaContextCreate1.
///    getSpi = Type: [IPSEC_GETSPI1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_getspi1)*</b> The inbound IPsec
///             traffic.
///    inboundSpi = Type: <b>IPSEC_SA_SPI*</b> The inbound SA SPI. The <b>IPSEC_SA_SPI</b> data type maps to the <b>UINT32</b> data
///                 type.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The SPI for the IPsec SA context was
///    retrieved successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecSaContextGetSpi1(HANDLE engineHandle, ulong id, const(IPSEC_GETSPI1)* getSpi, uint* inboundSpi);

///The <b>IPsecSaContextSetSpi0</b> function sets the security parameters index (SPI) for a security association (SA)
///context.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    id = Type: <b>UINT64</b> A runtime identifier for the SA context. This identifier was received from the system when
///         the application called IPsecSaContextCreate1.
///    getSpi = Type: [IPSEC_GETSPI1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_getspi1)*</b> The inbound IPsec
///             traffic.
///    inboundSpi = Type: <b>IPSEC_SA_SPI</b> The inbound SA SPI. The <b>IPSEC_SA_SPI</b> data type maps to the <b>UINT32</b> data
///                 type.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The SPI for the IPsec SA context was set
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecSaContextSetSpi0(HANDLE engineHandle, ulong id, const(IPSEC_GETSPI1)* getSpi, uint inboundSpi);

///The <b>IPsecSaContextAddInbound0</b> function adds an inbound IPsec security association (SA) bundle to an existing
///SA context. <div class="alert"><b>Note</b> <b>IPsecSaContextAddInbound0</b> is the specific implementation of
///IPsecSaContextAddInbound used in Windows Vista. See WFP Version-Independent Names and Targeting Specific Versions of
///Windows for more information. For Windows 7 and later, IPsecSaContextAddInbound1 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    id = Type: <b>UINT64</b> Identifier for the existing IPsec SA context. This is the value returned in the <i>id</i>
///         parameter by the call to IPsecSaContextCreate0.
///    inboundBundle = Type: [IPSEC_SA_BUNDLE0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_bundle0)*</b> The inbound IPsec
///                    SA bundle to be added to the SA context.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The IPsec SA bundle was successfully added
///    to the SA context. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecSaContextAddInbound0(HANDLE engineHandle, ulong id, const(IPSEC_SA_BUNDLE0)* inboundBundle);

///The <b>IPsecSaContextAddOutbound0</b> function adds an outbound IPsec security association (SA) bundle to an existing
///SA context. <div class="alert"><b>Note</b> <b>IPsecSaContextAddOutbound0</b> is the specific implementation of
///IPsecSaContextAddOutbound used in Windows Vista. See WFP Version-Independent Names and Targeting Specific Versions of
///Windows for more information. For Windows 7 and later, IPsecSaContextAddOutbound1 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    id = Type: <b>UINT64</b> Identifier for the existing IPsec SA context. This is the value returned in the <i>id</i>
///         parameter by the call to IPsecSaContextCreate0.
///    outboundBundle = Type: [IPSEC_SA_BUNDLE0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_bundle0)*</b> The outbound IPsec
///                     SA bundle to be added to the SA context.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The IPsec SA bundle was successfully added
///    to the SA context. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecSaContextAddOutbound0(HANDLE engineHandle, ulong id, const(IPSEC_SA_BUNDLE0)* outboundBundle);

///The <b>IPsecSaContextAddInbound1</b> function adds an inbound IPsec security association (SA) bundle to an existing
///SA context. <div class="alert"><b>Note</b> <b>IPsecSaContextAddInbound1</b> is the specific implementation of
///IPsecSaContextAddInbound used in Windows 7 and later. See WFP Version-Independent Names and Targeting Specific
///Versions of Windows for more information. For Windows Vista, IPsecSaContextAddInbound0 is available.</div><div>
///</div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    id = Type: <b>UINT64</b> Identifier for the existing IPsec SA context. This is the value returned in the <i>id</i>
///         parameter by the call to IPsecSaContextCreate1.
///    inboundBundle = Type: [IPSEC_SA_BUNDLE1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_bundle1)*</b> The inbound IPsec
///                    SA bundle to be added to the SA context.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The IPsec SA bundle was successfully added
///    to the SA context. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecSaContextAddInbound1(HANDLE engineHandle, ulong id, const(IPSEC_SA_BUNDLE1)* inboundBundle);

///The <b>IPsecSaContextAddOutbound1</b> function adds an outbound IPsec security association (SA) bundle to an existing
///SA context. <div class="alert"><b>Note</b> <b>IPsecSaContextAddOutbound1</b> is the specific implementation of
///IPsecSaContextAddOutbound used in Windows 7 and later. See WFP Version-Independent Names and Targeting Specific
///Versions of Windows for more information. For Windows Vista, IPsecSaContextAddOutbound0 is available.</div><div>
///</div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    id = Type: <b>UINT64</b> Identifier for the existing IPsec SA context. This is the value returned in the <i>id</i>
///         parameter by the call to IPsecSaContextCreate1.
///    outboundBundle = Type: [IPSEC_SA_BUNDLE1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_bundle1)*</b> The outbound IPsec
///                     SA bundle to be added to the SA context.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The IPsec SA bundle was successfully added
///    to the SA context. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecSaContextAddOutbound1(HANDLE engineHandle, ulong id, const(IPSEC_SA_BUNDLE1)* outboundBundle);

///The <b>IPsecSaContextExpire0</b> function indicates that an IPsec security association (SA) context should be
///expired.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    id = Type: <b>UINT64</b> A runtime identifier for SA context. This identifier was received from the system when the
///         application called IPsecSaContextCreate0.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The IPsec SA context was successfully
///    expired. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecSaContextExpire0(HANDLE engineHandle, ulong id);

///The <b>IPsecSaContextUpdate0</b> function updates an IPsec security association (SA) context.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    flags = Type: <b>UINT32</b> Flags indicating the specific field in the
///            [IPSEC_SA_CONTEXT1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_context1) structure that is being
///            updated. Possible values: <table> <tr> <th>IPsec SA flag</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="IPSEC_SA_DETAILS_UPDATE_TRAFFIC"></a><a id="ipsec_sa_details_update_traffic"></a><dl>
///            <dt><b>IPSEC_SA_DETAILS_UPDATE_TRAFFIC</b></dt> </dl> </td> <td width="60%"> Updates the
///            [IPSEC_SA_DETAILS1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_details1) structure. </td> </tr> <tr>
///            <td width="40%"><a id="IPSEC_SA_DETAILS_UPDATE_UDP_ENCAPSULATION"></a><a
///            id="ipsec_sa_details_update_udp_encapsulation"></a><dl> <dt><b>IPSEC_SA_DETAILS_UPDATE_UDP_ENCAPSULATION</b></dt>
///            </dl> </td> <td width="60%"> Updates the
///            [IPSEC_SA_DETAILS1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_details1) structure. </td> </tr> <tr>
///            <td width="40%"><a id="IPSEC_SA_BUNDLE_UPDATE_FLAGS"></a><a id="ipsec_sa_bundle_update_flags"></a><dl>
///            <dt><b>IPSEC_SA_BUNDLE_UPDATE_FLAGS</b></dt> </dl> </td> <td width="60%"> Updates the
///            [IPSEC_SA_BUNDLE1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_bundle1) structure. </td> </tr> <tr>
///            <td width="40%"><a id="IPSEC_SA_BUNDLE_UPDATE_NAP_CONTEXT"></a><a
///            id="ipsec_sa_bundle_update_nap_context"></a><dl> <dt><b>IPSEC_SA_BUNDLE_UPDATE_NAP_CONTEXT</b></dt> </dl> </td>
///            <td width="60%"> Updates the [IPSEC_SA_BUNDLE1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_bundle1)
///            structure. </td> </tr> <tr> <td width="40%"><a id="IPSEC_SA_BUNDLE_UPDATE_KEY_MODULE_STATE"></a><a
///            id="ipsec_sa_bundle_update_key_module_state"></a><dl> <dt><b>IPSEC_SA_BUNDLE_UPDATE_KEY_MODULE_STATE</b></dt>
///            </dl> </td> <td width="60%"> Updates the
///            [IPSEC_SA_BUNDLE1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_bundle1) structure. </td> </tr> <tr>
///            <td width="40%"><a id="IPSEC_SA_BUNDLE_UPDATE_PEER_V4_PRIVATE_ADDRESS"></a><a
///            id="ipsec_sa_bundle_update_peer_v4_private_address"></a><dl>
///            <dt><b>IPSEC_SA_BUNDLE_UPDATE_PEER_V4_PRIVATE_ADDRESS</b></dt> </dl> </td> <td width="60%"> Updates the
///            [IPSEC_SA_BUNDLE1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_bundle1) structure. </td> </tr> <tr>
///            <td width="40%"><a id="IPSEC_SA_BUNDLE_UPDATE_MM_SA_ID"></a><a id="ipsec_sa_bundle_update_mm_sa_id"></a><dl>
///            <dt><b>IPSEC_SA_BUNDLE_UPDATE_MM_SA_ID</b></dt> </dl> </td> <td width="60%"> Updates the
///            [IPSEC_SA_BUNDLE1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_bundle1) structure. </td> </tr>
///            </table>
///    newValues = Type: [IPSEC_SA_CONTEXT1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_context1)*</b> An inbound and
///                outbound SA pair.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The IPsec SA context was updated
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecSaContextUpdate0(HANDLE engineHandle, ulong flags, const(IPSEC_SA_CONTEXT1)* newValues);

///The <b>IPsecSaContextCreateEnumHandle0</b> function creates a handle used to enumerate a set of IPsec security
///association (SA) context objects.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumTemplate = Type: <b>const IPSEC_SA_CONTEXT_ENUM_TEMPLATE0*</b> Template to selectively restrict the enumeration.
///    enumHandle = Type: <b>HANDLE*</b> Address of a <b>HANDLE</b> variable. On function return, it contains the handle for SA
///                 context enumeration.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The enumerator was created successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecSaContextCreateEnumHandle0(HANDLE engineHandle, const(IPSEC_SA_CONTEXT_ENUM_TEMPLATE0)* enumTemplate, 
                                     HANDLE* enumHandle);

///The <b>IPsecSaContextEnum0</b> function returns the next page of results from the IPsec security association (SA)
///context enumerator. <div class="alert"><b>Note</b> <b>IPsecSaContextEnum0</b> is the specific implementation of
///IPsecSaContextEnum used in Windows Vista. See WFP Version-Independent Names and Targeting Specific Versions of
///Windows for more information. For Windows 7 and later, IPsecSaContextEnum1 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle for an SA context enumeration returned by IPsecSaContextCreateEnumHandle0.
///    numEntriesRequested = Type: <b>UINT32</b> Number of SA contexts requested.
///    entries = Type: [IPSEC_SA_CONTEXT0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_context0)***</b> Addresses of
///              the enumeration entries.
///    numEntriesReturned = Type: <b>UINT32*</b> The number of SA contexts returned.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The IPsec SA contexts were enumerated
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecSaContextEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, 
                         IPSEC_SA_CONTEXT0*** entries, uint* numEntriesReturned);

///The <b>IPsecSaContextEnum1</b> function returns the next page of results from the IPsec security association (SA)
///context enumerator. <div class="alert"><b>Note</b> <b>IPsecSaContextEnum1</b> is the specific implementation of
///IPsecSaContextEnum used in Windows 7 and later. See WFP Version-Independent Names and Targeting Specific Versions of
///Windows for more information. For Windows Vista, IPsecSaContextEnum0 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle for an SA context enumeration returned by IPsecSaContextCreateEnumHandle0.
///    numEntriesRequested = Type: <b>UINT32</b> Number of SA contexts requested.
///    entries = Type: [IPSEC_SA_CONTEXT1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_context1)***</b> Addresses of
///              the enumeration entries.
///    numEntriesReturned = Type: <b>UINT32*</b> The number of SA contexts returned.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The IPsec SA contexts were enumerated
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecSaContextEnum1(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, 
                         IPSEC_SA_CONTEXT1*** entries, uint* numEntriesReturned);

///The <b>IPsecSaContextDestroyEnumHandle0</b> function frees a handle returned by IPsecSaContextCreateEnumHandle0.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle of an IPsec security association (SA) context enumeration returned by
///                 IPsecSaContextCreateEnumHandle0.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The enumerator was successfully deleted.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecSaContextDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

///The <b>IPsecSaContextSubscribe0</b> function is used to request the delivery of notifications regarding a particular
///IPsec security association (SA) context.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    subscription = Type: <b>const IPSEC_SA_CONTEXT_SUBSCRIPTION0*</b> The notifications which will be delivered.
///    callback = Type: <b>IPSEC_SA_CONTEXT_CALLBACK0</b> Function pointer that will be invoked when a notification is ready for
///               delivery.
///    context = Type: <b>void*</b> Optional context pointer. This pointer is passed to the <i>callback</i> function along with
///              details of the event.
///    eventsHandle = Type: <b>HANDLE*</b> Handle to the newly created subscription.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The subscription was created successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecSaContextSubscribe0(HANDLE engineHandle, const(IPSEC_SA_CONTEXT_SUBSCRIPTION0)* subscription, 
                              IPSEC_SA_CONTEXT_CALLBACK0 callback, void* context, HANDLE* eventsHandle);

///The <b>IPsecSaContextUnsubscribe0</b> function is used to cancel an IPsec security association (SA) change
///subscription and stop receiving change notifications.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    eventsHandle = Type: <b>HANDLE</b> Handle of the subscribed SA change notification. This is the returned handle from the call to
///                   IPsecSaContextSubscribe0. This may be <b>NULL</b>, in which case the function will have no effect.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The subscription was deleted successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecSaContextUnsubscribe0(HANDLE engineHandle, HANDLE eventsHandle);

///The <b>IPsecSaContextSubscriptionsGet0</b> function retrieves an array of all the current IPsec security association
///(SA) change notification subscriptions.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    entries = Type: <b>IPSEC_SA_CONTEXT_SUBSCRIPTION0***</b> The current IPsec SA notification subscriptions.
///    numEntries = Type: <b>UINT32*</b> The number of entries returned.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The subscriptions were retrieved
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecSaContextSubscriptionsGet0(HANDLE engineHandle, IPSEC_SA_CONTEXT_SUBSCRIPTION0*** entries, 
                                     uint* numEntries);

///The <b>IPsecSaCreateEnumHandle0</b> function creates a handle used to enumerate a set of Internet Protocol Security
///(IPsec) security association (SA) objects.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumTemplate = Type: [IPSEC_SA_ENUM_TEMPLATE0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_enum_template0)*</b>
///                   Template to selectively restrict the enumeration.
///    enumHandle = Type: <b>HANDLE*</b> Handle of the newly created enumeration.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The enumeration was created successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecSaCreateEnumHandle0(HANDLE engineHandle, const(IPSEC_SA_ENUM_TEMPLATE0)* enumTemplate, 
                              HANDLE* enumHandle);

///The <b>IPsecSaEnum0</b> function returns the next page of results from the IPsec security association (SA)
///enumerator. <div class="alert"><b>Note</b> <b>IPsecSaEnum0</b> is the specific implementation of IPsecSaEnum used in
///Windows Vista. See WFP Version-Independent Names and Targeting Specific Versions of Windows for more information. For
///Windows 7 and later, IPsecSaEnum1 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle for an IPsec SA enumeration. Call IPsecSaCreateEnumHandle0 to obtain an enumeration
///                 handle.
///    numEntriesRequested = Type: <b>UINT32</b> The number of enumeration entries requested.
///    entries = Type: [IPSEC_SA_DETAILS0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_details0)***</b> Addresses of
///              the enumeration entries.
///    numEntriesReturned = Type: <b>UINT32*</b> The number of enumeration entries returned.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The SAs were enumerated successfully. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl> </td>
///    <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td> <td
///    width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecSaEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, IPSEC_SA_DETAILS0*** entries, 
                  uint* numEntriesReturned);

///The <b>IPsecSaEnum1</b> function returns the next page of results from the IPsec security association (SA)
///enumerator. <div class="alert"><b>Note</b> <b>IPsecSaEnum1</b> is the specific implementation of IPsecSaEnum used in
///Windows 7 and later. See WFP Version-Independent Names and Targeting Specific Versions of Windows for more
///information. For Windows Vista, IPsecSaEnum0 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle for an IPsec SA enumeration. Call IPsecSaCreateEnumHandle0 to obtain an enumeration
///                 handle.
///    numEntriesRequested = Type: <b>UINT32</b> The number of enumeration entries requested.
///    entries = Type: [IPSEC_SA_DETAILS1](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_sa_details1)***</b> Addresses of
///              the enumeration entries.
///    numEntriesReturned = Type: <b>UINT32*</b> The number of enumeration entries returned.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The SAs were enumerated successfully. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl> </td>
///    <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td> <td
///    width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecSaEnum1(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, IPSEC_SA_DETAILS1*** entries, 
                  uint* numEntriesReturned);

///The <b>IPsecSaDestroyEnumHandle0</b> function frees a handle returned by IPsecSaCreateEnumHandle0.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle of the enumeration to destroy. Previously created by a call to
///                 IPsecSaCreateEnumHandle0.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The enumeration was deleted successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecSaDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

///The <b>IPsecSaDbGetSecurityInfo0</b> function retrieves a copy of the security descriptor for the IPsec security
///association (SA) database.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    securityInfo = Type: <b>SECURITY_INFORMATION</b> The type of security information to retrieve.
///    sidOwner = Type: <b>PSID*</b> The owner security identifier (SID) in the returned security descriptor.
///    sidGroup = Type: <b>PSID*</b> The primary group security identifier (SID) in the returned security descriptor.
///    dacl = Type: <b>PACL*</b> The discretionary access control list (DACL) in the returned security descriptor.
///    sacl = Type: <b>PACL*</b> The system access control list (SACL) in the returned security descriptor.
///    securityDescriptor = Type: <b>PSECURITY_DESCRIPTOR*</b> The returned security descriptor.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The security descriptor was retrieved
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecSaDbGetSecurityInfo0(HANDLE engineHandle, uint securityInfo, void** sidOwner, void** sidGroup, 
                               ACL** dacl, ACL** sacl, void** securityDescriptor);

///The <b>IPsecSaDbSetSecurityInfo0</b> function sets specified security information in the security descriptor of the
///IPsec security association database.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    securityInfo = Type: <b>SECURITY_INFORMATION</b> The type of security information to set.
///    sidOwner = Type: <b>const SID*</b> The owner's security identifier (SID) to be set in the security descriptor.
///    sidGroup = Type: <b>const SID*</b> The group's SID to be set in the security descriptor.
///    dacl = Type: <b>const ACL*</b> The discretionary access control list (DACL) to be set in the security descriptor.
///    sacl = Type: <b>const ACL*</b> The system access control list (SACL) to be set in the security descriptor.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The security information was set
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecSaDbSetSecurityInfo0(HANDLE engineHandle, uint securityInfo, const(SID)* sidOwner, const(SID)* sidGroup, 
                               const(ACL)* dacl, const(ACL)* sacl);

///The <b>IPsecDospGetStatistics0</b> function retrieves Internet Protocol Security (IPsec) DoS Protection statistics.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    idpStatistics = Type: [IPSEC_DOSP_STATISTICS0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_dosp_statistics0)*</b>
///                    Top-level object of IPsec DoS Protection statistics organization.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The IPsec DoS Protection statistics were
///    successfully returned. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecDospGetStatistics0(HANDLE engineHandle, IPSEC_DOSP_STATISTICS0* idpStatistics);

///The <b>IPsecDospStateCreateEnumHandle0</b> function creates a handle used to enumerate a set of IPsec DoS Protection
///objects.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumTemplate = Type: <b>const IPSEC_DOSP_STATE_ENUM_TEMPLATE0*</b> Template for selectively restricting the enumeration.
///    enumHandle = Type: <b>HANDLE*</b> Address of a <b>HANDLE</b> variable. On function return, it contains the handle for the
///                 newly created enumeration.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The enumeration was created successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecDospStateCreateEnumHandle0(HANDLE engineHandle, const(IPSEC_DOSP_STATE_ENUM_TEMPLATE0)* enumTemplate, 
                                     HANDLE* enumHandle);

///The <b>IPsecDospStateEnum0</b> function returns the next page of results from the IPsec DoS Protection state
///enumerator. Each IPsec DoS Protection state entry corresponds to a flow that has successfully passed the IPsec DoS
///Protection authentication checks.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle for an IPsec DoS Protection enumeration. Call IPsecDospStateCreateEnumHandle0 to
///                 obtain an enumeration handle.
///    numEntriesRequested = Type: <b>UINT32</b> The number of enumeration entries requested.
///    entries = Type: [IPSEC_DOSP_STATE0](/windows/desktop/api/ipsectypes/ns-ipsectypes-ipsec_dosp_state0)***</b> Addresses of
///              the enumeration entries.
///    numEntries = Type: <b>UINT32*</b> The number of enumeration entries returned.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The results were enumerated successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecDospStateEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, 
                         IPSEC_DOSP_STATE0*** entries, uint* numEntries);

///The <b>IPsecDospStateDestroyEnumHandle0</b> function frees a handle returned by IPsecDospStateCreateEnumHandle0.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle of the enumeration to destroy. Previously created by a call to
///                 IPsecDospStateCreateEnumHandle0.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The enumeration was deleted successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecDospStateDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

///The <b>IPsecDospGetSecurityInfo0</b> function retrieves a copy of the security descriptor for the IPsec DoS
///Protection database.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    securityInfo = Type: <b>SECURITY_INFORMATION</b> The type of security information to retrieve.
///    sidOwner = Type: <b>PSID*</b> The owner security identifier (SID) in the returned security descriptor.
///    sidGroup = Type: <b>PSID*</b> The primary group security identifier (SID) in the returned security descriptor.
///    dacl = Type: <b>PACL*</b> The discretionary access control list (DACL) in the returned security descriptor.
///    sacl = Type: <b>PACL*</b> The system access control list (SACL) in the returned security descriptor.
///    securityDescriptor = Type: <b>PSECURITY_DESCRIPTOR*</b> The returned security descriptor.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The security descriptor was retrieved
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecDospGetSecurityInfo0(HANDLE engineHandle, uint securityInfo, void** sidOwner, void** sidGroup, 
                               ACL** dacl, ACL** sacl, void** securityDescriptor);

///The <b>IPsecDospSetSecurityInfo0</b> function sets specified security information in the security descriptor of the
///IPsec DoS Protection database.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    securityInfo = Type: <b>SECURITY_INFORMATION</b> The type of security information to set.
///    sidOwner = Type: <b>const SID*</b> The owner's security identifier (SID) to be set in the security descriptor.
///    sidGroup = Type: <b>const SID*</b> The group's SID to be set in the security descriptor.
///    dacl = Type: <b>const ACL*</b> The discretionary access control list (DACL) to be set in the security descriptor.
///    sacl = Type: <b>const ACL*</b> The system access control list (SACL) to be set in the security descriptor.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The security information was set
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecDospSetSecurityInfo0(HANDLE engineHandle, uint securityInfo, const(SID)* sidOwner, const(SID)* sidGroup, 
                               const(ACL)* dacl, const(ACL)* sacl);

///The <b>IPsecKeyManagerAddAndRegister0</b> function registers a Trusted Intermediary Agent (TIA) with IPsec.
///Params:
///    engineHandle = Type: <b>HANDLE</b> A handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    keyManager = Type: <b>const IPSEC_KEY_MANAGER0*</b> The set of key management callbacks which IPsec will invoke.
///    keyManagerCallbacks = Type: <b>const IPSEC_KEY_MANAGER_CALLBACKS0*</b> The set of callbacks which should be invoked by IPsec at various
///                          stages of SA negotiation.
///    keyMgmtHandle = Type: <b>HANDLE*</b> Address of the newly created registration.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The TIA was successfully registered. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl> </td>
///    <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td> <td
///    width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>FWP_E_ALREADY_EXISTS</b></dt> <dt>0x80320009L</dt> </dl> </td> <td width="60%"> The TIA was not
///    registered successfully because another TIA has already been registered to dictate keys. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>FWP_E_INVALID_INTERVAL</b></dt> <dt>0x80320021L</dt> </dl> </td> <td width="60%"> The
///    TIA was not registered successfully because <i>keyDictationTimeoutHint</i> exceeded the maximum allowed value of
///    10 seconds. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SEC_E_CANNOT_INSTALL</b></dt> <dt>0x80090307L</dt>
///    </dl> </td> <td width="60%"> The TIA was not registered successfully because the binary image has not set the
///    <b>IMAGE_DLLCHARACTERISTICS_FORCE_INTEGRITY</b> property. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecKeyManagerAddAndRegister0(HANDLE engineHandle, const(IPSEC_KEY_MANAGER0)* keyManager, 
                                    const(IPSEC_KEY_MANAGER_CALLBACKS0)* keyManagerCallbacks, HANDLE* keyMgmtHandle);

///The <b>IPsecKeyManagerUnregisterAndDelete0</b> function unregisters a Trusted Intermediary Agent (TIA) which had
///previously been registered with IPsec.
///Params:
///    engineHandle = Type: <b>HANDLE</b> A handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    keyMgmtHandle = Type: <b>HANDLE</b> Address of the previously created registration.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The TIA was successfully unregistered.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecKeyManagerUnregisterAndDelete0(HANDLE engineHandle, HANDLE keyMgmtHandle);

///The <b>IPsecKeyManagersGet0</b> function returns a list of current Trusted Intermediary Agents (TIAs).
///Params:
///    engineHandle = Type: <b>HANDLE</b> A handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    entries = Type: <b>IPSEC_KEY_MANAGER0***</b> All of the current TIAs.
///    numEntries = Type: <b>UINT32*</b> The number of entries returned.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The list of current TIAs was successfully
///    returned. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecKeyManagersGet0(HANDLE engineHandle, IPSEC_KEY_MANAGER0*** entries, uint* numEntries);

///The <b>IPsecKeyManagerGetSecurityInfoByKey0</b> function retrieves a copy of the security descriptor that controls
///access to the key manager.
///Params:
///    engineHandle = Type: <b>HANDLE</b> A handle to an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    reserved = Type: <b>const void*</b> Reserved. Must be set to NULL.
///    securityInfo = Type: <b>SECURITY_INFORMATION</b> The type of security information to retrieve.
///    sidOwner = Type: <b>PSID*</b> The owner security identifier (SID) in the returned security descriptor.
///    sidGroup = Type: <b>PSID*</b> The primary group security identifier (SID) in the returned security descriptor.
///    dacl = Type: <b>PACL*</b> The discretionary access control list (DACL) in the returned security descriptor.
///    sacl = Type: <b>PACL*</b> The system access control list (SACL) in the returned security descriptor.
///    securityDescriptor = Type: <b>PSECURITY_DESCRIPTOR*</b> The returned security descriptor.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The security descriptor was successfully
///    retrieved. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecKeyManagerGetSecurityInfoByKey0(HANDLE engineHandle, const(void)* reserved, uint securityInfo, 
                                          void** sidOwner, void** sidGroup, ACL** dacl, ACL** sacl, 
                                          void** securityDescriptor);

///The <b>IPsecKeyManagerSetSecurityInfoByKey0</b> function sets specified security information in the security
///descriptor that controls access to the key manager.
///Params:
///    engineHandle = Type: <b>HANDLE</b> A handle to an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    reserved = Type: <b>const void*</b> Reserved. Should be specified as NULL.
///    securityInfo = Type: <b>SECURITY_INFORMATION</b> The type of security information to set.
///    sidOwner = Type: <b>const SID*</b> The owner's security identifier (SID) to be set in the security descriptor.
///    sidGroup = Type: <b>const SID*</b> The group's SID to be set in the security descriptor.
///    dacl = Type: <b>const ACL*</b> The discretionary access control list (DACL) to be set in the security descriptor.
///    sacl = Type: <b>const ACL*</b> The system access control list (SACL) to be set in the security descriptor.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The security information was successfully
///    set. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt>
///    </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl>
///    </td> <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IPsecKeyManagerSetSecurityInfoByKey0(HANDLE engineHandle, const(void)* reserved, uint securityInfo, 
                                          const(SID)* sidOwner, const(SID)* sidGroup, const(ACL)* dacl, 
                                          const(ACL)* sacl);

///The <b>IkeextGetStatistics0</b> function retrieves Internet Key Exchange (IKE) and Authenticated Internet Protocol
///(AuthIP) statistics. <div class="alert"><b>Note</b> <b>IkeextGetStatistics0</b> is the specific implementation of
///IkeextGetStatistics used in Windows Vista. See WFP Version-Independent Names and Targeting Specific Versions of
///Windows for more information. For Windows 7 and later, IkeextGetStatistics1 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine generated by a previous call to
///                   FwpmEngineOpen0.
///    ikeextStatistics = Type: [IKEEXT_STATISTICS0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_statistics0)*</b> The top-level
///                       object of IKE/AuthIP statistics organization.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The information was retrieved successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IkeextGetStatistics0(HANDLE engineHandle, IKEEXT_STATISTICS0* ikeextStatistics);

///The <b>IkeextGetStatistics1</b> function retrieves Internet Key Exchange (IKE) and Authenticated Internet Protocol
///(AuthIP) statistics. <div class="alert"><b>Note</b> <b>IkeextGetStatistics1</b> is the specific implementation of
///IkeextGetStatistics used in Windows 7 and later. See WFP Version-Independent Names and Targeting Specific Versions of
///Windows for more information. For Windows Vista, IkeextGetStatistics0 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine generated by a previous call to
///                   FwpmEngineOpen0.
///    ikeextStatistics = Type: [IKEEXT_STATISTICS1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_statistics1)*</b> The top-level
///                       object of IKE/AuthIP statistics organization.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The information was retrieved successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IkeextGetStatistics1(HANDLE engineHandle, IKEEXT_STATISTICS1* ikeextStatistics);

///The <b>IkeextSaDeleteById0</b> function removes a security association (SA) from the database.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine generated by a previous call to
///                   FwpmEngineOpen0.
///    id = Type: <b>UINT64</b> The SA identifier.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The SA was removed successfully. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl> </td>
///    <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td> <td
///    width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IkeextSaDeleteById0(HANDLE engineHandle, ulong id);

///The <b>IkeextSaGetById0</b> function retrieves an IKE/AuthIP security association (SA) from the database. <div
///class="alert"><b>Note</b> <b>IkeextSaGetById0</b> is the specific implementation of IkeextSaGetById used in Windows
///Vista. See WFP Version-Independent Names and Targeting Specific Versions of Windows for more information. For Windows
///7, IkeextSaGetById1 is available. For Windows 8, IkeextSaGetById2 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    id = Type: <b>UINT64</b> The SA identifier.
///    sa = Type: [IKEEXT_SA_DETAILS0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_sa_details0)**</b> Address of the SA
///         details.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The SA was retrieved successfully. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl> </td>
///    <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td> <td
///    width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IkeextSaGetById0(HANDLE engineHandle, ulong id, IKEEXT_SA_DETAILS0** sa);

///The <b>IkeextSaGetById1</b> function retrieves an IKE/AuthIP security association (SA) from the database. <div
///class="alert"><b>Note</b> <b>IkeextSaGetById1</b> is the specific implementation of IkeextSaGetById used in Windows
///7. See WFP Version-Independent Names and Targeting Specific Versions of Windows for more information. For Windows 8,
///IkeextSaGetById2 is available. For Windows Vista, IkeextSaGetById0 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    id = Type: <b>UINT64</b> The SA identifier.
///    saLookupContext = Type: <b>GUID*</b> Optional pointer to the SA lookup context propagated from the SA to data connections flowing
///                      over that SA. It is made available to any application that queries socket security properties using the Winsock
///                      API WSAQuerySocketSecurity function, allowing the application to obtain detailed IPsec authentication information
///                      for its connection.
///    sa = Type: [IKEEXT_SA_DETAILS1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_sa_details1)**</b> Address of the SA
///         details.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The SA was retrieved successfully. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl> </td>
///    <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td> <td
///    width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IkeextSaGetById1(HANDLE engineHandle, ulong id, GUID* saLookupContext, IKEEXT_SA_DETAILS1** sa);

///The <b>IkeextSaGetById2</b> function retrieves an IKE/AuthIP security association (SA) from the database. <div
///class="alert"><b>Note</b> <b>IkeextSaGetById2</b> is the specific implementation of IkeextSaGetById used in Windows
///8. See WFP Version-Independent Names and Targeting Specific Versions of Windows for more information. For Windows 7,
///IkeextSaGetById1 is available. For Windows Vista, IkeextSaGetById0 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    id = Type: <b>UINT64</b> The SA identifier.
///    saLookupContext = Type: <b>GUID*</b> Optional pointer to the SA lookup context propagated from the SA to data connections flowing
///                      over that SA. It is made available to any application that queries socket security properties using the Winsock
///                      API WSAQuerySocketSecurity function, allowing the application to obtain detailed IPsec authentication information
///                      for its connection.
///    sa = Type: [IKEEXT_SA_DETAILS2](/windows/desktop/api/iketypes/ns-iketypes-ikeext_sa_details2)**</b> Address of the SA
///         details.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The SA was retrieved successfully. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl> </td>
///    <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td> <td
///    width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IkeextSaGetById2(HANDLE engineHandle, ulong id, GUID* saLookupContext, IKEEXT_SA_DETAILS2** sa);

///The <b>IkeextSaCreateEnumHandle0</b> function creates a handle used to enumerate a set of Internet Key Exchange (IKE)
///and Authenticated Internet Protocol (AuthIP) security association (SA) objects.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine generated by a previous call to
///                   FwpmEngineOpen0.
///    enumTemplate = Type: [IKEEXT_SA_ENUM_TEMPLATE0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_sa_enum_template0)*</b>
///                   Template for selectively restricting the enumeration.
///    enumHandle = Type: <b>HANDLE*</b> Address of a <b>HANDLE</b> variable. On function return, it contains the handle of the newly
///                 created enumeration.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The enumeration was created successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IkeextSaCreateEnumHandle0(HANDLE engineHandle, const(IKEEXT_SA_ENUM_TEMPLATE0)* enumTemplate, 
                               HANDLE* enumHandle);

///The <b>IkeextSaEnum0</b> function returns the next page of results from the IKE/AuthIP security association (SA)
///enumerator. <div class="alert"><b>Note</b> <b>IkeextSaEnum0</b> is the specific implementation of IkeextSaEnum used
///in Windows Vista. See WFP Version-Independent Names and Targeting Specific Versions of Windows for more information.
///For Windows 7, IkeextSaEnum1 is available. For Windows 8, IkeextSaEnum2 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle for an IKE/AuthIP SA enumeration. Call IkeextSaCreateEnumHandle0 to obtain an
///                 enumeration handle.
///    numEntriesRequested = Type: <b>UINT32</b> Number of enumeration entries requested.
///    entries = Type: [IKEEXT_SA_DETAILS0](/windows/desktop/api/iketypes/ns-iketypes-ikeext_sa_details0)***</b> Addresses of the
///              enumeration entries.
///    numEntriesReturned = Type: <b>UINT32*</b> The number of enumeration entries returned.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The SAs were enumerated successfully. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl> </td>
///    <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td> <td
///    width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IkeextSaEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, IKEEXT_SA_DETAILS0*** entries, 
                   uint* numEntriesReturned);

///The <b>IkeextSaEnum1</b> function returns the next page of results from the IKE/AuthIP security association (SA)
///enumerator. <div class="alert"><b>Note</b> <b>IkeextSaEnum1</b> is the specific implementation of IkeextSaEnum used
///in Windows 7. See WFP Version-Independent Names and Targeting Specific Versions of Windows for more information. For
///Windows 8, IkeextSaEnum2 is available. For Windows Vista, IkeextSaEnum0 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle for an IKE/AuthIP SA enumeration. Call IkeextSaCreateEnumHandle0 to obtain an
///                 enumeration handle.
///    numEntriesRequested = Type: <b>UINT32</b> Number of enumeration entries requested.
///    entries = Type: [IKEEXT_SA_DETAILS1](/windows/desktop/api/iketypes/ns-iketypes-ikeext_sa_details1)***</b> Addresses of the
///              enumeration entries.
///    numEntriesReturned = Type: <b>UINT32*</b> The number of enumeration entries returned.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The SAs were enumerated successfully. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl> </td>
///    <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td> <td
///    width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IkeextSaEnum1(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, IKEEXT_SA_DETAILS1*** entries, 
                   uint* numEntriesReturned);

///The <b>IkeextSaEnum2</b> function returns the next page of results from the IKE/AuthIP security association (SA)
///enumerator. <div class="alert"><b>Note</b> <b>IkeextSaEnum2</b> is the specific implementation of IkeextSaEnum used
///in Windows 8. See WFP Version-Independent Names and Targeting Specific Versions of Windows for more information. For
///Windows 7, IkeextSaEnum1 is available. For Windows Vista, IkeextSaEnum0 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle for an IKE/AuthIP SA enumeration. Call IkeextSaCreateEnumHandle0 to obtain an
///                 enumeration handle.
///    numEntriesRequested = Type: <b>UINT32</b> Number of enumeration entries requested.
///    entries = Type: [IKEEXT_SA_DETAILS2](/windows/desktop/api/iketypes/ns-iketypes-ikeext_sa_details2)***</b> Addresses of the
///              enumeration entries.
///    numEntriesReturned = Type: <b>UINT32*</b> The number of enumeration entries returned.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The SAs were enumerated successfully. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl> </td>
///    <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td> <td
///    width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IkeextSaEnum2(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, IKEEXT_SA_DETAILS2*** entries, 
                   uint* numEntriesReturned);

///The <b>IkeextSaDestroyEnumHandle0</b> function frees a handle returned by IkeextSaCreateEnumHandle0.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine generated by a previous call to
///                   FwpmEngineOpen0.
///    enumHandle = Type: <b>HANDLE</b> Handle of the enumeration to destroy. Previously created by a call to
///                 IkeextSaCreateEnumHandle0.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The enumeration was deleted successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IkeextSaDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

///The <b>IkeextSaDbGetSecurityInfo0</b> function retrieves a copy of the security descriptor for a security association
///(SA) database.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine generated by a previous call to
///                   FwpmEngineOpen0.
///    securityInfo = Type: <b>SECURITY_INFORMATION</b> The type of security information to retrieve.
///    sidOwner = Type: <b>PSID*</b> The owner security identifier (SID) in the returned security descriptor.
///    sidGroup = Type: <b>PSID*</b> The primary group security identifier (SID) in the returned security descriptor.
///    dacl = Type: <b>PACL*</b> The discretionary access control list (DACL) in the returned security descriptor.
///    sacl = Type: <b>PACL*</b> The system access control list (SACL) in the returned security descriptor.
///    securityDescriptor = Type: <b>PSECURITY_DESCRIPTOR*</b> The returned security descriptor.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The security descriptor was retrieved
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IkeextSaDbGetSecurityInfo0(HANDLE engineHandle, uint securityInfo, void** sidOwner, void** sidGroup, 
                                ACL** dacl, ACL** sacl, void** securityDescriptor);

///The <b>IkeextSaDbSetSecurityInfo0</b> function sets specified security information in the security descriptor of the
///IKE/AuthIP security association database.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine generated by a previous call to
///                   FwpmEngineOpen0.
///    securityInfo = Type: <b>SECURITY_INFORMATION</b> The type of security information to set.
///    sidOwner = Type: <b>const SID*</b> The owner's security identifier (SID) to be set in the security descriptor.
///    sidGroup = Type: <b>const SID*</b> The group's SID to be set in the security descriptor.
///    dacl = Type: <b>const ACL*</b> The discretionary access control list (DACL) to be set in the security descriptor.
///    sacl = Type: <b>const ACL*</b> The system access control list (SACL) to be set in the security descriptor.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The security information was set
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint IkeextSaDbSetSecurityInfo0(HANDLE engineHandle, uint securityInfo, const(SID)* sidOwner, const(SID)* sidGroup, 
                                const(ACL)* dacl, const(ACL)* sacl);

///The <b>FwpmNetEventCreateEnumHandle0</b> function creates a handle used to enumerate a set of network events.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumTemplate = Type:
///                   [FWPM_NET_EVENT_ENUM_TEMPLATE0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_net_event_enum_template0)*</b>
///                   Template to selectively restrict the enumeration.
///    enumHandle = Type: <b>HANDLE*</b> The handle for network event enumeration.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The enumerator was created successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmNetEventCreateEnumHandle0(HANDLE engineHandle, const(FWPM_NET_EVENT_ENUM_TEMPLATE0)* enumTemplate, 
                                   HANDLE* enumHandle);

///The <b>FwpmNetEventEnum0</b> function returns the next page of results from the network event enumerator. <div
///class="alert"><b>Note</b> <b>FwpmNetEventEnum0</b> is the specific implementation of FwpmNetEventEnum used in Windows
///Vista. See WFP Version-Independent Names and Targeting Specific Versions of Windows for more information. For Windows
///7, FwpmNetEventEnum1 is available. For Windows 8, FwpmNetEventEnum2 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle for a network event enumeration created by a call to FwpmNetEventCreateEnumHandle0.
///    numEntriesRequested = Type: <b>UINT32</b> The number of enumeration entries requested.
///    entries = Type: [FWPM_NET_EVENT0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_net_event0)***</b> Addresses of
///              enumeration entries.
///    numEntriesReturned = Type: <b>UINT32*</b> The number of enumeration entries returned.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The network events were enumerated
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_NET_EVENTS_DISABLED</b></dt>
///    <dt>0x80320013</dt> </dl> </td> <td width="60%"> The collection of network diagnostic events is disabled. Call
///    FwpmEngineSetOption0 to enable it. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmNetEventEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, 
                       FWPM_NET_EVENT0*** entries, uint* numEntriesReturned);

///The <b>FwpmNetEventEnum1</b> function returns the next page of results from the network event enumerator. <div
///class="alert"><b>Note</b> <b>FwpmNetEventEnum1</b> is the specific implementation of FwpmNetEventEnum used in Windows
///7 and later. See WFP Version-Independent Names and Targeting Specific Versions of Windows for more information. For
///Windows 8, FwpmNetEventEnum2 is available. For Windows Vista, FwpmNetEventEnum0 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle for a network event enumeration created by a call to FwpmNetEventCreateEnumHandle0.
///    numEntriesRequested = Type: <b>UINT32</b> The nmber of enumeration entries requested.
///    entries = Type: [FWPM_NET_EVENT1](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_net_event1)***</b> Addresses of
///              enumeration entries.
///    numEntriesReturned = Type: <b>UINT32*</b> The number of enumeration entries returned.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The network events were enumerated
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_NET_EVENTS_DISABLED</b></dt>
///    <dt>0x80320013</dt> </dl> </td> <td width="60%"> The collection of network diagnostic events is disabled. Call
///    FwpmEngineSetOption0 to enable it. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmNetEventEnum1(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, 
                       FWPM_NET_EVENT1*** entries, uint* numEntriesReturned);

///The <b>FwpmNetEventEnum2</b> function returns the next page of results from the network event enumerator. <div
///class="alert"><b>Note</b> <b>FwpmNetEventEnum2</b> is the specific implementation of FwpmNetEventEnum used in Windows
///8 and later. See WFP Version-Independent Names and Targeting Specific Versions of Windows for more information. For
///Windows 7, FwpmNetEventEnum1 is available. For Windows Vista, FwpmNetEventEnum0 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle for a network event enumeration created by a call to FwpmNetEventCreateEnumHandle0.
///    numEntriesRequested = Type: <b>UINT32</b> The number of enumeration entries requested.
///    entries = Type: [FWPM_NET_EVENT2](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_net_event2)***</b> Addresses of
///              enumeration entries.
///    numEntriesReturned = Type: <b>UINT32*</b> The number of enumeration entries returned.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The network events were enumerated
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_NET_EVENTS_DISABLED</b></dt>
///    <dt>0x80320013</dt> </dl> </td> <td width="60%"> The collection of network diagnostic events is disabled. Call
///    FwpmEngineSetOption0 to enable it. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmNetEventEnum2(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, 
                       FWPM_NET_EVENT2*** entries, uint* numEntriesReturned);

///The <b>FwpmNetEventEnum3</b> function returns the next page of results from the network event enumerator. <div
///class="alert"><b>Note</b> <b>FwpmNetEventEnum3</b> s the specific implementation of <b>FwpmNetEventEnum</b> used in
///Windows 10, version 1607 and later. See WFP Version-Independent Names and Targeting Specific Versions of Windows for
///more information. For Windows 8, FwpmNetEventEnum2 is available. For Windows 7, FwpmNetEventEnum1 is available. For
///Windows Vista, FwpmNetEventEnum0 is available.</div><div> </div>
///Params:
///    engineHandle = Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to the filter engine.
///    enumHandle = Handle for a network event enumeration created by a call to FwpmNetEventCreateEnumHandle0.
///    numEntriesRequested = The number of enumeration entries requested.
///    entries = Addresses of enumeration entries.
///    numEntriesReturned = The number of enumeration entries returned.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The network events were enumerated
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_NET_EVENTS_DISABLED</b></dt>
///    <dt>0x80320013</dt> </dl> </td> <td width="60%"> The collection of network diagnostic events is disabled. Call
///    FwpmEngineSetOption0 to enable it. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmNetEventEnum3(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, 
                       FWPM_NET_EVENT3*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt")
uint FwpmNetEventEnum4(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, 
                       FWPM_NET_EVENT4_*** entries, uint* numEntriesReturned);

@DllImport("fwpuclnt")
uint FwpmNetEventEnum5(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, 
                       FWPM_NET_EVENT5_*** entries, uint* numEntriesReturned);

///The <b>FwpmNetEventDestroyEnumHandle0</b> function frees a handle returned by FwpmNetEventCreateEnumHandle0.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle of a network event enumeration created by a call to FwpmNetEventCreateEnumHandle0.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The enumerator was successfully deleted.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmNetEventDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

///The <b>FwpmNetEventsGetSecurityInfo0</b> function retrieves a copy of the security descriptor for a network event
///object.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    securityInfo = Type: <b>SECURITY_INFORMATION</b> The type of security information to retrieve. Type: <b>SECURITY_INFORMATION</b>
///                   The type of security information to retrieve.
///    sidOwner = Type: <b>PSID*</b> The owner security identifier (SID) in the returned security descriptor.
///    sidGroup = Type: <b>PSID*</b> The primary group security identifier (SID) in the returned security descriptor.
///    dacl = Type: <b>PACL*</b> The discretionary access control list (DACL) in the returned security descriptor.
///    sacl = Type: <b>PACL*</b> The system access control list (SACL) in the returned security descriptor.
///    securityDescriptor = Type: <b>PSECURITY_DESCRIPTOR*</b> The returned security descriptor.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The security descriptor was retrieved
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmNetEventsGetSecurityInfo0(HANDLE engineHandle, uint securityInfo, void** sidOwner, void** sidGroup, 
                                   ACL** dacl, ACL** sacl, void** securityDescriptor);

///The <b>FwpmNetEventsSetSecurityInfo0</b> function sets specified security information in the security descriptor of a
///network event object.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    securityInfo = Type: <b>SECURITY_INFORMATION</b> The type of security information to set.
///    sidOwner = Type: <b>const SID*</b> The owner's security identifier (SID) to be set in the security descriptor.
///    sidGroup = Type: <b>const SID*</b> The group's SID to be set in the security descriptor.
///    dacl = Type: <b>const ACL*</b> The discretionary access control list (DACL) to be set in the security descriptor.
///    sacl = Type: <b>const ACL*</b> The system access control list (SACL) to be set in the security descriptor.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The security descriptor was set
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmNetEventsSetSecurityInfo0(HANDLE engineHandle, uint securityInfo, const(SID)* sidOwner, 
                                   const(SID)* sidGroup, const(ACL)* dacl, const(ACL)* sacl);

///The <b>FwpmNetEventSubscribe0</b> function is used to request the delivery of notifications regarding a particular
///net event. <div class="alert"><b>Note</b> <b>FwpmNetEventSubscribe0</b> is the specific implementation of
///FwpmNetEventSubscribe used in Windows 7. See WFP Version-Independent Names and Targeting Specific Versions of Windows
///for more information. For Windows 8, FwpmNetEventSubscribe1 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    subscription = Type:
///                   [FWPM_NET_EVENT_SUBSCRIPTION0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_net_event_subscription0)*</b> The
///                   notifications which will be delivered.
///    callback = Type: <b>FWPM_NET_EVENT_CALLBACK0</b> Function pointer that will be invoked when a notification is ready for
///               delivery.
///    context = Type: <b>void*</b> Optional context pointer. This pointer is passed to the <i>callback</i> function along with
///              details of the event.
///    eventsHandle = Type: <b>HANDLE*</b> Handle to the newly created subscription.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The subscription was created successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmNetEventSubscribe0(HANDLE engineHandle, const(FWPM_NET_EVENT_SUBSCRIPTION0)* subscription, 
                            FWPM_NET_EVENT_CALLBACK0 callback, void* context, HANDLE* eventsHandle);

///The <b>FwpmNetEventUnsubscribe0</b> function is used to cancel a net event subscription and stop receiving
///notifications.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    eventsHandle = Type: <b>HANDLE</b> Handle of the subscribed event notification. This is the returned handle from the call to
///                   FwpmNetEventSubscribe0. This may be <b>NULL</b>, in which case the function will have no effect.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The subscription was deleted successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmNetEventUnsubscribe0(HANDLE engineHandle, HANDLE eventsHandle);

///The <b>FwpmNetEventSubscriptionsGet0</b> function retrieves an array of all the current net event notification
///subscriptions.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    entries = Type:
///              [FWPM_NET_EVENT_SUBSCRIPTION0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_net_event_subscription0)***</b>
///              The current net event notification subscriptions.
///    numEntries = Type: <b>UINT32*</b> The number of entries returned.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The subscriptions were retrieved
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmNetEventSubscriptionsGet0(HANDLE engineHandle, FWPM_NET_EVENT_SUBSCRIPTION0*** entries, uint* numEntries);

///The <b>FwpmNetEventSubscribe1</b> function is used to request the delivery of notifications regarding a particular
///net event. <div class="alert"><b>Note</b> <b>FwpmNetEventSubscribe1</b> is the specific implementation of
///FwpmNetEventSubscribe used in Windows 8 and later. See WFP Version-Independent Names and Targeting Specific Versions
///of Windows for more information. For Windows 7, FwpmNetEventSubscribe0 is available.</div><div> </div>
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    subscription = Type:
///                   [FWPM_NET_EVENT_SUBSCRIPTION0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_net_event_subscription0)*</b> The
///                   notifications which will be delivered.
///    callback = Type: <b>FWPM_NET_EVENT_CALLBACK1</b> Function pointer that will be invoked when a notification is ready for
///               delivery.
///    context = Type: <b>void*</b> Optional context pointer. This pointer is passed to the <i>callback</i> function along with
///              details of the event.
///    eventsHandle = Type: <b>HANDLE*</b> Handle to the newly created subscription.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The subscription was created successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmNetEventSubscribe1(HANDLE engineHandle, const(FWPM_NET_EVENT_SUBSCRIPTION0)* subscription, 
                            FWPM_NET_EVENT_CALLBACK1 callback, void* context, HANDLE* eventsHandle);

///The <b>FwpmNetEventSubscribe2</b> function is used to request the delivery of notifications regarding a particular
///net event. <div class="alert"><b>Note</b> <b>FwpmNetEventSubscribe2</b> is the specific implementation of
///<b>FwpmNetEventSubscribe</b> used in Windows 10, version 1607 and later. See WFP Version-Independent Names and
///Targeting Specific Versions of Windows for more information. For Windows 8, FwpmNetEventSubscribe1 is available. For
///Windows 7, FwpmNetEventSubscribe0 is available.</div><div> </div>
///Params:
///    engineHandle = Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to the filter engine.
///    subscription = The notifications which will be delivered.
///    callback = Function pointer that will be invoked when a notification is ready for delivery.
///    context = Optional context pointer. This pointer is passed to the <i>callback</i> function along with details of the event.
///    eventsHandle = Handle to the newly created subscription.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The subscription was created successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmNetEventSubscribe2(HANDLE engineHandle, const(FWPM_NET_EVENT_SUBSCRIPTION0)* subscription, 
                            FWPM_NET_EVENT_CALLBACK2 callback, void* context, HANDLE* eventsHandle);

@DllImport("fwpuclnt")
uint FwpmNetEventSubscribe3(HANDLE engineHandle, const(FWPM_NET_EVENT_SUBSCRIPTION0)* subscription, 
                            FWPM_NET_EVENT_CALLBACK3 callback, void* context, HANDLE* eventsHandle);

@DllImport("fwpuclnt")
uint FwpmNetEventSubscribe4(HANDLE engineHandle, const(FWPM_NET_EVENT_SUBSCRIPTION0)* subscription, 
                            FWPM_NET_EVENT_CALLBACK4 callback, void* context, HANDLE* eventsHandle);

///The <b>FwpmSystemPortsGet0</b> function retrieves an array of all of the system port types.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Optional handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a
///                   session to the filter engine.
///    sysPorts = Type: [FWPM_SYSTEM_PORTS0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_system_ports0)**</b> The array of
///               system port types.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The subscriptions were retrieved
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmSystemPortsGet0(HANDLE engineHandle, FWPM_SYSTEM_PORTS0** sysPorts);

///The <b>FwpmSystemPortsSubscribe0</b> function is used to request the delivery of notifications regarding a particular
///system port.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    reserved = Type: <b>void*</b> Reserved.
///    callback = Type: <b>FWPM_SYSTEM_PORTS_CALLBACK0</b> Function pointer that will be invoked when a notification is ready for
///               delivery.
///    context = Type: <b>void*</b> Optional context pointer. This pointer is passed to the <i>callback</i> function along with
///              details of the system port.
///    sysPortsHandle = Type: <b>HANDLE*</b> Handle to the newly created subscription.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The subscription was created successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmSystemPortsSubscribe0(HANDLE engineHandle, void* reserved, FWPM_SYSTEM_PORTS_CALLBACK0 callback, 
                               void* context, HANDLE* sysPortsHandle);

///The <b>FwpmSystemPortsUnsubscribe0</b> function is used to cancel a system port subscription and stop receiving
///notifications.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    sysPortsHandle = Type: <b>HANDLE</b> Handle of the subscribed system port notification. This is the returned handle from the call
///                     to FwpmSystemPortsSubscribe0.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The subscription was deleted successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmSystemPortsUnsubscribe0(HANDLE engineHandle, HANDLE sysPortsHandle);

///The <b>FwpmConnectionGetById0</b> function retrieves a connection object.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    id = Type: <b>UINT64</b> The run-time identifier for the connection.
///    connection = Type: [FWPM_CONNECTION0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_connection0)**</b> The connection
///                 information.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The connection object was retrieved
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmConnectionGetById0(HANDLE engineHandle, ulong id, FWPM_CONNECTION0** connection);

///The <b>FwpmConnectionEnum0</b> function returns the next page of results from the connection object enumerator.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle for a provider context enumeration created by a call to
///                 FwpmConnectionCreateEnumHandle0.
///    numEntriesRequested = Type: <b>UINT32</b> Number of connection objects requested.
///    entries = Type: [FWPM_CONNECTION0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_connection0)***</b> Addresses of
///              enumeration entries.
///    numEntriesReturned = Type: <b>UINT32*</b>
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The connection objects were enumerated
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmConnectionEnum0(HANDLE engineHandle, HANDLE enumHandle, uint numEntriesRequested, 
                         FWPM_CONNECTION0*** entries, uint* numEntriesReturned);

///The <b>FwpmConnectionCreateEnumHandle0</b> function creates a handle used to enumerate a set of connection objects.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumTemplate = Type:
///                   [FWPM_CONNECTION_ENUM_TEMPLATE0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_connection_enum_template0)*</b>
///                   Template for selectively restricting the enumeration.
///    enumHandle = Type: <b>HANDLE*</b> Address of a <b>HANDLE</b> variable. On function return, it contains the handle for the
///                 enumeration.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The enumerator was created successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmConnectionCreateEnumHandle0(HANDLE engineHandle, const(FWPM_CONNECTION_ENUM_TEMPLATE0)* enumTemplate, 
                                     HANDLE* enumHandle);

///The <b>FwpmConnectionDestroyEnumHandle0</b> function frees a handle returned by FwpmConnectionCreateEnumHandle0.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    enumHandle = Type: <b>HANDLE</b> Handle of a connection object enumeration created by a call to
///                 FwpmProviderContextCreateEnumHandle0.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The enumerator was successfully deleted.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmConnectionDestroyEnumHandle0(HANDLE engineHandle, HANDLE enumHandle);

///The <b>FwpmConnectionGetSecurityInfo0</b> function retrieves a copy of the security descriptor for a connection
///object change event.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    securityInfo = Type: <b>SECURITY_INFORMATION</b> The type of security information to retrieve.
///    sidOwner = Type: <b>PSID*</b> The owner security identifier (SID) in the returned security descriptor.
///    sidGroup = Type: <b>PSID*</b> The primary group security identifier (SID) in the returned security descriptor.
///    dacl = Type: <b>PACL*</b> The discretionary access control list (DACL) in the returned security descriptor.
///    sacl = Type: <b>PACL*</b> The system access control list (SACL) in the returned security descriptor.
///    securityDescriptor = Type: <b>PSECURITY_DESCRIPTOR*</b> The returned security descriptor.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The security descriptor was successfully
///    retrieved. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmConnectionGetSecurityInfo0(HANDLE engineHandle, uint securityInfo, void** sidOwner, void** sidGroup, 
                                    ACL** dacl, ACL** sacl, void** securityDescriptor);

///The <b>FwpmConnectionSetSecurityInfo0</b> function sets specified security information in the security descriptor for
///a connection object change event.
///Params:
///    engineHandle = Type: <b>HANDLE</b> A handle to an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    securityInfo = Type: <b>SECURITY_INFORMATION</b> The type of security information to set.
///    sidOwner = Type: <b>const SID*</b> The owner's security identifier (SID) to be set in the security descriptor.
///    sidGroup = Type: <b>const SID*</b> The group's SID to be set in the security descriptor.
///    dacl = Type: <b>const ACL*</b> The discretionary access control list (DACL) to be set in the security descriptor.
///    sacl = Type: <b>const ACL*</b> The system access control list (SACL) to be set in the security descriptor.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The security information was successfully
///    set. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt>
///    </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl>
///    </td> <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmConnectionSetSecurityInfo0(HANDLE engineHandle, uint securityInfo, const(SID)* sidOwner, 
                                    const(SID)* sidGroup, const(ACL)* dacl, const(ACL)* sacl);

///The <b>FwpmConnectionSubscribe0</b> function is used to request the delivery of notifications about changes to a
///connection object.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    subscription = Type:
///                   [FWPM_CONNECTION_SUBSCRIPTION0](/windows/desktop/api/fwpmtypes/ns-fwpmtypes-fwpm_connection_subscription0)*</b>
///                   The notifications which will be delivered.
///    callback = Type: <b>FWPM_CONNECTION_CALLBACK0</b> Function pointer that will be invoked when a notification is ready for
///               delivery.
///    context = Type: <b>void*</b> Optional context pointer. This pointer is passed to the <i>callback</i> function along with
///              details of the event.
///    eventsHandle = Type: <b>HANDLE*</b> Handle to the newly created subscription.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The subscription was created successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmConnectionSubscribe0(HANDLE engineHandle, const(FWPM_CONNECTION_SUBSCRIPTION0)* subscription, 
                              FWPM_CONNECTION_CALLBACK0 callback, void* context, HANDLE* eventsHandle);

///The <b>FwpmConnectionUnsubscribe0</b> function is used to cancel a connection object change event subscription and
///stop receiving notifications.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    eventsHandle = Type: <b>HANDLE</b> Handle of the subscribed event notification. This is the returned handle from the call to
///                   FwpmConnectionSubscribe0. This may be <b>NULL</b>, in which case the function will have no effect.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The subscription was deleted successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmConnectionUnsubscribe0(HANDLE engineHandle, HANDLE eventsHandle);

///The <b>FwpmvSwitchEventSubscribe0</b> function is used to request the delivery of notifications regarding a
///particular vSwitch event.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    subscription = Type: <b>const FWPM_VSWITCH_EVENT_SUBSCRIPTION0*</b> The notifications which will be delivered.
///    callback = Type: <b>FWPM_VSWITCH_EVENT_CALLBACK0</b> Function pointer that will be invoked when a notification is ready for
///               delivery.
///    context = Type: <b>void*</b> Optional context pointer. This pointer is passed to the <i>callback</i> function along with
///              details of the event.
///    subscriptionHandle = Type: <b>HANDLE*</b> Handle to the newly created subscription.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The subscription was created successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmvSwitchEventSubscribe0(HANDLE engineHandle, const(FWPM_VSWITCH_EVENT_SUBSCRIPTION0)* subscription, 
                                FWPM_VSWITCH_EVENT_CALLBACK0 callback, void* context, HANDLE* subscriptionHandle);

///The <b>FwpmvSwitchEventUnsubscribe0</b> function is used to cancel a vSwitch event subscription and stop receiving
///notifications.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    subscriptionHandle = Type: <b>HANDLE</b> Handle of the subscribed event notification. This is the returned handle from the call to
///                         FwpmvSwitchEventSubscribe0. This may be <b>NULL</b>, in which case the function will have no effect.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The subscription was deleted successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt> </dl>
///    </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl> </td>
///    <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmvSwitchEventUnsubscribe0(HANDLE engineHandle, HANDLE subscriptionHandle);

///The <b>FwpmvSwitchEventsGetSecurityInfo0</b> function retrieves a copy of the security descriptor for a vSwitch
///event.
///Params:
///    engineHandle = Type: <b>HANDLE</b> Handle for an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    securityInfo = Type: <b>SECURITY_INFORMATION</b> The type of security information to retrieve.
///    sidOwner = Type: <b>PSID*</b> The owner security identifier (SID) in the returned security descriptor.
///    sidGroup = Type: <b>PSID*</b> The primary group security identifier (SID) in the returned security descriptor.
///    dacl = Type: <b>PACL*</b> The discretionary access control list (DACL) in the returned security descriptor.
///    sacl = Type: <b>PACL*</b> The system access control list (SACL) in the returned security descriptor.
///    securityDescriptor = Type: <b>PSECURITY_DESCRIPTOR*</b> The returned security descriptor.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The security descriptor was successfully
///    retrieved. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt>
///    <dt>0x80320001—0x80320039</dt> </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error.
///    See WFP Error Codes for details. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt>
///    <dt>0x80010001—0x80010122</dt> </dl> </td> <td width="60%"> Failure to communicate with the remote or local
///    firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmvSwitchEventsGetSecurityInfo0(HANDLE engineHandle, uint securityInfo, void** sidOwner, void** sidGroup, 
                                       ACL** dacl, ACL** sacl, void** securityDescriptor);

///The <b>FwpmvSwitchEventsSetSecurityInfo0</b> function sets specified security information in the security descriptor
///for a vSwitch event.
///Params:
///    engineHandle = Type: <b>HANDLE</b> A handle to an open session to the filter engine. Call FwpmEngineOpen0 to open a session to
///                   the filter engine.
///    securityInfo = Type: <b>SECURITY_INFORMATION</b> The type of security information to set.
///    sidOwner = Type: <b>const SID*</b> The owner's security identifier (SID) to be set in the security descriptor.
///    sidGroup = Type: <b>const SID*</b> The group's SID to be set in the security descriptor.
///    dacl = Type: <b>const ACL*</b> The discretionary access control list (DACL) to be set in the security descriptor.
///    sacl = Type: <b>const ACL*</b> The system access control list (SACL) to be set in the security descriptor.
///Returns:
///    Type: <b>DWORD</b> <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The security information was successfully
///    set. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FWP_E_* error code</b></dt> <dt>0x80320001—0x80320039</dt>
///    </dl> </td> <td width="60%"> A Windows Filtering Platform (WFP) specific error. See WFP Error Codes for details.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_* error code</b></dt> <dt>0x80010001—0x80010122</dt> </dl>
///    </td> <td width="60%"> Failure to communicate with the remote or local firewall engine. </td> </tr> </table>
///    
@DllImport("fwpuclnt")
uint FwpmvSwitchEventsSetSecurityInfo0(HANDLE engineHandle, uint securityInfo, const(SID)* sidOwner, 
                                       const(SID)* sidGroup, const(ACL)* dacl, const(ACL)* sacl);


