// Written in the D programming language.

module windows.ldap;

public import windows.core;
public import windows.security : CERT_CONTEXT, SecPkgContext_IssuerListInfoEx;
public import windows.systemservices : HANDLE, PSTR, PWSTR;

extern(Windows) @nogc nothrow:


// Enums


alias LDAP_RETCODE = int;
enum : int
{
    LDAP_SUCCESS                    = 0x00000000,
    LDAP_OPERATIONS_ERROR           = 0x00000001,
    LDAP_PROTOCOL_ERROR             = 0x00000002,
    LDAP_TIMELIMIT_EXCEEDED         = 0x00000003,
    LDAP_SIZELIMIT_EXCEEDED         = 0x00000004,
    LDAP_COMPARE_FALSE              = 0x00000005,
    LDAP_COMPARE_TRUE               = 0x00000006,
    LDAP_AUTH_METHOD_NOT_SUPPORTED  = 0x00000007,
    LDAP_STRONG_AUTH_REQUIRED       = 0x00000008,
    LDAP_REFERRAL_V2                = 0x00000009,
    LDAP_PARTIAL_RESULTS            = 0x00000009,
    LDAP_REFERRAL                   = 0x0000000a,
    LDAP_ADMIN_LIMIT_EXCEEDED       = 0x0000000b,
    LDAP_UNAVAILABLE_CRIT_EXTENSION = 0x0000000c,
    LDAP_CONFIDENTIALITY_REQUIRED   = 0x0000000d,
    LDAP_SASL_BIND_IN_PROGRESS      = 0x0000000e,
    LDAP_NO_SUCH_ATTRIBUTE          = 0x00000010,
    LDAP_UNDEFINED_TYPE             = 0x00000011,
    LDAP_INAPPROPRIATE_MATCHING     = 0x00000012,
    LDAP_CONSTRAINT_VIOLATION       = 0x00000013,
    LDAP_ATTRIBUTE_OR_VALUE_EXISTS  = 0x00000014,
    LDAP_INVALID_SYNTAX             = 0x00000015,
    LDAP_NO_SUCH_OBJECT             = 0x00000020,
    LDAP_ALIAS_PROBLEM              = 0x00000021,
    LDAP_INVALID_DN_SYNTAX          = 0x00000022,
    LDAP_IS_LEAF                    = 0x00000023,
    LDAP_ALIAS_DEREF_PROBLEM        = 0x00000024,
    LDAP_INAPPROPRIATE_AUTH         = 0x00000030,
    LDAP_INVALID_CREDENTIALS        = 0x00000031,
    LDAP_INSUFFICIENT_RIGHTS        = 0x00000032,
    LDAP_BUSY                       = 0x00000033,
    LDAP_UNAVAILABLE                = 0x00000034,
    LDAP_UNWILLING_TO_PERFORM       = 0x00000035,
    LDAP_LOOP_DETECT                = 0x00000036,
    LDAP_SORT_CONTROL_MISSING       = 0x0000003c,
    LDAP_OFFSET_RANGE_ERROR         = 0x0000003d,
    LDAP_NAMING_VIOLATION           = 0x00000040,
    LDAP_OBJECT_CLASS_VIOLATION     = 0x00000041,
    LDAP_NOT_ALLOWED_ON_NONLEAF     = 0x00000042,
    LDAP_NOT_ALLOWED_ON_RDN         = 0x00000043,
    LDAP_ALREADY_EXISTS             = 0x00000044,
    LDAP_NO_OBJECT_CLASS_MODS       = 0x00000045,
    LDAP_RESULTS_TOO_LARGE          = 0x00000046,
    LDAP_AFFECTS_MULTIPLE_DSAS      = 0x00000047,
    LDAP_VIRTUAL_LIST_VIEW_ERROR    = 0x0000004c,
    LDAP_OTHER                      = 0x00000050,
    LDAP_SERVER_DOWN                = 0x00000051,
    LDAP_LOCAL_ERROR                = 0x00000052,
    LDAP_ENCODING_ERROR             = 0x00000053,
    LDAP_DECODING_ERROR             = 0x00000054,
    LDAP_TIMEOUT                    = 0x00000055,
    LDAP_AUTH_UNKNOWN               = 0x00000056,
    LDAP_FILTER_ERROR               = 0x00000057,
    LDAP_USER_CANCELLED             = 0x00000058,
    LDAP_PARAM_ERROR                = 0x00000059,
    LDAP_NO_MEMORY                  = 0x0000005a,
    LDAP_CONNECT_ERROR              = 0x0000005b,
    LDAP_NOT_SUPPORTED              = 0x0000005c,
    LDAP_NO_RESULTS_RETURNED        = 0x0000005e,
    LDAP_CONTROL_NOT_FOUND          = 0x0000005d,
    LDAP_MORE_RESULTS_TO_RETURN     = 0x0000005f,
    LDAP_CLIENT_LOOP                = 0x00000060,
    LDAP_REFERRAL_LIMIT_EXCEEDED    = 0x00000061,
}

// Callbacks

alias DBGPRINT = uint function(const(PSTR) Format);
alias QUERYFORCONNECTION = uint function(ldap* PrimaryConnection, ldap* ReferralFromConnection, PWSTR NewDN, 
                                         PSTR HostName, uint PortNumber, void* SecAuthIdentity, 
                                         void* CurrentUserToken, ldap** ConnectionToUse);
alias NOTIFYOFNEWCONNECTION = ubyte function(ldap* PrimaryConnection, ldap* ReferralFromConnection, PWSTR NewDN, 
                                             PSTR HostName, ldap* NewConnection, uint PortNumber, 
                                             void* SecAuthIdentity, void* CurrentUser, uint ErrorCodeFromBind);
alias DEREFERENCECONNECTION = uint function(ldap* PrimaryConnection, ldap* ConnectionToDereference);
///The <b>QUERYCLIENTCERT</b> function is a client-side function that enables the server to request a certificate from
///the client when establishing a Secure Sockets Layer (SSL) connection.
///Params:
///    Connection = The session handle.
///    trusted_CAs = A list of server-trusted Certificate Authorities.
///    ppCertificate = Upon receiving the callback, the user supplies an appropriate client certificate in CERT_CONTEXT format and
///                    returns a value of <b>TRUE</b>. If the client cannot supply an appropriate certificate or wants the server to use
///                    anonymous credentials, it should return a value of <b>FALSE</b> instead. Any certificate supplied must be freed
///                    by the application after the connection is completed.
alias QUERYCLIENTCERT = ubyte function(ldap* Connection, SecPkgContext_IssuerListInfoEx* trusted_CAs, 
                                       CERT_CONTEXT** ppCertificate);
///<b>VERIFYSERVERCERT</b> is a callback function that allows a client to evaluate the certificate chain of the server
///to which it is connected.
///Params:
///    Connection = The session handle.
///    pServerCert = 
///Returns:
///    If the function succeeds (the client approves the server certificate), the return value is <b>TRUE</b>. If the
///    function fails; the return value is <b>FALSE</b> and the secure connection is torn down.
///    
alias VERIFYSERVERCERT = ubyte function(ldap* Connection, CERT_CONTEXT** pServerCert);

// Structs


///The <b>LDAP</b> structure represents an LDAP session. Typically, a session corresponds to a connection to a single
///server. However, in the case of referrals, an LDAP session may encompass several server connections. The ability to
///track referrals is available in LDAP 3.
struct ldap
{
struct ld_sb
    {
        size_t    sb_sd;
        ubyte[41] Reserved1;
        size_t    sb_naddr;
        ubyte[24] Reserved2;
    }
    PSTR      ld_host;
    uint      ld_version;
    ubyte     ld_lberoptions;
    uint      ld_deref;
    uint      ld_timelimit;
    uint      ld_sizelimit;
    uint      ld_errno;
    PSTR      ld_matched;
    PSTR      ld_error;
    uint      ld_msgid;
    ubyte[25] Reserved3;
    uint      ld_cldaptries;
    uint      ld_cldaptimeout;
    uint      ld_refhoplimit;
    uint      ld_options;
}

///The <b>LDAP_TIMEVAL</b> structure is used to represent an interval of time.
struct LDAP_TIMEVAL
{
    ///Time interval, in seconds.
    int tv_sec;
    ///Time interval, in microseconds.
    int tv_usec;
}

///The <b>berval</b> structure represents arbitrary binary data that is encoded according to Basic Encoding Rules (BER).
///Use a <b>berval</b> to represent any attribute that cannot be represented by a null-terminated string.
struct LDAP_BERVAL
{
    ///Length, in bytes, of binary data.
    uint bv_len;
    ///Pointer to the binary data.
    PSTR bv_val;
}

///The <b>LDAPMessage</b> structure is used by an LDAP function to return results and error data.
struct LDAPMessage
{
    uint         lm_msgid;
    uint         lm_msgtype;
    void*        lm_ber;
    LDAPMessage* lm_chain;
    LDAPMessage* lm_next;
    uint         lm_time;
    ldap*        Connection;
    void*        Request;
    uint         lm_returncode;
    ushort       lm_referral;
    ubyte        lm_chased;
    ubyte        lm_eom;
    ubyte        ConnectionReferenced;
}

///The <b>LDAPControl</b> structure represents both client-side and server controls.
struct ldapcontrolA
{
    ///Pointer to a wide, null-terminated string that indicates control type, such as "1.2.840.113556.1.4.805".
    PSTR        ldctl_oid;
    ///The data associated with the control, if any. If no data is associated with the control, set this member to
    ///<b>NULL</b>.
    LDAP_BERVAL ldctl_value;
    ///Indicates whether the control is critical, called the Criticality field.
    ubyte       ldctl_iscritical;
}

///The <b>LDAPControl</b> structure represents both client-side and server controls.
struct ldapcontrolW
{
    ///Pointer to a wide, null-terminated string that indicates control type, such as "1.2.840.113556.1.4.805".
    PWSTR       ldctl_oid;
    ///The data associated with the control, if any. If no data is associated with the control, set this member to
    ///<b>NULL</b>.
    LDAP_BERVAL ldctl_value;
    ///Indicates whether the control is critical, called the Criticality field.
    ubyte       ldctl_iscritical;
}

///The <b>LDAPMod</b> structure holds data required to perform a modification operation.
struct ldapmodW
{
    ///Specifies one of the following values to indicate the modification operation to perform. You can use the bitwise
    ///<b>OR</b> operator to combine the operation value with <b>LDAP_MOD_BVALUES</b> to indicate that the
    ///<b>mod_vals</b> union uses the <b>modv_bvals</b> member. If <b>LDAP_MOD_BVALUES</b> is not set, the union uses
    ///the <b>modv_strvals</b> member.
    uint  mod_op;
    ///Pointer to a null-terminated string that specifies the name of the attribute to modify.
    PWSTR mod_type;
union mod_vals
    {
        PWSTR*        modv_strvals;
        LDAP_BERVAL** modv_bvals;
    }
}

///The <b>LDAPMod</b> structure holds data required to perform a modification operation.
struct ldapmodA
{
    ///Specifies one of the following values to indicate the modification operation to perform. You can use the bitwise
    ///<b>OR</b> operator to combine the operation value with <b>LDAP_MOD_BVALUES</b> to indicate that the
    ///<b>mod_vals</b> union uses the <b>modv_bvals</b> member. If <b>LDAP_MOD_BVALUES</b> is not set, the union uses
    ///the <b>modv_strvals</b> member.
    uint mod_op;
    ///Pointer to a null-terminated string that specifies the name of the attribute to modify.
    PSTR mod_type;
union mod_vals
    {
        PSTR*         modv_strvals;
        LDAP_BERVAL** modv_bvals;
    }
}

///A <b>BerElement</b> structure is a C++ class object that performs basic encoding rules (BER) encoding.
struct berelement
{
    ///Pointer to an opaque buffer. Do not attempt to access it.
    PSTR opaque;
}

struct ldap_version_info
{
    uint lv_size;
    uint lv_major;
    uint lv_minor;
}

///The <b>LDAPAPIInfo</b> structure retrieves data about the API and implementations used.
struct ldapapiinfoA
{
    ///The version of this structure, which must be set to <b>LDAP_API_INFO_VERSION</b> before a call to
    ///ldap_get_option.
    int    ldapai_info_version;
    ///The current revision number of this LDAP API library.
    int    ldapai_api_version;
    ///The latest LDAP version supported by this LDAP API library.
    int    ldapai_protocol_version;
    ///Pointer to an array of null-terminated strings that indicate what API extensions are supported.
    byte** ldapai_extensions;
    ///Pointer to a null-terminated string that contains the name of the API vendor. This implementation returns the
    ///string ""Microsoft Corporation."".
    byte*  ldapai_vendor_name;
    ///The API vendor version number. This implementation returns an integer value in the format of MMnn, where MM is
    ///the major version number * 100, and nn is the minor version number. For example, version 5.10 is returned as 510.
    int    ldapai_vendor_version;
}

///The <b>LDAPAPIInfo</b> structure retrieves data about the API and implementations used.
struct ldapapiinfoW
{
    ///The version of this structure, which must be set to <b>LDAP_API_INFO_VERSION</b> before a call to
    ///ldap_get_option.
    int    ldapai_info_version;
    ///The current revision number of this LDAP API library.
    int    ldapai_api_version;
    ///The latest LDAP version supported by this LDAP API library.
    int    ldapai_protocol_version;
    ///Pointer to an array of null-terminated strings that indicate what API extensions are supported.
    PWSTR* ldapai_extensions;
    ///Pointer to a null-terminated string that contains the name of the API vendor. This implementation returns the
    ///string ""Microsoft Corporation."".
    PWSTR  ldapai_vendor_name;
    ///The API vendor version number. This implementation returns an integer value in the format of MMnn, where MM is
    ///the major version number * 100, and nn is the minor version number. For example, version 5.10 is returned as 510.
    int    ldapai_vendor_version;
}

///The <b>LDAPAPIFeatureInfo</b> structure retrieves data about any supported LDAP API extensions.
struct LDAPAPIFeatureInfoA
{
    ///The version of this structure, which must be set to <b>LDAP_FEATURE_INFO_VERSION</b> before the call to
    ///ldap_get_option is performed.
    int   ldapaif_info_version;
    ///A pointer to a null-terminated string that contains the name of the desired API extension. This value is set
    ///before the call to ldap_get_option is performed, and should match one of the strings returned in the
    ///<b>ldapai_extensions</b> member of LDAPAPIInfo set from a previous call to <b>ldap_get_option</b>.
    byte* ldapaif_name;
    ///The vendor API extension version number. This implementation returns an integer value in the format of MMnnn,
    ///where MM is the major version number * 1000, and nnn is the minor version number. For example, version 1.001
    ///would be returned as the number 1001.
    int   ldapaif_version;
}

///The <b>LDAPAPIFeatureInfo</b> structure retrieves data about any supported LDAP API extensions.
struct LDAPAPIFeatureInfoW
{
    ///The version of this structure, which must be set to <b>LDAP_FEATURE_INFO_VERSION</b> before the call to
    ///ldap_get_option is performed.
    int   ldapaif_info_version;
    ///A pointer to a null-terminated string that contains the name of the desired API extension. This value is set
    ///before the call to ldap_get_option is performed, and should match one of the strings returned in the
    ///<b>ldapai_extensions</b> member of LDAPAPIInfo set from a previous call to <b>ldap_get_option</b>.
    PWSTR ldapaif_name;
    ///The vendor API extension version number. This implementation returns an integer value in the format of MMnnn,
    ///where MM is the major version number * 1000, and nnn is the minor version number. For example, version 1.001
    ///would be returned as the number 1001.
    int   ldapaif_version;
}

struct ldapsearch
{
}

///The <b>LDAPSortKey</b> structure stores sorting criteria for use by sort controls.
struct ldapsortkeyW
{
    ///Pointer to a null-terminated string that specifies the name of the attribute to use as a sort key. Use multiple
    ///<b>LDAPSortKey</b> structures to specify multiple sort keys. Be aware that Active Directory supports only a
    ///single sort key.
    PWSTR sk_attrtype;
    ///Pointer to a null-terminated string that specifies the object identifier of the matching rule for the sort.
    ///Should be set to <b>NULL</b> if you do not want to explicitly specify a matching rule for the sort. Specifying an
    ///explicitly set matching rule is supported only by Windows Server 2003.
    PWSTR sk_matchruleoid;
    ///If <b>TRUE</b>, specifies that the sort be ordered from lowest to highest. If <b>FALSE</b>, the sort order is
    ///from highest to lowest.
    ubyte sk_reverseorder;
}

///The <b>LDAPSortKey</b> structure stores sorting criteria for use by sort controls.
struct ldapsortkeyA
{
    ///Pointer to a null-terminated string that specifies the name of the attribute to use as a sort key. Use multiple
    ///<b>LDAPSortKey</b> structures to specify multiple sort keys. Be aware that Active Directory supports only a
    ///single sort key.
    PSTR  sk_attrtype;
    ///Pointer to a null-terminated string that specifies the object identifier of the matching rule for the sort.
    ///Should be set to <b>NULL</b> if you do not want to explicitly specify a matching rule for the sort. Specifying an
    ///explicitly set matching rule is supported only by Windows Server 2003.
    PSTR  sk_matchruleoid;
    ///If <b>TRUE</b>, specifies that the sort be ordered from lowest to highest. If <b>FALSE</b>, the sort order is
    ///from highest to lowest.
    ubyte sk_reverseorder;
}

///The <b>LDAPVLVInfo</b> structure is used to set up the search parameters for a virtual list view (VLV) request
///control (LDAP_CONTROL_VLVREQUEST). The <b>LDAPVLVInfo</b> structure may also be used by applications to manage the
///state data associated with a series of VLV client/server interactions.
struct ldapvlvinfo
{
    ///Identifies the version of the <b>LDAPVLVInfo</b> structure. This should always be set to the value
    ///LDAP_VLVINFO_VERSION (1).
    int          ldvlv_version;
    ///Identifies the number of entries before the target entry that the client wants the server to send back in the
    ///list results. This field corresponds to the <b>beforeCount</b> element of the BER-encoded LDAP_CONTROL_VLVREQUEST
    ///control.
    uint         ldvlv_before_count;
    ///Indicates the number of entries after the target entry the client instructs the server to send back in the list
    ///results. This field corresponds to the <b>afterCount</b> element of the BER-encoded LDAP_CONTROL_VLVREQUEST
    ///control.
    uint         ldvlv_after_count;
    ///Indicates a ratio between the offset value and the content count. For example, consider if a user drags the
    ///scroll bar to view entries in the middle of the list. If the client estimates that the entire list contains 100
    ///entries, then to view the middle list it will calculate the offset to be 50, so the client sends this offset
    ///value, with 100 as the content count, sent in the <b>ldvlv_count</b> member, to the server. When the server
    ///receives this data, it may actually have calculated the content count to be 500, so it calculates the offset to
    ///find the target that the client requested, using the following formula: Si = Sc * (Ci / Cc) where Si is the
    ///actual list offset used by the server Sc is the server estimate for content count Ci is the client-submitted
    ///offset Cc is the client-submitted content count If the client uses an offset value of one (1), it indicates that
    ///the target is the first entry in the list. If the client uses an offset value that equals <b>ldvlv_count</b>,
    ///then the item is the last entry in the list. The offset will equal zero (0) when <b>ldvlv_count</b> equals zero,
    ///which would be the last entry in the list. Offsets are used only if the search is not based on an attribute
    ///value, so <b>ldvlv_attrvalue</b> must be <b>NULL</b>. This field corresponds to the offset element within the
    ///BER-encoded LDAP_CONTROL_VLVREQUEST control.
    uint         ldvlv_offset;
    ///Indicates the content count of the list. An estimation of the content count is sent by the client to the server
    ///when sending a search request, in order to enable the server to calculate an offset value. The server returns its
    ///own calculation of the content count to the client in its response. If the client does not have an estimate for
    ///content count, it sends zero (0), which indicates that the server should use its own estimate for content count.
    ///This member is used with <b>ldvlv_offset</b>. Because content count is required only if the search is not based
    ///on an attribute value, the <b>ldvlv_attrvalue</b> member must be <b>NULL</b>. This field corresponds to the
    ///<b>contentCount</b> element within the BER-encoded LDAP_CONTROL_VLVREQUEST control and the <b>contentCount</b>
    ///element within the BER-encoded LDAP_CONTROL_VLVRESPONSE control.
    uint         ldvlv_count;
    ///Provides an attribute value as a target entry for the search. The server compares this member to values that have
    ///the same attribute type, as specified in the <b>sk_attrtype</b> member of the LDAPSortKey structure. If an offset
    ///is used, then this member must be <b>NULL</b>. This member corresponds to the <b>assertionValue</b> element of
    ///the BER-encoded LDAP_CONTROL_VLVREQUEST control.
    LDAP_BERVAL* ldvlv_attrvalue;
    ///Provides the context ID that is assigned by the server to identify this search operation. This is an opaque
    ///"cookie" used by the server to keep internal track of the current VLV operation. On the first call to the search
    ///operation using the VLV control, this parameter should be set to <b>NULL</b>. The server may return a value in
    ///the LDAP_CONTROL_VLVRESPONSE message. This "cookie" value should be returned to the server on the next call to a
    ///search function that is performed against a particular VLV list.
    LDAP_BERVAL* ldvlv_context;
    ///This field is reserved for application-specific use and is not used by the ldap_create_vlv_control function; it
    ///has no effect on the control that is created.
    void*        ldvlv_extradata;
}

///The <b>LDAP_REFERRAL_CALLBACK</b> structure is used to implement external caching of connections. This structure is
///used only when tracking referrals.
struct LDAP_REFERRAL_CALLBACK
{
    ///The amount of memory required for the callback. Set this field to <code>sizeof(LDAP_REFERRAL_CALLBACK)</code>.
    uint                SizeOfCallbacks;
    ///A pointer to a callback function to determine whether there is a cached connection cached available. For more
    ///information, see Remarks.
    QUERYFORCONNECTION* QueryForConnection;
    ///A pointer to a callback function that determines whether a new connection will be cached or destroyed after the
    ///operation completes. For more information, see Remarks.
    NOTIFYOFNEWCONNECTION* NotifyRoutine;
    ///A pointer to a callback function to dereference a connection that is not in use. For more information, see
    ///Remarks.
    DEREFERENCECONNECTION* DereferenceRoutine;
}

// Functions

///<p class="CCE_Message">[ldap_open is available for use in the operating systems specified in the Requirements
///section; however, it is not recommended. Instead, use ldap_init.] The <b>ldap_open</b> function creates and
///initializes a connection block, then opens the connection to an LDAP server.
///Params:
///    HostName = A pointer to a null-terminated string. A domain name, a list of host names, or dotted strings that represent the
///               IP address of LDAP server hosts. Use a single space to separate the host names in the list. Each host name in the
///               list may be followed by a port number. The optional port number is separated from the host itself with a colon
///               (:). The LDAP run time attempts connection with the hosts in the order listed, stopping when a successful
///               connection is made. Be aware that only <b>ldap_open</b> attempts to make the connection before returning to the
///               caller. The function ldap_init does not connect to the LDAP server.
///    PortNumber = Contains the TCP port number to which to connect. The default LDAP port, 389, can be obtained by supplying the
///                 constant <b>LDAP_PORT</b>. If a host name includes a port number then this parameter is ignored.
///Returns:
///    If the function succeeds, it returns a session handle, in the form of a pointer to an LDAP data structure. Free
///    the session handle, when no longer required, with a call to ldap_unbind. If the function fails, it returns
///    <b>NULL</b>. Use the LdapGetLastError function to retrieve the error code.
///    
@DllImport("WLDAP32")
ldap* ldap_openW(const(PWSTR) HostName, uint PortNumber);

///<p class="CCE_Message">[ldap_open is available for use in the operating systems specified in the Requirements
///section; however, it is not recommended. Instead, use ldap_init.] The <b>ldap_open</b> function creates and
///initializes a connection block, then opens the connection to an LDAP server.
///Params:
///    HostName = A pointer to a null-terminated string. A domain name, a list of host names, or dotted strings that represent the
///               IP address of LDAP server hosts. Use a single space to separate the host names in the list. Each host name in the
///               list may be followed by a port number. The optional port number is separated from the host itself with a colon
///               (:). The LDAP run time attempts connection with the hosts in the order listed, stopping when a successful
///               connection is made. Be aware that only <b>ldap_open</b> attempts to make the connection before returning to the
///               caller. The function ldap_init does not connect to the LDAP server.
///    PortNumber = Contains the TCP port number to which to connect. The default LDAP port, 389, can be obtained by supplying the
///                 constant <b>LDAP_PORT</b>. If a host name includes a port number then this parameter is ignored.
///Returns:
///    If the function succeeds, it returns a session handle, in the form of a pointer to an LDAP data structure. Free
///    the session handle, when no longer required, with a call to ldap_unbind. If the function fails, it returns
///    <b>NULL</b>. Use the LdapGetLastError function to retrieve the error code.
///    
@DllImport("WLDAP32")
ldap* ldap_openA(const(PSTR) HostName, uint PortNumber);

///The <b>ldap_init</b> function initializes a session with an LDAP server.
///Params:
///    HostName = A pointer to a null-terminated string that contains a domain name, or a space-separated list of host names or
///               dotted strings that represent the IP address of hosts running an LDAP server to which to connect. Each host name
///               in the list can include an optional port number which is separated from the host itself with a colon (:). For
///               more information about the use of the <b>LDAP_OPT_AREC_EXCLUSIVE</b> option when connecting to Active Directory
///               servers, see the Remarks section.
///    PortNumber = Contains the TCP port number to which to connect. Set to <b>LDAP_PORT</b> to obtain the default port, 389. This
///                 parameter is ignored if a host name includes a port number.
///Returns:
///    If the function succeeds, it returns a session handle, in the form of a pointer to an LDAP data structure. The
///    session handle must be freed with a call to ldap_unbind when it is no longer required. If the function fails, it
///    returns <b>NULL</b>. Use LdapGetLastError to retrieve the error code.
///    
@DllImport("WLDAP32")
ldap* ldap_initW(const(PWSTR) HostName, uint PortNumber);

