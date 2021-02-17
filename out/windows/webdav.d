// Written in the D programming language.

module windows.webdav;

public import windows.core;
public import windows.systemservices : BOOL, HANDLE;

extern(Windows):


// Enums


///Specifies the next action that the WebDAV client should take after a successful call to the DavAuthCallback callback
///function.
alias AUTHNEXTSTEP = int;
enum : int
{
    ///Retry the connection request without using the DavAuthCallback callback function. This is the same as the default
    ///behavior if no callback function is registered.
    DefaultBehavior = 0x00000000,
    ///Retry the connection request using the credentials that were retrieved by the DavAuthCallback function.
    RetryRequest    = 0x00000001,
    ///Cancel the connection request.
    CancelRequest   = 0x00000002,
}

// Callbacks

///The WebDAV client calls the application-defined <i>DavFreeCredCallback</i> callback function to free the credential
///information that was retrieved by the DavAuthCallback callback function. The <i>PFNDAVAUTHCALLBACK_FREECRED</i> type
///defines a pointer to this callback function. <i>DavFreeCredCallback</i> is a placeholder for the application-defined
///function name.
///Params:
///    pbuffer = A pointer to the DAV_CALLBACK_AUTH_UNP or DAV_CALLBACK_AUTH_BLOB structure that was used in the DavAuthCallback
///              callback function.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a system
///    error code.
///    
alias PFNDAVAUTHCALLBACK_FREECRED = uint function(void* pbuffer);
///The WebDAV client calls the application-defined <i>DavAuthCallback</i> callback function to prompt the user for
///credentials. The <i>PFNDAVAUTHCALLBACK</i> type defines a pointer to this callback function. <i>DavAuthCallback</i>
///is a placeholder for the application-defined function name.
///Params:
///    lpwzServerName = A pointer to a <b>NULL</b>-terminated Unicode string that contains the name of the target server.
///    lpwzRemoteName = A pointer to a <b>NULL</b>-terminated Unicode string that contains the name of the network resource.
///    dwAuthScheme = A bitmask of flags that specify the authentication schemes to be used. <table> <tr> <th>Value</th>
///                   <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DAV_AUTHN_SCHEME_BASIC"></a><a
///                   id="dav_authn_scheme_basic"></a><dl> <dt><b>DAV_AUTHN_SCHEME_BASIC</b></dt> <dt>0x00000001</dt> </dl> </td> <td
///                   width="60%"> Basic authentication is to be used. </td> </tr> <tr> <td width="40%"><a
///                   id="DAV_AUTHN_SCHEME_NTLM"></a><a id="dav_authn_scheme_ntlm"></a><dl> <dt><b>DAV_AUTHN_SCHEME_NTLM</b></dt>
///                   <dt>0x00000002</dt> </dl> </td> <td width="60%"> Microsoft NTLM authentication is to be used. </td> </tr> <tr>
///                   <td width="40%"><a id="DAV_AUTHN_SCHEME_PASSPORT"></a><a id="dav_authn_scheme_passport"></a><dl>
///                   <dt><b>DAV_AUTHN_SCHEME_PASSPORT</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%"> Passport
///                   authentication is to be used. </td> </tr> <tr> <td width="40%"><a id="DAV_AUTHN_SCHEME_DIGEST"></a><a
///                   id="dav_authn_scheme_digest"></a><dl> <dt><b>DAV_AUTHN_SCHEME_DIGEST</b></dt> <dt>0x00000008</dt> </dl> </td> <td
///                   width="60%"> Microsoft Digest authentication is to be used. </td> </tr> <tr> <td width="40%"><a
///                   id="DAV_AUTHN_SCHEME_NEGOTIATE"></a><a id="dav_authn_scheme_negotiate"></a><dl>
///                   <dt><b>DAV_AUTHN_SCHEME_NEGOTIATE</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> Microsoft Negotiate
///                   is to be used. </td> </tr> <tr> <td width="40%"><a id="DAV_AUTHN_SCHEME_CERT"></a><a
///                   id="dav_authn_scheme_cert"></a><dl> <dt><b>DAV_AUTHN_SCHEME_CERT</b></dt> <dt>0x00010000</dt> </dl> </td> <td
///                   width="60%"> Certificate authentication is to be used. </td> </tr> <tr> <td width="40%"><a
///                   id="DAV_AUTHN_SCHEME_FBA"></a><a id="dav_authn_scheme_fba"></a><dl> <dt><b>DAV_AUTHN_SCHEME_FBA</b></dt>
///                   <dt>0x00100000</dt> </dl> </td> <td width="60%"> Forms-based authentication is to be used. </td> </tr> </table>
///    dwFlags = The flags that the WebDAV service passed in the <i>dwFlags</i> parameter when it called the NPAddConnection3
///              function.
///    pCallbackCred = A pointer to a DAV_CALLBACK_CRED structure.
///    NextStep = A pointer to an AUTHNEXTSTEP enumeration value that specifies the next action that the WebDAV client should take
///               after a successful call to the <i>DavAuthCallback</i> callback function.
///    pFreeCred = A pointer to a DavFreeCredCallback callback function.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a system
///    error code.
///    
alias PFNDAVAUTHCALLBACK = uint function(const(wchar)* lpwzServerName, const(wchar)* lpwzRemoteName, 
                                         uint dwAuthScheme, uint dwFlags, DAV_CALLBACK_CRED* pCallbackCred, 
                                         AUTHNEXTSTEP* NextStep, PFNDAVAUTHCALLBACK_FREECRED* pFreeCred);

