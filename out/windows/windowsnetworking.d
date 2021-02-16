module windows.windowsnetworking;

public import windows.core;
public import windows.security : NETCONNECTINFOSTRUCT, NETRESOURCEA, NETRESOURCEW;
public import windows.systemservices : BOOL, HANDLE;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Structs


alias NetEnumHandle = ptrdiff_t;

struct CONNECTDLGSTRUCTA
{
    uint          cbStructure;
    HWND          hwndOwner;
    NETRESOURCEA* lpConnRes;
    uint          dwFlags;
    uint          dwDevNum;
}

struct CONNECTDLGSTRUCTW
{
    uint          cbStructure;
    HWND          hwndOwner;
    NETRESOURCEW* lpConnRes;
    uint          dwFlags;
    uint          dwDevNum;
}

struct DISCDLGSTRUCTA
{
    uint         cbStructure;
    HWND         hwndOwner;
    const(char)* lpLocalName;
    const(char)* lpRemoteName;
    uint         dwFlags;
}

struct DISCDLGSTRUCTW
{
    uint          cbStructure;
    HWND          hwndOwner;
    const(wchar)* lpLocalName;
    const(wchar)* lpRemoteName;
    uint          dwFlags;
}

struct NETINFOSTRUCT
{
    uint   cbStructure;
    uint   dwProviderVersion;
    uint   dwStatus;
    uint   dwCharacteristics;
    size_t dwHandle;
    ushort wNetType;
    uint   dwPrinters;
    uint   dwDrives;
}

// Functions

@DllImport("MPR")
uint WNetAddConnectionA(const(char)* lpRemoteName, const(char)* lpPassword, const(char)* lpLocalName);

@DllImport("MPR")
uint WNetAddConnectionW(const(wchar)* lpRemoteName, const(wchar)* lpPassword, const(wchar)* lpLocalName);

@DllImport("MPR")
uint WNetAddConnection2A(NETRESOURCEA* lpNetResource, const(char)* lpPassword, const(char)* lpUserName, 
                         uint dwFlags);

@DllImport("MPR")
uint WNetAddConnection2W(NETRESOURCEW* lpNetResource, const(wchar)* lpPassword, const(wchar)* lpUserName, 
                         uint dwFlags);

@DllImport("MPR")
uint WNetAddConnection3A(HWND hwndOwner, NETRESOURCEA* lpNetResource, const(char)* lpPassword, 
                         const(char)* lpUserName, uint dwFlags);

@DllImport("MPR")
uint WNetAddConnection3W(HWND hwndOwner, NETRESOURCEW* lpNetResource, const(wchar)* lpPassword, 
                         const(wchar)* lpUserName, uint dwFlags);

@DllImport("MPR")
uint WNetAddConnection4A(HWND hwndOwner, NETRESOURCEA* lpNetResource, char* pAuthBuffer, uint cbAuthBuffer, 
                         uint dwFlags, char* lpUseOptions, uint cbUseOptions);

@DllImport("MPR")
uint WNetAddConnection4W(HWND hwndOwner, NETRESOURCEW* lpNetResource, char* pAuthBuffer, uint cbAuthBuffer, 
                         uint dwFlags, char* lpUseOptions, uint cbUseOptions);

@DllImport("MPR")
uint WNetCancelConnectionA(const(char)* lpName, BOOL fForce);

@DllImport("MPR")
uint WNetCancelConnectionW(const(wchar)* lpName, BOOL fForce);

@DllImport("MPR")
uint WNetCancelConnection2A(const(char)* lpName, uint dwFlags, BOOL fForce);

@DllImport("MPR")
uint WNetCancelConnection2W(const(wchar)* lpName, uint dwFlags, BOOL fForce);

@DllImport("MPR")
uint WNetGetConnectionA(const(char)* lpLocalName, const(char)* lpRemoteName, uint* lpnLength);

@DllImport("MPR")
uint WNetGetConnectionW(const(wchar)* lpLocalName, const(wchar)* lpRemoteName, uint* lpnLength);

@DllImport("MPR")
uint WNetUseConnectionA(HWND hwndOwner, NETRESOURCEA* lpNetResource, const(char)* lpPassword, 
                        const(char)* lpUserId, uint dwFlags, const(char)* lpAccessName, uint* lpBufferSize, 
                        uint* lpResult);

@DllImport("MPR")
uint WNetUseConnectionW(HWND hwndOwner, NETRESOURCEW* lpNetResource, const(wchar)* lpPassword, 
                        const(wchar)* lpUserId, uint dwFlags, const(wchar)* lpAccessName, uint* lpBufferSize, 
                        uint* lpResult);

@DllImport("MPR")
uint WNetUseConnection4A(HWND hwndOwner, NETRESOURCEA* lpNetResource, char* pAuthBuffer, uint cbAuthBuffer, 
                         uint dwFlags, char* lpUseOptions, uint cbUseOptions, const(char)* lpAccessName, 
                         uint* lpBufferSize, uint* lpResult);