///The <b>ldap_init</b> function initializes a session with an LDAP server.
///Params:
///    HostName = A pointer to a null-terminated string that contains a domain name, or a space-separated list of host names or
///               dotted strings that represent the IP address of hosts running an LDAP server to which to connect. Each host name
///               in the list can include an optional port number which is separated from the host itself with a colon (:). For
///               more information about the use of the <b>LDAP_OPT_AREC_EXCLUSIVE</b> option when connecting to Active Directory
///               servers, see the Remarks section.
///    PortNumber = Contains the TCP port number to which to connect. Set to <b>LDAP_PORT</b> to obtain the default port, 389. This
///                 parameter is ignored if a host name includes a port number.
///Returns:
///    If the function succeeds, it returns a session handle, in the form of a pointer to an LDAP data structure. The
///    session handle must be freed with a call to ldap_unbind when it is no longer required. If the function fails, it
///    returns <b>NULL</b>. Use LdapGetLastError to retrieve the error code.
///    
@DllImport("WLDAP32")
ldap* ldap_initA(const(PSTR) HostName, uint PortNumber);

///The <b>ldap_sslinit</b> function initializes a Secure Sockets Layer (SSL) session with an LDAP server.
///Params:
///    HostName = A pointer to a null-terminated string that contains a space-separated list of host names or dotted strings
///               representing the IP address of hosts running an LDAP server to which to connect. Each host name in the list can
///               include an optional port number which is separated from the host itself with a colon (:) character.
///    PortNumber = Contains the TCP port number to which to connect. Set to <b>LDAP_SSL_PORT</b> to obtain the default port, 636.
///                 This parameter is ignored if a host name includes a port number.
///    secure = If nonzero, the function uses SSL encryption. If the value is 0, the function establishes a plain TCP connection
///             and uses clear text (no encryption).
///Returns:
///    If the function succeeds, it returns a session handle, in the form of a pointer to an LDAP structure. The session
///    handle must be freed with a call to ldap_unbind when it is no longer needed. If the function fails, the return
///    value is <b>NULL</b>. Use LdapGetLastError to retrieve the error code.
///    
@DllImport("WLDAP32")
ldap* ldap_sslinitW(PWSTR HostName, uint PortNumber, int secure);

///The <b>ldap_sslinit</b> function initializes a Secure Sockets Layer (SSL) session with an LDAP server.
///Params:
///    HostName = A pointer to a null-terminated string that contains a space-separated list of host names or dotted strings
///               representing the IP address of hosts running an LDAP server to which to connect. Each host name in the list can
///               include an optional port number which is separated from the host itself with a colon (:) character.
///    PortNumber = Contains the TCP port number to which to connect. Set to <b>LDAP_SSL_PORT</b> to obtain the default port, 636.
///                 This parameter is ignored if a host name includes a port number.
///    secure = If nonzero, the function uses SSL encryption. If the value is 0, the function establishes a plain TCP connection
///             and uses clear text (no encryption).
///Returns:
///    If the function succeeds, it returns a session handle, in the form of a pointer to an LDAP structure. The session
///    handle must be freed with a call to ldap_unbind when it is no longer needed. If the function fails, the return
///    value is <b>NULL</b>. Use LdapGetLastError to retrieve the error code.
///    
@DllImport("WLDAP32")
ldap* ldap_sslinitA(PSTR HostName, uint PortNumber, int secure);

///The <b>ldap_connect</b> function establishes a connection with the server.
///Params:
///    ld = The session handle obtained from ldap_init.
///    timeout = A pointer to an LDAP_TIMEVAL structure that specifies the number of seconds to spend in an attempt to establish a
///              connection before a timeout. If <b>NULL</b>, the function uses a default timeout value.
///Returns:
///    If the function succeeds, <b>LDAP_SUCCESS</b> is returned. If the function fails, an error code is returned. For
///    more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_connect(ldap* ld, LDAP_TIMEVAL* timeout);

///<p class="CCE_Message">[ldap_open is available for use in the operating systems specified in the Requirements
///section; however, it is not recommended. Instead, use ldap_init.] The <b>ldap_open</b> function creates and
///initializes a connection block, then opens the connection to an LDAP server.
///Params:
///    HostName = A pointer to a null-terminated string. A domain name, a list of host names, or dotted strings that represent the
///               IP address of LDAP server hosts. Use a single space to separate the host names in the list. Each host name in the
///               list may be followed by a port number. The optional port number is separated from the host itself with a colon
///               (:). The LDAP run time attempts connection with the hosts in the order listed, stopping when a successful
///               connection is made. Be aware that only <b>ldap_open</b> attempts to make the connection before returning to the
///               caller. The function ldap_init does not connect to the LDAP server.
///    PortNumber = Contains the TCP port number to which to connect. The default LDAP port, 389, can be obtained by supplying the
///                 constant <b>LDAP_PORT</b>. If a host name includes a port number then this parameter is ignored.
///Returns:
///    If the function succeeds, it returns a session handle, in the form of a pointer to an LDAP data structure. Free
///    the session handle, when no longer required, with a call to ldap_unbind. If the function fails, it returns
///    <b>NULL</b>. Use the LdapGetLastError function to retrieve the error code.
///    
@DllImport("WLDAP32")
ldap* ldap_open(PSTR HostName, uint PortNumber);

///The <b>ldap_init</b> function initializes a session with an LDAP server.
///Params:
///    HostName = A pointer to a null-terminated string that contains a domain name, or a space-separated list of host names or
///               dotted strings that represent the IP address of hosts running an LDAP server to which to connect. Each host name
///               in the list can include an optional port number which is separated from the host itself with a colon (:). For
///               more information about the use of the <b>LDAP_OPT_AREC_EXCLUSIVE</b> option when connecting to Active Directory
///               servers, see the Remarks section.
///    PortNumber = Contains the TCP port number to which to connect. Set to <b>LDAP_PORT</b> to obtain the default port, 389. This
///                 parameter is ignored if a host name includes a port number.
///Returns:
///    If the function succeeds, it returns a session handle, in the form of a pointer to an LDAP data structure. The
///    session handle must be freed with a call to ldap_unbind when it is no longer required. If the function fails, it
///    returns <b>NULL</b>. Use LdapGetLastError to retrieve the error code.
///    
@DllImport("WLDAP32")
ldap* ldap_init(PSTR HostName, uint PortNumber);

///The <b>ldap_sslinit</b> function initializes a Secure Sockets Layer (SSL) session with an LDAP server.
///Params:
///    HostName = A pointer to a null-terminated string that contains a space-separated list of host names or dotted strings
///               representing the IP address of hosts running an LDAP server to which to connect. Each host name in the list can
///               include an optional port number which is separated from the host itself with a colon (:) character.
///    PortNumber = Contains the TCP port number to which to connect. Set to <b>LDAP_SSL_PORT</b> to obtain the default port, 636.
///                 This parameter is ignored if a host name includes a port number.
///    secure = If nonzero, the function uses SSL encryption. If the value is 0, the function establishes a plain TCP connection
///             and uses clear text (no encryption).
///Returns:
///    If the function succeeds, it returns a session handle, in the form of a pointer to an LDAP structure. The session
///    handle must be freed with a call to ldap_unbind when it is no longer needed. If the function fails, the return
///    value is <b>NULL</b>. Use LdapGetLastError to retrieve the error code.
///    
@DllImport("WLDAP32")
ldap* ldap_sslinit(PSTR HostName, uint PortNumber, int secure);

///The <b>cldap_open</b> function establishes a session with an LDAP server over a connectionless User Datagram Protocol
///(UDP) service. This is an alternate to using TCP/IP.
///Params:
///    HostName = A pointer to a null-terminated string that contains a list of host names or dotted strings that represent the IP
///               address of LDAP server hosts. Use a single space to separate the host names in the list. Each host name in the
///               list may be followed by a port number. The optional port number is separated from the host itself with a colon
///               (:). The LDAP run time attempts connection with the hosts in the order listed, stopping when a successful
///               connection is made.
///    PortNumber = The port number to be used. If no port number is specified, the default is port 389, which is defined as
///                 LDAP_PORT. If port numbers are included in the <i>HostName</i> parameter, this parameter is ignored.
///Returns:
///    If the function succeeds, a session handle, in the form of a pointer to an LDAP structure is returned. Free the
///    session handle with a call to ldap_unbind when it is no longer required. If the function fails, the return value
///    is <b>NULL</b>. To get the error code, call LdapGetLastError or the Win32 function GetLastError.
///    
@DllImport("WLDAP32")
ldap* cldap_openW(PWSTR HostName, uint PortNumber);

///The <b>cldap_open</b> function establishes a session with an LDAP server over a connectionless User Datagram Protocol
///(UDP) service. This is an alternate to using TCP/IP.
///Params:
///    HostName = A pointer to a null-terminated string that contains a list of host names or dotted strings that represent the IP
///               address of LDAP server hosts. Use a single space to separate the host names in the list. Each host name in the
///               list may be followed by a port number. The optional port number is separated from the host itself with a colon
///               (:). The LDAP run time attempts connection with the hosts in the order listed, stopping when a successful
///               connection is made.
///    PortNumber = The port number to be used. If no port number is specified, the default is port 389, which is defined as
///                 LDAP_PORT. If port numbers are included in the <i>HostName</i> parameter, this parameter is ignored.
///Returns:
///    If the function succeeds, a session handle, in the form of a pointer to an LDAP structure is returned. Free the
///    session handle with a call to ldap_unbind when it is no longer required. If the function fails, the return value
///    is <b>NULL</b>. To get the error code, call LdapGetLastError or the Win32 function GetLastError.
///    
@DllImport("WLDAP32")
ldap* cldap_openA(PSTR HostName, uint PortNumber);

///The <b>cldap_open</b> function establishes a session with an LDAP server over a connectionless User Datagram Protocol
///(UDP) service. This is an alternate to using TCP/IP.
///Params:
///    HostName = A pointer to a null-terminated string that contains a list of host names or dotted strings that represent the IP
///               address of LDAP server hosts. Use a single space to separate the host names in the list. Each host name in the
///               list may be followed by a port number. The optional port number is separated from the host itself with a colon
///               (:). The LDAP run time attempts connection with the hosts in the order listed, stopping when a successful
///               connection is made.
///    PortNumber = The port number to be used. If no port number is specified, the default is port 389, which is defined as
///                 LDAP_PORT. If port numbers are included in the <i>HostName</i> parameter, this parameter is ignored.
///Returns:
///    If the function succeeds, a session handle, in the form of a pointer to an LDAP structure is returned. Free the
///    session handle with a call to ldap_unbind when it is no longer required. If the function fails, the return value
///    is <b>NULL</b>. To get the error code, call LdapGetLastError or the Win32 function GetLastError.
///    
@DllImport("WLDAP32")
ldap* cldap_open(PSTR HostName, uint PortNumber);

///The <b>ldap_unbind</b> function frees resources associated with an LDAP session.
///Params:
///    ld = The session handle.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_unbind(ldap* ld);

///The <b>ldap_unbind_s</b> function synchronously frees resources associated with an LDAP session.
///Params:
///    ld = The session handle.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_unbind_s(ldap* ld);

///The <b>ldap_get_option</b> function retrieves the current values of session-wide parameters.
///Params:
///    ld = The session handle.
///    option = The name of the option accessed. For more information and a list of allowable options and their values, see the
///             following Remarks section.
///    outvalue = The address of the option value. The actual type of this parameter depends on the setting of the option
///               parameter.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_get_option(ldap* ld, int option, void* outvalue);

///The <b>ldap_get_option</b> function retrieves the current values of session-wide parameters.
///Params:
///    ld = The session handle.
///    option = The name of the option accessed. For more information and a list of allowable options and their values, see the
///             following Remarks section.
///    outvalue = The address of the option value. The actual type of this parameter depends on the setting of the option
///               parameter.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_get_optionW(ldap* ld, int option, void* outvalue);

///The <b>ldap_set_option</b> function sets options on connection blocks. For more information about structures, see
///Data Structures.
///Params:
///    ld = The session handle.
///    option = The name of the option set.
///    invalue = A pointer to the value that the option is to be given. The actual type of this parameter depends on the setting
///              of the option parameter. The constants LDAP_OPT_ON and LDAP_OPT_OFF can be given for options that have on or off
///              settings.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_set_option(ldap* ld, int option, const(void)* invalue);

///The <b>ldap_set_option</b> function sets options on connection blocks. For more information about structures, see
///Data Structures.
///Params:
///    ld = The session handle.
///    option = The name of the option set.
///    invalue = A pointer to the value that the option is to be given. The actual type of this parameter depends on the setting
///              of the option parameter. The constants LDAP_OPT_ON and LDAP_OPT_OFF can be given for options that have on or off
///              settings.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_set_optionW(ldap* ld, int option, const(void)* invalue);

///The <b>ldap_simple_bind</b> functionasynchronously authenticates a client to a server, using a plaintext password.
///<div class="alert"><b>Caution</b> This function sends the name and password without encrypting them, and therefore
///someone eavesdropping on the network could read the password. Unless a TLS (SSL) encrypted session has been
///established, do not use this function. For more information about how to set up an encrypted session, see
///Initializing a Session.</div><div> </div>
///Params:
///    ld = The session handle.
///    dn = The name of the user to bind as. The bind operation uses the <i>dn</i> and <i>passwd</i> parameters to
///         authenticate the user.
///    passwd = The password of the user specified in the <i>dn</i> parameter.
///Returns:
///    If the function succeeds, it returns the message ID of the operation initiated. If the function fails, it returns
///    -1 and sets the session error parameters in the LDAP data structure.
///    
@DllImport("WLDAP32")
uint ldap_simple_bindW(ldap* ld, PWSTR dn, PWSTR passwd);

///The <b>ldap_simple_bind</b> functionasynchronously authenticates a client to a server, using a plaintext password.
///<div class="alert"><b>Caution</b> This function sends the name and password without encrypting them, and therefore
///someone eavesdropping on the network could read the password. Unless a TLS (SSL) encrypted session has been
///established, do not use this function. For more information about how to set up an encrypted session, see
///Initializing a Session.</div><div> </div>
///Params:
///    ld = The session handle.
///    dn = The name of the user to bind as. The bind operation uses the <i>dn</i> and <i>passwd</i> parameters to
///         authenticate the user.
///    passwd = The password of the user specified in the <i>dn</i> parameter.
///Returns:
///    If the function succeeds, it returns the message ID of the operation initiated. If the function fails, it returns
///    -1 and sets the session error parameters in the LDAP data structure.
///    
@DllImport("WLDAP32")
uint ldap_simple_bindA(ldap* ld, PSTR dn, PSTR passwd);

///The <b>ldap_simple_bind_s</b> function synchronously authenticates a client to a server, using a plaintext password.
///<div class="alert"><b>Caution</b> This function sends the name and password without encrypting them, and an
///unauthorized user, on the network, could read the password. Unless a TLS (SSL) encrypted session has been
///established, do not this function. For more information about how to set up an encrypted session, see Initializing a
///Session.</div><div> </div>
///Params:
///    ld = The session handle.
///    dn = The name of the user to bind as. The bind operation uses the <i>dn</i> and <i>passwd</i> parameters to
///         authenticate the user.
///    passwd = The password of the user specified in the <i>dn</i> parameter.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_simple_bind_sW(ldap* ld, PWSTR dn, PWSTR passwd);

///The <b>ldap_simple_bind_s</b> function synchronously authenticates a client to a server, using a plaintext password.
///<div class="alert"><b>Caution</b> This function sends the name and password without encrypting them, and an
///unauthorized user, on the network, could read the password. Unless a TLS (SSL) encrypted session has been
///established, do not this function. For more information about how to set up an encrypted session, see Initializing a
///Session.</div><div> </div>
///Params:
///    ld = The session handle.
///    dn = The name of the user to bind as. The bind operation uses the <i>dn</i> and <i>passwd</i> parameters to
///         authenticate the user.
///    passwd = The password of the user specified in the <i>dn</i> parameter.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_simple_bind_sA(ldap* ld, PSTR dn, PSTR passwd);

///The <b>ldap_bind</b> function asynchronously authenticates a client with the LDAP server. The bind operation
///identifies a client to the directory server by providing a distinguished name and some type of authentication
///credential, such as a password. The authentication method used determines the type of required credential. <div
///class="alert"><b>Caution</b> Unless a TLS (SSL) encrypted session is established, do not use this function. This
///function sends the name and password in plaintext. An unauthorized user, monitoring network traffic, could read the
///password. For more information about how to establish an encrypted session, see Initializing a Session.</div><div>
///</div>
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry used to bind.
///    cred = A pointer to a null-terminated string that contains the credentials to use for authentication. Arbitrary
///           credentials can be passed using this parameter. The format and content of the credentials depend on the setting
///           of the method parameter. For more information, see the Remarks section.
///    method = The authentication method to use.
///Returns:
///    If the function succeeds, the return value is the message ID of the initiated operation. If the function fails,
///    it returns –1 and sets the session error parameters in the LDAP structure.
///    
@DllImport("WLDAP32")
uint ldap_bindW(ldap* ld, PWSTR dn, PWSTR cred, uint method);

///The <b>ldap_bind</b> function asynchronously authenticates a client with the LDAP server. The bind operation
///identifies a client to the directory server by providing a distinguished name and some type of authentication
///credential, such as a password. The authentication method used determines the type of required credential. <div
///class="alert"><b>Caution</b> Unless a TLS (SSL) encrypted session is established, do not use this function. This
///function sends the name and password in plaintext. An unauthorized user, monitoring network traffic, could read the
///password. For more information about how to establish an encrypted session, see Initializing a Session.</div><div>
///</div>
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry used to bind.
///    cred = A pointer to a null-terminated string that contains the credentials to use for authentication. Arbitrary
///           credentials can be passed using this parameter. The format and content of the credentials depend on the setting
///           of the method parameter. For more information, see the Remarks section.
///    method = The authentication method to use.
///Returns:
///    If the function succeeds, the return value is the message ID of the initiated operation. If the function fails,
///    it returns –1 and sets the session error parameters in the LDAP structure.
///    
@DllImport("WLDAP32")
uint ldap_bindA(ldap* ld, PSTR dn, PSTR cred, uint method);

///The <b>ldap_bind_s</b> function synchronously authenticates a client to the LDAP server.
///Params:
///    ld = The session handle.
///    dn = Pointer to a null-terminated string that contains the distinguished name of the entry used to bind. This can be a
///         DN, a UPN, a WinNT style user name, or other name that the directory server will accept as an identifier.
///    cred = Pointer to a null-terminated string that contains the credentials with which to authenticate. Arbitrary
///           credentials can be passed using this parameter. The format and content of the credentials depends on the setting
///           of the <i>method</i> parameter. For more information, see Remarks.
///    method = Indicates the authentication method to use. For more information and a listing of valid asynchronous
///             authentication methods, see the Remarks section. For more information and a description of the valid asynchronous
///             authentication method, see ldap_bind.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_bind_sW(ldap* ld, PWSTR dn, PWSTR cred, uint method);

///The <b>ldap_bind_s</b> function synchronously authenticates a client to the LDAP server.
///Params:
///    ld = The session handle.
///    dn = Pointer to a null-terminated string that contains the distinguished name of the entry used to bind. This can be a
///         DN, a UPN, a WinNT style user name, or other name that the directory server will accept as an identifier.
///    cred = Pointer to a null-terminated string that contains the credentials with which to authenticate. Arbitrary
///           credentials can be passed using this parameter. The format and content of the credentials depends on the setting
///           of the <i>method</i> parameter. For more information, see Remarks.
///    method = Indicates the authentication method to use. For more information and a listing of valid asynchronous
///             authentication methods, see the Remarks section. For more information and a description of the valid asynchronous
///             authentication method, see ldap_bind.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_bind_sA(ldap* ld, PSTR dn, PSTR cred, uint method);

///The <b>ldap_sasl_bind</b> is an asynchronous function that authenticates a client to the LDAP server using SASL.
///Params:
///    ExternalHandle = The session handle.
///    DistName = The distinguished name of the entry used to bind.
///    AuthMechanism = Indicates the authentication method to use.
///    cred = The credentials to use for authentication. Arbitrary credentials can be passed using this parameter. The format
///           and content of the credentials depend on the value of the <i>AuthMechanism</i> argument passed. For more
///           information, see Remarks.
///    ServerCtrls = A list of LDAP server controls.
///    ClientCtrls = A list of LDAP client controls.
///    MessageNumber = The message ID for the bind operation.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
int ldap_sasl_bindA(ldap* ExternalHandle, const(PSTR) DistName, const(PSTR) AuthMechanism, 
                    const(LDAP_BERVAL)* cred, ldapcontrolA** ServerCtrls, ldapcontrolA** ClientCtrls, 
                    int* MessageNumber);

///The <b>ldap_sasl_bind</b> is an asynchronous function that authenticates a client to the LDAP server using SASL.
///Params:
///    ExternalHandle = The session handle.
///    DistName = The distinguished name of the entry used to bind.
///    AuthMechanism = Indicates the authentication method to use.
///    cred = The credentials to use for authentication. Arbitrary credentials can be passed using this parameter. The format
///           and content of the credentials depend on the value of the <i>AuthMechanism</i> argument passed. For more
///           information, see Remarks.
///    ServerCtrls = A list of LDAP server controls.
///    ClientCtrls = A list of LDAP client controls.
///    MessageNumber = The message ID for the bind operation.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
int ldap_sasl_bindW(ldap* ExternalHandle, const(PWSTR) DistName, const(PWSTR) AuthMechanism, 
                    const(LDAP_BERVAL)* cred, ldapcontrolW** ServerCtrls, ldapcontrolW** ClientCtrls, 
                    int* MessageNumber);

///The <b>ldap_sasl_bind_s</b> function is a synchronous function that authenticates a client to the LDAP server using
///SASL.
///Params:
///    ExternalHandle = The session handle.
///    DistName = The distinguished name of the entry used to bind.
///    AuthMechanism = Indicates the authentication method to use.
///    cred = The credentials to use for authentication. Arbitrary credentials can be passed using this parameter. The format
///           and content of the credentials depend on the value of the <i>AuthMechanism</i> argument passed. For more
///           information, see Remarks.
///    ServerCtrls = A list of LDAP server controls.
///    ClientCtrls = A list of LDAP client controls.
///    ServerData = Authentication data returned by the server in response to the bind request.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
int ldap_sasl_bind_sA(ldap* ExternalHandle, const(PSTR) DistName, const(PSTR) AuthMechanism, 
                      const(LDAP_BERVAL)* cred, ldapcontrolA** ServerCtrls, ldapcontrolA** ClientCtrls, 
                      LDAP_BERVAL** ServerData);

///The <b>ldap_sasl_bind_s</b> function is a synchronous function that authenticates a client to the LDAP server using
///SASL.
///Params:
///    ExternalHandle = The session handle.
///    DistName = The distinguished name of the entry used to bind.
///    AuthMechanism = Indicates the authentication method to use.
///    cred = The credentials to use for authentication. Arbitrary credentials can be passed using this parameter. The format
///           and content of the credentials depend on the value of the <i>AuthMechanism</i> argument passed. For more
///           information, see Remarks.
///    ServerCtrls = A list of LDAP server controls.
///    ClientCtrls = A list of LDAP client controls.
///    ServerData = Authentication data returned by the server in response to the bind request.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
int ldap_sasl_bind_sW(ldap* ExternalHandle, const(PWSTR) DistName, const(PWSTR) AuthMechanism, 
                      const(LDAP_BERVAL)* cred, ldapcontrolW** ServerCtrls, ldapcontrolW** ClientCtrls, 
                      LDAP_BERVAL** ServerData);

///The <b>ldap_simple_bind</b> functionasynchronously authenticates a client to a server, using a plaintext password.
///<div class="alert"><b>Caution</b> This function sends the name and password without encrypting them, and therefore
///someone eavesdropping on the network could read the password. Unless a TLS (SSL) encrypted session has been
///established, do not use this function. For more information about how to set up an encrypted session, see
///Initializing a Session.</div><div> </div>
///Params:
///    ld = The session handle.
///    dn = The name of the user to bind as. The bind operation uses the <i>dn</i> and <i>passwd</i> parameters to
///         authenticate the user.
///    passwd = The password of the user specified in the <i>dn</i> parameter.
///Returns:
///    If the function succeeds, it returns the message ID of the operation initiated. If the function fails, it returns
///    -1 and sets the session error parameters in the LDAP data structure.
///    
@DllImport("WLDAP32")
uint ldap_simple_bind(ldap* ld, const(PSTR) dn, const(PSTR) passwd);

///The <b>ldap_simple_bind_s</b> function synchronously authenticates a client to a server, using a plaintext password.
///<div class="alert"><b>Caution</b> This function sends the name and password without encrypting them, and an
///unauthorized user, on the network, could read the password. Unless a TLS (SSL) encrypted session has been
///established, do not this function. For more information about how to set up an encrypted session, see Initializing a
///Session.</div><div> </div>
///Params:
///    ld = The session handle.
///    dn = The name of the user to bind as. The bind operation uses the <i>dn</i> and <i>passwd</i> parameters to
///         authenticate the user.
///    passwd = The password of the user specified in the <i>dn</i> parameter.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_simple_bind_s(ldap* ld, const(PSTR) dn, const(PSTR) passwd);

