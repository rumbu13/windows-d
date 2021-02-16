module windows.webdav;

public import windows.core;
public import windows.systemservices : BOOL, HANDLE;

extern(Windows):


// Enums


enum : int
{
    DefaultBehavior = 0x00000000,
    RetryRequest    = 0x00000001,
    CancelRequest   = 0x00000002,
}
alias AUTHNEXTSTEP = int;

// Callbacks

alias PFNDAVAUTHCALLBACK_FREECRED = uint function(void* pbuffer);
alias PFNDAVAUTHCALLBACK = uint function(const(wchar)* lpwzServerName, const(wchar)* lpwzRemoteName, 
                                         uint dwAuthScheme, uint dwFlags, DAV_CALLBACK_CRED* pCallbackCred, 
                                         AUTHNEXTSTEP* NextStep, PFNDAVAUTHCALLBACK_FREECRED* pFreeCred);

// Structs


struct DAV_CALLBACK_AUTH_BLOB
{
    void* pBuffer;
    uint  ulSize;
    uint  ulType;
}

struct DAV_CALLBACK_AUTH_UNP
{
    const(wchar)* pszUserName;
    uint          ulUserNameLength;
    const(wchar)* pszPassword;
    uint          ulPasswordLength;
}

struct DAV_CALLBACK_CRED
{
    DAV_CALLBACK_AUTH_BLOB AuthBlob;
    DAV_CALLBACK_AUTH_UNP UNPBlob;
    BOOL bAuthBlobValid;
    BOOL bSave;
}

// Functions

@DllImport("NETAPI32")
uint DavAddConnection(HANDLE* ConnectionHandle, const(wchar)* RemoteName, const(wchar)* UserName, 
                      const(wchar)* Password, char* ClientCert, uint CertSize);

@DllImport("NETAPI32")
uint DavDeleteConnection(HANDLE ConnectionHandle);

@DllImport("NETAPI32")
uint DavGetUNCFromHTTPPath(const(wchar)* Url, const(wchar)* UncPath, uint* lpSize);

@DllImport("NETAPI32")
uint DavGetHTTPFromUNCPath(const(wchar)* UncPath, const(wchar)* Url, uint* lpSize);

@DllImport("davclnt")
uint DavGetTheLockOwnerOfTheFile(const(wchar)* FileName, const(wchar)* LockOwnerName, 
                                 uint* LockOwnerNameLengthInBytes);

@DllImport("NETAPI32")
uint DavGetExtendedError(HANDLE hFile, uint* ExtError, const(wchar)* ExtErrorString, uint* cChSize);

@DllImport("NETAPI32")
uint DavFlushFile(HANDLE hFile);

@DllImport("davclnt")
uint DavInvalidateCache(const(wchar)* URLName);

@DllImport("davclnt")
uint DavCancelConnectionsToServer(const(wchar)* lpName, BOOL fForce);

@DllImport("davclnt")
uint DavRegisterAuthCallback(PFNDAVAUTHCALLBACK CallBack, uint Version);

@DllImport("davclnt")
void DavUnregisterAuthCallback(uint hCallback);


