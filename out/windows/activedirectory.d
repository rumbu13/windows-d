// Written in the D programming language.

module windows.activedirectory;

public import windows.core;
public import windows.automation : BSTR, DISPPARAMS, EXCEPINFO, IDispatch,
                                   IEnumVARIANT, IPropertyBag, ITypeInfo,
                                   VARIANT;
public import windows.com : HRESULT, IDataObject, IPersist, IUnknown;
public import windows.controls : LPFNADDPROPSHEETPAGE;
public import windows.gdi : HICON;
public import windows.security : LSA_FOREST_TRUST_INFORMATION;
public import windows.systemservices : BOOL, HANDLE, HINSTANCE, LARGE_INTEGER, PSTR,
                                       PWSTR;
public import windows.winsock : SOCKET_ADDRESS;
public import windows.windowsandmessaging : DLGPROC, HWND, LPARAM, WPARAM;
public import windows.windowsprogramming : FILETIME, HKEY, SYSTEMTIME;

extern(Windows) @nogc nothrow:


// Enums


///The <b>ADSTYPEENUM</b> enumeration is used to identify the data type of an ADSI property value.
alias ADSTYPEENUM = int;
enum : int
{
    ///The data type is not valid
    ADSTYPE_INVALID                = 0x00000000,
    ///The string is of Distinguished Name (path) of a directory service object.
    ADSTYPE_DN_STRING              = 0x00000001,
    ///The string is of the case-sensitive type.
    ADSTYPE_CASE_EXACT_STRING      = 0x00000002,
    ///The string is of the case-insensitive type.
    ADSTYPE_CASE_IGNORE_STRING     = 0x00000003,
    ///The string is displayable on screen or in print.
    ADSTYPE_PRINTABLE_STRING       = 0x00000004,
    ///The string is of a numeral to be interpreted as text.
    ADSTYPE_NUMERIC_STRING         = 0x00000005,
    ///The data is of a Boolean value.
    ADSTYPE_BOOLEAN                = 0x00000006,
    ///The data is of an integer value.
    ADSTYPE_INTEGER                = 0x00000007,
    ///The string is of a byte array.
    ADSTYPE_OCTET_STRING           = 0x00000008,
    ///The data is of the universal time as expressed in Universal Time Coordinate (UTC).
    ADSTYPE_UTC_TIME               = 0x00000009,
    ///The data is of a long integer value.
    ADSTYPE_LARGE_INTEGER          = 0x0000000a,
    ///The string is of a provider-specific string.
    ADSTYPE_PROV_SPECIFIC          = 0x0000000b,
    ///Not used.
    ADSTYPE_OBJECT_CLASS           = 0x0000000c,
    ///The data is of a list of case insensitive strings.
    ADSTYPE_CASEIGNORE_LIST        = 0x0000000d,
    ///The data is of a list of octet strings.
    ADSTYPE_OCTET_LIST             = 0x0000000e,
    ///The string is of a directory path.
    ADSTYPE_PATH                   = 0x0000000f,
    ///The string is of the postal address type.
    ADSTYPE_POSTALADDRESS          = 0x00000010,
    ///The data is of a time stamp in seconds.
    ADSTYPE_TIMESTAMP              = 0x00000011,
    ///The string is of a back link.
    ADSTYPE_BACKLINK               = 0x00000012,
    ///The string is of a typed name.
    ADSTYPE_TYPEDNAME              = 0x00000013,
    ///The data is of the Hold data structure.
    ADSTYPE_HOLD                   = 0x00000014,
    ///The string is of a net address.
    ADSTYPE_NETADDRESS             = 0x00000015,
    ///The data is of a replica pointer.
    ADSTYPE_REPLICAPOINTER         = 0x00000016,
    ///The string is of a fax number.
    ADSTYPE_FAXNUMBER              = 0x00000017,
    ///The data is of an email message.
    ADSTYPE_EMAIL                  = 0x00000018,
    ///The data is a Windows security descriptor as represented by a byte array.
    ADSTYPE_NT_SECURITY_DESCRIPTOR = 0x00000019,
    ///The data is of an undefined type.
    ADSTYPE_UNKNOWN                = 0x0000001a,
    ///The data is of ADS_DN_WITH_BINARY used for mapping a distinguished name to a nonvarying GUID. For more
    ///information, see Remarks.
    ADSTYPE_DN_WITH_BINARY         = 0x0000001b,
    ///The data is of ADS_DN_WITH_STRING used for mapping a distinguished name to a nonvarying string value. For more
    ///information, see Remarks.
    ADSTYPE_DN_WITH_STRING         = 0x0000001c,
}

///The <b>ADS_AUTHENTICATION_ENUM</b> enumeration specifies authentication options used in ADSI for binding to directory
///service objects. When calling IADsOpenDSObject or ADsOpenObject to bind to an ADSI object, provide at least one of
///the options. In general, different providers will have different implementations. The options documented here apply
///to the providers supplied by Microsoft included with the ADSI SDK. For more information, see ADSI System Providers.
alias ADS_AUTHENTICATION_ENUM = int;
enum : int
{
    ///Requests secure authentication. When this flag is set, the WinNT provider uses NT LAN Manager (NTLM) to
    ///authenticate the client. Active Directory will use Kerberos, and possibly NTLM, to authenticate the client. When
    ///the user name and password are <b>NULL</b>, ADSI binds to the object using the security context of the calling
    ///thread, which is either the security context of the user account under which the application is running or of the
    ///client user account that the calling thread represents.
    ADS_SECURE_AUTHENTICATION = 0x00000001,
    ///Requires ADSI to use encryption for data exchange over the network. <div class="alert"><b>Note</b> This option is
    ///not supported by the WinNT provider.</div> <div> </div>
    ADS_USE_ENCRYPTION        = 0x00000002,
    ///The channel is encrypted using Secure Sockets Layer (SSL). Active Directory requires that the Certificate Server
    ///be installed to support SSL. If this flag is not combined with the <b>ADS_SECURE_AUTHENTICATION</b> flag and the
    ///supplied credentials are <b>NULL</b>, the bind will be performed anonymously. If this flag is combined with the
    ///<b>ADS_SECURE_AUTHENTICATION</b> flag and the supplied credentials are <b>NULL</b>, then the credentials of the
    ///calling thread are used. <div class="alert"><b>Note</b> This option is not supported by the WinNT provider.</div>
    ///<div> </div>
    ADS_USE_SSL               = 0x00000002,
    ///A writable domain controller is not required. If your application only reads or queries data from Active
    ///Directory, you should use this flag to open the sessions. This allows the application to take advantage of
    ///Read-Only DCs (RODCs). In Windows Server 2008, ADSI attempts to connect to either Read-Only DCs (RODCs) or
    ///writable DCs. This allows the use of an RODC for the access and enables the application to run in a branch or
    ///perimeter network (also known as DMZ, demilitarized zone, and screened subnet), without the need for direct
    ///connectivity with a writable DC. For more information about programming for RODC compatibility, see the Read-Only
    ///Domain Controllers Application Compatibility Guide.
    ADS_READONLY_SERVER       = 0x00000004,
    ///This flag is not supported.
    ADS_PROMPT_CREDENTIALS    = 0x00000008,
    ///Request no authentication. The providers may attempt to bind the client, as an anonymous user, to the target
    ///object. The WinNT provider does not support this flag. Active Directory establishes a connection between the
    ///client and the targeted object, but will not perform authentication. Setting this flag amounts to requesting an
    ///anonymous binding, which indicates all users as the security context.
    ADS_NO_AUTHENTICATION     = 0x00000010,
    ///When this flag is set, ADSI will not attempt to query the <b>objectClass</b> property and thus will only expose
    ///the base interfaces supported by all ADSI objects instead of the full object support. A user can use this option
    ///to increase the performance in a series of object manipulations that involve only methods of the base interfaces.
    ///However, ADSI will not verify that any of the requested objects actually exist on the server. For more
    ///information, see Fast Binding Options for Batch Write/Modify Operations. This option is also useful for binding
    ///to non-Active Directory directory services, for example Exchange 5.5, where the <b>objectClass</b> query would
    ///fail.
    ADS_FAST_BIND             = 0x00000020,
    ///Verifies data integrity. The <b>ADS_SECURE_AUTHENTICATION</b> flag must also be set also to use signing. <div
    ///class="alert"><b>Note</b> This option is not supported by the WinNT provider.</div> <div> </div>
    ADS_USE_SIGNING           = 0x00000040,
    ///Encrypts data using Kerberos. The <b>ADS_SECURE_AUTHENTICATION</b> flag must also be set to use sealing. <div
    ///class="alert"><b>Note</b> This option is not supported by the WinNT provider.</div> <div> </div>
    ADS_USE_SEALING           = 0x00000080,
    ///Enables ADSI to delegate the user security context, which is necessary for moving objects across domains.
    ADS_USE_DELEGATION        = 0x00000100,
    ///If an Active Directory DNS server name is passed in the LDAP path, this forces an A-record lookup and bypasses
    ///any SRV record lookup when resolving the host name. <div class="alert"><b>Note</b> This option is not supported
    ///by the WinNT provider.</div> <div> </div>
    ADS_SERVER_BIND           = 0x00000200,
    ///Specify this flag to turn referral chasing off for the life of the connection. However, even when this flag is
    ///specified, ADSI still allows the setting of referral chasing behavior for container enumeration when set using
    ///<b>ADS_OPTION_REFERRALS</b> in ADS_OPTION_ENUM (as documented in container enumeration with referral chasing in
    ///IADsObjectOptions::SetOption) and searching separately (as documented in Referral Chasing with IDirectorySearch).
    ///<div class="alert"><b>Note</b> This option is not supported by the WinNT provider.</div> <div> </div>
    ADS_NO_REFERRAL_CHASING   = 0x00000400,
    ///Reserved.
    ADS_AUTH_RESERVED         = 0x80000000,
}

///The <b>ADS_STATUSENUM</b> enumeration specifies the status of a search preference set with the
///IDirectorySearch::SetSearchPreference method.
alias ADS_STATUSENUM = int;
enum : int
{
    ///The search preference was set successfully.
    ADS_STATUS_S_OK                    = 0x00000000,
    ///The search preference specified in the <b>dwSearchPref</b> member of the ADS_SEARCHPREF_INFO structure is
    ///invalid. Search preferences must be taken from the ADS_SEARCHPREF_ENUM enumeration.
    ADS_STATUS_INVALID_SEARCHPREF      = 0x00000001,
    ///The value specified in the <b>vValue</b> member of the ADS_SEARCHPREF_INFO structure is invalid for the
    ///corresponding search preference.
    ADS_STATUS_INVALID_SEARCHPREFVALUE = 0x00000002,
}

///The <b>ADS_DEREFENUM</b> enumeration specifies the process through which aliases are dereferenced.
alias ADS_DEREFENUM = int;
enum : int
{
    ///Does not dereference aliases when searching or locating the base object of the search.
    ADS_DEREF_NEVER     = 0x00000000,
    ///Dereferences aliases when searching subordinates of the base object, but not when locating the base itself.
    ADS_DEREF_SEARCHING = 0x00000001,
    ///Dereferences aliases when locating the base object of the search, but not when searching its subordinates.
    ADS_DEREF_FINDING   = 0x00000002,
    ///Dereferences aliases when both searching subordinates and locating the base object of the search.
    ADS_DEREF_ALWAYS    = 0x00000003,
}

///The <b>ADS_SCOPEENUM</b> enumeration specifies the scope of a directory search.
alias ADS_SCOPEENUM = int;
enum : int
{
    ///Limits the search to the base object. The result contains, at most, one object.
    ADS_SCOPE_BASE     = 0x00000000,
    ///Searches one level of the immediate children, excluding the base object.
    ADS_SCOPE_ONELEVEL = 0x00000001,
    ///Searches the whole subtree, including all the children and the base object itself.
    ADS_SCOPE_SUBTREE  = 0x00000002,
}

///The <b>ADS_PREFERENCES_ENUM</b> enumeration specifies the query preferences of the OLE DB provider for ADSI.
alias ADS_PREFERENCES_ENUM = int;
enum : int
{
    ///Requests an asynchronous search.
    ADSIPROP_ASYNCHRONOUS     = 0x00000000,
    ///Specifies that aliases of found objects are to be resolved. Use ADS_DEREFENUM to specify how to perform this
    ///operation.
    ADSIPROP_DEREF_ALIASES    = 0x00000001,
    ///Specifies the size limit that the server should observe in a search. The size limit is the maximum number of
    ///returned objects. A zero value indicates that no size limit is imposed. The server stops searching once the size
    ///limit is reached and returns the results accumulated up to that point.
    ADSIPROP_SIZE_LIMIT       = 0x00000002,
    ///Specifies the time limit, in seconds, that the server should observe in a search. A zero value indicates that no
    ///time limit restriction is imposed. When the time limit is reached, the server stops searching and returns results
    ///accumulated to that point.
    ADSIPROP_TIME_LIMIT       = 0x00000003,
    ///Indicates that the search should obtain only the name of attributes to which values have been assigned.
    ADSIPROP_ATTRIBTYPES_ONLY = 0x00000004,
    ///Specifies the search scope that should be observed by the server. For more information about the appropriate
    ///settings, see the ADS_SCOPEENUM enumeration.
    ADSIPROP_SEARCH_SCOPE     = 0x00000005,
    ///Specifies the time limit, in seconds, that a client will wait for the server to return the result.
    ADSIPROP_TIMEOUT          = 0x00000006,
    ///Specifies the page size in a paged search. For each request by the client, the server returns, at most, the
    ///number of objects as set by the page size.
    ADSIPROP_PAGESIZE         = 0x00000007,
    ///Specifies the time limit, in seconds, that the server should observe to search a page of results; this is opposed
    ///to the time limit for the entire search.
    ADSIPROP_PAGED_TIME_LIMIT = 0x00000008,
    ///Specifies that referrals may be chased. If the root search is not specified in the naming context of the server
    ///or when the search results cross a naming context (for example, when you have child domains and search in the
    ///parent domain), the server sends a referral message to the client which the client can choose to ignore or chase.
    ///By default, this option is set to ADS_CHASE_REFERRALS_EXTERNAL. For more information about referrals chasing, see
    ///ADS_CHASE_REFERRALS_ENUM.
    ADSIPROP_CHASE_REFERRALS  = 0x00000009,
    ///Specifies that the server sorts the result set. Use the ADS_SORTKEY structure to specify the sort keys.
    ADSIPROP_SORT_ON          = 0x0000000a,
    ///Specifies if the result should be cached on the client side. By default, ADSI caches the result set. Turning off
    ///this option may be more desirable for large result sets.
    ADSIPROP_CACHE_RESULTS    = 0x0000000b,
    ///Allows the OLEDB client to specify bind flags to use when binding to the server. Valid values are those allowed
    ///by ADsOpenObject. It is accessed from ADO scripts using the property name "ADSI Flag."
    ADSIPROP_ADSIFLAG         = 0x0000000c,
}

///The <b>ADSI_DIALECT_ENUM</b> enumeration specifies query dialects used in the OLE DB provider for ADSI.
alias ADSI_DIALECT_ENUM = int;
enum : int
{
    ///ADSI queries are based on the LDAP dialect.
    ADSI_DIALECT_LDAP = 0x00000000,
    ///ADSI queries are based on the SQL dialect.
    ADSI_DIALECT_SQL  = 0x00000001,
}

///The <b>ADS_CHASE_REFERRALS_ENUM</b> enumeration specifies if, and how, referral chasing occurs. When a server
///determines that other servers hold relevant data, in part or as a whole, it may refer the client to another server to
///obtain the result. Referral chasing is the action taken by a client to contact the referred-to server to continue the
///directory search.
alias ADS_CHASE_REFERRALS_ENUM = int;
enum : int
{
    ///The client should never chase the referred-to server. Setting this option prevents a client from contacting other
    ///servers in a referral process.
    ADS_CHASE_REFERRALS_NEVER       = 0x00000000,
    ///The client chases only subordinate referrals which are a subordinate naming context in a directory tree. For
    ///example, if the base search is requested for "DC=Fabrikam,DC=Com", and the server returns a result set and a
    ///referral of "DC=Sales,DC=Fabrikam,DC=Com" on the AdbSales server, the client can contact the AdbSales server to
    ///continue the search. The ADSI LDAP provider always turns off this flag for paged searches.
    ADS_CHASE_REFERRALS_SUBORDINATE = 0x00000020,
    ///The client chases external referrals. For example, a client requests server A to perform a search for
    ///"DC=Fabrikam,DC=Com". However, server A does not contain the object, but knows that an independent server, B,
    ///owns it. It then refers the client to server B.
    ADS_CHASE_REFERRALS_EXTERNAL    = 0x00000040,
    ///Referrals are chased for either the subordinate or external type.
    ADS_CHASE_REFERRALS_ALWAYS      = 0x00000060,
}

///The <b>ADS_SEARCHPREF_ENUM</b> enumeration specifies preferences for an IDirectorySearch object. This enumeration is
///used in the <b>dwSearchPref</b> member of the ADS_SEARCHPREF_INFO structure in the
///IDirectorySearch::SetSearchPreference method.
alias ADS_SEARCHPREF_ENUM = int;
enum : int
{
    ///Specifies that searches should be performed asynchronously. By default, searches are synchronous. In a
    ///synchronous search, the IDirectorySearch::GetFirstRow and IDirectorySearch::GetNextRow methods do not return
    ///until the server returns the entire result, or for a paged search, the entire page. An asynchronous search blocks
    ///until one row of the search results is available, or until the timeout interval specified by the
    ///<b>ADS_SEARCHPREF_TIMEOUT</b> search preference elapses.
    ADS_SEARCHPREF_ASYNCHRONOUS     = 0x00000000,
    ///Specifies that aliases of found objects are to be resolved. Use the ADS_DEREFENUM enumeration to specify how this
    ///is performed.
    ADS_SEARCHPREF_DEREF_ALIASES    = 0x00000001,
    ///Specifies the size limit that the server should observe during a search. The server stops searching when the size
    ///limit is reached and returns the results accumulated to that point. If this value is zero, the size limit is
    ///determined by the directory service. The default for this value is zero. If this value is greater than the size
    ///limit determined by the directory service, the directory service limit takes precedence. For Active Directory,
    ///the size limit specifies the maximum number of objects to be returned by the search. Also for Active Directory,
    ///the maximum number of objects returned by a search is 1000 objects.
    ADS_SEARCHPREF_SIZE_LIMIT       = 0x00000002,
    ///Specifies the number of seconds that the server waits for a search to complete. When the time limit is reached,
    ///the server stops searching and returns the results accumulated to that point. If this value is zero, the timeout
    ///period is infinite. The default for this value is 120 seconds.
    ADS_SEARCHPREF_TIME_LIMIT       = 0x00000003,
    ///Indicates that the search should obtain only the name of attributes to which values are assigned.
    ADS_SEARCHPREF_ATTRIBTYPES_ONLY = 0x00000004,
    ///Specifies the search scope that should be observed by the server. For more information about the appropriate
    ///settings, see the ADS_SCOPEENUM enumeration.
    ADS_SEARCHPREF_SEARCH_SCOPE     = 0x00000005,
    ///Specifies the time limit, in seconds, that a client will wait for the server to return the result. This option is
    ///set in an ADS_SEARCHPREF_INFO structure.
    ADS_SEARCHPREF_TIMEOUT          = 0x00000006,
    ///Specifies the page size in a paged search. For each request by the client, the server returns, at most, the
    ///number of objects as set by the page size. When page size is set, it is unnecessary to set the size limit. If a
    ///size limit is set, then the value for page size must be less than the value for size limit. If the value for page
    ///size exceeds size limit, then the <b>ERROR_DS_SIZELIMIT_EXCEEDED</b> error is returned with the number of rows
    ///specified by size limit.
    ADS_SEARCHPREF_PAGESIZE         = 0x00000007,
    ///Specifies the number of seconds that the server should wait for a page of search results, as opposed to the time
    ///limit for the entire search. When the time limit is reached, the server stops searching and returns the results
    ///obtained up to that point, along with a cookie that contains the data about where to resume searching. If this
    ///value is zero, the page timeout period is infinite. The default value for this limit is 120 seconds.
    ADS_SEARCHPREF_PAGED_TIME_LIMIT = 0x00000008,
    ///Specifies that referrals may be chased. If the root search is not specified in the naming context of the server
    ///or when the search results cross a naming context, for example, when you have child domains and search in the
    ///parent domain, the server sends a referral message to the client which the client can choose to ignore or chase.
    ///For more information about referral chasing, see ADS_CHASE_REFERRALS_ENUM.
    ADS_SEARCHPREF_CHASE_REFERRALS  = 0x00000009,
    ///Specifies that the server sorts the result set. Use the ADS_SORTKEY structure to specify the sort keys. This
    ///search preference works only for directory servers that support the LDAP control for server-side sorting. Active
    ///Directory supports the sort control, but it can impact server performance, particularly if the results set is
    ///large. Active Directory supports only a single sort key.
    ADS_SEARCHPREF_SORT_ON          = 0x0000000a,
    ///Specifies if the result should be cached on the client side. By default, ADSI caches the result set. Disabling
    ///this option may be desirable for large result sets.
    ADS_SEARCHPREF_CACHE_RESULTS    = 0x0000000b,
    ///Specifies a directory synchronization (DirSync) search, which returns all changes since a specified state. In the
    ///ADSVALUE structure, set the <b>dwType</b> member to ADS_PROV_SPECIFIC. The <b>ProviderSpecific</b> member is an
    ///<b>ADS_PROV_SPECIFIC</b> structure whose <b>lpValue</b> member specifies a cookie that indicates the state from
    ///which changes are retrieved. The first time you use the DirSync control, set the <b>dwLength</b> and
    ///<b>lpValue</b> members of the <b>ADS_PROV_SPECIFIC</b> structure to zero and <b>NULL</b> respectively. After
    ///reading the results set returned by the search until IDirectorySearch::GetNextRow returns
    ///<b>S_ADS_NOMORE_ROWS</b>, call IDirectorySearch::GetColumn to retrieve the <b>ADS_DIRSYNC_COOKIE</b> attribute
    ///which contains a cookie to use in the next DirSync search. For more information, see Polling for Changes Using
    ///the DirSync Control and LDAP_SERVER_DIRSYNC_OID. This flag cannot be combined with
    ///<b>ADS_SEARCHPREF_PAGESIZE</b>. The caller must have the <b>SE_SYNC_AGENT_NAME</b> privilege.
    ADS_SEARCHPREF_DIRSYNC          = 0x0000000c,
    ///Specifies whether the search should also return deleted objects that match the search filter. When objects are
    ///deleted, Active Directory moves them to a "Deleted Objects" container. By default, deleted objects are not
    ///included in the search results. In the ADSVALUE structure, set the <b>dwType</b> member to
    ///<b>ADSTYPE_BOOLEAN</b>. To include deleted objects, set the <b>Boolean</b> member of the <b>ADSVALUE</b>
    ///structure to <b>TRUE</b>. Not all attributes are preserved when the object is deleted. You can retrieve the
    ///<b>objectGUID</b> and <b>RDN</b> attributes. The <b>distinguishedName</b> attribute is the DN of the object in
    ///the "Deleted Objects" container, not the previous DN. The <b>isDeleted</b> attribute is <b>TRUE</b> for a deleted
    ///object. For more information, see Retrieving Deleted Objects.
    ADS_SEARCHPREF_TOMBSTONE        = 0x0000000d,
    ///Specifies that the search should use the LDAP virtual list view (VLV) control. <b>ADS_SEARCHPREF_VLV</b> can be
    ///used to access both string-type and offset-type VLV searches, by setting the appropriate fields. These two
    ///options cannot be used simultaneously because it is not possible to set the VLV control to request a result set
    ///that is both located at a specific offset and follows a particular value in the sort sequence. To perform a
    ///string search, set the <b>lpszTarget</b> field in ADS_VLV to the string to be searched for. To perform an offset
    ///type search, set the dwOffset field in <b>ADS_VLV</b>. If you use an offset search, you must set
    ///<b>lpszTarget</b> to <b>NULL</b>. <b>ADS_SEARCHPREF_SORT_ON</b> must be set to <b>TRUE</b> when using
    ///<b>ADS_SEARCHPREF_VLV</b>. The sort order of the search results determines the order used for the VLV search. If
    ///performing an offset-type search, the offset is used as an index into the sorted list. If performing a
    ///string-type search, the server attempts to return the first entry which is greater-than-or-equal-to the string,
    ///based on the sort order. Caching of search results is disabled when <b>ADS_SEARCHPREF_VLV</b> is specified. If
    ///you assign <b>ADS_SEARCHPREF_CACHE_RESULTS</b> a <b>TRUE</b>, value when using <b>ADS_SEARCHPREF_VLV</b>,
    ///SetSearchPreference will fail and return the error <b>E_ADS_BAD_PARAMETER</b>.
    ADS_SEARCHPREF_VLV              = 0x0000000e,
    ///Specifies that an attribute-scoped query search should be performed. The search is performed against those
    ///objects named in a specified attribute of the base object. The <b>vValue</b> member of the ADS_SEARCHPREF_INFO
    ///structure contains a <b>ADSTYPE_CASE_IGNORE_STRING</b> value which contains the lDAPDisplayName of attribute to
    ///search. This attribute must be a <b>ADS_DN_STRING</b> attribute. Only one attribute may be specified. Search
    ///scope is automatically set to <b>ADS_SCOPE_BASE</b> when using this preference, and attempting to set the scope
    ///otherwise will fail with the error <b>E_ADS_BAD_PARAMETER</b>. With the exception of the
    ///<b>ADS_SEARCHPREF_VLV</b> preference, all other preferences that use LDAP controls, such as
    ///<b>ADS_SEARCHPREF_DIRSYNC</b>, <b>ADS_SEARCHPREF_TOMBSTONE</b>, and so on, are not allowed when this preference
    ///is specified.
    ADS_SEARCHPREF_ATTRIBUTE_QUERY  = 0x0000000f,
    ///Specifies that the search should return security access data for the specified attributes. The <b>vValue</b>
    ///member of the ADS_SEARCHPREF_INFO structure contains an <b>ADS_INTEGER</b> value that is a combination of one or
    ///more of the following values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr>
    ///<td><b>ADS_SECURITY_INFO_OWNER</b></td> <td>Reads the owner data.</td> </tr> <tr>
    ///<td><b>ADS_SECURITY_INFO_GROUP</b></td> <td>Reads the group data.</td> </tr> <tr>
    ///<td><b>ADS_SECURITY_INFO_DACL</b></td> <td>Reads the discretionary access-control list (DACL).</td> </tr> <tr>
    ///<td><b>ADS_SECURITY_INFO_SACL</b></td> <td>Reads the system access-control list (SACL).</td> </tr> </table> If
    ///you read a security descriptor without explicitly specifying a security mask using
    ///<b>ADS_SEARCHPREF_SECURITY_MASK</b>, it defaults to the equivalent of <b>ADS_SECURITY_INFO_OWNER</b> |
    ///<b>ADS_SECURITY_INFO_GROUP</b> | <b>ADS_SECURITY_INFO_DACL</b>.
    ADS_SEARCHPREF_SECURITY_MASK    = 0x00000010,
    ///Contains optional flags for use with the <b>ADS_SEARCHPREF_DIRSYNC</b> search preference. The <b>vValue</b>
    ///member of the ADS_SEARCHPREF_INFO structure contains an <b>ADSTYPE_INTEGER</b> value that is zero or a
    ///combination of one or more of the following values. For more information about the DirSync control, see Polling
    ///for Changes Using the DirSync Control and LDAP_SERVER_DIRSYNC_OID. <table> <tr> <th>Identifier</th>
    ///<th>Value</th> <th>Description</th> </tr> <tr> <td><b>LDAP_DIRSYNC_OBJECT_SECURITY</b></td> <td>1</td> <td>If
    ///this flag is not present, the caller must have the replicate changes right. If this flag is present, the caller
    ///requires no rights, but is only allowed to see objects and attributes which are accessible to the caller.</td>
    ///</tr> <tr> <td><b>LDAP_DIRSYNC_ANCESTORS_FIRST_ORDER</b></td> <td>2048 (0x00000800)</td> <td>Return parent
    ///objects before child objects, when parent objects would otherwise appear later in the replication stream.</td>
    ///</tr> <tr> <td><b>LDAP_DIRSYNC_PUBLIC_DATA_ONLY</b></td> <td>8192 (0x00002000)</td> <td>Do not return private
    ///data in the search results.</td> </tr> <tr> <td><b>LDAP_DIRSYNC_INCREMENTAL_VALUES</b></td> <td>2147483648
    ///(0x80000000)</td> <td>If this flag is not present, all of the values, up to a server-specified limit, in a
    ///multi-valued attribute are returned when any value changes. If this flag is present, only the changed values are
    ///returned.</td> </tr> </table>
    ADS_SEARCHPREF_DIRSYNC_FLAG     = 0x00000011,
    ///The search should return distinguished names in Active Directory extended format. The <b>vValue</b> member of the
    ///ADS_SEARCHPREF_INFO structure contains an <b>ADSTYPE_INTEGER</b> value that contains zero if the GUID and SID
    ///portions of the DN string should be in hex format or one if the GUID and SID portions of the DN string should be
    ///in standard format. For more information about extended distinguished names, see LDAP_SERVER_EXTENDED_DN_OID.
    ADS_SEARCHPREF_EXTENDED_DN      = 0x00000012,
}

///The <b>ADS_PASSWORD_ENCODING_ENUM</b> enumeration identifies the type of password encoding used with the
///<b>ADS_OPTION_PASSWORD_METHOD</b> option in the IADsObjectOptions::GetOption and IADsObjectOptions::SetOption
///methods.
alias ADS_PASSWORD_ENCODING_ENUM = int;
enum : int
{
    ///Passwords are encoded using SSL.
    ADS_PASSWORD_ENCODE_REQUIRE_SSL = 0x00000000,
    ///Passwords are not encoded and are transmitted in plaintext.
    ADS_PASSWORD_ENCODE_CLEAR       = 0x00000001,
}

///The <b>ADS_PROPERTY_OPERATION_ENUM</b> enumeration specifies ways to update a named property in the cache.
alias ADS_PROPERTY_OPERATION_ENUM = int;
enum : int
{
    ///Instructs the directory service to remove all the property value(s) from the object.
    ADS_PROPERTY_CLEAR  = 0x00000001,
    ///Instructs the directory service to replace the current value(s) with the specified value(s).
    ADS_PROPERTY_UPDATE = 0x00000002,
    ///Instructs the directory service to append the specified value(s) to the existing values(s). When the
    ///<b>ADS_PROPERTY_APPEND</b> operation is specified, the new attribute value(s) are automatically committed to the
    ///directory service and removed from the local cache. This forces the local cache to be updated from the directory
    ///service the next time the attribute value(s) are retrieved.
    ADS_PROPERTY_APPEND = 0x00000003,
    ///Instructs the directory service to delete the specified value(s) from the object.
    ADS_PROPERTY_DELETE = 0x00000004,
}

///The <b>ADS_SYSTEMFLAG_ENUM</b> enumeration defines some of the values that can be assigned to the <b>systemFlags</b>
///attribute. Some of the values in the enumeration are specific to <b>attributeSchema</b> objects; other values can be
///set on objects of any class.
alias ADS_SYSTEMFLAG_ENUM = int;
enum : int
{
    ///Identifies an object that cannot be deleted.
    ADS_SYSTEMFLAG_DISALLOW_DELETE           = 0x80000000,
    ///For objects in the configuration partition, if this flag is set, the object can be renamed; otherwise, the object
    ///cannot be renamed. By default, this flag is not set on new objects created under the configuration partition, and
    ///you can set this flag only during object creation.
    ADS_SYSTEMFLAG_CONFIG_ALLOW_RENAME       = 0x40000000,
    ///For objects in the configuration partition, if this flag is set, the object can be moved; otherwise, the object
    ///cannot be moved. By default, this flag is not set on new objects created under the configuration partition, and
    ///you can set this flag only during object creation.
    ADS_SYSTEMFLAG_CONFIG_ALLOW_MOVE         = 0x20000000,
    ///For objects in the configuration partition, if this flag is set, the object can be moved with restrictions;
    ///otherwise, the object cannot be moved. By default, this flag is not set on new objects created under the
    ///configuration partition, and you can set this flag only during object creation.
    ADS_SYSTEMFLAG_CONFIG_ALLOW_LIMITED_MOVE = 0x10000000,
    ///Identifies a domain object that cannot be renamed.
    ADS_SYSTEMFLAG_DOMAIN_DISALLOW_RENAME    = 0x08000000,
    ///Identifies a domain object that cannot be moved.
    ADS_SYSTEMFLAG_DOMAIN_DISALLOW_MOVE      = 0x04000000,
    ///Naming context is in NTDS.
    ADS_SYSTEMFLAG_CR_NTDS_NC                = 0x00000001,
    ///Naming context is a domain.
    ADS_SYSTEMFLAG_CR_NTDS_DOMAIN            = 0x00000002,
    ///If this flag is set in the <b>systemFlags</b> attribute of an <b>attributeSchema</b> object, the attribute is not
    ///to be replicated.
    ADS_SYSTEMFLAG_ATTR_NOT_REPLICATED       = 0x00000001,
    ///If this flag is set in the <b>systemFlags</b> attribute of an <b>attributeSchema</b> object, the attribute is a
    ///constructed property.
    ADS_SYSTEMFLAG_ATTR_IS_CONSTRUCTED       = 0x00000004,
}

///The <b>ADS_GROUP_TYPE_ENUM</b> enumeration specifies the type of group objects in ADSI.
alias ADS_GROUP_TYPE_ENUM = int;
enum : int
{
    ///Specifies a group that can contain accounts from the same domain and other global groups from the same domain.
    ///This type of group can be exported to a different domain.
    ADS_GROUP_TYPE_GLOBAL_GROUP       = 0x00000002,
    ///Specifies a group that can contain accounts from any domain, other domain local groups from the same domain,
    ///global groups from any domain, and universal groups. This type of group should not be included in access-control
    ///lists of resources in other domains. This type of group is intended for use with the LDAP provider.
    ADS_GROUP_TYPE_DOMAIN_LOCAL_GROUP = 0x00000004,
    ///Specifies a group that is identical to the <b>ADS_GROUP_TYPE_DOMAIN_LOCAL_GROUP</b> group, but is intended for
    ///use with the WinNT provider.
    ADS_GROUP_TYPE_LOCAL_GROUP        = 0x00000004,
    ///Specifies a group that can contain accounts from any domain, global groups from any domain, and other universal
    ///groups. This type of group cannot contain domain local groups.
    ADS_GROUP_TYPE_UNIVERSAL_GROUP    = 0x00000008,
    ///Specifies a group that is security enabled. This group can be used to apply an access-control list on an ADSI
    ///object or a file system.
    ADS_GROUP_TYPE_SECURITY_ENABLED   = 0x80000000,
}

///The <b>ADS_USER_FLAG_ENUM</b> enumeration defines the flags used for setting user properties in the directory. These
///flags correspond to values of the <b>userAccountControl</b> attribute in Active Directory when using the LDAP
///provider, and the <b>userFlags</b> attribute when using the WinNT system provider.
alias ADS_USER_FLAG_ENUM = int;
enum : int
{
    ///The logon script is executed. This flag does not work for the ADSI LDAP provider on either read or write
    ///operations. For the ADSI WinNT provider, this flag is read-only data, and it cannot be set for user objects.
    ADS_UF_SCRIPT                                 = 0x00000001,
    ///The user account is disabled.
    ADS_UF_ACCOUNTDISABLE                         = 0x00000002,
    ///The home directory is required.
    ADS_UF_HOMEDIR_REQUIRED                       = 0x00000008,
    ///The account is currently locked out.
    ADS_UF_LOCKOUT                                = 0x00000010,
    ///No password is required.
    ADS_UF_PASSWD_NOTREQD                         = 0x00000020,
    ///The user cannot change the password. This flag can be read, but not set directly. For more information and a code
    ///example that shows how to prevent a user from changing the password, see User Cannot Change Password.
    ADS_UF_PASSWD_CANT_CHANGE                     = 0x00000040,
    ///The user can send an encrypted password.
    ADS_UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED        = 0x00000080,
    ///This is an account for users whose primary account is in another domain. This account provides user access to
    ///this domain, but not to any domain that trusts this domain. Also known as a local user account.
    ADS_UF_TEMP_DUPLICATE_ACCOUNT                 = 0x00000100,
    ///This is a default account type that represents a typical user.
    ADS_UF_NORMAL_ACCOUNT                         = 0x00000200,
    ///This is a permit to trust account for a system domain that trusts other domains.
    ADS_UF_INTERDOMAIN_TRUST_ACCOUNT              = 0x00000800,
    ///This is a computer account for a Windows or Windows Server that is a member of this domain.
    ADS_UF_WORKSTATION_TRUST_ACCOUNT              = 0x00001000,
    ///This is a computer account for a system backup domain controller that is a member of this domain.
    ADS_UF_SERVER_TRUST_ACCOUNT                   = 0x00002000,
    ///When set, the password will not expire on this account.
    ADS_UF_DONT_EXPIRE_PASSWD                     = 0x00010000,
    ///This is an Majority Node Set (MNS) logon account. With MNS, you can configure a multi-node Windows cluster
    ///without using a common shared disk.
    ADS_UF_MNS_LOGON_ACCOUNT                      = 0x00020000,
    ///When set, this flag will force the user to log on using a smart card.
    ADS_UF_SMARTCARD_REQUIRED                     = 0x00040000,
    ///When set, the service account (user or computer account), under which a service runs, is trusted for Kerberos
    ///delegation. Any such service can impersonate a client requesting the service. To enable a service for Kerberos
    ///delegation, set this flag on the <b>userAccountControl</b> property of the service account.
    ADS_UF_TRUSTED_FOR_DELEGATION                 = 0x00080000,
    ///When set, the security context of the user will not be delegated to a service even if the service account is set
    ///as trusted for Kerberos delegation.
    ADS_UF_NOT_DELEGATED                          = 0x00100000,
    ///Restrict this principal to use only Data Encryption Standard (DES) encryption types for keys.
    ADS_UF_USE_DES_KEY_ONLY                       = 0x00200000,
    ///This account does not require Kerberos preauthentication for logon.
    ADS_UF_DONT_REQUIRE_PREAUTH                   = 0x00400000,
    ///The user password has expired. This flag is created by the system using data from the password last set attribute
    ///and the domain policy. It is read-only and cannot be set. To manually set a user password as expired, use the
    ///NetUserSetInfo function with the USER_INFO_3 (<b>usri3_password_expired</b> member) or USER_INFO_4
    ///(<b>usri4_password_expired</b> member) structure.
    ADS_UF_PASSWORD_EXPIRED                       = 0x00800000,
    ///The account is enabled for delegation. This is a security-sensitive setting; accounts with this option enabled
    ///should be strictly controlled. This setting enables a service running under the account to assume a client
    ///identity and authenticate as that user to other remote servers on the network.
    ADS_UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION = 0x01000000,
}

///The <b>ADS_RIGHTS_ENUM</b> enumeration specifies access rights assigned to an Active Directory object. The
///IADsAccessControlEntry.AccessMask property contains a combination of these values for an Active Directory object. For
///more information and a list of possible access right values for file or file share objects, see File Security and
///Access Rights. For more information and a list of possible access right values for registry objects, see Registry Key
///Security and Access Rights.
alias ADS_RIGHTS_ENUM = int;
enum : int
{
    ///The right to delete the object.
    ADS_RIGHT_DELETE                 = 0x00010000,
    ///The right to read data from the security descriptor of the object, not including the data in the SACL.
    ADS_RIGHT_READ_CONTROL           = 0x00020000,
    ///The right to modify the discretionary access-control list (DACL) in the object security descriptor.
    ADS_RIGHT_WRITE_DAC              = 0x00040000,
    ///The right to assume ownership of the object. The user must be an object trustee. The user cannot transfer the
    ///ownership to other users.
    ADS_RIGHT_WRITE_OWNER            = 0x00080000,
    ///The right to use the object for synchronization. This enables a thread to wait until the object is in the
    ///signaled state.
    ADS_RIGHT_SYNCHRONIZE            = 0x00100000,
    ///The right to get or set the SACL in the object security descriptor.
    ADS_RIGHT_ACCESS_SYSTEM_SECURITY = 0x01000000,
    ///The right to read permissions on this object, read all the properties on this object, list this object name when
    ///the parent container is listed, and list the contents of this object if it is a container.
    ADS_RIGHT_GENERIC_READ           = 0x80000000,
    ///The right to read permissions on this object, write all the properties on this object, and perform all validated
    ///writes to this object.
    ADS_RIGHT_GENERIC_WRITE          = 0x40000000,
    ///The right to read permissions on, and list the contents of, a container object.
    ADS_RIGHT_GENERIC_EXECUTE        = 0x20000000,
    ///The right to create or delete child objects, delete a subtree, read and write properties, examine child objects
    ///and the object itself, add and remove the object from the directory, and read or write with an extended right.
    ADS_RIGHT_GENERIC_ALL            = 0x10000000,
    ///The right to create child objects of the object. The <b>ObjectType</b> member of an ACE can contain a <b>GUID</b>
    ///that identifies the type of child object whose creation is controlled. If <b>ObjectType</b> does not contain a
    ///<b>GUID</b>, the ACE controls the creation of all child object types.
    ADS_RIGHT_DS_CREATE_CHILD        = 0x00000001,
    ///The right to delete child objects of the object. The <b>ObjectType</b> member of an ACE can contain a <b>GUID</b>
    ///that identifies a type of child object whose deletion is controlled. If <b>ObjectType</b> does not contain a
    ///<b>GUID</b>, the ACE controls the deletion of all child object types.
    ADS_RIGHT_DS_DELETE_CHILD        = 0x00000002,
    ///The right to list child objects of this object. For more information about this right, see Controlling Object
    ///Visibility.
    ADS_RIGHT_ACTRL_DS_LIST          = 0x00000004,
    ///The right to perform an operation controlled by a validated write access right. The <b>ObjectType</b> member of
    ///an ACE can contain a <b>GUID</b> that identifies the validated write. If <b>ObjectType</b> does not contain a
    ///<b>GUID</b>, the ACE controls the rights to perform all valid write operations associated with the object.
    ADS_RIGHT_DS_SELF                = 0x00000008,
    ///The right to read properties of the object. The <b>ObjectType</b> member of an ACE can contain a <b>GUID</b> that
    ///identifies a property set or property. If <b>ObjectType</b> does not contain a <b>GUID</b>, the ACE controls the
    ///right to read all of the object properties.
    ADS_RIGHT_DS_READ_PROP           = 0x00000010,
    ///The right to write properties of the object. The <b>ObjectType</b> member of an ACE can contain a <b>GUID</b>
    ///that identifies a property set or property. If <b>ObjectType</b> does not contain a <b>GUID</b>, the ACE controls
    ///the right to write all of the object properties.
    ADS_RIGHT_DS_WRITE_PROP          = 0x00000020,
    ///The right to delete all child objects of this object, regardless of the permissions of the child objects.
    ADS_RIGHT_DS_DELETE_TREE         = 0x00000040,
    ///The right to list a particular object. If the user is not granted such a right, and the user does not have
    ///<b>ADS_RIGHT_ACTRL_DS_LIST</b> set on the object parent, the object is hidden from the user. This right is
    ///ignored if the third character of the dSHeuristics property is '0' or not set. For more information, see
    ///Controlling Object Visibility.
    ADS_RIGHT_DS_LIST_OBJECT         = 0x00000080,
    ///The right to perform an operation controlled by an extended access right. The <b>ObjectType</b> member of an ACE
    ///can contain a <b>GUID</b> that identifies the extended right. If <b>ObjectType</b> does not contain a
    ///<b>GUID</b>, the ACE controls the right to perform all extended right operations associated with the object.
    ADS_RIGHT_DS_CONTROL_ACCESS      = 0x00000100,
}

///The <b>ADS_ACETYPE_ENUM</b> enumeration is used to specify the type of an access-control entry for Active Directory
///objects. The IADsAccessControlEntry.AceType property contains one of these values for an Active Directory object. For
///more information and possible values for file, file share and registry objects, see the <b>AceType</b> member of the
///ACE_HEADER structure.
alias ADS_ACETYPE_ENUM = int;
enum : int
{
    ///The ACE is of the standard ACCESS ALLOWED type, where the <b>ObjectType</b> and <b>InheritedObjectType</b> fields
    ///are <b>NULL</b>.
    ADS_ACETYPE_ACCESS_ALLOWED                 = 0x00000000,
    ///The ACE is of the standard system-audit type, where the <b>ObjectType</b> and <b>InheritedObjectType</b> fields
    ///are <b>NULL</b>.
    ADS_ACETYPE_ACCESS_DENIED                  = 0x00000001,
    ///The ACE is of the standard system type, where the <b>ObjectType</b> and <b>InheritedObjectType</b> fields are
    ///<b>NULL</b>.
    ADS_ACETYPE_SYSTEM_AUDIT                   = 0x00000002,
    ///The ACE grants access to an object or a subobject of the object, such as a property set or property.
    ///<b>ObjectType</b> or <b>InheritedObjectType</b> or both contain a GUID that identifies a property set, property,
    ///extended right, or type of child object.
    ADS_ACETYPE_ACCESS_ALLOWED_OBJECT          = 0x00000005,
    ///The ACE denies access to an object or a subobject of the object, such as a property set or property.
    ///<b>ObjectType</b> or <b>InheritedObjectType</b> or both contain a GUID that identifies a property set, property,
    ///extended right, or type of child object.
    ADS_ACETYPE_ACCESS_DENIED_OBJECT           = 0x00000006,
    ///The ACE audits access to an object or a subobject of the object, such as a property set or property.
    ///<b>ObjectType</b> or <b>InheritedObjectType</b> or both contain a GUID that identifies a property set, property,
    ///extended right, or type of child object.
    ADS_ACETYPE_SYSTEM_AUDIT_OBJECT            = 0x00000007,
    ///Not used.
    ADS_ACETYPE_SYSTEM_ALARM_OBJECT            = 0x00000008,
    ///Same functionality as <b>ADS_ACETYPE_ACCESS_ALLOWED</b>, but used with applications that use Authz to verify
    ///ACEs.
    ADS_ACETYPE_ACCESS_ALLOWED_CALLBACK        = 0x00000009,
    ///Same functionality as <b>ADS_ACETYPE_ACCESS_DENIED</b>, but used with applications that use Authz to verify ACEs.
    ADS_ACETYPE_ACCESS_DENIED_CALLBACK         = 0x0000000a,
    ///Same functionality as <b>ADS_ACETYPE_ACCESS_ALLOWED_OBJECT</b>, but used with applications that use Authz to
    ///verify ACEs.
    ADS_ACETYPE_ACCESS_ALLOWED_CALLBACK_OBJECT = 0x0000000b,
    ///Same functionality as <b>ADS_ACETYPE_ACCESS_DENIED_OBJECT</b>, but used with applications that use Authz to check
    ///ACEs.
    ADS_ACETYPE_ACCESS_DENIED_CALLBACK_OBJECT  = 0x0000000c,
    ///Same functionality as <b>ADS_ACETYPE_SYSTEM_AUDIT</b>, but used with applications that use Authz to check ACEs.
    ADS_ACETYPE_SYSTEM_AUDIT_CALLBACK          = 0x0000000d,
    ///Not used.
    ADS_ACETYPE_SYSTEM_ALARM_CALLBACK          = 0x0000000e,
    ///Same functionality as <b>ADS_ACETYPE_SYSTEM_AUDIT_OBJECT</b>, but used with applications that use Authz to verify
    ///ACEs.
    ADS_ACETYPE_SYSTEM_AUDIT_CALLBACK_OBJECT   = 0x0000000f,
    ///Not used.
    ADS_ACETYPE_SYSTEM_ALARM_CALLBACK_OBJECT   = 0x00000010,
}

///The <b>ADS_ACEFLAG_ENUM</b> enumeration is used to specify the behavior of an Access Control Entry (ACE) for an
///Active Directory object. For more information and possible values for file, file share and registry objects, see the
///<b>AceFlags</b> member of the ACE_HEADER structure.
alias ADS_ACEFLAG_ENUM = int;
enum : int
{
    ///Child objects will inherit this access-control entry (ACE). The inherited ACE is inheritable unless the
    ///ADS_ACEFLAG_NO_PROPAGATE_INHERIT_ACE flag is set.
    ADS_ACEFLAG_INHERIT_ACE              = 0x00000002,
    ///The system will clear the ADS_ACEFLAG_INHERIT_ACE flag for the inherited ACEs of child objects. This prevents the
    ///ACE from being inherited by subsequent generations of objects.
    ADS_ACEFLAG_NO_PROPAGATE_INHERIT_ACE = 0x00000004,
    ///Indicates that an inherit-only ACE that does not exercise access control on the object to which it is attached.
    ///If this flag is not set, the ACE is an effective ACE that exerts access control on the object to which it is
    ///attached.
    ADS_ACEFLAG_INHERIT_ONLY_ACE         = 0x00000008,
    ///Indicates whether or not the ACE was inherited. The system sets this bit.
    ADS_ACEFLAG_INHERITED_ACE            = 0x00000010,
    ///Indicates whether the inherit flags are valid. The system sets this bit.
    ADS_ACEFLAG_VALID_INHERIT_FLAGS      = 0x0000001f,
    ///Generates audit messages for successful access attempts, used with ACEs that audit the system in a system
    ///access-control list (SACL).
    ADS_ACEFLAG_SUCCESSFUL_ACCESS        = 0x00000040,
    ///Generates audit messages for failed access attempts, used with ACEs that audit the system in a SACL.
    ADS_ACEFLAG_FAILED_ACCESS            = 0x00000080,
}

///The <b>ADS_FLAGTYPE_ENUM</b> enumeration specifies values that can be used to indicate the presence of the
///<b>ObjectType</b> or <b>InheritedObjectType</b> fields in the access-control entry (ACE).
alias ADS_FLAGTYPE_ENUM = int;
enum : int
{
    ///The <b>ObjectType</b> field is present in the ACE.
    ADS_FLAG_OBJECT_TYPE_PRESENT           = 0x00000001,
    ///The <b>InheritedObjectType</b> field is present in the ACE.
    ADS_FLAG_INHERITED_OBJECT_TYPE_PRESENT = 0x00000002,
}

///The <b>ADS_SD_CONTROL_ENUM</b> enumeration specifies control flags for a security descriptor.
alias ADS_SD_CONTROL_ENUM = int;
enum : int
{
    ///A default mechanism provides the owner security identifier (SID) of the security descriptor rather than the
    ///original provider of the security descriptor.
    ADS_SD_CONTROL_SE_OWNER_DEFAULTED       = 0x00000001,
    ///A default mechanism provides the group SID of the security descriptor rather than the original provider of the
    ///security descriptor.
    ADS_SD_CONTROL_SE_GROUP_DEFAULTED       = 0x00000002,
    ///The discretionary access-control list (DACL) is present in the security descriptor. If this flag is not set, or
    ///if this flag is set and the DACL is <b>NULL</b>, the security descriptor allows full access to everyone.
    ADS_SD_CONTROL_SE_DACL_PRESENT          = 0x00000004,
    ///The security descriptor uses a default DACL built from the creator's access token.
    ADS_SD_CONTROL_SE_DACL_DEFAULTED        = 0x00000008,
    ///The system access-control list (SACL) is present in the security descriptor.
    ADS_SD_CONTROL_SE_SACL_PRESENT          = 0x00000010,
    ///The security descriptor uses a default SACL built from the creator's access token.
    ADS_SD_CONTROL_SE_SACL_DEFAULTED        = 0x00000020,
    ///THE DACL of the security descriptor must be inherited.
    ADS_SD_CONTROL_SE_DACL_AUTO_INHERIT_REQ = 0x00000100,
    ///The SACL of the security descriptor must be inherited.
    ADS_SD_CONTROL_SE_SACL_AUTO_INHERIT_REQ = 0x00000200,
    ///The DACL of the security descriptor supports automatic propagation of inheritable access-control entries (ACEs)
    ///to existing child objects.
    ADS_SD_CONTROL_SE_DACL_AUTO_INHERITED   = 0x00000400,
    ///The SACL of the security descriptor supports automatic propagation of inheritable ACEs to existing child objects.
    ADS_SD_CONTROL_SE_SACL_AUTO_INHERITED   = 0x00000800,
    ///The security descriptor will not allow inheritable ACEs to modify the DACL.
    ADS_SD_CONTROL_SE_DACL_PROTECTED        = 0x00001000,
    ///The security descriptor will not allow inheritable ACEs to modify the SACL.
    ADS_SD_CONTROL_SE_SACL_PROTECTED        = 0x00002000,
    ///The security descriptor is of self-relative format with all the security information in a continuous block of
    ///memory.
    ADS_SD_CONTROL_SE_SELF_RELATIVE         = 0x00008000,
}

///The <b>ADS_SD_REVISION_ENUM</b> enumeration specifies the revision number of the access-control entry (ACE), or the
///access-control list (ACL), for Active Directory.
alias ADS_SD_REVISION_ENUM = int;
enum : int
{
    ///The revision number of the ACE, or the ACL, for Active Directory.
    ADS_SD_REVISION_DS = 0x00000004,
}

///The <b>ADS_NAME_TYPE_ENUM</b> enumeration specifies the formats used for representing distinguished names. It is used
///by the IADsNameTranslate interface to convert the format of a distinguished name.
alias ADS_NAME_TYPE_ENUM = int;
enum : int
{
    ///Name format as specified in RFC 1779. For example, "CN=Jeff Smith,CN=users,DC=Fabrikam,DC=com".
    ADS_NAME_TYPE_1779                    = 0x00000001,
    ///Canonical name format. For example, "Fabrikam.com/Users/Jeff Smith".
    ADS_NAME_TYPE_CANONICAL               = 0x00000002,
    ///Account name format used in Windows. For example, "Fabrikam\JeffSmith".
    ADS_NAME_TYPE_NT4                     = 0x00000003,
    ///Display name format. For example, "Jeff Smith".
    ADS_NAME_TYPE_DISPLAY                 = 0x00000004,
    ///Simple domain name format. For example, "JeffSmith@Fabrikam.com".
    ADS_NAME_TYPE_DOMAIN_SIMPLE           = 0x00000005,
    ///Simple enterprise name format. For example, "JeffSmith@Fabrikam.com".
    ADS_NAME_TYPE_ENTERPRISE_SIMPLE       = 0x00000006,
    ///Global Unique Identifier format. For example, "{95ee9fff-3436-11d1-b2b0-d15ae3ac8436}".
    ADS_NAME_TYPE_GUID                    = 0x00000007,
    ///Unknown name type. The system will estimate the format. This element is a meaningful option only with the
    ///IADsNameTranslate.Set or the IADsNameTranslate.SetEx method, but not with the IADsNameTranslate.Get or
    ///IADsNameTranslate.GetEx method.
    ADS_NAME_TYPE_UNKNOWN                 = 0x00000008,
    ///User principal name format. For example, "JeffSmith@Fabrikam.com".
    ADS_NAME_TYPE_USER_PRINCIPAL_NAME     = 0x00000009,
    ///Extended canonical name format. For example, "Fabrikam.com/Users Jeff Smith".
    ADS_NAME_TYPE_CANONICAL_EX            = 0x0000000a,
    ///Service principal name format. For example, "www/www.fabrikam.com@fabrikam.com".
    ADS_NAME_TYPE_SERVICE_PRINCIPAL_NAME  = 0x0000000b,
    ///A SID string, as defined in the Security Descriptor Definition Language (SDDL), for either the SID of the current
    ///object or one from the object SID history. For example, "O:AOG:DAD:(A;;RPWPCCDCLCSWRCWDWOGA;;;S-1-0-0)" For more
    ///information, see Security Descriptor String Format.
    ADS_NAME_TYPE_SID_OR_SID_HISTORY_NAME = 0x0000000c,
}

///The <b>ADS_NAME_INITTYPE_ENUM</b> enumeration specifies the types of initialization to perform on a
///<b>NameTranslate</b> object. It is used in the IADsNameTranslate interface.
alias ADS_NAME_INITTYPE_ENUM = int;
enum : int
{
    ///Initializes a <b>NameTranslate</b> object by setting the domain that the object binds to.
    ADS_NAME_INITTYPE_DOMAIN = 0x00000001,
    ///Initializes a <b>NameTranslate</b> object by setting the server that the object binds to.
    ADS_NAME_INITTYPE_SERVER = 0x00000002,
    ///Initializes a <b>NameTranslate</b> object by locating the global catalog that the object binds to.
    ADS_NAME_INITTYPE_GC     = 0x00000003,
}

///The <b>ADS_OPTION_ENUM</b> enumeration type contains values that indicate the options that can be retrieved or set
///with the IADsObjectOptions.GetOption and IADsObjectOptions.SetOption methods.
alias ADS_OPTION_ENUM = int;
enum : int
{
    ///Gets a <b>VT_BSTR</b> that contains the host name of the server for the current binding to this object. This
    ///option is not supported by the IADsObjectOptions.SetOption method.
    ADS_OPTION_SERVERNAME                = 0x00000000,
    ///Gets or sets a <b>VT_I4</b> value that indicates how referral chasing is performed in a query. This option can
    ///contain one of the values defined by the ADS_CHASE_REFERRALS_ENUM enumeration.
    ADS_OPTION_REFERRALS                 = 0x00000001,
    ///Gets or sets a <b>VT_I4</b> value that indicates the page size in a paged search.
    ADS_OPTION_PAGE_SIZE                 = 0x00000002,
    ///Gets or sets a <b>VT_I4</b> value that controls the security descriptor data that can be read on the object. This
    ///option can contain any combination of the values defined in the ADS_SECURITY_INFO_ENUM enumeration.
    ADS_OPTION_SECURITY_MASK             = 0x00000003,
    ///Gets a <b>VT_I4</b> value that determines if mutual authentication is performed by the SSPI layer. If the
    ///returned option value contains the <b>ISC_RET_MUTUAL_AUTH</b> flag, defined in Sspi.h, then mutual authentication
    ///has been performed. If the returned option value does not contain the <b>ISC_RET_MUTUAL_AUTH</b> flag, then
    ///mutual authentication has not been performed. For more information about mutual authentication, see SSPI. This
    ///option is not supported by the IADsObjectOptions.SetOption method.
    ADS_OPTION_MUTUAL_AUTH_STATUS        = 0x00000004,
    ///Enables the effective quota and used quota of a security principal to be read. This option takes a <b>VT_BSTR</b>
    ///value that contains the security principal that the quotas can be read for. If the security principal string is
    ///zero length or the value is a <b>VT_EMPTY</b> value, the security principal is the currently logged on user. This
    ///option is only supported by the IADsObjectOptions.SetOption method.
    ADS_OPTION_QUOTA                     = 0x00000005,
    ///Retrieves or sets a <b>VT_I4</b> value that contains the port number that ADSI uses to establish a connection
    ///when the password is set or changed. By default, ADSI uses port 636 to establish a connection to set or change
    ///the password.
    ADS_OPTION_PASSWORD_PORTNUMBER       = 0x00000006,
    ///Retrieves or sets a <b>VT_I4</b> value that specifies the password encoding method. This option can contain one
    ///of the values defined in the ADS_PASSWORD_ENCODING_ENUM enumeration.
    ADS_OPTION_PASSWORD_METHOD           = 0x00000007,
    ///Contains a <b>VT_BOOL</b> value that specifies if attribute value change operations should be accumulated. By
    ///default, when an attribute value is modified more than one time, the previous value change operation is
    ///overwritten by the more recent operation. If this option is set to <b>VARIANT_TRUE</b>, each attribute value
    ///change operation is accumulated in the cache. When the attribute value updates are committed to the server with
    ///the IADs.SetInfo method, each individual accumulated operation is sent to the server. When this option has been
    ///set to <b>VARIANT_TRUE</b>, it cannot be reset to <b>VARIANT_FALSE</b> for the lifetime of the ADSI object. To
    ///reset this option, all references to the ADSI object must be released and the object must be bound to again. When
    ///the object is bound to again, this option will be set to <b>VARIANT_FALSE</b> by default. This option only
    ///affects attribute values modified with the IADs.PutEx and IADsPropertyList.PutPropertyItem methods. This option
    ///is ignored by the IADs.Put method.
    ADS_OPTION_ACCUMULATIVE_MODIFICATION = 0x00000008,
    ///If this option is set on the object, no lookups will be performed (either during the retrieval or during
    ///modification). This option affects the IADs and IADsPropertyList interfaces. It is also applicable when
    ///retrieving the effective quota usage of a particular user.
    ADS_OPTION_SKIP_SID_LOOKUP           = 0x00000009,
}

///The <b>ADS_SECURITY_INFO_ENUM</b> enumeration specifies the available options for examining security data of an
///object.
alias ADS_SECURITY_INFO_ENUM = int;
enum : int
{
    ///Reads or sets the owner data.
    ADS_SECURITY_INFO_OWNER = 0x00000001,
    ///Reads or sets the group data.
    ADS_SECURITY_INFO_GROUP = 0x00000002,
    ///Reads or sets the discretionary access-control list data.
    ADS_SECURITY_INFO_DACL  = 0x00000004,
    ///Reads or sets the system access-control list data.
    ADS_SECURITY_INFO_SACL  = 0x00000008,
}

///The <b>ADS_SETTYPE_ENUM</b> enumeration specifies the available pathname format used by the IADsPathname::Set method.
alias ADS_SETTYPE_ENUM = int;
enum : int
{
    ///Sets the full path, for example, "LDAP://servername/o=internet/…/cn=bar".
    ADS_SETTYPE_FULL     = 0x00000001,
    ///Updates the provider only, for example, "LDAP".
    ADS_SETTYPE_PROVIDER = 0x00000002,
    ///Updates the server name only, for example, "servername".
    ADS_SETTYPE_SERVER   = 0x00000003,
    ///Updates the distinguished name only, for example, "o=internet/…/cn=bar".
    ADS_SETTYPE_DN       = 0x00000004,
}

///The <b>ADS_FORMAT_ENUM</b> enumeration specifies the available path value types used by the IADsPathname::Retrieve
///method.
alias ADS_FORMAT_ENUM = int;
enum : int
{
    ///Returns the full path in Windows format, for example, "LDAP://servername/o=internet/…/cn=bar".
    ADS_FORMAT_WINDOWS           = 0x00000001,
    ///Returns Windows format without server, for example, "LDAP://o=internet/…/cn=bar".
    ADS_FORMAT_WINDOWS_NO_SERVER = 0x00000002,
    ///Returns Windows format of the distinguished name only, for example, "o=internet/…/cn=bar".
    ADS_FORMAT_WINDOWS_DN        = 0x00000003,
    ///Returns Windows format of Parent only, for example, "o=internet/…".
    ADS_FORMAT_WINDOWS_PARENT    = 0x00000004,
    ///Returns the full path in X.500 format, for example, "LDAP://servername/cn=bar,…,o=internet".
    ADS_FORMAT_X500              = 0x00000005,
    ///Returns the path without server in X.500 format, for example, "LDAP://cn=bar,…,o=internet".
    ADS_FORMAT_X500_NO_SERVER    = 0x00000006,
    ///Returns only the distinguished name in X.500 format. For example, "cn=bar,…,o=internet".
    ADS_FORMAT_X500_DN           = 0x00000007,
    ///Returns only the parent in X.500 format, for example, "…,o=internet".
    ADS_FORMAT_X500_PARENT       = 0x00000008,
    ///Returns the server name, for example, "servername".
    ADS_FORMAT_SERVER            = 0x00000009,
    ///Returns the name of the provider, for example, "LDAP".
    ADS_FORMAT_PROVIDER          = 0x0000000a,
    ///Returns the name of the leaf, for example, "cn=bar".
    ADS_FORMAT_LEAF              = 0x0000000b,
}

///The <b>ADS_DISPLAY_ENUM</b> enumeration specifies how a path is to be displayed.
alias ADS_DISPLAY_ENUM = int;
enum : int
{
    ///The path is displayed with both attributes and values. For example, CN=Jeff Smith.
    ADS_DISPLAY_FULL       = 0x00000001,
    ///The path is displayed with values only. For example, Jeff Smith.
    ADS_DISPLAY_VALUE_ONLY = 0x00000002,
}

///The <b>ADS_ESCAPE_MODE_ENUM</b> enumeration specifies how escape characters are displayed in a directory path.
alias ADS_ESCAPE_MODE_ENUM = int;
enum : int
{
    ///The default escape mode provides a convenient option to specify the escape mode. It has the effect of minimal
    ///escape operation appropriate for a chosen format. Thus, the default behavior depends on the value that
    ///ADS_FORMAT_ENUM uses to retrieve the directory paths. <table> <tr> <th>Retrieved path format</th> <th>Default
    ///escaped mode</th> </tr> <tr> <td><b>ADS_FORMAT_X500</b></td> <td><b>ADS_ESCAPEDMODE_ON</b></td> </tr> <tr>
    ///<td><b>ADS_FORMAT_X500_NO_SERVER</b></td> <td><b>ADS_ESCAPEDMODE_ON</b></td> </tr> <tr>
    ///<td><b>ADS_FORMAT_WINDOWS</b></td> <td><b>ADS_ESCAPEDMODE_ON</b></td> </tr> <tr>
    ///<td><b>ADS_FORMAT_WINDOWS_NO_SERVER</b></td> <td><b>ADS_ESCAPEDMODE_ON</b></td> </tr> <tr>
    ///<td><b>ADS_FORMAT_X500_DN</b></td> <td><b>ADS_ESCAPEDMODE_OFF</b></td> </tr> <tr>
    ///<td><b>ADS_FORMAT_X500_PARENT</b></td> <td><b>ADS_ESCAPEDMODE_OFF</b></td> </tr> <tr>
    ///<td><b>ADS_FORMAT_WINDOWS_DN</b></td> <td><b>ADS_ESCAPEDMODE_OFF</b></td> </tr> <tr>
    ///<td><b>ADS_FORMAT_WINDOWS_PARENT</b></td> <td><b>ADS_ESCAPEDMODE_OFF</b></td> </tr> <tr>
    ///<td><b>ADS_FORMAT_LEAF</b></td> <td><b>ADS_ESCAPEDMODE_ON</b></td> </tr> </table>
    ADS_ESCAPEDMODE_DEFAULT = 0x00000001,
    ///All special characters are displayed in the escape format; for example, "CN=date\=yy\/mm\/dd\,weekday" appears as
    ///is.
    ADS_ESCAPEDMODE_ON      = 0x00000002,
    ///ADSI special characters are displayed in the unescaped format; for example, "CN=date\=yy\/mm\/dd\,weekday"
    ///appears as "CN=date\=yy/mm/dd\,weekday".
    ADS_ESCAPEDMODE_OFF     = 0x00000003,
    ///ADSI and LDAP special characters are displayed in the unescaped format; for example,
    ///"CN=date\=yy\/mm\/dd\,weekday" appears as "CN=date=yy/mm/dd,weekday".
    ADS_ESCAPEDMODE_OFF_EX  = 0x00000004,
}

///The <b>ADS_PATHTYPE_ENUM</b> enumeration specifies the type of object on which the IADsSecurityUtility interface is
///going to add or modify a security descriptor.
alias ADS_PATHTYPE_ENUM = int;
enum : int
{
    ///Indicates that the security descriptor will be retrieved or set on a file object.
    ADS_PATH_FILE      = 0x00000001,
    ///Indicates that the security descriptor will be retrieved or set on a file share object.
    ADS_PATH_FILESHARE = 0x00000002,
    ///Indicates that the security descriptor will be retrieved or set on a registry key object.
    ADS_PATH_REGISTRY  = 0x00000003,
}

///The <b>ADS_SD_FORMAT_ENUM</b> enumeration specifies the format that the security descriptor of an object will be
///converted to by the IADsSecurityUtility interface.
alias ADS_SD_FORMAT_ENUM = int;
enum : int
{
    ///Indicates that the security descriptor is to be converted to the IADsSecurityDescriptor interface format. If
    ///<b>ADS_SD_FORMAT_IID</b> is used as the input format when setting the security descriptor, the variant passed in
    ///is expected to be a VT_DISPATCH, where the dispatch pointer supports the <b>IADsSecurityDescriptor</b> interface.
    ADS_SD_FORMAT_IID       = 0x00000001,
    ///Indicates that the security descriptor is to be converted to the binary format.
    ADS_SD_FORMAT_RAW       = 0x00000002,
    ///Indicates that the security descriptor is to be converted to the hex encoded string format.
    ADS_SD_FORMAT_HEXSTRING = 0x00000003,
}

///The <b>DS_MANGLE_FOR</b> enumeration is used to define whether a relative distinguished name is mangled (encoded) and
///in what form the mangling occurs.
alias DS_MANGLE_FOR = int;
enum : int
{
    ///Indicates that the relative distinguished name is not mangled or that the type of mangling is unknown.
    DS_MANGLE_UNKNOWN                      = 0x00000000,
    ///Indicates that the relative distinguished name has been mangled for deletion.
    DS_MANGLE_OBJECT_RDN_FOR_DELETION      = 0x00000001,
    ///Indicates that the relative distinguished name has been mangled due to a naming conflict.
    DS_MANGLE_OBJECT_RDN_FOR_NAME_CONFLICT = 0x00000002,
}

///The <b>DS_NAME_FORMAT</b> enumeration provides formats to use for input and output names for the DsCrackNames
///function.
alias DS_NAME_FORMAT = int;
enum : int
{
    ///Indicates the name is using an unknown name type. This format can impact performance because it forces the server
    ///to attempt to match all possible formats. Only use this value if the input format is unknown.
    DS_UNKNOWN_NAME            = 0x00000000,
    ///Indicates that the fully qualified distinguished name is used. For example:
    ///CN=someone,OU=Users,DC=Engineering,DC=Fabrikam,DC=Com
    DS_FQDN_1779_NAME          = 0x00000001,
    ///Indicates a Windows NT 4.0 account name. For example: Engineering\someone The domain-only version includes two
    ///trailing backslashes (\\).
    DS_NT4_ACCOUNT_NAME        = 0x00000002,
    ///Indicates a user-friendly display name, for example, Jeff Smith. The display name is not necessarily the same as
    ///relative distinguished name (RDN).
    DS_DISPLAY_NAME            = 0x00000003,
    ///Indicates a GUID string that the IIDFromString function returns. For example:
    ///{4fa050f0-f561-11cf-bdd9-00aa003a77b6}
    DS_UNIQUE_ID_NAME          = 0x00000006,
    ///Indicates a complete canonical name. For example: engineering.fabrikam.com/software/someone The domain-only
    ///version includes a trailing forward slash (/).
    DS_CANONICAL_NAME          = 0x00000007,
    ///Indicates that it is using the user principal name (UPN). For example: someone@engineering.fabrikam.com
    DS_USER_PRINCIPAL_NAME     = 0x00000008,
    ///This element is the same as <b>DS_CANONICAL_NAME</b> except that the rightmost forward slash (/) is replaced with
    ///a newline character (\n), even in a domain-only case. For example: engineering.fabrikam.com/software\nsomeone
    DS_CANONICAL_NAME_EX       = 0x00000009,
    ///Indicates it is using a generalized service principal name. For example: www/www.fabrikam.com@fabrikam.com
    DS_SERVICE_PRINCIPAL_NAME  = 0x0000000a,
    ///Indicates a Security Identifier (SID) for the object. This can be either the current SID or a SID from the object
    ///SID history. The SID string can use either the standard string representation of a SID, or one of the string
    ///constants defined in Sddl.h. For more information about converting a binary SID into a SID string, see SID
    ///Strings. The following is an example of a SID string: S-1-5-21-397955417-626881126-188441444-501
    DS_SID_OR_SID_HISTORY_NAME = 0x0000000b,
    ///Not supported by the Directory Service (DS) APIs.
    DS_DNS_DOMAIN_NAME         = 0x0000000c,
}

///The <b>DS_NAME_FLAGS</b> enumeration is used to define how the name syntax will be cracked. These flags are used by
///the DsCrackNames function.
alias DS_NAME_FLAGS = int;
enum : int
{
    ///Indicates that there are no associated flags.
    DS_NAME_NO_FLAGS              = 0x00000000,
    ///Performs a syntactical mapping at the client without transferring over the network. The only syntactic mapping
    ///supported is from DS_FQDN_1779_NAME to <b>DS_CANONICAL_NAME</b> or <b>DS_CANONICAL_NAME_EX</b>. DsCrackNames
    ///returns the <b>DS_NAME_ERROR_NO_SYNTACTICAL_MAPPING</b> flag if a syntactical mapping is not possible.
    DS_NAME_FLAG_SYNTACTICAL_ONLY = 0x00000001,
    ///Forces a trip to the domain controller for evaluation, even if the syntax could be cracked locally.
    DS_NAME_FLAG_EVAL_AT_DC       = 0x00000002,
    ///The call fails if the domain controller is not a global catalog server.
    DS_NAME_FLAG_GCVERIFY         = 0x00000004,
    ///Enables cross forest trust referral.
    DS_NAME_FLAG_TRUST_REFERRAL   = 0x00000008,
}

///The <b>DS_NAME_ERROR</b> enumeration defines the errors returned by the <b>status</b> member of the
///DS_NAME_RESULT_ITEM structure. These are potential errors that may be encountered while a name is converted by the
///DsCrackNames function.
alias DS_NAME_ERROR = int;
enum : int
{
    ///The conversion was successful.
    DS_NAME_NO_ERROR                     = 0x00000000,
    ///A generic processing error occurred.
    DS_NAME_ERROR_RESOLVING              = 0x00000001,
    ///The name cannot be found or the caller does not have permission to access the name.
    DS_NAME_ERROR_NOT_FOUND              = 0x00000002,
    ///The input name is mapped to more than one output name or the desired format did not have a single, unique value
    ///for the object found.
    DS_NAME_ERROR_NOT_UNIQUE             = 0x00000003,
    ///The input name was found, but the associated output format cannot be found. This can occur if the object does not
    ///have all the required attributes.
    DS_NAME_ERROR_NO_MAPPING             = 0x00000004,
    ///Unable to resolve entire name, but was able to determine in which domain object resides. The caller is expected
    ///to retry the call at a domain controller for the specified domain. The entire name cannot be resolved, but the
    ///domain that the object resides in could be determined. The <b>pDomain</b> member of the DS_NAME_RESULT_ITEM
    ///contains valid data when this error is specified.
    DS_NAME_ERROR_DOMAIN_ONLY            = 0x00000005,
    ///A syntactical mapping cannot be performed on the client without transmitting over the network.
    DS_NAME_ERROR_NO_SYNTACTICAL_MAPPING = 0x00000006,
    ///The name is from an external trusted forest.
    DS_NAME_ERROR_TRUST_REFERRAL         = 0x00000007,
}

///The <b>DS_SPN_NAME_TYPE</b> enumeration is used by the DsGetSPN function to identify the format for composing SPNs.
alias DS_SPN_NAME_TYPE = int;
enum : int
{
    ///The SPN format for the distinguished name service of the host-based service, which provides services identified
    ///with its host computer. This SPN uses the following format: ```cpp jeffsmith.fabrikam.com ```
    DS_SPN_DNS_HOST  = 0x00000000,
    ///The SPN format for the distinguished name of the host-based service, which provides services identified with its
    ///host computer. This SPN uses the following format: ```cpp cn=jeffsmith,ou=computers,dc=fabrikam,dc=com ```
    DS_SPN_DN_HOST   = 0x00000001,
    ///The SPN format for the NetBIOS service of the host-based service, which provides services identified with its
    ///host computer. This SPN uses the following format: ```cpp jeffsmith-nec ```
    DS_SPN_NB_HOST   = 0x00000002,
    ///The SPN format for a replicable service that provides services to the specified domain. This SPN uses the
    ///following format: ```cpp fabrikam.com ```
    DS_SPN_DOMAIN    = 0x00000003,
    ///The SPN format for a replicable service that provides services to the specified NetBIOS domain. This SPN uses the
    ///following format: ```cpp fabrikam ```
    DS_SPN_NB_DOMAIN = 0x00000004,
    ///The SPN format for a specified service. This SPN uses the following formats, depending on which service is used:
    ///```cpp cn=anRpcService,cn=RPC Services,cn=system,dc=fabrikam,dc=com ``` ```cpp cn=aWsService,cn=Winsock
    ///Services,cn=system,dc=fabrikam,dc=com ``` ```cpp cn=aService,dc=itg,dc=fabrikam,dc=com ``` ```cpp
    ///www.fabrikam.com, ftp.fabrikam.com, ldap.fabrikam.com ``` ```cpp products.fabrikam.com ```
    DS_SPN_SERVICE   = 0x00000005,
}

///The <b>DS_SPN_WRITE_OP</b> enumeration identifies the type of write operation that should be performed by the
///DsWriteAccountSpn function.
alias DS_SPN_WRITE_OP = int;
enum : int
{
    ///Adds the specified service principal names (SPNs) to the object identified by the <i>pszAccount</i> parameter in
    ///DsWriteAccountSpn.
    DS_SPN_ADD_SPN_OP     = 0x00000000,
    ///Removes all SPNs currently registered on the account identified by the <i>pszAccount</i> parameter in
    ///DsWriteAccountSpn and replaces them with the SPNs specified by the <i>rpszSpn</i> parameter in
    ///<b>DsWriteAccountSpn</b>.
    DS_SPN_REPLACE_SPN_OP = 0x00000001,
    ///Deletes the specified SPNs from the object identified by the <i>pszAccount</i> parameter in DsWriteAccountSpn.
    DS_SPN_DELETE_SPN_OP  = 0x00000002,
}

///The <b>DS_REPSYNCALL_ERROR</b> enumeration is used with the DS_REPSYNCALL_ERRINFO structure to indicate where in the
///replication process an error occurred.
alias DS_REPSYNCALL_ERROR = int;
enum : int
{
    ///The server referred to by the <b>pszSvrId</b> member of the DS_REPSYNCALL_ERRINFO structure cannot be contacted.
    DS_REPSYNCALL_WIN32_ERROR_CONTACTING_SERVER = 0x00000000,
    ///An error occurred during replication of the server identified by the <b>pszSvrId</b> member of the
    ///DS_REPSYNCALL_ERRINFO structure.
    DS_REPSYNCALL_WIN32_ERROR_REPLICATING       = 0x00000001,
    ///The server identified by the <b>pszSvrId</b> member of the DS_REPSYNCALL_ERRINFO structure cannot be contacted.
    DS_REPSYNCALL_SERVER_UNREACHABLE            = 0x00000002,
}

///The <b>DS_REPSYNCALL_EVENT</b> enumeration is used with the DS_REPSYNCALL_UPDATE structure to define which event the
///<b>DS_REPSYNCALL_UPDATE</b> structure represents.
alias DS_REPSYNCALL_EVENT = int;
enum : int
{
    ///An error occurred. Error data is stored in the <b>pErrInfo</b> member of the DS_REPSYNCALL_UPDATE structure.
    DS_REPSYNCALL_EVENT_ERROR          = 0x00000000,
    ///Synchronization of two servers has started. Both the <b>pErrInfo</b> and <b>pSync</b> members of the
    ///DS_REPSYNCALL_UPDATE structure are <b>NULL</b>.
    DS_REPSYNCALL_EVENT_SYNC_STARTED   = 0x00000001,
    ///Synchronization of two servers has just finished. The servers involved in the synchronization are identified by
    ///the <b>pSync</b> member of the DS_REPSYNCALL_UPDATE structure. The <b>pErrInfo</b> member of the
    ///<b>DS_REPSYNCALL_UPDATE</b> structure is <b>NULL</b>.
    DS_REPSYNCALL_EVENT_SYNC_COMPLETED = 0x00000002,
    ///Execution of DsReplicaSyncAll is complete. Both the <b>pErrInfo</b> and <b>pSync</b> members of the
    ///DS_REPSYNCALL_UPDATE structure are <b>NULL</b>. The return value of the callback function is ignored.
    DS_REPSYNCALL_EVENT_FINISHED       = 0x00000003,
}

///Specifies tasks that Knowledge Consistency Checker (KCC) can execute.
alias DS_KCC_TASKID = int;
enum : int
{
    ///Dynamically adjusts the data replication topology of a network.
    DS_KCC_TASKID_UPDATE_TOPOLOGY = 0x00000000,
}

///The <b>DS_REPL_INFO_TYPE</b> enumeration is used with the DsReplicaGetInfo and DsReplicaGetInfo2 functions to specify
///the type of replication data to retrieve.
alias DS_REPL_INFO_TYPE = int;
enum : int
{
    ///Requests replication state data for naming context and source server pairs. Returns a pointer to a
    ///DS_REPL_NEIGHBORS structure.
    DS_REPL_INFO_NEIGHBORS                   = 0x00000000,
    ///Requests replication state data with respect to all replicas of a given naming context. Returns a pointer to a
    ///DS_REPL_CURSORS structure.
    DS_REPL_INFO_CURSORS_FOR_NC              = 0x00000001,
    ///Requests replication state data for the attributes for the given object. Returns a pointer to a
    ///DS_REPL_OBJ_META_DATA structure.
    DS_REPL_INFO_METADATA_FOR_OBJ            = 0x00000002,
    ///Requests replication state data with respect to connection failures between inbound replication partners. Returns
    ///a pointer to a DS_REPL_KCC_DSA_FAILURES structure.
    DS_REPL_INFO_KCC_DSA_CONNECT_FAILURES    = 0x00000003,
    ///Requests replication state data with respect to link failures between inbound replication partners. Returns a
    ///pointer to a DS_REPL_KCC_DSA_FAILURES structure.
    DS_REPL_INFO_KCC_DSA_LINK_FAILURES       = 0x00000004,
    ///Requests the replication tasks currently executing or queued to execute. Returns a pointer to a
    ///DS_REPL_PENDING_OPS structure.
    DS_REPL_INFO_PENDING_OPS                 = 0x00000005,
    ///Requests replication state data for a specific attribute for the given object. Returns a pointer to a
    ///DS_REPL_ATTR_VALUE_META_DATA structure.
    DS_REPL_INFO_METADATA_FOR_ATTR_VALUE     = 0x00000006,
    ///Requests replication state data with respect to all replicas of a given naming context. Returns a pointer to a
    ///DS_REPL_CURSORS_2 structure.
    DS_REPL_INFO_CURSORS_2_FOR_NC            = 0x00000007,
    ///Requests replication state data with respect to all replicas of a given naming context. Returns a pointer to a
    ///DS_REPL_CURSORS_3 structure.
    DS_REPL_INFO_CURSORS_3_FOR_NC            = 0x00000008,
    ///Requests replication state data for the attributes for the given object. Returns a pointer to a
    ///DS_REPL_OBJ_META_DATA_2 structure.
    DS_REPL_INFO_METADATA_2_FOR_OBJ          = 0x00000009,
    ///Requests replication state data for a specific attribute for the given object. Returns a pointer to a
    ///DS_REPL_ATTR_VALUE_META_DATA_2 structure.
    DS_REPL_INFO_METADATA_2_FOR_ATTR_VALUE   = 0x0000000a,
    DS_REPL_INFO_METADATA_EXT_FOR_ATTR_VALUE = 0x0000000b,
    DS_REPL_INFO_TYPE_MAX                    = 0x0000000c,
}

///The <b>DS_REPL_OP_TYPE</b> enumeration type is used to indicate the type of replication operation that a given entry
///in the replication queue represents.
alias DS_REPL_OP_TYPE = int;
enum : int
{
    ///Indicates an inbound replication over an existing replication agreement from a direct replication partner.
    DS_REPL_OP_TYPE_SYNC        = 0x00000000,
    ///Indicates the addition of a replication agreement for a new direct replication partner.
    DS_REPL_OP_TYPE_ADD         = 0x00000001,
    ///Indicates the removal of a replication agreement for an existing direct replication partner.
    DS_REPL_OP_TYPE_DELETE      = 0x00000002,
    ///Indicates the modification of a replication agreement for an existing direct replication partner.
    DS_REPL_OP_TYPE_MODIFY      = 0x00000003,
    ///Indicates the addition, deletion, or update of outbound change notification data for a direct replication
    ///partner.
    DS_REPL_OP_TYPE_UPDATE_REFS = 0x00000004,
}

///The <b>DSROLE_MACHINE_ROLE</b> enumeration is used with the <b>MachineRole</b> member of the
///DSROLE_PRIMARY_DOMAIN_INFO_BASIC structure to specify the computer role.
alias DSROLE_MACHINE_ROLE = int;
enum : int
{
    ///The computer is a workstation that is not a member of a domain.
    DsRole_RoleStandaloneWorkstation   = 0x00000000,
    ///The computer is a workstation that is a member of a domain.
    DsRole_RoleMemberWorkstation       = 0x00000001,
    ///The computer is a server that is not a member of a domain.
    DsRole_RoleStandaloneServer        = 0x00000002,
    ///The computer is a server that is a member of a domain.
    DsRole_RoleMemberServer            = 0x00000003,
    ///The computer is a backup domain controller.
    DsRole_RoleBackupDomainController  = 0x00000004,
    ///The computer is a primary domain controller.
    DsRole_RolePrimaryDomainController = 0x00000005,
}

///The <b>DSROLE_SERVER_STATE</b> enumeration is used with the DSROLE_UPGRADE_STATUS_INFO structure to indicate the role
///of a server.
alias DSROLE_SERVER_STATE = int;
enum : int
{
    ///The server role is unknown.
    DsRoleServerUnknown = 0x00000000,
    ///The server was, or is, a primary domain controller.
    DsRoleServerPrimary = 0x00000001,
    ///The server was, or is, a backup domain controller.
    DsRoleServerBackup  = 0x00000002,
}

///The <b>DSROLE_PRIMARY_DOMAIN_INFO_LEVEL</b> enumeration is used with the DsRoleGetPrimaryDomainInformation function
///to specify the type of data to retrieve.
alias DSROLE_PRIMARY_DOMAIN_INFO_LEVEL = int;
enum : int
{
    ///The DsRoleGetPrimaryDomainInformation function retrieves data from a DSROLE_PRIMARY_DOMAIN_INFO_BASIC structure.
    DsRolePrimaryDomainInfoBasic = 0x00000001,
    ///The DsRoleGetPrimaryDomainInformation function retrieves from a DSROLE_UPGRADE_STATUS_INFO structure.
    DsRoleUpgradeStatus          = 0x00000002,
    ///The DsRoleGetPrimaryDomainInformation function retrieves data from a DSROLE_OPERATION_STATE_INFO structure.
    DsRoleOperationState         = 0x00000003,
}

///The <b>DSROLE_OPERATION_STATE</b> enumeration is used with the DSROLE_OPERATION_STATE_INFO structure to indicate the
///operational state of a computer.
alias DSROLE_OPERATION_STATE = int;
enum : int
{
    ///The computer is idle.
    DsRoleOperationIdle       = 0x00000000,
    ///The computer is active.
    DsRoleOperationActive     = 0x00000001,
    ///The computer requires a restart.
    DsRoleOperationNeedReboot = 0x00000002,
}

// Constants


enum GUID CLSID_DsObjectPicker = GUID("17d6ccd8-3b7b-11d2-b9e0-00c04fd8dbf7");

// Callbacks

///The <b>CQAddFormsProc</b> callback function is called by a query form extension to add a form to the query dialog
///box. A pointer to this function is supplied to the query form extension in the <i>pAddFormsProc</i> parameter of the
///IQueryForm::AddForms method. <b>CQAddFormsProc</b> is a placeholder for the query handler-defined function name.
///Params:
///    lParam = Contains a 32-bit value defined by the query handler. This value is passed to the query form extension as the
///             <i>lParam</i> parameter in the IQueryForm::AddForms call.
///    pForm = Pointer to a CQFORM structure that defines the form to add.
///Returns:
///    Returns an <b>HRESULT</b> value that indicates the success, or failure, of the form add operation. The following
///    list lists possible return values.
///    
alias LPCQADDFORMSPROC = HRESULT function(LPARAM lParam, CQFORM* pForm);
///The <b>CQAddPagesProc</b> callback function is called by a query form extension to add a page to a query form in the
///query dialog box. A pointer to this function is supplied to the query form extension in the <i>pAddPagesProc</i>
///parameter of the IQueryForm::AddPages method. <b>CQAddPagesProc</b> is a placeholder for the query handler-defined
///function name.
///Params:
///    lParam = Contains a 32-bit value defined by the query handler. This value is passed to the query form extension as the
///             <i>lParam</i> parameter in the IQueryForm::AddPages call.
///    clsidForm = Contains the <b>CLSID</b> of the form that the page should be added to. This member can contain the <b>CLSID</b>
///                of a custom query form or one of the system-supplied forms defined for the <b>clsidDefaultForm</b> member of the
///                OPENQUERYWINDOW structure.
///    pPage = Pointer to a CQPAGE structure that defines the page to be added.
///Returns:
///    Returns an <b>HRESULT</b> value that indicates the success or failure of the page add operation. The following
///    list lists possible return values.
///    
alias LPCQADDPAGESPROC = HRESULT function(LPARAM lParam, const(GUID)* clsidForm, CQPAGE* pPage);
///The <b>CQPageProc</b> callback function is called by the query dialog box to notify the query form extension of
///events that occur in a query page. A pointer to this function is supplied to the query dialog box in the
///<i>pPageProc</i> member of the CQPAGE structure. <b>CQPageProc</b> is a placeholder for the query form
///extension-defined function name.
///Params:
///    pPage = Pointer to a CQPAGE structure that contains data about a query page.
///    hwnd = Contains the window handle of the query page.
///    uMsg = Contains a value that identifies the event that this function is called for. This can be one of the Common Query
///           Page Messages.
///    wParam = Contains additional message data. The contents of this parameter depend on the value of the <i>uMsg</i>
///             parameter.
///    lParam = Contains additional message data. The content of this parameter depends on the value of the <i>uMsg</i>
///             parameter.
///Returns:
///    The return value is the result of the message and depends on the value of the <i>uMsg</i> parameter.
///    
alias LPCQPAGEPROC = HRESULT function(CQPAGE* pPage, HWND hwnd, uint uMsg, WPARAM wParam, LPARAM lParam);
///The <b>DSEnumAttributesCallback</b> function is an application-defined callback function that is called once for each
///attribute enumerated by the IDsDisplaySpecifier::EnumClassAttributes method. A pointer to this function is supplied
///as the <i>pcbEnum</i> parameter in <b>IDsDisplaySpecifier::EnumClassAttributes</b>. <b>DSEnumAttributesCallback</b>
///is a placeholder for the application-defined function name.
///Params:
///    lParam = Contains an application-defined parameter passed as the <i>lParam</i> parameter to the
///             IDsDisplaySpecifier::EnumClassAttributes method.
///    pszAttributeName = Pointer to a null-terminated Unicode string that contains the LDAP name of the attribute.
///    pszDisplayName = Pointer to a null-terminated Unicode string that contains the localized name of the attribute.
///    dwFlags = Contains a set of flags that define the behavior or state of the attribute. This can be zero or the following
///              value:
///Returns:
///    Returns <b>S_OK</b> to continue the enumeration or any failure code, such as <b>E_FAIL</b>, to terminate the
///    enumeration.
///    
alias LPDSENUMATTRIBUTES = HRESULT function(LPARAM lParam, const(PWSTR) pszAttributeName, 
                                            const(PWSTR) pszDisplayName, uint dwFlags);
///The <b>BFFCallBack</b> function is an application-defined callback function that receives event notifications from
///the Active Directory Domain Services container browser dialog box. A pointer to this function is supplied to the
///container browser dialog box in the <b>pfnCallback</b> member of the DSBROWSEINFO structure when the
///DsBrowseForContainer function is called. <b>BFFCallBack</b> is a placeholder for the application-defined function
///name.
///Params:
///    hwnd = Contains the window handle of the browse dialog box. This handle is used to send messages to the browse dialog
///           box using the SendMessage function. The container browser dialog box handles the following messages.
///    uMsg = Specifies one of the following browse messages.
///    lParam = The value and meaning of this parameter is determined by the notification received. For more information, see the
///             notification message descriptions under the <i>uMsg</i> parameter.
///    lpData = Contains a pointer to the DSBROWSEINFO structure passed to the DsBrowseForContainer function. This is true for
///             all notification messages.
alias BFFCALLBACK = int function(HWND hwnd, uint uMsg, LPARAM lParam, LPARAM lpData);

// Structs


///The <b>CQFORM</b> structure is used to define a query form added to the query dialog box with the CQAddFormsProc
///callback function.
struct CQFORM
{
    ///Contains the size, in bytes, of the structure.
    uint         cbStruct;
    ///Contains a set of flags that modify the behavior of the query form. This can be zero or a combination of one or
    ///more of the following values.
    uint         dwFlags;
    ///Contains the class identifier used to identify the query form.
    GUID         clsid;
    ///Contains the handle of the icon to be displayed with the query form.
    HICON        hIcon;
    ///Pointer to a null-terminated Unicode string that contains the title of the query form.
    const(PWSTR) pszTitle;
}

///The <b>CQPAGE</b> structure is used to define a query page added to a form in the query dialog box with the
///CQAddPagesProc callback function.
struct CQPAGE
{
    ///Contains the size, in bytes, of the structure.
    uint         cbStruct;
    ///Reserved. This member must be zero.
    uint         dwFlags;
    ///Pointer to a query page callback function defined by the query form extension. This callback function is used to
    ///notify the extension of events in the page and takes the form of the CQPageProc callback function.
    LPCQPAGEPROC pPageProc;
    ///Contains the instance handle of the module that contains the resources identified by the <b>idPageName</b> and
    ///<b>idPageTemplate</b> members.
    HINSTANCE    hInstance;
    ///Contains the identifier of the string resource in <b>hInstance</b> used for the page title.
    int          idPageName;
    ///Contains the identifier of the dialog resource in <b>hInstance</b> used for the page dialog.
    int          idPageTemplate;
    ///Pointer to the dialog box procedure. For more information, see DialogProc.
    DLGPROC      pDlgProc;
    ///An extension-defined 32-bit value passed in the <b>lParam</b> member of the <b>CQPAGE</b> structure passed as the
    ///<i>pPage</i> parameter in the CQPageProc callback function.
    LPARAM       lParam;
}

///The <b>OPENQUERYWINDOW</b> structure is used with the ICommonQuery::OpenQueryWindow method to initialize the
///directory service query dialog box.
struct OPENQUERYWINDOW
{
    ///Contains the size, in bytes, of the structure. This member is used for versioning and parameter validation and
    ///must be filled in before calling ICommonQuery::OpenQueryWindow.
    uint          cbStruct;
    ///Contains a set of flags that define the behavior of the directory service query dialog box. This can be zero or a
    ///combination of one or more of the values listed in the following list.
    uint          dwFlags;
    ///Contains a <b>CLSID</b> value that specifies the query handler to be used by the query dialog box. The value of
    ///this member also determines the type of structure pointed to by the <b>pHandlerParameters</b> member.
    GUID          clsidHandler;
    ///Pointer to a structure that contains data for the query handler. The type of structure pointed to by this member
    ///is defined by the <b>clsidHandler</b> member. The following list lists the possible types of structures based on
    ///the value of the <b>clsidHandler</b> member.
    void*         pHandlerParameters;
    ///Specifies the default form to be displayed in the query dialog box. This member is ignored if <b>dwFlags</b> does
    ///not contain <b>OQWF_DEFAULTFORM</b>. This member can contain the <b>CLSID</b> of a custom query form or one of
    ///the system-supplied forms.
    GUID          clsidDefaultForm;
    ///Pointer to an IPersistQuery interface used to store and retrieve query data. This data pertains to the query
    ///itself, not the results of the query. If <b>dwFlags</b> contains <b>OQWF_LOADQUERY</b>, the query data is
    ///obtained from this interface. If <b>dwFlags</b> contains <b>OQWF_SAVEQUERY</b>, the query data is saved to this
    ///interface.
    IPersistQuery pPersistQuery;
union
    {
        void*        pFormParameters;
        IPropertyBag ppbFormParameters;
    }
}

///The <b>ADS_OCTET_STRING</b> structure is an ADSI representation of the <b>Octet String</b> attribute syntax used in
///Active Directory.
struct ADS_OCTET_STRING
{
    ///The size, in bytes, of the character array.
    uint   dwLength;
    ///Pointer to an array of single byte characters not interpreted by the underlying directory.
    ubyte* lpValue;
}

///The <b>ADS_NT_SECURITY_DESCRIPTOR</b> structure defines the data type of the security descriptor for Windows.
struct ADS_NT_SECURITY_DESCRIPTOR
{
    ///The length data, in bytes.
    uint   dwLength;
    ///Pointer to the security descriptor, represented as a byte array.
    ubyte* lpValue;
}

///The <b>ADS_PROV_SPECIFIC</b> structure contains provider-specific data represented as a binary large object (BLOB).
struct ADS_PROV_SPECIFIC
{
    ///The size of the character array.
    uint   dwLength;
    ///A pointer to an array of bytes.
    ubyte* lpValue;
}

///The <b>ADS_CASEIGNORE_LIST</b> structure is an ADSI representation of the <b>Case Ignore List</b> attribute syntax.
struct ADS_CASEIGNORE_LIST
{
    ///Pointer to the next <b>ADS_CASEIGNORE_LIST</b> in the list of case-insensitive strings.
    ADS_CASEIGNORE_LIST* Next;
    ///The null-terminated Unicode string value of the current entry of the list.
    PWSTR                String;
}

///The <b>ADS_OCTET_LIST</b> structure is an ADSI representation of an ordered sequence of single-byte strings.
struct ADS_OCTET_LIST
{
    ///Pointer to the next <b>ADS_OCTET_LIST</b> entry in the list.
    ADS_OCTET_LIST* Next;
    ///Contains the length, in bytes, of the list.
    uint            Length;
    ///Pointer to an array of BYTEs that contains the list. The <b>Length</b> member of this structure contains the
    ///number of BYTEs in this array.
    ubyte*          Data;
}

///The <b>ADS_PATH</b> structure is an ADSI representation of the <b>Path</b> attribute syntax.
struct ADS_PATH
{
    ///Type of file in the file system.
    uint  Type;
    ///The null-terminated Unicode string that contains the name of an existing volume in the file system.
    PWSTR VolumeName;
    ///The null-terminated Unicode string that contains the path of a directory in the file system.
    PWSTR Path;
}

///The <b>ADS_POSTALADDRESS</b> structure is an ADSI representation of the <b>Postal Address</b> attribute.
struct ADS_POSTALADDRESS
{
    ///An array of six null-terminated Unicode strings that represent the postal address.
    ushort[6]* PostalAddress;
}

///The <b>ADS_TIMESTAMP</b> structure is an ADSI representation of the <b>Timestamp</b> attribute syntax.
struct ADS_TIMESTAMP
{
    ///Number of seconds, with zero value being equal to 12:00 AM, January, 1970, UTC.
    uint WholeSeconds;
    ///An event identifier, in the order of occurrence, within the period specified by <b>WholeSeconds</b>.
    uint EventID;
}

///The <b>ADS_BACKLINK</b> structure is an ADSI representation of the <b>Back Link</b> attribute syntax.
struct ADS_BACKLINK
{
    ///Identifier of the remote server that requires an external reference to the object specified by <b>ObjectName</b>.
    ///See below.
    uint  RemoteID;
    ///The null-terminated Unicode string that specifies the name of an object to which the <b>Back Link</b> attribute
    ///is attached.
    PWSTR ObjectName;
}

///The <b>ADS_TYPEDNAME</b> structure represents an ADSI representation of <b>Typed Name</b> attribute syntax.
struct ADS_TYPEDNAME
{
    ///The null-terminated Unicode string that contains an object name.
    PWSTR ObjectName;
    ///The priority associated with the object.
    uint  Level;
    ///The frequency of reference of the object.
    uint  Interval;
}

///The <b>ADS_HOLD</b> structure is an ADSI representation of the <b>Hold</b> attribute syntax.
struct ADS_HOLD
{
    ///The null-terminated Unicode string that contains the name of an object put on hold.
    PWSTR ObjectName;
    ///Number of charges that a server places against the user on hold while it verifies the user account balance.
    uint  Amount;
}

///The <b>ADS_NETADDRESS</b> structure is an ADSI representation of the <b>Net Address</b> attribute syntax.
struct ADS_NETADDRESS
{
    ///Types of communication protocols.
    uint   AddressType;
    ///Address length in bytes.
    uint   AddressLength;
    ///A network address.
    ubyte* Address;
}

///The <b>ADS_REPLICAPOINTER</b> structure represents an ADSI representation of the Replica Pointer attribute syntax.
struct ADS_REPLICAPOINTER
{
    ///The null-terminated Unicode string that contains the name of the name server that holds the replica.
    PWSTR           ServerName;
    ///Type of replica: master, secondary, or read-only.
    uint            ReplicaType;
    ///Replica identification number.
    uint            ReplicaNumber;
    ///The number of existing replicas.
    uint            Count;
    ///A network address that is a likely reference to a node leading to the name server.
    ADS_NETADDRESS* ReplicaAddressHints;
}

///The <b>ADS_FAXNUMBER</b> structure is an ADSI representation of the <b>Facsimile Telephone Number</b> attribute
///syntax.
struct ADS_FAXNUMBER
{
    ///The null-terminated Unicode string value that contains the telephone number of the facsimile (fax) machine.
    PWSTR  TelephoneNumber;
    ///The number of data bits.
    uint   NumberOfBits;
    ///Optional parameters for the fax machine.
    ubyte* Parameters;
}

///The <b>ADS_EMAIL</b> structure is an ADSI representation of the <b>EMail Address</b> attribute syntax.
struct ADS_EMAIL
{
    ///The null-terminated Unicode string that contains the user address.
    PWSTR Address;
    ///Type of the email message.
    uint  Type;
}

///The <b>ADS_DN_WITH_BINARY</b> structure is used with the ADSVALUE structure to contain a distinguished name attribute
///value that also contains binary data.
struct ADS_DN_WITH_BINARY
{
    ///Contains the length, in bytes, of the binary data in <b>lpBinaryValue</b>.
    uint   dwLength;
    ///Pointer to an array of bytes that contains the binary data for the attribute. The <b>dwLength</b> member contains
    ///the number of bytes in this array.
    ubyte* lpBinaryValue;
    ///Pointer to a null-terminated Unicode string that contains the distinguished name.
    PWSTR  pszDNString;
}

///The <b>ADS_DN_WITH_STRING</b> structure is used with the ADSVALUE structure to contain a distinguished name attribute
///value that also contains string data.
struct ADS_DN_WITH_STRING
{
    ///Pointer to a null-terminated Unicode string that contains the string value of the attribute.
    PWSTR pszStringValue;
    ///Pointer to a null-terminated Unicode string that contains the distinguished name.
    PWSTR pszDNString;
}

///The <b>ADSVALUE</b> structure contains a value specified as an ADSI data type. These data types can be ADSI Simple
///Data Types or ADSI-defined custom data types that include C-style structures. The ADS_ATTR_INFO structure contains an
///array of <b>ADSVALUE</b> structures. Each <b>ADSVALUE</b> structure contains a single attribute value.
struct ADSVALUE
{
    ///Data type used to interpret the union member of the structure. Values of this member are taken from the
    ///ADSTYPEENUM enumeration.
    ADSTYPEENUM dwType;
union
    {
        ushort*              DNString;
        ushort*              CaseExactString;
        ushort*              CaseIgnoreString;
        ushort*              PrintableString;
        ushort*              NumericString;
        uint                 Boolean;
        uint                 Integer;
        ADS_OCTET_STRING     OctetString;
        SYSTEMTIME           UTCTime;
        LARGE_INTEGER        LargeInteger;
        ushort*              ClassName;
        ADS_PROV_SPECIFIC    ProviderSpecific;
        ADS_CASEIGNORE_LIST* pCaseIgnoreList;
        ADS_OCTET_LIST*      pOctetList;
        ADS_PATH*            pPath;
        ADS_POSTALADDRESS*   pPostalAddress;
        ADS_TIMESTAMP        Timestamp;
        ADS_BACKLINK         BackLink;
        ADS_TYPEDNAME*       pTypedName;
        ADS_HOLD             Hold;
        ADS_NETADDRESS*      pNetAddress;
        ADS_REPLICAPOINTER*  pReplicaPointer;
        ADS_FAXNUMBER*       pFaxNumber;
        ADS_EMAIL            Email;
        ADS_NT_SECURITY_DESCRIPTOR SecurityDescriptor;
        ADS_DN_WITH_BINARY*  pDNWithBinary;
        ADS_DN_WITH_STRING*  pDNWithString;
    }
}

///The <b>ADS_ATTR_INFO</b> structure is used to contain one or more attribute values for use with the
///IDirectoryObject::CreateDSObject, IDirectoryObject::GetObjectAttributes, or IDirectoryObject::SetObjectAttributes
///method.
struct ADS_ATTR_INFO
{
    ///The null-terminated Unicode string that contains the attribute name.
    PWSTR       pszAttrName;
    ///Contains one of the ADSI Attribute Modification Types values that determines the type of operation to be
    ///performed on the attribute value.
    uint        dwControlCode;
    ///A value from the ADSTYPEENUM enumeration that indicates the data type of the attribute.
    ADSTYPEENUM dwADsType;
    ///Pointer to an array of ADSVALUE structures that contain values for the attribute.
    ADSVALUE*   pADsValues;
    ///Size of the <b>pADsValues</b> array.
    uint        dwNumValues;
}

///The <b>ADS_OBJECT_INFO</b> structure specifies the data, including the identity and location, of a directory service
///object.
struct ADS_OBJECT_INFO
{
    ///The null-terminated Unicode string that contains the relative distinguished name of the directory service object.
    PWSTR pszRDN;
    ///The null-terminated Unicode string that contains the distinguished name of the directory service object.
    PWSTR pszObjectDN;
    ///The null-terminated Unicode string that contains the distinguished name of the parent object.
    PWSTR pszParentDN;
    ///The null-terminated Unicode string that contains the distinguished name of the schema class of the object.
    PWSTR pszSchemaDN;
    ///The null-terminated Unicode string that contains the name of the class of which this object is an instance.
    PWSTR pszClassName;
}

///The <b>ADS_SEARCHPREF_INFO</b> structure specifies the query preferences.
struct ads_searchpref_info
{
    ///Contains one of the ADS_SEARCHPREF_ENUM enumeration values that specifies the search option to set.
    ADS_SEARCHPREF_ENUM dwSearchPref;
    ///Contains a ADSVALUE structure that specifies the data type and value of the search preference.
    ADSVALUE            vValue;
    ///Receives one of the ADS_STATUSENUM enumeration values that indicates the status of the search preference. The
    ///IDirectorySearch::SetSearchPreference method will fill in this member when it is called.
    ADS_STATUSENUM      dwStatus;
}

///The <b>ADS_SEARCH_COLUMN</b> structure specifies the contents of a search column in the query returned from the
///directory service database.
struct ads_search_column
{
    ///A null-terminated Unicode string that contains the name of the attribute whose values are contained in the
    ///current search column.
    PWSTR       pszAttrName;
    ///Value from the ADSTYPEENUM enumeration that indicates how the attribute values are interpreted.
    ADSTYPEENUM dwADsType;
    ///Array of ADSVALUE structures that contain values of the attribute in the current search column for the current
    ///row.
    ADSVALUE*   pADsValues;
    ///Size of the <b>pADsValues</b> array.
    uint        dwNumValues;
    ///Reserved for internal use by providers.
    HANDLE      hReserved;
}

///The <b>ADS_ATTR_DEF</b> structure is used only as a part of <b>IDirectorySchemaMgmt</b>, which is an obsolete
///interface. The following information is provided for legacy purposes only. The <b>ADS_ATTR_DEF</b> structure
///describes schema data for an attribute. It is used to manage attribute definitions in the schema.
struct ADS_ATTR_DEF
{
    ///The null-terminated Unicode string that contains the name of the attribute.
    PWSTR       pszAttrName;
    ///Data type of the attribute as defined by ADSTYPEENUM.
    ADSTYPEENUM dwADsType;
    ///Minimum legal range for this attribute.
    uint        dwMinRange;
    ///Maximum legal range for this attribute.
    uint        dwMaxRange;
    ///Whether or not this attribute takes more than one value.
    BOOL        fMultiValued;
}

///The <b>ADS_CLASS_DEF</b> structure is used only as a part of <b>IDirectorySchemaMgmt</b>, which is an obsolete
///interface. The information that follows is provided for legacy purposes only. The <b>ADS_CLASS_DEF</b> structure
///holds the definitions of an object class.
struct ADS_CLASS_DEF
{
    ///The null-terminated Unicode string that specifies the class name.
    PWSTR   pszClassName;
    ///The number of mandatory class attributes.
    uint    dwMandatoryAttrs;
    ///Pointer to an array of null-terminated Unicode strings that contain the names of the mandatory attributes.
    PWSTR*  ppszMandatoryAttrs;
    ///Number of optional attributes of the class.
    uint    optionalAttrs;
    ///Pointer to an array of null-terminated Unicode strings that contain the names of the optional attributes.
    PWSTR** ppszOptionalAttrs;
    ///Number of naming attributes.
    uint    dwNamingAttrs;
    ///Pointer to an array of null-terminated Unicode strings that contain the names of the naming attributes.
    PWSTR** ppszNamingAttrs;
    ///Number of super classes of an object of this class.
    uint    dwSuperClasses;
    ///Pointer to an array of null-terminated Unicode strings that contain the names of the super classes.
    PWSTR** ppszSuperClasses;
    ///Flags that indicate the object of the class is a container when it is <b>TRUE</b> and not a container when
    ///<b>FALSE</b>.
    BOOL    fIsContainer;
}

///The <b>ADS_SORTKEY</b> structure specifies how to sort a query.
struct ADS_SORTKEY
{
    ///The null-terminated Unicode string that contains the attribute type.
    PWSTR pszAttrType;
    ///Reserved.
    PWSTR pszReserved;
    ///Reverse the order of the sorted results.
    ubyte fReverseorder;
}

///The <b>ADS_VLV</b> structure contains metadata used to conduct virtual list view (VLV) searches. This structure
///serves two roles. First, it specifies the search preferences sent to the server. Second, it returns the VLV metadata
///from the server.
struct ADS_VLV
{
    ///Indicates the number of entries, before the target entry, that the client requests from the server.
    uint   dwBeforeCount;
    ///Indicates the number of entries, after the target entry, that the client requests from the server.
    uint   dwAfterCount;
    ///On input, indicates the target entry's requested offset within the list. If the client specifies an offset which
    ///equals the client's assumed content count, then the target is the last entry in the list. On output, indicates
    ///the server's best estimate as to the actual offset of the returned target entry's position in the list.
    uint   dwOffset;
    ///The input value represents the client's estimated value for the content count. The output value is the server's
    ///estimate of the content count. If the client sends a content count of zero, this means that the server must use
    ///its estimate of the content count in place of the client's.
    uint   dwContentCount;
    ///Optional. Null-terminated Unicode string that indicates the desired target entry requested by the client. If this
    ///parameter contains a non-<b>NULL</b> value, the server ignores the value specified in <b>dwOffset</b> and search
    ///for the first target entry whose value for the primary sort key is greater than or equal to the specified string,
    ///based on the sort order of the list.
    PWSTR  pszTarget;
    ///Optional. Parameter that indicates the length of the context identifier. On input, if passing a context
    ///identifier in <b>lpContextID</b>, this must be set to the size of the identifier in bytes. Otherwise, it must be
    ///set equal to zero. On output, if <b>lpContextID</b> contains a non-<b>NULL</b> value, this indicates the length,
    ///in bytes, of the context ID returned by the server.
    uint   dwContextIDLength;
    ///Optional. Indicates the server-generated context identifier. This parameter may be sent to clients. If a client
    ///receives this parameter, it should return it unchanged in a subsequent request which relates to the same list.
    ///This interaction may enhance the performance and effectiveness of the servers. If not passing a context
    ///identifier to the server, this member must be set to <b>NULL</b> value. On output, if this member contains a
    ///non-<b>NULL</b> value, this points to the context ID returned by the server.
    ubyte* lpContextID;
}

///The <b>DSOBJECT</b> structure contains directory object data. An array of this structure is provided in the
///<b>aObjects</b> member of the DSOBJECTNAMES structure.
struct DSOBJECT
{
    ///Contains a set of flags that provide object data. This can be zero or a combination of one, or more, of the
    ///following values.
    uint dwFlags;
    ///Contains a set of flags that provide data about the object provider. This can be zero or a combination of one or
    ///more of the following values.
    uint dwProviderFlags;
    ///Contains the offset, in bytes, from the start of the DSOBJECTNAMES structure to a NULL-terminated, Unicode string
    ///that contains the ADSPath of the object. The following code example shows how to use this member. ```cpp pwszName
    ///= (LPWSTR)((LPBYTE)pdsObjNames + pdsObjNames->aObjects[i].offsetName); ```
    uint offsetName;
    ///Contains the offset, in bytes, from the start of the DSOBJECTNAMES structure to a NULL-terminated, Unicode string
    ///that contains the class name of the object. Contains zero if the class name is unknown. The following code
    ///example shows how to use this member. ```cpp pwszClass = (LPWSTR)((LPBYTE)pdsObjNames +
    ///pdsObjNames->aObjects[i].offsetClass); ```
    uint offsetClass;
}

///The <b>DSOBJECTNAMES</b> structure is used to contain directory object data for use by an Active Directory property
///sheet or context menu extension.
struct DSOBJECTNAMES
{
    ///Contains the namespace identifier which indicates the origin of the namespace selection. The
    ///<b>CLSID_DsFolder</b> value (identical to <b>CLSID_MicrosoftDS</b>) is used to identify namespaces implemented by
    ///Active Directory Domain Services.
    GUID        clsidNamespace;
    ///Contains the number of elements in the <b>aObjects</b> array.
    uint        cItems;
    ///Contains an array of DSBOJECT structures. Each <b>DSBOJECT</b> structure represents a single directory object.
    ///The <b>cItems</b> member contains the number of elements in the array.
    DSOBJECT[1] aObjects;
}

///The <b>DSDISPLAYSPECOPTIONS</b> structure is returned by the CFSTR_DS_DISPLAY_SPEC_OPTIONS clipboard format and is
///used to supply data to a context menu or property page extension about the display specifiers used. It is important
///to specify the credentials required by the extension, to access data in the Active Directory server.
struct DSDISPLAYSPECOPTIONS
{
    ///The size of the structure for versioning purposes.
    uint dwSize;
    ///A set of flags that indicate data about the object and define the contents of the structure. This can be zero or
    ///a combination of one or more of the following values.
    uint dwFlags;
    ///Contains the offset, in bytes, from the start of the <b>DSDISPLAYSPECOPTIONS</b> structure to a NULL-terminated,
    ///Unicode string that contains the prefix of the display specifier that the created extension was obtained from.
    ///This string can be one of the following values.
    uint offsetAttribPrefix;
    ///Contains the offset, in bytes, from the start of the <b>DSDISPLAYSPECOPTIONS</b> structure to a NULL-terminated,
    ///Unicode string that contains the name of the user used to authenticate the bind. This member is only valid if
    ///<b>dwFlags</b> contains the <b>DSDSOF_HASUSERANDSERVERINFO</b> flag. If this member contains zero, the user name
    ///is not included. The following example shows how to use this member. ```cpp pwszUserName = (LPWSTR)((LPBYTE)pdso
    ///+ pdso->offsetUserName); ```
    uint offsetUserName;
    ///Contains the offset, in bytes, from the start of the <b>DSDISPLAYSPECOPTIONS</b> structure to a NULL-terminated,
    ///Unicode string that contains the password used to authenticate the bind. This member is only valid if
    ///<b>dwFlags</b> contains the <b>DSDSOF_HASUSERANDSERVERINFO</b> flag. If this member contains zero, the password
    ///is not included. The following example shows how to use this member. ```cpp pwszPassword = (LPWSTR)((LPBYTE)pdso
    ///+ pdso->offsetPassword); ```
    uint offsetPassword;
    ///Contains the offset, in bytes, from the start of the <b>DSDISPLAYSPECOPTIONS</b> structure to a NULL-terminated,
    ///Unicode string that contains the name of the server. This member is only valid if <b>dwFlags</b> contains the
    ///<b>DSDSOF_HASUSERANDSERVERINFO</b> flag. If this member contains zero, the server name is not included. The
    ///following example shows how to use this member. ```cpp pwszServer = (LPWSTR)((LPBYTE)pdso + pdso->offsetServer);
    ///```
    uint offsetServer;
    ///Contains the offset, in bytes, from the start of the <b>DSDISPLAYSPECOPTIONS</b> structure to a NULL-terminated,
    ///Unicode string that contains the ADsPath of the server. This member is only valid if <b>dwFlags</b> contains the
    ///<b>DSDSOF_HASUSERANDSERVERINFO</b> flag. If this member contains zero, the server path is not included. The
    ///following example shows how to use this member. ```cpp pwszServerConfigPath = (LPWSTR)((LPBYTE)pdso +
    ///pdso->offsetServerConfigPath); ```
    uint offsetServerConfigPath;
}

///The <b>DSPROPERTYPAGEINFO</b> structure is used by an Active Directory property sheet extension to obtain static
///registration data for the extension. This structure is supplied by the CFSTR_DSPROPERTYPAGEINFO clipboard format.
struct DSPROPERTYPAGEINFO
{
    ///Contains the offset, in bytes, from the start of the <b>DSPROPERTYPAGEINFO</b> structure to a NULL-terminated,
    ///Unicode string that contains the optional data stored for the extension.
    uint offsetString;
}

///The <b>DOMAINDESC</b> structure contains data about an element in a domain tree obtained with the
///IDsBrowseDomainTree::GetDomains method. This structure is contained in the DOMAINTREE structure.
struct DOMAINDESC
{
    ///Pointer to a Unicode string that contains the domain name.
    PWSTR       pszName;
    ///Pointer to a Unicode string that contains the path of the domain. Reserved.
    PWSTR       pszPath;
    ///Pointer to a Unicode string that contains the fully qualified name of the domain in the form "DC=myDom,
    ///DC=Fabrikam, DC=com". This member is blank if the <b>DBDTF_RETURNFQDN</b> flag is not set in the <i>dwFlags</i>
    ///parameter in IDsBrowseDomainTree::GetDomains.
    PWSTR       pszNCName;
    ///Pointer to a Unicode string that contains the name of the parent domain. This member is <b>NULL</b> if the domain
    ///has no parent.
    PWSTR       pszTrustParent;
    ///Pointer to a Unicode string that contains the object class name of the domain.
    PWSTR       pszObjectClass;
    ///Contains a set of flags that specify the attributes of the trust. For more information, and a list of possible
    ///values, see the <i>Flags</i> parameter of DsEnumerateDomainTrusts.
    uint        ulFlags;
    ///Contains a nonzero value if the domain is a down-level domain or zero otherwise.
    BOOL        fDownLevel;
    ///Contains a pointer to a <b>DOMAINDESC</b> structure that represents the first child of the domain. Obtain
    ///subsequent children by accessing the <b>pdNextSibling</b> member of the child structure. This member is
    ///<b>NULL</b> if the domain has no children.
    DOMAINDESC* pdChildList;
    ///Contains a pointer to a <b>DOMAINDESC</b> structure that represents the next sibling of the domain. Obtain
    ///subsequent siblings by accessing the <b>pdNextSibling</b> member of the sibling structure. This member is
    ///<b>NULL</b> if the domain has no siblings.
    DOMAINDESC* pdNextSibling;
}

///The <b>DOMAINTREE</b> structure contains data about a node in a domain tree obtained with the
///IDsBrowseDomainTree::GetDomains method. Each of the domains in the tree node are represented by a DOMAINDESC
///structure.
struct DOMAIN_TREE
{
    ///Contains the size, in bytes, of the <b>DOMAINTREE</b> structure and all DOMAINDESC structures in this
    ///<b>DOMAINTREE</b> structure.
    uint          dsSize;
    ///Contains the number of DOMAINDESC structures in the <b>aDomains</b> array.
    uint          dwCount;
    ///Contains an array of DOMAINDESC structures that represent the domains. The array does not contain any child or
    ///sibling relational data. The relational data is contained within the <b>DOMAINDESC</b> structures.
    DOMAINDESC[1] aDomains;
}

///The <b>DSCLASSCREATIONINFO</b> structure is used with the IDsDisplaySpecifier::GetClassCreationInfo method to hold
///data about the class creation wizard objects for an object class.
struct DSCLASSCREATIONINFO
{
    ///Contains a set of flags that indicate which members of this structure contain valid data. This can be a
    ///combination of one or more of the following values.
    uint    dwFlags;
    ///Contains the class identifier of the class creation wizard dialog box. This member is not used if <b>dwFlags</b>
    ///does not contain <b>DSCCIF_HASWIZARDDIALOG</b>.
    GUID    clsidWizardDialog;
    ///Contains the class identifier of the primary property page of the class creation wizard. This member is not used
    ///if <b>dwFlags</b> does not contain <b>DSCCIF_HASWIZARDPRIMARYPAGE</b>.
    GUID    clsidWizardPrimaryPage;
    ///Contains the number of elements in the <b>aWizardExtensions</b> array.
    uint    cWizardExtensions;
    ///Contains an array of the class identifiers of the property page extensions. <b>cWizardExtensions</b> specifies
    ///the number of elements in this array.
    GUID[1] aWizardExtensions;
}

///The <b>DSBROWSEINFO</b> structure is used with the DsBrowseForContainer function to supply and return data about the
///Active Directory container browser dialog box.
struct DSBROWSEINFOW
{
    ///Contains the size, in bytes, of the <b>DSBROWSEINFO</b> structure. This is used by the DsBrowseForContainer
    ///function for versioning purposes.
    uint         cbStruct;
    ///Handle of the window used as the parent of the container browser dialog box.
    HWND         hwndOwner;
    ///Pointer to a null-terminated string that contains the caption of the dialog box. If this member is <b>NULL</b>, a
    ///default caption is used.
    const(PWSTR) pszCaption;
    ///Pointer to a null-terminated string that contains additional text to be displayed in the dialog box above the
    ///tree control. If this member is <b>NULL</b>, no additional text is displayed.
    const(PWSTR) pszTitle;
    ///Pointer to a null-terminated Unicode string that contains the ADsPath of the container placed at the root of the
    ///dialog box. The user cannot navigate above this level using the dialog box.
    const(PWSTR) pszRoot;
    ///Pointer to a null-terminated Unicode string that receives the ADsPath of the container selected in the dialog.
    ///This string will always be null-terminated even if <b>cchPath</b> is not large enough to hold the entire path. If
    ///<b>dwFlags</b> contains the <b>DSBI_EXPANDONOPEN</b> flag, this member contains the ADsPath of the container that
    ///should be initially selected in the dialog box.
    PWSTR        pszPath;
    ///Contains the size, in <b>WCHAR</b> characters, of the <b>pszPath</b> buffer.
    uint         cchPath;
    ///Contains a set of flags that define the behavior of the dialog box. This can be zero or a combination of one or
    ///more of the following values.
    uint         dwFlags;
    ///Pointer to an application-defined BFFCallBack callback function that receives notifications from the container
    ///browser dialog box. Set this member to <b>NULL</b> if it is not used.
    BFFCALLBACK  pfnCallback;
    ///Contains an application-defined 32-bit value passed as the <i>lpData</i> parameter in all calls to
    ///<b>pfnCallback</b>. This member is ignored if <b>pfnCallback</b> is <b>NULL</b>.
    LPARAM       lParam;
    ///Contains one of the ADS_FORMAT_ENUM values that specifies the format that the ADSI path returned in
    ///<b>pszPath</b> will accept.
    uint         dwReturnFormat;
    ///Pointer to a Unicode string that contains the user name used for the credentials. This member is ignored if
    ///<b>dwFlags</b> does not have the <b>DSBI_HASCREDENTIALS</b> flag set. If this member is <b>NULL</b>, the
    ///currently logged on user name is used.
    const(PWSTR) pUserName;
    ///Pointer to a Unicode string that contains the password used for the credentials. This member is ignored if
    ///<b>dwFlags</b> does not have the <b>DSBI_HASCREDENTIALS</b> flag set. If this member is <b>NULL</b>, the password
    ///of the currently logged on user is used.
    const(PWSTR) pPassword;
    ///Pointer to a Unicode string buffer that receives the class string of the selected. This member is ignored if
    ///<b>dwFlags</b> does not have the <b>DSBI_RETURNOBJECTCLASS</b> flag set.
    PWSTR        pszObjectClass;
    ///Contains the size, in <b>WCHAR</b> characters, of the <b>pszObjectClass</b> buffer.
    uint         cchObjectClass;
}

///The <b>DSBROWSEINFO</b> structure is used with the DsBrowseForContainer function to supply and return data about the
///Active Directory container browser dialog box.
struct DSBROWSEINFOA
{
    ///Contains the size, in bytes, of the <b>DSBROWSEINFO</b> structure. This is used by the DsBrowseForContainer
    ///function for versioning purposes.
    uint         cbStruct;
    ///Handle of the window used as the parent of the container browser dialog box.
    HWND         hwndOwner;
    ///Pointer to a null-terminated string that contains the caption of the dialog box. If this member is <b>NULL</b>, a
    ///default caption is used.
    const(PSTR)  pszCaption;
    ///Pointer to a null-terminated string that contains additional text to be displayed in the dialog box above the
    ///tree control. If this member is <b>NULL</b>, no additional text is displayed.
    const(PSTR)  pszTitle;
    ///Pointer to a null-terminated Unicode string that contains the ADsPath of the container placed at the root of the
    ///dialog box. The user cannot navigate above this level using the dialog box.
    const(PWSTR) pszRoot;
    ///Pointer to a null-terminated Unicode string that receives the ADsPath of the container selected in the dialog.
    ///This string will always be null-terminated even if <b>cchPath</b> is not large enough to hold the entire path. If
    ///<b>dwFlags</b> contains the <b>DSBI_EXPANDONOPEN</b> flag, this member contains the ADsPath of the container that
    ///should be initially selected in the dialog box.
    PWSTR        pszPath;
    ///Contains the size, in <b>WCHAR</b> characters, of the <b>pszPath</b> buffer.
    uint         cchPath;
    ///Contains a set of flags that define the behavior of the dialog box. This can be zero or a combination of one or
    ///more of the following values.
    uint         dwFlags;
    ///Pointer to an application-defined BFFCallBack callback function that receives notifications from the container
    ///browser dialog box. Set this member to <b>NULL</b> if it is not used.
    BFFCALLBACK  pfnCallback;
    ///Contains an application-defined 32-bit value passed as the <i>lpData</i> parameter in all calls to
    ///<b>pfnCallback</b>. This member is ignored if <b>pfnCallback</b> is <b>NULL</b>.
    LPARAM       lParam;
    ///Contains one of the ADS_FORMAT_ENUM values that specifies the format that the ADSI path returned in
    ///<b>pszPath</b> will accept.
    uint         dwReturnFormat;
    ///Pointer to a Unicode string that contains the user name used for the credentials. This member is ignored if
    ///<b>dwFlags</b> does not have the <b>DSBI_HASCREDENTIALS</b> flag set. If this member is <b>NULL</b>, the
    ///currently logged on user name is used.
    const(PWSTR) pUserName;
    ///Pointer to a Unicode string that contains the password used for the credentials. This member is ignored if
    ///<b>dwFlags</b> does not have the <b>DSBI_HASCREDENTIALS</b> flag set. If this member is <b>NULL</b>, the password
    ///of the currently logged on user is used.
    const(PWSTR) pPassword;
    ///Pointer to a Unicode string buffer that receives the class string of the selected. This member is ignored if
    ///<b>dwFlags</b> does not have the <b>DSBI_RETURNOBJECTCLASS</b> flag set.
    PWSTR        pszObjectClass;
    ///Contains the size, in <b>WCHAR</b> characters, of the <b>pszObjectClass</b> buffer.
    uint         cchObjectClass;
}

///The <b>DSBITEM</b> structure contains data about an item in the Active Directory container browser dialog box. This
///structure is passed with the <b>DSBM_QUERYINSERT</b> notification to the BFFCallBack callback function. The container
///browser dialog box is created with the DsBrowseForContainer function.
struct DSBITEMW
{
    ///Contains the size, in bytes, of the structure.
    uint         cbStruct;
    ///Pointer to a null-terminated Unicode string that contains the ADsPath of the item.
    const(PWSTR) pszADsPath;
    ///Pointer to a null-terminated Unicode string that contains the object class name of the item.
    const(PWSTR) pszClass;
    ///Contains a set of flags that indicate which members of the structure contain valid data. This can be zero or a
    ///combination of one or more of the following values.
    uint         dwMask;
    ///Contains a set of flags that indicate the state of the item. This can be zero or a combination of one or more of
    ///the following values.
    uint         dwState;
    ///Contains a set of flags that indicate which flags in the <b>dwState</b> member contain valid data. This can be
    ///zero or a combination of one or more of the following values. For example, if <b>dwStateMask</b> has the
    ///<b>DSBS_HIDDEN</b> flag set and <b>dwState</b> does not have the <b>DSBS_HIDDEN</b> flag set, then the item is
    ///visible. If <b>dwStateMask</b> does not have the <b>DSBS_HIDDEN</b> flag set, then the <b>DSBS_HIDDEN</b> flag in
    ///<b>dwState</b> must be ignored.
    uint         dwStateMask;
    ///Pointer to a null-terminated string that contains the display name of the item. The display name of an item can
    ///be changed by copying the new display name into this member, setting the <b>DSBF_DISPLAYNAME</b> flag in the
    ///<b>dwMask</b> member, and returning a nonzero value from BFFCallBack.
    ushort[64]   szDisplayName;
    ///Pointer to a null-terminated string that contains the name of an .exe, .dll, or .ico file that contains the icon
    ///to display for the item. This can be any file type that can be passed to the ExtractIcon function. The index for
    ///this icon is specified in <b>iIconResID</b>. To modify the icon displayed for the item, copy the icon source file
    ///name into this member, set <b>iIconResID</b> to the zero-based index of the icon, set the
    ///<b>DSBF_ICONLOCATION</b> flag in the <b>dwMask</b> member, and return a nonzero value from BFFCallBack.
    ushort[260]  szIconLocation;
    ///Contains the zero-based index of the icon to display for the item. <div class="alert"><b>Note</b> This is not the
    ///resource identifier of the icon.</div> <div> </div>
    int          iIconResID;
}

///The <b>DSBITEM</b> structure contains data about an item in the Active Directory container browser dialog box. This
///structure is passed with the <b>DSBM_QUERYINSERT</b> notification to the BFFCallBack callback function. The container
///browser dialog box is created with the DsBrowseForContainer function.
struct DSBITEMA
{
    ///Contains the size, in bytes, of the structure.
    uint         cbStruct;
    ///Pointer to a null-terminated Unicode string that contains the ADsPath of the item.
    const(PWSTR) pszADsPath;
    ///Pointer to a null-terminated Unicode string that contains the object class name of the item.
    const(PWSTR) pszClass;
    ///Contains a set of flags that indicate which members of the structure contain valid data. This can be zero or a
    ///combination of one or more of the following values.
    uint         dwMask;
    ///Contains a set of flags that indicate the state of the item. This can be zero or a combination of one or more of
    ///the following values.
    uint         dwState;
    ///Contains a set of flags that indicate which flags in the <b>dwState</b> member contain valid data. This can be
    ///zero or a combination of one or more of the following values. For example, if <b>dwStateMask</b> has the
    ///<b>DSBS_HIDDEN</b> flag set and <b>dwState</b> does not have the <b>DSBS_HIDDEN</b> flag set, then the item is
    ///visible. If <b>dwStateMask</b> does not have the <b>DSBS_HIDDEN</b> flag set, then the <b>DSBS_HIDDEN</b> flag in
    ///<b>dwState</b> must be ignored.
    uint         dwStateMask;
    ///Pointer to a null-terminated string that contains the display name of the item. The display name of an item can
    ///be changed by copying the new display name into this member, setting the <b>DSBF_DISPLAYNAME</b> flag in the
    ///<b>dwMask</b> member, and returning a nonzero value from BFFCallBack.
    byte[64]     szDisplayName;
    ///Pointer to a null-terminated string that contains the name of an .exe, .dll, or .ico file that contains the icon
    ///to display for the item. This can be any file type that can be passed to the ExtractIcon function. The index for
    ///this icon is specified in <b>iIconResID</b>. To modify the icon displayed for the item, copy the icon source file
    ///name into this member, set <b>iIconResID</b> to the zero-based index of the icon, set the
    ///<b>DSBF_ICONLOCATION</b> flag in the <b>dwMask</b> member, and return a nonzero value from BFFCallBack.
    byte[260]    szIconLocation;
    ///Contains the zero-based index of the icon to display for the item. <div class="alert"><b>Note</b> This is not the
    ///resource identifier of the icon.</div> <div> </div>
    int          iIconResID;
}

///The <b>DSOP_UPLEVEL_FILTER_FLAGS</b> structure contains flags that indicate the filters to use for an up-level scope.
///An up-level scope is a scope that supports the ADSI LDAP provider. For more information, see ADSI LDAP Provider. This
///structure is contained in the DSOP_FILTER_FLAGS structure when calling IDsObjectPicker::Initialize.
struct DSOP_UPLEVEL_FILTER_FLAGS
{
    ///Filter flags to use for an up-level scope, regardless of whether it is a mixed or native mode domain. This member
    ///can be a combination of one or more of the following flags.
    uint flBothModes;
    ///Filter flags to use for an up-level domain in mixed mode. Mixed mode refers to an up-level domain that may have
    ///Windows NT 4.0 Backup Domain Controllers present. This member can be a combination of the flags listed in the
    ///<b>flBothModes</b> flags. The <b>DSOP_FILTER_UNIVERSAL_GROUPS_SE</b> flag has no affect in a mixed-mode domain
    ///because universal security groups do not exist in mixed mode domains.
    uint flMixedModeOnly;
    ///Filter flags to use for an up-level domain in native mode. Native mode refers to an up-level domain in which an
    ///administrator has enabled native mode operation. This member can be a combination of the flags listed in the
    ///<b>flBothModes</b> flags.
    uint flNativeModeOnly;
}

///The <b>DSOP_FILTER_FLAGS</b> structure contains flags that indicate the types of objects presented to the user for a
///specified scope or scopes. This structure is contained in the DSOP_SCOPE_INIT_INFO structure when calling
///IDsObjectPicker::Initialize.
struct DSOP_FILTER_FLAGS
{
    ///Contains a DSOP_UPLEVEL_FILTER_FLAGS structure that contains the filter flags to use for up-level scopes. An
    ///up-level scope is a scope that supports the ADSI LDAP provider. For more information, see ADSI LDAP Provider.
    DSOP_UPLEVEL_FILTER_FLAGS Uplevel;
    ///Contains the filter flags to use for down-level scopes. This member can be a combination of the following flags.
    uint flDownlevel;
}

///The <b>DSOP_SCOPE_INIT_INFO</b> structure describes one or more scope types that have the same attributes. A scope
///type is a type of location, for example a domain, computer, or Global Catalog, from which the user can select
///objects. This structure is used with DSOP_INIT_INFO when calling IDsObjectPicker::Initialize.
struct DSOP_SCOPE_INIT_INFO
{
    ///Contains the size, in bytes, of the structure.
    uint              cbSize;
    ///Flags that indicate the scope types described by this structure. You can combine multiple scope types if all
    ///specified scopes use the same settings. This member can be a combination of the following flags.
    uint              flType;
    ///Flags that indicate the format used to return ADsPath for objects selected from this scope. The <b>flScope</b>
    ///member can also indicate the initial scope displayed in the <b>Look in</b> drop-down list. This member can be a
    ///combination of the following flags. LDAP and Global Catalog (GC) paths can be converted to the WinNT ADsPath
    ///Syntax. GC paths can be converted to the LDAP format. WinNT objects having an objectSid attribute can be
    ///converted to the LDAP format if you specify the <b>DSOP_SCOPE_FLAG_WANT_SID_PATH</b> or
    ///<b>DSOP_SCOPE_FLAG_WANT_PROVIDER_LDAP</b> flags. No other conversions are legal.
    uint              flScope;
    ///Contains a DSOP_FILTER_FLAGS structure that indicates the types of objects presented to the user for this scope
    ///or scopes.
    DSOP_FILTER_FLAGS FilterFlags;
    ///Pointer to a null-terminated Unicode string that contains the name of a domain controller of the domain to which
    ///the target computer is joined. This member is used only if the <b>flType</b> member contains the
    ///<b>DSOP_SCOPE_TYPE_UPLEVEL_JOINED_DOMAIN</b> flag. If that flag is not set, <b>pwzDcName</b> must be <b>NULL</b>.
    ///This member can be <b>NULL</b> even if the <b>DSOP_SCOPE_TYPE_UPLEVEL_JOINED_DOMAIN</b> flag is specified, in
    ///which case, the dialog box looks up the domain controller. This member enables you to name a specific domain
    ///controller in a multimaster domain. For example, an administrative application might make changes on a domain
    ///controller in a multimaster domain, and then open the object picker dialog box before the changes have been
    ///replicated on the other domain controllers.
    const(PWSTR)      pwzDcName;
    ///Reserved; must be <b>NULL</b>.
    const(PWSTR)      pwzADsPath;
    ///Contains an <b>HRESULT</b> value that indicates the status of the specific scope. If the
    ///IDsObjectPicker::Initialize method successfully creates the scope, or scopes, specified by this structure,
    ///<b>hr</b> contains <b>S_OK</b>. Otherwise, <b>hr</b> contains an error code. If IDsObjectPicker::Initialize
    ///returns <b>S_OK</b>, the <b>hr</b> members of all the specified <b>DSOP_SCOPE_INIT_INFO</b> structures also
    ///contain <b>S_OK</b>.
    HRESULT           hr;
}

///The <b>DSOP_INIT_INFO</b> structure contains data required to initialize an object picker dialog box. This structure
///is used with the IDsObjectPicker::Initialize method.
struct DSOP_INIT_INFO
{
    ///Contains the size, in bytes, of the structure.
    uint         cbSize;
    ///Pointer to a null-terminated Unicode string that contains the name of the target computer. The dialog box
    ///operates as if it is running on the target computer, using the target computer to determine the joined domain and
    ///enterprise. If this value is <b>NULL</b>, the target computer is the local computer.
    const(PWSTR) pwzTargetComputer;
    ///Specifies the number of elements in the <b>aDsScopeInfos</b> array.
    uint         cDsScopeInfos;
    ///Pointer to an array of DSOP_SCOPE_INIT_INFO structures that describe the scopes from which the user can select
    ///objects. This member cannot be <b>NULL</b> and the array must contain at least one element because the object
    ///picker cannot operate without at least one scope.
    DSOP_SCOPE_INIT_INFO* aDsScopeInfos;
    ///Flags that determine the object picker options. This member can be zero or a combination of one or more of the
    ///following flags.
    uint         flOptions;
    ///Contains the number of elements in the <b>apwzAttributeNames</b> array. This member can be zero.
    uint         cAttributesToFetch;
    ///Pointer to an array of null-terminated Unicode strings that contain the names of the attributes to retrieve for
    ///each selected object. If <b>cAttributesToFetch</b> is zero, this member is ignored.
    PWSTR*       apwzAttributeNames;
}

///The <b>DS_SELECTION</b> structure contains data about an object the user selected from an object picker dialog box.
///The DS_SELECTION_LIST structure contains an array of <b>DS_SELECTION</b> structures.
struct DS_SELECTION
{
    ///Pointer to a null-terminated Unicode string that contains the object's relative distinguished name (RDN).
    PWSTR    pwzName;
    ///Pointer to a null-terminated Unicode string that contains the object's ADsPath. The format of this string depends
    ///on the flags specified in the <b>flScope</b> member of the DSOP_SCOPE_INIT_INFO structure for the scope from
    ///which this object was selected.
    PWSTR    pwzADsPath;
    ///Pointer to a null-terminated Unicode string that contains the value of the object's objectClass attribute.
    PWSTR    pwzClass;
    ///Pointer to a null-terminated Unicode string that contains the object's userPrincipalName attribute value. If the
    ///object does not have a userPrincipalName value, <b>pwzUPN</b> points to an empty string (L"").
    PWSTR    pwzUPN;
    ///Pointer to an array of VARIANT structures. Each <b>VARIANT</b> contains the value of an attribute of the selected
    ///object. The attributes retrieved are determined by the attribute names specified in the <b>apwzAttributeNames</b>
    ///member of the DSOP_INIT_INFO structure passed to the IDsObjectPicker::Initialize method. The order of attributes
    ///in the <b>pvarFetchedAttributes</b> array corresponds to the order of attribute names specified in the
    ///<b>apwzAttributeNames</b> array. The object picker dialog box may not be able to retrieve the requested
    ///attributes. If the attribute cannot be retrieved, the <b>vt</b> member of the VARIANT structure contains
    ///<b>VT_EMPTY</b>.
    VARIANT* pvarFetchedAttributes;
    ///Contains one, or more, of the <b>DSOP_SCOPE_TYPE_*</b> that indicate the type of scope from which this object was
    ///selected. For more information, and a list of <b>DSOP_SCOPE_TYPE_*</b> flags, see the <b>flType</b> member of the
    ///DSOP_SCOPE_INIT_INFO structure.
    uint     flScopeType;
}

///The <b>DS_SELECTION_LIST</b> structure contains data about the objects the user selected from an object picker dialog
///box. This structure is supplied by the IDataObject interface supplied by the IDsObjectPicker::InvokeDialog method in
///the CFSTR_DSOP_DS_SELECTION_LIST data format.
struct DS_SELECTION_LIST
{
    ///Contains the number of elements in the <b>aDsSelection</b> array.
    uint            cItems;
    ///Contains the number of elements returned in the <b>pvarFetchedAttributes</b> member of each DS_SELECTION
    ///structure.
    uint            cFetchedAttributes;
    ///Contains an array of DS_SELECTION structures, one for each object selected by the user. The <b>cItems</b> member
    ///indicates the number of elements in this array.
    DS_SELECTION[1] aDsSelection;
}

///The <b>DSQUERYINITPARAMS</b> structure describes the data used to initialize a browse dialog box in the directory
///service query.
struct DSQUERYINITPARAMS
{
    ///Contains the size, in bytes, of this structure.
    uint  cbStruct;
    ///Contains a set of flags that define the query behavior. This can be zero or a combination of one or more of the
    ///following values.
    uint  dwFlags;
    ///Pointer to a null-terminated Unicode string that contains the ADsPath of the default scope for the search. Set
    ///this member to <b>NULL</b> if no default search scope is specified.
    PWSTR pDefaultScope;
    ///Pointer to a null-terminated Unicode string that contains the default file system path where searches will be
    ///saved. This member is ignored if the <b>dwFlags</b> member does not contain <b>DSQPF_SAVELOCATION</b>.
    PWSTR pDefaultSaveLocation;
    ///Pointer to a null-terminated Unicode string that contains the user name in the valid domain notation, for
    ///example, "fabrikam\jeffsmith".
    PWSTR pUserName;
    ///Pointer to a null-terminated Unicode string that contains the password of the user specified by the
    ///<b>pUserName</b> member.
    PWSTR pPassword;
    ///Pointer to a null-terminated Unicode string that contains the name of the server from which the list of trusted
    ///domains is read. The list is used to populate the <b>In:</b> drop-down list in the dialog box.
    PWSTR pServer;
}

///The <b>DSCOLUMN</b> structure represents a column in the directory services query dialog box. An array of this
///structure is contained in the DSQUERYPARAMS structure.
struct DSCOLUMN
{
    ///Reserved.
    uint dwFlags;
    ///Contains one of the list view column formatting values that indicates how the column is displayed. The possible
    ///values are defined for the <b>fmt</b> member of the LVCOLUMN structure.
    int  fmt;
    ///Contains the width, in pixels, of the column.
    int  cx;
    ///Contains the string table identifier for the column header string. To retrieve this string, call LoadString with
    ///the <b>hInstance</b> member of the DSQUERYPARAMS structure and this member for the string identifier.
    int  idsName;
    ///Indicates the name of the attribute displayed in the column. This can be one of the following values.
    int  offsetProperty;
    ///Reserved.
    uint dwReserved;
}

///The <b>DSQUERYPARAMS</b> structure contains query data used by the directory service query when searching the
///directory service. This structure is provided by the CFSTR_DSQUERYPARAMS clipboard format by the IDataObject provided
///by the ICommonQuery::OpenQueryWindow method. The caller of <b>ICommonQuery::OpenQueryWindow</b> can use this to
///retrieve the filter, column data used by the result view when issuing a query against the server.
struct DSQUERYPARAMS
{
    ///Contains the size, in bytes, of the <b>DSQUERYPARAMS</b> structure. This member is used for versioning of the
    ///structure.
    uint        cbStruct;
    ///Reserved.
    uint        dwFlags;
    ///Contains an instance handle used for extracting resources.
    HINSTANCE   hInstance;
    ///Contains the offset, in bytes, from the address of this structure to a null-terminated Unicode string that
    ///contains the LDAP filter.
    int         offsetQuery;
    ///Contains the number of elements in the <b>aColumns</b> array.
    int         iColumns;
    ///Reserved.
    uint        dwReserved;
    ///Contains an array of DSCOLUMN structures that contain the results of the query. The <b>iColumns</b> member
    ///specifies the number of elements in this array.
    DSCOLUMN[1] aColumns;
}

///The <b>DSQUERYCLASSLIST</b> structure describes a list of classes against which a directory service query is made.
struct DSQUERYCLASSLIST
{
    ///Size, in bytes, of this structure.
    uint    cbStruct;
    ///Number of the classes in the array.
    int     cClasses;
    ///Offset to the class names of Unicode strings.
    uint[1] offsetClass;
}

///The <b>DSA_NEWOBJ_DISPINFO</b> structure is used with the IDsAdminNewObjExt::Initialize method to supply additional
///data about an Active Directory Domain Services object creation wizard.
struct DSA_NEWOBJ_DISPINFO
{
    ///Contains the size, in bytes, of the structure. This member is used for versioning purposes.
    uint  dwSize;
    ///Contains the handle of the class icon for the object created.
    HICON hObjClassIcon;
    ///Pointer to a null-terminated Unicode string that contains the title of the wizard.
    PWSTR lpszWizTitle;
    ///Pointer to a null-terminated Unicode string that contains the display name, or canonical name, of the container
    ///the object is created in.
    PWSTR lpszContDisplayName;
}

///The <b>ADSPROPINITPARAMS</b> structure is used with the ADsPropGetInitInfo function to obtain object data that a
///display specifier applies to.
struct ADSPROPINITPARAMS
{
    ///The size, in bytes, of the <b>ADSPROPINITPARAMS</b> structure. Set this value before calling ADsPropGetInitInfo.
    uint             dwSize;
    ///Reserved.
    uint             dwFlags;
    ///Contains an <b>HRESULT</b> value that specifies the result of the bind/get operation. If this value does not
    ///equal <b>S_OK</b>, then the remaining structure members are not initialized and should be ignored.
    HRESULT          hr;
    ///Pointer to an IDirectoryObject interface that represents the directory object that the display specifier applies
    ///to. Do not release this interface.
    IDirectoryObject pDsObj;
    ///Pointer to a null-terminated Unicode string that contains the common name of the directory object.
    PWSTR            pwzCN;
    ///Pointer to an ADS_ATTR_INFO structure that contains attribute data for the directory object.
    ADS_ATTR_INFO*   pWritableAttrs;
}

///The <b>ADSPROPERROR</b> structure is used to pass error data to the notification object with the
///ADsPropSendErrorMessage function or the WM_ADSPROP_NOTIFY_ERROR message.
struct ADSPROPERROR
{
    ///Contains the window handle of the property page that generated the error.
    HWND    hwndPage;
    ///Pointer to a NULL-terminated Unicode string that contains the title of the property page that generated the
    ///error.
    PWSTR   pszPageTitle;
    ///Pointer to a NULL-terminated Unicode string that contains the ADsPath of the directory object that the error
    ///occurred on.
    PWSTR   pszObjPath;
    ///Pointer to a NULL-terminated Unicode string that contains the class name of the directory object that the error
    ///occurred on.
    PWSTR   pszObjClass;
    ///Contains an <b>HRESULT</b> value that specifies the code of the error that occurred. If <i>hr</i> is not equal to
    ///<b>S_OK</b>, then <i>pszError</i> is ignored. If <i>hr</i>is equal to <b>S_OK</b>, then <i>pszError</i> contains
    ///an error message.
    HRESULT hr;
    ///Pointer to a NULL-terminated Unicode string that contains the error message to be displayed in the error dialog
    ///box. This member is ignored if <i>hr</i> is not equal to <b>S_OK</b>. In this case, the error dialog box will
    ///display a system-defined message for the error specified by <i>hr</i>.
    PWSTR   pszError;
}

///The <b>SCHEDULE_HEADER</b> structure is used to contain the replication schedule data for a replication source. The
///SCHEDULE structure contains an array of <b>SCHEDULE_HEADER</b> structures.
struct SCHEDULE_HEADER
{
    ///Contains one of the following values that defines the type of schedule data that is contained in this structure.
    uint Type;
    ///Contains the offset, in bytes, from the beginning of the SCHEDULE structure to the data for this schedule. The
    ///size and form of this data depends on the schedule type defined by the <b>Type</b> member.
    uint Offset;
}

///The <b>SCHEDULE</b> structure is a variable-length structure used with the DsReplicaAdd and DsReplicaModify functions
///to contain replication schedule data for a replication source.
struct SCHEDULE
{
    ///Contains the size, in bytes, of the <b>SCHEDULE</b> structure, including the size of all of the elements and data
    ///of the <b>Schedules</b> array.
    uint               Size;
    ///Not used.
    uint               Bandwidth;
    ///Contains the number of elements in the <b>Schedules</b> array.
    uint               NumberOfSchedules;
    ///Contains an array of SCHEDULE_HEADER structures that contain the replication schedule data for the replication
    ///source. The <b>NumberOfSchedules</b> member contains the number of elements in this array. Currently, this array
    ///can only contain one element.
    SCHEDULE_HEADER[1] Schedules;
}

///The <b>DS_NAME_RESULT_ITEM</b> structure contains a name converted by the DsCrackNames function, along with
///associated error and domain data.
struct DS_NAME_RESULT_ITEMA
{
    ///Contains one of the DS_NAME_ERROR values that indicates the status of this name conversion.
    uint status;
    ///Pointer to a null-terminated string that specifies the DNS domain in which the object resides. This member will
    ///contain valid data if <b>status</b> contains DS_NAME_NO_ERROR or <b>DS_NAME_ERROR_DOMAIN_ONLY</b>.
    PSTR pDomain;
    ///Pointer to a null-terminated string that specifies the newly formatted object name.
    PSTR pName;
}

///The <b>DS_NAME_RESULT</b> structure is used with the DsCrackNames function to contain the names converted by the
///function.
struct DS_NAME_RESULTA
{
    ///Contains the number of elements in the <b>rItems</b> array.
    uint cItems;
    ///Contains an array of DS_NAME_RESULT_ITEM structure pointers. Each element of this array represents a single
    ///converted name.
    DS_NAME_RESULT_ITEMA* rItems;
}

///The <b>DS_NAME_RESULT_ITEM</b> structure contains a name converted by the DsCrackNames function, along with
///associated error and domain data.
struct DS_NAME_RESULT_ITEMW
{
    ///Contains one of the DS_NAME_ERROR values that indicates the status of this name conversion.
    uint  status;
    ///Pointer to a null-terminated string that specifies the DNS domain in which the object resides. This member will
    ///contain valid data if <b>status</b> contains DS_NAME_NO_ERROR or <b>DS_NAME_ERROR_DOMAIN_ONLY</b>.
    PWSTR pDomain;
    ///Pointer to a null-terminated string that specifies the newly formatted object name.
    PWSTR pName;
}

///The <b>DS_NAME_RESULT</b> structure is used with the DsCrackNames function to contain the names converted by the
///function.
struct DS_NAME_RESULTW
{
    ///Contains the number of elements in the <b>rItems</b> array.
    uint cItems;
    ///Contains an array of DS_NAME_RESULT_ITEM structure pointers. Each element of this array represents a single
    ///converted name.
    DS_NAME_RESULT_ITEMW* rItems;
}

///The <b>DS_REPSYNCALL_SYNC</b> structure identifies a single replication operation performed between a source, and
///destination, server by the DsReplicaSyncAll function.
struct DS_REPSYNCALL_SYNCA
{
    ///Pointer to a null-terminated string that specifies the DNS GUID of the source server.
    PSTR  pszSrcId;
    ///Pointer to a null-terminated string that specifies the DNS GUID of the destination server.
    PSTR  pszDstId;
    PSTR  pszNC;
    GUID* pguidSrc;
    GUID* pguidDst;
}

///The <b>DS_REPSYNCALL_SYNC</b> structure identifies a single replication operation performed between a source, and
///destination, server by the DsReplicaSyncAll function.
struct DS_REPSYNCALL_SYNCW
{
    ///Pointer to a null-terminated string that specifies the DNS GUID of the source server.
    PWSTR pszSrcId;
    ///Pointer to a null-terminated string that specifies the DNS GUID of the destination server.
    PWSTR pszDstId;
    PWSTR pszNC;
    GUID* pguidSrc;
    GUID* pguidDst;
}

///The <b>DS_REPSYNCALL_ERRINFO</b> structure is used with the DS_REPSYNCALL_UPDATE structure to contain errors
///generated by the DsReplicaSyncAll function during replication.
struct DS_REPSYNCALL_ERRINFOA
{
    ///Pointer to a null-terminated string that contains the DNS GUID of the server where the error occurred.
    ///Alternatively, this member can contain the distinguished name of the server if
    ///<b>DS_REPSYNCALL_ID_SERVERS_BY_DN</b> is specified in the <i>ulFlags</i> parameter of the DsReplicaSyncAll
    ///function.
    PSTR                pszSvrId;
    ///Contains one of the DS_REPSYNCALL_ERROR values that indicates where in the replication process the error
    ///occurred.
    DS_REPSYNCALL_ERROR error;
    ///Indicates the actual Win32 error code generated during replication between the source server referred to by
    ///<b>pszSrcId</b> and the destination server referred to by <b>pszSvrId</b>.
    uint                dwWin32Err;
    ///Pointer to a null-terminated string that specifies the DNS GUID of the source server. Alternatively, this member
    ///can contain the distinguished name of the source server if <b>DS_REPSYNCALL_ID_SERVERS_BY_DN</b> is specified in
    ///the <i>ulFlags</i> parameter of the DsReplicaSyncAll function.
    PSTR                pszSrcId;
}

///The <b>DS_REPSYNCALL_ERRINFO</b> structure is used with the DS_REPSYNCALL_UPDATE structure to contain errors
///generated by the DsReplicaSyncAll function during replication.
struct DS_REPSYNCALL_ERRINFOW
{
    ///Pointer to a null-terminated string that contains the DNS GUID of the server where the error occurred.
    ///Alternatively, this member can contain the distinguished name of the server if
    ///<b>DS_REPSYNCALL_ID_SERVERS_BY_DN</b> is specified in the <i>ulFlags</i> parameter of the DsReplicaSyncAll
    ///function.
    PWSTR               pszSvrId;
    ///Contains one of the DS_REPSYNCALL_ERROR values that indicates where in the replication process the error
    ///occurred.
    DS_REPSYNCALL_ERROR error;
    ///Indicates the actual Win32 error code generated during replication between the source server referred to by
    ///<b>pszSrcId</b> and the destination server referred to by <b>pszSvrId</b>.
    uint                dwWin32Err;
    ///Pointer to a null-terminated string that specifies the DNS GUID of the source server. Alternatively, this member
    ///can contain the distinguished name of the source server if <b>DS_REPSYNCALL_ID_SERVERS_BY_DN</b> is specified in
    ///the <i>ulFlags</i> parameter of the DsReplicaSyncAll function.
    PWSTR               pszSrcId;
}

///The <b>DS_REPSYNCALL_UPDATE</b> structure contains status data about the replication performed by the
///DsReplicaSyncAll function. The <b>DsReplicaSyncAll</b> function passes this structure to a callback function in its
///<i>pFnCallBack</i> parameter. For more information about the callback function, see SyncUpdateProc.
struct DS_REPSYNCALL_UPDATEA
{
    ///Contains a DS_REPSYNCALL_EVENT value that describes the event which the <b>DS_REPSYNCALL_UPDATE</b> structure
    ///represents.
    DS_REPSYNCALL_EVENT  event;
    ///Pointer to a DS_REPSYNCALL_ERRINFO structure that contains error data about the replication performed by the
    ///DsReplicaSyncAll function.
    DS_REPSYNCALL_ERRINFOA* pErrInfo;
    ///Pointer to a DS_REPSYNCALL_SYNC structure that identifies the source and destination servers that have either
    ///initiated or finished synchronization.
    DS_REPSYNCALL_SYNCA* pSync;
}

///The <b>DS_REPSYNCALL_UPDATE</b> structure contains status data about the replication performed by the
///DsReplicaSyncAll function. The <b>DsReplicaSyncAll</b> function passes this structure to a callback function in its
///<i>pFnCallBack</i> parameter. For more information about the callback function, see SyncUpdateProc.
struct DS_REPSYNCALL_UPDATEW
{
    ///Contains a DS_REPSYNCALL_EVENT value that describes the event which the <b>DS_REPSYNCALL_UPDATE</b> structure
    ///represents.
    DS_REPSYNCALL_EVENT  event;
    ///Pointer to a DS_REPSYNCALL_ERRINFO structure that contains error data about the replication performed by the
    ///DsReplicaSyncAll function.
    DS_REPSYNCALL_ERRINFOW* pErrInfo;
    ///Pointer to a DS_REPSYNCALL_SYNC structure that identifies the source and destination servers that have either
    ///initiated or finished synchronization.
    DS_REPSYNCALL_SYNCW* pSync;
}

///The <b>DS_SITE_COST_INFO</b> structure is used with the DsQuerySitesByCost function to contain communication cost
///data.
struct DS_SITE_COST_INFO
{
    ///Contains a success or error code that indicates if the cost data for the site could be obtained. This member can
    ///contain one of the following values.
    uint errorCode;
    ///If the <b>errorCode</b> member contains <b>ERROR_SUCCESS</b>, this member contains the communication cost value
    ///of the site. If the <b>errorCode</b> member contains <b>ERROR_DS_OBJ_NOT_FOUND</b>, this contents of this member
    ///is undefined.
    uint cost;
}

///The <b>DS_SCHEMA_GUID_MAP</b> structure contains the results of a call to DsMapSchemaGuids. If DsMapSchemaGuids
///succeeds in mapping a GUID, <b>DS_SCHEMA_GUID_MAP</b> contains both the GUID and a display name for the object to
///which the GUID refers.
struct DS_SCHEMA_GUID_MAPA
{
    ///GUID structure that specifies the object GUID.
    GUID guid;
    ///Indicates the type of GUID mapped by DsMapSchemaGuids.
    uint guidType;
    ///Pointer to a null-terminated string value that specifies the display name associated with the GUID. This value
    ///may be <b>NULL</b> if DsMapSchemaGuids was unable to map the GUID to a display name.
    PSTR pName;
}

///The <b>DS_SCHEMA_GUID_MAP</b> structure contains the results of a call to DsMapSchemaGuids. If DsMapSchemaGuids
///succeeds in mapping a GUID, <b>DS_SCHEMA_GUID_MAP</b> contains both the GUID and a display name for the object to
///which the GUID refers.
struct DS_SCHEMA_GUID_MAPW
{
    ///GUID structure that specifies the object GUID.
    GUID  guid;
    ///Indicates the type of GUID mapped by DsMapSchemaGuids.
    uint  guidType;
    ///Pointer to a null-terminated string value that specifies the display name associated with the GUID. This value
    ///may be <b>NULL</b> if DsMapSchemaGuids was unable to map the GUID to a display name.
    PWSTR pName;
}

///The <b>DS_DOMAIN_CONTROLLER_INFO_1</b> structure contains data about a domain controller. This structure is returned
///by the DsGetDomainControllerInfo function.
struct DS_DOMAIN_CONTROLLER_INFO_1A
{
    ///Pointer to a null-terminated string that specifies the NetBIOS name of the domain controller.
    PSTR NetbiosName;
    ///Pointer to a null-terminated string that specifies the DNS host name of the domain controller.
    PSTR DnsHostName;
    ///Pointer to a null-terminated string that specifies the site to which the domain controller belongs.
    PSTR SiteName;
    ///Pointer to a null-terminated string that specifies the name of the computer object on the domain controller.
    PSTR ComputerObjectName;
    ///Pointer to a null-terminated string that specifies the name of the server object on the domain controller.
    PSTR ServerObjectName;
    ///A Boolean value that indicates whether or not this domain controller is the primary domain controller. If this
    ///value is <b>TRUE</b>, the domain controller is the primary domain controller; otherwise, the domain controller is
    ///not the primary domain controller.
    BOOL fIsPdc;
    ///A Boolean value that indicates whether or not the domain controller is enabled. If this value is <b>TRUE</b>, the
    ///domain controller is enabled; otherwise, it is not enabled.
    BOOL fDsEnabled;
}

///The <b>DS_DOMAIN_CONTROLLER_INFO_1</b> structure contains data about a domain controller. This structure is returned
///by the DsGetDomainControllerInfo function.
struct DS_DOMAIN_CONTROLLER_INFO_1W
{
    ///Pointer to a null-terminated string that specifies the NetBIOS name of the domain controller.
    PWSTR NetbiosName;
    ///Pointer to a null-terminated string that specifies the DNS host name of the domain controller.
    PWSTR DnsHostName;
    ///Pointer to a null-terminated string that specifies the site to which the domain controller belongs.
    PWSTR SiteName;
    ///Pointer to a null-terminated string that specifies the name of the computer object on the domain controller.
    PWSTR ComputerObjectName;
    ///Pointer to a null-terminated string that specifies the name of the server object on the domain controller.
    PWSTR ServerObjectName;
    ///A Boolean value that indicates whether or not this domain controller is the primary domain controller. If this
    ///value is <b>TRUE</b>, the domain controller is the primary domain controller; otherwise, the domain controller is
    ///not the primary domain controller.
    BOOL  fIsPdc;
    ///A Boolean value that indicates whether or not the domain controller is enabled. If this value is <b>TRUE</b>, the
    ///domain controller is enabled; otherwise, it is not enabled.
    BOOL  fDsEnabled;
}

///The <b>DS_DOMAIN_CONTROLLER_INFO_2</b> structure contains data about a domain controller. This structure is returned
///by the DsGetDomainControllerInfo function.
struct DS_DOMAIN_CONTROLLER_INFO_2A
{
    ///Pointer to a null-terminated string that specifies the NetBIOS name of the domain controller.
    PSTR NetbiosName;
    ///Pointer to a null-terminated string that specifies the DNS host name of the domain controller.
    PSTR DnsHostName;
    ///Pointer to a null-terminated string that specifies the site to which the domain controller belongs.
    PSTR SiteName;
    ///Pointer to a null-terminated string that specifies the name of the site object on the domain controller.
    PSTR SiteObjectName;
    ///Pointer to a null-terminated string that specifies the name of the computer object on the domain controller.
    PSTR ComputerObjectName;
    ///Pointer to a null-terminated string that specifies the name of the server object on the domain controller.
    PSTR ServerObjectName;
    ///Pointer to a null-terminated string that specifies the name of the NTDS DSA object on the domain controller.
    PSTR NtdsDsaObjectName;
    ///A Boolean value that indicates whether or not this domain controller is the primary domain controller. If this
    ///value is <b>TRUE</b>, the domain controller is the primary domain controller; otherwise, the domain controller is
    ///not the primary domain controller.
    BOOL fIsPdc;
    ///A Boolean value that indicates whether or not the domain controller is enabled. If this value is <b>TRUE</b>, the
    ///domain controller is enabled; otherwise, it is not enabled.
    BOOL fDsEnabled;
    ///A Boolean value that indicates whether or not the domain controller is global catalog server. If this value is
    ///<b>TRUE</b>, the domain controller is a global catalog server; otherwise, it is not a global catalog server.
    BOOL fIsGc;
    ///Contains the <b>GUID</b> for the site object on the domain controller.
    GUID SiteObjectGuid;
    ///Contains the <b>GUID</b> for the computer object on the domain controller.
    GUID ComputerObjectGuid;
    ///Contains the <b>GUID</b> for the server object on the domain controller.
    GUID ServerObjectGuid;
    ///Contains the <b>GUID</b> for the NTDS DSA object on the domain controller.
    GUID NtdsDsaObjectGuid;
}

///The <b>DS_DOMAIN_CONTROLLER_INFO_2</b> structure contains data about a domain controller. This structure is returned
///by the DsGetDomainControllerInfo function.
struct DS_DOMAIN_CONTROLLER_INFO_2W
{
    ///Pointer to a null-terminated string that specifies the NetBIOS name of the domain controller.
    PWSTR NetbiosName;
    ///Pointer to a null-terminated string that specifies the DNS host name of the domain controller.
    PWSTR DnsHostName;
    ///Pointer to a null-terminated string that specifies the site to which the domain controller belongs.
    PWSTR SiteName;
    ///Pointer to a null-terminated string that specifies the name of the site object on the domain controller.
    PWSTR SiteObjectName;
    ///Pointer to a null-terminated string that specifies the name of the computer object on the domain controller.
    PWSTR ComputerObjectName;
    ///Pointer to a null-terminated string that specifies the name of the server object on the domain controller.
    PWSTR ServerObjectName;
    ///Pointer to a null-terminated string that specifies the name of the NTDS DSA object on the domain controller.
    PWSTR NtdsDsaObjectName;
    ///A Boolean value that indicates whether or not this domain controller is the primary domain controller. If this
    ///value is <b>TRUE</b>, the domain controller is the primary domain controller; otherwise, the domain controller is
    ///not the primary domain controller.
    BOOL  fIsPdc;
    ///A Boolean value that indicates whether or not the domain controller is enabled. If this value is <b>TRUE</b>, the
    ///domain controller is enabled; otherwise, it is not enabled.
    BOOL  fDsEnabled;
    ///A Boolean value that indicates whether or not the domain controller is global catalog server. If this value is
    ///<b>TRUE</b>, the domain controller is a global catalog server; otherwise, it is not a global catalog server.
    BOOL  fIsGc;
    ///Contains the <b>GUID</b> for the site object on the domain controller.
    GUID  SiteObjectGuid;
    ///Contains the <b>GUID</b> for the computer object on the domain controller.
    GUID  ComputerObjectGuid;
    ///Contains the <b>GUID</b> for the server object on the domain controller.
    GUID  ServerObjectGuid;
    ///Contains the <b>GUID</b> for the NTDS DSA object on the domain controller.
    GUID  NtdsDsaObjectGuid;
}

///The <b>DS_DOMAIN_CONTROLLER_INFO_3</b> structure contains data about a domain controller. This structure is returned
///by the DsGetDomainControllerInfo function.
struct DS_DOMAIN_CONTROLLER_INFO_3A
{
    ///Pointer to a null-terminated string that specifies the NetBIOS name of the domain controller.
    PSTR NetbiosName;
    ///Pointer to a null-terminated string that specifies the DNS host name of the domain controller.
    PSTR DnsHostName;
    ///Pointer to a null-terminated string that specifies the site to which the domain controller belongs.
    PSTR SiteName;
    ///Pointer to a null-terminated string that specifies the name of the site object on the domain controller.
    PSTR SiteObjectName;
    ///Pointer to a null-terminated string that specifies the name of the computer object on the domain controller.
    PSTR ComputerObjectName;
    ///Pointer to a null-terminated string that specifies the name of the server object on the domain controller.
    PSTR ServerObjectName;
    ///Pointer to a null-terminated string that specifies the name of the NTDS DSA object on the domain controller.
    PSTR NtdsDsaObjectName;
    ///A Boolean value that indicates whether or not this domain controller is the primary domain controller. If this
    ///value is <b>TRUE</b>, the domain controller is the primary domain controller; otherwise, the domain controller is
    ///not the primary domain controller.
    BOOL fIsPdc;
    ///A Boolean value that indicates whether or not the domain controller is enabled. If this value is <b>TRUE</b>, the
    ///domain controller is enabled; otherwise, it is not enabled.
    BOOL fDsEnabled;
    ///A Boolean value that indicates whether or not the domain controller is global catalog server. If this value is
    ///<b>TRUE</b>, the domain controller is a global catalog server; otherwise, it is not a global catalog server.
    BOOL fIsGc;
    ///A Boolean value that indicates if the domain controller is a read-only domain controller. If this value is
    ///<b>TRUE</b>, the domain controller is a read-only domain controller; otherwise, it is not a read-only domain
    ///controller.
    BOOL fIsRodc;
    ///Contains the <b>GUID</b> for the site object on the domain controller.
    GUID SiteObjectGuid;
    ///Contains the <b>GUID</b> for the computer object on the domain controller.
    GUID ComputerObjectGuid;
    ///Contains the <b>GUID</b> for the server object on the domain controller.
    GUID ServerObjectGuid;
    ///Contains the <b>GUID</b> for the NTDS DSA object on the domain controller.
    GUID NtdsDsaObjectGuid;
}

///The <b>DS_DOMAIN_CONTROLLER_INFO_3</b> structure contains data about a domain controller. This structure is returned
///by the DsGetDomainControllerInfo function.
struct DS_DOMAIN_CONTROLLER_INFO_3W
{
    ///Pointer to a null-terminated string that specifies the NetBIOS name of the domain controller.
    PWSTR NetbiosName;
    ///Pointer to a null-terminated string that specifies the DNS host name of the domain controller.
    PWSTR DnsHostName;
    ///Pointer to a null-terminated string that specifies the site to which the domain controller belongs.
    PWSTR SiteName;
    ///Pointer to a null-terminated string that specifies the name of the site object on the domain controller.
    PWSTR SiteObjectName;
    ///Pointer to a null-terminated string that specifies the name of the computer object on the domain controller.
    PWSTR ComputerObjectName;
    ///Pointer to a null-terminated string that specifies the name of the server object on the domain controller.
    PWSTR ServerObjectName;
    ///Pointer to a null-terminated string that specifies the name of the NTDS DSA object on the domain controller.
    PWSTR NtdsDsaObjectName;
    ///A Boolean value that indicates whether or not this domain controller is the primary domain controller. If this
    ///value is <b>TRUE</b>, the domain controller is the primary domain controller; otherwise, the domain controller is
    ///not the primary domain controller.
    BOOL  fIsPdc;
    ///A Boolean value that indicates whether or not the domain controller is enabled. If this value is <b>TRUE</b>, the
    ///domain controller is enabled; otherwise, it is not enabled.
    BOOL  fDsEnabled;
    ///A Boolean value that indicates whether or not the domain controller is global catalog server. If this value is
    ///<b>TRUE</b>, the domain controller is a global catalog server; otherwise, it is not a global catalog server.
    BOOL  fIsGc;
    ///A Boolean value that indicates if the domain controller is a read-only domain controller. If this value is
    ///<b>TRUE</b>, the domain controller is a read-only domain controller; otherwise, it is not a read-only domain
    ///controller.
    BOOL  fIsRodc;
    ///Contains the <b>GUID</b> for the site object on the domain controller.
    GUID  SiteObjectGuid;
    ///Contains the <b>GUID</b> for the computer object on the domain controller.
    GUID  ComputerObjectGuid;
    ///Contains the <b>GUID</b> for the server object on the domain controller.
    GUID  ServerObjectGuid;
    ///Contains the <b>GUID</b> for the NTDS DSA object on the domain controller.
    GUID  NtdsDsaObjectGuid;
}

///The <b>DS_REPL_NEIGHBOR</b> structure contains inbound replication state data for a particular naming context and
///source server pair, as returned by the DsReplicaGetInfo and DsReplicaGetInfo2 functions.
struct DS_REPL_NEIGHBORW
{
    ///Pointer to a null-terminated string that contains the naming context to which this replication state data
    ///pertains. Each naming context is replicated independently and has different associated neighbor data, even if the
    ///naming contexts are replicated from the same source server.
    PWSTR    pszNamingContext;
    ///Pointer to a null-terminated string that contains the distinguished name of the directory service agent
    ///corresponding to the source server to which this replication state data pertains. Each source server has
    ///different associated neighbor data.
    PWSTR    pszSourceDsaDN;
    ///Pointer to a null-terminated string that contains the transport-specific network address of the source server.
    ///That is, a directory name service name for RPC/IP replication, or an SMTP address for an SMTP replication.
    PWSTR    pszSourceDsaAddress;
    ///Pointer to a null-terminated string that contains the distinguished name of the <b>interSiteTransport</b> object
    ///that corresponds to the transport over which replication is performed. This member contains <b>NULL</b> for
    ///RPC/IP replication.
    PWSTR    pszAsyncIntersiteTransportDN;
    ///Contains a set of flags that specify attributes and options for the replication data. This can be zero or a
    ///combination of one or more of the following flags.
    uint     dwReplicaFlags;
    ///Reserved for future use.
    uint     dwReserved;
    ///Contains the <b>objectGuid</b> of the naming context corresponding to <b>pszNamingContext</b>.
    GUID     uuidNamingContextObjGuid;
    ///Contains the <b>objectGuid</b> of the <b>nTDSDSA</b> object corresponding to <b>pszSourceDsaDN</b>.
    GUID     uuidSourceDsaObjGuid;
    ///Contains the invocation identifier used by the source server as of the last replication attempt.
    GUID     uuidSourceDsaInvocationID;
    ///Contains the <b>objectGuid</b> of the inter-site transport object corresponding to
    ///<b>pszAsyncIntersiteTransportDN</b>.
    GUID     uuidAsyncIntersiteTransportObjGuid;
    ///Contains the update sequence number of the last object update received.
    long     usnLastObjChangeSynced;
    ///Contains the <b>usnLastObjChangeSynced</b> value at the end of the last complete, successful replication cycle,
    ///or 0 if none. Attributes at the source last updated at a update sequence number less than or equal to this value
    ///have already been received and applied by the destination.
    long     usnAttributeFilter;
    ///Contains a FILETIME structure that contains the date and time the last successful replication cycle was completed
    ///from this source. All members of this structure are zero if the replication cycle has never been completed.
    FILETIME ftimeLastSyncSuccess;
    ///Contains a FILETIME structure that contains the date and time of the last replication attempt from this source.
    ///All members of this structure are zero if the replication has never been attempted.
    FILETIME ftimeLastSyncAttempt;
    ///Contains an error code associated with the last replication attempt from this source. Contains
    ///<b>ERROR_SUCCESS</b> if the last attempt succeeded.
    uint     dwLastSyncResult;
    ///Contains the number of failed replication attempts from this source since the last successful replication attempt
    ///- or since the source was added as a neighbor, if no previous attempt was successful.
    uint     cNumConsecutiveSyncFailures;
}

///The <b>DS_REPL_NEIGHBORW_BLOB</b> structure contains inbound replication state data for a particular naming context
///and source server pair. This structure is similar to the DS_REPL_NEIGHBOR structure, but is obtained from the
///Lightweight Directory Access Protocol API functions when obtaining binary data for the
///<b>msDS-NCReplInboundNeighbors</b> attribute.
struct DS_REPL_NEIGHBORW_BLOB
{
    ///Contains the offset, in bytes, from the address of this structure to a null-terminated Unicode string that
    ///contains the naming context to which this replication state data pertains. Each naming context is replicated
    ///independently and has different associated neighbor data, even if the naming contexts are replicated from the
    ///same source server.
    uint     oszNamingContext;
    ///Contains the offset, in bytes, from the address of this structure to a null-terminated Unicode string that
    ///contains the distinguished name of the directory service agent corresponding to the source server to which this
    ///replication state data pertains. Each source server has different associated neighbor data.
    uint     oszSourceDsaDN;
    ///Contains the offset, in bytes, from the address of this structure to a null-terminated Unicode string that
    ///contains the transport-specific network address of the source server. That is, a directory name service name for
    ///RPC/IP replication, or an SMTP address for an SMTP replication.
    uint     oszSourceDsaAddress;
    ///Contains the offset, in bytes, from the address of this structure to a null-terminated Unicode string that
    ///contains the distinguished name of the <b>interSiteTransport</b> object that corresponds to the transport over
    ///which replication is performed. This member contains <b>NULL</b> for RPC/IP replication.
    uint     oszAsyncIntersiteTransportDN;
    ///Contains a set of flags that specify attributes and options for the replication data. This can be zero or a
    ///combination of one or more of the following flags.
    uint     dwReplicaFlags;
    ///Reserved for future use.
    uint     dwReserved;
    ///Contains the <b>objectGuid</b> of the naming context that corresponds to <b>pszNamingContext</b>.
    GUID     uuidNamingContextObjGuid;
    ///Contains the <b>objectGuid</b> of the <b>nTDSDSA</b> object that corresponds to <b>pszSourceDsaDN</b>.
    GUID     uuidSourceDsaObjGuid;
    ///Contains the invocation identifier used by the source server as of the last replication attempt.
    GUID     uuidSourceDsaInvocationID;
    ///Contains the <b>objectGuid</b> of the inter-site transport object that corresponds to
    ///<b>pszAsyncIntersiteTransportDN</b>.
    GUID     uuidAsyncIntersiteTransportObjGuid;
    ///Contains the update sequence number of the last object update received.
    long     usnLastObjChangeSynced;
    ///Contains the <b>usnLastObjChangeSynced</b> value at the end of the last complete, successful replication cycle,
    ///or 0 if none. Attributes at the source last updated at a update sequence number less than or equal to this value
    ///have already been received and applied by the destination.
    long     usnAttributeFilter;
    ///Contains a FILETIME structure that contains the date and time the last successful replication cycle was completed
    ///from this source. All members of this structure are zero if the replication cycle has never been completed.
    FILETIME ftimeLastSyncSuccess;
    ///Contains a FILETIME structure that contains the date and time of the last replication attempt from this source.
    ///All members of this structure are zero if the replication has never been attempted.
    FILETIME ftimeLastSyncAttempt;
    ///Contains a Windows error code associated with the last replication attempt from this source. Contains
    ///<b>ERROR_SUCCESS</b> if the last attempt was successful.
    uint     dwLastSyncResult;
    ///Contains the number of failed replication attempts that have been made from this source since the last successful
    ///replication attempt or since the source was added as a neighbor, if no previous attempt succeeded.
    uint     cNumConsecutiveSyncFailures;
}

///The <b>DS_REPL_NEIGHBORS</b> structure is used with the DsReplicaGetInfo and DsReplicaGetInfo2 functions to provide
///inbound replication state data for naming context and source server pairs.
struct DS_REPL_NEIGHBORSW
{
    ///Contains the number of elements in the <b>rgNeighbor</b> array.
    uint                 cNumNeighbors;
    ///Reserved for future use.
    uint                 dwReserved;
    DS_REPL_NEIGHBORW[1] rgNeighbor;
}

///The <b>DS_REPL_CURSOR</b> structure contains inbound replication state data with respect to all replicas of a given
///naming context, as returned by the DsReplicaGetInfo and DsReplicaGetInfo2 functions.
struct DS_REPL_CURSOR
{
    ///Contains the invocation identifier of the originating server to which the <b>usnAttributeFilter</b> corresponds.
    GUID uuidSourceDsaInvocationID;
    ///Contains the maximum update sequence number to which the destination server can indicate that it has recorded all
    ///changes originated by the given server at update sequence numbers less than, or equal to, this update sequence
    ///number. This is used to filter changes at replication source servers that the destination server has already
    ///applied.
    long usnAttributeFilter;
}

///The <b>DS_REPL_CURSOR_2</b> structure contains inbound replication state data with respect to all replicas of a given
///naming context, as returned by the DsReplicaGetInfo2 function. This structure is an enhanced version of the
///DS_REPL_CURSOR structure.
struct DS_REPL_CURSOR_2
{
    ///Contains the invocation identifier of the originating server to which the <b>usnAttributeFilter</b> corresponds.
    GUID     uuidSourceDsaInvocationID;
    ///Contains the maximum update sequence number to which the destination server can indicate that it has recorded all
    ///changes originated by the given server at update sequence numbers less than, or equal to, this update sequence
    ///number. This is used to filter changes at replication source servers that the destination server has already
    ///applied.
    long     usnAttributeFilter;
    ///Contains a FILETIME structure that contains the date and time of the last successful synchronization operation.
    FILETIME ftimeLastSyncSuccess;
}

///The <b>DS_REPL_CURSOR_3</b> structure contains inbound replication state data with respect to all replicas of a given
///naming context, as returned by the DsReplicaGetInfo2 function. This structure is an enhanced version of the
///DS_REPL_CURSOR and DS_REPL_CURSOR_2 structures.
struct DS_REPL_CURSOR_3W
{
    ///Contains the invocation identifier of the originating server to which the <b>usnAttributeFilter</b> corresponds.
    GUID     uuidSourceDsaInvocationID;
    ///Contains the maximum update sequence number to which the destination server can indicate that it has recorded all
    ///changes originated by the given server at update sequence numbers less than, or equal to, this update sequence
    ///number. This is used to filter changes at replication source servers that the destination server has already
    ///applied.
    long     usnAttributeFilter;
    ///Contains a FILETIME structure that contains the date and time of the last successful synchronization operation.
    FILETIME ftimeLastSyncSuccess;
    ///Pointer to a null-terminated string that contains the distinguished name of the directory service agent that
    ///corresponds to the source server to which this replication state data applies.
    PWSTR    pszSourceDsaDN;
}

///The <b>DS_REPL_CURSOR_BLOB</b> structure contains inbound replication state data with respect to all replicas of a
///given naming context. This structure is similar to the DS_REPL_CURSOR_3 structure, but is obtained from the
///Lightweight Directory Access Protocol API functions when obtaining binary data for the <b>msDS-NCReplCursors</b>
///attribute.
struct DS_REPL_CURSOR_BLOB
{
    ///Contains the invocation identifier of the originating server to which the <b>usnAttributeFilter</b> corresponds.
    GUID     uuidSourceDsaInvocationID;
    ///Contains the maximum update sequence number to which the destination server can indicate that it has recorded all
    ///changes originated by the given server at update sequence numbers less than, or equal to, this update sequence
    ///number. This is used to filter changes at replication source servers that the destination server has already
    ///applied.
    long     usnAttributeFilter;
    ///Contains a FILETIME structure that contains the date and time of the last successful synchronization operation.
    FILETIME ftimeLastSyncSuccess;
    ///Contains the offset, in bytes, from the address of this structure to a null-terminated Unicode string that
    ///contains the distinguished name of the directory service agent that corresponds to the source server to which
    ///this replication state data applies.
    uint     oszSourceDsaDN;
}

///The <b>DS_REPL_CURSORS</b> structure is used with the DsReplicaGetInfo and DsReplicaGetInfo2 function to provide
///replication state data with respect to all replicas of a given naming context.
struct DS_REPL_CURSORS
{
    ///Contains the number of elements in the <b>rgCursor</b> array.
    uint              cNumCursors;
    ///Reserved for future use.
    uint              dwReserved;
    DS_REPL_CURSOR[1] rgCursor;
}

///The <b>DS_REPL_CURSORS_2</b> structure is used with the DsReplicaGetInfo2 function to provide replication state data
///with respect to all replicas of a given naming context.
struct DS_REPL_CURSORS_2
{
    ///Contains the number of elements in the <b>rgCursor</b> array.
    uint                cNumCursors;
    ///Contains the zero-based index of the next entry to retrieve if more entries are available. This value is passed
    ///for the <i>dwEnumerationContext</i> parameter in the next call to DsReplicaGetInfo2 to retrieve the next block of
    ///entries. If no more entries are available, this member contains -1.
    uint                dwEnumerationContext;
    DS_REPL_CURSOR_2[1] rgCursor;
}

///The <b>DS_REPL_CURSORS_3</b> structure is used with the DsReplicaGetInfo2 function to provide replication state data
///with respect to all replicas of a given naming context.
struct DS_REPL_CURSORS_3W
{
    ///Contains the number of elements in the <b>rgCursor</b> array.
    uint                 cNumCursors;
    ///Contains the zero-based index of the next entry to retrieve if more entries are available. This value is passed
    ///for the <i>dwEnumerationContext</i> parameter in the next call to DsReplicaGetInfo2 to retrieve the next block of
    ///entries. If no more entries are available, this member contains -1.
    uint                 dwEnumerationContext;
    DS_REPL_CURSOR_3W[1] rgCursor;
}

///The <b>DS_REPL_ATTR_META_DATA</b> structure is used with the DsReplicaGetInfo and DsReplicaGetInfo2 functions to
///contain replication state data for an object attribute.
struct DS_REPL_ATTR_META_DATA
{
    ///Pointer to a null-terminated Unicode string that contains the LDAP display name of the attribute corresponding to
    ///this metadata.
    PWSTR    pszAttributeName;
    ///Contains the version of this attribute. Each originating modification of the attribute increases this value by
    ///one. Replication of a modification does not affect the version.
    uint     dwVersion;
    ///Contains the time at which the last originating change was made to this attribute. Replication of the change does
    ///not affect this value.
    FILETIME ftimeLastOriginatingChange;
    ///Contains the invocation identification of the server on which the last change was made to this attribute.
    ///Replication of the change does not affect this value.
    GUID     uuidLastOriginatingDsaInvocationID;
    ///Contains the update sequence number (USN) on the originating server at which the last change to this attribute
    ///was made. Replication of the change does not affect this value.
    long     usnOriginatingChange;
    ///Contains the USN on the destination server (the server from which the DsReplicaGetInfo function retrieved the
    ///metadata) at which the last change to this attribute was applied. This value typically is different on all
    ///servers.
    long     usnLocalChange;
}

///The <b>DS_REPL_ATTR_META_DATA_2</b> structure is used with the DsReplicaGetInfo and DsReplicaGetInfo2 functions to
///contain replication state data for an object attribute.
struct DS_REPL_ATTR_META_DATA_2
{
    ///Pointer to a null-terminated Unicode string that contains the LDAP display name of the attribute that corresponds
    ///to this metadata.
    PWSTR    pszAttributeName;
    ///Contains the version of this attribute. Each originating modification of the attribute increases this value by
    ///one. Replication of a modification does not affect the version.
    uint     dwVersion;
    ///Contains the time at which the last originating change was made to this attribute. Replication of the change does
    ///not affect this value.
    FILETIME ftimeLastOriginatingChange;
    ///Contains the invocation identification of the server on which the last change was made to this attribute.
    ///Replication of the change does not affect this value.
    GUID     uuidLastOriginatingDsaInvocationID;
    ///Contains the update sequence number (USN) on the originating server at which the last change to this attribute
    ///was made. Replication of the change does not affect this value.
    long     usnOriginatingChange;
    ///Contains the USN on the destination server (the server from which the DsReplicaGetInfo function retrieved the
    ///metadata) at which the last change to this attribute was applied. This value typically is different on all
    ///servers.
    long     usnLocalChange;
    ///Pointer to a null-terminated Unicode string that contains the distinguished name of the directory system agent
    ///server that originated the last replication.
    PWSTR    pszLastOriginatingDsaDN;
}

///The <b>DS_REPL_ATTR_META_DATA_BLOB</b> structure is used to contain replication state data for an object attribute.
///This structure is similar to the DS_REPL_ATTR_META_DATA_2 structure, but is obtained from the Lightweight Directory
///Access Protocol API functions when obtaining binary data for the <b>msDS-ReplAttributeMetaData</b> attribute.
struct DS_REPL_ATTR_META_DATA_BLOB
{
    ///Contains the offset, in bytes, from the address of this structure to a null-terminated Unicode string that
    ///contains the LDAP display name of the attribute corresponding to this metadata. A value of zero indicates an
    ///empty or <b>NULL</b> string.
    uint     oszAttributeName;
    ///Contains the version of this attribute. Each originating modification of the attribute increases this value by
    ///one. Replication of a modification does not affect the version.
    uint     dwVersion;
    ///Contains the time at which the last originating change was made to this attribute. Replication of the change does
    ///not affect this value.
    FILETIME ftimeLastOriginatingChange;
    ///Contains the invocation identification of the server on which the last change was made to this attribute.
    ///Replication of the change does not affect this value.
    GUID     uuidLastOriginatingDsaInvocationID;
    ///Contains the update sequence number (USN) on the originating server at which the last change to this attribute
    ///was made. Replication of the change does not affect this value.
    long     usnOriginatingChange;
    ///Contains the USN on the destination server (the server from which the DsReplicaGetInfo function retrieved the
    ///metadata) at which the last change to this attribute was applied. This value typically is different on all
    ///servers.
    long     usnLocalChange;
    ///Contains the offset, in bytes, from the address of this structure to a null-terminated Unicode string that
    ///contains the distinguished name of the directory system agent server that originated the last replication. A
    ///value of zero indicates an empty or <b>NULL</b> string.
    uint     oszLastOriginatingDsaDN;
}

///The <b>DS_REPL_OBJ_META_DATA</b> structure contains an array of DS_REPL_ATTR_META_DATA structures. These structures
///contain replication state data for past and present attributes for a given object. The replication state data is
///returned from the DsReplicaGetInfo and DsReplicaGetInfo2 functions. The metadata records data about the last
///modification of a given object attribute.
struct DS_REPL_OBJ_META_DATA
{
    ///Contains the number of elements in the <b>rgMetaData</b> array.
    uint cNumEntries;
    ///Not used.
    uint dwReserved;
    DS_REPL_ATTR_META_DATA[1] rgMetaData;
}

///The <b>DS_REPL_OBJ_META_DATA_2</b> structure contains an array of DS_REPL_ATTR_META_DATA_2 structures, which in turn
///contain replication state data for the attributes (past and present) for a given object, as returned by the
///DsReplicaGetInfo2 function. This structure is an enhanced version of the DS_REPL_OBJ_META_DATA structure.
struct DS_REPL_OBJ_META_DATA_2
{
    ///Contains the number of elements in the <b>rgMetaData</b> array.
    uint cNumEntries;
    ///Not used.
    uint dwReserved;
    DS_REPL_ATTR_META_DATA_2[1] rgMetaData;
}

///The <b>DS_REPL_KCC_DSA_FAILURE</b> structure contains replication state data about a specific inbound replication
///partner, as returned by the DsReplicaGetInfo and DsReplicaGetInfo2 function. This state data is compiled and used by
///the Knowledge Consistency Checker (KCC) to decide when alternate replication routes must be added to account for
///unreachable servers.
struct DS_REPL_KCC_DSA_FAILUREW
{
    ///Pointer to a null-terminated string that contains the distinguished name of the directory system agent object in
    ///the directory that corresponds to the source server.
    PWSTR    pszDsaDN;
    ///Contains the <b>objectGuid</b> of the directory system agent object represented by the <b>pszDsaDN</b> member.
    GUID     uuidDsaObjGuid;
    ///Contains a FILETIME structure which the contents of depends on the value passed for the <i>InfoType</i> parameter
    ///when DsReplicaGetInfo or DsReplicaGetInfo2 function was called.
    FILETIME ftimeFirstFailure;
    ///Contains the number of consecutive failures since the last successful replication.
    uint     cNumFailures;
    ///Contains the error code associated with the most recent failure, or <b>ERROR_SUCCESS</b> if the specific error is
    ///unavailable.
    uint     dwLastResult;
}

///The <b>DS_REPL_KCC_DSA_FAILUREW_BLOB</b> structure contains replication state data with respect to a specific inbound
///replication partner. This state data is compiled and used by the Knowledge Consistency Checker (KCC) to decide when
///alternate replication routes must be added to account for unreachable servers. This structure is similar to the
///DS_REPL_KCC_DSA_FAILURE structure, but is obtained from the Lightweight Directory Access Protocol API functions when
///obtaining binary data for the <b>msDS-ReplConnectionFailures</b> or <b>msDS-ReplLinkFailures</b> attribute.
struct DS_REPL_KCC_DSA_FAILUREW_BLOB
{
    ///Contains the offset, in bytes, from the address of this structure to a null-terminated string that contains the
    ///distinguished name of the directory system agent object in the directory that corresponds to the source server.
    uint     oszDsaDN;
    ///Contains the <b>objectGuid</b> of the directory system agent object represented by the <b>oszDsaDN</b> member.
    GUID     uuidDsaObjGuid;
    ///Contains a FILETIME structure which the contents of depends on the requested binary replication data.
    FILETIME ftimeFirstFailure;
    ///Contains the number of consecutive failures since the last successful replication.
    uint     cNumFailures;
    ///Contains the error code associated with the most recent failure, or <b>ERROR_SUCCESS</b> if the specific error is
    ///unavailable.
    uint     dwLastResult;
}

///The <b>DS_REPL_KCC_DSA_FAILURES</b> structure contains an array of DS_REPL_KCC_DSA_FAILURE structures, which in turn
///contain replication state data with respect to inbound replication partners, as returned by the DsReplicaGetInfo and
///DsReplicaGetInfo2 functions.
struct DS_REPL_KCC_DSA_FAILURESW
{
    ///Contains the number of elements in the <b>rgMetaData</b> array.
    uint cNumEntries;
    ///Reserved for future use.
    uint dwReserved;
    DS_REPL_KCC_DSA_FAILUREW[1] rgDsaFailure;
}

///The <b>DS_REPL_OP</b> structure describes a replication task currently executing or pending execution, as returned by
///the DsReplicaGetInfo or DsReplicaGetInfo2 function.
struct DS_REPL_OPW
{
    ///Contains a FILETIME structure that contains the date and time that this operation was added to the queue.
    FILETIME        ftimeEnqueued;
    ///Contains the operation identifier. This value is unique in the startup routine of every computer. When the
    ///computer is restarted, the identifiers are no longer unique.
    uint            ulSerialNumber;
    ///Contains the priority value of this operation. Tasks with a higher priority value are executed first. The
    ///priority is calculated by the server based on the type of operation and its parameters.
    uint            ulPriority;
    ///Contains one of the DS_REPL_OP_TYPE values that indicate the type of operation that this structure represents.
    DS_REPL_OP_TYPE OpType;
    ///Zero or more bits, the interpretation of which depends on the <b>OpType</b>. For <b>DS_REPL_OP_TYPE_SYNC</b>, the
    ///bits should be interpreted as <b>DS_REPSYNC_*</b>. <b>ADD</b>, <b>DELETE</b>, <b>MODIFY</b>, and
    ///<b>UPDATE_REFS</b> use <b>DS_REPADD_*</b>, <b>DS_REPDEL_*</b>, <b>DS_REPMOD_*</b>, and <b>DS_REPUPD_*</b>. For
    ///more information and descriptions of these bits, see DsReplicaSync, DsReplicaAdd, DsReplicaDel, DsReplicaModify,
    ///and DsReplicaUpdateRefs. Contains a set of flags that provides additional data about the operation. The contents
    ///of this member is determined by the contents of the <b>OpType</b> member.
    uint            ulOptions;
    ///Pointer to a null-terminated string that contains the distinguished name of the naming context associated with
    ///this operation. For example, the naming context to be synchronized for <b>DS_REPL_OP_TYPE_SYNC</b>.
    PWSTR           pszNamingContext;
    ///Pointer to a null-terminated string that contains the distinguished name of the directory system agent object
    ///associated with the remote server corresponding to this operation. For example, the server from which to request
    ///changes for <b>DS_REPL_OP_TYPE_SYNC</b>. This can be <b>NULL</b>.
    PWSTR           pszDsaDN;
    ///Pointer to a null-terminated string that contains the transport-specific network address of the remote server
    ///associated with this operation. For example, the DNS or SMTP address of the server from which to request changes
    ///for <b>DS_REPL_OP_TYPE_SYNC</b>. This can be <b>NULL</b>.
    PWSTR           pszDsaAddress;
    ///Contains the <b>objectGuid</b> of the naming context identified by <b>pszNamingContext</b>.
    GUID            uuidNamingContextObjGuid;
    ///Contains the <b>objectGuid</b> of the directory system agent object identified by <b>pszDsaDN</b>.
    GUID            uuidDsaObjGuid;
}

///The <b>DS_REPL_OPW_BLOB</b> structure describes a replication task currently executing or pending execution. This
///structure is similar to the DS_REPL_OP structure, but is obtained from the Lightweight Directory Access Protocol API
///functions when obtaining binary data for the <b>msDS-ReplPendingOps</b> attribute.
struct DS_REPL_OPW_BLOB
{
    ///Contains a FILETIME structure that contains the date and time that this operation was added to the queue.
    FILETIME        ftimeEnqueued;
    ///Contains the identifier of the operation. This value is unique in the startup routine of every computer. When the
    ///computer is restarted, the identifiers are no longer unique.
    uint            ulSerialNumber;
    ///Contains the priority value of this operation. Tasks with a higher priority value are executed first. The
    ///priority is calculated by the server based on the type of operation and its parameters.
    uint            ulPriority;
    ///Contains one of the DS_REPL_OP_TYPE values that indicate the type of operation that this structure represents.
    DS_REPL_OP_TYPE OpType;
    ///Zero or more bits, the interpretation of which depends on the <b>OpType</b>. For <b>DS_REPL_OP_TYPE_SYNC</b>, the
    ///bits should be interpreted as <b>DS_REPSYNC_*</b>. <b>ADD</b>, <b>DELETE</b>, <b>MODIFY</b>, and
    ///<b>UPDATE_REFS</b> use <b>DS_REPADD_*</b>, <b>DS_REPDEL_*</b>, <b>DS_REPMOD_*</b>, and <b>DS_REPUPD_*</b>. For
    ///more information, and descriptions of these bits, see DsReplicaSync, DsReplicaAdd, DsReplicaDel, DsReplicaModify,
    ///and DsReplicaUpdateRefs. Contains a set of flags that provide additional data about the operation. The contents
    ///of this member is determined by the contents of the <b>OpType</b> member. This list describes the contents of the
    ///<i>ulOptions</i> parameter for each <i>OpType</i> value.
    uint            ulOptions;
    ///Contains the offset, in bytes, from the address of this structure to a null-terminated string that contains the
    ///distinguished name of the naming context associated with this operation. For example, the naming context to be
    ///synchronized for <b>DS_REPL_OP_TYPE_SYNC</b>.
    uint            oszNamingContext;
    ///Contains the offset, in bytes, from the address of this structure to a null-terminated string that contains the
    ///distinguished name of the directory system agent object associated with the remote server corresponding to this
    ///operation. For example, the server from which to ask for changes for <b>DS_REPL_OP_TYPE_SYNC</b>. This can be
    ///<b>NULL</b>.
    uint            oszDsaDN;
    ///Contains the offset, in bytes, from the address of this structure to a null-terminated string that contains the
    ///transport-specific network address of the remote server associated with this operation. For example, the DNS or
    ///SMTP address of the server from which to ask for changes for <b>DS_REPL_OP_TYPE_SYNC</b>. This can be
    ///<b>NULL</b>.
    uint            oszDsaAddress;
    ///Contains the <b>objectGuid</b> of the naming context identified by <b>pszNamingContext</b>.
    GUID            uuidNamingContextObjGuid;
    ///Contains the <b>objectGuid</b> of the directory system agent object identified by <b>pszDsaDN</b>.
    GUID            uuidDsaObjGuid;
}

///The <b>DS_REPL_PENDING_OPS</b> structure contains an array of DS_REPL_OP structures, which in turn describe the
///replication tasks currently executing and queued to execute, as returned by the DsReplicaGetInfo and
///DsReplicaGetInfo2 functions. The entries in the queue are processed in priority order, and the first entry is the one
///currently being executed.
struct DS_REPL_PENDING_OPSW
{
    ///Contains a FILETIME structure that contains the date and time at which the first operation in the queue began
    ///executing.
    FILETIME       ftimeCurrentOpStarted;
    ///Contains the number of elements in the <b>rgPendingOps</b> array.
    uint           cNumPendingOps;
    DS_REPL_OPW[1] rgPendingOp;
}

///The <b>DS_REPL_VALUE_META_DATA</b> structure is used with the DS_REPL_ATTR_VALUE_META_DATA structure to contain
///attribute value replication metadata.
struct DS_REPL_VALUE_META_DATA
{
    ///Pointer to a null-terminated Unicode string that contains the LDAP display name of the attribute corresponding to
    ///this metadata.
    PWSTR    pszAttributeName;
    ///Pointer to a null-terminated Unicode string that contains the distinguished name of the object that this
    ///attribute belongs to.
    PWSTR    pszObjectDn;
    ///Contains the number of bytes in the <b>pbData</b> array.
    uint     cbData;
    ubyte*   pbData;
    ///Contains a FILETIME structure that contains the time this attribute was deleted.
    FILETIME ftimeDeleted;
    ///Contains a FILETIME structure that contains the time this attribute was created.
    FILETIME ftimeCreated;
    ///Contains the version of this attribute. Each originating modification of the attribute increases this value by
    ///one. Replication of a modification does not affect the version.
    uint     dwVersion;
    ///Contains a FILETIME structure that contains the time at which the last originating change was made to this
    ///attribute. Replication of the change does not affect this value.
    FILETIME ftimeLastOriginatingChange;
    ///Contains the invocation identifier of the server on which the last change was made to this attribute. Replication
    ///of the change does not affect this value.
    GUID     uuidLastOriginatingDsaInvocationID;
    ///Contains the update sequence number (USN) on the originating server at which the last change to this attribute
    ///was made. Replication of the change does not affect this value.
    long     usnOriginatingChange;
    ///Contains the USN on the destination server, that is the server from which the DsReplicaGetInfo2 function
    ///retrieved the metadata, at which the last change to this attribute was applied. This value is typically different
    ///on all servers.
    long     usnLocalChange;
}

///The <b>DS_REPL_VALUE_META_DATA_2</b> structure is used with the DS_REPL_ATTR_VALUE_META_DATA_2 structure to contain
///attribute value replication metadata.
struct DS_REPL_VALUE_META_DATA_2
{
    ///Pointer to a null-terminated Unicode string that contains the LDAP display name of the attribute that corresponds
    ///to this metadata.
    PWSTR    pszAttributeName;
    ///Pointer to a null-terminated Unicode string that contains the distinguished name of the object that this
    ///attribute belongs to.
    PWSTR    pszObjectDn;
    ///Contains the number of bytes in the <b>pbData</b> array.
    uint     cbData;
    ubyte*   pbData;
    ///Contains a FILETIME structure that contains the time this attribute was deleted.
    FILETIME ftimeDeleted;
    ///Contains a FILETIME structure that contains the time this attribute was created.
    FILETIME ftimeCreated;
    ///Contains the version of this attribute. Each originating modification of the attribute increases this value by
    ///one. Replication of a modification does not affect the version.
    uint     dwVersion;
    ///Contains a FILETIME structure that contains the time at which the last originating change was made to this
    ///attribute. Replication of the change does not affect this value.
    FILETIME ftimeLastOriginatingChange;
    ///Contains the invocation identifier of the server on which the last change was made to this attribute. Replication
    ///of the change does not affect this value.
    GUID     uuidLastOriginatingDsaInvocationID;
    ///Contains the update sequence number (USN) on the originating server at which the last change to this attribute
    ///was made. Replication of the change does not affect this value.
    long     usnOriginatingChange;
    ///Contains the USN on the destination server, that is, the server from which the DsReplicaGetInfo2 function
    ///retrieved the metadata, at which the last change to this attribute was applied. This value is typically different
    ///on all servers.
    long     usnLocalChange;
    ///Pointer to a null-terminated Unicode string that contains the distinguished name of the directory system agent
    ///server that originated the last replication.
    PWSTR    pszLastOriginatingDsaDN;
}

///Contains attribute replication meta data for the DS_REPL_ATTR_VALUE_META_DATA_EXT structure.
struct DS_REPL_VALUE_META_DATA_EXT
{
    ///Pointer to a null-terminated Unicode string that contains the LDAP display name of the attribute corresponding to
    ///this metadata.
    PWSTR    pszAttributeName;
    ///Pointer to a null-terminated Unicode string that contains the distinguished name of the object that this
    ///attribute belongs to.
    PWSTR    pszObjectDn;
    ///Contains the number of bytes in the <b>pbData</b> array.
    uint     cbData;
    ubyte*   pbData;
    ///Contains a FILETIME structure that contains the time this attribute was deleted.
    FILETIME ftimeDeleted;
    ///Contains a FILETIME structure that contains the time this attribute was created.
    FILETIME ftimeCreated;
    ///Contains the version of this attribute. Each originating modification of the attribute increases this value by
    ///one. Replication of a modification does not affect the version.
    uint     dwVersion;
    ///Contains a FILETIME structure that contains the time at which the last originating change was made to this
    ///attribute. Replication of the change does not affect this value.
    FILETIME ftimeLastOriginatingChange;
    ///Contains the invocation identifier of the server on which the last change was made to this attribute. Replication
    ///of the change does not affect this value.
    GUID     uuidLastOriginatingDsaInvocationID;
    ///Contains the update sequence number (USN) on the originating server at which the last change to this attribute
    ///was made. Replication of the change does not affect this value.
    long     usnOriginatingChange;
    ///Contains the USN on the destination server, that is the server from which the DsReplicaGetInfo2 function
    ///retrieved the metadata, at which the last change to this attribute was applied. This value is typically different
    ///on all servers.
    long     usnLocalChange;
    ///Pointer to a null-terminated Unicode string that contains the distinguished name of the directory system agent
    ///server that originated the last replication.
    PWSTR    pszLastOriginatingDsaDN;
    ///TBD
    uint     dwUserIdentifier;
    ///TBD
    uint     dwPriorLinkState;
    uint     dwCurrentLinkState;
}

///The <b>DS_REPL_VALUE_META_DATA_BLOB</b> structure is used to contain attribute value replication metadata. This
///structure is similar to the DS_REPL_VALUE_META_DATA_2 structure, but is obtained from the Lightweight Directory
///Access Protocol API functions when obtaining binary data for the <b>msDS-ReplValueMetaData</b> attribute.
struct DS_REPL_VALUE_META_DATA_BLOB
{
    ///Contains the offset, in bytes, from the address of this structure to a null-terminated Unicode string that
    ///contains the LDAP display name of the attribute corresponding to this metadata. A value of zero indicates an
    ///empty or <b>NULL</b> string.
    uint     oszAttributeName;
    ///Contains the offset, in bytes, from the address of this structure to a null-terminated Unicode string that
    ///contains the distinguished name of the object that this attribute belongs to. A value of zero indicates an empty
    ///or <b>NULL</b> string.
    uint     oszObjectDn;
    ///Contains the number of bytes in the <b>pbData</b> array.
    uint     cbData;
    ///Pointer to a buffer that contains the attribute replication metadata. The <b>cbData</b> member contains the
    ///length, in bytes, of this buffer.
    uint     obData;
    ///Contains a FILETIME structure that contains the time that this attribute was deleted.
    FILETIME ftimeDeleted;
    ///Contains a FILETIME structure that contains the time that this attribute was created.
    FILETIME ftimeCreated;
    ///Contains the version of this attribute. Each originating modification of the attribute increases this value by
    ///one. Replication of a modification does not affect the version.
    uint     dwVersion;
    ///Contains a FILETIME structure that contains the time at which the last originating change was made to this
    ///attribute. Replication of the change does not affect this value.
    FILETIME ftimeLastOriginatingChange;
    ///Contains the invocation identifier of the server on which the last change was made to this attribute. Replication
    ///of the change does not affect this value.
    GUID     uuidLastOriginatingDsaInvocationID;
    ///Contains the update sequence number (USN) on the originating server at which the last change to this attribute
    ///was made. Replication of the change does not affect this value.
    long     usnOriginatingChange;
    ///Contains the USN on the destination server, that is, the server from which the DsReplicaGetInfo2 function
    ///retrieved the metadata, at which the last change to this attribute was applied. This value is typically different
    ///on all servers.
    long     usnLocalChange;
    ///Contains the offset, in bytes, from the address of this structure to a null-terminated Unicode string that
    ///contains the distinguished name of the directory system agent server that originated the last replication. A
    ///value of zero indicates an empty or <b>NULL</b> string.
    uint     oszLastOriginatingDsaDN;
}

///Contains attribute value replication metadata. This structure is similar to the DS_REPL_VALUE_META_DATA_EXT
///structure, but is obtained from the Lightweight Directory Access Protocol API functions when obtaining binary data
///for the <b>msDS-ReplValueMetaData</b> attribute.
struct DS_REPL_VALUE_META_DATA_BLOB_EXT
{
    ///Contains the offset, in bytes, from the address of this structure to a null-terminated Unicode string that
    ///contains the LDAP display name of the attribute corresponding to this metadata. A value of zero indicates an
    ///empty or <b>NULL</b> string.
    uint     oszAttributeName;
    ///Contains the offset, in bytes, from the address of this structure to a null-terminated Unicode string that
    ///contains the distinguished name of the object that this attribute belongs to. A value of zero indicates an empty
    ///or <b>NULL</b> string.
    uint     oszObjectDn;
    ///Contains the number of bytes in the <b>pbData</b> array.
    uint     cbData;
    ///Pointer to a buffer that contains the attribute replication metadata. The <b>cbData</b> member contains the
    ///length, in bytes, of this buffer.
    uint     obData;
    ///Contains a FILETIME structure that contains the time that this attribute was deleted.
    FILETIME ftimeDeleted;
    ///Contains a FILETIME structure that contains the time that this attribute was created.
    FILETIME ftimeCreated;
    ///Contains the version of this attribute. Each originating modification of the attribute increases this value by
    ///one. Replication of a modification does not affect the version.
    uint     dwVersion;
    ///Contains a FILETIME structure that contains the time at which the last originating change was made to this
    ///attribute. Replication of the change does not affect this value.
    FILETIME ftimeLastOriginatingChange;
    ///Contains the invocation identifier of the server on which the last change was made to this attribute. Replication
    ///of the change does not affect this value.
    GUID     uuidLastOriginatingDsaInvocationID;
    ///Contains the update sequence number (USN) on the originating server at which the last change to this attribute
    ///was made. Replication of the change does not affect this value.
    long     usnOriginatingChange;
    ///Contains the USN on the destination server, that is, the server from which the DsReplicaGetInfo2 function
    ///retrieved the metadata, at which the last change to this attribute was applied. This value is typically different
    ///on all servers.
    long     usnLocalChange;
    ///Contains the offset, in bytes, from the address of this structure to a null-terminated Unicode string that
    ///contains the distinguished name of the directory system agent server that originated the last replication. A
    ///value of zero indicates an empty or <b>NULL</b> string.
    uint     oszLastOriginatingDsaDN;
    ///TBD
    uint     dwUserIdentifier;
    ///TBD
    uint     dwPriorLinkState;
    ///TBD
    uint     dwCurrentLinkState;
}

///The <b>DS_REPL_ATTR_VALUE_META_DATA</b> structure is used with the DsReplicaGetInfo2 function to provide metadata for
///a collection of attribute values.
struct DS_REPL_ATTR_VALUE_META_DATA
{
    ///Contains the number of elements in the <b>rgMetaData</b> array.
    uint cNumEntries;
    ///Contains the zero-based index of the next entry to retrieve if more entries are available. This value is passed
    ///for the <i>dwEnumerationContext</i> parameter in the next call to DsReplicaGetInfo2 to retrieve the next block of
    ///entries. If no more entries are available, this member contains -1.
    uint dwEnumerationContext;
    DS_REPL_VALUE_META_DATA[1] rgMetaData;
}

///The <b>DS_REPL_ATTR_VALUE_META_DATA_2</b> structure is used with the DsReplicaGetInfo2 function to provide metadata
///for a collection of attribute values.
struct DS_REPL_ATTR_VALUE_META_DATA_2
{
    ///Contains the number of elements in the <b>rgMetaData</b> array.
    uint cNumEntries;
    ///Contains the zero-based index of the next entry to retrieve if more entries are available. This value is passed
    ///for the <i>dwEnumerationContext</i> parameter in the next call to DsReplicaGetInfo2 to retrieve the next block of
    ///entries. If no more entries are available, this member contains -1.
    uint dwEnumerationContext;
    DS_REPL_VALUE_META_DATA_2[1] rgMetaData;
}

///Provides metadata for a collection of attribute replication values.
struct DS_REPL_ATTR_VALUE_META_DATA_EXT
{
    ///The number of elements in the <b>rgMetaData</b> array.
    uint cNumEntries;
    ///The zero-based index of the next entry to retrieve if more entries are available. This value is passed for the
    ///<i>dwEnumerationContext</i> parameter in the next call to DsReplicaGetInfo2 to retrieve the next block of
    ///entries. If no more entries are available, this member contains -1.
    uint dwEnumerationContext;
    DS_REPL_VALUE_META_DATA_EXT[1] rgMetaData;
}

///The <b>DS_REPL_QUEUE_STATISTICSW</b> structure is used to contain replication queue statistics. Reserved. Obtain this
///data using the DS_REPL_QUEUE_STATISTICSW_BLOB structure with the Lightweight Directory Access Protocol API functions
///to obtain binary data for the <b>msDS-ReplQueueStatistics</b> attribute.
struct DS_REPL_QUEUE_STATISTICSW
{
    ///Contains a FILETIME structure that contains the date and time that the currently running operation started.
    FILETIME ftimeCurrentOpStarted;
    ///Contains the number of currently pending operations.
    uint     cNumPendingOps;
    ///Contains a FILETIME structure that contains the date and time of the oldest synchronization operation.
    FILETIME ftimeOldestSync;
    ///Contains a FILETIME structure that contains the date and time of the oldest add operation.
    FILETIME ftimeOldestAdd;
    ///Contains a FILETIME structure that contains the date and time of the oldest modification operation.
    FILETIME ftimeOldestMod;
    ///Contains a FILETIME structure that contains the date and time of the oldest delete operation.
    FILETIME ftimeOldestDel;
    ///Contains a FILETIME structure that contains the date and time of the oldest reference update operation.
    FILETIME ftimeOldestUpdRefs;
}

///The <b>DSROLE_PRIMARY_DOMAIN_INFO_BASIC</b> structure is used with the DsRoleGetPrimaryDomainInformation function to
///contain domain data.
struct DSROLE_PRIMARY_DOMAIN_INFO_BASIC
{
    ///Contains one of the DSROLE_MACHINE_ROLE values that specifies the role of the computer.
    DSROLE_MACHINE_ROLE MachineRole;
    ///Contains a set of flags that provide additional domain data. This can be a combination of one or more of the
    ///following values.
    uint                Flags;
    ///Pointer to a null-terminated Unicode string that contains the NetBIOS domain name.
    PWSTR               DomainNameFlat;
    ///Pointer to a null-terminated Unicode string that contains the DNS domain name. This member is optional and may be
    ///<b>NULL</b>.
    PWSTR               DomainNameDns;
    ///Pointer to a null-terminated Unicode string that contains the forest name. This member is optional and may be
    ///<b>NULL</b>.
    PWSTR               DomainForestName;
    ///Contains the domain identifier. This member is valid only if the <b>Flags</b> member contains the
    ///<b>DSROLE_PRIMARY_DOMAIN_GUID_PRESENT</b> flag.
    GUID                DomainGuid;
}

///The <b>DSROLE_UPGRADE_STATUS_INFO</b> structure is used with the DsRoleGetPrimaryDomainInformation function to
///contain domain upgrade status data.
struct DSROLE_UPGRADE_STATUS_INFO
{
    ///Specifies the current state of the upgrade. This member can be one of the following values.
    uint                OperationState;
    ///If an upgrade is in progress, this member contains one of the DSROLE_SERVER_STATE values that indicate the
    ///previous role of the server.
    DSROLE_SERVER_STATE PreviousServerState;
}

///The <b>DSROLE_OPERATION_STATE_INFO</b> structure is used with the DsRoleGetPrimaryDomainInformation function to
///contain the operational state data for a computer.
struct DSROLE_OPERATION_STATE_INFO
{
    ///Contains one of the DSROLE_OPERATION_STATE values that indicates the computer operational state.
    DSROLE_OPERATION_STATE OperationState;
}

///The <b>DOMAIN_CONTROLLER_INFO</b> structure is used with the DsGetDcName function to receive data about a domain
///controller.
struct DOMAIN_CONTROLLER_INFOA
{
    ///Pointer to a null-terminated string that specifies the computer name of the discovered domain controller. The
    ///returned computer name is prefixed with "\\". The DNS-style name, for example, "\\phoenix.fabrikam.com", is
    ///returned, if available. If the DNS-style name is not available, the flat-style name (for example, "\\phoenix") is
    ///returned. This example would apply if the domain is a Windows NT 4.0 domain or if the domain does not support the
    ///IP family of protocols.
    PSTR DomainControllerName;
    ///Pointer to a null-terminated string that specifies the address of the discovered domain controller. The address
    ///is prefixed with "\\". This string is one of the types defined by the <b>DomainControllerAddressType</b> member.
    PSTR DomainControllerAddress;
    ///Indicates the type of string that is contained in the <b>DomainControllerAddress</b> member. This can be one of
    ///the following values.
    uint DomainControllerAddressType;
    ///The <b>GUID</b> of the domain. This member is zero if the domain controller does not have a Domain GUID; for
    ///example, the domain controller is not a Windows 2000 domain controller.
    GUID DomainGuid;
    ///Pointer to a null-terminated string that specifies the name of the domain. The DNS-style name, for example,
    ///"fabrikam.com", is returned if available. Otherwise, the flat-style name, for example, "fabrikam", is returned.
    ///This name may be different than the requested domain name if the domain has been renamed.
    PSTR DomainName;
    ///Pointer to a null-terminated string that specifies the name of the domain at the root of the DS tree. The
    ///DNS-style name, for example, "fabrikam.com", is returned if available. Otherwise, the flat-style name, for
    ///example, "fabrikam" is returned.
    PSTR DnsForestName;
    ///Contains a set of flags that describe the domain controller. This can be zero or a combination of one or more of
    ///the following values.
    uint Flags;
    ///Pointer to a null-terminated string that specifies the name of the site where the domain controller is located.
    ///This member may be <b>NULL</b> if the domain controller is not in a site; for example, the domain controller is a
    ///Windows NT 4.0 domain controller.
    PSTR DcSiteName;
    ///Pointer to a null-terminated string that specifies the name of the site that the computer belongs to. The
    ///computer is specified in the <i>ComputerName</i> parameter passed to DsGetDcName. This member may be <b>NULL</b>
    ///if the site that contains the computer cannot be found; for example, if the DS administrator has not associated
    ///the subnet that the computer is in with a valid site.
    PSTR ClientSiteName;
}

///The <b>DOMAIN_CONTROLLER_INFO</b> structure is used with the DsGetDcName function to receive data about a domain
///controller.
struct DOMAIN_CONTROLLER_INFOW
{
    PWSTR DomainControllerName;
    PWSTR DomainControllerAddress;
    ///Indicates the type of string that is contained in the <b>DomainControllerAddress</b> member. This can be one of
    ///the following values.
    uint  DomainControllerAddressType;
    ///The <b>GUID</b> of the domain. This member is zero if the domain controller does not have a Domain GUID; for
    ///example, the domain controller is not a Windows 2000 domain controller.
    GUID  DomainGuid;
    PWSTR DomainName;
    PWSTR DnsForestName;
    ///Contains a set of flags that describe the domain controller. This can be zero or a combination of one or more of
    ///the following values.
    uint  Flags;
    PWSTR DcSiteName;
    PWSTR ClientSiteName;
}

///The <b>DS_DOMAIN_TRUSTS</b> structure is used with the DsEnumerateDomainTrusts function to contain trust data for a
///domain.
struct DS_DOMAIN_TRUSTSW
{
    PWSTR NetbiosDomainName;
    PWSTR DnsDomainName;
    ///Contains a set of flags that specify more data about the domain trust. This can be zero or a combination of one
    ///or more of the following values.
    uint  Flags;
    ///Contains the index in the <i>Domains</i> array returned by the DsEnumerateDomainTrusts function that corresponds
    ///to the parent domain of the domain represented by this structure. This member is only valid if the all of the
    ///following conditions are met: <ul> <li>The <b>DS_DOMAIN_IN_FOREST</b> flag was specified in the <i>Flags</i>
    ///parameter of the DsEnumerateDomainTrusts function.</li> <li>The <b>Flags</b> member of this structure does not
    ///contain the <b>DS_DOMAIN_TREE_ROOT</b> flag.</li> </ul>
    uint  ParentIndex;
    ///Contains a value that indicates the type of trust represented by this structure. Possible values for this member
    ///are documented in the <b>TrustType</b> member of the TRUSTED_DOMAIN_INFORMATION_EX structure.
    uint  TrustType;
    ///Contains a value that indicates the attributes of the trust represented by this structure. Possible values for
    ///this member are documented in the <b>TrustAttribute</b> member of the TRUSTED_DOMAIN_INFORMATION_EX structure.
    uint  TrustAttributes;
    ///Contains the security identifier of the domain represented by this structure.
    void* DomainSid;
    ///Contains the GUID of the domain represented by this structure.
    GUID  DomainGuid;
}

///The <b>DS_DOMAIN_TRUSTS</b> structure is used with the DsEnumerateDomainTrusts function to contain trust data for a
///domain.
struct DS_DOMAIN_TRUSTSA
{
    ///Pointer to a null-terminated string that contains the NetBIOS name of the domain.
    PSTR  NetbiosDomainName;
    ///Pointer to a null-terminated string that contains the DNS name of the domain. This member may be <b>NULL</b>.
    PSTR  DnsDomainName;
    ///Contains a set of flags that specify more data about the domain trust. This can be zero or a combination of one
    ///or more of the following values.
    uint  Flags;
    ///Contains the index in the <i>Domains</i> array returned by the DsEnumerateDomainTrusts function that corresponds
    ///to the parent domain of the domain represented by this structure. This member is only valid if the all of the
    ///following conditions are met: <ul> <li>The <b>DS_DOMAIN_IN_FOREST</b> flag was specified in the <i>Flags</i>
    ///parameter of the DsEnumerateDomainTrusts function.</li> <li>The <b>Flags</b> member of this structure does not
    ///contain the <b>DS_DOMAIN_TREE_ROOT</b> flag.</li> </ul>
    uint  ParentIndex;
    ///Contains a value that indicates the type of trust represented by this structure. Possible values for this member
    ///are documented in the <b>TrustType</b> member of the TRUSTED_DOMAIN_INFORMATION_EX structure.
    uint  TrustType;
    ///Contains a value that indicates the attributes of the trust represented by this structure. Possible values for
    ///this member are documented in the <b>TrustAttribute</b> member of the TRUSTED_DOMAIN_INFORMATION_EX structure.
    uint  TrustAttributes;
    ///Contains the security identifier of the domain represented by this structure.
    void* DomainSid;
    ///Contains the GUID of the domain represented by this structure.
    GUID  DomainGuid;
}

@RAIIFree!DsGetDcCloseW
struct GetDcContextHandle
{
    ptrdiff_t Value;
}

// Functions

///The <b>ADsGetObject</b> function binds to an object given its path and a specified interface identifier.
///Params:
///    lpszPathName = Type: <b>LPCWSTR</b> The null-terminated Unicode string that specifies the path used to bind to the object in the
///                   underlying directory service. For more information and code examples for binding strings for this parameter, see
///                   LDAP ADsPath and WinNT ADsPath.
///    riid = Type: <b>REFIID</b> Interface identifier for a specified interface on this object.
///    ppObject = Type: <b>VOID**</b> Pointer to a pointer to the requested Interface.
///Returns:
///    Type: <b>HRESULT</b> This method supports the standard <b>HRESULT</b> return values, as well as the following.
///    For more information about other return values, see ADSI Error Codes.
///    
@DllImport("ACTIVEDS")
HRESULT ADsGetObject(const(PWSTR) lpszPathName, const(GUID)* riid, void** ppObject);

///The <b>ADsBuildEnumerator</b> function creates an enumerator object for the specified ADSI container object.
///Params:
///    pADsContainer = Type: <b>IADsContainer*</b> Pointer to the IADsContainer interface for the object to enumerate.
///    ppEnumVariant = Type: <b>IEnumVARIANT**</b> Pointer to an IEnumVARIANT interface pointer that receives the enumerator object
///                    created for the specified container object.
///Returns:
///    Type: <b>HRESULT</b> This method supports the standard <b>HRESULT</b> return values, including <b>S_OK</b> for a
///    successful operation. For more information about other return values, see ADSI Error Codes.
///    
@DllImport("ACTIVEDS")
HRESULT ADsBuildEnumerator(IADsContainer pADsContainer, IEnumVARIANT* ppEnumVariant);

///The <b>ADsFreeEnumerator</b> function frees an enumerator object created with the ADsBuildEnumerator function.
///Params:
///    pEnumVariant = Type: <b>IEnumVARIANT*</b> Pointer to the IEnumVARIANT interface on the enumerator object to be freed.
///Returns:
///    Type: <b>HRESULT</b> This method supports standard return values, as well as the following.
///    
@DllImport("ACTIVEDS")
HRESULT ADsFreeEnumerator(IEnumVARIANT pEnumVariant);

///The <b>ADsEnumerateNext</b> function enumerates through a specified number of elements from the current cursor
///position of the enumerator. When the operation succeeds, the function returns the enumerated set of elements in a
///variant array. The number of returned elements can be smaller than the specified number.
///Params:
///    pEnumVariant = Type: <b>IEnumVARIANT*</b> Pointer to the IEnumVARIANT interface on the enumerator object.
///    cElements = Type: <b>ULONG</b> Number of elements requested.
///    pvar = Type: <b>VARIANT*</b> Pointer to the array of elements retrieved.
///    pcElementsFetched = Type: <b>ULONG*</b> Actual number of elements retrieved, which can be smaller than the number of elements
///                        requested.
///Returns:
///    Type: <b>HRESULT</b> This method supports the standard return values. For more information about other return
///    values, see ADSI Error Codes.
///    
@DllImport("ACTIVEDS")
HRESULT ADsEnumerateNext(IEnumVARIANT pEnumVariant, uint cElements, VARIANT* pvar, uint* pcElementsFetched);

///The <b>ADsBuildVarArrayStr</b> function builds a variant array from an array of Unicode strings.
///Params:
///    lppPathNames = Type: <b>LPWSTR*</b> Array of null-terminated Unicode strings.
///    dwPathNames = Type: <b>DWORD</b> Number of Unicode entries in the given array.
///    pVar = Type: <b>VARIANT*</b> Pointer to the resulting variant array.
///Returns:
///    Type: <b>HRESULT</b> This method supports the standard return values, as well as the following. For more
///    information about other return values, see ADSI Error Codes.
///    
@DllImport("ACTIVEDS")
HRESULT ADsBuildVarArrayStr(PWSTR* lppPathNames, uint dwPathNames, VARIANT* pVar);

///The <b>ADsBuildVarArrayInt</b> function builds a variant array of integers from an array of <b>DWORD</b> values.
///Params:
///    lpdwObjectTypes = Type: <b>LPDWORD</b> Array of <b>DWORD</b> values.
///    dwObjectTypes = Type: <b>DWORD</b> Number of <b>DWORD</b> entries in the given array.
///    pVar = Type: <b>VARIANT*</b> Pointer to the resulting variant array of integers.
///Returns:
///    Type: <b>HRESULT</b> This method supports standard return values. For more information about other return values,
///    see ADSI Error Codes.
///    
@DllImport("ACTIVEDS")
HRESULT ADsBuildVarArrayInt(uint* lpdwObjectTypes, uint dwObjectTypes, VARIANT* pVar);

///The <b>ADsOpenObject</b> function binds to an ADSI object using explicit user name and password
///credentials.<b>ADsOpenObject</b> is a wrapper function for IADsOpenDSObject and is equivalent to the
///IADsOpenDSObject::OpenDsObject method.
///Params:
///    lpszPathName = Type: <b>LPCWSTR</b> The null-terminated Unicode string that specifies the ADsPath of the ADSI object. For more
///                   information and code examples of binding strings for this parameter, see LDAP ADsPath and WinNT ADsPath.
///    lpszUserName = Type: <b>LPCWSTR</b> The null-terminated Unicode string that specifies the user name to supply to the directory
///                   service to use for credentials. This string should always be in the format "&lt;domain&gt;\&lt;user name&gt;" to
///                   avoid ambiguity. For example, if DomainA and DomainB have a trust relationship and both domains have a user with
///                   the name "user1", it is not possible to predict which domain <b>ADsOpenObject</b> will use to validate "user1".
///    lpszPassword = Type: <b>LPCWSTR</b> The null-terminated Unicode string that specifies the password to supply to the directory
///                   service to use for credentials.
///    dwReserved = Type: <b>DWORD</b> Provider-specific authentication flags used to define the binding options. For more
///                 information, see ADS_AUTHENTICATION_ENUM.
///    riid = Type: <b>REFIID</b> Interface identifier for the requested interface on this object.
///    ppObject = Type: <b>VOID**</b> Pointer to a pointer to the requested interface.
///Returns:
///    Type: <b>HRESULT</b> This method supports the standard <b>HRESULT</b> return values, including the following. For
///    more information, see ADSI Error Codes.
///    
@DllImport("ACTIVEDS")
HRESULT ADsOpenObject(const(PWSTR) lpszPathName, const(PWSTR) lpszUserName, const(PWSTR) lpszPassword, 
                      uint dwReserved, const(GUID)* riid, void** ppObject);

///The <b>ADsGetLastError</b> function retrieves the calling thread's last-error code value.
///Params:
///    lpError = Type: <b>LPDWORD</b> Pointer to the location that receives the error code.
///    lpErrorBuf = Type: <b>LPWSTR</b> Pointer to the location that receives the null-terminated Unicode string that describes the
///                 error.
///    dwErrorBufLen = Type: <b>DWORD</b> Size, in characters, of the <i>lpErrorBuf</i> buffer. If the buffer is too small to receive
///                    the error string, the string is truncated, but still null-terminated. A buffer, of at least 256 bytes, is
///                    recommended.
///    lpNameBuf = Type: <b>LPWSTR</b> Pointer to the location that receives the null-terminated Unicode string that describes the
///                name of the provider that raised the error.
///    dwNameBufLen = Type: <b>DWORD</b> Size, in characters, of the <i>lpNameBuf</i> buffer. If the buffer is too small to receive the
///                   name of the provider, the string is truncated, but still null-terminated.
///Returns:
///    Type: <b>HRESULT</b> This method supports standard return values, as well as the following.
///    
@DllImport("ACTIVEDS")
HRESULT ADsGetLastError(uint* lpError, PWSTR lpErrorBuf, uint dwErrorBufLen, PWSTR lpNameBuf, uint dwNameBufLen);

///The <b>ADsSetLastError</b> sets the last-error code value for the calling thread. Directory service providers can use
///this function to set extended errors. The function saves the error data in a per-thread data structure.
///<b>ADsSetLastError</b> operates similar to the SetLastError function.
///Params:
///    dwErr = Type: <b>DWORD</b> The error code that occurred. If this is an error defined by Windows, <i>pszError</i> is
///            ignored. If this is ERROR_EXTENDED_ERROR, it indicates the provider has a network-specific error to report.
///    pszError = Type: <b>LPWSTR</b> The null-terminated Unicode string that describes the network-specific error.
///    pszProvider = Type: <b>LPWSTR</b> The null-terminated Unicode string that names the ADSI provider that raised the error.
@DllImport("ACTIVEDS")
void ADsSetLastError(uint dwErr, const(PWSTR) pszError, const(PWSTR) pszProvider);

///The <b>AllocADsMem</b> function allocates a block of memory of the specified size.
///Params:
///    cb = Type: <b>DWORD</b> Contains the size, in bytes, to be allocated.
///Returns:
///    Type: <b>LPVOID</b> When successful, the function returns a non-<b>NULL</b> pointer to the allocated memory. The
///    caller must free this memory when it is no longer required by passing the returned pointer to FreeADsMem. Returns
///    <b>NULL</b> if not successful. Call ADsGetLastError to obtain extended error status. For more information about
///    error code values, see ADSI Error Codes.
///    
@DllImport("ACTIVEDS")
void* AllocADsMem(uint cb);

///The <b>FreeADsMem</b> function frees the memory allocated by AllocADsMem or ReallocADsMem.
///Params:
///    pMem = Type: <b>LPVOID</b> Pointer to the memory to be freed. This memory must have been allocated with the AllocADsMem
///           or ReallocADsMem function.
///Returns:
///    Type: <b>BOOL</b> The function returns <b>TRUE</b> if successful, otherwise it returns <b>FALSE</b>.
///    
@DllImport("ACTIVEDS")
BOOL FreeADsMem(void* pMem);

///The <b>ReallocADsMem</b> function reallocates and copies an existing memory block.
///Params:
///    pOldMem = Type: <b>LPVOID</b> Pointer to the memory to copy. <b>ReallocADsMem</b> will free this memory with FreeADsMem
///              after it has been copied. If additional memory cannot be allocated, this memory is not freed. This memory must
///              have been allocated with the AllocADsMem, AllocADsStr, <b>ReallocADsMem</b>, or ReallocADsStr function. The
///              caller must free this memory when it is no longer required by passing this pointer to FreeADsMem.
///    cbOld = Type: <b>DWORD</b> Size, in bytes, of the memory to copy.
///    cbNew = Type: <b>DWORD</b> Size, in bytes, of the memory to allocate.
///Returns:
///    Type: <b>LPVOID</b> When successful, the function returns a pointer to the new allocated memory. Otherwise it
///    returns <b>NULL</b>.
///    
@DllImport("ACTIVEDS")
void* ReallocADsMem(void* pOldMem, uint cbOld, uint cbNew);

///The <b>AllocADsStr</b> function allocates memory for and copies a specified string.
///Params:
///    pStr = Type: <b>LPWSTR</b> Pointer to a null-terminated Unicode string to be copied.
///Returns:
///    Type: <b>LPWSTR</b> When successful, the function returns a non-<b>NULL</b> pointer to the allocated memory. The
///    string in <i>pStr</i> is copied to this buffer and null-terminated. The caller must free this memory when it is
///    no longer required by passing the returned pointer to FreeADsStr. Returns <b>NULL</b> if not successful. Call
///    ADsGetLastError to obtain the extended error status. For more information about error code values, see ADSI Error
///    Codes.
///    
@DllImport("ACTIVEDS")
PWSTR AllocADsStr(const(PWSTR) pStr);

///The <b>FreeADsStr</b> function frees the memory of a string allocated by AllocADsStr or ReallocADsStr.
///Params:
///    pStr = Type: <b>LPWSTR</b> Pointer to the string to be freed. This string must have been allocated with the AllocADsStr
///           or ReallocADsStr function.
///Returns:
///    Type: <b>BOOL</b> The function returns <b>TRUE</b> if the memory is freed. Otherwise, it returns <b>FALSE</b>.
///    
@DllImport("ACTIVEDS")
BOOL FreeADsStr(PWSTR pStr);

///The <b>ReallocADsStr</b> function creates a copy of a Unicode string.
///Params:
///    ppStr = Type: <b>LPWSTR*</b> Pointer to null-terminated Unicode string pointer that receives the allocated string.
///            <b>ReallocADsStr</b> will attempt to free this memory with FreeADsStr before reallocating the string, so this
///            parameter should be initialized to <b>NULL</b> if the memory should not be freed or was not allocated with the
///            AllocADsMem, AllocADsStr, ReallocADsMem or <b>ReallocADsStr</b> function. The caller must free this memory when
///            it is no longer required by passing this pointer to FreeADsStr.
///    pStr = Type: <b>LPWSTR</b> Pointer to a null-terminated Unicode string that contains the string to copy.
///Returns:
///    Type: <b>BOOL</b> The function returns <b>TRUE</b> if successful, otherwise <b>FALSE</b> is returned.
///    
@DllImport("ACTIVEDS")
BOOL ReallocADsStr(PWSTR* ppStr, PWSTR pStr);

///The <b>ADsEncodeBinaryData</b> function converts a binary large object (BLOB) to the Unicode format suitable to be
///embedded in a search filter.
///Params:
///    pbSrcData = Type: <b>PBYTE</b> BLOB to be converted.
///    dwSrcLen = Type: <b>DWORD</b> Size, in bytes, of the BLOB.
///    ppszDestData = Type: <b>LPWSTR*</b> Pointer to a null-terminated Unicode string that receives the converted data.
///Returns:
///    Type: <b>HRESULT</b> This method supports the standard return values, as well as the following.
///    
@DllImport("ACTIVEDS")
HRESULT ADsEncodeBinaryData(ubyte* pbSrcData, uint dwSrcLen, PWSTR* ppszDestData);

@DllImport("ACTIVEDS")
HRESULT ADsDecodeBinaryData(const(PWSTR) szSrcData, ubyte** ppbDestData, uint* pdwDestLen);

@DllImport("ACTIVEDS")
HRESULT PropVariantToAdsType(VARIANT* pVariant, uint dwNumVariant, ADSVALUE** ppAdsValues, uint* pdwNumValues);

@DllImport("ACTIVEDS")
HRESULT AdsTypeToPropVariant(ADSVALUE* pAdsValues, uint dwNumValues, VARIANT* pVariant);

@DllImport("ACTIVEDS")
void AdsFreeAdsValues(ADSVALUE* pAdsValues, uint dwNumValues);

///The <b>BinarySDToSecurityDescriptor</b> function converts a binary security descriptor to an IADsSecurityDescriptor
///object.
///Params:
///    pSecurityDescriptor = Type: <b>PSECURITY_DESCRIPTOR</b> Address of a SECURITY_DESCRIPTOR structure to convert.
///    pVarsec = Type: <b>VARIANT*</b> Address of a VARIANT that receives the object. The <b>VARIANT</b> contains a
///              <b>VT_DISPATCH</b> object that can be queried for the IADsSecurityDescriptor interface. The caller must release
///              this <b>VARIANT</b> by passing the <b>VARIANT</b> to the VariantClear function.
///    pszServerName = Type: <b>LPCWSTR</b> A null-terminated Unicode string that provides the name of the server that the security
///                    descriptor was retrieved from. This parameter is optional and can be <b>NULL</b>.
///    userName = Type: <b>LPCWSTR</b> A null-terminated Unicode string that provides the user name to be associated with the
///               security descriptor. This parameter is optional and can be <b>NULL</b>.
///    passWord = Type: <b>LPCWSTR</b> A null-terminated Unicode string that provides the password to be associated with the
///               security descriptor. This parameter is optional and can be <b>NULL</b>.
///    dwFlags = Type: <b>DWORD</b> Contains authentication flags for the conversion. This can be zero or a combination of one or
///              more of the ADS_AUTHENTICATION_ENUM enumeration values.
///Returns:
///    Type: <b>HRESULT</b> This method supports standard return values, as well as the following: If the operation
///    fails, an ADSI error code is returned. For more information, see ADSI Error Codes.
///    
@DllImport("ACTIVEDS")
HRESULT BinarySDToSecurityDescriptor(void* pSecurityDescriptor, VARIANT* pVarsec, const(PWSTR) pszServerName, 
                                     const(PWSTR) userName, const(PWSTR) passWord, uint dwFlags);

///The <b>SecurityDescriptorToBinarySD</b> function converts an IADsSecurityDescriptor object to the binary security
///descriptor format.
///Params:
///    vVarSecDes = Type: <b>VARIANT</b> Contains a VARIANT that contains the security descriptor to convert. The <b>VARIANT</b> must
///                 contain a <b>VT_DISPATCH</b> that contains an IADsSecurityDescriptor object.
///    ppSecurityDescriptor = Type: <b>PSECURITY_DESCRIPTOR*</b> Address of a SECURITY_DESCRIPTOR pointer that receives the binary security
///                           descriptor data. The caller must free this memory by passing this pointer to the FreeADsMem function.
///    pdwSDLength = Type: <b>PDWORD</b> Address of a <b>DWORD</b> value that receives the length, in bytes of the binary security
///                  descriptor data.
///    pszServerName = Type: <b>LPCWSTR</b> A null-terminated Unicode string that specifies the name of the server where the security
///                    descriptor is placed. This parameter is optional and can be <b>NULL</b>.
///    userName = Type: <b>LPCWSTR</b> A null-terminated Unicode string that contains the user name that the security descriptor is
///               associated to. This parameter is optional and can be <b>NULL</b>.
///    passWord = Type: <b>LPCWSTR</b> A null-terminated Unicode string that contains the password that the security descriptor is
///               associated. This parameter is optional and can be <b>NULL</b>.
///    dwFlags = Type: <b>DWORD</b> Contains authentication flags for the conversion. This can be zero or a combination of one or
///              more of the ADS_AUTHENTICATION_ENUM enumeration values.
///Returns:
///    Type: <b>HRESULT</b> This method supports the standard return values, as well as the following.
///    
@DllImport("ACTIVEDS")
HRESULT SecurityDescriptorToBinarySD(VARIANT vVarSecDes, void** ppSecurityDescriptor, uint* pdwSDLength, 
                                     const(PWSTR) pszServerName, const(PWSTR) userName, const(PWSTR) passWord, 
                                     uint dwFlags);

///The <b>DsBrowseForContainer</b> function displays a dialog box used to browse for container objects in Active
///Directory Domain Services.
///Params:
///    pInfo = Pointer to a DSBROWSEINFO structure that contains data about initializing the container browser dialog and
///            receives data about the selected object.
///Returns:
///    The function returns one of the following values.
///    
@DllImport("dsuiext")
int DsBrowseForContainerW(DSBROWSEINFOW* pInfo);

///The <b>DsBrowseForContainer</b> function displays a dialog box used to browse for container objects in Active
///Directory Domain Services.
///Params:
///    pInfo = Pointer to a DSBROWSEINFO structure that contains data about initializing the container browser dialog and
///            receives data about the selected object.
///Returns:
///    The function returns one of the following values.
///    
@DllImport("dsuiext")
int DsBrowseForContainerA(DSBROWSEINFOA* pInfo);

///The <b>DsGetIcon</b> function obtains the icon for a given object class. This function is obsolete. New applications
///should use the IDsDisplaySpecifier::GetIcon method to perform this function.
///Params:
///    dwFlags = Contains a set of flags that indicate the type of icon to retrieve. This can be a combination of one or more of
///              the following values.
///    pszObjectClass = Pointer to a null-terminated Unicode string that contains the name of the object class to retrieve the icon for.
///                     Examples of the object class name are "user" and "container".
///    cxImage = Contains the desired width, in pixels, of the icon. This function retrieves the icon that most closely matches
///              this width.
///    cyImage = Contains the desired height, in pixels, of the icon. This function retrieves the icon that most closely matches
///              this height.
///Returns:
///    Returns a handle to the icon if successful or <b>NULL</b> otherwise. The caller must destroy this icon when it is
///    no longer required by passing this handle to DestroyIcon.
///    
@DllImport("dsuiext")
HICON DsGetIcon(uint dwFlags, const(PWSTR) pszObjectClass, int cxImage, int cyImage);

///The <b>DsGetFriendlyClassName</b> function retrieves the localized name for an object class. This function is
///obsolete. New applications should use the IDsDisplaySpecifier::GetFriendlyClassName method to perform this function.
///Params:
///    pszObjectClass = Pointer to a null-terminated Unicode string that contains the name of the object class to obtain the name of.
///                     Examples of the object class name are "user" and "container".
///    pszBuffer = Pointer to a wide character buffer that receives the name string. This buffer must be at least <i>cchBuffer</i>
///                wide characters in length.
///    cchBuffer = Contains the size of the <i>pszBuffer</i> buffer, in wide characters, including the terminating <b>NULL</b>
///                character. If the name exceeds this number of characters, the name is truncated.
///Returns:
///    Returns a standard <b>HRESULT</b> value, including the following.
///    
@DllImport("dsuiext")
HRESULT DsGetFriendlyClassName(const(PWSTR) pszObjectClass, PWSTR pszBuffer, uint cchBuffer);

///The <b>ADsPropCreateNotifyObj</b> function is used to create, or obtain, a notification object for use by an Active
///Directory Domain Services property sheet extension.
///Params:
///    pAppThdDataObj = A pointer to the IDataObject object that represents the directory object that the property page applies to. This
///                     is the <b>IDataObject</b> passed to the property page IShellExtInit::Initialize method.
///    pwzADsObjName = The Active Directory Domain Services object name obtained by calling the IDataObject::GetData method for the
///                    CFSTR_DSOBJECTNAMES clipboard format on the IDataObject represented by <i>pAppThdDataObj</i>.
///    phNotifyObj = Pointer to an <b>HWND</b> value that receives the handle of the notification object.
///Returns:
///    Returns <b>S_OK</b> if successful, or an OLE-defined error value otherwise.
///    
@DllImport("dsprop")
HRESULT ADsPropCreateNotifyObj(IDataObject pAppThdDataObj, PWSTR pwzADsObjName, HWND* phNotifyObj);

///The <b>ADsPropGetInitInfo</b> function is used to obtain directory object data that an Active Directory Domain
///Services property sheet extension applies to.
///Params:
///    hNotifyObj = The handle of the notification object. To obtain this handle, call ADsPropCreateNotifyObj.
///    pInitParams = Pointer to an ADSPROPINITPARAMS structure that receives the directory object data. The <b>dwSize</b> member of
///                  this structure must be entered before calling this function.
///Returns:
///    Returns nonzero if successful or zero otherwise.
///    
@DllImport("dsprop")
BOOL ADsPropGetInitInfo(HWND hNotifyObj, ADSPROPINITPARAMS* pInitParams);

///The <b>ADsPropSetHwndWithTitle</b> function is used to notify the notification object of the property page window
///handle.This function includes the title of the property page which enables the error dialog displayed by
///ADsPropShowErrorDialog to provide more useful information to the user.
///Params:
///    hNotifyObj = The handle of the notification object. To obtain this handle, call ADsPropCreateNotifyObj.
///    hPage = A window handle of the property page.
///    ptzTitle = Pointer to a NULL-terminated string that contains the property page title.
///Returns:
///    Returns zero if the notification object does not exist or nonzero otherwise.
///    
@DllImport("dsprop")
BOOL ADsPropSetHwndWithTitle(HWND hNotifyObj, HWND hPage, byte* ptzTitle);

///The <b>ADsPropSetHwnd</b> function is used to notify the notification object of the property page window handle.
///Params:
///    hNotifyObj = The handle of the notification object. To obtain this handle, call ADsPropCreateNotifyObj.
///    hPage = A window handle of the property page.
///Returns:
///    Returns zero if the notification object does not exist or nonzero otherwise.
///    
@DllImport("dsprop")
BOOL ADsPropSetHwnd(HWND hNotifyObj, HWND hPage);

///The <b>ADsPropCheckIfWritable</b> function determines if an attribute can be written.
///Params:
///    pwzAttr = Pointer to a NULL-terminated <b>WCHAR</b> buffer that contains the name of the attribute.
///    pWritableAttrs = Pointer to the array of ADS_ATTR_INFO structures returned by ADsPropGetInitInfo.
///Returns:
///    Returns nonzero if the attribute is found in the writable-attribute list or zero otherwise. Also returns zero if
///    <i>pWritableAttrs</i> is <b>NULL</b>.
///    
@DllImport("dsprop")
BOOL ADsPropCheckIfWritable(const(PWSTR) pwzAttr, const(ADS_ATTR_INFO)* pWritableAttrs);

///The <b>ADsPropSendErrorMessage</b> function adds an error message to a list of error messages displayed by calling
///the ADsPropShowErrorDialog function.
///Params:
///    hNotifyObj = The handle of the notification object. To obtain this handle, call ADsPropCreateNotifyObj.
///    pError = Pointer to an ADSPROPERROR structure which contains data about the error message.
///Returns:
///    Returns nonzero if successful or zero otherwise.
///    
@DllImport("dsprop")
BOOL ADsPropSendErrorMessage(HWND hNotifyObj, ADSPROPERROR* pError);

///The <b>ADsPropShowErrorDialog</b> function displays a dialog box that contains the error messages accumulated through
///calls to the ADsPropSendErrorMessage function or the WM_ADSPROP_NOTIFY_ERROR.
///Params:
///    hNotifyObj = The handle of the notification object. To obtain this handle, call ADsPropCreateNotifyObj.
///    hPage = The window handle of the property page.
///Returns:
///    Returns zero if the notification object does not exist or nonzero otherwise.
///    
@DllImport("dsprop")
BOOL ADsPropShowErrorDialog(HWND hNotifyObj, HWND hPage);

///The <b>DsMakeSpn</b> function constructs a service principal name (SPN) that identifies a service instance. A client
///application uses this function to compose an SPN, which it uses to authenticate the service instance. For example,
///the client can pass an SPN in the <i>pszTargetName</i> parameter of the InitializeSecurityContext function.
///Params:
///    ServiceClass = Pointer to a constant null-terminated string that specifies the class of the service. This parameter can be any
///                   string unique to that service; either the protocol name, for example, ldap, or the string form of a GUID are
///                   acceptable.
///    ServiceName = Pointer to a constant null-terminated string that specifies the DNS name, NetBIOS name, or distinguished name
///                  (DN). This parameter must be non-<b>NULL</b>. For more information about how the <i>ServiceName</i>,
///                  <i>InstanceName</i> and <i>InstancePort</i> parameters are used to compose an SPN, see the following Remarks
///                  section.
///    InstanceName = Pointer to a constant null-terminated string that specifies the DNS name or IP address of the host for an
///                   instance of the service. If <i>ServiceName</i> specifies the DNS or NetBIOS name of the service host computer,
///                   the <i>InstanceName</i> parameter must be <b>NULL</b>. If <i>ServiceName</i> specifies a DNS domain name, the
///                   name of a DNS SRV record, or a distinguished name, such as the DN of a service connection point, the
///                   <i>InstanceName</i> parameter must specify the DNS or NetBIOS name of the service host computer.
///    InstancePort = Port number for an instance of the service. Use 0 for the default port. If this parameter is zero, the SPN does
///                   not include a port number.
///    Referrer = Pointer to a constant null-terminated string that specifies the DNS name of the host that gave an IP address
///               referral. This parameter is ignored unless the <i>ServiceName</i> parameter specifies an IP address.
///    pcSpnLength = Pointer to a variable that contains the length, in characters, of the buffer that will receive the new
///                  constructed SPN. This value may be 0 to request the final buffer size in advance. The <i>pcSpnLength</i>
///                  parameter also receives the actual length of the SPN created, including the terminating null character.
///    pszSpn = Pointer to a null-terminated string that receives the constructed SPN. This buffer should be the length specified
///             by <i>pcSpnLength</i>. The <i>pszSpn</i> parameter may be <b>NULL</b> to request the final buffer size in
///             advance.
///Returns:
///    If the function returns an SPN, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value
///    can be one of the following error codes.
///    
@DllImport("DSPARSE")
uint DsMakeSpnW(const(PWSTR) ServiceClass, const(PWSTR) ServiceName, const(PWSTR) InstanceName, 
                ushort InstancePort, const(PWSTR) Referrer, uint* pcSpnLength, PWSTR pszSpn);

///The <b>DsMakeSpn</b> function constructs a service principal name (SPN) that identifies a service instance. A client
///application uses this function to compose an SPN, which it uses to authenticate the service instance. For example,
///the client can pass an SPN in the <i>pszTargetName</i> parameter of the InitializeSecurityContext function.
///Params:
///    ServiceClass = Pointer to a constant null-terminated string that specifies the class of the service. This parameter can be any
///                   string unique to that service; either the protocol name, for example, ldap, or the string form of a GUID are
///                   acceptable.
///    ServiceName = Pointer to a constant null-terminated string that specifies the DNS name, NetBIOS name, or distinguished name
///                  (DN). This parameter must be non-<b>NULL</b>. For more information about how the <i>ServiceName</i>,
///                  <i>InstanceName</i> and <i>InstancePort</i> parameters are used to compose an SPN, see the following Remarks
///                  section.
///    InstanceName = Pointer to a constant null-terminated string that specifies the DNS name or IP address of the host for an
///                   instance of the service. If <i>ServiceName</i> specifies the DNS or NetBIOS name of the service host computer,
///                   the <i>InstanceName</i> parameter must be <b>NULL</b>. If <i>ServiceName</i> specifies a DNS domain name, the
///                   name of a DNS SRV record, or a distinguished name, such as the DN of a service connection point, the
///                   <i>InstanceName</i> parameter must specify the DNS or NetBIOS name of the service host computer.
///    InstancePort = Port number for an instance of the service. Use 0 for the default port. If this parameter is zero, the SPN does
///                   not include a port number.
///    Referrer = Pointer to a constant null-terminated string that specifies the DNS name of the host that gave an IP address
///               referral. This parameter is ignored unless the <i>ServiceName</i> parameter specifies an IP address.
///    pcSpnLength = Pointer to a variable that contains the length, in characters, of the buffer that will receive the new
///                  constructed SPN. This value may be 0 to request the final buffer size in advance. The <i>pcSpnLength</i>
///                  parameter also receives the actual length of the SPN created, including the terminating null character.
///    pszSpn = Pointer to a null-terminated string that receives the constructed SPN. This buffer should be the length specified
///             by <i>pcSpnLength</i>. The <i>pszSpn</i> parameter may be <b>NULL</b> to request the final buffer size in
///             advance.
///Returns:
///    If the function returns an SPN, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value
///    can be one of the following error codes.
///    
@DllImport("DSPARSE")
uint DsMakeSpnA(const(PSTR) ServiceClass, const(PSTR) ServiceName, const(PSTR) InstanceName, ushort InstancePort, 
                const(PSTR) Referrer, uint* pcSpnLength, PSTR pszSpn);

///The <b>DsCrackSpn</b> function parses a service principal name (SPN) into its component strings.
///Params:
///    pszSpn = Pointer to a constant null-terminated string that contains the SPN to parse. The SPN has the following format, in
///             which the &lt;service class&gt; and &lt;instance name&gt; components must be present and the &lt;port number&gt;
///             and &lt;service name&gt; components are optional. The &lt;port number&gt; component must be a numeric string
///             value. ```cpp <service class>/<instance name>:<port number>/<service name> ```
///    pcServiceClass = Pointer to a <b>DWORD</b> value that, on entry, contains the size, in <b>TCHARs</b>, of the <i>ServiceClass</i>
///                     buffer, including the terminating null character. On exit, this parameter contains the number of <b>TCHARs</b> in
///                     the <i>ServiceClass</i> string, including the terminating null character. If this parameter is <b>NULL</b>,
///                     contains zero, or <i>ServiceClass</i> is <b>NULL</b>, this parameter and <i>ServiceClass</i> are ignored. To
///                     obtain the number of characters required for the <i>ServiceClass</i> string, including the null terminator, call
///                     this function with a valid SPN, a non-<b>NULL</b> <i>ServiceClass</i> and this parameter set to 1.
///    ServiceClass = Pointer to a <b>TCHAR</b> buffer that receives a null-terminated string containing the &lt;service class&gt;
///                   component of the SPN. This buffer must be at least <i>*pcServiceClass </i><b>TCHARs</b> in size. This parameter
///                   may be <b>NULL</b> if the service class is not required.
///    pcServiceName = Pointer to a <b>DWORD</b> value that, on entry, contains the size, in <b>TCHARs</b>, of the <i>ServiceName</i>
///                    buffer, including the terminating null character. On exit, this parameter contains the number of <b>TCHARs</b> in
///                    the <i>ServiceName</i> string, including the terminating null character. If this parameter is <b>NULL</b>,
///                    contains zero, or <i>ServiceName</i> is <b>NULL</b>, this parameter and <i>ServiceName</i> are ignored. To obtain
///                    the number of characters required for the <i>ServiceName</i> string, including the null terminator, call this
///                    function with a valid SPN, a non-<b>NULL</b> <i>ServiceName</i> and this parameter set to 1.
///    ServiceName = Pointer to a <b>TCHAR</b> buffer that receives a null-terminated string containing the &lt;service name&gt;
///                  component of the SPN. This buffer must be at least <i>*pcServiceName </i><b>TCHARs</b> in size. If the
///                  &lt;service name&gt; component is not present in the SPN, this buffer receives the &lt;instance name&gt;
///                  component. This parameter may be <b>NULL</b> if the service name is not required.
///    pcInstanceName = Pointer to a <b>DWORD</b> value that, on entry, contains the size, in <b>TCHARs</b>, of the <i>InstanceName</i>
///                     buffer, including the terminating null character. On exit, this parameter contains the number of <b>TCHARs</b> in
///                     the <i>InstanceName</i> string, including the terminating null character. If this parameter is <b>NULL</b>,
///                     contains zero, or <i>InstanceName</i> is <b>NULL</b>, this parameter and <i>InstanceName</i> are ignored. To
///                     obtain the number of characters required for the <i>InstanceName</i> string, including the null terminator, call
///                     this function with a valid SPN, a non-<b>NULL</b> <i>InstanceName</i> and this parameter set to 1.
///    InstanceName = Pointer to a <b>TCHAR</b> buffer that receives a null-terminated string containing the &lt;instance name&gt;
///                   component of the SPN. This buffer must be at least <i>*pcInstanceName </i> <b>TCHARs</b> in size. This parameter
///                   may be <b>NULL</b> if the instance name is not required.
///    pInstancePort = Pointer to a <b>DWORD</b> value that receives the integer value of the &lt;port number&gt; component of the SPN.
///                    If the SPN does not contain a &lt;port number&gt; component, this parameter receives zero. This parameter may be
///                    <b>NULL</b> if the port number is not required.
///Returns:
///    Returns a Win32 error code, including the following.
///    
@DllImport("DSPARSE")
uint DsCrackSpnA(const(PSTR) pszSpn, uint* pcServiceClass, PSTR ServiceClass, uint* pcServiceName, 
                 PSTR ServiceName, uint* pcInstanceName, PSTR InstanceName, ushort* pInstancePort);

///The <b>DsCrackSpn</b> function parses a service principal name (SPN) into its component strings.
///Params:
///    pszSpn = Pointer to a constant null-terminated string that contains the SPN to parse. The SPN has the following format, in
///             which the &lt;service class&gt; and &lt;instance name&gt; components must be present and the &lt;port number&gt;
///             and &lt;service name&gt; components are optional. The &lt;port number&gt; component must be a numeric string
///             value. ```cpp <service class>/<instance name>:<port number>/<service name> ```
///    pcServiceClass = Pointer to a <b>DWORD</b> value that, on entry, contains the size, in <b>TCHARs</b>, of the <i>ServiceClass</i>
///                     buffer, including the terminating null character. On exit, this parameter contains the number of <b>TCHARs</b> in
///                     the <i>ServiceClass</i> string, including the terminating null character. If this parameter is <b>NULL</b>,
///                     contains zero, or <i>ServiceClass</i> is <b>NULL</b>, this parameter and <i>ServiceClass</i> are ignored. To
///                     obtain the number of characters required for the <i>ServiceClass</i> string, including the null terminator, call
///                     this function with a valid SPN, a non-<b>NULL</b> <i>ServiceClass</i> and this parameter set to 1.
///    ServiceClass = Pointer to a <b>TCHAR</b> buffer that receives a null-terminated string containing the &lt;service class&gt;
///                   component of the SPN. This buffer must be at least <i>*pcServiceClass </i><b>TCHARs</b> in size. This parameter
///                   may be <b>NULL</b> if the service class is not required.
///    pcServiceName = Pointer to a <b>DWORD</b> value that, on entry, contains the size, in <b>TCHARs</b>, of the <i>ServiceName</i>
///                    buffer, including the terminating null character. On exit, this parameter contains the number of <b>TCHARs</b> in
///                    the <i>ServiceName</i> string, including the terminating null character. If this parameter is <b>NULL</b>,
///                    contains zero, or <i>ServiceName</i> is <b>NULL</b>, this parameter and <i>ServiceName</i> are ignored. To obtain
///                    the number of characters required for the <i>ServiceName</i> string, including the null terminator, call this
///                    function with a valid SPN, a non-<b>NULL</b> <i>ServiceName</i> and this parameter set to 1.
///    ServiceName = Pointer to a <b>TCHAR</b> buffer that receives a null-terminated string containing the &lt;service name&gt;
///                  component of the SPN. This buffer must be at least <i>*pcServiceName </i><b>TCHARs</b> in size. If the
///                  &lt;service name&gt; component is not present in the SPN, this buffer receives the &lt;instance name&gt;
///                  component. This parameter may be <b>NULL</b> if the service name is not required.
///    pcInstanceName = Pointer to a <b>DWORD</b> value that, on entry, contains the size, in <b>TCHARs</b>, of the <i>InstanceName</i>
///                     buffer, including the terminating null character. On exit, this parameter contains the number of <b>TCHARs</b> in
///                     the <i>InstanceName</i> string, including the terminating null character. If this parameter is <b>NULL</b>,
///                     contains zero, or <i>InstanceName</i> is <b>NULL</b>, this parameter and <i>InstanceName</i> are ignored. To
///                     obtain the number of characters required for the <i>InstanceName</i> string, including the null terminator, call
///                     this function with a valid SPN, a non-<b>NULL</b> <i>InstanceName</i> and this parameter set to 1.
///    InstanceName = Pointer to a <b>TCHAR</b> buffer that receives a null-terminated string containing the &lt;instance name&gt;
///                   component of the SPN. This buffer must be at least <i>*pcInstanceName </i> <b>TCHARs</b> in size. This parameter
///                   may be <b>NULL</b> if the instance name is not required.
///    pInstancePort = Pointer to a <b>DWORD</b> value that receives the integer value of the &lt;port number&gt; component of the SPN.
///                    If the SPN does not contain a &lt;port number&gt; component, this parameter receives zero. This parameter may be
///                    <b>NULL</b> if the port number is not required.
///Returns:
///    Returns a Win32 error code, including the following.
///    
@DllImport("DSPARSE")
uint DsCrackSpnW(const(PWSTR) pszSpn, uint* pcServiceClass, PWSTR ServiceClass, uint* pcServiceName, 
                 PWSTR ServiceName, uint* pcInstanceName, PWSTR InstanceName, ushort* pInstancePort);

///The <b>DsQuoteRdnValue</b> function converts an RDN into a quoted RDN value, if the RDN value contains characters
///that require quotes. The quoted RDN can then be submitted as part of a distinguished name (DN) to the directory
///service using various APIs such as LDAP. An example of an RDN that would require quotes would be one that has a
///comma-separated value, such as an RDN for a name that uses the format "last,first".
///Params:
///    cUnquotedRdnValueLength = The number of characters in the <i>psUnquotedRdnValue</i> string.
///    psUnquotedRdnValue = The string that specifies the unquoted RDN value.
///    pcQuotedRdnValueLength = The maximum number of characters in the <i>psQuotedRdnValue</i> string. The following flags are the output for
///                             this parameter.
///    psQuotedRdnValue = The string that receives the converted, and perhaps quoted, RDN value.
///Returns:
///    The following list contains the possible values returned for the <b>DsQuoteRdnValue</b> function.
///    
@DllImport("DSPARSE")
uint DsQuoteRdnValueW(uint cUnquotedRdnValueLength, const(PWSTR) psUnquotedRdnValue, uint* pcQuotedRdnValueLength, 
                      PWSTR psQuotedRdnValue);

///The <b>DsQuoteRdnValue</b> function converts an RDN into a quoted RDN value, if the RDN value contains characters
///that require quotes. The quoted RDN can then be submitted as part of a distinguished name (DN) to the directory
///service using various APIs such as LDAP. An example of an RDN that would require quotes would be one that has a
///comma-separated value, such as an RDN for a name that uses the format "last,first".
///Params:
///    cUnquotedRdnValueLength = The number of characters in the <i>psUnquotedRdnValue</i> string.
///    psUnquotedRdnValue = The string that specifies the unquoted RDN value.
///    pcQuotedRdnValueLength = The maximum number of characters in the <i>psQuotedRdnValue</i> string. The following flags are the output for
///                             this parameter.
///    psQuotedRdnValue = The string that receives the converted, and perhaps quoted, RDN value.
///Returns:
///    The following list contains the possible values returned for the <b>DsQuoteRdnValue</b> function.
///    
@DllImport("DSPARSE")
uint DsQuoteRdnValueA(uint cUnquotedRdnValueLength, const(PSTR) psUnquotedRdnValue, uint* pcQuotedRdnValueLength, 
                      PSTR psQuotedRdnValue);

///The <b>DsUnquoteRdnValue</b> function is a client call that converts a quoted RDN value back to an unquoted RDN
///value. Because the RDN was originally put into quotes because it contained characters that could be misinterpreted
///when it was embedded within a distinguished name (DN), the unquoted RDN value should not be submitted as part of a DN
///to the directory service using various APIs such as LDAP.
///Params:
///    cQuotedRdnValueLength = The number of characters in the <i>psQuotedRdnValue</i> string.
///    psQuotedRdnValue = The RDN value that may be quoted and escaped.
///    pcUnquotedRdnValueLength = The input value for this argument is the maximum length, in characters, of <i>psQuotedRdnValue</i>. The output
///                               value for this argument includes the following flags.
///    psUnquotedRdnValue = The converted, unquoted RDN value.
///Returns:
///    The following list contains the possible values that are returned for the <b>DsUnquoteRdnValue</b> function.
///    
@DllImport("DSPARSE")
uint DsUnquoteRdnValueW(uint cQuotedRdnValueLength, const(PWSTR) psQuotedRdnValue, uint* pcUnquotedRdnValueLength, 
                        PWSTR psUnquotedRdnValue);

///The <b>DsUnquoteRdnValue</b> function is a client call that converts a quoted RDN value back to an unquoted RDN
///value. Because the RDN was originally put into quotes because it contained characters that could be misinterpreted
///when it was embedded within a distinguished name (DN), the unquoted RDN value should not be submitted as part of a DN
///to the directory service using various APIs such as LDAP.
///Params:
///    cQuotedRdnValueLength = The number of characters in the <i>psQuotedRdnValue</i> string.
///    psQuotedRdnValue = The RDN value that may be quoted and escaped.
///    pcUnquotedRdnValueLength = The input value for this argument is the maximum length, in characters, of <i>psQuotedRdnValue</i>. The output
///                               value for this argument includes the following flags.
///    psUnquotedRdnValue = The converted, unquoted RDN value.
///Returns:
///    The following list contains the possible values that are returned for the <b>DsUnquoteRdnValue</b> function.
///    
@DllImport("DSPARSE")
uint DsUnquoteRdnValueA(uint cQuotedRdnValueLength, const(PSTR) psQuotedRdnValue, uint* pcUnquotedRdnValueLength, 
                        PSTR psUnquotedRdnValue);

///The <b>DsGetRdnW</b> function retrieves the key and value of the first relative distinguished name and a pointer to
///the next relative distinguished name from a distinguished name string.
///Params:
///    ppDN = Address of a Unicode string pointer that, on entry, contains the distinguished name string to be parsed. The
///           length of this string is specified in the <i>pcDN</i> parameter. If the function succeeds, this parameter is
///           adjusted to point to the remainder of the distinguished name exclusive of current relative distinguished name.
///           For example, if this parameter points to the string "dc=corp,dc=fabrikam,dc=com", after the function is complete
///           this parameter points to the string ",dc=fabrikam,dc=com".
///    pcDN = Pointer to a <b>DWORD</b> value that, on entry, contains the number of characters in the <i>ppDN</i> string. If
///           the function succeeds, this parameter receives the number of characters in the remainder of the distinguished
///           name. These values do not include the null-terminated character.
///    ppKey = Pointer to a <b>LPCWCH</b> value that, if the function succeeds, receives a pointer to the key in the relative
///            distinguished name string. This pointer is within the <i>ppDN</i> string and is not null-terminated. The
///            <i>pcKey</i> parameter receives the number of characters in the key. This parameter is undefined if <i>pcKey</i>
///            receives zero.
///    pcKey = Pointer to a <b>DWORD</b> value that, if the function succeeds, receives the number of characters in the key
///            string represented by the <i>ppKey</i> parameter. If this parameter receives zero, <i>ppKey</i> is undefined.
///    ppVal = Pointer to a <b>LPCWCH</b> value that, if the function is successful, receives a pointer to the value in the
///            relative distinguished name string. This pointer is within the <i>ppDN</i> string and is not null-terminated. The
///            <i>pcVal</i> parameter receives the number of characters in the value. This parameter is undefined if
///            <i>pcVal</i> receives zero.
///    pcVal = Pointer to a <b>DWORD</b> value that, if the function succeeds, receives the number of characters in the value
///            string represented by the <i>ppVal</i> parameter. If this parameter receives zero, <i>ppVal</i> is undefined.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Win32 error code otherwise. Possible error codes include the
///    following values.
///    
@DllImport("DSPARSE")
uint DsGetRdnW(PWSTR* ppDN, uint* pcDN, PWSTR* ppKey, uint* pcKey, PWSTR* ppVal, uint* pcVal);

///The <b>DsCrackUnquotedMangledRdn</b> function unmangles (unencodes) a given relative distinguished name and returns
///both the decoded GUID and the mangling type used.
///Params:
///    pszRDN = Pointer to a string that contains the relative distinguished name (RDN) to translate. This string length is
///             specified by the <i>cchRDN</i> parameter, so this string is not required to be null-terminated. This string must
///             be in unquoted form. For more information about unquoted relative distinguished names, see DsUnquoteRdnValue.
///    cchRDN = Contains the length, in characters, of the <i>pszRDN</i> string.
///    pGuid = Pointer to <b>GUID</b> value that receives the GUID of the unmangled relative distinguished name. This parameter
///            can be <b>NULL</b>.
///    peDsMangleFor = Pointer to a DS_MANGLE_FOR value that receives the type of mangling used in the mangled relative distinguished
///                    name. This parameter can be <b>NULL</b>.
///Returns:
///    This function returns <b>TRUE</b> if the relative distinguished name is mangled or <b>FALSE</b> otherwise. If
///    this function returns <b>FALSE</b>, neither <i>pGuid</i> or <i>peDsMangleFor</i> receive any data.
///    
@DllImport("DSPARSE")
BOOL DsCrackUnquotedMangledRdnW(const(PWSTR) pszRDN, uint cchRDN, GUID* pGuid, DS_MANGLE_FOR* peDsMangleFor);

///The <b>DsCrackUnquotedMangledRdn</b> function unmangles (unencodes) a given relative distinguished name and returns
///both the decoded GUID and the mangling type used.
///Params:
///    pszRDN = Pointer to a string that contains the relative distinguished name (RDN) to translate. This string length is
///             specified by the <i>cchRDN</i> parameter, so this string is not required to be null-terminated. This string must
///             be in unquoted form. For more information about unquoted relative distinguished names, see DsUnquoteRdnValue.
///    cchRDN = Contains the length, in characters, of the <i>pszRDN</i> string.
///    pGuid = Pointer to <b>GUID</b> value that receives the GUID of the unmangled relative distinguished name. This parameter
///            can be <b>NULL</b>.
///    peDsMangleFor = Pointer to a DS_MANGLE_FOR value that receives the type of mangling used in the mangled relative distinguished
///                    name. This parameter can be <b>NULL</b>.
///Returns:
///    This function returns <b>TRUE</b> if the relative distinguished name is mangled or <b>FALSE</b> otherwise. If
///    this function returns <b>FALSE</b>, neither <i>pGuid</i> or <i>peDsMangleFor</i> receive any data.
///    
@DllImport("DSPARSE")
BOOL DsCrackUnquotedMangledRdnA(const(PSTR) pszRDN, uint cchRDN, GUID* pGuid, DS_MANGLE_FOR* peDsMangleFor);

///The <b>DsIsMangledRdnValue</b> function determines if a given relative distinguished name value is a mangled name of
///the given type.
///Params:
///    pszRdn = Pointer to a null-terminated string that contains the relative distinguished name to determine if it is mangled.
///             The <i>cRdn</i> parameter contains the number of characters in this string.
///    cRdn = Contains the number of characters in the <i>pszRdn</i> string.
///    eDsMangleForDesired = Contains one of the DS_MANGLE_FOR values that specifies the type of name mangling to search for.
///Returns:
///    Returns <b>TRUE</b> if the relative distinguished name is mangled and the mangle type is the same as specified.
///    Returns <b>FALSE</b> if the relative distinguished name is not mangled or the mangle type is different than
///    specified.
///    
@DllImport("DSPARSE")
BOOL DsIsMangledRdnValueW(const(PWSTR) pszRdn, uint cRdn, DS_MANGLE_FOR eDsMangleForDesired);

///The <b>DsIsMangledRdnValue</b> function determines if a given relative distinguished name value is a mangled name of
///the given type.
///Params:
///    pszRdn = Pointer to a null-terminated string that contains the relative distinguished name to determine if it is mangled.
///             The <i>cRdn</i> parameter contains the number of characters in this string.
///    cRdn = Contains the number of characters in the <i>pszRdn</i> string.
///    eDsMangleForDesired = Contains one of the DS_MANGLE_FOR values that specifies the type of name mangling to search for.
///Returns:
///    Returns <b>TRUE</b> if the relative distinguished name is mangled and the mangle type is the same as specified.
///    Returns <b>FALSE</b> if the relative distinguished name is not mangled or the mangle type is different than
///    specified.
///    
@DllImport("DSPARSE")
BOOL DsIsMangledRdnValueA(const(PSTR) pszRdn, uint cRdn, DS_MANGLE_FOR eDsMangleForDesired);

///The <b>DsIsMangledDn</b> function determines if the first relative distinguished name (RDN) in a distinguished name
///(DN) is a mangled name of a given type.
///Params:
///    pszDn = Pointer to a null-terminated string that contains the distinguished name to retrieve the relative distinguished
///            name from. This can also be a quoted distinguished name as returned by other directory service functions.
///    eDsMangleFor = Contains one of the DS_MANGLE_FOR values that specifies the type of name mangling to look for.
///Returns:
///    Returns <b>TRUE</b> if the first relative distinguished name in <i>pszDn</i> is mangled in the manner specified
///    by <i>eDsMangleFor</i> or <b>FALSE</b> otherwise.
///    
@DllImport("DSPARSE")
BOOL DsIsMangledDnA(const(PSTR) pszDn, DS_MANGLE_FOR eDsMangleFor);

///The <b>DsIsMangledDn</b> function determines if the first relative distinguished name (RDN) in a distinguished name
///(DN) is a mangled name of a given type.
///Params:
///    pszDn = Pointer to a null-terminated string that contains the distinguished name to retrieve the relative distinguished
///            name from. This can also be a quoted distinguished name as returned by other directory service functions.
///    eDsMangleFor = Contains one of the DS_MANGLE_FOR values that specifies the type of name mangling to look for.
///Returns:
///    Returns <b>TRUE</b> if the first relative distinguished name in <i>pszDn</i> is mangled in the manner specified
///    by <i>eDsMangleFor</i> or <b>FALSE</b> otherwise.
///    
@DllImport("DSPARSE")
BOOL DsIsMangledDnW(const(PWSTR) pszDn, DS_MANGLE_FOR eDsMangleFor);

@DllImport("DSPARSE")
uint DsCrackSpn2A(const(PSTR) pszSpn, uint cSpn, uint* pcServiceClass, PSTR ServiceClass, uint* pcServiceName, 
                  PSTR ServiceName, uint* pcInstanceName, PSTR InstanceName, ushort* pInstancePort);

@DllImport("DSPARSE")
uint DsCrackSpn2W(const(PWSTR) pszSpn, uint cSpn, uint* pcServiceClass, PWSTR ServiceClass, uint* pcServiceName, 
                  PWSTR ServiceName, uint* pcInstanceName, PWSTR InstanceName, ushort* pInstancePort);

@DllImport("DSPARSE")
uint DsCrackSpn3W(const(PWSTR) pszSpn, uint cSpn, uint* pcHostName, PWSTR HostName, uint* pcInstanceName, 
                  PWSTR InstanceName, ushort* pPortNumber, uint* pcDomainName, PWSTR DomainName, uint* pcRealmName, 
                  PWSTR RealmName);

@DllImport("DSPARSE")
uint DsCrackSpn4W(const(PWSTR) pszSpn, uint cSpn, uint* pcHostName, PWSTR HostName, uint* pcInstanceName, 
                  PWSTR InstanceName, uint* pcPortName, PWSTR PortName, uint* pcDomainName, PWSTR DomainName, 
                  uint* pcRealmName, PWSTR RealmName);

///The <b>DsBind</b> function binds to a domain controller.<b>DsBind</b> uses the default process credentials to bind to
///the domain controller. To specify alternate credentials, use the DsBindWithCred function.
///Params:
///    DomainControllerName = Pointer to a null-terminated string that contains the name of the domain controller to bind to. This name can be
///                           the name of the domain controller or the fully qualified DNS name of the domain controller. Either name type can,
///                           optionally, be preceded by two backslash characters. All of the following examples represent correctly formatted
///                           domain controller names: <ul> <li>"FAB-DC-01"</li> <li>"\\FAB-DC-01"</li> <li>"FAB-DC-01.fabrikam.com"</li>
///                           <li>"\\FAB-DC-01.fabrikam.com"</li> </ul> This parameter can be <b>NULL</b>. For more information, see Remarks.
///    DnsDomainName = Pointer to a null-terminated string that contains the fully qualified DNS name of the domain to bind to. This
///                    parameter can be <b>NULL</b>. For more information, see Remarks.
///    phDS = Address of a <b>HANDLE</b> value that receives the binding handle. To close this handle, pass it to the DsUnBind
///           function.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Windows or RPC error code otherwise. The following are the most
///    common error codes.
///    
@DllImport("NTDSAPI")
uint DsBindW(const(PWSTR) DomainControllerName, const(PWSTR) DnsDomainName, HANDLE* phDS);

///The <b>DsBind</b> function binds to a domain controller.<b>DsBind</b> uses the default process credentials to bind to
///the domain controller. To specify alternate credentials, use the DsBindWithCred function.
///Params:
///    DomainControllerName = Pointer to a null-terminated string that contains the name of the domain controller to bind to. This name can be
///                           the name of the domain controller or the fully qualified DNS name of the domain controller. Either name type can,
///                           optionally, be preceded by two backslash characters. All of the following examples represent correctly formatted
///                           domain controller names: <ul> <li>"FAB-DC-01"</li> <li>"\\FAB-DC-01"</li> <li>"FAB-DC-01.fabrikam.com"</li>
///                           <li>"\\FAB-DC-01.fabrikam.com"</li> </ul> This parameter can be <b>NULL</b>. For more information, see Remarks.
///    DnsDomainName = Pointer to a null-terminated string that contains the fully qualified DNS name of the domain to bind to. This
///                    parameter can be <b>NULL</b>. For more information, see Remarks.
///    phDS = Address of a <b>HANDLE</b> value that receives the binding handle. To close this handle, pass it to the DsUnBind
///           function.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Windows or RPC error code otherwise. The following are the most
///    common error codes.
///    
@DllImport("NTDSAPI")
uint DsBindA(const(PSTR) DomainControllerName, const(PSTR) DnsDomainName, HANDLE* phDS);

///The <b>DsBindWithCred</b> function binds to a domain controller using the specified credentials.
///Params:
///    DomainControllerName = Pointer to a null-terminated string that contains the fully qualified DNS name of the domain to bind. For more
///                           information about this parameter, see the <i>DomainControllerName</i> description in the DsBind topic.
///    DnsDomainName = Pointer to a null-terminated string that contains the fully qualified DNS name of the domain to bind to. For more
///                    information about this parameter, see the <i>DnsDomainName</i> description in the DsBind topic. This parameter is
///                    required to secure a Kerberos authentication.
///    AuthIdentity = Contains an RPC_AUTH_IDENTITY_HANDLE value that represents the credentials to be used for the bind. The
///                   DsMakePasswordCredentialsfunction is used to obtain this value. If this parameter is <b>NULL</b>, the credentials
///                   of the calling thread are used. DsUnBind must be called before freeing this handle with the
///                   DsFreePasswordCredentials function.
///    phDS = Address of a <b>HANDLE</b> value that receives the binding handle. To close this handle, pass it to the DsUnBind
///           function.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Windows or RPC error code otherwise. The following are the most
///    common error codes.
///    
@DllImport("NTDSAPI")
uint DsBindWithCredW(const(PWSTR) DomainControllerName, const(PWSTR) DnsDomainName, void* AuthIdentity, 
                     HANDLE* phDS);

///The <b>DsBindWithCred</b> function binds to a domain controller using the specified credentials.
///Params:
///    DomainControllerName = Pointer to a null-terminated string that contains the fully qualified DNS name of the domain to bind. For more
///                           information about this parameter, see the <i>DomainControllerName</i> description in the DsBind topic.
///    DnsDomainName = Pointer to a null-terminated string that contains the fully qualified DNS name of the domain to bind to. For more
///                    information about this parameter, see the <i>DnsDomainName</i> description in the DsBind topic. This parameter is
///                    required to secure a Kerberos authentication.
///    AuthIdentity = Contains an RPC_AUTH_IDENTITY_HANDLE value that represents the credentials to be used for the bind. The
///                   DsMakePasswordCredentialsfunction is used to obtain this value. If this parameter is <b>NULL</b>, the credentials
///                   of the calling thread are used. DsUnBind must be called before freeing this handle with the
///                   DsFreePasswordCredentials function.
///    phDS = Address of a <b>HANDLE</b> value that receives the binding handle. To close this handle, pass it to the DsUnBind
///           function.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Windows or RPC error code otherwise. The following are the most
///    common error codes.
///    
@DllImport("NTDSAPI")
uint DsBindWithCredA(const(PSTR) DomainControllerName, const(PSTR) DnsDomainName, void* AuthIdentity, HANDLE* phDS);

///The <b>DsBindWithSpn</b> function binds to a domain controller using the specified credentials and a specific service
///principal name (SPN) for mutual authentication. This function is provided for where complete control is required for
///mutual authentication. Do not use this function if you expect DsBind to find a server for you, because SPNs are
///computer-specific, and it is unlikely that the SPN you provide will match the server that <b>DsBind</b> finds for
///you. Providing a <b>NULL</b><i>ServicePrincipalName</i> argument results in behavior that is identical to
///DsBindWithCred.
///Params:
///    DomainControllerName = Pointer to a null-terminated string that contains the fully qualified DNS name of the domain to bind to. For more
///                           information, see the <i>DomainControllerName</i> description in the DsBind topic.
///    DnsDomainName = Pointer to a null-terminated string that contains the fully qualified DNS name of the domain to bind to. For more
///                    information, see the <i>DnsDomainName</i> description in the DsBind topic.
///    AuthIdentity = Contains an RPC_AUTH_IDENTITY_HANDLE value that represents the credentials to be used for the bind. The
///                   DsMakePasswordCredentialsfunction is used to obtain this value. If this parameter is <b>NULL</b>, the credentials
///                   of the calling thread are used. DsUnBind must be called before freeing this handle with the
///                   DsFreePasswordCredentials function.
///    ServicePrincipalName = Pointer to a null-terminated string that specifies the Service Principal Name to assign to the client. Passing
///                           <b>NULL</b> in <i>ServicePrincipalName</i> is equivalent to a call to the DsBindWithCred function.
///    phDS = Address of a <b>HANDLE</b> value that receives the binding handle. To close this handle, pass it to the DsUnBind
///           function.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Windows or RPC error code otherwise. The following are the most
///    common error codes.
///    
@DllImport("NTDSAPI")
uint DsBindWithSpnW(const(PWSTR) DomainControllerName, const(PWSTR) DnsDomainName, void* AuthIdentity, 
                    const(PWSTR) ServicePrincipalName, HANDLE* phDS);

///The <b>DsBindWithSpn</b> function binds to a domain controller using the specified credentials and a specific service
///principal name (SPN) for mutual authentication. This function is provided for where complete control is required for
///mutual authentication. Do not use this function if you expect DsBind to find a server for you, because SPNs are
///computer-specific, and it is unlikely that the SPN you provide will match the server that <b>DsBind</b> finds for
///you. Providing a <b>NULL</b><i>ServicePrincipalName</i> argument results in behavior that is identical to
///DsBindWithCred.
///Params:
///    DomainControllerName = Pointer to a null-terminated string that contains the fully qualified DNS name of the domain to bind to. For more
///                           information, see the <i>DomainControllerName</i> description in the DsBind topic.
///    DnsDomainName = Pointer to a null-terminated string that contains the fully qualified DNS name of the domain to bind to. For more
///                    information, see the <i>DnsDomainName</i> description in the DsBind topic.
///    AuthIdentity = Contains an RPC_AUTH_IDENTITY_HANDLE value that represents the credentials to be used for the bind. The
///                   DsMakePasswordCredentialsfunction is used to obtain this value. If this parameter is <b>NULL</b>, the credentials
///                   of the calling thread are used. DsUnBind must be called before freeing this handle with the
///                   DsFreePasswordCredentials function.
///    ServicePrincipalName = Pointer to a null-terminated string that specifies the Service Principal Name to assign to the client. Passing
///                           <b>NULL</b> in <i>ServicePrincipalName</i> is equivalent to a call to the DsBindWithCred function.
///    phDS = Address of a <b>HANDLE</b> value that receives the binding handle. To close this handle, pass it to the DsUnBind
///           function.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Windows or RPC error code otherwise. The following are the most
///    common error codes.
///    
@DllImport("NTDSAPI")
uint DsBindWithSpnA(const(PSTR) DomainControllerName, const(PSTR) DnsDomainName, void* AuthIdentity, 
                    const(PSTR) ServicePrincipalName, HANDLE* phDS);

///The <b>DsBindWithSpnEx</b> function binds to a domain controller using the specified credentials and a specific
///service principal name (SPN) for mutual authentication. This function is similar to the DsBindWithSpn function except
///this function allows more binding options with the <i>BindFlags</i> parameter. This function is provided where
///complete control is required over mutual authentication. Do not use this function if you expect DsBind to find a
///server for you, because SPNs are computer-specific, and it is unlikely that the SPN you provide will match the server
///that <b>DsBind</b> finds for you. Providing a <b>NULL</b><i>ServicePrincipalName</i> argument results in behavior
///that is identical to DsBindWithCred.
///Params:
///    DomainControllerName = Pointer to a null-terminated string that contains the fully qualified DNS name of the domain to bind. For more
///                           information, see the <i>DomainControllerName</i> description in the DsBind topic.
///    DnsDomainName = Pointer to a null-terminated string that contains the fully qualified DNS name of the domain to bind. For more
///                    information, see the <i>DnsDomainName</i> description in the DsBind topic.
///    AuthIdentity = Contains an RPC_AUTH_IDENTITY_HANDLE value that represents the credentials to be used for the bind. The
///                   DsMakePasswordCredentialsfunction is used to obtain this value. If this parameter is <b>NULL</b>, the credentials
///                   of the calling thread are used. DsUnBind must be called before freeing this handle with the
///                   DsFreePasswordCredentials function.
///    ServicePrincipalName = Pointer to a null-terminated string that specifies the Service Principal Name to assign to the client. Passing
///                           <b>NULL</b> in <i>ServicePrincipalName</i> is equivalent to a call to the DsBindWithCred function.
///    BindFlags = Contains a set of flags that define the behavior of this function. This parameter can contain zero or a
///                combination of the values listed in the following list.
///    phDS = Address of a <b>HANDLE</b> value that receives the binding handle. To close this handle, pass it to the DsUnBind
///           function.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Windows or RPC error code otherwise. The following list lists
///    common error codes.
///    
@DllImport("NTDSAPI")
uint DsBindWithSpnExW(const(PWSTR) DomainControllerName, const(PWSTR) DnsDomainName, void* AuthIdentity, 
                      const(PWSTR) ServicePrincipalName, uint BindFlags, HANDLE* phDS);

///The <b>DsBindWithSpnEx</b> function binds to a domain controller using the specified credentials and a specific
///service principal name (SPN) for mutual authentication. This function is similar to the DsBindWithSpn function except
///this function allows more binding options with the <i>BindFlags</i> parameter. This function is provided where
///complete control is required over mutual authentication. Do not use this function if you expect DsBind to find a
///server for you, because SPNs are computer-specific, and it is unlikely that the SPN you provide will match the server
///that <b>DsBind</b> finds for you. Providing a <b>NULL</b><i>ServicePrincipalName</i> argument results in behavior
///that is identical to DsBindWithCred.
///Params:
///    DomainControllerName = Pointer to a null-terminated string that contains the fully qualified DNS name of the domain to bind. For more
///                           information, see the <i>DomainControllerName</i> description in the DsBind topic.
///    DnsDomainName = Pointer to a null-terminated string that contains the fully qualified DNS name of the domain to bind. For more
///                    information, see the <i>DnsDomainName</i> description in the DsBind topic.
///    AuthIdentity = Contains an RPC_AUTH_IDENTITY_HANDLE value that represents the credentials to be used for the bind. The
///                   DsMakePasswordCredentialsfunction is used to obtain this value. If this parameter is <b>NULL</b>, the credentials
///                   of the calling thread are used. DsUnBind must be called before freeing this handle with the
///                   DsFreePasswordCredentials function.
///    ServicePrincipalName = Pointer to a null-terminated string that specifies the Service Principal Name to assign to the client. Passing
///                           <b>NULL</b> in <i>ServicePrincipalName</i> is equivalent to a call to the DsBindWithCred function.
///    BindFlags = Contains a set of flags that define the behavior of this function. This parameter can contain zero or a
///                combination of the values listed in the following list.
///    phDS = Address of a <b>HANDLE</b> value that receives the binding handle. To close this handle, pass it to the DsUnBind
///           function.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Windows or RPC error code otherwise. The following list lists
///    common error codes.
///    
@DllImport("NTDSAPI")
uint DsBindWithSpnExA(const(PSTR) DomainControllerName, const(PSTR) DnsDomainName, void* AuthIdentity, 
                      const(PSTR) ServicePrincipalName, uint BindFlags, HANDLE* phDS);

///The <b>DsBindByInstance</b> function explicitly binds to any AD LDS or Active Directory instance.
///Params:
///    ServerName = Pointer to a null-terminated string that specifies the name of the instance. This parameter is required to bind
///                 to an AD LDS instance. If this parameter is <b>NULL</b> when binding to an Active Directory instance, then the
///                 <i>DnsDomainName</i> parameter must contain a value. If this parameter and the <i>DnsDomainName</i> parameter are
///                 both <b>NULL</b>, the function fails with the return value <b>ERROR_INVALID_PARAMETER</b> (87).
///    Annotation = Pointer to a null-terminated string that specifies the port number of the AD LDS instance or <b>NULL</b> when
///                 binding to an Active Directory instance. For example, "389". If this parameter is <b>NULL</b> when binding by
///                 domain to an Active Directory instance, then the <i>DnsDomainName</i> parameter must be specified. If this
///                 parameter is <b>NULL</b> when binding to an AD LDS instance, then the <i>InstanceGuid</i> parameter must be
///                 specified.
///    InstanceGuid = Pointer to a <b>GUID</b> value that contains the <b>GUID</b> of the AD LDS instance. The <b>GUID</b> value is the
///                   <b>objectGUID</b> property of the <b>nTDSDSA</b> object of the instance. If this parameter is <b>NULL</b> when
///                   binding to an AD LDS instance, the <i>Annotation</i> parameter must be specified.
///    DnsDomainName = Pointer to a null-terminated string that specifies the DNS name of the domain when binding to an Active Directory
///                    instance by domain. Set this parameter to <b>NULL</b> to bind to an Active Directory instance by server or to an
///                    AD LDS instance.
///    AuthIdentity = Handle to the credentials used to start the RPC session. Use the DsMakePasswordCredentials function to create a
///                   structure suitable for <i>AuthIdentity</i>.
///    ServicePrincipalName = Pointer to a null-terminated string that specifies the Service Principal Name to assign to the client. Passing
///                           <b>NULL</b> in <i>ServicePrincipalName</i> is equivalent to a call to the DsBindWithCred function.
///    BindFlags = Contains a set of flags that define the behavior of this function. This parameter can contain zero or a
///                combination of one or more of the following values.
///    phDS = Address of a <b>HANDLE</b> value that receives the bind handle. To close this handle, call DsUnBind.
///Returns:
///    Returns <b>NO_ERROR</b> if successful or an RPC or Win32 error otherwise. Possible error codes include those
///    listed in the following list.
///    
@DllImport("NTDSAPI")
uint DsBindByInstanceW(const(PWSTR) ServerName, const(PWSTR) Annotation, GUID* InstanceGuid, 
                       const(PWSTR) DnsDomainName, void* AuthIdentity, const(PWSTR) ServicePrincipalName, 
                       uint BindFlags, HANDLE* phDS);

///The <b>DsBindByInstance</b> function explicitly binds to any AD LDS or Active Directory instance.
///Params:
///    ServerName = Pointer to a null-terminated string that specifies the name of the instance. This parameter is required to bind
///                 to an AD LDS instance. If this parameter is <b>NULL</b> when binding to an Active Directory instance, then the
///                 <i>DnsDomainName</i> parameter must contain a value. If this parameter and the <i>DnsDomainName</i> parameter are
///                 both <b>NULL</b>, the function fails with the return value <b>ERROR_INVALID_PARAMETER</b> (87).
///    Annotation = Pointer to a null-terminated string that specifies the port number of the AD LDS instance or <b>NULL</b> when
///                 binding to an Active Directory instance. For example, "389". If this parameter is <b>NULL</b> when binding by
///                 domain to an Active Directory instance, then the <i>DnsDomainName</i> parameter must be specified. If this
///                 parameter is <b>NULL</b> when binding to an AD LDS instance, then the <i>InstanceGuid</i> parameter must be
///                 specified.
///    InstanceGuid = Pointer to a <b>GUID</b> value that contains the <b>GUID</b> of the AD LDS instance. The <b>GUID</b> value is the
///                   <b>objectGUID</b> property of the <b>nTDSDSA</b> object of the instance. If this parameter is <b>NULL</b> when
///                   binding to an AD LDS instance, the <i>Annotation</i> parameter must be specified.
///    DnsDomainName = Pointer to a null-terminated string that specifies the DNS name of the domain when binding to an Active Directory
///                    instance by domain. Set this parameter to <b>NULL</b> to bind to an Active Directory instance by server or to an
///                    AD LDS instance.
///    AuthIdentity = Handle to the credentials used to start the RPC session. Use the DsMakePasswordCredentials function to create a
///                   structure suitable for <i>AuthIdentity</i>.
///    ServicePrincipalName = Pointer to a null-terminated string that specifies the Service Principal Name to assign to the client. Passing
///                           <b>NULL</b> in <i>ServicePrincipalName</i> is equivalent to a call to the DsBindWithCred function.
///    BindFlags = Contains a set of flags that define the behavior of this function. This parameter can contain zero or a
///                combination of one or more of the following values.
///    phDS = Address of a <b>HANDLE</b> value that receives the bind handle. To close this handle, call DsUnBind.
///Returns:
///    Returns <b>NO_ERROR</b> if successful or an RPC or Win32 error otherwise. Possible error codes include those
///    listed in the following list.
///    
@DllImport("NTDSAPI")
uint DsBindByInstanceA(const(PSTR) ServerName, const(PSTR) Annotation, GUID* InstanceGuid, 
                       const(PSTR) DnsDomainName, void* AuthIdentity, const(PSTR) ServicePrincipalName, 
                       uint BindFlags, HANDLE* phDS);

///The <b>DsBindToISTG</b> function binds to the computer that holds the Inter-Site Topology Generator (ISTG) role in
///the domain of the local computer.
///Params:
///    SiteName = Pointer to a null-terminated string that contains the site name used when binding. If this parameter is
///               <b>NULL</b>, the site of the nearest domain controller is used.
///    phDS = Address of a <b>HANDLE</b> value that receives the bind handle. To close this handle, call DsUnBind.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Win32 or RPC error code otherwise. The following are possible
///    error codes.
///    
@DllImport("NTDSAPI")
uint DsBindToISTGW(const(PWSTR) SiteName, HANDLE* phDS);

///The <b>DsBindToISTG</b> function binds to the computer that holds the Inter-Site Topology Generator (ISTG) role in
///the domain of the local computer.
///Params:
///    SiteName = Pointer to a null-terminated string that contains the site name used when binding. If this parameter is
///               <b>NULL</b>, the site of the nearest domain controller is used.
///    phDS = Address of a <b>HANDLE</b> value that receives the bind handle. To close this handle, call DsUnBind.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Win32 or RPC error code otherwise. The following are possible
///    error codes.
///    
@DllImport("NTDSAPI")
uint DsBindToISTGA(const(PSTR) SiteName, HANDLE* phDS);

///The <b>DsBindingSetTimeout</b> function sets the timeout value that is honored by all RPC calls that use the
///specified binding handle. RPC calls that required more time than the timeout value are canceled.
///Params:
///    hDS = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    cTimeoutSecs = Contains the new timeout value, in seconds.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Win32 or RPC error code otherwise. The following is a possible
///    error code.
///    
@DllImport("NTDSAPI")
uint DsBindingSetTimeout(HANDLE hDS, uint cTimeoutSecs);

///The <b>DsUnBind</b> function finds an RPC session with a domain controller and unbinds a handle to the directory
///service (DS).
///Params:
///    phDS = Pointer to a bind handle to the directory service. This handle is provided by a call to DsBind, DsBindWithCred,
///           or DsBindWithSpn.
///Returns:
///    <b>NO_ERROR</b>
///    
@DllImport("NTDSAPI")
uint DsUnBindW(HANDLE* phDS);

///The <b>DsUnBind</b> function finds an RPC session with a domain controller and unbinds a handle to the directory
///service (DS).
///Params:
///    phDS = Pointer to a bind handle to the directory service. This handle is provided by a call to DsBind, DsBindWithCred,
///           or DsBindWithSpn.
///Returns:
///    <b>NO_ERROR</b>
///    
@DllImport("NTDSAPI")
uint DsUnBindA(HANDLE* phDS);

///The <b>DsMakePasswordCredentials</b> function constructs a credential handle suitable for use with the DsBindWithCred
///function.
///Params:
///    User = Pointer to a null-terminated string that contains the user name to use for the credentials.
///    Domain = Pointer to a null-terminated string that contains the domain that the user is a member of.
///    Password = Pointer to a null-terminated string that contains the password to use for the credentials.
///    pAuthIdentity = Pointer to an RPC_AUTH_IDENTITY_HANDLE value that receives the credential handle. This handle is used in a
///                    subsequent call to DsBindWithCred. This handle must be freed with the DsFreePasswordCredentials function when it
///                    is no longer required.
///Returns:
///    Returns a Windows error code, including the following.
///    
@DllImport("NTDSAPI")
uint DsMakePasswordCredentialsW(const(PWSTR) User, const(PWSTR) Domain, const(PWSTR) Password, 
                                void** pAuthIdentity);

///The <b>DsMakePasswordCredentials</b> function constructs a credential handle suitable for use with the DsBindWithCred
///function.
///Params:
///    User = Pointer to a null-terminated string that contains the user name to use for the credentials.
///    Domain = Pointer to a null-terminated string that contains the domain that the user is a member of.
///    Password = Pointer to a null-terminated string that contains the password to use for the credentials.
///    pAuthIdentity = Pointer to an RPC_AUTH_IDENTITY_HANDLE value that receives the credential handle. This handle is used in a
///                    subsequent call to DsBindWithCred. This handle must be freed with the DsFreePasswordCredentials function when it
///                    is no longer required.
///Returns:
///    Returns a Windows error code, including the following.
///    
@DllImport("NTDSAPI")
uint DsMakePasswordCredentialsA(const(PSTR) User, const(PSTR) Domain, const(PSTR) Password, void** pAuthIdentity);

///The <b>DsFreePasswordCredentials</b> function frees memory allocated for a credentials structure by the
///DsMakePasswordCredentials function.
///Params:
///    AuthIdentity = Handle of the credential structure to be freed.
///Returns:
///    This function does not return a value.
///    
@DllImport("NTDSAPI")
void DsFreePasswordCredentials(void* AuthIdentity);

///The <b>DsCrackNames</b> function converts an array of directory service object names from one format to another. Name
///conversion enables client applications to map between the multiple names used to identify various directory service
///objects. For example, user objects can be identified by SAM account names (<i>Domain</i>&#92;<i>UserName</i>), user
///principal name (<i>UserName</i>@<i>Domain</i>.com), or distinguished name.
///Params:
///    hDS = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function. If <i>flags</i>
///          contains DS_NAME_FLAG_SYNTACTICAL_ONLY, <i>hDS</i> can be <b>NULL</b>.
///    flags = Contains one or more of the DS_NAME_FLAGS values used to determine how the name syntax will be cracked.
///    formatOffered = Contains one of the DS_NAME_FORMAT values that identifies the format of the input names. The <b>DS_LIST_NCS</b>
///                    value can also be passed for this parameter. This causes <b>DsCrackNames</b> to return the distinguished names of
///                    all naming contexts in the current forest. The <i>formatDesired</i> parameter is ignored. <i>cNames</i> must be
///                    at least one and all strings in <i>rpNames</i> must have a length greater than zero characters. The contents of
///                    the <i>rpNames</i> strings is ignored. <div class="alert"><b>Note</b> <b>DS_LIST_NCS</b> is not defined in a
///                    published header file. To use this value, define it in the exact format shown below.</div> <div> </div> ```cpp
///    formatDesired = Contains one of the DS_NAME_FORMAT values that identifies the format of the output names. The
///                    <b>DS_SID_OR_SID_HISTORY_NAME</b> value is not supported.
///    cNames = Contains the number of elements in the <i>rpNames</i> array.
///    rpNames = Pointer to an array of pointers to null-terminated strings that contain names to be converted.
///    ppResult = Pointer to a <b>PDS_NAME_RESULT</b> value that receives a DS_NAME_RESULT structure that contains the converted
///               names. The caller must free this memory, when it is no longer required, by calling DsFreeNameResult.
///Returns:
///    Returns a Win32 error value, an RPC error value, or one of the following.
///    
@DllImport("NTDSAPI")
uint DsCrackNamesW(HANDLE hDS, DS_NAME_FLAGS flags, DS_NAME_FORMAT formatOffered, DS_NAME_FORMAT formatDesired, 
                   uint cNames, const(PWSTR)* rpNames, DS_NAME_RESULTW** ppResult);

///The <b>DsCrackNames</b> function converts an array of directory service object names from one format to another. Name
///conversion enables client applications to map between the multiple names used to identify various directory service
///objects. For example, user objects can be identified by SAM account names (<i>Domain</i>&#92;<i>UserName</i>), user
///principal name (<i>UserName</i>@<i>Domain</i>.com), or distinguished name.
///Params:
///    hDS = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function. If <i>flags</i>
///          contains DS_NAME_FLAG_SYNTACTICAL_ONLY, <i>hDS</i> can be <b>NULL</b>.
///    flags = Contains one or more of the DS_NAME_FLAGS values used to determine how the name syntax will be cracked.
///    formatOffered = Contains one of the DS_NAME_FORMAT values that identifies the format of the input names. The <b>DS_LIST_NCS</b>
///                    value can also be passed for this parameter. This causes <b>DsCrackNames</b> to return the distinguished names of
///                    all naming contexts in the current forest. The <i>formatDesired</i> parameter is ignored. <i>cNames</i> must be
///                    at least one and all strings in <i>rpNames</i> must have a length greater than zero characters. The contents of
///                    the <i>rpNames</i> strings is ignored. <div class="alert"><b>Note</b> <b>DS_LIST_NCS</b> is not defined in a
///                    published header file. To use this value, define it in the exact format shown below.</div> <div> </div> ```cpp
///    formatDesired = Contains one of the DS_NAME_FORMAT values that identifies the format of the output names. The
///                    <b>DS_SID_OR_SID_HISTORY_NAME</b> value is not supported.
///    cNames = Contains the number of elements in the <i>rpNames</i> array.
///    rpNames = Pointer to an array of pointers to null-terminated strings that contain names to be converted.
///    ppResult = Pointer to a <b>PDS_NAME_RESULT</b> value that receives a DS_NAME_RESULT structure that contains the converted
///               names. The caller must free this memory, when it is no longer required, by calling DsFreeNameResult.
///Returns:
///    Returns a Win32 error value, an RPC error value, or one of the following.
///    
@DllImport("NTDSAPI")
uint DsCrackNamesA(HANDLE hDS, DS_NAME_FLAGS flags, DS_NAME_FORMAT formatOffered, DS_NAME_FORMAT formatDesired, 
                   uint cNames, const(PSTR)* rpNames, DS_NAME_RESULTA** ppResult);

///The <b>DsFreeNameResult</b> function frees the memory held by a DS_NAME_RESULT structure. Use this function to free
///the memory allocated by the DsCrackNames function.
///Params:
///    pResult = Pointer to the DS_NAME_RESULT structure to be freed.
@DllImport("NTDSAPI")
void DsFreeNameResultW(DS_NAME_RESULTW* pResult);

///The <b>DsFreeNameResult</b> function frees the memory held by a DS_NAME_RESULT structure. Use this function to free
///the memory allocated by the DsCrackNames function.
///Params:
///    pResult = Pointer to the DS_NAME_RESULT structure to be freed.
@DllImport("NTDSAPI")
void DsFreeNameResultA(DS_NAME_RESULTA* pResult);

///The <b>DsGetSpn</b> function constructs an array of one or more service principal names (SPNs). Each name in the
///array identifies an instance of a service. These SPNs may be registered with the directory service (DS) using the
///DsWriteAccountSpn function.
///Params:
///    ServiceType = Identifies the format of the SPNs to compose. The <i>ServiceType</i> parameter can have one of the following
///                  values.
///    ServiceClass = Pointer to a constant null-terminated string that specifies the class of the service; for example, http.
///                   Generally, this can be any string that is unique to the service.
///    ServiceName = Pointer to a constant null-terminated string that specifies the DNS name or distinguished name (DN) of the
///                  service. <i>ServiceName</i> is not required for a host-based service. For more information, see the description
///                  of the <i>ServiceType</i> parameter for the possible values of <i>ServiceName</i>.
///    InstancePort = Specifies the port number of the service instance. If this value is zero, the SPN does not include a port number.
///    cInstanceNames = Specifies the number of elements in the <i>pInstanceNames</i> and <i>pInstancePorts</i> arrays. If this value is
///                     zero, <i>pInstanceNames</i> must point to an array of <i>cInstanceNames</i> strings, and <i>pInstancePorts</i>
///                     can be either <b>NULL</b> or a pointer to an array of <i>cInstanceNames</i> port numbers. If this value is zero,
///                     <b>DsGetSpn</b> returns only one SPN in the <i>prpszSpn</i> array and <i>pInstanceNames</i> and
///                     <i>pInstancePorts</i> are ignored.
///    pInstanceNames = Pointer to an array of null-terminated strings that specify extra instance names (not used for host names). This
///                     parameter is ignored if <i>cInstanceNames</i> is zero. In that case, the <i>InstanceName</i> component of the SPN
///                     defaults to the fully qualified DNS name of the local computer or the NetBIOS name if <b>DS_SPN_NB_HOST</b> or
///                     <b>DS_SPN_NB_DOMAIN</b> is specified.
///    pInstancePorts = Pointer to an array of extra instance ports. If this value is non-<b>NULL</b>, it must point to an array of
///                     <i>cInstanceNames</i> port numbers. If this value is <b>NULL</b>, the SPNs do not include a port number. This
///                     parameter is ignored if <i>cInstanceNames</i> is zero.
///    pcSpn = Pointer to a variable that receives the number of SPNs contained in <i>prpszSpn</i>.
///    prpszSpn = Pointer to a variable that receives a pointer to an array of SPNs. This array must be freed with DsFreeSpnArray.
///Returns:
///    If the function returns an array of SPNs, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the
///    return value can be one of the following error codes.
///    
@DllImport("NTDSAPI")
uint DsGetSpnA(DS_SPN_NAME_TYPE ServiceType, const(PSTR) ServiceClass, const(PSTR) ServiceName, 
               ushort InstancePort, ushort cInstanceNames, PSTR* pInstanceNames, const(ushort)* pInstancePorts, 
               uint* pcSpn, PSTR** prpszSpn);

///The <b>DsGetSpn</b> function constructs an array of one or more service principal names (SPNs). Each name in the
///array identifies an instance of a service. These SPNs may be registered with the directory service (DS) using the
///DsWriteAccountSpn function.
///Params:
///    ServiceType = Identifies the format of the SPNs to compose. The <i>ServiceType</i> parameter can have one of the following
///                  values.
///    ServiceClass = Pointer to a constant null-terminated string that specifies the class of the service; for example, http.
///                   Generally, this can be any string that is unique to the service.
///    ServiceName = Pointer to a constant null-terminated string that specifies the DNS name or distinguished name (DN) of the
///                  service. <i>ServiceName</i> is not required for a host-based service. For more information, see the description
///                  of the <i>ServiceType</i> parameter for the possible values of <i>ServiceName</i>.
///    InstancePort = Specifies the port number of the service instance. If this value is zero, the SPN does not include a port number.
///    cInstanceNames = Specifies the number of elements in the <i>pInstanceNames</i> and <i>pInstancePorts</i> arrays. If this value is
///                     zero, <i>pInstanceNames</i> must point to an array of <i>cInstanceNames</i> strings, and <i>pInstancePorts</i>
///                     can be either <b>NULL</b> or a pointer to an array of <i>cInstanceNames</i> port numbers. If this value is zero,
///                     <b>DsGetSpn</b> returns only one SPN in the <i>prpszSpn</i> array and <i>pInstanceNames</i> and
///                     <i>pInstancePorts</i> are ignored.
///    pInstanceNames = Pointer to an array of null-terminated strings that specify extra instance names (not used for host names). This
///                     parameter is ignored if <i>cInstanceNames</i> is zero. In that case, the <i>InstanceName</i> component of the SPN
///                     defaults to the fully qualified DNS name of the local computer or the NetBIOS name if <b>DS_SPN_NB_HOST</b> or
///                     <b>DS_SPN_NB_DOMAIN</b> is specified.
///    pInstancePorts = Pointer to an array of extra instance ports. If this value is non-<b>NULL</b>, it must point to an array of
///                     <i>cInstanceNames</i> port numbers. If this value is <b>NULL</b>, the SPNs do not include a port number. This
///                     parameter is ignored if <i>cInstanceNames</i> is zero.
///    pcSpn = Pointer to a variable that receives the number of SPNs contained in <i>prpszSpn</i>.
///    prpszSpn = Pointer to a variable that receives a pointer to an array of SPNs. This array must be freed with DsFreeSpnArray.
///Returns:
///    If the function returns an array of SPNs, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the
///    return value can be one of the following error codes.
///    
@DllImport("NTDSAPI")
uint DsGetSpnW(DS_SPN_NAME_TYPE ServiceType, const(PWSTR) ServiceClass, const(PWSTR) ServiceName, 
               ushort InstancePort, ushort cInstanceNames, PWSTR* pInstanceNames, const(ushort)* pInstancePorts, 
               uint* pcSpn, PWSTR** prpszSpn);

///The <b>DsFreeSpnArray</b> function frees an array returned from the DsGetSpn function.
///Params:
///    cSpn = Specifies the number of elements contained in <i>rpszSpn</i>.
///    rpszSpn = Pointer to an array returned from DsGetSpn.
@DllImport("NTDSAPI")
void DsFreeSpnArrayA(uint cSpn, PSTR* rpszSpn);

///The <b>DsFreeSpnArray</b> function frees an array returned from the DsGetSpn function.
///Params:
///    cSpn = Specifies the number of elements contained in <i>rpszSpn</i>.
///    rpszSpn = Pointer to an array returned from DsGetSpn.
@DllImport("NTDSAPI")
void DsFreeSpnArrayW(uint cSpn, PWSTR* rpszSpn);

///The <b>DsWriteAccountSpn</b> function writes an array of service principal names (SPNs) to the
///<b>servicePrincipalName</b> attribute of a specified user or computer account object in Active Directory Domain
///Services. The function can either register or unregister the SPNs.
///Params:
///    hDS = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    Operation = Contains one of the DS_SPN_WRITE_OP values that specifies the operation that <b>DsWriteAccountSpn</b> will
///                perform.
///    pszAccount = Pointer to a constant null-terminated string that specifies the distinguished name of a user or computer object
///                 in Active Directory Domain Services. The caller must have write access to the <b>servicePrincipalName</b>
///                 property of this object.
///    cSpn = Specifies the number of SPNs in <i>rpszSpn</i>. If this value is zero, and <i>Operation</i> contains
///           <b>DS_SPN_REPLACE_SPN_OP</b>, the function removes all values from the <b>servicePrincipalName</b> attribute of
///           the specified account.
///    rpszSpn = Pointer to an array of constant null-terminated strings that specify the SPNs to be added to or removed from the
///              account identified by the <i>pszAccount</i> parameter. The DsGetSpn function is used to compose SPNs for a
///              service.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Win32, RPC or directory service error if unsuccessful.
///    
@DllImport("NTDSAPI")
uint DsWriteAccountSpnA(HANDLE hDS, DS_SPN_WRITE_OP Operation, const(PSTR) pszAccount, uint cSpn, PSTR* rpszSpn);

///The <b>DsWriteAccountSpn</b> function writes an array of service principal names (SPNs) to the
///<b>servicePrincipalName</b> attribute of a specified user or computer account object in Active Directory Domain
///Services. The function can either register or unregister the SPNs.
///Params:
///    hDS = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    Operation = Contains one of the DS_SPN_WRITE_OP values that specifies the operation that <b>DsWriteAccountSpn</b> will
///                perform.
///    pszAccount = Pointer to a constant null-terminated string that specifies the distinguished name of a user or computer object
///                 in Active Directory Domain Services. The caller must have write access to the <b>servicePrincipalName</b>
///                 property of this object.
///    cSpn = Specifies the number of SPNs in <i>rpszSpn</i>. If this value is zero, and <i>Operation</i> contains
///           <b>DS_SPN_REPLACE_SPN_OP</b>, the function removes all values from the <b>servicePrincipalName</b> attribute of
///           the specified account.
///    rpszSpn = Pointer to an array of constant null-terminated strings that specify the SPNs to be added to or removed from the
///              account identified by the <i>pszAccount</i> parameter. The DsGetSpn function is used to compose SPNs for a
///              service.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Win32, RPC or directory service error if unsuccessful.
///    
@DllImport("NTDSAPI")
uint DsWriteAccountSpnW(HANDLE hDS, DS_SPN_WRITE_OP Operation, const(PWSTR) pszAccount, uint cSpn, PWSTR* rpszSpn);

///The <b>DsClientMakeSpnForTargetServer</b> function constructs a service principal name (SPN) that identifies a
///specific server to use for authentication.
///Params:
///    ServiceClass = Pointer to a null-terminated string that contains the class of the service as defined by the service. This can be
///                   any string unique to the service.
///    ServiceName = Pointer to a null-terminated string that contains the distinguished name service (DNS) host name. This can either
///                  be a fully qualified name or an IP address in the Internet standard format. Use of an IP address for
///                  <i>ServiceName</i> is not recommended because this can create a security issue. Before the SPN is constructed,
///                  the IP address must be translated to a computer name through DNS name resolution. It is possible for the DNS name
///                  resolution to be spoofed, replacing the intended computer name with an unauthorized computer name.
///    pcSpnLength = Pointer to a <b>DWORD</b> value that, on entry, contains the size of the <i>pszSpn</i> buffer, in characters. On
///                  output, this parameter receives the number of characters copied to the <i>pszSpn</i> buffer, including the
///                  terminating <b>NULL</b>.
///    pszSpn = Pointer to a string buffer that receives the SPN.
///Returns:
///    This function returns standard Windows error codes.
///    
@DllImport("NTDSAPI")
uint DsClientMakeSpnForTargetServerW(const(PWSTR) ServiceClass, const(PWSTR) ServiceName, uint* pcSpnLength, 
                                     PWSTR pszSpn);

///The <b>DsClientMakeSpnForTargetServer</b> function constructs a service principal name (SPN) that identifies a
///specific server to use for authentication.
///Params:
///    ServiceClass = Pointer to a null-terminated string that contains the class of the service as defined by the service. This can be
///                   any string unique to the service.
///    ServiceName = Pointer to a null-terminated string that contains the distinguished name service (DNS) host name. This can either
///                  be a fully qualified name or an IP address in the Internet standard format. Use of an IP address for
///                  <i>ServiceName</i> is not recommended because this can create a security issue. Before the SPN is constructed,
///                  the IP address must be translated to a computer name through DNS name resolution. It is possible for the DNS name
///                  resolution to be spoofed, replacing the intended computer name with an unauthorized computer name.
///    pcSpnLength = Pointer to a <b>DWORD</b> value that, on entry, contains the size of the <i>pszSpn</i> buffer, in characters. On
///                  output, this parameter receives the number of characters copied to the <i>pszSpn</i> buffer, including the
///                  terminating <b>NULL</b>.
///    pszSpn = Pointer to a string buffer that receives the SPN.
///Returns:
///    This function returns standard Windows error codes.
///    
@DllImport("NTDSAPI")
uint DsClientMakeSpnForTargetServerA(const(PSTR) ServiceClass, const(PSTR) ServiceName, uint* pcSpnLength, 
                                     PSTR pszSpn);

///The <b>DsServerRegisterSpn</b> function composes two SPNs for a host-based service. The names are based on the DNS
///and NetBIOS names of the local computer. The function modifies the <b>servicePrincipalName</b> attribute of either a
///specified account or of the account associated with the calling thread. The function either registers or unregisters
///the SPNs. A host-based service is a service instance that provides services identified with its host computer, as
///distinguished from a replicable service where clients have no preference which host computer a service instance runs
///on.
///Params:
///    Operation = Specifies what operation <b>DsServerRegisterSpn</b> should perform. This parameter can have one of the following
///                values.
///    ServiceClass = Pointer to a constant null-terminated string specifying the class of the service. This parameter may be any
///                   string unique to that service; either the protocol name (for example, ldap) or the string form of a GUID will
///                   work.
///    UserObjectDN = Pointer to a constant null-terminated string specifying the distinguished name of a user or computer account
///                   object to write the SPNs to. If this parameter is <b>NULL</b>, <b>DsServerRegisterSpn</b> writes to the account
///                   object of the primary or impersonated user associated with the calling thread. If the thread is running in the
///                   security context of the LocalSystem account, the function writes to the account object of the local computer.
///Returns:
///    If the function successfully registers one or more SPNs, it returns <b>ERROR_SUCCESS</b>. Modification is
///    performed permissively, so that adding a value that already exists does not return an error.
///    
@DllImport("NTDSAPI")
uint DsServerRegisterSpnA(DS_SPN_WRITE_OP Operation, const(PSTR) ServiceClass, const(PSTR) UserObjectDN);

///The <b>DsServerRegisterSpn</b> function composes two SPNs for a host-based service. The names are based on the DNS
///and NetBIOS names of the local computer. The function modifies the <b>servicePrincipalName</b> attribute of either a
///specified account or of the account associated with the calling thread. The function either registers or unregisters
///the SPNs. A host-based service is a service instance that provides services identified with its host computer, as
///distinguished from a replicable service where clients have no preference which host computer a service instance runs
///on.
///Params:
///    Operation = Specifies what operation <b>DsServerRegisterSpn</b> should perform. This parameter can have one of the following
///                values.
///    ServiceClass = Pointer to a constant null-terminated string specifying the class of the service. This parameter may be any
///                   string unique to that service; either the protocol name (for example, ldap) or the string form of a GUID will
///                   work.
///    UserObjectDN = Pointer to a constant null-terminated string specifying the distinguished name of a user or computer account
///                   object to write the SPNs to. If this parameter is <b>NULL</b>, <b>DsServerRegisterSpn</b> writes to the account
///                   object of the primary or impersonated user associated with the calling thread. If the thread is running in the
///                   security context of the LocalSystem account, the function writes to the account object of the local computer.
///Returns:
///    If the function successfully registers one or more SPNs, it returns <b>ERROR_SUCCESS</b>. Modification is
///    performed permissively, so that adding a value that already exists does not return an error.
///    
@DllImport("NTDSAPI")
uint DsServerRegisterSpnW(DS_SPN_WRITE_OP Operation, const(PWSTR) ServiceClass, const(PWSTR) UserObjectDN);

///The <b>DsReplicaSync</b> function synchronizes a destination naming context (NC) with one of its sources.
///Params:
///    hDS = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    NameContext = Pointer to a constant null-terminated string that specifies the distinguished name of the destination NC.
///    pUuidDsaSrc = Pointer to the UUID of a source that replicates to the destination NC.
///    Options = Passes additional data used to process the request. This parameter can be a combination of the following values.
///Returns:
///    If the function performs its operation successfully, the return value is <b>ERROR_SUCCESS</b>. If the function
///    fails, the return value is one of the standard Win32 API errors.
///    
@DllImport("NTDSAPI")
uint DsReplicaSyncA(HANDLE hDS, const(PSTR) NameContext, const(GUID)* pUuidDsaSrc, uint Options);

///The <b>DsReplicaSync</b> function synchronizes a destination naming context (NC) with one of its sources.
///Params:
///    hDS = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    NameContext = Pointer to a constant null-terminated string that specifies the distinguished name of the destination NC.
///    pUuidDsaSrc = Pointer to the UUID of a source that replicates to the destination NC.
///    Options = Passes additional data used to process the request. This parameter can be a combination of the following values.
///Returns:
///    If the function performs its operation successfully, the return value is <b>ERROR_SUCCESS</b>. If the function
///    fails, the return value is one of the standard Win32 API errors.
///    
@DllImport("NTDSAPI")
uint DsReplicaSyncW(HANDLE hDS, const(PWSTR) NameContext, const(GUID)* pUuidDsaSrc, uint Options);

///The <b>DsReplicaAdd</b> function adds a replication source reference to a destination naming context.
///Params:
///    hDS = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    NameContext = The null-terminated string that specifies the distinguished name (DN) of the destination naming context (NC) for
///                  which to add the replica. The destination NC record must exist locally as either an object, instantiated or not,
///                  or a reference phantom, for example, a phantom with a GUID.
///    SourceDsaDn = The null-terminated string that specifies the DN of the <b>NTDS-DSA</b> object for the source directory system
///                  agent. This parameter is required if <i>Options</i> includes <b>DS_REPADD_ASYNCHRONOUS_REPLICA</b>; otherwise, it
///                  is ignored.
///    TransportDn = The null-terminated string that specifies the DN of the <b>interSiteTransport</b> object that represents the
///                  transport used for communication with the source server. This parameter is required if <i>Options</i> includes
///                  <b>DS_REPADD_INTERSITE_MESSAGING</b>; otherwise, it is ignored.
///    SourceDsaAddress = The null-terminated string that specifies the transport-specific address of the source DSA. This source server is
///                       identified by a string name, not by its UUID. A string name appropriate for <i>SourceDsaAddress</i> is usually a
///                       DNS name based on a GUID, where the GUID part of the name is the GUID of the <b>NTDS-DSA</b> object for the
///                       source server.
///    pSchedule = Pointer to a SCHEDULE structure that contains the replication schedule data for the replication source. This
///                parameter is optional and can be <b>NULL</b> if not used.
///    Options = Passes additional data to be used to process the request. This parameter can be a combination of the following
///              values.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value can
///    be one of the following.
///    
@DllImport("NTDSAPI")
uint DsReplicaAddA(HANDLE hDS, const(PSTR) NameContext, const(PSTR) SourceDsaDn, const(PSTR) TransportDn, 
                   const(PSTR) SourceDsaAddress, const(SCHEDULE)* pSchedule, uint Options);

///The <b>DsReplicaAdd</b> function adds a replication source reference to a destination naming context.
///Params:
///    hDS = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    NameContext = The null-terminated string that specifies the distinguished name (DN) of the destination naming context (NC) for
///                  which to add the replica. The destination NC record must exist locally as either an object, instantiated or not,
///                  or a reference phantom, for example, a phantom with a GUID.
///    SourceDsaDn = The null-terminated string that specifies the DN of the <b>NTDS-DSA</b> object for the source directory system
///                  agent. This parameter is required if <i>Options</i> includes <b>DS_REPADD_ASYNCHRONOUS_REPLICA</b>; otherwise, it
///                  is ignored.
///    TransportDn = The null-terminated string that specifies the DN of the <b>interSiteTransport</b> object that represents the
///                  transport used for communication with the source server. This parameter is required if <i>Options</i> includes
///                  <b>DS_REPADD_INTERSITE_MESSAGING</b>; otherwise, it is ignored.
///    SourceDsaAddress = The null-terminated string that specifies the transport-specific address of the source DSA. This source server is
///                       identified by a string name, not by its UUID. A string name appropriate for <i>SourceDsaAddress</i> is usually a
///                       DNS name based on a GUID, where the GUID part of the name is the GUID of the <b>NTDS-DSA</b> object for the
///                       source server.
///    pSchedule = Pointer to a SCHEDULE structure that contains the replication schedule data for the replication source. This
///                parameter is optional and can be <b>NULL</b> if not used.
///    Options = Passes additional data to be used to process the request. This parameter can be a combination of the following
///              values.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value can
///    be one of the following.
///    
@DllImport("NTDSAPI")
uint DsReplicaAddW(HANDLE hDS, const(PWSTR) NameContext, const(PWSTR) SourceDsaDn, const(PWSTR) TransportDn, 
                   const(PWSTR) SourceDsaAddress, const(SCHEDULE)* pSchedule, uint Options);

///The <b>DsReplicaDel</b> function removes a replication source reference from a destination naming context (NC).
///Params:
///    hDS = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    NameContext = Pointer to a constant null-terminated string that specifies the distinguished name (DN) of the destination NC
///                  from which to remove the replica. The destination NC record must exist locally as either an object, instantiated
///                  or not, or a reference phantom, for example, a phantom with a GUID.
///    DsaSrc = Pointer to a constant null-terminated Unicode string that specifies the transport-specific address of the source
///             directory system agent (DSA). This source server is identified by a string name, not by its <b>UUID</b>. A string
///             name appropriate for <i>DsaSrc</i> is usually a DNS name that is based on a <b>GUID</b>, where the <b>GUID</b>
///             part of the name is the <b>GUID</b> of the nTDSDSA object for the source server.
///    Options = Passes additional data used to process the request. This parameter can be a combination of the following values.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is a
///    standard Win32 API error or <b>ERROR_INVALID_PARAMETER</b> if a parameter is invalid.
///    
@DllImport("NTDSAPI")
uint DsReplicaDelA(HANDLE hDS, const(PSTR) NameContext, const(PSTR) DsaSrc, uint Options);

///The <b>DsReplicaDel</b> function removes a replication source reference from a destination naming context (NC).
///Params:
///    hDS = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    NameContext = Pointer to a constant null-terminated string that specifies the distinguished name (DN) of the destination NC
///                  from which to remove the replica. The destination NC record must exist locally as either an object, instantiated
///                  or not, or a reference phantom, for example, a phantom with a GUID.
///    DsaSrc = Pointer to a constant null-terminated Unicode string that specifies the transport-specific address of the source
///             directory system agent (DSA). This source server is identified by a string name, not by its <b>UUID</b>. A string
///             name appropriate for <i>DsaSrc</i> is usually a DNS name that is based on a <b>GUID</b>, where the <b>GUID</b>
///             part of the name is the <b>GUID</b> of the nTDSDSA object for the source server.
///    Options = Passes additional data used to process the request. This parameter can be a combination of the following values.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is a
///    standard Win32 API error or <b>ERROR_INVALID_PARAMETER</b> if a parameter is invalid.
///    
@DllImport("NTDSAPI")
uint DsReplicaDelW(HANDLE hDS, const(PWSTR) NameContext, const(PWSTR) DsaSrc, uint Options);

///The <b>DsReplicaModify</b> function modifies an existing replication source reference for a destination naming
///context.
///Params:
///    hDS = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    NameContext = Pointer to a constant null-terminated string that specifies the distinguished name (DN) of the destination naming
///                  context (NC).
///    pUuidSourceDsa = Pointer to the UUID of the source directory system agent (DSA). This parameter may be null if <i>ModifyFields</i>
///                     does not include <b>DS_REPMOD_UPDATE_ADDRESS</b> and <i>SourceDsaAddress</i> is not <b>NULL</b>.
///    TransportDn = Reserved for future use. Any value other than <b>NULL</b> results in <b>ERROR_NOT_SUPPORTED</b> being returned.
///    SourceDsaAddress = Pointer to a constant null-terminated Unicode string that specifies the transport-specific address of the source
///                       DSA. This parameter is ignored if <i>pUuidSourceDsa</i> is not <b>NULL</b> and <i>ModifyFields</i> does not
///                       include <b>DS_REPMOD_UPDATE_ADDRESS</b>.
///    pSchedule = Pointer to a SCHEDULE structure that contains the replication schedule data for the replication source. This
///                parameter is optional and can be <b>NULL</b> if not used. This parameter is required if <i>ModifyFields</i>
///                contains the <b>DS_REPMOD_UPDATE_SCHEDULE</b> flag.
///    ReplicaFlags = This parameter is used to control replication behavior and can take the following values.
///    ModifyFields = Specifies what fields should be modified. At least one field must be specified in <i>ModifyFields</i>. This
///                   parameter can be a combination of the following values.
///    Options = Passes additional data used to process the request. This parameter can be a combination of the following values.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value can
///    be one of the following.
///    
@DllImport("NTDSAPI")
uint DsReplicaModifyA(HANDLE hDS, const(PSTR) NameContext, const(GUID)* pUuidSourceDsa, const(PSTR) TransportDn, 
                      const(PSTR) SourceDsaAddress, const(SCHEDULE)* pSchedule, uint ReplicaFlags, uint ModifyFields, 
                      uint Options);

///The <b>DsReplicaModify</b> function modifies an existing replication source reference for a destination naming
///context.
///Params:
///    hDS = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    NameContext = Pointer to a constant null-terminated string that specifies the distinguished name (DN) of the destination naming
///                  context (NC).
///    pUuidSourceDsa = Pointer to the UUID of the source directory system agent (DSA). This parameter may be null if <i>ModifyFields</i>
///                     does not include <b>DS_REPMOD_UPDATE_ADDRESS</b> and <i>SourceDsaAddress</i> is not <b>NULL</b>.
///    TransportDn = Reserved for future use. Any value other than <b>NULL</b> results in <b>ERROR_NOT_SUPPORTED</b> being returned.
///    SourceDsaAddress = Pointer to a constant null-terminated Unicode string that specifies the transport-specific address of the source
///                       DSA. This parameter is ignored if <i>pUuidSourceDsa</i> is not <b>NULL</b> and <i>ModifyFields</i> does not
///                       include <b>DS_REPMOD_UPDATE_ADDRESS</b>.
///    pSchedule = Pointer to a SCHEDULE structure that contains the replication schedule data for the replication source. This
///                parameter is optional and can be <b>NULL</b> if not used. This parameter is required if <i>ModifyFields</i>
///                contains the <b>DS_REPMOD_UPDATE_SCHEDULE</b> flag.
///    ReplicaFlags = This parameter is used to control replication behavior and can take the following values.
///    ModifyFields = Specifies what fields should be modified. At least one field must be specified in <i>ModifyFields</i>. This
///                   parameter can be a combination of the following values.
///    Options = Passes additional data used to process the request. This parameter can be a combination of the following values.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value can
///    be one of the following.
///    
@DllImport("NTDSAPI")
uint DsReplicaModifyW(HANDLE hDS, const(PWSTR) NameContext, const(GUID)* pUuidSourceDsa, const(PWSTR) TransportDn, 
                      const(PWSTR) SourceDsaAddress, const(SCHEDULE)* pSchedule, uint ReplicaFlags, 
                      uint ModifyFields, uint Options);

///The <b>DsReplicaUpdateRefs</b> function adds or removes a replication reference for a destination from a source
///naming context.
///Params:
///    hDS = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    NameContext = Pointer to a constant null-terminated string that specifies the distinguished name of the source naming context.
///    DsaDest = Pointer to a constant null-terminated string that specifies the transport-specific address of the destination
///              directory system agent.
///    pUuidDsaDest = Pointer to a <b>UUID</b> value that contains the destination directory system agent.
///    Options = Contains a set of flags that provide additional data used to process the request. This can be zero or a
///              combination of one or more of the following values.
///Returns:
///    If the function succeeds, <b>ERROR_SUCCESS</b> is returned. If the function fails, the return value can be one of
///    the following.
///    
@DllImport("NTDSAPI")
uint DsReplicaUpdateRefsA(HANDLE hDS, const(PSTR) NameContext, const(PSTR) DsaDest, const(GUID)* pUuidDsaDest, 
                          uint Options);

///The <b>DsReplicaUpdateRefs</b> function adds or removes a replication reference for a destination from a source
///naming context.
///Params:
///    hDS = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    NameContext = Pointer to a constant null-terminated string that specifies the distinguished name of the source naming context.
///    DsaDest = Pointer to a constant null-terminated string that specifies the transport-specific address of the destination
///              directory system agent.
///    pUuidDsaDest = Pointer to a <b>UUID</b> value that contains the destination directory system agent.
///    Options = Contains a set of flags that provide additional data used to process the request. This can be zero or a
///              combination of one or more of the following values.
///Returns:
///    If the function succeeds, <b>ERROR_SUCCESS</b> is returned. If the function fails, the return value can be one of
///    the following.
///    
@DllImport("NTDSAPI")
uint DsReplicaUpdateRefsW(HANDLE hDS, const(PWSTR) NameContext, const(PWSTR) DsaDest, const(GUID)* pUuidDsaDest, 
                          uint Options);

///The <b>DsReplicaSyncAll</b> function synchronizes a server with all other servers, using transitive replication, as
///necessary. By default, <b>DsReplicaSyncAll</b> synchronizes the server with all other servers in its site; however,
///you can also use it to synchronize across site boundaries.
///Params:
///    hDS = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    pszNameContext = Pointer to a null-terminated string that specifies the distinguished name of the naming context to synchronize.
///                     The <i>pszNameContext</i> parameter is optional; if its value is <b>NULL</b>, the configuration naming context is
///                     replicated.
///    ulFlags = Passes additional data used to process the request. This parameter can be a combination of the following values.
///    pFnCallBack = Pointer to an application-defined SyncUpdateProc function called by the <b>DsReplicaSyncAll</b> function when it
///                  encounters an error, initiates synchronization of two servers, completes synchronization of two servers, or
///                  finishes synchronization of all the servers in the site.
///    pCallbackData = Pointer to application-defined data passed as the first argument of the SyncUpdateProc callback function pointed
///                    to by the <i>pFnCallBack</i> parameter.
///    pErrors = A NULL-terminated array of pointers to DS_REPSYNCALL_ERRINFO structures that contain errors that occurred during
///              synchronization. The memory used to hold both the array of pointers and the
///              MsCS\mscs\clusctl_resource_type_get_private_property_fmts.xml data is allocated as a single block of memory and
///              should be freed when no longer required by a single call to <b>LocalFree</b> with the pointer value returned in
///              <i>pErrors</i> used as the argument.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is as
///    follows.
///    
@DllImport("NTDSAPI")
uint DsReplicaSyncAllA(HANDLE hDS, const(PSTR) pszNameContext, uint ulFlags, BOOL*********** pFnCallBack, 
                       void* pCallbackData, DS_REPSYNCALL_ERRINFOA*** pErrors);

///The <b>DsReplicaSyncAll</b> function synchronizes a server with all other servers, using transitive replication, as
///necessary. By default, <b>DsReplicaSyncAll</b> synchronizes the server with all other servers in its site; however,
///you can also use it to synchronize across site boundaries.
///Params:
///    hDS = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    pszNameContext = Pointer to a null-terminated string that specifies the distinguished name of the naming context to synchronize.
///                     The <i>pszNameContext</i> parameter is optional; if its value is <b>NULL</b>, the configuration naming context is
///                     replicated.
///    ulFlags = Passes additional data used to process the request. This parameter can be a combination of the following values.
///    pFnCallBack = Pointer to an application-defined SyncUpdateProc function called by the <b>DsReplicaSyncAll</b> function when it
///                  encounters an error, initiates synchronization of two servers, completes synchronization of two servers, or
///                  finishes synchronization of all the servers in the site.
///    pCallbackData = Pointer to application-defined data passed as the first argument of the SyncUpdateProc callback function pointed
///                    to by the <i>pFnCallBack</i> parameter.
///    pErrors = A NULL-terminated array of pointers to DS_REPSYNCALL_ERRINFO structures that contain errors that occurred during
///              synchronization. The memory used to hold both the array of pointers and the
///              MsCS\mscs\clusctl_resource_type_get_private_property_fmts.xml data is allocated as a single block of memory and
///              should be freed when no longer required by a single call to <b>LocalFree</b> with the pointer value returned in
///              <i>pErrors</i> used as the argument.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is as
///    follows.
///    
@DllImport("NTDSAPI")
uint DsReplicaSyncAllW(HANDLE hDS, const(PWSTR) pszNameContext, uint ulFlags, BOOL*********** pFnCallBack, 
                       void* pCallbackData, DS_REPSYNCALL_ERRINFOW*** pErrors);

///The <b>DsRemoveDsServer</b> function removes all traces of a directory service agent (DSA) from the global area of
///the directory service.
///Params:
///    hDs = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    ServerDN = Pointer to a null-terminated string that specifies the fully qualified distinguished name of the domain
///               controller to remove.
///    DomainDN = Pointer to a null-terminated string that specifies a domain hosted by <i>ServerDN</i>. If this parameter is
///               <b>NULL</b>, no verification is performed to ensure that <i>ServerDN</i> is the last domain controller in
///               <i>DomainDN</i>.
///    fLastDcInDomain = Pointer to a Boolean value that receives <b>TRUE</b> if <i>ServerDN</i> is the last DC in <i>DomainDN</i> or
///                      <b>FALSE</b> otherwise. This parameter receives <b>FALSE</b> if <i>DomainDN</i> is <b>NULL</b>.
///    fCommit = Contains a Boolean value that specifies if the domain controller should actually be removed. If this parameter is
///              nonzero, <i>ServerDN</i> is removed. If this parameter is zero, the existence of <i>ServerDN</i> is checked and
///              <i>fLastDcInDomain</i> is written, but the domain controller is not removed.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Win32 or RPC error code if unsuccessful. Possible error codes
///    include the following.
///    
@DllImport("NTDSAPI")
uint DsRemoveDsServerW(HANDLE hDs, PWSTR ServerDN, PWSTR DomainDN, BOOL* fLastDcInDomain, BOOL fCommit);

///The <b>DsRemoveDsServer</b> function removes all traces of a directory service agent (DSA) from the global area of
///the directory service.
///Params:
///    hDs = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    ServerDN = Pointer to a null-terminated string that specifies the fully qualified distinguished name of the domain
///               controller to remove.
///    DomainDN = Pointer to a null-terminated string that specifies a domain hosted by <i>ServerDN</i>. If this parameter is
///               <b>NULL</b>, no verification is performed to ensure that <i>ServerDN</i> is the last domain controller in
///               <i>DomainDN</i>.
///    fLastDcInDomain = Pointer to a Boolean value that receives <b>TRUE</b> if <i>ServerDN</i> is the last DC in <i>DomainDN</i> or
///                      <b>FALSE</b> otherwise. This parameter receives <b>FALSE</b> if <i>DomainDN</i> is <b>NULL</b>.
///    fCommit = Contains a Boolean value that specifies if the domain controller should actually be removed. If this parameter is
///              nonzero, <i>ServerDN</i> is removed. If this parameter is zero, the existence of <i>ServerDN</i> is checked and
///              <i>fLastDcInDomain</i> is written, but the domain controller is not removed.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Win32 or RPC error code if unsuccessful. Possible error codes
///    include the following.
///    
@DllImport("NTDSAPI")
uint DsRemoveDsServerA(HANDLE hDs, PSTR ServerDN, PSTR DomainDN, BOOL* fLastDcInDomain, BOOL fCommit);

///The <b>DsRemoveDsDomain</b> function removes all traces of a domain naming context from the global area of the
///directory service.
///Params:
///    hDs = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    DomainDN = Pointer to a null-terminated string that specifies the distinguished name of the naming context to remove from
///               the directory service.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Win32 or RPC error code if unsuccessful. Possible error codes
///    include the following.
///    
@DllImport("NTDSAPI")
uint DsRemoveDsDomainW(HANDLE hDs, PWSTR DomainDN);

///The <b>DsRemoveDsDomain</b> function removes all traces of a domain naming context from the global area of the
///directory service.
///Params:
///    hDs = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    DomainDN = Pointer to a null-terminated string that specifies the distinguished name of the naming context to remove from
///               the directory service.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Win32 or RPC error code if unsuccessful. Possible error codes
///    include the following.
///    
@DllImport("NTDSAPI")
uint DsRemoveDsDomainA(HANDLE hDs, PSTR DomainDN);

///The <b>DsListSites</b> function lists all the sites in the enterprise forest.
///Params:
///    hDs = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    ppSites = Pointer to a pointer to a DS_NAME_RESULT structure that receives the list of sites in the enterprise. The site
///              name is returned in the distinguished name (DN) format. The returned structure must be freed using the
///              DsFreeNameResult function.
///Returns:
///    If the function returns a list of sites, the return value is <b>NO_ERROR</b>. If the function fails, the return
///    value can be one of the following error codes.
///    
@DllImport("NTDSAPI")
uint DsListSitesA(HANDLE hDs, DS_NAME_RESULTA** ppSites);

///The <b>DsListSites</b> function lists all the sites in the enterprise forest.
///Params:
///    hDs = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    ppSites = Pointer to a pointer to a DS_NAME_RESULT structure that receives the list of sites in the enterprise. The site
///              name is returned in the distinguished name (DN) format. The returned structure must be freed using the
///              DsFreeNameResult function.
///Returns:
///    If the function returns a list of sites, the return value is <b>NO_ERROR</b>. If the function fails, the return
///    value can be one of the following error codes.
///    
@DllImport("NTDSAPI")
uint DsListSitesW(HANDLE hDs, DS_NAME_RESULTW** ppSites);

///The <b>DsListServersInSite</b> function lists all the servers in a site.
///Params:
///    hDs = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    site = Pointer to a null-terminated string that specifies the site name. The site name uses a distinguished name format.
///           It is taken from the list of sites returned by the DsListSites function.
///    ppServers = Pointer to a pointer to a DS_NAME_RESULT structure that receives the list of servers in the site. The returned
///                structure must be freed using the DsFreeNameResult function.
///Returns:
///    If the function returns a list of servers, the return value is <b>NO_ERROR</b>. If the function fails, the return
///    value can be one of the following error codes.
///    
@DllImport("NTDSAPI")
uint DsListServersInSiteA(HANDLE hDs, const(PSTR) site, DS_NAME_RESULTA** ppServers);

///The <b>DsListServersInSite</b> function lists all the servers in a site.
///Params:
///    hDs = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    site = Pointer to a null-terminated string that specifies the site name. The site name uses a distinguished name format.
///           It is taken from the list of sites returned by the DsListSites function.
///    ppServers = Pointer to a pointer to a DS_NAME_RESULT structure that receives the list of servers in the site. The returned
///                structure must be freed using the DsFreeNameResult function.
///Returns:
///    If the function returns a list of servers, the return value is <b>NO_ERROR</b>. If the function fails, the return
///    value can be one of the following error codes.
///    
@DllImport("NTDSAPI")
uint DsListServersInSiteW(HANDLE hDs, const(PWSTR) site, DS_NAME_RESULTW** ppServers);

///The <b>DsListDomainsInSite</b> function lists all the domains in a site.
///Params:
///    hDs = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    site = Pointer to a null-terminated string that specifies the site name. This string is taken from the list of site
///           names returned by the DsListSites function.
///    ppDomains = Pointer to a pointer to a DS_NAME_RESULT structure that receives the list of domains in the site. To free the
///                returned structure, call the DsFreeNameResult function.
///Returns:
///    If the function returns a list of domains, the return value is <b>NO_ERROR</b>. If the function fails, the return
///    value can be one of the following error codes.
///    
@DllImport("NTDSAPI")
uint DsListDomainsInSiteA(HANDLE hDs, const(PSTR) site, DS_NAME_RESULTA** ppDomains);

///The <b>DsListDomainsInSite</b> function lists all the domains in a site.
///Params:
///    hDs = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    site = Pointer to a null-terminated string that specifies the site name. This string is taken from the list of site
///           names returned by the DsListSites function.
///    ppDomains = Pointer to a pointer to a DS_NAME_RESULT structure that receives the list of domains in the site. To free the
///                returned structure, call the DsFreeNameResult function.
///Returns:
///    If the function returns a list of domains, the return value is <b>NO_ERROR</b>. If the function fails, the return
///    value can be one of the following error codes.
///    
@DllImport("NTDSAPI")
uint DsListDomainsInSiteW(HANDLE hDs, const(PWSTR) site, DS_NAME_RESULTW** ppDomains);

///The <b>DsListServersForDomainInSite</b> function lists all the servers in a domain in a site.
///Params:
///    hDs = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    domain = Pointer to a null-terminated string that specifies the domain name. This string must be the same as one of the
///             strings returned by DsListDomainsInSite function.
///    site = Pointer to a null-terminated string that specifies the site name. This string is taken from the list of site
///           names returned by the DsListSites function.
///    ppServers = Pointer to a pointer to a DS_NAME_RESULT structure that receives the list of servers in the domain. The returned
///                structure must be freed using the DsFreeNameResult function.
///Returns:
///    If the function returns a list of servers, the return value is <b>NO_ERROR</b>. If the function fails, the return
///    value can be one of the following error codes.
///    
@DllImport("NTDSAPI")
uint DsListServersForDomainInSiteA(HANDLE hDs, const(PSTR) domain, const(PSTR) site, DS_NAME_RESULTA** ppServers);

///The <b>DsListServersForDomainInSite</b> function lists all the servers in a domain in a site.
///Params:
///    hDs = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    domain = Pointer to a null-terminated string that specifies the domain name. This string must be the same as one of the
///             strings returned by DsListDomainsInSite function.
///    site = Pointer to a null-terminated string that specifies the site name. This string is taken from the list of site
///           names returned by the DsListSites function.
///    ppServers = Pointer to a pointer to a DS_NAME_RESULT structure that receives the list of servers in the domain. The returned
///                structure must be freed using the DsFreeNameResult function.
///Returns:
///    If the function returns a list of servers, the return value is <b>NO_ERROR</b>. If the function fails, the return
///    value can be one of the following error codes.
///    
@DllImport("NTDSAPI")
uint DsListServersForDomainInSiteW(HANDLE hDs, const(PWSTR) domain, const(PWSTR) site, DS_NAME_RESULTW** ppServers);

///The <b>DsListInfoForServer</b> function lists miscellaneous data for a server.
///Params:
///    hDs = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    server = Pointer to a null-terminated string that specifies the server name. This name must be the same as one of the
///             strings returned by the DsListServersForDomainInSite or DsListServersInSite function.
///    ppInfo = Pointer to a variable that receives a pointer to a DS_NAME_RESULT structure that contains the server data. The
///             returned structure must be deallocated using DsFreeNameResult. The indexes of the array in the DS_NAME_RESULT
///             structure indicate what data are contained by each array element. The following constants may be used to specify
///             the desired index for a particular piece of data.
///Returns:
///    If the function returns server data, the return value is <b>NO_ERROR</b>. If the function fails, the return value
///    can be one of the following error codes.
///    
@DllImport("NTDSAPI")
uint DsListInfoForServerA(HANDLE hDs, const(PSTR) server, DS_NAME_RESULTA** ppInfo);

///The <b>DsListInfoForServer</b> function lists miscellaneous data for a server.
///Params:
///    hDs = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    server = Pointer to a null-terminated string that specifies the server name. This name must be the same as one of the
///             strings returned by the DsListServersForDomainInSite or DsListServersInSite function.
///    ppInfo = Pointer to a variable that receives a pointer to a DS_NAME_RESULT structure that contains the server data. The
///             returned structure must be deallocated using DsFreeNameResult. The indexes of the array in the DS_NAME_RESULT
///             structure indicate what data are contained by each array element. The following constants may be used to specify
///             the desired index for a particular piece of data.
///Returns:
///    If the function returns server data, the return value is <b>NO_ERROR</b>. If the function fails, the return value
///    can be one of the following error codes.
///    
@DllImport("NTDSAPI")
uint DsListInfoForServerW(HANDLE hDs, const(PWSTR) server, DS_NAME_RESULTW** ppInfo);

///The <b>DsListRoles</b> function lists roles recognized by the server.
///Params:
///    hDs = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    ppRoles = Pointer to a variable that receives a pointer to a DS_NAME_RESULT structure containing the roles the server
///              recognizes. The returned structure must be deallocated using DsFreeNameResult. The indexes of the array in the
///              DS_NAME_RESULT structure indicate what data are contained by each array element. The following constants may be
///              used to specify the desired index for a particular piece of data.
///Returns:
///    If the function returns a list of roles, the return value is <b>NO_ERROR</b>. If the function fails, the return
///    value can be one of the following error codes. Individual name conversion errors are reported in the returned
///    DS_NAME_RESULT structure.
///    
@DllImport("NTDSAPI")
uint DsListRolesA(HANDLE hDs, DS_NAME_RESULTA** ppRoles);

///The <b>DsListRoles</b> function lists roles recognized by the server.
///Params:
///    hDs = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    ppRoles = Pointer to a variable that receives a pointer to a DS_NAME_RESULT structure containing the roles the server
///              recognizes. The returned structure must be deallocated using DsFreeNameResult. The indexes of the array in the
///              DS_NAME_RESULT structure indicate what data are contained by each array element. The following constants may be
///              used to specify the desired index for a particular piece of data.
///Returns:
///    If the function returns a list of roles, the return value is <b>NO_ERROR</b>. If the function fails, the return
///    value can be one of the following error codes. Individual name conversion errors are reported in the returned
///    DS_NAME_RESULT structure.
///    
@DllImport("NTDSAPI")
uint DsListRolesW(HANDLE hDs, DS_NAME_RESULTW** ppRoles);

///The <b>DsQuerySitesByCost</b> function gets the communication cost between one site and one or more other sites.
///Params:
///    hDS = A directory service handle.
///    pwszFromSite = Pointer to a null-terminated string that contains the relative distinguished name of the site the costs are
///                   measured from.
///    rgwszToSites = Contains an array of null-terminated string pointers that contain the relative distinguished names of the sites
///                   the costs are measured to.
///    cToSites = Contains the number of elements in the <i>rgwszToSites</i> array.
///    dwFlags = Reserved.
///    prgSiteInfo = Pointer to an array of DS_SITE_COST_INFO structures that receives the cost data. Each element in this array
///                  contains the cost data between the site identified by the <i>pwszFromSite</i> parameter and the site identified
///                  by the corresponding <i>rgwszToSites</i> element. The caller must free this memory when it is no longer required
///                  by calling DsQuerySitesFree.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Win32 or RPC error code otherwise. Possible error codes include
///    values listed in the following list.
///    
@DllImport("NTDSAPI")
uint DsQuerySitesByCostW(HANDLE hDS, PWSTR pwszFromSite, PWSTR* rgwszToSites, uint cToSites, uint dwFlags, 
                         DS_SITE_COST_INFO** prgSiteInfo);

///The <b>DsQuerySitesByCost</b> function gets the communication cost between one site and one or more other sites.
///Params:
///    hDS = A directory service handle.
///    pszFromSite = Pointer to a null-terminated string that contains the relative distinguished name of the site the costs are
///                  measured from.
///    rgszToSites = Contains an array of null-terminated string pointers that contain the relative distinguished names of the sites
///                  the costs are measured to.
///    cToSites = Contains the number of elements in the <i>rgwszToSites</i> array.
///    dwFlags = Reserved.
///    prgSiteInfo = Pointer to an array of DS_SITE_COST_INFO structures that receives the cost data. Each element in this array
///                  contains the cost data between the site identified by the <i>pwszFromSite</i> parameter and the site identified
///                  by the corresponding <i>rgwszToSites</i> element. The caller must free this memory when it is no longer required
///                  by calling DsQuerySitesFree.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Win32 or RPC error code otherwise. Possible error codes include
///    values listed in the following list.
///    
@DllImport("NTDSAPI")
uint DsQuerySitesByCostA(HANDLE hDS, PSTR pszFromSite, PSTR* rgszToSites, uint cToSites, uint dwFlags, 
                         DS_SITE_COST_INFO** prgSiteInfo);

///The <b>DsQuerySitesFree</b> function frees the memory allocated by the DsQuerySitesByCost function.
///Params:
///    rgSiteInfo = Pointer to an array of DS_SITE_COST_INFO structures allocated by a call to DsQuerySitesByCost.
@DllImport("NTDSAPI")
void DsQuerySitesFree(DS_SITE_COST_INFO* rgSiteInfo);

///The <b>DsMapSchemaGuids</b> function converts GUIDs of directory service schema objects to their display names.
///Params:
///    hDs = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    cGuids = Indicates the number of elements in <i>rGuids</i>.
///    rGuids = Pointer to an array of <b>GUID</b> values for the objects to be mapped.
///    ppGuidMap = Pointer to a variable that receives a pointer to an array of DS_SCHEMA_GUID_MAP structures that contain the
///                display names of the objects in <i>rGuids</i>. This array must be deallocated using DsFreeSchemaGuidMap.
///Returns:
///    Returns a standard error code that includes the following values.
///    
@DllImport("NTDSAPI")
uint DsMapSchemaGuidsA(HANDLE hDs, uint cGuids, GUID* rGuids, DS_SCHEMA_GUID_MAPA** ppGuidMap);

///The <b>DsFreeSchemaGuidMap</b> function frees memory that the DsMapSchemaGuids function has allocated for a
///DS_SCHEMA_GUID_MAP structure.
///Params:
///    pGuidMap = Pointer to a DS_SCHEMA_GUID_MAP structure to deallocate.
///Returns:
///    This function does not return a value.
///    
@DllImport("NTDSAPI")
void DsFreeSchemaGuidMapA(DS_SCHEMA_GUID_MAPA* pGuidMap);

///The <b>DsMapSchemaGuids</b> function converts GUIDs of directory service schema objects to their display names.
///Params:
///    hDs = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    cGuids = Indicates the number of elements in <i>rGuids</i>.
///    rGuids = Pointer to an array of <b>GUID</b> values for the objects to be mapped.
///    ppGuidMap = Pointer to a variable that receives a pointer to an array of DS_SCHEMA_GUID_MAP structures that contain the
///                display names of the objects in <i>rGuids</i>. This array must be deallocated using DsFreeSchemaGuidMap.
///Returns:
///    Returns a standard error code that includes the following values.
///    
@DllImport("NTDSAPI")
uint DsMapSchemaGuidsW(HANDLE hDs, uint cGuids, GUID* rGuids, DS_SCHEMA_GUID_MAPW** ppGuidMap);

///The <b>DsFreeSchemaGuidMap</b> function frees memory that the DsMapSchemaGuids function has allocated for a
///DS_SCHEMA_GUID_MAP structure.
///Params:
///    pGuidMap = Pointer to a DS_SCHEMA_GUID_MAP structure to deallocate.
///Returns:
///    This function does not return a value.
///    
@DllImport("NTDSAPI")
void DsFreeSchemaGuidMapW(DS_SCHEMA_GUID_MAPW* pGuidMap);

///The <b>DsGetDomainControllerInfo</b> function retrieves data about the domain controllers in a domain.
///Params:
///    hDs = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    DomainName = Pointer to a null-terminated string that specifies the domain name.
///    InfoLevel = Contains a value that indicates the version of the <b>DS_DOMAIN_CONTROLLER_INFO</b> structure to return. This can
///                be one of the following values.
///    pcOut = Pointer to a <b>DWORD</b> variable that receives the number of items returned in <i>ppInfo</i> array.
///    ppInfo = Pointer to a pointer variable that receives an array of <b>DS_DOMAIN_CONTROLLER_INFO_*</b> structures. The type
///             of structures in this array is defined by the <i>InfoLevel</i> parameter. The caller must free this array, when
///             it is no longer required, by using the DsFreeDomainControllerInfo function.
///Returns:
///    If the function returns domain controller data, the return value is <b>ERROR_SUCCESS</b>. If the caller does not
///    have the privileges to access the server objects, the return value is <b>ERROR_SUCCESS</b>, but the
///    <b>DS_DOMAIN_CONTROLLER_INFO</b> structures could be empty. If the function fails, the return value can be one of
///    the following error codes.
///    
@DllImport("NTDSAPI")
uint DsGetDomainControllerInfoA(HANDLE hDs, const(PSTR) DomainName, uint InfoLevel, uint* pcOut, void** ppInfo);

///The <b>DsGetDomainControllerInfo</b> function retrieves data about the domain controllers in a domain.
///Params:
///    hDs = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    DomainName = Pointer to a null-terminated string that specifies the domain name.
///    InfoLevel = Contains a value that indicates the version of the <b>DS_DOMAIN_CONTROLLER_INFO</b> structure to return. This can
///                be one of the following values.
///    pcOut = Pointer to a <b>DWORD</b> variable that receives the number of items returned in <i>ppInfo</i> array.
///    ppInfo = Pointer to a pointer variable that receives an array of <b>DS_DOMAIN_CONTROLLER_INFO_*</b> structures. The type
///             of structures in this array is defined by the <i>InfoLevel</i> parameter. The caller must free this array, when
///             it is no longer required, by using the DsFreeDomainControllerInfo function.
///Returns:
///    If the function returns domain controller data, the return value is <b>ERROR_SUCCESS</b>. If the caller does not
///    have the privileges to access the server objects, the return value is <b>ERROR_SUCCESS</b>, but the
///    <b>DS_DOMAIN_CONTROLLER_INFO</b> structures could be empty. If the function fails, the return value can be one of
///    the following error codes.
///    
@DllImport("NTDSAPI")
uint DsGetDomainControllerInfoW(HANDLE hDs, const(PWSTR) DomainName, uint InfoLevel, uint* pcOut, void** ppInfo);

///The <b>DsFreeDomainControllerInfo</b> function frees memory that is allocated by DsGetDomainControllerInfo for data
///about the domain controllers in a domain.
///Params:
///    InfoLevel = Indicates what version of the <b>DS_DOMAIN_CONTROLLER_INFO</b> structure should be freed. This parameter can be
///                one of the following values.
///    cInfo = Indicates the number of items in <i>pInfo</i>.
///    pInfo = Pointer to an array of DS_DOMAIN_CONTROLLER_INFO structures to be freed.
///Returns:
///    This function does not return a value.
///    
@DllImport("NTDSAPI")
void DsFreeDomainControllerInfoA(uint InfoLevel, uint cInfo, void* pInfo);

///The <b>DsFreeDomainControllerInfo</b> function frees memory that is allocated by DsGetDomainControllerInfo for data
///about the domain controllers in a domain.
///Params:
///    InfoLevel = Indicates what version of the <b>DS_DOMAIN_CONTROLLER_INFO</b> structure should be freed. This parameter can be
///                one of the following values.
///    cInfo = Indicates the number of items in <i>pInfo</i>.
///    pInfo = Pointer to an array of DS_DOMAIN_CONTROLLER_INFO structures to be freed.
///Returns:
///    This function does not return a value.
///    
@DllImport("NTDSAPI")
void DsFreeDomainControllerInfoW(uint InfoLevel, uint cInfo, void* pInfo);

///The <b>DsReplicaConsistencyCheck</b> function invokes the Knowledge Consistency Checker (KCC) to verify the
///replication topology. The KCC dynamically adjusts the data replication topology of your network when domain
///controllers are added to or removed from the network, when a domain controller is unavailable, or when the data
///replication schedules are changed.
///Params:
///    hDS = Contains a directory service handle obtained from either the DSBind, DSBindWithCred, or DsBindWithSpn function.
///    TaskID = Identifies the task that the KCC should execute. <b>DS_KCC_TASKID_UPDATE_TOPOLOGY</b> is the only currently
///             supported value.
///    dwFlags = Contains a set of flags that modify the function behavior. This can be zero or a combination of one or more of
///              the following values.
///Returns:
///    If the function performs its operation successfully, the return value is <b>ERROR_SUCCESS</b>. If the function
///    fails, the return value can be one of the following.
///    
@DllImport("NTDSAPI")
uint DsReplicaConsistencyCheck(HANDLE hDS, DS_KCC_TASKID TaskID, uint dwFlags);

///The <b>DsReplicaVerifyObjects</b> function verifies all objects for a naming context with a source.
///Params:
///    hDS = Contains a directory service handle obtained from either the DSBind, DSBindWithCred, or DsBindWithSpn function.
///    NameContext = Pointer to a null-terminated string that contains the distinguished name of the naming context.
///    pUuidDsaSrc = Pointer to a <b>UUID</b> value that contains the <b>objectGuid</b> of the directory system agent object.
///    ulOptions = Contains a set of flags that modify the behavior of the function. This can be zero or the following value.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Win32 error otherwise. Possible error values include the
///    following.
///    
@DllImport("NTDSAPI")
uint DsReplicaVerifyObjectsW(HANDLE hDS, const(PWSTR) NameContext, const(GUID)* pUuidDsaSrc, uint ulOptions);

///The <b>DsReplicaVerifyObjects</b> function verifies all objects for a naming context with a source.
///Params:
///    hDS = Contains a directory service handle obtained from either the DSBind, DSBindWithCred, or DsBindWithSpn function.
///    NameContext = Pointer to a null-terminated string that contains the distinguished name of the naming context.
///    pUuidDsaSrc = Pointer to a <b>UUID</b> value that contains the <b>objectGuid</b> of the directory system agent object.
///    ulOptions = Contains a set of flags that modify the behavior of the function. This can be zero or the following value.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Win32 error otherwise. Possible error values include the
///    following.
///    
@DllImport("NTDSAPI")
uint DsReplicaVerifyObjectsA(HANDLE hDS, const(PSTR) NameContext, const(GUID)* pUuidDsaSrc, uint ulOptions);

///The <b>DsReplicaGetInfo</b> function retrieves replication state data from the directory service.
///Params:
///    hDS = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    InfoType = Contains one of the DS_REPL_INFO_TYPE values that specifies the type of replication data to retrieve. This value
///               also determines which type of structure is returned in <i>ppInfo</i>. Only the following values are supported for
///               this function. If other data types are required, the DsReplicaGetInfo2 function must be used. <a
///               id="DS_REPL_INFO_NEIGHBORS"></a> <a id="ds_repl_info_neighbors"></a>
///    pszObject = Pointer to a constant null-terminated Unicode string that identifies the object to retrieve replication data for.
///                The meaning of this parameter depends on the value of the <i>InfoType</i> parameter. The following are possible
///                value codes.
///    puuidForSourceDsaObjGuid = Pointer to a <b>GUID</b> value that identifies a specific replication source. If this parameter is not
///                               <b>NULL</b> and the <i>InfoType</i> parameter contains <b>DS_REPL_INFO_NEIGHBORS</b>, only neighbor data for the
///                               source corresponding to the nTDSDSA object with the given <b>objectGuid</b> in the directory is returned. This
///                               parameter is ignored if <b>NULL</b> or if the <i>InfoType</i> parameter is anything other than
///                               <b>DS_REPL_INFO_NEIGHBORS</b>.
///    ppInfo = Address of a structure pointer that receives the requested data. The value of the <i>InfoType</i> parameter
///             determines the format of this structure. For more information and list of possible <i>InfoType</i> values and the
///             corresponding structure types, see DS_REPL_INFO_TYPE. The caller must free this memory when it is no longer
///             required by calling DsReplicaFreeInfo.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Win32 or RPC error otherwise. The following are possible error
///    codes.
///    
@DllImport("NTDSAPI")
uint DsReplicaGetInfoW(HANDLE hDS, DS_REPL_INFO_TYPE InfoType, const(PWSTR) pszObject, 
                       GUID* puuidForSourceDsaObjGuid, void** ppInfo);

///The <b>DsReplicaGetInfo2</b> function retrieves replication state data from the directory service. This function
///allows paging of results in cases where there are more than 1000 entries to retrieve.
///Params:
///    hDS = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    InfoType = Contains one of the DS_REPL_INFO_TYPE values that specifies the type of replication data to retrieve. This value
///               also determines which type of structure is returned in <i>ppInfo</i>.
///    pszObject = Pointer to a constant null-terminated Unicode string that identifies the object to retrieve replication data for.
///                The meaning of this parameter depends on the value of the <i>InfoType</i> parameter. The following are possible
///                value codes.
///    puuidForSourceDsaObjGuid = Pointer to a <b>GUID</b> value that identifies a specific replication source. If this parameter is not
///                               <b>NULL</b> and the <i>InfoType</i> parameter contains <b>DS_REPL_INFO_NEIGHBORS</b>, only neighbor data for the
///                               source corresponding to the nTDSDSA object with the given <b>objectGuid</b> in the directory is returned. This
///                               parameter is ignored if <b>NULL</b> or if the <i>InfoType</i> parameter is anything other than
///                               <b>DS_REPL_INFO_NEIGHBORS</b>.
///    pszAttributeName = Pointer to a null-terminated Unicode string that contains the name of the specific attribute to retrieve
///                       replication data for. This parameter is only used if the <i>InfoType</i> parameter contains one of the following
///                       values. <a id="DS_REPL_INFO_METADATA_FOR_ATTR_VALUE"></a> <a id="ds_repl_info_metadata_for_attr_value"></a>
///    pszValue = Pointer to a null-terminated Unicode string that contains the distinguished name value to match. If the requested
///               attribute is a distinguished name type value, this function return the attributes that contain the specified
///               value.
///    dwFlags = Contains a set of flags that modify the behavior of the function. This parameter can be zero or the following
///              value.
///    dwEnumerationContext = Contains the index of the next entry to retrieve. This parameter must be set to zero the first time this function
///                           is called. This parameter is only used if the <i>InfoType</i> parameter contains one of the following values. <a
///                           id="DS_REPL_INFO_CURSORS_2_FOR_NC"></a> <a id="ds_repl_info_cursors_2_for_nc"></a>
///    ppInfo = Address of a structure pointer that receives the requested data. The value of the <i>InfoType</i> parameter
///             determines the format of this structure. For more information and a list of possible <i>InfoType</i> values and
///             the corresponding structure types, see DS_REPL_INFO_TYPE. The caller must free this memory when it is no longer
///             required by calling DsReplicaFreeInfo.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Win32 or RPC error otherwise. The following are possible error
///    codes.
///    
@DllImport("NTDSAPI")
uint DsReplicaGetInfo2W(HANDLE hDS, DS_REPL_INFO_TYPE InfoType, const(PWSTR) pszObject, 
                        GUID* puuidForSourceDsaObjGuid, const(PWSTR) pszAttributeName, const(PWSTR) pszValue, 
                        uint dwFlags, uint dwEnumerationContext, void** ppInfo);

///The <b>DsReplicaFreeInfo</b> function frees the replication state data structure allocated by the DsReplicaGetInfo or
///DsReplicaGetInfo2 functions.
///Params:
///    InfoType = Contains one of the DS_REPL_INFO_TYPE values that specifies the type of replication data structure contained in
///               <i>pInfo</i>. This must be the same value passed to the DsReplicaGetInfo or DsReplicaGetInfo2 function when the
///               structure was allocated.
///    pInfo = Pointer to the replication data structure allocated by the DsReplicaGetInfo or DsReplicaGetInfo2 functions.
@DllImport("NTDSAPI")
void DsReplicaFreeInfo(DS_REPL_INFO_TYPE InfoType, void* pInfo);

///The <b>DsAddSidHistory</b> function retrieves the primary account security identifier (SID) of a security principal
///from one domain and adds it to the <b>sIDHistory</b> attribute of a security principal in another domain in a
///different forest. When the source domain is in Windows 2000 native mode, this function also retrieves the
///<b>sIDHistory</b> values of the source principal and adds them to the destination principal <b>sIDHistory</b>. The
///<b>DsAddSidHistory</b> function performs a security-sensitive function by adding the primary account SID of an
///existing security principal to the <b>sIDHistory</b> of a principal in a domain in a different forest, effectively
///granting to the latter access to all resources accessible to the former. For more information about the use and
///security implications of this function, see Using DsAddSidHistory.
///Params:
///    hDS = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    Flags = Reserved for future use. Set to <b>NULL</b>.
///    SrcDomain = Pointer to a null-terminated string that specifies the name of the domain to query for the SID of
///                <i>SrcPrincipal</i>. If the source domain runs on Windows Server operating systems, <i>SrcDomain</i> can be
///                either a domain name system (DNS) name, for example, fabrikam.com, or a flat NetBIOS, for example, Fabrikam,
///                name. DNS names should be used when possible.
///    SrcPrincipal = Pointer to a null-terminated string that specifies the name of a security principal, user or group, in the source
///                   domain. This name is a domain-relative Security Account Manager (SAM) name, for example: evacorets.
///    SrcDomainController = Pointer to a null-terminated string that specifies the name of the primary domain controller (PDC) Emulator in
///                          the source domain to use for secure retrieval of the source principal SID and audit generation. If this parameter
///                          is <b>NULL</b>, DSBindWithCred will select the primary domain controller. <i>SrcDomainController</i> can be
///                          either a DNS name or a flat NetBIOS name. DNS names should be used when possible.
///    SrcDomainCreds = Contains an identity handle that represents the identity and credentials of a user with administrative rights in
///                     the source domain. To obtain this handle, call DsMakePasswordCredentials. This user must be a member of either
///                     the Administrators or the Domain Administrators group. If this call is made from a remote computer to the
///                     destination DC, then both the remote computer and the destination DC must support 128-bit encryption to
///                     privacy-protect the credentials. If 128-bit encryption is unavailable and <i>SrcDomainCreds</i> are provided,
///                     then the call must be made on the destination DC. If this parameter is <b>NULL</b>, the credentials of the caller
///                     are used for access to the source domain.
///    DstDomain = Pointer to a null-terminated string that specifies the name of the destination domain in which
///                <i>DstPrincipal</i> resides. This name can either be a DNS name, for example, fabrikam.com, or a NetBIOS name,
///                for example, Fabrikam. The destination domain must run Windows 2000 native mode.
///    DstPrincipal = Pointer to a null-terminated string that specifies the name of a security principal, user or group, in the
///                   destination domain. This domain-relative SAM name identifies the principal whose <b>sIDHistory</b> attribute is
///                   updated with the SID of the <i>SrcPrincipal</i>.
///Returns:
///    Returns a Win32 error codes including the following.
///    
@DllImport("NTDSAPI")
uint DsAddSidHistoryW(HANDLE hDS, uint Flags, const(PWSTR) SrcDomain, const(PWSTR) SrcPrincipal, 
                      const(PWSTR) SrcDomainController, void* SrcDomainCreds, const(PWSTR) DstDomain, 
                      const(PWSTR) DstPrincipal);

///The <b>DsAddSidHistory</b> function retrieves the primary account security identifier (SID) of a security principal
///from one domain and adds it to the <b>sIDHistory</b> attribute of a security principal in another domain in a
///different forest. When the source domain is in Windows 2000 native mode, this function also retrieves the
///<b>sIDHistory</b> values of the source principal and adds them to the destination principal <b>sIDHistory</b>. The
///<b>DsAddSidHistory</b> function performs a security-sensitive function by adding the primary account SID of an
///existing security principal to the <b>sIDHistory</b> of a principal in a domain in a different forest, effectively
///granting to the latter access to all resources accessible to the former. For more information about the use and
///security implications of this function, see Using DsAddSidHistory.
///Params:
///    hDS = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    Flags = Reserved for future use. Set to <b>NULL</b>.
///    SrcDomain = Pointer to a null-terminated string that specifies the name of the domain to query for the SID of
///                <i>SrcPrincipal</i>. If the source domain runs on Windows Server operating systems, <i>SrcDomain</i> can be
///                either a domain name system (DNS) name, for example, fabrikam.com, or a flat NetBIOS, for example, Fabrikam,
///                name. DNS names should be used when possible.
///    SrcPrincipal = Pointer to a null-terminated string that specifies the name of a security principal, user or group, in the source
///                   domain. This name is a domain-relative Security Account Manager (SAM) name, for example: evacorets.
///    SrcDomainController = Pointer to a null-terminated string that specifies the name of the primary domain controller (PDC) Emulator in
///                          the source domain to use for secure retrieval of the source principal SID and audit generation. If this parameter
///                          is <b>NULL</b>, DSBindWithCred will select the primary domain controller. <i>SrcDomainController</i> can be
///                          either a DNS name or a flat NetBIOS name. DNS names should be used when possible.
///    SrcDomainCreds = Contains an identity handle that represents the identity and credentials of a user with administrative rights in
///                     the source domain. To obtain this handle, call DsMakePasswordCredentials. This user must be a member of either
///                     the Administrators or the Domain Administrators group. If this call is made from a remote computer to the
///                     destination DC, then both the remote computer and the destination DC must support 128-bit encryption to
///                     privacy-protect the credentials. If 128-bit encryption is unavailable and <i>SrcDomainCreds</i> are provided,
///                     then the call must be made on the destination DC. If this parameter is <b>NULL</b>, the credentials of the caller
///                     are used for access to the source domain.
///    DstDomain = Pointer to a null-terminated string that specifies the name of the destination domain in which
///                <i>DstPrincipal</i> resides. This name can either be a DNS name, for example, fabrikam.com, or a NetBIOS name,
///                for example, Fabrikam. The destination domain must run Windows 2000 native mode.
///    DstPrincipal = Pointer to a null-terminated string that specifies the name of a security principal, user or group, in the
///                   destination domain. This domain-relative SAM name identifies the principal whose <b>sIDHistory</b> attribute is
///                   updated with the SID of the <i>SrcPrincipal</i>.
///Returns:
///    Returns a Win32 error codes including the following.
///    
@DllImport("NTDSAPI")
uint DsAddSidHistoryA(HANDLE hDS, uint Flags, const(PSTR) SrcDomain, const(PSTR) SrcPrincipal, 
                      const(PSTR) SrcDomainController, void* SrcDomainCreds, const(PSTR) DstDomain, 
                      const(PSTR) DstPrincipal);

///The <b>DsInheritSecurityIdentity</b> function appends the <b>objectSid</b> and <b>sidHistory</b> attributes of
///<i>SrcPrincipal</i> to the <b>sidHistory</b> of <i>DstPrincipal</i> and then deletes <i>SrcPrincipal</i>, all in a
///single transaction. To ensure that this operation is atomic, <i>SrcPrincipal</i> and <i>DstPrincipal</i> must be in
///the same domain and <i>hDS</i> must be bound to a domain controller that the correct permissions within that domain.
///Params:
///    hDS = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    Flags = Reserved for future use. Must be zero.
///    SrcPrincipal = Pointer to a null-terminated string that specifies the name of a security principal (user or group) in the source
///                   domain. This name is a domain-relative SAM name.
///    DstPrincipal = Pointer to a null-terminated string that specifies the name of a security principal (user or group) in the
///                   destination domain. This domain-relative SAM name identifies the principal whose <b>sidHistory</b> attribute will
///                   be updated with the SID of <i>SrcPrincipal</i>.
///Returns:
///    Returns a system or RPC error code including the following.
///    
@DllImport("NTDSAPI")
uint DsInheritSecurityIdentityW(HANDLE hDS, uint Flags, const(PWSTR) SrcPrincipal, const(PWSTR) DstPrincipal);

///The <b>DsInheritSecurityIdentity</b> function appends the <b>objectSid</b> and <b>sidHistory</b> attributes of
///<i>SrcPrincipal</i> to the <b>sidHistory</b> of <i>DstPrincipal</i> and then deletes <i>SrcPrincipal</i>, all in a
///single transaction. To ensure that this operation is atomic, <i>SrcPrincipal</i> and <i>DstPrincipal</i> must be in
///the same domain and <i>hDS</i> must be bound to a domain controller that the correct permissions within that domain.
///Params:
///    hDS = Contains a directory service handle obtained from either the DSBind or DSBindWithCred function.
///    Flags = Reserved for future use. Must be zero.
///    SrcPrincipal = Pointer to a null-terminated string that specifies the name of a security principal (user or group) in the source
///                   domain. This name is a domain-relative SAM name.
///    DstPrincipal = Pointer to a null-terminated string that specifies the name of a security principal (user or group) in the
///                   destination domain. This domain-relative SAM name identifies the principal whose <b>sidHistory</b> attribute will
///                   be updated with the SID of <i>SrcPrincipal</i>.
///Returns:
///    Returns a system or RPC error code including the following.
///    
@DllImport("NTDSAPI")
uint DsInheritSecurityIdentityA(HANDLE hDS, uint Flags, const(PSTR) SrcPrincipal, const(PSTR) DstPrincipal);

///The <b>DsRoleGetPrimaryDomainInformation</b> function retrieves state data for the computer. This data includes the
///state of the directory service installation and domain data.
///Params:
///    lpServer = Pointer to null-terminated Unicode string that contains the name of the computer on which to call the function.
///               If this parameter is <b>NULL</b>, the local computer is used.
///    InfoLevel = Contains one of the DSROLE_PRIMARY_DOMAIN_INFO_LEVEL values that specify the type of data to retrieve. This
///                parameter also determines the format of the data supplied in <i>Buffer</i>.
///    Buffer = Pointer to the address of a buffer that receives the requested data. The format of this data depends on the value
///             of the <i>InfoLevel</i> parameter. The caller must free this memory when it is no longer required by calling
///             DsRoleFreeMemory.
///Returns:
///    If the function is successful, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value
///    can be one of the following values.
///    
@DllImport("DSROLE")
uint DsRoleGetPrimaryDomainInformation(const(PWSTR) lpServer, DSROLE_PRIMARY_DOMAIN_INFO_LEVEL InfoLevel, 
                                       ubyte** Buffer);

///The <b>DsRoleFreeMemory</b> function frees memory allocated by the DsRoleGetPrimaryDomainInformation function.
///Params:
///    Buffer = Pointer to the buffer to be freed.
@DllImport("DSROLE")
void DsRoleFreeMemory(void* Buffer);

///The <b>DsGetDcName</b> function returns the name of a domain controller in a specified domain. This function accepts
///additional domain controller selection criteria to indicate preference for a domain controller with particular
///characteristics.
///Params:
///    ComputerName = Pointer to a null-terminated string that specifies the name of the server to process this function. Typically,
///                   this parameter is <b>NULL</b>, which indicates that the local computer is used.
///    DomainName = Pointer to a null-terminated string that specifies the name of the domain or application partition to query. This
///                 name can either be a DNS style name, for example, fabrikam.com, or a flat-style name, for example, Fabrikam. If a
///                 DNS style name is specified, the name may be specified with or without a trailing period. If the <i>Flags</i>
///                 parameter contains the <b>DS_GC_SERVER_REQUIRED</b> flag, <i>DomainName</i> must be the name of the forest. In
///                 this case, <b>DsGetDcName</b> fails if <i>DomainName</i> specifies a name that is not the forest root. If the
///                 <i>Flags</i> parameter contains the <b>DS_GC_SERVER_REQUIRED</b> flag and <i>DomainName</i> is <b>NULL</b>,
///                 <b>DsGetDcName</b> attempts to find a global catalog in the forest of the computer identified by
///                 <i>ComputerName</i>, which is the local computer if <i>ComputerName</i> is <b>NULL</b>. If <i>DomainName</i> is
///                 <b>NULL</b> and the <i>Flags</i> parameter does not contain the <b>DS_GC_SERVER_REQUIRED</b> flag,
///                 <i>ComputerName</i> is set to the default domain name of the primary domain of the computer identified by
///                 <i>ComputerName</i>.
///    DomainGuid = Pointer to a GUID structure that specifies the <b>GUID</b> of the domain queried. If <i>DomainGuid</i> is not
///                 <b>NULL</b> and the domain specified by <i>DomainName</i> or <i>ComputerName</i> cannot be found,
///                 <b>DsGetDcName</b> attempts to locate a domain controller in the domain having the GUID specified by
///                 <i>DomainGuid</i>.
///    SiteName = Pointer to a null-terminated string that specifies the name of the site where the returned domain controller
///               should physically exist. If this parameter is <b>NULL</b>, <b>DsGetDcName</b> attempts to return a domain
///               controller in the site closest to the site of the computer specified by <i>ComputerName</i>. This parameter
///               should be <b>NULL</b>, by default.
///    Flags = Contains a set of flags that provide additional data used to process the request. This parameter can be a
///            combination of the following values.
///    DomainControllerInfo = Pointer to a <b>PDOMAIN_CONTROLLER_INFO</b> value that receives a pointer to a DOMAIN_CONTROLLER_INFO structure
///                           that contains data about the domain controller selected. This structure is allocated by <b>DsGetDcName</b>. The
///                           caller must free the structure using the NetApiBufferFree function when it is no longer required.
///Returns:
///    If the function returns domain controller data, the return value is <b>ERROR_SUCCESS</b>. If the function fails,
///    the return value can be one of the following error codes.
///    
@DllImport("logoncli")
uint DsGetDcNameA(const(PSTR) ComputerName, const(PSTR) DomainName, GUID* DomainGuid, const(PSTR) SiteName, 
                  uint Flags, DOMAIN_CONTROLLER_INFOA** DomainControllerInfo);

///The <b>DsGetDcName</b> function returns the name of a domain controller in a specified domain. This function accepts
///additional domain controller selection criteria to indicate preference for a domain controller with particular
///characteristics.
///Params:
///    ComputerName = Pointer to a null-terminated string that specifies the name of the server to process this function. Typically,
///                   this parameter is <b>NULL</b>, which indicates that the local computer is used.
///    DomainName = Pointer to a null-terminated string that specifies the name of the domain or application partition to query. This
///                 name can either be a DNS style name, for example, fabrikam.com, or a flat-style name, for example, Fabrikam. If a
///                 DNS style name is specified, the name may be specified with or without a trailing period. If the <i>Flags</i>
///                 parameter contains the <b>DS_GC_SERVER_REQUIRED</b> flag, <i>DomainName</i> must be the name of the forest. In
///                 this case, <b>DsGetDcName</b> fails if <i>DomainName</i> specifies a name that is not the forest root. If the
///                 <i>Flags</i> parameter contains the <b>DS_GC_SERVER_REQUIRED</b> flag and <i>DomainName</i> is <b>NULL</b>,
///                 <b>DsGetDcName</b> attempts to find a global catalog in the forest of the computer identified by
///                 <i>ComputerName</i>, which is the local computer if <i>ComputerName</i> is <b>NULL</b>. If <i>DomainName</i> is
///                 <b>NULL</b> and the <i>Flags</i> parameter does not contain the <b>DS_GC_SERVER_REQUIRED</b> flag,
///                 <i>ComputerName</i> is set to the default domain name of the primary domain of the computer identified by
///                 <i>ComputerName</i>.
///    DomainGuid = Pointer to a GUID structure that specifies the <b>GUID</b> of the domain queried. If <i>DomainGuid</i> is not
///                 <b>NULL</b> and the domain specified by <i>DomainName</i> or <i>ComputerName</i> cannot be found,
///                 <b>DsGetDcName</b> attempts to locate a domain controller in the domain having the GUID specified by
///                 <i>DomainGuid</i>.
///    SiteName = Pointer to a null-terminated string that specifies the name of the site where the returned domain controller
///               should physically exist. If this parameter is <b>NULL</b>, <b>DsGetDcName</b> attempts to return a domain
///               controller in the site closest to the site of the computer specified by <i>ComputerName</i>. This parameter
///               should be <b>NULL</b>, by default.
///    Flags = Contains a set of flags that provide additional data used to process the request. This parameter can be a
///            combination of the following values.
///    DomainControllerInfo = Pointer to a <b>PDOMAIN_CONTROLLER_INFO</b> value that receives a pointer to a DOMAIN_CONTROLLER_INFO structure
///                           that contains data about the domain controller selected. This structure is allocated by <b>DsGetDcName</b>. The
///                           caller must free the structure using the NetApiBufferFree function when it is no longer required.
///Returns:
///    If the function returns domain controller data, the return value is <b>ERROR_SUCCESS</b>. If the function fails,
///    the return value can be one of the following error codes.
///    
@DllImport("logoncli")
uint DsGetDcNameW(const(PWSTR) ComputerName, const(PWSTR) DomainName, GUID* DomainGuid, const(PWSTR) SiteName, 
                  uint Flags, DOMAIN_CONTROLLER_INFOW** DomainControllerInfo);

///The <b>DsGetSiteName</b> function returns the name of the site where a computer resides. For a domain controller
///(DC), the name of the site is the location of the configured DC. For a member workstation or member server, the name
///specifies the workstation site as configured in the domain of the computer.
///Params:
///    ComputerName = Pointer to a null-terminated string that specifies the name of the server to send this function. A <b>NULL</b>
///                   implies the local computer.
///    SiteName = Pointer to a variable that receives a pointer to a null-terminated string specifying the site location of this
///               computer. This string is allocated by the system and must be freed using the NetApiBufferFree function.
///Returns:
///    If the function returns account information, the return value is <b>NO_ERROR</b>. If the function fails, the
///    return value can be one of the following error codes.
///    
@DllImport("logoncli")
uint DsGetSiteNameA(const(PSTR) ComputerName, PSTR* SiteName);

///The <b>DsGetSiteName</b> function returns the name of the site where a computer resides. For a domain controller
///(DC), the name of the site is the location of the configured DC. For a member workstation or member server, the name
///specifies the workstation site as configured in the domain of the computer.
///Params:
///    ComputerName = Pointer to a null-terminated string that specifies the name of the server to send this function. A <b>NULL</b>
///                   implies the local computer.
///    SiteName = Pointer to a variable that receives a pointer to a null-terminated string specifying the site location of this
///               computer. This string is allocated by the system and must be freed using the NetApiBufferFree function.
///Returns:
///    If the function returns account information, the return value is <b>NO_ERROR</b>. If the function fails, the
///    return value can be one of the following error codes.
///    
@DllImport("logoncli")
uint DsGetSiteNameW(const(PWSTR) ComputerName, PWSTR* SiteName);

///The <b>DsValidateSubnetName</b> function validates a subnet name in the form xxx.xxx.xxx.xxx/YY. The Xxx.xxx.xxx.xxx
///portion must be a valid IP address. Yy must be the number of leftmost significant bits included in the mask. All bits
///of the IP address that are not covered by the mask must be specified as zero.
///Params:
///    SubnetName = Pointer to a null-terminated string that specifies the name of the subnet to validate.
///Returns:
///    If the function returns account information, the return value is <b>NO_ERROR</b>. If the function fails, the
///    return value is the following error code.
///    
@DllImport("logoncli")
uint DsValidateSubnetNameW(const(PWSTR) SubnetName);

///The <b>DsValidateSubnetName</b> function validates a subnet name in the form xxx.xxx.xxx.xxx/YY. The Xxx.xxx.xxx.xxx
///portion must be a valid IP address. Yy must be the number of leftmost significant bits included in the mask. All bits
///of the IP address that are not covered by the mask must be specified as zero.
///Params:
///    SubnetName = Pointer to a null-terminated string that specifies the name of the subnet to validate.
///Returns:
///    If the function returns account information, the return value is <b>NO_ERROR</b>. If the function fails, the
///    return value is the following error code.
///    
@DllImport("logoncli")
uint DsValidateSubnetNameA(const(PSTR) SubnetName);

///The <b>DsAddressToSiteNames</b> function obtains the site names corresponding to the specified addresses.
///Params:
///    ComputerName = Pointer to a null-terminated string that specifies the name of the remote server to process this function. This
///                   parameter must be the name of a domain controller. A non-domain controller can call this function by calling
///                   DsGetDcName to find the domain controller.
///    EntryCount = Contains the number of elements in the <i>SocketAddresses</i> array.
///    SocketAddresses = Contains an array of SOCKET_ADDRESS structures that contain the addresses to convert. Each address in this array
///                      must be of the type <b>AF_INET</b>. <i>EntryCount</i> contains the number of elements in this array.
///    SiteNames = Receives an array of null-terminated string pointers that contain the site names for the addresses. Each element
///                in this array corresponds to the same element in the <i>SocketAddresses</i> array. An element is <b>NULL</b> if
///                the corresponding address does not map to any known site or if the address entry is not of the proper form. The
///                caller must free this array when it is no longer required by calling NetApiBufferFree.
///Returns:
///    Returns <b>NO_ERROR</b> if successful or a Win32 or RPC error otherwise. The following list lists possible error
///    codes.
///    
@DllImport("logoncli")
uint DsAddressToSiteNamesW(const(PWSTR) ComputerName, uint EntryCount, SOCKET_ADDRESS* SocketAddresses, 
                           PWSTR** SiteNames);

///The <b>DsAddressToSiteNames</b> function obtains the site names corresponding to the specified addresses.
///Params:
///    ComputerName = Pointer to a null-terminated string that specifies the name of the remote server to process this function. This
///                   parameter must be the name of a domain controller. A non-domain controller can call this function by calling
///                   DsGetDcName to find the domain controller.
///    EntryCount = Contains the number of elements in the <i>SocketAddresses</i> array.
///    SocketAddresses = Contains an array of SOCKET_ADDRESS structures that contain the addresses to convert. Each address in this array
///                      must be of the type <b>AF_INET</b>. <i>EntryCount</i> contains the number of elements in this array.
///    SiteNames = Receives an array of null-terminated string pointers that contain the site names for the addresses. Each element
///                in this array corresponds to the same element in the <i>SocketAddresses</i> array. An element is <b>NULL</b> if
///                the corresponding address does not map to any known site or if the address entry is not of the proper form. The
///                caller must free this array when it is no longer required by calling NetApiBufferFree.
///Returns:
///    Returns <b>NO_ERROR</b> if successful or a Win32 or RPC error otherwise. The following list lists possible error
///    codes.
///    
@DllImport("logoncli")
uint DsAddressToSiteNamesA(const(PSTR) ComputerName, uint EntryCount, SOCKET_ADDRESS* SocketAddresses, 
                           PSTR** SiteNames);

///The <b>DsAddressToSiteNamesEx</b> function obtains the site and subnet names corresponding to the addresses
///specified.
///Params:
///    ComputerName = Pointer to a null-terminated string that specifies the name of the remote server to process this function. This
///                   parameter must be the name of a domain controller. A non-domain controller can call this function by calling
///                   DsGetDcName to find the domain controller.
///    EntryCount = Contains the number of elements in the <i>SocketAddresses</i> array.
///    SocketAddresses = Contains an array of SOCKET_ADDRESS structures that contain the addresses to convert. Each address in this array
///                      must be of the type <b>AF_INET</b>. <i>EntryCount</i> contains the number of elements in this array.
///    SiteNames = Receives an array of null-terminated string pointers that contain the site names for the addresses. Each element
///                in this array corresponds to the same element in the <i>SocketAddresses</i> array. An element is <b>NULL</b> if
///                the corresponding address does not map to any known site or if the address entry is not of the proper form. The
///                caller must free this array when it is no longer required by calling NetApiBufferFree.
///    SubnetNames = Receives an array of null-terminated string pointers that contain the subnet names used to perform the address to
///                  site name mappings. Each element in this array corresponds to the same element in the <i>SocketAddresses</i>
///                  array. An element is <b>NULL</b> if the corresponding address to site name mapping was not determined or if no
///                  subnet was used to perform the corresponding address to site mapping. The latter will be the case when there is
///                  exactly one site in the enterprise with no subnet objects mapped to it. The caller must free this array when it
///                  is no longer required by calling NetApiBufferFree.
///Returns:
///    Returns <b>NO_ERROR</b> if successful or a Win32 or RPC error otherwise. The following are possible error codes.
///    
@DllImport("logoncli")
uint DsAddressToSiteNamesExW(const(PWSTR) ComputerName, uint EntryCount, SOCKET_ADDRESS* SocketAddresses, 
                             PWSTR** SiteNames, PWSTR** SubnetNames);

///The <b>DsAddressToSiteNamesEx</b> function obtains the site and subnet names corresponding to the addresses
///specified.
///Params:
///    ComputerName = Pointer to a null-terminated string that specifies the name of the remote server to process this function. This
///                   parameter must be the name of a domain controller. A non-domain controller can call this function by calling
///                   DsGetDcName to find the domain controller.
///    EntryCount = Contains the number of elements in the <i>SocketAddresses</i> array.
///    SocketAddresses = Contains an array of SOCKET_ADDRESS structures that contain the addresses to convert. Each address in this array
///                      must be of the type <b>AF_INET</b>. <i>EntryCount</i> contains the number of elements in this array.
///    SiteNames = Receives an array of null-terminated string pointers that contain the site names for the addresses. Each element
///                in this array corresponds to the same element in the <i>SocketAddresses</i> array. An element is <b>NULL</b> if
///                the corresponding address does not map to any known site or if the address entry is not of the proper form. The
///                caller must free this array when it is no longer required by calling NetApiBufferFree.
///    SubnetNames = Receives an array of null-terminated string pointers that contain the subnet names used to perform the address to
///                  site name mappings. Each element in this array corresponds to the same element in the <i>SocketAddresses</i>
///                  array. An element is <b>NULL</b> if the corresponding address to site name mapping was not determined or if no
///                  subnet was used to perform the corresponding address to site mapping. The latter will be the case when there is
///                  exactly one site in the enterprise with no subnet objects mapped to it. The caller must free this array when it
///                  is no longer required by calling NetApiBufferFree.
///Returns:
///    Returns <b>NO_ERROR</b> if successful or a Win32 or RPC error otherwise. The following are possible error codes.
///    
@DllImport("logoncli")
uint DsAddressToSiteNamesExA(const(PSTR) ComputerName, uint EntryCount, SOCKET_ADDRESS* SocketAddresses, 
                             PSTR** SiteNames, PSTR** SubnetNames);

///The <b>DsEnumerateDomainTrusts</b> function obtains domain trust data for a specified domain.
///Params:
///    ServerName = Pointer to a null-terminated string that specifies the name of a computer in the domain to obtain the trust
///                 information for. If this parameter is <b>NULL</b>, the name of the local computer is used. The caller must be an
///                 authenticated user in this domain. If this computer is a domain controller, this function returns the trust data
///                 immediately. If this computer is not a domain controller, this function obtains the trust data from cached data
///                 if the cached data is not expired. If the cached data is expired, this function obtains the trust data from a
///                 domain controller in the domain that this computer is a member of and updates the cache. The cached data
///                 automatically expires after five minutes.
///    Flags = Contains a set of flags that determines which domain trusts to enumerate. This can be zero or a combination of
///            one or more of the following values.
///    Domains = Pointer to a <b>PDS_DOMAIN_TRUSTS</b> value that receives an array of DS_DOMAIN_TRUSTS structures. Each structure
///              in this array contains trust data about a domain. The caller must free this memory when it is no longer required
///              by calling NetApiBufferFree.
///    DomainCount = Pointer to a <b>ULONG</b> value that receives the number of elements returned in the <i>Domains</i> array.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Win32 error code otherwise. Possible error codes include those
///    listed in the following list.
///    
@DllImport("logoncli")
uint DsEnumerateDomainTrustsW(PWSTR ServerName, uint Flags, DS_DOMAIN_TRUSTSW** Domains, uint* DomainCount);

///The <b>DsEnumerateDomainTrusts</b> function obtains domain trust data for a specified domain.
///Params:
///    ServerName = Pointer to a null-terminated string that specifies the name of a computer in the domain to obtain the trust
///                 information for. If this parameter is <b>NULL</b>, the name of the local computer is used. The caller must be an
///                 authenticated user in this domain. If this computer is a domain controller, this function returns the trust data
///                 immediately. If this computer is not a domain controller, this function obtains the trust data from cached data
///                 if the cached data is not expired. If the cached data is expired, this function obtains the trust data from a
///                 domain controller in the domain that this computer is a member of and updates the cache. The cached data
///                 automatically expires after five minutes.
///    Flags = Contains a set of flags that determines which domain trusts to enumerate. This can be zero or a combination of
///            one or more of the following values.
///    Domains = Pointer to a <b>PDS_DOMAIN_TRUSTS</b> value that receives an array of DS_DOMAIN_TRUSTS structures. Each structure
///              in this array contains trust data about a domain. The caller must free this memory when it is no longer required
///              by calling NetApiBufferFree.
///    DomainCount = Pointer to a <b>ULONG</b> value that receives the number of elements returned in the <i>Domains</i> array.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Win32 error code otherwise. Possible error codes include those
///    listed in the following list.
///    
@DllImport("logoncli")
uint DsEnumerateDomainTrustsA(PSTR ServerName, uint Flags, DS_DOMAIN_TRUSTSA** Domains, uint* DomainCount);

///The <b>DsGetForestTrustInformationW</b> function obtains forest trust data for a specified domain.
///Params:
///    ServerName = Contains the name of the domain controller that <b>DsGetForestTrustInformationW</b> is connected to remotely. The
///                 caller must be an authenticated user on this server. If this parameter is <b>NULL</b>, the local server is used.
///    TrustedDomainName = Contains the NETBIOS or DNS name of the trusted domain that the forest trust data is to be retrieved for. This
///                        domain must have the <b>TRUST_ATTRIBUTE_FOREST_TRANSITIVE</b> trust attribute. For more information, see
///                        TRUSTED_DOMAIN_INFORMATION_EX. If this parameter is <b>NULL</b>, the forest trust data for the domain hosted by
///                        <i>ServerName</i> is retrieved.
///    Flags = Contains a set of flags that modify the behavior of this function. This can be zero or the following value.
///    ForestTrustInfo = Pointer to an LSA_FOREST_TRUST_INFORMATION structure pointer that receives the forest trust data that describes
///                      the namespaces claimed by the domain specified by <i>TrustedDomainName</i>. The <b>Time</b>member of all returned
///                      records will be zero. The caller must free this structure when it is no longer required by calling
///                      NetApiBufferFree.
///Returns:
///    Returns <b>NO_ERROR</b> if successful or a Win32 error code otherwise. Possible error codes include the
///    following.
///    
@DllImport("logoncli")
uint DsGetForestTrustInformationW(const(PWSTR) ServerName, const(PWSTR) TrustedDomainName, uint Flags, 
                                  LSA_FOREST_TRUST_INFORMATION** ForestTrustInfo);

///The <b>DsMergeForestTrustInformationW</b> function merges the changes from a new forest trust data structure with an
///old forest trust data structure.
///Params:
///    DomainName = Pointer to a null-terminated Unicode string that specifies the trusted domain to update.
///    NewForestTrustInfo = Pointer to an <b>LSA_FOREST_TRUST_INFORMATION</b> structure that contains the new forest trust data to be merged.
///                         The <b>Flags</b> and <b>Time</b> members of the entries are ignored.
///    OldForestTrustInfo = Pointer to an <b>LSA_FOREST_TRUST_INFORMATION</b> structure that contains the old forest trust data to be merged.
///                         This parameter may be <b>NULL</b> if no records exist.
///    MergedForestTrustInfo = Pointer to an <b>LSA_FOREST_TRUST_INFORMATION</b> structure pointer that receives the merged forest trust data.
///                            The caller must free this structure when it is no longer required by calling NetApiBufferFree.
///Returns:
///    Returns <b>NO_ERROR</b> if successful or a Windows error code otherwise.
///    
@DllImport("logoncli")
uint DsMergeForestTrustInformationW(const(PWSTR) DomainName, LSA_FOREST_TRUST_INFORMATION* NewForestTrustInfo, 
                                    LSA_FOREST_TRUST_INFORMATION* OldForestTrustInfo, 
                                    LSA_FOREST_TRUST_INFORMATION** MergedForestTrustInfo);

///The <b>DsGetDcSiteCoverage</b> function returns the site names of all sites covered by a domain controller.
///Params:
///    ServerName = The null-terminated string value that specifies the name of the remote domain controller.
///    EntryCount = Pointer to a <b>ULONG</b> value that receives the number of sites covered by the domain controller.
///    SiteNames = Pointer to an array of pointers to null-terminated strings that receives the site names. To free the returned
///                buffer, call the NetApiBufferFree function.
///Returns:
///    This function returns DSGETDCAPI DWORD.
///    
@DllImport("logoncli")
uint DsGetDcSiteCoverageW(const(PWSTR) ServerName, uint* EntryCount, PWSTR** SiteNames);

///The <b>DsGetDcSiteCoverage</b> function returns the site names of all sites covered by a domain controller.
///Params:
///    ServerName = The null-terminated string value that specifies the name of the remote domain controller.
///    EntryCount = Pointer to a <b>ULONG</b> value that receives the number of sites covered by the domain controller.
///    SiteNames = Pointer to an array of pointers to null-terminated strings that receives the site names. To free the returned
///                buffer, call the NetApiBufferFree function.
///Returns:
///    This function returns DSGETDCAPI DWORD.
///    
@DllImport("logoncli")
uint DsGetDcSiteCoverageA(const(PSTR) ServerName, uint* EntryCount, PSTR** SiteNames);

///The <b>DsDeregisterDnsHostRecords</b> function deletes DNS entries, except for type A records registered by a domain
///controller. Only an administrator, account operator, or server operator may call this function.
///Params:
///    ServerName = The null-terminated string that specifies the name of the remote domain controller. Can be set to <b>NULL</b> if
///                 the calling application is running on the domain controller being updated.
///    DnsDomainName = The null-terminated string that specifies the DNS domain name of the domain occupied by the domain controller. It
///                    is unnecessary for this to be a domain hosted by this domain controller. If <b>NULL</b>, the <i>DnsHostName</i>
///                    with the leftmost label removed is specified.
///    DomainGuid = Pointer to the Domain GUID of the domain. If <b>NULL</b>, GUID specific names are not removed.
///    DsaGuid = Pointer to the GUID of the <b>NTDS-DSA</b> object to be deleted. If <b>NULL</b>, <b>NTDS-DSA</b> specific names
///              are not removed.
///    DnsHostName = Pointer to the null-terminated string that specifies the DNS host name of the domain controller whose DNS records
///                  are being deleted.
///Returns:
///    This function returns DSGETDCAPI DWORD.
///    
@DllImport("logoncli")
uint DsDeregisterDnsHostRecordsW(PWSTR ServerName, PWSTR DnsDomainName, GUID* DomainGuid, GUID* DsaGuid, 
                                 PWSTR DnsHostName);

///The <b>DsDeregisterDnsHostRecords</b> function deletes DNS entries, except for type A records registered by a domain
///controller. Only an administrator, account operator, or server operator may call this function.
///Params:
///    ServerName = The null-terminated string that specifies the name of the remote domain controller. Can be set to <b>NULL</b> if
///                 the calling application is running on the domain controller being updated.
///    DnsDomainName = The null-terminated string that specifies the DNS domain name of the domain occupied by the domain controller. It
///                    is unnecessary for this to be a domain hosted by this domain controller. If <b>NULL</b>, the <i>DnsHostName</i>
///                    with the leftmost label removed is specified.
///    DomainGuid = Pointer to the Domain GUID of the domain. If <b>NULL</b>, GUID specific names are not removed.
///    DsaGuid = Pointer to the GUID of the <b>NTDS-DSA</b> object to be deleted. If <b>NULL</b>, <b>NTDS-DSA</b> specific names
///              are not removed.
///    DnsHostName = Pointer to the null-terminated string that specifies the DNS host name of the domain controller whose DNS records
///                  are being deleted.
///Returns:
///    This function returns DSGETDCAPI DWORD.
///    
@DllImport("logoncli")
uint DsDeregisterDnsHostRecordsA(PSTR ServerName, PSTR DnsDomainName, GUID* DomainGuid, GUID* DsaGuid, 
                                 PSTR DnsHostName);

///The <b>DsGetDcOpen</b> function opens a new domain controller enumeration operation.
///Params:
///    DnsName = Pointer to a null-terminated string that contains the domain naming system (DNS) name of the domain to enumerate
///              the domain controllers for. This parameter cannot be <b>NULL</b>.
///    OptionFlags = Contains a set of flags that modify the behavior of the function. This can be zero or a combination of one or
///                  more of the following values.
///    SiteName = Pointer to a null-terminated string that contains the name of site the client is in. This parameter is optional
///               and may be <b>NULL</b>.
///    DomainGuid = Pointer to a <b>GUID</b> value that contains the identifier of the domain specified by <i>DnsName</i>. This
///                 identifier is used to handle the case of a renamed domain. If this value is specified and the domain specified in
///                 <i>DnsName</i> is renamed, this function attempts to enumerate domain controllers in the domain that contains the
///                 specified identifier. This parameter is optional and may be <b>NULL</b>.
///    DnsForestName = Pointer to a null-terminated string that contains the name of the forest that contains the <i>DnsName</i> domain.
///                    This value is used in conjunction with <i>DomainGuid</i>to enumerate the domain controllers if the domain has
///                    been renamed. This parameter is optional and may be <b>NULL</b>.
///    DcFlags = Contains a set of flags that identify the type of domain controllers to enumerate. This can be zero or a
///              combination of one or more of the following values.
///    RetGetDcContext = Pointer to a <b>HANDLE</b> value that receives the domain controller enumeration context handle. This handle is
///                      used with the DsGetDcNext function to identify the domain controller enumeration operation. This handle is passed
///                      to DsGetDcClose to close the domain controller enumeration operation.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Win32 or RPC error otherwise. Possible error values include the
///    following.
///    
@DllImport("logoncli")
uint DsGetDcOpenW(const(PWSTR) DnsName, uint OptionFlags, const(PWSTR) SiteName, GUID* DomainGuid, 
                  const(PWSTR) DnsForestName, uint DcFlags, GetDcContextHandle* RetGetDcContext);

///The <b>DsGetDcOpen</b> function opens a new domain controller enumeration operation.
///Params:
///    DnsName = Pointer to a null-terminated string that contains the domain naming system (DNS) name of the domain to enumerate
///              the domain controllers for. This parameter cannot be <b>NULL</b>.
///    OptionFlags = Contains a set of flags that modify the behavior of the function. This can be zero or a combination of one or
///                  more of the following values.
///    SiteName = Pointer to a null-terminated string that contains the name of site the client is in. This parameter is optional
///               and may be <b>NULL</b>.
///    DomainGuid = Pointer to a <b>GUID</b> value that contains the identifier of the domain specified by <i>DnsName</i>. This
///                 identifier is used to handle the case of a renamed domain. If this value is specified and the domain specified in
///                 <i>DnsName</i> is renamed, this function attempts to enumerate domain controllers in the domain that contains the
///                 specified identifier. This parameter is optional and may be <b>NULL</b>.
///    DnsForestName = Pointer to a null-terminated string that contains the name of the forest that contains the <i>DnsName</i> domain.
///                    This value is used in conjunction with <i>DomainGuid</i>to enumerate the domain controllers if the domain has
///                    been renamed. This parameter is optional and may be <b>NULL</b>.
///    DcFlags = Contains a set of flags that identify the type of domain controllers to enumerate. This can be zero or a
///              combination of one or more of the following values.
///    RetGetDcContext = Pointer to a <b>HANDLE</b> value that receives the domain controller enumeration context handle. This handle is
///                      used with the DsGetDcNext function to identify the domain controller enumeration operation. This handle is passed
///                      to DsGetDcClose to close the domain controller enumeration operation.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Win32 or RPC error otherwise. Possible error values include the
///    following.
///    
@DllImport("logoncli")
uint DsGetDcOpenA(const(PSTR) DnsName, uint OptionFlags, const(PSTR) SiteName, GUID* DomainGuid, 
                  const(PSTR) DnsForestName, uint DcFlags, GetDcContextHandle* RetGetDcContext);

///The <b>DsGetDcNext</b> function retrieves the next domain controller in a domain controller enumeration operation.
///Params:
///    GetDcContextHandle = Contains the domain controller enumeration context handle provided by the DsGetDcOpen function.
///    SockAddressCount = Pointer to a <b>ULONG</b> value that receives the number of elements in the <i>SockAddresses</i> array. If this
///                       parameter is <b>NULL</b>, socket addresses are not retrieved.
///    SockAddresses = Pointer to an array of SOCKET_ADDRESS structures that receives the socket address data for the domain controller.
///                    <i>SockAddressCount</i> receives the number of elements in this array. All returned addresses will be of type
///                    <b>AF_INET</b> or <b>AF_INET6</b>. The <b>sin_port</b> member contains the port from the server record. A port of
///                    0 indicates no port is available from DNS. The caller must free this memory when it is no longer required by
///                    calling LocalFree. This parameter is ignored if <i>SockAddressCount</i> is <b>NULL</b>.
///    DnsHostName = Pointer to a string pointer that receives the DNS name of the domain controller. This parameter receives
///                  <b>NULL</b> if no host name is known. The caller must free this memory when it is no longer required by calling
///                  NetApiBufferFree.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Win32 or RPC error otherwise. Possible error values include the
///    following.
///    
@DllImport("logoncli")
uint DsGetDcNextW(HANDLE GetDcContextHandle, uint* SockAddressCount, SOCKET_ADDRESS** SockAddresses, 
                  PWSTR* DnsHostName);

///The <b>DsGetDcNext</b> function retrieves the next domain controller in a domain controller enumeration operation.
///Params:
///    GetDcContextHandle = Contains the domain controller enumeration context handle provided by the DsGetDcOpen function.
///    SockAddressCount = Pointer to a <b>ULONG</b> value that receives the number of elements in the <i>SockAddresses</i> array. If this
///                       parameter is <b>NULL</b>, socket addresses are not retrieved.
///    SockAddresses = Pointer to an array of SOCKET_ADDRESS structures that receives the socket address data for the domain controller.
///                    <i>SockAddressCount</i> receives the number of elements in this array. All returned addresses will be of type
///                    <b>AF_INET</b> or <b>AF_INET6</b>. The <b>sin_port</b> member contains the port from the server record. A port of
///                    0 indicates no port is available from DNS. The caller must free this memory when it is no longer required by
///                    calling LocalFree. This parameter is ignored if <i>SockAddressCount</i> is <b>NULL</b>.
///    DnsHostName = Pointer to a string pointer that receives the DNS name of the domain controller. This parameter receives
///                  <b>NULL</b> if no host name is known. The caller must free this memory when it is no longer required by calling
///                  NetApiBufferFree.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Win32 or RPC error otherwise. Possible error values include the
///    following.
///    
@DllImport("logoncli")
uint DsGetDcNextA(HANDLE GetDcContextHandle, uint* SockAddressCount, SOCKET_ADDRESS** SockAddresses, 
                  PSTR* DnsHostName);

///The <b>DsGetDcClose</b> function closes a domain controller enumeration operation.
///Params:
///    GetDcContextHandle = Contains the domain controller enumeration context handle provided by the DsGetDcOpen function.
///Returns:
///    This function does not return a value.
///    
@DllImport("logoncli")
void DsGetDcCloseW(GetDcContextHandle GetDcContextHandle);


// Interfaces

@GUID("72D3EDC2-A4C4-11D0-8533-00C04FD8D503")
struct PropertyEntry;

@GUID("7B9E38B0-A97C-11D0-8534-00C04FD8D503")
struct PropertyValue;

@GUID("B75AC000-9BDD-11D0-852C-00C04FD8D503")
struct AccessControlEntry;

@GUID("B85EA052-9BDD-11D0-852C-00C04FD8D503")
struct AccessControlList;

@GUID("B958F73C-9BDD-11D0-852C-00C04FD8D503")
struct SecurityDescriptor;

@GUID("927971F5-0939-11D1-8BE1-00C04FD8D503")
struct LargeInteger;

@GUID("274FAE1F-3626-11D1-A3A4-00C04FB950DC")
struct NameTranslate;

@GUID("15F88A55-4680-11D1-A3B4-00C04FB950DC")
struct CaseIgnoreList;

@GUID("A5062215-4681-11D1-A3B4-00C04FB950DC")
struct FaxNumber;

@GUID("B0B71247-4080-11D1-A3AC-00C04FB950DC")
struct NetAddress;

@GUID("1241400F-4680-11D1-A3B4-00C04FB950DC")
struct OctetList;

@GUID("8F92A857-478E-11D1-A3B4-00C04FB950DC")
struct Email;

@GUID("B2538919-4080-11D1-A3AC-00C04FB950DC")
struct Path;

@GUID("F5D1BADF-4080-11D1-A3AC-00C04FB950DC")
struct ReplicaPointer;

@GUID("B2BED2EB-4080-11D1-A3AC-00C04FB950DC")
struct Timestamp;

@GUID("0A75AFCD-4680-11D1-A3B4-00C04FB950DC")
struct PostalAddress;

@GUID("FCBF906F-4080-11D1-A3AC-00C04FB950DC")
struct BackLink;

@GUID("B33143CB-4080-11D1-A3AC-00C04FB950DC")
struct TypedName;

@GUID("B3AD3E13-4080-11D1-A3AC-00C04FB950DC")
struct Hold;

@GUID("080D0D78-F421-11D0-A36E-00C04FB950DC")
struct Pathname;

@GUID("50B6327F-AFD1-11D2-9CB9-0000F87A369E")
struct ADSystemInfo;

@GUID("66182EC4-AFD1-11D2-9CB9-0000F87A369E")
struct WinNTSystemInfo;

@GUID("7E99C0A3-F935-11D2-BA96-00C04FB6D0D1")
struct DNWithBinary;

@GUID("334857CC-F934-11D2-BA96-00C04FB6D0D1")
struct DNWithString;

@GUID("F270C64A-FFB8-4AE4-85FE-3A75E5347966")
struct ADsSecurityUtility;

///The <b>IQueryForm</b> interface is implemented by a query form extension object to allow the form object to add forms
///and pages to the system-supplied directory service query dialog box.
@GUID("8CFCEE30-39BD-11D0-B8D1-00A024AB2DBB")
interface IQueryForm : IUnknown
{
    ///The <b>IQueryForm::Initialize</b> method initializes the query form extension object.
    ///Params:
    ///    hkForm = Contains a registry key that identifies where the query form object was obtained. This parameter may be
    ///             <b>NULL</b>.
    ///Returns:
    ///    This method returns <b>S_OK</b> to enable the form object within the query dialog, or a failure code, such as
    ///    <b>E_FAIL</b>, to prevent the form from being added to the query dialog.
    ///    
    HRESULT Initialize(HKEY hkForm);
    ///The <b>IQueryForm::AddForms</b> method is called to allow a query form extension object to add forms to the query
    ///dialog box.
    ///Params:
    ///    pAddFormsProc = Pointer to a callback function of the form CQAddFormsProc. The query form extension calls this function with
    ///                    the supplied <i>lParam</i> one time for each form to be added.
    ///    lParam = Contains a 32-bit value that is defined by the query handler. This value must be passed as the <i>lParam</i>
    ///             parameter in the CQAddFormsProc call.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful or a standard <b>HRESULT</b> failure code otherwise.
    ///    
    HRESULT AddForms(LPCQADDFORMSPROC pAddFormsProc, LPARAM lParam);
    ///The <b>IQueryForm::AddPages</b> method is called to allow a query form object to add pages to an existing form.
    ///Params:
    ///    pAddPagesProc = Pointer to a callback function of the form CQAddPagesProc. The query form extension calls this function with
    ///                    the supplied <i>lParam</i> one time for each page to be added to a form.
    ///    lParam = Contains a 32-bit value that is defined by the query handler. This value must be passed as the <i>lParam</i>
    ///             parameter in the CQAddPagesProc call.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful or a standard <b>HRESULT</b> failure code otherwise.
    ///    
    HRESULT AddPages(LPCQADDPAGESPROC pAddPagesProc, LPARAM lParam);
}

///The <b>IPersistQuery</b> interface is used to store and retrieve query parameters to and from persistent storage.This
///storage pertains to the query parameters, not the results of a query. A pointer to this interface is provided to a
///query form extension in the CQPM_PERSIST message. An application can also provide its own <b>IPersistQuery</b>
///implementation by passing a pointer to this interface to the query handler in the <b>pPersistQuery</b> member of the
///OPENQUERYWINDOW structure when ICommonQuery::OpenQueryWindow is called.
@GUID("1A3114B8-A62E-11D0-A6C5-00A0C906AF45")
interface IPersistQuery : IPersist
{
    ///The <b>IPersistQuery::WriteString</b> method writes a string to the query store.
    ///Params:
    ///    pSection = Pointer to a null-terminated Unicode string that represents the section name that the string should be
    ///               written to.
    ///    pValueName = Pointer to a null-terminated Unicode string that represents the name of the string value.
    ///    pValue = Pointer to a null-terminated Unicode string that contains the string to be written.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful or a standard <b>HRESULT</b> value otherwise. Possible error codes include
    ///    the following.
    ///    
    HRESULT WriteString(const(PWSTR) pSection, const(PWSTR) pValueName, const(PWSTR) pValue);
    ///The <b>IPersistQuery::ReadString</b> method reads a string from the query store.
    ///Params:
    ///    pSection = Pointer to a null-terminated Unicode string that represents the section name that the string should be read
    ///               from.
    ///    pValueName = Pointer to a null-terminated Unicode string that represents the name of the string value to be read.
    ///    pBuffer = Pointer to a character buffer that receives the string value. The <i>cchBuffer</i> parameter specifies the
    ///              size of this buffer including the null terminator.
    ///    cchBuffer = Contains the size, in characters, of the <i>pBuffer</i> buffer including the null terminator.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful or a standard <b>HRESULT</b> value otherwise. Possible error codes include
    ///    the following.
    ///    
    HRESULT ReadString(const(PWSTR) pSection, const(PWSTR) pValueName, PWSTR pBuffer, int cchBuffer);
    ///The <b>IPersistQuery::WriteInt</b> method writes an integer value to the query store.
    ///Params:
    ///    pSection = Pointer to a null-terminated Unicode string that represents the section name that the integer should be
    ///               written to.
    ///    pValueName = Pointer to a null-terminated Unicode string that represents the name of the integer value.
    ///    value = Contains the integer value to be written to the query store.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful or a standard <b>HRESULT</b> value otherwise. Possible error codes include
    ///    the following.
    ///    
    HRESULT WriteInt(const(PWSTR) pSection, const(PWSTR) pValueName, int value);
    ///The <b>IPersistQuery::ReadInt</b> method reads an integer value from the query store.
    ///Params:
    ///    pSection = A pointer to a null-terminated Unicode string that represents the section name that the integer should be
    ///               read from.
    ///    pValueName = A pointer to a null-terminated Unicode string that represents the name of the integer value to be read.
    ///    pValue = Pointer to an integer variable that receives the integer value.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful or a standard <b>HRESULT</b> value otherwise. Possible error codes include
    ///    the following.
    ///    
    HRESULT ReadInt(const(PWSTR) pSection, const(PWSTR) pValueName, int* pValue);
    ///The <b>IPersistQuery::WriteStruct</b> method writes a structure to the query store.
    ///Params:
    ///    pSection = Pointer to a null-terminated Unicode string that represents the section name that the structure should be
    ///               written to.
    ///    pValueName = Pointer to a null-terminated Unicode string that represents the name of the structure.
    ///    pStruct = Pointer to the structure to be written. The <i>cbStruct</i> parameter contains the number of bytes to be
    ///              written.
    ///    cbStruct = Contains the size, in bytes, of the structure to be written.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful or a standard <b>HRESULT</b> value otherwise. Possible error codes include
    ///    the following.
    ///    
    HRESULT WriteStruct(const(PWSTR) pSection, const(PWSTR) pValueName, void* pStruct, uint cbStruct);
    ///The <b>IPersistQuery::ReadStruct</b> method reads a structure from the query store.
    ///Params:
    ///    pSection = Pointer to a null-terminated Unicode string that represents the section name that the structure should be
    ///               read from.
    ///    pValueName = Pointer to a null-terminated Unicode string that represents the name of the structure value to be read.
    ///    pStruct = Pointer to a buffer that will receive the structure. The <i>cbStruct</i> parameter specifies the size of this
    ///              buffer, in bytes.
    ///    cbStruct = Specifies the size, in bytes, of the buffer represented by the <i>pStruct</i> parameter.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful or a standard <b>HRESULT</b> value otherwise. Possible error codes include
    ///    the following.
    ///    
    HRESULT ReadStruct(const(PWSTR) pSection, const(PWSTR) pValueName, void* pStruct, uint cbStruct);
    ///The <b>IPersistQuery::Clear</b> method empties the contents of the query store.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful or a standard <b>HRESULT</b> value otherwise.
    ///    
    HRESULT Clear();
}

///The <b>ICommonQuery</b> interface is used to programmatically display the system-supplied directory service query
///dialog box.To create an instance of this interface, call CoCreateInstance with the <b>CLSID_CommonQuery</b> class
///identifier as shown in the following code example. ```cpp HRESULT hr; ICommonQuery *pCommonQuery; hr =
///CoCreateInstance(CLSID_CommonQuery, NULL, CLSCTX_INPROC_SERVER, IID_ICommonQuery, (LPVOID*)&pCommonQuery); ```
@GUID("AB50DEC0-6F1D-11D0-A1C4-00AA00C16E65")
interface ICommonQuery : IUnknown
{
    ///The <b>ICommonQuery::OpenQueryWindow</b> method displays the directory service query dialog. This method does not
    ///return until the dialog box has been closed by the user.
    ///Params:
    ///    hwndParent = Contains the handle of the window to use as the parent to the query dialog box. This parameter can be
    ///                 <b>NULL</b> if no parent is specified.
    ///    pQueryWnd = Address of an OPENQUERYWINDOW structure that defines the query to perform and the characteristics of the
    ///                query dialog.
    ///    ppDataObject = Address of an IDataObject interface pointer that receives the results of the query. This parameter only
    ///                   receives valid data if this method returns <b>S_OK</b>. This <b>IDataObject</b> supports the following
    ///                   clipboard formats.
    ///Returns:
    ///    Returns a standard <b>HRESULT</b> value including the following.
    ///    
    HRESULT OpenQueryWindow(HWND hwndParent, OPENQUERYWINDOW* pQueryWnd, IDataObject* ppDataObject);
}

///The <b>IADs</b> interface defines the basic object features, that is, properties and methods, of any ADSI object.
///Examples of ADSI objects include users, computers, services, organization of user accounts and computers, file
///systems, and file service operations. Every ADSI object must support this interface, which serves to do the
///following: <ul> <li>Provides object identification by name, class, or ADsPath</li> <li>Identifies the object's
///container that manages the object's creation and deletion</li> <li>Retrieves the object's schema definition</li>
///<li>Loads object's attributes to the property cache and commits changes to the persistent directory store</li>
///<li>Accesses and modifies the object's attribute values in the property cache</li> </ul>The <b>IADs</b> interface is
///designed to ensure that ADSI objects provide network administrators and directory service providers with a simple and
///consistent representation of various underlying directory services.
@GUID("FD8256D0-FD15-11CE-ABC4-02608C9E7553")
interface IADs : IDispatch
{
    HRESULT get_Name(BSTR* retval);
    HRESULT get_Class(BSTR* retval);
    HRESULT get_GUID(BSTR* retval);
    HRESULT get_ADsPath(BSTR* retval);
    HRESULT get_Parent(BSTR* retval);
    HRESULT get_Schema(BSTR* retval);
    ///The <b>IADs::GetInfo</b> method loads into the property cache values of the supported properties of this ADSI
    ///object from the underlying directory store.
    ///Returns:
    ///    This method supports the standard return values, as well as the following. For more information, see ADSI
    ///    Error Codes.
    ///    
    HRESULT GetInfo();
    ///The <b>IADs::SetInfo</b> method saves the cached property values of the ADSI object to the underlying directory
    ///store.
    ///Returns:
    ///    This method supports the standard return values, including S_OK for a successful operation. For more
    ///    information, see ADSI Error Codes.
    ///    
    HRESULT SetInfo();
    ///The <b>IADs::Get</b> method retrieves a property of a given name from the property cache. The property can be
    ///single-valued, or multi-valued. The property value is represented as either a variant for a single-valued
    ///property or a variant array (of <b>VARIANT</b> or bytes) for a property that allows multiple values.
    ///Params:
    ///    bstrName = Contains a <b>BSTR</b> that specifies the property name.
    ///    pvProp = Pointer to a <b>VARIANT</b> that receives the value of the property. For a multi-valued property,
    ///             <i>pvProp</i> is a variant array of <b>VARIANT</b>, unless the property is a binary type. In this latter
    ///             case, <i>pvProp</i> is a variant array of bytes (VT_U1 or VT_ARRAY). For the property that refers to an
    ///             object, <i>pvProp</i> is a VT_DISPATCH pointer to the object referred to.
    ///Returns:
    ///    This method supports standard return values, as well as the following. For more information, see ADSI Error
    ///    Codes.
    ///    
    HRESULT Get(BSTR bstrName, VARIANT* pvProp);
    ///The <b>IADs::Put</b> method sets the values of an attribute in the ADSI attribute cache.
    ///Params:
    ///    bstrName = Contains a <b>BSTR</b> that specifies the property name.
    ///    vProp = Contains a <b>VARIANT</b> that specifies the new values of the property.
    ///Returns:
    ///    This method supports the standard return values, as well as the following. For more information, and other
    ///    return values, see ADSI Error Codes.
    ///    
    HRESULT Put(BSTR bstrName, VARIANT vProp);
    ///The <b>IADs::GetEx</b> method retrieves, from the property cache, property values of a given attribute. The
    ///returned property values can be single-valued or multi-valued. Unlike the IADs::Get method, the property values
    ///are returned as a variant array of <b>VARIANT</b>, or a variant array of bytes for binary data. A single-valued
    ///property is then represented as an array of a single element.
    ///Params:
    ///    bstrName = Contains a <b>BSTR</b> that specifies the property name.
    ///    pvProp = Pointer to a <b>VARIANT</b> that receives the value, or values, of the property.
    ///Returns:
    ///    This method supports the standard return values as well as the return values listed in the following list.
    ///    For more information, see ADSI Error Codes.
    ///    
    HRESULT GetEx(BSTR bstrName, VARIANT* pvProp);
    ///The <b>IADs::PutEx</b> method modifies the values of an attribute in the ADSI attribute cache. For example, for
    ///properties that allow multiple values, you can append additional values to an existing set of values, modify the
    ///values in the set, remove specified values from the set, or delete values from the set.
    ///Params:
    ///    lnControlCode = Control code that indicates the mode of modification: Append, Replace, Remove, and Delete. For more
    ///                    information and a list of values, see ADS_PROPERTY_OPERATION_ENUM.
    ///    bstrName = Contains a <b>BSTR</b> that specifies the property name.
    ///    vProp = Contains a <b>VARIANT</b> array that contains the new value or values of the property. A single-valued
    ///            property is represented as an array with a single element. If <i>InControlCode</i> is set to
    ///            <b>ADS_PROPERTY_CLEAR</b>, the value of the property specified by <i>vProp</i> is irrelevant.
    ///Returns:
    ///    This method supports standard return values, as well as the following. For more information, see ADSI Error
    ///    Codes.
    ///    
    HRESULT PutEx(int lnControlCode, BSTR bstrName, VARIANT vProp);
    ///The <b>IADs::GetInfoEx</b> method loads the values of specified properties of the ADSI object from the underlying
    ///directory store into the property cache.
    ///Params:
    ///    vProperties = Array of null-terminated Unicode string entries that list the properties to load into the Active Directory
    ///                  property cache. Each property name must match one in this object's schema class definition.
    ///    lnReserved = Reserved for future use. Must be set to zero.
    ///Returns:
    ///    This method supports the standard return values, as well as the following. For more information, see ADSI
    ///    Error Codes.
    ///    
    HRESULT GetInfoEx(VARIANT vProperties, int lnReserved);
}

///The <b>IADsContainer</b> interface enables an ADSI container object to create, delete, and manage contained ADSI
///objects. Container objects represent hierarchical directory trees, such as in a file system, and to organize the
///directory hierarchy. You can use the <b>IADsContainer</b> interface to either enumerate contained objects or manage
///their lifecycle. An example would be to recursively navigate a directory tree. By querying the <b>IADsContainer</b>
///interface on an ADSI object, you can determine if the object has any children. If the interface is not supported, the
///object is a leaf. Otherwise, it is a container. You can continue this process for the newly found container objects.
///To create, copy, or delete an object, send the request to the container object to perform the task.
@GUID("001677D0-FD16-11CE-ABC4-02608C9E7553")
interface IADsContainer : IDispatch
{
    HRESULT get_Count(int* retval);
    ///The <b>IADsContainer::get__NewEnum</b> method Retrieves an enumerator object for the container. The enumerator
    ///object implements the IEnumVARIANT interface to enumerate the children of the container object.
    ///Params:
    ///    retval = Pointer to an IUnknown pointer that receives the enumerator object. The caller must release this interface
    ///             when it is no longer required.
    ///Returns:
    ///    This method supports the standard return values, including S_OK for a successful operation. For more
    ///    information about error codes, see ADSI Error Codes.
    ///    
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Filter(VARIANT* pVar);
    HRESULT put_Filter(VARIANT Var);
    HRESULT get_Hints(VARIANT* pvFilter);
    HRESULT put_Hints(VARIANT vHints);
    HRESULT GetObjectA(BSTR ClassName, BSTR RelativeName, IDispatch* ppObject);
    ///The <b>IADsContainer::Create</b> method sets up a request to create a directory object of the specified schema
    ///class and a given name in the container. The object is not made persistent until IADs::SetInfo is called on the
    ///new object. This allows for setting mandatory properties on the new object.
    ///Params:
    ///    ClassName = Name of the schema class object to be created. The name is that returned from the IADs::get_Schema property
    ///                method.
    ///    RelativeName = Relative name of the object as it is known in the underlying directory and identical to the one retrieved
    ///                   through the IADs::get_Name property method.
    ///    ppObject = Indirect pointer to the IDispatch interface on the newly created object.
    ///Returns:
    ///    This method supports the standard return values, including S_OK for a successful operation. For more
    ///    information about error codes, see ADSI Error Codes.
    ///    
    HRESULT Create(BSTR ClassName, BSTR RelativeName, IDispatch* ppObject);
    ///The <b>IADsContainer::Delete</b> method deletes a specified directory object from this container.
    ///Params:
    ///    bstrClassName = The schema class object to delete. The name is that returned from the IADs::get_Class method. Also,
    ///                    <b>NULL</b> is a valid option for this parameter. Providing <b>NULL</b> for this parameter is the only way to
    ///                    deal with defunct schema classes. If an instance was created before the class became defunct, the only way to
    ///                    delete the instance of the defunct class is to call <b>IADsContainer::Delete</b> and provide <b>NULL</b> for
    ///                    this parameter.
    ///    bstrRelativeName = Name of the object as it is known in the underlying directory and identical to the name retrieved with the
    ///                       IADs::get_Name method.
    ///Returns:
    ///    This method supports the standard return values, including S_OK for a successful operation. For more
    ///    information about error codes, see ADSI Error Codes.
    ///    
    HRESULT Delete(BSTR bstrClassName, BSTR bstrRelativeName);
    ///The <b>IADsContainer::CopyHere</b> method creates a copy of the specified directory object in this container.
    ///Params:
    ///    SourceName = The ADsPath of the object to copy.
    ///    NewName = Optional name of the new object within the container. If a new name is not specified for the object, set to
    ///              <b>NULL</b>; the new object will have the same name as the source object.
    ///    ppObject = Indirect pointer to the IADs interface on the copied object.
    ///Returns:
    ///    This method supports the standard return values, including <b>S_OK</b> for a successful operation. For more
    ///    information and error code information, see ADSI Error Codes.
    ///    
    HRESULT CopyHere(BSTR SourceName, BSTR NewName, IDispatch* ppObject);
    ///The <b>IADsContainer::MoveHere</b>method moves a specified object to the container that implements this
    ///interface.The method can be used to rename an object.
    ///Params:
    ///    SourceName = The null-terminated Unicode string that specifies the <b>ADsPath</b> of the object to be moved.
    ///    NewName = The null-terminated Unicode string that specifies the relative name of the new object within the container.
    ///              This can be <b>NULL</b>, in which case the object is moved. If it is not <b>NULL</b>, the object is renamed
    ///              accordingly in the process.
    ///    ppObject = Pointer to a pointer to the IDispatch interface on the moved object.
    ///Returns:
    ///    This method supports standard return values, including <b>S_OK</b>, for a successful operation. For more
    ///    information about error codes, see ADSI Error Codes.
    ///    
    HRESULT MoveHere(BSTR SourceName, BSTR NewName, IDispatch* ppObject);
}

///The <b>IADsCollection</b> interface is a dual interface that enables its hosting ADSI object to define and manage an
///arbitrary set of named data elements for a directory service. Collections differ from arrays of elements in that
///individual items can be added or deleted without reordering the entire array. Collection objects can represent one or
///more items that correspond to volatile data, such as processes or active communication sessions, as well as
///persistent data, such as physical entities for a directory service. For example, a collection object can represent a
///list of print jobs in a queue or a list of active sessions connected to a server. Although a collection object can
///represent arbitrary data sets, all elements in a collection must be of the same type. The data are of <b>Variant</b>
///types. ADSI also exposes the IADsMembers and IADsContainer interfaces for manipulating two special cases of
///collection objects. <b>IADsMembers</b> is used for a collection of objects that share a common membership. An example
///of such objects are users that belong to a group. <b>IADsContainer</b> applies to an ADSI object that contains other
///objects. An example of this is a directory tree or a network topology.
@GUID("72B945E0-253B-11CF-A988-00AA006BC149")
interface IADsCollection : IDispatch
{
    ///The <b>IADsCollection::get__NewEnum</b> method gets a dependent enumerator object that implements IEnumVARIANT
    ///for this ADSI collection object. Be aware that there are two underscore characters in the function name
    ///(<b>get__NewEnum</b>).
    ///Params:
    ///    ppEnumerator = Pointer to a pointer to the IUnknown interface on the enumerator object for this collection.
    ///Returns:
    ///    This method supports the standard return values including <b>S_OK</b>, <b>E_FAIL</b>, or <b>E_NOTIMPL</b>.
    ///    For more information and other return values, see ADSI Error Codes.
    ///    
    HRESULT get__NewEnum(IUnknown* ppEnumerator);
    ///The <b>IADsCollection::Add</b> method adds a named item to the collection.
    ///Params:
    ///    bstrName = The <b>BSTR</b> value that specifies the item name. IADsCollection::GetObject and IADsCollection::Remove
    ///               reference the item by this name.
    ///    vItem = Item value. When the item is an object, this parameter holds the IDispatch interface pointer on the object.
    ///Returns:
    ///    This method supports the standard return values, as well as the following. For more information and other
    ///    return values, see ADSI Error Codes.
    ///    
    HRESULT Add(BSTR bstrName, VARIANT vItem);
    ///The <b>IADsCollection::Remove</b> method removes the named item from this ADSI collection object.
    ///Params:
    ///    bstrItemToBeRemoved = The null-terminated Unicode string that specifies the name of the item as it was specified by
    ///                          IADsCollection::Add.
    ///Returns:
    ///    This method supports the standard return values, including <b>S_OK</b>. For more information and other return
    ///    values, see ADSI Error Codes.
    ///    
    HRESULT Remove(BSTR bstrItemToBeRemoved);
    HRESULT GetObjectA(BSTR bstrName, VARIANT* pvItem);
}

///The <b>IADsMembers</b> interface is a dual interface. It is designed for managing a list of ADSI object references.
///It is implemented to support group membership for individual accounts. It can be used to manage a collection of ADSI
///objects belonging to a group. To access the collection of group members, use the IADsGroup::get_Members property
///method implemented by the ADSI group object. The <b>IADsMembers</b> interface serves a slightly different purpose
///from the IADsCollection and IADsContainer interfaces, which also works with a set of data or objects.
///<b>IADsCollection</b> manages sets of arbitrary data elements that are not object references, whereas
///<b>IADsContainer</b> manages objects that are part of the directory tree structure or the network topology.
@GUID("451A0030-72EC-11CF-B03B-00AA006E0975")
interface IADsMembers : IDispatch
{
    HRESULT get_Count(int* plCount);
    ///The <b>IADsMembers::get__NewEnum</b> method gets a dependent enumerator object that implements IEnumVARIANT for
    ///this ADSI collection object. Be aware that there are two underscore characters in the function name
    ///(<b>get__NewEnum</b>).
    ///Params:
    ///    ppEnumerator = Pointer to a pointer to the IUnknown interface on the enumerator object for this collection.
    ///Returns:
    ///    This method supports the standard return values, including S_OK. For more information about other return
    ///    values, see ADSI Error Codes.
    ///    
    HRESULT get__NewEnum(IUnknown* ppEnumerator);
    HRESULT get_Filter(VARIANT* pvFilter);
    HRESULT put_Filter(VARIANT pvFilter);
}

///The <b>IADsPropertyList</b> interface is used to modify, read, and update a list of property entries in the property
///cache of an object. It serves to enumerate, modify, and purge the contained property entries. Use the enumeration
///method of this interface to identify initialized properties. This is different from using the schema to determine all
///possible attributes that an ADSI object can have and which properties have been set. Call the methods of the
///<b>IADsPropertyList</b> interface to examine and manipulate the property list on the client. Before calling the
///methods of this interface, you must call IADs::GetInfo or IADs::GetInfoEx explicitly to load the assigned property
///values of the object into the cache. After calling the methods of this interface, you must call IADs::SetInfo to save
///the changes in the persistent store of the underlying directory. To obtain the property list of an ADSI object, bind
///to its <b>IADsPropertyList</b> interface. You must call the GetInfo method before calling other methods of property
///list object, if the property cache has not been initialized.
@GUID("C6F602B6-8F69-11D0-8528-00C04FD8D503")
interface IADsPropertyList : IDispatch
{
    HRESULT get_PropertyCount(int* plCount);
    ///The <b>IADsPropertyList::Next</b> method gets the next item in the property list. The returned item is a Property
    ///Entry object.
    ///Params:
    ///    pVariant = Address of a caller-allocated variable that contains the value of the next item in the property list. The
    ///               return value of <b>VT_DISPATCH</b> refers to an IDispatch interface pointer to an object implementing the
    ///               IADsPropertyEntry interface.
    ///Returns:
    ///    This method supports the standard <b>HRESULT</b> values, including <b>S_OK</b> if the item is obtained. When
    ///    the last item in the list is returned, the return value that is returned will differ depending on which
    ///    provider is used. The following codes are used to indicate that the last item in the list was obtained: For
    ///    more information and other return values, see ADSI Error Codes.
    ///    
    HRESULT Next(VARIANT* pVariant);
    ///The <b>IADsPropertyList::Skip</b> method skips a specified number of items, counting from the current cursor
    ///position, in the property list.
    ///Params:
    ///    cElements = Number of elements to be skipped.
    ///Returns:
    ///    This method supports the standard HRESULT return values, including S_OK. For more information and other
    ///    return values, see ADSI Error Codes.
    ///    
    HRESULT Skip(int cElements);
    ///The <b>IADsPropertyList::Reset</b> method resets the list to the first item.
    ///Returns:
    ///    This method supports the standard <b>HRESULT</b> values, including <b>S_OK</b>. For more information and
    ///    other return values, see ADSI Error Codes.
    ///    
    HRESULT Reset();
    ///The <b>IADsPropertyList::Item</b> method retrieves the specified property item from the list.
    ///Params:
    ///    varIndex = The <b>VARIANT</b> that contains the index or name of the property to be retrieved.
    ///    pVariant = Address of a caller-allocated <b>VARIANT</b> variable. On return, the <b>VARIANT</b> contains the IDispatch
    ///               pointer to the object which implements the IADsPropertyEntry interface for the attribute retrieved.
    ///Returns:
    ///    This method supports the standard HRESULT return values, including S_OK. For more information and other
    ///    return values, see ADSI Error Codes.
    ///    
    HRESULT Item(VARIANT varIndex, VARIANT* pVariant);
    ///The <b>IADsPropertyList::GetPropertyItem</b> method retrieves the item that matches the name from the list.
    ///Params:
    ///    bstrName = Contains the name of the requested property.
    ///    lnADsType = Contains one of the ADSTYPEENUM enumeration values that determines the data type to be used in interpreting
    ///                the requested property. If the type is unknown, this parameter can be set to <b>ADSTYPE_UNKNOWN</b>. For
    ///                schemaless servers, the user must specify the type.
    ///    pVariant = Address of a caller-allocated <b>VARIANT</b> variable. On return, the <b>VARIANT</b> contains the IDispatch
    ///               interface pointer of the object which implements the IADsPropertyEntry interface for the retrieved attribute.
    ///               Any memory allocated for this parameter must be released with the VariantClear function when the data is no
    ///               longer required.
    ///Returns:
    ///    This method supports the standard <b>HRESULT</b> return values, including <b>S_OK</b>. If the requested
    ///    property item is not found, the method returns <b>ADS_PROPERTY_NOT_FOUND</b>. For more information and other
    ///    return values, see ADSI Error Codes.
    ///    
    HRESULT GetPropertyItem(BSTR bstrName, int lnADsType, VARIANT* pVariant);
    ///The <b>IADsPropertyList::PutPropertyItem</b> method updates the values for an item in the property list.
    ///Params:
    ///    varData = New property values to be put in the property cache. This should contain the IDispatch pointer to the object
    ///              which implements the IADsPropertyEntry that contain the modified property values.
    ///Returns:
    ///    This method supports the standard HRESULT return values, including S_OK. For more information and other
    ///    return values, see ADSI Error Codes.
    ///    
    HRESULT PutPropertyItem(VARIANT varData);
    ///The <b>IADsPropertyList::ResetPropertyItem</b> method removes the specified item from the list; that is, from the
    ///cache. You can specify the item to be removed by name (as a string) or by index (as an integer).
    ///Params:
    ///    varEntry = Entry to be reset.
    ///Returns:
    ///    This method supports the standard <b>HRESULT</b> return values, including <b>S_OK</b>. For more information
    ///    and other return values, see ADSI Error Codes.
    ///    
    HRESULT ResetPropertyItem(VARIANT varEntry);
    ///The <b>IADsPropertyList::PurgePropertyList</b> method deletes all items from the property list.
    ///Returns:
    ///    This method supports the standard HRESULT return values, including S_OK. For more information and other
    ///    return values, see ADSI Error Codes.
    ///    
    HRESULT PurgePropertyList();
}

///The <b>IADsPropertyEntry</b> interface is used to manage a property entry in the property cache. A property entry
///holds a value (or values) of an attribute as defined in the schema. It is identified by the name of the corresponding
///attribute. A property entry object allows a user to specify how its values are to be manipulated. Examples of such
///operations include "update," "modify," and "delete". Multiple property entries are managed by a property list. To
///access a property entry, you call Item or GetPropertyItem method on the IADsPropertyList interface. Use the property
///methods of <b>IADsPropertyEntry</b> to examine and manipulate individual properties. Before calling the methods of
///this interface, you must call IADs::GetInfo or IADs::GetInfoEx explicitly to load the assigned property values of the
///object into the cache. After calling the methods of this interfaces, you must call IADs::SetInfo to save the changes
///in the persistent store of the underlying directory.
@GUID("05792C8E-941F-11D0-8529-00C04FD8D503")
interface IADsPropertyEntry : IDispatch
{
    HRESULT Clear();
    HRESULT get_Name(BSTR* retval);
    HRESULT put_Name(BSTR bstrName);
    HRESULT get_ADsType(int* retval);
    HRESULT put_ADsType(int lnADsType);
    HRESULT get_ControlCode(int* retval);
    HRESULT put_ControlCode(int lnControlCode);
    HRESULT get_Values(VARIANT* retval);
    HRESULT put_Values(VARIANT vValues);
}

///The <b>IADsPropertyValue</b> interface is used to represent the value of an IADsPropertyEntry object in a predefined
///data type. This interface exposes several properties for obtaining data values in the corresponding data format. The
///IADsPropertyEntry.Values property contains an array of <b>IADsPropertyValue</b> objects. Each of the
///<b>IADsPropertyValue</b> objects contains a single value of the IADsPropertyEntry object. For more information and a
///code example for creating entirely new property entries and values, see IADsPropertyList.PutPropertyItem. When
///obtaining values in a format not provided by one of the properties of this interface, use the IADsPropertyValue2
///interface. Before calling the methods of this interfaces, call IADs.GetInfo or IADs.GetInfoEx explicitly to load the
///assigned values of the object into the cache, if the cache has not been initialized. After modifying the properties
///of this interface, call IADs.SetInfo to save the changes to the persistent store of the underlying directory.
@GUID("79FA9AD0-A97C-11D0-8534-00C04FD8D503")
interface IADsPropertyValue : IDispatch
{
    ///The <b>IADsPropertyValue::Clear</b> method clears the current values of the property value object.
    ///Returns:
    ///    This method supports the standard HRESULT return values, including S_OK. For more information and other
    ///    return values, see ADSI Error Codes.
    ///    
    HRESULT Clear();
    HRESULT get_ADsType(int* retval);
    HRESULT put_ADsType(int lnADsType);
    HRESULT get_DNString(BSTR* retval);
    HRESULT put_DNString(BSTR bstrDNString);
    HRESULT get_CaseExactString(BSTR* retval);
    HRESULT put_CaseExactString(BSTR bstrCaseExactString);
    HRESULT get_CaseIgnoreString(BSTR* retval);
    HRESULT put_CaseIgnoreString(BSTR bstrCaseIgnoreString);
    HRESULT get_PrintableString(BSTR* retval);
    HRESULT put_PrintableString(BSTR bstrPrintableString);
    HRESULT get_NumericString(BSTR* retval);
    HRESULT put_NumericString(BSTR bstrNumericString);
    HRESULT get_Boolean(int* retval);
    HRESULT put_Boolean(int lnBoolean);
    HRESULT get_Integer(int* retval);
    HRESULT put_Integer(int lnInteger);
    HRESULT get_OctetString(VARIANT* retval);
    HRESULT put_OctetString(VARIANT vOctetString);
    HRESULT get_SecurityDescriptor(IDispatch* retval);
    HRESULT put_SecurityDescriptor(IDispatch pSecurityDescriptor);
    HRESULT get_LargeInteger(IDispatch* retval);
    HRESULT put_LargeInteger(IDispatch pLargeInteger);
    HRESULT get_UTCTime(double* retval);
    HRESULT put_UTCTime(double daUTCTime);
}

///The <b>IADsPropertyValue2</b> interface is used to represent the value of an IADsPropertyEntry object in any data
///format, including new or customer-defined data types. This interface is also useful for handling attribute values for
///multiple directory services. The IADsPropertyEntry.Values property contains an array of <b>IADsPropertyValue2</b>
///objects. Each of the IADsPropertyValue objects contains a single value of the IADsPropertyEntry object. For more
///information and a code example for creating entirely new property entries and values, see
///IADsPropertyList.PutPropertyItem. Before calling the methods of this interfaces, you must call IADs.GetInfo or
///IADs.GetInfoEx explicitly to load the assigned values of the object into the cache, if the cache has not been
///initialized. After modifying the values of the object, you must call IADs.SetInfo to save the changes to the
///persistent store of the underlying directory. This interface is more versatile than the IADsPropertyValue because
///this interface can be used to obtain any data type. The <b>IADsPropertyValue</b> interface can only be used to obtain
///a limited number of data types.
@GUID("306E831C-5BC7-11D1-A3B8-00C04FB950DC")
interface IADsPropertyValue2 : IDispatch
{
    ///The <b>IADsPropertyValue2::GetObjectProperty</b> method retrieves an attribute value.
    ///Params:
    ///    lnADsType = Pointer to a variable that, on entry, contains one of the ADSTYPEENUM values that specifies the data format
    ///                that the value should be returned. If the data type is not known, set this to <b>ADSTYPE_UNKNOWN</b>. In this
    ///                case, this method will obtain the attribute value in the default data type and set this variable to the
    ///                corresponding ADSTYPEENUM value. If any other <b>ADSTYPEENUM</b> value is specified, ADSI will return the
    ///                attribute value only if the data type matches the format of the value.
    ///    pvProp = Pointer to a <b>VARIANT</b> that receives the requested attribute value. The variant type of this data will
    ///             depend on the value returned in <i>lnADsType</i>. For more information and a list of the <i>lnADsType</i>
    ///             values and corresponding <i>pvProp</i> variant types, see IADsPropertyValue2.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful or one of the following error codes.
    ///    
    HRESULT GetObjectProperty(int* lnADsType, VARIANT* pvProp);
    ///The <b>IADsPropertyValue2::PutObjectProperty</b> method sets an attribute value.
    ///Params:
    ///    lnADsType = Contains one of the ADSTYPEENUM values that specifies the data format of the value set. This value must
    ///                correspond to the <i>pvProp</i> variant type. For more information and a list of the <i>lnADsType</i> values
    ///                and corresponding <i>pvProp</i> variant types, see IADsPropertyValue2.
    ///    vProp = Pointer to a <b>VARIANT</b> that contains the new attribute value. The variant type of this data must
    ///            correspond to the value in <i>lnADsType</i>. For more information and a list of the <i>lnADsType</i> values
    ///            and corresponding <i>pvProp</i> variant types, see IADsPropertyValue2.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful or an error code otherwise. The following are the most common error codes.
    ///    
    HRESULT PutObjectProperty(int lnADsType, VARIANT vProp);
}

@GUID("86AB4BBE-65F6-11D1-8C13-00C04FD8D503")
interface IPrivateDispatch : IUnknown
{
    HRESULT ADSIInitializeDispatchManager(int dwExtensionId);
    HRESULT ADSIGetTypeInfoCount(uint* pctinfo);
    HRESULT ADSIGetTypeInfo(uint itinfo, uint lcid, ITypeInfo* pptinfo);
    HRESULT ADSIGetIDsOfNames(const(GUID)* riid, ushort** rgszNames, uint cNames, uint lcid, int* rgdispid);
    HRESULT ADSIInvoke(int dispidMember, const(GUID)* riid, uint lcid, ushort wFlags, DISPPARAMS* pdispparams, 
                       VARIANT* pvarResult, EXCEPINFO* pexcepinfo, uint* puArgErr);
}

@GUID("89126BAB-6EAD-11D1-8C18-00C04FD8D503")
interface IPrivateUnknown : IUnknown
{
    HRESULT ADSIInitializeObject(BSTR lpszUserName, BSTR lpszPassword, int lnReserved);
    HRESULT ADSIReleaseObject();
}

///The <b>IADsExtension</b> interface forms the basis of the ADSI application extension model. It enables an independent
///software vendor (ISV) to add application-specific behaviors, such as methods or functions, into an existing ADSI
///object. Multiple vendors can independently extend the features of the same object to perform similar, but unrelated
///operations. The extension model is based on the aggregation model in COM. An aggregator, or outer object, can add to
///its base of methods, those of an aggregate object, or inner object. An ADSI extension object, which implements the
///<b>IADsExtension</b> interface, is an aggregate object, whereas an ADSI provider is an aggregator. <div
///class="alert"><b>Note</b> When implementing an extension module, release an interface when finished with it.
///Otherwise, the aggregator cannot release the interface even when no longer required.</div><div> </div>The
///<b>IADsExtension</b> interface can be used as follows: <ul> <li>The extension component requires an initialization
///notification as defined by <i>dwCode</i> in the Operate method. In this case, an extension client must call the
///<b>Operate</b> method. The other two methods, namely, PrivateInvoke and PrivateGetIDsOfNames, usually return
///<b>E_NOTIMPL</b> in the <b>HRESULT</b> value.</li> <li>The extension component supports any dual or dispatch
///interface. In this case, an extension client must call the PrivateGetIDsOfNames or PrivateInvoke methods. Operate
///usually ignores the data and returns <b>E_NOTIMPL</b> in the <b>HRESULT</b> value.</li> </ul>
@GUID("3D35553C-D2B0-11D1-B17B-0000F87593A0")
interface IADsExtension : IUnknown
{
    ///The <b>IADsExtension::Operate</b> method is invoked by the aggregator to perform the extended functionality. The
    ///method interprets the control code and input parameters according to the specifications of the provider. For more
    ///information, see the provider documentation.
    ///Params:
    ///    dwCode = A value of the ADSI extension control code. ADSI defines the following code value.
    ///    varData1 = Provider-supplied data the extension object will operate on. The value depends upon the control code value
    ///               and is presently undefined.
    ///    varData2 = Provider-supplied data the extension object will operate on. The value depends upon the control code value
    ///               and is presently undefined.
    ///    varData3 = Provider-supplied data the extension object will operate on. The value depends upon the control code value
    ///               and is presently undefined.
    ///Returns:
    ///    This method supports the standard return values, as well as the following: For more information about other
    ///    return values, see ADSI Error Codes.
    ///    
    HRESULT Operate(uint dwCode, VARIANT varData1, VARIANT varData2, VARIANT varData3);
    ///The <b>IADsExtension::PrivateGetIDsOfNames</b> method is called by the aggregator, ADSI, after ADSI determines
    ///that the extension is used to support a dual or dispatch interface. The method can use the type data to get
    ///DISPID using IDispatch::GetIDsOfNames.
    ///Params:
    ///    riid = Reserved for future use. It must be IID_NULL.
    ///    rgszNames = Passed-in array of names to be mapped.
    ///    cNames = Count of the names to be mapped.
    ///    lcid = The locale context in which to interpret the names.
    ///    rgDispid = Caller-allocated array, each element of which contains an identifier that corresponds to one of the names
    ///               passed in the <i>rgszNames</i> array. The first element represents the member name. The subsequent elements
    ///               represent each of the member's parameters.
    ///Returns:
    ///    The return values are the same as those of the standard IDispatch::GetIDsOfNames method. For more information
    ///    about other return values, see ADSI Error Codes.
    ///    
    HRESULT PrivateGetIDsOfNames(const(GUID)* riid, ushort** rgszNames, uint cNames, uint lcid, int* rgDispid);
    ///The <b>IADsExtension::PrivateInvoke</b> method is normally called by ADSI after the
    ///IADsExtension::PrivateGetIDsOfNames method. This method can either have a custom implementation or it can
    ///delegate the operation to IDispatch::DispInvoke method.
    ///Params:
    ///    dispidMember = Identifies the member. Use the IADsExtension::PrivateGetIDsOfNames method to obtain the dispatch identifier.
    ///    riid = Reserved for future use. Must be IID_NULL.
    ///    lcid = The locale context in which to interpret arguments. The IADsExtension::PrivateGetIDsOfNames function uses
    ///           <i>lcid</i>. It is also passed to the <b>PrivateInvoke</b> method to allow the object to interpret the
    ///           arguments that are specific to a locale.
    ///    wFlags = Flags that describe the context of the <b>PrivateInvoke</b> call, include.
    ///    pdispparams = Pointer to a DISPPARAMS structure that receives an array of arguments, an array of argument DISPIDs for named
    ///                  arguments, and counts for the number of elements in the arrays.
    ///    pvarResult = Pointer to the location where the result is to be stored, or <b>NULL</b> if the caller expects no result.
    ///                 This argument is ignored if <b>DISPATCH_PROPERTYPUT</b> or <b>DISPATCH_PROPERTYPUTREF</b> is specified.
    ///    pexcepinfo = Pointer to a structure that contains exception data. This structure should be filled in if
    ///                 <b>DISP_E_EXCEPTION</b> is returned. Can be <b>NULL</b>.
    ///    puArgErr = The index within the <b>rgvarg</b> member of the DISPPARAMS structure in <i>pdispparams</i> for the first
    ///               argument that has an error. Arguments are stored in the <b>rgvarg</b> array in reverse order, so the first
    ///               argument is the one with the highest index in the array. This parameter is returned only when the resulting
    ///               return value is <b>DISP_E_TYPEMISMATCH</b> or <b>DISP_E_PARAMNOTFOUND</b>.
    ///Returns:
    ///    This method supports the standard return values, as well as the following. For more information about other
    ///    return values, see ADSI Error Codes.
    ///    
    HRESULT PrivateInvoke(int dispidMember, const(GUID)* riid, uint lcid, ushort wFlags, DISPPARAMS* pdispparams, 
                          VARIANT* pvarResult, EXCEPINFO* pexcepinfo, uint* puArgErr);
}

///The <b>IADsDeleteOps</b> interface specifies a method an object can use to delete itself from the underlying
///directory. For a container object, the method deletes its children and the entire subtree. The interface is designed
///to offer features that complement IADsContainer. To remove an object from the directory store, request its parent
///object to perform the operation. That amounts to calling the IADsContainer::Delete method on the contained object.
///When the object also implements the <b>IADsDeleteOps</b> interface, you can instruct the object to remove itself, and
///all the contained objects, by calling the IADsDeleteOps::DeleteObject method directly on the object.
@GUID("B2BD0902-8878-11D1-8C21-00C04FD8D503")
interface IADsDeleteOps : IDispatch
{
    ///The <b>IADsDeleteOps::DeleteObject</b> method deletes an ADSI object.
    ///Params:
    ///    lnFlags = Reserved.
    ///Returns:
    ///    This method supports standard return values, including S_OK for a successful operation. For more information
    ///    about error codes, see ADSI Error Codes.
    ///    
    HRESULT DeleteObject(int lnFlags);
}

///The <b>IADsNamespaces</b> interface is implemented by the ADs provider and is used for managing namespace objects. A
///namespace object is a provider-specific top-level container and corresponds to the root node of a directory tree. The
///ADSI namespaces object serves as an entry point into the underlying directory and allows directory service
///administrators to enumerate the currently installed namespace objects. This interface supports two property methods
///to get and set the DefaultContainer property which holds the path to a container object. The default container is the
///base node from which browsing of the directory tree proceeds. References of any children objects can be made relative
///to this default container. The <b>DefaultContainer</b> property makes it more efficient and convenient for a client
///to reference repetitively a contained object. Obtain a pointer to the <b>IADsNamespaces</b> interface when you bind
///to the object using the "ADs:" string: ```vb Dim ns As IADsNamespaces Set ns = GetObject("ADs:") ``` Non-Automation
///clients can use the ADsGetObject helper function instead. ```cpp IADsNamespaces *pNs; hr = ADsGetObject(L"ADs:",
///IID_IADsNamespaces, (void**)&pNs); ``` In addition to the <b>IADsNamespaces</b> interface, the ADSI namespaces object
///also implements the IADsContainer interface.
@GUID("28B96BA0-B330-11CF-A9AD-00AA006BC149")
interface IADsNamespaces : IADs
{
    HRESULT get_DefaultContainer(BSTR* retval);
    HRESULT put_DefaultContainer(BSTR bstrDefaultContainer);
}

///The <b>IADsClass</b> interface is designed for managing schema class objects that provide class definitions for any
///ADSI object. Other schema management interfaces include IADsProperty for attribute definitions and IADsSyntax for
///attribute syntax.
@GUID("C8F93DD0-4AE0-11CF-9E73-00AA004A5691")
interface IADsClass : IADs
{
    HRESULT get_PrimaryInterface(BSTR* retval);
    HRESULT get_CLSID(BSTR* retval);
    HRESULT put_CLSID(BSTR bstrCLSID);
    HRESULT get_OID(BSTR* retval);
    HRESULT put_OID(BSTR bstrOID);
    HRESULT get_Abstract(short* retval);
    HRESULT put_Abstract(short fAbstract);
    HRESULT get_Auxiliary(short* retval);
    HRESULT put_Auxiliary(short fAuxiliary);
    HRESULT get_MandatoryProperties(VARIANT* retval);
    HRESULT put_MandatoryProperties(VARIANT vMandatoryProperties);
    HRESULT get_OptionalProperties(VARIANT* retval);
    HRESULT put_OptionalProperties(VARIANT vOptionalProperties);
    HRESULT get_NamingProperties(VARIANT* retval);
    HRESULT put_NamingProperties(VARIANT vNamingProperties);
    HRESULT get_DerivedFrom(VARIANT* retval);
    HRESULT put_DerivedFrom(VARIANT vDerivedFrom);
    HRESULT get_AuxDerivedFrom(VARIANT* retval);
    HRESULT put_AuxDerivedFrom(VARIANT vAuxDerivedFrom);
    HRESULT get_PossibleSuperiors(VARIANT* retval);
    HRESULT put_PossibleSuperiors(VARIANT vPossibleSuperiors);
    HRESULT get_Containment(VARIANT* retval);
    HRESULT put_Containment(VARIANT vContainment);
    HRESULT get_Container(short* retval);
    HRESULT put_Container(short fContainer);
    HRESULT get_HelpFileName(BSTR* retval);
    HRESULT put_HelpFileName(BSTR bstrHelpFileName);
    HRESULT get_HelpFileContext(int* retval);
    HRESULT put_HelpFileContext(int lnHelpFileContext);
    ///The <b>IADsClass::Qualifiers</b> method is an optional method that returns a collection of ADSI objects that
    ///describe additional qualifiers for this schema class.
    ///Params:
    ///    ppQualifiers = Address of an IADsCollection pointer variable that receives the interface pointer to the ADSI collection
    ///                   object that represents additional limits for this schema class.
    ///Returns:
    ///    This method supports the standard return values, as well as the following. For more information and other
    ///    return values, see ADSI Error Codes.
    ///    
    HRESULT Qualifiers(IADsCollection* ppQualifiers);
}

///The <b>IADsProperty</b> interface is designed to manage a single attribute definition for a schema class object. An
///attribute definition specifies the minimum and maximum values of a property, its syntax, and whether the property
///supports multiple values. Other interfaces involved in schema management include IADsClass and IADsSyntax. The
///<b>IADsProperty</b> interface exposes methods to describe a property by name, syntax, value ranges, and any other
///defined attributes. A property can have multiple names associated with it, but providers must ensure that each name
///is unique. Use the <b>IADsProperty</b> interface to determine at run time the attribute definition of a property
///supported by a directory service object. <p class="proch"><b>To determine the attribute definition at run time</b>
///<ol> <li>Bind to the schema class object of the ADSI object.</li> <li>Enumerate mandatory or optional attributes
///accessible from the schema class object. Skip this step if you know that the object supports the attribute of your
///interest.</li> <li>Bind to the schema container of the schema class object you obtained in first step.</li>
///<li>Retrieve the attribute definition object of the property of interest from the schema container.</li> <li>Examine
///the attribute definition of the property. You may have to also inspect the syntax object.</li> </ol>
@GUID("C8F93DD3-4AE0-11CF-9E73-00AA004A5691")
interface IADsProperty : IADs
{
    HRESULT get_OID(BSTR* retval);
    HRESULT put_OID(BSTR bstrOID);
    HRESULT get_Syntax(BSTR* retval);
    HRESULT put_Syntax(BSTR bstrSyntax);
    HRESULT get_MaxRange(int* retval);
    HRESULT put_MaxRange(int lnMaxRange);
    HRESULT get_MinRange(int* retval);
    HRESULT put_MinRange(int lnMinRange);
    HRESULT get_MultiValued(short* retval);
    HRESULT put_MultiValued(short fMultiValued);
    ///The <b>IADsProperty::Qualifiers</b> method is an optional method that returns a collection of ADSI objects that
    ///describe additional qualifiers of this property.
    ///Params:
    ///    ppQualifiers = Indirect pointer to the IADsCollection interface on the ADSI collection object that represents additional
    ///                   limits for this property.
    ///Returns:
    ///    This method supports the standard return values <b>E_FAIL</b> and <b>E_UNEXPECTED</b>, as well as the
    ///    following:
    ///    
    HRESULT Qualifiers(IADsCollection* ppQualifiers);
}

///The <b>IADsSyntax</b> interface specifies methods to identify and modify the available Automation data types used to
///represent its data. ADSI defines a standard set of syntax objects that can be used uniformly across multiple
///directory service implementations. Use the <b>IADsSyntax</b> interface to process the property values of any instance
///of ADSI schema class object.
@GUID("C8F93DD2-4AE0-11CF-9E73-00AA004A5691")
interface IADsSyntax : IADs
{
    HRESULT get_OleAutoDataType(int* retval);
    HRESULT put_OleAutoDataType(int lnOleAutoDataType);
}

///The <b>IADsLocality</b> interface is a dual interface that inherits from IADs. It is designed to represent the
///geographical location, or region, of a directory entity. This interface is one of several that provide support for
///directory services to organize accounts by country/region, locality (state/city/region), organization (company), or
///organizational unit (department). This interface manages locality, the IADsO interface manages organization, and the
///IADsOU interface manages the organization unit. When a directory service provides hierarchical groupings of directory
///entries by country/region, locality, organization, or organization unit, you can use this and the related interfaces
///to expand the directory tree accordingly. In this case, the <b>IADsLocality</b> interface is implemented by a
///locality object that implements the IADsContainer interface.
@GUID("A05E03A2-EFFE-11CF-8ABC-00C04FD8D503")
interface IADsLocality : IADs
{
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_LocalityName(BSTR* retval);
    HRESULT put_LocalityName(BSTR bstrLocalityName);
    HRESULT get_PostalAddress(BSTR* retval);
    HRESULT put_PostalAddress(BSTR bstrPostalAddress);
    HRESULT get_SeeAlso(VARIANT* retval);
    HRESULT put_SeeAlso(VARIANT vSeeAlso);
}

///The <b>IADsO</b> interface is a dual interface that inherits from IADs. It is designed for representing and managing
///the organization to which an account belongs. This interface is one of several that provide support for directory
///services to organize accounts by country/region, locality (state/city/region), organization (company), and
///organizational unit (department). Organization is managed by this interface, locality by the IADsLocality interface,
///and organization unit by IADsOU. When a directory service provides hierarchical groupings of directory entries by
///country/region, locality, organization, and organization unit, you can use this, and the related interfaces, to
///expand the directory tree accordingly. In this case, the <b>IADsO</b> interface is implemented by an organization
///object that implements the IADsContainer interface as well.
@GUID("A1CD2DC6-EFFE-11CF-8ABC-00C04FD8D503")
interface IADsO : IADs
{
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_LocalityName(BSTR* retval);
    HRESULT put_LocalityName(BSTR bstrLocalityName);
    HRESULT get_PostalAddress(BSTR* retval);
    HRESULT put_PostalAddress(BSTR bstrPostalAddress);
    HRESULT get_TelephoneNumber(BSTR* retval);
    HRESULT put_TelephoneNumber(BSTR bstrTelephoneNumber);
    HRESULT get_FaxNumber(BSTR* retval);
    HRESULT put_FaxNumber(BSTR bstrFaxNumber);
    HRESULT get_SeeAlso(VARIANT* retval);
    HRESULT put_SeeAlso(VARIANT vSeeAlso);
}

///The <b>IADsOU</b> interface is a dual interface that is used to manage organizationalUnit objects. All
///organizationalUnit objects that implement this interface also implement the IADsContainer interface.
@GUID("A2F733B8-EFFE-11CF-8ABC-00C04FD8D503")
interface IADsOU : IADs
{
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_LocalityName(BSTR* retval);
    HRESULT put_LocalityName(BSTR bstrLocalityName);
    HRESULT get_PostalAddress(BSTR* retval);
    HRESULT put_PostalAddress(BSTR bstrPostalAddress);
    HRESULT get_TelephoneNumber(BSTR* retval);
    HRESULT put_TelephoneNumber(BSTR bstrTelephoneNumber);
    HRESULT get_FaxNumber(BSTR* retval);
    HRESULT put_FaxNumber(BSTR bstrFaxNumber);
    HRESULT get_SeeAlso(VARIANT* retval);
    HRESULT put_SeeAlso(VARIANT vSeeAlso);
    HRESULT get_BusinessCategory(BSTR* retval);
    HRESULT put_BusinessCategory(BSTR bstrBusinessCategory);
}

///The <b>IADsDomain</b> interface is a dual interface that inherits from IADs. It is designed to represent a network
///domain and manage domain accounts. Use this interface to determine whether the domain is actually a Workgroup, to
///specify how frequently a user must change a password, and to specify the maximum number of invalid password logins
///allowed before a lockout on the account is set. To change a password, call the <b>ChangePassword</b> method on an
///ADSI object that supports password controls. For example, to change the password of a user account, call
///IADsUser::ChangePassword on the user object.
@GUID("00E4C220-FD16-11CE-ABC4-02608C9E7553")
interface IADsDomain : IADs
{
    HRESULT get_IsWorkgroup(short* retval);
    HRESULT get_MinPasswordLength(int* retval);
    HRESULT put_MinPasswordLength(int lnMinPasswordLength);
    HRESULT get_MinPasswordAge(int* retval);
    HRESULT put_MinPasswordAge(int lnMinPasswordAge);
    HRESULT get_MaxPasswordAge(int* retval);
    HRESULT put_MaxPasswordAge(int lnMaxPasswordAge);
    HRESULT get_MaxBadPasswordsAllowed(int* retval);
    HRESULT put_MaxBadPasswordsAllowed(int lnMaxBadPasswordsAllowed);
    HRESULT get_PasswordHistoryLength(int* retval);
    HRESULT put_PasswordHistoryLength(int lnPasswordHistoryLength);
    HRESULT get_PasswordAttributes(int* retval);
    HRESULT put_PasswordAttributes(int lnPasswordAttributes);
    HRESULT get_AutoUnlockInterval(int* retval);
    HRESULT put_AutoUnlockInterval(int lnAutoUnlockInterval);
    HRESULT get_LockoutObservationInterval(int* retval);
    HRESULT put_LockoutObservationInterval(int lnLockoutObservationInterval);
}

///The <b>IADsComputer</b> interface is a dual interface that inherits from IADs. It is designed to represent and manage
///a computer, such as a server, client, workstation, and so on, on a network. You can manipulate the properties of this
///interface to access data about a computer. The data includes the operating system, the make and model, processor,
///computer identifier, its network addresses, and so on. <div class="alert"><b>Note</b> The <b>IADsComputer</b>
///interface is not implemented by the LDAP ADSI provider. For more information, see ADSI Objects of LDAP.</div><div>
///</div>
@GUID("EFE3CC70-1D9F-11CF-B1F3-02608C9E7553")
interface IADsComputer : IADs
{
    HRESULT get_ComputerID(BSTR* retval);
    HRESULT get_Site(BSTR* retval);
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_Location(BSTR* retval);
    HRESULT put_Location(BSTR bstrLocation);
    HRESULT get_PrimaryUser(BSTR* retval);
    HRESULT put_PrimaryUser(BSTR bstrPrimaryUser);
    HRESULT get_Owner(BSTR* retval);
    HRESULT put_Owner(BSTR bstrOwner);
    HRESULT get_Division(BSTR* retval);
    HRESULT put_Division(BSTR bstrDivision);
    HRESULT get_Department(BSTR* retval);
    HRESULT put_Department(BSTR bstrDepartment);
    HRESULT get_Role(BSTR* retval);
    HRESULT put_Role(BSTR bstrRole);
    HRESULT get_OperatingSystem(BSTR* retval);
    HRESULT put_OperatingSystem(BSTR bstrOperatingSystem);
    HRESULT get_OperatingSystemVersion(BSTR* retval);
    HRESULT put_OperatingSystemVersion(BSTR bstrOperatingSystemVersion);
    HRESULT get_Model(BSTR* retval);
    HRESULT put_Model(BSTR bstrModel);
    HRESULT get_Processor(BSTR* retval);
    HRESULT put_Processor(BSTR bstrProcessor);
    HRESULT get_ProcessorCount(BSTR* retval);
    HRESULT put_ProcessorCount(BSTR bstrProcessorCount);
    HRESULT get_MemorySize(BSTR* retval);
    HRESULT put_MemorySize(BSTR bstrMemorySize);
    HRESULT get_StorageCapacity(BSTR* retval);
    HRESULT put_StorageCapacity(BSTR bstrStorageCapacity);
    HRESULT get_NetAddresses(VARIANT* retval);
    HRESULT put_NetAddresses(VARIANT vNetAddresses);
}

///The <b>IADsComputerOperations</b> interface is a dual interface that inherits from IADs. It exposes methods for
///retrieving the status of a computer over a network and to enable remote shutdown. Directory service providers may
///choose to implement this interface to support basic system administration over a network through ADSI.
@GUID("EF497680-1D9F-11CF-B1F3-02608C9E7553")
interface IADsComputerOperations : IADs
{
    ///The <b>IADsComputerOperations::Status</b> method retrieves the status of a computer.
    ///Params:
    ///    ppObject = Pointer to an IDispatch interface that reports the status code of computer operations. The status code is
    ///               provider-specific.
    ///Returns:
    ///    This method supports the standard return values as well as the following: For other return values, see ADSI
    ///    Error Codes.
    ///    
    HRESULT Status(IDispatch* ppObject);
    ///The <b>IADsComputerOperations::Shutdown</b> method causes a computer under ADSI control to execute the shutdown
    ///operation with an optional reboot.
    ///Params:
    ///    bReboot = If <b>TRUE</b>, then reboot the computer after the shutdown is complete.
    ///Returns:
    ///    This method supports the standard return values, as well as the following: For other return values, see ADSI
    ///    Error Codes.
    ///    
    HRESULT Shutdown(short bReboot);
}

///The <b>IADsGroup</b> interface is a dual interface that inherits from IADs. It manages group membership data in a
///directory service. It enables you to get member objects, test if a given object belongs to the group, and to add, or
///remove, an object to, or from, the group.
@GUID("27636B00-410F-11CF-B1FF-02608C9E7553")
interface IADsGroup : IADs
{
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    ///The <b>IADsGroup::Members</b> method retrieves a collection of the immediate members of the group. The collection
    ///does not include the members of other groups that are nested within the group. The default implementation of this
    ///method uses LsaLookupSids to query name information for the group members. LsaLookupSids has a maximum limitation
    ///of 20480 SIDs it can convert, therefore that limitation also applies to this method.
    ///Params:
    ///    ppMembers = Pointer to an IADsMembers interface pointer that receives the collection of group members. The caller must
    ///                release this interface when it is no longer required.
    ///Returns:
    ///    This method supports the standard return values, including <b>S_OK</b>. For more information and other return
    ///    values, see ADSI Error Codes.
    ///    
    HRESULT Members(IADsMembers* ppMembers);
    ///The <b>IADsGroup::IsMember</b> method determines if a directory service object is an immediate member of the
    ///group. This method does not verify membership in any nested groups.
    ///Params:
    ///    bstrMember = Contains the ADsPath of the directory service object to verify membership. This ADsPath must use the same
    ///                 ADSI provider used to bind to the group. For example, if the group was bound to using the LDAP provider, this
    ///                 ADsPath must also use the LDAP provider.
    ///    bMember = Pointer to a <b>VARIANT_BOOL</b> value that receives <b>VARIANT_TRUE</b> if the object is an immediate member
    ///              of the group or <b>VARIANT_FALSE</b> otherwise.
    ///Returns:
    ///    This method supports the standard return values, including <b>S_OK</b>. For more information, see ADSI Error
    ///    Codes.
    ///    
    HRESULT IsMember(BSTR bstrMember, short* bMember);
    ///The <b>IADsGroup::Add</b> method adds an ADSI object to an existing group.
    ///Params:
    ///    bstrNewItem = Contains a <b>BSTR</b> that specifies the ADsPath of the object to add to the group. For more information,
    ///                  see Remarks.
    ///Returns:
    ///    The following are the most common return values. For more information about return values, see ADSI Error
    ///    Codes.
    ///    
    HRESULT Add(BSTR bstrNewItem);
    ///The <b>IADsGroup::Remove</b> method removes the specified user object from this group. The operation does not
    ///remove the group object itself even when there is no member remaining in the group.
    ///Params:
    ///    bstrItemToBeRemoved = Contains a <b>BSTR</b> that specifies the ADsPath of the object to remove from the group. For more
    ///                          information about this parameter, see the Remarks section.
    ///Returns:
    ///    The following are the most common return values. For more information about return values, see ADSI Error
    ///    Codes.
    ///    
    HRESULT Remove(BSTR bstrItemToBeRemoved);
}

///The <b>IADsUser</b> interface is a dual interface that inherits from IADs. It is designed to represent and manage an
///end-user account on a network. Call the methods of this interface to access and manipulate end-user account data.
///Such data includes names of the user, telephone numbers, job title, and so on. This interface supports features for
///determining the group association of the user, and for setting or changing the password. To bind to a domain user
///through a WinNT provider, use the domain name as part of the ADsPath, as shown in the following code example. ```cpp
///GetObject("WinNT://MYDOMAIN/jeffsmith,user") ``` Similarly, use the computer name as part of the ADsPath to bind to a
///local user. ```cpp GetObject("WinNT://MYCOMPUTER/jeffsmith,user") ``` In Active Directory, domain users reside in the
///directory. The following code example shows how to bind to a domain user through an LDAP provider. ```cpp
///GetObject("LDAP://CN=Jeff Smith,OU=Sales,DC=Fabrikam,DC=Com") ``` However, local accounts reside in the local SAM
///database and the LDAP provider does not communicate with the local database. Thus, to bind to a local user, you must
///go through a WinNT provider as described in the second code example.
@GUID("3E37E320-17E2-11CF-ABC4-02608C9E7553")
interface IADsUser : IADs
{
    HRESULT get_BadLoginAddress(BSTR* retval);
    HRESULT get_BadLoginCount(int* retval);
    HRESULT get_LastLogin(double* retval);
    HRESULT get_LastLogoff(double* retval);
    HRESULT get_LastFailedLogin(double* retval);
    HRESULT get_PasswordLastChanged(double* retval);
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_Division(BSTR* retval);
    HRESULT put_Division(BSTR bstrDivision);
    HRESULT get_Department(BSTR* retval);
    HRESULT put_Department(BSTR bstrDepartment);
    HRESULT get_EmployeeID(BSTR* retval);
    HRESULT put_EmployeeID(BSTR bstrEmployeeID);
    HRESULT get_FullName(BSTR* retval);
    HRESULT put_FullName(BSTR bstrFullName);
    HRESULT get_FirstName(BSTR* retval);
    HRESULT put_FirstName(BSTR bstrFirstName);
    HRESULT get_LastName(BSTR* retval);
    HRESULT put_LastName(BSTR bstrLastName);
    HRESULT get_OtherName(BSTR* retval);
    HRESULT put_OtherName(BSTR bstrOtherName);
    HRESULT get_NamePrefix(BSTR* retval);
    HRESULT put_NamePrefix(BSTR bstrNamePrefix);
    HRESULT get_NameSuffix(BSTR* retval);
    HRESULT put_NameSuffix(BSTR bstrNameSuffix);
    HRESULT get_Title(BSTR* retval);
    HRESULT put_Title(BSTR bstrTitle);
    HRESULT get_Manager(BSTR* retval);
    HRESULT put_Manager(BSTR bstrManager);
    HRESULT get_TelephoneHome(VARIANT* retval);
    HRESULT put_TelephoneHome(VARIANT vTelephoneHome);
    HRESULT get_TelephoneMobile(VARIANT* retval);
    HRESULT put_TelephoneMobile(VARIANT vTelephoneMobile);
    HRESULT get_TelephoneNumber(VARIANT* retval);
    HRESULT put_TelephoneNumber(VARIANT vTelephoneNumber);
    HRESULT get_TelephonePager(VARIANT* retval);
    HRESULT put_TelephonePager(VARIANT vTelephonePager);
    HRESULT get_FaxNumber(VARIANT* retval);
    HRESULT put_FaxNumber(VARIANT vFaxNumber);
    HRESULT get_OfficeLocations(VARIANT* retval);
    HRESULT put_OfficeLocations(VARIANT vOfficeLocations);
    HRESULT get_PostalAddresses(VARIANT* retval);
    HRESULT put_PostalAddresses(VARIANT vPostalAddresses);
    HRESULT get_PostalCodes(VARIANT* retval);
    HRESULT put_PostalCodes(VARIANT vPostalCodes);
    HRESULT get_SeeAlso(VARIANT* retval);
    HRESULT put_SeeAlso(VARIANT vSeeAlso);
    HRESULT get_AccountDisabled(short* retval);
    HRESULT put_AccountDisabled(short fAccountDisabled);
    HRESULT get_AccountExpirationDate(double* retval);
    HRESULT put_AccountExpirationDate(double daAccountExpirationDate);
    HRESULT get_GraceLoginsAllowed(int* retval);
    HRESULT put_GraceLoginsAllowed(int lnGraceLoginsAllowed);
    HRESULT get_GraceLoginsRemaining(int* retval);
    HRESULT put_GraceLoginsRemaining(int lnGraceLoginsRemaining);
    HRESULT get_IsAccountLocked(short* retval);
    HRESULT put_IsAccountLocked(short fIsAccountLocked);
    HRESULT get_LoginHours(VARIANT* retval);
    HRESULT put_LoginHours(VARIANT vLoginHours);
    HRESULT get_LoginWorkstations(VARIANT* retval);
    HRESULT put_LoginWorkstations(VARIANT vLoginWorkstations);
    HRESULT get_MaxLogins(int* retval);
    HRESULT put_MaxLogins(int lnMaxLogins);
    HRESULT get_MaxStorage(int* retval);
    HRESULT put_MaxStorage(int lnMaxStorage);
    HRESULT get_PasswordExpirationDate(double* retval);
    HRESULT put_PasswordExpirationDate(double daPasswordExpirationDate);
    HRESULT get_PasswordMinimumLength(int* retval);
    HRESULT put_PasswordMinimumLength(int lnPasswordMinimumLength);
    HRESULT get_PasswordRequired(short* retval);
    HRESULT put_PasswordRequired(short fPasswordRequired);
    HRESULT get_RequireUniquePassword(short* retval);
    HRESULT put_RequireUniquePassword(short fRequireUniquePassword);
    HRESULT get_EmailAddress(BSTR* retval);
    HRESULT put_EmailAddress(BSTR bstrEmailAddress);
    HRESULT get_HomeDirectory(BSTR* retval);
    HRESULT put_HomeDirectory(BSTR bstrHomeDirectory);
    HRESULT get_Languages(VARIANT* retval);
    HRESULT put_Languages(VARIANT vLanguages);
    HRESULT get_Profile(BSTR* retval);
    HRESULT put_Profile(BSTR bstrProfile);
    HRESULT get_LoginScript(BSTR* retval);
    HRESULT put_LoginScript(BSTR bstrLoginScript);
    HRESULT get_Picture(VARIANT* retval);
    HRESULT put_Picture(VARIANT vPicture);
    HRESULT get_HomePage(BSTR* retval);
    HRESULT put_HomePage(BSTR bstrHomePage);
    ///The <b>IADsUser::Groups</b> method obtains a collection of the ADSI group objects to which this user belongs. The
    ///method returns an IADsMembers interface pointer through which you can enumerate all the groups in the collection.
    ///Params:
    ///    ppGroups = Pointer to a pointer to the IADsMembers interface on a members object that can be enumerated using
    ///               IEnumVARIANT to determine the groups to which this end-user belongs.
    ///Returns:
    ///    This method supports the standard return values, including S_OK. For other return values, see ADSI Error
    ///    Codes.
    ///    
    HRESULT Groups(IADsMembers* ppGroups);
    ///The <b>IADsUser::SetPassword</b> method sets the user password to a specified value. For the LDAP provider, the
    ///user account must have been created and stored in the underlying directory using IADs::SetInfo before
    ///<b>IADsUser::SetPassword</b> is called. The WinNT provider, however, enables you to set the password on a newly
    ///created user object prior to calling SetInfo. This ensures that you create passwords that comply with the system
    ///password policy before you create the user account.
    ///Params:
    ///    NewPassword = A <b>BSTR</b> that contains the new password.
    ///Returns:
    ///    This method supports the standard return values, including <b>S_OK</b>. For other return values, see ADSI
    ///    Error Codes.
    ///    
    HRESULT SetPassword(BSTR NewPassword);
    ///The <b>IADsUser::ChangePassword</b> method changes the user password from the specified old value to a new value.
    ///Params:
    ///    bstrOldPassword = A <b>BSTR</b> that contains the current password.
    ///    bstrNewPassword = A <b>BSTR</b> that contains the new password.
    ///Returns:
    ///    This method supports the standard return values, including S_OK. For more information and other return
    ///    values, see ADSI Error Codes.
    ///    
    HRESULT ChangePassword(BSTR bstrOldPassword, BSTR bstrNewPassword);
}

///The <b>IADsPrintQueue</b> interface represents a printer on a network. It is a dual interface that inherits from
///IADs. The property methods of this interface enables you to access data about a printer, for example printer model,
///physical location, and network address.
@GUID("B15160D0-1226-11CF-A985-00AA006BC149")
interface IADsPrintQueue : IADs
{
    HRESULT get_PrinterPath(BSTR* retval);
    HRESULT put_PrinterPath(BSTR bstrPrinterPath);
    HRESULT get_Model(BSTR* retval);
    HRESULT put_Model(BSTR bstrModel);
    HRESULT get_Datatype(BSTR* retval);
    HRESULT put_Datatype(BSTR bstrDatatype);
    HRESULT get_PrintProcessor(BSTR* retval);
    HRESULT put_PrintProcessor(BSTR bstrPrintProcessor);
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_Location(BSTR* retval);
    HRESULT put_Location(BSTR bstrLocation);
    HRESULT get_StartTime(double* retval);
    HRESULT put_StartTime(double daStartTime);
    HRESULT get_UntilTime(double* retval);
    HRESULT put_UntilTime(double daUntilTime);
    HRESULT get_DefaultJobPriority(int* retval);
    HRESULT put_DefaultJobPriority(int lnDefaultJobPriority);
    HRESULT get_Priority(int* retval);
    HRESULT put_Priority(int lnPriority);
    HRESULT get_BannerPage(BSTR* retval);
    HRESULT put_BannerPage(BSTR bstrBannerPage);
    HRESULT get_PrintDevices(VARIANT* retval);
    HRESULT put_PrintDevices(VARIANT vPrintDevices);
    HRESULT get_NetAddresses(VARIANT* retval);
    HRESULT put_NetAddresses(VARIANT vNetAddresses);
}

///The <b>IADsPrintQueueOperations</b> interface is a dual interface that inherits from IADs. It is used to control a
///printer from across a network. The <b>IADsPrintQueueOperations</b> interface supports the following operations: <ul>
///<li>Retrieve all print jobs submitted to the print queue.</li> <li>Suspend the print queue operation.</li> <li>Resume
///the print queue operation.</li> <li>Remove all print jobs from the print queue.</li> </ul>
@GUID("124BE5C0-156E-11CF-A986-00AA006BC149")
interface IADsPrintQueueOperations : IADs
{
    HRESULT get_Status(int* retval);
    ///The <b>IADsPrintQueueOperations::PrintJobs</b> method gets an IADsCollection interface pointer on the collection
    ///of the print jobs processed in this print queue. This collection can be enumerated using the standard Automation
    ///enumeration methods on IEnumVARIANT. To delete a print job, use the IADsCollection::Remove method on the
    ///retrieved interface pointer.
    ///Params:
    ///    pObject = Pointer to a pointer to the IADsCollection interface on the collection of objects added to this print queue.
    ///              Objects in the collection implement the IADsPrintJob interface.
    ///Returns:
    ///    This method supports the standard return values. For more information about other return values, see the ADSI
    ///    Error Codes.
    ///    
    HRESULT PrintJobs(IADsCollection* pObject);
    ///The <b>IADsPrintQueueOperations::Pause</b> method suspends the processing of print jobs within a print queue
    ///service.
    ///Returns:
    ///    This method supports the standard return values. For more information about other return values, see the ADSI
    ///    Error Codes.
    ///    
    HRESULT Pause();
    ///The <b>IADsPrintQueueOperations::Resume</b> method resumes processing of suspended print jobs in the print queue.
    ///Returns:
    ///    This method supports the standard return values. For more information about other return values, see the ADSI
    ///    Error Codes.
    ///    
    HRESULT Resume();
    ///The <b>IADsPrintQueueOperations::Purge</b> method clears the print queue of all print jobs without processing
    ///them.
    ///Returns:
    ///    This method supports the standard return values. For more information about other return values, see the ADSI
    ///    Error Codes.
    ///    
    HRESULT Purge();
}

///The <b>IADsPrintJob</b> interface is a dual interface that inherits from IADs. It is designed for representing a
///print job. When a user submits a request to a printer to print a document, a print job is created in the print queue.
///The property methods allow you to access the information about a print job. Such information includes which printer
///performs the printing, who submitted the document, when the document was submitted, and how many pages will be
///printed.
@GUID("32FB6780-1ED0-11CF-A988-00AA006BC149")
interface IADsPrintJob : IADs
{
    HRESULT get_HostPrintQueue(BSTR* retval);
    HRESULT get_User(BSTR* retval);
    HRESULT get_UserPath(BSTR* retval);
    HRESULT get_TimeSubmitted(double* retval);
    HRESULT get_TotalPages(int* retval);
    HRESULT get_Size(int* retval);
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_Priority(int* retval);
    HRESULT put_Priority(int lnPriority);
    HRESULT get_StartTime(double* retval);
    HRESULT put_StartTime(double daStartTime);
    HRESULT get_UntilTime(double* retval);
    HRESULT put_UntilTime(double daUntilTime);
    HRESULT get_Notify(BSTR* retval);
    HRESULT put_Notify(BSTR bstrNotify);
    HRESULT get_NotifyPath(BSTR* retval);
    HRESULT put_NotifyPath(BSTR bstrNotifyPath);
}

///The <b>IADsPrintJobOperations</b> interface is a dual interface that inherits from IADs. It is used to control a
///print job across a network. A print job object that implements the IADsPrintJob interface will also support the
///following features for this interface: <ul> <li>To examine the operational status and other information.</li> <li>To
///interrupt a running print job.</li> <li>To resume a paused print job.</li> </ul>
@GUID("9A52DB30-1ECF-11CF-A988-00AA006BC149")
interface IADsPrintJobOperations : IADs
{
    HRESULT get_Status(int* retval);
    HRESULT get_TimeElapsed(int* retval);
    HRESULT get_PagesPrinted(int* retval);
    HRESULT get_Position(int* retval);
    HRESULT put_Position(int lnPosition);
    ///The <b>IADsPrintJobOperations::Pause</b> method halts the processing of the current print job. Call the
    ///IADsPrintJobOperations::Resume method to continue the processing.
    ///Returns:
    ///    This method supports standard return values. For other return values, see ADSI Error Codes.
    ///    
    HRESULT Pause();
    ///The <b>IADsPrintJobOperations::Resume</b> method continues the print job halted by the
    ///IADsPrintJobOperations::Pause method.
    ///Returns:
    ///    This method supports the standard return values. For more information about other return values, see ADSI
    ///    Error Codes.
    ///    
    HRESULT Resume();
}

///The <b>IADsService</b> interface is a dual interface that inherits from IADs. It is designed to maintain data about
///system services running on a host computer. Examples of such services include "FAX" for Microsoft Fax Service,
///"RemoteAccess" for Routing and RemoteAccess Service, and "seclogon" for Secondary Logon Service. Examples of the data
///about any system service include the path to the executable file on the host computer, the type of the service, other
///services or load group required to run a particular service, and others. <b>IADsService</b> exposes several
///properties to represent such data.
@GUID("68AF66E0-31CA-11CF-A98A-00AA006BC149")
interface IADsService : IADs
{
    HRESULT get_HostComputer(BSTR* retval);
    HRESULT put_HostComputer(BSTR bstrHostComputer);
    HRESULT get_DisplayName(BSTR* retval);
    HRESULT put_DisplayName(BSTR bstrDisplayName);
    HRESULT get_Version(BSTR* retval);
    HRESULT put_Version(BSTR bstrVersion);
    HRESULT get_ServiceType(int* retval);
    HRESULT put_ServiceType(int lnServiceType);
    HRESULT get_StartType(int* retval);
    HRESULT put_StartType(int lnStartType);
    HRESULT get_Path(BSTR* retval);
    HRESULT put_Path(BSTR bstrPath);
    HRESULT get_StartupParameters(BSTR* retval);
    HRESULT put_StartupParameters(BSTR bstrStartupParameters);
    HRESULT get_ErrorControl(int* retval);
    HRESULT put_ErrorControl(int lnErrorControl);
    HRESULT get_LoadOrderGroup(BSTR* retval);
    HRESULT put_LoadOrderGroup(BSTR bstrLoadOrderGroup);
    HRESULT get_ServiceAccountName(BSTR* retval);
    HRESULT put_ServiceAccountName(BSTR bstrServiceAccountName);
    HRESULT get_ServiceAccountPath(BSTR* retval);
    HRESULT put_ServiceAccountPath(BSTR bstrServiceAccountPath);
    HRESULT get_Dependencies(VARIANT* retval);
    HRESULT put_Dependencies(VARIANT vDependencies);
}

///The <b>IADsServiceOperations</b> interface is a dual interface that inherits from IADs. It is designed to manage
///system services installed on a computer. You can use this interface to start, pause, and stop a system service,
///change the password, and examine the status of a given service across a network. Of the system services and their
///operations, file service and file service operations are a special case. They are represented and managed by
///IADsFileService and IADsFileServiceOperations.
@GUID("5D7B33F0-31CA-11CF-A98A-00AA006BC149")
interface IADsServiceOperations : IADs
{
    HRESULT get_Status(int* retval);
    ///The <b>IADsServiceOperations::Start</b> method starts a network service.
    ///Returns:
    ///    This method supports the standard return values, including S_OK. For more information about other return
    ///    values, see ADSI Error Codes.
    ///    
    HRESULT Start();
    ///The <b>IADsServiceOperations::Stop</b> method stops a currently active network service.
    ///Returns:
    ///    This method supports standard return values, including S_OK. For more information about other return values,
    ///    see ADSI Error Codes.
    ///    
    HRESULT Stop();
    ///The <b>IADsServiceOperations::Pause</b> method pauses a service started with the IADsServiceOperations::Start
    ///method.
    ///Returns:
    ///    This method supports the standard return values, including S_OK. For more information about other return
    ///    values, see ADSI Error Codes.
    ///    
    HRESULT Pause();
    ///The <b>IADsServiceOperations::Continue</b> method resumes a service operation paused by the
    ///IADsServiceOperations::Pause method.
    ///Returns:
    ///    This method supports the standard return values, including S_OK. For more information about other return
    ///    values, see ADSI Error Codes.
    ///    
    HRESULT Continue();
    ///The <b>IADsServiceOperations::SetPassword</b> method sets the password for the account used by the service
    ///manager. This method is called when the security context for this service is created.
    ///Params:
    ///    bstrNewPassword = The null-terminated Unicode string to be stored as the new password.
    ///Returns:
    ///    This method supports the standard return values, including S_OK. For more information about other return
    ///    values, see ADSI Error Codes.
    ///    
    HRESULT SetPassword(BSTR bstrNewPassword);
}

///The <b>IADsFileService</b> interface is a dual interface that inherits from IADsService. It is designed for
///representing file services supported in the directory service. Through this interface you can discover and modify the
///maximum number of users simultaneously running a file service. To access active sessions or open resources used by
///the file service, you must go through the IADsFileServiceOperations interface to retrieve sessions or resources. To
///examine the status of the file service or to perform service management operations, you use the IADsServiceOperations
///interface, which is inherited by IADsFileServiceOperations.
@GUID("A89D1900-31CA-11CF-A98A-00AA006BC149")
interface IADsFileService : IADsService
{
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_MaxUserCount(int* retval);
    HRESULT put_MaxUserCount(int lnMaxUserCount);
}

///The <b>IADsFileServiceOperations</b> interface is a dual interface that inherits from IADsServiceOperations. It
///extends the functionality, as exposed in the <b>IADsServiceOperations</b> interface, for managing the file service
///across a network. Specifically, it serves to maintain and manage open resources and active sessions of the file
///service.
@GUID("A02DED10-31CA-11CF-A98A-00AA006BC149")
interface IADsFileServiceOperations : IADsServiceOperations
{
    ///The <b>IADsFileServiceOperations::Sessions</b> method gets a pointer to a pointer to the IADsCollection interface
    ///on a collection of the session objects that represent the current open sessions for this file service.
    ///Params:
    ///    ppSessions = Pointer to a pointer to the IADsCollection interface used to enumerate objects that implement the IADsSession
    ///                 interface and represent the current open sessions for this file service.
    ///Returns:
    ///    This method supports the standard return values including S_OK. For more information and other return values,
    ///    see ADSI Error Codes.
    ///    
    HRESULT Sessions(IADsCollection* ppSessions);
    ///The <b>IADsFileServiceOperations::Resources</b> method gets a pointer to a pointer to the IADsCollection
    ///interface on a collection of the resource objects representing the current open resources on this file service.
    ///Params:
    ///    ppResources = Pointer to a pointer to the IADsCollection interface that can then be used to enumerate objects implementing
    ///                  the IADsResource interface and representing the current open resources for this file service.
    ///Returns:
    ///    This method supports the standard return values including S_OK. For more information and other return values,
    ///    see ADSI Error Codes.
    ///    
    HRESULT Resources(IADsCollection* ppResources);
}

///The <b>IADsFileShare</b> interface is a dual interface that inherits from IADs. It is designed for representing a
///published file share across the network. Call the methods on <b>IADsFileShare</b> to access or publish data about a
///file share point.
@GUID("EB6DCAF0-4B83-11CF-A995-00AA006BC149")
interface IADsFileShare : IADs
{
    HRESULT get_CurrentUserCount(int* retval);
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_HostComputer(BSTR* retval);
    HRESULT put_HostComputer(BSTR bstrHostComputer);
    HRESULT get_Path(BSTR* retval);
    HRESULT put_Path(BSTR bstrPath);
    HRESULT get_MaxUserCount(int* retval);
    HRESULT put_MaxUserCount(int lnMaxUserCount);
}

///The <b>IADsSession</b> interface is a dual interface that inherits from IADs. It is designed to represent an active
///session for file service across a network.
@GUID("398B7DA0-4AAB-11CF-AE2C-00AA006EBFB9")
interface IADsSession : IADs
{
    HRESULT get_User(BSTR* retval);
    HRESULT get_UserPath(BSTR* retval);
    HRESULT get_Computer(BSTR* retval);
    HRESULT get_ComputerPath(BSTR* retval);
    HRESULT get_ConnectTime(int* retval);
    HRESULT get_IdleTime(int* retval);
}

///The <b>IADsResource</b> interface is a dual interface that inherits from IADs. It is designed to manage an open
///resource for a file service across a network.
@GUID("34A05B20-4AAB-11CF-AE2C-00AA006EBFB9")
interface IADsResource : IADs
{
    HRESULT get_User(BSTR* retval);
    HRESULT get_UserPath(BSTR* retval);
    HRESULT get_Path(BSTR* retval);
    HRESULT get_LockCount(int* retval);
}

///The <b>IADsOpenDSObject</b> interface is designed to supply a security context for binding to an object in the
///underlying directory store. It provides a means for specifying credentials of a client. Use this interface to bind to
///an ADSI object when you must supply a set of credentials for authentication in any directory service. ADSI maintains
///the security context in its cache. Thus, throughout the connection within a process, Once authenticated, the supplied
///user credentials are applied to any actions performed on this object and its children. This credential caching model
///applies to binding to different objects as well, provided that the binding takes place within the same connection and
///process. Calling the OpenDSObject method of this interface yields the cache handle. Releasing this cache handle
///releases the security context as well.
@GUID("DDF2891E-0F9C-11D0-8AD4-00C04FD8D503")
interface IADsOpenDSObject : IDispatch
{
    ///The <b>IADsOpenDSObject::OpenDSObject</b> method binds to an ADSI object, using the given credentials, and
    ///retrieves an IDispatch pointer to the specified object. <div class="alert"><b>Important</b> It is not recommended
    ///that you use this method with the WinNT Provider. For more information, please see KB article 218497, User
    ///Authentication Issues with the Active Directory Service Interfaces WinNT Provider.</div><div> </div>
    ///Params:
    ///    lpszDNName = The null-terminated Unicode string that specifies the ADsPath of the ADSI object. For more information and
    ///                 examples of binding strings for this parameter, see LDAP ADsPath. When using the LDAP provider with an
    ///                 ADsPath that includes a specific server name, the <i>lnReserved</i> parameter should include the
    ///                 <b>ADS_SERVER_BIND</b> flag.
    ///    lpszUserName = The null-terminated Unicode string that specifies the user name to be used for securing permission from the
    ///                   namespace server. For more information, see the following Remarks section.
    ///    lpszPassword = The null-terminated Unicode string that specifies the password to be used to obtain permission from the
    ///                   namespace server.
    ///    lnReserved = Authentication flags used to define the binding options. For more information, see ADS_AUTHENTICATION_ENUM.
    ///    ppOleDsObj = Pointer to a pointer to an IDispatch interface on the requested object.
    ///Returns:
    ///    This method supports the standard return values, including <b>S_OK</b> when the IDispatch interface has been
    ///    successfully retrieved using these credentials. For more information, see ADSI Error Codes.
    ///    
    HRESULT OpenDSObject(BSTR lpszDNName, BSTR lpszUserName, BSTR lpszPassword, int lnReserved, 
                         IDispatch* ppOleDsObj);
}

///The <b>IDirectoryObject</b> interface is a non-Automation COM interface that provides clients with direct access to
///directory service objects. The interface enables access by means of a direct over-the-wire protocol, rather than
///through the ADSI attribute cache. Using the over-the-wire protocol optimizes performance. With
///<b>IDirectoryObject</b>, a client can get, or set, any number of object attributes with one method call. Unlike the
///corresponding Automation methods, which are invoked in batch, those of <b>IDirectoryObject</b> are executed when they
///are called. <b>IDirectoryObject</b> performs no attribute caching. Non-Automation clients can call the methods of
///<b>IDirectoryObject</b> to optimize performance and take advantage of native directory service interfaces. Automation
///clients cannot use <b>IDirectoryObject</b>. Instead, they should use the IADs interface. Of the ADSI system-supplied
///providers, only the LDAP provider supports this interface.
@GUID("E798DE2C-22E4-11D0-84FE-00C04FD8D503")
interface IDirectoryObject : IUnknown
{
    ///The <b>IDirectoryObject::GetObjectInformation</b> method retrieves a pointer to an ADS_OBJECT_INFO structure that
    ///contains data regarding the identity and location of a directory service object.
    ///Params:
    ///    ppObjInfo = Provides the address of a pointer to an ADS_OBJECT_INFO structure that contains data regarding the requested
    ///                directory service object. If <i>ppObjInfo</i> is <b>NULL</b> on return, <b>GetObjectInformation</b> cannot
    ///                obtain the requested data.
    ///Returns:
    ///    This method returns the standard return values, including <b>S_OK</b> when the data is obtained successfully.
    ///    For more information and other return values, see ADSI Error Codes.
    ///    
    HRESULT GetObjectInformation(ADS_OBJECT_INFO** ppObjInfo);
    ///The <b>IDirectoryObject::GetObjectAttributes</b> method retrieves one or more specified attributes of the
    ///directory service object.
    ///Params:
    ///    pAttributeNames = Specifies an array of names of the requested attributes. To request all of the object's attributes, set
    ///                      <i>pAttributeNames</i> to <b>NULL</b> and set the <i>dwNumberAttributes</i> parameter to (DWORD)-1.
    ///    dwNumberAttributes = Specifies the size of the <i>pAttributeNames</i> array. If -1, all of the object's attributes are requested.
    ///    ppAttributeEntries = Pointer to a variable that receives a pointer to an array of ADS_ATTR_INFO structures that contain the
    ///                         requested attribute values. If no attributes could be obtained from the directory service object, the
    ///                         returned pointer is <b>NULL</b>.
    ///    pdwNumAttributesReturned = Pointer to a <b>DWORD</b> variable that receives the number of attributes retrieved in the
    ///                               <i>ppAttributeEntries</i> array.
    ///Returns:
    ///    This method returns the standard values, as well as the following: For more information and other return
    ///    values, see ADSI Error Codes.
    ///    
    HRESULT GetObjectAttributes(PWSTR* pAttributeNames, uint dwNumberAttributes, 
                                ADS_ATTR_INFO** ppAttributeEntries, uint* pdwNumAttributesReturned);
    ///The <b>IDirectoryObject::SetObjectAttributes</b> method modifies data in one or more specified object attributes
    ///defined in the ADS_ATTR_INFO structure.
    ///Params:
    ///    pAttributeEntries = Provides an array of attributes to be modified. Each attribute contains the name of the attribute, the
    ///                        operation to perform, and the attribute value, if applicable. For more information, see the ADS_ATTR_INFO
    ///                        structure.
    ///    dwNumAttributes = Provides the number of attributes to be modified. This value should correspond to the size of the
    ///                      <i>pAttributeEntries</i> array.
    ///    pdwNumAttributesModified = Provides a pointer to a <b>DWORD</b> variable that contains the number of attributes modified by the
    ///                               <b>SetObjectAttributes</b> method.
    ///Returns:
    ///    This method returns the standard return values, including S_OK when the attributes are set successfully. For
    ///    more information and other return values, see ADSI Error Codes.
    ///    
    HRESULT SetObjectAttributes(ADS_ATTR_INFO* pAttributeEntries, uint dwNumAttributes, 
                                uint* pdwNumAttributesModified);
    ///The <b>IDirectoryObject::CreateDSObject</b> method creates a child of the current directory service object.
    ///Params:
    ///    pszRDNName = Provides the relative distinguished name (relative path) of the object to be created.
    ///    pAttributeEntries = An array of ADS_ATTR_INFO structures that contain attribute definitions to be set when the object is created.
    ///    dwNumAttributes = Provides a number of attributes set when the object is created.
    ///    ppObject = Provides a pointer to the IDispatch interface on the created object.
    ///Returns:
    ///    This method returns the standard return values, including S_OK for a successful operation. For more
    ///    information and other return values, see ADSI Error Codes.
    ///    
    HRESULT CreateDSObject(PWSTR pszRDNName, ADS_ATTR_INFO* pAttributeEntries, uint dwNumAttributes, 
                           IDispatch* ppObject);
    ///The <b>IDirectoryObject::DeleteDSObject</b> method deletes a leaf object in a directory tree.
    ///Params:
    ///    pszRDNName = The relative distinguished name (relative path) of the object to be deleted.
    ///Returns:
    ///    This method returns the standard return values, including S_OK for a successful operation. For more
    ///    information and other return values, see ADSI Error Codes.
    ///    
    HRESULT DeleteDSObject(PWSTR pszRDNName);
}

///The <b>IDirectorySearch</b> interface is a pure COM interface that provides a low overhead method that non-Automation
///clients can use to perform queries in the underlying directory. Of the ADSI system-supplied providers, only the LDAP
///provider supports this interface.
@GUID("109BA8EC-92F0-11D0-A790-00C04FD8D5A8")
interface IDirectorySearch : IUnknown
{
    ///The <b>IDirectorySearch::SetSearchPreference</b> method specifies a search preference for obtaining data in a
    ///subsequent search.
    ///Params:
    ///    pSearchPrefs = Provides a caller-allocated array of ADS_SEARCHPREF_INFO structures that contain the search preferences to be
    ///                   set.
    ///    dwNumPrefs = Provides the size of the <i>pSearchPrefs</i> array.
    ///Returns:
    ///    This method supports the standard return values, as well as the following: For more information and other
    ///    return values, see ADSI Error Codes.
    ///    
    HRESULT SetSearchPreference(ads_searchpref_info* pSearchPrefs, uint dwNumPrefs);
    ///The <b>IDirectorySearch::ExecuteSearch</b> method executes a search and passes the results to the caller. Some
    ///providers, such as LDAP, will defer the actual execution until the caller invokes the
    ///IDirectorySearch::GetFirstRow method or the IDirectorySearch::GetNextRow method.
    ///Params:
    ///    pszSearchFilter = A search filter string in LDAP format, such as "(objectClass=user)".
    ///    pAttributeNames = An array of attribute names for which data is requested. If <b>NULL</b>, <i>dwNumberAttributes</i> must be 0
    ///                      or 0xFFFFFFFF.
    ///    dwNumberAttributes = The size of the <i>pAttributeNames</i> array. The special value 0xFFFFFFFF indicates that
    ///                         <i>pAttributeNames</i> is ignored and can be <b>NULL</b>. This special value means that all attributes that
    ///                         are set are requested. If this value is 0 the <i>pAttributeNames</i> array can be <b>NULL</b>. No attribute
    ///                         will be requested.
    ///    phSearchResult = The address of a method-allocated handle to the search context. The caller passes this handle to other
    ///                     methods of IDirectorySearch to examine the search result. If <b>NULL</b>, the search cannot be executed.
    ///Returns:
    ///    This method returns the standard return values, as well as the following: For more information and other
    ///    return values, see ADSI Error Codes.
    ///    
    HRESULT ExecuteSearch(PWSTR pszSearchFilter, PWSTR* pAttributeNames, uint dwNumberAttributes, 
                          ptrdiff_t* phSearchResult);
    ///The <b>IDirectorySearch::AbandonSearch</b> method abandons a search initiated by an earlier call to the
    ///ExecuteSearch method.
    ///Params:
    ///    phSearchResult = Provides a handle to the search context.
    ///Returns:
    ///    This method returns the standard return values, including S_OK if the first row is obtained successfully. For
    ///    other return values, see ADSI Error Codes.
    ///    
    HRESULT AbandonSearch(ptrdiff_t phSearchResult);
    ///The <b>GetFirstRow</b> method gets the first row of a search result. This method will issue or reissue a new
    ///search, even if this method has been called before.
    ///Params:
    ///    hSearchResult = Contains the search handle obtained by calling IDirectorySearch::ExecuteSearch.
    ///Returns:
    ///    This method returns the standard return values, as well as the following: For more information, see ADSI
    ///    Error Codes.
    ///    
    HRESULT GetFirstRow(ptrdiff_t hSearchResult);
    ///The <b>GetNextRow</b> method gets the next row of the search result. If IDirectorySearch::GetFirstRow has not
    ///been called, <b>GetNextRow</b> will issue a new search beginning from the first row. Otherwise, this method will
    ///advance to the next row.
    ///Params:
    ///    hSearchResult = Contains the search handle obtained by calling IDirectorySearch::ExecuteSearch.
    ///Returns:
    ///    This method returns the standard return values, as well as the following: For more information, see ADSI
    ///    Error Codes.
    ///    
    HRESULT GetNextRow(ptrdiff_t hSearchResult);
    ///The <b>IDirectorySearch::GetPreviousRow</b> method gets the previous row of the search result. If the provider
    ///does not provide cursor support, it should return <b>E_NOTIMPL</b>.
    ///Params:
    ///    hSearchResult = Provides a handle to the search context.
    ///Returns:
    ///    This method returns the standard return values, as well as the following: For other return values, see ADSI
    ///    Error Codes.
    ///    
    HRESULT GetPreviousRow(ptrdiff_t hSearchResult);
    ///The <b>IDirectorySearch::GetNextColumnName</b> method gets the name of the next column in the search result that
    ///contains data.
    ///Params:
    ///    hSearchHandle = Provides a handle to the search context.
    ///    ppszColumnName = Provides the address of a pointer to a method-allocated string containing the requested column name. If
    ///                     <b>NULL</b>, no subsequent rows contain data.
    ///Returns:
    ///    This method returns the standard return values, as well as the following: For other return values, see ADSI
    ///    Error Codes.
    ///    
    HRESULT GetNextColumnName(ptrdiff_t hSearchHandle, PWSTR* ppszColumnName);
    ///The <b>IDirectorySearch::GetColumn</b> method gets data from a named column of the search result.
    ///Params:
    ///    hSearchResult = Provides a handle to the search context.
    ///    szColumnName = Provides the name of the column for which data is requested.
    ///    pSearchColumn = Provides the address of a method-allocated ADS_SEARCH_COLUMN structure that contains the column from the
    ///                    current row of the search result.
    ///Returns:
    ///    This method returns the standard return values, as well as the following. For other return values, see ADSI
    ///    Error Codes.
    ///    
    HRESULT GetColumn(ptrdiff_t hSearchResult, PWSTR szColumnName, ads_search_column* pSearchColumn);
    ///The <b>IDirectorySearch::FreeColumn</b> method releases memory that the IDirectorySearch::GetColumn method
    ///allocated for data for the column.
    ///Params:
    ///    pSearchColumn = Provides a pointer to the column to be freed.
    ///Returns:
    ///    This method returns the standard return values, as well as the following: For other return values, see ADSI
    ///    Error Codes.
    ///    
    HRESULT FreeColumn(ads_search_column* pSearchColumn);
    ///The <b>IDirectorySearch::CloseSearchHandle</b> method closes the handle to a search result and frees the
    ///associated memory.
    ///Params:
    ///    hSearchResult = Provides a handle to the search result to be closed.
    ///Returns:
    ///    This method returns the standard return values, as well as the following: For other return values, see ADSI
    ///    Error Codes.
    ///    
    HRESULT CloseSearchHandle(ptrdiff_t hSearchResult);
}

///The <b>IDirectorySchemaMgmt</b> interface is not currently implemented and should not be used.
@GUID("75DB3B9C-A4D8-11D0-A79C-00C04FD8D5A8")
interface IDirectorySchemaMgmt : IUnknown
{
    HRESULT EnumAttributes(PWSTR* ppszAttrNames, uint dwNumAttributes, ADS_ATTR_DEF** ppAttrDefinition, 
                           uint* pdwNumAttributes);
    HRESULT CreateAttributeDefinition(PWSTR pszAttributeName, ADS_ATTR_DEF* pAttributeDefinition);
    HRESULT WriteAttributeDefinition(PWSTR pszAttributeName, ADS_ATTR_DEF* pAttributeDefinition);
    HRESULT DeleteAttributeDefinition(PWSTR pszAttributeName);
    HRESULT EnumClasses(PWSTR* ppszClassNames, uint dwNumClasses, ADS_CLASS_DEF** ppClassDefinition, 
                        uint* pdwNumClasses);
    HRESULT WriteClassDefinition(PWSTR pszClassName, ADS_CLASS_DEF* pClassDefinition);
    HRESULT CreateClassDefinition(PWSTR pszClassName, ADS_CLASS_DEF* pClassDefinition);
    HRESULT DeleteClassDefinition(PWSTR pszClassName);
}

@GUID("1346CE8C-9039-11D0-8528-00C04FD8D503")
interface IADsAggregatee : IUnknown
{
    HRESULT ConnectAsAggregatee(IUnknown pOuterUnknown);
    HRESULT DisconnectAsAggregatee();
    HRESULT RelinquishInterface(const(GUID)* riid);
    HRESULT RestoreInterface(const(GUID)* riid);
}

@GUID("52DB5FB0-941F-11D0-8529-00C04FD8D503")
interface IADsAggregator : IUnknown
{
    HRESULT ConnectAsAggregator(IUnknown pAggregatee);
    HRESULT DisconnectAsAggregator();
}

///The <b>IADsAccessControlEntry</b> interface is a dual interface that enables directory clients to access and
///manipulate individual access-control entries (ACEs) of the owning object. An ACE stipulates who can access the object
///and what type of access granted and specifies whether the access control settings can be propagated from the object
///to any of its children. An ACE exposes a set of properties through this interface to provide such services. An object
///can have a number of ACEs, one for each client or a group of clients. ACEs are maintained in an access-control list
///(ACL) which implements the IADsAccessControlList interface. That is, a client must use an ACL to access an ACE. To
///access the ACL, retrieve the security descriptor of the object that implements the IADsSecurityDescriptor interface.
///The following procedures describe how to manage access controls over an ADSI object. Some of the
///<b>IADsAccessControlEntry</b> property values, such as AccessMask and <b>AceFlags</b>, will be different for
///different object types. For example, an Active Directory object will use the <b>ADS_RIGHT_GENERIC_READ</b> member of
///the ADS_RIGHTS_ENUM enumeration for the <b>IADsAccessControlEntry.AccessMask</b> property, but the equivalent access
///right for a file object is <b>FILE_GENERIC_READ</b>. It is not safe to assume that all property values will be the
///same for Active Directory objects and non-Active Directory objects. For more information, see Security Descriptors on
///Files and Registry Keys. <p class="proch"><b>To managing access controls over an ADSI object</b> <ol> <li>Retrieve
///the security descriptor for the object that implements the IADsSecurityDescriptor interface.</li> <li>Retrieve the
///ACL from the security descriptor.</li> <li>Work with the ACE, or ACEs, of the object in the ACL.</li> </ol><p
///class="proch"><b>To set a new or modified ACE as persistent</b> <ol> <li>Add the ACE to the ACL.</li> <li>Assign the
///ACL to the security descriptor.</li> <li>Commit the security descriptor to the directory store.</li> </ol>
@GUID("B4F3A14C-9BDD-11D0-852C-00C04FD8D503")
interface IADsAccessControlEntry : IDispatch
{
    HRESULT get_AccessMask(int* retval);
    HRESULT put_AccessMask(int lnAccessMask);
    HRESULT get_AceType(int* retval);
    HRESULT put_AceType(int lnAceType);
    HRESULT get_AceFlags(int* retval);
    HRESULT put_AceFlags(int lnAceFlags);
    HRESULT get_Flags(int* retval);
    HRESULT put_Flags(int lnFlags);
    HRESULT get_ObjectType(BSTR* retval);
    HRESULT put_ObjectType(BSTR bstrObjectType);
    HRESULT get_InheritedObjectType(BSTR* retval);
    HRESULT put_InheritedObjectType(BSTR bstrInheritedObjectType);
    HRESULT get_Trustee(BSTR* retval);
    HRESULT put_Trustee(BSTR bstrTrustee);
}

///The <b>IADsAccessControlList</b> interface is a dual interface that manages individual access-control entries (ACEs).
@GUID("B7EE91CC-9BDD-11D0-852C-00C04FD8D503")
interface IADsAccessControlList : IDispatch
{
    HRESULT get_AclRevision(int* retval);
    HRESULT put_AclRevision(int lnAclRevision);
    HRESULT get_AceCount(int* retval);
    HRESULT put_AceCount(int lnAceCount);
    ///The <b>IADsAccessControlList::AddAce</b> method adds an IADsAccessControlEntry object to the
    ///IADsAccessControlList object.
    ///Params:
    ///    pAccessControlEntry = Pointer to the IDispatch interface of the IADsAccessControlEntry object to be added. This parameter cannot be
    ///                          <b>NULL</b>.
    ///Returns:
    ///    Returns a standard <b>HRESULT</b> value including the following.
    ///    
    HRESULT AddAce(IDispatch pAccessControlEntry);
    ///The <b>IADsAccessControlList::RemoveAce</b> method removes an access-control entry (ACE) from the access-control
    ///list (ACL).
    ///Params:
    ///    pAccessControlEntry = Pointer to the <b>IDispatch</b> interface of the ACE to be removed from the ACL.
    ///Returns:
    ///    This method returns standard return values. For more information, see ADSI Error Codes.
    ///    
    HRESULT RemoveAce(IDispatch pAccessControlEntry);
    ///The <b>IADsAccessControlList::CopyAccessList</b> method copies every access control entry (ACE) in the
    ///access-control list (ACL) to the caller's process space.
    ///Params:
    ///    ppAccessControlList = Address of an IDispatch interface pointer to an ACL as the copy of the original access list. If this
    ///                          parameter is <b>NULL</b> on return, no copies of the ACL could be made.
    ///Returns:
    ///    This method returns the standard return values. For more information about other return values, see ADSI
    ///    Error Codes.
    ///    
    HRESULT CopyAccessList(IDispatch* ppAccessControlList);
    ///The <b>IADsAccessControlList::get__NewEnum</b> method is used to obtain an enumerator object for the ACL to
    ///enumerate ACEs.
    ///Params:
    ///    retval = Pointer to pointer to the IUnknown interface used to retrieve IEnumVARIANT interface on an enumerator object
    ///             for the ACL.
    ///Returns:
    ///    This method returns the standard return values, including <b>S_OK</b> and <b>E_FAIL</b>. For more information
    ///    about other return values, see ADSI Error Codes.
    ///    
    HRESULT get__NewEnum(IUnknown* retval);
}

///The <b>IADsSecurityDescriptor</b> interface provides access to properties on an ADSI security descriptor object.
@GUID("B8C787CA-9BDD-11D0-852C-00C04FD8D503")
interface IADsSecurityDescriptor : IDispatch
{
    HRESULT get_Revision(int* retval);
    HRESULT put_Revision(int lnRevision);
    HRESULT get_Control(int* retval);
    HRESULT put_Control(int lnControl);
    HRESULT get_Owner(BSTR* retval);
    HRESULT put_Owner(BSTR bstrOwner);
    HRESULT get_OwnerDefaulted(short* retval);
    HRESULT put_OwnerDefaulted(short fOwnerDefaulted);
    HRESULT get_Group(BSTR* retval);
    HRESULT put_Group(BSTR bstrGroup);
    HRESULT get_GroupDefaulted(short* retval);
    HRESULT put_GroupDefaulted(short fGroupDefaulted);
    HRESULT get_DiscretionaryAcl(IDispatch* retval);
    HRESULT put_DiscretionaryAcl(IDispatch pDiscretionaryAcl);
    HRESULT get_DaclDefaulted(short* retval);
    HRESULT put_DaclDefaulted(short fDaclDefaulted);
    HRESULT get_SystemAcl(IDispatch* retval);
    HRESULT put_SystemAcl(IDispatch pSystemAcl);
    HRESULT get_SaclDefaulted(short* retval);
    HRESULT put_SaclDefaulted(short fSaclDefaulted);
    ///The <b>IADsSecurityDescriptor::CopySecurityDescriptor</b> method copies an ADSI security descriptor object that
    ///holds security data about an object.
    ///Params:
    ///    ppSecurityDescriptor = Pointer to a pointer to a security descriptor object.
    ///Returns:
    ///    This method returns the standard return values, including <b>E_INVALIDARG</b>, <b>E_OUTOFMEMORY</b>,
    ///    <b>E_UNEXPECTED</b>, and <b>E_FAIL</b>, as well as <b>S_OK</b>. For more information about other return
    ///    values, see ADSI Error Codes.
    ///    
    HRESULT CopySecurityDescriptor(IDispatch* ppSecurityDescriptor);
}

///The <b>IADsLargeInteger</b> interface is used to manipulate 64-bit integers of the <b>LargeInteger</b> type.
@GUID("9068270B-0939-11D1-8BE1-00C04FD8D503")
interface IADsLargeInteger : IDispatch
{
    HRESULT get_HighPart(int* retval);
    HRESULT put_HighPart(int lnHighPart);
    HRESULT get_LowPart(int* retval);
    HRESULT put_LowPart(int lnLowPart);
}

///The <b>IADsNameTranslate</b>interface translates distinguished names (DNs) among various formats as defined in the
///ADS_NAME_TYPE_ENUM enumeration. The feature is available to objects in Active Directory. Name translations are
///performed on the directory server. To translate a DN, communicate with the server by means of an
///<b>IADsNameTranslate</b> object, and specify which object is of interest and what format is desired. The following is
///the general process for using the <b>IADsNameTranslate</b> interface. First, create an instance of the
///<b>IADsNameTranslate</b> object. Second, initialize the <b>IADsNameTranslate</b>object by specifying the directory
///server using the IADsNameTranslate::Initor IADsNameTranslate::InitEx methods. Third, set the directory object on the
///server by specifying the name with the IADsNameTranslate::Set method and the format with the IADsNameTranslate::SetEx
///method. Fourth, retrieve the object name in the specified format with the IADsNameTranslate::Getor
///IADsNameTranslate::GetEx method. The following code example shows how to create an <b>IADsNameTranslate</b> object in
///Visual C++, Visual Basic, and VBScript/Active Server Pages. <div class="alert"><b>Note</b> The format elements as
///defined in the ADS_NAME_TYPE_ENUM enumeration and used by <b>IADsNameTranslate</b> are not equivalent and are
///non-interchangeable with the format elements used by the DsCrackName function. Do not confuse the proper use of these
///similarly named but non-interchangeable element formats.</div><div> </div>
@GUID("B1B272A3-3625-11D1-A3A4-00C04FB950DC")
interface IADsNameTranslate : IDispatch
{
    HRESULT put_ChaseReferral(int lnChaseReferral);
    ///The <b>IADsNameTranslate::Init</b> method initializes a name translate object by binding to a specified directory
    ///server, domain, or global catalog, using the credentials of the current user. To initialize the object with a
    ///different user credential, use IADsNameTranslate::InitEx.
    ///Params:
    ///    lnSetType = A type of initialization to be performed. Possible values are defined in ADS_NAME_INITTYPE_ENUM.
    ///    bstrADsPath = The name of the server or domain, depending on the value of <i>lnInitType</i>. When
    ///                  <b>ADS_NAME_INITTYPE_GC</b> is issued, this parameter is ignored. The global catalog server of the domain of
    ///                  the current computer will perform the name translate operations. This method will fail if the computer is not
    ///                  part of a domain as no global catalog will be found in this scenario. For more information, see
    ///                  ADS_NAME_INITTYPE_ENUM.
    ///Returns:
    ///    Returns a standard <b>HRESULT</b> or RPC error code, including:
    ///    
    HRESULT Init(int lnSetType, BSTR bstrADsPath);
    ///The <b>IADsNameTranslate::InitEx</b> method initializes a name translate object by binding to a specified
    ///directory server, domain, or global catalog, using the specified user credential. To initialize the object
    ///without an explicit user credential, use IADsNameTranslate::Init. The <b>IADsNameTranslate::InitEx</b> method
    ///initializes the object by setting the server or domain that the object will point to and supplying a user
    ///credential.
    ///Params:
    ///    lnSetType = A type of initialization to be performed. Possible values are defined in ADS_NAME_INITTYPE_ENUM.
    ///    bstrADsPath = The name of the server or domain, depending on the value of <i>lnInitType</i>. When
    ///                  <b>ADS_NAME_INITTYPE_GC</b> is issued, this parameter is ignored. The global catalog server of the domain of
    ///                  the current machine will be used to carry out the name translate operations. This method will fail if the
    ///                  computer is not part of a domain, as no global catalog will be found in this scenario. For more information,
    ///                  see ADS_NAME_INITTYPE_ENUM.
    ///    bstrUserID = User name.
    ///    bstrDomain = User domain name.
    ///    bstrPassword = User password.
    ///Returns:
    ///    Returns a standard <b>HRESULT</b> or RPC error code, including:
    ///    
    HRESULT InitEx(int lnSetType, BSTR bstrADsPath, BSTR bstrUserID, BSTR bstrDomain, BSTR bstrPassword);
    ///The <b>IADsNameTranslate::Set</b> method directs the directory service to set up a specified object for name
    ///translation. To set the names and format of multiple objects, use IADsnametranslate::SetEx.
    ///Params:
    ///    lnSetType = The format of the name of a directory object. For more information, see ADS_NAME_TYPE_ENUM.
    ///    bstrADsPath = The object name, for example, "CN=Administrator, CN=users, DC=Fabrikam, DC=com".
    ///Returns:
    ///    This method supports the standard <b>HRESULT</b> return values, including:
    ///    
    HRESULT Set(int lnSetType, BSTR bstrADsPath);
    ///The <b>IADsNameTranslate::Get</b> method retrieves the name of a directory object in the specified format. The
    ///distinguished name must have been set in the appropriate format by the IADsNameTranslate::Set method.
    ///Params:
    ///    lnFormatType = The format type of the output name. For more information, see ADS_NAME_TYPE_ENUM. This method does not
    ///                   support the <b>ADS_NAME_TYPE_SID_OR_SID_HISTORY_NAME</b> element in <b>ADS_NAME_TYPE_ENUM</b>.
    ///    pbstrADsPath = The name of the returned object.
    ///Returns:
    ///    This method supports the standard <b>HRESULT</b> return values, including:
    ///    
    HRESULT Get(int lnFormatType, BSTR* pbstrADsPath);
    ///The <b>IADsNameTranslate::SetEx</b> method establishes an array of objects for name translation. The specified
    ///objects must exist in the connected directory server. To set the name and format of a single directory object,
    ///use the IADsNameTranslate::Set method.
    ///Params:
    ///    lnFormatType = The format type of the input names. For more information, see ADS_NAME_TYPE_ENUM.
    ///    pvar = A variant array of strings that hold object names.
    ///Returns:
    ///    This method supports the standard <b>HRESULT</b> return values, including:
    ///    
    HRESULT SetEx(int lnFormatType, VARIANT pvar);
    ///The <b>IADsNameTranslate::GetEx</b> method gets the object names in the specified format. The object names must
    ///be set by IADsNameTranslate::SetEx.
    ///Params:
    ///    lnFormatType = The format type used for the output names. For more information about the various types of formats you can
    ///                   use, see ADS_NAME_TYPE_ENUM. This method does not support the ADS_NAME_TYPE_SID_OR_SID_HISTORY_NAME element
    ///                   in <b>ADS_NAME_TYPE_ENUM</b>.
    ///    pvar = A variant array of strings that hold names of the objects returned.
    ///Returns:
    ///    This method supports the standard <b>HRESULT</b> return values, including:
    ///    
    HRESULT GetEx(int lnFormatType, VARIANT* pvar);
}

///The <b>IADsCaseIgnoreList</b> interface provides methods for an ADSI client to access the Case Ignore List attribute.
///You can call the property methods of this interface to obtain and modify the attribute.
@GUID("7B66B533-4680-11D1-A3B4-00C04FB950DC")
interface IADsCaseIgnoreList : IDispatch
{
    HRESULT get_CaseIgnoreList(VARIANT* retval);
    HRESULT put_CaseIgnoreList(VARIANT vCaseIgnoreList);
}

///The <b>IADsFaxNumber</b> interface provides methods for an ADSI client to access the Facsimile Telephone Number
///attribute. You can call the property methods of this interface to obtain and modify the attribute.
@GUID("A910DEA9-4680-11D1-A3B4-00C04FB950DC")
interface IADsFaxNumber : IDispatch
{
    HRESULT get_TelephoneNumber(BSTR* retval);
    HRESULT put_TelephoneNumber(BSTR bstrTelephoneNumber);
    HRESULT get_Parameters(VARIANT* retval);
    HRESULT put_Parameters(VARIANT vParameters);
}

///The <b>IADsNetAddress</b> interface provides methods for an ADSI client to access the Net Address attribute. You can
///call the property methods of this interface to obtain and modify the attribute.
@GUID("B21A50A9-4080-11D1-A3AC-00C04FB950DC")
interface IADsNetAddress : IDispatch
{
    HRESULT get_AddressType(int* retval);
    HRESULT put_AddressType(int lnAddressType);
    HRESULT get_Address(VARIANT* retval);
    HRESULT put_Address(VARIANT vAddress);
}

///The <b>IADsOctetList</b> interface provides methods for an ADSI client to access the Octet List attribute. You can
///call the property methods of this interface to obtain and modify the attribute.
@GUID("7B28B80F-4680-11D1-A3B4-00C04FB950DC")
interface IADsOctetList : IDispatch
{
    HRESULT get_OctetList(VARIANT* retval);
    HRESULT put_OctetList(VARIANT vOctetList);
}

///The <b>IADsEmail</b> interface provides methods for an ADSI client to access the Email Address attribute. You can
///call the property methods of this interface to obtain and modify the attribute.
@GUID("97AF011A-478E-11D1-A3B4-00C04FB950DC")
interface IADsEmail : IDispatch
{
    HRESULT get_Type(int* retval);
    HRESULT put_Type(int lnType);
    HRESULT get_Address(BSTR* retval);
    HRESULT put_Address(BSTR bstrAddress);
}

///The <b>IADsPath</b> interface provides methods for an ADSI client to access the <b>Path</b> attribute. You can call
///the property methods of this interface to obtain and modify the attribute.
@GUID("B287FCD5-4080-11D1-A3AC-00C04FB950DC")
interface IADsPath : IDispatch
{
    HRESULT get_Type(int* retval);
    HRESULT put_Type(int lnType);
    HRESULT get_VolumeName(BSTR* retval);
    HRESULT put_VolumeName(BSTR bstrVolumeName);
    HRESULT get_Path(BSTR* retval);
    HRESULT put_Path(BSTR bstrPath);
}

///The <b>IADsReplicaPointer</b> interface provides methods for an ADSI client to access the <b>Replica Pointer</b>
///attribute. You can call the property methods of this interface to obtain and modify the attribute.
@GUID("F60FB803-4080-11D1-A3AC-00C04FB950DC")
interface IADsReplicaPointer : IDispatch
{
    HRESULT get_ServerName(BSTR* retval);
    HRESULT put_ServerName(BSTR bstrServerName);
    HRESULT get_ReplicaType(int* retval);
    HRESULT put_ReplicaType(int lnReplicaType);
    HRESULT get_ReplicaNumber(int* retval);
    HRESULT put_ReplicaNumber(int lnReplicaNumber);
    HRESULT get_Count(int* retval);
    HRESULT put_Count(int lnCount);
    HRESULT get_ReplicaAddressHints(VARIANT* retval);
    HRESULT put_ReplicaAddressHints(VARIANT vReplicaAddressHints);
}

///The <b>IADsAcl</b> interface provides methods for an ADSI client to access and manipulate the <b>ACL</b> or
///<b>Inherited ACL</b> attribute values. This interface manipulates the attributes.
@GUID("8452D3AB-0869-11D1-A377-00C04FB950DC")
interface IADsAcl : IDispatch
{
    HRESULT get_ProtectedAttrName(BSTR* retval);
    HRESULT put_ProtectedAttrName(BSTR bstrProtectedAttrName);
    HRESULT get_SubjectName(BSTR* retval);
    HRESULT put_SubjectName(BSTR bstrSubjectName);
    HRESULT get_Privileges(int* retval);
    HRESULT put_Privileges(int lnPrivileges);
    ///The <b>IADsAcl::CopyAcl</b> method makes a copy of the existing ACL.
    ///Params:
    ///    ppAcl = Pointer to the newly created copy of the existing ACL.
    ///Returns:
    ///    This method supports the standard return values, as well as the following: For other return values, see ADSI
    ///    Error Codes.
    ///    
    HRESULT CopyAcl(IDispatch* ppAcl);
}

///The <b>IADsTimestamp</b> interface provides methods for an ADSI client to access the <b>Timestamp</b> attribute. You
///can call the property methods of this interface to obtain and modify the attribute.
@GUID("B2F5A901-4080-11D1-A3AC-00C04FB950DC")
interface IADsTimestamp : IDispatch
{
    HRESULT get_WholeSeconds(int* retval);
    HRESULT put_WholeSeconds(int lnWholeSeconds);
    HRESULT get_EventID(int* retval);
    HRESULT put_EventID(int lnEventID);
}

///The <b>IADsPostalAddress</b> interface provides methods for an ADSI client to access the <b>Postal Address</b>
///attribute. You can call the property methods of this interface to obtain and modify the attribute.
@GUID("7ADECF29-4680-11D1-A3B4-00C04FB950DC")
interface IADsPostalAddress : IDispatch
{
    HRESULT get_PostalAddress(VARIANT* retval);
    HRESULT put_PostalAddress(VARIANT vPostalAddress);
}

///The <b>IADsBackLink</b> interface provides methods for an ADSI client to access the <b>Back Link</b> attribute. You
///can call the property methods of this interface to obtain and modify the attribute.
@GUID("FD1302BD-4080-11D1-A3AC-00C04FB950DC")
interface IADsBackLink : IDispatch
{
    HRESULT get_RemoteID(int* retval);
    HRESULT put_RemoteID(int lnRemoteID);
    HRESULT get_ObjectName(BSTR* retval);
    HRESULT put_ObjectName(BSTR bstrObjectName);
}

///The <b>IADsTypedName</b> interface provides methods for an ADSI client to access the <b>Typed Name</b> attribute. You
///can call the property methods of this interface to obtain and modify the attribute.
@GUID("B371A349-4080-11D1-A3AC-00C04FB950DC")
interface IADsTypedName : IDispatch
{
    HRESULT get_ObjectName(BSTR* retval);
    HRESULT put_ObjectName(BSTR bstrObjectName);
    HRESULT get_Level(int* retval);
    HRESULT put_Level(int lnLevel);
    HRESULT get_Interval(int* retval);
    HRESULT put_Interval(int lnInterval);
}

///The <b>IADsHold</b> interface provides methods for an ADSI client to access the <b>Hold</b> attribute. You can call
///the property methods of this interface to obtain and modify the attribute.
@GUID("B3EB3B37-4080-11D1-A3AC-00C04FB950DC")
interface IADsHold : IDispatch
{
    HRESULT get_ObjectName(BSTR* retval);
    HRESULT put_ObjectName(BSTR bstrObjectName);
    HRESULT get_Amount(int* retval);
    HRESULT put_Amount(int lnAmount);
}

///The <b>IADsObjectOptions</b> interface provides a direct mechanism to specify and obtain provider-specific options
///for manipulating an ADSI object. Typically, the options apply to search operations of the underlying directory store.
///The supported options are provider-specific.
@GUID("46F14FDA-232B-11D1-A808-00C04FD8D5A8")
interface IADsObjectOptions : IDispatch
{
    ///The <b>IADsOptions.GetOption</b> method gets a provider-specific option for a directory object.
    ///Params:
    ///    lnOption = Indicates the provider-specific option to get. This parameter can be any value in the ADS_OPTION_ENUM
    ///               enumeration.
    ///    pvValue = Pointer to a <b>VARIANT</b> variable that receives the current value for the option specified in the
    ///              <i>lnOption</i> parameter.
    ///Returns:
    ///    The method supports the standard return values, including <b>S_OK</b> if the operation is successful, and
    ///    <b>E_ADS_BAD_PARAMETER</b> if the user has supplied an invalid <i>pvValue</i> parameter. For more
    ///    information, see ADSI Error Codes.
    ///    
    HRESULT GetOption(int lnOption, VARIANT* pvValue);
    ///The <b>IADsOptions.SetOption</b> method sets a provider-specific option for manipulating a directory object.
    ///Params:
    ///    lnOption = Indicates the provider-specific option to set. This parameter can be any value in the ADS_OPTION_ENUM
    ///               enumeration except <b>ADS_OPTION_SERVERNAME</b> or <b>ADS_OPTION_MUTUAL_AUTH_STATUS</b>.
    ///    vValue = Specifies the value to set for the option specified in the <i>lnOption</i> parameter.
    ///Returns:
    ///    The method supports the standard return values, including <b>S_OK</b> for a successful operation and
    ///    <b>E_ADS_BAD_PARAMETER</b> when the user has supplied an invalid <i>pValue</i> parameter. For more
    ///    information, see ADSI Error Codes.
    ///    
    HRESULT SetOption(int lnOption, VARIANT vValue);
}

///The <b>IADsPathname</b> interface parses the X.500 and Windows path in ADSI. The <b>IADsPathname</b> interface can be
///used to: <ul> <li>Set and get paths of ADSI objects in different formats.</li> <li>Extract or add each element for a
///given ADsPath.</li> <li>Construct ADsPaths to be used in queries of directory objects.</li> </ul>The
///<b>IADsPathname</b> interface is implemented on a <b>Pathname</b> object. You must instantiate the <b>Pathname</b>
///object to use the methods defined in the <b>IADsPathname</b> interface. This requirement is similar to calling the
///CoCreateInstance() function in C++. ```cpp IADsPathname *pPathname=NULL; HRESULT hr; hr =
///CoCreateInstance(CLSID_Pathname, NULL, CLSCTX_INPROC_SERVER, IID_IADsPathname, (void**)&pPathname); ``` You can also
///invoke the <b>New</b> operator in Visual Basic: ```vb Dim path As New Pathname ``` Or use the <b>CreateObject</b>
///function in VBScript, supplying "Pathname" as the ProgID. ```vb Dim path Set path = CreateObject("Pathname") ``` The
///<b>IADsPathname</b> interface uses two enumeration types: ADS_SETTYPE_ENUM, and ADS_FORMAT_ENUM.
@GUID("D592AED4-F420-11D0-A36E-00C04FB950DC")
interface IADsPathname : IDispatch
{
    ///The <b>IADsPathname::Set</b> method sets up the Pathname object for parsing a directory path. The path is set
    ///with a format as defined in ADS_SETTYPE_ENUM.
    ///Params:
    ///    bstrADsPath = Path of an ADSI object.
    ///    lnSetType = An ADS_SETTYPE_ENUM option that defines the format type to be retrieved.
    ///Returns:
    ///    This method supports the standard return values, as well as the following: For more information and other
    ///    return values, see ADSI Error Codes.
    ///    
    HRESULT Set(BSTR bstrADsPath, int lnSetType);
    ///The <b>IADsPathname::SetDisplayType</b> method specifies how to display the path of an object. It can query for
    ///the path to be displayed in a string with both naming attributes and values, that is, "CN=Jeff Smith" or with
    ///values only, that is, "Jeff Smith".
    ///Params:
    ///    lnDisplayType = The display type of a path as defined in ADS_DISPLAY_ENUM.
    ///Returns:
    ///    This method supports the standard return values, including the following:
    ///    
    HRESULT SetDisplayType(int lnDisplayType);
    ///The <b>IADsPathname::Retrieve</b> method retrieves the path of the object with different format types.
    ///Params:
    ///    lnFormatType = Specifies the format that the path should be retrieved in. This can be one of the values specified in the
    ///                   ADS_FORMAT_ENUM enumeration.
    ///    pbstrADsPath = Contains a pointer to a <b>BSTR</b> value the receives the object path. The caller must free this memory with
    ///                   the SysFreeString function when it is no longer required.
    ///Returns:
    ///    This method supports the standard return values, as well as the following. For more information and other
    ///    return values, see ADSI Error Codes.
    ///    
    HRESULT Retrieve(int lnFormatType, BSTR* pbstrADsPath);
    ///The <b>IADsPathname::GetNumElements</b> method retrieves the number of elements in the path.
    ///Params:
    ///    plnNumPathElements = The number of elements in the path.
    ///Returns:
    ///    This method supports the standard return values, as well as the following: For more information and other
    ///    return values, see ADSI Error Codes.
    ///    
    HRESULT GetNumElements(int* plnNumPathElements);
    ///The <b>IADsPathname::GetElement</b> method retrieves an element of a directory path.
    ///Params:
    ///    lnElementIndex = The index of the element.
    ///    pbstrElement = The returned element.
    ///Returns:
    ///    This method supports the standard return values, as well as the following: For more information and other
    ///    return values, see ADSI Error Codes.
    ///    
    HRESULT GetElement(int lnElementIndex, BSTR* pbstrElement);
    ///The <b>IADsPathname::AddLeafElement</b> method adds an element to the end of the directory path already set on
    ///the Pathname object.
    ///Params:
    ///    bstrLeafElement = The name of the leaf element.
    ///Returns:
    ///    This method supports the standard return values, as well as the following: For more information and other
    ///    return values, see ADSI Error Codes.
    ///    
    HRESULT AddLeafElement(BSTR bstrLeafElement);
    ///The <b>IADsPathname::RemoveLeafElement</b> method removes the last element from the directory path that has been
    ///set on the Pathname object.
    ///Returns:
    ///    This method supports the standard return values, as well as the following: For more information and other
    ///    return values, see ADSI Error Codes.
    ///    
    HRESULT RemoveLeafElement();
    ///The <b>IADsPathname::CopyPath</b> method creates a copy of the Pathname object.
    ///Params:
    ///    ppAdsPath = The IDispatch interface pointer on the returned IADsPathname object.
    ///Returns:
    ///    This method supports the standard return values, as well as the following: For more information and other
    ///    return values, see <a href="/windows/desktop/ADSI/adsi-error-codes">ADSI Error Codes</a>.
    ///    
    HRESULT CopyPath(IDispatch* ppAdsPath);
    ///The <b>IADsPathname::GetEscapedElement</b> method is used to escape special characters in the input path.
    ///Params:
    ///    lnReserved = Reserved for future use.
    ///    bstrInStr = An input string.
    ///    pbstrOutStr = An output string.
    ///Returns:
    ///    This method supports the standard return values, as well as the following: For more information and other
    ///    return values, see ADSI Error Codes.
    ///    
    HRESULT GetEscapedElement(int lnReserved, BSTR bstrInStr, BSTR* pbstrOutStr);
    HRESULT get_EscapedMode(int* retval);
    HRESULT put_EscapedMode(int lnEscapedMode);
}

///The <b>IADsADSystemInfo</b> interface retrieves data about the local computer if it is running a Windows operating
///system in a Windows domain. For example, you can get the domain, site, and distinguished name of the local computer.
///The <b>IADsADSystemInfo</b> interface is implemented on the <b>ADSystemInfo</b> object residing in adsldp.dll, which
///is included with the standard installation of ADSI on Windows 2000. You must explicitly create an instance of the
///<b>ADSystemInfo</b> object in order to call the methods on the <b>IADsADSystemInfo</b> interface. This requirement
///amounts to creating an <b>ADSystemInfo</b> instance with the CoCreateInstance function in C/C++. ```cpp
///IADsADSystemInfo *pADsys; HRESULT hr = CoCreateInstance(CLSID_ADSystemInfo, NULL, CLSCTX_INPROC_SERVER,
///IID_IADsADSystemInfo, (void**)&pADsys); ``` You can also use the <b>New</b> operator in Visual Basic. ```vb Dim adSys
///as New ADSystemInfo ``` Or you can call the <b>CreateObject</b> function in a scripting environment, supplying
///"ADSystemInfo" as the ProgID. ```vb Dim adSys Set adSys = CreateObject("ADSystemInfo") ```
@GUID("5BB11929-AFD1-11D2-9CB9-0000F87A369E")
interface IADsADSystemInfo : IDispatch
{
    HRESULT get_UserName(BSTR* retval);
    HRESULT get_ComputerName(BSTR* retval);
    HRESULT get_SiteName(BSTR* retval);
    HRESULT get_DomainShortName(BSTR* retval);
    HRESULT get_DomainDNSName(BSTR* retval);
    HRESULT get_ForestDNSName(BSTR* retval);
    HRESULT get_PDCRoleOwner(BSTR* retval);
    HRESULT get_SchemaRoleOwner(BSTR* retval);
    HRESULT get_IsNativeMode(short* retval);
    ///The <b>IADsADSystemInfo::GetAnyDCName</b> method retrieves the DNS name of a domain controller in the local
    ///computer's domain.
    ///Params:
    ///    pszDCName = Name of a domain controller, such as "ADServer1.domain1.Fabrikam.com".
    ///Returns:
    ///    This method supports the standard <b>HRESULT</b> return values. For more information, see ADSI Error Codes.
    ///    
    HRESULT GetAnyDCName(BSTR* pszDCName);
    ///The <b>IADsADSystemInfo::GetDCSiteName</b> method retrieves the name of the Active Directory site that contains
    ///the local computer.
    ///Params:
    ///    szServer = Name of the Active Directory site.
    ///    pszSiteName = DNS name of the service server.
    ///Returns:
    ///    This method supports the standard <b>HRESULT</b> return values. For more information, see ADSI Error Codes.
    ///    
    HRESULT GetDCSiteName(BSTR szServer, BSTR* pszSiteName);
    ///The <b>IADsADSystemInfo::RefreshSchemaCache</b> method refreshes the Active Directory schema cache.
    ///Returns:
    ///    This method supports the standard <b>HRESULT</b> return values. For more information, see ADSI Error Codes.
    ///    
    HRESULT RefreshSchemaCache();
    ///The <b>IADsADSystemInfo::GetTrees</b> method retrieves the DNS names of all the directory trees in the local
    ///computer's forest.
    ///Params:
    ///    pvTrees = A Variant array of strings that contains the names of the directory trees within the forest.
    ///Returns:
    ///    This method supports the standard <b>HRESULT</b> return values. For more information, see ADSI Error Codes.
    ///    
    HRESULT GetTrees(VARIANT* pvTrees);
}

///The <b>IADsWinNTSystemInfo</b> interface retrieves the WinNT system information about a computer. Such system
///information includes user account name, user domain, host name, and the primary domain controller of the host
///computer. The <b>IADsWinNTSystemInfo</b> interface is implemented on the <b>WinNTSystemInfo</b> object residing in
///Activeds.dll, which is included in the standard installation of ADSI for domain-capable editions of Windows. You must
///explicitly create an instance of the <b>WinNTSystemInfo</b> object to call the methods on the
///<b>IADsWinNTSystemInfo</b> interface. This requirement means creating an <b>WinNTSystemInfo</b> instance with the
///CoCreateInstance function in C/C++. ```cpp IADsWinNTSystemInfo *pNTsys; HRESULT hr =
///CoCreateInstance(CLSID_WinNTSystemInfo, NULL, CLSCTX_INPROC_SERVER, IID_IADsWinNTSystemInfo, (void**)&pNTsys); ```
///You can also use the <b>New</b> operator in Visual Basic. ```vb Dim ntSys As New WinNTSystemInfo ``` You can also
///call the <b>CreateObject</b> function in a scripting environment, supplying "WinNTSystemInfo" as the ProgID. ```vb
///Dim ntSys Set ntSys = CreateObject("WinNTSystemInfo") ```
@GUID("6C6D65DC-AFD1-11D2-9CB9-0000F87A369E")
interface IADsWinNTSystemInfo : IDispatch
{
    HRESULT get_UserName(BSTR* retval);
    HRESULT get_ComputerName(BSTR* retval);
    HRESULT get_DomainName(BSTR* retval);
    HRESULT get_PDC(BSTR* retval);
}

///The <b>IADsDNWithBinary</b> interface provides methods for an ADSI client to associate a distinguished name (DN) with
///the GUID of an object.
@GUID("7E99C0A2-F935-11D2-BA96-00C04FB6D0D1")
interface IADsDNWithBinary : IDispatch
{
    HRESULT get_BinaryValue(VARIANT* retval);
    HRESULT put_BinaryValue(VARIANT vBinaryValue);
    HRESULT get_DNString(BSTR* retval);
    HRESULT put_DNString(BSTR bstrDNString);
}

///The <b>IADsDNWithString</b> interface provides methods for an ADSI client to associate a distinguished name (DN) to a
///string value.
@GUID("370DF02E-F934-11D2-BA96-00C04FB6D0D1")
interface IADsDNWithString : IDispatch
{
    HRESULT get_StringValue(BSTR* retval);
    HRESULT put_StringValue(BSTR bstrStringValue);
    HRESULT get_DNString(BSTR* retval);
    HRESULT put_DNString(BSTR bstrDNString);
}

///The <b>IADsSecurityUtility</b> interface is used to get, set, or retrieve the security descriptor on a file,
///fileshare, or registry key. You can also use it to convert the security descriptor to or from raw or hexadecimal mode
///and you can limit the scope of the security descriptor data retrieved or set by indicating whether you want it for
///the owner, group, DACL, or SACL.
@GUID("A63251B2-5F21-474B-AB52-4A8EFAD10895")
interface IADsSecurityUtility : IDispatch
{
    ///The <b>GetSecurityDescriptor</b> method retrieves a security descriptor for the specified file, fileshare, or
    ///registry key.
    ///Params:
    ///    varPath = A <b>VARIANT</b> string that contains the path of the object to retrieve the security descriptor for.
    ///    lPathFormat = Contains one of the ADS_PATHTYPE_ENUM values which specifies the format of the <i>varPath</i> parameter.
    ///    lFormat = Contains one of the ADS_SD_FORMAT_ENUM values which specifies the format of the security descriptor returned
    ///              in the <i>pVariant</i> parameter. The following list identifies the possible values for this parameter and
    ///              the format that is supplied in the <i>pVariant</i> parameter.
    ///    pVariant = Pointer to a <b>VARIANT</b> that receives the returned security descriptor. The format of the retrieved
    ///               security descriptor is specified by the <i>lFormat</i> parameter.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful or a COM or Win32 error code otherwise. Possible error codes include the
    ///    following.
    ///    
    HRESULT GetSecurityDescriptor(VARIANT varPath, int lPathFormat, int lFormat, VARIANT* pVariant);
    ///The <b>SetSecurityDescriptor</b> method sets the security descriptor for the specified file, file share, or
    ///registry key.
    ///Params:
    ///    varPath = A <b>VARIANT</b> string that contains the path of the object to set the security descriptor for. Possible
    ///              values are listed in the following list.
    ///    lPathFormat = Contains one of the ADS_PATHTYPE_ENUM values which specifies the format of the <i>varPath</i> parameter.
    ///    varData = A <b>VARIANT</b> that contains the new security descriptor. The format of the security descriptor is
    ///              specified by the <i>lDataFormat</i> parameter.
    ///    lDataFormat = Contains one of the ADS_SD_FORMAT_ENUM values which specifies the format of the security descriptor contained
    ///                  in the <i>VarData</i> parameter. The following list identifies the possible values for this parameter and the
    ///                  format of the <i>VarData</i> parameter.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful or a COM or Win32 error code otherwise. Possible error codes are listed in
    ///    the following list.
    ///    
    HRESULT SetSecurityDescriptor(VARIANT varPath, int lPathFormat, VARIANT varData, int lDataFormat);
    ///The <b>ConvertSecurityDescriptor</b> method converts a security descriptor from one format to another.
    ///Params:
    ///    varSD = A <b>VARIANT</b> that contains the security descriptor to convert. The format of this <b>VARIANT</b> is
    ///            defined by the <i>lDataFormat</i> parameter.
    ///    lDataFormat = Contains one of the ADS_SD_FORMAT_ENUM values which specifies the format of the security descriptor in the
    ///                  <i>varSD</i> parameter. The following list identifies the possible values for this parameter and the format
    ///                  of the <i>varSD</i> parameter.
    ///    lOutFormat = Contains one of the ADS_SD_FORMAT_ENUM values which specifies the format that the security descriptor should
    ///                 be converted to. The following list identifies the possible values for this parameter and the format of the
    ///                 <i>pvResult</i> parameter.
    ///    pResult = Pointer to a <b>VARIANT</b> that receives the converted security descriptor. The format of the retrieved
    ///              security descriptor is specified by the <i>lOutFormat</i> parameter.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful or a COM or Win32 error code otherwise. Possible error codes include the
    ///    following.
    ///    
    HRESULT ConvertSecurityDescriptor(VARIANT varSD, int lDataFormat, int lOutFormat, VARIANT* pResult);
    ///The <b>SecurityMask</b> property determines which elements of the security descriptor to retrieve or set. This
    ///property must be set prior to calling IADsSecurityUtility.GetSecurityDescriptor or
    ///IADsSecurityUtility.SetSecurityDescriptor. This property is read/write.
    HRESULT get_SecurityMask(int* retval);
    ///The <b>SecurityMask</b> property determines which elements of the security descriptor to retrieve or set. This
    ///property must be set prior to calling IADsSecurityUtility.GetSecurityDescriptor or
    ///IADsSecurityUtility.SetSecurityDescriptor. This property is read/write.
    HRESULT put_SecurityMask(int lnSecurityMask);
}

///The <b>IDsBrowseDomainTree</b> interface is used by an application to display a domain browser dialog box and/or
///obtain a list of trust domains related to a given computer.
@GUID("7CABCF1E-78F5-11D2-960C-00C04FA31A86")
interface IDsBrowseDomainTree : IUnknown
{
    ///The <b>IDsBrowseDomainTree::BrowseTo</b> method displays a dialog box used to browse for a domain.
    ///Params:
    ///    hwndParent = Handle of the window that will be the owner of the domain browser dialog box.
    ///    ppszTargetPath = Pointer to a Unicode string pointer that receives the path string of the domain selected in the domain
    ///                     browser. This memory must be freed when it is no longer required by calling CoTaskMemFree. By default, this
    ///                     path takes the form "myDom.Fabrikam.com". If <i>dwFlags</i> contains the <b>DBDTF_RETURNFQDN</b> flag, the
    ///                     path takes the form "DC=myDom, DC=Fabrikam, DC=com".
    ///    dwFlags = Contains a set of flags that modify the behavior of the domain browser dialog box. This can be zero or a
    ///              combination of one or more of the following values.
    ///Returns:
    ///    Returns a standard <b>HRESULT</b> value including the following.
    ///    
    HRESULT BrowseTo(HWND hwndParent, PWSTR* ppszTargetPath, uint dwFlags);
    ///The <b>IDsBrowseDomainTree::GetDomains</b> method retrieves the trust domains of the current computer. The
    ///current computer is set using the IDsBrowseDomainTree::SetComputer method.
    ///Params:
    ///    ppDomainTree = Pointer to a DOMAINTREE structure pointer that receives the trust domain data. The caller must free this
    ///                   memory when no longer required by calling IDsBrowseDomainTree::FreeDomains.
    ///    dwFlags = Contains a set of flags that modify the domain contents. This can be zero or a combination of one or more of
    ///              the following values.
    ///Returns:
    ///    Returns a standard <b>HRESULT</b> value including the following.
    ///    
    HRESULT GetDomains(DOMAIN_TREE** ppDomainTree, uint dwFlags);
    ///The <b>IDsBrowseDomainTree::FreeDomains</b> method frees the memory allocated by the
    ///IDsBrowseDomainTree::GetDomains method.
    ///Params:
    ///    ppDomainTree = Pointer to the DOMAINTREE data structure.
    ///Returns:
    ///    Returns a standard <b>HRESULT</b> value including the following.
    ///    
    HRESULT FreeDomains(DOMAIN_TREE** ppDomainTree);
    ///The <b>IDsBrowseDomainTree::FlushCachedDomains</b> method frees the cached domain list.
    ///Returns:
    ///    Returns a standard <b>HRESULT</b> value including the following.
    ///    
    HRESULT FlushCachedDomains();
    ///The <b>IDsBrowseDomainTree::SetComputer</b> method specifies the computer and credentials to be used by this
    ///instance of the IDsBrowseDomainTree interface.
    ///Params:
    ///    pszComputerName = Pointer to a null-terminated Unicode string that contains the name of the target computer.
    ///    pszUserName = Pointer to a null-terminated Unicode string that contains the user name used to access the computer.
    ///    pszPassword = Pointer to a null-terminated Unicode string that contains the password used to access the computer.
    ///Returns:
    ///    Returns a standard <b>HRESULT</b> value including the following.
    ///    
    HRESULT SetComputer(const(PWSTR) pszComputerName, const(PWSTR) pszUserName, const(PWSTR) pszPassword);
}

///The <b>IDsDisplaySpecifier</b> interface provides access to Active Directory Domain Service objects of the
///<b>displaySpecifier</b> class. Such objects are known as <i>display specifiers</i>. A display specifier stores data
///about how user interface elements, such as property pages or context menus, of an object in Active Directory Domain
///Services are to be displayed. For more information, see Display Specifiers. This interface is used to extend the
///display features of an existing object in Active Directory Domain Services, manage the display for a new directory
///object, or enhance the display of an Active Directory Domain Services enabled application. For more information, see
///Extending the User Interface for Directory Objects. To create an instance of this interface, call CoCreateInstance
///with the <b>CLSID_DsDisplaySpecifier</b> object identifier as shown in the following code example. ```cpp #include
///<objbase.h> #define INITGUID #include <initguid.h> #include "dsclient.h" HRESULT hr; IDsDisplaySpecifier *pDS;
///CoInitialize(NULL); hr = CoCreateInstance( CLSID_DsDisplaySpecifier, NULL, CLSCTX_INPROC_SERVER,
///IID_IDsDisplaySpecifier, (void**)&pDS); if(SUCCEEDED(hr)) { // More code calling the interface methods.
///pDS->Release(); } CoUninitialize(); ```
@GUID("1AB4A8C0-6A0B-11D2-AD49-00C04FA31A86")
interface IDsDisplaySpecifier : IUnknown
{
    ///The <b>IDsDisplaySpecifier::SetServer</b> method specifies the server from which display specifier data is
    ///obtained.
    ///Params:
    ///    pszServer = Pointer to a null-terminated Unicode string that contains the name of the server that will be used to obtain
    ///                the display specifier data.
    ///    pszUserName = Pointer to a null-terminated Unicode string that contains the user name to be used for access to the server
    ///                  specified in <i>pszServer</i>.
    ///    pszPassword = Pointer to a null-terminated Unicode string that contains the password used to access the server specified in
    ///                  <i>pszServer</i>.
    ///    dwFlags = Contains a set of flags used to bind to the directory service. This can be zero or a combination of one or
    ///              more of the following values.
    ///Returns:
    ///    Returns a standard <b>HRESULT</b> value including the following.
    ///    
    HRESULT SetServer(const(PWSTR) pszServer, const(PWSTR) pszUserName, const(PWSTR) pszPassword, uint dwFlags);
    ///The <b>IDsDisplaySpecifier::SetLanguageID</b> method changes the locale used by the IDsDisplaySpecifier object to
    ///a specified language.
    ///Params:
    ///    langid = Contains the language identifier used by the IDsDisplaySpecifier object. If this parameter is zero, this
    ///             method calls the GetUserDefaultUILanguage function to retrieve the current user language identifier and uses
    ///             that locale.
    ///Returns:
    ///    This method always returns <b>S_OK</b>.
    ///    
    HRESULT SetLanguageID(ushort langid);
    ///The <b>IDsDisplaySpecifier::GetDisplaySpecifier</b> method binds to the display specifier object for a given
    ///class in Active Directory Domain Services.
    ///Params:
    ///    pszObjectClass = Pointer to a null-terminated Unicode string that contains the name of the object class to retrieve the
    ///                     display specifier for.
    ///    riid = Contains the interface identifier of the desired interface.
    ///    ppv = Pointer to an interface pointer that receives the display specifier of the object class.
    ///Returns:
    ///    Returns a standard <b>HRESULT</b> value including the following.
    ///    
    HRESULT GetDisplaySpecifier(const(PWSTR) pszObjectClass, const(GUID)* riid, void** ppv);
    ///The <b>IDsDisplaySpecifier::GetIconLocation</b> method obtains the icon location for a given object class. The
    ///icon location includes the filename and resource identifier.
    ///Params:
    ///    pszObjectClass = Pointer to a null-terminated Unicode string that contains the name of the object class for which to obtain
    ///                     the icon location. Examples of the object class name are "user" and "container".
    ///    dwFlags = Contains a set of flags that indicate the type of icon to retrieve. This can be a combination of one or more
    ///              of the following.
    ///    pszBuffer = Pointer to a wide character buffer that receives the path and file name of the file that contains the icon.
    ///                This buffer must be at least <i>cchBuffer</i> wide characters in length.
    ///    cchBuffer = Contains the size of the <i>pszBuffer</i> buffer, in wide characters, including the terminating <b>NULL</b>
    ///                character. If the file name exceeds this number of characters, the file name is truncated.
    ///    presid = Pointer to an <b>INT</b> value that receives the resource identifier or index of the icon. If this value is
    ///             positive, the value is the index of the icon in the file. If this value is negative, the absolute value of
    ///             this value is the resource identifier of the icon in the file.
    ///Returns:
    ///    Returns a standard <b>HRESULT</b> value including the following.
    ///    
    HRESULT GetIconLocation(const(PWSTR) pszObjectClass, uint dwFlags, PWSTR pszBuffer, int cchBuffer, int* presid);
    ///The <b>IDsDisplaySpecifier::GetIcon</b> method obtains the icon for a given object class.
    ///Params:
    ///    pszObjectClass = Pointer to a null-terminated Unicode string that contains the name of the object class to obtain the icon
    ///                     for. Examples of the object class name are "user" and "container".
    ///    dwFlags = Contains a set of flags that indicate the type of icon to retrieve. This can be a combination of one or more
    ///              of the following values.
    ///    cxIcon = Contains the desired width, in pixels, of the icon. This method obtains the icon that most closely matches
    ///             this width.
    ///    cyIcon = Contains the desired height, in pixels, of the icon. This method obtains the icon that most closely matches
    ///             this height.
    ///Returns:
    ///    Returns a handle to the icon, if successful, or <b>NULL</b> otherwise. The caller must destroy this icon when
    ///    it is no longer required by passing this handle to DestroyIcon.
    ///    
    HICON   GetIcon(const(PWSTR) pszObjectClass, uint dwFlags, int cxIcon, int cyIcon);
    ///The <b>IDsDisplaySpecifier::GetFriendlyClassName</b> method retrieves the localized name for an object class.
    ///Params:
    ///    pszObjectClass = Pointer to a null-terminated Unicode string that contains the name of the object class to obtain the name of.
    ///                     Examples of the object class name are "user" and "container".
    ///    pszBuffer = Pointer to a wide character buffer that receives the name string. This buffer must be at least
    ///                <i>cchBuffer</i> wide characters in length.
    ///    cchBuffer = Contains the size of the <i>pszBuffer</i> buffer, in wide characters, including the terminating <b>NULL</b>
    ///                character. If the name exceeds this number of characters, the name is truncated.
    ///Returns:
    ///    Returns a standard <b>HRESULT</b> value, including the following.
    ///    
    HRESULT GetFriendlyClassName(const(PWSTR) pszObjectClass, PWSTR pszBuffer, int cchBuffer);
    ///The <b>IDsDisplaySpecifier::GetFriendlyAttributeName</b> method retrieves from the localized name of an attribute
    ///of a given object class.
    ///Params:
    ///    pszObjectClass = Pointer to a null-terminated Unicode string that contains the name of the object class to obtain the
    ///                     localized attribute name for. Examples of the object class name are "user" and "container".
    ///    pszAttributeName = Pointer to a null-terminated Unicode string that contains the name of the attribute to obtain the localized
    ///                       name for.
    ///    pszBuffer = Pointer to a wide character buffer that receives the name string. This buffer must be at least
    ///                <i>cchBuffer</i> wide characters in length.
    ///    cchBuffer = Contains the size of the <i>pszBuffer</i> buffer, in wide characters, including the terminating <b>NULL</b>
    ///                character. If the name exceeds this number of characters, the name is truncated.
    ///Returns:
    ///    Returns a standard <b>HRESULT</b> value, including the following.
    ///    
    HRESULT GetFriendlyAttributeName(const(PWSTR) pszObjectClass, const(PWSTR) pszAttributeName, PWSTR pszBuffer, 
                                     uint cchBuffer);
    ///The <b>IDsDisplaySpecifier::IsClassContainer</b> method determines if a given object class is a container.
    ///Params:
    ///    pszObjectClass = Pointer to a null-terminated Unicode string that contains the name of the object class to determine if it is
    ///                     a container. Examples of the object class name are "user" and "container".
    ///    pszADsPath = Pointer to a null-terminated Unicode string that contains the <b>ADsPath</b> of a class object that can be
    ///                 bound to in the display specifier container and whose schema data can be obtained.
    ///    dwFlags = Contains flags that modify the behavior of this method. This can be zero or the following flag.
    ///Returns:
    ///    Returns <b>TRUE</b> if the specified class is a container. Otherwise it returns <b>FALSE</b>.
    ///    
    BOOL    IsClassContainer(const(PWSTR) pszObjectClass, const(PWSTR) pszADsPath, uint dwFlags);
    ///The <b>IDsDisplaySpecifier::GetClassCreationInfo</b> method retrieves data about the class creation wizard
    ///objects for a given object class.
    ///Params:
    ///    pszObjectClass = Pointer to a null-terminated Unicode string that contains the name of the attribute to obtain the
    ///                     <b>ADsType</b> for.
    ///    ppdscci = Pointer to a DSCLASSCREATIONINFO structure pointer that receives the class creation data. This memory is
    ///              allocated by this method. The caller must free this memory using LocalFree when it is no longer required.
    ///Returns:
    ///    Returns a standard <b>HRESULT</b> value including the following.
    ///    
    HRESULT GetClassCreationInfo(const(PWSTR) pszObjectClass, DSCLASSCREATIONINFO** ppdscci);
    ///The <b>IDsDisplaySpecifier::EnumClassAttributes</b> method enumerates the attributes for a given object class.
    ///The enumeration provides both the LDAP and localized names of each attribute.
    ///Params:
    ///    pszObjectClass = Pointer to a null-terminated Unicode string that contains the name of the object class to enumerate the
    ///                     attributes for. Examples of the object class name are "user" and "container".
    ///    pcbEnum = Pointer to an application-supplied DSEnumAttributesCallback function that is called once for each enumerated
    ///              attribute.
    ///    lParam = Contains an application-defined parameter passed as the <i>lParam</i> parameter in the
    ///             DSEnumAttributesCallback function.
    ///Returns:
    ///    Returns a standard <b>HRESULT</b> value including the following.
    ///    
    HRESULT EnumClassAttributes(const(PWSTR) pszObjectClass, LPDSENUMATTRIBUTES pcbEnum, LPARAM lParam);
    ///The <b>IDsDisplaySpecifier::GetAttributeADsType</b> method retrieves the attribute type for a given attribute.
    ///Params:
    ///    pszAttributeName = Pointer to a null-terminated Unicode string that contains the name of the attribute to obtain the type for.
    ///Returns:
    ///    Returns one of the ADSTYPEENUM values that indicate the type of the attribute.
    ///    
    ADSTYPEENUM GetAttributeADsType(const(PWSTR) pszAttributeName);
}

///The <b>IDsObjectPicker</b> interface is used by an application to initialize and display an object picker dialog box.
///To create an instance of this interface, call CoCreateInstance with the <b>CLSID_DsObjectPicker</b> class identifier
///as shown below. ```cpp HRESULT hr = S_OK; IDsObjectPicker *pDsObjectPicker = NULL; hr =
///CoCreateInstance(CLSID_DsObjectPicker, NULL, CLSCTX_INPROC_SERVER, IID_IDsObjectPicker, (void **) &pDsObjectPicker);
///``` The <b>IDsObjectPicker</b> implemented by the system supports both apartment and free-threading models and is
///thread safe. In practice, this means that a call to the methods of this interface will block until no other thread of
///your application is calling any other method on that instance of the interface.
interface IDsObjectPicker : IUnknown
{
    ///The <b>IDsObjectPicker::Initialize</b> method initializes the object picker dialog box with data about the
    ///scopes, filters, and options used by the object picker dialog box.
    ///Params:
    ///    pInitInfo = Pointer to a DSOP_INIT_INFO structure that contains the initialization data.
    ///Returns:
    ///    Returns a standard error code or one of the following values.
    ///    
    HRESULT Initialize(DSOP_INIT_INFO* pInitInfo);
    ///The <b>IDsObjectPicker::InvokeDialog</b> method displays a modal object picker dialog box and returns the user
    ///selections.
    ///Params:
    ///    hwndParent = Handle to the owner window of the dialog box. This parameter cannot be <b>NULL</b> or the result of the
    ///                 GetDesktopWindow function.
    ///    ppdoSelections = Pointer to an IDataObject interface pointer that receives a data object that contains data about the user
    ///                     selections. This data is supplied in the CFSTR_DSOP_DS_SELECTION_LIST data format. This parameter receives
    ///                     <b>NULL</b> if the user cancels the dialog box.
    ///Returns:
    ///    Returns a standard error code or one of the following values.
    ///    
    HRESULT InvokeDialog(HWND hwndParent, IDataObject* ppdoSelections);
}

///The IDsObjectPickerCredentials interface allows you to override credentials for the IDsObjectPicker object
///implementing this interface.
interface IDsObjectPickerCredentials : IDsObjectPicker
{
    ///Use this method to override the user credentials, passing new credentials for the account profile to be used.
    ///Params:
    ///    szUserName = User account.
    ///    szPassword = Password.
    ///Returns:
    ///    S_OK indicates success.
    ///    
    HRESULT SetCredentials(const(PWSTR) szUserName, const(PWSTR) szPassword);
}

///The <b>IDsAdminCreateObj</b> interface is implemented by the system and used by an application or component to
///programmatically start a creation wizard for a specified object class. To obtain an instance of this interface, call
///CoCreateInstance with the <b>CLSID_DsAdminCreateObj</b> class identifier as shown below. ```cpp #include <initguid.h>
///#include <dsadmin.h> HRESULT hr = S_OK; IDsAdminCreateObj* pCreateObj = NULL; hr =
///::CoCreateInstance(CLSID_DsAdminCreateObj, NULL, CLSCTX_INPROC_SERVER, IID_IDsAdminCreateObj, (void**)&pCreateObj);
///```
interface IDsAdminCreateObj : IUnknown
{
    ///The <b>IDsAdminCreateObj::Initialize</b> method initializes an IDsAdminCreateObj object with data about the
    ///container where the object will be created, the class of the object to be created and, possibly, the source
    ///object to copy from.
    ///Params:
    ///    pADsContainerObj = Pointer to an IADsContainer interface that represents the container where the object will be created. This
    ///                       parameter must not be <b>NULL</b>.
    ///    pADsCopySource = Pointer to the IADs interface of the object from which a copy is made. If the new object is not copied from
    ///                     another object, this parameter is <b>NULL</b>. The copy operation is only supported for user objects.
    ///    lpszClassName = Pointer to a <b>WCHAR</b> string that contains the LDAP name of the object class to be created. This
    ///                    parameter must not be <b>NULL</b>. Supported values are: "user", "computer", "printQueue", "group" and
    ///                    "contact".
    ///Returns:
    ///    If the method succeeds, <b>S_OK</b> is returned. If the method fails, an OLE-defined error code is returned.
    ///    
    HRESULT Initialize(IADsContainer pADsContainerObj, IADs pADsCopySource, const(PWSTR) lpszClassName);
    ///The <b>IDsAdminCreateObj::CreateModal</b> method displays the object creation wizard and returns the newly
    ///created object. The IDsAdminCreateObj::Initialize method must be called before
    ///<b>IDsAdminCreateObj::CreateModal</b> can be called.
    ///Params:
    ///    hwndParent = Contains the window handle of the owner of the wizard. This value cannot be <b>NULL</b>. Use the result of
    ///                 the GetDesktopWindow function if no parent window is available.
    ///    ppADsObj = Pointer to an IADs interface pointer that receives the newly created object. This parameter receives
    ///               <b>NULL</b> if the object creation wizard fails or is canceled. The caller must release this interface when
    ///               it is no longer required. This parameter may be <b>NULL</b> if this object is not required.
    ///Returns:
    ///    This method can return one of these values. Returns an OLE-defined error code or one of the following values.
    ///    
    HRESULT CreateModal(HWND hwndParent, IADs* ppADsObj);
}

///The <b>IDsAdminNewObj</b> interface is used by a primary or secondary object creation wizard extension to obtain page
///count data and to control the command buttons in the wizard. An instance of this interface is passed to the extension
///in the IDsAdminNewObjExt::Initialize method.
interface IDsAdminNewObj : IUnknown
{
    ///The <b>IDsAdminNewObj::SetButtons</b> method enables or disables the "Next" command button in the wizard for a
    ///specific page.
    ///Params:
    ///    nCurrIndex = Contains the zero-based index of the wizard page for which the "Next" button will be enabled or disabled.
    ///                 This index is relative to the page count of the wizard extension that calls the method.
    ///    bValid = Specifies if the "Next" command button is enabled or disabled. If this value is zero, the "Next" command
    ///             button is disabled. If this value is nonzero, the "Next" command button is enabled.
    ///Returns:
    ///    This method can return one of these values. Returns one of the following values.
    ///    
    HRESULT SetButtons(uint nCurrIndex, BOOL bValid);
    ///The <b>IDsAdminNewObj::GetPageCounts</b> method obtains the total number of pages in the wizard as well as the
    ///index of the first page of the extension.
    ///Params:
    ///    pnTotal = Pointer to a <b>LONG</b> value that receives the total number of pages contained in the wizard.
    ///    pnStartIndex = Pointer to a <b>LONG</b> value that receives the zero-based index of the first page of the extension.
    ///Returns:
    ///    This method can return one of these values. Returns one of the following values.
    ///    
    HRESULT GetPageCounts(int* pnTotal, int* pnStartIndex);
}

///The <b>IDsAdminNewObjPrimarySite</b> interface is implemented by the system and is used by a primary object creation
///extension to create a new temporary object in Active Directory Domain Services and then commit the object to
///persistent memory. To obtain an instance of this interface call QueryInterface with
///<b>IID_IDsAdminNewObjPrimarySite</b> on the IDsAdminNewObj interface passed to IDsAdminNewObjExt::Initialize.
interface IDsAdminNewObjPrimarySite : IUnknown
{
    ///The <b>IDsAdminNewObjPrimarySite::CreateNew</b> method enables a primary object creation extension to create a
    ///temporary directory service object in Active Directory Domain Services. This object is then passed to each object
    ///creation extension in the extension's IDsAdminNewObjExt::SetObject method.
    ///Params:
    ///    pszName = Pointer to a <b>WCHAR</b> string that contains the name of the object to be created.
    ///Returns:
    ///    If the method succeeds, <b>S_OK</b> is returned. If the method fails, an OLE-defined error code is returned.
    ///    This method fails if the calling extension is not a primary object creation extension.
    ///    
    HRESULT CreateNew(const(PWSTR) pszName);
    ///The <b>IDsAdminNewObjPrimarySite::Commit</b> method causes a single-page primary object creation extension's
    ///IDsAdminNewObjExt::WriteData method to be called and writes the temporary object to persistent memory.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful or an OLE-defined error code otherwise. This method fails if the calling
    ///    extension is not a primary object creation extension. This method also fails if the object creation wizard
    ///    contains more than one page.
    ///    
    HRESULT Commit();
}

///The <b>IDsAdminNewObjExt</b> interface is implemented by an object creation wizard extension. This interface is used
///by the Active Directory administrative MMC snap-ins to control the object creation extension. The snap-in creates an
///instance of this object by using the CLSID of the extension.
interface IDsAdminNewObjExt : IUnknown
{
    ///The <b>IDsAdminNewObjExt::Initialize</b> method initializes an object creation wizard extension.
    ///Params:
    ///    pADsContainerObj = Pointer to the IADsContainer interface of an existing container where the object are created. This parameter
    ///                       must not be <b>NULL</b>. If this object is to be kept beyond the scope of this method, the reference count
    ///                       must be incremented by calling IUnknown::AddRef or IUnknown::QueryInterface.
    ///    pADsCopySource = Pointer to the IADs interface of the object from which a copy is made. If the new object is not copied from
    ///                     another object, this parameter is <b>NULL</b>. For more information about copy operations, see the Remarks
    ///                     section. If this object is to be kept beyond the scope of this method, the reference count must be
    ///                     incremented by calling IUnknown::AddRef or IUnknown::QueryInterface.
    ///    lpszClassName = Pointer to a <b>WCHAR</b> string containing the LDAP name of the object class to be created. This parameter
    ///                    must not be <b>NULL</b>. Supported values are: "user", "computer", "printQueue", "group", and "contact".
    ///    pDsAdminNewObj = Pointer to an IDsAdminNewObj interface that contains additional data about the wizard. You can also obtain
    ///                     the IDsAdminNewObjPrimarySite interface of the primary extension by calling QueryInterface with
    ///                     <b>IID_IDsAdminNewObjPrimarySite</b> on this interface. If this object is to be kept beyond the scope of this
    ///                     method, the reference count must be incremented by calling IUnknown::AddRef or
    ///                     <b>IUnknown::QueryInterface</b>.
    ///    pDispInfo = Pointer to a DSA_NEWOBJ_DISPINFO structure that contains additional data about the object creation wizard.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful or an OLE-defined error code otherwise.
    ///    
    HRESULT Initialize(IADsContainer pADsContainerObj, IADs pADsCopySource, const(PWSTR) lpszClassName, 
                       IDsAdminNewObj pDsAdminNewObj, DSA_NEWOBJ_DISPINFO* pDispInfo);
    ///The <b>IDsAdminNewObjExt::AddPages</b> method is called to enable the object creation wizard extension to add the
    ///desired pages to the wizard.
    ///Params:
    ///    lpfnAddPage = Pointer to a function that the object creation wizard extension calls to add a page to the wizard. This
    ///                  function takes the following format. ```cpp BOOL fnAddPage(HPROPSHEETPAGE hPage, LPARAM lParam); ```
    ///                  <i>hPage</i> contains the handle of the wizard page created by calling CreatePropertySheetPage. <i>lParam</i>
    ///                  is the <i>lParam</i> value passed to <b>AddPages</b>.
    ///    lParam = Contains data that is private to the administrative snap-in. This value is passed as the second parameter to
    ///             <i>lpfnAddPage</i>.
    ///Returns:
    ///    If the method is successful, <b>S_OK</b> is returned. If the method fails, an OLE-defined error code is
    ///    returned.
    ///    
    HRESULT AddPages(LPFNADDPROPSHEETPAGE lpfnAddPage, LPARAM lParam);
    ///The <b>IDsAdminNewObjExt::SetObject</b> method provides the object creation extension with a pointer to the
    ///directory object created.
    ///Params:
    ///    pADsObj = Pointer to an IADs interface for the object. This parameter may be <b>NULL</b>. If this object is to be kept
    ///              beyond the scope of this method, the reference count must be incremented by calling IUnknown::AddRef or
    ///              IUnknown::QueryInterface.
    ///Returns:
    ///    The method should always return <b>S_OK</b>.
    ///    
    HRESULT SetObject(IADs pADsObj);
    ///The <b>IDsAdminNewObjExt::WriteData</b> method enables the object creation wizard extension to write its data
    ///into an object in Active Directory Domain Services.
    ///Params:
    ///    hWnd = The window handle used as the parent window for possible error messages.
    ///    uContext = Specifies the context in which <b>WriteData</b> is called. This will be one of the following values.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful or an OLE-defined error code otherwise.
    ///    
    HRESULT WriteData(HWND hWnd, uint uContext);
    ///The <b>IDsAdminNewObjExt::OnError</b> method is called when an error has occurred in the wizard pages.
    ///Params:
    ///    hWnd = The window handle used as the parent window for possible error messages.
    ///    hr = <b>HRESULT</b> of the error that occurred.
    ///    uContext = Specifies the context in which <b>OnError</b> is called. This will be one of the following values.
    ///Returns:
    ///    A primary creation extension returns <b>S_OK</b> to indicate that the error was handled by the extension or
    ///    an OLE-defined error code to cause the system to display an error message. The return value is ignored for a
    ///    secondary creation extension.
    ///    
    HRESULT OnError(HWND hWnd, HRESULT hr, uint uContext);
    ///The <b>IDsAdminNewObjExt::GetSummaryInfo</b> method obtains a string that contains a summary of the data gathered
    ///by the new object wizard extension page. This string is displayed in the wizard Finish page.
    ///Params:
    ///    pBstrText = A pointer to a <b>BSTR</b> value that receives the summary text. To allocate this value, call SysAllocString.
    ///                The caller must free this memory by calling SysFreeString.
    ///Returns:
    ///    If the method is successful, <b>S_OK</b> is returned. If the method fails, an OLE-defined error code is
    ///    returned. If the extension does not provide a summary string, this method should return <b>E_NOTIMPL</b>.
    ///    
    HRESULT GetSummaryInfo(BSTR* pBstrText);
}

///The <b>IDsAdminNotifyHandler</b> interface is implemented by an Active Directory administrative notification handler.
///This interface is used by the Active Directory Users and Computers MMC snap-in to notify registered handlers when
///certain events, such as deleting or renaming an object, occur. The snap-in creates an instance of this object by
///calling CoCreateInstance with the CLSID of the extension.
interface IDsAdminNotifyHandler : IUnknown
{
    ///The <b>IDsAdminNotifyHandler::Initialize</b> method is called to initialize the notification handler.
    ///Params:
    ///    pExtraInfo = Reserved. This parameter will be <b>NULL</b>.
    ///    puEventFlags = Pointer to a <b>ULONG</b> value that receives a set of flags that indicate which events the notification
    ///                   handler should receive. This can be a combination of one or more of the following values. If this parameter
    ///                   receives zero, the notification handler will not receive any events.
    ///Returns:
    ///    If the method succeeds, <b>S_OK</b> is returned. If the method fails, a standard <b>HRESULT</b> value is
    ///    returned.
    ///    
    HRESULT Initialize(IDataObject pExtraInfo, uint* puEventFlags);
    ///The <b>IDsAdminNotifyHandler::Begin</b> method is called when an event that the notification handler has
    ///requested is occurring. The notification handler specifies the events to receive notifications for when
    ///IDsAdminNotifyHandler::Initialize is called.
    ///Params:
    ///    uEvent = Contains a value the specifies the type of event that is occurring. This can be one of the following values.
    ///    pArg1 = Pointer to an IDataObject interface that supports the CFSTR_DSOBJECTNAMES clipboard format. The contents of
    ///            the data object will vary depending on the value of <i>uEvent</i>. For more information, see the Remarks
    ///            section.
    ///    pArg2 = Pointer to an IDataObject interface that supports the CFSTR_DSOBJECTNAMES clipboard format. The value of this
    ///            parameter and the contents of the data object will vary depending on the value of <i>uEvent</i>. For more
    ///            information, see the Remarks section.
    ///    puFlags = Pointer to a <b>ULONG</b> value that receives a set of flags that modify the behavior of the notification
    ///              handler in the notification confirmation dialog box. This can be zero or a combination of one or more of the
    ///              following values.
    ///    pBstr = Pointer to a <b>BSTR</b> that receives a string that contains the name and/or description of the notification
    ///            handler. This string is displayed in the confirmation dialog box. This string must be allocated by calling
    ///            the SysAllocString function. The caller must free this string when it is no longer required. If this
    ///            parameter receives <b>NULL</b> or an empty string, the notification handler is not added to the confirmation
    ///            dialog box and IDsAdminNotifyHandler::Notify is not called.
    ///Returns:
    ///    If the method succeeds, <b>S_OK</b> is returned. If the method fails, a standard <b>HRESULT</b> value is
    ///    returned.
    ///    
    HRESULT Begin(uint uEvent, IDataObject pArg1, IDataObject pArg2, uint* puFlags, BSTR* pBstr);
    ///The <b>IDsAdminNotifyHandler::Notify</b> method is called for each object after the confirmation dialog box has
    ///been displayed and the notification handler is selected in the confirmation dialog box.
    ///Params:
    ///    nItem = Contains the index of the item in the <b>aObjects</b> member of the DSOBJECTNAMES structure supplied in the
    ///            IDsAdminNotifyHandler::Begin method.
    ///    uFlags = Contains the flags supplied by the notification handler in the IDsAdminNotifyHandler::Begin method.
    ///Returns:
    ///    The return value from this method is ignored.
    ///    
    HRESULT Notify(uint nItem, uint uFlags);
    ///The <b>IDsAdminNotifyHandler::End</b> method is called after the notification event has occurred. This method is
    ///called even if the notification process is canceled.
    ///Returns:
    ///    The return value from this method is ignored.
    ///    
    HRESULT End();
}


// GUIDs

const GUID CLSID_ADSystemInfo       = GUIDOF!ADSystemInfo;
const GUID CLSID_ADsSecurityUtility = GUIDOF!ADsSecurityUtility;
const GUID CLSID_AccessControlEntry = GUIDOF!AccessControlEntry;
const GUID CLSID_AccessControlList  = GUIDOF!AccessControlList;
const GUID CLSID_BackLink           = GUIDOF!BackLink;
const GUID CLSID_CaseIgnoreList     = GUIDOF!CaseIgnoreList;
const GUID CLSID_DNWithBinary       = GUIDOF!DNWithBinary;
const GUID CLSID_DNWithString       = GUIDOF!DNWithString;
const GUID CLSID_Email              = GUIDOF!Email;
const GUID CLSID_FaxNumber          = GUIDOF!FaxNumber;
const GUID CLSID_Hold               = GUIDOF!Hold;
const GUID CLSID_LargeInteger       = GUIDOF!LargeInteger;
const GUID CLSID_NameTranslate      = GUIDOF!NameTranslate;
const GUID CLSID_NetAddress         = GUIDOF!NetAddress;
const GUID CLSID_OctetList          = GUIDOF!OctetList;
const GUID CLSID_Path               = GUIDOF!Path;
const GUID CLSID_Pathname           = GUIDOF!Pathname;
const GUID CLSID_PostalAddress      = GUIDOF!PostalAddress;
const GUID CLSID_PropertyEntry      = GUIDOF!PropertyEntry;
const GUID CLSID_PropertyValue      = GUIDOF!PropertyValue;
const GUID CLSID_ReplicaPointer     = GUIDOF!ReplicaPointer;
const GUID CLSID_SecurityDescriptor = GUIDOF!SecurityDescriptor;
const GUID CLSID_Timestamp          = GUIDOF!Timestamp;
const GUID CLSID_TypedName          = GUIDOF!TypedName;
const GUID CLSID_WinNTSystemInfo    = GUIDOF!WinNTSystemInfo;

const GUID IID_IADs                      = GUIDOF!IADs;
const GUID IID_IADsADSystemInfo          = GUIDOF!IADsADSystemInfo;
const GUID IID_IADsAccessControlEntry    = GUIDOF!IADsAccessControlEntry;
const GUID IID_IADsAccessControlList     = GUIDOF!IADsAccessControlList;
const GUID IID_IADsAcl                   = GUIDOF!IADsAcl;
const GUID IID_IADsAggregatee            = GUIDOF!IADsAggregatee;
const GUID IID_IADsAggregator            = GUIDOF!IADsAggregator;
const GUID IID_IADsBackLink              = GUIDOF!IADsBackLink;
const GUID IID_IADsCaseIgnoreList        = GUIDOF!IADsCaseIgnoreList;
const GUID IID_IADsClass                 = GUIDOF!IADsClass;
const GUID IID_IADsCollection            = GUIDOF!IADsCollection;
const GUID IID_IADsComputer              = GUIDOF!IADsComputer;
const GUID IID_IADsComputerOperations    = GUIDOF!IADsComputerOperations;
const GUID IID_IADsContainer             = GUIDOF!IADsContainer;
const GUID IID_IADsDNWithBinary          = GUIDOF!IADsDNWithBinary;
const GUID IID_IADsDNWithString          = GUIDOF!IADsDNWithString;
const GUID IID_IADsDeleteOps             = GUIDOF!IADsDeleteOps;
const GUID IID_IADsDomain                = GUIDOF!IADsDomain;
const GUID IID_IADsEmail                 = GUIDOF!IADsEmail;
const GUID IID_IADsExtension             = GUIDOF!IADsExtension;
const GUID IID_IADsFaxNumber             = GUIDOF!IADsFaxNumber;
const GUID IID_IADsFileService           = GUIDOF!IADsFileService;
const GUID IID_IADsFileServiceOperations = GUIDOF!IADsFileServiceOperations;
const GUID IID_IADsFileShare             = GUIDOF!IADsFileShare;
const GUID IID_IADsGroup                 = GUIDOF!IADsGroup;
const GUID IID_IADsHold                  = GUIDOF!IADsHold;
const GUID IID_IADsLargeInteger          = GUIDOF!IADsLargeInteger;
const GUID IID_IADsLocality              = GUIDOF!IADsLocality;
const GUID IID_IADsMembers               = GUIDOF!IADsMembers;
const GUID IID_IADsNameTranslate         = GUIDOF!IADsNameTranslate;
const GUID IID_IADsNamespaces            = GUIDOF!IADsNamespaces;
const GUID IID_IADsNetAddress            = GUIDOF!IADsNetAddress;
const GUID IID_IADsO                     = GUIDOF!IADsO;
const GUID IID_IADsOU                    = GUIDOF!IADsOU;
const GUID IID_IADsObjectOptions         = GUIDOF!IADsObjectOptions;
const GUID IID_IADsOctetList             = GUIDOF!IADsOctetList;
const GUID IID_IADsOpenDSObject          = GUIDOF!IADsOpenDSObject;
const GUID IID_IADsPath                  = GUIDOF!IADsPath;
const GUID IID_IADsPathname              = GUIDOF!IADsPathname;
const GUID IID_IADsPostalAddress         = GUIDOF!IADsPostalAddress;
const GUID IID_IADsPrintJob              = GUIDOF!IADsPrintJob;
const GUID IID_IADsPrintJobOperations    = GUIDOF!IADsPrintJobOperations;
const GUID IID_IADsPrintQueue            = GUIDOF!IADsPrintQueue;
const GUID IID_IADsPrintQueueOperations  = GUIDOF!IADsPrintQueueOperations;
const GUID IID_IADsProperty              = GUIDOF!IADsProperty;
const GUID IID_IADsPropertyEntry         = GUIDOF!IADsPropertyEntry;
const GUID IID_IADsPropertyList          = GUIDOF!IADsPropertyList;
const GUID IID_IADsPropertyValue         = GUIDOF!IADsPropertyValue;
const GUID IID_IADsPropertyValue2        = GUIDOF!IADsPropertyValue2;
const GUID IID_IADsReplicaPointer        = GUIDOF!IADsReplicaPointer;
const GUID IID_IADsResource              = GUIDOF!IADsResource;
const GUID IID_IADsSecurityDescriptor    = GUIDOF!IADsSecurityDescriptor;
const GUID IID_IADsSecurityUtility       = GUIDOF!IADsSecurityUtility;
const GUID IID_IADsService               = GUIDOF!IADsService;
const GUID IID_IADsServiceOperations     = GUIDOF!IADsServiceOperations;
const GUID IID_IADsSession               = GUIDOF!IADsSession;
const GUID IID_IADsSyntax                = GUIDOF!IADsSyntax;
const GUID IID_IADsTimestamp             = GUIDOF!IADsTimestamp;
const GUID IID_IADsTypedName             = GUIDOF!IADsTypedName;
const GUID IID_IADsUser                  = GUIDOF!IADsUser;
const GUID IID_IADsWinNTSystemInfo       = GUIDOF!IADsWinNTSystemInfo;
const GUID IID_ICommonQuery              = GUIDOF!ICommonQuery;
const GUID IID_IDirectoryObject          = GUIDOF!IDirectoryObject;
const GUID IID_IDirectorySchemaMgmt      = GUIDOF!IDirectorySchemaMgmt;
const GUID IID_IDirectorySearch          = GUIDOF!IDirectorySearch;
const GUID IID_IDsBrowseDomainTree       = GUIDOF!IDsBrowseDomainTree;
const GUID IID_IDsDisplaySpecifier       = GUIDOF!IDsDisplaySpecifier;
const GUID IID_IPersistQuery             = GUIDOF!IPersistQuery;
const GUID IID_IPrivateDispatch          = GUIDOF!IPrivateDispatch;
const GUID IID_IPrivateUnknown           = GUIDOF!IPrivateUnknown;
const GUID IID_IQueryForm                = GUIDOF!IQueryForm;