///The <b>ldap_bind</b> function asynchronously authenticates a client with the LDAP server. The bind operation
///identifies a client to the directory server by providing a distinguished name and some type of authentication
///credential, such as a password. The authentication method used determines the type of required credential. <div
///class="alert"><b>Caution</b> Unless a TLS (SSL) encrypted session is established, do not use this function. This
///function sends the name and password in plaintext. An unauthorized user, monitoring network traffic, could read the
///password. For more information about how to establish an encrypted session, see Initializing a Session.</div><div>
///</div>
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry used to bind.
///    cred = A pointer to a null-terminated string that contains the credentials to use for authentication. Arbitrary
///           credentials can be passed using this parameter. The format and content of the credentials depend on the setting
///           of the method parameter. For more information, see the Remarks section.
///    method = The authentication method to use.
///Returns:
///    If the function succeeds, the return value is the message ID of the initiated operation. If the function fails,
///    it returns –1 and sets the session error parameters in the LDAP structure.
///    
@DllImport("WLDAP32")
uint ldap_bind(ldap* ld, const(PSTR) dn, const(PSTR) cred, uint method);

///The <b>ldap_bind_s</b> function synchronously authenticates a client to the LDAP server.
///Params:
///    ld = The session handle.
///    dn = Pointer to a null-terminated string that contains the distinguished name of the entry used to bind. This can be a
///         DN, a UPN, a WinNT style user name, or other name that the directory server will accept as an identifier.
///    cred = Pointer to a null-terminated string that contains the credentials with which to authenticate. Arbitrary
///           credentials can be passed using this parameter. The format and content of the credentials depends on the setting
///           of the <i>method</i> parameter. For more information, see Remarks.
///    method = Indicates the authentication method to use. For more information and a listing of valid asynchronous
///             authentication methods, see the Remarks section. For more information and a description of the valid asynchronous
///             authentication method, see ldap_bind.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_bind_s(ldap* ld, const(PSTR) dn, const(PSTR) cred, uint method);

///The <b>ldap_search</b> function searches the LDAP directory and returns a requested set of attributes for each
///matched entry.
///Params:
///    ld = A session handle.
///    base = A pointer to a null-terminated string that contains the distinguished name of the entry at which to start the
///           search.
///    scope = A data type that specifies one of the following values to indicate the search scope.
///    filter = A pointer to a null-terminated string that specifies the search filter. For more information, see Search Filter
///             Syntax.
///    attrs = A null-terminated array of null-terminated strings that indicate which attributes to return for each matching
///            entry. Pass <b>NULL</b> to retrieve available attributes.
///    attrsonly = Boolean value that should be zero if both attribute types and values are to be returned, nonzero if only types
///                are required.
///Returns:
///    If the function succeeds, it returns the message ID of the search operation. If the function fails, it returns
///    –1 and sets the session error parameters in the LDAP data structure.
///    
@DllImport("WLDAP32")
uint ldap_searchW(ldap* ld, const(PWSTR) base, uint scope_, const(PWSTR) filter, ushort** attrs, uint attrsonly);

///The <b>ldap_search</b> function searches the LDAP directory and returns a requested set of attributes for each
///matched entry.
///Params:
///    ld = A session handle.
///    base = A pointer to a null-terminated string that contains the distinguished name of the entry at which to start the
///           search.
///    scope = A data type that specifies one of the following values to indicate the search scope.
///    filter = A pointer to a null-terminated string that specifies the search filter. For more information, see Search Filter
///             Syntax.
///    attrs = A null-terminated array of null-terminated strings that indicate which attributes to return for each matching
///            entry. Pass <b>NULL</b> to retrieve available attributes.
///    attrsonly = Boolean value that should be zero if both attribute types and values are to be returned, nonzero if only types
///                are required.
///Returns:
///    If the function succeeds, it returns the message ID of the search operation. If the function fails, it returns
///    –1 and sets the session error parameters in the LDAP data structure.
///    
@DllImport("WLDAP32")
uint ldap_searchA(ldap* ld, const(PSTR) base, uint scope_, const(PSTR) filter, byte** attrs, uint attrsonly);

///The <b>ldap_search_s</b> function synchronously searches the LDAP directory and returns a requested set of attributes
///for each matched entry.
///Params:
///    ld = Session handle.
///    base = Pointer to a null-terminated string that contains the distinguished name of the entry at which to start the
///           search.
///    scope = Specifies one of the following values to indicate the search scope.
///    filter = Pointer to a null-terminated string that specifies the search filter. For more information, see Search Filter
///             Syntax.
///    attrs = A null-terminated array of null-terminated strings indicating the attributes to return for each matching entry.
///            Pass <b>NULL</b> to retrieve all available attributes.
///    attrsonly = Boolean value that should be zero if both attribute types and values are to be returned, nonzero if only types
///                are required.
///    res = Contains the results of the search upon completion of the call. Can also contain partial results or extended data
///          when the function call fails with an error code. Free results returned with a call to ldap_msgfreewhen they are
///          no longer required by the application.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails it returns an error
///    code, however <b>ldap_search_s</b> can fail and can still allocate <i>pMsg</i>. For example, both
///    <b>LDAP_PARTIAL_RESULTS</b> and <b>LDAP_REFERRAL</b> error code allocate <i>pMsg</i>. For more information, see
///    the following code example. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_search_sW(ldap* ld, const(PWSTR) base, uint scope_, const(PWSTR) filter, ushort** attrs, uint attrsonly, 
                    LDAPMessage** res);

///The <b>ldap_search_s</b> function synchronously searches the LDAP directory and returns a requested set of attributes
///for each matched entry.
///Params:
///    ld = Session handle.
///    base = Pointer to a null-terminated string that contains the distinguished name of the entry at which to start the
///           search.
///    scope = Specifies one of the following values to indicate the search scope.
///    filter = Pointer to a null-terminated string that specifies the search filter. For more information, see Search Filter
///             Syntax.
///    attrs = A null-terminated array of null-terminated strings indicating the attributes to return for each matching entry.
///            Pass <b>NULL</b> to retrieve all available attributes.
///    attrsonly = Boolean value that should be zero if both attribute types and values are to be returned, nonzero if only types
///                are required.
///    res = Contains the results of the search upon completion of the call. Can also contain partial results or extended data
///          when the function call fails with an error code. Free results returned with a call to ldap_msgfreewhen they are
///          no longer required by the application.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails it returns an error
///    code, however <b>ldap_search_s</b> can fail and can still allocate <i>pMsg</i>. For example, both
///    <b>LDAP_PARTIAL_RESULTS</b> and <b>LDAP_REFERRAL</b> error code allocate <i>pMsg</i>. For more information, see
///    the following code example. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_search_sA(ldap* ld, const(PSTR) base, uint scope_, const(PSTR) filter, byte** attrs, uint attrsonly, 
                    LDAPMessage** res);

///The <b>ldap_search_st</b> function synchronously searches the LDAP directory and returns a requested set of
///attributes for each entry matched. An additional parameter specifies a local time-out for the search. The function is
///identical to ldap_search_s, except for the additional local time-out parameter.
///Params:
///    ld = Session handle.
///    base = Pointer to a null-terminated string that contains the distinguished name of the entry at which to start the
///           search.
///    scope = Specifies one of the following values to indicate the search scope.
///    filter = Pointer to a null-terminated string that specifies the search filter. For more information, see Search Filter
///             Syntax.
///    attrs = A null-terminated array of null-terminated strings that indicate which attributes to return for each matching
///            entry. Pass <b>NULL</b> to retrieve all available attributes.
///    attrsonly = Boolean value that must be zero if both attribute types and values are to be returned, nonzero if only types are
///                required.
///    timeout = The local search time-out value, in seconds.
///    res = Contains the results of the search upon completion of the call. Can also contain partial results or extended data
///          when the function call fails with an error code. Any results returned must be freed with a call to
///          ldap_msgfreewhen no longer required by the application.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code, however <b>ldap_search_st</b> can fail and can still allocate <i>pMsg</i>. For example, both
///    <b>LDAP_PARTIAL_RESULTS</b> and <b>LDAP_REFERRAL</b> error code allocate <i>pMsg</i>. For more information, see
///    the following code example. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_search_stW(ldap* ld, const(PWSTR) base, uint scope_, const(PWSTR) filter, ushort** attrs, uint attrsonly, 
                     LDAP_TIMEVAL* timeout, LDAPMessage** res);

///The <b>ldap_search_st</b> function synchronously searches the LDAP directory and returns a requested set of
///attributes for each entry matched. An additional parameter specifies a local time-out for the search. The function is
///identical to ldap_search_s, except for the additional local time-out parameter.
///Params:
///    ld = Session handle.
///    base = Pointer to a null-terminated string that contains the distinguished name of the entry at which to start the
///           search.
///    scope = Specifies one of the following values to indicate the search scope.
///    filter = Pointer to a null-terminated string that specifies the search filter. For more information, see Search Filter
///             Syntax.
///    attrs = A null-terminated array of null-terminated strings that indicate which attributes to return for each matching
///            entry. Pass <b>NULL</b> to retrieve all available attributes.
///    attrsonly = Boolean value that must be zero if both attribute types and values are to be returned, nonzero if only types are
///                required.
///    timeout = The local search time-out value, in seconds.
///    res = Contains the results of the search upon completion of the call. Can also contain partial results or extended data
///          when the function call fails with an error code. Any results returned must be freed with a call to
///          ldap_msgfreewhen no longer required by the application.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code, however <b>ldap_search_st</b> can fail and can still allocate <i>pMsg</i>. For example, both
///    <b>LDAP_PARTIAL_RESULTS</b> and <b>LDAP_REFERRAL</b> error code allocate <i>pMsg</i>. For more information, see
///    the following code example. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_search_stA(ldap* ld, const(PSTR) base, uint scope_, const(PSTR) filter, byte** attrs, uint attrsonly, 
                     LDAP_TIMEVAL* timeout, LDAPMessage** res);

///The <b>ldap_search_ext</b> function searches the LDAP directory and returns a requested set of attributes for each
///matched entry.
///Params:
///    ld = The session handle.
///    base = A pointer to a null-terminated string that contains the distinguished name of the entry at which to start the
///           search.
///    scope = Specifies one of the following values to indicate the search scope.
///    filter = A pointer to a null-terminated string that specifies the search filter. For more information, see Search Filter
///             Syntax.
///    attrs = A null-terminated array of null-terminated strings that indicate which attributes to return for each matching
///            entry. To retrieve all available attributes, pass <b>NULL</b>.
///    attrsonly = A Boolean value that should be zero if both attribute types and values are to be returned, nonzero if only types
///                are to be returned.
///    ServerControls = A list of LDAP server controls.
///    ClientControls = A list of client controls.
///    TimeLimit = Specifies both the local search time-out value in seconds and the operation time limit sent to the server within
///                the search request.
///    SizeLimit = A limit on the number of entries to return from the search. A value of zero indicates no limit.
///    MessageNumber = The request message ID.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_search_extW(ldap* ld, const(PWSTR) base, uint scope_, const(PWSTR) filter, ushort** attrs, 
                      uint attrsonly, ldapcontrolW** ServerControls, ldapcontrolW** ClientControls, uint TimeLimit, 
                      uint SizeLimit, uint* MessageNumber);

///The <b>ldap_search_ext</b> function searches the LDAP directory and returns a requested set of attributes for each
///matched entry.
///Params:
///    ld = The session handle.
///    base = A pointer to a null-terminated string that contains the distinguished name of the entry at which to start the
///           search.
///    scope = Specifies one of the following values to indicate the search scope.
///    filter = A pointer to a null-terminated string that specifies the search filter. For more information, see Search Filter
///             Syntax.
///    attrs = A null-terminated array of null-terminated strings that indicate which attributes to return for each matching
///            entry. To retrieve all available attributes, pass <b>NULL</b>.
///    attrsonly = A Boolean value that should be zero if both attribute types and values are to be returned, nonzero if only types
///                are to be returned.
///    ServerControls = A list of LDAP server controls.
///    ClientControls = A list of client controls.
///    TimeLimit = Specifies both the local search time-out value in seconds and the operation time limit sent to the server within
///                the search request.
///    SizeLimit = A limit on the number of entries to return from the search. A value of zero indicates no limit.
///    MessageNumber = The request message ID.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_search_extA(ldap* ld, const(PSTR) base, uint scope_, const(PSTR) filter, byte** attrs, uint attrsonly, 
                      ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, uint TimeLimit, uint SizeLimit, 
                      uint* MessageNumber);

///The <b>ldap_search_ext_s</b> function synchronously searches the LDAP directory and returns a requested set of
///attributes for each matched entry.
///Params:
///    ld = Session handle.
///    base = Pointer to a null-terminated string that contains the distinguished name of the entry at which to start the
///           search.
///    scope = Specifies one of the following values to indicate the search scope.
///    filter = Pointer to a null-terminated string that specifies the search filter. For more information, see Search Filter
///             Syntax.
///    attrs = A null-terminated array of pointers to null-terminated strings indicating which attributes to return for each
///            matching entry. Pass <b>NULL</b> to retrieve all available attributes.
///    attrsonly = Boolean value that should be zero if both attribute types and values are to be returned, nonzero if only types
///                are required.
///    ServerControls = A list of LDAP server controls.
///    ClientControls = A list of client controls.
///    timeout = Specifies both the local search time-out value, in seconds, and the operation time limit that is sent to the
///              server within the search request.
///    SizeLimit = A limit on the number of entries to return from the search. A value of zero indicates no limit.
///    res = Contains the results of the search upon completion of the call. Can also contain partial results or extended data
///          when the function call fails with an error code. Free returned results with a call to ldap_msgfreewhen no longer
///          required by the application.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code, however <b>ldap_search_ext_s</b> can fail and can still allocate <i>pMsg</i>. For example, both
///    <b>LDAP_PARTIAL_RESULTS</b> and <b>LDAP_REFERRAL</b> error code will allocate <i>pMsg</i>. For more information,
///    see the following code example. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_search_ext_sW(ldap* ld, const(PWSTR) base, uint scope_, const(PWSTR) filter, ushort** attrs, 
                        uint attrsonly, ldapcontrolW** ServerControls, ldapcontrolW** ClientControls, 
                        LDAP_TIMEVAL* timeout, uint SizeLimit, LDAPMessage** res);

///The <b>ldap_search_ext_s</b> function synchronously searches the LDAP directory and returns a requested set of
///attributes for each matched entry.
///Params:
///    ld = Session handle.
///    base = Pointer to a null-terminated string that contains the distinguished name of the entry at which to start the
///           search.
///    scope = Specifies one of the following values to indicate the search scope.
///    filter = Pointer to a null-terminated string that specifies the search filter. For more information, see Search Filter
///             Syntax.
///    attrs = A null-terminated array of pointers to null-terminated strings indicating which attributes to return for each
///            matching entry. Pass <b>NULL</b> to retrieve all available attributes.
///    attrsonly = Boolean value that should be zero if both attribute types and values are to be returned, nonzero if only types
///                are required.
///    ServerControls = A list of LDAP server controls.
///    ClientControls = A list of client controls.
///    timeout = Specifies both the local search time-out value, in seconds, and the operation time limit that is sent to the
///              server within the search request.
///    SizeLimit = A limit on the number of entries to return from the search. A value of zero indicates no limit.
///    res = Contains the results of the search upon completion of the call. Can also contain partial results or extended data
///          when the function call fails with an error code. Free returned results with a call to ldap_msgfreewhen no longer
///          required by the application.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code, however <b>ldap_search_ext_s</b> can fail and can still allocate <i>pMsg</i>. For example, both
///    <b>LDAP_PARTIAL_RESULTS</b> and <b>LDAP_REFERRAL</b> error code will allocate <i>pMsg</i>. For more information,
///    see the following code example. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_search_ext_sA(ldap* ld, const(PSTR) base, uint scope_, const(PSTR) filter, byte** attrs, uint attrsonly, 
                        ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, LDAP_TIMEVAL* timeout, 
                        uint SizeLimit, LDAPMessage** res);

///The <b>ldap_search</b> function searches the LDAP directory and returns a requested set of attributes for each
///matched entry.
///Params:
///    ld = A session handle.
///    base = A pointer to a null-terminated string that contains the distinguished name of the entry at which to start the
///           search.
///    scope = A data type that specifies one of the following values to indicate the search scope.
///    filter = A pointer to a null-terminated string that specifies the search filter. For more information, see Search Filter
///             Syntax.
///    attrs = A null-terminated array of null-terminated strings that indicate which attributes to return for each matching
///            entry. Pass <b>NULL</b> to retrieve available attributes.
///    attrsonly = Boolean value that should be zero if both attribute types and values are to be returned, nonzero if only types
///                are required.
///Returns:
///    If the function succeeds, it returns the message ID of the search operation. If the function fails, it returns
///    –1 and sets the session error parameters in the LDAP data structure.
///    
@DllImport("WLDAP32")
uint ldap_search(ldap* ld, PSTR base, uint scope_, PSTR filter, byte** attrs, uint attrsonly);

///The <b>ldap_search_s</b> function synchronously searches the LDAP directory and returns a requested set of attributes
///for each matched entry.
///Params:
///    ld = Session handle.
///    base = Pointer to a null-terminated string that contains the distinguished name of the entry at which to start the
///           search.
///    scope = Specifies one of the following values to indicate the search scope.
///    filter = Pointer to a null-terminated string that specifies the search filter. For more information, see Search Filter
///             Syntax.
///    attrs = A null-terminated array of null-terminated strings indicating the attributes to return for each matching entry.
///            Pass <b>NULL</b> to retrieve all available attributes.
///    attrsonly = Boolean value that should be zero if both attribute types and values are to be returned, nonzero if only types
///                are required.
///    res = Contains the results of the search upon completion of the call. Can also contain partial results or extended data
///          when the function call fails with an error code. Free results returned with a call to ldap_msgfreewhen they are
///          no longer required by the application.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails it returns an error
///    code, however <b>ldap_search_s</b> can fail and can still allocate <i>pMsg</i>. For example, both
///    <b>LDAP_PARTIAL_RESULTS</b> and <b>LDAP_REFERRAL</b> error code allocate <i>pMsg</i>. For more information, see
///    the following code example. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_search_s(ldap* ld, PSTR base, uint scope_, PSTR filter, byte** attrs, uint attrsonly, LDAPMessage** res);

///The <b>ldap_search_st</b> function synchronously searches the LDAP directory and returns a requested set of
///attributes for each entry matched. An additional parameter specifies a local time-out for the search. The function is
///identical to ldap_search_s, except for the additional local time-out parameter.
///Params:
///    ld = Session handle.
///    base = Pointer to a null-terminated string that contains the distinguished name of the entry at which to start the
///           search.
///    scope = Specifies one of the following values to indicate the search scope.
///    filter = Pointer to a null-terminated string that specifies the search filter. For more information, see Search Filter
///             Syntax.
///    attrs = A null-terminated array of null-terminated strings that indicate which attributes to return for each matching
///            entry. Pass <b>NULL</b> to retrieve all available attributes.
///    attrsonly = Boolean value that must be zero if both attribute types and values are to be returned, nonzero if only types are
///                required.
///    timeout = The local search time-out value, in seconds.
///    res = Contains the results of the search upon completion of the call. Can also contain partial results or extended data
///          when the function call fails with an error code. Any results returned must be freed with a call to
///          ldap_msgfreewhen no longer required by the application.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code, however <b>ldap_search_st</b> can fail and can still allocate <i>pMsg</i>. For example, both
///    <b>LDAP_PARTIAL_RESULTS</b> and <b>LDAP_REFERRAL</b> error code allocate <i>pMsg</i>. For more information, see
///    the following code example. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_search_st(ldap* ld, PSTR base, uint scope_, PSTR filter, byte** attrs, uint attrsonly, 
                    LDAP_TIMEVAL* timeout, LDAPMessage** res);

///The <b>ldap_search_ext</b> function searches the LDAP directory and returns a requested set of attributes for each
///matched entry.
///Params:
///    ld = The session handle.
///    base = A pointer to a null-terminated string that contains the distinguished name of the entry at which to start the
///           search.
///    scope = Specifies one of the following values to indicate the search scope.
///    filter = A pointer to a null-terminated string that specifies the search filter. For more information, see Search Filter
///             Syntax.
///    attrs = A null-terminated array of null-terminated strings that indicate which attributes to return for each matching
///            entry. To retrieve all available attributes, pass <b>NULL</b>.
///    attrsonly = A Boolean value that should be zero if both attribute types and values are to be returned, nonzero if only types
///                are to be returned.
///    ServerControls = A list of LDAP server controls.
///    ClientControls = A list of client controls.
///    TimeLimit = Specifies both the local search time-out value in seconds and the operation time limit sent to the server within
///                the search request.
///    SizeLimit = A limit on the number of entries to return from the search. A value of zero indicates no limit.
///    MessageNumber = The request message ID.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_search_ext(ldap* ld, PSTR base, uint scope_, PSTR filter, byte** attrs, uint attrsonly, 
                     ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, uint TimeLimit, uint SizeLimit, 
                     uint* MessageNumber);

///The <b>ldap_search_ext_s</b> function synchronously searches the LDAP directory and returns a requested set of
///attributes for each matched entry.
///Params:
///    ld = Session handle.
///    base = Pointer to a null-terminated string that contains the distinguished name of the entry at which to start the
///           search.
///    scope = Specifies one of the following values to indicate the search scope.
///    filter = Pointer to a null-terminated string that specifies the search filter. For more information, see Search Filter
///             Syntax.
///    attrs = A null-terminated array of pointers to null-terminated strings indicating which attributes to return for each
///            matching entry. Pass <b>NULL</b> to retrieve all available attributes.
///    attrsonly = Boolean value that should be zero if both attribute types and values are to be returned, nonzero if only types
///                are required.
///    ServerControls = A list of LDAP server controls.
///    ClientControls = A list of client controls.
///    timeout = Specifies both the local search time-out value, in seconds, and the operation time limit that is sent to the
///              server within the search request.
///    SizeLimit = A limit on the number of entries to return from the search. A value of zero indicates no limit.
///    res = Contains the results of the search upon completion of the call. Can also contain partial results or extended data
///          when the function call fails with an error code. Free returned results with a call to ldap_msgfreewhen no longer
///          required by the application.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code, however <b>ldap_search_ext_s</b> can fail and can still allocate <i>pMsg</i>. For example, both
///    <b>LDAP_PARTIAL_RESULTS</b> and <b>LDAP_REFERRAL</b> error code will allocate <i>pMsg</i>. For more information,
///    see the following code example. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_search_ext_s(ldap* ld, PSTR base, uint scope_, PSTR filter, byte** attrs, uint attrsonly, 
                       ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, LDAP_TIMEVAL* timeout, 
                       uint SizeLimit, LDAPMessage** res);

///The <b>ldap_check_filter</b> function is used to verify filter syntax.
///Params:
///    ld = The session handle.
///    SearchFilter = A pointer to a wide, null-terminated string that contains the name of the filter to check.
///Returns:
///    If the function succeeds, <b>LDAP_SUCCESS</b> is returned. If the function fails, an error code is returned. For
///    more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_check_filterW(ldap* ld, PWSTR SearchFilter);

///The <b>ldap_check_filter</b> function is used to verify filter syntax.
///Params:
///    ld = The session handle.
///    SearchFilter = A pointer to a wide, null-terminated string that contains the name of the filter to check.
///Returns:
///    If the function succeeds, <b>LDAP_SUCCESS</b> is returned. If the function fails, an error code is returned. For
///    more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_check_filterA(ldap* ld, PSTR SearchFilter);

///The <b>ldap_modify</b> function changes an existing entry.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the name of the entry to modify.
///    mods = A null-terminated array of modifications to make to the entry.
///Returns:
///    If the function succeeds, it returns the message ID of the modify operation. If the function fails, it returns
///    –1 and sets the session error parameters in the LDAP data structure.
///    
@DllImport("WLDAP32")
uint ldap_modifyW(ldap* ld, PWSTR dn, ldapmodW** mods);

///The <b>ldap_modify</b> function changes an existing entry.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the name of the entry to modify.
///    mods = A null-terminated array of modifications to make to the entry.
///Returns:
///    If the function succeeds, it returns the message ID of the modify operation. If the function fails, it returns
///    –1 and sets the session error parameters in the LDAP data structure.
///    
@DllImport("WLDAP32")
uint ldap_modifyA(ldap* ld, PSTR dn, ldapmodA** mods);

///The <b>ldap_modify_s</b> function changes an existing entry.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the name of the entry to modify.
///    mods = A null-terminated array of modifications to make to the entry.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_modify_sW(ldap* ld, PWSTR dn, ldapmodW** mods);

///The <b>ldap_modify_s</b> function changes an existing entry.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the name of the entry to modify.
///    mods = A null-terminated array of modifications to make to the entry.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_modify_sA(ldap* ld, PSTR dn, ldapmodA** mods);

///The <b>ldap_modify_ext</b> function changes an existing entry.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the name of the entry to modify.
///    mods = A null-terminated array of modifications to make to the entry.
///    ServerControls = A list of LDAP server controls.
///    ClientControls = A list of client controls
///    MessageNumber = This result parameter is set to the message ID of the request if the call succeeds.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_modify_extW(ldap* ld, const(PWSTR) dn, ldapmodW** mods, ldapcontrolW** ServerControls, 
                      ldapcontrolW** ClientControls, uint* MessageNumber);

///The <b>ldap_modify_ext</b> function changes an existing entry.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the name of the entry to modify.
///    mods = A null-terminated array of modifications to make to the entry.
///    ServerControls = A list of LDAP server controls.
///    ClientControls = A list of client controls
///    MessageNumber = This result parameter is set to the message ID of the request if the call succeeds.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_modify_extA(ldap* ld, const(PSTR) dn, ldapmodA** mods, ldapcontrolA** ServerControls, 
                      ldapcontrolA** ClientControls, uint* MessageNumber);

