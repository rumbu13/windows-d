module windows.webdav;

public import windows.systemservices;

extern(Windows):

struct DAV_CALLBACK_AUTH_BLOB
{
    void* pBuffer;
    uint ulSize;
    uint ulType;
}

struct DAV_CALLBACK_AUTH_UNP
{
    const(wchar)* pszUserName;
    uint ulUserNameLength;
    const(wchar)* pszPassword;
    uint ulPasswordLength;
}

struct DAV_CALLBACK_CRED
{
    DAV_CALLBACK_AUTH_BLOB AuthBlob;
    DAV_CALLBACK_AUTH_UNP UNPBlob;
    BOOL bAuthBlobValid;
    BOOL bSave;
}

enum AUTHNEXTSTEP
{
    DefaultBehavior = 0,
    RetryRequest = 1,
    CancelRequest = 2,
}

alias PFNDAVAUTHCALLBACK_FREECRED = extern(Windows) uint function(void* pbuffer);
alias PFNDAVAUTHCALLBACK = extern(Windows) uint function(const(wchar)* lpwzServerName, const(wchar)* lpwzRemoteName, uint dwAuthScheme, uint dwFlags, DAV_CALLBACK_CRED* pCallbackCred, AUTHNEXTSTEP* NextStep, PFNDAVAUTHCALLBACK_FREECRED* pFreeCred);
@DllImport("NETAPI32.dll")
uint DavAddConnection(HANDLE* ConnectionHandle, const(wchar)* RemoteName, const(wchar)* UserName, const(wchar)* Password, char* ClientCert, uint CertSize);

@DllImport("NETAPI32.dll")
uint DavDeleteConnection(HANDLE ConnectionHandle);

@DllImport("NETAPI32.dll")
uint DavGetUNCFromHTTPPath(const(wchar)* Url, const(wchar)* UncPath, uint* lpSize);

@DllImport("NETAPI32.dll")
uint DavGetHTTPFromUNCPath(const(wchar)* UncPath, const(wchar)* Url, uint* lpSize);

@DllImport("davclnt.dll")
uint DavGetTheLockOwnerOfTheFile(const(wchar)* FileName, const(wchar)* LockOwnerName, uint* LockOwnerNameLengthInBytes);

@DllImport("NETAPI32.dll")
uint DavGetExtendedError(HANDLE hFile, uint* ExtError, const(wchar)* ExtErrorString, uint* cChSize);

@DllImport("NETAPI32.dll")
uint DavFlushFile(HANDLE hFile);

@DllImport("davclnt.dll")
uint DavInvalidateCache(const(wchar)* URLName);

@DllImport("davclnt.dll")
uint DavCancelConnectionsToServer(const(wchar)* lpName, BOOL fForce);

@DllImport("davclnt.dll")
uint DavRegisterAuthCallback(PFNDAVAUTHCALLBACK CallBack, uint Version);

@DllImport("davclnt.dll")
void DavUnregisterAuthCallback(uint hCallback);