// Structs


///Stores an authentication BLOB that was retrieved by the DavAuthCallback callback function.
struct DAV_CALLBACK_AUTH_BLOB
{
    ///A pointer to a buffer that receives the authentication BLOB.
    void* pBuffer;
    ///The size, in bytes, of the buffer that the <b>pBuffer</b> member points to.
    uint  ulSize;
    ///The data type of the buffer that the <b>pBuffer</b> member points to. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td width="60%"> PCCERT_CONTEXT </td>
    ///</tr> </table>
    uint  ulType;
}

///Stores user name and password information that was retrieved by the DavAuthCallback callback function.
struct DAV_CALLBACK_AUTH_UNP
{
    ///A pointer to a string that contains the user name. This string is allocated by the DavAuthCallback callback
    ///function.
    const(wchar)* pszUserName;
    ///The length, in WCHAR, of the user name, not including the terminating <b>NULL</b> character.
    uint          ulUserNameLength;
    ///A pointer to a string that contains the password. This string is allocated by DavAuthCallback.
    const(wchar)* pszPassword;
    ///The length, in WCHAR, of the password, not including the terminating <b>NULL</b> character.
    uint          ulPasswordLength;
}

///Stores user credential information that was retrieved by the DavAuthCallback callback function.
struct DAV_CALLBACK_CRED
{
    ///If the <b>bAuthBlobValid</b> member is <b>TRUE</b>, this member is a DAV_CALLBACK_AUTH_BLOB structure that
    ///contains the user credential information.
    DAV_CALLBACK_AUTH_BLOB AuthBlob;
    ///If the <b>bAuthBlobValid</b> member is <b>FALSE</b>, this member is a DAV_CALLBACK_AUTH_UNP structure that
    ///contains the user credential information.
    DAV_CALLBACK_AUTH_UNP UNPBlob;
    ///<b>TRUE</b> if the credential information is stored in the <b>AuthBlob</b> member, and the <b>UNPBlob</b> member
    ///should be ignored. <b>FALSE</b> if it is stored in the <b>UNPBlob</b> member, and the <b>AuthBlob</b> member
    ///should be ignored.
    BOOL bAuthBlobValid;
    ///<b>TRUE</b> if the credential information was written to the credential manager, or <b>FALSE</b> otherwise.
    BOOL bSave;
}

// Functions

///Creates a secure connection to a WebDAV server or to a remote file or directory on a WebDAV server.
///Params:
///    ConnectionHandle = A pointer to a variable that receives the connection handle.
///    RemoteName = A pointer to a <b>null</b>-terminated Unicode string that contains the path to the remote file or directory. This
///                 string must begin with the "https://" prefix.
///    UserName = A pointer to a <b>null</b>-terminated Unicode string that contains the user name to be used for the connection.
///               This parameter is optional and can be <b>NULL</b>.
///    Password = A pointer to a <b>null</b>-terminated Unicode string that contains the password to be used for the connection.
///               This parameter is optional and can be <b>NULL</b>.
///    ClientCert = A pointer to a buffer that contains the client certificate to be used for the connection. The certificate must be
///                 in a serialized form.
///    CertSize = Size, in bytes, of the client certificate.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a system
///    error code.
///    
@DllImport("NETAPI32")
uint DavAddConnection(HANDLE* ConnectionHandle, const(wchar)* RemoteName, const(wchar)* UserName, 
                      const(wchar)* Password, char* ClientCert, uint CertSize);