///The <b>ldap_modify_ext_s</b> function changes an existing entry.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the name of the entry to modify.
///    mods = A null-terminated array of modifications to make to the entry.
///    ServerControls = A list of LDAP server controls.
///    ClientControls = A list of client controls.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_modify_ext_sW(ldap* ld, const(PWSTR) dn, ldapmodW** mods, ldapcontrolW** ServerControls, 
                        ldapcontrolW** ClientControls);

///The <b>ldap_modify_ext_s</b> function changes an existing entry.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the name of the entry to modify.
///    mods = A null-terminated array of modifications to make to the entry.
///    ServerControls = A list of LDAP server controls.
///    ClientControls = A list of client controls.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_modify_ext_sA(ldap* ld, const(PSTR) dn, ldapmodA** mods, ldapcontrolA** ServerControls, 
                        ldapcontrolA** ClientControls);

///The <b>ldap_modify</b> function changes an existing entry.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the name of the entry to modify.
///    mods = A null-terminated array of modifications to make to the entry.
///Returns:
///    If the function succeeds, it returns the message ID of the modify operation. If the function fails, it returns
///    –1 and sets the session error parameters in the LDAP data structure.
///    
@DllImport("WLDAP32")
uint ldap_modify(ldap* ld, PSTR dn, ldapmodA** mods);

///The <b>ldap_modify_s</b> function changes an existing entry.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the name of the entry to modify.
///    mods = A null-terminated array of modifications to make to the entry.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_modify_s(ldap* ld, PSTR dn, ldapmodA** mods);

///The <b>ldap_modify_ext</b> function changes an existing entry.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the name of the entry to modify.
///    mods = A null-terminated array of modifications to make to the entry.
///    ServerControls = A list of LDAP server controls.
///    ClientControls = A list of client controls
///    MessageNumber = This result parameter is set to the message ID of the request if the call succeeds.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_modify_ext(ldap* ld, const(PSTR) dn, ldapmodA** mods, ldapcontrolA** ServerControls, 
                     ldapcontrolA** ClientControls, uint* MessageNumber);

///The <b>ldap_modify_ext_s</b> function changes an existing entry.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the name of the entry to modify.
///    mods = A null-terminated array of modifications to make to the entry.
///    ServerControls = A list of LDAP server controls.
///    ClientControls = A list of client controls.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_modify_ext_s(ldap* ld, const(PSTR) dn, ldapmodA** mods, ldapcontrolA** ServerControls, 
                       ldapcontrolA** ClientControls);

///The <b>ldap_modrdn2</b> function changes the relative distinguished name of an LDAP entry. This function is obsolete.
///For LDAP 3 or later, use the ldap_rename_ext or ldap_rename_ext_s functions.
///Params:
///    ExternalHandle = The session handle.
///    DistinguishedName = A null-terminated string that contains the distinguished name to change.
///    NewDistinguishedName = A null-terminated string that contains the new relative distinguished name to give the entry.
///    DeleteOldRdn = <b>TRUE</b> if the old relative distinguished name should be deleted; <b>FALSE</b> if the old relative
///                   distinguished name should be retained.
///Returns:
///    If the function succeeds, it returns the message ID of the modify operation. If the function fails, it returns
///    –1 and sets the session error parameters in the LDAP data structure.
///    
@DllImport("WLDAP32")
uint ldap_modrdn2W(ldap* ExternalHandle, const(PWSTR) DistinguishedName, const(PWSTR) NewDistinguishedName, 
                   int DeleteOldRdn);

///The <b>ldap_modrdn2</b> function changes the relative distinguished name of an LDAP entry. This function is obsolete.
///For LDAP 3 or later, use the ldap_rename_ext or ldap_rename_ext_s functions.
///Params:
///    ExternalHandle = The session handle.
///    DistinguishedName = A null-terminated string that contains the distinguished name to change.
///    NewDistinguishedName = A null-terminated string that contains the new relative distinguished name to give the entry.
///    DeleteOldRdn = <b>TRUE</b> if the old relative distinguished name should be deleted; <b>FALSE</b> if the old relative
///                   distinguished name should be retained.
///Returns:
///    If the function succeeds, it returns the message ID of the modify operation. If the function fails, it returns
///    –1 and sets the session error parameters in the LDAP data structure.
///    
@DllImport("WLDAP32")
uint ldap_modrdn2A(ldap* ExternalHandle, const(PSTR) DistinguishedName, const(PSTR) NewDistinguishedName, 
                   int DeleteOldRdn);

///The <b>ldap_modrdn</b> function changes the relative distinguished name of an LDAP entry. This function is obsolete
///and is provided for backward compatibility with earlier versions of LDAP. For LDAP 3 or later, use the
///ldap_rename_ext or ldap_rename_ext_s functions.
///Params:
///    ExternalHandle = The session handle.
///    DistinguishedName = A pointer to a null-terminated string that contains the distinguished name of the entry to be changed.
///    NewDistinguishedName = A pointer to a null-terminated string that contains the new relative distinguished name to give the entry.
///Returns:
///    If the function succeeds, it returns the message ID of the modify operation. If the function fails, it returns
///    –1 and sets the session error parameters in the LDAP data structure.
///    
@DllImport("WLDAP32")
uint ldap_modrdnW(ldap* ExternalHandle, const(PWSTR) DistinguishedName, const(PWSTR) NewDistinguishedName);

///The <b>ldap_modrdn</b> function changes the relative distinguished name of an LDAP entry. This function is obsolete
///and is provided for backward compatibility with earlier versions of LDAP. For LDAP 3 or later, use the
///ldap_rename_ext or ldap_rename_ext_s functions.
///Params:
///    ExternalHandle = The session handle.
///    DistinguishedName = A pointer to a null-terminated string that contains the distinguished name of the entry to be changed.
///    NewDistinguishedName = A pointer to a null-terminated string that contains the new relative distinguished name to give the entry.
///Returns:
///    If the function succeeds, it returns the message ID of the modify operation. If the function fails, it returns
///    –1 and sets the session error parameters in the LDAP data structure.
///    
@DllImport("WLDAP32")
uint ldap_modrdnA(ldap* ExternalHandle, const(PSTR) DistinguishedName, const(PSTR) NewDistinguishedName);

///The <b>ldap_modrdn2_s</b> function changes the relative distinguished name of an LDAP entry. This function is
///obsolete. For LDAP 3 or later, use the ldap_rename_ext or ldap_rename_ext_s functions.
///Params:
///    ExternalHandle = The session handle.
///    DistinguishedName = A pointer to a null-terminated string that contains the distinguished name to change.
///    NewDistinguishedName = A pointer to a null-terminated string that contains the new relative distinguished name to give the entry.
///    DeleteOldRdn = <b>TRUE</b> if the old relative distinguished name should be deleted; <b>FALSE</b> if the old relative
///                   distinguished name should be retained.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_modrdn2_sW(ldap* ExternalHandle, const(PWSTR) DistinguishedName, const(PWSTR) NewDistinguishedName, 
                     int DeleteOldRdn);

///The <b>ldap_modrdn2_s</b> function changes the relative distinguished name of an LDAP entry. This function is
///obsolete. For LDAP 3 or later, use the ldap_rename_ext or ldap_rename_ext_s functions.
///Params:
///    ExternalHandle = The session handle.
///    DistinguishedName = A pointer to a null-terminated string that contains the distinguished name to change.
///    NewDistinguishedName = A pointer to a null-terminated string that contains the new relative distinguished name to give the entry.
///    DeleteOldRdn = <b>TRUE</b> if the old relative distinguished name should be deleted; <b>FALSE</b> if the old relative
///                   distinguished name should be retained.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_modrdn2_sA(ldap* ExternalHandle, const(PSTR) DistinguishedName, const(PSTR) NewDistinguishedName, 
                     int DeleteOldRdn);

///The <b>ldap_modrdn_s</b> function changes the relative distinguished name of an LDAP entry. This function is obsolete
///and is provided for backward compatibility with earlier versions of LDAP. For LDAP 3 or later, use the
///ldap_rename_ext or ldap_rename_ext_s function.
///Params:
///    ExternalHandle = The session handle.
///    DistinguishedName = A pointer to a null-terminated string that contains the distinguished name of the entry to be changed.
///    NewDistinguishedName = A pointer to a null-terminated string that contains the new relative distinguished name to give the entry.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_modrdn_sW(ldap* ExternalHandle, const(PWSTR) DistinguishedName, const(PWSTR) NewDistinguishedName);

///The <b>ldap_modrdn_s</b> function changes the relative distinguished name of an LDAP entry. This function is obsolete
///and is provided for backward compatibility with earlier versions of LDAP. For LDAP 3 or later, use the
///ldap_rename_ext or ldap_rename_ext_s function.
///Params:
///    ExternalHandle = The session handle.
///    DistinguishedName = A pointer to a null-terminated string that contains the distinguished name of the entry to be changed.
///    NewDistinguishedName = A pointer to a null-terminated string that contains the new relative distinguished name to give the entry.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_modrdn_sA(ldap* ExternalHandle, const(PSTR) DistinguishedName, const(PSTR) NewDistinguishedName);

///The <b>ldap_modrdn2</b> function changes the relative distinguished name of an LDAP entry. This function is obsolete.
///For LDAP 3 or later, use the ldap_rename_ext or ldap_rename_ext_s functions.
///Params:
///    ExternalHandle = The session handle.
///    DistinguishedName = A null-terminated string that contains the distinguished name to change.
///    NewDistinguishedName = A null-terminated string that contains the new relative distinguished name to give the entry.
///    DeleteOldRdn = <b>TRUE</b> if the old relative distinguished name should be deleted; <b>FALSE</b> if the old relative
///                   distinguished name should be retained.
///Returns:
///    If the function succeeds, it returns the message ID of the modify operation. If the function fails, it returns
///    –1 and sets the session error parameters in the LDAP data structure.
///    
@DllImport("WLDAP32")
uint ldap_modrdn2(ldap* ExternalHandle, const(PSTR) DistinguishedName, const(PSTR) NewDistinguishedName, 
                  int DeleteOldRdn);

///The <b>ldap_modrdn</b> function changes the relative distinguished name of an LDAP entry. This function is obsolete
///and is provided for backward compatibility with earlier versions of LDAP. For LDAP 3 or later, use the
///ldap_rename_ext or ldap_rename_ext_s functions.
///Params:
///    ExternalHandle = The session handle.
///    DistinguishedName = A pointer to a null-terminated string that contains the distinguished name of the entry to be changed.
///    NewDistinguishedName = A pointer to a null-terminated string that contains the new relative distinguished name to give the entry.
///Returns:
///    If the function succeeds, it returns the message ID of the modify operation. If the function fails, it returns
///    –1 and sets the session error parameters in the LDAP data structure.
///    
@DllImport("WLDAP32")
uint ldap_modrdn(ldap* ExternalHandle, const(PSTR) DistinguishedName, const(PSTR) NewDistinguishedName);

///The <b>ldap_modrdn2_s</b> function changes the relative distinguished name of an LDAP entry. This function is
///obsolete. For LDAP 3 or later, use the ldap_rename_ext or ldap_rename_ext_s functions.
///Params:
///    ExternalHandle = The session handle.
///    DistinguishedName = A pointer to a null-terminated string that contains the distinguished name to change.
///    NewDistinguishedName = A pointer to a null-terminated string that contains the new relative distinguished name to give the entry.
///    DeleteOldRdn = <b>TRUE</b> if the old relative distinguished name should be deleted; <b>FALSE</b> if the old relative
///                   distinguished name should be retained.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_modrdn2_s(ldap* ExternalHandle, const(PSTR) DistinguishedName, const(PSTR) NewDistinguishedName, 
                    int DeleteOldRdn);

///The <b>ldap_modrdn_s</b> function changes the relative distinguished name of an LDAP entry. This function is obsolete
///and is provided for backward compatibility with earlier versions of LDAP. For LDAP 3 or later, use the
///ldap_rename_ext or ldap_rename_ext_s function.
///Params:
///    ExternalHandle = The session handle.
///    DistinguishedName = A pointer to a null-terminated string that contains the distinguished name of the entry to be changed.
///    NewDistinguishedName = A pointer to a null-terminated string that contains the new relative distinguished name to give the entry.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_modrdn_s(ldap* ExternalHandle, const(PSTR) DistinguishedName, const(PSTR) NewDistinguishedName);

///The <b>ldap_rename_ext</b> function starts an asynchronous operation that changes the distinguished name of an entry
///in the directory. This function is available effective with LDAP 3.
///Params:
///    ld = The session handle.
///    dn = A pointer to a wide, null-terminated string that contains the distinguished name of the entry to be renamed.
///    NewRDN = A pointer to a wide, null-terminated string that contains the new relative distinguished name for the entry.
///    NewParent = A pointer to a wide, null-terminated string that contains the distinguished name of the new parent for this
///                entry. This parameter enables you to move the entry to a new parent container.
///    DeleteOldRdn = <b>TRUE</b> if the old relative distinguished name should be deleted; <b>FALSE</b> if the old relative
///                   distinguished name should be retained.
///    ServerControls = List of LDAP server controls.
///    ClientControls = List of client controls.
///    MessageNumber = Pointer to a variable that receives the message identifier for this asynchronous operation. Use this identifier
///                    with the ldap_result function to retrieve the results of the operation.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_rename_extW(ldap* ld, const(PWSTR) dn, const(PWSTR) NewRDN, const(PWSTR) NewParent, int DeleteOldRdn, 
                      ldapcontrolW** ServerControls, ldapcontrolW** ClientControls, uint* MessageNumber);

///The <b>ldap_rename_ext</b> function starts an asynchronous operation that changes the distinguished name of an entry
///in the directory. This function is available effective with LDAP 3.
///Params:
///    ld = The session handle.
///    dn = A pointer to a wide, null-terminated string that contains the distinguished name of the entry to be renamed.
///    NewRDN = A pointer to a wide, null-terminated string that contains the new relative distinguished name for the entry.
///    NewParent = A pointer to a wide, null-terminated string that contains the distinguished name of the new parent for this
///                entry. This parameter enables you to move the entry to a new parent container.
///    DeleteOldRdn = <b>TRUE</b> if the old relative distinguished name should be deleted; <b>FALSE</b> if the old relative
///                   distinguished name should be retained.
///    ServerControls = List of LDAP server controls.
///    ClientControls = List of client controls.
///    MessageNumber = Pointer to a variable that receives the message identifier for this asynchronous operation. Use this identifier
///                    with the ldap_result function to retrieve the results of the operation.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_rename_extA(ldap* ld, const(PSTR) dn, const(PSTR) NewRDN, const(PSTR) NewParent, int DeleteOldRdn, 
                      ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, uint* MessageNumber);

///The <b>ldap_rename_ext_s</b> function is a synchronous operation that changes the distinguished name of an entry in
///the directory. This function is available effective with LDAP 3.
///Params:
///    ld = The session handle.
///    dn = A pointer to a wide, null-terminated string that contains the distinguished name of the entry to be renamed.
///    NewRDN = A pointer to a wide, null-terminated string that contains the new relative distinguished name.
///    NewParent = A pointer to a wide, null-terminated string that contains the distinguished name of the new parent for this
///                entry. This parameter enables you to move the entry to a new parent container.
///    DeleteOldRdn = <b>TRUE</b> if the old relative distinguished name should be deleted; <b>FALSE</b> if the old relative
///                   distinguished name should be retained.
///    ServerControls = List of LDAP server controls.
///    ClientControls = List of client controls.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_rename_ext_sW(ldap* ld, const(PWSTR) dn, const(PWSTR) NewRDN, const(PWSTR) NewParent, int DeleteOldRdn, 
                        ldapcontrolW** ServerControls, ldapcontrolW** ClientControls);

///The <b>ldap_rename_ext_s</b> function is a synchronous operation that changes the distinguished name of an entry in
///the directory. This function is available effective with LDAP 3.
///Params:
///    ld = The session handle.
///    dn = A pointer to a wide, null-terminated string that contains the distinguished name of the entry to be renamed.
///    NewRDN = A pointer to a wide, null-terminated string that contains the new relative distinguished name.
///    NewParent = A pointer to a wide, null-terminated string that contains the distinguished name of the new parent for this
///                entry. This parameter enables you to move the entry to a new parent container.
///    DeleteOldRdn = <b>TRUE</b> if the old relative distinguished name should be deleted; <b>FALSE</b> if the old relative
///                   distinguished name should be retained.
///    ServerControls = List of LDAP server controls.
///    ClientControls = List of client controls.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_rename_ext_sA(ldap* ld, const(PSTR) dn, const(PSTR) NewRDN, const(PSTR) NewParent, int DeleteOldRdn, 
                        ldapcontrolA** ServerControls, ldapcontrolA** ClientControls);

///The <b>ldap_rename_ext</b> function starts an asynchronous operation that changes the distinguished name of an entry
///in the directory. This function is available effective with LDAP 3.
///Params:
///    ld = The session handle.
///    dn = A pointer to a wide, null-terminated string that contains the distinguished name of the entry to be renamed.
///    NewRDN = A pointer to a wide, null-terminated string that contains the new relative distinguished name for the entry.
///    NewParent = A pointer to a wide, null-terminated string that contains the distinguished name of the new parent for this
///                entry. This parameter enables you to move the entry to a new parent container.
///    DeleteOldRdn = <b>TRUE</b> if the old relative distinguished name should be deleted; <b>FALSE</b> if the old relative
///                   distinguished name should be retained.
///    ServerControls = List of LDAP server controls.
///    ClientControls = List of client controls.
///    MessageNumber = Pointer to a variable that receives the message identifier for this asynchronous operation. Use this identifier
///                    with the ldap_result function to retrieve the results of the operation.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_rename_ext(ldap* ld, const(PSTR) dn, const(PSTR) NewRDN, const(PSTR) NewParent, int DeleteOldRdn, 
                     ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, uint* MessageNumber);

///The <b>ldap_rename_ext_s</b> function is a synchronous operation that changes the distinguished name of an entry in
///the directory. This function is available effective with LDAP 3.
///Params:
///    ld = The session handle.
///    dn = A pointer to a wide, null-terminated string that contains the distinguished name of the entry to be renamed.
///    NewRDN = A pointer to a wide, null-terminated string that contains the new relative distinguished name.
///    NewParent = A pointer to a wide, null-terminated string that contains the distinguished name of the new parent for this
///                entry. This parameter enables you to move the entry to a new parent container.
///    DeleteOldRdn = <b>TRUE</b> if the old relative distinguished name should be deleted; <b>FALSE</b> if the old relative
///                   distinguished name should be retained.
///    ServerControls = List of LDAP server controls.
///    ClientControls = List of client controls.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_rename_ext_s(ldap* ld, const(PSTR) dn, const(PSTR) NewRDN, const(PSTR) NewParent, int DeleteOldRdn, 
                       ldapcontrolA** ServerControls, ldapcontrolA** ClientControls);

///The <b>ldap_add</b> function initiates an asynchronous add operation to a directory tree. For an add operation to
///succeed, the parent of the entry added must exist, or the parent must be empty (equal to the distinguished name of
///the root).
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry to add.
///    attrs = An array of pointers to LDAPMod structures. Each structure specifies a single attribute.
///Returns:
///    If the function succeeds, the message ID of the add operation is returned. If the function fails, it returns –1
///    and sets the session error parameters in the LDAP data structure. To retrieve the error data, use
///    LdapGetLastError.
///    
@DllImport("WLDAP32")
uint ldap_addW(ldap* ld, PWSTR dn, ldapmodW** attrs);

///The <b>ldap_add</b> function initiates an asynchronous add operation to a directory tree. For an add operation to
///succeed, the parent of the entry added must exist, or the parent must be empty (equal to the distinguished name of
///the root).
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry to add.
///    attrs = An array of pointers to LDAPMod structures. Each structure specifies a single attribute.
///Returns:
///    If the function succeeds, the message ID of the add operation is returned. If the function fails, it returns –1
///    and sets the session error parameters in the LDAP data structure. To retrieve the error data, use
///    LdapGetLastError.
///    
@DllImport("WLDAP32")
uint ldap_addA(ldap* ld, PSTR dn, ldapmodA** attrs);

///The <b>ldap_add_s</b> function initiates a synchronous add operation that adds an entry to a tree. The parent of the
///entry being added must already exist or the parent must be empty (equal to the root distinguished name) for an add
///operation to succeed.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry to add.
///    attrs = A null-terminated array of pointers to LDAPMod structures. Each structure specifies a single attribute. See
///            Remarks for more information.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_add_sW(ldap* ld, PWSTR dn, ldapmodW** attrs);

///The <b>ldap_add_s</b> function initiates a synchronous add operation that adds an entry to a tree. The parent of the
///entry being added must already exist or the parent must be empty (equal to the root distinguished name) for an add
///operation to succeed.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry to add.
///    attrs = A null-terminated array of pointers to LDAPMod structures. Each structure specifies a single attribute. See
///            Remarks for more information.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_add_sA(ldap* ld, PSTR dn, ldapmodA** attrs);

///The <b>ldap_add_ext</b> function initiates an asynchronous add operation to a tree. The parent of the entry added
///must exist, or the parent must be empty (equal to the distinguished name of the root) for an add operation to
///succeed.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry to add.
///    attrs = An array of pointers to LDAPMod structures. Each structure specifies a single attribute. For more information,
///            see the Remarks section.
///    ServerControls = List of LDAP server controls.
///    ClientControls = List of client controls.
///    MessageNumber = The message ID for the request.
///Returns:
///    If the function succeeds, <b>LDAP_SUCCESS</b> is returned. If the function fails, an error code is returned. For
///    more information, see Error Handling.
///    
@DllImport("WLDAP32")
uint ldap_add_extW(ldap* ld, const(PWSTR) dn, ldapmodW** attrs, ldapcontrolW** ServerControls, 
                   ldapcontrolW** ClientControls, uint* MessageNumber);

///The <b>ldap_add_ext</b> function initiates an asynchronous add operation to a tree. The parent of the entry added
///must exist, or the parent must be empty (equal to the distinguished name of the root) for an add operation to
///succeed.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry to add.
///    attrs = An array of pointers to LDAPMod structures. Each structure specifies a single attribute. For more information,
///            see the Remarks section.
///    ServerControls = List of LDAP server controls.
///    ClientControls = List of client controls.
///    MessageNumber = The message ID for the request.
///Returns:
///    If the function succeeds, <b>LDAP_SUCCESS</b> is returned. If the function fails, an error code is returned. For
///    more information, see Error Handling.
///    
@DllImport("WLDAP32")
uint ldap_add_extA(ldap* ld, const(PSTR) dn, ldapmodA** attrs, ldapcontrolA** ServerControls, 
                   ldapcontrolA** ClientControls, uint* MessageNumber);

///The <b>ldap_add_ext_s</b> function initiates a synchronous add operation to a tree. For an add operation to succeed,
///the parent of the entry added must exist, or the parent must be empty (equal to the distinguished name of the root).
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry to add.
///    attrs = An array of pointers to LDAPMod structures. Each structure specifies a single attribute. For more information,
///            see the Remarks section.
///    ServerControls = A list of LDAP server controls.
///    ClientControls = A list of client controls.
///Returns:
///    If the function succeeds, <b>LDAP_SUCCESS</b> is returned. If the function fails, an error code is returned. For
///    more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_add_ext_sW(ldap* ld, const(PWSTR) dn, ldapmodW** attrs, ldapcontrolW** ServerControls, 
                     ldapcontrolW** ClientControls);

///The <b>ldap_add_ext_s</b> function initiates a synchronous add operation to a tree. For an add operation to succeed,
///the parent of the entry added must exist, or the parent must be empty (equal to the distinguished name of the root).
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry to add.
///    attrs = An array of pointers to LDAPMod structures. Each structure specifies a single attribute. For more information,
///            see the Remarks section.
///    ServerControls = A list of LDAP server controls.
///    ClientControls = A list of client controls.
///Returns:
///    If the function succeeds, <b>LDAP_SUCCESS</b> is returned. If the function fails, an error code is returned. For
///    more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_add_ext_sA(ldap* ld, const(PSTR) dn, ldapmodA** attrs, ldapcontrolA** ServerControls, 
                     ldapcontrolA** ClientControls);

///The <b>ldap_add</b> function initiates an asynchronous add operation to a directory tree. For an add operation to
///succeed, the parent of the entry added must exist, or the parent must be empty (equal to the distinguished name of
///the root).
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry to add.
///    attrs = An array of pointers to LDAPMod structures. Each structure specifies a single attribute.
///Returns:
///    If the function succeeds, the message ID of the add operation is returned. If the function fails, it returns –1
///    and sets the session error parameters in the LDAP data structure. To retrieve the error data, use
///    LdapGetLastError.
///    
@DllImport("WLDAP32")
uint ldap_add(ldap* ld, PSTR dn, ldapmodA** attrs);

///The <b>ldap_add_s</b> function initiates a synchronous add operation that adds an entry to a tree. The parent of the
///entry being added must already exist or the parent must be empty (equal to the root distinguished name) for an add
///operation to succeed.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry to add.
///    attrs = A null-terminated array of pointers to LDAPMod structures. Each structure specifies a single attribute. See
///            Remarks for more information.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_add_s(ldap* ld, PSTR dn, ldapmodA** attrs);