@DllImport("MPR")
uint WNetUseConnection4W(HWND hwndOwner, NETRESOURCEW* lpNetResource, char* pAuthBuffer, uint cbAuthBuffer, 
                         uint dwFlags, char* lpUseOptions, uint cbUseOptions, const(wchar)* lpAccessName, 
                         uint* lpBufferSize, uint* lpResult);

@DllImport("MPR")
uint WNetConnectionDialog(HWND hwnd, uint dwType);

@DllImport("MPR")
uint WNetDisconnectDialog(HWND hwnd, uint dwType);

@DllImport("MPR")
uint WNetConnectionDialog1A(CONNECTDLGSTRUCTA* lpConnDlgStruct);

@DllImport("MPR")
uint WNetConnectionDialog1W(CONNECTDLGSTRUCTW* lpConnDlgStruct);

@DllImport("MPR")
uint WNetDisconnectDialog1A(DISCDLGSTRUCTA* lpConnDlgStruct);

@DllImport("MPR")
uint WNetDisconnectDialog1W(DISCDLGSTRUCTW* lpConnDlgStruct);

@DllImport("MPR")
uint WNetOpenEnumA(uint dwScope, uint dwType, uint dwUsage, NETRESOURCEA* lpNetResource, NetEnumHandle* lphEnum);

@DllImport("MPR")
uint WNetOpenEnumW(uint dwScope, uint dwType, uint dwUsage, NETRESOURCEW* lpNetResource, NetEnumHandle* lphEnum);

@DllImport("MPR")
uint WNetEnumResourceA(HANDLE hEnum, uint* lpcCount, char* lpBuffer, uint* lpBufferSize);

@DllImport("MPR")
uint WNetEnumResourceW(HANDLE hEnum, uint* lpcCount, char* lpBuffer, uint* lpBufferSize);

@DllImport("MPR")
uint WNetCloseEnum(HANDLE hEnum);

@DllImport("MPR")
uint WNetGetResourceParentA(NETRESOURCEA* lpNetResource, char* lpBuffer, uint* lpcbBuffer);

@DllImport("MPR")
uint WNetGetResourceParentW(NETRESOURCEW* lpNetResource, char* lpBuffer, uint* lpcbBuffer);

@DllImport("MPR")
uint WNetGetResourceInformationA(NETRESOURCEA* lpNetResource, char* lpBuffer, uint* lpcbBuffer, byte** lplpSystem);

@DllImport("MPR")
uint WNetGetResourceInformationW(NETRESOURCEW* lpNetResource, char* lpBuffer, uint* lpcbBuffer, 
                                 ushort** lplpSystem);

@DllImport("MPR")
uint WNetGetUniversalNameA(const(char)* lpLocalPath, uint dwInfoLevel, char* lpBuffer, uint* lpBufferSize);

@DllImport("MPR")
uint WNetGetUniversalNameW(const(wchar)* lpLocalPath, uint dwInfoLevel, char* lpBuffer, uint* lpBufferSize);

@DllImport("MPR")
uint WNetGetUserA(const(char)* lpName, const(char)* lpUserName, uint* lpnLength);

@DllImport("MPR")
uint WNetGetUserW(const(wchar)* lpName, const(wchar)* lpUserName, uint* lpnLength);

@DllImport("MPR")
uint WNetGetProviderNameA(uint dwNetType, const(char)* lpProviderName, uint* lpBufferSize);

@DllImport("MPR")
uint WNetGetProviderNameW(uint dwNetType, const(wchar)* lpProviderName, uint* lpBufferSize);

@DllImport("MPR")
uint WNetGetNetworkInformationA(const(char)* lpProvider, NETINFOSTRUCT* lpNetInfoStruct);

@DllImport("MPR")
uint WNetGetNetworkInformationW(const(wchar)* lpProvider, NETINFOSTRUCT* lpNetInfoStruct);

@DllImport("MPR")
uint WNetGetLastErrorA(uint* lpError, const(char)* lpErrorBuf, uint nErrorBufSize, const(char)* lpNameBuf, 
                       uint nNameBufSize);

@DllImport("MPR")
uint WNetGetLastErrorW(uint* lpError, const(wchar)* lpErrorBuf, uint nErrorBufSize, const(wchar)* lpNameBuf, 
                       uint nNameBufSize);

@DllImport("MPR")
uint MultinetGetConnectionPerformanceA(NETRESOURCEA* lpNetResource, NETCONNECTINFOSTRUCT* lpNetConnectInfoStruct);

@DllImport("MPR")
uint MultinetGetConnectionPerformanceW(NETRESOURCEW* lpNetResource, NETCONNECTINFOSTRUCT* lpNetConnectInfoStruct);