///Closes a connection that was created by using the DavAddConnection function.
///Params:
///    ConnectionHandle = A handle to an open connection that was created by using the DavAddConnection function.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a system
///    error code.
///    
@DllImport("NETAPI32")
uint DavDeleteConnection(HANDLE ConnectionHandle);

///Converts the specified HTTP path to an equivalent UNC path.
///Params:
///    Url = A pointer to a <b>null</b>-terminated Unicode string that contains the HTTP path. This string can be in any of
///          the following formats, where <i>server</i> is the server name and <i>path</i> is the path to a remote file or
///          directory on the server: <ul> <li>http://<i>server</i>/<i>path</i></li> <li>http://<i>server</i></li>
///          <li>\\http://<i>server</i>/<i>path</i></li> <li>\\http://<i>server</i></li>
///          <li>https://<i>server</i>/<i>path</i></li> <li>https://<i>server</i></li>
///          <li>\\https://<i>server</i>/<i>path</i></li> <li>\\https://<i>server</i></li> <li>&
///    UncPath = A pointer to a caller-allocated buffer that receives the UNC path as a <b>null</b>-terminated Unicode string.
///    lpSize = A pointer to a variable that on input specifies the maximum size, in Unicode characters, of the buffer that the
///             <i>UncPath</i> parameter points to. If the function succeeds, on output the variable receives the number of
///             characters that were copied into the buffer, including the terminating <b>NULL</b> character. If the function
///             fails with ERROR_INSUFFICIENT_BUFFER, on output the variable receives the number of characters needed to store
///             the UNC path, including the terminating <b>NULL</b> character.
@DllImport("NETAPI32")
uint DavGetUNCFromHTTPPath(const(wchar)* Url, const(wchar)* UncPath, uint* lpSize);

///Converts the specified UNC path to an equivalent HTTP path.
///Params:
///    UncPath = A pointer to a <b>null</b>-terminated Unicode string that contains the UNC path. This path must be in the
///              following format: &
///    Url = A pointer to a caller-allocated buffer that receives the HTTP path as a <b>null</b>-terminated Unicode string.
///    lpSize = A pointer to a variable that on input specifies the maximum size, in Unicode characters, of the buffer that the
///             <i>HttpPath</i> parameter points to. If the function succeeds, on output the variable receives the number of
///             characters that were copied into the buffer. If the function fails with ERROR_INSUFFICIENT_BUFFER, on output the
///             variable receives the number of characters needed to store the HTTP path, including the "http://" or "https://"
///             prefix and the terminating <b>NULL</b> character.
@DllImport("NETAPI32")
uint DavGetHTTPFromUNCPath(const(wchar)* UncPath, const(wchar)* Url, uint* lpSize);

///Returns the file lock owner for a file that is locked on a WebDAV server.
///Params:
///    FileName = A pointer to a <b>null</b>-terminated Unicode string that contains the name of a locked file on the WebDAV
///               server. This string must be in one of the following formats: <ul> <li>&
///    LockOwnerName = A pointer to a caller-allocated buffer that receives the name of the owner of the file lock. This parameter is
///                    optional and can be <b>NULL</b>. If it is <b>NULL</b>, the <i>LockOwnerNameLengthInBytes</i> parameter must point
///                    to zero on input.
///    LockOwnerNameLengthInBytes = A pointer to a variable that on input specifies the maximum size, in Unicode characters, of the buffer that the
///                                 <i>LockOwnerName</i> parameter points to. If the function succeeds, on output the variable receives the number of
///                                 characters that were copied into the buffer. If the function fails with ERROR_INSUFFICIENT_BUFFER, on output the
///                                 variable receives the number of characters needed to store the lock owner name, including the terminating
///                                 <b>NULL</b> character.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a system
///    error code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer that
///    the <i>LockOwnerName</i> parameter points to was not large enough to store the lock owner name. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more parameter
///    values were not valid. For example, this error code is returned if the <i>FileName</i> parameter is a <b>null</b>
///    pointer. </td> </tr> </table>
///    
@DllImport("davclnt")
uint DavGetTheLockOwnerOfTheFile(const(wchar)* FileName, const(wchar)* LockOwnerName, 
                                 uint* LockOwnerNameLengthInBytes);