///The <b>ldap_add_ext</b> function initiates an asynchronous add operation to a tree. The parent of the entry added
///must exist, or the parent must be empty (equal to the distinguished name of the root) for an add operation to
///succeed.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry to add.
///    attrs = An array of pointers to LDAPMod structures. Each structure specifies a single attribute. For more information,
///            see the Remarks section.
///    ServerControls = List of LDAP server controls.
///    ClientControls = List of client controls.
///    MessageNumber = The message ID for the request.
///Returns:
///    If the function succeeds, <b>LDAP_SUCCESS</b> is returned. If the function fails, an error code is returned. For
///    more information, see Error Handling.
///    
@DllImport("WLDAP32")
uint ldap_add_ext(ldap* ld, const(PSTR) dn, ldapmodA** attrs, ldapcontrolA** ServerControls, 
                  ldapcontrolA** ClientControls, uint* MessageNumber);

///The <b>ldap_add_ext_s</b> function initiates a synchronous add operation to a tree. For an add operation to succeed,
///the parent of the entry added must exist, or the parent must be empty (equal to the distinguished name of the root).
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry to add.
///    attrs = An array of pointers to LDAPMod structures. Each structure specifies a single attribute. For more information,
///            see the Remarks section.
///    ServerControls = A list of LDAP server controls.
///    ClientControls = A list of client controls.
///Returns:
///    If the function succeeds, <b>LDAP_SUCCESS</b> is returned. If the function fails, an error code is returned. For
///    more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_add_ext_s(ldap* ld, const(PSTR) dn, ldapmodA** attrs, ldapcontrolA** ServerControls, 
                    ldapcontrolA** ClientControls);

///Use the <b>ldap_compare</b> function to determine whether an attribute for a given entry holds a known value.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry.
///    attr = A pointer to a null-terminated string that contains the attribute to compare.
///    value = A pointer to a null-terminated string that contains the string attribute value to compare to the attribute value.
///Returns:
///    If the function succeeds, the message ID of the compare operation is returned. If the function fails, it returns
///    –1 and sets the session error parameters in the LDAP structure. This error can then be retrieved using
///    LdapGetLastError.
///    
@DllImport("WLDAP32")
uint ldap_compareW(ldap* ld, const(PWSTR) dn, const(PWSTR) attr, PWSTR value);

///Use the <b>ldap_compare</b> function to determine whether an attribute for a given entry holds a known value.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry.
///    attr = A pointer to a null-terminated string that contains the attribute to compare.
///    value = A pointer to a null-terminated string that contains the string attribute value to compare to the attribute value.
///Returns:
///    If the function succeeds, the message ID of the compare operation is returned. If the function fails, it returns
///    –1 and sets the session error parameters in the LDAP structure. This error can then be retrieved using
///    LdapGetLastError.
///    
@DllImport("WLDAP32")
uint ldap_compareA(ldap* ld, const(PSTR) dn, const(PSTR) attr, PSTR value);

///Use the <b>ldap_compare_s</b> function to determine whether an attribute for a given entry holds a known value.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry.
///    attr = A pointer to a null-terminated string that contains the attribute to compare.
///    value = A pointer to a null-terminated string that contains the string attribute value to compare to the attribute value.
///Returns:
///    If the function succeeds, and the attribute and known values match, the return value is <b>LDAP_COMPARE_TRUE</b>.
///    If the values do not match, the return value is <b>LDAP_COMPARE_FALSE</b>. If the function fails, it returns an
///    error code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_compare_sW(ldap* ld, const(PWSTR) dn, const(PWSTR) attr, PWSTR value);

///Use the <b>ldap_compare_s</b> function to determine whether an attribute for a given entry holds a known value.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry.
///    attr = A pointer to a null-terminated string that contains the attribute to compare.
///    value = A pointer to a null-terminated string that contains the string attribute value to compare to the attribute value.
///Returns:
///    If the function succeeds, and the attribute and known values match, the return value is <b>LDAP_COMPARE_TRUE</b>.
///    If the values do not match, the return value is <b>LDAP_COMPARE_FALSE</b>. If the function fails, it returns an
///    error code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_compare_sA(ldap* ld, const(PSTR) dn, const(PSTR) attr, PSTR value);

///Use the <b>ldap_compare</b> function to determine whether an attribute for a given entry holds a known value.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry.
///    attr = A pointer to a null-terminated string that contains the attribute to compare.
///    value = A pointer to a null-terminated string that contains the string attribute value to compare to the attribute value.
///Returns:
///    If the function succeeds, the message ID of the compare operation is returned. If the function fails, it returns
///    –1 and sets the session error parameters in the LDAP structure. This error can then be retrieved using
///    LdapGetLastError.
///    
@DllImport("WLDAP32")
uint ldap_compare(ldap* ld, const(PSTR) dn, const(PSTR) attr, PSTR value);

///Use the <b>ldap_compare_s</b> function to determine whether an attribute for a given entry holds a known value.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry.
///    attr = A pointer to a null-terminated string that contains the attribute to compare.
///    value = A pointer to a null-terminated string that contains the string attribute value to compare to the attribute value.
///Returns:
///    If the function succeeds, and the attribute and known values match, the return value is <b>LDAP_COMPARE_TRUE</b>.
///    If the values do not match, the return value is <b>LDAP_COMPARE_FALSE</b>. If the function fails, it returns an
///    error code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_compare_s(ldap* ld, const(PSTR) dn, const(PSTR) attr, PSTR value);

///Use the <b>ldap_compare_ext</b> function to determine if an attribute, for a given entry, holds a known value.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry to compare.
///    Attr = A pointer to a null-terminated string that contains the attribute to compare.
///    Value = A pointer to a null-terminated string that contains the string attribute value to be compared to the attribute
///            value.
///    Data = The berval attribute value to be compared to the attribute value.
///    ServerControls = Optional. A list of LDAP server controls. This parameter should be set to <b>NULL</b> if not used.
///    ClientControls = Optional. A list of client controls. This parameter should be set to <b>NULL</b> if not used.
///    MessageNumber = The message ID for the compare operation.
///Returns:
///    If the function succeeds, <b>LDAP_SUCCESS</b> is returned. If the function fails, an error code is returned. For
///    more information, see Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_compare_extW(ldap* ld, const(PWSTR) dn, const(PWSTR) Attr, const(PWSTR) Value, LDAP_BERVAL* Data, 
                       ldapcontrolW** ServerControls, ldapcontrolW** ClientControls, uint* MessageNumber);

///Use the <b>ldap_compare_ext</b> function to determine if an attribute, for a given entry, holds a known value.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry to compare.
///    Attr = A pointer to a null-terminated string that contains the attribute to compare.
///    Value = A pointer to a null-terminated string that contains the string attribute value to be compared to the attribute
///            value.
///    Data = The berval attribute value to be compared to the attribute value.
///    ServerControls = Optional. A list of LDAP server controls. This parameter should be set to <b>NULL</b> if not used.
///    ClientControls = Optional. A list of client controls. This parameter should be set to <b>NULL</b> if not used.
///    MessageNumber = The message ID for the compare operation.
///Returns:
///    If the function succeeds, <b>LDAP_SUCCESS</b> is returned. If the function fails, an error code is returned. For
///    more information, see Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_compare_extA(ldap* ld, const(PSTR) dn, const(PSTR) Attr, const(PSTR) Value, LDAP_BERVAL* Data, 
                       ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, uint* MessageNumber);

///Use the <b>ldap_compare_ext_s</b> function to determine if an attribute, for a given entry, holds a known value.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry to compare.
///    Attr = A pointer to a null-terminated string that contains the attribute to compare.
///    Value = A pointer to a null-terminated string that contains the string attribute value to be compared to the attribute
///            value. Set to <b>NULL</b> if not used.
///    Data = The berval attribute value to be compared to the attribute value. Set to <b>NULL</b> if not used.
///    ServerControls = Optional. A list of LDAP server controls. Set to <b>NULL</b> if not used.
///    ClientControls = Optional. A list of LDAP client controls. Set to <b>NULL</b> if not used.
///Returns:
///    If the function succeeds, and the attribute and known values match, <b>LDAP_COMPARE_TRUE</b> is returned; if the
///    values do not match, <b>LDAP_COMPARE_FALSE</b> is returned. If the function fails, an error code is returned. For
///    more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_compare_ext_sW(ldap* ld, const(PWSTR) dn, const(PWSTR) Attr, const(PWSTR) Value, LDAP_BERVAL* Data, 
                         ldapcontrolW** ServerControls, ldapcontrolW** ClientControls);

///Use the <b>ldap_compare_ext_s</b> function to determine if an attribute, for a given entry, holds a known value.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry to compare.
///    Attr = A pointer to a null-terminated string that contains the attribute to compare.
///    Value = A pointer to a null-terminated string that contains the string attribute value to be compared to the attribute
///            value. Set to <b>NULL</b> if not used.
///    Data = The berval attribute value to be compared to the attribute value. Set to <b>NULL</b> if not used.
///    ServerControls = Optional. A list of LDAP server controls. Set to <b>NULL</b> if not used.
///    ClientControls = Optional. A list of LDAP client controls. Set to <b>NULL</b> if not used.
///Returns:
///    If the function succeeds, and the attribute and known values match, <b>LDAP_COMPARE_TRUE</b> is returned; if the
///    values do not match, <b>LDAP_COMPARE_FALSE</b> is returned. If the function fails, an error code is returned. For
///    more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_compare_ext_sA(ldap* ld, const(PSTR) dn, const(PSTR) Attr, const(PSTR) Value, LDAP_BERVAL* Data, 
                         ldapcontrolA** ServerControls, ldapcontrolA** ClientControls);

///Use the <b>ldap_compare_ext</b> function to determine if an attribute, for a given entry, holds a known value.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry to compare.
///    Attr = A pointer to a null-terminated string that contains the attribute to compare.
///    Value = A pointer to a null-terminated string that contains the string attribute value to be compared to the attribute
///            value.
///    Data = The berval attribute value to be compared to the attribute value.
///    ServerControls = Optional. A list of LDAP server controls. This parameter should be set to <b>NULL</b> if not used.
///    ClientControls = Optional. A list of client controls. This parameter should be set to <b>NULL</b> if not used.
///    MessageNumber = The message ID for the compare operation.
///Returns:
///    If the function succeeds, <b>LDAP_SUCCESS</b> is returned. If the function fails, an error code is returned. For
///    more information, see Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_compare_ext(ldap* ld, const(PSTR) dn, const(PSTR) Attr, const(PSTR) Value, LDAP_BERVAL* Data, 
                      ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, uint* MessageNumber);

///Use the <b>ldap_compare_ext_s</b> function to determine if an attribute, for a given entry, holds a known value.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry to compare.
///    Attr = A pointer to a null-terminated string that contains the attribute to compare.
///    Value = A pointer to a null-terminated string that contains the string attribute value to be compared to the attribute
///            value. Set to <b>NULL</b> if not used.
///    Data = The berval attribute value to be compared to the attribute value. Set to <b>NULL</b> if not used.
///    ServerControls = Optional. A list of LDAP server controls. Set to <b>NULL</b> if not used.
///    ClientControls = Optional. A list of LDAP client controls. Set to <b>NULL</b> if not used.
///Returns:
///    If the function succeeds, and the attribute and known values match, <b>LDAP_COMPARE_TRUE</b> is returned; if the
///    values do not match, <b>LDAP_COMPARE_FALSE</b> is returned. If the function fails, an error code is returned. For
///    more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_compare_ext_s(ldap* ld, const(PSTR) dn, const(PSTR) Attr, const(PSTR) Value, LDAP_BERVAL* Data, 
                        ldapcontrolA** ServerControls, ldapcontrolA** ClientControls);

///The <b>ldap_delete</b> function deletes an entry from the directory tree.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry to delete.
///Returns:
///    If the function succeeds, it returns the message ID of the delete operation. If the function fails, the return
///    value is –1 and the function sets the session error parameters in the LDAP data structure. To retrieve this
///    value, use LdapGetLastError.
///    
@DllImport("WLDAP32")
uint ldap_deleteW(ldap* ld, const(PWSTR) dn);

///The <b>ldap_delete</b> function deletes an entry from the directory tree.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry to delete.
///Returns:
///    If the function succeeds, it returns the message ID of the delete operation. If the function fails, the return
///    value is –1 and the function sets the session error parameters in the LDAP data structure. To retrieve this
///    value, use LdapGetLastError.
///    
@DllImport("WLDAP32")
uint ldap_deleteA(ldap* ld, const(PSTR) dn);

///The <b>ldap_delete_s</b> function is a synchronous operation that removes a leaf entry from the directory tree.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry to delete.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_delete_sW(ldap* ld, const(PWSTR) dn);

///The <b>ldap_delete_s</b> function is a synchronous operation that removes a leaf entry from the directory tree.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry to delete.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_delete_sA(ldap* ld, const(PSTR) dn);

///The <b>ldap_delete_ext</b> function is an extended routine that removes a leaf entry from the directory tree.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry to delete.
///    ServerControls = Optional. List of LDAP server controls. If not used, set this parameter to NULL.
///    ClientControls = Optional. List of client controls. If not used, set this parameter to <b>NULL</b>.
///    MessageNumber = Message ID for the request.
///Returns:
///    If the function succeeds, <b>LDAP_SUCCESS</b> is returned. If the function fails, an error code is returned. For
///    more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_delete_extW(ldap* ld, const(PWSTR) dn, ldapcontrolW** ServerControls, ldapcontrolW** ClientControls, 
                      uint* MessageNumber);

///The <b>ldap_delete_ext</b> function is an extended routine that removes a leaf entry from the directory tree.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry to delete.
///    ServerControls = Optional. List of LDAP server controls. If not used, set this parameter to NULL.
///    ClientControls = Optional. List of client controls. If not used, set this parameter to <b>NULL</b>.
///    MessageNumber = Message ID for the request.
///Returns:
///    If the function succeeds, <b>LDAP_SUCCESS</b> is returned. If the function fails, an error code is returned. For
///    more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_delete_extA(ldap* ld, const(PSTR) dn, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, 
                      uint* MessageNumber);

///The <b>ldap_delete_ext_s</b> function is an extended routine that performs a synchronous operation to remove a leaf
///entry from the directory tree.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry to delete.
///    ServerControls = Optional. List of LDAP server controls. Set this parameter to <b>NULL</b> if not used.
///    ClientControls = Optional. List of client controls. Set this parameter to <b>NULL</b> if not used.
///Returns:
///    If the function succeeds, <b>LDAP_SUCCESS</b> is returned. If the function fails, an error code is returned. For
///    more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_delete_ext_sW(ldap* ld, const(PWSTR) dn, ldapcontrolW** ServerControls, ldapcontrolW** ClientControls);

///The <b>ldap_delete_ext_s</b> function is an extended routine that performs a synchronous operation to remove a leaf
///entry from the directory tree.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry to delete.
///    ServerControls = Optional. List of LDAP server controls. Set this parameter to <b>NULL</b> if not used.
///    ClientControls = Optional. List of client controls. Set this parameter to <b>NULL</b> if not used.
///Returns:
///    If the function succeeds, <b>LDAP_SUCCESS</b> is returned. If the function fails, an error code is returned. For
///    more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_delete_ext_sA(ldap* ld, const(PSTR) dn, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls);

///The <b>ldap_delete</b> function deletes an entry from the directory tree.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry to delete.
///Returns:
///    If the function succeeds, it returns the message ID of the delete operation. If the function fails, the return
///    value is –1 and the function sets the session error parameters in the LDAP data structure. To retrieve this
///    value, use LdapGetLastError.
///    
@DllImport("WLDAP32")
uint ldap_delete(ldap* ld, PSTR dn);

///The <b>ldap_delete_s</b> function is a synchronous operation that removes a leaf entry from the directory tree.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry to delete.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_delete_s(ldap* ld, PSTR dn);

///The <b>ldap_delete_ext</b> function is an extended routine that removes a leaf entry from the directory tree.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry to delete.
///    ServerControls = Optional. List of LDAP server controls. If not used, set this parameter to NULL.
///    ClientControls = Optional. List of client controls. If not used, set this parameter to <b>NULL</b>.
///    MessageNumber = Message ID for the request.
///Returns:
///    If the function succeeds, <b>LDAP_SUCCESS</b> is returned. If the function fails, an error code is returned. For
///    more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_delete_ext(ldap* ld, const(PSTR) dn, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, 
                     uint* MessageNumber);

///The <b>ldap_delete_ext_s</b> function is an extended routine that performs a synchronous operation to remove a leaf
///entry from the directory tree.
///Params:
///    ld = The session handle.
///    dn = A pointer to a null-terminated string that contains the distinguished name of the entry to delete.
///    ServerControls = Optional. List of LDAP server controls. Set this parameter to <b>NULL</b> if not used.
///    ClientControls = Optional. List of client controls. Set this parameter to <b>NULL</b> if not used.
///Returns:
///    If the function succeeds, <b>LDAP_SUCCESS</b> is returned. If the function fails, an error code is returned. For
///    more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_delete_ext_s(ldap* ld, const(PSTR) dn, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls);

///A client calls <b>ldap_abandon</b> to cancel an in-process asynchronous LDAP call.
///Params:
///    ld = The session handle.
///    msgid = The message ID of the call to be canceled. Asynchronous functions, such as ldap_search and ldap_modify, return
///            this message ID when they initiate an operation.
///Returns:
///    If the function succeeds, that is, if the cancel operation is successful, the return value is zero. If the
///    function fails, the return value is –1.
///    
@DllImport("WLDAP32")
uint ldap_abandon(ldap* ld, uint msgid);

///The <b>ldap_result</b> function obtains the result of an asynchronous operation.
///Params:
///    ld = The session handle.
///    msgid = The message ID of the operation, or the constant LDAP_RES_ANY if any result is required.
///    all = Specifies how many messages are retrieved in a single call to <b>ldap_result</b>. This parameter only has meaning
///          for search results. Pass the constant LDAP_MSG_ONE (0x00) to retrieve one message at a time. Pass LDAP_MSG_ALL
///          (0x01) to request that all results of a search be received before returning all results in a single chain. Pass
///          LDAP_MSG_RECEIVED (0x02) to indicate that all results retrieved so far should be returned in the result chain.
///    timeout = A timeout that specifies how long, in seconds, to wait for results to be returned. A <b>NULL</b> value causes
///              <b>ldap_result</b> to block until results are available. A timeout value of zero seconds specifies a polling
///              behavior.
///    res = Contains the result(s) of the operation. Any results returned should be freed with a call to ldap_msgfreeonce
///          they are no longer required by the application.
///Returns:
///    If the function succeeds, it returns one of the following values to indicate the type of the first result in the
///    <i>res</i> parameter. If the time-out expires, the function returns 0. If the function fails, it returns –1 and
///    sets the session error parameters in the LDAP data structure.
///    
@DllImport("WLDAP32")
uint ldap_result(ldap* ld, uint msgid, uint all, LDAP_TIMEVAL* timeout, LDAPMessage** res);

///The <b>ldap_msgfree</b> function frees the results obtained from a previous call to ldap_result, or to one of the
///synchronous search routines.
///Params:
///    res = The result, or chain of results, to free.
///Returns:
///    Returns <b>LDAP_SUCCESS</b>.
///    
@DllImport("WLDAP32")
uint ldap_msgfree(LDAPMessage* res);

///The <b>ldap_result2error</b> function parses a message and returns the error code.
///Params:
///    ld = The session handle.
///    res = The result of an LDAP operation, as returned by ldap_result, or one of the synchronous API operation calls.
///    freeit = Determines whether the LDAPMessage, pointed to by the <i>res</i> parameter, is freed. Setting <i>freeit</i> to
///             <b>TRUE</b> frees the message by calling the ldap_msgfree function.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_result2error(ldap* ld, LDAPMessage* res, uint freeit);

///The <b>ldap_parse_result</b> function parses responses from the server and returns the appropriate fields.
///Params:
///    Connection = The session handle.
///    ResultMessage = The result of an LDAP operation as returned by one of the synchronous operation calls or by ldap_result for an
///                    asynchronous operation.
///    ReturnCode = Indicates the outcome of the server operation that generated the original result message. Pass <b>NULL</b> to
///                 ignore this field.
///    MatchedDNs = A pointer to a wide, null-terminated string. In the case of a return of <b>LDAP_NO_SUCH_OBJECT</b>, this result
///                 parameter is filled in with a distinguished name indicating how much of the name in the request was recognized.
///                 Pass <b>NULL</b> to ignore this field.
///    ErrorMessage = A pointer to a wide, null-terminated string that contains the contents of the error message field from the
///                   <i>ResultMessage</i> parameter. Pass <b>NULL</b> to ignore this field.
///    Referrals = A pointer to a wide, null-terminated string that contains the contents of the referrals field from the
///                <i>ResultMessage</i> parameter, indicating zero or more alternate LDAP servers where the request should be
///                retried. Pass <b>NULL</b> to ignore this field.
///    ServerControls = This result parameter is filled in with an allocated array of controls copied from the <i>ResultMessage</i>
///                     parameter.
///    Freeit = Determines whether the <i>ResultMessage</i> parameter is freed. You can pass any nonzero value to the
///             <i>Freeit</i> parameter to free the <i>ResultMessage</i> pointer when it is no longer needed, or you can call
///             ldap_msgfree to free the result later.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_parse_resultW(ldap* Connection, LDAPMessage* ResultMessage, uint* ReturnCode, PWSTR* MatchedDNs, 
                        PWSTR* ErrorMessage, ushort*** Referrals, ldapcontrolW*** ServerControls, ubyte Freeit);

///The <b>ldap_parse_result</b> function parses responses from the server and returns the appropriate fields.
///Params:
///    Connection = The session handle.
///    ResultMessage = The result of an LDAP operation as returned by one of the synchronous operation calls or by ldap_result for an
///                    asynchronous operation.
///    ReturnCode = Indicates the outcome of the server operation that generated the original result message. Pass <b>NULL</b> to
///                 ignore this field.
///    MatchedDNs = A pointer to a wide, null-terminated string. In the case of a return of <b>LDAP_NO_SUCH_OBJECT</b>, this result
///                 parameter is filled in with a distinguished name indicating how much of the name in the request was recognized.
///                 Pass <b>NULL</b> to ignore this field.
///    ErrorMessage = A pointer to a wide, null-terminated string that contains the contents of the error message field from the
///                   <i>ResultMessage</i> parameter. Pass <b>NULL</b> to ignore this field.
///    Referrals = A pointer to a wide, null-terminated string that contains the contents of the referrals field from the
///                <i>ResultMessage</i> parameter, indicating zero or more alternate LDAP servers where the request should be
///                retried. Pass <b>NULL</b> to ignore this field.
///    ServerControls = This result parameter is filled in with an allocated array of controls copied from the <i>ResultMessage</i>
///                     parameter.
///    Freeit = Determines whether the <i>ResultMessage</i> parameter is freed. You can pass any nonzero value to the
///             <i>Freeit</i> parameter to free the <i>ResultMessage</i> pointer when it is no longer needed, or you can call
///             ldap_msgfree to free the result later.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_parse_resultA(ldap* Connection, LDAPMessage* ResultMessage, uint* ReturnCode, PSTR* MatchedDNs, 
                        PSTR* ErrorMessage, byte*** Referrals, ldapcontrolA*** ServerControls, ubyte Freeit);

///The <b>ldap_parse_extended_result</b> parses the results of an LDAP extended operation.
///Params:
///    Connection = The session handle.
///    ResultMessage = A pointer to an LDAPMessage structure as returned by ldap_result in response to an extended operation request.
///    ResultOID = A pointer to a null-terminated string that contains the dotted object identifier (OID) text string of the
///                server's response message. This is normally the same OID as the one naming the request that was originally passed
///                to the server by ldap_extended_operation.
///    ResultData = The arbitrary data returned by the extended operation (if <b>NULL</b>, no data is returned by the server).
///    Freeit = Determines whether the <i>ResultMessage</i> parameter is freed. You can pass any nonzero value to the
///             <i>Freeit</i> parameter to free the <i>ResultMessage</i> pointer when it is no longer needed, or you can call
///             ldap_msgfree to free the result later.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_parse_extended_resultA(ldap* Connection, LDAPMessage* ResultMessage, PSTR* ResultOID, 
                                 LDAP_BERVAL** ResultData, ubyte Freeit);

///The <b>ldap_parse_extended_result</b> parses the results of an LDAP extended operation.
///Params:
///    Connection = The session handle.
///    ResultMessage = A pointer to an LDAPMessage structure as returned by ldap_result in response to an extended operation request.
///    ResultOID = A pointer to a null-terminated string that contains the dotted object identifier (OID) text string of the
///                server's response message. This is normally the same OID as the one naming the request that was originally passed
///                to the server by ldap_extended_operation.
///    ResultData = The arbitrary data returned by the extended operation (if <b>NULL</b>, no data is returned by the server).
///    Freeit = Determines whether the <i>ResultMessage</i> parameter is freed. You can pass any nonzero value to the
///             <i>Freeit</i> parameter to free the <i>ResultMessage</i> pointer when it is no longer needed, or you can call
///             ldap_msgfree to free the result later.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_parse_extended_resultW(ldap* Connection, LDAPMessage* ResultMessage, PWSTR* ResultOID, 
                                 LDAP_BERVAL** ResultData, ubyte Freeit);

///The <b>ldap_controls_free</b> function frees an array of LDAPControl structures.
///Params:
///    Controls = The array of LDAPControl structures to free.
///Returns:
///    If the function succeeds, <b>LDAP_SUCCESS</b> is returned. If the function fails, an error code is returned. For
///    more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_controls_freeA(ldapcontrolA** Controls);

///The <b>ldap_control_free</b> function frees an LDAPControl structure.
///Params:
///    Controls = TBD
///Returns:
///    If the function succeeds, <b>LDAP_SUCCESS</b> is returned. If the function fails, an error code is returned. For
///    more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_control_freeA(ldapcontrolA* Controls);

///The <b>ldap_controls_free</b> function frees an array of LDAPControl structures.
///Params:
///    Control = TBD
///Returns:
///    If the function succeeds, <b>LDAP_SUCCESS</b> is returned. If the function fails, an error code is returned. For
///    more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_controls_freeW(ldapcontrolW** Control);

///The <b>ldap_control_free</b> function frees an LDAPControl structure.
///Params:
///    Control = The LDAPControl structure to free.
///Returns:
///    If the function succeeds, <b>LDAP_SUCCESS</b> is returned. If the function fails, an error code is returned. For
///    more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_control_freeW(ldapcontrolW* Control);

///This function is not supported. The <b>ldap_free_controls</b> function is an obsolete function which frees an array
///of LDAPControl structures. <div class="alert"><b>Note</b> Obsolete. Use the ldap_controls_free function.</div><div>
///</div>
///Params:
///    Controls = The array of LDAPControl structures to free.
///Returns:
///    If the function succeeds, <b>LDAP_SUCCESS</b> is returned. If the function fails, an error code is returned. For
///    more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_free_controlsW(ldapcontrolW** Controls);

///This function is not supported. The <b>ldap_free_controls</b> function is an obsolete function which frees an array
///of LDAPControl structures. <div class="alert"><b>Note</b> Obsolete. Use the ldap_controls_free function.</div><div>
///</div>
///Params:
///    Controls = The array of LDAPControl structures to free.
@DllImport("WLDAP32")
uint ldap_free_controlsA(ldapcontrolA** Controls);

///The <b>ldap_parse_result</b> function parses responses from the server and returns the appropriate fields.
///Params:
///    Connection = The session handle.
///    ResultMessage = The result of an LDAP operation as returned by one of the synchronous operation calls or by ldap_result for an
///                    asynchronous operation.
///    ReturnCode = Indicates the outcome of the server operation that generated the original result message. Pass <b>NULL</b> to
///                 ignore this field.
///    MatchedDNs = A pointer to a wide, null-terminated string. In the case of a return of <b>LDAP_NO_SUCH_OBJECT</b>, this result
///                 parameter is filled in with a distinguished name indicating how much of the name in the request was recognized.
///                 Pass <b>NULL</b> to ignore this field.
///    ErrorMessage = A pointer to a wide, null-terminated string that contains the contents of the error message field from the
///                   <i>ResultMessage</i> parameter. Pass <b>NULL</b> to ignore this field.
///    Referrals = A pointer to a wide, null-terminated string that contains the contents of the referrals field from the
///                <i>ResultMessage</i> parameter, indicating zero or more alternate LDAP servers where the request should be
///                retried. Pass <b>NULL</b> to ignore this field.
///    ServerControls = This result parameter is filled in with an allocated array of controls copied from the <i>ResultMessage</i>
///                     parameter.
///    Freeit = Determines whether the <i>ResultMessage</i> parameter is freed. You can pass any nonzero value to the
///             <i>Freeit</i> parameter to free the <i>ResultMessage</i> pointer when it is no longer needed, or you can call
///             ldap_msgfree to free the result later.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_parse_result(ldap* Connection, LDAPMessage* ResultMessage, uint* ReturnCode, PSTR* MatchedDNs, 
                       PSTR* ErrorMessage, PSTR** Referrals, ldapcontrolA*** ServerControls, ubyte Freeit);

///The <b>ldap_controls_free</b> function frees an array of LDAPControl structures.
///Params:
///    Controls = The array of LDAPControl structures to free.
///Returns:
///    If the function succeeds, <b>LDAP_SUCCESS</b> is returned. If the function fails, an error code is returned. For
///    more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_controls_free(ldapcontrolA** Controls);

///The <b>ldap_control_free</b> function frees an LDAPControl structure.
///Params:
///    Control = The LDAPControl structure to free.
///Returns:
///    If the function succeeds, <b>LDAP_SUCCESS</b> is returned. If the function fails, an error code is returned. For
///    more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_control_free(ldapcontrolA* Control);

///This function is not supported. The <b>ldap_free_controls</b> function is an obsolete function which frees an array
///of LDAPControl structures. <div class="alert"><b>Note</b> Obsolete. Use the ldap_controls_free function.</div><div>
///</div>
///Params:
///    Controls = The array of LDAPControl structures to free.
@DllImport("WLDAP32")
uint ldap_free_controls(ldapcontrolA** Controls);

///The <b>ldap_err2string</b> function converts a numeric LDAP error code into a null-terminated character string that
///describes the error.
///Params:
///    err = An LDAP error code as returned by another LDAP function.
///Returns:
///    If the function succeeds, a pointer to a null-terminated character string that describes the error, is returned.
///    If the function fails, a pointer to <b>NULL</b> is returned.
///    
@DllImport("WLDAP32")
PWSTR ldap_err2stringW(uint err);

///The <b>ldap_err2string</b> function converts a numeric LDAP error code into a null-terminated character string that
///describes the error.
///Params:
///    err = An LDAP error code as returned by another LDAP function.
///Returns:
///    If the function succeeds, a pointer to a null-terminated character string that describes the error, is returned.
///    If the function fails, a pointer to <b>NULL</b> is returned.
///    
@DllImport("WLDAP32")
PSTR ldap_err2stringA(uint err);

///The <b>ldap_err2string</b> function converts a numeric LDAP error code into a null-terminated character string that
///describes the error.
///Params:
///    err = An LDAP error code as returned by another LDAP function.
///Returns:
///    If the function succeeds, a pointer to a null-terminated character string that describes the error, is returned.
///    If the function fails, a pointer to <b>NULL</b> is returned.
///    
@DllImport("WLDAP32")
PSTR ldap_err2string(uint err);

///This function is not supported. The <b>ldap_perror</b> function is an obsolete function. It exists only for
///compatibility. <div class="alert"><b>Note</b> Obsolete. Use the LdapGetLastError function instead.</div><div> </div>
///Params:
///    ld = Session handle.
///    msg = A message.
@DllImport("WLDAP32")
void ldap_perror(ldap* ld, const(PSTR) msg);

///The <b>ldap_first_entry</b> function returns the first entry of a message.
///Params:
///    ld = The session handle.
///    res = The search result, as obtained by a call to one of the synchronous search routines or ldap_result.
///Returns:
///    If the search returned valid results, this function returns a pointer to the first result entry. If no entry or
///    reference exists in the result set, it returns <b>NULL</b>. This is the only error return; the session error
///    parameter in the LDAP data structure is cleared to 0 in either case.
///    
@DllImport("WLDAP32")
LDAPMessage* ldap_first_entry(ldap* ld, LDAPMessage* res);

///The <b>ldap_next_entry</b> function retrieves an entry from a search result chain.
///Params:
///    ld = The session handle.
///    entry = The entry returned by a previous call to ldap_first_entry or <b>ldap_next_entry</b>.
///Returns:
///    If the search returned valid results, this function returns a pointer to the next result entry in the results
///    set. If no further entries or references exist in the result set, it returns <b>NULL</b>. This is the only error
///    return; the session error parameter in the LDAP data structure is cleared to 0 in either case.
///    
@DllImport("WLDAP32")
LDAPMessage* ldap_next_entry(ldap* ld, LDAPMessage* entry);

///The <b>ldap_count_entries</b> function counts the number of search entries that a server returned.
///Params:
///    ld = The session handle.
///    res = The search result obtained by a call to one of the synchronous search routines or to ldap_result.
///Returns:
///    If the function succeeds, it returns the number of entries. If the function fails, the return value is –1 and
///    the function sets the session error parameters in the LDAP data structure.
///    
@DllImport("WLDAP32")
uint ldap_count_entries(ldap* ld, LDAPMessage* res);

///For a given directory entry, the <b>ldap_first_attribute</b> function returns the first attribute.
///Params:
///    ld = The session handle.
///    entry = The entry whose attributes are to be stepped through, as returned by ldap_first_entry or ldap_next_entry.
///    ptr = The address of a pointer used internally to track the current position in the entry.
///Returns:
///    A pointer to a null-terminated string. If the function succeeds, it returns a pointer to an allocated buffer that
///    contains the current attribute name. When there are no more attributes to step through, it returns <b>NULL</b>.
///    The session error parameter in the LDAP data structure is set to 0 in either case. If the function fails, it
///    returns <b>NULL</b> and sets the session error parameter in the LDAP data structure to the LDAP error code.
///    
@DllImport("WLDAP32")
PWSTR ldap_first_attributeW(ldap* ld, LDAPMessage* entry, berelement** ptr);

///For a given directory entry, the <b>ldap_first_attribute</b> function returns the first attribute.
///Params:
///    ld = The session handle.
///    entry = The entry whose attributes are to be stepped through, as returned by ldap_first_entry or ldap_next_entry.
///    ptr = The address of a pointer used internally to track the current position in the entry.
///Returns:
///    A pointer to a null-terminated string. If the function succeeds, it returns a pointer to an allocated buffer that
///    contains the current attribute name. When there are no more attributes to step through, it returns <b>NULL</b>.
///    The session error parameter in the LDAP data structure is set to 0 in either case. If the function fails, it
///    returns <b>NULL</b> and sets the session error parameter in the LDAP data structure to the LDAP error code.
///    
@DllImport("WLDAP32")
PSTR ldap_first_attributeA(ldap* ld, LDAPMessage* entry, berelement** ptr);

///For a given directory entry, the <b>ldap_first_attribute</b> function returns the first attribute.
///Params:
///    ld = The session handle.
///    entry = The entry whose attributes are to be stepped through, as returned by ldap_first_entry or ldap_next_entry.
///    ptr = The address of a pointer used internally to track the current position in the entry.
///Returns:
///    A pointer to a null-terminated string. If the function succeeds, it returns a pointer to an allocated buffer that
///    contains the current attribute name. When there are no more attributes to step through, it returns <b>NULL</b>.
///    The session error parameter in the LDAP data structure is set to 0 in either case. If the function fails, it
///    returns <b>NULL</b> and sets the session error parameter in the LDAP data structure to the LDAP error code.
///    
@DllImport("WLDAP32")
PSTR ldap_first_attribute(ldap* ld, LDAPMessage* entry, berelement** ptr);

///For a given entry, the <b>ldap_next_attribute</b> function returns the next attribute.
///Params:
///    ld = The session handle.
///    entry = The entry whose attributes are to be stepped through, as returned by ldap_first_entry or ldap_next_entry.
///    ptr = The address of a pointer used internally to track the current position in the entry.
///Returns:
///    If the function succeeds, it returns a pointer to a null-terminated string that contains the current attribute
///    name. If there are no more attributes to step through, it returns <b>NULL</b>. The session error parameter in the
///    LDAP data structure is set to 0 in either case. If the function fails, it returns <b>NULL</b> and sets the
///    session error parameter in the LDAP data structure to the LDAP error code.
///    
@DllImport("WLDAP32")
PWSTR ldap_next_attributeW(ldap* ld, LDAPMessage* entry, berelement* ptr);

///For a given entry, the <b>ldap_next_attribute</b> function returns the next attribute.
///Params:
///    ld = The session handle.
///    entry = The entry whose attributes are to be stepped through, as returned by ldap_first_entry or ldap_next_entry.
///    ptr = The address of a pointer used internally to track the current position in the entry.
///Returns:
///    If the function succeeds, it returns a pointer to a null-terminated string that contains the current attribute
///    name. If there are no more attributes to step through, it returns <b>NULL</b>. The session error parameter in the
///    LDAP data structure is set to 0 in either case. If the function fails, it returns <b>NULL</b> and sets the
///    session error parameter in the LDAP data structure to the LDAP error code.
///    
@DllImport("WLDAP32")
PSTR ldap_next_attributeA(ldap* ld, LDAPMessage* entry, berelement* ptr);

///For a given entry, the <b>ldap_next_attribute</b> function returns the next attribute.
///Params:
///    ld = The session handle.
///    entry = The entry whose attributes are to be stepped through, as returned by ldap_first_entry or ldap_next_entry.
///    ptr = The address of a pointer used internally to track the current position in the entry.
///Returns:
///    If the function succeeds, it returns a pointer to a null-terminated string that contains the current attribute
///    name. If there are no more attributes to step through, it returns <b>NULL</b>. The session error parameter in the
///    LDAP data structure is set to 0 in either case. If the function fails, it returns <b>NULL</b> and sets the
///    session error parameter in the LDAP data structure to the LDAP error code.
///    
@DllImport("WLDAP32")
PSTR ldap_next_attribute(ldap* ld, LDAPMessage* entry, berelement* ptr);

///The <b>ldap_get_values</b> function retrieves the list of values of a given attribute.
///Params:
///    ld = The session handle.
///    entry = The entry from which to retrieve values.
///    attr = A pointer to a null-terminated string that contains the attribute whose values are to be retrieved.
///Returns:
///    If the function succeeds, it returns a null-terminated list of pointers to values. If no attribute values were
///    found, it usually returns <b>NULL</b>. But in some cases it may return a list one pointer that is <b>NULL</b>.
///    Always make sure to use ldap_count_values to get the count of values in the returned list, as noted in Remarks.
///    The session error parameter in the LDAP data structure is set to 0 in either case. If the function fails, it
///    returns <b>NULL</b> and the session error parameter in the LDAP data structure is set to the LDAP error code.
///    
@DllImport("WLDAP32")
PWSTR* ldap_get_valuesW(ldap* ld, LDAPMessage* entry, const(PWSTR) attr);

///The <b>ldap_get_values</b> function retrieves the list of values of a given attribute.
///Params:
///    ld = The session handle.
///    entry = The entry from which to retrieve values.
///    attr = A pointer to a null-terminated string that contains the attribute whose values are to be retrieved.
///Returns:
///    If the function succeeds, it returns a null-terminated list of pointers to values. If no attribute values were
///    found, it usually returns <b>NULL</b>. But in some cases it may return a list one pointer that is <b>NULL</b>.
///    Always make sure to use ldap_count_values to get the count of values in the returned list, as noted in Remarks.
///    The session error parameter in the LDAP data structure is set to 0 in either case. If the function fails, it
///    returns <b>NULL</b> and the session error parameter in the LDAP data structure is set to the LDAP error code.
///    
@DllImport("WLDAP32")
PSTR* ldap_get_valuesA(ldap* ld, LDAPMessage* entry, const(PSTR) attr);

///The <b>ldap_get_values</b> function retrieves the list of values of a given attribute.
///Params:
///    ld = The session handle.
///    entry = The entry from which to retrieve values.
///    attr = A pointer to a null-terminated string that contains the attribute whose values are to be retrieved.
///Returns:
///    If the function succeeds, it returns a null-terminated list of pointers to values. If no attribute values were
///    found, it usually returns <b>NULL</b>. But in some cases it may return a list one pointer that is <b>NULL</b>.
///    Always make sure to use ldap_count_values to get the count of values in the returned list, as noted in Remarks.
///    The session error parameter in the LDAP data structure is set to 0 in either case. If the function fails, it
///    returns <b>NULL</b> and the session error parameter in the LDAP data structure is set to the LDAP error code.
///    
@DllImport("WLDAP32")
PSTR* ldap_get_values(ldap* ld, LDAPMessage* entry, const(PSTR) attr);

///The <b>ldap_get_values_len</b> function retrieves the list of values for a given attribute.
///Params:
///    ExternalHandle = The session handle.
///    Message = Handle to the LDAPMessage structure.
///    attr = A pointer to a null-terminated string that contains the attribute whose values are to be retrieved.
///Returns:
///    If the function succeeds, it returns a null-terminated list of pointers to berval structures that contain the
///    values of the specified attribute. If no attribute values were found, it returns <b>NULL</b>. The session error
///    parameter in the LDAP data structure is set to 0 in either case. If the function fails, it returns <b>NULL</b>
///    and the session error parameter in the LDAP data structure is set to the LDAP error code.
///    
@DllImport("WLDAP32")
LDAP_BERVAL** ldap_get_values_lenW(ldap* ExternalHandle, LDAPMessage* Message, const(PWSTR) attr);

///The <b>ldap_get_values_len</b> function retrieves the list of values for a given attribute.
///Params:
///    ExternalHandle = The session handle.
///    Message = Handle to the LDAPMessage structure.
///    attr = A pointer to a null-terminated string that contains the attribute whose values are to be retrieved.
///Returns:
///    If the function succeeds, it returns a null-terminated list of pointers to berval structures that contain the
///    values of the specified attribute. If no attribute values were found, it returns <b>NULL</b>. The session error
///    parameter in the LDAP data structure is set to 0 in either case. If the function fails, it returns <b>NULL</b>
///    and the session error parameter in the LDAP data structure is set to the LDAP error code.
///    
@DllImport("WLDAP32")
LDAP_BERVAL** ldap_get_values_lenA(ldap* ExternalHandle, LDAPMessage* Message, const(PSTR) attr);

///The <b>ldap_get_values_len</b> function retrieves the list of values for a given attribute.
///Params:
///    ExternalHandle = The session handle.
///    Message = Handle to the LDAPMessage structure.
///    attr = A pointer to a null-terminated string that contains the attribute whose values are to be retrieved.
///Returns:
///    If the function succeeds, it returns a null-terminated list of pointers to berval structures that contain the
///    values of the specified attribute. If no attribute values were found, it returns <b>NULL</b>. The session error
///    parameter in the LDAP data structure is set to 0 in either case. If the function fails, it returns <b>NULL</b>
///    and the session error parameter in the LDAP data structure is set to the LDAP error code.
///    
@DllImport("WLDAP32")
LDAP_BERVAL** ldap_get_values_len(ldap* ExternalHandle, LDAPMessage* Message, const(PSTR) attr);

///The <b>ldap_count_values</b> function counts the number of values in a list.
///Params:
///    vals = An array of null-terminated strings (values) returned by ldap_get_values.
///Returns:
///    This function returns the number of values in the array. There is no error return. If a <b>NULL</b> pointer is
///    passed as the argument, 0 is returned. If an invalid argument is passed, the value returned is undefined.
///    
@DllImport("WLDAP32")
uint ldap_count_valuesW(PWSTR* vals);

///The <b>ldap_count_values</b> function counts the number of values in a list.
///Params:
///    vals = An array of null-terminated strings (values) returned by ldap_get_values.
///Returns:
///    This function returns the number of values in the array. There is no error return. If a <b>NULL</b> pointer is
///    passed as the argument, 0 is returned. If an invalid argument is passed, the value returned is undefined.
///    
@DllImport("WLDAP32")
uint ldap_count_valuesA(PSTR* vals);

///The <b>ldap_count_values</b> function counts the number of values in a list.
///Params:
///    vals = An array of null-terminated strings (values) returned by ldap_get_values.
///Returns:
///    This function returns the number of values in the array. There is no error return. If a <b>NULL</b> pointer is
///    passed as the argument, 0 is returned. If an invalid argument is passed, the value returned is undefined.
///    
@DllImport("WLDAP32")
uint ldap_count_values(PSTR* vals);

///The <b>ldap_count_values_len</b> function counts the number of values in a list.
///Params:
///    vals = An array of values returned by ldap_get_values_len.
///Returns:
///    This function returns the number of values in the array. There is no error return. If a <b>NULL</b> pointer is
///    passed as the argument, 0 is returned. If an invalid argument is passed, the value returned is undefined.
///    
@DllImport("WLDAP32")
uint ldap_count_values_len(LDAP_BERVAL** vals);

///The <b>ldap_value_free</b> function frees a structure returned by ldap_get_values.
///Params:
///    vals = The structure to free.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_value_freeW(PWSTR* vals);

///The <b>ldap_value_free</b> function frees a structure returned by ldap_get_values.
///Params:
///    vals = The structure to free.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_value_freeA(PSTR* vals);

///The <b>ldap_value_free</b> function frees a structure returned by ldap_get_values.
///Params:
///    vals = The structure to free.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_value_free(PSTR* vals);

///The <b>ldap_value_free_len</b> frees berval structures that were returned by ldap_get_values_len.
///Params:
///    vals = The structure to free.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_value_free_len(LDAP_BERVAL** vals);

///The <b>ldap_get_dn</b> function retrieves the distinguished name for a given entry.
///Params:
///    ld = The session handle.
///    entry = The entry whose distinguished name is to be retrieved.
///Returns:
///    If the function succeeds, it returns the distinguished name as a pointer to a null-terminated character string.
///    If the function fails, it returns <b>NULL</b> and sets the session error parameters in the LDAP data structure.
///    
@DllImport("WLDAP32")
PWSTR ldap_get_dnW(ldap* ld, LDAPMessage* entry);

///The <b>ldap_get_dn</b> function retrieves the distinguished name for a given entry.
///Params:
///    ld = The session handle.
///    entry = The entry whose distinguished name is to be retrieved.
///Returns:
///    If the function succeeds, it returns the distinguished name as a pointer to a null-terminated character string.
///    If the function fails, it returns <b>NULL</b> and sets the session error parameters in the LDAP data structure.
///    
@DllImport("WLDAP32")
PSTR ldap_get_dnA(ldap* ld, LDAPMessage* entry);

///The <b>ldap_get_dn</b> function retrieves the distinguished name for a given entry.
///Params:
///    ld = The session handle.
///    entry = The entry whose distinguished name is to be retrieved.
///Returns:
///    If the function succeeds, it returns the distinguished name as a pointer to a null-terminated character string.
///    If the function fails, it returns <b>NULL</b> and sets the session error parameters in the LDAP data structure.
///    
@DllImport("WLDAP32")
PSTR ldap_get_dn(ldap* ld, LDAPMessage* entry);

///The <b>ldap_explode_dn</b> function breaks up an entry name into its component parts.
///Params:
///    dn = A pointer to a null-terminated string that contains the distinguished name to explode. The string that this
///         pointer refers to cannot be a constant string.
///    notypes = Indicates whether the type information components should be removed.
///Returns:
///    If the function succeeds, it returns a null-terminated character array containing the relative distinguished name
///    components of the distinguished name supplied.
///    
@DllImport("WLDAP32")
PWSTR* ldap_explode_dnW(const(PWSTR) dn, uint notypes);

///The <b>ldap_explode_dn</b> function breaks up an entry name into its component parts.
///Params:
///    dn = A pointer to a null-terminated string that contains the distinguished name to explode. The string that this
///         pointer refers to cannot be a constant string.
///    notypes = Indicates whether the type information components should be removed.
///Returns:
///    If the function succeeds, it returns a null-terminated character array containing the relative distinguished name
///    components of the distinguished name supplied.
///    
@DllImport("WLDAP32")
PSTR* ldap_explode_dnA(const(PSTR) dn, uint notypes);

///The <b>ldap_explode_dn</b> function breaks up an entry name into its component parts.
///Params:
///    dn = A pointer to a null-terminated string that contains the distinguished name to explode. The string that this
///         pointer refers to cannot be a constant string.
///    notypes = Indicates whether the type information components should be removed.
///Returns:
///    If the function succeeds, it returns a null-terminated character array containing the relative distinguished name
///    components of the distinguished name supplied.
///    
@DllImport("WLDAP32")
PSTR* ldap_explode_dn(const(PSTR) dn, uint notypes);

///The <b>ldap_dn2ufn</b> function converts a distinguished name to a user-friendly format.
///Params:
///    dn = A pointer to a null-terminated string that contains the distinguished name to convert.
///Returns:
///    If the function is successful, the user-friendly name is returned as a pointer to a null-terminated character
///    string. If the function fails, <b>NULL</b> is returned.
///    
@DllImport("WLDAP32")
PWSTR ldap_dn2ufnW(const(PWSTR) dn);

///The <b>ldap_dn2ufn</b> function converts a distinguished name to a user-friendly format.
///Params:
///    dn = A pointer to a null-terminated string that contains the distinguished name to convert.
///Returns:
///    If the function is successful, the user-friendly name is returned as a pointer to a null-terminated character
///    string. If the function fails, <b>NULL</b> is returned.
///    
@DllImport("WLDAP32")
PSTR ldap_dn2ufnA(const(PSTR) dn);

///The <b>ldap_dn2ufn</b> function converts a distinguished name to a user-friendly format.
///Params:
///    dn = A pointer to a null-terminated string that contains the distinguished name to convert.
///Returns:
///    If the function is successful, the user-friendly name is returned as a pointer to a null-terminated character
///    string. If the function fails, <b>NULL</b> is returned.
///    
@DllImport("WLDAP32")
PSTR ldap_dn2ufn(const(PSTR) dn);

///The <b>ldap_memfree</b> function frees memory allocated from the LDAP heap.
///Params:
///    Block = A pointer to a null-terminated string that contains a pointer to memory allocated by the LDAP library.
///Returns:
///    None.
///    
@DllImport("WLDAP32")
void ldap_memfreeW(PWSTR Block);

///The <b>ldap_memfree</b> function frees memory allocated from the LDAP heap.
///Params:
///    Block = A pointer to a null-terminated string that contains a pointer to memory allocated by the LDAP library.
///Returns:
///    None.
///    
@DllImport("WLDAP32")
void ldap_memfreeA(PSTR Block);

///The <b>ber_bvfree</b> function frees a berval structure.
///Params:
///    bv = TBD
///Returns:
///    None.
///    
@DllImport("WLDAP32")
void ber_bvfree(LDAP_BERVAL* bv);

///The <b>ldap_memfree</b> function frees memory allocated from the LDAP heap.
///Params:
///    Block = A pointer to a null-terminated string that contains a pointer to memory allocated by the LDAP library.
///Returns:
///    None.
///    
@DllImport("WLDAP32")
void ldap_memfree(PSTR Block);

///The <b>ldap_ufn2dn</b> function converts a user-friendly name to a distinguished name.
///Params:
///    ufn = Pointer to a null-terminated string that contains the user-friendly name to convert.
///    pDn = Pointer to a variable that receives a pointer to a null-terminated string that contains the resulting
///          distinguished name. If the <i>pDn</i> parameter returns non-<b>NULL</b>, free it with a call to ldap_memfree.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_ufn2dnW(const(PWSTR) ufn, PWSTR* pDn);