///Retrieves the extended error code information that the WebDAV server returned for the previous failed I/O operation.
///Params:
///    hFile = A handle to an open file for which the previous I/O operation has failed. If the previous operation is a failed
///            create operation, in which case there is no open file handle, specify INVALID_HANDLE_VALUE for this parameter.
///    ExtError = Pointer to a variable that receives the extended error code.
///    ExtErrorString = Pointer to a buffer that receives the extended error information as a null-terminated Unicode string.
///    cChSize = A pointer to a variable that on input specifies the size, in Unicode characters, of the buffer that the
///              <i>ExtErrorString</i> parameter points to. This value must be at least 1024 characters. If the function succeeds,
///              on output the variable receives the number of characters that are actually copied into the buffer. If the
///              function fails with ERROR_INSUFFICIENT_BUFFER, the variable receives 1024, but no characters are copied into the
///              <i>ExtErrorString</i> buffer.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a system
///    error code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more
///    parameter values were not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt>
///    </dl> </td> <td width="60%"> The value that the <i>cChSize</i> parameter points to was less than 1024. </td>
///    </tr> </table>
///    
@DllImport("NETAPI32")
uint DavGetExtendedError(HANDLE hFile, uint* ExtError, const(wchar)* ExtErrorString, uint* cChSize);

///Flushes the data from the local version of a remote file to the WebDAV server.
///Params:
///    hFile = A handle to an open file on a WebDAV server. The file handle must have the GENERIC_WRITE access right. For more
///            information, see File Security and Access Rights.
///Returns:
///    If the function succeeds, or if <i>hFile</i> is a handle to an encrypted file, the return value is ERROR_SUCCESS.
///    If the function fails, the return value is a system error code.
///    
@DllImport("NETAPI32")
uint DavFlushFile(HANDLE hFile);

///Invalidates the contents of the local cache for a remote file on a WebDAV server.
///Params:
///    URLName = A pointer to a Unicode string that contains the name of a remote file on a WebDAV server. This name can be an
///              HTTP path name (URL) or a UNC path name.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a system
///    error code.
///    
@DllImport("davclnt")
uint DavInvalidateCache(const(wchar)* URLName);

///Closes all connections to a WebDAV server or a remote file or directory on a WebDAV server.
///Params:
///    lpName = Pointer to a null-terminated Unicode string that contains the name of the remote file or server. This string must
///             be in one of the following formats: <ul> <li>http://<i>server</i>/<i>path</i></li> <li>&
///    fForce = A Boolean value that specifies whether the connection should be closed if there are open files. Set this
///             parameter to <b>FALSE</b> if the connection should be closed only if there are no open files. Set this parameter
///             to <b>TRUE</b> if the connection should be closed even if there are open files.
@DllImport("davclnt")
uint DavCancelConnectionsToServer(const(wchar)* lpName, BOOL fForce);

///Registers an application-defined callback function that the WebDAV client can use to prompt the user for credentials.
///Params:
///    CallBack = A pointer to a function of type PFNDAVAUTHCALLBACK.
///    Version = This parameter is reserved for future use.
///Returns:
///    If the function succeeds, the return value is an opaque handle. Note that <b>OPAQUE_HANDLE</b> is defined to be a
///    <b>DWORD</b> value.
///    
@DllImport("davclnt")
uint DavRegisterAuthCallback(PFNDAVAUTHCALLBACK CallBack, uint Version);

///Unregisters a registered callback function that the WebDAV client uses to prompt the user for credentials.
///Params:
///    hCallback = The opaque handle that was returned by the DavRegisterAuthCallback function.
@DllImport("davclnt")
void DavUnregisterAuthCallback(uint hCallback);