///The <b>ldap_ufn2dn</b> function converts a user-friendly name to a distinguished name.
///Params:
///    ufn = Pointer to a null-terminated string that contains the user-friendly name to convert.
///    pDn = Pointer to a variable that receives a pointer to a null-terminated string that contains the resulting
///          distinguished name. If the <i>pDn</i> parameter returns non-<b>NULL</b>, free it with a call to ldap_memfree.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_ufn2dnA(const(PSTR) ufn, PSTR* pDn);

///The <b>ldap_ufn2dn</b> function converts a user-friendly name to a distinguished name.
///Params:
///    ufn = Pointer to a null-terminated string that contains the user-friendly name to convert.
///    pDn = Pointer to a variable that receives a pointer to a null-terminated string that contains the resulting
///          distinguished name. If the <i>pDn</i> parameter returns non-<b>NULL</b>, free it with a call to ldap_memfree.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_ufn2dn(const(PSTR) ufn, PSTR* pDn);

@DllImport("WLDAP32")
uint ldap_startup(ldap_version_info* version_, HANDLE* Instance);

///<div class="alert"><b>Warning</b> <p class="note">The <b>ldap_cleanup</b> function may cause unpredictable behavior
///at DLL unload time so, there is no way to safely clean up resources when dynamically loading and unloading the
///wldap32.dll. <p class="note">Because of this, resource leaks can occur on unload of the library. Use of
///<b>ldap_cleanup</b> is therefore not recommended and, is at your own risk. </div> <div> </div>
///Params:
///    hInstance = This parameter is ignored.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_cleanup(HANDLE hInstance);

///The <b>ldap_escape_filter_element</b> function converts a filter element to a null-terminated character string that
///can be passed safely in a search filter.
///Params:
///    sourceFilterElement = A pointer to a null-terminated string that contains the filter element to convert.
///    sourceLength = The length, in bytes, of the source filter element.
///    destFilterElement = A pointer to a null-terminated character string.
///    destLength = The length, in bytes, of the <i>destFilterElement</i> buffer.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_escape_filter_elementW(PSTR sourceFilterElement, uint sourceLength, PWSTR destFilterElement, 
                                 uint destLength);

///The <b>ldap_escape_filter_element</b> function converts a filter element to a null-terminated character string that
///can be passed safely in a search filter.
///Params:
///    sourceFilterElement = A pointer to a null-terminated string that contains the filter element to convert.
///    sourceLength = The length, in bytes, of the source filter element.
///    destFilterElement = A pointer to a null-terminated character string.
///    destLength = The length, in bytes, of the <i>destFilterElement</i> buffer.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_escape_filter_elementA(PSTR sourceFilterElement, uint sourceLength, PSTR destFilterElement, 
                                 uint destLength);

///The <b>ldap_escape_filter_element</b> function converts a filter element to a null-terminated character string that
///can be passed safely in a search filter.
///Params:
///    sourceFilterElement = A pointer to a null-terminated string that contains the filter element to convert.
///    sourceLength = The length, in bytes, of the source filter element.
///    destFilterElement = A pointer to a null-terminated character string.
///    destLength = The length, in bytes, of the <i>destFilterElement</i> buffer.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_escape_filter_element(PSTR sourceFilterElement, uint sourceLength, PSTR destFilterElement, 
                                uint destLength);

@DllImport("WLDAP32")
uint ldap_set_dbg_flags(uint NewFlags);

@DllImport("WLDAP32")
void ldap_set_dbg_routine(DBGPRINT DebugPrintRoutine);

///The <b>LdapUTF8ToUnicode</b> function is used to translate strings for modules that do not have the UTF-8 code page.
///Params:
///    lpSrcStr = A pointer to a null-terminated UTF-8 string to convert.
///    cchSrc = An integer that specifies the size, in characters, of the <i>lpSrcStr</i> string.
///    lpDestStr = A pointer to a buffer that receives the converted Unicode string, without a null terminator.
///    cchDest = An integer that specifies the size, in characters, of the <i>lpDestStr</i> buffer.
///Returns:
///    The return value is the number of characters written to the <i>lpDestStr</i> buffer. If the <i>lpDestStr</i>
///    buffer is too small, GetLastError returns <b>ERROR_INSUFFICIENT_BUFFER</b>. When the <i>cchDest</i> parameter is
///    zero, the required size of the destination buffer is returned.
///    
@DllImport("WLDAP32")
int LdapUTF8ToUnicode(const(PSTR) lpSrcStr, int cchSrc, PWSTR lpDestStr, int cchDest);

///The <b>LdapUnicodeToUTF8</b> function converts Unicode strings to UTF-8. Modules that do not have the UTF-8 code page
///can call this function.
///Params:
///    lpSrcStr = A pointer to a null-terminated Unicode string to convert.
///    cchSrc = An integer that specifies the size, in characters, of the <i>lpSrcStr</i> string.
///    lpDestStr = A pointer to a buffer that receives the converted UTF-8 character string, without a null terminator.
///    cchDest = An integer that specifies the size, in characters, of the <i>lpDestStr</i> buffer.
///Returns:
///    The return value is the size, in characters, written to the <i>lpDestStr</i> buffer. If the <i>lpDestStr</i>
///    buffer is too small, GetLastError returns <b>ERROR_INSUFFICIENT_BUFFER</b>. When the <i>cchDest</i> parameter is
///    zero, the required size of the destination buffer is returned.
///    
@DllImport("WLDAP32")
int LdapUnicodeToUTF8(const(PWSTR) lpSrcStr, int cchSrc, PSTR lpDestStr, int cchDest);

///The <b>ldap_create_sort_control</b> function is used to format a list of sort keys into a search control. Support for
///controls is available effective with LDAP 3, but whether the sort control is supported or not is dependent on the
///particular server.
///Params:
///    ExternalHandle = The session handle.
///    SortKeys = Pointer to an array of LDAPSortKey structures. Each structure in the array specifies the name of an attribute to
///               use as a sort key, the matching rule for that key, and whether the sort order is ascending or descending.
///    IsCritical = Notifies the server whether this control is critical to the search. 0 ==&gt; FALSE, !0 ==&gt; TRUE.
///    Control = Pointer to the newly created control.
///Returns:
///    This function returns WINLDAPAPI ULONG LDAPAPI.
///    
@DllImport("WLDAP32")
uint ldap_create_sort_controlA(ldap* ExternalHandle, ldapsortkeyA** SortKeys, ubyte IsCritical, 
                               ldapcontrolA** Control);

///The <b>ldap_create_sort_control</b> function is used to format a list of sort keys into a search control. Support for
///controls is available effective with LDAP 3, but whether the sort control is supported or not is dependent on the
///particular server.
///Params:
///    ExternalHandle = The session handle.
///    SortKeys = Pointer to an array of LDAPSortKey structures. Each structure in the array specifies the name of an attribute to
///               use as a sort key, the matching rule for that key, and whether the sort order is ascending or descending.
///    IsCritical = Notifies the server whether this control is critical to the search. 0 ==&gt; FALSE, !0 ==&gt; TRUE.
///    Control = Pointer to the newly created control.
///Returns:
///    This function returns WINLDAPAPI ULONG LDAPAPI.
///    
@DllImport("WLDAP32")
uint ldap_create_sort_controlW(ldap* ExternalHandle, ldapsortkeyW** SortKeys, ubyte IsCritical, 
                               ldapcontrolW** Control);

///The <b>ldap_parse_sort_control</b> function parses the sort control returned by the server.
///Params:
///    ExternalHandle = The session handle.
///    Control = The control returned from the server, as obtained from a call to ldap_parse_result.
///    Result = The result code.
///    Attribute = A pointer to a null-terminated string that contains the name of the attribute that caused the operation to fail.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_parse_sort_controlA(ldap* ExternalHandle, ldapcontrolA** Control, uint* Result, PSTR* Attribute);

///The <b>ldap_parse_sort_control</b> function parses the sort control returned by the server.
///Params:
///    ExternalHandle = The session handle.
///    Control = The control returned from the server, as obtained from a call to ldap_parse_result.
///    Result = The result code.
///    Attribute = A pointer to a null-terminated string that contains the name of the attribute that caused the operation to fail.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_parse_sort_controlW(ldap* ExternalHandle, ldapcontrolW** Control, uint* Result, PWSTR* Attribute);

///The <b>ldap_create_sort_control</b> function is used to format a list of sort keys into a search control. Support for
///controls is available effective with LDAP 3, but whether the sort control is supported or not is dependent on the
///particular server.
///Params:
///    ExternalHandle = The session handle.
///    SortKeys = Pointer to an array of LDAPSortKey structures. Each structure in the array specifies the name of an attribute to
///               use as a sort key, the matching rule for that key, and whether the sort order is ascending or descending.
///    IsCritical = Notifies the server whether this control is critical to the search. 0 ==&gt; FALSE, !0 ==&gt; TRUE.
///    Control = Pointer to the newly created control.
///Returns:
///    This function returns WINLDAPAPI ULONG LDAPAPI.
///    
@DllImport("WLDAP32")
uint ldap_create_sort_control(ldap* ExternalHandle, ldapsortkeyA** SortKeys, ubyte IsCritical, 
                              ldapcontrolA** Control);

///The <b>ldap_parse_sort_control</b> function parses the sort control returned by the server.
///Params:
///    ExternalHandle = The session handle.
///    Control = The control returned from the server, as obtained from a call to ldap_parse_result.
///    Result = The result code.
///    Attribute = A pointer to a null-terminated string that contains the name of the attribute that caused the operation to fail.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_parse_sort_control(ldap* ExternalHandle, ldapcontrolA** Control, uint* Result, PSTR* Attribute);

///The <b>ldap_encode_sort_control</b> function formats a list of sort keys into a search control. This function is
///obsolete. Instead, use ldap_create_sort_control.
///Params:
///    ExternalHandle = The session handle.
///    SortKeys = A list of LDAPSortKey structures.
///    Control = Pointer to the new control.
///    Criticality = Notifies the server whether this control is critical to the search.
///Returns:
///    If the call completed successfully, <b>LDAP_SUCCESS</b> is returned. Other standard LDAP return values, such as
///    <b>LDAP_NO_MEMORY</b> or <b>LDAP_PARAM_ERROR</b>, may also be returned.
///    
@DllImport("WLDAP32")
uint ldap_encode_sort_controlW(ldap* ExternalHandle, ldapsortkeyW** SortKeys, ldapcontrolW* Control, 
                               ubyte Criticality);

///The <b>ldap_encode_sort_control</b> function formats a list of sort keys into a search control. This function is
///obsolete. Instead, use ldap_create_sort_control.
///Params:
///    ExternalHandle = The session handle.
///    SortKeys = A list of LDAPSortKey structures.
///    Control = Pointer to the new control.
///    Criticality = Notifies the server whether this control is critical to the search.
///Returns:
///    If the call completed successfully, <b>LDAP_SUCCESS</b> is returned. Other standard LDAP return values, such as
///    <b>LDAP_NO_MEMORY</b> or <b>LDAP_PARAM_ERROR</b>, may also be returned.
///    
@DllImport("WLDAP32")
uint ldap_encode_sort_controlA(ldap* ExternalHandle, ldapsortkeyA** SortKeys, ldapcontrolA* Control, 
                               ubyte Criticality);

///Use the <b>ldap_create_page_control</b> function to create a basic control for paging results. Support for controls
///is available effective with LDAP 3, but whether the page control is supported or not is dependent on the particular
///server.
///Params:
///    ExternalHandle = The session handle.
///    PageSize = The number of entries to return in each page.
///    Cookie = Pointer to a berval structure that the server uses to determine its location in the result set. This is an opaque
///             structure that you should not access directly. Set to <b>NULL</b> for the first call to
///             <b>ldap_create_page_control</b>.
///    IsCritical = Notifies the server whether this control is critical to the search.
///    Control = Pointer to the newly created control.
///Returns:
///    This function returns WINLDAPAPI ULONG LDAPAPI.
///    
@DllImport("WLDAP32")
uint ldap_create_page_controlW(ldap* ExternalHandle, uint PageSize, LDAP_BERVAL* Cookie, ubyte IsCritical, 
                               ldapcontrolW** Control);

///Use the <b>ldap_create_page_control</b> function to create a basic control for paging results. Support for controls
///is available effective with LDAP 3, but whether the page control is supported or not is dependent on the particular
///server.
///Params:
///    ExternalHandle = The session handle.
///    PageSize = The number of entries to return in each page.
///    Cookie = Pointer to a berval structure that the server uses to determine its location in the result set. This is an opaque
///             structure that you should not access directly. Set to <b>NULL</b> for the first call to
///             <b>ldap_create_page_control</b>.
///    IsCritical = Notifies the server whether this control is critical to the search.
///    Control = Pointer to the newly created control.
///Returns:
///    This function returns WINLDAPAPI ULONG LDAPAPI.
///    
@DllImport("WLDAP32")
uint ldap_create_page_controlA(ldap* ExternalHandle, uint PageSize, LDAP_BERVAL* Cookie, ubyte IsCritical, 
                               ldapcontrolA** Control);

///The <b>ldap_parse_page_control</b> parses the results of a search into pages.
///Params:
///    ExternalHandle = The session handle.
///    ServerControls = An array of controls that includes a page control. The page control contains the cookie and total count fields
///                     returned by the server.
///    TotalCount = A pointer to the total count of entries returned in this page (optional).
///    Cookie = An opaque cookie, used by the server to determine its location in the result set. Use ber_bvfree to free.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_parse_page_controlW(ldap* ExternalHandle, ldapcontrolW** ServerControls, uint* TotalCount, 
                              LDAP_BERVAL** Cookie);

///The <b>ldap_parse_page_control</b> parses the results of a search into pages.
///Params:
///    ExternalHandle = The session handle.
///    ServerControls = An array of controls that includes a page control. The page control contains the cookie and total count fields
///                     returned by the server.
///    TotalCount = A pointer to the total count of entries returned in this page (optional).
///    Cookie = An opaque cookie, used by the server to determine its location in the result set. Use ber_bvfree to free.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_parse_page_controlA(ldap* ExternalHandle, ldapcontrolA** ServerControls, uint* TotalCount, 
                              LDAP_BERVAL** Cookie);

///Use the <b>ldap_create_page_control</b> function to create a basic control for paging results. Support for controls
///is available effective with LDAP 3, but whether the page control is supported or not is dependent on the particular
///server.
///Params:
///    ExternalHandle = The session handle.
///    PageSize = The number of entries to return in each page.
///    Cookie = Pointer to a berval structure that the server uses to determine its location in the result set. This is an opaque
///             structure that you should not access directly. Set to <b>NULL</b> for the first call to
///             <b>ldap_create_page_control</b>.
///    IsCritical = Notifies the server whether this control is critical to the search.
///    Control = Pointer to the newly created control.
///Returns:
///    This function returns WINLDAPAPI ULONG LDAPAPI.
///    
@DllImport("WLDAP32")
uint ldap_create_page_control(ldap* ExternalHandle, uint PageSize, LDAP_BERVAL* Cookie, ubyte IsCritical, 
                              ldapcontrolA** Control);

///The <b>ldap_parse_page_control</b> parses the results of a search into pages.
///Params:
///    ExternalHandle = The session handle.
///    ServerControls = An array of controls that includes a page control. The page control contains the cookie and total count fields
///                     returned by the server.
///    TotalCount = A pointer to the total count of entries returned in this page (optional).
///    Cookie = An opaque cookie, used by the server to determine its location in the result set. Use ber_bvfree to free.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_parse_page_control(ldap* ExternalHandle, ldapcontrolA** ServerControls, uint* TotalCount, 
                             LDAP_BERVAL** Cookie);

///The <b>ldap_search_init_page</b> function initializes a search block for a simple paged-results search. This function
///is supported in LDAP 3.
///Params:
///    ExternalHandle = The session handle.
///    DistinguishedName = A pointer to a null-terminated string that contains the distinguished name of the entry at which to start the
///                        search.
///    ScopeOfSearch = A data type that specifies one of the following values to indicate the scope of the search.
///    SearchFilter = A pointer to a null-terminated string that specifies the search filter. For more information, see Search Filter
///                   Syntax.
///    AttributeList = A null-terminated array of null-terminated strings indicating which attributes to return for each matching entry.
///                    Pass <b>NULL</b> to retrieve all available attributes.
///    AttributesOnly = A Boolean value that should be zero if both attribute types and values are to be returned, nonzero if only types
///                     are to be returned.
///    ServerControls = A list of LDAP server controls.
///    ClientControls = A list of client controls.
///    PageTimeLimit = The time value, in seconds, that the client will wait for the server to return a page.
///    TotalSizeLimit = The maximum number of entries the client will accept. The <i>TotalSizeLimit</i> value affects only the individual
///                     pages within the paged search (not the overall paged search). So if <i>TotalSizeLimit</i> is greater than page
///                     size, then <i>TotalSizeLimit</i> will have no effect.
///    SortKeys = A pointer to an LDAPSortKey structure, which specifies the attribute type, the ordering rule, and the direction
///               for the search.
///Returns:
///    If the function succeeds, it returns a pointer to an LDAPSearch structure. If the function fails, the return
///    value is <b>NULL</b>. Use LdapGetLastError or GetLastError to retrieve the error code. Call the
///    ldap_search_abandon_page to free the returned structure.
///    
@DllImport("WLDAP32")
ldapsearch* ldap_search_init_pageW(ldap* ExternalHandle, const(PWSTR) DistinguishedName, uint ScopeOfSearch, 
                                   const(PWSTR) SearchFilter, ushort** AttributeList, uint AttributesOnly, 
                                   ldapcontrolW** ServerControls, ldapcontrolW** ClientControls, uint PageTimeLimit, 
                                   uint TotalSizeLimit, ldapsortkeyW** SortKeys);

///The <b>ldap_search_init_page</b> function initializes a search block for a simple paged-results search. This function
///is supported in LDAP 3.
///Params:
///    ExternalHandle = The session handle.
///    DistinguishedName = A pointer to a null-terminated string that contains the distinguished name of the entry at which to start the
///                        search.
///    ScopeOfSearch = A data type that specifies one of the following values to indicate the scope of the search.
///    SearchFilter = A pointer to a null-terminated string that specifies the search filter. For more information, see Search Filter
///                   Syntax.
///    AttributeList = A null-terminated array of null-terminated strings indicating which attributes to return for each matching entry.
///                    Pass <b>NULL</b> to retrieve all available attributes.
///    AttributesOnly = A Boolean value that should be zero if both attribute types and values are to be returned, nonzero if only types
///                     are to be returned.
///    ServerControls = A list of LDAP server controls.
///    ClientControls = A list of client controls.
///    PageTimeLimit = The time value, in seconds, that the client will wait for the server to return a page.
///    TotalSizeLimit = The maximum number of entries the client will accept. The <i>TotalSizeLimit</i> value affects only the individual
///                     pages within the paged search (not the overall paged search). So if <i>TotalSizeLimit</i> is greater than page
///                     size, then <i>TotalSizeLimit</i> will have no effect.
///    SortKeys = A pointer to an LDAPSortKey structure, which specifies the attribute type, the ordering rule, and the direction
///               for the search.
///Returns:
///    If the function succeeds, it returns a pointer to an LDAPSearch structure. If the function fails, the return
///    value is <b>NULL</b>. Use LdapGetLastError or GetLastError to retrieve the error code. Call the
///    ldap_search_abandon_page to free the returned structure.
///    
@DllImport("WLDAP32")
ldapsearch* ldap_search_init_pageA(ldap* ExternalHandle, const(PSTR) DistinguishedName, uint ScopeOfSearch, 
                                   const(PSTR) SearchFilter, byte** AttributeList, uint AttributesOnly, 
                                   ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, uint PageTimeLimit, 
                                   uint TotalSizeLimit, ldapsortkeyA** SortKeys);

///The <b>ldap_search_init_page</b> function initializes a search block for a simple paged-results search. This function
///is supported in LDAP 3.
///Params:
///    ExternalHandle = The session handle.
///    DistinguishedName = A pointer to a null-terminated string that contains the distinguished name of the entry at which to start the
///                        search.
///    ScopeOfSearch = A data type that specifies one of the following values to indicate the scope of the search.
///    SearchFilter = A pointer to a null-terminated string that specifies the search filter. For more information, see Search Filter
///                   Syntax.
///    AttributeList = A null-terminated array of null-terminated strings indicating which attributes to return for each matching entry.
///                    Pass <b>NULL</b> to retrieve all available attributes.
///    AttributesOnly = A Boolean value that should be zero if both attribute types and values are to be returned, nonzero if only types
///                     are to be returned.
///    ServerControls = A list of LDAP server controls.
///    ClientControls = A list of client controls.
///    PageTimeLimit = The time value, in seconds, that the client will wait for the server to return a page.
///    TotalSizeLimit = The maximum number of entries the client will accept. The <i>TotalSizeLimit</i> value affects only the individual
///                     pages within the paged search (not the overall paged search). So if <i>TotalSizeLimit</i> is greater than page
///                     size, then <i>TotalSizeLimit</i> will have no effect.
///    SortKeys = A pointer to an LDAPSortKey structure, which specifies the attribute type, the ordering rule, and the direction
///               for the search.
///Returns:
///    If the function succeeds, it returns a pointer to an LDAPSearch structure. If the function fails, the return
///    value is <b>NULL</b>. Use LdapGetLastError or GetLastError to retrieve the error code. Call the
///    ldap_search_abandon_page to free the returned structure.
///    
@DllImport("WLDAP32")
ldapsearch* ldap_search_init_page(ldap* ExternalHandle, const(PSTR) DistinguishedName, uint ScopeOfSearch, 
                                  const(PSTR) SearchFilter, byte** AttributeList, uint AttributesOnly, 
                                  ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, uint PageTimeLimit, 
                                  uint TotalSizeLimit, ldapsortkeyA** SortKeys);

///The <b>ldap_get_next_page</b> function returns the next page in a sequence of asynchronous paged search results.
///Params:
///    ExternalHandle = Session handle.
///    SearchHandle = Search block handle.
///    PageSize = The number of entries to return in a single page.
///    MessageNumber = The message ID for the request.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code return value. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_get_next_page(ldap* ExternalHandle, ldapsearch* SearchHandle, uint PageSize, uint* MessageNumber);

///The <b>ldap_get_next_page_s</b> function returns the next page in a sequence of synchronous paged search results.
///Params:
///    ExternalHandle = Session handle.
///    SearchHandle = Search block handle.
///    timeout = The time value, in seconds, that the client will wait for the call to return.
///    PageSize = The number of entries to return in a single page.
///    TotalCount = The server estimate of the total number of entries in the entire result set. A value of zero indicates that the
///                 server cannot provide an estimate.
///    Results = A pointer to the LDAPMessage structure that contains the results.
///Returns:
///    If the server returns a null cookie (non-continuation), the value is <b>LDAP_NO_RESULTS_RETURNED</b>. Otherwise,
///    the client signals a continuation (more data available) by returning <b>LDAP_SUCCESS</b>. If the function
///    otherwise fails, it returns the error code return value related to the failure. For more information, see Return
///    Values.
///    
@DllImport("WLDAP32")
uint ldap_get_next_page_s(ldap* ExternalHandle, ldapsearch* SearchHandle, LDAP_TIMEVAL* timeout, uint PageSize, 
                          uint* TotalCount, LDAPMessage** Results);

///The <b>ldap_get_paged_count</b> function records the number of paged results that the server has returned for a
///search.
///Params:
///    ExternalHandle = The session handle.
///    SearchBlock = Handle to an LDAPSearch structure.
///    TotalCount = The total pages in the search results.
///    Results = A pointer to the LDAPMessage structure that contains the results of the operation.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_get_paged_count(ldap* ExternalHandle, ldapsearch* SearchBlock, uint* TotalCount, LDAPMessage* Results);

///The <b>ldap_search_abandon_page</b> function terminates a paged-results search.
///Params:
///    ExternalHandle = The session handle.
///    SearchBlock = A handle to the search block for the current search.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_search_abandon_page(ldap* ExternalHandle, ldapsearch* SearchBlock);

///The <b>ldap_create_vlv_control</b> function is used to create the request control (LDAP_CONTROL_VLVREQUEST) on the
///server.
///Params:
///    ExternalHandle = An LDAP session handle, as obtained from a call to ldap_init.
///    VlvInfo = The address of an LDAPVLVInfo structure whose contents are used to construct the value of the control created.
///    IsCritical = If this value is not zero, the control created will have its criticality set to <b>TRUE</b>.
///    Control = A result parameter assigned the address of an LDAPControl structure that contains the request control
///              (LDAP_CONTROL_VLVREQUEST) created by this function.
///Returns:
///    The <b>ldap_create_vlv_control</b> function returns an LDAP error code to indicate failure, or LDAP_SUCCESS if
///    successful.
///    
@DllImport("WLDAP32")
int ldap_create_vlv_controlW(ldap* ExternalHandle, ldapvlvinfo* VlvInfo, ubyte IsCritical, ldapcontrolW** Control);

///The <b>ldap_create_vlv_control</b> function is used to create the request control (LDAP_CONTROL_VLVREQUEST) on the
///server.
///Params:
///    ExternalHandle = An LDAP session handle, as obtained from a call to ldap_init.
///    VlvInfo = The address of an LDAPVLVInfo structure whose contents are used to construct the value of the control created.
///    IsCritical = If this value is not zero, the control created will have its criticality set to <b>TRUE</b>.
///    Control = A result parameter assigned the address of an LDAPControl structure that contains the request control
///              (LDAP_CONTROL_VLVREQUEST) created by this function.
///Returns:
///    The <b>ldap_create_vlv_control</b> function returns an LDAP error code to indicate failure, or LDAP_SUCCESS if
///    successful.
///    
@DllImport("WLDAP32")
int ldap_create_vlv_controlA(ldap* ExternalHandle, ldapvlvinfo* VlvInfo, ubyte IsCritical, ldapcontrolA** Control);

///The <b>ldap_parse_vlv_control</b> function is used to find and parse VLV search results.
///Params:
///    ExternalHandle = The LDAP session handle.
///    Control = The address of a NULL-terminated array of LDAPControl structures, typically obtained by a call to
///              ldap_parse_result.
///    TargetPos = The numeric position of the target entry in the result set list, as provided by the targetPosition element of the
///                BER-encoded response control (LDAP_CONTROL_VLVRESPONSE). If this parameter is <b>NULL</b>, the target position is
///                not returned.
///    ListCount = The server estimate of the number of entries in the list as provided by the contentCount element of the
///                BER-encoded response control (LDAP_CONTROL_VLVRESPONSE). If this parameter is <b>NULL</b>, the size is not
///                returned.
///    Context = The server-generated context identifier. If the server does not return a context identifier, this parameter will
///              be set to <b>NULL</b>. If <b>NULL</b> is passed for contextp, the context identifier is not returned.
///    ErrCode = The VLV result code, as provided by the virtualListViewResult element of the BER-encoded response control
///              (LDAP_CONTROL_VLVRESPONSE). If this parameter is <b>NULL</b>, the result code is not returned.
///Returns:
///    This function returns an LDAP error code that indicates whether a VLV result control was found and parsed
///    successfully. <b>LDAP_SUCCESS</b> is returned if all goes well, <b>LDAP_CONTROL_MISSING</b> is returned if the
///    <i>ctrls</i> array does not include a response control (LDAP_CONTROL_VLVRESPONSE), and another LDAP error code is
///    returned if a parsing error or other issue occurs. VLV uses the following LDAP return value codes:
///    <b>LDAP_OPERATIONS_ERROR</b> <b>LDAP_UNWILLING_TO_PERFORM</b> <b>LDAP_INSUFFICIENT_ACCESS</b> <b>LDAP_BUSY</b>
///    <b>LDAP_TIMELIMIT_EXCEEDED</b> <b>LDAP_ADMINLIMIT_EXCEEDED</b> <b>LDAP_OTHER</b> In addition, the following two
///    codes have been added to support VLV:
///    
@DllImport("WLDAP32")
int ldap_parse_vlv_controlW(ldap* ExternalHandle, ldapcontrolW** Control, uint* TargetPos, uint* ListCount, 
                            LDAP_BERVAL** Context, int* ErrCode);

///The <b>ldap_parse_vlv_control</b> function is used to find and parse VLV search results.
///Params:
///    ExternalHandle = The LDAP session handle.
///    Control = The address of a NULL-terminated array of LDAPControl structures, typically obtained by a call to
///              ldap_parse_result.
///    TargetPos = The numeric position of the target entry in the result set list, as provided by the targetPosition element of the
///                BER-encoded response control (LDAP_CONTROL_VLVRESPONSE). If this parameter is <b>NULL</b>, the target position is
///                not returned.
///    ListCount = The server estimate of the number of entries in the list as provided by the contentCount element of the
///                BER-encoded response control (LDAP_CONTROL_VLVRESPONSE). If this parameter is <b>NULL</b>, the size is not
///                returned.
///    Context = The server-generated context identifier. If the server does not return a context identifier, this parameter will
///              be set to <b>NULL</b>. If <b>NULL</b> is passed for contextp, the context identifier is not returned.
///    ErrCode = The VLV result code, as provided by the virtualListViewResult element of the BER-encoded response control
///              (LDAP_CONTROL_VLVRESPONSE). If this parameter is <b>NULL</b>, the result code is not returned.
///Returns:
///    This function returns an LDAP error code that indicates whether a VLV result control was found and parsed
///    successfully. <b>LDAP_SUCCESS</b> is returned if all goes well, <b>LDAP_CONTROL_MISSING</b> is returned if the
///    <i>ctrls</i> array does not include a response control (LDAP_CONTROL_VLVRESPONSE), and another LDAP error code is
///    returned if a parsing error or other issue occurs. VLV uses the following LDAP return value codes:
///    <b>LDAP_OPERATIONS_ERROR</b> <b>LDAP_UNWILLING_TO_PERFORM</b> <b>LDAP_INSUFFICIENT_ACCESS</b> <b>LDAP_BUSY</b>
///    <b>LDAP_TIMELIMIT_EXCEEDED</b> <b>LDAP_ADMINLIMIT_EXCEEDED</b> <b>LDAP_OTHER</b> In addition, the following two
///    codes have been added to support VLV:
///    
@DllImport("WLDAP32")
int ldap_parse_vlv_controlA(ldap* ExternalHandle, ldapcontrolA** Control, uint* TargetPos, uint* ListCount, 
                            LDAP_BERVAL** Context, int* ErrCode);

///The <b>ldap_start_tls_s</b> function is used in an active LDAP session to begin using TLS encryption.
///Params:
///    ExternalHandle = A pointer to an <b>LDAP</b> structure that represents the current session.
///    ServerReturnValue = Optional. A pointer to a <b>ULONG</b> that may contain a server error code. This parameter should be consulted if
///                        <b>LDAP_OTHER</b> is returned in the return value. Pass in <b>NULL</b> if you do not wish to use it.
///    result = Optional. A pointer to a pointer for an LDAPMessage structure that may contain a server referral message. Pass in
///             <b>NULL</b> if you do not wish to use it.
///    ServerControls = Optional. A NULL-terminated array of pointers to LDAPControl structures that represent server controls. Pass in
///                     <b>NULL</b> if you do not want to specify server controls.
///    ClientControls = Optional. A NULL-terminated array of pointers to LDAPControl structures that represent client controls. Pass in
///                     <b>NULL</b> if you do not want to specify client controls.
///Returns:
///    If the function call succeeds, <b>LDAP_SUCCESS</b> is returned. <b>LDAP_UNWILLING_TO_PERFORM</b> is returned if a
///    TLD/SSL session is already in progress, or if a bind is currently in progress, or if there is an outstanding LDAP
///    request on the connection. If the server rejects the extended operation, <b>LDAP_OTHER</b> is returned and the
///    <i>ServerReturnValue</i> parameter should be checked for the server error code.
///    
@DllImport("WLDAP32")
uint ldap_start_tls_sW(ldap* ExternalHandle, uint* ServerReturnValue, LDAPMessage** result, 
                       ldapcontrolW** ServerControls, ldapcontrolW** ClientControls);

///The <b>ldap_start_tls_s</b> function is used in an active LDAP session to begin using TLS encryption.
///Params:
///    ExternalHandle = A pointer to an <b>LDAP</b> structure that represents the current session.
///    ServerReturnValue = Optional. A pointer to a <b>ULONG</b> that may contain a server error code. This parameter should be consulted if
///                        <b>LDAP_OTHER</b> is returned in the return value. Pass in <b>NULL</b> if you do not wish to use it.
///    result = Optional. A pointer to a pointer for an LDAPMessage structure that may contain a server referral message. Pass in
///             <b>NULL</b> if you do not wish to use it.
///    ServerControls = Optional. A NULL-terminated array of pointers to LDAPControl structures that represent server controls. Pass in
///                     <b>NULL</b> if you do not want to specify server controls.
///    ClientControls = Optional. A NULL-terminated array of pointers to LDAPControl structures that represent client controls. Pass in
///                     <b>NULL</b> if you do not want to specify client controls.
///Returns:
///    If the function call succeeds, <b>LDAP_SUCCESS</b> is returned. <b>LDAP_UNWILLING_TO_PERFORM</b> is returned if a
///    TLD/SSL session is already in progress, or if a bind is currently in progress, or if there is an outstanding LDAP
///    request on the connection. If the server rejects the extended operation, <b>LDAP_OTHER</b> is returned and the
///    <i>ServerReturnValue</i> parameter should be checked for the server error code.
///    
@DllImport("WLDAP32")
uint ldap_start_tls_sA(ldap* ExternalHandle, uint* ServerReturnValue, LDAPMessage** result, 
                       ldapcontrolA** ServerControls, ldapcontrolA** ClientControls);

///The <b>ldap_stop_tls_s</b> function stops the encryption operation started by a call to ldap_start_tls_s.
///Params:
///    ExternalHandle = A pointer to an <b>LDAP</b> structure that represents the current session.
///Returns:
///    Returns <b>TRUE</b> if the function call succeeds. Returns <b>FALSE</b> if a bind is currently in progress on the
///    connection, if the connection is not actively connected to the server, or if TLS (SSL) negotiation is in progress
///    on the connection.
///    
@DllImport("WLDAP32")
ubyte ldap_stop_tls_s(ldap* ExternalHandle);

///The <b>ldap_first_reference</b> function returns the first reference from a message.
///Params:
///    ld = The session handle.
///    res = The search result, as obtained by a call to one of the synchronous search routines or ldap_result.
///Returns:
///    If the search returned valid results, this function returns a pointer to the first result reference. If no entry
///    or reference exists in the result set, it returns <b>NULL</b>. This is the only error return; the session error
///    parameter in the LDAP data structure is cleared to 0 in either case.
///    
@DllImport("WLDAP32")
LDAPMessage* ldap_first_reference(ldap* ld, LDAPMessage* res);

///The <b>ldap_next_reference</b> function retrieves a reference from a search result chain.
///Params:
///    ld = The session handle.
///    entry = The entry returned by a previous call to ldap_first_reference or <b>ldap_next_reference</b>.
///Returns:
///    If the search returned valid results, this function returns a pointer to the next result entry in the results
///    set. If no further entries or references exist in the result set, it returns <b>NULL</b>. This is the only error
///    return; the session error parameter in the LDAP data structure is cleared to 0 in either case.
///    
@DllImport("WLDAP32")
LDAPMessage* ldap_next_reference(ldap* ld, LDAPMessage* entry);

///The <b>ldap_count_references</b> function counts the number of subordinate references that were returned by the
///server in a response to a search request.
///Params:
///    ld = The session handle.
///    res = The search result obtained by a call to one of the synchronous search routines or to ldap_result.
///Returns:
///    If the function succeeds, it returns the number of references. If the function fails, it returns –1 and sets
///    the session error parameters in the LDAP data structure.
///    
@DllImport("WLDAP32")
uint ldap_count_references(ldap* ld, LDAPMessage* res);

///The <b>ldap_parse_reference</b> function returns a list of subordinate referrals in a search response message.
///Params:
///    Connection = The session handle.
///    ResultMessage = A pointer to an LDAPMessage structure containing the search response.
///    Referrals = A pointer to the list of subordinate referrals. Free with ldap_value_free.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_parse_referenceW(ldap* Connection, LDAPMessage* ResultMessage, PWSTR** Referrals);

///The <b>ldap_parse_reference</b> function returns a list of subordinate referrals in a search response message.
///Params:
///    Connection = The session handle.
///    ResultMessage = A pointer to an LDAPMessage structure containing the search response.
///    Referrals = A pointer to the list of subordinate referrals. Free with ldap_value_free.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_parse_referenceA(ldap* Connection, LDAPMessage* ResultMessage, PSTR** Referrals);

///The <b>ldap_parse_reference</b> function returns a list of subordinate referrals in a search response message.
///Params:
///    Connection = The session handle.
///    ResultMessage = A pointer to an LDAPMessage structure containing the search response.
///    Referrals = A pointer to the list of subordinate referrals. Free with ldap_value_free.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. See Return Values for more information.
///    
@DllImport("WLDAP32")
uint ldap_parse_reference(ldap* Connection, LDAPMessage* ResultMessage, PSTR** Referrals);

///The <b>ldap_extended_operation</b> function enables you to pass extended LDAP operations to the server.
///Params:
///    ld = The session handle.
///    Oid = A pointer to a null-terminated string that contains the dotted object identifier text string that names the
///          request.
///    Data = The arbitrary data required by the operation. If <b>NULL</b>, no data is sent to the server.
///    ServerControls = Optional. A list of LDAP server controls. Set this parameter to <b>NULL</b>, if not used.
///    ClientControls = Optional. A list of client controls. Set this parameter to <b>NULL</b>, if not used.
///    MessageNumber = The message ID for the request.
///Returns:
///    If the function succeeds, <b>LDAP_SUCCESS</b> is returned. If the function fails, an error code is returned. For
///    more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_extended_operationW(ldap* ld, const(PWSTR) Oid, LDAP_BERVAL* Data, ldapcontrolW** ServerControls, 
                              ldapcontrolW** ClientControls, uint* MessageNumber);

///The <b>ldap_extended_operation</b> function enables you to pass extended LDAP operations to the server.
///Params:
///    ld = The session handle.
///    Oid = A pointer to a null-terminated string that contains the dotted object identifier text string that names the
///          request.
///    Data = The arbitrary data required by the operation. If <b>NULL</b>, no data is sent to the server.
///    ServerControls = Optional. A list of LDAP server controls. Set this parameter to <b>NULL</b>, if not used.
///    ClientControls = Optional. A list of client controls. Set this parameter to <b>NULL</b>, if not used.
///    MessageNumber = The message ID for the request.
///Returns:
///    If the function succeeds, <b>LDAP_SUCCESS</b> is returned. If the function fails, an error code is returned. For
///    more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_extended_operationA(ldap* ld, const(PSTR) Oid, LDAP_BERVAL* Data, ldapcontrolA** ServerControls, 
                              ldapcontrolA** ClientControls, uint* MessageNumber);

///The <b>ldap_extended_operation_s</b> function is used to pass extended LDAP operations to the server.
///Params:
///    ExternalHandle = The session handle.
///    Oid = A pointer to a null-terminated string that contains the dotted object identifier (OID) text string that names the
///          request.
///    Data = The arbitrary data required by the operation. If <b>NULL</b>, no data is sent to the server.
///    ServerControls = Optional. A list of LDAP server controls. Set this parameter to <b>NULL</b> if not used.
///    ClientControls = Optional. A list of client controls. Set this parameter to <b>NULL</b> if not used.
///    ReturnedOid = Optional. A pointer to a null-terminated string that contains the dotted OID text string of the server response
///                  message. This is normally the same OID as that which names the request passed to the server in the <i>Oid</i>
///                  parameter. Set to <b>NULL</b> if not used.
///    ReturnedData = Optional. The arbitrary data returned by the extended operation. If <b>NULL</b>, no data is returned by the
///                   server. Set this parameter to <b>NULL</b> if not used.
///Returns:
///    If the function succeeds, <b>LDAP_SUCCESS</b> is returned. If the function fails, an error code is returned. For
///    more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_extended_operation_sA(ldap* ExternalHandle, PSTR Oid, LDAP_BERVAL* Data, ldapcontrolA** ServerControls, 
                                ldapcontrolA** ClientControls, PSTR* ReturnedOid, LDAP_BERVAL** ReturnedData);

///The <b>ldap_extended_operation_s</b> function is used to pass extended LDAP operations to the server.
///Params:
///    ExternalHandle = The session handle.
///    Oid = A pointer to a null-terminated string that contains the dotted object identifier (OID) text string that names the
///          request.
///    Data = The arbitrary data required by the operation. If <b>NULL</b>, no data is sent to the server.
///    ServerControls = Optional. A list of LDAP server controls. Set this parameter to <b>NULL</b> if not used.
///    ClientControls = Optional. A list of client controls. Set this parameter to <b>NULL</b> if not used.
///    ReturnedOid = Optional. A pointer to a null-terminated string that contains the dotted OID text string of the server response
///                  message. This is normally the same OID as that which names the request passed to the server in the <i>Oid</i>
///                  parameter. Set to <b>NULL</b> if not used.
///    ReturnedData = Optional. The arbitrary data returned by the extended operation. If <b>NULL</b>, no data is returned by the
///                   server. Set this parameter to <b>NULL</b> if not used.
///Returns:
///    If the function succeeds, <b>LDAP_SUCCESS</b> is returned. If the function fails, an error code is returned. For
///    more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_extended_operation_sW(ldap* ExternalHandle, PWSTR Oid, LDAP_BERVAL* Data, ldapcontrolW** ServerControls, 
                                ldapcontrolW** ClientControls, PWSTR* ReturnedOid, LDAP_BERVAL** ReturnedData);

///The <b>ldap_extended_operation</b> function enables you to pass extended LDAP operations to the server.
///Params:
///    ld = The session handle.
///    Oid = A pointer to a null-terminated string that contains the dotted object identifier text string that names the
///          request.
///    Data = The arbitrary data required by the operation. If <b>NULL</b>, no data is sent to the server.
///    ServerControls = Optional. A list of LDAP server controls. Set this parameter to <b>NULL</b>, if not used.
///    ClientControls = Optional. A list of client controls. Set this parameter to <b>NULL</b>, if not used.
///    MessageNumber = The message ID for the request.
///Returns:
///    If the function succeeds, <b>LDAP_SUCCESS</b> is returned. If the function fails, an error code is returned. For
///    more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_extended_operation(ldap* ld, const(PSTR) Oid, LDAP_BERVAL* Data, ldapcontrolA** ServerControls, 
                             ldapcontrolA** ClientControls, uint* MessageNumber);

///The <b>ldap_close_extended_op</b> function ends a request that was made by calling ldap_extended_operation.
///Params:
///    ld = The session handle.
///    MessageNumber = The message ID for the request.
///Returns:
///    If the function succeeds, the return value is <b>LDAP_SUCCESS</b>. If the function fails, it returns an error
///    code. For more information, see Return Values.
///    
@DllImport("WLDAP32")
uint ldap_close_extended_op(ldap* ld, uint MessageNumber);

///The <b>LdapGetLastError</b> function retrieves the last error code returned by an LDAP call.
///Returns:
///    An LDAP error code.
///    
@DllImport("WLDAP32")
uint LdapGetLastError();

///The <b>LdapMapErrorToWin32</b> function translates an LdapError value to the closest Win32 error code.
///Params:
///    LdapError = The error code returned from an LDAP function.
///Returns:
///    Returns the corresponding Win32 error code.
///    
@DllImport("WLDAP32")
uint LdapMapErrorToWin32(uint LdapError);

///The <b>ldap_conn_from_msg</b> function returns the LDAP session handle (connection pointer) for a particular message.
///Params:
///    PrimaryConn = A pointer to the LDAP session handle of the message, if known. If the <b>LDAP</b> session handle for the message
///                  is unknown, then <b>NULL</b> may be passed for this parameter provided that the LDAP_OPT_REF_DEREF_CONN_PER_MSG
///                  session option had been previously set for the message session.
///    res = The <b>LDAP</b> message queried. If <b>NULL</b> is passed for this parameter, then the function will respond with
///          a <b>NULL</b> return value.
///Returns:
///    The return value is the LDAP session handle (connection pointer) where the message originated from. This function
///    returns <b>NULL</b> if the originating session has closed or if a <b>NULL</b> <b>LDAPMessage</b> pointer is
///    passed to the function and the LDAP_OPT_REF_DEREF_CONN_PER_MSG session option was not previously set for the
///    message session.
///    
@DllImport("WLDAP32")
ldap* ldap_conn_from_msg(ldap* PrimaryConn, LDAPMessage* res);

///The <b>ber_init</b> function allocates a new BerElement structure containing the data taken from the supplied berval
///structure.
///Params:
///    pBerVal = Pointer to the source berval structure.
///Returns:
///    If the function succeeds, the return value is a pointer to the newly allocated BerElement structure. If the
///    function fails, it returns a <b>NULL</b> pointer.
///    
@DllImport("WLDAP32")
berelement* ber_init(LDAP_BERVAL* pBerVal);

///The <b>ber_free</b> function frees a BerElement structure that was previously allocated with ber_alloc_t, ber_init,
///or the ldap_first_attribute/ ldap_next_attribute search functions.
///Params:
///    pBerElement = Pointer to the BerElement structure to be deallocated.
///    fbuf = Must be set to 0 if freeing structures allocated by ldap_first_attribute/ ldap_next_attribute, otherwise it must
///           be set to 1.
///Returns:
///    None.
///    
@DllImport("WLDAP32")
void ber_free(berelement* pBerElement, int fbuf);

///The <b>ber_bvecfree</b> function frees an array of berval structures.
///Params:
///    pBerVal = Pointer to a NULL-terminated array of berval structures to be deallocated.
///Returns:
///    None.
///    
@DllImport("WLDAP32")
void ber_bvecfree(LDAP_BERVAL** pBerVal);

///The <b>ber_bvdup</b> function creates a copy of the supplied berval structure.
///Params:
///    pBerVal = Pointer to the source berval structure.
///Returns:
///    If the function succeeds, the return value is a pointer to the newly allocated berval structure. If the function
///    fails, it returns a <b>NULL</b> pointer.
///    
@DllImport("WLDAP32")
LDAP_BERVAL* ber_bvdup(LDAP_BERVAL* pBerVal);

///The <b>ber_alloc_t</b> function allocates and constructs a new BerElement structure.
///Params:
///    options = A bitwise OR of the options used to generate the encoding or decoding of the <b>BerElement</b>. The
///              <b>LBER_USE_DER</b> flag (0x01) should always be specified, which causes the element lengths to be encoded in the
///              minimum number of octets. Unrecognized option bits are ignored.
///Returns:
///    If the function succeeds, the return value is a pointer to the newly allocated BerElement structure. If the
///    function fails, it returns a <b>NULL</b> pointer.
///    
@DllImport("WLDAP32")
berelement* ber_alloc_t(int options);

///The <b>ber_skip_tag</b> function skips the current tag and returns the tag of the next element in the supplied
///BerElement structure.
///Params:
///    pBerElement = Pointer to the source BerElement structure.
///    pLen = Returns the length of the skipped element.
///Returns:
///    Returns the tag of the next element in the BerElement structure. LBER_DEFAULT is returned if there is no further
///    data to read.
///    
@DllImport("WLDAP32")
uint ber_skip_tag(berelement* pBerElement, uint* pLen);

///The <b>ber_peek_tag</b> function returns the tag of the next element to be parsed in the supplied BerElement
///structure.
///Params:
///    pBerElement = Pointer to the source BerElement structure.
///    pLen = Returns the length of the next element to be parsed.
///Returns:
///    Returns the tag of the next element to be read in the BerElement structure. LBER_DEFAULT is returned if there is
///    no further data to be read.
///    
@DllImport("WLDAP32")
uint ber_peek_tag(berelement* pBerElement, uint* pLen);

///The <b>ber_first_element</b> function is used to begin the traversal of a SET, SET OF, SEQUENCE or SEQUENCE OF data
///value stored in the supplied BerElement structure. It returns the tag and length of the first element.
///Params:
///    pBerElement = Pointer to the source BerElement structure.
///    pLen = Returns the length of the next element to be parsed.
///    ppOpaque = Returns a pointer to a cookie that is passed to subsequent calls of the ber_next_element function.
///Returns:
///    Returns the tag of the next element to be read in the BerElement structure. LBER_DEFAULT is returned if there is
///    no further data to be read.
///    
@DllImport("WLDAP32")
uint ber_first_element(berelement* pBerElement, uint* pLen, byte** ppOpaque);

///The <b>ber_next_element</b> function is used along with ber_first_element to traverse a SET, SET OF, SEQUENCE or
///SEQUENCE OF data value stored in the supplied BerElement structure. It returns the tag and length of the next element
///in the constructed type.
///Params:
///    pBerElement = Pointer to the source BerElement structure.
///    pLen = Returns the length of the next element to be parsed.
///    opaque = An opaque cookie used internally that was returned by the initial call to the ber_first_element function.
///Returns:
///    Returns the tag of the next element to be read in the BerElement structure. LBER_DEFAULT is returned if there is
///    no further data to be read.
///    
@DllImport("WLDAP32")
uint ber_next_element(berelement* pBerElement, uint* pLen, byte* opaque);

///The <b>ber_flatten</b> function allocates a new berval structure containing the data taken from the supplied
///BerElement structure.
///Params:
///    pBerElement = Pointer to the source BerElement structure.
///    pBerVal = Pointer to the newly allocated berval structure, which should be freed using ber_bvfree.
///Returns:
///    The function returns 0 on success and -1 on failure.
///    
@DllImport("WLDAP32")
int ber_flatten(berelement* pBerElement, LDAP_BERVAL** pBerVal);

///The <b>ber_printf</b> function is used to encode a BER element and is similar to sprintf_s. One important difference
///is that state data is stored in the <b>BerElement</b> argument so that multiple calls can be made to
///<b>ber_printf</b> to append to the end of the BER element. The <b>BerElement</b> argument passed to this function
///must be a pointer to a <b>BerElement</b> returned by ber_alloc_t.
///Params:
///    pBerElement = A pointer to the encoded BerElement structure.
///    fmt = An encoding format string. For more information, see Remarks.
///    arg3 = The values to be encoded as specified by the <i>fmt</i> argument.
///Returns:
///    If the function succeeds, a non-negative number is returned. If the function fails, -1 is returned.
///    
@DllImport("WLDAP32")
int ber_printf(berelement* pBerElement, PSTR fmt);

///The <b>ber_scanf</b> function decodes a BER element in a similar manner as sscanf_s. One important difference is that
///some state status data is kept with the <b>BerElement</b> argument so that multiple calls can be made to
///<b>ber_scanf</b> to sequentially read from the BER element. The <b>BerElement</b> argument should be a pointer to a
///<b>BerElement</b> returned by ber_init.
///Params:
///    pBerElement = Pointer to the decoded BerElement structure.
///    fmt = Encoding format string. For more information, see Remarks section.
///    arg3 = Pointers to variables used to hold the values decoded as specified by the <i>fmt</i> argument.
///Returns:
///    On error, the function returns LBER_ERROR.
///    
@DllImport("WLDAP32")
uint ber_scanf(berelement* pBerElement, PSTR fmt);


